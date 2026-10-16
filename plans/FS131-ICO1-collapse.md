# FS131-ICO1 — the collapse proved: the plane over ℚ(√635087) has the plane's chromatic number

*Implementer's record (de Bruijn, the implementer, on Opus 5.5). Brief: `data/fs131/briefs/FS131-ICO1-collapse.md` (on `main`
at `f1fcc683d`). Worktree `.claude/worktrees/kcl1`, branch `fs131-ico1`, cut at `2e28d8a07` (the planner's `fs131-kcl1` with
`main` merged in). The plan: `plans/FS131-KCL1-collapse-plan.md`. Scripts and logs under `data/fs131/ico1/`.*

## Theorems this phase proved

None at kernel grade yet: every leaf below is proved and compiled in a scratch farm (`data/fs131/ico1/lean1.sh`, the
lakefile's options), but the modules have not passed `./scripts/build.sh` since they were proved, and the gate has not run.
Proved in source, awaiting the build and the gate: `Collapse/Thick` (all 10 leaves), `Collapse/Mixing` (all 4),
`Collapse/Colouring` (all 6), `Collapse/Dichotomy` (all 8); the new public theorems `StandingFive.norm_normOne_charSum_le`
(`Arith/FloorPlanes`) and `Rigidity.norm_charSum_le_weil` (`Rigidity/ClassRatio`), which **have** passed the build
(`data/fs131/ico1/build1.log`, before any `Collapse/` leaf was proved). Open: `Collapse/Slice` (4), `Collapse/Selection` (8),
`Collapse/Headline` (8).

## Stage 1 — SAVED: the readback

**Quotations.** The planner's checker (`data/fs131/kcl1/quote_check.py`, read-only here) run on this brief against this
worktree: five quotations, all verbatim (`data/fs131/ico1/quote_check.out`) — W2 (`data/fs131/REQUEST-2026-10-13.md`), row 128
(`LEDGER.md`), and the three headline statements (`Proofs/HadwigerNelson/Collapse/Headline.lean`). Control: `--plant` changes one
letter of W2 and the checker reports it NOT FOUND at character 134 and exits 1 (`quote_check_plant.out`). Against the main tree the
first two are verbatim and the third source does not exist there (the skeleton is on this branch only), as expected. **No
mismatch.**

**The target, in my words.** Seven skeleton modules under `Proofs/HadwigerNelson/Collapse/` hold 48 `sorry` leaves. Every leaf is
to be proved, no statement changed, so that

- `Collapse.chromaticNumber_planeOver_sqrt635087`: the unit-distance graph of `ℂ` induced on `planeOver ℚ(√635087)` has the
  chromatic number of the unit-distance graph of `ℂ`;
- `Collapse.chromaticNumber_planeOver_eq_plane_of_thick`: the same at every real number field `F` (a `Subfield ℝ` with
  `NumberField F`) all of whose stable primes are uniformly `c`-thick, `0 ≤ c < 1/5`;
- `Collapse.chromaticNumber_planeOver_deGrey`: the same at `ℚ(√3, √5, √7, √11)`;

are kernel theorems on the standard three axioms, `Rigidity.positive_entropy_rigidity` and `StandingFive.kloosterman_bound`,
with no hypothesis of ours; the six-or-seven corollary adds `Outside.OAI158.no_proper_five_coloring`.

**The order of work** (the plan's § 4.4, with the brief's rulings): (1) `Collapse/Thick`, with the approved edits D-E1
(`Arith/FloorPlanes`) and D-E2 (`Rigidity/ClassRatio`) — measuring the rebuild they cost first — and `Collapse/Mixing`'s
`finite_mixing`: the new leaves that decide the price; (2) the copies `Colouring → Dichotomy → Slice`; (3) `tendsto_levelResid`,
`mixing_at_level`, `not_both_ge_of_mixing`, then `Collapse/Selection`; (4) `Collapse/Headline`; (5) the experience pass on the
headline names and docstrings, the gate on one commit, the read-aloud, the drafts.

**The statement baseline, taken before the first rebuild.** `lake build --no-build Proofs` under the slot: all targets
up to date (`uptodate0.log`), so the compiled library is the skeleton's. Every constant of the seven modules and of the two
edited ones, dumped from that build (`data/fs131/ico1/lean/StatementDump.lean`, FS131-IDG1's dumper with this job's module list;
`statements-before.txt.gz`, 331 constants).

## Stage 2 — SAVED: the edits D-E1, D-E2, and `Collapse/Thick`

**The edits, measured first, then made.** D-E1 adds `StandingFive.norm_normOne_charSum_le` (`Arith/FloorPlanes`): the body of
`normOne_charSum_ge` up to its last line, whose conclusion is now the two-sided `‖Σ‖ ≤ 2√Q`; `normOne_charSum_ge` becomes its
real part in one line. D-E2 adds `Rigidity.norm_charSum_le_weil` (`Rigidity/ClassRatio`, at the end of the file, after the private
`two_div_le_weil` it reads): `‖Σ_{x x̄ = 1} ψ‖ ≤ 2√Q/(Q + 1)·|S_m|` at every level `m ≥ 1` of a stable prime not above `2` with
`|𝓞 ⧸ P| = Q²`, stated over `CertLink.normOneSet P m` (the private `levelSet` cannot appear in a public statement, and
`Counting.normOneQ` is downstream). Inside: the private `charBound_one_weil` is split into `norm_charSum_one_weil` (its body, now
over D-E1) and its real part, and a private `norm_charSum_le_of_one` runs `charBound_of_charBound_oneT`'s induction with norms.
No stored statement of either module moves (checked at the gate's statement comparison). **The rebuild they cost**: the build
after both edits (`data/fs131/ico1/build1.log`; `SLOT_BUDGET_GB=22 … --mem 12 --cpus 6 -- env MEMMAX=12G BATCH=4`) rebuilt 25
modules in **17 m 16 s** — every dependent under 25 s (`ClassRatio` 22 s, `Floor128` 12 s); the walk is the cost. Far under
the brief's hour: the edits stand, the copy route is not taken.

**`Collapse/Thick`: every leaf proved** (iteration in a farm, `data/fs131/ico1/lean1.sh`: a symlink copy of the compiled
library with the module written over it, the lakefile's options passed; the build is the check, at the next build).
- `thickAt_one` (5 lines, `AddChar.norm_apply`); `thickAt_weil` (2 lines over D-E2); `weil_const_anti` (`(√Q − √B)(√B√Q − 1) ≥ 0`).
- `thick_of_forall_thickAt` as planned: `c₀ ≤ 0` is vacuous (a private `nonneg_of_thickAt`: a thickness constant is `≥ 0`, so
  no stable prime exists); otherwise `B = ⌈4/c₀²⌉ + 1` puts Weil's constant below `c₀`, and the primes of absolute norm at most
  `max(N(2), B²)` are `Counting.level F N` — a `Finset`, so the maximum of their constants is taken there. The private
  `exists_card_sq` of `ClassRatio` is copied as `exists_card_sq'` (15 lines) rather than made public.
- `not_isRamified_of_thickAt`: the library's own argument (`colorable_two_levelTarget_one_of_isRamified`): at level one the
  norm-one residues are `{1}`, and any non-trivial character has `‖ψ 1‖ = 1`.
- `exists_addChar_extend`: through Mathlib's `MonoidHom.restrict_surjective` (`Mathlib/GroupTheory/FiniteAbelian/Duality`)
  on `Multiplicative G` with values in `ℂˣ` — **two imports added to the module** (that file and
  `Mathlib.RingTheory.RootsOfUnity.AlgebraicallyClosed`, for `HasEnoughRootsOfUnity ℂ n`); whether they move a stored statement
  is read at the gate's comparison (LEAN.md: imports choose instances).
- `norm_sum_piFinset_le`: `ψ s = ∏ ψ(single i (s i))`, `Finset.prod_univ_sum`, one factor non-trivial. **Its hypothesis
  `0 ≤ c` is not read by the proof** (the factors' norms are non-negative by themselves); the statement keeps it, and the proof
  references it by `have _ := hc` (LEAN.md § The gate's lint line) — reported, not a defect.
- `image_levR_unitVectors_of_unramified`: the landed proof with `ratio_unramified_of_tca h P` replaced by `hun P`.
- `levelThick`: `0 ≤ c` from a stable prime of level `k` (a non-trivial character of the level group needs one); the
  character extended to `Lev F k`; the connection set matched to `Fintype.piFinset` by `Finset.sum_nbij`/`card_nbij`.
- `levU_nonempty`: `1`.
- The `unusedSectionVars` warning at `ThickAt.mono` is fixed by `omit [NumberField F] in` (ruling 5).

**Re-price, first kind (a new leaf).** `Collapse/Thick` plus the two edits: about 360 lines of proof against the plan's 550
(410 + 140), in about 40 minutes of work, every leaf closed on its first or second compile.

## Stage 3 — SAVED: `Collapse/Mixing`

Every leaf proved (farm iteration; the build at the next build). About 630 lines against the plan's 570.
- `finite_mixing` (**re-price, second new leaf**): Fourier on the finite group with a private coefficient `fhat f ψ = Σ_x f(x)ψ(x)`;
  the edge identity `Σ_ψ f̂ conj ĝ λ_ψ = |G|·Σ_x f(x) Σ_s g(x + s)` and Parseval (the identity at `S = {0}`), the trivial
  character split off (`Finset.add_sum_erase`), `|λ_ψ| ≤ c|S|`, Cauchy–Schwarz (`Real.sum_mul_le_sqrt_mul_sqrt`) and
  `Σ_{ψ≠1}|f̂|² = |G|Σf² − (a|G|)² ≤ |G|²a(1 − a)`. 150 lines with its helpers; two compiles.
- The level machinery, as private helpers on the finite partition of `K` into the cosets over the level group `LevImg F k`
  (indexed by a `Fintype` instance taken as an argument): `integral_eq_sum_cosets` (`integral_iUnion_fintype`), the coset
  measure `1/N` (`haarK_proj_preimage`), `fillAt` with `levelFill F A k x = fillAt A k (proj x)` by `rfl`, measurability of the
  fill from continuity into the discrete level (`continuous_of_discreteTopology`), the residual integrating to `0` on every
  coset, and the closed form **`levelResid A k = Σ_g |C_g|·α_g(1 − α_g)`** — sharper than the plan's `≤ 2∫_A(1 − fill)`.
- `tendsto_levelResid`: the closed form is at most `|bad_k| + κ` (cosets with `α_g ≤ 1 − κ` contribute at most `|A ∩ C_g|`,
  the others at most `κ|C_g|`), and `Counting.tendsto_haarK_bad` at `κ = ε/2`.
- `mixing_at_level`: a private `edge_split` (the edge integral at a translation over `s` = `(1/N)Σ_g α_g β_{g+s}` + the
  residuals' product; the two cross terms vanish coset by coset, the translation `x ↦ x + t` carrying the coset over `g` to
  the one over `g + s` by `MeasurePreserving.setIntegral_preimage_emb`); Cauchy–Schwarz for integrals as a private
  `abs_integral_mul_le` (Hölder at `p = q = 2`, `integral_mul_le_Lp_mul_Lq_of_nonneg`); a unit vector chosen over each point
  of `levU` (`image_levR_unitVectors_of_unramified`); then `finite_mixing` on `LevImg F k` with `levelThick`.
- `not_both_ge_of_mixing`: squared, `ab ≤ c²(1 − a)(1 − b)` against `c(1 − a) < a`, `c(1 − b) < b`.

**Re-price after two kinds of new leaf** (Thick, Mixing): 990 lines against the plan's 1,120 for these, every leaf closed in at
most five compiles. The copies (`Colouring → Dichotomy → Slice`) come next; then `Selection`, `Headline`.

## Stage 4 — SAVED: `Collapse/Colouring` and `Collapse/Dichotomy` (the first copies)

Every leaf proved (farm iteration). **Re-price, the copy kind:** `Colouring` 215 lines of proof against the plan's 260;
`Dichotomy` about 610 against 1,000 — each leaf a copy of its four-colour namesake at `Fin k`, closed in at most three
compiles. The colour spectral measure (record § 3.2, decision 2) is what made the copies shorter: no tetrahedral identity, and
one private `colour_decomp` (`σ = Σ_j σ_{e_j}` by Fourier uniqueness, for any random colouring moved equivariantly at `0`)
serves both SI-3 and the factor law's spectrum.
- `Colouring`: `xk_nonempty_of_colorable`, `isClosed_Xk`, `measurableSet_Xk`, `rot_mem_Xk` as `SpectralChain`'s; the
  invariant measure as `Rigidity/InvariantMeasure`'s two steps at `Fin k` (private copies; that module's statements are at
  `Fin 4`); `Xk_one_eq_empty` (`0, 1` adjacent).
- `Dichotomy`: private `colourIndK`, `integral_colourIndK_mul_comp`, `measureReal_eq_sum_colours`, `colour_decomp`; the SI-4
  block of `Arith/SpectralInputs` at `Fin k` (`condSupportK`, `si4K`, `si4_equivariantK`, with the generic
  `condExp_comp_measurePreserving` read as it is); `TraceSplit`'s conditional-law lemmas at `Fin k`; `APlus`'s rotation of the
  factor and its factor colouring at `Fin k` (`minSelK` needs `NeZero k`: `exists_factorLawK` disposes of `k = 0` first — no
  probability on the empty `R → Fin 0`). `IsColourSpectral.rotInv` directly by Fourier uniqueness (`P(c(0) = c(uy)) =
  P(c(0) = c(y))` from `rot_inv`), with no Herglotz–Bochner uniqueness clause.
- `attribute [local instance] InvColouring.isProb` in the module (the four-colour modules' `scoped` form, local here).

## Stage 5 — SAVED: hand-back at the brief's budget line, with what is left

**Why here.** The coordinator's word of this session: hand back at a saved stage once past about 550k by the harness's count;
this session is past it. Nothing is lost: stages 1–4 are committed, and the worktree holds nothing else of this job (the farm
copies under `data/fs131/ico1/work/` were byte-identical to the committed modules and are deleted; the uncompressed baseline
dump is deleted, its `.gz` is committed). No slot is held; no process of this job is running.

**A correction to stage 4's numbers.** `Collapse/Colouring` is about 137 lines of proof (240 − 103), not 215.

**A finding about ruling 5 (for the coordinator, before the landing).** The brief's ruling 5 and the plan (§ 4.8) say the
`omit [NumberField ↥F] in` line at `Collapse.ThickAt.mono` moves no statement, "the binder is not in the stored type". The
baseline dump of the skeleton's compiled module says otherwise: the stored type of `ThickAt.mono` begins
`forall {F : Subfield ℝ} [inst… : NumberField ↥F] …` (`statements-before.txt.gz`; the auto-included instance is exactly what
the `unusedSectionVars` warning reports). The omit, committed at stage 2 as ruled, therefore **drops one instance binder** —
the theorem becomes more general (a strengthening, never a weakening), but its stored statement moves. Two ways to settle it:
keep the omit and show the drop from the kernel's side at the gate (LEAN.md § Searching — Lean, the one-binder check of
FS131-KN9), or replace it by `set_option linter.unusedSectionVars false in` (LEAN.md, FS131-ITK1), which keeps the stored type.
The successor should follow the coordinator's choice, and use `set_option linter.unusedSectionVars false in` rather than
`omit` for any other leaf that turns out not to read `[NumberField F]` (in `Collapse/Slice`, `measure_ne_eq_k` will not — its
four-colour namesake carries `omit [NumberField F] in` there because the namesake's statement was written so).

**What is left, in order** (the plan's § 4.3 for each leaf; what this job learned, below):
1. `Collapse/Slice` — `Rigidity/CountExtension` at `Fin k`, read in full this session. `measure_ne_eq_k`: `hσ.2 y` gives
   `∫ χ(y) dσ = P(c(0) = c(y))`, and `P(c(0) ≠ c(y)) = 1 − P(c(0) = c(y))` (probability, `measure_compl` on
   `measurableSet_eq_fun`). `tendsto_measure_ne_k`: the landed proof with `σ(R̂) = 1` from `hσ.2 0` (`{c | c 0 = c 0} = univ`)
   and `Re ∫ χ(y) dσ → 1` in place of the correlation. `exists_extension_k`, `exists_slice_k`: the landed proofs at `Fin k`,
   `measure_ne_shift` and `measure_eq_add_unit` copied privately with `Xk`. The module needs
   `attribute [local instance] InvColouring.isProb` (as `Collapse/Dichotomy` has it) or `haveI := μ.isProb`.
2. `Collapse/Selection` (8 leaves, plan § 4.3) — reads `Collapse.mixing_K` and `not_both_ge_of_mixing`, both proved.
3. `Collapse/Headline` (8 leaves, plan § 4.3), then the experience pass on the headline names and docstrings (ruling 6).
4. **The build**: `./scripts/build.sh` under the slot (the brief's line). It has not yet compiled the four proved `Collapse/`
   modules; expect the walk of about 17 minutes and every `Collapse/` module recompiled.
5. Merge `main` (it gained `Rigidity/MainClauseFive`, FS131-IL5), then the gate on one commit
   (`data/fs131/clone1/run-gate.sh` copied under `data/fs131/ico1/`), with the statement comparison against
   `statements-before.txt.gz` (`data/fs131/ico1/lean/StatementDump.lean`, run before and after): it must show (a)
   `normOne_charSum_ge`, every `ClassRatio` statement and every skeleton statement unchanged, (b) the two new public theorems,
   (c) the `ThickAt.mono` binder as settled above, and (d) whether `Collapse/Thick`'s two added Mathlib imports
   (`Mathlib.GroupTheory.FiniteAbelian.Duality`, `Mathlib.RingTheory.RootsOfUnity.AlgebraicallyClosed`, for
   `exists_addChar_extend`) moved any stored instance term — LEAN.md: imports choose instances.
6. The read-aloud of the three headlines against row 128, the front-page drafts (plan § 4.7, brought to what is proved), the
   report.

**Re-price for the successor.** Four modules took about 1,540 lines of proof (Thick + edits 360, Mixing 630, Colouring 137,
Dichotomy 600) against the plan's 2,450 for them, every leaf closed within five farm compiles. Left by the plan: Slice 330,
Selection 310, Headline 250 — on this job's rate, about 600 lines, well within one successor's session.
