#!/usr/bin/env python3
"""The planted faults for the exactness migration: inputs on which the FLOAT verdict is wrong.

    A control that passes without its failure mode being reachable has not been tested by passing.

WHAT THIS PROVED (2026-09-12). `equiv.py` beside this file shows the migration of commit 8b59db6
moved no number. On its own that is consistent with the migration having fixed nothing, because on
every base this project uses the float and the exact verdicts AGREE -- the defect had not yet
bitten. So each control here constructs an input where they differ, and prints its UNINFORMATIVE
OUTCOME first: the result that would mean the control could not have fired. Six sites, six faults,
each seen to go red.

    python3 tools/m63-exactness/controls.py                  # baseline 071ec4a vs the working tree
    python3 tools/m63-exactness/controls.py --today 8b59db6  # vs the migration commit itself

WHAT IT CANNOT PROVE AGAIN. The float code is gone from the tree; this reconstructs it from git and
cannot re-derive it. It validated a ONE-TIME MIGRATION and is NOT a standing gate -- nothing runs
it, and it is in no module's --self-test. The standing checks live in `typem_exact.py --self-test`:
section 1 (the sign predicate against 122 engineered near-zero probes), section 6 (the retired ray
keying, reimplemented there so it still has something real to compare against), section 6b (the
KD-tree proposal gate's measured headroom).

WHY THE FAMILY HID FOR SO LONG, which is the part worth carrying forward: `kfloat` is wrong on
none of 40,000 uniformly random elements of K and on 10 of 60,000 drawn from the near-cancelling
family p - q*sqrt33. A defect reachable only near a boundary is invisible to any test that samples
the space evenly, so these controls manufacture the boundary rather than sampling toward it.
"""
from __future__ import annotations
import argparse, math, sys
from fractions import Fraction as Fr
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import _trees

ap = argparse.ArgumentParser()
ap.add_argument("--baseline", default=_trees.BASELINE)
ap.add_argument("--today", default=None)
args = ap.parse_args()

B, X = _trees.baseline_pair(args.baseline)        # the pre-migration pair, internally consistent
P, p_src = _trees.today("typem_today", args.today)
print(f"baseline : {args.baseline}:tools/typem.py (+ typem_exact.py, for its probe generator)")
print(f"today    : {args.today + ':tools/typem.py' if args.today else p_src}")

DEAD = []


def control(n, t):
    print(f"\n--- C{n}  {t}")


def verdict(n, fired, note):
    print(f"    {'RED  -- control FIRED (float wrong, exact right)' if fired else 'NOT FIRED -- uninformative'}: {note}")
    if not fired:
        DEAD.append(n)


def fsign(x):
    v = B.kfloat(x)
    return (v > 0) - (v < 0)


def conv33(n):
    """Convergents of sqrt33 = [5; 1,2,1,10] repeating -- integers only, no float anywhere."""
    per = [1, 2, 1, 10]
    h0, h1, k0, k1, out = 0, 1, 1, 0, []
    for ai in [5] + [per[i % 4] for i in range(n)]:
        h0, h1, k0, k1 = h1, ai * h1 + h0, k1, ai * k1 + k0
        out.append((h1, k1))
    return out


CONV = conv33(60)


def flips():
    """K elements whose TRUE sign is +1 and whose FLOAT sign is -1. A real flip, not an underflow."""
    for h, k in CONV:
        for t in (Fr(1), Fr(1, 3), Fr(3), Fr(1, 7), Fr(7), Fr(5), Fr(11), Fr(101)):
            x = (-t * h, Fr(0), Fr(0), t * k)
            if P.ksign(x) > 0 and fsign(x) < 0:
                yield x


# ============================================================ C1  the sign predicate itself
control(1, "ksign vs the float sign on engineered near-zero elements of K")
print("    uninformative: float agrees with exact on every probe.")
pr = X.near_zero_probes()
fw = sum(1 for x, s, _ in pr if fsign(x) != s)
ew = sum(1 for x, s, _ in pr if P.ksign(x) != s)
print(f"    {len(pr)} probes: float sign WRONG on {fw}, exact ksign wrong on {ew}")
verdict(1, fw > 0 and ew == 0, f"float errs {fw}/{len(pr)}, exact errs {ew}")

# ============================================================ C2  sieve admissibility
control(2, "sieve's `D < 0` cut DISCARDING a real rotation class")
print("    uninformative: on the real bases old and new agree exactly (they DO -- the defect had")
print("    not bitten), so the control must inject an adversarial radicand end to end.")
bad = next(flips())
print(f"    injected D = {B.kstr(bad)}")
print(f"      true sign +1 (a real rotation); float value {B.kfloat(bad):+.4e} -> float sign {fsign(bad)}")
pts2 = [(B.Z, B.Z), (B.ONE, B.Z)]


def run_sieve(M, D):
    orig = M.radicand
    M.radicand = lambda a, b: (D, M.ONE, M.Z)
    try:
        return M.sieve(pts2, verbose=False)
    finally:
        M.radicand = orig


rb, rp = run_sieve(B, bad), run_sieve(P, bad)
print(f"    baseline: no_rotation={rb['no_rotation']}  admitting={rb['admitting']}")
print(f"    today   : no_rotation={rp['no_rotation']}  admitting={rp['admitting']}")
verdict(2, rb["no_rotation"] > 0 and rp["no_rotation"] == 0,
        "the float cut throws a real rotation class away; the exact one keeps it")

# ============================================================ C3  CrossLaw.collinear
control(3, "CrossLaw.collinear REFUSING a genuine rotation whose sin^2 floats to <= 0")
print("    uninformative: no cosine with a near-zero positive sin^2 is constructible here.")
found = None
for h, k in CONV:
    for m in (1, 2, 3, 5, 7, 10, 100, 1000):
        for sg in (1, -1):
            c = (Fr(1) + Fr(sg * h, m), Fr(0), Fr(0), Fr(-sg * k, m))
            D = P.ksub(P.ONE, P.kmul(c, c))
            if P.ksign(D) > 0 and fsign(D) <= 0 and not P.k_is_square(D):
                found = (c, D)
                break
        if found:
            break
    if found:
        break
if found is None:
    verdict(3, False, "no adversarial cosine constructed")
else:
    c, D = found
    print(f"    cos   = {B.kstr(c)}")
    print(f"    sin^2 = {B.kstr(D)}")
    print(f"      true sign +1 (a real rotation); float value {B.kfloat(D):+.4e} -> float sign {fsign(D)}")

    def accepts(M):
        try:
            M.CrossLaw.collinear(c)
            return "accepted"
        except ValueError:
            return "REFUSED"

    ab, apt = accepts(B), accepts(P)
    print(f"    baseline: {ab}     today: {apt}")
    verdict(3, ab == "REFUSED" and apt == "accepted",
            "the float test refuses a real rotation, so the candidate vanishes in silence")

# ============================================================ C4  parts_lattice disk cut
control(4, "parts_lattice's float disk test ADMITTING a point outside the disk")
print("    uninformative: at r = 2.0 and 2.44 the two predicates agree on every tuple (they DO),")
print("    so the control must place the radius exactly at a lattice point's own modulus.")


def old_pred(a, b, c, d, L):
    R33, R3, R11 = 33 ** 0.5, 3 ** 0.5, 11 ** 0.5
    return ((a + b * R33) ** 2 + (c * R3 + d * R11) ** 2 <= L + 1e-9 and
            (a - b * R33) ** 2 + (c * R3 - d * R11) ** 2 <= L + 1e-9)


def new_pred(a, b, c, d, Lx):
    S, Pp = a * a + 33 * b * b + 3 * c * c + 11 * d * d, a * b + c * d
    g = Lx - S
    return g >= 0 and g * g >= 132 * Pp * Pp


hit = None
for a in range(0, 14):
    for b in range(0, 3):
        for cc in range(0, 8):
            for d in range(0, 6):
                if (a - b) % 2 or (a - cc) % 2 or (a - d) % 2 or (a - b + cc + d) % 4:
                    continue
                S, Pp = a * a + 33 * b * b + 3 * cc * cc + 11 * d * d, a * b + cc * d
                if S == 0:
                    continue
                V = S + 2 * abs(Pp) * (33 ** 0.5)
                r = math.sqrt(V) / 12
                L, Lx = (12.0 * r) ** 2, Fr(144) * Fr(r) * Fr(r)
                o, n = old_pred(a, b, cc, d, L), new_pred(a, b, cc, d, Lx)
                if o != n:
                    hit = (a, b, cc, d, r, Lx, S, Pp, o, n)
                    break
            if hit: break
        if hit: break
    if hit: break
if hit is None:
    verdict(4, False, "no disagreement found in the scanned box")
else:
    a, b, cc, d, r, Lx, S, Pp, o, n = hit
    over = float(Fr(S) - Lx) + 2 * abs(Pp) * (33 ** 0.5)
    print(f"    tuple (a,b,c,d) = {(a, b, cc, d)} at r = {r!r}")
    print(f"    exact: S={S}, P={Pp}; its modulus exceeds the disk by {over:+.4e} -- outside")
    print(f"    baseline float predicate: {'ADMITS' if o else 'rejects'}    today exact: {'admits' if n else 'REJECTS'}")
    verdict(4, o and not n, "the 1e-9 slack admits a point outside the disk; the exact test rejects it")

# ============================================================ C5  the rho15 ray keys
control(5, "cross_edges_rho15_fast MISSING a real cross edge -- the antipodal gap")
print("    uninformative: on parts_lattice(2.0/2.44) old and new return the identical 126 edges")
print("    (they DO), so the control must use a point set holding an antipodal solution.")
K = lambda q: (Fr(q), Fr(0), Fr(0), Fr(0))
u = (K(Fr(31, 61)), K(0))
v = (K(Fr(-32, 61)), K(0))
nu, nv = B.norm2(u), B.norm2(v)
pp_, qq = B.conj_mul(u, v)
want = B.kscale(B.ksub(B.kadd(nu, nv), B.ONE), Fr(4, 7))
print(f"    (31/61, 0) and (-32/61, 0): the rational point of 4t^2 - 7tv + 4v^2 = 4 with t, v of")
print(f"    OPPOSITE sign. q = 0 and p = want = {B.kstr(pp_)}, so the law holds; and")
print(f"    |u|^2 + |v|^2 = {B.kstr(B.kadd(nu, nv))} < 1, which is what lets an antipodal pair join.")
pts5 = [(B.Z, B.Z), u, v]
eb, ep = set(B.cross_edges_rho15_fast(pts5)), set(P.cross_edges_rho15_fast(pts5))
print(f"    baseline float-ray law: {len(eb)} edges {sorted(eb)}")
print(f"    today exact-line law  : {len(ep)} edges {sorted(ep)}")
verdict(5, (1, 2) in ep and (1, 2) not in eb,
        f"signed ray keys separate antipodes, so the baseline MISSES {len(ep - eb)} real cross edge(s)")

# ============================================================ C6  radius_families identity
control(6, "radius_families INFLATING a kind count when two distinct radii share a float")
print("    uninformative: no two distinct K radii collide as floats.")
pair = None
for x, s, _ in pr:
    a6 = K(1)
    b6 = B.kadd(a6, x)
    if a6 != b6 and B.kfloat(a6) == B.kfloat(b6):
        pair = (a6, b6, x)
        break
if pair is None:
    verdict(6, False, "no float-colliding pair of radii found")
else:
    a6, b6, x = pair
    print(f"    a = 1, b = 1 + ({B.kstr(x)});  a != b: {a6 != b6};  float(a) == float(b): "
          f"{B.kfloat(a6) == B.kfloat(b6)}")
    ent = [(a6, b6, 1), (b6, a6, 1)]
    fb, fp = B.radius_families(ent), P.radius_families(ent)
    print(f"    baseline gives {len(fb)} kind(s); today gives {len(fp)} for ONE unordered pair")
    verdict(6, len(fb) == 2 and len(fp) == 1, "the float ordering counts one unordered pair twice")

print("\n" + "=" * 78)
print("ALL CONTROLS FIRED" if not DEAD else f"CONTROLS THAT DID NOT FIRE: {DEAD}")
sys.exit(1 if DEAD else 0)
