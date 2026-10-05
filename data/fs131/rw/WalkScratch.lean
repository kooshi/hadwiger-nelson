import Proofs.HadwigerNelson.Plane.ValidMap.MapGraph

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

/-! ### WALK's C5b–C5d, pure (FS131-RW2): the port graph of a compact set of curve stars -/

/-- **The radial piece of a ray** (FS131-RW2, WALK's C5c): a ray `f` from `v`, a continuous graph over the distance from `v` out to `r`, cut at
`ρ < r` and closed by `v`, is compact and connected, lies in `B̄(v, ρ)`, and has `v` in the closure of its punctured part. -/
theorem ray_piece {f : ℝ → ℂ} {v : ℂ} {r ρ : ℝ} (hρ : 0 < ρ) (hρr : ρ < r) (hfc : ContinuousOn f (Ioo 0 r))
    (hfn : ∀ s ∈ Ioo 0 r, ‖f s - v‖ = s) :
    IsCompact (insert v (f '' Ioc 0 ρ)) ∧ IsPreconnected (insert v (f '' Ioc 0 ρ)) ∧ IsPreconnected (f '' Ioc 0 ρ) ∧
      v ∉ f '' Ioc 0 ρ ∧ insert v (f '' Ioc 0 ρ) ⊆ closedBall v ρ ∧ v ∈ closure (f '' Ioc 0 ρ) := by
  have hIoc : Ioc 0 ρ ⊆ Ioo 0 r := fun s hs => ⟨hs.1, hs.2.trans_lt hρr⟩
  set g : ℝ → ℂ := fun s => if s = 0 then v else f s with hg
  have himg : insert v (f '' Ioc 0 ρ) = g '' Icc 0 ρ := by
    ext w
    constructor
    · rintro (rfl | ⟨s, hs, rfl⟩)
      · exact ⟨0, ⟨le_rfl, hρ.le⟩, by simp [hg]⟩
      · exact ⟨s, Ioc_subset_Icc_self hs, by simp [hg, hs.1.ne']⟩
    · rintro ⟨s, hs, rfl⟩
      rcases eq_or_lt_of_le hs.1 with h | h
      · left; simp [hg, ← h]
      · right; exact ⟨s, ⟨h, hs.2⟩, by simp [hg, h.ne']⟩
  have hgc : ContinuousOn g (Icc 0 ρ) := by
    intro s hs
    rcases eq_or_lt_of_le hs.1 with h | h
    · subst h
      rw [Metric.continuousWithinAt_iff]
      intro ε hε
      refine ⟨ε, hε, fun t ht hdt => ?_⟩
      by_cases ht0 : t = 0
      · simp [hg, ht0, hε]
      · have htpos : 0 < t := lt_of_le_of_ne ht.1 (Ne.symm ht0)
        simp only [hg, ht0, if_false, if_true, dist_eq_norm]
        rw [hfn t (hIoc ⟨htpos, ht.2⟩)]
        rw [Real.dist_eq, sub_zero, abs_of_pos htpos] at hdt
        exact hdt
    · have hca : ContinuousAt f s := hfc.continuousAt (Ioo_mem_nhds h (hs.2.trans_lt hρr))
      have heq : g =ᶠ[𝓝 s] f := by
        filter_upwards [eventually_ne_nhds h.ne'] with t ht
        simp [hg, ht]
      exact (hca.congr heq.symm).continuousWithinAt
  have hpre : IsPreconnected (f '' Ioc 0 ρ) := isPreconnected_Ioc.image _ (hfc.mono hIoc)
  have hvcl : v ∈ closure (f '' Ioc 0 ρ) := by
    rw [Metric.mem_closure_iff]
    intro δ hδ
    set s := min δ ρ / 2 with hs
    have hs0 : 0 < s := half_pos (lt_min hδ hρ)
    have hsρ : s ≤ ρ := by linarith [min_le_right δ ρ]
    refine ⟨f s, ⟨s, ⟨hs0, hsρ⟩, rfl⟩, ?_⟩
    rw [dist_comm, dist_eq_norm, hfn s (hIoc ⟨hs0, hsρ⟩)]
    linarith [min_le_left δ ρ]
  refine ⟨himg ▸ isCompact_Icc.image_of_continuousOn hgc, himg ▸ isPreconnected_Icc.image _ hgc, hpre, ?_, ?_, hvcl⟩
  · rintro ⟨s, hs, hsv⟩
    have := hfn s (hIoc hs)
    rw [hsv, sub_self, norm_zero] at this
    exact hs.1.ne this
  · rintro w (rfl | ⟨s, hs, rfl⟩)
    · exact mem_closedBall_self hρ.le
    · rw [mem_closedBall, dist_eq_norm, hfn s (hIoc hs)]; exact hs.2

/-- **A curve star is locally connected** (FS131-RW2): near its centre, a set with a curve star is the centre and the rays, each with the centre
in its closure. -/
theorem HasCurveStar.isPreconnected_inter_ball {C : Set ℂ} {z : ℂ} {n : ℕ} (h : HasCurveStar C z n) :
    ∃ r > 0, ∀ ε ∈ Ioc 0 r, IsPreconnected (C ∩ ball z ε) := by
  obtain ⟨r, hr, b, hbc, hbn, -, heq, -⟩ := h
  refine ⟨r, hr, fun ε hε => ?_⟩
  have hsub : Ioo 0 ε ⊆ Ioo 0 r := fun s hs => ⟨hs.1, hs.2.trans_le hε.2⟩
  have heq' : C ∩ ball z ε = insert z (⋃ i, b i '' Ioo 0 ε) := by
    have hb : ball z ε ⊆ ball z r := ball_subset_ball hε.2
    ext w
    constructor
    · rintro ⟨hwC, hwb⟩
      have : w ∈ C ∩ ball z r := ⟨hwC, hb hwb⟩
      rw [heq] at this
      rcases this with rfl | hw
      · exact Or.inl rfl
      · obtain ⟨i, s, hs, rfl⟩ := mem_iUnion.mp hw
        refine Or.inr (mem_iUnion.mpr ⟨i, s, ⟨hs.1, ?_⟩, rfl⟩)
        rw [mem_ball, dist_eq_norm, hbn i s hs] at hwb; exact hwb
    · rintro (rfl | hw)
      · have : w ∈ insert w (⋃ i, b i '' Ioo 0 r) := Or.inl rfl
        rw [← heq] at this
        exact ⟨this.1, mem_ball_self hε.1⟩
      · obtain ⟨i, s, hs, rfl⟩ := mem_iUnion.mp hw
        have : b i s ∈ insert z (⋃ i, b i '' Ioo 0 r) := Or.inr (mem_iUnion.mpr ⟨i, s, hsub hs, rfl⟩)
        rw [← heq] at this
        refine ⟨this.1, ?_⟩
        rw [mem_ball, dist_eq_norm, hbn i s (hsub hs)]; exact hs.2
  rw [heq']
  have hray : ∀ i, IsPreconnected (insert z (b i '' Ioo 0 ε)) := by
    intro i
    have hpre : IsPreconnected (b i '' Ioo 0 ε) := isPreconnected_Ioo.image _ ((hbc i).mono hsub)
    refine hpre.subset_closure (subset_insert _ _) (insert_subset_iff.mpr ⟨?_, subset_closure⟩)
    rw [Metric.mem_closure_iff]
    intro δ hδ
    set s := min δ ε / 2 with hs
    have hs0 : 0 < s := half_pos (lt_min hδ hε.1)
    have hsε : s < ε := by linarith [min_le_right δ ε]
    refine ⟨b i s, ⟨s, ⟨hs0, hsε⟩, rfl⟩, ?_⟩
    rw [dist_comm, dist_eq_norm, hbn i s (hsub ⟨hs0, hsε⟩)]
    linarith [min_le_left δ ε]
  refine isPreconnected_of_forall z fun w hw => ?_
  rcases hw with rfl | hw
  · exact ⟨{w}, singleton_subset_iff.mpr (Or.inl rfl), rfl, rfl, isPreconnected_singleton⟩
  · obtain ⟨i, hi⟩ := mem_iUnion.mp hw
    exact ⟨insert z (b i '' Ioo 0 ε), insert_subset_insert (subset_iUnion (fun i => b i '' Ioo 0 ε) i), Or.inl rfl,
      Or.inr hi, hray i⟩

/-- **The part of an arc inside a small disc about one of its interior points is one open interval of parameters** (FS131-RW2, WALK's C5d):
for `γ` injective on `[a, b]`, `p = γ t₀` with `a < t₀ < b`, a disc `B(p, ε)` missing both ends, and the arc's points in the disc connected,
the parameters in the disc are `(c₁, c₂)` with `a < c₁ < t₀ < c₂ < b`, and `γ c₁`, `γ c₂` lie on the circle. (A gap `t` between two
parameters in the disc would split those points by the closed arcs `γ '' [a, t]`, `γ '' [t, b]`, which meet only at `γ t`.) -/
theorem exists_Ioo_of_preimage_ball {γ : ℝ → ℂ} {a b t₀ ε : ℝ} {p : ℂ} (hγ : Continuous γ) (hinj : InjOn γ (Icc a b))
    (ht₀ : t₀ ∈ Ioo a b) (hp : γ t₀ = p) (hε : 0 < ε) (ha : ε < dist (γ a) p) (hb : ε < dist (γ b) p)
    (hpre : IsPreconnected (γ '' Icc a b ∩ ball p ε)) :
    ∃ c₁ c₂, a < c₁ ∧ c₁ < t₀ ∧ t₀ < c₂ ∧ c₂ < b ∧ (∀ t ∈ Icc a b, γ t ∈ ball p ε ↔ t ∈ Ioo c₁ c₂) ∧
      dist (γ c₁) p = ε ∧ dist (γ c₂) p = ε := by
  set I := {t | t ∈ Icc a b ∧ γ t ∈ ball p ε} with hI
  have hopen : IsOpen (γ ⁻¹' ball p ε) := isOpen_ball.preimage hγ
  have ht₀I : t₀ ∈ I := ⟨Ioo_subset_Icc_self ht₀, by rw [hp]; exact mem_ball_self hε⟩
  -- `I` is an interval
  have hord : ∀ t₁ ∈ I, ∀ t₂ ∈ I, ∀ t, t₁ ≤ t → t ≤ t₂ → t ∈ I := by
    intro t₁ ht₁ t₂ ht₂ t h1 h2
    have htab : t ∈ Icc a b := ⟨ht₁.1.1.trans h1, h2.trans ht₂.1.2⟩
    refine ⟨htab, ?_⟩
    by_contra hout
    have hA : IsClosed (γ '' Icc a t) := (isCompact_Icc.image hγ).isClosed
    have hB : IsClosed (γ '' Icc t b) := (isCompact_Icc.image hγ).isClosed
    obtain ⟨w, ⟨hwS, hwb⟩, hwA, hwB⟩ := (isPreconnected_closed_iff.mp hpre) _ _ hA hB
      (by
        rintro w ⟨⟨s, hs, rfl⟩, -⟩
        rcases le_total s t with h | h
        · exact Or.inl ⟨s, ⟨hs.1, h⟩, rfl⟩
        · exact Or.inr ⟨s, ⟨h, hs.2⟩, rfl⟩)
      ⟨γ t₁, ⟨⟨t₁, ht₁.1, rfl⟩, ht₁.2⟩, t₁, ⟨ht₁.1.1, h1⟩, rfl⟩ ⟨γ t₂, ⟨⟨t₂, ht₂.1, rfl⟩, ht₂.2⟩, t₂, ⟨h2, ht₂.1.2⟩, rfl⟩
    obtain ⟨s, hs, rfl⟩ := hwA
    obtain ⟨s', hs', hss'⟩ := hwB
    have h1' := hinj ⟨hs'.1.trans' htab.1, hs'.2⟩ ⟨hs.1, hs.2.trans htab.2⟩ hss'
    have hst : s = t := le_antisymm hs.2 (h1' ▸ hs'.1)
    exact hout (hst ▸ hwb)
  -- `I` is open near each of its points
  have hloc : ∀ t ∈ I, ∃ δ > 0, ∀ t' ∈ Icc a b, |t' - t| < δ → t' ∈ I := by
    intro t ht
    obtain ⟨δ, hδ, hδb⟩ := Metric.isOpen_iff.mp hopen t ht.2
    exact ⟨δ, hδ, fun t' ht' hd => ⟨ht', hδb (by rw [mem_ball, Real.dist_eq]; exact hd)⟩⟩
  -- near the ends, `γ` stays off the closed disc
  have hfar : ∀ s ∈ Icc a b, ε < dist (γ s) p → ∃ δ > 0, ∀ t, |t - s| < δ → ε < dist (γ t) p := by
    intro s _ hs
    have hc : ContinuousAt (fun t => dist (γ t) p) s := (hγ.dist continuous_const).continuousAt
    obtain ⟨δ, hδ, hδc⟩ := Metric.continuousAt_iff.mp hc (dist (γ s) p - ε) (by linarith)
    refine ⟨δ, hδ, fun t ht => ?_⟩
    have := hδc (show dist t s < δ by rw [Real.dist_eq]; exact ht)
    rw [Real.dist_eq] at this
    linarith [(abs_lt.mp this).1]
  have hbdd : BddBelow I := ⟨a, fun t ht => ht.1.1⟩
  have hbdd' : BddAbove I := ⟨b, fun t ht => ht.1.2⟩
  have hIne : I.Nonempty := ⟨t₀, ht₀I⟩
  set c₁ := sInf I with hc₁
  set c₂ := sSup I with hc₂
  have hdown : ∀ t ∈ I, a < t → ∃ t' ∈ I, t' < t := by
    intro t ht hat
    obtain ⟨δ, hδ, hδI⟩ := hloc t ht
    have hm : 0 < min δ (t - a) := lt_min hδ (sub_pos.mpr hat)
    have hm1 : min δ (t - a) ≤ δ := min_le_left _ _
    have hm2 : min δ (t - a) ≤ t - a := min_le_right _ _
    refine ⟨t - min δ (t - a) / 2, hδI _ ⟨by linarith, by linarith [ht.1.2]⟩ ?_, by linarith⟩
    rw [abs_lt]; constructor <;> linarith
  have hup : ∀ t ∈ I, t < b → ∃ t' ∈ I, t < t' := by
    intro t ht htb
    obtain ⟨δ, hδ, hδI⟩ := hloc t ht
    have hm : 0 < min δ (b - t) := lt_min hδ (sub_pos.mpr htb)
    have hm1 : min δ (b - t) ≤ δ := min_le_left _ _
    have hm2 : min δ (b - t) ≤ b - t := min_le_right _ _
    refine ⟨t + min δ (b - t) / 2, hδI _ ⟨by linarith [ht.1.1], by linarith⟩ ?_, by linarith⟩
    rw [abs_lt]; constructor <;> linarith
  have hc₁t : c₁ < t₀ := by
    obtain ⟨t', ht', hlt⟩ := hdown t₀ ht₀I ht₀.1
    exact (csInf_le hbdd ht').trans_lt hlt
  have hc₂t : t₀ < c₂ := by
    obtain ⟨t', ht', hlt⟩ := hup t₀ ht₀I ht₀.2
    exact hlt.trans_le (le_csSup hbdd' ht')
  have hac₁ : a < c₁ := by
    obtain ⟨δ, hδ, hδf⟩ := hfar a ⟨le_rfl, (ht₀.1.trans ht₀.2).le⟩ ha
    have : a + δ / 2 ≤ c₁ := le_csInf hIne fun t ht => by
      by_contra h
      push Not at h
      have := hδf t (by rw [abs_lt]; constructor <;> linarith [ht.1.1])
      exact absurd ht.2 (by rw [mem_ball]; linarith)
    linarith
  have hc₂b : c₂ < b := by
    obtain ⟨δ, hδ, hδf⟩ := hfar b ⟨(ht₀.1.trans ht₀.2).le, le_rfl⟩ hb
    have : c₂ ≤ b - δ / 2 := csSup_le hIne fun t ht => by
      by_contra h
      push Not at h
      have := hδf t (by rw [abs_lt]; constructor <;> linarith [ht.1.2])
      exact absurd ht.2 (by rw [mem_ball]; linarith)
    linarith
  have hiff : ∀ t ∈ Icc a b, γ t ∈ ball p ε ↔ t ∈ Ioo c₁ c₂ := by
    intro t ht
    constructor
    · intro htb
      have htI : t ∈ I := ⟨ht, htb⟩
      have h1 : c₁ ≤ t := csInf_le hbdd htI
      have h2 : t ≤ c₂ := le_csSup hbdd' htI
      refine ⟨lt_of_le_of_ne h1 fun h => ?_, lt_of_le_of_ne h2 fun h => ?_⟩
      · obtain ⟨t', ht', hlt⟩ := hdown t htI (h ▸ hac₁)
        have := csInf_le hbdd ht'
        linarith
      · obtain ⟨t', ht', hlt⟩ := hup t htI (h ▸ hc₂b)
        have := le_csSup hbdd' ht'
        linarith
    · intro hc
      obtain ⟨t₁, ht₁I, ht₁⟩ := (csInf_lt_iff hbdd hIne).mp hc.1
      obtain ⟨t₂, ht₂I, ht₂⟩ := (lt_csSup_iff hbdd' hIne).mp hc.2
      exact (hord t₁ ht₁I t₂ ht₂I t ht₁.le ht₂.le).2
  -- the ends of the interval lie on the circle
  have hcirc : ∀ c ∈ Icc a b, c ∉ Ioo c₁ c₂ → (∀ δ > 0, ∃ t ∈ Ioo c₁ c₂, |t - c| < δ) → dist (γ c) p = ε := by
    intro c hc hcn happ
    have h1 : ε ≤ dist (γ c) p := by
      by_contra h
      push Not at h
      exact hcn ((hiff c hc).mp (mem_ball.mpr h))
    refine le_antisymm ?_ h1
    by_contra h
    push Not at h
    obtain ⟨δ, hδ, hδf⟩ := hfar c hc h
    obtain ⟨t, ht, htc⟩ := happ δ hδ
    have htab : t ∈ Icc a b := ⟨hac₁.le.trans ht.1.le, ht.2.le.trans hc₂b.le⟩
    have := (hiff t htab).mpr ht
    rw [mem_ball] at this
    linarith [hδf t htc]
  have hc₁₂ : 0 < c₂ - c₁ := sub_pos.mpr (hc₁t.trans hc₂t)
  refine ⟨c₁, c₂, hac₁, hc₁t, hc₂t, hc₂b, hiff, ?_, ?_⟩
  · refine hcirc c₁ ⟨hac₁.le, (hc₁t.trans hc₂t).le.trans hc₂b.le⟩ (fun h => lt_irrefl _ h.1) fun δ hδ => ?_
    have hm : 0 < min δ (c₂ - c₁) := lt_min hδ hc₁₂
    have hm1 : min δ (c₂ - c₁) ≤ δ := min_le_left _ _
    have hm2 : min δ (c₂ - c₁) ≤ c₂ - c₁ := min_le_right _ _
    refine ⟨c₁ + min δ (c₂ - c₁) / 2, ⟨by linarith, by linarith⟩, ?_⟩
    rw [abs_lt]; constructor <;> linarith
  · refine hcirc c₂ ⟨hac₁.le.trans (hc₁t.trans hc₂t).le, hc₂b.le⟩ (fun h => lt_irrefl _ h.2) fun δ hδ => ?_
    have hm : 0 < min δ (c₂ - c₁) := lt_min hδ hc₁₂
    have hm1 : min δ (c₂ - c₁) ≤ δ := min_le_left _ _
    have hm2 : min δ (c₂ - c₁) ≤ c₂ - c₁ := min_le_right _ _
    refine ⟨c₂ - min δ (c₂ - c₁) / 2, ⟨by linarith, by linarith⟩, ?_⟩
    rw [abs_lt]; constructor <;> linarith

/-- **A port graph on `C` over the vertices `N`** (FS131-RW2, WALK's C5b–C5d): ports `P`, each at a vertex `vtx d ∈ N` and paired with the
other end `σ d` of its edge `E d`; evenly many ports at each vertex, and at least one; each edge closed, in `C`, holding both its end
vertices, connected off `N` and in the closure of that part, meeting `N` only at its ends and another edge only in `N`; the edges cover `C`;
and each edge has a *pure point* `p` off `N`, about which every small disc meets the edge exactly as it meets `C`, misses every other edge,
and cuts the edge into two closed connected pieces, one holding each end and one of two distinct points of the circle. Inhabitant:
`exists_isPortGraph`, on every compact connected set with an even curve star at each point and a vertex set (so at `∂ cl x̂` of every outer
tile of every valid plane map, `exists_boundaryWalk`'s construction). -/
structure IsPortGraph (C : Set ℂ) (N P : Finset ℂ) (vtx σ : ℂ → ℂ) (E : ℂ → Set ℂ) : Prop where
  vtx_mem : ∀ d ∈ P, vtx d ∈ N
  σ_mem : ∀ d ∈ P, σ d ∈ P
  σ_σ : ∀ d ∈ P, σ (σ d) = d
  σ_ne : ∀ d ∈ P, σ d ≠ d
  even : ∀ v ∈ N, Even (P.filter fun d => vtx d = v).card
  exists_port : ∀ v ∈ N, ∃ d ∈ P, vtx d = v
  isClosed : ∀ d ∈ P, IsClosed (E d)
  isPreconnected_diff : ∀ d ∈ P, IsPreconnected (E d \ (N : Set ℂ))
  subset : ∀ d ∈ P, E d ⊆ C
  subset_closure : ∀ d ∈ P, E d ⊆ closure (E d \ (N : Set ℂ))
  st_mem : ∀ d ∈ P, vtx d ∈ E d
  en_mem : ∀ d ∈ P, vtx (σ d) ∈ E d
  E_σ : ∀ d ∈ P, E (σ d) = E d
  mem_N : ∀ d ∈ P, ∀ v ∈ N, v ∈ E d → v = vtx d ∨ v = vtx (σ d)
  inter : ∀ d ∈ P, ∀ e ∈ P, e ≠ d → e ≠ σ d → E d ∩ E e ⊆ (N : Set ℂ)
  cover : ∀ z ∈ C, ∃ d ∈ P, z ∈ E d
  pure : ∀ d ∈ P, ∃ p ∈ E d, p ∉ N ∧ ∃ ε₀ > 0, ∀ ε ∈ Ioo 0 ε₀, E d ∩ ball p ε = C ∩ ball p ε ∧
    (∀ e ∈ P, e ≠ d → e ≠ σ d → Disjoint (E e) (closedBall p ε)) ∧
    ∃ E₁ E₂ : Set ℂ, ∃ q₁ q₂ : ℂ, E d \ ball p ε = E₁ ∪ E₂ ∧ IsClosed E₁ ∧ IsPreconnected E₁ ∧ IsClosed E₂ ∧
      IsPreconnected E₂ ∧ vtx d ∈ E₁ ∧ vtx (σ d) ∈ E₂ ∧ q₁ ∈ E₁ ∧ q₂ ∈ E₂ ∧ q₁ ≠ q₂ ∧ dist q₁ p = ε ∧ dist q₂ p = ε

/-- **WALK's C7: the edges of a port graph on a connected set are connected through shared vertices** (FS131-RW2): a set of ports closed
under `σ`, neither empty nor all, shares a vertex with its complement — else the edges of the two sides would be disjoint closed sets covering
`C` (two edges meet only at their end vertices). -/
theorem IsPortGraph.exists_shared_vertex {C : Set ℂ} {N P : Finset ℂ} {vtx σ : ℂ → ℂ} {E : ℂ → Set ℂ}
    (h : IsPortGraph C N P vtx σ E) (hC : IsPreconnected C) (S : Finset ℂ) (hSP : S ⊆ P) (hSσ : ∀ d ∈ S, σ d ∈ S)
    (hSne : S.Nonempty) (hout : ∃ d ∈ P, d ∉ S) : ∃ a ∈ S, ∃ b ∈ P, b ∉ S ∧ vtx a = vtx b := by
  classical
  by_contra hno
  push Not at hno
  set A := ⋃ d ∈ S, E d with hA
  set B := ⋃ d ∈ P \ S, E d with hB
  have hAc : IsClosed A := S.finite_toSet.isClosed_biUnion fun d hd => h.isClosed d (hSP hd)
  have hBc : IsClosed B := (P \ S).finite_toSet.isClosed_biUnion fun d hd => h.isClosed d (Finset.mem_sdiff.mp hd).1
  have hσout : ∀ e ∈ P, e ∉ S → σ e ∉ S := fun e he heS hσe => heS (h.σ_σ e he ▸ hSσ _ hσe)
  obtain ⟨w, hwC, hwA, hwB⟩ := (isPreconnected_closed_iff.mp hC) A B hAc hBc
    (fun z hz => by
      obtain ⟨d, hd, hzd⟩ := h.cover z hz
      by_cases hdS : d ∈ S
      · exact Or.inl (mem_iUnion₂.mpr ⟨d, hdS, hzd⟩)
      · exact Or.inr (mem_iUnion₂.mpr ⟨d, Finset.mem_sdiff.mpr ⟨hd, hdS⟩, hzd⟩))
    (by obtain ⟨d, hd⟩ := hSne; exact ⟨vtx d, h.subset d (hSP hd) (h.st_mem d (hSP hd)), mem_iUnion₂.mpr ⟨d, hd, h.st_mem d (hSP hd)⟩⟩)
    (by obtain ⟨d, hd, hdS⟩ := hout; exact ⟨vtx d, h.subset d hd (h.st_mem d hd), mem_iUnion₂.mpr ⟨d, Finset.mem_sdiff.mpr ⟨hd, hdS⟩,
      h.st_mem d hd⟩⟩)
  obtain ⟨d, hdS, hwd⟩ := mem_iUnion₂.mp hwA
  obtain ⟨e, heP, hwe⟩ := mem_iUnion₂.mp hwB
  obtain ⟨he, heS⟩ := Finset.mem_sdiff.mp heP
  have hd := hSP hdS
  have hed : e ≠ d := fun h' => heS (h' ▸ hdS)
  have heσ : e ≠ σ d := fun h' => heS (h' ▸ hSσ d hdS)
  have hwN : w ∈ (N : Set ℂ) := h.inter d hd e he hed heσ ⟨hwd, hwe⟩
  rcases h.mem_N d hd w hwN hwd with h1 | h1 <;> rcases h.mem_N e he w hwN hwe with h2 | h2
  · exact hno d hdS e he heS (h1.symm.trans h2)
  · exact hno d hdS (σ e) (h.σ_mem e he) (hσout e he heS) (h1.symm.trans h2)
  · exact hno (σ d) (hSσ d hdS) e he heS (h1.symm.trans h2)
  · exact hno (σ d) (hSσ d hdS) (σ e) (h.σ_mem e he) (hσout e he heS) (h1.symm.trans h2)

/-- **WALK's C5b–C5d: a compact connected set of even curve stars has a port graph over any finite vertex set holding its non-regular points**
(FS131-RW2). The vertices `N` are cut out by discs of a radius `ρ` below every star's radius and half their distances; the ports are the
rays' points at `ρ`; `σ` pairs the two ends of each arc of what is left (`port_arc`); the edge of a port is its radial piece, its arc, and
the radial piece of its partner. Two edges meet only at vertices (distinct rays at one vertex are disjoint, and an arc holds only its two
ports); each point of `C` is on an edge (a component of what is left with no port would be open and closed in `C`); the pure point of an
edge is its arc's middle, where the arc's parameters in a small disc are one interval (`exists_Ioo_of_preimage_ball`). -/
theorem exists_isPortGraph {C : Set ℂ} (hC : IsCompact C) (hCc : IsPreconnected C) {n : ℂ → ℕ}
    (hn : ∀ z ∈ C, HasCurveStar C z (n z)) (hev : ∀ z ∈ C, Even (n z)) (hpos : ∀ z ∈ C, 0 < n z) {N : Finset ℂ}
    (hN : N.Nonempty) (hNC : ∀ v ∈ N, v ∈ C) (hreg : ∀ z ∈ C, z ∉ N → IsRegularAt C z) :
    ∃ (P : Finset ℂ) (vtx σ : ℂ → ℂ) (E : ℂ → Set ℂ), IsPortGraph C N P vtx σ E := by
  classical
  have hloc : ∀ z ∈ C, ∃ r > 0, ∀ ε ∈ Ioc 0 r, IsPreconnected (C ∩ ball z ε) := fun z hz =>
    HasCurveStar.isPreconnected_inter_ball (hn z hz)
  choose! rl hrl hlocpre using hloc
  choose! r hr b hbc hbn hbd hbeq hbcurve using hn
  -- the radius of the cut
  have hevρ : ∀ᶠ ρ in 𝓝[>] (0 : ℝ), 0 < ρ ∧ (∀ v ∈ N, ρ < r v) ∧ ∀ v ∈ N, ∀ v' ∈ N, v ≠ v' → 2 * ρ < dist v v' := by
    refine (show ∀ᶠ ρ in 𝓝[>] (0 : ℝ), 0 < ρ from self_mem_nhdsWithin).and (((Finset.eventually_all N).mpr fun v hv => ?_).and
      ((Finset.eventually_all N).mpr fun v hv => (Finset.eventually_all N).mpr fun v' hv' => ?_))
    · exact Filter.Eventually.mono (Ioo_mem_nhdsGT (hr v (hNC v hv))) fun ρ h => h.2
    · by_cases hvv : v = v'
      · exact Eventually.of_forall fun _ h => absurd hvv h
      · have hd : 0 < dist v v' := dist_pos.mpr hvv
        exact Filter.Eventually.mono (Ioo_mem_nhdsGT (half_pos hd)) fun ρ h _ => by linarith [h.2]
  obtain ⟨ρ, hρ, hρr, hsep⟩ := hevρ.exists
  set C' := C \ ⋃ v ∈ N, ball v ρ with hC'def
  have hC'c : IsCompact C' := hC.diff (isOpen_biUnion fun v _ => isOpen_ball)
  have hC'C : C' ⊆ C := sdiff_subset
  have hnotball : ∀ z ∈ C', ∀ v ∈ N, ρ ≤ dist z v := fun z hz v hv => by
    by_contra h
    push Not at h
    exact hz.2 (mem_iUnion₂.mpr ⟨v, hv, h⟩)
  have hmemC' : ∀ z ∈ C, (∀ v ∈ N, ρ ≤ dist z v) → z ∈ C' := fun z hz hfar => ⟨hz, fun h => by
    obtain ⟨v, hv, hb⟩ := mem_iUnion₂.mp h
    rw [mem_ball] at hb
    linarith [hfar v hv]⟩
  have hNC' : ∀ v ∈ N, v ∉ C' := fun v hv h => by
    have := hnotball v h v hv
    rw [dist_self] at this
    linarith
  have hreg' : ∀ z ∈ C', IsRegularAt C z := fun z hz => hreg z (hC'C hz) fun h => hNC' z h hz
  have hvuniq : ∀ z, ∀ v ∈ N, ∀ v' ∈ N, dist z v ≤ ρ → dist z v' ≤ ρ → v = v' := by
    intro z v hv v' hv' h1 h2
    by_contra hne
    have := hsep v hv v' hv' hne
    have := dist_triangle v z v'
    rw [dist_comm v z] at this
    linarith
  -- the ports
  set Pf : Finset ℂ := N.biUnion fun v => Finset.univ.image fun i => b v i ρ with hPfdef
  have hρI : ∀ v ∈ N, ρ ∈ Ioo 0 (r v) := fun v hv => ⟨hρ, hρr v hv⟩
  have hport_of : ∀ z ∈ C, ∀ v ∈ N, dist z v = ρ → ∃ i, b v i ρ = z := by
    intro z hz v hv hzv
    have hzb : z ∈ C ∩ ball v (r v) := ⟨hz, by rw [mem_ball, hzv]; exact hρr v hv⟩
    rw [hbeq v (hNC v hv)] at hzb
    rcases hzb with rfl | hzb
    · rw [dist_self] at hzv; exact absurd hzv hρ.ne
    · obtain ⟨i, s, hs, hsz⟩ := mem_iUnion.mp hzb
      have : s = ρ := by rw [← hbn v (hNC v hv) i s hs, hsz, ← dist_eq_norm, hzv]
      exact ⟨i, this ▸ hsz⟩
  have hb_mem : ∀ v ∈ N, ∀ i, b v i ρ ∈ C ∧ dist (b v i ρ) v = ρ := by
    intro v hv i
    have : b v i ρ ∈ insert v (⋃ j, b v j '' Ioo 0 (r v)) := Or.inr (mem_iUnion.mpr ⟨i, ρ, hρI v hv, rfl⟩)
    rw [← hbeq v (hNC v hv)] at this
    exact ⟨this.1, by rw [dist_eq_norm, hbn v (hNC v hv) i ρ (hρI v hv)]⟩
  have hPf : ∀ z, z ∈ (Pf : Set ℂ) ↔ z ∈ C ∧ ∃ v ∈ N, dist z v = ρ := by
    intro z
    simp only [hPfdef, Finset.coe_biUnion, Finset.coe_image, Finset.coe_univ, image_univ, mem_iUnion, mem_range,
      Finset.mem_coe, exists_prop]
    constructor
    · rintro ⟨v, hv, i, rfl⟩
      exact ⟨(hb_mem v hv i).1, v, hv, (hb_mem v hv i).2⟩
    · rintro ⟨hz, v, hv, hzv⟩
      exact ⟨v, hv, hport_of z hz v hv hzv⟩
  have hray : ∀ p ∈ (Pf : Set ℂ), ∃ v ∈ N, ∃ (f : ℝ → ℂ) (r' : ℝ), ρ < r' ∧ ContinuousOn f (Ioo 0 r') ∧
      (∀ s ∈ Ioo 0 r', ‖f s - v‖ = s) ∧ f ρ = p ∧ ∃ ε > 0, C ∩ ball p ε = f '' Ioo 0 r' ∩ ball p ε := by
    intro p hp
    obtain ⟨hpC, v, hv, hpv⟩ := (hPf p).mp hp
    obtain ⟨i, rfl⟩ := hport_of p hpC v hv hpv
    have hvC := hNC v hv
    exact ⟨v, hv, b v i, r v, hρr v hv, hbc v hvC i, hbn v hvC i, rfl,
      star_local_ray (hbc v hvC) (hbn v hvC) (hbd v hvC) (hbeq v hvC) (hρI v hv)⟩
  -- each port's vertex and ray
  have hvi : ∀ d ∈ Pf, ∃ v ∈ N, ∃ g : ℝ → ℂ, (∃ i : Fin (n v), g = b v i) ∧ g ρ = d := by
    intro d hd
    obtain ⟨hdC, v, hv, hdv⟩ := (hPf d).mp hd
    obtain ⟨i, hi⟩ := hport_of d hdC v hv hdv
    exact ⟨v, hv, b v i, ⟨i, rfl⟩, hi⟩
  choose! vtx hvtx f hf hfρ using hvi
  have hray_eq : ∀ v ∈ N, ∀ g g' : ℝ → ℂ, (∃ i : Fin (n v), g = b v i) → (∃ i : Fin (n v), g' = b v i) → g ρ = g' ρ →
      g = g' := by
    rintro v hv g g' ⟨i, rfl⟩ ⟨j, rfl⟩ h
    by_cases hij : i = j
    · rw [hij]
    · exact absurd h (hbd v (hNC v hv) i j hij ρ (hρI v hv))
  have hray_ne : ∀ v ∈ N, ∀ g g' : ℝ → ℂ, (∃ i : Fin (n v), g = b v i) → (∃ i : Fin (n v), g' = b v i) → g ρ ≠ g' ρ →
      ∀ s ∈ Ioo 0 (r v), g s ≠ g' s := by
    rintro v hv g g' ⟨i, rfl⟩ ⟨j, rfl⟩ h s hs
    have hij : i ≠ j := fun hij => h (by rw [hij])
    exact hbd v (hNC v hv) i j hij s hs
  have hray_c : ∀ v ∈ N, ∀ g : ℝ → ℂ, (∃ i : Fin (n v), g = b v i) → ContinuousOn g (Ioo 0 (r v)) ∧
      (∀ s ∈ Ioo 0 (r v), ‖g s - v‖ = s) ∧ g '' Ioo 0 (r v) ⊆ C := by
    rintro v hv g ⟨i, rfl⟩
    refine ⟨hbc v (hNC v hv) i, hbn v (hNC v hv) i, ?_⟩
    rintro _ ⟨s, hs, rfl⟩
    have : b v i s ∈ insert v (⋃ j, b v j '' Ioo 0 (r v)) := Or.inr (mem_iUnion.mpr ⟨i, s, hs, rfl⟩)
    rw [← hbeq v (hNC v hv)] at this
    exact this.1
  have hdv : ∀ d ∈ Pf, dist d (vtx d) = ρ := by
    intro d hd
    have := (hray_c _ (hvtx d hd) _ (hf d hd)).2.1 ρ (hρI _ (hvtx d hd))
    rwa [hfρ d hd, ← dist_eq_norm] at this
  have hvtx_eq : ∀ d ∈ Pf, ∀ v ∈ N, dist d v ≤ ρ → vtx d = v := fun d hd v hv h =>
    hvuniq d _ (hvtx d hd) v hv (hdv d hd).le h
  have hPC' : ∀ d ∈ Pf, d ∈ C' := by
    intro d hd
    refine hmemC' d ((hPf d).mp hd).1 fun v hv => ?_
    by_contra h
    push Not at h
    have := hvtx_eq d hd v hv h.le
    rw [← this, hdv d hd] at h
    exact lt_irrefl _ h
  -- the arcs
  have harc := fun p (hp : p ∈ (Pf : Set ℂ)) => port_arc hρ hC'c rfl hreg' hPf hray hsep hp
  choose! γ ta tb hab hγc hγinj hQ hγa hγb huniq using harc
  set σ : ℂ → ℂ := fun p => γ p (tb p) with hσdef
  set Q : ℂ → Set ℂ := fun d => connectedComponentIn C' d with hQdef
  have hσP : ∀ d ∈ Pf, σ d ∈ Pf := fun d hd => hγb d hd
  have hQd : ∀ d ∈ Pf, Q d = γ d '' Icc (ta d) (tb d) := fun d hd => hQ d hd
  have hdQ : ∀ d ∈ Pf, d ∈ Q d := fun d hd => mem_connectedComponentIn (hPC' d hd)
  have hQC' : ∀ d, Q d ⊆ C' := fun d => connectedComponentIn_subset _ _
  have hσQ : ∀ d ∈ Pf, σ d ∈ Q d := fun d hd => by
    rw [hQd d hd]; exact ⟨tb d, right_mem_Icc.mpr (hab d hd).le, rfl⟩
  have hQσ : ∀ d ∈ Pf, Q (σ d) = Q d := fun d hd => (connectedComponentIn_eq (hσQ d hd)).symm
  have hσne : ∀ d ∈ Pf, σ d ≠ d := fun d hd h =>
    (hab d hd).ne (hγinj d hd ⟨le_rfl, (hab d hd).le⟩ ⟨(hab d hd).le, le_rfl⟩ ((hγa d hd).trans h.symm))
  have hports_Q : ∀ d ∈ Pf, ∀ q ∈ Pf, q ∈ Q d → q = d ∨ q = σ d := fun d hd q hq hqQ => huniq d hd q hq hqQ
  have hσσ : ∀ d ∈ Pf, σ (σ d) = d := by
    intro d hd
    have h1 := hσQ (σ d) (hσP d hd)
    rw [hQσ d hd] at h1
    rcases hports_Q d hd _ (hσP _ (hσP d hd)) h1 with h | h
    · exact h
    · exact absurd h (hσne (σ d) (hσP d hd))
  have hσinj : ∀ d ∈ Pf, ∀ e ∈ Pf, σ d = σ e → d = e := fun d hd e he h => by rw [← hσσ d hd, h, hσσ e he]
  have hQclosed : ∀ d ∈ Pf, IsClosed (Q d) := fun d hd => by
    rw [hQd d hd]; exact (isCompact_Icc.image (hγc d hd)).isClosed
  have hQfar : ∀ d ∈ Pf, ∀ w ∈ Q d, w ≠ d → w ≠ σ d → ∀ v ∈ N, ρ < dist w v := by
    intro d hd w hw h1 h2 v hv
    refine lt_of_le_of_ne (hnotball w (hQC' d hw) v hv) fun h => ?_
    have hwP : w ∈ Pf := (hPf w).mpr ⟨hC'C (hQC' d hw), v, hv, h.symm⟩
    rcases hports_Q d hd w hwP hw with h' | h'
    · exact h1 h'
    · exact h2 h'
  -- the radial pieces
  set R : ℂ → Set ℂ := fun d => insert (vtx d) (f d '' Ioc 0 ρ) with hRdef
  have hR : ∀ d ∈ Pf, IsCompact (R d) ∧ IsPreconnected (R d) ∧ IsPreconnected (f d '' Ioc 0 ρ) ∧ vtx d ∉ f d '' Ioc 0 ρ ∧
      R d ⊆ closedBall (vtx d) ρ ∧ vtx d ∈ closure (f d '' Ioc 0 ρ) := fun d hd =>
    ray_piece hρ (hρr _ (hvtx d hd)) (hray_c _ (hvtx d hd) _ (hf d hd)).1 (hray_c _ (hvtx d hd) _ (hf d hd)).2.1
  have hfC : ∀ d ∈ Pf, f d '' Ioc 0 ρ ⊆ C := fun d hd =>
    (image_mono (show Ioc 0 ρ ⊆ Ioo 0 (r (vtx d)) from fun s hs => ⟨hs.1, hs.2.trans_lt (hρr _ (hvtx d hd))⟩)).trans (hray_c _ (hvtx d hd) _ (hf d hd)).2.2
  have hRC : ∀ d ∈ Pf, R d ⊆ C := fun d hd => insert_subset_iff.mpr ⟨hNC _ (hvtx d hd), hfC d hd⟩
  have hdf : ∀ d ∈ Pf, d ∈ f d '' Ioc 0 ρ := fun d hd => ⟨ρ, ⟨hρ, le_rfl⟩, hfρ d hd⟩
  have hR_char : ∀ d ∈ Pf, ∀ w ∈ f d '' Ioc 0 ρ, w = f d (dist w (vtx d)) ∧ dist w (vtx d) ∈ Ioc 0 ρ := by
    rintro d hd _ ⟨s, hs, rfl⟩
    have := (hray_c _ (hvtx d hd) _ (hf d hd)).2.1 s ⟨hs.1, hs.2.trans_lt (hρr _ (hvtx d hd))⟩
    rw [dist_eq_norm, this]
    exact ⟨rfl, hs⟩
  have hR_C' : ∀ d ∈ Pf, ∀ w ∈ R d, w ∈ C' → w = d := by
    intro d hd w hw hwC'
    rcases hw with rfl | hw
    · exact absurd hwC' (hNC' _ (hvtx d hd))
    obtain ⟨e1, hs⟩ := hR_char d hd w hw
    have h1 : dist w (vtx d) = ρ := le_antisymm hs.2 (hnotball w hwC' _ (hvtx d hd))
    rw [e1, h1, hfρ d hd]
  have hR_N : ∀ d ∈ Pf, ∀ v ∈ N, v ∈ R d → v = vtx d := fun d hd v hv hvR =>
    hvuniq v v hv _ (hvtx d hd) (by rw [dist_self]; exact hρ.le) (mem_closedBall.mp ((hR d hd).2.2.2.2.1 hvR))
  have hRR : ∀ a ∈ Pf, ∀ a' ∈ Pf, a ≠ a' → R a ∩ R a' ⊆ (N : Set ℂ) := by
    rintro a ha a' ha' hne w ⟨hw, hw'⟩
    rcases hw with rfl | hw
    · exact hvtx a ha
    rcases hw' with rfl | hw'
    · exact hvtx a' ha'
    obtain ⟨e1, hs1⟩ := hR_char a ha w hw
    obtain ⟨e2, hs2⟩ := hR_char a' ha' w hw'
    have hvv : vtx a = vtx a' := hvuniq w _ (hvtx a ha) _ (hvtx a' ha') hs1.2 hs2.2
    have hfa' : ∃ i : Fin (n (vtx a)), f a' = b (vtx a) i := by rw [hvv]; exact hf a' ha'
    have hne' := hray_ne (vtx a) (hvtx a ha) (f a) (f a') (hf a ha) hfa' (by rw [hfρ a ha, hfρ a' ha']; exact hne)
      (dist w (vtx a)) ⟨hs1.1, hs1.2.trans_lt (hρr _ (hvtx a ha))⟩
    rw [← hvv] at e2
    exact absurd (e1.symm.trans e2) hne'
  have hRQ : ∀ a ∈ Pf, ∀ e ∈ Pf, a ≠ e → a ≠ σ e → ∀ w, w ∈ R a → w ∈ Q e → False := by
    intro a ha e he h1 h2 w hwR hwQ
    have := hR_C' a ha w hwR (hQC' e hwQ)
    subst this
    rcases hports_Q e he w ha hwQ with h | h
    · exact h1 h
    · exact h2 h
  have hQQ : ∀ d ∈ Pf, ∀ e ∈ Pf, e ≠ d → e ≠ σ d → ∀ w, w ∈ Q d → w ∈ Q e → False := by
    intro d hd e he h1 h2 w hwd hwe
    have hde : Q e = Q d := (connectedComponentIn_eq hwe).trans (connectedComponentIn_eq hwd).symm
    rcases hports_Q d hd e he (hde ▸ hdQ e he) with h | h
    · exact h1 h
    · exact h2 h
  -- the edges
  set E : ℂ → Set ℂ := fun d => R d ∪ Q d ∪ R (σ d) with hEdef
  have hQN : ∀ d, ∀ v ∈ N, v ∉ Q d := fun d v hv h => hNC' v hv (hQC' d h)
  have hEN : ∀ d ∈ Pf, E d \ (N : Set ℂ) = f d '' Ioc 0 ρ ∪ Q d ∪ f (σ d) '' Ioc 0 ρ := by
    intro d hd
    ext w
    constructor
    · rintro ⟨(h | h) | h, hwN⟩
      · rcases h with rfl | h
        · exact absurd (hvtx d hd) hwN
        · exact Or.inl (Or.inl h)
      · exact Or.inl (Or.inr h)
      · rcases h with rfl | h
        · exact absurd (hvtx _ (hσP d hd)) hwN
        · exact Or.inr h
    · rintro ((h | h) | h)
      · refine ⟨Or.inl (Or.inl (Or.inr h)), fun hwN => ?_⟩
        have := hR_N d hd w hwN (Or.inr h)
        exact (hR d hd).2.2.2.1 (this ▸ h)
      · exact ⟨Or.inl (Or.inr h), fun hwN => hQN d w hwN h⟩
      · refine ⟨Or.inr (Or.inr h), fun hwN => ?_⟩
        have := hR_N _ (hσP d hd) w hwN (Or.inr h)
        exact (hR _ (hσP d hd)).2.2.2.1 (this ▸ h)
  have hinter : ∀ d ∈ Pf, ∀ e ∈ Pf, e ≠ d → e ≠ σ d → E d ∩ E e ⊆ (N : Set ℂ) := by
    intro d hd e he hed heσ w ⟨hwd, hwe⟩
    have hdσe : d ≠ σ e := fun h => heσ (by rw [h, hσσ e he])
    have hσed : σ e ≠ σ d := fun h => hed (hσinj e he d hd h)
    rcases hwd with (h1 | h1) | h1 <;> rcases hwe with (h2 | h2) | h2
    · exact hRR d hd e he (Ne.symm hed) ⟨h1, h2⟩
    · exact (hRQ d hd e he (Ne.symm hed) hdσe w h1 h2).elim
    · exact hRR d hd (σ e) (hσP e he) hdσe ⟨h1, h2⟩
    · exact (hRQ e he d hd hed heσ w h2 h1).elim
    · exact (hQQ d hd e he hed heσ w h1 h2).elim
    · exact (hRQ (σ e) (hσP e he) d hd (fun h => hdσe h.symm) hσed w h2 h1).elim
    · exact hRR (σ d) (hσP d hd) e he (fun h => heσ h.symm) ⟨h1, h2⟩
    · exact (hRQ (σ d) (hσP d hd) e he (fun h => heσ h.symm) (fun h => hσed h.symm) w h1 h2).elim
    · exact hRR (σ d) (hσP d hd) (σ e) (hσP e he) (fun h => hσed h.symm) ⟨h1, h2⟩
  -- every component of what is left holds a port
  have hcomp : ∀ z ∈ C', ∃ d ∈ Pf, d ∈ connectedComponentIn C' z := by
    intro z hz
    by_contra hno
    push Not at hno
    set K := connectedComponentIn C' z with hK
    have hKC' : K ⊆ C' := connectedComponentIn_subset _ _
    have hKcl : IsClosed K := isClosed_of_closure_subset
      (isPreconnected_connectedComponentIn.closure.subset_connectedComponentIn (subset_closure (mem_connectedComponentIn hz))
        (closure_minimal hKC' hC'c.isClosed))
    have hKfar : ∀ w ∈ K, ∀ v ∈ N, ρ < dist w v := by
      intro w hw v hv
      refine lt_of_le_of_ne (hnotball w (hKC' hw) v hv) fun h => ?_
      exact hno w ((hPf w).mpr ⟨hC'C (hKC' hw), v, hv, h.symm⟩) hw
    have hKopen : ∀ w ∈ K, ∃ ε > 0, C ∩ ball w ε ⊆ K := by
      intro w hw
      have hwC := hC'C (hKC' hw)
      have hevw : ∀ᶠ ε in 𝓝[>] (0 : ℝ), 0 < ε ∧ ε < rl w ∧ ∀ v ∈ N, ε < dist w v - ρ :=
        (show ∀ᶠ ε in 𝓝[>] (0 : ℝ), 0 < ε from self_mem_nhdsWithin).and
          ((Filter.Eventually.mono (Ioo_mem_nhdsGT (hrl w hwC)) fun ε h => h.2).and
            ((Finset.eventually_all N).mpr fun v hv =>
              Filter.Eventually.mono (Ioo_mem_nhdsGT (show 0 < dist w v - ρ by linarith [hKfar w hw v hv])) fun ε h => h.2))
      obtain ⟨ε, hε, hεr, hεv⟩ := hevw.exists
      refine ⟨ε, hε, ?_⟩
      have hsub : C ∩ ball w ε ⊆ C' := fun y hy => hmemC' y hy.1 fun v hv => by
        have := dist_triangle w y v
        rw [dist_comm w y] at this
        linarith [hεv v hv, mem_ball.mp hy.2]
      have := (hlocpre w hwC ε ⟨hε, hεr.le⟩).subset_connectedComponentIn ⟨hwC, mem_ball_self hε⟩ hsub
      rwa [← connectedComponentIn_eq hw] at this
    set U := {w | ∃ ε > 0, C ∩ ball w ε ⊆ K} with hU
    have hUo : IsOpen U := by
      rw [Metric.isOpen_iff]
      rintro w ⟨ε, hε, hεK⟩
      refine ⟨ε, hε, fun w' hw' => ⟨ε - dist w' w, by rw [mem_ball] at hw'; linarith, fun y hy => hεK ⟨hy.1, ?_⟩⟩⟩
      rw [mem_ball] at hw' ⊢
      have := hy.2
      rw [mem_ball] at this
      linarith [dist_triangle y w' w]
    rcases (isPreconnected_iff_subset_of_disjoint.mp hCc) U Kᶜ hUo hKcl.isOpen_compl
      (fun w hw => by
        by_cases hwK : w ∈ K
        · exact Or.inl (hKopen w hwK)
        · exact Or.inr hwK)
      (by
        ext w
        simp only [mem_inter_iff, mem_empty_iff_false, iff_false, not_and]
        rintro hwC ⟨ε, hε, hεK⟩ hwK
        exact hwK (hεK ⟨hwC, mem_ball_self hε⟩)) with h | h
    · obtain ⟨v, hv⟩ := hN
      obtain ⟨ε, hε, hεK⟩ := h (hNC v hv)
      exact hNC' v hv (hKC' (hεK ⟨hNC v hv, mem_ball_self hε⟩))
    · exact h (hC'C hz) (mem_connectedComponentIn hz)
  refine ⟨Pf, vtx, σ, E, ⟨hvtx, hσP, hσσ, hσne, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, hinter, ?_, ?_⟩⟩
  · -- even
    intro v hv
    have hfil : (Pf.filter fun d => vtx d = v) = Finset.univ.image fun i : Fin (n v) => b v i ρ := by
      ext d
      simp only [Finset.mem_filter, Finset.mem_image, Finset.mem_univ, true_and]
      constructor
      · rintro ⟨hd, rfl⟩
        obtain ⟨i, hi⟩ := hf d hd
        exact ⟨i, by rw [← hi, hfρ d hd]⟩
      · rintro ⟨i, rfl⟩
        have hd : b v i ρ ∈ Pf := (hPf _).mpr ⟨(hb_mem v hv i).1, v, hv, (hb_mem v hv i).2⟩
        exact ⟨hd, hvtx_eq _ hd v hv (hb_mem v hv i).2.le⟩
    have hinj : Function.Injective fun i : Fin (n v) => b v i ρ := fun i j h => by
      by_contra hij
      exact hbd v (hNC v hv) i j hij ρ (hρI v hv) h
    rw [hfil, Finset.card_image_of_injective _ hinj, Finset.card_univ, Fintype.card_fin]
    exact hev v (hNC v hv)
  · -- a port at each vertex
    intro v hv
    have hd : b v ⟨0, hpos v (hNC v hv)⟩ ρ ∈ Pf := (hPf _).mpr ⟨(hb_mem v hv _).1, v, hv, (hb_mem v hv _).2⟩
    exact ⟨_, hd, hvtx_eq _ hd v hv (hb_mem v hv _).2.le⟩
  · -- closed
    intro d hd
    exact ((hR d hd).1.isClosed.union (hQclosed d hd)).union (hR _ (hσP d hd)).1.isClosed
  · -- connected off the vertices
    intro d hd
    rw [hEN d hd]
    refine IsPreconnected.union (σ d) (Or.inr (hσQ d hd)) (hdf _ (hσP d hd)) ?_ (hR _ (hσP d hd)).2.2.1
    exact IsPreconnected.union d (hdf d hd) (hdQ d hd) (hR d hd).2.2.1 isPreconnected_connectedComponentIn
  · -- in `C`
    intro d hd
    exact union_subset (union_subset (hRC d hd) ((hQC' d).trans hC'C)) (hRC _ (hσP d hd))
  · -- in the closure of its part off the vertices
    intro d hd
    rw [hEN d hd]
    have hcl : ∀ a ∈ Pf, R a ⊆ closure (f a '' Ioc 0 ρ) := fun a ha =>
      insert_subset_iff.mpr ⟨(hR a ha).2.2.2.2.2, subset_closure⟩
    refine union_subset (union_subset ((hcl d hd).trans (closure_mono ?_)) (subset_closure.trans (closure_mono ?_)))
      ((hcl _ (hσP d hd)).trans (closure_mono ?_))
    · exact fun w h => Or.inl (Or.inl h)
    · exact fun w h => Or.inl (Or.inr h)
    · exact fun w h => Or.inr h
  · exact fun d _ => Or.inl (Or.inl (Or.inl rfl))
  · exact fun d _ => Or.inr (Or.inl rfl)
  · -- symmetric
    intro d hd
    show R (σ d) ∪ Q (σ d) ∪ R (σ (σ d)) = R d ∪ Q d ∪ R (σ d)
    rw [hσσ d hd, hQσ d hd]
    ext w
    simp only [mem_union]
    tauto
  · -- meets the vertices only at its ends
    intro d hd v hv hvE
    rcases hvE with (h | h) | h
    · exact Or.inl (hR_N d hd v hv h)
    · exact absurd h (hQN d v hv)
    · exact Or.inr (hR_N _ (hσP d hd) v hv h)
  · -- the edges cover
    intro z hz
    by_cases hzC' : z ∈ C'
    · obtain ⟨d, hd, hdK⟩ := hcomp z hzC'
      refine ⟨d, hd, Or.inl (Or.inr ?_)⟩
      show z ∈ connectedComponentIn C' d
      rw [← connectedComponentIn_eq hdK]
      exact mem_connectedComponentIn hzC'
    · obtain ⟨v, hv, hzv⟩ : ∃ v ∈ N, dist z v < ρ := by
        by_contra h
        push Not at h
        exact hzC' (hmemC' z hz h)
      have hzb : z ∈ C ∩ ball v (r v) := ⟨hz, by rw [mem_ball]; linarith [hρr v hv]⟩
      rw [hbeq v (hNC v hv)] at hzb
      rcases hzb with rfl | hzb
      · have hd : b z ⟨0, hpos z (hNC z hv)⟩ ρ ∈ Pf := (hPf _).mpr ⟨(hb_mem z hv _).1, z, hv, (hb_mem z hv _).2⟩
        refine ⟨_, hd, Or.inl (Or.inl (Or.inl ?_))⟩
        exact (hvtx_eq _ hd z hv (hb_mem z hv _).2.le).symm
      · obtain ⟨i, s, hs, rfl⟩ := mem_iUnion.mp hzb
        have hd : b v i ρ ∈ Pf := (hPf _).mpr ⟨(hb_mem v hv i).1, v, hv, (hb_mem v hv i).2⟩
        have hvd : vtx (b v i ρ) = v := hvtx_eq _ hd v hv (hb_mem v hv i).2.le
        have hfv : ∃ j : Fin (n v), f (b v i ρ) = b v j := by
          have h := hf _ hd
          rw [hvd] at h
          exact h
        have hfd : f (b v i ρ) = b v i := hray_eq v hv _ _ hfv ⟨i, rfl⟩ (hfρ _ hd)
        refine ⟨_, hd, Or.inl (Or.inl (Or.inr ⟨s, ⟨hs.1, ?_⟩, by rw [hfd]⟩))⟩
        have := hbn v (hNC v hv) i s hs
        rw [dist_eq_norm, this] at hzv
        exact hzv.le
  · -- the pure point of each edge
    intro d hd
    have hab' := hab d hd
    set t₀ := (ta d + tb d) / 2 with ht₀def
    have ht₀ : t₀ ∈ Ioo (ta d) (tb d) := ⟨by linarith, by linarith⟩
    set p := γ d t₀ with hpdef
    have hpQ : p ∈ Q d := by rw [hQd d hd]; exact ⟨t₀, Ioo_subset_Icc_self ht₀, rfl⟩
    have hpE : p ∈ E d := Or.inl (Or.inr hpQ)
    have hpC' : p ∈ C' := hQC' d hpQ
    have hpN : p ∉ N := fun h => hNC' p h hpC'
    have hpd : p ≠ d := fun h => ht₀.1.ne' (hγinj d hd (Ioo_subset_Icc_self ht₀) ⟨le_rfl, hab'.le⟩ (h.trans (hγa d hd).symm))
    have hpσ : p ≠ σ d := fun h => ht₀.2.ne (hγinj d hd (Ioo_subset_Icc_self ht₀) ⟨hab'.le, le_rfl⟩ h)
    have hpfar : ∀ v ∈ N, ρ < dist p v := hQfar d hd p hpQ hpd hpσ
    have hEne : ∀ e ∈ Pf, (E e).Nonempty := fun e he => ⟨vtx e, Or.inl (Or.inl (Or.inl rfl))⟩
    have hEcl : ∀ e ∈ Pf, IsClosed (E e) := fun e he =>
      ((hR e he).1.isClosed.union (hQclosed e he)).union (hR _ (hσP e he)).1.isClosed
    have hpos_e : ∀ e ∈ Pf, e ≠ d → e ≠ σ d → 0 < infDist p (E e) := fun e he h1 h2 =>
      (infDist_pos_iff_notMem_closure (hEne e he)).mp (by
        rw [(hEcl e he).closure_eq]
        exact fun hp => hpN (hinter d hd e he h1 h2 ⟨hpE, hp⟩))
    have hevp : ∀ᶠ ε in 𝓝[>] (0 : ℝ), ε < rl p ∧ (∀ v ∈ N, ε < dist p v - ρ) ∧
        ∀ e ∈ Pf, e ≠ d → e ≠ σ d → ε < infDist p (E e) :=
      (Filter.Eventually.mono (Ioo_mem_nhdsGT (hrl p (hC'C hpC'))) fun ε h => h.2).and
        (((Finset.eventually_all N).mpr fun v hv =>
          Filter.Eventually.mono (Ioo_mem_nhdsGT (show 0 < dist p v - ρ by linarith [hpfar v hv])) fun ε h => h.2).and
        ((Finset.eventually_all Pf).mpr fun e he => by
          by_cases h12 : e ≠ d ∧ e ≠ σ d
          · exact Filter.Eventually.mono (Ioo_mem_nhdsGT (hpos_e e he h12.1 h12.2)) fun ε h _ _ => h.2
          · exact Eventually.of_forall fun ε h1 h2 => absurd ⟨h1, h2⟩ h12))
    obtain ⟨ε₀, hε₀, hsub⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp hevp
    refine ⟨p, hpE, hpN, ε₀, hε₀, fun ε hε => ?_⟩
    obtain ⟨hεr, hεv, hεe⟩ := hsub hε
    have hballC' : C ∩ ball p ε ⊆ C' := fun w hw => hmemC' w hw.1 fun v hv => by
      have := dist_triangle p w v
      rw [dist_comm p w] at this
      linarith [hεv v hv, mem_ball.mp hw.2]
    have hpre : IsPreconnected (C ∩ ball p ε) := hlocpre p (hC'C hpC') ε ⟨hε.1, hεr.le⟩
    have hCQ : C ∩ ball p ε ⊆ Q d := by
      have := hpre.subset_connectedComponentIn ⟨hC'C hpC', mem_ball_self hε.1⟩ hballC'
      rwa [← connectedComponentIn_eq hpQ] at this
    have hRball : ∀ a ∈ Pf, Disjoint (R a) (ball p ε) := by
      intro a ha
      rw [Set.disjoint_left]
      intro w hwR hwb
      have h1 := mem_closedBall.mp ((hR a ha).2.2.2.2.1 hwR)
      have h2 := dist_triangle p w (vtx a)
      rw [dist_comm p w] at h2
      linarith [hεv _ (hvtx a ha), mem_ball.mp hwb]
    have hQball : Q d ∩ ball p ε = C ∩ ball p ε :=
      Subset.antisymm (inter_subset_inter_left _ ((hQC' d).trans hC'C)) (fun w hw => ⟨hCQ hw, hw.2⟩)
    have hEball : E d ∩ ball p ε = C ∩ ball p ε := by
      refine Subset.antisymm ?_ (fun w hw => ⟨Or.inl (Or.inr (hCQ hw)), hw.2⟩)
      rintro w ⟨hwE, hwb⟩
      exact ⟨union_subset (union_subset (hRC d hd) ((hQC' d).trans hC'C)) (hRC _ (hσP d hd)) hwE, hwb⟩
    have hapart : ∀ e ∈ Pf, e ≠ d → e ≠ σ d → Disjoint (E e) (closedBall p ε) := by
      intro e he h1 h2
      rw [Set.disjoint_left]
      intro w hwE hwb
      have := infDist_le_dist_of_mem (x := p) hwE
      rw [dist_comm] at this
      linarith [hεe e he h1 h2, mem_closedBall.mp hwb]
    have hfar_port : ∀ a ∈ Pf, ε < dist a p := by
      intro a ha
      have := dist_triangle p a (vtx a)
      rw [hdv a ha, dist_comm p a] at this
      linarith [hεv _ (hvtx a ha)]
    obtain ⟨c₁, c₂, hac₁, hc₁t, htc₂, hc₂b, hiff, hd₁, hd₂⟩ := exists_Ioo_of_preimage_ball (hγc d hd) (hγinj d hd) ht₀ rfl hε.1
      (by rw [hγa d hd]; exact hfar_port d hd) (hfar_port _ (hσP d hd)) (by rw [← hQd d hd, hQball]; exact hpre)
    have hc₁₂ : c₁ < c₂ := hc₁t.trans htc₂
    refine ⟨hEball, hapart, R d ∪ γ d '' Icc (ta d) c₁, γ d '' Icc c₂ (tb d) ∪ R (σ d), γ d c₁, γ d c₂, ?_,
      (hR d hd).1.isClosed.union (isCompact_Icc.image (hγc d hd)).isClosed,
      IsPreconnected.union d (Or.inr (hdf d hd)) ⟨ta d, left_mem_Icc.mpr hac₁.le, hγa d hd⟩ (hR d hd).2.1
        (isPreconnected_Icc.image _ (hγc d hd).continuousOn),
      (isCompact_Icc.image (hγc d hd)).isClosed.union (hR _ (hσP d hd)).1.isClosed,
      IsPreconnected.union (σ d) ⟨tb d, right_mem_Icc.mpr hc₂b.le, rfl⟩ (Or.inr (hdf _ (hσP d hd)))
        (isPreconnected_Icc.image _ (hγc d hd).continuousOn) (hR _ (hσP d hd)).2.1,
      Or.inl (Or.inl rfl), Or.inr (Or.inl rfl), Or.inr ⟨c₁, right_mem_Icc.mpr hac₁.le, rfl⟩,
      Or.inl ⟨c₂, left_mem_Icc.mpr hc₂b.le, rfl⟩,
      fun h => hc₁₂.ne (hγinj d hd ⟨hac₁.le, hc₁₂.le.trans hc₂b.le⟩ ⟨hac₁.le.trans hc₁₂.le, hc₂b.le⟩ h), hd₁, hd₂⟩
    ext w
    constructor
    · rintro ⟨(h | h) | h, hwb⟩
      · exact Or.inl (Or.inl h)
      · rw [hQd d hd] at h
        obtain ⟨t, ht, rfl⟩ := h
        have hnt : t ∉ Ioo c₁ c₂ := fun h' => hwb ((hiff t ht).mpr h')
        rcases le_or_gt t c₁ with h' | h'
        · exact Or.inl (Or.inr ⟨t, ⟨ht.1, h'⟩, rfl⟩)
        · exact Or.inr (Or.inl ⟨t, ⟨le_of_not_gt fun h'' => hnt ⟨h', h''⟩, ht.2⟩, rfl⟩)
      · exact Or.inr (Or.inr h)
    · rintro ((h | ⟨t, ht, rfl⟩) | (⟨t, ht, rfl⟩ | h))
      · exact ⟨Or.inl (Or.inl h), Set.disjoint_left.mp (hRball d hd) h⟩
      · have htab : t ∈ Icc (ta d) (tb d) := ⟨ht.1, ht.2.trans (hc₁₂.le.trans hc₂b.le)⟩
        refine ⟨Or.inl (Or.inr (by rw [hQd d hd]; exact ⟨t, htab, rfl⟩)), fun hb => ?_⟩
        have := ((hiff t htab).mp hb).1
        linarith [ht.2]
      · have htab : t ∈ Icc (ta d) (tb d) := ⟨(hac₁.le.trans hc₁₂.le).trans ht.1, ht.2⟩
        refine ⟨Or.inl (Or.inr (by rw [hQd d hd]; exact ⟨t, htab, rfl⟩)), fun hb => ?_⟩
        have := ((hiff t htab).mp hb).2
        linarith [ht.1]
      · exact ⟨Or.inr h, Set.disjoint_left.mp (hRball _ (hσP d hd)) h⟩

/-! ### WALK's C5d and C10, on the map (FS131-RW2) -/

variable {k : ℕ} {F : ArcMap k}

/-- **A set connected near each of its points to a closed set lies in it** (FS131-RW2): a preconnected `S ⊆ C` meeting a closed `T`, such
that `C` lies in `T` near each point of `S ∩ T`, lies in `T`. -/
theorem subset_of_isPreconnected_of_locally {C S T : Set ℂ} (hS : IsPreconnected S) (hSC : S ⊆ C) (hT : IsClosed T)
    (hne : (S ∩ T).Nonempty) (hloc : ∀ w ∈ S ∩ T, ∃ r > 0, C ∩ ball w r ⊆ T) : S ⊆ T := by
  set U := {w | ∃ r > 0, C ∩ ball w r ⊆ T} with hU
  have hUo : IsOpen U := by
    rw [Metric.isOpen_iff]
    rintro w ⟨r, hr, hrT⟩
    refine ⟨r, hr, fun w' hw' => ⟨r - dist w' w, by rw [mem_ball] at hw'; linarith, fun y hy => hrT ⟨hy.1, ?_⟩⟩⟩
    rw [mem_ball] at hw' ⊢
    have := hy.2
    rw [mem_ball] at this
    linarith [dist_triangle y w' w]
  have hUT : ∀ w ∈ C, w ∈ U → w ∈ T := fun w hw ⟨r, hr, hrT⟩ => hrT ⟨hw, mem_ball_self hr⟩
  rcases (isPreconnected_iff_subset_of_disjoint.mp hS) U Tᶜ hUo hT.isOpen_compl
    (fun w hw => by
      by_cases hwT : w ∈ T
      · exact Or.inl (hloc w ⟨hw, hwT⟩)
      · exact Or.inr hwT)
    (by
      ext w
      simp only [mem_inter_iff, mem_empty_iff_false, iff_false, not_and]
      exact fun hwS hwU hwT => hwT (hUT w (hSC hwS) hwU)) with h | h
  · exact fun w hw => hUT w (hSC hw) (h hw)
  · obtain ⟨w, hwS, hwT⟩ := hne
    exact absurd hwT (h hwS)

/-- The frontier of a filled tile is not empty (the filled closure is a bounded nonempty set of the plane). -/
theorem nonempty_frontier_closure_fill (hF : F.Valid) {X : Set ℂ} (hX : F.IsTile X) :
    (frontier (closure (fill X))).Nonempty := by
  rw [nonempty_frontier_iff]
  obtain ⟨a, ha⟩ := hX.nonempty
  refine ⟨⟨a, subset_closure (Or.inl ha)⟩, fun h => ?_⟩
  have hb := isBounded_closure_fill hF hX
  rw [h] at hb
  exact NormedSpace.unbounded_univ ℝ ℂ hb

/-- **WALK's C3, the star with at least one ray** (FS131-RW2): at each point of `C = ∂ cl x̂`, `C` has a curve star of an even and positive
number of rays (a branch of the chart there lies in `C`, `frontier_fill_exists_ray`). -/
theorem frontier_fill_hasCurveStar_pos (hP : F.IsPlaneMap) {X : Set ℂ} (hX : F.IsTile X) {z : ℂ}
    (hz : z ∈ frontier (closure (fill X))) : ∃ d, Even d ∧ 0 < d ∧ HasCurveStar (frontier (closure (fill X))) z d := by
  obtain ⟨d, hev, hst⟩ := frontier_fill_hasCurveStar hP hX hz
  refine ⟨d, hev, Nat.pos_of_ne_zero fun hd0 => ?_, hst⟩
  subst hd0
  obtain ⟨r, hr, b, -, -, -, heq, -⟩ := hst
  obtain ⟨r₀, n, G, hC⟩ := localSectors F (show z ∈ F.dom by rw [hP]; exact mem_univ z)
  obtain ⟨u, hu, hsub⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp (G.eventually_dir_lt_nextDir hC.sorted hC.pos hC.curv)
  set r' := min (min u r₀) r with hr'def
  have hr'1 : r' ≤ min u r₀ := min_le_left _ _
  have hr'2 : r' ≤ r := min_le_right _ _
  have hr' : r' ∈ Ioc 0 r₀ := ⟨lt_min (lt_min hu hC.pos) hr, hr'1.trans (min_le_right _ _)⟩
  have hord : ∀ s ∈ Ioo 0 r', ∀ i, G.dir i s < G.nextDir i s := fun s hs =>
    hsub ⟨hs.1, hs.2.trans_le (hr'1.trans (min_le_left _ _))⟩
  have hn := frontier_fill_chart_pos hP hX hz hC
  obtain ⟨i, hi⟩ := frontier_fill_exists_ray hX hz hC hn hr'
  have hs : r' / 2 ∈ Ioo 0 r' := ⟨half_pos hr'.1, half_lt_self hr'.1⟩
  have hw := (frontier_fill_branch_iff hX hC hn hr' hord i hs).mpr hi
  have hwd : ‖branchPt z (G.β (BranchGerms.next i)) (G.κ (BranchGerms.next i)) (r' / 2) - z‖ = r' / 2 :=
    norm_branchPt_sub _ _ _ hs.1.le
  have hwb : branchPt z (G.β (BranchGerms.next i)) (G.κ (BranchGerms.next i)) (r' / 2) ∈
      frontier (closure (fill X)) ∩ ball z r := ⟨hw, by rw [mem_ball, dist_eq_norm, hwd]; linarith [hr'.1]⟩
  rw [heq] at hwb
  rcases hwb with h | h
  · rw [h, sub_self, norm_zero] at hwd
    linarith [hr'.1]
  · simp at h

/-- A point of an outer tile's closure and of the closure of another outer tile lies on the frontier of the first's filled closure. -/
theorem closure_inter_subset_frontier_fill {x y : Set ℂ} (hx : F.IsTile x) (hy : F.IsOuterTile y) (hne : y ≠ x) :
    closure x ∩ closure y ⊆ frontier (closure (fill x)) := by
  rintro w ⟨hwx, hwy⟩
  rw [frontier_eq_closure_inter_closure, closure_closure]
  refine ⟨closure_mono (subset_fill x) hwx, closure_mono (fun a ha => ?_) hwy⟩
  exact Set.disjoint_left.mp (IsOuterTile.disjoint_closure_fill hx hy hne) ha

/-- **A tile off a filled outer tile whose closure meets the outer tile's is outer** (FS131-RW2): a hole of another tile holding it would
also hold the outer tile (a tile off `cl T'` lies in one of its complementary components) or keep the two closures apart. -/
theorem isOuterTile_of_closure_inter {X Y : Set ℂ} (hX : F.IsOuterTile X) (hY : F.IsTile Y)
    (hYX : Y ⊆ (closure (fill X))ᶜ) (hne : (closure X ∩ closure Y).Nonempty) : F.IsOuterTile Y := by
  refine ⟨hY, fun T' Hc hT' hH hYH => ?_⟩
  by_cases hXT : X = T'
  · subst hXT
    obtain ⟨a, ha⟩ := hY.nonempty
    exact hYX ha (subset_closure (Or.inr ⟨Hc, hH, hYH ha⟩))
  · have hXc : X ⊆ (closure T')ᶜ := IsTile.subset_compl_closure hT' hX.1 hXT
    rcases IsTile.subset_or_subset_of_separated hX.1 hH.2.2.2
        (fun w hw => by
          by_cases hwH : w ∈ Hc
          · exact Or.inl hwH
          · exact Or.inr ⟨hXc hw, hwH⟩) with h | h
    · exact hX.2 T' Hc hT' hH h
    · obtain ⟨w, hwX, hwY⟩ := hne
      exact Set.disjoint_left.mp hH.2.2.2 (closure_mono hYH hwY) (closure_mono h hwX)

/-- The two germs of a two-germ chart: the second is the first's successor, and the first, one turn on, the second's. -/
theorem nextDir_two (G : BranchGerms 2) (s : ℝ) : G.nextDir 0 s = G.dir 1 s ∧ G.nextDir 1 s = G.dir 0 s + 2 * π := by
  refine ⟨?_, ?_⟩
  · simp [BranchGerms.nextDir, BranchGerms.dir, BranchGerms.nextβ, BranchGerms.nextκ]
  · simp only [BranchGerms.nextDir, BranchGerms.dir, BranchGerms.nextβ, BranchGerms.nextκ, germDir]
    simp
    ring

/-- **A sector meets a circle about its vertex in an arc of angles** (FS131-RW2): out to radius `r`, the points of the `i`-th sector at distance
`ρ < r` are the polar points at angles strictly between the two germs' directions at `ρ`. -/
theorem sector_inter_sphere {n : ℕ} (G : BranchGerms n) (z : ℂ) {r ρ : ℝ} (hρ : ρ ∈ Ioo 0 r) (i : Fin n) :
    G.sector z r i ∩ sphere z ρ = polarPt z ρ '' Ioo (G.dir i ρ) (G.nextDir i ρ) := by
  ext w
  constructor
  · rintro ⟨⟨s, hs, φ, hφ, rfl⟩, hw⟩
    have hs' : s = ρ := by
      rw [mem_sphere, dist_eq_norm, add_sub_cancel_left, norm_mul_e hs.1.le] at hw
      exact hw
    subst hs'
    exact ⟨φ, hφ, rfl⟩
  · rintro ⟨φ, hφ, rfl⟩
    refine ⟨⟨ρ, hρ, φ, hφ, rfl⟩, ?_⟩
    rw [mem_sphere, polarPt, dist_eq_norm, add_sub_cancel_left, norm_mul_e hρ.1.le]

/-- **WALK's C5d, the local picture at a regular point of `C = ∂ cl x̂`** (FS131-RW2): out to some radius the chart has two germs, both
branches in `C`, the sector on one side in `x` and the other in one tile `Y` off `cl x̂` — the only tile off `cl x̂` meeting the disc,
whose closure holds `C` there. Inside, each disc is `x`, `Y` and `C`; its circle meets `x` and `Y` in nonempty arcs; and its two points of `C`
interleave with points of `x ∪ Y` (one in each sector between them). -/
theorem frontier_fill_regular_local (hP : F.IsPlaneMap) {X : Set ℂ} (hX : F.IsTile X) {z : ℂ}
    (hz : z ∈ frontier (closure (fill X))) (hreg : IsRegularAt F.Γ z) :
    ∃ r > 0, ∃ Y, F.IsTile Y ∧ Y ⊆ (closure (fill X))ᶜ ∧ frontier (closure (fill X)) ∩ ball z r ⊆ closure Y ∧
      (∀ Y', F.IsTile Y' → Y' ⊆ (closure (fill X))ᶜ → (Y' ∩ ball z r).Nonempty → Y' = Y) ∧
      ∀ ρ ∈ Ioo 0 r, ball z ρ ⊆ X ∪ Y ∪ (frontier (closure (fill X)) ∩ ball z ρ) ∧
        IsPreconnected (X ∩ sphere z ρ) ∧ (X ∩ sphere z ρ).Nonempty ∧ IsPreconnected (Y ∩ sphere z ρ) ∧
        (Y ∩ sphere z ρ).Nonempty ∧
        ∀ q₁ ∈ frontier (closure (fill X)), ∀ q₂ ∈ frontier (closure (fill X)), dist q₁ z = ρ → dist q₂ z = ρ → q₁ ≠ q₂ →
          ∃ θ₁ θ₂ θ₃ θ₄ : ℝ, θ₁ < θ₂ ∧ θ₂ < θ₃ ∧ θ₃ < θ₄ ∧ θ₄ < θ₁ + 2 * π ∧ polarPt z ρ θ₁ = q₁ ∧
            polarPt z ρ θ₂ ∈ X ∪ Y ∧ polarPt z ρ θ₃ = q₂ ∧ polarPt z ρ θ₄ ∈ X ∪ Y := by
  classical
  set K := closure (fill X) with hKdef
  obtain ⟨r₀, n, G, hC⟩ := localSectors F (show z ∈ F.dom by rw [hP]; exact mem_univ z)
  obtain ⟨u, hu, hsub⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp (G.eventually_dir_lt_nextDir hC.sorted hC.pos hC.curv)
  set r := min u r₀ with hrdef
  have hr : r ∈ Ioc 0 r₀ := ⟨lt_min hu hC.pos, min_le_right _ _⟩
  have hord : ∀ s ∈ Ioo 0 r, ∀ i, G.dir i s < G.nextDir i s := fun s hs => hsub ⟨hs.1, hs.2.trans_le (min_le_left _ _)⟩
  have hn := frontier_fill_chart_pos hP hX hz hC
  have h2 := hC.eq_two_of_isRegularAt hn hr hord hreg
  subst h2
  have hfin2 : ∀ i j : Fin 2, i = j ∨ i = BranchGerms.next j := by decide
  have hnn : ∀ j : Fin 2, BranchGerms.next (BranchGerms.next j) = j := by decide
  have hpair : ∀ a b : Fin 2, a ≠ b → (a = 0 ∧ b = 1) ∨ (a = 1 ∧ b = 0) := by decide
  -- both branches are in `C`, so the two sectors lie on opposite sides
  set S := Finset.univ.filter fun i : Fin 2 =>
    ¬ (G.sector z r i ⊆ Kᶜ ↔ G.sector z r (BranchGerms.next i) ⊆ Kᶜ) with hS
  have hSall : S = Finset.univ := by
    obtain ⟨i, hi⟩ := frontier_fill_exists_ray hX hz hC hn hr
    have hi' : i ∈ S := Finset.mem_filter.mpr ⟨Finset.mem_univ _, hi⟩
    have hev := even_card_filter_ne_next (fun i : Fin 2 => G.sector z r i ⊆ Kᶜ)
    rw [← hS] at hev
    have hpos : 0 < S.card := Finset.card_pos.mpr ⟨i, hi'⟩
    have hle : S.card ≤ 2 := (Finset.card_le_univ S).trans (by simp)
    have hc : S.card = 2 := by obtain ⟨m, hm⟩ := hev; omega
    exact Finset.eq_univ_of_card S (by simpa using hc)
  have heqC : frontier K ∩ ball z r = insert z (⋃ i, branchPt z (G.β i) (G.κ i) '' Ioo 0 r) := by
    have heq := frontier_fill_inter_ball hP hX hz hC hr hord
    rw [← hS, hSall] at heq
    rw [heq]
    congr 1
    ext w
    simp only [Finset.mem_univ, iUnion_true, mem_iUnion]
    constructor
    · rintro ⟨i, hi⟩; exact ⟨_, hi⟩
    · rintro ⟨i, hi⟩
      exact ⟨BranchGerms.next i, by rw [hnn]; exact hi⟩
  have hcases : ∀ j, G.sector z r j ⊆ fill X ∨ G.sector z r j ⊆ Kᶜ := fun j => by
    obtain ⟨T, hT, hjT⟩ := hC.exists_tile_superset hn hr j
    rcases IsTile.subset_fill_or_subset_compl hX hT with h | h
    · exact Or.inl (hjT.trans h)
    · exact Or.inr (hjT.trans h)
  have hne : ∀ j, ¬ (G.sector z r j ⊆ fill X ∧ G.sector z r j ⊆ Kᶜ) := fun j ⟨h1, h2⟩ => by
    obtain ⟨y, hy⟩ := hC.sector_nonempty hr j
    exact h2 hy (subset_closure (h1 hy))
  obtain ⟨j, -, hjY⟩ : ∃ j : Fin 2, G.sector z r j ⊆ fill X ∧ G.sector z r (BranchGerms.next j) ⊆ Kᶜ := by
    have h0 : (0 : Fin 2) ∈ S := by rw [hSall]; exact Finset.mem_univ _
    have h0' := (Finset.mem_filter.mp h0).2
    rcases hcases 0 with h | h
    · exact ⟨0, h, (hcases _).resolve_left fun h' =>
        h0' ⟨fun h'' => absurd ⟨h, h''⟩ (hne 0), fun h'' => absurd ⟨h', h''⟩ (hne _)⟩⟩
    · refine ⟨BranchGerms.next 0, (hcases _).resolve_right fun h' => h0' ⟨fun _ => h', fun _ => h⟩, ?_⟩
      rw [hnn]; exact h
  -- the inner sector lies in `x`
  have hzX : z ∈ closure X := frontier_closure_fill_subset hP hX hz
  have hXK : X ⊆ K := (subset_fill X).trans subset_closure
  have hIP : ∀ w, w ∉ F.Γ → w ∈ F.interiorPts := fun w hw =>
    ⟨by rw [hP]; trivial, fun h => hw ⟨by rw [hP]; trivial, h⟩⟩
  obtain ⟨a, haX, hab⟩ := (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨z, hzX, mem_ball_self hr.1⟩
  have haI : a ∈ ball z r ∩ F.interiorPts := ⟨hab, hX.subset_interiorPts haX⟩
  rw [hC.cover r hr hn] at haI
  obtain ⟨i, hai⟩ := mem_iUnion.mp haI
  have hij : i = j := by
    rcases hfin2 i j with h | h
    · exact h
    · exact absurd (hXK haX) (hjY (h ▸ hai))
  subst hij
  have hiX : G.sector z r i ⊆ X := hC.sector_subset_tile_of_mem hn hr hX hai haX
  -- the outer sector lies in one tile `Y` off `cl x̂`
  obtain ⟨Y, hY, hYsec⟩ := hC.exists_tile_superset hn hr (BranchGerms.next i)
  have hYK : Y ⊆ Kᶜ := by
    rcases IsTile.subset_fill_or_subset_compl hX hY with h | h
    · exfalso
      obtain ⟨w, hw⟩ := hC.sector_nonempty hr (BranchGerms.next i)
      exact hjY hw (subset_closure (h (hYsec hw)))
    · exact h
  have hsecXY : ∀ i', G.sector z r i' ⊆ X ∪ Y := fun i' => by
    rcases hfin2 i' i with rfl | rfl
    · exact hiX.trans subset_union_left
    · exact hYsec.trans subset_union_right
  have hint : ∀ w ∈ ball z r, w ∉ F.Γ → ∃ i', w ∈ G.sector z r i' := fun w hw hwΓ => by
    have hwI : w ∈ ball z r ∩ F.interiorPts := ⟨hw, hIP w hwΓ⟩
    rw [hC.cover r hr hn] at hwI
    exact mem_iUnion.mp hwI
  have hΓC : F.Γ ∩ ball z r = frontier K ∩ ball z r := by rw [hC.gamma_inter_ball hn hr, heqC]
  have hXΓ : ∀ w ∈ X, w ∉ F.Γ := fun w hw hwΓ => by
    have := hX.subset_interiorPts hw
    exact this.2 hwΓ.2
  have hYΓ : ∀ w ∈ Y, w ∉ F.Γ := fun w hw hwΓ => (hY.subset_interiorPts hw).2 hwΓ.2
  -- the slices of a circle
  have hXsph : ∀ ρ ∈ Ioo 0 r, X ∩ sphere z ρ = G.sector z r i ∩ sphere z ρ := by
    intro ρ hρ
    refine Subset.antisymm (fun w ⟨hwX, hws⟩ => ⟨?_, hws⟩) (fun w ⟨hw, hws⟩ => ⟨hiX hw, hws⟩)
    have hwb : w ∈ ball z r := by rw [mem_ball, mem_sphere.mp hws]; exact hρ.2
    obtain ⟨i', hi'⟩ := hint w hwb (hXΓ w hwX)
    rcases hfin2 i' i with rfl | rfl
    · exact hi'
    · exact absurd (hXK hwX) (hYK (hYsec hi'))
  have hYsph : ∀ ρ ∈ Ioo 0 r, Y ∩ sphere z ρ = G.sector z r (BranchGerms.next i) ∩ sphere z ρ := by
    intro ρ hρ
    refine Subset.antisymm (fun w ⟨hwY, hws⟩ => ⟨?_, hws⟩) (fun w ⟨hw, hws⟩ => ⟨hYsec hw, hws⟩)
    have hwb : w ∈ ball z r := by rw [mem_ball, mem_sphere.mp hws]; exact hρ.2
    obtain ⟨i', hi'⟩ := hint w hwb (hYΓ w hwY)
    rcases hfin2 i' i with rfl | rfl
    · exact absurd (hXK (hiX hi')) (hYK hwY)
    · exact hi'
  have hpolc : ∀ ρ : ℝ, Continuous (polarPt z ρ) := fun ρ => continuous_const.add (continuous_const.mul continuous_e)
  have hslice : ∀ ρ ∈ Ioo 0 r, ∀ i', IsPreconnected (G.sector z r i' ∩ sphere z ρ) ∧ (G.sector z r i' ∩ sphere z ρ).Nonempty := by
    intro ρ hρ i'
    rw [sector_inter_sphere G z hρ i']
    exact ⟨isPreconnected_Ioo.image _ (hpolc ρ).continuousOn, (nonempty_Ioo.mpr (hord ρ hρ i')).image _⟩
  -- the points of `C` on a circle are the branches' points
  have hq : ∀ ρ ∈ Ioo 0 r, ∀ q ∈ frontier K, dist q z = ρ → ∃ i', q = polarPt z ρ (G.dir i' ρ) := by
    intro ρ hρ q hqC hqd
    have hqb : q ∈ frontier K ∩ ball z r := ⟨hqC, by rw [mem_ball, hqd]; exact hρ.2⟩
    rw [heqC] at hqb
    rcases hqb with rfl | hqb
    · rw [dist_self] at hqd; exact absurd hqd hρ.1.ne
    · obtain ⟨i', s, hs, rfl⟩ := mem_iUnion.mp hqb
      have : s = ρ := by rw [← hqd, dist_eq_norm, norm_branchPt_sub _ _ _ hs.1.le]
      subst this
      exact ⟨i', rfl⟩
  refine ⟨r, hr.1, Y, hY, hYK, ?_, ?_, fun ρ hρ => ⟨?_, ?_, ?_, ?_, ?_, ?_⟩⟩
  · -- `C` near `z` lies in the closure of `Y`
    intro w hw
    rw [heqC] at hw
    rcases hw with rfl | hw
    · rw [Metric.mem_closure_iff]
      intro ε hε
      have hρ : min ε r / 2 ∈ Ioo 0 r := ⟨half_pos (lt_min hε hr.1), by linarith [min_le_right ε r, lt_min hε hr.1]⟩
      obtain ⟨y, hyY, hys⟩ := (hYsph _ hρ ▸ (hslice _ hρ (BranchGerms.next i)).2 : (Y ∩ sphere w (min ε r / 2)).Nonempty)
      refine ⟨y, hyY, ?_⟩
      rw [dist_comm, mem_sphere.mp hys]
      linarith [min_le_left ε r, lt_min hε hr.1]
    · obtain ⟨i', s, hs, rfl⟩ := mem_iUnion.mp hw
      have h1 := G.branchPt_mem_closure_sector hord z (BranchGerms.next i) hs
      refine closure_mono hYsec ?_
      rcases hfin2 i' i with rfl | rfl
      · rw [hnn] at h1; exact h1.2
      · exact h1.1
  · -- `Y` is the only tile off `cl x̂` meeting the disc
    rintro Y' hY' hY'K ⟨a, haY', hab'⟩
    obtain ⟨i', hi'⟩ := hint a hab' fun haΓ => (hY'.subset_interiorPts haY').2 haΓ.2
    rcases hfin2 i' i with rfl | rfl
    · exact absurd (hXK (hiX hi')) (hY'K haY')
    · exact hY'.eq_of_mem hY haY' (hYsec hi')
  · -- the disc is `x`, `Y` and `C`
    intro w hw
    have hwr : w ∈ ball z r := ball_subset_ball hρ.2.le hw
    by_cases hwΓ : w ∈ F.Γ
    · have : w ∈ F.Γ ∩ ball z r := ⟨hwΓ, hwr⟩
      rw [hΓC] at this
      exact Or.inr ⟨this.1, hw⟩
    · obtain ⟨i', hi'⟩ := hint w hwr hwΓ
      exact Or.inl (hsecXY i' hi')
  · rw [hXsph ρ hρ]; exact (hslice ρ hρ i).1
  · rw [hXsph ρ hρ]; exact (hslice ρ hρ i).2
  · rw [hYsph ρ hρ]; exact (hslice ρ hρ _).1
  · rw [hYsph ρ hρ]; exact (hslice ρ hρ _).2
  · -- the two points of `C` on the circle interleave with the sectors
    intro q₁ hq₁ q₂ hq₂ hd₁ hd₂ hne'
    obtain ⟨i₁, rfl⟩ := hq ρ hρ q₁ hq₁ hd₁
    obtain ⟨i₂, rfl⟩ := hq ρ hρ q₂ hq₂ hd₂
    have hi12 : i₁ ≠ i₂ := fun h => hne' (by rw [h])
    have hmid : ∀ i', polarPt z ρ ((G.dir i' ρ + G.nextDir i' ρ) / 2) ∈ X ∪ Y := fun i' => by
      have hm : (G.dir i' ρ + G.nextDir i' ρ) / 2 ∈ Ioo (G.dir i' ρ) (G.nextDir i' ρ) :=
        ⟨by linarith [hord ρ hρ i'], by linarith [hord ρ hρ i']⟩
      have : polarPt z ρ ((G.dir i' ρ + G.nextDir i' ρ) / 2) ∈ G.sector z r i' ∩ sphere z ρ := by
        rw [sector_inter_sphere G z hρ i']; exact ⟨_, hm, rfl⟩
      exact hsecXY i' this.1
    have hper : ∀ θ, polarPt z ρ (θ + 2 * π) = polarPt z ρ θ := fun θ => by simp only [polarPt, e_add_two_pi]
    obtain ⟨hn0, hn1⟩ := nextDir_two G ρ
    have h0 := hord ρ hρ 0
    have h1 := hord ρ hρ 1
    rcases hpair i₁ i₂ hi12 with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
    · refine ⟨G.dir 0 ρ, (G.dir 0 ρ + G.nextDir 0 ρ) / 2, G.dir 1 ρ, (G.dir 1 ρ + G.nextDir 1 ρ) / 2, ?_, ?_, ?_, ?_, rfl,
        hmid 0, rfl, hmid 1⟩ <;> linarith
    · refine ⟨G.dir 1 ρ, (G.dir 1 ρ + G.nextDir 1 ρ) / 2, G.dir 0 ρ + 2 * π, (G.dir 0 ρ + G.nextDir 0 ρ) / 2 + 2 * π, ?_, ?_,
        ?_, ?_, rfl, hmid 1, hper _, by rw [hper]; exact hmid 0⟩ <;> linarith

/-- **WALK's C5d: each edge of the port graph of `C = ∂ cl x̂` is an edge of `x` with one outer tile** (FS131-RW2): at the edge's pure point the
local picture (`frontier_fill_regular_local`) gives the tile `y` on the outer side; `y` holds the whole edge in its closure (it is the only
tile off `cl x̂` at each point of the edge off the vertices, `subset_of_isPreconnected_of_locally`), is outer
(`isOuterTile_of_closure_inter`), and at a radius below the pure point's two radii every clause of `IsEdgeOf` holds; the closed disc misses
every other edge; and `y` is the only tile off `cl x̂` whose closure meets the edge off the vertices. -/
theorem exists_edgeOf (hP : F.IsPlaneMap) (x : {T : Set ℂ // F.IsOuterTile T}) {N P : Finset ℂ} {vtx σ : ℂ → ℂ}
    {E : ℂ → Set ℂ} (hG : IsPortGraph (frontier (closure (fill x.1))) N P vtx σ E)
    (hN : ∀ z ∈ frontier (closure (fill x.1)), z ∉ N → IsRegularAt F.Γ z) {d : ℂ} (hd : d ∈ P) :
    ∃ (y : {T : Set ℂ // F.IsOuterTile T}) (p : ℂ) (ρ : ℝ), IsEdgeOf x.1 y.1 (E d) (vtx d) (vtx (σ d)) p ρ ∧ p ∉ N ∧
      y.1 ⊆ (closure (fill x.1))ᶜ ∧ (∀ e ∈ P, e ≠ d → e ≠ σ d → Disjoint (E e) (closedBall p ρ)) ∧
      ∀ w ∈ E d, w ∉ N → ∀ Y : Set ℂ, F.IsTile Y → Y ⊆ (closure (fill x.1))ᶜ → w ∈ closure Y → Y = y.1 := by
  set X := x.1 with hXdef
  have hX := x.2.1
  set K := closure (fill X) with hKdef
  obtain ⟨p, hpE, hpN, ε₀, hε₀, hpure⟩ := hG.pure d hd
  have hpC : p ∈ frontier K := hG.subset d hd hpE
  obtain ⟨r, hr, Y, hY, hYK, hCY, -, hloc⟩ := frontier_fill_regular_local hP hX hpC (hN p hpC hpN)
  set ρ := min ε₀ r / 2 with hρdef
  have hρ0 : 0 < ρ := half_pos (lt_min hε₀ hr)
  have hρε : ρ < ε₀ := by linarith [min_le_left ε₀ r, lt_min hε₀ hr]
  have hρr : ρ < r := by linarith [min_le_right ε₀ r, lt_min hε₀ hr]
  obtain ⟨hEb, happ, E₁, E₂, q₁, q₂, hsplit, hE₁c, hE₁p, hE₂c, hE₂p, hu₁, hw₂, hq₁, hq₂, hq12, hd₁, hd₂⟩ :=
    hpure ρ ⟨hρ0, hρε⟩
  obtain ⟨hball, hXpre, hXne, hYpre, hYne, hθ⟩ := hloc ρ ⟨hρ0, hρr⟩
  -- the tile at a point of the edge off the vertices
  have hsame : ∀ w ∈ E d, w ∉ N → w ∈ closure Y → ∃ r' > 0, frontier K ∩ ball w r' ⊆ closure Y ∧
      ∀ Y' : Set ℂ, F.IsTile Y' → Y' ⊆ Kᶜ → w ∈ closure Y' → Y' = Y := by
    intro w hwE hwN hwY
    obtain ⟨r', hr', Y', hY', hY'K, hCY', huniq', -⟩ := frontier_fill_regular_local hP hX (hG.subset d hd hwE)
      (hN w (hG.subset d hd hwE) hwN)
    have hYY' : Y = Y' := huniq' Y hY hYK ((closure_inter_open_nonempty_iff isOpen_ball).mp ⟨w, hwY, mem_ball_self hr'⟩)
    refine ⟨r', hr', hYY' ▸ hCY', fun Y'' hY'' hY''K hwY'' => ?_⟩
    rw [hYY']
    exact huniq' Y'' hY'' hY''K ((closure_inter_open_nonempty_iff isOpen_ball).mp ⟨w, hwY'', mem_ball_self hr'⟩)
  have hconst : E d \ (N : Set ℂ) ⊆ closure Y :=
    subset_of_isPreconnected_of_locally (hG.isPreconnected_diff d hd) (sdiff_subset.trans (hG.subset d hd)) isClosed_closure
      ⟨p, ⟨hpE, hpN⟩, hCY ⟨hpC, mem_ball_self hr⟩⟩ fun w ⟨⟨hwE, hwN⟩, hwY⟩ => by
        obtain ⟨r', hr', h, -⟩ := hsame w hwE hwN hwY
        exact ⟨r', hr', h⟩
  have hEY : E d ⊆ closure Y := (hG.subset_closure d hd).trans (closure_minimal hconst isClosed_closure)
  have hYout : F.IsOuterTile Y := isOuterTile_of_closure_inter x.2 hY hYK
    ⟨p, frontier_closure_fill_subset hP hX hpC, hEY hpE⟩
  have hEsub : ∀ w ∈ E₁ ∪ E₂, w ∈ E d := fun w hw => (hsplit ▸ hw : w ∈ E d \ ball p ρ).1
  refine ⟨⟨Y, hYout⟩, p, ρ, ?_, hpN, hYK, fun e he h1 h2 => happ e he h1 h2, fun w hwE hwN Y' hY' hY'K hwY' => by
    obtain ⟨-, -, -, h⟩ := hsame w hwE hwN (hconst ⟨hwE, hwN⟩)
    exact h Y' hY' hY'K hwY'⟩
  obtain ⟨θ₁, θ₂, θ₃, θ₄, h12, h23, h34, h41, e1, e2, e3, e4⟩ := hθ q₁ (hG.subset d hd (hEsub q₁ (Or.inl hq₁)))
    q₂ (hG.subset d hd (hEsub q₂ (Or.inr hq₂))) hd₁ hd₂ hq12
  refine ⟨hG.isClosed d hd, (hG.isPreconnected_diff d hd).subset_closure sdiff_subset (hG.subset_closure d hd),
    fun w hw => ⟨frontier_closure_fill_subset hP hX (hG.subset d hd hw), hEY hw⟩, ?_, hG.st_mem d hd, hG.en_mem d hd, hpE,
    hρ0, ?_, hXpre, hXne, hYpre, hYne, E₁, E₂, hsplit, hE₁c, hE₁p, hE₂c, hE₂p, hu₁, hw₂, θ₁, θ₂, θ₃, θ₄, h12, h23, h34, h41,
    e1 ▸ hq₁, e2, e3 ▸ hq₂, e4⟩
  · rw [Set.disjoint_left]
    rintro w hwE (hwX | hwY)
    · exact (hG.subset d hd hwE).2 (interior_maximal ((subset_fill X).trans subset_closure) hX.isOpen hwX)
    · have := frontier_subset_closure (hG.subset d hd hwE)
      rw [isClosed_closure.closure_eq] at this
      exact hYK hwY this
  · intro w hw
    rcases hball hw with h | h
    · exact Or.inl h
    · rw [← hEb] at h
      exact Or.inr h.1

section Trail

variable {α β γ : Type*}

/-- A closed trail read through a map is a closed trail. -/
theorem BasedTrail.map {st en : α → β} {v : β} (g : γ → α) {L : List γ} (hL : BasedTrail (st ∘ g) (en ∘ g) v L) :
    BasedTrail st en v (L.map g) := by
  obtain ⟨hL0, hLc, hLh, hLl⟩ := hL
  refine ⟨by simpa using hL0, (List.isChain_map g).mpr hLc, ?_, ?_⟩
  · rw [List.head_map]; exact hLh
  · rw [List.getLast_map]; exact hLl

/-- **Insertion, repeated** (FS131-RW2, WALK's C10): finitely many new entries, each starting and ending at the start of some entry of a
closed trail, all go in, one at a time (`BasedTrail.insert`). -/
theorem BasedTrail.insert_all {st en : α → β} {v : β} {L : List α} (hL : BasedTrail st en v L) (hnd : L.Nodup) :
    ∀ W : List α, W.Nodup → (∀ w ∈ W, w ∉ L) → (∀ w ∈ W, st w = en w ∧ ∃ e ∈ L, st e = st w) →
      ∃ L', BasedTrail st en v L' ∧ L'.Nodup ∧ ∀ a, a ∈ L' ↔ a ∈ L ∨ a ∈ W
  | [], _, _, _ => ⟨L, hL, hnd, fun a => by simp⟩
  | w :: W, hWnd, hWL, hWst => by
    obtain ⟨hwW, hWnd'⟩ := List.nodup_cons.mp hWnd
    obtain ⟨L₁, hL₁, hnd₁, hmem₁⟩ := BasedTrail.insert_all hL hnd W hWnd' (fun a ha => hWL a (List.mem_cons_of_mem _ ha))
      (fun a ha => hWst a (List.mem_cons_of_mem _ ha))
    obtain ⟨hwse, e, heL, hew⟩ := hWst w List.mem_cons_self
    have heL₁ : e ∈ L₁ := (hmem₁ e).mpr (Or.inl heL)
    have hO : BasedTrail st en (st e) [w] :=
      ⟨List.cons_ne_nil _ _, List.isChain_singleton _, hew.symm, by simp only [List.getLast_singleton]; rw [← hwse, hew]⟩
    obtain ⟨L', hL', hmem', hnd'⟩ := hL₁.insert heL₁ hO
    refine ⟨L', hL', hnd' hnd₁ (List.nodup_singleton w) fun a ha haL₁ => ?_, fun a => ?_⟩
    · rw [List.mem_singleton] at ha
      subst ha
      rcases (hmem₁ a).mp haL₁ with h | h
      · exact hWL a List.mem_cons_self h
      · exact hwW h
    · rw [hmem' a, hmem₁ a, List.mem_singleton, List.mem_cons]
      tauto

end Trail

/-- **WALK's C10, the bookkeeping: a closed trail of entries with the right fields is a boundary walk** (FS131-RW2). Each entry has a tile,
a start and an end in its tile's closure, and possibly an edge from its start to its end; read cyclically, the hinge after an entry is its
end (the next entry's start), the edge entries are those with an edge, a tile listed twice is an edge entry both times, and distinct edge
entries keep their edges off each other's closed discs. -/
theorem isBoundaryWalk_of_trail {x : {T : Set ℂ // F.IsOuterTile T}} {β : Type*} {st en : β → ℂ} {v₀ : ℂ} {L : List β}
    (hL : BasedTrail st en v₀ L) (hnd : L.Nodup) (tile : β → {T : Set ℂ // F.IsOuterTile T}) (isEdge : β → Prop)
    (Ed : β → Set ℂ) (pd : β → ℂ) (ρd : β → ℝ)
    (hst : ∀ c ∈ L, st c ∈ closure (tile c).1) (hen : ∀ c ∈ L, en c ∈ closure (tile c).1)
    (hedge : ∀ c ∈ L, isEdge c → IsEdgeOf x.1 (tile c).1 (Ed c) (st c) (en c) (pd c) (ρd c))
    (hrep : ∀ c ∈ L, ∀ c' ∈ L, c ≠ c' → tile c = tile c' → isEdge c ∧ isEdge c')
    (hapart : ∀ c ∈ L, ∀ c' ∈ L, c ≠ c' → isEdge c → isEdge c' → Disjoint (Ed c') (closedBall (pd c) (ρd c)))
    (hmem : ∀ y, (∃ c ∈ L, tile c = y) ↔ F.filledGraph.Adj x y) :
    ∃ (r : List {T : Set ℂ // F.IsOuterTile T}) (z : ℕ → ℂ) (E : ℕ → Set ℂ) (p : ℕ → ℂ) (ρ : ℕ → ℝ) (edge : ℕ → Prop),
      F.IsBoundaryWalk x r z E p ρ edge := by
  obtain ⟨hL0, hLc, hLh, hLl⟩ := hL
  have hn : 0 < L.length := List.length_pos_iff.mpr hL0
  -- consecutive entries, cyclically: the end of one is the start of the next
  have hcyc : ∀ j c c', L[j]? = some c → L[(j + 1) % L.length]? = some c' → en c = st c' := by
    intro j c c' hc hc'
    obtain ⟨hj, rfl⟩ := List.getElem?_eq_some_iff.mp hc
    by_cases h : j + 1 < L.length
    · rw [Nat.mod_eq_of_lt h] at hc'
      obtain ⟨-, rfl⟩ := List.getElem?_eq_some_iff.mp hc'
      exact List.isChain_iff_getElem.mp hLc j h
    · have hjn : j + 1 = L.length := by omega
      rw [hjn, Nat.mod_self] at hc'
      obtain ⟨-, rfl⟩ := List.getElem?_eq_some_iff.mp hc'
      have e1 : L[j] = L.getLast hL0 := by rw [List.getLast_eq_getElem]; congr 1; omega
      have e2 : L[0] = L.head hL0 := (List.head_eq_getElem hL0).symm
      rw [e1, e2, hLl, hLh]
  have hprev : ∀ j c, L[j]? = some c → (L[(j + L.length - 1) % L.length]?.map en).getD v₀ = st c := by
    intro j c hc
    have hj := (List.getElem?_eq_some_iff.mp hc).1
    have hj' : (j + L.length - 1) % L.length < L.length := Nat.mod_lt _ hn
    have hnext : ((j + L.length - 1) % L.length + 1) % L.length = j := by
      rcases Nat.eq_zero_or_pos j with rfl | hj0
      · rw [show 0 + L.length - 1 = L.length - 1 by omega, Nat.mod_eq_of_lt (show L.length - 1 < L.length by omega),
          show L.length - 1 + 1 = L.length by omega, Nat.mod_self]
      · rw [show j + L.length - 1 = (j - 1) + L.length by omega, Nat.add_mod_right,
          Nat.mod_eq_of_lt (show j - 1 < L.length by omega), show j - 1 + 1 = j by omega, Nat.mod_eq_of_lt hj]
    obtain ⟨c'', hc''⟩ : ∃ c'', L[(j + L.length - 1) % L.length]? = some c'' :=
      ⟨_, List.getElem?_eq_getElem hj'⟩
    rw [hc'']
    exact hcyc _ c'' c hc'' (by rw [hnext]; exact hc)
  have hinj : ∀ (i j : ℕ) (c : β), L[i]? = some c → L[j]? = some c → i = j := by
    intro i j c hi hj
    obtain ⟨hi', rfl⟩ := List.getElem?_eq_some_iff.mp hi
    obtain ⟨hj', hj''⟩ := List.getElem?_eq_some_iff.mp hj
    exact hnd.getElem_inj_iff.mp hj''.symm
  have hmap : ∀ (j : ℕ) (a : {T : Set ℂ // F.IsOuterTile T}), (L.map tile)[j]? = some a → ∃ c, L[j]? = some c ∧ tile c = a := by
    intro j a h
    rw [List.getElem?_map, Option.map_eq_some_iff] at h
    exact h
  refine ⟨L.map tile, fun j => (L[j]?.map en).getD v₀, fun j => (L[j]?.map Ed).getD ∅, fun j => (L[j]?.map pd).getD 0,
    fun j => (L[j]?.map ρd).getD 0, fun j => ∃ c, L[j]? = some c ∧ isEdge c, ⟨fun y => ?_, ?_, ?_, ?_, ?_⟩⟩
  · rw [List.mem_map]; exact hmem y
  · intro j a b ha hb
    obtain ⟨c, hc, rfl⟩ := hmap j a ha
    obtain ⟨c', hc', rfl⟩ := hmap _ b (by rw [List.length_map] at hb; exact hb)
    simp only [hc, Option.map_some, Option.getD_some]
    exact ⟨hen c (List.mem_of_getElem? hc), hcyc j c c' hc hc' ▸ hst c' (List.mem_of_getElem? hc')⟩
  · rintro j a ha ⟨c, hc, hce⟩
    obtain ⟨c', hc', rfl⟩ := hmap j a ha
    rw [hc] at hc'
    cases hc'
    simp only [List.length_map, hc, Option.map_some, Option.getD_some]
    rw [hprev j c hc]
    exact hedge c (List.mem_of_getElem? hc) hce
  · intro i j a hij hi hj
    obtain ⟨c, hc, rfl⟩ := hmap i a hi
    obtain ⟨c', hc', hcc'⟩ := hmap j _ hj
    have hne : c ≠ c' := fun h => hij (hinj i j c hc (h ▸ hc'))
    obtain ⟨h1, h2⟩ := hrep c (List.mem_of_getElem? hc) c' (List.mem_of_getElem? hc') hne hcc'.symm
    exact ⟨⟨c, hc, h1⟩, ⟨c', hc', h2⟩⟩
  · rintro j - ⟨c, hc, hce⟩ i - hij ⟨c', hc', hce'⟩
    simp only [hc, hc', Option.map_some, Option.getD_some]
    have hne : c ≠ c' := fun h => hij (hinj i j c (h ▸ hc') hc)
    exact hapart c (List.mem_of_getElem? hc) c' (List.mem_of_getElem? hc') hne hce hce'

theorem exists_boundaryWalk' (hF : F.Valid) (hP : F.IsPlaneMap) (x : {T : Set ℂ // F.IsOuterTile T}) :
    ∃ (r : List {T : Set ℂ // F.IsOuterTile T}) (z : ℕ → ℂ) (E : ℕ → Set ℂ) (p : ℕ → ℂ) (ρ : ℕ → ℝ) (edge : ℕ → Prop),
      F.IsBoundaryWalk x r z E p ρ edge := by
  classical
  have hX : F.IsTile x.1 := x.2.1
  set K := closure (fill x.1) with hKdef
  set C := frontier K with hCdef
  have hCc : IsCompact C :=
    (isBounded_closure_fill hF hX).isCompact_closure.of_isClosed_subset isClosed_frontier frontier_subset_closure
  have hCpre : IsPreconnected C := isPreconnected_frontier_closure_fill hF hP hX
  obtain ⟨z₀, hz₀⟩ := nonempty_frontier_closure_fill hF hX
  -- the stars and the vertices
  have hstar : ∀ z ∈ C, ∃ d, Even d ∧ 0 < d ∧ HasCurveStar C z d := fun z hz => frontier_fill_hasCurveStar_pos hP hX hz
  choose! n hnev hnpos hnst using hstar
  set N : Finset ℂ := (finite_frontier_fill_nonRegular hF hP hX).toFinset ∪ {z₀} with hNdef
  have hNC : ∀ v ∈ N, v ∈ C := by
    intro v hv
    rcases Finset.mem_union.mp hv with h | h
    · exact ((Set.Finite.mem_toFinset _).mp h).1
    · rw [Finset.mem_singleton.mp h]; exact hz₀
  have hNΓ : ∀ z ∈ C, z ∉ N → IsRegularAt F.Γ z := by
    intro z hz hzN
    by_contra h
    exact hzN (Finset.mem_union_left _ ((Set.Finite.mem_toFinset _).mpr ⟨hz, h⟩))
  have hNreg : ∀ z ∈ C, z ∉ N → IsRegularAt C z := fun z hz hzN => frontier_fill_isRegularAt hP hX hz (hNΓ z hz hzN)
  have hNne : N.Nonempty := ⟨z₀, Finset.mem_union_right _ (Finset.mem_singleton_self _)⟩
  obtain ⟨P, vtx, σ, E, hG⟩ := exists_isPortGraph hCc hCpre hnst hnev hnpos hNne hNC hNreg
  -- each edge is an edge of `x`, with its tile
  have hedge : ∀ d ∈ P, ∃ (y : {T : Set ℂ // F.IsOuterTile T}) (p : ℂ) (ρ : ℝ),
      IsEdgeOf x.1 y.1 (E d) (vtx d) (vtx (σ d)) p ρ ∧ p ∉ N ∧ y.1 ⊆ Kᶜ ∧
      (∀ e ∈ P, e ≠ d → e ≠ σ d → Disjoint (E e) (closedBall p ρ)) ∧
      ∀ w ∈ E d, w ∉ N → ∀ Y : Set ℂ, F.IsTile Y → Y ⊆ Kᶜ → w ∈ closure Y → Y = y.1 :=
    fun d hd => exists_edgeOf hP x hG hNΓ hd
  choose ty tp tρ hty htpN htyK htap htuniq using hedge
  -- the Euler circuit of the port graph
  have hσinv : Function.Involutive (fun a : {d // d ∈ P} => (⟨σ a.1, hG.σ_mem a.1 a.2⟩ : {d // d ∈ P})) :=
    fun a => Subtype.ext (hG.σ_σ a.1 a.2)
  have hevf : ∀ b, Even (P.filter fun a => vtx a = b).card := by
    intro b
    by_cases hb : b ∈ N
    · exact hG.even b hb
    · rw [Finset.filter_eq_empty_iff.mpr fun a ha h => hb (by rw [← h]; exact hG.vtx_mem a ha)]
      exact ⟨0, rfl⟩
  obtain ⟨fA, hfA⟩ := exists_vertex_involution vtx P hevf
  have hAinv : Function.Involutive (fun a : {d // d ∈ P} => (⟨fA a.1, (hfA a.1 a.2).1⟩ : {d // d ∈ P})) :=
    fun a => Subtype.ext (hfA a.1 a.2).2.1
  set σ' := hσinv.toPerm _ with hσ'
  set πA := hAinv.toPerm _ with hπA
  have hconn : ∀ S : Finset {d // d ∈ P}, (∀ a ∈ S, σ' a ∈ S) → S.Nonempty → (∃ a, a ∉ S) →
      ∃ a ∈ S, ∃ b ∉ S, vtx a.1 = vtx b.1 := by
    intro S hSσ hSne ⟨a₁, ha₁⟩
    have hmapS : ∀ d, d ∈ S.map (Function.Embedding.subtype _) ↔ ∃ h : d ∈ P, (⟨d, h⟩ : {d // d ∈ P}) ∈ S := by
      intro d
      simp only [Finset.mem_map, Function.Embedding.coe_subtype]
      constructor
      · rintro ⟨a, ha, rfl⟩; exact ⟨a.2, ha⟩
      · rintro ⟨h, hS⟩; exact ⟨_, hS, rfl⟩
    obtain ⟨a, ha, b, hb, hbS, hab⟩ := hG.exists_shared_vertex hCpre (S.map (Function.Embedding.subtype _))
      (fun d hd => ((hmapS d).mp hd).1)
      (fun d hd => by
        obtain ⟨h, hS⟩ := (hmapS d).mp hd
        exact (hmapS _).mpr ⟨hG.σ_mem d h, hSσ _ hS⟩)
      (by obtain ⟨a, ha⟩ := hSne; exact ⟨a.1, (hmapS _).mpr ⟨a.2, ha⟩⟩)
      ⟨a₁.1, a₁.2, fun h => ha₁ (by obtain ⟨_, hS⟩ := (hmapS _).mp h; exact hS)⟩
    obtain ⟨ha', haS⟩ := (hmapS a).mp ha
    exact ⟨⟨a, ha'⟩, haS, ⟨b, hb⟩, fun h => hbS ((hmapS b).mpr ⟨hb, h⟩), hab⟩
  obtain ⟨v₁, hv₁⟩ := hNne
  obtain ⟨d₀, hd₀, -⟩ := hG.exists_port v₁ hv₁
  obtain ⟨L, hLt, hLnd, hLcov, hLσ⟩ := exists_euler σ' πA (fun a => vtx a.1) (fun a => hσinv a)
    (fun a h => hG.σ_ne a.1 a.2 (congrArg Subtype.val h)) (fun a => hAinv a)
    (fun a h => (hfA a.1 a.2).2.2.1 (congrArg Subtype.val h)) (fun a => (hfA a.1 a.2).2.2.2) hconn ⟨d₀, hd₀⟩
  -- the neighbours meeting `C` only at vertices, each at one of its vertices
  have hfin := filledGraph_locallyFinite hF hP x
  have hvy : ∀ y, F.filledGraph.Adj x y → ∃ w ∈ C, w ∈ closure y.1 := by
    intro y hy
    obtain ⟨hne, w, hwx, hwy⟩ := (filledGraph_adj_iff hP).mp hy
    exact ⟨w, closure_inter_subset_frontier_fill hX y.2 (fun h => hne (Subtype.ext h).symm) ⟨hwx, hwy⟩, hwy⟩
  choose! vy hvyC hvycl using hvy
  set W : List {T : Set ℂ // F.IsOuterTile T} :=
    (hfin.toFinset.filter fun y => ∀ w ∈ C, w ∈ closure y.1 → w ∈ N).toList with hWdef
  have hmemW : ∀ y, y ∈ W ↔ F.filledGraph.Adj x y ∧ ∀ w ∈ C, w ∈ closure y.1 → w ∈ N := by
    intro y
    simp only [hWdef, Finset.mem_toList, Finset.mem_filter, Set.Finite.mem_toFinset, SimpleGraph.mem_neighborSet]
  -- the entries: the circuit's edges, then the vertex-only neighbours
  set st : {d // d ∈ P} ⊕ {T : Set ℂ // F.IsOuterTile T} → ℂ := Sum.elim (fun a => vtx a.1) vy with hst
  set en : {d // d ∈ P} ⊕ {T : Set ℂ // F.IsOuterTile T} → ℂ := Sum.elim (fun a => vtx (σ a.1)) vy with hen
  have hL0 : BasedTrail st en (vtx d₀) (L.map Sum.inl) := BasedTrail.map Sum.inl hLt
  obtain ⟨L', hL't, hL'nd, hL'mem⟩ := hL0.insert_all (hLnd.map Sum.inl_injective) (W.map Sum.inr)
    ((Finset.nodup_toList _).map Sum.inr_injective)
    (fun c hc hcL => by
      obtain ⟨y, -, rfl⟩ := List.mem_map.mp hc
      obtain ⟨a, -, ha⟩ := List.mem_map.mp hcL
      exact Sum.inl_ne_inr ha)
    (fun c hc => by
      obtain ⟨y, hy, rfl⟩ := List.mem_map.mp hc
      obtain ⟨hyadj, hyN⟩ := (hmemW y).mp hy
      have hvN : vy y ∈ N := hyN _ (hvyC y hyadj) (hvycl y hyadj)
      obtain ⟨d, hd, hdv⟩ := hG.exists_port _ hvN
      refine ⟨rfl, ?_⟩
      rcases hLcov ⟨d, hd⟩ with h | h
      · exact ⟨Sum.inl ⟨d, hd⟩, List.mem_map_of_mem h, hdv⟩
      · obtain ⟨e, heL, he⟩ := hLt.exists_start h
        refine ⟨Sum.inl e, List.mem_map_of_mem heL, ?_⟩
        show vtx e.1 = vy y
        rw [he, ← hdv]
        show vtx (σ (σ d)) = vtx d
        rw [hG.σ_σ d hd])
  have hinl : ∀ a, Sum.inl a ∈ L' → a ∈ L := fun a h => by
    rcases (hL'mem _).mp h with h | h
    · obtain ⟨a', ha', he⟩ := List.mem_map.mp h
      exact Sum.inl_injective he ▸ ha'
    · obtain ⟨y, -, he⟩ := List.mem_map.mp h
      exact absurd he Sum.inr_ne_inl
  have hinr : ∀ y, Sum.inr y ∈ L' → y ∈ W := fun y h => by
    rcases (hL'mem _).mp h with h | h
    · obtain ⟨a', -, he⟩ := List.mem_map.mp h
      exact absurd he Sum.inl_ne_inr
    · obtain ⟨y', hy', he⟩ := List.mem_map.mp h
      exact Sum.inr_injective he ▸ hy'
  have hxy : ∀ y : {T : Set ℂ // F.IsOuterTile T}, y.1 ⊆ Kᶜ → x ≠ y := fun y hy h => by
    obtain ⟨a, ha⟩ := hX.nonempty
    exact hy (h ▸ ha) (subset_closure (Or.inl ha))
  refine isBoundaryWalk_of_trail hL't hL'nd (Sum.elim (fun a => ty a.1 a.2) id) (fun c => ∃ a, c = Sum.inl a)
    (Sum.elim (fun a => E a.1) fun _ => ∅) (Sum.elim (fun a => tp a.1 a.2) fun _ => 0) (Sum.elim (fun a => tρ a.1 a.2) fun _ => 0)
    ?_ ?_ ?_ ?_ ?_ ?_
  · rintro (a | y) hc
    · exact ((hty a.1 a.2).2.2.1 (hG.st_mem a.1 a.2)).2
    · exact hvycl y ((hmemW y).mp (hinr y hc)).1
  · rintro (a | y) hc
    · exact ((hty a.1 a.2).2.2.1 (hG.en_mem a.1 a.2)).2
    · exact hvycl y ((hmemW y).mp (hinr y hc)).1
  · rintro (a | y) hc ⟨a', ha'⟩
    · exact hty a.1 a.2
    · exact absurd ha' Sum.inr_ne_inl
  · have hvo : ∀ a : {d // d ∈ P}, ∀ y, y ∈ W → ty a.1 a.2 ≠ y := fun a y hy h => by
      have hpE := (hty a.1 a.2).2.2.2.2.2.2.1
      exact htpN a.1 a.2 (((hmemW y).mp hy).2 _ (hG.subset a.1 a.2 hpE) (by rw [← h]; exact ((hty a.1 a.2).2.2.1 hpE).2))
    rintro (a | y) hc (a' | y') hc' hne htile
    · exact ⟨⟨a, rfl⟩, ⟨a', rfl⟩⟩
    · exact absurd htile (hvo a y' (hinr y' hc'))
    · exact absurd htile.symm (hvo a' y (hinr y hc))
    · exact absurd (congrArg Sum.inr htile) hne
  · rintro (a | y) hc (a' | y') hc' hne ⟨b, hb⟩ ⟨b', hb'⟩
    · have haa' : a' ≠ a := fun h => hne (by rw [h])
      refine htap a.1 a.2 a'.1 a'.2 (fun h => haa' (Subtype.ext h)) fun h => ?_
      have : a' = σ' a := Subtype.ext h
      exact hLσ a (hinl a hc) (this ▸ hinl a' hc')
    · exact absurd hb' Sum.inr_ne_inl
    · exact absurd hb Sum.inr_ne_inl
    · exact absurd hb Sum.inr_ne_inl
  · intro y
    constructor
    · rintro ⟨(a | y'), hc, rfl⟩
      · exact (filledGraph_adj_iff hP).mpr ⟨hxy _ (htyK a.1 a.2), tp a.1 a.2, (hty a.1 a.2).2.2.1 (hty a.1 a.2).2.2.2.2.2.2.1⟩
      · exact ((hmemW y').mp (hinr y' hc)).1
    · intro hy
      by_cases h : ∃ w ∈ C, w ∈ closure y.1 ∧ w ∉ N
      · obtain ⟨w, hwC, hwy, hwN⟩ := h
        obtain ⟨d, hd, hwE⟩ := hG.cover w hwC
        have hyK : y.1 ⊆ Kᶜ := fun a ha haK =>
          Set.disjoint_left.mp (IsOuterTile.disjoint_closure_fill hX y.2 fun h => hy.1 (Subtype.ext h).symm) ha haK
        rcases hLcov ⟨d, hd⟩ with hL | hL
        · refine ⟨Sum.inl ⟨d, hd⟩, (hL'mem _).mpr (Or.inl (List.mem_map_of_mem hL)), ?_⟩
          exact Subtype.ext (htuniq d hd w hwE hwN y.1 y.2.1 hyK hwy).symm
        · refine ⟨Sum.inl (σ' ⟨d, hd⟩), (hL'mem _).mpr (Or.inl (List.mem_map_of_mem hL)), ?_⟩
          have hwE' : w ∈ E (σ d) := by rw [hG.E_σ d hd]; exact hwE
          exact Subtype.ext (htuniq (σ d) (hG.σ_mem d hd) w hwE' hwN y.1 y.2.1 hyK hwy).symm
      · push Not at h
        exact ⟨Sum.inr y, (hL'mem _).mpr (Or.inr (List.mem_map_of_mem ((hmemW y).mpr ⟨hy, h⟩))), rfl⟩

end ArcMap

end HadwigerNelson.Plane
