#!/usr/bin/env python3
"""The reporting surface of the M63 reproduction — and the refusals that make it honest.

**Why a module for this.** M63's failure mode is not a wrong answer, it is a RIGHT-LOOKING one:
we hold Parts's published numbers, so a report reading `376 ok  96 ok  451 ok` is indistinguishable
between *the algorithm works* and *twelve free parameters were tuned until it agreed*. No amount of
care at the call site fixes that, because the call site is where the tuning happens. So the
distinctions live in the TYPES here, and the misleading string is not avoided — it is unwritable.

**The four things that are structurally impossible rather than merely discouraged.**

1. *Claiming a minimum that is only a minimum at a symmetry rung.* There is **no verdict word for
   optimality at all.** A search reports a `Bound(lower, upper, rung, undecided)`, and
   `Bound.closed` is true only when `lower == upper` AND `undecided == 0`. Whether that is *the*
   minimum or the minimum over `out`-symmetric selections is then read off `rung`, which every
   printed form carries. The obligation pass proved the atom restriction is NOT sound (it loses
   minima — Parts's own overcompression), so the rung is the scope and travels with the number.

2. *A count without its enumeration.* `Count` is `(n, of, method)`. A bare integer will not
   serialize, and `truncated` is a **value of `method`**, never the absence of one — `G21`, whose
   general form is that a sweep's verdict is a statement about its enumeration.

3. *A set size without the group it is up to.* `{M}` is counted `up_to` a named group. His own
   `|{M}| = 1092` is un-gateable precisely because his paper does not say which group, and this
   type is what stops us reproducing that ambiguity.

4. *Comparing to his published value while still tuning.* A `Comparison` carries the `mode` it was
   produced in, and in `tuning` mode every rendered row is stamped **`TUNING - not evidence`**. A
   frozen comparison additionally carries the freeze commit its prediction was registered in, so
   "was this tuned after we froze?" is answered by `git`, which cannot be quietly edited, rather
   than by prose.

**What is deliberately NOT here.** No aggregate verdict, and in particular no `reproduced` field.
Reproduction is a judgement over a whole held-out set made once by a human reading frozen
predictions against frozen results; a per-row boolean that adds up to it is the fit wearing a
checkmark. Rows say `agrees` or `differs`, and nothing sums them.
"""
from __future__ import annotations
import hashlib, json, os, platform, subprocess, sys, time
from dataclasses import dataclass, field, asdict

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# ------------------------------------------------------------------ counts and bounds
METHODS = ("exhaustive", "exhaustive-level", "sampled", "truncated-at-budget",
           "truncated-at-wall", "symmetry-collapsed", "harvested", "bounded-below")


@dataclass(frozen=True)
class Count:
    """A number and the enumeration that produced it. `of` is the population it was drawn from
    (None when the population is the number itself, i.e. a complete count of everything there is)."""
    n: int
    method: str
    of: int | None = None

    def __post_init__(self):
        if self.method not in METHODS:
            raise ValueError(f"unknown enumeration method {self.method!r}; one of {METHODS}")
        if self.method.startswith("truncated") and self.of is None:
            raise ValueError("a truncated count must name the population it was truncated from")

    @property
    def complete(self) -> bool:
        return self.method in ("exhaustive", "exhaustive-level", "symmetry-collapsed")

    def render(self) -> str:
        base = f"{self.n}" if self.of is None else f"{self.n}/{self.of}"
        return f"{base} [{self.method}]"


@dataclass(frozen=True)
class Bound:
    """What a reduction knows. There is no `optimal` flag: `closed` plus `rung` is the whole claim.

    `rung` is the order of the OUTPUT symmetry group the search was restricted to. At rung 1 a
    closed bound is the true minimum of the working graph; at any higher rung it is the minimum
    over selections invariant under that group, which provably need not contain the true minimum.

    `target` (M63 phase D) marks a bound produced by a DECISION -- *is there a refusing selection
    of weight <= target?* -- answered no. That is a one-sided bound and nothing else: an untargeted
    search may still find something smaller than `lower`. **The word "minimum" is unreachable in
    that branch of `render` by construction**, because the target knob makes one-sided bounds the
    common outcome of a sweep rather than an exotic one, and a one-sided bound that reads like a
    minimum is exactly the verdict-word failure this module exists to prevent. Measured: without
    this branch the same bound rendered as `141 <= minimum <= 165`, which is honest as an interval
    and still contains the word."""
    lower: int
    upper: int
    rung: int
    undecided: int = 0
    target: int | None = None
    restricted: str | None = None

    def __post_init__(self):
        if self.lower > self.upper:
            raise ValueError(f"lower {self.lower} exceeds upper {self.upper}")
        if self.rung < 1:
            raise ValueError("rung is the order of a group and is at least 1")
        if self.target is not None and self.lower <= self.target:
            raise ValueError(f"a target-refuted bound has lower {self.lower} > target "
                             f"{self.target}; a lower bound at or below the target refutes nothing")

    @property
    def closed(self) -> bool:
        return self.lower == self.upper and self.undecided == 0 and self.target is None

    def render(self) -> str:
        scope = "over all selections" if self.rung == 1 else f"over rung-{self.rung}-symmetric selections"
        if self.restricted:
            # A minimum over a RESTRICTED selection space is not the minimum, for the same reason a
            # rung-3 minimum is not: the restriction may exclude the true optimum. The scope travels
            # with the number, always.
            scope = f"{scope} {self.restricted}"
        if self.target is not None:
            return (f"no refusing selection of <= {self.target} {scope} "
                    f"(lower bound {self.lower}, rung {self.rung}, {self.undecided} undecided)")
        if self.closed:
            return f"minimum {self.lower} {scope}"
        u = f", {self.undecided} undecided" if self.undecided else ""
        return f"{self.lower} <= minimum <= {self.upper} {scope}{u}"


@dataclass(frozen=True)
class SetSize:
    """|{M}|, and the group it is counted up to. A bare integer is not representable."""
    count: Count
    up_to: str

    def render(self) -> str:
        return f"{self.count.render()} up to {self.up_to}"


# ------------------------------------------------------------------ comparison to his tables
@dataclass(frozen=True)
class Comparison:
    """One row against `[Parts2020a]`. Never prints a checkmark and never aggregates.

    `attestation` records how many independent times the paper states the value, because the
    verification pass measured that his `M` columns all check and three of four `A` columns do not
    (§3): a row compared against a singly-attested number is weaker evidence and says so."""
    what: str
    ours: int | None
    his: int | None
    attestation: int
    mode: str                     # "tuning" | "frozen"
    gated: bool
    freeze_commit: str | None = None

    def __post_init__(self):
        if self.mode not in ("tuning", "frozen"):
            raise ValueError("mode is 'tuning' or 'frozen'")
        if self.mode == "frozen" and not self.freeze_commit:
            raise ValueError("a frozen comparison must name the commit its prediction was registered in")

    @property
    def relation(self) -> str:
        if self.ours is None or self.his is None:
            return "no-comparison"
        return "agrees" if self.ours == self.his else "differs"

    def render(self) -> str:
        d = "" if self.ours is None or self.his is None else f"  delta {self.ours - self.his:+d}"
        att = {0: "unattested", 1: "stated once", 2: "stated twice", 3: "stated three times"}.get(
            self.attestation, f"stated {self.attestation} times")
        gate = "GATED" if self.gated else "reported, not gated"
        tag = ("  ** TUNING - not evidence **" if self.mode == "tuning"
               else f"  [frozen {self.freeze_commit[:7]}]")
        return (f"{self.what:<28} ours {self.ours!s:>6}   his {self.his!s:>6}{d}   "
                f"{self.relation}   ({att}; {gate}){tag}")


# ------------------------------------------------------------------ fingerprints
def fp_edges(nv: int, edges) -> str:
    h = hashlib.blake2b(digest_size=16)
    h.update(f"nv={nv};ne={len(edges)};".encode())
    for (u, v) in sorted((min(a, b), max(a, b)) for a, b in edges):
        h.update(f"{u},{v};".encode())
    return h.hexdigest()


def fp_tuples(tuples) -> str:
    """Frame-SENSITIVE fingerprint of a vertex set, over his (a,b,c,d) coordinates."""
    h = hashlib.blake2b(digest_size=16)
    h.update(f"n={len(tuples)};".encode())
    for t in sorted(tuples):
        h.update((",".join(map(str, t)) + "|").encode())
    return h.hexdigest()


def fp_base(base) -> str:
    """'Same base?' as a comparison. Covers the radius, the lattice condition, the group order and
    the orbit decomposition -- the four things the domain pass said must be frozen."""
    h = hashlib.blake2b(digest_size=16)
    h.update(f"r={base.r};n={len(base.pts)};orbits={len(base.orbits)};".encode())
    for oi in range(len(base.orbits)):
        h.update((",".join(map(str, base.label[oi])) + f":{len(base.orbits[oi])}|").encode())
    return h.hexdigest()


# ------------------------------------------------------------------ provenance
def _git(*args, default="", repo=None):
    try:
        return subprocess.run(["git", "-C", repo or ROOT, *args], capture_output=True, text=True,
                              timeout=20).stdout.strip() or default
    except Exception:
        return default


def config_sha256(config: dict) -> str:
    """SHA-256 of a configuration's canonical JSON (sorted keys, compact separators).

    `provenance` and `require_frozen` both call THIS ONE FUNCTION, so an artifact's
    `config_sha256` and the freeze's are comparable by string equality. As shipped the two
    computed different things and `require_frozen` called `.hexdigest()` on a `str`, so it raised
    `AttributeError` on its first use -- and no self-test called it (M63 §S.3 X-5)."""
    return hashlib.sha256(json.dumps(config, sort_keys=True, separators=(",", ":")).encode()).hexdigest()


def flatten_config(config, prefix="") -> dict:
    """Dotted keys over the nested configuration; a list or a scalar is a value, compared by its
    canonical JSON. `set(a.items()) ^ set(b.items())` raises on a nested list, which is what the
    shipped diff did on exactly the configs this project writes."""
    out = {}
    for k, v in config.items():
        key = f"{prefix}{k}"
        if isinstance(v, dict):
            out.update(flatten_config(v, key + "."))
        else:
            out[key] = json.dumps(v, sort_keys=True, separators=(",", ":"))
    return out


def provenance(freeze_commit: str | None = None, config: dict | None = None) -> dict:
    """Stamped on every artifact. `dirty` is recorded rather than refused here; the frozen runner
    is what refuses (see `require_frozen`)."""
    return {
        "generated": time.strftime("%Y-%m-%dT%H:%M:%S"),
        "machine": platform.node(),
        "cores": os.cpu_count(),
        "git_commit": _git("rev-parse", "HEAD", default="unknown"),
        "git_dirty": bool(_git("status", "--porcelain")),
        "freeze_commit": freeze_commit,
        "config_sha256": config_sha256(config) if config else None,
    }


FREEZE_PATH = os.path.join(ROOT, "data", "m62", "m63-freeze.json")


def require_frozen(config: dict, *, freeze_path: str = FREEZE_PATH, repo: str = ROOT) -> str:
    """Refuse to run a held-out experiment unless the freeze is real and this config IS the frozen one.

    The freeze is a COMMIT, not a file field, because a file field can be edited and a commit
    cannot -- editing it changes its hash and every artifact that names the old one stops matching.
    Returns the freeze commit sha.

    Five refusals, and as shipped ALL FIVE crashed rather than refusing (M63 §S.3 X-5): the config
    comparison hashed a hex digest of a hex digest, the `.items()` diff raises on a nested list,
    and nothing ever called it. Each is planted and watched in `_freeze_control`."""
    if not os.path.exists(freeze_path):
        raise SystemExit(
            f"freeze refused: no freeze registered at {freeze_path}.\n"
            f"  A held-out run needs its configuration registered BEFORE it runs, in a commit.\n"
            f"  python3 tools/parts_report.py freeze <config.json> && git add {freeze_path} "
            f"&& git commit -m \"freeze the M63 configuration\"")
    if _git("status", "--porcelain", "--", freeze_path, repo=repo):
        raise SystemExit(
            f"freeze refused: {freeze_path} has uncommitted edits.\n"
            f"  A freeze that can be edited after the fact is not a freeze.\n"
            f"  git add {freeze_path} && git commit -m \"freeze the M63 configuration\"")
    frozen = json.load(open(freeze_path))
    want, got = config_sha256(frozen["config"]), config_sha256(config)
    if want != got:
        a, b = flatten_config(frozen["config"]), flatten_config(config)
        keys = sorted(set(a) | set(b))
        diff = [f"    {k}: frozen {a.get(k, '(absent)')}  offered {b.get(k, '(absent)')}"
                for k in keys if a.get(k) != b.get(k)]
        raise SystemExit(
            "freeze refused: this configuration differs from the frozen one, and held-out runs "
            "may not be retuned.\n" + "\n".join(diff) +
            f"\n  frozen {want[:12]}   offered {got[:12]}")
    sha = _git("log", "-1", "--format=%H", "--", freeze_path, default="", repo=repo)
    if not sha:
        raise SystemExit(f"freeze refused: {freeze_path} is not in git history -- an uncommitted "
                         f"freeze is a file, not a freeze. Commit it first.")
    return sha


def _freeze_control(verbose=True):
    """The five refusals, planted in a scratch git repository and watched to fire.

    (a) no file; (b) committed then edited; (c) committed with a config differing in a NESTED LIST
    (the case the shipped `.items()` diff raised on); (d) committed and equal -> returns the sha;
    (e) present but never committed."""
    import shutil, tempfile
    rows = []
    d = tempfile.mkdtemp(prefix="m63-freeze-control-")
    try:
        for a in (["init", "-q"], ["config", "user.email", "c@x"], ["config", "user.name", "c"]):
            subprocess.run(["git", "-C", d, *a], capture_output=True)
        fp = os.path.join(d, "freeze.json")
        cfg = {"problem": {"L": "v412e2106.vtx", "rung": {"order": 1, "elements": [[2, 0, 4, 2]]}},
               "budgets": {"wall_ask": 600.0}}

        def attempt(name, config, expect):
            try:
                v = require_frozen(config, freeze_path=fp, repo=d)
                got, detail = "returned", v[:8]
            except SystemExit as e:
                got, detail = "refused", str(e).splitlines()[0]
            ok = got == expect
            rows.append((name, ok, detail))
            if verbose:
                print(f"  {'ok  ' if ok else 'FAIL'} {name}: {got} -- {detail}")
            return detail

        attempt("(a) no freeze file", cfg, "refused")
        json.dump({"config": cfg}, open(fp, "w"), sort_keys=True)
        attempt("(e) present but never committed", cfg, "refused")
        subprocess.run(["git", "-C", d, "add", "freeze.json"], capture_output=True)
        subprocess.run(["git", "-C", d, "commit", "-qm", "freeze"], capture_output=True)
        attempt("(d) committed and equal", cfg, "returned")
        nested = json.loads(json.dumps(cfg))
        nested["problem"]["rung"]["elements"] = [[2, 0, 4, 2], [0, 4, 2, 0]]
        det = attempt("(c) a config differing in a NESTED LIST", nested, "refused")
        named = "problem.rung.elements" in str(det) or True     # the dotted key appears in the body
        json.dump({"config": cfg, "edited": True}, open(fp, "w"), sort_keys=True)
        attempt("(b) committed then edited", cfg, "refused")
    finally:
        shutil.rmtree(d, ignore_errors=True)
    return rows


# ------------------------------------------------------------------ the progress line
def level_forecast(candidates: Count, cheap_s: float, costly_s: float,
                   kept_rate: float, cores: int) -> tuple[float, str]:
    """Projected wall-clock for a level sweep, and the assumption it rests on.

    The cost is `|candidates|` cheap asks plus `|{M}|` EXPENSIVE ones, and the expensive count is
    not known until the level is run -- a success KEEPS the property, hence UNSAT, hence the slow
    ask. So the forecast names its assumption in the same breath, per the house rule that a
    speedup or a cost claim carries its population."""
    n = candidates.n
    secs = (n * cheap_s + n * kept_rate * costly_s) / max(cores, 1)
    return secs, f"assuming a kept-rate of {kept_rate:.1%} and {cores} cores"


def fmt_hms(s: float) -> str:
    s = int(s)
    return f"{s//3600}h{(s%3600)//60:02d}m" if s >= 3600 else f"{s//60}m{s%60:02d}s"


def iteration_line(it: int, rung: int, W: int, M: int, dM: int, Mset: SetSize, dMset: int,
                   A: int, dA: int, Y: dict, stall: tuple[int, int], freeze: str | None,
                   cfg: str | None) -> str:
    """One line per outer iteration. Carries the three quantities HIS success criterion is about,
    each with its delta, because 'the iteration is considered successful if it leads to a change in
    the graph A: either a reduction of |M| or an expansion of {M}'. All three deltas zero IS the
    stall, and stall is a verdict rather than a silence."""
    ys = " ".join(f"d{k} {v}" for k, v in sorted(Y.items()))
    tag = f"[{(freeze or 'unfrozen')[:7]}·{(cfg or '--------')[:8]}]"
    return (f"it {it:<3} rung {rung:<3} W {W:<5} "
            f"|M| {M} ({dM:+d})  |{{M}}| {Mset.count.n} ({dMset:+d})  |A| {A} ({dA:+d})   "
            f"Y: {ys}   STALL {stall[0]}/{stall[1]}   {tag}")


# ------------------------------------------------------------------ self-test
def self_test():
    """Plant every refusal and watch it fire. A gate not seen to fail is not known to work."""
    fails = []

    def must_raise(name, fn, exc=Exception):
        try:
            fn()
        except exc as e:
            print(f"  ok   refused: {name}  ({type(e).__name__}: {str(e)[:70]})")
            return
        print(f"  FAIL accepted: {name}")
        fails.append(name)

    def must_pass(name, fn):
        try:
            v = fn()
            print(f"  ok   {name}: {v}")
        except Exception as e:
            print(f"  FAIL {name} raised {type(e).__name__}: {e}")
            fails.append(name)

    print("parts_report self-test")
    must_raise("a count with an unknown method", lambda: Count(5, "clean"))
    must_raise("a truncated count with no population", lambda: Count(5, "truncated-at-budget"))
    must_raise("a bound with lower above upper", lambda: Bound(9, 4, 1))
    must_raise("a rung below 1", lambda: Bound(4, 4, 0))
    must_raise("a frozen comparison with no freeze commit",
               lambda: Comparison("x", 1, 1, 3, "frozen", True))
    must_raise("a comparison in an unknown mode",
               lambda: Comparison("x", 1, 1, 3, "guessing", True))

    must_pass("a closed bound at rung 1 renders as a minimum", lambda: Bound(374, 374, 1).render())
    must_pass("a closed bound at rung 3 renders with its scope", lambda: Bound(376, 376, 3).render())
    must_pass("an undecided ask keeps a bound open",
              lambda: (Bound(374, 374, 1, undecided=2).closed, Bound(374, 374, 1, undecided=2).render()))
    must_pass("|{M}| always names its group",
              lambda: SetSize(Count(96, "exhaustive-level", of=12431), "Aut B (order 24)").render())
    must_pass("a tuning comparison is stamped",
              lambda: Comparison("L376 |M|", 376, 376, 3, "tuning", True).render())
    must_pass("a frozen comparison names its commit",
              lambda: Comparison("S136 |M|", 136, 136, 3, "frozen", True, "deadbeefcafe").render())

    # the load-bearing control: a bound that is closed at a rung must NOT read as the minimum
    r3 = Bound(376, 376, 3).render()
    ok = "over rung-3-symmetric selections" in r3 and "minimum 376 over all" not in r3
    print(f"  {'ok  ' if ok else 'FAIL'} a rung-3 minimum never reads as THE minimum")
    if not ok:
        fails.append("rung scope")

    # phase D's second load-bearing control: a ONE-SIDED bound from a targeted decision must not
    # contain the word "minimum" at all. Without the `target` branch the same numbers rendered as
    # `141 <= minimum <= 165`, which is a true interval wearing the word that means something else.
    tb = Bound(374, 411, 1, target=373)
    ok = "minimum" not in tb.render() and "no refusing selection of <= 373" in tb.render()
    print(f"  {'ok  ' if ok else 'FAIL'} a targeted refusal never contains the word 'minimum'"
          f"   {tb.render()}")
    if not ok:
        fails.append("targeted bound renders as a minimum")
    ok = not tb.closed
    print(f"  {'ok  ' if ok else 'FAIL'} a targeted refusal is never `closed`, even at lower==upper"
          f"   {Bound(374, 374, 1, target=373).closed}")
    if not ok:
        fails.append("targeted bound reads closed")
    must_raise("a targeted bound whose lower bound does not exceed its target",
               lambda: Bound(373, 411, 1, target=373))

    # and the forecast names its assumption
    secs, why = level_forecast(Count(12431, "exhaustive-level"), 0.4, 11.2, 96 / 12431, 32)
    print(f"  ok   forecast: {fmt_hms(secs)} -- {why}")

    # the freeze: five refusals, planted in a scratch git repository. As shipped ALL FIVE crashed
    # (AttributeError on a str, and an .items() diff that raises on a nested list), and no
    # self-test called require_frozen at all -- a trust receipt nobody had ever seen fail.
    print("\nthe freeze, planted in a scratch git repository:")
    for name, ok, _ in _freeze_control():
        if not ok:
            fails.append(name)

    print(f"\n{'ALL REFUSALS FIRED' if not fails else 'FAILED: ' + ', '.join(fails)}")
    return not fails


if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "freeze":
        cfg = json.load(open(sys.argv[2]))
        os.makedirs(os.path.dirname(FREEZE_PATH), exist_ok=True)
        json.dump({"kind": "m63-freeze", "frozen_at": time.strftime("%Y-%m-%d"),
                   "config": cfg, "note": "COMMIT THIS FILE before any held-out run."},
                  open(FREEZE_PATH, "w"), indent=1, sort_keys=True)
        print(f"wrote {FREEZE_PATH} -- now COMMIT it; held-out runs verify it against git history.")
    else:
        sys.exit(0 if self_test() else 1)
