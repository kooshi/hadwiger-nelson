import Proofs.HadwigerNelson.Rigidity.ThinBoxes
import Proofs.HadwigerNelson.Rigidity.Multipliers

/-!
# The pigeonhole, two scales and one global point (FS-131, job FS131-K8B1; module M8b-3b)

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
  have h : (0 : ℝ) < Module.finrank ℚ (fieldI F) := Nat.cast_pos.2 Module.finrank_pos
  exact one_div_pos.2 (by positivity)

omit [NumberField F] in
/-- `M(3B²) = M(B)²` (X01D's scales `M` and `M²`). -/
theorem scaleHeight_three_mul_sq (B : ℕ) : scaleHeight F (3 * B ^ 2) = scaleHeight F B ^ 2 := by
  unfold scaleHeight
  rw [← pow_mul, mul_comm (Module.finrank ℚ (fieldI F)) 2, pow_mul]
  push_cast
  ring

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
  refine sub_ne_zero.2 fun h => c.ne (multiplier_injective F (Subtype.ext ?_))
  exact congrArg (fun z : fieldI F => (z : ℂ)) h

/-- `ℓ ∈ R`: a difference of two unit vectors. -/
theorem ℓ_eq_ofUnitRing (c : Collision D xw p ε δ B) :
    c.ℓ = ofUnitRing F (uvRing (multiplier F c.b₁) - uvRing (multiplier F c.b₂)) := by
  rw [map_sub, ← unitL_eq_ofUnitRing, ← unitL_eq_ofUnitRing]
  rfl

/-- **`e = v₂a₂ − v₁a₁ = ℓ(x̃ − t)`** (X01D ll. 256, 281). -/
theorem mul_sub_point (c : Collision D xw p ε δ B) :
    toSAdele F (unitL (multiplier F c.b₂)) * c.a₂ - toSAdele F (unitL (multiplier F c.b₁)) * c.a₁ =
      toSAdele F c.ℓ * (xw - toSAdele F c.point) := by
  have hy : toSAdele F c.ℓ * toSAdele F c.point = toSAdele F c.y := by
    rw [← map_mul, Collision.point, mul_div_cancel₀ _ c.ℓ_ne_zero]
  have hℓ : toSAdele F c.ℓ =
      toSAdele F (unitL (multiplier F c.b₁)) - toSAdele F (unitL (multiplier F c.b₂)) := by
    rw [Collision.ℓ, map_sub]
  rw [mul_sub, hy, hℓ, ← c.eq]
  ring

/-- `e = ι(ℓ)·x̃ − ι(r)`. -/
private theorem e_eq (c : Collision D xw p ε δ B) :
    toSAdele F (unitL (multiplier F c.b₂)) * c.a₂ - toSAdele F (unitL (multiplier F c.b₁)) * c.a₁ =
      toSAdele F c.ℓ * xw - toSAdele F c.y := by
  rw [c.mul_sub_point, mul_sub, ← map_mul, Collision.point, mul_div_cancel₀ _ c.ℓ_ne_zero]

/-- The size of `e` at an archimedean place: the multipliers are isometries there. -/
private theorem size_e_arch (c : Collision D xw p ε δ B) (v : InfinitePlace (fieldI F)) :
    (WPlace.arch v).size (toSAdele F (unitL (multiplier F c.b₂)) * c.a₂ -
      toSAdele F (unitL (multiplier F c.b₁)) * c.a₁) ≤ (WPlace.arch v).size c.a₁ + (WPlace.arch v).size c.a₂ := by
  have h := size_add_le (WPlace.arch v) (toSAdele F (unitL (multiplier F c.b₂)) * c.a₂)
    (-(toSAdele F (unitL (multiplier F c.b₁)) * c.a₁))
  rw [size_neg, size_toSAdele_mul, size_toSAdele_mul, absAt_multiplier_arch, absAt_multiplier_arch, one_mul,
    one_mul, ← sub_eq_add_neg] at h
  linarith

/-- The size of `e` at a split prime. -/
private theorem size_e_split (c : Collision D xw p ε δ B) (w : SplitPlace F) :
    (WPlace.split w).size (toSAdele F (unitL (multiplier F c.b₂)) * c.a₂ -
      toSAdele F (unitL (multiplier F c.b₁)) * c.a₁) ≤
      max ((WPlace.split w).absAt (unitL (multiplier F c.b₁))) ((WPlace.split w).absAt (unitL (multiplier F c.b₂))) *
        max ((WPlace.split w).size c.a₁) ((WPlace.split w).size c.a₂) := by
  have h := size_add_le_max w (toSAdele F (unitL (multiplier F c.b₂)) * c.a₂)
    (-(toSAdele F (unitL (multiplier F c.b₁)) * c.a₁))
  rw [size_neg, size_toSAdele_mul, size_toSAdele_mul, ← sub_eq_add_neg] at h
  refine h.trans (max_le ?_ ?_)
  · exact mul_le_mul (le_max_right _ _) (le_max_right _ _) (size_nonneg _ _)
      ((absAt_nonneg _ _).trans (le_max_left _ _))
  · exact mul_le_mul (le_max_left _ _) (le_max_left _ _) (size_nonneg _ _)
      ((absAt_nonneg _ _).trans (le_max_left _ _))

/-- `|ℓ|_v ≤ 2` at an archimedean place. -/
private theorem absAt_ℓ_arch (c : Collision D xw p ε δ B) (v : InfinitePlace (fieldI F)) :
    (WPlace.arch v).absAt c.ℓ ≤ 2 := by
  have h := size_add_le (WPlace.arch v) (toSAdele F (unitL (multiplier F c.b₁)))
    (-(toSAdele F (unitL (multiplier F c.b₂))))
  rw [size_neg, ← sub_eq_add_neg, ← map_sub, size_toSAdele, size_toSAdele, size_toSAdele, absAt_multiplier_arch,
    absAt_multiplier_arch] at h
  have hℓ : c.ℓ = unitL (multiplier F c.b₁) - unitL (multiplier F c.b₂) := rfl
  rw [hℓ]
  linarith

/-- `|ℓ|_w ≤ max(|v₁|_w, |v₂|_w)` at a split prime. -/
private theorem absAt_ℓ_split (c : Collision D xw p ε δ B) (w : SplitPlace F) :
    (WPlace.split w).absAt c.ℓ ≤
      max ((WPlace.split w).absAt (unitL (multiplier F c.b₁))) ((WPlace.split w).absAt (unitL (multiplier F c.b₂))) := by
  have h := size_add_le_max w (toSAdele F (unitL (multiplier F c.b₁))) (-(toSAdele F (unitL (multiplier F c.b₂))))
  rw [size_neg, ← sub_eq_add_neg, ← map_sub, size_toSAdele, size_toSAdele, size_toSAdele] at h
  exact h

omit [NumberField F] in
private theorem max_le_mul_max (a b : ℝ) : max a b ≤ max 1 a * max 1 b :=
  max_le ((le_max_right 1 a).trans (le_mul_of_one_le_right (zero_le_one.trans (le_max_left _ _)) (le_max_left _ _)))
    ((le_max_right 1 b).trans (le_mul_of_one_le_left (zero_le_one.trans (le_max_left _ _)) (le_max_left _ _)))

/-- A multiplier of index at most `B'` has split height at most `M(B')`. -/
private theorem splitHeight_le_scaleHeight {b B' : ℕ} (hb : b ∈ Finset.Icc 1 B') :
    splitHeight (unitL (multiplier F b)) ≤ scaleHeight F B' := by
  obtain ⟨h1, h2⟩ := Finset.mem_Icc.1 hb
  refine (splitHeight_multiplier_le F b).trans (pow_le_pow_left₀ (by positivity) ?_ _)
  have h3 : (1 : ℝ) ≤ b := by exact_mod_cast h1
  have h4 : (b : ℝ) ≤ B' := by exact_mod_cast h2
  linarith

omit [NumberField F] in
/-- One factor of a product of nonnegative reals kept, the others bounded. -/
private theorem prod_le_mul_prod_erase {ι : Type*} [DecidableEq ι] {s : Finset ι} {i₀ : ι} (hi₀ : i₀ ∈ s)
    {f g : ι → ℝ} (hf0 : ∀ i ∈ s, 0 ≤ f i) (hfg : ∀ i ∈ s, i ≠ i₀ → f i ≤ g i) :
    ∏ i ∈ s, f i ≤ f i₀ * ∏ i ∈ s.erase i₀, g i := by
  rw [← Finset.mul_prod_erase s f hi₀]
  exact mul_le_mul_of_nonneg_left (Finset.prod_le_prod (fun i hi => hf0 i (Finset.mem_of_mem_erase hi))
    fun i hi => hfg i (Finset.mem_of_mem_erase hi) (Finset.ne_of_mem_erase hi)) (hf0 i₀ hi₀)

/-- **Step 4: two scales give one point** (X01D § 3.5): collisions at the scales `B` and `3B²` with the thinness `δ(·)` have
the same point, once `8M(B)^{−10}` is below the gap `C` and `16ε ≤ 1`. -/
theorem point_eq {C : ℝ} (hC : D.IsGap C) (hε16 : 16 * ε ≤ 1)
    (hBC : 8 * (scaleHeight F B)⁻¹ ^ 10 < C)
    (c₁ : Collision D xw p ε (scaleThin F B) B) (c₂ : Collision D xw p ε (scaleThin F (3 * B ^ 2)) (3 * B ^ 2)) :
    c₁.point = c₂.point := by
  classical
  have hB1 : 1 ≤ B := (Finset.mem_Icc.1 c₁.mem₁).1.trans (Finset.mem_Icc.1 c₁.mem₁).2
  have hn : 0 < Module.finrank ℚ (fieldI F) := Module.finrank_pos
  have hM3 : (3 : ℝ) ≤ scaleHeight F B := by
    have h3B : (3 : ℝ) ≤ 3 * (B : ℝ) := by
      have : (1 : ℝ) ≤ B := by exact_mod_cast hB1
      linarith
    exact h3B.trans (le_self_pow₀ (by linarith) hn.ne')
  set M := scaleHeight F B with hM
  have hM0 : 0 < M := by linarith
  have hδ : scaleThin F B = M⁻¹ ^ 16 := rfl
  have hδ' : scaleThin F (3 * B ^ 2) ≤ scaleThin F B := by
    rw [hδ, scaleThin, scaleHeight_three_mul_sq, ← hM]
    exact pow_le_pow_left₀ (by positivity) (inv_anti₀ hM0 (le_self_pow₀ (by linarith) two_ne_zero)) _
  have hδ0 : 0 ≤ scaleThin F B := by rw [hδ]; positivity
  have h8δ : 8 * scaleThin F B ≤ 1 := by
    rw [hδ]
    have h1 : M⁻¹ ≤ 1 / 3 := by rw [one_div]; exact inv_anti₀ (by norm_num) hM3
    have h2 : M⁻¹ ^ 16 ≤ (1 / 3) ^ 16 := pow_le_pow_left₀ (by positivity) h1 _
    have h3 : (8 : ℝ) * (1 / 3) ^ 16 ≤ 1 := by norm_num
    nlinarith
  -- the lattice point `z = ℓ₂y₁ − ℓ₁y₂ = ℓ₁e₂ − ℓ₂e₁`
  set z := c₂.ℓ * c₁.y - c₁.ℓ * c₂.y with hzdef
  have hzΛ : z ∈ D.Λ := D.Λ.sub_mem (c₂.ℓ_eq_ofUnitRing ▸ D.mul_mem_Λ _ c₁.mem_Λ)
    (c₁.ℓ_eq_ofUnitRing ▸ D.mul_mem_Λ _ c₂.mem_Λ)
  have hz : toSAdele F z = toSAdele F c₁.ℓ * (toSAdele F (unitL (multiplier F c₂.b₂)) * c₂.a₂ -
      toSAdele F (unitL (multiplier F c₂.b₁)) * c₂.a₁) - toSAdele F c₂.ℓ *
      (toSAdele F (unitL (multiplier F c₁.b₂)) * c₁.a₂ - toSAdele F (unitL (multiplier F c₁.b₁)) * c₁.a₁) := by
    rw [e_eq c₁, e_eq c₂, hzdef, map_sub, map_mul, map_mul]
    ring
  -- archimedean sizes: `≤ 2(|a₁₂| + |a₂₂|) + 2(|a₁₁| + |a₂₁|)`
  have hzarch : ∀ v : InfinitePlace (fieldI F), v z ≤ 2 * ((WPlace.arch v).size c₂.a₁ + (WPlace.arch v).size c₂.a₂) +
      2 * ((WPlace.arch v).size c₁.a₁ + (WPlace.arch v).size c₁.a₂) := fun v => by
    have h := size_add_le (WPlace.arch v) (toSAdele F c₁.ℓ * (toSAdele F (unitL (multiplier F c₂.b₂)) * c₂.a₂ -
      toSAdele F (unitL (multiplier F c₂.b₁)) * c₂.a₁)) (-(toSAdele F c₂.ℓ *
      (toSAdele F (unitL (multiplier F c₁.b₂)) * c₁.a₂ - toSAdele F (unitL (multiplier F c₁.b₁)) * c₁.a₁)))
    rw [size_neg, ← sub_eq_add_neg, ← hz, size_toSAdele, size_toSAdele_mul, size_toSAdele_mul] at h
    have h1 := mul_le_mul (c₁.absAt_ℓ_arch v) (c₂.size_e_arch v) (size_nonneg _ _) zero_le_two
    have h2 := mul_le_mul (c₂.absAt_ℓ_arch v) (c₁.size_e_arch v) (size_nonneg _ _) zero_le_two
    have h3 : (WPlace.arch v).absAt z ≤ _ := h.trans (add_le_add h1 h2)
    exact h3
  -- split sizes: `≤ M₁M₂·max(σ₁, σ₂)`
  have hzsplit : ∀ w : SplitPlace F, (WPlace.split w).absAt z ≤
      (max 1 ((WPlace.split w).absAt (unitL (multiplier F c₁.b₁))) *
        max 1 ((WPlace.split w).absAt (unitL (multiplier F c₁.b₂)))) *
      (max 1 ((WPlace.split w).absAt (unitL (multiplier F c₂.b₁))) *
        max 1 ((WPlace.split w).absAt (unitL (multiplier F c₂.b₂)))) *
      max (max ((WPlace.split w).size c₁.a₁) ((WPlace.split w).size c₁.a₂))
        (max ((WPlace.split w).size c₂.a₁) ((WPlace.split w).size c₂.a₂)) := fun w => by
    have h := size_add_le_max w (toSAdele F c₁.ℓ * (toSAdele F (unitL (multiplier F c₂.b₂)) * c₂.a₂ -
      toSAdele F (unitL (multiplier F c₂.b₁)) * c₂.a₁)) (-(toSAdele F c₂.ℓ *
      (toSAdele F (unitL (multiplier F c₁.b₂)) * c₁.a₂ - toSAdele F (unitL (multiplier F c₁.b₁)) * c₁.a₁)))
    rw [size_neg, ← sub_eq_add_neg, ← hz, size_toSAdele, size_toSAdele_mul, size_toSAdele_mul] at h
    refine h.trans (max_le ?_ ?_)
    · refine (mul_le_mul ((c₁.absAt_ℓ_split w).trans (max_le_mul_max _ _)) ((c₂.size_e_split w).trans
        (mul_le_mul_of_nonneg_right (max_le_mul_max _ _) (le_max_of_le_left (size_nonneg _ _))))
        (size_nonneg _ _) (by positivity)).trans ?_
      rw [← mul_assoc]
      exact mul_le_mul_of_nonneg_left (le_max_right _ _) (by positivity)
    · refine (mul_le_mul ((c₂.absAt_ℓ_split w).trans (max_le_mul_max _ _)) ((c₁.size_e_split w).trans
        (mul_le_mul_of_nonneg_right (max_le_mul_max _ _) (le_max_of_le_left (size_nonneg _ _))))
        (size_nonneg _ _) (by positivity)).trans ?_
      rw [← mul_assoc, mul_comm (max 1 _ * max 1 _) (max 1 _ * max 1 _)]
      exact mul_le_mul_of_nonneg_left (le_max_left _ _) (by positivity)
  -- the box bounds
  have harchA : ∀ v : InfinitePlace (fieldI F), (WPlace.arch v).size c₁.a₁ ≤ 2 * ε ∧
      (WPlace.arch v).size c₁.a₂ ≤ 2 * ε ∧ (WPlace.arch v).size c₂.a₁ ≤ 2 * ε ∧
      (WPlace.arch v).size c₂.a₂ ≤ 2 * ε := fun v =>
    ⟨c₁.box₁.1.1 v, c₁.box₂.1.1 v, c₂.box₁.1.1 v, c₂.box₂.1.1 v⟩
  have hsplitA : ∀ w : SplitPlace F, max (max ((WPlace.split w).size c₁.a₁) ((WPlace.split w).size c₁.a₂))
      (max ((WPlace.split w).size c₂.a₁) ((WPlace.split w).size c₂.a₂)) ≤ 1 := fun w =>
    max_le (max_le ((size_le_one_iff w _).2 (c₁.box₁.1.2 w)) ((size_le_one_iff w _).2 (c₁.box₂.1.2 w)))
      (max_le ((size_le_one_iff w _).2 (c₂.box₁.1.2 w)) ((size_le_one_iff w _).2 (c₂.box₂.1.2 w)))
  -- the supports of the four multipliers
  obtain ⟨T₁, hT₁⟩ := exists_finset_absAt_le_one (unitL (multiplier F c₁.b₁))
  obtain ⟨T₂, hT₂⟩ := exists_finset_absAt_le_one (unitL (multiplier F c₁.b₂))
  obtain ⟨T₃, hT₃⟩ := exists_finset_absAt_le_one (unitL (multiplier F c₂.b₁))
  obtain ⟨T₄, hT₄⟩ := exists_finset_absAt_le_one (unitL (multiplier F c₂.b₂))
  -- `∏_T H ≤ M²M(3B²)² = M⁶` for every `T` holding the supports
  have hH : ∀ T : Finset (SplitPlace F), T₁ ∪ T₂ ∪ T₃ ∪ T₄ ⊆ T →
      ∏ w ∈ T, ((max 1 ((WPlace.split w).absAt (unitL (multiplier F c₁.b₁))) *
        max 1 ((WPlace.split w).absAt (unitL (multiplier F c₁.b₂)))) *
      (max 1 ((WPlace.split w).absAt (unitL (multiplier F c₂.b₁))) *
        max 1 ((WPlace.split w).absAt (unitL (multiplier F c₂.b₂))))) ≤ M ^ 6 := fun T hT => by
    have hs : ∀ (g : fieldI F) (Tg : Finset (SplitPlace F)), Tg ⊆ T → (∀ w ∉ Tg, (WPlace.split w).absAt g ≤ 1) →
        ∏ w ∈ T, max 1 ((WPlace.split w).absAt g) = splitHeight g := fun g Tg hTg hg =>
      (splitHeight_eq_prod g T fun w hw => hg w fun h => hw (hTg h)).symm
    rw [Finset.prod_mul_distrib, Finset.prod_mul_distrib, Finset.prod_mul_distrib,
      hs _ T₁ (fun _ h => hT (by simp [h])) hT₁, hs _ T₂ (fun _ h => hT (by simp [h])) hT₂,
      hs _ T₃ (fun _ h => hT (by simp [h])) hT₃, hs _ T₄ (fun _ h => hT (by simp [h])) hT₄]
    have h1 := splitHeight_le_scaleHeight (F := F) c₁.mem₁
    have h2 := splitHeight_le_scaleHeight (F := F) c₁.mem₂
    have h3 := splitHeight_le_scaleHeight (F := F) c₂.mem₁
    have h4 := splitHeight_le_scaleHeight (F := F) c₂.mem₂
    rw [scaleHeight_three_mul_sq, ← hM] at h3 h4
    have e1 := zero_le_one.trans (one_le_splitHeight (unitL (multiplier F c₁.b₁)))
    have e2 := zero_le_one.trans (one_le_splitHeight (unitL (multiplier F c₁.b₂)))
    have e3 := zero_le_one.trans (one_le_splitHeight (unitL (multiplier F c₂.b₁)))
    calc _ ≤ M * M * (M ^ 2 * M ^ 2) := mul_le_mul (mul_le_mul h1 h2 e2 hM0.le) (mul_le_mul h3 h4
          (zero_le_one.trans (one_le_splitHeight _)) (by positivity)) (mul_nonneg e3 (zero_le_one.trans
          (one_le_splitHeight _))) (by positivity)
      _ = M ^ 6 := by ring
  have h8M : 8 * scaleThin F B * M ^ 6 = 8 * M⁻¹ ^ 10 := by
    rw [hδ]; field_simp
  have hzT : ∀ T : Finset (SplitPlace F), T₁ ∪ T₂ ∪ T₃ ∪ T₄ ⊆ T → ∀ w ∉ T, (WPlace.split w).absAt z ≤ 1 :=
    fun T hT w hw => by
      have hw' : ∀ (g : fieldI F) (Tg : Finset (SplitPlace F)), Tg ⊆ T →
          (∀ w ∉ Tg, (WPlace.split w).absAt g ≤ 1) → max 1 ((WPlace.split w).absAt g) = 1 := fun g Tg hTg hg =>
        max_eq_left (hg w fun h => hw (hTg h))
      have := hzsplit w
      rw [hw' _ T₁ (fun _ h => hT (by simp [h])) hT₁, hw' _ T₂ (fun _ h => hT (by simp [h])) hT₂,
        hw' _ T₃ (fun _ h => hT (by simp [h])) hT₃, hw' _ T₄ (fun _ h => hT (by simp [h])) hT₄] at this
      linarith [hsplitA w]
  have hz0 : z = 0 := by
    cases p with
    | arch v₀ =>
      -- the archimedean product is `≤ 8δ`, the split one `≤ M⁶`
      let T := T₁ ∪ T₂ ∪ T₃ ∪ T₄
      refine hC z hzΛ T (hzT T le_rfl) ?_
      have hA : ∏ v : InfinitePlace (fieldI F), v z ^ v.mult ≤ 8 * scaleThin F B := by
        refine (prod_le_mul_prod_erase (Finset.mem_univ v₀) (g := fun _ => 1)
          (fun v _ => pow_nonneg (apply_nonneg v z) _) fun v _ hv => ?_).trans ?_
        · obtain ⟨a1, a2, a3, a4⟩ := harchA v
          exact pow_le_one₀ (apply_nonneg v z) (by linarith [hzarch v])
        · rw [Finset.prod_const_one, mul_one]
          have hzv : v₀ z ≤ 8 * scaleThin F B := by
            have := hzarch v₀
            have b1 : (WPlace.arch v₀).size c₁.a₁ ≤ scaleThin F B := c₁.box₁.2
            have b2 : (WPlace.arch v₀).size c₁.a₂ ≤ scaleThin F B := c₁.box₂.2
            have b3 : (WPlace.arch v₀).size c₂.a₁ ≤ scaleThin F B := c₂.box₁.2.trans hδ'
            have b4 : (WPlace.arch v₀).size c₂.a₂ ≤ scaleThin F B := c₂.box₂.2.trans hδ'
            linarith
          exact (pow_le_pow_left₀ (apply_nonneg v₀ z) hzv _).trans
            (pow_le_of_le_one (by positivity) h8δ InfinitePlace.mult_ne_zero)
      have hS : ∏ w ∈ T, (WPlace.split w).absAt z ≤ M ^ 6 :=
        (Finset.prod_le_prod (fun w _ => absAt_nonneg _ _) fun w _ =>
          (hzsplit w).trans (mul_le_of_le_one_right (by positivity) (hsplitA w))).trans (hH T le_rfl)
      calc (∏ v : InfinitePlace (fieldI F), v z ^ v.mult) * ∏ w ∈ T, (WPlace.split w).absAt z
          ≤ 8 * scaleThin F B * M ^ 6 :=
            mul_le_mul hA hS (Finset.prod_nonneg fun w _ => absAt_nonneg _ _) (by positivity)
        _ = 8 * M⁻¹ ^ 10 := h8M
        _ < C := hBC
    | split w₀ =>
      -- the archimedean product is `≤ 1`, the split one `≤ M⁶·δ`
      let T := insert w₀ (T₁ ∪ T₂ ∪ T₃ ∪ T₄)
      have hTsub : T₁ ∪ T₂ ∪ T₃ ∪ T₄ ⊆ T := Finset.subset_insert _ _
      refine hC z hzΛ T (hzT T hTsub) ?_
      have hA : ∏ v : InfinitePlace (fieldI F), v z ^ v.mult ≤ 1 :=
        Finset.prod_le_one (fun v _ => pow_nonneg (apply_nonneg v z) _) fun v _ => by
          obtain ⟨a1, a2, a3, a4⟩ := harchA v
          exact pow_le_one₀ (apply_nonneg v z) (by linarith [hzarch v])
      have hpw : max (max ((WPlace.split w₀).size c₁.a₁) ((WPlace.split w₀).size c₁.a₂))
          (max ((WPlace.split w₀).size c₂.a₁) ((WPlace.split w₀).size c₂.a₂)) ≤ scaleThin F B :=
        max_le (max_le c₁.box₁.2 c₁.box₂.2) (max_le (c₂.box₁.2.trans hδ') (c₂.box₂.2.trans hδ'))
      have hS : ∏ w ∈ T, (WPlace.split w).absAt z ≤ M ^ 6 * scaleThin F B := by
        refine (prod_le_mul_prod_erase (Finset.mem_insert_self w₀ _)
          (g := fun w => (max 1 ((WPlace.split w).absAt (unitL (multiplier F c₁.b₁))) *
            max 1 ((WPlace.split w).absAt (unitL (multiplier F c₁.b₂)))) *
          (max 1 ((WPlace.split w).absAt (unitL (multiplier F c₂.b₁))) *
            max 1 ((WPlace.split w).absAt (unitL (multiplier F c₂.b₂)))))
          (fun w _ => absAt_nonneg _ _) fun w _ _ =>
            (hzsplit w).trans (mul_le_of_le_one_right (by positivity) (hsplitA w))).trans ?_
        have hw0 := (hzsplit w₀).trans (mul_le_mul_of_nonneg_left hpw (by positivity))
        have hHT := hH T hTsub
        rw [← Finset.mul_prod_erase T _ (Finset.mem_insert_self w₀ _)] at hHT
        have hE : 0 ≤ ∏ w ∈ T.erase w₀, (max 1 ((WPlace.split w).absAt (unitL (multiplier F c₁.b₁))) *
            max 1 ((WPlace.split w).absAt (unitL (multiplier F c₁.b₂)))) *
          (max 1 ((WPlace.split w).absAt (unitL (multiplier F c₂.b₁))) *
            max 1 ((WPlace.split w).absAt (unitL (multiplier F c₂.b₂)))) :=
          Finset.prod_nonneg fun w _ => by positivity
        calc (WPlace.split w₀).absAt z * _ ≤ (_ * scaleThin F B) * _ := mul_le_mul_of_nonneg_right hw0 hE
          _ = (_ * _) * scaleThin F B := by ring
          _ ≤ M ^ 6 * scaleThin F B := mul_le_mul_of_nonneg_right hHT hδ0
      calc (∏ v : InfinitePlace (fieldI F), v z ^ v.mult) * ∏ w ∈ T, (WPlace.split w).absAt z
          ≤ 1 * (M ^ 6 * scaleThin F B) :=
            mul_le_mul hA hS (Finset.prod_nonneg fun w _ => absAt_nonneg _ _) zero_le_one
        _ ≤ 8 * scaleThin F B * M ^ 6 := by nlinarith [pow_pos hM0 6]
        _ = 8 * M⁻¹ ^ 10 := h8M
        _ < C := hBC
  -- `z = 0` is `y₁/ℓ₁ = y₂/ℓ₂`
  rw [Collision.point, Collision.point, div_eq_div_iff c₁.ℓ_ne_zero c₂.ℓ_ne_zero]
  linear_combination hz0

/-- **Step 5: the point is global at `p`, up to the scale** (X01D § 3.6): `|x̃ − t|_p ≤ 2^{[L:ℚ]+2}·M(B)³·δ`. -/
theorem size_sub_point_le (c : Collision D xw p ε δ B) :
    p.size (xw - toSAdele F c.point) ≤ 2 ^ (Module.finrank ℚ (fieldI F) + 2) * scaleHeight F B ^ 3 * δ := by
  classical
  have hB1 : 1 ≤ B := (Finset.mem_Icc.1 c.mem₁).1.trans (Finset.mem_Icc.1 c.mem₁).2
  have hn : 0 < Module.finrank ℚ (fieldI F) := Module.finrank_pos
  set M := scaleHeight F B with hM
  have hM1 : (1 : ℝ) ≤ M := by
    have h3B : (1 : ℝ) ≤ 3 * (B : ℝ) := by
      have : (1 : ℝ) ≤ B := by exact_mod_cast hB1
      linarith
    exact h3B.trans (le_self_pow₀ h3B hn.ne')
  have hδ0 : 0 ≤ δ := (size_nonneg p c.a₁).trans c.box₁.2
  have hℓ0 := c.ℓ_ne_zero
  have hℓO : c.ℓ ∈ stableIntegers F := c.ℓ_eq_ofUnitRing ▸ ofUnitRing_mem_stableIntegers _
  have hsz : p.absAt c.ℓ * p.size (xw - toSAdele F c.point) =
      p.size (toSAdele F (unitL (multiplier F c.b₂)) * c.a₂ - toSAdele F (unitL (multiplier F c.b₁)) * c.a₁) := by
    rw [← size_toSAdele_mul, ← c.mul_sub_point]
  obtain ⟨T₁, hT₁⟩ := exists_finset_absAt_le_one (unitL (multiplier F c.b₁))
  obtain ⟨T₂, hT₂⟩ := exists_finset_absAt_le_one (unitL (multiplier F c.b₂))
  have h1 := splitHeight_le_scaleHeight (F := F) c.mem₁
  have h2 := splitHeight_le_scaleHeight (F := F) c.mem₂
  -- `∏_T |ℓ|_w ≤ |ℓ|_{w₀}·M²` and the like: the split factors are at most `max(1,|v₁|)·max(1,|v₂|)`
  have hH : ∀ T : Finset (SplitPlace F), T₁ ∪ T₂ ⊆ T →
      ∏ w ∈ T, (max 1 ((WPlace.split w).absAt (unitL (multiplier F c.b₁))) *
        max 1 ((WPlace.split w).absAt (unitL (multiplier F c.b₂)))) ≤ M ^ 2 := fun T hT => by
    rw [Finset.prod_mul_distrib,
      ← splitHeight_eq_prod _ T fun w hw => hT₁ w fun h => hw (hT (Finset.mem_union_left _ h)),
      ← splitHeight_eq_prod _ T fun w hw => hT₂ w fun h => hw (hT (Finset.mem_union_right _ h)), sq]
    exact mul_le_mul h1 h2 (zero_le_one.trans (one_le_splitHeight _)) (by linarith)
  have hℓw : ∀ w : SplitPlace F, (WPlace.split w).absAt c.ℓ ≤
      max 1 ((WPlace.split w).absAt (unitL (multiplier F c.b₁))) *
        max 1 ((WPlace.split w).absAt (unitL (multiplier F c.b₂))) := fun w =>
    (c.absAt_ℓ_split w).trans (max_le_mul_max _ _)
  have hℓT : ∀ T : Finset (SplitPlace F), T₁ ∪ T₂ ⊆ T → ∀ w ∉ T, (WPlace.split w).absAt c.ℓ ≤ 1 :=
    fun T hT w hw => (c.absAt_ℓ_split w).trans (max_le (hT₁ w fun h => hw (hT (Finset.mem_union_left _ h)))
      (hT₂ w fun h => hw (hT (Finset.mem_union_right _ h))))
  have hA2 : ∀ v : InfinitePlace (fieldI F), v c.ℓ ^ v.mult ≤ 2 ^ v.mult := fun v =>
    pow_le_pow_left₀ (apply_nonneg v _) (c.absAt_ℓ_arch v) _
  have hprod2 : ∏ v : InfinitePlace (fieldI F), (2 : ℝ) ^ v.mult = 2 ^ Module.finrank ℚ (fieldI F) := by
    rw [Finset.prod_pow_eq_pow_sum, InfinitePlace.sum_mult_eq]
  -- (a) the lower bound `1 ≤ |ℓ|_p · 2^{[L:ℚ]+1} M²`, and (b) `|e|_p ≤ 2Mδ`
  have hkey : 1 ≤ p.absAt c.ℓ * (2 ^ (Module.finrank ℚ (fieldI F) + 1) * M ^ 2) ∧
      p.size (toSAdele F (unitL (multiplier F c.b₂)) * c.a₂ - toSAdele F (unitL (multiplier F c.b₁)) * c.a₁) ≤
        2 * M * δ := by
    cases p with
    | arch v₀ =>
      refine ⟨?_, ?_⟩
      · let T := T₁ ∪ T₂
        have hPF := one_le_prod_absAt_of_mem_stableIntegers hℓO hℓ0 T (hℓT T le_rfl)
        have hA : ∏ v : InfinitePlace (fieldI F), v c.ℓ ^ v.mult ≤
            v₀ c.ℓ * 2 ^ Module.finrank ℚ (fieldI F) := by
          refine (prod_le_mul_prod_erase (Finset.mem_univ v₀) (g := fun v => (2 : ℝ) ^ v.mult)
            (fun v _ => pow_nonneg (apply_nonneg v _) _) fun v _ _ => hA2 v).trans ?_
          obtain ⟨k, hk⟩ : ∃ k, v₀.mult = k + 1 := ⟨v₀.mult - 1, by have := v₀.mult_pos; omega⟩
          have hx : v₀ c.ℓ ^ v₀.mult ≤ v₀ c.ℓ * 2 ^ v₀.mult := by
            rw [hk, pow_succ, mul_comm, pow_succ]
            have := pow_le_pow_left₀ (apply_nonneg v₀ c.ℓ) (c.absAt_ℓ_arch v₀) k
            nlinarith [apply_nonneg v₀ c.ℓ, pow_nonneg (apply_nonneg v₀ c.ℓ) k]
          rw [← hprod2, ← Finset.mul_prod_erase _ (fun v : InfinitePlace (fieldI F) => (2 : ℝ) ^ v.mult)
            (Finset.mem_univ v₀), ← mul_assoc]
          exact mul_le_mul_of_nonneg_right hx (Finset.prod_nonneg fun v _ => by positivity)
        have hS : ∏ w ∈ T, (WPlace.split w).absAt c.ℓ ≤ M ^ 2 :=
          (Finset.prod_le_prod (fun w _ => absAt_nonneg _ _) fun w _ => hℓw w).trans (hH T le_rfl)
        have hP := hPF.trans (mul_le_mul hA hS (Finset.prod_nonneg fun w _ => absAt_nonneg _ _) (by positivity))
        have h2n : (2 : ℝ) ^ Module.finrank ℚ (fieldI F) ≤ 2 ^ (Module.finrank ℚ (fieldI F) + 1) :=
          pow_le_pow_right₀ (by norm_num) (Nat.le_succ _)
        have hv0 : 0 ≤ v₀ c.ℓ := apply_nonneg v₀ _
        calc (1 : ℝ) ≤ v₀ c.ℓ * 2 ^ Module.finrank ℚ (fieldI F) * M ^ 2 := hP
          _ ≤ v₀ c.ℓ * 2 ^ (Module.finrank ℚ (fieldI F) + 1) * M ^ 2 := by gcongr
          _ = _ := by show _ = v₀ c.ℓ * _; ring
      · have h := c.size_e_arch v₀
        have := c.box₁.2
        have := c.box₂.2
        nlinarith
    | split w₀ =>
      refine ⟨?_, ?_⟩
      · let T := insert w₀ (T₁ ∪ T₂)
        have hTsub : T₁ ∪ T₂ ⊆ T := Finset.subset_insert _ _
        have hPF := one_le_prod_absAt_of_mem_stableIntegers hℓO hℓ0 T (hℓT T hTsub)
        have hA : ∏ v : InfinitePlace (fieldI F), v c.ℓ ^ v.mult ≤ 2 ^ Module.finrank ℚ (fieldI F) := by
          rw [← hprod2]
          exact Finset.prod_le_prod (fun v _ => pow_nonneg (apply_nonneg v _) _) fun v _ => hA2 v
        have hS : ∏ w ∈ T, (WPlace.split w).absAt c.ℓ ≤ (WPlace.split w₀).absAt c.ℓ * M ^ 2 := by
          refine (prod_le_mul_prod_erase (Finset.mem_insert_self w₀ _) (fun w _ => absAt_nonneg _ _)
            fun w _ _ => hℓw w).trans (mul_le_mul_of_nonneg_left ?_ (absAt_nonneg _ _))
          refine le_trans ?_ (hH T hTsub)
          rw [← Finset.mul_prod_erase T _ (Finset.mem_insert_self w₀ _)]
          exact le_mul_of_one_le_left (Finset.prod_nonneg fun w _ => by positivity)
            (one_le_mul_of_one_le_of_one_le (le_max_left _ _) (le_max_left _ _))
        have hP := hPF.trans (mul_le_mul hA hS (Finset.prod_nonneg fun w _ => absAt_nonneg _ _) (by positivity))
        have h2n : (2 : ℝ) ^ Module.finrank ℚ (fieldI F) ≤ 2 ^ (Module.finrank ℚ (fieldI F) + 1) :=
          pow_le_pow_right₀ (by norm_num) (Nat.le_succ _)
        have hw0 : 0 ≤ (WPlace.split w₀).absAt c.ℓ := absAt_nonneg _ _
        calc (1 : ℝ) ≤ 2 ^ Module.finrank ℚ (fieldI F) * ((WPlace.split w₀).absAt c.ℓ * M ^ 2) := hP
          _ ≤ 2 ^ (Module.finrank ℚ (fieldI F) + 1) * ((WPlace.split w₀).absAt c.ℓ * M ^ 2) := by gcongr
          _ = _ := by ring
      · have h := c.size_e_split w₀
        have hv : max ((WPlace.split w₀).absAt (unitL (multiplier F c.b₁)))
            ((WPlace.split w₀).absAt (unitL (multiplier F c.b₂))) ≤ M :=
          max_le ((absAt_le_splitHeight w₀ _).trans h1) ((absAt_le_splitHeight w₀ _).trans h2)
        have ha : max ((WPlace.split w₀).size c.a₁) ((WPlace.split w₀).size c.a₂) ≤ δ := max_le c.box₁.2 c.box₂.2
        calc _ ≤ _ := h
          _ ≤ M * δ := mul_le_mul hv ha (le_max_of_le_left (size_nonneg _ _)) (by linarith)
          _ ≤ 2 * M * δ := by nlinarith
  obtain ⟨hlow, he⟩ := hkey
  have hs0 := size_nonneg p (xw - toSAdele F c.point)
  calc p.size (xw - toSAdele F c.point)
      ≤ p.size (xw - toSAdele F c.point) * (p.absAt c.ℓ * (2 ^ (Module.finrank ℚ (fieldI F) + 1) * M ^ 2)) :=
        le_mul_of_one_le_right hs0 hlow
    _ = (p.absAt c.ℓ * p.size (xw - toSAdele F c.point)) * (2 ^ (Module.finrank ℚ (fieldI F) + 1) * M ^ 2) := by
        ring
    _ ≤ (2 * M * δ) * (2 ^ (Module.finrank ℚ (fieldI F) + 1) * M ^ 2) := by
        rw [hsz]; exact mul_le_mul_of_nonneg_right he (by positivity)
    _ = 2 ^ (Module.finrank ℚ (fieldI F) + 2) * M ^ 3 * δ := by ring

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
  classical
  set S := D.π '' ((xw + ·) '' closedThinBox p (2 * ε) δ) with hS
  have hSm : MeasurableSet S :=
    D.measurableSet_image ((Homeomorph.addLeft xw).isClosedMap _ (isClosed_closedThinBox p _ _))
  -- the `B` rotated copies `t b = (rot v_b)⁻¹ S`, each of measure `μ S`
  let t : ℕ → Set (Dual F) := fun b => rot (multiplier F b) ⁻¹' S
  have htm : ∀ b, MeasurableSet (t b) := fun b => measurable_rot _ hSm
  have htμ : ∀ b, μ (t b) = μ S := fun b => by
    rw [← Measure.map_apply (measurable_rot _) hSm, hμ]
  have hsum : μ Set.univ < ∑ b ∈ Finset.Icc 1 B, μ (t b) := by
    rw [Finset.sum_congr rfl fun b _ => htμ b, Finset.sum_const, Nat.card_Icc, Nat.add_sub_cancel, nsmul_eq_mul,
      measure_univ]
    by_contra hle
    push Not at hle
    have h1 := ENNReal.toReal_mono ENNReal.one_ne_top hle
    rw [ENNReal.toReal_mul, ENNReal.toReal_natCast, ENNReal.toReal_one] at h1
    exact absurd hB (not_lt.2 h1)
  obtain ⟨b, hb, b', hb', hne, χ, hχb, hχb'⟩ :=
    exists_nonempty_inter_of_measure_univ_lt_sum_measure μ (fun b _ => (htm b).nullMeasurableSet) hsum
  -- `rot v_b χ = π(x̃ + a_b)`, and `χ = π c`
  obtain ⟨_, ⟨a, ha, rfl⟩, hχa⟩ := hχb
  obtain ⟨_, ⟨a', ha', rfl⟩, hχa'⟩ := hχb'
  obtain ⟨c, rfl⟩ := D.surjective_π χ
  rw [← D.π_unit_mul] at hχa hχa'
  obtain ⟨l, hl, hla⟩ := (D.π_eq_π_iff _ _).1 hχa.symm
  obtain ⟨l', hl', hla'⟩ := (D.π_eq_π_iff _ _).1 hχa'.symm
  -- `v_{b'}(x̃ + a_b) − v_b(x̃ + a_{b'}) = ι(v_b l' − v_{b'} l)`
  refine ⟨⟨b', b, hb', hb, fun h => hne h.symm, a, a', ha, ha',
    unitL (multiplier F b) * l' - unitL (multiplier F b') * l,
    D.Λ.sub_mem ((unitL_eq_ofUnitRing _).symm ▸ D.mul_mem_Λ _ hl')
      ((unitL_eq_ofUnitRing _).symm ▸ D.mul_mem_Λ _ hl), ?_⟩⟩
  rw [map_sub, map_mul, map_mul]
  linear_combination toSAdele F (unitL (multiplier F b)) * hla' - toSAdele F (unitL (multiplier F b')) * hla

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
  classical
  have hn : 0 < Module.finrank ℚ (fieldI F) := Module.finrank_pos
  -- the scales' arithmetic: for `B ≥ 1`, `B ≤ M(B)`, so `δ(B) ≤ 1/B` and `8M(B)^{−10} ≤ 8/B`
  have hMB : ∀ B : ℕ, 1 ≤ B → (B : ℝ) ≤ scaleHeight F B := fun B hB => by
    have h1 : (1 : ℝ) ≤ B := by exact_mod_cast hB
    have h3 : (1 : ℝ) ≤ 3 * (B : ℝ) := by linarith
    exact (by linarith : (B : ℝ) ≤ 3 * B).trans (le_self_pow₀ h3 hn.ne')
  have hinv : ∀ B : ℕ, 1 ≤ B → (scaleHeight F B)⁻¹ ≤ 1 / (B : ℝ) := fun B hB => by
    have h1 : (0 : ℝ) < B := by exact_mod_cast hB
    rw [one_div]; exact inv_anti₀ h1 (hMB B hB)
  have hinv1 : ∀ B : ℕ, 1 ≤ B → (scaleHeight F B)⁻¹ ≤ 1 := fun B hB =>
    (hinv B hB).trans (by rw [div_le_one (by exact_mod_cast hB)]; exact_mod_cast hB)
  have hinv0 : ∀ B : ℕ, 0 ≤ (scaleHeight F B)⁻¹ := fun B => by unfold scaleHeight; positivity
  have hδB : ∀ B : ℕ, 1 ≤ B → scaleThin F B ≤ 1 / (B : ℝ) := fun B hB =>
    (pow_le_of_le_one (hinv0 B) (hinv1 B hB) (by norm_num)).trans (hinv B hB)
  have hCB : ∀ B : ℕ, 1 ≤ B → 8 * (scaleHeight F B)⁻¹ ^ 10 ≤ 8 / (B : ℝ) := fun B hB => by
    have h1 := (pow_le_of_le_one (hinv0 B) (hinv1 B hB) (by norm_num : (10 : ℕ) ≠ 0)).trans (hinv B hB)
    calc 8 * (scaleHeight F B)⁻¹ ^ 10 ≤ 8 * (1 / (B : ℝ)) := by linarith
      _ = 8 / (B : ℝ) := by ring
  -- a heavy thin box at scale `B ≥ 4` gives a collision: `B·δ(B)^β = B·(3B)^{−1/2} > 1`
  have hcol : ∀ B : ℕ, 4 ≤ B → scaleThin F B ≤ δ₀ → Nonempty (Collision D xw p ε (scaleThin F B) B) :=
    fun B hB hδ => by
      refine D.exists_collision μ hμ xw p ε _ B ?_
      have hB0 : (0 : ℝ) < B := by exact_mod_cast (by omega : 0 < B)
      have hB3 : (3 : ℝ) < B := by exact_mod_cast (by omega : 3 < B)
      have hδpos : 0 < scaleThin F B := by unfold scaleThin scaleHeight; positivity
      have hh := hheavy _ hδpos hδ
      have hsub : D.π '' ((xw + ·) '' thinBox p (2 * ε) (scaleThin F B)) ⊆
          D.π '' ((xw + ·) '' closedThinBox p (2 * ε) (scaleThin F B)) :=
        Set.image_mono (Set.image_mono (thinBox_subset_closedThinBox p _ _))
      have hmono := measureReal_mono (μ := μ) hsub
      -- `δ(B)^β = e^{−log(3B)/2}`
      have hlogδ : Real.log (scaleThin F B) * heavyExponent F = -(Real.log (3 * B) / 2) := by
        unfold scaleThin scaleHeight heavyExponent
        rw [Real.log_pow, Real.log_inv, Real.log_pow]
        have : (Module.finrank ℚ (fieldI F) : ℝ) ≠ 0 := Nat.cast_ne_zero.2 hn.ne'
        field_simp
        ring
      rw [Real.rpow_def_of_pos hδpos, hlogδ] at hh
      have hexp : 1 < (B : ℝ) * Real.exp (-(Real.log (3 * B) / 2)) := by
        have h3 : Real.log (3 * (B : ℝ)) = Real.log 3 + Real.log B := Real.log_mul (by norm_num) hB0.ne'
        have h4 : Real.log 3 < Real.log B := Real.log_lt_log (by norm_num) hB3
        have h5 : (B : ℝ) * Real.exp (-(Real.log (3 * B) / 2)) = Real.exp (Real.log B - Real.log (3 * B) / 2) := by
          rw [Real.exp_sub, Real.exp_log hB0, Real.exp_neg]
          exact (div_eq_mul_inv _ _).symm
        rw [h5, ← Real.exp_zero]
        exact Real.exp_lt_exp.2 (by linarith)
      calc (1 : ℝ) < B * Real.exp (-(Real.log (3 * B) / 2)) := hexp
        _ ≤ B * μ.real (D.π '' ((xw + ·) '' closedThinBox p (2 * ε) (scaleThin F B))) :=
          mul_le_mul_of_nonneg_left (hh.trans hmono) hB0.le
  -- the first scale `B₀`: `B₀ ≥ 4`, `1/B₀ ≤ δ₀`, `8/B₀ < C`
  set B₀ : ℕ := max 4 (⌈1 / δ₀⌉₊ + ⌈8 / C⌉₊ + 1) with hB₀
  have hB₀4 : 4 ≤ B₀ := le_max_left _ _
  have hB₀δ : 1 / (B₀ : ℝ) ≤ δ₀ := by
    have h1 : 1 / δ₀ ≤ (B₀ : ℝ) := (Nat.le_ceil _).trans (by
      have : ⌈1 / δ₀⌉₊ ≤ B₀ := (by omega : ⌈1 / δ₀⌉₊ ≤ ⌈1 / δ₀⌉₊ + ⌈8 / C⌉₊ + 1).trans (le_max_right _ _)
      exact_mod_cast this)
    have hB0 : (0 : ℝ) < B₀ := by exact_mod_cast (by omega : 0 < B₀)
    rw [div_le_iff₀ hB0]; rw [div_le_iff₀ hδ₀] at h1; linarith
  have hB₀C : 8 / (B₀ : ℝ) < C := by
    have h1 : 8 / C < (B₀ : ℝ) := (Nat.le_ceil _).trans_lt (by
      have : ⌈8 / C⌉₊ < B₀ := (by omega : ⌈8 / C⌉₊ < ⌈1 / δ₀⌉₊ + ⌈8 / C⌉₊ + 1).trans_le (le_max_right _ _)
      exact_mod_cast this)
    have hB0 : (0 : ℝ) < B₀ := by exact_mod_cast (by omega : 0 < B₀)
    rw [div_lt_iff₀ hB0]; rw [div_lt_iff₀ hC0] at h1; linarith
  -- the scales `B_{j+1} = 3B_j²`, all `≥ B₀ + j`
  let Bs : ℕ → ℕ := fun j => Nat.rec B₀ (fun _ b => 3 * b ^ 2) j
  have hBs : ∀ j, B₀ + j ≤ Bs j := fun j => by
    induction j with
    | zero => exact le_rfl
    | succ j ih =>
      show B₀ + (j + 1) ≤ 3 * Bs j ^ 2
      nlinarith
  have hBs4 : ∀ j, 4 ≤ Bs j := fun j => hB₀4.trans ((Nat.le_add_right _ _).trans (hBs j))
  have hB₀pos : (0 : ℝ) < B₀ := by exact_mod_cast (show 0 < B₀ by omega)
  have hB₀le : ∀ j, (B₀ : ℝ) ≤ (Nat.cast (Bs j) : ℝ) := fun j => by
    have h := (Nat.le_add_right B₀ j).trans (hBs j)
    exact_mod_cast h
  have hBs1 : ∀ j, 1 ≤ Bs j := fun j => by have := hBs4 j; omega
  have hBsδ : ∀ j, scaleThin F (Bs j) ≤ δ₀ := fun j =>
    (hδB _ (hBs1 j)).trans ((one_div_le_one_div_of_le hB₀pos (hB₀le j)).trans hB₀δ)
  have hBsC : ∀ j, 8 * (scaleHeight F (Bs j))⁻¹ ^ 10 < C := fun j =>
    (hCB _ (hBs1 j)).trans_lt ((div_le_div_of_nonneg_left (by norm_num) hB₀pos (hB₀le j)).trans_lt hB₀C)
  let col : ∀ j, Collision D xw p ε (scaleThin F (Bs j)) (Bs j) := fun j => (hcol _ (hBs4 j) (hBsδ j)).some
  -- consecutive points agree, so all are the point at scale `0`
  have hpt : ∀ j, (col j).point = (col 0).point := fun j => by
    induction j with
    | zero => rfl
    | succ j ih => exact ((Collision.point_eq hC hε16 (hBsC j) (col j) (col (j + 1))).symm).trans ih
  refine ⟨(col 0).point, ?_⟩
  -- `|x̃ − t|_p ≤ 2^{[L:ℚ]+2}·M(B_j)^{−13} ≤ 2^{[L:ℚ]+2}/B_j` for every `j`
  have hbound : ∀ j, p.size (xw - toSAdele F (col 0).point) ≤ 2 ^ (Module.finrank ℚ (fieldI F) + 2) / (Nat.cast (Bs j) : ℝ) :=
    fun j => by
      have h := (col j).size_sub_point_le
      rw [hpt j] at h
      have hB1 : 1 ≤ Bs j := by linarith [hBs4 j]
      have hM : 0 < scaleHeight F (Bs j) := by unfold scaleHeight; have := hBs4 j; positivity
      have h13 : scaleHeight F (Bs j) ^ 3 * scaleThin F (Bs j) ≤ 1 / (Nat.cast (Bs j) : ℝ) := by
        unfold scaleThin
        rw [inv_pow, ← div_eq_mul_inv, div_le_iff₀ (pow_pos hM 16)]
        have hM1 : 1 ≤ scaleHeight F (Bs j) := (by exact_mod_cast hB1 : (1 : ℝ) ≤ Bs j).trans (hMB _ hB1)
        have hBpos : (0 : ℝ) < Bs j := by exact_mod_cast (by omega : 0 < Bs j)
        rw [one_div_mul_eq_div, le_div_iff₀ hBpos]
        calc scaleHeight F (Bs j) ^ 3 * (Nat.cast (Bs j) : ℝ) ≤ scaleHeight F (Bs j) ^ 3 * scaleHeight F (Bs j) :=
              mul_le_mul_of_nonneg_left (hMB _ hB1) (by positivity)
          _ = scaleHeight F (Bs j) ^ 4 := by ring
          _ ≤ scaleHeight F (Bs j) ^ 16 := pow_le_pow_right₀ hM1 (by norm_num)
      calc _ ≤ 2 ^ (Module.finrank ℚ (fieldI F) + 2) * scaleHeight F (Bs j) ^ 3 * scaleThin F (Bs j) := h
        _ ≤ 2 ^ (Module.finrank ℚ (fieldI F) + 2) * (1 / (Nat.cast (Bs j) : ℝ)) := by
            rw [mul_assoc]; exact mul_le_mul_of_nonneg_left h13 (by positivity)
        _ = _ := by ring
  show p.size _ = 0
  refine le_antisymm (le_of_forall_pos_le_add fun η hη => ?_) (size_nonneg _ _)
  -- `B_j ≥ j` is unbounded
  obtain ⟨j, hj⟩ := exists_nat_gt (2 ^ (Module.finrank ℚ (fieldI F) + 2) / η)
  have hBj : (j : ℝ) ≤ (Nat.cast (Bs j) : ℝ) := by
    have h := (Nat.le_add_left j B₀).trans (hBs j)
    exact_mod_cast h
  have hBpos : (0 : ℝ) < (Nat.cast (Bs j) : ℝ) := by
    have h : 0 < Bs j := by have := hBs4 j; omega
    exact_mod_cast h
  have hlt : 2 ^ (Module.finrank ℚ (fieldI F) + 2) / (Nat.cast (Bs j) : ℝ) < η := by
    rw [div_lt_iff₀ hBpos]; rw [div_lt_iff₀ hη] at hj; nlinarith
  linarith [hbound j]

/-- **The leaf set `π(L + W_p)`** (X01D l. 286, `T + K_{v*}`). -/
def leafSet (p : WPlace F) : Set (Dual F) := D.π '' {a | ∃ t : fieldI F, a - toSAdele F t ∈ hyperplane p}

example (p : WPlace F) (χ : Dual F) :
    χ ∈ D.leafSet p ↔ ∃ a, (∃ t : fieldI F, a - toSAdele F t ∈ hyperplane p) ∧ D.π a = χ := Iff.rfl

/-- **The leaf set is Borel**: the countable union over `t ∈ L` of the images of the closed sets `ι(t) + W_p`
(`countable_fieldI`, `isClosed_hyperplane`, `measurableSet_image`). -/
theorem measurableSet_leafSet (p : WPlace F) : MeasurableSet (D.leafSet p) := by
  haveI : Countable (fieldI F) := countable_fieldI
  have he : {a : SAdeleRing F | ∃ t : fieldI F, a - toSAdele F t ∈ hyperplane p} =
      ⋃ t : fieldI F, (toSAdele F t + ·) '' hyperplane p := by
    ext a
    simp only [Set.mem_setOf_eq, Set.mem_iUnion, Set.mem_image]
    constructor
    · rintro ⟨t, ht⟩
      exact ⟨t, a - toSAdele F t, ht, add_sub_cancel _ _⟩
    · rintro ⟨t, h, hh, rfl⟩
      exact ⟨t, by rw [add_sub_cancel_left]; exact hh⟩
  rw [leafSet, he, Set.image_iUnion]
  exact MeasurableSet.iUnion fun t =>
    D.measurableSet_image ((Homeomorph.addLeft (toSAdele F t)).isClosedMap _ (isClosed_hyperplane p))

/-- **Zero entropy is carried by the leaf set** (X01D l. 286: "`μ(R̂ ∖ (T + K_{v*})) = 0`"): Lemma 3.1′ (`thinBox_heavy`) at
`β = heavyExponent F` and every `η > 0` gives `X′` of measure `> 1 − η` whose every point, through any lift
(`surjective_π`), has a global point (`exists_point_of_heavy`); so `μ(leafSet) ≥ 1 − η` for every `η`. -/
theorem measure_leafSet_compl_eq_zero (μ : Measure (Dual F)) [IsProbabilityMeasure μ] (hμ : RotInv F μ)
    {u : unitVectors F} (h0 : ksEntropy μ (rot u) = 0) {p : WPlace F} (hp : 1 < p.absAt (unitL u))
    {C : ℝ} (hC0 : 0 < C) (hC : D.IsGap C) {ε : ℝ} (hε : 0 < ε) (hε16 : 16 * ε ≤ 1)
    (hεC : (∏ v : InfinitePlace (fieldI F), (2 * ε * (1 + v (unitL u))) ^ v.mult) * splitHeight (unitL u) < C) :
    μ (D.leafSet p)ᶜ = 0 := by
  have hm := D.measurableSet_leafSet p
  -- for every `η > 0`, `μ(leafSet) > 1 − η`
  have hη : ∀ η : ℝ, 0 < η → 1 - η < μ.real (D.leafSet p) := fun η hη => by
    obtain ⟨δ₀, hδ₀, X', -, hX', hheavy⟩ :=
      D.thinBox_heavy μ hμ h0 hp hC hε hεC (heavyExponent_pos F) hη
    have hsub : X' ⊆ D.leafSet p := fun x hx => by
      obtain ⟨xw, hxw⟩ := D.surjective_π x
      obtain ⟨t, ht⟩ := D.exists_point_of_heavy μ hμ hC0 hC hε16 hδ₀ (hheavy x hx xw hxw)
      exact ⟨xw, ⟨t, ht⟩, hxw⟩
    exact hX'.trans_le (measureReal_mono hsub)
  have h1 : μ.real (D.leafSet p) = 1 :=
    le_antisymm measureReal_le_one (le_of_forall_pos_lt_add fun η hη0 => by linarith [hη η hη0])
  have h2 : μ (D.leafSet p) = 1 := (ENNReal.toReal_eq_one_iff _).1 h1
  rw [prob_compl_eq_one_sub hm, h2, tsub_self]

end TateModel

end

end HadwigerNelson.Rigidity
