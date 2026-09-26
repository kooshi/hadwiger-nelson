# FS100-X21D — ℚ(√167) and the `L ≥ 5` family, given MR (crunch 2026-09-26 ×2×3, wave 3, job X21D)

*de Bruijn, Opus 5.5. Brief: `data/crunch-2026-09-26-x2x3/briefs/X21D-167-and-family-derivation.md` with its `STANDING-RULES.md`.
Stop time 12:30 UTC. A blind verifier (X21V) works the same list; no contact. Working files `data/fs100/x21d/`; checks `tools/x21d_*.py`.*

## Theorems this phase proved

*(filled at each stage; one line per theorem, grade, address)*

## The fixed claim list, copied verbatim (`plans/CRUNCH-2026-09-26-x2x3-queue.md` §7, first paragraph and list X21)

**Where waves 1–2 left MR** (from the reports, `data/crunch-2026-09-26-x2x3/reports/`): EF_F⁺ is TRUE by two derivations (X01D; X12B blind,
by its own route), and X01V's GAP at the multiplier step was absorbed by X12B's rational-unit-vector multipliers. PE-2 is TRUE by X02D and
X02V blind, given EL2021 Thm 1.2 through (★); PE-1 as stated is FALSE. SP-Cor passed X05V blind. So **MR(F) holds for every real number
field at [hand] grade, with the scope of row 100's exception** (a ramified stable dyadic place, where `R = O′` is not proved; X09C's audit).
Every claim below is stated with that scope and asks whether its field is outside the exception. **"Given MR"** below means: given MR(F) at
the grade and scope just described; each job names it as an input and does not re-derive it.

### List X21 — ℚ(√167), and the `L ≥ 5` family (X21D derives; X21V verifies blind)

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

### The J39 inputs, verbatim from `plans/STUB-measure-rigidity-three-fields.md` §2.3 (J39 block)

- **T-J39-3** (§3.2): "Let `N_k(F)` be the finite set of stable places of `F` that are not `k`-thick, and `Y_{F,k} = UD(ℝ²) × ∏_{v ∈ N_k(F)}
  G_v`. If `F²` is `k`-colourable, then **either** (A) `Y_{F,k}` carries a CP `k`-colouring, **or** (B) some `U`-invariant finite positive measure
  `τ` on `R̂` has `τ(E) = 0` and `∫ Re χ(1) dτ(χ) < 0` (an SP witness, so MR(F) fails, J45 SP-oi). Conversely (A) ⟹ `F²` is `k`-colourable. **So,
  given MR(F): `F²` is `k`-colourable iff `Y_{F,k}` has a CP `k`-colouring.**" (every `k`, every totally real `F`)
  *J48's correction (§3.4 item 1; the theorem unchanged):* step 5's "`R̂_prof = ∏_{stable w} O_{L_w}`" had no input — by Lemma C
  (FS91-J07-3) the profinite and stable topologies on `R` agree, and by Lemma C′ (FS91-J07-4) `(L⊗ℝ) × R̂_prof` is an open subgroup of
  finite index of `(L⊗ℝ) × ∏_{stable w} O_{L_w}`, equal to it unless a stable dyadic place is ramified in `L/F` with `R̄₂` proper
  (ℚ(√5)); there the colouring extends by independent copies on the finitely many cosets. Lemmas C and C′ join its inputs.
- **T-J39-1** (§3.2): "At `F = ℚ(√167)`, `k = 5`: `N₅(F)` is the four places above 23 and 43 (J21-TH; §2.3), and merging each conjugate pair
  (J21-SL) gives `Y = UD(ℝ²) × G₂₃ × G₄₃`. **The split places 2, 3, 5, 7, 29, 61 do not appear.**"
- **T-J39-5** (§3.3 (f)): "(i) Unconditionally: `χ(ℚ(√167)²) ≥ 6 ⟹ χ_CP(ℝ²) ≥ 6`. (ii) If MR(ℚ(√167)) holds, 43's all-levels ratio is `< 1/5`,
  and PL(23, 43) holds, then `χ_CP(ℝ²) ≥ 6 ⟹ χ(ℚ(√167)²) ≥ 6`." PL(23, 43) is "every CP five-colouring of `UD(ℝ²) × G₂₃ × G₄₃` yields one of
  `UD(ℝ²)`" (§3.3 (b)).
  *J48's correction (§3.4 item 2):* (ii)'s hypothesis "43's all-levels ratio is `< 1/5`" is used by neither proof and is dropped.

## Stage 1 — SAVED (quotation check, C0)

### 1.1 Quotation check (standing rule 5), 06:25

| quotation (in §7) | source | result |
|---|---|---|
| Row 117 | `LEDGER.md` row 117, bold headline | verbatim ✓ |
| K0 | `data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md` line 28 | verbatim ✓ |
| J48-N4cor, J48-N4 | stub §2.3, T-J39-4 bullet | verbatim ✓ |
| T-J39-3, T-J39-1, T-J39-5 (+ J48's corrections) | stub §2.3 | copied above from the source directly |
| "MR(F) holds for every real number field … with the scope of row 100's exception" (§7 ¶1) | `plans/FS100-derivation.md` FS100-MR: "MR(F) holds for every real number field `F` with `R = O′`"; row 100: "`R_F = O′` … with **no Galois hypothesis**, except possibly at a ramified stable dyadic place" | consistent: §7's scope is FS100-MR's hypothesis `R = O′`, which row 100 supplies outside the exception. **Note:** FS100-K0 (the derivation file's form) is wider than the brief's K0 quote — "over every real number field where T-C(A) holds at `S = ∅`" against "every real quadratic field in T-C(A)'s class"; A-3 is judged on the brief's quote, and the wider form noted |

### 1.2 C0 — probabilities, written 06:26 before the stage-2 derivation

*Honest note (G21, the X12B slip):* before writing these I had already checked Q-0's local computation mentally (`ℚ₂(√d) = ℚ₂(i)` for
`d ≡ 7 (mod 8)`) and the four fields' residue symbols at 11; the Q-0 and A-2 numbers are therefore informed, not sealed priors.

| claim | P(TRUE) | where I expect failure if any |
|---|---|---|
| Q-0 | 0.95 | only if "row 100's exception" is wider than "a stable dyadic place ramified in `L/F`" |
| A-1 | 0.70 | T-C(A)@∅'s class form is one mind (J28D); FS100-T1 for a general `d` (ramified 11, 19, 23, 31 when they divide `d`); any ℚ(√47)-specific step inside SP-Cor/A⁺ |
| A-2 | 0.75 | as A-1, plus the upper bound's field-level step (row 52 / row 57's gap) — hand-grade prior art should cover it |
| A-3 | 0.75 | a ℚ(√47)-specific input inside J45's proofs (N1, SI, R-U) |
| A-4 | 0.65 | J48-N4cor's own chain (T-J39-3 at `k = 4` with `N₄ = ∅`, de Grey's graph a.s.); "independently of row 117 and K0" — T-J39-3's route may share SP/R-U with K0's |
| B-1 | 0.70 | T-J39-3's (⟸) and step 6 at `k = 5`; MR's scope at ℚ(√167) (dyadic split: fine) |
| B-2 | 0.55 | (ii) with the 43 hypothesis dropped: whether `χ_CP(ℝ²) ≥ 6` and PL alone refuse `Y`, i.e. whether `G₄₃` needs no refusal of its own |
| B-3 | — (a question) | expected answer: a Hedetniemi-type "product of CP-refusers refuses" statement, not held |

### 1.3 Would-have-searched-here log (running)

- (none yet)
