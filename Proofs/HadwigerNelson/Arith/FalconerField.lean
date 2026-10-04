import Proofs.HadwigerNelson.Arith.PlaceHom
import Proofs.HadwigerNelson.Arith.FalconerFan
import Proofs.HadwigerNelson.FanGap
import Proofs.HadwigerNelson.LocalGlobal
import Proofs.HadwigerNelson.Instances.FalconerOrbit

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

/-! ## FS131-K2d: children of FALC-RES

Priced in `plans/FS131-w2-kernel-plan.md` § 15. Clause (i): a `(k − 2)`-colourable graph has no fan at `k` (the two missing colours
are both absent from the apex's neighbourhood and the tip takes neither), and FALC-FAN (B) against `Γ₇`'s slack at four colours.
Clause (ii): FALC-FAN (A) against the orbit facts of `Instances/FalconerOrbit`, through the homomorphism `v ↦ (φ, φ)(v − a)`. -/

/-- **A `(k − 2)`-colourable graph has no Falconer fan at `k` colours**: colour it with the first `k − 2` colours; the last two
are absent from the apex's neighbourhood, and the tip takes neither. -/
theorem not_falconerFan_of_colorable {V : Type*} {H : SimpleGraph V} {k : ℕ} (hk : 2 ≤ k) (hH : H.Colorable (k - 2))
    {a t : V} : ¬ FalconerFan H k a t := by
  sorry

/-- **The unit-vector subring holds every difference in a connected graph**: if `V` holds both coordinates of every unit
vector of `E²`, then for a connected unit-distance graph drawn in `E²` with apex `a`, every vertex minus `a` has coordinates in
`V` (a walk adds unit vectors). -/
theorem sub_mem_of_connected {E : Subfield ℝ} {V : Subring ℝ}
    (hU : ∀ x y : ℝ, x ∈ E → y ∈ E → x ^ 2 + y ^ 2 = 1 → x ∈ V ∧ y ∈ V) {W : Finset ℂ}
    (hW : (W : Set ℂ) ⊆ planeOver E) (hconn : (udOn W).Connected) {a : ℂ} (ha : a ∈ W) :
    ∀ v ∈ W, (v - a).re ∈ V ∧ (v - a).im ∈ V := by
  sorry

/-- **The homomorphism read off a place-hom pair at the apex**: `v ↦ (φ (v − a).re, φ (v − a).im)` maps a connected
unit-distance graph in `E²` into `Γ_q`, the apex to `0`. -/
theorem exists_hom_apex {F : Subfield ℝ} {𝔭 : Ideal (𝓞 F)} [𝔭.IsMaximal] {E : Subfield ℝ} {V : Subring ℝ}
    {φ : V →+* (𝓞 F ⧸ 𝔭)} (hφ : IsPlaceHom F 𝔭 E V φ) {W : Finset ℂ} (hW : (W : Set ℂ) ⊆ planeOver E)
    (hconn : (udOn W).Connected) {a : ℂ} (ha : a ∈ W) :
    ∃ ρ : udOn W →g unitQuadrance (𝓞 F ⧸ 𝔭), ∀ (v : (W : Set ℂ)) (hre : ((v : ℂ) - a).re ∈ V)
      (him : ((v : ℂ) - a).im ∈ V), ρ v = (φ ⟨_, hre⟩, φ ⟨_, him⟩) := by
  sorry

/-- **The tip lands on the apex** in a plane whose every nonzero vector is tip-free (FALC-FAN (A)): if `ρ` sends the apex
to `0` and every `w ≠ 0` has a 5-colouring with a gap `γ` at `0` and `C w ∉ {C 0, γ}`, then `ρ` sends the tip to `0`. -/
theorem tip_eq_zero_of_tipFree {V : Type*} {H : SimpleGraph V} {R : Type*} [CommRing R] {a t : V}
    (hfan : FalconerFan H 5 a t) (ρ : H →g unitQuadrance R) (ha : ρ a = 0)
    (hfree : ∀ w : R × R, w ≠ 0 →
      ∃ (C : (unitQuadrance R).Coloring (Fin 5)) (γ : Fin 5), FanGap C 0 γ ∧ C w ≠ C 0 ∧ C w ≠ γ) :
    ρ t = 0 := by
  sorry

/-- **No fan at five over a plane with a homomorphism to a graph slack at four** (FALC-FAN (B)'s last clause): every
4-colouring leaves no colour absent from the tip image's closed neighbourhood, while slackness supplies one that does. -/
theorem not_falconerFan_five_of_hom_slack {V W : Type*} {H : SimpleGraph V} {T : SimpleGraph W} {a t : V}
    (hfan : FalconerFan H 5 a t) (ρ : H →g T) (hT : Slack T 4) : False := by
  sorry

/-- **FS129-SA1-FALC-RES**, clause (i): a finite connected unit-distance graph over `E = F(t₁, …, t_n)` with a Falconer
fan at five colours forces `χ(F²) ≥ 4`, and `F` has no usable prime with residue field `𝔽₇`. -/
theorem falconerFan_five_field (F : Subfield ℝ) [NumberField F] {n : ℕ} (t : Fin n → ℝ)
    (ht : AlgebraicIndependent F t) (V : Finset ℂ) (hV : (V : Set ℂ) ⊆ planeOver (pureTranscendental F t))
    (hconn : (udOn V).Connected) {a b : ℂ} (ha : a ∈ V) (hb : b ∈ V) (hfan : FalconerFan (udOn V) 5 ⟨a, ha⟩ ⟨b, hb⟩) :
    4 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber ∧
      ¬ ∃ 𝔭 : Ideal (𝓞 F), IsUsablePrime 𝔭 ∧ Nat.card (𝓞 F ⧸ 𝔭) = 7 := by
  -- clause (i) does not read connectedness (a generalization; `plans/FS131-w2-kernel-plan.md` § 15)
  have _ := hconn
  refine ⟨?_, ?_⟩
  · -- `χ(F²) ≤ 3` would make `E²`, hence `H`, 3-colourable
    by_contra h
    have h3 : ((unitDistance ℂ).induce (planeOver F)).chromaticNumber ≤ (3 : ℕ) := by
      by_contra h'
      refine h ?_
      have h4 := (ENat.add_one_le_iff (ENat.coe_ne_top 3)).2 (not_le.1 h')
      exact le_of_eq_of_le (by norm_num) h4
    rw [← chromaticNumber_planeOver_pureTranscendental_eq F t ht] at h3
    have hcol : (udOn V).Colorable (5 - 2) :=
      ((SimpleGraph.chromaticNumber_le_iff_colorable).1 h3).of_hom (SimpleGraph.induceHomOfLE _ hV).toHom
    exact not_falconerFan_of_colorable (by norm_num) hcol hfan
  · rintro ⟨𝔭, h𝔭, h7⟩
    obtain ⟨ρ⟩ := exists_hom_finitePlane_of_card F t ht h𝔭 (by norm_num : Nat.Prime 7) h7
    exact not_falconerFan_five_of_hom_slack hfan (ρ.comp (SimpleGraph.induceHomOfLE _ hV).toHom) finitePlane7_slack

/-- **FS129-SA1-FALC-RES**, clause (ii): at every usable prime with residue field `𝔽₁₁` or `𝔽₁₉`, for **every** pair
`(V, φ)` with PLACE-HOM's properties (the row: "with V and φ as in PLACE-HOM"), the tip minus the apex has coordinates in `V`
and `φ` kills them. -/
theorem falconerFan_five_placeHom (F : Subfield ℝ) [NumberField F] {n : ℕ} (t : Fin n → ℝ)
    (ht : AlgebraicIndependent F t) (W : Finset ℂ) (hW : (W : Set ℂ) ⊆ planeOver (pureTranscendental F t))
    (hconn : (udOn W).Connected) {a b : ℂ} (ha : a ∈ W) (hb : b ∈ W) (hfan : FalconerFan (udOn W) 5 ⟨a, ha⟩ ⟨b, hb⟩)
    {𝔭 : Ideal (𝓞 F)} (h𝔭 : IsUsablePrime 𝔭) (hq : Nat.card (𝓞 F ⧸ 𝔭) = 11 ∨ Nat.card (𝓞 F ⧸ 𝔭) = 19)
    (V : Subring ℝ) (φ : V →+* (𝓞 F ⧸ 𝔭)) (hφ : IsPlaceHom F 𝔭 (pureTranscendental F t) V φ) :
    ∃ (hre : (b - a).re ∈ V) (him : (b - a).im ∈ V), φ ⟨_, hre⟩ = 0 ∧ φ ⟨_, him⟩ = 0 := by
  -- clause (ii) reads only the pair's properties, not the transcendence of `t` (a generalization; § 15)
  have _ := ht
  haveI : 𝔭.IsMaximal := h𝔭.1
  have hsub := sub_mem_of_connected hφ.2.1 hW hconn ha
  obtain ⟨ρ, hρ⟩ := exists_hom_apex hφ hW hconn ha
  obtain ⟨hre, him⟩ := hsub b hb
  refine ⟨hre, him, ?_⟩
  have hρa : ρ ⟨a, ha⟩ = 0 := by
    obtain ⟨h1, h2⟩ := hsub a ha
    rw [hρ ⟨a, ha⟩ h1 h2]
    have e0 : (⟨((a : ℂ) - a).re, h1⟩ : V) = 0 := Subtype.ext (by simp)
    have e1 : (⟨((a : ℂ) - a).im, h2⟩ : V) = 0 := Subtype.ext (by simp)
    rw [e0, e1, map_zero]; rfl
  -- transport to `UD(𝔽_q, 2)` and land the tip on the apex
  have key : ∀ q : ℕ, q.Prime → Nat.card (𝓞 F ⧸ 𝔭) = q →
      (∀ w : ZMod q × ZMod q, w ≠ 0 → ∃ (C : (finitePlane q).Coloring (Fin 5)) (γ : Fin 5),
        FanGap C 0 γ ∧ C w ≠ C 0 ∧ C w ≠ γ) → ρ ⟨b, hb⟩ = 0 := by
    intro q hq hcard hfree
    obtain ⟨e⟩ := nonempty_ringEquiv_zmod_of_card hq hcard
    haveI : Fact q.Prime := ⟨hq⟩
    let ρ' : udOn W →g finitePlane q := (unitQuadrance.map e.toRingHom).comp ρ
    have ha' : ρ' ⟨a, ha⟩ = 0 := by
      show (e (ρ ⟨a, ha⟩).1, e (ρ ⟨a, ha⟩).2) = 0
      rw [hρa]; simp
    have hb' := tip_eq_zero_of_tipFree hfan ρ' ha' hfree
    have h1 : e (ρ ⟨b, hb⟩).1 = 0 := congrArg Prod.fst hb'
    have h2 : e (ρ ⟨b, hb⟩).2 = 0 := congrArg Prod.snd hb'
    exact Prod.ext (by simpa using h1) (by simpa using h2)
  have hb0 : ρ ⟨b, hb⟩ = 0 := by
    rcases hq with h11 | h19
    · exact key 11 (by norm_num) h11 finitePlane11_tipFree
    · exact key 19 (by norm_num) h19 finitePlane19_tipFree
  rw [hρ ⟨b, hb⟩ hre him] at hb0
  exact ⟨congrArg Prod.fst hb0, congrArg Prod.snd hb0⟩

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
