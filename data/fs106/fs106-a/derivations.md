# FS106-A working derivations (Poros, advisor) — FENCED from every blind job of FS-106

*One mind each, [hand]. Written 2026-09-26 before any planner draft. These are the advisor's sketches behind the expectation in
`plans/POROS-2026-09-26-fs106-regular-half.md`; a blind second mind must derive each claim without this file.*

## A1 — Closed ⟹ slack on a compact set (Voronov's closed-set step)

Let `A_1, …, A_6` be closed and cover the closed disc `U_3(0)`, and suppose no `A_i` realizes distance 1. The sets
`P_i(ε) = {(x,y) ∈ A_i × A_i : |x−y| ∈ [1−ε, 1+ε]}` are compact and nested in `ε`; their intersection over `ε > 0` is
`{(x,y) ∈ A_i² : |x−y| = 1} = ∅`, so some `P_i(ε)` is empty: each `A_i` avoids a whole band. This is the only use of closedness in
`[Voronov2023]`'s proof of Thm 1.3 (p. 14: the limit pair `(x*, y*)` lands in `A_i` because `A_i` is closed); the rest is Thm 1.1 run
locally on the radius-3 disc. So Thm 1.3 = compactness + local Thm 1.1, and the regular hypothesis the method consumes is the band.

## A2 — Where the band enters Thm 1.1's proof (read, `[Voronov2023]` v3)

1. Prop. 2.1 (p. 5): the tile-constant recolouring shrinks the band by `2h`; everything topological downstream (Obs. 2.2 hole filling,
   Obs. 3.1 finitely many bichromatic points on a circle, Prop. 3.4's polylines, Lemma 2.2's trichromatic point) lives on the tiled colouring.
2. Prop. 2.2 (p. 6): a point `w` with `|u−w| = |v−w| = l ∈ (1−ε, 1+ε)`; with one distance there are two such `w`, with the band an open set.
3. §3, first paragraph: "If in a proper 6-coloring of the plane the point x is trichromatic, for example C(x) = {4, 5, 6}, then T1(x) must
   be colored in 1, 2, 3" — true only because points near `x` of each colour of `C(x)` are within the band of every point of `T_1(x)`.
4. §5, last paragraph: the `α`-rotation with `0 < α < ε` that moves `x_1, y_1, z_1, y_0` off bichromatic points.
5. Prop. 3.3 needs the circle to need three colours; with one forbidden distance the unit circle's graph is a union of 6-cycles and
   half-open 60° arcs coloured alternately `a, b` two-colour it properly (θ and θ + 60° always differ in parity).

## A3 — Density exclusion (tight replacement of item 3 at density points)

**Claim.** Let `D ⊂ ℝ²` be measurable with no pair at distance 1 (or with the set of such pairs null for the 3-dimensional measure on
unit pairs, then off a null set of points). If `x` is a Lebesgue density point of `D` and `|x − y| = 1`, then `y` is a point of density 0
of `D`: `|D ∩ B(y,ρ)| / |B(y,ρ)| → 0`.
**Sketch.** Write `η(r) = |B(x,r) ∖ D| / |B(x,r)| → 0`. For `y' ∈ B(y,ρ)`, `T_1(y')` crosses `B(x,2ρ)` in a chord at offset `≤ ρ`, of
length `≥ 2√3 ρ`. If `y' ∈ D`, that chord misses `D` (everywhere form) or meets it in a null set (a.e. form), so the chord lies in
`E = B(x,2ρ) ∖ D` up to length zero. Parametrize `y' ↦ (θ, τ)` (direction from `x`, offset); this is a local diffeomorphism with
Jacobian `≈ 1`, `θ` ranging over an interval of length `≈ 2ρ`. By Fubini in each fixed direction, `∫ H¹(L_{θ,τ} ∩ E) dτ = |E|`, so
`|{(θ,τ) bad}| · 2√3ρ ≤ 2ρ · |E| ≤ 2ρ · η(2ρ) · 4πρ²`, and `|D ∩ B(y,ρ)| ≤ C η(2ρ) ρ²`. Curvature of the chords is `O(ρ²)` and does not
change the orders. ∎ (one mind)
**Corollary.** At a density point `x` of its colour, `D_{c(x)}` has density → 0 in the thin annuli `A(x, 1 ± δ)` — the band is recovered
asymptotically at density points, never uniformly.

## A4 — Tight touching is free: the cone pair

`e` a unit vector, `0 < α < π/2`, `r < cos α`, `K_p = {p + a : a·e ≥ |a| cos α, |a| ≤ r}`, `K_q = {q − b : b·e ≥ |b| cos α, |b| ≤ r}`,
`q − p = e`. Then `|q' − p'|² = 1 − 2(a+b)·e + |a+b|² ≤ 1 − 2 cos α (|a|+|b|) + (|a|+|b|)² < 1` for `0 < |a|+|b| < 2 cos α`, and within
each cone all distances are `≤ 2r < 1`. So `K_p ∪ K_q`, one colour, realizes distance 1 only at `(p, q)`; its interior has no unit pair;
`p` and `q` have density `α/π > 0`. Hence: (i) the naive a.e. form of Thm 1.3 ("closures realize 1") is no contradiction; (ii) the
pointwise measurable form of Prop. 2.2 is false as a local statement; (iii) regular hexagons of diameter exactly 1, seven colours, are an
a.e.-proper colouring by closed sets each realizing 1 (opposite vertices) — the same phenomenon.

## A5 — The tangent form of Prop. 2.2, and the two exceptional configurations it names

Blow up at scale `s` around `u` and around `w₀` (`|w₀ − u| = 1`, `e = w₀ − u`): `|w₀ + s b − (u + s a)| = 1` ⟺
`e·(b − a) = −(s/2)|b − a|²`, which tends to `e·b = e·a`. So, in the limit, colour `j` is forbidden at `w₀ + s b` whenever `e·b` lies in
`P_e(A^u_j)`, the projection onto `e` of the tangent class of `j` at `u`. For `u, v` with `C(u) ∩ C(v) = ∅`, `C(u) ∪ C(v) = [6]` and
`w₀` at unit distance from both, a positive-measure set of `b` near `w₀` sees all six colours forbidden iff
`I_u = ⋂_{j∈C(u)} P_{e_u}(A^u_j)` and `I_v = ⋂_{j∈C(v)} P_{e_v}(A^v_j)` both have positive length (`e_u, e_v` independent, so
`(e_u·b, e_v·b)` sweeps a neighbourhood). Cases at a trichromatic `u`:
- three convex sectors (a Y-junction, or three cones toward `w₀`): `I_u` is a half-line — the contradiction holds;
- the **bowtie** — colour 3 on a double cone about `e_u^⊥`, colours 1 and 2 on the sectors facing `±e_u` (a degree-4 vertex with three
  colours): `P(A_1) = (0,∞)`, `P(A_2) = (−∞,0)`, `I_u = ∅` — no contradiction; this is `[SokolovVoronov2025]`'s Condition 6
  ("no trichromatic vertices of degree 4+") recovered from the tangent computation;
- a two-colour interface at `x` whose boundary is tangent to `T_1(y)` at unit distance: the first-order test is silent (the projections
  are complementary half-lines) and the second-order term decides: flat facing boundaries (and polygon edges) contain unit pairs; the
  borderline is boundaries curving with the unit circle — `[SokolovVoronov2025]`'s Condition 5 ("forbidden arcs") and
  `[Townsend1981]`'s counterexample to `[Woodall1973]` (the arc `e` "of unit radius centre `a`").
Only the blow-up level is checked; the curvature corrections at the bowtie and the second-order interface case are open. (one mind)

## A6 — The a.e. slack corollary: the step to name

"Move it by a random rigid motion … and Thm 1.1 applies" (`CLAUDE.md` § The aim, link 4) gives de Bruijn–Erdős a finite subgraph whose
edge lengths are arbitrary numbers in the band, while an a.e. hypothesis on pairs gives properness at almost every distance only (or, in a
3-dimensional form, at every distance but a.e. pair). The repair to state: pass to Voronov's tile colouring directly (Prop. 2.1), choosing
for each tile a colour of **positive measure** in it; a monochromatic tile pair at a distance in the shrunk band then carries a
positive-measure set of monochromatic pairs at distances in the original band. Either route works; the claim must say which measure the
a.e. is taken in.

## A3′ — Correction: A3 is FS-103's D1 read from the other point

`plans/FS103-M-derivation.md` §3.1, D1: "If `y ∈ S̃_j` and `d̄_j(x) = θ > 0`, then `|x − y| ≠ 1`." A3's conclusion (density 0 at `y`) is D1's
contrapositive with the roles of `x` and `y` exchanged. A3 is not new. FS106-P caught it; I had not read D1 before deriving A3 (a G50 instance).

## A7 — C-T-TRI in its density form fails: cusp junctions

Start from any band-proper colouring, for instance the hexagonal seven-colouring with slack. Inside a ball about each vertex, much smaller
than the slack, redraw the junction as a cusp: the boundary between two of the regions is a smooth curve `Γ` through the vertex, and the
third region enters as a horn tangent to `Γ`, such as `{0 < x, x² < y < 2x²}`. The horn has area `O(r³)` in `B(v, r)`, so density 0 at `v`.
The redrawn colouring is still band-proper for a smaller band, hence a.e.-proper, and no point has three colours of positive upper density:
`|P(x)| ≤ 2` everywhere, while `P_supp(v)` (colours of positive measure in every neighbourhood) still has three. So the existence of
trichromatic points is a closure statement, the kills are density statements, and a cusp vertex is where the two part. (one mind)

## A8 — Holes: small ones are invisible, and features are cheap to excise

(a) Let `x` be trichromatic in a band-`ε` colouring and remove `B(x, ρ)` with `ρ < ε/2`. Points of each colour of `C(x)` within `2ρ` of
`x` still exist around the hole. Their band-annuli contain `T_1(x)` widened by `ε − 2ρ > 0`. So Voronov's step "`T_1(x)` avoids `C(x)`"
survives, and a small hole acts like a tile.
(b) Conversely, excising discs of radius `ρ ≪ ε` about every trichromatic point costs `N π ρ²` per unit area and leaves a complement with no
trichromatic point, so V-2.2 read in the complement fails. Voronov's proof uses about ten features per unit disc (V-6.1), so breaking the
proof costs `O(ε²)` per unit area, matching `[SokolovVoronov2025]` §9's `S(ε) = Ω(ε²)`. A stable form (C-Q-STAB) therefore cannot come
from stabilizing the proof. It needs an obstruction carried by sets of positive measure. (one mind)

## A9 — Second-order test for bichromatic pairs at unit distance (C-T-L1a)

At first order, blow-ups at `x` and `y = x + e` conflict unless the two colours' tangent classes are complementary half-planes with
interfaces perpendicular to `e`. Write the colour-1 interfaces as `e·a = κ_x|a⊥|²` at `x` (colour 1 on the side toward `y`) and
`e·b = −κ_y|b⊥|²` at `y` (colour 1 on the side toward `x`). Up to higher order, colour 1 has no unit pair iff the quadratic form
`(2κ_x−1)|a⊥|² + 2a⊥·b⊥ + (2κ_y−1)|b⊥|²` is ≥ 0. With `u = 2κ_x − 1` and `v = 2κ_y − 1`, that is `u, v > 0` and `uv ≥ 1`. Colour 2 (the
backs) has no unit pair iff `u, v < 0` and `uv ≥ 1`. The two conditions are disjoint. The borderline `u = 0` is `x`'s interface lying on the
unit circle about `y`, which is `[SokolovVoronov2025]`'s Condition 5. (one mind, sketch)
