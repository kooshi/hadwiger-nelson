
/-! ## PLANTED NEGATIVE CONTROLS — appended by `scripts/vacuity.sh --self-test`.

`CLAUDE.md` § "Make the gate fail, and watch it fail" requires every check's negative control to
be run at every milestone, and twice this repository has shipped a gate that failed OPEN. Until
2026-09-09 this gate's controls could not be run at all: `isOurs` could not see declarations made
in the file being elaborated, and `lake env lean` does not apply `autoImplicit := false`, so the
first control that did run silently became a different, generic statement and returned a
clean-looking wrong answer. Both are repaired; this block is the standing consequence. -/
namespace HadwigerNelson

/-- CONTROL 1 — the `core9_plane` shape, re-planted. The library PROVES this domain empty. -/
theorem planted_vacuous_coloring (_C : (unitDistance ℂ).Coloring (Fin 4)) : (1 : ℕ) = 1 := rfl

/-- CONTROL 2 — a tracked `Prop` the library REFUTES (`pathGraph_not_additivelyRigid_three`). -/
theorem planted_vacuous_prop (_h : AdditivelyRigid pathAddr (SimpleGraph.pathGraph 3) 3) :
    (1 : ℕ) = 1 := rfl

/-- CONTROL 3 — the SAME family at an instantiation the library says nothing about. Must come
back `UNKNOWN`, never `VACUOUS`: a check that flags this is matching the family name rather than
the instance, and is worthless. This is the load-bearing half of the pair. -/
theorem planted_unknown_prop (_h : AdditivelyRigid pathAddr (SimpleGraph.pathGraph 3) 5) :
    (1 : ℕ) = 1 := rfl

/-- CONTROL 4 — the refutation path, end to end: this theorem is the evidence. -/
theorem planted_not_forces : ¬ Forces (SimpleGraph.pathGraph 3) 3 0 1 := fun h =>
  pathColoring3.valid (SimpleGraph.pathGraph_adj.mpr (Or.inl rfl)) (h pathColoring3)

/-- CONTROL 5 — and this theorem is what the evidence must kill. `VACUOUS`. -/
theorem planted_vacuous_forces (_h : Forces (SimpleGraph.pathGraph 3) 3 0 1) : (1 : ℕ) = 1 := rfl

/-- CONTROL 6 — a declaration is a CHECKED claim, not a `# noqa`. The carrier here is witnessed,
so the annotation is false and must fail as `STALE`.
VACUITY DECLARED: a false claim, planted, and the gate must refuse it. -/
theorem planted_stale (_C : (SimpleGraph.pathGraph 3).Coloring (Fin 3)) : (1 : ℕ) = 1 := rfl

/-- CONTROL 7 — a refutation. Its binder is MEANT to be empty, so it must produce no row at all;
if it does, the check is flagging theorems for their own content. -/
theorem planted_refutation (C : (unitDistance ℂ).Coloring (Fin 4)) : False :=
  (isEmpty_coloring_plane_four).false C

end HadwigerNelson
