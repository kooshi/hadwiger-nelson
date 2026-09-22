# M39 — the derivation file: every theorem this milestone stated outside the kernel

*Written 2026-09-22 by the FS-71 batch-2a implementer. Enumeration: `plans/M39-constraint-graph.md` read in full;
`tools/celllat.py` docstring spot-checked (restates §0a, adds nothing). Grades are `CLAUDE.md` § Notation's.*

## The theorems

**M39-T1 — The exact edge criterion for a scaled constraint graph. [hand; the M39 implementer; confirmed by a 300×200
dense-sampling control]** Fix the triangular lattice at scale `p`, `T = 1/p`, and its Voronoi cell `C` (a hexagon in
address coordinates under the form `Q(a,b) = a²+ab+b²`). For a lattice offset `d ≠ 0`, let `H = C − C = 2C` be the
difference body (the hexagon with vertices `2·hole i`). Then the pair of cells at offset `d` realizes exactly the
distance-squared set `{Q(addr d + w) : w ∈ H}`, and (since `Q` is convex on `H`) **`max` over this set is attained at
one of `H`'s six vertices, and `min` is `0` if `−addr d ∈ H`, else attained on one of `H`'s six edges** (a
one-parameter quadratic, minimised exactly in closed form). Consequently `d` is an edge of the constraint graph
`G(p)` **iff `min ≤ T² ≤ max`**, and this criterion is **necessary as well as sufficient** (unlike M38's
inscribed-disc test, which is only sufficient). *Proof:* `plans/M39-constraint-graph.md` §0a C1 (the convexity
argument: a linear functional — here a quadratic form restricted to a line through the offset — attains its extrema
on a convex polygon's vertex/edge set); confirmed, not derived independently, by `build/m39-cells.json`'s 300×200
dense sampling of `H`, which never escaped the computed `[min, max]` window (§R P1) — sampling is a control on the
closed-form claim, not a proof of it. *Proof verdict:* closes (the convexity argument is elementary and the claimed
extremal structure — vertex for max, edge-or-origin for min, of a convex quadratic form over a convex polygon — is
standard; the dense-sampling control found no counterexample across the probed grid). *Rests on it:* the entire
exact-arithmetic machinery of `tools/celllat.py`, reused unchanged through M40 (row 37), M42 (row 39) and M43 (row 40)
— i.e. every later gap-atlas / gap-kernel / fine-tail [tools] finding depends on this criterion's soundness, though
none of those milestones' Lean modules invoke it directly (M42's kernel forms, e.g. `exists_unit_pair_corner`, use
bespoke band-specific constructions instead — see Kernel below). *Prior art:* the mechanism — a convex quadratic
form's extrema on a convex polytope attained at vertices (max) or on the boundary (min, by a standard Lagrange/
one-variable reduction on each face) — is textbook convex geometry (support functions of a zonotope/hexagon), not a
citable result in this exact shape; the specific application (an "edge exists iff a target squared-distance lies in
the realizable interval of a lattice-offset's cell pair") was not searched as a named result. zbMATH:
`ab:"Voronoi cell" & ab:"difference body" & ab:"quadratic form"` (0 hits, 2026-09-22), `ti:"distance graph" &
ab:"lattice" & ab:"exact"` (0 hits). Nearest held key: none on point. *Kernel:* declined for its general form — no
module states or uses the min/max-over-a-hexagon lemma; the specific band instances that did reach the kernel
(`Coset.exists_unit_pair_corner`, row 39/M42) are separate, hand-tailored constructions for particular offset
families, not applications of this general criterion.

## Readings and measurements that were called theorems

- The whole `§R` SAT/ball census (clique numbers `ω(G(p))` across scales; the "oscillation" seven/eight/seven
  reading; the specific ball refutations `χ(G(1/3)) ≥ 8` outright and `χ(G(6/13)) = 7` exactly; the fine-scale
  `k = 7` SATs at `p = 1/6, 1/7`) is [tools] measurement — each an exact SAT computation on a named finite graph
  (a ball or a torus), correctly quantified in its own statement. **Superseded, not filed separately**: the
  correction banner at the top of `§R` (added by M40, deprecate-never-delete) states the `ω` census values below
  it were box/cap-clipped and wrong (true `ω = 9` on the bad band, `ω = 12` with `χ = 12` exactly on
  `p ∈ (0.4804, 0.5)`), and M40's "gap atlas" (row 37) re-runs and subsumes the whole scale census, including
  `p = 1/3`'s "deep pocket (1/3, 0.3464) has χ ≥ 8" (M39's `χ(G(1/3)) ≥ 8` finding, confirmed) and `p = 6/13`'s
  membership in the `G* = (0.4330, 0.4804)` band `χ = 7` reading. Row 36 (M39's own ledger row) correctly carries
  only the kernel content; the superseded census is not restated here as a theorem.
- The eight-clique / seven-clique kernel results (`Coset.eight_le_card_of_cell_constant`, `Coset.seven_le_card_fine`)
  are already kernel (row 36) — not filed here.

## Conjectures surfaced, not claimed

- **The scaled-shell exhaustion claim, asserted then refuted in the same corpus.** §0e states: *"The scaled-shell
  route is exhausted, and that is provable rather than observed... So the two windows already landed are all the
  scaled shell can ever give"* (argued from the inscribed-disc sufficient test, concluding the scaled shell is a
  clique only for `M < 4`, i.e. `M ∈ {1, 3}`). **This is false**, by the correction banner M40 attached to this
  file's own `§R`: *"§0e's 'scaled-shell route exhausted at M ∈ {1,3}' was derived with the inscribed-disc
  SUFFICIENT window and is FALSE under the exact criterion: the M = 4 shell owns the band (9, 28/3)."* Recorded
  here as a demoted claim with its refutation, per the project's demotion-record convention — not filed as a
  theorem (it was never true), and no proof to mark *gap* either (the argument's flaw is using a sufficient-only
  test, M38's, to make a universal claim that M39-T1's own necessary-and-sufficient criterion was built to correct).

## Prior art re-attributed

(none)

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M39-T1 | declined — the general min/max-over-hexagon criterion is never invoked directly in Lean; the kernel forms that followed (M42, row 39) use separate band-specific constructions |
