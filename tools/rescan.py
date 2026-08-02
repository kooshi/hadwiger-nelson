#!/usr/bin/env python3
"""The M17 hunt: sweep every pivot of constructed candidates for a confined five-colour fan.

UNTRUSTED, like everything in `tools/`. A CONFINED verdict here is a *triage* result — it becomes
a claim only through the kernel (LRAT certificate, `Fan.of_unsat`); a `separated` verdict is a
tool observation the write-up reports as such. A bug here can cost a theorem and can never buy one.

## Why every pivot, and why growth only

M15's identity makes fan *existence* free in any union of two 4-refuting copies: deleting any
vertex leaves a copy intact, so every vertex carries a five-colour fan and only *confinement* (all
partners in one distance class) is in question. And confinement is monotone the useful way round —
`not_fan_of_subset` in `Proofs/HadwigerNelson/FanMono.lean`: a separating colouring restricts to
every sub-candidate, so deletion can never create a confined fan. The hunt therefore only grows:
`double` (spindle a copy about a pivot at a class — every member moves exactly one unit),
`translate`+`union` (glue at maximal overlap), `orbit` (close under a symmetry group).

## The sweep, and its discipline

One proper colouring separates a class at a pivot whenever the whole class misses the pivot's
colour — so a single pool of models serves *every* pivot of a candidate (measured: all 3,158
pivots of a doubled de Grey graph in 309 s, ~1.2 calls/pivot warm). The bare graph is solved
first: a candidate that is 5-UNSAT outright would read "confined" at every class, so that answer
gets its own verdict (`bare-UNSAT`, triage never claim). M16's triage carries over unchanged: a
budget-cut solve is DEFERRED, logged, never folded into either answer; any deferral downgrades
the candidate to NO VERDICT; every line self-audits its category sum.

## The ledger

Every candidate examined appends one JSONL record to `tools/hunt_ledger.jsonl` — recipe included,
so every candidate is independently re-derivable (`--rederive` re-interprets and byte-compares).
The ledger is the "searched X" artifact the write-up quotes. Verdicts: `separated`, `CONFINED`,
`NO VERDICT`, `bare-UNSAT`.

    python3 tools/rescan.py --self-test
    python3 tools/rescan.py --known-hit-full          # the 667 s / 25-fan gate control
    python3 tools/rescan.py --hunt H1 --jobs 8
    python3 tools/rescan.py --candidate '{"op":"base","name":"heule510"}'
"""

from __future__ import annotations

import argparse
import json
import sys
import time
from collections import Counter
from dataclasses import dataclass, field as dc_field
from fractions import Fraction
from multiprocessing import Pool
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import construct as C  # noqa: E402
from coloring import base_clauses  # noqa: E402
from field import add, neg, spindle_available, sub  # noqa: E402
from forcer import _solve  # noqa: E402
from narrow import Sweep, classes_at, colour_of, is_rational, sweep_pivot  # noqa: E402

TOOLS = Path(__file__).resolve().parent
LEDGER = TOOLS / "hunt_ledger.jsonl"


# ------------------------------------------------------------------ recipes

def recipe_key(recipe: dict) -> str:
    """Canonical serialization — the ledger's resume key. Sorted keys, no whitespace, so the
    same tree always prints the same bytes (serialize∘parse∘serialize is the identity)."""
    return json.dumps(recipe, sort_keys=True, separators=(",", ":"))


def _load_base(name: str) -> C.Config:
    if name == "degrey_seed":
        return C.degrey_seed()
    path = TOOLS / f"{name}.json"
    if not path.exists():
        raise ValueError(f"unknown base configuration '{name}': no tools/{name}.json "
                         f"and it is not 'degrey_seed'")
    d = json.load(open(path))
    return C.Config([(list(c[0]), list(c[1])) for c in d["coords"]], d["denom"])


def _index_of_key(cfg: C.Config, key) -> int:
    want = (tuple(key[0]), tuple(key[1]))
    for i in range(len(cfg)):
        if cfg.key(i) == want:
            return i
    raise ValueError(f"recipe names a pivot that is not a point of this {len(cfg)}-point "
                     f"configuration: {key}")


def interpret(recipe: dict) -> C.Config:
    """Recipe tree → point set. Five constructors, all deduplicating by construction; every
    precondition failure is `construct.py`'s own, refused by name."""
    op = recipe.get("op")
    if op == "base":
        return _load_base(recipe["name"])
    if op == "double":
        cfg = interpret(recipe["of"])
        p = _index_of_key(cfg, recipe["pivot"])
        r2 = Fraction(recipe["r2"])
        cl = classes_at([(tuple(a), tuple(b)) for a, b in cfg.pts], p)
        for kk, Q in cl.items():
            if is_rational(kk) and Fraction(kk[0], cfg.denom ** 2) == r2:
                return C.spindle(cfg, p, Q[0])
        raise ValueError(f"recipe asks to double at r²={r2}, but the pivot has no class at "
                         f"that squared distance")
    if op == "translate":
        cfg = interpret(recipe["of"])
        dx, dy = recipe["vec"]
        return C.Config([(add(p[0], list(dx)), add(p[1], list(dy))) for p in cfg.pts],
                        cfg.denom).dedup()
    if op == "orbit":
        if recipe["group"] != "hex12":
            raise ValueError(f"unknown motion group '{recipe['group']}' — only hex12 is named")
        return C.orbit(interpret(recipe["of"]), C.hex12())
    if op == "union":
        return C.union(interpret(recipe["a"]), interpret(recipe["b"]))
    raise ValueError(f"unknown recipe op '{op}' in {recipe_key(recipe)[:120]}")


# ------------------------------------------------------------------ the candidate sweep

@dataclass
class CandidateSweep:
    """One candidate's complete answer. The verdict is a property of the counts and the bare
    status, never a field anybody sets."""
    name: str
    recipe: dict
    n: int
    n_edges: int
    k: int
    budget: float | None
    bare: str
    pivots: int = 0
    n_classes: int = 0
    pool_rejected: int = 0
    separated: int = 0
    confined: list = dc_field(default_factory=list)   # (pivot, r2-str|None, width)
    deferred: list = dc_field(default_factory=list)   # (pivot, r2-str|None, width, cut)
    calls: int = 0
    elapsed: float = 0.0
    resisting: Counter = dc_field(default_factory=Counter)
    pool_size: int = 0

    def verdict(self) -> str:
        if self.bare == "unsat":
            return "bare-UNSAT"
        if self.bare == "unknown" or self.deferred:
            return "NO VERDICT"
        if self.confined:
            return "CONFINED"
        return "separated"

    def line(self) -> str:
        cats = self.pool_rejected + self.separated + len(self.confined) + len(self.deferred)
        audit = "" if cats == self.n_classes else \
            f"  ** CATEGORY LEAK: {cats} != {self.n_classes} classes — tool bug **"
        v = self.verdict()
        tail = {"separated": "no confined fan at any pivot",
                "CONFINED": "** FAN CONFINED — the narrowing target exists **",
                "NO VERDICT": f"NO VERDICT: budget cut {len(self.deferred)} solve(s); "
                              f"re-run deferred at full budget first",
                "bare-UNSAT": "bare graph UNSAT at budget — TRIAGE for the χ≥6 pipeline; "
                              "an untrusted solver result, not a claim"}[v]
        return (f"{self.name}: {self.n} pts {self.n_edges} edges | {self.pivots} pivots, "
                f"{self.n_classes} classes = {self.pool_rejected} pool + {self.separated} "
                f"separated + {len(self.confined)} confined + {len(self.deferred)} DEFERRED | "
                f"{self.calls} calls {self.elapsed:.0f}s | {tail}{audit}")

    def record(self) -> dict:
        return {"name": self.name, "recipe": self.recipe, "n": self.n, "edges": self.n_edges,
                "k": self.k, "budget": self.budget, "bare": self.bare, "pivots": self.pivots,
                "classes": self.n_classes, "pool_rejected": self.pool_rejected,
                "separated": self.separated, "confined": self.confined,
                "deferred": self.deferred, "calls": self.calls,
                "elapsed": round(self.elapsed, 1),
                "resisting": {str(k2): v for k2, v in self.resisting.most_common()},
                "verdict": self.verdict()}


def _r2_of(kk: tuple, denom: int):
    return str(Fraction(kk[0], denom * denom)) if is_rational(kk) else None


def sweep_candidate(name: str, recipe: dict, cfg: C.Config, k: int = 5,
                    budget: float | None = 300.0, solve=None) -> CandidateSweep:
    """Every pivot, every class, one shared pool. The bare graph is solved first — see module
    doc — and duplicate points are refused before anything is believed."""
    coords = [(tuple(a), tuple(b)) for a, b in cfg.pts]
    n = len(coords)
    seen: dict[tuple, int] = {}
    for i, key in enumerate(coords):
        if key in seen:
            raise ValueError(f"candidate '{name}' has a duplicated plane point: indices "
                             f"{seen[key]} and {i} name the same coordinates — a distance-0 "
                             f"partner would poison every class it joins")
        seen[key] = i
    E = cfg.edges()
    do_solve = solve if solve is not None else _solve

    t0 = time.time()
    st, model = do_solve(base_clauses(n, E, k), k * n, budget)
    cs = CandidateSweep(name=name, recipe=recipe, n=n, n_edges=len(E), k=k, budget=budget,
                        bare=st)
    if st != "sat":
        cs.elapsed = time.time() - t0
        return cs
    colours = {v: colour_of(model, v, k) for v in range(n)}
    assert all(colours[a] != colours[b] for a, b in E if a != b), \
        "bare-graph model is improper on the candidate's own edges — encoding bug"
    pool = [colours]
    cs.calls = 1

    for p in range(n):
        sw: Sweep = sweep_pivot(n, E, coords, p, k, budget, solve=solve, pool=pool)
        cs.pivots += 1
        cs.n_classes += sw.n_classes
        cs.pool_rejected += sw.pool_rejected
        cs.separated += len(sw.separated)
        cs.calls += sw.calls
        for kk, stc in sw.called:
            cs.resisting[_r2_of(kk, cfg.denom) or "irrational"] += 1
        for kk, Q in sw.confined:
            cs.confined.append((p, _r2_of(kk, cfg.denom), len(Q)))
        for kk, Q, cut in sw.deferred:
            cs.deferred.append((p, _r2_of(kk, cfg.denom), len(Q), round(cut, 1)))
    cs.pool_size = len(pool)
    cs.elapsed = time.time() - t0
    return cs


# ------------------------------------------------------------------ the ledger

def ledger_read(path: Path = LEDGER) -> dict[str, dict]:
    """Records by canonical recipe key. A corrupt line is refused by number, never skipped."""
    out: dict[str, dict] = {}
    if not path.exists():
        return out
    for i, line in enumerate(open(path), 1):
        if not line.strip():
            continue
        try:
            rec = json.loads(line)
        except json.JSONDecodeError as ex:
            raise SystemExit(f"{path}:{i}: corrupt ledger line ({ex}); fix or remove it — "
                             f"a silently skipped record would erase a searched candidate")
        out[recipe_key(rec["recipe"])] = rec
    return out


def ledger_append(rec: dict, path: Path = LEDGER) -> None:
    with open(path, "a") as f:
        f.write(json.dumps(rec, sort_keys=True) + "\n")


# ------------------------------------------------------------------ hunt families

def _key_of(cfg: C.Config, idx: int) -> list:
    a, b = cfg.key(idx)
    return [list(a), list(b)]


def _spindleable_classes(cfg: C.Config, p: int) -> list[tuple[Fraction, int]]:
    """(r², width) of every spindle-able class at `p`, widest first."""
    cl = classes_at([(tuple(a), tuple(b)) for a, b in cfg.pts], p)
    out = []
    for kk, Q in cl.items():
        if is_rational(kk):
            r2 = Fraction(kk[0], cfg.denom ** 2)
            if r2 >= Fraction(1, 4) and spindle_available(r2):
                out.append((r2, len(Q)))
    return sorted(out, key=lambda t: -t[1])


def _top_overlap_vecs(cfg: C.Config, top: int) -> list[tuple]:
    """The `top` translation vectors coinciding the most points with the untranslated copy."""
    cnt: Counter = Counter()
    for i in range(len(cfg)):
        xi, yi = cfg.pts[i]
        for j in range(len(cfg)):
            if i != j:
                cnt[(tuple(sub(list(cfg.pts[j][0]), list(xi))),
                     tuple(sub(list(cfg.pts[j][1]), list(yi))))] += 1
    return [vec for vec, _ in cnt.most_common(top)]


def family(which: str) -> list[tuple[str, dict]]:
    """The named hunt families as (name, recipe) lists — H1–H4 statically enumerable, H5 read
    from the ledger (see `family_h5`)."""
    out: list[tuple[str, dict]] = []
    if which == "H1":
        dg = _load_base("degrey_cert")
        for p in [630, 633, 1420, 1423]:
            for r2, w in _spindleable_classes(dg, p):
                out.append((f"H1-dg{p}x{r2}",
                            {"op": "double", "of": {"op": "base", "name": "degrey_cert"},
                             "pivot": _key_of(dg, p), "r2": str(r2)}))
    elif which == "H2":
        for base in ["heule510", "heule553"]:
            cfg = _load_base(base)
            for r2, w in _spindleable_classes(cfg, 0):
                out.append((f"H2-{base}x{r2}",
                            {"op": "double", "of": {"op": "base", "name": base},
                             "pivot": _key_of(cfg, 0), "r2": str(r2)}))
    elif which == "H3":
        for base in ["heule510", "heule553", "degrey_cert"]:
            cfg = _load_base(base)
            for vi, vec in enumerate(_top_overlap_vecs(cfg, 6)):
                out.append((f"H3-{base}t{vi}",
                            {"op": "union", "a": {"op": "base", "name": base},
                             "b": {"op": "translate", "of": {"op": "base", "name": base},
                                   "vec": [list(vec[0]), list(vec[1])]}}))
    elif which == "H4":
        for base in ["heule510", "heule553"]:
            out.append((f"H4-orbit-{base}",
                        {"op": "orbit", "of": {"op": "base", "name": base}, "group": "hex12"}))
        # re-centred orbits: translate a handful of highest-degree vertices to the origin first
        cfg = _load_base("heule510")
        deg: Counter = Counter()
        for a, b in cfg.edges():
            deg[a] += 1
            deg[b] += 1
        for v, _ in deg.most_common(3):
            key = cfg.key(v)
            vec = [list(neg(list(key[0]))), list(neg(list(key[1])))]
            out.append((f"H4-orbit-h510v{v}",
                        {"op": "orbit", "group": "hex12",
                         "of": {"op": "translate", "of": {"op": "base", "name": "heule510"},
                                "vec": vec}}))
    else:
        raise ValueError(f"unknown family '{which}' — H1, H2, H3, H4 are enumerable here; "
                         f"H5 derives from the ledger via family_h5()")
    return out


def family_h5(led: dict[str, dict]) -> list[tuple[str, dict]]:
    """Second generation, budget six: re-double the sharpest resisting spindle-able classes of
    the H1 ledger's most-resisting candidates, at the same pivot."""
    scored = []
    for key, rec in led.items():
        if not rec["name"].startswith("H1-") or rec["verdict"] != "separated":
            continue
        res = rec.get("resisting", {})
        for r2s, cnt in res.items():
            if r2s == "irrational":
                continue
            r2 = Fraction(r2s)
            if r2 >= Fraction(1, 4) and spindle_available(r2):
                scored.append((cnt, rec, r2s))
    scored.sort(key=lambda t: -t[0])
    out = []
    for cnt, rec, r2s in scored[:6]:
        out.append((f"H5-{rec['name']}x{r2s}",
                    {"op": "double", "of": rec["recipe"], "pivot": rec["recipe"]["pivot"],
                     "r2": r2s}))
    return out


def _run_one(args_tuple):
    name, recipe, k, budget = args_tuple
    try:
        cfg = interpret(recipe)
        cs = sweep_candidate(name, recipe, cfg, k, budget)
        return cs.record(), cs.line()
    except Exception as ex:  # a candidate that cannot build is a ledger fact, not a crash
        return ({"name": name, "recipe": recipe, "error": str(ex), "verdict": "BUILD ERROR"},
                f"{name}: BUILD ERROR — {ex}")


def hunt(families: list[str], k: int, budget: float | None, jobs: int,
         ledger: Path = LEDGER) -> None:
    led = ledger_read(ledger)
    todo: list[tuple[str, dict]] = []
    for fam in families:
        todo += family_h5(led) if fam == "H5" else family(fam)
    fresh = [(nm, rc, k, budget) for nm, rc in todo if recipe_key(rc) not in led]
    print(f"hunt: {len(todo)} candidates in {families}, {len(todo) - len(fresh)} already in "
          f"ledger, {len(fresh)} to sweep, {jobs} workers", flush=True)
    if not fresh:
        return
    with Pool(jobs) as pool_:
        for rec, line in pool_.imap_unordered(_run_one, fresh):
            ledger_append(rec, ledger)
            print(line, flush=True)


# ------------------------------------------------------------------ controls

def self_test() -> None:
    """The fast tier: every verdict word driven to its trigger, every guard watched refusing."""
    # a tiny genuine sweep: the Moser spindle at 4 colours is separated everywhere (it is
    # vertex-critical, so no vertex carries a 4-colour fan at all)
    spindle = C.spindle(C.rhombus(), pivot=2, target=3)
    cs = sweep_candidate("spindle", {"op": "test"}, spindle, k=4, budget=60.0)
    assert cs.verdict() == "separated" and not cs.confined, cs.line()
    assert cs.pool_rejected + cs.separated == cs.n_classes

    # the known hit, single pivot (the 667 s all-pivots version is --known-hit-full): de Grey's
    # 397-point configuration at four colours confines exactly r² = 4 at the origin
    cfg = C.orbit(C.degrey_seed(), C.hex12())
    coords = [(tuple(a), tuple(b)) for a, b in cfg.pts]
    E = cfg.edges()
    origin = C.index_of(cfg, Fraction(0), Fraction(0))
    sw = sweep_pivot(len(cfg), E, coords, origin, 4)
    assert len(sw.confined) == 1 and len(sw.confined[0][1]) == 6, "known hit lost"

    # bare-UNSAT: an always-unsat oracle must yield the triage verdict, never "confined"
    cs2 = sweep_candidate("oracle-unsat", {"op": "test"}, spindle, k=4,
                          solve=lambda *_: ("unsat", None))
    assert cs2.verdict() == "bare-UNSAT" and "not a claim" in cs2.line()
    assert not cs2.confined, "an unsat bare graph must not be read as confinement"

    # never-answering oracle: NO VERDICT, and the words refuse to conclude
    cs3 = sweep_candidate("oracle-unknown", {"op": "test"}, spindle, k=4,
                          solve=lambda *_: ("unknown", None))
    assert cs3.verdict() == "NO VERDICT" and "no confined fan" not in cs3.line()

    # injected confinement: the CONFINED path is exercised without a 2-hour UNSAT — the bare
    # graph answers honestly, exactly one class call answers unsat
    state = {"calls": 0}

    def inject(clauses, nvars, budget):
        state["calls"] += 1
        return _solve(clauses, nvars, budget) if state["calls"] == 1 else ("unsat", None)

    cs4 = sweep_candidate("inject-confined", {"op": "test"}, spindle, k=4, solve=inject)
    assert cs4.verdict() == "CONFINED" and cs4.confined and "CONFINED" in cs4.line()

    # the category audit goes loud when a count is dropped on purpose
    cs.pool_rejected -= 1
    assert "CATEGORY LEAK" in cs.line()
    cs.pool_rejected += 1

    # the duplicate-point guard refuses by name
    dup = C.Config(spindle.pts + [spindle.pts[0]], spindle.denom)
    try:
        sweep_candidate("dup", {"op": "test"}, dup, k=4)
        raise SystemExit("SELF-TEST FAILED — a duplicated point should have been refused")
    except ValueError as ex:
        assert "duplicated plane point" in str(ex)

    # recipes: canonical key is a serialize∘parse fixpoint, and interpretation is deterministic
    r = {"op": "double", "of": {"op": "base", "name": "heule510"},
         "pivot": _key_of(_load_base("heule510"), 0), "r2": "1/3"}
    assert recipe_key(json.loads(recipe_key(r))) == recipe_key(r)
    a, b = interpret(r), interpret(r)
    assert [p for p in a.pts] == [p for p in b.pts] and a.denom == b.denom

    # a recipe that cannot build is refused by name
    for bad, msg in [({"op": "warp"}, "unknown recipe op"),
                     ({"op": "base", "name": "atlantis"}, "unknown base configuration"),
                     ({"op": "orbit", "of": {"op": "base", "name": "heule510"},
                       "group": "octo"}, "unknown motion group")]:
        try:
            interpret(bad)
            raise SystemExit(f"SELF-TEST FAILED — {bad} should have been refused")
        except ValueError as ex:
            assert msg in str(ex), f"refusal lost its name: {ex}"

    print("rescan.py self-test OK")


def known_hit_full() -> None:
    """The gate control (667 s measured): the all-pivots sweep of de Grey's 397-point
    configuration at four colours must find **exactly 25 confined fans — 13 at r² = 4 and 12 at
    r² = 4/9** (measured 2026-08-02, `plans/M17-constructing-narrow-fans.md` § 2.6), the origin's
    among them. A rescan that cannot re-find all of de Grey's four-colour narrow fans is not
    credible hunting five-colour ones."""
    cfg = C.orbit(C.degrey_seed(), C.hex12())
    cs = sweep_candidate("known-hit-full",
                         {"op": "orbit", "of": {"op": "base", "name": "degrey_seed"},
                          "group": "hex12"}, cfg, k=4, budget=1200.0)
    print(cs.line())
    got = Counter(r2 for _, r2, _ in cs.confined)
    want = Counter({"4": 13, "4/9": 12})
    ok = (cs.verdict() == "CONFINED" and got == want
          and any(p == C.index_of(cfg, Fraction(0), Fraction(0)) for p, _, _ in cs.confined))
    print(f"expected 13× r²=4 + 12× r²=4/9 incl. the origin; got {dict(got)} — "
          f"{'CONTROL PASSES' if ok else 'CONTROL FAILS'}")
    if not ok:
        raise SystemExit(1)


# ------------------------------------------------------------------ main

def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--known-hit-full", action="store_true")
    ap.add_argument("--hunt", nargs="+", metavar="FAMILY",
                    help="families to run: H1 H2 H3 H4 H5, or 'all'")
    ap.add_argument("--candidate", help="one recipe JSON to sweep")
    ap.add_argument("--rederive", action="store_true",
                    help="re-interpret every ledger recipe and re-verify its size")
    ap.add_argument("--colours", type=int, default=5)
    ap.add_argument("--budget", type=float, default=300.0)
    ap.add_argument("--jobs", type=int, default=8)
    ap.add_argument("--ledger", type=Path, default=LEDGER)
    args = ap.parse_args()

    if args.self_test:
        self_test()
    elif args.known_hit_full:
        known_hit_full()
    elif args.candidate:
        recipe = json.loads(args.candidate)
        cs = sweep_candidate(recipe_key(recipe)[:60], recipe, interpret(recipe),
                             args.colours, args.budget)
        ledger_append(cs.record(), args.ledger)
        print(cs.line())
    elif args.rederive:
        led = ledger_read(args.ledger)
        bad = 0
        for key, rec in led.items():
            if "error" in rec:
                continue
            cfg = interpret(rec["recipe"])
            if len(cfg) != rec["n"]:
                print(f"REDERIVE MISMATCH: {rec['name']} rebuilt to {len(cfg)} pts, "
                      f"ledger says {rec['n']}")
                bad += 1
        print(f"rederived {len(led)} recipes, {bad} mismatches")
        if bad:
            raise SystemExit(1)
    elif args.hunt:
        fams = ["H1", "H2", "H3", "H4", "H5"] if args.hunt == ["all"] else args.hunt
        hunt(fams, args.colours, args.budget, args.jobs, args.ledger)
    else:
        ap.error("nothing to do — try --self-test, --hunt, --candidate, or --rederive")


if __name__ == "__main__":
    main()
