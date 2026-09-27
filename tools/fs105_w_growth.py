#!/usr/bin/env python3
"""FS105-W exact checks (PARI/gp, seconds): EF_F+'s multiplier count and its Step-5 division at degree 16.

Setting: F = F_dG = Q(sqrt3, sqrt5, sqrt7, sqrt11), L = F(i), [L:Q] = 32; |.|_P = N(P)^{-v_P} (normalised); H_L(q) = prod_P max(1,|q|_P)
over the finite places.  U_Q = {q = (a+bi)/c : a^2 + b^2 = c^2} (den q = c).
Claims checked (plans/FS105-W-walk.md, stage 2):
  G1  For EVERY q in U_Q with den q <= DMAX: H_L(q) = (den q)^16 exactly.  Hence, for M = X^16,
      #{q in U_Q : H_L(q) <= M} = #{q in U_Q : den q <= X} = 4 + 8 * #{primitive triples with hypotenuse <= X}, which is
      (4/pi + o(1)) X = (4/pi + o(1)) M^(1/16): the count "c M^(1/[F:Q])" of row 120 / FS100-EFG, in ONE normalisation.
  G2  X01D Step 5's division (Lemma PF for one element): for every pair q1 != q2 in U_Q with den <= D2 and every SPLIT prime P of L
      (c(P) != P) with v_P(q1 - q2) > 0:  |q1 - q2|_P * 4^([L:Q]/2) * H_L(q1) * H_L(q2) >= 1.  At F_dG the dyadic primes are split
      (the wall is broken), so the pair (1, -1), l = 2, puts the bound's archimedean constant to work there.
  G3  X12B Step 4's per-place bound |q1 - q2|_P >= (4 X^4)^(-[L:Q]) at every finite P (X = max den) holds, and the exponent it needs is
      at most [F:Q] = 16, not [L:Q] = 32 (X12B's constant is loose by a factor 2 in the exponent -- the same count in another normalisation).
Plants (--plant NAME), each must turn its own check red:
  unnormalised : |q|_P as p^(-v_P/e_P) (the Q_p-absolute value)          -> G1 fails
  noarch       : drop the factor 4^([L:Q]/2) in G2                          -> G2 fails (at l = 2, a dyadic split prime)
Exit 0 iff every check passes (with --plant: iff the planted check fails).
"""
import subprocess, sys
from math import gcd, isqrt

DMAX, D2 = 101, 13

def uq(dmax):
    """All q in U_Q with den <= dmax, as (a, b, c): q = (a + b i)/c, gcd(a, b, c) = 1."""
    out = set()
    for c in range(1, dmax + 1):
        for a in range(-c, c + 1):
            b2 = c * c - a * a
            b = isqrt(b2)
            if b * b == b2 and gcd(gcd(abs(a), b), c) == 1:
                out.add((a, b, c)); out.add((a, -b, c))
    return sorted(out, key=lambda t: (t[2], t[0], t[1]))

GP = r'''
default(parisize, 10^9);
PLANT = "%PLANT%";
Fp = polcompositum(polcompositum(polcompositum(x^2-3, x^2-5)[1], x^2-7)[1], x^2-11)[1];
Ly = subst(polcompositum(Fp, x^2+1)[1], x, y);
nfL = nfinit([Ly, [2,3,5,7,11]]);
rt(a) = { my(r = nfroots(nfL, x^2 - a)); Mod(lift(r[1]), Ly) };
ii = rt(-1); s3 = rt(3); s5 = rt(5); s7 = rt(7); s11 = rt(11);
auts = nfgaloisconj(nfL); ap(a, e) = Mod(subst(lift(e), y, a), Ly); c = 0;
{ for (k = 1, #auts, my(a = auts[k]);
    if (ap(a, ii) == -ii && ap(a, s3) == s3 && ap(a, s5) == s5 && ap(a, s7) == s7 && ap(a, s11) == s11, c = a)); }
absP(P, v) = if (PLANT == "unnormalised", P.p^(-v / P.e), idealnorm(nfL, P)^(-v));
HL(q) = { my(fa = idealfactor(nfL, q), H = 1);
  for (j = 1, #fa~, if (fa[j,2] < 0, H *= absP(fa[j,1], fa[j,2]))); H };
issplit(P) = { my(pi = nfbasistoalg(nfL, P.gen[2]), cP = idealhnf(nfL, P.p, lift(ap(c, Mod(lift(pi), Ly)))));
  cP != idealhnf(nfL, P) };
Q = %QLIST%;
qe(t) = (t[1] + t[2]*ii) / t[3];
\\ G1
bad1 = 0; { for (j = 1, #Q, my(t = Q[j]); if (HL(qe(t)) != t[3]^16, bad1++)); }
print("G1 ", #Q, " ", bad1);
\\ G2 and G3
arch = if (PLANT == "noarch", 1, 4^(poldegree(Ly)/2));
Q2 = select(t -> t[3] <= %D2%, Q); bad2 = 0; npl = 0; minslack = 10^1000; bad3 = 0; worst3 = 0;
{ for (i = 1, #Q2, for (j = i + 1, #Q2,
    my(q1 = qe(Q2[i]), q2 = qe(Q2[j]), l = q1 - q2, X = max(Q2[i][3], Q2[j][3]), fa = idealfactor(nfL, l), H12 = HL(q1) * HL(q2));
    for (k = 1, #fa~, my(P = fa[k,1], v = fa[k,2]);
      if (v > 0,
        my(ab = idealnorm(nfL, P)^(-v), s);
        if (ab < (4*X^4)^(-poldegree(Ly)), bad3++);
        worst3 = max(worst3, log(1/ab) / log(4*X^4));
        if (issplit(P), npl++; s = ab * arch * H12; if (s < 1, bad2++); minslack = min(minslack, s)))))); }
print("G2 ", #Q2, " ", npl, " ", bad2, " ", if (minslack < 10^999, log(minslack)/log(2), "none"));
print("G3 ", bad3, " ", worst3);
'''

def run(plant):
    Q = uq(DMAX)
    qlist = "[" + ",".join(f"[{a},{b},{c}]" for a, b, c in Q) + "]"
    src = GP.replace("%PLANT%", plant or "none").replace("%QLIST%", qlist).replace("%D2%", str(D2))
    p = subprocess.run(["gp", "-q"], input=src + "\nquit\n", capture_output=True, text=True, timeout=600)
    errs = [l for l in p.stderr.splitlines() if "***" in l and "new stack size" not in l]
    if p.returncode != 0 or errs:
        print("GP ERRORS:"); print("\n".join(errs)); sys.exit(2)
    out = {}
    for line in p.stdout.splitlines():
        if line[:1] == "G" and line[1:2].isdigit():
            out[line[:2]] = line[3:].split()
    return out, Q

def verdicts(o, Q):
    v = {}
    g1 = o.get("G1", [])
    v["G1"] = len(g1) == 2 and int(g1[0]) == len(Q) and g1[1] == "0"
    g2 = o.get("G2", [])
    v["G2"] = len(g2) == 4 and int(g2[1]) > 0 and g2[2] == "0"
    g3 = o.get("G3", [])
    v["G3"] = len(g3) == 2 and g3[0] == "0" and float(g3[1]) <= 16.0 + 1e-9
    return v

def counts(Q):
    """#{q : den q <= X} at a few X, and the triple formula 4 + 8 * #{primitive triples, hypotenuse <= X}."""
    rows = []
    for X in (1, 5, 13, 25, 50, 101):
        n = sum(1 for t in Q if t[2] <= X)
        trip = sum(1 for c in range(2, X + 1) for a in range(1, c) for b in range(a + 1, c)
                   if a * a + b * b == c * c and gcd(a, b) == 1)
        rows.append((X, n, 4 + 8 * trip))
    return rows

if __name__ == "__main__":
    o, Q = run(None)
    for k in sorted(o): print(k, " ".join(o[k]))
    rows = counts(Q)
    print("COUNT (X, #{den<=X}, 4+8*#prim triples):", rows)
    v = verdicts(o, Q)
    v["COUNT"] = all(n == f for _, n, f in rows)
    print("VERDICTS", v)
    good = all(v.values()); status = 0 if good else 1
    if "--plant" in sys.argv:
        name = sys.argv[sys.argv.index("--plant") + 1]
        target = {"unnormalised": "G1", "noarch": "G2"}[name]
        op, _ = run(name)
        print(f"PLANTED RUN {target}:", " ".join(op.get(target, ["(absent)"])))
        vp = verdicts(op, Q); vp["COUNT"] = v["COUNT"]
        fired = not vp[target]
        others = all(vp[k] for k in vp if k != target)
        print(f"PLANT {name}: target {target} {'FIRED' if fired else 'DID NOT FIRE'}; other checks {'unaffected' if others else 'ALSO CHANGED'}")
        status = 0 if (good and fired) else 1
    print("EXIT", status); sys.exit(status)
