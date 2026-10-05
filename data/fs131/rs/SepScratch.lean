import Proofs.HadwigerNelson.Plane.ValidMap.MapGraph

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **SEP-S** -/
theorem exists_isClosed_of_reachable_offTwo {x y : {T : Set ℂ // F.IsOuterTile T}} {a b : Thomassen.offTwo x y}
    (h : (F.filledGraph.induce (Thomassen.offTwo x y)).Reachable a b) :
    ∃ S : Set ℂ, IsClosed S ∧ IsPreconnected S ∧ closure (fill a.1.1) ⊆ S ∧ closure (fill b.1.1) ⊆ S ∧
      ∀ w ∈ S, ∃ v ∈ Thomassen.offTwo x y, w ∈ closure (fill v.1) := by
  obtain ⟨W⟩ := h
  induction W with
  | @nil u =>
    exact ⟨closure (fill u.1.1), isClosed_closure, isPreconnected_closure_fill u.1.2.1, subset_rfl, subset_rfl,
      fun w hw => ⟨u.1, u.2, hw⟩⟩
  | @cons u v w' hadj W ih =>
    obtain ⟨S, hSc, hSp, hvS, hbS, hSsub⟩ := ih
    obtain ⟨-, q, hq1, hq2⟩ := SimpleGraph.induce_adj.mp hadj
    refine ⟨closure (fill u.1.1) ∪ S, isClosed_closure.union hSc,
      (isPreconnected_closure_fill u.1.2.1).union q hq1 (hvS hq2) hSp, subset_union_left, hbS.trans subset_union_right, ?_⟩
    rintro w (hw | hw)
    · exact ⟨u.1, u.2, hw⟩
    · exact hSsub w hw

/-- **The pure disc misses the closure of every open set off `x` and `y`** -/
theorem IsEdgeOf.disjoint_closure_ball {x y E O : Set ℂ} {u w p : ℂ} {ρ : ℝ} (hE : IsEdgeOf x y E u w p ρ) (hO : IsOpen O)
    (hOx : Disjoint O x) (hOy : Disjoint O y) : Disjoint (closure O) (ball p ρ) := by
  obtain ⟨-, -, hEsub, -, -, -, -, -, hball, -⟩ := hE
  refine Disjoint.closure_left ?_ isOpen_ball
  rw [Set.disjoint_left]
  intro v hvO hvB
  rcases hball hvB with (hvx | hvy) | hvE
  · exact Set.disjoint_left.mp hOx hvO hvx
  · exact Set.disjoint_left.mp hOy hvO hvy
  · obtain ⟨w', hw'O, hw'x⟩ := mem_closure_iff.mp (hEsub hvE).1 O hO hvO
    exact Set.disjoint_left.mp hOx hw'O hw'x

/-- The previous index's successor, read mod `len`. -/
theorem mod_succ_prev {len q : ℕ} (hq : q < len) : ((q + len - 1) % len + 1) % len = q := by
  rcases q with _ | q
  · rw [Nat.mod_eq_of_lt (by omega : 0 + len - 1 < len), show 0 + len - 1 + 1 = len by omega, Nat.mod_self]
  · rw [show q + 1 + len - 1 = q + len by omega, Nat.add_mod_right, Nat.mod_eq_of_lt (by omega : q < len),
      Nat.mod_eq_of_lt hq]

/-- **SEP-PIECE** -/
theorem IsBoundaryWalk.exists_piece {x : {T : Set ℂ // F.IsOuterTile T}} {r : List {T : Set ℂ // F.IsOuterTile T}} {z : ℕ → ℂ}
    {E : ℕ → Set ℂ} {p : ℕ → ℂ} {ρ : ℕ → ℝ} {edge : ℕ → Prop} (h : F.IsBoundaryWalk x r z E p ρ edge)
    {y : {T : Set ℂ // F.IsOuterTile T}} {i j : ℕ} (hij : i ≠ j) (hyi : r[i]? = some y) (hyj : r[j]? = some y) {q : ℕ}
    (hq : q < r.length) (hqi : q ≠ i) (hqj : q ≠ j) :
    ∃ P : Set ℂ, IsClosed P ∧ IsPreconnected P ∧ z ((q + r.length - 1) % r.length) ∈ P ∧ z q ∈ P ∧ Disjoint P (x.1 ∪ y.1) ∧
      Disjoint P (ball (p i) (ρ i)) ∧ p j ∉ P ∧ ∀ c, r[q]? = some c → c ≠ y → closure c.1 ⊆ P := by
  have hilen : i < r.length := (List.getElem?_eq_some_iff.mp hyi).1
  have hjlen : j < r.length := (List.getElem?_eq_some_iff.mp hyj).1
  have hpos : 0 < r.length := by omega
  obtain ⟨hei, hej⟩ := h.rep i j y hij hyi hyj
  have hEi := h.edgeOf i y hyi hei
  have hEj := h.edgeOf j y hyj hej
  have hρj : 0 < ρ j := hEj.2.2.2.2.2.2.2.1
  have hcq : r[q]? = some r[q] := List.getElem?_eq_getElem hq
  by_cases hcy : r[q] = y
  · have heq := (h.rep q i y hqi (hcy ▸ hcq) hyi).1
    obtain ⟨hEc, hEp, -, hEd, hu, hw, -⟩ := h.edgeOf q y (hcy ▸ hcq) heq
    refine ⟨E q, hEc, hEp, hu, hw, hEd, (h.apart i hilen hei q hq hqi heq).mono_right ball_subset_closedBall,
      fun hm => Set.disjoint_left.mp (h.apart j hjlen hej q hq hqj heq) hm (mem_closedBall_self hρj.le), fun c hc hcy' => ?_⟩
    rw [hcq] at hc
    exact absurd ((Option.some_injective _ hc).symm.trans hcy) hcy'
  · have hcx : r[q] ≠ x := fun e => ((h.mem r[q]).mp (List.getElem_mem hq)).ne e.symm
    have hdis : ∀ T : {T : Set ℂ // F.IsOuterTile T}, r[q] ≠ T → Disjoint r[q].1 T.1 := fun T hT =>
      Set.disjoint_left.mpr fun v hvc hvT =>
        IsTile.subset_compl_closure T.2.1 r[q].2.1 (fun e => hT (Subtype.ext e)) hvc (subset_closure hvT)
    have hc1x := hdis x hcx
    have hc1y := hdis y hcy
    have hnext : z q ∈ closure r[q].1 :=
      (h.hinge q r[q] (r[(q + 1) % r.length]'(Nat.mod_lt _ hpos)) hcq (List.getElem?_eq_getElem _)).1
    have hprev : z ((q + r.length - 1) % r.length) ∈ closure r[q].1 :=
      (h.hinge _ (r[(q + r.length - 1) % r.length]'(Nat.mod_lt _ hpos)) r[q] (List.getElem?_eq_getElem _)
        (by rw [mod_succ_prev hq]; exact hcq)).2
    refine ⟨closure r[q].1, isClosed_closure, r[q].2.1.isPreconnected.closure, hprev, hnext, ?_,
      hEi.disjoint_closure_ball r[q].2.1.isOpen hc1x hc1y,
      fun hm => Set.disjoint_left.mp (hEj.disjoint_closure_ball r[q].2.1.isOpen hc1x hc1y) hm (mem_ball_self hρj),
      fun c hc _ => ?_⟩
    · rw [Set.disjoint_union_right]
      exact ⟨hc1x.closure_left x.2.1.isOpen, hc1y.closure_left y.2.1.isOpen⟩
    · rw [hcq] at hc
      rw [Option.some_injective _ hc]

/-- **SEP-CORE** (scratch copy of `IsBoundaryWalk.sep`'s body) -/
theorem IsBoundaryWalk.sep' {x : {T : Set ℂ // F.IsOuterTile T}} {r : List {T : Set ℂ // F.IsOuterTile T}} {z : ℕ → ℂ}
    {E : ℕ → Set ℂ} {p : ℕ → ℂ} {ρ : ℕ → ℝ} {edge : ℕ → Prop} (h : F.IsBoundaryWalk x r z E p ρ edge) :
    ∀ (y : {T : Set ℂ // F.IsOuterTile T}) (i j : ℕ), i < j → r[i]? = some y → r[j]? = some y → ∀ (m n : ℕ) (a b : _), i < m → m < j →
      (n < i ∨ j < n) → r[m]? = some a → r[n]? = some b → ∀ (ha : a ∈ Thomassen.offTwo x y) (hb : b ∈ Thomassen.offTwo x y),
        ¬ (F.filledGraph.induce (Thomassen.offTwo x y)).Reachable ⟨a, ha⟩ ⟨b, hb⟩ := by
  intro y i j hij hyi hyj m n a b him hmj hn ham hbn ha hb hreach
  have hilen : i < r.length := (List.getElem?_eq_some_iff.mp hyi).1
  have hjlen : j < r.length := (List.getElem?_eq_some_iff.mp hyj).1
  have hnlen : n < r.length := (List.getElem?_eq_some_iff.mp hbn).1
  have hpos : 0 < r.length := by omega
  obtain ⟨hei, hej⟩ := h.rep i j y hij.ne hyi hyj
  have hEi := h.edgeOf i y hyi hei
  have hEj := h.edgeOf j y hyj hej
  obtain ⟨-, -, -, hEid, hzi1, hzi2, -, hρi, -, hxS, hxSne, hyS, hySne, E₁, E₂, hE12, hE1c, hE1p, hE2c, hE2p, hu1, hw2, θ₁, θ₂,
    θ₃, θ₄, h12, h23, h34, h41, hθ1, hθ2, hθ3, hθ4⟩ := id hEi
  have hpj : p j ∈ E j := hEj.2.2.2.2.2.2.1
  have hρj : 0 < ρ j := hEj.2.2.2.2.2.2.2.1
  have hpjB : p j ∉ closedBall (p i) (ρ i) := fun hm =>
    Set.disjoint_left.mp (h.apart i hilen hei j hjlen hij.ne' hej) hpj hm
  have hpjEi : p j ∉ E i := fun hm =>
    Set.disjoint_left.mp (h.apart j hjlen hej i hilen hij.ne hei) hm (mem_closedBall_self hρj.le)
  -- the pieces of the positions other than `i`, `j` (SEP-PIECE), extended by the two edges of `y` at `i`, `j`
  have hpc : ∀ q, ∃ P : Set ℂ, q < r.length → q ≠ i → q ≠ j → (IsClosed P ∧ IsPreconnected P ∧
      z ((q + r.length - 1) % r.length) ∈ P ∧ z q ∈ P ∧ Disjoint P (x.1 ∪ y.1) ∧ Disjoint P (ball (p i) (ρ i)) ∧ p j ∉ P ∧
      ∀ c, r[q]? = some c → c ≠ y → closure c.1 ⊆ P) := fun q => by
    by_cases hq : q < r.length ∧ q ≠ i ∧ q ≠ j
    · obtain ⟨P, hP⟩ := h.exists_piece hij.ne hyi hyj hq.1 hq.2.1 hq.2.2
      exact ⟨P, fun _ _ _ => hP⟩
    · exact ⟨∅, fun h1 h2 h3 => absurd ⟨h1, h2, h3⟩ hq⟩
  choose P hP using hpc
  set P' : ℕ → Set ℂ := fun q => if q = i then E i else if q = j then E j else P q with hP'
  have hP'eq : ∀ q, q ≠ i → q ≠ j → P' q = P q := fun q h1 h2 => by simp only [hP', if_neg h1, if_neg h2]
  have hP'pre : ∀ q < r.length, IsPreconnected (P' q) := fun q hq => by
    by_cases h1 : q = i
    · simp only [hP', if_pos h1]; exact hEi.2.1
    by_cases h2 : q = j
    · simp only [hP', if_neg h1, if_pos h2]; exact hEj.2.1
    rw [hP'eq q h1 h2]; exact (hP q hq h1 h2).2.1
  have hP'prev : ∀ q < r.length, z ((q + r.length - 1) % r.length) ∈ P' q := fun q hq => by
    by_cases h1 : q = i
    · simp only [hP', if_pos h1]; rw [h1]; exact hzi1
    by_cases h2 : q = j
    · simp only [hP', if_neg h1, if_pos h2]; rw [h2]; exact hEj.2.2.2.2.1
    rw [hP'eq q h1 h2]; exact (hP q hq h1 h2).2.2.1
  have hP'next : ∀ q < r.length, z q ∈ P' q := fun q hq => by
    by_cases h1 : q = i
    · simp only [hP', if_pos h1]; rw [h1]; exact hzi2
    by_cases h2 : q = j
    · simp only [hP', if_neg h1, if_pos h2]; rw [h2]; exact hEj.2.2.2.2.2.1
    rw [hP'eq q h1 h2]; exact (hP q hq h1 h2).2.2.2.1
  -- the points of `K₂` lie off `x`, `y`, the open disc at `p i`, and the point `p j`
  set good : ℂ → Prop := fun w => w ∉ x.1 ∧ w ∉ y.1 ∧ w ≠ p j ∧ w ∉ ball (p i) (ρ i) with hgood
  have hPgood : ∀ l, l % r.length ≠ i → l % r.length ≠ j → ∀ w ∈ P' (l % r.length), good w := fun l h1 h2 w hw => by
    rw [hP'eq _ h1 h2] at hw
    obtain ⟨-, -, -, -, hd, hdb, hpn, -⟩ := hP _ (Nat.mod_lt _ hpos) h1 h2
    exact ⟨fun hx => Set.disjoint_left.mp hd hw (Or.inl hx), fun hy => Set.disjoint_left.mp hd hw (Or.inr hy),
      fun e => hpn (e ▸ hw), fun hb => Set.disjoint_left.mp hdb hw hb⟩
  have hPclosed : ∀ l, l % r.length ≠ i → l % r.length ≠ j → IsClosed (P' (l % r.length)) := fun l h1 h2 => by
    rw [hP'eq _ h1 h2]; exact (hP _ (Nat.mod_lt _ hpos) h1 h2).1
  -- `a`'s side: positions `i + 1 … m`; `b`'s side: positions `n …` to `i − 1`, read mod the length
  set lo := if n < i then n + r.length else n with hlo
  have hA : ∀ l ∈ Icc (i + 1) m, l % r.length ≠ i ∧ l % r.length ≠ j := fun l hl => by
    rw [mem_Icc] at hl; rw [Nat.mod_eq_of_lt (by omega : l < r.length)]; omega
  have hB : ∀ l ∈ Icc lo (i + r.length - 1), l % r.length ≠ i ∧ l % r.length ≠ j := fun l hl => by
    rw [mem_Icc, hlo] at hl
    rcases Nat.lt_or_ge l r.length with hl' | hl'
    · rw [Nat.mod_eq_of_lt hl']; split_ifs at hl <;> omega
    · rw [Nat.mod_eq_sub_mod hl', Nat.mod_eq_of_lt (by split_ifs at hl <;> omega)]; split_ifs at hl <;> omega
  have hlo_mod : lo % r.length = n := by
    simp only [hlo]; split_ifs
    · rw [Nat.add_mod_right, Nat.mod_eq_of_lt hnlen]
    · exact Nat.mod_eq_of_lt hnlen
  have hlo_le : lo ≤ i + r.length - 1 := by simp only [hlo]; split_ifs <;> omega
  -- the chain `S` in `M̂ − x − y` (SEP-S)
  obtain ⟨S, hSc, hSp, haS, hbS, hSsub⟩ := exists_isClosed_of_reachable_offTwo hreach
  have hSgood : ∀ w ∈ S, good w := fun w hw => by
    obtain ⟨v, hv, hwv⟩ := hSsub w hw
    have hvx := IsOuterTile.disjoint_closure_fill v.2.1 x.2 fun e => hv.1 (Subtype.ext e).symm
    have hvy := IsOuterTile.disjoint_closure_fill v.2.1 y.2 fun e => hv.2 (Subtype.ext e).symm
    have hox : Disjoint (fill v.1) x.1 := (hvx.mono_right subset_closure).symm
    have hoy : Disjoint (fill v.1) y.1 := (hvy.mono_right subset_closure).symm
    refine ⟨fun hx => Set.disjoint_left.mp hvx hx hwv, fun hy => Set.disjoint_left.mp hvy hy hwv, fun e => ?_,
      fun hb => Set.disjoint_left.mp (hEi.disjoint_closure_ball v.2.1.isOpen_fill hox hoy) hwv hb⟩
    exact Set.disjoint_left.mp (hEj.disjoint_closure_ball v.2.1.isOpen_fill hox hoy) (e ▸ hwv) (mem_ball_self hρj)
  set UA := ⋃ l ∈ Icc (i + 1) m, P' (l % r.length) with hUA
  set UB := ⋃ l ∈ Icc lo (i + r.length - 1), P' (l % r.length) with hUB
  have hUAp : IsPreconnected UA := isPreconnected_biUnion_Icc_mod hpos hP'pre hP'prev hP'next _ _
  have hUBp : IsPreconnected UB := isPreconnected_biUnion_Icc_mod hpos hP'pre hP'prev hP'next _ _
  have hUAgood : ∀ w ∈ UA, good w := fun w hw => by
    simp only [hUA, mem_iUnion] at hw
    obtain ⟨l, hl, hw⟩ := hw
    exact hPgood l (hA l hl).1 (hA l hl).2 w hw
  have hUBgood : ∀ w ∈ UB, good w := fun w hw => by
    simp only [hUB, mem_iUnion] at hw
    obtain ⟨l, hl, hw⟩ := hw
    exact hPgood l (hB l hl).1 (hB l hl).2 w hw
  have hUAc : IsClosed UA := (finite_Icc _ _).isClosed_biUnion fun l hl => hPclosed l (hA l hl).1 (hA l hl).2
  have hUBc : IsClosed UB := (finite_Icc _ _).isClosed_biUnion fun l hl => hPclosed l (hB l hl).1 (hB l hl).2
  -- the joints of `K₂`
  have hziA : z i ∈ UA := by
    refine mem_biUnion (x := i + 1) ⟨le_rfl, him⟩ ?_
    have := hP'prev _ (Nat.mod_lt (i + 1) hpos)
    rwa [mod_prev_succ hpos, Nat.mod_eq_of_lt hilen] at this
  have hmA : closure a.1 ⊆ UA := by
    refine (subset_biUnion_of_mem (u := fun l => P' (l % r.length)) (⟨him, le_rfl⟩ : m ∈ Icc (i + 1) m)).trans' ?_
    have hm' : m % r.length = m := Nat.mod_eq_of_lt (by omega)
    show closure a.1 ⊆ P' (m % r.length)
    rw [hm', hP'eq m (by omega) (by omega)]
    exact (hP m (by omega) (by omega) (by omega)).2.2.2.2.2.2.2 a ham ha.2
  have hnB : closure b.1 ⊆ UB := by
    refine (subset_biUnion_of_mem (u := fun l => P' (l % r.length)) (⟨le_rfl, hlo_le⟩ : lo ∈ Icc lo (i + r.length - 1))).trans' ?_
    show closure b.1 ⊆ P' (lo % r.length)
    have hni : n ≠ i := by omega
    have hnj : n ≠ j := by omega
    rw [hlo_mod, hP'eq n hni hnj]
    exact (hP n hnlen hni hnj).2.2.2.2.2.2.2 b hbn hb.2
  have hziB : z ((i + r.length - 1) % r.length) ∈ UB :=
    mem_biUnion (x := i + r.length - 1) ⟨hlo_le, le_rfl⟩ (hP'next _ (Nat.mod_lt _ hpos))
  have haS' : closure a.1 ⊆ S := (closure_mono (subset_fill _)).trans haS
  have hbS' : closure b.1 ⊆ S := (closure_mono (subset_fill _)).trans hbS
  obtain ⟨pa, hpa⟩ := a.2.1.nonempty
  obtain ⟨pb, hpb⟩ := b.2.1.nonempty
  set K₂ := (((E₂ ∪ UA) ∪ S) ∪ UB) ∪ E₁ with hK₂
  have hK₂p : IsPreconnected K₂ :=
    ((((hE2p.union (z i) hw2 hziA hUAp).union pa (Or.inr (hmA (subset_closure hpa))) (haS' (subset_closure hpa)) hSp).union pb
      (Or.inr (hbS' (subset_closure hpb))) (hnB (subset_closure hpb)) hUBp).union _ (Or.inr hziB) hu1 hE1p)
  have hK₂c : IsClosed K₂ := (((hE2c.union hUAc).union hSc).union hUBc).union hE1c
  have hEgood : ∀ w ∈ E₁ ∪ E₂, good w := fun w hw => by
    rw [← hE12] at hw
    exact ⟨fun hx => Set.disjoint_left.mp hEid hw.1 (Or.inl hx), fun hy => Set.disjoint_left.mp hEid hw.1 (Or.inr hy),
      fun e => hpjEi (e ▸ hw.1), hw.2⟩
  have hK₂good : ∀ w ∈ K₂, good w := by
    rintro w ((((hw | hw) | hw) | hw) | hw)
    · exact hEgood w (Or.inr hw)
    · exact hUAgood w hw
    · exact hSgood w hw
    · exact hUBgood w hw
    · exact hEgood w (Or.inl hw)
  -- `K₁`: `x` and `y` off the disc, joined at `p j` (SEP-K1)
  set K₁ := insert (p j) (x.1 \ ball (p i) (ρ i)) ∪ insert (p j) (y.1 \ ball (p i) (ρ i)) with hK₁
  have hK₁p : IsPreconnected K₁ := isPreconnected_union_insert_diff_ball x.2.1.isPreconnected y.2.1.isPreconnected hxS hxSne hyS
    hySne (hEj.2.2.1 hpj).1 (hEj.2.2.1 hpj).2 hpjB
  have hpjb : p j ∉ ball (p i) (ρ i) := fun hm => hpjB (ball_subset_closedBall hm)
  have hK₁d : K₁ ⊆ (ball (p i) (ρ i))ᶜ := by
    rintro w ((rfl | hw) | (rfl | hw))
    · exact hpjb
    · exact hw.2
    · exact hpjb
    · exact hw.2
  have hsph : ∀ θ, polarPt (p i) (ρ i) θ ∉ ball (p i) (ρ i) := fun θ hm => by
    rw [mem_ball, dist_eq_norm, norm_polarPt_sub, abs_of_pos hρi] at hm; exact lt_irrefl _ hm
  have hK₁θ : ∀ θ, polarPt (p i) (ρ i) θ ∈ x.1 ∪ y.1 → polarPt (p i) (ρ i) θ ∈ K₁ := fun θ hθ => by
    rcases hθ with hθ | hθ
    · exact Or.inl (Or.inr ⟨hθ, hsph θ⟩)
    · exact Or.inr (Or.inr ⟨hθ, hsph θ⟩)
  obtain ⟨w, hw₂, hw₁⟩ := inter_nonempty_of_interleaved_exterior_of_isClosed hρi hK₂c hK₂p hK₁p
    (fun w hw => (hK₂good w hw).2.2.2) hK₁d h12 h23 h34 h41 (Or.inr hθ1) (Or.inl (Or.inl (Or.inl (Or.inl hθ3))))
    (hK₁θ θ₂ hθ2) (hK₁θ θ₄ hθ4)
  obtain ⟨hwx, hwy, hwp, -⟩ := hK₂good w hw₂
  rcases hw₁ with (e | hw) | (e | hw)
  · exact hwp e
  · exact hwx hw.1
  · exact hwp e
  · exact hwy hw.1

end ArcMap

end HadwigerNelson.Plane
