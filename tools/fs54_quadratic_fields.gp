\\ FS-54 D6 — every real quadratic field Q(sqrt d), squarefree 2 <= d <= DMAX, whose best residue-plane bound L is at
\\ least 6, with the planes that decide it.
\\
\\ A prime p = 3 (mod 4) is usable for Q(sqrt d) exactly when it splits or ramifies (residue degree 1): kronecker(D, p) != -1
\\ for the field discriminant D. The 2-adic wall stands (chi <= 4 by the residue at 2) exactly when some prime above 2
\\ is fixed by conjugation in F(i) with norm <= 4, which for a real quadratic field is d not = 7 (mod 8).
\\ Floors used, each with its source (CLAUDE.md rows 52, 68, 69, 71 and G44/G56; per plane in data/fplane/map.json):
\\   chi(UD(F_q,2)) = 3, 4, 5, 5 at q = 3, 7, 11, 19 (the planes' records); >= 5 at 31 (spectrum); >= 6 at 23, 43, 47
\\   (exact certificates refusing five: data/fs54/cert-q23-l3-N105.json, data/fs53/cert-q43-N365.json,
\\   data/fs53/cert-q47-N371.json); >= 7 at 59, 67, 79, 83 (exact certificates), 71 (exact spectrum), and every q >= 98 (Weil).
\\ So L >= 6 exactly when the wall is broken and no usable plane lies in {3, 7, 11, 19, 31}; then L = 6 iff a usable
\\ plane in {23, 43, 47} is six-chromatic, and L >= 7 when none of 23, 43, 47 is usable.
\\ (Until 2026-09-17 this script also excluded 23, whose floor was 5 before FS-56's certificate.)
\\   gp -q tools/fs54_quadratic_fields.gp
DMAX = 30000;
{
  my(low = [3, 7, 11, 19, 31], deciders = [23, 43, 47], rows6 = List(), rows7 = List());
  for(d = 2, DMAX, if(issquarefree(d) && d % 8 == 7,
    my(D = coredisc(d), usable = select(p -> p % 4 == 3 && kronecker(D, p) != -1, primes([3, 97])));
    if(#setintersect(Set(usable), Set(low)) == 0,
      my(dec = setintersect(Set(usable), Set(deciders)));
      if(#dec, listput(rows6, [d, dec, usable]), listput(rows7, [d, usable])))));
  print("real quadratic fields Q(sqrt d), d <= ", DMAX, ", wall broken, no usable plane in {3,7,11,19,31}:");
  print("  L >= 6, and L = 6 iff a listed decider plane is six-chromatic -- ", #rows6, " fields; the first 12:");
  for(i = 1, min(12, #rows6), print("    d = ", rows6[i][1], "  deciders ", rows6[i][2], "  usable planes < 100 ", rows6[i][3]));
  print("  L >= 7 (no usable plane below 59) -- ", #rows7, " fields; the first 8:");
  for(i = 1, min(8, #rows7), print("    d = ", rows7[i][1], "  usable planes < 100 ", rows7[i][2]));
  my(ds = Set(apply(r -> r[2], Vec(rows6))));
  for(i = 1, #ds, my(sel = select(r -> r[2] == ds[i], Vec(rows6)));
    print("  decided by ", ds[i], ": ", #sel, " (first d = ", sel[1][1], ")"));
}
