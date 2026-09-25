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
