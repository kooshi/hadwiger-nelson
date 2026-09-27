#!/usr/bin/env python3
"""FS105-B stage 1: the setting of EF_F+ at F1 = Q(sqrt 635087), by PARI (seconds).

Checks, each with a plant that must fire for its own reason:
  S1  635087 squarefree, F totally real, [F:Q] = 2.
  S2  no stable dyadic place: every prime of L = F(i) above 2 is moved by the
      conjugation i -> -i of L/F (so R_F = O' by LEDGER row 100, Lemma C').
      Plant: F = Q(sqrt 3), where 3 is not 7 mod 8, must show a stable dyadic place.
  S3  for sample u in U (norm one to F), |u| = 1 at every archimedean place of L and
      v_P(u) = 0 at every stable prime P dividing num/den of u; some split prime has
      v_P(u) != 0 (non-torsion u expands somewhere).  Plant: 2+i (not in U) fails.
  S4  small primes: which primes of L above p < 60 are split (P != conj P) or stable.

Run: python3 tools/fs105_b_setting.py  (exit 0 iff every check passes and every plant fires).
"""
import subprocess
import sys

GP_LIB = r"""
\\ L = F(i) as an absolute field; sigma = the conjugation of L/F (i -> -i, sqrt d fixed)
mkL(d) = {
  my(P = subst(polcompositum(x^2 - d, x^2 + 1)[1], x, y), L = nfinit(P), r, s, sig = 0, rts);
  r = lift(nfroots(L, x^2 + 1)[1]);
  s = lift(nfroots(L, x^2 - d)[1]);
  foreach(nfgaloisconj(L), g,
    my(gi = lift(nfgaloisapply(L, g, r)), gs = lift(nfgaloisapply(L, g, s)));
    if(gi == -r && gs == s, sig = g));
  if(sig == 0, error("no conjugation found"));
  [L, r, s, sig];
}
isstable(L, sig, P) = idealhnf(L, nfgaloisapply(L, sig, P)) == idealhnf(L, P);
"""


def gp(script: str) -> str:
    """Run a gp script, return stdout; raise on nonzero exit."""
    res = subprocess.run(["gp", "-q", "-f", "--default", "parisizemax=2G"],
                         input=GP_LIB + script, capture_output=True, text=True, timeout=300)
    if res.returncode != 0:
        raise RuntimeError(f"gp failed: {res.stderr}")
    if "***" in res.stderr or "***" in res.stdout:
        raise RuntimeError(f"gp error: {res.stdout}\n{res.stderr}")
    return res.stdout.strip()


def dyadic_report(d: int) -> list[tuple[int, int, bool]]:
    """For L = Q(sqrt d, i): each prime above 2 as (e, f, stable?)."""
    out = gp(f"""
    [L, r, s, sig] = mkL({d});
    dec = idealprimedec(L, 2);
    for(k = 1, #dec, my(P = dec[k]); print(P.e, " ", P.f, " ", isstable(L, sig, P)));
    """)
    rows = []
    for line in out.splitlines():
        e, f, st = line.split()
        rows.append((int(e), int(f), st == "1"))
    return rows


def main() -> int:
    ok = True
    d = 635087
    # S1
    out = gp(f"print(issquarefree({d})); print(factor({d})); print(polsturm(x^2-{d}))")
    lines = out.splitlines()
    print("S1 squarefree:", lines[0], " factor:", lines[1], " real roots of x^2-d:", lines[2])
    s1 = lines[0] == "1" and lines[2] == "2"
    ok &= s1
    # S2
    rows = dyadic_report(d)
    print("S2 primes of L above 2 at d=635087 (e, f, stable):", rows)
    s2 = len(rows) > 0 and not any(st for (_, _, st) in rows)
    print("S2 no stable dyadic place:", s2)
    ok &= s2
    plant = dyadic_report(3)
    print("S2-plant d=3 (e, f, stable):", plant)
    fired = any(st for (_, _, st) in plant)
    print("S2-plant fires (stable dyadic place present at Q(sqrt3)):", fired)
    ok &= fired
    # S3 and S4
    out = gp(f"""
    [L, r, s, sig] = mkL({d});
    z = 1 + r + s; u2 = nfeltdiv(L, z, nfgaloisapply(L, sig, z));
    u1 = nfeltdiv(L, 3 + 4*r, 5);
    bad = 2 + r;
    chk(u) = {{
      my(nu = nfeltmul(L, u, nfgaloisapply(L, sig, u)), arch, fac, stab = 1, spl = 0);
      arch = vector(#L.roots, k, abs(subst(lift(nfbasistoalg(L, u)), y, L.roots[k])));
      fac = idealfactor(L, u);
      for(k = 1, #fac~, my(P = fac[k,1], v = fac[k,2]);
        if(isstable(L, sig, P), stab = 0, spl = 1));
      [nfbasistoalg(L, nu) == 1, vecmax(apply(t -> abs(t - 1), arch)) < 1e-30, stab, spl];
    }};
    print(chk(u1)); print(chk(u2)); print(chk(bad));
    {{forprime(p = 2, 59, my(dec = idealprimedec(L, p), st = vector(#dec, k, isstable(L, sig, dec[k])));
      print(p, " ", #dec, " ", dec[1].e, " ", dec[1].f, " ", st))}}
    """)
    lines = out.splitlines()
    print("S3 [norm one, |u|=1 at all arch, unit at all stable P in its support, some split P in support]")
    print("   u1 = (3+4i)/5          :", lines[0])
    print("   u2 = z/sigma(z), z=1+i+sqrt d:", lines[1])
    print("   plant 2+i (not in U)   :", lines[2])
    ok &= lines[0] == "[1, 1, 1, 1]" and lines[1] == "[1, 1, 1, 1]"
    plant_fired = lines[2] != "[1, 1, 1, 1]"
    print("S3-plant fires:", plant_fired)
    ok &= plant_fired
    print("S4 p, #primes of L above p, e, f, stable-vector:")
    for ln in lines[3:]:
        print("   ", ln)
    print("ALL CHECKS PASS AND PLANTS FIRE" if ok else "FAILURE")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
