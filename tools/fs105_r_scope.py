#!/usr/bin/env python3
"""FS105-R, stage 1: the scope facts of claim (a), exact, by PARI (seconds).

Checks, at F1 = Q(sqrt 635087) and at de Grey's field F_dG = Q(sqrt3, sqrt5, sqrt7, sqrt11):
  S1  635087 is squarefree;
  S2  both fields are totally real, of degrees 2 and 16, and L = F(i) has degree 4 and 32;
  S3  every prime of F above 2 splits in L = F(i) (the 2-adic wall is broken; no stable dyadic place,
      so neither field is one of row 100's exception fields and R_F = O');
  S4  a Lemma W instance at F1 (X02D §2.2): p split completely in L1, (z) = P^h, w = z/c(z) in U,
      and Q(w^k) = L1 for k = 1..6 (the minimal polynomial of w^k has degree 4).

Plants (each must make the run FAIL, for its own reason):
  --plant-wall    replaces F_dG by K = Q(sqrt3, sqrt11), whose wall stands: S3 must fail at K.
  --plant-lemmaw  replaces z by a generator of a prime of Q(i) above a split p, so w lies in Q(i):
                  S4 must fail (degree 2, not 4).
Exit status 0 iff every check passes.
"""
import subprocess
import sys

PLANT_WALL = "--plant-wall" in sys.argv
PLANT_LEMMAW = "--plant-lemmaw" in sys.argv

big_rads = [3, 11] if PLANT_WALL else [3, 5, 7, 11]

GP = r"""
default(parisizemax, 2*10^9);
print("S1 ", issquarefree(635087));
mq(v) = {my(f = x^2 - v[1]); for(j = 2, #v, f = polcompositum(f, x^2 - v[j])[1]); f};
chk(name, v) = {
  my(f = mq(v), F = nfinit([f, [2,3,5,7,11,13]]), g = polcompositum(f, x^2 + 1)[1],
     L = nfinit([g, [2,3,5,7,11,13]]), P = idealprimedec(F, 2), Q = idealprimedec(L, 2));
  print("S2 ", name, " ", poldegree(F.pol), " ", F.sign[2], " ", poldegree(L.pol));
  \\ L/F has degree 2, so 'every dyadic prime of F splits in L' iff #Q == 2 #P
  print("S3 ", name, " ", #P, " ", #Q);
};
chk("F1", [635087]);
chk("FdG", @RADS@);
\\ S4: Lemma W instance at F1.
lemmaw(plant) = {
  my(L1 = bnfinit(subst(polcompositum(x^2 - 635087, x^2 + 1)[1], x, y), 1), h, p, aut, sq, ii, c = 0, z, cz, w, PP, G, Pg, zz);
  h = L1.no;
  p = 2; while(1, p = nextprime(p + 1); if(p % 4 == 1 && #idealprimedec(L1, p) == 4, break));
  aut = nfgaloisconj(L1);
  sq = nfroots(L1, x^2 - 635087)[1]; ii = nfroots(L1, x^2 + 1)[1];
  for(j = 1, #aut, if(nfgaloisapply(L1, aut[j], sq) == sq && nfgaloisapply(L1, aut[j], ii) == -ii, c = aut[j]));
  if(plant,
    G = bnfinit(x^2 + 1); Pg = idealprimedec(G, p)[1]; zz = bnfisprincipal(G, Pg)[2];
    z = subst(lift(nfbasistoalg(G, zz)), x, ii),
    PP = idealprimedec(L1, p)[1]; z = nfbasistoalg(L1, nffactorback(L1, bnfisprincipal(L1, idealpow(L1, PP, h), 4)[2])));
  cz = nfgaloisapply(L1, c, z); w = z / cz;
  print("S4 h=", h, " p=", p, " w*c(w)==1: ", nfgaloisapply(L1, c, w) * w == 1);
  print("S4deg ", vector(6, k, poldegree(minpoly(w^k))));
};
lemmaw(@PLANT@);
"""


def main() -> int:
    script = GP.replace("@RADS@", "[" + ",".join(map(str, big_rads)) + "]").replace("@PLANT@", "1" if PLANT_LEMMAW else "0")
    r = subprocess.run(["gp", "-q", "-f"], input=script, capture_output=True, text=True, timeout=110)
    errs = [ln for ln in r.stderr.splitlines() if "***" in ln and "Warning" not in ln]
    if r.returncode != 0 or errs:
        print("GP FAILED", r.returncode, "\n".join(errs))
        return 2
    out = [ln for ln in r.stdout.splitlines() if ln.strip()]
    print("\n".join(out))
    ok = True
    for ln in out:
        f = ln.split()
        if f[0] == "S1" and f[1] != "1":
            print("FAIL S1: 635087 not squarefree"); ok = False
        if f[0] == "S2":
            name, dF, r2, dL = f[1], int(f[2]), int(f[3]), int(f[4])
            want = {"F1": 2, "FdG": 16}[name]
            if PLANT_WALL and name == "FdG":
                want = 4
            if dF != want or r2 != 0 or dL != 2 * dF:
                print("FAIL S2 at", name, ": degree/totally real"); ok = False
        if f[0] == "S3":
            name, nP, nQ = f[1], int(f[2]), int(f[3])
            if nQ != 2 * nP:
                print("FAIL S3 at", name, ": some dyadic prime of F does not split in F(i)"); ok = False
        if f[0] == "S4" and "w*c(w)==1:" in ln and not ln.rstrip().endswith("1"):
            print("FAIL S4: w not in U"); ok = False
        if f[0] == "S4deg":
            degs = [int(t) for t in ln.split("[")[1].rstrip("]").split(",")]
            if any(dg != 4 for dg in degs):
                print("FAIL S4: Q(w^k) != L1 for some k:", degs); ok = False
    for tag in ("S1", "S2", "S3", "S4", "S4deg"):
        if not any(ln.split()[0] == tag for ln in out):
            print("FAIL: no", tag, "line was printed (a check that did not run)"); ok = False
    print("ALL PASS" if ok else "SOME CHECK FAILED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
