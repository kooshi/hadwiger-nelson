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
