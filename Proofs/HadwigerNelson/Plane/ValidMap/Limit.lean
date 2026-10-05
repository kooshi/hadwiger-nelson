import Proofs.HadwigerNelson.Plane.ValidMap.Chain

/-!
# The limit of a locally finite sequence of local steps (FS131-KL1)

Wave 5's limit infrastructure (`plans/FS131-limit-kernel-plan.md` § 2), for FS112-N2-RED and FS112-N2-TERM (`exists_red`,
`exists_terminal`): infinitely many local moves, each changing the map only on a compact set, the sets locally finite, have a
limit that agrees with every late enough stage near each compact part of the domain, so validity, the domain, "no unit arc created",
the colours at a point and every move's availability pass to it.

* **A local step** (`LocalStep F F' U`): `F'` agrees with `F` off `U` (`AgreesOff`), keeps every arc of `F` that misses `U` *as the
  same object*, and every new arc lies in `U` or inside an arc of `F` that meets `U`. Arcs are tracked because the limit's arcs are
  the arcs present from some stage on (`limitArcs`); a step that renamed far arcs (replaced an arc by a copy of it) would break that,
  and `keep` forbids it. The moves are surgeries (`trimArcs` plus new arcs in the disc), which have exactly this shape.
* **A locally finite sequence** (`LocalSeq`): steps `F n → F (n + 1)` on compact sets `U n` forming a locally finite family.
* **Its limit** (`LocalSeq.limit`): arcs eventually present, the colour at `z` read at the first stage after the last step whose set
  holds `z`. The pivot is `LocalSeq.frozen`: a compact part of the domain is met by finitely many supports, through every stage.
* **Locality** (`AgreesOff` on the complement of an open set `W`): two valid maps agreeing on `W` have the same colours, sectors,
  horns, contacts, cones, clearness, ring arcs and (Q)/(R2) arcs at the points whose closed ball of radius `3` lies in `W`
  (`coloursAt_eq_of_agreesOn`, `mergeAvailable_iff_of_agreesOn`, …). Validity enters through the tiles: in a valid map a tile of a
  colour carried at `v` never meets `ω(v)`, so in- and out-type are read near the contact.
* **Clean maps** (`IsClean`): every point of `Γ` carries two colours. A clean map's sites (`IsSite`: a repeated colour or a horn, the
  only points where a move can be available) are isolated; `exists_clean` removes the one-coloured parts of `Γ` from any valid map.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ}

/-! ## Local steps -/

/-- **A local step on `U`**: `F'` agrees with `F` off `U`, keeps every arc of `F` that misses `U` (as the same arc), and each of its
new arcs lies in `U` or inside an arc of `F` meeting `U` (a piece of an arc the step cut). -/
structure LocalStep (F F' : ArcMap k) (U : Set ℂ) : Prop where
  /-- The same domain; off `U`, the same interior points and colours. -/
  agreesOff : F'.AgreesOff F U
  /-- An arc missing `U` is kept. -/
  keep : ∀ a ∈ F.arcs, Disjoint a.carrier U → a ∈ F'.arcs
  /-- A new arc lies in `U`, or inside an arc of `F` that meets `U`. -/
  new : ∀ b ∈ F'.arcs, b ∉ F.arcs → b.carrier ⊆ U ∨ ∃ a ∈ F.arcs, (a.carrier ∩ U).Nonempty ∧ b.carrier ⊆ a.carrier

/-- The idle step (the procedure's step once nothing is left to do), on any set. -/
theorem LocalStep.refl (F : ArcMap k) (U : Set ℂ) : LocalStep F F U :=
  ⟨⟨rfl, fun _ _ => ⟨Iff.rfl, rfl⟩⟩, fun _ h _ => h, fun _ h h' => absurd h h'⟩

/-- A step on a smaller set is a step on a larger one. -/
theorem LocalStep.mono {F F' : ArcMap k} {U V : Set ℂ} (h : LocalStep F F' U) (hUV : U ⊆ V) : LocalStep F F' V := by
  sorry

/-- **A locally finite sequence of local steps**: the maps `F n`, the compact supports `U n` forming a locally finite family, and
each `F (n + 1)` a local step from `F n` on `U n`. -/
structure LocalSeq (k : ℕ) where
  /-- The stages. -/
  F : ℕ → ArcMap k
  /-- The support of the step after stage `n`. -/
  U : ℕ → Set ℂ
  /-- Each step is local on its support. -/
  step : ∀ n, LocalStep (F n) (F (n + 1)) (U n)
  /-- The supports are compact. -/
  isCompact : ∀ n, IsCompact (U n)
  /-- The supports form a locally finite family. -/
  locallyFinite : LocallyFinite U

namespace LocalSeq

variable (S : LocalSeq k)

/-- The constant sequence (every step idle, on the empty set): the inhabitant of `LocalSeq`, every clause exercised. -/
def const (F : ArcMap k) : LocalSeq k where
  F := fun _ => F
  U := fun _ => ∅
  step := fun _ => LocalStep.refl F ∅
  isCompact := fun _ => isCompact_empty
  locallyFinite := fun _ => ⟨univ, univ_mem, by simp⟩

/-- Every stage has the initial domain. -/
theorem dom_eq (n : ℕ) : (S.F n).dom = (S.F 0).dom := by
  induction n with
  | zero => rfl
  | succ n ih => exact (S.step n).agreesOff.1.symm.trans ih

/-- Each point lies in finitely many supports: from some stage on, in none. -/
theorem exists_stab (z : ℂ) : ∃ N, ∀ n ≥ N, z ∉ S.U n := by
  sorry

/-- The stage after which no support holds `z`. -/
noncomputable def stab (z : ℂ) : ℕ := Classical.choose (S.exists_stab z)

theorem not_mem_U_of_stab_le {z : ℂ} {n : ℕ} (hn : S.stab z ≤ n) : z ∉ S.U n :=
  Classical.choose_spec (S.exists_stab z) n hn

/-- **The pivot: a compact part of the domain freezes.** Every arc of a stage lies in an arc of `F 0` or in an earlier support, so
the arcs that ever meet `K` lie in a compact set, which finitely many supports meet; after them the arcs meeting `K`, and the
interior points and colours on `K`, are those of one stage. -/
theorem frozen {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ (S.F 0).dom) :
    ∃ N, ∀ n ≥ N, {a | a ∈ (S.F n).arcs ∧ (a.carrier ∩ K).Nonempty} = {a | a ∈ (S.F N).arcs ∧ (a.carrier ∩ K).Nonempty} ∧
      ∀ z ∈ K, (z ∈ (S.F n).interiorPts ↔ z ∈ (S.F N).interiorPts) ∧ (S.F n).col z = (S.F N).col z := by
  sorry

/-- The limit's arcs: those present at every late enough stage. -/
def limitArcs : Set Arc := {a | ∀ᶠ n in atTop, a ∈ (S.F n).arcs}

/-- The limit's colour: read at `z`'s stable stage. -/
noncomputable def limitCol (z : ℂ) : Fin k := (S.F (S.stab z)).col z

theorem limitArcs_nondegenerate : ∀ a ∈ S.limitArcs, a.Nondegenerate := by
  intro a ha
  obtain ⟨N, hN⟩ := eventually_atTop.mp ha
  exact (S.F N).nondegenerate a (hN N le_rfl)

/-- The limit's arcs are locally finite on the domain (`frozen` on a closed ball, and the frozen stage's local finiteness). -/
theorem limitArcs_locallyFinite :
    ∀ x ∈ (S.F 0).dom, ∃ t ∈ 𝓝 x, {a | a ∈ S.limitArcs ∧ (a.carrier ∩ t).Nonempty}.Finite := by
  sorry

/-- The limit's colour is locally constant off its arcs (near `x` it is the frozen stage's). -/
theorem limitCol_locallyConstant :
    ∀ x ∈ (S.F 0).dom, x ∉ ⋃ a ∈ S.limitArcs, a.carrier → ∀ᶠ y in 𝓝 x, S.limitCol y = S.limitCol x := by
  sorry

/-- **The limit map.** -/
noncomputable def limit : ArcMap k where
  dom := (S.F 0).dom
  isOpen_dom := (S.F 0).isOpen_dom
  arcs := S.limitArcs
  nondegenerate := S.limitArcs_nondegenerate
  locallyFinite := S.limitArcs_locallyFinite
  col := S.limitCol
  locallyConstant := S.limitCol_locallyConstant

@[simp] theorem limit_dom : S.limit.dom = (S.F 0).dom := rfl

/-- **The limit agrees with every late stage near a compact part of the domain**: some open `W ⊇ K` on which, from some stage on,
the limit and the stage have the same interior points and colours. -/
theorem eventually_agreesOn {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ (S.F 0).dom) :
    ∃ W, IsOpen W ∧ K ⊆ W ∧ ∀ᶠ n in atTop, S.limit.AgreesOff (S.F n) Wᶜ := by
  sorry

/-- The limit of plane maps is a plane map. -/
theorem limit_isPlaneMap (h : (S.F 0).IsPlaneMap) : S.limit.IsPlaneMap := h

/-- **Validity passes to the limit**: a unit pair of the limit lies in a compact set where the limit is a valid stage. -/
theorem limit_valid (h : ∀ n, (S.F n).Valid) : S.limit.Valid := by
  sorry

/-- **`IsModification` passes to the limit**: a ring arc of the limit is compact, so a ring arc of a late stage; a point's colours
are a late stage's. -/
theorem limit_isModification (h : ∀ n, (S.F 0).IsModification (S.F n)) : (S.F 0).IsModification S.limit := by
  sorry

end LocalSeq

/-! ## Locality: two maps agreeing on an open set -/

section Locality

variable {M F : ArcMap k} {W : Set ℂ}

/-- **The colours at a point are read near it.** -/
theorem coloursAt_eq_of_agreesOn (h : M.AgreesOff F Wᶜ) (hW : IsOpen W) {x : ℂ} (hx : x ∈ W) :
    M.coloursAt x = F.coloursAt x := by
  sorry

/-- **Ring arcs are read near them** (`Γ` on a compact arc inside `W`). -/
theorem onRingArc_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) (hW : IsOpen W) {p x : ℂ} {θ₁ θ₂ : ℝ}
    (hsub : ringArc p θ₁ θ₂ ⊆ W) : ringArc p θ₁ θ₂ ⊆ M.Γ ↔ ringArc p θ₁ θ₂ ⊆ F.Γ := by
  sorry

/-- **MERGE's availability is read in `B̄(v, 3)`** (valid maps: in- and out-type through the tile dichotomy at a carried colour). -/
theorem mergeAvailable_iff_of_agreesOn (hM : M.Valid) (hF : F.Valid) (h : M.AgreesOff F Wᶜ) (hW : IsOpen W) {v : ℂ}
    (hv : closedBall v 3 ⊆ W) : M.MergeAvailable v ↔ F.MergeAvailable v := by
  sorry

/-- **MERGE-RAY's availability is read near `v`** (horns only). -/
theorem rayAvailable_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) (hW : IsOpen W) {v : ℂ} (hv : closedBall v 3 ⊆ W) :
    M.RayAvailable v ↔ F.RayAvailable v := by
  sorry

/-- **SHAVE's availability is read in `B̄(v, 3)`** (horns, flanks, and clearness on unit circles about points near `v`). -/
theorem shaveAvailable_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) (hW : IsOpen W) {v : ℂ} (hv : closedBall v 3 ⊆ W) :
    M.ShaveAvailable v ↔ F.ShaveAvailable v := by
  sorry

/-- **The ring arcs about `P` and their (Q)/(R2) kinds are read in `B̄(P, 3)`** (sides, colours at `P`, the radius-2 witness). -/
theorem qrAt_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) (hW : IsOpen W) {P : ℂ} (hP : closedBall P 3 ⊆ W) :
    (∀ θ₁ θ₂ c c', M.IsRingArc P θ₁ θ₂ c c' → M.IsQArc P θ₁ θ₂ ∨ M.IsR2Arc P θ₁ θ₂) ↔
      (∀ θ₁ θ₂ c c', F.IsRingArc P θ₁ θ₂ c c' → F.IsQArc P θ₁ θ₂ ∨ F.IsR2Arc P θ₁ θ₂) := by
  sorry

end Locality

/-! ## The limit is terminal when every late stage is terminal near every point -/

namespace LocalSeq

variable (S : LocalSeq k)

/-- **Terminality passes to the limit** if at each point, from some stage on, no move is available there and every ring arc about it
is (Q) or (R2) — the procedure's fairness, read pointwise. -/
theorem limit_isTerminalMap (hP : (S.F 0).IsPlaneMap) (hval : ∀ n, (S.F n).Valid)
    (hev : ∀ v, ∀ᶠ n in atTop, ¬ (S.F n).MergeAvailable v ∧ ¬ (S.F n).RayAvailable v ∧ ¬ (S.F n).ShaveAvailable v ∧
      ∀ θ₁ θ₂ c c', (S.F n).IsRingArc v θ₁ θ₂ c c' → (S.F n).IsQArc v θ₁ θ₂ ∨ (S.F n).IsR2Arc v θ₁ θ₂) :
    S.limit.IsTerminalMap := by
  sorry

end LocalSeq

/-! ## Clean maps and their sites -/

variable (F : ArcMap k)

/-- **A clean map**: every point of `Γ` carries at least two colours (no part of an arc has one colour on both sides). -/
def IsClean : Prop := ∀ x ∈ F.Γ, 2 ≤ (F.coloursAt x).ncard

/-- **A site**: a point of the domain with a repeated colour or a horn — the only points where MERGE, MERGE-RAY or SHAVE can be
available (`not_available_of_not_isSite`). -/
def IsSite (x : ℂ) : Prop := x ∈ F.dom ∧ (F.HasRepeatedColour x ∨ ∃ α κ₁ κ₂ c, F.IsHorn x α κ₁ κ₂ c)

variable {F}

/-- Off the sites no move is available (MERGE needs two sectors of one colour; MERGE-RAY and SHAVE need a horn). -/
theorem not_available_of_not_isSite {x : ℂ} (hx : x ∈ F.dom) (hs : ¬ F.IsSite x) :
    ¬ F.MergeAvailable x ∧ ¬ F.RayAvailable x ∧ ¬ F.ShaveAvailable x := by
  sorry

/-- **A clean map's sites are isolated** (in a sector chart every point of the punctured ball is interior or on one branch with two
colours across it: one sector each side, no horn). -/
theorem IsClean.eventually_not_isSite (hc : F.IsClean) {x : ℂ} (hx : x ∈ F.dom) : ∀ᶠ y in 𝓝[≠] x, ¬ F.IsSite y := by
  sorry

/-- **Cleaning**: every valid map has a clean valid modification with the same colours at every point — the one-coloured parts of
`Γ` dropped (each arc replaced by its maximal sub-arcs of points of two or more colours), their points given the one colour around
them. -/
theorem exists_clean (hF : F.Valid) :
    ∃ F' : ArcMap k, F'.IsClean ∧ F'.Valid ∧ F.IsModification F' ∧ (∀ x, F'.coloursAt x = F.coloursAt x) ∧
      F'.Γ ⊆ F.Γ := by
  sorry

end ArcMap

/-! ### Spec examples -/

section Spec

open ArcMap

/-- The constant sequence's limit is its map's domain (a spec example for `LocalSeq.limit`). -/
example (F : ArcMap 2) : (LocalSeq.const F).limit.dom = F.dom := rfl

/-- Every stage of the constant sequence is its map (a spec example for `LocalSeq`). -/
example (F : ArcMap 2) : (LocalSeq.const F).F 5 = F := rfl

/-- The constant sequence's limit has no more arcs than its map (a spec example for `LocalSeq.limitArcs`). -/
example (F : ArcMap 2) : (LocalSeq.const F).limitArcs ⊆ F.arcs := fun _ ha => by
  obtain ⟨N, hN⟩ := eventually_atTop.mp ha
  exact hN N le_rfl

/-- The one-colour plane is clean: it has no arcs (a spec example for `IsClean`). -/
example (j : Fin 2) : (ArcMap.const univ isOpen_univ j).IsClean := by
  intro x hx
  simp [ArcMap.Γ, ArcMap.const] at hx

end Spec

end HadwigerNelson.Plane
