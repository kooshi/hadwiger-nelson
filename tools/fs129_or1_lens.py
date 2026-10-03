#!/usr/bin/env python3
"""FS129-OR1 — exact checks for the whole-tile restriction (FS129-OR1-WHOLE) and the cut-tile defect.

Check 1 (lens): for p = 0, a unit vector e and a point x with |x| <= rho and |x - 2e| <= 1,
    |x - e|^2 = (|x|^2 + |x - 2e|^2)/2 - 1   (the parallelogram identity on x - e +/- e)
so |x - e|^2 <= (rho^2 - 1)/2, with equality at the two corners of the lens; this is < 1 exactly when rho^2 < 3.
The script verifies the identity symbolically (sympy), the corner value exactly, and that the bound is attained and
sharp at rho = sqrt(3) (value 1), then samples the lens on a rational grid at rho = 17/10 and confirms every sampled
point obeys the bound.

Check 2 (cut): a U-shaped polygon tile of diameter < 1 whose intersection with the open disc B(0, 11/10) has two
components (its two prong tips), so a round restriction to that disc turns one tile into two tiles of one colour
at mutual distance < 1 — a Siamese pair in the restricted fragment. Exact rational arithmetic.

Prints "lens ok; cut ok" when both hold. --fault drops the constraint |x - 2e| <= 1 from the lens sampling (the
witness tile's disc), so the bound is violated; --fault-cut moves the bar inside the disc. Each prints something else.
"""
import sys
from fractions import Fraction as Fr
import sympy as sp

FAULT = "--fault" in sys.argv
FAULT_CUT = "--fault-cut" in sys.argv


def lens_check():
    x, y = sp.symbols("x y", real=True)
    # e = (1, 0) without loss of generality (rotation)
    lhs = (x - 1) ** 2 + y ** 2
    rhs = ((x ** 2 + y ** 2) + ((x - 2) ** 2 + y ** 2)) / 2 - 1
    if sp.simplify(lhs - rhs) != 0:
        return "identity fails"
    # corner of the lens: |x| = rho, |x - 2e| = 1  ->  x-coordinate (rho^2 + 3)/4
    rho = sp.symbols("rho", positive=True)
    xc = (rho ** 2 + 3) / 4
    yc2 = rho ** 2 - xc ** 2
    val = sp.simplify((xc - 1) ** 2 + yc2)
    if sp.simplify(val - (rho ** 2 - 1) / 2) != 0:
        return f"corner value {val}"
    if sp.simplify(val.subs(rho, sp.sqrt(3)) - 1) != 0:
        return "not sharp at sqrt(3)"
    # rational grid sample at rho = 17/10: every lens point obeys |x - e|^2 <= (rho^2 - 1)/2 < 1
    r = Fr(17, 10)
    bound = (r * r - 1) / 2
    n = 400
    worst = Fr(0)
    for i in range(n + 1):
        for j in range(-n, n + 1):
            px = Fr(1) + Fr(i, n) * Fr(9, 10)          # x in [1, 1.9]
            py = Fr(j, n) * Fr(9, 10)                  # y in [-0.9, 0.9]
            if px * px + py * py > r * r:
                continue
            if not FAULT and (px - 2) ** 2 + py * py > 1:
                continue
            d = (px - 1) ** 2 + py * py
            worst = max(worst, d)
    if worst > bound:
        return f"sampled point exceeds the bound: {float(worst):.4f} > {float(bound):.4f}"
    if not bound < 1:
        return "bound not below 1"
    return None


def cut_check():
    # A U-shaped tile: two prongs [a, a+w] x [-h, -h+t] style, built in polar-free Cartesian form.
    # Prongs: rectangles [1.05, 1.3] x [-0.3, -0.25] and [1.05, 1.3] x [0.25, 0.3]; bar: [1.25, 1.3] x [-0.3, 0.3].
    R2 = Fr(121, 100)  # (11/10)^2
    prongA = (Fr(105, 100), Fr(13, 10), Fr(-3, 10), Fr(-25, 100))
    prongB = (Fr(105, 100), Fr(13, 10), Fr(25, 100), Fr(3, 10))
    bar = (Fr(125, 100), Fr(13, 10), Fr(-3, 10), Fr(3, 10))
    if FAULT_CUT:  # planted: the connecting bar moved inside the disc, so the restriction no longer cuts the tile
        bar = (Fr(105, 100), Fr(13, 10), Fr(-3, 10), Fr(3, 10))

    def min_norm2(rect):
        x0, x1, y0, y1 = rect
        cx = min(max(Fr(0), x0), x1)
        cy = min(max(Fr(0), y0), y1)
        return cx * cx + cy * cy

    def max_dist2(r1, r2):
        best = Fr(0)
        for ax in (r1[0], r1[1]):
            for ay in (r1[2], r1[3]):
                for bx in (r2[0], r2[1]):
                    for by in (r2[2], r2[3]):
                        best = max(best, (ax - bx) ** 2 + (ay - by) ** 2)
        return best

    # the bar lies outside the disc, both prong tips reach inside it
    if not min_norm2(bar) >= R2:
        return "bar meets the disc"
    if not (min_norm2(prongA) < R2 and min_norm2(prongB) < R2):
        return "a prong misses the disc"
    # inside the disc the two prongs are disjoint pieces (separated by the gap -0.25 < y < 0.25, which the bar alone spans)
    # diameter of the tile below 1 (max over rectangle corners; the union's diameter is attained at corners)
    diam2 = max(max_dist2(a, b) for a in (prongA, prongB, bar) for b in (prongA, prongB, bar))
    if not diam2 < 1:
        return f"diameter^2 {diam2} not below 1"
    return None


def main():
    e1 = lens_check()
    e2 = cut_check()
    if e1 is None and e2 is None:
        print("lens ok; cut ok")
    else:
        print(f"lens: {e1 or 'ok'}; cut: {e2 or 'ok'}")


if __name__ == "__main__":
    main()
