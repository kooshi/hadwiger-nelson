import Proofs.HadwigerNelson.Plane.Woodall.Collar

/-!
# Maps need six, almost everywhere: Woodall's Theorem 6 as repaired (FS106-AE-MAP6, FS106-WO)

FS131-W's skeleton (`plans/FS131-W-kernel-plan.md` § 3), over arc maps (inventory item 88: the general Jordan form owed). A five-coloured arc
map of the plane, **valid** (D-AEMAP: no two interior points of one colour at distance exactly `1`; boundaries carry no colour), does not exist.

The chain is `[Woodall1973]`'s steps, region-only, on the picture at a point (`ArcMap.SectorsAt`):
* `exists_sectorsAt`: every point of a map of the plane has a picture (Woodall's steps 1–2 are free for arcs);
* **step 3** (`exists_woodallMerged`): a valid map can be recoloured, near its vertices, into one whose repeated colours sit on zero-angle sectors
  only (a modification; it keeps validity, the plane, and Condition 5);
* **step 5** (`step5_lt`; `step5_eq`, **open** — FS131-E1's Q1; `step5_eq_of_condition5`): no sector of angle `≤ π/3` between two neighbours of
  distinct colours, so a merged map is in normal form (inside `aeMap6_merged`, `aeMap6_merged_of_condition5`);
* **step 6** (`step6`, by Townsend's `π/3` lemma `townsend_lemma`): no point of three sectors in normal form;
* **step 7** (`step7`, **open** — FS131-E1's Q2) and **step 8** (`step8`): no point of four or five sectors in normal form, by a point of the
  unit circle about it carrying three colours and so falling under step 6;
* a point of at least three sectors exists (`exists_three_le_sectors`, from FS106-TS-T, `ArcMap.ts_t`).

**The rows.** FS106-AE-MAP6 is `ArcMap.aeMap6` (open leaves: `step5_eq`, `step7`), with `ArcMap.aeMap6_of_condition5` under Condition 5 (open
leaf: `step7`); FS106-WO's Theorem 6 is `woodall_thm6` (everywhere-proper sets divisible into regions, a corollary), its step-4 lemma
`woodall_step4` (`Plane/Woodall/Collar`); FS106-TW is `townsend_lemma` (`Plane/Woodall/Collar`), whose Theorem 4 Corollary is `step6`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## The picture at a point -/

/-- **Every point of a map of the plane has a picture**: finitely many arcs pass near `v`, each leaves `v` in a direction (segments and circular
arcs have tangents); the sectors between consecutive directions (two tangent arcs bounding a horn), with adjacent sectors of one colour
merged, are the picture. -/
theorem exists_sectorsAt (hP : F.IsPlaneMap) (v : ℂ) : ∃ n d c, F.SectorsAt v n d c := by
  sorry

/-- The colours at a point are the colours of its picture's sectors. -/
theorem SectorsAt.coloursAt_eq {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k} (h : F.SectorsAt v n d c) :
    F.coloursAt v = range c := by
  sorry

/-! ## Woodall's step 3: merging repeated colours at a vertex (a modification) -/

/-- **Woodall's step 3** (`[Woodall1973]` p. 197): a valid map of the plane can be recoloured near its vertices — two sectors of one colour at
`P` are joined across a run of sectors of angle `< π` between them (every unit circle through a point of the run near `P`, except those through
`P`, passes through one of the two; the run is clear for their colour), and two horns in Woodall's cone fill it — into a valid map of the plane
whose repeated colours sit on zero-angle sectors only. The new boundary arcs are circles of small radius about the vertices, so Condition 5 is
kept. -/
theorem exists_woodallMerged (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.IsPlaneMap ∧ F'.WoodallMerged ∧ (F.Condition5 → F'.Condition5) := by
  sorry

/-! ## Woodall's step 5: every angle above `π/3` -/

/-- **Woodall's step 5, strict** (`[Woodall1973]` p. 198, repaired): in a valid map of the plane with at most five colours, no sector of angle
`< π/3` lies between two neighbours of distinct colours (at a point of at least three sectors) — the inner arc opposite it, of length
`> 2π/3`, is coloured by the two remaining colours, against `woodall_step4`. -/
theorem step5_lt (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ}
    {c : Fin n → Fin k} (h : F.SectorsAt v n d c) (hn : 3 ≤ n) (i : Fin n) (hang : d i.succ - d i.castSucc < π / 3)
    (hnb : c (finRotate n i) ≠ c ((finRotate n).symm i)) : False := by
  sorry

/-- **Woodall's step 5 at angle exactly `π/3`, under Condition 5**: the inner arc opposite the sector has length exactly `2π/3`, and at each end
the excluded set keeps a one-sided collar past the end (no edge is a unit arc), so a change point's landing falls in it, against lemma (L). -/
theorem step5_eq_of_condition5 (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) (h5 : F.Condition5) {v : ℂ} {n : ℕ}
    {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k} (h : F.SectorsAt v n d c) (hn : 3 ≤ n) (i : Fin n)
    (hang : d i.succ - d i.castSucc = π / 3) (hnb : c (finRotate n i) ≠ c ((finRotate n).symm i)) : False := by
  sorry

/-- **Woodall's step 5 at angle exactly `π/3`** — **open** (`plans/FS131-W-kernel-plan.md` § 1.6 Q1, FS131-E1): the case where both edges of
the sector are unit arcs centred at the two ends of the opposite arc is not excluded by any argument held. -/
theorem step5_eq (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ}
    {c : Fin n → Fin k} (h : F.SectorsAt v n d c) (hn : 3 ≤ n) (i : Fin n) (hang : d i.succ - d i.castSucc = π / 3)
    (hnb : c (finRotate n i) ≠ c ((finRotate n).symm i)) : False := by
  sorry

/-- **Steps 3 and 5 give the normal form, so a merged map does not exist**: in a valid map of the plane with at most five colours whose repeated
colours sit on horns only, every point of three or more sectors has distinct colours (a horn between two neighbours of distinct colours dies
by `step5_lt`; a horn between two of one colour has horns for neighbours, and the chain of horns ends at a sector of positive angle) and every
angle above `π/3` (`step5_lt`, `step5_eq`); `aeMap6_normal` finishes. Stated with conclusion `False`, not `WoodallNormal`: its domain is empty
(by this very chain), so the intermediate normal-form statement would be vacuous. -/
theorem aeMap6_merged (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) (hM : F.WoodallMerged) : False := by
  sorry

/-- The same under Condition 5, with `step5_eq_of_condition5` in place of `step5_eq`. -/
theorem aeMap6_merged_of_condition5 (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) (h5 : F.Condition5)
    (hM : F.WoodallMerged) : False := by
  sorry

/-! ## Woodall's steps 6, 7, 8 -/

/-- **Woodall's step 6, repaired by Townsend's `π/3` lemma** (`[Woodall1973]` p. 198; `[Townsend1979ms]` Thm 4's Corollary): in a valid map of
the plane with at most five colours, no point has a picture of three sectors of distinct colours, each of angle above `π/3`. The three
excluded sets of the sectors' colours leave two colours around `ω(v)`; collars exist about every angle except at most three cut angles (an edge
that is a unit arc centred on `ω(v)`) and the switching angles where a second-order collar survives; some one-sided arc exceeds `π/3`. -/
theorem step6 (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {d : Fin 4 → ℝ} {c : Fin 3 → Fin k}
    (h : F.SectorsAt v 3 d c) (hc : Function.Injective c) (hang : ∀ i : Fin 3, π / 3 < d i.succ - d i.castSucc) : False := by
  sorry

/-- **Woodall's step 7** — **open** (`plans/FS131-W-kernel-plan.md` § 1.6 Q2, FS131-E1): in a valid map of the plane with at most five colours in
normal form, no point has four sectors. Woodall's argument finds, on `ω(v)` in the window opposite the smallest sector, a point `Q` where the
two colours of the opposite inner arc meet, outside of which only the smallest sector's colour and the fifth can occur; the case where only the
fifth occurs outside (so `Q` carries two colours, a corner of the boundary) is not excluded by any argument held. -/
theorem step7 (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) (hN : F.WoodallNormal) {v : ℂ} {d : Fin 5 → ℝ}
    {c : Fin 4 → Fin k} (h : F.SectorsAt v 4 d c) : False := by
  sorry

/-- **Woodall's step 8** (`[Woodall1973]` p. 199): in a valid map of the plane with at most five colours in normal form, no point has five
sectors: the point `Q` of `ω(v)` where the two colours of the inner arc opposite the smallest sector meet has only that sector's colour outside,
so carries exactly three colours, and step 6 applies at `Q`. -/
theorem step8 (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) (hN : F.WoodallNormal) {v : ℂ} {d : Fin 6 → ℝ}
    {c : Fin 5 → Fin k} (h : F.SectorsAt v 5 d c) : False := by
  sorry

/-! ## A vertex exists -/

/-- **A point of at least three sectors** (FS106-TS-T, `ts_t`: a point carrying at least three colours; its picture's adjacent sectors differ,
so it has at least three). Woodall's "no vertices at all … is clearly impossible", in the form his map conditions do not give for arc maps. -/
theorem exists_three_le_sectors (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ v n d c, F.SectorsAt v n d c ∧ 3 ≤ n := by
  sorry

/-! ## The theorems -/

/-- **Maps in Woodall's normal form need six**: a valid map of the plane with at most five colours in normal form does not exist (a point of
`n ≥ 3` sectors has `n ≤ 5` distinct colours; steps 6, 7, 8). -/
theorem aeMap6_normal (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) (hN : F.WoodallNormal) : False := by
  sorry

/-- **FS106-AE-MAP6** (arc maps): no map of the plane bounded by a locally finite family of segments and circular arcs, coloured with at most
five colours, is almost-everywhere proper (no two interior points of one colour at distance exactly `1`; boundary points carry no colour).
"Boundaries of measure 0" is not used (the row's last clause). **Open leaves**: `step5_eq` and `step7` (FS131-E1). -/
theorem aeMap6 (F : ArcMap k) (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) : False := by
  sorry

/-- **FS106-AE-MAP6 under Condition 5** (no boundary meets a unit circle in infinitely many points): **open leaf** `step7` only. -/
theorem aeMap6_of_condition5 (F : ArcMap k) (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) (h5 : F.Condition5) : False := by
  sorry

end ArcMap

/-- **FS106-WO, Woodall's Theorem 6** ("R(b) ≥ 6", `[Woodall1973]` p. 195), for arc maps: the plane is not covered by five sets
simultaneously divisible into regions by one map of the plane (each region in one set, every point in exactly one set) with no set realizing
the distance `1` — a colouring `col` agreeing with the map's colour at its interior points and proper at every unit pair. A corollary of
`ArcMap.aeMap6`: properness at every pair gives validity. -/
theorem woodall_thm6 {k : ℕ} (hk : k ≤ 5) (F : ArcMap k) (hP : F.IsPlaneMap) (col : ℂ → Fin k)
    (hdiv : ∀ x ∈ F.interiorPts, col x = F.col x) (hproper : ∀ x y : ℂ, dist x y = 1 → col x ≠ col y) : False := by
  sorry

end HadwigerNelson.Plane
