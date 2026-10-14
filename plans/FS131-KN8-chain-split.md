# FS131-KN8 — the five-colour chain, next: what the split reads, typed; the split's module typed; the zero-entropy side's second module

*de Bruijn, the planner; the fourth on this chain, after FS131-KN3, FS131-KN6 and FS131-KN7. Brief:
`data/fs131/briefs/FS131-KN8-chain-split.md` (on `main`). Branch `fs131-wk8`, cut from `fs131-wk7` at `6b7ec2426`, in the
worktree `.claude/worktrees/fs131-wq1`. Claims: `data/fs131/claims-NF2.md`. Stands on `plans/FS131-KN7-chain-next.md` (cited
KN7 § n), `plans/FS131-KN6-chain-first-layer.md` (KN6 § n), `plans/FS131-KN3-chain-plan.md` (KN3 § n) and the deriver's
`plans/FS131-EN2-derivation.md` (EN2 § n), `plans/FS100-X02D-derivation.md` (X02D), `plans/FS100-X01D-derivation.md` (X01D),
the last three on `main`. Working files: `data/fs131/kn8/`.*

## Theorems this phase proved

(Filled at the hand-back.)

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_kn8_readback.py` (KN7's tool with the brief's path changed): every line `> <text>` of the brief whose next line
is `> — source: <path>` must be one whole line of that file, character for character. Run against `main`'s tree, where the
brief and its sources live:

- `quotations=6 identical=6 differing=0`, exit 0 (`data/fs131/kn8/logs/readback.out`): W2
  (`data/fs131/REQUEST-2026-10-13.md`); NF2-NC, NF2-LEAF-20, NF2-LEAF-21 and the dated line of 2026-10-14 narrowing
  NF2-LEAF-20 (`data/fs131/claims-NF2.md`); item 750 (`plans/FS131-close-inventory.md`).
- Control (`--plant`: the last character of every matching source line changed in memory): `identical=0 differing=6`, exit 1
  (`readback-control.out`).
- The words item 750 quotes from the last planner ("clause (4) now uses `borel (X ⧸ G j)` …", "`EntropySplit` asks for
  entropy zero at one rotation …", "M7b is planned in words only, and M8b was not reached") are in KN7's record § 3.1, § 6.1
  and § 6.4 in substance; its report is on `fs131-wk7` and I did not re-run a byte check on it.

No mismatch: nothing for the coordinator from the readback of text.

### 1.2 The declared theorem, the split and its consumer, as the kernel prints them

`data/fs131/kn8/lean/Readback.lean` against the tree's compiled library (`logs/lean-Readback.log`; its four errors are
in the Mathlib name checks below it, none in the prints):

```
@positive_entropy_rigidity : ∀ {X : Type u_1} [inst : AddCommGroup X] [inst_1 : TopologicalSpace X]
  [inst_2 : MeasurableSpace X] [BorelSpace X],
  IsSolenoid X → ∀ {d : ℕ}, 2 ≤ d → ∀ (α : ZdAction d X), α.NoVirtuallyCyclicFactors →
  ∀ (μ : Measure X), IsProbabilityMeasure μ → α.IsErgodicOn ⊤ μ →
  ∃ Λ J ν G, Λ.FiniteIndex ∧ 0 < J ∧ μ = (↑J)⁻¹ • ∑ j, ν j ∧ (∀ (i j : Fin J), i ≠ j → ν i ⟂ₘ ν j) ∧
    ∀ (j : Fin J), IsProbabilityMeasure (ν j) ∧ α.IsErgodicOn Λ (ν j) ∧
      (IsClosed ↑(G j) ∧ α.InvariantOn Λ (G j) ∧
        ∀ g ∈ G j, ∀ (B : Set X), MeasurableSet B → (ν j) ((fun x => x + g) ⁻¹' B) = (ν j) B) ∧
      (∀ (n : Fin d → ℤ), ∃ k, Measure.map (⇑(α.toFun n)) (ν j) = ν k ∧ AddSubgroup.map (α.toFun n) (G j) = G k) ∧
      ∀ n ∈ Λ, ∀ (h : G j ≤ AddSubgroup.comap (α.toFun n) (G j)),
        ksEntropy (Measure.map (⇑(QuotientAddGroup.mk' (G j))) (ν j)) ⇑(QuotientAddGroup.map (G j) (G j) (α.toFun n) h) = 0

def HadwigerNelson.Rigidity.EntropySplit : Subfield ℝ → Prop := fun F =>
  ∀ (τ : Measure (Dual F)), IsFiniteMeasure τ → RotInv F τ →
    ∃ a b m ρ, IsHaarFourier m ∧ IsProbabilityMeasure ρ ∧ RotInv F ρ ∧
      (∃ u, (∀ (n : ℕ), n ≠ 0 → ↑u ^ n ≠ 1) ∧ ksEntropy ρ (rot u) = 0) ∧ τ = a • m + b • ρ

mrPlus_of_split_of_carried : ∀ (F : Subfield ℝ), EntropySplit F → ZeroEntropyCarried F → MRPlus F
'HadwigerNelson.Rigidity.mrPlus_of_split_of_carried' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The default print of clause (4) hides the σ-algebra on `X ⧸ G j`; KN7 § 3.2 read it with every argument shown
(`@ksEntropy (X ⧸ G j) (borel (X ⧸ G j)) (@Measure.map … (borel (X ⧸ G j)) …)`) and nothing has touched the module since
(the tree is KN7's last commit). As item 750 says, the consumer is on the standard three axioms.

### 1.3 The last planner's § 6.3, restated (M7b, the split's own module, as left in words)

M7b proves `entropySplit` from M7a (`Rigidity/HaarMultiple`), Lemma Γ, the release's ergodic decomposition
(`action_ergodic_decomposition`, lane P2) and mixture lemma (`ksEntropy_bind_eq_zero`, lane E's leaf 9 over P), Fourier
uniqueness and Haar existence. Its vocabulary, as decided there:
1. the unit vectors as a group, `unitCircle F : Subgroup Circle` (the `z` with `(z : ℂ) ∈ planeOver F`), with
   `unitVectors F ≃ unitCircle F`;
2. the rotation action `MulAction (unitCircle F) (Dual F)`, `g • χ = rot g χ`, owing `rot (u * v) = rot u ∘ rot v` and
   `rot 1 = id`; a subgroup `Γ` acts by restriction and is countable;
3. admissibility in X02D's operational form or in the page's ("every finite-index subgroup generates `F(i)`") — the M6
   planner's call;
4. `StandardBorelSpace (Dual F)` for the cylinder σ-algebra.

Its statements, in the deriver's order (EN2 § 5.2): (a) `RotInv` of `τ − maxMultiple τ m • m`; (b) step 2, the Haar set of
the kernel is null; (c) step 3, entropy zero at every `γ ∈ Γ`; (d) `entropySplit` from (a)–(c) and a non-torsion generator,
with `b = 0` and `ρ` the point mass at the trivial character when the remainder is `0`. Lemma Γ belongs with the pieces (M6)
and `haar_or_zero_entropy` (M5), whose proof may take `[PolishSpace X]`.

## Stage 2 — SAVED: what the split reads, typed (modules M4, the unit-vector group, M6 with Lemma Γ); item 3 settled

### 2.1 The cut (mine to decide)

| module | what | consumers |
|---|---|---|
| `Rigidity/DualGroup` (M4) | the dual of a discrete abelian group `G` as a compact group; Polish, Borel and standard Borel for countable `G`; separation of points; **Fourier uniqueness**; Haar in both forms | M6, M7b; generic in `G` |
| `Rigidity/UnitCircle` (new) | the unit vectors as a group acting on `Dual F`; Haar is rotation invariant; admissible pairs | M6, M7b |
| `Rigidity/Pieces` (M6 with Lemma Γ) | the pieces `M̂`, PE-1′, the chain, Lemma Γ's steps and Lemma Γ | M7b |

**M2 is off M7's path.** T4 (Fourier uniqueness) was to come from Herglotz–Bochner's uniqueness clause (M2). It needs no
Herglotz–Bochner: with the pointwise topology the evaluations span a point-separating star subalgebra of bounded continuous
functions, and Mathlib's `MeasureTheory.ext_of_forall_mem_subalgebra_integral_eq_of_polish`
(`Mathlib/MeasureTheory/Measure/FiniteMeasureExt.lean` l. 72, signature read at the pin, `logs/lean-Readback.log`) gives
uniqueness on a Polish space with Borel sets. The same makes `BochnerHerglotz G` idle in `SpectralInputs.ext_of_fourier`,
`exists_isHaarFourier` and `IsHaarFourier.map_mulRight` at every countable `G`, and proves BH's uniqueness clause there.
Sent to the coordinator at once (a shorter route), 2026-10-14.

### 2.2 The domain pass (`debruijn-domain-modeling`, a fresh invocation, scoped to every new definition)

- **The topology on `AddChar G Circle`**: induced by `χ ↦ (g ↦ (χ g : ℂ))`, **the same map** the library's cylinder
  σ-algebra is the comap of — so that "Borel = cylinder" is `borel_comap` with `Pi.borelSpace`, not a comparison of two
  products. Intrinsic: for discrete `G` it is the compact-open topology. **Scoped** in `HadwigerNelson.Rigidity` (a
  topology on Mathlib's type is speech into every search; every consumer is in the namespace), and with it every
  topological instance. `StandardBorelSpace` is a property of the library's own global σ-algebra, so it is a global
  instance. Weighed: inducing through `G → Circle` (a second product to compare); Mathlib's `PontryaginDual` (continuous
  homs out of a topological monoid — a second carrier with a bijection to keep).
- **Haar**: `dualHaar G := haarMeasure ⊤` is the named object; the chain's normal form stays `IsHaarFourier`, and the
  statement every other is read off is `isHaarFourier_iff : IsHaarFourier m ↔ m = dualHaar G`. Rotation and translation
  invariance are read off it (`map_dual_eq`, `map_mul_right_eq`), each from a Fourier computation that needs no
  countability (`map_dual`, `map_mul_right`). Unsampled member: `G = 0` — one point, Haar the point mass, no coefficient off
  `0`; uncountable `G` is excluded by `[Countable G]` wherever Borel is read.
- **The unit vectors as a group**: KN7's `unitCircle F : Subgroup Circle` kept; the chain's statements stay over
  `unitVectors F` and `rot`, and the bridge is `toUnitVector` with `smul_def : g • χ = rot (toUnitVector g) χ` by `rfl` and
  `unitCircleEquiv` — one concept in two costumes with the `_iff` (`rotInv_iff`) stated the same day. Weighed: a subgroup of
  `(unitRing F)ˣ` (canonical action, but norm one becomes a side condition).
- **Admissibility: a structure carrying the generators** (`AdmissiblePair`), because PE-1′ extracts them to build the
  pieces' `ℤ²`-action (data a consumer must extract). Its fields are the image of what consumers read: `zpowHom u w`
  injective (X02D's "two multiplicatively independent elements", i.e. `ℤ² ≅ Γ`), and for every finite-index
  `Λ ⊆ ℤ²` the values on `Λ` generate `fieldI F` — the page's "`ℚ(Γ′) = L` for every finite-index `Γ′`", read through
  `ℤ² ≅ Γ` in exactly the form `ZdAction.IsTotallyIrreducible` quantifies (finite-index `Λ : AddSubgroup (Fin d → ℤ)`). The
  operational form is a constructor theorem (`AdmissiblePair.ofPow`). The group `Γ` is `p.subgroup`, the range of
  `zpowHom`, acting by the canonical subgroup action — the instance `action_ergodic_decomposition` takes at `H = Γ`.
  Unsampled member: `F = ℝ` has no admissible pair (the closure of a countable set is not `ℂ`), which is why
  `exists_admissiblePair` takes `[NumberField F]`.
- **The pieces' carrier**: `PieceDual M := Additive (AddChar M Circle)`, a `def` with its own instances (`inferInstanceAs`)
  — the declared theorem takes an additive group, Mathlib has no `MeasurableSpace (Additive α)`
  (`logs/lean-Readback.log`: not synthesized), and instances on our own type are not speech on `Additive`. Weighed:
  `M →+ AddCircle 1` (natively additive; restriction from `Dual F` would need a logarithm). `IsPiece p M` as a `structure`
  of two `Prop` fields (finitely generated over `ℤ[Γ]`; `R/M` torsion — `ℚM = F(i)` stated without ℚ-spans);
  stability under `Γ` is a theorem (`IsPiece.mulR_mem`), not a field. `pieceAction`'s laws are the named lemmas
  `pieceMul_zero`, `pieceMul_add`, `dualMap_comp`, `continuous_dualMap`. Unsampled member: `M = 0` — a one-point solenoid
  whose action is virtually cyclic; full rank excludes it.

### 2.3 The obligation pass (`debruijn-obligation-modeling`, a fresh invocation, scoped to every new statement)

Each statement checked true as typed, with its decomposition below (§ 2.5). **Three statements of mine were false as first
typed and are corrected before this commit**: `isSolenoid_pieceDual`, `isTotallyIrreducible_pieceAction` and
`isPiece_closure_one` lacked `[NumberField F]`. Counter-model: a countable `F` carrying an admissible pair with `u`, `w`
transcendental — `ℤ[Γ]` is then a Laurent ring of infinite `ℤ`-rank, so its dual embeds in no `ℚⁿ` (not a solenoid), Lemma F's
finiteness fails, and `ℚ[Γ] ⊊ ℚ(Γ)` breaks the full rank of `ℤ[Γ]·1`. Every use is at a number field. Not a defect of the
chain's typed statements: these are new. Two places where the pass found a hypothesis derivable rather than missing:
`ksEntropy_rot_eq_iSup` needs the pieces countable, which a chain of finitely generated `ℤ[Γ]`-modules exhausting `R`
already implies; `integral_eq_zero_of_isAddHaarMeasure` needs `MeasurableAdd (PieceDual M)`, true for every `M` (an
instance to supply in the module).

**A classical input the leaf list does not name — Pontryagin duality for a discrete countable group, in two halves**
(prior-art debt and a decision for the coordinator; X02D's HX-1 step 1 and PE-1′ read it as "[textbook]"):
- **D1**: every continuous character of `Ĝ` is an evaluation at a point of `G` (NF2-LEAF-15's draft names this half). Proof
  in reach: continuity at `1` gives finitely many points `x₁, …, x_k` whose joint kernel `H` maps into the right half
  circle, so into `{1}`; the character factors through `Ĝ/H ≅ N̂` for `N = ⟨x₁, …, x_k⟩ ≅ ℤʲ ⊕ finite`, a torus times a finite
  group, whose continuous characters are monomials. About a day; formalize.
- **D2**: a closed subgroup `Y ⊆ Ĝ` is the annihilator of its annihilator — equivalently, continuous characters separate
  the points of the compact group `Ĝ/Y`. That is the Peter–Weyl (or duality) theorem for compact abelian groups: Haar
  measure, `L²`, compact convolution operators. Larger than an hour by far. PE-1′'s total irreducibility needs it at
  `N = Y^⊥ = 0` (a proper closed subgroup has a non-zero annihilator). **My call: a separate planner-and-implementer job**
  (Kooshi's W2 prefers the whole chain formalized), with the declared-axiom route (`[Rudin1962]` §§ 1.5, 2.1) as the
  fallback if it is priced over a week.

### 2.4 Read aloud against the sources

| statement | source | reading |
|---|---|---|
| `measure_eq_of_fourier` | X02D l. 174, T4: "a finite Borel measure on a compact abelian group is determined by its Fourier coefficients" | equal at `Ĝ` for countable `G` (the only duals the chain reads); the Borel measures are the cylinder ones (`borelSpace_dual`) |
| `dualHaar`, `isHaarFourier_iff` | EN2 § 5.2's inputs: "Haar measure exists and is `U`-invariant"; FS100's `m` | `m` is the Haar probability; the library's `IsHaarFourier` is the same measure |
| `IsHaarFourier.rotInv` | X02D l. 191, "`u_*m = m`"; EN2-PE2-MAX "uses only: `u_*m = m`" | equal |
| `standardBorelSpace_dual` | KN7 § Stage 4: the release's decomposition asks `[StandardBorelSpace Y]` | the instance at `Y = Dual F` |
| `AdmissiblePair` | X02D l. 146: "generated by two multiplicatively independent elements and `ℚ(Γ′) = L` for every finite-index `Γ′ ⊆ Γ`" | equal through `ℤ² ≅ Γ`; `L = fieldI F`, `ℚ(·)` = `Subfield.closure` |
| `AdmissiblePair.ofPow` | X02D l. 147: "in particular if `Γ` contains a `w` with `ℚ(wᵏ) = L` for every `k ≥ 1`" | equal (with `u`, `w` independent) |
| `exists_admissiblePair` | X02D l. 156, Lemma W, at one `u` | weaker than Lemma W (existence of one pair), which is all the path reads (KN7 § 6.1) |
| `IsPiece` | X02D § 3 "Setting": "finitely generated `ℤ[Γ]`-submodules `M ⊆ R` with `ℚM = L`" | equal (`ℚM = L` ⟺ `R/M` torsion, since `ℚR = L`) |
| PE-1′'s three | X02D l. 148: "`M̂` is a solenoid, the `Γ`-action is by automorphisms, totally irreducible, not virtually cyclic" | equal; "by automorphisms" is `ZdAction` (continuous endomorphisms with `α^{-n}` inverse) |
| `isErgodicOn_map_toPiece` | X02D l. 185, step 1 | equal; "ergodic" on the piece in the declared theorem's strict form |
| `ksEntropy_rot_eq_iSup` | X02D l. 188–189, step 3, "`h_ρ(γ) = lim_k h_{ρ_k}(γ)`" | the limit as a supremum (it is non-decreasing, as the step says) |
| `integral_eq_zero_of_isAddHaarMeasure` | X02D l. 190–191, step 4, "each Fourier coefficient … is computed on `M̂_k` for `k` large" | the computation at one piece |
| `isHaarFourier_or_ksEntropy_eq_zero` | X02D l. 183: "For admissible `Γ` and a `Γ`-invariant, `Γ`-ergodic probability measure `ρ` on `R̂`: `ρ = m`, or `h_ρ(γ) = 0` for every `γ ∈ Γ`" | equal: invariance and ergodicity are Mathlib's `ErgodicSMul p.subgroup (Dual F) ρ` — the release's decomposition's own conclusion, so step 3 of the split applies it with no translation; `ρ = m` is `IsHaarFourier ρ` |

**Models.** `dualHaar G` at `G = ℤ` (`example`, and the spec theorem `dualHaar_fourier_zero`, proved, which fails if
`dualHaar` drifts off a probability). The action and `zpowHom` at every `F`. `AdmissiblePair` at every real number field by
the leaf `exists_admissiblePair`; at `ℚ`, `u = (5 + 12i)/13`, `w = (3 + 4i)/5` (independent: the primes above 13 and 5 of
`ℤ[i]`; `ℚ(wᵏ) = ℚ(i)` since `wᵏ ∉ ℝ`, as `wᵏ` real on the circle would be `±1`). `IsPiece` by `isPiece_closure_one`. Lemma
Γ's hypothesis by the point mass at the trivial character (invariant; ergodic as every set has measure `0` or `1`); its
first disjunct by `dualHaar` (whose ergodicity is not claimed).

### 2.5 A plan per leaf (Mathlib names checked at the pin: `logs/lean-Names.log`, 28 names, 0 errors; `logs/lean-Readback.log`)

**`Rigidity/DualGroup`** (Mathlib only; one implementer):
1. `isClosedEmbedding_coe`: `⟨⟨⟨rfl⟩, injective⟩, isClosed_range⟩` — inducing is the definition (`Topology.IsInducing.induced`);
   injective by `DFunLike.ext` and `Circle` coercion injectivity; the range is `{f | f 0 = 1} ∩ ⋂ g h, {f | f (g+h) = f g * f h}
   ∩ ⋂ g, {f | ‖f g‖ = 1}` (an `AddChar` built from `f` with values `⟨f g, mem_sphere_zero_iff_norm.2 _⟩`), each closed by
   `isClosed_eq` over `continuous_apply`.
2. `isTopologicalGroup_dual`: `continuous_mul`/`continuous_inv` through `continuous_induced_rng`; coordinate `g` of `χ * ψ` is
   `χ g * ψ g` (`AddChar.coe_mul`, `Circle.coe_mul`); of `χ⁻¹` is `conj (χ g)` (`Circle.coe_inv_eq_conj`, `Complex.continuous_conj`).
3. `compactSpace_dual`: range ⊆ `Set.univ.pi fun _ => Metric.sphere 0 1`, compact by `isCompact_univ_pi` and `isCompact_sphere`;
   closed (leaf 1), so compact (`IsCompact.of_isClosed_subset`); `(isClosedEmbedding_coe G).isInducing.isCompact_iff` at
   `univ` (`Set.image_univ`), `isCompact_univ_iff`.
4. `polishSpace_dual`: `(isClosedEmbedding_coe G).polishSpace` (`PolishSpace (G → ℂ)` is an instance for countable `G`:
   `inferInstance : PolishSpace (ℕ → ℂ)` elaborates).
5. `borelSpace_dual`: `⟨(borel_comap).trans (congrArg _ (Pi.borelSpace).measurable_eq).symm⟩` read backwards — both are the
   comap by one map of `borel (G → ℂ) = MeasurableSpace.pi`.
6. `standardBorelSpace_dual`: from 4 and 5 (`inferInstance` inside the scope; Mathlib's instance from Polish and Borel).
7. `exists_apply_ne_one`: `CharacterModule.exists_character_apply_ne_zero_of_ne_zero` gives `c : G →+ AddCircle (1 : ℚ)` with
   `c r ≠ 0`; push to `AddCircle (1 : ℝ)` by the injective map induced by `ℚ → ℝ` (`QuotientAddGroup.map`, injective since
   a rational in `ℤ` modulo… is an integer); then `AddCircle.toCircle` (`AddCircle.toCircle_add`, `AddCircle.injective_toCircle`)
   as an `AddChar`. Hard: the `ℚ/ℤ → ℝ/ℤ` injectivity, a few lines.
8. `measure_eq_of_fourier`: `evalBCF r : AddChar G Circle →ᵇ ℂ` (`BoundedContinuousFunction.mkOfCompact` of
   `continuous_evalChar`); `A := StarAlgebra.adjoin ℂ (Set.range evalBCF)`; integrals agree on `A` by
   `StarAlgebra.adjoin_induction` (generators by `h`; `algebraMap` by `ev_0 = 1`; `+` and scalar by linearity; `*` because
   `evalBCF r * evalBCF s = evalBCF (r + s)` — so in fact the span of generators is closed and the induction's product case
   needs the span form: prove first `∀ g ∈ A, g ∈ Submodule.span ℂ (Set.range evalBCF)` by `Algebra.adjoin_eq_span` and the
   generators being a submonoid closed under `star`); separation: `χ ≠ χ'` gives `r` with `χ r ≠ χ' r`. Then
   `ext_of_forall_mem_subalgebra_integral_eq_of_polish`. **Hard leaf of the module** (the star-subalgebra plumbing).
9. `isProbabilityMeasure_dualHaar`: `⟨by simpa using haarMeasure_self (K₀ := ⊤)⟩` (`↑(⊤ : PositiveCompacts _) = univ`).
10. `isHaarFourier_dualHaar`: `MeasurableMul (AddChar G Circle)` from `ContinuousMul` + Borel + second countable; for `r ≠ 0`,
    `ψ` from 7; `integral_mul_left_eq_self (fun χ => (χ r : ℂ)) ψ` and `(ψ * χ) r = ψ r * χ r` give `I = ψ r * I`, so `I = 0`
    (`ψ r ≠ 1` in `ℂ`).
11. `isHaarFourier_iff`: `→` `measure_eq_of_fourier` with coefficients split at `r = 0` (`AddChar.map_zero_eq_one`,
    `integral_const`, `measure_univ`) and off it (both `0`); `←` `▸ isHaarFourier_dualHaar`.
12. `IsHaarFourier.map_dual`: measurability by `SpectralInputs.measurable_of_evalChar`; `isProbabilityMeasure_map`;
    `integral_map` (`AEMeasurable` from measurability; integrand `measurable_evalChar`); `hm.2 (φ r) (hφ.ne_iff' map_zero …)`.
13. `IsHaarFourier.map_mul_right`: as 12, with `(χ * a) r = χ r * a r`, `integral_mul_const`, `hm.2 r hr`.

**`Rigidity/UnitCircle`** (one implementer, after DualGroup):
1. `uvRing_toUnitVector_mul`, `_one`: `Subtype.ext`; `Subgroup.coe_mul`, `Circle.coe_mul`, `Subring.coe_mul`; `Circle.coe_one`.
2. `rotInv_iff`: `smul_def` and the surjectivity of `toUnitVector` (`(unitCircleEquiv F).surjective`).
3. `countable_unitCircle`: `Function.Injective.countable` of `g ↦ uvRing (toUnitVector g)` into the countable `unitRing F`
   (`countable_unitRing` over `Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)`, as in `ChainAtTA`).
4. `IsHaarFourier.rotInv`: `rot u = fun χ => χ.compAddMonoidHom (AddMonoidHom.mulLeft (uvRing u))` by `rfl`; injectivity of
   `mulLeft` (`mul_left_cancel₀` in the domain `unitRing F`, `uvRing u ≠ 0` from `‖u‖ = 1`); `IsHaarFourier.map_dual_eq`.
5. `u_nonTorsion`: `(toUnitVector p.u : ℂ) ^ k = 1` lifts to `p.u ^ (k : ℤ) = 1` (coercions injective), i.e.
   `zpowHom (ofAdd ![k, 0]) = zpowHom 1`; injectivity gives `![k, 0] = 0`, so `k = 0`.
6. `ofPow`'s `generates`: `le_antisymm` — `≤` by `Subfield.closure_le` (every value lies in `unitCircle F`); `≥`:
   `Λ.index • ![0, 1] ∈ Λ` (`AddSubgroup.nsmul_index_mem`, `Λ.index ≠ 0` from `FiniteIndex`), its value `w ^ Λ.index`, so
   `closure {w ^ Λ.index} ≤ closure (image)` (`Subfield.closure_mono`), and `hw` at `k = Λ.index`.
7. `exists_admissiblePair`: **hard, number theory; the module's heavy leaf.** X02D's construction twice: rational primes
   `p ≠ q` splitting completely in `L = F(i)` (one each; at biquadratic `L` from Dirichlet, `Nat.infinite_setOf_prime_and_eq_mod`;
   in general from Chebotarev — NF2-LEAF-19 — or the elementary fact that infinitely many primes divide values of a
   polynomial, Schur), primes `𝔓 ∣ p`, `𝔔 ∣ q` of `L` with `𝔓 ≠ 𝔓̄`, `(z) = 𝔓ʰ`, `w = z/z̄`, `u` likewise at `𝔔`; `ℚ(wᵏ) = L`
   by X02D's valuation argument (ll. 160–162), independence by valuations at `𝔓` and `𝔔`; then `ofPow`. Mathlib has the
   class group (`NumberField.classNumber`) and the valuations; this is a planner-and-implementer job of its own. At `ℚ(√47)`
   NF2-LEAF-19 says Dirichlet suffices.

**`Rigidity/Pieces`** (one implementer, after UnitCircle; leaves 8–9 wait on the duality job D1/D2 of § 2.3):
1. `continuous_dualMap`: `continuous_induced_rng.2`, coordinate `x` is `continuous_evalChar (φ x)` (through `ofChar` = id).
2. `measurable_toPiece`: `SpectralInputs.measurable_of_evalChar` (coordinate `x` is evaluation at `(x : unitRing F)`).
3. `IsPiece.mulR_mem`: rewrite `M` by `fg`; `AddSubgroup.closure_induction`; on a generator `mulR n x'`, `mulR m (mulR n x')
   = mulR (m + n) x'` (`map_mul` of `zpowHom`, `uvRing_toUnitVector_mul`, `mul_assoc`).
4. `pieceMul_zero`, `pieceMul_add`: `AddMonoidHom.ext`, `Subtype.ext`; `zpowHom` at `0` is `1`, `uvRing_toUnitVector_one`;
   at `m + n`, `map_mul`, `uvRing_toUnitVector_mul`, `mul_comm`, `mul_assoc`.
5. `toPiece_rot`: `rfl` up to `Subtype` coercions — both sides are `x ↦ χ (uvRing (…) * x)`; else `DFunLike.ext` and `rfl`.
6. `not_isVirtuallyCyclic_pieceAction`: from `α m = α (k • n)`, evaluating at every `χ` and at `x := 1`'s full-rank multiple in
   `M` gives `χ (zpow m · x) = χ (zpow (k n) · x)` for every character of `M` — separation on `M` (DualGroup's
   `exists_apply_ne_one`) gives `zpow m · x = zpow (k n) · x`, cancel `x ≠ 0`, injectivity gives `m = k • n`; so `Λ ⊆ ℤ n`, and a
   finite-index subgroup of `ℤ²` in a cyclic one contradicts `index` finiteness (`ℤ² ⧸ ℤn` infinite: `![a,b]` with `(a,b)` not
   parallel to `n` has infinite order modulo it).
7. `isPiece_closure_one`: `fg` with `s = {1}`; full rank: `ℚ[Γ] = ℚ(Γ) = fieldI F` (`generates ⊤`; `Γ` algebraic over `ℚ`, so the
   ring adjoined is the field — `Algebra.adjoin` of integral elements, `IntermediateField.adjoin_simple_toSubalgebra_of_integral`
   shape), so each `r ∈ R ⊆ fieldI F` is a rational combination of values `zpow n`; clear denominators.
8. `isSolenoid_pieceDual`: compact, Hausdorff, topological group from DualGroup through `inferInstanceAs`; connected: the
   identity component's quotient is profinite, and a non-trivial one has a continuous character of finite order, by **D1** an
   evaluation at an `x` with `n x` killed by every character, so `n x = 0` (separation), `x = 0` — torsion-free `M`; `dual_embeds`:
   by **D1** the continuous characters are the evaluations, so `PontryaginDual …` embeds in `M ⊆ fieldI F ≅ ℚ^{2[F:ℚ]}`
   (`Module.finrank ℚ (fieldI F)`, a basis). **Hard**; waits on D1.
9. `isTotallyIrreducible_pieceAction`: `Y` closed, `α_Λ`-invariant; by **D2** `Y = (Y^⊥)^⊥` with `N = Y^⊥ ⊆ M` stable under
   multiplication by `zpow n`, `n ∈ Λ`. `N = 0` gives `Y = ⊤`. `N ≠ 0`: `ℚN` is a `ℚ(Γ_Λ) = fieldI F`-subspace (`generates Λ`), so
   `ℚN = ℚM` and `M/N` is torsion; `M` is finitely generated over `ℤ[Γ_Λ]` (coset representatives of `ℤ²/Λ`), so one integer
   kills `M/N`, a quotient of `M/kM`, finite by Lemma F (`M` torsion-free of finite rank; C0's Lemma F); `Y ≅ (M/N)^` is finite.
   **Hard**; waits on D2 and Lemma F.
10. `exists_pieceChain`: enumerate `R` (countable, `countable_unitRing`): `M k := closure (Γ·{1, r₀, …, r_{k−1}})`; monotone by
    `closure_mono`; `IsPiece` with `s = {1, r₀, …}` and full rank from 7's inclusion `M 0 ⊆ M k`; `r_k ∈ M (k+1)`.
11. `isErgodicOn_map_toPiece`: (i) `MeasurePreserving (α n)`: `Measure.map_map`, `toPiece_rot`, `hρ.toSMulInvariantMeasure`
    (`measure_preimage_smul` / `map_smul`) at `g = zpowHom (ofAdd n) ∈ p.subgroup`; measurability of `α n` by evaluations; (ii)
    for strictly invariant measurable `s`: `S := toPiece M ⁻¹' s` is strictly invariant under every `g ∈ p.subgroup`
    (`mem_subgroup`, `toPiece_rot`), so `ErgodicSMul.aeconst_of_forall_preimage_smul_ae_eq` gives `EventuallyConst S (ae ρ)`, i.e.
    `ρ S = 0 ∨ ρ Sᶜ = 0` (`Filter.eventuallyConst_set'`-shape), and `Measure.map_apply`.
12. `ksEntropy_rot_eq_iSup`: `𝒜 k := MeasurableSpace.comap (toPiece (M k)) inferInstance`; monotone (restriction `M k ⊆ M k'`
    factors `toPiece`; `MeasurableSpace.comap_comp`, `comap_le_iff_le_map`); `⨆ 𝒜 k = ` the cylinder σ-algebra (`le_antisymm`:
    each `𝒜 k ≤` by `measurable_toPiece.comap_le`; each evaluation `χ ↦ χ r` is `𝒜 k`-measurable for `r ∈ M k`, and the
    cylinder σ-algebra is generated by them, `measurable_iff_comap_le`); countably generated: `MeasurableSpace.CountablyGenerated.comap`
    with `PieceDual (M k)` countably generated (`M k` countable as the closure of a countable set; a countable product of
    `ℂ`); T2 (`ksEntropy_eq_iSup_ksEntropyOn`, lane E's leaf 10) with `hT` from `hρ`; then each term by `ksEntropy_map` with
    `toPiece_rot` (intertwining) and measurability of `α n`.
13. `integral_eq_zero_of_isAddHaarMeasure`: `integral_map` to `PieceDual M`; `ψ₀ : AddChar M Circle` with `ψ₀ ⟨r, hr⟩ ≠ 1`
    (`exists_apply_ne_one`, `Subtype.ext` for `≠ 0`); `MeasurableAdd (PieceDual M)` (an instance to add, by evaluations);
    `integral_add_left_eq_self` with `(ofChar ψ₀ + χ) r = ψ₀ r * χ r` gives `I = ψ₀ r * I`.
14. **Lemma Γ** `isHaarFourier_or_ksEntropy_eq_zero`: `obtain ⟨M, hmono, hM, hex⟩ := exists_pieceChain`; `by_cases` on
    `∀ g ∈ p.subgroup, ksEntropy … = 0`. Else `g = zpowHom (ofAdd n)` (`mem_subgroup`) with positive entropy; by 12 some
    `k₀` has `ksEntropy (ρ.map (toPiece (M k₀))) (α n) ≠ 0`, and every `k ≥ k₀` too (each term is `ksEntropyOn (𝒜 k)`, monotone,
    `ksEntropyOn_mono`); at each such `k`, `haar_or_zero_entropy` (instances `BorelSpace`, `PolishSpace` of `PieceDual (M k)`
    with `M k` countable; hypotheses 8, 9, 6, `isProbabilityMeasure_map`, 11) and the positive entropy give
    `IsAddHaarMeasure`; for `r ≠ 0` pick `k ≥ k₀` with `r ∈ M k` (`hex`, `hmono`) and apply 13. Thirty lines.

### 2.6 Item 3 — `haar_or_zero_entropy`'s Polish question: settled, and the binder added (standing word, ruling 2)

**The proof needs it** on the route FS105-DED takes. Its finite-fibred step: with every `G j` finite, entropy zero on
`X ⧸ G j` (clause (4), since KN7 over `borel (X ⧸ G j)`) must give entropy zero on `X`. Take a finite Borel partition `Q` of
`X` whose cells meet each coset of `G j` in at most one point (compactness and `G j` finite); then the factor σ-algebra
`π⁻¹(Σ)` joined with `Q` is the Borel σ-algebra of `X` — the relative entropy over a finite extension is then at most the
entropy of `Q`'s names along a fibre, `log |G j|` per block, and vanishes per step — **exactly when** each image `π(B ∩ q)`
of a Borel set is in `Σ`. With Mathlib's quotient σ-algebra that is the definition (`π⁻¹(π(B ∩ q)) = (B ∩ q) + G j` is
Borel); with `borel (X ⧸ G j)` it is Lusin–Souslin (`π` injective and continuous on `q`), which needs `X` Polish. So the
proof runs over `positive_entropy_rigidity_of_polishSpace`. Whether a non-metrizable compact `X` has the two σ-algebras on
`X ⧸ G` differ for finite `G` I did not settle ([reading], not needed).

**The condition of the standing word**: every use on the headline's path is Lemma Γ's, at `X = PieceDual (M k)` with
`M k` countable, whose `PolishSpace` is `Rigidity.polishSpace_dual` through `inferInstanceAs` (`Rigidity/Pieces`; a leaf of
`Rigidity/DualGroup` with its plan, § 2.5 item 4 — a theorem of the library once that leaf lands, and a one-line one).

**The change**: `[PolishSpace X]` after `[BorelSpace X]` in `Rigidity.haar_or_zero_entropy`; its docstring gains the
paragraph above. **From the kernel's side** (`data/fs131/kn8/lean/ModuleDump.lean`, KN7's dumper; before from the tree's
compiled module, `logs/lean-dump-before.log`; after from the recompiled one, `logs/lean-dump-after.log`;
`tools/fs131_kn8_dump_diff.py`): `ADDED=0 REMOVED=0 CHANGED=1 SAME=3` (`logs/dump-diff.out`) — `haar_or_zero_entropy`
changed, the axiom, its model and the Polish form byte-identical; control (`--plant`): `CHANGED=4` (`dump-diff-control.out`).
**Sharper** (`logs/dump-binder-check.out`): the after-print is the before-print with exactly the text
` [@PolishSpace.{u_1} X inst_1]` inserted at character 213 (`True`), and one character short of it does not reproduce
(`False`, the control). No proof reads the theorem yet (it is a leaf, and no module calls it), so nothing else moves.
