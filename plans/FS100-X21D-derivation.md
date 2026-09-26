# FS100-X21D — ℚ(√167) and the `L ≥ 5` family, given MR (crunch 2026-09-26 ×2×3, wave 3, job X21D)

*de Bruijn, Opus 5.5. Brief: `data/crunch-2026-09-26-x2x3/briefs/X21D-167-and-family-derivation.md` with its `STANDING-RULES.md`.
Stop time 12:30 UTC. A blind verifier (X21V) works the same list; no contact. Working files `data/fs100/x21d/`; checks `tools/x21d_*.py`.*

## Theorems this phase proved

- **X21D-Q0** — for `d ≡ 7 (mod 8)`, `ℚ(√d)`'s one dyadic place splits in `ℚ(√d, i)` (`ℚ₂(√d) = ℚ₂(i)`); so the family is outside row 100's
  exception and `R = O′` there. [hand + tools exact] — §2.1; `tools/x21d_family.py`.
- **X21D-A1** — given MR (FS100-MR's scope), `χ(ℚ(√d)²) ≥ 5` for every squarefree `d ≡ 47, 143, 167 (mod 168)`. [hand, a composition; its
  weakest input R88-TCA's class form, one mind] — §2.2.
- **X21D-A2** — given MR, `χ(ℚ(√d)²) = 5` for every such `d` with `L = 5`; in particular at ℚ(√47), ℚ(√143), ℚ(√311), ℚ(√335); 44 of the 52
  family fields with `d ≤ 3000` have 11 or 19 stable. [hand + tools exact] — §2.3.
- **X21D-A4** — given MR, `χ(ℚ(√167)²) ≥ 5` by J48-N4cor without FS100-T1, T-C(A) or SP-Cor, over R-U and SP common to both routes;
  J48-N4cor reaches no `L = 5` family member (`λ*(Γ₁₁) = 0.476413`, `λ*(Γ₁₉) = 0.380486 > 1/3`). [hand + tools] — §2.4.
- **X21D-K0** — `MR(F) ∧ T-C(A)@∅(F) ⟹ χ(F²) ≥ 5` for every real number field (SP-Cor's proof, one input field-dependent); A⁺ at `S ≠ ∅`
  needs T-C(A) at `S`. [hand; second mind on K0, not blind to its summary] — §3.1.

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

- Stage 2: "sweep the family for a member where some stable place's ratio reaches 1/4" — instead: the ratio table's maximum is a
  finite list fixed by derivation (11, 19 by FS-66; 23, 31 by Hoffman; `p ≥ 37` by Weil; ramified by Lemma P / V3ram), read, not searched.
  The exact tool `tools/x21d_family.py` enumerates squarefree `d ≤ 3000` only to check congruences a derivation fixed (standing rule 3's edge
  case: a complete enumeration of a finite set whose extent the derivation fixed; logged as such).

## Stage 2 — SAVED (Q-0, A-1, A-2, A-4), 06:33

**Verdicts.** Q-0 **TRUE** [hand + tools exact]. A-1 **TRUE** as a composition, at the grades of its inputs (the weakest: R88-TCA's class form,
one mind outside ℚ(√47); K0, re-derived at stage 3). A-2 **TRUE** (A-1 plus the residue upper bound at 11 or 19). A-4 **TRUE**, with one
qualification on the word "independently" (§2.4).

### 2.1 Q-0 — TRUE

Let `d ≡ 7 (mod 8)` (the squarefree part of `d` has the same residue mod 8, since an odd square is `≡ 1 (mod 8)`), `F = ℚ(√d)`, `L = F(i)`.
Then `d ≡ 3 (mod 4)`, so 2 ramifies in `F`: one dyadic place `𝔭`, `F_𝔭 = ℚ₂(√d)`. Since `−d ≡ 1 (mod 8)`, `−d` is a square in `ℚ₂`, so
`√d = √−1·√−d ∈ ℚ₂(i)` and `F_𝔭 = ℚ₂(√d) = ℚ₂(i)`. Hence `i ∈ F_𝔭`, `L ⊗_F F_𝔭 = F_𝔭 × F_𝔭`: **`𝔭` splits in `L/F`, so it is not stable**
(stable = does not split in `L/F`, the definition FS100-T1's proof uses). There is no other dyadic place. Row 100's exception is "possibly at
a ramified stable dyadic place" (J48's form: "a stable dyadic place ... ramified in `L/F` with `R̄₂` proper"), so with no stable dyadic place
the field is outside it and Lemma C′ gives `R_F = O′`, which is FS100-MR's hypothesis. ∎ The hypothesis is not idle: for odd `d ≢ 7 (mod 8)`,
`−d` is not a 2-adic square (the tool's converse check), and then the dyadic place is stable (ramified in `L/F` when `d ≡ 1, 3, 5 (mod 8)`
are read case by case; not needed here). *Check:* `tools/x21d_family.py` (a) — brute-force solvability of `x² ≡ −d (mod 2^k)`, `k ≤ 12`, both
directions, every odd squarefree `d ≤ 3000`; plant `--plant-dyadic` (the test `d ≡ 3 (mod 8)`) fires at `d = 3`
(`data/fs100/x21d/family.out`, `familyplant-dyadic.out`).

### 2.2 A-1 — TRUE (a composition; inputs and grades)

For squarefree `d > 1`, `d ≡ 47, 143, 167 (mod 168)`, `F = ℚ(√d)`. The chain, each link with its source and grade:

| # | link | source | grade |
|---|---|---|---|
| 1 | `d ≡ 7 (mod 8)` (all three classes: `47 = 5·8+7`, `143 = 17·8+7`, `167 = 20·8+7`), so no stable dyadic place and `R = O′` | Q-0 (§2.1); row 100 Lemma C′ | [hand + tools exact]; Lemma C′ three derivations |
| 2 | MR(F) | §7 ¶1 (FS100-MR: "for every real number field `F` with `R = O′`") | given (the brief's "given MR") |
| 3 | `F` is in T-C(A)'s class: every stable place of `L` has all-levels four-colour ratio `< 1/4` | FS100-T1 (⟸ direction): 3, 7 inert (`d ≡ 2 (mod 3)`, `d mod 7 ∈ {3,5,6}`), dyadic split; the remaining stable places are `p ≡ 3 (mod 4)`, `p ≥ 11`, split or ramified in `F` (`p` inert in `F` gives `𝔽_{p²} ∋ √−1`, split in `L/F`; `p ≡ 1 (mod 4)` splits) | [hand + tools exact, one mind + two checks]; re-checked here by `x21d_family.py` (b) |
| 4 | T-C(A) at `S = ∅` over `F` | R88-TCA's class form (J28D) | [hand, **one mind** outside ℚ(√47)] |
| 5 | SP-Cor over `F`: `X₄(F) ≠ ∅` ⟹ a finite positive `U`-invariant `E`-null non-Haar `τ` | K0 / J45 SP-Cor + A⁺ (my stage-3 re-derivation, A-3) | [hand; K0 one mind + one-step check; A-3 below] |
| 6 | 2 + 5 ⟹ `X₄(F) = ∅`, i.e. `χ(F²) ≥ 5` | composition | — |

**Uniformity over the family, checked link by link.** (i) Link 1 is a congruence. (ii) Link 3's thresholds are a finite table independent of
`d`: at a stable 11 or 19 (split or, when `11 | d`, `19 | d`, ramified) FS-66's certificates at every level with Lemma P (ii) at ramified levels;
23 and 31 by Hoffman (31's `1/4 − 2.745·10⁻⁶` the maximum; R88-J28V-3); `p ≥ 37` by Weil (`36p < (p+1)²`); new levels Lemma P; ramified `p | d`
by V3ram/Lemma P; real places `m₁ ≤ 0.2470` (two real places merge — the diagonal copy of `UD(ℝ²)` sits in the product). The count R88-TCA runs
needs `max < 1/4` over the factors; the maximum over the whole family is the same finite list, so it is uniform in `d`. (iii) 3 and 7 never
divide `d` in the family (`d ≢ 0 (mod 3)`, `d ≢ 0 (mod 7)`), so no ramified 3- or 7-place can appear. (iv) Link 5 uses nothing about ℚ(√47)
(A-3). **Where it could still fail:** link 4 is one mind outside ℚ(√47), and the family is exactly its scope; a defect in J28D's class form
is the one step no second mind has walked (J48's "a second route" for ℚ(√167) cites the same class form).

### 2.3 A-2 — TRUE

Given A-1's `χ(F²) ≥ 5`: if `L(F) = 5`, some residue target of a stable place is five-colourable; in this family the dyadic place is split and
every target from a stable `q ≥ 23` has `χ ≥ 6` or is `q = 31` (floor 5, undecided), so `L = 5` means a usable plane at 11 or 19 (`χ(Γ₁₁) =
χ(Γ₁₉) = 5`) or, conditionally, `χ(Γ₃₁) = 5`. In every case the target `Γ_q` is a usable plane of residue field `𝔽_q`, `q ≡ 3 (mod 4)`, and
row 52's reduction gives `χ(F²) ≤ χ(Γ_q) = 5` — a split or ramified place both give a valuation subring with residue field `𝔽_q` in which
`−1` is a non-square, so every unit vector is integral and reduction is a homomorphism on each coset (G63's one lemma). Field level: row 57's
gap is a *kernel* gap; at hand grade this is `[Moorhouse2010]`/`[Madore2015]`'s bound (FS100-Q47 cites it the same way). So `χ(F²) = 5`.
**The four fields:** `47, 143 = 11·13, 311, 335 = 5·67` are squarefree and in the family (`311 ≡ 143`, `335 ≡ 167 (mod 168)`); 11 is stable at
each — split at 47, 311, 335 (`(47/11) = (3/11) = 1`, `(311/11) = (3/11) = 1`, `(335/11) = (5/11) = 1`) and ramified at 143 — so `L = 5` there
(`L ≥ 5` by the class, `≤ 5` by 11). *Check:* `x21d_family.py` (c); plant `--plant-legendre` (flip `(·/11)`) fires. **Family census** (`d ≤ 3000`,
`data/fs100/x21d/family.out`): 52 fields, 44 with 11 or 19 stable (`L = 5`, hence `χ = 5` given MR); the other 8, ℚ(√167) first, have `L ≥ 6`
unless `χ(Γ₃₁) = 5`.

### 2.4 A-4 — TRUE (one qualification)

J48-N4cor's two lines at `F = ℚ(√167)`: T-J39-3 at `k = 4` with `N₄(F) = ∅` (J48-N4: 23's `λ* = 0.331695… < 1/3`, rigorous interval
arithmetic; 43, 59, … a fortiori; 167 ramified by J21-TH; higher levels `≤ 2/(p+1) ≤ 1/12`) makes `Y_{F,4} = UD(ℝ²)` (the two real places
merged by the diagonal homomorphism). Given MR(F) (in scope: `167 ≡ 7 (mod 8)`, Q-0), branch (B) is excluded, so a four-colouring of `F²`
gives a CP four-colouring of `UD(ℝ²)`; restricted to de Grey's 1581 points it is a.s. proper on the finitely many edges at once, against
rung B's kernel theorem. So `χ(F²) ≥ 5`. Inputs: MR [given]; T-J39-3 (BC-1 TRUE, J48, with Lemmas C, C′ — C′ in scope by Q-0); J48-N4
[tools, rigorous]; rung B [kernel]. **"Independently of row 117 and K0": TRUE of the statements** — the route uses neither FS100-T1's class
computation nor T-C(A) (R88-TCA) nor SP-Cor/A⁺ — **but not of every lemma:** T-J39-3's skeleton ("the Følner step (P4); SI at `k` colours;
R-U; MR, or its failure, SP", J39 §4.7) shares J45's R-U, the SP-only-if step and the SI identity family with K0's route. So it is a second
route over partly common inputs; a defect in R-U or SP would take both routes down (J48 §3 already called its confirmation "route-dependent").
Its gain: it removes the one-mind link 4 of §2.2 (R88-TCA's class form) from ℚ(√167)'s `≥ 5`, replacing it with the 23 margin (`1.6·10⁻³`).
**Does it reach the rest of the family?** Only where `N₄(F) = ∅`; at every `L = 5` member 11 or 19 is stable and not 4-thick
(normalised `max|λ|` at level one: `0.476413` at 11, `0.380486` at 19, both `> 1/3`, computed at stage 3 by the exact character sums over the 12 and 20 unit vectors; level one already fails thickness), so J48-N4cor does not cover A-2's fields — A-1 there rests on link 4.

## Stage 3 — SAVED (A-3: K0, my own derivation, then compared with FS100-K0's statement), 06:37

**Blindness note (honest):** at stage 1 the brief's "Read first" list sent me to `plans/FS100-derivation.md` §2, where FS100-K0's
statement *and its one-paragraph proof summary* sit together; I read both at 06:24. So this derivation walked J45's text (`plans/FS84-SI-D-derivation.md`
§2–§4) independently, but it is not blind to K0's summary. X21V's is the blind one.

**Verdict. A-3 TRUE, with a scope reading of "A⁺":** SP-Cor holds with J45's proof over every real number field where T-C(A) holds at `S = ∅`
(wider than K0's "every real quadratic field in T-C(A)'s class"; nothing quadratic is used); A⁺ holds **at `S = ∅`** with J45's proof given
T-C(A)@∅. **Read literally — "J45's A⁺ … hold[s] … given T-C(A) there at `S = ∅`", A⁺ being J45's statement "for every … finite set `S` of
split places" — it is a GAP at the step "T-C(A) at `S ≠ ∅`":** J45's proof of A⁺ at `S` invokes T-C(A) at that same `S`, and for a merely
translation-invariant `μ` (A⁺'s scope) nothing reduces `S ≠ ∅` to `S = ∅` — R-U, which would (`σ_μ(E_S ∖ (T + A)) = 0`), needs `σ_μ`
`U`-invariant, i.e. a rotation-invariant `μ`. The gap does not touch SP-Cor (which uses `S = ∅` only) and is closed for the class's fields by
R88-TCA's class form at every finite `S` (J28D, one mind; a split dyadic `S`-place through C14.2 (c)). FS100-K0's own statement already carries
exactly this scope note ("A⁺ at a finite `S ≠ ∅` needs T-C(A) at that `S`, which R88-TCA's class form supplies"); the brief's K0 quotation
(J51V's claim list) lacks it. No correction to FS100-K0; the brief's quote is the narrower-sounding but literally-wider form.

### 3.1 The derivation: SP-Cor's proof, every input, its field dependence

Let `F` be a real number field, `R = ℤ[U] ⊂ L = F(i)`, `X₄(F)` the proper four-colourings (of `F²`, equivalently of `Cay(R, U)` on each
`R`-coset, since every unit vector lies in `U ⊂ R`). Suppose `X₄(F) ≠ ∅`.

| step | statement | input | field-dependent? |
|---|---|---|---|
| S1 | `X₄(F)` is compact metrizable (`F²` countable, Tychonoff, properness closed) and invariant under `R ⋊ U`, `c ↦ c(v· + y)` | — | no |
| S2 | an `R ⋊ U`-invariant Borel probability `μ` exists | `R ⋊ U` abelian-by-abelian, hence amenable (Markov–Kakutani / Følner) | no |
| S3 | with `h(c(0)) ∈ ℝ³` the tetrahedron vertex, `C(y) = E⟨h(c(0)), h(c(y))⟩ = ∫ χ(y) dσ_μ`; `C(vy) = C(y)` for `v ∈ U`, so `σ_μ` is `U`-invariant | Bochner on the discrete `R`; rotation invariance of `μ` (a rotation fixes 0) | no |
| S4 | `σ_μ(E ∖ (T + A)) = 0` | R-U (J45 §4.1): N1 (b) density by weak approximation for the norm-one torus `x² + y² = 1` of `L/F` (a rational curve over every `F`) and the split-place contraction `u = z/z̄`, `(z) = 𝔓^h` | no — "every real number field" |
| S5 | `E_∅ = T + A` | N1 (a): `R/NR` finite since `R` is torsion-free of rank `[L:ℚ]` | no |
| S6 | `∫_{R̂∖E_∅} Re χ(1) dσ_μ < 0` | A⁺ at `S = ∅` with remark (ii): SI-1, SI-3 (the tetrahedral identity, `k = 4`), SI-4 (a selection is an `𝒜_∅`-measurable equivariant proper colouring), N2 (its spectral measure lies on `E_∅ = T + A`), **T-C(A) at `S = ∅` over `F`** forbids that; `U`-invariance of `σ_μ` (S3) makes the integral constant on `U`, so strict at `u = 1` | **only through T-C(A)@∅** |
| S7 | `τ := σ_μ\|_{R̂∖E}` is finite, positive, `U`-invariant (`E` is `U`-invariant, N1 (b)), `τ(E) = 0`, and `∫ Re χ(1) dτ = ∫_{R̂∖E_∅} Re χ(1) dσ_μ < 0` (by S4, S5 the two restrictions differ by a `σ_μ`-null set) | S4–S6 | no |
| S8 | `τ` is not a multiple of Haar (`∫ χ(1) dHaar = 0`, `1 ≠ 0` in `R`), contradicting MR(F) | — | no |

So `MR(F) ∧ T-C(A)@∅(F) ⟹ χ(F²) ≥ 5` for **every** real number field `F` — no step uses that `F` is quadratic, that `d = 47`, or `R = O′`
(MR's own scope needs `R = O′`, a separate input: Q-0 supplies it on the family). Not used: Lemma C, C′, strong approximation, FS-66, C14,
`[AmbrusEtAl2023]` (they enter only through T-C(A)'s own proof). **Compared with FS100-K0's statement** ("J45's SP-Cor and A⁺ at `S = ∅`
hold, with J45's proofs, over every real number field where T-C(A) holds at `S = ∅` … A⁺ at a finite `S ≠ ∅` needs T-C(A) at that `S`"):
**identical**, including the scope note. Differences of truth: none.

### 3.2 A second look at the one input K0 does not re-derive

T-C(A)@∅ over the class (R88-TCA's class form, J28D, one mind) is where A-1 is weakest (§2.2 link 4). A-4's route removes it at ℚ(√167);
for the `L = 5` members no route here avoids it (J48-N4cor needs `N₄ = ∅`, false wherever 11 or 19 is stable: §2.4). **Proposed next job
(SPAWN candidate, not spawned):** a blind second derivation of R88-TCA's class form at `S = ∅` over the family (the count
`1 ≤ 4 max(α(Y′), r_X) < 1` with the ramified places `p | d` for `p = 11, 19, 23, 31` — the family members with such ramified places, e.g.
ℚ(√143) at 11, are exactly where the class form goes beyond ℚ(√47)'s factors).
