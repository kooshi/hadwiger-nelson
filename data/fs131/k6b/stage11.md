
## Stage 11 — SAVED: the bridge's eight rows — the curve notion, the skeleton, the plan and the price (`debruijn-obligation-modeling`, invoked fresh)

**Read for this stage**: `plans/FS131-E8-derivation.md` whole (stage 8); `plans/FS121-V2-verification.md` §§ 1.4–2.4 in full (Lemmas C, H, T;
DB1-L3; V2-SECTOR; the attack). Not read: every other argument of the first pass's § 7.2 item 4.

### 11.1 The space, and the statements the proofs derive from

No induction over data: the argument is *local to global by connectedness and compactness*. The local obligations, each a goal of its own:
(L) a chart at every interface point; (C) three real-variable inequalities on a unit-speed curve; (G) a component is one such curve (the
continuation); (K) compactness on a circle; (O) the angular order of the lifts. The statements are shaped around them:

- **One curve notion** (`Plane/Saturated/Curve`): `IsUnitCurve γ ψ I` — `γ' = e ∘ ψ` on `I`, the tangent angle `ψ` 1-Lipschitz. Unit speed
  and "curvature at most 1" in the only form any argument reads (`|ψ s − ψ u| ≤ |s − u|`); every inequality of E8 §§ 3.2–3.3 is then one integral
  of a cosine. A graph over a line was refused: the inequalities are in arclength, and a graph form would re-derive the reparametrization at
  every use. The ladder's circular arcs and segments are `IsUnitCurve`s with `ψ` affine (`ψ s = ψ₀ + s/n`, or constant); the first pass's
  "curves as sets with a pointwise type" stays the consumers' form — `IsInterfaceChart.discs` carries `HasTwoDiscsAt` at every point of the curve.
- **Components of the essential boundary in the punctured disc**, never "interface arcs": under `IsolatedAt` the two sets are equal
  (`Σ ∩ B(z, R) ⊆ {z}`), and the statements read `c.essBdry ∩ (ball z R \ {z})` to save every proof that step.
- **The fan's consumers' facts as set-level lemmas** (§ 10.2).

### 11.2 The modules and the rows

| module | rows | leaves (`sorry`) | proved here |
|---|---|---|---|
| `Plane/Saturated/Curve` (imports `Plane/Chord` only; no measure) | the curve part of FS131-E8-GAMMA, -BETA | `IsUnitCurve.chord` (C1), `.sin_le_inner` (C2), `.strictMonoOn_dist`, `.norm_sub_le`, `.one_le_dist` (the lens), `lipschitzOnWith_of_chord` | `isUnitCurve_segment` (the inhabitant), `IsUnitCurve.mono`, **`norm_sub_le_of_discs`** |
| `Plane/Saturated/LocalGraph` (imports `Pinch`, `Curve`) | **FS131-E8-DELTA**; **FS131-E8-LOCAL** = FS111-M-C11 (ii) = FS111-W-NOBEND; FS121-V5-LOC (i), (ii) with V5-OFF | `AeColouring.ae_one_colour_of_isConnected`, `.closure_essBdry_subset`, `.notMem_essBdry_of_mem_densitySet`, `local_graph`, `AeColouring.local_graph` | the structure `IsInterfaceChart` |
| `Plane/Saturated/FanBridge` (imports `LocalGraph`, `FanExamples`) | **FS131-E8-GAMMA, -BETA, -ALPHA, -FAN, -BRIDGE, -CLAUSE2**; FS121-V2-SECTOR, FS121-DB1-L3 (with FS111-W-NOREP) | `gamma`, `IsUnitCurve.exists_polarGraph`, `beta`, `alpha`, `fan_of_isolated`, `regJLiteral_of_saturated`, `finite_arcs_of_isBounded`, `Fan.two_le_n`, `Fan.col_ne`, `Fan.branch_outside_discs`, `Fan.branch_contacts`, `Fan.sector_alone` | `sq9_isolatedAt`; **`regJFan_of_saturated`** (BRIDGE, from `fan_of_isolated`), `regJFan_iff_singLocallyFinite`; `Fan.sector_unique` (DB1-L3, from `sector_alone`) |

**Which of the first pass's rows became corollaries** (the brief's question): **FS111-M-C11 (ii)** is `local_graph` (with "no cusp in `U`", the
deriver's erratum); **FS111-W-NOBEND** is its curve clause — no corner is `HasDerivWithinAt` at every point, curvature at most 1 is `lip` — the
merge of ruling 487 (c) **confirmed, from its entry and the deriver's § 4.6** (its own argument, `plans/FS111-W-wild.md`, not read: a third
pass's line); **FS121-V5-LOC (i)** is `closure_essBdry_subset` with `notMem_essBdry_of_mem_densitySet`, **(ii)** is `AeColouring.local_graph`;
clause (iii) is not stated. **FS121-DB1-L3** is a case of **FS121-V2-SECTOR** (`sector_unique` from `sector_alone`), so FS111-W-NOREP rides on it.

### 11.3 Each statement against its entry (`plans/FS131-E8-derivation.md`, verbatim words in quotes)

| entry | declaration | read-back |
|---|---|---|
| FS131-E8-DELTA | `ae_one_colour_of_isConnected (hW : IsOpen W) (hWc : IsConnected W) (hb : Disjoint W c.essBdry) (hcusp : Disjoint W (cuspSet c.cls)) : ∃ j, W ≤ᵐ c.cls j` | "a connected open set that meets the essential boundary of no class and holds no cusp of any class is almost everywhere of one colour" — verbatim; `IsConnected` includes non-empty (for `W = ∅` every `j` serves) |
| FS131-E8-LOCAL | `local_graph … (h : TwoColourOn A B N) (hU : IsOpen U) (hUN : U ⊆ N) (hcusp : ∀ x ∈ U, ¬ IsCuspAt A x ∧ ¬ IsCuspAt B x) (hsatA) (hsatB) (hy : y ∈ essBoundary A ∩ U) : ∃ Q γ ψ h', Q ⊆ U ∧ IsInterfaceChart A B N y Q γ ψ h'` | "an open set that holds no point of the singular set Σ": the argument reads of it only "no cusp" (§ 3.1 (1): "no cusp (it is off Σ)") and the one two-colour ball — so two sets, and `Σ` is not read (**wider**; the centred-ball `Σ` serves: ruling 495 (a) needs no change). "an open square … in which the interface set is the graph, over the tangent line at y, of a C^{1,1} function whose unit tangent is 1-Lipschitz in arclength": an open `Q ∋ y` in which `essBoundary A` is the image of an injective `IsUnitCurve` — the square and the graph are the proof's, the chart is what consumers read; "the two sides … connected open sets, each almost everywhere of one colour, of two different colours": `sides`, with `A`, `B` almost disjoint in `N`. Added: `discs` (the two unit discs at every point of the curve, normal `i e(ψ s)` into `B` — § 3.1 (2)). Not claimed (the chart's size bounded below; anything at `Σ`): not stated. `AeColouring.local_graph` is the entry's own form |
| FS131-E8-GAMMA | `gamma (h : c.IsolatedAt z R) (hy) : ∃ L γ ψ, 0 < L ∧ L ≤ π/2 ∧ IsUnitCurve γ ψ (Icc 0 L) ∧ InjOn γ (Icc 0 L) ∧ component = γ '' Ioo 0 L ∧ (γ 0 = z ∨ γ 0 ∈ sphere z R) ∧ (γ L = z ∨ γ L ∈ sphere z R)` | "0 < R ≤ 1/2 such that B(z, R) holds no other point of Σ and every essential boundary point of B(z, R) other than z has … a point of that class's support at distance 1": `IsolatedAt`; "an open arc of length at most π/2, not closed": `L ≤ π/2`, injective on the closed interval; "each of whose two ends converges to z or to a point of the circle": the two disjunctions; "whose unit tangent has a limit at each end": `IsUnitCurve` on `[0, L]`. `z ∈ Σ` is not a hypothesis (the entry's "let z be a point of the singular set" is not read by §§ 3.2–3.4) |
| FS131-E8-BETA | `IsUnitCurve.exists_polarGraph` (no colouring); `beta (h) (hy) (hz : z ∈ closure component) : ∃ φ d, ContinuousOn φ (Ioo 0 R) ∧ Tendsto φ (𝓝[>] 0) (𝓝 d) ∧ component = polarGraph z R φ` | "the distance from z is strictly increasing": `IsUnitCurve.strictMonoOn_dist`; "its other end lies on the circle", "a polar graph {z + t e(φ(t)) : 0 < t < R} with φ continuous on (0, R) and convergent": `beta`; "to an angle of the component's limit tangent at z": `exists_polarGraph`'s limit is `ψ 0` |
| FS131-E8-ALPHA | `alpha (h) : {components meeting closedBall z (R/2)}.Finite ∧ ∃ r, 0 < r ∧ r ≤ R/2 ∧ ∀ w ∈ c.essBdry ∩ (ball z r \ {z}), z ∈ closure (component of w)` | verbatim, "has an end at z" read as `z` in the component's closure |
| FS131-E8-FAN | `fan_of_isolated (hR : 0 < R) (hS : c.singularSet ∩ ball z R ⊆ {z}) (hsat : SaturatedOn c.cls (ball z R \ {z})) : Nonempty (c.Fan z)`; `Fan.two_le_n (hz : z ∈ c.singularSet) : 2 ≤ F.n`; `Fan.col_ne` | the entry's hypotheses verbatim, without "z a point of Σ" (read only for "at least two", `two_le_n`) and without `R ≤ 1/2` (pass to `min R (1/2)`); the conclusion is the first pass's structure, field by field as § 3.6 reads it. "at least two", "regions on the two sides of a curve being of different colours": for **any** fan, no saturation (**wider**, the planner's argument, § 11.5 (3)) |
| FS131-E8-BRIDGE | `regJFan_of_saturated (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) : c.RegJFan` (**proved** from FAN) | the deriver's hand-off line verbatim; `RegJBridge k` of the first pass's design follows with `RegJLiteral`'s second conjunct unread |
| FS131-E8-CLAUSE2 | `regJLiteral_of_saturated`, `finite_arcs_of_isBounded (hK : Bornology.IsBounded K)` | "every point of Σ lies in the closure of finitely many connected components of the interface set, and every bounded set meets finitely many": the two declarations |

**The docstring line of ruling 490 (b)** is on every theorem that takes a `Fan` (`sector_alone`; the module docstring of `Fan`): "under
saturation … equivalent to `Σ` being locally finite, by FS131-E8-BRIDGE ([hand], one mind, until `fan_of_isolated` is proved)".

### 11.4 The plan per leaf

Mathlib names confirmed at the pin by the proofs built here or by `#check` (`data/fs131/k6b/K6bChecks.lean`): `parallelogram_law_with_norm`,
`HasDerivWithinAt.ofReal_comp`, `LipschitzWith.const`, `le_of_tendsto_of_tendsto`, `Ioo_mem_nhdsGT`, `isClosed_iUnion_of_finite`,
`tendsto_densityRatio_compl_of_mem`, `nonempty_of_measure_ne_zero`, `Real.cos_neg_of_pi_div_two_lt_of_lt`, `Real.sin_neg_of_neg_of_neg_pi_lt`,
`Real.cos_pos_of_mem_Ioo`, `Measure.addHaar_affineSubspace`, `convex_halfSpace_im_lt`. Prices are implementer agent-hours (h) or days (d).

| leaf | route and children | hard part | price |
|---|---|---|---|
| `IsUnitCurve.chord` | `γ ℓ − γ 0 = ∫₀^ℓ e(ψ s) ds` (`intervalIntegral.integral_eq_sub_of_hasDeriv_right` or the `Icc` form; `e ∘ ψ` continuous); the inner product with `e(ψ 0)` is `∫ cos(ψ s − ψ 0)`; `cos(ψ s − ψ 0) ≥ cos s` (`Real.cos_le_cos_of_nonneg_of_le_pi` after `Real.cos_abs`) | one-sided derivatives at the ends of `Icc` | 4 h |
| `.sin_le_inner` | the same with `e(ψ s)`: `∫₀^s cos(ψ s − ψ u) du ≥ ∫₀^s cos(s − u) du = sin s` | — | 3 h |
| `.strictMonoOn_dist` | `(d/ds)‖γ s − γ 0‖² = 2⟨γ s − γ 0, e(ψ s)⟩ ≥ 2 sin s > 0` on `(0, ℓ]`; `strictMonoOn_of_deriv_pos` on the square, then the square root | positivity at `s = 0` is not needed (strict on the interior) | 3 h |
| `.norm_sub_le` | `‖∫₀^s (e(ψ u) − e(ψ 0)) du‖ ≤ ∫₀^s u du` (`norm_e_sub_e_le`, wave 1) | — | 2 h |
| `.one_le_dist` | `f s = ‖γ s − γ 0 ∓ i e(ψ 0)‖²`, `f 0 = 1`, `f' = 2⟨γ s − γ 0, e(ψ s)⟩ ∓ 2 sin(ψ s − ψ 0) ≥ 2 sin s − 2 sin s` (`sin_le_inner`; `Real.sin_le_sin_of_le_of_le_pi_div_two` with `|ψ s − ψ 0| ≤ s ≤ π/2`); monotone | the planner's derivation — § 11.5 (4) | 3 h |
| `lipschitzOnWith_of_chord` | for `u < s` in `I` and `n` pieces: `|ψ sᵢ₊₁ − ψ sᵢ| ≤ 2 arcsin(Δ/2)` once `|Δψ| < π` (uniform continuity on `[u, s]`), sum, `n → ∞` | the limit `n · 2 arcsin(d/2n) → d`; or: `ψ` is locally Lipschitz with constant `1 + ε` for every `ε` | 5 h |
| `notMem_essBdry_of_mem_densitySet` | `notMem_essClosure_of_mem_densitySet` (`Plane/Saturated/Fan`; import it) for the other classes; `essBoundary` excludes the class's own density points | — | 0.5 h |
| `ae_one_colour_of_isConnected` | E8 § 3.5: for `x ∈ W` some `j(x)` has `x ∈ densitySet (cls j)` (`exists_mem_essClosure_of_cover`, wave 2; no essential boundary); the other classes are null near `x` (no cusp: not in their support); so `{x ∈ W | ball about x a.e. in cls j}` is open for each `j`, the sets partition `W`, and `IsPreconnected` makes one of them all of `W` (`isPreconnected_iff_subset_of_disjoint`); then a.e. by a countable cover (`ae_le_set` through `IsOpen` and Lindelöf, or density points: `W ⊆ densitySet (cls j)` and `volume_densitySet_diff`) | the finish — use `volume_densitySet_diff` (wave 2), no cover | 5 h |
| `closure_essBdry_subset` | E8 § 3.1 (0): `x ∈ closure (essBoundary (cls j))` for one `j` (finite union); `exists_ne_mem_essClosure` (wave 2) gives `b ≠ j` at each approximant, one `b` on a subsequence (pigeonhole on `Fin k`, or `closure` of a finite union twice); `essSupport` closed; not a cusp of either gives both in `essClosure`; `notMem_essClosure_of_mem_densitySet` | the two finite pigeonholes: write `essBdry = ⋃ j, ⋃ b ≠ j, essBoundary (cls j) ∩ essClosure (cls b)` first | 5 h |
| `local_graph` | E8 § 3.1 (1)–(4). Children: (a) in `U`: `essBoundary A = essBoundary B = supp A ∩ supp B` (`TwoColourOn.essBoundary_inter_eq`; no cusp) — 3 h; (b) `c11_discs` at every such point, one `N` — given; (c) § 3.1 (3)(b) `|⟨x″ − x′, ν′⟩| ≤ δ²/2` — 2 h; (d) § 3.1 (3)(c), the crude `6δ` (the lens point; control `e8_lens.py`) — 5 h; (e) **sharp**: `norm_sub_le_of_discs`, the midpoint of the centres within `3.5δ` — 3 h; (f) existence on each normal segment (a segment is connected; its ends in the two open sets) — 4 h; (g) uniqueness and `|g u| ≤ u²` — 4 h; (h) the curve: `g` differentiable with `g' = −ν₁/ν₂`, arclength `s(u) = ∫√(1 + g'²)` strictly increasing with a `C¹` inverse, `γ = (u(s), g(u(s)))`, `ψ` a continuous lift of the tangent angle, `lipschitzOnWith_of_chord` with (e) — 2 d; (i) the two sides connected, their colours — 6 h | (h): Mathlib has no arclength reparametrization; **do not** follow § 3.1 (4)'s "where `g″` exists … absolutely continuous" (§ 11.5 (1)) | 5 d |
| `AeColouring.local_graph` | `exists_twoColourNhd_of_mem_interfaceSet` (`y ∉ Σ`), `U' = U ∩ ball y ρ`, cusps lie in `Σ`, `TwoColourNhd.mem_essBoundary`, `local_graph` | — | 1 h |
| `gamma` | E8 § 3.2, by its kernel note: no classification of one-manifolds. From a chart at `y`, the family of injective `IsUnitCurve`s through `y` inside the component, ordered by extension; lengths are at most `π/2` (`chord`: a sub-arc of length `π/2` has chord `≥ 1 > 2R`); the union of a chain is a curve (`ψ` extends: 1-Lipschitz); a maximal one is open and closed in the component (charts at its points; at an end inside the punctured disc the chart extends it — § 3.2 (3)) | gluing two charts along an overlap (two `IsUnitCurve`s with the same image near a point agree up to the parameter's shift and sign) | 4 d |
| `IsUnitCurve.exists_polarGraph` | `t(s) = dist (γ s) (γ 0)` strictly increasing and continuous (`strictMonoOn_dist`), so a homeomorphism of `[0, L]` onto `[0, t(L)]`; `φ(t)` a continuous lift of `arg (γ(s(t)) − γ 0)` chosen near `ψ 0` (`norm_sub_le`: the direction is within `s/2 · (1 + o(1))` of `e(ψ 0)`, so one branch of the argument serves for small `t`, and on `(0, t(L))` the direction stays in the open half-plane about `e(ψ 0)`? — **check**: it holds while `s < π/2` by `chord`, whose inner product is positive) | the lift: use `chord` to keep `(γ s − γ 0) · conj (e (ψ 0))` in the right half-plane, where `Complex.arg` is continuous, and put `φ = ψ 0 + arg(…)` | 1.5 d |
| `beta` | `gamma`; `z` in the closure forces an end at `z` (the other points of the closure are in the punctured disc or on the circle); `strictMonoOn_dist` forces the other end on the circle; `exists_polarGraph` with `dist (γ L) z = R` | — | 4 h |
| `alpha` | E8 § 3.4 (a)–(e): every component meeting the half disc meets the circle of radius `R/2` (continuity of the distance along `γ`); `essBdry ∩ sphere z (R/2)` compact (`closure_essBdry_subset`, no cusp there); each of its points has a chart lying in one component; finite subcover; the least distance of the finitely many components that miss `z` | (c): a chart's image is connected, so in one component | 1.5 d |
| `fan_of_isolated` | E8 § 3.6 with `R' = min R (1/2)`: `alpha`'s `r`; the components with `z` in their closure are finitely many polar graphs (`beta`) pairwise disjoint; lifts ordered within `(φ₀, φ₀ + 2π)` (continuous and never equal mod `2π`); `Fin n` by sorting at one `t`; regions by `ae_one_colour_of_isConnected` (a polar region between two continuous graphs is open and connected) | the ordered lifts; connectedness of `polarRegion` | 3 d |
| `regJLiteral_of_saturated`, `finite_arcs_of_isBounded` | E8 § 3.7: a component with `z` in its closure meets the fan's disc on a branch, and a branch lies in one component; compactness off the fans | — | 0.5 d, 1 d |
| `Fan.two_le_n`, `Fan.col_ne` | § 11.5 (3): a continuous polar graph is null (the image of a graph in `(t, θ)` under the polar map, locally Lipschitz); near a branch point every point is on the branch or in one of the two neighbouring cells; so equal colours make it a density point, against `F.bdry` and `notMem_essBdry_of_mem_densitySet`; `n = 0`: `ae_one_colour_of_isConnected` on the punctured disc | the null graph (`MeasureTheory.addHaar_image_eq_zero_of_differentiableOn_of_addHaar_eq_zero` for the polar map) | 1 d each |
| `Fan.branch_outside_discs` | a branch is a component with `z` in its closure (§ 10.2 (2)); `gamma`'s curve from `z`; `one_le_dist`; `F.dir i ≡ ψ 0` mod `2π` (`exists_polarGraph`'s limit and `F.tendsto`) | identifying the fan's `φ i` with the curve's polar angle | 1 d |
| `Fan.branch_contacts` | at branch points `pinch_interface`'s two types; a split point makes the whole branch a unit arc (§ 11.5 (4)); else all tangent, the normals `i e(ψ s)` converge (`IsUnitCurve` on the closed interval), contacts `x ± ν(x)` converge, supports are closed | the propagation of the split type | 1.5 d |
| `Fan.sector_alone` | `plans/FS121-V2-verification.md` §§ 2.2–2.3 verbatim: Lemma C is `half_dichotomy`; Lemma H from it on two cells of one colour (a cell is preconnected, in the density set: `subset_densitySet_of_isOpen_ae_subset`); the directions `D(W)` of a cell of positive angle are the open arc `(dir i, nextDir i)` (`F.tendsto`); the angular lemma; the zero-angle case by `branch_contacts`' three cases and `branch_outside_discs` | `D(W)` for a cell from the fan's fields; the angular case analysis (V2's control `fs121-v2-sectors` is a half-degree grid) | 2.5 d |

**The price of the bridge**: `Curve` 2.5 d, `LocalGraph` 6.5 d, `FanBridge` without the two sector rows 14.5 d — **about 23 agent-days**, 80 %
interval [12, 40]; registered 15 [6, 30] (Y4). Re-priced from the first two leaves closed here: `norm_sub_le_of_discs` (planned at an hour,
closed in one elaboration) and the fan's inhabitant (§ 10.3) — the *computational* leaves (`Curve`'s six, the two colouring lemmas of
`LocalGraph`) are likely high by a factor of two to three; `local_graph` (h), `gamma` and `fan_of_isolated` are not re-priced by them and carry
the interval's width. **Order of landing**: `Curve` and `LocalGraph`'s first three leaves at once; `local_graph`; then `FanBridge`. If
`gamma` proves large, `fan_of_isolated` stays a `sorry` and every consumer still lands over `Fan` (ruling 490 (a)).

### 11.5 Findings on the bridge (sent to the coordinator mid-job)

1. **A step that does not formalize as written, and a shorter route** — E8 § 3.1 (4), *Regularity*: "At a point where `g″` exists the graph stays
   outside two open unit discs tangent to it there, so its curvature is at most 1 in absolute value; the tangent angle `ψ = arctan g′` is
   absolutely continuous with `dψ/ds = κ`, so `ψ` is 1-Lipschitz in arclength." In the kernel that is Rademacher's theorem and the fundamental
   theorem for Lipschitz functions. **Replacement, proved** (`norm_sub_le_of_discs`): with `w = x′ − x″`, `s = ν′ + ν″`, non-overlap of the
   opposite discs is `‖w + s‖ ≥ 2`, `‖w − s‖ ≥ 2`; the parallelogram law twice gives `‖ν′ − ν″‖² = 4 − ‖s‖² ≤ ‖w‖²`. The non-overlap holds
   because the midpoint of two overlapping opposite discs' centres, `x′ + (x″ − x′)/2 + (ν′ − ν″)/2`, lies within `3.5δ` of `x′` by § 3.1 (3)(c)'s
   crude bound, hence in `N`, where the two discs are a.e. of two almost disjoint sets. The chordal bound then gives the angle's
   (`lipschitzOnWith_of_chord`). One mind (the planner's); the algebra is kernel-checked, the lens-in-`N` step is `local_graph`'s child (e).
2. **The fan's existence reads only a crude curvature bound** (its `r` is existential): with § 3.1 (3)(c)'s constant 6 alone, lengths are at most
   `π/12` in a disc of radius `1/12`, and §§ 3.2–3.6 run. The sharp constant is read by the consumers' lens only. Not used to restate anything.
3. **A generalization**: FS131-E8-FAN's "at least two [curves]" and "regions on the two sides of a curve being of different colours" read no
   saturation — they follow from the fan's fields and, for the first, `z ∈ Σ` (§ 11.4, `Fan.two_le_n`, `Fan.col_ne`). The planner's argument.
4. **Three statements are the planner's assembly**, for a deriver's check: `IsUnitCurve.one_le_dist` (E8's § 4.6 offered
   `|φ i t − dir i| ≤ arcsin(t)/2`, which does not put the branch outside the unit disc; the three lines of § 11.4 do, from E8's C2);
   `Fan.branch_contacts` (V2's Lemma T (ii), with the claim that a branch is of split type along its whole length or of tangent type along it:
   at a point with a common contact `y` of both colours `pinch` gives the split type — its other case needs antipodal contacts — and
   `c11_split` carries the unit circle about `y` along the connected branch); `fan_of_isolated` at every `z` isolated from `Σ ∖ {z}`.
5. **Ruling 495 (a)**: `local_graph` reads `TwoColourOn A B N` and "no cusp in `U`", never `Σ`; the centred-ball `Σ` serves. The agreement of
   the two readings under saturation is not stated; priced at a day after `local_graph` (small centred balls about a chart's point are cut by the
   curve into two connected pieces).

**Mutation audit** (statement level, by hand): `fan_of_isolated` without `hsat` is false (E8 § 4.1: circles of radii `2⁻ⁿ`, a spiral);
without `hS`, false at an accumulation point of `Σ`; `gamma` without `le : R ≤ 1/2`, false (a unit circle of interface in a disc of radius
above 1); `ae_one_colour_of_isConnected` without `hcusp`, false (E8's not-claimed line); `local_graph` without `hcusp` is the gap the deriver's
erratum names; `sector_alone` without `hsat`, false (V2 § 2.4: the bow-tie blocks); `norm_sub_le_of_discs` without `h2`, false (two points of a
line with normals tilted the same way toward each other).
