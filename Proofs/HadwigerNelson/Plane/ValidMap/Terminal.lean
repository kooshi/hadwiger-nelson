import Proofs.HadwigerNelson.Plane.ValidMap.Chain
import Proofs.HadwigerNelson.Plane.ValidMap.Contact
import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc
import Proofs.HadwigerNelson.Plane.ValidMap.BaseSteps
import Proofs.HadwigerNelson.Plane.ValidMap.BrickMap
import Proofs.HadwigerNelson.Plane.ValidMap.FlankUA
import Proofs.HadwigerNelson.Plane.ValidMap.HornShadow

/-!
# The terminal modification `M*` and the stuck chains' ends (FS112-N2-TERM, -C-ENDS, -C-DOUBLE, FS114-CV-HD)

Wave 5's skeleton (`plans/FS131-w5-kernel-plan.md` § 3), over the foundation `Plane/ValidMap/Chain`. Frames as in wave 4: at a vertex
`v` with axis `e α`, `n = e (α + π/2)`, `N = v + n`, `S = v − n`; a horn along `e (α + π)` has `n` reversed in its own frame, so its
arc on the `N` side is its *lower* arc (curvature `−1` there means "on `ω(N)`"). Rows:

* **FS112-N2-TERM** (`exists_terminal`), with **FS112-N2-RED** merged as its lemma (`exists_red`);
* **FLANK-Q unconditional** (wave 4's obligation, inventory item 79): `flankQ_upper_of_qrOnly`, `flankQ_lower_of_qrOnly`;
* **FS114-CV-HD** (`cv_hd_main`, `cv_hd`, `cv_class`, `cv_l0`; CV-ENDS is `c_ends`);
* **FS112-C-ENDS** in its erratum's form (`c_ends`), **FS112-C-DOUBLE** (`c_double`);
* supporting lemmas: the unit-arc stuck structure (`stuck_structure_ua`, FS112-WALK's row 5 — not a backlog row), the corrected
  **FS112-Y3-END-NEEDS** (`y3_end_needs`, inventory item 69), and **FS112-N3-END's chain clause** (`n3_end_chain`, item 74);
* the inhabitant of `IsTerminalMap` at seven colours (`sevenBrickMap_isTerminalMap`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Angle arithmetic at `S′` (FS131-I5i) -/

/-- An arc of directions `[b₀, b₁]` inside the closed lower half-turn `[α + π, α + 2π]` and holding both `α` and `α + π` is that half-turn
(E5 § 3.4: "its cone lies in `[α + π, α + 2π]` and holds both ends, so it **is** `[α + π, α + 2π]`"). -/
theorem angleIcc_eq_lower_half {α b₀ b₁ : ℝ} (h01 : b₀ ≤ b₁)
    (hsub : angleIcc b₀ b₁ ⊆ angleIcc (α + π) (α + 2 * π)) (hα : α ∈ angleIcc b₀ b₁) (hαπ : α + π ∈ angleIcc b₀ b₁) :
    ∃ m : ℤ, b₀ = α + π + 2 * π * m ∧ b₁ = α + 2 * π + 2 * π * m := by
  sorry

/-- An arc of directions inside `[α + π, α + 2π − φ]` (U1's cone at `S′`) whose arc meets no interior direction of the lower half-turn
`(α + π, α + 2π)` is the single direction `α + π` (E5 § 3.4: "hence equal to `{α + π}`"). -/
theorem angle_pinch {α φ b b' : ℝ} {m : ℤ} (hφ : 0 < φ) (hφπ : φ < π) (hbb : b ≤ b')
    (hsub : angleIcc b b' ⊆ angleIcc (α + π) (α + 2 * π - φ))
    (hdisj : Disjoint (angleIcc b b') (angleIoo (α + π + 2 * π * m) (α + 2 * π + 2 * π * m))) :
    b' = b ∧ ∃ m' : ℤ, b = α + π + 2 * π * m' := by
  sorry

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- `z` lies on a (Q) or an (R2) arc of some unit circle. -/
def OnQR2Arc (z : ℂ) : Prop :=
  ∃ P θ₁ θ₂, (F.IsQArc P θ₁ θ₂ ∨ F.IsR2Arc P θ₁ θ₂) ∧ z ∈ ringArc P θ₁ θ₂

/-- A horn bound of exactly `±1` at `w` along `e β` sits on a (Q) or (R2) arc: an upper arc on `ω(w + e(β + π/2))` is the start (at
`w`, angle `β − π/2`) of a (Q) or (R2) arc of that circle on the `+e β` side, and a lower arc on `ω(w − e(β + π/2))` likewise
(FLANK-Q's form). -/
def HornBoundsQR (w : ℂ) (β : ℝ) : Prop :=
  (∀ κ₁ d, F.IsHorn w β κ₁ 1 d → ∃ θ₂, β - π / 2 < θ₂ ∧
      (F.IsQArc (w + e (β + π / 2)) (β - π / 2) θ₂ ∨ F.IsR2Arc (w + e (β + π / 2)) (β - π / 2) θ₂)) ∧
    ∀ κ₂ d, F.IsHorn w β (-1) κ₂ d → ∃ θ₁, θ₁ < β + π / 2 ∧
      (F.IsQArc (w - e (β + π / 2)) θ₁ (β + π / 2) ∨ F.IsR2Arc (w - e (β + π / 2)) θ₁ (β + π / 2))

end ArcMap

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## The unit-arc stuck structure (supporting lemma: FS112-WALK's row 5, N4-STUCK (i)–(ii) with unit arcs) -/

/-- **FS110-N3-DEG's cone as horns, unit arcs allowed** (wave 4's `woodallCone_isHorn` with `woodallCone` for `woodallCone_strict`: no
Condition 5, curvatures in `[−1, 1]`): with `int D_c(v) = ∅`, every `c`-sector at `v` is a `c`-horn along `±a`. -/
theorem woodallCone_isHorn_ua (hF : F.Valid) {v : ℂ} {c : Fin k} (hv : F.Covers v 1)
    (hc : c ∈ F.coloursAt v) (hD : interior (F.allowedCone v c) = ∅) :
    ∃ α : ℝ, (F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2))) ∧
      (F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) ∧
      ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ S ∈ F.sectorsOf v r c, ∃ β ∈ ({α, α + π} : Set ℝ), ∃ κ₁ κ₂,
        -1 ≤ κ₁ ∧ κ₂ ≤ 1 ∧ F.IsHorn v β κ₁ κ₂ c ∧ S = hornSet v β κ₁ κ₂ r := by
  obtain ⟨α, hN, hS, hev⟩ := woodallCone hF hv hc hD
  obtain ⟨r₀, n, G, hC⟩ := localSectors F (hv (mem_closedBall_self zero_le_one))
  refine ⟨α, hN, hS, ?_⟩
  filter_upwards [hev, Ioc_mem_nhdsGT hC.pos] with r hr hrr S hS'
  obtain ⟨β, hβ, κ₁, κ₂, h1, h12, h2, hSeq⟩ := hr S hS'
  have hSec : F.IsSector v r (hornSet v β κ₁ κ₂ r) := hSeq ▸ hS'.1
  obtain ⟨i, -, -, -, -, hsec⟩ := hC.index_of_isSector_hornSet hrr h12 hSec
  have hn : 0 < n := i.pos
  obtain ⟨g, hg⟩ := hC.exists_col i
  -- the sector's colour is `c`
  have hgc : g = c := by
    obtain ⟨z, hz⟩ := hC.sector_nonempty hrr i
    have hz' : z ∈ S := by rw [hSeq, ← hsec r hrr]; exact hz
    have h1 := (hg r hrr hz).2
    have h2 := hS'.2 hz'
    exact h1.symm.trans h2
  refine ⟨β, hβ, κ₁, κ₂, h1, h2, ⟨h12, ?_⟩, hSeq⟩
  filter_upwards [Ioc_mem_nhdsGT hC.pos] with r' hr'
  rw [← hsec r' hr']
  refine ⟨(hC.isSector_iff hn hr').mpr ⟨i, rfl⟩, fun z hz => ?_⟩
  have := (hg r' hr' hz).2
  rw [hgc] at this
  exact this

/-- **N4-STUCK (i) with unit arcs** (wave 4's `stuck_horns` over `woodallCone_isHorn_ua`: no Condition 5, curvatures in `[−1, 1]`): at a stuck
vertex the colour with two or more sectors has exactly two, horns along `±a`, with out-type contacts at both poles. -/
theorem stuck_horns_ua (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) (hst : F.IsStuck v) {c : Fin k}
    {m : ℕ} (hm : 2 ≤ m) (hc : F.HasSectors v c m) :
    ∃ α κ₁ κ₂ κ₃ κ₄ : ℝ, F.IsHorn v α κ₁ κ₂ c ∧ F.IsHorn v (α + π) κ₃ κ₄ c ∧ -1 ≤ κ₁ ∧ κ₂ ≤ 1 ∧ -1 ≤ κ₃ ∧ κ₄ ≤ 1 ∧
      F.HasSectors v c 2 ∧ (F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2))) ∧
      (F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) := by
  have hvd : v ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  obtain ⟨hM, hR, hSh, -⟩ := hst
  have hD : interior (F.allowedCone v c) = ∅ := by
    by_contra hne
    exact hM ⟨c, m, hm, hc, nonempty_iff_ne_empty.mpr hne⟩
  have hcv : c ∈ F.coloursAt v := by
    obtain ⟨r, hr, -⟩ := (hc.and self_mem_nhdsWithin).exists
    have h1 : 1 < (F.sectorsOf v r c).encard := by rw [hr]; exact_mod_cast hm
    obtain ⟨S, -, hS, -, -⟩ := one_lt_encard_iff.mp h1
    have hS' : F.IsSector v r S ∧ S ⊆ F.col ⁻¹' {c} := hS
    obtain ⟨⟨x, -, hSx, hvS⟩, hSc⟩ := hS'
    have hSr : S ⊆ F.region c := fun z hz =>
      ⟨by rw [hSx] at hz; exact (connectedComponentIn_subset _ _ hz).1, hSc hz⟩
    exact closure_mono hSr hvS
  obtain ⟨α, hN, hS, hev⟩ := woodallCone_isHorn_ua hF hv hcv hD
  obtain ⟨r, ⟨hrH, hrm⟩, hr⟩ := ((hev.and hc).and self_mem_nhdsWithin).exists
  have h1 : 1 < (F.sectorsOf v r c).encard := by rw [hrm]; exact_mod_cast hm
  obtain ⟨x, y, hx, hy, hxy⟩ := one_lt_encard_iff.mp h1
  obtain ⟨βx, hβx, a₁, a₂, ha₁, ha₂, Hx, hxe⟩ := hrH x hx
  obtain ⟨βy, hβy, b₁, b₂, hb₁, hb₂, Hy, hye⟩ := hrH y hy
  -- one sector per ray
  have huniq : ∀ S ∈ F.sectorsOf v r c, ∀ β κ₁ κ₂, F.IsHorn v β κ₁ κ₂ c → S = hornSet v β κ₁ κ₂ r →
      ∀ S' ∈ F.sectorsOf v r c, ∀ κ₁' κ₂', F.IsHorn v β κ₁' κ₂' c → S' = hornSet v β κ₁' κ₂' r → S = S' := by
    intro S _ β κ₁ κ₂ H hSe S' _ κ₁' κ₂' H' hSe'
    obtain ⟨e1, e2⟩ := horn_unique_of_stuck hF hvd hR hSh H H'
    rw [hSe, hSe', e1, e2]
  have hβne : βx ≠ βy := by
    intro he
    rw [he] at Hx hxe
    exact hxy (huniq x hx βy a₁ a₂ Hx hxe y hy b₁ b₂ Hy hye)
  -- at most two sectors
  have hsub : F.sectorsOf v r c ⊆ {x, y} := by
    intro S hS'
    obtain ⟨β, hβ, κ₁, κ₂, -, -, H, hSe⟩ := hrH S hS'
    have hβ' : β = βx ∨ β = βy := by
      simp only [mem_insert_iff, mem_singleton_iff] at hβ hβx hβy
      rcases hβ with rfl | rfl <;> rcases hβx with rfl | rfl <;> rcases hβy with rfl | rfl <;>
        first | exact Or.inl rfl | exact Or.inr rfl | exact absurd rfl hβne
    rcases hβ' with rfl | rfl
    · exact Or.inl (huniq S hS' β κ₁ κ₂ H hSe x hx a₁ a₂ Hx hxe)
    · exact Or.inr (huniq S hS' β κ₁ κ₂ H hSe y hy b₁ b₂ Hy hye)
  have hm2 : m = 2 := by
    have hle : (F.sectorsOf v r c).encard ≤ 2 :=
      (encard_le_encard hsub).trans ((encard_insert_le _ _).trans (by rw [encard_singleton]; rfl))
    rw [hrm] at hle
    have : m ≤ 2 := by exact_mod_cast hle
    omega
  have hc2 : F.HasSectors v c 2 := hm2 ▸ hc
  simp only [mem_insert_iff, mem_singleton_iff] at hβx hβy
  rcases hβx with rfl | rfl
  · have hβy' : βy = βx + π := by
      rcases hβy with h | h
      · exact absurd h.symm hβne
      · exact h
    rw [hβy'] at Hy
    exact ⟨βx, a₁, a₂, b₁, b₂, Hx, Hy, ha₁, ha₂, hb₁, hb₂, hc2, hN, hS⟩
  · have hβy' : βy = α := by
      rcases hβy with h | h
      · exact h
      · exact absurd h.symm hβne
    rw [hβy'] at Hy
    exact ⟨α, b₁, b₂, a₁, a₂, Hy, Hx, hb₁, hb₂, ha₁, ha₂, hc2, hN, hS⟩


/-- **N4-STUCK (ii) with unit arcs: the flanks** — the open part of `stuck_structure_ua` once `stuck_horns_ua` has given the horns. At a stuck vertex
with at most three colours whose two-sector colour `c` has horns along `±e α` (curvatures in `[−1, 1]`) and out-type contacts at both poles: the
flank colours are two, `g` on the `+n` side of both horns and `h` on the `−n` side, distinct and other than `c`; they and `c` are the colours at `v`;
the degree is `4`; and off the parabola `|frameY| = ‖z − v‖²/2` the `+n` side is `g` and the `−n` side `h` (ruling 252's form (b)). FS110-N4-FLANK and
N4-SHAVE with unit arcs (S–V Prop. 7's flank argument): wave 4's `stuck_structure_flanks` proves it under Condition 5 with strict curvatures, where
a horn arc on `ω(v ± n)` cannot occur. Route (FS114-CV § 1.4's re-derivation, `Plane/ValidMap/FlankUA`): no SHAVE makes each flank colour shadow
its horn at every scale (`shadow_of_not_shave`); the upper flank's shadow comes from an in-type contact at `N` or an out-type one at `S′`, the lower
flank's from in-type at `S′` or out-type at `N` (`srcG_of_shadow`, `srcH_of_shadow`), so their allowed cones lie in `d·n ≥ 0` and `d·n ≤ 0`; the flanks
differ (`flank_ne_of_shadows`); the directions `±n` then force the turned horn's flanks to be the same two colours; every contact of `g` is in-type at `N`
or out-type at `S′` (`h` the mirror), so no MERGE leaves each one sector (`hasSectors_one_of_contacts`); the sides by `region_far_of_outType` for `c`
and `region_far_N_of_srcH`, `region_far_S_of_srcG` for the flanks. No Condition 5. Since two `c`-sectors are exactly these two horns, the statement is
`stuck_structure_ua`'s conclusion at this axis (the other axis `α + π` is the same configuration with `g ↔ h`). A step of `stuck_structure_ua`'s
proof. Inhabitant of the hypotheses: `bowtie` at `0` (`bowtie_isStuck`, `bowtie_coloursAt_zero`), with the horns `stuck_horns_ua` gives there. -/
theorem stuck_flanks_ua (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) (hst : F.IsStuck v) (h3 : (F.coloursAt v).ncard ≤ 3)
    {c : Fin k} {α κ₁ κ₂ κ₃ κ₄ : ℝ} (Hu : F.IsHorn v α κ₁ κ₂ c) (Hd : F.IsHorn v (α + π) κ₃ κ₄ c)
    (h1 : -1 ≤ κ₁) (h2 : κ₂ ≤ 1) (h3' : -1 ≤ κ₃) (h4 : κ₄ ≤ 1) (hc2 : F.HasSectors v c 2)
    (hN : F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2)))
    (hS : F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) :
    ∃ g h : Fin k, F.HasDegree v 4 ∧ F.coloursAt v = {c, g, h} ∧ g ≠ h ∧ g ≠ c ∧ h ≠ c ∧
      F.IsFlankAbove v α κ₂ g ∧ F.IsFlankBelow v α κ₁ h ∧ F.IsFlankAbove v (α + π) κ₄ h ∧ F.IsFlankBelow v (α + π) κ₃ g ∧
      (∀ᶠ ρ in 𝓝[>] (0 : ℝ), ∀ z ∈ F.interiorPts ∩ ball v ρ,
        (‖z - v‖ ^ 2 / 2 < frameY v α z → F.col z = g) ∧ (frameY v α z < -(‖z - v‖ ^ 2 / 2) → F.col z = h)) := by
  have hvd : v ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  obtain ⟨hcNc, hcNo⟩ := hN
  obtain ⟨hcSc, hcSo⟩ := hS
  obtain ⟨hM, -, hSh, -⟩ := hst
  -- the four flanks, none of colour `c`
  obtain ⟨g, hgu⟩ := Hu.exists_flankAbove hvd
  obtain ⟨h, hhu⟩ := Hu.exists_flankBelow hvd
  obtain ⟨h', hhd⟩ := Hd.exists_flankAbove hvd
  obtain ⟨g', hgd⟩ := Hd.exists_flankBelow hvd
  have band_ne : ∀ {β κ κ' : ℝ} {j : Fin k}, κ < κ' → (∀ᶠ ρ in 𝓝[>] (0 : ℝ), hornSet v β κ κ' ρ ⊆ F.region j) →
      (∀ z ρ, z ∈ hornSet v β κ κ' ρ → (∀ r', z ∉ hornSet v α κ₁ κ₂ r') ∧ ∀ r', z ∉ hornSet v (α + π) κ₃ κ₄ r') →
      j ≠ c := by
    intro β κ κ' j hlt hev hoff hjc
    subst hjc
    exact false_of_third_point hvd hc2 Hu Hd fun ρ hρ => by
      obtain ⟨p, hp, hpb⟩ := exists_mem_hornSet_near hlt hev hρ
      exact ⟨p, hp, hpb.1, hoff p ρ hpb⟩
  have hgc : g ≠ c := by
    obtain ⟨κ', hκ', hev⟩ := id hgu
    refine band_ne hκ' hev fun z ρ hz => ⟨fun r' hz' => lt_asymm hz.2.2.1 hz'.2.2.2, fun r' hz' => ?_⟩
    have := hz'.2.1; rw [frameX_add_pi] at this; linarith [hz.2.1]
  have hhc : h ≠ c := by
    obtain ⟨κ', hκ', hev⟩ := id hhu
    refine band_ne hκ' hev fun z ρ hz => ⟨fun r' hz' => lt_asymm hz'.2.2.1 hz.2.2.2, fun r' hz' => ?_⟩
    have := hz'.2.1; rw [frameX_add_pi] at this; linarith [hz.2.1]
  have hh'c : h' ≠ c := by
    obtain ⟨κ', hκ', hev⟩ := id hhd
    refine band_ne hκ' hev fun z ρ hz => ⟨fun r' hz' => ?_, fun r' hz' => lt_asymm hz.2.2.1 hz'.2.2.2⟩
    have := hz.2.1; rw [frameX_add_pi] at this; linarith [hz'.2.1]
  have hg'c : g' ≠ c := by
    obtain ⟨κ', hκ', hev⟩ := id hgd
    refine band_ne hκ' hev fun z ρ hz => ⟨fun r' hz' => ?_, fun r' hz' => lt_asymm hz'.2.2.1 hz.2.2.2⟩
    have := hz.2.1; rw [frameX_add_pi] at this; linarith [hz'.2.1]
  -- no SHAVE: every flank colour shadows its horn at every scale, from a source at a pole
  obtain ⟨shg, shh⟩ := shadow_of_not_shave hSh Hu hgu hhu
  obtain ⟨shh', shg'⟩ := shadow_of_not_shave hSh Hd hhd hgd
  have sg := srcG_of_shadow hF hv h1 Hu.1 h2 hgu shg
  have sh := srcH_of_shadow hF hv h1 Hu.1 h2 hhu shh
  have sh' := srcG_of_shadow hF hv h3' Hd.1 h4 hhd shh'
  rw [add_e_add_pi_add, sub_e_add_pi_add] at sh'
  have sg' := srcH_of_shadow hF hv h3' Hd.1 h4 hgd shg'
  rw [sub_e_add_pi_add, add_e_add_pi_add] at sg'
  have hgh : g ≠ h := flank_ne_of_shadows hF hv h1 Hu.1 h2 hgu hhu shg shh
  -- the colours at `v`
  have hcv : c ∈ F.coloursAt v := mem_closure_of_mem_coneAt Hu.mem_coneAt_region
  have hgv : g ∈ F.coloursAt v := mem_closure_of_mem_coneAt hgu.mem_coneAt
  have hhv : h ∈ F.coloursAt v := mem_closure_of_mem_coneAt hhu.mem_coneAt
  have hcol : F.coloursAt v = {c, g, h} := by
    refine (Set.eq_of_subset_of_ncard_le ?_ ?_ (toFinite _)).symm
    · intro x hx
      simp only [mem_insert_iff, mem_singleton_iff] at hx
      rcases hx with rfl | rfl | rfl <;> assumption
    · rw [ncard_eq_three.mpr ⟨c, g, h, hgc.symm, hhc.symm, hgh, rfl⟩]
      exact h3
  -- the directions `±n` and the cones
  have hnot : ∀ {j : Fin k} {w : ℂ} {β : ℝ}, F.IsContact v j w → F.OutType v j w → e β = w - v →
      e β ∉ F.allowedCone v j := by
    intro j w β hcj ho he hD
    have := (hD w hcj).2 ho
    rw [he, dot_self_eq, ← dist_eq_norm, hcj.2.1] at this
    norm_num at this
  have hDir : ∀ β, ∃ j ∈ F.coloursAt v, e β ∈ F.allowedCone v j := fun β => by
    obtain ⟨j, hj⟩ := F.exists_mem_coneAt_region hvd β
    exact ⟨j, mem_closure_of_mem_coneAt hj, coneAt_subset_allowedCone hF hv hj⟩
  have hn_eq : e (α + π / 2) = v + e (α + π / 2) - v := by ring
  have hs_eq : e (α + π / 2 + π) = v - e (α + π / 2) - v := by rw [e_add_pi']; ring
  have hnn : dot (e (α + π / 2)) (e (α + π / 2)) = 1 := by rw [dot_self_eq, norm_e]; norm_num
  have hsn : dot (e (α + π / 2 + π)) (e (α + π / 2)) = -1 := by rw [e_add_pi', dot_neg_left, hnn]
  -- the turned horn's flanks are the same two colours
  have hg'g : g' = g := by
    have hg'v : g' ∈ F.coloursAt v := mem_closure_of_mem_coneAt hgd.mem_coneAt
    rw [hcol] at hg'v
    simp only [mem_insert_iff, mem_singleton_iff] at hg'v
    rcases hg'v with h'' | h'' | h''
    · exact absurd h'' hg'c
    · exact h''
    · exfalso
      obtain ⟨j, hj, hjD⟩ := hDir (α + π / 2 + π)
      rw [hcol] at hj
      simp only [mem_insert_iff, mem_singleton_iff] at hj
      rcases hj with rfl | rfl | rfl
      · exact hnot hcSc hcSo hs_eq hjD
      · have := dot_nonneg_of_srcG sg hjD; linarith
      · have := dot_nonneg_of_srcG (h'' ▸ sg') hjD; linarith
  have hh'h : h' = h := by
    have hh'v : h' ∈ F.coloursAt v := mem_closure_of_mem_coneAt hhd.mem_coneAt
    rw [hcol] at hh'v
    simp only [mem_insert_iff, mem_singleton_iff] at hh'v
    rcases hh'v with h'' | h'' | h''
    · exact absurd h'' hh'c
    · exfalso
      obtain ⟨j, hj, hjD⟩ := hDir (α + π / 2)
      rw [hcol] at hj
      simp only [mem_insert_iff, mem_singleton_iff] at hj
      rcases hj with rfl | rfl | rfl
      · exact hnot hcNc hcNo hn_eq hjD
      · have := dot_nonpos_of_srcH (h'' ▸ sh') hjD; linarith
      · have := dot_nonpos_of_srcH sh hjD; linarith
    · exact h''
  subst g' h'
  -- `n ∈ D_g`, `−n ∈ D_h`
  have hDgn : e (α + π / 2) ∈ F.allowedCone v g := by
    obtain ⟨j, hj, hjD⟩ := hDir (α + π / 2)
    rw [hcol] at hj
    simp only [mem_insert_iff, mem_singleton_iff] at hj
    rcases hj with rfl | rfl | rfl
    · exact absurd hjD (hnot hcNc hcNo hn_eq)
    · exact hjD
    · have := dot_nonpos_of_srcH sh hjD; linarith
  have hDhs : e (α + π / 2 + π) ∈ F.allowedCone v h := by
    obtain ⟨j, hj, hjD⟩ := hDir (α + π / 2 + π)
    rw [hcol] at hj
    simp only [mem_insert_iff, mem_singleton_iff] at hj
    rcases hj with rfl | rfl | rfl
    · exact absurd hjD (hnot hcSc hcSo hs_eq)
    · have := dot_nonneg_of_srcG sg hjD; linarith
    · exact hjD
  have hDga := coneAt_subset_allowedCone hF hv hgu.mem_coneAt
  have hDgb := coneAt_subset_allowedCone hF hv hgd.mem_coneAt
  have hDha := coneAt_subset_allowedCone hF hv hhu.mem_coneAt
  have hDhb := coneAt_subset_allowedCone hF hv hhd.mem_coneAt
  have hpi : ∀ u : ℂ, dot (e (α + π)) u = -dot (e α) u := fun u => by rw [e_add_pi', dot_neg_left]
  have hsn' : ∀ u : ℂ, dot (e (α + π / 2 + π)) u = -dot (e (α + π / 2)) u := fun u => by
    rw [e_add_pi', dot_neg_left]
  -- `g`'s contacts: in-type at `N` or out-type at `S′`; `h`'s: in-type at `S′` or out-type at `N`
  have hiiig : ∀ w, F.IsContact v g w →
      (w - v = e (α + π / 2) ∧ F.InType v g w) ∨ (w - v = -e (α + π / 2) ∧ F.OutType v g w) := by
    intro w hw
    rcases (contact_inType_or_outType hF hv hw).1 with hin | hout
    · have a1 := (hDga w hw).1 hin
      have a2 := (hDgb w hw).1 hin
      have a3 := (hDgn w hw).1 hin
      rw [hpi] at a2
      have hx0 : frameX v α w = 0 := by rw [← dot_e_sub_eq_frameX]; linarith
      rcases eq_N_or_S_of_frameX_eq_zero hw.2.1 hx0 with hN | hS
      · rw [dist_eq_zero] at hN
        subst hN
        exact Or.inl ⟨by ring, hin⟩
      · exfalso
        rw [dist_eq_zero] at hS
        subst hS
        rw [show v - e (α + π / 2) - v = -e (α + π / 2) by ring, dot_neg_right, hnn] at a3
        norm_num at a3
    · have a1 := (hDga w hw).2 hout
      have a2 := (hDgb w hw).2 hout
      have a3 := (hDgn w hw).2 hout
      rw [hpi] at a2
      have hx0 : frameX v α w = 0 := by rw [← dot_e_sub_eq_frameX]; linarith
      rcases eq_N_or_S_of_frameX_eq_zero hw.2.1 hx0 with hN | hS
      · exfalso
        rw [dist_eq_zero] at hN
        subst hN
        rw [add_sub_cancel_left, hnn] at a3
        norm_num at a3
      · rw [dist_eq_zero] at hS
        subst hS
        exact Or.inr ⟨by ring, hout⟩
  have hiiih : ∀ w, F.IsContact v h w →
      (w - v = -e (α + π / 2) ∧ F.InType v h w) ∨ (w - v = -(-e (α + π / 2)) ∧ F.OutType v h w) := by
    intro w hw
    rcases (contact_inType_or_outType hF hv hw).1 with hin | hout
    · have a1 := (hDha w hw).1 hin
      have a2 := (hDhb w hw).1 hin
      have a3 := (hDhs w hw).1 hin
      rw [hpi] at a2
      rw [hsn'] at a3
      have hx0 : frameX v α w = 0 := by rw [← dot_e_sub_eq_frameX]; linarith
      rcases eq_N_or_S_of_frameX_eq_zero hw.2.1 hx0 with hN | hS
      · exfalso
        rw [dist_eq_zero] at hN
        subst hN
        rw [add_sub_cancel_left, hnn] at a3
        norm_num at a3
      · rw [dist_eq_zero] at hS
        subst hS
        exact Or.inl ⟨by ring, hin⟩
    · have a1 := (hDha w hw).2 hout
      have a2 := (hDhb w hw).2 hout
      have a3 := (hDhs w hw).2 hout
      rw [hpi] at a2
      rw [hsn'] at a3
      have hx0 : frameX v α w = 0 := by rw [← dot_e_sub_eq_frameX]; linarith
      rcases eq_N_or_S_of_frameX_eq_zero hw.2.1 hx0 with hN | hS
      · rw [dist_eq_zero] at hN
        subst hN
        exact Or.inr ⟨by ring, hout⟩
      · exfalso
        rw [dist_eq_zero] at hS
        subst hS
        rw [show v - e (α + π / 2) - v = -e (α + π / 2) by ring, dot_neg_right, hnn] at a3
        norm_num at a3
  -- no MERGE: one sector each, degree `4`
  have hg1 : F.HasSectors v g 1 := hasSectors_one_of_contacts hF hv hM (norm_e _) hgv hiiig
  have hh1 : F.HasSectors v h 1 :=
    hasSectors_one_of_contacts hF hv hM (by rw [norm_neg, norm_e]) hhv hiiih
  have hdeg : F.HasDegree v 4 := hasDegree_of_three_colours hcol hgc.symm hhc.symm hgh hc2 hg1 hh1
  -- the sides, outside the parabolas `frameY = ±‖z − v‖²/2`
  obtain ⟨ε₁, hε₁, hf₁⟩ := region_far_of_outType hF hv hcNc hcNo
  obtain ⟨ε₂, hε₂, hf₂⟩ := region_far_N_of_srcH hF hv sh
  obtain ⟨ε₃, hε₃, hf₃⟩ := region_far_of_outType hF hv hcSc hcSo
  obtain ⟨ε₄, hε₄, hf₄⟩ := region_far_S_of_srcG hF hv sg
  have hsides : ∀ᶠ ρ in 𝓝[>] (0 : ℝ), ∀ z ∈ F.interiorPts ∩ ball v ρ,
      (‖z - v‖ ^ 2 / 2 < frameY v α z → F.col z = g) ∧ (frameY v α z < -(‖z - v‖ ^ 2 / 2) → F.col z = h) := by
    filter_upwards [eventually_col_mem_coloursAt v,
      Ioo_mem_nhdsGT (lt_min (lt_min hε₁ hε₂) (lt_min hε₃ hε₄))] with ρ hρ hρε z hz
    have hzv : dist z v < min (min ε₁ ε₂) (min ε₃ ε₄) := lt_of_lt_of_le hz.2 hρε.2.le
    have hcz := hρ z hz
    have hzr : z ∈ F.region (F.col z) := ⟨hz.1, mem_singleton _⟩
    rw [hcol] at hcz
    simp only [mem_insert_iff, mem_singleton_iff] at hcz
    constructor
    · intro hY
      have hN : dist z (v + e (α + π / 2)) < 1 := by
        rw [← tanAbove_one_iff]
        show 0 < tanHeight 1 (frameX v α z) (frameY v α z)
        unfold tanHeight
        rw [frame_normSq]
        linarith
      rcases hcz with h' | h' | h'
      · exact absurd (hf₁ z (h' ▸ hzr) (lt_of_lt_of_le hzv ((min_le_left _ _).trans (min_le_left _ _)))) (not_le.mpr hN)
      · exact h'
      · exact absurd (hf₂ z (h' ▸ hzr) (lt_of_lt_of_le hzv ((min_le_left _ _).trans (min_le_right _ _)))) (not_le.mpr hN)
    · intro hY
      have hS : dist z (v - e (α + π / 2)) < 1 := by
        rw [← tanBelow_neg_one_iff]
        show tanHeight (-1) (frameX v α z) (frameY v α z) < 0
        unfold tanHeight
        rw [frame_normSq]
        linarith
      rcases hcz with h' | h' | h'
      · exact absurd (hf₃ z (h' ▸ hzr) (lt_of_lt_of_le hzv ((min_le_right _ _).trans (min_le_left _ _)))) (not_le.mpr hS)
      · exact absurd (hf₄ z (h' ▸ hzr) (lt_of_lt_of_le hzv ((min_le_right _ _).trans (min_le_right _ _)))) (not_le.mpr hS)
      · exact h'
  exact ⟨g, h, hdeg, hcol, hgh, hgc, hhc, hgu, hhu, hhd, hgd, hsides⟩

/-- **N4-STUCK (i)–(ii) with unit arcs** (FS112-WALK, row 5; used by FS114-CV's and CVB's arguments as "N4-STUCK's structure (i)–(ii) …
in `[−1, 1]`", `plans/FS114-CVB-verification.md` § 1.3). Not a backlog row (FS112-WALK is declined, a verdict table): a supporting lemma
of wave 5. At a stuck vertex `v` of a valid map with at most three colours there, the colour `c` with two or more sectors has exactly two,
cusp horns along `±e α` with bounding curvatures in `[−1, 1]`, out-type `c`-contacts at `v ± n`; `P_cl(v) = {c, g, h}` with degree `4`,
the interior points near `v` above the parabola `frameY = ‖z − v‖²/2` of colour `g` and below `frameY = −‖z − v‖²/2` of colour `h` (the sides
clause in inventory item 252's form (b), the point form outside the parabola: both horns, of curvatures in `[−1, 1]`, lie in
`|frameY| ≤ ‖z − v‖²/2`, so "the side off the horns is filled by `g` above and `h` below", as the derivation's (ii) says), `g` the upper flank
and `h` the lower flank of both horns (the flank conjuncts, kept beside it by the same ruling). Inhabitant of the hypotheses: `bowtie` at `0`
(`bowtie_isStuck`, `bowtie_coloursAt_zero`). -/
theorem stuck_structure_ua (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) (hst : F.IsStuck v)
    (h3 : (F.coloursAt v).ncard ≤ 3) {c : Fin k} {m : ℕ} (hm : 2 ≤ m) (hc : F.HasSectors v c m) :
    ∃ α κ₁ κ₂ κ₃ κ₄ : ℝ, ∃ g h : Fin k,
      F.IsHorn v α κ₁ κ₂ c ∧ F.IsHorn v (α + π) κ₃ κ₄ c ∧ -1 ≤ κ₁ ∧ κ₂ ≤ 1 ∧ -1 ≤ κ₃ ∧ κ₄ ≤ 1 ∧
      F.HasSectors v c 2 ∧ F.HasDegree v 4 ∧ F.coloursAt v = {c, g, h} ∧ g ≠ h ∧ g ≠ c ∧ h ≠ c ∧
      F.IsFlankAbove v α κ₂ g ∧ F.IsFlankBelow v α κ₁ h ∧ F.IsFlankAbove v (α + π) κ₄ h ∧ F.IsFlankBelow v (α + π) κ₃ g ∧
      (∀ᶠ ρ in 𝓝[>] (0 : ℝ), ∀ z ∈ F.interiorPts ∩ ball v ρ,
        (‖z - v‖ ^ 2 / 2 < frameY v α z → F.col z = g) ∧ (frameY v α z < -(‖z - v‖ ^ 2 / 2) → F.col z = h)) ∧
      (F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2))) ∧
      (F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) := by
  obtain ⟨α, κ₁, κ₂, κ₃, κ₄, Hu, Hd, h1, h2, h3', h4, hc2, hN, hS⟩ := stuck_horns_ua hF hv hst hm hc
  obtain ⟨g, h, hdeg, hcol, hgh, hgc, hhc, fa, fb, fa', fb', hsides⟩ :=
    stuck_flanks_ua hF hv hst h3 Hu Hd h1 h2 h3' h4 hc2 hN hS
  exact ⟨α, κ₁, κ₂, κ₃, κ₄, g, h, Hu, Hd, h1, h2, h3', h4, hc2, hdeg, hcol, hgh, hgc, hhc, fa, fb, fa', fb', hsides, hN, hS⟩

/-- **Every colour at a chain vertex approaches it along both directions of one axis** (`stuck_structure_ua`: `c`'s two horns, `g` and `h`
flanking both). Inhabitant of the hypotheses: `bowtie` at `0` (`bowtie_isStuck`, `bowtie_coloursAt_zero`). -/
theorem chainVertex_antipodal (hF : F.Valid) {E : ℂ} (hv : F.Covers E 1) (hst : F.IsStuck E)
    (h3 : (F.coloursAt E).ncard ≤ 3) :
    ∃ α : ℝ, ∀ j ∈ F.coloursAt E, α ∈ coneAt (F.region j) E ∧ α + π ∈ coneAt (F.region j) E := by
  obtain ⟨c, m, hm, hc⟩ := hst.2.2.2
  obtain ⟨α, κ₁, κ₂, κ₃, κ₄, g, h, Hu, Hd, -, -, -, -, -, -, hcol, -, -, -, fa, fb, fa', fb', -⟩ :=
    stuck_structure_ua hF hv hst h3 hm hc
  refine ⟨α, fun j hj => ?_⟩
  rw [hcol] at hj
  simp only [mem_insert_iff, mem_singleton_iff] at hj
  rcases hj with rfl | rfl | rfl
  · exact ⟨Hu.mem_coneAt_region, Hd.mem_coneAt_region⟩
  · exact ⟨fa.mem_coneAt, fb'.mem_coneAt⟩
  · exact ⟨fb.mem_coneAt, fa'.mem_coneAt⟩

/-! ## FS112-N2-TERM, with FS112-N2-RED as its lemma -/

/-- **FS112-N2-RED** (merged into FS112-N2-TERM as its lemma, SR2 item 13): every valid map of the plane has a valid modification —
the same domain, no unit arc created, every point of at least four colours carrying those colours in the map itself — in which every
unit arc is (Q) or (R2). "By W-MERGE and whole-arc bends" and "the procedure terminates with no stubs" are the proof's content (the
modification is the limit of the procedure). Inhabitant of the hypotheses: `sevenBrickMap` at seven colours (no unit arc: itself). -/
theorem exists_red (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ M : ArcMap k, F.IsModification M ∧ M.Valid ∧ M.QROnly := by
  sorry

/-- **FS112-N2-TERM**: every valid six-coloured map of the plane has a valid modification `M*` (the same domain, no unit arc created,
four-colour points' colours kept) which is a terminal valid map (`IsTerminalMap`: no MERGE, MERGE-RAY or SHAVE anywhere, every unit
arc (Q) or (R2)), in which (clause 2) every vertex — a point of at least three colours or with a repeated colour — is cubic
trichromatic, carries at least four colours (an NB4P exception), or is stuck; and (clause 3) every vertex stuck along `e α` lies on a
stuck run that is not bi-infinite, each finite end (the last chain vertex) within distance `1` of a point of a (Q) or (R2) arc or of a
point of at least four colours, and every horn bound `±1` at a vertex of the run, along `±e α`, a (Q) or (R2) arc. "One-sided infinite
chains are a GAP" is a not-claimed clause: nothing is stated about them. Inhabitant of the hypotheses: none at six colours is known
(a valid six-map of the plane is FS-114's open question); the statement's class at seven colours is inhabited by `sevenBrickMap`. -/
theorem exists_terminal {F : ArcMap 6} (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ M : ArcMap 6, F.IsModification M ∧ M.IsTerminalMap ∧
      (∀ x ∈ M.dom, 3 ≤ (M.coloursAt x).ncard ∨ M.HasRepeatedColour x →
        M.IsCubicTrichromatic x ∨ 4 ≤ (M.coloursAt x).ncard ∨ M.IsStuck x) ∧
      ∀ v α, M.StuckAlong v α → (M.coloursAt v).ncard ≤ 3 →
        M.stuckRun v α ≠ univ ∧
        (∀ j ∈ M.stuckRun v α, (j + 1 ∉ M.stuckRun v α ∨ j - 1 ∉ M.stuckRun v α) →
          ∃ z, dist z (v + (j : ℂ) * e (α + π / 2)) ≤ 1 ∧ (M.OnQR2Arc z ∨ 4 ≤ (M.coloursAt z).ncard)) ∧
        ∀ j ∈ M.stuckRun v α, M.HornBoundsQR (v + (j : ℂ) * e (α + π / 2)) α ∧
          M.HornBoundsQR (v + (j : ℂ) * e (α + π / 2)) (α + π) := by
  sorry

/-! ## FLANK-Q unconditional (wave 4's obligation, inventory item 79) -/

/-- **FS112-N2-FLANK-Q, the upper bound, unconditional** in any map whose unit arcs are all (Q) or (R2) (`QROnly`, N2-TERM's clause 1,
so in every `M*`): wave 4's `flankQ_upper` with its named hypothesis `hQR` discharged. Inhabitant of the local hypotheses: `bowtie` at
`0` (its arcs at `i` are (Q)); `QROnly` on the whole map is inhabited by the one-colour plane (`const_qrOnly`). -/
theorem flankQ_upper_of_qrOnly (hF : F.Valid) (hQR : F.QROnly) {v : ℂ} (hv : F.Covers v 1) {α κ₁ : ℝ} {c g : Fin k}
    (hH : F.IsHorn v α κ₁ 1 c) (hg : F.IsFlankAbove v α 1 g)
    (hcN : F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2))) :
    ∃ θ₂, α - π / 2 < θ₂ ∧ F.IsRingArc (v + e (α + π / 2)) (α - π / 2) θ₂ g c ∧
      ((F.IsQArc (v + e (α + π / 2)) (α - π / 2) θ₂ ∧
          ∃ T, F.TileOf g T ∧ T ⊆ ball v 1 ∧ v + e (α + π / 2) ∈ closure T) ∨
        (F.IsR2Arc (v + e (α + π / 2)) (α - π / 2) θ₂ ∧ g ∉ F.coloursAt (v + e (α + π / 2)) ∧
          v - e (α + π / 2) ∈ closure (F.region g) ∧ F.OutType v g (v - e (α + π / 2)) ∧
          ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ₁ 1 r ⊆ shadow (F.region g))) :=
  flankQ_upper hF hv hH hg hcN fun _ _ _ _ h => hQR _ _ _ _ _ h

/-- **FS112-N2-FLANK-Q, the lower bound, unconditional** (the mirror; `flankQ_lower` with `hQR` discharged by `QROnly`). -/
theorem flankQ_lower_of_qrOnly (hF : F.Valid) (hQR : F.QROnly) {v : ℂ} (hv : F.Covers v 1) {α κ₂ : ℝ} {c h : Fin k}
    (hH : F.IsHorn v α (-1) κ₂ c) (hh : F.IsFlankBelow v α (-1) h)
    (hcS : F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) :
    ∃ θ₁, θ₁ < α + π / 2 ∧ F.IsRingArc (v - e (α + π / 2)) θ₁ (α + π / 2) h c ∧
      ((F.IsQArc (v - e (α + π / 2)) θ₁ (α + π / 2) ∧
          ∃ T, F.TileOf h T ∧ T ⊆ ball v 1 ∧ v - e (α + π / 2) ∈ closure T) ∨
        (F.IsR2Arc (v - e (α + π / 2)) θ₁ (α + π / 2) ∧ h ∉ F.coloursAt (v - e (α + π / 2)) ∧
          v + e (α + π / 2) ∈ closure (F.region h) ∧ F.OutType v h (v + e (α + π / 2)) ∧
          ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α (-1) κ₂ r ⊆ shadow (F.region h))) :=
  flankQ_lower hF hv hH hh hcS fun _ _ _ _ h => hQR _ _ _ _ _ h

/-! ## FS114-CV-HD: CV-L0, the main clause, the equivalences, CV-CLASS -/

/-- **FS114-CV-HD, (CV-L0)**: in a terminal valid map a stuck vertex with at most three colours centres no unit arc, so `Γ ∩ ω(E)` is
finite. No model of a stuck vertex in a terminal valid plane map is known (`GENERIC`: FS-115's question); `bowtie` inhabits the local
hypotheses on a fragment. -/
theorem cv_l0 (hM : F.IsTerminalMap) {E : ℂ} (hst : F.IsStuck E) (h3 : (F.coloursAt E).ncard ≤ 3) :
    (∀ x, ¬ F.OnRingArc E x) ∧ (F.Γ ∩ sphere E 1).Finite := by
  obtain ⟨hF, hP, -, hQR⟩ := hM
  have hv : F.Covers E 1 := fun z _ => by rw [hP]; exact mem_univ z
  obtain ⟨c, m, hm, hc⟩ := hst.2.2.2
  obtain ⟨α, κ₁, κ₂, κ₃, κ₄, g, h, Hu, Hd, -, -, -, -, -, -, hcol, -, -, -, fa, fb, fa', fb', -⟩ :=
    stuck_structure_ua hF hv hst h3 hm hc
  -- every colour at `E` approaches `E` along `e α` and along `e (α + π)`
  have hanti : ∀ j ∈ F.coloursAt E, α ∈ coneAt (F.region j) E ∧ α + π ∈ coneAt (F.region j) E := by
    intro j hj
    rw [hcol] at hj
    simp only [mem_insert_iff, mem_singleton_iff] at hj
    rcases hj with rfl | rfl | rfl
    · exact ⟨Hu.mem_coneAt_region, Hd.mem_coneAt_region⟩
    · exact ⟨fa.mem_coneAt, fb'.mem_coneAt⟩
    · exact ⟨fb.mem_coneAt, fa'.mem_coneAt⟩
  have hno : ∀ x, ¬ F.OnRingArc E x := by
    intro x hx
    obtain ⟨a, b, d, d', hab, hR, -⟩ := exists_isRingArc_of_onRingArc hx one_pos
    -- its outer colour is carried at `E`: it is (Q) or (R2)
    have hmid : (a + b) / 2 ∈ Ioo a b := ⟨by linarith, by linarith⟩
    have hd' : d' ∈ F.coloursAt E := by
      rcases hQR _ _ _ _ _ hR with ⟨e₁, e₂, hR', -, he₂, -⟩ | ⟨e₁, e₂, hR', he₂, -, -⟩
      · have h12 := (hR.2.2 _ hmid).2.symm.trans (hR'.2.2 _ hmid).2
        rw [Set.singleton_eq_singleton_iff] at h12
        rw [h12]; exact he₂
      · have h12 := (hR.2.2 _ hmid).2.symm.trans (hR'.2.2 _ hmid).2
        rw [Set.singleton_eq_singleton_iff] at h12
        rw [h12]; exact he₂
    -- the outer colour's cone at the centre is shorter than `π` (U1), and holds `α` and `α + π`
    obtain ⟨h1, h2⟩ := hanti d' hd'
    have hcone := ringArc_cone_outer hF hR
    exact not_mem_angleIcc_add_pi (by linarith) (hcone h1) (hcone h2)
  exact ⟨hno, (F.finite_ringΓ_off_ringArc hv).subset fun x hx => ⟨hx, hno x⟩⟩

/-- **FS114-CV-HD, the main clause**: in a terminal valid six-coloured map, at a stuck vertex `E` with three colours whose two-sector
colour `c` has horns along `±e α`, both upper bounds `1` (the `+e α` horn's upper arc and the `−e α` horn's arc on the `N` side on
`ω(N)`: `κ₂ = 1`, `κ₃ = −1`) and no in-type lower-flank tile at `E − n` is impossible. A step inside a proof by contradiction where no
model is expected (`cv_hd`'s cycle consumes it). -/
theorem cv_hd_main {F : ArcMap 6} (hM : F.IsTerminalMap) {E : ℂ} (hst : F.IsStuck E) (h3 : (F.coloursAt E).ncard = 3)
    {c : Fin 6} (hc2 : F.HasSectors E c 2) {α κ₁ κ₂ κ₃ κ₄ : ℝ} (hH : F.IsHorn E α κ₁ κ₂ c)
    (hH' : F.IsHorn E (α + π) κ₃ κ₄ c) {h : Fin 6} (hh : F.IsFlankBelow E α κ₁ h)
    (hυ : κ₂ = 1 ∧ κ₃ = -1)
    (hnoHS : ¬ (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2)))) : False := by
  sorry

/-- **FS114-CV-HD, the equivalences**: in a terminal valid six-coloured map, at a stuck vertex `E` with three colours (horns of `c` along
`±e α`, upper flank `g`, lower flank `h`), the four conditions are equivalent — `G_N` (an in-type `g`-contact at `N`), `H_S` (an in-type
`h`-contact at `S`), `υ± = 1` (`κ₂ = 1 ∧ κ₃ = −1`: both horns' `N`-side arcs on `ω(N)`) and `λ± = −1` (`κ₁ = −1 ∧ κ₄ = 1`: both `S`-side
arcs on `ω(S)`). Model of the local hypotheses with all four conditions: `bowtie` at `0` (a fragment; `GENERIC` on terminal plane maps). -/
theorem cv_hd {F : ArcMap 6} (hM : F.IsTerminalMap) {E : ℂ} (hst : F.IsStuck E) (h3 : (F.coloursAt E).ncard = 3)
    {c : Fin 6} (hc2 : F.HasSectors E c 2) {α κ₁ κ₂ κ₃ κ₄ : ℝ} (hH : F.IsHorn E α κ₁ κ₂ c)
    (hH' : F.IsHorn E (α + π) κ₃ κ₄ c) {g h : Fin 6} (hg : F.IsFlankAbove E α κ₂ g) (hh : F.IsFlankBelow E α κ₁ h) :
    ((F.IsContact E g (E + e (α + π / 2)) ∧ F.InType E g (E + e (α + π / 2))) ↔
        (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2)))) ∧
      ((F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2))) ↔ (κ₂ = 1 ∧ κ₃ = -1)) ∧
      ((κ₂ = 1 ∧ κ₃ = -1) ↔ (κ₁ = -1 ∧ κ₄ = 1)) := by
  sorry

/-- **FS114-CV-HD, (CV-CLASS)**: a stuck vertex of a terminal valid six-coloured map (three colours, horns of `c` along `±e α`, upper
flank `g`, lower flank `h`) is a bowtie — all four horn arcs unit arcs, both neighbours carrying at least four colours and centring
both-kind arcs, a one-vertex chain — or carries `g` twice at `E − n` and `h` twice at `E + n`, each neighbour stuck or with at least four
colours. Model of the local hypotheses (the bowtie case): `bowtie` at `0`. -/
theorem cv_class {F : ArcMap 6} (hM : F.IsTerminalMap) {E : ℂ} (hst : F.IsStuck E) (h3 : (F.coloursAt E).ncard = 3)
    {c : Fin 6} (hc2 : F.HasSectors E c 2) {α κ₁ κ₂ κ₃ κ₄ : ℝ} (hH : F.IsHorn E α κ₁ κ₂ c)
    (hH' : F.IsHorn E (α + π) κ₃ κ₄ c) {g h : Fin 6} (hg : F.IsFlankAbove E α κ₂ g) (hh : F.IsFlankBelow E α κ₁ h) :
    (κ₂ = 1 ∧ κ₃ = -1 ∧ κ₁ = -1 ∧ κ₄ = 1 ∧
        4 ≤ (F.coloursAt (E + e (α + π / 2))).ncard ∧ 4 ≤ (F.coloursAt (E - e (α + π / 2))).ncard ∧
        (∃ θ₁ θ₂, F.BothKind (E + e (α + π / 2)) θ₁ θ₂) ∧ (∃ θ₁ θ₂, F.BothKind (E - e (α + π / 2)) θ₁ θ₂) ∧
        F.stuckRun E α = {0}) ∨
      ((∀ᶠ r in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf (E - e (α + π / 2)) r g).encard) ∧
        (∀ᶠ r in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf (E + e (α + π / 2)) r h).encard) ∧
        (F.IsStuck (E + e (α + π / 2)) ∨ 4 ≤ (F.coloursAt (E + e (α + π / 2))).ncard) ∧
        (F.IsStuck (E - e (α + π / 2)) ∨ 4 ≤ (F.coloursAt (E - e (α + π / 2))).ncard)) := by
  sorry

/-! ## FS112-Y3-END-NEEDS (corrected), FS112-C-ENDS, FS112-C-DOUBLE, FS112-N3-END's chain clause -/

/-- **FS112-Y3-END-NEEDS, corrected** (`plans/FS112-YB3-verification.md` § 3.1, YB3-NEEDS; the form FS114-CVB's `¬G_N` branch reads,
`plans/FS114-CVB-verification.md` § 1.6): in a terminal valid six-coloured map of the plane, a stuck vertex `E` with three colours whose
horns' `N`-side arcs both lie on `ω(N)` (`κ₂ = 1`, `κ₃ = −1`), with no in-type upper-flank contact at `N` and no in-type lower-flank
contact at `S` (so `λ_E > −1` on the in-type side: YB3's correction, the bowtie excluded), is impossible — its levels need a seventh
colour. Inventory item 69's supporting lemma (not a backlog row). A step inside a proof by contradiction: no model expected. -/
theorem y3_end_needs {F : ArcMap 6} (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {E : ℂ} (hst : F.IsStuck E)
    (h3 : (F.coloursAt E).ncard = 3) {c : Fin 6} (hc2 : F.HasSectors E c 2) {α κ₁ κ₄ : ℝ}
    (hH : F.IsHorn E α κ₁ 1 c) (hH' : F.IsHorn E (α + π) (-1) κ₄ c) {g h : Fin 6} (hg : F.IsFlankAbove E α 1 g)
    (hh : F.IsFlankBelow E α κ₁ h)
    (hnoG : ¬ (F.IsContact E g (E + e (α + π / 2)) ∧ F.InType E g (E + e (α + π / 2))))
    (hnoH : ¬ (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2)))) : False := by
  sorry

/-- **FS112-C-ENDS** in its erratum's form (caution C116; `plans/FS112-derivation.md:443` item 2) — FS114-CV-HD's (CV-ENDS): in a
terminal valid six-coloured map, the point of the normal line one step beyond each finite end of a stuck chain has at least four colours.
The chain is the stuck run through a vertex stuck along `e α`; its upper end is a member `j` with `j + 1` outside, its lower end a member
with `j − 1` outside. No model of a stuck chain in a terminal valid plane map is known (`GENERIC`, FS-115). -/
theorem c_ends {F : ArcMap 6} (hM : F.IsTerminalMap) {v : ℂ} {α : ℝ} (hv : F.StuckAlong v α) {j : ℤ}
    (hj : j ∈ F.stuckRun v α) :
    (j + 1 ∉ F.stuckRun v α → 4 ≤ (F.coloursAt (v + ((j + 1 : ℤ) : ℂ) * e (α + π / 2))).ncard) ∧
      (j - 1 ∉ F.stuckRun v α → 4 ≤ (F.coloursAt (v + ((j - 1 : ℤ) : ℂ) * e (α + π / 2))).ncard) := by
  sorry

/-- **FS112-C-DOUBLE** (caution C116: a regrade only): in a terminal valid six-coloured map (`IsTerminalMap` — the reading of "terminal
valid map" settled here, § 2.2 of the plan: wave 4's `Terminal` and N2-TERM's clause 1), a stuck vertex `E` with three colours all
four of whose horn arcs are unit arcs (the `+e α` horn between `ω(S)` and `ω(N)`, curvatures `−1` and `1`, and the `−e α` horn likewise
in its own frame) carries an in-type tile of its upper flank colour `g` at `N` and of its lower flank colour `h` at `S`, and both `N`
and `S` carry at least four colours and centre (Q) arcs — the four horn-bounding arcs. Model of the local hypotheses: `bowtie` at `0`
(a fragment; on terminal plane maps `GENERIC`, FS-115). -/
theorem c_double {F : ArcMap 6} (hM : F.IsTerminalMap) {E : ℂ} (hst : F.IsStuck E) (h3 : (F.coloursAt E).ncard = 3)
    {c : Fin 6} (hc2 : F.HasSectors E c 2) {α : ℝ} (hH : F.IsHorn E α (-1) 1 c) (hH' : F.IsHorn E (α + π) (-1) 1 c)
    {g h : Fin 6} (hg : F.IsFlankAbove E α 1 g) (hh : F.IsFlankBelow E α (-1) h) :
    (F.IsContact E g (E + e (α + π / 2)) ∧ F.InType E g (E + e (α + π / 2))) ∧
      (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2))) ∧
      4 ≤ (F.coloursAt (E + e (α + π / 2))).ncard ∧ 4 ≤ (F.coloursAt (E - e (α + π / 2))).ncard ∧
      (∃ θ₂, α - π / 2 < θ₂ ∧ F.IsQArc (E + e (α + π / 2)) (α - π / 2) θ₂) ∧
      (∃ θ₁, θ₁ < α - π / 2 ∧ F.IsQArc (E + e (α + π / 2)) θ₁ (α - π / 2)) ∧
      (∃ θ₁, θ₁ < α + π / 2 ∧ F.IsQArc (E - e (α + π / 2)) θ₁ (α + π / 2)) ∧
      (∃ θ₂, α + π / 2 < θ₂ ∧ F.IsQArc (E - e (α + π / 2)) (α + π / 2) θ₂) := by
  sorry

/-! ## NB3-END item 2: two sectors of the upper flank at `S′` (FS131-I5i, E5 § 3.4 over SEP) -/

/-- **Two sectors of one chart tangent along one direction are ordered by curvature** (E5 § 3.4, F6): if sector `j` is a horn along
`e β` (`nextβ j = β j`) and sector `i ≠ j` starts at a germ of the same direction and turns a half-turn, then `j`'s upper germ curves no
more than `i`'s first one — else the two sectors meet at small radius. -/
theorem nextκ_le_of_disjoint {P : ℂ} {n : ℕ} {G : BranchGerms n} {r₀ : ℝ} (hC : F.IsSectorChart G P r₀) {i j : Fin n}
    (hij : i ≠ j) (hj : G.nextβ j = G.β j) (hji : e (G.β j) = e (G.β i)) (hi : G.nextβ i = G.β i + π) :
    G.nextκ j ≤ G.κ i := by
  sorry

/-- **A point of the lower half-disc sector on the `−a` side lies below its first germ** (sign care: a germ of direction `α + π` and
curvature `κ` is the arc of upward curvature `−κ` in the frame at `α`). -/
theorem tanBelow_of_mem_sector {P : ℂ} {α : ℝ} {n : ℕ} {G : BranchGerms n} {r₀ : ℝ} (hC : F.IsSectorChart G P r₀)
    {i : Fin n} {m : ℤ} (hβ : G.β i = α + π + 2 * π * m) (hnb : G.nextβ i = G.β i + π) {r : ℝ} (hr : r ∈ Ioc 0 r₀)
    {y : ℂ} (hy : y ∈ G.sector P r i) (hx : frameX P α y < 0) : TanBelow P α (-G.κ i) y := by
  sorry

/-- **A horn sector along `−a` reaches the point above every arc of upward curvature `−κ` with `κ` at least its upper germ's
curvature** (on the `−a` side, arbitrarily near the point). -/
theorem exists_tanAbove_of_sector {P : ℂ} {α κ : ℝ} {n : ℕ} {G : BranchGerms n} {r₀ : ℝ}
    (hC : F.IsSectorChart G P r₀) {j : Fin n} {m : ℤ} (hβ : G.β j = α + π + 2 * π * m) (hnb : G.nextβ j = G.β j)
    (hκ : G.nextκ j ≤ κ) {r : ℝ} (hr : r ∈ Ioc 0 r₀) :
    ∀ ρ > 0, ∃ y ∈ G.sector P r j, dist y P < ρ ∧ frameX P α y < 0 ∧ TanAbove P α (-κ) y := by
  sorry

/-- **The opposite horn** (N4-STUCK (i) read at a given horn's axis): at a stuck vertex where `c` has two sectors, a `c`-horn along `e α`
has a partner `c`-horn along `e (α + π)`, with bounds in `[−1, 1]`. -/
theorem exists_horn_add_pi_of_stuck (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) (hst : F.IsStuck v) {c : Fin k}
    (hc2 : F.HasSectors v c 2) {α κ₁ κ₂ : ℝ} (hH : F.IsHorn v α κ₁ κ₂ c) :
    ∃ κ₃ κ₄, F.IsHorn v (α + π) κ₃ κ₄ c ∧ -1 ≤ κ₃ ∧ κ₄ ≤ 1 := by
  have hvd : v ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  obtain ⟨hM, hR, hSh, -⟩ := hst
  have hcv : c ∈ F.coloursAt v := mem_closure_of_mem_coneAt hH.mem_coneAt_region
  have hD : interior (F.allowedCone v c) = ∅ := by
    by_contra hne
    exact hM ⟨c, 2, le_rfl, hc2, nonempty_iff_ne_empty.mpr hne⟩
  obtain ⟨α', -, -, hev⟩ := woodallCone_isHorn_ua hF hv hcv hD
  obtain ⟨r, ⟨⟨hrH, hr2⟩, hrh⟩, hr0⟩ := (((hev.and hc2).and hH.2).and self_mem_nhdsWithin).exists
  have hr0' : (0 : ℝ) < r := hr0
  obtain ⟨β, hβ, κ, κ', -, -, -, hSeq⟩ := hrH _ ⟨hrh.1, hrh.2⟩
  have heq : e α = e β := by
    have := mem_coneAt_hornSet v α hH.1 hr0'
    rw [hSeq] at this
    exact e_eq_of_mem_coneAt_hornSet this
  have h1 : 1 < (F.sectorsOf v r c).encard := by rw [hr2]; norm_num
  obtain ⟨x, y, hx, hy, hxy⟩ := one_lt_encard_iff.mp h1
  obtain ⟨βx, hβx, a₁, a₂, ha₁, ha₂, Hx, hxe⟩ := hrH x hx
  obtain ⟨βy, hβy, b₁, b₂, hb₁, hb₂, Hy, hye⟩ := hrH y hy
  have hβne : βx ≠ βy := by
    intro he
    rw [he] at Hx hxe
    obtain ⟨e1, e2⟩ := horn_unique_of_stuck hF hvd hR hSh Hx Hy
    exact hxy (by rw [hxe, hye, e1, e2])
  have hαπ : e (α + π) = e (β + π) := by rw [e_add_pi, e_add_pi, heq]
  -- the direction opposite `β` among `{α', α' + π}`
  obtain ⟨γ, hγ, hγe⟩ : ∃ γ, (γ = βx ∨ γ = βy) ∧ e γ = e (β + π) := by
    simp only [mem_insert_iff, mem_singleton_iff] at hβ hβx hβy
    have h2π : e (α' + π + π) = e α' := by rw [show α' + π + π = α' + 2 * π by ring, e_add_two_pi]
    rcases hβ with rfl | rfl <;> rcases hβx with rfl | rfl <;> rcases hβy with rfl | rfl <;>
      first
      | exact absurd rfl hβne
      | exact ⟨_, Or.inl rfl, rfl⟩
      | exact ⟨_, Or.inr rfl, rfl⟩
      | exact ⟨_, Or.inl rfl, h2π.symm⟩
      | exact ⟨_, Or.inr rfl, h2π.symm⟩
  rcases hγ with rfl | rfl
  · exact ⟨a₁, a₂, Hx.congr (hγe.trans hαπ.symm), ha₁, ha₂⟩
  · exact ⟨b₁, b₂, Hy.congr (hγe.trans hαπ.symm), hb₁, hb₂⟩

/-- **NB3-END item 2, derived (E5 § 3.4)**: in `n3_end_of_not_inType`'s setting the upper flank colour `g` has at least two sectors at
`S′ = v − n` for every small radius. -/
theorem flank_two_sectors_at_S (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {α κ₂ : ℝ} {c : Fin k}
    (hst : F.IsStuck v) (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) κ₂ c)
    (hno : ∀ g, F.IsFlankAbove v α κ₂ g → ¬ (F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2)))) :
    ∃ g, F.IsFlankAbove v α κ₂ g ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf (v - e (α + π / 2)) r g).encard := by
  have hπ := Real.pi_pos
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  have hv := hvC v
  set S := v - e (α + π / 2) with hSdef
  set N := v + e (α + π / 2) with hNdef
  obtain ⟨κ₃, κ₄, Hd, h3', h4⟩ := exists_horn_add_pi_of_stuck hF hv hst hc2 hH
  obtain ⟨-, h2⟩ := horn_bounds_of_noMerge hF hv hst.1 le_rfl hc2 hH
  obtain ⟨hcN, hcS⟩ := horn_poles_contact hF hv hst.1 le_rfl hc2 hH
  obtain ⟨g, h, -, -, -, hgc, -, hgu, hhu, hhd, hgd, -⟩ :=
    stuck_flanks_ua hF hv hst h3.le hH Hd le_rfl h2 h3' h4 hc2 hcN hcS
  refine ⟨g, hgu, ?_⟩
  have hgv : g ∈ F.coloursAt v := mem_closure_of_mem_coneAt hgu.mem_coneAt
  have hNv : dist N v = 1 := by rw [hNdef, dist_eq_norm, add_sub_cancel_left, norm_e]
  -- `N` is not in `g`'s closure when a bound reaches `ω(N)` from the `g` side
  have hNg : κ₂ = 1 ∨ κ₃ = -1 → N ∉ closure (F.region g) := by
    intro hκ hNcl
    have hcont : F.IsContact v g N := ⟨hgv, hNv, hNcl⟩
    rcases (contact_inType_or_outType hF hv hcont).1 with hin | hout
    · exact hno g hgu ⟨hcont, hin⟩
    · rcases hκ with hκ | hκ
      · subst hκ; exact not_outType_N_of_flankAbove_one hF hv hgu hNcl hout
      · subst hκ
        have := not_outType_S_of_flankBelow_neg_one hF hv hgd (by rw [sub_e_add_pi_add]; exact hNcl)
        rw [sub_e_add_pi_add] at this
        exact this hout
  -- the `g`-shadow on both horns (no SHAVE), localized at `S′`
  obtain ⟨shH, -⟩ := shadow_of_not_shave hst.2.2.1 hH hgu hhu
  obtain ⟨-, shHd⟩ := shadow_of_not_shave hst.2.2.1 Hd hhd hgd
  have L1 := fun δ (hδ : 0 < δ) => witness_near_S_upper hF hv h2 hgu (fun h => hNg (Or.inl h)) hδ
  have L2 := fun δ (hδ : 0 < δ) => witness_near_S_lower hF hv h3' h4 hgd (fun h => hNg (Or.inr h)) hδ
  -- `g` is out-type at `S′`
  have hgS : F.IsContact v g S ∧ F.OutType v g S := by
    rcases srcG_of_shadow hF hv le_rfl hH.1 h2 hgu shH with hin | hout
    · exact absurd hin (hno g hgu)
    · exact hout
  -- the sector chart at `S′`
  obtain ⟨r₀, n, G, hC⟩ := localSectors F (hvC S (mem_closedBall_self zero_le_one))
  have hcSc : c ∈ F.coloursAt S := hcS.1.2.2
  have hgSc : g ∈ F.coloursAt S := hgS.1.2.2
  have hn : 0 < n := by
    rw [← hC.mem_Γ]
    by_contra hΓ
    have hSi : S ∈ F.interiorPts := ⟨hvC S (mem_closedBall_self zero_le_one), fun hS => hΓ ⟨hvC S
      (mem_closedBall_self zero_le_one), hS⟩⟩
    have h1 := coloursAt_eq_of_mem_interiorPts hSi
    rw [h1] at hcSc hgSc
    exact hgc (hgSc.trans hcSc.symm)
  have hfar := far_of_outType_chart hgS.2 hC hn
  have hfar' : ∃ r > 0, ∀ y ∈ F.region g, dist y S < r → 1 < dist y v := ⟨r₀, hC.pos, hfar⟩
  -- the witnesses, with their directions
  have W1 := exists_witness_dir (v := v) (α := α) (Or.inl rfl) (H := fun ρ => hornSet v α (-1) κ₂ ρ)
    (W := F.region g) (fun ρ z hz => ⟨hz.1, by rw [one_mul]; exact hz.2.1, abs_frameY_le_of_mem_hornSet le_rfl h2 hz,
      (tanAbove_neg_one_iff v α z).mp hz.2.2.1⟩)
    (fun ρ ρ' h => hornSet_mono_radius h) shH L1 hfar'
  have W2 := exists_witness_dir (v := v) (α := α) (Or.inr rfl) (H := fun ρ => hornSet v (α + π) κ₃ κ₄ ρ)
    (W := F.region g) (fun ρ z hz => ⟨hz.1, by have := hz.2.1; rw [frameX_add_pi] at this; linarith,
      by have := abs_frameY_le_of_mem_hornSet h3' h4 hz; rwa [frameY_add_pi, abs_neg] at this,
      by have := (tanBelow_one_iff v (α + π) z).mp (hz.2.2.2.mono h4); rwa [add_e_add_pi_add] at this⟩)
    (fun ρ ρ' h => hornSet_mono_radius h) shHd L2 hfar'
  have hαg : α ∈ coneAt (F.region g) S := by
    intro ε hε
    obtain ⟨y, hy, -, -, -, hyS, hyε, -, hdir⟩ := W1 ε hε 1 one_pos
    refine ⟨y, hy, hyS, hyε, ?_⟩
    simpa using hdir
  have hαπg : α + π ∈ coneAt (F.region g) S := by
    intro ε hε
    obtain ⟨y, hy, -, -, -, hyS, hyε, -, hdir⟩ := W2 ε hε 1 one_pos
    refine ⟨y, hy, hyS, hyε, ?_⟩
    rw [e_add_pi]
    simpa using hdir
  -- suppose `g` had at most one sector at some small radius
  by_contra hcon
  obtain ⟨r, hrlt, hr⟩ := ((not_eventually.mp hcon).and_eventually (Ioc_mem_nhdsGT hC.pos)).exists
  push Not at hrlt
  -- the indices of `g`'s sectors
  set gI : Set (Fin n) := {i | ∀ r' ∈ Ioc 0 r₀, G.sector S r' i ⊆ F.region g} with hgI
  have hgIu : ∀ i ∈ gI, ∀ i' ∈ gI, i = i' := by
    intro i hi i' hi'
    by_contra hne
    have hmem : ∀ j ∈ gI, G.sector S r j ∈ F.sectorsOf S r g := fun j hj =>
      ⟨(hC.isSector_iff hn hr).mpr ⟨j, rfl⟩, fun z hz => (hj r hr hz).2⟩
    have hne' : G.sector S r i ≠ G.sector S r i' := by
      intro heq
      obtain ⟨z, hz⟩ := hC.sector_nonempty hr i
      exact Set.disjoint_left.mp (hC.disjoint r hr i i' hne) hz (heq ▸ hz)
    have : 2 ≤ (F.sectorsOf S r g).encard := by
      rw [show (2 : ℕ∞) = ({G.sector S r i, G.sector S r i'} : Set (Set ℂ)).encard by
        rw [encard_pair hne']]
      exact encard_le_encard (by
        intro T hT; rcases hT with rfl | rfl
        · exact hmem i hi
        · exact hmem i' hi')
    exact absurd this (not_le.mpr hrlt)
  have hcolI : ∀ y ∈ F.region g, dist y S < r → ∃ i ∈ gI, y ∈ G.sector S r i := by
    intro y hy hyr
    have hyc : y ∈ ball S r ∩ F.interiorPts := ⟨hyr, hy.1⟩
    rw [hC.cover r hr hn] at hyc
    obtain ⟨i, hi⟩ := mem_iUnion.mp hyc
    obtain ⟨g', hg'⟩ := hC.exists_col i
    have hgg : g' = g := ((hg' r hr hi).2).symm.trans hy.2
    exact ⟨i, fun r' hr' => hgg ▸ hg' r' hr', hi⟩
  have hconeI : ∀ β ∈ coneAt (F.region g) S, ∃ i ∈ gI, β ∈ angleIcc (G.β i) (G.nextβ i) := by
    intro β hβ
    have h1 := coneAt_inter_ball hr.1 hβ
    have h2 : F.region g ∩ ball S r ⊆ ⋃ i ∈ gI, G.sector S r i := by
      intro y ⟨hy, hyr⟩
      obtain ⟨i, hi, hyi⟩ := hcolI y hy hyr
      exact mem_iUnion₂.mpr ⟨i, hi, hyi⟩
    obtain ⟨i, hi, hβi⟩ := coneAt_biUnion_finite (Set.toFinite gI) _ (coneAt_mono h2 S h1)
    exact ⟨i, hi, by rwa [hC.cone r hr i] at hβi⟩
  obtain ⟨i₀, hi₀, hαi⟩ := hconeI α hαg
  obtain ⟨i₁, hi₁, hαπi⟩ := hconeI (α + π) hαπg
  obtain rfl := hgIu i₀ hi₀ i₁ hi₁
  have hM := hC.sorted.mono
  -- `g`'s sector is the lower half-disc: its cone is `[α + π, α + 2π]`
  have hcone0 : angleIcc (G.β i₀) (G.nextβ i₀) ⊆ angleIcc (α + π) (α + 2 * π) := by
    rw [← hC.cone r hr i₀]
    exact coneAt_subset_of_far ⟨r, hr.1, fun y hy hyr => (hfar y (hi₀ r hr hy) (lt_of_lt_of_le hyr hr.2)).le⟩
  obtain ⟨m, hβ0, hnβ0⟩ := angleIcc_eq_lower_half (hM i₀) hcone0 hαi hαπi
  -- a sector of `c` at `S′`
  obtain ⟨y₁, hy₁, hy₁S⟩ := Metric.mem_closure_iff.mp hcSc r hr.1
  obtain ⟨j, hj⟩ : ∃ j, y₁ ∈ G.sector S r j := by
    have hyc : y₁ ∈ ball S r ∩ F.interiorPts := ⟨by rw [mem_ball, dist_comm]; exact hy₁S, hy₁.1⟩
    rw [hC.cover r hr hn] at hyc
    exact mem_iUnion.mp hyc
  obtain ⟨c', hc'⟩ := hC.exists_col j
  have hcc : c' = c := ((hc' r hr hj).2).symm.trans hy₁.2
  subst hcc
  have hji : i₀ ≠ j := by
    rintro rfl
    exact hgc (((hi₀ r hr hj).2).symm.trans hy₁.2)
  have hconej : angleIcc (G.β j) (G.nextβ j) ⊆ coneAt (F.region c') S := by
    rw [← hC.cone r hr j]; exact coneAt_mono (hc' r hr) S
  obtain ⟨φ, hφ, hφπ, hU1⟩ := coneAt_S_subset_of_horn hF hH h2
  have hdisj := hM.disjoint hji
  rw [hβ0, hnβ0] at hdisj
  obtain ⟨hjj, m', hβj⟩ := angle_pinch hφ hφπ (hM j) (hconej.trans hU1) hdisj
  have hβjmem : G.β j ∈ angleIcc (G.β j) (G.nextβ j) := Icc_subset_angleIcc _ _ ⟨le_rfl, hM j⟩
  rcases lt_or_eq_of_le h4 with h4' | h4'
  · -- `κ₄ < 1`: SEP at `S′` with the `−a` horn
    have hκ := nextκ_le_of_disjoint hC hji hjj (by rw [hβj, hβ0, e_add_int_mul, e_add_int_mul])
      (by rw [hnβ0, hβ0]; ring)
    obtain ⟨r', hr'c, hr'0⟩ := ((Hd.eventually_subset_region.and (Ioc_mem_nhdsGT (by norm_num : (0 : ℝ) < 1 / 2))).and
      self_mem_nhdsWithin).exists
    obtain ⟨y₀, hy₀g, z₀, hz₀, hz₀y₀, -, hy₀S, hy₀X, -⟩ := W2 r hr.1 r' hr'0
    obtain ⟨i', hi', hy₀i⟩ := hcolI y₀ hy₀g hy₀S
    obtain rfl := hgIu i' hi' i₀ hi₀
    have hy₀X' : frameX S α y₀ < 0 := by rw [frameX_base_S]; linarith
    have hy₀T := tanBelow_of_mem_sector hC hβ0 (by rw [hnβ0, hβ0]; ring) hr hy₀i hy₀X'
    have hK := exists_tanAbove_of_sector (α := α) hC hβj hjj hκ hr
    obtain ⟨y, hyK, z, hz, hyz⟩ := sep_add_pi_S h3' Hd.1 h4' hr'0 hr'c.2.2 ⟨z₀, hz₀, by rw [dist_comm]; exact hz₀y₀⟩
      hy₀T (K := G.sector S r j) (fun ρ hρ => by
        obtain ⟨y, hy, hyρ, hyX, hyT⟩ := hK ρ hρ
        exact ⟨y, hy, hyρ, by rw [← frameX_base_S]; exact hyX, hyT⟩)
    have hyc := hc' r hr hyK
    have hzc := hr'c.1 hz
    exact hF y hyc.1 z hzc.1 hyz (hyc.2.trans hzc.2.symm)
  · -- `κ₄ = 1`: U1 on the `−a` horn's arc of `ω(S′)` removes `α + π` from `c`'s cone
    subst h4'
    obtain ⟨φ', hφ', hφ'π, hU1'⟩ := coneAt_N_subset_of_horn hF Hd h3'
    rw [add_e_add_pi_add] at hU1'
    have := hU1' (hconej hβjmem)
    rw [show α + π + π = α + 2 * π by ring] at this
    exact angle_pinch_false hφ' hφ'π ⟨m', hβj⟩ this

/-- **NB3-END items 3–4** (`plans/FS112-NB3-verification.md` l. 238–241; NB3's, one mind, not re-derived by E5): in `n3_end_of_not_inType`'s
setting `S′ = v − n` carries at least four colours — `S′` terminal makes `g`'s two sectors horns along `±a` (item 3), and the colours `y`
below and `z` above `g`'s `+a` horn differ (SHAVE otherwise), so `P_cl(S′) ⊇ {c, g, y, z}`. The open part of `n3_end_of_not_inType` after
`flank_two_sectors_at_S`. A step inside a refutation-shaped row: no model expected. -/
theorem n3_end_four_colours (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {v : ℂ} {α κ₂ : ℝ} {c : Fin k}
    (hst : F.IsStuck v) (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) κ₂ c)
    (hno : ∀ g, F.IsFlankAbove v α κ₂ g → ¬ (F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2)))) :
    4 ≤ (F.coloursAt (v - e (α + π / 2))).ncard := by
  sorry

/-- **NB3-END item 5** (`plans/FS112-NB3-verification.md` l. 242–243; NB3's, one mind): in `n3_end_of_not_inType`'s setting `v − 2n` centres
a both-kind unit arc — the `y`-shadow on `g`'s `+a` horn at `S′` comes from an in-type `y`-tile at `v − 2n` Siamese to the lower flank, along
an arc of `ω(v − 2n)` with `s_in = y`, `s_out = g`, both carried at `v − 2n`. A step inside a refutation-shaped row: no model expected. -/
theorem n3_end_bothKind (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {v : ℂ} {α κ₂ : ℝ} {c : Fin k}
    (hst : F.IsStuck v) (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) κ₂ c)
    (hno : ∀ g, F.IsFlankAbove v α κ₂ g → ¬ (F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2)))) :
    ∃ θ₁ θ₂, F.BothKind (v - 2 * e (α + π / 2)) θ₁ θ₂ := by
  sorry

/-- **FS112-N3-END, its first case** (a child of `n3_end`, FS131-I5d): with no in-type upper-flank tile at `N`, the first disjunct — four colours and
a repeated colour at `S′ = v − n`, a both-kind unit arc centred at `v − 2n`. NB3-END items 2–5 (`plans/FS112-NB3-verification.md` l. 232–243) with
item 2's premise read as "no in-type `g`-tile at `N`" (FS131-I4m's reading, inventory items 288–289: NB3 leaves the case `κ₂ = 1`, `g ∉ P_cl(N)` to its
item 1, whose conclusion is not this statement): the `g`-shadow on both horns then comes from out-type `g`-tiles at `S′` tangent to `±a` (`srcG_of_shadow`
gives "in-type at `N` or out-type at `S′`"), two sectors of `g` at `S′`; `S′` terminal makes them horns; the colours `y ≠ z` beside the `+a` horn
(SHAVE otherwise); an in-type `y`-tile at `v − 2n` Siamese to the lower flank. The open part of `n3_end`. A step inside a refutation-shaped row: no
model expected. -/
theorem n3_end_of_not_inType (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {v : ℂ} {α κ₂ : ℝ} {c : Fin k}
    (hst : F.IsStuck v) (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) κ₂ c)
    (hno : ∀ g, F.IsFlankAbove v α κ₂ g → ¬ (F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2)))) :
    4 ≤ (F.coloursAt (v - e (α + π / 2))).ncard ∧ F.HasRepeatedColour (v - e (α + π / 2)) ∧
      ∃ θ₁ θ₂, F.BothKind (v - 2 * e (α + π / 2)) θ₁ θ₂ := by
  obtain ⟨g, -, hg2⟩ := flank_two_sectors_at_S hF hP hst h3 hc2 hH hno
  exact ⟨n3_end_four_colours hF hP hT hst h3 hc2 hH hno, ⟨g, hg2⟩, n3_end_bothKind hF hP hT hst h3 hc2 hH hno⟩

/-- **FS112-N3-END** (NB3's corrected form): in a terminal valid map of the plane, let `v` be stuck with exactly three colours, its
two-sector colour `c` having a horn along `e α` whose lower arc has curvature `−1` (an arc of `ω(v − n)`). Then either `v − n` carries
at least four colours and a repeated colour and `v − 2n` is the centre of a both-kind unit arc, or the upper flank colour `g` is
in-type at `v + n` and both horns' upper arcs lie on `ω(v + n)` (`κ₂ = 1`; for the horn along `−a` its lower arc in its own frame).
The row's "and the chain is the single vertex" needs wave 5's stuck-chain vocabulary and is not stated here (§ 8 of the plan). -/
theorem n3_end (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {v : ℂ} {α κ₂ : ℝ} {c : Fin k} (hst : F.IsStuck v)
    (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) κ₂ c) :
    (4 ≤ (F.coloursAt (v - e (α + π / 2))).ncard ∧ F.HasRepeatedColour (v - e (α + π / 2)) ∧
        ∃ θ₁ θ₂, F.BothKind (v - 2 * e (α + π / 2)) θ₁ θ₂) ∨
      ∃ g, F.IsFlankAbove v α κ₂ g ∧ F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2)) ∧ κ₂ = 1 ∧
        ∀ κ₃ κ₄, F.IsHorn v (α + π) κ₃ κ₄ c → κ₃ = -1 := by
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  by_cases hin : ∃ g, F.IsFlankAbove v α κ₂ g ∧ F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2))
  · -- an in-type upper flank at `N`: the flank lies in `B(N, 1)`, so `κ₂ = 1`, and the `−e α` horn's `+n` flank (the same colour) too
    right
    obtain ⟨g, hg, hgc, hgi⟩ := hin
    obtain ⟨-, hκ2⟩ := horn_bounds_of_noMerge hF (hvC v) hst.1 le_rfl hc2 hH
    have hk2 : κ₂ = 1 := by
      by_contra hne
      exact (contact_inType_or_outType hF (hvC v) hgc).2
        ⟨hgi, outType_N_of_flankAbove hF (hvC v) (lt_of_le_of_ne hκ2 hne) hg hgc.2.2⟩
    refine ⟨g, hg, hgc, hgi, hk2, fun κ₃ κ₄ Hd => ?_⟩
    obtain ⟨hκ3, hκ4⟩ := horn_bounds_of_noMerge hF (hvC v) hst.1 le_rfl hc2 Hd
    obtain ⟨hN, hS⟩ := horn_poles_contact hF (hvC v) hst.1 le_rfl hc2 hH
    obtain ⟨g₁, -, -, -, -, -, -, hg₁, -, -, hg₁d, -⟩ :=
      stuck_flanks_ua hF (hvC v) hst h3.le hH Hd le_rfl hκ2 hκ3 hκ4 hc2 hN hS
    have hg₁g : g₁ = g := hg₁.unique hg
    subst hg₁g
    by_contra hne
    have hout := outType_S_of_flankBelow hF (hvC v) (lt_of_le_of_ne hκ3 (Ne.symm hne)) hg₁d
      (by rw [sub_e_add_pi_add]; exact hgc.2.2)
    rw [sub_e_add_pi_add] at hout
    exact (contact_inType_or_outType hF (hvC v) hgc).2 ⟨hgi, hout⟩
  · left
    exact n3_end_of_not_inType hF hP hT hst h3 hc2 hH fun g hg hgi => hin ⟨g, hg, hgi⟩

/-- **FS112-N3-END's chain clause** ("and the chain is the single vertex", inventory item 74; wave 4's `n3_end` states the rest): in
n3_end's setting (a terminal valid plane map, `v` stuck with three colours, `c`'s horn along `e α` with lower bound `−1`), in its second
disjunct — the upper flank `g` in-type at `N` and `κ₂ = 1` — the stuck run through `v` is `{0}`: neither neighbour is a chain vertex.
Model of the local hypotheses: `bowtie` at `0` (`bowtie_isStuck`: `E` stuck, `±i` not). -/
theorem n3_end_chain (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {v : ℂ} {α : ℝ} {c g : Fin k}
    (hst : F.IsStuck v) (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) 1 c)
    (hg : F.IsFlankAbove v α 1 g) (hgN : F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2))) :
    F.stuckRun v α = {0} := by
  -- the run's chain clause reads only the two unit bounds of `c`'s horn (not `hT`, the flank, nor the in-type contact)
  have _ := hT
  have _ := hg
  have _ := hgN
  have hvC : ∀ x, F.Covers x 1 := fun x z _ => by rw [hP]; exact mem_univ z
  obtain ⟨⟨hcN, -⟩, ⟨hcS, -⟩⟩ := horn_poles_contact hF (hvC v) hst.1 le_rfl hc2 hH
  have hNo : ¬ F.IsChainVertex (v + e (α + π / 2)) := fun ⟨hstN, h3N⟩ => by
    obtain ⟨β, hβ⟩ := chainVertex_antipodal hF (hvC _) hstN h3N
    obtain ⟨h1, h2⟩ := hβ c hcN.2.2
    exact not_antipodal_coneAt_N_of_horn hF hH le_rfl h1 h2
  have hSo : ¬ F.IsChainVertex (v - e (α + π / 2)) := fun ⟨hstS, h3S⟩ => by
    obtain ⟨β, hβ⟩ := chainVertex_antipodal hF (hvC _) hstS h3S
    obtain ⟨h1, h2⟩ := hβ c hcS.2.2
    exact not_antipodal_coneAt_S_of_horn hF hH le_rfl h1 h2
  ext j
  simp only [stuckRun, mem_setOf_eq, mem_singleton_iff]
  constructor
  · intro hj
    by_contra hj0
    rcases lt_or_gt_of_ne hj0 with hlt | hgt
    · have := hj (-1) (by omega) (by omega)
      rw [show v + ((-1 : ℤ) : ℂ) * e (α + π / 2) = v - e (α + π / 2) by push_cast; ring] at this
      exact hSo this
    · have := hj 1 (by omega) (by omega)
      rw [show v + ((1 : ℤ) : ℂ) * e (α + π / 2) = v + e (α + π / 2) by push_cast; ring] at this
      exact hNo this
  · rintro rfl i hi1 hi2
    have hi : i = 0 := by omega
    subst hi
    rw [show v + ((0 : ℤ) : ℂ) * e (α + π / 2) = v by push_cast; ring]
    exact ⟨hst, h3.le⟩

end ArcMap

/-! ## The inhabitant of `IsTerminalMap` -/

/-- **The inhabitant of `IsTerminalMap`** (every clause at once, at seven colours, where no theorem of this module refutes it):
the seven-brick map is valid, of the plane, has no horn and no point of a repeated colour (so no move is available anywhere: `Terminal`),
and no arc of `Γ` on any unit circle (so `QROnly` holds vacuously in its arcs' sense — every constant-sided unit arc, of which there are
none, is (Q) or (R2)). -/
theorem sevenBrickMap_isTerminalMap : sevenBrickMap.IsTerminalMap :=
  ⟨sevenBrickMap_valid, sevenBrickMap_isPlaneMap,
    fun v _ => ⟨sevenBrick_not_mergeAvailable v, fun ⟨_, _, _, _, _, _, _, H, _⟩ => sevenBrick_not_isHorn H,
      fun ⟨_, _, _, _, _, _, _, H, _⟩ => sevenBrick_not_isHorn H⟩,
    fun _ _ _ _ _ h => absurd h sevenBrick_not_isRingArc⟩

end HadwigerNelson.Plane
