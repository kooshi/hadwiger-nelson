# M44 — The ε-dial: the cell family is not a door, it is a dial, and its limit is the problem
# (STUB — written 2026-08-13, on Kooshi's "write up the ideas, then choose". Read order for a
#  fresh session: this file WHOLE, then `plans/M43-fine-tail.md` §R (the fine-tail campaign and
#  its autopsy), `plans/M40-chi-omega-hunt.md` §R (the band atlas and the cores), CLAUDE.md
#  G23/G24/G28/G29. The instrument is `tools/celllat.py`, already built and controlled.)

## The one-paragraph version, for a reader who knows nothing

Colour the plane so that no two points exactly one unit apart share a colour. Nobody knows
whether 5, 6, or 7 colours are needed. This project built a family of finite, exactly-computable
graphs `G(p)` — one per scale `p` — whose colourings are exactly the plane colourings that are
constant on the cells of a triangular grid of that scale. Over five milestones we measured that
`G(p)` needs **seven** colours at every scale we ever probed, and closed the family as a research
direction because no six-colouring can live in it. **That was the right verdict on the wrong
question.** Being constant on cells of scale `p` means you forbid not just the distance 1 but a
whole small *interval* of distances around 1 — and that interval shrinks to nothing as the cells
shrink. So the family is a continuous dial: at one end, the classical seven-colouring; at the
other end, as the cells shrink to points, **the dial's limit is the unit-distance problem itself.**
The answer is seven for every setting of the dial, and might be five or six only exactly at the
limit. This milestone measures how the seven-forcing behaves as the dial turns toward that limit,
and states — and, if it holds, kernel-checks — the bridge theorem that makes the measurement mean
something.

## Why this reopens a direction that was closed

M43's close wrote: *"the from-above route is finished as a source of new mathematics."* The
reasoning was sound on its own terms — no six-colouring exists anywhere in the family, and
conditional on Voronov's proof of the Exoo conjecture (arXiv:2304.10163, external, unverified
here) that is provable at every scale, so no refinement of the construction can ever produce a
six-colouring of the plane.

What that argument evaluates is the family **as a door** (can a six-colouring walk through it?).
It says nothing about the family **as a dial** (what happens to the seven-forcing as the scale
goes to zero?). Nobody asked. The Voronov connection, which M43 treated as the direction's
tombstone, is precisely what makes the dial meaningful: it says the function is *constant at
seven on the entire open ray*, so every bit of information about the plane's own answer is in the
approach to the endpoint.

## The derivation, to be done on paper BEFORE any instrument runs (§A)

This milestone leads with a derivation, not a probe list, and the derivation is the deliverable
that survives even if every measurement is boring.

**A1 — the interval half-width `δ(p)`, exactly.** For each address offset `v`, the realizable
distances between two cells at that offset form a closed interval `I_v` (this is
`celllat.interval`, already exact and rational in the squared-norm coordinate). Define

> `δ(p) = min { dist(1, I_v) : v an offset with 1 ∉ I_v }`, over the finitely many `v` whose
> interval comes near 1.

Then **every proper colouring of `G(p)`, read as a plane colouring, avoids every distance in the
open interval `(1−δ(p), 1+δ(p))`** — provided the cell diameter `2p/√3` is below `1−δ(p)`, which
holds throughout the fine regime. Proof, three lines: two points at a distance in that interval
lie either in one cell (impossible — the cell is too small) or in cells at an offset whose
interval contains their distance; if that offset's interval missed 1 it would miss the whole
interval by definition of `δ`; so it contains 1, so the two cells are adjacent in `G(p)` and get
different colours. This is M43's bridge to Voronov, restated with the width made explicit and
computable rather than merely asserted positive.

**A2 — the limit lemma (the new content; NOT in the record anywhere).**

> Let `C(p)` be a vertex-critical non-6-colourable subgraph of `G(p)` (what our 1-minimal shrink
> produces), `N(p) = |C(p)|`. **If `N(p)` stays bounded along any sequence `p → 0`, then
> `χ(ℝ²) ≥ 7`.**

Proof shape, to be written carefully in §A and then, if it survives, formalized:
* A vertex-critical non-6-colourable graph is connected with minimum degree ≥ 6, so bounded
  vertex count plus edges of length `1 ± O(p)` gives a bounded **physical diameter** for free —
  the second boundedness hypothesis is not needed as an assumption.
* Take cell centres. Pass to a subsequence on which the vertex count, the labelled edge set, and
  (by Bolzano–Weierstrass inside a fixed compact ball) every vertex position converge.
* Every edge realizes distance 1 between two cells of diameter `2p/√3 → 0`, so the limiting
  positions of its endpoints are at distance **exactly** 1.
* Two indices may converge to the same point. They cannot be adjacent (an edge would have length
  1, not 0), so the limit is the original graph with some non-adjacent vertices identified — and
  identifying non-adjacent vertices only *raises* the chromatic number. The limit is therefore a
  finite point set in the plane whose distance-1 graph is not 6-colourable.

**The consequence, stated as sharply as it deserves:** the divergence of `N(p)` as `p → 0` is a
**necessary condition for `χ(ℝ²) ≤ 6`.** It is the exact quantitative obstruction between the
proven interval theorem and the open point theorem. Measuring the growth of `N(p)` is therefore
measuring the rate at which the plane escapes the seven — the first quantity in this project that
speaks to *which* of 5, 6, 7 is true rather than to whether one more object we built happens to
force.

**A3 — what a measurement of `N(p)` can and cannot say.** Registered honestly before any run:
a plateau is not a proof (only a bounded *subsequence*, which no finite ladder establishes) but
is strong evidence for `χ(ℝ²) = 7` plus a concrete size and diameter target for a witness.
A clean divergence is not a proof of `χ(ℝ²) ≤ 6` either; it is the removal of an obstruction, and
its **rate** is then the first principled estimate anywhere of how large a 7-forcing unit-distance
graph would have to be. There is no outcome of this measurement that is uninformative, which is
the property that made it worth promoting over a search.

## The preliminary reading from data already on disk (unregistered, must be re-measured)

Skimming the recorded cores across bands — **explicitly not a measurement; these came from
different bands, different shrink procedures, and different caps, and comparability is phase 1's
first job** — the pattern that prompted this milestone:

| band | scale `p` | vertex count of the recorded core | core physical radius (rough) |
|---|---|---|---|
| G\* | ≈ 0.433–0.480 | 23 | ≈ 1.3 |
| deep pocket | ≈ 0.333–0.346 | 53 | ≈ 1.7 |
| 1/6 flank (ω = 3) | ≈ 0.167 | 117 | ? |
| 1/7 coarse flank | ≈ 0.143 | 160 (ball `R*` = 9, 301 vertices) | ≈ 1.29 |

Two things jump out and both are registered predictions, not findings:
* **`N(p)` grows like a power of `1/p`** — the four points fit `N ∼ p^{−5/3}` to within the noise
  of four incomparable numbers.
* **The physical radius looks scale-INVARIANT at ≈ 1.3–1.7 unit distances**, which is what you
  would see if the seven-forcing occupies a *fixed physical region* and the vertex count grows
  only because that region is being sampled more finely (a fixed region holds `∼ p^{−2}` cells;
  we see a little less, i.e. a slightly sparsified region).

If the second holds down through another decade of scale it is the most useful design constraint
this project has ever produced: **the seven-forcing configuration is about one and a half unit
distances across, at every scale** — so a 7-forcing unit-distance graph, if one exists, plausibly
fits in a disc of that radius, and the from-below hunt has been searching objects (the 1581 and
its closures span far more) of the wrong shape.

## The phases

* **§0 — registration** (before any run): objects, priors with the evidence both ways, acceptance
  criteria that are necessary as well as sufficient (G21), failure clauses. `unknown at cap` is
  never a verdict. Nothing below runs before §0 is committed.
* **§A — the derivation.** A1 and A2 written out properly, with the collision case and the
  criticality/connectivity step done in full. If A2 does not survive careful writing, **the
  milestone reports that and stops** — the measurement without the bridge is a curiosity.
* **§1 — comparability.** Re-derive every core in the table above through ONE procedure at ONE
  cap, so the numbers are a sequence and not an anthology. This is the phase that decides whether
  the preliminary reading was real or an artifact of four different milestones' settings.
* **§2 — `δ(p)` exactly**, per band, on the existing rational window code. Cheap, pure arithmetic,
  and it gives the dial its true x-axis (the interval half-width, not the scale).
* **§3 — the ladder.** Refute six colours and shrink to a 1-minimal core at a ladder of decreasing
  `p` (extending past M43's `p ≈ 0.109` floor as far as the solver allows), recording
  `(p, δ, N*, physical radius, orbit profile, ω)` per rung. The twelve deep-tail bands M43 left
  as honest unknowns at cap are on this ladder and get a second, better-aimed attempt — but they
  are a by-product, not the point.
* **§4 — the curve, read honestly**, against §0's registered predictions, with the scope clause
  M43's autopsy earned: these witnesses refute *cell-constant* colourings, a restricted class, so
  the counts are an upper bound on the true interval-witness size and never a lower one. (The
  limit lemma is unaffected: the constancy restriction evaporates as `p → 0`.)
* **§5 — kernel, if A2 survives.** The limit lemma is a compactness argument over a finite point
  set in a compact ball — Bolzano–Weierstrass, a fixed finite graph along a subsequence, and the
  observation that identifying non-adjacent vertices cannot lower the chromatic number. This is a
  genuinely new *shape* of theorem for this repository (every existing result is a finite
  certificate or a closed-form classification; this is a limit statement connecting a family of
  finite certificates to a plane statement) and it is Mathlib-sized, not M06-sized. Stretch goal;
  the milestone lands without it.

## The honest prior

Nothing here is likely to settle the problem. What is likely — and what the record has been short
of since M41 — is that this produces (i) a stated, provable bridge nobody has written down,
(ii) a quantity nobody has measured, and (iii) a design constraint on the from-below hunt derived
rather than guessed. The failure mode to name in advance: `N(p)` may simply be dominated by the
solver's shrink quality rather than by mathematics, in which case §1's comparability check comes
back noisy and §4 reports a measurement of `tools/celllat.py` instead of a measurement of the
plane — which is G21, and which is why §1 exists and runs before §3.
