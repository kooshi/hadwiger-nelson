import Proofs.HadwigerNelson.Arity
import Proofs.HadwigerNelson.DistanceGraph
import Mathlib.Analysis.SpecialFunctions.Complex.Circle

/-!
# The plane is homogeneous, so one forced pair is all of them

A finite gadget forces a *particular* pair of points to wear different colours — or the same
colour. The six-colour programme needs the statement about *every* pair at that distance, and the
bridge is the one symmetry the plane has and a finite graph does not: its isometry group is
transitive on ordered pairs at a fixed distance.

Concretely, `z ↦ a·z + b` with `a = (y − x)/(y₀ − x₀)` and `b = x − a·x₀` carries `(x₀, y₀)` to
`(x, y)`, and `‖a‖ = 1` exactly because the two pairs are equidistant (a translation when
`x₀ = y₀`). Distance-preserving maps are endomorphisms of *every* distance graph
(`Isometry.distanceGraphHom`), so a colouring pulls back along one — and a hypothesis "this pair
wears such-and-such colours in every colouring" applies to the pulled-back colouring.

## The shape, after M49's domain-modeling pass

One lemma, `transport_pair`, for an arbitrary relation `R` on colours and an arbitrary set `D` of
forbidden distances: whatever relation the colours of one pair satisfy in every proper colouring of
`distanceGraph ℂ D`, the colours of every pair at the same distance satisfy it too. The two
polarities the programme uses — *separated* (`R := Ne`, a virtual edge) and *forced equal*
(`R := Eq`, the spindle's premise) — are its instances, and the unit-distance graph is the case
`D = {1}` through `unitDistance_eq_distanceGraph_singleton`. `Separated.plane` and
`Forces.plane` are the finite-gadget forms: a drawing, its edges realized at distances in `D`, the
forced pair's distance, and the property, in; the statement about every pair of the plane, out.

## What this buys, and when

Nothing here is deep, and no novelty is claimed for any step. It exists because it is the piece a
find consumes on the day it is found: a `Separated G 5 u v` gadget composed with
`Instances/HexShell.lean`'s pigeonhole (or with `Instances/OneTwo`'s single-class pigeonhole), or a
`Forces G 5 u v` gadget composed with `Spindle.lean`'s spindle theorem — either yields χ(ℝ²) ≥ 6.

## The degenerate case, and why it needs no hypothesis

`exists_isometry_map_pair` carries no `x₀ ≠ y₀`: at zero distance the two pairs collapse to two
points, and a translation carries one to the other. So `transport_pair` has no side condition
either — and `AritySpec` exercises the degenerate branch of `forced_pair_of_forced`, where the
hypothesis refutes itself.
-/

namespace HadwigerNelson

open SimpleGraph

/-- **The plane's isometry group is transitive on ordered pairs at a given distance.**

The map is `z ↦ a·z + b`, an explicit rotation-and-translation, or a bare translation when the
pairs are degenerate. A bare `Isometry` rather than an `IsometryEquiv`, because every consumer only
pulls a colouring back along it and surjectivity would be an obligation nobody spends. -/
theorem exists_isometry_map_pair {x₀ y₀ x y : ℂ} (h : dist x y = dist x₀ y₀) :
    ∃ g : ℂ → ℂ, Isometry g ∧ g x₀ = x ∧ g y₀ = y := by
  by_cases hne : x₀ = y₀
  · -- Degenerate: `x = y` too, and translation does it.
    subst hne
    rw [dist_self, dist_eq_zero] at h
    subst h
    exact ⟨fun z => z + (x - x₀), Isometry.of_dist_eq fun z w => by
      rw [Complex.dist_eq, Complex.dist_eq]; ring_nf, by ring, by ring⟩
  have hsub : y₀ - x₀ ≠ 0 := sub_ne_zero.mpr (Ne.symm hne)
  set a : ℂ := (y - x) / (y₀ - x₀) with ha
  have hnorm : ‖a‖ = 1 := by
    rw [ha, norm_div]
    rw [Complex.dist_eq, Complex.dist_eq] at h
    rw [show ‖y - x‖ = ‖y₀ - x₀‖ by rw [← norm_neg (y - x), ← norm_neg (y₀ - x₀)]; simpa using h]
    exact div_self (norm_ne_zero_iff.mpr hsub)
  refine ⟨fun z => a * z + (x - a * x₀), Isometry.of_dist_eq fun z w => ?_, by ring, ?_⟩
  · rw [Complex.dist_eq, Complex.dist_eq, show a * z + (x - a * x₀) - (a * w + (x - a * x₀))
      = a * (z - w) by ring, norm_mul, hnorm, one_mul]
  · have hkey : a * (y₀ - x₀) = y - x := div_mul_cancel₀ _ hsub
    linear_combination hkey

/-- **Homogeneity, relation-generic.** Whatever relation the colours of one pair satisfy in every
proper colouring of the distance graph, the colours of every pair at the same distance satisfy it
too. `R := Ne` is a virtual edge transported; `R := Eq` is a forced-equal pair transported — the
premise of the spindle. No side condition, and an arbitrary colour type. -/
theorem transport_pair {α : Type*} {D : Set ℝ} {R : α → α → Prop} {x₀ y₀ x y : ℂ}
    (h : ∀ C : (distanceGraph ℂ D).Coloring α, R (C x₀) (C y₀)) (hd : dist x y = dist x₀ y₀)
    (C : (distanceGraph ℂ D).Coloring α) : R (C x) (C y) := by
  obtain ⟨g, hg, hgx, hgy⟩ := exists_isometry_map_pair hd
  have := h (C.comap (Isometry.distanceGraphHom hg))
  rwa [show (C.comap _ : ℂ → α) x₀ = C x from congrArg C hgx,
       show (C.comap _ : ℂ → α) y₀ = C y from congrArg C hgy] at this

/-- **One forced pair is all of them** — the unit-distance instance (`D = {1}`, `R := Ne`), kept
in its M48 form for the callers that speak of `unitDistance ℂ`. -/
theorem forced_pair_of_forced {α : Type*} {x₀ y₀ x y : ℂ}
    (h : ∀ C : (unitDistance ℂ).Coloring α, C x₀ ≠ C y₀) (hd : dist x y = dist x₀ y₀)
    (C : (unitDistance ℂ).Coloring α) : C x ≠ C y := by
  revert h C
  rw [unitDistance_eq_distanceGraph_singleton]
  exact fun h C => transport_pair (R := Ne) h hd C

/-- **A gadget's virtual edge, transported to the whole plane** — every pair at the gadget's own
distance is separated in every proper colouring of the distance graph of `D`, given a drawing whose
edges are realized at distances in `D`. `Separated.plane` is the `D = {1}` reading. -/
theorem Separated.planeIn {ι : Type*} {G : SimpleGraph ι} {k : ℕ} {D : Set ℝ} (q : ι → ℂ)
    (hq : ∀ i j, G.Adj i j → dist (q i) (q j) ∈ D) (h0 : (0 : ℝ) ∉ D) {u v : ι} {d : ℝ}
    (hd : dist (q u) (q v) = d) (hs : Separated G k u v)
    (C : (distanceGraph ℂ D).Coloring (Fin k)) {x y : ℂ} (hxy : dist x y = d) : C x ≠ C y :=
  transport_pair (R := Ne) (fun C' => hs.comap (distanceGraphHom G q hq h0) C') (hxy.trans hd.symm) C

/-- **A gadget's forced-equal pair, transported to the whole plane** — the dual of
`Separated.planeIn` and the premise `Spindle.not_colorable_of_forced_equal` consumes. -/
theorem Forces.planeIn {ι : Type*} {G : SimpleGraph ι} {k : ℕ} {D : Set ℝ} (q : ι → ℂ)
    (hq : ∀ i j, G.Adj i j → dist (q i) (q j) ∈ D) (h0 : (0 : ℝ) ∉ D) {u v : ι} {d : ℝ}
    (hd : dist (q u) (q v) = d) (hf : Forces G k u v)
    (C : (distanceGraph ℂ D).Coloring (Fin k)) {x y : ℂ} (hxy : dist x y = d) : C x = C y :=
  transport_pair (R := Eq) (fun C' => hf.comap (distanceGraphHom G q hq h0) C') (hxy.trans hd.symm) C

/-- **A gadget's virtual edge, transported to the whole plane** — the unit-distance form, exactly
the shape `Instances/HexShell.lean`'s composition consumes: a drawing, the exact-arithmetic proof
that its edges are unit-length, the distance of the forced pair, and the separation itself, in; the
statement about every pair of the plane at that distance, out. -/
theorem Separated.plane {ι : Type*} {G : SimpleGraph ι} {k : ℕ} (q : ι → ℂ)
    (hq : ∀ i j, G.Adj i j → dist (q i) (q j) = 1) {u v : ι} {d : ℝ}
    (hd : dist (q u) (q v) = d) (hs : Separated G k u v)
    (C : (unitDistance ℂ).Coloring (Fin k)) {x y : ℂ} (hxy : dist x y = d) : C x ≠ C y := by
  revert C
  rw [unitDistance_eq_distanceGraph_singleton]
  exact fun C => hs.planeIn q (fun i j hij => Set.mem_singleton_iff.mpr (hq i j hij))
    (by norm_num) hd C hxy

end HadwigerNelson
