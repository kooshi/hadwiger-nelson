#!/usr/bin/env python3
"""FS111-VMW: R7 under the positive-density reading (P+): at exact points of the three arcs of D0,0, list every colour-D0 tile
meeting S(x, 1) and whether the meeting is only at a cusp (dmin = 1 exactly, attained at an arc endpoint = cusp).
A point is (P+)-free iff every colour-j tile meeting S(x,1) meets it only at cusps (density 0).
Plant: the Reuleaux side (arc of R0,0 over the same boundary) must NOT be (P+)-free (its partner is its own corner).
Usage: python3 tools/fs111_vmw_pplus.py [--out FILE]
"""
import sys
sys.path.insert(0, __file__.rsplit("/", 1)[0])
from fs111_vmw_exact import cand_point_piece, fmt, P, Q3            # noqa: E402
import fs111_vmw_tilings as TL                                       # noqa: E402
import fs111_vmw_strong as ST                                        # noqa: E402


def contacts(x, tl, colour, skip):
    res = []
    for T in tl:
        if T.colour != colour or T is skip:
            continue
        cands = [c for q in T.pieces for c in cand_point_piece(x, q)]
        lo = -1 if T.contains_closed(x) else min(c.cmp1() for c in cands)
        hi = max(c.cmp1() for c in cands)
        if lo <= 0 <= hi:
            only_cusp = (lo == 0 and hi > 0 and all(c.why.startswith("end") for c in cands if c.cmp1() == 0)
                         and any(any(e[0] == z[0] and e[1] == z[1] for z in T.zero) for q in T.pieces for e in q.ends()))
            res.append((T.name, lo, hi, only_cusp))
    return res


def main():
    out = []
    u, d = TL.r7()
    tl = list(u.values()) + list(d.values())
    D0 = d[(0, 0)]
    n, free = 0, 0
    for pc in D0.pieces:
        for x in ST.samples(pc)[1:-1]:
            n += 1
            cs = contacts(x, tl, D0.colour, D0)
            if cs and all(c[3] for c in cs):
                free += 1
            else:
                out.append(f"    NOT (P+)-free at {fmt(x)}: {cs}")
    out.append(f"[R7 (P+)] relative-interior exact points of D0,0's arcs: {n}; (P+)-free for colour D0: {free}")
    R0 = u[(0, 0)]
    nr, fr = 0, 0
    for pc in R0.pieces:
        for x in ST.samples(pc)[1:-1]:
            nr += 1
            cs = contacts(x, tl, R0.colour, None)
            if cs and all(c[3] for c in cs):
                fr += 1
    out.append(f"[R7 (P+) control] Reuleaux R0,0 arc points: {nr}; (P+)-free for its colour: {fr} (must be 0)")
    assert free == n and fr == 0
    x = P(1, Q3(-1, 1))
    out.append(f"[R7 (P+)] named point (1, sqrt3 - 1): contacts {contacts(x, tl, D0.colour, D0)}")
    text = "\n".join(out)
    if "--out" in sys.argv:
        open(sys.argv[sys.argv.index("--out") + 1], "w").write(text + "\n")
    print(text)


if __name__ == "__main__":
    main()
