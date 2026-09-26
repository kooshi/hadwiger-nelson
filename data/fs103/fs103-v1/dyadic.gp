\\ FS103-V1: dyadic places of F in L = F(i): split (i in F_v) or not, by counting primes of L above each dyadic prime of F
chk(pol) = { my(F = nfinit(pol), L = nfinit(polcompositum(pol, x^2+1)[1]));
  [#idealprimedec(F, 2), #idealprimedec(L, 2), [[q.e, q.f] | q <- idealprimedec(F,2)], [[q.e,q.f] | q <- idealprimedec(L,2)]] };
print("Q(sqrt635087): #primes over 2 in F, in L, (e,f) in F, in L: ", chk(x^2 - 635087));
print("Q(sqrt167): ", chk(x^2 - 167));
print("control Q(sqrt3) (dyadic place stable: one prime of L above it, f doubled, so inert in L/F — the non-split case fires): ", chk(x^2 - 3));
print("control Q(sqrt11): ", chk(x^2 - 11));
print("-7 a square in Q_2: ", issquare(-7 + O(2^30)), "   => i = sqrt(-7)/sqrt(7) lies in every dyadic completion of F_dG (sqrt7 in F_dG)");
F = nfinit(x^2 - 635087); print("place above 635087: e,f = ", [[q.e,q.f] | q <- idealprimedec(F, 635087)], "; 635087 mod 4 = ", 635087 % 4, " so x^2+1 irreducible over F_p: stable");
