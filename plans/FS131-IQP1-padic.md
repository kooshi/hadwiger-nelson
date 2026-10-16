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
- `PadicPlane.le_borelChromaticNumber_of_charSum`, `one_add_div_le_of_borelColoring`, `le_borelChromaticNumber_padicPlane`,
  `not_exists_bound_borelChromaticNumber_padicPlane`, `fibreShareBound_seven`,
  `unitQuadrance_zmod_seven_pow_not_colorable_three`, `unitQuadrance_zmod_eleven_pow_not_colorable_four`,
  `unitQuadrance_zmod_nineteen_pow_not_colorable_four`, `borelChromaticNumber_padicPlane_three`, `_seven`, `_eleven`,
  `_nineteen`, `four_le_borelChromaticNumber_padicPlane_twentyThree` (new, item 1002) (`PadicPlane/Values`).
- `FibreCert.cert7_global`, `cert7_seg0`, `cert7_psd` (`Arith/FibreCert7Check`, `decide +kernel`, 29 s in the build),
  `cert7_p`, `cert7_unum`, `cert7_scale`, `cert7_nseg`, `cert7_ok`, `FibreCertSound.sum_le_seven`, `model_seven`
  (`Arith/FibreCert7Bound`); the data `FibreCert.cert7` (`Arith/FibreCert7`).

Expected axioms, to be printed at the gate (not yet printed): the bound `le_borelChromaticNumber_of_charSum` on the
standard three (its character-sum hypothesis is the bound, so it reads no Weil); `one_add_div_le_of_borelColoring`,
`le_borelChromaticNumber_padicPlane`, `not_exists_bound_…`, `borelChromaticNumber_padicPlane_three` and
`four_le_…_twentyThree` on the standard three and `StandingFive.kloosterman_bound` (through `charSum_unitCircle_ge_weil`);
the values at 7, 11 and 19, the level clauses, and the certificate modules on the standard three.

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

## Stage 4 — SAVED: `PadicPlane/Values`, the certificate at 7, and the leaves at 23

**C7, three new modules.** `Arith/FibreCert7` (data; generated by `tools/fs131_ikc1_gen.py data/fs66/b1/cert-p7.json …
--name cert7 --nseg 1 --doc data/fs131/iqp1/cert7/doc.lean`, JSON sha256 `f4b2ffa7c427…`, log
`data/fs131/iqp1/cert7/gen.log`: 8,598 ops, 495 slots, 69 orbits, 14 diagonally dominant PSD blocks, the generator's
identity model HOLDS); its `cert7` definition is byte-identical to the planner's measured probe
(`data/fs131/kpa1/cert7/Cert7Probe.lean`, checked by script). `Arith/FibreCert7Check`: `cert7_global`, `cert7_seg0`,
`cert7_psd`, each `decide +kernel`, no `native_decide`. `Arith/FibreCert7Bound`: `cert7_p`, `cert7_unum`, `cert7_scale`,
`cert7_nseg`, `cert7_ok`, `FibreCertSound.sum_le_seven`, `model_seven`, after `Arith/FibreCert11Bound`. Imported by
`Proofs.lean` after `FibreCert11Bound`.

**`Values` (12 leaves proved, about 150 lines against the plan's 260 less C23).** V1 by `towerRatio_of_charSum` and
`le_borelChromaticNumber_of_towerRatio` with `1/(κ/(p + 1 + κ)) = 1 + (p + 1)/κ`; V2 by `one_le_mul_of_borelColoring` at
`towerRatio_weil`, and its `ℕ∞` form as V1 at `κ = 2√p` (`charSum_unitCircle_ge_weil`); V3 by Mathlib's Dirichlet
(`Nat.forall_exists_prime_gt_and_eq_mod` at `3 : ZMod 4`, a prime above `4(B + 1)²`) and `(p + 1)/(2√p) ≥ √p/2 > B + 1`;
C7 is `sum_le_seven`; the level clauses at 7, 11 and 19 by `not_colorable_of_towerRatio`; the values by `le_antisymm` of
`borelChromaticNumber_le_of_colorable` (the four finite-plane colourings) and `Nat.lt_ceil` against the bound at 3 and the
certificates at 7, 11 and 19 (at 19 the ratio is raised to `max (U/361) (1/8)` so that it is positive, still below
`1/4`).

**The three leaves at 23, moved out** (inventory item 1002; verbatim in `data/fs131/iqp1/leaves-23.lean`, the skeleton's
file at `data/fs131/iqp1/Values-skeleton.lean`):

```lean
/-- **FS-66's fibre-share bound at `p = 23`** (`data/fs66/b1/cert-p23.json`, `U = 97.9846…`). To be proved from a
certificate checked by the kernel (the plan's leaf C23: FS-66's file, or a reduced one with `U < 529/5`). -/
theorem fibreShareBound_twentyThree :
    CertLink.FibreShareBound 23 ((9798463752088652446789757724702574 : ℝ) / 100000000000000000000000000000000) := by
  sorry

/-- No level `UD(ℤ/23^k, 2)` is five-colourable (`5·U/529 < 1`). -/
theorem unitQuadrance_zmod_twentyThree_pow_not_colorable_five (k : ℕ) (hk : 1 ≤ k) :
    ¬ (unitQuadrance (ZMod (23 ^ k))).Colorable 5 := by
  sorry

/-- **`χ_Bor(ℚ₂₃²) ≥ 6`**: FS-66's certificate at 23 (`⌈529/U⌉ = 6`). -/
theorem six_le_borelChromaticNumber_padicPlane_twentyThree : 6 ≤ borelChromaticNumber (padicPlane 23) := by
  sorry
```

Their plan (the plan's C23, V4 at 23, V5 at 23): a reduced certificate at 23 (search request 26: format
`fs66-b1-cert-v2`, `U < 105.8`, at most about 2,000 rows and 20 PSD blocks), generated and split as at 19
(`tools/fs131_ikc1_gen.py`, `tools/fs131_ikc4_*`); then `fibreShareBound_twentyThree` is its `sum_le_…` (with the
reduced certificate's own `U` in the statement, by the coordinator's word, since FS-66's `U` would then not be the one
checked), the level clause is `not_colorable_of_towerRatio` at `5·U/529 < 1`, and `6 ≤` is `le_borelChromaticNumber_of_towerRatio`
with `⌈529/U⌉ = 6`, all as at 11.

**Added: `four_le_borelChromaticNumber_padicPlane_twentyThree`** (`4 ≤ χ_Bor(ℚ₂₃²)`, the bound at `p = 23`:
`⌈1 + 24/(2√23)⌉ = ⌈3.50…⌉ = 4`), beside `…_twentyThree_le_eight`, by the coordinator's word.

**The option `5 ≤` at 23, not taken here, and priced.** The kernel already holds the cosine bound at 23:
`CircleCos.circleCos_ge` (public, `Arith/CircleCos`; `check23` by `decide +kernel`) gives `κ' < 1/3` with every
non-trivial `Σ_{a²+b²=1} cos(2π(αa + βb)/23) ≥ −24κ'`, so `κ = 24κ' < 8` and `⌈1 + 24/κ⌉ ≥ 5` through
`le_borelChromaticNumber_of_charSum`. What is missing is the translation from `AddChar (ZMod q × ZMod q) ℂ` to those
cosines (`ψ(1, 0) = ζ^α`, `ψ(0, 1) = ζ^β` by `IsPrimitiveRoot.eq_pow_of_pow_eq_one`; `Re ζ^m = cos(2πm/q)`; `ψ ≠ 1` gives
`(α, β) ≠ 0`), the plain-plane form of `ClassRatio`'s private `charBound_one_of_circleCos`: about 50–70 lines, one leaf.
Left to the successor or a later job at the hand-back line; `4 ≤` is what this landing states.

**The module docstrings** were brought to what is proved (`data/fs131/iqp1/docfix.py`, applied after the first build):
every title's "skeleton" tag, and `Values`' claims at 23 (`4 ≤ χ_Bor(ℚ₂₃²) ≤ 8`, no level clause at 23).

**The build.** `./scripts/build.sh` under the slot (`MEMMAX=8G BATCH=3`): the first run rebuilt seven modules and failed
in `Values` on two slips (a `rw` that also rewrote the `p` inside `√p`; a `set` that hid the ratio from
`exact_mod_cast`; `data/fs131/iqp1/build1.log`); fixed, and the second run is **green: 736 of 736 batches, 6 modules rebuilt, 0
modules with warnings, 21 m 12 s** (`data/fs131/iqp1/build2.log`; full output
`build/gate/build/20261016T152827Z-3795274.log`). No `sorry` in the eight landing modules (`grep -rnP '\bsorry\b'`, 0
lines). **A first statement comparison** (this job's dumper after the build, `data/fs131/iqp1/statements-after1.txt`,
against the stage-1 print, by name, stored type and a definition's data): 56 constants SAME, 0 changed, 0 missing; the
three leaves at 23 absent as ruled; added: one public theorem, `four_le_borelChromaticNumber_padicPlane_twentyThree`
(item 1002), and the ten private helpers named in stages 2–3. It is a first pass with no planted control; the gate's
comparison (step 4 below) runs it with one. `ARCHITECTURE.md`: three rows for the new modules, the `Values` row rewritten (it named
level clauses the skeleton does not carry, and lacked the new import), the four other rows retagged;
`tools/check_architecture.py` PASS (`data/fs131/iqp1/arch1.txt`).

## What is left, for a successor (the hand-back line is reached)

The harness's count passed the brief's guidance at stage 3; this job hands back here. In order:

1. **Merge `main`.** The collapse has landed (merge `0f81fe2a3`, gated on `7c72b9bf7`); the gate's baseline is now
   `data/fs131/ico2/gate/` on `main` (the coordinator, 2026-10-16: audit 11,398 records — 10,747 clean, 569 axiom-free,
   77 imported, 5 purchases; vacuity declarations 22,357, refutations-skipped 242; assumptions rests 99, takes 109).
   `Rigidity/ClassRatio.lean` there carries D-E2, so the merge recompiles its dependents, `PadicPlane/Tower` and `Values`
   among them, once. Before the merge's first build, intersect the incoming constants with this branch's by name
   (`LEAN.md` § Searching — Lean, FS131-LDB1): this job adds no name `main` could hold, but the check is cheap.
2. **The build** through `./scripts/build.sh` under the slot; `lake lint --no-build -- --no-build --trace`.
3. **The gate on one commit**, by `data/fs131/clone1/run-gate.sh`'s steps copied under `data/fs131/iqp1/`, logs there:
   dupnames, the axiom audit with a block for the new records in `scripts/Axioms.lean` (the Weil-resting ones under
   IMPORTED against `StandingFive.kloosterman_bound`; generate it from the kernel's print, FS131-LGT1's method), vacuity
   (the colouring binders of `one_le_mul_of_borelColoring` and `one_add_div_le_of_borelColoring` read `GENERIC` in `k`;
   inhabited at `p = 3`, `k = 3` by `exists_borelColoring_of_colorable` with `finitePlane3_colorable_three`), the
   assumptions step (no new hypothesis; `RESTS` gains the Weil-resting records), each self-test, every count change
   explained against the new baseline.
4. **The statement comparison** against `data/fs131/iqp1/statements-before.txt` with this job's dumper
   (`data/fs131/iqp1/lean/StatementDump.lean`; add the three `Arith/FibreCert7*` modules to its list for the after-print):
   expected SAME for every constant but the three removed at 23 (ruled by item 1002), `Values`' new
   `four_le_borelChromaticNumber_padicPlane_twentyThree` (ADDED, public, item 1002) and the private helpers (ADDED,
   private: `Basic`'s `not_sq_eq_neg_one`, `norm_le_one_of_le_of_sq_add_sq`; `Tower`'s `normOne_iff_pow`,
   `card_normOneSet_one`, `finrank_int_le_two`, `charP_quot_pow`; `Measure`'s `isAddHaarMeasure_haar`,
   `res_eq_iff_dist_le`, `res_eq_of_le`, `haar_bad_le`). The definitions `borelChromaticNumber`, `padicPlane`,
   `TowerRatio`, `haar`, `res` and the two scoped instances are unchanged in text; the dump shows it from the kernel's side.
5. **`#print axioms`** of every head statement (expected above), the read-aloud against row 75, and the drafts for the
   front files: the planner's (`plans/FS131-KPA1-padic-plan.md` § 5) brought to what is proved — at 23 the kernel holds
   `4 ≤ χ_Bor(ℚ₂₃²) ≤ 8`, not `6 ≤`; row 75's level clause at 23 is not in the kernel.
6. **Optional, priced in stage 4:** `5 ≤ χ_Bor(ℚ₂₃²)` from `CircleCos.circleCos_ge`, about 50–70 lines.
