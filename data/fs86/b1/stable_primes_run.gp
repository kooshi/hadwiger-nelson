default(parisize, "200M");
\\ L = Q(sqrt d, i): defining polynomial of the compositum; F's generator s = sqrt d found as a root of x^2 - d in L.
report(Lpol, dlist, lbl, plant=0) = {
  my(L = nfinit(Lpol), G = nfgaloisconj(L), c = 0, sq, ii);
  ii = nfroots(L, x^2+1)[1];
  sq = vector(#dlist, j, nfroots(L, x^2 - dlist[j])[1]);
  foreach(G, g,
    my(ok = 1);
    for(j = 1, #sq, if (nfgaloisapply(L, g, sq[j]) != sq[j], ok = 0));
    if (!plant && ok && nfgaloisapply(L, g, ii) == -ii, c = g);
    if (plant && !ok && nfgaloisapply(L, g, ii) == ii, c = g));
  if (c == 0, error("no conjugation"));
  print(lbl, ": conjugation found");
  my(st = [], ns = []);
  forprime(p = 2, 200,
    my(pr = idealprimedec(L, p), s = vector(#pr, j, idealhnf(L, nfgaloisapply(L, c, pr[j])) == idealhnf(L, pr[j])));
    if (vecsum(s) > 0 && vecsum(s) < #pr, error("mixed stability at p = ", p));
    if (vecsum(s) == #pr, st = concat(st, [[p, #pr, pr[1].e, pr[1].f]]), ns = concat(ns, p)));
  print(lbl, " stable primes <= 200 [p, #primes of L above p, e, f]: ", st);
}
report(polcompositum(y^2-59, y^2+1)[1], [59], "Q(sqrt59)");
report(polcompositum(y^2-83, y^2+1)[1], [83], "Q(sqrt83)");
report(polcompositum(y^2-131, y^2+1)[1], [131], "Q(sqrt131)");
report(polcompositum(polcompositum(y^2-3, y^2-11)[1], y^2+1)[1], [3, 11], "K = Q(sqrt3,sqrt11)");
print("PLANT (wrong automorphism: fixes i, moves sqrt59) -- must differ from the true list:");
report(polcompositum(y^2-59, y^2+1)[1], [59], "PLANT Q(sqrt59)", 1);
quit
