\\ Verifier D: behaviour of E's dyadic places in E(i) for the field of vdc_counterexample.gp
f = 4494337*x^4 + 11933692*x^3 + 17314816*x^2 + 12362764*x + 6083575;
fy = subst(polredbest(f), 'x, 'y);
print("monic model: ", fy, "   isomorphic to f's field: ", nfisisom(subst(fy,'y,'x), f) != 0);
nf = nfinit(fy);
print("signature (r1,r2): ", nf.sign);
dec = idealprimedec(nf, 2);
L = rnfinit(nf, 'x^2 + 1);
for(j = 1, #dec, pr = dec[j]; up = rnfidealprimedec(L, pr); \
  print("dyadic prime ", j, ": e=", pr.e, " f=", pr.f, "; #primes of E(i) above = ", #up, \
        "; e(E(i)/Q) of those = ", vector(#up, t, up[t].e), "  -> ", \
        if(#up == 2, "SPLIT (not stable)", if(up[1].e == 2*pr.e, "RAMIFIED in E(i) (stable)", "INERT in E(i) (stable)"))));
\\ is 3 a square in the completion at the (e=2,f=1) place? i.e. is that completion Q2(sqrt3)?
\\ test: E_v = Q2(sqrt(-c)) with the local quadratic factor x^2 + b x + c; its discriminant b^2-4c over 12 should be a 2-adic square
F2 = factorpadic(f, 2, 40); q = F2[3,1]; D = polcoef(q,1)^2 - 4*polcoef(q,0);
print("local quadratic factor's discriminant / 12 is a 2-adic square: ", issquare(D/12));
print("  control: discriminant / 3 (should also be square, since 4 is): ", issquare(D/3), "; discriminant/6 (should NOT be): ", issquare(D/6));
