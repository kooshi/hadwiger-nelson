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
\\ discriminant such field per (member, degree).
\\
\\   gp -q tools/fs54_fields.gp          (PARI/GP 2.17.4; about a minute)
\\
\\ Why degree <= 4 is enough to name the smallest field for 27: a quadratic field has residue degrees <= 2, and a
\\ quartic field with a degree-3 prime above 3 also has a degree-1 prime above 3 (3 + 1 = 4), whose plane over F_3 is
\\ 3-colourable; so degree 3 is the least degree that can see 27 first, and every field of degree >= 5 has
\\ |disc| >= 1609 (the minimal quintic discriminant), far above the cubic found.

DMAX = 20000;
WINDOW = [23, 27, 31, 43, 47];

firstq(K) = { my(best = 10^9);
  forprime(p = 3, 97, if(p % 4 == 3, my(dec = idealprimedec(K, p));
    for(j = 1, #dec, my(f = dec[j].f); if(f % 2 == 1 && p^f < best, best = p^f)))); best };

usableq(K) = { my(out = List());
  forprime(p = 3, 97, if(p % 4 == 3, my(dec = idealprimedec(K, p));
    for(j = 1, #dec, my(f = dec[j].f); if(f % 2 == 1 && p^f < 100, listput(out, p^f))))); vecsort(Vec(out), , 8) };

\\ smallest norm of a conjugation-fixed prime of F(i) above 2; 0 if every prime above 2 splits in F(i)
fixed2(pol) = { my(K = nfinit(subst(pol, x, y)), rnf = rnfinit(K, x^2 + 1), dec = idealprimedec(K, 2), m = 0);
  for(j = 1, #dec, my(up = rnfidealprimedec(rnf, dec[j]));
    if(#up == 1, my(nm = 2^(up[1].f)); if(m == 0 || nm < m, m = nm))); m };

{
  my(best = Map(), counts = List());
  foreach(["C2","C3","S3","V4","C4","D4","A4","S4"], G,
    my(L = nflist(G, [1, DMAX]), hits = 0);
    for(i = 1, #L, my(pol = L[i], K = nfinit(pol));
      if(K.sign[1] >= 1, my(q = firstq(K));
        if(setsearch(WINDOW, q), my(w = fixed2(pol));
          if(w == 0 || w > 4, hits++;
            my(key = [q, poldegree(pol)], rec = [abs(K.disc), G, pol, usableq(K), w]);
            if(!mapisdefined(best, key) || mapget(best, key)[1] > rec[1], mapput(best, key, rec))))));
    listput(counts, [G, #L, hits]));
  print("fields enumerated, |disc| <= ", DMAX, " — [group, count, hits]: ", Vec(counts));
  print("smallest field per (first usable plane, degree): [|disc|, group, polynomial, usable planes < 100, min fixed norm above 2 (0 = none)]");
  my(M = vecsort(Vec(Mat(best)~), 1));
  for(i = 1, #M, print("  ", M[i][1], "  ", M[i][2]));
  print("control: the stub's candidate Q(sqrt3, rho), rho^3 = rho + 1 — usable planes ", usableq(nfinit(polredbest(polcompositum(x^3 - x - 1, x^2 - 3)[1]))));
}
