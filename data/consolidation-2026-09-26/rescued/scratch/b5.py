import sys; sys.path.insert(0, sys.argv[1]); from items import replace_items
P="/home/kooshi/source/lean-dir/CLAUDE.md"
L=open(P).read().split("\n")
i=[k for k,l in enumerate(L) if l.startswith("  **First count (FS-79, `plans/FS79-invariant-question.md` §R-close.3):**")]
assert len(i)==1; i=i[0]
assert L[i+2].rstrip().endswith("**eleven of eleven**.") and L[i+3].startswith("* **G73")
L[i:i+3]=["""  **The count so far — eleven of eleven** (each derivation close's §IQ record): FS-73 (the instance); FS-79
  (`plans/FS79-invariant-question.md` §R-close.3) — the class-level results (four no-gos of named formats, the rank-1 criterion, row 80)
  through the structural question, by derivation; the instance result (`L21cc6506` loose, row 81) from an exact computation, an extension
  of FS-73's `Θ` tree, aimed at a derived claim by the advisor's question; the *Do*'s last sentence missed once (the new tool not aimed at phase 0's survivors the day it landed; run the next day as P3b); FS-81 (`plans/FS81-quadratic-four-colours.md` §R-close.3) — the class theorem (row 82): classify `Θ₃(F)` for every `F ⊆ ℝ`, the recognition arriving with the question; the census's certificates (row 83) derived from its finite shadow, then certified; stage D (row 84) a calibration; FS-85 (§R-close.4) — rows 85, 86 answer S1 and S2, row 87's no-gos the same questions; the plan-phase advisor's split, target-moving results apart from no-gos, **Kooshi declined: "yes", no-gos count** (2026-09-24); FS-86 (§R-close) — S1 asked of every four-colouring and answered by derivation, the invariant locality at the tight place (rows 88–92); the pinning operator §IQ hoped for neither found nor excluded; FS-89 — §IQ posed Berend's MT/ID property modulo the isometric direction, and row 95 is that property; FS-91 — the class theorem via the peel on the value-set profile, and no mixing at `k = 3` with it; band rigidity at every band by extending a known tool; M2 — its one derivation, the bridge (J17): a ring hom into `ℝ_alg` is Artin–Lang, with a classical answer; the kernel ports outside the count; M3 — both questions through the structural form, Q2's invariant found (the fibre's classes above the mixing threshold), Q1's not (FW rules out every Kempe invariant); row 88 — Q-μ's invariant (spectral type) found and decisive on `T + A + Fin_S`, Q-tr's not; FS-67 — the criterion `χ(E_k(G)) ≤ k` and the obstruction it names, a Hedetniemi pair in `E_k(G)`, through the structural question; the spectral pullback by extending a known tool; the three-colour selection not found."""]
open(P,"w").write("\n".join(L))
NEW={
12:"""12. **What the wall leaves, and where the conjecture points** (G59, row 70): six finite graphs, in reach only at 47 and U₆₄ (FS-57).
   **If it holds, the conjecture's main clause says nothing above five**, and its sharpest remaining prediction is **ℚ(√167)**: at least
   six (five refused at 23 at every level of the tower, row 75) against a proven four (row 79).""",
13:"""13. **Fractional colourings see fields the residue method cannot** (G60, row 71): `[MatolcsiEtAl2025]`'s blow-up never leaves the
   field, whence **χ_f(K²) = 4**; capped by every usable residue plane's `χ_f` (3.5 at 𝔽₇) and by 4.36, it proves at most five.""",
16:"""16. **The construction grammar is crystallography's, and transcendence is free** (G62, G63): every witness is a twisted bilayer whose
   rotation is a Σ = n coincidence rotation (FS-63 is the gate), and χ(F(t)²) = χ(F²) for transcendental t (`[Fischer1990]` Thm 6), so
   χ(ℚ(π)²) = 2.""",
20:"""20. **At three colours the inheritance question is a theorem, and the answer is topological, not arithmetic** (row 79, G71): it answers
   a question posed three times in 2018 (`CLOSED-QUESTIONS.md` §2.4). **It stops at three by a fact about `K₄`** (G71, row 80); at four
   colours a two-sided certificate exists only if four-colourability is decidable, stated open in print (`[CGHO2025bg]` §6.2.1).""",
21:"""21. **Four colours, cell by cell** (row 80, G73): read one cell at a time, `K₄` certifies nothing. **Each no-go is for its format,
   never for a kind of invariant**: averaged, non-local and structure-derived certificates stay open (FS-80) — row 85's is structure-derived (G75).""",
28:"""28. **Colourings of products: mixing pins them, gap-freedom does not** (rows 114–115, G54; FS-67, `plans/FS67-derivation.md`): from four
   colours up a `k`-colouring of `G × H` need not come from gap-free `G`, and it must whenever `H` mixes. Three colours and Hoffman-tight `G`
   are open. Bearing on χ ≥ 6: none.""",
}
replace_items(NEW)
