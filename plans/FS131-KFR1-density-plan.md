# FS131-KFR1 — the density form of the collapse at the kernel: the map, the skeleton and the price

*de Bruijn, the planner (Opus), 2026-10-16. Brief `data/fs131/briefs/FS131-KFR1-density.md` (on `main` at `4f8bcf11f`).
Worktree `.claude/worktrees/kcl1`, branch `fs131-kfr1` cut from `main` at `65ee5a95c`. Nothing in this milestone is blind
(`plans/FS131-close-inventory.md` § Rulings in force, ruling 1).*

## Theorems this phase proved

None. A planning job: every new statement below is a skeleton leaf (`sorry`) on branch `fs131-kfr1`, and nothing with a
`sorry` reaches `main`.

## Stage 1 — SAVED: the readback

### 1.1 The quotations

`data/fs131/kfr1/quote_check.py` reads every block quotation of the brief (each run of `> ` lines closed by `> — source:`) and
looks for it, verbatim, in its named source. **All nine are verbatim** (`data/fs131/kfr1/quote_check.out`, exit 0):
W2 (`data/fs131/REQUEST-2026-10-13.md`); the asking lane's § 3.3 entry (`plans/POROS-2026-10-13-number-field-findings.md`,
under the heading "3.3 The first ten…", l. 315; the brief's "§ 3.2" for the rank is the ranking table at l. 295, rank 3,
C22 + C23 — both right); inventory item 1005 (`plans/FS131-close-inventory.md` l. 9439); ledger row 129 (`LEDGER.md`); the
five derivation entries FS103-F-FRAC, -F-TJ, -F-ROUND, -F-TF, -B-AMEN (`plans/FS103-derivation.md`). Control: `--plant`
changes one character of the first quotation and the check reports `MISMATCHES: 1`, exit 1
(`data/fs131/kfr1/quote_check_plant.out`). No mismatch; no finding about the brief.

### 1.2 Each result in my words, what it rests on, what the library holds

Vocabulary (fixed here, used below). `F` a real number field (`F : Subfield ℝ`, `[NumberField F]`); `F² = planeOver F` with
the induced unit-distance graph; `R = ℤ[U_F] = unitRing F`; `U` the unit vectors of `F²`; a *stable prime* `P` a maximal
ideal of `𝓞(F(i))` fixed by conjugation (`SpectralChain.StablePrime`); its level-`m` target `levelTarget P m =
Cay(𝓞/P^m, norm-one)`. `α₁(G)` = `G.finIndepRatio` (inf over nonempty finite vertex sets of `α(G[S])/|S|`, `ℝ≥0∞`,
`Plane/OneClass/Defs`); `m₁ = Plane.mOne`.

- **FRAC (the field clause of row 129).** For a real number field with `R = O′`, *given MR(F)*, every `R ⋊ U`-invariant random
  independent set of `Cay(R, U)` has density at most `α_loc(F) = max(m₁, sup_v r_v)`, `r_v` the all-levels ratio of the
  stable place `v`; hence `α₁(F²) = α_inv(F²) = α_loc(F)`; without MR a denser invariant set is an SP witness. Rests on: the
  Følner step, the per-class SI-3 identity at `T + A`, R-U, MR, the support set, the per-class extension, the product count
  (Zhang's count with the plane factor), and pullbacks for the reverse inequality. **The library holds** every ingredient in
  its *colouring* form (the collapse, `Collapse/`), the count already per colour (`Rigidity/CountDescent.volume_colour_le`,
  `PlaneZhang.sum_volume_inter_sq_le`, `FiniteZhang.ratioLe_pi`), MR as a theorem (`Rigidity.mrPlus`, closing every SP
  witness: `Collapse.not_isSPWitness`), the plane's `α₁(ℝ²) = m₁` (`OneClass.finIndepRatio_plane_eq_mOne`) and the Følner
  machinery on the algebraic plane (`Plane/OneClass/InvariantLaw`). It holds no statement about `α₁(F²)` for a number field.
- **TJ.** Per class: a density-`δ` invariant independent set gives `max(m₁, max_{v ∈ N_δ} r_v) ≥ δ` (`N_δ` the places with
  `λ*_v ≥ δ/(1 − δ)`) or an SP witness; and the mixing selection, per class, keeps only density `≥ (δ − ϑ)/(1 − ϑ)`,
  `ϑ = λ*/(1 + λ*)`. Rests on FRAC's unconditional form and the measurable Hoffman bound. Library: the Hoffman bound per
  place at finite levels (`Rigidity/ClassRatio`, private `ratioAtMost_of_charBound`-shaped lemma at l. 93; `RatioBound`), the
  edge inequality on the completion (`Collapse.mixing_K`, `not_both_heavy`). Nothing per class.
- **ROUND.** Row 123's bound is `χ(F²) ≥ ⌈1/α_loc⌉`; `1/α_loc ≤ 1/δ_Croft ≤ 4.36` at every field, so a density route never gives
  six. Rests on FRAC and Croft's set (`m₁ ≥ δ_Croft = 0.22936…`). Library: `inv_le_finIndepRatio_of_colorable` (a
  `k`-colouring gives `1/k ≤ α₁`); `m₁ ≥ 1/7` only (`OneClass.one_seventh_le_mOne`); `Plane/CoverExamples.disc7` (seven
  classes of closed half-discs, density `2π/(21√3) = 0.1728` each, unit pairs only on the spheres). **Not held: any `m₁ > 1/5`,
  which "never gives six" needs.**
- **TF.** Given MR at `ℚ(√635087)`: for every `ε > 0` a finite triangle-free unit-distance graph with independence ratio
  `≤ m₁ + ε`. Rests on FRAC at that field (every `r_v` below `m₁`) and `√3 ∉ ℚ(√635087)`. Library: the field
  (`Collapse.F635087`), its stable primes (`stablePrime_sqrt635087`: residue `Q²`, `Q ≥ 103`, none above 2).
- **B-AMEN.** With no MR, at every real field: `α₁(F²) = α_inv(F²)` and `α_inv ≥ α_loc` (pullbacks). Rests on Følner,
  averaging, residue homomorphisms. Library: the residue homomorphisms at every level (`UpperHalf.exists_hom_levelTarget`),
  the Følner and averaging lemmas on `E` (`OneClass.exists_foelner_finset` — generic in the group —,
  `IsShiftInvariantLaw.measure_origin_le`, `exists_shiftInvariant_of_foelner`, `exists_turnInvariant` — these three on `E`).
- **Item 1005 (1)**, the splits `six_le_chromaticNumber_planeOver_sqrt635087` and `chromaticNumber_planeOver_sqrt635087_le_seven`:
  one line each from `Collapse.chromaticNumber_planeOver_sqrt635087_six_or_seven`. **(2)**, a field uniformly thick below
  `1/6` (every stable residue size `Q²`, `Q ≥ 142`, none above 2) inhabiting `chromaticNumber_plane_le_of_thick`'s hypotheses
  at `k = 7` with the plane's seven-colouring. Library: `Collapse.thick_of_card`, `Rigidity.two_notMem_of_isSquare`,
  `Rigidity.stablePrime_card_of_two_notMem`, the `635087` instance's pattern (`Collapse/Headline` ll. 101–160).
- **The asking lane's corollary**: a finite triangle-free six-chromatic unit-distance graph. Rests on `6 ≤ χ(ℚ(√635087)²)`
  (the collapse with `[OAIMath2026]`'s six), de Bruijn–Erdős, and `√3 ∉ ℚ(√635087)`.

### 1.3 Findings of the readback (none is a defect of a statement)

1. **The field clause holds wider than written, in the kernel's terms**: at *every* real number field, with no "`R = O′`", no
   "totally real" and no MR hypothesis — the collapse's own widening (item 1005) carries over, because every step the
   per-class line needs is held in a form with neither scope (the completion is the closure of `R`; MR is `Rigidity.mrPlus`).
   Ramified stable primes need no scope either: there `r_P ≥ 1/2 ≥ α₁(F²)` (§ 2.3).
2. **Under the collapse's own hypothesis the density collapses too**: uniformly `c`-thick with `c < 1/5` gives every
   `r_P ≤ c/(1 + c) < 1/6`, and `m₁ ≥ 2π/(21√3) = 0.1728 > 1/6` is two lines from held lemmas (`disc7`'s open part), so
   `α₁(F²) = m₁(ℝ²) = α₁(ℝ²)` and `χ_f(F²) = χ_f(ℝ²)` at every such field — the fractional collapse, beside
   `χ(F²) = χ(ℝ²)`. At `ℚ(√635087)` and de Grey's field with no hypothesis.
3. **ROUND's "never gives six" is not reachable from the kernel's `m₁ ≥ 1/7`, nor from `disc7`** (`1/0.1728 = 5.79`): it
   needs `m₁ > 1/5`. The triangular packing of open discs of radius `1/2` at spacing `2` gives `m₁ ≥ π/(8√3) = 0.2267`
   (`1/m₁ < 4.42`) by `Plane.upperDensity_of_periodic`; Croft's `0.22936` is not needed for the integer statement.

## Stage 2 — SAVED: the map

Each step against the library at `65ee5a95c` (Mathlib `v4.32.0`), by declaration and module; "new" names a piece this plan
adds, with its estimate in lines of Lean (proof and statement; a copy-and-adapt of a held proof is priced at the held proof's
length less what the one-class form drops).

### 2.1 Every use of MR, and `Rigidity.mrPlus`

The five entries use MR in one place: FRAC step 4 ("`τ := σ_g|_{R̂∖E}` … is `a·Haar`"), and through FRAC in TJ (its
alternative (B)), ROUND (its bound is FRAC's), TF ("given MR(ℚ(√635087))") and FRAC step 9 (the unconditional SP clause).
**`Rigidity.mrPlus` discharges every one**, in the form `Collapse.not_isSPWitness` reads it: the one-class measure
`σ' = σ_g|_{(T+A)ᶜ}` is finite, rotation-invariant (`Collapse.rotInv_restrict_compl_TA`), `(T + A)`-null, and has
`∫ Re χ(1) dσ' = −E[p(0)p(1)] ≤ 0`; if it were negative it would be an SP witness at `E = T + A`
(`Collapse.IsSPWitness`), which `not_isSPWitness` (on `Rigidity.positive_entropy_rigidity`) excludes. The derivation's R-U
step (`σ_g(E ∖ (T + A)) = 0`) is not needed: the library's MR⁺ is stated at `T + A` itself (`SpectralChain.MRPlus`). So in
the kernel every entry is **unconditional**, on the declared import `positive_entropy_rigidity` (and Weil's bound only where an
instance proves thickness). FRAC step 9's SP clause becomes a statement about nothing (no SP witness exists); I plan no
separate statement for it.

### 2.2 The steps, held and missing

| step (entry) | held, by name and module | missing (new) | lines |
|---|---|---|---|
| α₁ of a number field's plane, as an object | `SimpleGraph.finIndepRatio`, `le_finIndepRatio_iff`, `finIndepRatio_le_of_embedding` (`Plane/OneClass/Defs`) | `stableRatio P := ⨆ m ≥ 1, ⨆ indep s, ‖s‖ / ‖𝓞/P^m‖` and `localRatio F := max m₁ (⨆ P, stableRatio P)` (`ℝ≥0∞`), API: `card_le_stableRatio`, `ratioAtMost_of_stableRatio_le`, `stableRatio_le_one` | 60 |
| FRAC 8, B-AMEN's pullbacks: `α_loc ≤ α₁(F²)` | `mOne_le_finIndepRatio` (C133-EASY, `Plane/OneClass/Algebraic`, no outside theorem), the embedding `F² ↪ ℂ`; `UpperHalf.exists_hom_levelTarget` (`Arith/UpperHalf`) | the averaging lemma for a Cayley target (`α(G[S]) ≥ ‖S‖·α(H)/‖H‖` for `G →g Cay(A, S)`, translates of a largest independent set); the two inequalities and their `max` | 120 |
| the ramified case | `ChainAtTA.IsRamified`, `colorable_two_levelTarget_one_of_isRamified`, `IsRamified.isDyadic` | `stableRatio P ≥ 1/2` at a ramified `P` (a colour class of the two-colouring); `α₁(F²) ≤ 1/2` (one edge, `finIndepRatio_le_of_forall_card_le` at `{0, 1}`) | 50 |
| FRAC 1 (Følner), B-AMEN's `α₁ ≤ α_inv` | `OneClass.exists_foelner_finset` (generic in the group), `exists_common_fixed`, `avgMeasure` (`Plane/OneClass/InvariantLaw`); `countable_unitRing`; the colouring analogue `Collapse.InvColouring`, `Xk` (`Collapse/Colouring`) | `IndepLaw F` (a law on `unitRing F → Bool` carried by the independent sets of `Cay(R, U)`, shift- and rotation-invariant; `density μ := μ {c | c 0 = true}`); `exists_indepLaw` (density `≥ α₁(Cay(R, U))`: FS-133's `exists_shiftInvariant_of_foelner` and `exists_turnInvariant` re-run on `R`, the rotations of `U`) | 330 |
| B-AMEN's `α_inv ≤ α₁` (averaging) | `IsShiftInvariantLaw.measure_origin_le` (on `E`) | `IndepLaw.density_le_finIndepRatio` on `R` (the same 45-line proof) | 50 |
| `α₁(F²) ≤ α₁(Cay(R, U))` | `finIndepRatio_le_of_embedding`; `UnitRing.unitRingOver_le_planeOverSubring` | the embedding `Cay(R, U) ↪g F²` | 25 |
| FRAC 2 (`U`-invariance of `σ_g`) | `Collapse.IsColourSpectral.rotInv`'s route; `Rigidity.measure_eq_of_fourier`, `exists_isSpectralMeasureOf` | `IsIndicatorSpectral μ σ` (`∫ χ(y) dσ = P(0 ∈ I, y ∈ I)`), `exists_isIndicatorSpectral`, `.rotInv`, `.integral_unit` | 110 |
| FRAC 3–5 (SI-3 per class, MR⁺, the support set) | `Collapse.setIntegral_compl_TA_re_k` and its private helpers (`colourIndK`, `integral_colourIndK_mul_comp`, `condLawK`, `colourCondK` …), `not_isSPWitness`, `Rigidity.isSpectralMeasureOf_condExpL2`, `contChars_tauPrime`, `factorSigma`; the support-set selection `si4K`, `ae_mem_condSupportK` (private, `Collapse/Dichotomy`) | one indicator in place of `k`: `setIntegral_compl_TA_re_one`, `condLaw_orth_of_mrPlus` (`E[p(0)p(u)] = 0` at every `u`), `exists_indepLaw_TA` (the support set `{p > 0}`: an `IndepLaw` with spectrum on `T + A` and density `≥` the given one) | 480 |
| FRAC 6 (extension) | `Collapse.exists_extension_k` (Borel–Cantelli, `measurable_find`, `mem_closure_ιG`, `denseRange_ιG`) | the Bool form with the edge event `c a = true ∧ c (a + u) = true`; continuity in probability from `P(c 0 ≠ c y) = 2(σ(R̂) − Re ∫ χ(y) dσ)`; the one-point law kept (`P(f c g = true) = density`) | 260 |
| the slice with its density | `Collapse.exists_slice_k` (Tonelli over the sample) | `exists_slice_set`: for every window `squareWin a s`, a measurable `W ⊆ ℂ × K` with null `W`–`W` edges and `(vol ⊗ haar)(W ∩ win × K) ≥ density · s²` (the expectation by Tonelli; the null-edge event almost sure) | 140 |
| FRAC 7 (the count, per class) | `Counting.volume_colour_le`, `tendsto_bad` (generic in `φ : ℂ × K → Fin 4` and the colour: applied to the indicator of `W`), `PlaneZhang.sum_volume_inter_sq_le`, `Plane.exists_nrWindow`, `FiniteZhang.ratioLe_pi`, `ratioLe_subgroup`, `Collapse.image_levR_unitVectors_of_unramified` | `rowsEdgeNull_levelRows_set` (the colour-`j` copy of `rowsEdgeNull_levelRows` reading only colour `j`'s edges, under `∀ P, ¬ IsRamified P` in place of `TCA F`), `ratioLe_levR_range_of_unramified` (10 lines), `measure_le_of_setEdgeNull` (the window bound `≤ (max(m₁, c) + 2ε)s₀²`) | 230 |
| FRAC assembled: every `IndepLaw` has density `≤ α_loc`; `α₁(F²) = α_loc` | — | the per-law bound, its ramified case, `finIndepRatio_planeOver_eq_localRatio`, `iSup_density_eq` (B-AMEN) | 120 |
| the fractional form `χ_f(F²) = 1/α_loc` | `fractionalChromaticNumber_mono_of_hom`, `FractionalColorable.fractionalChromaticNumber_le` (`Fractional`), `fractionalChromaticNumber_induce_le`, `fractionalChromaticNumber_plane`, `inv_finIndepRatio_le_iSup_fractionalChromaticNumber` | `χ_f(Cay(A, S)) ≤ ‖A‖/α` (an `α`-fold colouring by the translates of a largest independent set); the two bounds | 120 |
| the thick form and the instances | `Collapse.Thick`, `ThickAt`, `not_isRamified_of_thickAt`, `thick_sqrt635087`, `thick_deGrey`; `ratioAtMost_of_charBound` (private, `Rigidity/ClassRatio`); `disc7`, `disc7_unitPair_mem_sphere`, `disc7_upperDensity`, `volume_frontier_disc7`, `upperDensity_congr_ae` | `ratioAtMost_of_thickAt` (`c`-thick ⟹ ratio `≤ c/(1 + c)`); `two_pi_div_le_mOne` (`m₁ ≥ 2π/(21√3)` from `disc7 0`'s interior); the thick theorem and the two fields | 110 |
| TJ, first clause | the per-law bound; `ratioAtMost_of_thickAt` | `density_le_max_notThick` (the places `δ/(1 − δ)`-thick drop out) | 50 |
| TJ, second clause (the selection per class) | `Collapse.not_both_heavy`, `mixing_K`, `fibreMass` | not planned for the first module (a remark on a construction no theorem uses; § 3.5) | (110) |
| ROUND | `inv_le_finIndepRatio_of_colorable` | `inv_localRatio_le_chromaticNumber`; with the triangular packing, `inv_localRatio_lt_five` | 20 |
| ROUND's cap: `m₁ > 1/5` | `Plane.upperDensity_of_periodic` (`Plane/Slack`), `upperDensity_le_mOne`, `isIndepSet_unitDistance_iff` | `Plane/TriangularPacking`: open discs of radius `1/2` at the triangular lattice of spacing `2`, Borel, 1-avoiding, density `π/(8√3)` | 250 |
| TF and the corollary | `Collapse.F635087`, `chromaticNumber_planeOver_sqrt635087_six_or_seven`; `QuadraticPrime.nonempty_ringHom_padic` (a ring map `ℚ(√d) → ℚ_p` where `d` is a nonzero square mod `p`); Mathlib's `SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom` (as `Bridge`, `Plane/Radius` use it) | `sqrt_three_notMem_F635087` (`p = 17`: `635087 ≡ 1`, `3` a non-square), `cliqueFree_three_planeOver` (a unit triangle puts `√3` in `F`), TF at `ℚ(√635087)`, `exists_finite_triangleFree_six_chromatic` (compactness, then a minimal non-five-colourable subset is exactly six-chromatic) | 230 |
| item 1005 (1), the splits | `chromaticNumber_planeOver_sqrt635087_six_or_seven` | two one-liners | 10 |
| item 1005 (2), the model at `k = 7` | `thick_of_card`, `two_notMem_of_isSquare`, `stablePrime_card_of_two_notMem`, the `635087` pattern | a radicand `d₇` by the Chinese remainder theorem (`d₇ ≡ 7 mod 8`, a non-residue modulo each of the 18 primes `p ≡ 3 (mod 4)` below `142`) — a formula, not a search; `thick_d7 : Thick F (2√142/143)`, `2√142/143 < 1/6`, and the joint hypotheses of `chromaticNumber_plane_le_of_thick` at `k = 7` | 120 |

**Total, new: about 2,840 lines** (2,730 without TJ's second clause; § 3.4 has the per-module table).

### 2.3 Two notes the map turned up

- **The ramified case is free and has to be said.** `image_levR_unitVectors` (the unit vectors' image is the whole product
  connection set) needs no ramified stable prime (`Rigidity/CountResidue`: under `TCA`; `Collapse/Thick`: under
  `∀ P, ¬ IsRamified P`). At a ramified stable prime the level-one target is a perfect matching (`x ~ x + 1`, characteristic
  2, conjugation trivial), so `stableRatio P ≥ 1/2`, and `α₁(F²) ≤ 1/2` by one edge: the equality holds there with no count.
  This is why the kernel statement needs no scope where the derivation had `R = O′`.
- **The triangle-free six-chromatic graph is in reach** from `6 ≤ χ(ℚ(√635087)²)` (held, on
  `Outside.OAI158.no_proper_five_coloring`, `positive_entropy_rigidity` and Weil's bound): compactness gives a finite subset
  of `ℚ(√635087)²` with no five-colouring; a minimal one is six-chromatic (one vertex adds at most one colour); `√3 ∉
  ℚ(√635087)` makes it triangle-free. **Price: about 150 of the 230 lines above.** Prior art for "a finite triangle-free
  unit-distance graph with `χ = 6`": not searched by this job (prior-art debt for the asking lane; `[OAIMath2026]`'s graphs
  hold `ζ₆`).
