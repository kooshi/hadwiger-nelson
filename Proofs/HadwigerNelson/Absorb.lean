import Proofs.HadwigerNelson.CriticalSet
import Proofs.HadwigerNelson.SpareColour
import Mathlib.Logic.Equiv.Fin.Rotate

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
  permutation that moves every ring colour (`symCopy.coloringOfPerm`); the rotation `c ↦ c + 1` does
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
| `A` extends, `p q : A` | the compulsion in `G` is `G[A]`'s | `Extends.forces_iff`, `Extends.separated_iff` |
| `A` extends, `G[A]` `k`-colourable, `p ∈ A`, `q ∈ A` | no compulsion at `k + 1` between them | `Extends.not_forces_of_colorable`, `Extends.not_separated_of_colorable` |
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

/-- Adjacency in an induced subgraph is adjacency in `G` (definitional). Not a simp lemma: `simp` already
reaches it through `SimpleGraph.comap_adj`, and the linter says so. -/
theorem induce_adj {A : Set V} {a b : A} : (G.induce A).Adj a b ↔ G.Adj a b := Iff.rfl

/-- The restriction of a colouring of `G` to `G[A]`. -/
def restrictColoring (A : Set V) (C : G.Coloring (Fin k)) : (G.induce A).Coloring (Fin k) :=
  C.comp (Embedding.induce A).toHom

@[simp] theorem restrictColoring_apply (A : Set V) (C : G.Coloring (Fin k)) (a : A) :
    restrictColoring A C a = C a := rfl

/-! ## D1 — the extension principle -/

/-- **Compulsions among an extending set are the induced subgraph's own** (forced-equal polarity). -/
theorem Extends.forces_iff {A : Set V} (h : Extends G A k) {p q : A} :
    Forces G k p q ↔ Forces (G.induce A) k p q := by
  constructor
  · intro hF c
    obtain ⟨C, hC⟩ := h c
    rw [← hC p, ← hC q]
    exact hF C
  · intro hF C
    exact hF (restrictColoring A C)

/-- The same, virtual-edge polarity. -/
theorem Extends.separated_iff {A : Set V} (h : Extends G A k) {p q : A} :
    Separated G k p q ↔ Separated (G.induce A) k p q := by
  constructor
  · intro hS c
    obtain ⟨C, hC⟩ := h c
    rw [← hC p, ← hC q]
    exact hS C
  · intro hS C
    exact hS (restrictColoring A C)

/-- **The spare-colour lemma relative to a piece**: an extending set whose induced subgraph is
`k`-colourable carries no forced-equal pair at `k + 1` colours. -/
theorem Extends.not_forces_of_colorable {A : Set V} (h : Extends G A (k + 1))
    (hA : (G.induce A).Colorable k) {p q : V} (hp : p ∈ A) (hq : q ∈ A) (hpq : p ≠ q) :
    ¬ Forces G (k + 1) p q := fun hF =>
  HadwigerNelson.not_forces_of_colorable hA (p := ⟨p, hp⟩) (q := ⟨q, hq⟩)
    (fun h' => hpq (congrArg Subtype.val h')) ((h.forces_iff (p := ⟨p, hp⟩) (q := ⟨q, hq⟩)).mp hF)

/-- … nor a virtual edge. -/
theorem Extends.not_separated_of_colorable {A : Set V} (h : Extends G A (k + 1))
    (hA : (G.induce A).Colorable k) {p q : V} (hp : p ∈ A) (hq : q ∈ A) (hpq : ¬ G.Adj p q) :
    ¬ Separated G (k + 1) p q := fun hS =>
  HadwigerNelson.not_separated_of_colorable hA (p := ⟨p, hp⟩) (q := ⟨q, hq⟩)
    (show ¬ (G.induce A).Adj ⟨p, hp⟩ ⟨q, hq⟩ from hpq)
    ((h.separated_iff (p := ⟨p, hp⟩) (q := ⟨q, hq⟩)).mp hS)

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
  classical
  intro c
  obtain ⟨φ, hind, hlast⟩ := h c
  let f : V → Fin (k + 1) := fun v =>
    if hv : v ∈ A then c ⟨v, hv⟩
    else if Clashes G A c φ ⟨v, hv⟩ then Fin.last k else (φ ⟨v, hv⟩).castSucc
  -- across the cut: the piece end repainted (no spare neighbour) or not (no clash)
  have hcut : ∀ {v w : V}, G.Adj v w → v ∈ A → w ∉ A → f v ≠ f w := by
    intro v w hvw hv hw
    simp only [f, dif_pos hv, dif_neg hw]
    split_ifs with hcl
    · exact hlast ⟨w, hw⟩ hcl ⟨v, hv⟩ hvw.symm
    · intro heq
      exact hcl ⟨⟨v, hv⟩, hvw.symm, heq⟩
  have hvalid : ∀ {v w : V}, G.Adj v w → f v ≠ f w := by
    intro v w hvw
    by_cases hv : v ∈ A <;> by_cases hw : w ∈ A
    · simp only [f, dif_pos hv, dif_pos hw]
      exact c.valid (show (G.induce A).Adj ⟨v, hv⟩ ⟨w, hw⟩ from hvw)
    · exact hcut hvw hv hw
    · exact (hcut hvw.symm hw hv).symm
    · simp only [f, dif_neg hv, dif_neg hw]
      split_ifs with h1 h2 h2
      · exact absurd hvw (hind ⟨v, hv⟩ ⟨w, hw⟩ h1 h2)
      · exact ((φ ⟨w, hw⟩).castSucc_lt_last).ne'
      · exact ((φ ⟨v, hv⟩).castSucc_lt_last).ne
      · intro heq
        exact φ.valid (show (G.induce Aᶜ).Adj ⟨v, hv⟩ ⟨w, hw⟩ from hvw)
          (Fin.castSucc_injective k heq)
  refine ⟨SimpleGraph.Coloring.mk f hvalid, fun a => ?_⟩
  show f a = c a
  exact dif_pos a.2

/-! ## D2 — hub absorption -/

/-- **Hub absorption.** The piece `Aᶜ` is divided into components by a hub map `hub : V → V` into
`A` (adjacent piece vertices share a hub); the piece has a `k`-colouring `ψ` together with one
designated colour `h x` per hub that every piece neighbour of `x` avoids (glue the `k`-colourings of
the components-with-hub, taking `h x` to be the hub's own colour); every piece vertex has at most one
neighbour in `A`; and the piece vertices whose `A`-neighbour is not their hub are pairwise
non-adjacent. Then `A` extends at `k + 1` colours: permute each component's palette so `h x` becomes
the colour `A` gives the hub, then repaint the matching's clashes. -/
theorem extends_of_hubs {A : Set V} (hub : V → V) (hhub : ∀ b ∉ A, hub b ∈ A)
    (hcomp : ∀ b ∉ A, ∀ b' ∉ A, G.Adj b b' → hub b = hub b')
    (hcol : ∃ ψ : (G.induce Aᶜ).Coloring (Fin k), ∃ h : V → Fin k,
      ∀ b : (Aᶜ : Set V), G.Adj b (hub b) → ψ b ≠ h (hub b))
    (hdeg : ∀ b ∉ A, ∀ a ∈ A, ∀ a' ∈ A, G.Adj b a → G.Adj b a' → a = a')
    (hind : ∀ b ∉ A, ∀ b' ∉ A, (∃ a ∈ A, a ≠ hub b ∧ G.Adj b a) →
      (∃ a' ∈ A, a' ≠ hub b' ∧ G.Adj b' a') → ¬ G.Adj b b') :
    Extends G A (k + 1) := by
  classical
  obtain ⟨ψ, h, hψ⟩ := hcol
  refine extends_of_repaint fun c => ?_
  -- the colour each hub must wear (its `A`-colour, unless that is the spare colour)
  let j : V → Fin k := fun x =>
    if hx : x ∈ A then (if hl : c ⟨x, hx⟩ = Fin.last k then h x else (c ⟨x, hx⟩).castPred hl)
    else h x
  let σ : V → Equiv.Perm (Fin k) := fun x => Equiv.swap (h x) (j x)
  let φ : (G.induce Aᶜ).Coloring (Fin k) :=
    SimpleGraph.Coloring.mk (fun b => σ (hub b) (ψ b)) (by
      intro b b' hbb' heq
      have e := hcomp b b.2 b' b'.2 hbb'
      rw [e] at heq
      exact ψ.valid hbb' ((σ (hub b')).injective heq))
  -- a hub chord never clashes: the hub's colour is exactly what its piece neighbours avoid
  have hnohub : ∀ b : (Aᶜ : Set V), G.Adj b (hub b) →
      c ⟨hub b, hhub b b.2⟩ ≠ (φ b).castSucc := by
    intro b hadj heq
    have hx := hhub b b.2
    have hl : c ⟨hub b, hx⟩ ≠ Fin.last k := by
      rw [heq]; exact (Fin.castSucc_lt_last _).ne
    have hjv : j (hub b) = (c ⟨hub b, hx⟩).castPred hl := by
      simp only [j, dif_pos hx, dif_neg hl]
    have hσ : σ (hub b) (ψ b) = σ (hub b) (h (hub b)) := by
      rw [show σ (hub b) (h (hub b)) = j (hub b) from Equiv.swap_apply_left _ _, hjv]
      apply Fin.castSucc_injective k
      rw [Fin.castSucc_castPred]
      exact heq.symm
    exact hψ b hadj ((σ (hub b)).injective hσ)
  refine ⟨φ, ?_, ?_⟩
  · rintro b b' ⟨a, hba, hca⟩ ⟨a', hb'a', hc'a'⟩
    refine hind b b.2 b' b'.2 ⟨a, a.2, ?_, hba⟩ ⟨a', a'.2, ?_, hb'a'⟩
    · intro hax
      obtain rfl : a = ⟨hub b, hhub b b.2⟩ := Subtype.ext hax
      exact hnohub b hba hca
    · intro hax
      obtain rfl : a' = ⟨hub b', hhub b' b'.2⟩ := Subtype.ext hax
      exact hnohub b' hb'a' hc'a'
  · rintro b ⟨a, hba, hca⟩ a' hba'
    have e := hdeg b b.2 a a.2 a' a'.2 hba hba'
    obtain rfl : a' = a := Subtype.ext e.symm
    rw [hca]
    exact (Fin.castSucc_lt_last _).ne

/-- One hub: a single piece fused at `x ∈ A`, with the piece-plus-hub `k`-colourable — a spindle
copy `R(U − x)` over its fabric. -/
theorem extends_of_hub_matching {A : Set V} {x : V} (hx : x ∈ A)
    (hB : (G.induce (insert x Aᶜ)).Colorable k)
    (hdeg : ∀ b ∉ A, ∀ a ∈ A, ∀ a' ∈ A, G.Adj b a → G.Adj b a' → a = a')
    (hind : ∀ b ∉ A, ∀ b' ∉ A, (∃ a ∈ A, a ≠ x ∧ G.Adj b a) → (∃ a' ∈ A, a' ≠ x ∧ G.Adj b' a') →
      ¬ G.Adj b b') :
    Extends G A (k + 1) := by
  obtain ⟨C⟩ := hB
  refine extends_of_hubs (fun _ => x) (fun _ _ => hx) (fun _ _ _ _ _ => rfl) ?_ hdeg hind
  refine ⟨C.comp (G.induceHomOfLE (Set.subset_insert x Aᶜ)).toHom,
    fun _ => C ⟨x, Set.mem_insert x _⟩, ?_⟩
  intro b hadj heq
  exact C.valid (show (G.induce (insert x Aᶜ)).Adj ⟨b, Set.mem_insert_of_mem x b.2⟩
    ⟨x, Set.mem_insert x _⟩ from hadj) heq

/-- No hub: a `k`-colourable piece attached by a matching with pairwise non-adjacent endpoints. -/
theorem extends_of_matching {A : Set V} (hB : (G.induce Aᶜ).Colorable k)
    (hdeg : ∀ b ∉ A, ∀ a ∈ A, ∀ a' ∈ A, G.Adj b a → G.Adj b a' → a = a')
    (hind : ∀ b ∉ A, ∀ b' ∉ A, (∃ a ∈ A, G.Adj b a) → (∃ a' ∈ A, G.Adj b' a') → ¬ G.Adj b b') :
    Extends G A (k + 1) := by
  obtain ⟨φ⟩ := hB
  refine extends_of_repaint fun c => ⟨φ, ?_, ?_⟩
  · rintro b b' ⟨a, hba, -⟩ ⟨a', hb'a', -⟩
    exact hind b b.2 b' b'.2 ⟨a, a.2, hba⟩ ⟨a', a'.2, hb'a'⟩
  · rintro b ⟨a, hba, hca⟩ a' hba'
    have e := hdeg b b.2 a a.2 a' a'.2 hba hba'
    obtain rfl : a' = a := Subtype.ext e.symm
    rw [hca]
    exact (Fin.castSucc_lt_last _).ne

/-! ## D3 — greedy absorption -/

/-- **A greedy extension order from `A`**: the listed vertices are added one at a time, each with
at most `k` neighbours among `A` and the vertices before it. The reverse of a `(k+1)`-core peeling. -/
inductive ExtensionOrder (G : SimpleGraph V) (k : ℕ) : Set V → List V → Prop
  /-- Nothing left to add. -/
  | nil (A : Set V) : ExtensionOrder G k A []
  /-- Add `b ∉ A`, which has at most `k` neighbours in `A`, then continue from `insert b A`. -/
  | cons {A : Set V} {b : V} {L : List V} (hb : b ∉ A) (hdeg : (G.neighborSet b ∩ A).encard ≤ k)
      (hL : ExtensionOrder G k (insert b A) L) : ExtensionOrder G k A (b :: L)

/-- A set of at most `k` colours out of `k + 1` misses one. -/
private theorem exists_notMem_of_encard_le (S : Set (Fin (k + 1))) (hS : S.encard ≤ k) :
    ∃ j, j ∉ S := by
  by_contra hcon
  have hall : ∀ j, j ∈ S := fun j => Classical.byContradiction fun hj => hcon ⟨j, hj⟩
  rw [Set.eq_univ_of_forall hall, Set.encard_univ, ENat.card_eq_coe_fintype_card,
    Fintype.card_fin] at hS
  norm_cast at hS
  omega

/-- **Greedy absorption**: if a greedy extension order from `A` exhausts the complement, `A` extends
at `k + 1` colours. Nothing outside the `(k+1)`-core is visible at `k + 1` colours. -/
theorem extends_of_extensionOrder {A : Set V} {L : List V} (hL : ExtensionOrder G k A L)
    (hall : ∀ v, v ∉ A → v ∈ L) : Extends G A (k + 1) := by
  classical
  revert hall
  induction hL with
  | nil A =>
    intro hall c
    have hA : ∀ v, v ∈ A := fun v => by
      by_contra hv
      exact List.not_mem_nil (hall v hv)
    refine ⟨SimpleGraph.Coloring.mk (fun v => c ⟨v, hA v⟩) ?_, fun a => rfl⟩
    intro v w hvw
    exact c.valid (show (G.induce A).Adj ⟨v, hA v⟩ ⟨w, hA w⟩ from hvw)
  | @cons A b L hb hdeg _ ih =>
    intro hall
    have hall' : ∀ v, v ∉ insert b A → v ∈ L := by
      intro v hv
      have h1 : v ∉ A := fun h => hv (Set.mem_insert_of_mem b h)
      rcases List.mem_cons.mp (hall v h1) with rfl | h
      · exact absurd (Set.mem_insert v A) hv
      · exact h
    have hE : Extends G (insert b A) (k + 1) := ih hall'
    intro c
    -- a colour free at `b`: its `≤ k` neighbours in `A` use at most `k`
    let S : Set (Fin (k + 1)) := c '' {a : A | G.Adj b a}
    have hS : S.encard ≤ k := by
      calc S.encard ≤ ({a : A | G.Adj b a} : Set A).encard := Set.encard_image_le _ _
        _ = (Subtype.val '' {a : A | G.Adj b a}).encard :=
            (Subtype.val_injective.encard_image _).symm
        _ = (G.neighborSet b ∩ A).encard := by
            congr 1
            ext v
            simp only [Set.mem_image, Set.mem_setOf_eq, Set.mem_inter_iff,
              SimpleGraph.mem_neighborSet]
            constructor
            · rintro ⟨⟨a, ha⟩, hadj, rfl⟩
              exact ⟨hadj, ha⟩
            · rintro ⟨hadj, hv⟩
              exact ⟨⟨v, hv⟩, hadj, rfl⟩
        _ ≤ k := hdeg
    obtain ⟨j, hj⟩ := exists_notMem_of_encard_le S hS
    have memb : ∀ v : (insert b A : Set V), (v : V) ∉ A → (v : V) = b := fun v hv =>
      (Set.mem_insert_iff.mp v.2).resolve_right hv
    let c' : (G.induce (insert b A)).Coloring (Fin (k + 1)) :=
      SimpleGraph.Coloring.mk (fun v => if hv : (v : V) ∈ A then c ⟨v, hv⟩ else j) (by
        intro v w hvw
        by_cases hv : (v : V) ∈ A <;> by_cases hw : (w : V) ∈ A
        · simp only [dif_pos hv, dif_pos hw]
          exact c.valid (show (G.induce A).Adj ⟨v, hv⟩ ⟨w, hw⟩ from hvw)
        · simp only [dif_pos hv, dif_neg hw]
          intro heq
          apply hj
          refine ⟨⟨v, hv⟩, ?_, heq⟩
          have hwv : G.Adj (w : V) v := hvw.symm
          rw [memb w hw] at hwv
          exact hwv
        · simp only [dif_neg hv, dif_pos hw]
          intro heq
          apply hj
          refine ⟨⟨w, hw⟩, ?_, heq.symm⟩
          have hvw' : G.Adj (v : V) w := hvw
          rw [memb v hv] at hvw'
          exact hvw'
        · exfalso
          have : G.Adj (v : V) w := hvw
          rw [memb v hv, memb w hw] at this
          exact G.irrefl this)
    obtain ⟨C, hC⟩ := hE c'
    refine ⟨C, fun a => ?_⟩
    rw [hC ⟨a, Set.mem_insert_of_mem b a.2⟩]
    show (if hv : (a : V) ∈ A then c ⟨a, hv⟩ else j) = c a
    rw [dif_pos a.2]

/-- **A vertex of degree `≤ k` is invisible at `k + 1` colours**: its complement extends. -/
theorem extends_compl_singleton_of_degree_le [Fintype V] [DecidableRel G.Adj] {b : V}
    (hb : G.degree b ≤ k) : Extends G {b}ᶜ (k + 1) := by
  refine extends_of_extensionOrder (L := [b])
    (ExtensionOrder.cons (by simp) ?_ (ExtensionOrder.nil _)) ?_
  · have hN : G.neighborSet b ∩ {b}ᶜ = G.neighborSet b := by
      ext v
      simp only [Set.mem_inter_iff, SimpleGraph.mem_neighborSet, Set.mem_compl_iff,
        Set.mem_singleton_iff, and_iff_left_iff_imp]
      exact fun h hv => G.ne_of_adj h hv.symm
    rw [hN, ← SimpleGraph.coe_neighborFinset, Set.encard_coe_eq_coe_finsetCard]
    exact_mod_cast hb
  · intro v hv
    simp only [Set.mem_compl_iff, Set.mem_singleton_iff, not_not] at hv
    simp [hv]

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
  SimpleGraph.Coloring.mk (Sum.elim c (π ∘ c)) (by
    intro u v huv
    rcases u with a | a <;> rcases v with b | b <;>
      simp only [symCopy, SimpleGraph.fromRel_adj, ne_eq, Sum.inl.injEq, Sum.inr.injEq,
        reduceCtorEq, not_false_eq_true, true_and, Sum.elim_inl, Sum.elim_inr,
        Function.comp_apply] at huv ⊢
    · exact c.valid (huv.2.elim id Adj.symm)
    · rcases huv with ⟨rfl, hS⟩ | ⟨rfl, hS⟩ <;> exact (hπ _ hS).symm
    · rcases huv with ⟨rfl, hS⟩ | ⟨rfl, hS⟩ <;> exact hπ _ hS
    · intro heq
      exact c.valid (huv.2.elim id Adj.symm) (π.injective heq))

/-- **A symmetric copy is absorbed with no spare colour at all** (`k ≥ 2`): rotate the palette by one
on the copy. A spindle's ring chords force only through the fused centre. -/
theorem extends_symCopy (S : Set V) (hk : 2 ≤ k) :
    Extends (symCopy G S) (Set.range Sum.inl) k := by
  obtain ⟨n, rfl⟩ : ∃ n, k = n + 2 := ⟨k - 2, by omega⟩
  intro c'
  let c : G.Coloring (Fin (n + 2)) :=
    SimpleGraph.Coloring.mk (fun a => c' ⟨Sum.inl a, a, rfl⟩) (by
      intro a b hab
      apply c'.valid
      show (symCopy G S).Adj (Sum.inl a) (Sum.inl b)
      simp only [symCopy, SimpleGraph.fromRel_adj, ne_eq, Sum.inl.injEq]
      exact ⟨G.ne_of_adj hab, Or.inl hab⟩)
  have hrot : ∀ i : Fin (n + 2), finRotate (n + 2) i ≠ i := by
    rintro ⟨v, hv⟩ h
    by_cases hlt : v < n + 1
    · rw [finRotate_of_lt hlt, Fin.ext_iff] at h
      simp at h
    · have hvl : v = n + 1 := by omega
      subst hvl
      rw [finRotate_last', Fin.ext_iff] at h
      simp at h
  have hπ : ∀ a ∈ S, finRotate (n + 2) (c a) ≠ c a := fun a _ => hrot (c a)
  refine ⟨symCopy.coloringOfPerm S c (finRotate (n + 2)) hπ, ?_⟩
  rintro ⟨_, a, rfl⟩
  rfl

/-! ## Spec

`K₄ − e` forces `0 = 1` at three colours (`CriticalSet.lean`). Hang a path `2 – 4 – 5` at the hub `2`
with the chord `5 – 1`: the piece `{4, 5}` with its hub is a path, `2`-colourable; each piece vertex
has one neighbour across the cut; the only non-hub-attached vertex is `5`. So `{0, 1, 2, 3}` extends
at three colours and the compulsion is untouched. The planted red: `K₃,₃` with each vertex attached
to its own pendant, the pendants coloured so that each side's lists are `{0, 1}, {0, 2}, {1, 2}` —
every side then needs two colours, four in all — refuses: the independence hypothesis cannot be
dropped. -/

/-- `K₄ − e` with the path `2 – 4 – 5` and the chord `5 – 1`. -/
def k4MinusEdgeHub : SimpleGraph (Fin 6) :=
  SimpleGraph.fromRel fun i j =>
    (i < 4 ∧ j < 4 ∧ i ≠ j ∧ ¬ ({i, j} : Finset (Fin 6)) = {0, 1}) ∨
      ({i, j} : Finset (Fin 6)) = {2, 4} ∨ ({i, j} : Finset (Fin 6)) = {4, 5} ∨
      ({i, j} : Finset (Fin 6)) = {5, 1}

instance : DecidableRel k4MinusEdgeHub.Adj := fun a b =>
  decidable_of_iff _ (SimpleGraph.fromRel_adj _ a b).symm

/-- The intended edge list, pinned: five of `K₄ − e`, the path, the chord. -/
example : k4MinusEdgeHub.edgeFinset.card = 8 := by decide

/-- Membership in the hub instance's piece-plus-hub set, decided. -/
instance decidablePredMemHubPiece : DecidablePred (· ∈ insert (2 : Fin 6) {i : Fin 6 | i < 4}ᶜ) := fun i =>
  decidable_of_iff (i = 2 ∨ ¬ i < 4) (by simp [Set.mem_insert_iff])

/-- The hub instance's hypotheses are satisfiable — the model of `extends_of_hub_matching`: the piece
`{4, 5}` with its hub `2` is the path `2 – 4 – 5`, coloured `0, 1, 0`. -/
example : Extends k4MinusEdgeHub {i | i < 4} 3 :=
  extends_of_hub_matching (x := 2) (by simp)
    ⟨SimpleGraph.Coloring.mk (fun v => if (v : Fin 6) = 4 then (1 : Fin 2) else 0) (by
      intro v w hvw
      exact (by decide : ∀ v w : Fin 6, v ∈ insert (2 : Fin 6) {i : Fin 6 | i < 4}ᶜ →
        w ∈ insert (2 : Fin 6) {i : Fin 6 | i < 4}ᶜ → k4MinusEdgeHub.Adj v w →
        (if v = 4 then (1 : Fin 2) else 0) ≠ (if w = 4 then 1 else 0)) v w v.2 w.2 hvw)⟩
    (by decide) (by decide)

/-- `K₃,₃` on `{0,1,2} × {3,4,5}` with pendants `6, …, 11` (`i + 6 – i`). -/
def k33Pendants : SimpleGraph (Fin 12) :=
  SimpleGraph.fromRel fun i j =>
    (i < 3 ∧ 3 ≤ j ∧ j < 6) ∨ (j < 6 ∧ i = j + 6)

instance : DecidableRel k33Pendants.Adj := fun a b =>
  decidable_of_iff _ (SimpleGraph.fromRel_adj _ a b).symm

/-- The intended edge list, pinned: nine of `K₃,₃`, six pendants. -/
example : k33Pendants.edgeFinset.card = 15 := by decide

/-- The finite heart of the red: no proper 3-colouring of `K₃,₃` avoids the lists
`{0,1}, {0,2}, {1,2}` on each side — every colouring hits a forbidden colour `2, 1, 0, 2, 1, 0`. -/
theorem k33_lists_refuse (f : Fin 6 → Fin 3) (hf : ∀ i j : Fin 6, i < 3 → 3 ≤ j → f i ≠ f j) :
    ∃ i, f i = ![2, 1, 0, 2, 1, 0] i := by
  have key : ∀ x0 x1 x2 y0 y1 y2 : Fin 3,
      x0 ≠ y0 → x0 ≠ y1 → x0 ≠ y2 → x1 ≠ y0 → x1 ≠ y1 → x1 ≠ y2 → x2 ≠ y0 → x2 ≠ y1 → x2 ≠ y2 →
      x0 = 2 ∨ x1 = 1 ∨ x2 = 0 ∨ y0 = 2 ∨ y1 = 1 ∨ y2 = 0 := by decide
  rcases key (f 0) (f 1) (f 2) (f 3) (f 4) (f 5)
      (hf 0 3 (by decide) (by decide)) (hf 0 4 (by decide) (by decide))
      (hf 0 5 (by decide) (by decide)) (hf 1 3 (by decide) (by decide))
      (hf 1 4 (by decide) (by decide)) (hf 1 5 (by decide) (by decide))
      (hf 2 3 (by decide) (by decide)) (hf 2 4 (by decide) (by decide))
      (hf 2 5 (by decide) (by decide)) with h | h | h | h | h | h
  · exact ⟨0, h⟩
  · exact ⟨1, h⟩
  · exact ⟨2, h⟩
  · exact ⟨3, h⟩
  · exact ⟨4, h⟩
  · exact ⟨5, h⟩

/-- **The planted red**: with the pendants coloured `2, 1, 0, 2, 1, 0` the six lists are
`{0,1}, {0,2}, {1,2}` per side and `K₃,₃` refuses — the pendants' set does NOT extend at three
colours, although the piece is `2`-colourable and every piece vertex has exactly one neighbour across
the cut. -/
example : ¬ Extends k33Pendants {i | 6 ≤ i} 3 := by
  intro h
  let c : (k33Pendants.induce {i | 6 ≤ i}).Coloring (Fin 3) :=
    SimpleGraph.Coloring.mk (fun v => ![2, 1, 0, 2, 1, 0] ⟨(v : Fin 12).val - 6, by
      have := (v : Fin 12).isLt; omega⟩) (by
      intro v w hvw
      exact absurd hvw ((by decide : ∀ v w : Fin 12, 6 ≤ v → 6 ≤ w → ¬ k33Pendants.Adj v w)
        v w v.2 w.2))
  obtain ⟨C, hC⟩ := h c
  have hadj : ∀ i j : Fin 6, i < 3 → 3 ≤ j →
      k33Pendants.Adj (Fin.castLE (by norm_num) i) (Fin.castLE (by norm_num) j) := by decide
  obtain ⟨i, hi⟩ := k33_lists_refuse (fun i => C (Fin.castLE (by norm_num) i))
    (fun i j hi hj => C.valid (hadj i j hi hj))
  have hpend : ∀ i : Fin 6, k33Pendants.Adj (Fin.castLE (by norm_num) i) (Fin.natAdd 6 i) := by
    decide
  have hmem : (Fin.natAdd 6 i : Fin 12) ∈ {i : Fin 12 | 6 ≤ i} := by
    show 6 ≤ Fin.natAdd 6 i
    rw [Fin.le_def]
    simp [Fin.natAdd]
  have hp := hC ⟨Fin.natAdd 6 i, hmem⟩
  have hcol : c ⟨Fin.natAdd 6 i, hmem⟩ = ![2, 1, 0, 2, 1, 0] i := by
    show ![2, 1, 0, 2, 1, 0] ⟨(Fin.natAdd 6 i).val - 6, _⟩ = ![2, 1, 0, 2, 1, 0] i
    congr 1
    ext
    simp [Fin.natAdd]
  exact C.valid (hpend i) (hi.trans (hcol.symm.trans hp.symm))

end HadwigerNelson
