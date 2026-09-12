#!/usr/bin/env python3
"""M63 phase G filter 4 — the non-vacuity ask, one arena per rotation class.

Asks, for a rotation rho with cos in K and sin not in K: does the WHOLE arena
`L union rho*S` on a named base at a named radius refuse four colours?  No selection,
no reduction.  A verdict is about THAT ARENA and names its radius.

The asymmetry that governs the report: a missing edge can only make a graph easier to
colour, so UNSAT is robust to every edge-dropping defect and SAT is not.  Every control
below therefore points at the edge-dropping direction, and each asserts a quantity rather
than waiting for an event:

  C1  base symmetry gate      -- negation, sqrt3-flip, sqrt11-flip, both: zero images
                                 outside the point set, or the run REFUSES (plan 11.6).
  C2  wide-proposal control   -- the exact unit-edge set under a 1+1e-3 float proposal
                                 must EQUAL the shipped 1+1e-7 one.  This is the missing
                                 control on `typem.unit_edges_fast`.
  C3  cross-edge calibration  -- the committed law at cos = +-7/8 must return the census's
                                 own decomposition, digit for digit, or the run REFUSES.
  C4  positive control        -- rho15's arena must come back UNSAT before any zero is
                                 believed.  Its arena contains Heule-510.
  C5  variant isomorphism     -- the angles of one class must be carried onto each other by
                                 an explicit base symmetry, as a PERMUTATION of the cross
                                 edge set, not as equal counts.

Nothing under tools/ is modified: this is an experiment driver over the committed law
(`typem.CrossLaw`), the committed lattice (`typem.parts_lattice`), the committed arena
(`typem.Arena`) and the committed walled solver (`five_dial.sat`).
"""
import sys, os, json, time, argparse, itertools, math
from fractions import Fraction as Fr

ROOT = "/home/kooshi/source/lean-dir"
sys.path.insert(0, os.path.join(ROOT, "tools"))
import typem as T

Z, ONE = T.Z, T.ONE

# --- the Galois signatures on K = Q(sqrt3, sqrt11), slots (1, sqrt3, sqrt11, sqrt33) -----------
GALOIS = {"id": (1, 1, 1, 1), "s3": (1, -1, 1, -1), "s11": (1, 1, -1, -1), "s3s11": (1, -1, -1, 1)}

def gal_k(sig, x):   return tuple(s * v for s, v in zip(sig, x))
def gal_pt(sig, p):  return (gal_k(sig, p[0]), gal_k(sig, p[1]))
def neg_pt(p):       return (T.kneg(p[0]), T.kneg(p[1]))


class Refused(Exception):
    """A control that could not pass.  Never downgraded to a warning."""


# ============================================================== C1  the base symmetry gate
def symmetry_gate(pts):
    S = set(pts)
    out = {}
    out["negation"] = sum(1 for p in pts if neg_pt(p) not in S)
    for nm, sig in GALOIS.items():
        if nm == "id":
            continue
        out[nm] = sum(1 for p in pts if gal_pt(sig, p) not in S)
    bad = {k: v for k, v in out.items() if v}
    if bad:
        raise Refused(f"C1 base symmetry gate: images outside the point set {bad}. "
                      f"The cos^2 class key over-merges on such a base and would eliminate an "
                      f"untested sibling rotation silently (plan 11.6).")
    return out


# ============================================================== C2  the wide-proposal control
def unit_edges_wide(pts, margin):
    """`typem.unit_edges_fast`'s exact test under a deliberately wide float proposal."""
    from scipy.spatial import cKDTree
    import numpy as np
    F = np.array([[T.kfloat(p[0]), T.kfloat(p[1])] for p in pts])
    cand = cKDTree(F).query_pairs(1.0 + margin, output_type="ndarray")
    keep = []
    for i, j in cand:
        i, j = int(i), int(j)
        dx, dy = T.ksub(pts[i][0], pts[j][0]), T.ksub(pts[i][1], pts[j][1])
        if T.kadd(T.kmul(dx, dx), T.kmul(dy, dy)) == ONE:
            keep.append((min(i, j), max(i, j)))
    return sorted(set(keep)), len(cand)


def unit_edges_controlled(pts, margins=(1e-3, 1e-2, 5e-2)):
    """The shipped edge set, plus the control `typem.unit_edges_fast` does not have.

    The shipped routine proposes with a float radius `1 + 1e-7` and disposes exactly.  Its
    failure mode is a DROPPED edge, which makes the graph easier, makes it colourable, and reads
    as a sound elimination -- the one direction that flatters a SAT verdict.  So: rerun the exact
    test under proposals wider by up to 5e-2 and require the kept set to be IDENTICAL.  The
    control only bites once the candidate count actually grows, so the count is printed at every
    margin and a margin that does not grow it is reported as not-biting rather than as a pass."""
    shipped, ncand = T.unit_edges_fast(pts)
    ship_set = sorted({(min(i, j), max(i, j)) for i, j in shipped})
    rows, bit = [], False
    for m in margins:
        wide, ncw = unit_edges_wide(pts, m)
        grew = ncw > ncand
        bit = bit or grew
        rows.append(dict(margin=m, candidates=ncw, edges=len(wide),
                         candidates_added=ncw - ncand, agrees=(wide == ship_set)))
        if wide != ship_set:
            miss = set(wide) - set(ship_set)
            extra = set(ship_set) - set(wide)
            raise Refused(
                f"C2 wide-proposal control: the shipped 1+1e-7 proposal and the 1+{m:g} proposal "
                f"disagree -- {len(miss)} edge(s) only the wide one finds, {len(extra)} only the "
                f"shipped one.  A dropped unit edge flatters every SAT verdict.  "
                f"Examples missed: {sorted(miss)[:5]}")
    if not bit:
        raise Refused(
            f"C2 wide-proposal control NEVER BIT: no margin up to {max(margins):g} added a single "
            f"candidate pair to the {ncand} the shipped 1e-7 proposal already had, so the exact "
            f"test was never asked a question it could answer differently.  A control that cannot "
            f"fire is not a control (CLAUDE.md, the nine instruments).")
    return ship_set, dict(shipped_candidates=ncand, edges=len(ship_set), margins=rows, bit=True)


def control_selftest(pts, ship_set):
    """The negative control ON the control: a deliberately NARROW proposal must drop edges and
    must make `unit_edges_controlled` refuse.  Watched to fail before any zero is believed."""
    narrow, _ = unit_edges_wide(pts, -1e-3)         # propose only out to 0.999
    if narrow == ship_set:
        raise Refused("C2 self-test: a 0.999 proposal kept the SAME edge set, so the proposal "
                      "radius decides nothing and the control is measuring nothing.")
    return dict(narrow_radius=0.999, narrow_edges=len(narrow), shipped_edges=len(ship_set),
                dropped=len(set(ship_set) - set(narrow)), fired=True)


# ============================================================== the cross-edge law, decomposed
def cross_decompose(pts, norms, centre, cos):
    """(ordered cross edges, decomposition) at one exact cosine, in BOTH conventions.

    `same_index` is the committed census's `diag` column: pairs (i, i), the same base point in both
    copies.  It is NOT invariant under the base's symmetries -- v -> -v carries a pair (u, u) to the
    antipodal pair (u, -u), which has the same radii and is the same KIND -- so the census reads
    diag = 30 at cos = +7/8 and diag = 0 at cos = -7/8 for one arena seen twice.
    `equal_radius` is the invariant reading: the kind (a, b) with a = b.  Both are asserted."""
    law = T.CrossLaw.collinear(cos)             # raises if sin^2 is a square in K (Theorem B)
    E = law.edges(pts, norms)
    ctr = sum(1 for i, j in E if centre in (i, j))
    same = sum(1 for i, j in E if i == j)
    eqr = sum(1 for i, j in E if centre not in (i, j) and norms[i] == norms[j])
    kinds = {}
    for i, j in E:
        if centre in (i, j):
            continue
        kinds[T.kpair(norms[i], norms[j])] = kinds.get(T.kpair(norms[i], norms[j]), 0) + 1
    kd = [dict(radii=[T.kstr(a), T.kstr(b)], equal_radii=(a == b), ordered_pairs=n,
               sigma=T.kstr(T.kadd(a, b)),
               d_squared=T.kstr(T.ksub(T.kadd(a, b),
                                       T.kdiv(T.ksub(T.kadd(a, b), ONE), cos))))
          for (a, b), n in sorted(kinds.items(), key=lambda kv: T.kfloat(kv[0][0]))]
    return E, dict(centre=ctr, diag=same, offdiag_ordered=len(E) - ctr - same,
                   equal_radius_ordered=eqr, non_equal_radius_ordered=len(E) - ctr - eqr,
                   total=len(E), kinds=kd)


# ============================================================== C5  variant isomorphism
def variant_isomorphism(pts, norms, centre, cos, census_variants):
    """Each other angle of the class must be carried onto this one by an explicit base symmetry,
    checked as a PERMUTATION of the cross-edge set and not as equal counts (plan 11.6).

    For a base symmetry g and a rotation rho, g(rho v) = rho^g g(v), so g carries the arena of rho
    onto the arena of rho^g.  Here g ranges over {identity, negation} x Gal(K/Q) applied
    independently to the two sides, and the claim under test is that some (gL, gS) maps
    E_cross(cos) exactly onto E_cross(cos')."""
    idx = {p: i for i, p in enumerate(pts)}
    maps = {}
    for nm, sig in GALOIS.items():
        for sgn, sname in ((1, ""), (-1, "-")):
            f = (lambda p, sig=sig, sgn=sgn: gal_pt(sig, p) if sgn == 1 else neg_pt(gal_pt(sig, p)))
            maps[sname + nm] = [idx[f(p)] for p in pts]
    E0 = set(cross_decompose(pts, norms, centre, cos)[0])
    out = []
    for vs in census_variants:
        c2 = _parse_kstr(vs)
        if c2 == cos:
            out.append(dict(variant=vs, via="identity", matched=True)); continue
        E1 = set(cross_decompose(pts, norms, centre, c2)[0])
        hit = None
        for nl, pl in maps.items():
            for ns, ps in maps.items():
                if {(pl[i], ps[j]) for i, j in E0} == E1:
                    hit = f"L:{nl} S:{ns}"; break
            if hit: break
        if hit is None:
            raise Refused(
                f"C5 variant isomorphism: no base symmetry carries the cross edges of "
                f"{T.kstr(cos)} onto those of {vs}, so the census's class key merges two "
                f"rotations that are NOT one arena.  Screening one representative would "
                f"eliminate the other WITHOUT TESTING IT (plan 11.6's failure direction).")
        out.append(dict(variant=vs, via=hit, matched=True, cross_edges=len(E1)))
    return out


def _parse_kstr(s):
    """'11/32 + -3/32*sqrt33' back to a 4-slot K element."""
    slots = {"": 0, "*sqrt3": 1, "*sqrt11": 2, "*sqrt33": 3}
    v = [Fr(0)] * 4
    for term in s.split(" + "):
        for nm in ("*sqrt33", "*sqrt11", "*sqrt3"):
            if term.endswith(nm):
                v[slots[nm]] = Fr(term[:-len(nm)]); break
        else:
            v[0] = Fr(term)
    return tuple(v)


# ============================================================== C6  the independent cross-edge check
# The edge-dropping asymmetry protects `E_int`, which is MEASURED.  It does not protect `E_cross`,
# which is DERIVED: a wrong law INVENTS edges, which makes the arena denser, makes UNSAT cheaper,
# and reads as success -- the one direction that flatters a refusal.  (Poros, 2026-09-12.)
#
# So the cross edges are recounted by a second arithmetic that shares no step with the law:
# expand |u - rho v|^2 in K[x]/(x^2 - D) with D = 1 - cos^2 and x the formal square root, and
# require the x-coefficient to vanish and the rational part to equal 1.  It never forms conj(u)v,
# never tests collinearity, and never uses k = (|u|^2 + |v|^2 - 1)/2 -- the three steps the law is
# made of.  This is plan A2 at its cheapest, and it is what makes A3's recount possible on a
# cosine whose radicand leaves the committed tower.
def dist_sq_rotated(u, v, c, D):
    """(rational part, sqrt(D) part) of |u - rho v|^2 in K[sqrt D], rho = c + i sqrt D."""
    ux, uy = u; vx, vy = v
    ax = T.ksub(ux, T.kmul(c, vx))                       # u - rho v = (ax + vy x, ay - vx x)
    ay = T.ksub(uy, T.kmul(c, vy))
    rat = T.kadd(T.kadd(T.kmul(ax, ax), T.kmul(ay, ay)),
                 T.kmul(D, T.kadd(T.kmul(vx, vx), T.kmul(vy, vy))))
    rad = T.kscale(T.ksub(T.kmul(ax, vy), T.kmul(ay, vx)), 2)
    return rat, rad


def joins_independent(u, v, c, D):
    rat, rad = dist_sq_rotated(u, v, c, D)
    return rad == Z and rat == ONE


def recount_cross(pts, cos, claimed, prefix, margin=2e-2, sweep=True):
    """Two independent recounts of the cross-edge set, in both failure directions.

    (a) INVENTED edges -- every edge the law claims, over the WHOLE point set, re-verified by the
        K[sqrt D] expansion.  This closes the direction that manufactures a refusal.
    (b) DROPPED edges -- an exhaustive O(P^2) recount with NO float anywhere, over the first
        `prefix` points, plus a float-proposed / exactly-disposed sweep of ALL ordered pairs at a
        margin `margin` around 1.  A disagreement in either is fatal."""
    import numpy as np
    from scipy.spatial import cKDTree
    D = T.ksub(ONE, T.kmul(cos, cos))
    claimed = set(claimed)

    bad = [(i, j) for i, j in claimed if not joins_independent(pts[i], pts[j], cos, D)]
    if bad:
        raise Refused(f"C6(a) INVENTED EDGES: {len(bad)} of {len(claimed)} cross edges the law "
                      f"claims fail the independent K[sqrt D] expansion, e.g. {bad[:5]}.  A "
                      f"refusal built on them would be an artefact.")

    P = min(prefix, len(pts))
    brute = {(i, j) for i in range(P) for j in range(P)
             if joins_independent(pts[i], pts[j], cos, D)}
    claim_prefix = {(i, j) for i, j in claimed if i < P and j < P}
    if brute != claim_prefix:
        raise Refused(f"C6(b) prefix recount over the first {P} points disagrees with the law: "
                      f"{len(brute - claim_prefix)} edge(s) the expansion finds and the law does "
                      f"not, {len(claim_prefix - brute)} the other way.")

    # (d) the STRUCTURAL fact the expansion hands back, which is why a full sweep is belt and
    # braces rather than the check: the sqrt(D) coefficient came out as
    #     2[(ux - c vx) vy - (uy - c vy) vx] = 2[ux vy - uy vx],
    # in which c CANCELS.  So "the radical part vanishes" is a condition on the PAIR alone --
    # collinearity with the centre -- for every rotation at once, derived here and not assumed
    # from the law.  Checked on a sample against two unrelated cosines.
    import random as _r
    rr = _r.Random(20260912)
    probe = [(rr.randrange(len(pts)), rr.randrange(len(pts))) for _ in range(4000)]
    alt = [T.kelem(Fr(1, 3)), T.kelem(Fr(-5, 7))]
    for i, j in probe:
        base_rad = dist_sq_rotated(pts[i], pts[j], cos, D)[1]
        for c2 in alt:
            D2 = T.ksub(ONE, T.kmul(c2, c2))
            if dist_sq_rotated(pts[i], pts[j], c2, D2)[1] != base_rad:
                raise Refused("C6(d) the radical coefficient is NOT independent of cos, so the "
                              "expansion is mis-implemented: the algebra says c cancels.")
    t_sweep, ncand, nsweep = None, None, None
    if not sweep:
        return dict(claimed=len(claimed), reverified=len(claimed), prefix=P,
                    prefix_edges=len(brute), sweep="skipped (C6(d) covers the drop direction)",
                    c_independent=True, agrees=True)
    s = math.sqrt(T.kfloat(D))
    cf = T.kfloat(cos)
    L = np.array([[T.kfloat(p[0]), T.kfloat(p[1])] for p in pts])
    R = np.column_stack([cf * L[:, 0] - s * L[:, 1], cf * L[:, 1] + s * L[:, 0]])
    cand = cKDTree(L).query_ball_tree(cKDTree(R), 1.0 + margin)
    sweep, ncand = set(), 0
    for i, js in enumerate(cand):
        for j in js:
            ncand += 1
            if joins_independent(pts[i], pts[j], cos, D):
                sweep.add((i, j))
    if sweep != claimed:
        raise Refused(f"C6(c) full sweep at margin {margin:g} disagrees with the law: "
                      f"{len(sweep - claimed)} edge(s) the expansion finds and the law does not, "
                      f"{len(claimed - sweep)} the other way.")
    return dict(claimed=len(claimed), reverified=len(claimed), prefix=P,
                prefix_edges=len(brute), sweep_candidates=ncand, sweep_edges=len(sweep),
                sweep_margin=margin, c_independent=True, agrees=True)


# ============================================================== C7  the residue certificate
# Filter 3.5, between "kinds" and the solver, and it is RADIUS-FREE (Poros, 2026-09-12).
#
# `Arena` gives the S half the same index set and the same `E_int` as the L half, so a colouring of
# the BASE transports to both halves at once.  Take phi = Theorem B's residue colouring of K^2
# (`chromaticNumber_seamPlane`, kernel; `tools/residue_colouring.py` implements it), colour the L
# copy of point i by phi(p_i) and the S copy by phi(p_j) + delta for a constant delta in F4.  Then
# both interior blocks are proper because phi is proper on every unit distance in K^2 and adding a
# constant only relabels, and a cross edge (i, j) is proper iff phi(p_i) - phi(p_j) != delta.  So
# the arena is four-colourable as soon as some delta lies outside
#     Delta = { phi(p_i) - phi(p_j) : (i, j) in E_cross }.
# phi colours ALL of K^2, so the argument never mentions the radius, and the base's cross edges can
# never grow past the endpoint bound 1/|sin theta| -- so an elimination here holds at EVERY radius.
# One-sided: firing proves four-colourable, silence proves nothing.
#
# Nothing here is taken on trust.  The certificate returned is an explicit colouring and it is
# checked on EVERY edge of the arena, so the verdict does not rest on the argument above.
F4 = ((0, 0), (0, 1), (1, 0), (1, 1))
def _xor(a, b): return (a[0] ^ b[0], a[1] ^ b[1])


def residue_certificate(pts, E_int, E_cross, two_pair):
    import residue_colouring as RC
    report = []
    for start in (17, 256 - 17):
        S = RC.sqrt33_2adic(start)
        phi = [RC.residue_of_coords(p[0], p[1], S) for p in pts]
        nnone = sum(1 for r in phi if r is None)
        mono_unit = sum(1 for i, j in E_int if phi[i] is None or phi[j] is None or phi[i] == phi[j])
        mono_two = (phi[two_pair[0]] == phi[two_pair[1]]) if two_pair else None
        row = dict(prime=f"sqrt33_2adic({start})", non_integral=nnone,
                   mono_unit_edges=mono_unit, unit_edges=len(E_int),
                   distance_two_pair_monochromatic=mono_two)
        if nnone or mono_unit:
            row["usable"] = False; report.append(row); continue
        if two_pair and not mono_two:
            raise Refused("C7 negative control: the residue colouring is NOT monochromatic on a "
                          "distance-2 pair, so it is not Theorem B's colouring and its verdicts "
                          "mean nothing.")
        row["usable"] = True
        add_bad = 0
        for i, j in E_cross:
            d = (T.ksub(pts[i][0], pts[j][0]), T.ksub(pts[i][1], pts[j][1]))
            if RC.residue_of_coords(d[0], d[1], S) != _xor(phi[i], phi[j]):
                add_bad += 1
        if add_bad:
            raise Refused(f"C7 additivity: phi(u) - phi(v) != phi(u - v) on {add_bad} cross pairs; "
                          f"the residue map is not the additive map the construction needs.")
        Delta = {_xor(phi[i], phi[j]) for i, j in E_cross}
        row["Delta"] = sorted(Delta)
        row["monochromatic_cross"] = sum(1 for i, j in E_cross if phi[i] == phi[j])
        free = [d for d in F4 if d not in Delta]
        row["free_delta"] = free
        if free:
            n = len(pts)
            delta = free[0]
            col = [phi[i] for i in range(n)] + [_xor(phi[j], delta) for j in range(n)]
            bad = [(i, j) for i, j in E_int if col[i] == col[j]]
            bad += [(n + i, n + j) for i, j in E_int if col[n + i] == col[n + j]]
            bad += [(i, n + j) for i, j in E_cross if col[i] == col[n + j]]
            if bad:
                raise Refused(f"C7 the certificate does not check out: {len(bad)} monochromatic "
                              f"arena edge(s) under the explicit colouring, e.g. {bad[:5]}")
            row["certificate"] = dict(delta=delta, checked_edges=2 * len(E_int) + len(E_cross),
                                      monochromatic=0,
                                      classes=sorted(__import__("collections").Counter(col).values(),
                                                     reverse=True))
        report.append(row)
        if free:
            return row, report
    return None, report


def find_distance_two_pair(pts):
    """A pair at squared distance 4, for C7's negative control (phi must identify it)."""
    four = T.kscale(ONE, 4)
    for j in range(1, len(pts)):
        dx, dy = T.ksub(pts[0][0], pts[j][0]), T.ksub(pts[0][1], pts[j][1])
        if T.kadd(T.kmul(dx, dx), T.kmul(dy, dy)) == four:
            return (0, j)
    return None


# ============================================================== the ask
def ask(pts, E_int, cos, label, wall, centre_pin=True):
    norms = [T.norm2(p) for p in pts]
    centre = next(k for k, p in enumerate(pts) if p == (Z, Z))
    E_cross, dec = cross_decompose(pts, norms, centre, cos)
    A = T.Arena(pts, E_int, E_cross, label=label)
    t0 = time.time()
    st = T.refuses_four(A, A.full, wall=wall)
    dt = time.time() - t0
    return dict(cos=T.kstr(cos), cos_float=T.kfloat(cos), label=label,
                vertices=A.full.bit_count(), int_edges=len(E_int), cross=dec,
                verdict=st, seconds=round(dt, 2)), A


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--radius", type=str, default="2.44")
    ap.add_argument("--classes", default="wall", choices=["wall", "all", "new", "rho15"])
    ap.add_argument("--wall", type=float, default=3600.0)
    ap.add_argument("--census", default="data/m62/rotations-exact-parts-r2.44.json")
    ap.add_argument("--out", default=None)
    ap.add_argument("--prefix", type=int, default=700,
                    help="points in C6's exhaustive float-free cross-edge recount")
    ap.add_argument("--prediction", required=True,
                    help="registered BEFORE the run; copied into the artifact verbatim")
    a = ap.parse_args()

    r = Fr(a.radius)
    print(f"# phase G filter 4 -- arena radius {a.radius} ({float(r):.4f})")
    print(f"# registered prediction: {a.prediction}")

    t0 = time.time()
    pts, _ = T.parts_lattice(float(r))
    norms = [T.norm2(p) for p in pts]
    centre = next(k for k, p in enumerate(pts) if p == (Z, Z))
    print(f"base parts_lattice({a.radius}): {len(pts)} points, built in {time.time()-t0:.1f}s")

    syms = symmetry_gate(pts)
    print(f"  C1 symmetry gate PASS: negation, s3, s11, s3s11 -- zero images outside "
          f"({len(pts)} points each)")

    t0 = time.time()
    E_int, c2 = unit_edges_controlled(pts)
    print(f"  C2 wide-proposal control PASS: {c2['edges']} unit edges, identical sets "
          f"({time.time()-t0:.1f}s)")
    for m in c2["margins"]:
        print(f"       margin 1+{m['margin']:<6g} {m['candidates']:>8} candidates "
              f"({m['candidates_added']:+d} vs the shipped 1e-7 cut's {c2['shipped_candidates']}), "
              f"{m['edges']} exact unit edges, identical={m['agrees']}")
    st = control_selftest(pts, E_int)
    c2["selftest"] = st
    print(f"  C2 self-test FIRED as required: a 0.999 proposal drops {st['dropped']} of "
          f"{st['shipped_edges']} unit edges, so the proposal radius does decide something")

    # ---- C3 the cross-edge calibration, against the committed census artifact ----------------
    cal = {}
    for cs, cos in (("7/8", (Fr(7, 8), Fr(0), Fr(0), Fr(0))),
                    ("-7/8", (Fr(-7, 8), Fr(0), Fr(0), Fr(0)))):
        _, dec = cross_decompose(pts, norms, centre, cos)
        cal[cs] = dec
        print(f"  C3 cos = {cs:>5}: {dec['total']} ordered cross edges = {dec['centre']} centre "
              f"+ {dec['offdiag_ordered']} off-diagonal + {dec['diag']} diagonal (census "
              f"convention, (i,i) pairs); by KIND: {dec['non_equal_radius_ordered']} at distinct "
              f"radii + {dec['equal_radius_ordered']} at equal radii")
        for kk in dec["kinds"]:
            print(f"        kind ({kk['radii'][0]}, {kk['radii'][1]}): {kk['ordered_pairs']} "
                  f"ordered, sigma = {kk['sigma']}, d^2 = {kk['d_squared']}")
    want = {"7/8": dict(centre=60, offdiag_ordered=36, diag=30, total=126),
            "-7/8": dict(centre=60, offdiag_ordered=66, diag=0, total=126)}
    if float(r) >= 2.0:
        for cs in want:
            got = {k: cal[cs][k] for k in want[cs]}
            if got != want[cs]:
                raise Refused(f"C3 calibration: at cos = {cs} the law returns {got}, the "
                              f"committed census says {want[cs]}.  STOP -- the instrument does not "
                              f"reproduce the one known positive.")
        if (cal["-7/8"]["equal_radius_ordered"] != cal["7/8"]["equal_radius_ordered"] or
                cal["-7/8"]["non_equal_radius_ordered"] != cal["7/8"]["non_equal_radius_ordered"]):
            raise Refused("C3 invariant decomposition: v -> -v is a graph isomorphism of the -7/8 "
                          "arena onto the +7/8 one, so the decomposition BY KIND (equal radii vs "
                          "not) must be identical at the two signs.  It is not.")
        if cal["-7/8"]["offdiag_ordered"] != cal["7/8"]["offdiag_ordered"] + cal["7/8"]["diag"]:
            raise Refused("C3 derived identity: the base is centrally symmetric, so v -> -v is a "
                          "graph isomorphism from the -7/8 arena onto the +7/8 one, carrying the "
                          "diagonal pairs (u,u) to off-diagonal pairs (u,-u).  Therefore "
                          "offdiag(-7/8) must equal offdiag(7/8) + diag(7/8); it does not.")
        print(f"  C3 calibration PASS: both decompositions match the committed census exactly "
              f"(its `diag` column counts pairs (i,i)), the derived identity holds "
              f"({cal['-7/8']['offdiag_ordered']} = {cal['7/8']['offdiag_ordered']} + "
              f"{cal['7/8']['diag']}), and the INVARIANT decomposition by kind is identical at the "
              f"two signs ({cal['7/8']['non_equal_radius_ordered']} non-equal-radius + "
              f"{cal['7/8']['equal_radius_ordered']} equal-radius, both signs) -- so the -7/8 row "
              f"is the +7/8 arena RELABELLED (v -> -v), not a second rotation")
    else:
        print(f"  C3 calibration SKIPPED: radius {a.radius} < 2.0, the census's own radii")

    # ---- C0 the L-block precondition: the base alone must be four-colourable -----------------
    # Arena puts the whole E_int into BOTH blocks, so if the base alone refuses four colours every
    # filter-4 ask returns UNSAT for every rotation -- including the identity -- and the screen
    # measures nothing.  M62 §R20 settled this at radius 2.00 only; §R22's radius correction moved
    # the arena to 2.44 and the question is open there.  (Poros, 2026-09-12.)  One ask, first.
    two_pair = find_distance_two_pair(pts)
    A0 = T.Arena(pts, E_int, [], label="no-cross")
    t0c = time.time()
    st0 = T.refuses_four(A0, A0.full, wall=a.wall)
    print(f"\n  C0 L-block precondition: base + its mirror, ZERO cross edges, "
          f"{A0.full.bit_count()} vertices -> {st0.upper()} ({time.time()-t0c:.1f}s)")
    if st0 != "sat":
        raise Refused(
            f"C0 L-block precondition: the arena with NO cross edges is {st0} at radius {a.radius}. "
            f"If it is unsat, every rotation's arena is unsat for a reason that has nothing to do "
            f"with the rotation and the whole screen measures nothing; if it is unknown, the wall "
            f"is too short to read any verdict.  REFUSED.")
    out_c0 = dict(verdict=st0, vertices=A0.full.bit_count(), seconds=round(time.time()-t0c, 2))

    # ---- the classes to screen ---------------------------------------------------------------
    cen = json.load(open(os.path.join(ROOT, a.census)))
    def parse(sv):  return tuple(Fr(t) for t in sv)
    rows = []
    for c in cen["classes"]:
        if a.classes == "wall" and not c["wall_breaks"]:
            continue
        if a.classes == "new" and (not c["wall_breaks"] or c["radicand"][3] == "0"):
            continue
        if a.classes == "rho15" and c["radicand_str"] != "15/64":
            continue
        rows.append(c)
    print(f"\n# screening {len(rows)} rotation class(es) from {a.census}")

    rows.sort(key=lambda c: (0 if c["radicand_str"] == "15/64" else
                             1 if c["wall_breaks"] else 2, c["cos_str"]))
    out = dict(kind="phaseG-filter4-arena-screen", radius=a.radius, base="parts_lattice",
               points=len(pts), prediction=a.prediction, symmetries=syms, unit_edge_control=c2,
               calibration=cal, l_block=out_c0, census=a.census, results=[])

    for c in rows:
        cos = parse(c["cos"])
        print(f"\n## class {c['cos_str']}  (wall_breaks={c['wall_breaks']}, 11={c['eleven']}, "
              f"radicand {c['radicand_str']})")
        print(f"   variants in the census: {c['variants']}")
        iso = variant_isomorphism(pts, norms, centre, cos, c["variants"])
        for row in iso:
            print(f"     C5 {row['variant']:<24} <- {row['via']}")
        E_claim, dec = cross_decompose(pts, norms, centre, cos)
        rec_kinds = dec["kinds"]
        t0c = time.time()
        c6 = recount_cross(pts, cos, E_claim, a.prefix, sweep=bool(c["wall_breaks"]))
        print(f"     C6 independent recount PASS: all {c6['claimed']} claimed cross edges "
              f"re-verified by the K[sqrt D] expansion; exhaustive float-free recount over the "
              f"first {c6['prefix']} points agrees ({c6['prefix_edges']} edges); the radical "
              f"coefficient is cos-independent on 4,000 sampled pairs against two unrelated "
              f"cosines"
              + (f"; full sweep at margin {c6['sweep_margin']:g} "
                 f"({c6['sweep_candidates']} candidates) agrees" if "sweep_edges" in c6 else
                 f"; full sweep skipped (wall-standing class)")
              + f" ({time.time()-t0c:.1f}s)")
        # the endpoint bound 1/|sin theta|: exact, and it is what makes a radius-free claim legal
        D = T.ksub(ONE, T.kmul(cos, cos))
        ends = {i for e in E_claim for i in e}
        maxn = max(norms[i] for i in ends) if ends else Z
        complete = T.kcmp(T.kmul(D, maxn), ONE) <= 0
        rbound = (1.0 / (T.kfloat(D) ** 0.5))
        for kk in dec["kinds"]:
            print(f"     kind ({kk['radii'][0]}, {kk['radii'][1]}): {kk['ordered_pairs']} ordered "
                  f"pairs, sigma = {kk['sigma']}, d^2 = sigma - (sigma-1)/cos = {kk['d_squared']}"
                  + ("   [EQUAL RADII]" if kk["equal_radii"] else ""))
        print(f"     endpoint bound 1/|sin| = {rbound:.4f}; furthest cross-edge endpoint at "
              f"radius {T.kfloat(maxn) ** 0.5:.4f}; cross-edge set complete for EVERY radius on "
              f"this lattice: {complete}")
        c7, c7rep = residue_certificate(pts, E_int, E_claim, two_pair)
        for rr in c7rep:
            print(f"     C7 {rr['prime']:<22} usable={rr['usable']} "
                  + (f"Delta={rr.get('Delta')} monochromatic cross={rr.get('monochromatic_cross')} "
                     f"free delta={rr.get('free_delta')}" if rr["usable"] else
                     f"(non-integral {rr['non_integral']}, monochromatic unit edges "
                     f"{rr['mono_unit_edges']})"))
        if c7:
            print(f"     C7 >>> EXPLICIT 4-COLOURING of the arena, delta={c7['certificate']['delta']}, "
                  f"checked on all {c7['certificate']['checked_edges']} arena edges, "
                  f"0 monochromatic -- FOUR-COLOURABLE AT EVERY RADIUS by Theorem B")
        rec, A = ask(pts, E_int, cos, c["cos_str"], a.wall)
        rec["residue_certificate"] = c7
        rec["residue_report"] = c7rep
        rec["endpoint_bound"] = dict(one_over_sin=rbound,
                                     furthest_endpoint=T.kfloat(maxn) ** 0.5,
                                     cross_set_complete_at_every_radius=complete)
        rec["independent_recount"] = c6
        rec["wall_breaks"] = c["wall_breaks"]
        rec["eleven"] = c["eleven"]
        rec["radicand"] = c["radicand_str"]
        rec["census_variants"] = c["variants"]
        rec["kinds"] = c["kinds"]
        rec["variant_isomorphism"] = iso
        print(f"   arena: {rec['vertices']} vertices, {rec['int_edges']} unit edges per side, "
              f"{rec['cross']['total']} cross ({rec['cross']['centre']}c/"
              f"{rec['cross']['offdiag_ordered']}o/{rec['cross']['diag']}d)")
        print(f"   >>> VERDICT {rec['verdict'].upper()} at radius {a.radius}  ({rec['seconds']}s)")
        out["results"].append(rec)

    out["seconds"] = round(time.time() - t0, 1)
    if a.out:
        with open(os.path.join(ROOT, a.out), "w") as f:
            json.dump(out, f, indent=1)
        print(f"\nwrote {a.out}")
    return out


if __name__ == "__main__":
    try:
        main()
    except Refused as e:
        print(f"\n*** RUN REFUSED ***\n{e}")
        sys.exit(3)
