# FS-13 — The 6-critical cores of the finite planes, and their autopsy (STUB, 2026-09-06; minted at the M59 close — M59's phase A, unfinished)

> **Build triage 2026-09-08 (for Opus 5, `plans/BACKLOG-FOR-OPUS.md` MEASURE ONLY (phase 0)):** see that file for the spec, the acceptance gate and the stop rule before starting; results go into a `## §B. Built` section here.

*Read beside: `plans/M59-finite-plane-lift.md` §S3, §R3 (P3: the whole plane at 131 undecided at one hour; the 5-critical cores at 11
and 19); `tools/fplift.py cores`; `data/fplane/core-*.json`; M42/M43 (the cell family's 1-minimal cores and their autopsy); G44.*

## 1. Mission context, in plain language

The finite planes refuse five colours from p = 59 up by their spectra (M58), so 6-critical subgraphs exist at 59, 83, 131, …; M59
derived that any such core is obstructed from lifting unless it is a shadow (§S1 (b)) and built the shrink, but the whole-plane
refutation at 131 — 85,805 variables, the origin and a triangle pinned — is undecided by cadical in an hour: a Hoffman-carried
refusal is not a CDCL-sized one. What the cores are for under the programme is their AUTOPSY, not their lift: the finite plane's
6-forcing has exact algebraic tools (the torus, the sphere graph, the Kloosterman spectrum), and a 1-minimal 6-critical core is the
first object on which "what forces six" can be asked with all of them — the analogue of M42's 23-core at ω = 4, χ = 7.

## 2. What we know

| fact | where |
|---|---|
| the 5-critical core of UD(𝔽₁₁,2) by the sphere-then-vertex shrink: 63 vertices, 246 edges, six quadrances about the origin, 1-minimal | `data/fplane/core-p11-k4-spheres.json` |
| the 131 plane at k = 5 undecided at one hour; the 1581's 55-direction shadow at 131 undecided at 3 h | M59 §R-notes; M58 |
| sphere-set subgraphs at 131 have Hoffman floors ≤ 2.8 at eight spheres — the forcing is large-scale | M59 §S0 |

## 3. Derivations first

**D1 — where a k = 5 refutation of a Cayley subgraph is CDCL-sized.** The M18/M34 lesson: hand the solver the factoring. For a
vertex-transitive graph the natural cubes are the colourings of a neighbourhood (the 132 circle points at 131 — a 5-colouring of a
wheel of 22 hexagons: few up to symmetry); cube-and-conquer over them. Price before running.

**D2 — the sphere vocabulary as the growth order at 59 and 83.** At 59 (3,481 vertices, Hoffman 5.022, the tight plane) and 83
(6,889, 5.74 — K(√7)'s first usable prime): the sphere shrink from the whole plane with hour walls per ask; a sphere-minimal
≥ 6 object is torus-symmetric and its autopsy (which quadrances, which chords) is the finite plane's ring anatomy.

## 4. Phases

| phase | what | cost |
|---|---|---|
| 0 | D1 priced at 131; the sphere shrink at 59 with hour walls (one core) | a day |
| A | the vertex shrink; `local` on the core (its obstruction structure); the autopsy: ω, floor, sphere structure, class avoidance at k = 5 | days |

## 5. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | the sphere-minimal ≥ 6 object at 59 has more than half the plane's spheres | medium |
| P2 | every 6-critical core found is obstructed at level 2 (M59's P2, carried) | high |

## 6. Bearing on 6, honestly

Low-medium: the lift is derived to fail; the value is the mechanism of clique-free forcing in an object with exact algebraic
structure — a derivation target, not an object one.

## 7. Addresses

`tools/fplift.py` (`cores`, `local`), `build/m59/plane_cnf.py` (scratch), `data/fplane/core-*.json`.
