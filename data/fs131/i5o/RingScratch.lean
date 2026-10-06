import Proofs.HadwigerNelson.Plane.RingBand
import Proofs.HadwigerNelson.Plane.ValidMap.HexRing

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **A finite ring carries no arc of `Γ`** (`bv_l3`'s step 1): an arc of `Γ` on `ω(p)` of positive length is infinite, so a ring meeting
`Γ` in finitely many points (`RingProper`'s first clause) carries none. -/
theorem not_onRingArc_of_finite {p : ℂ} (h : (F.Γ ∩ sphere p 1).Finite) (x : ℂ) : ¬ F.OnRingArc p x := by
  rintro ⟨θ₁, θ₂, h12, -, hsub⟩
  have hπ := Real.pi_pos
  set b := min θ₂ (θ₁ + π) with hb
  have hab : θ₁ < b := lt_min h12 (by linarith)
  have hinj : InjOn (ringPt p) (Ioo θ₁ b) := by
    intro s hs s' hs' hss
    have hss' : spherePt p 1 s = spherePt p 1 s' := by simpa [spherePt, ringPt] using hss
    exact injOn_spherePt p one_pos θ₁ ⟨hs.1, by linarith [hs.2, min_le_right θ₂ (θ₁ + π)]⟩
      ⟨hs'.1, by linarith [hs'.2, min_le_right θ₂ (θ₁ + π)]⟩ hss'
  refine ((Ioo_infinite hab).image hinj) (h.subset ?_)
  rintro _ ⟨t, ht, rfl⟩
  exact ⟨hsub ⟨t, ⟨ht.1.le, by linarith [ht.2, min_le_left θ₂ (θ₁ + π)]⟩, rfl⟩, ringPt_mem_sphere p t⟩

/-- **The ring colouring's one-sided values are germs of the map** (the bridge back from `ringCircleColouring`): if the ring colouring
takes the value `a` just before `x` (resp. after), the germ of `ω(p)` on the clockwise (resp. counter-clockwise) side of `r(x)` lies in
one colour's class, a colour absent at `p` that `g` sends to `a`. -/
theorem ringCircle_val_germ (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (hno : ∀ x, ¬ F.OnRingArc p x) (g : Fin k → ZMod 3)
    (hg : Set.InjOn g (F.coloursAt p)ᶜ) {x : ℝ} {a : ZMod 3} (s : Side)
    (h : (s = .cw ∧ (F.ringCircleColouring hF hp hno g hg).LeftVal x a) ∨
      (s = .ccw ∧ (F.ringCircleColouring hF hp hno g hg).RightVal x a)) :
    ∃ X, g X = a ∧ X ∉ F.coloursAt p ∧ GermIn p x s (F.region X) := by
  set C := F.ringCircleColouring hF hp hno g hg with hC
  obtain ⟨l, r, hlr, hlx, hxr, hsub⟩ : ∃ l r, l < r ∧ (s = .cw → r = x) ∧ (s = .ccw → l = x) ∧
      ∀ θ ∈ Ioo l r, θ ∉ C.S ∧ C.c θ = a := by
    rcases h with ⟨rfl, h⟩ | ⟨rfl, h⟩
    · obtain ⟨l, hl, hs⟩ := mem_nhdsLT_iff_exists_Ioo_subset.mp ((C.eventually_notMem_S_lt x).and h)
      exact ⟨l, x, hl, fun _ => rfl, fun h => absurd h (by decide), fun θ hθ => hs hθ⟩
    · obtain ⟨r, hr, hs⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp ((C.eventually_notMem_S_gt x).and h)
      exact ⟨x, r, hr, fun h => absurd h (by decide), fun _ => rfl, fun θ hθ => hs hθ⟩
  have hint : ∀ θ ∈ Ioo l r, ringPt p θ ∈ F.interiorPts := fun θ hθ =>
    F.mem_interiorPts_of_notMem_Γ (hp (sphere_subset_closedBall (ringPt_mem_sphere p θ))) (hsub θ hθ).1
  have habs : ∀ θ ∈ Ioo l r, F.col (ringPt p θ) ∉ F.coloursAt p := fun θ hθ =>
    not_mem_coloursAt_of_mem_sphere hF (ringPt_mem_sphere p θ) ⟨hint θ hθ, rfl⟩
  obtain ⟨θ₀, hθ₀⟩ : ∃ θ₀, θ₀ ∈ Ioo l r := ⟨(l + r) / 2, by constructor <;> linarith⟩
  refine ⟨F.col (ringPt p θ₀), (hsub θ₀ hθ₀).2, habs θ₀ hθ₀, r - l, by linarith, ?_⟩
  rintro _ ⟨t, ht, rfl⟩
  have hθ : x + s.sign * t ∈ Ioo l r := by
    cases s
    · have := hlx rfl; simp only [Side.sign]; constructor <;> linarith [ht.1, ht.2]
    · have := hxr rfl; simp only [Side.sign]; constructor <;> linarith [ht.1, ht.2]
  refine ⟨hint _ hθ, ?_⟩
  show F.col (ringPt p (x + s.sign * t)) = F.col (ringPt p θ₀)
  exact hg (habs _ hθ) (habs θ₀ hθ₀) ((hsub _ hθ).2.trans (hsub θ₀ hθ₀).2.symm)

/-- **A proper ring has no swap point** (`bv_l3`'s step 3, for the band lemma): a swap of the ring colouring at `x` gives two change
points `r(x)`, `r(x ± π/3)` of `ω(p)`, at distance `1`, switching between one pair of colours (read back on the map's germs by
`ringCircle_val_germ`), against `RingProper`'s second clause. The two values differ because the clockwise germs at the two points are at
distance `1` (validity). -/
theorem ringCircle_noSwap (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (hR : F.RingProper p) (g : Fin k → ZMod 3)
    (hg : Set.InjOn g (F.coloursAt p)ᶜ) (x : ℝ) :
    ¬ (ringCircleColouring hF hp (not_onRingArc_of_finite hR.1) g hg).IsSwap x := by
  set C := ringCircleColouring hF hp (not_onRingArc_of_finite hR.1) g hg with hC
  rintro ⟨hxS, a, b, ha, hb, h⟩
  have hπ := Real.pi_pos
  have hno := not_onRingArc_of_finite (F := F) hR.1
  have main : ∀ y, |x - y| = π / 3 → C.LeftVal y b → C.RightVal y a → False := by
    intro y hxy hl hr
    have hd : dist (ringPt p x) (ringPt p y) = 1 :=
      ((dist_ringPt_ringPt_cmp_one p (by rw [hxy]; linarith)).1).mpr hxy
    obtain ⟨X', hX'a, hX'u, hX'g⟩ := ringCircle_val_germ hF hp hno g hg .cw (Or.inl ⟨rfl, ha⟩)
    obtain ⟨X, hXb, hXu, hXg⟩ := ringCircle_val_germ hF hp hno g hg .ccw (Or.inr ⟨rfl, hb⟩)
    obtain ⟨Y', hY'b, hY'u, hY'g⟩ := ringCircle_val_germ hF hp hno g hg .cw (Or.inl ⟨rfl, hl⟩)
    obtain ⟨Y, hYa, hYu, hYg⟩ := ringCircle_val_germ hF hp hno g hg .ccw (Or.inr ⟨rfl, hr⟩)
    -- the two values differ: the clockwise germs at `x` and `y` are `1` apart
    have hab : a ≠ b := by
      rintro rfl
      have hXY : X' = Y' := hg hX'u hY'u (hX'a.trans hY'b.symm)
      obtain ⟨δ₁, hδ₁, hs₁⟩ := hX'g
      obtain ⟨δ₂, hδ₂, hs₂⟩ := hY'g
      set t := min δ₁ δ₂ / 2 with ht
      have ht0 : 0 < t := by positivity
      have ht1 : t < δ₁ := by have := min_le_left δ₁ δ₂; linarith
      have ht2 : t < δ₂ := by have := min_le_right δ₁ δ₂; linarith
      have hz := hs₁ ⟨t, ⟨ht0, ht1⟩, rfl⟩
      have hw := hs₂ ⟨t, ⟨ht0, ht2⟩, rfl⟩
      have hdd : dist (ringPt p (x + Side.cw.sign * t)) (ringPt p (y + Side.cw.sign * t)) = 1 := by
        have : |(x + Side.cw.sign * t) - (y + Side.cw.sign * t)| = π / 3 := by
          rw [show (x + Side.cw.sign * t) - (y + Side.cw.sign * t) = x - y by ring]; exact hxy
        exact ((dist_ringPt_ringPt_cmp_one p (by rw [this]; linarith)).1).mpr this
      rw [hXY] at hz
      exact hF _ hz.1 _ hw.1 hdd (hz.2.trans hw.2.symm)
    have hyS : y ∈ C.S := by
      by_contra hyS
      have hc := C.locallyConstant y hyS
      have h1 : C.LeftVal y (C.c y) := hc.filter_mono nhdsWithin_le_nhds
      have h2 : C.RightVal y (C.c y) := hc.filter_mono nhdsWithin_le_nhds
      exact hab ((CircleColouring.RightVal.unique hr h2).trans (CircleColouring.LeftVal.unique hl h1).symm)
    have hXX : X ≠ X' := fun h' => hab (hX'a.symm.trans (h' ▸ hXb))
    have hYY : Y ≠ Y' := fun h' => hab (hYa.symm.trans (h' ▸ hY'b))
    have e1 : X = Y' := hg hXu hY'u (hXb.trans hY'b.symm)
    have e2 : X' = Y := hg hX'u hYu (hX'a.trans hYa.symm)
    refine hR.2 x y X X' Y Y' hd ⟨hxS, hXX, hXg, hX'g⟩ ⟨hyS, hYY, hYg, hY'g⟩ ?_
    rw [e1, e2, Set.pair_comm]
  rcases h with ⟨hl, hr⟩ | ⟨hl, hr⟩
  · exact main _ (by rw [show x - (x + π / 3) = -(π / 3) by ring, abs_neg, abs_of_pos (by positivity)]) hl hr
  · exact main _ (by rw [show x - (x - π / 3) = π / 3 by ring, abs_of_pos (by positivity)]) hl hr

end ArcMap

end HadwigerNelson.Plane
