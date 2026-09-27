*Instance block for job **FS107-V** (brief `data/fs107/briefs/V107-blind-verifier.md`). Filled in by the product owner on 2026-09-27, when FS107-R
handed back.*

- **The side verified:** R (stability). R's verdict on its main claims, R, R′ and R″, is GAP; do not verify those claims. Verify the four theorems
  it proved and the one implication it states.
- **The record** is `plans/FS107-R-stability.md`. It stays fenced until your stage 3 is committed.

## The statements, quoted verbatim from R's record ("Theorems this phase proved" and §3.4), in priority order

The words and grades are R's. Definitions (band-proper, partial six-colouring, junction, fat, void, SEQ, LIM) are in `data/fs107/claims.md`,
D-JUNC among them, and in `LEDGER.md` row 131.

1. **FS107-R-CP** (on both; on LIM the cone case of TS's C-T-TAN, quantified): "two fat junctions of complementary types at distance in
   `[η, 2 − η]`, blocking toward a point `w` at distance 1 from both, force `|H ∩ B(w, µ/4)| ≥ (t₁ − 2r)(t₁′ − 2r′)`, with `t₁ = s·sin(µ/2)/3`. The
   bound is independent of `ε`, moved only `O(ρs)` by any repair inside radius `ρ` of the junctions, and yields an uncovered disc." [hand, one mind]
2. **The implication in R's reduction** (R's §3.4, which R grades a [reading], one mind). Verify only the implication, "(A) and (B) ⟹ R", given CP.
   - "(A) branch (ii) is forced. For some `R, η, µ` and every band-proper partial six-colouring with holes `< δ` in `U_R`: `U_R` contains a
     complementary pair of junctions at distance in `[η, 2 − η]`, blocking toward a point at distance 1 from both."
   - "(B) a regularity scale. Those junctions are fat at a scale `s ≥ s₀`, with voids `r ≤ s·sin(µ/2)/12`."
   - "Given (A) and (B), Lemma CP gives `|H ∩ U_{R+1}| ≥ (s₀ sin(µ/2)/6)²`: R, and a C-VOID disc."
3. **FS107-R-SAT** (on both): "for a saturated band-proper partial six-colouring, the uncovered set is a.e. the **open** set
   `{z : |A_ε(z) ∩ C_j| > 0 for all six j}`." [hand, one mind]
4. **FS107-R-SW** (on SEQ): "a same-multicolour unit pair at flat boundaries of scale `s` costs `≥ εs` of holes, sharp for one colour; the other
   colour's facing half-discs cost `≳ s³` [sketch]." [hand, one mind] Verify the `εs` part, and give the `s³` part a verdict if you have the budget.
5. **FS107-R-OB′** (about arguments): "an argument that reads only one colour's pairs at a swap is capped at `O(εs)` per swap (hitting form)."
   [hand, one mind]

**Run the five killing tests of `claims.md` §3 on item 1 before you derive it.** A CP-type bound that survived the pinhole or strip test, or
that forced more than `δ₆ + O(ε)` of holes on the eroded Parts tiling, would contradict a held constraint. Name which one.

**Your record** is `plans/FS107-V-verification.md`.
