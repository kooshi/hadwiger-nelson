# FS131-ICO2 — the collapse finished: the last three modules, the build, the gate and the drafts

*Implementer's record (de Bruijn, the implementer, on Opus 5.5). Brief: `data/fs131/briefs/FS131-ICO2-collapse.md` (on `main`
at `57984248b`). Worktree `.claude/worktrees/kcl1`, branch `fs131-ico1`, taken over at `ebeb126d1` (clean). The plan:
`plans/FS131-KCL1-collapse-plan.md`; the previous implementer's record: `plans/FS131-ICO1-collapse.md`. Scripts and logs under
`data/fs131/ico2/`.*

## Theorems this phase proved

None yet at kernel grade (filled in as the gate passes).

## Stage 1 — SAVED: the readback

**Quotations.** The planner's checker (`data/fs131/kcl1/quote_check.py`, read-only) run on this brief and on the ICO1 brief
(whose § The statements is part of this one), against this worktree and against the main tree (`data/fs131/ico2/quote_check.out`):
this brief's two quotations (inventory items 988 and 993, `plans/FS131-close-inventory.md`) verbatim in both trees; the ICO1
brief's five (W2, row 128, the three headline statements) verbatim in this worktree, and the first two verbatim in the main
tree, whose third source (`Collapse/Headline.lean`) does not exist there — the skeleton is on this branch only, as expected.
Control: a copy of this brief with one letter changed inside its first quotation ("Weil" → "Weel") is reported NOT FOUND at
character 897 with exit 1 (`quote_check_plant.out`; the planted copy deleted after). **No mismatch.**

**The branch against the previous record's stage 5.** The branch is at `ebeb126d1`: the stage-5 report `32da5595c` with `main`
merged (`20fd89a89`, bringing `Rigidity/MainClauseFive` and records). `git status` clean. `grep -cw sorry`: 0 in `Thick`,
`Mixing`, `Colouring`, `Dichotomy`; 4 in `Slice`, 8 in `Selection`, 9 in `Headline` — as item 993 records. `main` is ahead by
two commits (`57984248b`, this brief; `99e78e428`, the handoff), neither touching `Proofs/`. The four proved modules have never
passed `./scripts/build.sh`: the first build of this job (`data/fs131/ico2/build1.log`) is their first real compile.

**The order of work.** (1) `Collapse/Slice` (4 leaves: `measure_ne_eq_k`, `tendsto_measure_ne_k`, `exists_extension_k`,
`exists_slice_k`, copies of `Rigidity/CountExtension` at `Fin k`), with an `omit [NumberField F] in` at `measure_ne_eq_k` if its
proof does not read the instance (item 993's ruling); (2) `Collapse/Selection` (8 leaves); (3) `Collapse/Headline` (9 `sorry`s:
`not_colorable_one_planeOver`, `chromaticNumber_planeOver_eq_plane_of_thick`, the two `isSquare_*`, the two `le_of_isSquare_*`,
the two `weil_*_lt_fifth`, `not_thick_bot`); a saved stage after each; (4) the experience pass on the headline names and
docstrings; (5) the build, no `sorry` in `Collapse/`; (6) merge `main`, the gate on one commit by the steps of
`data/fs131/clone1/run-gate.sh` copied under `data/fs131/ico2/`, every count change against `data/fs131/il5/gate/`, the
statement comparison against `data/fs131/ico1/statements-before.txt.gz` with the ruled changes (the `omit`s at `ThickAt.mono` and
`measure_ne_eq_k`, and `Collapse/Thick`'s two Mathlib imports) shown from the kernel's side, the vacuity scan's new sites with each
structure hypothesis's inhabitant, `#print axioms` of the three headlines and D-E1, D-E2; (7) the read-aloud against row 128;
(8) the drafts; (9) the report.

**Iteration.** While a build walks, the module under work is written in a copy under `data/fs131/ico2/work/` and compiled in the
previous job's farm (`build/ico1-farm`, by `data/fs131/ico1/lean1.sh`; the farm's `Thick`, `Mixing`, `Colouring`, `Dichotomy`
oleans are real files compiled from the committed sources within a minute of each commit); the copy goes over the module between
builds. The farm is iteration, never evidence: the build is the check.

## Stage 2 — SAVED: `Collapse/Slice`

**The first build of this job** (`data/fs131/ico2/build1.log`; `data/fs131/ico2/build.sh build1`, the brief's line:
`--mem 16 --cpus 10`, `MEMMAX=16G BATCH=6`): **OK — 381 of 381 batches, 9 modules rebuilt, 10 m 22 s**, at `ebeb126d1` (the stage-1
commit adds no Lean). Rebuilt: the seven `Collapse/` modules, `Rigidity/MainClauseFive` (brought by the last merge) and `Proofs`.
**The four modules the previous job proved (`Thick`, `Mixing`, `Colouring`, `Dichotomy`) compiled through `build.sh` with no
warning of any kind**; the only warnings are the `sorry` leaves of `Slice`, `Selection` and `Headline`. So D-E1, D-E2 and 28 of
the 49 leaves now stand on the real build.

**`Collapse/Slice`: every leaf proved** (4 of 4; written in `data/fs131/ico2/work/Slice.lean` while the build walked, compiled
in the farm, clean on the second compile — `slice1.out`, `slice2.out` — then copied over). Each is `Rigidity/CountExtension`'s
proof at `Fin k`:
- `measure_ne_eq_k` — `hσ.2 y`, then `measureReal_compl` on `{c(0) = c(y)}` and `probReal_univ`: four lines. **It does not read
  `[NumberField F]`, and carries `omit [NumberField F] in`** (item 993's ruling): its stored type drops that instance binder — a
  ruled change, listed in the gate's statement comparison and shown there from the kernel's side.
- `tendsto_measure_ne_k` — the landed proof with `σ(R̂) = 1` read from `hσ.2 0` (`{c | True} = univ`) and the real part of the
  coefficient in place of the correlation; no tetrahedral constant.
- `exists_extension_k` — the landed Borel–Cantelli construction verbatim at `Fin k`, over two private copies,
  `measure_ne_shift_k` and `measure_eq_add_unit_k` (the four-colour ones are private to `CountExtension`), each with
  `omit [NumberField F] in` as their originals have it.
- `exists_slice_k` — the landed Tonelli argument verbatim at `Fin k`.

About 255 lines of proof against the plan's 330, every one of them a copy; no Mathlib name new to the library.

## Stage 3 — SAVED: `Collapse/Selection`

*(Correction to stage 1: the farm is driven by this job's copy `data/fs131/ico2/lean1.sh` — the previous job's script with the
slot named `ico2` — not by `data/fs131/ico1/lean1.sh` itself.)*

**Every leaf proved** (8 of 8; work copy `data/fs131/ico2/work/Selection.lean`, clean on the second farm compile — `sel1.out`,
`sel2.out`). About 105 lines against the plan's 310.
- `measurable_fibreMass` — one term: `measurable_measure_prodMk_left` on `φ ⁻¹' {j}`, then `ennreal_toReal`.
- `sum_fibreMass` — `sum_measure_preimage_singleton` over `Finset.univ` for `x ↦ φ(z, x)`, `measure_univ`, and
  `ENNReal.toReal_sum`.
- `ae_slice_edge` — the reorder `((z, θ), x) ↦ ((z, x), θ)` is measure-preserving as `prodAssoc.symm ∘ (id × swap) ∘
  prodAssoc` (`measurePreserving_prodAssoc`, `MeasurePreserving.prod`, `Measure.measurePreserving_swap`); `SliceEdgeNullK`
  pulled back along it is null, `Measure.measure_prod_null` reads it fibre by fibre, and `ae_all_iff` over the countable
  `unitVectorsR F` (`countable_unitRing`) takes every unit vector at once.
- `not_both_heavy` — `mixing_K` on the two fibres of colour `j` (their edge set lies in the null set of `hzw`), and
  `not_both_ge_of_mixing` with `measureReal_le_one` for `a, b ≤ 1`.
- `le_fibreMass_selCol` — the pigeonhole `Finset.exists_le_of_sum_le` against `∑ 1/k = 1 = ∑ m_j`, then `dif_pos` and
  `Finset.min'_mem`.
- `measurable_selCol` — `selCol φ θ₀` factors through `z ↦ (j ↦ decide (θ₀ ≤ m_j(z)))` into the finite `Fin k → Bool`
  (`measurable_pi_iff`, `measurable_to_bool`, `measurableSet_le`), and every map out of that is measurable
  (`measurable_of_finite`); the factorization is one `simp only` with `decide_eq_true_eq`.
- `unitPairsNull_selCol` — the unit-pair set of a class lies in the exceptional set of `ae_slice_edge`: both ends selected `j`,
  so both heavy (`le_fibreMass_selCol`), against `not_both_heavy`.
- the spec example (a constant slice has fibre mass `1` on its colour) — `simp [fibreMass]`.

## Stage 4 — SAVED: `Collapse/Headline`

**Every leaf proved** (9 of 9; work copy `data/fs131/ico2/work/Headline.lean`; `head1.out` the first compile with two errors
and four `unnecessarySimpa` warnings, `head2.out` clean). About 50 lines against the plan's 250.
- `not_colorable_one_planeOver` — `0, 1 ∈ planeOver F` at distance `1`, and a colouring by `Fin 1` cannot separate them.
- `chromaticNumber_planeOver_eq_plane_of_thick` — `≤` by `Bridge.chromaticNumber_planeOver_le_plane`; `≥` by Mathlib's
  `chromaticNumber_le_of_forall_imp`: every `n` with `F²` `n`-colourable has `ℝ²` `n`-colourable — at `n ≥ 7` from
  `Bridge.chromaticNumber_complex_le_seven`, at `2 ≤ n ≤ 6` from `chromaticNumber_plane_le_of_thick` with
  `c(n − 1) ≤ 5c < 1`, and `n ≤ 1` excluded by the leaf above. (The first attempt, `le_chromaticNumber_iff_colorable`, is
  stated for a natural number on the left and does not apply.)
- `isSquare_635087`, `isSquare_deGrey` — `⟨√d, sqrt_mem_fieldOfRadicands⟩` and `Real.mul_self_sqrt`: the three-line proof of
  `SqrtClassValues.isSquare_radicand`, which is outside this module's import closure (`Instances/SqrtClassValues` imports
  `Rigidity/SqrtClassFive`, not the other way), inlined rather than imported.
- `le_of_isSquare_635087`, `le_of_isSquare_deGrey` — `interval_cases p` below `103` (`131`): each case closed by `omega`
  (`p % 4 ≠ 3`), by `norm_num` on `Nat.Prime` (composite), or by `decide +kernel` refuting `IsSquare` at one radicand. Plain
  `decide` hit the maximum recursion depth at the larger moduli of de Grey's case, so both lemmas use `+kernel` (same axioms).
  The residue facts were checked first by exhaustion in exact arithmetic (`data/fs131/ico2/residues.py`, output
  `residues.out`: 13 primes below `103` refute `635087`; 16 below `131` each refute one of `3, 5, 7, 11`, and `131` is the first
  prime `≡ 3 (mod 4)` at which all four are squares — so both bounds are tight; its plant, `--plant`, pretends `635087` is a
  square mod `83` and the check fails, `residues_plant.out`).
- `weil_103_lt_fifth`, `weil_131_lt_fifth` — `√103 < 10.4`, `√131 < 11.5` by `Real.sqrt_lt'`, then `div_lt_iff₀` and `linarith`.
- `not_thick_bot` — `UpperHalf.exists_stablePrime_rat` gives a ramified stable prime of `ℚ(i)`; `not_isRamified_of_thickAt`.

**No `sorry` remains in `Proofs/HadwigerNelson/Collapse/`** (`grep -cw sorry`: 0 in all seven). **A farm-side axiom print**
(iteration, not the gate's audit; `data/fs131/ico2/work/AxiomsScratch.lean`, `axioms-scratch.out`):
`chromaticNumber_planeOver_sqrt635087` and `chromaticNumber_planeOver_deGrey` on the standard three,
`Rigidity.positive_entropy_rigidity` and `StandingFive.kloosterman_bound`; the six-or-seven corollary on those and
`Outside.OAI158.no_proper_five_coloring`; **the general form `chromaticNumber_planeOver_eq_plane_of_thick` on the standard three
and `positive_entropy_rigidity` alone** — Weil's bound enters only at the instances, through `thick_of_card`, since thickness is
the general theorem's hypothesis; `not_thick_bot` on the standard three.

**Re-price, this job:** about 410 lines of proof for the three modules (Slice 255, Selection 105, Headline 50) against the plan's
890; with the previous job's 1,540, the module is about 1,950 lines against the plan's 3,270.

## Stage 5 — SAVED: the experience pass (`debruijn-experience-modeling`, loaded fresh)

**The users, and what each holds.** A mathematician citing the result holds the statement and its docstring, not the module; an
agent holds the docstring and what `exact?` returns; `exact?` holds the statements' shapes as indexed.

**Probes.** `data/fs131/ico2/work/ExactProbe.lean` (`exact-probe.out`), goals written as a user would, with
`SquareClass.fieldOfRadicands {635087}` and `{3, 5, 7, 11}` rather than the `abbrev`s: `exact?` returns
`Collapse.chromaticNumber_planeOver_sqrt635087` and `Collapse.chromaticNumber_planeOver_deGrey` (the `abbrev`s unfold for the
index, as they should). It does **not** close `6 ≤ χ(ℚ(√635087)²)`: the six-or-seven corollary is a conjunction, and search does
not project. Proposed, not made (it would add public statements): two one-line corollaries,
`six_le_chromaticNumber_planeOver_sqrt635087` and `chromaticNumber_planeOver_sqrt635087_le_seven` — held for the coordinator.

**Names.** Kept. `chromaticNumber_planeOver_eq_plane_of_thick` and `…_of_forall_thickAt` read as their statements in Mathlib's
convention (conclusion, then `of_` hypotheses). The instance names (`chromaticNumber_planeOver_sqrt635087`, `…_deGrey`) omit the
`_eq_plane` their conclusion would predict; the library is mixed here (`SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five`
against `UpperHalf.chromaticNumber_planeOver_eleven`), and the names are the coordinator's announcement's, so no rename is
proposed. `F635087` and `FdG` sit beside `F47`.

**Docstrings edited** (`Collapse/Headline` only; `Thick` and `ThickAt` already gloss themselves in words, and editing
`Collapse/Thick`'s docstrings would recompile its five dependents for nothing): the module doc says what the general form rests
on (`positive_entropy_rigidity` alone; Weil's bound enters only where an instance proves thickness) and how the plane is stated
(`unitDistance ℂ`, with `chromaticNumber_plane_eq_complex` to `EuclideanSpace ℝ (Fin 2)`; the `abbrev`s and `exact?`); the
general form's docstring glosses a stable prime and `c`-thickness in words and names its axiom; each instance's docstring gives
the mechanism (the least stable residue characteristic, Weil's constant) and its axioms; the corollary's says its halves are
`.1`, `.2`; the two residue lemmas say `decide +kernel`, as their proofs now are. **Docstrings only, shown in text**:
`data/fs131/lc1/code_only_diff.py HEAD …/Headline.lean` reads SAME (7,311 characters of code both sides; comments 5,979 →
7,590), and its plant (`--plant`, the first `:=` turned into `:≡`) reads DIFFERS (`data/fs131/ico2/pass-code-only*.out`). The
file compiles clean in the farm (`work/head3.out`). The axiom claims written into the docstrings are the farm's print; the gate's
audit is their check.
