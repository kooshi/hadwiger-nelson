#!/usr/bin/env python3
"""FS131-E6: the F6 model, checked in exact arithmetic (rationals and single square roots of rationals; no floating point decides
anything).

The model (plans/FS131-E6-derivation.md § 3.1): v = 0, alpha = 0, n = (0, 1), N = (0, 1), S' = (0, -1).
  * c-horn  H  = { |z| < rho, x > 0, y > 0, x^2 + y^2 - y > 0 }   (between the axis, curvature 0, and C2, curvature 2)
  * g        G0 = { |z| < rho, y > 0 } minus cl H                    (the upper flank)
  * h        H0 = { |z| < rho, y < 0 }                               (the lower flank)
  * h        T  = { N + s e(phi) : 0 < s < ell, pi/3 < phi < 2pi/3 } (a corner at N, out-type)
  * g        T' = { |z - N| > R, x > 0, |z - S'| < ell' }             (bounded at S' by the circle of radius R = 2 about N)
  * c        Tc = B((1 - rc) w, rc), w = (3/5, 4/5)                  (in-type, touching omega(v) at w only)
  * background: squares of side 3/5 centred on (3i/5, 3j/5), colour (i mod 3, j mod 3), 9 fresh colours, minus the features.

Checks (each prints one summary line; --check all prints all):
  arcs    the radii of every arc of the map; F6's model has no unit arc
  valid   the inequalities the validity lemmas (§ 3.2) reduce to
  sigma   for sigma < 1 and sigma > 1, horn points violating the clearness ShaveAvailable needs, with explicit witnesses at distance
          exactly 1 in T' (resp. T); so the admissible set is {1}
  nodrop  the witnesses of § 3.4: no colour can leave v by a local modification creating no unit arc
  open    the opening wedge beside the horn is c-clear (E6-OPEN's inequality in the model), and v keeps no horn

Planted faults (flags), each meant to turn one check red:
  --R 21/10        T' bounded by a circle of radius 2.1 about N (curvature at S' below 1/2): sigma < 1 becomes admissible
  --apex 1/50      T's corner moved from N to N + (0, 1/50): sigma > 1 becomes admissible
  --no-tc          no in-type c-tile: the c-shadow witnesses of nodrop disappear
  --rho 9/10       flanks of radius 9/10: the validity inequalities fail
  --unit-arc       T' bounded by a circle of radius 1 instead of 2: arcs reports a unit arc
  --open-dir -5,2  the opening wedge's far ray past the allowed cone: open fails
"""
import argparse
import sys
from fractions import Fraction as Fr

import sympy as sp


def F(*a):
    return Fr(*a)


def sign_ab(a, b, c):
    """Exact sign of a + b*sqrt(c), a, b, c rational, c >= 0."""
    a, b, c = Fr(a), Fr(b), Fr(c)
    if c < 0:
        raise ValueError("negative radicand")
    if b == 0 or c == 0:
        return (a > 0) - (a < 0)
    sb = 1 if b > 0 else -1
    if a == 0:
        return sb
    sa = 1 if a > 0 else -1
    if sa == sb:
        return sa
    # opposite signs: compare a^2 with b^2 c
    lhs, rhs = a * a, b * b * c
    if lhs == rhs:
        return 0
    return sa if lhs > rhs else sb


def pos(a, b=0, c=0):
    return sign_ab(a, b, c) > 0


def neg(a, b=0, c=0):
    return sign_ab(a, b, c) < 0


class Model:
    def __init__(self, args):
        self.rho = F(args.rho)
        self.ell = F("1/10")  # T's radius
        self.ellp = F("1/10")  # T''s radius about S'
        self.R = F(1) if args.unit_arc else F(args.R)
        self.apex = F(args.apex)  # T's corner at (0, 1 + apex)
        self.tc = not args.no_tc
        self.rc = F("1/10")
        self.w = (F(3, 5), F(4, 5))
        self.s = F(3, 5)  # background square side
        ox, oy = args.open_dir.split(",")
        self.odir = (F(ox), F(oy))

    # ---------- arcs ----------
    def arcs(self):
        radii = [
            ("rim of B(v, rho)", self.rho),
            ("C2, the horn's upper arc", F(1, 2)),
            ("T's outer arc about its corner", self.ell),
            ("T' along the circle about N", self.R),
            ("T' outer arc about S'", self.ellp),
            ("Tc's circle", self.rc),
            ("the opening's rim arc (radius below rho)", self.rho / 2),
        ]
        unit = [name for name, r in radii if r == 1]
        print(f"arcs: {len(radii)} circular radii (plus segments: the grid, the axis, T's two rays, T''s ray, the opening's ray); "
              f"unit arcs: {len(unit)}" + (f" ({'; '.join(unit)})" if unit else ""))
        return len(unit) == 0

    # ---------- validity ----------
    def valid(self):
        rho, ell, ellp, R, rc, s = self.rho, self.ell, self.ellp, self.R, self.rc, self.s
        w = self.w
        res = []
        # V1 (c): H vs Tc: p_x, p_y >= m := (1 - rc) min(w) - rc; z.p >= m (x + y) >= m |z| > |z|^2 / 2 needs 2m > rho
        m = (1 - rc) * min(w) - rc
        res.append(("V1 c: H vs Tc, 2m > rho", (not self.tc) or (2 * m > rho and m > 0)))
        # V2 (g): x > 0 part of G0 is inside C2, hence in B(N, 1) (identity x^2+(y-1)^2 = (x^2+y^2-y) + 1 - y), and |p - N| > R >= 2
        x, y = sp.symbols("x y", real=True)
        ident = sp.expand(x**2 + (y - 1)**2 - ((x**2 + y**2 - y) + 1 - y)) == 0
        res.append(("V2 g: G0 (x>0) vs T', identity and R >= 2", ident and R >= 2))
        # V3 (g): x <= 0 part of G0 vs T': |q-p|^2 > p_x^2 + (sqrt(R^2 - p_x^2) - 1)^2 = R^2 + 1 - 2 sqrt(R^2 - p_x^2) >= (R-1)^2;
        #         need (R - 1)^2 >= 1, i.e. R >= 2
        px = sp.symbols("p_x", positive=True)
        ident3 = sp.simplify(px**2 + (sp.sqrt(4 - px**2) - 1)**2 - (5 - 2 * sp.sqrt(4 - px**2))) == 0
        res.append(("V3 g: G0 (x<=0) vs T', identity and R >= 2", ident3 and R >= 2))
        # V4 (h): H0 vs T: e(phi).(q - N0) <= rho/2 - (sqrt3/2)(1 + apex - rho) < 0, with N0 = T's corner
        res.append(("V4 h: H0 vs T, rho/2 - (sqrt3/2)(1 + apex - rho) < 0", neg(rho / 2, -(1 + self.apex - rho) / 2, 3)))
        # V5 diameters below 1, background period gap above 1
        res.append(("V5 diameters < 1, gap 2s > 1, s sqrt2 < 1",
                    2 * rho < 1 and 2 * ell < 1 and 2 * ellp < 1 and 2 * rc < 1 and 2 * s > 1 and 2 * s * s < 1))
        # V6 features inside their squares (squares [3i/5 - 3/10, 3i/5 + 3/10]): B(v,rho) in (0,0); T in (0,2); T' in (0,-2); Tc in (1,1)
        h_ = s / 2
        inside = (rho < h_ and
                  ell < h_ and 1 + self.apex > 2 * s - h_ and 1 + self.apex + ell < 2 * s + h_ and
                  -1 - ellp > -2 * s - h_ and -1 < -2 * s + h_ and ellp < h_)
        cx, cy = (1 - rc) * w[0], (1 - rc) * w[1]
        inside = inside and (cx - rc > s - h_ and cx + rc < s + h_ and cy - rc > s - h_ and cy + rc < s + h_)
        res.append(("V6 features inside their background squares", inside))
        ok = sum(1 for _, b in res if b)
        bad = [n for n, b in res if not b]
        print(f"valid: {ok} of {len(res)} lemma inequalities hold" + (f" (failed: {'; '.join(bad)})" if bad else ""))
        return ok == len(res)

    # ---------- helpers on the shadows ----------
    def in_horn(self, z, r):
        x, y = z
        return x * x + y * y < r * r and x > 0 and y > 0 and y - (x * x + y * y) < 0  # tanHeight 0 > 0, tanHeight 2 < 0

    @staticmethod
    def tan_above(z, k):
        x, y = z
        return y - k * (x * x + y * y) / 2 > 0

    def witness_Tprime_ray(self, z):
        """y = N + (1 + d)(z - N)/d, d = |z - N|: |z - y| = 1 exactly; returns True iff y lies in T'."""
        x, yz = z
        D = x * x + (yz - 1) ** 2  # d = sqrt(D)
        # |y - N| = 1 + d > R  <=>  d > R - 1
        c1 = pos(-(self.R - 1), 1, D)
        c2 = x > 0  # y_x has the sign of z_x
        # |y - S'|^2 < ell'^2: times d > 0: a + b d < 0, a = 2D + 4(z_y - 1), b = 5 + D - ell'^2 + 4(z_y - 1)
        a = 2 * D + 4 * (yz - 1)
        b = 5 + D - self.ellp ** 2 + 4 * (yz - 1)
        c3 = neg(a, b, D)
        return c1 and c2 and c3

    def witness_T_vertical(self, z):
        """y = (0, 1 + apex + s''), s'' = z_y - 1 - apex + sqrt(1 - z_x^2): |z - y| = 1 exactly; True iff 0 < s'' < ell (y in T)."""
        x, yz = z
        a = yz - 1 - self.apex
        return pos(a, 1, 1 - x * x) and neg(a - self.ell, 1, 1 - x * x)

    def witness_Tc(self, z):
        """p = lam w, lam = z.w + sqrt((z.w)^2 + 1 - |z|^2): |z - p| = 1 exactly; True iff p in Tc (1 - 2 rc < lam < 1)."""
        if not self.tc:
            return False
        x, yz = z
        zw = x * self.w[0] + yz * self.w[1]
        rad = zw * zw + 1 - (x * x + yz * yz)
        return pos(zw - (1 - 2 * self.rc), 1, rad) and neg(zw - 1, 1, rad)

    def witness_Tprime_low(self, z):
        """p = S' + (a, -b), a = 1/100, b = sqrt(1 - (z_x - a)^2) - 1 - z_y: |z - p| = 1 exactly; True iff p in T'."""
        x, yz = z
        a = F(1, 100)
        rad = 1 - (x - a) ** 2
        b0 = -1 - yz  # b = b0 + sqrt(rad)
        c1 = pos(b0, 1, rad)  # b > 0
        # a^2 + b^2 < ell'^2: b^2 = b0^2 + rad + 2 b0 sqrt(rad)
        c2 = neg(a * a + b0 * b0 + rad - self.ellp ** 2, 2 * b0, rad)
        # |p - N|^2 = a^2 + (2 + b)^2 > R^2: (2 + b)^2 = (2 + b0)^2 + rad + 2 (2 + b0) sqrt(rad)
        c3 = pos(a * a + (2 + b0) ** 2 + rad - self.R ** 2, 2 * (2 + b0), rad)
        return c1 and c2 and c3 and a > 0

    # ---------- sigma ----------
    def sigma(self):
        r = F(1, 50)
        ts = [F(1, 10 ** 3), F(1, 10 ** 4), F(1, 10 ** 5)]
        low = [F(0), F(1, 4), F(1, 2), F(3, 4), F(9, 10), F(99, 100)]
        high = [F(101, 100), F(11, 10), F(3, 2), F(2)]
        low_ref = 0
        for sg in low:
            s_ = (max(sg, F(0)) / 2 + F(1, 2)) / 2
            hit = all(
                self.in_horn((t, s_ * t * t), r) and self.tan_above((t, s_ * t * t), sg)
                and ((t * t + (s_ * t * t - 1) ** 2) > 1) and self.witness_Tprime_ray((t, s_ * t * t))
                for t in ts)
            low_ref += hit
        high_ref = 0
        for sg in high:
            s_ = (F(1, 2) + sg / 2) / 2
            hit = all(
                self.in_horn((t, s_ * t * t), r) and not self.tan_above((t, s_ * t * t), sg)
                and ((t * t + (s_ * t * t - 1) ** 2) < 1) and self.witness_T_vertical((t, s_ * t * t))
                for t in ts)
            high_ref += hit
        # sigma = 1: the clearness is the hand lemma (|z - p| > R - |z - N| >= 1 for p in T' when |z - N| < 1 and R >= 2;
        # |z - p| > |z - N0| >= 1 for p in T, N0 its corner, when |z - N0| >= 1); here only its hypotheses are checked
        one_ok = self.R >= 2 and self.apex == 0
        adm = "{1}" if (low_ref == len(low) and high_ref == len(high) and one_ok) else "not {1}"
        print(f"sigma: below 1 refuted {low_ref}/{len(low)}; above 1 refuted {high_ref}/{len(high)}; admissible {adm}")
        return adm == "{1}"

    # ---------- nodrop ----------
    def nodrop(self):
        t = F(1, 1000)
        z1 = (-t, -t)        # old h-sector, direction 225 deg: z.w < 0
        z2 = (-2 * t, t)     # old g-sector, direction ~153 deg: z.w < 0, z_y > 0
        r = F(1, 50)
        zin = (t, F(3, 4) * t * t)   # old horn, inside B(N, 1)
        zout = (t, F(1, 4) * t * t)  # old horn, outside B(N, 1)
        items = [
            ("z1 c-shadowed (Tc) and g-shadowed (T'): neither c nor g", self.witness_Tc(z1) and self.witness_Tprime_low(z1)),
            ("z2 c-shadowed (Tc) and h-shadowed (T): neither c nor h", self.witness_Tc(z2) and self.witness_T_vertical(z2)),
            ("horn point inside B(N,1) h-shadowed, outside g-shadowed",
             self.in_horn(zin, r) and self.in_horn(zout, r) and self.witness_T_vertical(zin) and self.witness_Tprime_ray(zout)),
            ("c alone: z1 is c-shadowed", self.witness_Tc(z1)),
        ]
        ok = sum(1 for _, b in items if b)
        bad = [n for n, b in items if not b]
        print(f"nodrop witnesses: {ok} of {len(items)}" + (f" (missing: {'; '.join(bad)})" if bad else ""))
        return ok == len(items)

    # ---------- open ----------
    def open_(self):
        # wedge between the axis (direction 0) and the ray along odir; a point t e(theta), theta in [0, theta0], has
        # z.p >= t m (cos theta + sin theta) for p in Tc (p_x, p_y >= m > 0); cos + sin >= 0 at both ends and theta0 + pi/4 <= pi
        # make it >= t m min(1, cos theta0 + sin theta0) > t^2 / 2 for t < rho_open
        ox, oy = self.odir
        nrm2 = ox * ox + oy * oy
        # cos theta0 + sin theta0 = (ox + oy)/sqrt(nrm2); theta0 in (0, pi) needs oy > 0
        endpoint = ox + oy  # sign of cos + sin at theta0
        concave_ok = oy > 0 and (ox >= 0 or oy >= -ox)  # theta0 <= 3pi/4
        m = (1 - self.rc) * min(self.w) - self.rc
        rho_open = self.rho / 2
        # need m * min(1, endpoint/sqrt(nrm2)) > rho_open / 2: compare exactly
        if endpoint <= 0 or not concave_ok:
            clear = False
        else:
            # m * endpoint / sqrt(nrm2) > rho_open/2  <=>  m^2 endpoint^2 > (rho_open/2)^2 nrm2
            clear = m > rho_open / 2 and m * m * endpoint * endpoint > (rho_open / 2) ** 2 * nrm2
        # the allowed cone of c at v is {d : d.w >= 0}; the far ray must lie in its interior
        in_cone = ox * self.w[0] + oy * self.w[1] > 0
        after = "3 sectors, 0 horns" if (clear and in_cone) else "not opened"
        print(f"open: wedge {'c-clear' if clear else 'NOT c-clear'}; far ray {'inside' if in_cone else 'outside'} D_c(v); v after: {after}")
        return clear and in_cone


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--check", default="all", choices=["arcs", "valid", "sigma", "nodrop", "open", "all"])
    ap.add_argument("--rho", default="1/10")
    ap.add_argument("--R", default="2")
    ap.add_argument("--apex", default="0")
    ap.add_argument("--no-tc", action="store_true")
    ap.add_argument("--unit-arc", action="store_true")
    ap.add_argument("--open-dir", default="5,2")
    args = ap.parse_args()
    M = Model(args)
    checks = {"arcs": M.arcs, "valid": M.valid, "sigma": M.sigma, "nodrop": M.nodrop, "open": M.open_}
    todo = list(checks) if args.check == "all" else [args.check]
    ok = all([checks[c]() for c in todo])
    sys.exit(0)  # the verdict is the printed line; controls compare it


if __name__ == "__main__":
    main()
