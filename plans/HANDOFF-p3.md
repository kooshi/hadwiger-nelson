# Handoff — package P3 (FS-24 items G1 and G7a)

*Branch `consolidate/p3`, 2026-09-09. Subplan and its three modeling passes:
`plans/P3-generalize-geometry.md`. Written for someone with no memory of this work.*

---

## 1. What landed, in plain English

Two theorems in this repository were stated over the complex plane when their own proofs never
looked at the complex plane. Both are now stated at the level their proofs occupy, and **every old
name still exists with its old statement, verified byte-identical against the base commit** — so
nothing that cites them by address had to change.

### G1 — "one forced pair is all of them", off the plane

The repository's way of turning a statement about *one* pair of points into a statement about
*every* pair the same distance apart is a theorem called `transport_pair`
(`Proofs/HadwigerNelson/Homogeneous.lean`). Its argument is three sentences long: a rigid motion
carrying the first pair onto the second is an endomorphism of the distance graph, a colouring pulls
back along it, and the hypothesis then applies to the pulled-back colouring. **Nothing in that uses
the plane** — except a separate helper that manufactures the rigid motion.

So the argument is now a theorem over any metric space (`transport_pair_of_isometry`), with *the
existence of the rigid motion as a hypothesis*, and `transport_pair` is its one-line corollary over
the plane. Three more pieces make the hypothesis dischargeable in a subspace rather than only in
the plane:

* `isometry_affine` — the map `z ↦ a·z + b` is a rigid motion of the plane whenever `‖a‖ = 1`.
  This is not new content: it was already being proved twice, inline, inside the plane's own
  transitivity theorem. Extracting it made that theorem shorter.
* `exists_isometry_map_pair_of_mapsTo` — a rigid motion of the ambient space that maps a subset
  into itself restricts to a rigid motion of that subset.
* `Separated.transport` and `Forces.transport` — the same transport at the level a finite gadget's
  owner speaks, with the four existing plane theorems (`Separated.planeIn`, `Forces.planeIn`,
  `Separated.plane`, `forced_pair_of_forced`) now derived from them.

Plus `distanceGraph_induce` and `unitDistance_induce`, three lines each, which say a distance graph
restricted to a subset is the subset's own distance graph. Those were added late, after the wall
they remove turned out to be cheap; see §3.

### Why this is not tidying

`plans/STUB-four-colour-valuation-law.md` has an open item that needs exactly this theorem over
`K = ℚ(√3, √11)`, and the version we held could not be used there for **two** reasons, the second
sharper than the first.

1. Over `K²` the isometry group is not transitive on pairs at a given distance — the classical name
   for a space where it is, is **two-point homogeneous**, and a number-field plane is not one. So
   there is no wholesale discharge and the hypothesis has to be an argument. What a `K`-caller
   *can* prove is the hypothesis for the particular pairs a `K`-rotation reaches.
2. **Over the plane at four colours the conclusion is vacuous.** `transport_pair` concludes
   something about every proper colouring of the plane's distance graph, and at four colours that
   type is *empty* — this repository's own `χ(ℝ²) ≥ 5`, read backwards
   (`Instances/Interval.lean`'s `isEmpty_coloring_plane_four`). The colourings the `K`-work is
   about are colourings of the *`K`-plane*, which Theorem B proves are inhabited, and the
   `ℂ`-shaped theorem never mentions that type. **The generalization is what moves the statement
   out of the vacuous regime.**

That second point is the same trap that retracted the valuation-law argument in the first place,
and it is now written on the theorem itself rather than in a plan file.

### G7a — the glue classification, off unit radii

Two circles about distinct centres meet in exactly two points (or one), and this repository proves
that for arbitrary radii (`Glue.sphere_inter_sphere`). A corollary the descent machinery uses,
`Glue.eq_gluePoint_of_unit_pair`, was stated only for radius one. It is now
`Glue.eq_gluePoint_of_dist_pair`, at any radii, **with no more hypotheses than before** — the two
annulus conditions the general classification needs still fall out of the witness point itself, by
the triangle inequality and its reverse. The unit case is the corollary.

Downstream, in `CriticalSet.lean`, that removes the unit-edge hypothesis from the theorem saying
*where a forcing graph's critical vertices can be drawn*: it now holds for a drawing whose edges
merely lie in a set `D` of distances (`..._of_forces_in`), which is what the descent's
two-distance `{1, d}` objects are. A two-distance forcer confines its critical set to at most eight
points where a unit one confines it to two. The sibling theorem *"beyond distance 2 there are no
critical vertices at all"* generalizes twice over — to any metric space and to any edge-length
bound `M` (`criticalSet_eq_empty_of_forces_of_two_mul_lt_dist`).

### The gate

`build: OK`; zero `sorry` in `Proofs/`; the axiom audit reports **734 clean and exactly 5 declared
purchases** (baseline before this work: 725 and 5 — the purchase count is unchanged, which is the
number the acceptance said to stop on if it moved). All eleven pre-existing statements verified
character-identical to commit `d093033` by a script, not by eye.

## 2. The deliverable G1 exists for — the `K`-caller's shape, elaborated rather than asserted

This is the part worth reading if you are the next agent on
`plans/STUB-four-colour-valuation-law.md`. **Both of the following elaborate today**; they were
checked, not sketched.

The general shape — any subset `S` of the plane closed under the rigid motion:

```lean
example {ι : Type} {G : SimpleGraph ι} {k : ℕ} {D : Set ℝ}
    (S : Set ℂ) (a b : ℂ) (ha : ‖a‖ = 1) (hS : Set.MapsTo (fun z => a * z + b) S S)
    (q : ι → S) (hq : ∀ i j, G.Adj i j → dist (q i) (q j) ∈ D) (h0 : (0 : ℝ) ∉ D)
    {u v : ι} (hs : Separated G k u v) {x y : S}
    (hx : a * (q u : ℂ) + b = (x : ℂ)) (hy : a * (q v : ℂ) + b = (y : ℂ))
    (C : (distanceGraph S D).Coloring (Fin k)) : C x ≠ C y :=
  hs.transport q hq h0
    (exists_isometry_map_pair_of_mapsTo (isometry_affine ha b) hS hx hy) C
```

And the instance that stub actually needs — the `K`-plane, unit edges, four colours, a `√3`-pair
separated by a `K`-object and transported to every `√3`-pair a `K`-rotation reaches:

```lean
example {ι : Type} {G : SimpleGraph ι} (a b : ℂ) (ha : ‖a‖ = 1)
    (hS : Set.MapsTo (fun z => a * z + b) FieldWall4.seamPlane FieldWall4.seamPlane)
    (q : ι → FieldWall4.seamPlane)
    (hq : ∀ i j, G.Adj i j → dist (q i) (q j) ∈ ({1} : Set ℝ))
    {u v : ι} (hs : Separated G 4 u v) {x y : FieldWall4.seamPlane}
    (hx : a * (q u : ℂ) + b = (x : ℂ)) (hy : a * (q v : ℂ) + b = (y : ℂ))
    (C : (distanceGraph FieldWall4.seamPlane {1}).Coloring (Fin 4)) : C x ≠ C y :=
  hs.transport q hq (by norm_num)
    (exists_isometry_map_pair_of_mapsTo (isometry_affine ha b) hS hx hy) C
```

**The one obligation left to you is `hS`**: that multiplying by a norm-one `a ∈ K(i)` and adding a
`K`-point `b` keeps a `K`-point inside `K²`. That is field arithmetic on `seamPlane` of exactly the
kind `FieldWall4.seamPlane_sub` and `FieldWall4.seamPlane_ratMul` already do — nothing about
colourings, isometries or graphs is left.

**And the colouring type above is inhabited, not merely believed to be.** `FieldWall4` states its
result as `((unitDistance ℂ).induce seamPlane).Colorable 4`; `unitDistance_induce` turns that into
`(unitDistance ↥seamPlane).Colorable 4`, and `unitDistance_eq_distanceGraph_singleton` into
`(distanceGraph ↥seamPlane {1}).Colorable 4`, which is the type the transport concludes about. Do
that rewrite once at the top of your file and the vacuity question is closed.

Steps 1 and 3 of the stub's sketch — showing `core9`'s nine points lie in `K²`, and gluing the
transported objects onto the carrier's six `√3`-pairs — are untouched by this package, and step 1
is where the stub said the day would go.

## 3. What I did NOT do, and why

* **I did not write the `K`-caller.** It needs `FieldWall4.lean`, which package P6 owns this round.
  §2 hands over its shape instead, verified.
* **I did not generalize `encard_criticalSet_le_two_of_forces`** ("a forcing graph drawn with unit
  edges has at most two critical vertices"), and **this is a finding rather than a gap.** With the
  radii free, the two glue points move with the critical vertex, so "at most two" is simply false
  without a fixed radius pair. The *localization* theorem above it needs no unit hypothesis; the
  *counting* theorem does. Both modules now say so.
* **I did not mint the theorem this generalization is really an instance of.** The fact underneath
  is not metric at all: a colouring pulls back along a graph homomorphism, so *"every proper
  colouring relates these two vertices"* is carried forward by any endomorphism of the graph, and
  the metric enters only to build the endomorphism. That graph-level statement would be a **third**
  copy of a pattern the repository already carries in `Forces.comap` (`Forcer.lean`) and
  `Separated.comap` (`Arity.lean`) — both in files this package does not own. The honest move is to
  collapse three into one, and it belongs to a round whose owner holds `Forcer`, `Arity` and
  `Homogeneous` together. A `--` comment in `Homogeneous.lean` records it.
* **I did not mint two other things the passes surfaced, both cheap, neither wanted today.**
  (i) `Glue.sphere_inter_sphere` itself can drop both annulus hypotheses in favour of one witness of
  membership, giving the whole set equality rather than the pointwise disjunction — three lines
  whenever a consumer asks; both consumers today are pointwise. (ii) A translation lemma for a
  normed additive group (`y - x = y₀ - x₀ ⟹ transportable`) — three lines, whose only consumers
  would be `ℝⁿ` and `EuclideanSpace`, which are two-point homogeneous anyway.
* **I did not generalize `Glue.finite_two_unit_neighbors`.** Its consumer is the kill engine's
  depth-one census, which is a unit-circle census; a two-distance version answers a question nobody
  has asked.
* **I did not touch `CLAUDE.md`, `BIBLIOGRAPHY.md`, `plans/FRONTIER-STUBS.md`, or any file another
  package owns.**

### Two corrections the implementation forced, both worth keeping

1. **The shape I planned for the `CriticalSet` generalization would have been true and empty.** The
   subplan proposed reading the radii off the critical vertex — and if you do that, the `Forces` and
   `CriticalSet` hypotheses become *dead*, because **every point of the plane is a glue point of any
   two distinct points, at its own two distances to them**. The statement would have passed the
   build, passed the axiom audit, and said nothing. Quantifying over a distance *set* instead puts
   the content back: the radii are edge lengths, so the critical set lands in a finite union of glue
   pairs. This is the sibling of the vacuity trap the briefing names — not an empty domain, but live
   hypotheses that the proof never touches.
2. **The metric-space emptiness theorem needs `0 ≤ M`, a hypothesis the unit case got for free.**
   Without it there is a genuine counterexample: an edgeless graph with `M < 0` satisfies the
   edge-length bound vacuously and `2M < 0 = dist (q u) (q u)`, while its critical set is
   everything. The unit instance supplies `zero_le_one` and is unaffected.

### One correction to the parent stub's own text

`plans/STUB-generalize-the-kernel.md` §2 says of G1 that *"the same split serves
`EuclideanSpace ℝ (Fin n)` and the finite planes, where `addCayleyTranslate`
(`ResidueObstruction.lean:70`) is the isometry."* **The `EuclideanSpace` half is right; the finite
planes half is not.** The finite planes are `unitQuadrance` graphs over `ZMod p × ZMod p`, which is
not a metric space, so no theorem in `Homogeneous.lean` reaches them — their transport is
`ResidueObstruction.lean`'s own `forces_iff_forces_zero_sub`, which is a different argument with the
same shape. I have not edited the stub (other packages may hold FS-24 items in it); the coordinator
should apply this.

## 4. The amendments I would have made to `CLAUDE.md`

*Quoted to be pasted. The house rule — a derivation that erases the measurement which found it is a
worse record than one carrying both — is respected: everything below adds, and nothing deletes a
recorded measurement.*

### 4.1 Ledger row 43 (M48), append to the row's `Result` cell

> **GENERALIZED 2026-09-09 (consolidation, FS-24 G1).** The plane's homogeneity was stated over
> `ℂ` and its four-line proof needs only *that an isometry carrying one pair to the other exists* —
> the classical condition, holding globally, is that the space be **two-point homogeneous**, which
> `ℝ²` is and a number-field plane is not. `transport_pair_of_isometry` is that argument over any
> metric space with the isometry's existence as a hypothesis; `transport_pair`,
> `forced_pair_of_forced`, `Separated.plane`, `Separated.planeIn` and `Forces.planeIn` are
> unchanged and are now its corollaries, with `Separated.transport` / `Forces.transport` the
> gadget-level forms and `isometry_affine` / `exists_isometry_map_pair_of_mapsTo` /
> `distanceGraph_induce` / `unitDistance_induce` the pieces that discharge the hypothesis inside a
> subspace of the plane. **Why it was blocking**: `plans/STUB-four-colour-valuation-law.md` needs
> the transport over `K²` at four colours, and over `ℂ` at four colours the conclusion is
> **vacuous** — `isEmpty_coloring_plane_four` — so the generalization moves the statement out of
> the empty regime rather than merely widening it. The `K`-caller's exact shape is elaborated in
> `plans/HANDOFF-p3.md` §2; its one remaining obligation is that a norm-one element of `K(i)`
> preserves `K²`.

### 4.2 Ledger row 45 (M50), append to the row's `Result` cell

> **GENERALIZED 2026-09-09 (consolidation, FS-24 G7a).** `Glue.eq_gluePoint_of_unit_pair` was
> stated at radii `(1, 1)`; `Glue.eq_gluePoint_of_dist_pair` is the same theorem at any radii and
> **carries no additional hypothesis**, because both annulus bounds of `sphere_inter_sphere` still
> fall out of the witness — `dist x y ≤ r₁ + r₂` by the triangle inequality through the point, and
> `|r₁ − r₂| ≤ dist x y` by its reverse. The unit form is the corollary. What it buys is
> downstream, in row 48.

### 4.3 Ledger row 48 (M54), append to the row's `Result` cell

> **GENERALIZED 2026-09-09 (consolidation, FS-24 G7a), and a boundary found.** The plane
> localization no longer needs a unit-edge drawing: with the drawing's edges merely lying in a set
> `D` of distances, a critical vertex is drawn at a glue point of *some* radius pair from `D`
> (`eq_gluePoint_or_reflAxis_of_mem_criticalSet_of_forces_in`), so the descent's `{1, d}`
> two-distance objects are covered — a two-distance forcer confines its critical set to at most
> eight points where a unit one confines it to two. `criticalSet_eq_empty_of_forces_of_two_lt_dist`
> generalizes twice over, to any metric space and any edge-length bound `M`, needing only the
> `0 ≤ M` the unit case got for free
> (`criticalSet_eq_empty_of_forces_of_two_mul_lt_dist`). **`encard_criticalSet_le_two_of_forces`
> does NOT generalize, and that is a finding rather than a gap**: with the radii free the two glue
> points move with the critical vertex, so "at most two" is false — the localization survives the
> loss of the unit hypothesis and the counting does not.

### 4.4 Grokking G30, append to the sixth failure mode's paragraph

> **The repair has a failure mode of its own, found on 2026-09-09 while running it (FS-24 G1/G7a).**
> Widening a theorem's hypotheses can widen them past the point where they do any work. The planned
> shape for the `CriticalSet` plane corollary read the two radii *off the critical vertex* — and at
> read-off radii the `Forces` and `CriticalSet` hypotheses are **dead**, because every point of the
> plane is a glue point of any two distinct points at its own two distances. That statement would
> have been true, kernel-checked, axiom-clean, and empty. **So the sixth mode's repair inherits the
> fifth mode's guard**: after generalizing, delete each hypothesis once and confirm the proof
> breaks. Here the fix was to quantify over the drawing's distance *set* rather than over nothing,
> which is where the content was. A second, smaller instance the same day: the metric-space form of
> `criticalSet_eq_empty` needs `0 ≤ M`, which the unit instance supplied silently — a generalization
> can *lose* a hypothesis the special case was getting for free.

### 4.5 § Paths forward, in the consolidation amendment of 2026-09-09

> **FS-24's items G1 and G7a are DONE** (`plans/HANDOFF-p3.md`, `plans/P3-generalize-geometry.md`):
> the homogeneity transport is off `ℂ` and the glue classification is off unit radii, both with
> every old name and statement intact, on axioms exactly the standard three. The blocked work —
> the `√3` carrier over `K` in `plans/STUB-four-colour-valuation-law.md` — is unblocked, with its
> caller shape elaborated and its one remaining obligation named. FS-24's remaining items
> (G2–G6, G7b, G7c) are untouched.

## 5. Bibliography additions (`BIBLIOGRAPHY.md` is package P1's this round)

From the prior-art gate (`plans/P3-generalize-geometry.md` §PA). **Neither bears on χ(ℝ²) ≥ 6, and
nothing of ours rests on either** — they are a vocabulary citation and a negative result.

* `[BauJohnsonNoble2021]` — S. Bau, P. Johnson, M. Noble, *On Single-Distance Graphs on the Rational
  Points in Euclidean Spaces*, Canad. Math. Bull. **64**(1) (2021) 13–24,
  doi:10.4153/S0008439520000181. **Role:** the closest published treatment of distance graphs over a
  subfield of `ℝ`. They ask when `G(ℚⁿ, d₁)` and `G(ℚⁿ, d₂)` are *isomorphic* — answered for all
  `n`, yes exactly when `n ∈ {1, 2} ∪ 4ℤ` — which is a between-distances question; the
  within-one-distance transitivity question this package is about is not treated there or, as far as
  the gate could find, anywhere. **Read:** abstract, §1 introduction and §2 preliminaries, from the
  NSF public copy; the main theorem's proof not read. **Copy:** not saved to `~/source/library/`.
* **Named only, not obtained:** H.-C. Wang, *Two-point homogeneous spaces*, Ann. of Math. **55**
  (1952) 177–191 — the origin of the term this package adopts for G1's hypothesis. Cited for
  vocabulary; nothing rests on its contents. The classification of compact connected two-point
  homogeneous spaces as the rank-one Riemannian symmetric spaces is the standard reference fact.

## 6. Anything another package owns

* `plans/STUB-generalize-the-kernel.md` — the correction in §3 above (the finite planes are not
  metric spaces, so G1's split does not reach them).
* `scripts/Axioms.lean` — **I did edit this**, adding eleven `#print axioms` lines for the new
  theorems in three clearly-marked `-- P3 (consolidation 2026-09-09)` blocks. It is not on any
  package's exclusion list and leaving new theorems unaudited would defeat the gate, but if other
  packages also appended, the merge is a trivial union of independent lines.
* `Proofs/HadwigerNelson/DistanceGraph.lean` — **not** edited. `distanceGraph_induce` would have
  been at home there; it went into `Homogeneous.lean` instead (2 dependents rather than 4 plus
  transitive), per the briefing's leaf-first rule.
