#!/usr/bin/env python3
"""M63 phase D: the expansion half of `[Parts2020a]`'s loop, and the instruments that score it.

`tools/parts_reduce.py` is the *reduction* half -- given a working graph, find the minima. This
module is the other half: which vertices to ADD, how to price a candidate addition before paying
to reduce it, and how to judge a selection rule honestly when the literature contains exactly one
recorded expert move.

    python3 tools/parts_loop.py --self-test          # every planted control, ~2 min
    python3 tools/parts_loop.py census               # the expansion menu, solver-free
    python3 tools/parts_loop.py cost-probe           # D0: the ask regime, before anything long

--------------------------------------------------------------------------------------------------
**The five things that are easy to get backwards, each of which silently corrupts a later run.**

*1. What travels between a smaller working graph and a larger one.* Let `W subset W' = W u D`, same
companion `C`, same rung. Colourability of a selection depends on the selection and `C` ALONE --
`W` never enters -- so:

    a decided ask          BOTH directions, verbatim   (hence `ColourCache`, keyed by lattice
                                                        tuples so it is portable across stages)
    a refusing selection   UPWARD    (an incumbent, and its witness)
    non-criticality        UPWARD    (a superset of a refusing selection refuses)
    criticality            DOWNWARD ONLY
    a correction set       DOWNWARD ONLY

The last two are the same fact -- a singleton correction set IS a critical atom -- and importing one
upward unchanged can EXCLUDE a genuine record, because a refusing selection in the larger graph may
satisfy none of its atoms by using the new material. Derived independently here, by the M63 phase D
implementer, the small-half probe and Poros on 2026-09-11.

*2. Anything chosen by a rule that reads `A` changes meaning when `A` grows.* The reserve is defined
by degree INTO `A`, so adding one orbit can promote another that failed against the bare
accumulator: the admissible pair menu is NOT contained in pairs drawn from the single menu, and it
can only grow. Every `A`-dependent choice this module makes is therefore pinned by value at a named
baseline and recorded in the artifact, never re-resolved per iteration.

*3. His degree test governs the RESERVE, not the fills.* `[Parts2020a]` §5.6 gives partially filled
orbits their own priority and states the degree condition (parts:517-521) only for membership of
`R`. Two of the four orbits in his one recorded successful move were fills. A menu built on the
degree test alone can therefore miss every partially-occupied orbit below threshold, and
`menu_census` reports the two readings separately for exactly that reason.

*4. A reading is a parameter, never a constant.* His admission sentence -- *"if, when added to the
graph A, the degree of some of its vertices is at least 4"* -- reads three ways, and the menu's size
moves with it. Every count this module emits names the reading that produced it.

*5. Take edges from the stage, never from a whole-base relation.* A stage numbers vertices over
`range(2n)` with L first and S second and the S-side centre forbidden outright, so a relation
computed on the base does not know which side a shared point is on. That mistake produced 54 cross
edges where the record has 18 (Poros, P3b). `EdgeOracle` therefore builds ONE stage over the whole
base and reads every degree out of `stage.A.induced(...)`.
"""
from __future__ import annotations
import argparse, itertools, json, os, sys, time
from collections import defaultdict
from dataclasses import dataclass, field

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import parts_faces as F
import parts_repro as P
import parts_report as R
import parts_reduce as RED
import parts_stage as PS
import parts_vtx as V
import typem as T

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
REF11 = os.path.join(ROOT, "data", "m62", "parts-ref11", "JP", "Large")

# The three readings of his admission sentence (parts:517-521), nested by construction.
READINGS = {
    "a-strict": "an absent vertex's unit degree INTO A alone",
    "b-literal-internal": "degree in A u O, so the added orbit's own edges count -- the adopted "
                          "reading, and the better reading of his sentence",
    "c-literal-plus-cross": "degree in A u O u C, adding cross edges to the frozen companion",
}
ADOPTED_READING = "b-literal-internal"

# Phase D's additions to the closed verdict vocabulary (phase C's list plus `parts_reduce.VERDICTS`).
LOOP_VERDICTS = (
    "improved", "grew", "unchanged", "stalled", "level-truncated", "base-fails",
    "no-op-expansion", "proxy-cannot-separate", "batch-agrees", "rungs-agree",
    "contains-a-known-minimum", "rule-read-his-data", "rung-pinned", "rung-drifted",
    "map-identity-agrees", "map-parallel-identical", "map-entry-impossible",
    "edge-sweep-impossible", "edge-sweep-wrong-graph", "pin-edge-protected", "centre-critical",
    "restriction-identity-holds", "restriction-identity-broken", "companion-drifted",
)


# ============================================================ the portable colourability cache
class ColourCache:
    """Decided asks, keyed by the selection's LATTICE TUPLES rather than by atom index.

    Colourability of `S u C` depends on `S` and `C` alone, so a decided ask stays true in every
    larger working graph -- it is the one artifact that transfers in both directions verbatim
    (module docstring, rule 1). Atom indices do not survive a change of stage; lattice tuples do,
    which is why the key is what it is.

    The companion is part of the key, because the property is about `S u C` and a different
    companion is a different question. `undecided` is never cached: it is a fact about a budget."""

    def __init__(self, companion_fp: str):
        self.companion_fp = companion_fp
        self.hits = self.misses = 0
        self._d: dict[frozenset, str] = {}

    @staticmethod
    def key(stage, kept_atoms) -> frozenset:
        out = set()
        for a in kept_atoms:
            out.update((h, tuple(t)) for h, t in stage.vertex_labels(stage.atoms[a]))
        return frozenset(out)

    def get(self, k):
        v = self._d.get(k)
        if v is None:
            self.misses += 1
        else:
            self.hits += 1
        return v

    def put(self, k, verdict):
        if verdict in ("sat", "unsat"):          # never cache `unknown`: it is a launch fact
            self._d[k] = verdict

    def stats(self):
        return {"entries": len(self._d), "hits": self.hits, "misses": self.misses,
                "companion_fp": self.companion_fp,
                "note": "keyed by lattice tuples, so entries are portable across stages; an "
                        "`unknown` is never stored because it is a fact about a budget"}


# ============================================================ the edge oracle (one stage, once)
class EdgeOracle:
    """Unit-adjacency over the WHOLE base plus one frozen companion, read out of a single stage.

    Built once and shared, because the alternative -- a relation computed on the base -- does not
    know which side a shared point is on and overcounts cross edges (module docstring, rule 5).

    `deg_into(v, S)` is the number of unit neighbours of the L-side base point `v` lying in the
    L-side set `S`; `cross_deg(v)` is its number of edges to the companion."""

    def __init__(self, base, companion_tuples, cross_law=None, log=print):
        t0 = time.time()
        self.base = base
        allt = sorted(base.tups)
        self.stage = PS.Stage(base, allt, sorted(companion_tuples), side="L", rung=24,
                              pin=True, cross_law=cross_law)
        n = self.stage.A.n
        self.n = n
        self.ix = self.stage.ix
        self.key_of = {i: t for t, i in self.ix.items()}
        self.adj_LL = defaultdict(set)           # base tuple -> set of base tuples
        self.adj_LC = defaultdict(set)           # base tuple -> set of companion vertex ids
        n_ss = 0
        for u, v in self.stage.A.induced(self.stage.present):
            lo_is_L, hi_is_L = u < n, v < n
            if lo_is_L and hi_is_L:               # L-L: a base unit edge
                tu, tv = self.key_of[u], self.key_of[v]
                self.adj_LL[tu].add(tv)
                self.adj_LL[tv].add(tu)
            elif lo_is_L or hi_is_L:              # exactly one endpoint on the companion side
                lo, hi = (u, v) if lo_is_L else (v, u)
                self.adj_LC[self.key_of[lo]].add(hi)
            else:
                # S-S: an edge INSIDE the frozen companion. It exists (the companion is a graph,
                # not an independent set) and it contributes to no L-side admission degree. The
                # first version of this loop assumed every non-L-L edge had exactly one L
                # endpoint and died on `key_of[5498]`; a companion with 564 internal edges is
                # exactly the case that assumption misses.
                n_ss += 1
        self.companion_fp = R.fp_tuples(sorted(companion_tuples))
        self.n_companion_internal = n_ss
        log(f"  edge oracle: {len(allt)} base points, {sum(len(s) for s in self.adj_LL.values())//2}"
            f" internal unit edges, {sum(len(s) for s in self.adj_LC.values())} cross edges to the "
            f"companion, {n_ss} edges inside it  [{time.time()-t0:.0f}s]")

    def deg(self, t, S, reading, orbit_tuples=()):
        """His admission degree of base point `t`, under one of the three readings."""
        d = len(self.adj_LL[t] & S)
        if reading in ("b-literal-internal", "c-literal-plus-cross"):
            d += len(self.adj_LL[t] & (set(orbit_tuples) - S))
        if reading == "c-literal-plus-cross":
            d += len(self.adj_LC[t])
        return d


# ============================================================ the candidate
@dataclass(frozen=True)
class Candidate:
    """One proposed expansion: **the vertices it adds**, and where the proposal came from.

    `fills` and `adds` were one thing wearing two names. His prose distinguishes *completing a
    partially filled orbit* from *adding a reserve orbit*, but the object added is a set of base
    vertices not currently in `A` either way, and every consumer treats the two identically. The
    distinction is provenance, and provenance is a field.

    **The empty candidate is unrepresentable except as the deliberate control.** An expansion that
    adds nothing is his own recorded no-op (*"filling orbit (4,0,0,0)"*, already 6 of 6 in `A403`),
    so the constructor raises -- unless the provenance is `identity`, which is the map's own
    unsampled-member control (d6.5) and is the one place an empty expansion is meant."""
    vertices: frozenset
    provenance: str
    flags: frozenset = field(default_factory=frozenset)

    PROVENANCE = ("partial-fill", "reserve", "many-then-trim", "stall-escape", "identity")

    def __post_init__(self):
        if self.provenance not in self.PROVENANCE:
            raise ValueError(f"unknown provenance {self.provenance!r}; one of {self.PROVENANCE}")
        if not self.vertices and self.provenance != "identity":
            raise ValueError("no-op-expansion: a candidate that adds no vertex is his own recorded "
                             "no-op (filling an orbit already full in A). Only the `identity` "
                             "provenance -- the map's control d6.5 -- may be empty.")

    @property
    def n_new(self) -> int:
        """Derived, never stored -- his perturbation strength is the number of vertices added."""
        return len(self.vertices)

    def orbits(self, base) -> dict:
        """`{orbit label: how many of its members this candidate adds}` -- a rendering, not a
        second copy of the datum."""
        c = defaultdict(int)
        for t in self.vertices:
            c[base.label[base.of[t]]] += 1
        return dict(c)

    def name(self, base) -> str:
        o = self.orbits(base)
        return "+".join(f"({','.join(map(str, k))}):{v}" for k, v in sorted(o.items())) or "identity"

    def to_json(self, base) -> dict:
        return {"vertices": sorted(map(list, self.vertices)), "n_new": self.n_new,
                "orbits": {str(k): v for k, v in sorted(self.orbits(base).items())},
                "provenance": self.provenance, "flags": sorted(self.flags),
                "name": self.name(base)}


# ============================================================ the menu
def menu_census(base, A_tuples, oracle, *, min_degree=4, shoulder=3, log=print) -> dict:
    """Every orbit's standing against his admission rule, under all three readings at once.

    This is the function that decides how big the sweep is, so it reports rather than chooses:
    the eligible set under each reading, the fills (which his §5.6 exempts from the degree test
    altogether), the shoulder just below the cut, and which orbits lie outside his `r = 2` disk.

    **The fills exemption matters and is easy to miss.** His degree condition is stated for
    membership of the reserve `R`; partially filled orbits get their own priority sentence and no
    degree test. Two of the four orbits in his one recorded move were fills."""
    A = set(A_tuples)
    disk = P.orbits_meeting_disk(base, 2.0)
    rows = []
    for oi in range(len(base.orbits)):
        lab = base.label[oi]
        members = [base.tups[i] for i in base.orbits[oi]]
        absent = [t for t in members if t not in A]
        if not absent:
            continue                              # already full in A: his own no-op
        present = len(members) - len(absent)
        degs = {}
        for r in READINGS:
            degs[r] = max(oracle.deg(t, A, r, members) for t in absent)
        rows.append({
            "orbit": lab, "size": len(members), "absent": len(absent), "present": present,
            "partial": present > 0, "degree": degs,
            "radii": [round(x, 6) for x in base.radii[oi]],
            "outside_his_disk": lab not in disk,
            "all_coords_nonzero": all(x != 0 for x in lab),
        })
    out = {"kind": "m63-menu-census", "schema": 1, "producer": "tools/parts_loop.py:menu_census",
           "adopted_reading": ADOPTED_READING, "readings": READINGS,
           "min_degree": min_degree, "shoulder_degree": shoulder,
           "orbits_with_an_absent_vertex": len(rows), "rows": rows}
    for r in READINGS:
        elig = [x for x in rows if x["degree"][r] >= min_degree]
        fills = [x for x in rows if x["partial"]]
        fill_only = [x for x in fills if x["degree"][r] < min_degree]
        sh = [x for x in rows if x["degree"][r] == shoulder and not x["partial"]]
        out[r] = {
            "reserve": len(elig),
            "fills": len(fills),
            "fill_only": len(fill_only),
            "menu": len({tuple(x["orbit"]) for x in elig} | {tuple(x["orbit"]) for x in fills}),
            "shoulder": len(sh),
            "outside_disk_eligible": sum(1 for x in elig if x["outside_his_disk"]),
            "outside_disk_shoulder": sum(1 for x in sh if x["outside_his_disk"]),
            "degree_histogram": {str(k): sum(1 for x in rows if x["degree"][r] == k)
                                 for k in sorted({x["degree"][r] for x in rows})},
            "fill_only_labels": [x["orbit"] for x in fill_only],
            "shoulder_labels": [x["orbit"] for x in sh],
        }
        log(f"  reading {r:<22} reserve {len(elig):>3}  fills {len(fills):>3} "
            f"(fill-only {len(fill_only):>2})  MENU {out[r]['menu']:>3}  shoulder {len(sh):>3}  "
            f"outside-disk eligible {out[r]['outside_disk_eligible']}")
    return out


def menu_candidates(base, A_tuples, census, *, reading=ADOPTED_READING, min_degree=4,
                    shoulder=None) -> list[Candidate]:
    """The census turned into candidates: fills first (his §5.6 priority), then the reserve in
    decreasing-degree order (his own offering order), then the shoulder if asked for.

    A candidate adds every ABSENT member of its orbit. His priority sentence -- *"especially to
    orbits with a small number of vertices (6 or 12)"* -- is the tie-break inside the fill block."""
    A = set(A_tuples)
    fills, res, sh = [], [], []
    for x in census["rows"]:
        lab = tuple(x["orbit"])
        verts = frozenset(base.tups[i] for i in base.orbits[base.by_label[lab]]
                          if base.tups[i] not in A)
        flags = set()
        if x["outside_his_disk"]:
            flags.add("outside-his-disk")
        if x["all_coords_nonzero"]:
            flags.add("all-coords-nonzero")
        d = x["degree"][reading]
        if x["partial"]:
            if d < min_degree:
                flags.add("fill-only")           # admitted by his §5.6 exemption, not by degree
            fills.append((x["size"], -d, lab, Candidate(verts, "partial-fill", frozenset(flags))))
        elif d >= min_degree:
            res.append((-d, lab, Candidate(verts, "reserve", frozenset(flags))))
        elif shoulder is not None and d == shoulder:
            flags.add("shoulder")
            sh.append((-d, lab, Candidate(verts, "reserve", frozenset(flags))))
    fills.sort(key=lambda r: (r[0], r[1], r[2]))
    res.sort(key=lambda r: (r[0], r[1]))
    sh.sort(key=lambda r: (r[0], r[1]))
    return [c for *_, c in fills] + [c for *_, c in res] + [c for *_, c in sh]


# ============================================================ D0 -- the cost probe
def cost_probe(base, L_file, S_file, known_min_file, *, runs=3, near=20, log=print) -> dict:
    """The ask regime on one L stage, in CPU seconds, before anything long is launched.

    Four populations, because a cost statement that merges them is a statement about a mixture
    nobody can reproduce:
      cold_refusing   -- a fresh solver per measurement, the full working graph (what a per-
                         candidate sweep pays if it does NOT hold an oracle)
      phase1          -- the real phase-1 population, on one incremental oracle
      near_refusing   -- `near` refusing asks AT the optimum: a known minimum of this stage plus
                         k extra atoms, k = 0..near-1. This is the population his own ~10 s asks
                         were measured in, and the one P-D0b is about
      near_colourable -- the same minimum MINUS one atom, which must be colourable

    The known minimum doubles as control **d1.3** (`contains-a-known-minimum`) at two asks and no
    plant: it says the stage was built over the object we think it was."""
    L = V.load_lattice(os.path.join(REF11, L_file))
    S = V.load_lattice(os.path.join(REF11, S_file))
    M = V.load_lattice(os.path.join(REF11, known_min_file))
    st = PS.Stage(base, L, S, side="L", rung=1, pin=True)
    lab = {tuple(l[1]): i for i, l in enumerate(st.atom_labels)}
    if not set(M) <= set(L):
        raise SystemExit(f"{known_min_file} is not inside {L_file}: this probe's whole point is a "
                         f"selection whose answer is known, and there is none here")
    sel = sorted(lab[t] for t in M if t in lab)
    allA = list(range(len(st.atoms)))
    rest = [a for a in allA if a not in set(sel)]
    out = {"kind": "m63-cost-probe", "schema": 1, "producer": "tools/parts_loop.py:cost_probe",
           "stage": st.describe(), "stage_identity": st.identity(),
           "L": L_file, "S": S_file, "known_minimum": known_min_file,
           "atoms": len(allA), "known_minimum_atoms": len(sel),
           "load_at_start": open("/proc/loadavg").read().split()[0],
           "machine": os.uname().nodename, "cores": os.cpu_count()}

    def cpu(fn):
        best = None
        for _ in range(runs):
            t = time.process_time()
            fn()
            best = min(best, time.process_time() - t) if best is not None else time.process_time() - t
        return round(best, 4)

    log(f"  {st.describe()}")
    log(f"  known minimum {known_min_file}: {len(sel)} atoms of {len(allA)}")

    # (1) COLD refusing: a fresh solver each time. This is what `parts_stage.refuses` pays.
    def cold():
        PS.refuses(PS.Stage(base, L, S, side="L", rung=1, pin=True), allA)
    out["cold_refusing_cpu_s"] = cpu(cold)
    log(f"  cold refusing ask, fresh stage AND fresh solver, min of {runs}: "
        f"{out['cold_refusing_cpu_s']} s CPU")

    orc = RED.Oracle(st, wall=600.0)
    # d1.3, free: the known minimum must refuse, and minus one atom must be colourable.
    v_min, _ = orc.ask(sel, wall=None)
    v_m1, _ = orc.ask(sel[:-1], wall=None)
    out["d1.3"] = {"verdict": "contains-a-known-minimum"
                             if (v_min == "unsat" and v_m1 == "sat") else "known-minimum-absent",
                   "known_minimum_refuses": v_min, "minus_one_atom": v_m1}
    log(f"  d1.3 {out['d1.3']['verdict']}: the known minimum reads {v_min}, minus one atom {v_m1}")

    # (2) phase 1's own population, on the held oracle.
    t = time.process_time()
    n1 = 0
    for a in allA:
        orc.ask([x for x in allA if x != a])
        n1 += 1
    out["phase1"] = {"asks": n1, "cpu_s": round(time.process_time() - t, 2),
                     "mean_cpu_s": round((time.process_time() - t) / n1, 5)}
    log(f"  phase 1: {n1} asks, {out['phase1']['cpu_s']} s CPU, "
        f"{out['phase1']['mean_cpu_s']} s each")

    # (3) near-optimal REFUSING asks: the known minimum plus k extras is a superset of a refusing
    #     selection, hence refusing, and sits at weights |M|..|M|+near-1 -- the tight regime.
    t, ns = time.process_time(), 0
    for k in range(near):
        v, _ = orc.ask(sel + rest[:k], wall=None)
        ns += 1
        if v != "unsat":
            out.setdefault("anomalies", []).append(
                f"a superset of a known minimum read {v} at k={k}: impossible, this is a bug")
    out["near_refusing"] = {"asks": ns, "cpu_s": round(time.process_time() - t, 2),
                            "mean_cpu_s": round((time.process_time() - t) / ns, 5)}
    log(f"  near-optimal refusing: {ns} asks, {out['near_refusing']['mean_cpu_s']} s each")

    # (4) near-optimal COLOURABLE asks: the known minimum minus one atom, every way.
    t, nc = time.process_time(), 0
    for i in range(min(near, len(sel))):
        orc.ask(sel[:i] + sel[i + 1:], wall=None)
        nc += 1
    out["near_colourable"] = {"asks": nc, "cpu_s": round(time.process_time() - t, 2),
                              "mean_cpu_s": round((time.process_time() - t) / nc, 5)}
    log(f"  near-optimal colourable: {nc} asks, {out['near_colourable']['mean_cpu_s']} s each")
    out["asks"] = orc.stats()
    out["load_at_end"] = open("/proc/loadavg").read().split()[0]
    out["provenance"] = R.provenance(config={"probe": out["stage_identity"], "runs": runs})
    return out


# ============================================================ D6 -- the outcome map
#
# The map is the loop's own step tabulated over the menu, never a parallel implementation: a
# second evaluator can drift and would then be measuring something the loop does not do, which is
# the one failure this surface exists to prevent.
#
# **Three outcome states, and `undecided` is never folded into `inert`** (Poros card 15). The
# primary question is answered by a budgeted ask loop, so a wall hit is reachable -- and the
# candidates likeliest to exhaust a wall are those nearest the boundary, which are exactly the ones
# worth finding. Folding them into `no` biases the base rate DOWNWARD, invisibly. `density()`
# therefore computes the rate over DECIDED candidates and prints the undecided count beside it.

PRIMARY = "|M| strictly below the incumbent"
SECONDARY = "{M} strictly larger at fixed |M| and fixed rung"


def expanded(A_tuples, cand) -> list:
    return sorted(set(A_tuples) | set(cand.vertices))


def check_invariants(base, A_tuples, companion, cand, stage, reference, *, anchor=None) -> dict:
    """Per-entry invariants, cheapest first. They catch *right machinery, wrong graph*; the target
    and rung echoed in the record catch *right graph, wrong question*.

    1. the companion's fingerprint is constant across the sweep -- free, and a wrong companion
       dies at candidate one rather than at the report;
    2. **the restriction identity** -- the expanded stage's induced edges, restricted to the
       unexpanded stage's vertices, must equal the unexpanded stage's edges exactly. Adding
       vertices cannot change edges among existing ones, so this catches a wrong companion AND a
       wrong frame, which a vertex count cannot (Poros, and it is planted over my own weaker one);
    3. the vertex count is exactly `|A| + n_new`, which catches a candidate that silently added
       nothing or added a point already present;
    4. the known-answer anchor, two asks: a known minimum of the UNEXPANDED stage must still
       refuse here, and minus one atom must be colourable. Its answer is invariant under every
       expansion, so if it ever varies between candidates that is the instrument, not the
       geometry."""
    out = {"verdict": "restriction-identity-holds", "checks": []}

    def edge_labels(st):
        return {tuple(sorted(e)) for e in (
            (("L" if u < st.A.n else "S", st.keys[u % st.A.n]),
             ("L" if v < st.A.n else "S", st.keys[v % st.A.n]))
            for u, v in st.A.induced(st.present))}

    fp = R.fp_tuples(sorted(companion))
    if fp != reference["companion_fp"]:
        out["verdict"] = "companion-drifted"
        out["checks"].append(f"companion fingerprint {fp[:8]} != {reference['companion_fp'][:8]}")
        return out
    keep = set(reference["vertex_labels"])
    restricted = {e for e in edge_labels(stage) if e[0] in keep and e[1] in keep}
    if restricted != reference["edges"]:
        out["verdict"] = "restriction-identity-broken"
        out["checks"].append(
            f"{len(restricted)} edges in the restriction against {len(reference['edges'])} in the "
            f"unexpanded stage; only-here {len(restricted - reference['edges'])}, "
            f"only-there {len(reference['edges'] - restricted)}")
        return out
    want = reference["n_vertices"] + cand.n_new
    got = stage.present.bit_count()
    if got != want:
        out["verdict"] = "restriction-identity-broken"
        out["checks"].append(f"{got} vertices against the expected {want} = "
                             f"{reference['n_vertices']} + {cand.n_new}")
        return out
    out["checks"] = [f"companion {fp[:8]}", f"restriction {len(restricted)} edges",
                     f"vertices {got} = {reference['n_vertices']} + {cand.n_new}"]
    if anchor is not None:
        v1 = PS.refuses(stage, anchor)
        v2 = PS.refuses(stage, anchor[:-1])
        out["anchor"] = {"known_minimum": v1, "minus_one": v2,
                         "verdict": "contains-a-known-minimum" if (v1 == "unsat" and v2 == "sat")
                                    else "known-minimum-absent"}
        if out["anchor"]["verdict"] != "contains-a-known-minimum":
            out["verdict"] = "restriction-identity-broken"
    return out


def sweep_candidate(base, A_tuples, companion, cand, *, incumbent, reference, anchor_tuples=None,
                    ckpt_dir, secondary=True, wall_ask=600.0, slice_conflicts=RED.SLICE_CONFLICTS,
                    log=print) -> dict:
    """One map entry: the primary decision, then -- only if the primary says inert -- the secondary.

    `incumbent` is the best known WEIGHT (atoms), so `|M| = incumbent + 1` vertices. The primary
    asks `target = incumbent - 1`: can this expansion beat the incumbent? The secondary asks
    `target = incumbent, require_any = the new atoms`: did the set of minima grow?

    Both run against ONE checkpoint, so the secondary inherits the primary's entire harvest --
    phase 1 and the correction sets are graph facts and survive the change of objective, while the
    search facts are discarded (`parts_reduce.reduce_stage`'s restriction rule).

    **No score is computed here.** The entry stores labels and costs so that a ranking nobody has
    thought of yet is scorable from the file alone."""
    t0 = time.process_time()
    W = expanded(A_tuples, cand)
    stage = PS.Stage(base, W, sorted(companion), side="L", rung=1, pin=True)   # ALWAYS pinned
    name = cand.name(base)
    inv = check_invariants(base, A_tuples, companion, cand, stage, reference,
                           anchor=None if anchor_tuples is None else
                           sorted({tuple(l[1]): i for i, l in enumerate(stage.atom_labels)}[t]
                                  for t in anchor_tuples))
    entry = {"candidate": cand.to_json(base), "name": name,
             "stage_identity": stage.identity(), "stage_fingerprint": stage.fingerprint(),
             "atoms": len(stage.atoms), "vertices": stage.present.bit_count(),
             "invariants": inv, "asked_at_target": incumbent - 1,
             "rung_used": stage.rung, "incumbent": incumbent}
    if inv["verdict"] != "restriction-identity-holds":
        entry["verdict"] = "not_run"
        entry["note"] = f"invariants failed ({inv['verdict']}); no ask was made"
        return entry
    new_atoms = sorted(i for i, l in enumerate(stage.atom_labels) if tuple(l[1]) in cand.vertices)
    if len(new_atoms) != cand.n_new:
        entry["verdict"] = "not_run"
        entry["note"] = (f"{len(new_atoms)} new atoms for {cand.n_new} new vertices: the candidate "
                         f"is not a set of fresh vertices of this stage")
        return entry
    ck = os.path.join(ckpt_dir, f"m63-map-{name.replace('/', '_')}.ckpt.json")
    cfg = {"problem": {"A_fp": R.fp_tuples(A_tuples), "companion_fp": reference["companion_fp"],
                       "candidate": sorted(map(list, cand.vertices)), "rung": 1},
           "budgets": {"wall_ask": wall_ask, "slice_conflicts": slice_conflicts}}

    # --- the primary decision: can this expansion BEAT the incumbent?
    p = RED.reduce_stage(stage, target=incumbent - 1, checkpoint=ck, config=cfg, log=log,
                         wall_ask=wall_ask, slice_conflicts=slice_conflicts)
    pst = p.pop("state")
    entry["primary"] = {"verdict": p["verdict"], "bound": p["bound_render"],
                        "M_vertices": p.get("M_vertices"),
                        "correction_sets": p["hypergraph"]["correction_sets"],
                        "asks": p["asks"], "cpu_seconds": p["cpu_seconds"]}
    if p["verdict"] == "reduced":
        entry["verdict"] = "yes"                    # it BEAT the incumbent -- escalate
        entry["M"] = p["M_vertices"]
        entry["M_set"] = p.get("M_set")
        entry["minima"] = p.get("minima")
    elif p["verdict"] == "no-selection-at-target":
        entry["verdict"] = "no"
        entry["M"] = incumbent + 1                  # free: >= by the refutation, <= by the anchor
    else:
        entry["verdict"] = "unknown"
        entry["note"] = f"primary returned {p['verdict']}; an undecided candidate is NOT a refused one"

    # --- the secondary decision, on inert candidates only: did {M} grow?
    #
    # `new_atoms` MUST be non-empty. For the identity candidate it is empty, `require_any` is then
    # falsy, the added clause disappears, and the "restricted" decision silently becomes the
    # UNRESTRICTED one at target = incumbent -- which enumerates the entire level and answers a
    # question nobody asked, at the cost the target exists to avoid. It is also vacuous: with no
    # new material {M} cannot grow, by the same identity that makes the secondary a decision.
    if secondary and entry["verdict"] == "no" and not new_atoms:
        entry["M_set_grew"] = "no"
        entry["secondary"] = {"verdict": "not-asked", "note":
                              "the identity candidate adds no material, so {M} cannot grow: "
                              "every minimum of W' uses no new atom and is a minimum of W. "
                              "Asking it would drop the restriction and enumerate the full level."}
    elif secondary and entry["verdict"] == "no":
        s = RED.reduce_stage(stage, target=incumbent, require_any=new_atoms, checkpoint=ck,
                             config=cfg, log=log, wall_ask=wall_ask,
                             slice_conflicts=slice_conflicts)
        s.pop("state")
        entry["secondary"] = {"verdict": s["verdict"], "bound": s["bound_render"],
                              "correction_sets": s["hypergraph"]["correction_sets"],
                              "asks": s["asks"], "cpu_seconds": s["cpu_seconds"],
                              "new_minima": len(s.get("minima", []))}
        entry["M_set_grew"] = {"reduced": "yes", "no-selection-at-target": "no"}.get(
            s["verdict"], "unknown")
        if s["verdict"] == "reduced":
            entry["new_minima_witness"] = s.get("minima", [])[:4]
    entry["cpu_seconds"] = round(time.process_time() - t0, 2)
    return entry


def density(entries: list) -> dict:
    """The base rate, over DECIDED candidates only.

    An `unknown` is a statement about a budget, not about the graph, and folding it into `no`
    inflates every ranking's apparent precision and biases the base rate downward (Poros card 15).
    The rate is therefore over `yes + no`, and the other two counts sit beside it."""
    c = {k: sum(1 for e in entries if e.get("verdict") == k)
         for k in ("yes", "no", "unknown", "not_run")}
    decided = c["yes"] + c["no"]
    grew = sum(1 for e in entries if e.get("M_set_grew") == "yes")
    grew_dec = sum(1 for e in entries if e.get("M_set_grew") in ("yes", "no"))
    return {**c, "decided": decided,
            "helpful_rate": None if not decided else round(c["yes"] / decided, 4),
            "M_set_grew": grew, "M_set_decided": grew_dec,
            "grew_rate": None if not grew_dec else round(grew / grew_dec, 4),
            "note": "the rate is over DECIDED candidates; an `unknown` is a fact about a budget "
                    "and is never a `no`. Three-way and never two."}


def build_reference(base, A_tuples, companion):
    """The unexpanded stage, as the fixed thing every candidate is checked against."""
    st = PS.Stage(base, sorted(A_tuples), sorted(companion), side="L", rung=1, pin=True)

    def edge_labels(s):
        return {tuple(sorted(e)) for e in (
            (("L" if u < s.A.n else "S", s.keys[u % s.A.n]),
             ("L" if v < s.A.n else "S", s.keys[v % s.A.n]))
            for u, v in s.A.induced(s.present))}
    return {"companion_fp": R.fp_tuples(sorted(companion)),
            "vertex_labels": set(st.vertex_labels(st.present)),
            "edges": edge_labels(st),
            "n_vertices": st.present.bit_count(), "atoms": len(st.atoms),
            "stage_identity": st.identity(), "stage_fingerprint": st.fingerprint()}


_W = {}                    # worker globals, inherited across fork rather than pickled per task


def _run_one(job):
    block, bi, cand = job
    name = cand.name(_W["base"])
    path = os.path.join(_W["entries"], f"entry-{name.replace('/', '_')}.json")
    if os.path.exists(path):                      # exact resume: an answered candidate is not re-asked
        e = json.load(open(path))
        e["resumed"] = True
        return e
    logp = os.path.join(_W["entries"], f"log-{name.replace('/', '_')}.txt")
    with open(logp, "w") as lf:
        def log(*a):
            print(*a, file=lf, flush=True)
        try:
            e = sweep_candidate(_W["base"], _W["A"], _W["companion"], cand,
                                incumbent=_W["incumbent"], reference=_W["reference"],
                                anchor_tuples=_W["anchor"], ckpt_dir=_W["ckpt"],
                                secondary=_W["secondary"], wall_ask=_W["wall_ask"], log=log)
        except Exception as ex:                   # a crash is a `not_run`, never a silent `no`
            e = {"candidate": cand.to_json(_W["base"]), "name": name, "verdict": "not_run",
                 "note": f"{type(ex).__name__}: {ex}"}
            print(f"EXCEPTION {type(ex).__name__}: {ex}", file=lf, flush=True)
    e["block"], e["block_index"] = block, bi
    with open(path + ".tmp", "w") as f:
        json.dump(e, f, indent=1)
    os.replace(path + ".tmp", path)
    return e


def plan_blocks(base, cands, census, *, reading=ADOPTED_READING, seed=20260911, log=print):
    """Two blocks, and the reason is that "most valuable first" silently biases the map.

    A sweep truncated in any RANKING's order measures that ranking on a sample it selected, which
    is precisely the bias the map exists to avoid. So block 1 is a seeded uniform-random half of
    the menu -- cut short at any point it still gives an unbiased density and an unbiased
    precision estimate for EVERY ranking -- and block 2 is the remainder in his own decreasing
    degree order, so the most valuable candidates by his criterion are answered next. Block 3 is
    the degree-3 shoulder, which is a separate question (is his cut in the right place?) and is
    never folded into the map's base rate."""
    import random
    deg = {tuple(x["orbit"]): x["degree"][reading] for x in census["rows"]}
    adm = lambda c: max((deg.get(k, 0) for k in c.orbits(base)), default=0)
    menu = [c for c in cands if "shoulder" not in c.flags]
    sh = sorted((c for c in cands if "shoulder" in c.flags),
                key=lambda c: sorted(c.orbits(base)))
    rng = random.Random(seed)
    order = list(range(len(menu)))
    rng.shuffle(order)
    half = len(order) // 2
    b1 = [menu[i] for i in order[:half]]
    b2 = sorted((menu[i] for i in order[half:]), key=lambda c: (-adm(c), sorted(c.orbits(base))))
    jobs = ([("control", 0, Candidate(frozenset(), "identity"))] +
            [("random", i, c) for i, c in enumerate(b1)] +
            [("his-degree-order", i, c) for i, c in enumerate(b2)] +
            [("shoulder", i, c) for i, c in enumerate(sh)])
    log(f"  blocks: control 1 (the identity candidate, d6.5), random {len(b1)}, "
        f"his-degree-order {len(b2)}, shoulder {len(sh)} (seed {seed}); a truncation is reported "
        f"with the block that produced it")
    return jobs


def run_map(base, A_tuples, companion, cands, census, *, incumbent, anchor_tuples, entries_dir,
            ckpt_dir, jobs=1, seed=20260911, secondary=True, wall_ask=600.0, scoring_role,
            limit=0, log=print) -> dict:
    """`step` tabulated over the menu, in parallel, resumable per candidate.

    **No score is stored.** The file holds labels and costs so that a ranking nobody has thought
    of yet is scorable from it alone, and `scoring_role` states whether numbers read off it are
    in-sample (the rule may be developed against them) or held out (the only surface on which a
    beats-random claim may be made)."""
    from concurrent.futures import ProcessPoolExecutor
    os.makedirs(entries_dir, exist_ok=True)
    os.makedirs(ckpt_dir, exist_ok=True)
    _W.update(base=base, A=sorted(A_tuples), companion=sorted(companion), incumbent=incumbent,
              reference=build_reference(base, A_tuples, companion), anchor=anchor_tuples,
              entries=entries_dir, ckpt=ckpt_dir, secondary=secondary, wall_ask=wall_ask)
    work = plan_blocks(base, cands, census, seed=seed, log=log)
    if limit:
        work = work[:limit]
        log(f"  LIMITED to the first {len(work)} jobs of the plan: the density below is a "
            f"truncation and names the blocks it covers")
    t0, out = time.time(), []
    log(f"  {len(work)} candidates, {jobs} workers, incumbent {incumbent} atoms "
        f"(|M| = {incumbent + 1} vertices); target {incumbent - 1}")
    if jobs <= 1:
        for j in work:
            out.append(_run_one(j))
            log(f"    [{len(out)}/{len(work)}] {out[-1]['name']}: {out[-1].get('verdict')}  "
                f"[{time.time()-t0:.0f}s]")
    else:
        with ProcessPoolExecutor(max_workers=jobs) as ex:
            for e in ex.map(_run_one, work):
                out.append(e)
                log(f"    [{len(out)}/{len(work)}] {e['name']}: {e.get('verdict')}"
                    f"{' GREW' if e.get('M_set_grew') == 'yes' else ''}  [{time.time()-t0:.0f}s]")
    menu_entries = [e for e in out if e.get("block") != "shoulder"]
    sh_entries = [e for e in out if e.get("block") == "shoulder"]
    return {
        "kind": "m63-map", "schema": 1, "producer": "tools/parts_loop.py:run_map",
        "headline": (f"{len(out)} candidates on the accumulator, incumbent {incumbent + 1} "
                     f"vertices: " + ", ".join(f"{k} {v}" for k, v in density(menu_entries).items()
                                               if k in ("yes", "no", "unknown", "not_run"))),
        "scoring_role": scoring_role,
        "outcome_variables": {"primary": PRIMARY, "secondary": SECONDARY,
                              "note": "frozen before the first outcome was read; atoms-freed is a "
                                      "PREDICTOR and appears in no outcome column"},
        "menu": {"admission_reading": ADOPTED_READING, "counts": {
            k: census[ADOPTED_READING][k] for k in ("reserve", "fills", "fill_only", "menu",
                                                    "shoulder")},
            "note": "his degree test governs the RESERVE; his §5.6 exempts partially filled "
                    "orbits from it, and `fill_only` counts those a degree-built menu would miss"},
        "his_move_absent_by_construction":
            "this accumulator already CONTAINS his own recorded expansion, so the four orbits his "
            "move used are not in the candidate set at all. A reader finding his move missing from "
            "this map is seeing that, not an omission.",
        "density": density(menu_entries),
        "shoulder": {"n": len(sh_entries), "density": density(sh_entries),
                     "note": "reported as its own result with its own enumeration, NEVER folded "
                             "into the menu's base rate: it answers whether his admission cut at "
                             "degree 4 is in the right place, not how often a move helps"},
        "seconds": round(time.time() - t0, 1), "jobs": jobs, "seed": seed,
        "entries": sorted(out, key=lambda e: (e.get("block", ""), e.get("block_index", 0))),
        "provenance": R.provenance(config={"A_fp": R.fp_tuples(A_tuples),
                                           "companion_fp": R.fp_tuples(sorted(companion)),
                                           "incumbent": incumbent, "seed": seed}),
    }


# ============================================================ self-test
def _self_test(log=print):
    """Every planted control, each with the verdict it must flip."""
    fails = []

    def chk(name, cond, detail=""):
        log(f"  {'ok  ' if cond else 'FAIL'} {name}{('  ' + detail) if detail else ''}")
        if not cond:
            fails.append(name)

    def must_raise(name, fn, needle):
        try:
            fn()
        except Exception as e:
            ok = needle in str(e)
            log(f"  {'ok  ' if ok else 'FAIL'} {name}  ({type(e).__name__}: {str(e)[:72]})")
            if not ok:
                fails.append(name)
            return
        log(f"  FAIL {name}: it was ACCEPTED")
        fails.append(name)

    t0 = time.time()
    base = P.Base(P.PARTS_R)

    # --- d3.1: the no-op expansion is unrepresentable, and `identity` is the one exemption
    must_raise("d3.1 a candidate adding no vertex is refused",
               lambda: Candidate(frozenset(), "reserve"), "no-op-expansion")
    chk("d3.1 the identity candidate IS representable (control d6.5 needs it)",
        Candidate(frozenset(), "identity").n_new == 0)
    must_raise("an unknown provenance is refused",
               lambda: Candidate(frozenset({(1, 0, 0, 0)}), "guessing"), "unknown provenance")

    # --- the colour cache is keyed by lattice tuples, so it is portable across stages
    S136 = V.load_lattice(os.path.join(REF11, "v136e564.vtx"))
    L374 = V.load_lattice(os.path.join(REF11, "v374e1860.vtx"))
    A412 = V.load_lattice(os.path.join(REF11, "v412e2106.vtx"))
    st374 = PS.Stage(base, L374, S136, side="L", rung=1, pin=True)
    st412 = PS.Stage(base, A412, S136, side="L", rung=1, pin=True)
    lab374 = {tuple(l[1]): i for i, l in enumerate(st374.atom_labels)}
    lab412 = {tuple(l[1]): i for i, l in enumerate(st412.atom_labels)}
    common = sorted(set(lab374) & set(lab412))[:40]
    k374 = ColourCache.key(st374, [lab374[t] for t in common])
    k412 = ColourCache.key(st412, [lab412[t] for t in common])
    # The control is only discriminating if the two stages really DO index these points
    # differently -- otherwise "portable" is untested and the equality is a tautology.
    differ = [t for t in common if lab374[t] != lab412[t]]
    chk("the two stages index the same lattice points differently (so portability is testable)",
        len(differ) > 0, f"{len(differ)} of {len(common)} differ, e.g. {differ[:1]}: "
                         f"{[lab374[t] for t in differ[:1]]} vs {[lab412[t] for t in differ[:1]]}")
    chk("the colour cache key is portable across two stages with different index spaces",
        k374 == k412 and len(k374) == 40, f"{len(k374)} tuples, keys equal")
    cc = ColourCache("x")
    cc.put(k374, "unknown")
    chk("an `unknown` is never cached", cc.get(k374) is None and len(cc._d) == 0)

    # --- the restriction identity (Poros's per-entry invariant, planted over my own)
    orc = EdgeOracle(base, S136, log=log)
    # THE RESTRICTION IDENTITY (Poros's per-entry invariant, planted over my own vertex count).
    # An expanded stage contains the unexpanded one as an INDUCED subgraph on the original
    # vertices, so restricting its edges to those vertices must reproduce them exactly -- same
    # count and same pairs. It catches a wrong companion AND a wrong frame, which a vertex count
    # cannot, because both change cross edges among the ORIGINAL vertices.
    #
    # As first written this control FAILED at 1515 against 2442, and the cause was the very
    # mistake it exists to catch: two stages sort their own key lists, so vertex index `v` names
    # DIFFERENT lattice points in each, and I filtered the larger stage's integer edge pairs
    # through the smaller stage's bitmask. Compare by LABEL -- `(half, lattice tuple)` -- which is
    # the only vertex name a stage admits (`parts_stage.Stage.vertex_labels`).
    def edge_labels(st):
        return {tuple(sorted(e)) for e in (
            (("L" if u < st.A.n else "S", st.keys[u % st.A.n]),
             ("L" if v < st.A.n else "S", st.keys[v % st.A.n]))
            for u, v in st.A.induced(st.present))}

    def restriction(st_big, st_small):
        keep = set(st_small.vertex_labels(st_small.present))
        return {e for e in edge_labels(st_big) if e[0] in keep and e[1] in keep}
    E374 = edge_labels(st374)
    chk("the restriction identity holds: a larger stage's edges restrict to the smaller one's",
        restriction(st412, st374) == E374,
        f"{len(E374)} edges in the small stage, {len(restriction(st412, st374))} in the restriction")
    # and it must FAIL on a wrong companion -- otherwise it is not discriminating
    A166 = V.load_lattice(os.path.join(REF11, "v166e774.vtx"))
    stwrong = PS.Stage(base, A412, A166, side="L", rung=1, pin=True)
    chk("the restriction identity is DISCRIMINATING: a wrong companion breaks it",
        restriction(stwrong, st374) != E374,
        f"{len(restriction(stwrong, st374))} edges survive against the correct {len(E374)}")
    chk("the companion fingerprint separates the two companions",
        R.fp_tuples(S136) != R.fp_tuples(A166))

    # --- the menu census: the fills exemption, and the three readings nested
    cen = menu_census(base, A412, orc, log=log)
    a, b, c = (cen["a-strict"], cen["b-literal-internal"], cen["c-literal-plus-cross"])
    chk("the three readings are nested: strict <= internal <= plus-cross",
        a["reserve"] <= b["reserve"] <= c["reserve"],
        f"{a['reserve']} / {b['reserve']} / {c['reserve']}")
    chk("no orbit outside his r=2 disk is eligible, under ANY reading (P-D14, scored negative)",
        a["outside_disk_eligible"] == b["outside_disk_eligible"] ==
        c["outside_disk_eligible"] == 0)
    chk("the fills exemption is not vacuous on the large half",
        b["fills"] > 0, f"{b['fills']} partially occupied orbits, {b['fill_only']} below threshold")

    # --- the menu turns into candidates, and every candidate adds vertices A does not have
    cands = menu_candidates(base, A412, cen, shoulder=3)
    Aset = set(A412)
    chk("every candidate adds only ABSENT vertices, and adds at least one",
        all(c.n_new > 0 and not (c.vertices & Aset) for c in cands), f"{len(cands)} candidates")
    chk("the candidate count is the menu plus the shoulder",
        len(cands) == b["menu"] + b["shoulder"],
        f"{len(cands)} = {b['menu']} menu + {b['shoulder']} shoulder")
    chk("the fill-only candidates are flagged as such",
        sum(1 for c in cands if "fill-only" in c.flags) == b["fill_only"],
        f"{sum(1 for c in cands if 'fill-only' in c.flags)} flagged")

    # --- card 15: an `unknown` is never folded into a `no`, and the RATE is what must honour it
    planted = [{"verdict": "yes"}, {"verdict": "no"}, {"verdict": "unknown"},
               {"verdict": "not_run"}]
    d = density(planted)
    chk("d15 the base rate is over DECIDED candidates: an undecided is not a refusal",
        d["helpful_rate"] == 0.5 and d["decided"] == 2 and d["unknown"] == 1,
        f"rate {d['helpful_rate']} over {d['decided']} decided, {d['unknown']} undecided")
    d2 = density([{"verdict": "yes"}, {"verdict": "no"}, {"verdict": "no"}])
    chk("d15 control positive: with no undecided the rate is the naive one",
        d2["helpful_rate"] == round(1 / 3, 4), str(d2["helpful_rate"]))

    # --- the blocks: random first, and the identity candidate is planted as the map's own control
    work = plan_blocks(base, cands, cen, log=lambda *a: None)
    blocks = [b_ for b_, _, _ in work]
    chk("d6.5 the identity candidate is planted first, as block `control`",
        blocks[0] == "control" and work[0][2].n_new == 0)
    chk("the random block precedes his degree order (a truncation stays unbiased)",
        blocks.index("random") < blocks.index("his-degree-order"))
    chk("the shoulder is its own block, never folded into the menu",
        blocks.count("shoulder") == b["shoulder"] and blocks[-1] == "shoulder")
    chk("every candidate appears exactly once across the blocks",
        len(work) == len(cands) + 1 and
        len({c.name(base) for _, _, c in work}) == len(cands) + 1, f"{len(work)} jobs")

    log(f"\n{'ALL CONTROLS FIRED' if not fails else 'FAILED: ' + ', '.join(fails)}  "
        f"[{time.time()-t0:.0f}s]")
    return not fails


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--self-test", action="store_true", dest="selftest")
    sub = ap.add_subparsers(dest="cmd")
    c = sub.add_parser("census")
    c.add_argument("--A", default="v412e2106.vtx")
    c.add_argument("--companion", default="v136e564.vtx")
    c.add_argument("--out")
    m = sub.add_parser("map")
    m.add_argument("--A", default="v412e2106.vtx")
    m.add_argument("--companion", default="v136e564.vtx")
    m.add_argument("--anchor", default="v374e1860.vtx",
                   help="a known minimum of the UNEXPANDED stage; the per-candidate known-answer "
                        "anchor, two asks and no plant")
    m.add_argument("--incumbent", type=int, required=True,
                   help="the best known WEIGHT in atoms, so |M| = incumbent + 1 vertices")
    m.add_argument("--jobs", type=int, default=1)
    m.add_argument("--seed", type=int, default=20260911)
    m.add_argument("--shoulder", type=int, default=3)
    m.add_argument("--scoring-role", dest="role", required=True,
                   choices=["in-sample", "held-out"],
                   help="in-sample: the base rate is a measurement and the rule may be developed "
                        "against it, but no ranking claim may be read off it. held-out: the only "
                        "surface on which a beats-random claim may be made")
    m.add_argument("--no-secondary", action="store_true")
    m.add_argument("--limit", type=int, default=0,
                   help="run only the first N jobs of the block plan. Used for the FIRST "
                        "candidate alone and timed, before any parallel launch: parallel runs "
                        "contaminate the one cost datum every forecast rests on.")
    m.add_argument("--wall-ask", type=float, default=600.0)
    m.add_argument("--entries")
    m.add_argument("--out", required=True)
    m.add_argument("--dry-run", action="store_true")
    p = sub.add_parser("cost-probe")
    p.add_argument("--L", default="v412e2106.vtx")
    p.add_argument("--S", default="v136e564.vtx")
    p.add_argument("--known-minimum", dest="km", default="v374e1860.vtx")
    p.add_argument("--runs", type=int, default=3)
    p.add_argument("--near", type=int, default=20)
    p.add_argument("--out")
    a = ap.parse_args()
    if a.selftest:
        sys.exit(0 if _self_test() else 1)
    base = P.Base(P.PARTS_R)
    if a.cmd == "census":
        A = V.load_lattice(os.path.join(REF11, a.A))
        orc = EdgeOracle(base, V.load_lattice(os.path.join(REF11, a.companion)))
        out = menu_census(base, A, orc)
        out["A"] = a.A
        out["companion"] = a.companion
        out["provenance"] = R.provenance(config={"A": a.A, "companion": a.companion})
    elif a.cmd == "map":
        A = V.load_lattice(os.path.join(REF11, a.A))
        comp = V.load_lattice(os.path.join(REF11, a.companion))
        anchor = V.load_lattice(os.path.join(REF11, a.anchor))
        orc = EdgeOracle(base, comp)
        cen = menu_census(base, A, orc)
        cands = menu_candidates(base, A, cen, shoulder=a.shoulder)
        ent = a.entries or os.path.join(ROOT, "data", "m62", os.path.basename(a.out)[:-5])
        if a.dry_run:
            work = plan_blocks(base, cands, cen)
            print(f"map        {a.A} against {a.companion}, incumbent {a.incumbent} atoms "
                  f"(|M| = {a.incumbent + 1} vertices), target {a.incumbent - 1}")
            print(f"menu       {cen[ADOPTED_READING]['menu']} under {ADOPTED_READING} "
                  f"({cen[ADOPTED_READING]['fill_only']} fill-only, which his degree test misses) "
                  f"+ {cen[ADOPTED_READING]['shoulder']} shoulder at degree 3 = {len(cands)}")
            print(f"jobs       {len(work)} including the identity control; {a.jobs} workers")
            print(f"role       {a.role}")
            print(f"forecast   at the D0 rates (0.055 s colourable / 0.138 s refusing, measured "
                  f"under load 9) a candidate is phase 1 at ~55 s plus 800-1600 correction sets "
                  f"at ~1.2 s: 17-33 min each, so {len(work)} candidates is "
                  f"{len(work)*17//60}-{len(work)*33//60} core-hours, "
                  f"{len(work)*17//60//max(a.jobs,1)}-{len(work)*33//60//max(a.jobs,1)} h on "
                  f"{a.jobs} cores. The secondary decision adds an UNMEASURED factor; the first "
                  f"candidate measures it.")
            print(f"entries    {ent}/  (one file per candidate; an answered candidate is never "
                  f"re-asked, so a kill costs at most the candidates in flight)")
            print(f"writes     {a.out}")
            return
        out = run_map(base, A, comp, cands, cen, incumbent=a.incumbent, anchor_tuples=anchor,
                      entries_dir=ent, ckpt_dir=os.path.join(ROOT, "data", "m62", "ckpt"),
                      jobs=a.jobs, seed=a.seed, secondary=not a.no_secondary,
                      wall_ask=a.wall_ask, scoring_role=a.role, limit=a.limit)
    elif a.cmd == "cost-probe":
        out = cost_probe(base, a.L, a.S, a.km, runs=a.runs, near=a.near)
    else:
        ap.error("give a subcommand or --self-test")
    if a.out:
        os.makedirs(os.path.dirname(os.path.abspath(a.out)), exist_ok=True)
        with open(a.out + ".tmp", "w") as f:
            json.dump(out, f, indent=1)
        os.replace(a.out + ".tmp", a.out)
        print(f"wrote {a.out}")
    else:
        print(json.dumps({k: v for k, v in out.items() if k != "rows"}, indent=1)[:4000])


if __name__ == "__main__":
    main()
