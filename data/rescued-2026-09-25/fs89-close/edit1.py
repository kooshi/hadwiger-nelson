import sys
p='/home/kooshi/source/lean-dir/CLAUDE.md'
s=open(p,encoding='utf-8').read()
n0=len(s.encode())
R=[]
def rep(a,b):
    global s
    c=s.count(a)
    if c!=1:
        print("COUNT",c,"for:",a[:90]); sys.exit(1)
    s=s.replace(a,b)
# (a) last updated
rep("""*Last updated: 2026-09-25 — **FS-86 closed** (rows 88–94; G76 minted; G54, G75 corrected): over the triangle-free type-(B) fields four-colour rigidity is one pair, `(0, 4)` (row 88), left **undecided**; the plane over `ℚ₂(√3)` is rigid (row 90), every four-colouring of `K²` is classified (row 89), and every natural construction of a non-periodic colouring is impossible (rows 91–92); verdict **Paid (no-go)**, by ruling (`plans/FS86-dyadic-rigidity.md` §R-close).""",
"""*Last updated: 2026-09-25 — **FS-89 closed** (rows 95–97; G76 rewritten; G74, G30 corrected): every four- and five-colour band character of the rational unit circle's ring, hence of every real field's, is torsion plus archimedean (row 95), which gives HD1 for the type-(B) fields and no character colouring at ℚ(√47) or ℚ(√167) (row 96); one prime is not enough (row 97); verdict **Paid (theorem)**, outcome O1 at a prior of 0.10 (`plans/FS89-rational-band-rigidity.md` §R-close).""")
# (b) target paragraph
rep("(FS-81 priced a refusal there and did not land it, row 84; FS-84)","(FS-81 priced a refusal there and did not land it, row 84; FS-84; no character four-colouring, row 96)")
rep("the widest gap, at discriminant 668.","the widest gap, at discriminant 668 (no character five-colouring, row 96).")
rep("and only FS-64 aims at such a colouring.","and only FS-64's windowed form still aims at one (its one-character case is closed, row 96).")
# (c) item 24
rep("""   (rows 88–94, G76): the plane is rigid iff `(0, 4)` is forced (row 88) — **undecided**; the plane over `ℚ₂(√3)` is rigid (row 90), so the
   question is realising a local forcer without triangles; patchworks, half-space defects, walls, stripes, Kempe swaps, finite-type characters
   and measurable windows are excluded (rows 91–92), and what is left needs a measure-rigidity theorem not in print (FS-89) or HD1-cert's
   certificate (FS-90). ℚ(√2,√3), its member with triangles, is rigid given Heule's T721 (row 93). Toward six only through Soifer 55.1 (row 86).""",
"""   (rows 88–94, 96, G76): the plane is rigid iff `(0, 4)` is forced (row 88) — **undecided**; the plane over `ℚ₂(√3)` is rigid (row 90), so the
   question is realising a local forcer without triangles; patchworks, half-space defects, walls, stripes, Kempe swaps, measurable windows
   and **every character colouring** are excluded (rows 91–92, 96: HD1 holds), so a "no" must be a colouring no character gives.
   ℚ(√2,√3), its member with triangles, is rigid given Heule's T721 (row 93). Toward six only through Soifer 55.1 (row 86).
25. **Two primes restore Furstenberg–Berend rigidity modulo the rotated direction** (rows 95–97, G76): every four- and five-colour band
   character of `ℤ[i][1/p : p ≡ 1 (4)]`, hence of every real field's unit-vector ring, is torsion plus archimedean (`Θ₄` explicitly 13 discs
   and 16 points); at one prime it fails. So no single character four-colours ℚ(√47)'s plane or five-colours ℚ(√167)'s: FS-83's question is
   answered at both exposed fields, and a falsifier of the conjecture there is no character. Novelty pending `[Berend1984]`'s reading.""")
# (e) prior art
rep("the type-(B) frame, the classification of `K²`'s four-colourings, the rigid local plane and the no-go family on type-(B) planes (rows 88–94);",
"the type-(B) frame, the classification of `K²`'s four-colourings, the rigid local plane and the no-go family on type-(B) planes (rows 88–94); rational band rigidity at two or more primes and its field consequences (rows 95–97; pending `[Berend1984]`);")
rep("**Not ours:** the four-colour grid's cohomological triviality","**Not ours:** closed-set rigidity for hyperbolic multi-parameter actions and the isometric direction's minimal circles (`[Furstenberg1967]`, `[Berend1984min]`); the four-colour grid's cohomological triviality")
# (f) open milestones
rep("""**Open milestones, in order.** **None is open.** **FS-86 — four-colour rigidity over ℚ(√59) and ℚ(√83) — CLOSED 2026-09-25** (rows 88–94, G76; `plans/FS86-dyadic-rigidity.md`, its §R-close first; `plans/FS86-derivation.md`; the stub, `plans/STUB-dyadic-rigidity-triangle-free.md`, carries the banner);  **Next, Kooshi's choice (2026-09-25): FS-89, re-posed by the next-step advisor as a closed-set question over ℚ(i)** (`plans/POROS-2026-09-25-fs86-next.md`; the stub), in the finite-witness-free week to 2026-10-01 (§ Toolchain).""",
"""**Open milestones, in order.** **None is open.** **FS-89 — rational band rigidity — CLOSED 2026-09-25** (rows 95–97, G76; `plans/FS89-rational-band-rigidity.md`, its §R-close first; `plans/FS89-derivation.md`; the stub, `plans/STUB-isometric-measure-rigidity.md`, carries the banner). **Next:** Kooshi's choice, with a next-step advisor; the finite-witness-free week runs to 2026-10-01 (§ Toolchain).""")
open(p,'w',encoding='utf-8').write(s)
print(n0, len(s.encode()), len(s.encode())-n0)
