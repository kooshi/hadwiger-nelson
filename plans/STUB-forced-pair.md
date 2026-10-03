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

**At FS-121's close (2026-10-03, FS121-Z1).** Nothing of FS-121 bears on this route below the answer. One colour-generic tool is shared and untested
here: any a.e.-proper colouring becomes a measurable Grundy colouring without raising a point's colour index (FS121-D3-GRUNDY, held).

## Registered expectations (instruments, never caps)

- B-RR decided at one mind: **0.1**. A robust Lemma 6.1 count on a named class of near-colourings (bounded complexity first): **0.25**.

## Provisional bearings (replaced by the re-grokking at the opening)

G15 (pigeonhole × kill: the count is the pigeonhole, CP the kill), G71 (the index), G40 (non-absorption, read `δ`-independently — FS-111's X9 misfired on
exactly that), G79, G82, G21. Rows 131–134. Stubs: FS-121 (the other route), FS-109 (the dial), FS-110's closed record (SWAP-PRICE).

## A card carried for the opening (filed by Keryx, 2026-09-29)

*Poros's card from the close re-read of 2026-09-28 (`plans/POROS-2026-09-28-close-reread.md` § 2.4, card 1), re-addressed here by Poros's
job FS116-P1 (`plans/POROS-2026-09-28-fs116-question.md` § 2.4). Both quoted verbatim; the card's `answered by` line predates the re-address.*

```
question: do-fs114-kills-survive-a-band
  evidence: drafted row 138, "Every kill is a straddle … seen at second order" (`plans/FS114-C-close.md` l. 418); FS114-Y5-PXKILL "appears only at
    second order (YB4-2ND)" (§2.3); FS111-C1-UNIF "seven iff `inf_K δ₀(K) > 0`" and C1-PW "Q-NO ⟹ `δ₀(K) > 0` for every `K`" (FS111-C §B lines);
    FS107's H-EQ: a refutation is a sequence of periodic grid-square colourings (`CLAUDE.md` § The aim, link 5); G82
  expected: that some FS-114 kill had been priced against a band — none was
  ask: Does FS114-Y4-RSTOPALL, the bowtie killed at `√3`, survive as an exclusion for band-proper fragments with slack ε and small holes, at a radius and margin independent of ε and the complexity?
  if it survives: a robust route M exists — FS-116 posed on FS-107's grid-square near-colourings (with a robust form of CV-EXISTS) is a route to seven
    with no map step; FS-116 is posed that way from its opening, and FS-121 drops below FS-104
  if it dies: the margin is second-order in a scale the band can shrink; FS-116 stays exact, route M needs FS-121 as ranked, and G82's pricing rule
    gains an instance
  answered by: derivation — a fresh mind at FS-116's opening (its §IQ), on one kill, before round 7's queue
  cost: one to two hours of one derivation
  hunch: it dies — the straddle's margin is the square of the configuration's own scale, and at unbounded complexity nothing bounds that scale below
  falsifier: RSTOPALL re-derived with slack ε and holes < η at a radius and margin independent of ε, η and complexity
  rank: 1
```

> **R1's card 1, `do-fs114-kills-survive-a-band`: re-addressed to FS-122's opening (route R), not asked at FS-116.** Even if one kill survived a band, FS-116
> could not be posed on near-colourings from its opening. That posing needs a robust form of FS114-CV-EXISTS (a fat four-colour point in every band-proper
> near-colouring with small holes). CV-EXISTS goes through stuck chains of the terminal modification, a global and exact argument
> (`plans/FS114-derivation.md` l. 26 on), and no one has a robust form. A band-stable local kill is a statement of route R's kind, beside (A) and B-RR, so
> its home is FS-122. Hunch `kills-are-not-band-stable` stays open. **Default if Keryx says nothing:** the card is carried in FS-122's stub at its opening,
> and FS-116 does not ask it.
