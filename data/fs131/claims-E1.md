# FS131-E1 — the claim list: two GAPs in the repaired chain of "maps need six"

*Fixed 2026-10-04 by Keryx. The questions below are copied by script, verbatim, from `plans/FS131-W-kernel-plan.md` § 1.6 on branch `fs131-ww` at `c7db6d7c` (FS131-W's record), and nothing else is in this file. Inventory items 88–91 hold the findings and rulings.*

## The questions


*Common setting.* A map of the plane bounded by a locally finite family of segments and circular arcs (an arc map; the questions make sense for Jordan
boundaries too), five colours, **almost-everywhere proper** (D-AEMAP): no two points of open regions of one colour are at distance exactly `1`;
boundary points carry no colour. `ω(p)` is the unit circle about `p`; `e(θ) = (cos θ, sin θ)`. Woodall's steps 1–3 are taken as done (Woodall's normal
form: at every vertex the regions have distinct colours, edges enter vertices in well-defined directions). A **sector** at a vertex `P` is a region near
`P` between two consecutive edges; its **angle** is the difference of the edges' directions. For a sector `b` at `P` with edges in directions `β₁ < β₂`
(`φ_b = β₂ − β₁`) and neighbours `a` (before `β₁`) and `c` (after `β₂`) of colours `A`, `C`, the **interior arc opposite `b`** is the set of points
`z = P + ρ e(ψ)` with `ψ ∈ I_b = (β₂ − 3π/2, β₁ − π/2)` (length `π − φ_b`) and `ρ ∈ (1 − h, 1)`, `h` small: for each such `z`, `ω(z)` passes through `a`,
`b` and `c` near `P`, so no region point of the arc has colour `A`, `B` or `C`. **Lemma (L)** (FS106-L, held at [hand], stated in the kernel as
`lemmaL`): in an open set `W` coloured with two colours whose classes are open and have no unit pair, a point `b ∈ W` with both colours arbitrarily
near has `ω(b) ∩ W = ∅`. **The strict step-4 lemma** (FS106-WO): an interior or exterior arc of positive thickness of length `> 2π/3` cannot be coloured
with two colours; it is false at exactly `2π/3` (Townsend's counterexample: the annular sector `1 − h ≤ |x| ≤ 1`, angles `[0, 2π/3]`, cut by the arc of
`ω((1, 0))` through `e(π/3)` into two one-coloured parts).

*The page image.* `[Woodall1973]` p. 198 (`library/pdf/jcta-1973-woodall-distances-realized-covering-plane.pdf`, PDF page 12, rendered at 130 dpi),
step 5, verbatim: "We may suppose without loss of generality that each region subtends an angle of more than ⅓π at each of its vertices … For suppose
that some region subtends an angle φ ≤ ⅓π at a vertex P: let this region be in set B (say) and the neighboring regions, necessarily in different sets,
be in sets A and C. Then opposite the region in B there is an interior unit arc of positive thickness of length π − φ ≥ ⅔π with center P, no point of
which can be in A, B, or C, and every point of which is therefore in D or E. And this we know is impossible by step 4 above." The OCR text layer reads
"an angle 4 < Qr" and "π − φ > ⅔π" there; FS106-V3 (stage 3) read the inequalities as strict ("Steps 5 and 7 use strict inequalities and survive").
p. 199, step 7: "(This is because φ_a > ⅓π and φ_c > ⅓π: a diagram will make this clear. The strictness of these inequalities is necessary.)"

**Q1 (F1) — step 5 at `φ_b = π/3` exactly.** Is the following configuration excluded? A vertex `P` with consecutive sectors `a, b, c` of distinct colours
`A, B, C`, `φ_b = π/3`, so `I_b = (ψ₁, ψ₂)` has length exactly `2π/3`; write `Q₁ = P + e(ψ₁)`, `Q₂ = P + e(ψ₂)`. **The open case:** the edge between `b`
and `c` is, near `P`, an arc of `ω(Q₁)`, and the edge between `a` and `b` is, near `P`, an arc of `ω(Q₂)`. *What I checked* [planner's check, one mind]:
(i) unless the `b|c` edge lies on `ω(Q₁)` near `P`, the set `W` of points whose unit circles meet `a`, `b` and `c` contains a one-sided collar (inner or
outer, of positive thickness) over a neighbourhood of the angle `ψ₁` — for an arc map, by comparing the edge (a segment, or a circle of another radius or
centre) with `ω(Q₁)`, both tangent to the direction `β₂` at `P`; likewise at `ψ₂` with the `a|b` edge and `ω(Q₂)`; (ii) if at least one end carries
such a collar, a change point `b′` of the interior arc (which has a unit pair, so both colours `D, E`, so change points at every thickness) lands — its
circle crosses `ω(P)` at angles `θ ± α`, `α ∈ (π/3, π/3 + O(1 − |b′ − P|))` — inside `W`, against lemma (L). So only the double-unit-arc configuration is
open; there the arc's two ends are genuine cut points and Townsend's two-colouring of the `2π/3` sector is not excluded by anything I found. *Needed:*
a contradiction in that configuration (from the rest of the map), or a different argument giving every angle `> π/3`, or the configuration
exhibited. Under Condition 5 (no boundary contains an arc of a unit circle) Q1 does not arise.

**Q2 (F2) — step 7's terminal vertex.** Is the following configuration excluded? A vertex `P` with exactly four sectors `a, b, c, d` (colours `A, B, C, D`,
distinct), every angle `> π/3`, `φ_b` the smallest (`π/3 < φ_b ≤ π/2`). The interior arc opposite `b`, `I_b = (ψ₁, ψ₂)` of length `π − φ_b ∈ [π/2, 2π/3)`,
is coloured `D, E` only and contains unit pairs, so both colours. By lemma (L), every `D|E` change point of the arc at angle `θ` has both landings
`θ ± α` outside the arc, so as the thickness tends to `0` the change points accumulate in the **window** `[ψ₂ − π/3, ψ₁ + π/3]` (length `φ_b − π/3`), at a
point `Q ∈ ω(P)`, with `D` and `E` in the multicolour of `Q`. Just outside `ω(P)` near the window only `B` and `E` can occur (the unit circles about those
points pass through `a`, `c` and `d`: computed, using `φ_a, φ_c > π/3` strictly). **The open case:** `B` does not occur near `Q`: outside `ω(P)` near `Q`
is all `E`, and `D` reaches `ω(P)` only from inside — (a) along an arc of `ω(P)` from `Q` (a unit arc centred at `P`, `D` inside, `E` outside), or (b) at the
single point `Q`: the tip of a `D` wedge pointing outward (the two `D|E` edges meet at `Q`, transversally to `ω(P)`), or an arc of a circle of radius `< 1`
tangent to `ω(P)` from inside at `Q`. Then `Q` carries only `D` and `E`: under Condition 2 ("every vertex is an endpoint of at least three boundaries")
it is not a vertex, Woodall's "e must terminate … by meeting a vertex on the unit circle with center P" fails, and step 6 is never reached. *What I
checked* [planner's check, one mind]: lemma (L) at the change points on the `D|E` edges near `Q` (their landings fall beyond the ends of `I_b` when `Q` is
strictly inside the window); the sector `d` at `P` (with `φ_a, φ_c > π/3`, `d` lies in the open half-plane facing every direction of the window, so the
unit circles about the `D` points near `Q` miss `d` near `P`, and conversely); TS-U at `P` for form (a) (`D` at `P` faces the arc: consistent); unit pairs
inside the arc (the `D` part has angular length `≤ φ_b − π/3 ≤ π/6`, the two `E` parts `≤ π/3` each, and the cross pairs land beyond the ends). No
contradiction found. Form (a) needs a unit arc; form (b) survives Condition 5. *Needed:* a contradiction in this configuration (perhaps from the other
three opposite arcs at `P`, or from the window's exterior collar coloured `B, E`), a different argument excluding vertices with four regions, or the
configuration exhibited. In step 8 (five regions at `P`) the same accumulation point carries `B, D, E` (outside the window only `B` can occur), so step 8
reduces to step 6 at `Q` in Woodall's normal form: Q2 is step 7's alone.

