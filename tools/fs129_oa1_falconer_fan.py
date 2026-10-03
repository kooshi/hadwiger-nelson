#!/usr/bin/env python3
"""FS129-OA1: does a Falconer fan at five colours survive on the residue plane at 11?

A *Falconer fan* at k colours (FS129-OA1-FALCONER-FAN, plans/FS129-OA1-audit.md) is a finite unit-distance graph H with an apex a and
a tip t, t not adjacent to a, such that every proper k-colouring of H - a in which N(a) avoids two colours {c1, c2} gives t one of
c1, c2.  (Equivalently Fan(H', k, t, [a1, a2]) for H' = H with a replaced by two adjacent copies a1, a2 of the same neighbourhood.)

The kill (row 66's repaint, transported): let rho : H -> Gamma_11 be a graph homomorphism (any ring map of H's coordinate ring onto
F_11 carries unit vectors to unit vectors: `Slack.unitQuadrance_of_ringHom`).  Take a proper 5-colouring C of Gamma_11 with a gap
gamma at rho(a) (gamma not on N[rho(a)]).  Then C o rho on H - a has N(a) avoiding {C(rho a), gamma}; set c1 = C(rho a), c2 = gamma.
The fan fails at t if C(rho t) is not in {c1, c2}, or if rho(t) has in C a gap colour gamma' not in {c1, c2} (repaint t alone).

This script evaluates a FIXED finite set of colourings -- the orbit of the kernel's two held tables
(Proofs/HadwigerNelson/Instances/FinitePlane11.lean `finitePlane11Table`, Instances/FanGap11.lean `finitePlane11DoubleGapTable`)
under the 24-element point group of Gamma_11 and its 121 translations.  It searches for nothing: no solver, no witness hunt.  It prints
the residue differences w = rho(t) - rho(a) at which NO colouring of that orbit kills the fan (the exceptional set W).

Usage:  python3 tools/fs129_oa1_falconer_fan.py            -> prints W and the counts; exit 0
        python3 tools/fs129_oa1_falconer_fan.py --fault-table   (corrupts one table entry: must refuse, exit 2)
        python3 tools/fs129_oa1_falconer_fan.py --fault-gap     (accepts any colour as a 'gap': W changes)
"""
import sys

Q = 11
T1 = [[0,1,4,0,2,0,1,4,0,3,2],[2,4,1,3,0,1,4,1,3,0,1],[4,3,2,0,1,4,3,4,0,3,0],
      [3,0,1,2,4,1,4,0,2,1,4],[2,3,2,1,3,4,0,3,0,4,3],[1,0,1,4,2,1,2,4,1,3,0],
      [2,1,4,3,0,2,4,3,4,0,3],[1,4,2,1,2,4,1,4,0,2,0],[4,0,3,2,1,3,4,3,2,1,3],
      [3,2,0,1,2,4,0,2,0,2,4],[2,0,2,4,1,3,2,1,3,4,0]]
T2 = [[0,2,0,1,4,3,0,3,1,4,3],[3,0,1,2,3,4,3,0,2,1,2],[0,4,3,0,2,0,4,3,1,2,1],
      [1,2,4,3,0,1,3,4,3,0,2],[2,1,3,0,3,0,1,2,0,4,1],[3,2,4,3,4,3,2,0,1,3,4],
      [4,0,1,2,1,4,0,1,2,1,2],[3,4,3,1,2,0,3,4,1,2,4],[4,1,4,2,1,2,1,3,2,0,1],
      [1,2,3,4,0,1,2,4,3,4,0],[2,1,2,0,3,2,1,2,4,3,1]]

FAULT_TABLE = "--fault-table" in sys.argv
FAULT_GAP = "--fault-gap" in sys.argv
FAULT_NOTRANS = "--fault-notrans" in sys.argv
if FAULT_TABLE:
    T1 = [row[:] for row in T1]
    T1[0][1] = T1[0][0]          # planted: one entry changed

UNITS = [(a, b) for a in range(Q) for b in range(Q) if (a * a + b * b) % Q == 1]
assert len(UNITS) == Q + 1, UNITS          # q = 11 = 3 mod 4: the circle has q + 1 points
PTS = [(x, y) for x in range(Q) for y in range(Q)]


def add(u, v):
    return ((u[0] + v[0]) % Q, (u[1] + v[1]) % Q)


def nbrs(v):
    return [add(v, e) for e in UNITS]


def proper(T):
    return all(T[v[0]][v[1]] != T[w[0]][w[1]] for v in PTS for w in nbrs(v))


for name, T in (("finitePlane11Table", T1), ("finitePlane11DoubleGapTable", T2)):
    if not proper(T):
        print(f"REFUSED: {name} is not a proper colouring of Gamma_11")
        sys.exit(2)

# the point group: multiplication by a unit of F_121 = F_11(i), with or without conjugation
def rot(e, v, conj):
    x, y = v
    if conj:
        y = (-y) % Q
    a, b = e
    return ((a * x - b * y) % Q, (a * y + b * x) % Q)


GROUP = [(e, c) for e in UNITS for c in (False, True)]
assert len(GROUP) == 24


def gaps(T, s):
    """colours absent from the closed neighbourhood of s in T"""
    shown = {T[s[0]][s[1]]} | {T[w[0]][w[1]] for w in nbrs(s)}
    if FAULT_GAP:
        shown = {T[s[0]][s[1]]}            # planted: every other colour counted as a gap
    return [g for g in range(5) if g not in shown]


killed = set()
gapped_vertices = 0
for T in (T1, T2):
    for s in PTS:
        gs = gaps(T, s)
        if gs:
            gapped_vertices += 1
        for gamma in gs:
            c1 = T[s[0]][s[1]]
            for (e, cj) in GROUP:
                # C(w) = T(s + R w): a colouring of Gamma_11 with the gap gamma at 0
                for w in PTS:
                    if w == (0, 0):
                        # tip congruent to the apex: only a second gap at s kills
                        if any(g2 not in (c1, gamma) for g2 in gs):
                            killed.add(w)
                        continue
                    u = add(s, rot(e, w, cj))
                    cw = T[u[0]][u[1]]
                    if cw not in (c1, gamma) or any(g2 not in (c1, gamma) for g2 in gaps(T, u)):
                        killed.add(w)

# slackness of Gamma_11 over the orbit: a vertex v is gapped in some orbit colouring iff some translate of a table is gapped at v
shifts = [(0, 0)] if FAULT_NOTRANS else PTS
slack_v = {add(s, d) for T in (T1, T2) for s in PTS if gaps(T, s) for d in shifts}
print(f"vertices of Gamma_11 gapped in some colouring of the orbit: {len(slack_v)} of {len(PTS)}")
W = sorted(set(PTS) - killed)
print(f"gapped vertices over the two tables: {gapped_vertices} of {2 * len(PTS)}")
print(f"exceptional differences W (no colouring of the orbit kills the Falconer fan): {len(W)}")
print("W =", W)
