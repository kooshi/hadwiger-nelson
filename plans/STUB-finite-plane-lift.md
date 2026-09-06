# FS-11 — Lift a 6-critical subgraph of a finite plane to the field (STUB, 2026-09-06; minted at the M58 close)

*The constructive face of the finite-plane bound. Read beside this: `plans/M58-field-sieve.md` (the reduction theorem, the
spectral table, the field map), `CLAUDE.md` G43/G44, `Proofs/HadwigerNelson/UnitQuadrance.lean` (`UDCert.drawing_adj` —
the reduction as a graph hom), `data/fplane/spectral-below-600.json` (χ(UD(𝔽₁₃₁,2)) ≥ 8), `reference/Chat-analysis/analysis.txt`
("design in the finite plane, lift to the field" — the web session's speculative paragraph, here made precise).*

## 1. Mission context, in plain language

The reduction sends a unit-distance graph G in F² to a subgraph of the finite plane UD(𝔽_p, 2), and homs run the wrong way
for lower bounds: χ(G) ≤ χ(image). But a **lift** runs the right way. Let H be a subgraph of UD(𝔽_p, 2) — say a 6-critical
one, which exists at every p ≥ 59 because the plane there is ≥ 6-chromatic (≥ 8 at 131). A lift of H is a choice, for each
vertex v of H, of a point x_v ∈ F² in the residue class of v (with respect to the degree-one prime 𝔭 above p) such that every
edge uv of H is a unit edge: |x_u − x_v| = 1. Then the x_v are distinct (their residues are), H is isomorphic to a subgraph of
the unit-distance graph on {x_v}, and **χ(F²) ≥ χ(H) ≥ 6**. A lifted 6-critical subgraph of UD(𝔽₁₃₁, 2) into de Grey's field
would be a 6-chromatic unit-distance graph — the object of the whole hunt — found by solving a diophantine system whose
combinatorial part (which edges) is decided in the finite plane first, with no geometry.

The honest difficulty is in the count: a 6-critical graph has |E| ≥ (5/2)|V| edges and the lift has 2|V| unknowns in F
(each x_v is free within its residue class — the class is a coset of 𝔭 × 𝔭, an infinite set), so the unit-edge system is
overdetermined by a factor 5/4 and generically has no solution; a solution needs the finite plane's structure to be the
shadow of real structure (the residues of a genuine unit-distance configuration). The place to look is therefore not an
arbitrary 6-critical subgraph but one INSIDE the shadow of a known object (D7: the 1581's directions cover 55 of the 66
residue pairs at 131; its gen-1 closure all 66): the shadow's vertices that are residues of actual closure points already
lift, and the question becomes whether the closure's points contain a 6-critical subgraph of the plane — which is exactly
"is the closure 6-chromatic", decidable by the M31 machinery, and known NO for the gen-1 closure (k = 5 SAT in 1.14 s). So the
lift problem is the question of which NEW points, in which residue classes, a closure would need — a design vocabulary.

## 2. What we know

| fact | where |
|---|---|
| χ(UD(𝔽_p,2)) ≥ 6 for p ≥ 59; ≥ 8 at 131; the plane at 131 has 17,161 vertices, degree 132 | `data/fplane/spectral-below-600.json` |
| the reduction is a graph hom for every valid certificate (kernel) — a lift's edges reduce to the plane's edges by construction | `UnitQuadrance.lean` |
| the 1581's shadow at 131 covers 55 of 66 direction classes; the gen-1 closure's all 66, but the closure is 5-colourable | M58 §R3; M31 |
| a unit-distance graph's lift into a fixed residue class per vertex: each vertex free in 𝔭² (a 2-dimensional 𝔭-adic ball); each edge one quadratic equation | derivation §1 |

## 3. Derivations first

**D1 — the smallest 6-critical subgraphs of UD(𝔽₅₉,2) and UD(𝔽₁₃₁,2).** The plane at 59 is ≥ 6 by Hoffman with margin
0.022 — its 6-critical subgraphs may be large (Hoffman is tight only for very regular objects). Compute: the 1-minimal
5-refusing subgraphs by the M42/M43 shrink machinery on the plane (vertex-transitive, so start from balls in the Cayley
metric). Size, symmetry, and whether they are contained in a shadow of any object we hold.

**D2 — the lift as a system.** For H with vertices in 𝔽_p², unknowns x_v ∈ F² with x_v ≡ v (mod 𝔭): write x_v = v̂ + p·y_v
with v̂ a fixed lift and y_v ∈ O_𝔭²; the unit condition |x_u − x_v|² = 1 becomes a quadratic in y. Count solutions in the
𝔭-adic completion first (Hensel: a solution mod 𝔭² that is nonsingular lifts) — the LOCAL obstruction is decidable and
cheap, and a system with no 𝔭-adic solution has no global one. Register: most 6-critical H fail already locally.

**D3 — which H are shadows of real unit-distance graphs.** Necessary: H's edge directions (residues) must be liftable to
unit vectors of F² — every direction of UD(𝔽_p,2) is (the circle residues are exactly the residues of unit vectors, by
the theorem's own argument at p where the field has enough unit vectors — check which of the 66 classes at 131 are hit by
directions of the closure: all 66). Sufficient conditions are the content.

## 4. Phases

| phase | what | cost |
|---|---|---|
| 0 | D1 at 59 and 131 (the plane's 6-critical cores); D2's local test implemented | days |
| A | the local (𝔭-adic) lift test on every core found; a global lift attempt on any core that passes locally (a polynomial system over the field — sympy/Gröbner at small |V|, or the M49 descent's machinery: fix the edges, search points) | days to weeks |

## 5. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | the smallest 6-critical subgraph of UD(𝔽₁₃₁,2) has > 100 vertices | medium |
| P2 | no 6-critical subgraph of UD(𝔽₁₃₁,2) passes the local lift test into de Grey's field | medium-low |

## 6. Failure and pivot clauses

A core that lifts globally: HALT AND VERIFY — it is a 6-chromatic unit-distance graph (the jackpot clause verbatim).
All cores failing locally: the finite planes' 6-forcing is not the shadow of any unit-distance forcing at that prime — record,
and the shadow sieve (D7) becomes the only bridge left between the planes and the hunt.

## 7. Bearing on 6, honestly

Medium. It is the one route the pivot opens that could PRODUCE a 6-object rather than exclude fields; its odds are set by an
overdetermined diophantine system, and D2's local test says early whether there is anything to search.

## 8. Addresses

`tools/fplane.py` (`shadow`, `chi`), `tools/celllat.py` (the 1-minimal shrink, the ball machinery), `tools/closure.py`,
`Proofs/HadwigerNelson/UnitQuadrance.lean`, `plans/M58-field-sieve.md`.
