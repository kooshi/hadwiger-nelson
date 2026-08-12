# M39 — The constraint graph across scales: an exact attack on the upper bound
# (SUBPLAN — §0 registered 2026-08-12, desktop, before any instrument)

*Under Kooshi's autonomy authorization (expiring 12:00 UTC 2026-08-12).
Continuation of M37/M38, which established that a colouring constant on a
triangular lattice's cells is exactly a colouring of the lattice's **constraint
graph**, and closed that graph at seven colours for scales `p ∈ (1/2, 1)`.*

## The mission, and why it attacks the open half

M38's viewpoint has a consequence the milestone did not chase. For every scale
`p`, let `G(p)` be the graph on lattice addresses that joins `u` and `v` when
their Voronoi cells contain a pair of points exactly one unit apart. Then:

* a proper colouring of `G(p)` **is** a proper colouring of the plane (colour
  each point by its cell's label), so **`χ(ℝ²) ≤ χ(G(p))` for every `p`**;
* M38 says `χ(G(p)) = 7` for `p ∈ (1/2, 1)` — that IS the classical hexagonal
  seven-colouring, recovered as a graph-colouring fact;
* and **below `p = 1/2` nobody has looked**, because the family was invisible
  until the constraint-graph reading. If any `p` gives `χ(G(p)) ≤ 6`, then
  `χ(ℝ²) ≤ 6` — the open upper half of Hadwiger–Nelson.

The honest prior is that no such `p` exists (a six-colouring would be famous),
and then the measurement is still a rung: it extends M36's brick verdict onto
the natural hexagonal family, with an **exact** acceptance criterion this time
rather than a sufficient one — which is precisely the G21 lesson applied before
the fact rather than after.

## §0a — The derivation, committed before any instrument

**C1 — The exact criterion (this is the milestone's discipline).** Two cells at
lattice offset `d` realize a distance set `{|addr d + w| : w ∈ H}` where
`H = C − C = 2C` is the difference body of the Voronoi cell — in address
coordinates the hexagon with vertices `2·hole i`. Since `hexQ` is convex:
* `max` over `H` is attained at a **vertex** of `H` (six candidates);
* `min` over `H` is `0` if `−addr d ∈ H`, else attained on an **edge** of `H`
  (minimize a one-parameter quadratic per edge, exactly).
So `d` is an edge of `G(p)` **iff `min ≤ T² ≤ max`** where `T = 1/p` and both
ends are computed in exact rational arithmetic on the form — no floats, no
radicals, and NECESSARY as well as sufficient. M38's inscribed-disc condition
was only sufficient; using it here would measure the instrument (G21).

**C2 — What M38 already implies.** For `T ∈ (1, 2)` the criterion must return
edge set `{Q = 1, 3, 4}` — the coarse window — and the closed first shell must
be a 7-clique. This is the instrument's green control: it must reproduce M38.

**C3 — Where the clique argument must break.** The seven-point shell has
pairwise norms `{1, 3, 4}`, a distance ratio of 2. As `T` grows the edge set's
distance ratio shrinks toward 1, and no seven points in the plane have pairwise
distances within a factor approaching 1 — so **the shell clique cannot survive
for all `T`**, and the interesting question is what replaces it. Measuring the
clique number `ω(G(p))` across scales is therefore the first thing to do, and
its collapse below 7 marks exactly where a six-colouring would have room.

## §0b — Instruments

`tools/celllat.py` (new, UNTRUSTED): the exact edge criterion of C1 in
`fractions.Fraction`; the edge-set census across a grid of `T`; the clique
search (bounded, exact); and the torus SAT colouring (reusing the standing
`_solve`), where a proper colouring of the quotient lifts to the lattice.
Artifact `build/m39-cells.json`. Self-tests: the C2 green control (edge set
`{1,3,4}` on the coarse window and the shell a 7-clique), a planted red (an
offset whose interval misses `T²` must not be an edge), and the k = 4 mass red
(any 4-colouring found at any scale would contradict the kernel `χ(ℝ²) ≥ 5`
and is instrument catastrophe).

## §0c — Registered predictions

* **P1 [high]** — the instrument reproduces M38 exactly: edge set `{1,3,4}` for
  `T ∈ (1,2)`, the shell a 7-clique, and the coarse window's endpoints where
  M38 says they are.
* **P2 [medium-high]** — `ω(G(p))` drops below 7 somewhere below `p = 1/2`; the
  scale at which it drops is the milestone's headline number.
* **P3 [high]** — every SAT probe at `k = 4` refuses (mass red; a find is
  catastrophe, halt and report).
* **P4 [low — the long shot, stated so a find cannot be over-read]** — no
  `k = 6` colouring is found at any probed scale. **If one IS found it is
  `χ(ℝ²) ≤ 6`**: halt the campaign, re-derive the edge set independently, check
  the lifted colouring directly against the plane, and report to Kooshi before
  writing a word of interpretation. It would also be certifiable in the kernel
  by the M37/M38 machinery plus a finite table.
* **P5 [medium]** — where `k = 7` is found, the colouring is (up to relabelling)
  a coset colouring of an index-7 or larger ideal; genuinely non-coset
  seven-colourings at fine scales would be a finding in their own right.

## §0d — Failure clauses

* If the exact min-over-`H` computation is subtle, state and test it against a
  dense sampling of `H` (sampling can only refute) before trusting any verdict.
* If the SAT instances are too large at fine scales, report the scale reached
  and treat the rest as unprobed — never as refused (`unknown ≥ cap` is not a
  claim).
* Any segfault: HALT and report to Kooshi (standing).
