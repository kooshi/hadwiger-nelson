#!/usr/bin/env python3
"""FS129-MA1: the Falconer-fan kill of FS129-OA1-FALC-11, at the residue plane at 19.

A Falconer fan at k colours (FS129-OA1-FALC-RED, plans/FS129-OA1-audit.md section 2.3) is a finite unit-distance graph H with an apex a
and a tip t, t not adjacent to a, such that every proper k-colouring of H - a in which N(a) avoids two colours {c1, c2} gives t one of
c1, c2.  Row 66's repaint, transported along the residue map rho : H -> Gamma_q (q = 3 mod 4), kills it at t when some proper
5-colouring C of Gamma_q has a gap gamma at rho(a) and either C(rho t) is not in {C(rho a), gamma}, or rho(t) has a gap outside
{C(rho a), gamma} (repaint t alone).

This script evaluates a FIXED finite set of colourings: the orbit of one held kernel table under Gamma_q's point group (2(q+1)
elements: multiplication by a norm-one element of F_{q^2} = F_q(i), with or without conjugation) and its q^2 translations.  It
searches for nothing.  It prints the residue differences w = rho(t) - rho(a) at which no colouring of that orbit kills the fan.

Tables (both in the kernel):
  q = 19: Proofs/HadwigerNelson/Instances/FanGap19.lean `finitePlane19QuotColouring` = circ19Table(y - x),
          circ19Table from Instances/LocalGlobal19.lean.
  q = 11: the two tables of tools/fs129_oa1_falconer_fan.py (re-run here as a control of this code path).

Usage:  python3 tools/fs129_ma1_falcfan.py 19            -> the orbit report at 19; exit 0
        python3 tools/fs129_ma1_falcfan.py 11            -> the same code on 11's tables (expect W = [(0, 0)], as FS129-OA1-FALC-11-W)
        python3 tools/fs129_ma1_falcfan.py 19 --fault-table   (one entry of circ19Table changed: must refuse, exit 2)
        python3 tools/fs129_ma1_falcfan.py 19 --fault-gap     (any absent-from-the-vertex colour counted as a gap: W changes)
"""
import sys

ARGS = [a for a in sys.argv[1:] if not a.startswith("--")]
Q = int(ARGS[0]) if ARGS else 19
FAULT_TABLE = "--fault-table" in sys.argv
FAULT_GAP = "--fault-gap" in sys.argv

if Q == 19:
    CIRC19 = [0, 4, 3, 2, 4, 3, 2, 1, 0, 4, 3, 0, 4, 3, 2, 1, 0, 2, 1]
    if FAULT_TABLE:
        CIRC19 = CIRC19[:]
        CIRC19[5] = CIRC19[4]        # planted: one entry changed
    TABLES = [[[CIRC19[(y - x) % Q] for y in range(Q)] for x in range(Q)]]
    NAMES = ["finitePlane19QuotColouring"]
elif Q == 11:
    T1 = [[0,1,4,0,2,0,1,4,0,3,2],[2,4,1,3,0,1,4,1,3,0,1],[4,3,2,0,1,4,3,4,0,3,0],
          [3,0,1,2,4,1,4,0,2,1,4],[2,3,2,1,3,4,0,3,0,4,3],[1,0,1,4,2,1,2,4,1,3,0],
          [2,1,4,3,0,2,4,3,4,0,3],[1,4,2,1,2,4,1,4,0,2,0],[4,0,3,2,1,3,4,3,2,1,3],
          [3,2,0,1,2,4,0,2,0,2,4],[2,0,2,4,1,3,2,1,3,4,0]]
    T2 = [[0,2,0,1,4,3,0,3,1,4,3],[3,0,1,2,3,4,3,0,2,1,2],[0,4,3,0,2,0,4,3,1,2,1],
          [1,2,4,3,0,1,3,4,3,0,2],[2,1,3,0,3,0,1,2,0,4,1],[3,2,4,3,4,3,2,0,1,3,4],
          [4,0,1,2,1,4,0,1,2,1,2],[3,4,3,1,2,0,3,4,1,2,4],[4,1,4,2,1,2,1,3,2,0,1],
          [1,2,3,4,0,1,2,4,3,4,0],[2,1,2,0,3,2,1,2,4,3,1]]
    if FAULT_TABLE:
        T1 = [row[:] for row in T1]
        T1[0][1] = T1[0][0]
    TABLES = [T1, T2]
    NAMES = ["finitePlane11Table", "finitePlane11DoubleGapTable"]
else:
    print("only q = 11 or 19 have held tables")
    sys.exit(1)

UNITS = [(a, b) for a in range(Q) for b in range(Q) if (a * a + b * b) % Q == 1]
assert len(UNITS) == Q + 1, UNITS
PTS = [(x, y) for x in range(Q) for y in range(Q)]


def add(u, v):
    return ((u[0] + v[0]) % Q, (u[1] + v[1]) % Q)


def nbrs(v):
    return [add(v, e) for e in UNITS]


def proper(T):
    return all(T[v[0]][v[1]] != T[w[0]][w[1]] for v in PTS for w in nbrs(v))


for name, T in zip(NAMES, TABLES):
    if not proper(T):
        print(f"REFUSED: {name} is not a proper colouring of Gamma_{Q}")
        sys.exit(2)


def rot(e, v, conj):
    x, y = v
    if conj:
        y = (-y) % Q
    a, b = e
    return ((a * x - b * y) % Q, (a * y + b * x) % Q)


GROUP = [(e, c) for e in UNITS for c in (False, True)]
assert len(GROUP) == 2 * (Q + 1)


def gaps(T, s):
    shown = {T[s[0]][s[1]]} | {T[w[0]][w[1]] for w in nbrs(s)}
    if FAULT_GAP:
        shown = {T[s[0]][s[1]]}
    return [g for g in range(5) if g not in shown]


killed = set()
gapped = {}
for T in TABLES:
    for s in PTS:
        gs = gaps(T, s)
        if gs:
            gapped[s] = gapped.get(s, 0) + 1
        for gamma in gs:
            c1 = T[s[0]][s[1]]
            for (e, cj) in GROUP:
                for w in PTS:
                    if w == (0, 0):
                        if any(g2 not in (c1, gamma) for g2 in gs):
                            killed.add(w)
                        continue
                    u = add(s, rot(e, w, cj))
                    cw = T[u[0]][u[1]]
                    if cw not in (c1, gamma) or any(g2 not in (c1, gamma) for g2 in gaps(T, u)):
                        killed.add(w)

slack_v = {add(s, d) for T in TABLES for s in PTS if gaps(T, s) for d in PTS}
print(f"q = {Q}: vertices gapped in some colouring of the orbit: {len(slack_v)} of {len(PTS)}")
print(f"q = {Q}: gapped vertices in the held table(s): {sum(gapped.values())} (classes y - x: "
      f"{sorted({(s[1] - s[0]) % Q for s in gapped}) if Q == 19 else 'n/a'})")
W = sorted(set(PTS) - killed)
print(f"q = {Q}: exceptional differences (no colouring of the orbit kills the Falconer fan): {len(W)}")
print("W =", W)
