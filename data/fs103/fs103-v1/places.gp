\\ FS103-V1: PARI cross-check of stable places (i not in F_v) for Q(sqrt 635087), Q(sqrt 167), and F_dG = Q(sqrt3,sqrt5,sqrt7,sqrt11)
stable(nf, P) = { my(pr = idealprimedec(nf, P), out = List());
  \\ a place v of F is stable iff x^2+1 has no root in F_v, i.e. is irreducible over F_v
  for (j = 1, #pr, my(fa = nffactormod(nf, x^2+1, pr[j]));
     if (P > 2, if (#fa[,1] == 1 && poldegree(fa[1,1]) == 2, listput(out, [P, pr[j].e, pr[j].f])),
       \\ at 2 use the local test: -1 a square in F_v  <=>  x^2+1 has a root in the completion; test via idealfactor of the relative discriminant proxy
       listput(out, [P, pr[j].e, pr[j].f, "dyadic"])));
  Vec(out) };
f635 = nfinit(y^2 - 635087);
f167 = nfinit(y^2 - 167);
print("635087 prime: ", isprime(635087), "  mod 8: ", 635087 % 8, "  mod 3 (sqrt3 test): ", 635087 % 3);
S = []; forprime(p = 2, 1000, S = concat(S, stable(f635, p))); print("Q(sqrt635087) stable places below 1000 (p,e,f): ", S);
print("Q(sqrt635087) kronecker at 635087 (ramified): ", idealprimedec(f635, 635087));
S = []; forprime(p = 2, 100, S = concat(S, stable(f167, p))); print("Q(sqrt167) stable places below 100: ", S);
pdg = polcompositum(polcompositum(x^2-3, x^2-5)[1], polcompositum(x^2-7, x^2-11)[1])[1];
pdg = polredbest(pdg);
fdg = nfinit([subst(pdg, x, y), [2,3,5,7,11]]);
print("F_dG degree ", poldegree(pdg), ", signature ", fdg.sign);
S = []; forprime(p = 2, 600, S = concat(S, stable(fdg, p))); print("F_dG stable places below 600 (p,e,f): ", S);
