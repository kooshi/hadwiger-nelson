#!/usr/bin/env python3
"""pool_field_restrict — the depth-1 pool split by FIELD, exactly (M53 §B D5, §Bʹ.3/5, §Bʺ.4).

    python3 tools/pool_field_restrict.py --object <label> --base build/m51-pool-<bare>-depth1
    python3 tools/pool_field_restrict.py --object <label> --classify-only      # the radicand table alone
    python3 tools/pool_field_restrict.py --self-test

A glue point of two K-points at squared distance d² adjoins √r, r = 4/d² − 1 ∈ K = ℚ(√3, √11); it lies
in K² iff r is a SQUARE in K (a K-square gives coordinates m ± v√r ∈ K²; a non-square cannot, since
√r = (p − m)/v would then lie in K), so a pool point's field is a property of the point, an in-field
and an out-of-field pair can never produce the same point, and classifying by the recorded parents is
well-defined. Squareness in K is decided EXACTLY by the tower criterion ℚ ⊂ L = ℚ(√3) ⊂ K = L(√11): in
F(√m), x = a + b√m is a square iff (b = 0 and a or m·a is a square in F) or (b ≠ 0 and a² − m·b² = n²
for some n ∈ F with (a + n)/2 or (a − n)/2 a nonzero square u² in F; then x = (u + (b/2u)√m)²); the
base ℚ by integer roots of numerator and denominator. Every root found is VERIFIED by squaring in K;
PSLQ (the census tool's method, `pool_field_census.sqrt_in_K`) is the cross-check and must agree on
every radicand or the export refuses. The two restricted exports are NAMED pools of the object
(`depth1-infield`, `depth1-outfield`), fingerprinted under exactly those names so `batchkill.load_pool`
accepts them and the Python design / lookup / commit can consume them like any pool (the it-4
`pool_restrict.py` exports were engine-only for want of this). Soundness for every phase is the
restricted-pool rule: a kill on the slice transfers to the full pool, a survival is conservative.
UNTRUSTED like all of tools/."""
from __future__ import annotations
import argparse, hashlib, json, random, sys, time
from fractions import Fraction as Fr
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import numpy as np
import batchkill as BK  # noqa: E402
from copy_exact_field import K  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
M52 = ROOT / "data" / "m52"
M53 = ROOT / "data" / "m53"


# ------------------------------------------------------- the tower square test

def sqrt_Q(r: Fr):
    """A rational root of r, or None."""
    if r < 0:
        return None
    from math import isqrt
    p, q = r.numerator, r.denominator
    sp, sq = isqrt(p), isqrt(q)
    return Fr(sp, sq) if sp * sp == p and sq * sq == q else None


def sqrt_ext(x, m: int, sqrt_base, mul, sub, add, zero, is_zero, half):
    """A root of x = a + b√m in F(√m), given F's own root finder and arithmetic; None if x is not a
    square. x is a pair (a, b) of F-elements. Returns a pair (u, w) with (u + w√m)² = x."""
    a, b = x
    if is_zero(b):
        s = sqrt_base(a)
        if s is not None:
            return (s, zero)
        s = sqrt_base(div_scalar(a, m, mul))          # a = m·s²  ⟹  √a = s√m
        return (zero, s) if s is not None else None
    N = sub(mul(a, a), scal(mul(b, b), m, mul))       # a² − m b²
    n = sqrt_base(N)
    if n is None:
        return None
    for sgn in (1, -1):
        t = half(add(a, scal(n, sgn, mul)))           # (a ± n)/2
        u = sqrt_base(t)
        if u is None or is_zero(u):
            continue
        w = mul(half(b), inv(u, mul, sub, add, zero, is_zero))   # b / (2u)
        return (u, w)
    return None


# L = ℚ(√3) as pairs (p, q); K = L(√11) as pairs (a, b) of L-pairs.
def L_mul(x, y): return (x[0] * y[0] + 3 * x[1] * y[1], x[0] * y[1] + x[1] * y[0])
def L_add(x, y): return (x[0] + y[0], x[1] + y[1])
def L_sub(x, y): return (x[0] - y[0], x[1] - y[1])
def L_zero(): return (Fr(0), Fr(0))
def L_is_zero(x): return x[0] == 0 and x[1] == 0
def L_half(x): return (x[0] / 2, x[1] / 2)
def L_inv(x):
    N = x[0] * x[0] - 3 * x[1] * x[1]
    return (x[0] / N, -x[1] / N)


def scal(x, k, mul):
    """k · x for an integer k, in whichever level `mul` belongs to."""
    if isinstance(x, Fr):
        return x * k
    if isinstance(x[0], Fr):
        return (x[0] * k, x[1] * k)
    return (scal(x[0], k, L_mul), scal(x[1], k, L_mul))


def div_scalar(x, k, mul):
    return scal(x, Fr(1, k), mul)


def inv(x, mul, sub, add, zero, is_zero):
    if isinstance(x, Fr):
        return 1 / x
    if isinstance(x[0], Fr):
        return L_inv(x)
    raise AssertionError("inverse at the K level is never needed by the criterion")


def sqrt_L(x):
    """x = (p, q) ∈ ℚ(√3); a root (u, w) with (u + w√3)² = x, or None."""
    return sqrt_ext(x, 3, sqrt_Q, lambda a, b: a * b, lambda a, b: a - b, lambda a, b: a + b, Fr(0),
                    lambda a: a == 0, lambda a: a / 2)


def K_pair(k: K):
    """K in the basis (1, √3, √11, √33) as (a, b) with a, b ∈ L: k = a + b√11."""
    c0, c1, c2, c3 = k.c
    return ((c0, c1), (c2, c3))


def K_of_pair(x) -> K:
    (a0, a1), (b0, b1) = x
    return K(a0, a1, b0, b1)


def sqrt_K(k: K):
    """A root of k in K = ℚ(√3, √11), VERIFIED by squaring, or None (k is not a square in K)."""
    x = K_pair(k)
    r = sqrt_ext(x, 11, sqrt_L, L_mul, L_sub, L_add, L_zero(), L_is_zero, L_half)
    if r is None:
        return None
    root = K_of_pair(r)
    assert (root * root) == k, "the tower criterion returned a non-root — the arithmetic is wrong"
    return root


# --------------------------------------------------------- the radicand table

def exact_points(label: str):
    ex = json.loads((M52 / f"exact-{label}.json").read_text())["points"]
    def kx(i, which):
        A_, B_ = ex[str(i)][which]
        assert all(nn == 0 for nn, dd in B_), ("a K(√5) point — this tool is for K-point objects", i)
        return K(*(Fr(nn, dd) for nn, dd in A_))
    return {int(i): (kx(i, "x"), kx(i, "y")) for i in ex}


def k_inv(a: K) -> K:
    from pool_field_census import k_inv as ki
    return ki(a)


def classify_pairs(obj, pts, pairs, dps: int = 50, cross_check: bool = True, log=print):
    """{(u, v): class} for the given object-index pairs, with the radicand table {r.c: {...}}; the
    class is 'in' (a K-square, root verified) or 'out'. PSLQ must agree on every distinct radicand."""
    import mpmath as mp
    from pool_field_census import sqrt_in_K
    mp.mp.dps = dps
    four, one = K(4), K(1)
    table: dict = {}; cls: dict = {}
    t0 = time.time()
    for u, v in pairs:
        dx, dy = pts[u][0] - pts[v][0], pts[u][1] - pts[v][1]
        d2 = dx * dx + dy * dy
        assert not d2.is_zero(), ("coincident points", u, v)
        r = four * k_inv(d2) - one
        key = r.c
        if key not in table:
            root = sqrt_K(r)
            rec = {"radicand": r.json(), "class": "in" if root is not None else "out",
                   "root": root.json() if root is not None else None}
            if cross_check:
                p = sqrt_in_K(r, dps)
                agree = (p is not None) == (root is not None)
                rec["pslq"] = "in" if p is not None else "out"
                if not agree:
                    raise SystemExit(f"[field] REFUSED: the tower criterion says {rec['class']} and PSLQ says {rec['pslq']} "
                                     f"for radicand {r.json()} (pair {u},{v}) — investigate before any export")
            table[key] = rec
        cls[(u, v)] = table[key]["class"]
    n_in = sum(1 for c in cls.values() if c == "in")
    log(f"[field] {len(pairs):,} pairs → {len(table):,} distinct radicands: {sum(1 for t in table.values() if t['class']=='in')} in-field "
        f"({n_in:,} pairs), {sum(1 for t in table.values() if t['class']=='out')} out-of-field ({len(pairs)-n_in:,} pairs); "
        f"PSLQ agreed on every radicand [{time.time()-t0:.0f}s]", flush=True)
    return cls, table


def object_pairs(obj):
    """Every live pair at distance < 2 (the pool builder's own screen), as object-index pairs."""
    from scipy.spatial import cKDTree
    live = [i for i in range(obj.n) if i not in obj.deleted]
    P = np.array([obj.pts[i] for i in live]); tree = cKDTree(P); lv = np.array(live)
    return sorted((int(lv[i]), int(lv[j])) if lv[i] < lv[j] else (int(lv[j]), int(lv[i])) for i, j in tree.query_pairs(2.0 - 1e-9))


# ------------------------------------------------------------------ the export

def restrict(base: Path, obj, cls: dict, which: str, table_meta: dict, log=print) -> Path:
    """A `pool-export` of the points whose parent pair is in class `which`, NAMED `depth1-<which>field`
    and fingerprinted under that name (so `load_pool` accepts it)."""
    man = json.loads(Path(str(base) + ".json").read_text()); z0 = np.load(str(base) + ".npz")
    assert man["object"]["fingerprint"] == obj.fingerprint(), "the base export is for another object"
    z = {k: (z0[k].astype(np.int64) if k.endswith("_indptr") else z0[k]) for k in z0.files}
    n = man["pool"]["n_points"]; prov = z["pool_prov"]
    keep = np.zeros(n, dtype=bool)
    for i in range(n):
        a, b, s = (int(x) for x in prov[i])
        assert a < obj.n and b < obj.n, ("a depth-1 pool point with a pool parent", i, a, b)
        key = (a, b) if a < b else (b, a)
        keep[i] = (cls[key] == which)
    old_idx = np.flatnonzero(keep); new_of = -np.ones(n, dtype=np.int64); new_of[old_idx] = np.arange(len(old_idx))
    def rows(ip, ix): return [ix[ip[i]:ip[i + 1]] for i in range(n)]
    def refilter(ip, ix, remap):
        R = rows(ip, ix); out = []
        for o in old_idx:
            out.append(np.sort(remap(R[o])))
        nip = np.zeros(len(old_idx) + 1, dtype=np.uint64)
        for k, r in enumerate(out):
            nip[k + 1] = nip[k] + len(r)
        return nip, (np.concatenate(out) if nip[-1] else np.array([], dtype=ix.dtype)).astype(ix.dtype)
    A = {}
    A["pool_seed_indptr"], A["pool_seed_idx"] = refilter(z["pool_seed_indptr"], z["pool_seed_idx"], lambda r: r)
    A["pool_halo_indptr"], A["pool_halo_idx"] = refilter(z["pool_halo_indptr"], z["pool_halo_idx"], lambda r: r)
    def adj_remap(r):
        m = new_of[r.astype(np.int64)]; return m[m >= 0]
    A["pool_adj_indptr"], A["pool_adj_idx"] = refilter(z["pool_adj_indptr"], z["pool_adj_idx"], adj_remap)
    for k in ("halo_seed_indptr", "halo_seed_idx", "halo_adj_indptr", "halo_adj_idx"):
        A[k] = z0[k]
    A["pool_prov"] = z["pool_prov"][old_idx]; A["pool_xy"] = z["pool_xy"][old_idx]
    name = f"depth1-{which}field"
    params = {"restrict": f"field={which}", "field": "Q(sqrt3,sqrt11)",
              "rule": "the parent pair's radicand 4/d^2-1 is a square in K (tower criterion, exact; root verified by squaring); "
                      "PSLQ cross-check agreed on every radicand", "exact_source": f"data/m52/exact-{obj_label(obj)}.json"}
    fp = BK._pool_fp(obj, name, params, [tuple(p) for p in A["pool_xy"].tolist()])
    out = BK._pool_cache_base(obj, name)
    np.savez(str(out) + ".npz", **A)
    m2 = json.loads(json.dumps(man))
    m2["pool"].update({"fingerprint": fp, "name": name, "params": params, "n_points": int(len(old_idx)), "ordering": "by-depth"})
    m2["arrays"] = {k: {"dtype": str(v.dtype), "shape": list(v.shape), "sha256": hashlib.sha256(np.ascontiguousarray(v).tobytes()).hexdigest()} for k, v in A.items()}
    m2["derived_from"] = {"manifest": base.name + ".json", "pool_fingerprint": man["pool"]["fingerprint"], "criterion": f"field={which}", **table_meta}
    Path(str(out) + ".json").write_text(json.dumps(m2, indent=1))
    log(f"[field] {name}: {len(old_idx):,} of {n:,} points ({100*len(old_idx)/n:.1f} %); pool–pool edges {int(A['pool_adj_indptr'][-1])//2:,}; "
        f"fp {fp} → {out}.{{json,npz}}", flush=True)
    return out


_LABEL = {}
def obj_label(obj):
    return _LABEL.get(id(obj), "?")


# ------------------------------------------------------------------- self-test

def self_test():
    rng = random.Random(11)
    def rnd_K():
        return K(*(Fr(rng.randint(-9, 9), rng.randint(1, 5)) for _ in range(4)))
    def rnd_L():
        return (Fr(rng.randint(-9, 9), rng.randint(1, 5)), Fr(rng.randint(-9, 9), rng.randint(1, 5)))
    # planted squares at each level
    for _ in range(40):
        y = rnd_L(); x = L_mul(y, y); r = sqrt_L(x)
        assert r is not None and L_mul(r, r) == x, ("L square missed", y)
        yk = rnd_K(); xk = yk * yk; rk = sqrt_K(xk)
        assert rk is not None and (rk == yk or rk == -yk), ("K square missed", yk.json())
    # squares with a zero √11-part and a zero √3-part (the b = 0 branches, both sub-cases)
    for y in (K(Fr(3, 2)), K(0, Fr(5, 7)), K(0, 0, Fr(2)), K(0, 0, 0, Fr(1, 3))):
        assert sqrt_K(y * y) is not None, ("b = 0 branch missed", y.json())
    # planted non-squares: 5·y², 2·y², 7·y², y² + 1 (generic), 3 (a square in K!), 11 (a square in K!), 33 (a square in K!)
    for _ in range(40):
        y = rnd_K()
        if y.is_zero():
            continue
        for m in (2, 5, 7, 10, 14, 35):
            assert sqrt_K((y * y).scale(m)) is None, ("a non-square accepted", m, y.json())
    assert sqrt_K(K(3)) is not None and sqrt_K(K(11)) is not None and sqrt_K(K(33)) is not None
    assert sqrt_K(K(5)) is None and sqrt_K(K(2)) is None and sqrt_K(K(-1)) is None
    print("[field self-test] tower criterion: 40 planted L-squares, 40 planted K-squares (roots verified), the b = 0 branches, "
          "240 planted non-squares refused; 3, 11, 33 squares; 2, 5, −1 not")
    # PSLQ agreement on random squares and non-squares
    import mpmath as mp
    from pool_field_census import sqrt_in_K
    mp.mp.dps = 50
    for _ in range(20):
        y = rnd_K()
        if y.is_zero():
            continue
        x = y * y
        assert (sqrt_in_K(x, 50) is not None) == (sqrt_K(x) is not None)
        x5 = x.scale(5)
        assert (sqrt_in_K(x5, 50) is not None) == (sqrt_K(x5) is not None) == False
    print("[field self-test] PSLQ agrees with the tower criterion on 20 squares and 20 five-times-squares")
    # the planted red: an out-of-field radicand forced in must be refused by the root verification
    try:
        K_of_pair(((Fr(1), Fr(0)), (Fr(0), Fr(0))))
        bad = K(5)
        r = sqrt_K(bad)
        assert r is None
        print("[field self-test] planted red: √5 offered as in-field is refused (no root exists)")
    except AssertionError:
        raise SystemExit("[field self-test] RED DID NOT FIRE")
    print("[field self-test] all green")


# ----------------------------------------------------------------------- main

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--object"); ap.add_argument("--base", default=None)
    ap.add_argument("--classify-only", action="store_true"); ap.add_argument("--dps", type=int, default=50)
    ap.add_argument("--self-test", action="store_true")
    a = ap.parse_args()
    if a.self_test:
        return self_test()
    t0 = time.time()
    obj, removed = BK.load_object(a.object); _LABEL[id(obj)] = a.object
    pts = exact_points(a.object)
    pairs = object_pairs(obj)
    print(f"[field] {a.object}: {obj.n} points ({len(pts)} exact), {len(pairs):,} live pairs at distance < 2", flush=True)
    cls, table = classify_pairs(obj, pts, pairs, dps=a.dps)
    n_in_pairs = sum(1 for c in cls.values() if c == "in")
    meta = {"radicands": len(table), "radicands_in": sum(1 for t in table.values() if t["class"] == "in"),
            "radicands_out": sum(1 for t in table.values() if t["class"] == "out"), "pairs_in": n_in_pairs,
            "pairs_out": len(pairs) - n_in_pairs, "pslq_agreement": f"{len(table)}/{len(table)}", "dps": a.dps}
    M53.mkdir(parents=True, exist_ok=True)
    (M53 / f"fieldclass-{a.object}.json").write_text(json.dumps(
        {"kind": "field-classification", "label": a.object, "fingerprint_bare": obj.fingerprint(), **meta,
         "table": list(table.values()),
         "claim_scope": "class 'in' = the radicand is a square in Q(sqrt3,sqrt11) with the root verified by squaring; "
                        "'out' = the tower criterion refuses (exact); PSLQ at dps digits agreed on every radicand"}, indent=1))
    # the census's own numbers as the control (M52: 140,195 in-field pairs of 950,371 on the it-4 object)
    cp = M52 / f"poolfield-{a.object}.json"
    if cp.exists():
        c = json.loads(cp.read_text())
        exp_in, exp_pairs = c["classes"]["1"]["pairs"], c["pairs"]
        assert len(pairs) == exp_pairs and n_in_pairs == exp_in, \
            (f"[field] REFUSED: pair counts differ from the census — pairs {len(pairs)} vs {exp_pairs}, in-field {n_in_pairs} vs {exp_in}")
        print(f"[field] control: pair counts equal the M52 census ({exp_pairs:,} pairs, {exp_in:,} in-field)", flush=True)
    if a.classify_only or not a.base:
        print(f"[field] classification written to data/m53/fieldclass-{a.object}.json [{time.time()-t0:.0f}s]")
        return
    base = Path(a.base)
    o_in = restrict(base, obj, cls, "in", meta); o_out = restrict(base, obj, cls, "out", meta)
    m_in = json.loads(Path(str(o_in) + ".json").read_text()); m_out = json.loads(Path(str(o_out) + ".json").read_text())
    total = json.loads(Path(str(base) + ".json").read_text())["pool"]["n_points"]
    assert m_in["pool"]["n_points"] + m_out["pool"]["n_points"] == total, "in + out ≠ all"
    assert m_in["pool"]["n_points"] <= 2 * n_in_pairs, "more in-field points than twice the in-field pairs"
    for name in ("depth1-infield", "depth1-outfield"):
        p = BK.load_pool(obj, name)
        assert p is not None and p.name == name, name
    print(f"[field] in + out = all ({total:,}); both exports re-load through batchkill.load_pool with their fingerprints re-derived [{time.time()-t0:.0f}s]")


if __name__ == "__main__":
    main()
