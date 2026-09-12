#!/usr/bin/env python3
"""Independent verification of an edge-reduced 509-vertex object, sharing NOTHING with the search.

The greedy pass (`parts_edges.greedy_1minimal`) returns an object and re-asks it with a fresh
solver. That is not enough for a number anybody would publish, for a reason the product owner and
the advisor (Poros card 27) reached independently on 2026-09-11:

  **"re-verified by a fresh solver sharing no state with the search" is not "re-verified without
  the symmetry-breaking device".**

The greedy pass's own re-check calls `refuses(EdgeStage(est.v, pin=est.pin_on), kept)` -- with
`pin_on` true, so the re-check is PINNED. The pin is sound (its unit clauses are conditional on the
three pin edges being present, `parts_edges.EdgeStage.cnf`), but that soundness is OUR argument,
and this is the one device in the chain with a prior failure in its own history: an unconditional
pin produced a 373-vertex L-subgraph -- one below the world record -- on 2026-09-10 before a
control caught it (`parts_stage.Stage.cnf` lines 196-203).

So this module re-derives the whole claim from the object alone, with five legs that share no code
with the search and no argument of ours:

  1. **the refutation is UNPINNED** -- a plain four-colouring CNF over the kept edges, no selector
     variables, no symmetry break, nothing conditional. Costs the 62x once, on one object.
  2. **a separate process and a different CaDiCaL** -- the toolchain's standalone `cadical` 2.1.2
     binary reading a DIMACS file off disk, not the in-process `pysat` cadical153 the search used.
  3. **an LRAT proof, checked by a checker written here** -- so the refutation does not rest on
     CaDiCaL's word either. RUP steps with hints, replayed against the DIMACS file.
  4. **exact geometry, re-derived from the coordinates** -- every kept edge re-checked as a unit
     pair in exact `K = Q(sqrt3, sqrt11)` arithmetic. The cross edges are re-derived from the
     STATED law (`typem.CrossLaw`'s docstring derivation) rather than by calling the committed
     edge builder, which would be circular.
  5. **the degree floor** (M63 phase D §O6) -- every vertex of a refusing edge-subgraph has degree
     >= 4, so a violation is a bug in the instrument and a HALT, never a finding.

And three controls, because a check that has only ever said "pass" is not known to work:
  c1  the untouched 509/2442 object refuses         (a known positive -- the instrument must agree)
  c2  the kept object minus one kept edge is COLOURABLE (the path can return SAT at all)
  c3  the kept object minus one vertex is COLOURABLE   (phase C's C4.1, independently)

**The count this produces is never called "the minimum".** A greedy pass is order-dependent; the
exact edge minimum is a minimum hitting set and a different computation.

    python3 tools/parts_edge_verify.py --self-test          # the whole chain on the full 509
    python3 tools/parts_edge_verify.py --greedy data/m62/m63-edge-greedy-509.json \
        --out data/m62/m63-edge-verify-509.json --controls
"""
from __future__ import annotations
import argparse, json, os, subprocess, sys, time
from collections import defaultdict
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import typem as T
import parts_repro as P
import parts_edges as PE
import parts_report as R

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CADICAL = os.path.join(os.path.expanduser("~"), ".elan", "toolchains",
                       "leanprover--lean4---v4.32.0", "bin", "cadical")
KONE = (Fr(1), Fr(0), Fr(0), Fr(0))
KZERO = (Fr(0), Fr(0), Fr(0), Fr(0))
PUBLISHED_UPPER = 2406          # [deGreyParts2023] fn. 2's state of the art at 509 vertices
PUBLISHED_ORIG = 2442           # [Parts2020a]'s own edge count


# ============================================================ leg 4: exact geometry
def _conj_mul(u, v):
    """`conj(u) * v` for two K-plane points read as complex numbers: returns `(p, q)` in K."""
    (x1, y1), (x2, y2) = u, v
    p = T.kadd(T.kmul(x1, x2), T.kmul(y1, y2))
    q = T.ksub(T.kmul(x1, y2), T.kmul(y1, x2))
    return p, q


def geometry_check(est, kept_atoms) -> dict:
    """Every kept edge re-checked as an exact unit pair, from the coordinates.

    Three edge classes and three arguments, each stated because each is a different claim:

      L-L   `|u - v|^2 = 1` in K, decided exactly on the 4-slot Fractions.
      S-S   the S half is `rho * (the same lattice)`, and **rho is a rotation, hence an isometry**,
            so `|rho u - rho v| = |u - v|` and the same exact test applies to the underlying
            lattice points. That is an argument, not a computation, and it is stated here so a
            reader can reject it rather than discover it.
      L-S   `|u - rho v|^2 = 1` cannot be decided in K directly, because `rho15`'s sine
            `sqrt15/4` leaves K. `typem.CrossLaw`'s derivation splits it over the basis
            `{1, sqrt(D)}` into two exact K-conditions: `q = 0` (u and v collinear with the
            centre) and `c*p = k`, with `conj(u)v = p + iq`, `k = (|u|^2 + |v|^2 - 1)/2`,
            `c = cos = 7/8`. **Re-implemented here from the derivation** rather than by calling
            `CrossLaw.edges`, which would check the edge builder against itself.
    """
    n = est.n
    pts = est.v.A.pts
    cos = est.v.cross_law.cos
    half = Fr(1, 2)
    bad, counts = [], defaultdict(int)
    for a in kept_atoms:
        u, w = est.edges[est.deletable[a]]
        if u < n and w < n:
            kind = "L-L"
            d2 = T.norm2((T.ksub(pts[u][0], pts[w][0]), T.ksub(pts[u][1], pts[w][1])))
            ok = d2 == KONE
        elif u >= n and w >= n:
            kind = "S-S"
            i, j = u - n, w - n
            d2 = T.norm2((T.ksub(pts[i][0], pts[j][0]), T.ksub(pts[i][1], pts[j][1])))
            ok = d2 == KONE
        else:
            kind = "L-S"
            lu, sv = (u, w - n) if u < n else (w, u - n)
            p, q = _conj_mul(pts[lu], pts[sv])
            k = tuple(x * half for x in T.ksub(T.kadd(T.norm2(pts[lu]), T.norm2(pts[sv])), KONE))
            ok = (q == KZERO) and (T.kmul(cos, p) == k)
        counts[kind] += 1
        if not ok:
            bad.append({"edge": [list(est.label(u)[1]), list(est.label(w)[1])], "kind": kind})
    return {"verdict": "every-kept-edge-is-an-exact-unit-pair" if not bad else "GEOMETRY-FAILS",
            "checked": len(kept_atoms), "by_class": dict(counts),
            "failures": bad[:8], "n_failures": len(bad),
            "arithmetic": "exact, in Q(sqrt3, sqrt11) 4-slot Fractions; no floating point",
            "cross_edge_note": "the L-S class is re-derived from CrossLaw's stated derivation, "
                               "not by calling the committed edge builder"}


# ============================================================ leg 5: the degree floor
def degree_floor(est, kept_atoms, floor_edges=1018) -> dict:
    """M63 phase D §O6, recomputed here from the kept edge list alone.

    Every vertex critical in the 509 has degree >= 4 in EVERY refusing edge-subgraph: `G - v` is
    four-colourable (phase C's C4.1, all 509), so if `deg_H(v) <= 3` a fourth colour is free at `v`
    and a colouring of `H - v` extends, contradicting refusal. A violation is therefore an
    instrument bug and a HALT, not a discovery."""
    d = defaultdict(int)
    for a in kept_atoms:
        u, w = est.edges[est.deletable[a]]
        d[u] += 1
        d[w] += 1
    present = est.present_vertices
    low = sorted((k, est.label(v)[1]) for v, k in d.items() if k < 4)
    missing = [est.label(v)[1] for v in present if v not in d]
    ne = len(kept_atoms) + len(est.fixed_edges)
    ok = not low and not missing and ne >= floor_edges
    return {"verdict": "floor-respected" if ok else "edge-sweep-impossible",
            "edges": ne, "floor": floor_edges, "vertices": len(present),
            "min_degree": min(d.values()) if d else 0,
            "degree_below_4": [[list(t), k] for k, t in low[:8]],
            "isolated": [list(t) for t in missing[:8]],
            "sum_of_degrees": sum(d.values())}


# ============================================================ legs 1-2: the unpinned CNF
def write_dimacs(est, kept_atoms, path, *, drop_vertex=None) -> dict:
    """A plain four-colouring CNF of the kept graph. **No selectors and no pin.**

    Variables `4i + c + 1` for the i-th present vertex and colour c. Clauses: one at-least-one per
    vertex, and `(-x_{u,c} or -x_{v,c})` per kept edge per colour. At-most-one clauses are not
    needed and are not added: the edge clauses force adjacent vertices' true-colour SETS to be
    disjoint, so reading any true colour off a model gives a proper colouring, and conversely a
    proper colouring is a model. UNSAT therefore means exactly "no proper four-colouring"."""
    verts = [v for v in est.present_vertices if v != drop_vertex]
    loc = {v: i for i, v in enumerate(verts)}
    var = lambda i, c: 4 * i + c + 1
    cls = [[var(i, c) for c in range(4)] for i in range(len(verts))]
    ne = 0
    for a in kept_atoms:
        u, w = est.edges[est.deletable[a]]
        if u not in loc or w not in loc:
            continue
        ne += 1
        for c in range(4):
            cls.append([-var(loc[u], c), -var(loc[w], c)])
    with open(path, "w") as f:
        f.write(f"p cnf {4 * len(verts)} {len(cls)}\n")
        f.write("".join(" ".join(map(str, c)) + " 0\n" for c in cls))
    return {"path": path, "vars": 4 * len(verts), "clauses": len(cls),
            "vertices": len(verts), "edges": ne, "pinned": False, "selectors": 0}


def run_cadical(cnf, proof=None, *, timeout=3600) -> dict:
    """The standalone binary, in its own process, reading the file off disk."""
    cmd = [CADICAL, "-q"]
    if proof:
        cmd += ["--lrat=true", "--binary=false"]
    cmd.append(cnf)
    if proof:
        cmd.append(proof)
    t0 = time.time()
    r = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout)
    st = {10: "sat", 20: "unsat"}.get(r.returncode, f"exit-{r.returncode}")
    return {"status": st, "seconds": round(time.time() - t0, 2),
            "solver": "cadical 2.1.2 (the toolchain binary, a separate process)",
            "proof": proof, "proof_bytes": os.path.getsize(proof) if proof and
                                            os.path.exists(proof) else None}


# ============================================================ leg 3: the LRAT checker
def check_lrat(cnf_path, lrat_path, *, log=print) -> dict:
    """Replay an LRAT proof against the DIMACS file. Written here, so the refutation does not rest
    on CaDiCaL's own word.

    Each addition is checked by reverse unit propagation with its hints: assign every literal of
    the new clause FALSE, then walk the hints in order, each of which must be unit or already
    falsified under the running assignment; a falsified hint is the conflict that closes the step.
    The proof is accepted only when the empty clause is derived.

    **RAT steps are not supported and are reported rather than skipped** -- a checker that
    silently passes what it cannot check is this repository's own named failure mode."""
    clauses, nv = {}, 0
    with open(cnf_path) as f:
        cid = 0
        for line in f:
            if not line or line[0] in "pc%":
                continue
            lits = [int(x) for x in line.split()[:-1]]
            cid += 1
            clauses[cid] = lits
    n_orig = cid
    steps = rat = deletions = 0
    empty = False
    t0 = time.time()
    with open(lrat_path) as f:
        for line in f:
            p = line.split()
            if len(p) < 2:
                continue
            if p[1] == "d":
                for x in p[2:-1]:
                    clauses.pop(int(x), None)
                deletions += 1
                continue
            i = p.index("0", 1)
            cid = int(p[0])
            lits = [int(x) for x in p[1:i]]
            hints = [int(x) for x in p[i + 1:-1]]
            if any(h < 0 for h in hints):
                rat += 1
                clauses[cid] = lits
                continue
            val = {}
            for l in lits:
                val[-l] = True
                val[l] = False
            conflict = False
            for h in hints:
                D = clauses.get(h)
                if D is None:
                    return {"verdict": "LRAT-CHECK-FAILS", "why": f"step {cid} cites deleted or "
                            f"unknown clause {h}", "steps": steps}
                unassigned, satisfied = [], False
                for l in D:
                    v = val.get(l)
                    if v is True:
                        satisfied = True
                        break
                    if v is None:
                        unassigned.append(l)
                if satisfied:
                    continue
                if not unassigned:
                    conflict = True
                    break
                if len(unassigned) > 1:
                    return {"verdict": "LRAT-CHECK-FAILS",
                            "why": f"step {cid}: hint {h} is neither unit nor falsified "
                                   f"({len(unassigned)} unassigned)", "steps": steps}
                u = unassigned[0]
                val[u] = True
                val[-u] = False
            if not conflict:
                return {"verdict": "LRAT-CHECK-FAILS",
                        "why": f"step {cid}: the hints did not produce a conflict", "steps": steps}
            clauses[cid] = lits
            steps += 1
            if not lits:
                empty = True
                break
    ok = empty and rat == 0
    return {"verdict": ("LRAT-PROOF-REPLAYED" if ok else
                        "LRAT-CHECK-INCOMPLETE" if rat else "LRAT-CHECK-FAILS"),
            "original_clauses": n_orig, "rup_steps_checked": steps, "deletion_lines": deletions,
            "rat_steps_unsupported": rat, "empty_clause_derived": empty,
            "seconds": round(time.time() - t0, 1),
            "checker": "tools/parts_edge_verify.py:check_lrat, RUP with hints, written for this "
                       "verification and sharing no code with CaDiCaL or pysat"}


# ============================================================ the chain
def verify(kept_atoms, *, scratch, controls=True, lrat=True, label="object", log=print) -> dict:
    est = PE.EdgeStage(PE.record_stage(), pin=False)     # UNPINNED from the start: leg 1
    n_kept = len(kept_atoms)
    out = {"kind": "m63-edge-verify", "schema": 1,
           "producer": "tools/parts_edge_verify.py:verify", "label": label,
           "vertices": len(est.present_vertices), "edges": n_kept + len(est.fixed_edges),
           "started_from": len(est.atoms) + len(est.fixed_edges),
           "published_upper_bound": PUBLISHED_UPPER, "published_original": PUBLISHED_ORIG,
           "pin": "NONE -- the CNF carries no symmetry break and no selector variable"}
    log(f"  {label}: {out['vertices']} vertices, {out['edges']} edges, unpinned")

    out["geometry"] = geometry_check(est, kept_atoms)
    log(f"  geometry   {out['geometry']['verdict']}  {out['geometry']['by_class']}")
    out["degree_floor"] = degree_floor(est, kept_atoms)
    log(f"  floor      {out['degree_floor']['verdict']}  min degree "
        f"{out['degree_floor']['min_degree']}")

    cnf = os.path.join(scratch, f"{label}.cnf")
    out["cnf"] = write_dimacs(est, kept_atoms, cnf)
    proof = os.path.join(scratch, f"{label}.lrat") if lrat else None
    out["refutation"] = run_cadical(cnf, proof)
    log(f"  cadical    {out['refutation']['status']}  {out['refutation']['seconds']}s  "
        f"proof {out['refutation']['proof_bytes']} bytes")
    if lrat and out["refutation"]["status"] == "unsat":
        out["lrat"] = check_lrat(cnf, proof, log=log)
        log(f"  lrat       {out['lrat']['verdict']}  {out['lrat']['rup_steps_checked']} steps  "
            f"{out['lrat']['seconds']}s")
        # The checker is new code carrying a publishable claim, so its five planted faults travel
        # IN THE ARTIFACT and not merely in a log (the product owner's ruling, 2026-09-11): a
        # checker nobody has broken on purpose is the failure pattern this phase has hit five
        # times, and the plants are part of the claim rather than a note about it.
        out["lrat_planted_faults"] = lrat_controls(scratch, log=log)

    if controls:
        c = {}
        # c2: dropping one KEPT edge must make it colourable -- the path can return SAT at all
        cut = [a for a in kept_atoms][:1]
        if cut:
            k2 = [a for a in kept_atoms if a != cut[0]]
            f2 = os.path.join(scratch, f"{label}-c2.cnf")
            write_dimacs(est, k2, f2)
            c["c2_minus_one_kept_edge"] = run_cadical(f2)
        # c3: dropping one vertex must make it colourable (phase C's C4.1, independently)
        v = est.present_vertices[-1]
        f3 = os.path.join(scratch, f"{label}-c3.cnf")
        write_dimacs(est, kept_atoms, f3, drop_vertex=v)
        c["c3_minus_one_vertex"] = run_cadical(f3)
        c["c3_vertex"] = list(est.label(v)[1])
        c["verdict"] = ("controls-fire" if all(
            x["status"] == "sat" for k, x in c.items() if isinstance(x, dict)) else
            "A-CONTROL-DID-NOT-FIRE")
        out["controls"] = c
        log(f"  controls   {c['verdict']}  " +
            "  ".join(f"{k}={x['status']}" for k, x in c.items() if isinstance(x, dict)))

    legs = [out["geometry"]["verdict"] == "every-kept-edge-is-an-exact-unit-pair",
            out["degree_floor"]["verdict"] == "floor-respected",
            out["refutation"]["status"] == "unsat",
            (not lrat) or out.get("lrat", {}).get("verdict") == "LRAT-PROOF-REPLAYED",
            (not controls) or out["controls"]["verdict"] == "controls-fire",
            (not lrat) or out.get("lrat_planted_faults", {}).get("verdict") == "every-plant-fires"]
    out["verdict"] = "verified-refusing-edge-subgraph" if all(legs) else "VERIFICATION-INCOMPLETE"
    out["legs"] = {"unpinned_cnf": True, "fresh_process_and_solver": True,
                   "exact_geometry": legs[0], "degree_floor": legs[1],
                   "cadical_unsat": legs[2], "lrat_replayed": legs[3], "controls": legs[4],
                   "lrat_checker_fails_on_planted_faults": legs[5]}
    out["not_the_minimum"] = ("a greedy 1-minimal pass is order-dependent; this is an edge-reduced "
                              "object at an exact count and an UPPER bound on the edge minimum, "
                              "never the minimum, which is a hitting set and a different question")
    out["not_yet_a_record"] = ("M63 §S.1 #4: a beat is called a record only once certified in the "
                               "Lean kernel (UDCert plus the LRAT chain on exact geometry). Until "
                               "then this is a number, not a record.")
    return out


def lrat_controls(scratch, *, log=print) -> dict:
    """**Make the checker fail, and watch it fail.** A checker that has only ever said `pass` is
    not known to work, and this one is new code written for a number somebody would publish.

    Five plants on a small instance whose answer is known -- `K5` is not four-colourable, and `K4`
    is -- each with the verdict it must produce:

      p0  the honest proof of the honest instance                  -> LRAT-PROOF-REPLAYED
      p1  a hint deleted from one step                             -> LRAT-CHECK-FAILS
      p2  a literal flipped inside one derived clause              -> LRAT-CHECK-FAILS
      p3  the last step (the empty clause) removed                 -> LRAT-CHECK-FAILS
      p4  the proof checked against a DIFFERENT instance's DIMACS  -> LRAT-CHECK-FAILS
          (the certificate filed against the wrong problem, which is this repository's own
           named control and the one an honest-looking pipeline passes by accident)
    """
    os.makedirs(scratch, exist_ok=True)
    k5 = os.path.join(scratch, "k5.cnf")
    with open(k5, "w") as f:
        cls = [[4 * i + c + 1 for c in range(4)] for i in range(5)]
        for i in range(5):
            for j in range(i + 1, 5):
                for c in range(4):
                    cls.append([-(4 * i + c + 1), -(4 * j + c + 1)])
        f.write(f"p cnf 20 {len(cls)}\n" + "".join(" ".join(map(str, c)) + " 0\n" for c in cls))
    other = os.path.join(scratch, "k5b.cnf")          # a different instance: K4, four-colourable
    with open(other, "w") as f:
        cls = [[4 * i + c + 1 for c in range(4)] for i in range(4)]
        for i in range(4):
            for j in range(i + 1, 4):
                for c in range(4):
                    cls.append([-(4 * i + c + 1), -(4 * j + c + 1)])
        f.write(f"p cnf 16 {len(cls)}\n" + "".join(" ".join(map(str, c)) + " 0\n" for c in cls))
    p0 = os.path.join(scratch, "k5.lrat")
    r = run_cadical(k5, p0)
    lines = open(p0).read().splitlines()
    adds = [i for i, l in enumerate(lines) if len(l.split()) > 1 and l.split()[1] != "d"]

    def variant(name, mutate):
        ls = list(lines)
        mutate(ls)
        p = os.path.join(scratch, f"k5-{name}.lrat")
        open(p, "w").write("\n".join(ls) + "\n")
        return check_lrat(k5, p)["verdict"]

    def drop_hint(ls):
        i = adds[len(adds) // 2]
        p = ls[i].split()
        z = p.index("0", 1)
        if len(p) > z + 2:
            del p[z + 1]
        ls[i] = " ".join(p)

    def flip_lit(ls):
        i = adds[len(adds) // 2]
        p = ls[i].split()
        z = p.index("0", 1)
        if z > 1:
            p[1] = str(-int(p[1]))
        ls[i] = " ".join(p)

    out = {"solver": r["status"],
           "p0_honest": check_lrat(k5, p0)["verdict"],
           "p1_hint_deleted": variant("p1", drop_hint),
           "p2_literal_flipped": variant("p2", flip_lit),
           "p3_empty_clause_removed": variant("p3", lambda ls: ls.pop(adds[-1])),
           "p4_wrong_problem": check_lrat(other, p0)["verdict"]}
    want = {"solver": "unsat", "p0_honest": "LRAT-PROOF-REPLAYED"}
    fired = (all(out[k] == v for k, v in want.items()) and
             all(out[k] != "LRAT-PROOF-REPLAYED" for k in
                 ("p1_hint_deleted", "p2_literal_flipped", "p3_empty_clause_removed",
                  "p4_wrong_problem")))
    out["verdict"] = "every-plant-fires" if fired else "A-PLANT-DID-NOT-FIRE"
    for k, v in out.items():
        log(f"  {k:28} {v}")
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--lrat-controls", action="store_true", dest="lratctl",
                    help="plant five faults in an LRAT proof and require the checker to catch each")
    ap.add_argument("--greedy", help="the greedy pass's artifact")
    ap.add_argument("--checkpoint", help="verify the greedy pass's checkpoint state instead")
    ap.add_argument("--full", action="store_true", help="verify the untouched 509/2442 object")
    ap.add_argument("--self-test", action="store_true", dest="selftest")
    ap.add_argument("--no-lrat", action="store_true")
    ap.add_argument("--no-controls", action="store_true")
    ap.add_argument("--scratch", default="/tmp/claude-1000/-home-kooshi-source-lean-dir/"
                                         "461b308c-55b7-48c5-b5df-641026e31b79/scratchpad/"
                                         "impl-phaseD2")
    ap.add_argument("--out")
    a = ap.parse_args()
    os.makedirs(a.scratch, exist_ok=True)
    if a.lratctl:
        r = lrat_controls(a.scratch)
        if a.out:
            json.dump(r, open(a.out, "w"), indent=1)
        return 0 if r["verdict"] == "every-plant-fires" else 1
    est = PE.EdgeStage(PE.record_stage(), pin=False)
    if a.selftest or a.full:
        kept = list(range(len(est.atoms)))
        label = "full509"
    elif a.checkpoint:
        st = json.load(open(a.checkpoint))
        kept = sorted(st["kept"])
        label = f"greedy-ckpt-{len(kept)}"
    else:
        g = json.load(open(a.greedy))
        kept = [i for i in range(len(est.atoms)) if i not in set(g["dropped_atoms"])] \
            if "dropped_atoms" in g else None
        if kept is None:
            ck = os.path.join(ROOT, "data", "m62", "ckpt", "m63-edge-greedy.ckpt.json")
            st = json.load(open(ck))
            kept = sorted(st["kept"])
            print(f"  the artifact carries no atom indices; taking the kept set from {ck}")
        label = "greedy509"
        fp = R.fp_edges(len(est.present_vertices),
                        [est.edges[est.deletable[x]] for x in kept])
        if g.get("kept_edges_fp") and g["kept_edges_fp"] != fp:
            raise SystemExit("the rebuilt kept set does not match the artifact's fingerprint: "
                             "this verification would be of a different object")
        print(f"  kept-edge fingerprint agrees with the artifact: {fp[:16]}")
    r = verify(kept, scratch=a.scratch, controls=not a.no_controls, lrat=not a.no_lrat,
               label=label)
    print(f"\n  VERDICT  {r['verdict']}   {r['edges']} edges on {r['vertices']} vertices")
    if a.out:
        json.dump(r, open(a.out, "w"), indent=1)
        print(f"  wrote {a.out}")
    return 0 if r["verdict"] == "verified-refusing-edge-subgraph" else 1


if __name__ == "__main__":
    sys.exit(main())
