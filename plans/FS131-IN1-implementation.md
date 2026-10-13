# FS131-IN1 — the implementation of `Arith/ThreeColourCriterion`: thirteen leaves

*The kernel lane's implementer (de Bruijn), 2026-10-13, branch `fs131-wrc` (cut at the skeleton's commit `34d9113b2`). Brief:
`data/fs131/briefs/FS131-IN1-leaves.md` (on `main`). The skeleton and its plans: `plans/FS131-KN4-three-four-colours-plan.md`
§ 4.3 and its dated last section, `plans/FS131-KN5-three-four-colours-passes.md` §§ Stage 3, 5, 7 (both on `fs131-wr2`).
Working files: `data/fs131/in1/`.*

## Theorems this phase proved

*(filled as the stages are saved; one line per kernel theorem, with its declaration and its axioms)*

## Stage 1 — SAVED: the readback

**Quotations.** `data/fs131/in1/check_quotes.py` (the planner's checker, pointed at this brief): the brief's five quoted
blocks — Kooshi's W2 and the claim list's theorem and three dated lines — against their sources in the coordinator's checkout,
byte for byte: **5 MATCH**, exit 0 (`data/fs131/in1/logs/check_quotes.out`). Control `--plant` alters one token of each in
memory: 5 of 5 then mismatch (`check_quotes.plant.out`).

**The tree as found, and what was done about it.** The launch note said the tree's build is an older job's and "iteration on
your file works as it stands". It does not: this worktree's `.lake/build` is of 2026-10-07 (1,867 `.olean`s) and holds no
`.olean` of `Arith/TorsionExtraction` or `Arith/ThreeColourCharacter`, so `lake env lean` on the module stops at its first
import (`object file … TorsionExtraction.olean … does not exist`). Worked around with no build: `data/fs131/in1/farm.sh` makes
a scratch farm under this tree's gitignored `build/in1-farm/` — real copies of the 44 `.olean`s of the module's import closure
inside `Proofs`, taken from the planners' tree `fs131-wr2` (whose library was built from the skeleton), with
`Arith/TorsionExtraction` — the one upstream module whose source differs there (another implementer's proofs) — recompiled
into the farm **from this tree's skeleton source**, so the farm holds what this tree's build will hold, every upstream leaf
`sorry`. The script checks that every other copied module's source is the same file in the two trees (`logs/farm.out`: yes).
`data/fs131/in1/lean1.sh` runs `lean` on one file against the farm under the slot, with the lakefile's two options. On the
untouched skeleton: exit 0, the 13 `declaration uses sorry` warnings and nothing else, 2.4 s, 3.9 GB. The farm is an
iteration device and no evidence; the one build at the end compiles this tree's own library.

**The statement check, armed before the first edit** (the pattern of `data/fs131/iu1/`, FS131-IU1's, with its tool defect
read: a statement printed from two paths differs in an instance binder's stored name, so both prints are made at one path).
- `data/fs131/in1/statements.sh`: the skeleton (`git show 34d9113b2:…`) and the working module, each with
  `lean/StatementFooter.lean` appended, elaborated at one path in turn; the two prints compared by `statement_diff.py` — every
  named constant's kind, stored type and (a definition's) stored value, character for character — then its control. On the
  untouched file: `PASS`, 17 named constants (16 theorems, 1 definition), 3 `example`s compared whole as text; control
  `4 of 4` (`logs/statements-stage1.out`).
- Two checks added to the pattern: **a name outside the module's namespace** declared by the module fails (the launch note's
  point 1: a `simp [f]` that unfolds another module's definition can generate `f.eq_1` here under that definition's name) —
  the control's fourth plant is such a name; and the `example`s are compared as text, not counted.
- `data/fs131/in1/dump.sh` prints the constants of the **compiled** module from a named library
  (`lean/StatementDump.lean`). Made now from `fs131-wr2`'s compiled skeleton (its source there is the skeleton's, checked by
  `git diff`; its `.olean` is of 14:28 today): `data/fs131/in1/statements-before-wr2.txt`, the "before" the build at the end
  is compared with. Against the footer's print it differs in the eight statements that have an anonymous instance binder and
  in nothing else — the binder's stored name carries the module's path, as FS131-IU1 found — and **Lean's own hash of every
  stored type agrees across the two prints** (20 of 20; the hash does not read binder names).

**The leaves, each read in the source** (`Proofs/HadwigerNelson/Arith/ThreeColourCriterion.lean` at `34d9113b2`), restated in
one line, with the plan's route. `R = ℤ[U_F] = unitRing F`; `c̄` is the map an involution induces on a quotient.

| leaf | statement, in one line | the plan's route | agree |
|---|---|---|---|
| L3.1 `targetFloor_four_weil` | `Q % 4 = 3`, `14 ≤ Q` ⟹ `TargetFloor 4 Q` (every field of `Q²` elements with a non-trivial involution has `χ(normOneCayley) ≥ 4`) | `targetFloor_six_of_kloosterman`'s proof with `6 → 4`: `4√Q < Q + 1` from `14 ≤ Q`; `targetFloor_of_charSum 4 Q (m := 2√Q)`, `normOne_charSum_ge`, `kloostermanBound_of_ringChar_ne_two` | yes |
| H90 `exists_mul_conj_inv_eq_of_mul_conj_eq_one` | finite field `k`, involution `σ ≠ id`, `t·σ t = 1` ⟹ `∃ y : kˣ, y·σ(y⁻¹) = t` | plan: cyclic `kˣ`. Taken instead: `y = a + t·σ a` satisfies `t·σ y = y`; if every such `y` were `0` then `t = −1` and `σ = id` | yes — **and `[Finite k]` is not read by this proof** (see below) |
| FC3 `exists_normOne_zero_of_card_ne_nine` | finite field of characteristic 3, involution `σ`, `ι² = −1`, `σ ι = −ι`, not nine elements, `lam : k →+ ZMod 3` ⟹ `lam` vanishes at some `y·σ(y⁻¹)` | else `lam` properly three-colours `normOneCayley k σ` (H90); `card_fixed_of_involution` gives `|k| = Q²`, `Q ≡ 3 (mod 4)`; `Q ≥ 14`: L3.1; `Q < 14`: `Q ∈ {3, 7, 11}` and `Q² = 3ⁿ` leaves `Q = 3` | yes |
| FC2 `eq_zero_of_forall_normOne_eq` | finite field of characteristic 2, involution `σ ≠ id`, `lam : k →+ ZMod 2` constant `= e` on `{y·σ(y⁻¹)}` ⟹ `e = 0` | the range of `y ↦ y·σ(y)⁻¹` is a subgroup of `kˣ`, not trivial, of odd order, summing to `0` (`FiniteField.sum_subgroup_units_eq_zero`) | yes |
| L3.2 `exists_maximal_card_nine` | finite ring of characteristic 3, involution `c` with `𝔪.comap c = 𝔪` for every maximal `𝔪`, `ι² = −1`, `c ι = −ι`, `l : A →+ ZMod 3` never `0` on `{x·c(x⁻¹)}` ⟹ some maximal ideal has a quotient of nine elements | the shared reduction R (below), FC3 at every factor | yes |
| L3.3 `exists_maximal_conj_trivial` | finite ring of characteristic 2, such a `c`, `l : A →+ ZMod 2` equal to `1` on `{x·c(x⁻¹)}` ⟹ `∃ 𝔪` maximal, `∀ x, c x − x ∈ 𝔪` | R; varying one coordinate each factor's functional is constant on its norm-one elements; FC2 | yes |
| L3.4 `conj_mem_unitRing` | `x ∈ R ⟹ x̄ ∈ R` | `Subring.closure_le`: generators go to generators | yes |
| L3.5 `exists_unitSet_mul_conjR_eq` | `a ∈ R`, `a ≠ 0` ⟹ `∃ u ∈ unitSet F, u·ā = a` | `u = a/ā` | yes |
| L3.6 `comap_conjR_eq` | every ideal `I` of `R`: `I.comap conjR = I` | `ā = ū·a` | yes |
| L3.7 `finite_quotient_span_natCast` | `F` a number field, `N ≠ 0` ⟹ `R ⧸ (N)` finite | plan: `N^d + 1` elements and a free group of rank `≤ d`. Taken: at a prime `p`, `R/pR` is an `𝔽_p`-space of dimension `≤ [F(i):ℚ]` (a relation over `ℤ` descends: its coefficients are all divisible by `p`); a product by `Submodule.finite_quotient_smul` | yes |
| L3.8 `exists_maximal_of_torsion` | `F` a number field, `τ ∈ Θ₃ ∩ T₆` ⟹ a maximal ideal of `R` with conjugation trivial modulo it, or one with nine elements in its quotient | `§ Stage 3`: `P(x₂)`, `Q(x₃)` on units of `R/2`, `R/3`, exactly one for every pair; L3.3 or L3.2; pull the ideal back | yes |
| L3.9 `fieldBandSet_two_nonempty_of_conj_trivial` | `𝔪` maximal in `R` with `∀ x, x̄ − x ∈ 𝔪` ⟹ `Θ₂(R_F) ≠ ∅` | `2 ∈ 𝔪`; every unit vector is `1` modulo `𝔪`; an `𝔽₂`-functional with value 1 at 1 | yes |
| L3.10 `exists_maximal_conj_trivial_of_colorable_two` | every subfield `F ⊆ ℝ`: `F²` two-colourable ⟹ such an `𝔪` | D-2: `J = (u − 1 : u a unit vector)`; every element is `0` or `1` modulo `J`; the two-colouring's character kills `J` and not `1` | yes |

**R, the shared reduction** (the plan's § Stage 3, to be stated by the implementer; private): for a finite commutative ring `A` of
prime characteristic `p`, a ring endomorphism `c` fixing each maximal ideal and `l : A →+ ZMod p`, there are
`lam I : A ⧸ I →+ ZMod p`, one per maximal ideal `I`, such that for every family of units `y I ∈ (A ⧸ I)ˣ` some unit `x ∈ Aˣ` has
`l (x·c(x⁻¹)) = Σ_I lam I (y I·c̄(y I)⁻¹)`.

No leaf's statement disagrees with its plan; none reads false or vacuous on reading. **One finding at the readback, for the
coordinator**: H90 as typed carries `[Finite k]`, and the proof above does not read it — the statement holds for every field
with an involution that is not the identity (it is Hilbert's Theorem 90 for a quadratic extension, by the usual one-line
resolvent). The skeleton's form is kept; the route's consequence for the environment linters is in § Stage 2.

Order taken: the plan's — L3.1, H90, FC3, FC2, R, L3.2, L3.3, L3.4, L3.5, L3.6, L3.7, L3.8, L3.9, L3.10.
