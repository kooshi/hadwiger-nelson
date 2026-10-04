\\ FS129-SA1-SQRT3-LOCAL's control (plans/FS129-SA1-audit.md, stage 5): exact, over a fixed list of fields; it searches for nothing.
\\ For each field F and each place w of F above 2: sq3 = (3 is a square in F_w), read as "w splits in F(sqrt 3)/F".
\\ Claim: if sq3, then w is unramified in F(i)/F, and splits there iff f(w|2) is even (otherwise inert, relative degree 2).
\\ Prints: places checked, places with sq3, of those the places in fields WITHOUT sqrt 3 (the weakening's reach), and violations.
\\ Fault (environment FAULT=1): the hypothesis sq3 is dropped, so every dyadic place is tested.
FAULT = if(getenv("FAULT"), 1, 0);
CONV = if(getenv("CONV"), 1, 0); \\ CONV=1: count only the converse direction (a split place with f odd, or an unramified inert place with f even)
{L = List();
forstep(d=2,300,1, if(issquarefree(d), listput(L, y^2-d)));
listput(L, polcompositum(y^2-3,y^2-11)[1]);
listput(L, polcompositum(polcompositum(y^2-3,y^2-11)[1], y^2-5)[1]);
listput(L, polcompositum(polcompositum(y^2-3,y^2-11)[1], y^2-7)[1]);
listput(L, polcompositum(y^2-3,y^2-5)[1]);
listput(L, polcompositum(y^2-2,y^2-3)[1]);
listput(L, y^3+y^2-2*y-1);
listput(L, polcompositum(y^2-3, y^3+y^2-2*y-1)[1]);
listput(L, polcompositum(y^2-51, y^3+y^2-2*y-1)[1]);
listput(L, polcompositum(y^2-51, y^2-5)[1]);
listput(L, y^3-3*y-1);
listput(L, polcompositum(y^2-219, y^3-3*y-1)[1]);}
{
nplaces = 0; nsq = 0; nreach = 0; bad = 0;
for(j=1,#L, nf = nfinit(L[j]); has3 = #nfroots(nf, x^2-3) > 0;
  if(!has3, r3 = rnfinit(nf, x^2-3)); ri = rnfinit(nf, x^2+1);
  P = idealprimedec(nf, 2);
  for(k=1,#P, w = P[k]; nplaces++;
    sq3 = if(has3, 1, #rnfidealprimedec(r3, w) == 2);
    if(sq3, nsq++; if(!has3, nreach++));
    if(sq3 || FAULT,
      D = rnfidealprimedec(ri, w);
      unram = (vecmax(vector(#D, t, D[t].e / w.e)) == 1);
      split = (#D == 2);
      if(CONV, if(unram && ((split && w.f % 2 == 1) || (!split && w.f % 2 == 0)), bad++), if(!unram || split != (w.f % 2 == 0), bad++)))));

print("places checked ", nplaces, "; 3 a square at ", nsq, "; of those in fields without sqrt 3: ", nreach);
print("violations=", bad);
}
