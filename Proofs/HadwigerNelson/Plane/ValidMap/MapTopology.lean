import Proofs.HadwigerNelson.Plane.ValidMap.HexRing
import Proofs.HadwigerNelson.Plane.Tiles
import Proofs.HadwigerNelson.Plane.PlaneTopology
import Proofs.HadwigerNelson.Plane.CurveGraph
import Mathlib.Analysis.Normed.Module.Connected

/-!
# The plane topology of a map: tiles in complementary components, the outermost tile, the rim, the common boundary of two tiles

The map-level half of wave 5's planar infrastructure (job FS131-KP, `plans/FS131-planar-kernel-plan.md` § 3), over `Plane/PlaneTopology`
(unicoherence and its corollaries) and `Plane/LocalStructure` (`finite_tiles_near`, `dense_interiorPts`, `mem_closure_tile`, sector charts).
Upstream of `MapGraph` (the `cvb_*` leaves), `BaseWalk` (`retArcs_nested`, `exists_endpoint`, `exists_eleventh`) and `BaseDense`
(`exists_unenclosed_or_bad`).

* **A — tiles and complementary components**: a tile other than `T` lies in `(cl T)ᶜ`, on one side of any separation; every open set of the
  domain meets a tile; a closure point of an open set is a closure point of a tile meeting it; inside an open preconnected set the tiles are
  chained by touching closures (`mem_of_touch_closed`); finitely many tiles have closures meeting a compact set.
* **B — the outer domain and the outermost tile** (FS131-E4 E4-OUTERMOST): `outerDom T`, `EnclosesTile`; the outermost tile in `B̄(x, 1)`;
  two outer tiles meeting on its rim; the rim vertex cubic trichromatic and un-enclosed.
* **C — the rim of `u`'s component** (FS131-E4 E4-RIM, the eleventh point): Lemma H(a); the tiles of `u`'s colours meeting `B(u, 1)`; the
  assembly `exists_eleventh_of`.
* **D — the common boundary of two tiles in a disc, and arcs of a circle**: `exists_far_end` (the handshake on the finite boundary graph),
  `ringArc_cases` (two short arcs of one circle are disjoint, nested, interleaved, or abut).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Germs near their vertex: the cyclic order, and the far side of a sector -/

namespace BranchGerms

variable {n : ℕ}

/-- **Near the vertex the germs are strictly ordered**: for sorted germs that are graphs over the radius out to `r₀`, at every small distance
each germ's direction lies strictly below the next one's (a gap in direction persists by continuity; germs of one direction are ordered by
curvature at every distance). -/
theorem eventually_dir_lt_nextDir (G : BranchGerms n) (hS : G.Sorted) {r₀ : ℝ} (hr₀ : 0 < r₀) (hcurv : ∀ i, |G.κ i| * r₀ < 2) :
    ∀ᶠ s in 𝓝[>] (0 : ℝ), ∀ i, G.dir i s < G.nextDir i s := by
  rw [eventually_all]
  intro i
  rcases hS.2 i with hlt | ⟨heq, hκ⟩
  · have hlim : Tendsto (fun s => G.nextDir i s - G.dir i s) (𝓝 0) (𝓝 (G.nextβ i - G.β i)) := by
      have h := ((G.continuous_nextDir i).sub (G.continuous_dir i)).tendsto 0
      have h0 : (G.nextDir i - G.dir i) 0 = G.nextβ i - G.β i := by simp [nextDir, dir]
      rw [h0] at h
      exact h
    filter_upwards [(hlim.eventually_const_lt (show (0 : ℝ) < G.nextβ i - G.β i by linarith)).filter_mono
      nhdsWithin_le_nhds] with s hs
    linarith
  · filter_upwards [Ioo_mem_nhdsGT hr₀] with s hs
    have hb : ∀ κ : ℝ, |κ| * r₀ < 2 → -1 ≤ κ * s / 2 ∧ κ * s / 2 ≤ 1 := by
      intro κ hκr
      have h2 : |κ * s| ≤ |κ| * r₀ := by
        rw [abs_mul, abs_of_pos hs.1]; exact mul_le_mul_of_nonneg_left hs.2.le (abs_nonneg _)
      constructor <;> cases abs_le.mp (h2.trans hκr.le) <;> linarith
    have hnext : |G.nextκ i| * r₀ < 2 := by unfold nextκ; split_ifs <;> exact hcurv _
    have hlt : G.κ i * s / 2 < G.nextκ i * s / 2 := by
      have := mul_lt_mul_of_pos_right hκ hs.1; linarith
    have := Real.arcsin_lt_arcsin (hb _ (hcurv i)).1 hlt (hb _ hnext).2
    simp only [nextDir, dir, germDir, heq]
    linarith

/-- `next` is injective: the germ after `i` determines `i`. -/
theorem next_injective : Function.Injective (next : Fin n → Fin n) := by
  intro i j h
  unfold next at h
  split_ifs at h with hi hj hj <;> simp only [Fin.ext_iff] at h <;> ext <;> omega

/-- **The directions at one distance increase with the index**, where consecutive ones do. -/
theorem dir_lt_dir (G : BranchGerms n) {s : ℝ} (hs : ∀ i, G.dir i s < G.nextDir i s) {i j : Fin n} (hij : i < j) :
    G.dir i s < G.dir j s := by
  obtain ⟨i, hi⟩ := i
  obtain ⟨j, hj⟩ := j
  have hij' : i < j := hij
  clear hij
  induction j with
  | zero => omega
  | succ j ih =>
    have hstep : G.dir ⟨j, by omega⟩ s < G.dir ⟨j + 1, hj⟩ s := by
      have := hs ⟨j, by omega⟩
      rw [nextDir_eq] at this
      simpa only [hj, dite_true] using this
    rcases Nat.lt_succ_iff_lt_or_eq.mp hij' with h | h
    · exact (ih (by omega) h).trans hstep
    · subst h; exact hstep

/-- The weak form of `dir_lt_dir`. -/
theorem dir_le_dir (G : BranchGerms n) {s : ℝ} (hs : ∀ i, G.dir i s < G.nextDir i s) {i j : Fin n} (hij : i ≤ j) :
    G.dir i s ≤ G.dir j s := by
  rcases eq_or_lt_of_le hij with rfl | h
  · exact le_rfl
  · exact (G.dir_lt_dir hs h).le

/-- **Every direction at one distance lies below the first one turn on**, where consecutive ones increase. -/
theorem dir_lt_dir_zero_add (G : BranchGerms n) {s : ℝ} (hs : ∀ i, G.dir i s < G.nextDir i s) (j : Fin n) :
    G.dir j s < G.dir ⟨0, j.pos⟩ s + 2 * π := by
  have hlast := hs ⟨n - 1, by have := j.pos; omega⟩
  rw [nextDir_eq] at hlast
  simp only [show ¬ (n - 1 + 1 < n) by have := j.pos; omega, dite_false] at hlast
  exact (G.dir_le_dir hs (show j ≤ ⟨n - 1, _⟩ from Fin.mk_le_mk.mpr (by have := j.is_lt; omega))).trans_lt hlast

/-- **The far side of a sector**: where the germs (at least two) are strictly ordered, the sectors other than sector `k`, and the branch points
of the germs other than `k`'s two, lie in one open connected subset of `B(v, ρ)` missing sector `k` — the second sector of the two-germ chart
of `k`'s bounding germs. -/
theorem exists_far_side (G : BranchGerms n) (hn : 2 ≤ n) {ρ : ℝ} (hord : ∀ s ∈ Ioo 0 ρ, ∀ i, G.dir i s < G.nextDir i s)
    (v : ℂ) (k : Fin n) : ∃ O : Set ℂ, IsOpen O ∧ IsPreconnected O ∧ O ⊆ ball v ρ ∧ Disjoint O (G.sector v ρ k) ∧
      (∀ j, j ≠ k → G.sector v ρ j ⊆ O) ∧
      ∀ m, m ≠ k → m ≠ next k → ∀ s ∈ Ioo 0 ρ, branchPt v (G.β m) (G.κ m) s ∈ O := by
  have hπ := Real.pi_pos
  set G2 : BranchGerms 2 := ⟨![G.β k, G.nextβ k], ![G.κ k, G.nextκ k]⟩ with hG2
  have hd0 : ∀ s, G2.dir 0 s = G.dir k s := fun s => rfl
  have hn0 : ∀ s, G2.nextDir 0 s = G.nextDir k s := fun s => rfl
  have hd1 : ∀ s, G2.dir 1 s = G.nextDir k s := fun s => rfl
  have hn1 : ∀ s, G2.nextDir 1 s = G.dir k s + 2 * π := fun s => by
    show germDir (G.β k + 2 * π) (G.κ k) s = _
    rw [germDir_add_two_pi]; rfl
  have hs0 : G2.sector v ρ 0 = G.sector v ρ k := rfl
  set z0 : Fin n := ⟨0, by omega⟩ with hz0
  -- the angular facts at one distance
  have hnk : ∀ s, G.nextDir k s = if h : k.val + 1 < n then G.dir ⟨k.val + 1, h⟩ s else G.dir z0 s + 2 * π := fun s =>
    G.nextDir_eq k s
  have hnext_k : next k = if h : k.val + 1 < n then ⟨k.val + 1, h⟩ else z0 := rfl
  have hord2 : ∀ s ∈ Ioo 0 ρ, ∀ i, G2.dir i s < G2.nextDir i s := by
    intro s hs i
    have hlt : ∀ {i j : Fin n}, i < j → G.dir i s < G.dir j s := fun h => G.dir_lt_dir (hord s hs) h
    have hle : ∀ {i j : Fin n}, i ≤ j → G.dir i s ≤ G.dir j s := fun h => G.dir_le_dir (hord s hs) h
    have htop := G.dir_lt_dir_zero_add (hord s hs)
    rcases (by decide : ∀ i : Fin 2, i = 0 ∨ i = 1) i with rfl | rfl
    · rw [hd0, hn0]; exact hord s hs k
    · rw [hd1, hn1, hnk]
      split_ifs with h
      · have := htop ⟨k.val + 1, h⟩
        have := hle (show z0 ≤ k from Fin.mk_le_mk.mpr (Nat.zero_le _))
        linarith
      · have := hlt (show z0 < k from Fin.mk_lt_mk.mpr (by omega))
        linarith
  refine ⟨G2.sector v ρ 1, G2.isOpen_sector ρ 1, G2.isPreconnected_sector hord2 le_rfl 1, G2.sector_subset_ball 1,
    hs0 ▸ G2.sector_disjoint hord2 le_rfl (by decide), ?_, ?_⟩
  · intro j hj z hz
    obtain ⟨s, hs, φ, hφ, rfl⟩ := hz
    refine ⟨s, hs, ?_⟩
    show ∃ φ' ∈ Ioo (G2.dir 1 s) (G2.nextDir 1 s), _ = _
    rw [hd1, hn1]
    have hφ' : φ ∈ Ioo (G.dir j s) (G.nextDir j s) := hφ
    have hlt : ∀ {i j : Fin n}, i < j → G.dir i s < G.dir j s := fun h => G.dir_lt_dir (hord s hs) h
    have hle : ∀ {i j : Fin n}, i ≤ j → G.dir i s ≤ G.dir j s := fun h => G.dir_le_dir (hord s hs) h
    have htop := G.dir_lt_dir_zero_add (hord s hs)
    have hnj := G.nextDir_eq j s
    have h0k := hle (show z0 ≤ k from Fin.mk_le_mk.mpr (Nat.zero_le _))
    have h0j := hle (show z0 ≤ j from Fin.mk_le_mk.mpr (Nat.zero_le _))
    rcases lt_or_gt_of_ne hj with hjk | hjk
    · -- `j < k`: one turn on
      refine ⟨φ + 2 * π, ⟨?_, ?_⟩, by rw [e_add_two_pi]⟩
      · rw [hnk]; split_ifs with h
        · linarith [htop ⟨k.val + 1, h⟩, hφ'.1]
        · linarith [hφ'.1]
      · have hj1 : j.val + 1 < n := by have := k.is_lt; have : j.val < k.val := hjk; omega
        rw [hnj, dif_pos hj1] at hφ'
        have := hle (show (⟨j.val + 1, hj1⟩ : Fin n) ≤ k from Fin.mk_le_mk.mpr hjk)
        linarith [hφ'.2]
    · -- `k < j`
      refine ⟨φ, ⟨?_, ?_⟩, rfl⟩
      · have hk1 : k.val + 1 < n := by have := j.is_lt; have : k.val < j.val := hjk; omega
        rw [hnk, dif_pos hk1]
        have := hle (show (⟨k.val + 1, hk1⟩ : Fin n) ≤ j from Fin.mk_le_mk.mpr hjk)
        linarith [hφ'.1]
      · rw [hnj] at hφ'
        split_ifs at hφ' with h
        · linarith [htop ⟨j.val + 1, h⟩, hφ'.2]
        · linarith [hφ'.2]
  · intro m hmk hmn s hs
    refine ⟨s, hs, ?_⟩
    show ∃ φ' ∈ Ioo (G2.dir 1 s) (G2.nextDir 1 s), _ = _
    rw [hd1, hn1]
    have hlt : ∀ {i j : Fin n}, i < j → G.dir i s < G.dir j s := fun h => G.dir_lt_dir (hord s hs) h
    have hle : ∀ {i j : Fin n}, i ≤ j → G.dir i s ≤ G.dir j s := fun h => G.dir_le_dir (hord s hs) h
    have htop := G.dir_lt_dir_zero_add (hord s hs)
    rcases lt_or_gt_of_ne hmk with hmk' | hmk'
    · -- `m < k`: one turn on
      refine ⟨G.dir m s + 2 * π, ⟨?_, by linarith [hlt hmk']⟩, by rw [e_add_two_pi]; rfl⟩
      rw [hnk]; split_ifs with h
      · linarith [htop ⟨k.val + 1, h⟩, hle (show z0 ≤ m from Fin.mk_le_mk.mpr (Nat.zero_le _))]
      · have hm0 : m ≠ z0 := by rw [hnext_k, dif_neg h] at hmn; exact hmn
        have : z0 < m := Fin.mk_lt_mk.mpr (by
          have : m.val ≠ 0 := fun h0 => hm0 (Fin.ext h0)
          omega)
        linarith [hlt this]
    · -- `k < m`
      have hk1 : k.val + 1 < n := by have := m.is_lt; have : k.val < m.val := hmk'; omega
      have hm2 : k.val + 1 < m.val := by
        rw [hnext_k, dif_pos hk1] at hmn
        have : m.val ≠ k.val + 1 := fun h => hmn (Fin.ext h)
        have : k.val < m.val := hmk'
        omega
      refine ⟨G.dir m s, ⟨?_, ?_⟩, rfl⟩
      · rw [hnk, dif_pos hk1]; exact hlt (Fin.mk_lt_mk.mpr hm2)
      · linarith [htop m, hle (show z0 ≤ k from Fin.mk_le_mk.mpr (Nat.zero_le _))]

/-- **Branch points are closure points of the sectors they bound**: at a distance where the germs are strictly ordered, the point of germ `i`
lies in the closure of sector `i`, and the point of the germ after `i` in the closure of sector `i` too. -/
theorem branchPt_mem_closure_sector (G : BranchGerms n) {ρ : ℝ} (hord : ∀ s ∈ Ioo 0 ρ, ∀ i, G.dir i s < G.nextDir i s) (v : ℂ)
    (i : Fin n) {s : ℝ} (hs : s ∈ Ioo 0 ρ) :
    branchPt v (G.β i) (G.κ i) s ∈ closure (G.sector v ρ i) ∧
      branchPt v (G.β (next i)) (G.κ (next i)) s ∈ closure (G.sector v ρ i) := by
  have hgap := hord s hs i
  have hmem : ∀ φ ∈ Ioo (G.dir i s) (G.nextDir i s), v + (s : ℂ) * e φ ∈ G.sector v ρ i := fun φ hφ => ⟨s, hs, φ, hφ, rfl⟩
  have hcont : Continuous fun φ : ℝ => v + (s : ℂ) * e φ := by unfold e; fun_prop
  constructor
  · refine mem_closure_of_tendsto ((hcont.tendsto (G.dir i s)).mono_left (nhdsWithin_le_nhds (s := Ioi (G.dir i s)))) ?_
    filter_upwards [Ioo_mem_nhdsGT hgap] with φ hφ
    exact hmem φ hφ
  · have hpt : branchPt v (G.β (next i)) (G.κ (next i)) s = v + (s : ℂ) * e (G.nextDir i s) := by
      rw [branchPt_eq, e_nextDir]; rfl
    rw [hpt]
    refine mem_closure_of_tendsto ((hcont.tendsto (G.nextDir i s)).mono_left (nhdsWithin_le_nhds (s := Iio (G.nextDir i s)))) ?_
    filter_upwards [Ioo_mem_nhdsLT hgap] with φ hφ
    exact hmem φ hφ

/-- **A branch point touches only the two sectors its germ bounds** (at least two germs, strictly ordered): if the point of germ `m` lies in
the closure of sector `k`, then `k = m` or the germ after `k` is `m` (`exists_far_side`). -/
theorem eq_or_next_eq_of_mem_closure_sector (G : BranchGerms n) (hn : 2 ≤ n) {ρ : ℝ}
    (hord : ∀ s ∈ Ioo 0 ρ, ∀ i, G.dir i s < G.nextDir i s) (v : ℂ) {m k : Fin n} {s : ℝ} (hs : s ∈ Ioo 0 ρ)
    (h : branchPt v (G.β m) (G.κ m) s ∈ closure (G.sector v ρ k)) : k = m ∨ next k = m := by
  by_contra hc
  push Not at hc
  obtain ⟨O, hOo, -, -, hOd, -, hOm⟩ := G.exists_far_side hn hord v k
  exact Set.disjoint_left.mp (hOd.closure_right hOo) (hOm m (Ne.symm hc.1) (Ne.symm hc.2) s hs) h

-- The straight three-germ chart (directions `0`, `2π/3`, `4π/3`) is strictly ordered at every distance: a model of `exists_far_side`'s
-- hypothesis `hord`, at every `ρ`.
example : ∀ s : ℝ, ∀ i, (⟨![0, 2 * π / 3, 4 * π / 3], ![0, 0, 0]⟩ : BranchGerms 3).dir i s <
    (⟨![0, 2 * π / 3, 4 * π / 3], ![0, 0, 0]⟩ : BranchGerms 3).nextDir i s := by
  intro s i
  have hπ := Real.pi_pos
  fin_cases i <;> simp [dir, nextDir, germDir, nextβ, nextκ] <;> linarith

end BranchGerms

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## A — tiles and complementary components -/

/-- A tile other than `T` lies off `T`'s closure (it is open and disjoint from `T`). -/
theorem IsTile.subset_compl_closure {T T' : Set ℂ} (hT : F.IsTile T) (hT' : F.IsTile T') (hne : T' ≠ T) : T' ⊆ (closure T)ᶜ := by
  have hdisj : Disjoint T' T := by
    rw [Set.disjoint_left]
    intro w hw' hw
    exact hne (hT'.eq_of_mem hT hw' hw)
  exact (hdisj.closure_right hT'.isOpen).subset_compl_right

/-- A tile inside the union of two sets with disjoint closures lies inside one of them (it is preconnected). -/
theorem IsTile.subset_or_subset_of_separated {T A B : Set ℂ} (hT : F.IsTile T) (hsep : Disjoint (closure A) (closure B))
    (hcov : T ⊆ A ∪ B) : T ⊆ A ∨ T ⊆ B := by
  by_contra h
  push Not at h
  obtain ⟨⟨a, haT, haA⟩, ⟨b, hbT, hbB⟩⟩ : (T ∩ Aᶜ).Nonempty ∧ (T ∩ Bᶜ).Nonempty :=
    ⟨Set.not_subset.mp h.1 |>.imp fun x hx => ⟨hx.1, hx.2⟩, Set.not_subset.mp h.2 |>.imp fun x hx => ⟨hx.1, hx.2⟩⟩
  have hbA : b ∈ closure A := subset_closure ((hcov hbT).resolve_right hbB)
  have haB : a ∈ closure B := subset_closure ((hcov haT).resolve_left haA)
  obtain ⟨w, -, hwA, hwB⟩ := isPreconnected_closed_iff.mp hT.isPreconnected _ _ isClosed_closure isClosed_closure
    (fun x hx => (hcov hx).imp (fun h => subset_closure h) (fun h => subset_closure h)) ⟨b, hbT, hbA⟩ ⟨a, haT, haB⟩
  exact Set.disjoint_left.mp hsep hwA hwB

/-- Every nonempty open subset of the domain meets a tile (`dense_interiorPts`). -/
theorem exists_tile_inter_of_isOpen {U : Set ℂ} (hU : IsOpen U) (hUd : U ⊆ F.dom) (hne : U.Nonempty) :
    ∃ T, F.IsTile T ∧ (T ∩ U).Nonempty := by
  obtain ⟨z, hz⟩ := hne
  obtain ⟨w, hwU, hw⟩ := mem_closure_iff.mp (F.dense_interiorPts (hUd hz)) U hU hz
  exact ⟨connectedComponentIn F.interiorPts w, ⟨w, hw, rfl⟩, w, mem_connectedComponentIn hw, hwU⟩

/-- **Tile closures are locally finite**: a closure point in the domain of the union of the closures of any family of tiles is a closure
point of one of them (`finite_tiles_near`: near `z` only finitely many tiles, and a tile missing `B(z, r)` has its closure missing it). -/
theorem exists_mem_closure_of_mem_closure_biUnion {S : Set (Set ℂ)} (hS : ∀ T ∈ S, F.IsTile T) {z : ℂ} (hz : z ∈ F.dom)
    (hzS : z ∈ closure (⋃ T ∈ S, closure T)) : ∃ T ∈ S, z ∈ closure T := by
  obtain ⟨r, hr, hfin⟩ := F.finite_tiles_near hz
  by_contra hno
  push Not at hno
  have hfin' : {T | T ∈ S ∧ (T ∩ ball z r).Nonempty}.Finite := hfin.subset fun T hT => ⟨hS T hT.1, hT.2⟩
  have hcl : IsClosed (⋃ T ∈ {T | T ∈ S ∧ (T ∩ ball z r).Nonempty}, closure T) :=
    hfin'.isClosed_biUnion fun _ _ => isClosed_closure
  have hzn : z ∉ ⋃ T ∈ {T | T ∈ S ∧ (T ∩ ball z r).Nonempty}, closure T := by
    simp only [mem_iUnion₂]
    rintro ⟨T, hT, hzT⟩
    exact hno T hT.1 hzT
  have hnhds : ball z r ∩ (⋃ T ∈ {T | T ∈ S ∧ (T ∩ ball z r).Nonempty}, closure T)ᶜ ∈ 𝓝 z :=
    inter_mem (ball_mem_nhds z hr) (hcl.isOpen_compl.mem_nhds hzn)
  obtain ⟨w, ⟨hwb, hwn⟩, hwS⟩ := mem_closure_iff_nhds.mp hzS _ hnhds
  obtain ⟨T, hT, hwT⟩ := mem_iUnion₂.mp hwS
  by_cases hTb : (T ∩ ball z r).Nonempty
  · exact hwn (mem_iUnion₂.mpr ⟨T, ⟨hT, hTb⟩, hwT⟩)
  · exact hTb ((closure_inter_open_nonempty_iff isOpen_ball).mp ⟨w, hwT, hwb⟩)

/-- **A closure point of an open set is a closure point of a tile meeting it** (`finite_tiles_near`: near `z` finitely many tiles, whose
closures' union is closed and holds the interior points of `U` near `z`). -/
theorem exists_tile_mem_closure_of_mem_closure {U : Set ℂ} (hU : IsOpen U) {z : ℂ} (hz : z ∈ F.dom) (hzU : z ∈ closure U) :
    ∃ T, F.IsTile T ∧ (T ∩ U).Nonempty ∧ z ∈ closure T := by
  set S := {T | F.IsTile T ∧ (T ∩ U).Nonempty} with hSdef
  have hz' : z ∈ closure (⋃ T ∈ S, closure T) := by
    refine closure_mono (biUnion_mono subset_rfl fun _ _ => subset_closure) ?_
    rw [_root_.mem_closure_iff]
    intro o ho hzo
    obtain ⟨w, ⟨hwo, hwd⟩, hwU⟩ := _root_.mem_closure_iff.mp hzU _ (ho.inter F.isOpen_dom) ⟨hzo, hz⟩
    obtain ⟨T, hT, v, hvT, ⟨hvo, -⟩, hvU⟩ := exists_tile_inter_of_isOpen ((ho.inter F.isOpen_dom).inter hU)
      (fun x hx => hx.1.2) ⟨w, ⟨hwo, hwd⟩, hwU⟩
    exact ⟨v, hvo, mem_iUnion₂.mpr ⟨T, ⟨hT, v, hvT, hvU⟩, hvT⟩⟩
  obtain ⟨T, ⟨hT, hTU⟩, hzT⟩ := exists_mem_closure_of_mem_closure_biUnion (fun T hT => hT.1) hz hz'
  exact ⟨T, hT, hTU, hzT⟩

/-- **Inside an open preconnected set the tiles are chained by touching closures**: if every tile meeting `U` lies in `U`, a nonempty set
`P` of tiles in `U`, closed under passing to a tile in `U` whose closure meets a member's, holds every tile in `U`. (The closures of the tiles
of `P` and of the others cover `U` by locally finite, hence relatively closed, unions, and meet nowhere in `U`.) -/
theorem mem_of_touch_closed {U : Set ℂ} (hU : IsOpen U) (hUc : IsPreconnected U) (hUd : U ⊆ F.dom)
    (hin : ∀ T, F.IsTile T → (T ∩ U).Nonempty → T ⊆ U) (P : Set (Set ℂ)) (hP : ∀ T ∈ P, F.IsTile T ∧ T ⊆ U) (hne : P.Nonempty)
    (hcl : ∀ T ∈ P, ∀ T', F.IsTile T' → T' ⊆ U → (closure T ∩ closure T').Nonempty → T' ∈ P) :
    ∀ T, F.IsTile T → T ⊆ U → T ∈ P := by
  intro T₀ hT₀ hT₀U
  by_contra hT₀P
  set X := ⋃ T ∈ P, closure T with hX
  set Q := {T | F.IsTile T ∧ T ⊆ U ∧ T ∉ P} with hQ
  set Y := ⋃ T ∈ Q, closure T with hY
  -- a point of `U` in the closure of `X` (of `Y`) is in the closure of a tile of `P` (of `Q`)
  have hXc : ∀ z ∈ U, z ∈ closure X → ∃ T ∈ P, z ∈ closure T := fun z hzU hz =>
    exists_mem_closure_of_mem_closure_biUnion (fun T hT => (hP T hT).1) (hUd hzU) hz
  have hYc : ∀ z ∈ U, z ∈ closure Y → ∃ T ∈ Q, z ∈ closure T := fun z hzU hz =>
    exists_mem_closure_of_mem_closure_biUnion (fun T hT => hT.1) (hUd hzU) hz
  -- every point of `U` is in the closure of a tile inside `U`
  have hcov : U ⊆ closure X ∪ closure Y := by
    intro z hzU
    obtain ⟨T, hT, hzT⟩ := F.mem_closure_tile (hUd hzU)
    have hTU : T ⊆ U := hin T hT (by
      rw [inter_comm]; exact (closure_inter_open_nonempty_iff hU).mp ⟨z, hzT, hzU⟩ |>.mono (by
        rintro x ⟨h1, h2⟩; exact ⟨h2, h1⟩))
    by_cases hTP : T ∈ P
    · exact Or.inl (subset_closure (mem_iUnion₂.mpr ⟨T, hTP, hzT⟩))
    · exact Or.inr (subset_closure (mem_iUnion₂.mpr ⟨T, ⟨hT, hTU, hTP⟩, hzT⟩))
  obtain ⟨T₁, hT₁⟩ := hne
  obtain ⟨x₁, hx₁⟩ := (hP T₁ hT₁).1.nonempty
  obtain ⟨x₀, hx₀⟩ := hT₀.nonempty
  obtain ⟨z, hzU, hzX, hzY⟩ := isPreconnected_closed_iff.mp hUc _ _ isClosed_closure isClosed_closure hcov
    ⟨x₁, (hP T₁ hT₁).2 hx₁, subset_closure (mem_iUnion₂.mpr ⟨T₁, hT₁, subset_closure hx₁⟩)⟩
    ⟨x₀, hT₀U hx₀, subset_closure (mem_iUnion₂.mpr ⟨T₀, ⟨hT₀, hT₀U, hT₀P⟩, subset_closure hx₀⟩)⟩
  obtain ⟨T, hTP, hzT⟩ := hXc z hzU hzX
  obtain ⟨T', ⟨hT', hT'U, hT'P⟩, hzT'⟩ := hYc z hzU hzY
  exact hT'P (hcl T hTP T' hT' hT'U ⟨z, hzT, hzT'⟩)

/-- **Finitely many tiles have closures meeting a compact subset of the domain** (`finite_tiles_near` and a finite subcover). -/
theorem finite_tiles_closure_inter {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ F.dom) :
    {T | F.IsTile T ∧ (closure T ∩ K).Nonempty}.Finite := by
  choose! r hr hfin using fun z (hz : z ∈ K) => F.finite_tiles_near (hKd hz)
  obtain ⟨t, htK, hcov⟩ := hK.elim_nhds_subcover (fun z => ball z (r z)) fun z hz => ball_mem_nhds z (hr z hz)
  refine (t.finite_toSet.biUnion fun z hz => hfin z (htK z hz)).subset ?_
  rintro T ⟨hT, w, hwT, hwK⟩
  obtain ⟨z, hz, hwz⟩ := mem_iUnion₂.mp (hcov hwK)
  exact mem_iUnion₂.mpr ⟨z, hz, hT, (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨w, hwT, hwz⟩⟩

/-! ## B — the outer domain and the outermost tile (FS131-E4 E4-OUTERMOST) -/

/-- **The outer domain** of `T`: the points off `cl T` in an unbounded component of `(cl T)ᶜ` (for a tile of a valid map, `cl T` is bounded
and this is the one unbounded component, `isPreconnected_compl_closedBall`). Its complement is `T`'s hull. -/
def outerDom (T : Set ℂ) : Set ℂ := {z | z ∉ closure T ∧ ¬ Bornology.IsBounded (connectedComponentIn (closure T)ᶜ z)}

/-- **`T` encloses `S`**: some point of `S` off `cl T` lies in a bounded component of `(cl T)ᶜ` (`Unenclosed v` says no tile encloses a tile
at `v`). -/
def EnclosesTile (T S : Set ℂ) : Prop := ∃ y ∈ S \ closure T, Bornology.IsBounded (connectedComponentIn (closure T)ᶜ y)

/-- The outer domain is open: with each point it holds the point's component of `(cl T)ᶜ`. -/
theorem isOpen_outerDom (T : Set ℂ) : IsOpen (outerDom T) := by
  rw [isOpen_iff_forall_mem_open]
  intro z hz
  refine ⟨connectedComponentIn (closure T)ᶜ z, fun w hw => ⟨connectedComponentIn_subset _ _ hw, ?_⟩,
    isClosed_closure.isOpen_compl.connectedComponentIn, mem_connectedComponentIn hz.1⟩
  rw [← connectedComponentIn_eq hw]
  exact hz.2

/-- A tile's closure lies in `B̄(0, ‖x‖ + 1)` for any point `x` of the tile (`IsTile.closure_subset_closedBall`). -/
theorem IsTile.closure_subset_closedBall_zero (hF : F.Valid) {T : Set ℂ} (hT : F.IsTile T) {x : ℂ} (hx : x ∈ T) :
    closure T ⊆ closedBall 0 (‖x‖ + 1) := by
  intro z hz
  have := hT.closure_subset_closedBall hF (subset_closure hx) hz
  rw [mem_closedBall, dist_zero_right]; rw [mem_closedBall] at this
  linarith [norm_le_norm_add_norm_sub' z x, dist_eq_norm z x]

/-- A point outside `B̄(0, R)`. -/
theorem exists_not_mem_closedBall_zero (R : ℝ) : ∃ z : ℂ, z ∉ closedBall (0 : ℂ) R :=
  ⟨((|R| + 1 : ℝ) : ℂ), by
    rw [mem_closedBall, dist_zero_right, Complex.norm_real, Real.norm_of_nonneg (by positivity), not_le]
    linarith [le_abs_self R]⟩

/-- **The outer domain of a set with bounded closure is one complementary component**: the one through any point outside a disc holding
the closure. -/
theorem outerDom_eq_connectedComponentIn {T : Set ℂ} {R : ℝ} (hTR : closure T ⊆ closedBall 0 R) {z₀ : ℂ}
    (hz₀ : z₀ ∉ closedBall (0 : ℂ) R) : outerDom T = connectedComponentIn (closure T)ᶜ z₀ := by
  have hsub : (closedBall (0 : ℂ) R)ᶜ ⊆ connectedComponentIn (closure T)ᶜ z₀ :=
    (isPreconnected_compl_closedBall 0 R).subset_connectedComponentIn hz₀ (compl_subset_compl.mpr hTR)
  have hunb : ¬ Bornology.IsBounded (connectedComponentIn (closure T)ᶜ z₀) := by
    intro hb
    obtain ⟨R', hR'⟩ := hb.subset_closedBall 0
    obtain ⟨w, hw⟩ := exists_not_mem_closedBall_zero (max R R')
    exact hw (closedBall_subset_closedBall (le_max_right _ _) (hR' (hsub fun h =>
      hw (closedBall_subset_closedBall (le_max_left _ _) h))))
  have hbd : Bornology.IsBounded (closure T) := isBounded_closedBall.subset hTR
  ext z
  constructor
  · rintro ⟨hzT, hz⟩
    rw [← connectedComponentIn_eq_of_not_isBounded hbd hz hunb]
    exact mem_connectedComponentIn hzT
  · intro hz
    exact ⟨connectedComponentIn_subset _ _ hz, by rw [← connectedComponentIn_eq hz]; exact hunb⟩

/-- **A tile at a point of a chart's ball holds a sector having the point in its closure** (the ball's interior points are the finitely many
sectors, so a closure point of the tile in the ball is a closure point of one sector meeting the tile, and that sector lies in the tile). -/
theorem IsSectorChart.exists_sector_mem_closure {n : ℕ} {G : BranchGerms n} {p : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G p r₀)
    (hn : 0 < n) {r : ℝ} (hr : r ∈ Ioc 0 r₀) {q : ℂ} (hq : q ∈ ball p r) {A : Set ℂ} (hA : F.IsTile A) (hqA : q ∈ closure A) :
    ∃ i, G.sector p r i ⊆ A ∧ q ∈ closure (G.sector p r i) := by
  have h1 : q ∈ closure (⋃ i, G.sector p r i ∩ A) := by
    refine closure_mono ?_ (isOpen_ball.inter_closure ⟨hq, hqA⟩)
    rintro w ⟨hwb, hwA⟩
    have hw : w ∈ ball p r ∩ F.interiorPts := ⟨hwb, hA.subset_interiorPts hwA⟩
    rw [hC.cover r hr hn] at hw
    obtain ⟨i, hi⟩ := mem_iUnion.mp hw
    exact mem_iUnion.mpr ⟨i, hi, hwA⟩
  rw [closure_iUnion_of_finite] at h1
  obtain ⟨i, hi⟩ := mem_iUnion.mp h1
  obtain ⟨w, hwi, hwA⟩ : (G.sector p r i ∩ A).Nonempty := by
    by_contra h
    rw [not_nonempty_iff_eq_empty] at h
    rw [h, closure_empty] at hi
    exact hi
  exact ⟨i, hA.subset_of_preconnected (hC.isPreconnected r hr i) (hC.sector_subset_interiorPts hn hr i) hwi hwA,
    closure_mono inter_subset_left hi⟩

/-- **Points of three tiles are isolated**: about each point of the domain there is a disc in which every other point has at most two tiles
in its closure (off the centre the disc's points are interior, or on one branch of the chart, whose closure meets only the two sectors that
branch bounds: `BranchGerms.exists_far_side`). -/
theorem exists_ball_two_tiles {p : ℂ} (hp : p ∈ F.dom) :
    ∃ ρ > 0, ∀ q ∈ ball p ρ, q ≠ p → ∀ A B C : Set ℂ, F.IsTile A → F.IsTile B → F.IsTile C → q ∈ closure A → q ∈ closure B →
      q ∈ closure C → A = B ∨ A = C ∨ B = C := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hp
  obtain ⟨ρ', hρ', hord'⟩ :=
    mem_nhdsGT_iff_exists_Ioo_subset.mp (G.eventually_dir_lt_nextDir hC.sorted hC.pos hC.curv)
  set ρ := min ρ' r₀ with hρdef
  have hρ : ρ ∈ Ioc 0 r₀ := ⟨lt_min hρ' hC.pos, min_le_right _ _⟩
  have hord : ∀ s ∈ Ioo 0 ρ, ∀ i, G.dir i s < G.nextDir i s := fun s hs =>
    hord' ⟨hs.1, hs.2.trans_le (min_le_left _ _)⟩
  refine ⟨ρ, hρ.1, ?_⟩
  intro q hq hqp A B C hA hB hC' hqA hqB hqC
  by_cases hqi : q ∈ F.interiorPts
  · -- `q` lies in a tile, the only tile with `q` in its closure
    have hZ : F.IsTile (connectedComponentIn F.interiorPts q) := ⟨q, hqi, rfl⟩
    have key : ∀ D, F.IsTile D → q ∈ closure D → D = connectedComponentIn F.interiorPts q := by
      intro D hD hqD
      obtain ⟨w, hwD, hwZ⟩ := (closure_inter_open_nonempty_iff hZ.isOpen).mp ⟨q, hqD, mem_connectedComponentIn hqi⟩
      exact hD.eq_of_mem hZ hwD hwZ
    exact Or.inl ((key A hA hqA).trans (key B hB hqB).symm)
  · -- `q` lies on one branch `m`
    have hqb : q ∈ ball p r₀ := ball_subset_ball hρ.2 hq
    have hqd : q ∈ F.dom := hC.subdom hqb
    have hqΓ : q ∈ (F.Γ ∩ ball p r₀) \ {p} := by
      refine ⟨⟨⟨hqd, ?_⟩, hqb⟩, hqp⟩
      by_contra h
      exact hqi ⟨hqd, h⟩
    rw [hC.branches] at hqΓ
    obtain ⟨m, hm⟩ := mem_iUnion.mp hqΓ
    obtain ⟨s, hs, hqm⟩ := hm
    have hn : 0 < n := m.pos
    have hsρ : s < ρ := by
      have := norm_branchPt_sub p (G.β m) (G.κ m) hs.1.le
      rw [hqm] at this
      rw [mem_ball, dist_eq_norm, this] at hq
      exact hq
    -- each of the three tiles holds a sector having `q` in its closure
    obtain ⟨iA, hiA, hqiA⟩ := hC.exists_sector_mem_closure hn hρ hq hA hqA
    obtain ⟨iB, hiB, hqiB⟩ := hC.exists_sector_mem_closure hn hρ hq hB hqB
    obtain ⟨iC, hiC, hqiC⟩ := hC.exists_sector_mem_closure hn hρ hq hC' hqC
    have heq : ∀ {D D' : Set ℂ} {i : Fin n}, F.IsTile D → F.IsTile D' → G.sector p ρ i ⊆ D → G.sector p ρ i ⊆ D' →
        D = D' := by
      intro D D' i hD hD' hi hi'
      obtain ⟨w, hw⟩ := hC.sector_nonempty hρ i
      exact hD.eq_of_mem hD' (hi hw) (hi' hw)
    suffices h : iA = iB ∨ iA = iC ∨ iB = iC by
      rcases h with h | h | h
      · subst h; exact Or.inl (heq hA hB hiA hiB)
      · subst h; exact Or.inr (Or.inl (heq hA hC' hiA hiC))
      · subst h; exact Or.inr (Or.inr (heq hB hC' hiB hiC))
    by_cases hn2 : n ≤ 2
    · simp only [Fin.ext_iff]; omega
    · -- with three germs or more, a sector whose closure has `q` is one of the two that branch `m` bounds
      have hadj : ∀ i, q ∈ closure (G.sector p ρ i) → i = m ∨ BranchGerms.next i = m := by
        intro i hqi'
        by_contra h
        push Not at h
        obtain ⟨O, hOo, -, -, hOd, -, hOm⟩ := G.exists_far_side (by omega) hord p i
        have hqO : q ∈ O := hqm ▸ hOm m (Ne.symm h.1) (Ne.symm h.2) s ⟨hs.1, hsρ⟩
        exact Set.disjoint_left.mp (hOd.closure_right hOo) hqO hqi'
      have hinj := BranchGerms.next_injective (n := n)
      rcases hadj iA hqiA with h1 | h1 <;> rcases hadj iB hqiB with h2 | h2 <;> rcases hadj iC hqiC with h3 | h3 <;>
        first
        | exact Or.inl (h1.trans h2.symm)
        | exact Or.inr (Or.inl (h1.trans h3.symm))
        | exact Or.inr (Or.inr (h2.trans h3.symm))
        | exact Or.inl (hinj (h1.trans h2.symm))
        | exact Or.inr (Or.inl (hinj (h1.trans h3.symm)))
        | exact Or.inr (Or.inr (hinj (h2.trans h3.symm)))

/-- **A disc holding a set's closure holds its hull**: the complement of the disc is connected, unbounded, and off the closure. -/
theorem compl_outerDom_subset_closedBall {T : Set ℂ} {c : ℂ} {R : ℝ} (hT : closure T ⊆ closedBall c R) :
    (outerDom T)ᶜ ⊆ closedBall c R := by
  intro w hw
  by_contra hwc
  apply hw
  refine ⟨fun h => hwc (hT h), fun hb => ?_⟩
  have hsub : (closedBall c R)ᶜ ⊆ connectedComponentIn (closure T)ᶜ w :=
    (isPreconnected_compl_closedBall c R).subset_connectedComponentIn hwc (compl_subset_compl.mpr hT)
  have : Bornology.IsBounded (univ : Set ℂ) :=
    ((isBounded_closedBall (x := c) (r := R)).union hb).subset fun z _ => by
      by_cases h : z ∈ closedBall c R
      · exact Or.inl h
      · exact Or.inr (hsub h)
  exact NormedSpace.unbounded_univ ℝ ℂ this

/-- **Enclosure grows hulls** (FS131-E4 E4-OUTERMOST step 2; this record § 5.4): if the tile `T'` encloses the tile `T`, the outer domain of
`T'` lies in that of `T` — `T` sits in a bounded component `B'` of `(cl T')ᶜ`, so `cl T ⊆ B' ∪ cl T'`, which an unbounded component of
`(cl T')ᶜ` misses. -/
theorem outerDom_subset_of_encloses {T T' : Set ℂ} (hT : F.IsTile T) (hT' : F.IsTile T') (henc : EnclosesTile T' T) :
    outerDom T' ⊆ outerDom T := by
  obtain ⟨y, ⟨hyT, hyT'⟩, hb⟩ := henc
  set B' := connectedComponentIn (closure T')ᶜ y with hB'
  have hopen : IsOpen (closure T')ᶜ := isClosed_closure.isOpen_compl
  have hTT' : T ≠ T' := fun h => hyT' (h ▸ subset_closure hyT)
  have hTB : T ⊆ B' :=
    hT.isPreconnected.subset_connectedComponentIn hyT (IsTile.subset_compl_closure hT' hT hTT')
  have hclT : closure T ⊆ B' ∪ closure T' := by
    intro z hz
    by_cases hzB : z ∈ B'
    · exact Or.inl hzB
    · right
      have hzf : z ∈ frontier B' := ⟨closure_mono hTB hz, by rwa [hopen.connectedComponentIn.interior_eq]⟩
      simpa using frontier_connectedComponentIn_subset hopen y hzf
  rintro w ⟨hwT', hwb⟩
  set W := connectedComponentIn (closure T')ᶜ w with hWdef
  have hWB : Disjoint W B' := by
    rw [Set.disjoint_left]
    intro z hzW hzB
    apply hwb
    have h1 : W = connectedComponentIn (closure T')ᶜ z := by rw [hWdef]; exact connectedComponentIn_eq (hWdef ▸ hzW)
    have h2 : B' = connectedComponentIn (closure T')ᶜ z := by rw [hB']; exact connectedComponentIn_eq (hB' ▸ hzB)
    rw [h1, ← h2]; exact hb
  have hWT : W ⊆ (closure T)ᶜ := by
    intro z hzW hzT
    rcases hclT hzT with h | h
    · exact Set.disjoint_left.mp hWB hzW h
    · exact connectedComponentIn_subset _ _ hzW h
  have hwW : w ∈ W := mem_connectedComponentIn hwT'
  exact ⟨hWT hwW, fun hbd => hwb (hbd.subset (isPreconnected_connectedComponentIn.subset_connectedComponentIn hwW hWT))⟩

/-- **Enclosure strictly grows hulls** (KP's `not_encloses_of_hull_eq`): a tile whose outer domain is that of the tile `T` does not enclose
`T`. Were it to, the common rim `frontier (outerDom T)` would lie in both closures and be preconnected with two points (a one-point rim would
split `ℂ ∖ {p}`), and at each of its points a third tile, of the outer domain, would touch; but points of three tiles are isolated
(`exists_ball_two_tiles`). For open connected sets in general this fails (Wada's lakes): the map's regularity is read here. -/
theorem not_encloses_of_hull_eq (hF : F.Valid) {T T' : Set ℂ} (hT : F.IsTile T) (hT' : F.IsTile T') (hdom : (outerDom T)ᶜ ⊆ F.dom)
    (heq : outerDom T' = outerDom T) : ¬ EnclosesTile T' T := by
  rintro ⟨y, ⟨hyT, hyT'⟩, -⟩
  have hTT' : T ≠ T' := fun h => hyT' (h ▸ subset_closure hyT)
  obtain ⟨x, hx⟩ := hT.nonempty
  obtain ⟨x', hx'⟩ := hT'.nonempty
  have hTR := hT.closure_subset_closedBall_zero hF hx
  have hT'R := hT'.closure_subset_closedBall_zero hF hx'
  obtain ⟨z₀, hz₀⟩ := exists_not_mem_closedBall_zero (max (‖x‖ + 1) (‖x'‖ + 1))
  have hz₀1 : z₀ ∉ closedBall (0 : ℂ) (‖x‖ + 1) := fun h => hz₀ (closedBall_subset_closedBall (le_max_left _ _) h)
  have hz₀2 : z₀ ∉ closedBall (0 : ℂ) (‖x'‖ + 1) := fun h => hz₀ (closedBall_subset_closedBall (le_max_right _ _) h)
  have hW := outerDom_eq_connectedComponentIn hTR hz₀1
  have hW' := outerDom_eq_connectedComponentIn hT'R hz₀2
  set W := outerDom T with hWdef
  have hWo : IsOpen W := isOpen_outerDom T
  set Φ := frontier W with hΦ
  have hΦT : Φ ⊆ closure T := by
    rw [hΦ, hW]; intro v hv; simpa using frontier_connectedComponentIn_subset isClosed_closure.isOpen_compl z₀ hv
  have hΦT' : Φ ⊆ closure T' := by
    rw [hΦ, ← heq, hW']; intro v hv; simpa using frontier_connectedComponentIn_subset isClosed_closure.isOpen_compl z₀ hv
  have hΦpre : IsPreconnected Φ := by
    rw [hΦ, hW]; exact isPreconnected_frontier_connectedComponentIn isClosed_closure hT.isPreconnected.closure z₀
  have hWT : Disjoint W (closure T) := Set.disjoint_left.mpr fun z hz => hz.1
  have hWT' : Disjoint W (closure T') := by rw [← heq]; exact Set.disjoint_left.mpr fun z hz => hz.1
  have hΦd : ∀ p ∈ Φ, p ∈ F.dom := fun p hp => hdom (fun h => (hWo.inter_frontier_eq.subset ⟨h, hp⟩ : p ∈ (∅ : Set ℂ)))
  -- at every rim point a third tile, of `W`, touches
  have hthree : ∀ p ∈ Φ, ∃ Z, F.IsTile Z ∧ Z ≠ T ∧ Z ≠ T' ∧ p ∈ closure Z := by
    intro p hp
    obtain ⟨Z, hZ, ⟨w, hwZ, hwW⟩, hpZ⟩ := exists_tile_mem_closure_of_mem_closure hWo (hΦd p hp) hp.1
    refine ⟨Z, hZ, fun h => ?_, fun h => ?_, hpZ⟩
    · exact Set.disjoint_left.mp hWT hwW (subset_closure (h ▸ hwZ))
    · exact Set.disjoint_left.mp hWT' hwW (subset_closure (h ▸ hwZ))
  -- so the rim is one point
  have hz₀W : z₀ ∈ W := by rw [hW]; exact mem_connectedComponentIn (fun h => hz₀1 (hTR h))
  have hΦne : Φ.Nonempty := by
    rw [hΦ, nonempty_frontier_iff]
    refine ⟨⟨z₀, hz₀W⟩, fun h => ?_⟩
    exact (h ▸ mem_univ x : x ∈ W).1 (subset_closure hx)
  obtain ⟨p, hp⟩ := hΦne
  obtain ⟨ρ, hρ, hiso⟩ := exists_ball_two_tiles (hΦd p hp)
  have hsub : Φ ⊆ {p} ∪ (ball p ρ)ᶜ := by
    intro q hq
    by_cases hqp : q = p
    · exact Or.inl hqp
    · right
      intro hqb
      obtain ⟨Z, hZ, hZT, hZT', hqZ⟩ := hthree q hq
      rcases hiso q hqb hqp T T' Z hT hT' hZ (hΦT hq) (hΦT' hq) hqZ with h | h | h
      · exact hTT' h
      · exact hZT h.symm
      · exact hZT' h.symm
  have hΦp : Φ ⊆ {p} := by
    intro q hq
    by_contra hqp
    obtain ⟨w, -, hw1, hw2⟩ := isPreconnected_closed_iff.mp hΦpre {p} (ball p ρ)ᶜ isClosed_singleton
      isOpen_ball.isClosed_compl hsub ⟨p, hp, rfl⟩ ⟨q, hq, (hsub hq).resolve_left hqp⟩
    rw [mem_singleton_iff] at hw1
    subst hw1
    exact hw2 (mem_ball_self hρ)
  -- but `ℂ ∖ {p}` is connected, and `W`, `(cl W)ᶜ` would split it
  have hconn : IsPreconnected ({p}ᶜ : Set ℂ) :=
    (isConnected_compl_singleton_of_one_lt_rank (by rw [Complex.rank_real_complex]; norm_num) p).isPreconnected
  have hxW : x ∉ closure W :=
    Set.disjoint_left.mp ((Set.disjoint_left.mpr fun z hzT hzW => Set.disjoint_left.mp hWT hzW (subset_closure hzT) :
      Disjoint T W).closure_right hT.isOpen) hx
  have hpcl : p ∈ closure W := hp.1
  obtain ⟨w, -, hwW, hwc⟩ := hconn W (closure W)ᶜ hWo isClosed_closure.isOpen_compl
    (fun z hz => by
      by_cases hzW : z ∈ W
      · exact Or.inl hzW
      · exact Or.inr fun hzc => hz (hΦp ⟨hzc, by rwa [hWo.interior_eq]⟩))
    ⟨z₀, fun h => hz₀1 (hTR (hΦT ((mem_singleton_iff.mp h) ▸ hp))), hz₀W⟩
    ⟨x, fun h => hxW ((mem_singleton_iff.mp h) ▸ hpcl), hxW⟩
  exact hwc (subset_closure hwW)

/-- **The outermost tile** (E4-OUTERMOST steps 1–2): in a valid map covering `B̄(x, 1 + ρ)`, some tile `T*` has `x` in its hull, its hull in
`B̄(x, 1)`, and no tile enclosing it. (A tile has diameter at most `1`, its hull lies in the convex hull of its closure; enclosure strictly
grows hulls; the chain from a tile at `x` stays among the finitely many tiles meeting `B̄(x, 1)`.) -/
theorem exists_outermost (hF : F.Valid) {x : ℂ} {ρ : ℝ} (hρ : 0 < ρ) (hx : closedBall x (1 + ρ) ⊆ F.dom) :
    ∃ T, F.IsTile T ∧ x ∉ outerDom T ∧ (outerDom T)ᶜ ⊆ closedBall x 1 ∧ ∀ T', F.IsTile T' → ¬ EnclosesTile T' T := by
  have hxd : closedBall x 1 ⊆ F.dom := (closedBall_subset_closedBall (by linarith)).trans hx
  -- the candidates: the tiles with `x` in the hull; each hull lies in `B̄(x, 1)` (a tile's closure lies within `1` of each of its points,
  -- so within `1` of `x`)
  set C := {T | F.IsTile T ∧ x ∉ outerDom T} with hCdef
  have hhull : ∀ T ∈ C, (outerDom T)ᶜ ⊆ closedBall x 1 := by
    rintro T ⟨hT, hxT⟩
    have h2 : closure T ⊆ closedBall x 1 := by
      intro w hw
      have hxw : x ∈ closedBall w 1 := compl_outerDom_subset_closedBall (hT.closure_subset_closedBall hF hw) hxT
      rw [mem_closedBall] at hxw ⊢
      rw [dist_comm]; exact hxw
    exact compl_outerDom_subset_closedBall h2
  have hfin : C.Finite := by
    refine (finite_tiles_closure_inter (isCompact_closedBall x 1) hxd).subset ?_
    intro T hTC
    obtain ⟨z, hz⟩ := hTC.1.nonempty
    exact ⟨hTC.1, z, subset_closure hz, hhull T hTC (fun h => h.1 (subset_closure hz))⟩
  have hne : C.Nonempty := by
    obtain ⟨T, hT, hxT⟩ := F.mem_closure_tile (hxd (mem_closedBall_self zero_le_one))
    exact ⟨T, hT, fun h => h.1 hxT⟩
  -- a candidate with a maximal hull is enclosed by none
  obtain ⟨T, hTmax⟩ := hfin.exists_maximalFor (fun T => (outerDom T)ᶜ) C hne
  have hTC : T ∈ C := hTmax.1
  have hdom : (outerDom T)ᶜ ⊆ F.dom := (hhull T hTC).trans hxd
  refine ⟨T, hTC.1, hTC.2, hhull T hTC, fun T' hT' henc => ?_⟩
  have hmono := outerDom_subset_of_encloses hTC.1 hT' henc
  have hT'C : T' ∈ C := ⟨hT', fun h => hTC.2 (hmono h)⟩
  have hle : (outerDom T)ᶜ ⊆ (outerDom T')ᶜ := compl_subset_compl.mpr hmono
  have hge : (outerDom T')ᶜ ⊆ (outerDom T)ᶜ := hTmax.2 hT'C hle
  have heq : outerDom T' = outerDom T := compl_injective (Subset.antisymm hge hle)
  exact not_encloses_of_hull_eq hF hTC.1 hT' hdom heq henc

/-- **Two outer tiles meet on the rim of an un-enclosed tile** (E4-OUTERMOST step 3): the rim `Φ* = frontier (outerDom T*)` is preconnected
(`isPreconnected_frontier_connectedComponentIn`) and lies in the closures of the tiles of `outerDom T*` touching it, finitely many; were there
one, `T*` would lie in a bounded component of the complement of its closure (`isBounded_connectedComponentIn_of_frontier_subset`), against
`hno`; so two meet at a point `v` of `Φ* ⊆ cl T*` (`exists_inter_of_finite_closed_cover`). -/
theorem exists_rim_vertex (hF : F.Valid) {T : Set ℂ} (hT : F.IsTile T) (hdom : (outerDom T)ᶜ ⊆ F.dom)
    (hno : ∀ T', F.IsTile T' → ¬ EnclosesTile T' T) :
    ∃ X Y v, F.IsTile X ∧ F.IsTile Y ∧ X ≠ Y ∧ X ⊆ outerDom T ∧ Y ⊆ outerDom T ∧ v ∈ frontier (outerDom T) ∧
      v ∈ closure T ∧ v ∈ closure X ∧ v ∈ closure Y := by
  obtain ⟨x, hx⟩ := hT.nonempty
  have hTR := hT.closure_subset_closedBall_zero hF hx
  obtain ⟨z₀, hz₀⟩ := exists_not_mem_closedBall_zero (‖x‖ + 1)
  have hW := outerDom_eq_connectedComponentIn hTR hz₀
  set W := outerDom T with hWdef
  have hcl : IsClosed (closure T) := isClosed_closure
  have hWo : IsOpen W := by rw [hW]; exact hcl.isOpen_compl.connectedComponentIn
  set Φ := frontier W with hΦ
  -- the rim: preconnected, inside `cl T`, compact, nonempty
  have hΦpre : IsPreconnected Φ := by
    rw [hΦ, hW]; exact isPreconnected_frontier_connectedComponentIn hcl hT.isPreconnected.closure z₀
  have hΦT : Φ ⊆ closure T := by
    rw [hΦ, hW]; intro v hv; simpa using frontier_connectedComponentIn_subset hcl.isOpen_compl z₀ hv
  have hΦc : IsCompact Φ := (isCompact_closedBall 0 (‖x‖ + 1)).of_isClosed_subset isClosed_frontier (hΦT.trans hTR)
  have hΦd : Φ ⊆ F.dom := fun v hv => hdom (fun hvW => (hWo.inter_frontier_eq.subset ⟨hvW, hv⟩ : v ∈ (∅ : Set ℂ)))
  have hz₀W : z₀ ∈ W := by rw [hW]; exact mem_connectedComponentIn (fun h => hz₀ (hTR h))
  have hΦne : Φ.Nonempty := by
    rw [hΦ, nonempty_frontier_iff]
    refine ⟨⟨z₀, hz₀W⟩, fun h => ?_⟩
    exact (h ▸ mem_univ x : x ∈ W).1 (subset_closure hx)
  -- a tile meeting `W` lies in `W`
  have hinW : ∀ X, F.IsTile X → (X ∩ W).Nonempty → X ⊆ W := by
    rintro X hX ⟨w, hwX, hwW⟩
    have hXT : X ≠ T := by rintro rfl; exact hwW.1 (subset_closure hwX)
    rw [hW] at hwW ⊢
    rw [connectedComponentIn_eq hwW]
    exact hX.isPreconnected.subset_connectedComponentIn hwX (IsTile.subset_compl_closure hT hX hXT)
  -- the tiles of `W` touching the rim: finitely many, covering it
  set s := {X | F.IsTile X ∧ X ⊆ W ∧ (closure X ∩ Φ).Nonempty} with hs
  have hsfin : s.Finite := (finite_tiles_closure_inter hΦc hΦd).subset fun X hX => ⟨hX.1, hX.2.2⟩
  have hcov : Φ ⊆ ⋃ X ∈ s, closure X := by
    intro v hv
    obtain ⟨X, hX, hXW, hvX⟩ := exists_tile_mem_closure_of_mem_closure hWo (hΦd hv) hv.1
    exact mem_iUnion₂.mpr ⟨X, ⟨hX, hinW X hX hXW, v, hvX, hv⟩, hvX⟩
  -- two of them: one alone would enclose `T` (the last exit)
  obtain ⟨v₀, hv₀⟩ := hΦne
  obtain ⟨X, hXs, hv₀X⟩ := mem_iUnion₂.mp (hcov hv₀)
  obtain ⟨Y, hYs, hXY⟩ : ∃ Y ∈ s, X ≠ Y := by
    by_contra hall
    push Not at hall
    -- the rim lies in `cl X`
    have hΦX : Φ ⊆ closure X := by
      intro v hv
      obtain ⟨Y, hYs, hvY⟩ := mem_iUnion₂.mp (hcov hv)
      rwa [← hall Y hYs] at hvY
    have hXT : X ≠ T := by
      rintro rfl
      obtain ⟨w, hw⟩ := hXs.1.nonempty
      exact (hXs.2.1 hw).1 (subset_closure hw)
    have hxX : x ∉ closure X := by
      intro h
      obtain ⟨w, hw, hwx⟩ := (closure_inter_open_nonempty_iff hT.isOpen).mp ⟨x, h, hx⟩
      exact Set.disjoint_left.mp (Set.disjoint_left.mpr fun a ha haT =>
        hXT (hXs.1.eq_of_mem hT ha haT)) hw hwx
    apply hno X hXs.1
    refine ⟨x, ⟨hx, hxX⟩, ?_⟩
    have hbd : Bornology.IsBounded (closure T) := isBounded_closedBall.subset hTR
    have hunb : ¬ Bornology.IsBounded (connectedComponentIn (closure T)ᶜ z₀) := by
      rw [← hW]; intro hb
      exact hz₀W.2 (by rw [← connectedComponentIn_eq (by rw [← hW]; exact hz₀W)]; rw [hW] at hb; exact hb)
    exact isBounded_connectedComponentIn_of_frontier_subset hcl hbd isClosed_closure hunb
      (by rw [← hW]; exact hΦX) (by rw [← hW]; exact fun h => h.1 (subset_closure hx)) hxX
  obtain ⟨X', hX's, Y', hY's, hne, v, ⟨hvΦ, hvX'⟩, hvY'⟩ :=
    exists_inter_of_finite_closed_cover hΦpre hsfin (fun X => closure X) (fun _ _ => isClosed_closure) hcov hXs hYs hXY
      ⟨v₀, hv₀, hv₀X⟩ (by obtain ⟨w, hw1, hw2⟩ := hYs.2.2; exact ⟨w, hw2, hw1⟩)
  exact ⟨X', Y', v, hX's.1, hY's.1, hne, hX's.2.1, hY's.2.1, hvΦ, hΦT hvΦ, hvX', hvY'⟩

/-- **A tile at a chart's point holds a sector of every small radius**: if `v ∈ cl A` and `v`'s chart has germs, then for every `r ∈ (0, r₀]`
some sector of radius `r` lies in `A` (a sector meeting `A` is preconnected inside the interior points, so inside `A`'s component). -/
theorem IsSectorChart.exists_sector_subset_tile {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    (hn : 0 < n) {r : ℝ} (hr : r ∈ Ioc 0 r₀) {A : Set ℂ} (hA : F.IsTile A) (hvA : v ∈ closure A) : ∃ i, G.sector v r i ⊆ A := by
  obtain ⟨w, hwA, hwb⟩ := (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨v, hvA, mem_ball_self hr.1⟩
  have hw : w ∈ ball v r ∩ F.interiorPts := ⟨hwb, hA.subset_interiorPts hwA⟩
  rw [hC.cover r hr hn] at hw
  obtain ⟨i, hi⟩ := mem_iUnion.mp hw
  refine ⟨i, ?_⟩
  obtain ⟨x, hx, rfl⟩ := hA
  rw [connectedComponentIn_eq hwA]
  exact (hC.isPreconnected r hr i).subset_connectedComponentIn hi (hC.sector_subset_interiorPts hn hr i)

/-- **Two tiles of one colour at a point give it a repeated colour**: each holds a sector of every small radius, and the two sectors differ. -/
theorem hasRepeatedColour_of_two_tiles {v : ℂ} (hv : v ∈ F.dom) {A B : Set ℂ} {c : Fin k} (hA : F.TileOf c A)
    (hB : F.TileOf c B) (hAB : A ≠ B) (hvA : v ∈ closure A) (hvB : v ∈ closure B) : F.HasRepeatedColour v := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hv
  have hn : 0 < n := by
    by_contra h0
    have hball := hC.empty (by omega)
    obtain ⟨a, haA, hab⟩ := (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨v, hvA, mem_ball_self hC.pos⟩
    obtain ⟨b, hbB, hbb⟩ := (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨v, hvB, mem_ball_self hC.pos⟩
    have h1 : ball v r₀ ⊆ A := by
      obtain ⟨x, hx, hAx⟩ := hA.1
      rw [hAx, connectedComponentIn_eq (hAx ▸ haA)]
      exact (convex_ball v r₀).isPreconnected.subset_connectedComponentIn hab hball
    exact hAB (hA.1.eq_of_mem hB.1 (h1 hbb) hbB)
  refine ⟨c, ?_⟩
  filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
  obtain ⟨i, hi⟩ := hC.exists_sector_subset_tile hn hr hA.1 hvA
  obtain ⟨j, hj⟩ := hC.exists_sector_subset_tile hn hr hB.1 hvB
  have hne : G.sector v r i ≠ G.sector v r j := by
    intro h
    obtain ⟨w, hw⟩ := hC.sector_nonempty hr i
    exact hAB (hA.1.eq_of_mem hB.1 (hi hw) (hj (h ▸ hw)))
  have hSi : G.sector v r i ∈ F.sectorsOf v r c := ⟨(hC.isSector_iff hn hr).mpr ⟨i, rfl⟩, hi.trans hA.2⟩
  have hSj : G.sector v r j ∈ F.sectorsOf v r c := ⟨(hC.isSector_iff hn hr).mpr ⟨j, rfl⟩, hj.trans hB.2⟩
  calc (2 : ℕ∞) = ({G.sector v r i, G.sector v r j} : Set (Set ℂ)).encard := (Set.encard_pair hne).symm
    _ ≤ (F.sectorsOf v r c).encard := Set.encard_le_encard (insert_subset_iff.mpr ⟨hSi, singleton_subset_iff.mpr hSj⟩)

/-- **Three distinct tiles at a good point make it cubic trichromatic** (E4-OUTERMOST step 4; E4-RIM step 5): no repeated colour gives three
colours, no fourth colour gives exactly three, then `isCubicTrichromatic_of_three_of_noRep`. -/
theorem isCubicTrichromatic_of_three_tiles {v : ℂ} (hv : v ∈ F.dom) {A B C : Set ℂ} (hA : F.IsTile A) (hB : F.IsTile B)
    (hC : F.IsTile C) (hAB : A ≠ B) (hAC : A ≠ C) (hBC : B ≠ C) (hvA : v ∈ closure A) (hvB : v ∈ closure B) (hvC : v ∈ closure C)
    (hgood : v ∉ F.fourSet ∪ F.repSet) : F.IsCubicTrichromatic v := by
  have hnr : ¬ F.HasRepeatedColour v := fun h => hgood (Or.inr ⟨hv, h⟩)
  -- each tile has one colour, carried at `v`
  have hcol : ∀ {P}, F.IsTile P → v ∈ closure P → ∃ c, F.TileOf c P ∧ c ∈ F.coloursAt v := by
    intro P hP hvP
    obtain ⟨p, hp⟩ := hP.nonempty
    refine ⟨F.col p, hP.tileOf hp, ?_⟩
    show v ∈ closure (F.region (F.col p))
    have hsub : P ⊆ F.region (F.col p) := fun z hz => ⟨hP.subset_interiorPts hz, (hP.tileOf hp).2 hz⟩
    exact closure_mono hsub hvP
  obtain ⟨a, ha, hav⟩ := hcol hA hvA
  obtain ⟨b, hb, hbv⟩ := hcol hB hvB
  obtain ⟨c, hc, hcv⟩ := hcol hC hvC
  -- distinct tiles at `v` have distinct colours (else a repeated colour)
  have hdist : ∀ {P Q : Set ℂ} {p q : Fin k}, F.TileOf p P → F.TileOf q Q → P ≠ Q → v ∈ closure P → v ∈ closure Q → p ≠ q := by
    rintro P Q p q hP hQ hPQ hvP hvQ rfl
    exact hnr (hasRepeatedColour_of_two_tiles hv hP hQ hPQ hvP hvQ)
  have hab := hdist ha hb hAB hvA hvB
  have hac := hdist ha hc hAC hvA hvC
  have hbc := hdist hb hc hBC hvB hvC
  have h3 : (F.coloursAt v).ncard = 3 := by
    have hge : 3 ≤ (F.coloursAt v).ncard := by
      have : ({a, b, c} : Set (Fin k)).ncard = 3 := Set.ncard_eq_three.mpr ⟨a, b, c, hab, hac, hbc, rfl⟩
      rw [← this]
      exact Set.ncard_le_ncard (insert_subset_iff.mpr ⟨hav, insert_subset_iff.mpr ⟨hbv, singleton_subset_iff.mpr hcv⟩⟩)
        (Set.toFinite _)
    have hle : (F.coloursAt v).ncard < 4 := by
      by_contra h
      push Not at h
      exact hgood (Or.inl ⟨hv, h⟩)
    omega
  exact isCubicTrichromatic_of_three_of_noRep hv h3 hnr

/-- **The rim vertex is un-enclosed** (E4-OUTERMOST step 5): its three tiles are `T*` (enclosed by none), and two tiles of `T*`'s outer
domain, each of which a bounded complementary component of a tile's closure would carry together with `T*` (a small disc about `v`, or the
sectors of `T*` and the tile at `v` with the arc between them, connects them off that closure). -/
theorem unenclosed_of_rim_vertex {T X Y : Set ℂ} {v : ℂ} (hv : v ∈ F.dom) (hT : F.IsTile T) (hX : F.IsTile X) (hY : F.IsTile Y)
    (hXY : X ≠ Y) (hXo : X ⊆ outerDom T) (hYo : Y ⊆ outerDom T) (hvT : v ∈ closure T) (hvX : v ∈ closure X) (hvY : v ∈ closure Y)
    (hcub : F.IsCubicTrichromatic v) (hno : ∀ T', F.IsTile T' → ¬ EnclosesTile T' T) : F.Unenclosed v := by
  have hTX : T ≠ X := fun h => by
    obtain ⟨w, hw⟩ := hX.nonempty
    exact (hXo hw).1 (subset_closure (h.symm ▸ hw : w ∈ T))
  have hTY : T ≠ Y := fun h => by
    obtain ⟨w, hw⟩ := hY.nonempty
    exact (hYo hw).1 (subset_closure (h.symm ▸ hw : w ∈ T))
  -- the chart at `v` has three germs
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hv
  have hn3 : n = 3 := by
    obtain ⟨r, h1, h2⟩ := (hcub.1.and hC.hasDegree).exists
    rw [h1] at h2
    have : max n 1 = 3 := by exact_mod_cast h2.symm
    omega
  subst hn3
  -- strictly ordered below some `ρ ≤ r₀`
  obtain ⟨ρ', hρ', hord'⟩ :=
    mem_nhdsGT_iff_exists_Ioo_subset.mp (G.eventually_dir_lt_nextDir hC.sorted hC.pos hC.curv)
  set ρ := min ρ' r₀ with hρdef
  have hρ : ρ ∈ Ioc 0 r₀ := ⟨lt_min hρ' hC.pos, min_le_right _ _⟩
  have hord : ∀ s ∈ Ioo 0 ρ, ∀ i, G.dir i s < G.nextDir i s := fun s hs =>
    hord' ⟨hs.1, hs.2.trans_le (min_le_left _ _)⟩
  have h3pos : (0 : ℕ) < 3 := by norm_num
  -- each tile at `v` holds a sector at radius `ρ`; distinct tiles, distinct sectors
  have hsec : ∀ A, F.IsTile A → v ∈ closure A → ∃ i, G.sector v ρ i ⊆ A := fun A hA hvA =>
    hC.exists_sector_subset_tile h3pos hρ hA hvA
  have hdist : ∀ {A B : Set ℂ} {i j : Fin 3}, F.IsTile A → F.IsTile B → A ≠ B → G.sector v ρ i ⊆ A →
      G.sector v ρ j ⊆ B → i ≠ j := by
    rintro A B i j hA hB hAB hi hj rfl
    obtain ⟨w, hw⟩ := hC.sector_nonempty hρ i
    exact hAB (hA.eq_of_mem hB (hi hw) (hj hw))
  obtain ⟨iT, hiT⟩ := hsec T hT hvT
  obtain ⟨iX, hiX⟩ := hsec X hX hvX
  obtain ⟨iY, hiY⟩ := hsec Y hY hvY
  have hfin : ∀ a b c j : Fin 3, a ≠ b → a ≠ c → b ≠ c → j = a ∨ j = b ∨ j = c := by decide
  have hTXi := hdist hT hX hTX hiT hiX
  have hTYi := hdist hT hY hTY hiT hiY
  have hXYi := hdist hX hY hXY hiX hiY
  -- every tile at `v` is `T`, `X` or `Y`
  have hthree : ∀ S, F.IsTile S → v ∈ closure S → S = T ∨ S = X ∨ S = Y := by
    intro S hS hvS
    obtain ⟨i, hi⟩ := hsec S hS hvS
    obtain ⟨w, hw⟩ := hC.sector_nonempty hρ i
    have hwS := hi hw
    have hw' : w ∈ ball v ρ ∩ F.interiorPts := ⟨G.sector_subset_ball i hw, hS.subset_interiorPts hwS⟩
    rw [hC.cover ρ hρ h3pos] at hw'
    obtain ⟨j, hj⟩ := mem_iUnion.mp hw'
    rcases hfin iT iX iY j hTXi hTYi hXYi with rfl | rfl | rfl
    · exact Or.inl (hS.eq_of_mem hT hwS (hiT hj))
    · exact Or.inr (Or.inl (hS.eq_of_mem hX hwS (hiX hj)))
    · exact Or.inr (Or.inr (hS.eq_of_mem hY hwS (hiY hj)))
  -- a tile `A` of `T`'s outer domain at `v`: every point of `A` off a tile's closure is in an unbounded component (the tile is `T`, the third
  -- tile `B` — then `A` and `T` meet the far side of `B`'s sector — or misses `v`, and a small disc joins `A` to `T`)
  have key : ∀ A B : Set ℂ, ∀ iA iB : Fin 3, F.IsTile A → F.IsTile B → A ≠ B → T ≠ A → T ≠ B → A ⊆ outerDom T →
      v ∈ closure A → G.sector v ρ iA ⊆ A → G.sector v ρ iB ⊆ B → iT ≠ iA → iT ≠ iB → iA ≠ iB →
      (∀ S, F.IsTile S → v ∈ closure S → S = T ∨ S = A ∨ S = B) →
      ∀ T', F.IsTile T' → ∀ y ∈ A \ closure T', ¬ Bornology.IsBounded (connectedComponentIn (closure T')ᶜ y) := by
    intro A B iA iB hA hB hAB hTA hTB hAo hvA hiA hiB hTAi hTBi hABi h3 T' hT' y hy
    by_cases hT'T : T' = T
    · subst hT'T; exact (hAo hy.1).2
    have hT'A : T' ≠ A := fun h => hy.2 (h ▸ subset_closure hy.1)
    obtain ⟨t, ht⟩ := hT.nonempty
    have hTc : T ⊆ (closure T')ᶜ := IsTile.subset_compl_closure hT' hT (Ne.symm hT'T)
    have hAc : A ⊆ (closure T')ᶜ := IsTile.subset_compl_closure hT' hA (Ne.symm hT'A)
    obtain ⟨P, hPpre, hPsub, hyP, htP⟩ : ∃ P : Set ℂ, IsPreconnected P ∧ P ⊆ (closure T')ᶜ ∧ y ∈ P ∧ t ∈ P := by
      by_cases hvT' : v ∈ closure T'
      · have hT'B : T' = B := by
          rcases h3 T' hT' hvT' with h | h | h
          · exact absurd h hT'T
          · exact absurd h hT'A
          · exact h
        obtain ⟨O, hOo, hOpre, hOball, hOdisj, hOsub, -⟩ := G.exists_far_side (by norm_num) hord v iB
        have hOB : Disjoint O B := by
          rw [Set.disjoint_left]
          intro w hwO hwB
          have hw : w ∈ ball v ρ ∩ F.interiorPts := ⟨hOball hwO, hB.subset_interiorPts hwB⟩
          rw [hC.cover ρ hρ h3pos] at hw
          obtain ⟨j, hj⟩ := mem_iUnion.mp hw
          rcases hfin iT iA iB j hTAi hTBi hABi with rfl | rfl | rfl
          · exact hTB (hT.eq_of_mem hB (hiT hj) hwB)
          · exact hAB (hA.eq_of_mem hB (hiA hj) hwB)
          · exact Set.disjoint_left.mp hOdisj hwO hj
        have hOc : O ⊆ (closure T')ᶜ := by
          rw [hT'B]; exact (hOB.closure_right hOo).subset_compl_right
        obtain ⟨a, ha⟩ := hC.sector_nonempty hρ iA
        obtain ⟨b, hb⟩ := hC.sector_nonempty hρ iT
        have haO := hOsub iA hABi ha
        have hbO := hOsub iT hTBi hb
        refine ⟨A ∪ O ∪ T, ?_, union_subset (union_subset hAc hOc) hTc, Or.inl (Or.inl hy.1), Or.inr ht⟩
        exact (hA.isPreconnected.union a (hiA ha) haO hOpre).union b (Or.inr hbO) (hiT hb) hT.isPreconnected
      · obtain ⟨ε, hε, hεsub⟩ := Metric.isOpen_iff.mp isClosed_closure.isOpen_compl v hvT'
        obtain ⟨a, haA, ha⟩ := (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨v, hvA, mem_ball_self hε⟩
        obtain ⟨b, hbT, hb⟩ := (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨v, hvT, mem_ball_self hε⟩
        refine ⟨A ∪ ball v ε ∪ T, ?_, union_subset (union_subset hAc hεsub) hTc, Or.inl (Or.inl hy.1), Or.inr ht⟩
        exact (hA.isPreconnected.union a haA ha (convex_ball v ε).isPreconnected).union b (Or.inr hb) hbT
          hT.isPreconnected
    have hPc : P ⊆ connectedComponentIn (closure T')ᶜ y := hPpre.subset_connectedComponentIn hyP hPsub
    rw [connectedComponentIn_eq (hPc htP)]
    exact fun hb => hno T' hT' ⟨t, ⟨ht, hTc ht⟩, hb⟩
  intro T' S hT' hS hvS y hy
  rcases hthree S hS hvS with rfl | rfl | rfl
  · exact fun hb => hno T' hT' ⟨y, hy, hb⟩
  · exact key S Y iX iY hX hY hXY hTX hTY hXo hvX hiX hiY hTXi hTYi hXYi hthree T' hT' y hy
  · exact key S X iY iX hY hX hXY.symm hTY hTX hYo hvY hiY hiX hTYi hTXi hXYi.symm
      (fun S' hS' hvS' => (hthree S' hS' hvS').imp_right Or.symm) T' hT' y hy

/-! ## C — the rim of `u`'s component (FS131-E4 E4-RIM: the eleventh point) -/

/-- **Lemma H(a)** (E4-RIM step 1, FS110-CD Lemma H): in a valid map, a tile of a colour `j` whose `j`-tile `S` holds `u` in its closure, if it
meets `B(u, 1)`, lies in `B(u, 1)` (`S × T` is connected, carries no distance `1`, and holds a pair closer than `1`). Any `k`. -/
theorem tileOf_subset_ball (hF : F.Valid) {u : ℂ} {j : Fin k} {S T : Set ℂ} (hS : F.TileOf j S) (huS : u ∈ closure S)
    (hT : F.TileOf j T) (hTb : (T ∩ ball u 1).Nonempty) : T ⊆ ball u 1 := by
  -- no pair of the two tiles is at distance `1` (one colour, validity)
  have hne : ∀ s ∈ S, ∀ t ∈ T, dist s t ≠ 1 := fun s hs t ht h1 =>
    hF s (hS.1.subset_interiorPts hs) t (hT.1.subset_interiorPts ht) h1 (by rw [hS.2 hs, hT.2 ht])
  obtain ⟨t₀, ht₀T, ht₀u⟩ := hTb
  rw [mem_ball] at ht₀u
  -- a pair near `(u, t₀)` is closer than `1`
  obtain ⟨s₀, hs₀, hs₀d⟩ := Metric.mem_closure_iff.mp huS (1 - dist t₀ u) (by linarith)
  have hnear : dist s₀ t₀ < 1 := by
    have := dist_triangle s₀ u t₀
    rw [dist_comm u t₀, dist_comm s₀ u] at this
    linarith
  -- so every pair is closer than `1` (the distances over the connected `S × T` form an interval missing `1`)
  have hpre : IsPreconnected ((fun q : ℂ × ℂ => dist q.1 q.2) '' (S ×ˢ T)) :=
    (hS.1.isPreconnected.prod hT.1.isPreconnected).image _ (continuous_fst.dist continuous_snd).continuousOn
  have hall : ∀ q ∈ S ×ˢ T, dist q.1 q.2 ≤ 1 := by
    rintro ⟨s, t⟩ ⟨hs, ht⟩
    by_contra hlt
    push Not at hlt
    obtain ⟨q, hq, hq1⟩ := hpre.Icc_subset ⟨(s₀, t₀), ⟨hs₀, ht₀T⟩, rfl⟩ ⟨(s, t), ⟨hs, ht⟩, rfl⟩ ⟨hnear.le, hlt.le⟩
    exact hne q.1 hq.1 q.2 hq.2 hq1
  -- on the closure of `S`, so `dist u t ≤ 1` on `T`; `T` open makes it strict
  have hcl : closure (S ×ˢ T) ⊆ {q : ℂ × ℂ | dist q.1 q.2 ≤ 1} :=
    closure_minimal hall (isClosed_le (continuous_fst.dist continuous_snd) continuous_const)
  rw [closure_prod_eq] at hcl
  have hle : ∀ t ∈ T, dist t u ≤ 1 := fun t ht => by
    rw [dist_comm]; exact hcl (show (u, t) ∈ closure S ×ˢ closure T from ⟨huS, subset_closure ht⟩)
  intro t ht
  rw [mem_ball]
  refine lt_of_le_of_ne (hle t ht) fun h1 => ?_
  -- a point of `T` just beyond `t`, away from `u`, would be farther than `1`
  obtain ⟨ε, hε, hεT⟩ := Metric.isOpen_iff.mp hT.1.isOpen t ht
  set t' := t + ((ε / 2 : ℝ) : ℂ) * (t - u) with ht'
  have ht'T : t' ∈ T := hεT (by
    rw [mem_ball, ht', dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_of_nonneg (by linarith),
      ← dist_eq_norm, h1]
    linarith)
  have : dist t' u = (1 + ε / 2) * dist t u := by
    rw [ht', dist_eq_norm, dist_eq_norm, show t + ((ε / 2 : ℝ) : ℂ) * (t - u) - u = ((1 + ε / 2 : ℝ) : ℂ) * (t - u) by
      push_cast; ring, norm_mul, Complex.norm_real, Real.norm_of_nonneg (by linarith)]
  have := hle t' ht'T
  rw [‹dist t' u = _›, h1] at this
  linarith

/-- **A boundary on a unit circle, at a cubic touch point** (E4-RIM step 1's arc, for N3-NOBOTH): at a cubic trichromatic point `q` of the
domain, a tile `A` of colour `a` inside `B(u, 1)` and a tile `Y` of colour `c` off `B̄(u, 1)`, both holding `q` in their closures, are adjacent
sectors there; the branch between them lies on `ω(u)` (its points are closure points of both), and a short arc of it is an arc of `Γ` on `ω(u)` with
inner colour `a` and outer colour `c` (near a branch point only the two sectors it bounds: `eq_or_next_eq_of_mem_closure_sector`). -/
theorem exists_isRingArc_of_touch {u q : ℂ} (hq : q ∈ F.dom) (hcub : F.IsCubicTrichromatic q) {A Y : Set ℂ} {a c : Fin k}
    (hA : F.TileOf a A) (hY : F.TileOf c Y) (hAb : A ⊆ ball u 1) (hYb : Disjoint Y (closedBall u 1)) (hqA : q ∈ closure A)
    (hqY : q ∈ closure Y) : ∃ θ₁ θ₂, F.IsRingArc u θ₁ θ₂ a c := by
  have hπ := Real.pi_pos
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hq
  have hn3 : n = 3 := by
    obtain ⟨r, h1, h2⟩ := (hcub.1.and hC.hasDegree).exists
    rw [h1] at h2
    have : max n 1 = 3 := by exact_mod_cast h2.symm
    omega
  subst hn3
  obtain ⟨ρ', hρ', hord'⟩ :=
    mem_nhdsGT_iff_exists_Ioo_subset.mp (G.eventually_dir_lt_nextDir hC.sorted hC.pos hC.curv)
  set ρ := min (min ρ' r₀) (1 / 2) with hρdef
  have hρ : ρ ∈ Ioc 0 r₀ :=
    ⟨lt_min (lt_min hρ' hC.pos) (by norm_num), (min_le_left _ _).trans (min_le_right _ _)⟩
  have hρ2 : ρ ≤ 1 / 2 := min_le_right _ _
  have hord : ∀ s ∈ Ioo 0 ρ, ∀ i, G.dir i s < G.nextDir i s := fun s hs =>
    hord' ⟨hs.1, hs.2.trans_le ((min_le_left _ _).trans (min_le_left _ _))⟩
  have h3pos : (0 : ℕ) < 3 := by norm_num
  obtain ⟨iA, hiA⟩ := hC.exists_sector_subset_tile h3pos hρ hA.1 hqA
  obtain ⟨iY, hiY⟩ := hC.exists_sector_subset_tile h3pos hρ hY.1 hqY
  have hYball : Disjoint Y (ball u 1) :=
    Set.disjoint_left.mpr fun w hwY hwb => Set.disjoint_left.mp hYb hwY (ball_subset_closedBall hwb)
  have hiAY : iA ≠ iY := by
    rintro rfl
    obtain ⟨w, hw⟩ := hC.sector_nonempty hρ iA
    exact Set.disjoint_left.mp hYball (hiY hw) (hAb (hiA hw))
  have hclA : closure A ⊆ closedBall u 1 := (closure_mono hAb).trans (closure_ball u one_ne_zero).subset
  have hclY : closure Y ⊆ (ball u 1)ᶜ := (hYball.closure_left isOpen_ball).subset_compl_right
  -- the branch between the two sectors: germ `m`, with `next i₁ = m` and `{i₁, m} = {iA, iY}`
  have hadj : ∀ i j : Fin 3, i ≠ j → BranchGerms.next i = j ∨ BranchGerms.next j = i := by decide
  obtain ⟨i₁, m, hnext, hpair⟩ : ∃ i₁ m : Fin 3, BranchGerms.next i₁ = m ∧ ((i₁ = iA ∧ m = iY) ∨ (i₁ = iY ∧ m = iA)) := by
    rcases hadj iA iY hiAY with h | h
    · exact ⟨iA, iY, h, Or.inl ⟨rfl, rfl⟩⟩
    · exact ⟨iY, iA, h, Or.inr ⟨rfl, rfl⟩⟩
  set p : ℝ → ℂ := fun s => branchPt q (G.β m) (G.κ m) s with hp
  have hpcl : ∀ s ∈ Ioo 0 ρ, p s ∈ closure (G.sector q ρ iA) ∧ p s ∈ closure (G.sector q ρ iY) := by
    intro s hs
    have h1 := (G.branchPt_mem_closure_sector hord q m hs).1
    have h2 := (G.branchPt_mem_closure_sector hord q i₁ hs).2
    rw [hnext] at h2
    rcases hpair with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
    · exact ⟨h2, h1⟩
    · exact ⟨h1, h2⟩
  have hponly : ∀ s ∈ Ioo 0 ρ, ∀ j, p s ∈ closure (G.sector q ρ j) → j = iA ∨ j = iY := by
    intro s hs j hj
    rcases G.eq_or_next_eq_of_mem_closure_sector (by norm_num) hord q hs hj with h | h
    · rcases hpair with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
      · exact Or.inr h
      · exact Or.inl h
    · have := BranchGerms.next_injective (h.trans hnext.symm)
      rcases hpair with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
      · exact Or.inl this
      · exact Or.inr this
  have hpq : ∀ s, 0 ≤ s → ‖p s - q‖ = s := fun s hs => norm_branchPt_sub q _ _ hs
  have hp0 : p 0 = q := by simp [hp, branchPt]
  -- the branch lies on `ω(u)`
  have hunit : ∀ z, z ∈ closure A → z ∈ closure Y → ‖z - u‖ = 1 := by
    intro z h1 h2
    have h1' := hclA h1
    have h2' := hclY h2
    rw [mem_closedBall, dist_eq_norm] at h1'
    rw [mem_compl_iff, mem_ball, dist_eq_norm, not_lt] at h2'
    linarith
  have hpu : ∀ s ∈ Ico 0 ρ, ‖p s - u‖ = 1 := by
    intro s hs
    rcases eq_or_lt_of_le hs.1 with h0 | hpos
    · rw [← h0, hp0]; exact hunit q hqA hqY
    · exact hunit _ (closure_mono hiA (hpcl s ⟨hpos, hs.2⟩).1) (closure_mono hiY (hpcl s ⟨hpos, hs.2⟩).2)
  -- the sides along it
  have hside : ∀ s ∈ Ioo 0 ρ, F.innerColours u (p s) = {a} ∧ F.outerColours u (p s) = {c} := by
    intro s hs
    have hpb : p s ∈ ball q ρ := by rw [mem_ball, dist_eq_norm, hpq s hs.1.le]; exact hs.2
    have key : ∀ (U : Set ℂ) (c' : Fin k), p s ∈ closure (F.region c' ∩ U) →
        ∃ j, (j = iA ∨ j = iY) ∧ ∃ w ∈ G.sector q ρ j, w ∈ U ∧ F.col w = c' := by
      intro U c' h
      have h' : p s ∈ closure (⋃ j, G.sector q ρ j ∩ (F.region c' ∩ U)) := by
        refine closure_mono ?_ (isOpen_ball.inter_closure ⟨hpb, h⟩)
        rintro w ⟨hwb, hwr, hwU⟩
        have hw : w ∈ ball q ρ ∩ F.interiorPts := ⟨hwb, hwr.1⟩
        rw [hC.cover ρ hρ h3pos] at hw
        obtain ⟨j, hj⟩ := mem_iUnion.mp hw
        exact mem_iUnion.mpr ⟨j, hj, hwr, hwU⟩
      rw [closure_iUnion_of_finite] at h'
      obtain ⟨j, hj⟩ := mem_iUnion.mp h'
      obtain ⟨w, hwj, hwr, hwU⟩ : (G.sector q ρ j ∩ (F.region c' ∩ U)).Nonempty := by
        by_contra hne
        rw [not_nonempty_iff_eq_empty] at hne
        rw [hne, closure_empty] at hj
        exact hj
      exact ⟨j, hponly s hs j (closure_mono inter_subset_left hj), w, hwj, hwU, hwr.2⟩
    have hcolA : ∀ w ∈ G.sector q ρ iA, F.col w = a := fun w hw => hA.2 (hiA hw)
    have hcolY : ∀ w ∈ G.sector q ρ iY, F.col w = c := fun w hw => hY.2 (hiY hw)
    constructor
    · ext c'
      simp only [ArcMap.innerColours, mem_setOf_eq, mem_singleton_iff]
      constructor
      · intro h
        obtain ⟨j, hj, w, hwj, hwU, hwc⟩ := key (ball u 1) c' h
        rcases hj with rfl | rfl
        · rw [← hwc, hcolA w hwj]
        · exact absurd hwU (hclY (subset_closure (hiY hwj)))
      · intro h; rw [h]
        exact closure_mono (show A ⊆ F.region a ∩ ball u 1 from fun w hw => ⟨⟨hA.1.subset_interiorPts hw, hA.2 hw⟩, hAb hw⟩)
          (closure_mono hiA (hpcl s hs).1)
    · ext c'
      simp only [ArcMap.outerColours, mem_setOf_eq, mem_singleton_iff]
      constructor
      · intro h
        obtain ⟨j, hj, w, hwj, hwU, hwc⟩ := key (closedBall u 1)ᶜ c' h
        rcases hj with rfl | rfl
        · exact absurd (ball_subset_closedBall (hAb (hiA hwj))) hwU
        · rw [← hwc, hcolY w hwj]
      · intro h; rw [h]
        exact closure_mono (show Y ⊆ F.region c \ closedBall u 1 from
          fun w hw => ⟨⟨hY.1.subset_interiorPts hw, hY.2 hw⟩, fun hwc => Set.disjoint_left.mp hYb hw hwc⟩)
          (closure_mono hiY (hpcl s hs).2)
  -- the angle about `u` along the branch
  have hqu : ‖q - u‖ = 1 := by have := hpu 0 ⟨le_rfl, hρ.1⟩; rwa [hp0] at this
  have hqu0 : q - u ≠ 0 := fun h => by rw [h, norm_zero] at hqu; exact zero_ne_one hqu
  have hn1 : ∀ s ∈ Ico 0 ρ, ‖(p s - u) / (q - u)‖ = 1 := fun s hs => by rw [norm_div, hqu, div_one, hpu s hs]
  have hslit : ∀ s ∈ Ico 0 ρ, (p s - u) / (q - u) ∈ slitPlane := by
    intro s hs
    rw [mem_slitPlane_iff]
    by_contra hcon
    push Not at hcon
    have hsq : ((p s - u) / (q - u)).re * ((p s - u) / (q - u)).re +
        ((p s - u) / (q - u)).im * ((p s - u) / (q - u)).im = 1 := by
      rw [← Complex.normSq_apply, ← Complex.sq_norm, hn1 s hs]; norm_num
    have hre : ((p s - u) / (q - u)).re = -1 := by nlinarith [hcon.1, hcon.2]
    have hw1 : (p s - u) / (q - u) = -1 := Complex.ext (by simp [hre]) (by simp [hcon.2])
    rw [div_eq_iff hqu0] at hw1
    have h2 : p s - q = -2 * (q - u) := by linear_combination hw1
    have h3 : ‖p s - q‖ = 2 := by rw [h2, norm_mul, hqu]; norm_num
    rw [hpq s hs.1] at h3
    linarith [hs.2, hρ2]
  set g : ℝ → ℝ := fun s => arg ((p s - u) / (q - u)) with hg
  have hfc : Continuous fun s => (p s - u) / (q - u) :=
    ((continuous_branchPt q _ _).sub continuous_const).div_const _
  have hgc : ∀ s ∈ Ico 0 ρ, ContinuousAt g s := fun s hs =>
    ContinuousAt.comp (f := fun s => (p s - u) / (q - u)) (Complex.continuousAt_arg (hslit s hs)) hfc.continuousAt
  set θq := arg (q - u) with hθq
  have hrec : ∀ s ∈ Ico 0 ρ, ringPt u (θq + g s) = p s := by
    intro s hs
    have h1 : (p s - u) / (q - u) = e (g s) := by
      have := eq_polar_arg ((p s - u) / (q - u)); rw [hn1 s hs] at this; simpa using this
    have h2 : q - u = e θq := by
      have := eq_polar_arg (q - u); rw [hqu] at this; simpa using this
    show u + e (θq + g s) = p s
    rw [e_add, ← h2, ← h1]
    field_simp
    ring
  have hinj : ∀ s ∈ Ico 0 ρ, ∀ s' ∈ Ico 0 ρ, g s = g s' → s = s' := by
    intro s hs s' hs' h
    have := (hrec s hs).symm.trans (h ▸ hrec s' hs')
    rw [← hpq s hs.1, ← hpq s' hs'.1, this]
  -- two radii, their angles, and every angle between
  set s₁ := ρ / 4 with hs₁
  set s₂ := ρ / 2 with hs₂
  have hs₁m : s₁ ∈ Ico 0 ρ := ⟨by linarith [hρ.1], by linarith [hρ.1]⟩
  have hs₂m : s₂ ∈ Ico 0 ρ := ⟨by linarith [hρ.1], by linarith [hρ.1]⟩
  have hg12 : g s₁ ≠ g s₂ := fun h => by have := hinj _ hs₁m _ hs₂m h; linarith [hρ.1]
  have hcon : ContinuousOn g (uIcc s₁ s₂) := fun s hs => by
    rw [uIcc_of_le (by linarith [hρ.1])] at hs
    exact (hgc s ⟨by linarith [hs.1, hρ.1], by linarith [hs.2, hρ.1]⟩).continuousWithinAt
  have hivt := intermediate_value_uIcc hcon
  have hfind : ∀ θ ∈ Icc (θq + min (g s₁) (g s₂)) (θq + max (g s₁) (g s₂)), ∃ s ∈ Ioo 0 ρ, ringPt u θ = p s := by
    intro θ hθ
    obtain ⟨s, hs, hgs⟩ := hivt (show θ - θq ∈ uIcc (g s₁) (g s₂) from ⟨by linarith [hθ.1], by linarith [hθ.2]⟩)
    rw [uIcc_of_le (by linarith [hρ.1])] at hs
    have hsm : s ∈ Ioo 0 ρ := ⟨by linarith [hs.1, hρ.1], by linarith [hs.2, hρ.1]⟩
    refine ⟨s, hsm, ?_⟩
    rw [← hrec s ⟨hsm.1.le, hsm.2⟩, hgs]; ring_nf
  refine ⟨θq + min (g s₁) (g s₂), θq + max (g s₁) (g s₂), ⟨?_, ?_, ?_⟩⟩
  · have := min_lt_max.mpr hg12; linarith
  · rintro z ⟨θ, hθ, rfl⟩
    obtain ⟨s, hs, hz⟩ := hfind θ hθ
    rw [hz]
    have hmem : p s ∈ (F.Γ ∩ ball q r₀) \ {q} := by
      rw [hC.branches]
      exact mem_iUnion.mpr ⟨m, s, ⟨hs.1, hs.2.trans_le hρ.2⟩, rfl⟩
    exact hmem.1.1
  · intro θ hθ
    obtain ⟨s, hs, hz⟩ := hfind θ ⟨hθ.1.le, hθ.2.le⟩
    rw [hz]
    exact hside s hs

/-- **The eleventh point** (FS131-E4 E4-RIM, all five steps; `BaseCtx.exists_eleventh`'s content with the context's fields as hypotheses).
`R*` is the component of `u` in the union of the closures of the tiles of `u`'s colours meeting `B(u, 1)` (finitely many); its tiles lie in
`B(u, 1)` (`tileOf_subset_ball`) and every tile of `u`'s colours touching it is one of them (N3-NOBOTH, `noBoth`, at a touching point on
`ω(u)`); the frontier of `R*`'s outer domain is preconnected and meets two of its tiles (one alone would enclose `u`'s other tiles, against
`UnenclosedC u`: `isBounded_connectedComponentIn_of_frontier_subset`); two meet there (`exists_inter_of_finite_closed_cover`) at `q`; a tile at
`q` meets the outer domain and has no colour of `u`; no fourth colour. -/
theorem exists_eleventh_of {F : ArcMap 6} {u : ℂ} (hF : F.Valid) (hcov : F.Covers u 2) (hu : F.IsCubicTrichromatic u)
    (hH : F.BaseHyp u) (hE : F.UnenclosedC u) :
    ∃ q ∈ closedBall u 1, (F.coloursAt q).ncard = 3 ∧ (F.coloursAt q ∩ F.coloursAt u).ncard = 2 ∧
      ∀ j ∈ F.coloursAt q ∩ F.coloursAt u, ∀ T, F.TileOf j T → q ∈ closure T → T ⊆ ball u 1 := by
  have hud : u ∈ F.dom := hcov (mem_closedBall_self (by norm_num))
  have h1d : closedBall u 1 ⊆ F.dom := (closedBall_subset_closedBall (by norm_num)).trans hcov
  have hgood : ∀ z ∈ closedBall u 1, z ∉ F.fourSet ∪ F.repSet := fun z hz hbad =>
    Set.disjoint_left.mp hH (closedBall_subset_closedBall (by norm_num) hz) hbad
  set C := F.coloursAt u with hCdef
  have hcoluniq : ∀ {T : Set ℂ} {i j : Fin 6}, F.TileOf i T → F.TileOf j T → i = j := by
    intro T i j hi hj
    obtain ⟨w, hw⟩ := hi.1.nonempty
    have h1 : F.col w = i := hi.2 hw
    have h2 : F.col w = j := hj.2 hw
    exact h1.symm.trans h2
  -- (i) each colour of `u` has a tile at `u`
  have htileAt : ∀ j ∈ C, ∃ S, F.TileOf j S ∧ u ∈ closure S := by
    intro j hj
    have hsub : F.region j ⊆ ⋃ T ∈ {T | F.TileOf j T}, closure T := by
      intro z hz
      have hT : F.IsTile (connectedComponentIn F.interiorPts z) := ⟨z, hz.1, rfl⟩
      have h := hT.tileOf (mem_connectedComponentIn hz.1)
      rw [show F.col z = j from hz.2] at h
      exact mem_iUnion₂.mpr ⟨_, h, subset_closure (mem_connectedComponentIn hz.1)⟩
    obtain ⟨S, hS, huS⟩ := exists_mem_closure_of_mem_closure_biUnion (fun T hT => hT.1) hud (closure_mono hsub hj)
    exact ⟨S, hS, huS⟩
  -- (ii) a tile of a colour of `u` meeting `B̄(u, 1)` lies in `B(u, 1)` (Lemma H(a))
  have hinside : ∀ j ∈ C, ∀ T, F.TileOf j T → (T ∩ closedBall u 1).Nonempty → T ⊆ ball u 1 := by
    rintro j hj T hT ⟨z, hzT, hzb⟩
    obtain ⟨S, hS, huS⟩ := htileAt j hj
    rw [← closure_ball u one_ne_zero] at hzb
    obtain ⟨w, hwT, hwb⟩ := (_root_.mem_closure_iff.mp hzb) T hT.1.isOpen hzT
    exact tileOf_subset_ball hF hS huS hT ⟨w, hwT, hwb⟩
  have hcolAt : ∀ {P : Set ℂ} {z : ℂ}, F.IsTile P → z ∈ closure P → ∃ c, F.TileOf c P ∧ c ∈ F.coloursAt z := by
    intro P z hP hzP
    obtain ⟨p, hp⟩ := hP.nonempty
    refine ⟨F.col p, hP.tileOf hp, ?_⟩
    show z ∈ closure (F.region (F.col p))
    exact closure_mono (show P ⊆ F.region (F.col p) from fun w hw => ⟨hP.subset_interiorPts hw, (hP.tileOf hp).2 hw⟩) hzP
  -- (iii) the family, its union of closures `K₀`, and `u`'s component `R`
  set 𝒯 := {T | (∃ j ∈ C, F.TileOf j T) ∧ (T ∩ ball u 1).Nonempty} with h𝒯
  have h𝒯ball : ∀ T ∈ 𝒯, T ⊆ ball u 1 := by
    rintro T ⟨⟨j, hj, hT⟩, w, hwT, hwb⟩
    exact hinside j hj T hT ⟨w, hwT, ball_subset_closedBall hwb⟩
  have h𝒯tile : ∀ T ∈ 𝒯, F.IsTile T := fun T hT => by obtain ⟨⟨j, -, hTj⟩, -⟩ := hT; exact hTj.1
  have h𝒯fin : 𝒯.Finite := (finite_tiles_closure_inter (isCompact_closedBall u 1) h1d).subset fun T hT => by
    obtain ⟨⟨j, hj, hTj⟩, w, hwT, hwb⟩ := hT
    exact ⟨hTj.1, w, subset_closure hwT, ball_subset_closedBall hwb⟩
  set K₀ := ⋃ T ∈ 𝒯, closure T with hK₀
  have hK₀c : IsClosed K₀ := h𝒯fin.isClosed_biUnion fun _ _ => isClosed_closure
  have hK₀b : K₀ ⊆ closedBall u 1 :=
    iUnion₂_subset fun T hT => (closure_mono (h𝒯ball T hT)).trans (closure_ball u one_ne_zero).subset
  have hat : ∀ S, F.IsTile S → u ∈ closure S → S ∈ 𝒯 := by
    intro S hS huS
    obtain ⟨c, hc, hcu⟩ := hcolAt hS huS
    exact ⟨⟨c, hcu, hc⟩, (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨u, huS, mem_ball_self one_pos⟩⟩
  obtain ⟨S₀, hS₀, huS₀⟩ := F.mem_closure_tile hud
  have huK : u ∈ K₀ := mem_iUnion₂.mpr ⟨S₀, hat S₀ hS₀ huS₀, huS₀⟩
  set R := connectedComponentIn K₀ u with hR
  have hRpre : IsPreconnected R := isPreconnected_connectedComponentIn
  have huR : u ∈ R := mem_connectedComponentIn huK
  have hRK : R ⊆ K₀ := connectedComponentIn_subset _ _
  have hRc : IsClosed R :=
    isClosed_of_closure_subset (hRpre.closure.subset_connectedComponentIn (subset_closure huR) (closure_minimal hRK hK₀c))
  have hRb : R ⊆ closedBall u 1 := hRK.trans hK₀b
  have hRbd : Bornology.IsBounded R := isBounded_closedBall.subset hRb
  have hinR : ∀ T ∈ 𝒯, (closure T ∩ R).Nonempty → closure T ⊆ R := by
    rintro T hT ⟨z, hzT, hzR⟩
    have hcl : closure T ⊆ K₀ := subset_biUnion_of_mem (u := fun T => closure T) hT
    rw [hR, connectedComponentIn_eq hzR]
    exact (h𝒯tile T hT).isPreconnected.closure.subset_connectedComponentIn hzT hcl
  -- (iv) the unbounded component `W` of `Rᶜ` and its frontier
  set z₀ : ℂ := u + 2 with hz₀def
  have hz₀b : z₀ ∉ closedBall u 1 := by
    rw [mem_closedBall, dist_eq_norm, hz₀def, add_sub_cancel_left]; norm_num
  have hz₀R : z₀ ∉ R := fun h => hz₀b (hRb h)
  set W := connectedComponentIn Rᶜ z₀ with hW
  have hWo : IsOpen W := hRc.isOpen_compl.connectedComponentIn
  have hcompW : (closedBall u 1)ᶜ ⊆ W :=
    (isPreconnected_compl_closedBall u 1).subset_connectedComponentIn hz₀b (compl_subset_compl.mpr hRb)
  have hWunb : ¬ Bornology.IsBounded W := fun hb => NormedSpace.unbounded_univ ℝ ℂ
    (((isBounded_closedBall (x := u) (r := 1)).union hb).subset fun z _ => by
      by_cases h : z ∈ closedBall u 1
      · exact Or.inl h
      · exact Or.inr (hcompW h))
  have hWR : Disjoint W R := Set.disjoint_left.mpr fun z hz hzR => connectedComponentIn_subset _ _ hz hzR
  set Φ := frontier W with hΦ
  have hΦR : Φ ⊆ R := fun v hv => by simpa using frontier_connectedComponentIn_subset hRc.isOpen_compl z₀ hv
  have hΦpre : IsPreconnected Φ := isPreconnected_frontier_connectedComponentIn hRc hRpre z₀
  have hΦne : Φ.Nonempty := by
    rw [hΦ, nonempty_frontier_iff]
    exact ⟨⟨z₀, mem_connectedComponentIn hz₀R⟩, fun h => Set.disjoint_left.mp hWR (h ▸ mem_univ u : u ∈ W) huR⟩
  -- (v) two family tiles meet on `Φ`
  set s := {T | T ∈ 𝒯 ∧ (closure T ∩ Φ).Nonempty} with hs
  have hsfin : s.Finite := h𝒯fin.subset fun T hT => hT.1
  have hcov' : Φ ⊆ ⋃ T ∈ s, closure T := by
    intro v hv
    obtain ⟨T, hT, hvT⟩ := mem_iUnion₂.mp (hRK (hΦR hv))
    exact mem_iUnion₂.mpr ⟨T, ⟨hT, v, hvT, hv⟩, hvT⟩
  obtain ⟨v₀, hv₀⟩ := hΦne
  obtain ⟨X, hXs, hv₀X⟩ := mem_iUnion₂.mp (hcov' hv₀)
  obtain ⟨Y', hY's, hXY'⟩ : ∃ Y' ∈ s, X ≠ Y' := by
    by_contra hall
    push Not at hall
    have hΦX : Φ ⊆ closure X := fun v hv => by
      obtain ⟨Y', hY's, hvY'⟩ := mem_iUnion₂.mp (hcov' hv)
      rwa [← hall Y' hY's] at hvY'
    obtain ⟨⟨j, hj, hXj⟩, -⟩ := hXs.1
    obtain ⟨j', hj', hjj'⟩ : ∃ j' ∈ C, j' ≠ j := by
      by_contra hno
      push Not at hno
      have h1 := Set.ncard_le_ncard (show C ⊆ {j} from fun x hx => hno x hx) (Set.finite_singleton j)
      rw [Set.ncard_singleton] at h1
      have h3 : C.ncard = 3 := hu.2
      omega
    obtain ⟨S, hS, huS⟩ := htileAt j' hj'
    have hSX : S ≠ X := fun h => hjj' (hcoluniq hS (h ▸ hXj))
    obtain ⟨y, hy⟩ := hS.1.nonempty
    have hyR : y ∈ R := hinR S (hat S hS.1 huS) ⟨u, huS, huR⟩ (subset_closure hy)
    have hyX : y ∉ closure X := IsTile.subset_compl_closure hXj.1 hS.1 hSX hy
    apply hE j hj X S hXj hS.1 huS y ⟨hy, hyX⟩
    exact isBounded_connectedComponentIn_of_frontier_subset hRc hRbd isClosed_closure hWunb hΦX
      (fun h => Set.disjoint_left.mp hWR h hyR) hyX
  obtain ⟨T₀, hT₀s, T₁, hT₁s, hT₀₁, q, ⟨hqΦ, hqT₀⟩, hqT₁⟩ :=
    exists_inter_of_finite_closed_cover hΦpre hsfin (fun T => closure T) (fun _ _ => isClosed_closure) hcov' hXs hY's hXY'
      ⟨v₀, hv₀, hv₀X⟩ (by obtain ⟨w, hw1, hw2⟩ := hY's.2; exact ⟨w, hw2, hw1⟩)
  have hqR : q ∈ R := hΦR hqΦ
  have hqb : q ∈ closedBall u 1 := hRb hqR
  have hqd : q ∈ F.dom := h1d hqb
  have hT₀ := h𝒯tile T₀ hT₀s.1
  have hT₁ := h𝒯tile T₁ hT₁s.1
  -- (vi) a tile at `q` meets `W`; `q` is cubic trichromatic
  obtain ⟨Y, hY, ⟨w, hwY, hwW⟩, hqY⟩ := exists_tile_mem_closure_of_mem_closure hWo hqd hqΦ.1
  have hT₀R : closure T₀ ⊆ R := hinR T₀ hT₀s.1 ⟨q, hqT₀, hqR⟩
  have hT₁R : closure T₁ ⊆ R := hinR T₁ hT₁s.1 ⟨q, hqT₁, hqR⟩
  have hYT₀ : Y ≠ T₀ := fun h => Set.disjoint_left.mp hWR hwW (hT₀R (subset_closure (h ▸ hwY)))
  have hYT₁ : Y ≠ T₁ := fun h => Set.disjoint_left.mp hWR hwW (hT₁R (subset_closure (h ▸ hwY)))
  have hcubq := isCubicTrichromatic_of_three_tiles hqd hT₀ hT₁ hY hT₀₁ hYT₀.symm hYT₁.symm hqT₀ hqT₁ hqY (hgood q hqb)
  obtain ⟨a, haT₀, haq⟩ := hcolAt hT₀ hqT₀
  obtain ⟨b, hbT₁, hbq⟩ := hcolAt hT₁ hqT₁
  obtain ⟨c, hcY, hcq⟩ := hcolAt hY hqY
  have haC : a ∈ C := by obtain ⟨⟨j, hj, hj'⟩, -⟩ := hT₀s.1; exact hcoluniq hj' haT₀ ▸ hj
  have hbC : b ∈ C := by obtain ⟨⟨j, hj, hj'⟩, -⟩ := hT₁s.1; exact hcoluniq hj' hbT₁ ▸ hj
  -- (vii) `Y` carries no colour of `u`
  have hcC : c ∉ C := by
    intro hcC
    by_cases hYb : (Y ∩ ball u 1).Nonempty
    · exact Set.disjoint_left.mp hWR hwW (hinR Y ⟨⟨c, hcC, hcY⟩, hYb⟩ ⟨q, hqY, hqR⟩ (subset_closure hwY))
    · have hYcb : Disjoint Y (closedBall u 1) := Set.disjoint_left.mpr fun z hzY hzb =>
        hYb ⟨z, hzY, hinside c hcC Y hcY ⟨z, hzY, hzb⟩ hzY⟩
      obtain ⟨θ₁, θ₂, harc⟩ := exists_isRingArc_of_touch hqd hcubq haT₀ hcY (h𝒯ball T₀ hT₀s.1) hYcb hqT₀ hqY
      rcases noBoth hF hud ⟨a, c, harc, haC, hcC⟩ with h4 | hrep
      · exact hgood u (mem_closedBall_self zero_le_one) (Or.inl ⟨hud, h4⟩)
      · exact hgood u (mem_closedBall_self zero_le_one) (Or.inr ⟨hud, hrep⟩)
  -- (viii) the colours
  have hrep : ¬ F.HasRepeatedColour q := fun h => hgood q hqb (Or.inr ⟨hqd, h⟩)
  have hab : a ≠ b := fun h => hrep (hasRepeatedColour_of_two_tiles hqd haT₀ (h ▸ hbT₁) hT₀₁ hqT₀ hqT₁)
  have hac : a ≠ c := fun h => hcC (h ▸ haC)
  have hbc : b ≠ c := fun h => hcC (h ▸ hbC)
  have hq3 : F.coloursAt q = {a, b, c} := by
    symm
    apply Set.eq_of_subset_of_ncard_le
    · exact insert_subset_iff.mpr ⟨haq, insert_subset_iff.mpr ⟨hbq, singleton_subset_iff.mpr hcq⟩⟩
    · rw [hcubq.2, Set.ncard_eq_three.mpr ⟨a, b, c, hab, hac, hbc, rfl⟩]
    · exact Set.toFinite _
  have hinter : F.coloursAt q ∩ C = {a, b} := by
    rw [hq3]
    ext x
    simp only [mem_inter_iff, mem_insert_iff, mem_singleton_iff]
    constructor
    · rintro ⟨h | h | h, hx⟩
      · exact Or.inl h
      · exact Or.inr h
      · exact absurd (h ▸ hx) hcC
    · rintro (h | h)
      · exact ⟨Or.inl h, h ▸ haC⟩
      · exact ⟨Or.inr (Or.inl h), h ▸ hbC⟩
  refine ⟨q, hqb, hcubq.2, by rw [hinter]; exact Set.ncard_pair hab, ?_⟩
  intro j hj T hT hqT
  rw [hinter] at hj
  rcases hj with h | h
  · subst h
    by_cases hTT₀ : T = T₀
    · rw [hTT₀]; exact h𝒯ball T₀ hT₀s.1
    · exact absurd (hasRepeatedColour_of_two_tiles hqd hT haT₀ hTT₀ hqT hqT₀) hrep
  · rw [mem_singleton_iff] at h
    subst h
    by_cases hTT₁ : T = T₁
    · rw [hTT₁]; exact h𝒯ball T₁ hT₁s.1
    · exact absurd (hasRepeatedColour_of_two_tiles hqd hT hbT₁ hTT₁ hqT hqT₁) hrep

/-! ## D — the common boundary of two tiles in a disc; arcs of one circle -/

/-! ### The boundary of two tiles near a point: a star of curve rays (BG's map side, FS131-IP3) -/

/-- The colour is constant on a sector. -/
theorem IsSectorChart.col_eq_of_mem_sector {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀) (hn : 0 < n)
    {r : ℝ} (hr : r ∈ Ioc 0 r₀) {i : Fin n} {w w' : ℂ} (hw : w ∈ G.sector v r i) (hw' : w' ∈ G.sector v r i) : F.col w' = F.col w :=
  (hC.isPreconnected r hr i).constant (F.continuousOn_col.mono (hC.sector_subset_interiorPts hn hr i)) hw' hw

/-- A sector's colour is carried at the chart's point. -/
theorem IsSectorChart.col_mem_coloursAt {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀) (hn : 0 < n)
    {r : ℝ} (hr : r ∈ Ioc 0 r₀) {i : Fin n} {w : ℂ} (hw : w ∈ G.sector v r i) : F.col w ∈ F.coloursAt v := by
  refine closure_mono ?_ (hC.mem_closure_sector hr i)
  intro y hy
  exact ⟨hC.sector_subset_interiorPts hn hr i hy, hC.col_eq_of_mem_sector hn hr hw hy⟩

/-- **Two sectors of one colour make a repeated colour** (at every smaller radius they are two distinct sectors of that colour). -/
theorem IsSectorChart.hasRepeatedColour_of_col_eq {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    (hn : 0 < n) {r : ℝ} (hr : r ∈ Ioc 0 r₀) {i j : Fin n} (hij : i ≠ j) {w w' : ℂ} (hw : w ∈ G.sector v r i)
    (hw' : w' ∈ G.sector v r j) (hcol : F.col w = F.col w') : F.HasRepeatedColour v := by
  refine ⟨F.col w, ?_⟩
  filter_upwards [Ioc_mem_nhdsGT hr.1] with r' hr'
  have hr'₀ : r' ∈ Ioc 0 r₀ := ⟨hr'.1, hr'.2.trans hr.2⟩
  have hSi : G.sector v r' i ∈ F.sectorsOf v r' (F.col w) :=
    ⟨(hC.isSector_iff hn hr'₀).mpr ⟨i, rfl⟩, fun y hy => hC.col_eq_of_mem_sector hn hr hw (G.sector_mono hr'.2 i hy)⟩
  have hSj : G.sector v r' j ∈ F.sectorsOf v r' (F.col w) :=
    ⟨(hC.isSector_iff hn hr'₀).mpr ⟨j, rfl⟩, fun y hy => by
      show F.col y = F.col w
      rw [hcol]; exact hC.col_eq_of_mem_sector hn hr hw' (G.sector_mono hr'.2 j hy)⟩
  have hne : G.sector v r' i ≠ G.sector v r' j := by
    intro h
    obtain ⟨y, hy⟩ := hC.sector_nonempty hr'₀ i
    exact Set.disjoint_left.mp (hC.disjoint r' hr'₀ i j hij) hy (h ▸ hy)
  calc (2 : ℕ∞) = ({G.sector v r' i, G.sector v r' j} : Set (Set ℂ)).encard := (Set.encard_pair hne).symm
    _ ≤ (F.sectorsOf v r' (F.col w)).encard := Set.encard_le_encard (insert_subset_iff.mpr ⟨hSi, singleton_subset_iff.mpr hSj⟩)

/-- **Two tiles, two colours, no repeated colour: two germs.** A sector chart at a point in the closures of two distinct tiles, carrying two
colours and no repeated colour, has exactly two germs. -/
theorem IsSectorChart.eq_two {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀) {T₁ T₂ : Set ℂ}
    (h₁ : F.IsTile T₁) (h₂ : F.IsTile T₂) (hne : T₁ ≠ T₂) (hv₁ : v ∈ closure T₁) (hv₂ : v ∈ closure T₂)
    (hnr : ¬ F.HasRepeatedColour v) (h2 : (F.coloursAt v).ncard = 2) : n = 2 := by
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  have hn : 0 < n := by
    by_contra h0
    have hball := hC.empty (by omega)
    obtain ⟨a, haA, hab⟩ := (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨v, hv₁, mem_ball_self hC.pos⟩
    obtain ⟨b, hbB, hbb⟩ := (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨v, hv₂, mem_ball_self hC.pos⟩
    have h1 : ball v r₀ ⊆ T₁ := by
      obtain ⟨x, hx, hAx⟩ := h₁
      rw [hAx, connectedComponentIn_eq (hAx ▸ haA)]
      exact (convex_ball v r₀).isPreconnected.subset_connectedComponentIn hab hball
    exact hne (h₁.eq_of_mem h₂ (h1 hbb) hbB)
  obtain ⟨i₁, hi₁⟩ := hC.exists_sector_subset_tile hn hr₀ h₁ hv₁
  obtain ⟨i₂, hi₂⟩ := hC.exists_sector_subset_tile hn hr₀ h₂ hv₂
  have hi12 : i₁ ≠ i₂ := by
    rintro rfl
    obtain ⟨y, hy⟩ := hC.sector_nonempty hr₀ i₁
    exact hne (h₁.eq_of_mem h₂ (hi₁ hy) (hi₂ hy))
  have hge : 2 ≤ n := by
    by_contra h
    have : n = 1 := by omega
    subst this
    exact hi12 (Subsingleton.elim _ _)
  by_contra hne2
  have h3 : 3 ≤ n := by omega
  set j₀ : Fin n := ⟨0, by omega⟩
  set j₁ : Fin n := ⟨1, by omega⟩
  set j₂ : Fin n := ⟨2, by omega⟩
  obtain ⟨w₀, hw₀⟩ := hC.sector_nonempty hr₀ j₀
  obtain ⟨w₁, hw₁⟩ := hC.sector_nonempty hr₀ j₁
  obtain ⟨w₂, hw₂⟩ := hC.sector_nonempty hr₀ j₂
  have hd : ∀ {a b : Fin n} {wa wb : ℂ}, a ≠ b → wa ∈ G.sector v r₀ a → wb ∈ G.sector v r₀ b → F.col wa ≠ F.col wb :=
    fun hab ha hb hc => hnr (hC.hasRepeatedColour_of_col_eq hn hr₀ hab ha hb hc)
  have h01 : j₀ ≠ j₁ := by simp [j₀, j₁, Fin.ext_iff]
  have h02 : j₀ ≠ j₂ := by simp [j₀, j₂, Fin.ext_iff]
  have h12 : j₁ ≠ j₂ := by simp [j₁, j₂, Fin.ext_iff]
  have hsub : ({F.col w₀, F.col w₁, F.col w₂} : Set (Fin k)) ⊆ F.coloursAt v := by
    intro c hc
    rcases hc with rfl | rfl | rfl
    · exact hC.col_mem_coloursAt hn hr₀ hw₀
    · exact hC.col_mem_coloursAt hn hr₀ hw₁
    · exact hC.col_mem_coloursAt hn hr₀ hw₂
  have hcard : ({F.col w₀, F.col w₁, F.col w₂} : Set (Fin k)).ncard = 3 :=
    Set.ncard_eq_three.mpr ⟨_, _, _, hd h01 hw₀ hw₁, hd h02 hw₀ hw₂, hd h12 hw₁ hw₂, rfl⟩
  have := Set.ncard_le_ncard hsub (Set.toFinite _)
  omega

/-- **Near a two-germ point the common boundary of its two tiles is the two branches**: with the sectors in `T₁` and `T₂`, out to a radius
where the germs are strictly ordered, `cl T₁ ∩ cl T₂` is the point and its two branches. -/
theorem IsSectorChart.inter_closure_two {G : BranchGerms 2} {v : ℂ} {r₀ ρ : ℝ} (hC : F.IsSectorChart G v r₀) (hρ : ρ ∈ Ioc 0 r₀)
    (hord : ∀ s ∈ Ioo 0 ρ, ∀ i, G.dir i s < G.nextDir i s) {T₁ T₂ : Set ℂ} (h₁ : F.IsTile T₁) (h₂ : F.IsTile T₂) (hne : T₁ ≠ T₂)
    (hv₁ : v ∈ closure T₁) (hv₂ : v ∈ closure T₂) {i₁ i₂ : Fin 2} (hi₁ : G.sector v ρ i₁ ⊆ T₁)
    (hi₂ : G.sector v ρ i₂ ⊆ T₂) {r : ℝ} (hr : r ∈ Ioc 0 ρ) :
    closure T₁ ∩ closure T₂ ∩ ball v r = insert v (⋃ i, branchPt v (G.β i) (G.κ i) '' Ioo 0 r) := by
  apply Subset.antisymm
  · rintro w ⟨⟨hw₁, hw₂⟩, hwb⟩
    by_cases hwv : w = v
    · exact Or.inl hwv
    right
    have hwb₀ : w ∈ ball v r₀ := ball_subset_ball (hr.2.trans hρ.2) hwb
    have hwd : w ∈ F.dom := hC.subdom hwb₀
    have hwΓ : w ∈ ⋃ a ∈ F.arcs, a.carrier := by
      by_contra hwi
      have hwI : w ∈ F.interiorPts := ⟨hwd, hwi⟩
      have hZ : F.IsTile (connectedComponentIn F.interiorPts w) := ⟨w, hwI, rfl⟩
      have key : ∀ D, F.IsTile D → w ∈ closure D → D = connectedComponentIn F.interiorPts w := by
        intro D hD hwD
        obtain ⟨y, hyD, hyZ⟩ := (closure_inter_open_nonempty_iff hZ.isOpen).mp ⟨w, hwD, mem_connectedComponentIn hwI⟩
        exact hD.eq_of_mem hZ hyD hyZ
      exact hne ((key T₁ h₁ hw₁).trans (key T₂ h₂ hw₂).symm)
    have hmem : w ∈ (F.Γ ∩ ball v r₀) \ {v} := ⟨⟨⟨hwd, hwΓ⟩, hwb₀⟩, hwv⟩
    rw [hC.branches] at hmem
    obtain ⟨m, s, hs, rfl⟩ := mem_iUnion.mp hmem
    refine mem_iUnion.mpr ⟨m, s, ⟨hs.1, ?_⟩, rfl⟩
    have := norm_branchPt_sub v (G.β m) (G.κ m) hs.1.le
    rw [mem_ball, dist_eq_norm, this] at hwb
    exact hwb
  · rintro w (rfl | hw)
    · exact ⟨⟨hv₁, hv₂⟩, mem_ball_self hr.1⟩
    obtain ⟨i, s, hs, rfl⟩ := mem_iUnion.mp hw
    have hsρ : s ∈ Ioo 0 ρ := ⟨hs.1, hs.2.trans_le hr.2⟩
    have hboth : ∀ i : Fin 2, branchPt v (G.β i) (G.κ i) s ∈ closure (G.sector v ρ 0) ∩ closure (G.sector v ρ 1) := by
      intro i
      have b0 := G.branchPt_mem_closure_sector hord v 0 hsρ
      have b1 := G.branchPt_mem_closure_sector hord v 1 hsρ
      have hn0 : BranchGerms.next (0 : Fin 2) = 1 := rfl
      have hn1 : BranchGerms.next (1 : Fin 2) = 0 := rfl
      rw [hn0] at b0
      rw [hn1] at b1
      fin_cases i
      · exact ⟨b0.1, b1.2⟩
      · exact ⟨b0.2, b1.1⟩
    have hcl : ∀ j : Fin 2, branchPt v (G.β i) (G.κ i) s ∈ closure (G.sector v ρ j) := by
      intro j; fin_cases j
      · exact (hboth i).1
      · exact (hboth i).2
    refine ⟨⟨closure_mono hi₁ (hcl i₁), closure_mono hi₂ (hcl i₂)⟩, ?_⟩
    rw [mem_ball, dist_eq_norm, norm_branchPt_sub v _ _ hs.1.le]
    exact hs.2

/-- **The branches of strictly ordered germs form a curve star**: if near `v` the set `C` is `v` and the branches of `G` (graphs over the
radius, strictly ordered at each distance), it has a curve star of `n` rays at `v`. -/
theorem hasCurveStar_of_branches {C : Set ℂ} {v : ℂ} {n : ℕ} (G : BranchGerms n) {r : ℝ} (hr : 0 < r)
    (hord : ∀ s ∈ Ioo 0 r, ∀ i, G.dir i s < G.nextDir i s) (hcurv : ∀ i, |G.κ i| * r < 2)
    (heq : C ∩ ball v r = insert v (⋃ i, branchPt v (G.β i) (G.κ i) '' Ioo 0 r)) : HasCurveStar C v n := by
  have hπ := Real.pi_pos
  refine ⟨r, hr, fun i => branchPt v (G.β i) (G.κ i), fun i => (continuous_branchPt v _ _).continuousOn,
    fun i s hs => norm_branchPt_sub v _ _ hs.1.le, ?_, heq, fun i s hs => branch_locally_curve v _ _ (hcurv i) hs⟩
  -- distinct germs, distinct points at one distance
  have key : ∀ i j : Fin n, i < j → ∀ s ∈ Ioo 0 r, branchPt v (G.β i) (G.κ i) s ≠ branchPt v (G.β j) (G.κ j) s := by
    intro i j hij s hs h
    rw [branchPt_eq, branchPt_eq, polar_eq_iff hs.1 hs.1] at h
    have h1 := G.dir_lt_dir (hord s hs) hij
    have h2 := G.dir_lt_dir_zero_add (hord s hs) j
    have h3 := G.dir_le_dir (hord s hs) (show (⟨0, j.pos⟩ : Fin n) ≤ i from Fin.mk_le_mk.mpr (Nat.zero_le _))
    have he : e (G.dir j s - G.dir i s) = 1 := by
      rw [show G.dir j s - G.dir i s = G.dir j s + -G.dir i s by ring, e_add]
      have : e (germDir (G.β j) (G.κ j) s) = e (germDir (G.β i) (G.κ i) s) := h.2.symm
      change e (germDir (G.β j) (G.κ j) s) * e (-germDir (G.β i) (G.κ i) s) = 1
      rw [this, ← e_add, add_neg_cancel]; simp [e]
    refine e_ne_one (by linarith) ?_ he
    rw [abs_lt]; constructor <;> linarith
  intro i j hij s hs
  rcases lt_or_gt_of_ne hij with h | h
  · exact key i j h s hs
  · exact (key j i h s hs).symm


/-- In `Fin 2`, an element other than one of two distinct elements is the other. -/
theorem fin_two_eq_of_ne {a b c : Fin 2} (hab : a ≠ b) (hca : c ≠ a) : c = b := by
  revert a b c; decide

/-- An interior point carries only its own colour. -/
theorem coloursAt_subset_of_mem_interiorPts {z : ℂ} (hz : z ∈ F.interiorPts) : F.coloursAt z ⊆ {F.col z} := by
  intro j hj
  have hev := F.locallyConstant z hz.1 hz.2
  obtain ⟨y, hy, hyj⟩ := mem_closure_iff_nhds.mp hj _ hev
  rw [mem_singleton_iff, ← hyj.2]
  exact hy

/-- **At a two-colour change point of `ω(u)` one branch enters the disc and the other leaves it** (the germ change: the clockwise germ of
`ω(u)` lies in the `a`-sector and the counter-clockwise one in the `c`-sector, so arcs of circles about `u` just inside and just outside `ω(u)`
each cross a branch; near `r(θ)` no branch meets `ω(u)`, whose points there carry one pseudo-colour each). -/
theorem exists_inner_branch {u : ℂ} {θ : ℝ} {a c : Fin k} (hac : a ≠ c) (ha : F.GermPseudo u θ .cw a)
    (hc : F.GermPseudo u θ .ccw c) {G : BranchGerms 2} {r₀ ρ : ℝ} (hC : F.IsSectorChart G (ringPt u θ) r₀) (hρ : ρ ∈ Ioc 0 r₀)
    (hord : ∀ s ∈ Ioo 0 ρ, ∀ i, G.dir i s < G.nextDir i s) {T₁ T₂ : Set ℂ} (h₁ : F.TileOf a T₁) (h₂ : F.TileOf c T₂)
    (hv₁ : ringPt u θ ∈ closure T₁) (hv₂ : ringPt u θ ∈ closure T₂) {i₁ i₂ : Fin 2} (hi₁ : G.sector (ringPt u θ) ρ i₁ ⊆ T₁)
    (hi₂ : G.sector (ringPt u θ) ρ i₂ ⊆ T₂) :
    ∃ j : Fin 2, ∃ r ∈ Ioc 0 ρ, (∀ s ∈ Ioo 0 r, branchPt (ringPt u θ) (G.β j) (G.κ j) s ∈ ball u 1) ∧
      ∀ j' ≠ j, ∀ s ∈ Ioo 0 r, branchPt (ringPt u θ) (G.β j') (G.κ j') s ∉ closedBall u 1 := by
  have hπ := Real.pi_pos
  set x := ringPt u θ with hx
  have hρ₀ : ρ ∈ Ioc 0 r₀ := hρ
  -- the two tiles differ, and so do their sectors
  have hne : T₁ ≠ T₂ := by
    rintro rfl
    obtain ⟨y, hy⟩ := h₁.1.nonempty
    exact hac ((h₁.2 hy).symm.trans (h₂.2 hy))
  have hi12 : i₁ ≠ i₂ := by
    rintro rfl
    obtain ⟨y, hy⟩ := hC.sector_nonempty hρ i₁
    exact hne (h₁.1.eq_of_mem h₂.1 (hi₁ hy) (hi₂ hy))
  have hother : ∀ j : Fin 2, j ≠ i₂ → j = i₁ := fun j hj => fin_two_eq_of_ne hi12.symm hj
  -- the germs' colours are not `u`'s
  obtain ⟨δa, hδa, hga⟩ := ha
  obtain ⟨δc, hδc, hgc⟩ := hc
  have hgerm_mem : ∀ {s : Side} {δ t : ℝ}, 0 < t → t < δ → ringPt u (θ + s.sign * t) ∈ germ u θ s δ :=
    fun ht htδ => ⟨_, ⟨ht, htδ⟩, rfl⟩
  have hau : a ∉ F.coloursAt u := by
    have h := hga (hgerm_mem (half_pos hδa) (by linarith) : ringPt u (θ + Side.cw.sign * (δa / 2)) ∈ _)
    have : a ∈ F.pseudoColours u (ringPt u (θ + Side.cw.sign * (δa / 2))) := by rw [show _ = _ from h]; rfl
    exact this.2
  have hcu : c ∉ F.coloursAt u := by
    have h := hgc (hgerm_mem (half_pos hδc) (by linarith) : ringPt u (θ + Side.ccw.sign * (δc / 2)) ∈ _)
    have : c ∈ F.pseudoColours u (ringPt u (θ + Side.ccw.sign * (δc / 2))) := by rw [show _ = _ from h]; rfl
    exact this.2
  -- branch points carry `a` and `c`
  have hbr : ∀ (j : Fin 2) (s : ℝ), s ∈ Ioo 0 ρ → a ∈ F.pseudoColours u (branchPt x (G.β j) (G.κ j) s) ∧
      c ∈ F.pseudoColours u (branchPt x (G.β j) (G.κ j) s) := by
    intro j s hs
    have hmem : branchPt x (G.β j) (G.κ j) s ∈ closure T₁ ∩ closure T₂ ∩ ball x ρ := by
      rw [hC.inter_closure_two hρ hord h₁.1 h₂.1 hne hv₁ hv₂ hi₁ hi₂ ⟨hρ.1, le_rfl⟩]
      exact Or.inr (mem_iUnion.mpr ⟨j, s, hs, rfl⟩)
    exact ⟨⟨mem_coloursAt_of_tileOf h₁ hmem.1.1, hau⟩, ⟨mem_coloursAt_of_tileOf h₂ hmem.1.2, hcu⟩⟩
  -- near `x`, `ω(u)` is the two germs
  set δ := min (min δa δc) 1 with hδ
  have hδ0 : 0 < δ := lt_min (lt_min hδa hδc) one_pos
  have hδa' : δ ≤ δa := (min_le_left _ _).trans (min_le_left _ _)
  have hδc' : δ ≤ δc := (min_le_left _ _).trans (min_le_right _ _)
  have hδ1 : δ ≤ 1 := min_le_right _ _
  obtain ⟨ν, hν, hpol⟩ := polar_nbhd u (φ := θ) (α := θ - δ) (β := θ + δ) ⟨by linarith, by linarith⟩
  have hcirc : ∀ z, dist z x < ν → ‖z - u‖ = 1 → z ≠ x → F.pseudoColours u z = {a} ∨ F.pseudoColours u z = {c} := by
    intro z hz hz1 hzx
    obtain ⟨-, ψ, hψ, hzψ⟩ := hpol z hz
    rw [hz1] at hzψ
    have hzr : z = ringPt u ψ := by rw [hzψ]; simp [polarPt, ringPt]
    rcases lt_trichotomy ψ θ with hlt | heq | hgt
    · left
      refine hga ⟨θ - ψ, ⟨by linarith, by linarith [hψ.1]⟩, ?_⟩
      rw [hzr]; simp only [Side.sign]; congr 1; ring
    · exact absurd (by rw [hzr, heq]) hzx
    · right
      refine hgc ⟨ψ - θ, ⟨by linarith, by linarith [hψ.2]⟩, ?_⟩
      rw [hzr]; simp only [Side.sign]; congr 1; ring
  set r₁ := min ρ ν with hr₁
  have hr₁0 : 0 < r₁ := lt_min hρ.1 hν
  have hr₁ρ : r₁ ≤ ρ := min_le_left _ _
  have hr₁ν : r₁ ≤ ν := min_le_right _ _
  -- branch points near `x` are off `ω(u)`
  have hoff : ∀ (j : Fin 2) (s : ℝ), s ∈ Ioo 0 r₁ → ‖branchPt x (G.β j) (G.κ j) s - u‖ ≠ 1 := by
    intro j s hs h1
    have hsρ : s ∈ Ioo 0 ρ := ⟨hs.1, hs.2.trans_le hr₁ρ⟩
    have hd : dist (branchPt x (G.β j) (G.κ j) s) x < ν := by
      rw [dist_eq_norm, norm_branchPt_sub x _ _ hs.1.le]; exact hs.2.trans_le hr₁ν
    have hne' : branchPt x (G.β j) (G.κ j) s ≠ x := by
      intro h; have := norm_branchPt_sub x (G.β j) (G.κ j) hs.1.le; rw [h, sub_self, norm_zero] at this
      exact hs.1.ne this
    obtain ⟨ha', hc'⟩ := hbr j s hsρ
    rcases hcirc _ hd h1 hne' with h | h
    · rw [h, mem_singleton_iff] at hc'; exact hac hc'.symm
    · rw [h, mem_singleton_iff] at ha'; exact hac ha'
  -- so each branch lies inside or outside
  have hside : ∀ j : Fin 2, (∀ s ∈ Ioo 0 r₁, branchPt x (G.β j) (G.κ j) s ∈ ball u 1) ∨
      (∀ s ∈ Ioo 0 r₁, branchPt x (G.β j) (G.κ j) s ∉ closedBall u 1) := by
    intro j
    have hpre : IsPreconnected (branchPt x (G.β j) (G.κ j) '' Ioo 0 r₁) :=
      isPreconnected_Ioo.image _ (continuous_branchPt x _ _).continuousOn
    rcases IsPreconnected.subset_or_subset isOpen_ball (isOpen_compl_iff.mpr isClosed_closedBall)
      (Set.disjoint_left.mpr fun z hz hz' => hz' (ball_subset_closedBall hz)) (by
        rintro _ ⟨s, hs, rfl⟩
        by_cases h : branchPt x (G.β j) (G.κ j) s ∈ ball u 1
        · exact Or.inl h
        · right
          intro h'
          rw [mem_ball, not_lt] at h
          rw [mem_closedBall] at h'
          exact hoff j s hs (by rw [← dist_eq_norm]; linarith)) hpre with h | h
    · exact Or.inl fun s hs => h ⟨s, hs, rfl⟩
    · exact Or.inr fun s hs => h ⟨s, hs, rfl⟩
  -- a point of the punctured ball off the branches is in a sector
  have hsector : ∀ z ∈ ball x r₁, z ≠ x → z ∉ ⋃ a ∈ F.arcs, a.carrier → ∃ j, z ∈ G.sector x ρ j := by
    intro z hz hzx hzΓ
    have hzb : z ∈ ball x ρ := ball_subset_ball hr₁ρ hz
    have hz' : z ∈ ball x ρ ∩ F.interiorPts := ⟨hzb, hC.subdom (ball_subset_ball hρ.2 hzb), hzΓ⟩
    rw [hC.cover ρ hρ two_pos] at hz'
    exact mem_iUnion.mp hz'
  -- a point of the punctured ball on the arcs is a branch point
  have hbranch : ∀ z ∈ ball x r₁, z ≠ x → z ∈ ⋃ a ∈ F.arcs, a.carrier →
      ∃ j : Fin 2, ∃ s ∈ Ioo 0 r₁, z = branchPt x (G.β j) (G.κ j) s := by
    intro z hz hzx hzΓ
    have hzb₀ : z ∈ ball x r₀ := ball_subset_ball (hr₁ρ.trans hρ.2) hz
    have hmem : z ∈ (F.Γ ∩ ball x r₀) \ {x} := ⟨⟨⟨hC.subdom hzb₀, hzΓ⟩, hzb₀⟩, hzx⟩
    rw [hC.branches] at hmem
    obtain ⟨j, s, hs, rfl⟩ := mem_iUnion.mp hmem
    refine ⟨j, s, ⟨hs.1, ?_⟩, rfl⟩
    rw [mem_ball, dist_eq_norm, norm_branchPt_sub x _ _ hs.1.le] at hz
    exact hz
  -- the germs' points just off `x` lie in the `a`- and `c`-sectors
  have hgsec : ∀ t ∈ Ioo 0 δ, dist (ringPt u (θ - t)) x < r₁ → ringPt u (θ - t) ∈ G.sector x ρ i₁ := by
    intro t ht hd
    have hpz : F.pseudoColours u (ringPt u (θ - t)) = {a} :=
      hga ⟨t, ⟨ht.1, ht.2.trans_le hδa'⟩, by simp only [Side.sign]; congr 1; ring⟩
    have hzx : ringPt u (θ - t) ≠ x := by
      intro h
      have h' : e (θ - t) = e θ := by simpa [ringPt, hx] using h
      have := e_ne_one (t := -t) (by linarith [ht.1]) (by rw [abs_neg, abs_of_pos ht.1]; linarith [ht.2, hδ1, Real.two_le_pi])
      apply this
      rw [show -t = (θ - t) + -θ by ring, e_add, h', ← e_add, add_neg_cancel]; simp [e]
    have hzΓ : ringPt u (θ - t) ∉ ⋃ a ∈ F.arcs, a.carrier := by
      intro hΓ
      obtain ⟨j, s, hs, hjs⟩ := hbranch _ hd hzx hΓ
      have := (hbr j s ⟨hs.1, hs.2.trans_le hr₁ρ⟩).2
      rw [← hjs, hpz, mem_singleton_iff] at this
      exact hac this.symm
    obtain ⟨j, hj⟩ := hsector _ hd hzx hzΓ
    have hj1 : j = i₁ := by
      by_contra hji
      have hj2 : j = i₂ := by
        by_contra h
        exact hji (hother j h)
      subst hj2
      have hint : ringPt u (θ - t) ∈ F.interiorPts := hC.sector_subset_interiorPts two_pos hρ j hj
      have ha' : a ∈ F.coloursAt (ringPt u (θ - t)) := by
        have : a ∈ F.pseudoColours u (ringPt u (θ - t)) := by rw [hpz]; rfl
        exact this.1
      have := coloursAt_subset_of_mem_interiorPts hint ha'
      rw [mem_singleton_iff, h₂.2 (hi₂ hj)] at this
      exact hac this
    exact hj1 ▸ hj
  have hgsec' : ∀ t ∈ Ioo 0 δ, dist (ringPt u (θ + t)) x < r₁ → ringPt u (θ + t) ∈ G.sector x ρ i₂ := by
    intro t ht hd
    have hpz : F.pseudoColours u (ringPt u (θ + t)) = {c} :=
      hgc ⟨t, ⟨ht.1, ht.2.trans_le hδc'⟩, by simp only [Side.sign, one_mul]⟩
    have hzx : ringPt u (θ + t) ≠ x := by
      intro h
      have h' : e (θ + t) = e θ := by simpa [ringPt, hx] using h
      have := e_ne_one (t := t) ht.1.ne' (by rw [abs_of_pos ht.1]; linarith [ht.2, hδ1, Real.two_le_pi])
      apply this
      rw [show t = (θ + t) + -θ by ring, e_add, h', ← e_add, add_neg_cancel]; simp [e]
    have hzΓ : ringPt u (θ + t) ∉ ⋃ a ∈ F.arcs, a.carrier := by
      intro hΓ
      obtain ⟨j, s, hs, hjs⟩ := hbranch _ hd hzx hΓ
      have := (hbr j s ⟨hs.1, hs.2.trans_le hr₁ρ⟩).1
      rw [← hjs, hpz, mem_singleton_iff] at this
      exact hac this
    obtain ⟨j, hj⟩ := hsector _ hd hzx hzΓ
    have hj2 : j = i₂ := by
      by_contra hji
      have hj1 : j = i₁ := hother j hji
      subst hj1
      have hint : ringPt u (θ + t) ∈ F.interiorPts := hC.sector_subset_interiorPts two_pos hρ j hj
      have hc' : c ∈ F.coloursAt (ringPt u (θ + t)) := by
        have : c ∈ F.pseudoColours u (ringPt u (θ + t)) := by rw [hpz]; rfl
        exact this.1
      have := coloursAt_subset_of_mem_interiorPts hint hc'
      rw [mem_singleton_iff, h₁.2 (hi₁ hj)] at this
      exact hac this.symm
    exact hj2 ▸ hj
  -- the two ends of a short arc about `x` on `ω(u)`
  set t₀ := min (δ / 2) (r₁ / 4) with ht₀
  have ht₀0 : 0 < t₀ := lt_min (half_pos hδ0) (by linarith)
  have ht₀δ : t₀ < δ := lt_of_le_of_lt (min_le_left _ _) (half_lt_self hδ0)
  have ht₀r : t₀ ≤ r₁ / 4 := min_le_right _ _
  have hdist_ring : ∀ t : ℝ, dist (ringPt u (θ + t)) x ≤ |t| := by
    intro t
    rw [hx, dist_eq_norm, show ringPt u (θ + t) - ringPt u θ = e (θ + t) - e θ by simp [ringPt]]
    have := norm_e_sub_e_le (θ + t) θ
    rwa [show θ + t - θ = t by ring] at this
  have hpL : ringPt u (θ - t₀) ∈ G.sector x ρ i₁ := hgsec t₀ ⟨ht₀0, ht₀δ⟩ (by
    have := hdist_ring (-t₀); rw [← sub_eq_add_neg, abs_neg, abs_of_pos ht₀0] at this; linarith)
  have hpR : ringPt u (θ + t₀) ∈ G.sector x ρ i₂ := hgsec' t₀ ⟨ht₀0, ht₀δ⟩ (by
    have := hdist_ring t₀; rw [abs_of_pos ht₀0] at this; linarith)
  obtain ⟨εL, hεL, hbL⟩ := Metric.isOpen_iff.mp (hC.isOpen ρ hρ i₁) _ hpL
  obtain ⟨εR, hεR, hbR⟩ := Metric.isOpen_iff.mp (hC.isOpen ρ hρ i₂) _ hpR
  set η := min (min εL εR) (min (r₁ / 4) (1 / 2)) / 2 with hη
  have hη0 : 0 < η := by positivity
  have hηεL : η < εL := by have := min_le_left (min εL εR) (min (r₁ / 4) (1 / 2)); have := min_le_left εL εR; linarith
  have hηεR : η < εR := by have := min_le_left (min εL εR) (min (r₁ / 4) (1 / 2)); have := min_le_right εL εR; linarith
  have hηr : η ≤ r₁ / 8 := by
    have := min_le_right (min εL εR) (min (r₁ / 4) (1 / 2)); have := min_le_left (r₁ / 4) (1 / 2); linarith
  have hη1 : η ≤ 1 / 4 := by
    have := min_le_right (min εL εR) (min (r₁ / 4) (1 / 2)); have := min_le_right (r₁ / 4) (1 / 2); linarith
  -- an arc of the circle of radius `ρ'` about `u`, `|ρ' − 1| = η`, crosses a branch
  have hcross : ∀ ρ' : ℝ, |ρ' - 1| = η → ∃ j : Fin 2, ∃ s ∈ Ioo 0 r₁, ‖branchPt x (G.β j) (G.κ j) s - u‖ = ρ' := by
    intro ρ' hρ'
    have hρ'0 : 0 < ρ' := by cases abs_eq (hη0.le) |>.mp hρ' <;> linarith
    set g : ℝ → ℂ := fun t => polarPt u ρ' (θ + t) with hg
    have hgc : Continuous g := (continuous_polarPt u).comp (continuous_const.prodMk (continuous_const.add continuous_id))
    have hgd : ∀ t ∈ Icc (-t₀) t₀, dist (g t) x < r₁ := by
      intro t ht
      have := dist_polarPt_ringPt_le u ρ' (θ + t) θ
      rw [hρ', show θ + t - θ = t by ring] at this
      have : |t| ≤ t₀ := abs_le.mpr ⟨ht.1, ht.2⟩
      simp only [hg, hx]; linarith
    have hgu : ∀ t, ‖g t - u‖ = ρ' := fun t => by simp only [hg]; rw [norm_polarPt_sub, abs_of_pos hρ'0]
    have hgx : ∀ t, g t ≠ x := by
      intro t h
      have h1 := hgu t
      rw [h, hx, show ringPt u θ - u = e θ by simp [ringPt], norm_e] at h1
      have : ρ' ≠ 1 := by intro h'; rw [h', sub_self, abs_zero] at hρ'; exact hη0.ne hρ'
      exact this h1.symm
    have hendL : g (-t₀) ∈ G.sector x ρ i₁ := by
      apply hbL
      have := dist_polarPt_ringPt_le u ρ' (θ + -t₀) (θ - t₀)
      rw [hρ', show θ + -t₀ - (θ - t₀) = 0 by ring, abs_zero, add_zero] at this
      exact lt_of_le_of_lt this hηεL
    have hendR : g t₀ ∈ G.sector x ρ i₂ := by
      apply hbR
      have := dist_polarPt_ringPt_le u ρ' (θ + t₀) (θ + t₀)
      rw [hρ', sub_self, abs_zero, add_zero] at this
      exact lt_of_le_of_lt this hηεR
    by_contra hno
    push Not at hno
    -- the arc avoids the arcs of the map, so lies in the two sectors
    have hoffΓ : ∀ t ∈ Icc (-t₀) t₀, g t ∉ ⋃ a ∈ F.arcs, a.carrier := by
      intro t ht hΓ
      obtain ⟨j, s, hs, hjs⟩ := hbranch _ (hgd t ht) (hgx t) hΓ
      exact hno j s hs (by rw [← hjs]; exact hgu t)
    have hsub : g '' Icc (-t₀) t₀ ⊆ G.sector x ρ i₁ ∪ G.sector x ρ i₂ := by
      rintro _ ⟨t, ht, rfl⟩
      obtain ⟨j, hj⟩ := hsector _ (hgd t ht) (hgx t) (hoffΓ t ht)
      by_cases hj2 : j = i₂
      · exact Or.inr (hj2 ▸ hj)
      · exact Or.inl (hother j hj2 ▸ hj)
    rcases IsPreconnected.subset_or_subset (hC.isOpen ρ hρ i₁) (hC.isOpen ρ hρ i₂) (hC.disjoint ρ hρ i₁ i₂ hi12) hsub
      (isPreconnected_Icc.image _ hgc.continuousOn) with h | h
    · exact Set.disjoint_left.mp (hC.disjoint ρ hρ i₁ i₂ hi12) (h ⟨t₀, ⟨by linarith, le_rfl⟩, rfl⟩) hendR
    · exact Set.disjoint_left.mp (hC.disjoint ρ hρ i₁ i₂ hi12) hendL (h ⟨-t₀, ⟨le_rfl, by linarith⟩, rfl⟩)
  obtain ⟨j, s, hs, hjs⟩ := hcross (1 - η) (by rw [show 1 - η - 1 = -η by ring, abs_neg, abs_of_pos hη0])
  obtain ⟨j', s', hs', hjs'⟩ := hcross (1 + η) (by rw [show 1 + η - 1 = η by ring, abs_of_pos hη0])
  have hjin : ∀ s ∈ Ioo 0 r₁, branchPt x (G.β j) (G.κ j) s ∈ ball u 1 := by
    rcases hside j with h | h
    · exact h
    · exfalso; apply h s hs; rw [mem_closedBall, dist_eq_norm, hjs]; linarith
  have hjout : ∀ s ∈ Ioo 0 r₁, branchPt x (G.β j') (G.κ j') s ∉ closedBall u 1 := by
    rcases hside j' with h | h
    · exfalso; have := h s' hs'; rw [mem_ball, dist_eq_norm, hjs'] at this; linarith
    · exact h
  have hjj : j ≠ j' := by
    rintro rfl
    exact hjout (r₁ / 2) ⟨by linarith, by linarith⟩ (ball_subset_closedBall (hjin (r₁ / 2) ⟨by linarith, by linarith⟩))
  refine ⟨j, r₁, ⟨hr₁0, hr₁ρ⟩, hjin, fun j'' hj'' s hs => ?_⟩
  rw [fin_two_eq_of_ne hjj hj'']; exact hjout s hs

/-- **The `a|c` boundary from a change point has a far end** (the planar parity step of Prop. 19(b), FS110-CD Lemma E): at a change point
`r(θ)` of the pseudo-colouring of `ω(u)` from `a` (clockwise) to `c` (counter-clockwise), the `a`-tile `T₁` and the `c`-tile `T₂` there have,
in the component of `r(θ)` in `cl T₁ ∩ cl T₂ ∩ B̄(u, 1)`, a point with a third colour (possibly `r(θ)` itself) or a second point of `ω(u)`.
(`r(θ)` itself may carry three colours — germs along in-contact arcs of `ω(u)` with a colour of `u` inside, the `a|c` branch leaving
outward, the component `{r(θ)}`; then `r(θ)` is V-in, an endpoint: the obligation pass's correction, plan § 4.) Planned over the
finite boundary graph of `F` in `B̄(u, 1)` (vertices: arc ends, crossings, points on `ω(u)`; edges: arc pieces), whose `T₁|T₂` subgraph has
degree `2` at every two-colour point of `B(u, 1)` (two sectors, no repeated colour under H) and, when `r(θ)` has two colours, degree `1`
there (one branch enters the disc: the germ change), so
the handshake lemma (`SimpleGraph.even_card_odd_degree_vertices`) gives a second odd vertex in `r(θ)`'s component. -/
theorem exists_far_end {F : ArcMap 6} {u : ℂ} (_hF : F.Valid) (hcov : F.Covers u 2) (hH : F.BaseHyp u) {θ : ℝ} {a c : Fin 6}
    (hac : a ≠ c) (ha : F.GermPseudo u θ .cw a) (hc : F.GermPseudo u θ .ccw c) :
    ∃ T₁ T₂, F.TileOf a T₁ ∧ F.TileOf c T₂ ∧ ringPt u θ ∈ closure T₁ ∧ ringPt u θ ∈ closure T₂ ∧
      ∃ q ∈ connectedComponentIn (closure T₁ ∩ closure T₂ ∩ closedBall u 1) (ringPt u θ),
        (F.coloursAt q).ncard = 3 ∨ (q ≠ ringPt u θ ∧ dist q u = 1) := by
  classical
  set x := ringPt u θ with hx
  have hxu : dist x u = 1 := dist_ringPt u θ
  have hdomB : ∀ z ∈ closedBall u 1, z ∈ F.dom := fun z hz => hcov (closedBall_subset_closedBall (by norm_num) hz)
  have hxd : x ∈ F.dom := hdomB x (by rw [mem_closedBall, hxu])
  have hgood : ∀ z ∈ closedBall u 1, z ∉ F.fourSet ∪ F.repSet := fun z hz =>
    Set.disjoint_left.mp hH (closedBall_subset_closedBall (by norm_num) hz)
  -- the germs' colours are carried at `x`
  have hcol_x : ∀ {s : Side} {j : Fin 6}, F.GermPseudo u θ s j → j ∈ F.coloursAt x := by
    intro s j hj
    obtain ⟨δ, hδ, hg⟩ := hj
    have hcont : Continuous fun t : ℝ => ringPt u (θ + s.sign * t) := by unfold ringPt e; fun_prop
    have hlim : Tendsto (fun t : ℝ => ringPt u (θ + s.sign * t)) (𝓝[>] 0) (𝓝 x) := by
      have := (hcont.tendsto 0).mono_left (nhdsWithin_le_nhds (s := Ioi 0))
      simpa [hx] using this
    have hx_cl : x ∈ closure (germ u θ s δ) :=
      mem_closure_of_tendsto hlim (by filter_upwards [Ioo_mem_nhdsGT hδ] with t ht; exact ⟨t, ht, rfl⟩)
    have hsub : germ u θ s δ ⊆ closure (F.region j) := fun z hz => by
      have : j ∈ F.pseudoColours u z := by rw [show F.pseudoColours u z = {j} from hg hz]; rfl
      exact this.1
    exact closure_minimal hsub isClosed_closure hx_cl
  obtain ⟨T₁, h₁, hx₁⟩ := (F.mem_coloursAt_iff_exists_tileOf hxd).mp (hcol_x ha)
  obtain ⟨T₂, h₂, hx₂⟩ := (F.mem_coloursAt_iff_exists_tileOf hxd).mp (hcol_x hc)
  refine ⟨T₁, T₂, h₁, h₂, hx₁, hx₂, ?_⟩
  set K := closure T₁ ∩ closure T₂ ∩ closedBall u 1 with hK
  have hxK : x ∈ K := ⟨⟨hx₁, hx₂⟩, by rw [mem_closedBall, hxu]⟩
  by_cases h3 : (F.coloursAt x).ncard = 3
  · exact ⟨x, mem_connectedComponentIn hxK, Or.inl h3⟩
  by_contra hcon
  push Not at hcon
  set Cx := connectedComponentIn K x with hCx
  have hne : T₁ ≠ T₂ := by
    rintro rfl
    obtain ⟨y, hy⟩ := h₁.1.nonempty
    exact hac ((h₁.2 hy).symm.trans (h₂.2 hy))
  have hKc : IsCompact K := (isCompact_closedBall u 1).inter_left (isClosed_closure.inter isClosed_closure)
  have hxCx : x ∈ Cx := mem_connectedComponentIn hxK
  have hCxK : Cx ⊆ K := connectedComponentIn_subset _ _
  have hCxc : IsCompact Cx := by
    have hcl : IsClosed Cx := isClosed_of_closure_subset
      (isPreconnected_connectedComponentIn.closure.subset_connectedComponentIn (subset_closure hxCx)
        (closure_minimal hCxK hKc.isClosed))
    exact hKc.of_isClosed_subset hcl hCxK
  -- every point of the component carries exactly the two colours, with no repeated colour
  have h2col : ∀ z ∈ Cx, (F.coloursAt z).ncard = 2 ∧ ¬ F.HasRepeatedColour z ∧ z ∈ F.dom := by
    intro z hz
    have hzK := hCxK hz
    have hzd := hdomB z hzK.2
    have hg := hgood z hzK.2
    have hle3 : (F.coloursAt z).ncard ≤ 3 := by
      by_contra h
      push Not at h
      exact hg (Or.inl ⟨hzd, h⟩)
    have hge2 : 2 ≤ (F.coloursAt z).ncard := by
      have hsub : ({a, c} : Set (Fin 6)) ⊆ F.coloursAt z :=
        insert_subset_iff.mpr ⟨mem_coloursAt_of_tileOf h₁ hzK.1.1, singleton_subset_iff.mpr (mem_coloursAt_of_tileOf h₂ hzK.1.2)⟩
      have := Set.ncard_le_ncard hsub (Set.toFinite _)
      rwa [Set.ncard_pair hac] at this
    have h3' := (hcon z hz).1
    exact ⟨by omega, fun h => hg (Or.inr ⟨hzd, h⟩), hzd⟩
  -- the stars: two rays inside the disc, one at `x`
  have hstar : ∀ z ∈ Cx, HasCurveStar Cx z (if z = x then 1 else 2) := by
    intro z hz
    obtain ⟨hz2, hznr, hzd⟩ := h2col z hz
    have hzK := hCxK hz
    obtain ⟨r₀, n, G, hC⟩ := localSectors F hzd
    have hn2 := hC.eq_two h₁.1 h₂.1 hne hzK.1.1 hzK.1.2 hznr hz2
    subst hn2
    obtain ⟨ρ', hρ', hord'⟩ :=
      mem_nhdsGT_iff_exists_Ioo_subset.mp (G.eventually_dir_lt_nextDir hC.sorted hC.pos hC.curv)
    set ρ := min ρ' r₀ with hρdef
    have hρ : ρ ∈ Ioc 0 r₀ := ⟨lt_min hρ' hC.pos, min_le_right _ _⟩
    have hord : ∀ s ∈ Ioo 0 ρ, ∀ i, G.dir i s < G.nextDir i s := fun s hs =>
      hord' ⟨hs.1, hs.2.trans_le (min_le_left _ _)⟩
    obtain ⟨i₁, hi₁⟩ := hC.exists_sector_subset_tile two_pos hρ h₁.1 hzK.1.1
    obtain ⟨i₂, hi₂⟩ := hC.exists_sector_subset_tile two_pos hρ h₂.1 hzK.1.2
    have hcurv : ∀ r ≤ r₀, ∀ i, |G.κ i| * r < 2 := fun r hr i =>
      lt_of_le_of_lt (mul_le_mul_of_nonneg_left hr (abs_nonneg _)) (hC.curv i)
    refine HasCurveStar.connectedComponentIn ?_ hz
    by_cases hzx : z = x
    · rw [if_pos hzx]
      subst hzx
      obtain ⟨j, r, hr, hin, hout⟩ := exists_inner_branch hac ha hc hC hρ hord h₁ h₂ hzK.1.1 hzK.1.2 hi₁ hi₂
      have hinter := hC.inter_closure_two hρ hord h₁.1 h₂.1 hne hzK.1.1 hzK.1.2 hi₁ hi₂ hr
      refine hasCurveStar_of_branch (G.β j) (G.κ j) hr.1 (hcurv r (hr.2.trans hρ.2) j) (Subset.antisymm ?_ ?_)
      · intro w hw
        have hw' : w ∈ closure T₁ ∩ closure T₂ ∩ ball (ringPt u θ) r := ⟨hw.1.1, hw.2⟩
        rw [hinter] at hw'
        rcases hw' with rfl | hw'
        · exact mem_insert _ _
        obtain ⟨i, s, hs, rfl⟩ := mem_iUnion.mp hw'
        by_cases hij : i = j
        · subst hij; exact Or.inr ⟨s, hs, rfl⟩
        · exact absurd hw.1.2 (hout i hij s hs)
      · intro w hw
        have hw' : w ∈ closure T₁ ∩ closure T₂ ∩ ball (ringPt u θ) r := by
          rw [hinter]
          rcases hw with rfl | ⟨s, hs, rfl⟩
          · exact mem_insert _ _
          · exact Or.inr (mem_iUnion.mpr ⟨j, s, hs, rfl⟩)
        refine ⟨⟨hw'.1, ?_⟩, hw'.2⟩
        rcases hw with rfl | ⟨s, hs, rfl⟩
        · rw [mem_closedBall, dist_ringPt]
        · exact ball_subset_closedBall (hin s hs)
    · rw [if_neg hzx]
      have hzu : dist z u < 1 := lt_of_le_of_ne hzK.2 ((hcon z hz).2 hzx)
      set r := min ρ (1 - dist z u) with hrdef
      have hr : r ∈ Ioc 0 ρ := ⟨lt_min hρ.1 (by linarith), min_le_left _ _⟩
      have hball : ball z r ⊆ closedBall u 1 := fun w hw => by
        rw [mem_ball] at hw; rw [mem_closedBall]
        linarith [dist_triangle w z u, min_le_right ρ (1 - dist z u)]
      refine hasCurveStar_of_branches G hr.1 (fun s hs => hord s ⟨hs.1, hs.2.trans_le hr.2⟩)
        (fun i => hcurv r (hr.2.trans hρ.2) i) ?_
      rw [← hC.inter_closure_two hρ hord h₁.1 h₂.1 hne hzK.1.1 hzK.1.2 hi₁ hi₂ hr]
      ext w
      constructor
      · rintro ⟨⟨hw12, -⟩, hb⟩; exact ⟨hw12, hb⟩
      · rintro ⟨hw12, hb⟩; exact ⟨⟨hw12, hball hb⟩, hb⟩
  -- the handshake: `x` alone has odd degree
  obtain ⟨N, hN, heven⟩ := exists_finset_even_sum_deg hCxc hstar
  have hx1 : HasCurveStar Cx x 1 := by have := hstar x hxCx; rwa [if_pos rfl] at this
  have hxN : x ∈ N := (hN x).mpr ⟨hxCx, not_isRegularAt_of_hasCurveStar_one hx1⟩
  rw [← Finset.add_sum_erase N _ hxN, if_pos rfl] at heven
  have hrest : ∑ v ∈ N.erase x, (if v = x then 1 else 2) = ∑ v ∈ N.erase x, 2 :=
    Finset.sum_congr rfl fun v hv => if_neg (Finset.ne_of_mem_erase hv)
  rw [hrest, Finset.sum_const, smul_eq_mul] at heven
  obtain ⟨m, hm⟩ := heven
  omega

/-- A germ has one pseudo-colour: the clockwise germ at `r(θ)` cannot have pseudo-colours `a` and `c ≠ a` (the dead disjunct of
`exists_endpoint`'s `hc`, QA3 § 2.4 e). -/
theorem GermPseudo.eq_of_cw {u : ℂ} {θ : ℝ} {a c : Fin k} (ha : F.GermPseudo u θ .cw a) (hc : F.GermPseudo u θ .cw c) : a = c := by
  obtain ⟨δ₁, hδ₁, h₁⟩ := ha
  obtain ⟨δ₂, hδ₂, h₂⟩ := hc
  have hδ : 0 < min δ₁ δ₂ := lt_min hδ₁ hδ₂
  obtain ⟨z, hz⟩ : (germ u θ .cw (min δ₁ δ₂)).Nonempty :=
    ⟨_, mem_image_of_mem _ (show min δ₁ δ₂ / 2 ∈ Ioo 0 (min δ₁ δ₂) from ⟨by linarith, by linarith⟩)⟩
  have e₁ : F.pseudoColours u z = {a} := h₁ (germ_mono (min_le_left _ _) hz)
  have e₂ : F.pseudoColours u z = {c} := h₂ (germ_mono (min_le_right _ _) hz)
  exact Set.singleton_eq_singleton_iff.mp (e₁.symm.trans e₂)

end ArcMap

/-- An arc of `ω(u)` is unchanged by shifting both ends by a multiple of `2π`. -/
theorem ringArc_add_two_pi_mul (u : ℂ) (s t : ℝ) (n : ℤ) :
    ringArc u (s + 2 * π * n) (t + 2 * π * n) = ringArc u s t := by
  unfold ringArc
  rw [← Set.image_add_const_Icc, Set.image_image]
  congr 1
  ext θ
  simp only [ringPt, e_add_int_mul]

/-- **Two short arcs of one circle** (`retArcs_nested`'s case split): arcs `[s, t]`, `[s', t']` shorter than `60°` are disjoint, nested,
interleaved (one end of each strictly inside the other, modulo `2π`), or abut (an end of one is an end of the other and they are not
nested). -/
theorem ringArc_cases (u : ℂ) {s t s' t' : ℝ} (hst : s < t) (hst' : t < s + π / 3) (hs't' : s' < t') (hs't'' : t' < s' + π / 3) :
    Disjoint (ringArc u s t) (ringArc u s' t') ∨ ringArc u s t ⊆ ringArc u s' t' ∨ ringArc u s' t' ⊆ ringArc u s t ∨
      (∃ n : ℤ, (s < s' + 2 * π * n ∧ s' + 2 * π * n < t ∧ t < t' + 2 * π * n) ∨
        (s' + 2 * π * n < s ∧ s < t' + 2 * π * n ∧ t' + 2 * π * n < t)) ∨
      ringPt u t = ringPt u s' ∨ ringPt u t' = ringPt u s := by
  have hπ := Real.pi_pos
  -- shift the second arc to start within `π` of `s`
  set n : ℤ := ⌊(s - s' + π) / (2 * π)⌋ with hn
  have hn1 : (n : ℝ) ≤ (s - s' + π) / (2 * π) := Int.floor_le _
  have hn2 : (s - s' + π) / (2 * π) < n + 1 := Int.lt_floor_add_one _
  rw [le_div_iff₀ (by positivity)] at hn1
  rw [div_lt_iff₀ (by positivity)] at hn2
  set σ := s' + 2 * π * n with hσ
  set τ := t' + 2 * π * n with hτ
  have hσ1 : s - π < σ := by rw [hσ]; nlinarith
  have hσ2 : σ ≤ s + π := by rw [hσ]; nlinarith
  have hστ : σ < τ := by rw [hσ, hτ]; linarith
  have hστ' : τ < σ + π / 3 := by rw [hσ, hτ]; linarith
  have hA : ringArc u s' t' = ringArc u σ τ := (ringArc_add_two_pi_mul u s' t' n).symm
  have hrt' : ringPt u t' = ringPt u τ := by simp only [ringPt, hτ, e_add_int_mul]
  have hrs' : ringPt u s' = ringPt u σ := by simp only [ringPt, hσ, e_add_int_mul]
  -- real intervals that miss each other give arcs that miss each other
  have hdisj : (τ < s ∨ t < σ) → Disjoint (ringArc u s t) (ringArc u s' t') := by
    intro h
    rw [hA, Set.disjoint_left]
    rintro z ⟨θ, hθ, rfl⟩ ⟨φ, hφ, hφθ⟩
    simp only [ringPt, add_right_inj] at hφθ
    obtain ⟨m, hm⟩ := e_eq_e_iff.mp hφθ
    have hm0 : m = 0 := by
      have h1 : (m * (2 * π) : ℝ) < 2 * π := by linarith [hθ.1, hθ.2, hφ.1, hφ.2]
      have h2 : -(2 * π) < (m * (2 * π) : ℝ) := by linarith [hθ.1, hθ.2, hφ.1, hφ.2]
      have h1' : (m : ℝ) < 1 := by nlinarith
      have h2' : (-1 : ℝ) < m := by nlinarith
      have : m < 1 := by exact_mod_cast h1'
      have : -1 < m := by exact_mod_cast h2'
      omega
    rw [hm0] at hm
    simp at hm
    rcases h with h | h
    · linarith [hθ.1, hφ.2]
    · linarith [hθ.2, hφ.1]
  rcases lt_trichotomy τ s with h1 | h1 | h1
  · exact Or.inl (hdisj (Or.inl h1))
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (by rw [hrt', h1])))))
  rcases lt_trichotomy t σ with h2 | h2 | h2
  · exact Or.inl (hdisj (Or.inr h2))
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (by rw [hrs', h2])))))
  rw [hA]
  rcases le_or_gt σ s with h3 | h3
  · rcases le_or_gt t τ with h4 | h4
    · exact Or.inr (Or.inl (by unfold ringArc; exact image_mono (Icc_subset_Icc h3 h4)))
    · rcases eq_or_lt_of_le h3 with h5 | h5
      · exact Or.inr (Or.inr (Or.inl (by unfold ringArc; exact image_mono (Icc_subset_Icc h5.ge h4.le))))
      · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨n, Or.inr ⟨h5, h1, h4⟩⟩)))
  · rcases le_or_gt τ t with h4 | h4
    · exact Or.inr (Or.inr (Or.inl (by unfold ringArc; exact image_mono (Icc_subset_Icc h3.le h4))))
    · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨n, Or.inl ⟨h3, h2, h4⟩⟩)))


/-! ## E — one-sidedness: the orientation step (FS131-IP4) -/

/-- A point of the unit circle is the polar point at radius `1`. -/
theorem ringPt_eq_polarPt (u : ℂ) (θ : ℝ) : ringPt u θ = polarPt u 1 θ := by
  simp [ringPt, polarPt]

/-- Polar points at positive radii whose angles differ by less than a turn (and not at all) are distinct. -/
theorem polarPt_ne_of_sub {u : ℂ} {ρ ρ' a b : ℝ} (hρ : 0 < ρ) (hρ' : 0 < ρ') (h0 : 0 < a - b) (h1 : a - b < 2 * π) :
    polarPt u ρ a ≠ polarPt u ρ' b := by
  intro h
  have hn : ‖polarPt u ρ a - u‖ = ‖polarPt u ρ' b - u‖ := by rw [h]
  rw [norm_polarPt_sub, norm_polarPt_sub, abs_of_pos hρ, abs_of_pos hρ'] at hn
  subst hn
  have he : e a = e b := by
    have h2 : (ρ : ℂ) * e a = (ρ : ℂ) * e b := by
      have := congrArg (· - u) h
      simpa [polarPt] using this
    exact mul_left_cancel₀ (by exact_mod_cast hρ.ne') h2
  refine e_ne_one (t := a - b) h0.ne' (by rw [abs_of_pos h0]; exact h1) ?_
  rw [sub_eq_add_neg, e_add, he, ← e_add, add_neg_cancel]
  simp [e]

/-- **The crossing lemma on a circle of any radius** (`inter_nonempty_of_interleaved_of_isClosed_left`, moved by the homothety about `u`):
a closed preconnected `K` and a preconnected `K'` in `B̄(u, R)`, joining interleaved points of `ω(u, R)`, meet. -/
theorem inter_nonempty_of_interleaved_radius {u : ℂ} {R : ℝ} (hR : 0 < R) {K K' : Set ℂ} (hK : IsClosed K)
    (hKc : IsPreconnected K) (hK'c : IsPreconnected K') (hKd : K ⊆ closedBall u R) (hK'd : K' ⊆ closedBall u R)
    {s s' t t' : ℝ} (h₁ : s < s') (h₂ : s' < t) (h₃ : t < t') (h₄ : t' < s + 2 * π) (hs : polarPt u R s ∈ K)
    (ht : polarPt u R t ∈ K) (hs' : polarPt u R s' ∈ K') (ht' : polarPt u R t' ∈ K') : (K ∩ K').Nonempty := by
  have hRc : (R : ℂ) ≠ 0 := by exact_mod_cast hR.ne'
  set g : ℂ → ℂ := fun z => u + (z - u) / R with hg
  set h : ℂ → ℂ := fun w => u + R * (w - u) with hh
  have hgh : ∀ w, g (h w) = w := fun w => by simp only [hg, hh]; field_simp; ring
  have hhg : ∀ z, h (g z) = z := fun z => by simp only [hg, hh]; field_simp; ring
  have hgc : Continuous g := by simp only [hg]; fun_prop
  have hhc : Continuous h := by simp only [hh]; fun_prop
  have himg : ∀ S : Set ℂ, g '' S = h ⁻¹' S := fun S =>
    congrFun (Set.image_eq_preimage_of_inverse (f := g) (g := h) hhg hgh) S
  have hball : ∀ S ⊆ closedBall u R, g '' S ⊆ closedBall u 1 := by
    rintro S hS _ ⟨z, hz, rfl⟩
    have hz' := hS hz
    rw [mem_closedBall, dist_eq_norm] at hz' ⊢
    simp only [hg, add_sub_cancel_left, norm_div, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hR]
    rw [div_le_one hR]
    exact hz'
  have hpt : ∀ a, g (polarPt u R a) = ringPt u a := fun a => by
    simp only [hg, polarPt, ringPt, add_sub_cancel_left]
    field_simp
  obtain ⟨w, hw, hw'⟩ := inter_nonempty_of_interleaved_of_isClosed_left (u := u) (K := g '' K) (K' := g '' K')
    (by rw [himg]; exact hK.preimage hhc) (hKc.image _ hgc.continuousOn) (hK'c.image _ hgc.continuousOn) (hball K hKd)
    (hball K' hK'd) h₁ h₂ h₃ h₄ ⟨_, hs, hpt s⟩ ⟨_, ht, hpt t⟩ ⟨_, hs', hpt s'⟩ ⟨_, ht', hpt t'⟩
  obtain ⟨z, hz, rfl⟩ := hw
  obtain ⟨z', hz', hzz'⟩ := hw'
  have : z' = z := by rw [← hhg z', hzz', hhg]
  exact ⟨z, hz, this ▸ hz'⟩

/-- **The one-sidedness of a separating continuum** (the orientation step, `exists_endpoint`'s exit and both `retArcs_not_*`; FS131-IP4,
over the crossing lemma, no Jordan-type theorem): let `C ⊆ B̄(u, 1)` be closed and preconnected, and `T` open, disjoint from `C`, with every
point of `C` in `cl T` and `T` one-sided there (`T ∩ B(z, r)` preconnected for small `r`). Two distinct points `r(θ)`, `r(φ)` of `C` cannot
both have the counter-clockwise germ of `ω(u)` in `cl T ∖ C` and the clockwise one off `cl T`. Proof for `θ < φ < θ + 2π`: extend `C` by the
clockwise germs and radial segments to `ω(u, R)`, `R = 1 + η`, giving `C'` with points at angles `θ − t₀`, `φ − t₀` of `ω(u, R)`; the
points at `θ + t₀`, `φ + t₀` are reached from the `T`-side near `r(θ)` and near `r(φ)` along the counter-clockwise germs, so they are not
joined off `C'` (the crossing lemma at radius `R`); but along the preconnected `C` the `T`-side's class off `C'` is locally constant. -/
theorem orient_aux {u : ℂ} {T C : Set ℂ} (hTo : IsOpen T) (hC : IsClosed C) (hCc : IsPreconnected C) (hCd : C ⊆ closedBall u 1)
    (hCT : Disjoint C T) (hcl : C ⊆ closure T) (hloc : ∀ z ∈ C, ∃ r₀ > 0, ∀ r ∈ Ioc 0 r₀, IsPreconnected (T ∩ ball z r))
    {θ φ : ℝ} (hθφ : θ < φ) (hφθ : φ < θ + 2 * π) (hx : ringPt u θ ∈ C) (hq : ringPt u φ ∈ C)
    (hx₁ : ∃ δ > 0, ∀ t ∈ Ioo 0 δ, ringPt u (θ + t) ∈ closure T \ C) (hx₂ : ∃ δ > 0, ∀ t ∈ Ioo 0 δ, ringPt u (θ - t) ∉ closure T)
    (hq₁ : ∃ δ > 0, ∀ t ∈ Ioo 0 δ, ringPt u (φ + t) ∈ closure T \ C) (hq₂ : ∃ δ > 0, ∀ t ∈ Ioo 0 δ, ringPt u (φ - t) ∉ closure T) :
    False := by
  have hπ := Real.pi_pos
  obtain ⟨δ₁, hδ₁, hx₁⟩ := hx₁
  obtain ⟨δ₂, hδ₂, hx₂⟩ := hx₂
  obtain ⟨δ₃, hδ₃, hq₁⟩ := hq₁
  obtain ⟨δ₄, hδ₄, hq₂⟩ := hq₂
  set m := min (min (min δ₁ δ₂) (min δ₃ δ₄)) (min ((φ - θ) / 2) ((θ + 2 * π - φ) / 2)) with hm
  have hm0 : 0 < m := lt_min (lt_min (lt_min hδ₁ hδ₂) (lt_min hδ₃ hδ₄)) (lt_min (by linarith) (by linarith))
  have hm1 : m ≤ δ₁ := (min_le_left _ _).trans ((min_le_left _ _).trans (min_le_left _ _))
  have hm2 : m ≤ δ₂ := (min_le_left _ _).trans ((min_le_left _ _).trans (min_le_right _ _))
  have hm3 : m ≤ δ₃ := (min_le_left _ _).trans ((min_le_right _ _).trans (min_le_left _ _))
  have hm4 : m ≤ δ₄ := (min_le_left _ _).trans ((min_le_right _ _).trans (min_le_right _ _))
  have hm5 : m ≤ (φ - θ) / 2 := (min_le_right _ _).trans (min_le_left _ _)
  have hm6 : m ≤ (θ + 2 * π - φ) / 2 := (min_le_right _ _).trans (min_le_right _ _)
  set t₀ := m / 2 with ht₀
  have ht₀0 : 0 < t₀ := half_pos hm0
  have ht₀m : t₀ < m := half_lt_self hm0
  -- the clockwise germ points and the radius
  have hTne : (closure T).Nonempty := ⟨_, hcl hx⟩
  have hgx : ringPt u (θ - t₀) ∉ closure T := hx₂ t₀ ⟨ht₀0, by linarith⟩
  have hgq : ringPt u (φ - t₀) ∉ closure T := hq₂ t₀ ⟨ht₀0, by linarith⟩
  have hεx := (isClosed_closure.notMem_iff_infDist_pos hTne).mp hgx
  have hεq := (isClosed_closure.notMem_iff_infDist_pos hTne).mp hgq
  set η := min (infDist (ringPt u (θ - t₀)) (closure T)) (infDist (ringPt u (φ - t₀)) (closure T)) / 2 with hη
  have hη0 : 0 < η := half_pos (lt_min hεx hεq)
  have hηx : η < infDist (ringPt u (θ - t₀)) (closure T) := by
    have := min_le_left (infDist (ringPt u (θ - t₀)) (closure T)) (infDist (ringPt u (φ - t₀)) (closure T)); linarith
  have hηq : η < infDist (ringPt u (φ - t₀)) (closure T) := by
    have := min_le_right (infDist (ringPt u (θ - t₀)) (closure T)) (infDist (ringPt u (φ - t₀)) (closure T)); linarith
  set R := 1 + η with hR
  have hR0 : 0 < R := by linarith
  -- the extensions `Λ α`: the clockwise germ, then the radial segment out to `ω(u, R)`
  set Λ : ℝ → Set ℂ := fun α => ringPt u '' Icc (α - t₀) α ∪ (fun ρ : ℝ => polarPt u ρ (α - t₀)) '' Icc 1 R with hΛ
  have hcontR : ∀ α : ℝ, Continuous fun s : ℝ => ringPt u (α + s) := fun α => by unfold ringPt e; fun_prop
  have hcontR' : Continuous fun s : ℝ => ringPt u s := by unfold ringPt e; fun_prop
  have hcontP : ∀ β : ℝ, Continuous fun ρ : ℝ => polarPt u ρ β := fun β => by unfold polarPt e; fun_prop
  have hΛc : ∀ α, IsCompact (Λ α) := fun α =>
    (isCompact_Icc.image hcontR').union (isCompact_Icc.image (hcontP _))
  have hΛpre : ∀ α, IsPreconnected (Λ α) := by
    intro α
    refine IsPreconnected.union (ringPt u (α - t₀)) ⟨α - t₀, ⟨le_rfl, by linarith⟩, rfl⟩
      ⟨1, ⟨le_rfl, by linarith⟩, (ringPt_eq_polarPt u _).symm⟩ (isPreconnected_Icc.image _ hcontR'.continuousOn)
      (isPreconnected_Icc.image _ (hcontP _).continuousOn)
  have hΛα : ∀ α, ringPt u α ∈ Λ α := fun α => Or.inl ⟨α, ⟨by linarith, le_rfl⟩, rfl⟩
  have hΛe : ∀ α, polarPt u R (α - t₀) ∈ Λ α := fun α => Or.inr ⟨R, ⟨by linarith, le_rfl⟩, rfl⟩
  have hΛd : ∀ α, Λ α ⊆ closedBall u R := by
    intro α z hz
    rcases hz with ⟨s, -, rfl⟩ | ⟨ρ, hρ, rfl⟩
    · rw [mem_closedBall, dist_ringPt]; linarith
    · rw [mem_closedBall, dist_eq_norm, norm_polarPt_sub, abs_of_pos (by linarith [hρ.1])]; exact hρ.2
  -- every point of `Λ α` is a polar point at radius `≥ 1` with angle in `[α − t₀, α]`
  have hΛform : ∀ α z, z ∈ Λ α → ∃ ρ β, 1 ≤ ρ ∧ β ∈ Icc (α - t₀) α ∧ z = polarPt u ρ β := by
    intro α z hz
    rcases hz with ⟨s, hs, rfl⟩ | ⟨ρ, hρ, rfl⟩
    · exact ⟨1, s, le_rfl, hs, ringPt_eq_polarPt u s⟩
    · exact ⟨ρ, α - t₀, hρ.1, ⟨le_rfl, by linarith⟩, rfl⟩
  have hnotΛ : ∀ α γ ρ, 0 < ρ → (∀ β ∈ Icc (α - t₀) α, (0 < γ - β ∧ γ - β < 2 * π) ∨ (0 < β - γ ∧ β - γ < 2 * π)) →
      polarPt u ρ γ ∉ Λ α := by
    intro α γ ρ hρ hang hmem
    obtain ⟨ρ', β, hρ', hβ, heq⟩ := hΛform α _ hmem
    rcases hang β hβ with h | h
    · exact polarPt_ne_of_sub hρ (by linarith) h.1 h.2 heq
    · exact polarPt_ne_of_sub (by linarith) hρ h.1 h.2 heq.symm
  -- `Λ α` misses `T`
  have hΛT : ∀ α, (∀ t ∈ Ioc 0 t₀, ringPt u (α - t) ∉ closure T) → ringPt u α ∉ T →
      η < infDist (ringPt u (α - t₀)) (closure T) → Disjoint (Λ α) T := by
    intro α hgerm hαT hηα
    rw [Set.disjoint_left]
    rintro z (⟨s, hs, rfl⟩ | ⟨ρ, hρ, rfl⟩) hzT
    · by_cases hsα : s = α
      · exact hαT (hsα ▸ hzT)
      · have h := hgerm (α - s) ⟨by linarith [lt_of_le_of_ne hs.2 hsα], by linarith [hs.1]⟩
        rw [show α - (α - s) = s by ring] at h
        exact h (subset_closure hzT)
    · have hd : dist (polarPt u ρ (α - t₀)) (ringPt u (α - t₀)) ≤ η := by
        have := dist_polarPt_ringPt_le u ρ (α - t₀) (α - t₀)
        rw [sub_self, abs_zero, add_zero, abs_of_nonneg (by linarith [hρ.1])] at this
        linarith [hρ.2]
      have := infDist_le_dist_of_mem (x := ringPt u (α - t₀)) (subset_closure hzT)
      rw [dist_comm] at this
      linarith
  have hxT : ringPt u θ ∉ T := fun h => Set.disjoint_left.mp hCT hx h
  have hqT : ringPt u φ ∉ T := fun h => Set.disjoint_left.mp hCT hq h
  have hΛxT := hΛT θ (fun t ht => hx₂ t ⟨ht.1, by linarith [ht.2]⟩) hxT hηx
  have hΛqT := hΛT φ (fun t ht => hq₂ t ⟨ht.1, by linarith [ht.2]⟩) hqT hηq
  -- the extended continuum
  set C' := C ∪ Λ θ ∪ Λ φ with hC'
  have hC'c : IsClosed C' := (hC.union (hΛc θ).isClosed).union (hΛc φ).isClosed
  have hC'pre : IsPreconnected C' :=
    (hCc.union (ringPt u θ) hx (hΛα θ) (hΛpre θ)).union (ringPt u φ) (Or.inl hq) (hΛα φ) (hΛpre φ)
  have hC'd : C' ⊆ closedBall u R := by
    refine union_subset (union_subset (hCd.trans (closedBall_subset_closedBall (by linarith))) (hΛd θ)) (hΛd φ)
  have hC'T : Disjoint C' T := (hCT.union_left hΛxT).union_left hΛqT
  have hC'ne : C'.Nonempty := ⟨_, Or.inl (Or.inl hx)⟩
  set V' := closedBall u R \ C' with hV'
  -- the points reached along the counter-clockwise germs avoid `C'`
  have hoffC : ∀ ρ γ, 1 ≤ ρ → ρ ≤ R → (ρ = 1 → ringPt u γ ∉ C) → polarPt u ρ γ ∉ C := by
    intro ρ γ hρ1 hρR h1 hmem
    rcases eq_or_lt_of_le hρ1 with h | h
    · subst h; exact h1 rfl (by rw [ringPt_eq_polarPt]; exact hmem)
    · have := hCd hmem
      rw [mem_closedBall, dist_eq_norm, norm_polarPt_sub, abs_of_pos (by linarith)] at this
      linarith
  have hθoff : ∀ ρ ∈ Icc 1 R, ∀ t ∈ Ioc 0 t₀, polarPt u ρ (θ + t) ∉ C' := by
    intro ρ hρ t ht hmem
    rcases hmem with (hmem | hmem) | hmem
    · exact hoffC ρ (θ + t) hρ.1 hρ.2 (fun _ => (hx₁ t ⟨ht.1, by linarith [ht.2]⟩).2) hmem
    · refine hnotΛ θ (θ + t) ρ (by linarith [hρ.1]) (fun β hβ => Or.inl ⟨by linarith [hβ.2, ht.1], ?_⟩) hmem
      linarith [hβ.1, ht.2]
    · refine hnotΛ φ (θ + t) ρ (by linarith [hρ.1]) (fun β hβ => Or.inr ⟨by linarith [hβ.1, ht.2], ?_⟩) hmem
      linarith [hβ.2, ht.1]
  have hφoff : ∀ ρ ∈ Icc 1 R, ∀ t ∈ Ioc 0 t₀, polarPt u ρ (φ + t) ∉ C' := by
    intro ρ hρ t ht hmem
    rcases hmem with (hmem | hmem) | hmem
    · exact hoffC ρ (φ + t) hρ.1 hρ.2 (fun _ => (hq₁ t ⟨ht.1, by linarith [ht.2]⟩).2) hmem
    · refine hnotΛ θ (φ + t) ρ (by linarith [hρ.1]) (fun β hβ => Or.inl ⟨by linarith [hβ.2, ht.1], ?_⟩) hmem
      linarith [hβ.1, ht.2]
    · refine hnotΛ φ (φ + t) ρ (by linarith [hρ.1]) (fun β hβ => Or.inl ⟨by linarith [hβ.2, ht.1], ?_⟩) hmem
      linarith [hβ.1, ht.2]
  -- the `T`-side near a point of `C` lies off `C'`
  have hsideV : ∀ z ∈ C, ∀ r ≤ η, T ∩ ball z r ⊆ V' := by
    intro z hz r hr v hv
    refine ⟨?_, fun h => Set.disjoint_left.mp hC'T h hv.1⟩
    have h1 := hCd hz
    rw [mem_closedBall] at h1 ⊢
    have h2 := mem_ball.mp hv.2
    linarith [dist_triangle v z u]
  -- the `T`-side near `r(α)` is joined off `C'` to `ω(u, R)` at angle `α + t₀`
  have hside : ∀ α : ℝ, ringPt u α ∈ C → (∀ t ∈ Ioc 0 t₀, ringPt u (α + t) ∈ closure T) →
      (∀ ρ ∈ Icc 1 R, ∀ t ∈ Ioc 0 t₀, polarPt u ρ (α + t) ∉ C') →
      ∃ r > 0, ∀ v ∈ T ∩ ball (ringPt u α) r, JoinedIn V' (polarPt u R (α + t₀)) v := by
    intro α hα hcl' hoff
    obtain ⟨r₀, hr₀, hpre⟩ := hloc _ hα
    set r := min r₀ η with hr
    have hr0 : 0 < r := lt_min hr₀ hη0
    have hSV := hsideV _ hα r (min_le_right _ _)
    set t₁ := min t₀ (r / 4) with ht₁
    have ht₁0 : 0 < t₁ := lt_min ht₀0 (by linarith)
    have ht₁t₀ : t₁ ≤ t₀ := min_le_left _ _
    have ht₁r : t₁ ≤ r / 4 := min_le_right _ _
    have hg₁T : ringPt u (α + t₁) ∈ closure T := hcl' t₁ ⟨ht₁0, ht₁t₀⟩
    have hg₁C' : ringPt u (α + t₁) ∉ C' := by
      rw [ringPt_eq_polarPt]; exact hoff 1 ⟨le_rfl, by linarith⟩ t₁ ⟨ht₁0, ht₁t₀⟩
    have hε' := (hC'c.notMem_iff_infDist_pos hC'ne).mp hg₁C'
    obtain ⟨w₀, hw₀T, hw₀d⟩ := Metric.mem_closure_iff.mp hg₁T (min (infDist (ringPt u (α + t₁)) C') (r / 4))
      (lt_min hε' (by linarith))
    have hg₁x : dist (ringPt u (α + t₁)) (ringPt u α) ≤ t₁ := by
      rw [dist_eq_norm, show ringPt u (α + t₁) - ringPt u α = e (α + t₁) - e α by simp [ringPt]]
      have := norm_e_sub_e_le (α + t₁) α
      rwa [show α + t₁ - α = t₁ by ring, abs_of_pos ht₁0] at this
    have hw₀S : w₀ ∈ T ∩ ball (ringPt u α) r := by
      refine ⟨hw₀T, ?_⟩
      rw [mem_ball]
      have := min_le_right (infDist (ringPt u (α + t₁)) C') (r / 4)
      rw [dist_comm] at hw₀d
      linarith [dist_triangle w₀ (ringPt u (α + t₁)) (ringPt u α)]
    -- `w₀` to the germ point, inside a ball missing `C'`
    have hJ1 : JoinedIn V' w₀ (ringPt u (α + t₁)) := by
      set Bl := ball (ringPt u (α + t₁)) (infDist (ringPt u (α + t₁)) C') ∩ closedBall u R with hBl
      have hBlV : Bl ⊆ V' := fun y hy => ⟨hy.2, fun hyC => by
        have := infDist_le_dist_of_mem (x := ringPt u (α + t₁)) hyC
        have h2 := mem_ball.mp hy.1
        rw [dist_comm] at h2
        linarith⟩
      have hw₀Bl : w₀ ∈ Bl := by
        refine ⟨?_, (hSV hw₀S).1⟩
        rw [mem_ball, dist_comm]
        exact lt_of_lt_of_le hw₀d (min_le_left _ _)
      have hg₁Bl : ringPt u (α + t₁) ∈ Bl :=
        ⟨mem_ball_self hε', by rw [mem_closedBall, dist_ringPt]; linarith⟩
      exact (((convex_ball _ _).inter (convex_closedBall _ _)).isPathConnected ⟨_, hw₀Bl⟩).joinedIn _ hw₀Bl _ hg₁Bl
        |>.mono hBlV
    -- along the germ
    have hJ2 : JoinedIn V' (ringPt u (α + t₁)) (ringPt u (α + t₀)) := by
      have hP : IsPathConnected ((fun s : ℝ => ringPt u (α + s)) '' Icc t₁ t₀) :=
        ((convex_Icc t₁ t₀).isPathConnected (nonempty_Icc.mpr ht₁t₀)).image' (hcontR α).continuousOn
      refine (hP.joinedIn _ ⟨t₁, ⟨le_rfl, ht₁t₀⟩, rfl⟩ _ ⟨t₀, ⟨ht₁t₀, le_rfl⟩, rfl⟩).mono ?_
      rintro _ ⟨s, hs, rfl⟩
      refine ⟨by rw [mem_closedBall, dist_ringPt]; linarith, ?_⟩
      show ringPt u (α + s) ∉ C'
      rw [ringPt_eq_polarPt]
      exact hoff 1 ⟨le_rfl, by linarith⟩ s ⟨by linarith [hs.1], hs.2⟩
    -- out along the radius
    have hJ3 : JoinedIn V' (ringPt u (α + t₀)) (polarPt u R (α + t₀)) := by
      have hP : IsPathConnected ((fun ρ : ℝ => polarPt u ρ (α + t₀)) '' Icc 1 R) :=
        ((convex_Icc 1 R).isPathConnected (nonempty_Icc.mpr (by linarith))).image' (hcontP _).continuousOn
      refine (hP.joinedIn _ ⟨1, ⟨le_rfl, by linarith⟩, (ringPt_eq_polarPt u _).symm⟩ _
        ⟨R, ⟨by linarith, le_rfl⟩, rfl⟩).mono ?_
      rintro _ ⟨ρ, hρ, rfl⟩
      refine ⟨?_, hoff ρ hρ t₀ ⟨ht₀0, le_rfl⟩⟩
      rw [mem_closedBall, dist_eq_norm, norm_polarPt_sub, abs_of_pos (by linarith [hρ.1])]
      exact hρ.2
    refine ⟨r, hr0, fun v hv => ?_⟩
    have hSpc : IsPathConnected (T ∩ ball (ringPt u α) r) :=
      (hTo.inter isOpen_ball).isConnected_iff_isPathConnected.mp ⟨⟨w₀, hw₀S⟩, hpre r ⟨hr0, min_le_left _ _⟩⟩
    have hJ4 : JoinedIn V' w₀ v := (hSpc.joinedIn _ hw₀S _ hv).mono hSV
    exact hJ3.symm.trans (hJ2.symm.trans (hJ1.symm.trans hJ4))
  -- the two radial ends are not joined off `C'` (the crossing lemma at radius `R`)
  have hNJ : ¬ JoinedIn V' (polarPt u R (θ + t₀)) (polarPt u R (φ + t₀)) := by
    intro hJ
    set γ := hJ.somePath
    obtain ⟨z, hzC', hzγ⟩ := inter_nonempty_of_interleaved_radius (K := C') (K' := range γ) hR0 hC'c hC'pre
      (isPreconnected_range γ.continuous) hC'd (fun y ⟨s, hs⟩ => hs ▸ (hJ.somePath_mem s).1)
      (s := θ - t₀) (s' := θ + t₀) (t := φ - t₀) (t' := φ + t₀) (by linarith) (by linarith) (by linarith) (by linarith)
      (Or.inl (Or.inr (hΛe θ))) (Or.inr (hΛe φ)) ⟨0, γ.source⟩ ⟨1, γ.target⟩
    obtain ⟨s, rfl⟩ := hzγ
    exact (hJ.somePath_mem s).2 hzC'
  -- the class of the `T`-side is locally constant along `C`
  set UA := {w : ℂ | ∃ r > 0, ∀ v ∈ T ∩ ball w r, JoinedIn V' (polarPt u R (θ + t₀)) v} with hUA
  set UB := {w : ℂ | ∃ r > 0, ∀ v ∈ T ∩ ball w r, ¬ JoinedIn V' (polarPt u R (θ + t₀)) v} with hUB
  have hshrink : ∀ (P : ℂ → Prop) (w : ℂ) (r : ℝ), 0 < r → (∀ v ∈ T ∩ ball w r, P v) →
      ∀ w' ∈ ball w (r / 2), ∀ v ∈ T ∩ ball w' (r / 2), P v := by
    intro P w r hr h w' hw' v hv
    refine h v ⟨hv.1, ?_⟩
    rw [mem_ball] at hw' ⊢
    have := mem_ball.mp hv.2
    linarith [dist_triangle v w' w]
  have hUAo : IsOpen UA := by
    rw [Metric.isOpen_iff]
    rintro w ⟨r, hr, hw⟩
    exact ⟨r / 2, half_pos hr, fun w' hw' => ⟨r / 2, half_pos hr, hshrink _ w r hr hw w' hw'⟩⟩
  have hUBo : IsOpen UB := by
    rw [Metric.isOpen_iff]
    rintro w ⟨r, hr, hw⟩
    exact ⟨r / 2, half_pos hr, fun w' hw' => ⟨r / 2, half_pos hr, hshrink _ w r hr hw w' hw'⟩⟩
  have hcov : C ⊆ UA ∪ UB := by
    intro z hz
    obtain ⟨r₀, hr₀, hpre⟩ := hloc z hz
    set r := min r₀ η with hr
    have hr0 : 0 < r := lt_min hr₀ hη0
    have hSV := hsideV z hz r (min_le_right _ _)
    by_cases hex : ∃ v ∈ T ∩ ball z r, JoinedIn V' (polarPt u R (θ + t₀)) v
    · obtain ⟨v₀, hv₀, hJ₀⟩ := hex
      have hSpc : IsPathConnected (T ∩ ball z r) :=
        (hTo.inter isOpen_ball).isConnected_iff_isPathConnected.mp ⟨⟨v₀, hv₀⟩, hpre r ⟨hr0, min_le_left _ _⟩⟩
      exact Or.inl ⟨r, hr0, fun v hv => hJ₀.trans ((hSpc.joinedIn _ hv₀ _ hv).mono hSV)⟩
    · push Not at hex
      exact Or.inr ⟨r, hr0, hex⟩
  have hdisj : C ∩ (UA ∩ UB) = ∅ := by
    rw [Set.eq_empty_iff_forall_notMem]
    rintro z ⟨hz, ⟨r₁, hr₁, h₁⟩, ⟨r₂, hr₂, h₂⟩⟩
    obtain ⟨v, hvT, hvd⟩ := Metric.mem_closure_iff.mp (hcl hz) (min r₁ r₂) (lt_min hr₁ hr₂)
    have hv1 : v ∈ ball z r₁ := by rw [mem_ball, dist_comm]; exact lt_of_lt_of_le hvd (min_le_left _ _)
    have hv2 : v ∈ ball z r₂ := by rw [mem_ball, dist_comm]; exact lt_of_lt_of_le hvd (min_le_right _ _)
    exact h₂ v ⟨hvT, hv2⟩ (h₁ v ⟨hvT, hv1⟩)
  have hxA : ringPt u θ ∈ UA :=
    hside θ hx (fun t ht => (hx₁ t ⟨ht.1, by linarith [ht.2]⟩).1) hθoff
  have hqB : ringPt u φ ∈ UB := by
    obtain ⟨r, hr, h⟩ := hside φ hq (fun t ht => (hq₁ t ⟨ht.1, by linarith [ht.2]⟩).1) hφoff
    exact ⟨r, hr, fun v hv hJ => hNJ (hJ.trans (h v hv).symm)⟩
  rcases isPreconnected_iff_subset_of_disjoint.mp hCc UA UB hUAo hUBo hcov hdisj with h | h
  · exact (Set.eq_empty_iff_forall_notMem.mp hdisj) _ ⟨hq, h hq, hqB⟩
  · exact (Set.eq_empty_iff_forall_notMem.mp hdisj) _ ⟨hx, hxA, h hx⟩

/-- **The model of `inter_nonempty_of_interleaved_radius`'s hypotheses** (every hypothesis at once): the two crossing diameters of the disc of
radius `2` about `0`, from angle `0` to `π` and from `π/2` to `3π/2`. -/
example : (segment ℝ (polarPt 0 2 0) (polarPt 0 2 π) ∩ segment ℝ (polarPt 0 2 (π / 2)) (polarPt 0 2 (3 * π / 2))).Nonempty := by
  have hc : IsClosed (segment ℝ (polarPt 0 2 0) (polarPt 0 2 π)) := by
    rw [segment_eq_image' ℝ]; exact (isCompact_Icc.image (by fun_prop)).isClosed
  have hm : ∀ x : ℝ, polarPt 0 2 x ∈ closedBall (0 : ℂ) 2 := fun x => by
    rw [mem_closedBall, dist_eq_norm, norm_polarPt_sub, abs_of_pos two_pos]
  exact inter_nonempty_of_interleaved_radius two_pos hc (convex_segment _ _).isPreconnected (convex_segment _ _).isPreconnected
    ((convex_closedBall 0 2).segment_subset (hm _) (hm _)) ((convex_closedBall 0 2).segment_subset (hm _) (hm _))
    (by linarith [Real.pi_pos]) (by linarith [Real.pi_pos]) (by linarith [Real.pi_pos]) (by linarith [Real.pi_pos])
    (left_mem_segment _ _ _) (right_mem_segment _ _ _) (left_mem_segment _ _ _) (right_mem_segment _ _ _)

/-- A spec example for `polarPt_ne_of_sub`: the points `2` and `2i` of the circle of radius `2` differ. -/
example : polarPt 0 2 (π / 2) ≠ polarPt 0 2 0 :=
  polarPt_ne_of_sub two_pos two_pos (by linarith [Real.pi_pos]) (by linarith [Real.pi_pos])

/-- **The one-sidedness of a separating continuum**, any two angles (`orient_aux` after reducing `φ` into `(θ, θ + 2π)`). -/
theorem orient {u : ℂ} {T C : Set ℂ} (hTo : IsOpen T) (hC : IsClosed C) (hCc : IsPreconnected C) (hCd : C ⊆ closedBall u 1)
    (hCT : Disjoint C T) (hcl : C ⊆ closure T) (hloc : ∀ z ∈ C, ∃ r₀ > 0, ∀ r ∈ Ioc 0 r₀, IsPreconnected (T ∩ ball z r))
    {θ φ : ℝ} (hx : ringPt u θ ∈ C) (hq : ringPt u φ ∈ C) (hxq : ringPt u θ ≠ ringPt u φ)
    (hx₁ : ∃ δ > 0, ∀ t ∈ Ioo 0 δ, ringPt u (θ + t) ∈ closure T \ C) (hx₂ : ∃ δ > 0, ∀ t ∈ Ioo 0 δ, ringPt u (θ - t) ∉ closure T)
    (hq₁ : ∃ δ > 0, ∀ t ∈ Ioo 0 δ, ringPt u (φ + t) ∈ closure T \ C) (hq₂ : ∃ δ > 0, ∀ t ∈ Ioo 0 δ, ringPt u (φ - t) ∉ closure T) :
    False := by
  obtain ⟨ψ, hψ, heψ⟩ := exists_mem_Icc_e_eq θ φ
  have hshift : ∀ t, ringPt u (ψ + t) = ringPt u (φ + t) := fun t => by simp only [ringPt, e_add, heψ]
  have hshift' : ∀ t, ringPt u (ψ - t) = ringPt u (φ - t) := fun t => by
    simp only [ringPt, sub_eq_add_neg, e_add, heψ]
  have hψφ : ringPt u ψ = ringPt u φ := by simpa using hshift 0
  have hθψ : θ < ψ := lt_of_le_of_ne hψ.1 fun h => hxq (by rw [← hψφ, h])
  have hψθ : ψ < θ + 2 * π := lt_of_le_of_ne hψ.2 fun h => hxq (by rw [← hψφ, h, ringPt, ringPt, e_add_two_pi])
  refine orient_aux hTo hC hCc hCd hCT hcl hloc hθψ hψθ hx (hψφ ▸ hq) hx₁ hx₂ ?_ ?_
  · obtain ⟨δ, hδ, h⟩ := hq₁; exact ⟨δ, hδ, fun t ht => hshift t ▸ h t ht⟩
  · obtain ⟨δ, hδ, h⟩ := hq₂; exact ⟨δ, hδ, fun t ht => hshift' t ▸ h t ht⟩

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- A tile meeting a sector of a chart holds the whole sector (the sector is preconnected inside the interior points). -/
theorem IsSectorChart.sector_subset_tile_of_mem {n : ℕ} {G : BranchGerms n} {z : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G z r₀)
    (hn : 0 < n) {r : ℝ} (hr : r ∈ Ioc 0 r₀) {A : Set ℂ} (hA : F.IsTile A) {j : Fin n} {w : ℂ} (hw : w ∈ G.sector z r j)
    (hwA : w ∈ A) : G.sector z r j ⊆ A := by
  obtain ⟨x, hx, rfl⟩ := hA
  rw [connectedComponentIn_eq hwA]
  exact (hC.isPreconnected r hr j).subset_connectedComponentIn hw (hC.sector_subset_interiorPts hn hr j)

/-- **A tile is one-sided at a point with no repeated colour**: near a point `z` of the domain in the closure of a tile `T` of colour `c`,
with no repeated colour, `T ∩ B(z, r)` is one sector (or the whole disc), hence preconnected, and `T` is the only tile of colour `c` meeting
`B(z, r)`; the disc lies in the domain. -/
theorem tile_side {z : ℂ} (hz : z ∈ F.dom) (hnr : ¬ F.HasRepeatedColour z) {c : Fin k} {T : Set ℂ} (hT : F.TileOf c T)
    (hzT : z ∈ closure T) :
    ∃ r₀ > 0, ball z r₀ ⊆ F.dom ∧ ∀ r ∈ Ioc 0 r₀, IsPreconnected (T ∩ ball z r) ∧
      ∀ T', F.TileOf c T' → (T' ∩ ball z r).Nonempty → T' = T := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hz
  refine ⟨r₀, hC.pos, hC.subdom, fun r hr => ?_⟩
  obtain ⟨a, haT, hab⟩ := (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨z, hzT, mem_ball_self hr.1⟩
  by_cases hn : n = 0
  · -- no germ: the disc is interior, inside `T`
    have hball : ball z r ⊆ F.interiorPts := (ball_subset_ball hr.2).trans (hC.empty hn)
    have hsub : ball z r ⊆ T := by
      obtain ⟨x, hx, hTx⟩ := hT.1
      rw [hTx, connectedComponentIn_eq (hTx ▸ haT)]
      exact (convex_ball z r).isPreconnected.subset_connectedComponentIn hab hball
    refine ⟨by rw [inter_eq_right.mpr hsub]; exact (convex_ball z r).isPreconnected, fun T' hT' ⟨w, hwT', hwb⟩ => ?_⟩
    exact hT'.1.eq_of_mem hT.1 hwT' (hsub hwb)
  have hn0 : 0 < n := Nat.pos_of_ne_zero hn
  obtain ⟨i, hi⟩ := hC.exists_sector_subset_tile hn0 hr hT.1 hzT
  -- a tile of colour `c` meeting the disc holds a sector, which is `i`
  have hsec : ∀ T', F.TileOf c T' → ∀ w ∈ T' ∩ ball z r, ∃ j, w ∈ G.sector z r j ∧ G.sector z r j ⊆ T' ∧ j = i := by
    intro T' hT' w ⟨hwT', hwb⟩
    have hw : w ∈ ball z r ∩ F.interiorPts := ⟨hwb, hT'.1.subset_interiorPts hwT'⟩
    rw [hC.cover r hr hn0] at hw
    obtain ⟨j, hj⟩ := mem_iUnion.mp hw
    have hjT' := hC.sector_subset_tile_of_mem hn0 hr hT'.1 hj hwT'
    refine ⟨j, hj, hjT', ?_⟩
    by_contra hji
    obtain ⟨y, hy⟩ := hC.sector_nonempty hr i
    exact hnr (hC.hasRepeatedColour_of_col_eq hn0 hr hji hj hy (by rw [hT'.2 (hjT' hj), hT.2 (hi hy)]))
  have heq : T ∩ ball z r = G.sector z r i := by
    apply Subset.antisymm
    · intro w hw
      obtain ⟨j, hj, -, rfl⟩ := hsec T hT w hw
      exact hj
    · intro w hw
      exact ⟨hi hw, G.sector_subset_ball i hw⟩
  refine ⟨heq ▸ hC.isPreconnected r hr i, fun T' hT' ⟨w, hw⟩ => ?_⟩
  obtain ⟨j, hj, hjT', rfl⟩ := hsec T' hT' w hw
  exact hT'.1.eq_of_mem hT.1 (hjT' hj) (hi hj)

/-- **The germs of a change point, read through the tiles**: at a change point `r(θ)` of the pseudo-colouring of `ω(u)` from `a` (clockwise)
to `c` (counter-clockwise), with `T₂` the `c`-tile there and no repeated colour at `r(θ)`, the counter-clockwise germ lies in `cl T₂` and
off `cl T₁` (any `a`-tile `T₁`), and the clockwise germ off `cl T₂`. -/
theorem germ_side {u : ℂ} {θ : ℝ} {a c : Fin k} (hac : a ≠ c) (ha : F.GermPseudo u θ .cw a) (hc : F.GermPseudo u θ .ccw c)
    {T₁ T₂ : Set ℂ} (h₁ : F.TileOf a T₁) (h₂ : F.TileOf c T₂) (hxd : ringPt u θ ∈ F.dom) (hnr : ¬ F.HasRepeatedColour (ringPt u θ))
    (hx₂ : ringPt u θ ∈ closure T₂) :
    (∃ δ > 0, ∀ t ∈ Ioo 0 δ, ringPt u (θ + t) ∈ closure T₂ \ closure T₁) ∧
      ∃ δ > 0, ∀ t ∈ Ioo 0 δ, ringPt u (θ - t) ∉ closure T₂ := by
  obtain ⟨r₀, hr₀, hdom, hside⟩ := tile_side hxd hnr h₂ hx₂
  obtain ⟨δa, hδa, hga⟩ := ha
  obtain ⟨δc, hδc, hgc⟩ := hc
  have hmemA : ∀ t ∈ Ioo 0 δa, F.pseudoColours u (ringPt u (θ - t)) = {a} := fun t ht =>
    hga ⟨t, ht, by simp only [Side.sign]; congr 1; ring⟩
  have hmemC : ∀ t ∈ Ioo 0 δc, F.pseudoColours u (ringPt u (θ + t)) = {c} := fun t ht =>
    hgc ⟨t, ht, by simp only [Side.sign, one_mul]⟩
  have hau : a ∉ F.coloursAt u := by
    have : a ∈ F.pseudoColours u (ringPt u (θ - δa / 2)) := by
      rw [hmemA _ ⟨half_pos hδa, half_lt_self hδa⟩]; rfl
    exact this.2
  have hcu : c ∉ F.coloursAt u := by
    have : c ∈ F.pseudoColours u (ringPt u (θ + δc / 2)) := by
      rw [hmemC _ ⟨half_pos hδc, half_lt_self hδc⟩]; rfl
    exact this.2
  refine ⟨⟨min δc r₀, lt_min hδc hr₀, fun t ht => ⟨?_, fun hT₁ => ?_⟩⟩, ⟨δa, hδa, fun t ht hT₂ => ?_⟩⟩
  · have htc : t ∈ Ioo 0 δc := ⟨ht.1, ht.2.trans_le (min_le_left _ _)⟩
    have hp : c ∈ F.coloursAt (ringPt u (θ + t)) := by
      have : c ∈ F.pseudoColours u (ringPt u (θ + t)) := by rw [hmemC t htc]; rfl
      exact this.1
    have hpb : ringPt u (θ + t) ∈ ball (ringPt u θ) r₀ := by
      rw [mem_ball, dist_eq_norm, show ringPt u (θ + t) - ringPt u θ = e (θ + t) - e θ by simp [ringPt]]
      have := norm_e_sub_e_le (θ + t) θ
      rw [show θ + t - θ = t by ring, abs_of_pos ht.1] at this
      linarith [ht.2.trans_le (min_le_right _ _)]
    obtain ⟨T', hT', hpT'⟩ := (F.mem_coloursAt_iff_exists_tileOf (hdom hpb)).mp hp
    have hT'ne : (T' ∩ ball (ringPt u θ) r₀).Nonempty :=
      (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨_, hpT', hpb⟩
    rw [← (hside r₀ ⟨hr₀, le_rfl⟩).2 T' hT' hT'ne]
    exact hpT'
  · have htc : t ∈ Ioo 0 δc := ⟨ht.1, ht.2.trans_le (min_le_left _ _)⟩
    have : a ∈ F.pseudoColours u (ringPt u (θ + t)) := ⟨mem_coloursAt_of_tileOf h₁ hT₁, hau⟩
    rw [hmemC t htc, mem_singleton_iff] at this
    exact hac this
  · have : c ∈ F.pseudoColours u (ringPt u (θ - t)) := ⟨mem_coloursAt_of_tileOf h₂ hT₂, hcu⟩
    rw [hmemA t ht, mem_singleton_iff] at this
    exact hac this.symm

/-- A tile has one colour. -/
theorem TileOf.eq_colour {c c' : Fin k} {T : Set ℂ} (h : F.TileOf c T) (h' : F.TileOf c' T) : c = c' := by
  obtain ⟨y, hy⟩ := h.1.nonempty
  exact (h.2 hy).symm.trans (h'.2 hy)

/-- `GermPseudo` reads only the point `r(θ)`: it is unchanged when `θ` moves by a turn. -/
theorem GermPseudo.congr_e {u : ℂ} {θ θ' : ℝ} (he : e θ = e θ') {s : Side} {a : Fin k}
    (h : F.GermPseudo u θ s a) : F.GermPseudo u θ' s a := by
  obtain ⟨δ, hδ, hg⟩ := h
  refine ⟨δ, hδ, fun z hz => hg ?_⟩
  obtain ⟨t, ht, rfl⟩ := hz
  exact ⟨t, ht, by simp only [ringPt, e_add, he]⟩

/-- A germ has one pseudo-colour, on either side. -/
theorem GermPseudo.eq_of_same {u : ℂ} {θ : ℝ} {s : Side} {a c : Fin k} (ha : F.GermPseudo u θ s a)
    (hc : F.GermPseudo u θ s c) : a = c := by
  obtain ⟨δ₁, hδ₁, h₁⟩ := ha
  obtain ⟨δ₂, hδ₂, h₂⟩ := hc
  have hδ : 0 < min δ₁ δ₂ := lt_min hδ₁ hδ₂
  obtain ⟨z, hz⟩ : (germ u θ s (min δ₁ δ₂)).Nonempty :=
    ⟨_, mem_image_of_mem _ (show min δ₁ δ₂ / 2 ∈ Ioo 0 (min δ₁ δ₂) from ⟨by linarith, by linarith⟩)⟩
  have e₁ : F.pseudoColours u z = {a} := h₁ (germ_mono (min_le_left _ _) hz)
  have e₂ : F.pseudoColours u z = {c} := h₂ (germ_mono (min_le_right _ _) hz)
  exact Set.singleton_eq_singleton_iff.mp (e₁.symm.trans e₂)

end ArcMap

end HadwigerNelson.Plane
