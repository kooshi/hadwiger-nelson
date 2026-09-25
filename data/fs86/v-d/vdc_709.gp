\\ Verifier D: the brief's example E = Q(sqrt(-709)): dyadic place(s), and stable places below 60
nf = nfinit('y^2 + 709); L = rnfinit(nf, 'x^2 + 1);
dec = idealprimedec(nf, 2);
print("primes above 2: ", #dec, "  (e,f)=", [dec[1].e, dec[1].f], "; -709/3 is a 2-adic square (completion Q2(sqrt3)): ", issquare(-709/3 + O(2^20)));
forprime(p = 3, 60, dp = idealprimedec(nf, p); st = List(); \
  for(j = 1, #dp, if(#rnfidealprimedec(L, dp[j]) == 1, listput(st, p^dp[j].f))); \
  if(#st, print("p=", p, ": stable places with residue sizes ", Vec(st))));
\\ plant: the real field Q(sqrt 59) must show 11, 23, 31, 43, 47, 59 (FS86-A2)
nf2 = nfinit('y^2 - 59); L2 = rnfinit(nf2, 'x^2 + 1); s = List();
forprime(p = 3, 60, dp = idealprimedec(nf2, p); for(j = 1, #dp, if(#rnfidealprimedec(L2, dp[j]) == 1, listput(s, p))));
print("control Q(sqrt59) stable odd primes <60: ", Set(Vec(s)));
