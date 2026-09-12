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
ROWS_DIR = os.path.join(ROOT, "data", "m62", "m63-rows")

# Fields that sit inside the frozen config but describe the ROW a run starts from, not the RULE
# it runs. They are excluded from the compared hash and checked against the run's ACTUAL starting
# state instead -- see `require_frozen`.
ROW_DESCRIPTIVE = ("held_out_state", "incumbent_weight", "target")

# Fields §S.5 settled as belonging inside the pin -- `cross_law = collinear(7/8)` and
# `fp_base(Base(2.6))` -- which the 2026-09-11 freeze does NOT carry. They cannot be added to it:
# re-freezing would silently change what the already-scored rows were judged under, which is the
# one thing a freeze exists to prevent. They are pinned PER ROW instead, and a run whose row
# carries no registration has them RECORDED and says so rather than implying a pin.
ROW_PINNED = ("cross_law", "base_fp", "base_r")


def rule_portion(config: dict) -> dict:
    """The frozen configuration minus the fields that describe a row rather than the rule.

    Hash equality over the WHOLE config was the bug: `held_out_state`, `incumbent_weight` and
    `target` are prose and numbers about one starting state, but the runtime incumbent comes from
    the starting RECORD (`parts_rule.run_loop`). So a frozen run on any other row passed
    `require_frozen` by hash equality while its own receipt asserted the wrong starting state."""
    return {k: v for k, v in config.items() if k not in ROW_DESCRIPTIVE}


def row_path(row_id: str, *, rows_dir: str = ROWS_DIR) -> str:
    if not row_id or "/" in row_id or row_id.startswith("."):
        raise SystemExit(f"a row id is one path segment and may not be empty; got {row_id!r}")
    return os.path.join(rows_dir, f"{row_id}.json")


def require_frozen(config: dict, *, row: dict | None = None, freeze_path: str = FREEZE_PATH,
                   rows_dir: str = ROWS_DIR, repo: str = ROOT) -> dict:
    """Refuse to run a held-out experiment unless the freeze is real, this config IS the frozen
    RULE, and the ROW it runs on is registered. Returns a **receipt**.

    The freeze is a COMMIT, not a file field, because a file field can be edited and a commit
    cannot -- editing it changes its hash and every artifact that names the old one stops matching.

    **What a hash can and cannot say.** The frozen config mixes two things: the RULE (what the
    loop does) and a DESCRIPTION of one row (`held_out_state`, `incumbent_weight`, `target`). The
    runtime incumbent comes from the starting record, not from the config, so hash equality over
    the whole thing let a run on a DIFFERENT row pass while its receipt asserted the frozen row's
    starting state -- a receipt asserting a falsehood, which is worse than no receipt because it
    is believed. So the hash now covers the rule only (`rule_portion`), and the row is checked
    against the run's ACTUAL starting state and recorded in the receipt.

    **Per-row registration, never re-freezing.** A row whose actual state differs from the
    freeze's description must carry its own committed registration under `data/m62/m63-rows/`.
    That is also where §S.5's `cross_law` and `fp_base` pin lives: the 2026-09-11 freeze predates
    it and may not be edited, so on an unregistered row those two are RECORDED and the receipt
    says `pinned_by: null` rather than implying a pin that is not there.

    Refusals, each planted and watched in `_freeze_control`: (a) no freeze file; (b) the freeze
    edited after its commit; (c) a rule differing from the frozen one; (d) the freeze never
    committed; (e) **no row supplied** -- missing-and-fatal, so a run cannot be judged against a
    row nobody named; (f) **a row whose actual state contradicts the freeze with no registration
    to cover it**; (g) a registration that does not match the row it claims to register."""
    if not os.path.exists(freeze_path):
        raise SystemExit(
            f"freeze refused: no freeze registered at {freeze_path}.\n"
            f"  A held-out run needs its configuration registered BEFORE it runs, in a commit.\n"
            f"  python3 tools/parts_report.py freeze <config.json> && git add {freeze_path} "
            f"&& git commit -m \"freeze the M63 configuration\"")
    st = _git("status", "--porcelain", "--", freeze_path, repo=repo)
    if st:
        what = ("is untracked -- a file, not a freeze" if st.lstrip().startswith("??")
                else "has uncommitted edits")
        raise SystemExit(
            f"freeze refused: {freeze_path} {what}.\n"
            f"  A freeze that can be edited after the fact is not a freeze.\n"
            f"  git add {freeze_path} && git commit -m \"freeze the M63 configuration\"")
    frozen = json.load(open(freeze_path))
    fr, cr = rule_portion(frozen["config"]), rule_portion(config)
    want, got = config_sha256(fr), config_sha256(cr)
    if want != got:
        a, b = flatten_config(fr), flatten_config(cr)
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

    # (e) the row is missing-and-fatal. A frozen run is a run ON SOMETHING, and hash equality says
    # nothing about which row; a receipt that names no row can only repeat the freeze's prose.
    if row is None:
        raise SystemExit(
            "freeze refused: no row was supplied, so this receipt could only repeat the freeze's\n"
            "  own description of a starting state -- which is how a frozen run on one row came\n"
            "  to certify the starting state of another. Pass `row=` with the run's ACTUAL\n"
            f"  starting state: at least {{'row_id', 'incumbent_weight'}}, plus {list(ROW_PINNED)}.")
    missing = [k for k in ("row_id", "incumbent_weight") if k not in row]
    if missing:
        raise SystemExit(f"freeze refused: the row is missing {missing}; a row that cannot be "
                         f"identified cannot be registered or checked.")

    # (f)/(g) the row against the freeze's description, and against its own registration.
    described = {k: frozen["config"][k] for k in ROW_DESCRIPTIVE if k in frozen["config"]}
    matches_freeze = described.get("incumbent_weight") == row["incumbent_weight"]
    rp = row_path(row["row_id"], rows_dir=rows_dir)
    reg, reg_sha = None, None
    if os.path.exists(rp):
        rst = _git("status", "--porcelain", "--", rp, repo=repo)
        if rst:
            what = ("is untracked -- a file, not a registration"
                    if rst.lstrip().startswith("??") else "has uncommitted edits")
            raise SystemExit(f"freeze refused: the row registration {rp} {what}.\n"
                             f"  A registration that can be edited after the fact is not one.\n"
                             f"  git add {rp} && git commit -m \"register row {row['row_id']}\"")
        reg = json.load(open(rp))
        reg_sha = _git("log", "-1", "--format=%H", "--", rp, default="", repo=repo)
        if not reg_sha:
            raise SystemExit(f"freeze refused: {rp} is not in git history -- an uncommitted "
                             f"registration is a file, not a registration. Commit it first.")
        off = {k: (reg["row"].get(k), row.get(k)) for k in set(reg["row"]) | set(row)
               if reg["row"].get(k) != row.get(k)}
        if off:
            raise SystemExit(
                f"freeze refused: this run's starting state is not the one registered for row "
                f"{row['row_id']!r}.\n" +
                "\n".join(f"    {k}: registered {v[0]!r}  actual {v[1]!r}"
                          for k, v in sorted(off.items())) +
                f"\n  {rp}")
    elif not matches_freeze:
        raise SystemExit(
            f"freeze refused: this run starts at incumbent_weight "
            f"{row['incumbent_weight']}, and the freeze describes "
            f"{described.get('incumbent_weight')!r}.\n"
            f"  Hash equality covers the RULE only, so it cannot cover this -- and the old code\n"
            f"  passed here while its receipt asserted the frozen row's starting state.\n"
            f"  Register the row BEFORE running it (never re-freeze: that would change what the\n"
            f"  already-scored rows were judged under):\n"
            f"    python3 tools/parts_rule.py register-row --row-id {row['row_id']} ...\n"
            f"    git add {rp} && git commit -m \"register row {row['row_id']}\"")

    pinned_by = (f"the row registration {os.path.relpath(rp, ROOT)} @ {(reg_sha or '')[:12]}"
                 if reg else None)
    return {
        "freeze_commit": sha,
        "rule_sha256": got,
        "rule_fields": sorted(cr),
        "row": dict(row),
        "row_registration": (os.path.relpath(rp, ROOT) if reg else None),
        "row_registration_commit": reg_sha,
        "row_matches_freeze_description": matches_freeze,
        "freeze_describes": described,
        "pins": {k: {"value": row.get(k), "pinned_by": pinned_by,
                     "note": None if reg else
                     "RECORDED, NOT PINNED: the freeze predates the §S.5 decision to pin this and "
                     "may not be re-frozen. Register this row to pin it."}
                 for k in ROW_PINNED},
        "reading": (
            "the rule is the frozen one and this row's starting state is registered"
            if reg else
            "the rule is the frozen one, and this row's starting state matches the freeze's own "
            "description; the §S.5 pins are recorded but not pinned until the row is registered"),
    }


def _freeze_control(verbose=True):
    """Every refusal, planted in a scratch git repository and watched to fire.

    (a) no file; (b) committed then edited; (c) a config differing in a NESTED LIST (the case the
    shipped `.items()` diff raised on); (d) committed and equal -> returns a receipt; (e) present
    but never committed; **(e2) no row supplied**; **(f) a row contradicting the freeze with no
    registration**; **(g) a registration that does not match the row**; (h) an uncommitted
    registration; (i) the registered row, which returns and whose receipt says PINNED.

    **The uninformative outcome, named first.** Every refusal here is checked by `expect`, and a
    refusal firing for the wrong reason would still read `refused`. So each new refusal is matched
    on a needle from its own message, and each is paired with an ACCEPT arm at (d) and (i): if the
    accept arms ever went red, every refusal below would be a blanket one and would prove nothing.
    (f)'s reachability is the point of the whole item -- on the old code that call RETURNED."""
    import shutil, tempfile
    rows = []
    d = tempfile.mkdtemp(prefix="m63-freeze-control-")
    try:
        for a in (["init", "-q"], ["config", "user.email", "c@x"], ["config", "user.name", "c"]):
            subprocess.run(["git", "-C", d, *a], capture_output=True)
        fp = os.path.join(d, "freeze.json")
        rd = os.path.join(d, "rows")
        os.makedirs(rd, exist_ok=True)
        cfg = {"problem": {"L": "v412e2106.vtx", "rung": {"order": 1, "elements": [[2, 0, 4, 2]]}},
               "budgets": {"wall_ask": 600.0},
               # the descriptive half: prose and a number about ONE row, which is what the old
               # hash silently certified for every other row too
               "held_out_state": "the 375-level accumulator", "incumbent_weight": 374,
               "target": "|M| <= 374"}
        frozen_row = {"row_id": "A403", "incumbent_weight": 374,
                      "cross_law": {"name": "rho15", "cos": "7/8"}, "base_fp": "ff" * 8,
                      "base_r": 2.6}
        other_row = dict(frozen_row, row_id="A412", incumbent_weight=373)

        def attempt(name, config, expect, needle="", row=frozen_row):
            try:
                v = require_frozen(config, row=row, freeze_path=fp, rows_dir=rd, repo=d)
                got, full = "returned", v["freeze_commit"][:8] + " " + v["reading"]
            except SystemExit as e:
                got, full = "refused", str(e)
            detail = full.splitlines()[0]
            # match on the WHOLE message: a refusal names its reason on the line that explains
            # the remedy, and matching the first line alone scored a correct refusal as a miss.
            ok = got == expect and (needle in full if needle else True)
            rows.append((name, ok, detail))
            if verbose:
                print(f"  {'ok  ' if ok else 'FAIL'} {name}: {got} -- {detail[:96]}")
            return detail

        attempt("(a) no freeze file", cfg, "refused", "no freeze registered")
        json.dump({"config": cfg}, open(fp, "w"), sort_keys=True)
        attempt("(e) present but never committed", cfg, "refused", "is untracked")
        subprocess.run(["git", "-C", d, "add", "freeze.json"], capture_output=True)
        subprocess.run(["git", "-C", d, "commit", "-qm", "freeze"], capture_output=True)
        attempt("(d) ACCEPT ARM: committed, equal, row matches the freeze", cfg, "returned")

        # (e2) a run that names no row cannot be judged against one
        try:
            require_frozen(cfg, freeze_path=fp, rows_dir=rd, repo=d)
            det, ok = "ACCEPTED with no row", False
        except SystemExit as e:
            det, ok = str(e).splitlines()[0], "no row was supplied" in str(e)
        rows.append(("(e2) no row supplied is fatal", ok, det))
        if verbose:
            print(f"  {'ok  ' if ok else 'FAIL'} (e2) no row supplied is fatal: {det[:96]}")

        # (f) THE ITEM: a different row, same rule. The old code returned the sha here and the
        # receipt then asserted the frozen row's starting state.
        attempt("(f) a row contradicting the freeze, unregistered", cfg, "refused",
                "Register the row", row=other_row)

        # (h)/(g)/(i) the registration path
        rp = os.path.join(rd, "A412.json")
        json.dump({"kind": "m63-row", "row": other_row}, open(rp, "w"), sort_keys=True)
        attempt("(h) an untracked registration is not a registration", cfg, "refused",
                "is untracked -- a file, not a registration", row=other_row)
        subprocess.run(["git", "-C", d, "add", "rows/A412.json"], capture_output=True)
        subprocess.run(["git", "-C", d, "commit", "-qm", "row"], capture_output=True)
        det = attempt("(i) ACCEPT ARM: the registered row runs, and its receipt says PINNED",
                      cfg, "returned", row=other_row)
        rec = require_frozen(cfg, row=other_row, freeze_path=fp, rows_dir=rd, repo=d)
        pinned = all(v["pinned_by"] for v in rec["pins"].values())
        rows.append(("(i2) the receipt pins cross_law and the base on a registered row", pinned,
                     str(rec["pins"]["cross_law"])[:90]))
        if verbose:
            print(f"  {'ok  ' if pinned else 'FAIL'} (i2) the receipt pins cross_law and the base "
                  f"on a registered row: {str(rec['pins']['cross_law'])[:80]}")
        unpinned = require_frozen(cfg, row=frozen_row, freeze_path=fp, rows_dir=rd, repo=d)
        honest = (unpinned["pins"]["cross_law"]["pinned_by"] is None
                  and "NOT PINNED" in unpinned["pins"]["cross_law"]["note"])
        rows.append(("(i3) on an UNregistered row the receipt says recorded, never pinned",
                     honest, str(unpinned["pins"]["cross_law"])[:90]))
        if verbose:
            print(f"  {'ok  ' if honest else 'FAIL'} (i3) on an UNregistered row the receipt says "
                  f"recorded, never pinned")

        # (g) the registration must match the row it claims to register
        attempt("(g) a row that differs from its own registration", cfg, "refused",
                "not the one registered", row=dict(other_row, incumbent_weight=372))

        # (j) the `not in git history` branch. It is NOT reachable by "never committed" -- an
        # untracked file is dirty and (e) catches it first -- so a control that assumed it was
        # would have been scoring the dirty refusal under another name. It IS reachable by a
        # freeze that lives outside the repository being checked, where `git status` and
        # `git log` both come back empty. Planted so the branch is seen to fire at least once.
        outside = os.path.join(tempfile.mkdtemp(prefix="m63-freeze-outside-"), "freeze.json")
        json.dump({"config": cfg}, open(outside, "w"), sort_keys=True)
        try:
            require_frozen(cfg, row=frozen_row, freeze_path=outside, rows_dir=rd, repo=d)
            det, ok = "ACCEPTED a freeze outside the repository", False
        except SystemExit as e:
            det, ok = str(e).splitlines()[0], "not in git history" in str(e)
        rows.append(("(j) a freeze outside the repository is not in its history", ok, det))
        if verbose:
            print(f"  {'ok  ' if ok else 'FAIL'} (j) a freeze outside the repository is not in "
                  f"its history: {det[:88]}")
        shutil.rmtree(os.path.dirname(outside), ignore_errors=True)

        nested = json.loads(json.dumps(cfg))
        nested["problem"]["rung"]["elements"] = [[2, 0, 4, 2], [0, 4, 2, 0]]
        attempt("(c) a config differing in a NESTED LIST", nested, "refused", "differs from")
        # the descriptive half is NOT part of the rule hash any more: changing it alone is not a
        # retune of the rule, it is a different ROW, and (f) is what catches that.
        desc = dict(cfg, held_out_state="something else entirely")
        attempt("(c2) a DESCRIPTIVE field alone is not a rule difference", desc, "returned")
        json.dump({"config": cfg, "edited": True}, open(fp, "w"), sort_keys=True)
        attempt("(b) committed then edited", cfg, "refused", "uncommitted edits")
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
