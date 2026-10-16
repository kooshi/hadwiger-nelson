# FS131-IQP1 — the p-adic plane in the kernel: the skeleton's leaves proved, the build and the gate

*de Bruijn, the kernel lane's implementer. Brief `data/fs131/briefs/FS131-IQP1-padic.md` (on `main`; a copy is
`data/fs131/iqp1/brief-copy.md`). Worktree `.claude/worktrees/il5`, branch `fs131-kpa1`, from `8f5f0e3fd`. The plan is
`plans/FS131-KPA1-padic-plan.md`. No fence. Started 2026-10-16.*

## Theorems this phase proved

Elaborated under `lake env lean` (iteration only; the build is the evidence, stage 7), axioms to be printed at the gate:

- `PadicPlane.towerRatio_one`, `not_colorable_of_towerRatio`, `norm_le_one_of_sq_add_sq_eq_one` (`PadicPlane/Basic`).
- `PadicPlane.ratioAtMost_of_charSum_levelOne`, `exists_stablePrime_above`, `exists_levelEmbedding`,
  `towerRatio_of_ratioAtMost`, `charSum_levelOne_of_unitCircle`, `charSum_unitCircle_ge_weil`,
  `towerRatio_of_fibreShareBound` (`PadicPlane/Tower`).
- `PadicPlane.res_surjective`, `isOpen_res_fibre`, `haar_univ`, `haar_res_fibre`, `exists_unitVector_lift`,
  `isIndepSet_wellFilled`, `exists_level_haar_bad_le`, `haar_le_of_towerRatio`, `one_le_mul_of_borelColoring`,
  `le_borelChromaticNumber_of_towerRatio` (`PadicPlane/Measure`).
- `PadicPlane.exists_residueMap`, `exists_borelColoring_of_colorable`, `borelChromaticNumber_le_chromaticNumber`
  (`PadicPlane/Upper`).

## Stage 1 — SAVED: the readback

### 1.1 The quotations

Five quotations in the brief, each checked mechanically against its named source with line breaks folded, by the
planner's checker run unchanged (`tools/fs131_kpa1_quotes.py data/fs131/iqp1/brief-copy.md --root .`, output
`data/fs131/iqp1/quotes.out`): **all five verbatim** — W2 in `data/fs131/REQUEST-2026-10-13.md`; inventory items 997 and
999 in `plans/FS131-close-inventory.md` (this worktree's copy, merged from `main` at `8f5f0e3fd`); the four head
statements and the six value statements in `Proofs/HadwigerNelson/PadicPlane/Values.lean`. The checker's planted control
(one character of the first quotation changed) is refused, exit 1 (`data/fs131/iqp1/quotes-plant.out`).

### 1.2 The targets

Every `sorry` of `PadicPlane/{Basic, Measure, Upper, Tower, Values}` (38 leaves, the plan's § 3.3), proved without a
change to any stored statement, with three exceptions the ruling of inventory item 999 (2) makes: the leaves at 23 that
need a certificate nobody has yet leave the landing's modules, their statements and plans kept below (§ 1.4). The head
statements are the four of the brief's § The statements (`le_borelChromaticNumber_of_charSum`,
`one_add_div_le_of_borelColoring`, `le_borelChromaticNumber_padicPlane`,
`not_exists_bound_borelChromaticNumber_padicPlane`) and the values at 3, 7, 11, 19, with `≤ 8` at 23. T0 goes by route A
(public pieces; no edit to `Rigidity/ClassRatio.lean`; ruling (1) of item 999). The certificate at 7 (leaf C7) is three
new modules `Arith/FibreCert7`, `FibreCert7Check`, `FibreCert7Bound`, generated from FS-66's `cert-p7.json` by the
library's generator, as the plan measured.

### 1.3 The order of work

The plan's (§ 3.3), with the price re-measured on the first two leaves of each kind: Tower T1–T3 (the number-field
bridge); Basic B1–B3; Tower T4, T5, T6, T0; Measure M1–M10; Upper U1–U3; the certificate C7; Values. A saved stage after
each module.

### 1.4 The leaves at 23

Item 999's ruling (2) names `six_le_borelChromaticNumber_padicPlane_twentyThree`. Two more skeleton statements rest on the
same missing certificate: `fibreShareBound_twentyThree` (C23 itself) and
`unitQuadrance_zmod_twentyThree_pow_not_colorable_five` (it needs `5·U/529 < 1`, so `U < 105.8`). Neither held bound
reaches them: Weil's ratio at 23 is `2√23/(24 + 2√23) = 0.2855…` and `5 · 0.2855 = 1.43 > 1`; the `κ` form at
`κ = −λ_min(Γ₂₃) ≈ 7.97` gives `5κ/(24 + κ) = 1.25 > 1`. Told to the coordinator by message at stage 1 (2026-10-16): the
three leave the landing's modules together, their statements kept here verbatim, and the held lower bound at 23 is
`4 ≤ χ_Bor(ℚ₂₃²)` (`le_borelChromaticNumber_padicPlane 23`: `⌈1 + 24/(2√23)⌉ = ⌈3.502…⌉ = 4`).

### 1.5 The stored statements before the first proof

`data/fs131/iqp1/lean/StatementDump.lean` — FS131-ICO1's dumper (read in that job's worktree, not written there) with
this job's five modules — run against the compiled skeleton before any rebuild (`lake build --no-build Proofs` first:
"All targets up-to-date", `data/fs131/iqp1/uptodate0.log`; no file of `Proofs/` differs between the planner's last
commit `621ccacc4` and `8f5f0e3fd`): `data/fs131/iqp1/statements-before.txt`, 65 constants (Basic 11, Measure 19,
Upper 5, Tower 9, Values 21). The gate compares the built modules' dump against it.

### 1.6 The coordinator's answer (inventory item 1002)

All three leaves at 23 leave the landing's modules, statements and plans kept here; `four_le_borelChromaticNumber_padicPlane_twentyThree`
is added beside `…_twentyThree_le_eight`; optionally `5 ≤` by the `κ` form if the character-sum bound at 23 is a cheap
finite check. **It is held already:** `CircleCos.circleCos_ge` (public, `Arith/CircleCos`, `check23` by `decide +kernel`)
bounds every non-trivial cosine sum over the circle of `𝔽₂₃²` below by `−κ'·24` with `κ' < 1/3`, so `κ = 24κ' < 8` and
`⌈1 + 24/κ⌉ ≥ 5`. What it costs is the translation from `AddChar (ZMod p × ZMod p) ℂ` to the cosines (about 50 lines);
decided at the Values stage, recorded there.

## Stage 2 — SAVED: `PadicPlane/Basic` and `PadicPlane/Tower`

Every leaf of the two modules proved; each file elaborates under `lake env lean` with the lakefile's two options and no
warning (`data/fs131/iqp1/probe/tower.log` empty). No stored statement touched.

**`Basic` (3 leaves, 105 lines against the plan's 90).** B1 by `Finset.card_le_univ`; B2 by the colour classes as
`Finset.univ.filter`, summed fibrewise. B3 by the route the docstring states, with one change: no ultrametric case split
is needed — with `‖b‖ ≤ ‖a‖` and `‖a‖ > 1`, `u = b/a` is integral and `1 + u² = a⁻²` has norm below `1`, so the residue of
`u` squares to `−1` in `𝔽_p`. That `−1` is not a square at `p ≡ 3 (mod 4)` is proved here in 30 lines from
`orderOf_dvd_card` (a square root of `−1` is a unit of order `4`, and `4 ∤ p − 1`): neither `ZMod.exists_sq_eq_neg_one_iff`
nor `FiniteField.isSquare_neg_one_iff` is in `Basic`'s import closure, and an added import can move stored statements
(`LEAN.md` § Searching — Lean). Two private helpers: `not_sq_eq_neg_one`, `norm_le_one_of_le_of_sq_add_sq`.

**`Tower` (7 leaves, 435 lines against the plan's 540 by route A).** T0 by route A as ruled: Hoffman
(`RatioBound.card_mul_le_of_indep`) at each level `n + 1` with `m = κQ^n`, every non-trivial character either descended
(`FibreShare.exists_eq_compAddMonoidHom`, then Hensel's count `Rigidity.henselCount_of_two_notMem` fibre by fibre: the sum
is `Q^n` times a level-one sum) or new (`Rigidity.newCharBound_of_two_notMem`: `‖Σ‖ ≤ 2Q^n ≤ κQ^n`); `|S_{n+1}| =
Q^n(Q + 1)` by the same count and `|S₁| = Q + 1` (`StandingFive.card_normOne` once the norm-one set is `{u^(Q+1) = 1}`,
`StandingFive.involution_eq_pow`). No edit to `Rigidity/ClassRatio.lean`, no private name read. T1 by absolute norms only:
`finrank ℚ (ℚ(i)) ≤ 2` from the two surjections `ℚ → ⊥` and `⊥ × ⊥ → ℚ(i)`; every maximal `Q ∋ p` has `absNorm Q ∣ p^d`,
`d ≤ 2`, not `1` (`Q ≠ ⊤`), not `p` (a field of `p` elements holding a square root of `−1`,
`FiniteField.isSquare_neg_one_iff`), so `p²` and `d = 2`; stability because two distinct conjugate maximal ideals over `p`
would give `p⁴ ∣ p²` (`Ideal.mul_eq_inf_of_isCoprime`). T2 through `CharP (𝓞 ⧸ P^k) (p^k)` (private `charP_quot_pow`:
`n = p^j u`, `u` invertible modulo `p^k`, so `p^j ∈ P^k` and `p^{2k} ∣ p^{2j}`), then `ZMod.castHom` and `(a, b) ↦ θa +
θb·ι`, whose norm is `θ(a² + b²)`; injective because `2` is invertible modulo `p^k`. T3 by the image of the independent
set. T4 and T5 through K3 (`CertLink.exists_addEquiv_zmod`); T5 reads Weil exactly as `ClassRatio`'s private
`charBound_one_weil` does, through the public `StandingFive.normOne_charSum_ge`. T6 is `CertLink.card_le_of_fibreShareBound`
with Lemma P's two public theorems, through T3. Private helpers: `normOne_iff_pow`, `card_normOneSet_one`,
`finrank_int_le_two`, `charP_quot_pow`.

**Two statement binders no proof reads**: `hk : 1 ≤ k` of `exists_levelEmbedding` (the embedding exists at `k = 0`) and
`hpP` of `charSum_levelOne_of_unitCircle` (K3 reads only `2 ∉ P` and the residue count). The statements are kept; each
proof references the binder once (`have _ := hk`) with a comment saying it is not needed, which the build's
`unusedVariables` linter accepts and `clear` does not (`data/fs131/iqp1/probe/P3.lean`). A weaker hypothesis than needed,
not a defect.

**Re-price.** The two modules took 540 lines against the plan's 630 and three elaboration rounds each (about 7 s per round
for `Tower`). The plan's per-line prices hold; nothing seen here moves the rest of the plan's price.

## Stage 3 — SAVED: `PadicPlane/Measure` and `PadicPlane/Upper`

Every leaf of the two modules proved; each elaborates with the lakefile's options and no warning
(`data/fs131/iqp1/probe/measure.log`, `upper.log`, both empty). No stored statement touched.

**`Measure` (10 leaves, about 330 lines against the plan's 455).** M1 by `ZMod.natCast_zmod_val`. M2 from a private
`res_eq_iff_dist_le` (two points share a level-`j` residue exactly when they are within `p^{−j}` in the sup metric:
`PadicInt.ker_toZModPow`, `PadicInt.norm_le_pow_iff_mem_span_pow`), so each fibre holds the open ball of radius `p^{−k}`
about each of its points. M3 by `Measure.addHaarMeasure_self` at `⊤`. M4: every fibre is a translate of the fibre over
`0` (`measure_preimage_add`) and the `p^{2k}` fibres sum to `1` (`sum_measure_preimage_singleton`). M5 by
`hensels_lemma` for `X² − (1 − a²)` at a lift `b₀` of the unit coordinate; at this pin `hensels_lemma` gives only
`‖z − b₀‖ < 1`, not the distance, so the congruence modulo `p^k` comes from `(z − b₀)(z + b₀) = −(a² + b₀² − 1)` with
`z + b₀` a unit (`‖2b₀‖ = 1 > ‖z − b₀‖`); the swap of coordinates covers a vanishing second residue, and `k = 0` is
`(1, 0)`. M6 by one lift, as planned: `I ∩ C_x` and `(I ∩ C_y) − s` lie in `C_x`, each above half of it, and
`nonempty_inter_of_measure_lt_add` gives `z, z + s ∈ I`. M7 by regularity with no density theorem: a compact `K ⊆ I`
and an open `U ⊇ I` within `ε/2` (`MeasurableSet.exists_isCompact_sdiff_lt`, `exists_isOpen_sdiff_lt`), a coset inside
`U` about each point of `U`, finitely many covering `K` (`IsCompact.elim_nhds_subcover`); their union `Z` is saturated
from the largest level on (private `res_eq_of_le`, `PadicInt.cast_toZModPow`), and the private `haar_bad_le` bounds the
badly filled points by `μ(I \ Z) + μ(Z \ I)`. M8: every point of `I` is badly filled or in a well-filled coset, the
well-filled residues are independent (M6), so at most `c·p^{2k}`. M9: the inclusion `ℤ_p² → ℚ_p²` is
`unitQuadrance.map` of `PadicInt.Coe.ringHom`, continuous, so measurable into `borel (ℚ_p²)` (`measurable_generateFrom`,
`LEAN.md` l. 420's pattern); its classes are measurable independent sets covering `ℤ_p²`. M10 by `Nat.ceil_le`. The Haar
instances are read through the definition by a local `haveI` from the private `isAddHaarMeasure_haar`: no instance is
declared on `haar`.

**`Upper` (3 leaves, about 125 lines against the plan's 130).** U1: `ℤ_p² ⊂ ℚ_p²` as the additive subgroup
`H = (PadicInt.subring p).toAddSubgroup.prod …`, a representative of each coset by `Quotient.out`
(`QuotientAddGroup.eq`, `out_eq'`), the difference `x − c(x)` read in `ℤ_p²` by choice through the coordinate inclusion,
reduced by `PadicInt.toZMod` in each coordinate. An edge stays in one coset (`norm_le_one_of_sq_add_sq_eq_one`), so its
image difference is the residue of a unit vector of `ℤ_p²`; within distance `1` the residue does not move
(`PadicInt.ker_toZMod`), so each fibre is open. U2: the pulled-back colouring's classes are unions of fibres, open, and
`MeasurableSpace.measurableSet_generateFrom` puts them in `borel`. U3 by `colorable_chromaticNumber_of_fintype` and
`ENat.coe_toNat`.

**Re-price.** Two rounds of elaboration each for `Measure` and `Upper` after the first. The hand-written total so far
is about 995 lines for 23 leaves against the plan's 1,215 for the same leaves.
