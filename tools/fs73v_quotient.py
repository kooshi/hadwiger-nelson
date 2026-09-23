#!/usr/bin/env python3
"""FS-73 independent verifier: the upper half of the sandwich at K, checked through the quotient Lambda/8Lambda.

Given F >= 8Lambda (the refusals), F/8Lambda is a subgroup of Lambda/8Lambda = (Z/8)^4 stable under the point group G (order 24),
and it is trivial iff it holds no element of order 2, i.e. no 4*lambda with lambda not in 2Lambda. G has three orbits on those 15
classes, so F = 8Lambda iff three vectors 4*lambda are each separated by SOME 4-colouring of Cay(Lambda, U). An 8Lambda-periodic
colouring is a colouring of the finite Cayley graph Cay(Lambda/8Lambda, U mod 8Lambda); this file asks for one with
c(0) != c(4*lambda), and verifies any colouring found by pulling it back to the radius-3/2 ball and checking every edge.
"""
from __future__ import annotations

import itertools
import json
import os
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs73v_lattice as L  # noqa: E402
import fs73v_sat as S  # noqa: E402

N = 8


def main():
    B = L.build(verbose=False)
    H = B["H"]
    coef = lambda v: tuple(t % N for t in L.member(H, v))  # class of v in Lambda/N Lambda (HNF coefficients mod N)
    Ucls = sorted({coef(u) for u in B["U"]})
    assert (0, 0, 0, 0) not in Ucls, "a unit vector lies in N Lambda: the quotient has loops"
    verts = list(itertools.product(range(N), repeat=4))
    vid = {v: i for i, v in enumerate(verts)}
    add = lambda a, b: tuple((x + y) % N for x, y in zip(a, b))
    edges = set()
    for v in verts:
        for u in Ucls:
            w = add(v, u)
            edges.add((min(vid[v], vid[w]), max(vid[v], vid[w])))
    out = {"N": N, "quotient_vertices": len(verts), "U_mod_N": len(Ucls), "quotient_edges": len(edges)}
    reps = {"sqrt33*4/9": (0, 0, 0, 16), "(2/9)(sqrt-3+sqrt33)": (0, 8, 0, 8), "(2/9)(sqrt-3+sqrt-11)+(4/9)sqrt33": (0, 8, 8, 16)}
    from pysat.solvers import Solver
    res = {}
    for name, t in reps.items():
        tc = coef(t)
        assert all(c % 4 == 0 for c in tc) and any(tc), (name, tc)  # 4*lambda with lambda not in 2 Lambda
        n = len(verts)
        x = lambda v, c: 4 * v + c + 1
        cls = []
        for v in range(n):
            cls.append([x(v, c) for c in range(4)])
            for c1 in range(4):
                for c2 in range(c1 + 1, 4):
                    cls.append([-x(v, c1), -x(v, c2)])
        for (a, b) in edges:
            for c in range(4):
                cls.append([-x(a, c), -x(b, c)])
        o, d = vid[(0, 0, 0, 0)], vid[tc]
        cls += [[x(o, 0)], [x(d, 1)]]
        t0 = time.process_time()
        s = Solver(name="glucose4", bootstrap_with=cls)
        ok = s.solve()
        r = {"target_class": tc, "adjacent_to_0": tc in Ucls, "verdict": "SAT" if ok else "UNSAT",
             "cpu_s": round(time.process_time() - t0, 2)}
        if ok:
            m = set(l for l in s.get_model() if l > 0)
            col = [next(c for c in range(4) if x(v, c) in m) for v in range(n)]
            qbad = sum(1 for (a, b) in edges if col[a] == col[b])
            # pull back to the ball and check every directed edge there, independently of the quotient's edge list
            ball_col = [col[vid[coef(tuple(int(t) for t in p))]] for p in B["pts"]]
            chk = S.verify_colouring(B, ball_col)
            r["quotient_monochromatic_edges"] = qbad
            r["pullback_ball_check"] = chk
            r["c0_c_target"] = (col[o], col[d])
            assert qbad == 0 and chk["monochromatic"] == 0 and col[o] != col[d]
        s.delete()
        res[name] = r
    out["asks"] = res
    return out


if __name__ == "__main__":
    print(json.dumps(main(), indent=1, default=str))
