import Proofs.HadwigerNelson.Arity
import Proofs.HadwigerNelson.Homogeneous
import Proofs.HadwigerNelson.Sat.Encoding

/-!
# Models for the arity floor — because a `∀` over an empty domain proves everything

`Arity.lean` states what a colour compulsion is and how low its arity can be. Every one of those
statements would elaborate, prove, and mean nothing if no graph ever satisfied the hypotheses, so
this file exhibits the instances. Three of them, chosen to pin the definition from three sides.

## The planted positive: the smallest graph whose first compulsion is at arity three

Five vertices, five edges, three colours — a 4-cycle `0–1–2–4–0` with a pendant `3` hung on `2`.
Found by exhaustion over small graphs during M45 subplanning, and minimal among those searched.

```
        0 ─── 1
        │     │
        4 ─── 2 ─── 3
```

**Every pair is free**: for any two vertices some proper 3-colouring agrees on them (when they are
non-adjacent) and some disagrees. **And yet the triple `(1, 3, 4)` can never be rainbow** — vertex
`2` is adjacent to all three, so three distinct colours on them leave it none.

That last fact is not proved here by search: `p5_compels_rainbow` is a direct application of
`compels_rainbow_of_neighbors`, so the planted positive is literally an instance of the general
theorem. **The first compulsion of a graph is a fan** — the same mechanism that, at six colours and
degree 53, bounds the arity floor of the objects the measurement campaign runs on.

## The planted negative and the vacuity self-report

A triangle at three colours has no compulsion at any arity — the floor is `⊤`, and a definition
that called *something* compelled there would be measuring itself. And `K₄` at three colours reports
floor `0` rather than "everything is compelled", which is the base-satisfiability guard that every
instrument in `tools/` carries by hand, here made a value.

## Why witnesses rather than enumeration

The pair facts are witnessed by an explicit list of **three** proper colourings, not by deciding an
existential over all `3⁵` functions. Two reasons, and the second is the one that settled it:
`Decidable` synthesis will not build the instance for `∀ u v, … → ∃ f : Fin 5 → Fin 3, …` at all;
and a `Fintype (Fin 5 → Fin 3)` is data the kernel must *construct* before it can look at any of it,
which is the measured trap of this project's data modules. Three named colourings cost nothing.
-/

namespace HadwigerNelson

namespace AritySpec

open SimpleGraph

/-- The planted positive: a 4-cycle `0–1–2–4–0` with a pendant `3` on `2`. -/
def p5 : List (Fin 5 × Fin 5) := [(0, 1), (0, 4), (1, 2), (2, 3), (2, 4)]

/-- The graph on those edges. -/
abbrev P5 : SimpleGraph (Fin 5) := edgeGraph 5 p5

/-- Three proper 3-colourings, enough to witness both patterns on every pair. Found by a greedy
cover over all 36 proper colourings; the covering number really is three. -/
def p5cols : List (Fin 5 → Fin 3) := [![0, 1, 0, 1, 1], ![0, 1, 2, 0, 1], ![0, 1, 0, 1, 2]]

/-! ## Non-vacuity -/

/-- Every listed colouring really is proper — the red control on the witness list itself. -/
theorem p5cols_proper : ∀ f ∈ p5cols, ∀ i j, P5.Adj i j → f i ≠ f j := by
  simp only [edgeGraph_adj]
  decide +kernel

/-- The hypotheses of everything below have a model. -/
theorem p5_colorable : P5.Colorable 3 :=
  colorable_iff_exists.mpr ⟨![0, 1, 0, 1, 1], by simp only [edgeGraph_adj]; decide⟩

/-! ## Arity two is flat -/

/-- Any two non-adjacent vertices can share a colour. -/
theorem p5_can_agree (u v : Fin 5) (h : ¬ P5.Adj u v) : ∃ f ∈ p5cols, f u = f v := by
  revert h
  simp only [edgeGraph_adj]
  revert u v
  decide +kernel

/-- Any two distinct vertices can take different colours. -/
theorem p5_can_differ (u v : Fin 5) (h : u ≠ v) : ∃ f ∈ p5cols, f u ≠ f v := by
  revert h
  revert u v
  decide +kernel

/-- **No pair of vertices carries a compulsion.** Routed through `compels_two_eq` /
`compels_two_ne` rather than by unfolding — the arity-2 classification doing the work it exists
for, which is also the API-only test this file is meant to pass. -/
theorem p5_no_pair_compulsion (S : Fin 2 → Fin 5) (q : Fin 2 → Fin 3) : ¬ Compels P5 3 S q := by
  intro hc
  have hS : Function.Injective S := hc.1.1
  have hne : S 0 ≠ S 1 := fun h => absurd (hS h) (by decide)
  by_cases hq : q 0 = q 1
  · obtain ⟨hadj, hsep⟩ := (compels_two_eq hS hq).mp hc
    obtain ⟨f, hmem, hfe⟩ := p5_can_agree (S 0) (S 1) hadj
    exact hsep (Coloring.mk f fun {i j} h => p5cols_proper f hmem i j h) hfe
  · have hfor := (compels_two_ne hS hq).mp hc
    obtain ⟨f, hmem, hfd⟩ := p5_can_differ (S 0) (S 1) hne
    exact hfd (hfor (Coloring.mk f fun {i j} h => p5cols_proper f hmem i j h))

/-! ## Arity three fires — as an instance of the general theorem -/

/-- **The triple `(1, 3, 4)` can never be rainbow.** Not a search: vertex `2` has these three as
distinct neighbours, so this is `compels_rainbow_of_neighbors` verbatim. -/
theorem p5_compels_rainbow : Compels P5 3 ![1, 3, 4] id :=
  compels_rainbow_of_neighbors (v := 2) ![1, 3, 4]
    (by intro i; fin_cases i <;> simp only [edgeGraph_adj] <;> decide)
    (by intro a b h; fin_cases a <;> fin_cases b <;> simp_all)

/-- **The arity floor of the planted graph is exactly three** — both directions, the lower one
routed entirely through the public API. -/
theorem p5_arityFloor : arityFloor P5 3 = 3 := by
  refine le_antisymm (by simpa using arityFloor_le_of_compels p5_compels_rainbow) ?_
  refine le_arityFloor_iff.mpr fun n hn => ?_
  by_contra hlt
  have h3 : n < 3 := by exact_mod_cast not_le.mp hlt
  obtain ⟨T, q, hc⟩ := hn
  have h2 : ¬ n < 2 := by
    intro h2
    refine hc.2 ⟨p5_colorable.some, fun i j => ?_⟩
    have : i = j := Fin.ext (by have := i.isLt; have := j.isLt; omega)
    subst this; simp
  have : n = 2 := by omega
  subst this
  exact p5_no_pair_compulsion T q hc

/-! ## The planted negative -/

/-- In a triangle, "not adjacent" means "equal". -/
theorem tri_nonadj {u v : Fin 3} (h : ¬ (edgeGraph 3 [(0, 1), (0, 2), (1, 2)]).Adj u v) : u = v := by
  revert h
  simp only [edgeGraph_adj]
  revert u v
  decide

/-- A triangle at three colours: **nothing is compelled at any arity**, so the floor is `⊤`. The
identity colouring realizes every locally proper pattern, because local properness plus injectivity
already forces the pattern to be the one the identity wears. -/
theorem tri_arityFloor : arityFloor (edgeGraph 3 [(0, 1), (0, 2), (1, 2)]) 3 = ⊤ := by
  rw [eq_top_iff]
  refine le_arityFloor_iff.mpr fun n ⟨T, q, hc⟩ => absurd ?_ hc.2
  obtain ⟨hinj, hadm⟩ := hc.1
  refine ⟨Coloring.mk id fun {i j} h => h.1, fun i j => ⟨fun h => congrArg q (hinj h), fun h => ?_⟩⟩
  exact congrArg id (tri_nonadj (hadm i j h))

/-! ## The vacuity self-report -/

/-- `K₄` refuses three colours, and the floor reports `0` — not "everything is compelled". -/
theorem k4_arityFloor_zero :
    arityFloor (edgeGraph 4 [(0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3)]) 3 = 0 := by
  rw [arityFloor_eq_zero_iff, not_colorable_edgeGraph_iff]
  decide +kernel

/-! ## The ladder theorem, exercised in both directions

`arityFloor_le_of_embedding` puts the **bigger** graph on the **left**, which is the one thing about
it a reader can get backwards. These two instances make the direction visible: first that a
compulsion really does survive being embedded in more material, and then that the inequality is not
secretly an equality. -/

/-- The 5-vertex model again, with a sixth vertex added and joined to nothing. -/
abbrev P5plus : SimpleGraph (Fin 6) := edgeGraph 6 [(0, 1), (0, 4), (1, 2), (2, 3), (2, 4)]

/-- Embedding the model into itself-plus-an-isolated-vertex. Adjacency is *reflected* as well as
preserved — the added vertex touches nothing — which is exactly the hypothesis `↪g` carries and a
bare homomorphism does not. -/
def p5Embed : P5 ↪g P5plus where
  toFun := Fin.castSucc
  inj' := Fin.castSucc_injective 5
  map_rel_iff' := by
    intro i j
    simp only [edgeGraph_adj]
    revert i j
    decide

/-- **More material, same compulsion.** The floor of the enlarged graph is still at most `3` — the
shape a closure-ladder measurement instantiates, where a witness sits inside a much larger closure
and one asks whether anything it compels is still compelled there. -/
example : arityFloor P5plus 3 ≤ 3 := p5_arityFloor ▸ arityFloor_le_of_embedding p5Embed

/-- The triangle sits inside `K₄`. -/
def triEmbed : (edgeGraph 3 [(0, 1), (0, 2), (1, 2)]) ↪g
    (edgeGraph 4 [(0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3)]) where
  toFun := Fin.castSucc
  inj' := Fin.castSucc_injective 3
  map_rel_iff' := by
    intro i j
    simp only [edgeGraph_adj]
    revert i j
    decide

/-- **The inequality is strict somewhere**, so the ladder theorem is not a disguised equality: the
triangle compels nothing at three colours (floor `⊤`) while `K₄`, which contains it, is not
3-colourable at all (floor `0`). Growing a graph really can collapse the floor. -/
example : arityFloor (edgeGraph 4 [(0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3)]) 3
    < arityFloor (edgeGraph 3 [(0, 1), (0, 2), (1, 2)]) 3 := by
  rw [k4_arityFloor_zero, tri_arityFloor]
  exact ENat.top_pos

/-! ## Homogeneity: the degenerate member

`forced_pair_of_forced` carries no `x₀ ≠ y₀` hypothesis because at zero distance the hypothesis
refutes itself. This exercises that branch rather than trusting it. -/

/-- With `x₀ = y₀` the "forced apart" hypothesis is contradictory, so it yields anything — which is
why the side condition a first draft would carry is unnecessary. -/
example {α : Type*} (x₀ x y : ℂ) (h : ∀ C : (unitDistance ℂ).Coloring α, C x₀ ≠ C x₀)
    (C : (unitDistance ℂ).Coloring α) : C x ≠ C y :=
  forced_pair_of_forced h (by rw [dist_self]; exact absurd rfl (h C)) C

end AritySpec

end HadwigerNelson
