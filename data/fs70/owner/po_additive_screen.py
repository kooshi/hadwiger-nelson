#!/usr/bin/env python3
"""Owner's independent re-derivation of the planner's additive screen (plan §2.2, §3.4), sharing no code with tools/fs70_*.

Field elements: integer 4-tuples (a,b,c,d) = a + b√3 + c√5 + d√15 over a denominator.  A complex number z = x + iy of E = F(i)
is a pair of such; as a Z-module element it is the integer 8-vector (x, y) over the lattice denominator M.

1. Unit vectors of F² with denominator dividing M: brute force over the box the four real embeddings force
   (|a ± b√3 ± c√5 ± d√15| ≤ M for every sign pattern), exact test x² + y² = 1.
2. Λ = Z-span of the given generators (as integer 8-vectors over M); a Z-basis by sympy's HNF; membership by solving.
3. Λ ∩ U from step 1 filtered by membership.  Since every unit vector of Λ has denominator dividing M, this is exhaustive.
4. Hom(Λ, Z/4) and Hom(Λ, (Z/2)²): all |G|^rank maps on the basis; keep those nonzero on Λ ∩ U; read φ at i√3, 2, 4/3, 8/3.
"""
import itertools, sys
from math import sqrt, gcd
from fractions import Fraction
from sympy import Matrix, ZZ
from sympy.matrices.normalforms import hermite_normal_form

S3, S5, S15 = sqrt(3), sqrt(5), sqrt(15)

def fmul(p, q):
    a1, b1, c1, d1 = p; a2, b2, c2, d2 = q
    return (a1*a2 + 3*b1*b2 + 5*c1*c2 + 15*d1*d2,
            a1*b2 + b1*a2 + 5*(c1*d2 + d1*c2),
            a1*c2 + c1*a2 + 3*(b1*d2 + d1*b2),
            a1*d2 + d1*a2 + b1*c2 + c1*b2)

def fadd(p, q): return tuple(x + y for x, y in zip(p, q))
def fsub(p, q): return tuple(x - y for x, y in zip(p, q))
def fscale(p, k): return tuple(k * x for x in p)

def cmul(z, w):
    """complex product of z = (x, y), w = (x', y') with field-element parts (numerators over a common denominator handled by caller)"""
    (x1, y1), (x2, y2) = z, w
    return (fsub(fmul(x1, x2), fmul(y1, y2)), fadd(fmul(x1, y2), fmul(y1, x2)))

def units_with_denominator(M):
    """all (x, y) in (1/M)Z^8 with x² + y² = 1, returned as integer 8-tuples over M"""
    box = []
    for a in range(-M, M + 1):
        for b in range(-int(M / S3) - 1, int(M / S3) + 2):
            for c in range(-int(M / S5) - 1, int(M / S5) + 2):
                for d in range(-int(M / S15) - 1, int(M / S15) + 2):
                    ok = True
                    for sb in (1, -1):
                        for sc in (1, -1):
                            if abs(a + sb * b * S3 + sc * c * S5 + sb * sc * d * S15) > M + 1e-9:
                                ok = False
                    if ok:
                        box.append((a, b, c, d))
    sq = {}
    for e in box:
        sq.setdefault(fmul(e, e), []).append(e)
    target = (M * M, 0, 0, 0)
    out = set()
    for e, s in ((e, fmul(e, e)) for e in box):
        need = fsub(target, s)
        for f in sq.get(need, []):
            out.add(e + f)
    return sorted(out)

def to_vec(z, M):
    """z = ((x-tuple), (y-tuple)) with denominator m -> integer 8-vector over M"""
    (x, y), m = z
    assert M % m == 0
    k = M // m
    return tuple(k * v for v in x) + tuple(k * v for v in y)

def main():
    # generators: ζ12 = (√3/2, 1/2) over 2; u = (-2/3, √5/3) over 3; ū.  M = 6.
    M = 6
    zeta = (((0, 1, 0, 0), (1, 0, 0, 0)), 2)
    u = (((-2, 0, 0, 0), (0, 0, 1, 0)), 3)
    ubar = (((-2, 0, 0, 0), (0, 0, -1, 0)), 3)
    one = (((1, 0, 0, 0), (0, 0, 0, 0)), 1)

    def cpow_orbit(base):
        """ζ12^m · base, m = 0..11, as (x,y) over denominator base_m * 2^? — we multiply by ζ12 twelve times, denominators 2^m: normalise by gcd"""
        outs = []
        z = base
        for _ in range(12):
            outs.append(z)
            (x, y), m = z
            (nx, ny) = cmul((x, y), zeta[0])
            nm = m * 2
            g = 0
            for v in nx + ny + (nm,):
                g = gcd(g, abs(v))
            z = ((tuple(v // g for v in nx), tuple(v // g for v in ny)), nm // g)
        return outs

    gens = cpow_orbit(one) + cpow_orbit(u) + cpow_orbit(ubar)
    G = Matrix([list(to_vec(z, M)) for z in gens])            # rows = generators, over M
    H = hermite_normal_form(G.T)                               # columns span the lattice
    B = [tuple(int(v) for v in H[:, j]) for j in range(H.shape[1])]
    B = [b for b in B if any(b)]
    rank = len(B)
    Bm = Matrix(B).T                                           # 8 x rank
    print(f"rank {rank}")

    def coords(vec):
        sol = Bm.solve(Matrix(vec))  # rational; must be integral for membership
        cs = [Fraction(int(s.p), int(s.q)) for s in sol]
        if all(c.denominator == 1 for c in cs):
            return [int(c) for c in cs]
        return None

    U = units_with_denominator(M)
    print(f"unit vectors with denominator | {M}: {len(U)}")
    LU = [(vec, coords(vec)) for vec in U]
    LU = [(vec, c) for vec, c in LU if c is not None]
    print(f"unit vectors IN the lattice: g = {len(LU)}")

    def tup(z):  # a field element pair over denominator m -> 8-vector over M
        return to_vec(z, M)

    targets = {
        "i√3": coords(tup((((0, 0, 0, 0), (0, 1, 0, 0)), 1))),
        "2":   coords(tup((((2, 0, 0, 0), (0, 0, 0, 0)), 1))),
        "4/3": coords(tup((((4, 0, 0, 0), (0, 0, 0, 0)), 3))),
        "8/3": coords(tup((((8, 0, 0, 0), (0, 0, 0, 0)), 3))),
        "1/3": coords(tup((((1, 0, 0, 0), (0, 0, 0, 0)), 3))),
    }
    print("targets in the lattice:", {k: (v is not None) for k, v in targets.items()})

    for name, group_vals, addf in (("Z/4", range(4), lambda a, b: (a + b) % 4),
                                   ("Klein", range(4), lambda a, b: a ^ b)):
        count = 0
        kills = {k: 0 for k in targets}
        for phi in itertools.product(group_vals, repeat=rank):
            def ev(c):
                s = 0
                for ci, pi in zip(c, phi):
                    for _ in range(abs(ci) % 4):
                        s = addf(s, pi if ci > 0 else (( -pi) % 4 if name == "Z/4" else pi))
                return s
            ok = all(ev(c) != 0 for _, c in LU)
            if not ok:
                continue
            count += 1
            for k, c in targets.items():
                if c is not None and ev(c) == 0:
                    kills[k] += 1
        print(f"{name}: additive 4-colourings nonzero on all {len(LU)} unit vectors: {count}; of which φ(target)=0:", kills)

if __name__ == "__main__":
    main()
