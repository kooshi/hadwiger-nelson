\\ Verifier W, W-A input checks (exact). K(i) = Q(sqrt3, sqrt11, i), field variable y.
f = subst(polcompositum(polcompositum(x^2-3, x^2-11)[1], x^2+1)[1], x, y);
nf = nfinit([f, [2,3,11]]);
r11 = nfroots(nf, x^2-11)[1]; ii = nfroots(nf, x^2+1)[1];
sm11 = nfeltmul(nf, ii, r11);
v = nfeltmul(nf, -4/9, 1 + nfalgtobasis(nf, sm11));
vb = nfeltmul(nf, -4/9, 1 - nfalgtobasis(nf, sm11));
P = idealprimedec(nf, 2);
print("primes above 2: ", #P, "   [e,f]: ", vector(#P,k,[P[k].e, P[k].f]));
for(k=1,#P, print("prime ",k,": v(v)=", idealval(nf, v, P[k]), "  v(8)=", idealval(nf, 8, P[k]), "  v(4)=", idealval(nf,4,P[k]), "  v(8/3)=", idealval(nf, 8/3, P[k])));
print("v*vbar = ", nfbasistoalg(nf, nfeltmul(nf, v, vb)), "   expected 64/27");
print("33 mod 8 = ", 33 % 8, "   issquare(33 + O(2^20)) = ", issquare(33 + O(2^20)));
\\ PLANT: v with the 4 replaced by 2 must have valuation 4, not 6
vp = nfeltmul(nf, -2/9, 1 + nfalgtobasis(nf, sm11));
print("PLANT (2 in place of 4): v = ", vector(#P,k,idealval(nf, vp, P[k])), "  (must read 4, not 6)");
quit
