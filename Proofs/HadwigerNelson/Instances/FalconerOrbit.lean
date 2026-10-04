import Proofs.HadwigerNelson.Instances.FanGap11
import Proofs.HadwigerNelson.Instances.FanGap19
import Proofs.HadwigerNelson.Instances.PlaneFreedom
import Proofs.HadwigerNelson.PlaneRotation

/-!
# Where a fan's tip can land in the planes at `7`, `11` and `19` (FS-131 wave 2, FALC-RES)

The finite facts behind **FS129-SA1-FALC-RES** (`Arith/FalconerField`), all read off colourings already in the kernel, with
no new table and no search (`plans/FS131-w2-kernel-plan.md` § 15):

* **At `7`, four colours**: the periodic colouring `circ7Table ∘ projAlong (1, 2)` (`Instances/PlaneFreedom`) has colour `3`
  absent from `N[(0, 2)]` (the class `y − 2x = 2` sees `{0, 1, 2}`), so `UD(𝔽₇, 2)` is slack at four colours.
* **The orbit facts at `11` and `19`, five colours**: rotating about the gapped vertex of the colouring already held
  (`finitePlane11_fanGap` at `(2, 4)`, gap `2`; `finitePlane19_fanGap` at `(0, 4)`, gap `1`) moves every nonzero `w` to a point
  coloured neither the vertex's colour nor the gap colour. With the gap transported to `0` (`tipFree_of_orbit`), every
  `w ≠ 0` has a colouring with a gap `γ` at `0` and `C w ∉ {C 0, γ}` — so by FALC-FAN (A) a fan's tip and apex have one image.

Each orbit fact is one `decide +kernel` over `120 × 12` (resp. `360 × 20`) lookups, 2–4 s; `tools/fs131_k2d_orbit.py`
re-checks them in Python with planted faults.
-/

set_option maxRecDepth 100000

namespace HadwigerNelson

open SimpleGraph

/-! ### The plane at `7`: slack at four colours -/

/-- The periodic 4-colouring of `UD(𝔽₇, 2)`: `circ7Table` along the projection `(x, y) ↦ y − 2x`. -/
def finitePlane7QuotColouring (v : ZMod 7 × ZMod 7) : Fin 4 :=
  circ7Table (projAlong (1, 2) v)

/-- Proper: an edge's difference projects into `circ7D`, along which `circ7Table` never repeats. -/
theorem finitePlane7QuotColouring_proper :
    ∀ {u v : ZMod 7 × ZMod 7}, (finitePlane 7).Adj u v →
      finitePlane7QuotColouring u ≠ finitePlane7QuotColouring v := by
  intro u v h
  rw [unitQuadrance_adj] at h
  obtain ⟨-, hq⟩ := h
  have hmem : u - v ∈ unitCircle (ZMod 7) := by
    show (u - v).1 ^ 2 + (u - v).2 ^ 2 = 1
    simpa only [Prod.fst_sub, Prod.snd_sub] using hq
  have hD : projAlong ((1 : ZMod 7), (2 : ZMod 7)) (u - v) ∈ circ7D := circ7_image _ hmem
  have hkey := circ7_proper _ hD (projAlong ((1 : ZMod 7), (2 : ZMod 7)) v)
  have he : projAlong ((1 : ZMod 7), (2 : ZMod 7)) v + projAlong ((1 : ZMod 7), (2 : ZMod 7)) (u - v)
      = projAlong ((1 : ZMod 7), (2 : ZMod 7)) u := by
    rw [map_sub]; abel
  rw [he] at hkey
  exact hkey

/-- The periodic colouring, bundled. -/
def finitePlane7QuotColoring : (finitePlane 7).Coloring (Fin 4) :=
  Coloring.mk finitePlane7QuotColouring finitePlane7QuotColouring_proper

/-- **The gap at `7`**: colour `3` is absent from `N[(0, 2)]`. -/
theorem finitePlane7_fanGap : FanGap finitePlane7QuotColoring (0, 2) 3 := by
  decide +kernel

/-- Red: a present colour is refused as a gap (`0` is on `N(0, 2)`). -/
theorem finitePlane7_not_fanGap_zero : ¬ FanGap finitePlane7QuotColoring (0, 2) 0 := by
  decide +kernel

/-- **`UD(𝔽₇, 2)` is slack at four colours.** -/
theorem finitePlane7_slack : Slack (finitePlane 7) 4 :=
  slack_addCayley_of_fanGap finitePlane7_fanGap

/-! ### The orbit facts at `11` and `19` -/

/-- **The orbit fact at `11`**: rotating about the gapped vertex `(2, 4)` of the certified table carries every `w ≠ 0` to a
point coloured neither `1` (the vertex's colour) nor `2` (the gap). -/
theorem gamma11_orbit : ∀ w : ZMod 11 × ZMod 11, w ≠ 0 → ∃ a b : ZMod 11, a ^ 2 + b ^ 2 = 1 ∧
    finitePlane11Colouring ((2, 4) + rotMap a b w) ≠ finitePlane11Colouring (2, 4) ∧
    finitePlane11Colouring ((2, 4) + rotMap a b w) ≠ 2 := by
  decide +kernel

/-- **The orbit fact at `19`**, about the gapped vertex `(0, 4)` of the periodic colouring (gap `1`). -/
theorem gamma19_orbit : ∀ w : ZMod 19 × ZMod 19, w ≠ 0 → ∃ a b : ZMod 19, a ^ 2 + b ^ 2 = 1 ∧
    finitePlane19QuotColouring ((0, 4) + rotMap a b w) ≠ finitePlane19QuotColouring (0, 4) ∧
    finitePlane19QuotColouring ((0, 4) + rotMap a b w) ≠ 1 := by
  decide +kernel

/-- **A gap moves to `0` along a rotation about it**: from a gap `γ` at `g`, the colouring `x ↦ C (g + R x)` (`R` the rotation
by a circle point) has the gap `γ` at `0` and the value `C (g + R w)` at `w`. -/
theorem tipFree_of_orbit {R : Type*} [CommRing R] {k : ℕ} {C : (unitQuadrance R).Coloring (Fin k)} {g : R × R}
    {γ : Fin k} (hgap : FanGap C g γ) {a b : R} (hab : a ^ 2 + b ^ 2 = 1) :
    ∃ C' : (unitQuadrance R).Coloring (Fin k), FanGap C' 0 γ ∧ ∀ w, C' w = C (g + rotMap a b w) := by
  refine ⟨C.comap ((addCayleyTranslate _ g).comp (rotHom hab)), ⟨?_, fun x hx => ?_⟩, fun w => rfl⟩
  · show γ ≠ C (g + rotMap a b 0)
    rw [map_zero, add_zero]; exact hgap.1
  · show C (g + rotMap a b x) ≠ γ
    refine hgap.2 _ ?_
    have h0 : (unitQuadrance R).Adj (rotHom hab 0) (rotHom hab x) := (rotHom hab).map_adj hx
    have h1 : (unitQuadrance R).Adj (g + rotMap a b 0) (g + rotMap a b x) :=
      (addCayleyTranslate {v : R × R | v.1 ^ 2 + v.2 ^ 2 = 1} g).map_adj h0
    rw [map_zero, add_zero] at h1
    exact h1

/-- **The tip is free at `11`**: every `w ≠ 0` has a 5-colouring with a gap `γ` at `0` and `C w ∉ {C 0, γ}`. -/
theorem finitePlane11_tipFree (w : ZMod 11 × ZMod 11) (hw : w ≠ 0) :
    ∃ (C : (finitePlane 11).Coloring (Fin 5)) (γ : Fin 5), FanGap C 0 γ ∧ C w ≠ C 0 ∧ C w ≠ γ := by
  obtain ⟨a, b, hab, h1, h2⟩ := gamma11_orbit w hw
  obtain ⟨C', hC', hw'⟩ := tipFree_of_orbit finitePlane11_fanGap hab
  refine ⟨C', 2, hC', ?_, ?_⟩
  · rw [hw', hw' 0, map_zero, add_zero]; exact h1
  · rw [hw']; exact h2

/-- **The tip is free at `19`.** -/
theorem finitePlane19_tipFree (w : ZMod 19 × ZMod 19) (hw : w ≠ 0) :
    ∃ (C : (finitePlane 19).Coloring (Fin 5)) (γ : Fin 5), FanGap C 0 γ ∧ C w ≠ C 0 ∧ C w ≠ γ := by
  obtain ⟨a, b, hab, h1, h2⟩ := gamma19_orbit w hw
  obtain ⟨C', hC', hw'⟩ := tipFree_of_orbit finitePlane19_fanGap hab
  refine ⟨C', 1, hC', ?_, ?_⟩
  · rw [hw', hw' 0, map_zero, add_zero]; exact h1
  · rw [hw']; exact h2

end HadwigerNelson
