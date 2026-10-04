import Proofs.HadwigerNelson.Plane.SVMap
import Proofs.HadwigerNelson.Plane.ValidMap.MapTopology
import Mathlib.Combinatorics.SimpleGraph.Paths
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Connected
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Subgraph
import Mathlib.Combinatorics.SimpleGraph.Metric
import Mathlib.Combinatorics.Enumerative.DoubleCounting

/-!
# Thomassen's steps on valid maps: the map graph, filled holes, 2-separators, the reduced graph `H`, and Lemma 1

Wave 5's skeleton (`plans/FS131-w5-kernel-plan.md` § 8) for **FS114-CVB-THOM** with **FS114-CVB-PINCH** (`plans/FS114-CVB-verification.md`
§ 1.9, B1–B2): `[Thomassen1999]`'s steps other than the rainbow step hold for every valid map, Siamese pairs allowed — fill holes, read facial
cycles as boundary walks, replace the count in `int(R)` by local finiteness — and the reduced map graph `H` has a vertex of degree at least `6`.

**Pure graph theory** (namespace `HadwigerNelson.Thomassen`, over Mathlib's `SimpleGraph`):

* `LocallyHamiltonian G` — `[Thomassen1999]` p. 850: "for each `x` in `V(G)`, `G` has a cycle with vertex set `D₁(x)`";
* `lemma1` — Thomassen's Lemma 1 (p. 850): a connected, locally finite, locally Hamiltonian graph with at least `13` vertices has a vertex of
  degree at least `6`. **Formalized here** (a page of counting over the distance layers `D₁, …, D₄`), not imported;
* `twoSepInterior G x y` — CVB's `int(M, x, y)` (B2 step 2): the vertices of the finite components of `G − x − y`; `IsTwoSep`,
  `IsMaximalTwoSep` (Thomassen p. 852: "no 2-separator `{u, v}` with `x` or `y` in `int(M, u, v)`"); `reducedVerts`, `reduced` — `H`, the graph
  with every maximal 2-separator's interior deleted.

**On a map** (`ArcMap`): `mapGraph` (tiles, adjacent when their closures meet), `IsHoleOf` (a nonempty bounded part of the complement of a tile's
closure separated from the rest of it — "a boundary component of `x` disjoint from its outer one", read through the closure; FS131-KP), `fill` (a tile with its holes),
`IsOuterTile` (a tile inside no hole of another tile), `filledGraph` (the filled map's graph: outer tiles, adjacent when their filled closures
meet).

Rows: `cvb_thom_reduced` (B2 steps 1–3: `H` connected, locally finite, locally Hamiltonian, infinite), `cvb_thom` (B2 step 4: a vertex of
`H`-degree at least `6`), `cvb_pinch_connected` and `cvb_hole_disconnected` (B1), `exists_holed_valid_fragment` (B1's "holes are locally
consistent with validity"). Not claimed (the row's own line): the rainbow step on valid maps; the 2-separator criterion at pinches as more
than a sketch.
-/

namespace HadwigerNelson.Thomassen

variable {V : Type*} (G : SimpleGraph V)

/-- **Locally Hamiltonian** (`[Thomassen1999]` p. 850): for each vertex `x`, `G` has a cycle whose vertex set is the neighbourhood
`D₁(x)`. -/
def LocallyHamiltonian : Prop :=
  ∀ x, ∃ (a : V) (p : G.Walk a a), p.IsCycle ∧ ∀ y, y ∈ p.support ↔ G.Adj x y

/-- The vertices other than `x` and `y`. -/
def offTwo (x y : V) : Set V := {v | v ≠ x ∧ v ≠ y}

/-- **`int(G, x, y)`** (CVB B2 step 2, in place of Thomassen's curve `R`): the vertices of the finite connected components of `G − x − y`. -/
def twoSepInterior (x y : V) : Set V :=
  {v | ∃ hv : v ∈ offTwo x y, ((G.induce (offTwo x y)).connectedComponentMk ⟨v, hv⟩).supp.Finite}

/-- **A 2-separator** `{x, y}`: two distinct vertices whose removal leaves a finite component. -/
def IsTwoSep (x y : V) : Prop := x ≠ y ∧ (twoSepInterior G x y).Nonempty

/-- **A maximal 2-separator** (`[Thomassen1999]` p. 852): a 2-separator `{x, y}` such that no 2-separator `{u, v}` has `x` or `y` in its
interior. -/
def IsMaximalTwoSep (x y : V) : Prop :=
  IsTwoSep G x y ∧ ∀ u v, IsTwoSep G u v → x ∉ twoSepInterior G u v ∧ y ∉ twoSepInterior G u v

/-- The vertices of **`H`**: those in the interior of no maximal 2-separator. -/
def reducedVerts : Set V := {v | ∀ x y, IsMaximalTwoSep G x y → v ∉ twoSepInterior G x y}

/-- **`H`** (`[Thomassen1999]` p. 852): `G` with the interior of every maximal 2-separator deleted. -/
def reduced : SimpleGraph (reducedVerts G) := G.induce (reducedVerts G)

/-- **A ring at `x`** (the combinatorial shadow of `x`'s boundary walk, CVB B2 step 2 over `[Thomassen1999]` p. 851; FS131-KP plan § 4): a list
`r` whose entries are exactly `x`'s neighbours, cyclically consecutive entries equal or adjacent, and in which any two appearances of a vertex
`y` separate: an entry strictly between them and one strictly outside, both other than `y`, lie in different components of `G − x − y`.
(The planar ring lists each repeated neighbour only at its edge contacts — Thomassen's rule — since at a vertex contact the tiles on both
sides are adjacent and the separation fails.) -/
def IsRing (x : V) (r : List V) : Prop :=
  (∀ y, y ∈ r ↔ G.Adj x y) ∧ (∀ (i : ℕ) (a b : V), r[i]? = some a → r[(i + 1) % r.length]? = some b → a = b ∨ G.Adj a b) ∧
    ∀ (y : V) (i j : ℕ), i < j → r[i]? = some y → r[j]? = some y → ∀ (m n : ℕ) (a b : V), i < m → m < j → (n < i ∨ j < n) →
      r[m]? = some a → r[n]? = some b → ∀ (ha : a ∈ offTwo x y) (hb : b ∈ offTwo x y),
        ¬ (G.induce (offTwo x y)).Reachable ⟨a, ha⟩ ⟨b, hb⟩

/-- `y` appears at two positions of `r` that are not cyclically consecutive (`[Thomassen1999]` p. 851: "`y = xᵢ = xⱼ` for `1 ≤ i < j − 1 <
k − 1`"). -/
def TwiceApart (r : List V) (y : V) : Prop :=
  ∃ i j : ℕ, i + 1 < j ∧ ¬ (i = 0 ∧ j + 1 = r.length) ∧ r[i]? = some y ∧ r[j]? = some y

/-- **The planar properties Thomassen's reduction reads** (FS131-KP plan § 4; CVB B2 steps 1–3): locally finite, connected, infinite; a ring
at every vertex, with `G − x − y` connected unless `y` appears twice apart in `x`'s ring; and for every pair exactly one infinite component of
`G − x − y` (CVB step 2: "the complement of the compact connected `cl x̂ ∪ cl ŷ` has one unbounded component and every other component of
`M − x − y` is finite"). The filled map graph of a valid plane map has them (`ArcMap.filledGraph_planarLike`); the reduction is
`reduced_props_of_planarLike`. -/
structure PlanarLike : Prop where
  /-- Locally finite. -/
  locFin : ∀ x, (G.neighborSet x).Finite
  /-- Connected. -/
  conn : G.Connected
  /-- Infinite. -/
  inf : Infinite V
  /-- A ring at every vertex, `G − x − y` connected unless `y` appears twice apart. -/
  ring : ∀ x, ∃ r, IsRing G x r ∧ ∀ y, y ≠ x → ¬ TwiceApart r y → (G.induce (offTwo x y)).Connected
  /-- Exactly one infinite component of `G − x − y`. -/
  oneInf : ∀ x y, x ≠ y → ∃ c : (G.induce (offTwo x y)).ConnectedComponent, ¬ c.supp.Finite ∧ ∀ c', ¬ c'.supp.Finite → c' = c

/-- **Thomassen's reduction, as pure graph theory** (`[Thomassen1999]` pp. 851–852 with CVB B2 step 3's replacement of the count by
finiteness): for a graph with the planar properties, `H = reduced G` is connected, locally finite, locally Hamiltonian and infinite. The
proof (plan § 4, leaf T-GRAPH): 2-separators are pairs with finite components; interiors nest (Thomassen: "`int(M, x, y) ⊆ int(M, u, v)`" when
`x` or `y` lies in `int(M, u, v)`, from the rings' separation); a maximal 2-separator exists above every 2-separator (a strictly increasing
chain of finite interiors containing a fixed vertex's neighbourhood is finite, by local finiteness and `oneInf`); `H` connected (a shortest
path never enters an interior), locally finite (an induced subgraph); locally Hamiltonian (delete from `x`'s ring the vertices in interiors
of 2-separators through `x`; the reduced cyclic sequence has no repetition and at least three entries, else `G` is finite by `oneInf`); infinite
(every interior is finite and the maximal 2-separators' crucial edges are locally finite in number). -/
theorem reduced_props_of_planarLike (h : PlanarLike G) :
    (reduced G).Connected ∧ (∀ x, ((reduced G).neighborSet x).Finite) ∧ LocallyHamiltonian (reduced G) ∧ Infinite (reducedVerts G) := by
  sorry

/-! ## Lemma 1's two local facts, and the discrete intermediate value theorem they share -/

section Lemma1

variable {G}

/-- (C): in a locally Hamiltonian graph every edge `y w` has two distinct common neighbours. -/
theorem LocallyHamiltonian.exists_two_common (hH : LocallyHamiltonian G) {y w : V} (hyw : G.Adj y w) :
    ∃ c₁ c₂, c₁ ≠ c₂ ∧ G.Adj y c₁ ∧ G.Adj w c₁ ∧ G.Adj y c₂ ∧ G.Adj w c₂ := by
  obtain ⟨a, p, hp, hsupp⟩ := hH y
  have hw : w ∈ p.support := (hsupp w).mpr hyw
  have h2 := SimpleGraph.Walk.IsCycle.ncard_neighborSet_toSubgraph_eq_two hp hw
  obtain ⟨c₁, c₂, hne, heq⟩ := Set.ncard_eq_two.mp h2
  have hmem : ∀ c ∈ p.toSubgraph.neighborSet w, G.Adj y c ∧ G.Adj w c := by
    intro c hc
    have hadj : p.toSubgraph.Adj w c := hc
    exact ⟨(hsupp c).mp (p.mem_support_of_adj_toSubgraph hadj.symm), hadj.adj_sub⟩
  have h1 := hmem c₁ (by rw [heq]; simp)
  have h2 := hmem c₂ (by rw [heq]; simp)
  exact ⟨c₁, c₂, hne, h1.1, h1.2, h2.1, h2.2⟩

/-- A discrete intermediate value theorem, upward: an integer sequence whose steps rise by at most `1`, below `n` at `i` and above it at
`j > i`, takes the value `n` strictly between. -/
theorem exists_eq_of_steps_up (g : ℕ → ℤ) (n : ℤ) {i j : ℕ} (hij : i < j)
    (hstep : ∀ k, i ≤ k → k < j → g (k + 1) ≤ g k + 1) (hi : g i < n) (hj : n < g j) :
    ∃ k, i < k ∧ k < j ∧ g k = n := by
  revert hstep hj
  induction j, hij using Nat.le_induction with
  | base =>
    intro hstep hj
    have := hstep i le_rfl (Nat.lt_succ_self i)
    simp only [Nat.succ_eq_add_one] at *
    omega
  | succ j hij' ih =>
    intro hstep hj
    rcases lt_trichotomy (g j) n with h | h | h
    · have := hstep j (by omega) (Nat.lt_succ_self j); omega
    · exact ⟨j, by omega, Nat.lt_succ_self j, h⟩
    · obtain ⟨k, hk1, hk2, hk3⟩ := ih (fun k hk hk' => hstep k hk (Nat.lt_succ_of_lt hk')) h
      exact ⟨k, hk1, Nat.lt_succ_of_lt hk2, hk3⟩

/-- The discrete intermediate value theorem, both ways: steps of size at most `1`, strictly on opposite sides of `n` at `i < j`. -/
theorem exists_eq_of_steps (g : ℕ → ℤ) (n : ℤ) {i j : ℕ} (hij : i < j)
    (hstep : ∀ k, i ≤ k → k < j → g (k + 1) ≤ g k + 1 ∧ g k ≤ g (k + 1) + 1)
    (hside : (g i < n ∧ n < g j) ∨ (n < g i ∧ g j < n)) : ∃ k, i < k ∧ k < j ∧ g k = n := by
  rcases hside with ⟨h1, h2⟩ | ⟨h1, h2⟩
  · exact exists_eq_of_steps_up g n hij (fun k hk hk' => (hstep k hk hk').1) h1 h2
  · obtain ⟨k, hk1, hk2, hk3⟩ := exists_eq_of_steps_up (fun k => -g k) (-n) hij
      (fun k hk hk' => by have := (hstep k hk hk').2; omega) (by omega) (by omega)
    exact ⟨k, hk1, hk2, by omega⟩

/-- (L): in a locally Hamiltonian graph, a vertex `v` with neighbours at levels `m` and `m + 2` from `x` has two distinct neighbours at
level `m + 1` (its neighbourhood cycle passes from level `m` to `m + 2` and back, and each passage crosses level `m + 1`). -/
theorem LocallyHamiltonian.two_mid (hH : LocallyHamiltonian G) (x : V) {v u w : V} (hu : G.Adj v u) (hw : G.Adj v w)
    (huw : G.dist x u + 2 = G.dist x w) :
    ∃ m₁ m₂, m₁ ≠ m₂ ∧ G.Adj v m₁ ∧ G.Adj v m₂ ∧ G.dist x m₁ = G.dist x u + 1 ∧ G.dist x m₂ = G.dist x u + 1 := by
  obtain ⟨a, p, hp, hsupp⟩ := hH v
  have hL := hp.three_le_length
  set L := p.length with hLdef
  set f : ℕ → ℤ := fun i => (G.dist x (p.getVert i) : ℤ) with hf
  set n' : ℤ := (G.dist x u : ℤ) + 1 with hn'
  -- positions below `L`
  have hpos : ∀ z, G.Adj v z → ∃ i, i < L ∧ p.getVert i = z := by
    intro z hz
    obtain ⟨i, hi, hiL⟩ := SimpleGraph.Walk.mem_support_iff_exists_getVert.mp ((hsupp z).mpr hz)
    rcases lt_or_eq_of_le hiL with h | h
    · exact ⟨i, h, hi⟩
    · refine ⟨0, by omega, ?_⟩
      rw [SimpleGraph.Walk.getVert_zero, ← hi, h, SimpleGraph.Walk.getVert_length]
  obtain ⟨i₀, hi₀, hui⟩ := hpos u hu
  obtain ⟨j₀, hj₀, hwj⟩ := hpos w hw
  have hfi : f i₀ = n' - 1 := by simp only [hf, hn', hui]; omega
  have hfj : f j₀ = n' + 1 := by simp only [hf, hn', hwj]; omega
  have hfL : f L = f 0 := by simp only [hf, hLdef, SimpleGraph.Walk.getVert_length, SimpleGraph.Walk.getVert_zero]
  have hstep : ∀ k, k < L → f (k + 1) ≤ f k + 1 ∧ f k ≤ f (k + 1) + 1 := by
    intro k hk
    have hadj := p.adj_getVert_succ hk
    rcases hadj.diff_dist_adj (u := x) with h | h | h <;> simp only [hf] <;> omega
  have hmid : ∀ k, f k = n' → G.Adj v (p.getVert k) ∧ G.dist x (p.getVert k) = G.dist x u + 1 := by
    intro k hk
    refine ⟨(hsupp _).mp (p.getVert_mem_support k), ?_⟩
    simp only [hf, hn'] at hk; omega
  have hinj : ∀ k₁ k₂, k₁ < L → k₂ < L → k₁ ≠ k₂ → p.getVert k₁ ≠ p.getVert k₂ := by
    intro k₁ k₂ h₁ h₂ hne heq
    exact hne (hp.getVert_injOn' (show k₁ ≤ p.length - 1 by omega) (show k₂ ≤ p.length - 1 by omega) heq)
  have hne₀ : i₀ ≠ j₀ := by intro h; rw [h] at hfi; omega
  -- the first crossing, between the two positions
  set lo := min i₀ j₀
  set hi := max i₀ j₀
  have hlohi : lo < hi := by omega
  have hflo : f lo ≠ n' := by
    rcases le_total i₀ j₀ with h | h
    · rw [show lo = i₀ from min_eq_left h]; omega
    · rw [show lo = j₀ from min_eq_right h]; omega
  have hfhi : f hi ≠ n' := by
    rcases le_total i₀ j₀ with h | h
    · rw [show hi = j₀ from max_eq_right h]; omega
    · rw [show hi = i₀ from max_eq_left h]; omega
  have hopp : (f lo < n' ∧ n' < f hi) ∨ (n' < f lo ∧ f hi < n') := by
    rcases le_total i₀ j₀ with h | h
    · rw [show lo = i₀ from min_eq_left h, show hi = j₀ from max_eq_right h]; omega
    · rw [show lo = j₀ from min_eq_right h, show hi = i₀ from max_eq_left h]; omega
  have hhiL : hi < L := by omega
  obtain ⟨k₁, hk₁, hk₁', hfk₁⟩ := exists_eq_of_steps f n' hlohi (fun k _ hk => hstep k (by omega)) hopp
  -- the second crossing, on the other arc
  obtain ⟨k₂, hk₂L, hk₂ne, hfk₂⟩ : ∃ k₂, k₂ < L ∧ k₂ ≠ k₁ ∧ f k₂ = n' := by
    rcases lt_trichotomy (f 0) n' with h0 | h0 | h0
    · rcases hopp with ⟨h1, h2⟩ | ⟨h1, h2⟩
      · -- `f hi > n' > f L`: a crossing in `(hi, L)`
        obtain ⟨k, hk, hk', hfk⟩ := exists_eq_of_steps f n' hhiL (fun k _ hk => hstep k hk) (Or.inr ⟨h2, by rw [hfL]; exact h0⟩)
        exact ⟨k, hk', by omega, hfk⟩
      · -- `f 0 < n' < f lo`: a crossing in `(0, lo)`
        have hlo0 : 0 < lo := by
          rcases Nat.eq_zero_or_pos lo with h | h
          · rw [h] at h1; omega
          · exact h
        obtain ⟨k, hk, hk', hfk⟩ := exists_eq_of_steps f n' hlo0 (fun k _ hk => hstep k (by omega)) (Or.inl ⟨h0, h1⟩)
        exact ⟨k, by omega, by omega, hfk⟩
    · have hlo0 : 0 < lo := by
        rcases Nat.eq_zero_or_pos lo with h | h
        · rw [h] at hflo; exact absurd h0 hflo
        · exact h
      exact ⟨0, by omega, by omega, h0⟩
    · rcases hopp with ⟨h1, h2⟩ | ⟨h1, h2⟩
      · have hlo0 : 0 < lo := by
          rcases Nat.eq_zero_or_pos lo with h | h
          · rw [h] at h1; omega
          · exact h
        obtain ⟨k, hk, hk', hfk⟩ := exists_eq_of_steps f n' hlo0 (fun k _ hk => hstep k (by omega)) (Or.inr ⟨h0, h1⟩)
        exact ⟨k, by omega, by omega, hfk⟩
      · obtain ⟨k, hk, hk', hfk⟩ := exists_eq_of_steps f n' hhiL (fun k _ hk => hstep k hk) (Or.inl ⟨h2, by rw [hfL]; exact h0⟩)
        exact ⟨k, hk', by omega, hfk⟩
  obtain ⟨ha₁, hd₁⟩ := hmid k₁ hfk₁
  obtain ⟨ha₂, hd₂⟩ := hmid k₂ hfk₂
  exact ⟨_, _, hinj k₁ k₂ (by omega) hk₂L hk₂ne.symm, ha₁, ha₂, hd₁, hd₂⟩

end Lemma1

/-- **Thomassen's Lemma 1** (`[Thomassen1999]` p. 850): a connected, locally finite, locally Hamiltonian graph with at least `13` vertices
has a vertex of degree at least `6`. Pure graph theory, formalized here (the planner's decision, plan § 8.3: under the hour-of-agent-work
line, and "when unsure, formalize"). Model of the hypotheses: the triangular lattice (`triLattice`, infinite, every neighbourhood a
hexagon). -/
theorem lemma1 (hfin : ∀ x, (G.neighborSet x).Finite) (hc : G.Connected) (hH : LocallyHamiltonian G)
    (h13 : 13 ≤ ENat.card V) : ∃ x, 6 ≤ (G.neighborSet x).encard := by
  classical
  by_contra hno
  push Not at hno
  -- every degree is at most `5`
  have hdeg : ∀ v, (G.neighborSet v).ncard ≤ 5 := by
    intro v
    have h := hno v
    rw [← (hfin v).cast_ncard_eq] at h
    have : (G.neighborSet v).ncard < 6 := by exact_mod_cast h
    omega
  obtain ⟨x⟩ := hc.nonempty
  -- the levels from `x`
  have hlevadj : ∀ {a b : V}, G.Adj a b → G.dist x b ≤ G.dist x a + 1 ∧ G.dist x a ≤ G.dist x b + 1 := by
    intro a b hab
    rcases hab.diff_dist_adj (u := x) with h | h | h <;> omega
  have hdown : ∀ (n : ℕ) (v : V), G.dist x v = n + 1 → ∃ u, G.Adj u v ∧ G.dist x u = n := by
    intro n v hv
    obtain ⟨q, hq⟩ := hc.exists_walk_length_eq_dist x v
    have hlt : n < q.length := by omega
    have hadj := q.adj_getVert_succ hlt
    rw [show n + 1 = q.length by omega, SimpleGraph.Walk.getVert_length] at hadj
    refine ⟨_, hadj, le_antisymm ?_ ?_⟩
    · have := SimpleGraph.dist_le (q.take n)
      rw [SimpleGraph.Walk.take_length] at this
      exact this.trans (min_le_left _ _)
    · have := (hlevadj hadj).1; omega
  have hzero : ∀ v, G.dist x v = 0 ↔ v = x := fun v => by
    rw [hc.dist_eq_zero_iff]; exact eq_comm
  have hone : ∀ v, G.dist x v = 1 ↔ G.Adj x v := fun v => SimpleGraph.dist_eq_one_iff_adj
  -- finiteness of the levels
  have hDfin : ∀ n, {v | G.dist x v = n}.Finite := by
    intro n
    induction n with
    | zero => exact (Set.finite_singleton x).subset fun v hv => (hzero v).mp hv
    | succ n ih =>
      refine (ih.biUnion fun u _ => hfin u).subset ?_
      intro v hv
      obtain ⟨u, hu, hun⟩ := hdown n v hv
      exact Set.mem_biUnion hun hu
  set D : ℕ → Finset V := fun n => (hDfin n).toFinset with hD
  have hmemD : ∀ n v, v ∈ D n ↔ G.dist x v = n := fun n v => by simp [hD]
  set Nf : V → Finset V := fun v => (hfin v).toFinset with hNf
  have hmemN : ∀ v z, z ∈ Nf v ↔ G.Adj v z := fun v z => by simp [hNf]
  have hNcard : ∀ v, (Nf v).card ≤ 5 := fun v => by
    rw [← Set.ncard_eq_toFinset_card _ (hfin v)]; exact hdeg v
  set lev : V → ℕ → Finset V := fun v n => (Nf v).filter (fun z => G.dist x z = n) with hlev
  have hmemlev : ∀ v n z, z ∈ lev v n ↔ G.Adj v z ∧ G.dist x z = n := fun v n z => by
    simp only [hlev, Finset.mem_filter, hmemN]
  have hlev3 : ∀ v a b c, a ≠ b → a ≠ c → b ≠ c → (lev v a).card + (lev v b).card + (lev v c).card ≤ 5 := by
    intro v a b c hab hac hbc
    have d1 : Disjoint (lev v a) (lev v b) := Finset.disjoint_left.mpr fun z h1 h2 =>
      hab (((hmemlev v a z).mp h1).2.symm.trans ((hmemlev v b z).mp h2).2)
    have d2 : Disjoint (lev v a ∪ lev v b) (lev v c) := Finset.disjoint_left.mpr fun z h1 h2 => by
      rcases Finset.mem_union.mp h1 with h1 | h1
      · exact hac (((hmemlev v a z).mp h1).2.symm.trans ((hmemlev v c z).mp h2).2)
      · exact hbc (((hmemlev v b z).mp h1).2.symm.trans ((hmemlev v c z).mp h2).2)
    have hsub : lev v a ∪ lev v b ∪ lev v c ⊆ Nf v := by
      intro z hz
      simp only [Finset.mem_union] at hz
      rcases hz with (h | h) | h <;> exact Finset.filter_subset _ _ h
    have := Finset.card_le_card hsub
    rw [Finset.card_union_of_disjoint d2, Finset.card_union_of_disjoint d1] at this
    exact this.trans (hNcard v)
  have htwo : ∀ (v : V) (n : ℕ) (a b : V), a ≠ b → G.Adj v a → G.Adj v b → G.dist x a = n → G.dist x b = n →
      2 ≤ (lev v n).card := by
    intro v n a b hab ha hb hna hnb
    have : ({a, b} : Finset V) ⊆ lev v n := by
      intro z hz
      simp only [Finset.mem_insert, Finset.mem_singleton] at hz
      rcases hz with rfl | rfl
      · exact (hmemlev v n z).mpr ⟨ha, hna⟩
      · exact (hmemlev v n z).mpr ⟨hb, hnb⟩
    have h2 := Finset.card_le_card this
    rwa [Finset.card_pair hab] at h2
  -- (S1) a vertex of level `1` has at most two neighbours at level `2`
  have hS1 : ∀ y, G.dist x y = 1 → (lev y 2).card ≤ 2 := by
    intro y hy
    have hxy : G.Adj x y := (hone y).mp hy
    obtain ⟨c₁, c₂, hne, h1, h1', h2, h2'⟩ := hH.exists_two_common hxy
    have hl1 := htwo y 1 c₁ c₂ hne h1' h2' ((hone c₁).mpr h1) ((hone c₂).mpr h2)
    have hl0 : 1 ≤ (lev y 0).card := Finset.card_pos.mpr ⟨x, (hmemlev y 0 x).mpr ⟨hxy.symm, (hzero x).mpr rfl⟩⟩
    have := hlev3 y 0 1 2 (by norm_num) (by norm_num) (by norm_num)
    omega
  -- (S2) a vertex of level `2` has at least two neighbours at level `1`
  have hS2 : ∀ z, G.dist x z = 2 → 2 ≤ (lev z 1).card := by
    intro z hz
    obtain ⟨y, hyz, hy⟩ := hdown 1 z hz
    obtain ⟨c₁, c₂, hne, h1, h1', h2, h2'⟩ := hH.exists_two_common hyz
    have hlv : ∀ c, G.Adj y c → G.Adj z c → G.dist x c = 1 ∨ G.dist x c = 2 := by
      intro c hyc hzc
      have := hlevadj hyc; have := hlevadj hzc; omega
    by_cases hc : G.dist x c₁ = 1 ∨ G.dist x c₂ = 1
    · rcases hc with hc | hc
      · exact htwo z 1 y c₁ (fun h => (h ▸ h1).ne rfl) hyz.symm h1' hy hc
      · exact htwo z 1 y c₂ (fun h => (h ▸ h2).ne rfl) hyz.symm h2' hy hc
    · exfalso
      push Not at hc
      have hd1 : G.dist x c₁ = 2 := (hlv c₁ h1 h1').resolve_left hc.1
      have hd2 : G.dist x c₂ = 2 := (hlv c₂ h2 h2').resolve_left hc.2
      have : ({z, c₁, c₂} : Finset V) ⊆ lev y 2 := by
        intro t ht
        simp only [Finset.mem_insert, Finset.mem_singleton] at ht
        rcases ht with rfl | rfl | rfl
        · exact (hmemlev y 2 t).mpr ⟨hyz, hz⟩
        · exact (hmemlev y 2 t).mpr ⟨h1, hd1⟩
        · exact (hmemlev y 2 t).mpr ⟨h2, hd2⟩
      have h3 := Finset.card_le_card this
      rw [Finset.card_insert_of_notMem (by
          simp only [Finset.mem_insert, Finset.mem_singleton, not_or]
          exact ⟨fun h => (h ▸ h1').ne rfl, fun h => (h ▸ h2').ne rfl⟩),
        Finset.card_pair hne] at h3
      have := hS1 y hy
      omega
  -- (S3) a vertex of level `2` has at most one neighbour at level `3`
  have hS3 : ∀ z, G.dist x z = 2 → (lev z 3).card ≤ 1 := by
    intro z hz
    by_contra h
    push Not at h
    obtain ⟨w, hw⟩ := Finset.card_pos.mp (by omega : 0 < (lev z 3).card)
    obtain ⟨hzw, hw3⟩ := (hmemlev z 3 w).mp hw
    obtain ⟨u, huz, hu⟩ := hdown 1 z hz
    obtain ⟨m₁, m₂, hne, hm₁, hm₂, hd₁, hd₂⟩ := hH.two_mid x huz.symm hzw (by omega)
    have hl2 := htwo z 2 m₁ m₂ hne hm₁ hm₂ (by omega) (by omega)
    have hl1 := hS2 z hz
    have := hlev3 z 1 2 3 (by norm_num) (by norm_num) (by norm_num)
    omega
  -- (S4) a vertex of level `3` has at least three neighbours at level `2`
  have hS4 : ∀ w, G.dist x w = 3 → 3 ≤ (lev w 2).card := by
    intro w hw
    obtain ⟨z, hzw, hz⟩ := hdown 2 w hw
    obtain ⟨c₁, c₂, hne, h1, h1', h2, h2'⟩ := hH.exists_two_common hzw
    have hlv : ∀ c, G.Adj z c → G.Adj w c → c ≠ w → G.dist x c = 2 := by
      intro c hzc hwc hcw
      have := hlevadj hzc; have := hlevadj hwc
      by_contra h2c
      have hc3 : G.dist x c = 3 := by omega
      have := htwo z 3 w c (Ne.symm hcw) hzw hzc hw hc3
      have := hS3 z hz
      omega
    have hd1 := hlv c₁ h1 h1' (fun h => (h ▸ h1').ne rfl)
    have hd2 := hlv c₂ h2 h2' (fun h => (h ▸ h2').ne rfl)
    have : ({z, c₁, c₂} : Finset V) ⊆ lev w 2 := by
      intro t ht
      simp only [Finset.mem_insert, Finset.mem_singleton] at ht
      rcases ht with rfl | rfl | rfl
      · exact (hmemlev w 2 t).mpr ⟨hzw.symm, hz⟩
      · exact (hmemlev w 2 t).mpr ⟨h1', hd1⟩
      · exact (hmemlev w 2 t).mpr ⟨h2', hd2⟩
    have h3 := Finset.card_le_card this
    rwa [Finset.card_insert_of_notMem (by
        simp only [Finset.mem_insert, Finset.mem_singleton, not_or]
        exact ⟨fun h => (h ▸ h1).ne rfl, fun h => (h ▸ h2).ne rfl⟩),
      Finset.card_pair hne] at h3
  -- the level sizes
  have hfilt : ∀ (s : Finset V) (n : ℕ) (a : V), s = D n → s.filter (G.Adj a) = lev a n := by
    intro s n a hs
    ext t
    rw [Finset.mem_filter, hs, hmemD, hmemlev]
    exact and_comm
  have hD1 : (D 1).card ≤ 5 := by
    have : D 1 = Nf x := by ext t; rw [hmemD, hmemN, hone]
    rw [this]; exact hNcard x
  have hD2 : (D 2).card ≤ 5 := by
    have h := Finset.card_nsmul_le_card_nsmul (R := ℕ) (s := D 2) (t := D 1) (fun a b => G.Adj a b)
      (m := 2) (n := 2)
      (fun a ha => by
        rw [Finset.bipartiteAbove, hfilt (D 1) 1 a rfl]; exact hS2 a ((hmemD 2 a).mp ha))
      (fun b hb => by
        have : (D 2).bipartiteBelow (fun a b => G.Adj a b) b = lev b 2 := by
          rw [Finset.bipartiteBelow, ← hfilt (D 2) 2 b rfl]
          exact Finset.filter_congr fun t _ => G.adj_comm t b
        rw [this]; exact hS1 b ((hmemD 1 b).mp hb))
    simp only [smul_eq_mul] at h
    omega
  have hD3 : (D 3).card ≤ 1 := by
    have h := Finset.card_nsmul_le_card_nsmul (R := ℕ) (s := D 3) (t := D 2) (fun a b => G.Adj a b)
      (m := 3) (n := 1)
      (fun a ha => by
        rw [Finset.bipartiteAbove, hfilt (D 2) 2 a rfl]; exact hS4 a ((hmemD 3 a).mp ha))
      (fun b hb => by
        have : (D 3).bipartiteBelow (fun a b => G.Adj a b) b = lev b 3 := by
          rw [Finset.bipartiteBelow, ← hfilt (D 3) 3 b rfl]
          exact Finset.filter_congr fun t _ => G.adj_comm t b
        rw [this]; exact hS3 b ((hmemD 2 b).mp hb))
    simp only [smul_eq_mul] at h
    omega
  -- (S8) no vertex at level `4` or beyond
  have hS8 : ∀ q, G.dist x q ≠ 4 := by
    intro q hq
    obtain ⟨w, hwq, hw⟩ := hdown 3 q hq
    obtain ⟨u, huw, hu⟩ := hdown 2 w hw
    obtain ⟨m₁, m₂, hne, -, -, hd₁, hd₂⟩ := hH.two_mid x huw.symm hwq (by omega)
    have : ({m₁, m₂} : Finset V) ⊆ D 3 := by
      intro t ht
      simp only [Finset.mem_insert, Finset.mem_singleton] at ht
      rcases ht with rfl | rfl
      · exact (hmemD 3 t).mpr (by omega)
      · exact (hmemD 3 t).mpr (by omega)
    have := Finset.card_le_card this
    rw [Finset.card_pair hne] at this
    omega
  have hle3 : ∀ v, G.dist x v ≤ 3 := by
    have key : ∀ m v, G.dist x v ≠ 4 + m := by
      intro m
      induction m with
      | zero => exact hS8
      | succ m ih =>
        intro v hv
        obtain ⟨u, -, hu⟩ := hdown (4 + m) v (by omega)
        exact ih u hu
    intro v
    by_contra h
    push Not at h
    exact key (G.dist x v - 4) v (by omega)
  -- the count
  have huniv : (Set.univ : Set V) ⊆ ↑(D 0 ∪ D 1 ∪ D 2 ∪ D 3) := by
    intro v _
    simp only [Finset.coe_union, Set.mem_union, Finset.mem_coe, hmemD]
    have := hle3 v
    omega
  have hD0 : (D 0).card ≤ 1 := by
    have : D 0 ⊆ {x} := fun t ht => Finset.mem_singleton.mpr ((hzero t).mp ((hmemD 0 t).mp ht))
    simpa using Finset.card_le_card this
  have hcard : (D 0 ∪ D 1 ∪ D 2 ∪ D 3).card ≤ 12 := by
    have := Finset.card_union_le (D 0 ∪ D 1 ∪ D 2) (D 3)
    have := Finset.card_union_le (D 0 ∪ D 1) (D 2)
    have := Finset.card_union_le (D 0) (D 1)
    omega
  have henc : ENat.card V ≤ 12 := by
    rw [← Set.encard_univ]
    calc (Set.univ : Set V).encard ≤ (↑(D 0 ∪ D 1 ∪ D 2 ∪ D 3) : Set V).encard := Set.encard_le_encard huniv
      _ = ((D 0 ∪ D 1 ∪ D 2 ∪ D 3).card : ℕ∞) := Set.encard_coe_eq_coe_finsetCard _
      _ ≤ 12 := by exact_mod_cast hcard
  have := h13.trans henc
  norm_num at this

/-- The triangular lattice on `ℤ × ℤ`: `(a, b)` and `(c, d)` adjacent when their difference is `±(1, 0)`, `±(0, 1)` or `±(1, −1)`. -/
def triLattice : SimpleGraph (ℤ × ℤ) where
  Adj p q := (q.1 - p.1, q.2 - p.2) ∈ ({(1, 0), (-1, 0), (0, 1), (0, -1), (1, -1), (-1, 1)} : Set (ℤ × ℤ))
  symm := ⟨fun p q h => by
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff, Prod.mk.injEq] at h ⊢
    omega⟩
  loopless := ⟨fun p h => by
    simp only [sub_self, Set.mem_insert_iff, Set.mem_singleton_iff, Prod.mk.injEq] at h
    omega⟩

/-- Adjacency in the triangular lattice, as six coordinate cases. -/
theorem triLattice_adj {p q : ℤ × ℤ} : triLattice.Adj p q ↔
    (q.1 - p.1 = 1 ∧ q.2 - p.2 = 0) ∨ (q.1 - p.1 = -1 ∧ q.2 - p.2 = 0) ∨ (q.1 - p.1 = 0 ∧ q.2 - p.2 = 1) ∨
      (q.1 - p.1 = 0 ∧ q.2 - p.2 = -1) ∨ (q.1 - p.1 = 1 ∧ q.2 - p.2 = -1) ∨ (q.1 - p.1 = -1 ∧ q.2 - p.2 = 1) := by
  simp only [triLattice, Set.mem_insert_iff, Set.mem_singleton_iff, Prod.mk.injEq]

/-- **The inhabitant of `lemma1`'s hypotheses**: the triangular lattice is locally finite, connected and locally Hamiltonian (each
neighbourhood is a hexagon), and infinite. -/
theorem triLattice_hyps :
    (∀ x, (triLattice.neighborSet x).Finite) ∧ triLattice.Connected ∧ LocallyHamiltonian triLattice ∧ 13 ≤ ENat.card (ℤ × ℤ) := by
  set O : Finset (ℤ × ℤ) := {(1, 0), (-1, 0), (0, 1), (0, -1), (1, -1), (-1, 1)} with hO
  refine ⟨?_, ?_, ?_, ?_⟩
  · -- the neighbours are `x` plus one of six offsets
    intro x
    refine ((O.image fun o => (x.1 + o.1, x.2 + o.2)).finite_toSet).subset ?_
    intro y hy
    rw [SimpleGraph.mem_neighborSet, triLattice_adj] at hy
    simp only [Finset.coe_image, Set.mem_image, Finset.mem_coe, hO, Finset.mem_insert, Finset.mem_singleton]
    rcases hy with h | h | h | h | h | h <;>
      [exact ⟨(1, 0), by simp, by ext <;> simp <;> omega⟩; exact ⟨(-1, 0), by simp, by ext <;> simp <;> omega⟩;
       exact ⟨(0, 1), by simp, by ext <;> simp <;> omega⟩; exact ⟨(0, -1), by simp, by ext <;> simp <;> omega⟩;
       exact ⟨(1, -1), by simp, by ext <;> simp <;> omega⟩; exact ⟨(-1, 1), by simp, by ext <;> simp <;> omega⟩]
  · -- connected: every point is reachable from the origin by unit steps
    have hstep1 : ∀ p : ℤ × ℤ, triLattice.Reachable p (p.1 + 1, p.2) := fun p =>
      SimpleGraph.Adj.reachable (triLattice_adj.mpr (Or.inl ⟨by simp, by simp⟩))
    have hstep2 : ∀ p : ℤ × ℤ, triLattice.Reachable p (p.1, p.2 + 1) := fun p =>
      SimpleGraph.Adj.reachable (triLattice_adj.mpr (Or.inr (Or.inr (Or.inl ⟨by simp, by simp⟩))))
    have hrow : ∀ (b : ℤ) (a : ℤ), triLattice.Reachable (0, b) (a, b) := by
      intro b a
      induction a using Int.induction_on with
      | zero => rfl
      | succ n ih => exact ih.trans (hstep1 (n, b))
      | pred n ih =>
        refine ih.trans ?_
        have := hstep1 (-(n : ℤ) - 1, b)
        simp only [sub_add_cancel] at this
        exact this.symm
    have hcol : ∀ b : ℤ, triLattice.Reachable (0, 0) (0, b) := by
      intro b
      induction b using Int.induction_on with
      | zero => rfl
      | succ n ih => exact ih.trans (hstep2 (0, n))
      | pred n ih =>
        refine ih.trans ?_
        have := hstep2 (0, -(n : ℤ) - 1)
        simp only [sub_add_cancel] at this
        exact this.symm
    refine ⟨fun p q => ?_⟩
    exact ((hcol p.2).trans (hrow p.2 p.1)).symm.trans ((hcol q.2).trans (hrow q.2 q.1))
  · -- each neighbourhood is a hexagon
    intro x
    set a : ℤ × ℤ := (x.1 + 1, x.2)
    set b : ℤ × ℤ := (x.1, x.2 + 1)
    set c : ℤ × ℤ := (x.1 - 1, x.2 + 1)
    set d : ℤ × ℤ := (x.1 - 1, x.2)
    set f : ℤ × ℤ := (x.1, x.2 - 1)
    set g : ℤ × ℤ := (x.1 + 1, x.2 - 1)
    have hab : triLattice.Adj a b := triLattice_adj.mpr (by simp [a, b])
    have hbc : triLattice.Adj b c := triLattice_adj.mpr (by simp [b, c])
    have hcd : triLattice.Adj c d := triLattice_adj.mpr (by simp [c, d])
    have hdf : triLattice.Adj d f := triLattice_adj.mpr (by simp [d, f])
    have hfg : triLattice.Adj f g := triLattice_adj.mpr (by simp [f, g])
    have hga : triLattice.Adj g a := triLattice_adj.mpr (by simp [g, a])
    let p : triLattice.Walk b a :=
      .cons hbc (.cons hcd (.cons hdf (.cons hfg (.cons hga .nil))))
    refine ⟨a, .cons hab p, ?_, ?_⟩
    · rw [SimpleGraph.Walk.cons_isCycle_iff]
      constructor
      · rw [SimpleGraph.Walk.isPath_def]
        simp [p, a, b, c, d, f, g, Prod.ext_iff]
        omega
      · simp [p, a, b, c, d, f, g, Prod.ext_iff]
        omega
    · intro y
      simp only [SimpleGraph.Walk.support_cons, SimpleGraph.Walk.support_nil, p, List.mem_cons, List.not_mem_nil, or_false,
        triLattice_adj, a, b, c, d, f, g, Prod.ext_iff]
      omega
  · rw [ENat.card_eq_top_of_infinite]; exact le_top

/-- A spec example for `triLattice`: `(0, 0)` and `(1, −1)` are adjacent, `(0, 0)` and `(1, 1)` are not. -/
example : triLattice.Adj (0, 0) (1, -1) ∧ ¬ triLattice.Adj (0, 0) (1, 1) := by
  constructor
  · simp [triLattice]
  · simp [triLattice]

/-- A spec example for `exists_eq_of_steps`: the identity sequence, below `2` at `0` and above it at `4`, takes the value `2` in between. -/
example : ∃ k, 0 < k ∧ k < 4 ∧ (fun i : ℕ => (i : ℤ)) k = 2 :=
  exists_eq_of_steps _ 2 (by norm_num) (fun k _ _ => by push_cast; omega) (Or.inl ⟨by norm_num, by norm_num⟩)

/-- A spec example for `LocallyHamiltonian.exists_two_common`, on the triangular lattice: the edge from `(0, 0)` to `(1, 0)` has two common
neighbours. -/
example : ∃ c₁ c₂, c₁ ≠ c₂ ∧ triLattice.Adj (0, 0) c₁ ∧ triLattice.Adj (1, 0) c₁ ∧ triLattice.Adj (0, 0) c₂ ∧ triLattice.Adj (1, 0) c₂ :=
  triLattice_hyps.2.2.1.exists_two_common (by simp [triLattice])

end HadwigerNelson.Thomassen

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- **The map graph `M`** (CVB § 1.9's frame): the tiles, two distinct tiles adjacent when their closures meet. -/
def mapGraph : SimpleGraph {T : Set ℂ // F.IsTile T} where
  Adj T T' := T ≠ T' ∧ (closure T.1 ∩ closure T'.1).Nonempty
  symm := ⟨fun T T' h => ⟨h.1.symm, by rw [inter_comm]; exact h.2⟩⟩
  loopless := ⟨fun T h => h.1 rfl⟩

/-- **`Hc` is a hole of `T`** (CVB B1: "a boundary component of `x` disjoint from its outer one"; FS131-KP's repair, plan § 2): a nonempty
bounded part of the complement of `T`'s closure whose closure misses the closure of the rest of that complement. The separation makes `Hc` a
union of whole clusters of complementary components (components chained by touching closures) not containing the unbounded one; so `T` has a
hole exactly when the complementary components, joined when their closures touch, are not one cluster — exactly when `mapGraph − T` is
disconnected. It reads the complement of the closure, not the components of `∂T`: a phantom slit can join `∂T`'s components while `cl T`
still separates (plan § 2.2). Not required to be one cluster: `fill`, `IsOuterTile` and the `cvb_*` leaves read holes only through their union
or their existence. -/
def IsHoleOf (T Hc : Set ℂ) : Prop :=
  Hc.Nonempty ∧ Hc ⊆ (closure T)ᶜ ∧ Bornology.IsBounded Hc ∧ Disjoint (closure Hc) (closure ((closure T)ᶜ \ Hc))

/-- **The filled tile** `x̂` (CVB B2 step 1): the tile with its holes. -/
def fill (T : Set ℂ) : Set ℂ := T ∪ ⋃₀ {Hc | IsHoleOf T Hc}

/-- **An outer tile**: a tile lying in no hole of another tile (the tiles the filled map keeps). -/
def IsOuterTile (T : Set ℂ) : Prop := F.IsTile T ∧ ∀ T' Hc, F.IsTile T' → IsHoleOf T' Hc → ¬ T ⊆ Hc

/-- **The filled map's graph** (CVB B2 step 1: "its map graph is `M` minus the hole contents"): the outer tiles, two distinct ones adjacent
when the closures of their filled tiles meet. -/
def filledGraph : SimpleGraph {T : Set ℂ // F.IsOuterTile T} where
  Adj T T' := T ≠ T' ∧ (closure (fill T.1) ∩ closure (fill T'.1)).Nonempty
  symm := ⟨fun T T' h => ⟨h.1.symm, by rw [inter_comm]; exact h.2⟩⟩
  loopless := ⟨fun T h => h.1 rfl⟩

end ArcMap

/-! ### Spec examples -/

section Spec

/-- A tile of the one-colour plane is the plane (a spec example for `mapGraph`: the one-colour plane's map graph has one vertex, so no
edge). -/
example (j : Fin 2) (T T' : {T : Set ℂ // (ArcMap.const univ isOpen_univ j).IsTile T}) :
    ¬ (ArcMap.const univ isOpen_univ j).mapGraph.Adj T T' := by
  rintro ⟨hne, -⟩
  apply hne
  obtain ⟨T, x, hx, rfl⟩ := T
  obtain ⟨T', y, hy, rfl⟩ := T'
  have hU : (ArcMap.const univ isOpen_univ j).interiorPts = univ := by simp
  apply Subtype.ext
  simp only [hU, connectedComponentIn_univ, PreconnectedSpace.connectedComponent_eq_univ]

/-- **Adversary**: a set with empty closure-complement has no hole (a spec example for `IsHoleOf`: the plane is no tile's hole-maker). -/
example (Hc : Set ℂ) : ¬ ArcMap.IsHoleOf (univ : Set ℂ) Hc := by
  rintro ⟨⟨z, hz⟩, hsub, -⟩
  simpa using hsub hz

/-- **Adversary: a chain to the outside is no hole** (FS131-I5b's counterexample to the old definition, as a plane set; plan § 2.3): the
unit disc minus the closed discs of radius `1/4` about `1/4` and `3/4` — the first touches the second at `1/2`, the second touches the unit
circle at `1`. A separated part of the complement holding either small disc holds the other, then the outside, so it is unbounded. (Under the
old definition the disc about `1/4` was a hole, and `cvb_hole_disconnected` was false.) -/
theorem not_isHoleOf_chain (Hc : Set ℂ) :
    ¬ ArcMap.IsHoleOf (ball 0 1 \ (closedBall (1 / 4 : ℂ) (1 / 4) ∪ closedBall (3 / 4 : ℂ) (1 / 4))) Hc := by
  sorry

/-- **A cluster is one hole** (item 242's case; plan § 2.3): the unit disc minus the closed discs of radius `1/4` about `±1/4`, which touch at
`0` and miss the unit circle; the two open small discs together are a hole (neither alone is: their closures touch). Exercises the separation
clause on a hole of two components. -/
theorem isHoleOf_cluster :
    ArcMap.IsHoleOf (ball 0 1 \ (closedBall (-1 / 4 : ℂ) (1 / 4) ∪ closedBall (1 / 4 : ℂ) (1 / 4)))
      (ball (-1 / 4 : ℂ) (1 / 4) ∪ ball (1 / 4 : ℂ) (1 / 4)) ∧
    ¬ ArcMap.IsHoleOf (ball 0 1 \ (closedBall (-1 / 4 : ℂ) (1 / 4) ∪ closedBall (1 / 4 : ℂ) (1 / 4))) (ball (1 / 4 : ℂ) (1 / 4)) := by
  sorry

end Spec

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS114-CVB-THOM -/

/-- The filled map graph is locally finite (FS131-KP plan § 4, leaf F-LOC): a filled tile lies in its hull, inside `B̄(x, 1)` for any `x` in
its closure (`IsTile.closure_subset_closedBall`, `exists_outermost`'s hull bound), so the tiles whose filled closures meet it have closures
meeting a compact set (`finite_tiles_closure_inter`). -/
theorem filledGraph_locallyFinite (hF : F.Valid) (hP : F.IsPlaneMap) (x : {T : Set ℂ // F.IsOuterTile T}) :
    (F.filledGraph.neighborSet x).Finite := by
  sorry

/-- The filled map graph is connected (leaf F-CONN): the filled outer tiles' closures cover the plane (every tile lies in an outer tile's
fill: the enclosure chain stops, as in `exists_outermost`), so `mem_of_touch_closed` on `U = ℂ` with the touching relation of the fills. -/
theorem filledGraph_connected (hF : F.Valid) (hP : F.IsPlaneMap) : F.filledGraph.Connected := by
  sorry

/-- The filled map graph is infinite (leaf F-INF): the plane is unbounded and every filled tile bounded. -/
theorem filledGraph_infinite (hF : F.Valid) (hP : F.IsPlaneMap) : Infinite {T : Set ℂ // F.IsOuterTile T} := by
  sorry

/-- **Rings from boundary walks** (leaf F-RING, the planar heart of CVB B2 step 2): every filled outer tile `x̂` has a ring — the outer
boundary walk of `x̂` (`frontier (outerDom x)`, preconnected), listing the tiles met at each pass (sector charts), each repeated tile only at
its edge contacts — and `M̂ − x − y` is connected unless `y` appears twice apart (a bounded component of `ℂ ∖ (cl x̂ ∪ cl ŷ)` is enclosed by
edges of both; CVB's sketch, one mind). Plan § 4: the boundary walk is built over the finite boundary graph of `F` near `cl x̂` (the same
graph as `exists_far_end`'s); separation by `isPreconnected_frontier_connectedComponentIn` and `inter_nonempty_of_interleaved`. **H**, the
wave's longest leaf; may be its own job (Keryx's call after the implementer's measurement). -/
theorem filledGraph_rings (hF : F.Valid) (hP : F.IsPlaneMap) (x : {T : Set ℂ // F.IsOuterTile T}) :
    ∃ r, Thomassen.IsRing F.filledGraph x r ∧
      ∀ y, y ≠ x → ¬ Thomassen.TwiceApart r y → (F.filledGraph.induce (Thomassen.offTwo x y)).Connected := by
  sorry

/-- **One infinite component** (leaf F-ONE, CVB B2 step 2): for distinct outer tiles `x`, `y`, `M̂ − x − y` has exactly one infinite
component — the tiles of the unbounded component of `ℂ ∖ (cl x̂ ∪ cl ŷ)` are chained (`mem_of_touch_closed`) and infinitely many, those of
bounded components finitely many (`finite_tiles_closure_inter` on the hull), and every component meeting no unbounded tile is among them. -/
theorem filledGraph_oneInf (hF : F.Valid) (hP : F.IsPlaneMap) (x y : {T : Set ℂ // F.IsOuterTile T}) (hxy : x ≠ y) :
    ∃ c : (F.filledGraph.induce (Thomassen.offTwo x y)).ConnectedComponent, ¬ c.supp.Finite ∧ ∀ c', ¬ c'.supp.Finite → c' = c := by
  sorry

/-- **The filled map graph of a valid plane map has Thomassen's planar properties** (CVB B2 steps 1–3; the five leaves above). -/
theorem filledGraph_planarLike (hF : F.Valid) (hP : F.IsPlaneMap) : Thomassen.PlanarLike F.filledGraph :=
  ⟨filledGraph_locallyFinite hF hP, filledGraph_connected hF hP, filledGraph_infinite hF hP, filledGraph_rings hF hP,
    filledGraph_oneInf hF hP⟩

/-- **FS114-CVB-THOM, B2 steps 1–3** (`plans/FS114-CVB-verification.md` § 1.9): for every valid map of the plane, Siamese pairs allowed, the
reduced filled map graph `H` is connected, locally finite, locally Hamiltonian and infinite — `[Thomassen1999]`'s steps other than the
rainbow step, with holes filled, facial cycles read as boundary walks, and the count in `int(R)` replaced by local finiteness. Colour-free
(CVB: "indeed every locally finite plane map with bounded connected tiles"); validity enters only through the tiles' diameter `≤ 1`
(`dist_lt_one_of_forall_dist_ne_one`). Every `k`. Model of the hypotheses: `sevenBrickMap` (valid, of the plane, `k = 7`). -/
theorem cvb_thom_reduced (hF : F.Valid) (hP : F.IsPlaneMap) :
    (Thomassen.reduced F.filledGraph).Connected ∧ (∀ x, ((Thomassen.reduced F.filledGraph).neighborSet x).Finite) ∧
      Thomassen.LocallyHamiltonian (Thomassen.reduced F.filledGraph) ∧ Infinite (Thomassen.reducedVerts F.filledGraph) :=
  Thomassen.reduced_props_of_planarLike _ (filledGraph_planarLike hF hP)

/-- **FS114-CVB-THOM** (B2 step 4): every valid map of the plane, Siamese pairs allowed, has an outer tile of degree at least `6` in the reduced
filled map graph `H` (`cvb_thom_reduced` and `Thomassen.lemma1`). The rainbow step — that such a tile's neighbours carry six colours — is not
claimed (it fails on valid maps: FS114-N114-RD's types (A) and (B)). Model of the hypotheses: `sevenBrickMap` (`k = 7`; its bricks have six
neighbours each). -/
theorem cvb_thom (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ x, 6 ≤ ((Thomassen.reduced F.filledGraph).neighborSet x).encard := by
  obtain ⟨hc, hfin, hH, hinf⟩ := cvb_thom_reduced hF hP
  exact Thomassen.lemma1 _ hfin hc hH (by rw [ENat.card_eq_top_of_infinite]; exact le_top)

/-- **FS114-CVB-PINCH, the pinch clause** (B1): in the map graph of a valid map of the plane, removing a tile with no hole leaves the graph
connected — at a pinched tile (its boundary walk visits a vertex twice) as at a simple one. Read at the class the argument reads (every tile
with no hole; Thomassen's own case is the unpinched one). Model of the hypotheses: a brick of `sevenBrickMap`. -/
theorem cvb_pinch_connected (hF : F.Valid) (hP : F.IsPlaneMap) {T : Set ℂ} (hT : F.IsTile T) (hno : ∀ Hc, ¬ IsHoleOf T Hc) :
    (F.mapGraph.induce {T' | T' ≠ ⟨T, hT⟩}).Connected := by
  -- FS131-KP plan § 4, leaf PINCH: through the separation, with local finiteness read at one point only
  have hbd : Bornology.IsBounded (closure T) := sorry -- `IsTile.closure_subset_closedBall`
  -- `M − T` has a vertex: a tile of the unbounded complementary component (`isPreconnected_compl_closedBall`, `exists_tile_inter_of_isOpen`)
  have hne : Nonempty {T' : {T : Set ℂ // F.IsTile T} // T' ∈ {T' | T' ≠ ⟨T, hT⟩}} := sorry
  -- fix a tile `A ≠ T`; let `P` be the tiles reachable from it in `M − T`, `Y` the union of the components of `(cl T)ᶜ` holding a tile of `P`
  -- (each such component's tiles all lie in `P`: `mem_of_touch_closed`), and `Hc := (cl T)ᶜ \ Y`. A point of `cl Hc ∩ cl Y` lies in `cl T`
  -- (both are unions of open components), and there `exists_tile_mem_closure_of_mem_closure` gives tiles of `Hc` and `Y` whose closures meet,
  -- adjacent in `M − T`, so the first is in `P`: `Hc` and `Y` are separated. The one not holding the unbounded component
  -- (`connectedComponentIn_eq_of_not_isBounded`) is bounded; were `Hc` nonempty, `Hc` or `Y` would be a hole, against `hno`. So every tile is
  -- in `P` (`IsTile.subset_compl_closure`).
  sorry

/-- **FS114-CVB-PINCH, the hole clause** (B1): in the map graph of a valid map of the plane, removing a tile with a hole disconnects the graph
(the tiles inside the hole from those outside). Whether a valid plane map with a holed tile exists is not claimed (the row: "every valid map
cannot be refuted by an object"); the local configuration is `exists_holed_valid_fragment`. `GENERIC` on plane maps. -/
theorem cvb_hole_disconnected (hF : F.Valid) (hP : F.IsPlaneMap) {T Hc : Set ℂ} (hT : F.IsTile T) (hH : IsHoleOf T Hc) :
    ¬ (F.mapGraph.induce {T' | T' ≠ ⟨T, hT⟩}).Connected := by
  -- FS131-KP plan § 4, leaf HOLE: no Jordan curve theorem, only the separation clause
  obtain ⟨hne, hsub, hb, hsep⟩ := hH
  -- `Hc` and the rest of `(cl T)ᶜ` are open (`Hc = (cl T)ᶜ \ cl ((cl T)ᶜ \ Hc)`)
  have hHo : IsOpen Hc := sorry
  -- a tile inside the hole (`exists_tile_inter_of_isOpen`, `IsTile.subset_compl_closure`, `IsTile.subset_or_subset_of_separated`)
  have hin : ∃ A, F.IsTile A ∧ A ⊆ Hc := sorry
  -- a tile outside it: the rest holds the unbounded component (`isPreconnected_compl_closedBall`, `IsTile.closure_subset_closedBall`)
  have hout : ∃ B, F.IsTile B ∧ B ≠ T ∧ B ⊆ (closure T)ᶜ \ Hc := sorry
  -- a walk of `M − T` from `A` to `B` has a dart leaving the tiles inside `Hc` (`SimpleGraph.Walk.exists_boundary_dart`); the dart's two tiles
  -- have closures in `cl Hc` and `cl ((cl T)ᶜ \ Hc)`, disjoint by `hsep`, yet adjacent
  sorry

end ArcMap

/-! ### The holed fragment (`exists_holed_valid_fragment`'s object) -/

/-- A preconnected set whose norms avoid `[a, b]` lies on one side of it, the side of any of its points. -/
theorem norm_side_of_isPreconnected {S : Set ℂ} (hS : IsPreconnected S) {a b : ℝ} (hab : a ≤ b)
    (havoid : ∀ z ∈ S, ‖z‖ < a ∨ b < ‖z‖) {z₀ : ℂ} (hz₀ : z₀ ∈ S) :
    (‖z₀‖ < a → ∀ z ∈ S, ‖z‖ < a) ∧ (b < ‖z₀‖ → ∀ z ∈ S, b < ‖z‖) := by
  have hI := hS.image (fun z : ℂ => ‖z‖) continuous_norm.continuousOn
  constructor
  · intro h0 z hz
    by_contra hz'
    push Not at hz'
    obtain ⟨w, hw, hwa⟩ := hI.Icc_subset (mem_image_of_mem _ hz₀) (mem_image_of_mem _ hz) ⟨h0.le, hz'⟩
    rcases havoid w hw with h | h <;> simp only at hwa <;> linarith
  · intro h0 z hz
    by_contra hz'
    push Not at hz'
    obtain ⟨w, hw, hwb⟩ := hI.Icc_subset (mem_image_of_mem _ hz) (mem_image_of_mem _ hz₀) ⟨hz', h0.le⟩
    rcases havoid w hw with h | h <;> simp only at hwb <;> linarith

/-- A point of norm `ρ > 0` lies on the full circle `circ 0 ρ 0 (2π)`. -/
theorem mem_carrier_circ_of_norm {ρ : ℝ} {z : ℂ} (hz : ‖z‖ = ρ) : z ∈ (Arc.circ 0 ρ 0 (2 * π)).carrier := by
  have hpol : z = (ρ : ℂ) * e (Complex.arg z) := by
    rw [← hz]; exact (Complex.norm_mul_exp_arg_mul_I z).symm
  rcases le_or_gt 0 (Complex.arg z) with h | h
  · exact ⟨Complex.arg z, ⟨h, by linarith [Complex.arg_le_pi z, Real.pi_pos]⟩, by
      show (0 : ℂ) + (ρ : ℂ) * e (Complex.arg z) = z; rw [zero_add, ← hpol]⟩
  · refine ⟨Complex.arg z + 2 * π, ⟨by linarith [Complex.neg_pi_lt_arg z], by linarith⟩, ?_⟩
    show (0 : ℂ) + (ρ : ℂ) * e (Complex.arg z + 2 * π) = z
    rw [zero_add, e_add_two_pi, ← hpol]

/-- The points of `circ 0 ρ θ₀ θ₁` have norm `ρ` (`ρ ≥ 0`). -/
theorem norm_of_mem_carrier_circ {ρ θ₀ θ₁ : ℝ} (hρ : 0 ≤ ρ) {z : ℂ} (hz : z ∈ (Arc.circ 0 ρ θ₀ θ₁).carrier) : ‖z‖ = ρ := by
  obtain ⟨θ, -, rfl⟩ := hz
  show ‖(0 : ℂ) + (ρ : ℂ) * e θ‖ = ρ
  rw [zero_add, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg hρ]

/-- The points of the radial segment `seg (u/2) (3u/5)` (`‖u‖ = 1`) have norm in `[1/2, 3/5]`. -/
theorem norm_of_mem_carrier_radial {u z : ℂ} (hu : ‖u‖ = 1) (hz : z ∈ (Arc.seg ((1 / 2 : ℝ) * u) ((3 / 5 : ℝ) * u)).carrier) :
    1 / 2 ≤ ‖z‖ := by
  obtain ⟨a, b, ha, hb, hab, rfl⟩ := hz
  have : a • ((1 / 2 : ℝ) * u) + b • ((3 / 5 : ℝ) * u) = ((a / 2 + 3 * b / 5 : ℝ) : ℂ) * u := by
    simp only [Complex.real_smul]; push_cast; ring
  rw [this, norm_mul, hu, mul_one, Complex.norm_real, Real.norm_of_nonneg (by positivity)]
  linarith

/-- A point `t u` with `‖u‖ = 1`, `t ∈ [1/2, 3/5]`, lies on the radial segment `seg (u/2) (3u/5)`. -/
theorem mem_carrier_radial {u : ℂ} {t : ℝ} (ht : 1 / 2 ≤ t) (ht' : t ≤ 3 / 5) :
    (t : ℂ) * u ∈ (Arc.seg ((1 / 2 : ℝ) * u) ((3 / 5 : ℝ) * u)).carrier := by
  refine ⟨(3 / 5 - t) * 10, (t - 1 / 2) * 10, by linarith, by linarith, by ring, ?_⟩
  simp only [Complex.real_smul]; push_cast; ring

/-- The holed fragment's arcs: the circles of radii `1/4` and `1/2` about `0`, and four radial segments from radius `1/2` to `3/5` on the
axes. -/
noncomputable def holedArcs : Set Arc :=
  {.circ 0 (1 / 4) 0 (2 * π), .circ 0 (1 / 2) 0 (2 * π), .seg ((1 / 2 : ℝ) * 1) ((3 / 5 : ℝ) * 1),
    .seg ((1 / 2 : ℝ) * (-1)) ((3 / 5 : ℝ) * (-1)), .seg ((1 / 2 : ℝ) * I) ((3 / 5 : ℝ) * I),
    .seg ((1 / 2 : ℝ) * (-I)) ((3 / 5 : ℝ) * (-I))}

/-- The holed fragment's colour: `2` on the disc `|z| < 1/4`, `1` on the annulus `1/4 ≤ |z| < 1/2`, and outside it one colour per open
quadrant (`3`, `4`, `5`, `0`). -/
noncomputable def holedCol (z : ℂ) : Fin 6 :=
  if ‖z‖ < 1 / 4 then 2 else if ‖z‖ < 1 / 2 then 1 else
    if 0 < z.re then (if 0 < z.im then 3 else 0) else (if 0 < z.im then 4 else 5)

/-- A spec example for `holedCol`: the centre has colour `2`, the point `3/8` colour `1`. -/
example : holedCol 0 = 2 ∧ holedCol (3 / 8) = 1 := by
  constructor
  · simp [holedCol]
  · have h : ‖(3 / 8 : ℂ)‖ = 3 / 8 := by
      rw [show (3 / 8 : ℂ) = ((3 / 8 : ℝ) : ℂ) by push_cast; ring, Complex.norm_real, Real.norm_of_nonneg (by norm_num)]
    simp only [holedCol, h]; norm_num

/-- Membership in the holed fragment's arcs, by norm: a point on an arc has norm `1/4` or at least `1/2`. -/
theorem norm_of_mem_holedArcs {z : ℂ} (hz : z ∈ ⋃ a ∈ holedArcs, a.carrier) : ‖z‖ = 1 / 4 ∨ 1 / 2 ≤ ‖z‖ := by
  simp only [mem_iUnion, holedArcs, mem_insert_iff, mem_singleton_iff, exists_prop] at hz
  obtain ⟨a, ha, hza⟩ := hz
  rcases ha with rfl | rfl | rfl | rfl | rfl | rfl
  · exact Or.inl (norm_of_mem_carrier_circ (by norm_num) hza)
  · exact Or.inr (norm_of_mem_carrier_circ (by norm_num) hza).ge
  · exact Or.inr (norm_of_mem_carrier_radial (by simp) hza)
  · exact Or.inr (norm_of_mem_carrier_radial (by simp) hza)
  · exact Or.inr (norm_of_mem_carrier_radial (by simp) hza)
  · exact Or.inr (norm_of_mem_carrier_radial (by simp) hza)

/-- Off the holed fragment's arcs, within `3/5`: the norm is not `1/4` or `1/2`, and beyond `1/2` neither coordinate vanishes. -/
theorem holed_off_arcs {z : ℂ} (hd : ‖z‖ < 3 / 5) (hz : z ∉ ⋃ a ∈ holedArcs, a.carrier) :
    ‖z‖ ≠ 1 / 4 ∧ ‖z‖ ≠ 1 / 2 ∧ (1 / 2 < ‖z‖ → z.re ≠ 0 ∧ z.im ≠ 0) := by
  have hmem : ∀ a ∈ holedArcs, z ∉ a.carrier := fun a ha h => hz (mem_biUnion ha h)
  refine ⟨fun h => hmem _ (by simp [holedArcs]) (mem_carrier_circ_of_norm h),
    fun h => hmem _ (by simp [holedArcs]) (mem_carrier_circ_of_norm h), fun h => ⟨fun hre => ?_, fun him => ?_⟩⟩
  · -- on the imaginary axis
    obtain ⟨t, rfl⟩ : ∃ t : ℝ, z = (t : ℂ) * I := ⟨z.im, by apply Complex.ext <;> simp [hre]⟩
    have hn : ‖(t : ℂ) * I‖ = |t| := by rw [norm_mul, Complex.norm_I, mul_one, Complex.norm_real, Real.norm_eq_abs]
    rw [hn] at h hd
    rcases le_or_gt 0 t with h0 | h0
    · rw [abs_of_nonneg h0] at h hd
      exact hmem _ (by simp [holedArcs]) (mem_carrier_radial (u := I) (by linarith) (by linarith))
    · rw [abs_of_neg h0] at h hd
      have : (t : ℂ) * I = ((-t : ℝ) : ℂ) * (-I) := by push_cast; ring
      rw [this] at hmem
      exact hmem _ (by simp [holedArcs]) (mem_carrier_radial (u := -I) (by linarith) (by linarith))
  · -- on the real axis
    obtain ⟨t, rfl⟩ : ∃ t : ℝ, z = (t : ℂ) * 1 := ⟨z.re, by apply Complex.ext <;> simp [him]⟩
    have hn : ‖(t : ℂ) * 1‖ = |t| := by rw [mul_one, Complex.norm_real, Real.norm_eq_abs]
    rw [hn] at h hd
    rcases le_or_gt 0 t with h0 | h0
    · rw [abs_of_nonneg h0] at h hd
      exact hmem _ (by simp [holedArcs]) (mem_carrier_radial (u := 1) (by linarith) (by linarith))
    · rw [abs_of_neg h0] at h hd
      have : (t : ℂ) * 1 = ((-t : ℝ) : ℂ) * (-1) := by push_cast; ring
      rw [this] at hmem
      exact hmem _ (by simp [holedArcs]) (mem_carrier_radial (u := -1) (by linarith) (by linarith))

/-- **The holed fragment** (CVB B1's configuration): the disc `|z| < 1/4` of colour `2` inside the annulus `1/4 < |z| < 1/2` of colour `1`,
ringed by four quarter-annuli `1/2 < |z| < 3/5` of colours `3`, `4`, `5`, `0`; domain `B(0, 3/5)`. -/
noncomputable def holedFrag : ArcMap 6 where
  dom := ball 0 (3 / 5)
  isOpen_dom := isOpen_ball
  arcs := holedArcs
  nondegenerate := by
    intro a ha
    simp only [holedArcs, mem_insert_iff, mem_singleton_iff] at ha
    rcases ha with rfl | rfl | rfl | rfl | rfl | rfl <;> simp only [Arc.Nondegenerate]
    · exact ⟨by norm_num, by positivity, by linarith⟩
    · exact ⟨by norm_num, by positivity, by linarith⟩
    all_goals
      intro h
      have := congrArg (fun w : ℂ => ‖w‖) h
      simp only [norm_mul, Complex.norm_real, norm_neg, Complex.norm_I, norm_one] at this
      norm_num at this
  locallyFinite := by
    intro x _
    refine ⟨univ, univ_mem, ?_⟩
    refine Set.Finite.subset ?_ (fun a ha => ha.1)
    simp only [holedArcs]
    exact ((((((Set.finite_singleton _).insert _).insert _).insert _).insert _).insert _)
  col := holedCol
  locallyConstant := by
    intro x hx hxa
    have hd : ‖x‖ < 3 / 5 := by simpa using hx
    obtain ⟨h4, h2, hax⟩ := holed_off_arcs hd hxa
    have hcn := continuous_norm.tendsto x
    rcases lt_or_gt_of_ne h4 with hlt | hgt
    · filter_upwards [hcn.eventually (gt_mem_nhds hlt)] with y hy
      simp only [holedCol, if_pos hy, if_pos hlt]
    rcases lt_or_gt_of_ne h2 with hlt2 | hgt2
    · filter_upwards [hcn.eventually (lt_mem_nhds hgt), hcn.eventually (gt_mem_nhds hlt2)] with y hy hy'
      simp only [holedCol, if_neg (not_lt.mpr hy.le), if_pos hy', if_neg (not_lt.mpr hgt.le), if_pos hlt2]
    obtain ⟨hre, him⟩ := hax hgt2
    have hre' : ∀ᶠ y in 𝓝 x, (0 < y.re ↔ 0 < x.re) := by
      rcases lt_or_gt_of_ne hre with h | h
      · filter_upwards [(Complex.continuous_re.tendsto x).eventually (gt_mem_nhds h)] with y hy
        exact ⟨fun h' => by linarith, fun h' => by linarith⟩
      · filter_upwards [(Complex.continuous_re.tendsto x).eventually (lt_mem_nhds h)] with y hy
        exact ⟨fun _ => h, fun _ => hy⟩
    have him' : ∀ᶠ y in 𝓝 x, (0 < y.im ↔ 0 < x.im) := by
      rcases lt_or_gt_of_ne him with h | h
      · filter_upwards [(Complex.continuous_im.tendsto x).eventually (gt_mem_nhds h)] with y hy
        exact ⟨fun h' => by linarith, fun h' => by linarith⟩
      · filter_upwards [(Complex.continuous_im.tendsto x).eventually (lt_mem_nhds h)] with y hy
        exact ⟨fun _ => h, fun _ => hy⟩
    filter_upwards [hcn.eventually (lt_mem_nhds hgt2), hre', him'] with y hy hyr hyi
    have h1 : ¬ ‖y‖ < 1 / 4 := by linarith
    have h1' : ¬ ‖y‖ < 1 / 2 := by linarith
    have h3 : ¬ ‖x‖ < 1 / 4 := by linarith
    have h3' : ¬ ‖x‖ < 1 / 2 := by linarith
    simp only [holedCol, if_neg h1, if_neg h1', if_neg h3, if_neg h3', hyr, hyi]

/-- Two points of norm below `3/5` whose coordinates agree in sign (weakly) are less than `1` apart. -/
theorem dist_lt_one_of_same_quadrant {x y : ℂ} (hx : ‖x‖ < 3 / 5) (hy : ‖y‖ < 3 / 5) (hre : 0 ≤ x.re * y.re)
    (him : 0 ≤ x.im * y.im) : dist x y < 1 := by
  have hx2 : x.re ^ 2 + x.im ^ 2 < 9 / 25 := by
    have := Complex.sq_norm x; rw [Complex.normSq_apply] at this; nlinarith [norm_nonneg x]
  have hy2 : y.re ^ 2 + y.im ^ 2 < 9 / 25 := by
    have := Complex.sq_norm y; rw [Complex.normSq_apply] at this; nlinarith [norm_nonneg y]
  have hd : dist x y ^ 2 = (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 := by
    rw [dist_eq_norm, Complex.sq_norm, Complex.normSq_apply]; simp only [Complex.sub_re, Complex.sub_im]; ring
  nlinarith [dist_nonneg (x := x) (y := y)]

/-- The holed fragment is valid: each colour class is one piece of diameter below `1`. -/
theorem holedFrag_valid : holedFrag.Valid := by
  intro x hx y hy hxy hcol
  have hxd : ‖x‖ < 3 / 5 := by simpa [holedFrag] using hx.1
  have hyd : ‖y‖ < 3 / 5 := by simpa [holedFrag] using hy.1
  change holedCol x = holedCol y at hcol
  have hlt : dist x y < 1 := by
    unfold holedCol at hcol
    split_ifs at hcol with a1 a2 a3 a4 b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 <;>
      first
      | exact absurd hcol (by decide)
      | (rw [dist_eq_norm]; linarith [norm_sub_le x y, norm_neg y])
      | (apply dist_lt_one_of_same_quadrant hxd hyd <;> nlinarith)
  linarith

/-- A spec example for `holedArcs` and `holedFrag`: the inner circle is an arc, the centre has colour `2`, the domain is `B(0, 3/5)`. -/
example : Arc.circ 0 (1 / 4) 0 (2 * π) ∈ holedArcs ∧ holedFrag.col 0 = 2 ∧ holedFrag.dom = ball 0 (3 / 5) :=
  ⟨by simp [holedArcs], by simp [holedFrag, holedCol], rfl⟩

/-- The open annulus `1/4 < |z| < 1/2` is preconnected (the image of a band under polar coordinates). -/
theorem isPreconnected_holedAnnulus : IsPreconnected {z : ℂ | 1 / 4 < ‖z‖ ∧ ‖z‖ < 1 / 2} := by
  have h : {z : ℂ | 1 / 4 < ‖z‖ ∧ ‖z‖ < 1 / 2} = (fun p : ℝ × ℝ => (p.1 : ℂ) * e p.2) '' (Ioo (1 / 4) (1 / 2) ×ˢ univ) := by
    ext z
    constructor
    · rintro ⟨h1, h2⟩
      exact ⟨(‖z‖, Complex.arg z), ⟨⟨h1, h2⟩, mem_univ _⟩, Complex.norm_mul_exp_arg_mul_I z⟩
    · rintro ⟨⟨r, θ⟩, ⟨⟨h1, h2⟩, -⟩, rfl⟩
      have : ‖(r : ℂ) * e θ‖ = r := by rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg (by linarith)]
      simp only [mem_setOf_eq, this]; exact ⟨h1, h2⟩
  rw [h]
  exact (isPreconnected_Ioo.prod isPreconnected_univ).image _ (by unfold e; fun_prop)

/-- **Holes are locally consistent with validity** (FS114-CVB-PINCH's last clause, CVB B1's counterexample configuration): there is a valid
six-coloured fragment covering `B̄(0, 1/2)` with a tile that has a hole — the annulus `1/4 < |z| < 1/2` of colour `1` about the disc
`|z| < 1/4` of colour `2`, ringed by four quarter-annuli `1/2 < |z| < 3/5` of colours `3, 4, 5, 6 = 0` (`holedFrag`). -/
theorem exists_holed_valid_fragment :
    ∃ F : ArcMap 6, F.Valid ∧ F.Covers 0 (1 / 2) ∧ ∃ T Hc, F.IsTile T ∧ ArcMap.IsHoleOf T Hc := by
  set A : Set ℂ := {z : ℂ | 1 / 4 < ‖z‖ ∧ ‖z‖ < 1 / 2} with hA
  have hint : ∀ z ∈ holedFrag.interiorPts, ‖z‖ ≠ 1 / 4 ∧ ‖z‖ ≠ 1 / 2 := by
    intro z hz
    have hd : ‖z‖ < 3 / 5 := by simpa [holedFrag] using hz.1
    obtain ⟨h1, h2, -⟩ := holed_off_arcs hd hz.2
    exact ⟨h1, h2⟩
  have hAint : A ⊆ holedFrag.interiorPts := by
    rintro z ⟨h1, h2⟩
    refine ⟨show z ∈ ball (0 : ℂ) (3 / 5) by rw [mem_ball, dist_zero_right]; linarith, fun hz => ?_⟩
    rcases norm_of_mem_holedArcs hz with h | h <;> linarith
  have h38 : (3 / 8 : ℂ) ∈ A := by
    have : ‖(3 / 8 : ℂ)‖ = 3 / 8 := by
      rw [show (3 / 8 : ℂ) = ((3 / 8 : ℝ) : ℂ) by push_cast; ring, Complex.norm_real, Real.norm_of_nonneg (by norm_num)]
    simp only [hA, mem_setOf_eq, this]; norm_num
  have hn38 : ‖(3 / 8 : ℂ)‖ = 3 / 8 := by
    rw [show (3 / 8 : ℂ) = ((3 / 8 : ℝ) : ℂ) by push_cast; ring, Complex.norm_real, Real.norm_of_nonneg (by norm_num)]
  -- the tile through `3/8` is the annulus
  have hT : A = connectedComponentIn holedFrag.interiorPts (3 / 8) := by
    apply Set.Subset.antisymm (isPreconnected_holedAnnulus.subset_connectedComponentIn h38 hAint)
    intro z hz
    have hC := isPreconnected_connectedComponentIn (x := (3 / 8 : ℂ)) (F := holedFrag.interiorPts)
    have hCsub := connectedComponentIn_subset holedFrag.interiorPts (3 / 8 : ℂ)
    have hmem := mem_connectedComponentIn (hAint h38)
    have hlo := (norm_side_of_isPreconnected hC le_rfl (a := 1 / 4) (fun w hw => lt_or_gt_of_ne (hint w (hCsub hw)).1)
      hmem).2 (by rw [hn38]; norm_num) z hz
    have hhi := (norm_side_of_isPreconnected hC le_rfl (a := 1 / 2) (fun w hw => lt_or_gt_of_ne (hint w (hCsub hw)).2)
      hmem).1 (by rw [hn38]; norm_num) z hz
    exact ⟨hlo, hhi⟩
  -- the closure of the annulus is the closed annulus
  have hclsub : closure A ⊆ {z : ℂ | 1 / 4 ≤ ‖z‖ ∧ ‖z‖ ≤ 1 / 2} :=
    closure_minimal (fun z hz => ⟨hz.1.le, hz.2.le⟩)
      ((isClosed_le continuous_const continuous_norm).inter (isClosed_le continuous_norm continuous_const))
  have hclsup : ∀ z : ℂ, 1 / 4 ≤ ‖z‖ → ‖z‖ ≤ 1 / 2 → z ∈ closure A := by
    intro z h1 h2
    rw [Metric.mem_closure_iff]
    intro ε hε
    set s := min 1 ε with hs
    have hs0 : 0 < s := lt_min one_pos hε
    have hs1 : s ≤ 1 := min_le_left _ _
    have hsε : s ≤ ε := min_le_right _ _
    have hz0 : 0 < ‖z‖ := by linarith
    set c : ℝ := 1 - s + 3 * s / (8 * ‖z‖) with hc
    have hc0 : 0 < c := by
      have : 0 < 3 * s / (8 * ‖z‖) := by positivity
      rw [hc]; linarith
    have hnb : ‖(c : ℂ) * z‖ = (1 - s) * ‖z‖ + 3 * s / 8 := by
      rw [norm_mul, Complex.norm_real, Real.norm_of_nonneg hc0.le, hc]; field_simp
    refine ⟨(c : ℂ) * z, ⟨?_, ?_⟩, ?_⟩
    · rw [hnb]; nlinarith
    · rw [hnb]; nlinarith
    · have : dist z ((c : ℂ) * z) = |1 - c| * ‖z‖ := by
        rw [dist_eq_norm, show z - (c : ℂ) * z = ((1 - c : ℝ) : ℂ) * z by push_cast; ring, norm_mul, Complex.norm_real,
          Real.norm_eq_abs]
      have h8 : (1 - c) * ‖z‖ = s * (‖z‖ - 3 / 8) := by rw [hc]; field_simp; ring
      rw [this, show |1 - c| * ‖z‖ = |(1 - c) * ‖z‖| by rw [abs_mul, abs_of_pos hz0], h8, abs_mul, abs_of_pos hs0]
      have hab : |‖z‖ - 3 / 8| ≤ 1 / 8 := abs_le.mpr ⟨by linarith, by linarith⟩
      nlinarith [abs_nonneg (‖z‖ - 3 / 8)]
  -- the complement of the closed annulus, and its components
  have havoid : ∀ z ∈ (closure A)ᶜ, ‖z‖ < 1 / 4 ∨ 1 / 2 < ‖z‖ := by
    intro z hz
    by_contra h
    push Not at h
    exact hz (hclsup z h.1 h.2)
  have hside : ∀ z ∈ (closure A)ᶜ, (‖z‖ < 1 / 4 → connectedComponentIn (closure A)ᶜ z ⊆ ball 0 (1 / 4)) ∧
      (1 / 2 < ‖z‖ → connectedComponentIn (closure A)ᶜ z ⊆ {w | 1 / 2 < ‖w‖}) := by
    intro z hz
    have hsub := connectedComponentIn_subset (closure A)ᶜ z
    obtain ⟨h1, h2⟩ := norm_side_of_isPreconnected isPreconnected_connectedComponentIn (by norm_num : (1 / 4 : ℝ) ≤ 1 / 2)
      (fun w hw => havoid w (hsub hw)) (mem_connectedComponentIn hz)
    exact ⟨fun h w hw => by rw [mem_ball, dist_zero_right]; exact h1 h w hw, fun h w hw => h2 h w hw⟩
  have h0 : (0 : ℂ) ∈ (closure A)ᶜ := fun h => by have := (hclsub h).1; simp at this; linarith
  have hHc := (hside 0 h0).1 (by simp)
  -- the disc `|z| < 1/4` lies in the hole (preconnected, off `cl A`, through `0`)
  have hball : ball (0 : ℂ) (1 / 4) ⊆ connectedComponentIn (closure A)ᶜ 0 :=
    (convex_ball (0 : ℂ) (1 / 4)).isPreconnected.subset_connectedComponentIn (mem_ball_self (by norm_num))
      (fun w hw hwA => by
        have := (hclsub hwA).1
        rw [mem_ball, dist_zero_right] at hw
        linarith)
  -- the rest of the complement lies beyond `1/2`
  have hrest : (closure A)ᶜ \ connectedComponentIn (closure A)ᶜ 0 ⊆ {w : ℂ | 1 / 2 < ‖w‖} := by
    rintro w ⟨hw, hwn⟩
    rcases havoid w hw with h | h
    · exact absurd (hball (by rw [mem_ball, dist_zero_right]; exact h)) hwn
    · exact h
  refine ⟨holedFrag, holedFrag_valid, fun z hz => ?_, A, connectedComponentIn (closure A)ᶜ 0, ⟨3 / 8, hAint h38, hT⟩,
    ⟨0, mem_connectedComponentIn h0⟩, connectedComponentIn_subset _ _, Metric.isBounded_ball.subset hHc, ?_⟩
  · show z ∈ ball (0 : ℂ) (3 / 5)
    rw [mem_closedBall] at hz; rw [mem_ball]; linarith
  · have hc1 : closure (connectedComponentIn (closure A)ᶜ 0) ⊆ closedBall 0 (1 / 4) :=
      (closure_mono hHc).trans (closure_ball_subset_closedBall)
    have hc2 : closure ((closure A)ᶜ \ connectedComponentIn (closure A)ᶜ 0) ⊆ {w : ℂ | 1 / 2 ≤ ‖w‖} :=
      closure_minimal (fun w hw => show 1 / 2 ≤ ‖w‖ from (show 1 / 2 < ‖w‖ from hrest hw).le)
        (isClosed_le continuous_const continuous_norm)
    refine Set.disjoint_left.mpr fun w hw1 hw2 => ?_
    have := hc1 hw1
    have := hc2 hw2
    simp only [mem_closedBall, dist_zero_right, mem_setOf_eq] at *
    linarith

end HadwigerNelson.Plane
