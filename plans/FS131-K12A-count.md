# FS131-K12A — the five-colour chain: the count, typed to its leaves

*de Bruijn, the planner (the tenth on this chain). Brief: `data/fs131/briefs/FS131-K12A-count.md` (on `main`). Branch
`fs131-wk12`, cut from `fs131-wkr` at `3fabd5e10`, in the tree `.claude/worktrees/fs131-wch`. Working files:
`data/fs131/k12a/`. Report: `data/fs131/reports/FS131-K12A.md`.*

## Theorems this phase proved

(Filled at the last stage.)

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_k12a_readback.py` (FS131-KR1's checker with this brief's path) reads every block quotation of the brief and
requires the quoted text, character for character, as one whole line of its source on `main`'s working tree. Output
`data/fs131/k12a/readback.out`: **6 quotations, 6 IDENTICAL** — W2 (`data/fs131/REQUEST-2026-10-13.md`), NF2-NC and the two
dated lines of 2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 818 and 823 (`plans/FS131-close-inventory.md`).
Control (`--plant`, `data/fs131/k12a/readback-plant.out`): one character changed in each quotation in memory, **6 of 6
reported**.

### 1.2 The count, as the kernel holds it

Printed from the compiled tree (`data/fs131/k12a/probes/Readback.lean`, output `Readback.out`):

```
def HadwigerNelson.SpectralChain.Interface.Count : {F : Subfield ℝ} → Interface F → Prop :=
fun {F} I => TCA F → I.R88TCA
def HadwigerNelson.SpectralChain.Interface.R88TCA : {F : Subfield ℝ} → Interface F → Prop :=
fun {F} I => ∀ (μ : InvariantColouring F) (σ : Measure (Dual F)), IsTraceSpectral F μ.μ σ → σ I.TAᶜ ≠ 0
```

and the probe's `example` — `(chainInterface F).Count ↔ (TCA F → ∀ μ σ, IsTraceSpectral F μ.μ σ → σ (TA F)ᶜ ≠ 0)` by
`Iff.rfl` — elaborates. **Restated:** over a real number field `F`, if every conjugation-stable prime of `F(i)` has some
`c < 1/4` bounding every independent set of every level's residue target (`TCA F`), then no translation- and
rotation-invariant random proper four-colouring of `Cay(ℤ[U], U)` (`InvariantColouring F`: a probability law on
`ℤ[U] → Fin 4`, carried by `X₄(F)`, invariant under every shift and rotation) has a trace spectral measure (`σ` finite,
`∫ χ(y) dσ = E⟨e_{c(0)}, e_{c(y)}⟩`) carried by `T + A` (`σ (TA F)ᶜ = 0`). Equivalently: such a colouring with spectrum on
`T + A` is impossible. `TCA F` gives one constant per prime; the uniform form is `Rigidity.tca_uniform`
(`∀ F [NumberField F], TCA F → ∃ c < 1/4, ∀ P, RatioAtMost P c`, module M13, a `sorry` leaf there, reading Weil).

### 1.3 The map planner's five blocks (`plans/FS131-KR1-chain-map.md` § 2.5), restated

| block | reads | produces |
|---|---|---|
| C1 continuity | `σ (TA F)ᶜ = 0`; the characters of `T + A` are `τ′`-continuous (M10); dominated convergence | `P(c(0) ≠ c(y)) = 3(1 − C(y))/4 → 0` as `y → 0` in `G_∅ = (L ⊗ ℝ) × ∏_{stable} 𝓞_{L_v}`; no Bochner |
| C2 extension | C1; density of `R` in `G_∅` (M9) | a `G_∅`-stationary process, continuous in probability, with a jointly measurable modification (Doob–Cohn) |
| C3 a.e.-proper | C2; `T_∅ = ∏ T(F_v)` is the closure of `U` (weak approximation for the norm-one torus; `[S9]` at each stable level) | a.s. the monochromatic edges `{(x, w) : c̃(x) = c̃(x + w)}` are `Haar × ν`-null |
| C4 regularisation, windows | Lebesgue differentiation along `E_n = C_n × V_n` (not doubling); C14.1–C14.4's window lemmas | edge-null sets made independent; C14.1-e: `d_n(Z) ≤ r_X d_n(N_e[Z]) + η_X(n)` |
| C5 the count | factor ratios (`m₁` at each real place by C14.3's induction; a complex place by FS100-CX; `sup_P c_P` at the stable places, uniform by Weil); stationary Zhang (`[Zhang2012]` Thm 1.8, X25B-PZ) | `1 = Σ_j p_j ≤ 4 max(r_factors) < 1`: no such colouring |

The derivation's entries (read): R88-TC-ext, -J28V-2, -TC-reg, -TC-Yp, -J28V-3, -TC-count, -TC-tab, R88-TCA
(`plans/R88-derivation.md` ll. 114–161); FS100-TCA, FS100-CX (`plans/FS100-derivation.md` ll. 291, 293); J28D § 3.2 C1–C8,
§ 3.3 (`plans/FS86-R88-D-derivation.md` ll. 142–219).

## Stage 2 — SAVED: the count typed, in seven blocks and eight modules (59 leaves `sorry`)

### 2.1 The route, and where it leaves the map planner's

The count is proved by contradiction from one colouring: spectrum on `T + A` → continuity in probability along a completion
`G = (L ⊗ ℝ) × K` → a jointly measurable random colouring of `G`, almost surely proper at every edge of the closure of `U` →
**one slice** `Δ × K`, `Δ = ℚ(i) ⊗ ℝ ⊆ L ⊗ ℝ`, carrying `UD(ℝ²) ⊗ Cay(K, U)` → down to the finite levels of `K` → Zhang's
count on `UD(ℝ²) ⊗ (finite Cayley graph)` in a window, which caps every colour at `max(m₁, c) + ε < 1/4`. Five departures
from § 2.5's C1–C5, each sent to the coordinator at once (message of this stage):

1. **One archimedean factor at every number field.** Restricting to the slice drops vertices and edges (the safe direction
   for a ratio), so only `m₁` of one plane is read: C14.3's induction over the real places and FS100-CX at the complex places
   leave the path. The slice's edges `(Δ(e^{iθ}), ιK u)` lie in the closure of `U` by **weak approximation by `h`-th powers**
   (`mem_closure_pow`) — narrower than "U is dense in the archimedean torus" — and the congruence trick (`w^h ≡ 1` at a
   finite level, `h` the exponent of its units).
2. **`[S9]` without smoothness**: Hilbert 90 modulo `P^m` (`z = w + s w̄`), at the unramified stable primes, which are all
   of them under `TCA` (`noRamifiedStableDyadic_of_tca`).
3. **Doob–Cohn replaced by Borel–Cantelli** (summable increments of `c(π_n g)`), and **R88-J28V-2's non-doubling Vitali
   family avoided**: regularisation only in `ℂ` (the kernel's `Plane.dist_ne_one_of_mem_densitySet`), the profinite side by
   coset densities (`tendsto_haarK_bad`) and finite levels. All stable places are one factor read by ratio
   (`tca_uniform`): no Hoffman step, no `H`/`B` split, no Lemma Y′.
4. **Lemma C (d) from `c·O′ ⊆ R`** (item 791's question (4)): the count reads neither `R = O′` nor a scope.
5. **Zhang with one finite factor**: the neighbourhood ratio of the finite factor is finite averaging; only the plane's needs
   a window argument (`volume_inter_sq_le_essNbhd`), and `m₁` enters through the library's supremum `Plane.mOne`.

### 2.2 The blocks, their modules and statements, read aloud against the derivation

| block | module (leaves) | principal statements | read against | model |
|---|---|---|---|---|
| P — the plane | `Plane/WindowDensity` (9) | `volume_inter_sq_le`: `UnitPairsNull A → |A ∩ sq a s| ≤ m₁ (s+2)²`; `exists_periodic_near_mOne`; `volume_inter_sq_le_essNbhd`: `∃ s₀, ∀ a s ≥ s₀, |Z ∩ sq| ≤ m₁ |N_e[Z] ∩ sq| + ε s²` | J28D C4 Lemma X′, C14.1-e; C14.2 (a) | `∅`, the disc of radius `1/3` |
| Z — finite Zhang | `Rigidity/FiniteZhang` (4) | `card_le_mul_card_closedNbhd` (NH-Y′ finite); `ratioLe_prod`, `ratioLe_pi` (`[Zhang2012]` Thm 1.8's count); `ratioLe_subgroup` | J28D C5, NH-Y′; X25B-PZ | `RatioLe S 1`; `{0} ⊆ ZMod 2` independent for `{1}` |
| C — Zhang on the plane | `Rigidity/PlaneZhang` (5) | `sum_volume_inter_sq_le`: rows of `UD(ℝ²) ⊗ Cay(Q,S)` with null edges hold `≤ (max(m₁, r) + ε)|Q| s²` of a large window | J28D C5 (i), (ii′), NH-X, the count | empty rows (proved `example`) |
| A — the archimedean factor | `Rigidity/CountTorus` (7) | `Delta`; `Delta_circle_mem_closure`; `mem_closure_pow` | J28D C3 (weak approximation); FS100-TCA; FS100-CX | `F = ℚ`, `u = (3+4i)/5` |
| R — the finite levels | `Rigidity/CountResidue` (12) | `exists_normOneL_residue(s)` (`[S9]`, NF2-LEAF-07); `exists_mem_nsmul_of_resR_eq_zero` (Lemma C (d)); `image_levR_unitVectors`; `ratioLe_levR_range` | NF2-LEAF-07; J28D C1 (Lemma C (d)); R88-J28V-3, -TC-tab (ratios only) | inert `p ≡ 3 (4)` in `ℚ(i)`; the ramified `(1+i)` fails `¬ IsRamified`, as it must |
| K — the completion | `Rigidity/CountCompletion` (10) | `K`, `haarK`, `haarK_proj_preimage`, `tendsto_haarK_bad`, `denseRange_ιG`, `mem_closure_ιG` | J28D C1–C3 (`G_S`, dense, closure of `U`) | `ιK 0`; `F = ℚ` |
| E — the extension | `Rigidity/CountExtension` (5) | `tendsto_measure_ne` (C1); `exists_extension` (C2–C3); `exists_slice` | R88-TC-ext (J28V-1), J28D C1–C3 | `F = ℚ`: the residue two-colouring mod `(1+i)`, uniformly shifted (no `TCA` read; docstring) |
| D — descent and the count | `Rigidity/CountDescent` (5) | `rowsEdgeNull_levelRows`, `volume_colour_le`, `tendsto_bad`, `false_of_slice`; **`count_of_oneAvoidingDensityBound : Plane.OneAvoidingDensityBound → (chainInterface F).Count`, composed over the leaves** | R88-TCA; J28D § 3.3; FS100-TCA | a step in a proof by contradiction (docstring); the control `ℚ(√11)` |

Every module compiles against the tree's library under the lakefile's options (`data/fs131/k12a/lean1.sh`, a symlink farm;
logs `data/fs131/k12a/logs/*.log`: exit 0, each warning `declaration uses 'sorry'`). `tools/check_architecture.py`: the
eight rows pass; its one failure is the inherited `Rigidity/ZeroEntropyNames` imports cell (the base fails it too, with the
eight modules then missing rows: `logs/architecture-base.log`).

### 2.3 The domain pass (`debruijn-domain-modeling`, invoked fresh)

- `sq` is a preimage under `Complex.equivRealProd` of `Ico ×ˢ Ico`: its measure is Mathlib's, not a lemma of ours.
- The library's `Plane.IsPeriodicSet L P` is reused; the job's own periodicity predicate was deleted.
- Independence is read **in the connection set** (`SIndep`: `y − x ∉ S` for all `x, y`, equal ones included): the trivial
  level of a field with no stable prime of norm `≤ k` is one point with the loop `0`, ratio `0`, and Zhang then reads the
  plane alone — no special case. `RatioLe` uses `Nat.card` and `[Finite G]`, as `RatioAtMost` does.
- `finite_quot` is an instance (a `Prop`-valued class: no diamond), so no statement carries a `haveI`.
- `Lev F k` is a type synonym so that its discrete topology is an instance on our type, never on Mathlib's `𝓞 L ⧸ I`
  (which carries no topology at the pin: `data/fs131/k12a/probes/Inst.out`).
- `ιG` is an `AddMonoidHom` (the consumers read additivity and `comap ιG (𝓝 0)`); `SliceEdgeNull` is defined once, in
  `CountExtension`, and is `exists_slice`'s conclusion.
- `toL` repeats lane T's `Rigidity.ofUnitRing` (`Rigidity/TateModel`) under another name in another namespace; neither module
  imports the other. At the join the two can be made one (a question, INVENTORY).

## Stage 3 — SAVED: the obligation pass, and the plan per leaf (61 leaves)

### 3.1 The obligation pass (`debruijn-obligation-modeling`, invoked fresh)

- **Quantifier order for the consumer.** The count fixes one window and then sends the level `k → ∞`; the window bound is
  applied to the lonely sets of every row at every level. So the plane's neighbourhood ratio must hold at **one scale for
  every set**: `volume_inter_sq_le_essNbhd` (`∀ Z, ∃ s₀`) was replaced by `NRWindow ε s₀` and `exists_nrWindow`
  (`∃ s₀, ∀ Z`), and `sum_volume_inter_sq_le` now takes `NRWindow ε s₀` and any `s ≥ s₀` (no `∃` of its own). Under the
  old order the count's proof could not be written (the scale would depend on the level).
- **Generalised for the proof:** `le_upperDensity_of_periodic` at every cell `sq b L` (the periodisation of `A ∩ sq a s`
  is read in the cell `sq a (s + 2)`, where it is exactly the trace).
- **Named children added:** `unitPairsNull_diff_essNbhd_union` (C14.1-e's union, the heart of the neighbourhood ratio),
  `Delta_circle_mul_mem_closure_pow` (what the completion reads of the torus), `resR_eq_zero_of_le` and
  `exists_level_mem_nsmul` (Lemma C (d) in the form the topology comparison reads), `hasBasis_nhds_zero_K` (read by the
  extension's choice of neighbourhoods and by the cylinder approximation).
- **Removed, no consumer:** `Delta_mul`.
- **Every hypothesis is read** by its route below; the one structure hypothesis of a block whose hypotheses are a step in a
  proof by contradiction (`false_of_slice`, `exists_slice`) says so in its docstring, with the model of the parts that do not
  read `TCA` (`F = ℚ`).

### 3.2 The plan per leaf

*Names `#check`ed at the pin: `data/fs131/k12a/probes/Names.out`, `Readback.out`, `Inst.out`. "Hard" marks the leaf a lane
should open with.*

| module | leaf | route; Mathlib and library names | hard? |
|---|---|---|---|
| WindowDensity | `measurableSet_sq`, `volume_sq` | preimage of `Ico ×ˢ Ico` under the measurable equivalence; `Complex.volume_preserving_equiv_real_prod`, `Measure.prod_prod`, `Real.volume_Ico` | low |
| | `densitySet_bandFree` | `Plane.dist_ne_one_of_mem_densitySet` with `Plane.upperDensityAt_pos_of_mem_densitySet`; a.e. equality from `Plane.volume_diff_densitySet`, `Plane.volume_densitySet_diff` (`Plane/Cover`) | low |
| | `le_upperDensity_of_periodic` | the cells `sq (b + L(m + ni)) L` inside `ball 0 R` number at least `λ(ball 0 (R − √2 L))/L²`; each holds `λ(P ∩ sq b L)` (`measure_preimage_add_right` and periodicity); `Filter.le_limsup_of_frequently_le'` along `R → ∞` | medium |
| | `bandFree_periodize` | two points of distinct copies differ by at least `2` in one coordinate (`|Re|` or `|Im|`), so their distance exceeds `1` | low |
| | `volume_inter_sq_le` | the three above at `L = s + 2`, the cell `sq a (s + 2)`; `upperDensity P ≤ mOne` (`le_iSup₂`) | low |
| | `exists_periodic_near_mOne` | `mOne` is a supremum: a measurable 1-avoiding `A` with `upperDensity A > m₁ − ε/3`; a ball where the ratio exceeds it; a grid square of side `s` inside the ball's cover with ratio `> m₁ − 2ε/3` (pigeonhole over finitely many squares); periodise at `s + 2`, `s` large | medium |
| | `unitPairsNull_diff_essNbhd_union` | three kinds of pairs: inside `J` none; inside `Z` null; across, the slice `{θ : x + e θ ∈ Z}` is null for `x ∉ N_e[Z]` and `Plane.volume_slice_swap` for the reverse orientation; `Plane.unitPairsNull_iff_ae_phi_eq_zero` | medium |
| | `exists_nrWindow` | **the block's hard leaf**: `J` from the last-but-one; for `t ∈ sq 0 L`, `volume_inter_sq_le` on `((J + t) \ N_e[Z]) ∪ Z`; `∫_{t ∈ sq 0 L} λ((J + t) ∩ M) dt = λ(J ∩ sq 0 L) λ(M)` (Tonelli, `lintegral_prod_swap`, periodicity); `s₀` from `4s + 4 ≤ ε s²/2` and `m₁ − δ_J ≤ ε/2` — independent of `Z` | hard |
| | `essNbhd ∅` example | `phi ∅ = 0` | low |
| FiniteZhang | `card_le_mul_card_closedNbhd` | a maximum independent `J`; for each `t`, `((J + t) \ N[I]) ∪ I` is independent; `Σ_t |(J + t) ∩ N[I]| = |J| |N[I]|` (`Finset.sum_comm`); divide by `|G|` | medium |
| | `ratioLe_prod` | **the hard leaf**: rows `X_b`, social/lonely in `G₁`, `A_x`, `B(x)`; `|A_x| ≤ c (|G₂| − |B(x)|)` (NR in `G₂`, `A_x` independent, `N[A_x] ∩ B(x) = ∅`), `Σ_b |X*_b| ≤ c Σ_x |B(x)|` (NR in `G₁`); sum — the finite form of PlaneZhang's count | medium |
| | `ratioLe_pi` | induction on the finite index (`Finite.induction_empty_option`), the product split by `Equiv.piOptionEquivProd`; empty index: one point, the connection set `univ ∋ 0`, ratio `0 ≤ c` | medium |
| | `ratioLe_subgroup` | an independent `I ⊆ A` translated by a transversal of `A` in `G` is independent in `G` (edges stay in cosets: `S ⊆ A`); `|G| = [G : A] |A|` (`AddSubgroup.card_mul_index`) | low |
| PlaneZhang | `measurableSet_lonely`, `unitPairsNull_lonely` | `measurable_phi`; a lonely point's slice in its row is null, so the pair set of the lonely set is null (`Plane.pairSet_null_iff_ae_slice`) | low |
| | `ae_sIndep_social` | for each `q` and `t ∈ S` (finitely many): `{z ∈ Y (q + t) : phi (Y q) z ≠ 0}` is null by `RowsEdgeNull` at `(q + t, −t)`; `measure_iUnion_null` over the finite pairs | medium |
| | `ae_disjoint_touched` | J28D (ii′)'s cases — `b ∈ A_z` against `z ∈ X*_b` (disjoint by definition); `b ∈ A_z` against `phi (X*_b) z ≠ 0` (swap of the lonely slice); `b − a ∈ S` against `z ∈ X*_b` and against `phi (X*_b) z ≠ 0` (edge-nullity at `(b, a − b)`, `(a, b − a)`) | medium-hard |
| | `sum_volume_inter_sq_le` | **the hard leaf**: `Σ_q λ(Y q ∩ W) = ∫_W |{q : z ∈ Y q}| = ∫_W |A_z| + Σ_b λ(X*_b ∩ W)` (finite sums of indicators, `lintegral_finset_sum`); `|A_z| ≤ r (|Q| − |B(z)|)` a.e.; `Σ_b λ(X*_b ∩ W) ≤ m₁ Σ_b λ(N_e[X*_b] ∩ W) + ε |Q| s² = m₁ ∫_W |B(z)| + ε |Q| s²`; combine in `ℝ` | hard |
| CountTorus | `mem_normOneL_iff` | `‖u‖ = 1 ⟺ u ū = 1` (`Complex.mul_conj`, `Complex.normSq`) | low |
| | `Delta_ratCast` | `map_add`, `map_mul`, `map_ratCast` of `mixedEmbedding`; `Complex.re`/`im` of `q₁ + q₂ i` | low |
| | `Delta_circle_mem_closure` | `φ(t) = (1 − t² + 2ti)/(1 + t²)`, `t ∈ ℚ`, dense in the circle (`Rat.denseRange_cast`, `φ` continuous, onto the circle minus `−1`); `Delta_ratCast`; `Delta` continuous (finite-dimensional, `LinearMap.continuous_of_finiteDimensional`) | medium |
| | `mem_closure_pow` | **the hard leaf of the block**: `x = φ(t₀)` (`t₀ = (x − x̄)/(i(x + x̄ + 2))` read in `F`) or `x = −1 = i²`; `φ(t)^h = φ(Q_h(t)/P_h(t))` (`ring`/`field_simp`); coordinates `NumberField.mixedEmbedding.mixedEmbedding_apply_isReal`/`_isComplex` of `F`'s mixed space; `ξ_v = exp(log φ(σ_v t₀)/h)` (`Complex.exp_log`, `Complex.neg_pi_lt_log_im`, `Complex.log_im_le_pi`: `ξ ≠ −1`); `y_v = (ξ_v − 1)/(i(ξ_v + 1))`, real at a real place; `t ∈ F` near `y` (density of `F` in its mixed space from `latticeBasis` and `ℚ`-multiples, or `InfinitePlace.denseRange_algebraMap_pi`); transfer from `F`'s mixed space to `L`'s by a continuous linear map on `e(F ⊕ Fi)` | hard |
| | `Delta_circle_mul_mem_closure_pow` | `Submonoid.topologicalClosure` of the submonoid `e '' ((·^h) '' normOneL)`; `Submonoid.le_topologicalClosure`; the two above | low |
| | `pow_mem_normOneL`, `mul_mem_normOneL` | `map_pow`, `map_mul` of `conjOn` | low |
| CountResidue | `toL_mem_localRing` | `Rigidity.unitRing_le_stableIntegers`, `mem_stableIntegers`, `UnitRing.coe_mem_unitRingOver_iff` | low |
| | `isIndepSet_levelTarget_iff`, `neg_mem_normOneQ` | `SimpleGraph.fromRel_adj`; `0 ∉ normOneQ` at `m ≥ 1` (`1 ≠ 0` in `𝓞/P^m`); `map_neg`, `neg_mul_neg` | low |
| | `finite_quot` | `Ideal.finiteQuotientOfFreeOfNeBot`, `P^m ≠ ⊥` (`pow_ne_zero`, a maximal ideal of a number ring is `≠ ⊥`) | low |
| | `ratioLe_normOneQ` | `isIndepSet_levelTarget_iff`, `RatioAtMost` unfolded | low |
| | `exists_normOneL_residue` | **Hilbert 90 mod `P^m`**: lift `s` to `a ∈ 𝓞` (`Ideal.Quotient.mk_surjective`); `z = w + a·w̄` with `w = 1` or `w = ζ`, `ζ̄ − ζ ∉ P` (from `¬ IsRamified P`); `z ∉ P` in either case; `x = z / z̄`; `P.residue` of a quotient (`UpperHalf.residue_div`) and of conjugation (`UpperHalf.residue_conj`) | medium |
| | `exists_normOneL_residues` | `IsDedekindDomain.exists_forall_sub_mem_ideal` for the `z_P` and for `w`; distinct stable primes have distinct ideals (`stablePrime_injective`) | medium |
| | `exists_unitRing_of_normOneL` | `x = a + bi`, `a² + b² = 1`, so `(x : ℂ) ∈ unitVectors F ⊆ unitRing F` (`unitVectors_subset_unitRing`) | low |
| | `exists_mem_nsmul_of_resR_eq_zero` | `c` from `exists_mul_stableIntegers_le`; `Φ` the stable primes containing `N c`, `m` with `P^m ∣ N c` for each; residues zero ⟹ `r/(N c) ∈ O′` (valuations: `UpperHalf.mem_localRing`, the localisation's maximal ideal); then `c·(r/(N c)) ∈ R` | medium |
| | `resR_eq_zero_of_le` | `Ideal.pow_le_pow_right` and the factorisation of `P.residue` through `Ideal.Quotient.factor` | low |
| | `mem_level` | `Set.Finite.mem_toFinset` | low |
| | `exists_level_mem_nsmul` | `k = max m (max of absNorm over Φ)`; `resR_eq_zero_of_le` | low |
| | `image_levR_unitVectors` | `⊆`: a ring map keeps `x x̄ = 1` (`UpperHalf.residue_conj`); `⊇`: `exists_normOneL_residues` at `level F k` with `ratio_unramified_of_tca`, then `exists_unitRing_of_normOneL` | medium |
| | `ratioLe_levR_range` | `ratioLe_pi` over `level F k` (each factor `ratioLe_normOneQ`), `ratioLe_subgroup` for `(levR F k).range ⊇ normOneLev F k` (`image_levR_unitVectors`) | low |
| CountCompletion | `CompactSpace (K F)`, `continuous_proj` | `Pi.compactSpace`, `Finite.compactSpace`; `AddSubgroup.isClosed_topologicalClosure`, `IsClosed.isCompact`; `continuous_apply` | low |
| | `range_proj` | `⊇` from `proj_ιK`; `⊆`: `proj` is continuous into a discrete space, so the preimage of `range (levR F k)` is clopen and holds the dense `range ιK` | low |
| | `proj_eq_zero_of_le` | the reduction `Lev F k → Lev F k'` composed with `levR F k` is `levR F k'`; the set where `proj k x = 0 → proj k' x = 0` is closed and holds `range ιK` | medium |
| | `hasBasis_nhds_zero_K` | `nhds_pi` (finitely many coordinates), `proj_eq_zero_of_le` to the largest, `nhds_subtype` | medium |
| | `IsProbabilityMeasure haarK`, `IsAddLeftInvariant` | `Measure.addHaarMeasure_self` at `⊤`; `Measure.isAddHaarMeasure_addHaarMeasure` | low |
| | `haarK_proj_preimage` | the level-`k` cosets are translates of one open subgroup (`measure_preimage_add`), finitely many, covering `K` | low |
| | `tendsto_haarK_bad` | **the hard leaf of the block**: regularity (`MeasurableSet.exists_isOpen_sdiff_lt`, `MeasurableSet.exists_isCompact_sdiff_lt`); a compact set inside an open one is inside a finite union of level-`k₀` cosets inside the open set (`hasBasis_nhds_zero_K`, `IsCompact.elim_finite_subcover`); for `k ≥ k₀` the bad points of a coset that the cylinder holds cost `κ`-fraction of the cylinder's excess | medium-hard |
| | `denseRange_ιG` | a basic open set `B(v, δ) × (ιK r₀ + ker proj k)`; `r = r₀ + M y` with `M = ∏_{P ∈ level k} absNorm P^k ∈ P^k`, and `M·R` dense in `L ⊗ ℝ` (`Rigidity.dense_mixedEmbedding_nsmul_unitRing`) | medium |
| | `mem_closure_ιG` | `h = Monoid.exponent (Lev F k)ˣ` (`Monoid.pow_exponent_eq_one`): `levR k (w^h) = 1` for a unit vector `w`; `u·w^h` with `e(w^h) ≈ e(ū)Δ(e^{iθ})` from `Delta_circle_mul_mem_closure_pow` and `e(u) e(ū) = 1`; `hasBasis_nhds_zero_K` | medium |
| CountExtension | `measure_ne_eq` | `corr = ∫ tetra (c 0) (c y) = 1 − (4/3) P(c 0 ≠ c y)` (`integral_indicator`, the two values of `tetra`) | low |
| | `comap_ιG_le_nhds_tauPrime` | `nhds_inf` for `tauPrime = profTop ⊓ archTop`; profinite part by `exists_level_mem_nsmul` at `N + 1`; archimedean part by the first coordinate of `ιG` (`nhds_induced`) | medium |
| | `tendsto_measure_ne` | `tendsto_integral_filter_of_dominated_convergence` along `comap ιG (𝓝 0)` (countably generated: `G` first countable), bound `1`, pointwise limit `1` on `TA F` (`Rigidity.TA_subset_contChars` and `comap_ιG_le_nhds_tauPrime`), `σ (TA F)ᶜ = 0`; then `measure_ne_eq` | medium |
| | `exists_extension` | **the hard leaf of the module**: neighbourhoods `O_n` (basic, from `hasBasis_nhds_zero_K` and balls) with `P(c 0 ≠ c y) ≤ 2^{−n}` on `ιG⁻¹(O_n + O_n + O_n)`; `π_n g` = the first `r` in an enumeration of `R` (`countable_unitRing`) with `ιG r ∈ g + O_n` (`denseRange_ιG`; `measurable_find`); `f c g` = the eventual value of `c (π_n g)` (`measure_limsup_atTop_eq_zero` on the summable increments, shift invariance `InvariantColouring.shift_inv`); the edge bound through `InvariantColouring.carried` (`c ∈ X₄`) | hard |
| | `exists_slice` | Tonelli over `μ × (volume × haarK) × arcLength` (`lintegral_prod`) for each of countably many `u`; `mem_closure_ιG`; one sample off a countable union of null sets | medium |
| CountDescent | `measurableSet_levelRows` | `Measurable.measure_of_isPiSystem`-free: `z ↦ haarK (section)` is measurable for a measurable set of the product (`measurable_measure_prodMk_left`) | low |
| | `rowsEdgeNull_levelRows` | **the hard leaf of the module**: for `s = levR k u`, translation by `ιK u` carries coset `q` to `q + s` (`IsAddLeftInvariant`); two fills above `3/4` share more than `1/2` of a coset; Tonelli turns a positive measure of row pairs into a positive measure of monochromatic slice edges at `u` | medium-hard |
| | `volume_colour_le` | Tonelli; on each coset either the fill exceeds `3/4` (the row) or the point is bad; `haarK_proj_preimage` | medium |
| | `tendsto_bad` | per `z`, `tendsto_haarK_bad` at `κ = 1/4`; `tendsto_lintegral_filter_of_dominated_convergence` over the window | medium |
| | `false_of_slice` | `tca_uniform` gives `c`; `ε` with `4 (max(m₁, c) + 2ε) < 1`; `s₀` from `exists_nrWindow`; one window `sq 0 s₀`; `k ≥ 1` with each bad term `≤ ε s₀²` (`tendsto_bad`); `sum_volume_inter_sq_le` at level `k` with `ratioLe_levR_range` and `rowsEdgeNull_levelRows`; the four colours sum to `s₀²` | medium |

## Stage 4 — SAVED: first leaves, and the price

### 4.1 Five first leaves, written in scratch and elaborated

Each is the module's statement restated under a scratch name in `data/fs131/k12a/leaves/`, compiled against the tree's
library and this job's modules with the lakefile's options (`data/fs131/k12a/leaf1.sh`); outputs beside them (`*.out`:
exit 0, no `sorry`, no warning).

| block | leaf (module statement) | file | lines | iterations to green | elaboration |
|---|---|---|---|---|---|
| K | `CompactSpace (K F)` and `IsProbabilityMeasure (haarK F)` | `LeafK.lean` | 17 | 1 | 2.8 s, 3.9 GB |
| R | `exists_normOneL_residue` — `[S9]` at one prime, Hilbert 90 mod `P^m` | `LeafR.lean` | 58 | 2 | 2.8 s, 4.0 GB |
| Z | `card_le_mul_card_closedNbhd` — the finite neighbourhood ratio | `LeafZ.lean` | 73 | 2 | 2.0 s, 1.9 GB |
| P | `unitPairsNull_diff_essNbhd_union` — C14.1-e's union | `LeafP.lean` | 44 | 2 | 2.3 s, 3.1 GB |
| E | `tendsto_measure_ne` — C1 (over its two sibling leaves) | `LeafE.lean` | 50 | 4 | 3.0 s, 4.0 GB |

What the leaves taught: (1) the library's residue API (`UpperHalf.residue_div`, `isUnit_mk_pow`, `coe_conjO`,
`conjO_conjO`) carries `[S9]` with no new infrastructure; (2) the plane's slice API (`pairSet_measure_eq_lintegral`,
`pairSet_null_iff_ae_slice`, `volume_slice_swap`, `ae_arcLength_shift_pi`) carries the essential-neighbourhood bookkeeping —
PlaneZhang's and CountDescent's null-set leaves are of this kind; (3) **the completion needed two instances the skeleton
lacked**, `SecondCountableTopology (Lev F k)` and `SecondCountableTopology (K F)` (instance search did not find the
subtype's), without which `comap ιG (𝓝 0)` is not countably generated and dominated convergence does not apply — now
declared in `CountCompletion`, with their proofs; (4) block A's hard leaf has no `Algebra F (fieldI F)` to lean on
(`data/fs131/k12a/leaves/ProbeA.out`): its transfer from `F`'s mixed space to `L`'s goes through a ring map `F →+* L` and
`(NumberField.mixedEmbedding.latticeBasis F).constr`, which the plan names.

### 4.2 The calibration and the price

Against § 3.2's grades, the five leaves measured `low ≈ 15`, `medium ≈ 45–75` lines, each green in one to four
elaborations of three seconds. Priced from that, leaf by leaf (`hard` taken at 200–500 lines, `medium-hard` at 100–250):

| block | module | leaves | lines (proofs) | agent-days | its hard leaf |
|---|---|---|---|---|---|
| P | `Plane/WindowDensity` | 10 | 550–750 | 1.5–2.5 | `exists_nrWindow` |
| Z | `Rigidity/FiniteZhang` | 4 | 400–550 | 1–1.5 | `ratioLe_prod` |
| C | `Rigidity/PlaneZhang` | 5 | 500–700 | 1.5–2 | `sum_volume_inter_sq_le` |
| A | `Rigidity/CountTorus` | 7 | 600–900 | 2–3 | `mem_closure_pow` (no first leaf of its own; priced from the probe and the route) |
| R | `Rigidity/CountResidue` | 14 | 500–650 | 1.5–2 | `exists_normOneL_residues`, `exists_mem_nsmul_of_resR_eq_zero` |
| K | `Rigidity/CountCompletion` | 11 | 700–950 | 2–3 | `tendsto_haarK_bad` |
| E | `Rigidity/CountExtension` | 5 | 700–1,100 | 2–3.5 | `exists_extension` |
| D | `Rigidity/CountDescent` | 5 | 450–700 | 1.5–2 | `rowsEdgeNull_levelRows` |
| **the count** | eight modules (≈ 900 lines of statements, now typed) | **61** | **4,400–6,300** | **13–19.5 agent-days of one lane; about one week of wall time across four lanes** | |

**Against the map's 6,000–12,000 lines and 3–6 weeks** (from Mathlib's coverage): the shorter routes of § 2.1 remove
Doob–Cohn, the Vitali family on the non-doubling product, C14.3's induction, FS100-CX's step and the measurable Hoffman
bound from the path, and the five leaves price what is left at about half the map's lower figure. Blocks A, C and D are
priced from leaves of the same kind in other blocks, not from leaves of their own; A is the least certain (place
bookkeeping). **No block is priced over two weeks.** Plus, outside these modules, the upstream leaves the count reads (§ 5.1).

**Classical inputs.** None beyond the chain's lists: Borel–Cantelli (`measure_limsup_atTop_eq_zero`), Haar measure on a
compact group (`Measure.addHaarMeasure`) and its regularity, dominated convergence, the Lebesgue density theorem (the
kernel's `Plane/DensityPoints`), the Chinese remainder theorem (`IsDedekindDomain.exists_forall_sub_mem_ideal`) are at the
pin; Zhang's counting (`[Zhang2012]` Thm 1.8) and Hilbert 90 mod `P^m` are formalized in these modules; `m₁(ℝ²) < 1/4` is
the named hypothesis `Plane.OneAvoidingDensityBound` (`[AmbrusEtAl2023]` Thm 1), unchanged. **Formalize every one; no axiom
declared.** Off the path now: Doob–Cohn, `[BachocEtAl2014]` Thm 2.2, weak approximation for the norm-one torus in full
(only its `h`-th-power consequence is read).
