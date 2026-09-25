P = polcompositum(x^3-x-1, x^2-7)[1];
F = nfinit(subst(P,x,y));
print(P, " sig=", F.sign, " disc=", F.disc);
R = rnfinit(F, x^2+1);
for(i=1,3, p=[2,3,7][i]; D=idealprimedec(F,p); for(j=1,#D, pr=D[j]; up=rnfidealprimedec(R, pr); print(p, " e=",pr.e," f=",pr.f," primes above in L: ", #up, " (e,f)= ", vector(#up,k,[up[k].e, up[k].f]))));
