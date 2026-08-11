import Proofs.HadwigerNelson.EdgeList
import Proofs.HadwigerNelson.Critical
import Proofs.HadwigerNelson.Instances.Triangle

/-!
# The pigeonhole bridge, the transmuter, and the criticality factorization (M34)

Act One of the two-act anatomy (G15/G16), as kernel vocabulary. Three pieces:

* **The bridge**: a proper `k`-colouring of `(V, E)` avoiding every monochromatic pair of a
  list `P` *is* a proper colouring of the augmented graph `(V, E ++ P)` — so a class-avoidance
  refutation is an ordinary non-colourability fact about an ordinary edge list, and the entire
  certified SAT chain (encoding, mask checker, emitters) applies to it verbatim. The entry
  point instances consume is `mono_pair_of_not_colorable_append`;
  `colorable_append_iff_exists_avoiding` is its two-way form, kept for the negative controls.

* **The transmuter** (`transmuter`): the five-vertex forcing at the heart of the nine-vertex
  √3-pair core — a centre `z`, its rainbow triangle `a b c`, and a hub `h` seeing `z, b, c`:
  if the triangle is pairwise polychromatic, the hub is forced to `a`'s colour. Decided at
  `4⁵`, every hypothesis certified load-bearing by a nine-way mutation audit. This is the
  gadget vocabulary for union assemblies: wire properness facts in, get the forced transfer
  out. Measured aside (M34 §0a B2): in the de Grey instance the transfer `h = a` happens
  across plane distance exactly 2 — the ρ₁₅ spindle distance.

* **A1, the criticality factorization** (`not_colorable_iff_covers`): `χ(G) > k` **iff**
  every proper `k`-colouring of `G.deleteIncidenceSet v` puts all `k` colours on `N_G(v)` —
  unconditionally, for any vertex `v`. When the deleted graph is `k`-colourable this reads:
  the fan at `v` is exactly `χ(G) ≥ k + 1` — so the instrument's `fan(G − v, N(v))` query
  (the min-cover ladder's top row) measures `k+1`-chromaticity itself, and M33's "the 4-onset
  arrives exactly at the last ring" is vertex-criticality worn locally, now a theorem. Two
  more readings, recorded: since `v` is isolated in the deleted graph, the right-hand side is
  `Fan (G.deleteIncidenceSet v) k v N(v)` read through `v`'s colour freedom; and Heule-510's
  fan reading at its centre + this lemma + the validated 4-colouring of `510 − v0` re-derive
  `χ(510) ≥ 5` — not re-certified here, since the LRAT bound already exists.

Nothing in this module mentions a particular witness; the instances live in
`Instances/Core9.lean` and `Instances/Core122/`.
-/

namespace HadwigerNelson

open SimpleGraph

variable {V : Type*} {G : SimpleGraph V} {k : ℕ}

/-! ## The bridge: class avoidance is colourability of the augmented graph -/

/-- A colouring makes some listed pair monochromatic. The pigeonhole conclusions are exactly
this predicate — it exists so the theorems read as the claim ("some pair of `P` goes mono")
rather than as existential soup. -/
def MonoPair {n : ℕ} (P : List (Fin n × Fin n)) (C : Fin n → Fin k) : Prop :=
  ∃ p ∈ P, C p.1 = C p.2

/-- Avoiding the class, unfolded: no listed pair is monochromatic iff every listed pair wears
two colours. The one lemma both the bridge and every instance destructure `¬ MonoPair`
through. -/
theorem not_monoPair_iff {n : ℕ} {P : List (Fin n × Fin n)} {C : Fin n → Fin k} :
    ¬ MonoPair P C ↔ ∀ p ∈ P, C p.1 ≠ C p.2 := by
  simp [MonoPair]

/-- **The construction half of the bridge.** An avoiding colouring of the base graph is a
proper colouring of the augmented graph: base edges by properness, class pairs by avoidance,
each in both orientations. No non-loop hypothesis is needed — the construction never meets a
loop. -/
theorem colorable_append_of_avoiding {n : ℕ} {E P : List (Fin n × Fin n)}
    (C : (edgeGraph n E).Coloring (Fin k)) (h : ∀ p ∈ P, C p.1 ≠ C p.2) :
    (edgeGraph n (E ++ P)).Colorable k := by
  refine ⟨Coloring.mk C ?_⟩
  rintro i j ⟨hne, hm | hm⟩
  · rcases List.mem_append.mp hm with hE | hP
    · exact C.valid (edgeGraph_adj_of_mem hne hE)
    · exact h (i, j) hP
  · rcases List.mem_append.mp hm with hE | hP
    · exact (C.valid (edgeGraph_adj_of_mem (Ne.symm hne) hE)).symm
    · exact (h (j, i) hP).symm

/-- **The bridge, the direction the certificates consume.** If the augmented graph has no
proper `k`-colouring — an LRAT certificate, a `decide`, any refutation — then every proper
`k`-colouring of the base graph makes some pair of `P` monochromatic. -/
theorem mono_pair_of_not_colorable_append {n : ℕ} {E P : List (Fin n × Fin n)}
    (h : ¬ (edgeGraph n (E ++ P)).Colorable k)
    (C : (edgeGraph n E).Coloring (Fin k)) : MonoPair P C := by
  by_contra hno
  exact h (colorable_append_of_avoiding C (not_monoPair_iff.mp hno))

/-- **The bridge, both directions.** The augmented graph is `k`-colourable exactly when some
proper `k`-colouring of the base graph avoids every listed pair. The loop-freedom hypothesis
`hP` is needed only here: a loop pair would be stripped by `edgeGraph` and could never be
avoided. -/
theorem colorable_append_iff_exists_avoiding {n : ℕ} {E P : List (Fin n × Fin n)}
    (hP : ∀ p ∈ P, p.1 ≠ p.2) :
    (edgeGraph n (E ++ P)).Colorable k ↔
      ∃ C : (edgeGraph n E).Coloring (Fin k), ¬ MonoPair P C := by
  constructor
  · rintro ⟨D⟩
    refine ⟨Coloring.mk D fun hadj =>
      D.valid (edgeGraph_adj_mono (List.subset_append_left E P) hadj), ?_⟩
    rw [not_monoPair_iff]
    intro p hp
    exact D.valid ⟨hP p hp, Or.inl (List.mem_append_right E hp)⟩
  · rintro ⟨C, hC⟩
    exact colorable_append_of_avoiding C (not_monoPair_iff.mp hC)

/-! ## The transmuter: the five-vertex forcing of the nine-vertex core -/

/-- **The transmuter.** Centre `z` sees its whole triangle `a b c`; hub `h` sees `z`, `b`,
`c` (never `a`); the triangle is pairwise polychromatic. Then the triangle is rainbow in the
three colours other than `z`'s, the hub avoids the colours of `{z, b, c}`, and exactly `a`'s
colour is left: `h = a`, forced. Four colours, five vertices, `decide`.

At the de Grey instance the five vertices are a √3-triangle, its unit circumcentre, and the
hub — and `dist h a = 2` exactly, so the forced transfer crosses the ρ₁₅ spindle distance:
the √3-avoidance hypothesis manufactures forced-equal distance-2 pairs. -/
theorem transmuter {h z a b c : Fin 4}
    (hza : z ≠ a) (hzb : z ≠ b) (hzc : z ≠ c)
    (hhz : h ≠ z) (hhb : h ≠ b) (hhc : h ≠ c)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) :
    h = a := by
  revert h z a b c
  decide

/-- **The mutation audit, one `decide`**: dropping any one of the transmuter's nine
hypotheses admits a countermodel with `h ≠ a` — every hypothesis is load-bearing. A statement
whose weakenings all still proved would have been over-hedged; this pins the opposite. -/
example :
    (∃ h z a b c : Fin 4, z ≠ b ∧ z ≠ c ∧ h ≠ z ∧ h ≠ b ∧ h ≠ c ∧
      a ≠ b ∧ a ≠ c ∧ b ≠ c ∧ h ≠ a) ∧          -- z ≠ a dropped
    (∃ h z a b c : Fin 4, z ≠ a ∧ z ≠ c ∧ h ≠ z ∧ h ≠ b ∧ h ≠ c ∧
      a ≠ b ∧ a ≠ c ∧ b ≠ c ∧ h ≠ a) ∧          -- z ≠ b dropped
    (∃ h z a b c : Fin 4, z ≠ a ∧ z ≠ b ∧ h ≠ z ∧ h ≠ b ∧ h ≠ c ∧
      a ≠ b ∧ a ≠ c ∧ b ≠ c ∧ h ≠ a) ∧          -- z ≠ c dropped
    (∃ h z a b c : Fin 4, z ≠ a ∧ z ≠ b ∧ z ≠ c ∧ h ≠ b ∧ h ≠ c ∧
      a ≠ b ∧ a ≠ c ∧ b ≠ c ∧ h ≠ a) ∧          -- h ≠ z dropped
    (∃ h z a b c : Fin 4, z ≠ a ∧ z ≠ b ∧ z ≠ c ∧ h ≠ z ∧ h ≠ c ∧
      a ≠ b ∧ a ≠ c ∧ b ≠ c ∧ h ≠ a) ∧          -- h ≠ b dropped
    (∃ h z a b c : Fin 4, z ≠ a ∧ z ≠ b ∧ z ≠ c ∧ h ≠ z ∧ h ≠ b ∧
      a ≠ b ∧ a ≠ c ∧ b ≠ c ∧ h ≠ a) ∧          -- h ≠ c dropped
    (∃ h z a b c : Fin 4, z ≠ a ∧ z ≠ b ∧ z ≠ c ∧ h ≠ z ∧ h ≠ b ∧ h ≠ c ∧
      a ≠ c ∧ b ≠ c ∧ h ≠ a) ∧                  -- a ≠ b dropped
    (∃ h z a b c : Fin 4, z ≠ a ∧ z ≠ b ∧ z ≠ c ∧ h ≠ z ∧ h ≠ b ∧ h ≠ c ∧
      a ≠ b ∧ b ≠ c ∧ h ≠ a) ∧                  -- a ≠ c dropped
    (∃ h z a b c : Fin 4, z ≠ a ∧ z ≠ b ∧ z ≠ c ∧ h ≠ z ∧ h ≠ b ∧ h ≠ c ∧
      a ≠ b ∧ a ≠ c ∧ h ≠ a) := by              -- b ≠ c dropped
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩ <;> decide

/-! ## A1: the criticality factorization -/

/-- **A1 — the criticality factorization, unconditional.** The whole graph refuses `k`
colours **iff** every proper `k`-colouring of the vertex-deleted graph (`deleteIncidenceSet`:
edges dropped, vertex kept) covers `v`'s `G`-neighbourhood with all `k` colours.

No colourability hypothesis on the deleted graph is needed: if it also refuses, both sides
are true (the coverage side vacuously). The fan interpretation — `χ(G) ≥ k + 1` factored at
`v` — is the reading when `G − v` IS `k`-colourable, which is what the instruments' base-SAT
guard establishes before any fan claim. The right-hand side is the `fan(G − v, N(v))` query
shape (the min-cover ladder's top row), and — since `v` is isolated after deletion — it is
also `Fan (G.deleteIncidenceSet v) k v N(v)` read through `v`'s colour freedom. -/
theorem not_colorable_iff_covers (v : V) :
    ¬ G.Colorable k ↔
      ∀ C : (G.deleteIncidenceSet v).Coloring (Fin k), ∀ c : Fin k,
        ∃ w, G.Adj v w ∧ C w = c := by
  constructor
  · -- the recolouring move: a colouring missing `c` on `N(v)` hands `c` to `v`
    intro hnc C c
    by_contra hno
    push Not at hno
    apply hnc
    classical
    refine ⟨Coloring.mk (fun w => if w = v then c else C w) ?_⟩
    intro x y hxy
    by_cases hx : x = v <;> by_cases hy : y = v
    · exact absurd (hx.trans hy.symm) (G.ne_of_adj hxy)
    · subst hx
      simp only [if_neg hy]
      exact fun hEq => hno y hxy hEq.symm
    · subst hy
      simp only [if_neg hx]
      exact fun hEq => hno x hxy.symm hEq
    · simp only [if_neg hx, if_neg hy]
      exact C.valid (deleteIncidenceSet_adj.mpr ⟨hxy, hx, hy⟩)
  · -- a full colouring restricts, and covers with its own colour at `v` — refused
    rintro hcov ⟨D⟩
    obtain ⟨w, hw, hCw⟩ :=
      hcov (Coloring.mk D fun hadj => D.valid (deleteIncidenceSet_adj.mp hadj).1) (D v)
    exact D.valid hw hCw.symm

/-! ## Specification — validated before any instance is trusted -/

/-- Non-vacuity and the negative control for the bridge: the star `0−1, 0−2` (base edge plus
avoidance pair) is 2-colourable, so the pigeonhole must NOT fire — an explicit avoiding
colouring exists. `fired` requires refusal; this is the refusal's absence. -/
example : (edgeGraph 3 ([(0, 1)] ++ [(0, 2)])).Colorable 2 := by
  refine ⟨Coloring.mk ![0, 1, 1] ?_⟩
  rintro i j ⟨hne, hm⟩
  fin_cases i <;> fin_cases j <;> revert hne hm <;> decide

/-- The bridge fires on the smallest genuine pigeonhole: path `0−2, 1−2` plus the pair
`{0, 1}` is `K₃`, which refuses two colours — so every proper 2-colouring of the path makes
`{0, 1}` monochromatic. Exercises the whole chain: `⊤`-comparison refutation in,
`MonoPair` out. -/
example (C : (edgeGraph 3 [(0, 2), (1, 2)]).Coloring (Fin 2)) :
    MonoPair [((0 : Fin 3), (1 : Fin 3))] C := by
  refine mono_pair_of_not_colorable_append (fun hcol => ?_) C
  have heq : edgeGraph 3 ([(0, 2), (1, 2)] ++ [(0, 1)]) = ⊤ := by
    ext i j
    simp only [edgeGraph_adj, top_adj]
    fin_cases i <;> fin_cases j <;> decide
  rw [heq] at hcol
  exact not_colorable_two_top_fin_three hcol

/-- The transmuter is not vacuous: a concrete model of all nine hypotheses. -/
example : (1 : Fin 4) = 1 :=
  transmuter (h := 1) (z := 0) (a := 1) (b := 2) (c := 3)
    (by decide) (by decide) (by decide) (by decide) (by decide)
    (by decide) (by decide) (by decide) (by decide)

/-- A1's negative control: the pendant triangle IS 3-colourable, so by A1's ← direction some
3-colouring of the pendant-deleted graph must miss a colour on the pendant's neighbourhood —
the coverage side genuinely refuses on a colourable graph. -/
example : (edgeGraph 4 pendantTriangle).Colorable 3 := by
  refine ⟨Coloring.mk ![0, 1, 2, 1] ?_⟩
  rintro i j ⟨hne, hm⟩
  fin_cases i <;> fin_cases j <;> revert hne hm <;> decide

/-- A1 read forward on the pendant triangle: since it is 3-colourable, the coverage statement
must be refutable — exhibited through `not_colorable_iff_covers`'s contrapositive. -/
example : ¬ (∀ C : ((edgeGraph 4 pendantTriangle).deleteIncidenceSet 3).Coloring (Fin 3),
    ∀ c : Fin 3, ∃ w, (edgeGraph 4 pendantTriangle).Adj 3 w ∧ C w = c) := by
  rw [← not_colorable_iff_covers]
  intro hnc
  refine hnc ⟨Coloring.mk ![0, 1, 2, 1] ?_⟩
  rintro i j ⟨hne, hm⟩
  fin_cases i <;> fin_cases j <;> revert hne hm <;> decide

end HadwigerNelson
