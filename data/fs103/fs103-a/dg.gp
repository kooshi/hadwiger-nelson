\\ stable places of F = Q(sqrt3,sqrt5,sqrt7,sqrt11): places v with residue field size q = 3 mod 4 (odd), i.e. -1 nonsquare in residue field
P = polcompositum(polcompositum(x^2-3,x^2-5)[1], polcompositum(x^2-7,x^2-11)[1])[1];
nf = nfinit(P); print("degree ", poldegree(P), " disc factors ", factor(nf.disc)[,1]~);
L = [];
forprime(p=2,400, dec = idealprimedec(nf,p); for(i=1,#dec, q = p^dec[i].f; if(q%4==3, L = concat(L,[[p,dec[i].e,dec[i].f,q]]))));
print("stable (q = 3 mod 4) places with p<400: ", L);
forprime(p=2,11, dec=idealprimedec(nf,p); print(p, ": #places ", #dec, " e ", dec[1].e, " f ", dec[1].f));
\\ control: plant -- K = Q(sqrt3,sqrt11) must have a stable place at 11 (usable), and at 2 (wall stands)
nfK = nfinit(polcompositum(x^2-3,x^2-11)[1]); LK=[]; forprime(p=2,60, dec=idealprimedec(nfK,p); for(i=1,#dec, q=p^dec[i].f; if(q%4==3 || p==2, LK=concat(LK,[[p,dec[i].e,dec[i].f]])))); print("control K: ", LK);
