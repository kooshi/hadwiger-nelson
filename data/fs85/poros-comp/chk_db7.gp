P = polcompositum(y^2+3, y^2+11)[1];
E = nfinit(P);
s3 = nfroots(E, x^2+3)[1]; s11 = nfroots(E, x^2+11)[1];
z3 = (-1 + s3)/2; z3i = (-1 - s3)/2;
dec = idealprimedec(E, 2);
print("primes above 2: ", #dec, "  f = ", vector(#dec,i,dec[i].f), "  e = ", vector(#dec,i,dec[i].e));
for(sg=0,1, o = (5 + (-1)^sg*s11)/6; \
  print("omega3 sign ", sg, ": v(o - z3) = ", vector(#dec,i, nfeltval(E, o - z3, dec[i])), \
        "   v(o - z3^-1) = ", vector(#dec,i, nfeltval(E, o - z3i, dec[i])), "  |o|=1 check: ", nfeltnorm(E,o)));
\\ control: a congruence that must fail (omega3 vs 1)
print("control v(o-1) = ", vector(#dec,i, nfeltval(E, (5+s11)/6 - 1, dec[i])));
