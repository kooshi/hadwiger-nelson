# FS131-IDG1 — the five-colour chain: the dual group (D), Pontryagin duality (PD-I) and the unit circle (U), proved

*The chain's third implementer (brief `data/fs131/briefs/FS131-IDG1-dual-group.md`, written 2026-10-14 06:22 UTC).
Branch `fs131-wdg` in the worktree `.claude/worktrees/fs131-wq1`, cut from `fs131-wpd` at `c138bbafd`; not pushed (the
brief: the remote is unreachable). Working files under `data/fs131/idg1/`; checks `tools/fs131_idg1_*.py`.*

## Theorems this phase proved

*(Filled at the last stage, from the axioms printed from the built tree.)*

## Stage 1 — SAVED: the join, the build, the readback, the dump before any edit

### 1.1 The join

`git switch -c fs131-wdg` at `c138bbafd` (`fs131-wpd`), then `git merge --no-ff fs131-wl1` (at `7a369b624`): merge commit
`3b531d1d2`, no conflict (`ARCHITECTURE.md` and `Proofs.lean` auto-merged), 209 files — the entropy branch's three ported
modules (`Outside/OAI015Maximal`, `OAI015Mixtures`, `OAI015Shannon`), lanes H, C and N's proved files (`Rigidity/HaarMultiple`,
`ZeroEntropyNames`, `SolenoidErgodic`, `ChainAtTA`, `Entropy`), and the two implementers' records, data and tools. Neither
side of the merge touches any of my six files or their upstream (`Arith/SpectralInputs` and above): `git diff --stat` of
each side over `Proofs/`.

**The build** (`data/fs131/idg1/build.sh 1 8`, under the slot at 10 GiB and 4 CPUs): `==> build: OK — 249 of 249
batches, 12 module(s) rebuilt, 11 module(s) with warnings, 7m19s`, `exit=0` (`logs/build-1.log`; full output
`build/gate/build/20261014T062450Z-1941704.log`). Rebuilt: the three `Outside/OAI015*` ports, `Rigidity.HaarMultiple`,
`SolenoidErgodic`, `Entropy`, `PositiveEntropy`, `ZeroEntropyNames`, `ChainAtTA`, `Pieces`, `EntropySplitMax`, `Proofs`.
443 s; peak 5.20 GiB summed, 3.59 GiB for one process (`logs/build-1.times`). Every warning is `declaration uses 'sorry'`.

**My six modules' compiled files are the ones the build found**: the `.olean` checksums of `DualGroup`, `Annihilator`,
`SubgroupHaar`, `Duality`, `DualConnected`, `UnitCircle` (and `Pieces`, which was recompiled to the same bytes) are
identical before and after build 1; `EntropySplitMax`'s changed, as its import `ChainAtTA` did
(`logs/olean-before-build1.sha256`, `logs/olean-after-build1.check`).

### 1.2 The quotations (standing rule 3)

`tools/fs131_idg1_quotes.py` (FS131-IN1L's checker, aimed at this brief) checks each `> ` run of the brief against its
source on the main checkout, byte for byte. **All five match** (`logs/quotes.out`, exit 0): W2 in
`data/fs131/REQUEST-2026-10-13.md`; the two dated lines in `data/fs131/claims-NF2.md`; inventory items 770 and 775 in
`plans/FS131-close-inventory.md`. **The planted control** changes one digit in each quotation and requires each to
mismatch: "plant fires" five times (`logs/quotes-plant.out`, exit 0). No finding about the brief.

### 1.3 The leaves, each restated in one line beside its plan

**Lane D** — `Rigidity/DualGroup`, 13 leaves (plan: `plans/FS131-KN8-chain-split.md` § 2.5, items 1–13; item 757 for 8 and 9).
`Ĝ = AddChar G Circle`, topology induced by `χ ↦ (g ↦ (χ g : ℂ))`.

| leaf | the statement, in one line | the plan's route |
|---|---|---|
| `isClosedEmbedding_coe` | `χ ↦ (g ↦ χ g)` is a closed embedding `Ĝ → (G → ℂ)` | inducing by definition; injective by `AddChar.ext`; the range is cut out by closed equations |
| `isTopologicalGroup_dual` | `Ĝ` is a topological group | coordinates of `χψ` and `χ⁻¹` through `continuous_induced_rng` |
| `compactSpace_dual` | `Ĝ` is compact | the range is closed inside the compact product of unit circles |
| `polishSpace_dual` | `[Countable G]`: `Ĝ` is Polish | `IsClosedEmbedding.polishSpace` |
| `borelSpace_dual` | `[Countable G]`: Borel σ-algebra = the cylinder σ-algebra | `borel_comap`, `Pi.borelSpace` |
| `standardBorelSpace_dual` | `[Countable G]`: the cylinder σ-algebra is standard Borel | from the two above |
| `exists_apply_ne_one` | `r ≠ 0 → ∃ ψ, ψ r ≠ 1` | a character into `ℚ/ℤ` (`CharacterModule`), carried injectively into the circle |
| `measure_eq_of_fourier` | `[Countable G]`: finite measures with equal Fourier coefficients are equal | the evaluations span a point-separating star subalgebra of `Ĝ →ᵇ ℂ`; `ext_of_forall_mem_subalgebra_integral_eq_of_polish` |
| `isProbabilityMeasure_dualHaar` | `dualHaar G` is a probability | `haarMeasure_self` at `⊤` |
| `isHaarFourier_dualHaar` | `dualHaar G`'s coefficients vanish off `0` | left invariance against `ψ` with `ψ r ≠ 1` |
| `isHaarFourier_iff` | `IsHaarFourier m ↔ m = dualHaar G` | Fourier uniqueness, coefficients split at `r = 0` |
| `IsHaarFourier.map_dual` | the dual of an injective endomorphism keeps `IsHaarFourier` | `integral_map`; `φ r ≠ 0` |
| `IsHaarFourier.map_mul_right` | translation keeps `IsHaarFourier` | `integral_evalChar_map_mulRight` |

**Lane PD-I** — the four duality modules, 29 `sorry`s (plan: `plans/FS131-KPD1-pontryagin.md` § 4.1; the proofs in the
planner's copies `data/fs131/kpd1/route/`).

| module | leaves (`sorry` in the skeleton), each in one line | the plan |
|---|---|---|
| `Annihilator` (9) | `le_dualAnnihilator_iff` (`Y ≤ N^⊥ ↔ N ≤ Y^⊥`); `dualCoannihilator_dualAnnihilator_dualCoannihilator` (`((Y^⊥)^⊥)^⊥ = Y^⊥`); `dualAnnihilator_bot` (`⊥^⊥ = ⊤`); `dualCoannihilator_bot` (`⊥^⊥ = ⊤` on `G`); `dualCoannihilator_top` (`Ĝ^⊥ = 0`, separation); `isClosed_setOf_apply_eq_one` (`{χ \| χ g = 1}` closed); `isClosed_dualAnnihilator` (`N^⊥` closed); `dualCoannihilator_topologicalClosure` (a subgroup and its closure have one annihilator); `finite_dualAnnihilator` (`G ⧸ N` finite ⇒ `N^⊥` finite) | the route copy |
| `SubgroupHaar` (6) | `isProbabilityMeasure_subgroupHaar`; `subgroupHaar_compl` (lives on `Y`); `subgroupHaar_pos` (charges open sets meeting `Y`); `integral_subgroupHaar_of_mem` (coefficient `1` on `Y^⊥`); `integral_subgroupHaar_of_not_mem` (`0` off it); **`subgroupHaar_bot`** (spec: `subgroupHaar ⊥ = dirac 1`) | the route copy; the spec leaf by § 4.1 item 3 |
| `Duality` (10) | `dualAnnihilator_dualCoannihilator` (`(Y^⊥)^⊥` is the closure); `eq_top_of_isClosed_of_dualCoannihilator_eq_bot` and its `'` form (closed with trivial annihilator ⇒ `⊤`); `evalDualHom_injective`; `graphSubgroup`'s three closure fields (one, product, inverse); `isClosed_graphSubgroup`; `exists_mem_dualCoannihilator_graphSubgroup` (some `(g, 1)` in the graph's annihilator); `evalDualHom_surjective` (D1) | the route copy |
| `DualConnected` (4) | `surjective_compAddMonoidHom` (restriction along an injection is onto); `exists_pow_eq` (torsion-free `G` ⇒ `Ĝ` divisible); `connectedSpace_dual` (D3); **`not_connectedSpace_dual_zmod_two`** (the negative partner) | the route copy; the spec leaf by § 4.1 item 4 |

**Lane U** — `Rigidity/UnitCircle`, 7 leaves, all but `exists_admissiblePair` (plan: KN8 § 2.5, `Rigidity/UnitCircle` items 1–6).

| leaf | the statement, in one line | the plan's route |
|---|---|---|
| `uvRing_toUnitVector_mul` | `uvRing (toUnitVector (g h)) = uvRing (toUnitVector g) · uvRing (toUnitVector h)` | `Subtype.ext`, `Circle.coe_mul` |
| `uvRing_toUnitVector_one` | `uvRing (toUnitVector 1) = 1` | `Circle.coe_one` |
| `rotInv_iff` | `RotInv F τ ↔ ∀ g, τ.map (g • ·) = τ` | `smul_def`; `unitCircleEquiv` onto |
| `countable_unitCircle` | `[NumberField F]`: `unitCircle F` is countable | injects into the countable `unitRing F` |
| `IsHaarFourier.rotInv` | `[NumberField F]`: a Haar measure in Fourier form is `RotInv` | `rot u` is the dual of `mulLeft u`, injective; `map_dual_eq` |
| `AdmissiblePair.u_nonTorsion` | `u^k ≠ 1` for `k ≠ 0` | `zpowHom` injective at `![k, 0]` |
| `AdmissiblePair.ofPow`'s `generates` | the values on a finite-index `Λ` generate `F(i)` | `Λ.index • ![0, 1] ∈ Λ`, `hw` at the index |

### 1.4 The stored statements before any edit

`data/fs131/idg1/lean/StatementDump.lean` is FS131-IN1L's dumper aimed at my six modules **and their two importers**
`Rigidity/Pieces` and `Rigidity/EntropySplitMax` (not mine; dumped so that an import line I add upstream is seen to move
none of their stored terms). It adds two things: a `PROPTYPE` flag (the stored type is a proposition — a proof, whose
value is not compared), and for every definition of a non-proposition a `DATA` line, the value with every proof subterm
erased, because two definitions of my files hold proofs as structure fields that are leaves of this job
(`AdmissiblePair.ofPow`'s `generates`, `Duality.graphSubgroup`'s three closure fields; `LEAN.md`, FS124-I3's line). It ran
on the built tree after build 1 (which recompiled none of my six, § 1.1) and before any edit:
`data/fs131/idg1/statements-before.txt.xz` (committed compressed; `xz -dk` restores the 5.9 MB text), 238 constants —
`DualGroup` 25, `Annihilator` 26, `SubgroupHaar` 11, `Duality` 32, `DualConnected` 4, `UnitCircle` 56, `Pieces` 74,
`EntropySplitMax` 10. The modules declare no axiom. Every `instance` of a `Prop`-valued class is stored as a theorem. Two
stored values hold `sorryAx`, exactly the two ruled definitions; neither `DATA` line does.

The reader is `tools/fs131_idg1_statements.py`. **Against itself:** PASS — 154 named constants (kinds and types), 37
data definitions' values, 2 ruled definitions' data views, 5 example heads (`logs/statements-self.out`). **Its control**
plants eight faults and all 8 are reported, "the check can fail" (`logs/statements-control.out`): a changed stored type, a
changed definition value, a missing leaf, a theorem made a definition, a new public constant off the allow-list, an axiom,
a moved data field of a ruled definition (`ofPow`'s `u` and `w` swapped), and a changed statement in the downstream
`Pieces`.

## Stage 2 — SAVED: lane D proved (`Rigidity/DualGroup`, 13 leaves), through build 2

**Written in a copy first** (`data/fs131/idg1/work/DualGroup.lean`, while build 1 walked; `LEAN.md`, FS124-I5's line):
three elaborations under `data/fs131/idg1/lean1.sh` (`logs/lean-dg-1.log` … `lean-dg-3.log`; the third exit 0, 10 s, no
`sorry`), about 40 minutes from the first line. The copy differs from the skeleton only in proofs: `diff` shows the 13
`sorry` lines and four proof heads (`:= by` → `:=` or `where`) removed, nothing else of the skeleton's text. Every leaf
went by the plan's route (KN8 § 2.5), with one private definition or lemma where the route needed a name:

- `isClosedEmbedding_coe`: `⟨⟨⟨rfl⟩, injective⟩, closed range⟩`; the range is `{f 0 = 1} ∩ ⋂ {f (g+h) = f g f h} ∩ ⋂
  {‖f g‖ = 1}`, each closed set a `have` of its own (one `refine` over all three timed out at `isDefEq`).
- `isTopologicalGroup_dual`: coordinates through `continuous_induced_rng`, `AddChar.mul_apply`, `AddChar.inv_apply'`,
  `Circle.coe_inv_eq_conj`.
- `compactSpace_dual`: the range inside `univ.pi (sphere 0 1)`, `IsInducing.isCompact_iff`.
- `polishSpace_dual`: `IsClosedEmbedding.polishSpace`. `borelSpace_dual`: `borel_comap` and
  `BorelSpace.measurable_eq (α := G → ℂ)`. `standardBorelSpace_dual`: `inferInstance`.
- `exists_apply_ne_one`: `CharacterModule.exists_character_apply_ne_zero_of_ne_zero`, then the private
  `exists_ratCircle` — `ℚ/ℤ → Additive Circle`, `q ↦ exp(2πiq)` by `QuotientAddGroup.lift`, with trivial kernel by
  `Circle.exp_eq_one`.
- `measure_eq_of_fourier`: the private `evalBCF r` (evaluation as a bounded continuous function, `mkOfCompact`) and
  `fourierAlg` — **a star subalgebra whose carrier is the span of the evaluations**, closed under products by a double
  `Submodule.span_induction` (`evalBCF (r + s) = evalBCF r * evalBCF s`), under `star` (`star (evalBCF r) =
  evalBCF (-r)`), containing `1 = evalBCF 0`. Integrals agree on it by one span induction; separation is
  `AddChar.ext`; `ext_of_forall_mem_subalgebra_integral_eq_of_polish` concludes. The plan's `StarAlgebra.adjoin` is not
  needed: the span is already the algebra.
- `isProbabilityMeasure_dualHaar`, `isHaarFourier_dualHaar` (left invariance against `ψ` with `ψ r ≠ 1`),
  `isHaarFourier_iff` (Fourier uniqueness split at `r = 0`), `IsHaarFourier.map_dual` (`integral_map`,
  `map_ne_zero_iff`), `IsHaarFourier.map_mul_right` (`integral_evalChar_map_mulRight`).

**Re-price** (Done means item 2, from the first two leaves): `isClosedEmbedding_coe` and `isTopologicalGroup_dual`
took two of the three iterations between them, minutes each, and the hard leaf, Fourier uniqueness, one iteration —
the module about 40 minutes against KN8's plan, which did not price it in hours; what was left (PD-I and U) was then
priced at under an hour each, and took about 20 minutes of writing between them (stages 3 and 4).

**Build 2** (`data/fs131/idg1/build.sh 2 8`, all three lanes folded in): `==> build: OK — 249 of 249 batches, 9
module(s) rebuilt, 6 module(s) with warnings, 7m57s`, `exit=0` (`logs/build-2.log`; full output
`build/gate/build/20261014T063909Z-1993210.log`). Rebuilt: my six, `Pieces`, `EntropySplitMax`, `Proofs`; 482 s, peak
3.45 GiB for one process (`build-2.times`). **The only warning from my six files is `UnitCircle.lean:219`,
`exists_admissiblePair`'s `sorry` (lane A's leaf, not mine)**; the other 27 are `declaration uses 'sorry'` in `Pieces`,
`EntropySplitMax`, `PositiveEntropy` and `Entropy`, none of them mine.

**No statement changed, from the kernel's side** (`tools/fs131_idg1_statements.py statements-before.txt
statements-after-2.txt 3b531d1d2`, `logs/statements-compare-2.out`): PASS — 154 named constants of the eight modules
(kinds and types), 37 data definitions' values, the 2 ruled definitions' data views, 5 `example` heads, all the same;
**no new public constant**; 7 new private constants, all `DualGroup`'s (`evalBCF`, `evalBCF_apply`, `evalBCF_add`,
`evalBCF_zero`, `star_evalBCF`, `fourierAlg`, `exists_ratCircle`); internal names 84 → 115, not compared; no axiom.
The two ruled definitions read `RULED PROOF FIELD`: `Duality.graphSubgroup` and `AdmissiblePair.ofPow`, values moved
with their proof fields, data fields the same. **The control on the same two dumps** plants the eight faults of stage 1
and all 8 are reported (`logs/statements-compare-2-control.out`).

**Axioms, from the built tree** (`data/fs131/idg1/lean/Axioms.lean` → `axioms-after-2.txt`, read by
`tools/fs131_idg1_axioms.py`; `logs/axioms-check-2.out`): PASS. 111 records of the six modules (`DualGroup` 31,
`Annihilator` 18, `SubgroupHaar` 8, `Duality` 17, `DualConnected` 4, `UnitCircle` 33), private helpers included: **110 on
the standard three or fewer**, and `exists_admissiblePair` on those and `sorryAx`, its `sorry` its own. None rests on the
declared printed theorem. The planted record (`positive_entropy_rigidity_of_polishSpace`, on the declared theorem) is
reported. **The control** plants `sorryAx` in `measure_eq_of_fourier`, the declared theorem in `connectedSpace_dual`
and a downstream record whose `sorry` comes from `isClosedEmbedding_coe`: 3 of 3 reported
(`logs/axioms-check-2-control.out`).

**What the downstream modules now wait on** (the same print, `DOWNSTREAM` rows; not mine): of `Pieces`' and
`EntropySplitMax`'s 44 records, 21 rest on no `sorry`, and the `sorry` of the other 23 comes only from those two
modules' own leaves (`IsPiece.mulR_mem`, `pieceMul_zero`, `pieceMul_add`, `PieceDual.continuous_dualMap`,
`isSolenoid_pieceDual`, `isTotallyIrreducible_pieceAction`, …, `condExpKernel_ergodicDecomposition`,
`rotInv_sub_maxMultiple`), **none from a declaration of my six files**.

## Stage 3 — SAVED: lane PD-I proved (`Annihilator`, `SubgroupHaar`, `Duality`, `DualConnected`), through build 2

**The route copies folded in.** `data/fs131/kpd1/route/{Annihilator,SubgroupHaar,Duality,DualConnected}.lean` copied to
`data/fs131/idg1/work/`, then over the modules. Against the skeletons each removes only `sorry` lines and four proof
heads of `Annihilator` (`:= by` → `:=`): checked by `diff`, nothing else of the skeleton's text moves. The planner's
docstring difference in `Annihilator` (`isClosed_setOf_apply_eq_one`'s) is not there: the texts are identical.

**The two spec leaves** (KPD1 § 4.1 items 3 and 4), written in the copies (`logs/lean-sh-1.log`, `lean-dc-1.log`; exit 0):
- `subgroupHaar_bot` (`subgroupHaar ⊥ = dirac 1`): the plan's route — `ext s hs`, `Measure.map_apply`,
  `Measure.dirac_apply'`; every `y : ↥⊥` is `1` (`Subgroup.mem_bot`), so the preimage is `univ` or `∅` as `1 ∈ s` or
  not; `Set.indicator_of_mem` / `indicator_of_notMem`.
- `not_connectedSpace_dual_zmod_two`: every `χ` has `χ(1)·χ(1) = χ(1 + 1) = 1`, so `χ 1 = ±1` (`mul_self_eq_one_iff`);
  separation gives `χ₁` with `χ₁ 1 = −1`; the real part of `χ 1` is continuous, `≤ 0` at `χ₁` and `≥ 0` at `1`, so
  `intermediate_value_univ` gives a `χ` with real part `0` — against `±1`.

**The stored terms against the dumps** (build 2; stage 2's comparison covers these four modules): no stored type moved,
the data definitions' values (`dualAnnihilator`, `dualCoannihilator`, `subgroupHaar`, `evalDualHom`, `extendByPow`,
`dualDualEquiv`, `additiveDualDualEquiv`) are the same, and `graphSubgroup`'s data field is the same while its three proof
fields are now proved (the ruled difference KPD1 § 4.1 item 5 names). **`Rigidity/Pieces` against the planner's own dump**
(`data/fs131/kpd1/dump/pieces-after.txt`, taken after its re-pointing): all 74 constants identical in kind, type and
value to this job's dump after build 2 (`logs/pieces-vs-planner.out`). **KPD1's expectation is met**: D2
(`dualAnnihilator_dualCoannihilator_of_isClosed`, its closure form, the case and its additive form), D1
(`evalDualHom_surjective`, `dualDualEquiv`, `additiveDualDualEquiv`), D3 (`connectedSpace_dual`) and
`finite_dualAnnihilator` all rest on the standard three (stage 2's axiom print).

## Stage 4 — SAVED: lane U proved (`Rigidity/UnitCircle`, 7 of its 8 leaves), through build 2

Written in a copy (`logs/lean-uc-1.log`, one error; `lean-uc-2.log`, exit 0, the one warning `exists_admissiblePair`'s
`sorry`), by KN8 § 2.5's routes:
- `uvRing_toUnitVector_mul`, `_one`: `Subtype.ext`, a `show` of the coerced equation, `Subgroup.coe_mul`,
  `Circle.coe_mul` / `OneMemClass.coe_one`, `Circle.coe_one`.
- `rotInv_iff`: `→` at `toUnitVector g`; `←` through `(unitCircleEquiv F).surjective`.
- `countable_unitCircle`: `Function.Injective.countable` into `unitRing F` (countable by
  `countable_unitRing_of_numberField`).
- `IsHaarFourier.rotInv`: `uvRing u ≠ 0` (its norm is `1`), so `mulLeft (uvRing u)` is injective
  (`mul_left_cancel₀`), and `IsHaarFourier.map_dual_eq` — `rot u` is by definition the dual of `mulLeft`.
- `AdmissiblePair.u_nonTorsion`: `u^k = 1` in `unitCircle F` (coercions injective), so `zpowHom` takes `![k, 0]` to `1`;
  injectivity and the first coordinate give `k = 0`.
- `AdmissiblePair.ofPow`'s `generates`: `≤` by `Subfield.closure_le` (each value is a point of `unitCircle F`); `≥`:
  `hw` at `Λ.index` (positive by `FiniteIndex.index_ne_zero`), and `w ^ Λ.index` is the value at `Λ.index • ![0, 1] ∈ Λ`
  (`AddSubgroup.nsmul_index_mem`), so `closure {w ^ Λ.index} ≤ closure (image)`.

**Not mine and untouched:** `exists_admissiblePair` (lane A). Its print rests on `sorryAx`, its own; nothing of the six
files reads it.
