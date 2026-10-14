# FS131-IDG1 — the five-colour chain: the dual group (D), Pontryagin duality (PD-I) and the unit circle (U), proved

*The chain's third implementer (brief `data/fs131/briefs/FS131-IDG1-dual-group.md`, written 2026-10-14 06:22 UTC).
Branch `fs131-wdg` in the worktree `.claude/worktrees/fs131-wq1`, cut from `fs131-wpd` at `c138bbafd`; not pushed (the
brief: the remote is unreachable). Working files under `data/fs131/idg1/`; checks `tools/fs131_idg1_*.py`.*

## Theorems this phase proved

Every line is [kernel], on exactly `[propext, Classical.choice, Quot.sound]` ("the standard three"), printed from the
built tree after build 3 by `data/fs131/idg1/lean/Axioms.lean` (`data/fs131/idg1/axioms-after.txt`, read by
`tools/fs131_idg1_axioms.py`: 110 of the six modules' 111 records on the standard three, the 111th lane A's leaf).
Namespace `HadwigerNelson.Rigidity` unless written in full.

**Lane D — `Rigidity/DualGroup`** (the dual `Ĝ = AddChar G Circle` of a discrete abelian group, pointwise topology):
- `isClosedEmbedding_coe` — `χ ↦ (g ↦ χ g)` is a closed embedding into `G → ℂ` — standard three
- `isTopologicalGroup_dual` — `Ĝ` is a topological group — standard three
- `compactSpace_dual` — `Ĝ` is compact — standard three
- `polishSpace_dual` — Polish, for countable `G` — standard three
- `borelSpace_dual` — the Borel σ-algebra is the library's cylinder σ-algebra, for countable `G` — standard three
- `standardBorelSpace_dual` — standard Borel, for countable `G` — standard three
- `exists_apply_ne_one` — the characters separate the points of `G` — standard three
- `measure_eq_of_fourier` — **Fourier uniqueness**: finite measures on `Ĝ` with equal Fourier coefficients are equal,
  countable `G` — standard three
- `isProbabilityMeasure_dualHaar` — Haar measure `dualHaar G` is a probability — standard three
- `isHaarFourier_dualHaar` — its Fourier coefficients vanish off `0` — standard three
- `isHaarFourier_iff` — `IsHaarFourier m ↔ m = dualHaar G` — standard three
- `HadwigerNelson.SpectralInputs.IsHaarFourier.map_dual` — the dual of an injective endomorphism keeps it — standard three
- `HadwigerNelson.SpectralInputs.IsHaarFourier.map_mul_right` — translation keeps it — standard three

**Lane PD-I — Pontryagin duality** (the planner's route copies, folded in, and its two spec leaves):
- `Rigidity/Annihilator`: `le_dualAnnihilator_iff`, `dualCoannihilator_dualAnnihilator_dualCoannihilator`,
  `dualAnnihilator_bot`, `dualCoannihilator_bot`, `dualCoannihilator_top`, `isClosed_setOf_apply_eq_one`,
  `isClosed_dualAnnihilator`, `dualCoannihilator_topologicalClosure`, `finite_dualAnnihilator` — each standard three
- `Rigidity/SubgroupHaar`: `isProbabilityMeasure_subgroupHaar`, `subgroupHaar_compl`, `subgroupHaar_pos`,
  `integral_subgroupHaar_of_mem`, `integral_subgroupHaar_of_not_mem`, `subgroupHaar_bot` (spec) — each standard three
- `Rigidity/Duality`: `dualAnnihilator_dualCoannihilator` (D2 for every subgroup: the closure),
  `eq_top_of_isClosed_of_dualCoannihilator_eq_bot`, `eq_top_of_isClosed_of_dualCoannihilator_eq_bot'` (D2's case),
  `evalDualHom_injective`, `Duality.graphSubgroup`'s three closure fields, `Duality.isClosed_graphSubgroup`,
  `Duality.exists_mem_dualCoannihilator_graphSubgroup`, `evalDualHom_surjective` (**D1**) — each standard three
- `Rigidity/DualConnected`: `surjective_compAddMonoidHom`, `exists_pow_eq`, `connectedSpace_dual` (**D3**),
  `not_connectedSpace_dual_zmod_two` (the negative partner) — each standard three

**Lane U — `Rigidity/UnitCircle`** (all but `exists_admissiblePair`): `uvRing_toUnitVector_mul`,
`uvRing_toUnitVector_one`, `rotInv_iff`, `countable_unitCircle`, `HadwigerNelson.SpectralInputs.IsHaarFourier.rotInv`,
`AdmissiblePair.u_nonTorsion`, `AdmissiblePair.ofPow`'s `generates` field — each standard three.

**Consequences** — already proved, they had rested on `sorryAx` through these leaves and now rest on the standard
three: **D2** `dualAnnihilator_dualCoannihilator_of_isClosed` (a closed subgroup of `Ĝ` is the annihilator of its
annihilator, countable `G`), `dualDualEquiv` and `additiveDualDualEquiv` (`G ≅ (Ĝ)^`), `integral_subgroupHaar_eq`,
`IsHaarFourier.map_dual_eq`, `IsHaarFourier.map_mul_right_eq`, `exists_isHaarFourier_of_countable` (a Haar measure in
Fourier form exists at every countable `G` with no Herglotz–Bochner), the instances `t2Space_dual`,
`secondCountableTopology_dual`, `isHaarMeasure_dualHaar`, and `instMulActionDual`, `measurableConstSMul_dual`.

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
took two of the three iterations between them, minutes each, and the hard leaf (Fourier uniqueness, KN8 § 5.1's "the
hard one") one iteration: the module took about 40 minutes. What was left, PD-I and U, I then priced at under an hour
each; they took about 20 minutes of writing between them (stages 3 and 4), with the build shared.

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

## Stage 5 — SAVED: the architecture cell and the docstrings, build 3, the checks from the built tree

**`ARCHITECTURE.md`** (FS131-IN1L's drafts, its record § Drafts for the landing): the imports cell of
`Rigidity/ZeroEntropyNames` reads `` `Rigidity/Entropy`, `Outside/OAI015Maximal` ``; the rows of `ZeroEntropyNames`,
`HaarMultiple` and `SolenoidErgodic` read "proved by FS131-IN1L: no `sorry`", their leaves "Proved (FS131-IN1L)"; the
row of `ChainAtTA` moves `measurableSet_TA`, `rot_preimage_TA`, `exists_nonTorsion_unitVector` to its proved list, adds
`rotInv_dirac_one` and `zeroEntropyCarried_model`, and keeps three leaves (`entropySplit`, `zeroEntropyCarried`,
`noRamifiedStableDyadic_of_tca`). **`tools/check_architecture.py`: `RESULT: PASS`** (`logs/arch-1.out`). **Its
control**: the same check on a copy of the file as it was before the edit (`data/fs131/idg1/work/ARCHITECTURE.before.md`)
fails with exactly the cell IN1L reported, `FAIL imports of Rigidity/ZeroEntropyNames: stated-only [], real-only
['Outside/OAI015Maximal']` (`logs/arch-plant-before.out`, exit 1). The rows of my own six modules still say "skeleton";
they are outside my touches, and their new text is drafted below.

**The stale module docstrings IN1L named** (prose only; `data/fs131/idg1/work/docstrings.py`, which refuses unless each
passage occurs once inside the module docstring): the titles of `HaarMultiple`, `SolenoidErgodic` and
`ZeroEntropyNames` ("skeleton" → "proved by FS131-IN1L"); `ChainAtTA`'s title, its "Leaves" paragraph (the three
proved leaves moved to a "Proved by FS131-IN1L" line) and its "Inhabitants" paragraph (`zeroEntropyCarried_model`
named); `ZeroEntropyNames`' "not yet joined; at the join its proof is that theorem" (now: its proof is the port's
`Outside.OAI015.excessiveOccupation_measure_bound`). **Shown prose-only twice** (`LEAN.md`, FS131-LC1's line):
- *in text*: `tools/fs131_idg1_code_only.py` (FS131-LC1's tool) reads all four files SAME as `HEAD` with every block
  comment removed (`logs/code-only.out`). **Its plant had to be repaired**: FS131-LC1's plant turns the first `:=` into
  `:≡`, and in three of these four files the first `:=` is inside a docstring — the planted run read those three SAME
  and the control failed ("plant: FAIL (3)"). The plant now takes the last `:=`, which is code in each file; all four
  read DIFFERS (`logs/code-only-plant.out`, "plant: OK").
- *from the kernel's side*: `data/fs131/idg1/lean/DocDump.lean` dumped the four modules before build 3 and after
  (`docdump-before.txt`, `docdump-after.txt`): **all 183 constants identical, line for line**, internal ones and
  proofs included (`tools/fs131_idg1_docdump_diff.py`, `logs/docdump-compare.out`); its control plants a changed type,
  a removed constant and an added one, and all 3 are reported (`logs/docdump-compare-control.out`).
- The theorem docstring of `measure_frequentVisits_le` ("stated under this library's name until lane P's port is
  joined") is stale too; it is not a module docstring, so it is drafted below, not edited.

**Build 3** (`data/fs131/idg1/build.sh 3 8`): `==> build: OK — 249 of 249 batches, 6 module(s) rebuilt, 6 module(s)
with warnings, 7m12s`, `exit=0` (`logs/build-3.log`; full output `build/gate/build/20261014T065208Z-2043900.log`;
435 s, peak 3.91 GiB for one process). Rebuilt: the four docstring modules, `EntropySplitMax`, `Proofs`. **From my
six files one warning, `UnitCircle.lean:219:8`, `exists_admissiblePair`'s `sorry`**; every other warning is a
`declaration uses 'sorry'` in `ChainAtTA` (its three leaves, not mine), `Pieces`, `EntropySplitMax`, `PositiveEntropy`
or `Entropy`. No `sorry` in my six files but that leaf's (`grep`: `UnitCircle.lean` 1, the other five 0).

**From the built tree after build 3:**
- *Statements*: `tools/fs131_idg1_statements.py statements-before.txt statements-after.txt 3b531d1d2`: **PASS** — as
  at build 2: no stored type moved in the eight modules, no data definition's value moved, the two ruled proof fields
  only, no new public constant, 7 private helpers, no axiom (`logs/statements-compare.out`); the control, 8 of 8
  (`logs/statements-compare-control.out`). **No unread binder** was found in my six files: the build's
  `unusedVariables` warns of none, and the lint's `unusedArguments` passes — so nothing was dropped by item 726's word,
  and the reader's `--dropped` list is empty.
- *Axioms*: `tools/fs131_idg1_axioms.py axioms-after.txt`: **PASS**, 110 records on exactly the standard three, the
  111th `exists_admissiblePair` (its own `sorry`); the planted record reported; the control 3 of 3
  (`logs/axioms-check.out`, `axioms-check-control.out`). The print is byte-identical to build 2's.
- *Linters*: `lake lint --no-build -- --no-build --trace` under the slot: `exit=0`, `-- Linting passed for Proofs.`,
  14 linters `(2/2) Passed!` (`logs/lint-1.log`). **Its control**: `DualGroup.lean` copied to the ignored
  `build/fs131-idg1/lint/` with `#lint` appended reads "Found 0 errors in 23 declarations" (`logs/lint-control-Green.log`);
  the same copy with a planted `theorem planted_unused_countable (G) [AddCommGroup G] [Countable G] : True` fails,
  `unusedArguments` naming it and both instance arguments (`logs/lint-control-Red.log`, exit 1).
- *Doubled names on the joined tree* (`./scripts/dupnames.sh` under the slot): `OK — no name is declared by two
  modules (24 generated on demand)`, `exit=0` (`logs/dupnames-1.log`); the two names it lists as gone since this tree's
  previous scan are `SixRing.chart.eq_1` and `SixRing.ringRadius.eq_1`, generated equation lemmas of `Plane/`, not
  from my files.
- *Spec examples*: every `example` of the six files elaborates in each build (`DualGroup`'s `dualHaar ℤ` probability,
  `Annihilator`'s `N = ⊤`, `Duality`'s two, `DualConnected`'s `ℤ`), and their heads are unchanged (the statement
  reader's text side, 5 heads).

The whole-library gate steps — `scripts/axioms.sh` with the CLEAN block below, `vacuity.sh`, `assumptions.sh` and
their counts — belong to the landing that joins the chain to `main`, as for FS131-IN1L; I ran none of them.

## Drafts for the landing

### `scripts/Axioms.lean` — the CLEAN block

`data/fs131/idg1/audit-block.lean`, generated from the built tree (build 3's axiom print) by
`tools/fs131_idg1_audit_block.py` (FS131-IN1L's generator; it also leaves out what `structure` generates beside the
fields — `casesOn`, `noConfusion`, `mk.injEq`, …): **91 `#print axioms` lines**, every public record of the six
modules on the standard three, Lean's generated names left out. `exists_admissiblePair` (on `sorryAx`, lane A's leaf) is
listed in a comment and left out. **Slot:** the end of CLEAN, just above the PURCHASED banner, with the chain's other
modules (FS131-IN1L's block, `data/fs131/in1l/audit-block.lean`) when they land.

### `ARCHITECTURE.md` § 3, the rows of my six modules (outside my touches)

- `Rigidity/DualGroup`: "**FS-131 (FS131-KN8), skeleton: 13 leaves `sorry`.**" → "**FS-131 (FS131-KN8, proved by
  FS131-IDG1): no `sorry`.**"
- `Rigidity/Annihilator`: "**FS-131 (FS131-KPD1), skeleton: 8 leaves `sorry`.**" → "**FS-131 (FS131-KPD1, proved by
  FS131-IDG1): no `sorry`.**"; "**Leaves:**" → "**Proved (FS131-IDG1):**", and `isClosed_setOf_apply_eq_one` added to
  that list after `dualCoannihilator_top` (separation) — **the row is stale on this one**: the skeleton holds 9 `sorry`s,
  `isClosed_setOf_apply_eq_one` among them, and the row counts 8 and does not name it.
- `Rigidity/SubgroupHaar`, `Rigidity/Duality`, `Rigidity/DualConnected`: "skeleton: 6 / 9 / 4 leaves `sorry`." →
  "proved by FS131-IDG1: no `sorry`." inside the bold head (as above); "**Leaves:**" → "**Proved (FS131-IDG1):**"
  (DualConnected: "**Leaves:** all four." → "**Proved (FS131-IDG1):** all four.").
- `Rigidity/UnitCircle`: "**FS-131 (FS131-KN8), skeleton: 8 leaves `sorry`.**" → "**FS-131 (FS131-KN8; proved by
  FS131-IDG1 but lane A's `exists_admissiblePair`), skeleton: 1 leaf `sorry`.**"

The imports cells are right as they stand (`tools/check_architecture.py` PASS).

### Module and theorem docstrings now stale (prose only)

- **My six modules' titles** say "skeleton": `Rigidity/DualGroup` ("…; module M4 of `plans/FS131-KN3-chain-plan.md`;
  skeleton)"), `Annihilator`, `SubgroupHaar`, `Duality`, `DualConnected` ("…; job FS131-KPD1; skeleton)") and
  `UnitCircle` ("…; the vocabulary of modules M6 and M7b; skeleton)") → "proved by FS131-IDG1" (UnitCircle: "proved by
  FS131-IDG1 but `exists_admissiblePair`"). `Annihilator`'s docstring says "**The converse `(Y^⊥)^⊥ ≤ Y` for closed `Y`
  is Pontryagin duality** (`Rigidity/Duality`), not proved here" — true of the module, and now proved there.
- **`Rigidity/ZeroEntropyNames`, `measure_frequentVisits_le`'s docstring**: "stated under this library's name until
  lane P's port is joined; its proof is then that theorem (module docstring)" → "stated under this library's name; its
  proof is the port's `Outside.OAI015.excessiveOccupation_measure_bound` (module docstring)". Not a module docstring,
  so not in my touches.
- A docstring edit recompiles the module's importers (`LEAN.md` § Building): `DualGroup`'s is under all five others,
  `Pieces`, `EntropySplitMax` and `Proofs`.

### Models of the hypotheses, for the landing's reading

The vacuity scan has no tracked carrier among these modules' binders (no colouring), so it will be silent on them;
each structure of hypotheses, its kernel model, and whether the library holds it:

| statement(s) | hypotheses | model | in the library? |
|---|---|---|---|
| `measure_eq_of_fourier` | `[Countable G]`, `σ`, `σ'` finite, equal coefficients | `G = ℤ`, `σ = σ' = dualHaar ℤ` | **no** — draft below |
| `isHaarFourier_iff`, `IsHaarFourier.map_mul_right(_eq)` | `IsHaarFourier m` | `dualHaar G` (`isHaarFourier_dualHaar`, now standard three) | yes: `exists_isHaarFourier_of_countable` |
| `IsHaarFourier.map_dual(_eq)` | `IsHaarFourier m`, `φ` injective | `dualHaar ℤ`, `n ↦ 2n` | **no** — draft below |
| `exists_apply_ne_one` | `r ≠ 0` | `G = ℤ`, `r = 1` (the `ZMod 2` case is used in `not_connectedSpace_dual_zmod_two`) | yes, inside that proof |
| `finite_dualAnnihilator` | `[Finite (G ⧸ N)]` | `N = ⊤` (the module docstring's model) | **no** term — draft below |
| `subgroupHaar` and its four facts | `[CompactSpace Y]` | `Y = ⊥` | yes: `subgroupHaar_bot` |
| `subgroupHaar_pos` | `U` open, `U ∩ Y` non-empty | `U = univ`, `Y = ⊥` | **no** — draft below |
| `integral_subgroupHaar_eq` | `Y^⊥ = Z^⊥` | `Z = (Y^⊥)^⊥` (D2's own use) | yes, inside `dualAnnihilator_dualCoannihilator_of_isClosed` |
| D2 and its case | `Y` closed (with `Y^⊥ = ⊥`) | `Y = ⊤`; and a closed subgroup neither `⊥` nor `⊤`, `(2ℤ)^⊥` | yes: `Duality`'s `example` (`⊤`); `(2ℤ)^⊥` drafted below |
| `surjective_compAddMonoidHom` | `f` injective | `n ↦ 2n` on `ℤ` | **no** — draft below |
| `exists_pow_eq`, `connectedSpace_dual` | `[IsAddTorsionFree G]` | `G = ℤ` | yes: `DualConnected`'s `example`; the negative partner shows the hypothesis needed |
| `countable_unitCircle`, `IsHaarFourier.rotInv` | `[NumberField F]` | `F = ⊥` (`Instances.UpperHalfValues.instNumberFieldBot`, downstream) | yes, downstream |
| `AdmissiblePair.u_nonTorsion`, `AdmissiblePair.ofPow` | an admissible pair; `hinj`, `hw` | at `ℚ`, `u = (3 + 4i)/5`, `w = (5 + 12i)/13` (UnitCircle's docstring) | **no: open in the kernel** — it is `exists_admissiblePair`, lane A's leaf. The local hypotheses alone: `hinj` and `hw` together are that leaf's content at one `F`; no object of the library satisfies them yet |

Draft models (`data/fs131/idg1/work/ModelDrafts.lean`, against the built tree: `logs/lean-models-1.log`, exit 0; the
same file with a planted `example : (1 : ℕ) = 2 := rfl` fails, `logs/lean-models-plant.log`): `measure_eq_of_fourier`'s
hypotheses at `dualHaar ℤ`; `IsHaarFourier.map_dual`'s at `dualHaar ℤ` with `zmultiplesHom ℤ 2`; `subgroupHaar_pos`'s at
`univ` and `⊥`; `Finite (ℤ ⧸ ⊤)`; the injectivity of `n ↦ 2n` for `surjective_compAddMonoidHom`; the closedness of
`(2ℤ)^⊥`. **Slot:** each as an `example` beside its statement, in its module.

### `LEAN.md` § Searching — Lean (Keryx files; each a new bullet at the section's end)

- Fourier uniqueness on the dual of a countable discrete group needs no Peter–Weyl and no `StarAlgebra.adjoin`: the
  evaluations as bounded continuous functions (`BoundedContinuousFunction.mkOfCompact` on the compact dual) have a
  **span** closed under products (`ev_r · ev_s = ev_{r+s}`), `star` (`ev_{-r}`) and holding `1 = ev_0`, so the span is a
  `StarSubalgebra` by its fields, integrals agree on it by one `Submodule.span_induction`, and
  `ext_of_forall_mem_subalgebra_integral_eq_of_polish` concludes (`Rigidity.measure_eq_of_fourier`, FS131-IDG1).
  `clear` the membership hypothesis before `induction … using Submodule.span_induction`, or every case's hypothesis
  carries it as a premise.
- `ℚ/ℤ` into the circle with trivial kernel: `QuotientAddGroup.lift` of `q ↦ Additive.ofMul (Circle.exp (2π q))`,
  the kernel by `Circle.exp_eq_one`; with `CharacterModule.exists_character_apply_ne_zero_of_ne_zero` it separates the
  points of any abelian group by characters into `Circle` (`Rigidity.exists_apply_ne_one`, FS131-IDG1).
- At the pin: `AddChar.ext` takes both characters explicitly (`AddChar.ext _ _ h`); the family argument of
  `Pi.borelSpace` is `X`, not `π` — `BorelSpace.measurable_eq (α := G → ℂ)` names the instance; `→ᵇ` is notation scoped
  in `BoundedContinuousFunction` (write the type out, or open the scope); an `instance` of a `Prop`-valued class is
  stored as a theorem (FS131-IDG1's dump).
- After `rintro ⟨χ, rfl⟩` in `Set.range (fun χ => fun g => (χ g : ℂ))`, the goal holds a β-redex that `rw` cannot see
  through, and the error prints as a type mismatch `Circle` against `↥(Submonoid.unitSphere ℂ)`: `show` the reduced
  goal first. Three closed sets of `G → ℂ` written as `{f | …}` in one `refine` timed out at `isDefEq`; one `have` per
  set elaborates at once (`Rigidity.isClosedEmbedding_coe`, FS131-IDG1).
- A dump that compares definitions' stored values must not compare a `Prop`-valued instance's (a proof), and a
  definition that holds proofs as structure fields (`Duality.graphSubgroup`, `AdmissiblePair.ofPow`) is compared by
  its value with every proof subterm erased (`Meta.transform` with `isProof` → `True.intro`; `data/fs131/idg1/lean/
  StatementDump.lean`'s `DATA` line), which generalizes FS124-I3's "compare its data fields" to any nesting
  (FS131-IDG1).
- FS131-LC1's code-only plant (the first `:=` → `:≡`) cannot fire on a file whose first `:=` is inside a docstring —
  three of four files here; plant the last `:=`, or check that the planted text's code differs (`tools/
  fs131_idg1_code_only.py`, FS131-IDG1).

## Drafts for the front page

None for this job. No milestone closes with it: the chain lands as one unit, and `Rigidity/UnitCircle` keeps lane A's
leaf. The gate's whole-library counts belong to the landing that joins the chain to `main`; its rows are the audit block
above and the theorems of this record's list.

## Stage 6 — SAVED: the drafts

The drafts above, with the CLEAN block regenerated from build 3's print (`data/fs131/idg1/audit-block.lean`, identical
to the one from build 2's). Nothing of this job is running or queued.

## Stage 7 — SAVED: the report

`data/fs131/reports/FS131-IDG1.md`, the same text as the hand-back. Nothing of this job is running or queued. The branch
`fs131-wdg` is not pushed (the brief). The tree's compiled library is current for the branch head after build 3.
