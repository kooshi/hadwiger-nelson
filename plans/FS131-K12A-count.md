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
