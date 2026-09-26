#!/usr/bin/env python3
"""X01D exact check (PARI/gp): a non-torsion norm-one unit of L = F(i) when F is not totally real.

Claim checked (EF-G (a) counterexample, plans/FS100-X01D-derivation.md stage 2):
  F = Q(cbrt 2) (real, not totally real), L = F(i). There is u in O_L^x with u * sigma(u) = 1
  (sigma: i -> -i, fixing F), u not a root of unity. Then H(u) = 1 (unit at every finite place)
  while u expands an archimedean place, so h_m(u) > 0 = log H(u).
Control (known answer): for totally real F = Q(sqrt 2), L = F(i) is CM, every eps/sigma(eps) is a
  root of unity (Kronecker), so the same pipeline must report NO non-torsion element.
Plant: --plant uses sigma = identity; then u = 1 for every unit and the F = Q(cbrt 2) check must FAIL.
Exit 0 only if the claim holds, the control holds, and (with --plant) the plant is caught.
"""
import subprocess, sys

GP = r'''
check(fpol, plant) = {
  my(nfF = nfinit(subst(fpol, x, y)), eq = rnfequation(nfF, x^2 + 1, 1), Lpol = eq[1]);
  my(bnf = bnfinit(Lpol, 1), aut = nfgaloisconj(bnf), s = 0, res = List());
  \\ sigma: the automorphism of L fixing F (the image of y) and not the identity
  my(yL = eq[2]);   \\ y expressed in L (as a polmod)
  for (k = 1, #aut, my(a = aut[k]);
    if (a != x && subst(lift(yL), x, Mod(a, Lpol)) == yL, s = a));
  if (plant, s = x);
  if (s == 0, return([-1]));
  my(fu = bnf.fu, tors = 0, nontors = 0, badnorm = 0);
  for (j = 1, #fu,
    my(e = Mod(lift(fu[j]), Lpol), se = Mod(subst(lift(e), x, Mod(s, Lpol)), Lpol), u = e / se);
    if (u * Mod(subst(lift(u), x, Mod(s, Lpol)), Lpol) != 1, badnorm++);
    my(cp = charpoly(u), isunit = (denominator(content(cp)) == 1 && abs(polcoef(cp, 0)) == 1));
    if (!isunit, badnorm++);
    my(r = polroots(cp), mx = vecmax(apply(z -> abs(z), r)));
    if (mx > 1 + 1e-20, nontors++; print("  unit ", j, ": u = eps/sigma(eps), max |conj| = ", mx), tors++));
  [nontors, tors, badnorm, #fu]
};
print("F=Q(cbrt2): ", check(x^3 - 2, PLANT));
print("F=Q(sqrt2): ", check(x^2 - 2, 0));
'''

def run(plant):
    out = subprocess.run(["gp", "-q", "-f"], input=GP.replace("PLANT", "1" if plant else "0"),
                         capture_output=True, text=True, timeout=120).stdout
    print(out.strip())
    res = {}
    for line in out.splitlines():
        if line.startswith("F="):
            k, v = line.split(": ", 1)
            res[k] = [int(t) for t in v.strip("[]").split(",")]
    return res

def verdict(res):
    a, b = res.get("F=Q(cbrt2)"), res.get("F=Q(sqrt2)")
    claim = a is not None and a[0] >= 1 and a[2] == 0
    control = b is not None and b[0] == 0 and b[2] == 0 and b[3] >= 1
    return claim, control

if __name__ == "__main__":
    claim, control = verdict(run(False))
    print(f"CLAIM (non-torsion norm-one unit over Q(cbrt2)): {claim}; CONTROL (none over Q(sqrt2)): {control}")
    if "--plant" in sys.argv:
        pc, _ = verdict(run(True))
        print(f"PLANT (sigma = identity) claim reads: {pc} -> {'CAUGHT' if not pc else 'NOT CAUGHT'}")
        sys.exit(0 if (claim and control and not pc) else 1)
    sys.exit(0 if (claim and control) else 1)
