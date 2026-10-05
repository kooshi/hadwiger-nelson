import Proofs.HadwigerNelson.Plane.ValidMap.Contact
import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc

/-!
# The flanks of a horn with unit-arc bounds: shadows, sources, half-planes (FS114-CV § 1.4's re-derivation of N4-STUCK (ii))

Wave 5's unit-arc versions of wave 4's flank lemmas (`Plane/ValidMap/Contact`'s `shaveAvailable_of_not_doublyShadowed`,
`flank_ne_of_doublyShadowed`, `outType_S_of_shadow`, `outType_N_of_shadow`), which assume Condition 5 or curvatures in `(−1, 1)`.
Here a horn along `e α` has bounding curvatures in `[−1, 1]` and no Condition 5 is read. Frames as in wave 4: `n = e (α + π/2)`,
`N = v + n`, `S′ = v − n`.

* **No SHAVE, read directly** (`shadow_of_not_shave`): a horn whose tip is clear for one flank colour near `v` is shaved into that colour
  (the split arc at the horn's own bound), so at a vertex with no SHAVE each flank colour shadows the horn at every scale. No curvature
  function `σ` and no Condition 5 are needed for this direction.
* **The sources** (`srcG_of_shadow`, `srcH_of_shadow`): a shadow of the upper flank's colour comes from an in-type contact at `N` or an
  out-type one at `S′` (`shadow_source_near_poles` localizes it at a pole; at `κ₂ < 1` it is `S′`, `horn_shadow_near_S`; at `κ₂ = 1` the
  flank lies in `B(N, 1)`, so a contact at `N` is not out-type, `not_outType_N_of_flankAbove_one`); the lower flank is the mirror.
* **Their half-planes** (`dot_nonneg_of_srcG`, `dot_nonpos_of_srcH`): the allowed cone lies in `d·n ≥ 0`, resp. `d·n ≤ 0`; and the class
  near `v` stays out of `B(S′, 1)`, resp. `B(N, 1)` (`region_far_S_of_srcG`, `region_far_N_of_srcH`; an in-type contact by
  `region_near_of_inType`).
* **The two flanks differ** (`flank_ne_of_shadows`): one colour on both flanks would be out-type at both poles, so it shadows the tip from
  neither.
* **One sector** (`hasSectors_one_of_contacts`): a colour whose contacts all lie in the half-plane form of one direction `u` has `u` inside
  its allowed cone, so with no MERGE it has one sector.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **An angular interval shorter than `π` holds no antipodal pair**: `β` and `β + π` are never both in `angleIcc a b` when
`b − a < π` (CV-L0's "no cone of angle `< π` holds both horns"). -/
theorem not_mem_angleIcc_add_pi {a b β : ℝ} (hab : b - a < π) (hβ : β ∈ angleIcc a b) : β + π ∉ angleIcc a b := by
  intro hβ'
  have hπ := Real.pi_pos
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp hβ
  obtain ⟨m', hm1', hm2'⟩ := mem_iUnion.mp hβ'
  rcases lt_trichotomy m' m with h | h | h
  · have : (m' : ℝ) + 1 ≤ m := by exact_mod_cast h
    nlinarith
  · subst h
    linarith
  · have : (m : ℝ) + 1 ≤ m' := by exact_mod_cast h
    nlinarith

example : (0 : ℝ) ∈ angleIcc (-1) 1 := mem_iUnion.mpr ⟨0, by simp, by simp⟩


/-- **No SHAVE: each flank colour shadows the horn at every scale.** If the tip of a horn were clear for its upper flank's colour `g`
near `v`, SHAVE would be available with the split arc at the lower bound (`σ = κ₁`: the whole tip recoloured `g`); for the lower flank
`h`, at the upper bound (`σ = κ₂`). No curvature bound and no Condition 5 are read. Inhabitant of the hypotheses: `bowtie` at `0`
(`bowtie_isStuck`, `bowtie_isHorn`, `bowtie_flanks`, in `Plane/ValidMap/BaseSteps`). -/
theorem shadow_of_not_shave {v : ℂ} {α κ₁ κ₂ : ℝ} {c g h : Fin k} (hSh : ¬ F.ShaveAvailable v)
    (hH : F.IsHorn v α κ₁ κ₂ c) (hg : F.IsFlankAbove v α κ₂ g) (hh : F.IsFlankBelow v α κ₁ h) :
    (∀ ρ > 0, ∃ z ∈ hornSet v α κ₁ κ₂ ρ, z ∈ shadow (F.region g)) ∧
      ∀ ρ > 0, ∃ z ∈ hornSet v α κ₁ κ₂ ρ, z ∈ shadow (F.region h) := by
  constructor
  · intro ρ hρ
    by_contra hno
    push Not at hno
    refine hSh ⟨c, g, h, α, κ₁, κ₂, κ₁, hH, hg, hh, le_rfl, hH.1.le, ?_⟩
    filter_upwards [Ioo_mem_nhdsGT hρ] with r hr z hz
    exact ⟨fun _ y hy hzy => hno z (hornSet_mono_radius hr.2.le hz) ⟨y, hy, hzy⟩, fun hA => absurd hz.2.2.1 hA⟩
  · intro ρ hρ
    by_contra hno
    push Not at hno
    refine hSh ⟨c, g, h, α, κ₁, κ₂, κ₂, hH, hg, hh, hH.1.le, le_rfl, ?_⟩
    filter_upwards [Ioo_mem_nhdsGT hρ] with r hr z hz
    exact ⟨fun hA => absurd hz.2.2.2 (lt_asymm hA), fun _ y hy hzy => hno z (hornSet_mono_radius hr.2.le hz) ⟨y, hy, hzy⟩⟩

/-- **An upper flank on `ω(N)` is never out-type at `N`**: at `κ₂ = 1` the flank lies inside `B(N, 1)`, so a tile of its colour at `N`
is unit-near the flank, hence within `1` of `v` — and an out-type tile misses `B̄(v, 1)`. Inhabitant of the hypotheses: `bowtie` at
`0`, `α = 0` (`bowtie_flanks`, `bowtie_inType`: its `g` is in-type at `N = i`). -/
theorem not_outType_N_of_flankAbove_one (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α : ℝ} {g : Fin k}
    (hg : F.IsFlankAbove v α 1 g) (hNcl : v + e (α + π / 2) ∈ closure (F.region g)) :
    ¬ F.OutType v g (v + e (α + π / 2)) := by
  intro hout
  have hNv : dist (v + e (α + π / 2)) v = 1 := by rw [dist_eq_norm, add_sub_cancel_left, norm_e]
  have hNdom : v + e (α + π / 2) ∈ F.dom := hv (by rw [mem_closedBall, hNv])
  obtain ⟨T, hT, hNT⟩ := (F.mem_coloursAt_iff_exists_tileOf hNdom).mp hNcl
  obtain ⟨t, ht⟩ := hT.1.nonempty
  have htv : 1 < dist t v := by
    by_contra hle
    push Not at hle
    exact (hout T hT hNT).ne_of_mem ht (mem_closedBall.mpr hle) rfl
  obtain ⟨κ', hκ', hev⟩ := hg
  obtain ⟨p, hpg, hp⟩ := exists_mem_hornSet_near hκ' hev (show 0 < dist t v - 1 by linarith)
  have hpN : dist p (v + e (α + π / 2)) < 1 := (tanAbove_one_iff v α p).mp hp.2.2.1
  obtain ⟨y, hy, hyd⟩ := Metric.mem_closure_iff.mp hNT (1 - dist p (v + e (α + π / 2))) (by linarith)
  have hpy : dist p y < 1 := by have := dist_triangle p (v + e (α + π / 2)) y; linarith
  have hpt : 1 < dist p t := by
    have := dist_triangle t p v
    rw [dist_comm t p] at this
    linarith [hp.1]
  obtain ⟨hAp, hpA⟩ := tileOf_component hpg
  exact false_of_pole hF hT hAp (subset_closure ht) hy hpA hpt hpy

/-- **A lower flank on `ω(S′)` is never out-type at `S′`** (the mirror of `not_outType_N_of_flankAbove_one`). Inhabitant of the
hypotheses: `bowtie` at `0`, `α = 0` (`bowtie_flanks`, `bowtie_inType`: its `h` is in-type at `S′ = −i`). -/
theorem not_outType_S_of_flankBelow_neg_one (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α : ℝ} {h : Fin k}
    (hh : F.IsFlankBelow v α (-1) h) (hScl : v - e (α + π / 2) ∈ closure (F.region h)) :
    ¬ F.OutType v h (v - e (α + π / 2)) := by
  intro hout
  have hSv : dist (v - e (α + π / 2)) v = 1 := by rw [dist_eq_norm, sub_sub_cancel_left, norm_neg, norm_e]
  have hSdom : v - e (α + π / 2) ∈ F.dom := hv (by rw [mem_closedBall, hSv])
  obtain ⟨T, hT, hST⟩ := (F.mem_coloursAt_iff_exists_tileOf hSdom).mp hScl
  obtain ⟨t, ht⟩ := hT.1.nonempty
  have htv : 1 < dist t v := by
    by_contra hle
    push Not at hle
    exact (hout T hT hST).ne_of_mem ht (mem_closedBall.mpr hle) rfl
  obtain ⟨κ', hκ', hev⟩ := hh
  obtain ⟨p, hph, hp⟩ := exists_mem_hornSet_near hκ' hev (show 0 < dist t v - 1 by linarith)
  have hpS : dist p (v - e (α + π / 2)) < 1 := (tanBelow_neg_one_iff v α p).mp hp.2.2.2
  obtain ⟨y, hy, hyd⟩ := Metric.mem_closure_iff.mp hST (1 - dist p (v - e (α + π / 2))) (by linarith)
  have hpy : dist p y < 1 := by have := dist_triangle p (v - e (α + π / 2)) y; linarith
  have hpt : 1 < dist p t := by
    have := dist_triangle t p v
    rw [dist_comm t p] at this
    linarith [hp.1]
  obtain ⟨hAp, hpA⟩ := tileOf_component hph
  exact false_of_pole hF hT hAp (subset_closure ht) hy hpA hpt hpy

/-- **The upper flank's shadow comes from a `+n` source**: if the colour `g` above a horn with bounds in `[−1, 1]` shadows the horn at
every scale, then `g` has an in-type contact at `N` or an out-type contact at `S′` (FS114-CV § 1.4: "in-type at `N` or out-type at `S`";
at `κ₂ < 1` the second, by `horn_shadow_near_S`). Inhabitant of the hypotheses: `bowtie` at `0`, `α = 0` (`bowtie_flanks`; its tip is
in the shadow of both flanks, `bowtie_doublyShadowed`). -/
theorem srcG_of_shadow (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {g : Fin k}
    (h1 : -1 ≤ κ₁) (h12 : κ₁ < κ₂) (h2 : κ₂ ≤ 1) (hg : F.IsFlankAbove v α κ₂ g)
    (hsh : ∀ ρ > 0, ∃ z ∈ hornSet v α κ₁ κ₂ ρ, z ∈ shadow (F.region g)) :
    (F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2))) ∨
      (F.IsContact v g (v - e (α + π / 2)) ∧ F.OutType v g (v - e (α + π / 2))) := by
  have hgv : g ∈ F.coloursAt v := mem_closure_of_mem_coneAt hg.mem_coneAt
  have hNv : dist (v + e (α + π / 2)) v = 1 := by rw [dist_eq_norm, add_sub_cancel_left, norm_e]
  have hSv : dist (v - e (α + π / 2)) v = 1 := by rw [dist_eq_norm, sub_sub_cancel_left, norm_neg, norm_e]
  have hS : v - e (α + π / 2) ∈ closure (F.region g) →
      F.IsContact v g (v - e (α + π / 2)) ∧ F.OutType v g (v - e (α + π / 2)) := fun hScl =>
    ⟨⟨hgv, hSv, hScl⟩, outType_S_of_mem_closure hF hv (by linarith) hg hScl⟩
  rcases lt_or_eq_of_le h2 with h2' | rfl
  · -- `κ₂ < 1`: the shadow comes from near `S′`
    right
    apply hS
    rw [Metric.mem_closure_iff]
    intro ε hε
    obtain ⟨ρ, hρ, hloc⟩ := horn_shadow_near_S hF hv h1 h2' hg hε
    obtain ⟨z, hz, y, hy, hzy⟩ := hsh ρ hρ
    exact ⟨y, hy, by rw [dist_comm]; exact hloc z hz y hy hzy⟩
  · -- `κ₂ = 1`: from near `N` or near `S′`
    have hpole : v + e (α + π / 2) ∈ closure (F.region g) ∨ v - e (α + π / 2) ∈ closure (F.region g) := by
      by_contra hno
      push Not at hno
      obtain ⟨hN', hS'⟩ := hno
      rw [Metric.mem_closure_iff] at hN' hS'
      push Not at hN' hS'
      obtain ⟨δN, hδN, hfN⟩ := hN'
      obtain ⟨δS, hδS, hfS⟩ := hS'
      obtain ⟨ρ, hρ, hloc⟩ := shadow_source_near_poles hF hv hgv (coneAt_subset_allowedCone hF hv hg.mem_coneAt)
        (lt_min hδN hδS)
      obtain ⟨z, hz, y, hy, hzy⟩ := hsh ρ hρ
      rcases hloc z hz.1 hz.2.1 (abs_frameY_le_of_mem_hornSet h1 le_rfl hz) y hy hzy with hyN | hyS
      · have := hfN y hy
        rw [dist_comm] at this
        linarith [min_le_left δN δS]
      · have := hfS y hy
        rw [dist_comm] at this
        linarith [min_le_right δN δS]
    rcases hpole with hNcl | hScl
    · have hcont : F.IsContact v g (v + e (α + π / 2)) := ⟨hgv, hNv, hNcl⟩
      rcases (contact_inType_or_outType hF hv hcont).1 with hin | hout
      · exact Or.inl ⟨hcont, hin⟩
      · exact absurd hout (not_outType_N_of_flankAbove_one hF hv hg hNcl)
    · exact Or.inr (hS hScl)

/-- **The lower flank's shadow comes from a `−n` source** (the mirror of `srcG_of_shadow`): an in-type contact at `S′` or an out-type
contact at `N`. Inhabitant of the hypotheses: `bowtie` at `0`, `α = 0` (`bowtie_flanks`, `bowtie_doublyShadowed`). -/
theorem srcH_of_shadow (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {h : Fin k}
    (h1 : -1 ≤ κ₁) (h12 : κ₁ < κ₂) (h2 : κ₂ ≤ 1) (hh : F.IsFlankBelow v α κ₁ h)
    (hsh : ∀ ρ > 0, ∃ z ∈ hornSet v α κ₁ κ₂ ρ, z ∈ shadow (F.region h)) :
    (F.IsContact v h (v - e (α + π / 2)) ∧ F.InType v h (v - e (α + π / 2))) ∨
      (F.IsContact v h (v + e (α + π / 2)) ∧ F.OutType v h (v + e (α + π / 2))) := by
  have hhv : h ∈ F.coloursAt v := mem_closure_of_mem_coneAt hh.mem_coneAt
  have hNv : dist (v + e (α + π / 2)) v = 1 := by rw [dist_eq_norm, add_sub_cancel_left, norm_e]
  have hSv : dist (v - e (α + π / 2)) v = 1 := by rw [dist_eq_norm, sub_sub_cancel_left, norm_neg, norm_e]
  have hN : v + e (α + π / 2) ∈ closure (F.region h) →
      F.IsContact v h (v + e (α + π / 2)) ∧ F.OutType v h (v + e (α + π / 2)) := fun hNcl =>
    ⟨⟨hhv, hNv, hNcl⟩, outType_N_of_mem_closure hF hv (by linarith) hh hNcl⟩
  rcases lt_or_eq_of_le h1 with h1' | rfl
  · -- `−1 < κ₁`: the shadow comes from near `N`
    right
    apply hN
    rw [Metric.mem_closure_iff]
    intro ε hε
    obtain ⟨ρ, hρ, hloc⟩ := horn_shadow_near_N hF hv h1' h2 hh hε
    obtain ⟨z, hz, y, hy, hzy⟩ := hsh ρ hρ
    exact ⟨y, hy, by rw [dist_comm]; exact hloc z hz y hy hzy⟩
  · -- `κ₁ = −1`: from near `N` or near `S′`
    have hpole : v + e (α + π / 2) ∈ closure (F.region h) ∨ v - e (α + π / 2) ∈ closure (F.region h) := by
      by_contra hno
      push Not at hno
      obtain ⟨hN', hS'⟩ := hno
      rw [Metric.mem_closure_iff] at hN' hS'
      push Not at hN' hS'
      obtain ⟨δN, hδN, hfN⟩ := hN'
      obtain ⟨δS, hδS, hfS⟩ := hS'
      obtain ⟨ρ, hρ, hloc⟩ := shadow_source_near_poles hF hv hhv (coneAt_subset_allowedCone hF hv hh.mem_coneAt)
        (lt_min hδN hδS)
      obtain ⟨z, hz, y, hy, hzy⟩ := hsh ρ hρ
      rcases hloc z hz.1 hz.2.1 (abs_frameY_le_of_mem_hornSet le_rfl h2 hz) y hy hzy with hyN | hyS
      · have := hfN y hy
        rw [dist_comm] at this
        linarith [min_le_left δN δS]
      · have := hfS y hy
        rw [dist_comm] at this
        linarith [min_le_right δN δS]
    rcases hpole with hNcl | hScl
    · exact Or.inr (hN hNcl)
    · have hcont : F.IsContact v h (v - e (α + π / 2)) := ⟨hhv, hSv, hScl⟩
      rcases (contact_inType_or_outType hF hv hcont).1 with hin | hout
      · exact Or.inl ⟨hcont, hin⟩
      · exact absurd hout (not_outType_S_of_flankBelow_neg_one hF hv hh hScl)

/-- **A `+n` source puts the allowed cone in `d·n ≥ 0`**: an in-type contact at `N` gives `d·n ≥ 0`, an out-type one at `S′` gives
`d·(−n) ≤ 0`. -/
theorem dot_nonneg_of_srcG {v : ℂ} {α : ℝ} {j : Fin k}
    (hj : (F.IsContact v j (v + e (α + π / 2)) ∧ F.InType v j (v + e (α + π / 2))) ∨
      (F.IsContact v j (v - e (α + π / 2)) ∧ F.OutType v j (v - e (α + π / 2))))
    {d : ℂ} (hd : d ∈ F.allowedCone v j) : 0 ≤ dot d (e (α + π / 2)) := by
  rcases hj with ⟨hc, hin⟩ | ⟨hc, hout⟩
  · have := (hd _ hc).1 hin
    rwa [add_sub_cancel_left] at this
  · have := (hd _ hc).2 hout
    rw [sub_sub_cancel_left, dot_neg_right] at this
    linarith

/-- **A `−n` source puts the allowed cone in `d·n ≤ 0`** (the mirror of `dot_nonneg_of_srcG`). -/
theorem dot_nonpos_of_srcH {v : ℂ} {α : ℝ} {j : Fin k}
    (hj : (F.IsContact v j (v - e (α + π / 2)) ∧ F.InType v j (v - e (α + π / 2))) ∨
      (F.IsContact v j (v + e (α + π / 2)) ∧ F.OutType v j (v + e (α + π / 2))))
    {d : ℂ} (hd : d ∈ F.allowedCone v j) : dot d (e (α + π / 2)) ≤ 0 := by
  rcases hj with ⟨hc, hin⟩ | ⟨hc, hout⟩
  · have := (hd _ hc).1 hin
    rw [sub_sub_cancel_left, dot_neg_right] at this
    linarith
  · have := (hd _ hc).2 hout
    rwa [add_sub_cancel_left] at this

/-- **An in-type contact keeps its colour's class near `v` within `1` of the contact**: a point of the class near `v` is within `< 1`
of a point of the in-type tile (inside `B(v, 1)`), so its tile is unit-near that tile, and closure points are within `1`. Inhabitant
of the hypotheses: `bowtie` at `0` (`bowtie_inType`). -/
theorem region_near_of_inType (hF : F.Valid) {v w : ℂ} {j : Fin k} (hv : F.Covers v 1)
    (hcont : F.IsContact v j w) (hin : F.InType v j w) :
    ∃ ε > 0, ∀ z ∈ F.region j, dist z v < ε → dist z w ≤ 1 := by
  have hwd : w ∈ F.dom := hv (by rw [mem_closedBall, hcont.2.1])
  obtain ⟨T, hT, hwT⟩ := (F.mem_coloursAt_iff_exists_tileOf hwd).mp hcont.2.2
  obtain ⟨t, ht⟩ := hT.1.nonempty
  have htv : dist t v < 1 := hin T hT hwT ht
  refine ⟨1 - dist t v, by linarith, fun z hz hzv => ?_⟩
  obtain ⟨hA, hzA⟩ := tileOf_component hz
  have hzt : dist z t < 1 := by
    have := dist_triangle z v t
    rw [dist_comm v t] at this
    linarith
  rcases unitNear_or_unitFar hF hA hT with hn | hf
  · exact UnitNear.dist_le_of_mem_closure hn (subset_closure hzA) hwT
  · exact absurd (hf z hzA t ht) (not_lt.mpr hzt.le)

/-- `N` and `S′` are `2` apart. -/
theorem dist_N_S (v : ℂ) (α : ℝ) : dist (v + e (α + π / 2)) (v - e (α + π / 2)) = 2 := by
  rw [dist_eq_norm, show v + e (α + π / 2) - (v - e (α + π / 2)) = 2 * e (α + π / 2) by ring, norm_mul, norm_e]
  norm_num

/-- **A `+n` source keeps the class near `v` off `B(S′, 1)`**: an out-type contact at `S′` by `region_far_of_outType`; an in-type one at
`N` keeps it in `B̄(N, 1)`, which meets `B(S′, 1)` nowhere. -/
theorem region_far_S_of_srcG (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α : ℝ} {j : Fin k}
    (hj : (F.IsContact v j (v + e (α + π / 2)) ∧ F.InType v j (v + e (α + π / 2))) ∨
      (F.IsContact v j (v - e (α + π / 2)) ∧ F.OutType v j (v - e (α + π / 2)))) :
    ∃ ε > 0, ∀ z ∈ F.region j, dist z v < ε → 1 ≤ dist z (v - e (α + π / 2)) := by
  rcases hj with ⟨hc, hin⟩ | ⟨hc, hout⟩
  · obtain ⟨ε, hε, hf⟩ := region_near_of_inType hF hv hc hin
    refine ⟨ε, hε, fun z hz hzv => ?_⟩
    have h1 := hf z hz hzv
    have h2 := dist_triangle (v + e (α + π / 2)) z (v - e (α + π / 2))
    rw [dist_N_S, dist_comm (v + e (α + π / 2)) z] at h2
    linarith
  · exact region_far_of_outType hF hv hc hout

/-- **A `−n` source keeps the class near `v` off `B(N, 1)`** (the mirror of `region_far_S_of_srcG`). -/
theorem region_far_N_of_srcH (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α : ℝ} {j : Fin k}
    (hj : (F.IsContact v j (v - e (α + π / 2)) ∧ F.InType v j (v - e (α + π / 2))) ∨
      (F.IsContact v j (v + e (α + π / 2)) ∧ F.OutType v j (v + e (α + π / 2)))) :
    ∃ ε > 0, ∀ z ∈ F.region j, dist z v < ε → 1 ≤ dist z (v + e (α + π / 2)) := by
  rcases hj with ⟨hc, hin⟩ | ⟨hc, hout⟩
  · obtain ⟨ε, hε, hf⟩ := region_near_of_inType hF hv hc hin
    refine ⟨ε, hε, fun z hz hzv => ?_⟩
    have h1 := hf z hz hzv
    have h2 := dist_triangle (v + e (α + π / 2)) z (v - e (α + π / 2))
    rw [dist_N_S, dist_comm (v + e (α + π / 2)) z] at h2
    linarith
  · exact region_far_of_outType hF hv hc hout

/-- **The two flanks of a horn differ** (N4-STUCK (i)'s `g ≠ h` with unit arcs, FS114-CV § 1.4: "with one colour `k` on both flanks no
`k`-tile can shadow the tip"): were both flanks one colour, its contacts at `N` and at `S′` would be out-type (`outType_N_of_mem_closure`
as the lower flank, `outType_S_of_mem_closure` as the upper), which a bound `κ₂ = 1` or `κ₁ = −1` forbids
(`not_outType_N_of_flankAbove_one`, `not_outType_S_of_flankBelow_neg_one`), and which off them keeps the tip out of the colour's shadow
near both poles (`horn_not_shadowed_near_N`, `_S`) — against the shadow at every scale. Inhabitant of the hypotheses: `bowtie` at `0`,
`α = 0` (`bowtie_flanks`, `bowtie_doublyShadowed`; its flanks are `0` and `2`). -/
theorem flank_ne_of_shadows (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {g h : Fin k}
    (h1 : -1 ≤ κ₁) (h12 : κ₁ < κ₂) (h2 : κ₂ ≤ 1) (hg : F.IsFlankAbove v α κ₂ g) (hh : F.IsFlankBelow v α κ₁ h)
    (hshg : ∀ ρ > 0, ∃ z ∈ hornSet v α κ₁ κ₂ ρ, z ∈ shadow (F.region g))
    (hshh : ∀ ρ > 0, ∃ z ∈ hornSet v α κ₁ κ₂ ρ, z ∈ shadow (F.region h)) : g ≠ h := by
  rintro rfl
  have hgv : g ∈ F.coloursAt v := mem_closure_of_mem_coneAt hg.mem_coneAt
  have hoN : F.IsContact v g (v + e (α + π / 2)) ∧ F.OutType v g (v + e (α + π / 2)) := by
    rcases srcH_of_shadow hF hv h1 h12 h2 hh hshh with ⟨hc, hin⟩ | hout
    · exact absurd ⟨hin, outType_S_of_mem_closure hF hv (by linarith) hg hc.2.2⟩ (contact_inType_or_outType hF hv hc).2
    · exact hout
  have hoS : F.IsContact v g (v - e (α + π / 2)) ∧ F.OutType v g (v - e (α + π / 2)) := by
    rcases srcG_of_shadow hF hv h1 h12 h2 hg hshg with ⟨hc, hin⟩ | hout
    · exact absurd ⟨hin, outType_N_of_mem_closure hF hv (by linarith) hh hc.2.2⟩ (contact_inType_or_outType hF hv hc).2
    · exact hout
  rcases lt_or_eq_of_le h2 with h2' | rfl
  · rcases lt_or_eq_of_le h1 with h1' | rfl
    · obtain ⟨δN, hδN, ρN, hρN, hN⟩ := horn_not_shadowed_near_N hF hv h1 h2' hg
      obtain ⟨δS, hδS, ρS, hρS, hS⟩ := horn_not_shadowed_near_S hF hv h2 h1' hh
      obtain ⟨ρ, hρ, hloc⟩ := shadow_source_near_poles hF hv hgv (coneAt_subset_allowedCone hF hv hg.mem_coneAt)
        (lt_min hδN hδS)
      obtain ⟨z, hz, y, hy, hzy⟩ := hshg (min ρ (min ρN ρS)) (lt_min hρ (lt_min hρN hρS))
      rcases hloc z (lt_of_lt_of_le hz.1 (min_le_left _ _)) hz.2.1 (abs_frameY_le_of_mem_hornSet h1 h2 hz) y hy hzy
        with hyN | hyS
      · exact hN z (hornSet_mono_radius ((min_le_right _ _).trans (min_le_left _ _)) hz) y hy
          (lt_of_lt_of_le hyN (min_le_left _ _)) hzy
      · exact hS z (hornSet_mono_radius ((min_le_right _ _).trans (min_le_right _ _)) hz) y hy
          (lt_of_lt_of_le hyS (min_le_right _ _)) hzy
    · exact not_outType_S_of_flankBelow_neg_one hF hv hh hoS.1.2.2 hoS.2
  · exact not_outType_N_of_flankAbove_one hF hv hg hoN.1.2.2 hoN.2

/-- **A constant-sided arc near a point of an arc of `Γ`** (plan § 9.1's shared child `exists_isRingArc_of_onRingArc`, for `cv_l0` and
`pseudo_nonempty`): if `x` lies on an arc of `Γ` on `ω(p)`, then within any distance `ε > 0` of `x` that arc contains a sub-arc of positive
length with constant sides (wave 4's `exists_isRingArc_of_subset_Γ`, engines A and B, on the part of the arc within `ε/2` of `x` in
angle). Inhabitant of the hypotheses: `quadRing` at `0` (`quadRing_isRingArc`, `Plane/LocalMapExamples`). -/
theorem exists_isRingArc_of_onRingArc {p x : ℂ} (h : F.OnRingArc p x) {ε : ℝ} (hε : 0 < ε) :
    ∃ a b c c', a < b ∧ F.IsRingArc p a b c c' ∧ ringArc p a b ⊆ ball x ε := by
  obtain ⟨θ₁, θ₂, h12, ⟨φ, hφ, rfl⟩, hΓ⟩ := h
  set φ₁ := max θ₁ (φ - ε / 2) with hφ₁
  set φ₂ := min θ₂ (φ + ε / 2) with hφ₂
  have h12' : φ₁ < φ₂ := max_lt (lt_min h12 (by linarith [hφ.1])) (lt_min (by linarith [hφ.2]) (by linarith))
  have hsub : ringArc p φ₁ φ₂ ⊆ ringArc p θ₁ θ₂ := ringArc_subset_ringArc (le_max_left _ _) (min_le_left _ _)
  obtain ⟨a, b, c, c', ha, hab, hb, hR⟩ := exists_isRingArc_of_subset_Γ h12' (hsub.trans hΓ)
  refine ⟨a, b, c, c', hab, hR, ?_⟩
  rintro _ ⟨ψ, hψ, rfl⟩
  rw [mem_ball, ringPt, ringPt, dist_add_left, dist_eq_norm]
  have h1 : φ - ε / 2 ≤ ψ := (le_max_right _ _).trans (ha.trans hψ.1)
  have h2 : ψ ≤ φ + ε / 2 := (hψ.2.trans hb).trans (min_le_right _ _)
  calc ‖e ψ - e φ‖ ≤ |ψ - φ| := norm_e_sub_e_le ψ φ
    _ ≤ ε / 2 := abs_le.mpr ⟨by linarith, by linarith⟩
    _ < ε := by linarith

/-- **One sector, by a half-plane of contacts**: a colour carried at `v` whose every contact `w` on `ω(v)` is in-type with `w − v = u` or
out-type with `w − v = −u` (`‖u‖ = 1`) has the open half-plane `d·u > 0` in its allowed cone, so `u` is interior to it; with no MERGE at
`v` it has exactly one sector (wave 4's `stuck_structure_flanks` step `hone`, with an in-type contact allowed). Inhabitant of the
hypotheses: `bowtie` at `0` with `j = 0`, `u = i` (`bowtie_not_merge_zero`, `bowtie_inType`). -/
theorem hasSectors_one_of_contacts (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) (hM : ¬ F.MergeAvailable v) {j : Fin k}
    {u : ℂ} (hu : ‖u‖ = 1) (hj : j ∈ F.coloursAt v)
    (hcont : ∀ w, F.IsContact v j w → (w - v = u ∧ F.InType v j w) ∨ (w - v = -u ∧ F.OutType v j w)) :
    F.HasSectors v j 1 := by
  have hvd : v ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  obtain ⟨m', hm'⟩ := exists_hasSectors hvd j
  have hge : 1 ≤ m' := by
    obtain ⟨ρ, h1', h2'⟩ := ((eventually_one_le_sectorsOf hvd hj).and hm').exists
    rw [h2'] at h1'
    exact_mod_cast h1'
  have hle : m' ≤ 1 := by
    by_contra hlt
    push Not at hlt
    refine hM ⟨j, m', hlt, hm', u, mem_interior.mpr ⟨{d | 0 < dot d u}, ?_, ?_, ?_⟩⟩
    · intro d hd w hw
      have hd' : 0 < dot d u := hd
      rcases hcont w hw with ⟨hwu, hin⟩ | ⟨hwu, hout⟩
      · refine ⟨fun _ => by rw [hwu]; exact hd'.le, fun hout => absurd ⟨hin, hout⟩ (contact_inType_or_outType hF hv hw).2⟩
      · refine ⟨fun hin => absurd ⟨hin, hout⟩ (contact_inType_or_outType hF hv hw).2, fun _ => ?_⟩
        rw [hwu, dot_neg_right]
        linarith
    · exact isOpen_lt continuous_const (by unfold dot; fun_prop)
    · show 0 < dot u u
      rw [dot_self_eq, hu]
      norm_num
  exact (le_antisymm hle hge) ▸ hm'

end ArcMap

end HadwigerNelson.Plane
