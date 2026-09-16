#!/usr/bin/env python3
"""FS-54 §M — write Aut(UD(F_27,2)) as a GAP permutation group on the 729 points (1-indexed, repository numbering),
and a GAP program that lists the conjugacy classes of its subgroups of PRIME order (2, 3, 7) with each class's
orbits on points.  Output: data/fs54/symmetric/prime-order-classes.json (written by GAP, re-read by the solver).
Generators: translations by the six unit coordinate vectors, rotation by every unit vector, the reflection
(x, y) -> (x, -y), and the Frobenius (x, y) -> (x^3, y^3).  GAP checks |G| = 122472 (nauty's value) before anything else.
Run: python3 tools/fs54_aut_gap.py && gap -q -b data/fs54/symmetric/aut.g < /dev/null"""
import io, contextlib, itertools, os, sys
sys.path.insert(0, os.path.dirname(__file__))
with contextlib.redirect_stdout(io.StringIO()):
    from fs54_periodic_alpha import GENS, POINTS, _index, N
OUT = "data/fs54/symmetric"
trans = []
for i in range(N):
    e = [0] * N; e[i] = 1
    trans.append([_index(tuple((a + b) % 3 for a, b in zip(v, e))) for v in POINTS])
perms = trans + GENS
lines = ["gens := ["]
lines.append(",\n".join("PermList([" + ",".join(str(x + 1) for x in p) + "])" for p in perms))
lines.append("];")
lines.append(r'''
G := Group(gens);
if Size(G) <> 122472 then Print("SIZE MISMATCH ", Size(G), "\n"); QUIT_GAP(1); fi;
out := OutputTextFile("data/fs54/symmetric/prime-order-classes.json", false);
SetPrintFormattingStatus(out, false);
PrintTo(out, "[");
first := true;
for p in [2, 3, 7] do
  cls := Filtered(ConjugacyClasses(G), c -> Order(Representative(c)) = p);
  done := [];
  for c in cls do
    x := Representative(c);
    if ForAny(done, d -> ForAny([1..p-1], k -> x^k in d)) then continue; fi;
    Add(done, c);
    H := Group(x);
    orbs := Orbits(H, [1..729]);
    nsub := Size(c) / (p - 1);
    fixed := Number(orbs, o -> Length(o) = 1);
    if not first then AppendTo(out, ",\n"); fi;
    first := false;
    AppendTo(out, "{\"order\": ", p, ", \"class_size_elements\": ", Size(c), ", \"fixed_points\": ", fixed,
                  ", \"orbits\": ", List(orbs, o -> List(o, i -> i - 1)), "}");
  od;
od;
AppendTo(out, "]\n");
CloseStream(out);
Print("ok\n");
QUIT_GAP(0);
''')
open(f"{OUT}/aut.g", "w").write("\n".join(lines))
print("wrote", f"{OUT}/aut.g")
