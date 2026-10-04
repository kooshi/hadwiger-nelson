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
  intro hfan
  let ρ : udOn V →g addCayley (ψ '' {u : Λ | ‖(u : ℂ)‖ = 1}) :=
    { toFun := fun v => ψ ⟨v.1, hV v.2⟩
      map_rel' := by
        intro x y h
        have hd : dist (x : ℂ) (y : ℂ) = 1 := h
        have hxy : (⟨(y : ℂ), hV y.2⟩ : Λ) - ⟨(x : ℂ), hV x.2⟩ ∈ {u : Λ | ‖(u : ℂ)‖ = 1} := by
          show ‖(y : ℂ) - x‖ = 1
          rw [← dist_eq_norm, dist_comm]; exact hd
        rw [addCayley_adj]
        have hne := hψ _ hxy
        refine ⟨fun heq => hne ?_, Or.inl ?_⟩
        · rw [map_sub, heq, sub_self]
        · rw [show -ψ ⟨(x : ℂ), hV x.2⟩ + ψ ⟨(y : ℂ), hV y.2⟩ = ψ (⟨(y : ℂ), hV y.2⟩ - ⟨(x : ℂ), hV x.2⟩) by
            rw [map_sub]; abel]
          exact ⟨_, hxy, rfl⟩ }
  have hB := (falconerFan_hom (by norm_num) hfan ρ).2
  let tb : (V : Set ℂ) := ⟨b, hb⟩
  have hg := FanGap.translate hgap (w - ρ tb)
  have hg' : FanGap (C.comap (addCayleyTranslate _ (w - ρ tb))) (ρ tb) γ := by
    simpa using hg
  obtain ⟨x, hx, hxc⟩ := (hB (C.comap (addCayleyTranslate _ (w - ρ tb)))).2 γ
  rcases hx with rfl | hadj
  · exact hg'.1 hxc.symm
  · exact hg'.2 x hadj hxc

/-- **FS129-MA2-FALC-HOSTS**, clause (iii), over row 78's half (`hR78`, named): if `H` is drawn in a lattice on which every
difference identified by all four-colourings lies in `8Λ`, then the tip minus the apex is in `8Λ`. -/
theorem falconerFan_five_mem_eight (Λ : AddSubgroup ℂ)
    (hR78 : ∀ x y : Λ, (∀ C : ((unitDistance ℂ).induce (Λ : Set ℂ)).Coloring (Fin 4), C ⟨x, x.2⟩ = C ⟨y, y.2⟩) →
      ∃ w ∈ Λ, (y : ℂ) - x = 8 * w)
    (V : Finset ℂ) (hV : (V : Set ℂ) ⊆ Λ) {a b : ℂ} (ha : a ∈ V) (hb : b ∈ V)
    (hfan : FalconerFan (udOn V) 5 ⟨a, ha⟩ ⟨b, hb⟩) : ∃ w ∈ Λ, b - a = 8 * w := by
  let ρ : udOn V →g (unitDistance ℂ).induce (Λ : Set ℂ) :=
    { toFun := fun v => ⟨v.1, hV v.2⟩
      map_rel' := fun h => h }
  have hB := (falconerFan_hom (by norm_num) hfan ρ).2
  exact hR78 ⟨a, hV ha⟩ ⟨b, hV hb⟩ (fun C => (hB C).1)

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
  have hstep : ∀ u v : (V : Set ℂ), (udOn V).Adj u v → (u : ℂ) - a ∈ R → (v : ℂ) - a ∈ R := by
    intro u v h hu
    have hd : dist (u : ℂ) (v : ℂ) = 1 := h
    have : (v : ℂ) - u ∈ R := hRU _ ⟨by simpa using F.sub_mem (hV v.2).1 (hV u.2).1, by simpa using F.sub_mem (hV v.2).2 (hV u.2).2⟩
      (by rw [← dist_eq_norm, dist_comm]; exact hd)
    have := R.add_mem hu this
    simpa using this
  have hwalk : ∀ (u v : (V : Set ℂ)) (w : (udOn V).Walk u v), (u : ℂ) - a ∈ R → (v : ℂ) - a ∈ R := by
    intro u v w
    induction w with
    | nil => exact id
    | cons h _ ih => exact fun hu => ih (hstep _ _ h hu)
  have hmem : ∀ v : (V : Set ℂ), (v : ℂ) - a ∈ R := by
    intro v
    obtain ⟨w⟩ := hconn.preconnected ⟨a, ha⟩ v
    exact hwalk _ _ w (by simp)
  -- the homomorphism to the unit-distance graph on `R`, `v ↦ v - a`
  let ρ : udOn V →g (unitDistance ℂ).induce (R : Set ℂ) :=
    { toFun := fun v => ⟨(v : ℂ) - a, hmem v⟩
      map_rel' := by
        intro x y h
        have hd : dist (x : ℂ) (y : ℂ) = 1 := h
        show dist ((x : ℂ) - a) ((y : ℂ) - a) = 1
        rw [dist_sub_right]; exact hd }
  have hB := (falconerFan_hom (by norm_num) hfan ρ).2
  have hforced : b - a ∈ {v : ℂ | ∀ C : ((unitDistance ℂ).induce (R : Set ℂ)).Coloring (Fin 4), ∀ x : R,
        ∀ h : (x : ℂ) + v ∈ R, C x = C ⟨_, h⟩} := by
    intro C x h
    let T : ((unitDistance ℂ).induce (R : Set ℂ)) →g ((unitDistance ℂ).induce (R : Set ℂ)) :=
      { toFun := fun y => ⟨(y : ℂ) + x, R.add_mem y.2 x.2⟩
        map_rel' := by
          intro y z hyz
          have hd : dist (y : ℂ) (z : ℂ) = 1 := hyz
          show dist ((y : ℂ) + x) ((z : ℂ) + x) = 1
          rw [dist_add_right]; exact hd }
    have h1 := (hB (C.comap T)).1
    have e1 : T (ρ ⟨a, ha⟩) = x := Subtype.ext (by simp [T, ρ])
    have e2 : T (ρ ⟨b, hb⟩) = ⟨(x : ℂ) + (b - a), h⟩ := Subtype.ext (by simp [T, ρ, add_comm])
    have h1' : C (T (ρ ⟨a, ha⟩)) = C (T (ρ ⟨b, hb⟩)) := h1
    rwa [e1, e2] at h1'
  have hba : b - a ≠ 0 := sub_ne_zero.2 (fun h => hfan.1 (Subtype.ext h.symm))
  rcases hR88 with h0 | hP
  · exact absurd (by simpa using (h0 ▸ hforced : b - a ∈ ({0} : Set ℂ))) hba
  · exact ⟨hP ▸ hforced, hR88per hP⟩

end HadwigerNelson.Arith
