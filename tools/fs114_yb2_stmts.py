#!/usr/bin/env python3
"""FS114-YB2 stage 1c: exact checks at named points on my bowtie for the instance's statements (derivations in the record).
  tactic : each tactic tile and its inner tile lie in opposite closed half-planes of a line through q_i, the tactic tile meeting it at q_i only.
  rstop  : the free colours at named points r + (1/100) u around r = (sqrt3, 0) (u rational unit vectors) -- none free in the cone (-60, 60).
  ring   : the straddlers, colour by colour, at points of the unit circle about q1 just above r and just outside it.
Run: python3 tools/fs114_yb2_stmts.py tactic|rstop|ring"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb2_exact as X   # noqa: E402
import fs114_yb2_run as R     # noqa: E402

n, s3, P, add, sub, smul, dot = R.n, R.s3, R.P, X.add, X.sub, X.smul, X.dot


def side_signs(ps, q, nv):
    """signs of <x - q, nv> at every candidate extreme of the tile (vertices; arc points in directions +-nv), with the vertex q flagged."""
    out = []
    for pc in ps:
        for v in pc.ends():
            out.append((dot(sub(v, q), nv).sign(), X.same(v, q)))
        if pc.kind == "A":
            k = dot(sub(pc.C, q), nv)
            for sg in (1, -1):
                if pc.has_km(smul(sg, nv), smul(0, nv), n(0), strict=True):
                    out.append((X.sgn_km(k, pc.rho * sg, dot(nv, nv)), False))
    return out


def tactic():
    b = R.Bowtie()
    t = b.tiles()
    ok = True
    cases = [("T1", "t1", b.q1, (n(1), n(1))), ("T1_y", "t1", b.q2, (n(1), n(-1))), ("T1_x", "t3", b.qC, (n(-1), n(1))),
             ("T1_xy", "t3", b.qD, (n(-1), n(-1)))]
    for tac, inner, q, nv in cases:
        a = side_signs(t[tac][1], q, nv)
        c = side_signs(t[inner][1], q, nv)
        good = all(s > 0 or (s == 0 and atq) for s, atq in a) and all(s <= 0 for s, _ in c)
        ok &= good
        print(f"  {tac} vs {inner} at {X.fp(q)}: tactic tile signs {sorted(set(s for s, _ in a))} (zero only at q: "
              f"{all(atq for s, atq in a if s == 0)}); inner tile signs {sorted(set(s for s, _ in c))}: {'meets at q alone' if good else 'FAIL'}")
    print("TACTIC", "OK" if ok else "FAIL")


UNITS = [(Fr(1), Fr(0)), (Fr(4, 5), Fr(3, 5)), (Fr(4, 5), Fr(-3, 5)), (Fr(3, 5), Fr(4, 5)), (Fr(3, 5), Fr(-4, 5)), (Fr(0), Fr(1)),
         (Fr(-3, 5), Fr(4, 5)), (Fr(-1), Fr(0)), (Fr(-3, 5), Fr(-4, 5)), (Fr(0), Fr(-1))]


def rstop():
    b = R.Bowtie()
    t = b.tiles()
    r = (s3, n(0))
    import math
    for u in UNITS:
        z = add(r, (n(u[0] / 100), n(u[1] / 100)))
        fr, st = X.free(z, t, [1, 2, 3, 4, 5, 6])
        ang = math.degrees(math.atan2(float(u[1]), float(u[0])))
        print(f"  r + (1/100)({u[0]}, {u[1]}) [{ang:7.2f} deg]: free {fr}; straddled by " +
              "; ".join(f"{c}:{','.join(v)}" for c, v in sorted(st.items())))


def ring():
    b = R.Bowtie()
    t = b.tiles()
    e330 = (s3 / 2, n(Fr(-1, 2)))
    rot = lambda v, c, s: (v[0] * c - v[1] * s, v[0] * s + v[1] * c)
    for (c, s_), lab in [((Fr(399, 401), Fr(40, 401)), "5.71"), ((Fr(9999, 10001), Fr(200, 10001)), "1.15")]:
        w = rot(e330, n(c), n(s_))
        for rad, tag in [(Fr(1), "on the ring"), (Fr(1) + Fr(1, 10 ** 6), "1e-6 outside")]:
            z = add(b.q1, smul(n(rad), w))
            fr, st = X.free(z, t, [1, 2, 3, 4, 5, 6])
            print(f"  q1 + {tag} e(330 + {lab} deg): free {fr}; straddled by " + "; ".join(f"{k}:{','.join(v)}" for k, v in sorted(st.items())))


if __name__ == "__main__":
    {"tactic": tactic, "rstop": rstop, "ring": ring}[sys.argv[1]]()
