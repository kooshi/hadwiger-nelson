\\ J22 (crunch 2026-09-25): an independent PARI/GP check of tools/crunch_j22_spectrum_exact.py's decision.
\\ Gamma = Cay(F_p^2, T), T = {x^2 + y^2 = 1}.  For every character xi = (a,b) != 0 the eigenvalue is the polmod
\\ sum_{t in T} z^{(a t1 + b t2) mod p}  in  Q[z]/(polcyclo(p)).  Checks: (S) the eigenvalue depends only on a^2+b^2
\\ (for the isotropic classes when p = 1 mod 4: on the line); then, for each distinct value, minpoly() (PARI's exact
\\ minimal polynomial over Q) and polsturm() (PARI's exact real-root count) on [B, +oo] and [-oo, -B], B = |T|/4.
\\ Usage:  gp -q -f tools/crunch_j22_spectrum_check.gp  with  P = <prime>; PLANT = 0 or 1  set by  -D  or the driver below.
\\ PLANT = 1 drops one point of T: check (S) must fail and the script must print CHECK (S) FAILED.

j22check(p, plant) =
{
  my(T = List(), Phi = polcyclo(p, 'z), lam = Map(), bynorm = Map(), vals = List(), B, nhi = 0, nlo = 0,
     lmin = +oo, lmax = -oo, P, r, c, v, key, first = 1);
  for (x = 0, p-1, for (y = 0, p-1, if ((x^2 + y^2) % p == 1, listput(T, [x, y]))));
  if (plant, listpop(T, 1));
  B = #T / 4;
  for (a = 0, p-1, for (b = 0, p-1,
    if (a == 0 && b == 0, next);
    v = Mod(sum(k = 1, #T, 'z^((a*T[k][1] + b*T[k][2]) % p)), Phi);
    c = (a^2 + b^2) % p;
    key = if (c == 0, [0, if (a == 0, 0, (b * lift(Mod(a, p)^-1)) % p)], [c, -1]);
    if (mapisdefined(bynorm, key),
      if (mapget(bynorm, key) != v, print("CHECK (S) FAILED: eigenvalue not a function of the norm class at ", [a,b]); return(2)),
      mapput(bynorm, key, v); listput(vals, v))));
  print("p=", p, " |T|=", #T, " B=", B, "  check (S): PASS; distinct eigenvalue classes: ", #vals);
  for (i = 1, #vals,
    P = minpoly(vals[i]);
    nhi += polsturm(P, [B, +oo]);
    nlo += polsturm(P, [-oo, -B]);
    r = polrootsreal(P);
    lmin = min(lmin, vecmin(r)); lmax = max(lmax, vecmax(r)));
  print("  lambda_min ~ ", lmin, "   lambda_max ~ ", lmax, "   lambda* ~ ", max(-lmin, lmax) / #T);
  print("  polsturm: distinct-root counts summed over classes: <= -B: ", nlo, ";  >= +B: ", nhi);
  print("  DECISION p=", p, ": ", if (nlo == 0 && nhi == 0, "lambda* < 1/4 (5-thick at level one)", "lambda* >= 1/4 (NOT 5-thick at level one)"));
  return(0);
}

\\ The standard compact piece at a place split in F(i)/F with residue field F_q, q = p^f (hyperbola coordinates:
\\ T = {(e, 1/e) : e in F_q^*}): level-one eigenvalues K(a,b) = sum_e zeta_p^{Tr(a e + b / e)}.  Exact: minpoly and
\\ polsturm at B = (q-1)/4.  (Higher levels: <= 2/(q-1) in normalised absolute value, a hand bound, not computed.)
j22split(p, f) =
{
  my(q = p^f, g = ffgen(q, 'w), Phi = polcyclo(p, 'z), els = List(), vals = Map(), lst = List(), B = (q-1)/4,
     nhi = 0, nlo = 0, lmin = +oo, lmax = -oo, v, P, r, e);
  e = ffprimroot(g);
  for (i = 0, q-2, listput(els, e^i));
  foreach([0, 1] , sa, 0);
  \\ characters (a, b) with a, b ranging over {0} u F_q^*; eigenvalue depends on (a == 0, b == 0, ab) -- all enumerated
  for (i = -1, q-2, for (j = -1, q-2,
    if (i == -1 && j == -1, next);
    my(a = if (i < 0, 0*e, els[i+1]), b = if (j < 0, 0*e, els[j+1]));
    v = Mod(sum(k = 1, #els, 'z^(lift(Mod(trace(a*els[k] + b/els[k]), p)) % p)), Phi);
    if (!mapisdefined(vals, v), mapput(vals, v, 1); listput(lst, v))));
  for (i = 1, #lst,
    P = minpoly(lst[i]);
    nhi += polsturm(P, [B, +oo]); nlo += polsturm(P, [-oo, -B]);
    r = polrootsreal(P); lmin = min(lmin, vecmin(r)); lmax = max(lmax, vecmax(r)));
  print("q=", q, " |T|=", q-1, " B=", B, "  distinct values: ", #lst, "  lambda_min ~ ", lmin, "  lambda_max ~ ", lmax,
        "  lambda*(level one) ~ ", max(-lmin, lmax)/(q-1));
  print("  polsturm <= -B: ", nlo, ";  >= +B: ", nhi, "   DECISION q=", q, ": ",
        if (nlo == 0 && nhi == 0, "level-one lambda* < 1/4", "level-one lambda* >= 1/4 (standard piece NOT 5-thick)"));
  return(0);
}
