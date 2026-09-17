#!/usr/bin/env python3
"""fs58_recheck_witness -- a decorrelated second opinion on a FS-58 witness file, sharing no code with the generator
(tools/fs58_search.py, tools/fs58_witness.py) or the checker (tools/fs58_check_witness.py).

Usage: fs58_recheck_witness.py D WITNESS.json
  1. every pair of points tested in fractions.Fraction arithmetic over Q(sqrt D) (distance^2 = rational part + sqrt D part; unit iff
     rational part 1 and sqrt D part 0): the set of unit pairs must equal the file's edge list;
  2. three SAT solvers outside the generator's set (Lingeling, CaDiCaL 1.5.3, MapleChrono) must refuse a proper 3-colouring of that
     edge set (no pin);
  3. deleting vertex 1 of the pinned edge must leave a 3-colourable graph (a model, verified) -- the refusal needs that vertex.
Prints RECHECK PASS or RECHECK FAIL: <reason>."""
import sys, json
from fractions import Fraction as F
from pysat.solvers import Lingeling, Cadical153, MapleChrono


def main():
    D, path = int(sys.argv[1]), sys.argv[2]
    W = json.load(open(path))
    P = [(F(a, m), F(b, m), F(c, m), F(e, m)) for a, b, c, e, m in W['points']]
    E = set()
    for i in range(len(P)):
        for j in range(i + 1, len(P)):
            d = [P[i][k] - P[j][k] for k in range(4)]
            if d[0] ** 2 + D * d[1] ** 2 + d[2] ** 2 + D * d[3] ** 2 == 1 and d[0] * d[1] + d[2] * d[3] == 0:
                E.add((i, j))
    fileE = set(tuple(e) for e in W['edges'])
    if E != fileE:
        print(f'RECHECK FAIL: {len(E)} unit pairs by Fraction arithmetic against {len(fileE)} in the file')
        return 1
    n = len(P)
    cl = [[3 * v + 1, 3 * v + 2, 3 * v + 3] for v in range(n)] + [[-(3 * i + c + 1), -(3 * j + c + 1)] for i, j in sorted(E) for c in range(3)]
    verdicts = []
    for S in (Lingeling, Cadical153, MapleChrono):
        s = S(bootstrap_with=cl)
        r = s.solve()
        s.delete()
        verdicts.append(f'{S.__name__} {"SAT" if r else "UNSAT"}')
        if r:
            print(f'RECHECK FAIL: {S.__name__} finds a 3-colouring')
            return 1
    q = W['pinned_edge'][1]
    keep = [c for c in cl if all((abs(l) - 1) // 3 != q for l in c)]
    s = Cadical153(bootstrap_with=keep)
    if not s.solve():
        print(f'RECHECK FAIL: deleting vertex {q} leaves a graph that still refuses (control expected a colouring)')
        return 1
    m = set(x for x in s.get_model() if x > 0)
    col = {v: next(c for c in range(3) if 3 * v + c + 1 in m) for v in range(n) if v != q}
    if any(col[i] == col[j] for i, j in E if q not in (i, j)):
        print('RECHECK FAIL: the control model is not proper')
        return 1
    print(f'RECHECK PASS: {n} points; {len(E)} unit pairs by Fraction arithmetic over all {n * (n - 1) // 2} pairs = the file; '
          f'{", ".join(verdicts)}; deleting vertex {q} leaves a 3-colourable graph (model verified)')
    return 0


if __name__ == '__main__':
    sys.exit(main())
