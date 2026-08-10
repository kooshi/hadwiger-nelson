#!/usr/bin/env python3
"""Export a finite hexagram chunk (M26's certified object, truncated at seam height B) for the
rigidity instrument — vertices, unit edges, and the rot6 symmetry as vertex permutations.

UNTRUSTED, like everything in `tools/`. The chunk is the E4 calibration target of M30: the
rigidity instrument is validated on ground the kernel already certified (χ(hexagram) = 4,
`Hexagram.lean`), before being pointed at the new field.

The point model is `couple.py`'s `--hexagram-census` sweep, reused rather than re-typed: seven
⟨ζ₆,σ⟩-ladders — six pivots hexPivot a = m·(1+ζ₆^a) with outer (radius 1) and inner (radius 1/√3)
circles, plus the metapivot's own pair anchored along ζ₁₂ — at addresses (x ∈ ℤ/6, |b| ≤ B).
Fusions (the six pivots ARE the meta-inner hex layer at height 0, and M23's glue points) collapse
under exact dedup. The rot6 permutation is computed geometrically (rotate, look up) and asserted
to be an automorphism of the edge set — the M26 lesson that the automorphism control catches real
instrument bugs.

    python3 tools/hexchunk.py --B 0        # → build/m30-hexchunk-B0.json (+ -sym)
"""

from __future__ import annotations

import argparse
import json
import sys
from fractions import Fraction as F
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import couple as C  # noqa: E402  (the one copy of the seam-field exact arithmetic)

DIM = C.DIM
B1, B3, B33 = C.B1, C.B3, C.B33

Z6 = C.frac_c({B1: F(1, 2)}, {B3: F(1, 2)})
Z12 = C.frac_c({B3: F(1, 2)}, {B1: F(1, 2)})
SEAM = C.frac_c({B3: F(1, 6)}, {B33: F(1, 6)})
SEAMI = C.frac_c({B3: F(1, 6)}, {B33: F(-1, 6)})
MPIV = C.frac_c({B1: F(1, 2)}, {B3: F(1, 6)})
ONE = C.frac_c({B1: F(1)})
INNER_R = [F(0)] * DIM
INNER_R[B3] = F(1, 3)          # 1/√3 = √3/3


def cadd2(a, b):
    return (C.add(a[0], b[0]), C.add(a[1], b[1]))


def csub2(a, b):
    return (C.sub(a[0], b[0]), C.sub(a[1], b[1]))


def word(x: int, b: int):
    w = C.cpow(Z6, x % 6)
    s = SEAM if b >= 0 else SEAMI
    for _ in range(abs(b)):
        w = C.cmul(w, s)
    return w


HEXPIV = [C.cmul(MPIV, cadd2(ONE, C.cpow(Z6, a))) for a in range(6)]


def gen_points(B: int):
    """(points, labels): every circle point of the chunk, deduped, with all its addresses."""
    table: dict[tuple, int] = {}
    pts, labels = [], []

    def put(p, label):
        k = (tuple(p[0]), tuple(p[1]))
        if k not in table:
            table[k] = len(pts)
            pts.append(p)
            labels.append([])
        labels[table[k]].append(label)

    for a in range(6):
        for x in range(6):
            for b in range(-B, B + 1):
                w = word(x, b)
                put(cadd2(HEXPIV[a], w), ["outer", a, x, b])
                put(cadd2(HEXPIV[a], C.cscale(INNER_R, w)), ["inner", a, x, b])
    for y in range(6):
        for d in range(-B, B + 1):
            w = C.cmul(word(y, d), Z12)
            put(cadd2(MPIV, w), ["meta-outer", y, d])
            put(cadd2(MPIV, C.cscale(INNER_R, w)), ["meta-inner", y, d])
    return pts, table, labels


def is_one(v):
    re, im = v
    return all(c == 0 for c in im) and re[B1] == 1 and \
        all(c == 0 for i, c in enumerate(re) if i != B1)


def unit_edges(pts):
    out = []
    for i in range(len(pts)):
        for j in range(i + 1, len(pts)):
            d = csub2(pts[i], pts[j])
            if is_one(C.cmul(d, C.cconj(d))):
                out.append((i, j))
    return out


def rot6_perm(pts, table):
    """The 60° rotation about the metapivot as a vertex permutation — geometric, then verified."""
    perm = []
    for p in pts:
        q = cadd2(MPIV, C.cmul(Z6, csub2(p, MPIV)))
        k = (tuple(q[0]), tuple(q[1]))
        if k not in table:
            raise SystemExit("rot6 leaves the chunk: the truncation is not rot6-closed — "
                             "the address model is wrong (it should shift x by +1 only)")
        perm.append(table[k])
    return perm


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--B", type=int, default=0, help="seam-height bound |b| ≤ B")
    args = ap.parse_args()

    pts, table, labels = gen_points(args.B)
    edges = unit_edges(pts)
    perm = rot6_perm(pts, table)
    # the automorphism control: rot6 must map the edge set to itself, exactly
    eset = {tuple(sorted(e)) for e in edges}
    for (i, j) in edges:
        if tuple(sorted((perm[i], perm[j]))) not in eset:
            raise SystemExit(f"rot6 is not an automorphism of the computed edge set at edge "
                             f"({i},{j}) — the unit-chord sweep and the symmetry disagree")
    syms = []
    p = list(range(len(pts)))
    for _ in range(5):
        p = [perm[v] for v in p]
        syms.append(list(p))

    fus = sum(1 for l in labels if len(l) > 1)
    print(f"hexagram chunk B={args.B}: {len(pts)} vertices ({fus} fused), {len(edges)} unit edges; "
          f"rot6 verified as an automorphism")
    out = Path(f"build/m30-hexchunk-B{args.B}.json")
    out.parent.mkdir(exist_ok=True)
    json.dump({"n": len(pts), "edges": edges, "labels": labels,
               "note": f"hexagram truncated at |b| <= {args.B}; kernel fact: the full object "
                       f"has chi = 4 (Hexagram.lean)"}, open(out, "w"))
    json.dump(syms, open(f"build/m30-hexsym-B{args.B}.json", "w"))
    print(f"wrote {out} and build/m30-hexsym-B{args.B}.json")


if __name__ == "__main__":
    main()
