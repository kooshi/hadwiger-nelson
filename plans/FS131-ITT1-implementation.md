# FS131-ITT1 — the five-colour chain: its two newest branches joined, then the adelic model's first lanes proved

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-ITT1-join-tate.md` (on `main`). Branch `fs131-wt1`, cut from
`fs131-wp23` at `28c21407a` in the worktree `.claude/worktrees/fs131-wq1`; `fs131-wk8b` (`fec557c9a`) merged in. Working
files: `data/fs131/itt1/`. Laptop: 12 cores, 31 GB.*

## Theorems this phase proved

(Filled as leaves fall; each line: declaration — grade — axioms — module.)

## Stage 1 — SAVED: the join, the build, the readback, the stored statements before any edit

**1.1 The join.** `git checkout -b fs131-wt1` at `28c21407a`; `git merge --no-ff fs131-wk8b`: one conflict,
`ARCHITECTURE.md` (as `git merge-tree` reported); `Proofs.lean` merged itself. **No row changed on both sides** (each row
compared with the merge base `3b531d1d2`): `fs131-wp23` changed the rows of `Rigidity/Annihilator`, `ChainAtTA`,
`DualConnected`, `DualGroup`, `Duality`, `HaarMultiple`, `SolenoidErgodic`, `SubgroupHaar`, `UnitCircle`,
`ZeroEntropyNames` (and added `Outside/OAI015*`, changed `Entropy`, `EntropySplitMax` outside the conflict), `fs131-wk8b`
changed `PositiveEntropy`'s and added fifteen (`EntropyFibres`, `RingScope`, the six `Tate*`, `PlaceSizes`,
`Multipliers`, `ThinBoxes`, `GlobalPoint`, `WanderingShells`, `ZeroEntropyClosed`). The resolution keeps each module's
row from the side that changed it, each module once, in `fs131-wk8b`'s order: 418 rows, none doubled, every row equal to
the changing side's, the text outside the table byte-identical to `fs131-wp23`'s. Merge commit `432600f15`.

**1.2 Build 1** (`./scripts/build.sh` under the slot, `MEMMAX=10G BATCH=8`): `OK — 254 of 254 batches, 18 module(s)
rebuilt, 16 module(s) with warnings, 8m2s`, exit 0 (`data/fs131/itt1/logs/build1.log`, full output `build1-full.log`).
Every warning is ``declaration uses `sorry` ``. Messaged to the coordinator with the finding of § 1.5.

**1.3 The brief's quotations** (standing rule 3). `tools/fs131_itt1_quotes.py` (FS131-KT1's reader, with a control per
quotation) against `main`'s tree: **6 quotations, 6 MATCH** (`logs/quotes.log`) — W2 (`data/fs131/REQUEST-2026-10-13.md`),
the two dated lines of 2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 799, 811, 815
(`plans/FS131-close-inventory.md`). **Control** (`--plant`): one character of each quotation changed in turn; each planted
quotation reported MISMATCH and the other five MATCH, 6 of 6 (`logs/quotes-plant.log`). No finding about the brief.

**1.4 The stored statements before any edit.** `data/fs131/itt1/lean/StatementDump.lean` (FS131-IP23's dumper, aimed at
the six modules this job writes — `RingScope`, `TateModel`, `TateLocal`, `TateArch`, `TateCharacter`, and `ThinBoxes` for
the move — and the seven downstream of them: `TateKernel`, `TateExists`, `PlaceSizes`, `Multipliers`, `GlobalPoint`,
`WanderingShells`, `ZeroEntropyClosed`), run on build 1's tree before any edit: `statements-before.txt` (225 MB; committed
as `.xz`, sha256 in `statements-before.sha256`), 298 constants (215 named, 83 internal). The reader is
`tools/fs131_itt1_statements.py` (IP23's, with each constant's module tracked and the one move named: the moved constant
must be in its new module with its stored type unchanged, any other change of module a failure). **Against itself:** PASS
— 215 named constants, 62 data definitions' values, 22 example heads (`statements-self.out`). **Its control** plants nine
faults (a T-I leaf's type, `archTrace`'s value, a T-L leaf missing, `thinBox_heavy`'s type downstream, `box` moved to
another module, a new public constant, an axiom, a leaf become a definition, the moved statement changed) and all 9 are
reported, "the check can fail" (`statements-control.out`).

**1.5 A finding (sent to the coordinator at this stage): `TateModel.sigmaCompactSpace` takes no Tate model.** Its stored
type (`logs/SigmaCheck.log`, `#check` from build 1's tree) is `∀ {F : Subfield ℝ} [NumberField ↥F], SigmaCompactSpace
(SAdeleRing F)`: its statement does not mention the section variable `D`, so `D` is not a binder, and K8B1's route "from
`exists_isCompact`" reads a field of a `D` it does not have. The statement as stored is true with no model (W is the mixed
space times a restricted product over countably many places with compact `O_w`). My course, within the brief: the move as
ruled, text unchanged; `isOpenMap` (which does take `D`) through a private helper that reads `D.exists_isCompact`; and
`sigmaCompactSpace` by the intrinsic route after T-L's `compactSpace_adicCompletionIntegers`, or left a leaf.

**1.6 Each leaf, its statement in one line, beside its plan** (as the kernel holds it; plans: FS131-KT1 § 4.3, FS131-KN9
§ 3.2).

| module | leaf | the statement | the plan's route |
|---|---|---|---|
| `TateModel` | `mul_mem_Λ` | `r ∈ R`, `y ∈ Λ` ⇒ `r·y ∈ Λ` | the stabiliser of `Λ` is a subring holding every `unitL u` (`π_unit_mul`, `rot u 1 = 1`); `Subring.closure_le` |
| | `π_eq_π_iff` | `π a = π b ↔ ∃ y ∈ Λ, a = b + ι y` | `AddChar.map_sub_eq_div`, `div_eq_one`, `ker_eq` |
| | `toSAdele_mem_torsionChars` | `π(ι t)` has finite order | `N t ∈ 𝓞 L ⊆ O′` (`exists_integral_multiple`), `stableIntegers_le`, `AddChar.map_nsmul_eq_pow` |
| | `isOpenMap` | `π` is an open map | `MonoidHom.isOpenMap_of_sigmaCompact` on `π.toMonoidHom`, `W` σ-compact |
| | `sigmaCompactSpace` (moved here) | `W` is σ-compact, for every real number field, **no model** | K8B1: from `exists_isCompact` — not available (§ 1.5) |
| `TateLocal` | `exists_valuation_le_one_away` | every `s ∈ K` is `≡ t (mod O_v)` with `t` integral at every `w ≠ v` | route copy `G1b_crt` |
| | `exists_approx_completion` | the same for `z ∈ K_v` | route copy `G1_approx` |
| | `exists_int_trace_of_integral` | integral at every prime ⇒ `Tr x ∈ ℤ` | route copy `G2_trace_int` |
| | `exists_trace_not_int_away` | some `t` integral off `v` has `Tr t ∉ ℤ` | a uniformizer's power, CRT, the trace dual's denominators |
| | `exists_nat_mul_integral_of_trace_int` | one `d₀ ≥ 1` makes `d₀ y` integral for every `y` with `Tr(y𝓞) ⊆ ℤ` | dual basis, common denominator |
| | `compactSpace_adicCompletionIntegers` | `O_v` is compact | complete, DVR, finite residue field |
| `TateArch` | `archTrace_mixedEmbedding` | `Tr_∞(ι_∞ x) = Tr x` | agree on the integral basis |
| | `exists_eq_mixedEmbedding_of_archTrace_int` | `Tr_∞(b·ι_∞ s) ∈ ℤ` for all `s ∈ 𝓞` ⇒ `b = ι_∞ y` | the Gram matrix over `ℚ` |
| | `archTrace_mixedEmbedding_one` | `Tr_∞(1) = [K:ℚ]` | `archTrace_mixedEmbedding`, `Algebra.trace_algebraMap` |
| `TateCharacter` | `mem_stableIntegers_iff_valuation` | `x ∈ O′ ↔` integral at every stable prime | `mem_localRing`, valuation subring at a prime |
| | `exists_isApprox` | every `a ∈ W` has an approximant | finite bad set, `exists_approx_completion` summed |
| | `exists_int_trace_sub_of_isApprox` | two approximants differ by an integral trace | `exists_int_trace_of_integral` |
| | `tateCharFun_eq` | `ψ(a)` through any approximant | the above, `Circle.exp` periodic |
| | `tateCharFun_zero`, `tateCharFun_add` | `ψ(0) = 1`, `ψ(a+b) = ψ(a)ψ(b)` | the approximants `0`, `t_a + t_b` |
| | `tateChar_of_integral` | integral at every split prime ⇒ `ψ(a) = e(Tr_∞ a_∞)` | approximant `0` |
| | `tateChar_toSAdele_of_mem` | `ψ(ι x) = 1` for `x ∈ O′` | approximant `x`, `archTrace_mixedEmbedding` |
| | `continuous_tateChar` | `ψ` continuous | continuous on the open subgroup `L_∞ × ∏ O_w` |
| | `continuous_tatePi` | `π` continuous | pointwise topology of `R̂` |
| | `tatePi_unit_mul` | `π(u a) = rot u (π a)` | `ofUnitRing (uvRing u * r) = unitL u * ofUnitRing r` |
| | `tatePi_toSAdele_of_mem` | `π(ι x) = 1` for `x ∈ O′` | `R ⊆ O′`, `tateChar_toSAdele_of_mem` |
| | `tatePi_arch_mem` | `π(b, 0) ∈ archChars R` | `tateChar_of_integral`, the lift `r ↦ 2π Tr_∞(b r)` |
| `RingScope` (M9-R) | `exists_mul_stableIntegers_le` | `∃ c ≥ 1, c·O′ ⊆ R`, every real number field | FS91-J10-L1 (b), (d), (e) |
| | `dense_mixedEmbedding_nsmul_unitRing` | for `N ≥ 1`, `ι_∞(N·R)` is dense in `L ⊗ ℝ` | `1/5 ∈ R`, `c₀𝓞 L ⊆ R`, lattices `N5^{−k}c₀ ι(𝓞)` |

**1.7 The coordinator's ruling on § 1.5** (received at this stage): keep the statement as stored, with no `(D : TateModel
F)`; the move with text unchanged; `isOpenMap` through a private helper over `D.exists_isCompact`; `sigmaCompactSpace`
proved by the intrinsic route once `compactSpace_adicCompletionIntegers` is proved, with `TateModel` importing `TateLocal`
(recorded in the `ARCHITECTURE.md` row). Its condition: if the intrinsic route needs more than the restricted product's
σ-compactness that Mathlib provides at the pin, say so before typing anything new.

## Stage 2 — SAVED: the move, shown from the kernel's side

**2.1 The edit.** The three lines of `TateModel.sigmaCompactSpace` (its docstring, its statement, its `sorry`) cut from
`Rigidity/ThinBoxes` (inside `namespace TateModel`, after `variable (D : TateModel F)`) and pasted, byte for byte, into
`Rigidity/TateModel` inside `namespace TateModel` just above `isOpenMap` (where `variable {F} (D : TateModel F)` is in
scope: `F` implicit in both places, and `D` read by neither statement). Nothing else in either file changed (`git diff`:
4 lines out, 4 lines in). `ThinBoxes` imports `TateModel` through `PlaceSizes → TateCharacter`, so its readers see the
name unchanged.

**2.2 Build 2** (under the slot, `MEMMAX=10G BATCH=8`): `OK — 254 of 254 batches, 11 module(s) rebuilt, 16 module(s)
with warnings, 7m58s`, exit 0 (`logs/build2.log`, `build2-full.log`); every warning a `sorry`.

**2.3 From the kernel's side.** Dump after the move (`statements-move.txt`, `.xz` and sha256 committed) against stage 1's,
`tools/fs131_itt1_statements.py … 432600f15 --moved`: **PASS** — 215 named constants (kinds, types, modules), 62 data
definitions' values, 22 example heads; no new constant; and `IDENTICAL THM …TateModel.sigmaCompactSpace: identical up to
the module's name in 21 hygienic instance-binder names, Lean's hash equal; module …ThinBoxes -> …TateModel`
(`statements-compare-move.out`). The stored type differs in exactly one way, measured: the instance binder's stored name
carries the file's module (`inst._@.Proofs.HadwigerNelson.Rigidity.ThinBoxes.3304278987._hygCtx._hyg.6` becomes
`…TateModel.3304278987…`; LEAN.md's FS131-IU1 line), 21 tokens, every other of the 4,006 tokens equal and Lean's hash of
the type (blind to binder names) equal, 1262488868 both. The reader rewrites the old and the new module's name in that
position and no other, for the moved constant only. **Controls:** `--control` on these two dumps, 9 of 9 planted faults
reported (`statements-compare-move-control.out`; plant 9 changes the moved statement in its new home and is reported
`TYPE`); and the same two dumps without `--moved` FAIL with `MOVE …: ThinBoxes -> TateModel; expected ThinBoxes ->
ThinBoxes` (`statements-compare-move-unmoved.out`) — the check sees the move.

## Stage 3 — SAVED: lanes T-I, T-L, T-A, T-C proved in the modules (elaborated file by file; the build is stage 4)

Each module elaborated under `lake env lean` with the lakefile's two options (`data/fs131/itt1/lean1.sh`), exit 0 and no
warning: `TateModel` (`logs/TI-5.log`), `TateLocal` (`TL-7.log`), `TateArch` (`TA-4.log`), `TateCharacter` (`TC-4.log`).
No `sorry` is left in the four files. Every change is a proof, a private helper or an import line (`git diff` read file by
file: the only lines removed are the `sorry`s); the kernel's side is stage 4's.

| lane | leaves | route as planned? | lines (est. → written) | rounds |
|---|---|---|---|---|
| T-I `TateModel` | `mul_mem_Λ`, `π_eq_π_iff`, `toSAdele_mem_torsionChars`, `isOpenMap` | yes (the stabiliser subring and `Subring.closure_le`; `AddChar.map_sub_eq_div`; `exists_integral_multiples` and `AddChar.map_nsmul_eq_pow`; `MonoidHom.isOpenMap_of_sigmaCompact` on `π.toMonoidHom`) | 85 → 55 | 3 |
| | `sigmaCompactSpace` (moved here, no model) | **no** — the ruled intrinsic route, shortened (§ 3.1) | — → 50 | 2 |
| T-L `TateLocal` | the three route copies | folded from `FormG.lean` verbatim but for one name | 72 → 72 | 0 |
| | `exists_nat_mul_integral_of_trace_int` | **another route**: `isIntegral_discr_mul_of_mem_traceDual` (Mathlib's `Different.lean`) at the integral basis, `d₀ := |disc K|` — no dual basis, no common denominator | 50 → 30 | 2 |
| | `exists_trace_not_int_away` | as planned, with `ϖ ∈ v ∖ 0` in place of a uniformizer and only inequalities in `ℤᵐ⁰` | 45 → 45 | 2 |
| | `compactSpace_adicCompletionIntegers` | as planned (`compactSpace_iff_…_finite_residueField`; the residue field a quotient of `𝓞 ⧸ v` by density and `exists_valuation_sub_lt_of_integer`) | 80 → 60 | 4 |
| T-A `TateArch` | `archTrace_mixedEmbedding`, `archTrace_mixedEmbedding_one` | yes | 30 → 12 | 2 |
| | `exists_eq_mixedEmbedding_of_archTrace_int` | **another route**: no Gram-matrix solve — `Φ b = (Tr_∞(b·ι eⱼ))ⱼ` is `ℝ`-linear and onto `ℝ^n` (the trace dual basis hits each `Pi.single`), hence injective by dimension; `y := Σ nⱼ e_j^∨` | 70 → 35 | 4 |
| T-C `TateCharacter` | all thirteen | yes; `exists_isApprox` as § 4.6's four children | ~270 → 190 | 4 |

**3.1 `TateModel.sigmaCompactSpace`, the route taken** (the coordinator ruled the intrinsic route and named the box cover;
I took a shorter one with fewer inputs and said so before typing it): `H := range structureMap` of `∏_w O_w` is compact
(Tychonoff with `compactSpace_adicCompletionIntegers`); every split adele is `ι(t) + h`, `t ∈ L`, `h ∈ H`
(`exists_approx_completion` at the finitely many non-integral places, summed); so `∏′ L_w = ⋃_{t ∈ L} (ι t + H)`,
countable because `L` is; `W` is its product with the mixed space (Mathlib's instances). No σ-compactness of `L_w`, no
`ProperSpace`, no countability of the places: `countable_splitPlace` stays a K8-A leaf in `PlaceSizes`, and the move
Amendment 1 allowed is not made. `isOpenMap` now reads `sigmaCompactSpace` itself; the private `D`-helper of stage 1's plan
is gone (one fact, one proof). `TateModel` imports `TateLocal` (which imports only Mathlib) and
`Mathlib.Topology.Baire.LocallyCompactRegular` (the Baire instance of the compact `R̂`); `TateLocal` imports
`Mathlib.RingTheory.DedekindDomain.Different` and `Mathlib.NumberTheory.NumberField.Discriminant.Defs`.

**3.2 Re-priced from the first two leaves of each lane.** Every lane came in under its estimate: T-I about 0.7 of the
plan, T-L about 0.75, T-A about 0.5, T-C about 0.7, at two to four elaboration rounds a leaf. Lane T's remainder after this
job is T-K (`Rigidity/TateKernel`, 9 leaves, planned ~440 lines): at T-C's rate about 300 lines, half a day of an
implementer.

**3.3 The drafts D5 applied** (item 815's ruling 1; prose only): `Rigidity/EntropySplitMax`'s module docstring ("closed by
the port (lane P2) at the join" → "proved by the port (lane P2, FS131-IP23)") and `condExpKernel_ergodicDecomposition`'s
("**Closed by the port at the join** …" → "**Proved by the port** (lane P2, FS131-IP23): the release's theorem,
`Outside.OAI015.action_ergodic_decomposition`, is its proof, `actionInvariantSigma` being `invariantSigma` by its body.");
`Rigidity/Entropy`'s § "The reasoning surface": the draft's "…" filled from the sentence it replaces — the point mass
(`ksEntropy_dirac`, proved over Mathlib alone, read in the file) joins the first sentence, and "Proved from the release's
ported entropy files:" takes the other three and the pinning theorem, T2 with "over `Outside/OAI015Generating`,
FS131-IP23". **In text** (`data/fs131/lc1/code_only_diff.py`): both files SAME outside block comments
(`d5-code-only.out`); its plant reads DIFFERS for both (`d5-code-only-plant.out`). **From the kernel's side:** both
modules dumped from build 2's tree before build 3 (`lean/StatementDumpD5.lean`, `d5-before.txt`); the comparison is
stage 4's.
