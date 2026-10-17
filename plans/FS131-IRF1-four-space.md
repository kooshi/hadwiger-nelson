# FS131-IRF1 — rational four-space at four colours: the compulsion law, Johnson's question and the structure clause, proved

*de Bruijn, the implementer (Opus 5.5), 2026-10-17. Brief: `data/fs131/briefs/FS131-IRF1-four-space.md` (on `main`). Worktree
`.claude/worktrees/il5`, branch `fs131-kfs1`, from `273fb7b9a` (the planner's skeleton; its plan
`plans/FS131-KFS1-four-space-plan.md`). Working files: `data/fs131/irf1/`.*

## Theorems this phase proved

None yet (stage 1 is the readback).

## Stage 1 — SAVED: the readback, the dump, Part B's skeleton removed

### 1.1 The brief's quotations, checked against their sources

`data/fs131/irf1/quote_check.py` (a copy of the planner's `data/fs131/kfs1/quote_check.py`, unchanged) takes every block
quotation of the brief (a run of `>` lines closed by `— source: <path>`), collapses whitespace and nested `>` prefixes on both
sides, and requires the quote's text in the source. Run against this worktree (`data/fs131/irf1/quote_check.out`): **7 quotes,
7 FOUND, exit 0** — W2 (`data/fs131/REQUEST-2026-10-13.md`), the `ℚ⁴` entry (`CLOSED-QUESTIONS.md`), the two head statements
(`RationalFour/Compulsion.lean`, `RationalFour/Forbid.lean`), and items 1082, 1075 and 1025 (`plans/FS131-close-inventory.md`).
Planted control (`--plant`: `formalize` → `formalise` in the first quote): MISSING, exit 1
(`data/fs131/irf1/quote_check_plant.out`). **Mismatches: none.**

### 1.2 The target, restated

Prove every `sorry` of the four skeleton modules `Proofs/HadwigerNelson/RationalFour/{Basic,Order,Compulsion,Forbid}.lean`
(36 of them: 4 in `Basic`, 12 in `Order`, 13 in `Compulsion`, 7 in `Forbid` — counted from the source; `declaration uses
'sorry'` counts 38 in the planner's build, the two of Part B's skeleton among them) without changing a stored statement, and add **A3, the structure clause**, as a
head statement in the skeleton's vocabulary (item 1082 ruling (1)): every proper four-colouring `c` of `quatGraph` and every
base point `x₀` have a bijection `e : Fin 4 ≃ Fin 4` with `c (x₀ + z) = e (residue z)` for every `z ∈ comp` — on each component
the colouring is the residue map up to relabelling. Planned name: `exists_equiv_coloring_add_eq_residue` (`RationalFour/Compulsion`).

The heads (plan § 3.2), unchanged: `forall_coloring_eq_iff`, `forall_coloring_ne_iff`, `exists_coloring_eq_and_ne_iff` (the
compulsion law on `ratFourGraph`), `coloring_eq_of_one_le_padicValRat`, `coloring_ne_of_padicValRat_eq_zero` (its applied
forms), `exists_coloring_forbidding_iff` (`[Johnson2006]` p. 212, every `d > 0`), `exists_coloring_forbidding_iff_padicValRat`,
`coloring_forbids_of_odd`, and the read-back anchor `nonempty_iso_unitDistance`.

### 1.3 The rulings in force, and the order of work

- Item 1082 (1): A3 is stated and proved here, about 40 lines. (3): two implementers on two branches; Part B's skeleton is
  removed from this branch in the first commit (done: `Instances/SeamFractional.lean` deleted, its import line in `Proofs.lean`
  and its `ARCHITECTURE.md` row removed; `tools/check_architecture.py` PASS, `data/fs131/irf1/arch-stage1.out`), so nothing
  with a `sorry` from Part B reaches `main` with this branch.
- Item 1075: no novelty wording for C7 — "prior art: pending `[KubickiLehelMorayne2002]`" where a novelty line would go.
- Item 1025: commits pass the privacy guard's hook; never `--no-verify`.
- Fences: none.

**Order:** the plan's — `Basic` (`sqDist_toQuat`, `nonempty_iso_unitDistance`, the two `val` examples), `Order` (the normal form
`zero_le_val_iff` first, then `zero_le_val_add`, `one_le_val_div_odd`, `mul_mem_comp`, `inv_prime_mem_comp`,
`inv_odd_mem_comp`, `mem_comp_iff`, `mem_pr_iff`, `pr_le_comp`, `sqDist_tetra`, `existsUnique_tetra_sub_mem_pr`),
`Compulsion` (Zaks's gadget, forced equal, forced different, the residue colourings, A3, the law on `quatGraph`, the heads),
`Forbid`. Re-price after the first two leaves; a saved stage after each module; then the merge of `main` and the gate.

### 1.4 The skeleton's stored statements, dumped before any proof edit

`data/fs131/irf1/lean/StatementDump.lean` (a copy of FS131-IRU2's dumper, the module list replaced by the four modules) run on
the planner's build as given (`lake build --no-build Proofs` under the slot: all targets up to date,
`data/fs131/irf1/uptodate-start.log`; no Lean file differs between the planner's build commit `1e69f1b91` and `273fb7b9a`):
`data/fs131/irf1/statements-skeleton.txt.gz` — 70 constants (24 + 21 + 20 + 5), 59 of them not internal. The comparator
`data/fs131/irf1/statements.py` (shaped like `tools/fs131_iru2_statements.py`): every non-internal constant of the skeleton must
be SAME (kind, flags, stored type; a definition's proof-erased value), every added constant is listed (A3 the one expected
head, the rest helpers), and the `example` heads of each module are compared as text with the base commit's (comments and
docstrings blanked). Self-check, the skeleton against itself (`data/fs131/irf1/statements-selfcheck.out`): 59 SAME, one FAIL —
`HEAD-ABSENT exists_equiv_coloring_add_eq_residue`, as it must be before A3 exists — and **five plants, each FIRED and alone**:
a character of `forall_coloring_eq_iff`'s stored type, `mem_comp_iff` dropped, `residueCol`'s data changed, an example head of
`Forbid` changed, an example of `Basic` turned into a theorem.

## Stage 2 — SAVED: `RationalFour/Basic` and `RationalFour/Order` proved

**Proved, every leaf, no statement changed** (the stage-4 statement comparison is the receipt from the kernel's side):
`Basic` — `sqDist_toQuat` (two lines: the coordinates of `toQuat` are `rfl`), `nonempty_iso_unitDistance` (the map
`x ↦ ⟨toLp (x · : ℝ), _⟩` is a bijection onto `ratPoints`; adjacency through `EuclideanSpace.dist_eq`, `Real.sqrt_eq_one` and
`Rat.cast_inj`), the two `val` examples. `Order` — all twelve leaves, in the plan's order, with eleven private helpers:
the arithmetic of `v₂` over odd denominators (`padicValRat_int_div_odd`, `zero_le_padicValRat_int`, `two_pow_dvd_iff`), squares
mod 4 and 8 (`sq_emod_four`, `sq_emod_eight_of_odd`, `parity_of_four_dvd`, `four_dvd_of_parity`), the induction on the 2-power
of the denominator generalizing the quadruple (`normal_form_aux`, the obligation pass's item 1 exactly), a common denominator
(`exists_int_mul_of_den_dvd`), the rational scalars of `ℍ[ℚ]` (`ratCast_inv`, `ratCast_mul`), and for the tetrahedron
`mem_pr_of_div_odd` and `div_two_mul_sub_eq` (the obligation pass's item 3: every residue case is one parity check by `omega`
and four coordinate identities).

**Two things the plan did not say, both found by the elaborator:**
1. **A coercion `ℚ → ℍ[ℚ]` elaborates to `Rat.cast` (`Quaternion.instRatCast`), not to `QuaternionAlgebra.coe`**, because
   `ℍ[ℚ]` is a division ring. So the stored statements of `inv_prime_mem_comp` and `inv_odd_mem_comp` are about
   `(Rat.cast (p : ℚ) : ℍ[ℚ])⁻¹` — the quaternion inverse of the cast — and Mathlib's `coe_inv`, `coe_mul` do not rewrite
   them. Read from the skeleton's dump (`Inv.inv … (Rat.cast … (Nat.cast p))`); the two helpers `ratCast_inv`, `ratCast_mul`
   carry them to rational arithmetic. The statement means what the plan says (`(Rat.cast p)⁻¹ = Rat.cast p⁻¹`, `ratCast_inv`).
2. **An anonymous constructor ascribed `ℍ[ℚ]` elaborates at the unfolded type `QuaternionAlgebra ℚ (-1) 0 (-1)`** (printed
   `ℍ[ℚ,-1,-1]`), and `∈ pr` or `*` against it then fails instance search. The skeleton's statements are not affected (each such
   constructor meets an expected type from `val` or an `Eq` at `ℍ[ℚ]`); in proofs the constructor is named by `set` or the
   statement takes the point as a variable with an equation (`mem_pr_of_div_odd`'s `hq`).

**The re-price from the first two leaves** (`zero_le_val_iff` with its helpers, then `zero_le_val_add`): about 175 lines in about
fifteen minutes, against the plan's 170 for the normal form; the module total is 570 lines (plan 450, the plan's skeleton
included), the extra being the explicit coordinate work of the tetrahedron and of the ring route to `1/p`. Total at this
stage, with `Compulsion` and `Forbid` drafted in copies under `data/fs131/irf1/work/`: about 1,300 lines against the plan's
1,190 — within a tenth; nothing to message.

**Build:** `data/fs131/irf1/build.sh order` (the brief's line: slot `--mem 8 --cpus 5`, `MEMMAX=8G BATCH=3`) on the working tree
over `45da98e5b` with `Basic` and `Order` filled: `data/fs131/irf1/build-order.log`. `RationalFour/Basic` and `Order` rebuilt
with no warning; `Compulsion` and `Forbid` rebuilt with their skeleton `sorry`s only.
