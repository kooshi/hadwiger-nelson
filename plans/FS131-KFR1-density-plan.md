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

## Stage 3 — SAVED: the skeleton, the plan per leaf, the price

The coordinator's ruling (inventory item 1008, received during stage 2) adopts all three findings of § 1.3. The widest form
is the head statement. The fractional collapse is a theorem beside it. The disc module is part of this plan.

### 3.1 The skeleton (four new modules, 79 leaves, on `fs131-kfr1` only)

| module | contents | leaves |
|---|---|---|
| `Collapse/Density/Defs` (D1) | `stableRatio`, `localRatio`, `IndepSets`, `IndepLaw`, `IndepLaw.density`, `SetEdgeNull`; the lower half; the ramified bound; Hoffman from thickness; `disc7_le_mOne`, `sixth_lt_mOne` | 19 |
| `Collapse/Density/Upper` (D2) | `cayR`, `indShift`, `factorOne`, `condOne`, `IsIndicatorSpectral`, `setCol`; Følner, averaging, the per-class dichotomy, the extension, the slice, the count, the per-law bound | 19 |
| `Plane/TriangularPacking` (D4) | `triCentre`, `triPacking`; independence, periodicity, density `π/(8√3)`, `pi_div_le_mOne`, `fifth_lt_mOne` | 9 |
| `Collapse/Density/Headline` (D3) | the head statements, B-AMEN, `χ_f`, the fractional collapse and its instances, TJ, ROUND, TF, the corollary, item 1005's splits (proved) and the model at `k = 7` (`d7`, `F7`) | 22 + 2 proved |

Each module elaborates (`data/fs131/kfr1/seq.sh`, logs under `data/fs131/kfr1/logs/`), and the build is
`data/fs131/kfr1/build.log` (§ 3.6). The stored types of the head statements were printed from the compiled modules
(`data/fs131/kfr1/KernelSigs.lean`, `kernel-sigs.out`). Every binder is the one written. `inv_localRatio_lt_five` takes no
`[NumberField F]`: `localRatio F ≥ m₁` at every `F`. The splits print `[propext, Classical.choice, Quot.sound,
positive_entropy_rigidity, kloosterman_bound, no_proper_five_coloring]`, which is the six-or-seven corollary's list.

### 3.2 Read aloud against row 129 and the entries

- `finIndepRatio_planeOver_eq_localRatio : α₁(F²) = max(m₁(ℝ²), ⨆_P r_P)` for every `F : Subfield ℝ` with
  `[NumberField F]`. Row 129 says "given MR(F) … `α₁(F²) = α_loc(F)`, `α_loc(F) = max(m₁(ℝ²), sup_v r_v)` (`r_v` a stable
  place's all-levels independence ratio)". The two match term for term: `α₁` is `finIndepRatio` of the induced
  unit-distance graph on `planeOver F`; `m₁` is `Plane.mOne`, the same constant as FS-133's equality; `v` ranges over
  `StablePrime F`; `r_v` is the supremum over `m ≥ 1` of `levelTarget P m`'s ratio. One reading note: `levelTarget` uses
  *every* norm-one residue, where the derivation uses the image of `U`. At an unramified prime the two are equal (`[S9]`,
  `image_levR_unitVectors_of_unramified`). At a ramified prime both sides of the equality are `1/2`. The statement is wider
  than the row: there is no MR hypothesis, no `R = O′`, and no requirement that `F` be totally real.
- `finIndepRatio_planeOver_eq_iSup_density` is B-AMEN's `α₁ = α_inv`, with `α_inv` the supremum of `P(0 ∈ I)` over
  `R ⋊ U`-invariant laws (`IndepLaw`). That is FRAC's definition.
- `fractionalChromaticNumber_planeOver_eq`, `χ_f(F²) = 1/α_loc(F)`, is the "fractional local–global principle" of row 129's
  title, stated for `χ_f` itself.
- The fractional collapse, at `Thick F c` with `0 ≤ c < 1/5` (the collapse's own hypothesis), gives `α₁(F²) = m₁ = α₁(ℝ²)`
  and `χ_f(F²) = χ_f(ℝ²)`. At the two fields it holds with no hypothesis.
- TJ's first clause is stated with `N_δ` as "`c`-thick for no `c < δ/(1 − δ)`" (`λ*_v ≥ δ/(1 − δ)`). Its second clause, the
  selection's density loss, is **not stated** (§ 3.5).
- ROUND: `1/k ≤ α_loc` for a `k`-colourable `F²`, and `1/α_loc < 5`. Together they are "this route gives at most five". The
  ceiling form `χ ≥ ⌈1/α_loc⌉` is the first statement read at the integer `k`.
- TF: for `ε > 0`, a nonempty finite `S ⊂ ℂ` whose unit-distance graph is `CliqueFree 3` and has `α(S) < (m₁ + ε)|S|`. The
  entry's "`≤ 0.24699 + ε`" is `m₁ ≤ 0.2470` (`Plane.mOne_le_of_oneAvoidingDensityBound`). It is not restated.
- The corollary: a finite `S ⊂ ℂ`, `CliqueFree 3`, with `χ = 6` exactly.
- **Not claimed** anywhere: a value of `m₁` or `χ_f(ℝ²)`; anything at six colours beyond the corollary; that the fractional
  forms are new.

### 3.3 The plan, per leaf

Routes name held declarations, and each name was read in its module at `65ee5a95c`. Leaves marked **(copy)** adapt a held
proof of the colouring namesake; the edits listed are the only changes.

**D1.**
- `card_div_le_stableRatio`: `le_iSup₂_of_le` four times.
- `ratioAtMost_of_stableRatio_le`: `ENNReal.div_le_iff`. The quotient is finite and nonempty: `finite_quot_pow` is private in
  `Rigidity/ClassRatio`, so use `Ideal.finiteQuotientOfFreeOfNeBot` as there.
- `stableRatio_le_one`: `Finset.card_le_univ`.
- `half_le_stableRatio_of_isRamified`: take the larger colour class of `colorable_two_levelTarget_one_of_isRamified` at
  `m = 1`. A two-way pigeonhole on `Finset.univ.filter` gives `2·|class| ≥ |A|` (`noRamifiedStableDyadic_of_tca`'s proof,
  `Rigidity/ChainAtTA` l. 556, does the same).
- `ratioAtMost_of_thickAt`: `open private ratioAtMost_of_charBound from Proofs.HadwigerNelson.Rigidity.ClassRatio`, with
  `CharBound` from `ThickAt` by `Complex.re_le_norm` (`|Re z| ≤ ‖z‖`; `levelSet P m = normOneQ P m` by `rfl` — **check**).
  If `open private` is ruled out, reprove it from `RatioBound.card_mul_le_of_indep` (40 lines).
- `stableRatio_le_of_thickAt`: from the line above, `iSup₂_le`.
- `card_div_le_finIndepRatio_of_hom`: `le_finIndepRatio_iff`. For a nonempty finite `S`, count
  `Σ_{a ∈ A} |S ∩ φ⁻¹(s + a)| = |S|·|s|` (`Finset.sum_comm`, `Finset.card_eq_sum_ones`). Some `a` reaches the average
  (`Finset.exists_le_card_fiber_of_mul_le_card`, or `Finset.exists_lt_of_sum_lt` read contrapositively). `φ⁻¹(s + a) ∩ S`
  is independent by `hH` and `φ.map_adj`, and `card_le_indepNum_induce` closes. About 70 lines.
- `levelTarget_adj_add`: `SimpleGraph.fromRel_adj`, `add_sub_add_right_eq_sub`.
- `stableRatio_le_finIndepRatio`: `iSup₂_le`, `UpperHalf.exists_hom_levelTarget`, the averaging lemma, `Finite` of the
  quotient.
- `mOne_le_finIndepRatio_planeOver`: `OneClass.mOne_le_finIndepRatio.trans (finIndepRatio_le_of_embedding (Embedding.induce _))`.
- `localRatio_le_finIndepRatio`: `max_le` and `iSup_le`.
- `finIndepRatio_planeOver_le_half`: `finIndepRatio_le_of_forall_card_le` at `S = {0, 1}`, `a = 1`.
- `disc7_le_mOne`: `upperDensity_le_mOne` at `interior (disc7 0)`. Independence: a unit pair of `disc7 0` lies on its spheres
  (`disc7_unitPair_mem_sphere`), so it is not in the interior. The density is `upperDensity_congr_ae` from
  `volume_frontier_disc7`, then `disc7_upperDensity`.
- `sixth_lt_mOne`: `2π/(21√3) > 1/6` ⟺ `12π > 21√3`, with `Real.pi_gt_three` and `√3 < 7/4` (`Real.sqrt_lt'`).
- `isClosed_indepSets`, `measurableSet_indepSets`: `Collapse/Colouring`'s `isClosed_Xk`, `measurableSet_Xk` **(copy)**.
- `nonempty_indepLaw`: the point mass at `fun _ => false`, as `OneClass.isInvariantLaw_dirac`, with `countable_unitRing`.
- `setEdgeNull_empty`: `simp`.

**D2.**
- `measurePreserving_shift`: `⟨measurable_pi_lambda …, μ.shift_inv y⟩`.
- `finIndepRatio_planeOver_le_cayR`: the embedding `x ↦ ⟨x, unitRingOver_le_planeOverSubring F x.2⟩`. Its adjacency iff is
  `Complex.dist_eq` together with "`|y − x| = 1` and `y − x ∈ planeOver F` is `y − x ∈ unitVectors F`".
- `exists_indepLaw` **(copy, FS-133 on `R`)**. Steps:
  - `OneClass.exists_foelner_finset (unitRing F)`.
  - A largest independent subset `J n ⊆ F n` (`le_finIndepRatio_iff`).
  - `exists_shiftInvariant_of_foelner`'s proof with `E` replaced by `unitRing F` and `shiftLab` by `indShift` (90 lines).
  - The rotation step through `OneClass.exists_common_fixed` on the closed class "carried by `IndepSets F`,
    shift-invariant, origin law fixed". `Collapse/Colouring`'s `exists_invColouring` steps at `Bool` do exactly this. The
    covariance is `shift_y ∘ rot_u = rot_u ∘ shift_{u y}`.
  - About 230 lines.
- `IndepLaw.density_le_finIndepRatio` **(copy)**: `OneClass.IsShiftInvariantLaw.measure_origin_le`'s proof on `R`. The
  independence of the random set's trace on `S` is from `carried`.
- `exists_isIndicatorSpectral`: `exists_isSpectralMeasureOf indShift μ.measurePreserving_shift indShift_add` at
  `indicatorConstLp 2 … 1`. The coefficient is `Collapse/Dichotomy`'s `integral_colourIndK_mul_comp` **(copy at `Bool`,
  `j = true`)**.
- `.rotInv` **(copy)** of `IsColourSpectral.rotInv`, with the event `{c 0 = true ∧ c (u y) = true}`.
- `.integral_unit`: `carried` at the pair `(0, u)`.
- `factorOne`, `condOne`: definitions. `condOne` is `condExp`, the `μ[·|𝒜]` notation written out.
- `setIntegral_compl_TA_re_one` **(copy)** of `setIntegral_compl_TA_re_k`'s body with one `j`.
  - Its helpers, copied: `colourCondK` → `indCond := condExpL2 … (indicatorConstLp …)`, `colourCondK_ae_eq_condLawK`,
    `condLawK_comp_colourShiftK`, `integral_colourCondK_mul_comp`.
  - The `Finset.sum` and `colour_decomp` drop out, since the measure *is* the indicator's.
  - About 150 lines.
- `integral_condOne_mul_eq_zero`. Let `σ' = σ.restrict (TA F)ᶜ`.
  - `hpos`: `0 ≤ E[p(0)p(u)]` (`integral_nonneg_of_ae`, `condExp_nonneg`).
  - `hrot`: `setIntegral_compl_TA_rot_k`'s proof **(copy)**.
  - If `∫ Re χ(1) dσ' < 0`, then `⟨_, rotInv_restrict_compl_TA hσ.rotInv, restrict_compl self, h⟩ : IsSPWitness F (TA F) σ'`
    contradicts `not_isSPWitness le_rfl`.
  - So the integral is `0` at `1`, hence at every `u`, and the identity gives `0`.
  - About 50 lines.
- `exists_indepLaw_TA`. The support set is `J ω x := decide (0 < condOne μ x ω)`, with `si4K`'s pattern: the version
  `p(x) = p(0) ∘ shift_x`.
  - From `integral_condOne_mul_eq_zero` and `p ≥ 0`, `p(0)p(u) = 0` a.s.: `integral_eq_zero_iff_of_nonneg_ae`.
  - By shift-invariance and countability of `R × U`, `J` is a.s. independent: `Collapse/Dichotomy`'s
    `ae_condLawK_mul_eq_zero` **(copy at `Bool`)**.
  - `J ⊇ I` a.s.: `measure_condLawK_nonpos_inter` **(copy)**.
  - Shift and rotation invariance of `J`'s law: `factorColouringK_shift_ae`, `_rot_ae` **(copy)**.
  - Spectrum on `T + A` (`J` is `𝒜`-measurable): `factorLawK_spectral_null` **(copy)**.
  - The density inequality: `J ⊇ I`.
  - About 230 lines, half of `Collapse/Dichotomy`'s factor block.
- `tendsto_measure_ne_one` **(copy)** of `tendsto_measure_ne_k`. Its first line becomes
  `P(c 0 ≠ c y) = 2(P(c 0) − P(c 0 ∧ c y)) = 2(σ(R̂) − Re ∫ χ(y) dσ)`: the law is shift-invariant, so
  `P(c y) = P(c 0)`. About 70 lines.
- `exists_extension_one` **(copy)** of `exists_extension_k`, about 170 lines:
  - `Fin k` becomes `Bool`.
  - `measure_eq_add_unit_k` becomes the event `c a ∧ c (a + u)`, null by `carried`.
  - The edge set `C m` becomes `{c (π m g) ∧ c (π m (g + t))}`.
  - New, about 25 lines: the one-point law `μ{f c g = true} = density`. It holds for `g = ιG r` by `Nat.find` stability,
    and in general as a limit of `P(c(π n g))`, a constant sequence by shift-invariance.
- `exists_slice_set` **(copy)** of `exists_slice_k` for the null edges. The density bound is new, about 40 lines: Tonelli
  (`Measure.prod_apply_symm`) gives `∫ (vol ⊗ haar)(W_c ∩ win × K) dμ = density · s²`. Then `exists_lt_of_lintegral_lt`
  (or the contrapositive of `lintegral_mono`) intersected with the almost-sure null edges (`Eventually.and`, `.exists`
  with `Filter.Frequently`). About 120 lines.
- `ratioLe_levR_range_of_unramified`: `Counting.ratioLe_levR_range`'s proof **(copy, 10 lines)** with
  `image_levR_unitVectors_of_unramified`.
- `rowsEdgeNull_levelRows_set` **(copy)** of `rowsEdgeNull_levelRows`, about 85 lines. `image_levR_unitVectors` becomes the
  unramified form. `hAB` reads "both in `W`" through `setCol` (`if_pos`), and `hM0` is `SetEdgeNull`.
- `exists_window_bound`: `false_of_slice`'s window block with no sum, about 70 lines. Ingredients: `exists_nrWindow`;
  `volume_colour_le` and `tendsto_bad` at `φ = setCol W`, `j = 1`; `{p | setCol W p = 1} = W` (`decide`/`if`);
  `sum_volume_inter_sq_le` with `ratioLe_levR_range_of_unramified`.
- `density_le_max_of_unramified`: for each `ε`, the window `s₀`, then `exists_slice_set` (after `exists_indepLaw_TA`) at
  `(0, s₀)` and `exists_window_bound`. Divide by `s₀²` and let `ε → 0` (`ENNReal.le_of_forall_pos_le_add`). About 40 lines.
- `density_le_localRatio`, about 40 lines. Ramified case (`by_cases`): `density_le_finIndepRatio`, `cayR`'s ratio `≤ 1/2`
  (its edge `0 ~ 1`), and `half_le_stableRatio_of_isRamified`. Unramified case: `c := (⨆ P, stableRatio P).toReal`, which
  is `≤ 1` by `stableRatio_le_one`, and `ratioAtMost_of_stableRatio_le`.

**D4.**
- `zero_mem_triPacking`, `measurableSet_triPacking`: `isOpen_iUnion`, `isOpen_ball`.
- `two_le_dist_triCentre`: `|2a + b + bi√3|² = 4(a² + ab + b²)`, and `a² + ab + b² ≥ 1` for `(a, b) ≠ 0` (`nlinarith`, or
  `omega` after `Int` casts).
- `isIndepSet_triPacking`: `isIndepSet_unitDistance_iff`. One disc gives distance `< 1` (`dist_triangle`). Two discs give
  distance `> 2 − 1`.
- `triPacking_periodic`: reindex `(m, n) ↦ (m + 1, n)` and `(m, n + 1)`.
- `linearIndependent_triLattice`: `LinearIndependent.pair_iff`, with imaginary parts `0` and `√3 ≠ 0`.
- `upperDensity_triPacking`, about 120 lines: `upperDensity_of_periodic`, then the cell measure. Model it on
  `Plane/CoverExamples.volume_disc7_cell`, about 130 lines there: the parallelogram holds, up to translation by lattice
  vectors, exactly one disc. The cell's area is `2√3`.
- `pi_div_le_mOne`: `upperDensity_le_mOne`.
- `fifth_lt_mOne`: `π/(8√3) > 1/5` ⟺ `5π > 8√3`.

**D3.**
- `finIndepRatio_planeOver_eq_localRatio`: `le_antisymm` of the chain `α₁(F²) ≤ α₁(cayR) ≤ density μ ≤ localRatio`
  (`finIndepRatio_planeOver_le_cayR`, `exists_indepLaw`, `density_le_localRatio`) and `localRatio_le_finIndepRatio`.
- `finIndepRatio_planeOver_eq_iSup_density`: the same chain with `density_le_finIndepRatio`.
- `fractionalChromaticNumber_le_card_div`, about 50 lines. `FractionalColorable H |s| |A|` by `x ↦ {a : x − a ∈ s}`, through
  `Fintype.equivFin`. Then `FractionalColorable.fractionalChromaticNumber_le`.
- `fractionalChromaticNumber_planeOver_eq`, about 70 lines.
  - `≥`: `inv_finIndepRatio_le_iSup_fractionalChromaticNumber`, `fractionalChromaticNumber_induce_le`, the head statement.
  - `≤ 1/m₁`: `fractionalChromaticNumber_induce_le`, `OneClass.fractionalChromaticNumber_plane`.
  - `≤ |A|/|s|` at every level: `fractionalChromaticNumber_mono_of_hom`.
  - So `≤ (max …)⁻¹` by `ENNReal.inv_iSup`-style algebra.
- `localRatio_eq_mOne_of_thick`: `stableRatio_le_of_thickAt`, `c/(1 + c) < 1/6 < m₁` (`sixth_lt_mOne`).
- The thick forms and the four instances: one line each from the head statement, `fractionalChromaticNumber_planeOver_eq`,
  `fractionalChromaticNumber_plane`, `thick_sqrt635087`, `thick_deGrey` and the constants' `< 1/5` (held in
  `Collapse/Headline`'s instance proofs).
- `IndepLaw.density_le_notThick`, about 90 lines. The places `c`-thick for some `c < δ/(1 − δ)` have `r_P ≤ c/(1 + c) < δ`.
  The remaining difficulty is that their supremum stays `< δ`. That needs `r_P → 0` along the stable primes: Weil
  (`ratioAtMost_weil`, private in `Rigidity/ClassRatio`), `exists_uniform_tail`'s pattern with the constant made small, and
  `finite_stablePrime_absNorm_le`. Then a case split on the attained maximum.
- `inv_le_localRatio_of_colorable`: `inv_le_finIndepRatio_of_colorable` and the head statement.
- `inv_localRatio_lt_five`: `fifth_lt_mOne`, `le_max_left`, `ENNReal.inv_lt_iff_inv_lt`.
- `cliqueFree_three_planeOver_of_sqrt_three_notMem`, about 60 lines. Three pairwise unit points `x, y, z` give
  `w = (z − x)/(y − x) ∈ planeOver F` with `|w| = |w − 1| = 1`. Then `Re w = 1/2` and `(Im w)² = 3/4`, so
  `√3 = ±2 Im w ∈ F`.
- `sqrt_three_notMem_F635087`, about 50 lines. `QuadraticPrime.nonempty_ringHom_padic {635087}` at `p = 17` (`635087 ≡ 1`)
  gives `ι : F → ℚ_[17]`, and `ι(√3)² = 3`. Then `‖ι √3‖ = 1`, the residue in `ZMod 17` squares to `3`
  (`PadicInt.toZMod`), and `decide` refutes it.
- `exists_triangleFree_ratio_lt`: the head instance, the definition of `⨅` (`iInf_lt_iff`), and the triangle-freeness carried
  by `Embedding.induce`. About 30 lines.
- `exists_finite_triangleFree_six_chromatic`, about 90 lines.
  - Not five-colourable: `six_le_chromaticNumber_planeOver_sqrt635087`.
  - Compactness: `SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom`, contrapositive, as `Plane/Radius` uses it. This
    gives a finite `S₀` with no five-colouring.
  - `Finset.exists_minimal` on `{S ⊆ S₀ | ¬ Colorable 5}`.
  - Minimality gives `Colorable 6`: delete a vertex, colour the rest with five colours, and give the vertex the sixth. So
    `χ = 6` by `chromaticNumber_eq_iff_colorable_not_colorable`.
  - `CliqueFree 3` is carried by the embedding into `planeOver F635087`.
- Item 1005's splits: proved (`.1`, `.2`).
- `stablePrime_F7`, about 60 lines, the pattern of `stablePrime_sqrt635087` and `le_of_isSquare_635087`.
  `two_notMem_of_isSquare` holds since `d₇ % 8 = 7` (`decide`). `interval_cases` runs over the eighteen primes, each
  refuted by `decide +kernel` on `IsSquare ((d₇ : ℕ) : ZMod p)`; the residues are small. **Measure** the `decide` on a
  31-digit numeral cast to `ZMod p`: `Nat.cast` reduces modulo `p` by `Nat.mod`, GMP-backed.
- `weil_142_lt_sixth`: `√142 < 143/12` ⟺ `142·144 < 143²` (`20448 < 20449`), with `Real.sqrt_lt'`.
- `exists_model_seven`: `thick_of_card (B := 142)` with `stablePrime_F7`, `weil_142_lt_sixth`, and the plane's
  seven-colouring restricted (`Instances.plane_colorable_seven`, `Colorable.mono_left` with `Embedding.induce`).

### 3.4 The price, in lines of Lean

| module | lines |
|---|---|
| D1 `Collapse/Density/Defs` | 380 |
| D2 `Collapse/Density/Upper` | 1,370 |
| D4 `Plane/TriangularPacking` | 250 |
| D3 `Collapse/Density/Headline` | 650 |
| **total** | **about 2,650** |

The total is below stage 2's 2,840 because the leaves, priced one by one, reuse more than the table assumed (the count's
descent is reused, not copied). D2 is the long pole, and two-thirds of it is copy-and-adapt of `Collapse/Dichotomy` and
`Collapse/Slice`. Re-price from the first two leaves (`CLAUDE.md` § What compute actually helps). The cheapest order that
shows the head statement's shape early:
1. D1 and D4, which hold no MR and no spectral theory.
2. D2's count and Følner leaves, which reuse held proofs with small edits.
3. D2's dichotomy and extension.
4. D3.

One implementer, sequential, since D3 needs everything. D1 and D4 could be split off to a second implementer.

### 3.5 Choices made, with the alternative

- **`TJ`'s second clause is not stated.** It is "the mixing selection, per class, keeps only density `≥ (δ − ϑ)/(1 − ϑ)`".
  It is a statement about a construction that no theorem uses: the derivation records it to explain why the selection is not
  the tool for the ratio. A statement would be `Collapse.not_both_heavy` composed with Markov's inequality over `fibreMass`,
  about 110 lines. I would add it only on Keryx's word. Confidence that it belongs to no headline: high.
- **The colouring privates are copied, not opened.** The alternative is to read `Collapse/Dichotomy`'s private helpers with
  Batteries' `open private` (LEAN.md's `Rigidity/BochnerTau` precedent). That saves about 200 lines, but it ties a
  published module to another's private names. `ratioAtMost_of_charBound` is the one place I would open a private: it is
  40 lines, and a copy duplicates a Hoffman proof. The implementer may also draft making it public, an edit to
  `Rigidity/ClassRatio` that is Keryx's to rule.
- **Item 1005's two owed items live in the new `Collapse/Density/Headline`**, not in `Collapse/Headline`. The brief makes
  existing modules draft-only. `exact?` finds them in either place.

### 3.6 The experience-modeling pass (`debruijn-experience-modeling`, on the head statements and the definitions)

Read as the user holding the goal `((unitDistance ℂ).induce (planeOver F)).finIndepRatio = ?`, as `exact?`, and as a
reader of the docstrings with nothing else.

- **Shape.** The left sides are the ones the library already uses for `χ` and `α₁`: the induced graph on `planeOver F`, and
  `finIndepRatio`/`fractionalChromaticNumber` as FS-133 wrote them. The names follow the collapse's own:
  - `finIndepRatio_planeOver_sqrt635087` matches `chromaticNumber_planeOver_sqrt635087`;
  - `fractionalChromaticNumber_planeOver_eq_plane_of_thick` matches `chromaticNumber_planeOver_eq_plane_of_thick`;
  - so a reader who knows one predicts the other. No change.
- **The new definitions were a hide.** `localRatio` and `stableRatio` had no reasoning surface: a user bounding `α_loc` would
  have had to unfold a `max` of an `iSup`, and the bridge to the count's `RatioAtMost` ran one way only, which implies that
  the converse is hard. **Changed:** four leaves added to D1 — `mOne_le_localRatio`, `stableRatio_le_localRatio`,
  `localRatio_le_iff` (the reasoning surface of an upper bound, as `mOne_le_iff` is `m₁`'s), and `stableRatio_le_of_ratioAtMost`
  (the converse; five lines). D1 now has 23 leaves, the skeleton 83; the price moves by about 25 lines.
- **The fractional collapse states both members.** It is given as `α₁(F²) = m₁` and as `α₁(F²) = α₁(ℝ²)`, and `χ_f` likewise,
  so a user holding either right side finds a closing lemma. No change.
- **One vocabulary.** "Stable prime", "residue target", "all-levels ratio" and "uniformly `c`-thick" are the words the
  collapse's modules use. `IndepLaw` is `InvColouring`'s one-class namesake, said so in its docstring. No change.
- **Breakdown.** A user who tries the head statement at a field without `[NumberField F]` gets "failed to synthesize
  `NumberField ↥F`" at the statement. That is the true obligation: the residue rings are finite only there. No change.
