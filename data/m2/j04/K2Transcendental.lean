import Proofs.HadwigerNelson.SquareClass
import Proofs.HadwigerNelson.ResidueColouring
import Proofs.HadwigerNelson.ResidueTower
import Mathlib.FieldTheory.RatFunc.Basic
import Mathlib.NumberTheory.Transcendental.Liouville.LiouvilleNumber

/-!
# K2 skeleton (J04 → J15): FS-39 route C, `χ(F(t)²) = χ(F²)` for `t` transcendental over `F`

`[Fischer1990]` Thm 6 (statement and proof: evaluation at `t = 0` on the unit vectors' coset). Route: every unit vector
of `F(t)²` has both coordinates in the `t`-integral subring `A` (the residue `F` is formally real), so the plane splits
into cosets of `A × A` and `cosetResidue` of the residue map `A →+* F` is a colouring pull-back. **Not** through
`colorable_unitDistance_induce_of_valuationSubring`, whose colours are the elements of a *finite* residue ring.
-/

set_option autoImplicit false

namespace HadwigerNelson
namespace RouteC

open SimpleGraph Polynomial

/-! ## Leaf A (priced by J04): the plane over a real field, in coordinates -/

/-- The plane over `L ⊆ ℝ` is the unit-quadrance graph of `L`, vertex by vertex. -/
noncomputable def planeOverEquiv (L : Subfield ℝ) : planeOver L ≃ L × L where
  toFun z := (⟨(z : ℂ).re, z.2.1⟩, ⟨(z : ℂ).im, z.2.2⟩)
  invFun p := ⟨⟨p.1, p.2⟩, p.1.2, p.2.2⟩
  left_inv _ := rfl
  right_inv _ := rfl

theorem dist_eq_one_iff_quadrance (z w : ℂ) :
    dist z w = 1 ↔ (z.re - w.re) ^ 2 + (z.im - w.im) ^ 2 = 1 := by
  rw [Complex.dist_eq, Complex.norm_def, Real.sqrt_eq_one, Complex.normSq_apply]
  simp only [Complex.sub_re, Complex.sub_im]
  constructor <;> intro h <;> linarith [h]

/-- **The plane over `L` is `unitQuadrance L`** as graphs. -/
noncomputable def planeOverIso (L : Subfield ℝ) :
    (unitDistance ℂ).induce (planeOver L) ≃g unitQuadrance L where
  toEquiv := planeOverEquiv L
  map_rel_iff' {z w} := by
    rw [unitQuadrance_adj_iff_quadrance]
    simp only [SimpleGraph.comap_adj, Function.Embedding.coe_subtype, unitDistance_adj,
      dist_eq_one_iff_quadrance, planeOverEquiv, Equiv.coe_fn_mk]
    constructor
    · intro h
      have := congrArg (fun x : L => (x : ℝ)) h
      simpa using this
    · intro h
      apply Subtype.ext
      simpa using h

/-! ## Leaf B (priced by J04): coset reduction along a subring holding every unit vector -/

/-- **Colourability pulls back through a subring that holds every unit vector.** The plane over `R` splits into cosets
of `A × A` with no edge between cosets (edge differences are unit vectors, in `A × A`); on each coset `cosetResidue`
of `φ × φ` is additive, so a unit edge maps to a unit edge of `S²`. Fischer's evaluation at `0` is `φ`. -/
theorem unitQuadrance_colorable_of_subring {R S : Type*} [CommRing R] [CommRing S] [Nontrivial S]
    (A : Subring R) (hA : ∀ v : R × R, v.1 ^ 2 + v.2 ^ 2 = 1 → v.1 ∈ A ∧ v.2 ∈ A)
    (φ : A →+* S) {k : ℕ} (h : (unitQuadrance S).Colorable k) : (unitQuadrance R).Colorable k := by
  obtain ⟨C⟩ := h
  let P : AddSubgroup (R × R) := A.toAddSubgroup.prod A.toAddSubgroup
  let ψ : P →+ S × S :=
    { toFun := fun v => (φ ⟨v.1.1, v.2.1⟩, φ ⟨v.1.2, v.2.2⟩)
      map_zero' := by ext <;> simp <;> exact map_zero φ
      map_add' := fun v w => by
        ext
        · exact map_add φ ⟨v.1.1, v.2.1⟩ ⟨w.1.1, w.2.1⟩
        · exact map_add φ ⟨v.1.2, v.2.2⟩ ⟨w.1.2, w.2.2⟩ }
  refine ⟨Coloring.mk (fun z => C (cosetResidue ψ z)) fun {u v} huv => ?_⟩
  rw [unitQuadrance_adj] at huv
  obtain ⟨-, hq⟩ := huv
  have hmem : u - v ∈ P := hA (u - v) (by simpa using hq)
  apply C.valid
  rw [unitQuadrance_adj_iff_quadrance]
  have hsub := cosetResidue_sub ψ hmem
  rw [cosetResidue_apply_of_mem ψ hmem] at hsub
  have h1 : (cosetResidue ψ u).1 - (cosetResidue ψ v).1 = φ ⟨(u - v).1, hmem.1⟩ :=
    congrArg Prod.fst hsub
  have h2 : (cosetResidue ψ u).2 - (cosetResidue ψ v).2 = φ ⟨(u - v).2, hmem.2⟩ :=
    congrArg Prod.snd hsub
  rw [h1, h2, ← map_pow, ← map_pow, ← map_add]
  have : (⟨(u - v).1, hmem.1⟩ : A) ^ 2 + ⟨(u - v).2, hmem.2⟩ ^ 2 = 1 :=
    Subtype.ext (by simpa using hq)
  rw [this, map_one]

/-! ## The transcendental adjunction (J15) -/

/-- `F⟮t⟯ ⊆ ℝ`, as the image of `RatFunc F` under `X ↦ t`. -/
noncomputable def adjoinTranscendental (F : Subfield ℝ) (t : ℝ) (ht : Transcendental F t) : Subfield ℝ :=
  sorry

theorem le_adjoinTranscendental (F : Subfield ℝ) (t : ℝ) (ht : Transcendental F t) :
    F ≤ adjoinTranscendental F t ht := sorry

/-- The `t`-integral subring (no pole at `t = 0`). -/
noncomputable def tIntegral (F : Subfield ℝ) (t : ℝ) (ht : Transcendental F t) :
    Subring (adjoinTranscendental F t ht) := sorry

/-- Evaluation at `t = 0`, a ring hom onto `F`. -/
noncomputable def evalZero (F : Subfield ℝ) (t : ℝ) (ht : Transcendental F t) :
    tIntegral F t ht →+* F := sorry

/-- **The one real leaf** (`[Fischer1990]` Thm 6's "setting `x = 0`"): every unit vector of `F(t)²` is `t`-integral,
because `F ⊆ ℝ` makes `a² + b² = 0` force `a = b = 0` in the residue field. -/
theorem unit_mem_tIntegral (F : Subfield ℝ) (t : ℝ) (ht : Transcendental F t)
    (v : adjoinTranscendental F t ht × adjoinTranscendental F t ht) (hv : v.1 ^ 2 + v.2 ^ 2 = 1) :
    v.1 ∈ tIntegral F t ht ∧ v.2 ∈ tIntegral F t ht := sorry

/-- **Transcendence is free** (`[Fischer1990]` Thm 6; `CLAUDE.md` G63): `χ(F(t)²) = χ(F²)`. -/
theorem chromaticNumber_planeOver_adjoinTranscendental (F : Subfield ℝ) (t : ℝ) (ht : Transcendental F t) :
    ((unitDistance ℂ).induce (planeOver (adjoinTranscendental F t ht))).chromaticNumber =
      ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := sorry

/-- The named inhabitant: Liouville's constant is transcendental over `ℚ = ⊥`. -/
theorem transcendental_liouvilleNumber_bot : Transcendental (⊥ : Subfield ℝ) (liouvilleNumber 10) := sorry

/-- `χ(ℚ(L)²) = χ(ℚ²)`, `L` Liouville's constant (π's transcendence is not in Mathlib). -/
theorem chromaticNumber_planeOver_liouville :
    ((unitDistance ℂ).induce (planeOver (adjoinTranscendental ⊥ (liouvilleNumber 10)
        transcendental_liouvilleNumber_bot))).chromaticNumber =
      ((unitDistance ℂ).induce (planeOver ⊥)).chromaticNumber :=
  chromaticNumber_planeOver_adjoinTranscendental _ _ _

end RouteC
end HadwigerNelson
