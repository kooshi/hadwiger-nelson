# M14 — Seed optimization: **the fan**

*Subplanned 2026-08-01, immediately after M13 landed a negative result. The carry-forward evidence
M13 left is § 1; everything from § 0 on was measured during this subplanning session and it changes
the milestone's shape.*

> **M13 searched for a pair of points forced to share a colour, and found none anywhere.
> de Grey's own construction does not contain one either — until its very last step.
> What it contains is a *fan*: a point `p` and a handful of points `Q` such that every proper
> 4-colouring paints `p` the same colour as *at least one* member of `Q`.**
>
> **That is the seed property. It is graded, it is cheap to test, and it discriminates de Grey's
> seed from everything M13 reached — perfectly, in under a second per candidate.**

---

## 0. Measurements — taken before anything was specified

Desktop (32 cores, 125 GB), 2026-08-01. `cadical` from the toolchain; wall clock, single runs
unless stated, because the discriminating results differ by three orders of magnitude and the
ranking is not in doubt.

### (a) The seed is not the object with the property. Its orbit is.

| | points | unit edges | avg degree |
|---|---|---|---|
| de Grey's seed `S` | 39 | **18** | 0.92 |
| `orbit(S, hex₁₂)` | **397** | **1974** | 9.94 |
| `spindle(orbit(S), (0,0), (2,0))` | 793 | 3954 | 9.97 |

The 39 seed points are almost edgeless. Nothing is forced in them, and — measured below — they do
not even carry a disjunctive property. **They are a fundamental domain**: 39 × 12 = 468 images
under the order-12 hexagonal group, colliding to 397 on the symmetry axes.

**Consequence for the search.** "Choose 39 seed points" is the wrong frame. de Grey chose a
*symmetric 397-point configuration*; the 39 points are its quotient, and the compression ratio is
10×. A search over seeds is a search over symmetric configurations, and the symmetry is the only
reason a 400-point object can be named in 39 points.

### (b) The property: a **fan** — measured at the origin of `orbit(S, hex₁₂)`

Every rational distance class from the origin was tested. "Fan" means: no proper 4-colouring gives
the origin a colour different from *all* the listed partners.

| `r²` from the origin | partners | spindle-able | every 4-colouring agrees with one? |
|---|---|---|---|
| 1/9 | 6 | no | no |
| 1/3 | 18 | yes | no |
| 5/9 | 12 | yes | no |
| 4/3 | 18 | no | no |
| 5/3 | 24 | no | no |
| 3 | 6 | yes | no |
| **4** | **6** | **yes** (radicand 15 = 3·5) | **YES — this is the fan** |

> **In de Grey's 397-point configuration, every proper 4-colouring paints the origin the same
> colour as at least one of *three* points at distance 2 from it.**

Exactly one distance class carries it, and it is a spindle-able one. Cost to find: 10.1 s for the
deciding call, 0.4 s for each of the six refutations.

Six partners is the distance class; **three of them suffice**, and the certifying shrink (drop one,
re-decide, keep the drop only if it still holds) earns that number in 57 s. The same width 3 appears
at pivot #2 — so it is the configuration's width, not one pivot's accident.

### (c) The property discriminates — perfectly, and 85× cheaper than M13's oracle

The narrowest single-distance-class fan, over pivots and over every spindle-able class:

| configuration | points | edges | narrowest fan | time |
|---|---|---|---|---|
| M13 universe | 7 | 12 | **none at any pivot or class** | 0.0 s |
| M13 universe | 13 | 24 | **none** | 0.1 s |
| M13 universe | 19 | 42 | **none** | 0.2 s |
| M13 universe | 43 | 108 | **none** | 0.6 s |
| `orbit(S, hex₁₂)` | 397 | 1974 | **width 3**, pivot #2, `r² = 4` | 29 s |

**Nothing M13 searched has a fan at all.** Not a narrow one — none, at any pivot, at any
spindle-able distance. They are not "close to forcing and short of it"; they are infinitely far
away, and the fan test says so in 0.6 s where M13's forced-pair sweep spent **51 s per universe** to
report a bare "nothing".

### (d) M13's oracle tested for fan width **one**, and could not have seen de Grey's construction

`backbone(p)` returns `{q : every 4-colouring gives c(p) = c(q)}` — the width-1 case. Measured: the
7-point hexagonal patch that opens de Grey's argument has **no width-1 fan at any of its 7 pivots**,
and neither does `orbit(S, hex₁₂)` at the origin until after the spindle. So the instrument was not
merely unlucky on the space it walked; **it was blind to the property de Grey's own building block
has.** The generalisation from "one partner" to "a few partners" is the milestone.

### (e) A graded objective *does* exist — M13's stub said it did not, and that was wrong

M13's stub recorded "there is no graded objective … every configuration short of the answer scores
zero". Two objectives were measured this session, and both are real-valued and monotone:

* **Free hitting number** — the fewest pairs `L` (not sharing a pivot) such that every 4-colouring
  makes one of them monochromatic. Computed exactly by implicit hitting set: an outer exact
  minimum-hitting-set over sampled colourings, an inner SAT call per round.

  | configuration | points | minimum |
  |---|---|---|
  | rhombus | 4 | none exists |
  | hexagonal patch | 7 | **3** |
  | M13 universe | 13 | 3 |
  | M13 universe | 19 | 3 |
  | M13 universe | 43 | 3 |

  Finite, exact, 0.1–0.6 s — **and flat at 3 across the entire reachable space**, so it grades
  without guiding. Recorded because it is cheap and because "the objective is flat here" is itself
  the result.

* **Fan width** — § (c). Discriminates. This is the one to search on.

**A greedy hitting set is not the minimum and must not be reported as one.** Greedy plus a
one-at-a-time shrink returns an *irreducible* set, and it returned 3 for the 793-point configuration
that is *known* to force a pair — where the true minimum is 1. The implicit-hitting-set loop above
is the exact computation; the greedy number is a bound and will be labelled as one.

### (f) The field is *derived* from the fan's distance, not chosen

`field.py` already records that ℚ(√3,√5,√7,√11) holds the spindle radicals of `r² = 1, 3/2, 2, 3`.
The stronger statement the fan supplies:

| where it comes from | `r²` | radicand `4r²−1` | contributes |
|---|---|---|---|
| the unit triangular lattice | — | — | √3 |
| the fan's own distance | 4 | 15 = 3·5 | **√5** |
| the distance the patch also admits | 3 | 11 | **√11** |
| de Grey's closing spindle | 16 | 63 = 9·7 | **√7** |

So all four square roots are accounted for by the lattice plus three spindle distances, two of which
are exactly the distances the hexagonal patch can be monochromatic at. **The field is not a modelling
choice; it is what the fan forces.** A search that changes the fan's distance changes the field, and
`field.py`'s `missing_root` already names the cost.

### (g) The fractional route is measured dead as a gradient — do not re-propose it

M10 § 0(a): every 5-chromatic witness in this repository is *worse* for the fractional chromatic
number than the 7-vertex Moser spindle, because big-and-sparse is good for χ and bad for the
independence ratio. Independence ratio and χ are different objectives, and this was settled with
numbers a milestone ago.

### (i) The smallest genuine fan — the non-vacuity witness

Every theorem about fans quantifies over fans, so a fan of width above one has to *exist* or the
module is `Forces` in costume. Exhaustive search over all graphs on up to 8 vertices:

| colours | smallest graph with a genuine width-2 fan | pivot | partners |
|---|---|---|---|
| 3 | **4 vertices, 4 edges** — a triangle `0,1,2` with `3` pendant on `0` | 3 | 1, 2 |
| 4 | 5 vertices, 8 edges | 4 | 2, 3 |

"Genuine" means no proper subset of the partners is itself a fan, and the two witnessing colourings
are exhibited. **The three-colour case is the calibration instance**: the triangle uses all three
colours, so the pendant point — barred only from its neighbour's colour — must take one of the other
two. It is a realizable unit-distance graph, it exhausts in `3⁴ = 81` cases, and no solver is
involved anywhere.

### (j) The closing move does **not** generalise past width one — except in one geometry

`not_colorable_of_spindled_fan` needs every partner of one copy adjacent to every partner of the
other. In the plane:

* **Width ≥ 3 is impossible.** Two unit circles meet in at most two points, so three partners would
  have to lie inside a two-point set.
* **Width 2 survives in exactly one configuration**, derived rather than searched: the two partners
  diametrically opposite the pivot at distance `1/√2`, closed by a quarter turn. All four cross
  distances are exactly 1, verified; `r² = 1/2` and the spindle radicand is `4r²−1 = 1`, so it is
  rational and available in any field.

So narrowing really is the work, and the search's win condition widens by exactly one case rather
than becoming a scale.

### (k) Spindling does **not** narrow the fan at its own pivot

Measured on de Grey's own step. `orbit(S, hex₁₂)` has width 3 at the origin; `spindle(orbit, (0,0),
(2,0))` — his next move, at the fan's own distance — still has width 3 at the origin (187 s to
re-shrink), and the narrowest fan over the first 12 pivots is width 3 at `r² = 4` both before and
after (29 s, then 440 s).

**The width-1 fan the spindle creates appears at a *different* pivot**: `(−2,0)`, paired with
`(2,0)` at `r² = 16`, which is the pair de Grey closes on. So the descent is not "the fan at `p`
narrows"; it is "a narrower fan appears elsewhere", and a search must re-scan pivots after every
move rather than tracking one. Recorded because the opposite is the natural assumption and it is
wrong.

### (h) The oracle agrees with the kernel — five controls, watched

The fan oracle is cross-checked against the one fan this repository has already proved
(`rhombus_forces`, by `decide +kernel`, no solver involved) and against its committed 4-colour
countermodel.

| control | wanted | got |
|---|---|---|
| rhombus, 3 colours, far pair | fan | fan |
| rhombus, **4** colours, far pair | no | no |
| rhombus, 3 colours, an adjacent partner | no | no |
| rhombus, 3 colours, empty fan | no (it *is* 3-colourable) | no |
| rhombus, **2** colours, empty fan | fan (not 2-colourable) | fan |

Two miswritten controls were caught by this table before any of it was believed: one asked about an
edge rather than the far pair (the tool and Lean number the rhombus differently), and one passed the
same colour count on both rows so the 4-colour case was never actually run. **Both looked like tool
bugs and were script bugs** — which is the argument for running the negative control rather than
asserting it.

---

## 1. What M13 left (carried forward unchanged)

M13's search: 33 universes, 7 to 679 points, 51 s each, **0 forced pairs, 0 pivots unsettled** —
real negatives, not timeouts. Branching factor **378** spindle moves from one 43-point
configuration, so depth 2 is 84 CPU-days and depth 3 about 87 CPU-years. All 39 of de Grey's seed
points are irredundant (39/39, 46 s). **A 256-core request was considered and declined on this
evidence**, and § 0(c) is why that was right: the missing thing was never compute.

de Grey's construction is exactly four primitive moves, verified by exact point-set equality:
`spindle(delete₂(spindle(orbit(S, hex₁₂), (0,0), (2,0))), (−2,0), (2,0))`. Note the third argument:
**his first spindle is at `r² = 4`, which is the fan's distance measured in § 0(b).** The
construction and the property agree, and nothing here had to assume that.

---

## 2. The shape — Lean

`Proofs/HadwigerNelson/Forcer.lean` states `Forces G k p q := ∀ C : G.Coloring (Fin k), C p = C q`.
The generalisation is one list:

```lean
/-- Every proper `k`-colouring makes at least one listed pair monochromatic. -/
def ForcesSome (G : SimpleGraph V) (k : ℕ) (L : List (V × V)) : Prop :=
  ∀ C : G.Coloring (Fin k), ∃ e ∈ L, C e.1 = C e.2
```

Two boundary readings, and both are the point:

* `ForcesSome G k [(p, q)] ↔ Forces G k p q` — M13's whole module is the singleton rung.
* `ForcesSome G k [] ↔ ¬ G.Colorable k` — the empty list *is* the theorem, with no spindle needed.

So `|L|` is a descent measure from a finite start to zero, and every rung between is a statement
this repository could not previously write down. The ladder to state:

| statement | what it is |
|---|---|
| `ForcesSome.of_unsat` | the producer — a SAT certificate, as `Forces.of_unsat` already is |
| `ForcesSome.narrow` | drop a pair no colouring can make monochromatic — **the descent step** |
| `ForcesSome.mono`, `.comap`, `.map` | more edges, placements, symmetries — as at M13 |
| `not_colorable_of_forcesSome_nil` | `|L| = 0` closes with no spindle |
| `Forces.of_forcesSome_singleton` | `|L| = 1` hands back to `not_colorable_of_spindled_forcer` |

The **fan** is the shape the search actually computes, and it is `ForcesSome` with a shared pivot:

```lean
/-- Every proper `k`-colouring paints `p` like some member of `Q`. -/
def Fan (G : SimpleGraph V) (k : ℕ) (p : V) (Q : List V) : Prop :=
  ForcesSome G k (Q.map (fun q => (p, q)))
```

## 3.0 The domain pass — what it changed

Run against the skeleton at commit 7370444. Five findings, each of which moved a declaration.

**`Fan` is the primitive; `ForcesSome` is deleted.** The free list-of-pairs version had two pretty
boundary readings, and `Fan` has both of them anyway. What settled it is an asymmetry in the
*encoding*, and it is intrinsic rather than a convenience: because every pair shares the pivot,
colour names being arbitrary means the refutation is **a cube** — pin the pivot to colour `0`, then
one unit clause per partner. Without a shared pivot it is `k` binary clauses per pair, a different
and larger encoding, for a property § 0(e) measured to be *flat*. So the generality had no consumer
and one real cost, and deleting it is subtraction.

**The dual gets a name, and the name already existed.** `Fan.narrow`'s hypothesis is
`∀ C, C p ≠ C q`, which is exactly what `tools/forcer.py` calls `SEPARATED` — a concept the tool has
had a word for since M13 while Lean had none. It is now `Separated`, with `Separated.of_adj` free,
which is the case the search meets constantly.

**There is no induction, and that is the finding.** The skeleton had a ladder — narrow by one,
recurse on `Q.length`. The theorem the ladder was climbing toward turns out to need no recursion at
all:

```lean
theorem not_colorable_of_fan (h : Fan G k p Q) (hs : ∀ q ∈ Q, Separated G k p q) : ¬ G.Colorable k
```

Two quantifiers meeting: the fan says some partner agrees, separation says none does. Both ends of
the ladder are instances (`Q = []` makes the second hypothesis vacuous; `Q = [q]` is M13's forced
pair). **Width is a measure on the search, not on any proof**, and `Fan.narrow` survives only as
bookkeeping so a reader can find each line of the search's log as a theorem.

**`List`, and no nodup condition.** `Finset` would drag `[DecidableEq V]` into every statement and
break `Fan.map`, which wants `List.map` and would need `Finset.image`. Only membership is ever
observed, so a repeated partner is harmless; `Fan.widen` applied both ways *is* the statement that
only members matter, so the set-ness is a theorem rather than a carrier.

**The distances stay out of the types.** Every transport lemma would carry an index none of them
inspects, and the Lean side of this repository holds no geometry — that lives in `UDCert`/`Assembly`.
The constraint is demanded where it bites anyway: the closing lemma needs an adjacency, and an
adjacency is exactly where the geometry has to be true. **The theorem asks for it in the one place it
is load-bearing**, which is the placement cut deciding itself.

**The adversarial member is admitted on purpose.** `Fan G k p [p]` holds for every graph and says
nothing, so the type is weaker than the intent. Narrowing `q ≠ p` into the type taxes every statement
for a case that cannot do harm: `not_colorable_of_fan` demands `Separated G k p p`, which is false
whenever a colouring exists. The type is weaker than the intent; the theorem is not. It is pinned as
a spec example so the weakness is recorded rather than discovered.

**The skeleton is `Proofs/HadwigerNelson/Fan.lean`** — every signature and full statement, `sorry`
at 19 leaves after the domain pass, elaborating clean. It carries nine specification examples: the
width-2 non-vacuity witness of § 0(i), the two colourings proving its width is really two, and five
countermodels (a fan over the pivot itself, an empty fan on a graph that *is* 3-colourable, the same
fan at four colours, the rhombus at width one, and a non-vacuous `Separated`). A definition that
drifted toward something vacuous would pass every positive and fail every negative.

## 3. The shape — tools

`tools/forcer.py` gains the fan, and `forces` becomes its width-1 special case:

* `fan(n, edges, p, Q, k, timeout)` → `FAN` / `SEPARATED` / `UNKNOWN`, three outcomes, the third
  never folded — the existing rule.
* `narrowest_fan(cfg, k, pivots, timeout)` → `(pivot, r², width)` or `None`, searching one distance
  class at a time and keeping the narrowest. This is the seed-quality score of § 0(c).
* `shrink_fan` — certifying, one partner at a time, so "width" is earned rather than reported.
* **The separating colouring stops being discarded.** `forces()` currently returns `separated`
  without the colouring; the fan loop needs it, and returning it is the change the M13 stub already
  identified as the cheapest one available.

## 4. Scope

**In.** The ladder in Lean (§ 2), with M13's theorem re-derived as its `|L| = 1` rung. The fan
oracle and its controls in the tool (§ 3). de Grey's fan — § 0(b) — as a *certified* Lean statement
if the certificate is affordable at 397 points and 4 colours; the cost model puts a 553-point
4-colour certificate at 37.4 CPU s of solving and ≈40 min of kernel time, so this is expected to be
affordable and will be measured before it is promised.

**Out.** χ ≥ 6 — that is M15. Finding a *new* seed is attempted with the fan score and reported
honestly either way; the milestone does not depend on it succeeding.

## 5. Honest risks

* **A fan may not narrow under any move we have.** § 0 establishes the property and the score; it
  does not establish that the score *descends* under orbit/spindle/union. The descent is being
  measured on de Grey's own two-step construction as this is written, and if it does not descend
  there, the score ranks candidates without generating them — still worth having, and reported as
  that.
* **The fan test is one SAT call per distance class per pivot.** Cheap at 43 points (0.6 s for the
  whole sweep), 29 s at 397, and it will not stay cheap. Orbit symmetry cuts pivots by up to 12× and
  is not yet exploited; `Forces.map` is the theorem that licenses it.
* **Width 3 is not width 1.** de Grey needed a further spindle *and* his hand-chosen 39 points to
  close the gap. Nothing measured here says the last step is easy.
* **Refutation cost is not monotone in graph size** (M07), and at five colours instances of the same
  size varied by two orders of magnitude (M12). Carried forward; still true.
* **Symmetry carries no colouring information.** A symmetric unit-distance graph need not be hard to
  colour; symmetry can promote a candidate and can never reject one. Carried forward.
