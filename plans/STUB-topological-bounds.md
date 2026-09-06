# FS-9 — Topological lower bounds on unit-distance graphs: the one technique sharp at every integer (STUB, 2026-09-06)

*Minted while mining Kooshi's web-Claude analysis (`reference/Chat-analysis/analysis.txt`, "the lower-bound side: what sees
integrality"), on his direction to mine it fully. A room the project has not entered: algebraic topology. Read beside this:
`CLAUDE.md` G9/G27 (the 791-forcer is exactly V ∩ −V — a centrally symmetric graph, which is what a free ℤ₂-action looks
like from outside), G24/G28 (integrality-carried forcing, every linear relaxation blind), G43 (linearity is the blind
spot), `BIBLIOGRAPHY.md` [Lovasz1978], [Lovasz1983], [KahleMartinezFigueroa2020] (second-hand at minting).*

## 1. Mission context, in plain language

Every lower-bound instrument this project has used is either exhaustive (SAT, exact and opaque) or linear (fractional,
spectral, additive — and blind to integrality by construction, G43). Topological lower bounds are neither: Lovász's proof of
Kneser's conjecture bounds χ(G) from below by the connectivity of the neighbourhood complex (χ(G) ≥ conn(N(G)) + 3), the
box-complex version by a ℤ₂-coindex, and Borsuk–Ulam is what makes them sharp at every integer — Kneser graphs, distance
graphs on spheres (Lovász 1983), and even random Borsuk graphs (Kahle–Martinez-Figueroa 2020) reach their true chromatic
number by this route. The technique needs a free ℤ₂-action on something; the plane's central symmetry x ↦ −x is one on any
centrally symmetric unit-distance graph avoiding the origin — and the 791-forcer IS V ∩ −V of de Grey's witness (P9,
M41), with a forced central symmetry of its 4-colourings (M30). Whether any unit-distance graph has a topological lower
bound above 3 is, as far as we know, open. The milestone: compute the bounds on our objects and find out.

## 2. What we know

| fact | where |
|---|---|
| χ(G) ≥ conn(N(G)) + 3 (Lovász 1978; N(G) the simplicial complex whose simplices are vertex sets with a common neighbour); χ(G) ≥ coind(B(G)) + 2 for the box complex; the box bound is at least the neighbourhood bound | second-hand (the analysis's list; standard, e.g. Matoušek's *Using the Borsuk–Ulam Theorem*) — to be verified against a text before use |
| the 791-forcer: centrally symmetric (V ∩ −V), 4-chromatic with six forced pairs, every 4-colouring centrally symmetric on the radius-2/√3 circle | M30, M41 P9 |
| unit-distance graphs are locally sparse: two points have ≤ 2 common unit neighbours (the glue point and its mirror), so N(G)'s maximal simplices are the neighbourhoods N(v), of size ≤ Δ (60 on the 1581), and any two of them share ≤ 2 vertices | `Glue.lean`, `PartnerLattice.lean` |
| triangle-free 4-chromatic unit-distance graphs exist (Wormald 1979, girth 5; O'Donnell 1999, arbitrary girth) — the 3 → 4 step has a route that is not rainbow-clique holonomy (G25 amended) | second-hand |

## 3. Derivations first

**D1 — what the neighbourhood complex of a unit-distance graph looks like.** Its facets are the closed neighbourhoods'
vertex sets N(v); two facets meet in ≤ 2 vertices (the two common neighbours). So N(G) is a union of simplices of
dimension deg(v) − 1 glued along edges and vertices only: its homology above dimension 1 vanishes on each facet, and the
gluing graph (facets adjacent when they share a vertex) carries all the topology — N(G) is homotopy equivalent to a
2-dimensional complex (derive: the nerve of the facet cover, whose triple intersections are empty or a vertex). Hence
conn(N(G)) ≤ 1 for every unit-distance graph with ≥ 2 facets meeting in ≤ 2 points — and the neighbourhood bound is
≤ 4 AT BEST (conn ≤ 1 ⟹ χ ≥ 4 is the most it can say). So the neighbourhood complex can certify 4 but never 5; the
question is the box complex / hom complex, whose coindex is not bounded by this local sparsity argument (Hom(K₂, G) is
the box complex; its connectivity can exceed that of N(G)). Derive the same local-sparsity ceiling for B(G) — if it exists,
the room is closed on unit-distance graphs by derivation and the milestone is an afternoon; if not, compute.

**D2 — the free ℤ₂-action.** For the 791-forcer, x ↦ −x acts freely on the vertex set and preserves edges; the quotient
graph and the ℤ₂-index of the induced action on B(G) are the objects. Derive whether the forced central symmetry of
4-colourings (M30) is the shadow of a coindex ≥ 2.

## 4. Phases

| phase | what | cost |
|---|---|---|
| 0 | D1, D2; verify the three theorems' statements against a text | a day |
| A | if D1 does not close the room: compute the homology of N(G) and of the box complex of the Moser spindle, K₄ − e, the 9-core, the 791-forcer (a reduced complex: facets glued along ≤ 2 vertices), with a homology package (the complexes are small after the nerve reduction) | a day |
| B | the coindex lower bounds vs the true χ on those objects: which, if any, reaches its χ | hours |

## 5. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | the neighbourhood complex of every unit-distance graph is homotopy 2-dimensional (D1), so its Lovász bound is ≤ 4 | medium-high |
| P2 | no object we hold has a box-complex bound above 3 | medium |

## 6. Failure clauses

P2 refuted (an object with a topological bound ≥ 4, or ≥ 5): a lower-bound genre that sees integrality exists on
unit-distance graphs — a real find; the 6-hunt gains a design target (a graph with a free ℤ₂-action and coindex 4).
P1 refuted: the derivation is wrong; compute.

## 7. Bearing on 6, honestly

Low-medium. It produces no object; if the room is open it produces a NEW KIND of lower bound (not exhaustive, not linear),
which is exactly what G24/G28/G43 say the hunt lacks. If D1's ceiling holds for the box complex too, the room closes in a day.

## 8. Addresses

`tools/` (a homology computation: `gudhi` or a hand-rolled chain complex over 𝔽₂ on the nerve), the objects
(`tools/m56_export_791.py` for the 791; `additive.py --planted moser|k4e`; `Instances/Core9.lean`'s points).
