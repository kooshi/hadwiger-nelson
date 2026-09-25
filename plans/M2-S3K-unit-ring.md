# M2 · J16 — FS-47's prime inversion in the kernel (valuation form), then FS-87's stripe lemma

*Crunch job J16 (2026-09-25), kernel lane, de Bruijn. Brief: `data/crunch-2026-09-25/briefs/J16-M2-prime-inversion-kernel.md` with
`STANDING-RULES.md`. Plan: `plans/M2-kernel-lane.md` §2.2, §3.2, §4.2 (J16's row), §4.4. Working files: `data/m2/j16/`.
Started 21:55 UTC from the gate state J15 left at `6cb89847`.*

## Stage 1 — SAVED

### 1.1 The quotation check (standing rule 5)

| brief's quotation | source | verdict |
|---|---|---|
| "hence `1/p ∈ R` **iff** no stable prime lies above `p`" | `plans/STUB-unit-vector-ring-kernel.md` §1, lines 27–28 | verbatim (a line break between "stable prime" and "lies") |
| "For every real number field `F`, `E = F(i)`, `R` its unit-vector ring, and every rational prime `p`: `1/p ∈ R` iff no conjugation-stable prime of `E` lies above `p`." | `plans/ASTRA-2026-09-14-derivation.md` T2, line 26 | verbatim |
| "**V2-T5, the stripe lemma** — under NT₀ every proper four-colouring of the triangular lattice is striped (type O/P wheels; propagation along a line, then line to line)" | `plans/STUB-de-grey-chain-kernel.md` target 1, lines 19–20 | verbatim (the stub continues "A finite local lemma plus an induction on lines; the first leaf.") |
| the Lean statement of `inv_natCast_mem_unitRing_iff` (brief: "elaborates today; leaves `normOne_subset_iff_stable` and `inv_mem_iff_forall_valuationSubring` closed; `inv_natCast_mem_unitRing_iff` and the spec example open") | `data/m2/j04/K3PrimeInversion.lean` | holds: two leaves closed, two `sorry` |
| named declarations: `normOne`, `normOne_subset_valuationSubring`, `mem_normOne_conj_iff` | `Proofs/HadwigerNelson/ResidueColouring.lean:253, 481, 534` | all present; `normOne σ := {u \| u * σ u = 1}` over a `CommRing`; `normOne_subset_valuationSubring` takes `(A : ValuationSubring L)`, stability, involution |
| `Ideal.image_subset_nonunits_valuationSubring` | Mathlib `RingTheory/Valuation/LocalSubring.lean:145` | present: `{A : Subring K} (I : Ideal A) (hI : I ≠ ⊤) : ∃ B : ValuationSubring K, A ≤ B.toSubring ∧ A.subtype '' I ⊆ B.nonunits` |
| "`1/2 = (w + w̄) + 2 ∈ ℤ[U]`, `w = (−3 + i√7)/4`, whence `3/8 ∈ ℤ[U]`" | `CLAUDE.md` G55 ("over K(√7), w = (−3 + i√7)/4 has w³ + w̄³ − 3w² − 3w̄² = 3/8"); `Instances/SevenConditional.lean` (`w`, `conj_w : w̄ = −3/2 − w`) | arithmetic re-derived: `w w̄ = (9+7)/16 = 1`, `w + w̄ = −3/2`, so `(w + w̄) + 2 = 1/2`, and `3/8 = 3·(1/2)³` ✓ |
| the news: `unitQuadrance_colorable_of_valuationSubring` in `Transcendental.lean` | `Proofs/HadwigerNelson/Transcendental.lean:177` | present (J15). It colours; it does not bear on prime inversion — **silent** here |
| the news: J07's Lemma C/C′ | `plans/FS91-S1D-character.md` §2.3–2.4 | read. Lemma C(c) is a completed-ring strengthening (`R/pR ≅ R̄_p/pR̄_p`) of which prime inversion is the corollary "no stable prime above `p` ⟹ `R/pR = 0`". It needs completions and a class-number argument; the valuation form needs neither. **Does not bear on the statement choice**; not consumed |

One scope note found at the source, recorded so it is not lost: the stub's banner (`plans/STUB-unit-vector-ring-kernel.md` line 3) re-aims
FS-47 at **Lemma R** "at its corrected scope: no stable prime ramified in `F(i)/F`". Lemma R (`ℤ[U_F]` is the ring of elements integral at
every stable prime) is **not** prime inversion; prime inversion needs no such scope condition (T2 is stated for every real number field and
every prime; at ℚ(√5) the unique prime above 2 is stable, so `1/2 ∉ R` and both sides are false). J16 lands prime inversion; Lemma R stays
the stub's remaining target.

### 1.2 C0 — the registered predictions, and mine beside them

| id | prediction (`plans/M2-kernel-lane.md` §4.3, verbatim) | planner's p | mine, at the start | both outcomes reachable? |
|---|---|---|---|---|
| P-J16a | "prime inversion in valuation form lands inside 1.5 hours" | 0.85 | 0.90 (two of four leaves closed, the rest a composition) | yes: a universe or coercion wall at `Subring.closure_le` vs `B.toSubring` could cost an hour |
| P-J16b | "the stripe lemma lands in full inside J16" | 0.10 | 0.10 (§3.2 prices it at 4–6 hours, more than the remaining budget after K3-B) | yes: the line inductions may be shorter than priced |

### 1.3 The price, from the next two leaves (never from a table)

Both open leaves closed **on the first elaboration** in a scratch copy (`data/m2/j16/Leaves.lean`, `scripts/slot.py --mem 16 --cpus 4 --
lake env lean`, 1.9 s wall; one linter nit, `tac <;> simp <;> norm_num`):
- `inv_natCast_mem_unitRing_iff` — four lines: leaf 2 at `x = n`, then `forall_congr'` and `unitRing σ ≤ B ↔ normOne σ ⊆ B`
  (`Subring.closure_le`) ↔ σ-stability (leaf 1). The coercion `(B.toSubring : Set L) = (B : Set L)` closed by `rfl`.
- `inv_five_mem_unitRing_conj` — `1/5 = (3+4i)/5 + (3−4i)/5 − 1`, each summand norm one by `mem_normOne_conj_iff`.

**Re-price of stage 2** (the module): the remaining products are the wall form (a two-line instance plus a `nonunits` restatement), the
bridge from the abstract `unitRing σ` to the plane's unit-vector ring `Subring.closure {z ∈ planeOver F | ‖z‖ = 1}` (the vocabulary J14's
chain theorem consumes), and the explicit `K(√7)` memberships. Estimate: 45–75 minutes, the bridge the only step with any risk (a
`Subfield ℂ` structure on `planeOver F` and conjugation restricted to it).

### 1.4 Would have searched here

| # | the move a search would have made | what was done instead |
|---|---|---|
| X1 | none at this stage | — |

## Stage 2 — SAVED

*21:58–22:08 UTC. Two new modules, the gate green; committed alone, before any stripe work.*

### 2.1 What landed

`Proofs/HadwigerNelson/UnitRing.lean` (general) and `Proofs/HadwigerNelson/Instances/SevenUnitRing.lean` (the `K(√7)` instance):

| declaration | statement (in words) |
|---|---|
| `unitRing σ` | the subring generated by `normOne σ` (a field `L` with a ring endomorphism `σ`) |
| `normOne_subset_iff_stable` | a valuation subring holds every norm-one element iff it is σ-stable (σ an involution) |
| `unitRing_le_valuationSubring_iff` | `unitRing σ ≤ B` iff `B` is σ-stable |
| `inv_mem_iff_forall_valuationSubring` | `x ∈ R`, `x ≠ 0`: `x⁻¹ ∈ R` iff `x⁻¹` lies in every valuation subring above `R` (Chevalley domination) |
| **`inv_natCast_mem_unitRing_iff`** | **prime inversion, valuation form**, the skeleton's statement verbatim: `(n : L)⁻¹ ∈ unitRing σ ↔ ∀ B : ValuationSubring L, (∀ z ∈ B, σ z ∈ B) → (n : L)⁻¹ ∈ B` (`[CharZero L]`, `σ` an involution, `n ≠ 0`) |
| `inv_natCast_mem_unitRing_iff_not_mem_nonunits` | the same with "`(n : L) ∉ B.nonunits`" — no σ-stable place has `n` in its maximal ideal |
| `inv_two_mem_unitRing_iff` | the 2-adic wall, valuation form |
| `planeOverSubfield F` | `F(i)` as a `Subfield ℂ` (carrier `planeOver F`) |
| `conj_mem_planeOverSubfield` | `F(i)` is conjugation-stable — **so the involution is `ResidueColouring.conjOn`, the one Theorem A uses** (a duplicate `conjOn` I first wrote was removed when the name clashed; reuse ties prime inversion to the same valuation subrings Theorem A colours with) |
| `unitRingOver F` | the unit-vector ring of `F²`: `Subring.closure {z ∈ planeOver F ∣ ‖z‖ = 1}` in `ℂ` — the chain theorem's vocabulary |
| `coe_mem_unitRingOver_iff` | for `x : F(i)`: `(x : ℂ) ∈ unitRingOver F ↔ x ∈ unitRing (conjOn …)` |
| `inv_natCast_mem_unitRingOver_iff` | prime inversion in the plane: `(n : ℂ)⁻¹ ∈ unitRingOver F` iff no conjugation-stable valuation subring of `F(i)` has `n` in its maximal ideal |
| `exists_sum_eq_of_mem_unitRingOver` | every element of `unitRingOver F` is `∑ u_j` over finitely many unit vectors of `F²` (closure induction; products by `finProdFinEquiv`) |
| **`add_one_le_chromaticNumber_planeOver_of_inv_mem_unitRingOver`** | **G55's chain theorem in ring form**: a forcer drawn in `F²` at `δ = q b − q a ≠ 0` with `δ⁻¹ ∈ unitRingOver F` gives `χ(F²) ≥ k + 1` |
| `inv_five_mem_unitRing_conj` | spec: `1/5 ∈ ℤ[U]` over `ℂ` (`(3+4i)/5 + (3−4i)/5 − 1`); two further spec examples: prime inversion consumed at `n = 5` over `ℂ`, and `1/5 ∈ unitRingOver ℚ` |
| `inv_two_mem_unitRingOver_seven` | `1/2 = w + w̄ + 2 ∈ ℤ[U_{K(√7)}]`, `w = (−3 + i√7)/4` |
| `three_div_eight_mem_unitRingOver_seven` | `3/8 = 3·(1/2)³ ∈ ℤ[U_{K(√7)}]` |
| **`wall_broken_seven`** | no conjugation-stable valuation subring of `K(√7)(i)` has 2 in its maximal ideal (prime inversion applied to the explicit sum) |
| spec `example` | `χ(K(√7)²) ≥ 5` from `G4` by the ring-form chain theorem and `3/8 ∈ ℤ[U]`, with no multipliers named — a second route to J14's `five_le_chromaticNumber_planeOver_seven_of_G4` |

Every docstring that states prime inversion says the number-field reading is row 57's gap and is not proved.

### 2.2 The gate (desktop, one run each; logs under `build/gate/`, copies in `data/m2/j16/*-stage2.log`)

| check | result |
|---|---|
| build (`scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`) | **OK** — 178 of 178 batches, 3 modules rebuilt (`UnitRing` 1.9 s, `Instances.SevenUnitRing` 2.0 s, `Proofs` 1.4 s), **0 modules with warnings**, 3 m 29 s |
| `sorry` | none in either module |
| `./scripts/axioms.sh` | **OK — 1069 clean** (1056 + the 13 new entries, every one `[propext, Classical.choice, Quot.sound]`), 10 axiom-free, **5 declared purchases** (unchanged) |
| `./scripts/vacuity.sh` | **OK** — declarations 6908 → 6936, refutations-skipped 286 → 287, sites 278 → 279, generic 256 → 257; the one new site is the ring-form chain theorem (`Forces G k a b`, GENERIC — the caller's obligation, as for J14's chain theorems); vacuous 0, stale 0, declared 3, unknown 2 (the baseline's) |
| `python3 tools/check_architecture.py` | **PASS** (two rows added: `UnitRing`, `Instances/SevenUnitRing`) |
| inhabitant per structure hypothesis | the only hypotheses are `σ` with `hσσ` (inhabited by complex conjugation, `Complex.conj_conj`, a spec `example`) and `Forces` (GENERIC; the `K(√7)` example consumes it under `G4`) |
| spec example per definition | `unitRing` (`inv_five_mem_unitRing_conj`), `unitRingOver` (`1/5 ∈ unitRingOver ℚ`), `planeOverSubfield` (used by `wall_broken_seven`) |
| P-lane: no certificate module touched | holds — the two modules import `Chain`, `ResidueColouring`, `SevenConditional`; only they and `Proofs` rebuilt |

### 2.3 The planted fault (watched red)

`data/m2/j16/PlantInvolution.lean`: `UnitRing.lean` with the involution hypothesis `hσσ` dropped from `normOne_subset_iff_stable`
only. Elaborated under the slot: **exit 1**, `Unknown identifier hσσ` at line 57 — the ⟸ direction (the converse,
`normOne_subset_valuationSubring B h hσσ`) — and at line 61 (the ⟹ direction's `map_div₀, hσσ`), then the callers' type mismatch.
The faithful module, the pair's other half, elaborates with exit 0. The plant fired for its reason: both directions consume the
involution. (What it does not show: that the statement is *false* without an involution — no counter-model was built.)

### 2.4 Decisions this stage (four parts)

| choice | alternative weighed | why this won | confidence |
|---|---|---|---|
| two modules — general `UnitRing.lean`, instance `Instances/SevenUnitRing.lean` — where the brief names one | everything in `UnitRing.lean` | the general module stays free of `SevenConditional` and its field; repository practice puts field instances under `Instances/` | high |
| the plane's ring is `unitRingOver F ⊆ ℂ`, bridged to the abstract ring through `planeOverSubfield F` | state the `K(√7)` memberships in the abstract ring of `F(i)` only | the chain theorem (J14) and every consumer speak `‖u‖ = 1`, `u ∈ planeOver F`; the bridge costs 30 lines and makes prime inversion readable in that vocabulary | high |
| reuse `ResidueColouring.conjOn` | my own `conjOn F` (written first; it clashed by name) | the same involution Theorem A (`colorable_unitDistance_induce_of_valuationSubring`) takes, so the valuation subrings prime inversion quantifies over are Theorem A's | high |
| add the ring-form chain theorem (not in the brief's list) | leave `3/8 ∈ ℤ[U]` as a bare membership | it is G55's statement as written ("if `1/δ` is a sum of unit vectors") and the only way a membership reaches a colour bound; 40 lines | high |

### 2.5 Predictions scored

| id | prediction | outcome |
|---|---|---|
| P-J16a | "prime inversion in valuation form lands inside 1.5 hours" (planner 0.85; mine 0.90) | **met** — 13 minutes from the stage-1 commit to the gate green (16:55 start, 17:06 build OK) |

### 2.6 Would have searched here

| # | the move a search would have made | what was done instead |
|---|---|---|
| X2 | none — no finite object in this stage | — |

### 2.7 Theorems this phase proved

| theorem | grade | address |
|---|---|---|
| `normOne_subset_iff_stable` — a valuation subring holds every norm-one element iff it is σ-stable | kernel | `Proofs/HadwigerNelson/UnitRing.lean` |
| `inv_mem_iff_forall_valuationSubring` — invertibility in a subring is invertibility in every valuation subring above it | kernel | same |
| `inv_natCast_mem_unitRing_iff`, `…_not_mem_nonunits`, `inv_two_mem_unitRing_iff` — prime inversion, valuation form, and the wall | kernel | same |
| `coe_mem_unitRingOver_iff`, `inv_natCast_mem_unitRingOver_iff` — the plane's ring is the abstract ring of `F(i)`; prime inversion in the plane | kernel | same |
| `exists_sum_eq_of_mem_unitRingOver` — ring elements are finite sums of unit vectors | kernel | same |
| `add_one_le_chromaticNumber_planeOver_of_inv_mem_unitRingOver` — the chain theorem in ring form | kernel | same |
| `inv_two_mem_unitRingOver_seven`, `three_div_eight_mem_unitRingOver_seven`, `wall_broken_seven` — the wall broken over `K(√7)`, valuation form | kernel | `Proofs/HadwigerNelson/Instances/SevenUnitRing.lean` |

## Stage 3 — SAVED

*22:10–22:27 UTC. `Proofs/HadwigerNelson/Stripe.lean`, 447 lines: **the stripe lemma is proved in full**, no `sorry`, no solver, no native
evaluation. So no J16b is needed.*

### 3.1 The statement (read aloud against the stub)

The stub (`plans/STUB-de-grey-chain-kernel.md` target 1, quoted in 1.1): "under NT₀ every proper four-colouring of the triangular lattice
is striped". The kernel statement, `Stripe.striped_of_proper_nt0 (hc : Proper c) (hnt : NT0 c) : Striped c` for `c : ℤ × ℤ → Fin 4`:
- `ℤ × ℤ` is `ℤ[ζ₆]` in the basis `1, ζ₆`; `rim` lists the six units `(1,0), (0,1), (−1,1), (−1,0), (0,−1), (1,−1)` = `1, ζ₆, ζ₆², …`
  in cyclic order (spec: each has Eisenstein norm `a² + ab + b² = 1`);
- `Proper c`: every point differs from its six neighbours — the triangular lattice's unit-distance graph;
- `NT0 c`: no alternate triple of any wheel is monochromatic. **Faithfulness:** every √3-triangle of `ℤ[ζ₆]` has side `s = (1+ζ₆)u`
  (`u` a unit, the only elements of norm 3), and its centroid `p + s(1+ζ₆)/3 = p + uζ₆` is a lattice point, so every √3-triangle is an
  alternate triple of the wheel at its centroid (spec: `N(rim 2 − rim 0) = 3`). So `NT0` is exactly "no monochromatic √3-triangle";
- `Striped c`: `∃ π : Fin 4 → ZMod 2` with both fibres of size two and an additive `β : ℤ × ℤ →+ ZMod 2` with
  `π (c x) = π (c 0) + β x` — the colours split into two pairs whose index is affine. That is V2's "pair-linear".

### 3.2 The proof as landed (and where it differs from V2 §W5 item 3)

| step | declaration | how |
|---|---|---|
| wheel facts | `WheelFacts`, `wheel_all`, `wheelFacts`, `wheel` | one `Prop` per wheel (centre `a`, rim `r₀…r₅`): proper + no alternate triple ⟹ (type O or type P along `rim 0`, `rim 1`, `rim 2`) ∧ (`r₂ = r₄ → r₀ = r₃ ∧ r₁ = r₅`) ∧ (`r₁ = r₅ → r₀ = r₃ ∧ r₂ = r₄`); `decide` on it for all `4⁷ = 16,384` wheels, nested `List.all`, `decide +kernel` |
| propagation | `typeP_zero_add`, `typeP_three_add`, `typeP_line` | type P along `rim 0` at `x` makes the wheel at `x ± rim 0` satisfy the hypothesis of the second or third wheel fact (the neighbours of `±v` at `x` are the neighbours of `∓v` at `x ± v`), so type P propagates; `Int.induction_on` |
| line to line | `striped_of_line` | **properness alone**: if the line `x + ℤ(1,0)` is two-periodic with colours `{p, q}`, the point `(s, n+1)` is adjacent to `(s, n)` and `(s+1, n)` (`rim 1`, `rim 2`), which carry both colours of line `n`'s pair, so it lies in the other pair (`pairOf_step`, decided over `Fin 4`); the same downward; so the pair of `x + (s, n)` is `n mod 2` |
| one direction | `rot`, `rotInv`, `proper_comp_rot`, `nt0_comp_rot`, `striped_of_comp_rot`, `typeP_comp_rot` | `ζ₆·(a, b) = (−b, a + b)` steps the rim (`rot_rim`); type P along `rim 1` or `rim 2` becomes type P along `rim 0` after one or two rotations |
| assembly | `striped_of_typeP`, `striped_of_proper_nt0` | a type-P point gives a two-periodic line; with none, every point is type O (the first wheel fact) and the line through `0` is two-periodic |

**Two simplifications against V2's text, both checked by the kernel:** (1) NT₀ is used only to produce one two-coloured line; the line-to-line
induction needs properness alone (V2 phrases it with alternating pairs, which is more than needed). (2) The all-type-O case needs no
separate `𝔽₄` factorisation: type O at every point makes every line two-periodic, and the same line-to-line step finishes.

### 3.3 Controls

| control | result |
|---|---|
| **plant, the wheel check** (`data/m2/j16/PlantWheel.lean`: the forward propagation fact's `r₁ = r₅` replaced by `r₁ = r₄`, false on type-P wheels) | **red for its reason**: `decide proved that the proposition … is false` at `wheel_all`, then the type mismatch in `typeP_zero_add`; the faithful module is the pair's passing half |
| **the hypotheses are inhabited** | `modTwo` (the class mod `2ℤ[ζ₆]`, a bijection `𝔽₄ → Fin 4`): `proper_modTwo`, `nt0_modTwo` (each reduced to `(ZMod 2)²` and decided), and `example : Striped modTwo` through the theorem |
| **NT₀ cannot be dropped** | `threeCol x = (a + 2b) mod 3`: `proper_threeCol` and `not_striped_threeCol` (a period-3 line forces `β(1,0) = 0`, so three colours share a pair — a fibre of size ≥ 3). The theorem is not true of proper colourings alone, so NT₀ is load-bearing, and the statement is not vacuous in either direction |

### 3.4 The gate after this stage

| check | result |
|---|---|
| build | **OK** — 178 of 178 batches, 2 modules rebuilt (`Stripe` 4.2 s, `Proofs` 1.4 s), **0 modules with warnings** |
| `./scripts/axioms.sh` | **OK — 1077 clean** (+8), **11 axiom-free** (+1: `wheel_all` uses no axioms), **5 declared purchases** (unchanged) |
| `./scripts/vacuity.sh` | **OK** — declarations 6936 → 6986, refutations-skipped 287 → 293 (`not_striped_threeCol` and its auxiliaries conclude `False`), sites 279, vacuous 0, stale 0, declared 3, witnessed 17, generic 257, unknown 2 (no new site: `Proper`, `NT0` are predicates, not structure binders) |
| architecture | **PASS** (row `Stripe` added) |
| elaboration cost | whole module 4.8 s wall, 2.9 GB peak with a minimal import (`ZMod.Basic`, `Fin.VecNotation`, `List.FinRange`, `Ring`, `LinearCombination`) — against J04's 18.4 s / 9.8 GB for S1 alone with a whole-`Mathlib` import; the per-wheel check on direct arguments beats J04's vector form (`![…]` indexing measured 15 s for one fact on the same `4⁷`) |

A docstring correction after the gate run (names of the wheel and propagation declarations) is rebuilt in stage 4's gate.

### 3.5 Predictions scored

| id | prediction | outcome |
|---|---|---|
| P-J16b | "the stripe lemma lands in full inside J16" (planner 0.10; mine 0.10) | **met** — 17 minutes of elaboration work. §3.2's price (4–6 hours, 400–500 lines) was built from S1's rate and a ten-point S2; the S2-as-a-wheel-statement shape (§4.4 item 5) and the properness-only line step removed most of it |

### 3.6 Would have searched here

| # | the move a search would have made | what was done instead |
|---|---|---|
| X3 | none — the one finite computation is the complete enumeration of one wheel's `4⁷` colourings, a set the wheel derivation fixes (the ban's "at the edge" case, as J04's S1), plus decisions over `Fin 4`, `(ZMod 2)²`, `ZMod 3` and the 16 maps `Fin 4 → ZMod 2`, each a finite fact a derivation named | — |

### 3.7 Theorems this phase proved

| theorem | grade | address |
|---|---|---|
| `wheel_all` / `wheelFacts` / `wheel` — the wheel classification (type O or P) and the two propagation facts, on all `4⁷` wheels | kernel | `Proofs/HadwigerNelson/Stripe.lean` |
| `typeP_line` — type P along a direction propagates along its line | kernel | same |
| `striped_of_line` — a two-periodic line stripes a proper four-colouring (properness alone) | kernel | same |
| `striped_of_comp_rot` and the rotation transfers | kernel | same |
| **`striped_of_proper_nt0` — the stripe lemma (FS85-V2-T5)** | kernel | same |
| `proper_modTwo`, `nt0_modTwo`; `proper_threeCol`, `not_striped_threeCol` — the model, and NT₀ cannot be dropped | kernel | same |

## Stage 4 — SAVED

*22:27–22:36 UTC. The final gate, the module map, the proposed edits, the report.*

### 4.1 The final gate (after stage 3's docstring correction)

| check | result |
|---|---|
| build | **OK** — 178 of 178 batches, 2 modules rebuilt (`Stripe`, `Proofs`), **0 modules with warnings** (`data/m2/j16/build-stage4.log`) |
| `sorry` in the three new modules | none |
| `./scripts/axioms.sh` | **OK — 1077 clean, 11 axiom-free, 5 declared purchases** (J15's state was 1056 / 10 / 5; +21 clean entries, +1 axiom-free) |
| `./scripts/vacuity.sh` | **OK** — `declarations=6986 refutations-skipped=293`; `sites=279 vacuous=0 stale=0 declared=3 witnessed=17 generic=257 unknown=2` (J15's: 6908 / 286 / 278 / generic 256) |
| `python3 tools/check_architecture.py` | **PASS** — rows `UnitRing`, `Instances/SevenUnitRing`, `Stripe` |
| `lake lint` | **not run** — the kernel brief's gate line names build, `sorry`, axioms and vacuity; `lake lint` may build the lint driver through Lake, which the build rule forbids. Held for the owner |
| certificate modules touched (P-lane) | none — `UnitRing` imports `Chain`, `ResidueColouring`; `SevenUnitRing` imports `UnitRing`, `SevenConditional`; `Stripe` imports Mathlib only |

### 4.2 The module map

`ARCHITECTURE.md` §3 gained three rows (`UnitRing`, `Instances/SevenUnitRing`, `Stripe`); `Proofs.lean` imports the three modules;
`scripts/Axioms.lean` gained two CLEAN sections (FS-47, J16: 13 entries; FS-87 target 1, J16: 9 entries).

### 4.3 Proposed edits (for the front-page lane; this job edits none of `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`)

1. **`LEDGER.md`, a new row** — "Prime inversion, valuation form: for a field with an involution σ, `1/n ∈ ℤ[U]` iff no σ-stable valuation
   subring has `n` in its maximal ideal; in the plane over `F ⊆ ℝ`, the same for `F(i)` under conjugation (the valuation subrings of
   Theorem A); the chain theorem in ring form (a forcer at `δ` with `1/δ ∈ ℤ[U_F]` refuses its colour count); over `K(√7)`, `1/2, 3/8 ∈
   ℤ[U]` and no conjugation-stable valuation subring of `K(√7)(i)` has 2 in its maximal ideal. Kernel. Not proved: that such valuation
   subrings are the conjugation-stable primes of a number field (row 57's gap, FS-37). Prior art: GPT Astra's Theorem 1.2 (hand);
   `[Fischer1990b]` Thms 1, 3–4 (special cases); Chevalley's domination (Stacks 00IA, Mathlib). `Proofs/HadwigerNelson/UnitRing.lean`,
   `Instances/SevenUnitRing.lean`; FS-47 (J16)." And in § B: ASTRA T2 (prime inversion) → kernel in valuation form.
2. **`LEDGER.md`, a new row** — "The stripe lemma: every proper four-colouring of the triangular lattice with no monochromatic
   √3-triangle is striped (two colour pairs, pair index affine `ℤ[ζ₆] → 𝔽₂`). Kernel; the wheel facts by a complete check of one wheel's
   `4⁷` colourings. NT₀ cannot be dropped (a proper three-colouring is not striped). Prior art `[Parts2020hv]` §3 (human-verified);
   derived at FS85-V2-T5. `Proofs/HadwigerNelson/Stripe.lean`; FS-87 target 1 (J16)." And in § B: FS85-V2-T5 → kernel.
3. **`CLAUDE.md` G35** — "The wall is broken iff 1/2 lies in the unit-vector ring ℤ[U]" can cite the kernel's valuation form
   (`inv_two_mem_unitRing_iff`), still with the number-field reading as row 57's gap. **G55** — the chain theorem in ring form is
   kernel (`add_one_le_chromaticNumber_planeOver_of_inv_mem_unitRingOver`), so "look for 1/δ as a sum of unit vectors" is "is
   `1/δ ∈ ℤ[U]`", decided place by place in valuation form.
4. **`plans/FRONTIER-STUBS.md`** — FS-47 (rank 23): D3 in valuation form and D5's `3/8` done; left: row 57's translation (FS-37) and
   Lemma R at its corrected scope. FS-87 (rank 9): target 1 done; next, dB9's V1.
5. **`plans/M2-kernel-lane.md` §3.2** (the planner's record, not mine to edit): K3-A's price "4–6 hours, 400–500 lines" measured at
   17 minutes and 447 lines including the controls; the S2-as-a-wheel-statement shape was the saving.

### 4.4 Decisions this stage

| choice | alternative weighed | why this won | confidence |
|---|---|---|---|
| no J16b | a J16b for the stripe remainder, as the brief's stop rule anticipated | nothing remains: the lemma is proved and gated | high |
| `lake lint` not run, held | run it | the build rule forbids anything that may build through Lake, and the brief's gate line omits it | medium — if `lake lint` only reads existing `.olean`s, it is safe and should run |

### 4.5 Would have searched here

| # | the move a search would have made | what was done instead |
|---|---|---|
| X4 | none | — |

### 4.6 Theorems this phase proved

None new at this stage (the gate re-checked stages 2 and 3).
