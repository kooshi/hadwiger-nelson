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
