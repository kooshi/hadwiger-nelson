import Proofs.HadwigerNelson.Arity
import Proofs.HadwigerNelson.DistanceGraph
import Mathlib.Analysis.SpecialFunctions.Complex.Circle

/-!
# Transporting a pair compulsion along an isometry

A finite gadget forces a *particular* pair of points to wear different colours — or the same
colour. The six-colour programme needs the statement about *every* pair at that distance, and the
bridge is an isometry carrying one pair onto the other: distance-preserving maps are endomorphisms
of every distance graph (`Isometry.distanceGraphHom`), so a colouring pulls back along one, and a
hypothesis "this pair wears such-and-such colours in every colouring" applies to the pulled-back
colouring.

That argument never mentions the ambient space. `transport_pair_of_isometry` is it, over any metric
space, with **the existence of the isometry as a hypothesis**; everything else in this file is
either a way to discharge that hypothesis or a consumer of the conclusion.

## Two regimes, and why the hypothesis is an argument

A metric space in which *every* pair of points can be carried onto every other pair at the same
distance is called **two-point homogeneous** in the metric-geometry literature. The Euclidean plane
is one — `exists_isometry_map_pair` is that fact, the map being `z ↦ a·z + b` with
`a = (y − x)/(y₀ − x₀)`, of modulus 1 exactly because the two pairs are equidistant, and a bare
translation when `x₀ = y₀`. Over such a space the hypothesis discharges wholesale and
`transport_pair` is the resulting `ℂ`-shaped theorem, kept in its M49 form for its callers.

**A number-field plane is not two-point homogeneous.** Over `K² = ℚ(√3, √11)²` only some pairs at a
given distance are related by a `K`-rational rigid motion, so no wholesale discharge exists — but
the hypothesis can still be proved for the pairs one *does* reach, which is exactly why it is an
argument rather than a `ℂ`-specific step buried in a proof. See "Off the plane" below.

## The shape, after M49's domain-modeling pass

One lemma for an arbitrary relation `R` on colours and an arbitrary set `D` of forbidden distances:
whatever relation the colours of one pair satisfy in every proper colouring of `distanceGraph V D`,
the colours of every pair reachable from it by an isometry satisfy it too. The two polarities the
programme uses — *separated* (`R := Ne`, a virtual edge) and *forced equal* (`R := Eq`, the
spindle's premise) — are its instances, and the unit-distance graph is the case `D = {1}` through
`unitDistance_eq_distanceGraph_singleton`. `Separated.transport` and `Forces.transport` are the
finite-gadget forms — a drawing, its edges realized at distances in `D`, an isometry, and the
property, in; the statement about the image pair, out — with `Separated.planeIn`, `Forces.planeIn`
and `Separated.plane` their `ℂ` readings.

## Off the plane

Three pieces carry a compulsion into a subspace of the plane that is closed under some rigid
motions but not all of them — a number-field plane, a lattice, an orbit:

* `isometry_affine` — `z ↦ a·z + b` is an isometry of `ℂ` whenever `‖a‖ = 1`;
* `exists_isometry_map_pair_of_mapsTo` — an ambient isometry that maps a set into itself restricts
  to an isometry of that set;
* `Separated.transport` / `Forces.transport` — the gadget-level consumers.

Composed: `exists_isometry_map_pair_of_mapsTo (isometry_affine ha b) hS hx hy` discharges the
hypothesis, and the **one obligation a caller owes is `hS`** — that `z ↦ a·z + b` keeps points of
the subspace inside it, which for `K²` is the closure of `K` under the arithmetic of a norm-one
element of `K(i)`.

`FieldWall4.lean` states the four-colourability of the `K`-plane as
`((unitDistance ℂ).induce seamPlane).Colorable 4`, while the transport concludes about
`(distanceGraph ↥seamPlane {1}).Coloring (Fin 4)`. Those two graphs agree — a subtype carries the
ambient metric — and `unitDistance_induce` / `distanceGraph_induce` are the identification, so the
caller's colouring type really is inhabited rather than merely believed to be.

## Non-vacuity is the caller's business

The conclusion quantifies over proper colourings of `distanceGraph V D`, and **that type can be
empty, in which case the theorem is true and says nothing.** Over `ℂ` at `D = {1}` and four colours
it *is* empty — `Instances/Interval.lean`'s `isEmpty_coloring_plane_four`, which is this
repository's own `χ(ℝ²) ≥ 5` read backwards — so no `ℂ` instance at four colours carries
information. Over `K²` at four colours it is inhabited (`four_colorable_of_seam_field`), which is
what makes the same statement content-bearing one field down, and is the reason this
generalization was worth doing.

The isometry hypothesis is itself structure-valued, so this file exhibits inhabitants: the plane's
own transitivity, and a spec model over the Gaussian integers, whose isometry group is a proper
subgroup of the plane's.

## The degenerate case, and why it needs no hypothesis

`exists_isometry_map_pair` carries no `x₀ ≠ y₀`: at zero distance the two pairs collapse to two
points, and a translation carries one to the other. So `transport_pair` has no side condition
either — and `AritySpec` exercises the degenerate branch of `forced_pair_of_forced`, where the
hypothesis refutes itself.

## What this buys, and when

Nothing here is deep, and no novelty is claimed for any step: `transport_pair` is the folklore
consequence of two-point homogeneity, and the split into a hypothesis plus a witness is how the
distinction between a homogeneous space and a subspace of one is drawn everywhere. It exists
because it is the piece a find consumes on the day it is found: a `Separated G 5 u v` gadget
composed with `Instances/HexShell.lean`'s pigeonhole (or with `Instances/OneTwo`'s single-class
pigeonhole), or a `Forces G 5 u v` gadget composed with `Spindle.lean`'s spindle theorem — either
yields χ(ℝ²) ≥ 6.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ## Isometries of the plane, and of its subspaces -/

/-- **The plane's orientation-preserving rigid motions.** `z ↦ a·z + b` is an isometry of `ℂ`
exactly when `a` has modulus one — every rotation-and-translation of the plane, and the only maps
`exists_isometry_map_pair` ever builds. Kept separate because a subspace of the plane closed under
one of these inherits it (`exists_isometry_map_pair_of_mapsTo`), which is the route off `ℂ`. -/
theorem isometry_affine {a : ℂ} (ha : ‖a‖ = 1) (b : ℂ) : Isometry fun z => a * z + b :=
  Isometry.of_dist_eq fun z w => by
    rw [Complex.dist_eq, Complex.dist_eq,
      show a * z + b - (a * w + b) = a * (z - w) by ring, norm_mul, ha, one_mul]

/-- Red control: `‖a‖ = 1` is load-bearing — a dilation is not an isometry. -/
example : ¬ Isometry (fun z : ℂ => 2 * z) := by
  intro h
  have := h.dist_eq 0 1
  rw [Complex.dist_eq, Complex.dist_eq] at this
  norm_num at this

/-- **An isometry restricted to a set it preserves.** The hypothesis-discharging step for any
subspace of a metric space: an ambient isometry mapping `S` into itself is an isometry of `S`, so a
pair of `S` reachable in the ambient space is reachable inside `S`. With `isometry_affine` this is
the `K`-caller's route — `a` a norm-one element of `K(i)`, `b` a `K`-point, `S` the `K`-plane, and
`hS` the field-closure fact. -/
theorem exists_isometry_map_pair_of_mapsTo {V : Type*} [MetricSpace V] {S : Set V} {g : V → V}
    (hg : Isometry g) (hS : Set.MapsTo g S S) {x₀ y₀ x y : S}
    (hx : g x₀ = x) (hy : g y₀ = y) :
    ∃ g' : S → S, Isometry g' ∧ g' x₀ = x ∧ g' y₀ = y :=
  ⟨fun z => ⟨g z, hS z.2⟩,
    Isometry.of_dist_eq fun z w => by
      simpa only [Subtype.dist_eq] using hg.dist_eq (z : V) (w : V),
    Subtype.ext hx, Subtype.ext hy⟩

/-- **The plane's isometry group is transitive on ordered pairs at a given distance** — the plane
is two-point homogeneous, and this is the wholesale discharge of `transport_pair_of_isometry`'s
hypothesis that no subspace enjoys.

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
    exact ⟨fun z => 1 * z + (x - x₀), isometry_affine norm_one _, by ring, by ring⟩
  have hsub : y₀ - x₀ ≠ 0 := sub_ne_zero.mpr (Ne.symm hne)
  set a : ℂ := (y - x) / (y₀ - x₀) with ha
  have hnorm : ‖a‖ = 1 := by
    rw [ha, norm_div]
    rw [Complex.dist_eq, Complex.dist_eq] at h
    rw [show ‖y - x‖ = ‖y₀ - x₀‖ by rw [← norm_neg (y - x), ← norm_neg (y₀ - x₀)]; simpa using h]
    exact div_self (norm_ne_zero_iff.mpr hsub)
  refine ⟨fun z => a * z + (x - a * x₀), isometry_affine hnorm _, by ring, ?_⟩
  have hkey : a * (y₀ - x₀) = y - x := div_mul_cancel₀ _ hsub
  linear_combination hkey

/-- **A distance graph restricted to a subspace is the subspace's own distance graph.** A subtype
carries the ambient metric, so `induce` and `distanceGraph` commute — the bridge between how a
result about a subspace is usually *stated* (as an induced subgraph of the plane) and the form the
transport concludes about (a distance graph on the subtype). -/
theorem distanceGraph_induce {V : Type*} [MetricSpace V] {D : Set ℝ} (S : Set V) :
    (distanceGraph V D).induce S = distanceGraph (↥S) D := by
  ext x y
  simp [distanceGraph_adj, Subtype.dist_eq, Subtype.ext_iff]

/-- The unit-distance reading of `distanceGraph_induce`, in the shape `FieldWall4.lean` states its
four-colourability of the `K`-plane: `((unitDistance ℂ).induce seamPlane).Colorable 4` and
`(unitDistance ↥seamPlane).Colorable 4` are the same statement. -/
theorem unitDistance_induce {V : Type*} [MetricSpace V] (S : Set V) :
    (unitDistance V).induce S = unitDistance (↥S) := by
  rw [unitDistance_eq_distanceGraph_singleton, distanceGraph_induce,
    ← unitDistance_eq_distanceGraph_singleton]

/-! ## The transport -/

-- The intrinsic fact underneath is not metric at all: a colouring pulls back along a graph
-- homomorphism, so "every proper colouring relates these two vertices" is carried forward by any
-- endomorphism of the graph, and the metric enters only to manufacture the endomorphism. That
-- graph-level statement is deliberately not minted here: the repository already carries the same
-- pattern in `Forces.comap` (`Forcer.lean`) and `Separated.comap` (`Arity.lean`), so a third copy
-- would add a name where the honest move is to collapse three into one.

/-- **Homogeneity, relation-generic and space-generic.** Whatever relation the colours of one pair
satisfy in every proper colouring of the distance graph, the colours of any pair reachable from it
by an isometry satisfy it too. `R := Ne` is a virtual edge transported; `R := Eq` is a forced-equal
pair transported — the premise of the spindle. No side condition, an arbitrary colour type, and an
arbitrary metric space.

The hypothesis `hg` is an existence statement rather than the map itself because that is the shape
every transitivity lemma produces; a caller holding the map writes `⟨g, hg, rfl, rfl⟩`.

**Non-vacuity is the caller's business**: the conclusion quantifies over proper colourings of
`distanceGraph V D`, and at `V = ℂ`, `D = {1}` and four colours that type is empty
(`isEmpty_coloring_plane_four`). Over `K² = ℚ(√3, √11)²` at four colours it is not
(`four_colorable_of_seam_field`). -/
theorem transport_pair_of_isometry {V : Type*} [MetricSpace V] {α : Type*} {D : Set ℝ}
    {R : α → α → Prop} {x₀ y₀ x y : V}
    (h : ∀ C : (distanceGraph V D).Coloring α, R (C x₀) (C y₀))
    (hg : ∃ g : V → V, Isometry g ∧ g x₀ = x ∧ g y₀ = y)
    (C : (distanceGraph V D).Coloring α) : R (C x) (C y) := by
  obtain ⟨g, hgi, hgx, hgy⟩ := hg
  have := h (C.comap (Isometry.distanceGraphHom hgi))
  rwa [show (C.comap _ : V → α) x₀ = C x from congrArg C hgx,
       show (C.comap _ : V → α) y₀ = C y from congrArg C hgy] at this

/-- **Homogeneity over the plane**, the M49 form its callers speak. Over a space whose isometry
group is *not* transitive on equidistant pairs — a number-field plane, say, where this statement
does not even typecheck — use `transport_pair_of_isometry` and supply the map. -/
theorem transport_pair {α : Type*} {D : Set ℝ} {R : α → α → Prop} {x₀ y₀ x y : ℂ}
    (h : ∀ C : (distanceGraph ℂ D).Coloring α, R (C x₀) (C y₀)) (hd : dist x y = dist x₀ y₀)
    (C : (distanceGraph ℂ D).Coloring α) : R (C x) (C y) :=
  transport_pair_of_isometry h (exists_isometry_map_pair hd) C

/-- **One forced pair is all of them** — the unit-distance instance (`D = {1}`, `R := Ne`), kept
in its M48 form for the callers that speak of `unitDistance ℂ`. -/
theorem forced_pair_of_forced {α : Type*} {x₀ y₀ x y : ℂ}
    (h : ∀ C : (unitDistance ℂ).Coloring α, C x₀ ≠ C y₀) (hd : dist x y = dist x₀ y₀)
    (C : (unitDistance ℂ).Coloring α) : C x ≠ C y := by
  revert h C
  rw [unitDistance_eq_distanceGraph_singleton]
  exact fun h C => transport_pair (R := Ne) h hd C

/-! ## The gadget forms -/

/-- **A gadget's virtual edge, transported along an isometry** — the space-generic form: a drawing
whose edges are realized at distances in `D`, an isometry carrying the separated pair's drawn
image onto `(x, y)`, and the separation itself, in; `C x ≠ C y`, out. `Separated.planeIn` is the
reading over `ℂ`, where the isometry comes for free. -/
theorem Separated.transport {ι V : Type*} [MetricSpace V] {G : SimpleGraph ι} {k : ℕ} {D : Set ℝ}
    (q : ι → V) (hq : ∀ i j, G.Adj i j → dist (q i) (q j) ∈ D) (h0 : (0 : ℝ) ∉ D) {u v : ι}
    {x y : V} (hg : ∃ g : V → V, Isometry g ∧ g (q u) = x ∧ g (q v) = y)
    (hs : Separated G k u v) (C : (distanceGraph V D).Coloring (Fin k)) : C x ≠ C y :=
  transport_pair_of_isometry (R := Ne)
    (fun C' => hs.comap (distanceGraphHom G q hq h0) C') hg C

/-- **A gadget's forced-equal pair, transported along an isometry** — the dual of
`Separated.transport`, and the premise `Spindle.not_colorable_of_forced_equal` consumes. -/
theorem Forces.transport {ι V : Type*} [MetricSpace V] {G : SimpleGraph ι} {k : ℕ} {D : Set ℝ}
    (q : ι → V) (hq : ∀ i j, G.Adj i j → dist (q i) (q j) ∈ D) (h0 : (0 : ℝ) ∉ D) {u v : ι}
    {x y : V} (hg : ∃ g : V → V, Isometry g ∧ g (q u) = x ∧ g (q v) = y)
    (hf : Forces G k u v) (C : (distanceGraph V D).Coloring (Fin k)) : C x = C y :=
  transport_pair_of_isometry (R := Eq)
    (fun C' => hf.comap (distanceGraphHom G q hq h0) C') hg C

/-- **A gadget's virtual edge, transported to the whole plane** — every pair at the gadget's own
distance is separated in every proper colouring of the distance graph of `D`, given a drawing whose
edges are realized at distances in `D`. `Separated.plane` is the `D = {1}` reading. -/
theorem Separated.planeIn {ι : Type*} {G : SimpleGraph ι} {k : ℕ} {D : Set ℝ} (q : ι → ℂ)
    (hq : ∀ i j, G.Adj i j → dist (q i) (q j) ∈ D) (h0 : (0 : ℝ) ∉ D) {u v : ι} {d : ℝ}
    (hd : dist (q u) (q v) = d) (hs : Separated G k u v)
    (C : (distanceGraph ℂ D).Coloring (Fin k)) {x y : ℂ} (hxy : dist x y = d) : C x ≠ C y :=
  hs.transport q hq h0 (exists_isometry_map_pair (hxy.trans hd.symm)) C

/-- **A gadget's forced-equal pair, transported to the whole plane** — the dual of
`Separated.planeIn` and the premise `Spindle.not_colorable_of_forced_equal` consumes. -/
theorem Forces.planeIn {ι : Type*} {G : SimpleGraph ι} {k : ℕ} {D : Set ℝ} (q : ι → ℂ)
    (hq : ∀ i j, G.Adj i j → dist (q i) (q j) ∈ D) (h0 : (0 : ℝ) ∉ D) {u v : ι} {d : ℝ}
    (hd : dist (q u) (q v) = d) (hf : Forces G k u v)
    (C : (distanceGraph ℂ D).Coloring (Fin k)) {x y : ℂ} (hxy : dist x y = d) : C x = C y :=
  hf.transport q hq h0 (exists_isometry_map_pair (hxy.trans hd.symm)) C

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

/-! ## A model of the isometry hypothesis away from the plane

The plane's own transitivity discharges `transport_pair_of_isometry`'s hypothesis unconditionally,
so it never exercises the regime the hypothesis exists for. This one does: the Gaussian integers,
carrying `(0, 1)` to `(0, i)` by the quarter-turn.

That subspace is **not** two-point homogeneous — its isometries are the eight symmetries of the
square lattice composed with translations, and the norm-25 vectors `(5, 0)` and `(3, 4)` lie in
different orbits — so the hypothesis there is a real obligation rather than a free one. *That
sentence is a remark and not a theorem*; what is proved below is only that the hypothesis holds for
the exhibited pair, which is what non-vacuity needs. -/

/-- The Gaussian integers, as a subspace of the plane. -/
def gaussianInt : Set ℂ := {z : ℂ | ∃ m n : ℤ, z = m + n * Complex.I}

theorem quarterTurn_mapsTo : Set.MapsTo (fun z : ℂ => Complex.I * z + 0) gaussianInt gaussianInt := by
  rintro z ⟨m, n, rfl⟩
  refine ⟨-n, m, ?_⟩
  push_cast
  linear_combination (n : ℂ) * Complex.I_sq

/-- **The model.** The hypothesis of `transport_pair_of_isometry` holds for the pair `(0, 1)` and
its quarter-turn image `(0, i)` inside the Gaussian integers — a metric space that is neither `ℂ`
nor two-point homogeneous. -/
example :
    ∃ g : gaussianInt → gaussianInt, Isometry g ∧
      g ⟨0, 0, 0, by norm_num⟩ = ⟨0, 0, 0, by norm_num⟩ ∧
      g ⟨1, 1, 0, by norm_num⟩ = ⟨Complex.I, 0, 1, by norm_num⟩ :=
  exists_isometry_map_pair_of_mapsTo (isometry_affine Complex.norm_I 0) quarterTurn_mapsTo
    (by norm_num) (by norm_num)

end HadwigerNelson
