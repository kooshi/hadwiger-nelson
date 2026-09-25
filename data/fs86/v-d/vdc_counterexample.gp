\\ Verifier D: an explicit field refuting VD-C as briefed (a second, ramified, dyadic place).
\\ Construction by formula: f = g + 2^N (r + K (x^2+x+1)^2), g = (x^2-3)(x-1)(x-3),
\\ r (deg <= 3) by CRT so that f = ffinit(p,4) mod p for p in {3,7,11,19}; K = 4389*k large for positivity.
g = (x^2-3)*(x-1)*(x-3);
N = 10; P = [3,7,11,19]; M = 3*7*11*19;
\\ target irreducible quartics mod p (PARI's deterministic constructor), made monic in x
T = vector(#P, j, lift(ffinit(P[j], 4, 'x)));
\\ r = 2^-N (t_p - g) mod p, coefficientwise, degree <= 3 (leading coefficients cancel: both monic)
r = sum(e = 0, 3, lift(chinese(vector(#P, j, Mod(polcoef(T[j] - g, e) * lift(Mod(2,P[j])^(-N)), P[j])))) * 'x^e);
k = 1; K = M*k;
until(polsturm(f) == 0, f = g + 2^N*(r + K*('x^2+'x+1)^2); if(polsturm(f) != 0, k++; K = M*k));
print("f = ", f);
print("real roots (polsturm): ", polsturm(f), "   irreducible over Q: ", polisirreducible(f));
for(j = 1, #P, print("f mod ", P[j], " irreducible: ", polisirreducible(Mod(1,P[j])*f)));
nf = nfinit(f);
dec = idealprimedec(nf, 2);
print("primes above 2 in E: ", #dec, "  (e,f) = ", vector(#dec, j, [dec[j].e, dec[j].f]));
\\ which dyadic completions contain i?  -1 is a square in E_v iff the prime splits in E(i)/E
L = rnfinit(nf, 'y^2+1);
for(j = 1, #dec, pr = dec[j]; print("dyadic prime ", j, ": e=", pr.e, " f=", pr.f, "; primes of E(i) above it: ", #rnfidealprimedec(L, pr), " with e(L/E) = ", vector(#rnfidealprimedec(L,pr), t, rnfidealprimedec(L,pr)[t].e / pr.e)));
\\ the ramified-degree-2 place should be Q2(sqrt3): check 3 is a square in the residue-completion by factoring f over Q2
print("factorisation of f over Q_2 (precision 2^30): ", factorpadic(f, 2, 30));
for(j = 1, #P, dp = idealprimedec(nf, P[j]); print("primes above ", P[j], ": (e,f) = ", vector(#dp, t, [dp[t].e, dp[t].f])));
