import Proofs.HadwigerNelson.Forcer

/-! # Fans — the disjunctive forcer, and the rung M13's search could not see

`Forcer.lean` states the end of the argument: `Forces G k p q` says *every* proper `k`-colouring
paints `p` and `q` alike, and two copies of such a configuration spindle into a graph with no
`k`-colouring at all. M13 searched for exactly that and found none, anywhere.

**de Grey's construction does not contain one either, until its last step.** What his 397-point
configuration contains — measured at M14 subplanning, `plans/M14-seed-optimization.md` § 0(b) — is
weaker and is the thing that can actually be found:

> every proper 4-colouring paints the origin the same colour as **at least one** of three points at
> distance 2 from it.

That is a **fan**. This module states it, states the ladder that descends from it, and re-derives
`Forces` as its width-one rung. Two boundary readings make the ladder a genuine descent:

| width | statement | meaning |
|---|---|---|
| `Q = []` | `Fan G k p []` | there is no `k`-colouring at all — the theorem, with no spindle |
| `Q = [q]` | `Fan G k p [q]` | `Forces G k p q` — hand back to `not_colorable_of_spindled_forcer` |
| `Q` wider | `Fan G k p Q` | the rung a search can reach, and the one de Grey's graph occupies |

So `Q.length` is a measure that descends to a proof, and every intermediate value is a statement
this repository could not previously write down.

`ForcesSome` is the version without a shared pivot; the fan is its pivoted specialisation. Both are
stated because the measurements disagree about which is primary — the free version is *flat* across
everything M13 searched (§ 0(e)), the pivoted version *discriminates* (§ 0(c)) — and the domain pass
resolves which one earns the definition.
-/

namespace HadwigerNelson

variable {V W : Type*} {G : SimpleGraph V} {H : SimpleGraph W} {k : ℕ}

/-! ## The disjunctive property -/

/-- **Every proper `k`-colouring makes at least one listed pair monochromatic.**

The generalisation of `Forces` from one pair to a list, and the only shape in which de Grey's
building block has anything to say. -/
def ForcesSome (G : SimpleGraph V) (k : ℕ) (L : List (V × V)) : Prop :=
  ∀ C : G.Coloring (Fin k), ∃ e ∈ L, C e.1 = C e.2

/-- **Every proper `k`-colouring paints `p` like some member of `Q`.**

The pivoted specialisation, and the one the search computes: a pivot and one distance class of
partners. -/
def Fan (G : SimpleGraph V) (k : ℕ) (p : V) (Q : List V) : Prop :=
  ForcesSome G k (Q.map fun q => (p, q))

/-! ## The two ends of the ladder -/

/-- **An empty disjunction is a refutation.** No pair can be monochromatic when there are no pairs,
so no colouring exists — the theorem with no spindle and no closing move. -/
theorem not_colorable_of_forcesSome_nil (h : ForcesSome G k []) : ¬ G.Colorable k := by
  sorry

/-- **An empty fan is a refutation** — the same statement, pivoted. -/
theorem not_colorable_of_fan_nil {p : V} (h : Fan G k p []) : ¬ G.Colorable k := by
  sorry

/-- **A width-one fan is exactly a forced pair**, so M13's module is this one's base case rather
than a parallel development. -/
theorem fan_singleton_iff {p q : V} : Fan G k p [q] ↔ Forces G k p q := by
  sorry

/-- The same for the unpivoted version. -/
theorem forcesSome_singleton_iff {p q : V} : ForcesSome G k [(p, q)] ↔ Forces G k p q := by
  sorry

/-! ## The descent -/

/-- **Drop a disjunct no colouring can satisfy.** The descent step: `Q.length` falls by one, and the
hypothesis is a refutation of a single equality — one SAT call, or one `decide`.

This is the move that turns a fan into a forcer and a forcer into a theorem. -/
theorem Fan.narrow {p q : V} {Q : List V} (h : Fan G k p (q :: Q))
    (hno : ∀ C : G.Coloring (Fin k), C p ≠ C q) : Fan G k p Q := by
  sorry

/-- **Widening is free.** A fan over `Q` is a fan over any list containing it — the direction that
costs nothing, recorded so a caller never re-proves it. -/
theorem Fan.widen {p : V} {Q Q' : List V} (h : Fan G k p Q) (hsub : Q ⊆ Q') : Fan G k p Q' := by
  sorry

/-! ## Transport — as at M13, one statement per way a fan travels -/

/-- **More edges only force more.** -/
theorem Fan.mono {G' : SimpleGraph V} (hle : G ≤ G') {p : V} {Q : List V} (h : Fan G k p Q) :
    Fan G' k p Q := by
  sorry

/-- **A fan speaks about every graph it maps into.** -/
theorem Fan.comap {p : V} {Q : List V} (h : Fan G k p Q) (φ : G →g H) (C : H.Coloring (Fin k)) :
    ∃ q ∈ Q, C (φ p) = C (φ q) := by
  sorry

/-- **A symmetry carries a fan to a fan**, which is what licenses one pivot per symmetry orbit —
the completeness argument for a search over a configuration built as an orbit. -/
theorem Fan.map {p : V} {Q : List V} (h : Fan G k p Q) (σ : G →g G) :
    Fan G k (σ p) (Q.map σ) := by
  sorry

/-! ## The producers

A fan is refuted by pinning the pivot to colour `0` — colour names are arbitrary, so one pattern
stands for all — and then forbidding colour `0` at every partner. The pin is a `cubeCNF` unit; the
partners need *negative* units, which is the one piece of encoding this module adds. -/

open Std.Sat in
/-- The clauses forbidding each listed vertex from taking colour `c` — one negative unit each.

`cubeCNF` can only say "this vertex *has* that colour"; a fan's refutation needs the negation at
every partner, and a negative unit clause is the whole of it. -/
def avoidCNF (k : ℕ) {n : ℕ} (Q : List (Fin n)) (c : ℕ) : Std.Sat.CNF ℕ :=
  ⟨(Q.map fun q => [(colorVar k q.val c, false)]).toArray⟩

/-- **A fan straight from a refutation** — the producer that scales, and the one the search emits.

The colour count is `k + 1` because the argument names one colour and so needs one to exist. A
literal `4` or `5` unifies with it. -/
theorem Fan.of_unsat {n k : ℕ} {E : List (Fin n × Fin n)} {p : Fin n} {Q : List (Fin n)}
    (h : (coloringCNF (k + 1) n E ++ cubeCNF (k + 1) n [(p, 0)] ++
          avoidCNF (k + 1) Q 0).Unsat) :
    Fan (edgeGraph n E) (k + 1) p Q := by
  sorry

/-- **A fan from exhausting the colourings** — the small-case producer, `decide +kernel`'s route,
and the one that needs no solver at all. Ceiling `k ^ n`, so it is for calibration instances. -/
theorem Fan.of_edges {n : ℕ} {E : List (Fin n × Fin n)} {p : Fin n} {Q : List (Fin n)}
    (h : ∀ f : Fin n → Fin k, (∃ e ∈ E, e.1 ≠ e.2 ∧ f e.1 = f e.2) ∨ ∃ q ∈ Q, f p = f q) :
    Fan (edgeGraph n E) k p Q := by
  sorry

/-! ## Specification — the fans this repository can already check by hand

The rhombus is the calibration instance: `rhombus_forces` proves its far corners agree at three
colours by exhausting all `3⁴ = 81` colourings, so the width-one fan is decidable here and the
statements above can be read against something already believed. -/

/-- The rhombus is a width-one fan at three colours — the same fact as `rhombus_forces`, said in
this module's vocabulary. -/
example : Fan (edgeGraph 4 rhombus) 3 0 [3] := by
  sorry

/-- **Widening a true fan keeps it true**, and here that is checkable by hand. -/
example : Fan (edgeGraph 4 rhombus) 3 0 [3, 1] := by
  sorry

-- The negative controls. Each is a countermodel, so each would go red if the definition drifted
-- toward something vacuous — a `Fan` that held for every list would pass the positives above and
-- fail every line here.

/-- **A fan over the wrong partner is false.** Vertex `1` is adjacent to `0`, so no colouring paints
them alike, and the width-one fan at `1` cannot hold. -/
example : ¬ Fan (edgeGraph 4 rhombus) 3 0 [1] := by
  sorry

/-- **The empty fan is false here**, because the rhombus *is* 3-colourable — the control that would
catch `not_colorable_of_fan_nil` being stated backwards. -/
example : ¬ Fan (edgeGraph 4 rhombus) 3 0 [] := by
  sorry

/-- **Four colours break it.** The same width-one fan is false at four colours, matching the
countermodel already recorded for `rhombus_forces`. -/
example : ¬ Fan (edgeGraph 4 rhombus) 4 0 [3] := by
  sorry

end HadwigerNelson
