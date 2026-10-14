# FS131-IJ1 — the five-colour chain: the join of its proof line with the map's and the count's modules; the ring map made one; M10, M2a, M3, M2b

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-IJ1-join-m10-m2.md` (on `main`). Branch `fs131-wt3`, cut from
`fs131-wt2` at `cea54d08e` in the worktree `.claude/worktrees/fs131-wq1`; `fs131-wk12` (at `f6898c132`) merged into it.
Working files: `data/fs131/ij1/`. Laptop: 12 cores, 31 GB.*

## Theorems this phase proved

Each [kernel], axioms exactly `[propext, Classical.choice, Quot.sound]`, printed from build 2's tree
(`data/fs131/ij1/axioms-after.txt`; reader `tools/fs131_ij1_axioms.py` PASS, control 4 of 4); all under
`HadwigerNelson.Rigidity`.
- **M10, `Rigidity/ContinuityGroup`** (6 leaves): `isTopologicalAddGroup_tauPrime`, `isCountablyGenerated_nhds_tauPrime`,
  `TA_subset_contChars`, `mem_archChars_of_continuousAt`, `archContinuousAt_pow_of_mem_contChars`,
  `contChars_subset_TA`; with them **`contChars_tauPrime : ∀ (F : Subfield ℝ) [NumberField ↥F], contChars (tauPrime F)
  = TA F`** (J45 N1 (a) at `S = ∅`: the characters of `ℤ[U_F]` continuous for the profinite-plus-archimedean topology are
  exactly the torsion characters times the archimedean ones) has no leaf below it. 28 records of the module, all CLEAN
  (10 public, 18 private and generated).
- **M2a, `Rigidity/Herglotz`** (3 leaves): `exists_almostInvariant_weights`, `exists_fejer_measures`,
  `exists_fourier_eq_of_tendsto`; with them **`bochnerHerglotz_of_countable : ∀ (G : Type u_1) [AddCommGroup G]
  [Countable G], BochnerHerglotz G`** (every positive-definite function on a countable abelian group is the
  Fourier–Stieltjes transform of a unique finite measure on its dual; `[Rudin1962]` 1.4.3 with 1.3.6, by a Fejér route)
  has no leaf below it. 15 records of the module (4 public, 11 private and generated), all CLEAN.
- `mem_torsion_mul_arch_iff`, `exists_rat_coords` (`Rigidity/ChainAtTA`, proved before, made public): CLEAN.

9 leaves; 27 private helpers (five of them private definitions: `archHom`, `fivePow`, `wBox`, `wPt`, `wCnt`) and two
generated constants (`archHom.congr_simp`, `wCnt.congr_simp`). **Not proved** (left `sorry`, re-priced in stage 5): M3's two
leaves, M2b's four.

## Stage 1 — SAVED: the join, its build, the readback, the stored statements before any edit

**1.1 The join.** `git merge-tree` reported `ARCHITECTURE.md` alone in conflict, as the brief said. Merge commit
`3ae198eac` (`--no-ff`, parents `cea54d08e` and `f6898c132`): the conflict was one block, this line's eight rows
(`SolenoidErgodic` … `UnitCircle`, each "proved by …") against the other line's thirteen new rows (`Herglotz` …
`CountDescent`) followed by the base's eight old rows for the same eight modules; the old rows were checked to be the
merge base's (`fec557c9a`) line for line and dropped, both sides' other rows kept (21 → 8 + 13). `fs131-wk12` touches no
Lean file this line touches (it adds fourteen modules and their imports in `Proofs.lean`).

**1.2 The joined tree builds** (`./scripts/build.sh` under the slot, `MEMMAX=10G BATCH=8`; `logs/build0.log`, gate log
`build/gate/build/20261014T135108Z-3273743.log`): `OK — 256 of 256 batches, 15 module(s) rebuilt, 20 module(s) with
warnings, 7m53s`, exit 0 — the fourteen new modules and `Proofs`; every warning ``declaration uses `sorry` ``. The one line
was sent to the coordinator.

**1.3 The brief's quotations** (standing rule 3; `tools/fs131_ij1_quotes.py`, FS131-ITT1's reader unchanged in logic,
against `main`'s tree): **7 quotations, 7 MATCH** (`logs/quotes.log`) — W2 (`data/fs131/REQUEST-2026-10-13.md`), the two
dated lines of 2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 823, 832, 850, 847
(`plans/FS131-close-inventory.md`). **Control** (`--plant`): one character of each quotation changed in turn, each planted
quotation MISMATCH and the other six MATCH, 7 of 7 (`logs/quotes-plant.log`). No finding about the brief.

**1.4 The stored statements before any edit.** `data/fs131/ij1/lean/StatementDump.lean` (FS131-ITK1's dumper aimed at the
ten modules this job's edits can reach: the seven it writes — `ChainAtTA`, `CountResidue`, `CountCompletion`,
`ContinuityGroup`, `Herglotz`, `InvariantMeasure`, `BochnerTau` — and the three downstream of them it does not —
`CountTorus`, `CountExtension`, `CountDescent`), run on the joined build before any edit: `statements-before.txt` (13 MB;
committed as `.xz`, sha256 in `statements-before.sha256`), 216 constants (137 named, 79 internal). The reader is
`tools/fs131_ij1_statements.py` (ITK1's, with the two ruled changes made checkable, § 2.3). Against itself: PASS
(`statements-self.out`).

**1.5 `AdmissiblePair.ofPow`** (item 847 ruling 3): on the joined branch `Rigidity/UnitCircle.lean`'s `def
AdmissiblePair.ofPow` and its proof are `fs131-wt1`'s text, byte for byte (the 22 lines from the keyword, md5 equal on
`fs131-wt1` and `fs131-wt3`; `fs131-wk12`'s differs — its `sorry` version — and the merge did not take it: `fs131-wk12`
never changed that file after the base). Its stored type and axioms from the built tree are printed in stage 5.

**1.6 Each leaf, its statement in one line, beside its plan** (plans: `plans/FS131-KR1-chain-map.md` on `fs131-wk12`, §§ 2.1–2.3
and the table of § 4.3). `R = unitRing F`, `L = fieldI F`, `V = L ⊗ ℝ` (the mixed space), `T + A = TA F`.

| module | leaf | the statement | the plan's route |
|---|---|---|---|
| M10 `ContinuityGroup` | `isTopologicalAddGroup_tauPrime` | `τ′_∅` is a group topology | `topologicalAddGroup_inf` of `topologicalAddGroup_iInf` and `topologicalAddGroup_induced` |
| | `isCountablyGenerated_nhds_tauPrime` | the `τ′_∅`-neighbourhoods of `0` are countably generated | `nhds_inf`, `nhds_iInf`, comaps of `pure` and of the mixed space's neighbourhoods |
| | `TA_subset_contChars` | `T + A ⊆` the `τ′_∅`-continuous characters | torsion: locally constant on cosets of `N·R`; arch: the lift is a real combination of `ℚ`-coordinates, continuous for the mixed embedding |
| | `mem_archChars_of_continuousAt` | a character continuous at `0` for `archTop` has an additive real lift | (hard) lattices `5^{−k}c₀𝓞_L`, stabilisation, density |
| | `archContinuousAt_pow_of_mem_contChars` | a `τ′_∅`-continuous character has a non-zero power continuous at `0` for `archTop` | `Re χ > 0` on `N·R ∩ B_δ`; `|arg χ^N| < π/(2k)` on `B_{δ/(Nk)}` |
| | `contChars_subset_TA` | the `τ′_∅`-continuous characters `⊆ T + A` | the two above and `mem_torsion_mul_arch_iff` |
| M2a `Herglotz` | `exists_almostInvariant_weights` | finitely supported weights `w n ≥ 0`, `Σ (w n)² = 1`, `Σ_x w(x) w(x + z) → 1` for every `z` | convolutions of uniform weights on progressions; Young's inequality |
| | `exists_fejer_measures` | a positive-definite `C` is the coefficientwise limit of finite measures on `Ĝ` of mass `C 0` | density `Σ w(x)w(y)C(x−y)χ̄(x−y)` times `dualHaar`; `isHaarFourier_dualHaar` |
| | `exists_fourier_eq_of_tendsto` | measures of bounded mass with convergent coefficients have a finite limit point with those coefficients | Prokhorov on the compact dual |
| M3 `InvariantMeasure` | `exists_shiftInvariant_on` | a shift-invariant probability measure on a closed shift-invariant nonempty `K` | average push-forwards of a point mass with the weights `(w n)²`; a limit point |
| | `exists_rotInvariant_of_shiftInvariant` | rotation averages of a shift-invariant measure on `K` give one invariant under both | the same over the unit vectors, `shift_y ∘ rot_u = rot_u ∘ shift_{uy}` |
| M2b `BochnerTau` | `finite_quotient_nsmul` | `R ⧸ N·R` is finite, `N ≥ 1` | finite subsets of `R` span free groups of rank `≤ [L:ℚ]` |
| | `archimedean_support` | a finite measure on `R̂` with `archTop`-continuous transform is carried by `A` | (hard) tightness on the lattices' duals, Prokhorov on `V*`, uniqueness |
| | `exists_twisted_parts` | a `τ′_∅`-continuous transform splits as `Σ_{t ∈ T} ψ_t` with each `t̄ψ_t` positive-definite and arch-continuous | (hard, first) twisted Riemann sums, uniform continuity, `finite_quotient_nsmul` |
| | `bochnerOn_tauPrime` | Bochner for `τ′_∅` | M2a on each part, `archimedean_support`, the sum, uniqueness |

## Stage 2 — SAVED: the replacement of `Counting.toL` by `ofUnitRing`; the two lemmas of `ChainAtTA` made public

**2.1 One map, from the kernel's side** (`data/fs131/ij1/probes/OneTerm.lean`, importing `CountResidue` and `TateModel` on
the joined build; `OneTerm.out`): `theorem FS131IJ1_toL_eq_ofUnitRing (F : Subfield ℝ) : Counting.toL F = ofUnitRing F :=
rfl` is accepted (axioms `[propext, Classical.choice, Quot.sound]` — the `rfl` itself reads none; the print is of the
probe's environment). Both stored types are one expression (hash `3608629697` each, `types equal: true`; neither takes
`[NumberField F]`). Both stored values are printed in full; they differ as stored, and are equal once the names of their
three auxiliary proofs (`Counting.toL._proof_1…3`, `ofUnitRing._proof_1…3`) are identified — the two definitions are the
same text, `RingHom.codRestrict (unitRing F).subtype (fieldI F) fun r => UnitRing.unitRingOver_le_planeOverSubring F r.2`.

**2.2 The edit.** `Rigidity/CountResidue.lean`: `def toL` deleted; `import Proofs.HadwigerNelson.Rigidity.TateModel` added;
`toL_mem_localRing` **renamed** `ofUnitRing_mem_localRing` (its statement `ofUnitRing F r ∈ P.localRing`, its `sorry`
kept: it is lane Λ2's leaf); `toLocal`'s value and `exists_unitRing_of_normOneL`'s statement re-pointed.
`Rigidity/CountCompletion.lean`: `ιG`'s value re-pointed. `Counting.finite_quot` untouched (item 847 ruling 2 is lane Λ2's).
`Rigidity/ChainAtTA.lean`: `private` removed from `mem_torsion_mul_arch_iff` and `exists_rat_coords`, nothing else (no
other module declares either name).

**2.3 Build 1** (`logs/build1.log`; gate log `build/gate/build/20261014T140104Z-3311078.log`): `OK — 256 of 256 batches, 21
module(s) rebuilt, 20 module(s) with warnings, 9m4s`, exit 0 — `ChainAtTA` and the twenty modules downstream of it or of
`CountResidue`; every warning a `sorry`.

**2.4 No statement changed but the ruled ones, from the kernel's side** (`statements-before.txt` against build 1's
`statements-b1.txt`, `.xz` + sha256; `tools/fs131_ij1_statements.py … 3ae198eac --deleted deleted.txt --renamed
renamed.txt --publicized publicized.txt --allow-new allow-new.txt`): **PASS** (`statements-compare-b1.out`) — 135 named
constants, 39 data definitions' values, 3 example heads; no new public constant beyond the ruled ones; and exactly these,
each named:
- **RULED DELETE** `Counting.toL`.
- **RULED RENAME** `Counting.toL_mem_localRing → Counting.ofUnitRing_mem_localRing`; its stored type equal after the
  substitution, up to the hygienic hash Lean mints from a theorem's name into its two instance-binder tokens
  (`inst._@.…CountResidue.<hash>._hygCtx._hyg.6`) — the reader blanks that hash for a renamed constant only.
- **RULED SUBST**, the stored term equal to the first dump's with `Counting.toL` read as `ofUnitRing` (and the renamed
  theorem by its new name), compared on the term with Lean's hash token stripped: the **type** of
  `Counting.exists_unitRing_of_normOneL`, the **values** of `Counting.toLocal` and `Counting.ιG`. These are every stored
  term of the ten modules that mentioned `toL`.
- **RULED PUBLIC** `mem_torsion_mul_arch_iff`, `exists_rat_coords`: the private constants of the first dump are the public
  ones of the second, kind, stored type and module identical.
- The downstream modules `CountTorus`, `CountExtension`, `CountDescent` — and `CountResidue`'s other 70 constants, under the
  new import of `TateModel` — unchanged: the import moved no stored instance.

**The controls.** `--control` plants nine faults (an M10 leaf's type, `archTop`'s value, an M2a leaf missing,
`count_of_oneAvoidingDensityBound`'s type downstream, `tauPrime` moved, a new public constant, an axiom, a leaf become a
definition, and **a reader of the replaced map whose stored type differs by more than the name**): 9 of 9 reported
(`statements-control-b1.out`). Without the ruled lists the same two dumps FAIL with 10 differences, naming every ruled one
(`statements-compare-b1-unruled.out`): the reader's substitution is off unless `toL` is listed as deleted.

## Stage 3 — SAVED: M10, `Rigidity/ContinuityGroup`, all six leaves (elaborated; the build is a later stage)

Written against a copy (`data/fs131/ij1/work/ContinuityGroup.lean`; rounds `logs/M10-1.log` … `M10-6.log`, the last exit 0
with **no warning**, under `lake env lean` with the lakefile's two options), then copied over the module; `git diff -U0`
removes the six `sorry` lines and nothing else. About 420 lines against the plan's 800–1,200 (about 0.4).

| leaf | route as planned? |
|---|---|
| `isTopologicalAddGroup_tauPrime` | yes (`topologicalAddGroup_inf`, `_iInf`, `_induced`; the discrete quotient by `topologicalAddGroup_of_discreteTopology` at `⊥`) |
| `isCountablyGenerated_nhds_tauPrime` | yes (`nhds_inf`, `nhds_iInf`, `nhds_induced`, `nhds_discrete` at `⊥`, `Filter.isCountablyGenerated_pure`) |
| `TA_subset_contChars` | yes in outline, pointwise (`continuous_iff_continuousAt` and `Filter.Tendsto.mul`, so no product instance on `R` is asked for): the torsion factor is constant on the coset `y + (N′ + 1)·R`, a profinite neighbourhood; the archimedean factor through **another route than `exists_rat_coords`**: an additive `ψ : R → ℝ` equals `r ↦ Σ_i ℓ_i(ι_∞ r)·ψ(c e_i)/c`, `ℓ_i` the coordinates in Mathlib's `latticeBasis` (an integral basis `e_i` of `𝓞_L` sent to an `ℝ`-basis of `V`), `c·𝓞_L ⊆ R` (`exists_mul_stableIntegers_le` with `𝓞_L ⊆ O′`), and a non-zero `y` with `y r ∈ 𝓞_L` (`exists_integral_multiples`): both sides agree on the `c e_i` and are additive, so agree at `c y r`, hence at `r` |
| `mem_archChars_of_continuousAt` | **another route, shorter** (no lattices, no stabilisation, no density): on the ball `‖ι_∞ r‖ < δ` where `Re χ > 0`, `θ = arg ∘ χ` is additive along multiples (`arg (z w) = arg z + arg w` for arguments in `(−π/2, π/2)`); `1/5 ∈ R` (`(3 ± 4i)/5`), so the lift is `ψ(r) = 5^k θ(r/5^k)` for every `k` past the first at which `5‖ι_∞(r/5^k)‖ < δ` (independent of `k` by `θ(5x) = 5θ(x)`), additive by one common `k`, and `χ = exp ∘ ψ` from `χ(r) = χ(r/5^k)^{5^k}` |
| `archContinuousAt_pow_of_mem_contChars` | yes (`Re χ > 0` on `M·R ∩ B_δ`, the profinite neighbourhood holding `M·R` by `Filter.iInf_sets_induct`; then `|arg χ^M(x)| < π/(2n)` when `n‖ι_∞ x‖ < δ/M`) |
| `contChars_subset_TA` | yes (`mem_torsion_mul_arch_iff`, now public) |

**Private helpers** (17): `archHom` (a private definition: `archTop`'s map as an additive map, `archTop F =
induced (archHom F) inferInstance` by `rfl`), `archTop_eq`, `tendsto_archHom`, `eventually_archTop`, `norm_archHom_nsmul`,
`arg_mul_of_abs_lt`, `arg_nsmul_of_small`, `abs_arg_lt_of_small`, `inv_five_mem`, `fivePow` (a private definition, `r/5^k
∈ R`), `nsmul_fivePow`, `fivePow_succ`, `fivePow_add`, `exists_nsmul_mem_of_mem_nhds_profTop`, `mem_nhds_profTop`,
`exists_nat_mul_integers_mem`, `tendsto_archTop_addMonoidHom`. No import added. The mixed space's norm exists only with the
real places decidable (`Fintype` of a subtype): `eventually_archTop` and `norm_archHom_nsmul` are stated under `open scoped
Classical in`, and the proofs that read the norm open `classical`.

**Re-priced from M10:** about 0.4 of the plan; the hard leaf, by a shorter route, about 100 lines.

## Stage 4 — SAVED: M2a, `Rigidity/Herglotz`, all three leaves (elaborated; the build is the next stage)

Against a copy (`data/fs131/ij1/work/Herglotz.lean`; rounds `logs/M2a-1.log` … `M2a-8.log`, the last exit 0 with **no
warning**), copied over the module; `git diff -U0` removes the three `sorry` lines and nothing else. One import added:
`Mathlib.MeasureTheory.Measure.Prokhorov` (finite measures and their compactness); whether it moved a stored instance is
stage 5's dump. About 330 lines against the plan's 600–900 (about 0.45).

| leaf | route as planned? |
|---|---|
| `exists_almostInvariant_weights` | **another route, shorter** (no convolutions, no Young's inequality): for a surjection `g : ℕ → G`, `ν_n` is the push-forward of the counting measure of the box `{0,…,n}^n` by `a ↦ Σ_j a_j g_j`, and `w_n = √ν_n`; then `Σ w_n² = 1` fibre by fibre, `Σ_x w(x)w(x + z) ≤ 1` by `ab ≤ (a² + b²)/2`, and `≥ n/(n+1)` once `z = g_m`, `m < n`, because `√(ν(x)ν(x+g_m)) ≥ #{a : a_m < n, Σ a_j g_j = x}/#box` (the vectors whose `m`-th exponent can grow inject into both fibres) and those vectors are `n/(n+1)` of the box |
| `exists_fejer_measures` | yes: `q_n(χ) = Σ_{x,x'} w x w x' C(x − x') χ(x' − x)` is `hC`'s sum at `z x = w x χ(−x)`, so real and `≥ 0`; `σ_n = dualHaar.withDensity (q_n)₊`; its coefficients `C(r) Σ_x w(x)w(x − r)` by orthogonality (`isHaarFourier_dualHaar`); mass the coefficient at `0` |
| `exists_fourier_eq_of_tendsto` | yes, with a **cluster point** in place of a subsequence (no metrizability of the space of measures): `isCompact_setOf_finiteMeasure_le_of_compactSpace`, `IsCompact.exists_clusterPt`, the coefficient map continuous on `FiniteMeasure` (`tendsto_iff_forall_integral_rclike_tendsto` at `ℂ`), `ClusterPt.map`, `eq_of_nhds_neBot` |

**Private helpers** (10): `wBox`, `wPt`, `wCnt` (private definitions: the box, its points, the fibre counts),
`wPt_add_single`, `card_wBox_pos`, `card_wBox_lt`, `fejer_sum_eq`, `integral_dualHaar_eval`, `integrable_dualHaar_eval`,
`integral_fejer`. With them **`bochnerHerglotz_of_countable : BochnerHerglotz G`** has no leaf below it in its module
(axioms in stage 5).

**Re-priced:** M2a at about 0.45 of its plan, M10 at about 0.4. M3 (plan 500–800) at these rates is about 250–350 lines; M2b
(plan 2,000–2,500) about 900–1,100.

## Stage 5 — SAVED: build 2; no statement changed but the ruled ones; the axioms; lint; doubled names; architecture

**5.1 Build 2** (`./scripts/build.sh` under the slot, `MEMMAX=10G BATCH=8`; `logs/build2.log`, gate log
`build/gate/build/20261014T144432Z-3450231.log`): `OK — 256 of 256 batches, 10 module(s) rebuilt, 18 module(s) with
warnings, 8m18s`, exit 0. Rebuilt: `Herglotz`, `InvariantMeasure`, `ContinuityGroup`, `BochnerTau`, `CountTorus`,
`CountResidue`, `CountCompletion`, `CountExtension`, `CountDescent`, `Proofs`. **No warning from `ContinuityGroup` or
`Herglotz`**; every warning of the build is ``declaration uses `sorry` `` — in my other files only at their remaining
leaves (`ChainAtTA`'s three, `CountResidue`'s and `CountCompletion`'s lanes' leaves, `InvariantMeasure`'s two,
`BochnerTau`'s four).

**5.2 From the kernel's side** (stage 1's dump against build 2's, `statements-after.txt`, `.xz` + sha256): **PASS**
(`statements-compare.out`) — the same ruled list as § 2.4 and nothing else: 135 named constants, 39 data definitions'
values (`profTop`, `archTop`, `tauPrime` among them), 3 example heads; no new public constant; 29 new private constants
(the 27 helpers and `archHom.congr_simp`, `wCnt.congr_simp`, generated by `simp` on a private definition in its own
module); internal constants 79 → 110. **The import of `Mathlib.MeasureTheory.Measure.Prokhorov` into `Herglotz` moved no
stored term** of `Herglotz`, `InvariantMeasure` or `BochnerTau`. Control on these two dumps: 9 of 9
(`statements-control.out`); without the ruled lists, FAIL with 10 differences (`statements-compare-unruled.out`).

**5.3 The axioms of every declaration of my seven files** (`lean/Axioms.lean` → `axioms-after.txt`;
`tools/fs131_ij1_axioms.py` → `axioms-verdict.out`): **PASS** — 141 records: `ContinuityGroup` 28 and `Herglotz` 15, all
CLEAN; `ChainAtTA` 39 (34 CLEAN, the two made public among them; 5 resting on its own three leaves); `CountResidue` 25
(6 CLEAN), `CountCompletion` 27 (3 CLEAN), `InvariantMeasure` 3 (0), `BochnerTau` 4 (0): every other record rests on
`sorryAx` only through named open leaves (55 OPEN-LEAF, each listed with its sources; none sourced in `ContinuityGroup`
or `Herglotz`). `invariantMeasureOnClosed_of_countable` rests on `sorryAx` from `exists_shiftInvariant_on` and
`exists_rotInvariant_of_shiftInvariant` alone; `bochnerOn_tauPrime` from itself. The planted record
(`positive_entropy_rigidity_of_polishSpace`) is reported resting on the declared printed theorem. `--control`: 4 of 4
(`axioms-control.out`). **`AdmissiblePair.ofPow`** (item 847 ruling 3): `[Classical.choice, Quot.sound, propext]` on the
joined tree — `fs131-wt1`'s proved version.

**5.4 The linters** (`lake lint --no-build -- --no-build --trace` under the slot; `logs/lint.log`): **exit 1, 13 of 14
Passed; `unusedArguments` fails with one message: `HadwigerNelson.Rigidity.archTop 1 unused argument: argument 2:
[NumberField ↥F]`** (`Rigidity/ContinuityGroup` l. 42). The finding is the skeleton's: `archTop`'s value
(`TopologicalSpace.induced (fun r => mixedEmbedding (fieldI F) ⟨r, _⟩) inferInstance`) reads no `NumberField` at the
pin, and neither the build's linters nor `lake env lean` report an environment linter — the planners (FS131-KR1,
FS131-K12A) ran no `lake lint`. Not repaired here: dropping the binder changes the stored type of `archTop`, `tauPrime` and
every statement over them (a definition change); `@[nolint unusedArguments]` with its reason is an attribute on a
definition. Held for the coordinator. **Doubled names** (`./scripts/dupnames.sh` on the joined tree): OK — no name
declared by two modules, 24 generated on demand, "no repeated name appeared or disappeared since the previous complete
run" (`logs/dupnames.log`; gate log `build/gate/dupnames/20261014T145602Z-3506915.log`). **Architecture**
(`tools/check_architecture.py`): RESULT PASS with seven rows updated (`logs/architecture.log`). **Not run** (the branch
condition of item 815's ruling 2, as for FS131-ITK1): `scripts/axioms.sh`, `assumptions.sh`, `vacuity.sh`.

**5.5 What is left, re-priced.** M10 came in at about 0.4 of its plan and M2a at about 0.45, each in six to eight
elaboration rounds. **M3** (`InvariantMeasure`, 2 leaves, plan 500–800): about 250–400 lines. Its route, as found while
pricing it: work on `K` itself as a compact space (`isCompact_iff_compactSpace`), average point masses
`Σ_x w(x)² δ_{c₀(· + x)}` on `K`, take a cluster point in `FiniteMeasure K` as M2a's third leaf does, push it to
`unitRing F → Fin 4` by `Subtype.val` (so `μ Kᶜ = 0` is free); invariance by `FiniteMeasure` equality from bounded
continuous integrals, the defect `|Σ_x w(x)² (f(c₀(·+x+y)) − f(c₀(·+x)))| ≤ 2‖f‖·√(2 − 2⟨w, τ_y w⟩)` (Cauchy–Schwarz;
reindex with `finsum` over `G`); the rotation step the same over a countable abelian group carrying the unit vectors
(`Rigidity.unitCircle F`, an import). **M2b** (`BochnerTau`, 4 leaves, plan 2,000–2,500): about 900–1,200 lines at these
rates, not re-priced from a leaf of its own. One fact bears on its hard leaf: **an archimedean torsion character of `R`
is trivial** (`1/5 ∈ R`, so a real lift with values in `(2π/N)ℤ` has every value in `⋂_k 5^k(2π/N)ℤ = 0`), so the cosets
`t·A`, `t ∈ T`, are disjoint and `exists_twisted_parts`'s parts are `ψ_t(y) = ∫_{tA} χ(y) dσ` once `σ` is known to be
carried by `T + A` — the statement is true; the proof the plan names (twisted Riemann sums) must still build them from
`φ` alone. Neither module prices above a week.

## Drafts for the landing (files this job does not write; each names its slot)

**The audit's block** (`scripts/Axioms.lean`, CLEAN section, after FS131-ITK1's block): `data/fs131/ij1/draft-axioms-block.lean`,
16 `#print axioms` lines — the two lemmas of `ChainAtTA` made public, the 10 public declarations of `ContinuityGroup`,
the 4 of `Herglotz` — CLEAN at build 2, generated from the built tree's print. The private helpers and the two generated
`congr_simp` constants are not in the CLEAN section (as FS131-ITK1's block).

**The models** (`LEAN.md` § The gate). `ContinuityGroup`'s statements are over every real number field and carry no
hypothesis beyond `[NumberField ↥F]` (`archContinuousAt_pow_of_mem_contChars`: `h : χ ∈ contChars (tauPrime F)` is
inhabited at `χ = 1`, and `mem_archChars_of_continuousAt`'s hypothesis at `χ = 1`, a constant map; `one_mem_TA`). Herglotz's
statements are over every countable abelian group: `G = ℤ` or the trivial group, `C = 1` positive-definite (the transform of
the point mass at the trivial character), and `exists_fourier_eq_of_tendsto`'s hypotheses at the constant sequence of that
point mass, `M = 1`. Each note names objects for the hypotheses they satisfy only.

**`ARCHITECTURE.md`** (written on this branch): the rows of `ContinuityGroup` and `Herglotz` ("no `sorry`"), `TateExists`
and `ZeroEntropyClosed` (item 850 ruling 2: "no `sorry`", on the standard three), `ChainAtTA` (the two lemmas public),
`CountResidue` (the ring map is `ofUnitRing`; imports cell `Rigidity/TateModel` added).

**`LEAN.md` § Searching — Lean**, five lines (each follows the last line there):
- "The norm of `mixedEmbedding.mixedSpace K` exists only with the real places decidable (`Fintype` of a subtype of
  `InfinitePlace K`): `‖v‖` fails to synthesize `SeminormedAddCommGroup` without `classical`, while the space's topology
  needs none. State a lemma that reads the norm under `open scoped Classical in` and open `classical` in a proof that
  does; `Metric.nhds_basis_ball` then describes the topology the definition chose by `inferInstance` (FS131-IJ1)."
- "A statement whose domain carries a topology that is not the instance (`tauPrime F` on `unitRing F`, a subtype of `ℂ`)
  is proved pointwise: `(@continuous_iff_continuousAt _ _ t _ _).2`, then `Filter.Tendsto` on `@nhds _ t y` — a filter
  carries no instance, so `Tendsto.mul`, `.comp`, `.mono_left (nhds_mono h)` apply where `Continuous.comp`/`.mul` synthesize
  the subtype topology and fail. `rw [nhds_inf]` does not see through a reducible `tauPrime`: state `nhds_inf (t₁ := …)
  (t₂ := …)` as a `have`; `nhds_induced` at a target topology given as `⊥` needs `@nhds_induced _ _ ⊥`, else the quotient's
  own topology instance is synthesized; `@nhds_discrete _ ⊥ (discreteTopology_bot _)` gives `pure` (FS131-IJ1)."
- "`rw` with an `AddChar` lemma under the coercion `Circle → ℂ` (`AddChar.map_neg_eq_inv` at `↑(χ (-x))`) fails with
  'motive is not type correct' (`Circle` is a def over `Submonoid.unitSphere ℂ`): prove the identity in `Circle`, carry it
  by `congrArg (fun z : Circle => (z : ℂ))`, and `simp only [Circle.coe_mul, Circle.coe_inv_eq_conj]`; `simp` rewrites
  `↑(χ 0)` where `rw` cannot (FS131-IJ1)."
- "A cluster point in place of a subsequence for finite measures on a compact space: `isCompact_setOf_finiteMeasure_le_of_
  compactSpace`, `IsCompact.exists_clusterPt`, `ClusterPt.map`, `eq_of_nhds_neBot`; `μ ↦ ∫ f dμ` for a bounded continuous
  `f` into `ℂ` is continuous by `(FiniteMeasure.tendsto_iff_forall_integral_rclike_tendsto ℂ).1 Filter.tendsto_id f`
  (`Mathlib.MeasureTheory.Measure.Prokhorov`). `Algebra.IsAlgebraic ℤ K` is not an instance for a number field:
  `exists_integral_multiples ℤ ℚ {x}` gives `y ≠ 0` with `y • x` integral (FS131-IJ1)."
- "`lake lint` alone runs the environment linters: `unusedArguments` flags a definition's instance binder its value does not
  read (`Rigidity.archTop`'s `[NumberField F]`), which neither the build nor `lake env lean` reports — a skeleton's
  definitions are linted only there. And a renamed theorem's instance binders carry a hygienic hash minted from its name
  (`inst._@.<module>.<hash>._hygCtx._hyg.6`): a stored-type comparison across a rename blanks that hash for the renamed
  constant alone (`tools/fs131_ij1_statements.py`) (FS131-IJ1)."
