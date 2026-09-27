# FS107-V — blind verification of competitor R's five statements (FS-107, stability)

*Job FS107-V, de Bruijn (Opus 5.5), blind verifier. Brief: `data/fs107/briefs/V107-blind-verifier.md`, instance block
`data/fs107/briefs/V107-instance-R.md`, standing rules `data/fs107/briefs/STANDING-RULES.md`. Started 2026-09-27 at HEAD `209ce4f2`.
Read before stage 1: the brief, the instance block, the standing rules; `CLAUDE.md` from disk (§ The aim, § Counter-priors, G21, G82);
`LEDGER.md` rows 131–132; `data/fs107/claims.md` in full; `data/fs106/claims.md` §§0–2; `plans/FS106-TS-derivation.md` stage 4 (C-T-TAN)
and stage 5; `[Parts2020c]` §§1, 2.3 (text layer); A8b's line in `plans/POROS-2026-09-26-fs106-regular-half.md`.*

**Fences.** None touched. R's record `plans/FS107-R-stability.md` stays unopened until stage 3 is committed. I did run
`grep -c` for the words "fat", "CP", "blocking" over the unfenced plans and briefs, to learn whether R's definitions had been
copied anywhere I may read (they had not: the only hits are the instance block itself, `χ_CP`, and "fat Cantor set").

## Stage 1 — SAVED: quotation check, restatements, registered expectations

### 1.1 Quotation check (standing rule 5)

The instance block's five statements are R's own theorems. They are quoted from R's record, which is fenced, so they cannot
be checked against their source until stage 4. What can be checked now is every term and reference they borrow from the
claim list.

| item | what the instance block says | checked against | result |
|---|---|---|---|
| definitions | "Definitions (band-proper, partial six-colouring, junction, fat, void, SEQ, LIM) are in `data/fs107/claims.md`, D-JUNC among them, and in `LEDGER.md` row 131." | `claims.md` §0 and the objects list; row 131 | **Partly false.** SEQ, LIM, D-JUNC ("junction", "type", "complementary types"), band-properness (D-MU, row 131) and partial colourings are there. **"Fat", "void" (as a term with a radius `r`), "blocking toward `w`", the angle `µ`, the scale `s`, `t₁′`, "saturated", `A_ε(z)`, "swap", "flat boundaries of scale `s`" and "facing half-discs" are defined in neither.** They are R's definitions, in R's fenced record. So items 1, 2, 4 and 5 are not self-contained: I verify them against definitions I reconstruct (§1.2) and compare at stage 4. |
| item 1's reference | "on LIM the cone case of TS's C-T-TAN, quantified" | `claims.md` K-TAN; `plans/FS106-TS-derivation.md` stage 4, C-T-TAN | matches: C-T-TAN is TRUE there [hand, one mind], stated with slice sets `T_u`, `T_v` and a parallelogram `Π`; its failure set at cone points is tangent interfaces and bowties. |
| the killing tests the instance block paraphrases | "A CP-type bound that survived the pinhole or strip test, or that forced more than `δ₆ + O(ε)` of holes on the eroded Parts tiling, would contradict a held constraint." | `claims.md` §3, R's tests 1, 3, 5 | a faithful paraphrase of tests 1, 3 and 5 (the owner's words, not a quotation). |
| item 2's references | "(A) branch (ii)", "R, and a C-VOID disc" | `claims.md` §1 (R = C-Q-STAB, R′ = C-VOID) | R and C-VOID match `claims.md` §1; "branch (ii)" is R's own case split, unverifiable before stage 4. |
| item 5's "(hitting form)" | "capped at `O(εs)` per swap (hitting form)" | `claims.md` §0 "Hitting-form argument" (QB §1.2) | the term is defined there; whether a one-colour argument at a swap is of that form is part of the verdict. |

### 1.2 The statements in my own words, with the definitions I reconstruct

Notation (mine): `C₁, …, C₆` disjoint measurable classes, *band-proper at `ε`*: `(Leb ⊗ Leb){(x, y) ∈ C_j² : 1 − ε ≤ |x − y| ≤ 1 + ε} = 0`
for each `j` (for LIM, `ε = 0` read as `Leb ⊗ σ`-null unit pairs, D-M). `H = ℝ² ∖ ⋃ C_j`, the uncovered set. `A_ε(z) = {y : 1 − ε ≤ |y − z| ≤ 1 + ε}`.

1. **CP.** Reconstructed reading: a junction at `u` is *fat at scale `s` with void `r`* if each colour of its three-element type
   fills (up to a null set) a connected open region `A_j ⊆ B(u, s) ∖ B(u, r)` whose projection on a line through `u` is long;
   *blocking toward `w`* (with `|w − u| = |w − v| = 1`) means the projections of the three regions at `u` on `e_u = w − u` share an
   interval of length `≍ s·sin(µ/2)`, and likewise at `v` on `e_v = w − v`. In my words: **if two junctions of complementary types, at
   distance in `[η, 2 − η]`, each have their three colours filling regions of size `s` that all "reach" the same side of the unit circle
   through `w`, then a region near `w` of area at least `(t₁ − 2r)(t₁′ − 2r′)` is uncovered, whatever `ε` is; shrinking or repairing the
   colouring inside radius `ρ` of the junctions changes this by `O(ρs)`, and the region contains a disc.** It is Voronov's Prop. 2.2
   (V-P2.2) made quantitative: the pinhole that V-P2.2 finds at `w` becomes a region of fixed size when the colour pieces at `u` and `v`
   are fat.
2. **The implication.** If every band-proper partial six-colouring with small holes in `U_R` has such a pair (A), fat at a scale bounded
   below independently of `ε`, with small voids (B), then CP gives an `ε`-independent amount of hole in a fixed disc, so C-Q-STAB (R)
   holds: either the holes are already `≥ δ` or CP supplies `(s₀ sin(µ/2)/6)²`.
3. **SAT.** Reconstructed reading of *saturated*: no class can be enlarged by a positive-measure piece of `H` and stay band-proper. In
   my words: **for such a colouring the holes are, up to a null set, exactly the points whose band annulus meets every one of the six
   classes in positive area — and that set is open.**
4. **SW.** Reconstructed reading: `p`, `q` with `|p − q| = 1`, each with multicolour `{a, b}`, and inside `B(p, s)`, `B(q, s)` the colouring
   is two half-discs separated by a straight boundary through the centre, up to holes. In the cheapest orientation (boundaries
   perpendicular to `pq`, the colours mirrored) one colour's half-discs face away from each other and the other colour's face each
   other. In my words: **such a pair forces holes of area at least `εs`; for the away-facing colour a strip of width `ε` achieves this
   order, so it is sharp; the facing colour forces `≳ s³`, which does not depend on `ε` [R: sketch].**
5. **OB′.** In my words: **a lower-bound argument whose only input at a swap is the band-properness of one colour's pairs can certify at
   most `O(εs)` of hole there** — because a strip of width `ε` satisfies that input.

### 1.3 Registered expectations (before any derivation; both outcomes reachable)

| item | expected verdict | probability | the other reachable outcome, and what would show it |
|---|---|---|---|
| 1 CP | TRUE as an exclusion lemma; the `ε`-independence is elementary (the exclusion of colour `j` from `A_j + S¹` holds for every `ε ≥ 0`) | 0.7 | MISSTATED at the constants (0.25): the curvature of unit circles moves the linear projection by `O((s + |b|)²)`, so `t₁ = s sin(µ/2)/3` and containment in `B(w, µ/4)` need a smallness condition on `s` relative to `µ` and `η` that the statement does not show; FALSE (≤ 0.05) only if the exclusion step itself fails |
| 2 implication | TRUE, possibly after a radius repair | 0.7 | GAP (0.3) if the quantifiers of (A), (B) let `s₀`, `µ` or `η` depend on `ε`, or if CP needs `s` bounded above and (B) does not provide it |
| 3 SAT | TRUE | 0.9 | MISSTATED if "saturated" is not maximality under adding positive-measure pieces of `H` |
| 4 SW, `εs` | TRUE | 0.85 | FALSE if some flat orientation is cheaper than `εs` |
| 4 SW, `s³` | TRUE | 0.65 | FALSE or smaller order if the facing colour's conflicts can be removed by holes of area `o(s³)` |
| 5 OB′ | TRUE for the away-facing colour; **MISSTATED if "one colour" may be the facing colour and the `s³` bound holds** (then reading that colour certifies `≳ s³`, not `O(εs)`) | 0.5 / 0.5 | decided by item 4's `s³` part and by R's definition of "reads only one colour's pairs" |

**Would have searched here:** nothing yet.
