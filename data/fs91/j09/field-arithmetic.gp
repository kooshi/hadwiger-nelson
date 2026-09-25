pF = polcompositum(x^3-x-1, x^2-7)[1]; F = nfinit(pF);
pL = polcompositum(pF, x^2+1)[1]; L = nfinit(pL);
print("F: degree ", poldegree(pF), ", signature ", F.sign, ", disc ", factor(F.disc));
for(k=1,3, my(p=[2,3,7][k]); print("p=",p,"  F: ", apply(P->[P.e,P.f], idealprimedec(F,p)), "   L: ", apply(P->[P.e,P.f], idealprimedec(L,p))));
