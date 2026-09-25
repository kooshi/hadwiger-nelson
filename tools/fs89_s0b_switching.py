#!/usr/bin/env python3
"""FS-89 Stage 0B: exact finite prefixes of the switching family (the perfect tree of S0B-T5), band [1/4, 3/4].

Orbit model (tools/fs89_s0b_orbits.py): e_m in Q = [1/4,3/4]^2, e_{m+1} - wbar e_m in pi^{-1} Z[i].  Two leaves:
  parity:  e_{m+1} = P + wbar (e_m - P),                 P = (1+i)/2, admissible while |e - P| <= 1/4;
  order 3: e_{m+1} = C' + wbar (e_m - C),  C' = lift(iC),  C in {(a+bi)/3}, admissible while |e - C| <= 1/12.
A switch at time m moves to the other leaf when e_m lies strictly inside the other leaf's disc.  Policy j: switch at the
j-th admissible time after the previous switch.  Every step is checked exactly (Q membership, digit lattice), and the
orbits of different policies are compared.  Starts at e_0 = C_0 = (1+i)/3 on the order-3 leaf.
"""
from __future__ import annotations

import sys
from fractions import Fraction as Fr

WB = (Fr(3, 5), Fr(-4, 5))
P = (Fr(1, 2), Fr(1, 2))
X3 = [(Fr(a, 3), Fr(b, 3)) for a in (1, 2) for b in (1, 2)]


def cmul(p, q):
    return (p[0] * q[0] - p[1] * q[1], p[0] * q[1] + p[1] * q[0])


def sub(p, q):
    return (p[0] - q[0], p[1] - q[1])


def add(p, q):
    return (p[0] + q[0], p[1] + q[1])


def n2(p):
    return p[0] ** 2 + p[1] ** 2


def lift(z):
    return (z[0] - (z[0].numerator // z[0].denominator), z[1] - (z[1].numerator // z[1].denominator))


def step_leaf(e, leaf):
    if leaf == "P":
        return add(P, cmul(WB, sub(e, P)))
    C = leaf
    Cn = lift(cmul((Fr(0), Fr(1)), C))
    return add(Cn, cmul(WB, sub(e, C))), Cn


def run(policy_j: int, steps: int):
    e, leaf = X3[0], X3[0]         # on the order-3 leaf at its centre
    orbit, switches, seen = [e], [], 0
    for m in range(steps):
        # switching opportunity at time m?
        if leaf == "P":
            near = [C for C in X3 if n2(sub(e, C)) < Fr(1, 144)]
            can = bool(near)
        else:
            can = n2(sub(e, P)) < Fr(1, 16)
        if can:
            seen += 1
            if seen == policy_j:
                leaf = near[0] if leaf == "P" else "P"
                switches.append(m)
                seen = 0
        if leaf == "P":
            e2 = step_leaf(e, "P")
        else:
            e2, leaf = step_leaf(e, leaf)
        # exact checks
        assert Fr(1, 4) <= e2[0] <= Fr(3, 4) and Fr(1, 4) <= e2[1] <= Fr(3, 4), (m, e2)
        d = sub(e2, cmul(WB, e))
        pd = cmul((Fr(2), Fr(1)), d)                 # pi * d must be a Gaussian integer
        assert pd[0].denominator == 1 and pd[1].denominator == 1, (m, d)
        e = e2
        orbit.append(e)
    return orbit, switches


def main() -> int:
    steps = int(sys.argv[1]) if len(sys.argv) > 1 else 80
    orbits = {}
    for j in (1, 2, 3):
        o, sw = run(j, steps)
        orbits[j] = o
        print(f"policy j={j}: {len(sw)} switches in {steps} steps at times {sw[:12]}{' ...' if len(sw) > 12 else ''}; "
              f"every step exact-checked (in Q, digit in pi^-1 Z[i])")
    for a, b in ((1, 2), (1, 3), (2, 3)):
        first = next((m for m in range(steps + 1) if orbits[a][m] != orbits[b][m]), None)
        print(f"orbits j={a} and j={b} first differ at time {first}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
