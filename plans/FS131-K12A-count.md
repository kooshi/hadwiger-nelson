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
