#!/usr/bin/env python3
"""residue_colouring — the explicit 4-colouring of any K-point unit-distance graph, K = ℚ(√3, √11)
(Theorem B of `~/field-wall-conjecture.md`, 2026-09-05: colour a point by its residue modulo a
conjugation-fixed prime 𝔭 of K(i) above 2, whose residue field is 𝔽₄).

    python3 tools/residue_colouring.py --seed                 # the note's §9.4 test on the Exoo–Ismailescu seed
    python3 tools/residue_colouring.py --object <label>       # a committed K-point object (exact coords in data/m52/exact-<label>.json)

The 2-adic model: K(i) ↪ ℚ₂(ζ₁₂) = ℚ₂(ζ₃)(i) with √33 ↦ S (S ∈ ℤ₂, S² = 33, S ≡ 17 or −17 mod 256 —
the two primes above 2), √3 ↦ −i(2ζ₃ + 1), √11 ↦ −(S/3)·i·(2ζ₃ + 1). A point z = x + iy with
x = x₀ + x₁√3 + x₂√11 + x₃√33, y likewise, has image A + B·i with A, B ∈ ℚ₂(ζ₃) = {p + qζ₃}, and its
residue is (A + B) mod 2 ∈ 𝔽₄ = {p + qω}, read as the pair (p mod 2, q mod 2). Every unit vector is a
𝔭-adic unit (Theorem A), so a unit step always changes the residue; every distance of positive
𝔭-adic valuation (2, 4, 2√3, 8/3, 8/√3, …) never does. Points are coloured per unit-connected component
by r(z − z₀) for a base z₀ of the component (the colouring lives on cosets of the local ring). The
tool VALIDATES: proper on every unit edge; on the seed, monochromatic on every distance-2 edge; and
reports the forced pair's colours (Theorem 7.1: different). UNTRUSTED like all of tools/; the
theorem's kernel formalization is the next milestone's."""
from __future__ import annotations
import argparse, json, sys, time
from collections import Counter
from fractions import Fraction as Fr
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))

N_BITS = 200
MOD = 1 << N_BITS


def sqrt33_2adic(start: int) -> int:
    S = start % 256
    for k in range(8, N_BITS):
        if (S * S - 33) % (1 << (k + 1)):
            S += 1 << (k - 1)
    assert (S * S - 33) % MOD == 0
    return S


def v2(n: int) -> int:
    n = abs(n); c = 0
    while n and n % 2 == 0:
        n //= 2; c += 1
    return c


def mod2(q: Fr):
    """The residue mod 2 of a 2-adic number given as a rational (with S substituted), or None if not 2-integral."""
    num, den = q.numerator, q.denominator
    if num == 0:
        return 0
    e = v2(den)
    if v2(num) < e:
        return None
    return ((num >> e) if e else num) % 2


def residue_of_coords(x, y, S: int):
    """x, y: 4-tuples of Fractions (coefficients of 1, √3, √11, √33). Returns (p, q) ∈ 𝔽₄ or None."""
    x0, x1, x2, x3 = x; y0, y1, y2, y3 = y
    tx = x1 + x2 * Fr(S, 3); ty = y1 + y2 * Fr(S, 3)
    A0 = x0 + x3 * S + ty; A1 = 2 * ty
    B0 = y0 + y3 * S - tx; B1 = -2 * tx
    p, q = mod2(A0 + B0), mod2(A1 + B1)
    return None if p is None or q is None else (p, q)


def colour(points: dict, unit_edges, S: int):
    """points: {i: (x4, y4)} exact coords; returns {i: colour} coloured per unit-connected component."""
    adj = {i: [] for i in points}
    for u, v in unit_edges:
        if u in adj and v in adj:
            adj[u].append(v); adj[v].append(u)
    comp = {}; bases = {}
    for s0 in points:
        if s0 in comp:
            continue
        bases[s0] = s0; stack = [s0]; comp[s0] = s0
        while stack:
            u = stack.pop()
            for w in adj[u]:
                if w not in comp:
                    comp[w] = s0; stack.append(w)
    col = {}
    for i, (x, y) in points.items():
        bx, by = points[comp[i]]
        dx = tuple(x[k] - bx[k] for k in range(4)); dy = tuple(y[k] - by[k] for k in range(4))
        col[i] = residue_of_coords(dx, dy, S)
    return col, len(bases)


def report(name, col, unit_edges, two_edges, pair=None):
    nonint = sum(1 for c in col.values() if c is None)
    bad_unit = [(u, v) for u, v in unit_edges if col.get(u) is None or col.get(v) is None or col[u] == col[v]]
    bad_two = [(u, v) for u, v in two_edges if col.get(u) is None or col.get(v) is None or col[u] != col[v]]
    line = (f"[residue] {name}: {len(col)} points; non-integral residues {nonint}; unit edges monochromatic "
            f"{len(bad_unit)} of {len(unit_edges)} (must be 0); distance-2 pairs not monochromatic {len(bad_two)} of {len(two_edges)} (must be 0); "
            f"colour classes {sorted(Counter(col.values()).values(), reverse=True)}")
    if pair:
        a, b = pair
        line += f"; forced pair {a},{b}: {col[a]} vs {col[b]} — {'different' if col[a] != col[b] else 'EQUAL (would contradict Theorem 7.1)'}"
    print(line, flush=True)
    return {"points": len(col), "non_integral": nonint, "unit_mono": len(bad_unit), "unit_edges": len(unit_edges),
            "two_not_mono": len(bad_two), "two_edges": len(two_edges), "classes": sorted(Counter(col.values()).values(), reverse=True),
            "pair": [list(col[pair[0]]), list(col[pair[1]])] if pair else None, "ok": nonint == 0 and not bad_unit and not bad_two}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--seed", action="store_true"); ap.add_argument("--object", default=None)
    ap.add_argument("--result", default=None)
    a = ap.parse_args()
    t0 = time.time(); out = {"kind": "residue-colouring", "branches": {}}
    if a.seed:
        import twodist as T
        H = T.ei_H(); cls = T.classify(H, radii=(1, 4))
        # seed coords ((a√3 + b√11)/12, (c + d√33)/12) → x = (0, a/12, b/12, 0), y = (c/12, 0, 0, d/12)
        pts = {i: ((Fr(0), Fr(p[0], 12), Fr(p[1], 12), Fr(0)), (Fr(p[2], 12), Fr(0), Fr(0), Fr(p[3], 12))) for i, p in enumerate(H)}
        pair = (H.index(T.EI_A), H.index(T.EI_B)); out["object"] = "Exoo–Ismailescu H (214 points)"
        for start in (17, 256 - 17):
            col, ncomp = colour(pts, cls[1], sqrt33_2adic(start))
            out["branches"][f"sqrt33≡{start} mod 256"] = {**report(f"seed H, √33 ≡ {start} (mod 256), {ncomp} component(s)", col, cls[1], cls[4], pair), "components": ncomp}
    if a.object:
        import batchkill as BK
        obj, removed = BK.load_object(a.object)
        ex = json.loads((Path(__file__).resolve().parent.parent / "data" / "m52" / f"exact-{a.object}.json").read_text())["points"]
        def four(v):
            A_, B_ = v; assert all(nn == 0 for nn, dd in B_), "a K(√5) point — this colouring is for K-point objects only"
            return tuple(Fr(nn, dd) for nn, dd in A_)
        pts = {int(i): (four(ex[i]["x"]), four(ex[i]["y"])) for i in ex if int(i) not in obj.deleted}
        ue = [tuple(e) for e in obj.unit_edges()]
        two = [tuple(e) for e in obj.cheats if e[0] in pts and e[1] in pts]      # every seed distance-2 pair, standing or not
        out["object"] = a.object
        for start in (17, 256 - 17):
            col, ncomp = colour(pts, ue, sqrt33_2adic(start))
            out["branches"][f"sqrt33≡{start} mod 256"] = {**report(f"{a.object}, √33 ≡ {start} (mod 256), {ncomp} component(s)", col, ue, two, (obj.A, obj.B)), "components": ncomp}
    out["seconds"] = round(time.time() - t0, 1)
    out["claim_scope"] = ("the residue 4-colouring of Theorem B (~/field-wall-conjecture.md), computed at 200 2-adic bits on both primes above 2, "
                          "validated proper on every unit edge and monochromatic on every seed distance-2 pair; the forced pair separated")
    if a.result:
        Path(a.result).write_text(json.dumps(out, indent=1)); print(f"[residue] wrote {a.result}")


if __name__ == "__main__":
    main()
