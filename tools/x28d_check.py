#!/usr/bin/env python3
"""X28D exact checks (PARI/GP, seconds): the complex-place scope of chi(F^2) >= min(L(F), 5).

What is checked, and why the prime set is finite (fixed by derivation, not searched):
  the only targets of chromatic number <= 4 are (G59, row 117): a dyadic place ramified in F(i)/F (chi <= 2),
  a dyadic place inert of norm Q <= 32 (U_Q, 4), and an odd stable place of residue field F_3 (Gamma_3, 3) or
  F_7 (Gamma_7, 4).  So "L(F) >= 5" is decided by the places above 2, 3 and 7 alone; 11 is read only to show
  L = 5 exactly (a stable F_11 place, Gamma_11, chi = 5).

Fields (each an explicit construction from the derivation in plans/FS100-X28D-derivation.md, never a search):
  A  = Q(sqrt 23, cbrt 2)               CP-2's counterexample; CP-3's L-counterexample over Q(sqrt 23)
  B  = Q(sqrt 3, 2cos(2pi/7))           CP-3's unconditional chi-counterexample over Q(sqrt 3)

Plants (each must make the corresponding assertion fail):
  --plant-sqrt7   A with sqrt 7 for sqrt 23: an F_3 place appears (3 splits in Q(sqrt 7)), L <= 3
  --plant-sqrt5   A with sqrt 5 for sqrt 23: the dyadic place is no longer split (wall stands)
  --plant-cube3   B with cbrt 2 for 2cos(2pi/7): the F_3 place survives (a pure cube root cannot make 3 inert)
  --plant-real    A with the totally real cubic x^3-3x+1 for cbrt 2: the field is totally real, so the
                  "no totally real subfield with L >= 5" assertion must fail on the field itself
"""
import subprocess
import sys

GP_LIB = r"""
comp(a,b)=my(v=polcompositum(a,b)); if(#v!=1, error("compositum not a field")); polredbest(v[1]);
dyad(pol)={ my(nf,P,e,f,K2,Q);
  if(poldegree(pol)==1, return(["ramified",1,1]));
  nf=nfinit(pol); P=idealprimedec(nf,2);
  if(#P!=1, error("more than one dyadic prime: extend the checker"));
  e=P[1].e; f=P[1].f;
  K2=nfinit(comp(pol,x^2+1)); Q=idealprimedec(K2,2);
  if(#Q==2, return(["split",e,f]));
  if(#Q!=1, error("dyadic count"));
  if(Q[1].e==2*e && Q[1].f==f, return(["ramified",e,f]));
  if(Q[1].f==2*f && Q[1].e==e, return(["inert",e,f]));
  error("dyadic type"); }
odd(pol,p)={ my(nf,P); if(poldegree(pol)==1, return([[1,1,if(p%4==3,"stable","split")]]));
  nf=nfinit(pol); P=idealprimedec(nf,p);
  vector(#P,j, [P[j].e, P[j].f, if(p%4==3 && P[j].f%2==1, "stable", "split")]); }
small(pol)={ my(w=List(), d=dyad(pol), o);
  if(d[1]=="ramified", listput(w, "dyadic ramified (chi<=2)"));
  if(d[1]=="inert" && 2^d[3]<=32, listput(w, Str("dyadic inert Q=",2^d[3]," (4)")));
  foreach([3,7], p, o=odd(pol,p); for(j=1,#o, if(o[j][3]=="stable" && o[j][2]==1,
     listput(w, Str("stable F_",p," place (",if(p==3,3,4),")")))));
  Vec(w); }
report(name,pol)={ my(s=polsturm(pol)); print(name, " pol=", pol, " deg=", poldegree(pol), " real_roots=", s,
  " dyad=", dyad(pol), " at3=", odd(pol,3), " at7=", odd(pol,7), " at11=", odd(pol,11), " small=", small(pol)); }
"""


def gp(script: str) -> str:
    r = subprocess.run(["gp", "-q", "-f", "--default", "parisizemax=2G"], input=GP_LIB + script,
                       capture_output=True, text=True, timeout=300)
    if r.returncode != 0 or "***" in r.stdout or "***" in r.stderr:
        sys.exit(f"GP FAILED\n{r.stdout}\n{r.stderr}")
    return r.stdout


def main() -> int:
    plants = set(a for a in sys.argv[1:] if a.startswith("--plant-"))
    unknown = plants - {"--plant-sqrt7", "--plant-sqrt5", "--plant-cube3", "--plant-real"}
    if unknown:
        sys.exit(f"unknown plant {unknown}")
    quad_A = "x^2-7" if "--plant-sqrt7" in plants else "x^2-5" if "--plant-sqrt5" in plants else "x^2-23"
    cub_A = "x^3-3*x+1" if "--plant-real" in plants else "x^3-2"
    cub_B = "x^3-2" if "--plant-cube3" in plants else "x^3+x^2-2*x-1"
    out = gp(f"""
A=comp({quad_A},{cub_A}); B=comp(x^2-3,{cub_B});
report("A", A); report("A.base", {quad_A}); report("B", B); report("B.base", x^2-3);
S=nfsubfields(A);
for(j=1,#S, my(g=polredbest(S[j][1])); print("A.sub deg=", poldegree(g), " totally_real=", polsturm(g)==poldegree(g), " small=", small(g), " pol=", g));
print("B.sub3=", odd(B,3), " B.dyad=", dyad(B));
""")
    print(out, end="")
    lines = out.splitlines()
    fails = []

    def line(prefix):
        hits = [l for l in lines if l.startswith(prefix + " ")]
        if len(hits) != 1:
            sys.exit(f"parse: {prefix}: {len(hits)} lines")
        return hits[0]

    a = line("A")
    # A: degree 6, not totally real (2 real roots), L >= 5 (no small target), L = 5 (a stable F_11 place)
    if "deg=6" not in a:
        fails.append("A: degree is not 6")
    if "real_roots=6" in a:
        fails.append("A: totally real (CP-2 needs a non-real embedding)")
    if "small=[]" not in a:
        fails.append("A: has a target of chi <= 4, so L(A) <= 4")
    if 'dyad=["split"' not in a:
        fails.append("A: dyadic place not split in A(i)")
    if "[1, 1, \"stable\"]" not in a.split("at11=")[1].split(" small=")[0]:
        fails.append("A: no stable F_11 place (L(A) = 5 not witnessed)")
    # A's totally real subfields all have L <= 4
    subs = [l for l in lines if l.startswith("A.sub ")]
    if not subs:
        fails.append("A: no subfields listed")
    for l in subs:
        if "totally_real=1" in l and "small=[]" in l:
            fails.append(f"A: a totally real subfield has L >= 5: {l}")
    # base of A (Q(sqrt 23)) has L <= 4 (CP-3's L-counterexample: L rises 4 -> 5 in a cubic step)
    if "small=[]" in line("A.base"):
        fails.append("A.base: L >= 5 already")
    # B: totally real, contains sqrt 3 by construction, no residue-F_3 place at all; base Q(sqrt 3) has one
    b = line("B")
    if "real_roots=6" not in b:
        fails.append("B: not totally real")
    b3 = [l for l in lines if l.startswith("B.sub3=")][0].split("B.sub3=")[1].split(" B.dyad=")[0]
    if ", 1, " in b3:
        fails.append(f"B: a prime above 3 has residue degree 1 (residue F_3): {b3}")
    if "stable F_3" not in line("B.base"):
        fails.append("B.base: Q(sqrt 3) has no stable F_3 place")
    if fails:
        print("FAIL:\n  " + "\n  ".join(fails))
        return 1
    print("ALL ASSERTIONS HOLD")
    return 0


if __name__ == "__main__":
    sys.exit(main())
