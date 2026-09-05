#!/usr/bin/env python3
"""wall_break_test — the exact 2-adic classifier of a radicand r ∈ K = ℚ(√3, √11): does adjoining
√r to K break the field wall? (the field-wall note §6–§7.3, 2026-09-05)

The wall stands for a real field F iff some completion of F above 2 lacks √−1 (then a conjugation-
fixed prime of norm ≤ 4 exists and the residue colouring is a 4-colouring of F²). K has two primes
above 2, both with completion ℚ₂(√3) (the two 2-adic embeddings √33 ↦ ±S). For r ∈ K with images
r₁, r₂ ∈ ℚ₂(√3): K(√r) has i in EVERY completion above 2 iff −r₁ and −r₂ are both squares in
ℚ₂(√3). A SET of radicands breaks the wall iff the class of −1 lies in the 𝔽₂-span of their
square classes at BOTH primes (F×/F×² ≅ (ℤ/2)⁴ for F = ℚ₂(√3)); single-point breakers are the
radicands whose class pair is exactly (−1, −1).

    python3 tools/wall_break_test.py --self-test
    python3 tools/wall_break_test.py --object <label> [--result build/m54/wallbreak-<label>.json]

Squareness in ℚ₂(√3) is decided exactly: x = α + β√3 is a square iff N(x) = α² − 3β² is a
ℚ₂-square n² and (α + n)/2 or (α − n)/2 is a ℚ₂-square (then p = √((α ± n)/2), q = β/(2p)); a
ℚ₂-number is a square iff its valuation is even and its unit part ≡ 1 (mod 8). 2-adic roots are
Hensel-lifted to 200 bits; every quantity tested has valuation far below that. UNTRUSTED like all
of tools/; the theorem it instantiates is the note's §6.1–§6.2.
"""
from __future__ import annotations
import argparse, itertools, json, sys, time
from collections import defaultdict
from fractions import Fraction as Fr
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))

ROOT = Path(__file__).resolve().parent.parent
N_BITS = 200
MOD = 1 << N_BITS


def v2(n: int) -> int:
    n = abs(n); c = 0
    while n and n % 2 == 0:
        n //= 2; c += 1
    return c


def q2_val_unit(x: Fr):
    """(valuation, unit part mod 8) of a nonzero rational read 2-adically."""
    assert x != 0
    a, b = x.numerator, x.denominator
    va, vb = v2(a), v2(b)
    assert va < N_BITS - 40 and vb < N_BITS - 40, "precision guard: valuation too close to the 2-adic working precision"
    ua, ub = (a >> va) if va else a, (b >> vb) if vb else b
    return va - vb, (ua * pow(ub, -1, 8)) % 8


def q2_is_square(x: Fr) -> bool:
    if x == 0:
        return True
    v, u = q2_val_unit(x)
    return v % 2 == 0 and u == 1


def q2_sqrt(x: Fr):
    """A rational whose 2-adic value is ≡ √x (mod 2^(N_BITS−…)), or None if x is not a 2-adic square."""
    if x == 0:
        return Fr(0)
    if not q2_is_square(x):
        return None
    a, b = x.numerator, x.denominator
    m = a * b                                   # x = m / b², so √x = √m / b
    v = v2(m); m >>= v
    r = 1
    for k in range(3, N_BITS):                  # r² ≡ m (mod 2^(k+1)), lifting one bit per step
        if (r * r - m) % (1 << (k + 1)):
            r += 1 << (k - 1)
    assert (r * r - m) % MOD == 0
    return Fr(r << (v // 2), b)


def f_is_square(x) -> bool:
    """x = (α, β) meaning α + β√3 ∈ ℚ₂(√3): is it a square there?"""
    al, be = x
    if al == 0 and be == 0:
        return True
    if be == 0:
        return q2_is_square(al) or q2_is_square(3 * al)
    n = q2_sqrt(al * al - 3 * be * be)
    if n is None:
        return False
    return q2_is_square((al + n) / 2) or q2_is_square((al - n) / 2)


def f_mul(x, y):
    return (x[0] * y[0] + 3 * x[1] * y[1], x[0] * y[1] + x[1] * y[0])


def f_neg(x):
    return (-x[0], -x[1])


class SquareClasses:
    """F×/F×² for F = ℚ₂(√3): a basis found by search, classes as 4-bit vectors."""
    def __init__(self):
        cands = [(Fr(-1), Fr(1)), (Fr(-1), Fr(0)), (Fr(5), Fr(0)), (Fr(0), Fr(1)), (Fr(1), Fr(2)), (Fr(3), Fr(0)),
                 (Fr(7), Fr(0)), (Fr(1), Fr(1)), (Fr(2), Fr(1)), (Fr(2), Fr(0)), (Fr(1), Fr(4))]
        basis = []
        for g in cands:
            if len(basis) == 4:
                break
            indep = True
            for k in range(0, len(basis) + 1):
                for S in itertools.combinations(basis, k):
                    p = g
                    for s in S:
                        p = f_mul(p, s)
                    if f_is_square(p):
                        indep = False
            if indep:
                basis.append(g)
        assert len(basis) == 4, ("no basis of F×/F×² found among the candidates", basis)
        self.basis = basis
        self.subsets = [tuple(S) for k in range(5) for S in itertools.combinations(range(4), k)]
        self.minus_one = self.bits((Fr(-1), Fr(0)))

    def bits(self, x) -> int:
        hits = []
        for S in self.subsets:
            p = x
            for i in S:
                p = f_mul(p, self.basis[i])
            if f_is_square(p):
                hits.append(S)
        assert len(hits) == 1, ("a class must be hit by exactly one subset", x, hits)
        return sum(1 << i for i in hits[0])


def embeddings(r, S: int):
    """r ∈ K as four Fractions (1, √3, √11, √33) → its two images in ℚ₂(√3) as (α, β) pairs."""
    a, b, c, d = r
    out = []
    for s in (S, -S):
        out.append((a + d * s, b + c * Fr(s, 3)))
    return out


def classify_radicand(r, S: int, sq: SquareClasses):
    imgs = embeddings(r, S)
    bits = tuple(sq.bits(x) for x in imgs)
    neg_square = tuple(f_is_square(f_neg(x)) for x in imgs)
    return {"bits": bits, "breaks_alone": all(neg_square), "neg_square": neg_square,
            "square_at": tuple(f_is_square(x) for x in imgs)}


def span_contains(vectors, target, dim=8):
    """𝔽₂ linear algebra: rank and whether target ∈ span; vectors as ints of `dim` bits."""
    rows = []
    for v in vectors:
        for r in rows:
            v = min(v, v ^ r)
        if v:
            rows.append(v); rows.sort(reverse=True)
    t = target
    for r in rows:
        t = min(t, t ^ r)
    return len(rows), t == 0


PLANTED = {  # rational radicands: (expected breaks_alone) — the note's §6.2 table, and two non-rational ones
    (1, 0, 0, 0): False, (2, 0, 0, 0): False, (3, 0, 0, 0): False, (5, 0, 0, 0): True, (7, 0, 0, 0): True,
    (10, 0, 0, 0): False, (11, 0, 0, 0): False, (13, 0, 0, 0): True, (14, 0, 0, 0): False, (15, 0, 0, 0): True,
    (21, 0, 0, 0): True, (23, 0, 0, 0): True, (33, 0, 0, 0): False, (35, 0, 0, 0): False, (70, 0, 0, 0): False,
    (1, 1, 0, 0): False,      # 1 + √3: N(−r) = −2, odd valuation
    (2, 1, 0, 0): False,      # 2 + √3 = a unit with square norm; −r not a square (both (α±n)/2 have odd valuation)
    (7, 4, 0, 0): False,      # (2 + √3)²: a K-square (in-field); −r square iff −1 is: no
    (35, 20, 0, 0): True,     # 5·(2 + √3)²: −r square iff −5 is: yes (−5 ≡ 3·1 mod 8 → 3·square)
    (0, 0, 0, 1): False,      # √33 itself: a unit at both primes; −√33 ↦ ∓s, s ≡ 1 mod 16 → −s ≡ 7 mod 8: not a square
    (4, 0, 0, 0): False,      # 4: a square; −4 = −1·4: not
}


def self_test(S: int):
    sq = SquareClasses()
    assert sq.minus_one != 0, "−1 must not be a square in ℚ₂(√3)"
    # the sixteen classes are distinct and −1's class is what Theorem 6 uses
    seen = set()
    for Sb in sq.subsets:
        p = (Fr(1), Fr(0))
        for i in Sb:
            p = f_mul(p, sq.basis[i])
        seen.add(sq.bits(p))
    assert len(seen) == 16, "the basis must generate sixteen distinct classes"
    bad = []
    for r, exp in PLANTED.items():
        got = classify_radicand(tuple(Fr(c) for c in r), S, sq)["breaks_alone"]
        if got != exp:
            bad.append((r, exp, got))
    assert not bad, ("planted radicands disagree with the note's table", bad)
    # the planted 2-adic facts behind the table
    assert q2_is_square(Fr(33)) and not q2_is_square(Fr(-1)) and q2_is_square(Fr(-7)) and q2_is_square(Fr(-15))
    assert f_is_square((Fr(-5), Fr(0))) and not f_is_square((Fr(-2), Fr(0))) and not f_is_square((Fr(-35), Fr(0)))
    print(f"[wall] self-test green: basis {[(str(a), str(b)) for a, b in sq.basis]}, class(−1) = {sq.minus_one:04b}, "
          f"{len(PLANTED)} planted radicands classified as the note's table says")
    return sq


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--self-test", action="store_true"); ap.add_argument("--object", default=None)
    ap.add_argument("--result", default=None)
    a = ap.parse_args()
    from residue_colouring import sqrt33_2adic
    S = sqrt33_2adic(17)
    sq = self_test(S)
    if not a.object:
        return
    t0 = time.time()
    import batchkill as BK
    from pool_field_restrict import exact_points, object_pairs
    from copy_exact_field import K
    from pool_field_census import k_inv
    obj, _ = BK.load_object(a.object)
    pts = exact_points(a.object)
    pairs = object_pairs(obj)
    print(f"[wall] {a.object}: {len(pairs):,} live pairs at distance < 2; computing radicands 4/d² − 1 exactly in K …", flush=True)
    four, one = K(4), K(1)
    counts = defaultdict(int); ex_pair = {}
    for u, v in pairs:
        dx, dy = pts[u][0] - pts[v][0], pts[u][1] - pts[v][1]
        r = four * k_inv(dx * dx + dy * dy) - one
        counts[r.c] += 1
        ex_pair.setdefault(r.c, (u, v))
    print(f"[wall] {len(counts):,} distinct radicands [{time.time()-t0:.0f}s]; classifying 2-adically …", flush=True)
    from pool_field_restrict import sqrt_K
    rows = []
    for key, n in counts.items():
        cl = classify_radicand(key, S, sq)
        infield = sqrt_K(K(*key)) is not None
        rows.append({"radicand": [[c.numerator, c.denominator] for c in key], "pairs": n, "in_field": infield,
                     "bits": list(cl["bits"]), "breaks_alone": cl["breaks_alone"], "neg_square": list(cl["neg_square"]),
                     "square_at": list(cl["square_at"]), "example_pair": list(ex_pair[key])})
    tot_pairs = sum(r["pairs"] for r in rows)
    brk = [r for r in rows if r["breaks_alone"]]
    inf = [r for r in rows if r["in_field"]]
    one_side = [r for r in rows if not r["breaks_alone"] and any(r["neg_square"])]
    print(f"[wall] radicands {len(rows):,} over {tot_pairs:,} pairs: in-field {len(inf)} ({sum(r['pairs'] for r in inf):,} pairs); "
          f"WALL-BREAKING ALONE {len(brk)} radicands, {sum(r['pairs'] for r in brk):,} pairs; "
          f"breaking at exactly one prime {len(one_side)} radicands, {sum(r['pairs'] for r in one_side):,} pairs")
    for r in sorted(brk, key=lambda r: -r["pairs"])[:12]:
        print(f"        breaker: r = {r['radicand']} pairs {r['pairs']:,} bits {r['bits']} e.g. pair {r['example_pair']}")
    # the F2-span of the out-of-field classes, and the small combinations that break
    target = (sq.minus_one << 4) | sq.minus_one
    vecs = [(r["bits"][0] << 4) | r["bits"][1] for r in rows if not r["in_field"]]
    rank, hit = span_contains(vecs, target)
    dist = defaultdict(int)
    for r in rows:
        if not r["in_field"]:
            dist[tuple(r["bits"])] += r["pairs"]
    pair_breaks = 0
    classes = list(dist.keys())
    for i in range(len(classes)):
        for j in range(i + 1, len(classes)):
            b1, b2 = classes[i], classes[j]
            if (b1[0] ^ b2[0]) == sq.minus_one and (b1[1] ^ b2[1]) == sq.minus_one:
                pair_breaks += 1
    print(f"[wall] out-of-field class pairs: {len(dist)} distinct of 256 possible; 𝔽₂-rank {rank} of 8; (−1,−1) ∈ span: {hit}; "
          f"two-class combinations that jointly break: {pair_breaks}")
    top = sorted(dist.items(), key=lambda kv: -kv[1])[:10]
    print("[wall] top out-of-field class pairs by pair count: " + ", ".join(f"({b[0]:04b},{b[1]:04b}):{n:,}" for b, n in top))
    out = {"kind": "wall-break-census", "object": a.object, "pairs": tot_pairs, "radicands": len(rows),
           "in_field": {"radicands": len(inf), "pairs": sum(r["pairs"] for r in inf)},
           "breaks_alone": {"radicands": len(brk), "pairs": sum(r["pairs"] for r in brk)},
           "one_prime_only": {"radicands": len(one_side), "pairs": sum(r["pairs"] for r in one_side)},
           "class_minus_one": sq.minus_one, "basis": [[str(a), str(b)] for a, b in sq.basis],
           "span": {"rank": rank, "contains_target": hit, "distinct_class_pairs": len(dist), "two_class_breakers": pair_breaks},
           "class_pair_counts": [[list(b), n] for b, n in sorted(dist.items(), key=lambda kv: -kv[1])],
           "table": rows, "seconds": round(time.time() - t0, 1),
           "claim_scope": ("every live pair at distance < 2 of the object; radicand 4/d² − 1 exact in K; squareness in ℚ₂(√3) decided "
                           "by the norm-and-half criterion at 200 2-adic bits; 'breaks_alone' = −r a square at BOTH 2-adic primes "
                           "(K(√r) has i in every completion above 2, so no conjugation-fixed prime of norm ≤ 4 remains)")}
    if a.result:
        Path(a.result).write_text(json.dumps(out, indent=1)); print(f"[wall] wrote {a.result}")


if __name__ == "__main__":
    main()
