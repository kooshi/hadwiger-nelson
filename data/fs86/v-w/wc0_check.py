"""Verifier W, W-C0 numerics (mpmath, 40 digits; floats labelled). Checks a derived claim, finds nothing by search.
(1) min J0 and its location j_{1,1}; (2) the roots x of J0(x) = -1/3 (the stated r0: x = 2*pi*r0);
(3) the stated measure's correlation Sigma(z) = J0(x|z|) at |z| = j11/x: below -1/3 (the scope defect);
(4) the repaired measure  w*delta_0 + (1-w)*circle(2*pi*r = j11),  w = (m - 1/3)/(1 + m), m = -J0(j11):
    Sigma(1) = -1/3 exactly, Sigma(s) >= -1/3 on a grid s in [0, 60] (float scan, a check, not the proof);
(5) the later minima of J0 are above -1/3 (so the repaired Sigma touches -1/3 only at s = 1);
PLANT: w = 0 in (4) must make the grid check fail."""
import mpmath as mp, sys
mp.mp.dps = 40
j11 = mp.besseljzero(1, 1)            # first positive zero of J1 = first extremum of J0
m = -mp.besselj(0, j11)
print("j11 =", mp.nstr(j11, 20), "  min J0 = J0(j11) =", mp.nstr(-m, 20))
roots = [mp.findroot(lambda x: mp.besselj(0, x) + mp.mpf(1)/3, x0) for x0 in (3.2, 4.5)]
for x in roots:
    zbad = j11 / x
    print("root x = 2*pi*r0 =", mp.nstr(x, 15), " r0 =", mp.nstr(x/(2*mp.pi), 12),
          "| stated measure: Sigma(|z| =", mp.nstr(zbad, 8), ") =", mp.nstr(mp.besselj(0, x*zbad), 10), "< -1/3")
w = (m - mp.mpf(1)/3) / (1 + m)
print("repaired weight w =", mp.nstr(w, 20), "  sum p_a^2 of a balanced-mixture reading (w+1/3)*3/4 =", mp.nstr((w + mp.mpf(1)/3)*3/4, 12))
def sig(s, ww):
    return ww + (1 - ww) * mp.besselj(0, j11 * s)
print("repaired Sigma(1) + 1/3 =", mp.nstr(sig(1, w) + mp.mpf(1)/3, 5))
def gridmin(ww, N=60000, top=60):
    mn, arg = mp.mpf(10), None
    for k in range(N + 1):
        s = mp.mpf(top) * k / N
        v = sig(s, ww)
        if v < mn: mn, arg = v, s
    return mn, arg
mp.mp.dps = 20
mn, arg = gridmin(w)
print("[float grid] repaired: min Sigma on [0,60] =", mp.nstr(mn, 12), "at s =", mp.nstr(arg, 6), " (-1/3 =", mp.nstr(-mp.mpf(1)/3, 12), ")")
ok = mn >= -mp.mpf(1)/3 - mp.mpf(10)**-15
mnp, argp = gridmin(mp.mpf(0))
plant_fires = mnp < -mp.mpf(1)/3 - mp.mpf(10)**-6
print("PLANT w=0: min =", mp.nstr(mnp, 10), " fires:", plant_fires)
mins = [mp.besselj(0, mp.besseljzero(1, k)) for k in range(1, 6)]
print("J0 at its first five extrema (J1 zeros):", [mp.nstr(v, 8) for v in mins])
later_ok = all(v > -mp.mpf(1)/3 for v in mins[1:])
print("VERDICT: repaired measure pointwise-consistent:", ok, "| later minima above -1/3:", later_ok, "| plant fired:", plant_fires)
sys.exit(0 if (ok and later_ok and plant_fires) else 1)
