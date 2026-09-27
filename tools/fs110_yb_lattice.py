#!/usr/bin/env python3
"""FS110-YB: one formula-given candidate for Y2-LAT, checked exactly: BB's local tiles repeated translation-invariantly over the three cosets of
the index-3 sublattice of the unit triangular lattice (class (m + 2n) mod 3 at m e0 + n e60: class 0 gets u's tiles, 1 gets v's, 2 gets w's
quadrant squares). This is MY reading of "the translation-invariant triangular-lattice extension of BB"; the side's own formula is not in my
instance block."""
import fs110_yb_check as K, fs110_yb_fragments as F
from fs110_yb_check import add, mul, e, Fr
base = F.frag_BB()
U = [t for t in base if t.name.startswith("u_")]; V = [t for t in base if t.name.startswith("v_")]
Wt = [t for t in base if t.name.startswith("wQ")]
def at(tiles, shift, origin, tag):
    return [t.mapped(lambda z: add(sub_(z, origin), shift), f"{tag}{t.name}", t.colour) for t in tiles]
def sub_(p, q): return (p[0] - q[0], p[1] - q[1])
tiles = []
for m in range(-3, 4):
    for n in range(-3, 4):
        p = add(mul(m, e(0)), mul(n, e(60)))
        if float(p[0])**2 + float(p[1])**2 > 2.3**2: continue
        cls = (m + 2 * n) % 3
        src, org = [(U, (K.Q3(0), K.Q3(0))), (V, (K.Q3(1), K.Q3(0))), (Wt, F.W)][cls]
        tiles += at(src, p, org, f"[{m},{n}]")
r = K.check(tiles, "Y2-LAT candidate: BB translated over the index-3 sublattice", verbose=False)
rej = [x for x in r["res"] if x["verdict"] == "REJECT"]
print(f"tiles={len(tiles)} pairs={r['pairs']} expected={r['expect']} verdict={r['verdict']} rejecting pairs={len(rej)}")
for x in rej[:12]: print("  ", x["A"], x["B"], "colour", x["colour"], f"[{x['lo']:.4f}, {x['hi']:.4f}]")
