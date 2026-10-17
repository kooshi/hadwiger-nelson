# FS131-IRF1 — rational four-space at four colours: the compulsion law, Johnson's question and the structure clause, proved

*de Bruijn, the implementer (Opus 5.5), 2026-10-17. Brief: `data/fs131/briefs/FS131-IRF1-four-space.md` (on `main`). Worktree
`.claude/worktrees/il5`, branch `fs131-kfs1`, from `273fb7b9a` (the planner's skeleton; its plan
`plans/FS131-KFS1-four-space-plan.md`). Working files: `data/fs131/irf1/`.*

## Theorems this phase proved

Every one [kernel], on exactly `[propext, Classical.choice, Quot.sound]` (`#print axioms`, `data/fs131/irf1/readaloud.txt`;
the audit's 63 records, `data/fs131/irf1/axioms-all.txt`), no outside theorem, no hypothesis standing for one; gated on
`6ab6248fe` (stage 4).
- `HadwigerNelson.RationalFour.forall_coloring_eq_iff`, `forall_coloring_ne_iff`, `exists_coloring_eq_and_ne_iff` — the
  four-colour compulsion law of `ℚ⁴` (`RationalFour/Compulsion`); applied forms `coloring_eq_of_one_le_padicValRat`,
  `coloring_ne_of_padicValRat_eq_zero`.
- `HadwigerNelson.RationalFour.exists_coloring_forbidding_iff` — `[Johnson2006]` p. 212's question, every `d > 0`
  (`RationalFour/Forbid`); `exists_coloring_forbidding_iff_padicValRat`, `coloring_forbids_of_odd`.
- `HadwigerNelson.RationalFour.exists_equiv_coloring_add_eq_residue` — A3, the structure clause; `coloring_eq_of_forall_tetra`.
- `HadwigerNelson.RationalFour.coloring_eq_of_eqOn_isOpen` — `[KubickiLehelMorayne2002]` Thm 4.3's rigidity.
- `HadwigerNelson.RationalFour.coloring_eq_of_sqDist_two` — `[Zaks1999]` Lemma 1; `mem_comp_iff` — `[BendaPerles2000]`
  pp. 123–125's component; `residueColouring`, `nonempty_coloring`, `nonempty_ratFourGraph_coloring` — `[Johnson1990]` Thm 3's
  colouring; `nonempty_iso_unitDistance` — the read-back anchor; `zero_le_val_iff`, `mem_pr_iff`,
  `existsUnique_tetra_sub_mem_pr`, `inv_odd_mem_comp`, `mul_mem_comp` and the quaternion-level law.

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

## Stage 3 — SAVED: `RationalFour/Compulsion` and `RationalFour/Forbid` proved; A3 and the rigidity corollary added

**Proved, every leaf, no stored statement changed** (receipt: stage 4's comparison). `Compulsion` — Zaks's Lemma 1 by the
gadget `0, 1, h, a, b` moved by `z ↦ x + (z − a)·q` and one `decide` over `Fin 4⁵` (the plan's route); forced equal by closure
induction with the base point quantified (the obligation pass's item 4); forced different through the tetrahedron; the residue
colourings through four private lemmas (`residue_spec`, `residue_eq_of_sub_mem_pr`, `sub_out_mem_comp`,
`sub_mem_pr_of_residue_eq`); the law on `quatGraph`; the three heads on `ratFourGraph` by two transport lemmas
(`forall_coloring_iff_quat`, `exists_coloring_iff_quat`, over private colourings read through `toQuat`), each head a single
`rw` chain; Zaks's Lemma 2 example. `Forbid` — Lagrange over `ℚ` (`Nat.sum_four_squares` at `num·den`), the odd-quotient reading
of `v₂ = 0` (coprimality of `num`, `den`), the rational answer (the similarity `z ↦ z·q`, `|q|² = r`, carries a colouring
forbidding `r` to one forbidding `1/r`), `coloring_forbids_of_odd`, Johnson's question for every `d > 0`, and the two spec
examples.

**Added, public** (the brief's A3, and three the brief left to me, each named in the report):
- `exists_equiv_coloring_add_eq_residue` — **A3, the structure clause**: `∀ c x₀, ∃ e : Fin 4 ≃ Fin 4, ∀ z ∈ comp,
  c (x₀ + z) = e (residue z)` (the planner's one line, its name chosen here; `e i = c (x₀ + tetra i)`, a bijection because the
  tetrahedron's six edges are unit, `Finite.injective_iff_bijective`).
- `coloring_eq_of_forall_tetra` — its corollary: two proper four-colourings agreeing on one translated tetrahedron agree on its
  component.
- `coloring_eq_of_eqOn_isOpen` — **`[KubickiLehelMorayne2002]` Thm 4.3's rigidity, in the paper's own form** (the coordinator's
  optional addition, inventory item 1086, taken): for every open `U ⊆ Fin 4 → ℝ` meeting `ℚ⁴` and every two proper
  four-colourings `c, c'` of `ratFourGraph`, agreement on `U ∩ ℚ⁴` gives `c = c'`. One new input, as the reader said: every
  coset of `P` is dense, `(2/3ᵏ)ℤ⁴ ⊆ P` (private `exists_near_sub_mem_pr`, by `round` coordinate by coordinate). 68 lines with its docstrings
  against the reader's guess of 60–120.
- `nonempty_ratFourGraph_coloring` — the model of every hypothesis of the `ratFourGraph` heads, an unconditional
  `Nonempty (ratFourGraph.Coloring (Fin 4))`, which the vacuity scan reads as a witness (`nonempty_coloring`, the skeleton's, is
  the one for `quatGraph`).

**The merge of `main`** (`0e390e766`, before the build): main's commits since `273fb7b9a` change no Lean module, no script and
no lakefile (`git diff --stat` over `Proofs`, `Proofs.lean`, `scripts`, `lakefile.toml`: empty); they bring
`[KubickiLehelMorayne2002]`'s bibliography row and the reading record `plans/FS131-PAS3-kubicki-lehel-morayne.md`.

**Build:** `data/fs131/irf1/build.sh all` on `68f2052ce` (clean tree): **OK — 746 of 746 batches, 3 modules rebuilt
(`Compulsion`, `Forbid`, the root), 0 modules with warnings**, 18 m 49 s (`data/fs131/irf1/build-all.log`; the gate's copy
`build/gate/build/20261017T012516Z-2119524.log`). No `sorry` remains in the four modules.

## Stage 5 — SAVED: the read-aloud

Each statement as the kernel stores it (`data/fs131/irf1/readaloud.txt`, `#check @` on the built modules), read against
`CLOSED-QUESTIONS.md` § 3's `ℚ⁴` entry (C7) and `[Johnson2006]` p. 212's question, *"For which d > 0 does there exist a
4-coloring of ℚ⁴ which forbids both distances 1 and d?"*. Vocabulary: `ratFourGraph` on `Fin 4 → ℚ`, `x ∼ y ⟺
Σᵢ (xᵢ − yᵢ)² = 1` (`sqDist4`); a proper four-colouring is Mathlib's `ratFourGraph.Coloring (Fin 4)`; `nonempty_iso_unitDistance`
shows this graph is the library's `unitDistance (EuclideanSpace ℝ (Fin 4))` induced on the points with rational coordinates.

- **`exists_coloring_forbidding_iff`** `{d : ℝ} (hd : 0 < d) : (∃ c, ∀ x y, (sqDist4 x y : ℝ) = d ^ 2 → c x ≠ c y) ↔
  (∀ r : ℚ, (r : ℝ) ≠ d ^ 2) ∨ ∃ p q : ℕ, Odd p ∧ Odd q ∧ d ^ 2 = p / q`. Aloud: *for `d > 0`, a proper four-colouring of
  `ℚ⁴` in which no two points at distance `d` share a colour exists exactly when `d²` is irrational, or `d² = p/q` with `p, q`
  odd natural numbers.* That is Johnson's question as posed (forbidding 1 is properness), answered for every `d > 0`, and C7's
  answer with LX's scope repair as its first disjunct. **Matches.**
- **`coloring_forbids_of_odd`** `(hp : Odd p) (hq : Odd q) (c) (h : sqDist4 x y = p / q) : c x ≠ c y` — *every proper
  four-colouring forbids `√(p/q)`*: C7's "and then every proper four-colouring forbids `d`". **Matches.**
- **`exists_coloring_forbidding_iff_padicValRat`** `(hr : 0 < r) : (∃ c, ∀ x y, sqDist4 x y = r → c x ≠ c y) ↔
  padicValRat 2 r = 0` — the same on rational squared distances: forbiddable iff `v₂(r) = 0`. **Matches** C7's valuation form.
- **The compulsion law.** `forall_coloring_eq_iff x y : (∀ c, c x = c y) ↔ x = y ∨ 1 ≤ v₂(sqDist4 x y)`;
  `forall_coloring_ne_iff x y : (∀ c, c x ≠ c y) ↔ v₂(sqDist4 x y) = 0 ∧ x ≠ y`; `exists_coloring_eq_and_ne_iff x y :
  ((∃ c, c x = c y) ∧ ∃ c, c x ≠ c y) ↔ v₂(sqDist4 x y) < 0`. Aloud: *a pair is forced to one colour iff it is one point or
  `v₂(|x − y|²) ≥ 1`; forced apart iff `v₂ = 0` and the points differ; free iff `v₂ < 0`* — C7's three clauses ("a pair",
  i.e. `x ≠ y`), with the junk value `padicValRat 2 0 = 0` guarded in the open: at `x = y` the first holds, the second's
  `x ≠ y` fails, the third's `v₂(0) = 0 < 0` fails, as the left sides do. **Matches.** The applied forms
  `coloring_eq_of_one_le_padicValRat`, `coloring_ne_of_padicValRat_eq_zero` are one direction each.
- **`exists_equiv_coloring_add_eq_residue`** `(c : quatGraph.Coloring (Fin 4)) (x₀ : ℍ[ℚ]) : ∃ e : Fin 4 ≃ Fin 4, ∀ z ∈ comp,
  c (x₀ + z) = e (residue z)` — A3: *on the component `x₀ + comp` every proper four-colouring is the residue map followed by a
  bijection of the colours*. Stated on `quatGraph`, which `quatIso` identifies with `ratFourGraph` (`x ↦ (x₀, x₁, x₂, x₃)` as
  `re, imI, imJ, imK`); `comp` is the group the unit vectors generate (`mem_comp_iff`: `v₂(|z|²) ≥ 0`), `residue z` the vertex
  of the unit tetrahedron `(0, 1, h, h′)` congruent to `z` modulo `P = (1 + i)·comp` (`existsUnique_tetra_sub_mem_pr`). C7's
  "on each component, the residue colouring onto `𝔽₄` up to relabelling" — **matches**, with `𝔽₄` named by a transversal:
  the field structure of `comp/P` is not stated.
- **`coloring_eq_of_eqOn_isOpen`** `(c c' : ratFourGraph.Coloring (Fin 4)) {U : Set (Fin 4 → ℝ)} (hU : IsOpen U) (hne : ∃ x,
  (↑x) ∈ U) (h : ∀ x, ↑x ∈ U → c x = c' x) : c = c'` — `[KubickiLehelMorayne2002]` Thm 4.3's rigidity in its p. 49 definition
  as the coordinator quoted it (item 1086; I have not read the paper): *for every open `U` meeting `ℚ⁴` and every proper
  four-colouring `c'`, agreement on `U ∩ ℚ⁴` gives `c = c'`*. **Matches the quoted definition** at `k = 4`, `D = ℚ⁴` with
  `ℝ⁴`'s topology (as `Fin 4 → ℝ`, the product topology).

**Not claimed:** anything with five or more colours; anything in `ℚⁿ`, `n ≠ 4`; the field structure of `comp/P`; the S³-density
half of Thm 4.3; novelty (prior art: pending `[KubickiLehelMorayne2002]` in the modules' words, per the brief; item 1086's
reading — the paper does not contain C7 — is the coordinator's to word).

## Stage 4 — SAVED: the gate, on one commit

**The commit:** `6ab6248fe` (branch `fs131-kfs1`, `main` merged at `0e390e766`; the tree clean at the pass's start). The steps of
`data/fs131/irf1/run-gate.sh` (a copy of `data/fs131/clone1/run-gate.sh`, paths changed), run from the snapshot
`build/irf1/snap/run-gate.sh`; every log under `data/fs131/irf1/gate/`, `run-pass.out` the summary. **Every step exit 0:**
up to date (5 s); `sorry` (narrow) 0 lines; line-initial `axiom` lines 5 (unchanged); `dupnames` and its self-test; `axioms` and
its self-test (287 s, every planted fault fired, every partner passed); `vacuity` and its self-test; `assumptions` and its
self-test; `check_architecture` PASS; `lake lint` — `Linting passed for Proofs.`; the three digests. The one tracked file
modified during the pass is this record (the read-aloud, appended while it ran).

**Counts, against `main`'s last gate (FS131-IRU2's, `data/fs131/iru2/gate/`), each change explained:**
| count | `main` | here | why |
|---|---|---|---|
| audit records | 11,743 | 11,806 | +63: the four modules' public theorems and definitions, filed CLEAN (`scripts/Axioms.lean`'s FS131-IRF1 block, generated by `data/fs131/irf1/audit_block.py`; coverage OK) |
| clean / axiom-free / imported / purchases | 11,043 / 575 / 120 / 5 | 11,106 / 575 / 120 / 5 | +63 clean, each on exactly the standard three; nothing else moves |
| vacuity `declarations` | 22,728 | 22,802 | +74 = 63 public records + 10 equation lemmas Lean generated on demand in the modules that defined them (`sqDist`, `sqDist4`, `onePlusI`, `val` in `Basic`; `tetra`, `hur`, `hur'`, `pr` in `Order`; `residue`, `residueCol` in `Compulsion`) + 1 matcher, `forall_quatColoring_ne_iff.match_1_1` (a destructuring `fun ⟨hc, hp⟩` in its term; `LEAN.md`'s FS131-ICS1 line — reconciled, not rewritten: a rewrite costs a rebuild and changes no statement) |
| `refutations-skipped` | 246 | 246 | no new statement concludes `False` |
| `sites` / `witnessed` | 1,465 / 40 | 1,477 / 52 | +12 sites, each WITNESSED (below) |
| `generic` / `unknown` / `declared` / `vacuous` / `stale` | 1,420 / 2 / 3 / 0 / 0 | the same | |
| assumptions (nine counts) | `axioms=3 rests=168 named=19 inline=14 outside=7 ours=21 open=5 takes=109 mentions=2` | the same; `fails=0` | no statement takes a declared hypothesis; no `Prop` former is defined |
| dupnames, generated on demand | 31 | 31 | each equation lemma lives in one module of a chain; none doubled |

**The vacuity scan's twelve new sites, each structure hypothesis with its inhabitant named** (`data/fs131/irf1/gate/vacuity.log`):
the binder `c : quatGraph.Coloring (Fin 4)` in `coloring_eq_of_sqDist_two`, `coloring_eq_of_mem_pr`,
`coloring_ne_of_mem_comp_of_notMem_pr`, `exists_equiv_coloring_add_eq_residue`, `coloring_eq_of_forall_tetra` (two binders) and
`residueColouring`'s type — WITNESSED by `nonempty_coloring` (the residue colouring at shift 0, a library theorem); the binder
`c : ratFourGraph.Coloring (Fin 4)` in `coloring_eq_of_one_le_padicValRat`, `coloring_ne_of_padicValRat_eq_zero`,
`coloring_forbids_of_odd` and `coloring_eq_of_eqOn_isOpen` (two binders) — WITNESSED by `nonempty_ratFourGraph_coloring`. The
hypotheses beyond the colourings are conditions on the theorem's own variables, each met at a named point by the spec examples:
`h : sqDist x y = 2` (Zaks's Lemma 2 example's pair, scaled), `1 ≤ v₂` at `(0, (2,0,0,0))`, `sqDist4 x y = 3/5` (the `Forbid`
example), and `coloring_eq_of_eqOn_isOpen`'s `U` at `U = univ` (any colouring with itself). The heads stated as `↔` carry their
colourings inside the equivalence and read no site; both sides are inhabited by the same two witnesses.

**Statement comparison against the skeleton** (`data/fs131/irf1/statements.out`; the dump of the built modules
`statements-after.txt.gz` against `statements-skeleton.txt.gz`): **59 of 59 skeleton constants SAME** (kind, flags, stored type;
each definition's proof-erased value), VALUE-MOVED 0, the `example` heads of all four modules identical to `273fb7b9a`'s;
**28 added**: the one expected head (A3), three public theorems the brief left to me (`coloring_eq_of_forall_tetra`,
`coloring_eq_of_eqOn_isOpen`, `nonempty_ratFourGraph_coloring`), 24 private helpers. Its five plants fired again on this print.

**`#print axioms` of every head:** the standard three, no outside theorem (Theorems this phase proved, above).

**Negative controls watched:** the four gate self-tests (dupnames 15 controls, axioms 23, vacuity 65, assumptions 21) fired and
passed in this pass; my own: the quotation check (`formalize` → `formalise`: MISSING), the statement comparison (five plants),
the audit-block generator (`--plant`: an unknown axiom, a `sorryAx`, a declared import and a misfiled record, all four reported,
`data/fs131/irf1/audit-plant.out`), and the architecture check (`RationalFour/Forbid`'s imports cell planted as
`RationalFour/Order` in a copy: `FAIL imports of RationalFour/Forbid`, exit 1, `data/fs131/irf1/plants/arch-plant.out`).
**Not run:** a lint plant — it needs a module edited, a walk rebuilt and a second walk to restore (two walks of about 19 minutes
at this machine's `BATCH=3`); the lint driver is unchanged since FS131-LGT1 watched its control fire.
