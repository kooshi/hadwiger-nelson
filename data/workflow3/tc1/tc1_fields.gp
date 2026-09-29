\\ TC1 (2026-09-28): the places above 2 of a few real number fields and their behaviour in F(i), and whether any odd
\\ place has a small usable residue field (size <= 47, q = 3 mod 4).  Exact: PARI's maximal order, made maximal at every
\\ prime below 100 (every prime decomposed here).  Split: -1 a square in the completion (nfislocalpower).  Ramified or
\\ inert, when not split: whether the place divides the relative discriminant of x^2 + 1 over F (rnfdisc), so F(i) is
\\ never built.  Run from the repository root:  gp -q data/workflow3/tc1/tc1_fields.gp
\\ TC1_QUIET=1 prints only the last line.  The last line is "CHECK: PASS" only if every expected pattern below holds;
\\ gp exits 0 even after an error, so the line, never the exit status, is the verdict.
\\ Controls with known answers (G1, G43, row 52): K keeps the wall (its two dyadic places inert in K(i), norm 2);
\\ K(sqrt5) and K(sqrt7) break it; K(sqrt35) keeps it.
\\ Planted fault (TC1_FAULT=1): the split test asks whether 3, not -1, is a local square; K's places then read as
\\ split, and the last line is "CHECK: FAIL".

default(parisizemax, 1000000000);
quiet = (getenv("TC1_QUIET") == "1");
fault = (getenv("TC1_FAULT") == "1");
say(s) = if(!quiet, print(s));
cp(a, b) = polredbest(polcompositum(a, b)[1]);
mk(p) = nfinit([subst(p, x, 'y), 100]);

typ(nf, pr, D) =
{
  if(nfislocalpower(nf, pr, if(fault, 3, -1), 2), return("split"));
  if(idealval(nf, D, pr) > 0, "ramified", "inert");
}

\\ returns [the types of the dyadic places, their residue degrees, the number of small usable odd residue fields]
show(name, p) =
{
  my(nf = mk(p), D = rnfdisc(nf, x^2 + 1)[1], P2 = idealprimedec(nf, 2), ts = vector(#P2), fs = vector(#P2), nsmall = 0);
  say(Str(name, "  degree ", poldegree(p)));
  for(k = 1, #P2, ts[k] = typ(nf, P2[k], D); fs[k] = P2[k].f;
    say(Str("   place above 2: e=", P2[k].e, " f=", fs[k], "  in F(i): ", ts[k],
            if(ts[k] == "inert", Str("  target U_Q, Q=", 2^fs[k], "; the prime of F(i) has norm ", 4^fs[k]),
               if(ts[k] == "ramified", Str("  two colours; the prime of F(i) has norm ", 2^fs[k]), "")))));
  say(Str("   wall: ", if(#select(t -> t != "split", ts), "STANDS", "BROKEN")));
  foreach([3,5,7,11,13,17,19,23,29,31,43,47], q,
    my(us = select(f -> (q^f % 4 == 3) && q^f <= 47, apply(Q -> Q.f, idealprimedec(nf, q))));
    nsmall += #us;
    if(#us, say(Str("   usable residue field(s) of size <= 47 above ", q, ": ", apply(f -> q^f, us)))));
  [ts, fs, nsmall];
}

K  = polcompositum(x^2 - 3, x^2 - 11)[1];
E3 = polsubcyclo(7, 3);          \\ Q(zeta_7)^+, 2 inert of degree 3
E7 = polsubcyclo(29, 7);         \\ the septic subfield of Q(zeta_29), 2 inert of degree 7

say("== controls");
cK   = show("K = Q(sqrt3, sqrt11)", K);
cK5  = show("K(sqrt5)", cp(K, x^2 - 5));
cK7  = show("K(sqrt7)", cp(K, x^2 - 7));
cK35 = show("K(sqrt35)", cp(K, x^2 - 35));
say("== the fields of the verdicts");
v1 = show("E3 = Q(zeta_7)^+", E3);
v2 = show("Q(sqrt3)*E3", cp(x^2 - 3, E3));
v3 = show("Q(sqrt3)*E7", cp(x^2 - 3, E7));
v4 = show("K*E7", cp(K, E7));
isK = #nfsubfields(mk(cp(K, E7)), 4) && (#select(s -> nfisisom(s[1], subst(K, x, 'y)), nfsubfields(mk(cp(K, E7)), 4)) > 0);
say(Str("== K*E7 contains K: ", isK));
ok = 0;
{
  ok = [Set(cK[1]) == Set(["inert"]) && Set(cK[2]) == Set([1]),
        Set(cK5[1]) == Set(["split"]), Set(cK7[1]) == Set(["split"]),
        Set(cK35[1]) == Set(["inert"]) && Set(cK35[2]) == Set([1]),
        v1[1] == ["ramified"] && v1[2] == [3],
        v2[1] == ["inert"] && v2[2] == [3],
        v3[1] == ["inert"] && v3[2] == [7] && v3[3] == 0,
        v4[1] == ["inert", "inert"] && v4[2] == [7, 7] && v4[3] == 0 && isK];
}
print("CHECK: ", if(type(ok) == "t_VEC" && #ok == 8 && vecmin(ok) == 1, "PASS", Str("FAIL ", ok)));
quit;
