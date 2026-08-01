# M13 — Re-finding χ ≥ 5 with the search (carry-forward capture)

*Opened 2026-08-01, immediately after M12 landed. **Not subplanned** — this is the evidence a
subplanning session starts from, so nothing here has to be rediscovered.*

**The hunt is now M14.** This milestone was inserted ahead of it for one reason, and it is a
measurement rather than a preference:

> **A search instrument that cannot re-discover the witness for the rung below is not credible for
> the rung above.**

That is the same discipline the project already runs on — the Moser spindle was rung A's calibration
instance for the entire pipeline, deliberately small enough that `decide` could cross-check the SAT
bridge. This milestone is that discipline applied to the *search itself*.

---

## 1. The measurement that put this milestone here

Blind breadth-first search from seeds, using only the moves `tools/construct.py` has, asking each
graph its chromatic number. Desktop, 2026-08-01.

| | |
|---|---|
| the **Moser spindle** — rung A's witness — found at | **depth 1, under 1 s, 3 graphs examined** |
| verified isomorphic to the committed one | **yes** |
| anything needing **five** colours | **none** — 1,961 distinct graphs, 23 levels, 358 s |
| how the search ended | **exhausted**, frontier empty |

**So the instrument would have found χ ≥ 4, and cannot reach χ ≥ 5.** The exhaustion is the sharper
half: spindle-from-seeds is a *small closed family*, not a space that merely wants more budget.
Adding compute to this move set buys nothing.

**And the search found a bug eleven hand-written controls missed** — a division by zero on the
degenerate half-turn spindle (`r² = 1/4`, radicand 0). That is a second, independent argument for
calibrating against a running search rather than against a tool's own examples.

---

## 2. de Grey's construction, step by step — because omitting it would be arrogant

His route is the one construction *known* to reach χ ≥ 5, and it is fully written down in
`tools/degrey.py`, which follows arXiv:1804.02385v3 § 5.1 verbatim. Reproduced here because the
milestone's first job is to be able to walk it:

| step | move | do we have it? |
|---|---|---|
| 1 | a hand-chosen **seed set** `S` | seeds yes, *his* seed set no |
| 2 | `S_a` = **orbit of `S` under the order-12 group**: six rotations by multiples of 60° together with reflection in the x-axis | **no** — this is the missing primitive |
| 3 | `S_b` = `S_a` rotated by `2·arcsin(1/4)` (`cos 7/8`, `sin √15/8`) — the spindle at `r² = 4` | **yes** |
| 4 | `Y = (S_a ∪ S_b)` **minus two points** `(±1/3, 0)` | union yes, **deletion no** |
| 5–6 | rotate `Y` about `(−2, 0)` by `π/2 ± arcsin(1/8)`, and take the union of the two images | **partly** — we rotate only so that a *designated pair lands a unit apart*, never about an arbitrary centre by a chosen angle |

So the primitives this milestone needs are **named by his construction rather than guessed**:

1. **Orbit under a finite group** — his step 2, and the largest gap. `Assembly` already covers the
   *Lean* side of many placed copies (one certificate, seams only); what is missing is the tool move
   that proposes one.
2. **Deletion** — his step 4 removes exactly two points. A search that can only grow cannot express
   this, and it is not a detail: those two points are removed because they are the ones that make the
   graph 4-colourable.
3. **Rotation about an arbitrary centre by any available angle** — his steps 5–6. Strictly more
   general than the spindle move, which fixes the angle from a chosen pair.

**Alternatives are welcome and may well be better** — his construction is one path up a mountain with
no map, and the instrument exists partly to look for others. But a search that *cannot express* the
one route known to work has not been shown to be searching the right space at all. Being able to walk
his path is the calibration; finding a different one is the win.

### What his argument then does with the graph

Not brute force. `G` is **two rotated copies of `Y` sharing exactly one vertex and joined by exactly
one edge** — `tools/degrey.py`'s `halves()` makes the split explicit, and M06's proof is built on it:
one forcing lemma per half, composed. M09 later found the second copy is the first *rotated* and
deleted 1,043 modules, 180 MB and 12.8 hours by deriving it instead of certifying it.

**That is the gadget-composition route, and it is why the catalogue matters here rather than as a
separate deliverable.** de Grey did not find a 1581-vertex graph and hand it to a solver; he
composed properties. The instrument's leverage is the same.

---

## 3. Why a gadget catalogue must be *constructed* here, not collected

M12 measured this and it is the hardest constraint on the milestone:

* **Nothing this project owns forces any port property at five colours.** Zero of 48 non-adjacent
  port sets across four graphs; of 16,657 exact distance classes the only forcing one is the unit
  distance itself. The four-colour control fires (5 of 5 patterns refuted on a graph with no
  4-colouring), so this is a fact and not a broken probe.
* **The cause is structural.** A graph comfortably `k`-colourable imposes nothing on scattered
  points, and every graph here is comfortably 5-colourable — de Grey's included, which is exactly
  5-chromatic. Forcing needs a graph **tight at the colour count being asked about**.
* **So the first unmeasured quantity is the tightness threshold**: how large or how constrained must
  a configuration be before it forces *anything* at five colours? That measurement goes first, exactly
  as M12's five-colour cost did — and it is cheap, because the profiler is free.

---

## 4. What is already built and needs no rebuilding

**Lean.** `Assembly` (many placed copies, one certificate, intra-copy edges free, seams checked;
`adj_embed` so the colouring transports along the same map) · `AssemblyDiagnose` (which seam failed,
by copy and base vertex) · the `Gadget` algebra at any colour count — `inter`, `mono`, `widen`,
`transport`, `edge`, `ofUnsat`, `ofExhaustion`, `survivors`, `not_colorable_of_gadget` ·
`Pattern` (one colouring per colour-partition) · `Motion` (similarities, composition) ·
`Instances/Mycielski` (the five-colour calibration instance).

**Tools.** `field.py` (exact arithmetic, one implementation, and the spindle-availability test) ·
`construct.py` (seed, triangle, rhombus, spindle, union) · `profile.py` (a subgraph's whole port
property) · `minimise.py` · `scan.py` (finds the isometries a point set already exhibits — this is
how de Grey's own 791-point split was recovered in 3.6 s) · `shrink.py` · `emit_mask.py`
(colour-parametric, and able to read the graph out of the DIMACS Lean printed).

---

## 5. The cost model, all of it

Desktop (32 cores, 125 GB). Everything a subplanning session should reason from.

### The search loop

| quantity | value |
|---|---|
| one search step end to end | **~17 ms** (geometry 0.8 ms, reject 1.7 ms, profile 15 ms) |
| reject a candidate (find a 5-colouring), 553 vertices | **0.02 CPU s** |
| certify one (refute at 4 colours), same graph | 37.4 CPU s — **~3,000× the cost** |
| profiler, 855 port patterns at 7 ports, 5 colours | 0.19 s wall |

**The asymmetry is the search's whole economics**: looking is nearly free, certifying is not.

### Five colours, once something is found

| quantity | value |
|---|---|
| 47-vertex 6-chromatic graph, refuted at 5 colours, one edge pinned | **387,065 propagation steps ≈ 9 min kernel**, 19 modules, 2.9 MB |
| the same, unpinned | 10,224,710 |
| colour-naming lever at 5 colours (a **triangle** — the largest clique the plane permits) | **8.5–53×, median ~25×** |
| M07's configuration race, at gadget scale | **1.00× — does not reproduce** |
| one more colour, at matched size and criticality | **10–30×** |
| for scale: the 553-point witness at *four* colours (M07) | 1,104,106 steps |
| de Grey's 1581-point witness at four colours (M06) | 34,169,571 steps, 27.8 h, 2,265 modules |

### The composition ceilings

| quantity | value |
|---|---|
| terminal check, interface vertices at 5 colours | **10** (86,472 partitions, 257 s); 12 is out of reach |
| gadget with no certificate at all (`ofExhaustion`) | **7 vertices** at 5 colours |
| kernel, per propagation step | ~1.35 ms projected; 1.4–2.9 ms end to end with elaboration |

### Geometry and assembly

| quantity | value |
|---|---|
| emitted literal coordinates | **7.1 ms per edge** (M08) |
| **computed** coordinates checked by `decide` | **0.33 CPU s per edge — 47× worse** |
| computed coordinates through `Assembly.validOn_copiedEdges` | **free** — no per-edge reduction |
| sub-copy scan, 1581 points | 3.6 s, exact |

**That middle row is why `Assembly` is mandatory rather than an optimisation**: a candidate built as
copies must be certified symbolically or it is worse than not building it as copies at all.

### The field

Spindling at squared distance `r²` needs `√(4r²−1)`; √3, √5, √7, √11 are exactly the spindle radicals
of `r² = 1, 3/2, 2, 3`. **32 of 94 sampled radii** are available. Extending is a parameter change with
a principled trigger (`field.py`'s `missing_root` names the root a refusal would need), and it doubles
the tower and every coordinate with it.

---

## 6. Explicitly *not* in this milestone

**χ ≥ 6.** That is M14. This milestone ends when the search re-finds a 5-chromatic unit-distance
graph, or when it is measured not to and that is reported.

---

## 7. Honest risks

* **Re-finding χ ≥ 5 may be nearly as hard as finding χ ≥ 6.** If so this is a second wall rather
  than a stepping stone, and the milestone should fall back to a weaker, still-useful target: *the
  best chromatic number the search reaches, reported honestly*, plus the tightness threshold.
* **The tightness threshold is unmeasured** and could be large enough that constructed gadgets are
  individually unaffordable to certify.
* **de Grey's seed set is hand-chosen.** Reproducing his route needs either his seed set (which we
  have, in `tools/degrey.py`) or a search that finds an equally good one — and the second is a much
  harder problem than the first. Re-finding χ ≥ 5 *given his seeds* is a weaker claim than finding it
  from nothing, and the milestone must say which it achieved.
* **Symmetry carries no colouring information.** A rotationally symmetric unit-distance graph need
  not be hard to colour — rotate any graph 180° about a distant point and take the union. Symmetry can
  **promote** a candidate and can never **reject** one. The orbit primitive makes this mistake easier
  to make, which is why it is written down here.
* **Refutation cost is not monotone in graph size** (M07), and at five colours instances of the same
  size varied by two orders of magnitude (M12). "Smaller" is not "cheaper".
