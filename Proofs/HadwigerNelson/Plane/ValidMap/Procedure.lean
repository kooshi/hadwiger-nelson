import Proofs.HadwigerNelson.Plane.ValidMap.Limit

/-!
# The terminal procedure: FS112-N2-RED's bends with FS110-N4-TERM's moves, as one locally finite sequence (FS131-KL1)

Wave 5's construction behind `exists_red` and `exists_terminal` (`plans/FS131-limit-kernel-plan.md` §§ 3–4): **every valid map of the
plane has a modification that is a terminal valid map** (`exists_terminalMap`, every `k`). Clean the map (`exists_clean`), then run
one procedure over its *treatment points* (`treatPts`: the sites and the centres of unit arcs, never created afterwards): at the
least-index point with something to do, apply a **vertex step** (MERGE, MERGE-RAY or SHAVE at a site, then cleaned: its degree drops,
`exists_vertexStep`) or an **arc step** (a toward or away bend of a maximal bad unit arc, then cleaned: the point's count of maximal
bad arcs drops, `exists_arcStep`). A site is treated at most its initial degree times; a centre's bad count rises only at the finitely
many vertex steps within distance `3` and at the at most `k` stages where it loses a colour, so it too is treated finitely often
(`exists_terminalSeq`). The supports are then locally finite, and the limit (`Plane/ValidMap/Limit`) is the terminal map.

**Where the steps' proofs live** (inventory items 371–372): `exists_vertexStep` and `exists_arcStep` read the moves' constructions —
`main`'s `Moves` (`exists_shave_aux`, `exists_rayMerge_aux` through `Near.move`), `MergeMove` (`exists_merge_aux`) and `UnitArc`
(`bend_toward`, `bend_away_whole`, the N2-TAN bend) — followed by `exists_clean`; they are stated here and proved after this branch
merges `main`, in this module with those imports (or a module between them; the plan's § 4.3). Until then they are `sorry`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-! ## Maximal unit arcs, bad arcs, treatment points -/

/-- **A maximal constant-sided unit arc** of `ω(P)`: a ring arc with sides `c`, `c'`, its start normalised to `[0, 2π)`, not contained
in a longer one with the same sides. (In a valid map ring arcs are at most `60°` long, `l60_le`, so every ring arc lies in a maximal
one.) -/
def IsMaxRingArc (P : ℂ) (θ₁ θ₂ : ℝ) (c c' : Fin k) : Prop :=
  F.IsRingArc P θ₁ θ₂ c c' ∧ θ₁ ∈ Ico 0 (2 * π) ∧
    ∀ θ₁' θ₂', θ₁' ≤ θ₁ → θ₂ ≤ θ₂' → F.IsRingArc P θ₁' θ₂' c c' → θ₁' = θ₁ ∧ θ₂' = θ₂

/-- **The bad count at `P`**: the number of maximal unit arcs about `P` that are neither (Q) nor (R2) (as `encard`). A maximal arc is
bad exactly when some sub-arc is neither — (Q) is read on the sides and `P`, and (R2) of the whole arc gives (R2) of every sub-arc —
so `badCount F P = 0` is "every ring arc about `P` is (Q) or (R2)" (`badCount_eq_zero_iff`). -/
noncomputable def badCount (P : ℂ) : ℕ∞ :=
  {p : ℝ × ℝ | ∃ c c', F.IsMaxRingArc P p.1 p.2 c c' ∧ ¬ F.IsQArc P p.1 p.2 ∧ ¬ F.IsR2Arc P p.1 p.2}.encard

/-- **Treatment points**: the sites and the centres of unit arcs of `Γ` — where a step may act. No step creates one
(`exists_vertexStep`, `exists_arcStep`), so the initial map's enumerate every stage's. -/
def treatPts : Set ℂ := {v | F.IsSite v ∨ ∃ x, F.OnRingArc v x}

variable {F}

/-- `badCount F P = 0` exactly when every ring arc about `P` is (Q) or (R2) (every ring arc lies in a maximal one, `l60_le`). -/
theorem badCount_eq_zero_iff (hF : F.Valid) (P : ℂ) :
    F.badCount P = 0 ↔ ∀ θ₁ θ₂ c c', F.IsRingArc P θ₁ θ₂ c c' → F.IsQArc P θ₁ θ₂ ∨ F.IsR2Arc P θ₁ θ₂ := by
  sorry

/-- **Finitely many maximal arcs about a point** of a clean valid map (the sides change only at sites of `ω(P)`, finitely many). -/
theorem badCount_lt_top (hF : F.Valid) (hc : F.IsClean) (P : ℂ) : F.badCount P < ⊤ := by
  sorry

/-- **Treatment points are locally finite** in a clean map: sites are isolated (`IsClean.eventually_not_isSite`) and closed; the
centres of the unit arcs meeting a compact set are finitely many (local finiteness of the arcs). -/
theorem treatPts_inter_finite (hc : F.IsClean) {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ F.dom) :
    (K ∩ F.treatPts).Finite := by
  sorry

/-- **A both-kind arc at a centre of at most three colours makes MERGE available there** (N2-RED's parenthesis: by U1 the side
cones hold neither side colour, and a colour holding both side cones is a colour of two sectors with a non-empty allowed cone). So
an arc step is needed only at in-only, out-only and inert arcs. -/
theorem mergeAvailable_of_bothKind (hF : F.Valid) (hP : F.IsPlaneMap) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hA : F.IsRingArc P θ₁ θ₂ c c') (hc : c ∈ F.coloursAt P) (hc' : c' ∈ F.coloursAt P) (h3 : (F.coloursAt P).ncard ≤ 3) :
    F.MergeAvailable P := by
  sorry

/-! ## The two steps (the strengthened moves, cleaned) -/

/-- **The vertex step** (MERGE, MERGE-RAY or SHAVE at a site, then `exists_clean`): at a point of a clean valid map where a move is
available, for every bound `δ > 0`, a clean valid modification that is a local step on `B̄(v, ρ)`, `ρ < δ`, in which `v`'s degree
drops, `v` gains no colour, and no other point of the disc is a site. Proof after the merge with `main`: the move's construction
(`exists_merge_aux`, `exists_rayMerge_aux`, `exists_shave_aux` — `Near.move`/`surgery`, whose arcs are `trimArcs` plus new arcs in the
disc: `LocalStep` from `trimArcs_spec`), then `exists_clean` (which drops the kept germs that now have one colour on both sides and
the one-coloured parts of the rim circle — FS131-KL1's finding: without it SHAVE raises `v`'s degree). -/
theorem exists_vertexStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : v ∈ F.dom)
    (hav : F.MergeAvailable v ∨ F.RayAvailable v ∨ F.ShaveAvailable v) {m : ℕ} (hdeg : F.HasDegree v m) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ, 0 < ρ ∧ ρ < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' < m, F'.HasDegree v m') ∧ F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
  sorry

/-- **The arc step** (a bend of a maximal bad unit arc, then `exists_clean`): at a maximal unit arc about `P`, neither (Q) nor (R2),
whose side colours are not both carried at `P`, for every `δ > 0` and every locally finite set `T` (the treatment points), a clean
valid modification that is a local step on the closed `ε`-neighbourhood of the arc, `ε < δ`, lowering `P`'s bad count, creating no
site and changing no site's degree, and at every other point of `T` adding no colour and — unless it loses one — raising no bad
count. The toward bend (`bend_toward`) when the outer colour is absent at `P`; else the away bend (`bend_away_whole`, or N2-TAN's
tangent bend on the parts of the arc with no radius-2 witness). **The last clause is FS131-KL1's question (5)** (inventory item 372):
a bend's lens never cuts another arc's (R2) witness — a witness arc `R₂(β)` cannot cross the bent arc's open part, since past it
`R₂(β)` would lie in the outer tile, outside the closure of the inner colour's class (one mind's sketch; this child is its check). -/
theorem exists_arcStep (hF : F.Valid) (hc : F.IsClean) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hmax : F.IsMaxRingArc P θ₁ θ₂ c c') (hQ : ¬ F.IsQArc P θ₁ θ₂) (hR : ¬ F.IsR2Arc P θ₁ θ₂)
    (hnb : ¬ (c ∈ F.coloursAt P ∧ c' ∈ F.coloursAt P)) {T : Set ℂ}
    (hT : ∀ K, IsCompact K → (K ∩ T).Finite) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ε, 0 < ε ∧ ε < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧
      LocalStep F F' (cthickening ε (ringArc P θ₁ θ₂)) ∧ F.IsModification F' ∧
      F'.badCount P < F.badCount P ∧ (∀ x, F'.IsSite x → F.IsSite x) ∧
      (∀ x m, F.HasDegree x m → F'.HasDegree x m) ∧
      ∀ Q ∈ T, Q ≠ P → F'.coloursAt Q ⊆ F.coloursAt Q ∧
        (F'.coloursAt Q = F.coloursAt Q → F'.badCount Q ≤ F.badCount Q) := by
  sorry

/-! ## The procedure and the terminal map -/

/-- **The procedure** (N4-TERM's enumeration with N2-RED's bends): from a clean valid plane map, a locally finite sequence of local
steps through clean valid modifications, after which, at every point, from some stage on, no move is available and every unit arc
about it is (Q) or (R2). Enumerate `treatPts F` (countable: `treatPts_inter_finite`); at each stage act at the least-index point with
something to do (an available move: `exists_vertexStep`; else a bad maximal arc, whose sides are then not both at `P` by
`mergeAvailable_of_bothKind`: `exists_arcStep`), with the step's radius below a third of the distance to the other treatment points
nearby; idle (`LocalStep.refl`) if nothing is left. Each point is acted on finitely often (degree; bad count between its finitely
many rises), so the supports are locally finite, and a point with something to do from some stage on would be chosen infinitely
often. -/
theorem exists_terminalSeq (hF : F.Valid) (hP : F.IsPlaneMap) (hc : F.IsClean) :
    ∃ S : LocalSeq k, S.F 0 = F ∧ (∀ n, (S.F n).Valid ∧ F.IsModification (S.F n)) ∧
      ∀ v, ∀ᶠ n in atTop, ¬ (S.F n).MergeAvailable v ∧ ¬ (S.F n).RayAvailable v ∧ ¬ (S.F n).ShaveAvailable v ∧
        ∀ θ₁ θ₂ c c', (S.F n).IsRingArc v θ₁ θ₂ c c' → (S.F n).IsQArc v θ₁ θ₂ ∨ (S.F n).IsR2Arc v θ₁ θ₂ := by
  sorry

/-- **Every valid map of the plane has a modification that is a terminal valid map** (FS112-N2-TERM's construction, every `k`; the
shorter route of FS131-KL1, inventory item 372: `exists_red` and `exists_terminal` are read off it). Clean (`exists_clean`), run the
procedure (`exists_terminalSeq`), take the limit (`LocalSeq.limit_isModification`, `LocalSeq.limit_isTerminalMap`). Inhabitant of the
hypotheses: `sevenBrickMap` at seven colours (`sevenBrickMap_valid`, `sevenBrickMap_isPlaneMap`). -/
theorem exists_terminalMap (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ M : ArcMap k, F.IsModification M ∧ M.IsTerminalMap := by
  obtain ⟨F₀, hc, hF₀, hmod₀, -, -⟩ := exists_clean hF
  have hP₀ : F₀.IsPlaneMap := by
    show F₀.dom = univ
    rw [hmod₀.dom_eq]; exact hP
  obtain ⟨S, hS0, hS, hev⟩ := exists_terminalSeq hF₀ hP₀ hc
  have hmod : ∀ n, (S.F 0).IsModification (S.F n) := fun n => by rw [hS0]; exact (hS n).2
  have hlim := S.limit_isModification hmod
  rw [hS0] at hlim
  exact ⟨S.limit, hmod₀.trans hlim, S.limit_isTerminalMap (by rw [hS0]; exact hP₀) (fun n => (hS n).1) hev⟩

end ArcMap

end HadwigerNelson.Plane
