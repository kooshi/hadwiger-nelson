# FS-130 — the bicycle's windings: can two unit circles whose centres are between 1 and 2 apart be three-coloured by finitely many arcs, with no two points at distance 1 of one colour? (stub)

*Minted 2026-10-03 by FS-129's record job, part 2 (FS129-Z2; `plans/FS129-Z2-record.md` stage 4), from FS-129 inventory items 81 and 120: a
new derivation the audit's readers named and did not attempt — "a coupling of the two circles' windings across the cross curve is missing"
(`plans/FS129-MR1-audit.md` § Table of misses; `plans/FS129-MA1-audit.md` § 5.1; `plans/FS129-SR2-audit.md` § 4.2). Not ranked: Poros writes its
question section, its bearing on the answer and its rank (FS129-P1); everything below is the context a fresh mind needs. **Solver column: in-ban** —
derivation, and colourings given by formula with exact checks; a scan over arc offsets is a search, the Searcher's (`plans/STANDING-RULES.md` rule 5).
Read first: `CLAUDE.md` § The aim and § Counter-priors; `plans/FS106-TS-derivation.md` § Stage 4 (C-T-BIKE); `plans/FS110-derivation.md` FS110-N2-RING,
FS110-Y3-GP, FS110-Y-BIKE-3C; `plans/FS107-R-stability.md` §§ 3.4, 3.6; `plans/FS129-derivation.md` FS129-SR1-RINGBAND.*

## The object, in plain language

Take two points `u`, `v` of the plane at distance `d`, `1 < d < 2`, and the two unit circles `T₁(u)` and `T₁(v)` about them — **the bicycle**. Join two
points of the union when they are exactly 1 apart. Points of one circle are 1 apart when they are 60° apart on it; a point of `T₁(u)` is 1 from the two
points where the unit circle about it crosses `T₁(v)`, and those cross pairs, as the point moves, trace the **cross curve**. The question C-T-BIKE asks
(`plans/FS106-TS-derivation.md` § Stage 4, verbatim): "an explicit proper 3-colouring of `T₁(u) ∪ T₁(v)` by finitely many arcs (or a proof none exists),
for each `d = |u − v| ∈ (1, 2)`".

What is held:
- **Three colours are needed** at every `d ∈ (1, 2)` — FS106-BIKE ([hand; one mind: TS]): "The bicycle T₁(u) ∪ T₁(v), 1 < |u − v| < 2, with the single
  distance 1 needs three colours (a triangle at |x − v| = √3); whether three suffice by finitely many arcs is open."
- **Each circle alone has a winding.** A three-colouring of one circle by arcs, proper at 60°, lifts to a winding `W`: FS110-N2-RING ("At a three-colour
  vertex whose unit circle carries no arc of `Γ` the ring has a winding `W`; `|W| ≤ 1` forces a swap point", two minds) and FS110-Y3-GP ("A ring with no
  two change points exactly 60° apart winds `W ≡ 3 (mod 6)`; so `|W| ≤ 2` needs two change points at distance exactly 1", two minds); FS129-SR1-RINGBAND
  (derived, one mind) is their one lemma: with no swap point `W = 6M + 3` unless the change set is 60°-invariant (FS-129 item 97).
- **One family fails off grid corners** — FS110-Y-BIKE-3C ([hand; two minds, one blind; GAP at grid-corner passages]): "No six-arc three-cycle colouring of
  each circle colours the bicycle at any `d` in `(1, 2)` whose cross curve meets no grid vertex."
- **Existence holds at nine named `d`, by two families** (`plans/SEARCH-2026-10-04.md`, [cert]): `T₁(u)` alternating 1, 2 on 60° arcs from
  the ray towards `v`, `T₁(v)` coloured hexagon by hexagon from FS106-TS's lists (`d = 4/3, 3/2, 30/17, 19/10, 99/50`); and FS-107's
  shared-colour ansatz at its tangent offsets, both circles' boundaries at the intersection point `p`, `p` coloured 2 (`d = 30/17, 24/13,
  48/25, 80/41`). Measured: the first for every `d ∈ ((√13 − 1)/2, 2)`, the second only on its tangent curve and only for `d ∈ (√3, 2)`;
  for `d ∈ (1, (√13 − 1)/2]` no colouring with a two-coloured circle (at most four boundaries per 60°, 1° grid) — open there. The
  shared-colour solutions are grid-corner passages, the case FS110-Y-BIKE-3C's GAP names.
- **The shared-colour ansatz is tight**: FS-107's two hand windows at `d = 1.9` (branch gap 58.4°, 59.3° against 60°) are near its only
  solutions, `φ = γ + 60°` (`plans/SEARCH-2026-10-04.md` § 2.3); every other offset fails.
- **A near miss**: row 1's two-circle theorem needs two concentric circles; the bicycle's are not (`plans/FS129-MA1-audit.md` § 5.1).

**What is missing** (the audit's finding): an invariant that couples the two circles' windings across the cross curve — "an invariant for a
three-colouring of two hexagon rings coupled by cross edges" (`plans/FS129-MA1-audit.md` § 5.1). With it, a three-colouring by arcs either exists for a
named `d` (and is written by formula) or is excluded at every `d`.

## Why it was asked, and where it stands now

The bicycle is the configuration at the end of branch (i) of Voronov's Lemma 6.1 (`[Voronov2023]` Thm 1.2, the band form; FS106-BIKE's prior art);
FS-106 named C-T-BIKE as a step of route (R-S) on the limit object, and FS-107 read branch (i) as "escapable as a graph" — the index's only band step is to
exclude a simultaneous swap (`plans/FS107-R-stability.md` § 3.4; `plans/FS106-TS-derivation.md` C-T-BIKE (ii)). FS-107's R-S route is closed (row 133), so
C-T-BIKE has had no consumer since; FS129-MA1 recorded the winding route "not derived — the route it served (FS-107's R-S) is closed (row 133)". Route R's
live stub is FS-122 (`plans/STUB-forced-pair.md`), whose progress is measured by a robust Lemma 6.1 count.

## Bearing on the answer (provisional, FS129-Z2's; Poros replaces it)

**None known.** Whether the bicycle's three-colourability by arcs bears on a robust Lemma 6.1 count (FS-122) is this stub's first question for Poros. A
coupling invariant would be new structure on the unit-distance graph of two circles, whatever its bearing.

## The question (Poros, 2026-10-03)

*FS129-P1 ranks this stub 18 (`plans/POROS-2026-10-03-fs129-rerank.md` § 3).*

**Existence form.** For a given `d ∈ (1, 2)`, is there a proper three-colouring of `T₁(u) ∪ T₁(v)` by finitely many arcs (C-T-BIKE)?
**Structural form.** For every three-colouring of the bicycle by finitely many arcs, at every `d`, what relation do the two circles' windings (FS110-N2-RING,
FS129-SR1-RINGBAND: `W = 6M + 3` with no swap point) satisfy across the cross curve — an invariant every colouring carries, so that existence is decided by
which pairs of windings the cross curve permits?
**First, for its bearing**: does a robust count of `[Voronov2023]` Lemma 6.1 (FS-122) read branch (i), whose configuration the bicycle is? If it does, a NO
here closes that branch for the count; if not, this stub's interest is the coupling invariant alone, and its rank stays where it is.
**Bearing on the answer**: none known; a coupling invariant would be new structure on two rings joined by cross edges, bearing on route R only through
FS-122's count (its old consumer, FS-107's R-S, is closed, row 133).

## Registered expectations

None registered here (Poros's card and the opening register them).

## Failure clauses

A NO says which arcs it excludes (finitely many; unit arcs or not) and at which `d`; a YES is a colouring by formula with an exact check whose planted
fault fires; choosing an offset by scanning is a search request, never a step (FS106-TS: "choosing `φ` by a scan is a search (the ban)").

## Deliverables

The plan (the reframe first); a derivation file in the Ephodos grammar; any colouring by formula with an exact check.

## Provisional bearings

G71 (the height: a three-colouring of a circle has a winding), G13 (row 1's two-circle theorem, a near miss), G21 (no held inhabitant), G40, G79; rows 1,
131–134; stubs FS-122 (route R), FS-123 and FS-124 (the same winding on a ring, through FS-110's winding at a three-colour point).
