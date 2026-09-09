#!/usr/bin/env python3
"""copy_exact_field — EXACT coordinates of a descent object in ℚ(√3, √11), and of its ρ₁₅ copies in
ℚ(√3, √5, √11), with every unit edge verified by exact rational arithmetic (M52 phase 1/2; the
finding that made it necessary: PSLQ says all 1,953 points of the it-4 object are in the seed field,
which the Moser lattice (our former "direction ladder", T13) implies — every glue point is a parent plus a ladder unit vector).

    python3 tools/copy_exact_field.py --object <label> [--dps 60]

Method. Seed points carry exact 4-basis coordinates already (`Obj.seed_exact_pts`). For each halo
point, PSLQ finds an integer relation between each coordinate and {1, √3, √11, √33} (dps digits,
maxcoeff 1e10), the residual is checked at dps − 10 digits, and the coordinate becomes an element of
K = ℚ(√3, √11) with rational components. Copy points are DERIVED exactly: c + ρ₁₅^±(p − c) with
ρ₁₅ = (7 + i√15)/8, in K(√5) (an element is A + √5·B with A, B ∈ K; √15·y = √5·(√3·y)). Then every
unit edge of the object is verified as an EXACT identity (Δx² + Δy² = 1 in K(√5), Fraction
arithmetic, no floating point) — the certificate's geometry table, at the tools level. The output
`data/m52/exact-<label>.json` holds the integer-tuple coordinates over a common denominator and the
verification counts; a single failed edge is a loud refusal, never a warning."""
from __future__ import annotations
import argparse, json, sys, time
from fractions import Fraction as Fr
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import mpmath as mp
import batchkill as B

OUT = Path(__file__).resolve().parent.parent / "data" / "m52"


class K:
    """ℚ(√3, √11) with basis (1, √3, √11, √33)."""
    __slots__ = ("c",)
    def __init__(self, c0=0, c1=0, c2=0, c3=0):
        self.c = (Fr(c0), Fr(c1), Fr(c2), Fr(c3))
    def __add__(self, o): return K(*(a + b for a, b in zip(self.c, o.c)))
    def __sub__(self, o): return K(*(a - b for a, b in zip(self.c, o.c)))
    def __neg__(self): return K(*(-a for a in self.c))
    def __mul__(self, o):
        a0, a1, a2, a3 = self.c; b0, b1, b2, b3 = o.c
        # √3² = 3, √11² = 11, √33² = 33, √3√11 = √33, √3√33 = 3√11, √11√33 = 11√3
        return K(a0*b0 + 3*a1*b1 + 11*a2*b2 + 33*a3*b3,
                 a0*b1 + a1*b0 + 11*(a2*b3 + a3*b2),
                 a0*b2 + a2*b0 + 3*(a1*b3 + a3*b1),
                 a0*b3 + a3*b0 + a1*b2 + a2*b1)
    def scale(self, q): return K(*(a * Fr(q) for a in self.c))
    def is_zero(self): return all(a == 0 for a in self.c)
    def __eq__(self, o): return self.c == o.c
    def mp(self):
        a0, a1, a2, a3 = self.c
        return mp.mpf(a0.numerator)/a0.denominator + mp.mpf(a1.numerator)/a1.denominator*mp.sqrt(3) \
            + mp.mpf(a2.numerator)/a2.denominator*mp.sqrt(11) + mp.mpf(a3.numerator)/a3.denominator*mp.sqrt(33)
    def json(self): return [[a.numerator, a.denominator] for a in self.c]


class K5:
    """K(√5): A + √5·B."""
    __slots__ = ("A", "B")
    def __init__(self, A: K, B: K | None = None):
        self.A = A; self.B = B if B is not None else K()
    def __add__(self, o): return K5(self.A + o.A, self.B + o.B)
    def __sub__(self, o): return K5(self.A - o.A, self.B - o.B)
    def __mul__(self, o): return K5(self.A * o.A + (self.B * o.B).scale(5), self.A * o.B + self.B * o.A)
    def is_zero(self): return self.A.is_zero() and self.B.is_zero()
    def __eq__(self, o): return self.A == o.A and self.B == o.B


ONE = K5(K(1))


def pslq_coord(x, dps):
    """x ∈ K from an integer relation; None if PSLQ finds no relation with coefficients ≤ 1e10."""
    if abs(x) < mp.mpf(10) ** (-(dps - 10)):
        return K()
    rel = mp.pslq([x, 1, mp.sqrt(3), mp.sqrt(11), mp.sqrt(33)], maxcoeff=10 ** 10, maxsteps=10 ** 5)
    if not rel or rel[0] == 0:
        return None
    k = K(*(Fr(-r, rel[0]) for r in rel[1:]))
    if abs(k.mp() - x) >= mp.mpf(10) ** (-(dps - 10)):
        return None                                        # a spurious relation, refused
    return k


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--object", required=True); ap.add_argument("--dps", type=int, default=60)
    a = ap.parse_args()
    t0 = time.time(); mp.mp.dps = a.dps
    obj, removed = B.load_object(a.object)
    ex = obj.mp_values(a.dps)
    live = [i for i in range(obj.n) if i not in obj.deleted]
    X: dict[int, K5] = {}; Y: dict[int, K5] = {}
    failed = []
    for i in live:
        rec = obj.prov[i]
        if rec[0] == "seed":
            sa, sb, sc, sd = obj.seed_exact_pts[rec[1]]       # x = (a√3 + b√11)/12, y = (c + d√33)/12
            X[i] = K5(K(0, Fr(sa, 12), Fr(sb, 12), 0)); Y[i] = K5(K(Fr(sc, 12), 0, 0, Fr(sd, 12)))
        elif rec[0] == "glue":
            kx = pslq_coord(ex[i].real, a.dps); ky = pslq_coord(ex[i].imag, a.dps)
            if kx is None or ky is None:
                failed.append(i); continue
            X[i] = K5(kx); Y[i] = K5(ky)
    if failed:
        print(f"[exact] {len(failed)} halo points have NO relation in K at maxcoeff 1e10: {failed[:10]} — the object is not in the seed field (or the bound is too small)", flush=True)
    # copies: derived exactly — (x + iy) ↦ c + ρ(p − c), ρ = 7/8 + i√15/8 = 7/8 + i·√5·(√3/8)
    seven8 = K5(K(Fr(7, 8))); s15 = K5(K(), K(0, Fr(1, 8)))    # √15/8 = √5·(√3/8)
    for i in live:
        rec = obj.prov[i]
        if rec[0] != "rot": continue
        _, c, srcp, sgn = rec
        if srcp in failed or c in failed:
            failed.append(i); continue
        dx, dy = X[srcp] - X[c], Y[srcp] - Y[c]
        s = s15 if sgn > 0 else K5(K(), K(0, Fr(-1, 8)))
        X[i] = X[c] + seven8 * dx - s * dy
        Y[i] = Y[c] + s * dx + seven8 * dy
    # verify every unit edge exactly
    ue = obj.unit_edges()
    bad = []; checked = 0
    for u, v in ue:
        if u in failed or v in failed: continue
        dx, dy = X[u] - X[v], Y[u] - Y[v]
        if not (dx * dx + dy * dy - ONE).is_zero():
            bad.append((u, v))
        checked += 1
    # and the exact-rejected pairs must FAIL exactly (they are non-unit)
    nu_ok = sum(1 for u, v in obj.non_unit if not ((X[u]-X[v])*(X[u]-X[v]) + (Y[u]-Y[v])*(Y[u]-Y[v]) - ONE).is_zero())
    kinds = dict(seed=sum(1 for i in live if obj.prov[i][0] == "seed"), glue=sum(1 for i in live if obj.prov[i][0] == "glue"),
                 rot=sum(1 for i in live if obj.prov[i][0] == "rot"))
    print(f"[exact] {a.object}: {len(live)} live points {kinds}; {len(live) - len(failed)} with exact coordinates "
          f"(seed in K, glue by PSLQ into K, copies derived in K(√5)); unit edges verified EXACTLY {checked - len(bad)}/{checked}"
          f"{' — FAILED ' + str(bad[:6]) if bad else ''}; non_unit pairs exactly non-unit {nu_ok}/{len(obj.non_unit)} [{time.time()-t0:.0f}s]", flush=True)
    assert not bad, "an exact unit-edge identity FAILED — refused"
    out = dict(kind="exact-field", label=a.object, fingerprint=obj.fingerprint(removed), field="Q(sqrt3,sqrt11)" if not kinds["rot"] else "Q(sqrt3,sqrt5,sqrt11)",
               basis_K=["1", "sqrt3", "sqrt11", "sqrt33"], basis_K5="A + sqrt5*B, A,B in K",
               points={str(i): dict(x=[X[i].A.json(), X[i].B.json()], y=[Y[i].A.json(), Y[i].B.json()]) for i in live if i not in failed},
               failed=failed, unit_edges_verified=checked - len(bad), unit_edges_total=len(ue), non_unit_confirmed=nu_ok,
               dps=a.dps, seconds=round(time.time() - t0, 1),
               claim_scope="coordinates discovered by PSLQ (numeric), then every unit edge verified as an EXACT identity in "
                           "Fraction arithmetic over the stated basis; the identities are the claim, the discovery is not")
    OUT.mkdir(parents=True, exist_ok=True)
    (OUT / f"exact-{a.object}.json").write_text(json.dumps(out))
    print(f"[exact] wrote {OUT / ('exact-' + a.object + '.json')}")


if __name__ == "__main__":
    main()
