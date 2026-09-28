# FS-122 — the forced pair at every complexity (route R's third statement): must every near-colouring of the plane with small holes carry a close complementary pair of fat junctions? (stub)

*Minted 2026-09-28 by the close job FS111-C at FS-111's close from the planner's draft `data/fs111/fs111-p/STUB-DRAFT-forced-pair.md`, corrected by what
FS-111 found (`plans/FS111-close-inventory.md` items 5, 20, 23; `plans/FS111-C-close.md` § Stage 5). Sibling of FS-121 (route M). **Solver column:
in-ban** — derivation and reading. Written for a session with no memory of FS-111: read `CLAUDE.md` § The aim and § Counter-priors first, then `LEDGER.md`
row 133, `plans/FS107-derivation.md` (FS107-RR, FS107-R-CP, and its §5 erratum), `plans/FS107-R-stability.md` §3.4, and `plans/FS111-derivation.md`
(FS111-C1-ROUTES, FS111-W-NEG, FS111-W-B-NONABS, FS111-W-HX-PAIRS).*

## The question

FS-107's reduction (FS107-RR, two minds, one blind, after two repairs): given the quantified cone lemma FS107-R-CP, seven (`χ_m⁰(ℝ²) ≥ 7`) follows from
**(A)** a complementary pair of fat junctions at distance in `[η, 2 − η]`, blocking toward a point at distance 1 from both, in every disc `U_R` of every
band-proper partial six-colouring with holes `< δ` in `U_R`, and **(B)** a lower bound `s₀` on their cone scale. FS-111's card 1 (two minds, one blind)
showed this is a **complete route to seven in which FS-114's map NO is idle** (`FS111-C1-ROUTES`); its third statement is **A-ALL**, (A) over every
complexity.

**What FS-111 established about it (two minds, one blind): A-ALL, with its `δ` quantified with `R, η, µ`, holds iff `χ_m⁰(ℝ²) ≥ 7`** (`FS111-W-NEG` (iii):
with seven it holds vacuously; its failure gives holes `< δ` in every `U_R`, which is `χ_m⁰ ≤ 6` by row 131's disc form). **So A-ALL is the answer
restated**, as REG-A₆ is on route M; no wild object can refute it without six (R's registration P3 is a bet on six). Its value is its method: a **local
count** — `[Voronov2023]` Lemma 6.1's count of junction types, made robust — that forces the pair before holes are known to be bounded.

**The smaller statements this route has:**
1. **B-RR** — a cone-scale lower bound `s₀`, **independent of `δ`**, at the pairs (A) supplies. The `δ`-dependent form B-NONABS is FALSE as written
   (`FS111-W-B-NONABS`: a fragment has holes `≲ (ε + s)²` near the forced point at every scale `s`); B-RR cannot be refuted by a wild object.
2. **What replaces the bicycle's swap at unbounded complexity** — the index of density traces (G71, row 132) is the one integer invariant held for
   six-colour interfaces, and it fails where a unit-arc interface faces a bowtie; `[Voronov2023]` Lemma 6.1's branch (i) ends at a bicycle, whose swap
   FS107-R-SW prices at `2εs` and `s³/256`.
3. **Where the pair's unit point sits.** In HX (the hexagonal seven-colouring with one class absorbed) complementary blocking pairs exist and their unit
   points lie inside HX's voids (`FS111-W-HX-PAIRS`, one mind; FS-107's "K-C6 vacuous" corrected by the §5 erratum), and CP's bound there is `≈ 10⁻¹¹`
   against a stall of `0.0432`: CP locates holes, it does not size them. A route-R proof needs the count to size them too.

## Bearing on the answer

**Decisive, and the answer restated:** A-ALL with B-RR and CP gives `χ_m⁰(ℝ²) = 7`, so `χ(ℝ²) = 7` given MR, **with no map NO**; A-ALL's failure is
`χ_m⁰(ℝ²) ≤ 6`, so `χ(ℝ²) ≤ 6` with no MR. Because A-ALL is equivalent to seven, this stub's progress is measured by B-RR and by a robust Lemma 6.1 count —
each smaller than the answer. Under Condition 5 at bounded complexity no close complementary pair exists in a valid map at all (row 134, NB-5), which is
why the map line never needed (A); so this route and FS-121's meet nowhere below the answer.

## Registered expectations (instruments, never caps)

- B-RR decided at one mind: **0.1**. A robust Lemma 6.1 count on a named class of near-colourings (bounded complexity first): **0.25**.

## Provisional bearings (replaced by the re-grokking at the opening)

G15 (pigeonhole × kill: the count is the pigeonhole, CP the kill), G71 (the index), G40 (non-absorption, read `δ`-independently — FS-111's X9 misfired on
exactly that), G79, G82, G21. Rows 131–134. Stubs: FS-121 (the other route), FS-109 (the dial), FS-110's closed record (SWAP-PRICE).
