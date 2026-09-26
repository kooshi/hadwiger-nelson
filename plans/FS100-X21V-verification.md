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

## Stage 2 — SAVED (blind derivation: the control first, then A-3 = K0, then the rest)

*Tool: `tools/x21v_checks.py` (exact Legendre arithmetic, PARI `idealprimedec`, a complete enumeration of the 168 residues, and one float
character sum), 6 s; run log `data/fs100/x21v/checks-run.log` (ALL PASS); three plants, each fired for its own reason
(`data/fs100/x21v/plant-{dyadic-rule,class,circle}.log`: the flipped mod-8 rule disagrees with PARI at d = 3, 11, 19, …; the wrong class
list fails C2; a circle short of one point moves 23's constant from 0.33170 to 0.38327).*

### 2.0 Two local facts used throughout (hand; C1, C3 check them against PARI)

For `F = ℚ(√d)`, `d > 1` squarefree, `L = F(i)`, a place `v` of `F` is **stable** (one place of `L` above it, conjugation-fixed) iff `−1` is
not a square in `F_v`.
- **Odd `p`.** `p ∤ d`, `(d/p) = 1`: `F_v = ℚ_p`, stable iff `p ≡ 3 (4)`, residue `𝔽_p`. `(d/p) = −1`: `F_v = ℚ_{p²}`, `−1` is a square in
  `𝔽_{p²}`, never stable. `p | d`: `F_v` ramified with residue `𝔽_p`, stable iff `p ≡ 3 (4)`. **So every stable odd place of a real quadratic
  field has residue field `𝔽_p`, `p ≡ 3 (mod 4)`, and it is stable iff `p | d` or `(d/p) = 1`.**
- **`p = 2`.** If `F_v` is a field, `−1 = (a + b√d)²` forces `a = 0` (else `2ab ≠ 0`) and then `−1/d`, i.e. `−d`, is a square in `ℚ₂`.
  **So the dyadic place is non-stable iff `−d ∈ ℚ₂^{×2}` iff `d ≡ 7 (mod 8)`.** (C1: equal to PARI's decomposition on all squarefree
  `d < 400`; controls: `d = 5, 17` give a *ramified* stable dyadic place — exactly the fields row 100 names for its exception, reproduced;
  `d = 59` an unramified (inert) one, `U₂`.)

### 2.1 Q-0 — TRUE [hand + tools exact]

`d ≡ 7 (mod 8)` ⟹ `−d ≡ 1 (mod 8)` ⟹ `−d = s²`, `s ∈ ℤ₂` (Hensel) ⟹ `−1 = (s/√d)²` in `F_v = ℚ₂(√d)` ⟹ the dyadic place splits in `L`, the
two places above it are swapped by conjugation, and no stable dyadic place exists; row 100's exception ("a ramified stable dyadic place")
cannot occur. The converse also holds (2.0), so among real quadratic fields **"no stable dyadic place" is exactly `d ≡ 7 (mod 8)`.**

### 2.2 A-1's control, written before A-1 (as the brief asks)

**What a wrong-reason pass would look like.** Take three fields where §7 says MR holds and where `χ ≤ 4` is known:
- **ℚ(√23)** (`23 ≡ 7 (8)`, so outside row 100's exception by Q-0; `23 ≡ 2 (3)`): C3 lists **7 stable**, target `Γ₇`, `α(Γ₇) = 14`
  (row 70), ratio `14/49 = 2/7 > 1/4`; `χ(ℚ(√23)²) = 4` (row 73).
- **ℚ(√31)** (`31 ≡ 7 (8)`, `31 ≢ 2 (3)`): **3 stable**, `Γ₃`, ratio `1/3`; `χ = 3` (`d ≡ 7 (mod 12)`, G61).
- **ℚ(√59)** (`59 ≡ 3 (8)`): the dyadic place is stable and **unramified** in `L/F` (C1), so not row 100's exception; target `U₂ = K₄`,
  ratio exactly `1/4` (Hoffman-tight), not `< 1/4`; `χ ≤ 4`.

At each, the chain "MR ⟹ χ ≥ 5" **must** break, because its conclusion is false while MR holds. **Where it breaks, derived:** the residue
colouring `c` at the non-thick place (at `Γ₇`, `Γ₃`, `U₂`) is periodic modulo a finite-index ideal of `R`; the uniform measure on its finitely
many translates is a translation-invariant Borel probability on `X₄(F)` whose spectral measure sits on finitely many torsion characters, `⊆ T
= E_∅`. So **T-C(A) at `S = ∅` is false there**, A⁺ at `S = ∅` fails for that `μ` (SI-3 is 0 at every `u`), and SP-Cor's line "`∫_{R̂∖E_∅}
Re χ(1) dσ_μ < 0` by A⁺" is the line that breaks. Every other step — amenability of `R ⋊ U` (P6), R-U (every real number field), MR, the Haar
integral — holds at all three. **So a correct derivation of A-1 must use the count against every stable place (the class hypothesis of
R88-TCA) at the T-C(A) step, and nowhere else can it stop.** A wrong-reason pass is any route whose steps all hold at one of the three:
arguing from `d ≡ 7 (mod 8)` alone (valid at 23, 31), from MR + R-U + P6 alone (valid at all three), or a T-C(A) count that omits the places
above 3 or 7 (valid at 23 and 31). Each proves a false `χ ≥ 5`. **The chain below uses the class exactly at the T-C(A) step** (2.4 step 2).

### 2.3 A-3 (K0) — blind: **TRUE, with one scope note** [hand, second mind; J45's proofs walked, K0's own proof unread]

**Statement derived.** *For every real number field `F` (quadratic or not) and every finite set `S` of split places: T-C(A)(F) at `S` ⟹
A⁺(F) at `S`; and T-C(A)(F) at `S = ∅` ⟹ SP-Cor(F): MR(F) ⟹ `χ(F²) ≥ 5`.*

*A⁺ at `S`* (J45 Stage 3, walked line by line for any input specific to ℚ(√47)): equality at every `u` ⟹ (SI-4) `c′ = min ∘ M` is an
`𝒜_S`-measurable equivariant proper four-colouring; its law is a translation-invariant probability on `X₄(F)`; the coordinates of `e_{c′(0)}`
lie in `L²(𝒜_S)`, so (N2) its spectral measure is carried by `E_S`; T-C(A) at `S` forbids that. The inputs and their scope:
- SI-1 to SI-4, N1, N2: stated in J45 §1.2's notation for any real `F`; N1's density step uses weak approximation for the norm-one torus (a
  rational curve, any number field) and `|R/NR| ≤ N^{rank R}` for a torsion-free group of finite rank (any number field); N2 is Hilbert-space
  and Bochner. J45 built `G′_S` precisely so that **no Lemma R, no Lemma C** enters — so not even row 100's exception bites here.
- T-C(A) at the same `S`: the hypothesis. **Nothing else about ℚ(√47) is used** (J45's own heading already says "and every field in T-C(A)'s
  class").

*SP-Cor* (J45 §4.2, walked): `X₄(F) ≠ ∅` is compact and invariant under `R ⋊ U` (countable; abelian-by-abelian, hence amenable — `U` is the
norm-one group of `L`, abelian, for every `F`); an invariant `μ`; rotation about 0 gives `C(vy) = C(y)`, so `σ_μ` is `U`-invariant; R-U
(J45: "for every real number field") gives `σ_μ(E ∖ (T + A)) = 0`; A⁺ **at `S = ∅`** with its remark (ii) (a `U`-invariant `σ_μ` makes the
integral constant in `u`) gives `∫_{R̂∖E_∅} Re χ(1) dσ_μ < 0`; so `τ = σ_μ|_{R̂∖E}` is positive, `U`-invariant, `E`-null, with `∫ Re χ(1) dτ < 0
= ∫ Re χ(1) d(Haar)` — not a Haar multiple, contradicting MR(F). Only T-C(A) at `S = ∅` is used; no degree, no class condition, no Lemma C.

**The scope note (not a defect of truth; a wording one).** K0 says "J45's A⁺ … hold[s] … given T-C(A) there at `S = ∅`". J45's A⁺ quantifies
over **every finite `S`**, and its proof at a given `S` consumes T-C(A) **at that `S`**. From T-C(A) at `S = ∅` alone the same proof gives
A⁺ at `S = ∅` for every `μ`, and at every `S` for **rotation-invariant** `μ` (R-U makes `∫_{R̂∖E_S}` and `∫_{R̂∖E_∅}` agree); for a
non-rotation-invariant `μ` at `S ≠ ∅` it does not. Over T-C(A)'s class the gap is filled by R88-TCA's class form, which states T-C(A) at
every finite `S` — so K0 is TRUE over the class as a statement, and TRUE as literally worded only with A⁺ read at `S = ∅` (all SP-Cor uses).
Row 117 already carries this ("A⁺ at a finite `S ≠ ∅` needs T-C(A) at that `S`, which the class form supplies"): **agreement, reached blind.**

**Widening (derived):** "real quadratic" is not used; K0 holds over every real number field satisfying T-C(A) at `S = ∅` — which is row
117's own phrasing ("over every real number field where T-C(A) holds at `S = ∅`").

### 2.4 A-1 — **TRUE given its inputs** [hand; a composition]

For squarefree `d > 1`, `d ≡ 47, 143, 167 (mod 168)`, `F = ℚ(√d)`:
1. **The class.** C2: the residues mod 168 with `d ≡ 7 (8)`, `d ≡ 2 (3)`, `d` a non-residue mod 7 are exactly `{47, 143, 167}`. By 2.0 those
   three congruences say: no stable dyadic place; 3 not stable (3 stable iff `d ≡ 0, 1 (3)`); 7 not stable (iff `7 | d` or `(d/7) = 1`). So
   the targets `U₂ … U₃₂` (ratio `≥ 1/4`), `Γ₃`, `Γ₇` are absent; the remaining stable places are odd `p ≡ 3 (4)`, `p ≥ 11`, whose all-levels
   ratios `< 1/4` are row 117's inputs (FS-66 at 11, 19; Hoffman at 23, 31, …, 31's `1/4 − 2.745·10⁻⁶` the largest; Weil; Lemma P at a
   ramified one) — **not re-derived here** (verified input). So `F` is in R88-TCA's class.
2. **T-C(A)(F) at `S = ∅`** — R88-TCA's class form (verified input; one mind outside ℚ(√47)). *This is the step the control says must carry
   the class (2.2), and it does.*
3. **A⁺ at `S = ∅` and SP-Cor over `F`** — 2.3.
4. **MR(F)** at §7's scope: `F` is outside row 100's exception by Q-0 (`47, 143, 167 ≡ 7 (mod 8)`).
5. So `χ(F²) ≥ 5`. ∎

*Remark.* The weakest link is step 2's class form (one mind, J28D) — its proof's use of Lemma C/C′ is safe on this family because Q-0 removes
the only place where `R = O′` is unproved. A-1 inherits exactly the grades of row 117, R88-TCA's class form and MR.

### 2.5 A-2 — **TRUE given A-1** [hand + tools exact + kernel lemma]

Lower bound: A-1. Upper bound: `L(F) = 5` supplies a stable place whose residue target is five-colourable; for a real quadratic field with no
stable dyadic place (Q-0) the targets are `Γ_p` at stable odd `p` (2.0), and `𝔭` a prime of `O_F` above `p` gives the valuation subring
`O_{F,𝔭}` (a DVR) with residue field `𝔽_p`, `p ≡ 3 (4)`, which has no `√−1`; unit vectors are `𝔭`-integral and reduction is a homomorphism,
so `χ(F²) ≤ χ(Γ_p)` (the kernel's `colorable_unitDistance_induce_of_valuationSubring`, row 57). Row 57's "Not proved" clause is the *general*
number-field supply of that valuation subring; for a prime of a quadratic ring the localisation is textbook, so it does not bite here.
**The named four** (C4): at `d = 47, 143, 311, 335` the primes above 11 are stable with residue degree 1 (`47 ≡ 3`, `311 ≡ 3`, `335 ≡ 5`
(mod 11) are residues; `11 | 143`, ramified, residue `𝔽₁₁`), so `L ≤ χ(Γ₁₁) = 5`; with row 117's `L ≥ 5`, `L = 5` and `χ = 5` at all four.
`47 ≡ 47`, `143 ≡ 143`, `311 ≡ 143`, `335 ≡ 167 (mod 168)` (in the family). *Control:* at `d = 167` 11 is not stable (C4) — consistent with
`L(ℚ(√167)) ≥ 6`. *Note:* `31`'s five-colourability is undecided (G56's floor 5), so some members with 31 stable and neither 11 nor 19 stable
may have `L = 5` through `Γ₃₁` or `L ≥ 6`; A-2's "for every such `d` with `L = 5`" is unaffected.

### 2.6 A-4 — **TRUE given its inputs; the independence is real** [hand + tools float]

J48-N4 (`N₄(ℚ(√167)) = ∅`) + J48-N4cor ⟹ given MR(ℚ(√167)) (outside row 100's exception: `167 ≡ 7 (8)`, Q-0), `χ ≥ 5`. The mechanism,
re-derived: `N₄ = ∅` makes `Y_{F,4} = UD(ℝ²)`; T-J39-3 given MR: four-colourable iff `UD(ℝ²)` has a CP four-colouring; a CP colouring is
proper a.s. at each fixed edge, so a.s. on all edges of de Grey's 1581-vertex graph at once (finitely many), a sample four-colours it —
refused by rung B. **Checks:** C3: the stable odd places of ℚ(√167) below 70 are 23, 43, 59, 67 (11, 19, 31 not stable); C5 reproduces
`λ*(23) = 0.3316953` at level one (float character sum; J48 used rigorous interval arithmetic), margin `1/3 − λ* = 0.001638` (J48: "1.6·10⁻³"),
`λ*(43) = 0.2718689`, `λ*(59) = 0.2486263` (J39's table); new characters at level `k ≥ 2` have `|λ|/d ≤ 2/(p+1)` (row 75's fibre bound), and
`2√p/(p+1) < 1/3` for `p ≥ 37` (Weil). Not re-derived: the ramified place above 167 at depth (J48-N4's own scope). **Independence:** row 117's
inputs are *independence ratios* `< 1/4` (FS-66 at 11 and 19, Hoffman, Lemma P); J48-N4's are *mixing constants* `< 1/3` (a different
spectral quantity, and 11, 19 are not even stable here); J39 records T-J39-3 as using "neither FS-66 nor Zhang"; and neither T-C(A) nor A⁺
enters J48-N4cor's route (thick places leave by mixing, not by T-C(A)'s count). So A-4 is a second route to `χ(ℚ(√167)²) ≥ 5` given MR, sharing
only MR (and SI/R-U-type lemmas inside T-J39-3) with A-1.

### 2.7 B-1 — **TRUE given its inputs** [hand]; the merge re-derived

T-J39-3 at `k = 5` for the totally real `F = ℚ(√167)`, with MR(F) (Q-0: outside the exception), gives "`F²` 5-colourable iff `Y_{F,5}` has a
CP 5-colouring"; T-J39-1 names `Y`. **My checks on T-J39-1:** C3/C5 give `N₅ = ` the places above 23 and 43 (`λ* = 0.3317, 0.2719 > 1/4`),
and 59 is 5-thick by `0.2486 < 1/4` (margin `1.4·10⁻³`), 67 and above by Weil (`2√67/68 = 0.2408`); 23 and 43 split in `F` (C3), so two places
each — "the four places". **The merge, derived (Lemma X21V-M):** for any graph `G`, `G × G` (categorical) has a CP `k`-colouring iff `G`
does — the projection pulls one back, and the diagonal `x ↦ (x, x)` is a homomorphism into `G × G`, so a CP colouring restricts to it. The two
places above 23 have isomorphic local planes (`F_v ≅ ℚ₂₃`), likewise 43, and the **two real places** of `F` give two copies of `UD(ℝ²)`: the
same lemma explains why `Y` has a single `UD(ℝ²)` factor. (Edges of the product are all pairs of unit vectors, by weak approximation plus
continuity in probability — CP makes `e ↦ P(c(x) = c(x + e))` continuous, so zero on a dense set of edge vectors is zero on its closure.)

### 2.8 B-2 — **TRUE given its inputs** [hand]; (i) holds with no input at all

(i) **Derived directly, with no T-J39-3:** for every countable `F ⊆ ℝ`, `χ(F²) ≤ χ_CP(ℝ²)` — sample a CP `k`-colouring of `UD(ℝ²)` and restrict
to `F²`; the unit-distance pairs of `F²` are countably many fixed edges, each proper a.s., so all at once a.s. Hence `χ(ℚ(√167)²) ≥ 6 ⟹
χ_CP(ℝ²) ≥ 6`, unconditionally. (ii) If `χ(F²) ≤ 5`: B-1 (MR) gives a CP 5-colouring of `Y`; PL(23, 43) gives one of `UD(ℝ²)`; so
`χ_CP(ℝ²) ≤ 5`. Contrapositive: `χ_CP(ℝ²) ≥ 6 ⟹ χ(F²) ≥ 6`. **"43's all-levels ratio `< 1/5`" is used nowhere** — J48's correction confirmed.

### 2.9 B-3 — the answer: **GAP, and a necessary condition shows why no factor-level statement short of rung D (CP form) can do it** [hand]

**Lemma X21V-B3a (projection) [hand].** A CP `k`-colouring of any factor of a categorical product pulls back along the projection to a CP
`k`-colouring of the product (translation invariance, continuity in probability and a.s. properness at each fixed edge all pass through a
homomorphism that is a group homomorphism). **So "`Y` has no CP five-colouring" implies all three of `χ_CP(ℝ²) ≥ 6`, `χ_CP(G₂₃) ≥ 6`,
`χ_CP(G₄₃) ≥ 6`.**

**Consequences.**
1. **Any statement implying "Y has no CP five-colouring" implies `χ_CP(ℝ²) ≥ 6`** — the measurable (CP) form of rung D, open (known:
   `χ_CP(ℝ²) ≥ 5` by `m₁ < 1/4`; `≤ 7` by a randomly translated hexagonal colouring). And `χ(ℝ²) ≥ 6 ⟹ χ_CP(ℝ²) ≥ 6` by 2.8's restriction, so
   it is *weaker* than rung D, but no held result gives it.
2. **The weakest sufficient statements, both carrying `χ_CP(ℝ²) ≥ 6`:** (a) `χ_CP(ℝ²) ≥ 6` together with PL(23, 43) — then "Y has no CP5" ⟺
   `χ_CP(ℝ²) ≥ 6` (2.8 (ii) is this); (b) the necessary triple of Lemma B3a together with a *CP-Hedetniemi property at five colours* for `Y`
   ("a CP five-colouring of `Y` yields one of some factor") — weaker than PL as a product lemma, but it needs the two `p`-adic parts.
3. **What the held results give.** *Row 75:* its all-levels bound `B₁(23) = 97.98…`, ratio `0.18523 < 1/5`, bounds the measurable independence
   density of the 23-adic compact piece (G66's reading of `lim α(G_k)/p^{2k}`), and averaging a CP colouring (some colour has probability
   `≥ 1/5`; its class is edge-null, hence a.e. independent by R88-TC-reg) refuses a CP five-colouring of `G₂₃`: **`χ_CP(G₂₃) ≥ 6`** [hand,
   sketch — the fibre-share inequality applied to a measurable set]. *Row 69 (the queue says "row 71"; see 1.2):* five refused at 43 **at
   level one only**, so `χ_CP(G₄₃) ≥ 6` is open — it is FS-69's `B₁(43) < 369.8`. *`m₁`-type densities:* **closed by a theorem** — Croft's
   `m₁(ℝ²) ≥ 0.2293 > 1/5`, and the cylinder `A × G₂₃ × G₄₃` over a real independent set is independent in `Y`, so `Y`'s measurable independence
   ratio exceeds 1/5 and **no one-point density bound, on `ℝ²` or on `Y`, can refuse five colours**; a refusal must use more than one-point
   densities (as Falconer's `χ_m ≥ 5` does), and at five colours none is held.
4. **Verdict:** GAP at `χ_CP(ℝ²) ≥ 6` (necessary, open), plus a product lemma (PL(23, 43), or CP-Hedetniemi at five with FS-69's 43 part).
   Row 75 supplies the 23 part of the necessary triple; nothing held supplies the rest.

### 2.10 Would-have-searched-here log (stage 2)

- Would have enumerated real quadratic `d` to test "the family ⟺ `L ≥ 5`" empirically; instead derived the congruences (2.0) and enumerated
  only the 168 residues mod 168, the extent fixed by the derivation (C2, a complete exact enumeration).
- Would have searched for a CP five-colouring of `Y` or of `G₄₃`'s levels to "see" B-3; instead derived the projection lemma, which shows any
  refusal already implies `χ_CP(ℝ²) ≥ 6`.
