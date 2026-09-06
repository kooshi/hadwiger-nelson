import Proofs.HadwigerNelson.CriticalSet

/-! # Absorption: pieces that are invisible to a pair compulsion

M55 (2026-09-06). M54 said WHERE a pair compulsion at `k + 1` colours can live (inside the critical
set's complement's reach); this module says which PIECES of a graph can never carry one. The carrier is
one property of a vertex set `A`: **`A` extends** at `k` colours when every proper `k`-colouring of the
induced subgraph `G[A]` is the restriction of a proper `k`-colouring of `G`. Then the compulsions of `G`
among `A`'s vertices are exactly those of `G[A]` (`Extends.forces_iff`, `Extends.separated_iff`), and
if `G[A]` is `(k−1)`-colourable there are none (`Extends.not_forces_of_colorable`) — the spare-colour
lemma relative to a piece.

Three sufficient conditions, each a construction:

* **hub-and-matching absorption** (`extends_of_hub_matching`): the complement `B` attaches to `A`
  through one hub `x ∈ A` and otherwise a matching whose `B`-endpoints are pairwise non-adjacent, and
  `G[B ∪ {x}]` is `k`-colourable. A `k`-colouring of `B ∪ {x}` with the hub's colour permuted onto
  `c x` handles the hub's chords with no spare colour; the matching's conflicts are repainted with the
  spare colour. This is the exact shape of a spindle copy `R(U − x)` hanging off its fabric `U`: fused
  at the centre, coupled by a thin conic of chords (G12). **Consequence: a union of spindle copies at
  distinct centres over one fabric never carries a compulsion among the fabric's vertices, however
  many copies there are** — the fabric is 4-colourable (Theorem B) and each copy is absorbed in turn.
* **degree absorption** (`extends_compl_singleton_of_degree_le`): a vertex of degree `≤ k` is invisible
  at `k + 1` colours; iterated, nothing outside the `(k+1)`-core is.
* **symmetric copies** (`extends_symCopy`): two copies of a graph joined by chords between
  corresponding vertices — a spindle's ring chords `y – R(y)` with no fusion — extend every colouring
  at every `k ≥ 2` by the shift `c ↦ c + 1`: a spindle forces only through its fused point.

The hypothesis that the matching's endpoints are independent is load-bearing: a `k`-colourable piece
need not be `k`-choosable, and `K₂,₄` attached by a matching with adjacent endpoints refuses a
3-colouring of its attachment points (the planted red, § Spec).

Folklore in each instance (greedy extension; list-colouring of degenerate pieces); the packaging as
"what a five-colour sweep cannot see", with the hub form that matches the spindle construction and
the plane consequence for copy unions, is this module's.

## Which direction to reach for

| you have | you want | use |
|---|---|---|
| `A` extends, `p q ∈ A` | the compulsion in `G` is `G[A]`'s | `Extends.forces_iff`, `Extends.separated_iff` |
| `A` extends and `G[A]` is `k`-colourable | no compulsion at `k + 1` among `A` | `Extends.not_forces_of_colorable`, `Extends.not_separated_of_colorable` |
| a copy fused at a hub, coupled by a thin matching | `A` extends | `extends_of_hub_matching` (no hub: `extends_of_matching`) |
| a vertex of degree `≤ k` | its complement extends at `k + 1` | `extends_compl_singleton_of_degree_le` |
| two copies joined by symmetric chords | the first copy extends at any `k ≥ 2` | `extends_symCopy` |

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

/-! ## D2 — hub-and-matching absorption -/

/-- **A piece attached by a matching with independent endpoints, itself `k`-colourable, is absorbed
at `k + 1` colours**: every vertex outside `A` has at most one neighbour in `A`, the attached outside
vertices are pairwise non-adjacent, and `G[Aᶜ]` is `k`-colourable. -/
theorem extends_of_matching {A : Set V} (hB : (G.induce Aᶜ).Colorable k)
    (hdeg : ∀ b ∉ A, ∀ a ∈ A, ∀ a' ∈ A, G.Adj b a → G.Adj b a' → a = a')
    (hind : ∀ b ∉ A, ∀ b' ∉ A, (∃ a ∈ A, G.Adj b a) → (∃ a' ∈ A, G.Adj b' a') → ¬ G.Adj b b') :
    Extends G A (k + 1) := by
  sorry

/-- **Hub-and-matching absorption**: the piece `B = Aᶜ` attaches to `A` through a hub `x ∈ A` and
otherwise through a matching with pairwise non-adjacent `B`-endpoints, and `G[B ∪ {x}]` is
`k`-colourable. Then `A` extends at `k + 1` colours — the hub's chords cost no spare colour (permute
the piece's palette so the hub wears `c x`), the matching's conflicts are repainted with it. -/
theorem extends_of_hub_matching {A : Set V} {x : V} (hx : x ∈ A)
    (hB : (G.induce (insert x Aᶜ)).Colorable k)
    (hdeg : ∀ b ∉ A, ∀ a ∈ A, ∀ a' ∈ A, G.Adj b a → G.Adj b a' → a = a')
    (hind : ∀ b ∉ A, ∀ b' ∉ A, (∃ a ∈ A, a ≠ x ∧ G.Adj b a) → (∃ a' ∈ A, a' ≠ x ∧ G.Adj b' a') →
      ¬ G.Adj b b') :
    Extends G A (k + 1) := by
  sorry

/-! ## D3 — degree absorption -/

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

/-- **A symmetric copy is absorbed with no spare colour at all** (`k ≥ 2`): shift the palette by one
on the copy. A spindle's ring chords force only through the fused centre. -/
theorem extends_symCopy (S : Set V) (hk : 2 ≤ k) :
    Extends (symCopy G S) (Set.range Sum.inl) k := by
  sorry

/-! ## Spec

`K₄` minus the edge `{0, 1}` forces `0 = 1` at three colours (`CriticalSet.lean`). A pendant vertex `4`
adjacent to `2` alone has degree `1 ≤ 2`, so `{4}ᶜ` extends at three colours and the compulsion on
`{0, 1, 2, 3}` is unchanged. The planted red: `K₂,₄` attached by a matching whose endpoints are
adjacent refuses a 3-colouring of the attachment vertices, so the independence hypothesis of
`extends_of_matching` cannot be dropped. -/

/-- `K₄ − e` with a pendant vertex `4 – 2`. -/
def k4MinusEdgePendant : SimpleGraph (Fin 5) :=
  SimpleGraph.fromRel fun i j =>
    i ≠ j ∧ ¬ ({i, j} : Finset (Fin 5)) = {0, 1} ∧ (i ≠ 4 ∧ j ≠ 4 ∨ ({i, j} : Finset (Fin 5)) = {2, 4})

instance : DecidableRel k4MinusEdgePendant.Adj := fun a b =>
  decidable_of_iff _ (SimpleGraph.fromRel_adj _ a b).symm

example : Extends k4MinusEdgePendant {4}ᶜ 3 :=
  extends_compl_singleton_of_degree_le (by decide)

end HadwigerNelson
