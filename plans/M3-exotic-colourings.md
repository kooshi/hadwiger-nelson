# M3 (crunch milestone) — colourings no periodic colouring or character gives: FS-76 in rank one, and FS-64 at five colours over ℚ(√167)

*Planner: de Bruijn (Opus 5.5), crunch job J06, 2026-09-25, from `data/crunch-2026-09-25/briefs/J06-M3-reframe.md` (template J03's brief;
`STANDING-RULES.md` part of it). The reframe of WORKFLOW 3 (§G, §PA, §IQ), the subplan (§S, §P), the modeling passes (§M), the
would-have-searched log (§X). Two questions, one verdict column each: **Q1** = FS-76 in rank one; **Q2** = FS-64 at five colours over
ℚ(√167). Fenced from J20 and J22 (the blind verifiers) until each verifier's verdicts are committed: this file carries routes.*

*Theorems this phase proved:* none claimed by the planner as results; the reformulations in "The milestone in the theory's terms" are
[hand, planner, one mind], stated for the derivation jobs to prove or refute, and are listed as their targets in §S.

---

## Stage 1 — SAVED (the quotation check, the recognition, §G.1)

### Q. The quotation check (standing rule 5): every quotation in the J06 brief and the owner's launch message against its source

| # | quotation (brief or launch message) | source | result |
|---|---|---|---|
| 1 | "the rank-1 criterion is exact (T35: `P ≠ F` iff every cyclic phase is rigid and a wall exists), and a scan to `max D = 14`, `\|D\| ≤ 5` found no counterexample (T36). **Rank 1 closes if 'every phase rigid ⟹ no wall' is proved** (the reading, unrefuted on 377 of 377 all-rigid sets) — the cheapest open item here." | `plans/STUB-four-colour-inheritance.md`, "Re-aimed at FS-79's close", Question 1 | **verbatim**, except that the stub's inner double quotes around *every phase rigid ⟹ no wall* are single quotes in the brief (a nesting change, meaning intact) |
| 2 | "with `plans/FS79-derivation.md` T3, T30 and T34–T36" | `plans/FS79-derivation.md` | **slip in the brief:** FS79-**T30** is "C4′: on every non-bipartite graph the signed flux through an even relation torus is slaved to the monopole charge swept" — a face-flux no-go, not the rank-1 walls. The rank-1 walls are **FS73-T30** ("Rank-1 walls at four colours, and the wall criterion", `plans/FS73-derivation.md` line 284). Both are read here; J18's brief cites FS73-T30. Logged as an inventory slip. |
| 3 | "at five colours the window count fails at the real place (Croft's `m₁ ≥ 0.22936 > 1/5`), so the five-colour question is untouched." | `plans/STUB-four-colours-167.md` line 5 (the FS-86 re-aim) | **verbatim** |
| 4 | "FS86-CL1 excluded four colours there" (not quoted; a paraphrase) | `plans/FS86-derivation.md` FS86-CL1: "over ℚ(√47) and ℚ(√167), no four-colouring of the plane is a measurable window colouring over a finite set `S` of places whose split places are odd (`W` proper on `Γ_S`, or off a null set as in C14′)" | **faithful with a qualifier dropped**: CL1 requires the split places of `S` odd (C14.2 (c) at `p = 2` is "not checked"), and it is graded "[hand, one mind (the close planner)]". Both qualifiers are carried into J21's brief verbatim. |
| 5 | queue line J21: "(FS86-CL1 excluded four; at five the real place's `m₁ ≥ 0.229 > 1/5` breaks its count)" | CL1's last sentence: "Croft 1967's `m₁ ≥ 0.22936 > 1/5`" | faithful (rounded) |
| 6 | "The conjecture predicts at least six at ℚ(√167). A five-colour window colouring would falsify it." | `CLAUDE.md` Frontier item 12; G59 ("the conjecture predicts χ(ℚ(√167)²) ≥ 6 whichever way the wall goes") | faithful. **Precision owed:** a five-colouring from a window proper on all of `Γ_S` falsifies it; a window proper only off a null set (C14′'s format) gives a plane colouring only for almost every placement, and **its properness on the countable set `ι_S(F²) + t` is not implied by a.e.-properness** (a countable set of directions is null in the circle). J21's brief states the format exactly. |
| 7 | owner's launch message: "J01 has verified, blind, that FS-89's band rigidity holds at k = 6–9 colours (RS_k for every \|S\| ≥ 2, and RQ_k) [hand + tools exact], and claims, with one reader so far, every k (Θ_k(R_F) ⊆ T + A for every F ⊆ ℝ)" | `data/crunch-2026-09-25/reports/J01.md` RESULT line: "PA-B3 TRUE at k = 6, 7, 8, 9 (RS_k(S) every \|S\| ≥ 2, and RQ_k) [hand + tools exact]; the all-k candidate TRUE [hand, one mind]: RS_k(S) for every k and \|S\| ≥ 2, RQ_k for every k, Θ_k(R_F) ⊆ T + A for every F ⊆ ℝ" | faithful. Consumed as: k ≤ 9 verified; every k only as the named hypothesis "given J01-7, one reader". |
| 8 | "one derivation agent (J18), gated at about 2.5 hours, then a blind verifier (J20) with a fixed list you write now. A second mind (J19) is launched only if J18 stalls at a named step, and then on that step." | `plans/CRUNCH-2026-09-25-queue.md` §2 rows J18–J20 | faithful |
| 9 | "Staffing is one derivation (J21) plus a blind verifier (J22)." | queue §2 rows J21, J22 | faithful |

### The milestone in the theory's terms (the recognition; §IQ states it formally)

**Q1, recognised.** For a finite `D ⊂ ℤ_{>0}` (gcd 1 without loss, FS79-T6), the proper four-colourings of `G(ℤ, D)` form a
one-dimensional shift of finite type `X₄(D)` — a hom-shift on `Cay(ℤ, D)` with target `K₄` — presented by the window-state graph. In
a one-dimensional SFT, *every cyclic strongly connected component is a single cycle* is exactly **zero topological entropy**, which is
exactly **`X₄(D)` countable**; and given zero entropy, *a wall exists* is exactly **`X₄(D)` infinite** (a bi-infinite path confined to
one single-cycle SCC is periodic, and there are finitely many). So FS-79's reading R2 is, in the discipline's words:

> **R2 ⟺ "a countable four-colouring shift of a distance graph on ℤ is finite"** (equivalently: an infinite one has positive entropy;
> equivalently, its Cantor–Bendixson rank is 1).

General one-dimensional SFTs violate this (the two-symbol shift forbidding `10` is countable and infinite), so a proof must use what
colouring shifts have and general SFTs lack: the reflection `x ↦ −x` and the colour permutations (T34 used both, and closes the achiral
case), and **Kempe structure** — a finite Kempe component, or a vertex whose closed neighbourhood misses a colour (a fan gap, G13), in a
periodic colouring yields a finite perturbation, hence a second cycle through its SCC, hence entropy. So in an all-rigid shift **every
periodic colouring is fan-gap-free and has only infinite Kempe components** [planner's lemma, one line, owed to J18 as a named step].
What is open is the chiral case: a wall `C → C′` between rigid phases one of which is chiral (T34), for instance `C → C^R`, which
reflection maps to itself.

**Q2, recognised.** A measurable window colouring over a finite set `S` of places of `F = ℚ(√167)` is a measurable proper colouring
of the **categorical product** `Γ_S = ∏_{v ∈ S} Γ_v` of the local unit-distance graphs (FS-64 §3a; C14's `Cay(G_S, T_S)`, `T_S` the
product of the local circles). Three facts, each already in the corpus or classical, change what the question is:
1. **Pullback from one factor.** A proper colouring of one factor pulls back along the projection to a proper colouring of `Γ_S`, so
   `χ_meas(Γ_S) ≤ min_v χ_meas(Γ_v)`. At `S = {∞₁}` the format is exactly a measurable proper five-colouring of the unit-distance graph
   of `ℝ²`. **So "no five-colour window colouring over any `S` containing a real place" implies `χ_m(ℝ²) ≥ 6`**, where the literature
   holds `5 ≤ χ_m(ℝ²) ≤ 7` (Falconer 1981; the Hadwiger–Nelson surveys; §PA to confirm that six is open). And a yes at `S = {∞₁}` is a
   measurable five-colouring of the whole plane, which is `χ(ℝ²) ≤ 5`. **The question's simplest slice is an open problem of the
   literature, at least as hard in the "no" direction as the measurable chromatic number of the plane.**
2. **The count, and where it stops.** C14.1/C14.3's count (Zhang's product rule: the product's measurable independence ratio is the
   largest factor's) excludes `k` colours when every factor's ratio is `< 1/k`. At `k = 5` the real places read `m₁ ≥ 0.22936`
   (Croft), so the count fails whenever `S` contains a real place — the integrality gap `χ_f ≤ 4.36 < 5 ≤ χ_m` sits at the real factor
   (G43, G59's escape hatch, G24's gap law). Where `S` has **no** real place the count reaches five except at two named factors: the
   inert place 43 above level one (its all-levels ratio is uncertified; FS-66's instrument is priced at 84 GPU-days there, G66, and banned
   as a machine-long certificate) and the split dyadic places (C14.2 (c) at `p = 2`, "not checked").
3. **No tight place.** ℚ(√167) has no conjugation-fixed place Hoffman-tight at five colours (G54: 23 and 43 slack), so C14's second half
   (one good fibre propagated by a tight plane's gap-freeness) has nothing to stand on; a pullback theorem at five colours would have to
   come from the product's own structure (a measurable, stability form of `[Zhang2012]` Thm 1.8's MIS-normality) or not at all.

So Q2 splits into **(Q2-fin)** the finite-place windows — a count with two named gaps, plausibly closable by hand; **(Q2-∞)** windows
using a real place — reducible, at best, to the measurable chromatic number of `ℝ²` (or of `ℝ² × ℝ²` for the two real places, which
the Galois conjugation swaps, G27), by a **pullback theorem**: *every measurable proper five-colouring of `Γ_∞ × Γ_fin` with `Γ_fin`'s
ratio `< 1/5` is almost everywhere a pullback from the archimedean factor* — the product-structure question a derivation can attack, and
whose failure would be a measurable Hedetniemi gap (a genuine finding either way).

### G.1 The grokkings (every entry G1–G76, fresh from disk; one line, two columns: Q1 | Q2)

- **G1** — Q1 silent: no field; rank-1 graphs. | Q2 **bears**: ℚ(√167)'s wall is broken (167 ≡ 7 mod 8), so its dyadic places are split, the count's unchecked factor → J21 stage 2 (named gap).
- **G2** — Q1 silent: no geometry. | Q2 silent: construction grammar, not colourings.
- **G3** — Q1 silent: radii. | Q2 silent: radii.
- **G4** — Q1 silent: shell inventory. | Q2 silent: shell inventory.
- **G5** — Q1 silent: 1-sums of witnesses (FS79-T6 is the rank-1 reduction). | Q2 silent.
- **G6** — Q1 silent. | Q2 silent: hexagram containment.
- **G7** — Q1 silent. | Q2 silent: the Σ = 42 layer is a character matter (rows 95–96), not a window.
- **G8** — Q1 silent. | Q2 silent: direction group of the 1581.
- **G9** — Q1 silent: a compulsion hunt one rung below; Q1 is inheritance, not a hunt. | Q2 silent.
- **G10** — Q1 silent. | Q2 silent.
- **G11** — Q1 silent. | Q2 silent: Moser-free forcers.
- **G12** — Q1 silent. | Q2 silent: quadrature of detuned copies.
- **G13** — Q1 **bears**: a fan gap in a periodic colouring is a one-vertex recolouring, a finite perturbation, so entropy; all-rigid ⟹ gap-free periodic points → J18 stage 2 (lemma K0). | Q2 silent: pair-level coverage, not densities.
- **G14** — Q1 silent. | Q2 silent.
- **G15** — Q1 silent. | Q2 silent: design grammar of forcers.
- **G16** — Q1 silent. | Q2 silent.
- **G17** — Q1 silent. | Q2 silent.
- **G18** — Q1 silent: no solver. | Q2 silent: no solver.
- **G19** — Q1 silent. | Q2 silent: class sweeps.
- **G20** — Q1 silent. | Q2 **bears**: brick/torus colourings are the archimedean corner (seven, closed classes); a window at ∞ inherits ≤ 7 → J21 stage 2 (the corners).
- **G21** — Q1 **bears**: T36's 377/377 measures `|D| ≤ 5`, `max D ≤ 14`; no scan extends it (ban); every claim carries an exact quantifier → J18 C0, J20's list. | Q2 **bears**: CL1's "untouched at five" measures the count, not the format → J21 stage 2 separates count from truth.
- **G22** — Q1 silent. | Q2 **bears**: no polygonal colouring uses six (`[SokolovVoronov2025]`), so polygonal real windows at `S = {∞}` need seven; the measurable slice is open → J21 stage 2.
- **G23** — Q1 silent. | Q2 silent: scale refinement.
- **G24** — Q1 silent. | Q2 **bears**: the count is a relaxation (1/m₁ ≤ 4.36); five at the real factor is integrality, so no density argument decides it → J21 stage 3 needs a non-density step.
- **G25** — Q1 silent. | Q2 silent: 6-forcer pricing.
- **G26** — Q1 silent. | Q2 silent: gadget reduction.
- **G27** — Q1 **bears**: use every automorphism of the shift (reflection, S₄), as T34 did; the chiral case wants one more → J18 stage 2. | Q2 **bears**: the Galois flip swaps ℚ(√167)'s two real places; `Γ_{∞₁} × Γ_{∞₂}` carries that symmetry → J21 stage 3.
- **G28** — Q1 silent. | Q2 silent.
- **G29** — Q1 silent. | Q2 **bears**: with G22, cell-constant real windows need seven at every scale; only non-polygonal measurable windows are live → J21 stage 2.
- **G30** — Q1 **bears**: failure mode 5 — R2's statement ships inhabitants (`{1,2,3}`: all rigid, no wall; `{1,5,7,10}`: walls with entropy); discipline to enter: symbolic dynamics → §PA, J18. | Q2 **bears**: mode 5/7 — a "no" ships its format's inhabitant at seven (the hexagonal tiling as a window); discipline: measurable combinatorics → §PA.
- **G31** — Q1 silent. | Q2 silent.
- **G32** — Q1 silent. | Q2 silent.
- **G33** — Q1 silent. | Q2 silent.
- **G34** — Q1 silent. | Q2 silent.
- **G35** — Q1 silent. | Q2 **bears**: broken wall = every dyadic place split; the split ratio at `p = 2` (C14.2 (c)) is unchecked → J21 stage 2 closes or names it.
- **G36** — Q1 silent. | Q2 silent.
- **G37** — Q1 silent. | Q2 silent.
- **G38** — Q1 silent: additive phases are achiral (T34 covers). | Q2 **bears**: coset/additive colourings give nothing between four and seven; with row 96, the windowless and linear cases are closed → J21 stage 1 (inputs).
- **G39** — Q1 silent. | Q2 silent.
- **G40** — Q1 silent. | Q2 silent.
- **G41** — Q1 silent: additive colourings of `G(ℤ, D)` are single achiral cycles (T31/T34). | Q2 silent.
- **G42** — Q1 **bears**: Kempe connectivity; all-rigid ⟹ every Kempe component of every periodic colouring infinite (a finite one swaps to a detour, entropy) → J18 stage 2 (lemma K0). | Q2 silent.
- **G43** — Q1 silent. | Q2 **bears**: a composite target beats its best factor only through an integrality gap `χ_f ≤ k < χ`; the real factor is exactly that gap at five → J21 stage 3 (measurable Hedetniemi).
- **G44** — Q1 silent. | Q2 **bears**: every stable prime ≥ 59 has Hoffman ratio < 1/5, constant up the tower (G54) → J21 stage 2 count, citable.
- **G45** — Q1 silent. | Q2 silent.
- **G46** — Q1 **bears**: name it: 1-D SFT, hom-shift on `Cay(ℤ, D)`, zero entropy ⟺ countable → §PA query and J18's statement. | Q2 **bears**: name it: measurable chromatic number, categorical products of LCA Cayley graphs, model sets → §PA.
- **G47** — Q1 silent. | Q2 silent.
- **G48** — Q1 silent. | Q2 **falsifiable**: a five-colour window colouring is a whole-plane colouring local at no prime, the conjecture's named falsifier at ℚ(√167) — registered as P-Q2-yes (§P).
- **G49** — Q1 **bears**: gate in the discipline's words; grep the held Polymath16/MathOverflow threads → §PA. | Q2 **bears**: same; "measurable chromatic number" → §PA.
- **G50** — Q1 **bears**: held-unread touching Q1: `[EggletonErdosSkilton1990]`, `[CGHO2025bg]` §6.2.1 → §PA reads them. | Q2 **bears**: `[AmbrusEtAl2023]` (input, unaudited: item 70/J26), Croft 1967, Falconer 1981, `[BachocEtAl2014]` (abstract only) → §PA.
- **G51** — Q1 **bears**: the seventh run's shape; J19 only on a named stall; fixed list before claims → §S. | Q2 **bears**: J21 + blind J22 with a lemma-statement fallback → §S.
- **G52** — Q1 silent. | Q2 silent.
- **G53** — Q1 silent. | Q2 silent: arena counting screen.
- **G54** — Q1 silent: rank-1 inheritance is decided by T35, not by quotient tightness. | Q2 **bears**: ℚ(√167) has no tight place at five, so C14's pullback half has no footing; the count is the only engine → J21 stage 3.
- **G55** — Q1 silent. | Q2 silent: chain theorem needs a forced pair.
- **G56** — Q1 silent. | Q2 **bears**: 23 and 43 are ℚ(√167)'s window members; 23's all-levels ratio ≤ 97/529 is certified, 43's only at level one → J21 stage 2 gap.
- **G57** — Q1 silent. | Q2 silent: triangles do not enter the count; the real factor has them regardless.
- **G58** — Q1 silent. | Q2 silent.
- **G59** — Q1 silent. | Q2 **bears**: "six only through a factor with χ_f ≤ 6 < χ" — at five the real factor is that factor; the prediction ≥ 6 → J21 stage 3, §P.
- **G60** — Q1 silent. | Q2 **bears**: the density engine of C14.1 is G60's; its cap (4.36, usable planes' χ_f) is why the count stops at five → J21 stage 2 states the cap as a theorem of the format.
- **G61** — Q1 silent. | Q2 silent.
- **G62** — Q1 silent. | Q2 **bears**: the window colouring is the cut-and-project instrument G62 frames; finite-place windows are the "commensurate" (periodic-like) side → J21 stage 2 naming.
- **G63** — Q1 silent. | Q2 silent.
- **G64** — Q1 silent. | Q2 **bears**: FS-64 is "the only proposal for an instrument" in the `L(F)`–`χ(F²)` gap; a no removes a falsifier format, a yes falsifies → §IQ, §P.
- **G65** — Q1 silent: no solver, no ball. | Q2 silent.
- **G66** — Q1 silent. | Q2 **bears**: a `p`-adic factor's measurable ratio is the tower's limit; certified at 23, not at 43 (priced out, banned) → J21 stage 2: 43's all-levels ratio `< 1/5` by hand, or named.
- **G67** — Q1 **bears**: any grokking this milestone mints gets trigger, Do, killing test → §G.4, the close. | Q2 **bears**: same.
- **G68** — Q1 **bears**: a gap is sufficient for looseness; in rank 1 T35 is exact and a gap is entropy (G13) → J18 stage 2 cites. | Q2 silent.
- **G69** — Q1 silent: no arithmetic in rank 1. | Q2 silent.
- **G70** — Q1 silent. | Q2 silent.
- **G71** — Q1 **bears**: at three colours the height forbids walls; R2 is what replaces the height at four (walls come with entropy) → J18 stage 2; a proof is a four-colour inheritance theorem with no arithmetic (its killing test's form). | Q2 silent.
- **G72** — Q1 **bears** → §IQ. | Q2 **bears** → §IQ.
- **G73** — Q1 **bears**: R2 cannot be a cell-local certificate; the SCC/entropy structure is a global, structure-derived invariant of the shift → J18 stage 2. | Q2 silent: window-frequency LPs are FS-80's.
- **G74** — Q1 silent. | Q2 **bears**: rows 95–96 close the windowless (character) case at five; a window that is a character is excluded → J21 stage 1 (inputs).
- **G75** — Q1 silent: triangle-pinned spectra are rank ≥ 2 mechanisms. | Q2 silent.
- **G76** — Q1 silent. | Q2 **bears**: C14's no-go at four and "count the primes first"; the five-colour analogue is the question itself → J21 stage 2.

**Counts, §G.1:** 76 grokkings walked (checked mechanically: every id G1–G76 present once). Q1: 14 bears, 62 silent, 0 falsifiable.
Q2: 27 bears, 48 silent, 1 falsifiable (G48, registered as P-Q2-yes in §P).
