import Proofs.HadwigerNelson.CriticalSet

/-! # Absorption: pieces that are invisible to a pair compulsion

M55 (2026-09-06). M54 said WHERE a pair compulsion at `k + 1` colours can live (inside the critical
set's complement's reach); this module says which PIECES of a graph can never carry one. The carrier is
one property of a vertex set `A`: **`A` extends** at `k` colours when every proper `k`-colouring of the
induced subgraph `G[A]` is the restriction of a proper `k`-colouring of `G` — the restriction map on
colourings is onto. Then the compulsions of `G` among `A`'s vertices are exactly those of `G[A]`
(`Extends.forces_iff`, `Extends.separated_iff`), and if `G[A]` is `(k−1)`-colourable there are none
(`Extends.not_forces_of_colorable`) — the spare-colour lemma relative to a piece.

Every sufficient condition here is one construction, the **repaint lemma** (`extends_of_repaint`):
colour the piece with `k` colours, then repaint with the spare colour every piece vertex whose colour
clashes with a neighbour across the cut. That is proper exactly when the clashing vertices are
pairwise non-adjacent and none of them touches a spare-coloured neighbour. The instances differ only
in how the piece's colouring is chosen:

* **hub absorption** (`extends_of_hubs`): the piece splits into components each fused to the rest at
  one hub, every piece vertex has at most one neighbour across the cut, and the non-hub chords form
  a matching with pairwise non-adjacent piece endpoints. Permuting each component's palette so its
  hub wears the hub's colour makes the hub chords clash-free; the matching's clashes are repainted.
  This is the exact shape of spindle copies `Rᵢ(U − xᵢ)` hanging off one fabric `U`: each fused at
  its centre, coupled by a thin conic of chords (G12), never touching each other. **Consequence: a
  union of spindle copies at distinct centres over one fabric carries no compulsion among the
  fabric's vertices, however many copies** — the fabric is 4-colourable (Theorem B) and the copies
  are absorbed together.
* **greedy absorption** (`extends_of_extensionOrder`): vertices added to `A` one at a time, each with
  at most `k` neighbours among what is already there, are invisible at `k + 1` colours — the
  `(k+1)`-core is all a five-colour sweep can see. A single vertex of degree `≤ k` is the instance.
* **symmetric copies** (`symCopy`): two copies of a graph joined by chords between corresponding
  vertices — a spindle's ring chords `y – R(y)` with no fusion — are coloured by any palette
  permutation that moves every ring colour (`symCopy_coloring_of_perm`); the shift `c ↦ c + 1` does
  it at every `k ≥ 2` (`extends_symCopy`). Fusing a point `x` demands a permutation FIXING `c x`, and
  a ring point forced to wear `c x` makes that impossible: the spindle, in palette language.

The independence hypothesis is load-bearing: a `k`-colourable piece need not be `k`-choosable. With
three colours, `K₃,₃` whose six vertices each lose one colour to a pendant neighbour — the lists
`{0,1}, {0,2}, {1,2}` on each side — refuses (§ Spec, the planted red).

Folklore in each instance (greedy extension; list colouring of degenerate pieces); the packaging as
"what a five-colour sweep cannot see", the hub form matching the spindle construction, and the plane
consequence for copy unions are this module's.

## Which direction to reach for

| you have | you want | use |
|---|---|---|
| `A` extends, `p q ∈ A` | the compulsion in `G` is `G[A]`'s | `Extends.forces_iff`, `Extends.separated_iff` |
| `A` extends and `G[A]` is `k`-colourable | no compulsion at `k + 1` among `A` | `Extends.not_forces_of_colorable`, `Extends.not_separated_of_colorable` |
| copies fused at hubs, coupled by a thin matching | `A` extends | `extends_of_hubs` (one hub: `extends_of_hub_matching`; no hub: `extends_of_matching`) |
| a greedy order adding low-degree vertices | `A` extends | `extends_of_extensionOrder` (one vertex: `extends_compl_singleton_of_degree_le`) |
| two copies joined by symmetric chords | the first copy extends at any `k ≥ 2` | `extends_symCopy` |
| a piece colouring whose clashes are independent | `A` extends (the carrier) | `extends_of_repaint` |

Stated over an arbitrary vertex type; `Fintype`/`DecidableRel` only where a degree is counted. -/

namespace HadwigerNelson

open SimpleGraph

variable {V : Type*} {G : SimpleGraph V} {k : ℕ}

/-- **`A` extends at `k` colours**: every proper `k`-colouring of the induced subgraph `G[A]` is the
restriction of a proper `k`-colouring of `G`. -/
def Extends (G : SimpleGraph V) (A : Set V) (k : ℕ) : Prop :=
  ∀ c : (G.induce A).Coloring (Fin k), ∃ C : G.Coloring (Fin k), ∀ a : A, C a = c a

/-- The restriction of a colouring of `G` to `G[A]`. -/
def restrictColoring (A : Set V) (C : G.Coloring (Fin k)) : (G.induce A).Coloring (Fin k) :=
  C.comp (Embedding.induce A).toHom

@[simp] theorem restrictColoring_apply (A : Set V) (C : G.Coloring (Fin k)) (a : A) :
    restrictColoring A C a = C a := rfl

/-! ## D1 — the extension principle -/

/-- **Compulsions among an extending set are the induced subgraph's own** (forced-equal polarity). -/
theorem Extends.forces_iff {A : Set V} (h : Extends G A k) {p q : A} :
    Forces G k p q ↔ Forces (G.induce A) k p q := by
  sorry

/-- The same, virtual-edge polarity. -/
theorem Extends.separated_iff {A : Set V} (h : Extends G A k) {p q : A} :
    Separated G k p q ↔ Separated (G.induce A) k p q := by
  sorry

/-- **The spare-colour lemma relative to a piece**: an extending set whose induced subgraph is
`k`-colourable carries no forced-equal pair at `k + 1` colours. -/
theorem Extends.not_forces_of_colorable {A : Set V} (h : Extends G A (k + 1))
    (hA : (G.induce A).Colorable k) {p q : A} (hpq : p ≠ q) : ¬ Forces G (k + 1) p q := by
  sorry

/-- … nor a virtual edge. -/
theorem Extends.not_separated_of_colorable {A : Set V} (h : Extends G A (k + 1))
    (hA : (G.induce A).Colorable k) {p q : A} (hpq : ¬ G.Adj p q) : ¬ Separated G (k + 1) p q := by
  sorry

/-! ## The repaint lemma — the carrier -/

/-- A piece vertex `b ∉ A` **clashes** under `(c, φ)` when some neighbour across the cut wears the
colour `φ` gives `b`. -/
def Clashes (G : SimpleGraph V) (A : Set V) (c : (G.induce A).Coloring (Fin (k + 1)))
    (φ : (G.induce Aᶜ).Coloring (Fin k)) (b : (Aᶜ : Set V)) : Prop :=
  ∃ a : A, G.Adj b a ∧ c a = (φ b).castSucc

/-- **The repaint lemma.** If for every colouring `c` of `G[A]` some `k`-colouring `φ` of the piece
has pairwise non-adjacent clashing vertices, none of them adjacent to a spare-coloured vertex of
`A`, then `A` extends at `k + 1` colours: colour the piece by `φ` and repaint the clashes. -/
theorem extends_of_repaint {A : Set V}
    (h : ∀ c : (G.induce A).Coloring (Fin (k + 1)), ∃ φ : (G.induce Aᶜ).Coloring (Fin k),
      (∀ b b' : (Aᶜ : Set V), Clashes G A c φ b → Clashes G A c φ b' → ¬ G.Adj b b') ∧
      (∀ b : (Aᶜ : Set V), Clashes G A c φ b → ∀ a : A, G.Adj b a → c a ≠ Fin.last k)) :
    Extends G A (k + 1) := by
  sorry

/-! ## D2 — hub absorption -/

/-- **Hub absorption.** The piece `Aᶜ` is divided into components by a hub map `hub : V → V` into
`A` (adjacent piece vertices share a hub); each component together with its hub is `k`-colourable;
every piece vertex has at most one neighbour in `A`; and the piece vertices whose `A`-neighbour is
not their hub are pairwise non-adjacent. Then `A` extends at `k + 1` colours. -/
theorem extends_of_hubs {A : Set V} (hub : V → V) (hhub : ∀ b ∉ A, hub b ∈ A)
    (hcomp : ∀ b ∉ A, ∀ b' ∉ A, G.Adj b b' → hub b = hub b')
    (hcol : ∀ x ∈ hub '' Aᶜ, (G.induce (insert x {b' | b' ∉ A ∧ hub b' = x})).Colorable k)
    (hdeg : ∀ b ∉ A, ∀ a ∈ A, ∀ a' ∈ A, G.Adj b a → G.Adj b a' → a = a')
    (hind : ∀ b ∉ A, ∀ b' ∉ A, (∃ a ∈ A, a ≠ hub b ∧ G.Adj b a) →
      (∃ a' ∈ A, a' ≠ hub b' ∧ G.Adj b' a') → ¬ G.Adj b b') :
    Extends G A (k + 1) := by
  sorry

/-- One hub: a single piece fused at `x ∈ A` — a spindle copy `R(U − x)` over its fabric. -/
theorem extends_of_hub_matching {A : Set V} {x : V} (hx : x ∈ A)
    (hB : (G.induce (insert x Aᶜ)).Colorable k)
    (hdeg : ∀ b ∉ A, ∀ a ∈ A, ∀ a' ∈ A, G.Adj b a → G.Adj b a' → a = a')
    (hind : ∀ b ∉ A, ∀ b' ∉ A, (∃ a ∈ A, a ≠ x ∧ G.Adj b a) → (∃ a' ∈ A, a' ≠ x ∧ G.Adj b' a') →
      ¬ G.Adj b b') :
    Extends G A (k + 1) := by
  sorry

/-- No hub: a `k`-colourable piece attached by a matching with pairwise non-adjacent endpoints. -/
theorem extends_of_matching {A : Set V} (hB : (G.induce Aᶜ).Colorable k)
    (hdeg : ∀ b ∉ A, ∀ a ∈ A, ∀ a' ∈ A, G.Adj b a → G.Adj b a' → a = a')
    (hind : ∀ b ∉ A, ∀ b' ∉ A, (∃ a ∈ A, G.Adj b a) → (∃ a' ∈ A, G.Adj b' a') → ¬ G.Adj b b') :
    Extends G A (k + 1) := by
  sorry

/-! ## D3 — greedy absorption -/

/-- **A greedy extension order from `A`**: the listed vertices are added one at a time, each with
at most `k` neighbours among `A` and the vertices before it. The reverse of a `(k+1)`-core peeling. -/
inductive ExtensionOrder (G : SimpleGraph V) (k : ℕ) : Set V → List V → Prop
  | nil (A : Set V) : ExtensionOrder G k A []
  | cons {A : Set V} {b : V} {L : List V} (hb : b ∉ A) (hdeg : (G.neighborSet b ∩ A).encard ≤ k)
      (hL : ExtensionOrder G k (insert b A) L) : ExtensionOrder G k A (b :: L)

/-- A set of at most `k` colours out of `k + 1` misses one. -/
private theorem exists_notMem_of_encard_le (S : Set (Fin (k + 1))) (hS : S.encard ≤ k) :
    ∃ j, j ∉ S := by
  sorry

/-- **Greedy absorption**: if a greedy extension order from `A` exhausts the complement, `A` extends
at `k + 1` colours. Nothing outside the `(k+1)`-core is visible at `k + 1` colours. -/
theorem extends_of_extensionOrder {A : Set V} {L : List V} (hL : ExtensionOrder G k A L)
    (hall : ∀ v, v ∉ A → v ∈ L) : Extends G A (k + 1) := by
  sorry

/-- **A vertex of degree `≤ k` is invisible at `k + 1` colours**: its complement extends. -/
theorem extends_compl_singleton_of_degree_le [Fintype V] [DecidableRel G.Adj] {b : V}
    (hb : G.degree b ≤ k) : Extends G {b}ᶜ (k + 1) := by
  sorry

/-! ## D4 — symmetric copies -/

/-- Two copies of `G` joined by the chords `(a, a′)` between corresponding vertices `a ∈ S`. -/
def symCopy (G : SimpleGraph V) (S : Set V) : SimpleGraph (V ⊕ V) :=
  SimpleGraph.fromRel fun u v =>
    match u, v with
    | .inl a, .inl b => G.Adj a b
    | .inr a, .inr b => G.Adj a b
    | .inl a, .inr b => a = b ∧ a ∈ S
    | .inr a, .inl b => a = b ∧ a ∈ S

/-- **A symmetric copy is coloured by any palette permutation that moves every ring colour**:
`c` on the first copy, `π ∘ c` on the second. Fusing a point `x` would demand `π (c x) = c x`. -/
def symCopy.coloringOfPerm (S : Set V) (c : G.Coloring (Fin k)) (π : Equiv.Perm (Fin k))
    (hπ : ∀ a ∈ S, π (c a) ≠ c a) : (symCopy G S).Coloring (Fin k) :=
  SimpleGraph.Coloring.mk (Sum.elim c (π ∘ c)) (by sorry)

/-- **A symmetric copy is absorbed with no spare colour at all** (`k ≥ 2`): shift the palette by one
on the copy. A spindle's ring chords force only through the fused centre. -/
theorem extends_symCopy (S : Set V) (hk : 2 ≤ k) :
    Extends (symCopy G S) (Set.range Sum.inl) k := by
  sorry

/-! ## Spec

`K₄ − e` forces `0 = 1` at three colours (`CriticalSet.lean`). Hang a path `2 – 4 – 5` at the hub `2`
with the chord `5 – 1`: the piece `{4, 5}` with its hub is a path, `2`-colourable; each piece vertex
has one neighbour across the cut; the only non-hub-attached vertex is `5`. So `{0, 1, 2, 3}` extends
at three colours and the compulsion is untouched. The pendant `4 – 2` alone is the degree instance.
The planted red: `K₃,₃` with each vertex attached to its own pendant, the pendants coloured so that
each side's lists are `{0, 1}, {0, 2}, {1, 2}` — every side then needs two colours, four in all —
refuses: the independence hypothesis cannot be dropped. -/

/-- `K₄ − e` with the path `2 – 4 – 5` and the chord `5 – 1`. -/
def k4MinusEdgeHub : SimpleGraph (Fin 6) :=
  SimpleGraph.fromRel fun i j =>
    (i < 4 ∧ j < 4 ∧ i ≠ j ∧ ¬ ({i, j} : Finset (Fin 6)) = {0, 1}) ∨
      ({i, j} : Finset (Fin 6)) = {2, 4} ∨ ({i, j} : Finset (Fin 6)) = {4, 5} ∨
      ({i, j} : Finset (Fin 6)) = {5, 1}

instance : DecidableRel k4MinusEdgeHub.Adj := fun a b =>
  decidable_of_iff _ (SimpleGraph.fromRel_adj _ a b).symm

/-- The hub instance's hypotheses are satisfiable: the model of `extends_of_hub_matching`. -/
example : Extends k4MinusEdgeHub {i | i < 4} 3 :=
  extends_of_hub_matching (x := 2) (by decide) sorry (by decide) (by decide)

/-- `K₃,₃` on `{0,1,2} × {3,4,5}` with pendants `6, …, 11` (`i + 6 – i`). -/
def k33Pendants : SimpleGraph (Fin 12) :=
  SimpleGraph.fromRel fun i j =>
    (i < 3 ∧ 3 ≤ j ∧ j < 6) ∨ (j < 6 ∧ i = j + 6)

instance : DecidableRel k33Pendants.Adj := fun a b =>
  decidable_of_iff _ (SimpleGraph.fromRel_adj _ a b).symm

/-- The finite heart of the red: no proper 3-colouring of `K₃,₃` avoids the lists
`{0,1}, {0,2}, {1,2}` on each side — every colouring hits a forbidden colour `2, 1, 0, 2, 1, 0`. -/
theorem k33_lists_refuse :
    ∀ f : Fin 6 → Fin 3, (∀ i j : Fin 6, i < 3 → 3 ≤ j → f i ≠ f j) →
      ∃ i, f i = ![2, 1, 0, 2, 1, 0] i := by
  sorry

/-- **The planted red**: with the pendants coloured `2, 1, 0, 2, 1, 0` the six lists are
`{0,1}, {0,2}, {1,2}` per side and `K₃,₃` refuses — the pendants' set does NOT extend at three
colours, although the piece is `2`-colourable and every piece vertex has exactly one neighbour across
the cut. -/
example : ¬ Extends k33Pendants {i | 6 ≤ i} 3 := by
  sorry

end HadwigerNelson
