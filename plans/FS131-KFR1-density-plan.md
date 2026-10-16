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
