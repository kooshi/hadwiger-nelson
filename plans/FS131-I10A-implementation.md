# FS-131, wave 10 — implementation record: the spectral inputs and the character colouring's last leaf

*Job FS131-I10A (de Bruijn, the implementer), 2026-10-06, branch `fs131-w10` (from the planner's `f919973e`). Brief:
`data/fs131/briefs/FS131-I10A-wave10.md`. Plan: `plans/FS131-w10-kernel-plan.md` §§ 2, 3, 5.1, 5.2, 5.5.*

**What I may change, and what I may not.** Mine: the proof of each open leaf of `Proofs/HadwigerNelson/Arith/SpectralInputs.lean` (eight) and of
`mem_archimedean_unitRing_iff` in `Proofs/HadwigerNelson/Arith/CharacterColouring.lean`; new helper declarations in those two files, under names no
other module declares; a block "FS131-I10A" in `scripts/Axioms.lean`; this record; `tools/fs131_i10a_*.py`; `data/fs131/i10a/`; the report. Not mine: any
statement, hypothesis, conclusion or definition of the skeleton (a leaf that is false or too weak as stated goes to Keryx by message); a new `axiom`;
`native_decide`; the wave's other files (`StationaryRatio`, `StandingFive`); any landed module; `main`; the gate; another branch.

## Theorems this phase proved

**All nine leaves of the brief are proved; neither file has a `sorry`.** Kernel-checked on this branch by `./scripts/build.sh` under the slot
(`data/fs131/i10a/logs/build-3-all-leaves.log`, exit 0); axioms `[propext, Classical.choice, Quot.sound]` for each of the 33 records of the
"FS131-I10A" block of `scripts/Axioms.lean`, printed with a control that shows `sorryAx` (`data/fs131/i10a/logs/axioms-all.log`). The branch does not
run the gate, so the audit is the landing's. Every named hypothesis of the plan's § 5.5 is still a hypothesis: none was proved here.

`Proofs/HadwigerNelson/Arith/SpectralInputs.lean`, each [kernel on this branch], read against `plans/FS84-SI-D-derivation.md`:

- **`measurableSet_factorSigma_iff`** — J45-N2 (i). Lemma N2 (l. 126–135): "the sets whose indicators lie in `H_S` form a σ-algebra `𝒜_S`". Lean:
  for any family of measure-preserving maps and any filter, a set is `factorSigma`-measurable iff it is in `factorSets`.
- **`contVec_eq_lpMeas`** — J45-N2 (ii). Same lemma: "`H_S = L²(𝒜_S)`". Lean: `contVec T hT l` is the set of `factorSigma`-a.e.-strongly-measurable
  vectors of `L²(μ)`.
- **`measurableSet_preimage_factorSigma`** — J45-N2 (iii): "for a translation-invariant σ-algebra". Lean: when the maps commute, `T x ⁻¹' A` is
  `factorSigma`-measurable when `A` is.
- **`spectral_carried_iff`** — J45-N2, first sentence: "For `f ∈ L²(μ)`, `σ_f(R̂ ∖ E_S) = 0` iff `y ↦ V_y f` is `τ′_S`-continuous". Lean: for a
  first-countable group topology `t` with `BochnerOn t` (named hypothesis) and an additive action, a spectral measure of `f` is null off
  `contChars t` iff `f ∈ contVec T hT (𝓝 0)`.
- **`contChars_haar_null`** — J45-N1 (c), the Haar-null clause: "`E_S` is a proper dense subgroup of `R̂`, so `Haar(E_S) = 0`". Lean: given
  `BochnerHerglotz R` (named hypothesis), a measurable, point-separating, proper `contChars t` has `m (contChars t) = 0` for `IsHaarFourier m`.
- **`si4`** — J45-SI-4, verbatim "equality at every `u` ⟹ every selection from the supports is an `𝒜_S`-measurable equivariant proper
  four-colouring" (Lemma SI-4, l. 159–162). Lean: the selection is `𝒜`-measurable, a.s. proper across `adj`, and `c(x) ∈ M(x)` a.s.
- **`sp_if`** — J45-SP-if, verbatim "If some finite positive `U`-invariant `ν` with `ν(E) = 0` is not a multiple of Haar, then some finite positive
  `U`-invariant `τ` has `τ(E) = 0` and `∫ Re χ(1) dτ < 0`" (l. 299–310). Lean: over `BochnerHerglotz`, `Interface.MulStable`, `Interface.NegCircle`
  (named hypotheses).
- **`exists_isHaarFourier`** — not a row: `IsHaarFourier` is satisfiable given `BochnerHerglotz G`.
- **New statements, one mind (mine), owed the planner's read-back** — the children the plan asked the implementer to state:
  `condExpL2_mem_contVec`, `condExpL2_eq_self_iff`, `inner_sub_condExpL2_eq_zero` (J45-N2's "`Π(E_S) = E[·|𝒜_S]`": Mathlib's `condExpL2` for
  `factorSigma` takes values in `contVec`, fixes exactly `contVec`, and its residual is orthogonal to `contVec`); **`si4_equivariant`** (J45-SI-4's
  "translation-equivariant", "`M(x + y) = M(x) ∘ T_y`": for measure-preserving `S` with `𝒜.comap S = 𝒜` and `c (S ω) x = c ω (π x)`, a.s.
  `M(S ω)(x) = M(ω)(π x)` for every `x`), over `condExp_comp_measurePreserving` (`E[g|𝒜] ∘ S = E[g ∘ S|𝒜]` a.s.).
- Helpers of general use: `ext_of_fourier` (two finite measures on the characters with equal Fourier coefficients are equal, given
  `BochnerHerglotz`), `posDef_fourier`, `posDef_delta`, `IsHaarFourier.integral_eq`, `IsHaarFourier.map_mulRight` (Haar is translation-invariant),
  `mul_mem_contChars_iff` (`contChars t` is a subgroup for any topology `t`), `measurable_of_evalChar`, `measurable_mul_char`,
  `mem_factorSets_iff`, `isClosed_contVec`, `lipschitz_comp_mem_contVec`, `setOf_lt_mem_factorSets`, `compMeasurePreserving_add`, `_zero`,
  `norm_comp_sub_sq`, `ae_mem_condSupport` (SI-2), `ae_condLaw_mul_eq_zero`; definitions `factorSetsSpace`, `clamp`, `condLaw`, `mulDual`, `negOne`,
  each with a spec example.

`Proofs/HadwigerNelson/Arith/CharacterColouring.lean`, [kernel on this branch]:

- **`mem_archimedean_unitRing_iff`** — the erratum's `A` (`plans/FS89-derivation.md:32`): "read `A` as `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`". Lean: a
  character of `R_F` is in `archimedean (unitRing F)` iff it is the reduction of a `ℚ`-linear `F(i) → ℝ` restricted to `R_F`. Over
  `exists_ratLinear_extension` (an additive map from a group embedded in a `ℚ`-vector space into `ℝ` extends `ℚ`-linearly: Mathlib's Baer criterion
  for the divisible group `ℝ`) and the definition `unitRingToFieldI`.

## Stage 1 — SAVED (FS131-I10A): the readback, the build as given

**Quotations** (standing rule 3), by script — `grep -F` of each quoted string in the file the brief names; `data/fs131/i10a/logs/quotations.txt`:
**seven of seven match** (`CLAUDE.md` § Counter-priors; inventory items 484, 485, 477, 478 in `plans/FS131-close-inventory.md`, read on `main`, where
they are filed; the plan's §§ 5.2 and 5.5 headings in this worktree).

**Read**: the planner's record whole; `SpectralInputs.lean` and `CharacterColouring.lean` whole; `SpectralChain.lean` lines 51–230 and 400–530 (the
foundation: `Dual`, `rot`, `RotInv`, `PosDef`, `BochnerHerglotz`, `Interface`, `posDef_corr`, `rotInv_of_isTraceSpectral`); the derivation entries
J45-N1, -N2, -SI-4, -SP-oi, -SP-if (`plans/FS84-SI-D-derivation.md:419–556`) and their lemmas (§ 2.1 lines 105–135, § 2.2 lines 142–162, § 4.2 lines
296–319); the erratum for `A` (`plans/FS89-derivation.md:32`).

**The branch as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0, "all 1771 modules already up to
date", 21 `declaration uses 'sorry'` warnings: `CharacterColouring` 1, `SpectralInputs` 8, `StationaryRatio` 3, `StandingFive` 9
(`data/fs131/i10a/logs/build-0-as-given.log`).

**The statement check** is `tools/fs131_i10a_statements.py <base> <files>`: every declaration of the base commit's file must appear verbatim in the
working tree — a theorem up to its first ` :=`, anything else whole, docstrings included. Its two planted faults fire (`--self-test`: one character of
a theorem's statement changed; one line of a definition dropped).

## Stage 2 — SAVED (FS131-I10A): group 1, the factor trio (J45-N2's measure-theoretic half)

**The statement the proofs derive from** is simpler than the plan's: `A ∈ factorSets ↔ MeasurableSet A ∧ μ(T_y⁻¹A ∆ A) → 0` along `l`
(`mem_factorSets_iff`; from Mathlib's `dist_indicatorConstLp_eq_norm` and the `rfl` `Lp.indicatorConstLp_compMeasurePreserving`). With it the empty
set, complements, finite unions and invariance under commuting maps are set identities; countable unions use `isClosed_contVec` and
`tendsto_indicatorConstLp_set`. Leaf (ii)'s `⊆` is the plan's route: `1_{f > t}` is the `L²`-limit of the clamps `max 0 (min 1 ((n+1)(f − t)))`, each in
`contVec` by `lipschitz_comp_mem_contVec`; the limit is bounded by `‖1_{0 < f − t < 1/(n+1)}‖₂ → 0`, with no dominated-convergence theorem. `⊇` is
`Lp.induction_stronglyMeasurable`. **A route that fails, found on paper before any Lean**: Chebyshev on `{f ∘ T_y > t} ∆ {f > t}` leaves `μ{f = t}`,
which need not vanish — the clamp limit is what crosses an atom of `f` at `t`.

**Evidence.** Build: `data/fs131/i10a/logs/build-1-trio.log` (exit 0; `SpectralInputs` rebuilt in 3.1 s; its warnings are the five remaining `sorry`
leaves, lines 61, 112, 561, 579, 603). Axioms: `data/fs131/i10a/axioms-group1.lean`, log `data/fs131/i10a/logs/axioms-group1.log` — ten records on the
standard three, and the control (`sp_if`, still open) prints `sorryAx`. Statements: `tools/fs131_i10a_statements.py f919973e` on both files — 24 and 33
base declarations, all unchanged; self-test fired.

**Re-priced from these leaves** (the brief's ask). The trio with N2's last clause: about 330 lines of Lean, five elaboration rounds, one build of eight
minutes (the walk; the module itself compiles in 3 s), about 45k of my own tokens — against the plan's 540 lines. At that rate the six leaves left
(about 1,000 lines by the plan) are about 135k of my own tokens; the job stays inside the brief's guidance. Iteration is on scratch files importing the
built module (3 s a round), so the price is in the proofs, not the machine.

**A Lean fact met here** (draft for `LEAN.md` § Searching — Lean, Keryx's file): `T ⁻¹' A ∆ A` parses as `T ⁻¹' (A ∆ A)` — `⁻¹'` binds looser than `∆`;
write `(T ⁻¹' A) ∆ A`.

## Stage 3 — SAVED (FS131-I10A): group 2, SI-4

`si4` in three children: `measurable_selection` (`M(x)` is a function of the `𝒜`-measurable `p(x)`; finitely many fibres), `ae_mem_condSupport`
(SI-2: `P(c(x) = j, p_j(x) ≤ 0) = ∫_{p_j ≤ 0} p_j ≤ 0`, by `setIntegral_condExp`), `ae_condLaw_mul_eq_zero` (a non-negative integrable function with
integral 0 vanishes a.s.; integrability from `0 ≤ p_j ≤ 1`). Properness then needs `M(x) ≠ ∅`, which is SI-2 — the hypothesis `hf` asks `f s ∈ s`
only for non-empty `s`. One elaboration round after the first draft.

## Stage 4 — SAVED (FS131-I10A): group 3, the Fourier group (`exists_isHaarFourier`, `contChars_haar_null`, `sp_if`)

**The statement the three derive from**: `ext_of_fourier` — given `BochnerHerglotz G`, two finite measures on the characters with the same Fourier
coefficients are equal (their common transform is positive definite, `posDef_fourier`, so the uniqueness clause applies). Then:
`exists_isHaarFourier` is `posDef_delta` and a mass count; `contChars_haar_null` is the plan's Fourier-side route, with `contChars t` a subgroup for
**any** topology `t` (pointwise products and inverses of continuous circle-valued functions: no group topology on `R` is read, the planner's finding
6, now confirmed by a proof); `sp_if` is the derivation's three steps, the convolution written as the push-forward of `τ′ ⊗ λ` under multiplication
(`integral_prod_mul` gives `τ̂(1) = τ̂′(1) λ̂(1)` with no Fubini bookkeeping; `Measure.prod_apply_symm` gives `τ(E) = ∫ τ′(E·a⁻¹) dλ(a) = 0`).
Both files passed their first elaboration; `sp_if` its first.

**Evidence for stages 3–4.** Build: `data/fs131/i10a/logs/build-2-si4-fourier.log` (exit 0; one `sorry` left in `SpectralInputs`, line 784).
Axioms: `data/fs131/i10a/axioms-group2.lean`, log `data/fs131/i10a/logs/axioms-group2.log` — twelve records on the standard three, and the control
(`spectral_carried_iff`, then open) prints `sorryAx`. Statements: PASS, 24 and 33.

## Stage 5 — SAVED (FS131-I10A): group 4 — `spectral_carried_iff`, `mem_archimedean_unitRing_iff`, and SI-4's equivariance clause

- `spectral_carried_iff`: `‖V_y f − f‖² = 2(⟨f,f⟩ − ⟨f, V_y f⟩) = 2 ∫ (1 − Re χ(y)) dσ` (`norm_comp_sub_sq`; `σ(R̂) = ‖f‖²` because `V_0 = id`,
  which for an action follows from `T 0 = T 0 ∘ T 0` and the injectivity of an isometry — `T 0` itself need not be the identity). `⟹`: dominated
  convergence along sequences. `⟸`: `|⟨f, V_y f⟩ − ⟨f, V_x f⟩| ≤ ‖f‖ ‖V_{y−x} f − f‖`, then `BochnerOn t`.
- `mem_archimedean_unitRing_iff`: Mathlib has Baer's criterion for divisible groups (`Module.Baer.of_divisible`,
  `Module.Baer.extension_property_addMonoidHom`) and `AddMonoidHom.toRatLinearMap`; the leaf is ten lines over them. It adds two Mathlib imports to
  `CharacterColouring` (`Mathlib.Algebra.Category.Grp.Injective`, `Mathlib.Algebra.Module.LinearMap.Rat`).
- `si4_equivariant`: stated with `𝒜.comap S = 𝒜`, an equality. `𝒜.comap S ≤ 𝒜` is not enough: for the one-sided shift on fair bits with
  `𝒜 = σ(ω₁, ω₂, …)` and `g = ω₀`, `E[g|𝒜] ∘ S = 1/2` and `E[g ∘ S|𝒜] = ω₁`.

**Evidence.** Build: `data/fs131/i10a/logs/build-3-all-leaves.log` (exit 0; `CharacterColouring` and `SpectralInputs` rebuilt with no warning; the
twelve `sorry` warnings left are `StandingFive` 9 and `StationaryRatio` 3, the wave's other files). Axioms: `data/fs131/i10a/axioms-all.lean`, log
`data/fs131/i10a/logs/axioms-all.log` — 33 records of this job's block on the standard three; the control (`StandingFive.usable_card_ge`, open on
this branch) prints `sorryAx`. Statements: `tools/fs131_i10a_statements.py f919973e` — PASS, 24 and 33 base declarations unchanged, docstrings
included. Environment linters, on scratch copies of the two files with `#lint` appended (iteration only, not the gate's run): 0 errors in 93 and 36
declarations.

## Findings (for the report's inventory)

1. **Two hypotheses the proofs do not read** (statements unchanged; each consumed by a `have` so the unused-arguments linter stays silent, with a
   comment at the line): `sp_if`'s `[Countable (unitRing F)]` (multiplication of characters is measurable for the cylinder σ-algebra with no
   countability); `spectral_carried_iff`'s `[IsProbabilityMeasure μ]` (`σ` carries `‖f‖²`; any measure with a measure-preserving action). The linter
   named the second; the first I found writing the proof.
2. **`sp_if`'s hypothesis `hcirc : I.NegCircle` has no model in the file.** The plan's § 5.5 prices one at `Interface.trivial` at "an hour"
   (`∫₀^π cos(π cos θ) dθ < 0`). Not done, and re-priced: it needs the push-forward of Lebesgue measure on a circle of archimedean characters, its
   rotation invariance, and the sign of `J₀(π)`, where the crude three-interval bound leaves a margin of about 0.04 — a stage of a job, not an hour.
   A cheaper model at `F = ℚ`: the point mass at the parity character (every rational unit vector is `≡ 1` at the prime `1 + i`), if the library's
   two-colour modules hold that ring map; not checked here.
3. **To apply `si4_equivariant` to `𝒜 = factorSigma`** one needs `(factorSigma T hT l).comap (T x) = factorSigma T hT l`.
   `measurableSet_preimage_factorSigma` gives `≤`; `≥` needs `T x ∘ T (−x) = id` pointwise, true for the shift on colourings and not a consequence
   of `hadd` alone (which gives `V_0 = id` on `L²`, not `T 0 = id`). Two lines when the action is by bijections; not stated here.
4. The plan's route for N2 (i) (closed subspace, Lipschitz stability, then products of indicators) was replaced by the set identity
   `mem_factorSets_iff`; its route for (ii) was kept.
5. A Lean fact (stage 2): `⁻¹'` binds looser than `∆`.

## Slips, mine

- Stages 3–5 are one commit: after stage 2 I built groups 2–3 together and committed only after group 4's build. A halt in between would have cost
  three groups of uncommitted proof text (the scratch files were in the session's scratch directory, which is RAM). Nothing was lost.
- The condition of each wait on a build was checked false at arming (logged in the command's first line).

## Drafts for the front page

The gate's counts (`CLAUDE.md` § The gate, § Trust ledger) are the landing's: this branch does not run the gate, and twelve leaves of the wave's
other files are open on it. Drafts, each for the landing of wave 10:

- **`plans/LEAN-BACKLOG.md`, rows J45-N2, J45-SI-4, J45-SP-if, J45-N1** (state column, replacing "stated, `sorry`"): J45-N2 — [kernel] whole:
  `measurableSet_factorSigma_iff`, `contVec_eq_lpMeas`, `measurableSet_preimage_factorSigma`, `condExpL2_mem_contVec`, `condExpL2_eq_self_iff`,
  `inner_sub_condExpL2_eq_zero` with no hypothesis from outside; `spectral_carried_iff` over `BochnerOn t`. J45-SI-4 — [kernel] whole: `si4`,
  `si4_equivariant`, no hypothesis from outside. J45-SP-if — [kernel]: `sp_if` over `SpectralChain.BochnerHerglotz`, `Interface.MulStable`,
  `Interface.NegCircle`. J45-N1 — clause (c) [kernel]: `contChars_haar_null` over `SpectralChain.BochnerHerglotz`; (a), (b) not stated (K10b).
- **`LEDGER.md`, the row holding FS89's erratum** (after "with `A(R_F)` they hold"): "`A` read back in the kernel as `Hom_ℚ(F(i), ℝ) mod 1`:
  `CharacterColouring.mem_archimedean_unitRing_iff`, standard three axioms."
- **`LEAN.md` § Searching — Lean** (a new bullet): "`T ⁻¹' A ∆ A` parses as `T ⁻¹' (A ∆ A)`: write `(T ⁻¹' A) ∆ A`."
- **`plans/FS131-kernel-plan.md` § 7.4** (the named hypotheses' table, row `Interface.NegCircle`, last column, replacing "an hour"): "a job's
  stage: the circle measure, its invariance, and `J₀(π) < 0` with a margin of 0.04 on the crude bound (FS131-I10A)."
- Frontier line and Proof Atlas: no change until the wave lands.
