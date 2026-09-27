#!/usr/bin/env python3
"""FS105-W exact check (PARI/gp, seconds): admissibility of Gamma = <(3+4i)/5, w> at de Grey's field, by a second route.

Setting as tools/fs105_w_setting.py: F = Q(sqrt3,sqrt5,sqrt7,sqrt11), L = F(i), w = z/c(z), z = sqrt3+sqrt5+sqrt7+sqrt11+21i+1.
Claims checked (plans/FS105-W-walk.md, stage 3):
  A1  For EVERY non-trivial tau in Gal(L/Q) (31 of them), (tau(w)/w)^12 != 1.  Since mu(L) = mu_12, this says tau(w)/w is not a root of
      unity, i.e. tau(w^k) != w^k for every k != 0: no non-zero power of w lies in ANY of the 373 proper subfields of L (each is fixed by
      some non-trivial tau).  So every finite-index subgroup of <u, w> spans L: admissible.  (Stage 1's S6 proved the same by divisors;
      this route uses no prime ideal.)
  A2  <u, w> = Z^2 with u = (3+4i)/5: the valuation vectors of u and w at the primes of L above 5 and 421 have rank 2 (so u^a w^b in mu_12
      forces a = b = 0: torsion-free and independent).
  A3  The same test on u alone fails, as it must: u lies in Q(i) (a Gamma inside U_Q is never admissible).
Plant (--plant wpower): w := (2+i)/sqrt5, which is in U_F with w^2 = (3+4i)/5 in Q(i) -> A1 must fail (tau: sqrt5 -> -sqrt5 gives -1).
Exit 0 iff the checks pass (with --plant: iff A1 fails).
"""
import subprocess, sys

GP = r'''
default(parisize, 10^9);
PLANT = "%PLANT%";
Fp = polcompositum(polcompositum(polcompositum(x^2-3, x^2-5)[1], x^2-7)[1], x^2-11)[1];
Ly = subst(polcompositum(Fp, x^2+1)[1], x, y);
nfL = nfinit([Ly, [2,3,5,7,11]]);
rt(a) = { my(r = nfroots(nfL, x^2 - a)); Mod(lift(r[1]), Ly) };
ii = rt(-1); s3 = rt(3); s5 = rt(5); s7 = rt(7); s11 = rt(11);
auts = nfgaloisconj(nfL);
ap(a, e) = Mod(subst(lift(e), y, a), Ly);
c = 0;
{ for (k = 1, #auts, my(a = auts[k]);
    if (ap(a, ii) == -ii && ap(a, s3) == s3 && ap(a, s5) == s5 && ap(a, s7) == s7 && ap(a, s11) == s11, c = a)); }
if (c == 0, error("no conjugation found"));
z = s3 + s5 + s7 + s11 + 21*ii + 1; w = z / ap(c, z);
if (PLANT == "wpower", w = (2 + ii) / s5);
u = (3 + 4*ii) / 5;
nt = 0; bad = 0; badu = 0;
{ for (k = 1, #auts, my(a = auts[k]); if (a != y, nt++;
    if ((ap(a, w) / w)^12 == 1, bad++);
    if ((ap(a, u) / u)^12 == 1, badu++))); }
print("A1 ", nt, " ", bad, " ", w * ap(c, w) == 1);
P = concat(idealprimedec(nfL, 5), idealprimedec(nfL, 421));
V = matrix(2, #P, r, j, nfeltval(nfL, if (r == 1, u, w), P[j]));
print("A2 ", matrank(V));
print("A3 ", badu);
'''

def run(plant):
    p = subprocess.run(["gp", "-q"], input=GP.replace("%PLANT%", plant or "none") + "\nquit\n",
                       capture_output=True, text=True, timeout=600)
    errs = [l for l in p.stderr.splitlines() if "***" in l and "new stack size" not in l]
    if p.returncode != 0 or errs:
        print("GP ERRORS:"); print("\n".join(errs)); sys.exit(2)
    return {l[:2]: l[3:].split() for l in p.stdout.splitlines() if l[:1] == "A" and l[1:2].isdigit()}

def verdicts(o):
    return {"A1": o.get("A1") == ["31", "0", "1"], "A2": o.get("A2") == ["2"],
            "A3": len(o.get("A3", [])) == 1 and int(o["A3"][0]) > 0}

if __name__ == "__main__":
    o = run(None)
    for k in sorted(o): print(k, " ".join(o[k]))
    v = verdicts(o); print("VERDICTS", v)
    good = all(v.values()); status = 0 if good else 1
    if "--plant" in sys.argv:
        op = run("wpower"); print("PLANTED RUN A1:", " ".join(op.get("A1", ["(absent)"])))
        vp = verdicts(op); fired = not vp["A1"]
        print(f"PLANT wpower: target A1 {'FIRED' if fired else 'DID NOT FIRE'}")
        status = 0 if (good and fired) else 1
    print("EXIT", status); sys.exit(status)
