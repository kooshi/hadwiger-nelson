# M12 — Candidate construction

*Subplanned 2026-08-01. Supersedes the carry-forward stub opened the same day; every number the stub
carried is preserved in § 7, and the five items it listed are re-scoped in § 2 against what § 0
measured.*

**The hunt is M13.** This milestone was split out of it so that everything we can name in advance is
built in advance, and whatever gets built *during* the hunt is genuinely novel by construction.

---

## 0. The measurements, first — they overturned two of the stub's five items

The stub's item 1 was a measurement and said it goes first. It did. All figures on the **desktop
(32 cores, 125 GB)**, CaDiCaL as shipped with the toolchain.

The unit throughout is the **trimmed hint entry** — the same quantity M06 and M07 recorded as
"propagation steps", confirmed by reading `tools/emit_mask.py`: it backward-trims the certificate and
counts `sum(len(hn[i]) for i in order)`, then projects kernel time as `entries × 1.35 ms`. So the
numbers below are directly comparable to de Grey's 34,169,571 and Heule's 1,104,106.

### 0(a) One more colour costs one to two orders of magnitude — measured three ways

**The same graph, only the colour count changed.** The 47-vertex, 236-edge Mycielskian of the
Grötzsch graph, which is exactly 6-chromatic:

| colours | verdict | CPU s | LRAT actions | certificate | trimmed hint entries |
|---|---|---|---|---|---|
| 3 | not colourable | 0.00 | 130 | 0.00 MB | — |
| 4 | not colourable | 0.02 | 2,240 | 0.27 MB | 45,001 |
| **5** | **not colourable** | **6.15** | **511,918** | **91 MB** | **10,224,710** |
| 6 | colourable | 0.00 | — | — | — |

**227× the kernel work with the graph held fixed.** That comparison conflates two things — one more
colour, and the fact that at five this graph is *critical* while at four it has slack — so two more
controls:

**Matched criticality, matched size.** Random graphs on 40 vertices, density raised until the first
instance that is *just* not `k`-colourable:

| colours | LRAT actions, three seeds |
|---|---|
| 4 | 219 – 500 |
| 5 | 1,608 |
| 6 | 9,923 – 119,280 |

Roughly **10–20× per colour** at fixed size and fixed criticality.

**The ladder.** Each Mycielskian is exactly one more chromatic than the last, and the solver confirms
it rather than the construction being taken on faith — every rung was checked UNSAT at `χ−1` and SAT
at `χ`, which is this measurement's own control.

### 0(b) The levers: one survives and is stronger, one vanishes

M07 found two levers on four-colour refutations. **Neither was known at five, and reporting an
un-optimised number as "the cost" would have been wrong.**

**Colour-naming survives and is worth more.** Pinning a clique's colours is sound at any `k` — colour
names are arbitrary, so a `k`-colouring exists iff one exists giving a fixed clique colours 0,1,2,…
Measured at five colours on four triangle-rich critical instances:

| instance | plain | pin an edge | **pin a triangle** | pin a K₄ |
|---|---|---|---|---|
| n=40 | 386,078 | 27,221 (14×) | **11,906 (32×)** | 8,646 (45×) |
| n=60 | 218,427 | 60,250 (3.6×) | **25,813 (8.5×)** | 15,133 (14×) |
| n=70 | 4,572,050 | 268,854 (17×) | **87,069 (53×)** | 63,700 (72×) |
| n=80 | 1,596,158 | 157,757 (10×) | **64,454 (25×)** | 38,996 (41×) |

**The triangle column is the one that matters and the K₄ column is unreachable**: a unit-distance
graph in the plane has no K₄, because four points cannot be pairwise at distance 1. The triangle is
the largest clique the geometry permits, and it is worth **8.5–53×, median ~25×**, against M07's 20×
at four colours.

**The configuration race does not reproduce.** M07 measured racing CaDiCaL configurations and seeds
on trimmed hint count at **10.5×**. At gadget scale, on the 47-vertex instance, eight configurations:

| | best | worst | **speed-up** |
|---|---|---|---|
| hint entries | 10,224,710 | 13,797,062 | **1.00×** |

The default configuration was already the best. **The race is a de-Grey-scale lever, not a general
one** — recorded because using it at gadget scale would spend eight cores for nothing.

**Net.** The 47-vertex 6-chromatic graph, refuted at five colours with one edge pinned, is
**387,065 hint entries** — about **a third of the 553-vertex four-colour witness** that took ~30
minutes and 100 modules. **A five-colour refutation at gadget scale is affordable.**

### 0(c) Rejecting a candidate is free — the best news here

The search's inner loop is not "prove this graph needs six colours", it is "does this candidate have
a 5-colouring?", answered *yes* almost every time. Measured:

| graph | vertices | refute at 4 colours | **find a 5-colouring** |
|---|---|---|---|
| Moser spindle | 7 | (colourable) | 0.00 s |
| core-and-spindle | 63 | (colourable) | 0.00 s |
| Heule | 510 | 61.0 CPU s | **0.01 CPU s** |
| Heule | 553 | 37.4 CPU s | **0.02 CPU s** |
| de Grey | 1581 | 27.8 h (M06) | *see § 0(f)* |

**Rejecting is three to four thousand times cheaper than certifying**, and it stays cheap at 553
vertices. A search can afford to look at very many candidates; what it cannot afford is to certify
them. That asymmetry is the search's whole economics and it is now measured rather than assumed.

### 0(d) The profiler is free

A subgraph's *whole* port property at five colours, on the 63-vertex core-and-spindle, 32 jobs:

| ports | patterns at 5 colours | wall |
|---|---|---|
| 3 | 5 | 0.01 s |
| 5 | 52 | 0.03 s |
| 6 | 202 | 0.07 s |
| 7 | 855 | **0.19 s** |

Building a catalogue costs nothing. **Finding something to put in it is the problem — see next.**

### 0(e) Nothing this project owns forces anything at five colours

**This is the finding that re-scoped the milestone**, and it is the five-colour extension of the
stub's four-colour observation. Two independent probes, both negative:

* **Random non-adjacent port sets.** Forty-eight port sets of three and four vertices, drawn pairwise
  non-adjacent so that no refutation could be explained by an edge, across the core-and-spindle
  (63 vertices), both Heule graphs (510, 553) and de Grey's (1581). **Zero forced anything.**
* **Every distance class, exactly.** For each distinct exact squared distance in a graph — computed
  in `ℚ(√3,√5,√7,√11)`, so a class is a fact and not a float tolerance — take a pair at that distance
  as ports and ask whether "the two ends agree" or "the two ends differ" is impossible at five
  colours:

  | graph | distance classes | classes forcing anything at 5 colours |
  |---|---|---|
  | Moser spindle, 7 points | 7 | **1 — and it is the edge** |
  | core-and-spindle, 63 points | 161 | **1 — the edge** |
  | Heule, 510 points | 6,943 | **1 — the edge** |
  | Heule, 553 points | 9,546 | **1 — the edge** |

  The unit distance forces "the two ends differ", which is what an edge is. **Nothing else in any of
  these graphs constrains a pair of points at five colours at all.**

**The control fires.** The same probe at *four* colours on the 553-vertex graph refutes **5 of 5**
patterns, as it must — that graph has no 4-colouring at all, so every port pattern is impossible.
A probe that reported "nothing forced" everywhere would look identical to a broken one; this is the
partner that goes red.

**Why it is not an accident.** A graph comfortably `k`-colourable imposes nothing on a handful of
scattered points, and *every graph we own is comfortably 5-colourable* — de Grey's included, which is
exactly 5-chromatic. Forcing needs a graph **tight at the colour count being asked about**.

**Consequence: the catalogue cannot be harvested, only constructed.** The stub listed "the gadget
catalogue" and "the candidate generator" as two items. They are one item: constructing a five-colour
gadget and constructing a candidate are the same act, and the producer (`Gadget.ofExhaustion`,
`Gadget.ofUnsat`, `tools/profile.py`) has been ready since M11.

### 0(f) The pipeline cannot express the question yet

`tools/emit_mask.py` — the emitter that turns a solver certificate into kernel-checkable Lean —
hard-codes four colours in three places: `Cube {n} 4` at line 231, `coloringCNF 4 …` at line 365, and
the `tools/coloring.py` calls that default to `K = 4`. Everything else is already colour-generic:
`coloringCNF k n E`, `cubeCNF k n`, `Cube n k`, `Gadget k n m E p`, and the whole of
`Sat/MaskCheck.lean`. **The gap is three lines of untrusted Python, not a proof.**

### 0(g) The field is derived, not chosen — and the move set is decidable

Spindling — rotate a copy of a configuration about a shared point until a designated pair lands a
unit apart, which is how the Moser spindle, de Grey's graph and the core-and-spindle were all
built — about a pair at squared distance `r²` rotates by

```
cos θ = (2r² − 1) / (2r²),      sin θ = √(4r² − 1) / (2r²)
```

so **the spindle stays in the field exactly when `4r² − 1` is a square there**. For a rational `r²`
that is decidable in one line: the squarefree part of `4r² − 1` must divide `3·5·7·11 = 1155`.

The four square roots this project's field is built from are **exactly spindle radicals**:

| radius `r²` | `4r² − 1` | gives |
|---|---|---|
| 1 | 3 | **√3** — the unit rhombus |
| 3/2 | 5 | **√5** |
| 2 | 7 | **√7** |
| 3 | 11 | **√11** — the Moser spindle's rhombus diagonal |
| 4 | 15 | √15, and de Grey's rotation by `2·arcsin(1/4)` is `cos 7/8, sin √15/8` — this formula on the nose |

`ℚ(√3,√5,√7,√11)` is not an arbitrary choice inherited from de Grey's paper: **it is the closure of
the first few spindle operations**, and `tools/degrey.py`'s own header ("√15 from the rotation by
`2·arcsin(1/4)`") says so without noticing it.

**32 of 94 sampled radii admit a spindle in this field** — one in three. Unavailable ones name the
extension they would need: `r² = 4/3` wants √39, `r² = 7/4` wants √6, `r² = 5` wants √19. **So
"should the field grow?" has a principled trigger** rather than being a taste question, and M12 does
not need to answer it to proceed.

### 0(h) The exact field is implemented five times

`tools/degrey.py`, `tools/corespindle.py`, `tools/heule.py`, `tools/spindle.py` and `tools/scan.py`
each carry their own copy of multiplication over the 16-dimensional basis — two of them in
`Fraction`, three in cleared integers. A generator would be the sixth. That is a role unnamed, and
the fix is subtraction: one module, five importers.

---

## 1. What this milestone is

**One sentence.** Everything needed to *propose* a candidate and to *ask it the five-colour question*
— because M11 built an instrument that only ever consumes graphs, and nothing here has ever asked
about five colours.

Four deliverables, in dependency order.

### A. The five-colour question, asked and answered

The first `¬ Colorable 5` in this project, kernel-checked, with the cost recorded. § 0(f) says the
work is three lines of Python plus a regeneration.

**The witness is defined in Lean, not emitted as a literal.** The Mycielskian is a five-line
recursive definition; iterating it four times from a single edge gives a 47-vertex graph that is
exactly 6-chromatic. A reader re-derives it from the definition rather than trusting 236 emitted
pairs — which is the standard of evidence this project holds itself to above rung B, and it is
cheaper than the alternative besides. The DIMACS still comes out of Lean's own `coloringCNF` through
`scripts/Dimacs.lean`, so the certificate and the theorem cannot address different formulas.

### B. The constructor

A generator of unit-distance point sets that **stays in the exact field by construction**, with the
primitives every known construction in this area is made of:

| primitive | what it is |
|---|---|
| seed | a point, a unit edge, the unit triangle |
| **spindle** | rotate a copy about a shared point until a designated pair is a unit apart — § 0(g) says exactly when it is available |
| orbit | close a set under a list of motions |
| union / translate | place a copy anywhere the field permits |

**Its terminal test is that it rebuilds what we already have**: the Moser spindle and de Grey's seed
set, from primitives alone, matching the committed coordinates exactly. A generator that cannot
re-derive the Moser spindle is not a generator, and this is the one check that cannot pass by
accident.

### C. Assembly — many copies certified for the price of the seams

M09's largest single win was an orbit found by accident: de Grey's second 791-point copy was his
first one rotated, and *deriving* it rather than certifying it deleted 1,043 modules, 180 MB and 12.8
hours, replaced by 95 CPU seconds. **If a candidate is constructed as an orbit, that saving is true by
construction.** M11 left `UDCert.validOn_map_of_scaling` stated over a bare map and a bare scale
factor — not over a `Motion` — precisely so that this composes. What is missing is the layer above:
one certificate for `c` copies, where the intra-copy edges cost nothing and only the **cross-copy
edges** are checked.

### D. One search step, timed end to end

Propose → reject-or-profile → compose → score. Every stage is measured in § 0; the loop has never
been run. The answer decides whether M13 searches over thousands of candidates or dozens, and those
are different searches.

---

## 2. The shape

### 2.1 What changed against the stub

| stub item | after § 0 |
|---|---|
| 1. measure the five-colour cost | **done, in § 0** — and it decided the rest |
| 2. a candidate generator | **B**, and promoted to the milestone's centre |
| 3. orbit construction | **C** — unchanged, now with a consumer |
| 4. a gadget catalogue at five colours | **folded into B.** § 0(e) shows it cannot be harvested; constructing a five-colour gadget *is* constructing a candidate |
| 5. the loop, measured | **D** — unchanged |

### 2.2 Where the work lives

**Lean gains two modules and no changes to any frozen one.**

* `Proofs/HadwigerNelson/Assembly.lean` — deliverable C. New, so nothing upstream is disturbed.
* `Proofs/HadwigerNelson/Instances/Mycielski.lean` (+ a certificate directory) — deliverable A.

**`Motion.lean` is not touched.** A spindle is `Motion.rotAbout` with particular arguments, and the
arguments are what the tool computes; no new Lean constructor earns its keep, and editing
`Motion.lean` costs 118 CPU seconds of dependent rebuilds for nothing (M11 § 0(a)).

**`tools/` gains one module and loses five copies of one.**

* `tools/field.py` — the 16-dimensional exact arithmetic, once. Five importers.
* `tools/construct.py` — deliverable B.
* `tools/emit_mask.py` — the three-line colour parameter of § 0(f).

### 2.3 The assembly shape, stated

The wrinkle the stub flagged is arithmetic, and it resolves uniformly. A motion `μ` sends a point at
denominator `d` to one at `d·M`, and scales every squared distance by `scale`. So `c` copies placed
by `μ₁…μ_c` do not share a denominator — until each copy `i` is additionally scaled by `∏_{j≠i} Mⱼ`.
Then **every copy sits at the common denominator `d·∏Mⱼ` and every copy's distances scale by the same
`∏ scaleⱼ`**, which is exactly the hypothesis `UDCert.validOn_map_of_scaling` already takes:

```
hg : ∀ p p', (g p).distSq (g p') = s * p.distSq p'
hden : c'.denomSq = s * c.denomSq
```

So each copy's intra-copy edges are transported for free — no per-vertex check, no per-edge
arithmetic — and the milestone's only geometric cost is the **cross-copy edges**, which is the
irreducible part.

Two facts to carry into the modeling pass rather than decide here: whether the copy list wants to be
a `List Motion` or a single motion iterated (`Motion` is deliberately neither a monoid nor closed
under inverse — M11 § 3.5 — and the monoid instance is `Motion.ext` plus four `ring` identities *if*
a consumer appears); and whether the exponential denominator growth in the copy count costs anything,
which M08's finding that kernel bit width is irrelevant beside step count suggests it does not.

---

## 3. The skeleton

Committed to the tree with this plan, and **it builds**: `lake build` green with `autoImplicit` off,
**nine tracked leaves and no `sorry` inside any definition** — a `sorry` in a `def` is a junk value,
not an agenda item, and there are none.

### 3.1 `Instances/Mycielski.lean` — deliverable A

The construction, the graph, six size guards, an index-bound guard, and the two theorems:

```lean
def step (n : ℕ) (E : List (ℕ × ℕ)) : ℕ × List (ℕ × ℕ)      -- one Mycielskian
def iter : ℕ → ℕ × List (ℕ × ℕ)                              -- k of them above one edge
def raw : ℕ × List (ℕ × ℕ) := iter 4                         -- 47 vertices, 236 edges
def edges : List (Fin size × Fin size)

example : (iter 2).1 = 11 ∧ (iter 2).2.length = 20 := by decide +kernel   -- the Grötzsch rung
example : raw.1 = size ∧ raw.2.length = 236 := by decide +kernel
example : raw.2.all (fun e => decide (e.1 < size) && decide (e.2 < size)) = true := by decide +kernel

theorem mycielski47_not_colorable_five : ¬ (edgeGraph size edges).Colorable 5 := sorry
theorem mycielski47_colorable_six : (edgeGraph size edges).Colorable 6 := sorry
```

The ladder is pinned rung by rung (2/1, 5/5, 11/20, 23/71, 47/236) so a `step` that dropped or
duplicated an edge family goes red rather than producing a different graph that still elaborates.
The index-bound guard is what makes the `% size` in `edges` a no-op — without it a stray index would
silently fold two vertices together and the theorem would be about a graph nobody checked.

### 3.2 `Assembly.lean` — deliverable C

```lean
def Pt.scaleBy (m : Q4) (p : Pt) : Pt                        -- same point, m× the denominator
theorem Pt.distSq_scaleBy (m : Q4) (p p' : Pt) :
    (p.scaleBy m).distSq (p'.scaleBy m) = m * m * p.distSq p' := sorry

structure Assembly (n : ℕ) where
  base : UDCert n
  places : List Motion

def Assembly.factor : ℕ                                       -- ∏ scaleⱼ
def Assembly.coFactor (i : Fin A.places.length) : ℕ           -- ∏_{j≠i} scaleⱼ, by deletion
def Assembly.place (i) (p : Pt) : Pt                          -- scaleBy (coFactor i) ∘ rescale ∘ image

theorem Assembly.distSq_place (i) (p p' : Pt) :
    ((A.place i) p).distSq ((A.place i) p')
      = ((A.factor * A.factor : ℕ) : Q4) * p.distSq p' := sorry

def Assembly.idx (i) (v : Fin n) : Fin (A.places.length * n)  -- i * n + v, bound proved
def Assembly.copiedEdges : List _                             -- every copy's own edges
def Assembly.cert (cross : List _) : UDCert (A.places.length * n)

theorem Assembly.validOn_copiedEdges (cross) (hbase : A.base.Valid = true) :
    (A.cert cross).ValidOn A.copiedEdges = true := sorry
theorem Assembly.valid_of_cross (cross) (hbase) (hcross) : (A.cert cross).Valid = true := sorry
```

**`coFactor` is defined by deletion, never as `factor / scale i`.** Natural division truncates, and a
junk value there would produce a certificate at the wrong denominator that still elaborated — the
totality discipline's canonical trap, in the one place this milestone could have fallen into it.

**`cert` derives `0 < n` rather than carrying it as a field.** A vertex of the assembled graph
existing already implies it, so the structure stays free of a hypothesis every consumer would have
had to discharge.

### 3.3 The spec examples, per the gate

Every definition gets a check that would fail if it drifted, and every discriminating check gets a
partner that goes red:

* `myc47` — the size guards above, plus the solver's own ladder check (§ 0(a)) recorded in the tool's
  self-test: every rung UNSAT at `χ−1` **and** SAT at `χ`.
* `Assembly` — a two-point base placed by two motions, `#eval`'d, with the assembled certificate
  valid; and the adversarial member, a placement list whose motions have mismatched scales, which
  must fail rather than silently certify.
* `construct.py` — rebuilds the Moser spindle and de Grey's seed set exactly; and a `--self-test`
  whose negative half asks for a spindle at `r² = 4/3` (needing √39) and requires a refusal, not a
  silently wrong rotation.

---

## 4. The controls, and each one watched to fail

Per the house rule: a check is not known to work until it has been seen to fail. Eight, each with the
break that must make it go red.

| the check | break it by | must say |
|---|---|---|
| `myc47_not_colorable_five` | file the certificate against the 4-colour formula | the checker refuses |
| the same | delete one edge from the graph | the graph becomes 5-colourable; no certificate exists |
| the six-colour control | ask for a 5-colouring instead | must succeed, so a "6" that was silently a "5" is caught |
| the emitter's colour parameter | emit at 4 and check at 5 | size/position mismatch in Lean |
| `Assembly.validOn_copies` | give two motions different scales without re-denominating | validity fails |
| the same | move one base point off its unit circle | the base's own check fails first |
| `construct.py` rebuild | perturb one seed coordinate | the rebuilt spindle stops matching the committed JSON |
| `construct.py` spindle availability | ask for `r² = 4/3` | refusal naming √39, never a wrong rotation |

---

## 5. Explicitly *not* in this milestone

* **The search strategy.** No move set, no beam width, no restart policy. Unchanged from the stub and
  for the same reason: designed without a running search, it would be designed against an imagined
  difficulty. The scoring signal is already free — `Gadget.survivors.length`.
* **Extending the field.** § 0(g) gives the principled trigger; nothing yet pulls it. Extending is a
  parameter change with a known cost (the tower doubles per root), not new mathematics.
* **A 6-chromatic unit-distance graph.** That is rung D and it is M13.

---

## 6. Honest risks

* **The one that is new.** § 0(e) shows forcing at five colours needs configurations tighter than
  anything here, and **how much tighter is unmeasured.** If the smallest five-colour forcing
  configuration is beyond what the constructor reaches, M12 lands its instrument and reports that
  honestly — "searched X, found nothing" is a result and goes in the write-up.
* **A 6-chromatic unit-distance graph may not exist, or may be astronomically large.** χ(ℝ²) is 5, 6
  or 7; Polymath16 stalled at exactly this point. Every rung below has already paid.
* **Refutation cost is not monotone in graph size** (M07), and § 0(a)'s random instances vary by two
  orders of magnitude at fixed size. "Small" is not "cheap".
* **The five-colour cost is measured on proxies, not on unit-distance graphs**, because no
  6-chromatic unit-distance graph exists to measure. Structure buys orders of magnitude — de Grey's
  1581-vertex graph at four colours cost 34.2 M hint entries where a random 4-critical graph that
  size would be unreachable — so § 0(a) is likely **pessimistic** for real candidates, and that is a
  belief, not a measurement.
* **Ten interface vertices may not be enough** for a composition a search proposes (M11).
* **Symmetry carries no colouring information.** A rotationally symmetric unit-distance graph need
  not be 4-colourable — rotate any graph 180° about a distant point and take the union. Symmetry can
  **promote** a candidate and can never **reject** one. Getting that backwards would be unsound, and
  it is the exact mistake this shape of search invites.

---

## 7. Measurement anchors, all of them

Desktop (32 cores, 125 GB) unless stated. New in this milestone marked **new**.

### The five-colour question — **new**

| quantity | value |
|---|---|
| 47-vertex 6-chromatic graph, refuted at 5 colours | 10,224,710 hint entries, 91 MB, 6.15 CPU s |
| the same, at 4 colours | 45,001 hint entries, 0.27 MB, 0.02 CPU s |
| the same, at 5 colours with one edge pinned | **387,065 hint entries** |
| colour-naming lever at 5 colours (triangle) | **8.5–53×, median ~25×** |
| configuration race at gadget scale | **1.00× — does not reproduce** |
| find a 5-colouring of a 553-vertex unit-distance graph | **0.02 CPU s** |
| refute the same graph at 4 colours | 37.4 CPU s |
| profiler, 855 patterns at 7 ports, 5 colours | **0.19 s wall** |
| port sets forcing anything at 5 colours, across all four graphs | **0 of 48** |
| distance classes forcing anything at 5 colours, beyond the edge | **0** |
| spindle radii available in `ℚ(√3,√5,√7,√11)` | **32 of 94 sampled** |

### The terminal check (M11 § 0)

| colours | interface | colourings checked | time |
|---|---|---|---|
| 5 | 7 | 855 | 1.49 s |
| 5 | 8 | 3,845 | 8.33 s |
| 5 | 9 | 18,002 | 46.5 s |
| 5 | 10 | 86,472 | **257 s — the practical ceiling** |
| 5 | 8 | *390,625, without the partition quotient* | **does not finish** |

### Colour-partition counts

| interface | 4 colours | 5 colours |
|---|---|---|
| 6 | 187 of 4,096 | 202 of 15,625 |
| 8 | 2,795 of 65,536 | 3,845 of 390,625 |
| 10 | 43,947 of 1,048,576 | 86,472 of 9,765,625 |
| 12 | 700,075 of 16,777,216 | 2,079,475 of 244,140,625 |

### Everything carried forward

| quantity | value | from |
|---|---|---|
| kernel, per trimmed hint entry | ~1.35 ms (projection); 1.4–2.9 ms end to end including elaboration | M06/M07 |
| kernel folding, one colouring | ~1.2 ms | M11 § 0(e) |
| kernel, one pattern *built* | ~105 µs, independent of colour count | M11 § 0(c) |
| exhaustion ceiling, no certificate | 9 vertices at 4 colours; **7 at 5** | M11 |
| geometry, distinct differences per edge | ~1 : 118 | M08 |
| geometry, de Grey's 7,877 edges | 55.9 CPU s, 2 modules | M08 |
| refutation, de Grey (1581) | 34.2 M hint entries, 27.8 h, 2,265 modules | M06 |
| refutation, Heule (553 / 510) | 1.10 M / 1.41 M, ~30 min each | M07 |
| naming one triangle's colours, at 4 colours | 20× | M07 |
| racing solver configurations, at de Grey scale | 10.5× | M07 |
| sub-copy scan, 1581 points | 3.6 s, exact | M11 |
| deriving de Grey's second copy rather than certifying it | −1,043 modules, −180 MB, −12.8 h | M09 |
| editing `Gadget.lean` / `Motion.lean` | 18 / 118 CPU s of dependents | M11 § 0(a) |
| a `--` comment upstream | **free downstream** | M11 § 0(a) |
| a `/--` or `/-!` comment upstream | rebuilds every dependent | M11 § 0(a) |
