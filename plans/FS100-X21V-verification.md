# FS-100 wave 3 — X21V: blind verification of list X21 (ℚ(√167), and the `L ≥ 5` family, given MR)

*Job X21V (Coxeter, a blind verifier; Opus 5.5), crunch of 2026-09-26, wave 3. Brief:
`data/crunch-2026-09-26-x2x3/briefs/X21V-167-and-family-verifier.md` with `STANDING-RULES.md`. Stop 12:30 UTC. Fenced until stage 3 is
committed: X21D's record, data, brief and report, the advisor's record, X21D / "X23 advisor" commit bodies, and the proof of FS100-K0
(`plans/FS100-derivation.md` §2 K0 below its statement, `plans/FS100-J51V-verification.md` §2.7, `data/fs100/j53/`). None was opened.*

## Theorems this phase proved

*(filled at stage 3; one line per theorem, grade, address)*

## Stage 1 — SAVED (quotation check, the claims verbatim, C0)

### 1.1 The claims, copied verbatim from `plans/CRUNCH-2026-09-26-x2x3-queue.md` §7 (first paragraph) and list X21

§7, first paragraph (verbatim): **Kooshi, verbatim (relayed 06:17):** *"We still have usage left for crunching. Do these findings transfer to the other wanted posters? Please
continue the queue with asks about them."*

§7, "Where waves 1–2 left MR" (verbatim, the scope every claim uses): "EF_F⁺ is TRUE by two derivations (X01D; X12B blind,
by its own route), and X01V's GAP at the multiplier step was absorbed by X12B's rational-unit-vector multipliers. PE-2 is TRUE by X02D and
X02V blind, given EL2021 Thm 1.2 through (★); PE-1 as stated is FALSE. SP-Cor passed X05V blind. So **MR(F) holds for every real number
field at [hand] grade, with the scope of row 100's exception** (a ramified stable dyadic place, where `R = O′` is not proved; X09C's audit).
Every claim below is stated with that scope and asks whether its field is outside the exception. **"Given MR"** below means: given MR(F) at
the grade and scope just described; each job names it as an input and does not re-derive it."

List X21 (verbatim):

Inputs quoted verbatim:
- Row 117: "For `ℚ(√d)` real quadratic: every stable place of `ℚ(√d, i)` has all-levels four-colour ratio `< 1/4` ⟺ `d ≡ 47, 143, 167 (mod 168)`
  ⟺ `L(ℚ(√d)) ≥ 5`; and over every real number field where T-C(A) holds at `S = ∅`, J45's A⁺ and SP-Cor hold with J45's proofs — so MR(F) ⟹
  `χ(F²) ≥ 5` at ℚ(√143), ℚ(√311), ℚ(√335) as at ℚ(√47)."
- K0 (list of `data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md`): "J45's A⁺ and SP-Cor hold, with the same proofs, over every
  real quadratic field in T-C(A)'s class (so over ℚ(√143), ℚ(√311), ℚ(√335)), given T-C(A) there at `S = ∅`."
- J48-N4cor (stub §2, under T-J39-4): "For every totally real `F` with `N₄(F) = ∅` — every stable place 4-thick — MR(F) ⟹ `χ(F²) ≥ 5`", and
  J48-N4: "`N₄(ℚ(√167)) = ∅`: every stable place of ℚ(√167) is 4-thick, 23 by `0.331695… < 1/3` (margin `1.6·10⁻³`)".
- T-J39-3, T-J39-1 and T-J39-5, verbatim in the stub's §2 (J39 block); J48's corrections there included.

The claims:
- **Q-0.** "Every real quadratic field `ℚ(√d)` with `d ≡ 7 (mod 8)` has no stable dyadic place, so it lies outside row 100's exception."
- **A-1.** "Given MR, for every squarefree `d > 1` with `d ≡ 47, 143, 167 (mod 168)`: `χ(ℚ(√d)²) ≥ 5`."
- **A-2.** "Given MR, for every such `d` with `L(ℚ(√d)) = 5`: `χ(ℚ(√d)²) = 5`. This includes ℚ(√47), ℚ(√143), ℚ(√311) and ℚ(√335)."
- **A-3.** K0, as quoted above (a second mind on a one-mind input; X21V derives it blind).
- **A-4.** "Given MR, `χ(ℚ(√167)²) ≥ 5` by J48-N4cor, independently of row 117 and K0."
- **B-1.** "Given MR, at `F = ℚ(√167)`: `χ(F²) ≤ 5` iff `Y = UD(ℝ²) × G₂₃ × G₄₃` carries a CP five-colouring (T-J39-3 and T-J39-1 with MR(F)
  discharged)."
- **B-2.** "Given MR, if PL(23, 43) holds, then `χ(ℚ(√167)²) ≥ 6` iff `χ_CP(ℝ²) ≥ 6` (T-J39-5 (i), and (ii) with MR(F) discharged and J48's
  correction)."
- **B-3** (a question; the answer is a derivation or a GAP). "Name the weakest statement about `Y`'s factors (`UD(ℝ²)`, and `G₂₃`, `G₄₃` at full
  depth) that implies 'Y has no CP five-colouring', and say whether any held result gives it: row 75 (five refused at 23 at every level), row 71
  (five refused at 43 at level one), five-colour bounds on `m₁`-type densities of `ℝ²`."

### 1.2 Quotation check (standing rule 5), every quotation in the brief's claim list against its source

| quotation | source checked | result |
|---|---|---|
| Row 117's sentence | `LEDGER.md` line 155 (row 117) | **verbatim** (a substring of the row's bold headline) |
| K0 | `data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md` line 28 | **verbatim** |
| J48-N4cor | `plans/STUB-measure-rigidity-three-fields.md` §2.3, T-J39-4 block (lines 184–185) | **verbatim** |
| J48-N4 | same block (lines 181–182) | **verbatim** |
| T-J39-3, T-J39-1, T-J39-5 and J48's corrections | stub §2.3 J39 block (lines 169–190) | present verbatim; copied into §1.3 below |
| B-3's "row 71 (five refused at 43 at level one)" | `LEDGER.md` rows 69, 71 | **misattributed (not a quotation, a characterisation):** row 71 is "Five colours refused at 23" (`α(Γ₂₃) ≤ 105`); five refused at **43** is **row 69** ("Five refused at 43 (α ≤ 365 against the 370 five needs)"). The substance (five refused at 43 at level one) is right; the row number is wrong. Scored in B-3 with row 69. |
| B-3's "row 75 (five refused at 23 at every level)" | `LEDGER.md` row 75 | matches row 75's content (`m·B₁ < p²` refuses m colours at every level; 23 among its primes) |
| §7's "MR(F) holds for every real number field … with the scope of row 100's exception" | queue §7, second paragraph | verbatim above; row 100's exception: "except possibly at a ramified stable dyadic place" (`LEDGER.md` row 100) — matches |

### 1.3 The J39 block's statements used (verbatim, `plans/STUB-measure-rigidity-three-fields.md` §2.3)

- **T-J39-3**: "Let `N_k(F)` be the finite set of stable places of `F` that are not `k`-thick, and `Y_{F,k} = UD(ℝ²) × ∏_{v ∈ N_k(F)} G_v`. If
  `F²` is `k`-colourable, then **either** (A) `Y_{F,k}` carries a CP `k`-colouring, **or** (B) some `U`-invariant finite positive measure `τ` on
  `R̂` has `τ(E) = 0` and `∫ Re χ(1) dτ(χ) < 0` (an SP witness, so MR(F) fails, J45 SP-oi). Conversely (A) ⟹ `F²` is `k`-colourable. **So,
  given MR(F): `F²` is `k`-colourable iff `Y_{F,k}` has a CP `k`-colouring.**" (every `k`, every totally real `F`); J48's correction: step 5
  via Lemmas C and C′, with independent copies on the finitely many cosets at a ramified stable dyadic place with `R̄₂` proper.
- **T-J39-1**: "At `F = ℚ(√167)`, `k = 5`: `N₅(F)` is the four places above 23 and 43 (J21-TH; §2.3), and merging each conjugate pair
  (J21-SL) gives `Y = UD(ℝ²) × G₂₃ × G₄₃`. **The split places 2, 3, 5, 7, 29, 61 do not appear.**"
- **T-J39-5**: "(i) Unconditionally: `χ(ℚ(√167)²) ≥ 6 ⟹ χ_CP(ℝ²) ≥ 6`. (ii) If MR(ℚ(√167)) holds, 43's all-levels ratio is `< 1/5`, and
  PL(23, 43) holds, then `χ_CP(ℝ²) ≥ 6 ⟹ χ(ℚ(√167)²) ≥ 6`." PL(23, 43) is "every CP five-colouring of `UD(ℝ²) × G₂₃ × G₄₃` yields one of
  `UD(ℝ²)`". J48's correction: "(ii)'s hypothesis '43's all-levels ratio is `< 1/5`' is used by neither proof and is dropped."
- J39's notation (stub §2.3): "`G_v` the full-depth local plane at a stable place, 'CP colouring' a translation-invariant random colouring,
  continuous in probability, proper almost surely at each fixed edge; 'thick' means the place's compact local piece has mixing constant
  `λ* < 1/(k−1)`".

### 1.4 C0 — my priors that each claim is TRUE as stated (before any derivation)

| claim | C0 | the risk I see |
|---|---|---|
| Q-0 | 0.95 | none beyond an arithmetic slip |
| A-1 | 0.80 | a composition of verified inputs (row 117, R88-TCA's class form, K0); risk is a scope mismatch between them |
| A-2 | 0.75 | the upper bound's field-level step (row 57's "Not proved" clause) and whether each named field really has `L = 5` |
| A-3 | 0.80 | "A⁺ hold[s]" is quantified over every finite `S`, while the hypothesis is T-C(A) at `S = ∅` only |
| A-4 | 0.85 | whether J48-N4cor's route secretly uses row 117 or K0 |
| B-1 | 0.80 | a direct instance of T-J39-3 + T-J39-1; the only risk is the merge (an input) |
| B-2 | 0.80 | as B-1 |
| B-3 | 0.05 that a held result gives "Y has no CP five-colouring" | — |

### 1.5 Would-have-searched-here log (running)

- (none yet)
