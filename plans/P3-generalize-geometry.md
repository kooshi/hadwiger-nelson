# P3 — the geometry hypotheses that should be arguments (FS-24 items G1 and G7a)

*Consolidation package P3, 2026-09-09. Branch `consolidate/p3`. Parent plan:
`plans/STUB-generalize-the-kernel.md` §2 (G1) and §3 (G7, first bullet).*

---

## 0. What this is, for a reader with no memory of the project

Two theorems in this repository are stated over the complex plane when their own proofs never
look at the complex plane. Both are geometry facts wearing a coordinate system they do not need.

* **G1 — "one forced pair is all of them."** A small finite graph can force two of its points to
  wear different colours in every proper colouring. The plane is *homogeneous*: any pair of points
  can be slid onto any other pair the same distance apart, by a rigid motion. So a statement about
  one pair becomes a statement about every pair at that distance. That transport step is the
  theorem `transport_pair`, and it is stated about the complex plane. Its four-line proof uses only
  one thing: *that a rigid motion carrying the first pair to the second exists.* It never uses that
  the ambient space is the plane, except inside a separate helper that manufactures the motion.
* **G7a — "a point with two known neighbours has nowhere to hide."** Two circles meet in at most
  two points, and this repository has that classification for arbitrary radii
  (`Glue.sphere_inter_sphere`). A corollary used by the descent machinery,
  `Glue.eq_gluePoint_of_unit_pair`, states it only for two circles of radius **one**. Nothing in
  its proof needs the radii to be one.

Neither item is new mathematics. Both are statements moved to the level their proofs already
occupy.

## 1. Why G1 is not tidying — the acceptance test

`plans/STUB-four-colour-valuation-law.md` closes with an open item: re-state a nine-point carrier
over the number field `K = ℚ(√3, √11)`, transport a hypothetical separating object *"by a norm-one
element of `K(i)`"*, glue, and contradict Theorem B (`χ(K²) = 4`). Step 2 of that sketch is
literally G1's theorem — and the version this repository holds **cannot be used, and cannot even be
stated, in that setting.** Two independent reasons, and the second is the sharp one:

1. **Over `K²` the isometry group is not transitive on equidistant pairs.** There is no analogue of
   `exists_isometry_map_pair`, so the `ℂ`-form's transport is unavailable wholesale. What a
   `K`-caller *can* prove is the hypothesis *for the particular pairs a `K`-rotation reaches* — so
   the hypothesis has to be an argument.
2. **Over `ℂ` at four colours the conclusion is vacuous.** `transport_pair` concludes something
   about *every* proper colouring of `distanceGraph ℂ D`. At `D = {1}` and four colours that type
   is **empty** — this repository's own `Instances/Interval.lean` proves
   `isEmpty_coloring_plane_four`. The valuation-law stub was retracted for exactly this reason. The
   colourings the `K`-work is about are colourings of the *`K`-plane*, which Theorem B proves are
   inhabited; and those are `(distanceGraph ↥seamPlane D).Coloring (Fin 4)`, a type the `ℂ`-shaped
   theorem never mentions. **So the generalization is what moves the statement out of the vacuous
   regime, not merely what makes it convenient.**

**Acceptance for G1 is therefore not "it compiles" but "a `K`-caller can discharge the
hypothesis."** §5 below writes that caller's exact shape, and the implementation ships the
discharge lemma it needs.

## §PA — Prior-art gate (WORKFLOW step 3a)

Run 2026-09-09, before any derivation. Searched in the disciplines' vocabulary, not this
project's. **Finding: both statements are classical folklore, both are correctly disclaimed as such
in the modules already, and the search changed nothing about the plan — but it supplied the right
NAME for G1's hypothesis, which the modules should use.**

**Discipline 1 — metric geometry.** The hypothesis "for any two pairs of points at equal distance
there is an isometry carrying one to the other" is a named classical notion: a metric space with
that property is **two-point homogeneous**. Compact connected two-point homogeneous spaces are the
rank-one Riemannian symmetric spaces (Wang 1952; Tits) — spheres, real/complex/quaternionic
projective spaces — and `ℝⁿ` is two-point homogeneous. So `exists_isometry_map_pair` is "the
Euclidean plane is two-point homogeneous", and `transport_pair` is the folklore consequence that a
distance graph over a two-point homogeneous space has one orbit of ordered pairs per distance.
**Consequence for the work:** a number-field plane `K²` is *not* two-point homogeneous, which is
precisely the obstruction §1 names — so the split into (a) a per-pair hypothesis and (b) a
`ℂ`-witness is the standard way this distinction is drawn in the literature, and the module
docstring should say "two-point homogeneous" so a reader outside this project recognises it.

**Discipline 2 — distance graphs / graph colouring over subfields.** Distance graphs on the
rational points are actively studied: Bau, Johnson and Noble, *On Single-Distance Graphs on the
Rational Points in Euclidean Spaces*, Canad. Math. Bull. **64** (2021) 13–24, ask when `G(ℚⁿ, d₁)`
and `G(ℚⁿ, d₂)` are isomorphic and answer it for all `n` (yes exactly when `n ∈ {1, 2} ∪ 4ℤ`), with
observations on clique numbers. That is the *between-distances* question; the *within-one-distance*
transitivity question this package is about is not treated there, and I found no source treating it
for a number-field plane. Recorded as a negative, per the gate's own rule.

**Discipline 3 — the Hadwiger–Nelson literature itself.** Every "spindling" construction in the
field (de Grey, Heule, Parts, Haugland) uses the transport step implicitly and none states it; it is
below the threshold anyone writes down. No novelty is claimed and the modules already say so.

**G7a's prior art is already recorded in the project's own ledger.** The two-circle classification
is `Glue.lean`'s theorem, and ledger row 17 already records the convergence with `[Vinh2006]`
Lemma 3 (the same discriminant trichotomy over a finite field). Widening a corollary from radii
`(1,1)` to `(r₁, r₂)` adds nothing to that record.

**Bibliography additions** (`BIBLIOGRAPHY.md` is package P1's this round — these go to the
coordinator via the handoff, not into the file):

* `[BauJohnsonNoble2021]` — S. Bau, P. Johnson, M. Noble, *On Single-Distance Graphs on the
  Rational Points in Euclidean Spaces*, Canad. Math. Bull. 64(1) (2021) 13–24,
  doi:10.4153/S0008439520000181. **Role:** the closest published treatment of distance graphs over
  a subfield of `ℝ`; establishes that the between-distance isomorphism question over `ℚⁿ` is
  settled and that the within-distance transitivity question is not what that literature asks.
  **Read:** §1–§2 (abstract, introduction, preliminaries) from the NSF public copy; the main
  theorem's proof not read. **What rests on it:** nothing of ours; it is a negative-result citation
  for FS-24 §PA.
* **Named only, not obtained:** H.-C. Wang, *Two-point homogeneous spaces*, Ann. of Math. 55 (1952)
  177–191 — the origin of the term this package adopts for G1's hypothesis. Cited for vocabulary
  only; nothing rests on its contents.

## 2. G1 — the shape

Everything lands in `Proofs/HadwigerNelson/Homogeneous.lean` (two direct dependents: `OneDefect`,
`Instances/AritySpec`). The transport machinery it stands on — `Isometry.distanceGraphHom` and
`distanceGraphHom` in `DistanceGraph.lean:92` — is already `[MetricSpace V]`-generic, so no
upstream module is touched.

### 2.1 The core

```lean
theorem transport_pair_of_isometry {V : Type*} [MetricSpace V] {α : Type*} {D : Set ℝ}
    {R : α → α → Prop} {x₀ y₀ x y : V}
    (hg : ∃ g : V → V, Isometry g ∧ g x₀ = x ∧ g y₀ = y)
    (h : ∀ C : (distanceGraph V D).Coloring α, R (C x₀) (C y₀))
    (C : (distanceGraph V D).Coloring α) : R (C x) (C y)
```

**Why the hypothesis is an `∃` and not the isometry itself.** A caller holding the map writes the
anonymous constructor `⟨g, hg, rfl, rfl⟩`; a caller holding an existence statement — which is what
a transitivity lemma *is*, and what `exists_isometry_map_pair` already produces — passes it
directly. The `∃` form is the cheaper call site in both directions, and it has one hypothesis
instead of three. Settled here; re-examined in the domain pass.

`transport_pair` keeps its exact statement as a one-line corollary, and so does everything below
it.

### 2.2 Three inhabitants of the hypothesis, because a `∀` over an empty domain proves nothing

The briefing's standing trap applies directly: `transport_pair_of_isometry`'s hypothesis is
structure-valued, so the file must name inhabitants. `exists_isometry_map_pair` is the existing
`ℂ` one and it is *too* good — it discharges the hypothesis unconditionally, so it cannot show
that the general form has content beyond the plane. Two more, in ascending order of relevance:

```lean
/-- Equal difference vectors: a translation does it. Any normed additive group. -/
theorem exists_isometry_map_pair_of_sub_eq {V : Type*} [SeminormedAddCommGroup V]
    {x₀ y₀ x y : V} (h : y - x = y₀ - x₀) : ∃ g : V → V, Isometry g ∧ g x₀ = x ∧ g y₀ = y

/-- An ambient isometry preserving a set restricts to the subspace it preserves. -/
theorem exists_isometry_map_pair_of_mapsTo {V : Type*} [MetricSpace V] {S : Set V} {g : V → V}
    (hg : Isometry g) (hS : Set.MapsTo g S S) {x₀ y₀ x y : S}
    (hx : g x₀ = x) (hy : g y₀ = y) : ∃ g' : S → S, Isometry g' ∧ g' x₀ = x ∧ g' y₀ = y

/-- The plane's rigid motions, restricted to any subset they preserve — the `K`-caller's discharge:
`a` a norm-one element of `K(i)`, `b` a `K`-point, `S` the `K`-plane. -/
theorem exists_isometry_map_pair_affine {S : Set ℂ} {a b : ℂ} (ha : ‖a‖ = 1)
    (hS : ∀ z ∈ S, a * z + b ∈ S) {x₀ y₀ x y : S}
    (hx : a * x₀ + b = x) (hy : a * y₀ + b = y) : ∃ g : S → S, Isometry g ∧ g x₀ = x ∧ g y₀ = y
```

Plus a **worked non-`ℂ` model** as a spec `example` — a rotation of the Gaussian integers, a
subspace of the plane whose isometry group is a proper subgroup of the plane's — so the file
exhibits the hypothesis satisfied somewhere the wholesale transitivity theorem does not apply.

### 2.3 The gadget forms

`Separated.planeIn` and `Forces.planeIn` are the shapes a finite gadget's owner calls. Their
proofs are one line each and use nothing complex-specific beyond `transport_pair`; they get
metric-space-generic siblings taking the same isometry hypothesis, with the existing `ℂ` names as
corollaries:

```lean
theorem Separated.transport {ι V : Type*} [MetricSpace V] {G : SimpleGraph ι} {k : ℕ} {D : Set ℝ}
    (q : ι → V) (hq : ∀ i j, G.Adj i j → dist (q i) (q j) ∈ D) (h0 : (0 : ℝ) ∉ D) {u v : ι}
    (hs : Separated G k u v) {x y : V}
    (hg : ∃ g : V → V, Isometry g ∧ g (q u) = x ∧ g (q v) = y)
    (C : (distanceGraph V D).Coloring (Fin k)) : C x ≠ C y

theorem Forces.transport  -- the same, concluding `C x = C y`
```

## 3. G7a — the shape

```lean
-- PartnerLattice.lean
theorem eq_gluePoint_of_dist_pair {p x y : ℂ} (hne : x ≠ y) {r₁ r₂ : ℝ}
    (hx : dist p x = r₁) (hy : dist p y = r₂) :
    p = gluePoint x y r₁ r₂ ∨ p = reflAxis x y (gluePoint x y r₁ r₂)
```

Both annulus bounds of `Glue.sphere_inter_sphere` still fall out of the witness `p`, exactly as in
the unit case: `dist x y ≤ dist x p + dist p y = r₁ + r₂` by the triangle inequality, and
`|r₁ − r₂| = |dist x p − dist y p| ≤ dist x y` by the reverse triangle inequality
(`abs_dist_sub_le`). So the generalized statement has **no more hypotheses than the unit one** —
only `x ≠ y`, which is load-bearing (at `x = y` the intersection is a whole circle).
`eq_gluePoint_of_unit_pair` becomes the `r₁ = r₂ = 1` corollary.

Calling it with `rfl, rfl` reads the radii off the point itself, which is the form the consumer
wants: **every point of the plane is a glue point of any two distinct points**, with its own two
distances as the radii. That removes the unit-edge hypothesis from `CriticalSet.lean`'s plane
corollary entirely rather than merely widening it:

```lean
-- CriticalSet.lean
theorem eq_gluePoint_or_reflAxis_of_mem_criticalSet_of_forces_dist {ι : Type*} {G : SimpleGraph ι}
    (q : ι → ℂ) {u v : ι} (hne : q u ≠ q v) (h : Forces G (k + 1) u v) :
    ∀ c ∈ CriticalSet G k,
      q c = Glue.gluePoint (q u) (q v) (dist (q u) (q c)) (dist (q v) (q c)) ∨
      q c = Glue.reflAxis (q u) (q v)
              (Glue.gluePoint (q u) (q v) (dist (q u) (q c)) (dist (q v) (q c)))
```

with the unit-edge version as the corollary (rewrite the two distances by `hq`). This covers M49's
`{1, d}` two-distance objects, and every other drawing, because it assumes nothing about the
drawing at all.

**A free sibling, taken because it is three lines.** `criticalSet_eq_empty_of_forces_of_two_lt_dist`
uses only the triangle inequality, so it generalizes twice over — off `ℂ` to any metric space, and
off unit edges to any edge-length bound `M`, with `2 * M < dist (q u) (q v)`. Old name kept as the
`M = 1` corollary.

## 4. Skeleton status

Written as a full skeleton with `sorry` at every leaf before any proof effort (WORKFLOW step 3);
see §6 for the order of burn-down.

## 5. The `K`-caller's shape — the deliverable G1 exists for

Written here so the next agent does not have to re-derive it. The `K`-plane is `↥seamPlane` where
`seamPlane : Set ℂ` is `FieldWall4.lean`'s `{z | z.re ∈ seamSpan ∧ z.im ∈ seamSpan}`; a `Set` in
Lean carries a `MetricSpace` instance on its coercion automatically, so `distanceGraph ↥seamPlane D`
typechecks with no new definition. The caller then writes:

```lean
-- given: a K-object separating one √3-pair (u₀, v₀) at four colours, and a K(i)-rotation `a`
--        with ‖a‖ = 1 and a translation `b ∈ K²` carrying (u₀, v₀) to the target pair (x, y)
have hstab : ∀ z ∈ seamPlane, a * z + b ∈ seamPlane := ...      -- K(i) closure: the only real work
exact hs.transport q hq h0
  (exists_isometry_map_pair_affine ha hstab hx hy) C
```

The one genuine obligation is `hstab` — that multiplication by `a` and translation by `b` keep a
point in `K²` — which is field arithmetic on `seamPlane`, of exactly the kind
`FieldWall4.seamPlane_sub` and `seamPlane_ratMul` already do. Everything else is supplied here.

**One bridge is deliberately not built** (see §7): `FieldWall4` states its four-colourability as
`((unitDistance ℂ).induce seamPlane).Colorable 4`, while the transport concludes about
`(distanceGraph ↥seamPlane {1}).Coloring (Fin 4)`. Those two graphs agree — the subtype's metric is
the ambient one — but the identification is a lemma nobody has written, and writing it means
touching `FieldWall4.lean`, which another package owns this round.

## 6. Order of work, and the build discipline

Leaf-first, and the two items are independent:

1. `Homogeneous.lean` — G1 core, inhabitants, gadget forms, spec model. (2 dependents.)
2. `PartnerLattice.lean` — G7a core and corollary. (1 dependent.)
3. `CriticalSet.lean` — the two generalized plane corollaries. (1 dependent.)

Iterate with `lake env lean <file>` (≈2 s); never conclude a module is green from it. The gate is
`flock /home/kooshi/source/.consolidation-build.lock ./scripts/build.sh`, then a `sorry` grep, then
`./scripts/axioms.sh` — which must still report **725+ clean and exactly 5 declared purchases**.

## 7. What this package will not do

* **No new axiom purchases, no `native_decide`, no `sorry`.** Every proof here is four lines of
  metric-space reasoning.
* **No caller is changed.** Every old theorem keeps its old name and its old statement, as the
  parent stub's acceptance clause requires; the record cites these names by address.
* **The `K`-caller itself is not written.** It needs `FieldWall4.lean` (owned by package P6 this
  round) and the `induce`/subtype bridge above; §5 hands over its shape instead.
* **`finite_two_unit_neighbors` is left at unit radii.** Its consumer is the kill engine's
  depth-one census, which is a unit-circle census; a two-distance version would be a statement
  nobody has asked for. Noted rather than built.

---

## 8. Domain-modeling pass (WORKFLOW step 5, first pass) — what it changed

Run 2026-09-09 against §2 and §3. **Four changes, three of them subtractions, and two findings
recorded rather than built.**

### 8.1 The intrinsic structure, named

The property `transport_pair` transports is *"every proper colouring puts the colours of these two
vertices in relation `R`"*, and the fact that makes it transport is not geometric at all: **a
colouring pulls back along a graph homomorphism, so that property is carried forward by any
endomorphism of the graph.** The metric enters at exactly one point — to manufacture the
endomorphism from an isometry (`Isometry.distanceGraphHom`, already generic). So the true fixed
point of this pass is a graph-level statement with no metric in it.

**It is deliberately not minted.** The repository already carries that pattern twice — `Forces.comap`
(`Forcer.lean:47`) and `Separated.comap` (`Arity.lean`) — and both live in files this package does
not own. A third copy here would *add* a name where the honest move is to *collapse* three into one;
that collapse belongs to a round whose owner holds `Forcer`, `Arity` and `Homogeneous` together. The
finding is recorded in the module as a `--` comment and in the handoff, and `transport_pair_of_isometry`
keeps its metric-flavoured statement, which is also the shape a reader of this module is looking for.

### 8.2 The `∃`-hypothesis is confirmed, and its classical name adopted

Four representations were weighed. A bundled `IsometryEquiv` was refused, as the module already
refuses it for a stated reason (surjectivity is an obligation no consumer spends). A `MulAction` of
an isometry group on pairs is machinery no consumer asked for. A named relation
`SameOrbit x₀ y₀ x y` was refused for a sharper reason: **an isometry of a general metric space need
not be surjective, so "reachable by an isometry" is a preorder and not an equivalence** — calling it
an orbit would invite a symmetry that is false. The bare `∃` stays; the docstring gains the classical
name for the *global* version of the condition (a metric space in which it always holds is
**two-point homogeneous**, §PA).

Call-site test, both directions: a caller holding the map writes `⟨g, hg, rfl, rfl⟩` (four tokens); a
caller holding an existence statement — which is what every transitivity lemma produces — passes it
directly. The `∃` form is the cheaper call site both ways and has one hypothesis instead of three.

### 8.3 Two inhabitants dropped, one extracted — the API gets smaller

§2.2 proposed three new lemmas around the hypothesis. The pass found the ℂ witness
`exists_isometry_map_pair` is proving one fact twice, inline, in both its branches: **that
`z ↦ a·z + b` with `‖a‖ = 1` is an isometry of the plane.** Extracting that fact is a subtraction:

```lean
theorem isometry_affine {a : ℂ} (ha : ‖a‖ = 1) (b : ℂ) : Isometry fun z => a * z + b
```

With it in hand:

* `exists_isometry_map_pair_affine` is **dropped** — it is now
  `exists_isometry_map_pair_of_mapsTo (isometry_affine ha b) hS hx hy`, one term, and a wrapper that
  saves a caller zero lines of thought is a name for nothing. The composite is written out in §5's
  caller sketch instead.
* `exists_isometry_map_pair_of_sub_eq` (translation in a normed additive group) is **dropped** — over
  `ℂ` it is `isometry_affine` at `a = 1`, and its only other consumers would be `EuclideanSpace ℝ
  (Fin n)` and `ℝⁿ`, which are two-point homogeneous anyway, so it buys nothing today. It is three
  lines whenever someone wants it, and the handoff says so. *A finding that came with the drop:* the
  parent stub's remark that this split "serves the finite planes, where `addCayleyTranslate` is the
  isometry" does **not** hold as stated — the finite planes are `unitQuadrance` graphs over
  `ZMod p × ZMod p`, which is not a metric space, so no theorem in this file reaches them.

What survives is two names: `isometry_affine` (the plane's rigid motions, extracted from a
duplicated proof) and `exists_isometry_map_pair_of_mapsTo` (an ambient isometry restricted to a set
it preserves — the piece that actually carries the hypothesis into a subspace).

### 8.4 The non-vacuity witness changed, and improved

§2.2 planned a normed-group lemma as the "not just `ℂ`" inhabitant. That is a weak witness: in a
normed group the wholesale transitivity theorem is available anyway, so it never exercises the case
the generalization exists for. Replaced by a spec `example` over the **Gaussian integers**
`{z : ℂ | ∃ m n : ℤ, z = m + n * I}` with the quarter-turn `z ↦ i·z` — a subspace of the plane whose
isometry group is a proper subgroup of the plane's, which is the regime `K²` lives in.

### 8.5 The `CriticalSet` generalization is re-shaped

§3 proposed reading the radii off the critical vertex, which puts `dist (q u) (q c)` in the statement
four times and makes the old corollary a rewrite underneath `gluePoint`. Better: take the critical
vertex as an argument (matching the pointwise style of `eq_gluePoint_of_dist_pair` one file down),
and name the radii as implicits with `rfl`-dischargeable hypotheses.

```lean
theorem eq_gluePoint_or_reflAxis_of_mem_criticalSet_of_forces_of_dist {ι : Type*}
    {G : SimpleGraph ι} (q : ι → ℂ) {u v c : ι} {r₁ r₂ : ℝ} (hne : q u ≠ q v)
    (h : Forces G (k + 1) u v) (hc : c ∈ CriticalSet G k)
    (h₁ : dist (q u) (q c) = r₁) (h₂ : dist (q v) (q c) = r₂) :
    q c = Glue.gluePoint (q u) (q v) r₁ r₂ ∨
      q c = Glue.reflAxis (q u) (q v) (Glue.gluePoint (q u) (q v) r₁ r₂)
```

Passing `rfl rfl` reads the radii off the point; passing the drawing's edge facts recovers the old
statement's `1 1` **directly, with no rewriting inside `gluePoint`**. The old name's proof becomes
`fun c hc => …`, one line.

### 8.6 Seams checked

* **Non-vacuity of the new hypothesis:** two inhabitants, one of them outside the two-point
  homogeneous regime (§8.4).
* **Vacuity of the *conclusion*, which is the trap that produced this package's sibling work:**
  `transport_pair_of_isometry` concludes about every colouring of `distanceGraph V D`, and at
  `V = ℂ`, `D = {1}`, four colours that type is empty. The docstring says which instances are
  non-vacuous and names `Instances/Interval.lean`'s `isEmpty_coloring_plane_four` as the reason the
  `ℂ` instance is not one of them.
* **Unsampled member for `eq_gluePoint_of_dist_pair`:** `r₁ = 0` (the point sits on a centre) forces
  `dist x y = r₂`, tangency, and both disjuncts collapse to `x` — the statement holds and still says
  something. Negative radii are unreachable because `hx : dist p x = r₁` supplies non-negativity, so
  unlike `sphere_inter_sphere` this statement needs no `nonneg_of_annulus`.
* **A stronger form recorded and not built:** `sphere_inter_sphere` itself can drop both annulus
  hypotheses in favour of one witness of membership, giving the whole set equality rather than the
  pointwise disjunction. Three lines whenever a consumer wants it; both consumers today are pointwise.
* **The bound that genuinely needs the unit hypothesis:** `encard_criticalSet_le_two_of_forces` is
  *not* generalized, and this is a finding rather than a gap — at read-off radii the two glue points
  depend on the critical vertex, so "at most two" is false without a fixed radius pair. The
  localization theorem above it needs no such hypothesis; the counting theorem does.
