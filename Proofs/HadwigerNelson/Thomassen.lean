import Mathlib.Combinatorics.SimpleGraph.Paths
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Connected
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Subgraph
import Mathlib.Combinatorics.SimpleGraph.Metric
import Mathlib.Combinatorics.Enumerative.DoubleCounting
import Mathlib.Tactic.NormNum
import Mathlib.Data.List.NodupEquivFin

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
Hamiltonian (`ladder_adversary`, FS131-IT1). The filled map graph of a valid plane map has them (`ArcMap.filledGraph_planarLike`); the reduction is
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


/-! ## Cyclic sequences: collapsing runs to a cycle -/

/-- No value `y` interleaves with two other values: there are no positions `i < m < j` and `n` outside `[i, j]` with `y` at `i`
and `j` and values other than `y` at `m` and `n`. -/
def NoInterleave {W : Type*} (s : List W) : Prop :=
  ∀ (y a b : W) (i m j n : ℕ), i < m → m < j → (n < i ∨ j < n) → s[i]? = some y → s[m]? = some a → s[j]? = some y →
    s[n]? = some b → a = y ∨ b = y

/-- A sublist of a sequence with no interleaving value has none. -/
theorem NoInterleave.sublist {W : Type*} {s u : List W} (hs : NoInterleave s) (hu : List.Sublist u s) : NoInterleave u := by
  obtain ⟨f, hf⟩ := List.sublist_iff_exists_orderEmbedding_getElem?_eq.mp hu
  intro y a b i m j n him hmj hn hi hm hj hn'
  rw [hf] at hi hm hj hn'
  refine hs y a b (f i) (f m) (f j) (f n) (f.strictMono him) (f.strictMono hmj) ?_ hi hm hj hn'
  rcases hn with hn | hn
  · exact Or.inl (f.strictMono hn)
  · exact Or.inr (f.strictMono hn)

/-- Collapse each run of equal consecutive entries to one entry (the run's last). -/
def collapse {W : Type*} [DecidableEq W] : List W → List W
  | [] => []
  | [a] => [a]
  | a :: b :: l => if a = b then collapse (b :: l) else a :: collapse (b :: l)

section Collapse

variable {W : Type*} [DecidableEq W]

/-- `collapse l` is a sublist of `l`. -/
theorem collapse_sublist : ∀ l : List W, List.Sublist (collapse l) l
  | [] => by simp [collapse]
  | [a] => by simp [collapse]
  | a :: b :: l => by
    unfold collapse
    split_ifs
    · exact (collapse_sublist (b :: l)).cons a
    · exact (collapse_sublist (b :: l)).cons_cons a

/-- `collapse` keeps every value. -/
theorem mem_collapse : ∀ (l : List W) (y : W), y ∈ collapse l ↔ y ∈ l
  | [] => by simp [collapse]
  | [a] => by simp [collapse]
  | a :: b :: l => by
    intro y
    unfold collapse
    split_ifs with hab
    · subst hab; rw [mem_collapse (a :: l) y]; simp
    · rw [List.mem_cons, mem_collapse (b :: l) y]; simp

/-- `collapse` keeps the first entry. -/
theorem head?_collapse : ∀ l : List W, (collapse l).head? = l.head?
  | [] => by simp [collapse]
  | [a] => by simp [collapse]
  | a :: b :: l => by
    unfold collapse
    split_ifs with hab
    · subst hab; rw [head?_collapse (a :: l)]; simp
    · simp

/-- `collapse` keeps the last entry. -/
theorem getLast?_collapse : ∀ l : List W, (collapse l).getLast? = l.getLast?
  | [] => by simp [collapse]
  | [a] => by simp [collapse]
  | a :: b :: l => by
    unfold collapse
    split_ifs with hab
    · rw [getLast?_collapse (b :: l)]; simp
    · have hh := head?_collapse (b :: l)
      have hl := getLast?_collapse (b :: l)
      cases hc : collapse (b :: l) with
      | nil => rw [hc] at hh; simp at hh
      | cons c t => rw [hc] at hl; rw [List.getLast?_cons_cons, hl, List.getLast?_cons_cons]

/-- Consecutive entries equal or `R`-related become distinct and `R`-related. -/
theorem isChain_collapse {R : W → W → Prop} :
    ∀ l : List W, l.IsChain (fun a b => a = b ∨ R a b) → (collapse l).IsChain (fun a b => a ≠ b ∧ R a b)
  | [] => by simp [collapse]
  | [a] => by simp [collapse]
  | a :: b :: l => by
    intro hl
    rw [List.isChain_cons_cons] at hl
    unfold collapse
    split_ifs with hab
    · exact isChain_collapse (b :: l) hl.2
    · have ih := isChain_collapse (b :: l) hl.2
      have hhead := head?_collapse (b :: l)
      cases hc : collapse (b :: l) with
      | nil => simp
      | cons c t =>
        rw [hc] at ih hhead
        simp only [List.head?_cons, Option.some.injEq] at hhead
        subst hhead
        rw [List.isChain_cons_cons]
        exact ⟨⟨hab, hl.1.resolve_left hab⟩, ih⟩

end Collapse

/-- A nonempty chain of distinct adjacent entries, closing up (the last adjacent to the first), with no value interleaving and at least three
distinct values, is a cycle. -/
theorem exists_cycle_of_chain {W : Type*} (H : SimpleGraph W) (u : List W) (hne : u ≠ [])
    (hc : u.IsChain (fun a b => a ≠ b ∧ H.Adj a b)) (hw : H.Adj (u.getLast hne) (u.head hne)) (hni : NoInterleave u)
    (h3 : ∃ a b c, a ∈ u ∧ b ∈ u ∧ c ∈ u ∧ a ≠ b ∧ a ≠ c ∧ b ≠ c) :
    ∃ (a : W) (p : H.Walk a a), p.IsCycle ∧ ∀ y, y ∈ p.support ↔ y ∈ u := by
  classical
  have hlen : 0 < u.length := List.length_pos_of_ne_nil hne
  -- no repetition
  have hnd : u.Nodup := by
    rw [List.nodup_iff_getElem?_ne_getElem?]
    intro i j hij hj heq
    have hi : i < u.length := by omega
    have hy : u[i]? = some u[i] := List.getElem?_eq_getElem hi
    have hyj : u[j]? = some u[i] := heq ▸ hy
    have hi1 : i + 1 < u.length := by omega
    have hadj1 := List.isChain_iff_getElem.mp hc i hi1
    have hm : i + 1 < j := by
      by_contra hcon
      have hji : j = i + 1 := by omega
      subst hji
      rw [List.getElem?_eq_getElem hi1, Option.some.injEq] at hyj
      exact hadj1.1 hyj.symm
    rcases Nat.eq_zero_or_pos i with hi0 | hi0
    · subst hi0
      have hjl : j < u.length - 1 := by
        by_contra hcon
        have hjl : j = u.length - 1 := by omega
        subst hjl
        rw [List.getElem?_eq_getElem hj, Option.some.injEq] at hyj
        apply hw.ne
        rw [List.getLast_eq_getElem, List.head_eq_getElem, hyj]
      rcases hni u[0] u[1] u[u.length - 1] 0 1 j (u.length - 1) (by omega) hm (Or.inr hjl) hy
          (List.getElem?_eq_getElem hi1) hyj (List.getElem?_eq_getElem (by omega)) with h' | h'
      · exact hadj1.1 h'.symm
      · apply hw.ne
        rw [List.getLast_eq_getElem, List.head_eq_getElem, h']
    · have hprev := List.isChain_iff_getElem.mp hc (i - 1) (by omega)
      have hii : i - 1 + 1 = i := by omega
      simp only [hii] at hprev
      rcases hni u[i] u[i + 1] u[i - 1] i (i + 1) j (i - 1) (by omega) hm (Or.inl (by omega)) hy
          (List.getElem?_eq_getElem hi1) hyj (List.getElem?_eq_getElem (by omega)) with h' | h'
      · exact hadj1.1 h'.symm
      · exact hprev.1 h'
  -- at least three entries
  have h3' : 3 ≤ u.length := by
    obtain ⟨a, b, c, ha, hb, hc', hab, hac, hbc⟩ := h3
    have hsub : ({a, b, c} : Finset W) ⊆ u.toFinset := by
      intro z hz; simp only [Finset.mem_insert, Finset.mem_singleton] at hz
      rw [List.mem_toFinset]; rcases hz with rfl | rfl | rfl <;> assumption
    have := Finset.card_le_card hsub
    rw [List.toFinset_card_of_nodup hnd, Finset.card_insert_of_notMem (by simp [hab, hac]),
      Finset.card_insert_of_notMem (by simp [hbc]), Finset.card_singleton] at this
    omega
  -- the cycle: the path along `u`, closed by the edge from its last entry to its first
  let p := SimpleGraph.Walk.ofSupport u hne (hc.imp fun _ _ h => h.2)
  have hpath : p.IsPath := by
    rw [SimpleGraph.Walk.isPath_def, SimpleGraph.Walk.support_ofSupport]; exact hnd
  refine ⟨u.getLast hne, .cons hw p, ?_, ?_⟩
  · rw [SimpleGraph.Walk.cons_isCycle_iff]
    refine ⟨hpath, fun he => ?_⟩
    rw [Sym2.eq_swap] at he
    have := hpath.length_eq_one_of_mem_edges he
    rw [SimpleGraph.Walk.length_ofSupport] at this
    omega
  · intro y
    rw [SimpleGraph.Walk.support_cons, SimpleGraph.Walk.support_ofSupport, List.mem_cons]
    constructor
    · rintro (rfl | hy)
      · exact List.getLast_mem hne
      · exact hy
    · exact Or.inr

/-- **A cyclic sequence collapses to a cycle**: consecutive entries (cyclically) equal or adjacent, no value interleaving, at least three
distinct values — then the values are the vertex set of a cycle. -/
theorem exists_cycle_of_cyclic {W : Type*} (H : SimpleGraph W) (s : List W)
    (hchain : ∀ (i : ℕ) (a b : W), s[i]? = some a → s[(i + 1) % s.length]? = some b → a = b ∨ H.Adj a b)
    (hnoint : NoInterleave s) (h3 : ∃ a b c, a ∈ s ∧ b ∈ s ∧ c ∈ s ∧ a ≠ b ∧ a ≠ c ∧ b ≠ c) :
    ∃ (a : W) (p : H.Walk a a), p.IsCycle ∧ ∀ y, y ∈ p.support ↔ y ∈ s := by
  classical
  obtain ⟨a₀, b₀, c₀, ha₀, hb₀, hc₀, hab, hac, hbc⟩ := h3
  have hne : s ≠ [] := List.ne_nil_of_mem ha₀
  have hlen : 0 < s.length := List.length_pos_of_ne_nil hne
  have hlin : s.IsChain (fun a b => a = b ∨ H.Adj a b) := by
    rw [List.isChain_iff_getElem]
    intro i hi
    exact hchain i _ _ (List.getElem?_eq_getElem (by omega))
      (by rw [Nat.mod_eq_of_lt hi]; exact List.getElem?_eq_getElem hi)
  have hwrap : s.getLast hne = s.head hne ∨ H.Adj (s.getLast hne) (s.head hne) := by
    refine hchain (s.length - 1) _ _ ?_ ?_
    · rw [List.getLast_eq_getElem]; exact List.getElem?_eq_getElem _
    · rw [Nat.sub_add_cancel hlen, Nat.mod_self, List.head_eq_getElem]; exact List.getElem?_eq_getElem _
  set t := collapse s with ht
  have htc : t.IsChain (fun a b => a ≠ b ∧ H.Adj a b) := isChain_collapse s hlin
  have htmem : ∀ y, y ∈ t ↔ y ∈ s := mem_collapse s
  have htne : t ≠ [] := fun h' => by simpa [h'] using (htmem a₀).mpr ha₀
  have hthead : t.head htne = s.head hne := by
    have := head?_collapse s
    rw [← ht, List.head?_eq_some_head htne, List.head?_eq_some_head hne] at this
    exact Option.some.inj this
  have htlast : t.getLast htne = s.getLast hne := by
    have := getLast?_collapse s
    rw [← ht, List.getLast?_eq_some_getLast htne, List.getLast?_eq_some_getLast hne] at this
    exact Option.some.inj this
  have htni : NoInterleave t := hnoint.sublist (collapse_sublist s)
  by_cases hhl : t.head htne = t.getLast htne
  · -- drop the head: it is also the last entry
    have httl : t.tail ≠ [] := by
      intro h'
      have hsing : t = [t.head htne] := by
        have := List.cons_head_tail htne
        rw [h'] at this
        exact this.symm
      have ha := (htmem a₀).mpr ha₀
      have hb := (htmem b₀).mpr hb₀
      rw [hsing, List.mem_singleton] at ha hb
      exact hab (ha.trans hb.symm)
    have hmemtl : ∀ y, y ∈ t.tail ↔ y ∈ s := by
      intro y
      rw [← htmem y]
      constructor
      · exact List.mem_of_mem_tail
      · intro hy
        rw [← List.cons_head_tail htne, List.mem_cons] at hy
        rcases hy with rfl | hy
        · rw [hhl, ← List.getLast_tail httl]; exact List.getLast_mem httl
        · exact hy
    have hct : t.tail.IsChain (fun a b => a ≠ b ∧ H.Adj a b) := htc.tail
    have hwt : H.Adj (t.tail.getLast httl) (t.tail.head httl) := by
      rw [List.getLast_tail httl, ← hhl]
      have h01 := htc
      rw [← List.cons_head_tail htne, ← List.cons_head_tail httl, List.isChain_cons_cons] at h01
      exact h01.1.2
    obtain ⟨a, p, hp, hsupp⟩ := exists_cycle_of_chain H t.tail httl hct hwt (htni.sublist (List.tail_sublist t))
      ⟨a₀, b₀, c₀, (hmemtl a₀).mpr ha₀, (hmemtl b₀).mpr hb₀, (hmemtl c₀).mpr hc₀, hab, hac, hbc⟩
    exact ⟨a, p, hp, fun y => (hsupp y).trans (hmemtl y)⟩
  · have hwt : H.Adj (t.getLast htne) (t.head htne) := by
      rcases hwrap with h' | h'
      · exact absurd (by rw [hthead, htlast, h']) hhl
      · rw [hthead, htlast]; exact h'
    obtain ⟨a, p, hp, hsupp⟩ := exists_cycle_of_chain H t htne htc hwt htni
      ⟨a₀, b₀, c₀, (htmem a₀).mpr ha₀, (htmem b₀).mpr hb₀, (htmem c₀).mpr hc₀, hab, hac, hbc⟩
    exact ⟨a, p, hp, fun y => (hsupp y).trans (htmem y)⟩

/-! ## The 2-separators of a graph with the planar properties -/

/-- `offTwo` is symmetric. -/
theorem offTwo_comm (x y : V) : offTwo x y = offTwo y x := by
  ext v; simp only [offTwo, Set.mem_setOf_eq]; exact and_comm

/-- `int(x, y)` is symmetric. -/
theorem twoSepInterior_comm (x y : V) : twoSepInterior G x y = twoSepInterior G y x := by
  ext v; simp only [mem_twoSepInterior_iff, offTwo_comm x y]

/-- `int(x, y)` misses `x` and `y`. -/
theorem twoSepInterior_subset_offTwo (x y : V) : twoSepInterior G x y ⊆ offTwo x y := fun _ hv => hv.1

/-- A vertex reached inside `offTwo x y` from an interior vertex is interior. -/
theorem mem_twoSepInterior_of_reachIn {x y v w : V} (hv : v ∈ twoSepInterior G x y) (hw : ReachIn G (offTwo x y) v w) :
    w ∈ twoSepInterior G x y := by
  obtain ⟨-, hf⟩ := mem_twoSepInterior_iff.mp hv
  exact mem_twoSepInterior_iff.mpr ⟨hw.right_mem, compIn_eq_of_reachIn hw ▸ hf⟩

/-- A neighbour of an interior vertex is interior, or one of the two separating vertices. -/
theorem mem_twoSepInterior_or_of_adj {x y v w : V} (hv : v ∈ twoSepInterior G x y) (hvw : G.Adj v w) :
    w ∈ twoSepInterior G x y ∨ w = x ∨ w = y := by
  by_cases hw : w ∈ offTwo x y
  · exact Or.inl (mem_twoSepInterior_of_reachIn hv (ReachIn.of_adj hv.1 hw hvw))
  · simp only [offTwo, Set.mem_setOf_eq, not_and_or, not_not] at hw
    exact Or.inr hw

section PlanarLike

variable (h : PlanarLike G)
include h

/-- Infinitely many vertices are off any two. -/
theorem PlanarLike.offTwo_infinite (x y : V) : (offTwo x y).Infinite := by
  have hS : offTwo x y = ({x, y} : Set V)ᶜ := by
    ext v; simp [offTwo]
  haveI := h.inf
  rw [hS]
  exact (Set.toFinite _).infinite_compl

/-- Any two neighbours of `x` are joined off `x`: the ring's consecutive entries are equal or adjacent. -/
theorem PlanarLike.reachIn_of_adj_adj {x z₁ z₂ : V} (h₁ : G.Adj x z₁) (h₂ : G.Adj x z₂) :
    ReachIn G {v | v ≠ x} z₁ z₂ := by
  obtain ⟨r, ⟨hmem, hcons, -⟩, -⟩ := h.ring x
  have hne : ∀ z ∈ r, z ∈ {v | v ≠ x} := fun z hz => ((hmem z).mp hz).ne'
  have hlen : 0 < r.length := List.length_pos_of_mem ((hmem z₁).mpr h₁)
  have key : ∀ i (hi : i < r.length), ReachIn G {v | v ≠ x} (r[0]'hlen) (r[i]'hi) := by
    intro i
    induction i with
    | zero => intro _; exact ReachIn.refl (hne _ (List.getElem_mem _))
    | succ i ih =>
      intro hi
      have h' := hcons i r[i] r[i + 1] (List.getElem?_eq_getElem (by omega))
        (by rw [Nat.mod_eq_of_lt hi]; exact List.getElem?_eq_getElem hi)
      refine (ih (by omega)).trans ?_
      rcases h' with h' | h'
      · rw [h']; exact ReachIn.refl (hne _ (List.getElem_mem _))
      · exact ReachIn.of_adj (hne _ (List.getElem_mem _)) (hne _ (List.getElem_mem _)) h'
  obtain ⟨i, hi, rfl⟩ := List.getElem_of_mem ((hmem z₁).mpr h₁)
  obtain ⟨j, hj, rfl⟩ := List.getElem_of_mem ((hmem z₂).mpr h₂)
  exact (key i hi).symm.trans (key j hj)

/-- **No cut vertex**: `G − x` is connected. -/
theorem PlanarLike.reachIn_ne {x a b : V} (ha : a ≠ x) (hb : b ≠ x) : ReachIn G {v | v ≠ x} a b := by
  have hexit : ∀ c, c ≠ x → ∃ z, ReachIn G {v | v ≠ x} c z ∧ G.Adj x z := by
    intro c hc
    obtain ⟨p⟩ := h.conn.preconnected c x
    obtain ⟨z, w, hz, hzw, hw, -⟩ := exists_exit (S := {v | v ≠ x}) p hc (by simp)
    simp only [Set.mem_setOf_eq, not_not] at hw
    subst hw
    exact ⟨z, hz, hzw.symm⟩
  obtain ⟨z₁, hz₁, h₁⟩ := hexit a ha
  obtain ⟨z₂, hz₂, h₂⟩ := hexit b hb
  exact hz₁.trans ((h.reachIn_of_adj_adj h₁ h₂).trans hz₂.symm)

/-- `int(x, x)` is empty: `G − x` is connected and infinite. -/
theorem PlanarLike.twoSepInterior_self (x : V) : twoSepInterior G x x = ∅ := by
  ext v
  simp only [Set.mem_empty_iff_false, iff_false]
  intro hv
  obtain ⟨hvS, hf⟩ := mem_twoSepInterior_iff.mp hv
  refine h.offTwo_infinite x x (hf.subset fun b hb => ?_)
  have hS : {w : V | w ≠ x} = offTwo x x := by ext w; simp [offTwo]
  have := h.reachIn_ne hvS.1 hb.1
  rw [hS] at this
  exact this

/-- A nonempty interior has two distinct ends. -/
theorem PlanarLike.ne_of_mem_twoSepInterior {x y v : V} (hv : v ∈ twoSepInterior G x y) : x ≠ y := by
  rintro rfl; rw [h.twoSepInterior_self] at hv; exact hv

/-- **Every 2-separator is an edge**: a nonempty interior makes `y` appear twice apart in `x`'s ring. -/
theorem PlanarLike.adj_of_mem_twoSepInterior {x y v : V} (hv : v ∈ twoSepInterior G x y) : G.Adj x y := by
  have hxy := h.ne_of_mem_twoSepInterior hv
  obtain ⟨r, ⟨hmem, -, -⟩, hconn⟩ := h.ring x
  by_cases htw : TwiceApart r y
  · obtain ⟨i, -, -, -, hi, -⟩ := htw
    exact (hmem y).mp (List.mem_of_getElem? hi)
  · exfalso
    obtain ⟨-, hall⟩ := connected_induce_iff'.mp (hconn y hxy.symm htw)
    obtain ⟨hvS, hf⟩ := mem_twoSepInterior_iff.mp hv
    exact h.offTwo_infinite x y (hf.subset fun b hb => hall v b hvS hb)

/-- Every component of `G − x − y` is adjacent to `x` (and, by symmetry, to `y`). -/
theorem PlanarLike.exists_adj_left {x y a : V} (hxy : x ≠ y) (ha : a ∈ offTwo x y) :
    ∃ z, ReachIn G (offTwo x y) a z ∧ G.Adj z x := by
  obtain ⟨p, hp⟩ := h.reachIn_ne (x := y) ha.2 hxy
  obtain ⟨z, w, hz, hzw, hw, hwp⟩ := exists_exit (S := offTwo x y) p ha (by simp [offTwo])
  have hwy : w ≠ y := hp w hwp
  have hwx : w = x := by
    by_contra hwx; exact hw ⟨hwx, hwy⟩
  subst hwx
  exact ⟨z, hz, hzw⟩

/-- Every component of `G − x − y` is adjacent to `y`. -/
theorem PlanarLike.exists_adj_right {x y a : V} (hxy : x ≠ y) (ha : a ∈ offTwo x y) :
    ∃ z, ReachIn G (offTwo x y) a z ∧ G.Adj z y := by
  rw [offTwo_comm] at ha ⊢
  exact h.exists_adj_left hxy.symm ha

/-- Interiors are finite. -/
theorem PlanarLike.twoSepInterior_finite (x y : V) : (twoSepInterior G x y).Finite := by
  by_cases hxy : x = y
  · subst hxy; rw [h.twoSepInterior_self]; exact Set.finite_empty
  refine (((h.locFin x).inter_of_left (twoSepInterior G x y)).biUnion
    (t := fun e => compIn (G := G) (offTwo x y) e) fun e he => (mem_twoSepInterior_iff.mp he.2).2).subset ?_
  intro v hv
  obtain ⟨e, hve, hex⟩ := h.exists_adj_left hxy hv.1
  exact Set.mem_biUnion (x := e) ⟨hex.symm, mem_twoSepInterior_of_reachIn hv hve⟩ hve.symm

/-- **Interiors nest** (`[Thomassen1999]` p. 852: "`int(M, x, y) ⊆ int(M, u, v)`"): if `x` lies in the interior of `{u, w}`, every interior
of a pair through `x` lies in it. -/
theorem PlanarLike.twoSepInterior_subset {u w x y : V} (hx : x ∈ twoSepInterior G u w) :
    twoSepInterior G x y ⊆ twoSepInterior G u w := by
  intro z hz
  have huw := h.ne_of_mem_twoSepInterior hx
  have hxy := h.ne_of_mem_twoSepInterior hz
  have hadj : G.Adj x y := h.adj_of_mem_twoSepInterior hz
  obtain ⟨hxS, hxfin⟩ := mem_twoSepInterior_iff.mp hx
  have hy : ReachIn G (offTwo u w) x y ∨ y ∉ offTwo u w := by
    by_cases hyS : y ∈ offTwo u w
    · exact Or.inl (ReachIn.of_adj hxS hyS hadj)
    · exact Or.inr hyS
  -- the infinite component of `G − u − w`
  obtain ⟨c, hcinf, -⟩ := h.oneInf u w huw
  obtain ⟨⟨i₀, hi₀⟩, hc⟩ := c.exists_rep
  replace hc : (G.induce (offTwo u w)).connectedComponentMk ⟨i₀, hi₀⟩ = c := hc
  have hIinf : ¬ (compIn (G := G) (offTwo u w) i₀).Finite := by
    rw [← supp_finite_iff hi₀, hc]; exact hcinf
  -- it avoids `x`'s component
  have hIx : ∀ v, ReachIn G (offTwo u w) i₀ v → ¬ ReachIn G (offTwo u w) x v := by
    intro v hv hvx
    exact hIinf (by rw [compIn_eq_of_reachIn (hv.trans hvx.symm)]; exact hxfin)
  -- so it lies in `G − x − y`
  have hIT : ∀ v, ReachIn G (offTwo u w) i₀ v → ReachIn G (offTwo x y) i₀ v := by
    intro v hv
    obtain ⟨p, hp⟩ := hv
    refine ⟨p, fun q hq => ?_⟩
    have hq' := reachIn_of_mem_support p hp q hq
    refine ⟨?_, ?_⟩
    · rintro rfl; exact hIx _ hq' (ReachIn.refl hxS)
    · rintro rfl
      rcases hy with hy | hy
      · exact hIx _ hq' hy
      · exact hy hq'.right_mem
  have hJinf : ¬ (compIn (G := G) (offTwo x y) i₀).Finite := fun hf => hIinf (hf.subset fun v hv => hIT v hv)
  -- `u` and `w`, when other than `y`, are in that infinite component
  have huJ : u ≠ y → ReachIn G (offTwo x y) i₀ u := by
    intro huy
    obtain ⟨e, he, heu⟩ := h.exists_adj_left huw hi₀
    exact (hIT e he).trans (ReachIn.of_adj (hIT e he).right_mem ⟨fun hux => hxS.1 hux.symm, huy⟩ heu)
  have hwJ : w ≠ y → ReachIn G (offTwo x y) i₀ w := by
    intro hwy
    obtain ⟨e, he, hew⟩ := h.exists_adj_right huw hi₀
    exact (hIT e he).trans (ReachIn.of_adj (hIT e he).right_mem ⟨fun hwx => hxS.2 hwx.symm, hwy⟩ hew)
  obtain ⟨hzT, hzfin⟩ := mem_twoSepInterior_iff.mp hz
  -- `z`'s component of `G − x − y` avoids `u` and `w`
  have hzi : ∀ v, ReachIn G (offTwo x y) z v → v ≠ u ∧ v ≠ w := by
    intro v hv
    have hnot : ¬ ReachIn G (offTwo x y) i₀ v := fun h' =>
      hJinf (by rw [compIn_eq_of_reachIn (h'.trans hv.symm)]; exact hzfin)
    refine ⟨?_, ?_⟩
    · rintro rfl
      by_cases huy : v = y
      · exact hv.right_mem.2 huy
      · exact hnot (huJ huy)
    · rintro rfl
      by_cases hwy : v = y
      · exact hv.right_mem.2 hwy
      · exact hnot (hwJ hwy)
  -- and reaches `x`, inside `G − u − w`
  obtain ⟨e, hze, hex⟩ := h.exists_adj_left hxy hzT
  have hzeS : ReachIn G (offTwo u w) z e := by
    obtain ⟨p, hp⟩ := hze
    exact ⟨p, fun q hq => hzi q (reachIn_of_mem_support p hp q hq)⟩
  have hzx : ReachIn G (offTwo u w) z x := hzeS.trans (ReachIn.of_adj hzeS.right_mem hxS hex)
  exact mem_twoSepInterior_of_reachIn hx hzx.symm

/-- Two pairs whose interiors share a vertex, neither pair's ends inside the other's interior: an end of the first is an end of the second. -/
theorem PlanarLike.eq_or_eq_of_mem {x y u w v : V} (hv : v ∈ twoSepInterior G x y) (hv' : v ∈ twoSepInterior G u w)
    (hu : u ∉ twoSepInterior G x y) (hw : w ∉ twoSepInterior G x y) (hx : x ∉ twoSepInterior G u w) : x = u ∨ x = w := by
  have hxy := h.ne_of_mem_twoSepInterior hv
  -- `v`'s component of `G − x − y` avoids `u` and `w`
  have hD : ∀ q, ReachIn G (offTwo x y) v q → q ∈ offTwo u w := by
    intro q hq
    have hqi := mem_twoSepInterior_of_reachIn hv hq
    exact ⟨fun hqu => hu (hqu ▸ hqi), fun hqw => hw (hqw ▸ hqi)⟩
  obtain ⟨e, hve, hex⟩ := h.exists_adj_left hxy hv.1
  have hveT : ReachIn G (offTwo u w) v e := by
    obtain ⟨p, hp⟩ := hve
    exact ⟨p, fun q hq => hD q (reachIn_of_mem_support p hp q hq)⟩
  by_contra hne
  push Not at hne
  have hxT : x ∈ offTwo u w := ⟨hne.1, hne.2⟩
  exact hx (mem_twoSepInterior_of_reachIn hv' (hveT.trans (ReachIn.of_adj hveT.right_mem hxT hex)))

/-- **A vertex lies in the interior of at most one maximal pair.** -/
theorem PlanarLike.eq_of_mem_maximal {x y u w v : V} (hm : IsMaximalTwoSep G x y) (hm' : IsMaximalTwoSep G u w)
    (hv : v ∈ twoSepInterior G x y) (hv' : v ∈ twoSepInterior G u w) : (x = u ∧ y = w) ∨ (x = w ∧ y = u) := by
  obtain ⟨hxu, hyu⟩ := hm.2 u w hm'.1
  obtain ⟨hux, hwx⟩ := hm'.2 x y hm.1
  have hx := h.eq_or_eq_of_mem hv hv' hux hwx hxu
  have hy := h.eq_or_eq_of_mem (x := y) (y := x) (twoSepInterior_comm (G := G) x y ▸ hv) hv'
    (twoSepInterior_comm (G := G) x y ▸ hux) (twoSepInterior_comm (G := G) x y ▸ hwx) hyu
  have hxy := h.ne_of_mem_twoSepInterior hv
  rcases hx with rfl | rfl <;> rcases hy with rfl | rfl
  · exact absurd rfl hxy
  · exact Or.inl ⟨rfl, rfl⟩
  · exact Or.inr ⟨rfl, rfl⟩
  · exact absurd rfl hxy

/-- **Above every 2-separator a maximal one** (the step `finSep` is read by): of the finitely many pairs whose interior holds a fixed vertex
of `int(x, y)` and contains `int(x, y)`, one of largest interior is maximal, by nesting. -/
theorem PlanarLike.exists_maximal_above {x y : V} (hs : IsTwoSep G x y) :
    ∃ u w, IsMaximalTwoSep G u w ∧ twoSepInterior G x y ⊆ twoSepInterior G u w := by
  obtain ⟨v₀, hv₀⟩ := hs.2
  set P : Set (V × V) := {p | IsTwoSep G p.1 p.2 ∧ twoSepInterior G x y ⊆ twoSepInterior G p.1 p.2} with hP
  have hPfin : P.Finite := (h.finSep v₀).subset fun p hp => hp.2 hv₀
  obtain ⟨p, ⟨hp2, hpsub⟩, hpmax⟩ :=
    hPfin.exists_maximalFor (fun p => (twoSepInterior G p.1 p.2).ncard) P ⟨(x, y), hs, subset_rfl⟩
  refine ⟨p.1, p.2, ⟨hp2, fun u' w' hs' => ⟨fun h1 => ?_, fun h2 => ?_⟩⟩, hpsub⟩
  · have hsub := h.twoSepInterior_subset (y := p.2) h1
    have hlt : (twoSepInterior G p.1 p.2).ncard < (twoSepInterior G u' w').ncard :=
      Set.ncard_lt_ncard (Set.ssubset_iff_subset_ne.mpr ⟨hsub, fun heq => (heq ▸ h1).1.1 rfl⟩)
        (h.twoSepInterior_finite u' w')
    have := hpmax (j := (u', w')) ⟨hs', hpsub.trans hsub⟩ hlt.le
    simp only at this
    omega
  · have hsub := h.twoSepInterior_subset (y := p.1) h2
    rw [twoSepInterior_comm (G := G) p.2 p.1] at hsub
    have hlt : (twoSepInterior G p.1 p.2).ncard < (twoSepInterior G u' w').ncard :=
      Set.ncard_lt_ncard (Set.ssubset_iff_subset_ne.mpr ⟨hsub, fun heq => (heq ▸ h2).1.2 rfl⟩)
        (h.twoSepInterior_finite u' w')
    have := hpmax (j := (u', w')) ⟨hs', hpsub.trans hsub⟩ hlt.le
    simp only at this
    omega

/-- A vertex of `H` lies in no interior at all. -/
theorem PlanarLike.not_mem_twoSepInterior {v x y : V} (hv : v ∈ reducedVerts G) : v ∉ twoSepInterior G x y := by
  intro hvi
  obtain ⟨u, w, hm, hsub⟩ := h.exists_maximal_above ⟨h.ne_of_mem_twoSepInterior hvi, v, hvi⟩
  exact hv u w hm (hsub hvi)

end PlanarLike

/-- The ends of a maximal 2-separator are vertices of `H`. -/
theorem mem_reducedVerts_of_maximal {x y : V} (hm : IsMaximalTwoSep G x y) :
    x ∈ reducedVerts G ∧ y ∈ reducedVerts G :=
  ⟨fun u w hm' => (hm.2 u w hm'.1).1, fun u w hm' => (hm.2 u w hm'.1).2⟩

/-- A vertex outside `H` lies in the interior of a maximal 2-separator. -/
theorem exists_maximal_of_not_mem {v : V} (hv : v ∉ reducedVerts G) :
    ∃ p : V × V, IsMaximalTwoSep G p.1 p.2 ∧ v ∈ twoSepInterior G p.1 p.2 := by
  simp only [reducedVerts, Set.mem_setOf_eq, not_forall, not_not] at hv
  obtain ⟨x, y, hm, hvi⟩ := hv
  exact ⟨(x, y), hm, hvi⟩

/-! ## `H`: connected, locally finite, infinite, locally Hamiltonian -/

/-- A neighbour of a vertex `x` of `H` that is not in `H` lies in `int(x, y)` for some `y` in `H`. -/
theorem exists_reducedVerts_mem_twoSepInterior {x z : V} (hx : x ∈ reducedVerts G) (hxz : G.Adj x z) (hz : z ∉ reducedVerts G) :
    ∃ y, y ∈ reducedVerts G ∧ z ∈ twoSepInterior G x y := by
  obtain ⟨p, hm, hzi⟩ := exists_maximal_of_not_mem hz
  rcases mem_twoSepInterior_or_of_adj hzi hxz.symm with hxi | hx1 | hx2
  · exact absurd hxi (hx _ _ hm)
  · exact ⟨p.2, (mem_reducedVerts_of_maximal hm).2, hx1 ▸ hzi⟩
  · exact ⟨p.1, (mem_reducedVerts_of_maximal hm).1, hx2 ▸ twoSepInterior_comm (G := G) p.1 p.2 ▸ hzi⟩

/-- A discrete crossing, upward: a sequence in `P ∪ {y}` at `lo` and outside it at `hi`, leaving `P` only onto `y`, is `y` in `[lo, hi)`. -/
theorem exists_eq_of_cross_up {W : Type*} (g : ℕ → W) (P : W → Prop) (y : W) {lo hi : ℕ} (hlh : lo ≤ hi)
    (step : ∀ k, lo ≤ k → k < hi → P (g k) → ¬ P (g (k + 1)) → g (k + 1) = y)
    (hlo : P (g lo) ∨ g lo = y) (hhi : ¬ P (g hi)) (hhi' : g hi ≠ y) : ∃ k, lo ≤ k ∧ k < hi ∧ g k = y := by
  induction hi, hlh using Nat.le_induction with
  | base => rcases hlo with h' | h' <;> contradiction
  | succ hi hlh ih =>
    by_cases hP : P (g hi)
    · exact absurd (step hi hlh (Nat.lt_succ_self hi) hP hhi) hhi'
    · by_cases hy : g hi = y
      · exact ⟨hi, hlh, Nat.lt_succ_self hi, hy⟩
      · obtain ⟨k, hk1, hk2, hk3⟩ := ih (fun k hk hk' => step k hk (by omega)) hP hy
        exact ⟨k, hk1, by omega, hk3⟩

/-- A discrete crossing, downward. -/
theorem exists_eq_of_cross_down {W : Type*} (g : ℕ → W) (P : W → Prop) (y : W) {lo hi : ℕ} (hlh : lo ≤ hi)
    (step : ∀ k, lo ≤ k → k < hi → P (g (k + 1)) → ¬ P (g k) → g k = y)
    (hhi : P (g hi) ∨ g hi = y) (hlo : ¬ P (g lo)) (hlo' : g lo ≠ y) : ∃ k, lo < k ∧ k ≤ hi ∧ g k = y := by
  induction hi, hlh using Nat.le_induction with
  | base => rcases hhi with h' | h' <;> contradiction
  | succ hi hlh ih =>
    rcases hhi with hP | hy
    · by_cases hP' : P (g hi)
      · obtain ⟨k, hk1, hk2, hk3⟩ := ih (fun k hk hk' => step k hk (by omega)) (Or.inl hP')
        exact ⟨k, hk1, by omega, hk3⟩
      · have hy := step hi hlh (Nat.lt_succ_self hi) hP hP'
        obtain ⟨k, hk1, hk2, hk3⟩ := ih (fun k hk hk' => step k hk (by omega)) (Or.inr hy)
        exact ⟨k, hk1, by omega, hk3⟩
    · exact ⟨hi + 1, by omega, le_rfl, hy⟩

section Reduced

variable (h : PlanarLike G)
include h

/-- Every vertex has a neighbour. -/
theorem PlanarLike.exists_adj (x : V) : ∃ z, G.Adj x z := by
  haveI := h.inf
  obtain ⟨w, hw⟩ := exists_ne x
  obtain ⟨p⟩ := h.conn.preconnected x w
  cases p with
  | nil => exact absurd rfl hw
  | cons hadj _ => exact ⟨_, hadj⟩

/-- **`H` is locally finite**: an induced subgraph of a locally finite graph. -/
theorem PlanarLike.reduced_locallyFinite (x : reducedVerts G) : ((reduced G).neighborSet x).Finite := by
  have hS : (reduced G).neighborSet x = Subtype.val ⁻¹' G.neighborSet x.1 := by
    ext y; rfl
  rw [hS]
  exact (h.locFin x.1).preimage Subtype.val_injective.injOn

/-- **`H` is infinite**: a finite `H` would have finitely many pairs, each with a finite interior, and they cover `G`. -/
theorem PlanarLike.reducedVerts_infinite : (reducedVerts G).Infinite := by
  intro hfin
  haveI := h.inf
  refine Set.infinite_univ (α := V)
    ((hfin.union ((hfin.prod hfin).biUnion fun p _ => h.twoSepInterior_finite p.1 p.2)).subset ?_)
  intro v _
  by_cases hv : v ∈ reducedVerts G
  · exact Or.inl hv
  · obtain ⟨p, hm, hvi⟩ := exists_maximal_of_not_mem hv
    exact Or.inr (Set.mem_biUnion (x := p) ⟨(mem_reducedVerts_of_maximal hm).1, (mem_reducedVerts_of_maximal hm).2⟩ hvi)

/-- **`H` is connected**: send each interior vertex to one end of its maximal pair; adjacent vertices go to equal or adjacent ones. -/
theorem PlanarLike.reduced_connected : (reduced G).Connected := by
  classical
  obtain ⟨k₀, hk₀⟩ := h.reducedVerts_infinite.nonempty
  have hpick : ∀ v, ∃ a : reducedVerts G, (v ∈ reducedVerts G → a.1 = v) ∧
      (v ∉ reducedVerts G → ∃ b, IsMaximalTwoSep G a.1 b ∧ v ∈ twoSepInterior G a.1 b) := by
    intro v
    by_cases hv : v ∈ reducedVerts G
    · exact ⟨⟨v, hv⟩, fun _ => rfl, fun h' => absurd hv h'⟩
    · obtain ⟨p, hm, hvi⟩ := exists_maximal_of_not_mem hv
      exact ⟨⟨p.1, (mem_reducedVerts_of_maximal hm).1⟩, fun h' => absurd h' hv, fun _ => ⟨p.2, hm, hvi⟩⟩
  choose φ hφ₁ hφ₂ using hpick
  have hone : ∀ v w, v ∉ reducedVerts G → G.Adj v w → φ v = φ w ∨ (reduced G).Adj (φ v) (φ w) := by
    intro v w hv hvw
    obtain ⟨b, hm, hvi⟩ := hφ₂ v hv
    have hbK := (mem_reducedVerts_of_maximal hm).2
    have hab : G.Adj (φ v).1 b := h.adj_of_mem_twoSepInterior hvi
    rcases mem_twoSepInterior_or_of_adj hvi hvw with hwi | hwa | hwb
    · have hwK : w ∉ reducedVerts G := fun hwK => hwK _ _ hm hwi
      obtain ⟨b', hm', hwi'⟩ := hφ₂ w hwK
      rcases h.eq_of_mem_maximal hm hm' hwi hwi' with ⟨h1, -⟩ | ⟨h1, h2⟩
      · exact Or.inl (Subtype.ext h1)
      · right; show G.Adj (φ v).1 (φ w).1; rw [← h2]; exact hab
    · have hwK : w ∈ reducedVerts G := hwa ▸ (φ v).2
      exact Or.inl (Subtype.ext (by rw [hφ₁ w hwK, hwa]))
    · have hwK : w ∈ reducedVerts G := hwb ▸ hbK
      right; show G.Adj (φ v).1 (φ w).1; rw [hφ₁ w hwK, hwb]; exact hab
  have hstep : ∀ v w, G.Adj v w → φ v = φ w ∨ (reduced G).Adj (φ v) (φ w) := by
    intro v w hvw
    by_cases hv : v ∈ reducedVerts G
    · by_cases hw : w ∈ reducedVerts G
      · right; show G.Adj (φ v).1 (φ w).1; rw [hφ₁ v hv, hφ₁ w hw]; exact hvw
      · rcases hone w v hw hvw.symm with h1 | h1
        · exact Or.inl h1.symm
        · exact Or.inr h1.symm
    · exact hone v w hv hvw
  have hwalk : ∀ a b (p : G.Walk a b), (reduced G).Reachable (φ a) (φ b) := by
    intro a b p
    induction p with
    | nil => rfl
    | cons hadj q ih =>
      rcases hstep _ _ hadj with heq | hadj'
      · rw [heq]; exact ih
      · exact hadj'.reachable.trans ih
  have hφK : ∀ a : reducedVerts G, φ a.1 = a := fun a => Subtype.ext (hφ₁ a.1 a.2)
  haveI : Nonempty (reducedVerts G) := ⟨⟨k₀, hk₀⟩⟩
  refine ⟨fun a b => ?_⟩
  obtain ⟨p⟩ := h.conn.preconnected a.1 b.1
  have := hwalk _ _ p
  rwa [hφK a, hφK b] at this

/-- That `y` is unique. -/
theorem PlanarLike.eq_of_mem_twoSepInterior_of_mem_reducedVerts {x y₁ y₂ z : V} (hx : x ∈ reducedVerts G) (hy₁ : y₁ ∈ reducedVerts G) (hy₂ : y₂ ∈ reducedVerts G)
    (h₁ : z ∈ twoSepInterior G x y₁) (h₂ : z ∈ twoSepInterior G x y₂) : y₁ = y₂ := by
  rw [twoSepInterior_comm] at h₁ h₂
  rcases h.eq_or_eq_of_mem h₁ h₂ (h.not_mem_twoSepInterior hy₂) (h.not_mem_twoSepInterior hx)
      (h.not_mem_twoSepInterior hy₁) with h' | h'
  · exact h'
  · exact absurd h' (h.ne_of_mem_twoSepInterior h₁)

/-- A vertex of `H` has a neighbour in `H` other than any two of its neighbours: otherwise it would lie in the interior of the pair. -/
theorem PlanarLike.exists_adj_mem_reducedVerts_ne {x a b : V} (hx : x ∈ reducedVerts G) (ha : G.Adj x a) (hb : G.Adj x b) :
    ∃ z, G.Adj x z ∧ z ∈ reducedVerts G ∧ z ≠ a ∧ z ≠ b := by
  by_contra hno
  push Not at hno
  have hkept : ∀ z, G.Adj x z → z ∈ reducedVerts G → z = a ∨ z = b := fun z hz hzK => by
    by_cases hza : z = a
    · exact Or.inl hza
    · exact Or.inr (hno z hz hzK hza)
  set C : Set V := {x} ∪ twoSepInterior G x a ∪ twoSepInterior G x b with hC
  have hCfin : C.Finite :=
    ((Set.finite_singleton x).union (h.twoSepInterior_finite x a)).union (h.twoSepInterior_finite x b)
  have hclosed : ∀ v w, v ∈ C → w ∈ offTwo a b → G.Adj v w → w ∈ C := by
    intro v w hv hw hvw
    rcases hv with (hv | hv) | hv
    · rw [Set.mem_singleton_iff] at hv
      subst hv
      by_cases hwK : w ∈ reducedVerts G
      · rcases hkept w hvw hwK with rfl | rfl
        · exact absurd rfl hw.1
        · exact absurd rfl hw.2
      · obtain ⟨y, hyK, hwy⟩ := exists_reducedVerts_mem_twoSepInterior hx hvw hwK
        rcases hkept y (h.adj_of_mem_twoSepInterior hwy) hyK with rfl | rfl
        · exact Or.inl (Or.inr hwy)
        · exact Or.inr hwy
    · rcases mem_twoSepInterior_or_of_adj hv hvw with hwi | hwx | hwa
      · exact Or.inl (Or.inr hwi)
      · exact Or.inl (Or.inl hwx)
      · exact absurd hwa hw.1
    · rcases mem_twoSepInterior_or_of_adj hv hvw with hwi | hwx | hwb
      · exact Or.inr hwi
      · exact Or.inl (Or.inl hwx)
      · exact absurd hwb hw.2
  have hxab : x ∈ offTwo a b := ⟨ha.ne, hb.ne⟩
  have hxi : x ∈ twoSepInterior G a b := mem_twoSepInterior_iff.mpr
    ⟨hxab, hCfin.subset fun w hw => mem_of_reachIn_of_closed hclosed (Or.inl (Or.inl rfl)) hw⟩
  exact h.not_mem_twoSepInterior hx hxi

/-- **`H` is locally Hamiltonian**: map each entry of `x`'s ring to the vertex of `H` it stands for (itself, or the unique `y` in `H` with
the entry in `int(x, y)`); the image has consecutive entries equal or adjacent, no value interleaving (the ring's separation and `oneInf`'s
uniqueness), and at least three values, so it collapses to a cycle on `x`'s neighbourhood in `H`. -/
theorem PlanarLike.reduced_locallyHamiltonian : LocallyHamiltonian (reduced G) := by
  classical
  intro x
  obtain ⟨r, ⟨hmem, hcons, hsep⟩, -⟩ := h.ring x.1
  -- the vertex of `H` an entry stands for
  have hpick : ∀ z, ∃ a : reducedVerts G, (z ∈ reducedVerts G → a.1 = z) ∧
      (z ∉ reducedVerts G → G.Adj x.1 z → z ∈ twoSepInterior G x.1 a.1) := by
    intro z
    by_cases hz : z ∈ reducedVerts G
    · exact ⟨⟨z, hz⟩, fun _ => rfl, fun h' => absurd hz h'⟩
    · by_cases hxz : G.Adj x.1 z
      · obtain ⟨y, hyK, hzy⟩ := exists_reducedVerts_mem_twoSepInterior x.2 hxz hz
        exact ⟨⟨y, hyK⟩, fun h' => absurd h' hz, fun _ _ => hzy⟩
      · exact ⟨x, fun h' => absurd h' hz, fun _ h' => absurd h' hxz⟩
  choose π hπ₁ hπ₂ using hpick
  have hπeq : ∀ z (y : reducedVerts G), G.Adj x.1 z → (π z = y ↔ z = y.1 ∨ z ∈ twoSepInterior G x.1 y.1) := by
    intro z y hz
    constructor
    · rintro rfl
      by_cases hzK : z ∈ reducedVerts G
      · exact Or.inl (hπ₁ z hzK).symm
      · exact Or.inr (hπ₂ z hzK hz)
    · rintro (rfl | hzi)
      · exact Subtype.ext (hπ₁ _ y.2)
      · have hzK : z ∉ reducedVerts G := fun hzK => h.not_mem_twoSepInterior hzK hzi
        exact Subtype.ext (h.eq_of_mem_twoSepInterior_of_mem_reducedVerts x.2 (π z).2 y.2 (hπ₂ z hzK hz) hzi)
  have hπadj : ∀ z, G.Adj x.1 z → G.Adj x.1 (π z).1 := by
    intro z hz
    rcases (hπeq z (π z) hz).mp rfl with h' | h'
    · rw [← h']; exact hz
    · exact h.adj_of_mem_twoSepInterior h'
  have hradj : ∀ i z, r[i]? = some z → G.Adj x.1 z := fun i z hi => (hmem z).mp (List.mem_of_getElem? hi)
  set s := r.map π with hs
  have hsget : ∀ (i : ℕ) (A : reducedVerts G), s[i]? = some A → ∃ z, r[i]? = some z ∧ π z = A := by
    intro i A hA
    rw [hs, List.getElem?_map, Option.map_eq_some_iff] at hA
    exact hA
  -- consecutive entries
  have hstep : ∀ z z', G.Adj x.1 z → G.Adj x.1 z' → (z = z' ∨ G.Adj z z') →
      π z = π z' ∨ (reduced G).Adj (π z) (π z') := by
    intro z z' hz hz' hzz'
    rcases hzz' with rfl | hzz'
    · exact Or.inl rfl
    by_cases hzK : z ∈ reducedVerts G <;> by_cases hz'K : z' ∈ reducedVerts G
    · right; show G.Adj (π z).1 (π z').1; rw [hπ₁ z hzK, hπ₁ z' hz'K]; exact hzz'
    · left
      have hz'i := hπ₂ z' hz'K hz'
      rcases mem_twoSepInterior_or_of_adj hz'i hzz'.symm with hzi | hzx | hzy
      · exact absurd hzi (h.not_mem_twoSepInterior hzK)
      · exact absurd hzx hz.ne'
      · exact Subtype.ext (by rw [hπ₁ z hzK, hzy])
    · left
      have hzi := hπ₂ z hzK hz
      rcases mem_twoSepInterior_or_of_adj hzi hzz' with hz'i | hz'x | hz'y
      · exact absurd hz'i (h.not_mem_twoSepInterior hz'K)
      · exact absurd hz'x hz'.ne'
      · exact Subtype.ext (by rw [hπ₁ z' hz'K, hz'y])
    · left
      have hzi := hπ₂ z hzK hz
      rcases mem_twoSepInterior_or_of_adj hzi hzz' with hz'i | hz'x | hz'y
      · exact ((hπeq z' (π z) hz').mpr (Or.inr hz'i)).symm
      · exact absurd hz'x hz'.ne'
      · exact absurd (hz'y ▸ (π z).2) hz'K
  have hchain : ∀ (i : ℕ) (A B : reducedVerts G), s[i]? = some A → s[(i + 1) % s.length]? = some B →
      A = B ∨ (reduced G).Adj A B := by
    intro i A B hA hB
    obtain ⟨z, hz, rfl⟩ := hsget i A hA
    rw [hs, List.length_map] at hB
    obtain ⟨z', hz', rfl⟩ := hsget ((i + 1) % r.length) B (by rw [hs]; exact hB)
    exact hstep z z' (hradj _ _ hz) (hradj _ _ hz') (hcons i z z' hz hz')
  -- no interleaving
  have hnoint : NoInterleave s := by
    intro Y A B i m j n him hmj hn hi hm hj hn'
    by_contra hne
    push Not at hne
    obtain ⟨hAY, hBY⟩ := hne
    obtain ⟨zi, hzi, hπi⟩ := hsget i Y hi
    obtain ⟨zm, hzm, hπm⟩ := hsget m A hm
    obtain ⟨zj, hzj, hπj⟩ := hsget j Y hj
    obtain ⟨zn, hzn, hπn⟩ := hsget n B hn'
    set y := Y.1 with hy
    have hxy : x.1 ≠ y := by
      have := hπadj zi (hradj _ _ hzi); rw [hπi] at this; exact this.ne
    set P : V → Prop := fun v => v ∈ twoSepInterior G x.1 y with hP
    set g : ℕ → V := fun k => r.getD k x.1 with hg
    have hgk : ∀ k, k < r.length → r[k]? = some (g k) := by
      intro k hk; simp only [hg, List.getD_eq_getElem?_getD, List.getElem?_eq_getElem hk, Option.getD_some]
    have hlen : ∀ k z, r[k]? = some z → k < r.length := fun k z hk => by
      by_contra hc; rw [List.getElem?_eq_none (by omega)] at hk; simp at hk
    have hil := hlen i zi hzi
    have hml := hlen m zm hzm
    have hjl := hlen j zj hzj
    have hnl := hlen n zn hzn
    have hgi : g i = zi := Option.some.inj ((hgk i hil).symm.trans hzi)
    have hgm : g m = zm := Option.some.inj ((hgk m hml).symm.trans hzm)
    have hgj : g j = zj := Option.some.inj ((hgk j hjl).symm.trans hzj)
    -- membership in `y`'s fibre
    have hfib : ∀ k, k < r.length → (π (g k) = Y ↔ g k = y ∨ P (g k)) := fun k hk =>
      hπeq (g k) Y (hradj k _ (hgk k hk))
    have hcross : ∀ k, k + 1 < r.length → (P (g k) → ¬ P (g (k + 1)) → g (k + 1) = y) ∧
        (P (g (k + 1)) → ¬ P (g k) → g k = y) := by
      intro k hk
      have hk' := hgk k (by omega)
      have hk1 := hgk (k + 1) hk
      have hc := hcons k (g k) (g (k + 1)) hk' (by rw [Nat.mod_eq_of_lt hk]; exact hk1)
      have hxk := hradj k _ hk'
      have hxk1 := hradj (k + 1) _ hk1
      refine ⟨fun h1 h2 => ?_, fun h1 h2 => ?_⟩
      · rcases hc with hc | hc
        · exact absurd (hc ▸ h1) h2
        · rcases mem_twoSepInterior_or_of_adj h1 hc with h3 | h3 | h3
          · exact absurd h3 h2
          · exact absurd h3 hxk1.ne'
          · exact h3
      · rcases hc with hc | hc
        · exact absurd (hc ▸ h1) h2
        · rcases mem_twoSepInterior_or_of_adj h1 hc.symm with h3 | h3 | h3
          · exact absurd h3 h2
          · exact absurd h3 hxk.ne'
          · exact h3
    have hmout : ¬ P (g m) ∧ g m ≠ y := by
      have := (hfib m hml).not.mp (by rw [hgm, hπm]; exact hAY)
      push Not at this
      exact ⟨this.2, this.1⟩
    have hiin : P (g i) ∨ g i = y := ((hfib i hil).mp (by rw [hgi, hπi])).symm
    have hjin : P (g j) ∨ g j = y := ((hfib j hjl).mp (by rw [hgj, hπj])).symm
    -- the real appearances of `y` around `m`
    obtain ⟨i', hi'1, hi'2, hgi'⟩ := exists_eq_of_cross_up g P y him.le
      (fun k hk hk' => (hcross k (by omega)).1) hiin hmout.1 hmout.2
    obtain ⟨j', hj'1, hj'2, hgj'⟩ := exists_eq_of_cross_down g P y hmj.le
      (fun k hk hk' => (hcross k (by omega)).2) hjin hmout.1 hmout.2
    have hgn : g n = zn := Option.some.inj ((hgk n hnl).symm.trans hzn)
    have hnout : ¬ P zn ∧ zn ≠ y := by
      have := (hfib n hnl).not.mp (by rw [hgn, hπn]; exact hBY)
      push Not at this
      rw [hgn] at this
      exact ⟨this.2, this.1⟩
    have hzmS : zm ∈ offTwo x.1 y := ⟨(hradj m zm hzm).ne', hgm ▸ hmout.2⟩
    have hznS : zn ∈ offTwo x.1 y := ⟨(hradj n zn hzn).ne', hnout.2⟩
    have hsep' := hsep y i' j' (by omega) (by rw [hgk i' (by omega), hgi']) (by rw [hgk j' (by omega), hgj'])
      m n zm zn hi'2 hj'1 (by omega) hzm hzn hzmS hznS
    -- against `oneInf`: both lie in the one infinite component
    obtain ⟨c, -, huniq⟩ := h.oneInf x.1 y hxy
    have hinf : ∀ v (hv : v ∈ offTwo x.1 y), ¬ P v → (G.induce (offTwo x.1 y)).connectedComponentMk ⟨v, hv⟩ = c := by
      intro v hv hPv
      exact huniq _ fun hf => hPv ⟨hv, hf⟩
    exact hsep' (SimpleGraph.ConnectedComponent.exact
      ((hinf zm hzmS (hgm ▸ hmout.1)).trans (hinf zn hznS hnout.1).symm))
  -- three values
  have h3 : ∃ a b c, a ∈ s ∧ b ∈ s ∧ c ∈ s ∧ a ≠ b ∧ a ≠ c ∧ b ≠ c := by
    have hkin : ∀ z (hz : z ∈ reducedVerts G), G.Adj x.1 z → (⟨z, hz⟩ : reducedVerts G) ∈ s := by
      intro z hz hxz
      rw [hs, List.mem_map]
      exact ⟨z, (hmem z).mpr hxz, Subtype.ext (hπ₁ z hz)⟩
    obtain ⟨z₀, hz₀⟩ := h.exists_adj x.1
    obtain ⟨z₁, h1, hK1, -, -⟩ := h.exists_adj_mem_reducedVerts_ne x.2 hz₀ hz₀
    obtain ⟨z₂, h2, hK2, hne2, -⟩ := h.exists_adj_mem_reducedVerts_ne x.2 h1 h1
    obtain ⟨z₃, h3, hK3, hne31, hne32⟩ := h.exists_adj_mem_reducedVerts_ne x.2 h1 h2
    refine ⟨⟨z₁, hK1⟩, ⟨z₂, hK2⟩, ⟨z₃, hK3⟩, hkin _ _ h1, hkin _ _ h2, hkin _ _ h3, ?_, ?_, ?_⟩
    · intro he; exact hne2 (congrArg Subtype.val he).symm
    · intro he; exact hne31 (congrArg Subtype.val he).symm
    · intro he; exact hne32 (congrArg Subtype.val he).symm
  obtain ⟨a, p, hp, hsupp⟩ := exists_cycle_of_cyclic (reduced G) s hchain hnoint h3
  refine ⟨a, p, hp, fun y => (hsupp y).trans ?_⟩
  rw [hs, List.mem_map]
  constructor
  · rintro ⟨z, hz, rfl⟩
    exact hπadj z ((hmem z).mp hz)
  · intro hxy
    exact ⟨y.1, (hmem y.1).mpr hxy, Subtype.ext (hπ₁ _ y.2)⟩

end Reduced

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
    (reduced G).Connected ∧ (∀ x, ((reduced G).neighborSet x).Finite) ∧ LocallyHamiltonian (reduced G) ∧ Infinite (reducedVerts G) :=
  ⟨h.reduced_connected, h.reduced_locallyFinite, h.reduced_locallyHamiltonian, h.reducedVerts_infinite.to_subtype⟩

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

/-! ## The adversary: without `finSep` the reduction fails -/

/-- **The ladder**: the strong product of the ray `ℕ` with an edge — the levels `{(n, false), (n, true)}` are edges and consecutive levels are
completely joined. Every field of `PlanarLike` but `finSep` holds, and `H = G` is not locally Hamiltonian (`ladder_adversary`; FS131-IT1,
inventory item 308). -/
def ladder : SimpleGraph (ℕ × Bool) where
  Adj p q := (p.1 = q.1 ∧ p.2 ≠ q.2) ∨ p.1 + 1 = q.1 ∨ q.1 + 1 = p.1
  symm := ⟨fun p q h => by
    rcases h with ⟨h1, h2⟩ | h | h
    · exact Or.inl ⟨h1.symm, Ne.symm h2⟩
    · exact Or.inr (Or.inr h)
    · exact Or.inr (Or.inl h)⟩
  loopless := ⟨fun p h => by
    rcases h with ⟨-, h⟩ | h | h
    · exact h rfl
    · omega
    · omega⟩

/-- Adjacency in the ladder: same level and other side, or consecutive levels. -/
theorem ladder_adj {p q : ℕ × Bool} : ladder.Adj p q ↔ (p.1 = q.1 ∧ p.2 ≠ q.2) ∨ p.1 + 1 = q.1 ∨ q.1 + 1 = p.1 := Iff.rfl

/-- In the ladder, a vertex climbs inside `S` to level `N` when every level strictly above it, up to `N`, keeps a vertex of `S`. -/
theorem ladder_climb {S : Set (ℕ × Bool)} {N : ℕ} :
    ∀ (d : ℕ) (v : ℕ × Bool), v ∈ S → v.1 + d = N → (∀ k, v.1 < k → k ≤ N → ∃ t, (k, t) ∈ S) →
      ∃ t, ReachIn ladder S v (N, t) := by
  intro d
  induction d with
  | zero => intro v hv hd _; exact ⟨v.2, by rw [← hd]; exact ReachIn.refl hv⟩
  | succ d ih =>
    intro v hv hd hlev
    obtain ⟨t, ht⟩ := hlev (v.1 + 1) (by omega) (by omega)
    obtain ⟨t', ht'⟩ := ih (v.1 + 1, t) ht (by simp only; omega) (fun k hk hk' => hlev k (by simp only at hk; omega) hk')
    exact ⟨t', (ReachIn.of_adj hv ht (Or.inr (Or.inl rfl))).trans ht'⟩

/-- In the ladder, a vertex descends inside `S` to `(N, false)` when every level from `N` up is wholly in `S`. -/
theorem ladder_descend {S : Set (ℕ × Bool)} {N : ℕ} (hS : ∀ k t, N ≤ k → (k, t) ∈ S) :
    ∀ (d : ℕ) (v : ℕ × Bool), v.1 = N + d → ReachIn ladder S v (N, false) := by
  intro d
  induction d with
  | zero =>
    intro v hv
    obtain ⟨n, t⟩ := v
    simp only [Nat.add_zero] at hv
    subst hv
    cases t
    · exact ReachIn.refl (hS _ _ le_rfl)
    · exact ReachIn.of_adj (hS _ _ le_rfl) (hS _ _ le_rfl) (Or.inl ⟨rfl, by simp⟩)
  | succ d ih =>
    intro v hv
    have hv' : v ∈ S := by obtain ⟨n, t⟩ := v; exact hS _ _ (by simp only at hv; omega)
    exact (ReachIn.of_adj hv' (hS (N + d) false (by omega)) (Or.inr (Or.inr (by simp only; omega)))).trans
      (ih (N + d, false) rfl)

/-- Off any two vertices that are not a level above the first, every vertex of the ladder reaches a vertex above both. -/
theorem ladder_reachIn {x y : ℕ × Bool} (hxy : ¬ (x.1 = y.1 ∧ x ≠ y ∧ 1 ≤ x.1)) {a : ℕ × Bool} (ha : a ∈ offTwo x y) :
    ReachIn ladder (offTwo x y) a (max x.1 y.1 + 1, false) := by
  set N := max x.1 y.1 + 1 with hN
  have hhigh : ∀ k t, N ≤ k → (k, t) ∈ offTwo x y := fun k t hk =>
    ⟨fun h => by have := congrArg Prod.fst h; simp only at this; omega,
     fun h => by have := congrArg Prod.fst h; simp only at this; omega⟩
  by_cases haN : a.1 ≤ N
  · obtain ⟨t, ht⟩ := ladder_climb (N := N) (N - a.1) a ha (by omega) (fun k hk hkN => by
      by_contra hno
      push Not at hno
      have h1 := hno false
      have h2 := hno true
      simp only [offTwo, Set.mem_setOf_eq, not_and_or, not_not] at h1 h2
      apply hxy
      rcases h1 with h1 | h1 <;> rcases h2 with h2 | h2
      · rw [← h1] at h2; simp at h2
      · rw [← h1, ← h2]; simp; omega
      · rw [← h1, ← h2]; simp; omega
      · rw [← h1] at h2; simp at h2)
    exact ht.trans (ladder_descend hhigh 0 (N, t) (by simp))
  · exact ladder_descend hhigh (a.1 - N) a (by omega)

/-- `G − x − y` in the ladder is connected unless `{x, y}` is a level above the first. -/
theorem ladder_connected {x y : ℕ × Bool} (hxy : ¬ (x.1 = y.1 ∧ x ≠ y ∧ 1 ≤ x.1)) :
    (ladder.induce (offTwo x y)).Connected := by
  have hhigh : (max x.1 y.1 + 1, false) ∈ offTwo x y :=
    ⟨fun h => by have := congrArg Prod.fst h; simp only at this; omega,
     fun h => by have := congrArg Prod.fst h; simp only at this; omega⟩
  exact connected_induce_iff'.mpr ⟨⟨_, hhigh⟩, fun a b ha hb => (ladder_reachIn hxy ha).trans (ladder_reachIn hxy hb).symm⟩

/-- Below a level `L_n` (given as `{x, y}`, two vertices of level `n`), the lower levels are closed under adjacency off `L_n`. -/
theorem ladder_below_closed {n : ℕ} {x y : ℕ × Bool} (hx : x.1 = n) (hy : y.1 = n) (hxy : x ≠ y) {a b : ℕ × Bool} (ha : a.1 < n)
    (hb : ReachIn ladder (offTwo x y) a b) : b.1 < n := by
  refine mem_of_reachIn_of_closed (C := {v : ℕ × Bool | v.1 < n}) (fun v w hv hw hvw => ?_) ha hb
  simp only [Set.mem_setOf_eq] at hv ⊢
  have hw1 : w.1 ≤ n := by rcases hvw with ⟨h1, -⟩ | h1 | h1 <;> omega
  by_contra hc
  have hwn : w.1 = n := by omega
  have hx2y2 : x.2 ≠ y.2 := fun h => hxy (Prod.ext (hx.trans hy.symm) h)
  have hw2 : w.2 = x.2 ∨ w.2 = y.2 := by
    revert hx2y2
    cases w.2 <;> cases x.2 <;> cases y.2 <;> simp
  rcases hw2 with h | h
  · exact hw.1 (Prod.ext (hwn.trans hx.symm) h)
  · exact hw.2 (Prod.ext (hwn.trans hy.symm) h)

/-- The levels below `n` are finitely many vertices. -/
theorem ladder_below_finite (n : ℕ) : {v : ℕ × Bool | v.1 < n}.Finite := by
  refine ((Set.finite_Iio n).prod (Set.finite_univ (α := Bool))).subset ?_
  intro v hv
  exact ⟨hv, trivial⟩

/-- A vertex below a level `L_n` lies in its interior. -/
theorem ladder_mem_twoSepInterior {n : ℕ} {v : ℕ × Bool} (hv : v.1 < n) :
    v ∈ twoSepInterior ladder (n, false) (n, true) := by
  have hvS : v ∈ offTwo (n, false) (n, true) :=
    ⟨fun h => by rw [h] at hv; simp at hv, fun h => by rw [h] at hv; simp at hv⟩
  exact mem_twoSepInterior_iff.mpr ⟨hvS, (ladder_below_finite n).subset fun b hb =>
    ladder_below_closed (x := (n, false)) (y := (n, true)) rfl rfl (by simp) hv hb⟩

/-- Infinitely many vertices of the ladder are off any two. -/
theorem ladder_offTwo_infinite (x y : ℕ × Bool) : (offTwo x y).Infinite := by
  have hS : offTwo x y = ({x, y} : Set (ℕ × Bool))ᶜ := by ext v; simp [offTwo]
  rw [hS]
  exact (Set.toFinite _).infinite_compl

/-- The ring of the ladder at `(0, s)`: no repeats. -/
theorem ladder_ring_zero (s : Bool) : IsRing ladder (0, s) [(0, !s), (1, s), (1, !s)] := by
  refine ⟨fun y => ?_, fun i a b ha hb => ?_, fun y i j hij hi hj => ?_⟩
  · obtain ⟨m, t⟩ := y
    simp only [List.mem_cons, List.not_mem_nil, or_false, Prod.mk.injEq, ladder_adj]
    cases s <;> cases t <;> simp <;> omega
  · simp only [List.length_cons, List.length_nil] at hb
    rcases i with _ | _ | _ | i <;> simp at ha hb <;> subst ha <;> subst hb <;> right <;> simp [ladder_adj]
  · exfalso
    have hnd : [((0 : ℕ), !s), (1, s), (1, !s)].Nodup := by cases s <;> decide
    exact List.nodup_iff_getElem?_ne_getElem?.mp hnd i j hij (List.getElem?_eq_some_iff.mp hj).1 (hi.trans hj.symm)

/-- The ring of the ladder at `(n + 1, s)`: the one repeat, `(n + 1, !s)`, separates level `n` from level `n + 2`. -/
theorem ladder_ring_succ (n : ℕ) (s : Bool) :
    IsRing ladder (n + 1, s) [(n + 2, s), (n + 2, !s), (n + 1, !s), (n, !s), (n, s), (n + 1, !s)] := by
  refine ⟨fun y => ?_, fun i a b ha hb => ?_, fun y i j hij hi hj => ?_⟩
  · obtain ⟨m, t⟩ := y
    simp only [List.mem_cons, List.not_mem_nil, or_false, Prod.mk.injEq, ladder_adj]
    cases s <;> cases t <;> simp <;> omega
  · simp only [List.length_cons, List.length_nil] at hb
    rcases i with _ | _ | _ | _ | _ | _ | i <;> simp at ha hb <;> subst ha <;> subst hb <;> right <;> simp [ladder_adj]
  · have hj6 : j < 6 := (List.getElem?_eq_some_iff.mp hj).1
    have h25 : i = 2 ∧ j = 5 ∧ y = (n + 1, !s) := by
      rcases i with _ | _ | _ | _ | _ | _ | i <;> rcases j with _ | _ | _ | _ | _ | _ | j <;>
        simp only [List.getElem?_cons_zero, List.getElem?_cons_succ, Option.some.injEq] at hi hj <;>
        (try omega) <;> subst hi <;> simp_all
    obtain ⟨rfl, rfl, rfl⟩ := h25
    intro m n' a b him hmj hn' ha hb hxa hxb hreach
    have hab : a.1 = n ∧ b.1 = n + 2 := by
      have hn6 : n' < 6 := (List.getElem?_eq_some_iff.mp hb).1
      rcases m with _ | _ | _ | _ | _ | _ | m <;> (try omega) <;>
      rcases n' with _ | _ | _ | _ | _ | _ | n' <;> (try omega) <;>
        simp only [List.getElem?_cons_zero, List.getElem?_cons_succ, Option.some.injEq] at ha hb <;>
        subst ha <;> subst hb <;> simp
    have := ladder_below_closed (n := n + 1) (x := (n + 1, s)) (y := (n + 1, !s)) rfl rfl (by simp) (by omega)
      ((reachable_induce_iff hxa hxb).mp hreach)
    omega

/-- No 2-separator of the ladder is maximal: each lies in the interior of the level above it. -/
theorem ladder_not_isMaximalTwoSep (x y : ℕ × Bool) : ¬ IsMaximalTwoSep ladder x y := by
  intro hm
  have hx := ladder_mem_twoSepInterior (n := x.1 + 1) (v := x) (by omega)
  exact (hm.2 _ _ ⟨fun h => by simp at h, x, hx⟩).1 hx

/-- `H` of the ladder is the ladder: no vertex lies in the interior of a maximal 2-separator. -/
theorem ladder_reducedVerts (v : ℕ × Bool) : v ∈ reducedVerts ladder := fun x y hm => absurd hm (ladder_not_isMaximalTwoSep x y)

/-- **The ladder is an adversary of `PlanarLike` without `finSep`**: locally finite, connected, infinite, rings at every vertex with `G − x − y`
connected unless `y` appears twice apart, exactly one infinite component of every `G − x − y` — yet `finSep` fails (`(0, false)` lies in the
interior of every level above it) and `H` (here `G` itself: no 2-separator is maximal) is not locally Hamiltonian (at `(1, false)` the
neighbourhood is two edges joined through one vertex). So `reduced_props_of_planarLike` needs `finSep`. -/
theorem ladder_adversary :
    (∀ x, (ladder.neighborSet x).Finite) ∧ ladder.Connected ∧ Infinite (ℕ × Bool) ∧
      (∀ x, ∃ r, IsRing ladder x r ∧ ∀ y, y ≠ x → ¬ TwiceApart r y → (ladder.induce (offTwo x y)).Connected) ∧
      (∀ x y, x ≠ y → ∃ c : (ladder.induce (offTwo x y)).ConnectedComponent, ¬ c.supp.Finite ∧ ∀ c', ¬ c'.supp.Finite → c' = c) ∧
      ¬ (∀ v, {p : (ℕ × Bool) × (ℕ × Bool) | v ∈ twoSepInterior ladder p.1 p.2}.Finite) ∧
      ¬ LocallyHamiltonian (reduced ladder) := by
  refine ⟨?_, ?_, inferInstance, ?_, ?_, ?_, ?_⟩
  · -- locally finite
    intro x
    refine ((ladder_below_finite (x.1 + 2)).subset fun y hy => ?_)
    rcases hy with ⟨h1, -⟩ | h1 | h1 <;> simp only [Set.mem_setOf_eq] <;> omega
  · -- connected
    refine (SimpleGraph.connected_iff_exists_forall_reachable ladder).mpr ⟨(0, false), ?_⟩
    rintro ⟨n, t⟩
    induction n with
    | zero =>
      cases t
      · rfl
      · exact SimpleGraph.Adj.reachable (Or.inl ⟨rfl, by decide⟩)
    | succ n ih => exact ih.trans (SimpleGraph.Adj.reachable (Or.inr (Or.inl rfl)))
  · -- rings
    rintro ⟨_ | n, s⟩
    · refine ⟨_, ladder_ring_zero s, fun y hy _ => ladder_connected fun h => ?_⟩
      simp only at h; omega
    · refine ⟨_, ladder_ring_succ n s, fun y hy htw => ladder_connected fun h => htw ?_⟩
      obtain ⟨h1, h2, -⟩ := h
      have hy' : y = (n + 1, !s) := by
        obtain ⟨m, t⟩ := y
        simp only at h1
        subst h1
        cases s <;> cases t <;> simp_all
      subst hy'
      exact ⟨2, 5, by omega, by simp, rfl, rfl⟩
  · -- one infinite component
    intro x y hxy
    by_cases hsplit : x.1 = y.1 ∧ x ≠ y ∧ 1 ≤ x.1
    · obtain ⟨hxy1, hne, -⟩ := hsplit
      have hS : ∀ k t, x.1 + 1 ≤ k → (k, t) ∈ offTwo x y := fun k t hk =>
        ⟨fun h => by rw [← h] at hk; simp at hk, fun h => by rw [hxy1, ← h] at hk; simp at hk⟩
      have hc0 := hS (x.1 + 1) false le_rfl
      refine ⟨(ladder.induce (offTwo x y)).connectedComponentMk ⟨_, hc0⟩, fun hf => ?_, fun c' hc' => ?_⟩
      · rw [supp_finite_iff hc0] at hf
        exact Set.infinite_of_injective_forall_mem (f := fun m : ℕ => ((x.1 + 1 + m, false) : ℕ × Bool))
          (fun a b hab => by simp only [Prod.mk.injEq] at hab; omega)
          (fun m => (ladder_descend hS m _ rfl).symm) hf
      · obtain ⟨⟨v, hv⟩, rfl⟩ := c'.exists_rep
        by_cases hvn : v.1 < x.1
        · exfalso
          apply hc'
          refine (supp_finite_iff (G := ladder) hv).mpr ?_
          exact (ladder_below_finite x.1).subset fun b hb => ladder_below_closed rfl hxy1.symm hne hvn hb
        · have hvn' : x.1 + 1 ≤ v.1 := by
            by_contra hc
            have hv1 : v.1 = x.1 := by omega
            obtain ⟨v1, v2⟩ := v
            obtain ⟨x1, x2⟩ := x
            obtain ⟨y1, y2⟩ := y
            simp only at hv1 hxy1
            subst hv1 hxy1
            simp only [offTwo, Set.mem_setOf_eq, ne_eq, Prod.mk.injEq, true_and] at hv hne
            cases v2 <;> cases x2 <;> cases y2 <;> simp_all
          exact SimpleGraph.ConnectedComponent.sound ((reachable_induce_iff hv hc0).mpr
            (ladder_descend hS (v.1 - (x.1 + 1)) v (by omega)))
    · have hc0 : (max x.1 y.1 + 1, false) ∈ offTwo x y :=
        ⟨fun h => by have := congrArg Prod.fst h; simp only at this; omega,
         fun h => by have := congrArg Prod.fst h; simp only at this; omega⟩
      refine ⟨(ladder.induce (offTwo x y)).connectedComponentMk ⟨_, hc0⟩, fun hf => ?_, fun c' _ => ?_⟩
      · rw [supp_finite_iff hc0] at hf
        exact ladder_offTwo_infinite x y (hf.subset fun b hb => (ladder_reachIn hsplit hb).symm)
      · obtain ⟨⟨v, hv⟩, rfl⟩ := c'.exists_rep
        exact SimpleGraph.ConnectedComponent.sound ((reachable_induce_iff hv hc0).mpr (ladder_reachIn hsplit hv))
  · -- `finSep` fails at `(0, false)`
    intro hfin
    exact Set.infinite_of_injective_forall_mem (f := fun n : ℕ => (((n + 1, false), (n + 1, true)) : (ℕ × Bool) × (ℕ × Bool)))
      (fun a b hab => by simp only [Prod.mk.injEq] at hab; omega) (fun n => ladder_mem_twoSepInterior (by simp)) (hfin (0, false))
  · -- at `(1, false)`: each of the four outer neighbours has its two cycle-neighbours forced, and `(1, true)` would need four
    intro hH
    set mk : ℕ × Bool → reducedVerts ladder := fun v => ⟨v, ladder_reducedVerts v⟩ with hmk
    obtain ⟨a, p, hp, hsupp⟩ := hH (mk (1, false))
    have hsuppv : ∀ v : ℕ × Bool, mk v ∈ p.support ↔ ladder.Adj (1, false) v := fun v => hsupp (mk v)
    -- the cycle-neighbours of a support vertex are support vertices adjacent to it
    have hnb : ∀ w z, p.toSubgraph.Adj w z → ladder.Adj (1, false) z.1 ∧ ladder.Adj w.1 z.1 := fun w z hwz =>
      ⟨(hsupp z).mp (p.mem_support_of_adj_toSubgraph hwz.symm), hwz.adj_sub⟩
    have htwo : ∀ w, w ∈ p.support → (p.toSubgraph.neighborSet w).ncard = 2 := fun w hw =>
      hp.ncard_neighborSet_toSubgraph_eq_two hw
    -- an outer vertex is joined to `(1, true)` in the cycle
    have hforced : ∀ v o : ℕ × Bool, ladder.Adj (1, false) v →
        (∀ z : ℕ × Bool, ladder.Adj (1, false) z → ladder.Adj v z → z = o ∨ z = (1, true)) →
        p.toSubgraph.Adj (mk v) (mk (1, true)) := by
      intro v o hv hz
      by_contra hno
      have hsub : p.toSubgraph.neighborSet (mk v) ⊆ {mk o} := by
        intro z hzv
        obtain ⟨h1, h2⟩ := hnb _ _ hzv
        rcases hz z.1 h1 h2 with h | h
        · exact Subtype.ext h
        · exact absurd (by rw [show z = mk (1, true) from Subtype.ext h] at hzv; exact hzv) hno
      have := Set.ncard_le_ncard hsub (Set.finite_singleton _)
      rw [htwo _ ((hsuppv v).mpr hv), Set.ncard_singleton] at this
      omega
    have h1 := hforced (0, false) (0, true) (by simp [ladder_adj]) (fun z hz1 hz2 => by
      obtain ⟨m, t⟩ := z; simp only [ladder_adj, Prod.mk.injEq] at hz1 hz2 ⊢; cases t <;> simp at hz1 hz2 ⊢ <;> omega)
    have h2 := hforced (0, true) (0, false) (by simp [ladder_adj]) (fun z hz1 hz2 => by
      obtain ⟨m, t⟩ := z; simp only [ladder_adj, Prod.mk.injEq] at hz1 hz2 ⊢; cases t <;> simp at hz1 hz2 ⊢ <;> omega)
    have h3 := hforced (2, false) (2, true) (by simp [ladder_adj]) (fun z hz1 hz2 => by
      obtain ⟨m, t⟩ := z; simp only [ladder_adj, Prod.mk.injEq] at hz1 hz2 ⊢; cases t <;> simp at hz1 hz2 ⊢ <;> omega)
    have h4 := hforced (2, true) (2, false) (by simp [ladder_adj]) (fun z hz1 hz2 => by
      obtain ⟨m, t⟩ := z; simp only [ladder_adj, Prod.mk.injEq] at hz1 hz2 ⊢; cases t <;> simp at hz1 hz2 ⊢ <;> omega)
    have hsub : ({mk (0, false), mk (0, true), mk (2, false), mk (2, true)} : Set (reducedVerts ladder)) ⊆
        p.toSubgraph.neighborSet (mk (1, true)) := by
      intro z hz
      simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hz
      rcases hz with rfl | rfl | rfl | rfl
      · exact h1.symm
      · exact h2.symm
      · exact h3.symm
      · exact h4.symm
    have hfin : (p.toSubgraph.neighborSet (mk (1, true))).Finite := by
      apply Set.finite_of_ncard_ne_zero
      rw [htwo _ ((hsuppv (1, true)).mpr (by simp [ladder_adj]))]
      omega
    have := Set.ncard_le_ncard hsub hfin
    rw [htwo _ ((hsuppv (1, true)).mpr (by simp [ladder_adj]))] at this
    rw [Set.ncard_insert_of_notMem (by simp [hmk]), Set.ncard_insert_of_notMem (by simp [hmk]),
      Set.ncard_pair (by simp [hmk])] at this
    omega

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

/-- A spec example for `collapse`: runs go, order and the wrap stay. -/
example : collapse [1, 1, 2, 2, 2, 3, 1, 1] = [1, 2, 3, 1] := by decide

/-- A spec example for `NoInterleave`: `[1, 2, 1, 3]` interleaves (`1 … 2 … 1 … 3`); `[1, 1, 2]` does not. -/
example : ¬ NoInterleave [1, 2, 1, 3] ∧ NoInterleave [1, 1, 2] := by
  refine ⟨fun h => ?_, ?_⟩
  · have := h 1 2 3 0 1 2 3 (by omega) (by omega) (Or.inr (by omega)) rfl rfl rfl rfl
    omega
  · intro y a b i m j n him hmj hn hi hm hj hn'
    have hj3 : j < 3 := (List.getElem?_eq_some_iff.mp hj).1
    obtain rfl : i = 0 := by omega
    obtain rfl : j = 2 := by omega
    simp only [List.getElem?_cons_zero, List.getElem?_cons_succ, Option.some.injEq] at hi hj
    omega

/-- A spec example for `ladder`: `(0, false)` is adjacent to `(0, true)` and `(1, true)`, not to `(2, false)`. -/
example : ladder.Adj (0, false) (0, true) ∧ ladder.Adj (0, false) (1, true) ∧ ¬ ladder.Adj (0, false) (2, false) := by
  simp [ladder_adj]

end HadwigerNelson.Thomassen
