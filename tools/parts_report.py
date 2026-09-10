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
    over selections invariant under that group, which provably need not contain the true minimum."""
    lower: int
    upper: int
    rung: int
    undecided: int = 0

    def __post_init__(self):
        if self.lower > self.upper:
            raise ValueError(f"lower {self.lower} exceeds upper {self.upper}")
        if self.rung < 1:
            raise ValueError("rung is the order of a group and is at least 1")

    @property
    def closed(self) -> bool:
        return self.lower == self.upper and self.undecided == 0

    def render(self) -> str:
        scope = "over all selections" if self.rung == 1 else f"over rung-{self.rung}-symmetric selections"
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
def _git(*args, default=""):
    try:
        return subprocess.run(["git", "-C", ROOT, *args], capture_output=True, text=True,
                              timeout=20).stdout.strip() or default
    except Exception:
        return default


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
        "config_sha256": (hashlib.sha256(
            json.dumps(config, sort_keys=True).encode()).hexdigest() if config else None),
    }


FREEZE_PATH = os.path.join(ROOT, "data", "m62", "m63-freeze.json")


def require_frozen(config: dict) -> str:
    """Refuse to run a held-out experiment unless the freeze is real and this config IS the frozen one.

    The freeze is a COMMIT, not a file field, because a file field can be edited and a commit
    cannot -- editing it changes its hash and every artifact that names the old one stops matching.
    Returns the freeze commit sha."""
    if not os.path.exists(FREEZE_PATH):
        raise SystemExit(f"no freeze registered: {FREEZE_PATH} does not exist.\n"
                         f"  Register one with `python3 tools/parts_report.py freeze <config.json>` "
                         f"and COMMIT it before running any held-out experiment.")
    if _git("status", "--porcelain", "--", FREEZE_PATH):
        raise SystemExit(f"the freeze file has uncommitted edits -- a freeze that can be edited "
                         f"after the fact is not a freeze. Commit or revert {FREEZE_PATH}.")
    frozen = json.load(open(FREEZE_PATH))
    want = hashlib.sha256(json.dumps(frozen["config"], sort_keys=True).hexdigest().encode()).hexdigest()
    got = hashlib.sha256(json.dumps(config, sort_keys=True).hexdigest().encode()).hexdigest()
    if want != got:
        diff = sorted(set(frozen["config"].items()) ^ set(config.items()))
        raise SystemExit(f"this config differs from the frozen one -- held-out runs may not be "
                         f"retuned. Differing entries: {diff}")
    sha = _git("log", "-1", "--format=%H", "--", FREEZE_PATH, default="")
    if not sha:
        raise SystemExit("the freeze file is not in git history; commit it first.")
    return sha


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

    # and the forecast names its assumption
    secs, why = level_forecast(Count(12431, "exhaustive-level"), 0.4, 11.2, 96 / 12431, 32)
    print(f"  ok   forecast: {fmt_hms(secs)} -- {why}")

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
