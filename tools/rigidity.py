#!/usr/bin/env python3
"""The colour-space instrument: what EVERY proper k-colouring of a finite graph agrees on.

UNTRUSTED, like everything in `tools/`. A pair this tool calls forced becomes mathematics only
when a later milestone re-derives it in Lean; a bug here can cost a theorem and never buy one.

## What it measures

Three things, per (graph, k):

* **Forced-equal pairs** — {u,v} painted alike by every proper k-colouring. The transmissible
  currency of gadgets: M13's forced pair is the width-one case, and de Grey's 791-point forcer
  is the load-bearing example (its forced pair, spindled, is the 5th colour).
* **Virtual edges** — non-adjacent {u,v} painted DIFFERENTLY by every proper k-colouring. What a
  spindle wants: a virtual edge is an edge the colouring theory already believes in.
* **The colour-space census** — the number of proper k-colourings up to a supplied symmetry group
  and colour permutation, enumerated with blocking clauses under a cap.

## The design (M30 §0b): one lattice, batch violation queries

Every model teaches all pairs at once: vertices grouped by their colour-history signature give the
forced-equal candidates (identical signature ⟺ agreed in every model so far); a per-model sweep of
within-class pairs accumulates `seen_equal`, whose complement is the virtual-edge candidates.
Confirmation is by **batch violation query**: one CNF asks "does any proper colouring violate any
surviving candidate?" (Tseitin selectors, biconditional per colour, so a SAT model genuinely
witnesses the violation it selected). SAT ⟹ a new teaching model that must shrink the candidate
set; UNSAT ⟹ every survivor on that side is confirmed at once. Each call either teaches or closes,
so the loop terminates. Three outcomes throughout — `confirmed` / `unsettled` / `unknown` — and a
timeout is reported as `unknown`, never folded into either answer.

**The vacuity guard**: if the graph has no proper k-colouring at all, every pair is "forced"
vacuously and none of it means anything. The χ-check is the first model draw; UNSAT halts the
instrument with a banner and a distinct exit code rather than reporting vacuous forcings.

    python3 tools/rigidity.py --self-test
    python3 tools/rigidity.py --graph build/m30-forcer791.json --k 4
    python3 tools/rigidity.py --graph build/m30-hexchunk.json --k 4 --sym build/m30-hexsym.json --census 10000
"""

from __future__ import annotations

import argparse
import json
import sys
import time
from itertools import combinations
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from coloring import base_clauses, unvar, var  # noqa: E402
from forcer import _solve  # noqa: E402

VACUOUS_EXIT = 3


# ------------------------------------------------------------------ graphs in and colours out

def load_graph(path: Path) -> tuple[int, list[tuple[int, int]]]:
    """`(n, edges)` from the standard witness shape (`names`/`coords`/`edges`) or bare `n`/`edges`."""
    d = json.load(open(path))
    n = d["n"] if "n" in d else len(d["names"])
    return n, [tuple(e) for e in d["edges"]]


def amo_clauses(n: int, k: int) -> list[list[int]]:
    """At-most-one colour per vertex. `coloring.base_clauses` leaves colour sets free (the
    certificate never needed more); this instrument reads models as functions, so it pins them."""
    return [[-var(v, a, k), -var(v, b, k)]
            for v in range(n) for a in range(k) for b in range(a + 1, k)]


def decode(model: set[int], n: int, k: int) -> list[int]:
    """The colour function of a model (unique per vertex once `amo_clauses` are in the formula)."""
    out = [-1] * n
    for lit in model:
        if lit > 0:
            v, c = unvar(lit, k)
            if v < n:
                out[v] = c
    if any(c < 0 for c in out):
        raise RuntimeError("model leaves a vertex uncoloured — the at-least-one clauses are missing")
    return out


# ------------------------------------------------------------------ the meters (M32)
#
# Coverage and triple compulsions — the k-set instruments the pairwise sweep is structurally
# blind to (G9/G13). Each query is ONE SAT call made palette-WLOG sound by ownership: this
# module builds the whole clause set from (n, edges, k); no API accepts foreign clauses, so
# the palette symmetry the WLOG needs can never be silently broken by a caller.

def coverage_query(n: int, edges, k: int, S, j: int, cap: float | None = None) -> dict:
    """Is there a proper k-colouring with the target set S restricted to colours {0..j−1}?

    Palette-WLOG: "S uses ≤ j colours" ⟺ some global palette permutation puts S inside
    {0..j−1}, so banning colours {j..k−1} on S loses nothing. `sat` ⟹ the target can be
    j-covered; `unsat` at j = k−1 (with j = k sat) ⟹ FANNED: every proper k-colouring puts
    all k colours on S. `unknown` is a cap reading, never a claim."""
    clauses = base_clauses(n, edges, k) + amo_clauses(n, k)
    for v in S:
        for c in range(j, k):
            clauses.append([-var(v, c, k)])
    t0 = time.time()
    status, model = _solve(clauses, n * k, cap)
    row = {"j": j, "outcome": status, "seconds": round(time.time() - t0, 2), "cap": cap}
    if status == "sat":
        colours = decode(model, n, k)
        for (a, b) in edges:
            if colours[a] == colours[b]:
                raise SystemExit("COVERAGE MODEL INVALID: monochromatic edge — solver or "
                                 "decode is wrong")
        used = sorted({colours[v] for v in S})
        if any(c >= j for c in used):
            raise SystemExit("COVERAGE MODEL INVALID: the target wears a banned colour — "
                             "the restriction clauses are wrong")
        row["used_on_target"] = used
    return row


def min_cover(n: int, edges, k: int, S, cap: float | None = None) -> dict:
    """The coverage ladder j = k, k−1, …, 1. The top row j = k IS the vacuity guard (it is the
    unrestricted colourability question), so no fan claim can outrun colourability. min-cover
    is monotone in j; `unknown` rows widen the answer to an honest interval [lo, hi].

    Verdicts: `vacuous` (graph refuses k — no coverage claim follows), `unknown` (the guard
    row capped), `fanned` (lo = hi = k: every k-colouring covers S with all k colours — a
    fresh centre vertex on this circle transitions to colour k+1), `settled` (lo = hi < k),
    `interval` (unknown rows in between)."""
    rows = [coverage_query(n, edges, k, S, k, cap)]
    if rows[0]["outcome"] == "unsat":
        return {"rows": rows, "verdict": "vacuous"}
    if rows[0]["outcome"] == "unknown":
        return {"rows": rows, "verdict": "unknown"}
    for j in range(k - 1, 0, -1):
        rows.append(coverage_query(n, edges, k, S, j, cap))
        if rows[-1]["outcome"] == "unsat":
            break               # monotone: every lower j is unsat too
    sats = [r["j"] for r in rows if r["outcome"] == "sat"]
    unsats = [r["j"] for r in rows if r["outcome"] == "unsat"]
    hi = min(sats)
    lo = (max(unsats) + 1) if unsats else 1
    verdict = "fanned" if lo == hi == k else ("settled" if lo == hi else "interval")
    return {"rows": rows, "lo": lo, "hi": hi, "verdict": verdict}


def triple_query(n: int, edges, k: int, triple, mode: str, cap: float | None = None) -> dict:
    """Can this triple be monochromatic (mode `mono`) / rainbow (mode `rainbow`) in a proper
    k-colouring? Palette-WLOG pins: mono → all three to colour 0; rainbow → colours 0,1,2
    (needs k ≥ 3). `unsat` at mono = COMPELLED non-mono (M20's genre — a compulsion that may
    act through no edge); `sat` = moot (a colouring realizes it). The caller must have seen
    the graph k-colourable first (the χ row or a min_cover guard row) — an unsat here on an
    uncolourable graph would be vacuous."""
    x, y, z = triple
    if mode == "mono":
        pins = [[var(x, 0, k)], [var(y, 0, k)], [var(z, 0, k)]]
    elif mode == "rainbow":
        if k < 3:
            raise SystemExit("TRIPLE QUERY REJECTED: rainbow needs k ≥ 3")
        pins = [[var(x, 0, k)], [var(y, 1, k)], [var(z, 2, k)]]
    else:
        raise SystemExit(f"TRIPLE QUERY REJECTED: unknown mode {mode!r} (mono|rainbow)")
    clauses = base_clauses(n, edges, k) + amo_clauses(n, k) + pins
    t0 = time.time()
    status, model = _solve(clauses, n * k, cap)
    row = {"triple": [x, y, z], "mode": mode, "outcome": status,
           "seconds": round(time.time() - t0, 2), "cap": cap}
    if status == "sat":
        colours = decode(model, n, k)
        for (a, b) in edges:
            if colours[a] == colours[b]:
                raise SystemExit("TRIPLE MODEL INVALID: monochromatic edge — solver or decode "
                                 "is wrong")
        want = [0, 0, 0] if mode == "mono" else [0, 1, 2]
        if [colours[x], colours[y], colours[z]] != want:
            raise SystemExit("TRIPLE MODEL INVALID: the pin does not hold in the model — the "
                             "pin clauses are wrong")
    return row


# ------------------------------------------------------------------ the avoidance instrument (M33)
#
# Class-level compulsion queries — the disjunctive asks the instance meters are structurally
# blind to (G15). ONE semantics: avoid a monochromatic m-tuple; arity is data (an "equal pair"
# IS a mono 2-tuple, and at arity 2 the avoidance clause is literally an edge clause).
# Direction B ("can this instance EVER be realized") is `mono_realizable`, the arity-generic
# sibling of `triple_query(mode=mono)`. The caller (tools/mechanism.py) owns the base-SAT
# guard and computes verdicts through `avoid_verdict` ONLY; these functions own the encodings
# and re-validate every SAT model in-process. Instances are dense index tuples — no geometry.

def _check_instances(instances) -> None:
    for inst in instances:
        if len(inst) < 2 or len(set(inst)) != len(inst):
            raise SystemExit(f"AVOID QUERY REJECTED: malformed instance {tuple(inst)!r} "
                             "(arity ≥ 2, members distinct)")


def _validate_avoiding(colours, edges, instances) -> None:
    for (a, b) in edges:
        if colours[a] == colours[b]:
            raise SystemExit("AVOID MODEL INVALID: monochromatic edge — solver or decode is wrong")
    for inst in instances:
        if len({colours[v] for v in inst}) == 1:
            raise SystemExit("AVOID MODEL INVALID: a class instance is monochromatic — the "
                             "avoidance clauses are wrong")


def class_avoid(n: int, edges, k: int, instances, cap: float | None = None,
                want_model: bool = False) -> dict:
    """Can a proper k-colouring avoid EVERY monochromatic class instance? One clause per
    instance per colour: ¬(every member wears c). `unsat` — WITH the caller's base row sat and
    the class inhabited — is FIRED: every proper k-colouring makes some instance mono; the
    pigeonhole, localized. `sat` models are re-validated (proper AND genuinely avoiding);
    `want_model` returns the validated colouring (the shrink loop's necessity witnesses)."""
    _check_instances(instances)
    clauses = base_clauses(n, edges, k) + amo_clauses(n, k) + _palette_breaking(n, k)
    for inst in instances:
        for c in range(k):
            clauses.append([-var(v, c, k) for v in inst])
    t0 = time.time()
    status, model = _solve(clauses, n * k, cap)
    row = {"encoding": "onehot", "n_instances": len(instances), "outcome": status,
           "seconds": round(time.time() - t0, 2), "cap": cap}
    if status == "sat":
        colours = decode(model, n, k)
        _validate_avoiding(colours, edges, instances)
        if want_model:
            row["colours"] = colours
    return row


def _palette_breaking(n: int, k: int, limit: int = 400) -> list[list[int]]:
    """First-occurrence palette symmetry breaking: vertex v may wear colour c ≥ 1 only if some
    earlier vertex wears c−1. SOUND for palette-invariant properties only (properness and
    mono-avoidance are; colour-NAMED restrictions like coverage_query's are NOT — never add
    this there). Any prefix of the full scheme is still sound (the canonical first-occurrence
    relabeling satisfies every clause), so the emission is truncated at `limit` vertices to
    bound the formula at enriched scales. Without this, an avoidance UNSAT pays the full 4!
    palette factor — measured 300 s+ vs 59 s on the 791 forcer's pairs (M33 controls)."""
    return [[-var(v, c, k)] + [var(u, c - 1, k) for u in range(v)]
            for v in range(1, min(n, limit)) for c in range(1, k)]


def class_avoid_binary(n: int, edges, k: int, instances, cap: float | None = None) -> dict:
    """The decorrelated re-encode (M33 §0g G-3): 2-bit binary colours, k = 4 only — half the
    variables, no at-most-one, different clause shapes, ONE mono-ban generator serving edges
    and instances alike (properness IS mono-banning the edge). Exists so a `fired` verdict
    never rests on a single clause generator; agreement with `class_avoid` is asserted by the
    self-test gadgets and by every onset confirmation."""
    if k != 4:
        raise SystemExit("BINARY RE-ENCODE REJECTED: k = 4 only (2 bits per vertex)")
    _check_instances(instances)

    def bit(v: int, i: int) -> int:
        return v * 2 + i + 1

    clauses: list[list[int]] = []

    def mono_ban(tup) -> None:
        for c in range(4):
            cl = []
            for v in tup:
                cl.append(bit(v, 0) if (c & 1) == 0 else -bit(v, 0))
                cl.append(bit(v, 1) if (c >> 1) == 0 else -bit(v, 1))
            clauses.append(cl)

    for e in edges:
        mono_ban(e)
    for inst in instances:
        mono_ban(inst)
    if n > 0:  # palette pin, sound by transitivity: relabel so vertex 0 wears colour 00
        clauses.append([-bit(0, 0)])
        clauses.append([-bit(0, 1)])
    t0 = time.time()
    status, model = _solve(clauses, n * 2, cap)
    row = {"encoding": "binary-2bit", "n_instances": len(instances), "outcome": status,
           "seconds": round(time.time() - t0, 2), "cap": cap}
    if status == "sat":
        colours = [(1 if bit(v, 0) in model else 0) + 2 * (1 if bit(v, 1) in model else 0)
                   for v in range(n)]
        _validate_avoiding(colours, edges, instances)
    return row


def mono_realizable(n: int, edges, k: int, instance, cap: float | None = None) -> dict:
    """Direction B, arity-generic: pin THIS instance monochromatic (palette-WLOG colour 0) in
    a proper k-colouring. `sat` = realizable, model validated (proper AND the pin holds);
    `unsat` = the instance can NEVER be mono — the class-level impossibility genre (M20's
    `no_mono_outer_triple`). The caller must have seen the graph k-colourable first — an
    unsat on an uncolourable graph would be vacuous."""
    _check_instances([instance])
    clauses = base_clauses(n, edges, k) + amo_clauses(n, k)
    for v in instance:
        clauses.append([var(v, 0, k)])
    t0 = time.time()
    status, model = _solve(clauses, n * k, cap)
    row = {"instance": list(instance), "outcome": status,
           "seconds": round(time.time() - t0, 2), "cap": cap}
    if status == "sat":
        colours = decode(model, n, k)
        for (a, b) in edges:
            if colours[a] == colours[b]:
                raise SystemExit("REALIZE MODEL INVALID: monochromatic edge — solver or decode "
                                 "is wrong")
        if any(colours[v] != 0 for v in instance):
            raise SystemExit("REALIZE MODEL INVALID: the mono pin does not hold — the pin "
                             "clauses are wrong")
    return row


def avoid_verdict(base_outcome: str, avoid_outcome: str | None, n_instances: int) -> str:
    """The ONE place a class verdict is computed (M33 §0f F3): `fired` structurally requires
    the region colourable AND the class inhabited AND the avoidance refused. `empty` is a
    zero-instance region ("nothing to avoid here yet" — never clean); `vacuous` is a region
    that refuses k colours outright (every question moot)."""
    if base_outcome == "unsat":
        return "vacuous"
    if base_outcome == "unknown":
        return "unknown-at-base"
    if n_instances == 0:
        return "empty"
    return {"unsat": "fired", "sat": "clean", "unknown": "unknown"}[avoid_outcome]


# ------------------------------------------------------------------ the pair lattice

class Rigidity:
    """The two-question knowledge state over unordered vertex pairs, updated by whole models.

    Invariant (M13's backbone invariant, generalized from one pivot to all pairs, per side):

        confirmed  ⊆  the true forced set  ⊆  confirmed ∪ candidates ∪ unknown
    """

    def __init__(self, n: int, edges: list[tuple[int, int]], k: int,
                 timeout: float | None = None):
        self.n, self.k = n, k
        self.edges = [tuple(sorted(e)) for e in edges]
        self.adj = set(self.edges)
        self.base = base_clauses(n, self.edges, k) + amo_clauses(n, k)
        self.timeout = timeout
        self.models: list[list[int]] = []
        self.seen_equal: set[int] = set()          # pair id u*n+v (u<v) seen alike in some model
        self.status = "fresh"                      # fresh | vacuous | done | unknown
        self.eq_confirmed: list[tuple[int, int]] = []
        self.eq_unsettled: list[tuple[int, int]] = []
        self.ne_confirmed: list[tuple[int, int]] = []
        self.ne_unsettled: list[tuple[int, int]] = []
        self.calls = 0

    def _pid(self, u: int, v: int) -> int:
        return u * self.n + v if u < v else v * self.n + u

    def observe(self, colours: list[int]) -> None:
        """Fold one proper colouring into the lattice: within-class pairs have been seen equal."""
        self.models.append(colours)
        classes: dict[int, list[int]] = {}
        for v, c in enumerate(colours):
            classes.setdefault(c, []).append(v)
        for members in classes.values():
            for u, v in combinations(members, 2):
                self.seen_equal.add(u * self.n + v)

    def eq_candidates(self) -> list[tuple[int, int]]:
        """Pairs alike in EVERY model so far — vertices grouped by colour-history signature."""
        sig: dict[tuple[int, ...], list[int]] = {}
        for v in range(self.n):
            sig.setdefault(tuple(m[v] for m in self.models), []).append(v)
        return [(u, v) for members in sig.values() if len(members) > 1
                for u, v in combinations(sorted(members), 2)]

    def ne_candidates(self) -> list[tuple[int, int]]:
        """Non-adjacent pairs never yet seen alike (adjacent pairs are distinct by edge, not news)."""
        out = []
        for u in range(self.n):
            for v in range(u + 1, self.n):
                if (u, v) not in self.adj and u * self.n + v not in self.seen_equal:
                    out.append((u, v))
        return out

    # ---- batch violation queries: one call either teaches a new model or closes a side

    def _query(self, cands: list[tuple[int, int]], want: str):
        """SAT: "some proper colouring violates some candidate". `want` names the candidate kind:
        `eq` candidates are violated by a colouring that SEPARATES the pair, `ne` candidates by one
        that UNITES it. Selector s_i is biconditionally tied to the violation so the model's colour
        function genuinely witnesses it."""
        clauses = list(self.base)
        nv = self.k * self.n
        sel = []
        for (u, v) in cands:
            nv += 1
            s = nv
            sel.append(s)
            for c in range(self.k):
                if want == "eq":
                    # s → the pair shares no colour  (they differ as functions)
                    clauses.append([-s, -var(u, c, self.k), -var(v, c, self.k)])
                else:
                    # s → identical colour sets  (they agree as functions)
                    clauses.append([-s, -var(u, c, self.k), var(v, c, self.k)])
                    clauses.append([-s, var(u, c, self.k), -var(v, c, self.k)])
        clauses.append(sel)
        self.calls += 1
        return _solve(clauses, nv, self.timeout)

    def _settle(self, want: str) -> tuple[list, list]:
        """Drive one side to confirmation or honest unknown."""
        while True:
            cands = self.eq_candidates() if want == "eq" else self.ne_candidates()
            if not cands:
                return [], []
            st, model = self._query(cands, want)
            if st == "unsat":
                return cands, []
            if st == "unknown":
                return [], cands
            colours = decode(model, self.n, self.k)
            before = len(cands)
            self.observe(colours)
            after = len(self.eq_candidates() if want == "eq" else self.ne_candidates())
            if after >= before:
                raise RuntimeError(
                    f"a violation model failed to shrink the {want}-candidate set "
                    f"({before} → {after}) — the selector encoding is wrong; halting rather than "
                    f"looping")

    def run(self) -> None:
        st, model = _solve(self.base, self.k * self.n, self.timeout)
        self.calls += 1
        if st == "unsat":
            self.status = "vacuous"
            return
        if st == "unknown":
            self.status = "unknown"
            return
        self.observe(decode(model, self.n, self.k))
        self.eq_confirmed, self.eq_unsettled = self._settle("eq")
        self.ne_confirmed, self.ne_unsettled = self._settle("ne")
        self.status = "done" if not (self.eq_unsettled or self.ne_unsettled) else "unknown"


# ------------------------------------------------------------------ the census up to symmetry

def _canon(colours: list[int], syms: list[list[int]]) -> tuple[int, ...]:
    """Canonical form under (supplied symmetry group) × (colour permutation): the lexicographically
    least first-occurrence-normalized vector over the group. The identity is always included, so an
    empty `syms` means palette-only."""
    best = None
    for g in [list(range(len(colours)))] + syms:
        vec = [colours[g[v]] for v in range(len(colours))]
        names: dict[int, int] = {}
        norm = tuple(names.setdefault(c, len(names)) for c in vec)
        if best is None or norm < best:
            best = norm
    return best


def census(n: int, edges: list[tuple[int, int]], k: int, syms: list[list[int]],
           cap: int, timeout: float | None = None) -> dict:
    """Proper k-colourings up to symmetry × palette, by blocking-clause enumeration.

    Soundness lives in the Python canonical set — blocking clauses only prevent re-finding the
    exact concrete models already seen, so a palette- or symmetry-variant found later deduplicates
    here rather than corrupting the count. Reports `exact: false` when the cap or a timeout cut
    the enumeration short — "> cap" is a result, never trimmed to the cap."""
    clauses = base_clauses(n, edges, k) + amo_clauses(n, k)
    canon: set[tuple[int, ...]] = set()
    calls = 0
    while len(canon) <= cap:
        st, model = _solve(clauses, k * n, timeout)
        calls += 1
        if st == "unsat":
            return {"count": len(canon), "exact": True, "calls": calls}
        if st == "unknown":
            return {"count": len(canon), "exact": False, "why": "timeout", "calls": calls}
        colours = decode(model, n, k)
        canon.add(_canon(colours, syms))
        clauses.append([-var(v, colours[v], k) for v in range(n)])
    return {"count": len(canon), "exact": False, "why": "cap", "calls": calls}


# ------------------------------------------------------------------ reporting

def report(rig: Rigidity, label: str, census_result: dict | None = None) -> dict:
    if rig.status == "vacuous":
        print(f"VACUOUS: {label} has NO proper {rig.k}-colouring — forced-pair analysis is "
              f"meaningless and was NOT run. (A pair in an empty colouring space is 'forced' "
              f"only vacuously.)")
        return {"label": label, "k": rig.k, "status": "vacuous"}
    out = {
        "label": label, "k": rig.k, "status": rig.status,
        "models_drawn": len(rig.models), "sat_calls": rig.calls,
        "forced_equal": {"confirmed": sorted(rig.eq_confirmed),
                         "unsettled": sorted(rig.eq_unsettled)},
        "virtual_edges": {"confirmed": sorted(rig.ne_confirmed),
                          "unsettled": sorted(rig.ne_unsettled)},
        "adjacent_pairs_skipped": len(rig.adj),
    }
    if census_result is not None:
        out["census"] = census_result
    fe, ve = out["forced_equal"], out["virtual_edges"]
    print(f"{label} @ k={rig.k}: {rig.status}; models {len(rig.models)}, calls {rig.calls}; "
          f"forced-equal {len(fe['confirmed'])} confirmed / {len(fe['unsettled'])} unsettled; "
          f"virtual edges {len(ve['confirmed'])} confirmed / {len(ve['unsettled'])} unsettled"
          + (f"; census {census_result['count']}{'' if census_result['exact'] else '+'} "
             f"(exact={census_result['exact']})" if census_result else ""))
    return out


# ------------------------------------------------------------------ the controls (§0 of the plan)

def self_test() -> None:
    """Every discriminating check next to the failure that would fool it. Each control is a gate
    that has been SEEN red: the deleted-edge rhombus is the forced-pair detector's red, the Moser
    spindle at 3 is the vacuity guard's, the path graph pins the violation loop's arithmetic."""
    failures = []

    def expect(got, want, what):
        ok = got == want
        print(f"  {'ok  ' if ok else 'FAIL'} {what}: {got!r}" + ("" if ok else f" (want {want!r})"))
        if not ok:
            failures.append(what)

    # rhombus: two unit triangles glued; far pair (2,3) forced alike at 3 colours
    rh = [(0, 1), (0, 2), (1, 2), (0, 3), (1, 3)]
    r = Rigidity(4, rh, 3)
    r.run()
    expect(r.status, "done", "rhombus settles")
    expect(sorted(r.eq_confirmed), [(2, 3)], "rhombus k=3 forces exactly the far pair")
    expect(r.ne_confirmed, [], "rhombus k=3 has no virtual edge")
    c = census(4, rh, 3, [], 100)
    expect((c["count"], c["exact"]), (1, True), "rhombus k=3 census: one colouring up to palette")

    # the deleted-edge control: loosening the graph must LOSE the forced pair
    r = Rigidity(4, [(0, 1), (1, 2), (0, 3), (1, 3)], 3)
    r.run()
    expect(sorted(r.eq_confirmed), [], "rhombus minus an edge: the forced pair vanishes")

    # the vacuity control: the Moser spindle has no proper 3-colouring
    sp = json.load(open(Path(__file__).resolve().parent / "spindle.json"))
    n_sp = len(sp["names"]) if "names" in sp else sp["n"]
    r = Rigidity(n_sp, [tuple(e) for e in sp["edges"]], 3)
    r.run()
    expect(r.status, "vacuous", "Moser spindle k=3 reports VACUOUS, not forced pairs")

    # the violation loop's arithmetic: P3 forces its endpoints together at 2 colours
    r = Rigidity(3, [(0, 1), (1, 2)], 2)
    r.run()
    expect(sorted(r.eq_confirmed), [(0, 2)], "path A–B–C at k=2 forces the endpoints alike")
    c = census(3, [(0, 1), (1, 2)], 2, [], 100)
    expect((c["count"], c["exact"]), (1, True), "P3 k=2 census: one colouring up to palette")

    # symmetry quotient: the 4-cycle at k=2 has one colouring up to palette; at k=3 the census
    # collapses further under its rotation than without it
    c4 = [(0, 1), (1, 2), (2, 3), (3, 0)]
    rot = [[1, 2, 3, 0], [2, 3, 0, 1], [3, 0, 1, 2]]
    plain = census(4, c4, 3, [], 100)
    quot = census(4, c4, 3, rot, 100)
    expect(plain["exact"] and quot["exact"], True, "C4 censuses complete")
    expect(quot["count"] < plain["count"], True,
           f"C4 k=3: rotation quotient strictly collapses ({plain['count']} → {quot['count']})")

    # virtual-edge detection: K3 minus an edge at k=3... has none; but the 5-cycle at k=2 is
    # vacuous, and the BULL-free check we actually want is the spindle at k=4: its hub pair
    # structure is costly here, so the cheap positive: C5 at k=3 — antipodal-ish pairs are free,
    # no forced structure, and the instrument says so rather than inventing any.
    r = Rigidity(5, [(0, 1), (1, 2), (2, 3), (3, 4), (4, 0)], 3)
    r.run()
    expect((r.status, r.eq_confirmed, r.ne_confirmed), ("done", [], []),
           "C5 k=3: free — no forced pair, no virtual edge")

    # ---- the M32 meters, each control red/green on cue ----

    # fanned positive: C5 at k=3 needs all 3 colours (χ(C5)=3) — the wheel-hub semantics: a hub
    # adjacent to all of C5 would transition to colour 4 (and W5 is indeed 4-chromatic).
    c5 = [(0, 1), (1, 2), (2, 3), (3, 4), (4, 0)]
    mc = min_cover(5, c5, 3, [0, 1, 2, 3, 4])
    expect(mc["verdict"], "fanned", "C5 k=3 whole-set coverage reads FANNED (χ(C5)=3)")

    # fanned negative (the red partner): C4 is bipartite — 2 colours cover it inside k=3
    mc = min_cover(4, c4, 3, [0, 1, 2, 3])
    expect((mc["verdict"], mc["lo"], mc["hi"]), ("settled", 2, 2),
           "C4 k=3 min-cover settles at 2 — not fanned")

    # the free vacuity guard: K4 refuses 3 colours; the ladder must say VACUOUS, never fanned
    k4 = [(a, b) for a in range(4) for b in range(a + 1, 4)]
    mc = min_cover(4, k4, 3, [0, 1, 2, 3])
    expect(mc["verdict"], "vacuous", "K4 k=3 coverage ladder reads VACUOUS (guard row unsat)")

    # ladder arithmetic: P3 at k=2 — the endpoints always share, so {0,2} is 1-coverable
    mc = min_cover(3, [(0, 1), (1, 2)], 2, [0, 2])
    expect((mc["lo"], mc["hi"]), (1, 1), "P3 k=2: endpoint pair min-cover = 1")

    # triple compulsion positive: C4 at k=2, triple (0,2,1) — 0,2 non-adjacent yet the triple
    # can never be mono (1 is adjacent to both): COMPELLED non-mono through a non-edge pair
    tq = triple_query(4, c4, 2, (0, 2, 1), "mono")
    expect(tq["outcome"], "unsat", "C4 k=2 triple (0,2,1) mono is COMPELLED non-mono")

    # triple moot (the red partner): the triangle at k=3 is realized rainbow
    tri = [(0, 1), (0, 2), (1, 2)]
    tq = triple_query(3, tri, 3, (0, 1, 2), "rainbow")
    expect(tq["outcome"], "sat", "triangle k=3 rainbow triple is moot (realized)")

    # rejection path: rainbow at k=2 must refuse loudly, not silently accept
    try:
        triple_query(4, c4, 2, (0, 1, 2), "rainbow")
        expect("no-error", "SystemExit", "rainbow at k=2 rejected")
    except SystemExit as e:
        expect("REJECTED" in str(e) or "rainbow" in str(e), True, "rainbow at k=2 rejected")

    # ---- the M33 avoidance instrument, each control red/green on cue (§0g G-4) ----

    # planted forced-equal: u=3, v=4 both adjacent to the shared K3 {0,1,2} — at k=4 both are
    # forced to the 4th colour, so the mono 2-tuple (3,4) cannot be avoided
    k3 = [(0, 1), (0, 2), (1, 2)]
    forced_eq = k3 + [(3, 0), (3, 1), (3, 2), (4, 0), (4, 1), (4, 2)]
    ca = class_avoid(5, forced_eq, 4, [(3, 4)])
    expect(ca["outcome"], "unsat", "planted forced-equal gadget: avoid-mono (3,4) FIRES")
    ca = class_avoid(5, forced_eq[:-1], 4, [(3, 4)])  # one spoke removed
    expect(ca["outcome"], "sat", "one spoke removed: avoid-mono (3,4) goes clean")
    mr = mono_realizable(5, forced_eq, 4, (3, 4))
    expect(mr["outcome"], "sat", "direction B: the forced pair is (of course) realizable mono")

    # planted mono-triple: u,v,w = 3,4,5 each adjacent to ALL of the shared K3 — all three
    # forced to the 4th colour, a compelled mono triple
    mono_tri = k3 + [(u, w) for u in (3, 4, 5) for w in (0, 1, 2)]
    ca = class_avoid(6, mono_tri, 4, [(3, 4, 5)])
    expect(ca["outcome"], "unsat", "planted mono-triple gadget: avoid-mono (3,4,5) FIRES")
    ca = class_avoid(6, mono_tri[:-1], 4, [(3, 4, 5)])
    expect(ca["outcome"], "sat", "one spoke removed: avoid-mono (3,4,5) goes clean")

    # the binary re-encode must AGREE on all four gadget readings (the decorrelation control)
    for eds, inst, want, what in [(forced_eq, (3, 4), "unsat", "pair fired"),
                                  (forced_eq[:-1], (3, 4), "sat", "pair clean"),
                                  (mono_tri, (3, 4, 5), "unsat", "triple fired"),
                                  (mono_tri[:-1], (3, 4, 5), "sat", "triple clean")]:
        cb = class_avoid_binary(6, eds, 4, [inst])
        expect(cb["outcome"], want, f"binary re-encode agrees: {what}")

    # direction-B trivial-impossibility red: an ADJACENT tuple can never be mono — UNSAT for a
    # reason that is not a compulsion (the enumerator excludes internal edges by geometry;
    # this control documents the trap)
    mr = mono_realizable(5, forced_eq, 4, (0, 1))
    expect(mr["outcome"], "unsat", "direction B on an adjacent pair: UNSAT for the trivial reason")

    # id-mapping shuffle: the forced-equal gadget embedded at scrambled indices among decoys —
    # verdicts must survive the relabeling
    perm = {0: 7, 1: 2, 2: 9, 3: 0, 4: 5}
    shuf = [(perm[a], perm[b]) for (a, b) in forced_eq] + [(1, 3), (3, 8), (1, 8)]
    ca = class_avoid(10, shuf, 4, [(perm[3], perm[4])])
    expect(ca["outcome"], "unsat", "shuffled embedding: the fired verdict survives relabeling")

    # the verdict function: fired needs colourable + inhabited + refused; nothing else may
    expect(avoid_verdict("sat", "unsat", 1), "fired", "verdict: sat base + unsat avoid = FIRED")
    expect(avoid_verdict("sat", "sat", 1), "clean", "verdict: sat/sat = clean")
    expect(avoid_verdict("sat", "sat", 0), "empty", "verdict: zero instances = EMPTY, never clean")
    expect(avoid_verdict("unsat", "unsat", 9), "vacuous", "verdict: base unsat = VACUOUS, never fired")
    expect(avoid_verdict("unknown", "unsat", 9), "unknown-at-base", "verdict: capped base = no claim")
    expect(avoid_verdict("sat", "unknown", 9), "unknown", "verdict: capped avoid = no claim")

    # rejection path: a malformed instance refuses loudly
    try:
        class_avoid(5, forced_eq, 4, [(3, 3)])
        expect("no-error", "SystemExit", "duplicate-member instance rejected")
    except SystemExit as e:
        expect("REJECTED" in str(e), True, "duplicate-member instance rejected")

    print("SELF-TEST:", "ok" if not failures else f"{len(failures)} FAILURES: {failures}")
    if failures:
        sys.exit(1)


# ------------------------------------------------------------------ CLI

def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--graph", type=Path, help="graph JSON (n/edges or names/coords/edges)")
    ap.add_argument("--k", type=int, default=4)
    ap.add_argument("--sym", type=Path, help="JSON list of vertex permutations to quotient by")
    ap.add_argument("--census", type=int, metavar="CAP",
                    help="also enumerate the colour space up to symmetry × palette, capped")
    ap.add_argument("--timeout", type=float, default=600.0, help="per-SAT-call timeout, seconds")
    ap.add_argument("--out", type=Path, help="write the JSON report here")
    ap.add_argument("--coverage", metavar="IDS",
                    help="M32 meter: min-cover ladder for the comma-separated target vertex set")
    ap.add_argument("--triple", metavar="X,Y,Z", help="M32 meter: triple compulsion query")
    ap.add_argument("--mode", default="mono", choices=["mono", "rainbow"])
    ap.add_argument("--self-test", action="store_true", dest="selftest")
    args = ap.parse_args()

    if args.selftest:
        self_test()
        return
    if not args.graph:
        ap.error("--graph or --self-test")

    if args.coverage or args.triple:
        n, edges = load_graph(args.graph)
        if args.coverage:
            S = [int(x) for x in args.coverage.split(",")]
            mc = min_cover(n, edges, args.k, S, args.timeout)
            v = mc["verdict"]
            if v == "vacuous":
                print(f"VACUOUS: the graph itself refuses {args.k} colours — no coverage "
                      f"claim follows")
            elif v == "fanned":
                print(f"FANNED at k={args.k}: every proper colouring covers the target with "
                      f"all {args.k} colours — a centre vertex on this circle transitions to "
                      f"colour {args.k + 1}")
            elif v == "unknown":
                print(f"unknown at cap — NOT a bound, NOT a fan claim")
            else:
                print(f"not fanned: min-cover ∈ [{mc['lo']}, {mc['hi']}] of {args.k}")
            print(json.dumps(mc, indent=1))
        if args.triple:
            t = tuple(int(x) for x in args.triple.split(","))
            tq = triple_query(n, edges, args.k, t, args.mode, args.timeout)
            if tq["outcome"] == "unsat":
                print(f"COMPELLED non-{args.mode} at k={args.k} (M20's genre) — guard: confirm "
                      f"the graph is {args.k}-colourable or this is vacuous")
            elif tq["outcome"] == "sat":
                print("moot: a colouring realizes it")
            else:
                print("unknown at cap — no claim")
            print(json.dumps(tq, indent=1))
        return

    n, edges = load_graph(args.graph)
    syms = [list(p) for p in json.load(open(args.sym))] if args.sym else []
    t0 = time.time()
    rig = Rigidity(n, edges, args.k, timeout=args.timeout)
    rig.run()
    cen = None
    if rig.status != "vacuous" and args.census is not None:
        cen = census(n, edges, args.k, syms, args.census, timeout=args.timeout)
    out = report(rig, args.graph.name, cen)
    out["seconds"] = round(time.time() - t0, 1)
    if args.out:
        args.out.parent.mkdir(parents=True, exist_ok=True)
        json.dump(out, open(args.out, "w"), indent=1)
        print(f"wrote {args.out}")
    if rig.status == "vacuous":
        sys.exit(VACUOUS_EXIT)


if __name__ == "__main__":
    main()
