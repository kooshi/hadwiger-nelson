"""FS-89 S0A (verifier G): exact-arithmetic-backed checks of two derived claims about Gamma_q = Cay(F_{q^2}, mu_{q+1}).

(1) Weil: every non-trivial eigenvalue lambda_a = sum_{t in mu_{q+1}} e(Tr(a t)/q) has |lambda_a| <= 2 sqrt(q)
    (G44's Kloosterman form).  Used: the middle-half multiset has |Fourier coefficient| = 1/sin(pi/2q) > 2 sqrt(q) for q >= 11.
(2) Hoffman ratio h(q) = -lambda_min/(d - lambda_min), d = q+1, compared with 1/4 and 1/5.
The circle mu_{q+1} is enumerated exactly as {(x,y) in F_q^2 : x^2+y^2 = 1} (q = 3 mod 4, so i is not in F_q);
Tr(a t) for a = (a1,a2), t = x + iy is 2(a1 x - a2 y) (mod q).  Floats only for the cosine sums; margins are printed.
Not a search: every a is evaluated (the spectrum), nothing is selected.
"""
import math, sys

def circle(q):
    return [(x, y) for x in range(q) for y in range(q) if (x*x + y*y) % q == 1]

def spectrum(q):
    C = circle(q)
    assert len(C) == q + 1, (q, len(C))
    # eigenvalue depends on the linear functional (x,y) -> (b1 x + b2 y) mod q; enumerate all (b1,b2) != 0
    vals = []
    for b1 in range(q):
        for b2 in range(q):
            if b1 == 0 and b2 == 0:
                continue
            s = sum(math.cos(2*math.pi*((b1*x + b2*y) % q)/q) for x, y in C)
            vals.append(s)
    return vals

def middle_half_coeff(q):
    return 1/math.sin(math.pi/(2*q))

qs = [int(a) for a in sys.argv[1:]] or [3, 7, 11, 19, 23, 31, 43, 47, 59, 67, 71, 79, 83]
for q in qs:
    assert q % 4 == 3
    v = spectrum(q)
    d = q + 1
    lmin, amax = min(v), max(abs(x) for x in v)
    h = -lmin/(d - lmin)
    print(f"q={q:3d}  max|lambda|={amax:8.4f}  2sqrt(q)={2*math.sqrt(q):8.4f}  weil_ok={amax <= 2*math.sqrt(q)+1e-9}"
          f"  middle_half_coeff={middle_half_coeff(q):8.4f}  exceeds_weil={middle_half_coeff(q) > 2*math.sqrt(q)}"
          f"  lambda_min={lmin:9.4f}  hoffman={h:.5f}  <1/4:{h < 0.25}  <1/5:{h < 0.2}")
