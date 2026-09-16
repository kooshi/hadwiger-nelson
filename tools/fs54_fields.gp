\\ FS-54 D6 — which real number field would a colouring of a window plane buy?
\\
\\ A real number field F has a USABLE residue plane at q = p^f when some prime of F above p has residue degree f
\\ with p = 3 (mod 4) and f odd (equivalently residue field F_q with q = 3 (mod 4)); then chi(F^2) <= chi(UD(F_q,2))
\\ (row 52 of CLAUDE.md's ledger). A conjugation-fixed prime of F(i) above 2 of norm N gives chi(F^2) <= N, which
\\ matters only when N <= 4 (the 2-adic wall). A field "sees q first" when q is its smallest usable residue plane.
\\
\\ This script enumerates EVERY field of degree <= 4 with |disc| <= DMAX by Galois group (PARI's nflist, complete by
\\ construction), keeps the real ones (at least one real embedding) whose first usable plane is a window member
\\ {23, 27, 31, 43, 47} and which have no conjugation-fixed prime above 2 of norm <= 4, and prints the smallest-
\\ discriminant such field per (member, degree). A field of ODD degree always has a ramified prime above 2 (some prime has odd
\\ local degree, so i is not in the completion and F_p(i)/F_p is ramified), so it is 2-colourable and never appears; for 27
\\ the least degree is therefore 6, and a second pass below searches composita of a cubic field with a quadratic field.
\\
\\   gp -q tools/fs54_fields.gp          (PARI/GP 2.17.4; about a minute)
\\
\\ For 27: a quadratic field has residue degrees <= 2; a quartic with a degree-3 prime above 3 also has a degree-1 prime above 3
\\ (whose plane over F_3 is 3-colourable); an odd-degree field is 2-colourable. So a field seeing 27 first has even degree >= 6.

DMAX = 20000;
WINDOW = [23, 27, 31, 43, 47];

firstq(K) = { my(best = 10^9);
  forprime(p = 3, 97, if(p % 4 == 3, my(dec = idealprimedec(K, p));
    for(j = 1, #dec, my(f = dec[j].f); if(f % 2 == 1 && p^f < best, best = p^f)))); best };

usableq(K) = { my(out = List());
  forprime(p = 3, 97, if(p % 4 == 3, my(dec = idealprimedec(K, p));
    for(j = 1, #dec, my(f = dec[j].f); if(f % 2 == 1 && p^f < 100, listput(out, p^f))))); vecsort(Vec(out), , 8) };

\\ The primes above 2, classified in F(i)/F (FS-54 correction — the first version kept only "norm <= 4", which is wrong):
\\   split    -> no bound from this prime;
\\   ramified -> conjugation acts trivially on the residue field, so every unit vector is = 1 there and a linear map to F_2
\\               sending 1 to 1 is a proper 2-colouring: chi(F^2) <= 2, whatever the norm (every odd-degree field has one);
\\   inert    -> the residue graph is Cay(F_{Q^2}, mu_{Q+1}), Q = N(p): chromatic number 4 at Q = 2 and Q = 4, recorded
\\               as a bound to look up for Q >= 8.
\\ Returns [kind, Q] with kind 0 = every prime above 2 splits, 2 = some ramified, 4 = some inert with Q <= 4, 8 = inert Q >= 8 only.
cls2(pol) = { my(K = nfinit(subst(pol, x, y)), rnf = rnfinit(K, x^2 + 1), dec = idealprimedec(K, 2), kind = 0, Qmin = 0);
  for(j = 1, #dec, my(up = rnfidealprimedec(rnf, dec[j]));
    if(#up == 1,
      if(up[1].e == 2 * dec[j].e, kind = 2,
        my(Q = 2^dec[j].f); if(Q <= 4, if(kind != 2, kind = 4), if(kind == 0, kind = 8; Qmin = Q)))));
  [kind, Qmin] };

{
  my(best = Map(), counts = List());
  foreach(["C2","C3","S3","V4","C4","D4","A4","S4"], G,
    my(L = nflist(G, [1, DMAX]), hits = 0);
    for(i = 1, #L, my(pol = L[i], K = nfinit(pol));
      if(K.sign[1] >= 1, my(q = firstq(K));
        if(setsearch(WINDOW, q), my(w = cls2(pol));
          if(w[1] == 0 || w[1] == 8, hits++;
            my(key = [q, poldegree(pol)], rec = [abs(K.disc), G, pol, usableq(K), w]);
            if(!mapisdefined(best, key) || mapget(best, key)[1] > rec[1], mapput(best, key, rec))))));
    listput(counts, [G, #L, hits]));
  print("fields enumerated, |disc| <= ", DMAX, " — [group, count, hits]: ", Vec(counts));
  print("smallest field per (first usable plane, degree): [|disc|, group, polynomial, usable planes < 100, [2-adic kind, Q]] (kind 0: every prime above 2 splits in F(i); 8: inert with Q >= 8)");
  my(M = vecsort(Vec(Mat(best)~), 1));
  for(i = 1, #M, print("  ", M[i][1], "  ", M[i][2]));
  print("control: the stub's candidate Q(sqrt3, rho), rho^3 = rho + 1 — usable planes ", usableq(nfinit(polredbest(polcompositum(x^3 - x - 1, x^2 - 3)[1]))));
}
{
  my(cubics = concat(nflist("C3", [1, 4000]), nflist("S3", [1, 4000])), best = List());
  foreach(cubics, c, my(Kc = nfinit(c));
    if(#select(pr -> pr.f == 3, idealprimedec(Kc, 3)) == 1,
      forstep(d = 7, 400, 8, if(issquarefree(d),
        my(pol = polredbest(polcompositum(c, x^2 - d)[1]), K = nfinit(pol));
        if(K.sign[1] >= 1 && firstq(K) == 27, my(w = cls2(pol));
          if(w[1] == 0 || w[1] == 8, listput(best, [abs(K.disc), c, d, usableq(K), w])))))));
  best = vecsort(Vec(best), 1);
  print("fields seeing 27 first among composita (cubic, |disc| <= 4000, 3 inert) x Q(sqrt d) (d = 7 mod 8, d <= 400), smallest 6:");
  for(i = 1, min(6, #best), print("  |disc| ", best[i][1], "  cubic ", best[i][2], "  d = ", best[i][3], "  usable < 100 ", best[i][4], "  2-adic ", best[i][5]));
}
