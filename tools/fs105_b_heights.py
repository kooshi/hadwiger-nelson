#!/usr/bin/env python3
"""FS105-B stage 2: exact checks of the arithmetic EF_F+'s derivation uses at F1 = Q(sqrt 635087).

H1  H_L(q_s) <= (s^2+1)^2 for q_s = (s+i)/(s-i), s = 1..12, H over all places of L with normalised values.
    Plant P1: the Q(i)-height bound (s^2+1)^1 (the degree exponent [L:Q(i)] = 2 forgotten) must FAIL for some s.
H2  Liouville |a|_P0 >= 1/H(a) and (h3) H(a) <= 16 H(q_s) H(q_t) for a = q_s - q_t, at P0 a prime of L
    where u* = q_2 expands.  Plant P2: dropping the archimedean factors of H must break Liouville for a = 17^3 at a prime above 17.
H3  (control C-2) growth: #{s : H(q_s) <= M} against #{k in Z : H(q_2^k) <= M} for M = 10^4, 10^8, 10^16:
    polynomial against logarithmic.  The cyclic count must fail the Step-4 requirement #Q > e^{n beta} with
    M = C e^{n beta / kappa}; the U_Q family must pass it.
H4  exponent bookkeeping of Step 5 with kappa = 1/4, lambda = log|u*|_P0, beta = kappa*lambda/12: both
    3beta/kappa - lambda < 0 and 11beta/kappa - lambda < 0.  Plant P4: beta = kappa*lambda/5 must violate the second.
H5  Step 6's supply: at a split prime Q of L above 3 (not reached by U_Q), z in Q \\ sigma(Q) gives u = z/sigma(z) in U
    with v_Q(u) != 0.  Plant P5: z = 3 (in Q and sigma Q) gives v_Q(u) = 0.

Run: python3 tools/fs105_b_heights.py ; exit 0 iff every check passes and every plant fires.
"""
import subprocess
import sys
from fractions import Fraction

D = 635087

LIB = r"""
d=%d; P=subst(polcompositum(x^2-d,x^2+1)[1],x,y); L=nfinit(P);
r=lift(nfroots(L,x^2+1)[1]); s=lift(nfroots(L,x^2-d)[1]);
sig=0; foreach(nfgaloisconj(L),g,if(lift(nfgaloisapply(L,g,r))==-r && lift(nfgaloisapply(L,g,s))==s,sig=g));
Hfin(a)=my(f=idealfactor(L,a),h=1); for(k=1,#f~, if(f[k,2]<0, h*=idealnorm(L,f[k,1])^(-f[k,2]))); h;
Harch(a)=my(h=1.,v=lift(nfbasistoalg(L,a))); for(k=1,#L.roots, h*=max(1,abs(subst(v,y,L.roots[k]))^2)); h;
H(a)=Hfin(a)*Harch(a);
q(t)=nfeltdiv(L, t+r, t-r);
absP(a,Pr)=idealnorm(L,Pr)^(-idealval(L,a,Pr));
""" % D


def gp(script: str) -> list[str]:
    res = subprocess.run(["gp", "-q", "-f", "--default", "realprecision=60"], input=LIB + script,
                         capture_output=True, text=True, timeout=300)
    if res.returncode != 0 or "***" in res.stdout or "***" in res.stderr:
        raise RuntimeError(f"gp failed:\n{res.stdout}\n{res.stderr}")
    return res.stdout.strip().splitlines()


def main() -> int:
    ok = True
    # H1 + P1
    out = gp("for(t=1,12, print(t, \" \", H(q(t))));")
    rows = [(int(a), Fraction(b.split(".")[0]) if "." in b else Fraction(b)) for a, b in (ln.split() for ln in out)]
    h1 = all(h <= (t * t + 1) ** 2 for t, h in rows)
    p1 = any(h > (t * t + 1) for t, h in rows)
    print("H1 H_L(q_s), s=1..12:", [(t, int(h)) for t, h in rows])
    print("H1 H_L(q_s) <= (s^2+1)^2 for all:", h1, "| P1 plant (bound (s^2+1)^1) fires:", p1)
    ok &= h1 and p1
    # H2 + P2
    out = gp(r"""
    u=q(2); f=idealfactor(L,u); P0=0; for(k=1,#f~, if(f[k,2]<0, P0=f[k,1]));
    print(idealnorm(L,P0), " ", -idealval(L,u,P0));
    {for(t1=1,6, for(t2=t1+1,7, my(a=q(t1)-q(t2));
       print(t1," ",t2," ",absP(a,P0)*H(a) >= 1 - 1e-40, " ", H(a) <= 16*H(q(t1))*H(q(t2))*(1+1e-40))))}
    P17=idealprimedec(L,17)[1]; a=17^3; print("PLANT ", absP(a,P17)*Hfin(a) >= 1, " ", absP(a,P17)*H(a) >= 1 - 1e-40);
    """)
    nP0, vP0 = map(int, out[0].split())
    print(f"H2 P0: N(P0) = {nP0}, |u*|_P0 = N(P0)^{vP0} with u* = q_2 = (2+i)/(2-i)")
    pairs = [ln.split() for ln in out[1:-1]]
    h2 = all(p[2] == "1" and p[3] == "1" for p in pairs)
    print(f"H2 Liouville and (h3) on {len(pairs)} differences q_s - q_t:", h2)
    plant = out[-1].split()
    p2 = plant[1] == "0" and plant[2] == "1"
    print("H2 P2 plant (no archimedean factor, a = 17^3) breaks Liouville:", plant[1] == "0",
          "| true H restores it:", plant[2] == "1")
    ok &= h2 and p2
    # H3: growth of U_Q family vs the cyclic group <q_2>, heights exact: H(q_s) from H1's formula is <= (s^2+1)^2;
    # H(q_2^k) = H(q_2)^|k| (q_2^k = ((2+i)/(2-i))^k, finite part N(2-i)^{2|k|} in L: 25^|k|).
    Hq2 = 25
    for e in (4, 8, 16):
        M = 10 ** e
        n_family = 0
        t = 1
        while (t * t + 1) ** 2 <= M:
            n_family += 1
            t += 1
        n_cyc = 1
        k = 1
        while Hq2 ** k <= M:
            n_cyc += 2
            k += 1
        print(f"H3 M=1e{e}: #U_Q family with (s^2+1)^2 <= M: {n_family}  (~M^(1/4)={M ** 0.25:.0f});  #<q_2> with H<=M: {n_cyc}")
    # Step-4 requirement: #Q(M) > e^{n beta} at M = C e^{n beta/kappa}. Family: #Q ~ M^{1/4} = C^{1/4} e^{n beta} -> passes for C > 16 (C = 16 is the boundary: equality).
    # Cyclic: #Q(M) ~ 2 log M / log 25 = 2(log C + n beta/kappa)/log 25, linear in n, < e^{n beta} for large n -> fails.
    import math
    kappa, beta = 0.25, 0.25 * math.log(25) / 12
    n = 400
    Mlog = math.log(32) + n * beta / kappa  # M(n) = 32 e^{n beta/kappa} > (2 e^{n beta})^4
    fam = math.exp(Mlog / 4) / 2
    cyc = 2 * Mlog / math.log(25) + 1
    need = math.exp(n * beta)
    h3 = fam > need
    p3 = cyc < need
    print(f"H3 at n={n}: need #Q > e^(n beta) = {need:.3e}; family gives >= {fam:.3e} (pass={h3}); cyclic gives {cyc:.1f} (fails={p3})")
    ok &= h3 and p3
    # H4 exact bookkeeping
    lam = Fraction(1)  # scale-free: lambda = 1 unit
    kap = Fraction(1, 4)
    b = kap * lam / 12
    h4 = (3 * b / kap - lam < 0) and (11 * b / kap - lam < 0)
    bb = kap * lam / 5
    p4 = not (11 * bb / kap - lam < 0)
    print(f"H4 beta=kappa*lambda/12: 3b/k-l={3*b/kap-lam}, 11b/k-l={11*b/kap-lam} (<0: {h4}); plant beta=kappa*lambda/5: 11b/k-l={11*bb/kap-lam} (violates: {p4})")
    ok &= h4 and p4
    # H5 + P5
    out = gp(r"""
    dec=idealprimedec(L,3); Q=dec[1]; sQ=nfgaloisapply(L,sig,Q);
    print(idealhnf(L,Q)!=idealhnf(L,sQ));
    z=0; foreach(Q.gen, g, if(g!=0 && idealval(L,g,sQ)==0 && idealval(L,g,Q)>0, z=g));
    if(z==0, z=nfeltadd(L, Q[2], idealtwoelt(L, idealmul(L,Q,Q))[2]));
    {my(zz=0, B=idealhnf(L,Q)); for(j=1,4, my(g=B[,j]); if(idealval(L,g,sQ)==0, zz=g; break)); if(zz==0, for(j=1,4, for(k=1,4, my(g=B[,j]+B[,k]); if(idealval(L,g,sQ)==0 && zz==0, zz=g)))); z=zz};
    u=nfeltdiv(L,z,nfgaloisapply(L,sig,z)); nu=nfeltmul(L,u,nfgaloisapply(L,sig,u));
    print(nfbasistoalg(L,nu)==1, " ", idealval(L,u,Q), " ", idealval(L,u,sQ));
    u3=nfeltdiv(L,3,3); print("PLANT ", idealval(L,u3,Q));
    """)
    distinct = out[0] == "1"
    norm1, vQ, vsQ = out[1].split()
    h5 = distinct and norm1 == "1" and int(vQ) != 0 and int(vQ) == -int(vsQ)
    p5 = out[2].split()[1] == "0"
    print(f"H5 split prime Q above 3 (Q != sigma Q: {distinct}); u = z/sigma z: norm one {norm1 == '1'}, v_Q(u) = {vQ}, v_sigmaQ(u) = {vsQ} -> {h5}")
    print(f"H5 P5 plant z = 3 gives v_Q = {out[2].split()[1]} (fires: {p5})")
    ok &= h5 and p5
    print("ALL CHECKS PASS AND PLANTS FIRE" if ok else "FAILURE")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
