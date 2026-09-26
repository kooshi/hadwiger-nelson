\\ X23V: F = Q(sqrt3)*M7, M7 the degree-7 subfield of Q(zeta_29); L = F(i). Dyadic, 3 and 7 in F and L.
m = polsubcyclo(29,7); f = polcompositum(m, x^2-3)[1]; g = polcompositum(f, x^2+1)[1];
F = nfinit([f,[2,3,7]]); L = nfinit([g,[2,3,7]]);
print("deg F = ", poldegree(f), ", signature ", F.sign);
foreach([2,3,7], p, dF = idealprimedec(F,p); dL = idealprimedec(L,p); print(p, ": F primes ", #dF, " (e,f)=", [dF[1].e, dF[1].f], "; L primes ", #dL, " (e,f)=", [dL[1].e, dL[1].f], "; stable=", #dL==#dF));
quit
