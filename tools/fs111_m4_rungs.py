#!/usr/bin/env python3
"""FS111-M4: exact checks for the ladder cut-off (plans/FS111-M4-cascade.md, stage 3).

Edge frame of HC (plans/FS111-M3-finiteness.md §1.6): the down triangle's facing side is
[-1/2,1/2] x {0}, its apex (0, -sqrt3/2), the face centre it points at O- = (0, -sqrt3/2 - 2);
the band's flat side is sigma = [-1/2,1/2] x {1}; the up triangle's bottom side is at t = 2, its
apex (0, 2 + sqrt3/2), its face centre O+ = (0, 4 + sqrt3/2). Discs of radius 1/2 at O-, O+.
Rung k of the ladder (k in Z) has its flat side on t = 1 + k and its layer inside
{1 + k < t < 1 + k + 1/64} (every rung is at most as thick as the band, which is <= g <= 1/64).

Checks (sympy, exact):
  K1  over the first Cantor gap |s| <= 1/6: the rung -4 and rung +4 layers (t in (-3, -3 + 1/64]
      and (5, 5 + 1/64]) lie in the open discs about O-, O+; the rung flat sides t = -2, -1, 3, 4
      over |s| <= 1/2 miss both closed discs and both triangles.
  K2  the gap polynomial phi(s) = (s-a)^2 (b-s)^2 / 4 has its maximum w^4/64 at the midpoint;
      the downward bound: the largest n with w^4/64 <= n - sqrt(n^2 - w^2/4) is N-(1/3) = 72.
  K3  the upward bound: min_y [c y^2 + (x-y)^2/2] = x^2 c/(2c+1); with c = w^2/4 the rung count
      n <= 1/(2 * c/(2c+1)) = 1 + 2/w^2, so N+(1/3) <= 19.
  K4  control (the unpinched form, SQ9: squares of side 1/2, colour (i mod 3, j mod 3)): the
      class of the row two above a square is the class of the row below it (W+), the class of the
      row two below is the class of the row above (W-); same-colour facing sides at distance 1.
Plants (each must make exactly its named check fail; the faithful run must pass all):
  far    face centres at distance 3 from the apexes (21/10 and 5/2 still collide at rung 4: the disc is roomy) -> K1
  gdbl   phi doubled                                         -> K2
  c2     c = w^2/2 in K3                                     -> K3
  sq4    SQ9 replaced by squares coloured (i mod 4, j mod 4)  -> K4
Output: data/fs111/fs111-m4/rungs.out (also printed). Exit 0 iff all as expected.
"""
import sys
import sympy as sp

OUT = "data/fs111/fs111-m4/rungs.out"
LOG = []
r3 = sp.sqrt(3)
HALF = sp.Rational(1, 2)


def log(s=""):
    print(s)
    LOG.append(s)


def K1(apex_to_centre=sp.Integer(2)):
    Om = -r3 / 2 - apex_to_centre
    Op = 2 + r3 / 2 + apex_to_centre
    ok = True
    g = sp.Rational(1, 6)
    thin = sp.Rational(1, 64)
    # rung -4 layer: t in (-3, -3+thin], |s| <= 1/6; the disc is convex, so the four corners suffice
    for (s, t) in [(g, -3), (g, -3 + thin), (-g, -3), (-g, -3 + thin)]:
        d2 = s**2 + (t - Om)**2
        if not sp.simplify(d2 - HALF**2).is_negative:
            ok = False
    for (s, t) in [(g, 5), (g, 5 + thin), (-g, 5), (-g, 5 + thin)]:
        d2 = s**2 + (t - Op)**2
        if not sp.simplify(d2 - HALF**2).is_negative:
            ok = False
    # flat sides t = -2, -1, 3, 4 miss both discs (distance from centre along the axis > 1/2)
    # and both triangles (below the down apex / above the up apex)
    for t in [-2, -1, 3, 4]:
        for O in [Om, Op]:
            if not (sp.Abs(t - O) - HALF).is_positive:
                ok = False
    if not ((-r3 / 2) - (-1)).is_positive:
        ok = False
    if not (3 - (2 + r3 / 2)).is_positive:
        ok = False
    return ok


def K2(scale=sp.Integer(1)):
    s, a, w = sp.symbols("s a w", positive=True)
    phi = scale * (s - a)**2 * (a + w - s)**2 / 4
    mid = a + w / 2
    ok = sp.simplify(phi.subs(s, mid) - w**4 / 64) == 0
    ok = ok and sp.simplify(sp.diff(phi, s).subs(s, mid)) == 0
    # largest n with h <= n - sqrt(n^2 - w^2/4), at w = 1/3, h = phi(mid)
    wv = sp.Rational(1, 3)
    h = (scale * (wv / 2)**4 / 4)
    q = wv**2 / 4
    n = 1
    while True:
        m = n + 1
        if (m - sp.sqrt(m**2 - q) - h).is_negative:
            break
        n = m
        if n > 10**4:
            break
    log(f"  K2: largest n with h <= n - sqrt(n^2 - w^2/4) at w = 1/3: {n}")
    return ok and n == 72


def K3(cfun=lambda w: w**2 / 4):
    x, y, c, w = sp.symbols("x y c w", positive=True)
    f = c * y**2 + (x - y)**2 / 2
    ystar = sp.solve(sp.diff(f, y), y)[0]
    fmin = sp.simplify(f.subs(y, ystar))
    ok = sp.simplify(fmin - x**2 * c / (2 * c + 1)) == 0
    ok = ok and sp.simplify(sp.diff(f, y, 2)).is_positive
    cw = cfun(w)
    nmax = sp.simplify(1 / (2 * (cw / (2 * cw + 1))))
    ok = ok and sp.simplify(nmax - (1 + 2 / w**2)) == 0
    val = nmax.subs(w, sp.Rational(1, 3))
    log(f"  K3: upward rung bound 1 + 2/w^2 at w = 1/3: {val}")
    return ok and val == 19


def K4(mod=3):
    ok = True
    for i in range(-6, 7):
        for j in range(-6, 7):
            col = lambda ii, jj: (ii % mod, jj % 3 if mod == 3 else jj % mod)
            below = col(i, j - 1)
            above = col(i, j + 1)
            if col(i, j + 2) != below or col(i, j - 2) != above:
                ok = False
    # same-colour squares: the next one up along a column is 3 rows away (period 3/2); the gap
    # between facing sides is 3/2 - 1/2 = 1 exactly
    if mod == 3 and sp.Rational(3, 2) - HALF != 1:
        ok = False
    return ok


def run(name, far=False, gdbl=False, c2=False, sq4=False):
    res = {
        "K1": K1(sp.Integer(3) if far else sp.Integer(2)),
        "K2": K2(sp.Integer(2) if gdbl else sp.Integer(1)),
        "K3": K3((lambda w: w**2 / 2) if c2 else (lambda w: w**2 / 4)),
        "K4": K4(4 if sq4 else 3),
    }
    log(f"[{name}] " + " ".join(f"{k}={'PASS' if v else 'FAIL'}" for k, v in res.items()))
    return res


def main():
    faithful = run("faithful")
    good = all(faithful.values())
    expect = {"far": "K1", "gdbl": "K2", "c2": "K3", "sq4": "K4"}
    for p, chk in expect.items():
        r = run("plant " + p, **{p: True})
        fails = sorted(k for k, v in r.items() if not v)
        hit = fails == [chk]
        log(f"  plant {p}: fails {fails}; expected [{chk}] -> {'FIRES' if hit else 'DOES NOT FIRE AS EXPECTED'}")
        good = good and hit
    log("ALL AS EXPECTED" if good else "SOMETHING UNEXPECTED")
    with open(OUT, "w") as fh:
        fh.write("\n".join(LOG) + "\n")
    return 0 if good else 1


if __name__ == "__main__":
    sys.exit(main())
