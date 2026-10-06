import Proofs.HadwigerNelson.Plane.ValidMap.Procedure
import Proofs.HadwigerNelson.Plane.ValidMap.OpenMove

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

theorem exists_vertexStep' (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : v ∈ F.dom)
    (hav : F.MergeAvailable v ∨ F.RayAvailable v ∨ F.ShaveAvailable v) {m j : ℕ} (hdeg : F.HasDegree v m)
    (hhorn : F.HasHornCount v j) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ, 0 < ρ ∧ ρ < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
  sorry

theorem exists_arcStep' (hF : F.Valid) (hc : F.IsClean) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hmax : F.IsMaxRingArc P θ₁ θ₂ c c') (hQ : ¬ F.IsQArc P θ₁ θ₂) (hR : ¬ F.IsR2Arc P θ₁ θ₂)
    (hnb : ¬ (c ∈ F.coloursAt P ∧ c' ∈ F.coloursAt P)) {T : Set ℂ}
    (hT : ∀ K, IsCompact K → (K ∩ T).Finite) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ε, 0 < ε ∧ ε < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧
      LocalStep F F' (cthickening ε (ringArc P θ₁ θ₂)) ∧ F.IsModification F' ∧
      F'.badCount P < F.badCount P ∧ (∀ x, F'.IsSite x → F.IsSite x) ∧
      (∀ x m, F.HasDegree x m → F'.HasDegree x m) ∧
      (∀ x j, F.HasHornCount x j → ∃ j' ≤ j, F'.HasHornCount x j') ∧
      ∀ Q ∈ T, Q ≠ P → F'.coloursAt Q ⊆ F.coloursAt Q ∧
        (F'.coloursAt Q = F.coloursAt Q → F'.badCount Q ≤ F.badCount Q) := by
  sorry

/-! ## Locality off a closed support (small radii) -/

section LocalitySmall

variable {M : ArcMap k} {U : Set ℂ}

/-- Off a closed set, the small balls about a point miss it. -/
theorem eventually_ball_subset_compl (hU : IsClosed U) {x : ℂ} (hx : x ∉ U) : ∀ᶠ r in 𝓝[>] (0 : ℝ), ball x r ⊆ Uᶜ := by
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp hU.isOpen_compl x hx
  filter_upwards [Ioo_mem_nhdsGT hε] with r hr
  exact (ball_subset_ball hr.2.le).trans hball

/-- **The degree of a point off the closed support of a step is unchanged.** -/
theorem hasDegree_iff_of_agreesOff (h : M.AgreesOff F U) (hU : IsClosed U) {x : ℂ} (hx : x ∉ U) (m : ℕ) :
    M.HasDegree x m ↔ F.HasDegree x m := by
  have h' : M.AgreesOff F Uᶜᶜ := by rwa [compl_compl]
  refine eventually_congr ?_
  filter_upwards [eventually_ball_subset_compl hU hx] with r hr
  have : {S | M.IsSector x r S} = {S | F.IsSector x r S} := by
    ext S; exact isSector_iff_of_agreesOn h' hr
  rw [this]

/-- **The horn count of a point off the closed support of a step is unchanged.** -/
theorem hasHornCount_iff_of_agreesOff (h : M.AgreesOff F U) (hU : IsClosed U) {x : ℂ} (hx : x ∉ U) (j : ℕ) :
    M.HasHornCount x j ↔ F.HasHornCount x j := by
  have h' : M.AgreesOff F Uᶜᶜ := by rwa [compl_compl]
  refine eventually_congr ?_
  filter_upwards [eventually_ball_subset_compl hU hx] with r hr
  have : {S | M.IsSector x r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet x α κ₁ κ₂ r} =
      {S | F.IsSector x r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet x α κ₁ κ₂ r} := by
    ext S; exact and_congr_left fun _ => isSector_iff_of_agreesOn h' hr
  rw [this]

/-- **Sites off the closed support of a step are unchanged.** -/
theorem isSite_iff_of_agreesOff (h : M.AgreesOff F U) (hU : IsClosed U) {x : ℂ} (hx : x ∉ U) :
    M.IsSite x ↔ F.IsSite x := by
  have h' : M.AgreesOff F Uᶜᶜ := by rwa [compl_compl]
  have hev := eventually_ball_subset_compl hU hx
  unfold IsSite
  rw [h.1]
  refine and_congr_right fun _ => or_congr ?_ ?_
  · refine exists_congr fun c => eventually_congr ?_
    filter_upwards [hev] with r hr
    rw [sectorsOf_eq_of_agreesOn h' hr]
  · refine exists_congr fun α => exists_congr fun κ₁ => exists_congr fun κ₂ => exists_congr fun c =>
      and_congr_right fun _ => eventually_congr ?_
    filter_upwards [hev] with r hr
    refine and_congr (isSector_iff_of_agreesOn h' hr) ⟨fun hc z hz => ?_, fun hc z hz => ?_⟩
    · have := hc hz
      simp only [mem_preimage, mem_singleton_iff] at this ⊢
      rw [← this]; exact (h.2 z (hr (hornSet_subset_ball _ _ _ _ _ hz))).2
    · have := hc hz
      simp only [mem_preimage, mem_singleton_iff] at this ⊢
      rw [← this]; exact (h.2 z (hr (hornSet_subset_ball _ _ _ _ _ hz))).2.symm

/-- **The bad count of a point whose closed disc of radius `3` misses the closed support of a step is unchanged.** -/
theorem badCount_eq_of_agreesOff (h : M.AgreesOff F U) (hU : IsClosed U) {P : ℂ} (hP : Disjoint (closedBall P 3) U) :
    M.badCount P = F.badCount P := by
  have h' : M.AgreesOff F Uᶜᶜ := by rwa [compl_compl]
  have hsub : closedBall P 3 ⊆ Uᶜ := fun z hz hzU => (Set.disjoint_left.mp hP) hz hzU
  have hW := hU.isOpen_compl
  unfold badCount IsMaxRingArc
  simp only [isRingArc_iff_of_agreesOn h' hW hsub, isQArc_iff_of_agreesOn h' hW hsub, isR2Arc_iff_of_agreesOn h' hW hsub]

end LocalitySmall

/-! ## The potential of a site -/

/-- The horn count exists at every point of the domain. -/
theorem exists_hasHornCount {v : ℂ} (hv : v ∈ F.dom) : ∃ j, F.HasHornCount v j := by
  obtain ⟨X⟩ := exists_near hv
  rcases Nat.eq_zero_or_pos X.n with hn | hn
  · refine ⟨0, ?_⟩
    filter_upwards [Ioc_mem_nhdsGT X.hC.pos] with r hr
    rw [Nat.cast_zero, encard_eq_zero, eq_empty_iff_forall_notMem]
    rintro S ⟨hS, α, κ₁, κ₂, -, rfl⟩
    have hball := (X.hC.isSector_iff_of_zero hn hr).mp hS
    have hv' : v ∈ hornSet v α κ₁ κ₂ r := hball ▸ mem_ball_self hr.1
    have := hv'.2.1
    simp [frameX] at this
  · exact ⟨_, X.hasHornCount_chart hn⟩

/-- **The potential of a point**: its degree plus its number of horns (`0` where either is undefined). The procedure's vertex
steps lower it (FS131-E6-ROUTE). -/
noncomputable def pot (F : ArcMap k) (v : ℂ) : ℕ := by
  classical
  exact if h : ∃ s : ℕ, ∃ m j, F.HasDegree v m ∧ F.HasHornCount v j ∧ s = m + j then h.choose else 0

/-- The potential is the degree plus the horn count. -/
theorem pot_eq {v : ℂ} {m j : ℕ} (hm : F.HasDegree v m) (hj : F.HasHornCount v j) : F.pot v = m + j := by
  have h : ∃ s : ℕ, ∃ m j, F.HasDegree v m ∧ F.HasHornCount v j ∧ s = m + j := ⟨_, m, j, hm, hj, rfl⟩
  unfold pot
  rw [dif_pos h]
  obtain ⟨m', j', hm', hj', hs⟩ := h.choose_spec
  rw [hs, hm.eq hm', hj.eq hj']

/-- **A sequence of naturals that rises only at finitely many stages falls at finitely many stages.** -/
theorem finite_strict_of_antitone_off (b : ℕ → ℕ) {R : Set ℕ} (hR : R.Finite) (h : ∀ n ∉ R, b (n + 1) ≤ b n) :
    {n | b (n + 1) < b n}.Finite := by
  obtain ⟨N, hN⟩ := hR.bddAbove
  have hanti : ∀ s, N < s → ∀ n, s ≤ n → b n ≤ b s := by
    intro s hs n hn
    induction n, hn using Nat.le_induction with
    | base => exact le_rfl
    | succ n hn ih => exact (h n fun hnR => absurd (hN hnR) (by omega)).trans ih
  have key : ∀ B s, N < s → b s ≤ B → ∃ M, ∀ n, M ≤ n → ¬ b (n + 1) < b n := by
    intro B
    induction B with
    | zero =>
      intro s hs hb
      refine ⟨s, fun n hn hlt => ?_⟩
      have := hanti s hs n hn
      omega
    | succ B ih =>
      intro s hs hb
      by_cases hex : ∃ n, s ≤ n ∧ b (n + 1) < b n
      · obtain ⟨n₀, hn₀, hlt⟩ := hex
        have := hanti s hs n₀ hn₀
        exact ih (n₀ + 1) (by omega) (by omega)
      · push Not at hex
        exact ⟨s, fun n hn hlt => absurd hlt (not_lt.mpr (hex n hn))⟩
  obtain ⟨M, hM⟩ := key (b (N + 1)) (N + 1) (by omega) le_rfl
  refine (finite_lt_nat M).subset fun n hn => ?_
  by_contra hge
  exact hM n (by simpa using hge) hn

/-! ## The procedure's invariant and one step -/

/-- A move is available at `v`. -/
def MoveAt (F : ArcMap k) (v : ℂ) : Prop := F.MergeAvailable v ∨ F.RayAvailable v ∨ F.ShaveAvailable v

/-- Something is left to do at `v`: a move is available, or a maximal unit arc about `v` is neither (Q) nor (R2). -/
def Todo (F : ArcMap k) (v : ℂ) : Prop := F.MoveAt v ∨ F.badCount v ≠ 0

/-- **The procedure's invariant** at a stage `G` of the run from `F`: a clean valid map of the plane, a modification of `F`,
whose sites are treatment points of `F`. -/
structure ProcInv (F G : ArcMap k) : Prop where
  /-- Valid. -/
  valid : G.Valid
  /-- Clean. -/
  clean : G.IsClean
  /-- Of the plane. -/
  plane : G.IsPlaneMap
  /-- A modification of the initial map. -/
  modif : F.IsModification G
  /-- No site but at an initial treatment point. -/
  sites : ∀ x, G.IsSite x → x ∈ F.treatPts

/-- Under the invariant, something is left to do only at the initial map's treatment points. -/
theorem ProcInv.mem_treatPts_of_todo {G : ArcMap k} (h : ProcInv F G) {v : ℂ} (hv : G.Todo v) : v ∈ F.treatPts := by
  rcases hv with hmv | hb
  · refine h.sites v ?_
    by_contra hs
    have := not_available_of_not_isSite (by rw [h.plane]; trivial) hs
    exact hmv.elim this.1 fun h' => h'.elim this.2.1 this.2.2
  · rw [badCount, Ne, encard_eq_zero, ← Ne, ← nonempty_iff_ne_empty] at hb
    obtain ⟨⟨θ₁, θ₂⟩, c, c', hmax, -, -⟩ := hb
    have hA := hmax.1
    exact Or.inr ⟨ringPt v θ₁, h.modif.ringArcsWithin v _ ⟨θ₁, θ₂, hA.1, ⟨θ₁, ⟨le_rfl, hA.1.le⟩, rfl⟩, hA.2.1⟩⟩

/-- **One step of the procedure** from `G` to `G'` with support `U`, acting at `a` (`none`: idle; `some (t, true)`: a vertex step
at `t`; `some (t, false)`: an arc step at `t`), over the treatment points `T` indexed by `f`. -/
structure ProcStep (T : Set ℂ) (f : ℂ → ℕ) (G G' : ArcMap k) (U : Set ℂ) (a : Option (ℂ × Bool)) : Prop where
  /-- A local step. -/
  step : LocalStep G G' U
  /-- Its support is compact. -/
  isCompact : IsCompact U
  /-- No treatment point's potential rises. -/
  pot_le : ∀ x ∈ T, G'.pot x ≤ G.pot x
  /-- No treatment point gains a colour. -/
  col_sub : ∀ x ∈ T, G'.coloursAt x ⊆ G.coloursAt x
  /-- The idle step: nothing is left to do. -/
  idle : a = none → G' = G ∧ U = ∅ ∧ ∀ t ∈ T, ¬ G.Todo t
  /-- The point acted at is the least-index treatment point with something to do; the support is within `2` of it. -/
  least : ∀ t b, a = some (t, b) → t ∈ T ∧ G.Todo t ∧ (∀ t' ∈ T, G.Todo t' → f t ≤ f t') ∧ U ⊆ closedBall t 2
  /-- A vertex step lowers its point's potential. -/
  vert : ∀ t, a = some (t, true) → G'.pot t < G.pot t
  /-- An arc step lowers its point's bad count. -/
  arc : ∀ t, a = some (t, false) → G'.badCount t < G.badCount t
  /-- A treatment point's bad count rises only when it loses a colour or at a vertex step within `4` of it. -/
  bad_le : ∀ x ∈ T, G'.badCount x ≤ G.badCount x ∨ G'.coloursAt x ≠ G.coloursAt x ∨ ∃ t, a = some (t, true) ∧ dist x t ≤ 4

/-- A ring arc is compact. -/
theorem isCompact_ringArc (p : ℂ) (θ₁ θ₂ : ℝ) : IsCompact (ringArc p θ₁ θ₂) :=
  isCompact_Icc.image (continuous_const.add continuous_e)

/-- A point of the closed `ε`-neighbourhood of a ring arc about `p` is at distance between `1 − ε` and `1 + ε` from `p`. -/
theorem dist_of_mem_cthickening_ringArc {p z : ℂ} {θ₁ θ₂ ε : ℝ} (hε : 0 ≤ ε) (hz : z ∈ cthickening ε (ringArc p θ₁ θ₂)) :
    1 - ε ≤ dist z p ∧ dist z p ≤ 1 + ε := by
  rw [(isCompact_ringArc p θ₁ θ₂).cthickening_eq_biUnion_closedBall hε] at hz
  obtain ⟨_, ⟨θ, -, rfl⟩, hzy⟩ := mem_iUnion₂.mp hz
  rw [mem_closedBall] at hzy
  have h1 := dist_triangle z (ringPt p θ) p
  have h2 := dist_triangle (ringPt p θ) z p
  rw [dist_ringPt] at h1 h2
  rw [dist_comm (ringPt p θ) z] at h2
  exact ⟨by linarith, by linarith⟩

/-- **The procedure's step exists**: at the least-index treatment point with something to do, a vertex step if a move is
available (`exists_vertexStep`, its radius below the distance to every other treatment point), else an arc step at a bad maximal
arc (`exists_arcStep`; its sides are not both at the centre, `mergeAvailable_of_bothKind`); idle if nothing is left. -/
theorem exists_procStep (hP : F.IsPlaneMap) (hc : F.IsClean) (f : ℂ → ℕ) {G : ArcMap k} (hG : ProcInv F G) :
    ∃ G' U a, ProcInv F G' ∧ ProcStep F.treatPts f G G' U a := by
  classical
  have hGd : ∀ x, x ∈ G.dom := fun x => by rw [hG.plane]; trivial
  have hT : ∀ K, IsCompact K → (K ∩ F.treatPts).Finite := fun K hK =>
    treatPts_inter_finite hP hc hK (by rw [hP]; exact subset_univ _)
  by_cases hex : ∃ t ∈ F.treatPts, G.Todo t
  swap
  · push Not at hex
    exact ⟨G, ∅, none, hG, ⟨LocalStep.refl G ∅, isCompact_empty, fun _ _ => le_rfl, fun _ _ => subset_rfl,
      fun _ => ⟨rfl, rfl, hex⟩, fun _ _ h => absurd h (by simp), fun _ h => absurd h (by simp), fun _ h => absurd h (by simp),
      fun _ _ => Or.inl le_rfl⟩⟩
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
      exists_vertexStep' hG.valid hG.clean (hGd t) hmv hdeg hhorn hδ0
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
      exists_arcStep' hG.valid hG.clean hmax hQ hR hnb hT (show (0 : ℝ) < 1 / 2 by norm_num)
    have hUc : IsClosed (cthickening ε (ringArc t θ₁ θ₂)) := isClosed_cthickening
    have htU : t ∉ cthickening ε (ringArc t θ₁ θ₂) := fun h => by
      have := (dist_of_mem_cthickening_ringArc hε0.le h).1
      rw [dist_self] at this; linarith
    refine ⟨G', cthickening ε (ringArc t θ₁ θ₂), some (t, false), ⟨hV, hC, ?_, hG.modif.trans hmod,
      fun x hx => hG.sites x (hsites x hx)⟩,
      ⟨hstep, (isCompact_ringArc t θ₁ θ₂).cthickening, ?_, ?_, fun h => absurd h (by simp), ?_, fun _ h => absurd h (by simp), ?_, ?_⟩⟩
    · show G'.dom = univ
      rw [← hstep.agreesOff.1]; exact hG.plane
    · intro x _
      obtain ⟨mx, -, hmx⟩ := exists_hasDegree_of_mem_dom (hGd x)
      obtain ⟨jx, hjx⟩ := exists_hasHornCount (hGd x)
      obtain ⟨j', hj', hjx'⟩ := hhorns x jx hjx
      rw [pot_eq (hdegs x mx hmx) hjx', pot_eq hmx hjx]
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

/-! ## A run of the procedure -/

/-- **A run of the procedure** from `F`: the stages, the supports, the points acted at. -/
structure ProcRun (F : ArcMap k) (f : ℂ → ℕ) where
  /-- The stages. -/
  G : ℕ → ArcMap k
  /-- The supports. -/
  U : ℕ → Set ℂ
  /-- The point acted at after stage `n`, and whether by a vertex step. -/
  a : ℕ → Option (ℂ × Bool)
  /-- Every stage satisfies the invariant. -/
  inv : ∀ n, ProcInv F (G n)
  /-- Every step is a step of the procedure. -/
  spec : ∀ n, ProcStep F.treatPts f (G n) (G (n + 1)) (U n) (a n)

namespace ProcRun

variable {f : ℂ → ℕ} (R : ProcRun F f)

/-- A treatment point is the centre of finitely many vertex steps (each lowers its potential, which never rises). -/
theorem finite_vert {x : ℂ} (hx : x ∈ F.treatPts) : {n | R.a n = some (x, true)}.Finite := by
  refine (finite_strict_of_antitone_off (fun n => (R.G n).pot x) finite_empty
    fun n _ => (R.spec n).pot_le x hx).subset ?_
  intro n hn
  exact (R.spec n).vert x hn

/-- A treatment point's colours change at finitely many stages (they only shrink). -/
theorem finite_colChange {x : ℂ} (hx : x ∈ F.treatPts) :
    {n | (R.G (n + 1)).coloursAt x ≠ (R.G n).coloursAt x}.Finite := by
  refine (finite_strict_of_antitone_off (fun n => ((R.G n).coloursAt x).ncard) finite_empty
    fun n _ => ncard_le_ncard ((R.spec n).col_sub x hx) (toFinite _)).subset ?_
  intro n hn
  exact ncard_lt_ncard (ssubset_of_subset_of_ne ((R.spec n).col_sub x hx) hn) (toFinite _)

/-- A treatment point is the centre of finitely many arc steps: each lowers its bad count, which rises only at the finitely
many stages where it loses a colour or a vertex step acts within `4` of it. -/
theorem finite_arc (hP : F.IsPlaneMap) (hc : F.IsClean) {x : ℂ} (hx : x ∈ F.treatPts) :
    {n | R.a n = some (x, false)}.Finite := by
  have hnear : (closedBall x 4 ∩ F.treatPts).Finite :=
    treatPts_inter_finite hP hc (isCompact_closedBall x 4) (by rw [hP]; exact subset_univ _)
  have hRfin : ({n | (R.G (n + 1)).coloursAt x ≠ (R.G n).coloursAt x} ∪
      ⋃ t ∈ closedBall x 4 ∩ F.treatPts, {n | R.a n = some (t, true)}).Finite :=
    (R.finite_colChange hx).union (hnear.biUnion fun t ht => R.finite_vert ht.2)
  have hfinite : ∀ n, (R.G n).badCount x ≠ ⊤ := fun n =>
    (badCount_lt_top (R.inv n).valid (R.inv n).plane x).ne
  refine (finite_strict_of_antitone_off (fun n => ((R.G n).badCount x).toNat) hRfin fun n hn => ?_).subset ?_
  · rcases (R.spec n).bad_le x hx with h | h | ⟨t, ht, hd⟩
    · exact ENat.toNat_le_toNat h (hfinite n)
    · exact absurd (Or.inl h) hn
    · refine absurd (Or.inr ?_) hn
      have htT := ((R.spec n).least t true ht).1
      exact mem_biUnion (show t ∈ closedBall x 4 ∩ F.treatPts from
        ⟨by rw [mem_closedBall, dist_comm]; exact hd, htT⟩) ht
  · intro n hn
    have hlt := (R.spec n).arc x hn
    obtain ⟨b, hb⟩ := ENat.ne_top_iff_exists.mp (hfinite n)
    obtain ⟨b', hb'⟩ := ENat.ne_top_iff_exists.mp (hfinite (n + 1))
    show ((R.G (n + 1)).badCount x).toNat < ((R.G n).badCount x).toNat
    rw [← hb, ← hb'] at hlt ⊢
    simpa using hlt

/-- **Each treatment point is acted at finitely often** (FS110-N4-TERM's count, with FS131-E6's potential). -/
theorem finite_acted (hP : F.IsPlaneMap) (hc : F.IsClean) {x : ℂ} (hx : x ∈ F.treatPts) :
    {n | ∃ b, R.a n = some (x, b)}.Finite := by
  refine ((R.finite_vert hx).union (R.finite_arc hP hc hx)).subset ?_
  rintro n ⟨b, hb⟩
  cases b
  · exact Or.inr hb
  · exact Or.inl hb

/-- **The supports are locally finite**: a support meeting `B(x, 1)` belongs to a step at a treatment point within `3` of `x`. -/
theorem locallyFinite (hP : F.IsPlaneMap) (hc : F.IsClean) : LocallyFinite R.U := by
  intro x
  refine ⟨ball x 1, ball_mem_nhds x one_pos, ?_⟩
  have hnear : (closedBall x 3 ∩ F.treatPts).Finite :=
    treatPts_inter_finite hP hc (isCompact_closedBall x 3) (by rw [hP]; exact subset_univ _)
  refine (hnear.biUnion fun t ht => R.finite_acted hP hc ht.2).subset ?_
  rintro n ⟨z, hzU, hzb⟩
  rcases h : R.a n with _ | ⟨t, b⟩
  · rw [((R.spec n).idle h).2.1] at hzU; exact absurd hzU (notMem_empty z)
  · obtain ⟨htT, -, -, hsub⟩ := (R.spec n).least t b h
    have hz2 := hsub hzU
    refine mem_biUnion (show t ∈ closedBall x 3 ∩ F.treatPts from ⟨?_, htT⟩) ⟨b, h⟩
    rw [mem_closedBall] at hz2 ⊢
    rw [mem_ball] at hzb
    have := dist_triangle t z x
    rw [dist_comm t z] at this
    linarith

/-- **Fairness**: at every point, from some stage on, nothing is left to do — past the finitely many stages acting at the
treatment points of index at most its own, a point with something to do would be the least-index choice. -/
theorem eventually_not_todo (hP : F.IsPlaneMap) (hc : F.IsClean) (hf : InjOn f F.treatPts) (v : ℂ) :
    ∀ᶠ n in atTop, ¬ (R.G n).Todo v := by
  by_cases hv : v ∈ F.treatPts
  swap
  · exact Eventually.of_forall fun n h => hv ((R.inv n).mem_treatPts_of_todo h)
  have hJ : {t | t ∈ F.treatPts ∧ f t ≤ f v}.Finite := by
    refine Set.Finite.of_finite_image ((finite_le_nat (f v)).subset ?_) (hf.mono fun t ht => ht.1)
    rintro _ ⟨t, ht, rfl⟩; exact ht.2
  have hfin : (⋃ t ∈ {t | t ∈ F.treatPts ∧ f t ≤ f v}, {n | ∃ b, R.a n = some (t, b)}).Finite :=
    hJ.biUnion fun t ht => R.finite_acted hP hc ht.1
  obtain ⟨N, hN⟩ := hfin.bddAbove
  filter_upwards [eventually_gt_atTop N] with n hn htodo
  rcases h : R.a n with _ | ⟨t, b⟩
  · exact ((R.spec n).idle h).2.2 v hv htodo
  · obtain ⟨htT, -, hmin, -⟩ := (R.spec n).least t b h
    have : n ≤ N := hN (mem_biUnion (show t ∈ {t | t ∈ F.treatPts ∧ f t ≤ f v} from
      ⟨htT, hmin v hv htodo⟩) ⟨b, h⟩)
    omega

end ProcRun

theorem exists_terminalSeq' (hF : F.Valid) (hP : F.IsPlaneMap) (hc : F.IsClean) :
    ∃ S : LocalSeq k, S.F 0 = F ∧ (∀ n, (S.F n).Valid ∧ F.IsModification (S.F n)) ∧
      ∀ v, ∀ᶠ n in atTop, ¬ (S.F n).MergeAvailable v ∧ ¬ (S.F n).RayAvailable v ∧ ¬ (S.F n).ShaveAvailable v ∧
        ∀ θ₁ θ₂ c c', (S.F n).IsRingArc v θ₁ θ₂ c c' → (S.F n).IsQArc v θ₁ θ₂ ∨ (S.F n).IsR2Arc v θ₁ θ₂ := by
  classical
  -- an injective index on the treatment points
  have hcount : F.treatPts.Countable := by
    have : F.treatPts = ⋃ n : ℕ, closedBall (0 : ℂ) n ∩ F.treatPts := by
      ext z
      simp only [mem_iUnion, mem_inter_iff, mem_closedBall, dist_zero_right]
      exact ⟨fun hz => ⟨⌈‖z‖⌉₊, Nat.le_ceil _, hz⟩, fun ⟨_, _, hz⟩ => hz⟩
    rw [this]
    exact countable_iUnion fun n =>
      (treatPts_inter_finite hP hc (isCompact_closedBall 0 n) (by rw [hP]; exact subset_univ _)).countable
  obtain ⟨f, hf⟩ := Set.countable_iff_exists_injOn.mp hcount
  have hInv0 : ProcInv F F := ⟨hF, hc, hP, IsModification.refl F, fun x hx => Or.inl hx⟩
  haveI : Nonempty (ArcMap k) := ⟨F⟩
  choose! nG nU na hn using fun (G : ArcMap k) (hG : ProcInv F G) => exists_procStep hP hc f hG
  let Gs : ℕ → ArcMap k := fun n => nG^[n] F
  have hInv : ∀ n, ProcInv F (Gs n) := by
    intro n
    induction n with
    | zero => exact hInv0
    | succ n ih =>
      show ProcInv F (nG^[n + 1] F)
      rw [Function.iterate_succ_apply']
      exact (hn _ ih).1
  have hSpec : ∀ n, ProcStep F.treatPts f (Gs n) (Gs (n + 1)) (nU (Gs n)) (na (Gs n)) := by
    intro n
    show ProcStep F.treatPts f (Gs n) (nG^[n + 1] F) _ _
    rw [Function.iterate_succ_apply']
    exact (hn _ (hInv n)).2
  let R : ProcRun F f := ⟨Gs, fun n => nU (Gs n), fun n => na (Gs n), hInv, hSpec⟩
  refine ⟨⟨Gs, R.U, fun n => (hSpec n).step, fun n => (hSpec n).isCompact, R.locallyFinite hP hc⟩, rfl,
    fun n => ⟨(hInv n).valid, (hInv n).modif⟩, fun v => ?_⟩
  filter_upwards [R.eventually_not_todo hP hc hf v] with n hn
  have hnm : ¬ (Gs n).MoveAt v := fun h => hn (Or.inl h)
  refine ⟨fun h => hnm (Or.inl h), fun h => hnm (Or.inr (Or.inl h)), fun h => hnm (Or.inr (Or.inr h)), ?_⟩
  have hb : (Gs n).badCount v = 0 := by
    by_contra hb
    exact hn (Or.inr hb)
  exact (badCount_eq_zero_iff (hInv n).valid (hInv n).plane v).mp hb

end ArcMap

end HadwigerNelson.Plane
