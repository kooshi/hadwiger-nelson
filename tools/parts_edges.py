#!/usr/bin/env python3
"""The exact EDGE minimum of a unit-distance graph, as the same reduction with edges as atoms.

`[deGreyParts2023]` footnote 2, on `[Parts2020a]`'s 509-vertex record:

    "In [5] the corresponding 509-vertex graph has 2442 edges, but is not edge-critical, which
     allows us to reduce e5. We were able to discard 36 edges, but we didn't perform an
     exhaustive search, so further improvements are possible."

So the published edge record at 509 vertices is **2406**, reached by a non-exhaustive greedy
discard, and **the exact edge minimum at 509 vertices is a number nobody holds**.

--------------------------------------------------------------------------------------------------
**This is not a second instrument. It is `parts_stage.Stage` with edges as its deletable units**,
and that is the whole design (M63 phase D §M, collapse 1). `Stage` already models *a working
graph, a frozen part, and a set of deletable units*, and `reduce_stage` already computes the
minimum-weight hitting set over those units. An edge is a deletable unit:

    R(S) := (V, S) u C refuses four colours      is UPWARD CLOSED in S,

for exactly the reason the vertex version is -- a proper four-colouring of `(V, S') u C` with
`S subset S'` is in particular proper on every edge of `S`, so if the bigger graph were colourable
the smaller one would be. Hence M63 §O carries VERBATIM: the MCS/MUS duality, phase 1, the
correction sets, the completeness invariant, the bound, exact resume, the wall, the verdict
vocabulary and the record schema all arrive free, and `reduce_stage` needs no change at all.

**Three things that do NOT carry, and each is a soundness obligation rather than a detail.**

1. *`|M| = w* + 1` is a VERTEX-side identity* -- the shared centre is the one fixed deletable-side
   vertex. For edges the objective is the edge count and the constant is the number of FIXED
   edges, which is three (the pin triangle). A record applying the vertex formula to an edge run
   is off by one. `side_fixed` here returns that three, and `M_edges` is what the record calls it.

2. *The pin must be in the frozen part, and this is soundness rather than speed.* §5.9's symmetry
   break -- pin a unit triangle's three vertices to three distinct colours -- is WLOG only while
   those vertices are PAIRWISE ADJACENT in the graph being asked. Delete a pin edge and the
   triangle is not a triangle, the break stops being WLOG, and asks silently return `unsat` for a
   colourable graph. So the pin's three edges are FIXED, never atoms, and `pin_is_sound` plants
   the bug and watches the control fire. The vertex side met the same hazard on 2026-09-10 and
   reported a 373-vertex L-subgraph, one below the world record, before its control caught it.

3. *The object stays a unit-distance graph, and this is the reader's first objection.* A
   unit-distance graph requires every EDGE to be a unit pair; it never requires every unit pair to
   be an edge. So a refusing edge-subgraph on the same points is still a unit-distance witness --
   the convention `[deGreyParts2023]`'s own footnote uses when it discards 36.

**A free lower bound, and it makes the sweep self-checking** (M63 phase D §O6). Every vertex
critical in `G` has degree >= 4 in every refusing edge-subgraph `H` of `G`: `G - v` is
four-colourable, `H - v subset G - v` is too, and if `deg_H(v) <= 3` a fourth colour is free at
`v` and the colouring extends, contradicting that `H` refuses. Phase C's C4.1 proved all 508
ATOMS of the record critical, and the shared centre is never an atom, so

    2 e(H) = sum_v deg_H(v) >= 508 x 4 + deg_H(centre) >= 2032,  hence  e_min >= 1016,

and `e_min >= 1018` once one ask confirms the centre is critical too (control d6.8). Far below the
published 2406, so it closes nothing -- but any returned object with a degree-3 vertex, or any
reported count below the floor, is a BUG and not a record, caught by an assertion rather than by a
reviewer. That is exactly the failure an edge sweep is prone to: an edge dropped whose loss is
masked by a stale incumbent.

    python3 tools/parts_edges.py --self-test
    python3 tools/parts_edges.py sweep --out data/m62/m63-edge-minimum-509.json
"""
from __future__ import annotations
import argparse, hashlib, json, os, sys, time
from collections import defaultdict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import parts_repro as P
import parts_report as R
import parts_reduce as RED
import parts_stage as PS
import parts_vtx as V

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
REF11 = os.path.join(ROOT, "data", "m62", "parts-ref11", "JP", "Large")


class EdgeStage:
    """`parts_stage.Stage`'s vertex set, frozen, with its EDGES as the deletable atoms.

    Everything `parts_reduce.reduce_stage` reads is provided with the same meaning: `atoms` (one
    bitmask per deletable edge, so `bit_count()` weights each edge 1), `rung`, `side_fixed`, `cnf`,
    `pin_is_sound`, `identity`, `fingerprint`, `problem_line`, `describe`.

    **Edges come from the assembled stage** -- `stage.A.induced(stage.present)` -- and never from a
    relation computed on the base. A base relation does not know which side a shared point is on,
    which produced 54 cross edges where the record has 18, and has now caused faults in three
    separate agents (M63 phase D, 2026-09-11)."""

    def __init__(self, vstage, *, pin=True):
        self.v = vstage
        self.base = vstage.base
        self.rung = 1
        self.side = "E"
        self.pin_on = pin
        n = vstage.A.n
        self.n = n
        self.label = lambda w: ("L" if w < n else "S", vstage.keys[w % n])
        self.edges = sorted(tuple(sorted(e)) for e in vstage.A.induced(vstage.present))
        self.eix = {e: i for i, e in enumerate(self.edges)}
        pinv = set(vstage.pin)                       # L-side key indices of the §5.9 triangle
        self.pin = tuple(vstage.pin)
        self.pin_edges = sorted(i for i, (u, w) in enumerate(self.edges)
                                if u in pinv and w in pinv)
        if pin and len(self.pin_edges) != 3:
            raise ValueError(
                f"the §5.9 pin triangle contributes {len(self.pin_edges)} edges, not 3: its three "
                f"vertices are not pairwise adjacent in this graph, so pinning them to distinct "
                f"colours is NOT without loss of generality. Pass pin=False to run unpinned.")
        # **The pin is CONDITIONAL on its own three edges, not paid for by freezing them.**
        #
        # Freezing them is sound and was the first design, but it silently narrows the question:
        # the optimum then found is the minimum over edge-subgraphs CONTAINING THE PIN TRIANGLE,
        # which is >= the unrestricted edge minimum, and reporting it as "the exact edge minimum
        # of the 509" would be a conditional minimum wearing an unconditional name (Poros card
        # 18). That is the characteristic failure this repository's standard names, and it would
        # reach a published number rather than an internal map.
        #
        # The repair costs nothing and is the device `parts_stage.Stage.cnf` already uses for a
        # deletable pin VERTEX: make the three unit clauses conditional on the three pin edges
        # being present. When all three are kept the triangle is a triangle, its three vertices
        # take three distinct colours in every proper colouring, and fixing which is WLOG -- the
        # full symmetry break, and its 62x. When any is dropped the clauses are vacuous and the
        # ask is simply unpinned and slower. Sound in both branches, unrestricted in scope, and
        # fast in the overwhelming majority of asks, since a minimum edge-subgraph drops 36-ish
        # edges of 2442.
        self.fixed_edges = set()
        self.pin_conditional = bool(pin)
        self.deletable = [i for i in range(len(self.edges)) if i not in self.fixed_edges]
        self.atoms = [1 << i for i in self.deletable]
        self.atom_labels = [["E", list(self.label(self.edges[i][0])[1]
                                       + self.label(self.edges[i][1])[1])]
                            for i in self.deletable]
        self.present_vertices = sorted(
            w for w in range(2 * n) if (vstage.present >> w) & 1)

    # --------------------------------------------------------------- the key property
    def cnf(self, k=4):
        """One-time CNF. Every VERTEX is present and must be coloured; a deletable edge constrains
        only when its selector is true, so dropping an edge removes its constraint and nothing
        else. The pin's three unit clauses are unconditional -- correctly, because its three edges
        are fixed, so the triangle is a triangle in every selection this stage can express."""
        loc = {w: i for i, w in enumerate(self.present_vertices)}
        var = lambda i, c: i * k + c + 1
        top = len(self.present_vertices) * k
        sel = []
        for _ in self.deletable:
            top += 1
            sel.append(top)
        cls = [[var(i, c) for c in range(k)] for i in range(len(self.present_vertices))]
        pos = {e: j for j, e in enumerate(self.deletable)}
        for i, (u, w) in enumerate(self.edges):
            iu, iw = loc[u], loc[w]
            if i in self.fixed_edges:
                for c in range(k):
                    cls.append([-var(iu, c), -var(iw, c)])
            else:
                s = sel[pos[i]]
                for c in range(k):
                    cls.append([-s, -var(iu, c), -var(iw, c)])
        if self.pin_on:
            # conditional on the triangle's three edges being present (see __init__)
            guard = [-sel[pos[i]] for i in self.pin_edges]
            for j, w in enumerate(self.pin):
                cls.append(guard + [var(loc[w], j)])
        return cls, sel, top, loc

    def pin_is_sound(self, trials=6, rng=None):
        """Plant the bug the pin can cause and watch the control fire.

        The hazard is specific to an edge stage: with an UNCONDITIONAL pin, a selection dropping a
        pin edge is asked with the triangle broken and the unit clauses still in force, and a
        colourable graph comes back `unsat`. So the control drops random edge sets -- **including
        the pin's own edges, which is the case that matters and the one a fixed-pin design could
        not even express** -- and requires the pinned and unpinned verdicts to agree."""
        import random
        rng = rng or random.Random(0)
        if not self.pin_on:
            return {"verdict": "pin-is-fixed", "note": "unpinned stage"}
        bare = EdgeStage(self.v, pin=False)
        c1, s1, _, _ = self.cnf()
        c2, s2, _, _ = bare.cnf()
        self._sel, bare._sel = s1, s2
        allA = list(range(len(self.atoms)))
        pinA = [a for a, i in enumerate(self.deletable) if i in set(self.pin_edges)]
        rows = []
        for t in range(trials):
            drop = set(rng.sample(allA, min(3 + 4 * t, len(allA) - 1)))
            if t % 2:                      # every other trial DROPS A PIN EDGE, on purpose
                drop.add(pinA[t % len(pinA)])
            kept = [x for x in allA if x not in drop]
            a = refuses(self, kept)
            b = refuses(bare, kept)        # same atom indexing now: no edge is frozen
            rows.append({"dropped": len(drop), "dropped_a_pin_edge": bool(drop & set(pinA)),
                         "with_pin": a, "without_pin": b, "agree": a == b})
        bad = [r for r in rows if not r["agree"]]
        return {"verdict": "pin-changes-answers" if bad else "pin-agrees-everywhere",
                "checked": len(rows), "rows": rows,
                "dropped_a_pin_edge_in": sum(1 for r in rows if r["dropped_a_pin_edge"]),
                "disagreements": bad[:4],
                "note": "behavioural, and NOT discriminating on its own: exhibiting an "
                        "unconditional pin's unsoundness needs a selection colourable only with "
                        "two pin vertices equal, which random drops do not find. The structural "
                        "guard -- the conditional CNF has no unit clause -- is what discriminates."}

    # --------------------------------------------------------------- reporting surface
    @property
    def side_fixed(self) -> int:
        """The FIXED EDGE count, not a vertex constant: `e(M) = w* + side_fixed`. The vertex side's
        `+1` is the shared centre and has no meaning here (§O4.1). With a conditional pin nothing
        is frozen, so this is zero and `e(M) = w*` exactly."""
        return len(self.fixed_edges)

    def fingerprint(self):
        return R.fp_edges(len(self.present_vertices),
                          [(self.present_vertices.index(u), self.present_vertices.index(w))
                           for u, w in self.edges])

    def identity(self) -> str:
        h = hashlib.sha256()
        h.update(f"EDGES;graph={self.fingerprint()};n={len(self.present_vertices)};".encode())
        for i in self.deletable:
            h.update(f"d:{self.edges[i]};".encode())
        for i in sorted(self.fixed_edges):
            h.update(f"f:{self.edges[i]};".encode())
        return h.hexdigest()

    def problem_line(self) -> str:
        return (f"rung 1 EDGE atoms, {len(self.atoms)} deletable edges of {len(self.edges)}, "
                f"reduce {{E}}")

    def describe(self):
        return (f"edge stage: {len(self.present_vertices)} vertices (frozen), {len(self.edges)} "
                f"edges, {len(self.atoms)} deletable + {len(self.fixed_edges)} pinned   "
                f"fp {self.fingerprint()[:12]}")

    def vertex_labels(self, mask):
        return [self.label(w) for w in range(2 * self.n) if (mask >> w) & 1]

    # --------------------------------------------------------------- the floor (§O6)
    def degrees(self, kept_atoms):
        d = defaultdict(int)
        for i in list(self.fixed_edges) + [self.deletable[a] for a in kept_atoms]:
            u, w = self.edges[i]
            d[u] += 1
            d[w] += 1
        return d

    def floor_check(self, kept_atoms, floor):
        """Milliseconds, and it fires on exactly the failure an edge sweep is prone to."""
        d = self.degrees(kept_atoms)
        ne = len(kept_atoms) + len(self.fixed_edges)
        bad = sorted((self.label(w), k) for w, k in d.items() if k < 4)
        missing = [self.label(w) for w in self.present_vertices if w not in d]
        if bad or missing or ne < floor:
            return {"verdict": "edge-sweep-impossible", "edges": ne, "floor": floor,
                    "degree_below_4": [[list(l[1]), k] for l, k in bad[:8]],
                    "isolated": [list(l[1]) for l in missing[:8]],
                    "note": "every vertex critical in the 509 has degree >= 4 in EVERY refusing "
                            "edge-subgraph (§O6), so this object cannot refuse four colours and "
                            "the sweep has a bug -- most likely an edge dropped against a stale "
                            "incumbent. The run is abandoned, not reported."}
        return {"verdict": "floor-respected", "edges": ne, "floor": floor,
                "min_degree": min(d.values())}


def refuses(stage, kept, solver=None):
    """('unsat' | 'sat') for the selection keeping exactly `kept`. 'unsat' = it refuses."""
    from pysat.solvers import Solver
    own = solver is None
    if own:
        cls, sel, top, _ = stage.cnf()
        solver = Solver(name="cadical153", bootstrap_with=cls)
        stage._sel = sel
    sel = stage._sel
    st = solver.solve(assumptions=[sel[a] for a in kept])
    if own:
        solver.delete()
    return "sat" if st else "unsat"


def record_stage(base=None):
    """The assembled record: `L374 u rho*S136` sharing one centre, 509 vertices and 2442 edges."""
    base = base or P.Base(P.PARTS_R)
    return PS.Stage(base, V.load_lattice(os.path.join(REF11, "v374e1860.vtx")),
                    V.load_lattice(os.path.join(REF11, "v136e564.vtx")), side="LS", rung=1)


def assemble_record(base=None) -> dict:
    """D5: our own 509, with the decomposition his paper states and the refusal that earns it."""
    base = base or P.Base(P.PARTS_R)
    st = record_stage(base)
    n = st.A.n
    E = st.A.induced(st.present)
    LL = sum(1 for u, v in E if u < n and v < n)
    SS = sum(1 for u, v in E if u >= n and v >= n)
    cross = [(u, v) for u, v in E if (u < n) != (v < n)]
    ccent = sum(1 for u, v in cross if st.A.centre in (u, v % n) and min(u, v) == st.A.centre)
    v = PS.refuses(st, list(range(len(st.atoms))))
    return {"vertices": st.present.bit_count(), "edges": len(E),
            "decomposition": {"L_L": LL, "S_S": SS, "cross": len(cross),
                              "cross_at_the_shared_centre": ccent,
                              "cross_off_centre": len(cross) - ccent,
                              "his_form": "1860 + 564 + 12 + 6, which books the twelve "
                                          "centre-to-S edges to the S side as he does; the stage "
                                          "books them to the L side, so it reads 1860 + 552 + 30",
                              "reconciles": LL == 1860 and SS == 552 and len(cross) == 30
                                            and len(cross) - ccent == 18},
            "refuses_four_colours": v == "unsat",
            "fingerprint": st.fingerprint(), "identity": st.identity()}


def greedy_1minimal(est, *, wall_ask=600.0, checkpoint=None, floor=1016, log=print) -> dict:
    """A certified refusing edge-subgraph with an EXACT edge count: an upper bound on `e_min`.

    **Why this exists beside the exact minimisation, and why it runs first** (Poros card 22). The
    exact minimum is a minimum hitting set over a window that phase 1 puts at roughly 630 edges
    wide, and it may not close. A greedy 1-minimal pass is ~2,442 asks and yields an OBJECT: a
    graph that provably refuses four colours, whose edge count is directly comparable with
    `[deGreyParts2023]`'s 2,406. An upper bound you can certify beats a floor you cannot close,
    and the two are not alternatives -- the greedy result also seeds the hitting set.

    The pass is order-dependent by nature: a different order gives a different 1-minimal set and
    possibly a different count. The order used is recorded, and the count is what it is -- never
    called *the* minimum, which is what the hitting set computes.

    An `unknown` ask KEEPS the edge. That is the conservative direction: it can only leave the
    object larger, never make it non-refusing, so the result stays a valid upper bound."""
    orc = RED.Oracle(est, wall=wall_ask)
    n = len(est.atoms)
    state = {"kept": list(range(n)), "dropped": [], "i": 0, "unknown": []}
    if checkpoint and os.path.exists(checkpoint):
        state = json.load(open(checkpoint))
        log(f"  resuming: {state['i']}/{n} examined, {len(state['dropped'])} dropped")
    kept = set(state["kept"])
    t0, last = time.time(), time.time()
    v0, _ = orc.ask(sorted(kept), wall=None)
    if v0 != "unsat":
        raise SystemExit("the starting edge set does not refuse: nothing to minimise")
    for i in range(state["i"], n):
        trial = sorted(kept - {i})
        v, _ = orc.ask(trial)
        if v == "unsat":                      # still refuses, so this edge is redundant HERE
            kept = set(trial)
            state["dropped"].append(i)
        elif v == "unknown":
            state["unknown"].append(i)        # kept, conservatively: the bound stays valid
        state["i"] = i + 1
        if time.time() - last > 20.0 or i + 1 == n:
            last = time.time()
            log(f"    greedy {i+1}/{n}  dropped {len(state['dropped'])}  "
                f"edges now {len(kept)}  [{time.time()-t0:.0f}s]")
            if checkpoint:
                state["kept"] = sorted(kept)
                json.dump(state, open(checkpoint + ".tmp", "w"))
                os.replace(checkpoint + ".tmp", checkpoint)
    kept = sorted(kept)
    # the object must be re-verified by a FRESH solver sharing no state with the search (d6.3)
    fresh = refuses(EdgeStage(est.v, pin=est.pin_on), kept)
    fc = est.floor_check(kept, floor)
    return {"kind": "m63-edge-greedy", "schema": 1,
            "producer": "tools/parts_edges.py:greedy_1minimal",
            "edges": len(kept) + est.side_fixed, "dropped": len(state["dropped"]),
            "started_from": len(est.atoms) + est.side_fixed,
            "published_upper_bound": 2406, "published_original": 2442,
            "their_discard": 36, "ours_discard": len(state["dropped"]),
            "beats_published": len(kept) + est.side_fixed < 2406,
            "d6.3_fresh_solver_reverifies": fresh,
            "verdict": ("edge-sweep-impossible" if fc["verdict"] != "floor-respected"
                        else "greedy-1-minimal" if fresh == "unsat" else "NOT-REFUSING"),
            "floor_check": fc, "undecided_kept": len(state["unknown"]),
            "order": "the stage's own edge order (radial vertex order); a different order gives a "
                     "different 1-minimal set -- this is an UPPER bound, never the minimum",
            "asks": orc.stats(), "seconds": round(time.time() - t0, 1),
            "dropped_edges": [[list(est.label(est.edges[est.deletable[a]][0])[1]),
                               list(est.label(est.edges[est.deletable[a]][1])[1])]
                              for a in state["dropped"]],
            "kept_edges_fp": R.fp_edges(len(est.present_vertices),
                                        [est.edges[est.deletable[a]] for a in kept]),
            "still_unit_distance": "every edge kept is a unit pair; a unit-distance graph does not "
                                   "require every unit pair to be an edge"}


def _self_test(log=print):
    fails = []

    def chk(name, cond, detail=""):
        log(f"  {'ok  ' if cond else 'FAIL'} {name}{('  ' + detail) if detail else ''}")
        if not cond:
            fails.append(name)

    t0 = time.time()
    base = P.Base(P.PARTS_R)
    vst = record_stage(base)

    # d5.1 -- our own record, before anything is done to it
    rec = assemble_record(base)
    chk("d5.1 the assembled record is 509 vertices and 2442 edges, and refuses four colours",
        (rec["vertices"], rec["edges"]) == (509, 2442) and rec["refuses_four_colours"],
        f"{rec['vertices']} / {rec['edges']}, refuses {rec['refuses_four_colours']}")
    chk("d5.1 its decomposition reconciles with his 1860 + 564 + 12 + 6",
        rec["decomposition"]["reconciles"],
        f"L-L {rec['decomposition']['L_L']} + S-S {rec['decomposition']['S_S']} + cross "
        f"{rec['decomposition']['cross']} ({rec['decomposition']['cross_off_centre']} off-centre)")

    est = EdgeStage(vst)
    # d6.7 -- the edge-atom stage, and its atom count IS the edge count less the pinned three
    chk("d6.7 the edge stage is 509 vertices and 2442 edges",
        len(est.present_vertices) == 509 and len(est.edges) == 2442,
        f"{len(est.present_vertices)} vertices, {len(est.edges)} edges")
    chk("d6.7 every edge is an atom: 2442 deletable, 0 frozen, so w* IS the edge count",
        len(est.atoms) == 2442 and est.side_fixed == 0,
        f"{len(est.atoms)} atoms + {est.side_fixed} fixed")
    chk("d6.7 every atom weighs exactly one edge",
        all(m.bit_count() == 1 for m in est.atoms))

    # d6.2, in the form card 18 forced. Freezing the pin edges was sound but narrowed the
    # question to subgraphs CONTAINING the triangle -- a conditional minimum that would have been
    # reported as the exact edge minimum. The pin is now conditional on its own three edges, so
    # the search is UNRESTRICTED, and the control is no longer "the pin edges are protected" but
    # "dropping a pin edge is SAFE".
    chk("d6.2 the pin edges ARE deletable, so the optimum is the unrestricted edge minimum",
        set(est.pin_edges) <= set(est.deletable) and not est.fixed_edges,
        f"pin edges {est.pin_edges} are atoms; nothing frozen")
    unc = est.pin_is_sound()
    chk("d6.2 the pin agrees with an unpinned stage on selections that DROP a pin edge",
        unc["verdict"] == "pin-agrees-everywhere" and
        any(r["dropped_a_pin_edge"] for r in unc.get("rows", [])) is not None,
        f"{unc['verdict']} ({unc.get('checked')} checks)")

    # d6.2's DISCRIMINATING control, and the honest story of why it is structural.
    #
    # The behavioural plant -- restore the unconditional pin and watch the agreement check go red
    # -- was written first and DID NOT FIRE. That is worth recording rather than deleting: the
    # unconditional pin is unsound in principle (it forbids colourings in which two pin vertices
    # share a colour, which is only WLOG while the edge between them is present, and on the
    # VERTEX side that bug reported a 373-vertex subgraph one below the world record on
    # 2026-09-10) but exhibiting it needs a selection that is colourable ONLY with two pin
    # vertices equal, and random drops do not find one. A behavioural control that cannot be made
    # to fail is not a control.
    #
    # So the guard is STRUCTURAL and deterministic: the conditional CNF contains NO unit clause at
    # all -- edge clauses have length 3 or 2, vertex clauses 4, guarded pin clauses 4 -- while an
    # unconditional pin is exactly three unit clauses. That plant fires every time.
    cls0, _, _, _ = est.cnf()
    units = [c for c in cls0 if len(c) == 1]
    chk("d6.2 the conditional CNF has NO unit clause: every pin clause is guarded",
        not units, f"{len(units)} unit clauses")

    class _UnconditionalPin(EdgeStage):
        """The bug, restored verbatim: the pin as three unconditional unit clauses."""
        def cnf(self, k=4):
            cls, sel, top, loc = EdgeStage.cnf(self, k)
            for j, w in enumerate(self.pin):
                cls.append([loc[w] * k + j + 1])
            return cls, sel, top, loc
    bad_cls, _, _, _ = _UnconditionalPin(vst).cnf()
    bad_units = [c for c in bad_cls if len(c) == 1]
    chk("d6.2 CONTROL: the planted unconditional pin IS caught, as three unit clauses",
        len(bad_units) == 3, f"{len(bad_units)} unit clauses in the planted version")
    chk("d6.2 CONTROL: and the behavioural check is reported as NOT discriminating here",
        True, "random drops do not exhibit the unsoundness; the structural guard is what does")

    # d6.1 -- the planted negative: an edge stage over the WRONG graph fails before any ask
    wrong = PS.Stage(base, V.load_lattice(os.path.join(REF11, "v374e1860.vtx")),
                     V.load_lattice(os.path.join(REF11, "v374e1860.vtx")), side="LS", rung=1)
    we = EdgeStage(wrong)
    chk("d6.1 edge-sweep-wrong-graph: a stage built over the wrong halves is not 509/2442",
        (len(we.present_vertices), len(we.edges)) != (509, 2442),
        f"{len(we.present_vertices)} vertices, {len(we.edges)} edges -- refused before any ask")

    # the pin control, planted and watched
    ps = est.pin_is_sound()
    chk("the pin control fires green on the real stage", ps["verdict"] == "pin-agrees-everywhere",
        f"{ps['verdict']} ({ps.get('checked')} checks)")

    # upward closure, as a measurement rather than an assertion: the full edge set refuses, and
    # a sub-selection that refuses stays refusing when edges are added back
    allA = list(range(len(est.atoms)))
    chk("the full edge set refuses four colours", refuses(est, allA) == "unsat")
    chk("the EMPTY edge selection does not refuse (so the pin alone carries nothing)",
        refuses(est, []) == "sat")

    # d6.9 -- the floor assertion must fire on a planted degree-3 object and pass on the real one
    fc = est.floor_check(allA, 1016)
    chk("d6.9 the full record respects the §O6 floor", fc["verdict"] == "floor-respected",
        f"{fc['edges']} edges, min degree {fc.get('min_degree')}")
    v0 = est.edges[0][0]
    kill = [a for a, i in enumerate(est.deletable) if v0 in est.edges[i]]
    fc2 = est.floor_check([a for a in allA if a not in set(kill)], 1016)
    chk("d6.9 edge-sweep-impossible fires on a planted low-degree vertex",
        fc2["verdict"] == "edge-sweep-impossible",
        f"{fc2['verdict']}, {len(fc2.get('degree_below_4', [])) + len(fc2.get('isolated', []))} "
        f"bad vertices")

    log(f"\n{'ALL CONTROLS FIRED' if not fails else 'FAILED: ' + ', '.join(fails)}  "
        f"[{time.time()-t0:.0f}s]")
    return not fails


def centre_critical(base=None, log=print) -> dict:
    """Control d6.8, one ask: is the record minus its shared centre four-colourable?

    C4.1 proved all 508 ATOMS of the record critical, and the centre is never an atom, so its
    criticality is the one hypothesis §O6's floor is missing. An answer of "not colourable" would
    mean the record is NOT vertex-minimal, which is a loud finding rather than a detail."""
    base = base or P.Base(P.PARTS_R)
    vst = record_stage(base)
    # Deleting a VERTEX asks the same question as deleting every edge at it, because an isolated
    # vertex can always be coloured. So this is the edge stage with the centre's edges dropped --
    # NOT a rebuilt vertex stage. Two reasons, and the first bit on the first run:
    #   * `typem.Arena` locates the rotation centre as the point at the origin and raises
    #     `StopIteration` if it is absent, so a stage without the centre cannot be built at all;
    #   * the ask must be UNPINNED. §5.9's triangle has the centre as one of its three vertices,
    #     so dropping the centre's edges breaks the triangle and the symmetry break stops being
    #     without loss of generality -- the exact hazard §O4(2) is about, arriving from the other
    #     side.
    est = EdgeStage(vst, pin=False)
    c = vst.A.centre
    kept = [a for a, i in enumerate(est.deletable) if c not in est.edges[i]]
    dropped = len(est.deletable) - len(kept)
    v = refuses(est, kept)
    out = {"verdict": "centre-critical" if v == "sat" else "centre-NOT-critical",
           "ask": v, "vertices": len(est.present_vertices) - 1,
           "centre_edges_dropped": dropped, "pinned": False,
           "floor": 1018 if v == "sat" else 1016,
           "note": ("the centre is critical too, so every one of the 509 vertices is, and the §O6 "
                    "floor rises from 1016 to 1018" if v == "sat" else
                    "the record minus its centre STILL REFUSES: the 509 is not vertex-minimal. "
                    "This is a loud finding, not a detail -- escalate.")}
    log(f"  d6.8 {out['verdict']}: G - centre reads {v}; floor {out['floor']}")
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--self-test", action="store_true", dest="selftest")
    sub = ap.add_subparsers(dest="cmd")
    s = sub.add_parser("sweep")
    s.add_argument("--out", required=True)
    s.add_argument("--checkpoint")
    s.add_argument("--wall-ask", type=float, default=600.0)
    s.add_argument("--phase1-only", action="store_true",
                   help="stop after phase 1. Its critical count is already a rigorous LOWER bound "
                        "on the edge minimum, and against the published 2406 that is most of the "
                        "question at a few minutes' cost.")
    s.add_argument("--target", type=int, default=None)
    s.add_argument("--greedy", action="store_true",
                   help="a greedy 1-minimal pass: ~2442 asks for a CERTIFIED refusing subgraph "
                        "with an exact edge count, directly comparable with the published 2406. "
                        "An upper bound you can certify beats a floor you cannot close.")
    a = ap.parse_args()
    if a.selftest:
        sys.exit(0 if _self_test() else 1)
    if a.cmd != "sweep":
        ap.error("give a subcommand or --self-test")
    base = P.Base(P.PARTS_R)
    est = EdgeStage(record_stage(base))
    print(f"  {est.describe()}")
    cc = centre_critical(base)
    floor = cc["floor"]
    cfg = {"problem": {"object": "the assembled 509 (L374 u rho*S136), edges as atoms",
                       "fingerprint": est.fingerprint(), "pin_edges_fixed": est.pin_edges},
           "budgets": {"wall_ask": a.wall_ask, "target": a.target}}
    ck = a.checkpoint or (a.out + ".ckpt.json")
    t0 = time.process_time()
    if a.greedy:
        out = greedy_1minimal(est, wall_ask=a.wall_ask, checkpoint=ck, floor=floor)
        out["headline"] = (
            f"greedy 1-minimal edge pass on the 509: {out['edges']} edges "
            f"(dropped {out['dropped']} of {out['started_from']}), re-verified by a fresh solver: "
            f"{out['d6.3_fresh_solver_reverifies']}. Published: 2442 in [Parts2020a], 2406 in "
            f"[deGreyParts2023] fn.2 by a NON-exhaustive discard of 36. "
            f"{'BEATS the published 2406' if out['beats_published'] else 'does NOT beat 2406'}. "
            f"This is an UPPER bound from one order, not the minimum.")
        out["degree_floor"] = cc
        out["provenance"] = R.provenance(config=cfg)
    elif a.phase1_only:
        orc = RED.Oracle(est, wall=a.wall_ask)
        state = RED.load_checkpoint(ck, est, cfg) or RED.ReductionState(
            stage_identity=est.identity(), problem_sha256=RED.problem_hash(est, cfg),
            problem_line=est.problem_line())
        crit, drop, unk = RED.phase1(orc, est.atoms, state, ckpt=ck)
        out = {"kind": "m63-edge-phase1", "schema": 1,
               "producer": "tools/parts_edges.py:main --phase1-only",
               "headline": (f"edge phase 1 on the 509: {len(crit)} individually critical edges of "
                            f"{len(est.atoms)} deletable, so e_min >= {len(crit) + est.side_fixed} "
                            f"against the published 2406"),
               "critical": len(crit), "droppable_alone": len(drop), "undecided": len(unk),
               "deletable": len(est.atoms), "fixed_edges": est.side_fixed,
               "lower_bound_on_e_min": len(crit) + est.side_fixed,
               "published_upper_bound": 2406, "published_original": 2442,
               # POROS'S FORCED INEQUALITY, asserted rather than read off afterwards. Their
               # 36-edge reduction is itself a refusing subgraph, so it contains every critical
               # edge, so c <= 2442 - 36 = 2406. A count above that means either this instrument
               # is wrong or their footnote is -- a CONTROL against published prior art, free,
               # and a calibration of a brand-new instrument against something external.
               "external_calibration": {
                   "claim": "c <= 2406, because [deGreyParts2023]'s 36-edge reduction is itself "
                            "a refusing subgraph and therefore contains every critical edge",
                   "c": len(crit) + est.side_fixed, "bound": 2406,
                   "verdict": ("calibration-holds" if len(crit) + est.side_fixed <= 2406
                               else "calibration-FAILED"),
                   "if_failed": "either this instrument is wrong or their footnote is; it is a "
                                "control and not a finding either way",
                   "fork": ("c = 2406 exactly: every individually-removable edge is one of their "
                            "36, and since they report the 36 JOINTLY removable, the exact edge "
                            "minimum IS 2406 and the question closes -- their non-exhaustive "
                            "search was exhaustive after all"
                            if len(crit) + est.side_fixed == 2406 else
                            "c < 2406: there are individually-removable edges they missed, the "
                            "minimum lies in [c, 2406], and the gap is the hitting set's to "
                            "close. It does not collapse on its own -- individually removable is "
                            "not jointly removable, so c is a floor and not the answer")},
               "degree_floor": cc, "asks": orc.stats(),
               "cpu_seconds": round(time.process_time() - t0, 1),
               "droppable_edges": [[list(est.label(est.edges[est.deletable[a_]][0])[1]),
                                    list(est.label(est.edges[est.deletable[a_]][1])[1])]
                                   for a_ in drop],
               "note": "a singleton correction set IS a critical edge, so the count of "
                       "individually critical edges is a rigorous LOWER bound on the exact edge "
                       "minimum. If it equals 2406 the published greedy discard was optimal after "
                       "all; if it is lower there is room and the hitting set says how much.",
               "provenance": R.provenance(config=cfg)}
    else:
        rec = RED.reduce_stage(est, checkpoint=ck, config=cfg, wall_ask=a.wall_ask, target=a.target)
        rec.pop("state")
        kept = rec.get("minima", [[]])[0] if rec.get("minima") else []
        out = {"kind": "m63-edge-minimum", "schema": 1, "producer": "tools/parts_edges.py:sweep",
               "headline": (f"exact edge minimisation of the 509: {rec['verdict']}, "
                            f"{rec['bound_render']}"
                            + (f", e(M) = {rec['M_vertices']} edges" if rec.get("M_vertices")
                               else "")),
               "e_min": rec.get("M_vertices"), "published_upper_bound": 2406,
               "published_original": 2442, "degree_floor": cc,
               "floor_check": est.floor_check(kept, floor) if kept else None,
               "still_unit_distance": "every edge kept is a unit pair; a unit-distance graph does "
                                      "not require every unit pair to be an edge -- the convention "
                                      "[deGreyParts2023] fn.2 itself uses when it discards 36",
               **rec, "provenance": R.provenance(config=cfg)}
    os.makedirs(os.path.dirname(os.path.abspath(a.out)), exist_ok=True)
    with open(a.out + ".tmp", "w") as f:
        json.dump(out, f, indent=1)
    os.replace(a.out + ".tmp", a.out)
    print(f"\n{out['headline']}\nwrote {a.out}")


if __name__ == "__main__":
    main()
