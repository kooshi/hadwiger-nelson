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

> **Correction owed (2026-09-25 crunch):** see `plans/M3-S1D-windows-five.md` §1.1 (Q7); carried in `plans/M3-close-inventory.md` row 19. Not applied here; the corrected text is §R-close R4.C.1.

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

> **Correction owed (2026-09-25 crunch):** see `plans/M3-S1A-rank-one.md` §2.4; carried in `plans/M3-close-inventory.md` row 9. Not applied here; the corrected text is §R-close R4.C.2.

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

> **Correction owed (2026-09-25 crunch):** see `plans/M3-S1A-rank-one.md` §2.1 and §2.4, and `plans/M3-S1D-windows-five.md` §3.6; carried in `plans/M3-close-inventory.md` rows 9, 10, 20. Not applied here; the corrected text is §R-close R4.C.3–R4.C.5.

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

---

## §R-close — M3's close (crunch job J23c, de Bruijn, Opus 5.5, 2026-09-25)

*Brief: `data/crunch-2026-09-25/briefs/J23c-M3-close-math.md`, with J23a's brief as its template and `STANDING-RULES.md`. Worked from
`plans/M3-close-inventory.md` (this job is its only writer while it runs), the five job records (`plans/M3-S1A-rank-one.md` J18,
`plans/M3-S1B-rank-one.md` J19, `plans/M3-S1V-rank-one.md` J20, `plans/M3-S1D-windows-five.md` J21, `plans/M3-S1V-windows-five.md` J22 and
J22b), the reports in `data/crunch-2026-09-25/reports/`, and `plans/CRUNCH-2026-09-25-INDEX.md` §3. Every number below is read from its
source record, never from the inventory. Drafts for `LEDGER.md`, `CLAUDE.md`, `plans/FRONTIER-STUBS.md` and stub banners live in this
section only; a front-page job applies them. Nothing here judges a verdict a record reached: each is filed at its grade and status.*

### Stage 1 — SAVED (the quotation check; the inventory walk)

#### R1.1 The quotation check (standing rule 5): every quotation or attributed statement in the J23c brief and the owner's launch message

| # | quotation or statement (brief / launch message) | source | result |
|---|---|---|---|
| 1 | Q1 "is every countable four-colouring shift of a distance graph on ℤ finite (R2, A-T1)?" | this plan §IQ.1 item 2 ("is every countable `k`-colouring shift of a distance graph finite"); §S A-T1′ | faithful (the brief fixes `k = 4`, as A-T1′ does) |
| 2 | "A-T1 is open at a named step, reached three times" | J18 §3.5 (GAP at KE); J19 §2.8 item 3 (GAP at KT's transport step; A-T1 = FW ∧ A-T1ⁿᶠ); J20 §2.4 (GAP, "the missing step, verbatim") and §3.4 | faithful: three stalls, reached by three agents; the three named steps differ in wording, and J20 §3.4 identifies its own with J19's FW plus the non-frozen half |
| 3 | Q2 "the verdicts agree, with gaps at D1-43 and D2(a)/(b)" | J22 §4.2 row 1: "**no divergence of truth on the fixed list**"; J21 §4.2 | faithful |
| 4 | "J22's first run was killed by its own 8 GiB slot cap (exit 137 at step 6/7, peak 8.38 GB …)" | J22 §4.4 ("exit 137 at 44:34 wall, peak RSS 8,383,092 kB — the slot's own 8 GiB cap killed it in step 6/7 (representative 220 of 266)"); `data/m3/j22/fs66-cert-p23-m5.time` ("Maximum resident set size (kbytes): 8383092") | faithful (8,383,092 kB is 8.38 GB decimal, 7.99 GiB) |
| 5 | "D1-fac's clause at 23 rests on row 75's recorded certified verdict either way" | J22 §4.4 last sentence | verbatim in substance |
| 6 | "J19's enumeration of 94 rigid points of `X₄({2,6,11,13,14})`" | J19 §2.6, §1.5 ("at the ban's edge, logged") | faithful |
| 7 | "J20's declined residue step mod 20, which the owner ruled waits for 2026-10-01" | J20 §3.4 ("It is **not run here**: it scaffolds a counterexample search, which is the owner's call under the ban"); the ruling itself has no other written source than this brief | the declined step: faithful. **The ruling is logged here as an owner ruling (inventory row 60), source: the J23c brief** |
| 8 | "J21-MX (a spectral form of Burr–Erdős–Lovász; Hedetniemi for special factors; Kechris–Marks Problem 4.23)" | J21 §3.2 "Prior art and the classical case" | faithful |
| 9 | "`[EggletonErdosSkilton1990]` is unheld (Kooshi asked)" | inventory row 38; `~/source/library/pdf/` listing (2026-09-25 18:16: the 1985 paper held, the 1990 paper absent) | faithful |
| 10 | "`[Zhu2021]`-type items the records list" | J22 §3.5 and report ("`[77]` (Zhu, JCTB 2021, Thm 3.5) not held"); `tools/bib_audit.py` lists `[Zhu2021]` undefined, first seen in this brief | faithful; a bibliography row is owed (inventory row 51) |
| 11 | launch message: "its last line reads `exit=<code>` when done, about 45–50 minutes from 18:25" | `data/m3/j22/fs66-cert-p23-m5-rerun.out` (at 18:16 by `date`: steps 1–4 passed); `scripts/slot.py --status`: a 16 GiB `python3` slot, age 130 s | consistent (the machine clock read 18:16 when the rerun was 2 minutes old; the estimate stands) |

No quotation in the brief is wrong. One precision (row 7) is logged as an owner ruling.

#### R1.2 The inventory walk

- **Added (rows 41–66):** the J20 and J22/J22b reports' inventory lines and held items, which no clerk had folded; the owner's rulings
  carried by the J23c brief; the FS-66 re-run; the bibliography-audit finding for `[Zhu2021]`.
- **Ticked at this stage:** the rows fully disposed of by being recorded (owner rulings, the held items the owner has already ruled on, the
  59 margin now settled exactly). **Routed:** every other row names the stage that disposes of it (2 = the derivation file; 3 = the
  re-reads, predictions, tallies, the ban measurement and the prior-art gate; 4 = the drafts).
- **A limit of this job, stated once:** three "Correction owed" banners in this plan (§PA.1, §S, §M) say "the close rewrites this entry".
  This job may touch only §R-close, so the corrected text is given in §R-close (stage 4, R4.C) and the banners stand, pointing through the
  inventory to it. Held for the owner.

#### R1.3 The FS-66 checker re-run at 23 (pending at this stage)

`scripts/slot.py --mem 16 --cpus 1 -- python3 tools/fs66_b1_cert_check.py data/fs66/b1/cert-p23.json --m 5`, log
`data/m3/j22/fs66-cert-p23-m5-rerun.out`; at this save it had passed steps 1–4 of 7. Its verdict is read and filed at a later stage (R2.x).

#### R1.4 Would have searched here (this job)

| # | the move a search would have made | what was done instead |
|---|---|---|
| — | none at this stage | — |

### Stage 2 — SAVED (the derivation file)

*Theorems this phase proved (J23c):* none — the close files the jobs' theorems; it proves nothing of its own.

- **`plans/M3-derivation.md` written:** 46 entries in ten sections — Q1's one-dimensional facts and equivalences (§1: F2, F3, T35W, EQ,
  DC), its local lemmas (§2: K0loc, K0H, AK1, AK2, AKq, CUT), its Kempe structure (§3: KE⟹, KC, ENDS, FRZ, KEF, KT, TW, BIN), its tools
  entries (§4: J18-CTL, J18-DPR, J19-CTL, J19-AF✗, J20-NAMED); Q2's corner, count and factor table (§5: D0, D1, D1fac, D1-3, D1-2, D1-43p,
  J22-T10, J22-T1, J22-T2), its products and obstructions (§6: SL, D3, MX, UNIF, TH, J22-T8, RED, D2p, NG1, NG2, NG3, D4); the FS-66
  re-run (§7, pending at this save); the planner's statements mapped (§8); what stays open (§9); the kernel decisions (§10).
- **Every "Theorems this phase proved" line of every M3 record has an entry or an explicit merge:** J18's 11 lines (F3, K0loc, K0H, AK1,
  AK2, AKq, EQ, DC, CTL, DPR, KE⟹), J19's 9 (KC, ENDS, FRZ, KEF, TW, BIN, CTL, AF✗, KT), J20's 18 (W, E1, E2, T35W, EQ, RET, K0, K1, K2,
  Q, CUT, KC, FRZ, KEF, TW, BIN, DC, NAMED — merged into J18's and J19's entries except T35W, CUT and NAMED, which are their own), J21's
  16 (D0, D1, D1fac, D1-3, D1-2, D1-43p, SL, D3, MX, TH, RED, D2p, NG1, D4, NG2, and NG3 from §3.6's body), J22's 13 (T1–T13: T3 → D1-2,
  T4 → NG3, T5 → D3, T6 → MX, T7 and T9 → D2p, T11 → SL, T12 → NG1, T13 → NG2; T1, T2, T8, T10 their own). J21-UNIF is filed from J21 §2.6
  (b) and §3.3 and J22 §2.2, where it is stated but not in a theorems table. The plan's J06 statements are §8's map (no theorems table:
  inventory row 28).
- **Where the records differ, both are filed** with their addresses: J19-KC's `N` (J20's reading), J21's five headline scopes (J22 §4.2),
  59's grade (float → exact), J18-DPR's KE clause (unverified by J20), J19-ENDS clause 2 (the reading that makes it true is J19's own).
- **Independence recorded per entry.** Two derivations (or two tools) for 38 of the 46; one mind for J20-CUT, J22-T10, J22-T8 (a classical
  bound re-derived) and J18-EQ's second clause; single tools runs for J18-CTL, J18-DPR (each partly confirmed by J20), J19-CTL and
  J20-NAMED; M3-CHK23 pending.

### Stage 3 — SAVED (the re-reads, G72's count, the predictions, the verdict, the tallies, the ban measurement, the close's prior-art gate)

#### R3.1 §G re-read — which extractions paid, which entry should have borne

**Paid (Q1).** G46 (name it: one-dimensional SFT) gave the whole frame — F3's "countable ⟺ zero entropy ⟺ all phases single cycles" and
J18-DC's move from `D` to single colourings. G13/G42 gave K0, proved in a stronger local form (K0loc: one rigid phase suffices). G27
(use every automorphism) is where TW sits: reflection and `S₄` close the achiral case (FS79-T34), and the chiral case stayed exactly the open
case. G21 was honoured three times: J18's C0 note that T36's 377/377 may measure achirality; J19-AF✗ run on one `D` chosen by a stated rule;
J20's "the scan's null measures its range". G30 mode 5 (inhabitants: `{1,2,3}`, FS85-dB2, `{1,5,7,10}`) was used by every Q1 job. G51: J19
launched only on J18's named stall, and **three minds met one wall** (J18 at KE, J19 at KT, J20 at its own step, identified by J20 with J19's
FW) — G51's licence for a negative is used exactly as far as it reaches: a proved no-go of a *format* (FW is invisible to every Kempe
argument, J19-FRZ), never a claim that A-T1 is false.

**Paid (Q2).** G54 ("no tight place at five; the count is the only engine") was right about the count and wrong about "only": J21-MX is a
third engine, **mixing** (`λ*`, both signs of the spectrum), which the plan did not foresee (J21 C0 note (b); §4.4 "not foreseen"). G56/G66
predicted D1-43's GAP exactly (43's all-levels ratio uncertified, the relaxation banned). G1/G35 aimed D1-2 (the dyadic place split),
closed by two minds. G24/G43 (integrality gap at the real factor) predicted that no density argument decides Q2-∞ — confirmed by D2's
GAP-2 and NG2. G22/G29 bounded the scope (polygonal real windows need seven). G48's falsifiable line (P-D-a) did not fire.

**Should have borne and did not (instances for WORKFLOW 3.1).**
1. **G44/G54's *Do* — "compute the spectrum first" — bore on D2's hypothesis and was read only for tightness.** The plan wrote D2 with a
   counting hypothesis ("every factor of `B` of measurable independence ratio `< 1/5`"); J21 and J22 each found independently that a
   selection needs a spectral one (`λ* < 1/4`, the largest non-trivial `|eigenvalue|`, not `λ_min` alone), and NG2 shows ratio alone
   fails at 125 colours. The spectrum was on the table (G44's Kloosterman eigenvalues) for the sign of `λ_min`; its absolute value was the
   quantity the pullback needed.
2. **`[Zhang2012]` Thm 1.8, held and read in full, was applied past its statement** (G50's "held paper" instance in reverse): its
   MIS-normality is about **maximum** independent sets; the plan's cylinder lemma asked it of any set of density `> β`, and a five-colouring's
   classes are not maximum (`5m₁ > 1`; J21 §3.6). NG1 and J22-T12 refute the lemma in both readings.
3. **The prior-art neighbour of the cylinder lemma was not searched:** `[AlonDinurFriedgutSudakov2004]` (maximum and near-maximum
   independent sets of weak products are cylinders, with stability, by Fourier analysis — found by this close's gate, R3.10) is the
   discipline's own form of the lemma the plan invented; its stability is near the maximum, which is exactly why a density-`> β` form fails.
4. **LEDGER § B was read by keyword scan** (plan §X X5, inventory row 27); no § B entry was missed that a record later needed (checked
   against the records' input lists: FS86-dB-H, FS86-LP, FS86-Cx-C9, C14, FS66-T8, FS79-T6/T34/T35/T36, FS73-T24/T30, FS85-dB1/dB2 — every
   one was named in the briefs by id).

#### R3.2 §PA sweep — what M3 learned about what its objects ARE

- **Q1.** A four-colouring shift of `G(ℤ, D)` whose phases are all rigid is **Kempe-rich, not frozen** (J19-AF✗, J20-NAMED: no frozen
  rigid point on any of six named sets); R2 is a statement about **single heteroclinic colourings** (J18-DC), and the Kempe method splits it
  exactly into **FW** (walls between frozen points: invisible to every Kempe argument) and the rest (KT). → a grokking draft (R4.G, G77).
- **Q2.** At ℚ(√167) the five-colour window question is **local at twelve places plus ∞**: every other place is invisible (removable
  without loss, Borel), because what a place contributes to a product colouring is governed by its compact pieces' **mixing constant**, not
  its independence ratio (MX, TH, RED, NG2). The barrier prime's place is a split place — the count's best factor and a non-mixing one.
  → folded into G76's draft (R4.G) and FS-64's re-aim.
- **In the discipline's words:** J21-MX is a spectral (expander-mixing) form of Burr–Erdős–Lovász's `χ(G × K_n) = min(χ(G), n)`, in
  Borel/measurable form — a positive special case of `[KechrisMarks2020]` Problem 4.23 (their Borel Hedetniemi problem) for pairs with one
  mixing compact abelian Cayley factor. Its prior-art position is R3.10; a `CLOSED-QUESTIONS.md` entry stays a candidate (a positive special
  case of an open problem is not an answer to it).

#### R3.3 §IQ re-read and G72's count

- **Q1's structural form** ("what can the space of all proper `k`-colourings of a Cayley graph of ℤ be, as a one-dimensional SFT —
  countable ⟹ finite?") produced every Q1 result: the equivalences, DC, KC, FRZ/KEF, KT and the FW split are statements about every
  colouring of the shift, by derivation, with no search. **The invariant it asked for was not found** — none orders phases so that
  reflection and colour permutations cannot both respect it — and FW is a proof that no Kempe-move invariant can be it. *Came through the
  structural question: yes; invariant: none known.*
- **Q2's structural form** ("is every measurable proper `k`-colouring of `A × B` a.e. a pullback from `A` when `B`'s measurable independence
  ratio is below `1/k`?") was answered **no as posed** (NG1 refutes the cylinder route; NG2 refutes ratio-only schemas at 125 colours) and
  **yes with mixing in place of ratio** (MX, Borel exactly, measurable into N′). **The invariant it forced is named:** the fibre map's
  classes above the mixing threshold `λ*/(1 + λ*)` — a spectral invariant of the factor, local in the fibre. *Came through the structural
  question: yes; invariant: found.*
- **G72's count:** M3 adds two data points, both through the structural question (Q2's with its invariant). The running number is
  assigned by the front-page job, which orders M1's (FS-91) and M3's counts; nothing came from a search or a tool extension.

#### R3.4 The predictions, scored once (scoring rule: plan §P — the committed claim list and the verifiers' verdicts; a GAP on the deciding step is "not landed")

| id | prediction | prior | outcome |
|---|---|---|---|
| P-A1 | J18 proves A-T1 | 0.25 | not landed |
| P-A2 | J18 proves A-C | 0.10 | not landed (the one derived candidate keeps a non-rigid phase) |
| P-A3 | J18 stalls at a named step with A-K0, A-K1, A-K2 proved | 0.55 | **landed** (J18 §3.5; the three lemmas TRUE by J20 blind) |
| P-A4 | less than P-A3 | 0.10 | not landed |
| P-A5 | given P-A1, the proof holds for every `k ≥ 4` | 0.50 | not reached (P-A1 not landed); J18 records that no lemma uses `k = 4` |
| P-A6 | EES's aperiodic colourings sit in positive-entropy shifts | 0.85 | **unscorable** (`[EggletonErdosSkilton1990]` unheld) |
| P-D-a | a window five-colouring constructed | 0.02 | not landed |
| P-D-b | a full no over every finite `S` | 0.03 | not landed |
| P-D-c | D0, D1 with a gap closed, and D2 proved | 0.20 | not landed (D2 GAP on its deciding steps; one gap, D1-2, closed) |
| P-D-d | D0, D1 with gaps named; D2 not proved, its obstruction named | 0.55 | **landed** (and more: D2p at partial scope, the reduction to twelve places) |
| P-D-e | less than P-D-d | 0.20 | not landed |
| P-D-3 | D1-3 holds | 0.95 | **landed** (two minds) |
| P-D-2 | the dyadic ratio shown `< 1/5` | 0.60 | **landed** (two minds) |
| P-D-43 | 43's all-levels ratio `< 1/5` by hand | 0.10 | not landed |

**The jobs' C0s** (each scored in its record; summarised): **J18** (§4.3) — A-K0/K1/K2 0.97/0.97/0.98 proved; A-Kq labelled/plain 0.90/0.05
proved/refuted; A-T1 0.45 open; the stall 0.80 happened; P-J18-DC (non-rigid phase survives, 0.80) met. **J19** (§3.3) — C0-3 (a sharper
obstruction, 0.80) met; C0-4 (KE refuted, 0.10) half met (a class, no instance); C0-5 (twin-family walls, 0.6) met; **C0-6 (all 94 frozen,
0.35) lost**; C0-1, C0-2 not met. **J20** (§1.3) — every lemma TRUE as its high prior said; A-Kq (0.55) split as its stated doubt foresaw;
A-T1 (0.50) GAP; J19-KEF (0.50) TRUE once KE was stated. **J21** (§4.4) — every claim's outcome the expected one; "not foreseen": the partial
scope is mixing, and it reduces ℚ(√167)'s window question to twelve places. **J22** (§1.3) — every fixed-list verdict the modal one; J21-TH
(0.55 TRUE, 0.30 FALSE) TRUE.

**Calibration note (G21).** The plan's modal registrations (P-A3, P-D-d) landed; no prediction that landed was scored on prose. The one
flattering direction to audit: P-D-d is scored "landed" although its companion P-D-c failed only on D2 — checked against J22's verdict
table (D2(a), D2(b) GAP after B2): the scoring stands.

#### R3.5 The verdict, in four parts

- **The choice.** **Q1 (FS-76 in rank one): not landed** — A-T1 (R2) is open at a named step, reached by three minds; what landed is a
  verified reformulation (J18-DC: A-T1 is a statement about single heteroclinic colourings), a corrected and verified lemma set (K0loc, AK1,
  AK2, AKq for the labelled quotient; the plain quotient's rigidity clause false), the Kempe closure theory (KC, ENDS, FRZ, KEF, TW, BIN) and a
  no-go of a format (FW is invisible to every Kempe argument). **Q2 (FS-64 at five colours over ℚ(√167)): landed in part** — the finite-place
  count holds everywhere except at 43 (D1 with D1-fac, D1-2, D1-3; two minds), a pullback theorem holds for mixing factors (MX, D2p), and
  every window question there reduces to at most nine places (RED); D2(a)/(b) stay GAP at two named steps and nothing touches `χ_µ(ℝ²)`.
  Both headline questions — R2, and a five-colour window no-go over every `S` — are **not landed**. Under Kooshi's rule, every item above is
  a success of knowledge; the labels score the experiment only.
- **The alternative weighed.** Label Q2 "not landed", because its deciding claim (D2(a)) is GAP. It would have been the more austere
  reading.
- **Why this one.** The plan registered the partial outcome (P-D-d, 0.55) as modal *before* any job ran, and scored claims, not labels;
  what landed beyond it (D2p, MX, RED) is verified by a second mind. Saying "landed in part" with the unlanded parts named keeps both facts
  visible; "not landed" would hide verified theorems, "landed" would hide D2's GAP.
- **Confidence: high** on every grade and status (two derivations on 38 of 46 entries, `plans/M3-derivation.md`). **Medium** on "in part"
  as the right size: J23cpa read the three neighbours (none holds MX) and found its threshold in print with a complete first factor
  (`[PakVilenchik2013]`); if Špacapan 2011 (unread, paywalled) holds MX's finite form, Q2's own content shrinks to the place count and the
  reduction (R5).

#### R3.6 The honesty tally (every owner error and agent slip in the inventory, and the owner's rulings)

| who | slip or error | inventory row |
|---|---|---|
| owner | the J06 brief's "FS79 T30" for FS73-T30, and "Ellenberg2018's question" for the inheritance question | 1 |
| owner | gave Kooshi the 1985 title for the 1990 DOI | 39 |
| J06 (planner) | A-Kq's one-line proof (fails at windows of ≤ 2 colours); "A-K2 is FS86-dB-H's rank-one form" (only left-gap-free); the cylinder lemma (false); `[KechrisMarks2020]` "§4.7" for §5.1 Ex. 5.1; the J22 brief's truncated CL1 grade; no "Theorems this phase proved" heading | 9, 10, 20, 19, 57, 28 |
| J19 | read two withheld passages through over-wide `sed` ranges (logged by itself); a positive control asserting a false claim (caught because it failed); a registration commit that lost a git-lock race to its run | 34 |
| J20 | a strand-swap lift sign error, caught by the properness requirement before any verdict used it | 46 |
| J21 | five headline scopes wider than their bodies (SL's σ-compactness, D1-43p's two clauses, NG1's intermediate bound, NG2's scope and grade) and one display truncating an upper bound; each body right; corrected by J22 | 49 |
| J22 | `--mem 8` under-declared (exit 137 at step 6/7, explained); a plant that first fired for the wrong reason, re-planted | 55, 58 |

**Owner rulings logged:** J20/J22 keep their verified-input lists (row 6); J19 aimed at A-T1 itself, KE a route (row 35); J20 and J22 given
J19's and J21's statements verbatim as extra blind claims, and the exact check at 59 (row 36); J22 stopped at ≈ 406k and resumed as J22b
(row 54); J20's residue step waits for 2026-10-01 (row 60). **Tool defects:** none shipped (J20's sign error never reached a verdict).
**What the verifiers caught that the derivers had not:** the `N` of J19-KC; J21's five headline scopes; 59's grade; A-Kq's `D = {1,2}`
companion. **What no one caught until the close:** nothing that changes a verdict.

#### R3.7 The budget tally (harness counts where reported)

| job | harness | own | source |
|---|---|---|---|
| J06 | ≈ 484k | — | inventory row 7 |
| J18 | 402k (task notification) / ≈ 230k (its report) | ≈ 120k | row 40; `reports/J18.md` — the two sources disagree; both filed |
| J19 | 386k (task notification) / ≈ 230k (its report) | ≈ 215k | row 40; `reports/J19.md` — likewise |
| J20 | ≈ 400k | ≈ 215k | `reports/J20.md` |
| J21 | ≈ 460–468k (past the 420k line) | — | `reports/J21.md`; row 40 |
| J22 / J22b | ≈ 406k at the owner's stop / not reported | — / ≈ 190k | the record's Handover; `reports/J22.md` |

#### R3.8 The ban measurement

**Would-have-searched lines across M3: 32** — J06 5 (X1–X5), J18 5 (W1–W5), J19 5 (W1–W5), J20 5 (three in B1, two in B2), J21 6
(W1–W6), J22 6. **Run as searches: none.** J21's W6 was run as a prior-art query, not a witness search.

**At the ban's edge (in, logged by their authors):**
1. J19's complete enumeration of the window-state graph of `X₄({2,6,11,13,14})` (94 phases, 2.0 s), one `D` chosen by a stated rule before
   the run (J19 §1.5, §2.6) — the brief's "94 rigid points".
2. J18's one derived check `D′ = D_c(40) = {1,5,7,10,13,27,33}`, `M` fixed by the derivation and the outcome registered first (J18 §3.4);
   the plan's X2 had anticipated it.
3. The complete recomputations of named sets: J18-CTL and J19-CTL on `{1,5,7,10}`; J20-NAMED on six named sets; J20's `{1,3,6,9}`, a set
   derived by hand before its one check.
4. J22's two-point (Delsarte) LP bound on `α(F)` for Exoo's circulant — "a relaxation of fixed shape, seconds (in, logged)" (J22 §1.4).
5. Exact spectra and FFTs of graphs fixed by the statements (J21's tools, J22-T1/T2), and the FS-66 checker re-run (an existing checker on
   an existing certificate).

**Declined at the edge:** J20's first exact step toward A-C (the admissible residues mod 20 of T30's rigid–rigid walls; J20 §3.4) —
**the owner ruled it waits for 2026-10-01** (inventory row 60).

**What the ban cost, named:** D1-43 (FS-66's relaxation at 43, 84 GPU-days, would settle `B₁(43) < 369.8` or not); an instance for KE♯/FW
(a search for a frozen rigid–rigid wall); A-C's construction route (the residue step, then completions); `κ < 1/5` at the non-thick places
(finite questions). **What it did not cost:** no stall was one a search would have closed with certainty; R2's truth is not a finite
question at any known size.

#### R3.9 The FS-66 checker re-run at 23

Pending at this save (steps 1–4 of 7 passed at 18:29). **Filed at stage 5 (R5.2): CERTIFIED, exit 0.**

#### R3.10 The close's prior-art gate (WORKFLOW 3.2, zbMATH API for discovery; queries and hits in `data/m3/j23c/`)

*Time-boxed; every negative measures its query's words (G21).*

| result | queries (this gate, beyond J06's §PA and J21's §3.7) | found | position |
|---|---|---|---|
| J21-MX (spectral Burr–Erdős–Lovász; Borel/measurable) | zbMATH: `Hedetniemi & eigenvalue` (1), `& Cayley` (5), `& holds` (14), `& circulant` (4), `& Kneser` (10), `multiplicative & Hedetniemi` (10), `direct product & chromatic number & eigenvalue` (0), `categorical product & chromatic & spectral` (0), `Borel chromatic number` (31), `Borel & Hedetniemi` (0), `measurable & categorical product` (0), `measurable chromatic number & product` (0); three web searches | nothing on point. **Nearest printed relatives, unread:** `[AlonDinurFriedgutSudakov2004]` (GAFA 14; zbMATH 1056.05104: maximum and near-maximum independent sets of weak products of spectral base graphs are induced by the base, with stability, by Fourier analysis — the discipline's form of the planner's cylinder lemma); Tardif–Wrochna 2019 (*Hedetniemi's conjecture and strongly multiplicative graphs*, zbl 1427.05090; review withheld); `[GodsilEtAl2020]` (Godsil, Roberson, Rooney, Šámal, Varvitsiotis, *Vector coloring the categorical product of graphs*, zbl 1442.05056; held, part-read); Kechris–Solecki–Todorčević 1999 (definable Hedetniemi applications). `[KechrisMarks2020]` §4.6: "We do not know any other results along these lines." | **not found by these searches**; the reading job J23cpa then read ADFS, Tardif–Wrochna and `[GodsilEtAl2020]`: none contains it, and its threshold is in print with a complete first factor (`[PakVilenchik2013]` Thm 3) — R5 |
| J21-TH, J21-RED (thick places; the reduction) | `p-adic & chromatic number & measurable` (0), `adelic & chromatic` (0, off-topic) | nothing | not found by these searches |
| J22-T10 | not searched as new | the equality case of the Hoffman bound is classical (Hoffman; Haemers); T10 specialises it to FS-66's relaxation `B₁` | classical in substance |
| J18-DC, J19-KC/KT/FRZ (rank-one colouring shifts, Kempe moves) | `Kempe & periodic` (1), `Kempe & frozen` (4, recolouring Hadwiger), `Kempe equivalence` (16), `Kempe & lattice` (18, off-topic), `shift of finite type & coloring` (4), `distance graph & entropy` (0), `distance graph & aperiodic` (1: EES 1990); one web search | nothing on point. Nearest: `[EggletonErdosSkilton1990]` (unread, unheld — the one printed statement on aperiodic `χ(D)`-colourings of `G(ℤ, D)`); `[MoharSalas2009]` (Kempe classes of colourings of periodic lattices; a listing row); `[AbrishamiEtAl2025]` (existence of periodic colourings; held) | not found by these searches |
| J21-NG2's external input | fetched `[Zhu2021]` (X. Zhu, *Relatively small counterexamples to Hedetniemi's conjecture*, JCTB 146 (2021) 141–150, doi 10.1016/j.jctb.2020.09.005, arXiv:2004.09028, Zbl 1457.05095) to `~/source/library/pdf/arXiv-2004.09028-zhu-relatively-small-counterexamples-hedetniemi.pdf`; read: §3's Theorem 3 statement and construction, §4's remark on `p` | Theorem 3, verbatim: "`χ(G), χ(H) > c` and `χ(G × H) ≤ c`", with `G = F[K_q]`, `q ≥ (p − 1)/2`, `c = 3q + 2`, `F` of odd girth 7 and `χ_f(F) > 3 + 4/(p − 1)`; §4: "Geoffrey Exoo found an odd girth 7 graph G on 83 vertices and with independence number 27. This implies that `χ_f(G) > 3.074`. So `p ≤ 83`" and "For `p = 83`, we have `q = 41` and `c = 125`" | NG2's input confirmed in print first-hand: `H → K₁₂₅^{F[K₄₁]}`, so `χ(A) ≥ χ(H) > 125`. **Still external:** `α(F) = 27` (Exoo's search, cited as personal communication) and the identification of Exoo's graph with the circulant (from `[Zhu2025]`); Theorem 3's proof not read |

### Stage 4 — SAVED (the drafts: ledger rows, § B lines, corrected text, `CLAUDE.md` lines, stub re-aims, new stubs, the re-rank)

*Drafts only. A front-page job applies them; nothing below has been written into `LEDGER.md`, `CLAUDE.md`, `plans/FRONTIER-STUBS.md`,
`BIBLIOGRAPHY.md` or any existing stub. Row numbers read "next": M1's close (`plans/FS91-character-local-global.md` §R-close) had not
reached its stage 4 when this was written, so the front-page job numbers M3's rows after M1's.*

#### R4.L `LEDGER.md` § A — three rows

**Row next — rank one at four colours, reduced and not decided.**
| next | **Rank-one four-colour inheritance, restated and reduced but not decided: for finite `D ⊂ ℤ_{>0}`, FS-76's rank-one reading R2 ("every phase of `X₄(D)` rigid ⟹ no wall") is equivalent to "a countable four-colouring shift of a distance graph on ℤ is finite", to `P₄(D) = F₄(D)`, to the reversal lemma A-K3, and to "no heteroclinic four-colouring of ℤ has an all-rigid Δ-completion `X₄(D_c(M))`"; in an all-rigid shift every periodic point is gap-free with two-sided Kempe strands and the Kempe class of a wall point keeps its tails in different labelled phases, so walls between Kempe-frozen tails are invisible to every Kempe argument; the richest all-rigid shift held (`{2,6,11,13,14}`, 94 phases, no wall) has no frozen point** (M3; `plans/M3-derivation.md` §1–§4). **[hand, two derivations for every lemma and equivalence (J18 or J19; J20 blind from the fixed list, or from the statement); tools exact on seven named sets, `{2,6,11,13,14}` by two tools]** R2 stalled at one named step, reached by three minds (J18 at KE, J19 at KT's transport step, J20 at its own, which it identifies with J19's FW plus the non-frozen half). Corrected on the way: A-Kq holds for FS-79's labelled quotient, and the plain quotient's rigidity clause is false (`D = {1}`, `{1,2}`); unique continuation needs **left** gap-freeness (FS73-T30's rigid–rigid walls leave two-sided gap-free points); J19-KC's `N` is the lcm of the least periods (`D = {1,3,6,9}`). KE ("a one-sided Kempe swap sends a tail into a non-single-cycle phase") is false at every wall whose one-sided components are total, so it needs KE♯; J20-TW: every wall between distinct phases of any `X₄(D)` has a chiral end. **Not claimed:** R2 either way; KE♯, KT, FW; the binary return-time model for `D ⊇ {1,2}` (J19-BIN) is a restatement. **Prior art:** the one-dimensional SFT facts are Lind–Marcus's; R2, the Δ-completion and the Kempe split not found (M3 §R-close R3.10); `[EggletonErdosSkilton1990]`, the one printed statement on aperiodic `χ(D)`-colourings, unheld and unread. | `plans/M3-S1A-rank-one.md`, `plans/M3-S1B-rank-one.md`, `plans/M3-S1V-rank-one.md`, `tools/crunch_j18_*`, `tools/crunch_j19_*`, `tools/crunch_j20_*`, `data/m3/j18–j20/` | M3 (crunch 2026-09-25) |

**Row next+1 — the mixing selection.**
| next+1 | **The mixing selection: if `K` is compact abelian and a probability `ν` on `T_K ⊆ K` has every non-trivial Fourier coefficient below `1/(k−1)` in absolute value (`λ* < 1/(k−1)`), then from every Borel proper `k`-colouring of `X × Cay(K, T_K)`, `X` any Borel graph, the fibre's colour of measure above `λ*/(1 + λ*)` is a Borel proper `k`-colouring of `X`; measurably, one proper off a null vertex set** (M3; `plans/M3-derivation.md` M3-J21-MX, NG1, NG2). **[hand, two derivations (J21; J22 from the statement, both forms of the null-vertex format)]** The engine is the compact expander-mixing lemma; the complete-graph case is Burr–Erdős–Lovász's `χ(G × K_n) = min(χ(G), n)` (`[Tardif2008]` Thm 3.2), and in `[KechrisMarks2020]`'s terms it is a positive special case of Problem 4.23 (Borel Hedetniemi) for pairs with one mixing compact abelian Cayley factor. **Ratio is not enough:** a finite abelian Cayley graph with independence ratio `< 1/125` does not carry the selection at 125 colours (`F[K₄₁]`, `F` Exoo's 83-vertex circulant, from `[Zhu2021]` Thm 3; `α(F) = 27` external), and "an independent set of density above the ratio is a cylinder" is false for every `B` (two constructions). **Not claimed:** anything at `λ* ≥ 1/(k−1)`; edges with both ends in the null set (the null-set step); ratio-only statements at five colours. **Prior art (`plans/M3-PA-mixing.md` Stage 6):** as stated not found (53 zbMATH queries, six papers read); partly in print — the threshold `λ(H)/r < 1/(k−1)` with a complete first factor is `[PakVilenchik2013]` Thm 3 (unique and unique vector `k`-colourability; `[GodsilEtAl2020]` Cor. 4.4), the `K_n` case BEL's (`[Tardif2008]` Thm 3.2); undecided only at Špacapan 2011 (unread). The proof is BEL's plurality selection plus the expander mixing lemma, so the finite case may be called folklore. | `plans/M3-S1D-windows-five.md` §3.2, §3.6; `plans/M3-S1V-windows-five.md` §2.2, §3.4–§3.5; `tools/crunch_j22_b2_checks.py` | M3 (crunch 2026-09-25) |

**Row next+2 — windows at five over ℚ(√167).**
| next+2 | **Windows at five colours over ℚ(√167): no measurable window five-colouring reads a finite set of places with no real place and none above 43 (the dyadic place is split with ratio 0 — C14.2 (c) holds at `q = 2` —, the barrier prime's place is split, 59 has ratio `0.199119854095` exactly); every finite place except twelve (above 2, 3, 5, 7, 29, 61, split; above 23, 43, stable) is 5-thick, so a Borel window five-colouring over any `S` exists iff one exists over `S_red ⊆ {∞, 2, 3, 5, 7, 23, 29, 43, 61}`, and with a real place and only thick finite places the question is exactly `χ_B(ℝ²) ≤ 5`** (M3; `plans/M3-derivation.md` §5–§6). **[hand + tools exact + cert, two derivations (J21; J22 blind on the fixed list, from the statement on MX, TH, RED); 59 exact by two code bases; 23 by row 75's certificate]** So a window falsifier of the conjecture's "≥ 6" at ℚ(√167) must read a place above 43 (with no real place) or one of 2, 3, 5, 7, 23, 29, 43, 61 (with one) — or be a Borel (or null-set-tolerant) five-colouring of `ℝ²`. Two real places merge (`χ_µ(Γ_{∞₁} × Γ_{∞₂}) = χ_µ(Γ_{∞₁})`, slicing, σ-compact groups); the pullback D2 holds for thick factors (Borel iff; measurable into the null-vertex format). **Not claimed:** anything about `χ_µ(ℝ²)`; 43 at depth (needs `B₁(43) < 369.8`; the fibre-share inequality with only the spectrum gives exactly Hoffman's `0.2138`, its true maximum is strictly below); D2 at the non-thick factors (GAP-2) and from measurable to everywhere-proper (GAP-1); any colouring no window gives. **Corrects row 92:** FS86-CL1's qualifier "split places odd" can be dropped at ℚ(√47) and ℚ(√167) (two minds). **Prior art:** not found (M3 §R-close R3.10). | `plans/M3-S1D-windows-five.md`, `plans/M3-S1V-windows-five.md`, `tools/crunch_j21_*`, `tools/crunch_j22_*`, `data/m3/j21/`, `data/m3/j22/` | M3 (crunch 2026-09-25) |

**Row 92, correction in place** (inventory row 18): replace "for sets of places whose split places are odd (C14.2 at `p = 2`, where their
dyadic places split, not checked)" with "for every finite set of places (C14.2 (c) holds at `q = 2`: M3, row next+2, two minds)".

#### R4.B `LEDGER.md` § B — one line per entry of `plans/M3-derivation.md` (milestone column "M3")

| id | milestone | the theorem, in one line | grade | proof | kernel |
|---|---|---|---|---|---|
| M3-J18-F2 | M3 | inside a rigid phase a path is deterministic; a point with both limit phases one rigid `C` is on `C`'s periodic orbit (= J20-RET) | hand, two derivations | `plans/M3-derivation.md` M3-J18-F2 | declined |
| M3-J18-F3 | M3 | one-dimensional SFT facts for `X_k(D)`: a non-single-cycle phase gives `h > 0`; all single cycles give `h = 0`, countability, and wall ⟺ infinite (= J20-W, E1, E2) | hand (standard), two derivations | M3-J18-F3 | declined |
| M3-J20-T35W | M3 | FS79-T35 on the unquotiented window-state graph, `X₄(D) = ∅` included | hand, two derivations of a held theorem | M3-J20-T35W | declined |
| M3-J18-EQ | M3 | A-T1 ⟺ A-T1′ ⟺ A-T2 ⟺ A-K3 for every `D` (= J20-EQ); route (ii)'s potential exists iff A-T1 | hand; first clause two derivations, second one mind | M3-J18-EQ | declined |
| M3-J18-DC | M3 | the Δ-completion theorem: A-T1 fails iff some heteroclinic four-colouring `c` has an all-rigid `X₄(D_c(M))` (= J20-DC) | hand, two derivations | M3-J18-DC | declined |
| M3-J18-K0loc | M3 | a periodic point of one rigid phase is gap-free, its Kempe strands two-sided and crossing every cut, its `m`-windows `≥ k − 1` colours (= J20-K0, CUT 1–2) | hand, two derivations | M3-J18-K0loc | declined |
| M3-J18-K0H | M3 | the two-sided rank-one form of FS86-dB-H is false (T30's rigid–rigid walls) | hand + FS-79 tools, two derivations | M3-J18-K0H | declined |
| M3-J18-AK1 | M3 | all phases rigid and `X₄(D) ≠ ∅` ⟹ `χ(G(ℤ, D)) = 4` (= J20-K1) | hand, two derivations | M3-J18-AK1 | declined |
| M3-J18-AK2 | M3 | a left-gap-free colouring is fixed by any left half-line; a wall leaves a phase only at a left gap (= J20-K2) | hand, two derivations | M3-J18-AK2 | declined |
| M3-J18-AKq | M3 | A-Kq for the labelled quotient; the plain quotient's rigidity clause false at `D = {1}`, `{1,2}` (= J20-Q) | hand (+ tools exact), two derivations | M3-J18-AKq | declined |
| M3-J20-CUT | M3 | at a wall's exit site the window is not coloured inside the two absent colours; a crossing-free cut for a pair `π` gives a wall to `τ_π·B` | hand, one mind | M3-J20-CUT | declined |
| M3-J18-KE⟹ | M3 | KE ⟹ A-T1 | hand, two derivations | M3-J18-KE⟹ | declined |
| M3-J19-KC | M3 | Kempe closure in an all-rigid shift: strands `σ^N`-invariant for `N` the lcm of least periods (false for a point's least period, `D = {1,3,6,9}`); Kempe classes of wall points stay wall points with tails in different labelled phases (= J20-KC) | hand (+ tools exact), two derivations | M3-J19-KC | declined |
| M3-J19-ENDS | M3 | the ends partition of a wall point: each strand of a tail has one end-component; finite components meet `[a − m, b + m]`; swaps act on tails by strand swaps | hand (+ tools exact), two derivations | M3-J19-ENDS | declined |
| M3-J19-FRZ | M3 | at Kempe-frozen tails every point of the Kempe class has relabelled tails; no rigidity needed (= J20-FRZ) | hand, two derivations | M3-J19-FRZ | declined |
| M3-J19-KEF | M3 | KE fails at every rigid–rigid wall whose one-sided components are all total; so KE ⟹ KE♯ (= J20-KEF) | hand, two derivations | M3-J19-KEF | declined |
| M3-J19-KT | M3 | KE ⟹ KT ⟹ A-T1 and KT ⟹ KE♯; A-T1 = FW ∧ A-T1ⁿᶠ with FW invisible to Kempe arguments | hand, two derivations of the implications | M3-J19-KT | declined |
| M3-J19-TW | M3 | every wall between distinct phases of any `X₄(D)` has a chiral end; an achiral end yields a twin wall (= J20-TW) | hand, two derivations | M3-J19-TW | declined |
| M3-J19-BIN | M3 | for `D ⊇ {1,2}`, `X₄(D)` is a 24-to-1 extension of a binary return-time shift; phases, rigidity, walls, mirroring transfer (= J20-BIN) | hand, two derivations | M3-J19-BIN | declined |
| M3-J18-CTL | M3 | the control `{1,5,7,10}`: 18 phases, 17 rigid, 15 walls; 8 of 9 rigid–rigid wall points have trivial completion to `M = 100` | tools exact, one run (phase counts confirmed by J20) | M3-J18-CTL | declined |
| M3-J18-DPR | M3 | `X₄({1,5,7,10,13,27,33})`: 25 phases, 24 rigid, one non-rigid; A-C not landed | tools exact, one run (partly confirmed by J20) | M3-J18-DPR | declined |
| M3-J19-CTL | M3 | the control's 62 one-sided components: 10 total keep the tail rigid, 52 proper send it to the non-rigid phase, matching J18's data | tools exact, one run | M3-J19-CTL | declined |
| M3-J19-AF✗ | M3 | all-rigid `X₄({2,6,11,13,14})`: 94 rigid points, none Kempe-frozen; single-strand swaps connect all 94 phases (conjecture AF false) | tools exact, two tools | M3-J19-AF✗ | declined |
| M3-J20-NAMED | M3 | on T30's four sets, `{2,6,11,13,14}` and `{1,5,7,10,13,27,33}` no rigid periodic point is Kempe-frozen; rigid–rigid wall ends period 20, chiral | tools exact, one run | M3-J20-NAMED | declined |
| M3-J21-D0 | M3 | a window five-colouring over one real place is a measurable five-colouring of `UD(ℝ²)`; a no over every `S` with a real place gives `χ_µ(ℝ²) ≥ 6` | hand, two derivations | M3-J21-D0 | declined |
| M3-J21-D1 | M3 | no real place and every factor of ratio `< 1/5` ⟹ no window five-colouring (formats E, N, L) | hand, two derivations | M3-J21-D1 | declined |
| M3-J21-D1fac | M3 | ℚ(√167)'s factor table: 23 `≤ 0.18523`, 59 `0.199119854095` exact, stable `p ≥ 67`, 167, odd split places 0; stable places below 59 are 23, 43 | hand + tools exact + cert, two derivations | M3-J21-D1fac | declined |
| M3-J21-D1-3 | M3 | the place above 3 is split in `F(i)/F`: ratio 0 | hand, two derivations | M3-J21-D1-3 | declined |
| M3-J21-D1-2 | M3 | C14.2 (c) holds at `q = 2`: the dyadic place has ratio 0 (= J22-T3) | hand (+ tools), two derivations | M3-J21-D1-2 | declined |
| M3-J21-D1-43p | M3 | at 43: level-one windows excluded in D1's setting; the spectrum alone gives exactly Hoffman; depth GAP (`B₁(43) < 369.8` needed) | hand + cert, two derivations (corrected by J22) | M3-J21-D1-43p | declined |
| M3-J22-T10 | M3 | the fibre-share inequality with only the spectrum gives exactly Hoffman; its true maximum `B₁(p)` is strictly below unless an independent set meets Hoffman; `B₁(43) < 395.2338` | hand + tools exact, one mind | M3-J22-T10 | declined |
| M3-J22-T1 | M3 | `Γ₅₉`: `λ* = 0.2486262833630 < 1/4`, Hoffman `0.199119854095 < 1/5`, exactly | tools exact, two code bases | M3-J22-T1 | declined |
| M3-J22-T2 | M3 | level-one `λ*` of the standard compact piece at `q = 9, 25, 49, 23, 29, 43, 61` all `≥ 1/4`; at 67, 121 `< 1/4`; at 2, `λ* = 1` | tools exact, two derivations | M3-J22-T2 | declined |
| M3-J21-SL | M3 | slicing along shifted diagonals: σ-compact `G`, σ-finite `Y` (as J21 stated it for every LCA `G`, false at `ℝ × ℝ_d`) (= J22-T11) | hand, two derivations (corrected by J22) | M3-J21-SL | declined |
| M3-J21-D3 | M3 | `χ_µ(Γ_{∞₁} × Γ_{∞₂}) = χ_µ(Γ_{∞₁})`, and for `χ_B` (= J22-T5) | hand, two derivations | M3-J21-D3 | declined |
| M3-J21-MX | M3 | the mixing selection: a compact factor with `λ* < 1/(k−1)` can be deleted from a Borel `k`-colouring of a product (measurably, into the null-vertex format) (= J22-T6) | hand, two derivations | M3-J21-MX | candidate (finite form) |
| M3-J21-UNIF | M3 | the uniform measure on a compact piece's circle is optimal for Hoffman and for mixing | hand, two derivations | M3-J21-UNIF | declined |
| M3-J21-TH | M3 | every finite place of ℚ(√167) is 5-thick except twelve (above 2, 3, 5, 7, 29, 61; 23, 43) | tools exact + hand, two derivations | M3-J21-TH | declined |
| M3-J22-T8 | M3 | at a split place with odd `p`, level-`m ≥ 2` characters with equal negative valuations have `|ν̂| ≤ 2/(q − 1)`; Lemma P re-derived | hand, one mind (a classical bound) | M3-J22-T8 | declined |
| M3-J21-RED | M3 | a Borel window five-colouring of ℚ(√167)'s plane over `S` exists iff one over `S_red ⊆ {∞, 2, 3, 5, 7, 23, 29, 43, 61}` | hand, two derivations | M3-J21-RED | declined |
| M3-J21-D2p | M3 | D2(a), D2(b) hold when every factor of `B` is thick (Borel iff; measurable into N′) (= J22-T7, T9) | hand, two derivations | M3-J21-D2p | declined |
| M3-J21-NG1 | M3 | the planner's cylinder lemma is false for every `B` of the D2 class, literally and in the containment reading (= J22-T12) | hand (+ tools exact), two constructions | M3-J21-NG1 | declined |
| M3-J21-NG2 | M3 | ratio alone cannot carry D2 at 125 colours (`F[K₄₁]`, from `[Zhu2021]` Thm 3) (= J22-T13) | hand + external, two derivations | M3-J21-NG2 | declined |
| M3-J21-NG3 | M3 | at a split place the whole local graph has clopen cross-independent sets of density bounded below; only compact pieces can mix (= J22-T4) | hand, two constructions | M3-J21-NG3 | declined |
| M3-J21-D4 | M3 | C9's `⌊4θ̃⌋` is a Borel window four-colouring of ℚ(√11)'s plane over `{∞, 7}`, a pullback from neither factor; the hexagonal seven-colouring is a window over `{∞₁}` | hand, two derivations | M3-J21-D4 | seven-colour half kernel (row 33) |
| M3-CHK23 | M3 | the frozen FS-66 checker re-run on `cert-p23.json --m 5`: CERTIFIED, exit 0 (no `UD(ℤ/23^k, 2)` is 5-colourable, via FS-66's hand links) | cert (an existing checker on an existing certificate) | M3-CHK23 | — (FS-66's) |

#### R4.C Corrected text for the plan's §PA.1, §S and §M (the entries keep their history; each banner now points here)

- **R4.C.1 (§PA.1 row 3; inventory row 19).** The passage "the unit distance graph on R², … is known to have 5 ≤ χ(U) ≤ χ_µ(U) ≤ χ_B(U)
  ≤ 7, … but the exact values of χ(U), χ_µ(U), χ_B(U) are unknown" is in `[KechrisMarks2020]` **§5.1, Example 5.1 (pp. 45–46)**, not §4.7
  (§4.7 is "Extensions", p. 33); Problem 4.23 and "We do not know any other results along these lines. Is C_B(4) true?" are in §4.6 as
  quoted.
- **R4.C.2 (§S, the definitions' parenthesis, and the fixed list's A-Kq; inventory rows 9, 42).** Read the parenthesis as: "(FS79-T35 states
  its criterion with phases taken modulo colour permutation in FS-79's **labelled** (transfer) quotient — each class's out-edges those of a
  representative, one per admissible colour, with multiplicity; the claims below hold for that quotient and for the unquotiented graph. In
  the plain (orbit) quotient the wall clause holds and the rigidity clause fails: `D = {1}`, `{1,2}`.)" A-Kq's verdict: TRUE for the
  labelled quotient, its rigidity clause FALSE for the plain one (`plans/M3-derivation.md` M3-J18-AKq).
- **R4.C.3 (§M, domain pass item 1; inventory row 9).** "An edge's lift is determined by its source" fails exactly at windows using at most
  two colours (a non-trivial stabiliser); the two quotients agree on phases whenever every phase window uses at least three colours, which
  every all-rigid shift satisfies (K0loc (d)).
- **R4.C.4 (§M, domain pass item 2; inventory row 10).** A-K2 is the rank-one form of FS86-dB-H **with left-gap-freeness**; the two-sided
  transcription is false in rank one (FS73-T30's rigid–rigid walls leave two-sided gap-free periodic points; M3-J18-K0H).
- **R4.C.5 (§M, D2(a)'s obligation tree; inventory row 20).** The cylinder lemma ("an independent set of `A′ × B` of relative density
  `> β` is a.e. a cylinder `I × B`") is false already for `A′ = A = UD(ℝ²)`, literally and in the containment reading, for every `B` of the
  D2 class (M3-J21-NG1); `[Zhang2012]` Thm 1.8 (i) speaks of **maximum** independent sets. The route that works is fibre-local — the
  mixing selection (M3-J21-MX) — and needs `λ* < 1/4`, not ratio `< 1/5`.

#### R4.G `CLAUDE.md` — drafted lines (net ≤ 4,000 bytes; measured in R4.M)

<!-- M3-CLAUDE-DRAFT-BEGIN -->
*Frontier, "Where the problem stands", a new item after 25 (numbered by the front-page job):*
**Rank one at four colours, and windows at five over ℚ(√167)** (rows next–next+2; M3 of the 2026-09-25 crunch, `plans/M3-derivation.md`).
FS-76's rank-one question (every phase rigid ⟹ no wall) is *a countable four-colouring shift of a distance graph on ℤ is finite*, and a
statement about single heteroclinic colourings; **not landed**, stalled at one step by three minds (G77). At five colours no window
reads finitely many places of ℚ(√167) with no real place and none above 43; a factor leaves a product colouring when it **mixes**, not
when its ratio is small, so the window question lives at nine places; nothing touches `χ_µ(ℝ²)`.

*Prior-art position, "Ours:" add:* rows next–next+2. *"Not ours:" add:* the mixing selection's complete-graph case
(Burr–Erdős–Lovász) and its threshold beside `K_k` (`[PakVilenchik2013]`); the ratio-only counterexample (`[Zhu2021]` Thm 3); one-dimensional SFT facts (Lind–Marcus).

*Grokkings — new entry:*
* **G77 — Rank-one inheritance is "countable ⟹ finite", and Kempe moves cannot see a frozen wall. [hand, two derivations (row next);
  tools exact on named sets; one reading]** The four-colourings of `G(ℤ, D)` form a one-dimensional SFT; all phases rigid is zero entropy,
  and R2 says such a shift is finite — equivalently `P₄ = F₄`, equivalently no heteroclinic colouring has an all-rigid completion
  `X₄(D_c(M))`. In an all-rigid shift periodic points are gap-free with two-sided strands and the Kempe class of a wall point keeps its
  tails in different labelled phases; at frozen tails Kempe moves only relabel, so the frozen part of R2 needs an invariant no Kempe
  argument supplies. *Reading:* all-rigid shifts are Kempe-rich (`{2,6,11,13,14}`: 94 phases, none frozen). *Do: when a rank-one
  colouring question resists, restate it on single colourings and split it at frozen tails before choosing a Kempe route. Killing test of
  the reading: an all-rigid `X₄(D)` with a frozen rigid point. Nothing kills the equivalences; they forbid a Kempe proof of the frozen case.*

*Grokkings — edits in place:*
- **G76**, before its *Do*: "**At five colours over ℚ(√167)** (row next+2) a factor leaves a product colouring when its compact pieces
  mix (`λ* < 1/4`, a spectral Burr–Erdős–Lovász), not when its ratio is small (false at 125 colours); twelve places do not mix, so the
  window question lives at nine places, and with a real place it is `χ_B(ℝ²)`'s."
- **G50**, its instances: "**M3's:** `[Zhang2012]` Thm 1.8, read in full, was applied to sets of density above the ratio though it speaks
  of maximum ones, and `[AlonDinurFriedgutSudakov2004]`, the discipline's form of that lemma, went unsearched."
- **G72**, its count: "**M3:** both questions through the structural form; Q2's invariant found (the fibre's classes above the mixing
  threshold), Q1's not (FW rules out every Kempe invariant)." (The running number: the front-page job orders M1's and M3's.)
- **G30**, the ladder: "→ descriptive set theory (Borel and measurable combinatorics, entered at M3)".

*Paths forward table (the front-page job places the rows by R4.F):*
- FS-76's row, append: "**At M3's close:** rank one reduced to single colourings (row next), open at FW and KT; frozen walls → the new
  rank-one-walls stub."
- FS-64's row, append: "**At M3's close:** five-colour windows over ℚ(√167) excluded off 43 with no real place; the rest reduces to nine
  places (row next+2) → the non-mixing-places stub."
- FS-69's row, append: "also decides the finite-place windows at five over ℚ(√167) (`B₁(43) < 369.8`, M3)."
- New rows: "**FS-(new) rank-one walls** — `plans/STUB-rank-one-walls.md` | frozen walls, `D ⊇ {1,2}`, the completion route | none"
  and "**FS-(new) windows at the non-mixing places** — `plans/STUB-windows-five-nonmixing.md` | D2 at seven places, the null-set step |
  speculative".
<!-- M3-CLAUDE-DRAFT-END -->

#### R4.F `plans/FRONTIER-STUBS.md` — re-aims and the re-rank (proposals; M1's close re-ranks the same table, so placements are relative)

- **FS-76** (rank 8): append the FS-76 line of R4.G; its bearing unchanged. **Placement:** unchanged.
- **FS-64** (rank 11): append the FS-64 line of R4.G, and in its bearing column: "the finite-place half at five over ℚ(√167) is now a
  theorem off 43; the live part is the nine places". **Placement:** unchanged.
- **FS-59** (rank 1): append "**At M3's close:** window five-colourings over finitely many places of ℚ(√167) reduced to nine places (row
  next+2); a five-colouring of the plane no window gives is untouched." **Placement:** unchanged.
- **FS-49** (rank 27): append "**At M3's close:** its measurable analogue is posed in print — Mixon's 2018 criterion (Polymath16 fourth
  thread): a five-colour forced `{1,2}`-vertex at an irrational angle proves `χ_µ(ℝ²) ≥ 6`; windows over finitely many places of ℚ(√167)
  cannot supply it from thick places (row next+2)." **Placement:** unchanged.
- **FS-69** (rank 30): append the FS-69 line of R4.G; bearing: "also the last gap in M3's finite-place window count". **Placement:**
  one step up, beside FS-57 and FS-65 (it now has two consumers), still "idle compute" — the relaxation is banned until 2026-10-01.
- **New: FS-(new) rank-one walls** — just below FS-76. **New: FS-(new) windows at the non-mixing places** — just below FS-64.

#### R4.S Stub banners (text for the front-page job to put at the top of each stub)

- `plans/STUB-four-colour-inheritance.md` (FS-76): "> **At M3's close (2026-09-25):** rank one (R2) is equivalent to *a countable
  four-colouring shift of a distance graph is finite* and to a statement about single heteroclinic colourings (J18-DC); open at one step
  reached by three minds; frozen walls are invisible to Kempe arguments. `plans/M3-derivation.md` §1–§4; `LEDGER.md` row next; follow-on
  `plans/STUB-rank-one-walls.md`."
- `plans/STUB-adelic-window-colouring.md` (FS-64): "> **At M3's close (2026-09-25):** at five colours over ℚ(√167) no window reads a finite
  set of places with no real place and none above 43; thick places are invisible, so every window question reduces to `S_red ⊆ {∞, 2, 3, 5,
  7, 23, 29, 43, 61}`; with a real place and only thick finite places it is `χ_B(ℝ²) ≤ 5`. `plans/M3-derivation.md` §5–§6; `LEDGER.md` rows
  next+1, next+2; follow-on `plans/STUB-windows-five-nonmixing.md`."
- `plans/STUB-four-colours-167.md` (FS-59): "> **At M3's close (2026-09-25):** FS-64's window format at five is reduced to nine places
  (row next+2); a window falsifier of '≥ 6' must read a place above 43 or one of 2, 3, 5, 7, 23, 29, 61 with a real place."
- `plans/STUB-distance-two-gadget.md` (FS-49): the FS-49 line of R4.F.
- `plans/STUB-certificate-at-43.md` (FS-69): "> **At M3's close (2026-09-25):** `B₁(43) < 369.8` would also close ℚ(√167)'s finite-place
  window count at five (D1-43, `plans/M3-derivation.md` M3-J21-D1-43p, M3-J22-T10: Hoffman alone reads `0.2138`, the fibre-share maximum is
  strictly below)."

#### R4.Bib `BIBLIOGRAPHY.md` — rows proposed

- **`[Zhu2021]`** — X. Zhu, *Relatively small counterexamples to Hedetniemi's conjecture*, J. Combin. Theory Ser. B 146 (2021) 141–150;
  doi 10.1016/j.jctb.2020.09.005; arXiv:2004.09028; Zbl 1457.05095 | M3's J21-NG2 (the ratio-only counterexample at 125 colours) |
  `pdf/arXiv-2004.09028-zhu-relatively-small-counterexamples-hedetniemi.pdf` (fetched 2026-09-25 by J23c) | read: §3 Theorem 3's statement
  and construction, §4's remarks on `p` (Exoo's 83-vertex graph, `α = 27`, personal communication); the proof not read.
- **`[AlonDinurFriedgutSudakov2004]`** — N. Alon, I. Dinur, E. Friedgut, B. Sudakov, *Graph products, Fourier analysis and spectral
  techniques*, Geom. Funct. Anal. 14 (2004) 913–940; Zbl 1056.05104 | the discipline's form of M3's cylinder lemma (maximum and
  near-maximum independent sets of weak products), a neighbour of the mixing selection | not held | **listing**: zbMATH review read only.
- **Superseded for ADFS, Tardif–Wrochna and GRRSV by `plans/M3-PA-mixing.md` Stage 6** (J23cpa): its four new rows (`[AlonDinurFriedgutSudakov2004]`,
  `[TardifWrochna2019]`, `[PakVilenchik2013]`, `[BrakensiekDavies2024]`, each held and read per section), its two read-status updates
  (`[GodsilEtAl2020]`, `[Tardif2008]`) and its listing rows are the ones to apply; the ADFS row above is replaced by J23cpa's.
- **`[Polymath16]`**: add to its contents the fourth thread's MCNP ≥ 6 criterion (Mixon, 5 May 2018; M3 plan §PA.1 row 4).
- **`[AmbrusEtAl2023]` / `[AmbrusEtAl2024]`** (inventory row 56): the two keys name one paper (arXiv:2207.14179) with different read
  statuses; merge them under one key and keep the fuller read status (`[AmbrusEtAl2023]`: held; §2, §5 read).

#### R4.M The byte measure of R4.G, and the new stubs

The `CLAUDE.md` draft is measured by `data/m3/j23c/measure_claude_draft.py` (the bytes between the two markers, less the markers and the
italic placement notes): its output at the save: "block 4013 bytes; placement notes 221; net 3792; budget 4000; OK" (re-measured at stage 5, after J23cpa's fold; 3,738 at stage 4) (the plant `--plant` reports OVER, exit 1). The two new stub files are `plans/STUB-rank-one-walls.md` and
`plans/STUB-windows-five-nonmixing.md`.

### Stage 5 — SAVED (J23cpa folded; the FS-66 re-run filed)

#### R5.1 The prior-art reader for J21-MX (job J23cpa, `plans/M3-PA-mixing.md`, report `data/crunch-2026-09-25/reports/J23cpa.md`)

Its verdict, filed at its exact scope (inventory rows 67–72): **J21-MX as stated** (arbitrary first factor, compact abelian `K`, weighted
`ν`, Borel and measurable forms) is **not found** by 53 zbMATH queries and six papers read; it is **partly in print** — the threshold
`λ(H)/r < 1/(k−1)` on a regular factor is `[PakVilenchik2013]` Thm 3 with first factor `K_k` only (unique and unique vector
`k`-colourability), generalised to vector colourings by `[GodsilEtAl2020]` Cor. 4.4, and the `K_n` case is Burr–Erdős–Lovász's
(`[Tardif2008]` Thm 3.2); `[AlonDinurFriedgutSudakov2004]`, `[TardifWrochna2019]` and `[GodsilEtAl2020]` do not contain it; undecided only
at Špacapan 2011 (paywalled; Kooshi asked). The compact mixing lemma is classical in finite form (Krivelevich–Sudakov; Haemers).

**What changed here at this stage (history in git):** R3.10's MX row and the GRRSV name (five authors, held); R3.5's confidence sentence;
R4.L row next+1's prior-art sentence and its BEL citation; the `CLAUDE.md` draft's "Not ours" line (`[PakVilenchik2013]` added; net 3,792
bytes, R4.M); R4.Bib (J23cpa's rows supersede this job's ADFS/Tardif–Wrochna/GRRSV proposals); `plans/M3-derivation.md` M3-J21-MX (BEL →
`[Tardif2008]` Thm 3.2; the prior-art paragraph). **Owed to the front-page lane (not this job's file):** the BEL attribution in
`plans/M3-S1D-windows-five.md` §3.2 (inventory row 69). **Noted:** anyone quoting `[KechrisMarks2020]` §4.6's "C(k) for k ≥ 5 is unknown"
quotes its Addendum (Shitov) beside it (row 70).

**The side find, as a recognition (row 72), for FS-67's re-aim (R4.F, added):** `[TardifWrochna2019]` Thm 2 makes the Moser spindle
strongly multiplicative — `G × H →` spindle implies `G →` spindle or `H →` spindle. FS-67 asks when a colouring of a product of local
targets must be local at one place; for spindle-valued maps it is a theorem in print. Append to FS-67's row in `plans/FRONTIER-STUBS.md`:
"**At M3's close:** for maps *into the Moser spindle* the answer is yes in print (`[TardifWrochna2019]` Thm 2, strong multiplicativity;
found by M3's prior-art reader, `plans/M3-PA-mixing.md` Stage 2)."

#### R5.2 The FS-66 checker re-run at 23 (M3-CHK23)

**CERTIFIED, exit 0** (log `data/m3/j22/fs66-cert-p23-m5-rerun.out`, 69 lines, last written 19:03:39; launched about 18:14 under a 16 GiB slot, so about 49 minutes wall, one core). The frozen checker (sha256 `735b926798ffac14…`, matching row 75's) re-verified the certificate `data/fs66/b1/cert-p23.json` (sha256 `28cf189c83d2…`) through all seven steps — step 6: "identity (*) holds on 134447 canonical monomials (46 blocks, 138706 rows), coefficient by coefficient in exact integers"; step 7: "5 * U_num = 48992318760443262233948788623512870 < 529 * scale" — and printed: "CERTIFIED: every phi in [0,1]^529 with q(phi) >= 0 has sum(phi) <= U = 97.984637… … so BY THE HAND-PROVED LINKS L1, L2, L6 (data/fs66/b1/SOUNDNESS.md) no UD(Z/23^k, 2), k >= 1, is 5-colourable. Standard-library checker, NOT the Lean kernel." **So D1-fac's clause at 23 is now confirmed first-hand** (grade: cert, an existing checker on an existing certificate), beside row 75's recorded verdict. Peak memory was not logged (no GNU time on this run); it stayed under the 16 GiB cap.
