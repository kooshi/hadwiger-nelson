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

---

## Stage 2 — SAVED (§G.2 the rows, §G.3 the method rules, §G.4 what changed)

### G.2 The ledger rows (`LEDGER.md` § A, rows 1–97 by mechanism, read in full from disk; § B read by keyword scan only — see §X)

- **R1** — Q1 silent: two-circle theorem. | Q2 silent.
- **R2** — Q1 silent: seam rotation. | Q2 silent.
- **R3** — Q1 silent: coverage monotonicity. | Q2 silent.
- **R4** — Q1 silent: fan ⟺ coverage (G13 carries the rank-1 use). | Q2 silent.
- **R5** — Q1 silent. | Q2 silent.
- **R6** — Q1 silent. | Q2 silent.
- **R7** — Q1 silent: greedy bound. | Q2 silent.
- **R8** — Q1 silent. | Q2 silent.
- **R9** — Q1 silent. | Q2 silent.
- **R10** — Q1 silent. | Q2 silent.
- **R11** — Q1 silent: a strip's window automaton; method precedent only (T35 is the rank-1 form). | Q2 silent.
- **R12** — Q1 silent. | Q2 silent.
- **R13** — Q1 silent. | Q2 silent.
- **R14** — Q1 silent. | Q2 silent.
- **R15** — Q1 silent. | Q2 silent.
- **R16** — Q1 silent. | Q2 silent.
- **R17** — Q1 silent. | Q2 silent.
- **R18** — Q1 silent. | Q2 silent.
- **R19** — Q1 silent. | Q2 silent.
- **R20** — Q1 silent. | Q2 silent.
- **R21** — Q1 silent. | Q2 silent.
- **R22** — Q1 silent. | Q2 silent.
- **R23** — Q1 silent. | Q2 silent.
- **R24** — Q1 silent. | Q2 silent.
- **R25** — Q1 silent. | Q2 silent.
- **R26** — Q1 silent. | Q2 silent.
- **R27** — Q1 silent. | Q2 silent.
- **R28** — Q1 silent. | Q2 silent.
- **R29** — Q1 silent. | Q2 silent.
- **R30** — Q1 silent. | Q2 silent.
- **R31** — Q1 silent. | Q2 silent: vacuity lesson carried by G30 mode 5.
- **R32** — Q1 silent. | Q2 silent: {1,√3,2} host.
- **R33** — Q1 silent. | Q2 **bears**: the hexagonal 7-colouring is the format's inhabitant at seven (a window at `S = {∞}`, proper everywhere) → J21's no-go ships it (G30.5).
- **R34** — Q1 silent. | Q2 silent: G22/G29 carry the coset/cell corner.
- **R35** — Q1 silent. | Q2 silent: same.
- **R36** — Q1 silent. | Q2 silent.
- **R37** — Q1 silent. | Q2 silent.
- **R38** — Q1 silent. | Q2 silent.
- **R39** — Q1 silent. | Q2 silent.
- **R40** — Q1 silent. | Q2 silent.
- **R41** — Q1 silent. | Q2 silent: limit lemma for drawings.
- **R42** — Q1 silent: arity floor. | Q2 silent.
- **R43** — Q1 silent. | Q2 silent.
- **R44** — Q1 silent. | Q2 silent.
- **R45** — Q1 **bears**: the entropy floor (a 3-colourable graph has ≥ 2ⁿ four-colourings on 3n vertices) gives: all-rigid ⟹ `χ(G(ℤ,D)) = 4` exactly → J18 stage 2, lemma K1. | Q2 silent.
- **R46** — Q1 silent. | Q2 silent.
- **R47** — Q1 silent. | Q2 silent.
- **R48** — Q1 silent. | Q2 silent.
- **R49** — Q1 silent. | Q2 silent.
- **R50** — Q1 silent. | Q2 **bears**: `[Fischer1990]` Ex. 4 — no additive `k`-colouring of ℚ(√167)'s plane for `k < 11`: the linear corner is closed → J21 stage 1 inputs.
- **R51** — Q1 silent. | Q2 silent.
- **R52** — Q1 silent. | Q2 **bears**: the finite factors' ceilings (23, 43 usable): a window at `{23}` alone is a residue colouring, ≤ 8 → J21 stage 2 corners.
- **R53** — Q1 silent. | Q2 **bears**: the factor list for the count — every stable `p ≥ 59` refuses five spectrally → J21 stage 2.
- **R54** — Q1 silent. | Q2 silent.
- **R55** — Q1 silent. | Q2 silent.
- **R56** — Q1 silent. | Q2 **bears**: `card_le_chromaticNumber_mul_indepNum` is the finite, kernel form of C14.1's count → J21 cites.
- **R57** — Q1 silent. | Q2 silent: residue colourings are the one-factor pullbacks; R52 carries the value.
- **R58** — Q1 silent. | Q2 silent.
- **R59** — Q1 silent. | Q2 silent.
- **R60** — Q1 silent. | Q2 silent.
- **R61** — Q1 silent. | Q2 silent.
- **R62** — Q1 silent. | Q2 silent.
- **R63** — Q1 silent. | Q2 silent: two colours from inertia.
- **R64** — Q1 silent. | Q2 silent.
- **R65** — Q1 silent. | Q2 silent.
- **R66** — Q1 **bears**: a gapped vertex is repaintable (one-vertex perturbation); in rank 1 that is a detour, so entropy → J18 lemma K0 (with G13). | Q2 silent.
- **R67** — Q1 silent. | Q2 silent: G54 carries (no tight place at ℚ(√167)).
- **R68** — Q1 silent. | Q2 silent.
- **R69** — Q1 silent. | Q2 **bears**: five refused at 43 by `α ≤ 365 < 370` — level-one ratio 0.1974, a margin of 0.0026; the all-levels ratio is the open factor → J21 stage 2 gap.
- **R70** — Q1 silent. | Q2 **bears**: FS54-T5's product rule (`[Zhang2012]`, `[Zhu2011]`) is the finite form of C14.3 → J21 stage 2.
- **R71** — Q1 silent. | Q2 **bears**: the field blow-up and its cap (4.36) are the count's engine; no density argument reaches five → J21 stage 2 (the cap theorem).
- **R72** — Q1 silent. | Q2 **bears**: FS-64's configuration (ii), the barrier prime 3, is inert in ℚ(√167) with `i ∈ 𝔽₉`, so a **split** place there (ratio → 0 by C14.2 (c)) — it cannot carry a five-colouring the count forbids → J21 stage 2 checks and states it.
- **R73** — Q1 silent. | Q2 silent.
- **R74** — Q1 silent. | Q2 silent.
- **R75** — Q1 silent. | Q2 **bears**: 23's all-levels ratio `≤ 97.98/529 = 0.1852 < 1/5` (certificate); 43 "not claimed", its instrument priced at 84 GPU-days (banned) → J21 stage 2 names 43 at depth.
- **R76** — Q1 silent. | Q2 silent.
- **R77** — Q1 silent. | Q2 silent.
- **R78** — Q1 **bears**: `InheritanceQuestion` (kernel `Prop`, `Kempe.lean`) is Q1's subgroup form; `forces_iff_exists_finite` (compactness) → J18 states R2 as its rank-1 instance. | Q2 silent.
- **R79** — Q1 **bears**: at three colours `P = F` by density (T24) — the `k = 3` case of Q1 is a theorem; a proof of R2 must say why its argument fails at three or reduces to T24 there → J18 stage 2 control. | Q2 silent.
- **R80** — Q1 **bears**: T3 (walls are one-way), T4 (rank-1 window LP exact), T34, T35, T36 are Q1's inputs → J18 stage 1. | Q2 silent.
- **R81** — Q1 silent. | Q2 silent: four colours.
- **R82** — Q1 silent. | Q2 silent: three colours.
- **R83** — Q1 silent. | Q2 silent.
- **R84** — Q1 silent. | Q2 silent.
- **R85** — Q1 silent: the annihilator method is a rank ≥ 2 mechanism; rank-1 periodicity is SFT combinatorics. | Q2 silent.
- **R86** — Q1 **bears**: FS85-dB2's `|D| = 70` distance graph has exactly 24 four-colourings (all rigid, no wall, far outside T36's range), and the embedding lemma (dB1) realises finite graphs in `G(ℤ, D)` — the construction route to a counterexample → J18 stage 3. | Q2 silent.
- **R87** — Q1 silent. | Q2 silent.
- **R88** — Q1 silent. | Q2 silent: type (B), four colours.
- **R89** — Q1 silent. | Q2 silent.
- **R90** — Q1 silent. | Q2 silent: dyadic local plane (ℚ(√167)'s dyadic places are split).
- **R91** — Q1 **bears**: Theorem H (a colouring agreeing with a gap-free periodic one on a half-space equals it) has a rank-1 analogue — one-sided gap-freeness forbids walls out of a phase; R2 is H's rank-1 form for all-rigid shifts → J18 stage 2, lemma K2. | Q2 silent.
- **R92** — Q1 silent. | Q2 **bears**: C14/CL1 are the four-colour theorem Q2 extends; its inputs (C14.1–C14.3, the factor ratios, the `p = 2` caveat) → J21 stage 1.
- **R93** — Q1 silent. | Q2 silent.
- **R94** — Q1 silent. | Q2 **bears**: C9's `⌊4θ⌋` over ℚ(√11) is a non-pullback window colouring where the count permits — the format's positive control → J21 stage 2.
- **R95** — Q1 silent. | Q2 **bears**: every four- and five-colour band character is `T + A` (to nine given J01) → J21 stage 1 inputs.
- **R96** — Q1 silent. | Q2 **bears**: CL5, no character five-colouring of ℚ(√167) — the windowless case closed → J21 stage 1 inputs.
- **R97** — Q1 **bears**: a one-prime heteroclinic character is a wall between two phases in a rank-one system, killed by a second direction — the analogy, and why rank 1 has no second direction → J18 stage 2 note. | Q2 silent: rows 95–96 carry.

**Counts, §G.2:** 97 rows walked (every id R1–R97 present once, checked mechanically). Q1: 8 bears, 89 silent, 0 falsifiable. Q2: 14 bears, 83 silent, 0 falsifiable.

### G.3 The method rules (the `[method]` grokkings G21, G30, G46, G49, G50, G67, G72 are in G.1; below, every other rule in § Whose work, § Delegation, § Standard of evidence, § What compute helps, § Trust ledger, § Toolchain, § Building, § The kernel's cost model, § Searching, § The gate, § Make the gate fail)

- **M1 own the conclusions; "not landed" is complete** — both **bears**: J18/J21 report GAP as GAP → every brief.
- **M2 ask for what the work needs** — both silent: nothing to provision.
- **M3 delegation one level deep** — both **bears**: every brief says it, with the reason → §S briefs.
- **M4 no native evaluation in a headline** — both silent: no Lean this milestone.
- **M5 the artifact is certificate plus checker** — Q1 **bears**: a counterexample `D` ships its window graph and an exact checker → J18 stage 3. | Q2 silent: hand.
- **M6 witness independently re-derivable** — Q1 **bears**: a counterexample is stated by construction, not coordinates → J18. | Q2 silent.
- **M7 read the final statement aloud** — both **bears**: J20's and J22's lists end with the statement read against the informal claim.
- **M8 report the hunt honestly** — both **bears**: every null typed with its range.
- **M9 write the certificate for the reviewer early** — both **bears**: J18/J21 stage 4 asks "what must a reviewer check?"
- **M10 order verification by evidential value** — both **bears**: the verifiers check the deciding step first (the chiral case; the pullback step).
- **M11 a kernel leaf priced high** — both silent: no kernel.
- **M12 a GPU is not a SAT accelerator** — both silent.
- **M13 nothing in `tools/` trusted** — Q1 **bears**: T36's scan tool is evidence, not proof → J18 C0. | Q2 silent.
- **M14 trust ledger; grep the right name** — both silent.
- **M15 lean4checker a publication gate** — both silent.
- **M16 the ban** — both **bears**: no scan (T36 not extended), no LP oracle, no relaxation at 43 → every brief.
- **M17 the would-have-searched log** — both **bears** → every brief.
- **M18 pysat interrupts** — both silent: no solver.
- **M19 venvs outside `build/`** — both silent.
- **M20 break symmetry before SAT** — both silent: no SAT.
- **M21 Python 3.14 forkserver** — Q1 **bears** lightly: any exact check that pools uses `fork` or an initializer → J18 tools. | Q2 silent.
- **M22 machines; physical cores; predicted beside measured** — both silent.
- **M23 always `scripts/build.sh`** — both silent: no Lean.
- **M24 `lake env lean` is not the gate** — both silent.
- **M25 batch is the plan** — both silent.
- **M26 unexplained crash: halt** — both **bears**: in every brief (standing rule 8).
- **M27 RAM is the discriminator; `slot.py`** — Q1 **bears**: a window graph has up to `4^{max D}` states; price before running, slot above 2 GiB → J18 stage 3. | Q2 silent.
- **M28 checkpoint and resume [PROTECTED]** — both silent: no run over 15 minutes is planned; any that appears must answer "what does a relaunch redo?" first.
- **M29 a blocking run is presumed killable [PROTECTED]** — both silent: no long runs.
- **M30 kill by pid/pgid, verify by effect** — both silent.
- **M31 a pipe can kill the producer** — both silent.
- **M32 never edit a running script** — both silent.
- **M33 generated modules and invalidation** — both silent.
- **M34 the kernel's cost model** — both silent.
- **M35 searching (ugrep, `rg -uu`, `exact?`)** — both **bears** lightly: grep counts over records use `rg`/`grep -oF` → verifiers' reading.
- **M36 `vacuity.sh`** — both silent: no Lean.
- **M37 gates keep what they computed** — both silent.
- **M38 every structural hypothesis ships an inhabitant** — both **bears**: R2's inhabitants (`{1,2,3}`; FS85-dB2) and the window format's (the hexagonal 7-window; C9 at four over ℚ(√11)) → J18, J21.
- **M39 an `#eval`/example per definition** — both silent: no definitions in Lean.
- **M40 make the gate fail** — both **bears**: every `tools/crunch_j*` check plants a fault and watches it fire → J18, J21.
- **M41 a positive signal for what did not happen** — Q1 **bears**: an exact wall check reports "walls: 0" only beside a control that has walls (`{1,5,7,10}`) → J18. | Q2 silent.
- **M42 waiters** — both silent.
- **M43 the uninformative outcome reachable** — both **bears** → §P checks each prediction's outcomes reachable.
- **M44 pre-decide the response to your own gate** — both **bears**: §P's scoring rules written now.
- **M45 a sharp instrument loses coverage** — both silent.
- **M46 carry what a number measures** — Q2 **bears**: Croft's 0.22936 is a construction's density (a lower bound on `m₁`), `[AmbrusEtAl2023]`'s 0.2470 an external computer-assisted upper bound, C14.2 (c) a limit — J21 carries each with its kind. | Q1 silent.
- **M47 one thing differs; both outcomes reachable** — both **bears** → §P.
- **M48 measured versus derived halves** — both silent.
- **M49 a check reads the value the code ships** — both silent.
- **M50 the failure path's formatting** — both silent.
- **M51 bound a plant on both sides** — both silent.
- **M52 replay policies** — both silent.
- **M53 a failing run's cost understates** — both silent.
- **M54 a caveat written then stepped over** — both **bears**: CL1's "split places odd" and "one mind" must survive into every summary → J21, J22.
- **M55 count the generator's free parameters** — Q1 **bears**: T36's generator (`|D| ≤ 5`) cannot represent FS85-dB2's `|D| = 70` → J18 C0, §P. | Q2 silent.
- **M56 a true explanation stops the look; check every gate** — Q1 **bears**: a counterexample candidate is checked against all of T35's conditions → J18. | Q2 silent.
- **M57 mutation harness restores; mutate the constant** — both silent.
- **M58 archiving a checker** — both silent.
- **M59 enumerate the parameter first** — both silent.
- **M60 a positive control proves its generator's shapes only** — Q1 **bears**: T36's 377/377 says nothing outside its shape → §P. | Q2 silent.
- **M61 a one-sided filter's inapplicability is not a pass** — Q2 **bears**: the count is one-sided; its failure at the real place is not a "yes" → J21. | Q1 silent.
- **M62 scars, not foresight: plant faults routinely** — both **bears** (standing rule 7).

**Counts, §G.3:** 62 rules walked (M1–M62, checked mechanically). Q1: 26 bears, 36 silent. Q2: 19 bears, 43 silent. 0 falsifiable.

### G.4 What the re-grokking changed in the plan

1. **Q1 is restated in symbolic dynamics' words** (G46, R80): R2 ⟺ *a countable (zero-entropy) four-colouring shift of a distance graph is finite*. J18's statement carries both forms, and §PA searches the second.
2. **Q1 gets three free lemmas before the hard step** (G13, G42, R45, R66, R91): K0 — in an all-rigid shift every periodic colouring is fan-gap-free with every Kempe component infinite; K1 — all-rigid ⟹ `χ(G(ℤ,D)) = 4`; K2 — R2 is Theorem H's rank-1 form: a wall leaves a phase only where the phase is not one-sidedly gap-free (a branching state). They localise the open case to **chiral** rigid phases with a branching state (T34).
3. **Q1 gains a construction route** (R86): the embedding lemma realises finite graphs in `G(ℤ, D)`; a counterexample, if it exists, is likely far outside T36's `|D| ≤ 5` (M55, M60), and J18 is told to try building one before believing R2.
4. **Q2 is re-scoped** (G22, G24, G43, R33, R71): its simplest slice, `S = {∞}`, *is* the measurable chromatic number of the plane at five. So "no five-colour window over any `S`" implies `χ_m(ℝ²) ≥ 6` (open, §PA to confirm), and J21 is not asked to prove it. J21's targets: **(Q2-fin)** the count over sets of places with no real place, its two gaps (43 above level one; the split dyadic ratio) closed or named; **(Q2-∞)** a pullback theorem reducing every window using real places to the archimedean factors, or the named obstruction to one.
5. **Q2 loses FS-64's configuration (ii)** (R72): at ℚ(√167) the barrier prime 3 is a split place, so it contributes ratio → 0 and cannot carry a five-colouring; J21 checks this in its first stage.
6. **Q2's positive controls are named** (R33, R94): the hexagonal 7-window, and C9's non-pullback four-window over ℚ(√11).
7. **Predictions registered before any job runs** (§P), with both outcomes of each confirmed reachable (M43, M47).

---

## Stage 3 — SAVED (§PA, the prior-art gate; about 40 minutes, time-boxed)

*Run in the recognition's words (WORKFLOW 3.2), with the zbMATH API for discovery (item 8), the held Polymath16 threads grepped
(G49), and two web searches. Every negative below measures its query's words (G21).*

### PA.1 Question 2 — measurable colourings, products, windows

> **Correction owed (2026-09-25 crunch):** see `plans/M3-S1D-windows-five.md` §1.1 (Q7); carried in `plans/M3-close-inventory.md` row 19. Not applied here; the close rewrites this entry.

| # | query or source | found | verdict |
|---|---|---|---|
| 1 | zbMATH `ab:"measurable chromatic number"` (17 hits: Falconer's line, Székely–Wormald on ℝ, Bachoc–Nebe–Oliveira–Vallentin 2009, Oliveira–Vallentin 2010, Bachoc–Passuello–Thiery 2015, Bogolubsky–Raigorodskii 2015, Miller 2008, Conley–Miller 2016, Bernshteyn 2019, Weilacher 2022, Malen 2015, Payne 2009) | no paper proving `χ_m(ℝ²) ≥ 6` | negative |
| 2 | zbMATH `ab:"measurable" & ab:"chromatic number of the plane" & py:2000-2026`; `…& ab:"six"`; `ab:"measurable chromatic number" & ab:"product"` | 3, 0, 0 hits; none on six or on products | negative |
| 3 | **`[KechrisMarks2020]`** — A. S. Kechris, A. S. Marks, *Descriptive graph combinatorics* (survey, 2020 version; fetched to `~/source/library/pdf/KechrisMarks-descriptive-graph-combinatorics-2020.pdf`; read: §4.6, §4.7) | §4.7, verbatim: "the unit distance graph on R², … is known to have 5 ≤ χ(U) ≤ χ_µ(U) ≤ χ_B(U) ≤ 7, … but the exact values of χ(U), χ_µ(U), χ_B(U) are unknown." §4.6, **Problem 4.23**, verbatim: "If G, H are analytic graphs, is it true that χ_B(G × H) = min{χ_B(G), χ_B(H)}?"; "C_B(k) … We do not know any other results along these lines. Is C_B(4) true?" | **confirms the recognition**: `χ_µ(ℝ²) ∈ {5, 6, 7}` is open in print, so Q2's `S = {∞₁}` slice is an open problem; and Q2-∞'s pullback question is a **measurable instance of Kechris–Marks's Problem 4.23** (their Borel Hedetniemi problem), open at `k ≥ 4` in general |
| 4 | the held Polymath16 threads (`~/source/library/notes/polymath16-threads-1-18-text.txt`), grep "measurable" | **fourth thread** (Mixon, 5 May 2018), verbatim: "Question. Consider all proper 5-colorings of Tamás's $V_A\oplus V_A\oplus V_A$ in which the neighborhood of the origin avoids colors 1 and 2. Is there any vertex (other than the origin) that is colored either 1 or 2 in all such colorings? If such a vertex exists (and the vertex's distance $r$ from the origin has the property that $\arcsin(\frac{1}{2r})$ is an irrational multiple of $\pi$ ), then the measurable chromatic number of the plane is at least 6 ." First thread (Mixon, 18 April 2018): "Hans Parshall and I went through Falconer's proof … It appears as though a proof that MCNP ≥ 6 might be within reach by somehow replacing the diamond graph with (a subgraph of) de Grey's"; Tao (fourth thread): "Falconer's argument for CNP ≥ 5 in the measurable case basically proceeds by noting that one can without loss of generality fix one point, say the origin, to be an 'edge' vertex in that it takes two colors" | **MCNP ≥ 6 is a posed question with a known reduction** (Falconer's "edge vertex" plus a forced {1,2}-vertex at an irrational angle) — a finite-witness route, banned this week; J21 reads it as the archimedean corner's state of the art and as a template for the product (a Falconer-type argument on `Γ_S`) |
| 5 | web: "measurable chromatic number of the plane at least 6" | map-type colourings (Jordan-curve regions) need ≥ 6 (Woodall 1973, Townsend 2005; restated in arXiv:2502.01958); polygonal need 7 (`[SokolovVoronov2025]`); measurable `≥ 6` not found | **regular windows at `∞`** with Jordan-region classes need six — so the live five-colour windows at a real place are non-regular measurable ones (sharpens G22) |
| 6 | `[AmbrusEtAl2024]` (bibliography row, second-hand) | "Croft 1967's 0.22936 > 1/5 restated — the density route can never certify measurable χ ≥ 6" | consistent: the count cannot decide Q2-∞ (G24) |
| 7 | zbMATH `ab:"model set" & ab:"chromatic"`; `ab:"cut and project" & ab:"coloring"` | 0, 0 | negative (FS-64 §4's question "has anyone coloured a model set to avoid a distance?": not in zbMATH's reviews in these words) |
| 8 | zbMATH `ab:"Croft" & ab:"unit distance"` | Falconer 1981 (no review text), Tolmachev 2025 (*lower bounds of the density of planar periodic sets without unit distances*) | Croft 1967 itself not indexed under these words; `m₁ ≥ 0.22936` stays second-hand (a debt, J21 cites it as such) |

**What PA.1 teaches about the object (the §PA sweep, WORKFLOW 9):** Q2 is the adelic (several-place) generalisation of the measurable
chromatic number of the plane. Its archimedean slice is open in the descriptive-combinatorics literature (Kechris–Marks) and posed with a
reduction on Polymath16; its product structure is an instance of Borel/measurable Hedetniemi (Kechris–Marks Problem 4.23). So the
honest targets are **(a) the finite-place count, (b) a pullback theorem (measurable Hedetniemi for one compact-circle Cayley factor
against finite-ratio factors)**, and **(c) a Falconer-type argument on the product** — the last being the one route by which the finite
places could make five impossible over `S ∋ ∞` without first settling MCNP ≥ 6 (it would need the finite places to supply what de Grey's
graph could not in Mixon's question). A "no" over every `S ∋ ∞` would prove MCNP ≥ 6 and answer Polymath16's question.

### PA.2 Question 1 — rank-one colouring shifts

| # | query or source | found | verdict |
|---|---|---|---|
| 1 | `[Ellenberg2018]` (read in full at FS-79's gate; bibliography row) | the question is **existence** (a periodic `k`-colouring); in rank 1 it is answered yes by pigeonhole on windows (Lehner; `[EggletonErdosSkilton1990]` Thm 2) | **scope correction to the brief's gloss**: Q1 (`P = F`, inheritance) is *not* Ellenberg's question at `k = 4` on ℤ; it is the forcing form, C3-inherit (row 78's `InheritanceQuestion`), in rank 1 |
| 2 | `[CGHO2025bg]` §6.2.1 (read at FS-79's gate) | decidability of emptiness for ℤ^d with arbitrary generators "not understood"; nothing on rank-1 inheritance | silent on Q1 |
| 3 | zbMATH `ab:"distance graph" & ab:"periodic" & ab:"coloring"` (4 hits) | Zhu 1998 (*Pattern periodic coloring of distance graphs*, JCTB; review read: periods of colourings), Liu–Zhu 2002, Cervantes–Krebs 2025 (colouring periods), Chappell 1998 | the distance-graph literature studies **periods of optimal colourings**, not the forced group; negative on R2 |
| 4 | zbMATH `ab:"uniquely colorable" & ab:"distance graph"` | 0 | negative |
| 5 | zbMATH `ab:"hom-shift" \| ab:"homshift"` | CGHO 2026; Gangloff–Hellouin de Menibus–Oprocha 2026 (block gluing in hom shifts) | hom-shift literature is ℤ², nearest-neighbour; negative on rank-1 arbitrary-generator inheritance |
| 6 | zbMATH `ab:"countable" & ab:"shift of finite type" & ab:"entropy"` | 6 hits, none on colourings | negative; the fact used (a one-dimensional SFT is countable iff it has zero entropy iff every irreducible component is a single cycle) is textbook (Lind–Marcus, recalled, not re-read) |
| 7 | `[EggletonErdosSkilton1990]` review (zbMATH 0698.05033, read): "3) There are finite sets D for which there exists aperiodic proper colourings using only χ(D) colours." | aperiodic optimal colourings exist for some prime `D` | **a prior-art debt that bears directly**: if any of their aperiodic examples sits in a zero-entropy four-colouring shift, it refutes R2. The paper is not held; the twin-prime family `{2, 3, p, p+2}` (χ = 4) lies inside T36's range only for `p ≤ 11`. J18's stage 1 reads their construction (fetch route: `rd.springer.com`, memory note "paper fetch routes") or records it unread |
| 8 | web: colouring shifts of distance graphs, zero entropy, countable | nothing on point | negative |

**What PA.2 teaches:** R2 is not in print in either discipline's words. It is a statement about which one-dimensional SFTs arise as
colouring shifts: countable ⟹ finite. The nearest printed facts are EES's aperiodic colourings (unread) and Lind–Marcus's structure of
one-dimensional SFTs. The distance-graph literature's live questions are *periods*, and a proof of R2 would also say: an all-rigid shift's
periods are finitely many cycles, so `P` has finite index.

### PA.3 Bibliography rows proposed (the front-page lane writes them)

- **`[KechrisMarks2020]`** — held (`~/source/library/pdf/KechrisMarks-descriptive-graph-combinatorics-2020.pdf`); read §4.6–§4.7; role: Q2's
  archimedean corner open in print, and Problem 4.23 (Borel Hedetniemi).
- **`[Polymath16threads]` fourth thread (5 May 2018)** — the MCNP ≥ 6 criterion quoted above; add to the existing row's contents.
- **`[Zhu1998]`** — X. Zhu, *Pattern periodic coloring of distance graphs*, JCTB 73 (1998); review read only.
- **`[Woodall1973]` / `[Townsend2005]`** — map-type colourings need six; listing only (second-hand, arXiv:2502.01958).
- **`[EggletonErdosSkilton1990]`** — its read status stays "review read"; the aperiodic construction is a debt (J18 stage 1).

---

## Stage 4 — SAVED (§IQ, §S, §P)

### IQ.1 Question 1 (FS-76 in rank one) — WORKFLOW 3.3

1. **Existence form.** Is there a finite `D ⊂ ℤ_{>0}` and a proper four-colouring of `G(ℤ, D)` that separates a pair every periodic
   four-colouring identifies (`P₄(D) ≠ F₄(D)`)?
2. **Structural form.** *What can the space of all proper `k`-colourings of a Cayley graph of ℤ be, as a one-dimensional shift of finite
   type?* Posed for every finite `D` and every `k` (at `k = 3` the height answers it, T24; at `k = 4` it is open), with no arithmetic:
   **is every countable `k`-colouring shift of a distance graph finite** — equivalently, does every wall between phases come with
   entropy?
3. **The invariant it forces.** Every colouring carries its **pair of limit phases** (α- and ω-limit cyclic components) and, through
   them, a place in the **phase graph** (cyclic components ordered by walls), which is acyclic by definition, reversed by the reflection,
   and permuted by the colour group. What is missing is an invariant that **orders phases so that reflection and colour permutations
   cannot both respect it** — none known; finding it (or a Kempe move that reverses a wall, K3) is the milestone. At three colours the
   height's slope is that invariant.
4. **Route.** Derivation only (J18). An exact check may verify a derived claim: a constructed `D`'s window graph, computed once.
5. **Open instances it would decide.** The chiral rigid–rigid walls of FS73-T30's sets (which exist beside entropy: the controls); every
   `D` beyond T36's range, FS85-dB2's `|D| = 70` graph among them (all rigid, no wall: a positive control); `[EggletonErdosSkilton1990]`'s
   aperiodic `χ(D)`-colourings (unread); and, through T6/T7's product constructions, every rank-`r` graph periodic in `r − 1` directions
   (T34's class).

### IQ.2 Question 2 (FS-64 at five colours over ℚ(√167)) — WORKFLOW 3.3

1. **Existence form.** Is there a finite set `S` of places of `F = ℚ(√167)` and a proper five-colouring of `Γ_S` with measurable
   classes (so that `r ↦ W(ι_S(r) + t)` five-colours `F²` for every `t`)?
2. **Structural form.** *For a product `Γ_S = ∏ Cay(G_v, T_v)` of Cayley graphs of locally compact abelian groups with compact
   connection sets, what is every measurable proper `k`-colouring?* In the most general class, arithmetic stripped: **is every measurable
   proper `k`-colouring of `A × B` almost everywhere a pullback from `A` when `B`'s measurable independence ratio is below `1/k` and
   `A`'s is not?** — the measurable form of Hedetniemi's question (`[KechrisMarks2020]` Problem 4.23) in the Cayley class, with the
   count (Zhang's product rule) as its known half.
3. **The invariant it forces.** Known half: the colour-class densities and each factor's measurable independence ratio (the count).
   The other half: the **fibre map** `b ↦ W(·, b)`, a measurable family of colourings of `A` indexed by `B`, and at the archimedean
   factor Falconer's **edge vertex** (a Lebesgue-density point shared by two classes). An invariant forcing the fibre map to be
   constant (a pullback) at five colours is not known; finding one, or the obstruction, is the milestone.
4. **Route.** Derivation only (J21). No LP, no relaxation (the 43-adic all-levels certificate is a machine-long run: banned).
5. **Open instances it would decide.** `χ_µ(ℝ²) ≥ 6` (open, `[KechrisMarks2020]` §4.7; Polymath16's fourth thread) — only as its
   `S = {∞₁}` slice, never as J21's target; five at ℚ(√167) over finite-place `S` (43 at depth, the dyadic places); `χ_µ` of `ℝ² × ℝ²`
   against `ℝ²` (the two real places); the same questions at ℚ(√47) at four colours are already closed (FS86-CL1).

### S. The stages as jobs

> **Correction owed (2026-09-25 crunch):** see `plans/M3-S1A-rank-one.md` §2.4; carried in `plans/M3-close-inventory.md` row 9. Not applied here; the close rewrites this entry.

| job | kind | question | record | stages (harness k) | stop rule |
|---|---|---|---|---|---|
| **J18** | derivation | Q1 | `plans/M3-S1A-rank-one.md` | 1 quotation check + C0 + inputs (60); 2 A-K0–A-K2 and A-T1′ (80); 3 the chiral case: A-T1 or A-C (100); 4 claims, reviewer's view, report (40) | the gate at ~2.5 h: a proof, a counterexample, or a stall at a named step, saved |
| **J19** | derivation, conditional | the step J18 names | `plans/M3-S1B-rank-one.md` | skeleton only (brief file) | launched only on a named stall |
| **J20** | blind verifier | J18's or J19's claims, fixed list below | `plans/M3-S1V-rank-one.md` | B1 blind (150); B2 lemma statements, only if B1 stalls (100); B3 divergence table (50) | a verdict per claim |
| **J21** | derivation | Q2 | `plans/M3-S1D-windows-five.md` | 1 quotation check + C0 + inputs (60); 2 D0, D1 (80); 3 D2, D3 (100); 4 D4, claims, report (40) | the same |
| **J22** | blind verifier | J21's claims, fixed list below | `plans/M3-S1V-windows-five.md` | B1, B2, B3 as J20 | a verdict per claim |

**Definitions for Q1 (J18's and J20's briefs quote these):** for finite `D ⊂ ℤ_{>0}`, `G(ℤ, D)` has vertex set ℤ and `x ~ y` iff
`|x − y| ∈ D`; `X_k(D) ⊆ [k]^ℤ` is the set of proper `k`-colourings; with `m = max D`, the **window-state graph** has as vertices the
words of length `m` occurring in some point of `X_k(D)`, and an edge `w → w′` when `w′` is `w` shifted by one position inside an
`(m+1)`-word occurring in some point; a **phase** is a strongly connected component containing a cycle, **rigid** if it is a single
cycle; a **wall** is a path from one phase to a different phase; `F_k(D)` is the set of `δ ∈ ℤ` with `c(x) = c(x + δ)` for every
`c ∈ X_k(D)` and `x`, and `P_k(D)` the same over the periodic `c`. (FS79-T35 states its criterion with phases taken modulo colour
permutation; the claims below hold in either form, and a derivation says which it uses.)

**Q1's target statements (J20's fixed list; verbatim).**
- **A-T1 (R2).** "For every finite `D ⊂ ℤ_{>0}`, if every phase of the window-state graph of `X₄(D)` is rigid, then no wall exists."
- **A-T1′.** "For every finite `D ⊂ ℤ_{>0}`, `X₄(D)` is finite or has positive topological entropy."
- **A-T2.** "For every finite `D ⊂ ℤ_{>0}`, `P₄(D) = F₄(D)`."
- **A-K0.** "If every phase of `X₄(D)` is rigid, then every periodic `c ∈ X₄(D)` has all four colours on the closed neighbourhood of
  every vertex, and every two-colour Kempe component of `c` is infinite."
- **A-K1.** "If every phase of `X₄(D)` is rigid and `X₄(D) ≠ ∅`, then `χ(G(ℤ, D)) = 4`."
- **A-K2.** "If `c ∈ X₄(D)` and for every `x ∈ ℤ` the colours `{c(x − d) : d ∈ D} ∪ {c(x)}` are all four colours, then every
  `c′ ∈ X₄(D)` that agrees with `c` on `{y : y < x₀}` for some `x₀` equals `c`; so a wall leaves a phase `C` only through a state at
  which the next colour is not determined by the window."
- **A-Kq.** "Every phase of the window-state graph of `X₄(D)` is rigid iff every phase of its quotient by colour permutations is rigid,
  and a wall exists in one iff it exists in the other."
- **A-K3 (the reversal lemma).** "If every phase of `X₄(D)` is rigid, then for every wall from a phase `C` to a phase `C′` there is a
  wall from `C′` to `g·C` for some colour permutation `g`." (With FS79-T34's orbit step it gives A-T1.)
- **A-C.** "There is a finite `D ⊂ ℤ_{>0}` (named) such that every phase of `X₄(D)` is rigid and a wall exists." (the alternative to
  A-T1; with T35 it gives `P₄(D) ≠ F₄(D)`)

**Definitions for Q2 (J21's and J22's briefs quote these, and FS86-Cx-C14 and FS86-CL1 verbatim):** `F = ℚ(√167)`; `S` a finite set
of places of `F`; for `v ∈ S`, `G_v = F_v²` and `T_v = {(x, y) ∈ F_v² : x² + y² = 1}`; `G_S = ∏_{v ∈ S} G_v`, `T_S = ∏_{v ∈ S} T_v`,
`Γ_S = Cay(G_S, T_S)`; `ι_S : F² → G_S` the diagonal embedding. A **measurable window `k`-colouring over `S`** is a map
`W : G_S → [k]` whose classes are Haar-measurable and which is proper on every edge of `Γ_S` (`W(g) ≠ W(g + t)` for all `g ∈ G_S`,
`t ∈ T_S`); each `r ↦ W(ι_S(r) + t)` is then a proper `k`-colouring of `F²`. (C14's own format also allows finite levels at finite
places and C14′'s "proper off a null set"; a derivation says which format each claim covers — a.e.-properness does not give properness on
the countable set `ι_S(F²) + t`.)

**Q2's target statements (J22's fixed list; verbatim).**
- **D0.** "A measurable window five-colouring over `S = {∞₁}` is exactly a proper five-colouring of the unit-distance graph of `ℝ²`
  with Lebesgue-measurable classes; for every finite `S` containing a real place, a measurable proper five-colouring of that graph pulls
  back to a measurable window five-colouring over `S`. Hence no measurable window five-colouring over any `S` containing a real place
  implies `χ_µ(ℝ²) ≥ 6`."
- **D1.** "For every finite set `S` of places of ℚ(√167) containing no real place, if every local graph `Γ_v`, `v ∈ S`, has
  measurable independence ratio `< 1/5`, then no measurable window five-colouring over `S` exists."
- **D1-fac.** "At ℚ(√167) the local graph has measurable independence ratio `< 1/5` at 23 (FS-66's all-levels certificate), at every
  stable odd place `p ≥ 59` (the level-one Hoffman ratio, constant up the inert tower), at the ramified place 167 (Lemma P), and at every
  odd split place (C14.2 (c))."
- **D1-43.** "The 43-adic local graph of ℚ(√167) has measurable independence ratio `< 1/5`." (or: open, with the missing step named)
- **D1-2.** "Each dyadic place of ℚ(√167) (split in `F(i)/F`) has local graph of measurable independence ratio `< 1/5`." (or: open,
  named)
- **D1-3.** "At ℚ(√167) the place above 3 is split in `F(i)/F`, so FS-64's configuration (ii) contributes a factor of measurable
  independence ratio 0."
- **D2(a).** "Let `A` be the unit-distance graph of `ℝ²` and `B` a product of finitely many of ℚ(√167)'s finite places' local graphs,
  every factor of `B` of measurable independence ratio `< 1/5`. Then `A × B` has a measurable proper five-colouring iff `A` does." (or
  its failure, at a named step)
- **D2(b).** The same with `A` the categorical product of the unit-distance graphs of `ℝ²` at the two real places.
- **D3.** "`χ_µ(Γ_{∞₁} × Γ_{∞₂}) = χ_µ(Γ_{∞₁})`" (or the named obstruction)
- **D4.** "C9's colouring `⌊4θ⌋` over ℚ(√11) is a measurable window four-colouring over `{∞, 7}` that is not a pullback from one
  factor; and the hexagonal seven-colouring is a measurable window seven-colouring over `{∞₁}` of every real field." (the format's
  inhabitants)

### P. Registered predictions (before J18 or J21 runs; scored by the close; both outcomes of each confirmed reachable)

| id | prediction | prior | reachable both ways? |
|---|---|---|---|
| P-A1 | J18 proves A-T1 (so A-T1′, A-T2) | 0.25 | yes: a proof, or its failure |
| P-A2 | J18 proves A-C (a counterexample, constructed and exactly checked) | 0.10 | yes: construction is in scope |
| P-A3 | J18 stalls at a named step with A-K0, A-K1, A-K2 proved | 0.55 | yes |
| P-A4 | less than P-A3 | 0.10 | yes |
| P-A5 | given P-A1, the proof holds for every `k ≥ 4` | 0.50 | yes |
| P-A6 | `[EggletonErdosSkilton1990]`'s aperiodic colourings, if read, all sit in positive-entropy shifts | 0.85 | yes (reading decides) |
| P-D-a | a measurable window five-colouring of ℚ(√167)'s plane is constructed (**falsifies the conjecture's ≥ 6**; over `{∞₁}` alone it would prove `χ(ℝ²) ≤ 5`) | 0.02 | yes, by construction |
| P-D-b | a full no over every finite `S` (would prove `χ_µ(ℝ²) ≥ 6`) | 0.03 | yes |
| P-D-c | D0 and D1 with at least one named gap closed, and D2 proved | 0.20 | yes |
| P-D-d | D0 and D1 with gaps named; D2 not proved, its obstruction named | 0.55 | yes |
| P-D-e | less than P-D-d | 0.20 | yes |
| P-D-3 | D1-3 holds (3 is split at ℚ(√167)) | 0.95 | yes (a one-line check) |
| P-D-2 | the dyadic split places' ratio is shown `< 1/5` (C14.2 (c) at `p = 2`) | 0.60 | yes |
| P-D-43 | 43's all-levels ratio shown `< 1/5` by hand this crunch | 0.10 | yes |

**Scoring rule, fixed now (M44):** a prediction is scored on the committed claim list and the verifier's verdicts, never on a record's
prose; a GAP verdict on the deciding step scores the claim as not landed.

---

## Stage 5 — SAVED (§M, §X; the briefs)

### M. The modeling passes (fresh Skill invocations: `debruijn-domain-modeling`, then `debruijn-obligation-modeling`, applied to §S's statements; no Lean this milestone, so the passes act on the statements and the obligation trees)

> **Correction owed (2026-09-25 crunch):** see `plans/M3-S1A-rank-one.md` §2.1 and §2.4, and `plans/M3-S1D-windows-five.md` §3.6; carried in `plans/M3-close-inventory.md` rows 9, 10, 20. Not applied here; the close rewrites this entry.

**Domain pass — what changed in §S.**
1. *The quotient seam* (the placement cut): FS79-T35 reads phases modulo colour permutation, T36's tool computes in the quotient, and the
   stub states R2 without saying which. Both forms are equivalent (a single cycle's preimage in the colour cover is a disjoint union of
   cycles, since an edge's lift is determined by its source; a quotient path staying on a cycle lifts to one cycle) — minted as **A-Kq**,
   a one-line obligation, so that no verifier finds a spurious gap between the two readings.
2. *A-K2 was trivial as first written* (it said only that a branching position misses two colours, true of any `c`, periodic or not):
   restated as the **rank-1 form of FS86-dB-H** — a colouring that is "left-gap-free" everywhere admits no continuation but itself — which
   is the statement that names *where* a wall can leave a phase.
3. *Unsampled members*: `X₄(D) = ∅` (A-T1, A-T1′, A-T2 hold vacuously; A-K1 carries `X₄(D) ≠ ∅`); `S = ∅` in Q2 (the empty product
   has a loop at 0, no proper colouring, consistent); the inhabitants the claims ship are `{1,2,3}` (one rigid phase, no wall),
   FS85-dB2 (24 colourings, rigid, no wall), FS73-T30's `{1,5,7,10}` (walls beside entropy: the negative control for any wall
   detector), the hexagonal seven-window and C9 (D4).
4. *Two statements in one*: D1 mixed a conditional theorem with an unsettled factor table, and D2 mixed one real place with two — each
   split (D1, D1-fac, D1-43, D1-2; D2(a), D2(b)) so that a verifier's verdict attaches to one claim.
5. *Adversarial member for D0*: a colouring proper only off a null set satisfies C14′'s format and says nothing on the countable set
   `ι_S(F²) + t`; §S's definition requires properness on every edge of `Γ_S`, and every claim says which format it covers.

**Obligation pass — the trees handed to J18 and J21.**
- **A-T1 ⟸ A-K3 + FS79-T34's orbit step**: if every wall `C → C′` has a return wall `C′ → gC`, then `C → C′ → gC → gC′ → g²C → ⋯`
  closes in the finite phase graph, a cycle through distinct phases, contradicting their being distinct strongly connected components.
  So **A-K3 is the milestone's one hard obligation**, and T34 is its achiral case. The local obligations beneath it: A-K0 (entropy
  lemmas: a fan gap or a finite Kempe component in a periodic colouring makes a detour, hence a second cycle), A-K1 (the spare-colour
  entropy floor, row 45), A-K2 (where a wall can leave), A-Kq. Two candidate moves for A-K3's chiral case, named for J18 as routes and
  not as claims: **(i) a Kempe swap on a one-sided component** (a Kempe component of the wall colouring bounded on one side, swapped,
  moves one end of the wall to a colour-permuted phase), and **(ii) a reflection-invariant potential** (any function on phases, invariant
  under reflection and colour permutations, that strictly decreases along walls contradicts a wall at once — so A-K3's failure would have
  to be witnessed by a phase graph admitting no such function). *Validation:* at `k = 3` A-T1 is true (T24: no walls at all), so any
  argument for A-K3 must not use `k = 4` where `k = 3` would refute it — J18 states at which step `k = 4` enters (P-A5).
- **A-C's checklist** (a counterexample candidate must meet each before an exact check is priced): its phases chiral (T34), its periodic
  points gap-free with infinite Kempe components (A-K0), `χ(G(ℤ, D)) = 4` (A-K1), a branching state (A-K2), no return wall (A-K3 false
  for it). The construction tool is FS85-dB1's embedding lemma (row 86).
- **D1** is C14.1 + C14.3 at `k = 5` (the count, free) plus the factor table **D1-fac**, one local obligation per factor; the two open
  leaves are D1-43 (the fibre-share relaxation at 43 is priced out and banned; a hand bound from `⟨φ, A₁φ⟩ ≤ 2Σφ(1 − φ)` alone recovers
  only Hoffman's ratio, which is ≥ 1/5 at 43 — the planner's one-line check, so a hand route needs a sharper inequality) and D1-2
  (C14.2 (c) at `p = 2`).
- **D2(a)'s obligation tree, with its likely failure named.** "⟸" is the pullback (free). "⟹" by induction on the colour count with the
  factor `A` generalised to its measurable induced subgraphs `A′` (Gries's fresh variable): at `j ≤ 5` colours some class has relative
  density `≥ 1/j > β` (B's ratio), and **if** an independent set of `A′ × B` of relative density `> β` is a.e. a cylinder `I × B`
  (a measurable, stability form of `[Zhang2012]` Thm 1.8(i)), removing it leaves a `(j−1)`-colouring of `(A′ ∖ I) × B`, and the induction
  closes. **The named hard step:** Zhang's theorem is for vertex-transitive factors, and `A′` leaves that class after the first step — so
  the cylinder lemma for non-transitive `A′` is where D2(a) will stand or fall. J21 attacks it first.

### X. The would-have-searched log (the planner's)

| # | the move a search would have made | what was done instead |
|---|---|---|
| X1 | extend T36's rank-1 scan past `max D = 14`, `\|D\| ≤ 5`, hunting a zero-entropy shift with a wall | not run (the ban); R2 restated as "countable ⟹ finite" and decomposed into A-K0–A-K3 for derivation; FS85-dB2 cited as an out-of-range inhabitant |
| X2 | compute window graphs of FS73-T30's four wall sets to classify their walls as `C → C^R` or not | not run; J18 may compute them once, as a check of a derived claim about chirality, logged at the ban's edge |
| X3 | run FS-66's second-level relaxation at 43 to certify the all-levels ratio `< 1/5` | not run (a machine-long certificate, banned; 84 GPU-days); D1-43 left to hand derivation or named open |
| X4 | search Polymath16's MCNP ≥ 6 criterion (a five-colouring of `V_A ⊕ V_A ⊕ V_A` with a forced {1,2}-vertex) | not run; quoted in §PA as the archimedean corner's state of the art |
| X5 | read `LEDGER.md` § B in full | read by keyword scan (rank-1, entropy, measurable, window, Kempe, periodic, distance graph): budget; every § B entry the derivations cite is named in their briefs by id |

**The briefs written at this stage** (under `data/crunch-2026-09-25/briefs/`): `J18-M3-rank-one-derivation.md`,
`J19-M3-rank-one-second-mind-SKELETON.md` (two slots the owner fills from J18's stall), `J20-M3-rank-one-verifier.md` (fixed list = §S's
Q1 statements, quoted, route parentheticals removed), `J21-M3-windows-five-derivation.md`, `J22-M3-windows-five-verifier.md` (fixed list =
§S's Q2 statements). Every brief carries the no-children rule with its reason, the resume paragraph, the ban and the would-have-searched
log. **The planner's check behind D1-43** (float character sums, seconds): level-one Hoffman ratios `0.24908` (23), `0.21376` (43),
`0.19912` (59).

## Where the 2026-09-25 work on this lives

*Addresses and titles only, added by the 2026-09-25 crunch's bookkeeper (job J30). The index of that day's work, with its results, is `plans/CRUNCH-2026-09-25-INDEX.md`; a blind verifier does not open it.*

- the jobs' records: `plans/M3-S1A-rank-one.md` (J18), `plans/M3-S1D-windows-five.md` (J21), `plans/M3-S1B-rank-one.md` (J19, in progress); the verifiers' records `plans/M3-S1V-rank-one.md` (J20) and `plans/M3-S1V-windows-five.md` (J22) when they run
- tools `tools/crunch_j18_*`, `tools/crunch_j21_*`; data `data/m3/j18/`, `data/m3/j21/`
- reports `data/crunch-2026-09-25/reports/J06.md`, `J18.md`, `J21.md`; close inventory `plans/M3-close-inventory.md`
