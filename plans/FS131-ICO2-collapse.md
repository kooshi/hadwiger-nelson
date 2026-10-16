# FS131-ICO2 — the collapse finished: the last three modules, the build, the gate and the drafts

*Implementer's record (de Bruijn, the implementer, on Opus 5.5). Brief: `data/fs131/briefs/FS131-ICO2-collapse.md` (on `main`
at `57984248b`). Worktree `.claude/worktrees/kcl1`, branch `fs131-ico1`, taken over at `ebeb126d1` (clean). The plan:
`plans/FS131-KCL1-collapse-plan.md`; the previous implementer's record: `plans/FS131-ICO1-collapse.md`. Scripts and logs under
`data/fs131/ico2/`.*

## Theorems this phase proved

All [kernel], through the full gate on `7c72b9bf7` (stage 7); axioms as the receipt of record prints them (std3 =
`[propext, Classical.choice, Quot.sound]`; EL = `Rigidity.positive_entropy_rigidity`; W = `StandingFive.kloosterman_bound`;
O5 = `Outside.OAI158.no_proper_five_coloring`). The modules `Collapse/Thick`, `Mixing`, `Colouring`, `Dichotomy` were proved by
FS131-ICO1 and `Slice`, `Selection`, `Headline` by this job; all seven reached the kernel's grade at this gate. The headlines:
- `Collapse.chromaticNumber_planeOver_sqrt635087` — `χ(ℚ(√635087)²) = χ(ℝ²)` — std3 + EL + W.
- `Collapse.chromaticNumber_planeOver_eq_plane_of_thick` — `χ(F²) = χ(ℝ²)` at every real number field uniformly `c`-thick with
  `0 ≤ c < 1/5` — std3 + EL.
- `Collapse.chromaticNumber_planeOver_deGrey` — `χ(ℚ(√3, √5, √7, √11)²) = χ(ℝ²)` — std3 + EL + W.
- `Collapse.chromaticNumber_planeOver_eq_plane_of_forall_thickAt` — the same, each stable prime `c_P`-thick with `c_P < 1/5` —
  std3 + EL + W.
- `Collapse.chromaticNumber_planeOver_sqrt635087_six_or_seven` — `6 ≤ χ(ℚ(√635087)²) ≤ 7` — std3 + EL + W + O5.
- `Collapse.chromaticNumber_plane_le_of_thick` — over a uniformly `c`-thick real number field with `c(k − 1) < 1`, a proper
  `k`-colouring of `F²` gives `χ(ℝ²) ≤ k` (the load-bearing step) — std3 + EL.
- The two approved edits: `StandingFive.norm_normOne_charSum_le` (D-E1, the two-sided norm-one character bound, over the named
  hypothesis `KloostermanBound`) — std3; `Rigidity.norm_charSum_le_weil` (D-E2, Weil's bound at every level) — std3 + W.
- Along the line: `Collapse.exists_invColouring_TA`, `Collapse.not_isSPWitness`, `Collapse.exists_slice_of_colorable` — std3 +
  EL; `Collapse.thickAt_weil`, `thick_of_card`, `thick_of_forall_thickAt`, `thick_sqrt635087`, `thick_deGrey` — std3 + W;
  `Collapse.mixing_K`, `finite_mixing`, `exists_aeColouring_of_slice`, `exists_slice_k`, `exists_extension_k`,
  `tendsto_measure_ne_k`, `exists_factorLawK`, `exists_isColourSpectral`, `exists_invColouring`, `not_thick_bot`,
  `le_of_isSquare_635087`, `le_of_isSquare_deGrey` and the rest — std3.

Every one of the 80 public theorems of the nine modules, with its axioms: `data/fs131/ico2/gate/theorems-proved.txt`; every
one of the 138 public records (theorems and definitions) as filed in the audit: `data/fs131/ico2/audit.*.lean`.

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

## Stage 6 — SAVED: the build, and the module map

**The build** (`data/fs131/ico2/build2.log`, at `1f9792da4`, the stage-5 commit; the brief's line): **OK — 381 of 381 batches,
4 modules rebuilt (`Collapse/Slice`, `Selection`, `Headline`, `Proofs`), 0 with warnings, 9 m 39 s.** The full output
(`build/gate/build/20261016T134242Z-3442973.log`) holds no `warning` line; `grep -rnw sorry Proofs/HadwigerNelson/Collapse/` finds
nothing, in code or in comments. Every module of the collapse has now compiled through `build.sh` with its proofs.

**`ARCHITECTURE.md`**: seven rows, after `Rigidity/EntropySplitMax` (the last `Rigidity/` row of § 3), the planner's draft
(§ 4.5) brought to what is proved — each module's role, its principal declarations, its imports cell, ledger row 128, FS-131.
`tools/check_architecture.py`: PASS, 625 modules and 625 rows, 0 import mismatches, none of the rows' identifiers unknown
(`data/fs131/ico2/arch.txt`); its plant — `Collapse/Thick`'s imports cell set to `Rigidity/CountTorus` in a copy — fails by name
(`FAIL imports of Collapse/Thick: stated-only ['Rigidity/CountTorus'], real-only ['Rigidity/CountCompletion']`,
`arch-plant.txt`). What each module rests on is added to its row from the gate's audit.

**The gate's instruments, written** (each run at stage 7): `data/fs131/ico2/run-gate.sh` (the `clone1` steps, logs to
`data/fs131/ico2/gate/`, slots `ico2-*`; the diff is those four lines); `data/fs131/ico2/lean/StatementDump.lean` (FS131-ICO1's
dumper, namespace renamed) with `data/fs131/ico2/statements.py` (the comparison against `statements-before.txt.gz`, the two ruled
binder drops checked as FS131-KN9's one-binder check asks, four plants); `data/fs131/ico2/lean/AxiomsAll.lean` (FS131-LGT1's
record printer, the nine modules listed) with `data/fs131/ico2/audit_block.py` (the audit's blocks from the kernel's print, and
`--coverage` after they are filed; three plants).

## Stage 7 — SAVED: the gate on one commit

**The commit of record: `7c72b9bf7`** (branch `fs131-ico1`). It holds `main` merged (`ac830b568`: the brief and the handoff
only, no Lean), the gate's inputs (`54921b69e`), the coordinator's ruling of item 998 (`5391315fc`: the unread binder
`[∀ i, DecidableEq (A i)]` dropped from `Collapse.norm_sum_piFinset_le`), and the build of that commit (`7c72b9bf7` adds only
the build's log, a script parameter and a printer: no Lean; the pass's up-to-date check reads exit 0 there). **The build**
(`data/fs131/ico2/build4.log`, at `5391315fc`): OK — 381 of 381 batches, 5 modules rebuilt (`Collapse/Thick`, `Mixing`,
`Selection`, `Headline`, `Proofs`), 0 with warnings, 9 m 57 s; its slot lowered to `--mem 9 --cpus 6`, `MEMMAX=9G` (two planners
held 13 GiB and six cores; the brief's 16 GiB and ten cores could not be admitted beside them — a cap lowered, never raised).
The build before the ruling (`build3.log`) was stopped while it waited for its slot, having read nothing (`exit=143`; the waiting
`slot.py` found by the inode of the log it held open, stopped by PID, gone from `ps` and the log static after).

**The pass** (`data/fs131/ico2/run-gate.sh`, `clone1`'s steps; logs `data/fs131/ico2/gate/`), 14:42:28–14:55:47 UTC,
`HEAD=7c72b9bf7…`, tracked files modified 0 at the start and 0 after. Every step exited 0; read from the saved logs, against
`main`'s last gate (`data/fs131/il5/gate/`, `113ca8ece`):

| step | `main`'s last gate (`113ca8ece`) | this pass (`7c72b9bf7`) | the change, explained |
|---|---|---|---|
| up to date | exit 0 | exit 0 (3 s) | — |
| `sorry` (narrow) | 0 lines | 0 lines | — |
| line-initial `axiom` | 5 lines | 5 lines, identical (`diff` empty) | no axiom added |
| doubled names | OK, 31 generated on demand | OK, 31, the list identical | the two new `congr_simp` theorems (`Collapse.factorK.congr_simp` in `Dichotomy`, `Rigidity.Counting.K.congr_simp` in `Mixing`) are each in one module |
| its self-test | 15 of 15 | 15 of 15 | — |
| axiom audit | 11287 records: 10651 clean, 569 axiom-free, 62 imported, 5 purchases | 11398: **10747** clean, 569, **77** imported, 5 | +111 records, every public record of the nine modules not filed before: 96 CLEAN, 15 IMPORTED (6 on Weil's bound alone, 5 on E–L alone, 3 on both, 1 on both and the five-colour theorem); declared imports 3, library axioms 3, native auxiliaries 10, unchanged |
| its self-test | 23 of 23 | 23 of 23 | after the two state controls moved (below) |
| vacuity | declarations=22241, refutations-skipped=240; sites=1455 vacuous=0 stale=0 declared=3 witnessed=38 generic=1412 unknown=2 | declarations=**22357**, refutations-skipped=**242**, the sites identical | +116 declarations: the scan's own predicates read on the nine modules (`data/fs131/ico2/lean/VacuityNew.lean`, `vacuity-new.txt`) give 114 in the seven `Collapse/` modules and one each from D-E1 and D-E2; +2 refutations, `Collapse.shift_mem_Xk` and `rot_mem_Xk` (below); **no site** |
| its self-test | 65 of 65 | 65 of 65 | — |
| assumptions | axioms=3 rests=78 named=19 inline=14 outside=7 ours=21 open=5 takes=108 mentions=2 | rests=**99**, takes=**109**, the rest identical | +21 `RESTS` rows (the 20 new public IMPORTED records' 20 axiom pairs — 9 on E–L, 10 on Weil's bound, 1 on the five-colour theorem — and D-E2's private `norm_charSum_one_weil` on Weil's bound) and +1 `TAKES` (D-E1 takes the named hypothesis `KloostermanBound`, as its sibling `normOne_charSum_ge` does); also constants 21920 → 22111, theorems 16046 → 16208, formers 450 → 456 (the six new predicates, each concluded by a theorem, none flagged), hypotheses 26313 → 26653, `cohyp` 77 → 80, `unseen` 21276 → 21481 (the new theorems' other hypotheses — every one a condition on the theorem's own variables: **no hand result of ours is written out in a binder**, said here on the landing's word as the step asks) |
| its self-test | 33 of 33 | 33 of 33 | — |
| architecture | PASS, 618 modules | PASS, **625** modules and rows, 0 import mismatches | +7 modules and rows |
| lint | 14 linters `(2/2) Passed!`, "Linting passed for Proofs." | the same | after the ruling of item 998 (below) |
| digests | the headers and `CLAUDE.md` matching | the two ledgers' headers match (9 of 9 each); `CLAUDE.md` flagged stale in exactly three places: § Trust ledger `10651 clean → 10747, 62 imported → 77`; § Trust ledger `rests 78 → 99, takes 108 → 109`; § The gate `declarations 22241 → 22357, refutations-skipped 240 → 242` | `CLAUDE.md` is Keryx's to write: the drafts below |

**The gate's inputs, each seen red for its named cause before it moved** (`data/fs131/ico2/prep/`): the audit's block —
generated from the kernel's print of every record of the nine modules (`lean/AxiomsAll.lean` → `axioms-all.txt`, 322 records:
138 public, 184 private, which the audit does not take) by `audit_block.py` (96 CLEAN, 6 / 8 / 1 IMPORTED under the
`kloosterman_bound`, `positive_entropy_rigidity` and `no_proper_five_coloring` banners, each with a job comment line), filed in
`scripts/Axioms.lean`; its coverage check after filing reads all 138 filed under their class, and against the pre-filing copy
reports the 111 UNFILED with exit 1; its plant (an unknown axiom, a `sorryAx`, a CLEAN record moved to PURCHASED) reports all
three with exit 1. `scripts/axioms-controls.txt`: the self-test on the new audit failed exactly `baseline` (expected
`imported=62`, got 77) and `imported_declared` (63, got 78), the other 21 behaving (`axioms-selftest-red.log`); moved by the
file's rule (the counts, the `old` digests' texts, the header's tally: seventy-seven IMPORTED, Weil's bound 58, the five-colour
theorem 7, E–L 27, 14 on E–L and Weil's bound), then 23 of 23. `scripts/assumptions-ledger.txt`: the step failed on exactly 22
`unlisted-consumer` rows (`assumptions-red.log`); written by `--write-ledger` (22 rows in, none out, 188 → 210;
`assumptions-write-ledger.log`). `scripts/vacuity-baseline.txt`: the header's count line after the scan flagged it stale and
nothing else (`vacuity.log`). No `AssumptionAudit.declared` line: the theorems take no hypothesis standing for an assumption.

**The lint finding and the ruling (inventory item 998).** The preview of the linters on the stage-6 build
(`prep/lint-preview.log`) failed on one finding: `Collapse.norm_sum_piFinset_le`, argument 7, `[(i : ι) → DecidableEq (A i)]`,
unread (the proof is classical; `Fintype.piFinset` needs only `[DecidableEq ι]`) — a skeleton statement's, which the build's
linters never see. I referenced the binder in the proof to keep the stored statement, and messaged the coordinator; the ruling:
drop it, a third ruled change of item 993's kind. Dropped at `5391315fc`; its one consumer `levelThick` finds the instance as
before. Lint is green on the commit of record.

**The statement comparison** (`data/fs131/ico2/statements.py` against `data/fs131/ico1/statements-before.txt.gz`, the
skeleton's compiled library dumped before the first rebuild; the after-dump from the gated build, `gate/statements-after.txt`;
`gate/statements.out`): **CLEAN**. In the nine modules every stored type, and every definition's data (the value with proofs
erased), is the skeleton's but the three ruled drops, each read as FS131-KN9's one-binder check reads one — the before-print
holds the binder's text exactly once and, with it removed, is the after-print character for character:
- `Collapse.ThickAt.mono`: `[NumberField ↥F]` (item 993, the committed `omit`);
- `Collapse.measure_ne_eq_k`: `[NumberField ↥F]` (item 993, the `omit` at `Collapse/Slice`);
- `Collapse.norm_sum_piFinset_le`: `[∀ i, DecidableEq (A i)]` (item 998).
Added: the two public theorems of the approved edits, `StandingFive.norm_normOne_charSum_le` (D-E1) and
`Rigidity.norm_charSum_le_weil` (D-E2), and no other public declaration; 87 private helpers (2 in `ClassRatio`, 85 in
`Collapse/`), and two theorems Lean generates on demand (`factorK.congr_simp`, `Rigidity.Counting.K.congr_simp`). **`Collapse/Thick`'s
two added Mathlib imports moved no stored term**: its other fifteen constants, and every constant of the six modules downstream,
print identically, instance arguments included. Its plants: a changed stored type, a dropped constant, an unlisted public
constant, and each ruled binder a near miss by one character (its closing bracket kept) — each reported by name and nothing else
new (`PLANTS ALL FIRED`). Its first run had a bug of my own (the bracket scan began at the binder's own `[`), which made the ruled
entries read DIFFERS — a failure in the loud direction, fixed before any verdict was taken.

**`#print axioms`** (the receipt of record, `gate/receipt-axioms.log`, `pp.fullNames`):
- `Collapse.chromaticNumber_planeOver_sqrt635087`, `Collapse.chromaticNumber_planeOver_deGrey`,
  `Collapse.chromaticNumber_planeOver_eq_plane_of_forall_thickAt`: `[propext, Classical.choice, Quot.sound,
  Rigidity.positive_entropy_rigidity, StandingFive.kloosterman_bound]`;
- `Collapse.chromaticNumber_planeOver_eq_plane_of_thick`: `[propext, Classical.choice, Quot.sound,
  Rigidity.positive_entropy_rigidity]` — **Weil's bound is not among them**: thickness is the hypothesis, and Weil enters only
  where an instance proves it (`thick_of_card`); the per-place form needs it, because making per-prime thickness uniform uses
  Weil's bound at the infinitely many large primes (`thick_of_forall_thickAt`);
- `Collapse.chromaticNumber_planeOver_sqrt635087_six_or_seven`: those five and `Outside.OAI158.no_proper_five_coloring`;
- D-E1, `StandingFive.norm_normOne_charSum_le`: the standard three (Weil's bound is its named hypothesis `KloostermanBound`);
- D-E2, `Rigidity.norm_charSum_le_weil`: the standard three and `StandingFive.kloosterman_bound`.

**The scan's two refutation-skips, read.** `Collapse.shift_mem_Xk` and `Collapse.rot_mem_Xk` conclude `… ∈ Xk F k`, which the
reducing telescope unfolds through `Xk`'s definition to `c x ≠ c y`, so the scan counts them as refutations: they refute
nothing (closure of the proper colourings under translation and rotation). What the skip hides is their binders'
audit; their one structure carrier, `c ∈ Xk F k`, is inhabited at `F = ℚ`, `k = 2` (`nonempty_invColouring_bot`'s colouring).

**The structure hypotheses, by hand** (the scan adds no site: its tracked carriers do not occur). Each with its model and grade:

| hypothesis | where taken | model, and grade |
|---|---|---|
| `P : StablePrime F` | `Collapse/Thick`, `Headline` | at `ℚ`, `UpperHalf.exists_stablePrime_rat` (kernel, standard three); with `2 ∉ P` and `|𝓞/P| = Q²` (`thickAt_weil`): at `ℚ(√3)`, `Q = 3` (`CertLink.exists_stablePrime_sqrt_three`, kernel, on Weil's bound); for every stable prime at once (`thick_of_card`): at `ℚ(√635087)` (`stablePrime_sqrt635087`) and de Grey's field (`stablePrime_deGrey`), kernel, standard three *(corrected after this stage's commit `e04c74b52`: its first text said no theorem exhibits such a prime; `exists_stablePrime_sqrt_three` does)* |
| `ThickAt P c`, `Thick F c` | `Thick`, `Mixing`, `Selection`, `Headline` | `ThickAt P 1` at every `P` (`thickAt_one`, kernel, standard three); `Thick F c` at `c < 1/5` at `ℚ(√635087)` and de Grey's field (`thick_sqrt635087`, `thick_deGrey`, kernel, on Weil's bound); empty at `ℚ` for `c < 1` (`not_thick_bot`, kernel, standard three) |
| `μ : InvColouring F k` | `Colouring`, `Dichotomy`, `Slice` | at `ℚ`, `k = 2` (`nonempty_invColouring_bot`, kernel, standard three); from any proper `k`-colouring of `F²` (`nonempty_invColouring_of_colorable`); empty at `k = 1` (`Xk_one_eq_empty`) |
| `IsColourSpectral μ.μ σ` | `Dichotomy`, `Slice` | for every `μ` (`exists_isColourSpectral`, kernel, standard three) |
| `σ (TA F)ᶜ = 0` | `Slice` | supplied by `exists_invColouring_TA` for every `F` with an invariant colouring (kernel, on E–L) — at `ℚ`, `k = 2` |
| `Measurable φ ∧ SliceEdgeNullK F φ` | `Selection` | from any proper `k`-colouring of `F²` (`exists_slice_of_colorable`, kernel, on E–L): at `ℚ`, `k = 2`; at `ℚ(√635087)`, `k = 7` |
| thickness with `c(k − 1) < 1` (or the window `c/(1 + c) < θ₀ < 1/k`) and a `k`-colouring (or a slice `k`-colouring), at once | `chromaticNumber_plane_le_of_thick`, `unitPairsNull_selCol`, `exists_aeColouring_of_slice` | **no object of the library**: at `k ≤ 5` empty given `Outside.OAI158.no_proper_five_coloring`; at `k = 6` (`ℚ(√635087)`) the joint satisfiability is `χ(ℝ²) ≤ 6`, the open question; at `k = 7` satisfiable in mathematics by any field all of whose stable residue sizes are `Q²` with `Q ≥ 142` (Weil's constant below `1/6`), none stated here. Said so in the Models paragraphs of `Collapse/Selection` and `Collapse/Headline` (edited at `54921b69e`: docstrings only, `code_only_diff.py` SAME), with the model `ℚ(√635087)` at `k = 7` named and the hypothesis it fails (`c(k − 1) < 1`) |

**Negative controls watched red in this job**: the quotation checker's plant; the residue exhaustion's plant; the code-only diff's
plant; the map check's plant (a wrong imports cell); the comparator's four plants; the audit block's three plants and the
coverage check against the pre-filing copy; the audit's two state controls and the assumptions step's 22 rows, each red for its
named cause before its input moved; and lint, red for a real finding before the ruling. Each self-test plants its own (15, 23,
65, 33 controls). **Not run: a lint plant** — the lint step is the driver over the whole library, its control watched at
FS131-LGT1, and `main`'s last pass ran none either; here lint's red was seen on a real finding.

## Stage 8 — SAVED: the read-aloud, against `LEDGER.md` row 128

The stored statements as the gated build prints them (`data/fs131/ico2/lean/ReadAloud.lean`, `pp.fullNames`;
`gate/read-aloud.txt`), with the definitions they name:
`Collapse.F635087 := SquareClass.fieldOfRadicands {635087}` and `Collapse.FdG := SquareClass.fieldOfRadicands {3, 5, 7, 11}`
(reducible; `fieldOfRadicands D` is `Subfield.closure` of the `√d`, `d ∈ D`, in `ℝ`); `planeOver F := {z : ℂ | z.re ∈ F ∧
z.im ∈ F}`; `unitDistance V` the graph with `Adj x y ↔ dist x y = 1`; `SimpleGraph.chromaticNumber`, Mathlib's, valued in
`ℕ∞`; `StablePrime F` a maximal ideal of `𝓞 F(i)` fixed by conjugation; `ThickAt P c := ∀ m ≥ 1, ∀ ψ` non-trivial additive
character of `𝓞 F(i) ⧸ P^m`, `‖Σ_{s ∈ normOneQ P m} ψ s‖ ≤ c · #normOneQ P m`; `Thick F c := ∀ P : StablePrime F, ThickAt P c`.

**`Collapse.chromaticNumber_planeOver_sqrt635087 : (SimpleGraph.induce (planeOver F635087) (unitDistance ℂ)).chromaticNumber =
(unitDistance ℂ).chromaticNumber`.** Read: the unit-distance graph on the points of the plane both of whose coordinates lie in
`ℚ(√635087)` — `F²` — has the same chromatic number, in `ℕ∞`, as the unit-distance graph of the whole plane `ℂ ≅ ℝ²`. No
hypothesis. Against row 128: its first member, `χ(F²) = χ(ℝ²)`, at its first instance, **with no MR hypothesis** (the row's
"given MR" is `Rigidity.mrPlus`, a theorem on `[EinsiedlerLindenstrauss2022]` Thm 1.3) and no hypothesis of ours; it rests on
that theorem and Weil's bound. The row's number for the instance, `sup_v λ*_v = 0.192617` exact, is the exact spectral value; the
kernel uses Weil's upper bound instead, `2√Q/(Q + 1) ≤ 2√103/104 = 0.19517…` at every stable prime (every one lies over a prime
`p ≡ 3 (mod 4)`, `p ≥ 103`, matching the row's "first stable place 103"): weaker than the row's number, below `1/5`, which is
all the proof needs. Not stated: the row's third member `χ_CP(ℝ²)` (row 130's; the library holds `χ(ℝ²) = χ_m⁰(ℝ²)` as
`Outside.OAI158.chromaticNumber_plane_eq_chiM0`, so `χ(ℚ(√635087)²) = χ_m⁰(ℝ²)` is a one-line composition, not stored).

**`Collapse.chromaticNumber_planeOver_eq_plane_of_thick : ∀ {F : Subfield ℝ} [NumberField ↥F] {c : ℝ}, Thick F c → 0 ≤ c →
c < 1/5 → (SimpleGraph.induce (planeOver F) (unitDistance ℂ)).chromaticNumber = (unitDistance ℂ).chromaticNumber`.** Read: for
every subfield of `ℝ` that is a number field (a real number field, as the library takes one), if one constant `c` in `[0, 1/5)`
bounds, at every stable prime and every level, every non-trivial character's sum over the norm-one residues by `c` times their
number, then `χ(F²) = χ(ℝ²)`. Against row 128's hypothesis — "every totally real number field `F` whose stable places are all
6-thick (`λ*_v < 1/5` at every level, both signs)": the character sum over the norm-one residues, normalised by their number, is
the residue target's normalised eigenvalue, and the modulus is "both signs"; the row's per-place form ("each place below
`1/5`") is `chromaticNumber_planeOver_eq_plane_of_forall_thickAt` (`∀ P, ∃ c < 1/5, ThickAt P c`), proved from the uniform form
through Weil's bound at the large primes. **Wider than the row in two ways**, both read in the stored type: no
`[NumberField.IsTotallyReal F]` binder, and no MR hypothesis and no exception scope (the row's "`N₆(F) = ∅`, which puts `F` outside
row 100's exception": MR⁺ holds at every real number field in the kernel). The mutation the planner read (§ 4.1): with `c < 1/4`
the statement would claim what the derivation does not give at six colours; the proof uses `5c < 1` at `k = 6`.

**`Collapse.chromaticNumber_planeOver_deGrey : (SimpleGraph.induce (planeOver FdG) (unitDistance ℂ)).chromaticNumber =
(unitDistance ℂ).chromaticNumber`.** Read: the same for `ℚ(√3, √5, √7, √11)`, the field of de Grey's coordinates. No hypothesis.
Against row 128's second instance: every stable prime lies over `p ≡ 3 (mod 4)`, `p ≥ 131` (the row's "first stable places over
131"), and Weil's bound `2√131/132 = 0.1734…` stands in for the row's exact `0.168047`; the row's "MR at degree 16 walked at
FS-105, one checking reading" is discharged — MR⁺ is the kernel's at every degree.

**`Collapse.chromaticNumber_planeOver_sqrt635087_six_or_seven : 6 ≤ χ(ℚ(√635087)²) ∧ χ(ℚ(√635087)²) ≤ 7`** (written out as the
first). Against the row's "Consequences, given MR: rung D is six over ℚ(√635087)" read with its `[OAIMath2026]` paragraph
("`χ(ℚ(√635087)²) = χ(F_dG²) ∈ {6, 7}`"): the first half of that, on the import `no_proper_five_coloring` in place of "given
MR" (de Grey's field's is the same composition, not stored).

**Not claimed by any of them**: a value of `χ(ℝ²)`; the row's `χ_CP` member; the row's other consequences (the triangle-free
reading, S_nf). The row's load-bearing step — "a `k`-colouring of `F²` gives a CP `k`-colouring of `UD(ℝ²)` or an SP witness",
the colour count entering at `max_j m_j ≥ 1/k` — is `chromaticNumber_plane_le_of_thick` in the library's format: a measurable
`k`-colouring proper at almost every unit pair (`AeColouring k`, the `χ_m⁰` object) with a fixed threshold, the SP witness
excluded by MR⁺ inside it, and the pigeonhole at `le_fibreMass_selCol`.

## Stage 9 — SAVED: the drafts

## Drafts for the front page

*Each draft names its slot: the file, the section, and the words it replaces or follows. Every quoted slot text was checked to
occur exactly once in its file in this tree (`main` merged at `ac830b568`). Counts are this job's gate's
(`data/fs131/ico2/gate/`, `7c72b9bf7`, stage 7). Keryx files; this job edits none of these files.*

### D1 — `CLAUDE.md` § Trust ledger, the audit's sentence

**Slot:** "the current audit reads 10651 clean and 5 declared purchases, and 62 imported (and 569 axiom-free; 11,287 records at
FS131-IL5, the main clause through five as one theorem, 2026-10-16)" → "the current audit reads 10747 clean and 5 declared
purchases, and 77 imported (and 569 axiom-free; 11,398 records at FS131-ICO2, the collapse, 2026-10-16)".

**Slot, same paragraph:** "with forty-eight imported records (twelve of them the three-colour criterion's and row 99's, FS131-LJ1;
twenty-six the five-colour chain's, FS131-LGT1; two the main clause's through five as one theorem, FS131-IL5)" → "with fifty-eight
imported records (twelve of them the three-colour criterion's and row 99's, FS131-LJ1; twenty-six the five-colour chain's,
FS131-LGT1; two the main clause's through five as one theorem, FS131-IL5; ten the collapse's, FS131-ICO2: the thickness of
ℚ(√635087) and de Grey's field, the two instances, the per-place form, the six-or-seven corollary, and D-E2's
`Rigidity.norm_charSum_le_weil`)".

**Slot, same paragraph:** "`Outside.OAI158.no_proper_five_coloring` — no map `ℂ → Fin 5` separates every unit pair — with six;" →
"`Outside.OAI158.no_proper_five_coloring` — no map `ℂ → Fin 5` separates every unit pair — with seven (the seventh the collapse's
`Collapse.chromaticNumber_planeOver_sqrt635087_six_or_seven`);".

**Slot, same paragraph:** "— with eighteen, ten of which rest on Weil's bound too (the five-colour chain's headline
`Rigidity.min_localBound_five_le_chromaticNumber`, `χ(ℚ(√47)²) = 5` and M15's other values, and `χ(F²) = L(F)` at `L(F) ≤ 5` with
its `min` form, `Rigidity/MainClauseFive`); no record rests on the five-colour theorem and another import," → "— with
twenty-seven, fourteen of which rest on Weil's bound too (the five-colour chain's headline
`Rigidity.min_localBound_five_le_chromaticNumber`, `χ(ℚ(√47)²) = 5` and M15's other values, `χ(F²) = L(F)` at `L(F) ≤ 5` with its
`min` form, `Rigidity/MainClauseFive`, and the collapse at ℚ(√635087) and de Grey's field, its per-place form and its six-or-seven
corollary, `Collapse/Headline`; the collapse's general form `Collapse.chromaticNumber_planeOver_eq_plane_of_thick` rests on it
alone); one record rests on the five-colour theorem and another import, the collapse's six-or-seven corollary, on all three,".

### D2 — `CLAUDE.md` § Trust ledger, the assumptions sentence

**Slot:** "`axioms=3 rests=78 named=19 inline=14 outside=7 ours=21 open=5 takes=108 mentions=2` — three outside theorems declared as
axioms, with seventy-eight (axiom, theorem) rows resting on them, sixty-eight theorems, ten of them on two;" → "`axioms=3 rests=99
named=19 inline=14 outside=7 ours=21 open=5 takes=109 mentions=2` — three outside theorems declared as axioms, with ninety-nine
(axiom, theorem) rows resting on them, eighty-four theorems, thirteen of them on two and one on three;". **And** in the same
sentence "taken in 108 (hypothesis, statement) pairs by 55 statements" → "taken in 109 (hypothesis, statement) pairs by 56
statements" (the new pair: D-E1's `StandingFive.norm_normOne_charSum_le` takes `KloostermanBound`, as its sibling
`normOne_charSum_ge` does). *(The theorem counts are mine, from the step's per-axiom counts — `no_proper_five_coloring` 7,
`positive_entropy_rigidity` 27, `kloosterman_bound` 65, so 99 memberships — over 84 theorems: 70 on one, 13 on two, 1 on three
(the sentence's old 68 and 10, plus this landing's 16 theorems: 5 on E–L alone, 7 on Weil's bound alone, 3 on both, 1 on all
three). The step prints the rows, not the theorems; Keryx may prefer to drop them.)*

### D3 — `CLAUDE.md` § The gate, the vacuity counts

**Slot:** "`declarations=22241 refutations-skipped=240 sites=1455`" → "`declarations=22357 refutations-skipped=242 sites=1455`"
(the second backticked group unchanged). The two new refutation-skips are `Collapse.shift_mem_Xk` and `rot_mem_Xk`, which refute
nothing (stage 7).

### D4 — `CLAUDE.md` § Frontier, the "Last filed" line

**Slot:** from "Last filed: **the main clause through five as one theorem** (FS131-IL5, 2026-10-16:" through "the upper half prior
art, the lower half this project's derivation);" → "Last filed: **the collapse** (FS131-KCL1, FS131-ICO1, FS131-ICO2,
2026-10-16: seven `Collapse/` modules through the gate on `7c72b9bf7` — `χ(F²) = χ(ℝ²)` at every real number field whose stable
primes are uniformly `c`-thick with `c < 1/5`, totally real or not (`Collapse.chromaticNumber_planeOver_eq_plane_of_thick`, on
`[EinsiedlerLindenstrauss2022]` Thm 1.3 alone), `χ(ℚ(√635087)²) = χ(ℝ²)` and `χ(ℚ(√3,√5,√7,√11)²) = χ(ℝ²)` with no hypothesis
(on it and Weil's bound), and with `[OAIMath2026]`'s import `6 ≤ χ(ℚ(√635087)²) ≤ 7`; row 128's field clause, its MR the kernel's
`Rigidity.mrPlus`; the field equality prior art: not found in print, the plane equality `[OAIMath2026]`'s; no value of `χ(ℝ²)`
moved);" — the IL5 text going to `plans/FILINGS.md` as the filings' rule has it.

### D5 — `CLAUDE.md` § Where the problem stands, "What the kernel holds"

**Slot: after** "the derivation is this project's, and the kernel's check is this landing's;" (the main clause through five's
entry), **before** "**Theorems A and B**": insert "**the collapse** (FS-131, FS131-ICO2): `χ(F²) = χ(ℝ²)` at every real number
field whose stable primes are uniformly `c`-thick, `c < 1/5` — every non-trivial character of every level of every
conjugation-fixed prime of `F(i)` summing over the norm-one residues to at most `c` times their number — totally real or not
(`Collapse.chromaticNumber_planeOver_eq_plane_of_thick`, on `[EinsiedlerLindenstrauss2022]` Thm 1.3 alone; its per-place form
`…_of_forall_thickAt` on Weil's bound too); `χ(ℚ(√635087)²) = χ(ℝ²)` and `χ(ℚ(√3,√5,√7,√11)²) = χ(ℝ²)` with no hypothesis,
thickness by Weil's bound above 103 and 131 (`Collapse.chromaticNumber_planeOver_sqrt635087`, `…_deGrey`), and `6 ≤
χ(ℚ(√635087)²) ≤ 7` with `Outside.OAI158.no_proper_five_coloring` (`…_sqrt635087_six_or_seven`) — row 128's field clause, wider
than the row (no total reality; no MR hypothesis); the field equality prior art: not found in print (row 128), the plane equality
`[OAIMath2026]`'s; the derivation FS-103's, the kernel's check this landing's;".

### D6 — `CLAUDE.md` § Where the problem stands, the plane's number

**Slot:** "**The plane's number is a measurable one with no hypothesis, and given MR a field's**" → "**The plane's number is a
measurable one with no hypothesis, and a field's**". **Slot, same paragraph:** "and given MR(ℚ(√635087)) it is `χ(ℚ(√635087)²)`
(row 128; [hand], two blind minds)" → "and it is `χ(ℚ(√635087)²)` with no hypothesis (`Collapse.chromaticNumber_planeOver_sqrt635087`,
on `[EinsiedlerLindenstrauss2022]` Thm 1.3 and Weil's bound; row 128, in the kernel since FS131-ICO2)".

### D7 — `CLAUDE.md` § The aim, link 1 (the planner's § 4.7 draft, brought to what is proved)

**Slot:** "Given MR at a number field (row 120) it also equals `χ(F²)` at each totally real field where every stable place mixes at
six colours, ℚ(√635087) and de Grey's field among them (row 128; [hand, two minds])." → "It also equals `χ(F²)` at every real
number field whose stable places all mix at six colours, ℚ(√635087) and de Grey's field among them — in the kernel since
FS131-ICO2, on `[EinsiedlerLindenstrauss2022]` Thm 1.3 and, at the two fields, Weil's bound (row 128;
`Collapse.chromaticNumber_planeOver_eq_plane_of_thick`)."

### D8 — `CLAUDE.md` § The local–global conjecture, and the theory paragraph

**Slot (the conjecture):** "seven at ℚ(√635087) is `χ(ℝ²) = 7` given MR (row 128)" → "seven at ℚ(√635087) is `χ(ℝ²) = 7` (row 128;
the equality `χ(ℚ(√635087)²) = χ(ℝ²)` in the kernel since FS131-ICO2)". **Slot (§ Grokkings' theory in one paragraph):** "and given
MR χ(F²) = χ(ℝ²), the least k with a measurable k-colouring proper at almost every unit pair" → "and χ(F²) = χ(ℝ²), the least k with
a measurable k-colouring proper at almost every unit pair" — and in the parenthesis after it, "(rows 128, 130, G81; [hand])" →
"(rows 128, 130, G81; the field equality [kernel] since FS131-ICO2, on `[EinsiedlerLindenstrauss2022]` Thm 1.3)". *(Whether the
grokkings file's G81 entry says "given MR" too is Keryx's to read; this job did not open the grokkings.)*

### D9 — `LEDGER.md` row 128, regraded

**Slot 1, the head:** "**The collapse: given MR, the plane's number is a field's." → "**The collapse: the plane's number is a
field's.". **Slot 2, the grade bracket:** "**[hand + tools exact; the load-bearing step two derivations blind to each other and to
J39's and J48's proofs (V1; V2) — four derivations with the two held; the assemblies two blind; place lists and spectra tools
exact, three code bases; MR row 120's grade; the complex-place widening one mind (V2), not claimed]**" → "**[kernel since FS131-ICO2
for the field clause (`Proofs/HadwigerNelson/Collapse/`, the gate on `7c72b9bf7`): at every real number field uniformly `c`-thick
with `c < 1/5`, totally real or not, `Collapse.chromaticNumber_planeOver_eq_plane_of_thick`, on
`Rigidity.positive_entropy_rigidity` (`[EinsiedlerLindenstrauss2022]` Thm 1.3) — MR is `Rigidity.mrPlus` there — and the
standard three; at ℚ(√635087) and de Grey's field with no hypothesis, `Collapse.chromaticNumber_planeOver_sqrt635087`,
`Collapse.chromaticNumber_planeOver_deGrey`, also on `StandingFive.kloosterman_bound` (`[Weil1948]`), which gives the kernel's
thickness, `2√103/104` and `2√131/132`, in place of the row's exact spectra; the per-place form
`Collapse.chromaticNumber_planeOver_eq_plane_of_forall_thickAt` on both; with `Outside.OAI158.no_proper_five_coloring`,
`6 ≤ χ(ℚ(√635087)²) ≤ 7`, `Collapse.chromaticNumber_planeOver_sqrt635087_six_or_seven`. Still [hand + tools exact], as graded
before: the `χ_CP` member (row 130), the consequences past `{6, 7}`, the exact spectra and place lists]**". **Slot 3:** "**Not
claimed:** the complex-place widening; anything at six." → "**Not claimed:** anything at six. The complex-place widening is held
in the kernel's form: the general theorem takes no total reality.". **Slot 4, the addresses cell:** after
"`plans/FS105-derivation.md` FS105-MR16" add "; `Proofs/HadwigerNelson/Collapse/` (FS131-KCL1, FS131-ICO1, FS131-ICO2)".

**Row 120** (its "Not claimed: MR at row 100's exception fields (ℚ(√5), ℚ(√17), ℚ(α)), where the adelic model needs `R = O′`"):
predates `Rigidity.mrPlus`, which the collapse reads at every real number field, exception fields included. This is FS131-PR1's
owed correction "row 120's grade" (inventory item 951), seen a third time; no new slot.

### D10 — `README.md` § Results, Planes over number fields

**Slot: after** the row whose first cell begins "`χ(ℚ(√47)²) = 5`. Also `χ = 5` over ℚ(√143)", **insert**:

> | `χ(F²) = χ(ℝ²)` for every real number field whose stable primes are uniformly `c`-thick with `c < 1/5`: for one `c` and every prime ideal of `F(i)` that conjugation maps to itself, every non-trivial additive character of every `𝓞/Pᵐ` sums over the elements of norm one to at most `c` times their number. So `χ(ℚ(√635087)²) = χ(ℝ²)` and `χ(ℚ(√3, √5, √7, √11)²) = χ(ℝ²)`, and with **O5**, `6 ≤ χ(ℚ(√635087)²) ≤ 7`. | `Collapse.chromaticNumber_planeOver_eq_plane_of_thick`, `Collapse.chromaticNumber_planeOver_sqrt635087`, `Collapse.chromaticNumber_planeOver_deGrey`, `Collapse.chromaticNumber_planeOver_sqrt635087_six_or_seven` | std3 + **EL** (the general form); + **W** (the two fields); + **O5** (the corollary) | the derivation is this project's; the field equality: prior art not found in print. The plane's number it is equated with is `[OAIMath2026]`'s `χ_m⁰`; in dimension at least four the analogue is `[Davies2026]` Thm 1.1 | 128 |

**And the section's header sentence:** "The axiom lists are exactly what `#print axioms` printed on 2026-10-15 from the library as
gated at commit `752b11569`" holds for every other row; the new row's lists are this job's receipt (`7c72b9bf7`, 2026-10-16) —
Keryx's choice of wording.

### D11 — `ROADMAP.md`

**§ 1, item 3** ("**Row 128, the collapse.** For a totally real field whose stable places all "mix" at six colours … has not been
checked here (`LEDGER.md` row 128; `Rigidity/ZeroEntropyClosed.lean`)."): delete it — the form of MR row 128's proof uses is
`Rigidity.mrPlus` (checked: the planner's stage 2, and in the kernel since this landing) — and renumber items 4–6 to 3–5 (I have
not checked whether any file cites § 1's items by number). Row 128 stays in item 6's group A for its parts still [hand].

**§ 2, item 1 (O5):** "Six records rest on it, among them `6 ≤ χ(ℝ²) ≤ 7` and `6 ≤ χ_m⁰(ℝ²)`." → "Seven records rest on it, among
them `6 ≤ χ(ℝ²) ≤ 7`, `6 ≤ χ_m⁰(ℝ²)` and `6 ≤ χ(ℚ(√635087)²) ≤ 7`." **Item 2 (EL):** "Eighteen records rest on it, among them the
five-colour chain `min(L(F), 5) ≤ χ(F²)`, `χ(F²) = L(F)` whenever `L(F) ≤ 5`, and `χ(ℚ(√47)²) = 5`." → "Twenty-seven records rest
on it, among them the five-colour chain `min(L(F), 5) ≤ χ(F²)`, `χ(F²) = L(F)` whenever `L(F) ≤ 5`, `χ(ℚ(√47)²) = 5`, and the
collapse `χ(F²) = χ(ℝ²)` at every uniformly thick real number field." **Item 3 (W):** "Forty-eight records rest on it:" →
"Fifty-eight records rest on it:", and in its sentence "and, with EL, the five-colour chain" → "and, with EL, the five-colour chain
and the collapse at ℚ(√635087) and de Grey's field".

### D12 — `ARCHITECTURE.md` § 5 (Trust), the consumer cells (outside this job's touches, so drafted)

**`Rigidity.positive_entropy_rigidity`'s row:** after "and the chain's headline `min_localBound_five_le_chromaticNumber`" add ";
and the collapse (`Collapse/`, FS131-ICO2): `chromaticNumber_planeOver_eq_plane_of_thick` and its instances". **`no_proper_five_coloring`'s
row:** "`Plane.radius_five` — six records" → "`Plane.radius_five`; and, of the collapse, `Collapse.chromaticNumber_planeOver_sqrt635087_six_or_seven`
— seven records". **`kloosterman_bound`'s row:** its "(twenty imported records in all)" has been stale since FS131-LGT1 (the audit
reads 58 now); a count, or "the principal consumers", is Keryx's choice.

### D13 — the Proof Atlas

Node `R128` ("the collapse", `tools/viz_proof_atlas_facts.py` l. 105; `data/viz/proof-atlas/facts.json`): its grade is read from
row 128's grade words, so D9 moves it to kernel for the field clause; its `plain` text "Given MR, at a totally real field whose
every stable place mixes at six colours (ℚ(√635087), de Grey's field), the field's plane, the real plane and the stationary random
colourings all need the same number of colours." → "At every real number field whose stable places all mix at six colours
(ℚ(√635087), de Grey's field), the field's plane and the real plane need the same number of colours — in the kernel, on EL (and W at
the two fields); the stationary random colourings' number is row 130's."; its quote, and the `MR → R128` edge's (l. 519), follow
D9's new head ("The collapse: the plane's number is a field's."), which the checker re-reads. `LEANWALL`'s quote (l. 159, "the
collapse (row 128)" among what Lean owes) is from `plans/STUB-regularity-wall.md`, whose text is the stub's writers'.
