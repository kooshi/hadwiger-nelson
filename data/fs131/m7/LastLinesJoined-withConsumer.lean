import Proofs.HadwigerNelson.Plane.ValidMap.Procedure
import Proofs.HadwigerNelson.Plane.ValidMap.ArcStep

/-!
# FS131-IA2 — the last lines for `Procedure`, compiled in a scratch file (not part of the library)

What the job that holds `Procedure.lean` adds, once `Procedure` imports `Plane/ValidMap/ArcStep`:

* `IsMaxRingArc.meet` (FS131-IA1's W5, in the form `ArcBend.maxBad_centre` reads): a ring arc of `F` about `P` whose open arc meets
  that of a maximal ring arc `α` has `α`'s sides and lies in `α`.
* the proof of `exists_arcStep` in its repaired statement (record § 3.6) — here under the scratch name `exists_arcStep'`.
* the two changed places of `exists_procStep` (the call, and the `pot_le` bullet) — here in the copy `exists_procStep'`.

`bend_away_part_weak` stands in for `bend_away_part` with its horn clause in the arc step's form (inventory ruling 438 (b); on this
branch `BendStep`'s copy still has the iff): in `Procedure` the call is to `bend_away_part` itself.

Compile: `lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false data/fs131/ia2/ProcedureLastLines.lean` (iteration-grade
evidence only: it is not built by `scripts/build.sh`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## The last lines: W5 -/

/-- **A ring arc about `P` whose open arc meets a maximal ring arc's has its sides and lies in it** (FS131-IA1's W5, on point sets):
turn it by whole turns to share an interior angle (`isRingArc_add_int`), read the sides there (`IsRingArc.sides_eq`), unite
(`IsRingArc.union`) and use the maximality. -/
theorem IsMaxRingArc.meet {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hmax : F.IsMaxRingArc P θ₁ θ₂ c c') {a b : ℝ} {d d' : Fin k}
    (hD : F.IsRingArc P a b d d') (hnd : ¬ Disjoint (ringPt P '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂)) :
    (d = c ∧ d' = c') ∧ ringPt P '' Ioo a b ⊆ ringPt P '' Ioo θ₁ θ₂ := by
  rw [Set.not_disjoint_iff] at hnd
  obtain ⟨_, ⟨s, hs, rfl⟩, ⟨θ, hθ, hθs⟩⟩ := hnd
  have he : e θ = e s := by
    simp only [ringPt] at hθs
    exact add_left_cancel hθs
  obtain ⟨n, hn⟩ := e_eq_e_iff.mp he
  have hD' : F.IsRingArc P (a + 2 * π * n) (b + 2 * π * n) d d' := (isRingArc_add_int n).mpr hD
  have hθ' : θ ∈ Ioo (a + 2 * π * n) (b + 2 * π * n) := ⟨by linarith [hs.1], by linarith [hs.2]⟩
  obtain ⟨hcd, hcd'⟩ := hmax.1.sides_eq hD' hθ hθ'
  subst hcd hcd'
  have hov : max θ₁ (a + 2 * π * n) < min θ₂ (b + 2 * π * n) := by
    rw [max_lt_iff, lt_min_iff, lt_min_iff]
    exact ⟨⟨hmax.1.1, hθ.1.trans hθ'.2⟩, ⟨hθ'.1.trans hθ.2, by linarith [hD.1]⟩⟩
  have hU := hmax.1.union hD' hov
  obtain ⟨h1, h2⟩ := hmax.2.2 _ _ (min_le_left _ _) (le_max_left _ _) hU
  have ha : θ₁ ≤ a + 2 * π * n := by rw [← h1]; exact min_le_right _ _
  have hb : b + 2 * π * n ≤ θ₂ := by rw [← h2]; exact le_max_right _ _
  refine ⟨⟨rfl, rfl⟩, ?_⟩
  rintro _ ⟨t, ht, rfl⟩
  exact ⟨t + 2 * π * n, ⟨by linarith [ht.1], by linarith [ht.2]⟩, ringPt_add_int P t n⟩

/-! ## The last lines: `exists_arcStep`, repaired statement (record § 3.6) -/

theorem exists_arcStep' (hF : F.Valid) (hP : F.IsPlaneMap) (hc : F.IsClean) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hmax : F.IsMaxRingArc P θ₁ θ₂ c c') (hQ : ¬ F.IsQArc P θ₁ θ₂) (hR : ¬ F.IsR2Arc P θ₁ θ₂)
    (hnb : ¬ (c ∈ F.coloursAt P ∧ c' ∈ F.coloursAt P)) {T : Set ℂ}
    (hT : ∀ K, IsCompact K → (K ∩ T).Finite) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ε, 0 < ε ∧ ε < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧
      LocalStep F F' (cthickening ε (ringArc P θ₁ θ₂)) ∧ F.IsModification F' ∧
      F'.badCount P < F.badCount P ∧ (∀ x, F'.IsSite x → F.IsSite x) ∧
      (∀ x ∈ T, ∀ m, F.HasDegree x m → ∃ m' ≤ m, F'.HasDegree x m') ∧
      (∀ x j, F.HasHornCount x j → ∃ j' ≤ j, F'.HasHornCount x j') ∧
      ∀ Q ∈ T, Q ≠ P → F'.coloursAt Q ⊆ F.coloursAt Q ∧
        (F'.coloursAt Q = F.coloursAt Q → F'.badCount Q ≤ F.badCount Q) := by
  -- BEGIN last lines
  obtain ⟨ε, hε0, hεδ, hε1, hεT⟩ := exists_arcStep_radius hT P θ₁ θ₂ hδ
  have hfree := hmax.1.free_of_isClean hc
  -- the bend: away from `P` if the outer colour is carried there (then the inner is not), else toward `P`
  obtain ⟨M, h, K, g, hB⟩ : ∃ (M : ArcMap k) (h : ℂ ≃ₜ ℂ) (K : Set ℂ) (g : Fin k), ArcBend F M h K P θ₁ θ₂ c c' g ε := by
    by_cases hout : c' ∈ F.coloursAt P
    · have hin : c ∉ F.coloursAt P := fun h => hnb ⟨h, hout⟩
      obtain ⟨M, h, K, hM⟩ := bend_away_part hF hP hmax.1 hin hfree hε0
      exact ⟨M, h, K, c, ArcBend.of_away hP hmax.1 hin hout hM⟩
    · obtain ⟨M, h, K, hB⟩ := exists_arcBend_toward hF hmax.1 hout hfree hε0
      exact ⟨M, h, K, c', hB⟩
  obtain ⟨hV, hC, hstep, hmod, hsite, hdeg, hhorn, hcolT, -⟩ := hB.arcStep hc hε1.le hεT
  refine ⟨ε, hε0, hεδ, M, hV, hC, hstep, hmod, ?_, hsite, hdeg, hhorn, fun Q hQT hQP => ⟨hcolT Q hQT, fun hcol => ?_⟩⟩
  · -- `P`'s count drops: a bad maximal arc of `M` about `P` is one of `F` off `α°`, and `α` is one of `F`'s
    have hfin := badCount_lt_top hF hP P
    rw [badCount, encard_lt_top_iff] at hfin
    have hkey : ∀ {a b : ℝ} {d d' : Fin k}, M.IsMaxRingArc P a b d d' → ¬ M.IsQArc P a b → ¬ M.IsR2Arc P a b →
        Disjoint (ringPt P '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) ∧ F.IsMaxRingArc P a b d d' ∧ ¬ F.IsQArc P a b ∧
          ¬ F.IsR2Arc P a b := by
      intro a b d d' hM hQM hRM
      obtain ⟨hdisj, hFD, hmaxF, hQF, hRF⟩ := hB.maxBad_centre hF hc hε1.le
        (fun _ _ _ _ hD hnd => hmax.meet hD hnd) hM.1 hM.2.2 hQM hRM
      exact ⟨hdisj, ⟨hFD, hM.2.1, hmaxF⟩, hQF, hRF⟩
    have hsub : {p : ℝ × ℝ | ∃ c c', M.IsMaxRingArc P p.1 p.2 c c' ∧ ¬ M.IsQArc P p.1 p.2 ∧ ¬ M.IsR2Arc P p.1 p.2} ⊆
        {p : ℝ × ℝ | ∃ c c', F.IsMaxRingArc P p.1 p.2 c c' ∧ ¬ F.IsQArc P p.1 p.2 ∧ ¬ F.IsR2Arc P p.1 p.2} := by
      rintro ⟨a, b⟩ ⟨d, d', hM, hQM, hRM⟩
      exact ⟨d, d', (hkey hM hQM hRM).2⟩
    refine (hfin.subset hsub).encard_lt_encard ⟨hsub, fun hrev => ?_⟩
    obtain ⟨d, d', hM, hQM, hRM⟩ := hrev (show (θ₁, θ₂) ∈ _ from ⟨c, c', hmax, hQ, hR⟩)
    obtain ⟨t, ht⟩ := nonempty_Ioo.mpr hmax.1.1
    exact Set.disjoint_left.mp (hkey hM hQM hRM).1 ⟨t, ht, rfl⟩ ⟨t, ht, rfl⟩
  · -- at `Q ≠ P` with its colours kept, a bad maximal arc of `M` about `Q` is one of `F`
    refine encard_le_encard ?_
    rintro ⟨a, b⟩ ⟨d, d', hM, hQM, hRM⟩
    obtain ⟨hFD, hmaxF, hQF, hRF⟩ := hB.maxBad_other hF hc hε1.le hQP hcol hM.1 hM.2.2 hQM hRM
    exact ⟨d, d', ⟨hFD, hM.2.1, hmaxF⟩, hQF, hRF⟩
  -- END last lines

/-! ## The consumer: `exists_procStep` with the two changed places (generated by `tools/fs131_ia2_lastlines.py`)

The copy of `Procedure`'s `exists_procStep` under the name `exists_procStep'`, calling `exists_arcStep'` with `hG.plane`, its
`pot_le` bullet reading the degree clause at `x ∈ T` as `∃ m' ≤ m`. Nothing else differs from `Procedure.lean`'s text. -/

/-- **The procedure's step exists**: at the least-index treatment point with something to do, a vertex step if a move is
available (`exists_vertexStep`, its radius below the distance to every other treatment point), else an arc step at a bad maximal
arc (`exists_arcStep`; its sides are not both at the centre, `mergeAvailable_of_bothKind`); idle if nothing is left. -/
theorem exists_procStep' (hP : F.IsPlaneMap) (hc : F.IsClean) (f : ℂ → ℕ) {G : ArcMap k} (hG : ProcInv F G) :
    ∃ G' U a, ProcInv F G' ∧ ProcStep F.treatPts f G G' U a := by
  classical
  have hGd : ∀ x, x ∈ G.dom := fun x => by rw [hG.plane]; trivial
  have hT : ∀ K, IsCompact K → (K ∩ F.treatPts).Finite := fun K hK =>
    treatPts_inter_finite hP hc hK (by rw [hP]; exact subset_univ _)
  by_cases hex : ∃ t ∈ F.treatPts, G.Todo t
  swap
  · push Not at hex
    exact ⟨G, ∅, none, hG, ProcStep.refl f hex⟩
  -- the least-index point with something to do
  obtain ⟨t, ⟨htT, htodo⟩, hmin⟩ : ∃ t, (t ∈ F.treatPts ∧ G.Todo t) ∧
      ∀ t', t' ∈ F.treatPts ∧ G.Todo t' → f t ≤ f t' := by
    obtain ⟨t₀, ht₀⟩ := hex
    have hne : (f '' {t | t ∈ F.treatPts ∧ G.Todo t}).Nonempty := ⟨f t₀, t₀, ht₀, rfl⟩
    obtain ⟨t, ht, hft⟩ := Nat.sInf_mem hne
    exact ⟨t, ht, fun t' ht' => hft ▸ Nat.sInf_le ⟨t', ht', rfl⟩⟩
  have hleast : ∀ t' ∈ F.treatPts, G.Todo t' → f t ≤ f t' := fun t' h1 h2 => hmin t' ⟨h1, h2⟩
  by_cases hmv : G.MoveAt t
  · -- a vertex step
    obtain ⟨m, -, hdeg⟩ := exists_hasDegree_of_mem_dom (hGd t)
    obtain ⟨j, hhorn⟩ := exists_hasHornCount (hGd t)
    obtain ⟨δ, hδ0, hδ2, hδT⟩ : ∃ δ : ℝ, 0 < δ ∧ δ ≤ 1 / 2 ∧ ∀ x ∈ F.treatPts, x ≠ t → δ < dist x t := by
      have hfin : ((closedBall t 1 ∩ F.treatPts) \ {t}).Finite := (hT _ (isCompact_closedBall t 1)).sdiff
      obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp hfin.isClosed.isOpen_compl t (by simp)
      refine ⟨min (1 / 2) (ε / 2), by positivity, min_le_left _ _, fun x hx hxt => ?_⟩
      by_cases hx1 : dist x t ≤ 1
      · have : x ∉ ball t ε := fun hxb => hball hxb ⟨⟨mem_closedBall.mpr hx1, hx⟩, hxt⟩
        rw [mem_ball, not_lt] at this
        exact lt_of_lt_of_le (lt_of_le_of_lt (min_le_right _ _) (by linarith)) this
      · push Not at hx1
        exact lt_of_le_of_lt (min_le_left _ _) (by linarith)
    obtain ⟨ρ, hρ0, hρδ, G', hV, hC, hstep, hmod, ⟨m', j', hlt, hdeg', hhorn'⟩, hcol, hsite⟩ :=
      exists_vertexStep hG.valid hG.clean (hGd t) hmv hdeg hhorn hδ0
    have hUc : IsClosed (closedBall t ρ) := isClosed_closedBall
    have hoff : ∀ x ∈ F.treatPts, x ≠ t → x ∉ closedBall t ρ := fun x hx hxt hxb => by
      have := hδT x hx hxt; rw [mem_closedBall] at hxb; linarith
    have hpot : G'.pot t < G.pot t := by rw [pot_eq hdeg' hhorn', pot_eq hdeg hhorn]; exact hlt
    refine ⟨G', closedBall t ρ, some (t, true), ⟨hV, hC, ?_, hG.modif.trans hmod, ?_⟩,
      ⟨hstep, isCompact_closedBall t ρ, ?_, ?_, fun h => absurd h (by simp), ?_, ?_, fun _ h => absurd h (by simp), ?_⟩⟩
    · show G'.dom = univ
      rw [← hstep.agreesOff.1]; exact hG.plane
    · intro x hx
      by_cases hxb : x ∈ closedBall t ρ
      · by_cases hxt : x = t
        · exact hxt ▸ htT
        · exact absurd hx (hsite x hxb hxt)
      · exact hG.sites x ((isSite_iff_of_agreesOff hstep.agreesOff hUc hxb).mp hx)
    · intro x hx
      by_cases hxt : x = t
      · subst hxt; exact hpot.le
      · have hxb := hoff x hx hxt
        obtain ⟨mx, -, hmx⟩ := exists_hasDegree_of_mem_dom (hGd x)
        obtain ⟨jx, hjx⟩ := exists_hasHornCount (hGd x)
        rw [pot_eq ((hasDegree_iff_of_agreesOff hstep.agreesOff hUc hxb mx).mpr hmx)
          ((hasHornCount_iff_of_agreesOff hstep.agreesOff hUc hxb jx).mpr hjx), pot_eq hmx hjx]
    · intro x hx
      by_cases hxt : x = t
      · subst hxt; exact hcol
      · have hxb := hoff x hx hxt
        exact (coloursAt_eq_of_agreesOn (W := (closedBall t ρ)ᶜ) (by rw [compl_compl]; exact hstep.agreesOff)
          hUc.isOpen_compl hxb).subset
    · intro t' b h
      cases h
      exact ⟨htT, htodo, hleast, closedBall_subset_closedBall (by linarith)⟩
    · intro t' h
      cases h
      exact hpot
    · intro x hx
      by_cases hd : dist x t ≤ 4
      · exact Or.inr (Or.inr ⟨t, rfl, hd⟩)
      · push Not at hd
        refine Or.inl (le_of_eq (badCount_eq_of_agreesOff hstep.agreesOff hUc ?_))
        rw [Set.disjoint_left]
        intro z hz hz'
        rw [mem_closedBall] at hz hz'
        have := dist_triangle x z t
        rw [dist_comm x z] at this
        linarith
  · -- an arc step
    have hb : G.badCount t ≠ 0 := htodo.resolve_left hmv
    have hb' := hb
    rw [badCount, Ne, encard_eq_zero, ← Ne, ← nonempty_iff_ne_empty] at hb'
    obtain ⟨⟨θ₁, θ₂⟩, c, c', hmax, hQ, hR⟩ := hb'
    have hnb : ¬ (c ∈ G.coloursAt t ∧ c' ∈ G.coloursAt t) := by
      rintro ⟨h1, h2⟩
      by_cases h4 : 4 ≤ (G.coloursAt t).ncard
      · exact hQ ⟨c, c', hmax.1, h1, h2, h4⟩
      · exact hmv (Or.inl (mergeAvailable_of_bothKind hG.valid hG.plane hmax.1 h1 h2 (by omega)))
    obtain ⟨ε, hε0, hε2, G', hV, hC, hstep, hmod, hbad, hsites, hdegs, hhorns, hQs⟩ :=
      exists_arcStep' hG.valid hG.plane hG.clean hmax hQ hR hnb hT (show (0 : ℝ) < 1 / 2 by norm_num)
    have hUc : IsClosed (cthickening ε (ringArc t θ₁ θ₂)) := isClosed_cthickening
    have htU : t ∉ cthickening ε (ringArc t θ₁ θ₂) := fun h => by
      have := (dist_of_mem_cthickening_ringArc hε0.le h).1
      rw [dist_self] at this; linarith
    refine ⟨G', cthickening ε (ringArc t θ₁ θ₂), some (t, false), ⟨hV, hC, ?_, hG.modif.trans hmod,
      fun x hx => hG.sites x (hsites x hx)⟩,
      ⟨hstep, (isCompact_ringArc t θ₁ θ₂).cthickening, ?_, ?_, fun h => absurd h (by simp), ?_, fun _ h => absurd h (by simp), ?_, ?_⟩⟩
    · show G'.dom = univ
      rw [← hstep.agreesOff.1]; exact hG.plane
    · intro x hx
      obtain ⟨mx, -, hmx⟩ := exists_hasDegree_of_mem_dom (hGd x)
      obtain ⟨jx, hjx⟩ := exists_hasHornCount (hGd x)
      obtain ⟨m', hm', hdeg'⟩ := hdegs x hx mx hmx
      obtain ⟨j', hj', hjx'⟩ := hhorns x jx hjx
      rw [pot_eq hdeg' hjx', pot_eq hmx hjx]
      omega
    · intro x hx
      by_cases hxt : x = t
      · subst hxt
        exact (coloursAt_eq_of_agreesOn (W := (cthickening ε (ringArc x θ₁ θ₂))ᶜ)
          (by rw [compl_compl]; exact hstep.agreesOff) hUc.isOpen_compl htU).subset
      · exact (hQs x hx hxt).1
    · intro t' b h
      cases h
      refine ⟨htT, htodo, hleast, fun z hz => ?_⟩
      rw [mem_closedBall]
      linarith [(dist_of_mem_cthickening_ringArc hε0.le hz).2]
    · intro t' h
      cases h
      exact hbad
    · intro x hx
      by_cases hxt : x = t
      · subst hxt; exact Or.inl hbad.le
      · by_cases heq : G'.coloursAt x = G.coloursAt x
        · exact Or.inl ((hQs x hx hxt).2 heq)
        · exact Or.inr (Or.inl heq)

end ArcMap

end HadwigerNelson.Plane

#print axioms HadwigerNelson.Plane.ArcMap.IsMaxRingArc.meet
#print axioms HadwigerNelson.Plane.ArcMap.exists_arcStep'
#print axioms HadwigerNelson.Plane.ArcMap.exists_procStep'
