import Proofs.HadwigerNelson.Forcer

/-! # Fans — the disjunctive forcer, and the rung M13's search could not see

`Forcer.lean` states the end of the argument: `Forces G k p q` says *every* proper `k`-colouring
paints `p` and `q` alike, and two copies of such a configuration spindle into a graph with no
`k`-colouring. M13 searched 33 configurations for a forced pair and found none, anywhere.

**de Grey's construction contains no forced pair either, until its very last step.** What his
397-point configuration holds — measured at M14 subplanning, `plans/M14-seed-optimization.md`
§ 0(b) — is weaker, and is the thing a search can actually find:

> every proper 4-colouring paints the origin the same colour as **at least one** of three points at
> distance 2 from it.

That is a **fan**, and `Forces` is its width-one case. The ladder, and both ends of it:

| width | statement | meaning |
|---|---|---|
| `Q = []` | `Fan G k p []` | there is no `k`-colouring at all — the theorem, with no spindle |
| `Q = [q]` | `Fan G k p [q]` | `Forces G k p q`, which M13 already knows how to close |
| wider | `Fan G k p Q` | the rung de Grey's graph occupies, and the one a search can reach |

## Why the pivot is shared, and why the partners share a distance

Both are load-bearing, and neither is a convention:

* **A fan's refutation is a cube.** Colour names are arbitrary, so pinning the pivot to colour `0`
  loses nothing, and the remaining claim — no partner also takes colour `0` — is one unit clause per
  partner. The version without a shared pivot needs `k` binary clauses per pair instead, and that is
  a different, larger encoding for a property measured to be *flat* across everything M13 searched
  (§ 0(e)). The shared pivot is what makes `Fan.of_unsat` reuse `cubeCNF`.
* **One distance class is what makes the closing move possible at all** — see
  `not_colorable_of_spindled_fan`, whose docstring carries the geometry.

The coordinate distances are deliberately *absent* from these types. Every transport lemma below
would carry an index none of them inspects, and the constraint is already demanded where it bites:
the closing lemma needs an adjacency, and an adjacency is where the geometry has to be true.
-/

namespace HadwigerNelson

variable {V W : Type*} {G : SimpleGraph V} {H : SimpleGraph W} {k : ℕ}

/-! ## The two properties -/

/-- **Every proper `k`-colouring paints `p` like some member of `Q`** — a *fan* at `p` over `Q`.

`Forces` generalised from one partner to a list, and the only shape in which de Grey's building
block has anything to say. `Q.length` is the *width*, and the whole search is the descent of it.

`Q` is a `List` rather than a `Finset` because nothing here needs `DecidableEq V` — `Fan.map` would
need `Finset.image` and every statement would carry the instance — and because only membership is
ever observed, so a repeated partner is harmless. `Fan.widen`, applied both ways, is the statement
that only `Q`'s members matter. -/
def Fan (G : SimpleGraph V) (k : ℕ) (p : V) (Q : List V) : Prop :=
  ∀ C : G.Coloring (Fin k), ∃ q ∈ Q, C p = C q

/-- **No proper `k`-colouring paints `p` and `q` alike** — the exact dual of `Forces`, and the
hypothesis that retires a partner from a fan.

Named for the word `tools/forcer.py` already uses: its oracle answers `forced`, `separated`, or
`unknown`, and the middle answer had no name on this side of the boundary. -/
def Separated (G : SimpleGraph V) (k : ℕ) (p q : V) : Prop :=
  ∀ C : G.Coloring (Fin k), C p ≠ C q

/-- **Adjacent vertices are separated** — free, and the case the search meets constantly, since a
partner adjacent to the pivot is dead weight it can drop without a solver. -/
theorem Separated.of_adj {p q : V} (h : G.Adj p q) : Separated G k p q :=
  fun C => C.valid h

/-! ## The theorem the whole ladder exists to reach

There is no induction here, and that is the finding: separating *every* partner of a fan refutes
the graph in one step, so the width is a measure on the *search*, not on any proof. -/

/-- **A fan every one of whose partners is separated refutes the graph.**

Two quantifiers meeting: the fan says some partner agrees with `p`, separation says none does. The
whole ladder in one statement, with both ends as instances — `Q = []` makes the second hypothesis
vacuous, and `Q = [q]` is M13's forced pair needing one separation. -/
theorem not_colorable_of_fan {p : V} {Q : List V} (h : Fan G k p Q)
    (hs : ∀ q ∈ Q, Separated G k p q) : ¬ G.Colorable k := by
  sorry

/-- **An empty fan is a refutation** — the `Q = []` instance, stated because it is the base case a
narrowing search is aiming at and a reader should not have to derive it. -/
theorem not_colorable_of_fan_nil {p : V} (h : Fan G k p []) : ¬ G.Colorable k := by
  sorry

/-- **A width-one fan is exactly a forced pair**, so M13's module is this one's base case rather
than a parallel development. -/
theorem fan_singleton_iff {p q : V} : Fan G k p [q] ↔ Forces G k p q := by
  sorry

/-! ## The descent

`narrow` is bookkeeping for a search that retires partners one at a time; the mathematics above
needs no such step. It is stated because the search's log is a sequence of these, and a reader
following that log should find each line as a theorem. -/

/-- **Retire a separated partner.** The width falls by one. -/
theorem Fan.narrow {p q : V} {Q : List V} (h : Fan G k p (q :: Q)) (hs : Separated G k p q) :
    Fan G k p Q := by
  sorry

/-- **Widening is free**, and applied in both directions it says a fan depends on `Q`'s members
only — the reason `List` costs nothing here. -/
theorem Fan.widen {p : V} {Q Q' : List V} (h : Fan G k p Q) (hsub : Q ⊆ Q') : Fan G k p Q' := by
  sorry

/-! ## Transport — one statement per way a fan travels -/

/-- **More edges only force more.** -/
theorem Fan.mono {G' : SimpleGraph V} (hle : G ≤ G') {p : V} {Q : List V} (h : Fan G k p Q) :
    Fan G' k p Q := by
  sorry

/-- **A fan speaks about every graph it maps into.** Pull the ambient colouring back along the
placement; the work of the closing lemma is this one line, twice. -/
theorem Fan.comap {p : V} {Q : List V} (h : Fan G k p Q) (φ : G →g H) (C : H.Coloring (Fin k)) :
    ∃ q ∈ Q, C (φ p) = C (φ q) := by
  sorry

/-- **A symmetry carries a fan to a fan**, which licenses one pivot per symmetry orbit — the
completeness argument for a search over a configuration built as an orbit, and the only place it is
recorded. -/
theorem Fan.map {p : V} {Q : List V} (h : Fan G k p Q) (σ : G →g G) :
    Fan G k (σ p) (Q.map σ) := by
  sorry

/-! ## The closing lemma -/

/-- **The spindle closes a fan.** Two placements sharing the pivot, with *every* partner of one copy
adjacent to *every* partner of the other: the ambient graph has no `k`-colouring.

M13's `not_colorable_of_spindled_forcer` is the `Q = [q]` case, where the hypothesis is a single
edge.

**Why this does not remove the need to narrow.** `hjoin` asks for a complete bipartite unit-distance
join between the two copies of `Q`, and in the plane that is almost never available. At most two
points sit at unit distance from two given points — two unit circles meet twice — so a width-three
fan would need three points inside a two-point set, and **no width-three close exists at all**.
Width two survives in exactly one geometry, computed at M14 subplanning: the partners diametrically
opposite the pivot at distance `1/√2`, closed by a quarter turn, all four cross distances exactly
one. So the search's target is width one, or that single width-two configuration, and narrowing is
the work. -/
theorem not_colorable_of_spindled_fan {p : V} {Q : List V} (φ ψ : G →g H) (hpiv : φ p = ψ p)
    (h : Fan G k p Q) (hjoin : ∀ q ∈ Q, ∀ q' ∈ Q, H.Adj (φ q) (ψ q')) :
    ¬ H.Colorable k := by
  sorry

/-! ## The producers -/

open Std.Sat in
/-- The clauses forbidding each listed vertex from taking colour `c` — one negative unit each.

`cubeCNF` can only say "this vertex *has* that colour"; a fan's refutation needs the negation at
every partner, and a negative unit clause is the whole of it. -/
def avoidCNF (k : ℕ) {n : ℕ} (Q : List (Fin n)) (c : ℕ) : Std.Sat.CNF ℕ :=
  ⟨(Q.map fun q => [(colorVar k q.val c, false)]).toArray⟩

/-- **A fan straight from a refutation** — the producer that scales, and the one the search emits.

Colour names are arbitrary, so pinning the pivot to colour `0` refutes every colouring that
separates it from all of `Q`, not merely those that happen to paint it `0`. The colour count is
`k + 1` because the argument names one colour and so needs one to exist; a literal `4` or `5`
unifies with it. -/
theorem Fan.of_unsat {n k : ℕ} {E : List (Fin n × Fin n)} {p : Fin n} {Q : List (Fin n)}
    (h : (coloringCNF (k + 1) n E ++ cubeCNF (k + 1) n [(p, 0)] ++
          avoidCNF (k + 1) Q 0).Unsat) :
    Fan (edgeGraph n E) (k + 1) p Q := by
  sorry

/-- **A fan from exhausting the colourings** — no solver, no certificate, ceiling `k ^ n`, so it is
for calibration instances and the specification examples below. -/
theorem Fan.of_edges {n : ℕ} {E : List (Fin n × Fin n)} {p : Fin n} {Q : List (Fin n)}
    (h : ∀ f : Fin n → Fin k, (∃ e ∈ E, e.1 ≠ e.2 ∧ f e.1 = f e.2) ∨ ∃ q ∈ Q, f p = f q) :
    Fan (edgeGraph n E) k p Q := by
  sorry

/-! ## Specification

Every theorem above quantifies over fans, so a fan of width greater than one has to *exist* or the
whole module is `Forces` in costume. Here is the smallest one — found by exhaustive search over all
graphs on up to eight vertices at three and four colours, `plans/M14-seed-optimization.md` § 0(i). -/

/-- **A unit triangle with a pendant point**: `0`, `1`, `2` mutually adjacent, and `3` adjacent to
`0` alone. -/
def pendantTriangle : List (Fin 4 × Fin 4) := [(0, 1), (0, 2), (1, 2), (0, 3)]

/-- **The model of the hypotheses, and the smallest genuine fan there is.** At three colours the
triangle uses all three, so the pendant point — barred only from `0`'s colour — must take `1`'s or
`2`'s.

This is the non-vacuity witness for every theorem in this module: a fan of width **two**, checked by
exhausting all `3⁴ = 81` colourings with no solver anywhere. -/
example : Fan (edgeGraph 4 pendantTriangle) 3 3 [1, 2] := by
  sorry

-- The two colourings that show the width is really two: each retires one partner and not the other,
-- so neither singleton is a fan. Without this pair the example above would be `Forces` wearing a
-- longer list.

/-- **Neither partner alone suffices** — the control that makes the width honest. -/
example : ¬ Fan (edgeGraph 4 pendantTriangle) 3 3 [1] := by
  sorry

/-- The same for the other partner. -/
example : ¬ Fan (edgeGraph 4 pendantTriangle) 3 3 [2] := by
  sorry

/-! ### Negative controls

Each would go red if `Fan` drifted toward something vacuous, and the first is the adversarial member
this model deliberately admits. -/

/-- **A pivot is its own partner, and that says nothing.** `Fan G k p [p]` holds for every graph, so
the definition is weaker than the intent — and it is left that way on purpose, because narrowing
`q ≠ p` into the type taxes every statement above while `not_colorable_of_fan` already demands
`Separated G k p p`, which is false whenever a colouring exists. **The type is weaker than the
intent; the theorem is not.** The search excludes the pivot from `Q` for the same reason. -/
example : Fan (edgeGraph 4 pendantTriangle) 3 3 [3] := by
  sorry

/-- **The empty fan is false here**, because this graph *is* 3-colourable — the control that catches
`not_colorable_of_fan_nil` being stated backwards. -/
example : ¬ Fan (edgeGraph 4 pendantTriangle) 3 3 [] := by
  sorry

/-- **Four colours break it.** The pendant point can take a fourth colour and match neither partner,
so the fan is genuinely about the colour count and not about the shape alone. -/
example : ¬ Fan (edgeGraph 4 pendantTriangle) 4 3 [1, 2] := by
  sorry

/-- **The rhombus, in this module's vocabulary** — the same fact as `rhombus_forces`, at width one,
tying the new definition to the one theorem here that was already believed. -/
example : Fan (edgeGraph 4 rhombus) 3 0 [3] := by
  sorry

/-- **Separation is not vacuous either**: the rhombus separates two adjacent corners. -/
example : Separated (edgeGraph 4 rhombus) 3 0 1 := by
  sorry

end HadwigerNelson
