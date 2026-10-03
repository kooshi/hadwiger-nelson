#!/usr/bin/env python3
"""FS121-V5: exact checks for FS121-D4-GRID (standard library, exact rationals).

  pigeon [--fault]   For k = 2..6 colours: every sequence of k + 1 colours with adjacent entries distinct has two equal entries
                     at index distance between 2 and k (the window the record's Step 2 uses).  Prints the number of sequences
                     that violate this: 0.  --fault uses sequences of length k, where 1, 2, ..., k violates it.
  nonsat [--fault]   Saturation is used: a grid colouring, a.e.-proper, 72 colours, whose B_x accumulates at 0.
                     B_x = (1/4)Z u {1/(4n) : n >= 1}, B_y = (1/4)Z.  A cell in the quarter-square strip m (columns inside
                     [m/4, (m+1)/4]) and row j gets colour (m mod 6, j mod 6, p), p = n mod 2 for the thin column
                     (1/(4(n+1)), 1/(4n)) and p = 0 otherwise.  Checked on the window m, j in -8..7 with thin columns n <= 60:
                     cells sharing an edge differ; two distinct cells of one colour lie in one quarter-square (diameter
                     sqrt(2)/4 < 1) or have closures more than 1 apart.  Prints True.  --fault drops p: adjacent thin
                     columns then share a colour, and it prints False.
"""
import itertools
import sys
from fractions import Fraction as F


def pigeon(fault):
    bad = 0
    for k in range(2, 7):
        L = k if fault else k + 1
        for seq in itertools.product(range(k), repeat=L):
            if any(seq[i] == seq[i + 1] for i in range(L - 1)):
                continue
            if not any(seq[i] == seq[j] for i in range(L) for j in range(i + 2, min(L, i + k + 1))):
                bad += 1
    print(f"violations: {bad}")


def box_gap2(a, b):
    """Squared distance between two closed boxes ((x0,x1),(y0,y1))."""
    dx = max(F(0), a[0][0] - b[0][1], b[0][0] - a[0][1])
    dy = max(F(0), a[1][0] - b[1][1], b[1][0] - a[1][1])
    return dx * dx + dy * dy


def nonsat(fault):
    N = 60
    cols = []  # (interval, strip m, parity p)
    for m in range(-8, 8):
        if m == 0:
            for n in range(N, 0, -1):
                cols.append(((F(1, 4 * (n + 1)), F(1, 4 * n)), 0, 0 if fault else n % 2))
        else:
            cols.append(((F(m, 4), F(m + 1, 4)), m, 0))
    rows = [((F(j, 4), F(j + 1, 4)), j) for j in range(-8, 8)]
    cells = []
    for (I, m, p) in cols:
        for (J, j) in rows:
            cells.append(((I, J), (m % 6, j % 6, p), (m, j)))
    colour = {(c[0][0], c[0][1]): c[1] for c in cells}
    ok = True
    # cells sharing an edge of positive length differ
    for (I, J), col, _ in cells:
        for (I2, J2), col2, _ in cells:
            share_v = J == J2 and (I[1] == I2[0])
            share_h = I == I2 and (J[1] == J2[0])
            if (share_v or share_h) and col == col2:
                ok = False
    # same colour: one quarter-square, or closures more than 1 apart
    by_col = {}
    for c in cells:
        by_col.setdefault(c[1], []).append(c)
    for col, cs in by_col.items():
        for a, b in itertools.combinations(cs, 2):
            if a[2] == b[2]:
                continue  # same quarter-square (m, j): both inside a square of diameter sqrt(2)/4
            if box_gap2(a[0], b[0]) <= 1:
                ok = False
    print(ok and F(2, 16) < 1)


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    fault = "--fault" in sys.argv[1:]
    if args == ["pigeon"]:
        pigeon(fault)
    elif args == ["nonsat"]:
        nonsat(fault)
    else:
        print(__doc__)
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())
