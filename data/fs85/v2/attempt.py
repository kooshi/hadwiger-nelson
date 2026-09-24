"""Verifier 2 -- C1's adversarial attempt, built by formula (no search): the 2-adic residue colouring at P+ twisted by a 5-adic ridge.

On the component M = (1/3)O_E (and so on Lambda/40Lambda, which restricts isomorphically to M/40M since Lambda = 3Lambda + 40Lambda):
    c(x) = [x + s(lambda(x)) d]  in  M / (1/3)P+  ~  F4,
lambda the linear form of a line l1 in L_alpha1 (so that the ridge sits where the spectrum allows it for alpha1), d a unit vector
whose residue delta has alpha1(delta) = 1/2, s(t) = 1 for t in {1, 2}, else 0.  It is four-valued (so tetrahedron-valued), not
24Lambda-periodic (it depends on x mod 5), and the proof predicts two failures:
  (i)  its spectrum leaves Theta_5 at alpha2 + t l1 (alpha2 the other character with alpha2(delta) = 1/2; l1 is not in L_alpha2, F3);
  (ii) it is not proper: some u in U5 with u = delta mod P+ has lambda(u) != 0 (F6), and the ridge then paints an edge.
Both are exhibited exactly below.
"""
import cmath
from fractions import Fraction as Fr
import w3_facts as W       # re-runs the fact checker (asserts) and exposes its data
from lat import in_lattice, hnf_rows

UM, Pp1 = W.UM, W.Pp1
HP = hnf_rows([list(g) for g in Pp1])
def same_residue(x, y):
    return in_lattice(tuple(a - b for a, b in zip(x, y)), HP)
a1 = W.Aplus[0]
l1 = sorted(W.lines[a1])[0]
lam = lambda x: sum(p * q for p, q in zip(l1, x)) % 5
val = lambda t, x: sum(a * b for a, b in zip(t, x)) % 1        # a character's value
# d: a unit vector with alpha1(d) = 1/2
d = next(u for u in UM.values() if val(a1, u) == Fr(1, 2))
s = lambda t: 1 if t in (1, 2) else 0
def colour(x):
    y = tuple(a + s(lam(x)) * b for a, b in zip(x, d))
    return y
# (ii) an explicit monochromatic edge
bad = None
for u in UM.values():
    if same_residue(u, d) and lam(u) != 0:
        for t in range(5):
            if s(t) != s((t + lam(u)) % 5):
                # x = k e1 with lam(x) = t, e1 = (1,0,0,0) if l1[0] != 0 else another basis vector
                i = next(i for i in range(4) if l1[i]); k = (t * pow(l1[i], -1, 5)) % 5
                x = tuple(k if j == i else 0 for j in range(4))
                xu = tuple(a + b for a, b in zip(x, u))
                if same_residue(colour(x), colour(xu)):
                    bad = (x, u, t); break
        if bad: break
assert bad is not None, "no monochromatic edge found -- the proof's prediction (ii) failed"
x, u, t = bad
print(f"(ii) monochromatic edge: x = {x} (M-coords), u = {u} in U5, lambda(x) = {t}, lambda(u) = {lam(u)}; "
      f"colours equal mod (1/3)P+: {same_residue(colour(x), colour(tuple(a + b for a, b in zip(x, u))))}")
# (i) the spectrum at alpha2 + tau*l1: the function depends on (r, lambda) only; its tetrahedron coefficients at (alpha, tau) are
#     proportional to  sum_t e(-tau t/5) (-1)^{alpha(s(t) delta)}  (the r-sum factors out); nonzero iff alpha(delta) = 1/2 and
#     the ridge sum  sum_{t} e(-tau t / 5) (-1)^{s(t)}  != 0, which holds for every tau != 0 (no proper subset of the fifth roots of
#     unity sums to 0).
a2 = next(a for a in W.Aplus if a != a1 and val(a, d) == Fr(1, 2))
for tau in range(1, 5):
    z = sum(cmath.exp(-2j * cmath.pi * tau * tt / 5) * (-1) ** s(tt) for tt in range(5))
    assert abs(z) > 0.5, z          # float display only; the exact reason is the fifth-roots fact
print(f"(i) alpha2 = {a2} has alpha2(d) = 1/2; l1 = {l1} is in L_alpha1 = {sorted(W.lines[a1])} but not in L_alpha2 = "
      f"{sorted(W.lines[a2])}: so alpha2 + tau*l1 (tau != 0) is in the spectrum and not in Theta_5 -> NT fails somewhere (W1(a))")
assert l1 not in W.lines[a2]
