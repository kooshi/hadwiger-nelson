#!/usr/bin/env python3
"""phaseh_base — M63 phase H: a base built FOR a rotation, and the five falsifiers of
`plans/M63-phaseH-a-base-for-a-rotation.md` §7.

The rotation is cos(theta) = 11/32 + (3/32)sqrt33, the one angle besides Parts's own that survives
phase G's arithmetic filters on his lattice and was then eliminated there -- because his lattice is
missing the single point that carries the equal-radius cross kind:

    u = (1/3 - sqrt3/2 - sqrt11/6, 1/3 + sqrt3/2 + sqrt11/6),   |u|^2 = (7 + sqrt33)/3
                                                                     = 1/(2 - 2 cos theta).

This builds the Z-module M = Lambda_parts + Z<Galois orbit of u> (rank 7 -- every generator has a
zero sqrt33 component in its y coordinate, so M lies in a hyperplane of K^2 ~ Q^8), cuts it by the
TOTALLY-REAL disk (every Galois conjugate of |p|^2 at most r^2, which is what makes the cut finite),
and measures.

GENERATOR IMAGE, stated because the phase-G instrument failure was exactly this (handoff section 6):
  * Q-span(Lambda_parts) = {x in Q<1,sqrt33>, y in Q<sqrt3,sqrt11>}  -- 4-dimensional, and u is
    NOT in it.  Any sweep whose generator is Parts's lattice cannot represent u.
  * Q-span(M)            = {y_3 = 0}                                 -- 7-dimensional, u IS in it,
    verified by exhibiting u's integer coordinate vector on the module basis.
  * zeta6 * u has y_3 = -1/12, so a zeta6-CLOSED module containing u has rank 8, whose cut at
    radius 2.44 is ~1.9e8 points: unaffordable.  zeta6-closure is therefore dropped DELIBERATELY,
    and H5 (negation and the two Galois flips) is kept because it is free.

UNTRUSTED like everything under tools/.  Nothing here is a certificate.
"""
from __future__ import annotations
import argparse, json, math, os, sys, time
from fractions import Fraction as Fr

ROOT = "/home/kooshi/source/lean-dir"
sys.path.insert(0, os.path.join(ROOT, "tools"))
import typem as T
import typem_exact as TE
import phaseg_screen as PG
import residue_colouring as RC

Z, ONE = T.Z, T.ONE
GALOIS = {"id": (1, 1, 1, 1), "s3": (1, -1, 1, -1), "s11": (1, 1, -1, -1), "s3s11": (1, -1, -1, 1)}

COS_NEW = (Fr(11, 32), Fr(0), Fr(0), Fr(3, 32))
COS_RHO15 = (Fr(7, 8), Fr(0), Fr(0), Fr(0))
U = ((Fr(1, 3), Fr(-1, 2), Fr(-1, 6), Fr(0)), (Fr(1, 3), Fr(1, 2), Fr(1, 6), Fr(0)))


def gal_pt(sig, p):
    return (tuple(s * v for s, v in zip(sig, p[0])), tuple(s * v for s, v in zip(sig, p[1])))


def vec12(p):
    v = [q * 12 for q in p[0]] + [q * 12 for q in p[1]]
    assert all(q.denominator == 1 for q in v), f"denominator 12 does not clear {p}"
    return [int(q) for q in v]


def unvec12(v):
    return (tuple(Fr(v[j], 12) for j in range(4)), tuple(Fr(v[j], 12) for j in range(4, 8)))


def hnf(rows):
    """A row-echelon Z-basis of the module spanned by `rows` (integer vectors)."""
    rows = [r[:] for r in rows]
    n = len(rows[0]); r = 0; basis = []
    for c in range(n):
        piv = next((i for i in range(r, len(rows)) if rows[i][c] != 0), None)
        if piv is None:
            continue
        rows[r], rows[piv] = rows[piv], rows[r]
        changed = True
        while changed:
            changed = False
            for i in range(r + 1, len(rows)):
                if rows[i][c] != 0:
                    q = rows[i][c] // rows[r][c]
                    rows[i] = [x - q * y for x, y in zip(rows[i], rows[r])]
                    if rows[i][c] != 0:
                        rows[r], rows[i] = rows[i], rows[r]; changed = True
        if rows[r][c] < 0:
            rows[r] = [-x for x in rows[r]]
        basis.append(rows[r]); r += 1
    return basis


def module_basis(with_u=True):
    """Z-basis of Lambda_parts (+ the Galois orbit of u), as integer vectors of 12*p."""
    gens = []
    for (a, b, c, d) in [(2, 2, 0, 0), (2, 0, 2, 0), (2, 0, 0, 2), (1, 1, 1, -1), (1, -1, 1, 1),
                         (0, 0, 2, 2), (2, -2, 0, 0), (1, 1, -1, 1), (0, 2, 2, 0), (0, 2, 0, 2)]:
        if (a - b) % 2 or (a - c) % 2 or (a - d) % 2 or (a - b + c + d) % 4:
            continue
        gens.append([a, 0, 0, b, 0, c, d, 0])
    if with_u:
        for sig in GALOIS.values():
            gens.append(vec12(gal_pt(sig, U)))
    return hnf(gens)


def in_module(B, v):
    """The integer coordinate vector of v on the echelon basis B, or None."""
    tgt = [Fr(x) for x in v]; coef = []
    for row in B:
        c = next(j for j in range(8) if row[j] != 0)
        f = tgt[c] / row[c]
        tgt = [t - f * Fr(x) for t, x in zip(tgt, row)]
        coef.append(f)
    if any(t != 0 for t in tgt) or any(f.denominator != 1 for f in coef):
        return None
    return [int(f) for f in coef]


def enumerate_ball(G, R):
    """Every integer z with z^T G z <= R (Fincke-Pohst, float Cholesky; the verdict is exact later)."""
    import numpy as np
    L = np.linalg.cholesky(G).T
    n = G.shape[0]; out = []; z = [0] * n

    def rec(i, rem, partial):
        if i < 0:
            out.append(tuple(z)); return
        d = L[i, i]
        centre = -partial[i] / d
        rad = math.sqrt(max(rem, 0.0)) / d
        for zi in range(math.ceil(centre - rad - 1e-9), math.floor(centre + rad + 1e-9) + 1):
            z[i] = zi
            v = d * zi + partial[i]
            nrem = rem - v * v
            if nrem < -1e-9:
                continue
            rec(i - 1, nrem, [partial[j] + L[j, i] * zi for j in range(n)])
        z[i] = 0
    rec(n - 1, R, [0.0] * n)
    return out


SIGS = ((1, 1, 1, 1), (1, -1, 1, -1), (1, 1, -1, -1), (1, -1, -1, 1))


def totally_real_ok(n, r2):
    """Every Galois conjugate of the squared norm n is at most r2.  EXACT (ksign)."""
    for sig in SIGS:
        if T.ksign(T.ksub(r2, tuple(s * t for s, t in zip(sig, n)))) < 0:
            return False
    return True


def build(r2: Fr, with_u=True, verbose=True):
    """The totally-real disk cut of the module, at squared radius r2."""
    import numpy as np
    B = module_basis(with_u)
    W = np.array([1, 3, 11, 33, 1, 3, 11, 33], dtype=float)
    Bm = np.array(B, dtype=float)
    G = (Bm * W) @ Bm.T
    R = float(144 * r2)                       # Q(12p) <= 144 r^2 is implied by the cut
    t0 = time.time()
    Zs = enumerate_ball(G, R)
    r2k = (Fr(r2), Fr(0), Fr(0), Fr(0))
    pts = []
    for z in Zs:
        v = [sum(z[i] * B[i][j] for i in range(len(B))) for j in range(8)]
        p = unvec12(v)
        if totally_real_ok(T.norm2(p), r2k):
            pts.append(p)
    pts.sort(key=lambda p: (TE.KOrder(T.norm2(p)), TE.KOrder(p[0]), TE.KOrder(p[1])))
    if verbose:
        print(f"[build] rank {len(B)} module, r^2 = {r2} ({float(r2)**0.5:.6f}): "
              f"Q-ball {len(Zs):,} -> totally-real cut {len(pts):,} points  ({time.time()-t0:.1f}s)")
    return pts, B


# ====================================================================== controls
def calibration():
    """MANDATORY before any zero is believed (handoff section 8.2): the committed law on the
    committed lattice must return the census's own decomposition, digit for digit."""
    pts, _ = TE.parts_lattice_exact(Fr("2.44"))
    norms = [T.norm2(p) for p in pts]
    centre = next(k for k, p in enumerate(pts) if p == (Z, Z))
    out = {}
    for sgn, want in ((Fr(7, 8), (60, 36, 30)), (Fr(-7, 8), (60, 66, 0))):
        E, dec = PG.cross_decompose(pts, norms, centre, T.kelem(sgn))
        got = (dec["centre"], dec["offdiag_ordered"], dec["diag"])
        out[str(sgn)] = dict(total=dec["total"], got=got, want=want, ok=(got == want and dec["total"] == 126))
        if not out[str(sgn)]["ok"]:
            raise PG.Refused(f"calibration at cos={sgn}: got {got} total {dec['total']}, want {want} total 126")
    print(f"[calib] rho15 on parts_lattice(2.44): +7/8 -> 60/36/30, -7/8 -> 60/66/0, both total 126  OK")
    return out


def generator_image(B):
    """The check the handoff's section 6 failure demands: write the generator's image down and
    confirm the target is inside it.  Reported as a positive signal, never as silence."""
    row = dict()
    row["module_rank"] = len(B)
    row["zero_coordinates"] = [j for j in range(8) if all(b[j] == 0 for b in B)]
    cu = in_module(B, vec12(U))
    row["u_coordinates_on_basis"] = cu
    row["u_in_module"] = cu is not None
    Bp = module_basis(with_u=False)
    row["parts_only_rank"] = len(Bp)
    row["parts_only_zero_coordinates"] = [j for j in range(8) if all(b[j] == 0 for b in Bp)]
    row["u_in_parts_module"] = in_module(Bp, vec12(U)) is not None
    # zeta6 * u leaves the module: the rank-8 closure is unaffordable, and this says so in numbers
    half = Fr(1, 2); s3h = (Fr(0), half, Fr(0), Fr(0))
    z6u = (T.ksub(T.kscale(U[0], half), T.kmul(s3h, U[1])),
           T.kadd(T.kmul(s3h, U[0]), T.kscale(U[1], half)))
    row["zeta6_u_y_sqrt33_slot"] = str(z6u[1][3])
    row["zeta6_u_in_module"] = in_module(B, vec12(z6u)) is not None
    if not row["u_in_module"]:
        raise PG.Refused("the module does not contain u: every zero over this family would be structural")
    if row["u_in_parts_module"]:
        raise PG.Refused("u lies in Parts's own module, which contradicts phase G section 12.4")
    print(f"[image] module rank {row['module_rank']}, identically-zero coordinate slots "
          f"{row['zero_coordinates']} (7 = y's sqrt33 slot); u IS in it at {cu}; "
          f"Parts's own module has rank {row['parts_only_rank']} and u is NOT in it; "
          f"zeta6*u has y_sqrt33 = {row['zeta6_u_y_sqrt33_slot']} and is NOT in it")
    return row


def symmetry_gate(pts):
    S = set(pts)
    out = {"negation": sum(1 for p in pts if (T.kneg(p[0]), T.kneg(p[1])) not in S)}
    for nm, sig in GALOIS.items():
        if nm != "id":
            out[nm] = sum(1 for p in pts if gal_pt(sig, p) not in S)
    bad = {k: v for k, v in out.items() if v}
    if bad:
        raise PG.Refused(f"C1 base symmetry gate: images outside the point set {bad}")
    print(f"[C1] symmetry gate: negation and all three Galois flips map the base onto itself, "
          f"zero images outside")
    return out


def unit_edges_exact_vec(pts, margin=1e-7):
    """Exact unit pairs, integer-vectorised.  A KD-tree PROPOSES; exact integer arithmetic in the
    field's own coordinate slots DISPOSES.  Identical in kind to `typem.unit_edges_fast`, ~200x
    faster because it never builds a Fraction: with v = L*(p - q) an integer 8-vector,

        |p-q|^2 = 1   <=>   slot0 = L^2  and  slot1 = slot2 = slot3 = 0,
        slot0 = a^2+3b^2+11c^2+33d^2 (+ the same in y),  slot1 = 2ab+22cd (+ y), etc.

    A dropped unit edge makes the graph easier, makes it colourable, and reads as a sound
    elimination, so this is cross-checked against the committed routine on the base itself
    (`unit_edge_crosscheck`), never merely on a toy."""
    from scipy.spatial import cKDTree
    from math import gcd
    import numpy as np
    L = 1
    for p in pts:
        for q in p[0] + p[1]:
            L = L * q.denominator // gcd(L, q.denominator)
    V = np.array([[int(q * L) for q in p[0] + p[1]] for p in pts], dtype=np.int64)
    F = np.array([[T.kfloat(p[0]), T.kfloat(p[1])] for p in pts])
    cand = cKDTree(F).query_pairs(1.0 + margin, output_type='ndarray')
    if len(cand) == 0:
        return [], 0
    out = []
    CH = 2_000_000                       # chunked: 33M candidate pairs x 8 int64 is 2.1 GB at once
    for lo in range(0, len(cand), CH):
        ch = cand[lo:lo + CH]
        d = V[ch[:, 0]] - V[ch[:, 1]]
        a, b, c, e, f, g, h, k = (d[:, i] for i in range(8))
        s0 = a*a + 3*b*b + 11*c*c + 33*e*e + f*f + 3*g*g + 11*h*h + 33*k*k
        s1 = 2*a*b + 22*c*e + 2*f*g + 22*h*k
        s2 = 2*a*c + 6*b*e + 2*f*h + 6*g*k
        s3 = 2*a*e + 2*b*c + 2*f*k + 2*g*h
        for i, j in ch[(s0 == L * L) & (s1 == 0) & (s2 == 0) & (s3 == 0)]:
            out.append((int(i), int(j)))
    return out, len(cand)


def unit_edge_crosscheck(pts, n=1400, seed=20260912):
    """The vectorised routine against the committed `typem.unit_edges_fast`, on a random induced
    subgraph OF THIS BASE.  The induced edge set of a subset is the subset of the edge set, so an
    agreement here is an agreement about this base's own arithmetic, not about a toy."""
    import random
    rr = random.Random(seed)
    sub = rr.sample(range(len(pts)), min(n, len(pts)))
    S = [pts[i] for i in sub]
    A, _ = T.unit_edges_fast(S, 1e-7)
    B, _ = unit_edges_exact_vec(S, 1e-7)
    if set(map(tuple, A)) != set(B):
        raise PG.Refused(f"unit-edge cross-check on {len(S)} points of this base: the committed "
                         f"routine and the vectorised one differ by {len(set(map(tuple,A)) ^ set(B))} edges")
    print(f"[C2a] vectorised exact unit edges agree with the committed typem.unit_edges_fast on a "
          f"random {len(S)}-point induced subgraph of this base: {len(B)} edges, identical set")
    return dict(subsample=len(S), edges=len(B), identical=True)


def unit_edges_controlled(pts, margins=(1e-3, 1e-2)):
    """C2: the shipped 1+1e-7 proposal must give the SAME exact edge set as deliberately wide ones.
    A dropped unit edge makes the graph easier, makes it colourable, and reads as a sound
    elimination -- the one direction whose error flatters us."""
    cross = unit_edge_crosscheck(pts)
    ship, ncand = unit_edges_exact_vec(pts, 1e-7)
    S = set(ship)
    rows = []
    for m in margins:
        wide, nc = unit_edges_exact_vec(pts, m)
        W = set(wide)
        rows.append(dict(margin=m, candidates=nc, edges=len(W), equals_shipped=(W == S)))
        if W != S:
            raise PG.Refused(f"C2 wide-proposal control at margin {m}: the exact edge set differs "
                             f"from the shipped one by {len(W ^ S)} edges")
    tight, _ = unit_edges_exact_vec(pts, -1e-3)       # the control must be able to FIRE
    if set(tight) == S:
        raise PG.Refused("C2 self-test: a 0.999 proposal dropped nothing, so the control cannot fire")
    print(f"[C2] unit edges {len(S):,} on {len(pts):,} points ({len(S)/max(len(pts),1):.2f} per point); "
          f"wide proposals at {margins} give the identical exact set; the tightened self-test fires "
          f"({len(S) - len(set(tight)):,} edges dropped)")
    return ship, dict(crosscheck=cross, margins=rows, edges=len(S))


def kinds_per_prime(pts, cos, label=""):
    """The replacement for F1 (Poros, 2026-09-12): F1's own premise is unreachable on any base
    containing Parts's lattice, and its firing would be GOOD news -- a base whose only non-centre
    kind is the diagonal is the minimal surviving configuration.  The count that carries weight is,
    PER PRIME, the number of non-centre kinds with v_p(d^2) > 0.  It must be >= 1 at each prime or
    the certificate fires there."""
    norms = [T.norm2(p) for p in pts]
    centre = next(k for k, p in enumerate(pts) if p == (Z, Z))
    E, dec = PG.cross_decompose(pts, norms, centre, cos)
    ZERO4 = (Fr(0),) * 4
    primes = {17: RC.sqrt33_2adic(17), 239: RC.sqrt33_2adic(239)}
    for kd in dec["kinds"]:
        d2 = PG._parse_kstr(kd["d_squared"])
        kd["mono"] = {str(k): (RC.residue_of_coords(d2, ZERO4, S) == (0, 0)) for k, S in primes.items()}
    live = {str(k): sum(1 for kd in dec["kinds"] if kd["mono"][str(k)]) for k in primes}
    dec["monochromatic_kinds_per_prime"] = live
    print(f"[kinds] {label}cos {T.kstr(cos)}: {dec['total']} ordered cross edges "
          f"= {dec['centre']} centre + {dec['offdiag_ordered']} distinct-radius + {dec['diag']} same-index; "
          f"{len(dec['kinds'])} non-centre kinds; monochromatic kinds per prime {live}")
    for kd in dec["kinds"]:
        print(f"         kind radii {kd['radii']} equal={kd['equal_radii']} pairs={kd['ordered_pairs']} "
              f"sigma={kd['sigma']} d2={kd['d_squared']} mono={kd['mono']}")
    return E, dec


def independent_recount(pts, cos, claimed):
    """C6(a): every cross edge the law claims, re-verified by the K[x]/(x^2 - D) expansion, which
    shares no step with the law.  A wrong law INVENTS edges, which makes a refusal cheaper and
    reads as success -- the one direction that flatters us on E_cross."""
    D = T.ksub(ONE, T.kmul(cos, cos))
    bad = [(i, j) for i, j in claimed if not PG.joins_independent(pts[i], pts[j], cos, D)]
    if bad:
        raise PG.Refused(f"C6(a) INVENTED EDGES: {len(bad)} of {len(claimed)} fail the independent "
                         f"expansion, e.g. {bad[:5]}")
    # the control must be able to fire: a deliberately wrong cosine must reject nearly everything
    wrong = T.kelem(Fr(3, 4)); Dw = T.ksub(ONE, T.kmul(wrong, wrong))
    survive = sum(1 for i, j in list(claimed)[:400] if PG.joins_independent(pts[i], pts[j], wrong, Dw))
    if survive == min(400, len(claimed)):
        raise PG.Refused("C6(a) self-test: a wrong cosine accepted every claimed edge, so the "
                         "recount cannot fire")
    print(f"[C6a] all {len(claimed)} claimed cross edges re-verified by the independent "
          f"K[x]/(x^2-D) expansion; the self-test at a wrong cosine keeps only {survive} of "
          f"{min(400,len(claimed))}")
    return dict(claimed=len(claimed), reverified=len(claimed), selftest_survivors=survive)


def certificate(pts, E_int, E_cross):
    """F3: rebuild Delta and test all four delta, at both primes.  It CANNOT fire against a base
    containing u -- growth only ADDS differences to Delta and the certificate needs one MISSING --
    so this is checked once, with the reason stated, and not re-litigated."""
    two = PG.find_distance_two_pair(pts)
    if two is None:
        raise PG.Refused(
            "F3: this base has no distance-2 pair, so phi's negative control (Theorem B's colouring "
            "must identify a distance-2 pair) is SKIPPED inside residue_certificate while `usable` "
            "is still set True -- the certificate would return a benign verdict having checked "
            "nothing (Poros PH-5(1), 2026-09-12).  Refused rather than run.")
    row, report = PG.residue_certificate(pts, E_int, E_cross, two)
    inapplicable = [r["prime"] for r in report if not r.get("usable")]
    if inapplicable:
        raise PG.Refused(
            f"F3: the residue colouring is INAPPLICABLE at {inapplicable} (non-integral residues or "
            f"a monochromatic unit edge).  That is a THIRD verdict, not silence: a base can defeat "
            f"the certificate by breaking its applicability rather than its conclusion, which is a "
            f"Goodhart hazard for any loop iterating on bases against it (Poros PH-5(2)).")
    for r in report:
        print(f"[F3] {r['prime']}: non-integral {r['non_integral']}, monochromatic unit edges "
              f"{r['mono_unit_edges']} of {r['unit_edges']}, Delta {r.get('Delta')}, "
              f"monochromatic cross {r.get('monochromatic_cross')}, free delta {r.get('free_delta')}")
    if row is not None:
        print("[F3] *** THE CERTIFICATE FIRED: the arena is four-colourable at every radius. ***")
    else:
        print("[F3] the certificate is SILENT at both primes -- which proves NOTHING (one-sided).")
    return row, report


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--r2", default="17/4", help="squared cut radius, exact (u needs >= (7+sqrt33)/3 = 4.2482)")
    ap.add_argument("--no-u", action="store_true", help="build WITHOUT u: the negative control base")
    ap.add_argument("--sat", action="store_true")
    ap.add_argument("--wall", type=float, default=1800.0)
    ap.add_argument("--skip-calib", action="store_true")
    ap.add_argument("--solver-control", action="store_true",
                    help="rho15 on parts_lattice(2.44) must come back UNSAT before any SAT here is "
                         "believed: that arena contains Heule-510")
    ap.add_argument("--out", default=None)
    a = ap.parse_args()
    out = dict(kind="m63-phaseH-base", r2=a.r2, with_u=not a.no_u, t0=time.strftime("%F %T"))
    if not a.skip_calib:
        out["calibration"] = calibration()
    B = module_basis(with_u=not a.no_u)
    if not a.no_u:
        out["generator_image"] = generator_image(B)
    pts, _ = build(Fr(a.r2), with_u=not a.no_u)
    out["points"] = len(pts)
    out["symmetries"] = symmetry_gate(pts)
    # C0: Parts's own lattice must be a SUBSET of the cut, or the base is not an extension of his.
    # `parts_lattice_exact` takes a RADIUS; build it at 3 (which strictly contains every squared
    # radius this phase uses) and re-cut it by the exact squared radius, so no root is ever taken.
    S = set(pts)
    r2k = (Fr(a.r2), Fr(0), Fr(0), Fr(0))
    lam = [p for p in TE.parts_lattice_exact(Fr(3))[0]
           if totally_real_ok(T.norm2(p), r2k)]
    missing = [p for p in lam if p not in S]
    if missing:
        raise PG.Refused(f"the cut does not contain Parts's own lattice: {len(missing)} of "
                         f"{len(lam)} points missing, so the base is not an extension of his")
    out["parts_subset"] = dict(parts_points=len(lam), missing=0)
    print(f"[C0] Parts's lattice at this cut radius is a SUBSET of the base: "
          f"{len(lam)} of {len(lam)} points present")
    out["u_in_base"] = U in set(pts)
    print(f"[base] {len(pts):,} points; u in base: {out['u_in_base']}; "
          f"points of norm 1: {sum(1 for p in pts if T.norm2(p) == ONE)}")
    E_int, out["unit_edge_control"] = unit_edges_controlled(pts)
    out["unit_edges"] = len(E_int)
    # F2, sharpened: u's own unit degree.  A base that contains u and nothing near it wins H1 and
    # loses everything else.
    if out["u_in_base"]:
        iu = pts.index(U)
        deg = sum(1 for e in E_int if iu in e)
        out["u_unit_degree"] = deg
        orb = {gal_pt(s, U) for s in GALOIS.values()}
        orb |= {(T.kneg(p[0]), T.kneg(p[1])) for p in orb}
        idx = {p: i for i, p in enumerate(pts)}
        out["u_orbit_degrees"] = [sum(1 for e in E_int if idx[p] in e) for p in orb if p in idx]
        print(f"[F2] u's unit degree in the base: {deg}; its 8-point symmetry orbit: "
              f"{sorted(out['u_orbit_degrees'])}")
    E_cross, dec = kinds_per_prime(pts, COS_NEW, label="NEW rotation, ")
    out["cross_new"] = dec
    out["recount_new"] = independent_recount(pts, COS_NEW, E_cross)
    out["certificate_new"] = dict(zip(("fired", "report"), certificate(pts, E_int, E_cross)))
    if a.solver_control:
        cp, _ = TE.parts_lattice_exact(Fr("2.44"))
        cE, _ = unit_edges_exact_vec(cp, 1e-7)
        cn = [T.norm2(q) for q in cp]
        cc = next(k for k, q in enumerate(cp) if q == (Z, Z))
        cX, cdec = PG.cross_decompose(cp, cn, cc, COS_RHO15)
        CA = T.Arena(cp, cE, cX, label="rho15-control")
        t0 = time.time()
        cst = T.refuses_four(CA, CA.full, wall=a.wall)
        out["solver_control"] = dict(verdict=cst, vertices=CA.full.bit_count(),
                                     unit_edges=len(cE), cross=cdec["total"],
                                     seconds=round(time.time() - t0, 1))
        print(f"[C4] SOLVER POSITIVE CONTROL rho15 on parts_lattice(2.44): {CA.full.bit_count():,} "
              f"vertices, {len(cE):,} unit edges, {cdec['total']} cross edges -> {cst.upper()} in "
              f"{out['solver_control']['seconds']}s")
        if cst != "unsat":
            raise PG.Refused(f"C4: the solver control came back {cst}, not unsat.  No SAT verdict "
                             f"from this pipeline may be believed until it does.")
    if a.sat:
        A = T.Arena(pts, E_int, E_cross, label="phaseH-new")
        t0 = time.time()
        st = T.refuses_four(A, A.full, wall=a.wall)
        out["sat_new"] = dict(verdict=st, vertices=A.full.bit_count(), seconds=round(time.time() - t0, 1))
        print(f"[F4] arena {A.full.bit_count():,} vertices, {len(E_int):,} interior edges each side, "
              f"{len(E_cross)} cross edges -> {st.upper()} in {out['sat_new']['seconds']}s")
    if a.out:
        with open(a.out, "w") as f:
            json.dump(out, f, indent=1, default=str)
        print(f"[out] wrote {a.out}")
    return out


if __name__ == "__main__":
    main()
