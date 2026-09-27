#!/usr/bin/env python3
"""FS105-W exact checks (PARI/gp, seconds): the setting of MR at de Grey's field F_dG = Q(sqrt3, sqrt5, sqrt7, sqrt11).

Claims checked (plans/FS105-W-walk.md, stage 1):
  S1  [F_dG:Q] = 16 and F_dG is totally real (Sturm count 16).
  S2  L = F_dG(i) has [L:Q] = 32 and signature (0, 16): sixteen complex places, no real one.
  S3  The 2-adic wall is broken: every prime of F_dG above 2 splits in L (L has twice as many primes above 2,
      with the same e and f); hence no stable dyadic place, so R_F = O' (LEDGER row 100) holds.
  S4  G35's congruence agrees: some odd squarefree product of {3,5,7,11} is = 7 (mod 8).
  S5  p0 := the least prime totally split in L (32 primes of residue degree 1), and it is found by the
      Legendre-symbol criterion as well (two independent routes to the same prime).
  S6  Lemma W, explicit: z in O_L with v_{p0}(N_{L/Q} z) = 1 gives w = z/c(z) in U (w c(w) = 1), and
      <(3+4i)/5, w> is admissible: every non-trivial Galois element moves the p0-part of div(w)
      (v_{p0}(N z) = 1 puts exactly one prime above p0 in div(z)). Control: <(3+4i)/5, (5+12i)/13> generates
      only Q(i) (minimal polynomials of degree 2) -- not admissible, as the advisor's risk says.
  S7  Height normalisation: for q = (a+bi)/c in U_Q, H_L(q) := prod over finite P of max(1, N(P)^{-v_P(q)}) equals
      c^16 = c^[F_dG:Q] exactly (so #{q in U_Q : H_L(q) <= M} = #{den q <= M^(1/16)}); |q|_v = 1 at every complex place.
  S8  mu(L) = mu_12, so Gamma = <u, w> is torsion-free once u, w are independent.
Plants (--plant NAME), each must turn its own check red:
  heightnorm  : compute |q|_P as p^{-v_P(q)/e_P} (the Q_p-absolute value, not the normalised one) -> S7 fails
  notsplit    : use the least prime with all five symbols but ONE equal to 1 -> S5's residue-degree test fails
  subfieldz   : take z in Q(i) (z = 2+i) -> S6's admissibility test fails
Exit 0 iff every check passes (and, with --plant, iff the planted check fails).
"""
import subprocess, sys

GP = r'''
default(parisize, 10^9);
PLANT = "%PLANT%";
ns(v) = { my(c = Vec(Str(v)), r = ""); for (j = 1, #c, if (c[j] != " ", r = concat(r, c[j]))); r };
Fp = polcompositum(polcompositum(polcompositum(x^2-3, x^2-5)[1], x^2-7)[1], x^2-11)[1];
Lp = polcompositum(Fp, x^2+1)[1];
Fy = subst(Fp, x, y); Ly = subst(Lp, x, y);
nfF = nfinit([Fy, [2,3,5,7,11]]); nfL = nfinit([Ly, [2,3,5,7,11]]);
print("S1 ", poldegree(Fy), " ", polsturm(Fy));
print("S2 ", poldegree(Ly), " ", nfL.sign[1], " ", nfL.sign[2]);
P2F = idealprimedec(nfF, 2); P2L = idealprimedec(nfL, 2);
print("S3 ", #P2F, " ", #P2L, " ", ns(Set([[p.e,p.f] | p <- P2F])), " ", ns(Set([[p.e,p.f] | p <- P2L])));
cls = [d | d <- [3,5,7,11,15,21,33,35,55,77,105,165,231,385,1155], d%8==7];
print("S4 ", #cls, " ", ns(cls));
rt(a) = { my(r = nfroots(nfL, x^2 - a)); if (#r == 0, error("no root ", a)); Mod(lift(r[1]), Ly) };
ii = rt(-1); s3 = rt(3); s5 = rt(5); s7 = rt(7); s11 = rt(11);
syms(p) = [kronecker(-1,p), kronecker(3,p), kronecker(5,p), kronecker(7,p), kronecker(11,p)];
p0 = 0; forprime(p = 13, 10^6, if (vecmin(syms(p)) == 1, p0 = p; break));
if (PLANT == "notsplit", forprime(p = 13, 10^6, if (#select(t -> t == 1, syms(p)) == 4, p0 = p; break)));
dec = idealprimedec(nfL, p0);
print("S5 ", p0, " ", #dec, " ", ns(Set([[q.e,q.f] | q <- dec])));
auts = nfgaloisconj(nfL);
ap(a, e) = Mod(subst(lift(e), y, a), Ly);
c = 0;
{ for (k = 1, #auts, my(a = auts[k]);
    if (ap(a, ii) == -ii && ap(a, s3) == s3 && ap(a, s5) == s5 && ap(a, s7) == s7 && ap(a, s11) == s11, c = a)); }
if (c == 0, error("no conjugation"));
cj(e) = ap(c, e);
z = 0;
{ for (n = 1, 60, my(t = s3 + s5 + s7 + s11 + n*ii + 1);
    if (valuation(norm(t), p0) == 1, z = t; break)); }
if (PLANT == "subfieldz", z = 2 + ii);
if (z == 0, print("INFO no z with v_p0(N z) = 1 in the list; S6 will fail"); z = 2 + ii);
w = z / cj(z);
q1 = (3 + 4*ii)/5; q2 = (5 + 12*ii)/13;
divp(e) = [nfeltval(nfL, e, P) | P <- dec];
dw = divp(w); moved = 1;
{ for (k = 1, #auts, my(a = auts[k]);
    if (a != y, if (divp(ap(a, w)) == dw, moved = 0))); }
indep = (dw != vector(#dec) && divp(q1) == vector(#dec));
print("S6 ", w * cj(w) == 1, " ", q1 * cj(q1) == 1, " ", moved, " ", indep, " ", poldegree(minpoly(w)), " ", poldegree(minpoly(q1)), " ", poldegree(minpoly(q2)), " ", poldegree(minpoly(q1^3 * q2^5)), " ", valuation(norm(z), p0), " ", lift(z) == lift(s3 + s5 + s7 + s11 + ii + 1) || 1);
HL(q) = { my(fa = idealfactor(nfL, q), H = 1);
  for (j = 1, #fa~, my(P = fa[j,1], v = fa[j,2]);
    if (v < 0, if (PLANT == "heightnorm", H *= P.p^(-v / P.e), H *= idealnorm(nfL, P)^(-v))));
  H };
trip = [[3,4,5],[5,12,13],[8,15,17],[7,24,25],[20,21,29],[12,35,37],[9,40,41],[28,45,53],[11,60,61],[33,56,65]];
ok7 = 1;
{ for (j = 1, #trip, my(t = trip[j], q = (t[1] + t[2]*ii)/t[3]);
    if (HL(q) != t[3]^16, ok7 = 0; print("  S7 miss ", t, " ", HL(q)))); }
arch = vecmax([abs(abs(r) - 1) | r <- polroots(charpoly(q1))]);
archw = vecmax([abs(abs(r) - 1) | r <- polroots(charpoly(w))]);
print("S7 ", ok7, " ", arch < 1e-30, " ", archw < 1e-30);
print("S8 ", nfrootsof1(nfL)[1]);
print("INFO z = sqrt3+sqrt5+sqrt7+sqrt11+n*i+1 with n = ", n0 = 0; for (n = 1, 60, if (lift(z) == lift(s3+s5+s7+s11+n*ii+1), n0 = n)); n0, "; v_p0(N z) = ", valuation(norm(z), p0), "; H_L(w) = ", HL(w), "; H_L(w) = p0^k? ", ispower(HL(w)));
'''

def run(plant):
    p = subprocess.run(["gp", "-q", "-D", "timer=0"], input=GP.replace("%PLANT%", plant or "none") + "\nquit\n",
                       capture_output=True, text=True, timeout=300)
    errs = [l for l in p.stderr.splitlines() if "***" in l and "new stack size" not in l]
    if p.returncode != 0 or errs:
        print("GP ERRORS:"); print("\n".join(errs)); sys.exit(2)
    out = {}
    for line in p.stdout.splitlines():
        if line[:1] == "S" and line[1:2].isdigit():
            out[line[:2]] = line[3:].split()
        elif line.strip():
            print("   ", line)
    return out

def verdicts(o):
    v = {}
    v["S1"] = o.get("S1") == ["16", "16"]
    v["S2"] = o.get("S2") == ["32", "0", "16"]
    s3 = o.get("S3", [])
    v["S3"] = len(s3) == 4 and int(s3[1]) == 2 * int(s3[0]) and s3[2] == s3[3]
    v["S4"] = int(o.get("S4", ["0"])[0]) > 0
    s5 = o.get("S5", [])
    v["S5"] = len(s5) == 3 and s5[1] == "32" and s5[2] == "[[1,1]]"
    v["S6"] = o.get("S6", [])[:4] == ["1", "1", "1", "1"] and o["S6"][4] == "32" and o["S6"][5:8] == ["2", "2", "2"] and o["S6"][8] == "1"
    v["S7"] = o.get("S7") == ["1", "1", "1"]
    v["S8"] = o.get("S8") == ["12"]
    return v

if __name__ == "__main__":
    o = run(None)
    for k in sorted(o): print(k, " ".join(o[k]))
    v = verdicts(o)
    print("VERDICTS", v)
    good = all(v.values())
    status = 0 if good else 1
    if "--plant" in sys.argv:
        name = sys.argv[sys.argv.index("--plant") + 1]
        target = {"heightnorm": "S7", "notsplit": "S5", "subfieldz": "S6"}[name]
        op = run(name)
        print(f"PLANTED RUN {target}:", " ".join(op.get(target, ["(absent)"])))
        vp = verdicts(op)
        fired = not vp[target]
        others = all(vp[k] for k in vp if k != target and not (name == "notsplit" and k == "S6"))
        print(f"PLANT {name}: target {target} {'FIRED' if fired else 'DID NOT FIRE'}; other checks {'unaffected' if others else 'ALSO CHANGED'}")
        status = 0 if (good and fired) else 1
    print("EXIT", status)
    sys.exit(status)
