# M47 — The three-distance plane: closing χ(ℝ²; {1, √3, 2}) if the numbers meet
# (STUB — written 2026-08-13. Read order for a fresh session: this file, then
#  `Proofs/Instances/HexShell.lean` (the lower bound, already kernel-checked),
#  `plans/M35-k5-transfer.md` §R (where that theorem came from), `plans/M39-constraint-graph.md`
#  and `tools/celllat.py` (the machinery for the upper bound, a small change away).)

## The one-paragraph version, for a reader who knows nothing

The famous question asks for the fewest colours such that no two points **exactly one unit apart**
share a colour; the answer is known only to be 5, 6, or 7. A natural variant fixes a small *set*
of forbidden distances instead of one. For the set {1, √3, 2} this repository already holds a
kernel-checked theorem: **at least seven colours are needed** — because a point together with its
six neighbours in a triangular grid of side 1 has all twenty-one of its mutual distances inside
that set, so those seven points must all differ. What we do not know is the matching upper bound.
The machinery to compute upper bounds for any finite set of forbidden distances is already built —
it is the cell-family instrument from four milestones ago, and extending it from one forbidden
distance to several is a change of a few lines. **If any scale yields exactly seven, the chromatic
number of the plane for this three-distance set is determined exactly, at both ends, in the
kernel.**

## Why this set and not another

It is not an arbitrary variant. **{1, √3, 2} is precisely the distance set the entire push toward
six colours lives in.** The reduction the from-below hunt rests on (G26) reads: the kernel already
holds Act One — every proper five-colouring of the plane puts a monochromatic pair at √3 or 2 on
the closed first shell — so a six-colouring proof needs exactly one more gadget, forcing a pair at
√3 or 2 to differ. The ambient in which that gadget must live is the graph on {1, √3, 2}. Studying
its chromatic number is studying the room the missing object has to sit in, and it is the cheapest
possible way to learn something structural about that room.

## The mathematical content, such as it is, stated honestly

* **Lower bound: done, kernel-checked.** `Instances/HexShell.lean`, `hexShell_pigeonhole` and its
  plane corollaries: the closed first shell is a 7-clique of the {1, √3, 2}-distance graph, so
  `χ(ℝ²; {1,√3,2}) ≥ 7`. The record already flags this as "compulsion folklore, formalization
  ours" — no novelty is claimed for the bound itself.
* **Upper bound: a small extension of an existing instrument.** The cell-family constraint graph
  `G(p)` joins two grid addresses when their cells contain a pair at the forbidden distance; the
  criterion is exact rational interval arithmetic (`celllat.interval`, `celllat.edge_set`) keyed
  on a single distance. For a set `D`, the graph is the **union of the edge sets at each distance
  in `D`** — mechanically, evaluating the same criterion at `d/p` for each `d ∈ D` and unioning.
  A proper colouring of that graph is a plane colouring avoiding all of `D`, so `χ(ℝ²; D)` is
  bounded above by its chromatic number at every scale.
* **The promotion path exists and has been exercised.** The certificate machinery (`Brick.lean`,
  with the boundary-tight soundness correction from M36, and the `avoids` surface that already
  certifies a nine-colouring avoiding an extra distance) is exactly the consumer for any find. A
  seven-colouring found by search becomes a kernel theorem the same day; that pipeline was run end
  to end at M36.

**The whole milestone is therefore: does any scale give seven?** If yes, `χ(ℝ²; {1,√3,2}) = 7`
exactly, both ends kernel-checked, and the answer is a complete determination. If no scale in the
family gets below eight, we have learned that the three-distance plane needs strictly more colours
than the one-distance plane's known upper bound — also a statement, and one that constrains the
room the missing gadget lives in.

## The gate that runs first, before any code

**A literature check, and it is a real risk to the milestone.** Chromatic numbers of the plane for
several forbidden distances are a studied subject (Chilakamarri and others on `χ(ℝ²; {1,d})`, and
the two-distance case in general). The specific set {1, √3, 2} is the closed hex shell's difference
set and is exactly the kind of thing that may already be settled. §0 is a literature pass with the
same discipline M43 applied when it found Voronov's theorem: if the value is known, the milestone
reports that, records the citation in the Grokkings, keeps whatever our machinery adds (a
kernel-checked instance of a known value is worth a footnote, not a milestone), and closes.
**Under the standing publication bar this milestone is below the line either way** — its value is
structural knowledge about the from-below hunt's ambient, not a publishable result.

## The phases

* **§0** — literature check (blocking) and registration.
* **§1** — extend the cell instrument to a forbidden *set*; green control: the singleton `{1}`
  must reproduce the recorded band atlas exactly, row for row. Planted red: a set containing a
  distance realizable inside one cell must be rejected loudly, not silently mis-scored.
* **§2** — the band decomposition for {1, √3, 2}: the thresholds now come from three families of
  offset windows, so the band structure is finer and the point-group class keying (M40) must be
  re-derived rather than reused.
* **§3** — clique numbers and colourability across the bands, at seven and eight colours, with the
  mass-red control at a colour count that must fail.
* **§4** — on a seven find: certify it through `Brick`/the cell certificate the same day, pair it
  with the standing `hexShell` lower bound, and state the equality. On no find: report the best
  upper bound reached and the scope (which scales, which caps), never as a bound on the family.

## The honest prior

Medium-low that a seven exists in this family — the three distance families' edge sets overlap
heavily and the graph is much denser than the single-distance one at every scale — and material
that the answer is already in the literature. The reason to keep it on the board anyway is cost:
it is a few lines of instrument change over machinery that is built, controlled, and already
proven to promote to the kernel, aimed at the exact distance set the main hunt depends on.
