import Proofs.HadwigerNelson.Rigidity.ThinBoxes
import Proofs.HadwigerNelson.Rigidity.Multipliers

/-!
# The pigeonhole, two scales and one global point (FS-131, job FS131-K8B1; module M8b-3b; skeleton)

Part 3 of M8b (`plans/FS131-K8B1-zero-entropy-second.md`; X01D §§ 3.4–3.6, `plans/FS100-X01D-derivation.md` ll. 246–287), over
`(D : TateModel F)`, with FS131-KN8's multipliers (`Rigidity/Multipliers`).

**Read aloud.** Write `D := [L:ℚ]`, and index the scales by `B ∈ ℕ`: the multipliers `v_1, …, v_B` have heights at most
`M(B) := (3B)^D` (`scaleHeight`), the thinness is `δ(B) := M(B)^{−16}` (`scaleThin`, X01D's `δ(M) = M^{−K}`, `K = 16`), and
the exponent is `β := 1/(32 D)` (`heavyExponent`, X01D's `β = α/(2K)` at `α = α′ = 1/D`).

* **Step 3, the pigeonhole** (X01D § 3.4; `TateModel.exists_collision`): if `B · μ(π(x̃ + Q̄_p(2ε, δ))) > 1`, two of the sets
  `v_b·π(x̃ + Q̄_p(2ε, δ))`, `1 ≤ b ≤ B`, meet (each has the measure of the first: `μ` is invariant), so there are
  `b₁ ≠ b₂` and `a₁, a₂ ∈ Q̄_p(2ε, δ)` with `r := v₁(x̃ + a₁) − v₂(x̃ + a₂) ∈ Λ` — a **collision** (`Collision`). Its
  `ℓ := v₁ − v₂ ∈ R ∖ 0` and its **point** `t := r/ℓ ∈ L` (`Collision.point`), and `e := ℓ x̃ − r = v₂a₂ − v₁a₁ = ℓ(x̃ − t)`
  (`Collision.mul_sub_point`). The closed box `Q̄` replaces X01D's open `Q` here: its image under `π` is Borel
  (`TateModel.measurableSet_image`), and every bound below reads only `≤ 2ε`.
* **Step 4, two scales** (X01D § 3.5; `Collision.point_eq`): collisions at the scales `B` and `3B²` (so `M(3B²) = M(B)²`, X01D's
  `M` and `M²`) have one point: `z := ℓ₂r₁ − ℓ₁r₂ = ℓ₁e₂ − ℓ₂e₁ ∈ Λ` has archimedean factors `≤ 16ε ≤ 1` (at an archimedean `p`,
  `≤ 8δ(B)`), split factors `≤ m₁(w)m₂(w)` (at a split `p`, times `δ(B)`), so its product is `≤ 8δ(B)M(B)²M(3B²)² = 8M(B)^{−10}`,
  below the gap: `z = 0`.
* **Step 5, the point is global at `p`** (X01D § 3.6; `Collision.size_sub_point_le`): `|x̃ − t|_p = |e|_p/|ℓ|_p ≤
  2^{D+2}·M(B)³·δ`, by Lemma PF for `ℓ ∈ R` (`one_le_prod_absAt_of_mem_stableIntegers`).
* **The global point** (`TateModel.exists_point_of_heavy`): if the thin boxes at `x̃` are heavy (Lemma 3.1′'s conclusion at
  `β = heavyExponent F`), iterate the scales `B, 3B², …` from a large `B` (the pigeonhole holds once `B ≥ 4`:
  `B·δ(B)^β = (B/3)^{1/2}`): every consecutive pair has one point, so all have one `t`, and `|x̃ − t|_p → 0`: `x̃ − t ∈ W_p`.
* **The leaf set** `π(L + W_p)` (`TateModel.leafSet`) is Borel (`measurableSet_leafSet`), and **carries `μ`**
  (`TateModel.measure_leafSet_compl_eq_zero`): Lemma 3.1′ for every `η` and the global point (X01D l. 286: "every `x ∈ X′` lies in
  `T + K_{v*}` … `μ(R̂ ∖ (T + K_{v*})) = 0`").

**Inhabitants.** `Collision D x̃ p ε δ B` is a structure of data; it is inhabited exactly when two of the moved boxes meet, which
`exists_collision` supplies under its hypothesis, itself met at the point mass at `1` with `x̃ = 0` (every box's image holds `1`,
`B ≥ 2`). The measure hypotheses of `measure_leafSet_compl_eq_zero` are `thinBox_heavy`'s (`Rigidity/ThinBoxes`).
-/

namespace HadwigerNelson.Rigidity

open SpectralChain NumberField MeasureTheory WPlace

noncomputable section

variable (F : Subfield ℝ) [NumberField F]

/-- **The height bound at scale `B`**, `M(B) = (3B)^{[L:ℚ]}`: every `v_b`, `1 ≤ b ≤ B`, has split height at most `M(B)`. -/
def scaleHeight (B : ℕ) : ℝ := (3 * (B : ℝ)) ^ Module.finrank ℚ (fieldI F)

/-- **The thinness at scale `B`**, `δ(B) = M(B)^{−16}` (X01D l. 251: `δ(M) := M^{−K}`, `K = 16`). -/
def scaleThin (B : ℕ) : ℝ := (scaleHeight F B)⁻¹ ^ 16

/-- **The exponent of heaviness**, `β = 1/(32 [L:ℚ])` (X01D l. 251: `β := α/(2K)`, here `α = 1/[L:ℚ]`, `K = 16`). -/
def heavyExponent : ℝ := 1 / (32 * (Module.finrank ℚ (fieldI F) : ℝ))

example (B : ℕ) : scaleHeight F B = (3 * (B : ℝ)) ^ Module.finrank ℚ (fieldI F) := rfl

example (B : ℕ) : scaleThin F B = (scaleHeight F B)⁻¹ ^ 16 := rfl

example : heavyExponent F = 1 / (32 * (Module.finrank ℚ (fieldI F) : ℝ)) := rfl

theorem heavyExponent_pos : 0 < heavyExponent F := by
  sorry

/-- `M(3B²) = M(B)²` (X01D's scales `M` and `M²`). -/
theorem scaleHeight_three_mul_sq (B : ℕ) : scaleHeight F (3 * B ^ 2) = scaleHeight F B ^ 2 := by
  sorry

variable {F}

/-- **A collision at scale `B`** (X01D l. 255): two distinct multipliers `v_{b₁}, v_{b₂}` (`1 ≤ bᵢ ≤ B`) and two points
`a₁, a₂` of the closed thin box with `v₁(x̃ + a₁) − v₂(x̃ + a₂) = ι(y)`, `y ∈ Λ`. -/
structure Collision (D : TateModel F) (xw : SAdeleRing F) (p : WPlace F) (ε δ : ℝ) (B : ℕ) where
  /-- The first multiplier's index. -/
  b₁ : ℕ
  /-- The second multiplier's index. -/
  b₂ : ℕ
  /-- `1 ≤ b₁ ≤ B`. -/
  mem₁ : b₁ ∈ Finset.Icc 1 B
  /-- `1 ≤ b₂ ≤ B`. -/
  mem₂ : b₂ ∈ Finset.Icc 1 B
  /-- The two multipliers are distinct. -/
  ne : b₁ ≠ b₂
  /-- The first point of the box. -/
  a₁ : SAdeleRing F
  /-- The second point of the box. -/
  a₂ : SAdeleRing F
  /-- `a₁ ∈ Q̄_p(2ε, δ)`. -/
  box₁ : a₁ ∈ closedThinBox p (2 * ε) δ
  /-- `a₂ ∈ Q̄_p(2ε, δ)`. -/
  box₂ : a₂ ∈ closedThinBox p (2 * ε) δ
  /-- The lattice point `r`. -/
  y : fieldI F
  /-- `r ∈ Λ`. -/
  mem_Λ : y ∈ D.Λ
  /-- `v₁(x̃ + a₁) − v₂(x̃ + a₂) = ι(r)`. -/
  eq : toSAdele F (unitL (multiplier F b₁)) * (xw + a₁) - toSAdele F (unitL (multiplier F b₂)) * (xw + a₂) =
    toSAdele F y

namespace Collision

variable {D : TateModel F} {xw : SAdeleRing F} {p : WPlace F} {ε δ : ℝ} {B : ℕ}

/-- `ℓ = v₁ − v₂` (X01D l. 256). -/
def ℓ (c : Collision D xw p ε δ B) : fieldI F := unitL (multiplier F c.b₁) - unitL (multiplier F c.b₂)

/-- **The collision's point** `t = r/ℓ` (X01D l. 275). -/
def point (c : Collision D xw p ε δ B) : fieldI F := c.y / c.ℓ

example (c : Collision D xw p ε δ B) : c.point = c.y / c.ℓ := rfl

theorem ℓ_ne_zero (c : Collision D xw p ε δ B) : c.ℓ ≠ 0 := by
  sorry

/-- `ℓ ∈ R`: a difference of two unit vectors. -/
theorem ℓ_eq_ofUnitRing (c : Collision D xw p ε δ B) :
    c.ℓ = ofUnitRing F (uvRing (multiplier F c.b₁) - uvRing (multiplier F c.b₂)) := by
  sorry

/-- **`e = v₂a₂ − v₁a₁ = ℓ(x̃ − t)`** (X01D ll. 256, 281). -/
theorem mul_sub_point (c : Collision D xw p ε δ B) :
    toSAdele F (unitL (multiplier F c.b₂)) * c.a₂ - toSAdele F (unitL (multiplier F c.b₁)) * c.a₁ =
      toSAdele F c.ℓ * (xw - toSAdele F c.point) := by
  sorry

/-- **Step 4: two scales give one point** (X01D § 3.5): collisions at the scales `B` and `3B²` with the thinness `δ(·)` have
the same point, once `8M(B)^{−10}` is below the gap `C` and `16ε ≤ 1`. -/
theorem point_eq {C : ℝ} (hC : D.IsGap C) (hε16 : 16 * ε ≤ 1)
    (hBC : 8 * (scaleHeight F B)⁻¹ ^ 10 < C)
    (c₁ : Collision D xw p ε (scaleThin F B) B) (c₂ : Collision D xw p ε (scaleThin F (3 * B ^ 2)) (3 * B ^ 2)) :
    c₁.point = c₂.point := by
  sorry

/-- **Step 5: the point is global at `p`, up to the scale** (X01D § 3.6): `|x̃ − t|_p ≤ 2^{[L:ℚ]+2}·M(B)³·δ`. -/
theorem size_sub_point_le (c : Collision D xw p ε δ B) :
    p.size (xw - toSAdele F c.point) ≤ 2 ^ (Module.finrank ℚ (fieldI F) + 2) * scaleHeight F B ^ 3 * δ := by
  sorry

end Collision

namespace TateModel

variable (D : TateModel F)

/-- **Step 3, the pigeonhole** (X01D § 3.4): if `B·μ(π(x̃ + Q̄_p(2ε, δ))) > 1`, the `B` rotated copies of the set cannot be
disjoint (`exists_nonempty_inter_of_measure_univ_lt_sum_measure`; each copy has the set's measure, `μ` being invariant and
the copies Borel), and two that meet are a collision (`π_unit_mul`, `π_eq_π_iff`). -/
theorem exists_collision (μ : Measure (Dual F)) [IsProbabilityMeasure μ] (hμ : RotInv F μ) (xw : SAdeleRing F)
    (p : WPlace F) (ε δ : ℝ) (B : ℕ)
    (hB : 1 < (B : ℝ) * μ.real (D.π '' ((xw + ·) '' closedThinBox p (2 * ε) δ))) :
    Nonempty (Collision D xw p ε δ B) := by
  sorry

/-- **The global point** (X01D §§ 3.5–3.6): if every thin box at `x̃` of thinness `δ ≤ δ₀` has measure at least `δ^β`
(`β = heavyExponent F`), then `x̃ − t ∈ W_p` for some `t ∈ L`. Route: from `B₀ ≥ 4` with `δ(B₀) ≤ δ₀` and `8M(B₀)^{−10} < C`, the
scales `B_{j+1} = 3B_j²`; at each a collision (`exists_collision`: `B·δ(B)^β = (B/3)^{1/2} > 1`, and the closed box contains the
open one); consecutive points agree (`Collision.point_eq`), so all equal one `t`; and `|x̃ − t|_p ≤ 2^{[L:ℚ]+2}M(B_j)^{−13} → 0`
(`Collision.size_sub_point_le`). -/
theorem exists_point_of_heavy (μ : Measure (Dual F)) [IsProbabilityMeasure μ] (hμ : RotInv F μ) {p : WPlace F}
    {C : ℝ} (hC0 : 0 < C) (hC : D.IsGap C) {ε : ℝ} (hε16 : 16 * ε ≤ 1) {δ₀ : ℝ} (hδ₀ : 0 < δ₀)
    {xw : SAdeleRing F}
    (hheavy : ∀ δ : ℝ, 0 < δ → δ ≤ δ₀ → δ ^ heavyExponent F ≤ μ.real (D.π '' ((xw + ·) '' thinBox p (2 * ε) δ))) :
    ∃ t : fieldI F, xw - toSAdele F t ∈ hyperplane p := by
  sorry

/-- **The leaf set `π(L + W_p)`** (X01D l. 286, `T + K_{v*}`). -/
def leafSet (p : WPlace F) : Set (Dual F) := D.π '' {a | ∃ t : fieldI F, a - toSAdele F t ∈ hyperplane p}

example (p : WPlace F) (χ : Dual F) :
    χ ∈ D.leafSet p ↔ ∃ a, (∃ t : fieldI F, a - toSAdele F t ∈ hyperplane p) ∧ D.π a = χ := Iff.rfl

/-- **The leaf set is Borel**: the countable union over `t ∈ L` of the images of the closed sets `ι(t) + W_p`
(`countable_fieldI`, `isClosed_hyperplane`, `measurableSet_image`). -/
theorem measurableSet_leafSet (p : WPlace F) : MeasurableSet (D.leafSet p) := by
  sorry

/-- **Zero entropy is carried by the leaf set** (X01D l. 286: "`μ(R̂ ∖ (T + K_{v*})) = 0`"): Lemma 3.1′ (`thinBox_heavy`) at
`β = heavyExponent F` and every `η > 0` gives `X′` of measure `> 1 − η` whose every point, through any lift
(`surjective_π`), has a global point (`exists_point_of_heavy`); so `μ(leafSet) ≥ 1 − η` for every `η`. -/
theorem measure_leafSet_compl_eq_zero (μ : Measure (Dual F)) [IsProbabilityMeasure μ] (hμ : RotInv F μ)
    {u : unitVectors F} (h0 : ksEntropy μ (rot u) = 0) {p : WPlace F} (hp : 1 < p.absAt (unitL u))
    {C : ℝ} (hC0 : 0 < C) (hC : D.IsGap C) {ε : ℝ} (hε : 0 < ε) (hε16 : 16 * ε ≤ 1)
    (hεC : (∏ v : InfinitePlace (fieldI F), (2 * ε * (1 + v (unitL u))) ^ v.mult) * splitHeight (unitL u) < C) :
    μ (D.leafSet p)ᶜ = 0 := by
  sorry

end TateModel

end

end HadwigerNelson.Rigidity
