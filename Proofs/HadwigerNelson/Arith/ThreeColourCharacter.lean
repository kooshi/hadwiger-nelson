import Proofs.HadwigerNelson.ThreeColour
import Proofs.HadwigerNelson.Arith.CharacterColouring
import Mathlib.Analysis.LocallyConvex.Separation
import Mathlib.Topology.Algebra.Group.Compact

/-!
# Three colours give a character: the criterion's ⟹ in character form (FS-131, NF4; planner FS131-KN4)

**Read aloud, against the claim** (`data/fs131/claims-NF4.md`, NF4-S6): *"A winding on the relation lattice of
`Cay(R_F, U_F)` gives a character `θ` of `R_F` with `θ(U_F) ⊆ [1/3, 2/3]` (`plans/FS73-derivation.md` T22;
`plans/FS81-derivation.md:39`)."* In this library's words: a proper 3-colouring of the unit-distance graph on `F²`
gives a point of `CharacterColouring.fieldBandSet F (band 3)` — an additive map `θ : ℤ[U_F] → ℝ/ℤ` with
`θ(u) ∈ [1/3, 2/3]` at every unit vector `u` of `F²`. **Every subfield `F ⊆ ℝ`; no finite generation, no number field.**

**The route** (FS81-T2, `plans/FS81-derivation.md:39`, in the form the kernel's winding makes short).
1. *Finitely many generators.* A colouring proper along `s : Fin m → A` carries a winding `W` on the relation lattice
   (`ThreeColour.nonempty_winding`, in the kernel since FS-75). `Winding.exists_box_point`: some `x ∈ [1/3, 2/3]^m` has
   `r · x = W r` on every relation — the box and the affine condition are separated otherwise, and the separating
   functional, moved to a rational and then an integer combination of relations, contradicts `W.minRise_le` at `−r`.
2. *A character of the whole group.* `r · x ∈ ℤ` on relations, so `s j ↦ x j mod 1` is a character of the subgroup `s`
   generates; `ℝ/ℤ` is divisible, so it extends to `A` (`exists_character_of_box_point`).
3. *All generators at once.* The characters of `A` with `θ(S) ⊆ B` form a closed subset of the compact space
   `A → ℝ/ℤ`, decreasing in `S`; finite `S` suffice (`bandSet_nonempty_of_finite`) — de Bruijn–Erdős in character form.

**Whose this is** (`LEDGER.md` § The claim list, row 79). The criterion "three colours are linear" is this project's
FS73-T22 with FS81-T2's passage to infinitely many generators `[hand; two independent derivations]`; not found in print,
never "first". The compactness is de Bruijn–Erdős's in character form.

**Inhabitants.** `ThreeColour.properAlong_one_two` (`ℤ` along `(1, 2)`, `x ↦ x mod 3`) inhabits
`exists_character_of_properAlong`, and `exists_character_one_two` is its conclusion there;
`ThreeColour.nonempty_winding_one_two` inhabits `Winding.exists_box_point`. `bandSet_three_nonempty_of_proper` is met at a
group with torsion by the 5-cycle (`bandSet_three_nonempty_zmod_five`: `ℤ/5`, the step `1`, the colours `0, 1, 0, 1, 2`).
No declaration of this module exhibits a subfield of `ℝ` whose plane is three-colourable — the hypothesis of
`fieldBandSet_three_nonempty_of_colorable`; the joining module `Arith/ThreeFourColours` does (`ℚ(√3)`, and every
two-colourable plane).

**Wider than the ledger's row 79** (FS131-IC1's reading, stated by FS131-KJ1). Row 79 states the criterion for finitely
generated torsion-free groups and finite symmetric generating sets; `exists_character_of_properAlong` and
`bandSet_three_nonempty_of_proper` hold for **every** abelian group and **every** set of steps, torsion included. And the
headline reads the colouring only on the ring `ℤ[U_F]`: `fieldBandSet_three_nonempty_of_colorable_unitRing`.
-/

namespace HadwigerNelson.ThreeColourCharacter

open HadwigerNelson.ThreeColour HadwigerNelson.CharacterColouring HadwigerNelson.SpectralChain SimpleGraph

variable {A : Type*} [AddCommGroup A] {m : ℕ}

/-! ## §1 Finitely many generators: from the winding to a point of the box -/

/-- **Finitely many strict linear inequalities with a real solution have an integer one**: the solutions form an open
cone, the rational vectors are dense, and a common denominator scales a rational solution to an integer one. (The one
analytic step of `Winding.exists_box_point`, read there at the `2^m` vertices of the box.) -/
theorem exists_int_vector_of_forall_neg {ι κ : Type*} [Fintype ι] [Finite κ] (ℓ : κ → (ι → ℝ) →ₗ[ℝ] ℝ) {c : ι → ℝ}
    (h : ∀ k, ℓ k c < 0) : ∃ N : ι → ℤ, ∀ k, ℓ k (fun i => (N i : ℝ)) < 0 := by
  -- the solutions form an open set, and `c` is in it
  have hopen : IsOpen (⋂ k, {x : ι → ℝ | ℓ k x < 0}) :=
    isOpen_iInter_of_finite fun k => isOpen_lt (ℓ k).continuous_of_finiteDimensional continuous_const
  -- so a rational vector is in it
  obtain ⟨q, hq⟩ := (DenseRange.piMap fun _ : ι => Rat.denseRange_cast (𝕜 := ℝ)).exists_mem_open hopen
    ⟨c, Set.mem_iInter.mpr h⟩
  have hq' : ∀ k, ℓ k (fun i => ((q i : ℚ) : ℝ)) < 0 := fun k => Set.mem_iInter.mp hq k
  -- and its multiple by a common denominator `D` is an integer vector
  set D : ℕ := ∏ i, (q i).den
  have hDpos : 0 < D := Finset.prod_pos fun i _ => (q i).den_pos
  refine ⟨fun i => (q i).num * ((D / (q i).den : ℕ) : ℤ), fun k => ?_⟩
  have hN : (fun i => (((q i).num * ((D / (q i).den : ℕ) : ℤ) : ℤ) : ℝ)) = (D : ℝ) • fun i => ((q i : ℚ) : ℝ) := by
    funext i
    obtain ⟨e, he⟩ : (q i).den ∣ D := Finset.dvd_prod_of_mem _ (Finset.mem_univ i)
    have hden : ((q i).den : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr (q i).den_ne_zero
    rw [Pi.smul_apply, smul_eq_mul, he, Nat.mul_div_cancel_left e (q i).den_pos, Rat.cast_def]
    push_cast
    field_simp
  rw [hN, map_smul, smul_eq_mul]
  exact mul_neg_of_pos_of_neg (Nat.cast_pos.mpr hDpos) (hq' k)

/-- **The winding's bound, read at a vertex of the box** (C1): for a relation `r`, the vertex `v` with `v_j = 2/3`
where `0 ≤ r_j` and `v_j = 1/3` elsewhere has `W r ≤ r · v` — `W.minRise_le` at `−r`, because `−min(−t, −2t)` is `2t`
for `0 ≤ t` and `t` otherwise, three times `t v_j`. -/
private theorem winding_le_vertex {s : Fin m → A} (W : Winding s) (r : (relMap s).ker) :
    ((W.toHom r : ℤ) : ℝ) ≤
      ∑ j, (((r : Fin m → ℤ) j : ℤ) : ℝ) * (if 0 ≤ (r : Fin m → ℤ) j then 2 / 3 else 1 / 3) := by
  have h := W.minRise_le (-r)
  rw [map_neg] at h
  have hmin : ∀ t : ℤ, min (-t) (2 * -t) = -(if 0 ≤ t then 2 * t else t) := fun t => by
    split_ifs <;> omega
  have h3 : 3 * W.toHom r ≤ ∑ j, (if 0 ≤ (r : Fin m → ℤ) j then 2 * (r : Fin m → ℤ) j else (r : Fin m → ℤ) j) := by
    -- `minRise` read by unfolding, not by `simp [minRise]`: that would mint `minRise.eq_1` here, a second copy of a
    -- theorem `ThetaCert` already generated
    change ∑ j, min (-(r : Fin m → ℤ) j) (2 * -(r : Fin m → ℤ) j) ≤ 3 * -W.toHom r at h
    simp only [hmin, Finset.sum_neg_distrib] at h
    linarith
  have h3' : (3 : ℝ) * ((W.toHom r : ℤ) : ℝ) ≤
      ∑ j, 3 * ((((r : Fin m → ℤ) j : ℤ) : ℝ) * (if 0 ≤ (r : Fin m → ℤ) j then 2 / 3 else 1 / 3)) := by
    have hcast : (((3 * W.toHom r : ℤ)) : ℝ) ≤
        ((∑ j, (if 0 ≤ (r : Fin m → ℤ) j then 2 * (r : Fin m → ℤ) j else (r : Fin m → ℤ) j) : ℤ) : ℝ) :=
      Int.cast_le.mpr h3
    rw [Int.cast_mul, Int.cast_sum] at hcast
    refine hcast.trans (le_of_eq (Finset.sum_congr rfl fun j _ => ?_))
    split_ifs <;> push_cast <;> ring
  rw [← Finset.mul_sum] at h3'
  linarith

/-- **The real-linear half of `Winding.exists_box_point`** (C2 with C3): for a real matrix `g` and a target `w`, if
every integer combination `Σ_i N_i (g_i · v − w_i)` of the equations is non-negative at some vertex `v` of the box
`[1/3, 2/3]^m`, a point of the box solves `g_i · x = w_i` for every `i`. (Otherwise a functional separates the image
of the box, compact and convex, from `w`; it is negative at every vertex, and `exists_int_vector_of_forall_neg` makes
its coefficients integers.) -/
private theorem exists_mem_box_of_forall_int {n : ℕ} (g : Fin n → Fin m → ℝ) (w : Fin n → ℝ)
    (h : ∀ N : Fin n → ℤ, ∃ b : Fin m → Bool,
      0 ≤ ∑ i, (N i : ℝ) * (∑ j, g i j * (if b j then 2 / 3 else 1 / 3) - w i)) :
    ∃ x : Fin m → ℝ, (∀ j, x j ∈ Set.Icc (1 / 3 : ℝ) (2 / 3)) ∧ ∀ i, ∑ j, g i j * x j = w i := by
  classical
  by_contra hno
  -- the matrix as a linear map, and the box
  let L : (Fin m → ℝ) →ₗ[ℝ] (Fin n → ℝ) := Matrix.mulVecLin (Matrix.of g)
  have hL : ∀ x i, L x i = ∑ j, g i j * x j := fun x i => by
    simp [L, Matrix.mulVec, dotProduct]
  let B : Set (Fin m → ℝ) := Set.univ.pi fun _ => Set.Icc (1 / 3 : ℝ) (2 / 3)
  have hBc : IsCompact B := isCompact_univ_pi fun _ => isCompact_Icc
  have hBconv : Convex ℝ B := convex_pi fun _ _ => convex_Icc _ _
  have hw : w ∉ L '' B := by
    rintro ⟨x, hx, rfl⟩
    exact hno ⟨x, fun j => hx j (Set.mem_univ j), fun i => (hL x i).symm⟩
  -- a functional separating the image of the box from `w`, in coordinates
  obtain ⟨f, u, hfu, huw⟩ := geometric_hahn_banach_closed_point (hBconv.linear_image L)
    (hBc.image L.continuous_of_finiteDimensional).isClosed hw
  let c : Fin n → ℝ := fun i => f (fun k => if i = k then 1 else 0)
  have hf : ∀ y : Fin n → ℝ, f y = ∑ i, y i * c i := fun y => by
    simpa [smul_eq_mul] using LinearMap.pi_apply_eq_sum_univ (f : (Fin n → ℝ) →ₗ[ℝ] ℝ) y
  -- it is negative at every vertex
  let v : (Fin m → Bool) → Fin m → ℝ := fun b j => if b j then 2 / 3 else 1 / 3
  have hv : ∀ b, v b ∈ B := fun b j _ => by
    by_cases hb : b j <;> simp only [v, hb] <;> constructor <;> norm_num
  let d : (Fin m → Bool) → Fin n → ℝ := fun b i => ∑ j, g i j * v b j - w i
  have hneg : ∀ b, ∑ i, d b i * c i < 0 := fun b => by
    have h1 : f (L (v b)) < f w := (hfu _ ⟨v b, hv b, rfl⟩).trans huw
    rw [hf, hf] at h1
    have h2 : ∑ i, d b i * c i = ∑ i, L (v b) i * c i - ∑ i, w i * c i := by
      rw [← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun i _ => by rw [hL]; ring
    linarith
  -- so some integer combination is negative at every vertex
  obtain ⟨N, hN⟩ := exists_int_vector_of_forall_neg
    (fun b : Fin m → Bool => ∑ i, d b i • (LinearMap.proj i : (Fin n → ℝ) →ₗ[ℝ] ℝ)) (c := c)
    (fun b => by simpa [LinearMap.sum_apply] using hneg b)
  obtain ⟨b, hb⟩ := h N
  have hNb := hN b
  simp only [LinearMap.sum_apply, LinearMap.smul_apply, LinearMap.proj_apply, smul_eq_mul] at hNb
  have h3 : ∑ i, (N i : ℝ) * (∑ j, g i j * (if b j then 2 / 3 else 1 / 3) - w i) = ∑ i, d b i * (N i : ℝ) :=
    Finset.sum_congr rfl fun i _ => mul_comm _ _
  linarith

/-- **NF4-S6, finite form (FS73-T22 ⟹ past the winding).** A winding is the relation form of a point of the box: some
`x ∈ [1/3, 2/3]^m` has `Σ_j r_j x_j = W r` for every relation `r`. -/
theorem _root_.HadwigerNelson.ThreeColour.Winding.exists_box_point {s : Fin m → A} (W : Winding s) :
    ∃ x : Fin m → ℝ, (∀ j, x j ∈ Set.Icc (1 / 3 : ℝ) (2 / 3)) ∧
      ∀ r : (relMap s).ker, ∑ j, (((r : Fin m → ℤ) j : ℤ) : ℝ) * x j = ((W.toHom r : ℤ) : ℝ) := by
  -- finitely many generators `g i` of the relation lattice, and every relation an integer combination of them
  obtain ⟨n, g, hg⟩ := Submodule.fg_iff_exists_fin_generating_family.mp
    (IsNoetherian.noetherian (AddSubgroup.toIntSubmodule (relMap s).ker))
  have hgK : ∀ i, g i ∈ (relMap s).ker := fun i =>
    show g i ∈ AddSubgroup.toIntSubmodule (relMap s).ker from hg ▸ Submodule.subset_span ⟨i, rfl⟩
  let gK : Fin n → (relMap s).ker := fun i => ⟨g i, hgK i⟩
  have hcoe : ∀ (N : Fin n → ℤ) (j : Fin m),
      ((∑ i, N i • gK i : (relMap s).ker) : Fin m → ℤ) j = ∑ i, N i * g i j := fun N j => by
    simp [gK]
  have hrep : ∀ r : (relMap s).ker, ∃ N : Fin n → ℤ, r = ∑ i, N i • gK i := fun r => by
    have hr : (r : Fin m → ℤ) ∈ Submodule.span ℤ (Set.range g) := hg ▸ r.2
    obtain ⟨N, hN⟩ := (Submodule.mem_span_range_iff_exists_fun ℤ).mp hr
    refine ⟨N, Subtype.ext (funext fun j => ?_)⟩
    rw [hcoe, ← hN]
    simp
  -- both sides of the equation are additive in the relation (C4)
  have hkey : ∀ (N : Fin n → ℤ) (x : Fin m → ℝ),
      ∑ j, ((((∑ i, N i • gK i : (relMap s).ker) : Fin m → ℤ) j : ℤ) : ℝ) * x j
          - ((W.toHom (∑ i, N i • gK i) : ℤ) : ℝ)
        = ∑ i, (N i : ℝ) * (∑ j, ((g i j : ℤ) : ℝ) * x j - ((W.toHom (gK i) : ℤ) : ℝ)) := fun N x => by
    simp only [hcoe, map_sum, map_zsmul, smul_eq_mul, Int.cast_sum, Int.cast_mul, mul_sub, Finset.sum_sub_distrib,
      Finset.sum_mul, Finset.mul_sum]
    rw [Finset.sum_comm]
    congr 1
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
  -- the winding's bound at a vertex is the hypothesis of the real-linear half
  obtain ⟨x, hxB, hx⟩ := exists_mem_box_of_forall_int (fun i j => ((g i j : ℤ) : ℝ))
    (fun i => ((W.toHom (gK i) : ℤ) : ℝ)) fun N => by
      refine ⟨fun j => decide (0 ≤ ((∑ i, N i • gK i : (relMap s).ker) : Fin m → ℤ) j), ?_⟩
      have h1 := winding_le_vertex W (∑ i, N i • gK i)
      have h2 := hkey N fun j => if 0 ≤ ((∑ i, N i • gK i : (relMap s).ker) : Fin m → ℤ) j then 2 / 3 else 1 / 3
      simp only [decide_eq_true_eq]
      linarith
  refine ⟨x, hxB, fun r => ?_⟩
  obtain ⟨N, rfl⟩ := hrep r
  have h2 := hkey N x
  have h0 : ∑ i, (N i : ℝ) * (∑ j, ((g i j : ℤ) : ℝ) * x j - ((W.toHom (gK i) : ℤ) : ℝ)) = 0 :=
    Finset.sum_eq_zero fun i _ => by rw [hx i, sub_self, mul_zero]
  linarith

/-- **Values on generators that are integral on relations are a character.** If `Σ_j r_j x_j ∈ ℤ` for every relation `r`
of `s`, some character of `A` takes the value `x j mod 1` at `s j`. (On the subgroup `s` generates by the first
isomorphism theorem; extended to `A` because `ℝ/ℤ` is divisible.) -/
theorem exists_character_of_box_point (s : Fin m → A) {x : Fin m → ℝ}
    (hx : ∀ r : (relMap s).ker, ∃ n : ℤ, ∑ j, (((r : Fin m → ℤ) j : ℤ) : ℝ) * x j = (n : ℝ)) :
    ∃ θ : A →+ UnitAddCircle, ∀ j, θ (s j) = ((x j : ℝ) : UnitAddCircle) := by
  classical
  -- the character `r ↦ Σ_j r_j x_j mod 1` of `ℤ^m`
  let ψ : (Fin m → ℤ) →+ UnitAddCircle :=
    AddMonoidHom.mk' (fun r => ((∑ j, ((r j : ℤ) : ℝ) * x j : ℝ) : UnitAddCircle)) fun r r' => by
      rw [← AddCircle.coe_add]
      congr 1
      simp [add_mul, Finset.sum_add_distrib]
  have hψ : ∀ r, ψ r = ((∑ j, ((r j : ℤ) : ℝ) * x j : ℝ) : UnitAddCircle) := fun _ => rfl
  -- it kills the relations, so it descends to the subgroup `s` generates
  have hker : (relMap s).rangeRestrict.ker ≤ ψ.ker := fun r hr => by
    rw [AddMonoidHom.ker_rangeRestrict] at hr
    obtain ⟨n, hn⟩ := hx ⟨r, hr⟩
    rw [AddMonoidHom.mem_ker, hψ, hn]
    exact (AddCircle.coe_eq_zero_iff 1).mpr ⟨n, by simp⟩
  let φ : (relMap s).range →+ UnitAddCircle :=
    (relMap s).rangeRestrict.liftOfSurjective (relMap s).rangeRestrict_surjective ⟨ψ, hker⟩
  have hφ : ∀ r, φ ((relMap s).rangeRestrict r) = ψ r := fun r =>
    AddMonoidHom.liftOfRightInverse_comp_apply _ _ _ _ r
  -- and extends to `A`: `ℝ/ℤ` is divisible, hence injective over `ℤ` (Baer)
  obtain ⟨θ, hθ⟩ := (Module.Baer.of_divisible UnitAddCircle).extension_property_addMonoidHom
    (relMap s).range.subtype (AddSubgroup.subtype_injective _) φ
  refine ⟨θ, fun j => ?_⟩
  have h1 : relMap s (Pi.single j 1) = s j := by
    -- `relMap` read by unfolding (see `winding_le_vertex`)
    change ∑ k, (Pi.single j (1 : ℤ) : Fin m → ℤ) k • s k = s j
    simp [Pi.single_apply]
  have h2 := DFunLike.congr_fun hθ ((relMap s).rangeRestrict (Pi.single j 1))
  rw [hφ, hψ] at h2
  simpa [h1, Pi.single_apply] using h2

/-- **The criterion's ⟹, finitely many generators, character form**: a colouring proper along `s` gives a character of
`A` with every `θ (s j)` in the band `[1/3, 2/3]`. -/
theorem exists_character_of_properAlong (s : Fin m → A) {c : A → ZMod 3} (hc : ProperAlong s c) :
    ∃ θ : A →+ UnitAddCircle, ∀ j, θ (s j) ∈ band 3 := by
  obtain ⟨W⟩ := nonempty_winding s hc
  obtain ⟨x, hxB, hx⟩ := W.exists_box_point
  obtain ⟨θ, hθ⟩ := exists_character_of_box_point s (x := x) fun r => ⟨W.toHom r, hx r⟩
  refine ⟨θ, fun j => ⟨x j, ?_, (hθ j).symm⟩⟩
  have h := hxB j
  rw [Set.mem_Icc] at h ⊢
  rw [Nat.cast_ofNat]
  constructor <;> linarith [h.1, h.2]

/-! ## §2 All generators at once: compactness of the character group -/

/-- The band `[1/k, 1 − 1/k]` is closed in `ℝ/ℤ` (a compact interval's image). -/
theorem isClosed_band (k : ℕ) : IsClosed (band k) :=
  (isCompact_Icc.image (AddCircle.continuous_mk' 1)).isClosed

/-- **Compactness, character form** (de Bruijn–Erdős for band sets): for a closed band `B`, if every finite subset of `U`
has a character of `M` with values in `B` on it, so has `U`. -/
theorem bandSet_nonempty_of_finite {M : Type*} [AddCommGroup M] (U : Set M) {B : Set UnitAddCircle} (hB : IsClosed B)
    (h : ∀ S : Finset M, (S : Set M) ⊆ U → (bandSet (S : Set M) B).Nonempty) : (bandSet U B).Nonempty := by
  classical
  -- the additive maps are a closed, hence compact, set of functions `M → ℝ/ℤ`
  have hcomp : IsCompact (Set.range ((↑) : (M →+ UnitAddCircle) → M → UnitAddCircle)) :=
    (AddMonoidHom.isClosed_range_coe M UnitAddCircle).isCompact
  -- one closed condition for each element of `U`; finitely many of them are met by the hypothesis's character
  obtain ⟨_, ⟨θ, rfl⟩, hθ⟩ := hcomp.inter_iInter_nonempty (fun u : U => {φ : M → UnitAddCircle | φ u ∈ B})
    (fun u => hB.preimage (continuous_apply (u : M))) fun t => by
      obtain ⟨θ, hθ⟩ := h (t.image Subtype.val) fun x hx => by
        obtain ⟨u, -, rfl⟩ := Finset.mem_image.mp (Finset.mem_coe.mp hx)
        exact u.2
      exact ⟨θ, ⟨θ, rfl⟩, Set.mem_iInter₂.mpr fun u hu =>
        hθ u (Finset.mem_coe.mpr (Finset.mem_image_of_mem _ hu))⟩
  exact ⟨θ, fun u hu => Set.mem_iInter.mp hθ ⟨u, hu⟩⟩

/-- **NF4-S6 for a group**: a colouring `c : A → ZMod 3` that changes along every step in `U` gives a character of `A`
with `θ(U) ⊆ [1/3, 2/3]`. -/
theorem bandSet_three_nonempty_of_proper {U : Set A} {c : A → ZMod 3} (hc : ∀ a, ∀ u ∈ U, c (a + u) ≠ c a) :
    (bandSet U (band 3)).Nonempty := by
  refine bandSet_nonempty_of_finite U (isClosed_band 3) fun S hS => ?_
  -- a finite subset of `U`, listed along `Fin S.card`, is a family the colouring is proper along
  obtain ⟨θ, hθ⟩ := exists_character_of_properAlong (fun j : Fin S.card => ((S.equivFin.symm j : S) : A)) (c := c)
    fun a j => hc a _ (hS (S.equivFin.symm j).2)
  exact ⟨θ, fun u hu => by simpa using hθ (S.equivFin ⟨u, hu⟩)⟩

/-! ## §3 The plane over a subfield of `ℝ` -/

/-- **NF4-S6 (FS81-T2: `χ(F²) ≤ 3 ⟹ Θ₃(F) ≠ ∅`), every subfield `F ⊆ ℝ`.** A proper 3-colouring of the unit-distance
graph on `F²` gives a character of `ℤ[U_F]` with values in `[1/3, 2/3]` on every unit vector of `F²`. -/
theorem fieldBandSet_three_nonempty_of_colorable (F : Subfield ℝ)
    (h : ((unitDistance ℂ).induce (planeOver F)).Colorable 3) : (fieldBandSet F (band 3)).Nonempty := by
  obtain ⟨C⟩ := h
  -- `ℤ[U_F]` lies in the plane over `F`, so the colouring restricts to it; a unit vector is a step of length 1
  have hmem : ∀ a : unitRing F, (a : ℂ) ∈ planeOver F := fun a => UnitRing.unitRingOver_le_planeOverSubring F a.2
  refine bandSet_three_nonempty_of_proper (c := fun a : unitRing F => (C ⟨a, hmem a⟩ : ZMod 3)) fun a u hu => ?_
  refine C.valid ?_
  change (unitDistance ℂ).Adj ((a + u : unitRing F) : ℂ) (a : ℂ)
  rw [unitDistance_adj, Subring.coe_add, dist_eq_norm, add_sub_cancel_left]
  exact hu.2

/-! ## Spec -/

/-- The model: `ℤ` along `(1, 2)` with `x ↦ x mod 3` — the conclusion of `exists_character_of_properAlong` there. -/
theorem exists_character_one_two : ∃ θ : ℤ →+ UnitAddCircle, ∀ j, θ (![(1 : ℤ), 2] j) ∈ band 3 :=
  exists_character_of_properAlong _ properAlong_one_two

-- The band at 3 holds `1/3`, `1/2` and `2/3`, and not `0`.
example : ((1 / 3 : ℝ) : UnitAddCircle) ∈ band 3 := ⟨1 / 3, ⟨by norm_num, by norm_num⟩, rfl⟩
example : ((1 / 2 : ℝ) : UnitAddCircle) ∈ band 3 := ⟨1 / 2, ⟨by norm_num, by norm_num⟩, rfl⟩

/-! ## The two readings FS131-IC1 named (stated by FS131-KJ1) -/

/-- **The headline, read on the ring of unit vectors**: a proper 3-colouring of the unit-distance graph on `ℤ[U_F]`
alone — the component of `0` in `F²` — gives the character. It is what the proof of
`fieldBandSet_three_nonempty_of_colorable` reads (the plane's colouring is only ever evaluated on the ring), and that
theorem is this one after restricting the colouring. Every subfield `F ⊆ ℝ`. -/
theorem fieldBandSet_three_nonempty_of_colorable_unitRing (F : Subfield ℝ)
    (h : ((unitDistance ℂ).induce (unitRing F : Set ℂ)).Colorable 3) : (fieldBandSet F (band 3)).Nonempty := by
  obtain ⟨C⟩ := h
  refine bandSet_three_nonempty_of_proper (c := fun a : unitRing F => (C ⟨a, a.2⟩ : ZMod 3)) fun a u hu => ?_
  refine C.valid ?_
  change (unitDistance ℂ).Adj ((a + u : unitRing F) : ℂ) (a : ℂ)
  rw [unitDistance_adj, Subring.coe_add, dist_eq_norm, add_sub_cancel_left]
  exact hu.2

/-- **The criterion's forward half at a group with torsion** — the 5-cycle: `ℤ/5` with the one step `1`, coloured
`0, 1, 0, 1, 2`. The colouring changes along the step, so `bandSet_three_nonempty_of_proper` gives a character of `ℤ/5`
with `θ(1) ∈ [1/3, 2/3]` modulo 1 (it is `2/5` or `3/5`). `LEDGER.md` row 79 states the criterion for finitely generated
torsion-free groups; this is a model of the kernel's wider statement outside that class. -/
theorem bandSet_three_nonempty_zmod_five : (bandSet ({1} : Set (ZMod 5)) (band 3)).Nonempty :=
  bandSet_three_nonempty_of_proper (c := fun a : ZMod 5 => (![0, 1, 0, 1, 2] : Fin 5 → ZMod 3) a) fun a u hu => by
    rw [Set.mem_singleton_iff] at hu
    subst hu
    revert a
    decide

-- The band at 3 holds `2/3` and not `0` (the other two of the four facts promised above).
example : ((2 / 3 : ℝ) : UnitAddCircle) ∈ band 3 := ⟨2 / 3, ⟨by norm_num, by norm_num⟩, rfl⟩
example : (0 : UnitAddCircle) ∉ band 3 := by
  rintro ⟨x, ⟨h1, h2⟩, hx⟩
  obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff 1).mp hx
  rw [zsmul_eq_mul, mul_one] at hn
  rw [Nat.cast_ofNat] at h1 h2
  have h3 : (0 : ℝ) < n := by rw [hn]; linarith
  have h4 : (n : ℝ) < 1 := by rw [hn]; linarith
  have h5 : (0 : ℤ) < n := by exact_mod_cast h3
  have h6 : n < (1 : ℤ) := by exact_mod_cast h4
  omega

end HadwigerNelson.ThreeColourCharacter
