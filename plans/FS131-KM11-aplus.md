# FS131-KM11 — the five-colour chain: M11 (A⁺ at the empty set), typed to its leaves and priced

*de Bruijn, the planner (the twelfth on this chain). Brief: `data/fs131/briefs/FS131-KM11-aplus.md` (on `main`). Branch
`fs131-wm11`, cut from the chain's line at `1e438c171`, in the tree `.claude/worktrees/fs132-wi1`. Working files:
`data/fs131/km11/`. Report: `data/fs131/reports/FS131-KM11.md`.*

## Theorems this phase proved

A planning job; filled at the last stage.

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_km11_readback.py` (KR1's tool, copied with the brief's path changed; KR1's own is not edited) reads every block
quotation of the brief and requires it, character for character, as one whole line of its source on `main`'s working tree.
Output `data/fs131/km11/readback.out`: **6 quotations, 6 IDENTICAL** — W2 (`data/fs131/REQUEST-2026-10-13.md`), NF2-NC and the
two dated lines of 2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 823 and 863 (`plans/FS131-close-inventory.md`).
Control (`--plant`, `data/fs131/km11/readback-plant.out`): one character changed in each quotation in memory, **6 of 6
reported**, exit 0 as the control requires. The brief's two in-line quotations of the map planner's record — "(d) … **the step
no record states as a lemma**" and "1,500–2,500 lines" — read against `plans/FS131-KR1-chain-map.md` § 2.4 on this branch:
present as quoted.

### 1.2 The branch and the build

`git checkout -b fs131-wm11 1e438c171` in `fs132-wi1` (the tree was on `fs131-f4`, clean). First build:
`slot.py --mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh` → **`build: OK — 256 of 256 batches, 74 module(s)
rebuilt, 18 module(s) with warnings, 11m7s`** (`build/gate/build/20261014T151321Z-3570208.log`; my copy
`data/fs131/km11/build1.log`).

### 1.3 The hypothesis, from the kernel

`data/fs131/km11/probes/Print.lean` → `Print.out`, from the compiled library:

```
def HadwigerNelson.SpectralChain.Interface.APlusOfR88 : {F : Subfield ℝ} → Interface F → Prop := fun {F} I => I.R88TCA → I.APlus0
def …APlus0 := fun {F} I => ∀ (μ : InvariantColouring F) (σ : Measure (Dual F)), IsTraceSpectral F μ.μ σ →
      ∫ (χ : Dual F) in I.TAᶜ, (↑(χ 1)).re ∂σ < 0
def …R88TCA := fun {F} I => ∀ (μ : InvariantColouring F) (σ : Measure (Dual F)), IsTraceSpectral F μ.μ σ → σ I.TAᶜ ≠ 0
def HadwigerNelson.Rigidity.chainInterface : (F : Subfield ℝ) → [NumberField ↥F] → Interface F :=
  fun F [NumberField ↥F] => { E := TA F, TA := TA F, …, h := fun τ u => ksEntropy τ (rot u) }
```

and the kernel accepts, by `Iff.rfl`, the restatement

```lean
(chainInterface F).APlusOfR88 ↔
  ((∀ (μ : InvariantColouring F) (σ : Measure (Dual F)), IsTraceSpectral F μ.μ σ → σ (TA F)ᶜ ≠ 0) →
    ∀ (μ : InvariantColouring F) (σ : Measure (Dual F)), IsTraceSpectral F μ.μ σ → ∫ χ in (TA F)ᶜ, (χ 1 : ℂ).re ∂σ < 0)
```

**Restated.** For a real number field `F`: *if* no translation- and rotation-invariant random proper four-colouring of
`Cay(ℤ[U_F], U_F)` has a trace spectral measure null off `T + A`, *then* every such colouring's every trace spectral measure
has a strictly negative mean of `Re χ(1)` over the characters off `T + A`. `χ 1` is the character at the ring's `1`, which is
the unit vector `1`. M11 proves it with no hypothesis beyond `[NumberField F]`.

The read statements, as the kernel stores them (`Print.out`): `contChars_tauPrime : contChars (tauPrime F) = TA F` and
`bochnerHerglotz_of_countable`, `measure_eq_of_fourier` on the standard three; **`bochnerOn_tauPrime : BochnerOn (tauPrime
F)` on `sorryAx`** (M2b, being proved); `isTopologicalAddGroup_tauPrime`, `isCountablyGenerated_nhds_tauPrime`,
`measurableSet_TA`, `rot_preimage_TA`, `spectral_carried_iff`, `si4`, `si4_equivariant`, `si4_equivariant_factorSigma`,
`comap_factorSigma_eq_of_action`, `rotInv_of_isTraceSpectral`, `contVec_eq_lpMeas`, `inner_sub_condExpL2_eq_zero`.

### 1.4 The map planner's steps (a)–(g), restated: what each reads, what it produces, what the kernel already holds

Notation: `Ω = (unitRing F → Fin 4)` with the law `μ.μ`; `V_y f = f ∘ shift_y` the Koopman operators; `𝒜 = factorSigma` of
the shifts along `𝓝_{τ′} 0`; `Π = condExpL2` for `𝒜`.

| step | reads | produces | held by the kernel now |
|---|---|---|---|
| (a) `σ = ⅓Σ_k σ_{g_k}` | Herglotz–Bochner (existence of each `σ_{g_k}`), Fourier uniqueness, the tetrahedral Gram identity | the trace measure as a sum of three spectral measures | `bochnerHerglotz_of_countable`, `measure_eq_of_fourier`, `tetra_eq`; **not**: a spectral measure of a vector of `L²(μ)` exists (`posDef` of `y ↦ ⟨f, V_y f⟩`) |
| (b) `σ_g = σ_h + σ_r` | `h ∈ contVec`, `r ⊥ contVec`, `contVec` shift-invariant, `V_y` unitary | the split of each `σ_{g_k}` | `condExpL2_mem_contVec`, `inner_sub_condExpL2_eq_zero`; **not**: the cross-term vanishing, `contVec` invariance |
| (c) `σ_h(TAᶜ) = 0` | N2's `⟸`: `spectral_carried_iff` with `BochnerOn (tauPrime F)` and `contChars_tauPrime` | `σ_h` on `T + A` | `spectral_carried_iff`, `contChars_tauPrime`, `isTopologicalAddGroup_tauPrime`, `isCountablyGenerated_nhds_tauPrime`; `bochnerOn_tauPrime` typed (M2b) |
| (d) `σ_r(TA) = 0` | the cyclic subspace of `r`, density of trigonometric polynomials in `L²(σ_r)`, N2's `⟹` (dominated convergence), `r ⊥ contVec` | `σ_r` off `T + A` | nothing: **the step no record states as a lemma** |
| (e) SI-3 | (a)–(d), properness (`μ (X4 F)ᶜ = 0`), conditional expectation commuting with shifts | `∫_{TAᶜ} Re χ(u) dσ = −(4/3)Σ_j E[p_j(0)p_j(u)] ≤ 0` | `condExp_comp_measurePreserving`, `comap_factorSigma_eq_of_action`, `condLaw_nonneg` |
| (f) remark (ii) | `σ` rotation-invariant (`rotInv_of_isTraceSpectral` over `bochnerHerglotz_of_countable`), `rot_preimage_TA` | the integral is the same at every `u ∈ U` | both read statements are theorems; the transfer is not |
| (g) SI-4 and R88-TCA | equality at every `u` ⟹ SI-4's selection `c′`; its law an `InvariantColouring` (shift and **rotation** equivariance, carried by `X₄`); its trace measure carried by `T + A` (N2's `⟸` again); `R88TCA` | the contradiction | `si4`, `si4_equivariant`, `si4_equivariant_factorSigma`; **not**: `𝒜` rotation-invariant (needs multiplication by `u` continuous for `τ′`), the law's four fields, its trace measure on `T + A` |

**Two findings already at the readback** (to the coordinator at once, below):

1. **A shorter route for (a) and (e): colour indicators in place of tetrahedral coordinates.** With `e_j = 1{c(0) = j}` and
   `tetra i j = (4/3)[i = j] − 1/3`, the correlation is `corr(y) = (4/3)Σ_j ⟨e_j, V_y e_j⟩ − 1/3` (because `Σ_j e_j = 1`), so
   by Fourier uniqueness **`3σ + δ₁ = 4Σ_j σ_{e_j}`**, a sum of positive measures with natural-number coefficients. Then
   SI-3 is immediate: `⟨e_j, V_u e_j⟩ = μ(c(0) = j = c(u)) = 0` for `u ∈ U`, and `Πe_j = p_j(0)`, the very `condLaw` that
   `SpectralInputs.si4`'s hypothesis is written in. The tetrahedral coordinates and their Gram algebra leave the path; the
   identity `⟨Σp_ie_i, Σq_je_j⟩ = (4/3)Σp_jq_j − 1/3` of SI-3's proof becomes the definition of `tetra`. The same identity
   serves the factor colouring in (g), with `e″_j = 1{c′(0) = j}`, which is `𝒜`-measurable — so (g)'s "its trace measure is
   carried by `T + A`" is the same lemma applied once more.
2. **Step (d) needs no Bochner theorem, and holds at the class its argument reads.** For any action of a countable abelian
   group by measure-preserving maps, any countably generated filter `l` on the group, any measurable set `A` of characters
   each tending to `1` along `l`, and any `f ⊥ contVec(l)` with spectral measure `σ`: `σ(A) = 0`. The cyclic-subspace
   construction is a limit of real Koopman sums `Σ_y Re(a_y) V_y f`, Cauchy because
   `‖Σ Re(a_y)V_y f‖² + ‖Σ Im(a_y)V_y f‖² = ∫ |Σ a_y χ(y)|² dσ` (σ's coefficients are real), so no symmetry of `σ` under
   `χ ↦ χ̄` is needed; density of trigonometric polynomials in `L²(σ)` is Stone–Weierstrass on the compact dual
   (`ContinuousMap.starSubalgebra_topologicalClosure_eq_top_of_separatesPoints`) with `ContinuousMap.toLp_denseRange`, both
   at the pin (`data/fs131/km11/probes/Names.out`), in place of the record's "Fourier uniqueness applied to the positive and
   negative parts of a complex measure".
