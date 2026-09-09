import Proofs.HadwigerNelson.Fan

/-!
# Compulsions are about the palette's size, not about `Fin k`

`Forces G k p q` and `Separated G k p q` (`Forcer.lean`, `Fan.lean`) quantify over
`G.Coloring (Fin k)`, and that is the right choice: `SimpleGraph.Colorable` quantifies over `Fin k`
too, so a forcer and the thing it refutes speak about the same colourings with no cardinality
bookkeeping between them.

The cost lands at the boundary. A caller who *builds* a colouring — Fischer's additive colourings
(`Additive.lean`), the residue colouring of a plane over a number field (`ResidueColouring.lean`) —
builds it valued in a group or a residue field, not in `Fin k`, and then has to translate. Before
this module the translation was written by hand at each such site: mint
`Fintype.equivFinOfCardEq`, push the colouring through `SimpleGraph.recolorOfEquiv`, apply the
compulsion, cancel the equivalence.

This module writes it once. Nothing here is deep — a bijection of palettes is a bijection of
colourings — and that is the point: the eight lemmas below are what makes the `Fin k` in the two
definitions an implementation detail rather than a constraint on who may use them.

**Why a module of its own.** A *declaration* added to `Forcer.lean` rebuilds its sixty-seven
transitive dependents, forever after; a new leaf that `Forcer`'s consumers import costs one rebuild
and nothing thereafter (`CLAUDE.md` § Toolchain). That is also why `Forcer.lean` and `Fan.lean` each
carry a `--` comment pointing at a lemma of theirs that lives somewhere else.
-/

namespace HadwigerNelson

open SimpleGraph

variable {V α : Type*} {G : SimpleGraph V} {k : ℕ} {p q : V}

/-! ## Forced pairs -/

/-- **A forced pair agrees under a colouring by any palette of the right size.** The equivalence
carries the colouring into `Fin k`, where `Forces` speaks, and is then cancelled by injectivity. -/
theorem Forces.eq_of_equiv (h : Forces G k p q) (e : α ≃ Fin k) (C : G.Coloring α) :
    C p = C q :=
  e.injective (h (G.recolorOfEquiv e C))

/-- **`Forces.eq_of_equiv` at the hypothesis callers actually hold** — a cardinality, not a chosen
bijection. The colouring comes last so that `h.eq_of_card hk C` reads left to right. -/
theorem Forces.eq_of_card [Fintype α] (h : Forces G k p q) (hk : Fintype.card α = k)
    (C : G.Coloring α) : C p = C q :=
  h.eq_of_equiv (Fintype.equivFinOfCardEq hk) C

/-- **The converse: agreement in one `k`-sized palette *is* forcing.** Together with
`Forces.eq_of_equiv` this says `Forces G k p q` is a statement about the palette's cardinality and
about nothing else. -/
theorem Forces.of_equiv (e : α ≃ Fin k) (h : ∀ C : G.Coloring α, C p = C q) : Forces G k p q :=
  fun C => e.symm.injective (h (G.recolorOfEquiv e.symm C))

/-- **One separating colouring refutes forcing**, whatever palette it is valued in — the form a
caller who has *constructed* a colouring walks to. -/
theorem not_forces_of_coloring_ne [Fintype α] (hk : Fintype.card α = k) (C : G.Coloring α)
    (hne : C p ≠ C q) : ¬ Forces G k p q :=
  fun h => hne (h.eq_of_card hk C)

/-! ## Virtual edges -/

/-- **A virtual edge is separated under a colouring by any palette of the right size.** -/
theorem Separated.ne_of_equiv (h : Separated G k p q) (e : α ≃ Fin k) (C : G.Coloring α) :
    C p ≠ C q :=
  fun hc => h (G.recolorOfEquiv e C) (congrArg e hc)

/-- **`Separated.ne_of_equiv` at the hypothesis callers actually hold.** -/
theorem Separated.ne_of_card [Fintype α] (h : Separated G k p q) (hk : Fintype.card α = k)
    (C : G.Coloring α) : C p ≠ C q :=
  h.ne_of_equiv (Fintype.equivFinOfCardEq hk) C

/-- **The converse: separation in one `k`-sized palette *is* a virtual edge.** -/
theorem Separated.of_equiv (e : α ≃ Fin k) (h : ∀ C : G.Coloring α, C p ≠ C q) :
    Separated G k p q :=
  fun C hc => h (G.recolorOfEquiv e.symm C) (congrArg e.symm hc)

/-- **One identifying colouring refutes a virtual edge**, whatever palette it is valued in. -/
theorem not_separated_of_coloring_eq [Fintype α] (hk : Fintype.card α = k) (C : G.Coloring α)
    (heq : C p = C q) : ¬ Separated G k p q :=
  fun h => h.ne_of_card hk C heq

/-! ## Spec

A model of each side that is not vacuous, and the red that pins the cardinality hypothesis. -/

section Spec

/-- **The model for `Forces`.** The two-vertex *empty* graph really is `1`-colourable — the constant
colouring — so this is a statement about colourings that exist, and `Unit` is a palette that is not
`Fin 1` on the nose. -/
example (C : (⊥ : SimpleGraph (Fin 2)).Coloring Unit) : C 0 = C 1 := by
  have h : Forces (⊥ : SimpleGraph (Fin 2)) 1 0 1 := fun D => Subsingleton.elim _ _
  exact h.eq_of_card (by simp) C

/-- **The model for `Separated`.** Adjacent vertices are separated for free (`Separated.of_adj`),
and `Bool` is a genuine two-element palette that is not `Fin 2`. -/
example (C : (⊤ : SimpleGraph (Fin 2)).Coloring Bool) : C 0 ≠ C 1 :=
  (Separated.of_adj (k := 2) (by simp)).ne_of_card (by simp) C

/-- The two-colouring of an edge that the red below needs: `Bool` really does separate. -/
example : ∃ C : (⊤ : SimpleGraph (Fin 2)).Coloring Bool, C 0 ≠ C 1 :=
  ⟨SimpleGraph.Coloring.mk (fun v => v == 0) fun {a b} hab hc => by
     revert hc; revert hab; revert a b; decide, by decide⟩

/-- **Red: the cardinality hypothesis is load-bearing, and it fails in the direction that matters.**
`Forces (⊤ : SimpleGraph (Fin 2)) 1 0 1` is *true* — `Fin 1` has one element, so any two of its
members agree, and the graph has no `1`-colouring for the statement to bite on — while the
`Bool`-colouring above separates the same two vertices. So dropping `hk` from `Forces.eq_of_card`
would make it **false**, not merely unprovable. -/
example : Forces (⊤ : SimpleGraph (Fin 2)) 1 0 1 := fun _ => Subsingleton.elim _ _

end Spec

end HadwigerNelson
