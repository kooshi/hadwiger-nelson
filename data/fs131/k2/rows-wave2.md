### 16. FS111-C-FILL
<!--row FS111-C-FILL plans/FS111-derivation.md:252-->
**Address** `plans/FS111-derivation.md:252` · **Role** SEED · **Era** R · **Was** 12 in `lean-order.md` · **Upstream ids** none
<!--needs FS111-C-FILL: -->

<!--q FS111-C-FILL statement-->
**Statement as filed:**
> if x is j-free with |S̃_j ∩ A_η(x)| = 0, the fill move on B(x, η/2) with colour j keeps the colouring a.e.-proper with k colours

<!--q FS111-C-FILL not_claimed-->
**Not claimed:**
> that fills saturate (fills create no contact for the filled colour, FS111-W-FILL-FREE)

<!--q FS111-C-FILL grade-->
**Grade as filed:**
> hand

<!--q FS111-C-FILL minds-->
**Minds as filed:**
> 2 — blind to: FS111-P's stage 5 until V0's verdicts were committed; method: the same measure estimate (a third reading, FS111-M § 1.4, sighted of V0)

<!--q FS111-C-FILL handoff-->
**Handoff as filed:**
> de Bruijn — queued behind the measurable chain: a short measure estimate once D-NF is in Lean


### 18. FS111-M-R7
<!--row FS111-M-R7 plans/FS111-derivation.md:347-->
**Address** `plans/FS111-derivation.md:347` · **Role** SEED · **Era** R · **Was** 14 in `lean-order.md` · **Upstream ids** none
<!--needs FS111-M-R7: -->

<!--q FS111-M-R7 statement-->
**Statement as filed:**
> R7 — Reuleaux triangles of width 1 on the up triangles of the unit triangular lattice Λ, coloured by the four cosets of 2Λ, and the cusped down triangles coloured by the three cosets of M = ⟨(0, √3), (3/2, √3/2)⟩ — is a.e.-proper, tight and saturated (every essential boundary point is a contact point for each of its colours); every boundary is a unit arc centred at a lattice point that carries both its side colours

<!--q FS111-M-R7 not_claimed-->
**Not claimed:**
> saturation with partners of positive density (FALSE at the down arcs, FS111-VMW-R7-PPLUS); any six-colour analogue

<!--q FS111-M-R7 grade-->
**Grade as filed:**
> computed over: one fundamental domain of Λ, 7 classes, exact in ℚ(√3), with the hand reduction of the plane to it

<!--q FS111-M-R7 minds-->
**Minds as filed:**
> 2 — blind to: FS111-M's record until VMW's verdicts were committed (3ea1d5ab); method: M by two distance engines agreeing (its own and the frozen FS112-Y engine), VMW by hand proofs and its own exact certificates

<!--q FS111-M-R7 handoff-->
**Handoff as filed:**
> de Bruijn — a periodic tiling in ℚ(√3) with an exact certificate; kernel-checkable now, not urgent (a control object)


### 19. FS111-M-SATC
<!--row FS111-M-SATC plans/FS111-derivation.md:316-->
**Address** `plans/FS111-derivation.md:316` · **Role** SEED · **Era** R · **Was** 15 in `lean-order.md` · **Upstream ids** FS111-C-FILL
<!--needs FS111-M-SATC: FS111-C-FILL-->

<!--q FS111-M-SATC statement-->
**Statement as filed:**
> every a.e.-proper k-colouring lies below a maximal admissible cover (k measurable sets with null unit pairs, maximal under inclusion up to null sets, union of full measure), and every maximal cover's supports satisfy ℝ² = int F_j ∪ (F_j + S¹) for each j; a selection from a maximal cover is an a.e.-proper k-colouring

<!--q FS111-M-SATC not_claimed-->
**Not claimed:**
> that a selection is saturated (FS111-M2-NOSEL); that the classes are regular (FS111-M3-IRREG)

<!--q FS111-M-SATC grade-->
**Grade as filed:**
> hand

<!--q FS111-M-SATC minds-->
**Minds as filed:**
> 1 — FS111-M (FS111-M2-COV re-reads it, sighted)

<!--q FS111-M-SATC handoff-->
**Handoff as filed:**
> de Bruijn — queued behind the measurable chain: Zorn on admissible covers is short once a.e.-properness is in Lean


### 20. FS111-M2-COV
<!--row FS111-M2-COV plans/FS111-derivation.md:822-->
**Address** `plans/FS111-derivation.md:822` · **Role** SEED · **Era** R · **Was** 16 in `lean-order.md` · **Upstream ids** FS111-M-SATC
<!--needs FS111-M2-COV: FS111-M-SATC-->

<!--q FS111-M2-COV statement-->
**Statement as filed:**
> a k-tuple of measurable sets is a maximal admissible cover iff each coordinate is a MUA set and their union has full measure

<!--q FS111-M2-COV not_claimed-->
**Not claimed:**
> that a maximal cover's classes are regular (FS111-M3-IRREG) or disjoint (DISC7 has lenses)

<!--q FS111-M2-COV grade-->
**Grade as filed:**
> hand

<!--q FS111-M2-COV minds-->
**Minds as filed:**
> 1 — FS111-M2

<!--q FS111-M2-COV handoff-->
**Handoff as filed:**
> de Bruijn — queued behind the measurable chain, with FS111-M-SATC


### 29. FS111-M2-FIX
<!--row FS111-M2-FIX plans/FS111-derivation.md:870-->
**Address** `plans/FS111-derivation.md:870` · **Role** SEED · **Era** R · **Was** 32 in `lean-order.md` · **Upstream ids** FS111-C-HULL, FS111-M2-INT, FS111-M2-ZERO
<!--needs FS111-M2-FIX: FS111-C-HULL,FS111-M2-INT,FS111-M2-ZERO-->

<!--q FS111-M2-FIX statement-->
**Statement as filed:**
> a regular MUA set A satisfies the shadow identity int F = ℝ² ∖ (F + S¹), F = supp A: every unit circle centred in F misses int F, and every component of int F lies inside or outside each such circle

<!--q FS111-M2-FIX not_claimed-->
**Not claimed:**
> the converse (a regular set satisfying the identity need not be maximal: FS111-M3-FIXCONV)

<!--q FS111-M2-FIX grade-->
**Grade as filed:**
> derived from: FS111-M2-INT, FS111-M2-ZERO

<!--q FS111-M2-FIX minds-->
**Minds as filed:**
> 2 — blind to: M2's record until VM2's verdicts were committed; method: VM2 from VM2-INT and maximality (VM2 § 2.2)

<!--q FS111-M2-FIX handoff-->
**Handoff as filed:**
> de Bruijn — queued behind the measurable chain: the identity route M's cover form rests on


### 31. FS111-V0-RESCALE
<!--row FS111-V0-RESCALE plans/FS111-derivation.md:175-->
**Address** `plans/FS111-derivation.md:175` · **Role** SEED · **Era** R · **Was** 38 in `lean-order.md` · **Upstream ids** none
<!--needs FS111-V0-RESCALE: -->

<!--q FS111-V0-RESCALE statement-->
**Statement as filed:**
> if an a.e.-proper measurable k-colouring of ℝ² exists, a tight one exists (rescale by 1 ± ε*, ε* the supremum of the slacks); so a tight a.e.-proper k-colouring exists iff χ_m⁰(ℝ²) ≤ k

<!--q FS111-V0-RESCALE not_claimed-->
**Not claimed:**
> that every a.e.-proper colouring is tight

<!--q FS111-V0-RESCALE grade-->
**Grade as filed:**
> hand

<!--q FS111-V0-RESCALE minds-->
**Minds as filed:**
> 1 — FS111-V0

<!--q FS111-V0-RESCALE handoff-->
**Handoff as filed:**
> de Bruijn — queued behind the measurable chain (FS-113): a short lemma with D-SLACK and a.e.-properness defined


### 37. FS111-W-SQ9
<!--row FS111-W-SQ9 plans/FS111-derivation.md:654-->
**Address** `plans/FS111-derivation.md:654` · **Role** upstream · **Era** R · **Was** 44 in `lean-order.md` · **Upstream ids** none
<!--needs FS111-W-SQ9: -->

<!--q FS111-W-SQ9 statement-->
**Statement as filed:**
> the colouring of the plane by closed squares of side 1/2, square (i, j) coloured (i mod 3, j mod 3), is a.e.-proper, tight and saturated, also with positive-density partners (every edge faces a same-colour edge at distance exactly 1)

<!--q FS111-W-SQ9 not_claimed-->
**Not claimed:**
> saturation below nine colours on square tilings (FS111-W-HEXSAT's hexagonal analogue)

<!--q FS111-W-SQ9 grade-->
**Grade as filed:**
> computed over: one period of the square lattice (9 classes), exact rationals

<!--q FS111-W-SQ9 minds-->
**Minds as filed:**
> 2 — blind to: W's record until VMW's verdicts were committed; method: W's checker ../tools/fs111_w_check.py, VMW's own certificates

<!--q FS111-W-SQ9 handoff-->
**Handoff as filed:**
> none — a control object; exact and periodic, formalizable on demand


### 103. FS116-O1-YESLIM
<!--row FS116-O1-YESLIM plans/FS116-derivation.md:30-->
**Address** `plans/FS116-derivation.md:30` · **Role** SEED · **Era** R · **Was** 116 in `lean-order.md` · **Upstream ids** none
<!--needs FS116-O1-YESLIM: -->

<!--q FS116-O1-YESLIM statement-->
**Statement as filed:**
> for every k ≥ 1, if for every R > 0 some closed disc of radius R carries a valid k-coloured fragment (a map of an open set containing the disc, bounded by segments and circular arcs, k-coloured with no two interior points of one colour at distance exactly 1), then χ_m⁰(ℝ²) ≤ k; at k = 6, then χ(ℝ²) ≤ 6, with no MR

<!--q FS116-O1-YESLIM not_claimed-->
**Not claimed:**
> the converse (a measurable a.e.-proper six-colouring gives no fragment: it need not be a map); that the limit colouring is a map, or saturated, or regular; anything about the fragments' centres, so nothing about C114-LOCAL-F's explicitness; χ(ℝ²) ≤ 6 from fragments on discs of one bounded radius

<!--q FS116-O1-YESLIM grade-->
**Grade as filed:**
> hand

<!--q FS116-O1-YESLIM minds-->
**Minds as filed:**
> 2 — blind to: the first derivation until V1's verdicts were committed (3daaa05c); method: the Rajchman step by a compact operator and the rounding by a least index (V1 § 4.1 rows 1–2), against dominated convergence and the support rounding; the same model (Opus 5.5), one prior

<!--q FS116-O1-YESLIM handoff-->
**Handoff as filed:**
> de Bruijn — queued behind the measurable chain (row 131's weak-* step): the statement at every k, its not-claimed line, and the Rajchman lemma it rests on

<!--q FS116-O1-YESLIM merge@SR2-4.3-18-->
**Merge note — to formalize** (SR2-4.3 item 18, `plans/FS129-SR2-audit.md:481-482`; status applied):
> 18. **FS106-EQ's (c) ⟹ (a) at every `k`** once (the weak-* step), and **FS116-O1-YESLIM** as its corollary by Lemma P (FS129-SR2-YESLIM-EQ), in place of YESLIM's own weak-* argument.


### 165. FS121-D3-GRUNDY
<!--row FS121-D3-GRUNDY plans/FS121-derivation.md:516-->
**Address** `plans/FS121-derivation.md:516` · **Role** SEED · **Era** R · **Was** 174 in `lean-order.md` · **Upstream ids** FS111-M-SATC, FS111-M2-ZERO
<!--needs FS121-D3-GRUNDY: FS111-M-SATC,FS111-M2-ZERO-->

<!--q FS121-D3-GRUNDY statement-->
**Statement as filed:**
> every a.e.-proper k-colouring (S_1, …, S_k) of the plane can be modified, keeping it a.e.-proper with k colours and never raising a point's colour index, into a measurable Grundy colouring (A_1, …, A_k): A_1 is a MUA set, each A_m is maximal among sets with null unit pairs inside the complement of A_1 ∪ … ∪ A_(m−1) that contain S_m minus that union, every point of the support of A_m is at distance exactly 1 from the support of A_i for every i < m, and so at every essential boundary point x every colour of P(x) other than the largest is bound at x

<!--q FS121-D3-GRUNDY not_claimed-->
**Not claimed:**
> that the colour max P(x) is bound (the output need not be saturated); uniqueness; that the output lies above f in any order; any regularity of the classes; that a saturated input stays saturated

<!--q FS121-D3-GRUNDY grade-->
**Grade as filed:**
> hand

<!--q FS121-D3-GRUNDY minds-->
**Minds as filed:**
> 2 — blind to: D3 § 2.2 until dea603eb; method: exhaustion (dependent choice) and a ball added at a support point (V3), against Zorn and a positive-density limit (D3)

<!--q FS121-D3-GRUNDY handoff-->
**Handoff as filed:**
> de Bruijn — queued behind the measurable chain; its dependent-choice route matters to a ZF + DC audit (Soifer's Open AC Problem 62.14)


### 167. FS121-D4-FACE
<!--row FS121-D4-FACE plans/FS121-derivation.md:908-->
**Address** `plans/FS121-derivation.md:908` · **Role** SEED · **Era** R · **Was** 180 in `lean-order.md` · **Upstream ids** none
<!--needs FS121-D4-FACE: -->

<!--q FS121-D4-FACE statement-->
**Statement as filed:**
> in an a.e.-proper measurable colouring, let x be a point, e a unit vector and e⊥ a unit vector orthogonal to it; if the open half-box {x − s e + t e⊥ : 0 < s < ε, |t| < ε} and the open box {x + s e + t e⊥ : g < s < g + ε′, |t| < ρ} both lie almost everywhere in one class S_c, with ε, ε′ > 0 and 0 < 2g < ρ², then no point of supp S_c is at distance exactly 1 from x; so in a saturated colouring the colour c has density 1 at x

<!--q FS121-D4-FACE not_claimed-->
**Not claimed:**
> the same with a curved near side (a tangent unit disc admits the in-contact x − e); the margin below ρ² ≥ 2g − g² (FALSE there, FS121-V5-FACE-SHARP); anything at an x where c has density 1; honesty, D-NF, REG-J′ (none is used)

<!--q FS121-D4-FACE grade-->
**Grade as filed:**
> hand

<!--q FS121-D4-FACE minds-->
**Minds as filed:**
> 2 — blind to: D4 §§ 2.1–2.2 until V5's verdicts were committed (4ed402c6); method: a Fubini pair lemma and a crossing criterion with the exact corner (V5), against the sagitta bound and a shrinking ε′ (D4)

<!--q FS121-D4-FACE handoff-->
**Handoff as filed:**
> de Bruijn — a short measure-theoretic lemma (Fubini on Leb ⊗ σ, one trigonometric bound); it crosses with the measurable chain

<!--q FS121-D4-FACE merge@SR1-6.2-6-->
**Merge note — replaced in whole or in the part the line names** (SR1-6.2 item 6, `plans/FS129-SR1-audit.md:548-548`; status applied):
> 6. **FS121-V5-FACE-SHARP**'s form in place of FS121-D4-FACE's hypothesis `2g < ρ²`.


### C1. FS129-OA1-NOPERLAW
<!--row FS129-OA1-NOPERLAW plans/FS129-derivation.md:301-->
**Address** `plans/FS129-derivation.md:301` · **Role** FS-129 composition · **Upstream ids** none
<!--needs FS129-OA1-NOPERLAW: -->

<!--q FS129-OA1-NOPERLAW statement-->
**Statement as filed:**
> for a stationary random colouring c of ℝ², continuous in probability and proper almost surely on every unit pair, the set Z of vectors x with c(0) = c(x) almost surely is a discrete subgroup of ℝ²; if the law of c is rotation-invariant, Z = {0}

<!--q FS129-OA1-NOPERLAW not_claimed-->
**Not claimed:**
> anything about pairs forced with probability below 1, or about near-forcing at a scale; that rotation-averaging preserves every property a route needs (it preserves stationarity, continuity in probability and almost-sure properness, which is all this statement uses)

<!--q FS129-OA1-NOPERLAW grade-->
**Grade as filed:**
> hand

<!--q FS129-OA1-NOPERLAW minds-->
**Minds as filed:**
> 1

<!--q FS129-OA1-NOPERLAW handoff-->
**Handoff as filed:**
> none — a relay-result recorded for FS-104's route (b); it enters no proof in this record

<!--q FS129-OA1-NOPERLAW uses_only-->
**Uses only:**
> continuity in probability (x ↦ P(c(0) ≠ c(x)) is continuous, so Z is closed); stationarity (Z is a subgroup: c(x) = c(x + y) a.s. is the shift of c(0) = c(y)); properness on unit pairs (Z misses the unit circle); that a closed subgroup of ℝ² that is not discrete contains a line through 0

<!--q FS129-OA1-NOPERLAW merge@SA1-6.3-UNCHANGED-->
**Merge note — unchanged** (SA1-6.3 item UNCHANGED, `plans/FS129-SA1-audit.md:747-747`; status applied):
> **Unchanged:** FS129-OA1-NOPERLAW (handoff none); TC1-STANDING-FIVE (a conditional seed).


### C8. FS129-SA1-FALC-RED
<!--row FS129-SA1-FALC-RED plans/FS129-derivation.md:237-->
**Address** `plans/FS129-derivation.md:237` · **Role** FS-129 composition · **Upstream ids** none
<!--needs FS129-SA1-FALC-RED: -->

<!--q FS129-SA1-FALC-RED statement-->
**Statement as filed:**
> if a finite unit-distance graph H ⊂ ℝ² has a Falconer fan at k colours with apex a and tip t, |t − a| = r > 1/2, and arcsin(1/(2r))/π irrational, then every cover of ℝ² by k measurable sets has two points at distance 1 inside one of the sets, so χ_m(ℝ²) ≥ k + 1 for Falconer's everywhere-proper measurable chromatic number

<!--q FS129-SA1-FALC-RED not_claimed-->
**Not claimed:**
> the almost-everywhere form (χ_m⁰, the target given MR) — it needs Lemma 3 with a positive-measure set of translations, which the 1981 text does not supply; that any Falconer fan at five colours exists; anything for χ(ℝ²) without MR; Lemma 1 in the form "for every e ∈ E, almost every rotation about e" (false in general: a null E may hold a circle about e)

<!--q FS129-SA1-FALC-RED grade-->
**Grade as filed:**
> hand

<!--q FS129-SA1-FALC-RED minds-->
**Minds as filed:**
> 1

<!--q FS129-SA1-FALC-RED handoff-->
**Handoff as filed:**
> de Bruijn — formalize FS129-OA1-FALC-RED's statement from this entry's argument, behind the measurable chain (FS-113), importing `[Falconer1981]` Lemma 1 in the paper's form only (the motion is the lemma's), Lemmas 2–4 as `plans/FS129-MA1-audit.md` § 2.1 transcribes them

<!--q FS129-SA1-FALC-RED uses_only-->
**Uses only:**
> `[Falconer1981]` as `plans/FS129-MA1-audit.md` § 2.1 transcribes it from the page images — Lemma 1 in the paper's form (for a non-empty null set E, a countable configuration C and a point x ∈ C, a rigid motion p, chosen by the lemma, with p(x) ∈ E and, for almost every rotation ρ about p(x), ρ(p(C)) ∩ E = {p(x)}); Lemma 2(i) applied to a class of positive measure and positive co-measure, for E ≠ ∅ and E null; the null-set sentence (E is the union of the classes' metrical boundaries, for disjoint classes); FS103-M's D2 (a point of E lies in at least two metrical boundaries, `plans/FS103-M-derivation.md` line 252); Lemma 3; Lemma 4, with Lemma 2(ii); the cover made disjoint first

<!--q FS129-SA1-FALC-RED merge@SA1-6.3-6-->
**Merge note — to formalize** (SA1-6.3 item 6, `plans/FS129-SA1-audit.md:733-734`; status applied):
> 6. **FS129-OA1-FALC-RED's statement from FS129-SA1-FALC-RED's argument**, importing `[Falconer1981]` Lemma 1 in the paper's form only (the motion is the lemma's; never "for every e ∈ E, almost every rotation about e").


### C10. FS129-SA1-PLACE-HOM
<!--row FS129-SA1-PLACE-HOM plans/FS129-derivation.md:59-->
**Address** `plans/FS129-derivation.md:59` · **Role** FS-129 composition · **Upstream ids** none
<!--needs FS129-SA1-PLACE-HOM: -->

<!--q FS129-SA1-PLACE-HOM statement-->
**Statement as filed:**
> let F ⊆ ℝ be a number field with a usable prime 𝔭 of residue field 𝔽_q, and let E = F(t₁, …, t_n) ⊂ ℝ with t₁, …, t_n algebraically independent over F (n ≥ 0); then there are a subring V ⊆ E holding both coordinates of every unit vector of E² and a ring homomorphism φ : V → 𝔽_q that restricts to reduction mod 𝔭 on the local ring 𝒪_{F,𝔭}; so the unit-distance graph on E² has a graph homomorphism into Γ_q, given on each coset x₀ + V² by x ↦ φ(x − x₀)

<!--q FS129-SA1-PLACE-HOM not_claimed-->
**Not claimed:**
> any finitely generated E ⊂ ℝ that is not purely transcendental over a number field (G63's Remark-1 caution; a place of such an E lands in an uncontrolled residue field); a homomorphism onto Γ_q (only into); that V is a valuation ring

<!--q FS129-SA1-PLACE-HOM grade-->
**Grade as filed:**
> hand

<!--q FS129-SA1-PLACE-HOM minds-->
**Minds as filed:**
> 1

<!--q FS129-SA1-PLACE-HOM handoff-->
**Handoff as filed:**
> de Bruijn — the homomorphism behind `unitQuadrance_colorable_of_valuationSubring` (`Transcendental.lean`, via `cosetResidue`), iterated n times and composed with the residue map at 𝔭; every field statement of this family is formalized through it

<!--q FS129-SA1-PLACE-HOM uses_only-->
**Uses only:**
> for n = 0, V = 𝒪_{F,𝔭} and φ the reduction (a unit vector of F is 𝔭-integral, because −1 is not a square in 𝔽_q — the valuation lemma `mem_valuationSubring_of_sq_add_sq_eq_one`); for n ≥ 1, by induction, V_n = {x in the valuation ring of t_n ↦ 0 on F(t₁, …, t_{n−1})(t_n) : x(t_n = 0) ∈ V_{n−1}} and φ_n = φ_{n−1} ∘ (evaluation at t_n = 0) — a unit vector of E_n has coordinates in that valuation ring because its residue field F(t₁, …, t_{n−1}) ⊂ ℝ has no square root of −1 (G63, the same valuation lemma), and its value at t_n = 0 is a unit vector of E_{n−1}, in V_{n−1}² by induction; that a ring homomorphism takes a unit vector to a vector of quadrance 1, which is non-zero and adjacent to 0 in Γ_q; the coset step of `unitQuadrance_colorable_of_subring`

<!--q FS129-SA1-PLACE-HOM merge@SA1-6.3-2-->
**Merge note — to formalize** (SA1-6.3 item 2, `plans/FS129-SA1-audit.md:727-728`; status applied):
> 2. **FS129-SA1-PLACE-HOM**, once, as the homomorphism every field statement of the family goes through (the coset map behind `unitQuadrance_colorable_of_valuationSubring`, iterated, composed with the residue map).


### C11. FS129-SA1-FALC-RES
<!--row FS129-SA1-FALC-RES plans/FS129-derivation.md:197-->
**Address** `plans/FS129-derivation.md:197` · **Role** FS-129 composition · **Upstream ids** FS129-SA1-FALC-DICHO-K, FS129-SA1-FALC-FAN, FS129-SA1-PLACE-HOM
<!--needs FS129-SA1-FALC-RES: FS129-SA1-FALC-DICHO-K,FS129-SA1-FALC-FAN,FS129-SA1-PLACE-HOM-->

<!--q FS129-SA1-FALC-RES statement-->
**Statement as filed:**
> let F ⊆ ℝ be a number field, E = F(t₁, …, t_n) ⊂ ℝ with t₁, …, t_n algebraically independent over F (n ≥ 0), and H ⊂ E² a finite connected unit-distance graph with apex a and tip t forming a Falconer fan at five colours; then (i) χ(F²) ≥ 4, and F has no usable prime of residue field 𝔽₇; (ii) for every usable prime 𝔭 of F of residue field 𝔽₁₁ or 𝔽₁₉, with V and φ as in FS129-SA1-PLACE-HOM at 𝔭, t − a has coordinates in V and φ(t − a) = 0

<!--q FS129-SA1-FALC-RES not_claimed-->
**Not claimed:**
> that any fan at five colours exists; the case φ(t − a) = 0 excluded (no held colouring has a vertex with two gap colours; the Searcher's queue rows 1 and 4); fields whose only four-colourable residue targets are dyadic inert U_Q with Q ∈ {4, 8, 16} (queue row 5); fields with L(F) ≥ 5 beyond clause (ii); the almost-everywhere form

<!--q FS129-SA1-FALC-RES grade-->
**Grade as filed:**
> derived from: FS129-SA1-FALC-FAN, FS129-SA1-FALC-DICHO-K, FS129-SA1-PLACE-HOM

<!--q FS129-SA1-FALC-RES minds-->
**Minds as filed:**
> 1

<!--q FS129-SA1-FALC-RES handoff-->
**Handoff as filed:**
> de Bruijn — formalize in place of FS129-OA1-FALC-11, FS129-MA1-FALC-19 and FS129-MA2-FALC-HOSTS clause (i): FALC-FAN's lemma through PLACE-HOM, with the two orbit facts as `decide` over 2 × 121 × 24 colourings of Γ₁₁ and 40 × 361 of Γ₁₉, beside `Instances/FanGap11.lean` and `Instances/FanGap19.lean`; HOSTS clauses (ii)–(iv) stay as filed, re-pointed to FALC-FAN (B) and DICHO-K

<!--q FS129-SA1-FALC-RES uses_only-->
**Uses only:**
> FS129-SA1-FALC-DICHO-K (χ(H) ≥ 4) and χ(E²) = χ(F²) (row 104, iterated) for χ(F²) ≥ 4; FS129-SA1-FALC-FAN (B) at T = Γ₇ through FS129-SA1-PLACE-HOM, with the kernel's gapped `circ7Table` colouring moved by a translation of Γ₇ to put its gap at ρ(t) (control FS129-MA2-G7GAP); FS129-SA1-FALC-FAN (A) at T = Γ₁₁ and Γ₁₉ through PLACE-HOM, translated so that ρ(a) = 0, with the two exact orbit facts — for every w ≠ 0 in 𝔽_q², some colouring in the orbit of the held tables under Γ_q's point group and translations, with a gap γ at 0, has C(w) ∉ {C(0), γ} or a gap at w outside {C(0), γ} (controls FS129-SA1-ORBIT11, FS129-SA1-ORBIT19, re-running pass 1's and pass 2's tools); that H connected puts t − a in V² (a sum of unit vectors)

<!--q FS129-SA1-FALC-RES merge@SA1-6.3-5-->
**Merge note — to formalize** (SA1-6.3 item 5, `plans/FS129-SA1-audit.md:731-732`; status applied):
> 5. **FS129-SA1-FALC-RES** in place of FS129-OA1-FALC-11, FS129-MA1-FALC-19 and FS129-MA2-FALC-HOSTS clause (i); HOSTS clauses (ii)–(iv) as filed, from FALC-FAN (B) and DICHO-K.


### C12. FS129-MA2-FALC-HOSTS
<!--row FS129-MA2-FALC-HOSTS plans/FS129-derivation.md:262-->
**Address** `plans/FS129-derivation.md:262` · **Role** FS-129 composition · **Upstream ids** FS129-SA1-FALC-DICHO-K, FS129-SA1-FALC-FAN, FS129-SA1-FALC-RES (the `uses only:` names FS129-MA1-FALC-19, FS129-MA2-FALC-DICHO, FS129-MA2-FALC-GAP4; a superseded form there is read as the form its handoff names)
<!--needs FS129-MA2-FALC-HOSTS: FS129-SA1-FALC-DICHO-K,FS129-SA1-FALC-FAN,FS129-SA1-FALC-RES-->

<!--q FS129-MA2-FALC-HOSTS statement-->
**Statement as filed:**
> let H ⊂ F² be a finite connected unit-distance graph over a real number field F, with apex a and tip t forming a Falconer fan at five colours; then (i) F has no usable prime of residue field 𝔽₃ or 𝔽₇ and no place above 2 ramified in F(i); (ii) if H is drawn in a lattice Λ with its complete unit-vector set U and some finite quotient Cay(Λ/NΛ, U mod N) has a proper four-colouring with a colour absent from a closed neighbourhood, there is no such H; (iii) if H is drawn in de Grey's lattice, t − a ∈ 8Λ; (iv) if F is ℚ(√59), ℚ(√83) or ℚ(√131), then t − a ∈ R ∩ 𝔓⁴ (R = ℤ[U_F], 𝔓 the dyadic prime) and every four-colouring of F² is periodic

<!--q FS129-MA2-FALC-HOSTS not_claimed-->
**Not claimed:**
> that any fan exists in the planes (iii) and (iv) leave open; anything over K beyond MA1's (FS129-OA1-FALC-11 at the primes of residue field 𝔽₁₁, and row 59's dyadic law, already confine t − a there); the fields whose only four-colourable residue targets are dyadic inert U_Q with Q ∈ {4, 8, 16} — whether those targets have a gapped four-colouring is not decided (a search request); fields with L(F) ≥ 5, where H may be five-chromatic and nothing here applies

<!--q FS129-MA2-FALC-HOSTS grade-->
**Grade as filed:**
> derived from: FS129-MA2-FALC-GAP4, FS129-MA2-FALC-DICHO

<!--q FS129-MA2-FALC-HOSTS minds-->
**Minds as filed:**
> 1

<!--q FS129-MA2-FALC-HOSTS handoff-->
**Handoff as filed:**
> de Bruijn — clauses (ii)–(iv) as filed, over FS129-SA1-FALC-FAN (B) and FS129-SA1-FALC-DICHO-K in place of FS129-MA2-FALC-GAP4 and -DICHO (SA1 § 6.3 item 5); clause (i) is superseded by FS129-SA1-FALC-RES (i) and is not formalized from this entry (FS129-Z1, 2026-10-03); the reader's handoff, verbatim: "de Bruijn — (i) over `finitePlane7` and `PlaneRotation`'s residue homomorphism; (iii) and (iv) wait on rows 78 and 88's Lean forms"

<!--q FS129-MA2-FALC-HOSTS uses_only-->
**Uses only:**
> FS129-MA2-FALC-GAP4 and FS129-MA2-FALC-DICHO; for (i), the residue map at a usable prime 𝔭 as a homomorphism of H, translated to put a vertex at 0, into Γ_q (FS129-MA1-FALC-19's step: −1 a non-square in 𝔽_q), the kernel's gapped proper four-colouring of Γ₇ (`circ7Table` along `projAlong (1, 2)`, `Instances/PlaneFreedom.lean`; control FS129-MA2-G7GAP) moved by a translation of Γ₇ to put its gap at the tip's image, χ(Γ₃) = 3, and a place above 2 ramified in F(i) giving χ(F²) ≤ 2 (G35); for (ii), the quotient map Λ → Λ/NΛ and the quotient's translations; for (iii), row 78 (`F = P = 8Λ` on de Grey's lattice); for (iv), row 88 (`F(R) ∈ {0, P(R)}`, `P(R) = R ∩ 𝔓⁴`) and that H connected puts t − a in R

<!--q FS129-MA2-FALC-HOSTS merge@SA1-6.3-5-->
**Merge note — replaced in whole or in the part the line names** (SA1-6.3 item 5, `plans/FS129-SA1-audit.md:731-732`; status applied):
> 5. **FS129-SA1-FALC-RES** in place of FS129-OA1-FALC-11, FS129-MA1-FALC-19 and FS129-MA2-FALC-HOSTS clause (i); HOSTS clauses (ii)–(iv) as filed, from FALC-FAN (B) and DICHO-K.


### C13. FS129-SA1-NOAFF-FIELDS
<!--row FS129-SA1-NOAFF-FIELDS plans/FS129-derivation.md:121-->
**Address** `plans/FS129-derivation.md:121` · **Role** FS-129 composition · **Upstream ids** FS129-SA1-NOAFF-K, FS129-SA1-PLACE-HOM
<!--needs FS129-SA1-NOAFF-FIELDS: FS129-SA1-NOAFF-K,FS129-SA1-PLACE-HOM-->

<!--q FS129-SA1-NOAFF-FIELDS statement-->
**Statement as filed:**
> let F ⊆ ℝ be a number field, E = F(t₁, …, t_n) ⊂ ℝ with t₁, …, t_n algebraically independent over F (n ≥ 0), and H ⊂ E² a finite unit-distance graph; suppose k = 5 and F has a usable prime of residue field 𝔽₁₁ or 𝔽₁₉ or χ(F²) ≤ 4, or k = 4 and F has a usable prime of residue field 𝔽₇ or χ(F²) ≤ 3; then for every family of functions φ_v : Fin k → ℝ (v a vertex of H) with Σ_v φ_v(C(v)) taking one value on every proper k-colouring C of H, every φ_v is constant

<!--q FS129-SA1-NOAFF-FIELDS not_claimed-->
**Not claimed:**
> fields with no usable prime of residue field 𝔽₇, 𝔽₁₁ or 𝔽₁₉ and χ(F²) ≥ k (K at k = 4 among them — its primes above 7 have residue field 𝔽₄₉, and K's plane carries four-colour forced pairs, hence identities); inequalities; k ≥ 6

<!--q FS129-SA1-NOAFF-FIELDS grade-->
**Grade as filed:**
> derived from: FS129-SA1-NOAFF-K, FS129-SA1-PLACE-HOM

<!--q FS129-SA1-NOAFF-FIELDS minds-->
**Minds as filed:**
> 1

<!--q FS129-SA1-NOAFF-FIELDS handoff-->
**Handoff as filed:**
> de Bruijn — formalize in place of FS129-OA1-NOLIN5's and FS129-MA1-NOAFF5's field readings: NOAFF-K composed with PLACE-HOM and the three kernel slack facts

<!--q FS129-SA1-NOAFF-FIELDS uses_only-->
**Uses only:**
> FS129-SA1-NOAFF-K (its slack clause); FS129-SA1-PLACE-HOM (H into Γ_q); slackness of Γ₁₁ and Γ₁₉ at five (kernel: `finitePlane11_slack`, `finitePlane19_slack`) and of Γ₇ at four (the kernel's `circ7Table` is proper with a gapped vertex, and Γ₇ is a Cayley graph, `slack_addCayley_of_fanGap`; control FS129-SA1-NOAFF4's first line, FS129-MA2-G7GAP); χ(E²) = χ(F²) (row 104, kernel at d = 2, iterated n times), so H maps into K_{k−1}, which is slack at k

<!--q FS129-SA1-NOAFF-FIELDS merge@SA1-6.3-1-->
**Merge note — to formalize** (SA1-6.3 item 1, `plans/FS129-SA1-audit.md:724-726`; status applied):
> 1. **FS129-SA1-NOAFF-K** (with its field corollary **FS129-SA1-NOAFF-FIELDS**) in place of FS129-OA1-NOLIN5, FS129-MA1-NOAFF5, MA2's k = 4 note (`plans/FS129-MA2-audit.md` § 2.3) and FS84-S1e (`plans/FS84-S1-derivation.md` § 4.2); `Slack.forces_iff_of_hom` (row 66, kernel) is its two-vertex case.


### C14. FS129-SA1-SQRT3-LOCAL
<!--row FS129-SA1-SQRT3-LOCAL plans/FS129-derivation.md:321-->
**Address** `plans/FS129-derivation.md:321` · **Role** FS-129 composition · **Upstream ids** none
<!--needs FS129-SA1-SQRT3-LOCAL: -->

<!--q FS129-SA1-SQRT3-LOCAL statement-->
**Statement as filed:**
> for a number field F and a place w of F above 2 at which 3 is a square in the completion F_w, w is unramified in F(i)/F, and w splits in F(i) if and only if its residue degree f(w|2) is even; when it does not split it is inert, of norm 2^f with f = f(w|2) odd

<!--q FS129-SA1-SQRT3-LOCAL not_claimed-->
**Not claimed:**
> anything at a dyadic place where 3 is not a square — ℚ(ζ₇)⁺'s one place above 2 is ramified in F(i) (TC1-FIELDS); at ℚ(√7)'s, i ∈ F_w and w splits with f = 1; anything about the places of F not above 2

<!--q FS129-SA1-SQRT3-LOCAL grade-->
**Grade as filed:**
> hand

<!--q FS129-SA1-SQRT3-LOCAL minds-->
**Minds as filed:**
> 1

<!--q FS129-SA1-SQRT3-LOCAL handoff-->
**Handoff as filed:**
> de Bruijn — formalize in place of TC1-SQRT3-DYADIC, as a conditional seed like it: one local lemma; it crosses with G56's dyadic exclusion if that is formalized

<!--q FS129-SA1-SQRT3-LOCAL uses_only-->
**Uses only:**
> √−3 generates ℚ₄ = ℚ₂(ζ₃), the unramified quadratic extension of ℚ₂; F_w(i) = F_w(√−3) when 3 is a square in F_w (i = √−3/√3); a compositum with an unramified extension is unramified over the smaller field; ℚ₄ ⊆ F_w when 2 divides f(w|2), and not otherwise

<!--q FS129-SA1-SQRT3-LOCAL merge@SA1-6.3-7-->
**Merge note — to formalize** (SA1-6.3 item 7, `plans/FS129-SA1-audit.md:735-735`; status applied):
> 7. **FS129-SA1-SQRT3-LOCAL** in place of TC1-SQRT3-DYADIC (a conditional seed, as filed).


### C24. FS129-SR2-SUPK
<!--row FS129-SR2-SUPK plans/FS129-derivation.md:1065-->
**Address** `plans/FS129-derivation.md:1065` · **Role** FS-129 composition · **Upstream ids** FS106-SUP
<!--needs FS129-SR2-SUPK: FS106-SUP-->

<!--q FS129-SR2-SUPK statement-->
**Statement as filed:**
> for every k ≥ 1, µ_k⁰ = lim_{ε→0} µ_k(ε) = lim_{ε→0} µ_k^tile(ε) = lim_{ε→0} µ_k^per(ε), with µ_k⁰, µ_k(ε), µ_k^tile(ε), µ_k^per(ε) defined as FS106-SUP defines them at six (the suprema of the upper densities covered by a.e.-proper, band-proper, band-proper tiled, and band-proper periodic tiled partial k-colourings)

<!--q FS129-SR2-SUPK not_claimed-->
**Not claimed:**
> SUP's second clause (µ^per(ε) = µ(ε) at each ε, and attainment) at every k — QB's stronger form was not read here; any value of µ_k⁰

<!--q FS129-SR2-SUPK grade-->
**Grade as filed:**
> derived from: FS106-SUP

<!--q FS129-SR2-SUPK minds-->
**Minds as filed:**
> 1

<!--q FS129-SR2-SUPK handoff-->
**Handoff as filed:**
> de Bruijn — in place of FS106-SUP; then FS106-EQ's (e) has its input as stated, and EQ's (c) ⟺ (d) is SUPK at the value 1

<!--q FS129-SR2-SUPK uses_only-->
**Uses only:**
> FS106-SUP's argument (plans/FS106-TQ-derivation.md § 3.2) and its Lemmas P and T (§ 3.1) and TQ-REM-i, none of which reads the number of classes: Lemma P copies a colouring of a square, Lemma T colours each grid square by the least class meeting it in positive measure, REM-i keeps points class by class

<!--q FS129-SR2-SUPK merge@SR2-4.3-11-->
**Merge note — to formalize** (SR2-4.3 item 11, `plans/FS129-SR2-audit.md:472-473`; status applied):
> 11. **FS129-SR2-SUPK** (every `k`) in place of **FS106-SUP** (six); FS106-EQ's (c) ⟺ (d) as its corollary at the value 1, and **FS106-COMP's first clause** as FS106-EQ's (c) ⟹ (a), stated at every `k`.


### L1. FS106-COMP
<!--row FS106-COMP plans/FS106-derivation.md:229-->
**Address** `plans/FS106-derivation.md:229` · **Role in `lean-order.md`** upstream · **Was** 1 · **Why it left** in edges.csv as IX1 wrote it: FS106-COMP → FS106-EQ [kept]; FS106-EQ → FS106-SUP [dropped: false, sorted by SR2]; FS106-SUP → FS111-C1-UNIF [kept]
**Cautions:** [C118](#c118)

<!--q FS106-COMP statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> If for every δ > 0 six disjoint measurable classes with Leb ⊗ σ-null unit pairs have union of upper density ≥ 1 − δ, then χ_CP(ℝ²) ≤ 6 and χ_m⁰(ℝ²) ≤ 6; and "µ₆(ε) < 1 for every ε > 0" is equivalent to `[Voronov2023]` Thm 1.1 (Euclidean norm, six colours).

<!--q FS106-COMP not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS106-COMP grade-->
**Grade as filed:**
> hand; the first two minds, one blind: TQ, QB; the equivalence one mind: QB

<!--q FS106-COMP minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS106-COMP handoff-->
**`*Kernel:*` line as filed:**
> declined.

<!--q FS106-COMP merge@SR2-4.3-11-->
**Merge note — named** (SR2-4.3 item 11, `plans/FS129-SR2-audit.md:472-473`; status applied):
> 11. **FS129-SR2-SUPK** (every `k`) in place of **FS106-SUP** (six); FS106-EQ's (c) ⟺ (d) as its corollary at the value 1, and **FS106-COMP's first clause** as FS106-EQ's (c) ⟹ (a), stated at every `k`.


### L4. FS106-REM
<!--row FS106-REM plans/FS106-derivation.md:225-->
**Address** `plans/FS106-derivation.md:225` · **Role in `lean-order.md`** upstream · **Was** 4 · **Why it left** in edges.csv as IX1 wrote it: FS106-REM → FS106-EQ [kept]; FS106-EQ → FS106-SUP [dropped: false, sorted by SR2]; FS106-SUP → FS111-C1-UNIF [kept]
**Cautions:** [C118](#c118)

<!--q FS106-REM statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> Kept points (balls of radii ε/2 and 2ε at least 1 − η full of one tight class; any η < 1/(1 + 4π), QB's η = 1/10) of one colour are never at distance in [1 − ε, 1 + ε], for every ε > 0, in every almost-everywhere-proper measurable partial colouring; for a CP colouring P(0 is not kept at scale ε) → 0; the uniform form of the latter is FALSE (the zigzag colouring).

<!--q FS106-REM not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS106-REM grade-->
**Grade as filed:**
> hand; two minds, one blind: TQ, QB; the uniform form's falsity one mind (TQ)

<!--q FS106-REM minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS106-REM handoff-->
**`*Kernel:*` line as filed:**
> declined.


### L5. FS106-EQ
<!--row FS106-EQ plans/FS106-derivation.md:197-->
**Address** `plans/FS106-derivation.md:197` · **Role in `lean-order.md`** upstream CYCLE · **Was** 5 · **Why it left** in edges.csv as IX1 wrote it: FS106-EQ → FS106-SUP [dropped: false, sorted by SR2]; FS106-SUP → FS111-C1-UNIF [kept]
**Cautions:** [C118](#c118)

<!--q FS106-EQ statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> For every k, with no MR and no Voronov: χ_m⁰(ℝ²) ≤ k ⟺ χ_CP(ℝ²) ≤ k ⟺ µ_k⁰ = 1 ⟺ lim_{ε→0} µ_k(ε) = 1 ⟺ for every δ > 0 there are ε > 0 and a periodic partial k-colouring by half-open grid squares with no monochromatic pair at any distance in [1 − ε, 1 + ε], leaving density ≤ δ uncovered. At k = 6: χ_m⁰(ℝ²) ≥ 7 ⟺ lim_{ε→0} µ₆(ε) < 1, so `[SokolovVoronov2025]` §9's hypothesis "µ∗₆ < 1" (read uniformly in ε) is equivalent to χ_m⁰ = 7.

<!--q FS106-EQ not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS106-EQ grade-->
**Grade as filed:**
> hand; two minds, one blind: TQ, QB by a different route at (c) ⟹ (a); (a) ⟺ (b) is row 130's

<!--q FS106-EQ minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS106-EQ handoff-->
**`*Kernel:*` line as filed:**
> stub — after row 130's M1 enters FS-101.

<!--q FS106-EQ note@205-->
**dated note filed under the entry (`plans/FS106-derivation.md:205`):**
> *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR2-audit.md` § 2.1 row 5 and § 2.2.3; `plans/FS129-close-inventory.md` item 117):* this entry is stated "for every k", and its periodic grid-square clause rests on FS106-SUP, which is stated at six only. The input at every k is FS129-SR2-SUPK (`plans/FS129-derivation.md`: FS106-SUP's argument, which reads no number of classes, at every k; derived, one mind). Read EQ's every-k form as citing SUPK; EQ's (c) ⟺ (d) is SUPK read at the value 1. No statement changes.

<!--q FS106-EQ merge@SR2-4.3-11-->
**Merge note — named** (SR2-4.3 item 11, `plans/FS129-SR2-audit.md:472-473`; status applied):
> 11. **FS129-SR2-SUPK** (every `k`) in place of **FS106-SUP** (six); FS106-EQ's (c) ⟺ (d) as its corollary at the value 1, and **FS106-COMP's first clause** as FS106-EQ's (c) ⟹ (a), stated at every `k`.

<!--q FS106-EQ merge@SR2-4.3-18-->
**Merge note — to formalize** (SR2-4.3 item 18, `plans/FS129-SR2-audit.md:481-482`; status applied):
> 18. **FS106-EQ's (c) ⟹ (a) at every `k`** once (the weak-* step), and **FS116-O1-YESLIM** as its corollary by Lemma P (FS129-SR2-YESLIM-EQ), in place of YESLIM's own weak-* argument.


### L17. FS111-M2-DISC7
<!--row FS111-M2-DISC7 plans/FS111-derivation.md:887-->
**Address** `plans/FS111-derivation.md:887` · **Role in `lean-order.md`** upstream · **Was** 17 · **Why it left** in edges.csv as IX1 wrote it: FS111-M2-DISC7 → FS111-M2-HULLC [dropped: false, sorted by SR2]
**Cautions:** [C118](#c118)

<!--q FS111-M2-DISC7 statement-->
**Statement as filed:**
> the circumscribed discs of the tight hexagonal seven-colouring (radius 1/2, centred at the hexagon centres, coloured as the hexagons) form a maximal admissible seven-cover with regular classes whose overlaps (lenses) have positive measure; each class has density 2π/(21√3), the seven summing to Kershner's thinnest-covering density 2π/(3√3)

<!--q FS111-M2-DISC7 not_claimed-->
**Not claimed:**
> that its selections are saturated (FS111-M2-NOSEL); curvature of class boundaries ≤ 1 (it is 2)

<!--q FS111-M2-DISC7 grade-->
**Grade as filed:**
> computed over: one period of the hexagonal lattice, 7 discs, exact rational bounds in ℚ(√3)

<!--q FS111-M2-DISC7 minds-->
**Minds as filed:**
> 2 — blind to: M2's record until VM2's verdicts were committed; method: M2 by hand and a 2,173-point exact grid, VM2 by exact bounds at every point (VM2-DISC7-EXACT)

<!--q FS111-M2-DISC7 handoff-->
**Handoff as filed:**
> none — a control object; exact and periodic, formalizable on demand


### L25. FS111-M-COVER-SC
<!--row FS111-M-COVER-SC plans/FS111-derivation.md:538-->
**Address** `plans/FS111-derivation.md:538` · **Role in `lean-order.md`** upstream · **Was** 25 · **Why it left** in edges.csv as IX1 wrote it: FS111-M-COVER-SC → FS111-M2-HULLC [dropped: false, sorted by SR2]
**Cautions:** [C118](#c118)

<!--q FS111-M-COVER-SC statement-->
**Statement as filed:**
> in a maximal cover, at every boundary point of F_a each adjacent path-connected piece of F̃_a lies in an enclosing unit disc or outside an exterior one; where ∂F_a is locally the graph of a continuous function with F_a below it, that function is semiconcave with constant 1

<!--q FS111-M-COVER-SC not_claimed-->
**Not claimed:**
> semiconvexity (FALSE on covers: DISC7, curvature 2)

<!--q FS111-M-COVER-SC grade-->
**Grade as filed:**
> derived from: FS111-M-SATC, FS111-C-HULL

<!--q FS111-M-COVER-SC minds-->
**Minds as filed:**
> 1 — FS111-M (FS111-M2-HULLC extends it, sighted; VM2 blind on HULLC)

<!--q FS111-M-COVER-SC handoff-->
**Handoff as filed:**
> none — superseded by FS111-M2-HULLC's fuller form; crosses with it

<!--q FS111-M-COVER-SC note@553-->
**dated note filed under the entry (`plans/FS111-derivation.md:553`):**
> *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR2-audit.md` § 2.1, rows 25 and 37; `plans/FS129-close-inventory.md` item 117):* the handoff's "superseded by FS111-M2-HULLC's fuller form" is wrong: HULLC adds "with regular classes", while this entry's semiconcavity holds on every maximal cover (it uses FS111-M-SATC and C-HULL only). Formalize this entry's semiconcavity in place of HULLC's semiconcave clause (SR2 § 4.3 item 17); the edge from this entry into HULLC is not a use. C-HULL is itself a case of FS129-SR2-HULLSET (`plans/FS129-derivation.md`).

<!--q FS111-M-COVER-SC merge@SR2-4.3-17-->
**Merge note — to formalize** (SR2-4.3 item 17, `plans/FS129-SR2-audit.md:480-480`; status applied):
> 17. **FS111-M-COVER-SC's semiconcavity** (every maximal cover) in place of **FS111-M2-HULLC's semiconcave clause** (regular classes).


### L33. FS111-M3-BAND
<!--row FS111-M3-BAND plans/FS111-derivation.md:1261-->
**Address** `plans/FS111-derivation.md:1261` · **Role in `lean-order.md`** upstream CYCLE · **Was** 33 · **Why it left** in edges.csv as IX1 wrote it: FS111-M3-BAND → FS111-M3-HC [kept]; FS111-M3-HC → FS111-M3-IRREG [kept]; FS111-M3-IRREG → FS111-M3-FIXCONV [kept]; FS111-M3-FIXCONV → FS111-M2-FIX [dropped: false, sorted by SR2]
**Cautions:** [C118](#c118)

<!--q FS111-M3-BAND statement-->
**Statement as filed:**
> a flat side of a block of diameter ≤ 1 in a MUA set needs material of its class at distance exactly 1 over the middle half of the side; a band of length λ excludes its own horns out to λ and is unit-free only if λ ≤ 1; a side of length 1 with its band at distance 1 is excluded exactly by an apex at depth √3/2, tight at one point

<!--q FS111-M3-BAND not_claimed-->
**Not claimed:**
> anything about curved sides (constant-width blocks carry no band)

<!--q FS111-M3-BAND grade-->
**Grade as filed:**
> derived from: FS111-M2-FIX

<!--q FS111-M3-BAND minds-->
**Minds as filed:**
> 1 — FS111-M3

<!--q FS111-M3-BAND handoff-->
**Handoff as filed:**
> none — design facts for HC


### L34. FS111-M3-FIXCONV
<!--row FS111-M3-FIXCONV plans/FS111-derivation.md:1247-->
**Address** `plans/FS111-derivation.md:1247` · **Role in `lean-order.md`** upstream CYCLE · **Was** 34 · **Why it left** in edges.csv as IX1 wrote it: FS111-M3-FIXCONV → FS111-M2-FIX [dropped: false, sorted by SR2]
**Cautions:** [C118](#c118)

<!--q FS111-M3-FIXCONV statement-->
**Statement as filed:**
> the converse of FS111-M2-FIX fails: F_f is regular with int F = ℝ² ∖ (F + S¹) and its interior is not maximal

<!--q FS111-M3-FIXCONV not_claimed-->
**Not claimed:**
> anything about maximal sets

<!--q FS111-M3-FIXCONV grade-->
**Grade as filed:**
> derived from: FS111-M3-IRREG

<!--q FS111-M3-FIXCONV minds-->
**Minds as filed:**
> 1 — FS111-M3

<!--q FS111-M3-FIXCONV handoff-->
**Handoff as filed:**
> none — a scope marker for FS111-M2-FIX


### L35. FS111-M3-HC
<!--row FS111-M3-HC plans/FS111-derivation.md:1135-->
**Address** `plans/FS111-derivation.md:1135` · **Role in `lean-order.md`** upstream CYCLE · **Was** 35 · **Why it left** in edges.csv as IX1 wrote it: FS111-M3-HC → FS111-M3-IRREG [kept]; FS111-M3-IRREG → FS111-M3-FIXCONV [kept]; FS111-M3-FIXCONV → FS111-M2-FIX [dropped: false, sorted by SR2]
**Cautions:** [C118](#c118)

<!--q FS111-M3-HC statement-->
**Statement as filed:**
> the honeycomb class HC — equilateral triangles of side 1 at the vertices of a honeycomb of edge 2 + √3/3, pointing at the face centres; on each edge a band of length 1 at distance 1 from both facing sides, of thickness in [0, g] vanishing exactly on a closed null set Z ∋ ±1/2; discs of radius 1/2 at the face centres — is a regular MUA set satisfying FS111-M2-FIX, for every gap function with (G1)'s bounds; with Z a Cantor set (HC_K) each band has one interior component per gap

<!--q FS111-M3-HC not_claimed-->
**Not claimed:**
> that HC_K is a class of any partition (FS111-M4-HC: it fits none with an ordinary ladder through three rungs); any colour count

<!--q FS111-M3-HC grade-->
**Grade as filed:**
> computed over: the critical configurations of one period of the honeycomb, exact in ℚ(√3), with the hand reduction to them

<!--q FS111-M3-HC minds-->
**Minds as filed:**
> 1 — FS111-M3 (../tools/fs111_m3_honey.py: six checks, five plants firing)

<!--q FS111-M3-HC handoff-->
**Handoff as filed:**
> none — a counterexample to a universal form; exact, formalizable on demand


### L36. FS111-M3-IRREG
<!--row FS111-M3-IRREG plans/FS111-derivation.md:1231-->
**Address** `plans/FS111-derivation.md:1231` · **Role in `lean-order.md`** upstream CYCLE · **Was** 36 · **Why it left** in edges.csv as IX1 wrote it: FS111-M3-IRREG → FS111-M3-FIXCONV [kept]; FS111-M3-FIXCONV → FS111-M2-FIX [dropped: false, sorted by SR2]
**Cautions:** [C118](#c118)

<!--q FS111-M3-IRREG statement-->
**Statement as filed:**
> with a fat Cantor set Z_f, A_f = int HC(g_f) is unit-avoiding, regular and satisfies the shadow identity, but is not maximal, and every MUA set containing it has |∂ supp| > 0; so "every MUA set is regular" (MUA-REG-U) is false

<!--q FS111-M3-IRREG not_claimed-->
**Not claimed:**
> that no maximal cover can be modified into one with regular classes (MUA-REG-P is open)

<!--q FS111-M3-IRREG grade-->
**Grade as filed:**
> hand

<!--q FS111-M3-IRREG minds-->
**Minds as filed:**
> 1 — FS111-M3

<!--q FS111-M3-IRREG handoff-->
**Handoff as filed:**
> none — a no-go for a universal form


### FS121-V5-FACE-SHARP
<!--row FS121-V5-FACE-SHARP plans/FS121-derivation.md:1055-->
**Address** `plans/FS121-derivation.md:1055` · **Role** not in the order · **Named by** SR1-6.2 item 6

<!--q FS121-V5-FACE-SHARP statement-->
**Statement as filed:**
> in FS121-D4-FACE's setting, the first clause holds whenever ρ² ≥ 2g − g², that is (1 − g)² + ρ² ≥ 1, and fails for some colouring whenever ρ² < 2g − g²

<!--q FS121-V5-FACE-SHARP not_claimed-->
**Not claimed:**
> anything about curved near sides

<!--q FS121-V5-FACE-SHARP grade-->
**Grade as filed:**
> hand

<!--q FS121-V5-FACE-SHARP minds-->
**Minds as filed:**
> 1

<!--q FS121-V5-FACE-SHARP handoff-->
**Handoff as filed:**
> none — it sharpens a held lemma's margin

<!--q FS121-V5-FACE-SHARP merge@SR1-6.2-6-->
**Merge note — to formalize** (SR1-6.2 item 6, `plans/FS129-SR1-audit.md:548-548`; status applied):
> 6. **FS121-V5-FACE-SHARP**'s form in place of FS121-D4-FACE's hypothesis `2g < ρ²`.


### 3. FS106-SUP
<!--row FS106-SUP plans/FS106-derivation.md:207-->
**Address** `plans/FS106-derivation.md:207` · **Role** upstream · **Era** R · **Was** 6 in `lean-order.md` · **Upstream ids** none
<!--needs FS106-SUP: -->

<!--q FS106-SUP statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> The tight and slack suprema coincide: µ₆⁰ = lim µ₆(ε) = lim µ₆^tile(ε) = lim µ₆^per(ε); moreover µ₆^per(ε) = µ₆(ε) at each ε, and µ₆⁰ and µ₆(ε) are attained (by a stationary family and by almost every sample of it).

<!--q FS106-SUP not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS106-SUP grade-->
**Grade as filed:**
> hand; two minds, one blind: TQ, QB (stronger)

<!--q FS106-SUP minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS106-SUP handoff-->
**`*Kernel:*` line as filed:**
> declined.

<!--q FS106-SUP merge@SR2-4.3-11-->
**Merge note — replaced in whole or in the part the line names** (SR2-4.3 item 11, `plans/FS129-SR2-audit.md:472-473`; status applied):
> 11. **FS129-SR2-SUPK** (every `k`) in place of **FS106-SUP** (six); FS106-EQ's (c) ⟺ (d) as its corollary at the value 1, and **FS106-COMP's first clause** as FS106-EQ's (c) ⟹ (a), stated at every `k`.


### 177. TC1-SQRT3-DYADIC
<!--row TC1-SQRT3-DYADIC plans/TC1-derivation.md:8-->
**Address** `plans/TC1-derivation.md:8` · **Role** SEED (conditional: handoff begins `none`) · **Era** A · **Was** 196 in `lean-order.md` · **Upstream ids** none
<!--needs TC1-SQRT3-DYADIC: -->
**Cautions:** [C13](#c13)

<!--q TC1-SQRT3-DYADIC statement-->
**Statement as filed:**
> for a number field F with √3 ∈ F and i ∉ F, no place of F above 2 is ramified in F(i)/F, and a place w above 2 splits in F(i) if and only if its residue degree f(w|2) is even; when it does not split it is inert, of norm 2^f with f odd

<!--q TC1-SQRT3-DYADIC not_claimed-->
**Not claimed:**
> anything for F without √3 — ℚ(ζ₇)⁺'s one place above 2 is ramified in F(i) (TC1-FIELDS)

<!--q TC1-SQRT3-DYADIC grade-->
**Grade as filed:**
> hand

<!--q TC1-SQRT3-DYADIC minds-->
**Minds as filed:**
> 1

<!--q TC1-SQRT3-DYADIC handoff-->
**Handoff as filed:**
> none — a two-line local lemma that scopes G56's exclusion; it crosses to de Bruijn with that exclusion if it is formalized

<!--q TC1-SQRT3-DYADIC merge@SA1-6.3-7-->
**Merge note — replaced in whole or in the part the line names** (SA1-6.3 item 7, `plans/FS129-SA1-audit.md:735-735`; status applied):
> 7. **FS129-SA1-SQRT3-LOCAL** in place of TC1-SQRT3-DYADIC (a conditional seed, as filed).


### C26. FS129-SR2-YESLIM-EQ
<!--row FS129-SR2-YESLIM-EQ plans/FS129-derivation.md:1102-->
**Address** `plans/FS129-derivation.md:1102` · **Role** FS-129 composition · **Upstream ids** FS106-COMP, FS106-EQ
<!--needs FS129-SR2-YESLIM-EQ: FS106-COMP,FS106-EQ-->

<!--q FS129-SR2-YESLIM-EQ statement-->
**Statement as filed:**
> for every k ≥ 1, if for every R > 0 some closed disc of radius R carries a valid k-coloured fragment, then χ_m⁰(ℝ²) ≤ k (FS116-O1-YESLIM's first clause), as a corollary of FS106-EQ's implication (c) ⟹ (a) at k

<!--q FS129-SR2-YESLIM-EQ not_claimed-->
**Not claimed:**
> YESLIM's clause at six with no MR (that is row 130's χ(ℝ²) ≤ χ_m⁰(ℝ²), unchanged); anything about a single fragment of bounded radius

<!--q FS129-SR2-YESLIM-EQ grade-->
**Grade as filed:**
> derived from: FS106-EQ

<!--q FS129-SR2-YESLIM-EQ minds-->
**Minds as filed:**
> 1

<!--q FS129-SR2-YESLIM-EQ handoff-->
**Handoff as filed:**
> de Bruijn — formalize FS106-EQ's (c) ⟹ (a) once at every k (the weak-* step), and YESLIM as this two-line corollary in place of its own weak-* argument

<!--q FS129-SR2-YESLIM-EQ uses_only-->
**Uses only:**
> FS106-EQ (c) ⟹ (a) at k — if for every δ > 0 there are k disjoint measurable classes with Leb ⊗ σ-null monochromatic unit pairs whose union has upper density at least 1 − δ, then χ_m⁰(ℝ²) ≤ k (FS106-COMP's first clause, stated by EQ at every k); Lemma P of plans/FS106-TQ-derivation.md § 3.1 in its Leb ⊗ σ-null form; that a fragment's tile boundaries are Lebesgue-null and its colour classes have no unit pair between interior points

<!--q FS129-SR2-YESLIM-EQ merge@SR2-4.3-18-->
**Merge note — named** (SR2-4.3 item 18, `plans/FS129-SR2-audit.md:481-482`; status applied):
> 18. **FS106-EQ's (c) ⟹ (a) at every `k`** once (the weak-* step), and **FS116-O1-YESLIM** as its corollary by Lemma P (FS129-SR2-YESLIM-EQ), in place of YESLIM's own weak-* argument.
