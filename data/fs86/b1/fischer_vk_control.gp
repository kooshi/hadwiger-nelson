\\ FS-86 verifier B1: a positive control for VK by formula (no search).  [Fischer1994]'s additive 4-colouring of the plane over
\\ K = Q(sqrt3, sqrt11) (K is in his family: 3 = 3, 11 = 11 mod 16, 33 = 1 mod 32) is v(x) = f(x) mod 4, with f the Q-linear
\\ functional f(x) = 2 (x_1 + x_i + x_s33 + x_is33) on coordinates over the basis {1, s3, s11, s33} x {1, i}, s33 = s3*s11
\\ (tools/fischer1994_check.py's docstring: v(xi) = 2(a0 + b0 + a3 + b3)/c).  VK predicts: f kills (maps into 4 Z_(2)) the ideal
\\ R_K cap P_j^4 for exactly ONE dyadic prime P_j (the colouring reads one prime), and — since v separates (0, 2P), 2P of
\\ valuation 2 at both primes — kills R_K cap P_j^2 for NEITHER j (the two-sided control: this outcome is reachable and must
\\ come out "not killed").  Test on a Z-basis of each ideal of O_L (the localisation at 2 does not change 2-adic valuations).
default(parisize, "200M");
L = nfinit(polcompositum(polcompositum(y^2-3, y^2-11)[1], y^2+1)[1]);
r3 = nfroots(L, x^2-3)[1]; r11 = nfroots(L, x^2-11)[1]; ri = nfroots(L, x^2+1)[1];
r33 = nfeltmul(L, r3, r11);
B = [1, r3, r11, r33, ri, nfeltmul(L,ri,r3), nfeltmul(L,ri,r11), nfeltmul(L,ri,r33)];
M = matconcat(vector(8, j, nfalgtobasis(L, B[j])));   \\ columns: B in zk coordinates
Minv = M^-1;
f(xz) = { my(c = Minv * xz); 2*(c[1] + c[5] + c[4] + c[8]); }   \\ xz: zk-coordinates column
v2(q) = if (q == 0, oo, valuation(q, 2));
\\ sanity: f(1) = 2, f(i) = 2 (nonzero mod 4, as a colouring needs on unit vectors)
print("f(1) = ", f(nfalgtobasis(L,1)), ", f(i) = ", f(nfalgtobasis(L,ri)));
P = idealprimedec(L, 2); print("#primes above 2: ", #P, " (e,f) = ", [[P[1].e,P[1].f],[P[2].e,P[2].f]]);
for (j = 1, 2, foreach([2, 3, 4], k, my(I = idealpow(L, P[j], k), vals = vector(8, t, v2(f(I[,t])))); \
  print("P_", j, "^", k, ": min 2-adic valuation of f on a Z-basis = ", vecmin(vals), "  -> ", if (vecmin(vals) >= 2, "KILLED (maps into 4Z_(2))", "not killed"))));
\\ plant: a wrong functional f'(x) = 2 (x_1 + x_i) (drops the sqrt33 terms) is not a colouring; report what it does (no prediction
\\ from VK, since VK speaks only of colourings) -- recorded to show the test distinguishes functionals.
fp(xz) = { my(c = Minv * xz); 2*(c[1] + c[5]); }
for (j = 1, 2, my(I = idealpow(L, P[j], 4), vals = vector(8, t, v2(fp(I[,t])))); print("PLANT f' on P_", j, "^4: min val = ", vecmin(vals)));
\\ unit vector check on f': is f' nonzero mod 4 on the unit vector u = (1+ i s11)/(1 - i s11)?
u = nfeltdiv(L, nfalgtobasis(L, 1 + ri*r11), nfalgtobasis(L, 1 - ri*r11));
print("f(u) = ", f(u), "   f'(u) = ", fp(u));
quit
