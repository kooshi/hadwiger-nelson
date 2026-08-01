# M14 — Seed optimization (carry-forward capture)

*Opened 2026-08-01, immediately after M13 landed. **Not subplanned** — this is the evidence a
subplanning session starts from, so nothing here has to be rediscovered.*

**The hunt is now M15.** This milestone was inserted ahead of it because M13 measured the
bottleneck, and it is not the one the roadmap assumed.

> **The search is not compute-bound. It is bound by the choice of seed points — the one part of de
> Grey's construction he did by hand, and the one nobody has automated.**

---

## 1. The measurement that put this milestone here

M13's search, desktop, 2026-08-01. Growth arm: build a configuration, orbit it under the hexagonal
group, spindle it, ask whether any pair of points is forced to share a colour in every
4-colouring.

| | |
|---|---|
| universes examined | **33**, from 7 to 679 points |
| oracle cost | **51 s per universe** (one backbone per pivot) |
| forced pairs found | **0** |
| pivots left unsettled | **0** — so these are real negatives, not timeouts |
| branching factor | **378 spindle moves from one 43-point configuration** |

**Two independent reasons this does not converge, and neither is fixed by hardware.**

**(a) The target is unreachable.** de Grey's construction begins at **39 hand-chosen points**. The
growth moves — orbit, spindle, union — only ever *add* points, so they produce orbit closures and
never a hand-chosen subset. The one subtractive move, `delete`, belongs to the shrinker, which needs
a forcer to start from. So his seed set is not slow to find; it is **not in the reachable set at
all**.

**(b) The rate is not close either.** At branching 378, depth 2 is 142,884 nodes ≈ **84 CPU-days**
(we sampled 33 — 0.02%), and depth 3 is 54 million nodes ≈ **87 CPU-years**.

**And there is no gradient to climb toward a good seed set**: all 39 of de Grey's seed points are
irredundant, measured — drop any one and the forcing dies, 39 of 39 in 46 s. Every proper subset of
the answer scores exactly zero, so the objective is flat everywhere except at the answer.

**A hardware request was considered and declined on this evidence.** Scaling to the 256-core server
would buy 8× against a target the move set cannot express. Recorded because the standing instruction
is to ask for what the work needs, and this is the measurement that says compute is not it.

---

## 2. What this milestone is

**Solve for a seed set instead of enumerating seed sets.** The win condition is already a
statement with two quantifiers:

> ∃ a finite point set `C` and points `p, q ∈ C` such that ∀ proper `k`-colourings of `C`,
> `C` gives `p` and `q` the same colour — and `4·|pq|² − 1` is a square in ℚ(√3,√5,√7,√11).

That is a **∃∀ problem**, not a tree search, and enumerate-and-test is the worst possible algorithm
for one. The shapes worth trying, in the order they should be measured:

1. **CEGAR / counterexample-guided refinement.** Start from a candidate set; ask the oracle; a
   `separated` answer returns a *witness colouring* that separates `p` from `q`. That witness is
   information the current search throws away — it says exactly which colouring must be killed, and
   the points that would kill it are the ones to add. This is the single cheapest change and it
   turns a blind walk into a guided one.
2. **QBF, or a 2-level SAT encoding** over a fixed candidate universe: choose a subset of a rich
   point set such that every 4-colouring of the subset agrees at `p` and `q`. Bounded, complete over
   that universe, and it answers "no such subset exists here" — which enumerate-and-test never can.
3. **Local search over subsets of a rich universe**, with the forcing margin as an objective rather
   than the binary answer. Needs a *graded* objective, which § 4 flags as the open problem.

---

## 3. What is already built and needs no rebuilding

**Lean** — `Proofs/HadwigerNelson/Forcer.lean`, all proved, axioms exactly the standard three:

* `Forces G k p q` — the win condition, over any graph and any colour count.
* `not_colorable_of_spindled_forcer` — **a forced pair plus a spindle is a rung.** Whatever M14
  finds is cashed through this and nothing else has to be re-argued.
* `not_colorable_spindleEdges` — the same where the graph is *constructed*, so no placement is
  searched for and the joining edge is free by construction.
* `Forces.of_edges` (exhaustion, `by decide +kernel`), **`Forces.of_unsat` (a SAT certificate
  directly — the producer at scale, and the one that works at four and five colours)**,
  `Forces.of_gadget` (through the gadget algebra).
* `Forces.mono` (more edges force more), `Forces.comap`, `Forces.map` (a symmetry carries a forced
  pair to a forced pair — one pivot per orbit is enough, on a configuration that *is* symmetric).
* `ForcerDiagnose` — which side condition refused a candidate, in the user's vocabulary.

**Tools** — `construct.py` (seed, spindle, **orbit**, **delete**, `index_of`, and
`degrey_from_primitives`, which rebuilds his 1581 points from 39 seeds and matches the committed
table exactly) · `forcer.py` (`forces` with three outcomes, `backbone` carrying `unknown` as a set,
`shrink` that earns the word "irredundant") · `field.py` · `profile.py` · `scan.py` · `minimise.py`
· `shrink.py` · `emit_mask.py`.

---

## 4. The open problems, named

* **There is no graded objective.** "Is this pair forced?" is a yes/no, and every configuration
  short of the answer scores zero. Local search needs a real-valued signal — *how close* is this set
  to forcing? Candidates worth measuring: the number of colourings that separate the pair (model
  counting, expensive), the size of the smallest set of separating colourings that would have to be
  killed, or the fraction of port patterns already refuted. **Measure one before designing around
  it.**
* **The witness colouring is currently discarded.** `forces()` returns `separated` without the
  colouring that separates. Returning it is a small change and it is the input CEGAR needs.
* **The universe must contain a forcer or nothing can be found in it.** M13 measured that the tool's
  own seeds — unit edge, triangle, rhombus — all live in the unit triangular lattice, whose
  hexagonal orbit is a single 7-point patch, and that the `r² = 1` spindle is a 60° rotation that
  patch is already closed under. **Spindling first is what leaves the lattice.** Any universe
  construction has to do that deliberately.
* **How tight must a configuration be before it forces anything?** Unmeasured at four colours from
  below; de Grey's answer from above is 793 points. The M13 shrink of his own forcer was **killed by
  request before it reported**, so this number is still open and it is cheap to get.

---

## 5. The cost model

Desktop (32 cores, 125 GB). Everything a subplanning session should reason from.

| quantity | value |
|---|---|
| forcing oracle, loose configuration (≤ 400 points) | 0.1–0.5 s |
| forcing oracle, one universe in the M13 search (≤ 679 points) | **51 s** |
| forcing oracle, tight 791-point configuration | 32 s one pair · 112 s full backbone |
| reject a candidate (find a 5-colouring), 553 points | 0.02 CPU s |
| certify one at four colours, 553 points | 37.4 CPU s → **1,104,106 kernel steps ≈ 40 min** |
| certify de Grey's 1581 points | 34,169,571 steps → **27.8 h**, 2,265 modules |
| branching factor, 43-point configuration | 378 spindle moves |
| kernel, per propagation step | ~1.35 ms projected; 1.4–2.9 ms with elaboration |
| emitted literal coordinates | 7.1 ms per edge |
| **computed** coordinates by `decide` | 0.33 CPU s per edge — 47× worse |
| computed coordinates through `Assembly` | **free** |
| terminal check, interface vertices at five colours | 10 (86,472 partitions, 257 s) |

**Looking is nearly free; certifying is hours.** That asymmetry is not the bottleneck and never was.

---

## 6. Explicitly *not* in this milestone

**χ ≥ 6.** That is M15. M14 ends when a seed set is found by search rather than by hand — or when
the ∃∀ formulation is measured intractable at the sizes that matter, and that is reported.

---

## 7. Honest risks

* **Seed optimization may be the hard part of the whole problem.** de Grey found his 39 points by
  insight. If the ∃∀ search is intractable at 100+ points, this milestone reports that and rung D
  needs a different idea rather than a bigger machine.
* **A graded objective may not exist.** If forcing really is a cliff — nothing, nothing, nothing,
  then everything — then local search cannot work in principle and only complete methods (QBF,
  exhaustive subset search over a bounded universe) are left. § 4's first item decides this.
* **Extending the field doubles every coordinate.** `field.py`'s `missing_root` names the root a
  refused spindle would need; adjoining one doubles the tower and every coordinate with it.
* **Refutation cost is not monotone in graph size** (M07), and at five colours instances of the same
  size varied by two orders of magnitude (M12). "Smaller" is not "cheaper".
* **Symmetry carries no colouring information.** A rotationally symmetric unit-distance graph need
  not be hard to colour. Symmetry can **promote** a candidate and can never **reject** one.
