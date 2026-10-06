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
is unit-near the flank, hence within `1` of `v` — and an out-type tile misses `B̄(v, 1)`. Inhabitant: no Lean model of all at once. `bowtie` at `0`, `α = 0` satisfies every hypothesis but `F.Covers 0 1` — the local hypotheses
(`bowtie_flanks`, `bowtie_inType`: its `g` is in-type at `N = i`); `Covers` fails there by FS131-QA4's QA4-B1. At [hand] all hold on
FS131-E7's `P₅` at its stuck vertex, `α = 0`, `g = 7` (twelve colours; `plans/FS131-E7-derivation.md` § 7): an open gate item until its
Lean model lands. -/
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

/-- **A lower flank on `ω(S′)` is never out-type at `S′`** (the mirror of `not_outType_N_of_flankAbove_one`). Inhabitant: no Lean model of all at once. `bowtie` at `0`, `α = 0` satisfies every hypothesis but `F.Covers 0 1` — the local hypotheses
(`bowtie_flanks`, `bowtie_inType`: its `h` is in-type at `S′ = −i`); `Covers` fails there by FS131-QA4's QA4-B1. At [hand] all hold on
FS131-E7's `P₅` at its stuck vertex, `α = 0`, `h = 8` (twelve colours; `plans/FS131-E7-derivation.md` § 7): an open gate item until its
Lean model lands. -/
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
at `κ₂ < 1` the second, by `horn_shadow_near_S`). Inhabitant: no Lean model of all at once. `bowtie` at `0`, `α = 0`, `κ₁ = −1`, `κ₂ = 1` satisfies every hypothesis but `F.Covers 0 1` —
the local hypotheses (`bowtie_flanks`; its tip is in the shadow of both flanks, `bowtie_doublyShadowed`); `Covers` fails there by
FS131-QA4's QA4-B1. At [hand] all hold on FS131-E7's `P₅` at its stuck vertex, `α = 0`, `κ₁ = −1`, `κ₂ = 1`, `g = 7` (twelve colours;
`plans/FS131-E7-derivation.md` § 7): an open gate item until its Lean model lands. -/
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
contact at `N`. Inhabitant: no Lean model of all at once. `bowtie` at `0`, `α = 0`, `κ₁ = −1`, `κ₂ = 1` satisfies every hypothesis but `F.Covers 0 1` —
the local hypotheses (`bowtie_flanks`, `bowtie_doublyShadowed`); `Covers` fails there by FS131-QA4's QA4-B1. At [hand] all hold on
FS131-E7's `P₅` at its stuck vertex, `α = 0`, `κ₁ = −1`, `κ₂ = 1`, `h = 8` (twelve colours; `plans/FS131-E7-derivation.md` § 7): an open
gate item until its Lean model lands. -/
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
of a point of the in-type tile (inside `B(v, 1)`), so its tile is unit-near that tile, and closure points are within `1`. Inhabitant: no Lean model of all at once. `bowtie` at `0` satisfies every hypothesis but `F.Covers 0 1` — the local hypotheses
(`bowtie_inType`); `Covers` fails there by FS131-QA4's QA4-B1. At [hand] all hold on FS131-E7's `P₅` at its stuck vertex, `j = 7`, `w` its
upper pole (twelve colours; `plans/FS131-E7-derivation.md` § 7): an open gate item until its Lean model lands. -/
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
near both poles (`horn_not_shadowed_near_N`, `_S`) — against the shadow at every scale. Inhabitant: no Lean model of all at once. `bowtie` at `0`, `α = 0`, `κ₁ = −1`, `κ₂ = 1` satisfies every hypothesis but `F.Covers 0 1` —
the local hypotheses (`bowtie_flanks`, `bowtie_doublyShadowed`; its flanks are `0` and `2`); `Covers` fails there by FS131-QA4's QA4-B1.
At [hand] all hold on FS131-E7's `P₅` at its stuck vertex, `α = 0`, `κ₁ = −1`, `κ₂ = 1`, `g = 7`, `h = 8` (twelve colours;
`plans/FS131-E7-derivation.md` § 7): an open gate item until its Lean model lands. -/
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

/-- The point `S′ + t e(α + π/2 − x)` in the frame at `v` along `e α`: `(t sin x, t cos x − 1)`. -/
theorem S_add_eq_fromFrame (v : ℂ) (α t x : ℝ) :
    v - e (α + π / 2) + (t : ℂ) * e (α + π / 2 - x) = fromFrame v α (t * Real.sin x) (t * Real.cos x - 1) := by
  unfold fromFrame
  rw [e_add α (π / 2), show α + π / 2 - x = α + (π / 2 - x) by ring, e_add α (π / 2 - x), e_eq (π / 2), e_eq (π / 2 - x),
    Real.cos_pi_div_two, Real.sin_pi_div_two, Real.cos_pi_div_two_sub, Real.sin_pi_div_two_sub]
  push_cast
  ring

/-- The squared distance from `v` of a point at distance `t` from a pole, at angle `x` off the direction of `v`. -/
theorem fromFrame_normSq_aux {t x : ℝ} : (t * Real.sin x) ^ 2 + (1 - t * Real.cos x) ^ 2 =
    (t - 1) ^ 2 + 2 * t * (1 - Real.cos x) := by
  have := Real.sin_sq_add_cos_sq x
  linear_combination t ^ 2 * this

/-- **A horn bounded above by `ω(N)` holds radial segments just outside `ω(N)`**: for every direction from `N` within a small angle `φ₀`
past the direction `α − π/2` of `v`, the points of that ray at distance slightly more than `1` from `N` lie in the horn, so in its
colour's class. Inhabitant of the hypotheses: `bowtie` at `0`, `α = 0` (`bowtie_isHorn`). -/
theorem horn_radial_N {v : ℂ} {α κ₁ : ℝ} {c : Fin k} (hH : F.IsHorn v α κ₁ 1 c) (h1 : -1 ≤ κ₁) :
    ∃ φ₀ > (0 : ℝ), ∀ x ∈ Ioo 0 φ₀, ∃ η₀ > (0 : ℝ), ∀ t ∈ Ioo (1 : ℝ) (1 + η₀),
      v + e (α + π / 2) + (t : ℂ) * e (α - π / 2 + x) ∈ F.region c := by
  have hπ := Real.pi_pos
  obtain ⟨r₀, hr₀sub, hr₀⟩ := (hH.eventually_subset_region.and self_mem_nhdsWithin).exists
  have hr₀' : (0 : ℝ) < r₀ := hr₀
  set r := min r₀ 1 with hr
  have hr0 : 0 < r := lt_min hr₀' one_pos
  have hr1 : r ≤ 1 := min_le_right _ _
  have hrr : r ≤ r₀ := min_le_left _ _
  refine ⟨r / 2, by positivity, fun x hx => ?_⟩
  have hk1 : κ₁ < 1 := hH.1
  have hxpi : x < π := by linarith [hx.2, Real.pi_gt_three]
  have hcos1 : Real.cos x < 1 := by
    have := Real.cos_lt_cos_of_nonneg_of_le_pi (le_refl 0) hxpi.le hx.1
    rwa [Real.cos_zero] at this
  set A := 1 - Real.cos x with hA
  have hA0 : 0 < A := by rw [hA]; linarith
  have hAx : A ≤ x ^ 2 / 2 := by rw [hA]; linarith [Real.one_sub_sq_div_two_le_cos (x := x)]
  have hsin : 0 < Real.sin x := Real.sin_pos_of_pos_of_lt_pi hx.1 hxpi
  refine ⟨min (r / 2) (A * (1 - κ₁) / 4), lt_min (by positivity) (by nlinarith), fun t ht => ?_⟩
  set u := t - 1 with hu
  have hu0 : 0 < u := by rw [hu]; linarith [ht.1]
  have hu1 : u < r / 2 := by rw [hu]; linarith [ht.2, min_le_left (r / 2) (A * (1 - κ₁) / 4)]
  have hu2 : u < A * (1 - κ₁) / 4 := by rw [hu]; linarith [ht.2, min_le_right (r / 2) (A * (1 - κ₁) / 4)]
  have ht' : t = 1 + u := by rw [hu]; ring
  apply hr₀sub
  rw [normalPt_add_eq_fromFrame]
  have hq : (t * Real.sin x) ^ 2 + (1 - t * Real.cos x) ^ 2 = u ^ 2 + 2 * (1 + u) * A := by
    rw [fromFrame_normSq_aux, ht', hA]; ring
  have hcosx : -1 ≤ Real.cos x := Real.neg_one_le_cos x
  refine ⟨?_, ?_, ?_, ?_⟩
  · -- the distance from `v`
    have hn := frame_normSq v α (fromFrame v α (t * Real.sin x) (1 - t * Real.cos x))
    rw [frameX_fromFrame, frameY_fromFrame, hq, ← dist_eq_norm] at hn
    have hlt : u ^ 2 + 2 * (1 + u) * A < r₀ ^ 2 := by
      have hx2 : x < r / 2 := hx.2
      have : x ^ 2 < r ^ 2 / 4 := by nlinarith [mul_lt_mul'' hx2 hx2 hx.1.le hx.1.le]
      nlinarith
    nlinarith [dist_nonneg (x := fromFrame v α (t * Real.sin x) (1 - t * Real.cos x)) (y := v)]
  · show 0 < frameX v α _
    rw [frameX_fromFrame]
    nlinarith
  · show 0 < tanHeight κ₁ (frameX v α _) (frameY v α _)
    rw [frameX_fromFrame, frameY_fromFrame]
    unfold tanHeight
    rw [hq]
    have hY : 1 - t * Real.cos x = A - u * Real.cos x := by rw [ht', hA]; ring
    rw [hY]
    have hA2 : A ≤ 2 := by rw [hA]; linarith
    have hk' : κ₁ ≤ 1 := hk1.le
    nlinarith [mul_le_mul_of_nonneg_left hcosx hu0.le, mul_le_mul_of_nonneg_left (Real.cos_le_one x) hu0.le,
      mul_nonneg hu0.le hA0.le, sq_nonneg u]
  · show tanHeight 1 (frameX v α _) (frameY v α _) < 0
    rw [frameX_fromFrame, frameY_fromFrame]
    unfold tanHeight
    rw [hq]
    have hY : 1 - t * Real.cos x = A - u * Real.cos x := by rw [ht', hA]; ring
    rw [hY]
    nlinarith [sq_nonneg u, mul_pos hu0 hA0, Real.cos_le_one x]

/-- **A horn bounded below by `ω(S′)` holds radial segments just outside `ω(S′)`** (the mirror of `horn_radial_N`): for directions from
`S′` within a small angle before `α + π/2`, the points at distance slightly more than `1` from `S′` lie in the horn's colour's class. -/
theorem horn_radial_S {v : ℂ} {α κ₂ : ℝ} {c : Fin k} (hH : F.IsHorn v α (-1) κ₂ c) (h2 : κ₂ ≤ 1) :
    ∃ φ₀ > (0 : ℝ), ∀ x ∈ Ioo 0 φ₀, ∃ η₀ > (0 : ℝ), ∀ t ∈ Ioo (1 : ℝ) (1 + η₀),
      v - e (α + π / 2) + (t : ℂ) * e (α + π / 2 - x) ∈ F.region c := by
  have hπ := Real.pi_pos
  obtain ⟨r₀, hr₀sub, hr₀⟩ := (hH.eventually_subset_region.and self_mem_nhdsWithin).exists
  have hr₀' : (0 : ℝ) < r₀ := hr₀
  set r := min r₀ 1 with hr
  have hr0 : 0 < r := lt_min hr₀' one_pos
  have hr1 : r ≤ 1 := min_le_right _ _
  have hrr : r ≤ r₀ := min_le_left _ _
  refine ⟨r / 2, by positivity, fun x hx => ?_⟩
  have hk2 : -1 < κ₂ := hH.1
  have hxpi : x < π := by linarith [hx.2, Real.pi_gt_three]
  have hcos1 : Real.cos x < 1 := by
    have := Real.cos_lt_cos_of_nonneg_of_le_pi (le_refl 0) hxpi.le hx.1
    rwa [Real.cos_zero] at this
  set A := 1 - Real.cos x with hA
  have hA0 : 0 < A := by rw [hA]; linarith
  have hAx : A ≤ x ^ 2 / 2 := by rw [hA]; linarith [Real.one_sub_sq_div_two_le_cos (x := x)]
  have hsin : 0 < Real.sin x := Real.sin_pos_of_pos_of_lt_pi hx.1 hxpi
  refine ⟨min (r / 2) (A * (1 + κ₂) / 4), lt_min (by positivity) (by nlinarith), fun t ht => ?_⟩
  set u := t - 1 with hu
  have hu0 : 0 < u := by rw [hu]; linarith [ht.1]
  have hu1 : u < r / 2 := by rw [hu]; linarith [ht.2, min_le_left (r / 2) (A * (1 + κ₂) / 4)]
  have hu2 : u < A * (1 + κ₂) / 4 := by rw [hu]; linarith [ht.2, min_le_right (r / 2) (A * (1 + κ₂) / 4)]
  have ht' : t = 1 + u := by rw [hu]; ring
  apply hr₀sub
  rw [S_add_eq_fromFrame]
  have hq : (t * Real.sin x) ^ 2 + (t * Real.cos x - 1) ^ 2 = u ^ 2 + 2 * (1 + u) * A := by
    have := fromFrame_normSq_aux (t := t) (x := x)
    rw [show (t * Real.cos x - 1) ^ 2 = (1 - t * Real.cos x) ^ 2 by ring, this, ht', hA]; ring
  have hcosx : -1 ≤ Real.cos x := Real.neg_one_le_cos x
  have hY : t * Real.cos x - 1 = -(A - u * Real.cos x) := by rw [ht', hA]; ring
  refine ⟨?_, ?_, ?_, ?_⟩
  · have hn := frame_normSq v α (fromFrame v α (t * Real.sin x) (t * Real.cos x - 1))
    rw [frameX_fromFrame, frameY_fromFrame, hq, ← dist_eq_norm] at hn
    have hlt : u ^ 2 + 2 * (1 + u) * A < r₀ ^ 2 := by
      have hx2 : x < r / 2 := hx.2
      have : x ^ 2 < r ^ 2 / 4 := by nlinarith [mul_lt_mul'' hx2 hx2 hx.1.le hx.1.le]
      nlinarith
    nlinarith [dist_nonneg (x := fromFrame v α (t * Real.sin x) (t * Real.cos x - 1)) (y := v)]
  · show 0 < frameX v α _
    rw [frameX_fromFrame]
    nlinarith
  · show 0 < tanHeight (-1) (frameX v α _) (frameY v α _)
    rw [frameX_fromFrame, frameY_fromFrame]
    unfold tanHeight
    rw [hq, hY]
    nlinarith [sq_nonneg u, mul_pos hu0 hA0, Real.cos_le_one x]
  · show tanHeight κ₂ (frameX v α _) (frameY v α _) < 0
    rw [frameX_fromFrame, frameY_fromFrame]
    unfold tanHeight
    rw [hq, hY]
    have hA2 : A ≤ 2 := by rw [hA]; linarith
    nlinarith [mul_le_mul_of_nonneg_left hcosx hu0.le, mul_le_mul_of_nonneg_left (Real.cos_le_one x) hu0.le,
      mul_nonneg hu0.le hA0.le, sq_nonneg u]

/-- **A horn on `ω(N)` keeps its colour's cone at `N` shorter than `π`** (N112-END's step, U1 read through the horn instead of a ring arc):
the radial segments of `horn_radial_N` put every direction of the colour's class at `N` at a non-acute angle to every direction just past
`α − π/2`, so the cone at `N` holds no antipodal pair. -/
theorem not_antipodal_coneAt_N_of_horn (hF : F.Valid) {v : ℂ} {α κ₁ : ℝ} {c : Fin k} (hH : F.IsHorn v α κ₁ 1 c)
    (h1 : -1 ≤ κ₁) {β : ℝ} (hβ : β ∈ coneAt (F.region c) (v + e (α + π / 2))) :
    β + π ∉ coneAt (F.region c) (v + e (α + π / 2)) := by
  have hπ := Real.pi_pos
  obtain ⟨φ₀, hφ₀, hrad⟩ := horn_radial_N hH h1
  set φ := min φ₀ 1 with hφ
  have hφ0 : 0 < φ := lt_min hφ₀ one_pos
  have hφπ : φ < π := lt_of_le_of_lt (min_le_right _ _) (by linarith [Real.pi_gt_three])
  have hI : ∀ γ ∈ coneAt (F.region c) (v + e (α + π / 2)), γ - π ∈ angleIcc (α - π / 2 + φ - π / 2) (α - π / 2 + π / 2) := by
    intro γ hγ
    refine mem_angleIcc_of_cos_nonneg (by linarith) fun θ hθ => ?_
    obtain ⟨η₀, hη₀, hseg⟩ := hrad (θ - (α - π / 2)) ⟨by linarith [hθ.1], by linarith [hθ.2, min_le_left φ₀ 1]⟩
    have hseg' : ∀ t ∈ Ioo 1 (1 + η₀), v + e (α + π / 2) + (t : ℂ) * e θ ∈ closure (F.region c) := fun t ht => by
      have := hseg t ht
      rw [show α - π / 2 + (θ - (α - π / 2)) = θ by ring] at this
      exact subset_closure this
    have := hF.cos_nonpos_of_radial_outer hη₀ hseg' γ hγ
    rw [show γ - π - θ = (γ - θ) - π by ring, Real.cos_sub_pi]
    linarith
  intro hβ'
  have h1' := hI β hβ
  have h2' := hI (β + π) hβ'
  rw [show β + π - π = (β - π) + π by ring] at h2'
  exact not_mem_angleIcc_add_pi (by linarith) h1' h2'

/-- **A horn on `ω(S′)` keeps its colour's cone at `S′` shorter than `π`** (the mirror of `not_antipodal_coneAt_N_of_horn`). -/
theorem not_antipodal_coneAt_S_of_horn (hF : F.Valid) {v : ℂ} {α κ₂ : ℝ} {c : Fin k} (hH : F.IsHorn v α (-1) κ₂ c)
    (h2 : κ₂ ≤ 1) {β : ℝ} (hβ : β ∈ coneAt (F.region c) (v - e (α + π / 2))) :
    β + π ∉ coneAt (F.region c) (v - e (α + π / 2)) := by
  have hπ := Real.pi_pos
  obtain ⟨φ₀, hφ₀, hrad⟩ := horn_radial_S hH h2
  set φ := min φ₀ 1 with hφ
  have hφ0 : 0 < φ := lt_min hφ₀ one_pos
  have hφπ : φ < π := lt_of_le_of_lt (min_le_right _ _) (by linarith [Real.pi_gt_three])
  have hI : ∀ γ ∈ coneAt (F.region c) (v - e (α + π / 2)), γ - π ∈ angleIcc (α + π / 2 - π / 2) (α + π / 2 - φ + π / 2) := by
    intro γ hγ
    refine mem_angleIcc_of_cos_nonneg (by linarith) fun θ hθ => ?_
    obtain ⟨η₀, hη₀, hseg⟩ := hrad (α + π / 2 - θ) ⟨by linarith [hθ.2], by linarith [hθ.1, min_le_left φ₀ 1]⟩
    have hseg' : ∀ t ∈ Ioo 1 (1 + η₀), v - e (α + π / 2) + (t : ℂ) * e θ ∈ closure (F.region c) := fun t ht => by
      have := hseg t ht
      rw [show α + π / 2 - (α + π / 2 - θ) = θ by ring] at this
      exact subset_closure this
    have := hF.cos_nonpos_of_radial_outer hη₀ hseg' γ hγ
    rw [show γ - π - θ = (γ - θ) - π by ring, Real.cos_sub_pi]
    linarith
  intro hβ'
  have h1' := hI β hβ
  have h2' := hI (β + π) hβ'
  rw [show β + π - π = (β - π) + π by ring] at h2'
  exact not_mem_angleIcc_add_pi (by linarith) h1' h2'

/-- **A horn of a two-sector colour, at a vertex with no MERGE, has out-type contacts of its colour at both its poles** (N3-DEG through
wave 4's `woodallCone`, read at the horn's own axis: `woodallCone`'s axis is the horn's up to `π`). Inhabitant: no Lean model of all at once. `bowtie` at `0` satisfies every hypothesis but `F.Covers 0 1` — the local hypotheses
(`bowtie_not_merge_zero`, `bowtie_coloursAt_zero`, `bowtie_isHorn`); `Covers` fails there by FS131-QA4's QA4-B1. At [hand] all hold on
FS131-E7's `P₅` at its stuck vertex, `c = 9`, `m = 2`, `α = 0`, `κ₁ = −1`, `κ₂ = 1` (twelve colours; `plans/FS131-E7-derivation.md` § 7):
an open gate item until its Lean model lands. -/
theorem horn_poles_contact (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) (hM : ¬ F.MergeAvailable v) {c : Fin k} {m : ℕ}
    (hm : 2 ≤ m) (hc : F.HasSectors v c m) {α κ₁ κ₂ : ℝ} (hH : F.IsHorn v α κ₁ κ₂ c) :
    (F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2))) ∧
      (F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) := by
  have hcv : c ∈ F.coloursAt v := mem_closure_of_mem_coneAt hH.mem_coneAt_region
  have hD : interior (F.allowedCone v c) = ∅ := by
    by_contra hne
    exact hM ⟨c, m, hm, hc, nonempty_iff_ne_empty.mpr hne⟩
  obtain ⟨α', hN, hS, hev⟩ := woodallCone hF hv hcv hD
  obtain ⟨r, ⟨hr1, hr2⟩, hr0⟩ := ((hev.and hH.2).and self_mem_nhdsWithin).exists
  obtain ⟨β, hβ, κ, κ', -, -, -, hSeq⟩ := hr1 _ hr2
  have hr0' : (0 : ℝ) < r := hr0
  have heq : e α = e β := by
    have := mem_coneAt_hornSet v α hH.1 hr0'
    rw [hSeq] at this
    exact (e_eq_of_mem_coneAt_hornSet this)
  have hn : e (α + π / 2) = e (β + π / 2) := by rw [e_add, e_add, heq]
  rw [hn]
  simp only [mem_insert_iff, mem_singleton_iff] at hβ
  rcases hβ with rfl | rfl
  · exact ⟨hN, hS⟩
  · rw [add_e_add_pi_add, sub_e_add_pi_add]; exact ⟨hS, hN⟩

-- An interior point carries exactly its own colour: `coloursAt_eq_singleton_of_interior` (`Plane/ValidMap/Limit`); this file's
-- copy `coloursAt_eq_of_mem_interiorPts`, which nothing here read, was removed by FS131-RP1 (inventory ruling 459 (c)).

/-- `‖e s − 1‖` controls `|s|` on `(−π, π]`: `|s| ≤ (π/2) ‖e s − 1‖`. -/
theorem abs_le_norm_e_sub_one {s : ℝ} (h1 : -π < s) (h2 : s ≤ π) : |s| ≤ π / 2 * ‖e s - 1‖ := by
  have hπ := Real.pi_pos
  have hn : ‖e s - 1‖ = 2 * |Real.sin (s / 2)| := by
    have hsq : ‖e s - 1‖ ^ 2 = (2 * |Real.sin (s / 2)|) ^ 2 := by
      rw [Complex.sq_norm, Complex.normSq_apply, e_eq]
      simp only [Complex.sub_re, Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.I_re, Complex.ofReal_im,
        Complex.I_im, Complex.one_re, Complex.sub_im, Complex.add_im, Complex.mul_im, Complex.one_im]
      rw [mul_pow, sq_abs]
      have hc : Real.cos s = 1 - 2 * Real.sin (s / 2) ^ 2 := by
        have h1 := Real.cos_two_mul (s / 2)
        have h2 := Real.sin_sq_add_cos_sq (s / 2)
        rw [show 2 * (s / 2) = s by ring] at h1
        linarith
      have hs := Real.sin_sq_add_cos_sq s
      nlinarith [hc, hs]
    have h0 : 0 ≤ ‖e s - 1‖ := norm_nonneg _
    have h0' : 0 ≤ 2 * |Real.sin (s / 2)| := by positivity
    nlinarith [sq_nonneg (‖e s - 1‖ - 2 * |Real.sin (s / 2)|), sq_nonneg (‖e s - 1‖ + 2 * |Real.sin (s / 2)|)]
  rw [hn]
  rcases lt_trichotomy s 0 with hs | rfl | hs
  · have := sin_half_ge (s := -s) (by linarith) (by linarith)
    rw [show -s / 2 = -(s / 2) by ring, Real.sin_neg] at this
    rw [abs_of_neg hs, abs_of_neg (by linarith [div_pos (show 0 < -s by linarith) hπ])]
    have : -s ≤ π * -Real.sin (s / 2) := by rwa [div_le_iff₀ hπ, mul_comm] at this
    nlinarith
  · simp
  · rcases lt_or_eq_of_le h2 with h2' | rfl
    · have := sin_half_ge (s := s) hs h2'
      rw [abs_of_pos hs, abs_of_pos (by linarith [div_pos hs hπ])]
      have : s ≤ π * Real.sin (s / 2) := by rwa [div_le_iff₀ hπ, mul_comm] at this
      nlinarith
    · rw [show π / 2 = π / 2 by rfl, Real.sin_pi_div_two, abs_one, abs_of_pos hπ]
      linarith

/-- **Points of `ω(p)` near an interior point of an arc of it lie on the arc.** -/
theorem sphere_near_mem_ringArc {p : ℂ} {θ₁ θ₂ θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) :
    ∃ δ > 0, ∀ z ∈ sphere p 1, dist z (ringPt p θ) < δ → z ∈ ringArc p θ₁ θ₂ := by
  have hπ := Real.pi_pos
  set m := min (θ - θ₁) (θ₂ - θ) with hm
  have hm0 : 0 < m := lt_min (by linarith [hθ.1]) (by linarith [hθ.2])
  set m' := min m 1 with hm'
  have hm'0 : 0 < m' := lt_min hm0 one_pos
  refine ⟨m' / π, by positivity, fun z hz hzd => ?_⟩
  set w := (z - p) * starRingEnd ℂ (e θ) with hw
  have hzp : ‖z - p‖ = 1 := by rw [← dist_eq_norm]; exact hz
  have hw1 : ‖w‖ = 1 := by rw [hw, norm_mul, RCLike.norm_conj, norm_e, hzp, mul_one]
  have hwe : w = e (arg w) := by
    have := eq_polar_arg w
    rw [hw1] at this
    simpa using this
  have hzw : z - p = e θ * w := by
    rw [hw, ← mul_assoc, mul_comm (e θ), mul_assoc, conj_e_mul_e, mul_one]
  set s := arg w with hs
  have hz' : z = ringPt p (θ + s) := by
    rw [ringPt, e_add, ← hwe, ← hzw]; ring
  have hds : dist z (ringPt p θ) = ‖e s - 1‖ := by
    rw [hz', ringPt, ringPt, dist_add_left, dist_eq_norm, e_add,
      show e θ * e s - e θ = e θ * (e s - 1) by ring, norm_mul, norm_e, one_mul]
  have hsb := abs_le_norm_e_sub_one (s := s) (Complex.neg_pi_lt_arg w) (Complex.arg_le_pi w)
  rw [← hds] at hsb
  have hs2 : |s| < m' / 2 := by
    calc |s| ≤ π / 2 * dist z (ringPt p θ) := hsb
      _ < π / 2 * (m' / π) := by gcongr
      _ = m' / 2 := by field_simp
  have hsm : |s| < m := by linarith [min_le_left m 1]
  rw [hz']
  refine ⟨θ + s, ⟨?_, ?_⟩, rfl⟩
  · linarith [(abs_lt.mp hsm).1, min_le_left (θ - θ₁) (θ₂ - θ)]
  · linarith [(abs_lt.mp hsm).2, min_le_right (θ - θ₁) (θ₂ - θ)]

/-- **The colours at an interior point of a constant-sided arc are its two side colours**: near the point, `ω(p)` lies in `Γ`, so every
class reaching the point does so from inside or from outside the circle. Inhabitant of the hypotheses: `quadRing` (`quadRing_isRingArc`). -/
theorem IsRingArc.coloursAt_eq {p : ℂ} {θ₁ θ₂ θ : ℝ} {c c' : Fin k} (hR : F.IsRingArc p θ₁ θ₂ c c') (hθ : θ ∈ Ioo θ₁ θ₂) :
    F.coloursAt (ringPt p θ) = {c, c'} := by
  obtain ⟨hin, hout⟩ := hR.2.2 θ hθ
  ext j
  simp only [mem_insert_iff, mem_singleton_iff]
  constructor
  · intro hj
    have hsplit : F.region j ⊆ (F.region j ∩ ball p 1) ∪ (F.region j \ closedBall p 1) ∪ (F.region j ∩ sphere p 1) := by
      intro z hz
      rcases lt_trichotomy (dist z p) 1 with h | h | h
      · exact Or.inl (Or.inl ⟨hz, h⟩)
      · exact Or.inr ⟨hz, h⟩
      · exact Or.inl (Or.inr ⟨hz, fun h' => absurd (mem_closedBall.mp h') (not_le.mpr h)⟩)
    have h := closure_mono hsplit hj
    rw [closure_union, closure_union] at h
    rcases h with (h | h) | h
    · left
      have : j ∈ F.innerColours p (ringPt p θ) := h
      rw [hin] at this
      exact this
    · right
      have : j ∈ F.outerColours p (ringPt p θ) := h
      rw [hout] at this
      exact this
    · exfalso
      obtain ⟨δ, hδ, hsph⟩ := sphere_near_mem_ringArc (p := p) hθ
      obtain ⟨z, ⟨hzj, hzs⟩, hzd⟩ := Metric.mem_closure_iff.mp h δ hδ
      have hzΓ := hR.2.1 (hsph z hzs (by rw [dist_comm]; exact hzd))
      exact hzj.1.2 hzΓ.2
  · rintro (rfl | rfl)
    · have : j ∈ F.innerColours p (ringPt p θ) := by rw [hin]; exact mem_singleton _
      exact closure_mono inter_subset_left this
    · have : j ∈ F.outerColours p (ringPt p θ) := by rw [hout]; exact mem_singleton _
      exact closure_mono sdiff_subset this

/-- **One colour flanks a horn from above**: two upper flanks at one bound share the band between it and the lower of their upper limits. Inhabitant of the hypotheses: `bowtie` at `0` (`bowtie_flanks`). -/
theorem IsFlankAbove.unique {v : ℂ} {α κ : ℝ} {g g' : Fin k} (hg : F.IsFlankAbove v α κ g) (hg' : F.IsFlankAbove v α κ g') :
    g = g' := by
  obtain ⟨κ₁, h1, ev1⟩ := hg
  obtain ⟨κ₂, h2, ev2⟩ := hg'
  have hev : ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ (min κ₁ κ₂) r ⊆ F.region g ∩ F.region g' := by
    filter_upwards [ev1, ev2] with r hr1 hr2
    exact subset_inter ((hornSet_mono le_rfl (min_le_left _ _)).trans hr1) ((hornSet_mono le_rfl (min_le_right _ _)).trans hr2)
  obtain ⟨p, hp, -⟩ := exists_mem_hornSet_near (lt_min h1 h2) hev one_pos
  exact (hp.1.2 : F.col p = g).symm.trans hp.2.2

/-- **A horn of a two-sector colour, at a vertex with no MERGE, has bounds in `[−1, 1]`** (wave 4's `woodallCone`: every sector of the colour
is a horn along the axis with such bounds, and a horn's bounds are determined by its set, `hornSet_curv_eq`). Inhabitant: no Lean model of all at once. `bowtie` at `0` satisfies every hypothesis but `F.Covers 0 1` — the local hypotheses
(`bowtie_not_merge_zero`, `bowtie_coloursAt_zero`, `bowtie_isHorn`); `Covers` fails there by FS131-QA4's QA4-B1. At [hand] all hold on
FS131-E7's `P₅` at its stuck vertex, `c = 9`, `m = 2`, `α = 0`, `κ₁ = −1`, `κ₂ = 1` (twelve colours; `plans/FS131-E7-derivation.md` § 7):
an open gate item until its Lean model lands. -/
theorem horn_bounds_of_noMerge (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) (hM : ¬ F.MergeAvailable v) {c : Fin k} {m : ℕ}
    (hm : 2 ≤ m) (hc : F.HasSectors v c m) {α κ₁ κ₂ : ℝ} (hH : F.IsHorn v α κ₁ κ₂ c) : -1 ≤ κ₁ ∧ κ₂ ≤ 1 := by
  have hcv : c ∈ F.coloursAt v := mem_closure_of_mem_coneAt hH.mem_coneAt_region
  have hD : interior (F.allowedCone v c) = ∅ := by
    by_contra hne
    exact hM ⟨c, m, hm, hc, nonempty_iff_ne_empty.mpr hne⟩
  obtain ⟨α', -, -, hev⟩ := woodallCone hF hv hcv hD
  obtain ⟨r, ⟨hr1, hr2⟩, hr0⟩ := ((hev.and hH.2).and self_mem_nhdsWithin).exists
  obtain ⟨β, -, κ, κ', hκ1, hκ12, hκ2, hSeq⟩ := hr1 _ hr2
  have hr0' : (0 : ℝ) < r := hr0
  have heq : e α = e β := by
    have := mem_coneAt_hornSet v α hH.1 hr0'
    rw [hSeq] at this
    exact e_eq_of_mem_coneAt_hornSet this
  rw [hornSet_congr heq.symm κ κ' r] at hSeq
  obtain ⟨h1, h2⟩ := hornSet_curv_eq hH.1 hκ12 hr0' hSeq
  exact ⟨h1 ▸ hκ1, h2 ▸ hκ2⟩

/-- **FS131-E6-CONE**: a horn of a colour whose allowed cone has empty interior has bounds in `[−1, 1]` (`woodallCone`: every sector of
the colour is then a horn set along one axis with such bounds, and a horn's bounds are determined by its set, `hornSet_curv_eq`). So a
horn with a bound outside `[−1, 1]` — every horn shaveable only along a unit circle strictly inside it — has `int D_c(v) ≠ ∅`.
`horn_bounds_of_noMerge` is the case where the empty interior comes from two sectors and no MERGE (this is its proof with the cone
hypothesis made direct; FS131-E6 § 4.1); that lemma's local hypotheses give these by the example below, so `bowtie` at `0` satisfies every hypothesis here but `F.Covers 0 1`
(FS131-QA4's QA4-B1): no Lean model of all at once. At [hand] all hold on FS131-E7's `P₅` at its stuck vertex, `c = 9`, `α = 0`, `κ₁ =
−1`, `κ₂ = 1` (the cone of `9` there lies in a line; twelve colours; `plans/FS131-E7-derivation.md` § 7): an open gate item until its Lean
model lands. -/
theorem horn_bounds_of_interior_empty (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {α κ₁ κ₂ : ℝ}
    (hH : F.IsHorn v α κ₁ κ₂ c) (hD : interior (F.allowedCone v c) = ∅) : -1 ≤ κ₁ ∧ κ₂ ≤ 1 := by
  have hcv : c ∈ F.coloursAt v := mem_closure_of_mem_coneAt hH.mem_coneAt_region
  obtain ⟨α', -, -, hev⟩ := woodallCone hF hv hcv hD
  obtain ⟨r, ⟨hr1, hr2⟩, hr0⟩ := ((hev.and hH.2).and self_mem_nhdsWithin).exists
  obtain ⟨β, -, κ, κ', hκ1, hκ12, hκ2, hSeq⟩ := hr1 _ hr2
  have hr0' : (0 : ℝ) < r := hr0
  have heq : e α = e β := by
    have := mem_coneAt_hornSet v α hH.1 hr0'
    rw [hSeq] at this
    exact e_eq_of_mem_coneAt_hornSet this
  rw [hornSet_congr heq.symm κ κ' r] at hSeq
  obtain ⟨h1, h2⟩ := hornSet_curv_eq hH.1 hκ12 hr0' hSeq
  exact ⟨h1 ▸ hκ1, h2 ▸ hκ2⟩

/-- `horn_bounds_of_noMerge`, read off E6-CONE (a check that the new lemma carries the old one). -/
example (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) (hM : ¬ F.MergeAvailable v) {c : Fin k} {m : ℕ}
    (hm : 2 ≤ m) (hc : F.HasSectors v c m) {α κ₁ κ₂ : ℝ} (hH : F.IsHorn v α κ₁ κ₂ c) : -1 ≤ κ₁ ∧ κ₂ ≤ 1 :=
  horn_bounds_of_interior_empty hF hv hH (by
    by_contra hne
    exact hM ⟨c, m, hm, hc, nonempty_iff_ne_empty.mpr hne⟩)

/-- **One sector, by a half-plane of contacts**: a colour carried at `v` whose every contact `w` on `ω(v)` is in-type with `w − v = u` or
out-type with `w − v = −u` (`‖u‖ = 1`) has the open half-plane `d·u > 0` in its allowed cone, so `u` is interior to it; with no MERGE at
`v` it has exactly one sector (wave 4's `stuck_structure_flanks` step `hone`, with an in-type contact allowed). Inhabitant: no Lean model of all at once. `bowtie` at `0` with `j = 0`, `u = i` satisfies every hypothesis but `F.Covers 0 1`
— the local hypotheses (`bowtie_not_merge_zero`, `bowtie_inType`; FS131-QA4 § 3.5's sample); `Covers` fails there by FS131-QA4's QA4-B1. At [hand] all
hold on FS131-E7's `P₅` at its stuck vertex, `j = 7`, `u = i` (the one contact of `7` there is the upper pole, in-type) (twelve colours;
`plans/FS131-E7-derivation.md` § 7): an open gate item until its Lean model lands. -/
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
