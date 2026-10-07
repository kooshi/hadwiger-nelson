# FS-124 — the kernel lane's claim list, first module (the radius clause)

*Fixed by Keryx, 2026-10-07 (13:20 UTC), for the kernel lane's planner: the statements and their not-claimed lines, copied by
script from the deriver's entries, and nothing else — no grade, no route, no model. A weak `k`-colouring of an open set `U` of
the plane is a measurable map `c` from `U` to `k` labels with `c(z) ≠ c(z + u)` for almost every pair of a point `z` of `U` and a
unit vector `u` with `z + u` in `U`; a rigid motion is an orientation-preserving isometry of the plane; `χ(ℝ²)` is the chromatic
number of the unit-distance graph of the plane. In the order the planner takes them. A later change is a dated line at the end.*

**C124-RADIUS-GRAPH** — statement: Let k ≥ 1, U an open set of the plane, c a weak k-colouring of U, and V a finite subset of U. Then the rigid motions g with g(V) ⊂ U form a non-empty open set, and for almost every one of them the points g(v), g(v′) have different labels for every two points v, v′ of V at distance 1; so the unit-distance graph on V has a proper k-colouring.

*Not claimed (C124-RADIUS-GRAPH):* anything for an infinite V (C124-RADIUS-COUNTABLE takes countable sets with compact closure in U); that any open set has a weak k-colouring; a bound on the measure of the good motions beyond "full"

**C124-RADIUS-COUNTABLE** — statement: Let k ≥ 1, U an open set of the plane, c a weak k-colouring of U, and V a countable subset of U whose closure is a compact subset of U. Then the unit-distance graph on V has a proper k-colouring of the form v ↦ c(g(v)) for a rigid motion g with g(V) ⊂ U.

*Not claimed (C124-RADIUS-COUNTABLE):* anything for an uncountable V; anything for a countable V that accumulates at the boundary of U; that the colouring obtained is measurable in any sense on a larger set

**C124-RADIUS-UP** — statement: For every integer k ≥ 1: if for every R > 0 the open disc of radius R about the origin has a weak measurable k-colouring, then every finite unit-distance graph in the plane has a proper k-colouring, and χ(ℝ²) ≤ k.

*Not claimed (C124-RADIUS-UP):* an explicit radius at any k; the converse (C124-RADIUS-DOWN, which uses an import); that the hypothesis holds at k = 6; anything from one disc beyond the finite graphs that fit inside it

**C124-RADIUS-DOWN** — statement: For every integer k ≥ 1: if χ(ℝ²) ≤ k, every open set of the plane has a weak measurable k-colouring.

*Not claimed (C124-RADIUS-DOWN):* anything without that import; that χ(ℝ²) ≤ 6; any regularity of the colouring obtained beyond measurability

**C124-RADIUS-FIVE** — statement: There is R > 0 such that no open disc of radius R has a weak measurable five-colouring.

*Not claimed (C124-RADIUS-FIVE):* any value of R — the argument gives the radius of a disc holding a finite unit-distance graph that is not five-colourable, which exists by compactness and has not been exhibited; the same at six
