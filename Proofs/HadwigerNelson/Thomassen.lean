import Mathlib.Combinatorics.SimpleGraph.Paths
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Connected
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Subgraph
import Mathlib.Combinatorics.SimpleGraph.Metric
import Mathlib.Combinatorics.Enumerative.DoubleCounting
import Mathlib.Tactic.NormNum

/-!
# Thomassen's reduction, as pure graph theory

`[Thomassen1999]` pp. 850–852 over Mathlib's `SimpleGraph`, with no geometry (moved verbatim from `Plane/ValidMap/MapGraph`, job FS131-IT1):

* `LocallyHamiltonian G` — p. 850: "for each `x` in `V(G)`, `G` has a cycle with vertex set `D₁(x)`";
* `lemma1` — Thomassen's Lemma 1 (p. 850): a connected, locally finite, locally Hamiltonian graph with at least `13` vertices has a vertex of
  degree at least `6`;
* `twoSepInterior G x y` — CVB's `int(M, x, y)` (FS114-CVB B2 step 2): the vertices of the finite components of `G − x − y`; `IsTwoSep`,
  `IsMaximalTwoSep`, `reducedVerts`, `reduced` — `H`, the graph with every maximal 2-separator's interior deleted;
* `IsRing`, `TwiceApart`, `PlanarLike` — the planar properties the reduction reads (FS131-KP plan § 4), and `reduced_props_of_planarLike`, the reduction;
* `triLattice` — the triangular lattice, the model of `lemma1`'s hypotheses.

The map side (`ArcMap.filledGraph_planarLike`, `ArcMap.cvb_thom_reduced`) stays in `Plane/ValidMap/MapGraph`.
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

/-- **The planar properties Thomassen's reduction reads** (FS131-KP plan § 4; CVB B2 steps 1–3; `finSep` added by ruling, inventory items
308–309): locally finite, connected, infinite; a ring at every vertex, with `G − x − y` connected unless `y` appears twice apart in `x`'s ring;
for every pair exactly one infinite component of `G − x − y` (CVB step 2: "the complement of the compact connected `cl x̂ ∪ cl ŷ` has one
unbounded component and every other component of `M − x − y` is finite"); and every vertex in the interior of finitely many pairs (on a map:
the tiles have diameter at most `1`, so a pair whose interior holds a tile lies near it). Without `finSep` the reduction fails: in the strong
product of a ray with an edge, every other field holds, the levels are 2-separators nesting forever, none is maximal, and `H = G` is not locally
Hamiltonian (FS131-IT1). The filled map graph of a valid plane map has them (`ArcMap.filledGraph_planarLike`); the reduction is
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
  /-- Every vertex lies in the interior of finitely many pairs (read by the maximal 2-separator above a 2-separator). -/
  finSep : ∀ v, {p : V × V | v ∈ twoSepInterior G p.1 p.2}.Finite

section Reduction

/-! ## Reachability inside a vertex set -/

/-- `a` reaches `b` by a walk of `G` whose vertices all lie in `S`. -/
def ReachIn (S : Set V) (a b : V) : Prop := ∃ p : G.Walk a b, ∀ v ∈ p.support, v ∈ S

variable {G}

/-- A vertex of `S` reaches itself inside `S`. -/
theorem ReachIn.refl {S : Set V} {a : V} (ha : a ∈ S) : ReachIn G S a a := ⟨.nil, by simpa using ha⟩

/-- Reaching inside `S` is symmetric. -/
theorem ReachIn.symm {S : Set V} {a b : V} (h : ReachIn G S a b) : ReachIn G S b a := by
  obtain ⟨p, hp⟩ := h
  exact ⟨p.reverse, fun v hv => hp v (by simpa using hv)⟩

/-- Reaching inside `S` is transitive. -/
theorem ReachIn.trans {S : Set V} {a b c : V} (h₁ : ReachIn G S a b) (h₂ : ReachIn G S b c) : ReachIn G S a c := by
  obtain ⟨p, hp⟩ := h₁
  obtain ⟨q, hq⟩ := h₂
  refine ⟨p.append q, fun v hv => ?_⟩
  rw [SimpleGraph.Walk.mem_support_append_iff] at hv
  rcases hv with hv | hv
  · exact hp v hv
  · exact hq v hv

/-- Adjacent vertices of `S` reach each other inside `S`. -/
theorem ReachIn.of_adj {S : Set V} {a b : V} (ha : a ∈ S) (hb : b ∈ S) (hab : G.Adj a b) : ReachIn G S a b :=
  ⟨.cons hab .nil, fun v hv => by
    simp only [SimpleGraph.Walk.support_cons, SimpleGraph.Walk.support_nil, List.mem_cons, List.not_mem_nil,
      or_false] at hv
    rcases hv with rfl | rfl <;> assumption⟩

/-- Reaching inside `S` is reaching inside any larger set. -/
theorem ReachIn.mono {S T : Set V} (hST : S ⊆ T) {a b : V} (h : ReachIn G S a b) : ReachIn G T a b := by
  obtain ⟨p, hp⟩ := h
  exact ⟨p, fun v hv => hST (hp v hv)⟩

/-- The start of a walk inside `S` is in `S`. -/
theorem ReachIn.left_mem {S : Set V} {a b : V} (h : ReachIn G S a b) : a ∈ S := by
  obtain ⟨p, hp⟩ := h
  exact hp a p.start_mem_support

/-- The end of a walk inside `S` is in `S`. -/
theorem ReachIn.right_mem {S : Set V} {a b : V} (h : ReachIn G S a b) : b ∈ S := by
  obtain ⟨p, hp⟩ := h
  exact hp b p.end_mem_support

/-- Every vertex of a walk inside `S` is reached inside `S` from the walk's start. -/
theorem reachIn_of_mem_support {S : Set V} {a b : V} (p : G.Walk a b) (hp : ∀ v ∈ p.support, v ∈ S) :
    ∀ v ∈ p.support, ReachIn G S a v := by
  induction p with
  | nil => intro v hv; simp only [SimpleGraph.Walk.support_nil, List.mem_singleton] at hv; subst hv
           exact ReachIn.refl (hp _ (by simp))
  | cons hadj q ih =>
    intro v hv
    simp only [SimpleGraph.Walk.support_cons, List.mem_cons] at hv
    have hq : ∀ v ∈ q.support, v ∈ S := fun v hv => hp v (by simp [hv])
    rcases hv with rfl | hv
    · exact ReachIn.refl (hp _ (by simp))
    · exact (ReachIn.of_adj (hp _ (by simp)) (hq _ q.start_mem_support) hadj).trans (ih hq v hv)

/-- A set closed under adjacency inside `S` contains everything reached inside `S` from its points. -/
theorem mem_of_reachIn_of_closed {S C : Set V} (hC : ∀ v w, v ∈ C → w ∈ S → G.Adj v w → w ∈ C) {a b : V} (ha : a ∈ C)
    (h : ReachIn G S a b) : b ∈ C := by
  obtain ⟨p, hp⟩ := h
  induction p with
  | nil => exact ha
  | cons hadj q ih =>
    exact ih (hC _ _ ha (hp _ (by simp)) hadj) (fun v hv => hp v (by simp [hv]))

/-- A walk from inside `S` to outside leaves `S` along an edge: some vertex reached inside `S` is adjacent to a vertex of
the walk outside `S`. -/
theorem exists_exit {S : Set V} {a b : V} (p : G.Walk a b) (ha : a ∈ S) (hb : b ∉ S) :
    ∃ z w, ReachIn G S a z ∧ G.Adj z w ∧ w ∉ S ∧ w ∈ p.support := by
  induction p with
  | nil => exact absurd ha hb
  | @cons u u' _ hadj q ih =>
    by_cases hu' : u' ∈ S
    · obtain ⟨z, w, hz, hzw, hw, hwq⟩ := ih hu' hb
      exact ⟨z, w, (ReachIn.of_adj ha hu' hadj).trans hz, hzw, hw, by simp [hwq]⟩
    · exact ⟨u, u', ReachIn.refl ha, hadj, hu', by simp⟩

/-- Reachability in the induced graph is reachability inside the set. -/
theorem reachable_induce_iff {S : Set V} {a b : V} (ha : a ∈ S) (hb : b ∈ S) :
    (G.induce S).Reachable ⟨a, ha⟩ ⟨b, hb⟩ ↔ ReachIn G S a b := by
  constructor
  · rintro ⟨p⟩
    have key : ∀ (u w : S) (q : (G.induce S).Walk u w), ReachIn G S u w := by
      intro u w q
      induction q with
      | nil => exact ReachIn.refl (Subtype.prop _)
      | cons h q ih => exact (ReachIn.of_adj (Subtype.prop _) (Subtype.prop _) (SimpleGraph.induce_adj.mp h)).trans ih
    exact key _ _ p
  · rintro ⟨p, hp⟩
    exact ⟨p.induce S hp⟩

/-- The component of `a` inside `S`, as a set of vertices. -/
def compIn (S : Set V) (a : V) : Set V := {b | ReachIn G S a b}

/-- Vertices reaching each other inside `S` have the same component inside `S`. -/
theorem compIn_eq_of_reachIn {S : Set V} {a b : V} (h : ReachIn G S a b) : compIn (G := G) S a = compIn (G := G) S b := by
  ext c; exact ⟨fun hc => h.symm.trans hc, fun hc => h.trans hc⟩

/-- A component of the induced graph is finite exactly when the component inside the set is. -/
theorem supp_finite_iff {S : Set V} {a : V} (ha : a ∈ S) :
    ((G.induce S).connectedComponentMk ⟨a, ha⟩).supp.Finite ↔ (compIn (G := G) S a).Finite := by
  have hsupp : Subtype.val '' ((G.induce S).connectedComponentMk ⟨a, ha⟩).supp = compIn (G := G) S a := by
    ext b
    simp only [Set.mem_image, SimpleGraph.ConnectedComponent.mem_supp_iff, SimpleGraph.ConnectedComponent.eq, compIn,
      Set.mem_setOf_eq]
    constructor
    · rintro ⟨⟨b, hb⟩, hr, rfl⟩
      exact (reachable_induce_iff hb ha).mp hr |>.symm
    · intro h
      exact ⟨⟨b, h.right_mem⟩, (reachable_induce_iff _ _).mpr h.symm, rfl⟩
  rw [← hsupp]
  exact ⟨fun h => h.image _, fun h => h.of_finite_image Subtype.val_injective.injOn⟩

/-- `int(x, y)` read through `compIn`: the vertices off `x` and `y` whose component in `G − x − y` is finite. -/
theorem mem_twoSepInterior_iff {x y v : V} :
    v ∈ twoSepInterior G x y ↔ v ∈ offTwo x y ∧ (compIn (G := G) (offTwo x y) v).Finite := by
  constructor
  · rintro ⟨hv, hf⟩; exact ⟨hv, (supp_finite_iff hv).mp hf⟩
  · rintro ⟨hv, hf⟩; exact ⟨hv, (supp_finite_iff hv).mpr hf⟩

/-- The induced graph on `S` is connected exactly when `S` is nonempty and any two of its vertices reach each other inside `S`. -/
theorem connected_induce_iff' {S : Set V} :
    (G.induce S).Connected ↔ S.Nonempty ∧ ∀ a b, a ∈ S → b ∈ S → ReachIn G S a b := by
  rw [SimpleGraph.connected_iff]
  constructor
  · rintro ⟨hp, ⟨⟨a, ha⟩⟩⟩
    exact ⟨⟨a, ha⟩, fun a b ha hb => (reachable_induce_iff ha hb).mp (hp _ _)⟩
  · rintro ⟨⟨a, ha⟩, h⟩
    exact ⟨fun a b => (reachable_induce_iff a.2 b.2).mpr (h a.1 b.1 a.2 b.2), ⟨⟨a, ha⟩⟩⟩

end Reduction

/-- **Thomassen's reduction, as pure graph theory** (`[Thomassen1999]` pp. 851–852 with CVB B2 step 3's replacement of the count by
finiteness): for a graph with the planar properties, `H = reduced G` is connected, locally finite, locally Hamiltonian and infinite. The
proof (FS131-IT1, over FS131-KP plan § 4's route, with `finSep`): no cut vertex (the rings' consecutive clause); every 2-separator an edge (the
rings' second part); every component of `G − x − y` adjacent to both `x` and `y`; interiors nest (Thomassen: "`int(M, x, y) ⊆ int(M, u, v)`"
when `x` lies in `int(M, u, v)`; `oneInf`'s existence half); a vertex lies in the interior of at most one maximal pair; above every 2-separator a
maximal one (`finSep`: of the finitely many pairs whose interior holds a fixed interior vertex, one of largest interior); `H` connected (each
interior vertex sent to an end of its maximal pair), locally finite (an induced subgraph), infinite (a finite `H` has finitely many pairs, each
with a finite interior); locally Hamiltonian (each entry of `x`'s ring sent to the vertex of `H` it stands for — itself, or the unique `y` in `H`
with the entry in `int(x, y)`; the image has consecutive entries equal or adjacent, no interleaving value by the rings' separation and
`oneInf`'s uniqueness half, and at least three values, and its runs collapse to a cycle on `x`'s neighbourhood in `H`). -/
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

/-! ## The inhabitant: the triangular lattice has the planar properties -/

/-- In the triangular lattice `G − x − y` is connected, for every pair: every vertex off `x` and `y` climbs a column free of both (its own,
or one beside it) to a row above both, and that row is a path. -/
theorem triLattice_reachIn {x y a b : ℤ × ℤ} (ha : a ∈ offTwo x y) (hb : b ∈ offTwo x y) :
    ReachIn triLattice (offTwo x y) a b := by
  set b₀ : ℤ := max x.2 y.2 + 1 with hb₀
  have hR : ∀ p : ℤ × ℤ, triLattice.Adj p (p.1 + 1, p.2) := fun p => triLattice_adj.mpr (by simp)
  have hU : ∀ p : ℤ × ℤ, triLattice.Adj p (p.1, p.2 + 1) := fun p => triLattice_adj.mpr (by simp)
  have hUL : ∀ p : ℤ × ℤ, triLattice.Adj p (p.1 - 1, p.2 + 1) := fun p => triLattice_adj.mpr (by simp)
  have hrowS : ∀ c : ℤ, (c, b₀) ∈ offTwo x y := fun c =>
    ⟨fun h => by have := congrArg Prod.snd h; simp only at this; omega,
     fun h => by have := congrArg Prod.snd h; simp only at this; omega⟩
  -- the row `b₀` is a path off `x` and `y`
  have hrow : ∀ c : ℤ, ReachIn triLattice (offTwo x y) (0, b₀) (c, b₀) := by
    intro c
    induction c using Int.induction_on with
    | zero => exact ReachIn.refl (hrowS 0)
    | succ n ih => exact ih.trans (ReachIn.of_adj (hrowS _) (hrowS _) (hR (n, b₀)))
    | pred n ih =>
      refine ih.trans (ReachIn.of_adj (hrowS _) (hrowS _) ?_)
      have := hR (-(n : ℤ) - 1, b₀)
      simp only [sub_add_cancel] at this
      exact this.symm
  -- a column free of `x` and `y` is a path off them, reaching the row
  have hcol : ∀ c : ℤ, c ≠ x.1 → c ≠ y.1 → ∀ k : ℤ, ReachIn triLattice (offTwo x y) (c, b₀) (c, k) := by
    intro c hcx hcy k
    have hS : ∀ k : ℤ, (c, k) ∈ offTwo x y := fun k =>
      ⟨fun h => hcx (congrArg Prod.fst h), fun h => hcy (congrArg Prod.fst h)⟩
    induction k using Int.inductionOn' (b := b₀) with
    | zero => exact ReachIn.refl (hS _)
    | succ k _ ih => exact ih.trans (ReachIn.of_adj (hS _) (hS _) (hU (c, k)))
    | pred k _ ih =>
      refine ih.trans (ReachIn.of_adj (hS _) (hS _) ?_)
      have := hU (c, k - 1)
      simp only [sub_add_cancel] at this
      exact this.symm
  -- every vertex off `x` and `y` reaches the base point
  have hbase : ∀ v, v ∈ offTwo x y → ReachIn triLattice (offTwo x y) (0, b₀) v := by
    intro v hv
    by_cases hfree : v.1 ≠ x.1 ∧ v.1 ≠ y.1
    · exact (hrow v.1).trans (hcol v.1 hfree.1 hfree.2 v.2)
    · by_cases hfree' : v.1 + 1 ≠ x.1 ∧ v.1 + 1 ≠ y.1
      · have hS' : (v.1 + 1, v.2) ∈ offTwo x y :=
          ⟨fun h => hfree'.1 (congrArg Prod.fst h), fun h => hfree'.2 (congrArg Prod.fst h)⟩
        exact (hrow _).trans ((hcol _ hfree'.1 hfree'.2 v.2).trans (ReachIn.of_adj hS' hv (hR v).symm))
      · have hfree'' : v.1 - 1 ≠ x.1 ∧ v.1 - 1 ≠ y.1 := by
          constructor <;> omega
        have hS' : (v.1 - 1, v.2 + 1) ∈ offTwo x y :=
          ⟨fun h => hfree''.1 (congrArg Prod.fst h), fun h => hfree''.2 (congrArg Prod.fst h)⟩
        exact (hrow _).trans ((hcol _ hfree''.1 hfree''.2 (v.2 + 1)).trans (ReachIn.of_adj hS' hv (hUL v).symm))
  exact (hbase a ha).symm.trans (hbase b hb)

theorem triLattice_offTwo_infinite (x y : ℤ × ℤ) : (offTwo x y).Infinite := by
  have hS : offTwo x y = ({x, y} : Set (ℤ × ℤ))ᶜ := by ext v; simp [offTwo]
  rw [hS]
  exact (Set.toFinite _).infinite_compl

/-- The triangular lattice has no 2-separator: every interior is empty. -/
theorem triLattice_twoSepInterior (x y : ℤ × ℤ) : twoSepInterior triLattice x y = ∅ := by
  ext v
  simp only [Set.mem_empty_iff_false, iff_false]
  intro hv
  obtain ⟨hvS, hf⟩ := mem_twoSepInterior_iff.mp hv
  exact triLattice_offTwo_infinite x y (hf.subset fun b hb => triLattice_reachIn hvS hb)

/-- The ring of the triangular lattice at `x`: its hexagon, in order. -/
def triRing (x : ℤ × ℤ) : List (ℤ × ℤ) :=
  [(x.1 + 1, x.2), (x.1, x.2 + 1), (x.1 - 1, x.2 + 1), (x.1 - 1, x.2), (x.1, x.2 - 1), (x.1 + 1, x.2 - 1)]

theorem triRing_isRing (x : ℤ × ℤ) : IsRing triLattice x (triRing x) := by
  refine ⟨fun y => ?_, fun i a b ha hb => ?_, fun y i j hij hi hj => ?_⟩
  · simp only [triRing, List.mem_cons, List.not_mem_nil, or_false, triLattice_adj, Prod.ext_iff]
    omega
  · simp only [triRing, List.length_cons, List.length_nil] at hb
    right
    rcases i with _ | _ | _ | _ | _ | _ | i <;>
      simp only [triRing, List.getElem?_cons_succ, List.getElem?_cons_zero, Option.some.injEq, Nat.reduceAdd,
        Nat.reduceMod, List.getElem?_nil] at ha hb <;> (try simp at ha) <;> subst ha <;> subst hb <;>
      simp only [triLattice_adj] <;> omega
  · exfalso
    have hnd : (triRing x).Nodup := by
      simp [triRing, Prod.ext_iff]
      omega
    exact List.nodup_iff_getElem?_ne_getElem?.mp hnd i j hij
      (List.getElem?_eq_some_iff.mp hj).1 (hi.trans hj.symm)

/-- **The inhabitant of `PlanarLike`**: the triangular lattice (rings its hexagons, no repeats; `G − x − y` always connected, so one
infinite component and no 2-separator). Every field is exercised: the rings and `oneInf` at every vertex and pair, `finSep` with every
interior empty. -/
theorem triLattice_planarLike : PlanarLike triLattice where
  locFin := triLattice_hyps.1
  conn := triLattice_hyps.2.1
  inf := inferInstance
  ring x := ⟨triRing x, triRing_isRing x, fun y _ _ => connected_induce_iff'.mpr
    ⟨⟨(max x.1 y.1 + 1, 0), fun h => by have := congrArg Prod.fst h; simp only at this; omega,
      fun h => by have := congrArg Prod.fst h; simp only at this; omega⟩,
     fun _ _ ha hb => triLattice_reachIn ha hb⟩⟩
  oneInf x y _ := by
    obtain ⟨v₀, hv₀⟩ := (triLattice_offTwo_infinite x y).nonempty
    refine ⟨(triLattice.induce (offTwo x y)).connectedComponentMk ⟨v₀, hv₀⟩, fun hf => ?_, fun c' _ => ?_⟩
    · rw [supp_finite_iff hv₀] at hf
      exact triLattice_offTwo_infinite x y (hf.subset fun b hb => triLattice_reachIn hv₀ hb)
    · obtain ⟨⟨v, hv⟩, rfl⟩ := c'.exists_rep
      exact SimpleGraph.ConnectedComponent.sound ((reachable_induce_iff hv hv₀).mpr (triLattice_reachIn hv hv₀))
  finSep v := by
    simp only [triLattice_twoSepInterior, Set.mem_empty_iff_false, Set.setOf_false, Set.finite_empty]

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

/-- A spec example for `ReachIn`: in the triangular lattice `(2, 0)` reaches `(-1, 0)` off `(0, 0)` and `(1, 0)`, and nothing reaches inside a
set from outside it. -/
example : ReachIn triLattice (offTwo (0, 0) (1, 0)) (2, 0) (-1, 0) ∧ ¬ ReachIn triLattice {v | v ≠ (0, 0)} (0, 0) (1, 0) :=
  ⟨triLattice_reachIn (by simp [offTwo]) (by simp [offTwo]), fun h => h.left_mem rfl⟩

/-- A spec example for `compIn`: in the triangular lattice the component of `(5, 5)` off `(0, 0)` and `(1, 0)` is everything off them. -/
example : compIn (G := triLattice) (offTwo (0, 0) (1, 0)) (5, 5) = offTwo (0, 0) (1, 0) := by
  ext b
  exact ⟨fun hb => hb.right_mem, fun hb => triLattice_reachIn (by simp [offTwo]) hb⟩

/-- A spec example for `triRing`: the hexagon at the origin, in order. -/
example : triRing (0, 0) = [(1, 0), (0, 1), (-1, 1), (-1, 0), (0, -1), (1, -1)] := by decide

end HadwigerNelson.Thomassen
