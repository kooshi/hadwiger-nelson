#!/usr/bin/env python3
"""FS116-V1: the hexagonal seven-colouring of circumradius 1/2 restricted to any disc is a valid 7-coloured fragment
(YESLIM's model at k = 7), exact.  Hexagon centres c(m, n) = m*(sqrt3/2, 0) + n*(sqrt3/4, 3/4) (adjacent centres sqrt3/2 apart);
colour (m + RULE*n) mod MOD, RULE = 5, MOD = 7 (the index-7 sublattice).  A hexagon lies within 1/2 of its centre, so two
same-colour hexagons are at distance > 1 when their centres are more than 2 apart; a hexagon's diameter is 1 (vertex to
opposite vertex), so its interior points are at distance < 1.  Squared centre distance in units of 3/4: m^2 + mn + n^2.
Prints the least squared centre distance between distinct same-colour hexagons, and whether it exceeds 4.
Plant: --plant-mod6 (colour (m + 2n) mod 6) must fail."""
import sys
from fractions import Fraction as Fr

MOD, RULE = (6, 2) if "--plant-mod6" in sys.argv else (7, 5)
best = None
for m in range(-12, 13):
    for n in range(-12, 13):
        if (m, n) != (0, 0) and (m + RULE * n) % MOD == 0:
            d2 = Fr(3, 4) * (m * m + m * n + n * n)
            best = d2 if best is None or d2 < best else best
print(f"least same-colour centre distance^2 = {best}; valid: {best > 4}")
