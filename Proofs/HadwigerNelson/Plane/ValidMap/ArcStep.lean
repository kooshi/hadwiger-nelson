import Proofs.HadwigerNelson.Plane.ValidMap.BendStep

/-!
# The arc step from the clauses a bend exports (FS131-IA2)

`exists_arcStep` (`Plane/ValidMap/Procedure`) bends one maximal bad unit arc `α = r([θ₁, θ₂])` of `ω(P)` off its circle: toward `P` when
the outer colour is not carried at `P` (the collar bend, `CollarFit`), away from `P` when the inner colour is not (`bend_away_part`).
This module proves the step's clauses **once, over the clauses a bend exports** (`ArcBend`), upstream of `Procedure`
(`plans/FS131-arcstep-implementation.md`, FS131-IA2's stages):

* **The interface** `ArcBend F M h K P θ₁ θ₂ c c' g ε`: the bent map `M`, the homeomorphism `h`, the collar `K`, the gaining colour `g`
  — the weakest clauses the step reads. The toward collar bend supplies it with `g = c'` (`CollarFit.arcBend`), the away bend's
  conclusion with `g = c` (`ArcBend.of_away`).
* **The step's clauses from the interface** (`ArcBend.arcStep`): the bent map is valid and clean, a local step on the closed
  `ε`-neighbourhood of the arc, a modification, creates no site, raises no degree at a point off the collar or on the closed arc and no
  horn count anywhere, and adds no colour at such a point.
* **The two count clauses at the ring-arc level** (`ArcBend.maxBad`, `maxBad_centre`, `maxBad_other`): a maximal bad unit arc of the bent
  map is one of `F`, with its open arc off `α°`. `IsMaxRingArc` and `badCount` are `Procedure`'s, downstream: the maximality is read
  here in its unfolded form, and what `Procedure` adds is the point-set form of `α`'s maximality (a ring arc about `P` meeting `α°` has
  `α`'s sides and lies in `α`) and the `encard` step.
* **Owed lemmas of FS131-IA1's work list**: the colours, degree and repeated colour at a point of an open ring arc
  (`IsRingArc.coloursAt_openArc`, `IsRingArc.degree_openArc`); a unit arc about another centre misses the open arc
  (`IsRingArc.disjoint_openArc_of_ne`, W4); a horn at a point iff its horn count is at least `1` (`exists_hasHornCount_isHorn_iff`, W6);
  the step's radius (`exists_arcStep_radius`); the local step of a cut (`LocalStep.of_cutArcs`, W1 and W2 as one statement, FS131-KA1's
  text).

**Models.** `ArcBend`: the collar bend of `l60Frag` at `collarModel` (the spec example at the end), which rests on the open child
`CollarFit.map_hornCount_le` (`BendStep`). No Lean model is named for a clean map carrying a ring arc (the hypothesis `hc` with `ring`),
as in `BendStep`'s header: an open gate item, owed with the arc step's model (inventory ruling 427 (d)).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## The interface: what the arc step reads from a bend -/

/-- **The clauses the arc step reads from a bend** of the unit arc `α = r([θ₁, θ₂])` of `ω(P)`, sides `c` (inner) and `c'` (outer): a
bent map `M`, a homeomorphism `h` of the plane and a collar `K` within `ε` of the arc and inside the domain, meeting `Γ` only on the
arc, with `g`, one of the two side colours, the colour that gains. `M` is valid and a local step on `K`; `h` is the identity off `K`,
fixes `Γ` off the open arc, carries interior points to interior points, the colours at each point, degrees forward and repeated
colours back; no horn count rises; no unit arc is created (`ringArcsWithin`), the constant-sided unit arcs of `M` are `F`'s (`R1`) and
`F`'s whose open arc misses `α°` survive (`R2`); each interior point of `α` is fixed or becomes an interior point of colour `g`
(`gain`); and an interior point of `α` still on a unit arc of `M` about `P` has the (R2) kind — outer colour at `P`, inner colour not,
and its radius-2 point in the closure of the inner colour's class (`left`).

Neither the collar's compactness nor `h K ⊆ K` is read by the step. Inhabitants: `CollarFit.arcBend` (the toward collar bend, `g = c'`,
where `left` is vacuous) and `ArcBend.of_away` (the away bend's conclusion, `g = c`). -/
structure ArcBend (F M : ArcMap k) (h : ℂ ≃ₜ ℂ) (K : Set ℂ) (P : ℂ) (θ₁ θ₂ : ℝ) (c c' g : Fin k) (ε : ℝ) : Prop where
  /-- The arc is a constant-sided unit arc of `F`. -/
  ring : F.IsRingArc P θ₁ θ₂ c c'
  /-- The gaining colour is a side colour. -/
  side : g = c ∨ g = c'
  /-- The bent map is valid. -/
  valid : M.Valid
  /-- The collar lies within `ε` of the arc. -/
  sub_thick : K ⊆ thickening ε (ringArc P θ₁ θ₂)
  /-- The collar lies in the domain. -/
  sub_dom : K ⊆ F.dom
  /-- The collar meets `Γ` only on the arc. -/
  free : F.Γ ∩ K ⊆ ringArc P θ₁ θ₂
  /-- The bend is a local step on the collar. -/
  step : LocalStep F M K
  /-- The homeomorphism is the identity off the collar. -/
  fix_off : ∀ z ∉ K, h z = z
  /-- It fixes `Γ` off the open arc. -/
  fix_Γ : ∀ z ∈ F.Γ, z ∉ ringPt P '' Ioo θ₁ θ₂ → h z = z
  /-- It carries interior points to interior points. -/
  interior : ∀ z ∈ F.interiorPts, h z ∈ M.interiorPts
  /-- It carries the colours at each point. -/
  coloursAt : ∀ z, M.coloursAt (h z) = F.coloursAt z
  /-- It carries degrees. -/
  degree : ∀ z n, F.HasDegree z n → M.HasDegree (h z) n
  /-- A repeated colour of the bent map comes from one of `F`. -/
  repeated : ∀ z, M.HasRepeatedColour (h z) → F.HasRepeatedColour z
  /-- No horn count rises. -/
  horn : ∀ x j, F.HasHornCount x j → ∃ j' ≤ j, M.HasHornCount x j'
  /-- No unit arc is created. -/
  ringArcsWithin : M.RingArcsWithin F
  /-- R1: a constant-sided unit arc of the bent map is one of `F`, with the same sides. -/
  R1 : ∀ Q a b d d', M.IsRingArc Q a b d d' → F.IsRingArc Q a b d d'
  /-- R2: a constant-sided unit arc of `F` whose open arc misses `α°` survives. -/
  R2 : ∀ Q a b d d', F.IsRingArc Q a b d d' → Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) → M.IsRingArc Q a b d d'
  /-- An interior point of the arc is fixed, or becomes an interior point of the gaining colour. -/
  gain : ∀ θ ∈ Ioo θ₁ θ₂, h (ringPt P θ) = ringPt P θ ∨ ringPt P θ ∈ M.region g
  /-- What is left of `α°` on a unit arc of the bent map about `P` has the (R2) kind. -/
  left : ∀ θ ∈ Ioo θ₁ θ₂, M.OnRingArc P (ringPt P θ) →
    c' ∈ F.coloursAt P ∧ c ∉ F.coloursAt P ∧ P + 2 * e θ ∈ closure (F.region c)

/-! ## A constant-sided unit arc at its interior points -/

section RingArc

variable {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}

/-- **The colours at an interior point of a constant-sided unit arc are its two sides**: near the point `ω(P)` lies in `Γ`, so a class
reaches the point from inside `ω(P)` or from outside. -/
theorem IsRingArc.coloursAt_openArc (hA : F.IsRingArc P θ₁ θ₂ c c') {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) :
    F.coloursAt (ringPt P θ) = {c, c'} := by
  sorry

/-- **In a clean map the two sides of a unit arc differ** (an interior point of the arc carries at least two colours). -/
theorem IsRingArc.sides_ne_of_isClean (hc : F.IsClean) (hA : F.IsRingArc P θ₁ θ₂ c c') : c ≠ c' := by
  sorry

/-- **`F` at an interior point of a constant-sided unit arc near which `Γ` is `ω(P)`**: degree `2`, and a repeated colour exactly when
the two sides agree (`degree_of_circle`; `CollarFit.degree_openArc` is this at a collar's arc). -/
theorem IsRingArc.degree_openArc (hA : F.IsRingArc P θ₁ θ₂ c c') {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂)
    (hfree : ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1) :
    (∀ n, F.HasDegree (ringPt P θ) n ↔ n = 2) ∧ (F.HasRepeatedColour (ringPt P θ) ↔ c = c') := by
  sorry

/-- **A unit arc about another centre misses the open arc** (FS131-IA1's W4): near an interior point of `α` with `Γ` free there, `Γ`
lies on `ω(P)`, which a unit circle about `Q ≠ P` meets in finitely many points. -/
theorem IsRingArc.disjoint_openArc_of_ne (hF : F.Valid) {Q : ℂ} {a b : ℝ} {d d' : Fin k} (hQP : Q ≠ P)
    (hD : F.IsRingArc Q a b d d') (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1) :
    Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) := by
  sorry

end RingArc

/-! ## Horns and the horn count (W6) -/

/-- **A horn at a point iff its horn count is at least `1`** (FS131-IA1's W6), with the count's existence: at a point of the domain the
horn count exists, and it is at least `1` exactly when some horn has its tip there (at a chart, `Near.hasHornCount_chart`: the count is
the number of consecutive germs sharing a direction, and such a pair bounds a horn). -/
theorem exists_hasHornCount_isHorn_iff {v : ℂ} (hv : v ∈ F.dom) :
    ∃ j, F.HasHornCount v j ∧ ((∃ α κ₁ κ₂ c, F.IsHorn v α κ₁ κ₂ c) ↔ 1 ≤ j) := by
  sorry

/-! ## The step's radius -/

/-- **The arc step's radius**: for a locally finite set `T` and a bound `δ`, a radius `ε < δ`, `ε < 1`, with every point of `T` in the
closed `ε`-neighbourhood of the arc on the arc. -/
theorem exists_arcStep_radius {T : Set ℂ} (hT : ∀ K, IsCompact K → (K ∩ T).Finite) (P : ℂ) (θ₁ θ₂ : ℝ) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ε, 0 < ε ∧ ε < δ ∧ ε < 1 ∧ cthickening ε (ringArc P θ₁ θ₂) ∩ T ⊆ ringArc P θ₁ θ₂ := by
  sorry

/-! ## The step's clauses from the interface -/

namespace ArcBend

variable {M : ArcMap k} {h : ℂ ≃ₜ ℂ} {K : Set ℂ} {P : ℂ} {θ₁ θ₂ : ℝ} {c c' g : Fin k} {ε : ℝ}

/-- The bent map has `F`'s domain. -/
theorem dom_eq (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) : M.dom = F.dom := hB.step.agreesOff.1.symm

/-- A point of the collar is at distance between `1 − ε` and `1 + ε` from `P`. -/
theorem dist_of_mem (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) {z : ℂ} (hz : z ∈ K) : 1 - ε < dist z P ∧ dist z P < 1 + ε := by
  sorry

/-- **The place of a preimage**: a point is fixed, or its preimage is an interior point of `F` in the collar or an interior point of
the arc. -/
theorem symm_cases (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (x : ℂ) :
    h.symm x = x ∨ h.symm x ∈ F.interiorPts ∨ ∃ θ ∈ Ioo θ₁ θ₂, h.symm x = ringPt P θ := by
  sorry

/-- The colours at a point off the collar are kept. -/
theorem coloursAt_of_notMem (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) {x : ℂ} (hx : x ∉ K) : M.coloursAt x = F.coloursAt x := by
  sorry

/-- **The colours at the centre are kept** (`ε ≤ 1`: the centre is off the collar). -/
theorem coloursAt_centre (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hε : ε ≤ 1) : M.coloursAt P = F.coloursAt P := by
  sorry

/-- **The bent map of a clean map is clean**: a point of its `Γ` is the image of a point of `F`'s, with the same colours. -/
theorem isClean (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hc : F.IsClean) : M.IsClean := by
  sorry

/-- **The bend is a local step on the closed `ε`-neighbourhood of the arc.** -/
theorem localStep (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) : LocalStep F M (cthickening ε (ringArc P θ₁ θ₂)) :=
  hB.step.mono (hB.sub_thick.trans (thickening_subset_cthickening _ _))

/-- **The bent map is a modification of `F`**: a point of at least four colours in it is fixed (a moved point's preimage is interior,
one colour, or on the open arc, two). -/
theorem isModification (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) : F.IsModification M := by
  sorry

/-- **No colour is added at a point off the collar or on the closed arc**: such a point is fixed, or an interior point of the arc
turned to the gaining colour, a side colour of the arc there. -/
theorem coloursAt_subset (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) {x : ℂ} (hx : x ∉ K ∨ x ∈ ringArc P θ₁ θ₂) :
    M.coloursAt x ⊆ F.coloursAt x := by
  sorry

/-- **No degree rises at a point off the collar or on the closed arc** (the repaired degree clause of `exists_arcStep`, where it is
read): a fixed point keeps its degree; an interior point of the arc turned to the gaining colour falls to degree `1`. -/
theorem degree_le (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hc : F.IsClean) {x : ℂ} (hx : x ∉ K ∨ x ∈ ringArc P θ₁ θ₂) {m : ℕ}
    (hm : F.HasDegree x m) : ∃ m' ≤ m, M.HasDegree x m' := by
  sorry

/-- **No site is created**: a repeated colour of the bent map sits at a fixed point (a moved point's preimage is interior, or on the
open arc, whose two sides differ in a clean map); a horn of the bent map gives horn count at least `1` there, so in `F` too (`horn`),
so a horn of `F` (`exists_hasHornCount_isHorn_iff`). -/
theorem isSite (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hc : F.IsClean) {x : ℂ} (hx : M.IsSite x) : F.IsSite x := by
  sorry

/-- **(Q) is kept** at a centre whose colours are kept, for an arc whose open arc misses `α°`. -/
theorem isQArc_of (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) {Q : ℂ} {a b : ℝ} (hQ : F.IsQArc Q a b)
    (hd : Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂)) (hcol : M.coloursAt Q = F.coloursAt Q) : M.IsQArc Q a b := by
  sorry

/-- **(R2) is kept** at a centre whose colours are kept, for an arc whose open arc misses `α°` (question (5), `isR2Arc_of_fixed`). -/
theorem isR2Arc_of (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hF : F.Valid) (hc : F.IsClean) {Q : ℂ} {a b : ℝ} (hR : F.IsR2Arc Q a b)
    (hd : Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂)) (hcol : M.coloursAt Q = F.coloursAt Q) : M.IsR2Arc Q a b := by
  sorry

/-- **What is left of the arc is (R2)** (FS131-IA1's W7): a unit arc of the bent map about `P` with `α`'s sides whose open arc lies in
`α°` is an (R2) arc of the bent map (`left` at each interior angle; the ends by closedness; the radius-2 points are off the collar). -/
theorem isR2Arc_left (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hε : ε ≤ 1) {a b : ℝ} (hM : M.IsRingArc P a b c c')
    (hsub : ringPt P '' Ioo a b ⊆ ringPt P '' Ioo θ₁ θ₂) : M.IsR2Arc P a b := by
  sorry

/-- **A maximal bad unit arc of the bent map is one of `F`, off `α°`** — the two count clauses of `exists_arcStep` at the ring-arc
level. `Q` is a centre whose colours are kept; `hmeet` says that a unit arc of `F` about `Q` whose open arc meets `α°` is centred at
`P`, has `α`'s sides and lies in `α` (for `Q ≠ P` no such arc exists, `IsRingArc.disjoint_openArc_of_ne`; for `Q = P` it is `α`'s
maximality, read on point sets — `Procedure`'s `IsMaxRingArc` with `IsRingArc.union`). An arc of the bent map about `Q`, maximal among
its unit arcs with the same sides (`IsMaxRingArc`'s last clause, unfolded) and neither (Q) nor (R2), has its open arc off `α°`, and is
such an arc of `F`. -/
theorem maxBad (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hF : F.Valid) (hc : F.IsClean) (hε : ε ≤ 1) {Q : ℂ}
    (hcol : M.coloursAt Q = F.coloursAt Q)
    (hmeet : ∀ a b d d', F.IsRingArc Q a b d d' → ¬ Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) →
      Q = P ∧ (d = c ∧ d' = c') ∧ ringPt Q '' Ioo a b ⊆ ringPt P '' Ioo θ₁ θ₂)
    {a b : ℝ} {d d' : Fin k} (hM : M.IsRingArc Q a b d d')
    (hmax : ∀ a' b', a' ≤ a → b ≤ b' → M.IsRingArc Q a' b' d d' → a' = a ∧ b' = b)
    (hQ : ¬ M.IsQArc Q a b) (hR : ¬ M.IsR2Arc Q a b) :
    Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) ∧ F.IsRingArc Q a b d d' ∧
      (∀ a' b', a' ≤ a → b ≤ b' → F.IsRingArc Q a' b' d d' → a' = a ∧ b' = b) ∧ ¬ F.IsQArc Q a b ∧ ¬ F.IsR2Arc Q a b := by
  sorry

/-- **The count clause at the centre**, at the ring-arc level: given `α`'s maximality on point sets (`hmeet`), a maximal bad unit arc of
the bent map about `P` is a maximal bad unit arc of `F` about `P` whose open arc misses `α°` — so it is not `α`. -/
theorem maxBad_centre (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hF : F.Valid) (hc : F.IsClean) (hε : ε ≤ 1)
    (hmeet : ∀ a b d d', F.IsRingArc P a b d d' → ¬ Disjoint (ringPt P '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) →
      (d = c ∧ d' = c') ∧ ringPt P '' Ioo a b ⊆ ringPt P '' Ioo θ₁ θ₂)
    {a b : ℝ} {d d' : Fin k} (hM : M.IsRingArc P a b d d')
    (hmax : ∀ a' b', a' ≤ a → b ≤ b' → M.IsRingArc P a' b' d d' → a' = a ∧ b' = b)
    (hQ : ¬ M.IsQArc P a b) (hR : ¬ M.IsR2Arc P a b) :
    Disjoint (ringPt P '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) ∧ F.IsRingArc P a b d d' ∧
      (∀ a' b', a' ≤ a → b ≤ b' → F.IsRingArc P a' b' d d' → a' = a ∧ b' = b) ∧ ¬ F.IsQArc P a b ∧ ¬ F.IsR2Arc P a b :=
  hB.maxBad hF hc hε (hB.coloursAt_centre hε) (fun a b d d' hD hnd => ⟨rfl, hmeet a b d d' hD hnd⟩) hM hmax hQ hR

/-- **The count clause at another centre**, at the ring-arc level: at `Q ≠ P` whose colours are kept, a maximal bad unit arc of the bent
map about `Q` is a maximal bad unit arc of `F` about `Q`. -/
theorem maxBad_other (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hF : F.Valid) (hc : F.IsClean) (hε : ε ≤ 1) {Q : ℂ} (hQP : Q ≠ P)
    (hcol : M.coloursAt Q = F.coloursAt Q) {a b : ℝ} {d d' : Fin k} (hM : M.IsRingArc Q a b d d')
    (hmax : ∀ a' b', a' ≤ a → b ≤ b' → M.IsRingArc Q a' b' d d' → a' = a ∧ b' = b)
    (hQ : ¬ M.IsQArc Q a b) (hR : ¬ M.IsR2Arc Q a b) :
    F.IsRingArc Q a b d d' ∧ (∀ a' b', a' ≤ a → b ≤ b' → F.IsRingArc Q a' b' d d' → a' = a ∧ b' = b) ∧
      ¬ F.IsQArc Q a b ∧ ¬ F.IsR2Arc Q a b :=
  (hB.maxBad hF hc hε hcol (fun _ _ _ _ hD hnd =>
    absurd (hD.disjoint_openArc_of_ne hF hQP (hB.ring.free_of_isClean hc)) hnd) hM hmax hQ hR).2

/-- **The arc step's clauses from a bend**, but for the two counts (`maxBad_centre`, `maxBad_other`): for a clean valid map, a bend
within `ε < 1` of the arc and a set `T` whose points in the closed `ε`-neighbourhood of the arc lie on the arc, the bent map is valid
and clean, a local step on that neighbourhood, a modification of `F`; it creates no site, raises no degree at a point of `T` and no horn
count anywhere, adds no colour at a point of `T`, and keeps the colours at the centre. -/
theorem arcStep (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hc : F.IsClean) (hε : ε ≤ 1) {T : Set ℂ}
    (hT : cthickening ε (ringArc P θ₁ θ₂) ∩ T ⊆ ringArc P θ₁ θ₂) :
    M.Valid ∧ M.IsClean ∧ LocalStep F M (cthickening ε (ringArc P θ₁ θ₂)) ∧ F.IsModification M ∧
      (∀ x, M.IsSite x → F.IsSite x) ∧ (∀ x ∈ T, ∀ m, F.HasDegree x m → ∃ m' ≤ m, M.HasDegree x m') ∧
      (∀ x j, F.HasHornCount x j → ∃ j' ≤ j, M.HasHornCount x j') ∧ (∀ Q ∈ T, M.coloursAt Q ⊆ F.coloursAt Q) ∧
      M.coloursAt P = F.coloursAt P := by
  sorry

end ArcBend

/-! ## The local step of a cut (W1 and W2; FS131-KA1's statement) -/

/-- **A map whose arcs are `F`'s cut at the open arc, with new arcs inside `K`, is a local step on `K`** (FS131-KA1's
`LocalStep.of_cutArcs`, stated here with its signature — at the merge the two are one statement, in `BendAway`; FS131-IA1's W1 and W2):
an arc of `F` missing `K` misses the closed arc, so it is in the cut whole; a piece of the cut that is no arc of `F` lies in an arc of
`F` through an end of the arc, a point of `K`. -/
theorem LocalStep.of_cutArcs {M : ArcMap k} {K : Set ℂ} {S : Set Arc} {P : ℂ} {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂)
    (hag : M.AgreesOff F K) (harcs : M.arcs = F.cutArcs P θ₁ θ₂ ∪ S) (hS : ∀ a ∈ S, a.carrier ⊆ K)
    (hK : ringArc P θ₁ θ₂ ⊆ K) : LocalStep F M K := by
  sorry

/-! ## The toward collar bend supplies the interface -/

section Collar

variable {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} {ε R' R R'' : ℝ}

/-- The closed arc lies in the collar. -/
theorem CollarFit.ringArc_subset_collarK (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    ringArc P θ₁ θ₂ ⊆ collarK P θ₁ θ₂ R' R'' := by
  sorry

/-- The lens lies in the collar (FS131-IA1's W3). -/
theorem CollarFit.lensSet_subset_collarK (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    lensSet P θ₁ θ₂ R ⊆ collarK P θ₁ θ₂ R' R'' := by
  sorry

/-- **The collar bend is a local step on the collar** (`LocalStep.of_cutArcs`: its arcs are the cut's and the lens boundary's two). -/
theorem CollarFit.map_localStep (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    LocalStep F hfit.map (collarK P θ₁ θ₂ R' R'') := by
  sorry

/-- **The toward collar bend supplies the interface**, the outer colour gaining: `left` is vacuous (R3, `CollarFit.map_R3`). It rests
on the open child `CollarFit.map_hornCount_le` (`BendStep`) for `horn`. -/
theorem CollarFit.arcBend (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    ArcBend F hfit.map hfit.homeo (collarK P θ₁ θ₂ R' R'') P θ₁ θ₂ c c' c' ε := by
  sorry

/-- **The toward bend, in the arc step's form**: a constant-sided unit arc of a valid map whose outer colour is not carried at its
centre, with `Γ` free near its interior points, has for every `ε > 0` a bend within `ε` satisfying the interface, the outer colour
gaining (`exists_collarFit`, `CollarFit.arcBend`). -/
theorem exists_arcBend_toward (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c') (hout : c' ∉ F.coloursAt P)
    (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1) (hε : 0 < ε) :
    ∃ (M : ArcMap k) (h : ℂ ≃ₜ ℂ) (K : Set ℂ), ArcBend F M h K P θ₁ θ₂ c c' c' ε := by
  obtain ⟨R', R, R'', hfit⟩ := exists_collarFit hF hA hout hfree hε
  exact ⟨hfit.map, hfit.homeo, collarK P θ₁ θ₂ R' R'', hfit.arcBend hF⟩

end Collar

/-! ## The away bend's conclusion supplies the interface -/

/-- **The away bend's conclusion supplies the interface**, the inner colour gaining: the clauses of `bend_away_part`'s conclusion
(`BendStep`; its horn clause in the arc step's form, inventory ruling 438 (b)) for a map `M`, a homeomorphism `h` and a collar `K`,
at an arc of a plane map whose outer colour is carried at the centre and whose inner colour is not. `left` is the last clause read at
the angle itself (FS131-IA1's W7 starts here). -/
theorem ArcBend.of_away {M : ArcMap k} {h : ℂ ≃ₜ ℂ} {K : Set ℂ} {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} {ε : ℝ}
    (hP : F.IsPlaneMap) (hA : F.IsRingArc P θ₁ θ₂ c c') (hin : c ∉ F.coloursAt P) (hout : c' ∈ F.coloursAt P)
    (hM : M.Valid ∧ IsCompact K ∧ K ⊆ thickening ε (ringArc P θ₁ θ₂) ∧
      F.Γ ∩ K ⊆ ringArc P θ₁ θ₂ ∧ LocalStep F M K ∧
      (∀ z ∉ K, h z = z) ∧ (∀ z ∈ K, h z ∈ K) ∧
      (∀ z ∈ F.Γ, z ∉ ringPt P '' Ioo θ₁ θ₂ → h z = z) ∧
      (∀ z, (h z ∈ M.interiorPts ↔ z ∈ F.interiorPts) ∧ (z ∈ F.interiorPts → M.col (h z) = F.col z)) ∧
      (∀ z, M.coloursAt (h z) = F.coloursAt z) ∧
      (∀ z n, M.HasDegree (h z) n ↔ F.HasDegree z n) ∧
      (∀ z, M.HasRepeatedColour (h z) ↔ F.HasRepeatedColour z) ∧
      (∀ x j, F.HasHornCount x j → ∃ j' ≤ j, M.HasHornCount x j') ∧
      M.RingArcsWithin F ∧
      (∀ Q a b d d', M.IsRingArc Q a b d d' → F.IsRingArc Q a b d d') ∧
      (∀ Q a b d d', F.IsRingArc Q a b d d' → Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) →
        M.IsRingArc Q a b d d') ∧
      (∀ θ ∈ Ioo θ₁ θ₂, h (ringPt P θ) = ringPt P θ ∨ ringPt P θ ∈ M.region c) ∧
      (∀ θ ∈ Ioo θ₁ θ₂, M.OnRingArc P (ringPt P θ) →
        ∃ a b, a < b ∧ θ ∈ Icc a b ∧ Icc a b ⊆ F.r2Contacts P θ₁ θ₂ c)) :
    ArcBend F M h K P θ₁ θ₂ c c' c ε := by
  sorry

/-! ## Spec examples -/

/-- The interface at a model: the collar bend of `l60Frag` (`collarModel`: the arc `r([π/8, 5π/24])` of `ω(0)`, sides `0` and `1`)
satisfies it for every `ε`, the outer colour `1` gaining. (It rests on `CollarFit.map_hornCount_le`, open.) -/
example {ε : ℝ} (hε : 0 < ε) :
    ∃ (R' R'' : ℝ) (M : ArcMap 4) (h : ℂ ≃ₜ ℂ), ArcBend l60Frag M h (collarK 0 (π / 8) (5 * π / 24) R' R'') 0 (π / 8) (5 * π / 24) 0 1 1 ε := by
  obtain ⟨R', R, R'', hfit⟩ := collarModel hε
  exact ⟨R', R'', hfit.map, hfit.homeo, hfit.arcBend l60Frag_valid⟩

end ArcMap

end HadwigerNelson.Plane
