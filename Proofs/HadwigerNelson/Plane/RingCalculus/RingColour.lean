import Proofs.HadwigerNelson.Plane.RingCalculus.Star

/-!
# The colours of a ring's germs: constancy between change points, the sixth-of-a-turn swap (FS116-V6-RING, -WIN)

Job FS131-I8A (`plans/FS131-I8A-implementation.md`, Stage 4), for `ArcMap.v6_hubs` (`Plane/RingCalculus/Empty`).

On a covered Γ-free ring every germ lies in one colour class (`GammaFreeRing.exists_germIn`, from wave 3's
`germ_dichotomy`), of a colour absent at `p` (`not_mem_coloursAt_of_germIn`), and exactly two colours are absent
(`GammaFreeRing.exists_absent_pair`). A *germ colouring* `κ θ s` names the class of the germ on side `s` of `r(θ)`; the
lemmas below take it as data (`hκ : ∀ θ s, GermIn p θ s (F.region (κ θ s))`), so each is stated at the class it reads —
any ring all of whose germs lie in single classes:

* `germCol_const` (H4): with no change point strictly between `a` and `b`, the colour just counter-clockwise of `r(a)` is
  the colour just clockwise of `r(b)`.
* `germCol_rotate_ne` (H3): a sixth of a turn on, a germ's colour is another.
* `exists_isChangePoint_iff`: the change points are the points whose two germs differ in colour.
* with two colours: `germCol_change_rotate`, `germCol_change_int` (H5: change points are invariant under sixths of a
  turn), `exists_germCol_change` (H6: one exists), `exists_third_change` (two change points less than a sixth apart have
  a third in the window: FS116-V6-WIN's parity, by H4 twice — no count of points).

Spec: `halfPlane2`'s ring about `0` (`Plane/LocalMapExamples`, a Γ-free ring) at the end.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## Germs in one colour class -/

/-- A germ of a ring at a point of an open set lies in the set. -/
theorem germIn_of_mem_isOpen {O : Set ℂ} (hO : IsOpen O) {p : ℂ} {θ : ℝ} (h : ringPt p θ ∈ O) (s : Side) :
    GermIn p θ s O := by
  obtain ⟨ε, hε, hsub⟩ := Metric.isOpen_iff.mp hO _ h
  refine ⟨ε, hε, ?_⟩
  rintro _ ⟨t, ⟨ht0, ht1⟩, rfl⟩
  refine hsub (mem_ball.mpr (lt_of_le_of_lt ?_ ht1))
  rw [dist_comm]
  exact dist_ringPt_germ_le p θ s ht0.le

/-- One germ lies in at most one colour class. -/
theorem germIn_region_unique {p : ℂ} {θ : ℝ} {s : Side} {c c' : Fin k} (h : GermIn p θ s (F.region c))
    (h' : GermIn p θ s (F.region c')) : c = c' := by
  obtain ⟨δ, hδ, hsub⟩ := h.inter h'
  have hz := hsub ⟨δ / 2, ⟨by linarith, by linarith⟩, rfl⟩
  have h1 : F.col (ringPt p (θ + s.sign * (δ / 2))) = c := hz.1.2
  have h2 : F.col (ringPt p (θ + s.sign * (δ / 2))) = c' := hz.2.2
  exact h1.symm.trans h2

/-- **On a covered Γ-free ring every germ lies in one colour class** (the ring meets `Γ` in isolated points). -/
theorem GammaFreeRing.exists_germIn {p : ℂ} (hΓ : F.GammaFreeRing p) (hp : F.Covers p 1) (θ : ℝ) (s : Side) :
    ∃ c, GermIn p θ s (F.region c) := by
  rcases F.germ_dichotomy (hp (mem_closedBall.mpr (dist_ringPt p θ).le)) s with h | ⟨θ₁, θ₂, c, c', hA, -⟩
  · exact h
  · exact absurd hA (hΓ.not_isRingArc θ₁ θ₂ c c')

/-- The colour of a germ of the ring of `p` is absent at `p`. -/
theorem not_mem_coloursAt_of_germIn (hF : F.Valid) {p : ℂ} {θ : ℝ} {s : Side} {c : Fin k}
    (h : GermIn p θ s (F.region c)) : c ∉ F.coloursAt p := by
  obtain ⟨z, hzc, hz⟩ := GermIn.exists_mem_sphere h
  exact not_mem_coloursAt_of_mem_sphere hF hz hzc

/-- **A Γ-free ring of a vertex of at least four colours with at most two colours absent has exactly two absent**
(FS116-V6-RING: no (Q) arc, so `qfree4`). -/
theorem GammaFreeRing.exists_absent_pair {p : ℂ} (hΓ : F.GammaFreeRing p) (hF : F.Valid) (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hk : k ≤ (F.coloursAt p).ncard + 2) :
    ∃ X X', X ≠ X' ∧ (F.coloursAt p)ᶜ = {X, X'} := by
  have h1 := qfree4 hF hp h4 hΓ.qFreeRing
  have h2 := Set.ncard_add_ncard_compl (F.coloursAt p)
  rw [Nat.card_fin] at h2
  exact Set.ncard_eq_two.mp (by omega)

/-! ## A germ colouring of a ring

`κ θ s` names the colour class holding the germ on side `s` of `r(θ)`. The lemmas take the colouring as data, so they
are stated at the class they read: any ring every germ of which lies in one class. -/

section GermColouring

variable {p : ℂ} {κ : ℝ → Side → Fin k}

/-- The germ colouring is the only one. -/
theorem germCol_eq (hκ : ∀ θ s, GermIn p θ s (F.region (κ θ s))) {θ : ℝ} {s : Side} {c : Fin k}
    (h : GermIn p θ s (F.region c)) : κ θ s = c :=
  germIn_region_unique (hκ θ s) h

/-- Just counter-clockwise of `r(θ)` both germs carry the counter-clockwise colour of `r(θ)`. -/
theorem germCol_right (hκ : ∀ θ s, GermIn p θ s (F.region (κ θ s))) (θ : ℝ) :
    ∃ δ > 0, ∀ θ' ∈ Ioo θ (θ + δ), ∀ s, κ θ' s = κ θ .ccw := by
  obtain ⟨δ, hδ, hsub⟩ := hκ θ .ccw
  refine ⟨δ, hδ, fun θ' hθ' s => germCol_eq hκ (germIn_of_mem_isOpen (F.isOpen_region _) (hsub ?_) s)⟩
  exact ⟨θ' - θ, ⟨by linarith [hθ'.1], by linarith [hθ'.2]⟩, by simp [Side.sign]⟩

/-- Just clockwise of `r(θ)` both germs carry the clockwise colour of `r(θ)`. -/
theorem germCol_left (hκ : ∀ θ s, GermIn p θ s (F.region (κ θ s))) (θ : ℝ) :
    ∃ δ > 0, ∀ θ' ∈ Ioo (θ - δ) θ, ∀ s, κ θ' s = κ θ .cw := by
  obtain ⟨δ, hδ, hsub⟩ := hκ θ .cw
  refine ⟨δ, hδ, fun θ' hθ' s => germCol_eq hκ (germIn_of_mem_isOpen (F.isOpen_region _) (hsub ?_) s)⟩
  exact ⟨θ - θ', ⟨by linarith [hθ'.2], by linarith [hθ'.1]⟩, by simp [Side.sign]⟩

/-- **The ring's colour is constant between change points** (H4): if the two germs agree at every point strictly
between `a` and `b`, the colour just counter-clockwise of `r(a)` is the colour just clockwise of `r(b)`. -/
theorem germCol_const (hκ : ∀ θ s, GermIn p θ s (F.region (κ θ s))) {a b : ℝ} (hab : a < b)
    (hno : ∀ θ ∈ Ioo a b, κ θ .ccw = κ θ .cw) : κ a .ccw = κ b .cw := by
  have hcont : ContinuousOn (fun θ => κ θ .ccw) (Ioo a b) := by
    intro θ hθ
    refine ContinuousAt.continuousWithinAt ?_
    obtain ⟨δ₁, hδ₁, h1⟩ := germCol_right hκ θ
    obtain ⟨δ₂, hδ₂, h2⟩ := germCol_left hκ θ
    have hev : ∀ᶠ θ' in 𝓝 θ, κ θ' .ccw = κ θ .ccw := by
      filter_upwards [Ioo_mem_nhds (by linarith : θ - δ₂ < θ) (by linarith : θ < θ + δ₁)] with θ' hθ'
      rcases lt_trichotomy θ' θ with h | rfl | h
      · rw [h2 θ' ⟨hθ'.1, h⟩ .ccw, hno θ hθ]
      · rfl
      · exact h1 θ' ⟨h, hθ'.2⟩ .ccw
    exact continuousAt_const.congr (hev.mono fun θ' h => h.symm)
  obtain ⟨δ₁, hδ₁, h1⟩ := germCol_right hκ a
  obtain ⟨δ₂, hδ₂, h2⟩ := germCol_left hκ b
  have hm₁ : a + min δ₁ (b - a) / 2 ∈ Ioo a b := by
    have := lt_min hδ₁ (sub_pos.mpr hab)
    have := min_le_right δ₁ (b - a)
    constructor <;> linarith
  have hm₂ : b - min δ₂ (b - a) / 2 ∈ Ioo a b := by
    have := lt_min hδ₂ (sub_pos.mpr hab)
    have := min_le_right δ₂ (b - a)
    constructor <;> linarith
  have e1 : κ (a + min δ₁ (b - a) / 2) .ccw = κ a .ccw := by
    refine h1 _ ⟨hm₁.1, ?_⟩ .ccw
    have := min_le_left δ₁ (b - a)
    linarith
  have e2 : κ (b - min δ₂ (b - a) / 2) .cw = κ b .cw := by
    refine h2 _ ⟨?_, hm₂.2⟩ .cw
    have := min_le_left δ₂ (b - a)
    linarith
  have e3 : κ (a + min δ₁ (b - a) / 2) .ccw = κ (b - min δ₂ (b - a) / 2) .ccw :=
    isPreconnected_Ioo.constant hcont hm₁ hm₂
  rw [← e1, e3, hno _ hm₂, e2]

/-- **A sixth of a turn on, the germ's colour is another** (two ring points `60°` apart are `1` apart). -/
theorem germCol_rotate_ne (hF : F.Valid) (hκ : ∀ θ s, GermIn p θ s (F.region (κ θ s))) (θ : ℝ) (s : Side) :
    κ (θ + π / 3) s ≠ κ θ s := fun h =>
  not_germIn_closure_rotate hF p θ s (κ θ s)
    ⟨(hκ θ s).mono subset_closure, (h ▸ hκ (θ + π / 3) s).mono subset_closure⟩

/-- **Change points are the points where the two germs' colours differ.** -/
theorem exists_isChangePoint_iff (hp : F.Covers p 1) (hκ : ∀ θ s, GermIn p θ s (F.region (κ θ s))) (ψ : ℝ) :
    (∃ X X', F.IsChangePoint p ψ X X') ↔ κ ψ .ccw ≠ κ ψ .cw := by
  constructor
  · rintro ⟨X, X', -, hne, h1, h2⟩
    rw [germCol_eq hκ h1, germCol_eq hκ h2]
    exact hne
  · intro h
    refine ⟨κ ψ .ccw, κ ψ .cw, ?_, h, hκ ψ .ccw, hκ ψ .cw⟩
    by_contra hΓ
    have hI : ringPt p ψ ∈ F.interiorPts :=
      mem_interiorPts_of_notMem_Γ (hp (mem_closedBall.mpr (dist_ringPt p ψ).le)) hΓ
    have hreg : ringPt p ψ ∈ F.region (F.col (ringPt p ψ)) := ⟨hI, rfl⟩
    exact h ((germCol_eq hκ (germIn_of_mem_isOpen (F.isOpen_region _) hreg .ccw)).trans
      (germCol_eq hκ (germIn_of_mem_isOpen (F.isOpen_region _) hreg .cw)).symm)

/-! ### Two colours -/

/-- With two colours on the ring, a sixth of a turn swaps them: change points go to change points (H5). -/
theorem germCol_change_rotate (hF : F.Valid) (hκ : ∀ θ s, GermIn p θ s (F.region (κ θ s))) {X X' : Fin k}
    (hr : ∀ θ s, κ θ s = X ∨ κ θ s = X') (θ : ℝ) :
    κ (θ + π / 3) .ccw ≠ κ (θ + π / 3) .cw ↔ κ θ .ccw ≠ κ θ .cw := by
  have h1 := germCol_rotate_ne hF hκ θ .ccw
  have h2 := germCol_rotate_ne hF hκ θ .cw
  rcases hr θ .ccw with a | a <;> rcases hr θ .cw with b | b <;> rcases hr (θ + π / 3) .ccw with c | c <;>
    rcases hr (θ + π / 3) .cw with d | d <;> simp_all

/-- Change points are invariant under every multiple of a sixth of a turn. -/
theorem germCol_change_int (hF : F.Valid) (hκ : ∀ θ s, GermIn p θ s (F.region (κ θ s))) {X X' : Fin k}
    (hr : ∀ θ s, κ θ s = X ∨ κ θ s = X') (θ : ℝ) (n : ℤ) :
    κ (θ + n * (π / 3)) .ccw ≠ κ (θ + n * (π / 3)) .cw ↔ κ θ .ccw ≠ κ θ .cw := by
  induction n using Int.induction_on with
  | zero => simp
  | succ i ih =>
    rw [← ih, ← germCol_change_rotate hF hκ hr (θ + (i : ℤ) * (π / 3))]
    rw [show θ + ((i : ℤ) : ℝ) * (π / 3) + π / 3 = θ + (((i : ℤ) + 1 : ℤ) : ℝ) * (π / 3) by push_cast; ring]
  | pred i ih =>
    rw [← ih, ← germCol_change_rotate hF hκ hr (θ + ((-(i : ℤ) - 1 : ℤ) : ℝ) * (π / 3))]
    rw [show θ + ((-(i : ℤ) - 1 : ℤ) : ℝ) * (π / 3) + π / 3 = θ + ((-(i : ℤ) : ℤ) : ℝ) * (π / 3) by push_cast; ring]

/-- **A change point exists** (H6): a ring with no change point is one colour, against the sixth-of-a-turn swap. -/
theorem exists_germCol_change (hF : F.Valid) (hκ : ∀ θ s, GermIn p θ s (F.region (κ θ s))) :
    ∃ ψ, κ ψ .ccw ≠ κ ψ .cw := by
  by_contra h
  push Not at h
  have h1 := germCol_const hκ (a := 0) (b := 0 + π / 3) (by linarith [Real.pi_pos]) fun θ _ => h θ
  exact germCol_rotate_ne hF hκ 0 .ccw ((h _).trans h1.symm)

/-- **Two change points less than a sixth of a turn apart have a third in the window** (the parity of FS116-V6-WIN, by
H4 twice): otherwise the colour just clockwise of `r(ψ₁ + 60°)` would be the colour just clockwise of `r(ψ₁)`. -/
theorem exists_third_change (hF : F.Valid) (hκ : ∀ θ s, GermIn p θ s (F.region (κ θ s))) {X X' : Fin k}
    (hr : ∀ θ s, κ θ s = X ∨ κ θ s = X') {ψ₁ ψ₂ : ℝ} (h₁ : κ ψ₁ .ccw ≠ κ ψ₁ .cw) (h₂ : κ ψ₂ .ccw ≠ κ ψ₂ .cw)
    (h12 : ψ₁ < ψ₂) (hlt : ψ₂ < ψ₁ + π / 3) :
    ∃ ψ₃ ∈ Ioo ψ₁ (ψ₁ + π / 3), ψ₃ ≠ ψ₂ ∧ κ ψ₃ .ccw ≠ κ ψ₃ .cw := by
  by_contra h
  push Not at h
  have e1 := germCol_const hκ h12 fun θ hθ => h θ ⟨hθ.1, by linarith [hθ.2]⟩ (ne_of_lt hθ.2)
  have e2 := germCol_const hκ hlt fun θ hθ => h θ ⟨by linarith [hθ.1], hθ.2⟩ (ne_of_gt hθ.1)
  have h3 := germCol_rotate_ne hF hκ ψ₁ .cw
  rcases hr ψ₁ .ccw with a | a <;> rcases hr ψ₁ .cw with b | b <;> rcases hr ψ₂ .ccw with c | c <;>
    rcases hr ψ₂ .cw with d | d <;> rcases hr (ψ₁ + π / 3) .cw with f | f <;> simp_all

end GermColouring

end ArcMap

end HadwigerNelson.Plane

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Spec examples -/

/-- `halfPlane2` covers the closed unit disc about `0`. -/
theorem halfPlane2_covers : halfPlane2.Covers 0 1 := fun z hz =>
  show z ∈ ball (0 : ℂ) 2 from mem_ball.mpr (lt_of_le_of_lt (mem_closedBall.mp hz) one_lt_two)

/-- **Inhabitant**: on `halfPlane2`'s Γ-free ring every germ lies in one colour class. -/
example (θ : ℝ) (s : Side) : ∃ c, GermIn 0 θ s (halfPlane2.region c) :=
  halfPlane2_gammaFreeRing.exists_germIn halfPlane2_covers θ s

/-- On `halfPlane2`'s ring any germ colouring changes at `r(0)`, its change point (colours `1` above, `0` below). -/
example {κ : ℝ → Side → Fin 2} (hκ : ∀ θ s, GermIn 0 θ s (halfPlane2.region (κ θ s))) : κ 0 .ccw ≠ κ 0 .cw :=
  (ArcMap.exists_isChangePoint_iff halfPlane2_covers hκ 0).mp ⟨1, 0, halfPlane2_isChangePoint⟩

/-- **Adversary**: `halfPlane2` is not valid, and `germCol_rotate_ne` — the one lemma here that reads validity — fails on
it: a germ colouring is constant on the upper half of its ring, so equal at `r(60°)` and `r(120°)`. -/
example {κ : ℝ → Side → Fin 2} (hκ : ∀ θ s, GermIn 0 θ s (halfPlane2.region (κ θ s))) : ¬ halfPlane2.Valid := fun hF => by
  have hπ := Real.pi_pos
  have key : ∀ θ : ℝ, 0 < θ → θ < π → κ θ .ccw = κ θ .cw := by
    intro θ h0 h1
    by_contra hne
    obtain ⟨X, X', hy⟩ := (ArcMap.exists_isChangePoint_iff halfPlane2_covers hκ θ).mpr hne
    have him := halfPlane2_im_eq_zero_of_mem_Γ hy.1
    have hs : Real.sin θ = 0 := by simpa [ringPt, e_eq, Complex.sin_ofReal_re, Complex.cos_ofReal_re] using him
    have := Real.sin_pos_of_pos_of_lt_pi h0 h1
    linarith
  have h1 := ArcMap.germCol_const hκ (a := π / 3) (b := π / 3 + π / 3) (by linarith)
    fun θ hθ => key θ (by linarith [hθ.1]) (by linarith [hθ.2])
  exact ArcMap.germCol_rotate_ne hF hκ (π / 3) .ccw (by rw [key (π / 3 + π / 3) (by linarith) (by linarith), h1])

end HadwigerNelson.Plane
