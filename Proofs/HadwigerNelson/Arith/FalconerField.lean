import Proofs.HadwigerNelson.Arith.PlaceHom
import Proofs.HadwigerNelson.Arith.FalconerFan
import Proofs.HadwigerNelson.FanGap
import Proofs.HadwigerNelson.LocalGlobal

/-!
# Where a Falconer fan at five colours can live (FS-131 wave 2)

Rows: **FS129-SA1-FALC-RES** (in place of FS129-OA1-FALC-11, FS129-MA1-FALC-19 and FS129-MA2-FALC-HOSTS (i)) and
**FS129-MA2-FALC-HOSTS** clauses (ii)–(iv), over FS129-SA1-FALC-FAN (B) and FS129-SA1-FALC-DICHO-K (SA1 item 5). Plan:
`plans/FS131-w2-kernel-plan.md` § 4.

**Named hypotheses from outside the backlog** (rows 78 and 88 are ours and not yet in the kernel): HOSTS (iii) takes the
half of row 78 it reads — on the lattice, a difference every four-colouring identifies lies in `8Λ` — as `hR78`; HOSTS (iv)
takes row 88's frame — the forced group is `0` or `P`, and if it is `P` every four-colouring is periodic — as `hR88`,
`hR88per`. Both clauses are stated over any lattice and any ring with those properties; de Grey's lattice and the rings of
ℚ(√59), ℚ(√83), ℚ(√131) instantiate them when rows 78 and 88 have Lean forms.
-/

namespace HadwigerNelson.Arith

open HadwigerNelson NumberField SimpleGraph

/-- The graph a finite `V ⊆ ℂ` spans in the unit-distance graph. -/
noncomputable abbrev udOn (V : Finset ℂ) : SimpleGraph (V : Set ℂ) := (unitDistance ℂ).induce (V : Set ℂ)

/-- **FS129-SA1-FALC-RES**, clause (i): a finite connected unit-distance graph over `E = F(t₁, …, t_n)` with a Falconer
fan at five colours forces `χ(F²) ≥ 4`, and `F` has no usable prime with residue field `𝔽₇`. -/
theorem falconerFan_five_field (F : Subfield ℝ) [NumberField F] {n : ℕ} (t : Fin n → ℝ)
    (ht : AlgebraicIndependent F t) (V : Finset ℂ) (hV : (V : Set ℂ) ⊆ planeOver (pureTranscendental F t))
    (hconn : (udOn V).Connected) {a b : ℂ} (ha : a ∈ V) (hb : b ∈ V) (hfan : FalconerFan (udOn V) 5 ⟨a, ha⟩ ⟨b, hb⟩) :
    4 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber ∧
      ¬ ∃ 𝔭 : Ideal (𝓞 F), IsUsablePrime 𝔭 ∧ Nat.card (𝓞 F ⧸ 𝔭) = 7 := by
  sorry

/-- **FS129-SA1-FALC-RES**, clause (ii): at every usable prime with residue field `𝔽₁₁` or `𝔽₁₉`, for **every** pair
`(V, φ)` with PLACE-HOM's properties (the row: "with V and φ as in PLACE-HOM"), the tip minus the apex has coordinates in `V`
and `φ` kills them. -/
theorem falconerFan_five_placeHom (F : Subfield ℝ) [NumberField F] {n : ℕ} (t : Fin n → ℝ)
    (ht : AlgebraicIndependent F t) (W : Finset ℂ) (hW : (W : Set ℂ) ⊆ planeOver (pureTranscendental F t))
    (hconn : (udOn W).Connected) {a b : ℂ} (ha : a ∈ W) (hb : b ∈ W) (hfan : FalconerFan (udOn W) 5 ⟨a, ha⟩ ⟨b, hb⟩)
    {𝔭 : Ideal (𝓞 F)} (h𝔭 : IsUsablePrime 𝔭) (hq : Nat.card (𝓞 F ⧸ 𝔭) = 11 ∨ Nat.card (𝓞 F ⧸ 𝔭) = 19)
    (V : Subring ℝ) (φ : V →+* (𝓞 F ⧸ 𝔭)) (hφ : IsPlaceHom F 𝔭 (pureTranscendental F t) V φ) :
    ∃ (hre : (b - a).re ∈ V) (him : (b - a).im ∈ V), φ ⟨_, hre⟩ = 0 ∧ φ ⟨_, him⟩ = 0 := by
  sorry

/-- **FS129-MA2-FALC-HOSTS**, clause (ii): a unit-distance graph drawn in a lattice `Λ` with a Falconer fan at five colours
does not exist if some image of `Λ` (the row: a finite quotient `Λ/NΛ`; here any additive hom `ψ` not killing a unit vector)
carries a proper four-colouring of its Cayley graph on `ψ(U)` with a colour absent from a closed neighbourhood. (The row's
"connected" is not read.) -/
theorem not_falconerFan_five_of_fanGap (Λ : AddSubgroup ℂ) {A : Type*} [AddCommGroup A] (ψ : Λ →+ A)
    (hψ : ∀ u : Λ, ‖(u : ℂ)‖ = 1 → ψ u ≠ 0) (C : (addCayley (ψ '' {u : Λ | ‖(u : ℂ)‖ = 1})).Coloring (Fin 4))
    {w : A} {γ : Fin 4} (hgap : FanGap C w γ) (V : Finset ℂ) (hV : (V : Set ℂ) ⊆ Λ) {a b : ℂ} (ha : a ∈ V)
    (hb : b ∈ V) : ¬ FalconerFan (udOn V) 5 ⟨a, ha⟩ ⟨b, hb⟩ := by
  sorry

/-- **FS129-MA2-FALC-HOSTS**, clause (iii), over row 78's half (`hR78`, named): if `H` is drawn in a lattice on which every
difference identified by all four-colourings lies in `8Λ`, then the tip minus the apex is in `8Λ`. -/
theorem falconerFan_five_mem_eight (Λ : AddSubgroup ℂ)
    (hR78 : ∀ x y : Λ, (∀ C : ((unitDistance ℂ).induce (Λ : Set ℂ)).Coloring (Fin 4), C ⟨x, x.2⟩ = C ⟨y, y.2⟩) →
      ∃ w ∈ Λ, (y : ℂ) - x = 8 * w)
    (V : Finset ℂ) (hV : (V : Set ℂ) ⊆ Λ) {a b : ℂ} (ha : a ∈ V) (hb : b ∈ V)
    (hfan : FalconerFan (udOn V) 5 ⟨a, ha⟩ ⟨b, hb⟩) : ∃ w ∈ Λ, b - a = 8 * w := by
  sorry

/-- **FS129-MA2-FALC-HOSTS**, clause (iv), over row 88's frame (`hR88`, `hR88per`, named): for a connected `H ⊂ F²` with a
fan at five colours and an additive group `R` holding every unit vector of `F²`, whose forced set (the differences every
four-colouring of the unit-distance graph on `R` identifies at every point) is `{0}` or `P`, and is `P` only if every
four-colouring of `F²` is periodic (`Per`), the tip minus the apex lies in `P` and `Per` holds. -/
theorem falconerFan_five_mem_P (F : Subfield ℝ) (R : AddSubgroup ℂ)
    (hRU : ∀ u ∈ planeOver F, ‖u‖ = 1 → u ∈ R) (P : Set ℂ) (Per : Prop)
    (hR88 : {v : ℂ | ∀ C : ((unitDistance ℂ).induce (R : Set ℂ)).Coloring (Fin 4), ∀ x : R,
        ∀ h : (x : ℂ) + v ∈ R, C x = C ⟨_, h⟩} = {0} ∨
      {v : ℂ | ∀ C : ((unitDistance ℂ).induce (R : Set ℂ)).Coloring (Fin 4), ∀ x : R,
        ∀ h : (x : ℂ) + v ∈ R, C x = C ⟨_, h⟩} = P)
    (hR88per : {v : ℂ | ∀ C : ((unitDistance ℂ).induce (R : Set ℂ)).Coloring (Fin 4), ∀ x : R,
        ∀ h : (x : ℂ) + v ∈ R, C x = C ⟨_, h⟩} = P → Per)
    (V : Finset ℂ) (hV : (V : Set ℂ) ⊆ planeOver F) (hconn : (udOn V).Connected) {a b : ℂ} (ha : a ∈ V) (hb : b ∈ V)
    (hfan : FalconerFan (udOn V) 5 ⟨a, ha⟩ ⟨b, hb⟩) : b - a ∈ P ∧ Per := by
  sorry

end HadwigerNelson.Arith
