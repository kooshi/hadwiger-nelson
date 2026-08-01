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

## 3.0.1 The obligation pass — what it changed

**The producer needed no new encoding, and finding that saved 28 hours.** The skeleton encoded a fan
directly: pin the pivot to colour `0`, then one *negative* unit clause per partner (`avoidCNF`). The
assignment bridge that would justify those clauses (`ofColoring`, `colorFn`) is private to
`Sat/Encoding.lean`, so the lemma had to live there — and **1,432 of this repository's 1,494 modules
depend on that file**, 1,406 of them generated certificate modules. A new declaration there is
exactly the rebuild M07 paid 28 hours for.

The statement that avoids it:

> **A fan is a colourability question about a bigger graph.** Join the pivot to every partner; a
> proper colouring of the join is precisely a proper colouring of the original that separates the
> pivot from all of them. So "no colouring separates them" *is* "the join has no colouring".

`Fan.of_unsat` becomes one line over `not_colorable_of_unsat`, which M03 already shipped. `avoidCNF`
is deleted. Proved in a probe before it was written down.

**The converse is a separate statement and it is load-bearing.** `fan_iff_not_colorable` needs
`p ∉ Q` — a pivot listed among its own partners makes the fan trivially true while adding no edge to
the join — and without the converse a search reporting "not a fan" would be reporting on a different
question than the theorems consume.

**The colour-symmetry lemma was found and then made unnecessary.** Mathlib has
`SimpleGraph.recolorOfEquiv` (in `Coloring/Vertex.lean` — `Coloring.lean` itself was deprecated on
2026-04-02 and is now a re-export, which is why this was grepped rather than recalled). The
reduction above needs no permutation argument at all, so the better outcome was not using it.

**Decidability, measured on all nine spec examples.** Positives close by `Fan.of_edges` and
`decide +kernel` at `3⁴ = 81` and `4⁴ = 256` cases. Negatives need explicit countermodels, because
`edgeGraph` deliberately has no `DecidableRel .Adj`: validity discharges by
`simp only [edgeGraph_adj]; decide`, and the contradiction by
`simp only [SimpleGraph.Coloring.mk]` then `decide` — both patterns M13 already established.

### The mutation audit, run rather than planned

| perturbation | wanted | got |
|---|---|---|
| `Fan` with the quantifiers swapped (`∃ q ∈ Q, ∀ C` instead of `∀ C, ∃ q ∈ Q`) | provably **false** on an instance where the real definition holds | **false**, refuted by the two colourings that make the width honest |
| `hpiv` dropped from the closing lemma | proof breaks | breaks — the missing step *is* `hpiv` |

The first is the sharpest control in the milestone and it is now a permanent example in the module.
The swapped version is strictly stronger — it says a specific partner is forced — **and it is what
M13's oracle tested for.** So the negative result M13 reported is not merely a search that came up
empty; it is a search for a property that fails on de Grey's own building block, and one line in
this file now says so in a form the kernel checks.

### PROVE / TEST / ASSUME

* **Prove** — the ladder, the three producers, and `fan_iff_not_colorable`. All in Lean, all
  kernel-checked, axioms audited.
* **Test** — the nine specification examples (five of them countermodels), the quantifier-order
  control, and the tool's control table.
* **Assume** — nothing new. The geometry is `UDCert`'s as before, and `cadical` stays untrusted
  because its certificate is re-checked.

### What the tool is allowed to claim

Three obligations, each written because the opposite has shipped here before:

* **`shrink_fan` earns "irredundant", never "minimum".** It may claim: the kept set is a fan, and
  for every member, dropping it is verified *not* a fan. It may **not** claim minimality — § 0(e)
  measured a greedy-plus-single-drop result of 3 on a configuration whose true minimum is 1. Any
  "narrowest" claim has to come from the implicit-hitting-set loop, and is labelled with which one
  produced it.
* **`UNKNOWN` never folds into either answer.** A timeout while testing a drop must not be read as
  "still a fan" (the width would be reported too small, and the claim would be *false*) nor silently
  as "not a fan" (too large, merely wrong). `shrink_fan` returns the unsettled list alongside the
  kept set, and the printed line states the unsettled count whether or not it is zero — M13's
  `report_universe` pattern.
* **Controls are a data table, not repeated code, over one shared graph.** Two of this session's
  own controls were miswritten and both read as tool bugs: one indexed the rhombus by hand and hit
  an edge rather than the far pair (the tool and Lean number it differently), and one repeated the
  same colour count on two rows so the four-colour case never ran. Both classes disappear when each
  control is a `(graph, pivot, partners, colours, expected)` row consumed by one runner, and the
  graph comes from a single source rather than a second transcription.

### The measure, stated honestly

There is **no monotone per-pivot quantity** — § 0(k) measured the fan at de Grey's own pivot staying
at width 3 across the spindle that creates his forced pair elsewhere. What *is* monotone is global:
`Fan.mono` says adding edges preserves a fan, so `min over all pivots and partner sets of the width`
is non-increasing under every growth move. That buys safety — no growth move can destroy progress —
and it does **not** buy guidance, because the minimum is measured flat at 3 across everything M13
reached. Evaluating it costs a full pivot sweep, and this plan states that there is no cheaper
proxy rather than implying one.

## 3.0.2 The experience pass — what it changed

**Exactly one `@[simp]`, and its normal form is stated.** `fan_singleton_iff` rewrites
`Fan G k p [q]` to `Forces G k p q` — the shorter side, the older vocabulary, and the shape M13's
closing lemma already consumes, so a search that has narrowed to one partner lands where the next
move accepts it. It cannot loop (the left side carries a list literal the right side does not).
Nothing else in the module is tagged: the transport lemmas are implications, not equations, and an
untagged implication costs no heartbeats forever.

**A "which one to reach for" table in the module docstring.** Thirteen declarations is past the four
a reader holds, and three of them are producers differing only by *cost* — exhaustion, certificate,
any refutation. The table is the progressive-disclosure handle; without it a caller has to read
three docstrings to learn which is cheap.

**`Fan.of_unsat` deliberately collides with `Forces.of_unsat`.** They use different encodings — M13
pins two ports through the gadget algebra, M14 joins edges and calls `not_colorable_of_unsat` — and
that is exactly why the names should match: `of_<source>` is the convention, the source is the same
(a refutation), and the encoding is the implementation detail a caller must never need. A user who
learned one predicts the other correctly, which is what a naming convention is for.

**Prose in this module is free — for now, and the expiry is worth writing down.** `Fan.lean` has
**0 dependents** and `Forcer.lean` has 3, so a docstring costs one file's re-elaboration today. The
moment a generated certificate imports `Fan.lean` — which is what certifying de Grey's 397-point fan
would do — every docstring in it becomes a rebuild of everything beneath. At that point the prose
moves downstream to `FanDiagnose.lean`, exactly as `Sat/Diagnose.lean` holds what `Sat/Mask.lean`
cannot afford.

### The four failures, and which side can say each

| the user hits | who can say it | what it owes |
|---|---|---|
| no fan at any pivot | **only the tool** — Lean certifies positives, never a search's exhaustiveness | the pivot and class counts swept, *and* that every one was settled |
| a fan at a distance the field cannot spindle | **only the tool** — this module holds no geometry by design | the width, the distance, and **the square root that would be needed** (`field.py`'s `missing_root`) |
| the oracle timed out mid-sweep | **only the tool** | the unsettled count, and a refusal to print a width at all |
| a fan of width ≥ 3 | tool immediately; the reason lives in `not_colorable_of_spindled_fan`'s docstring | that it is **not closable by any spindle** — and that the move is to *narrow*, not to abandon |

The last one matters most and is the easiest to get wrong: width ≥ 3 is unclosable but it is **not
worthless** — it is de Grey's own position. The message says "narrow it", never "no".

### The report line

M13's search printed forced pairs, found none, and so printed nothing. M14 prints a width, and a
width is a lie unless it carries its provenance and its unsettled count:

```
397 pts  1974 edges  k=4   fan width 3  [irredundant, 0 unsettled]  pivot 0, r²=4 spindle-able
                                        -> width >= 3 cannot be closed by a spindle; narrow it
 43 pts   108 edges  k=4   NO FAN  (43 pivots x 6 spindle-able classes, all settled, 0.6 s)
 43 pts   108 edges  k=4   width <= 4  ** UNSETTLED: 3 drops timed out -- this is not a width **
```

Three rules the line encodes, each because the opposite has shipped here: the provenance tag is
mandatory (`irredundant` from a certifying sweep, `minimum` only from the implicit-hitting-set
loop); the unsettled count is printed **whether or not it is zero**; and an unsettled sweep prints
`width <=` and a warning rather than a number that reads as a measurement.

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

## 9. What landed

**`Proofs/HadwigerNelson/Fan.lean`** — 19 declarations, zero `sorry`, builds in 1.4 s, axioms
exactly the standard three. `Fan`, `Separated`, the ladder, three producers, the closing lemma, and
**nine** specification examples of which **five are countermodels** — the width-2 witness with each
partner alone refuted, the empty fan, the four-colour case, and the quantifier-order mutation.

**`tools/forcer.py`** — `fan`, `fanEdges`, `Fanned`, `shrink_fan`, `best_fan`. The tool builds the
**same joined edge list** Lean's `fanEdges` builds and asks the same question of it, so the two
agree by construction rather than by a second transcription. `forces` and `fan` are cross-checked
against each other at width one, at three and four colours — two different formulas for one
question, which is the cheapest independent check available here.

**Reproduced through the shipped tool**, not the prototype:

```
M13 universe       7 pts    12 edges  k=4  NO FAN at any pivot or spindle-able class   0.0 s
M13 universe      13 pts    24 edges  k=4  NO FAN                                      0.1 s
M13 universe      19 pts    42 edges  k=4  NO FAN                                      0.1 s
M13 universe      43 pts   108 edges  k=4  NO FAN                                      0.2 s
de Grey orbit    397 pts  1974 edges  k=4  width 3 at pivot 0 [irredundant, 0 unsettled,
                                           7 calls] -> width >= 3 cannot be closed by a
                                           spindle; narrow it                         72.7 s
```

### The gate

| check | result |
|---|---|
| `lake build` | green, 4,640 jobs, under a memory cap |
| `sorry` | none (the one grep hit is the word inside a docstring in `Packed.lean`) |
| `#print axioms` | **147 clean**, 5 declared purchases — up from M13's 130, every new declaration on the standard three |
| `lake lint` | silent |
| spec examples | 9, five of them countermodels, all passing |
| `regen-check` | **OK** — both Heule certificates reproduced bit for bit, de Grey's 1581 points rebuilt exactly from 39 seeds, **80 tool controls** across seven tools (`forcer.py` alone went 14 → 33) |

### The negative controls, watched failing

Seven, each broken on purpose and then restored:

| broken | went red with |
|---|---|
| `fan` reports `separated` as `fan` | the width-2 witness's second row |
| `fanEdges` forgets to join the partners | the width-2 witness itself |
| `shrink_fan` claims irredundance without the sweep | the certified-width control |
| an unsettled *drop* folded into a refusal | the injected-oracle control |
| `width` printed despite an unsettled sweep | the starved-shrink control |
| the width-2 Lean witness narrowed to width 1 | `decide` proved the proposition false |
| `p ∉ Q` dropped from `fan_iff_not_colorable` | unknown identifier `hp` |
| `fanEdges` (Lean) forgets the join | application type mismatch |

**And the axiom audit was seen failing for real, not on purpose.** Before `Proofs.lean` was rebuilt
with the new import, `scripts/Axioms.lean` could not resolve `Fan`, and `axioms.sh` printed
`FAIL — scripts/Axioms.lean did not elaborate` rather than passing quietly. That is the M04 repair
holding: the check that used to fail open now fails loud.

**A fourth miswritten control, caught by its own negative control.** The sweep that records an
unsettled *drop* was unreachable from outside — any timeout small enough to trigger it also starves
the guard call — so deleting the branch left the self-test green. That is a check that could not
fail, and it is now driven through an injected oracle. Three of this session's controls were
miswritten before this one; the pattern is that **a control is only known to work once it has been
watched failing**, and the ones that had not been were exactly the ones that were wrong.

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
