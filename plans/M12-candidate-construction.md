# M12 — Candidate construction (carry-forward capture)

*Opened 2026-08-01, immediately after M11 shipped. **Not subplanned** — this is the evidence a
subplanning session starts from, so that nothing here has to be rediscovered. Full subplanning, with
its own measurements and skeleton, is a separate step.*

**The hunt is M13.** This milestone was split out of it deliberately: a search that stops to build a
tool is a search that stops, and worse, a tool built *during* a stall is shaped by the stall rather
than by the problem. That is the characteristic failure of machine-assisted combinatorics — a search
that found what a bug allowed — and the cheapest defence is to build everything we already know we
need before the search starts, so that anything built *during* the hunt is genuinely novel.

Two of the five items below are M11's carry-forward. **Three were not on any list**, and the first of
them is more important than either carried item.

---

## 1. The gating measurement: nobody has ever asked this pipeline about five colours

`χ(ℝ²) ≥ 5` means *no 4-colouring*. **`χ(ℝ²) ≥ 6` means no 5-colouring** — and as of M11 the
machinery can *ask* that question but has never been made to answer it. Counted across the whole
repository:

| colour count | `coloringCNF k …` in Lean | `Colorable k` in Lean |
|---|---|---|
| 3 | 10 | 4 |
| 4 | 10 | 9 |
| **5** | **0** | **0** |

M11 shipped the capability and one spec witness that exercises it — the complete graph on five
vertices, refuted at four colours and *surviving* at five. **There is not one refutation at five
colours anywhere in this project**, and therefore not one measurement of what refuting five colours
costs.

### Why that number decides everything downstream

Every cost this project has recorded is a four-colour cost, and the one thing already established
about refutation cost is that it **does not scale the way anyone expects**:

| witness | vertices | propagation steps | processor time |
|---|---|---|---|
| de Grey | 1581 | 34,169,571 | 27.8 h |
| Heule | 553 | 1,104,106 | ~30 min |
| Heule | 510 | 1,413,841 | ~35 min — **28% *more* than the larger graph** |

M07's finding, restated because it governs this milestone: **refutation cost is not monotone in graph
size.** A smaller graph is less constrained and harder per vertex; that was swamped by the effect of
leaving de Grey's construction at all. At five colours the regime changes again in a direction nobody
here has sampled — the formula grows 25% in variables and edge clauses, but the space of colourings
grows by `(5/4)^n`, and instances are satisfiable far more often, which is a *different kind* of
search for a CDCL solver.

**If refuting five colours on a gadget-sized graph costs a hundred times what four does, the hunt's
whole shape changes** — which gadgets are affordable, how large a candidate can be, whether the
certificate route survives at all. It is one measurement and it is cheap. It goes first.

### What to measure, concretely

* A small graph known **not** 5-colourable — the complete graph on six vertices is the trivial one,
  and a 5-chromatic-plus-one construction is the honest one — through the *whole* pipeline: DIMACS
  from the Lean definition, CaDiCaL, LRAT, the packed format, `Sat/MaskCheck.lean`, kernel.
* The same graph at four colours, for the ratio.
* Steps, certificate size, module count, processor time — the four numbers M06 and M07 recorded, so
  the comparison is like for like.
* **The satisfiable direction too.** A search spends most of its time being told "yes, this is
  5-colourable"; that cost is the search's inner loop and is equally unmeasured.

---

## 2. The gap nobody noticed: nothing in this repository constructs a candidate

M11 built an instrument that **consumes** graphs. `tools/profile.py` takes one, `tools/minimise.py`
shrinks one, `tools/scan.py` reads one. Nothing **produces** one.

Every graph here arrived by hand:

| tool | what it makes |
|---|---|
| `tools/spindle.py` | *the* Moser spindle, hard-coded |
| `tools/degrey.py` | *de Grey's* graph, his construction, hard-coded |
| `tools/heule.py` | *reads* Heule's published coordinates |
| `tools/corespindle.py` | *the* core-and-spindle construction, hard-coded |

Four generators, four constructions, no generality. A search needs a *space* of candidates and a way
to walk it, and the space is not "all graphs" — it is **unit-distance graphs in the exact field**,
which is a much smaller and much more structured thing.

That is the second item, and it is arguably more fundamental than either carried one, because orbit
construction is a *particular way* of generating candidates.

Design notes for the subplan, not decisions:

* The natural primitive is a **point set closed under a set of motions**, which is exactly what
  `Motion` now expresses and exactly what `tools/scan.py` detects.
* The natural second primitive is **spindling**: take a configuration, rotate a copy about a shared
  vertex until two designated points land a unit apart. That is how the Moser spindle, de Grey's
  graph and Fisher–Ullman's core-and-spindle were all built, and the rotation it needs is a `Motion`.
* The exact field is a hard constraint: a candidate whose coordinates leave `ℚ(√3,√5,√7,√11)` cannot
  be certified. Every construction primitive must stay inside it, which is a *restriction on the
  search space that the tool should enforce* rather than a check that fails later.

---

## 3. Carried from M11 — orbit construction

**M11 § 1.5, deferred before any work started**, on the honest ground that its saving is only
collectable once a search proposes an orbit. It now has a consumer: item 2.

### What it buys, measured rather than argued

M09's largest single win was an orbit found **by accident**: de Grey's second 791-point copy turned
out to be his first one rotated, and deriving it rather than certifying it deleted **1,043 generated
modules, 180 MB of source, and 12.8 hours of processor time**, replaced by 95 CPU seconds. If a
candidate is *constructed* as an orbit, that saving is true by construction and guaranteed rather
than hoped for — one certificate per orbit representative instead of one per copy.

### What M11 left ready, and the one wrinkle it left open

Ready:

* `Motion.image` — the image of a point, at `M` times the source's denominator.
* `Motion.rescale` — the same point re-written at `M` times the denominator.
* `Motion.distSq_image`, `Motion.distSq_rescale` — each scales every squared distance by `scale`.
* `Motion.trans` — motions compose, in reading order.
* `UDCert.validOn_map_of_scaling` — **stated over a bare `g : Pt → Pt` and `s : Q4`, not over a
  `Motion`**, precisely so that `image`, `rescale` and their composites are all instances. A copy
  whose coordinates are *defined* as the image costs **nothing**: no per-vertex check, no per-edge
  arithmetic.

Open, and it is arithmetic rather than mathematics:

> **The scale factor compounds under iteration.** Level `i` of an orbit sits at denominator `d·Mⁱ`,
> so the levels do not share a denominator without extra scaling, and `UDCert.denom` is an integer
> while `M` need not be (`M² = scale`, and `scale` need not be a perfect square — a reflection with
> `a = 1, b = √11` has `scale = 12`). The composite `rescale ∘ image` scales by `scale` and takes the
> denominator to `scale · d`, which **is** an integer for any motion; that is the general route, and
> plain `image` at `M · d` is the cheaper one when `M` happens to be a natural number, as de Grey's
> `32` is.

`Motion` is **not** closed under inverse and is **not** a monoid, both deliberately (M11 § 3.5). If
orbits need `μ ^ i`, the monoid instance is `Motion.ext` plus four `ring` identities, because `trans`
is already field-wise; if they need inverses, it is three more laws (`A Aᵀ = scale·I`), satisfied by
every smart constructor. Both were left unbuilt for want of a consumer. **Item 3 is that consumer**,
and the subplan should decide which, if either, is actually wanted.

---

## 4. Carried from M11 — the gadget catalogue

**M11 § 2.5**, which shipped its *producer* and not its contents.

### What exists

* `Gadget.ofExhaustion` — a gadget from checking every colouring, **no solver and no certificate
  anywhere**. Its hypothesis is decidable, so a caller writes `by decide +kernel`.
* `tools/profile.py` — a subgraph's whole port property, one solver call per colour-partition, in
  milliseconds.
* The first gadget that is neither an edge nor a certificate: the **rhombus**, whose two
  *non-adjacent* far corners are forced to share a colour at three colours and forced nothing at
  four. Both directions committed.

### The measured finding that shapes the catalogue

**At four colours, not one graph in this repository has a port property that its edges do not already
explain.** Measured on 2026-08-01 with the new tools:

| graph | ports | refuted patterns | shrinks to |
|---|---|---|---|
| core-and-spindle, 63 vertices | 0, 1, 2 | 3 | **3 vertices, 2 edges** — the two edges, and nothing else |
| Moser spindle, 7 vertices | 0, 2, 5 | 3 | **3 vertices, 2 edges** — likewise |
| core-and-spindle, 63 vertices | 0, 30, 60 | **0** | — |
| rhombus, 4 vertices, at **three** colours | 0, 3 | 1 | **4 vertices, 5 edges — nothing removable** |

The pattern is not an accident: a graph that is comfortably `k`-colourable imposes nothing on a
handful of distant vertices. **A gadget property needs a graph that is tight at the colour count
being asked about** — which is why the rhombus forces at three and not at four, and why a catalogue
aimed at rung D must be built at *five*.

That makes the catalogue's shape clear and cheap: enumerate small unit-distance configurations, run
the profiler at five colours, keep what forces, emit as Lean through `Gadget.ofExhaustion` where it
fits under the exhaustion ceiling and through a certificate where it does not.

### The exhaustion ceiling, measured

`decide +kernel` over every `Fin n → Fin k` costs ~1.2 ms per colouring in the kernel (2,187
colourings in 2.6 s, measured on the Moser spindle at three colours). So:

| colours | ceiling for a no-certificate gadget |
|---|---|
| 4 | `n ≈ 9` vertices (`4⁹ = 262,144` ≈ 5 min) |
| **5** | **`n ≈ 7` vertices** (`5⁷ = 78,125` ≈ 94 s) |

Seven vertices is small. Whether the useful five-colour gadgets fit under it is unknown, and it is
the second reason item 1 goes first: everything larger needs a certificate, at a cost nobody has
measured.

---

## 5. The loop, unmeasured end to end

M11 measured the *terminal check* precisely and measured nothing else about a search iteration. One
iteration is: propose a candidate → profile its gadgets → compose → score → decide the next move. The
per-stage costs are known or knowable; **the loop has never been run**, so the wall-clock cost of one
search step is a projection.

That measurement belongs here, because the answer determines whether the hunt is a search over
thousands of candidates or over dozens — and those are different searches.

---

## 6. Explicitly *not* in this milestone

**The search strategy.** No move set, no beam width, no restart policy, no objective beyond the one
that already exists. A search strategy designed without a search is speculative structure, and this
project's standard forbids it for good reason: it would be designed against an imagined difficulty
rather than the real one.

The scoring signal is already free — `Gadget.survivors.length` counts the port colourings a
composition has not ruled out, one per colour-partition, each rendered as a solver cube. What moves
descend it is a question only a running search can answer, and answering it is M13's work.

---

## 7. The measurement anchors

Every number a subplanning session should reason from, in one place. Desktop (32 cores, 125 GB)
unless stated.

### The terminal check (M11 § 0)

| colours | interface vertices | colourings checked | time |
|---|---|---|---|
| 5 | 7 | 855 | 1.49 s |
| 5 | 8 | 3,845 | 8.33 s |
| 5 | 9 | 18,002 | 46.5 s |
| 5 | 10 | 86,472 | **257 s — the practical ceiling** |
| 5 | 8 | *390,625, without the partition quotient* | **does not finish** |

~2–3 ms per colour-partition, growing slowly with the interface size. Checking every colouring
instead is 53–72× worse and caps the interface at **seven**.

### Colour-partition counts

| interface | at 4 colours | at 5 colours |
|---|---|---|
| 6 | 187 of 4,096 | 202 of 15,625 |
| 8 | 2,795 of 65,536 | 3,845 of 390,625 |
| 10 | 43,947 of 1,048,576 | 86,472 of 9,765,625 |
| 12 | 700,075 of 16,777,216 | 2,079,475 of 244,140,625 |

### Everything else

| quantity | value | from |
|---|---|---|
| kernel folding, one colouring | ~1.2 ms | M11 § 0(e) |
| kernel, one pattern *built* and nothing else | ~105 µs, independent of colour count | M11 § 0(c) |
| geometry, distinct differences per edge | ~1 : 118 across de Grey's whole build | M08 |
| geometry, de Grey's 7,877 edges | 55.9 CPU s, 2 modules | M08 |
| refutation, de Grey (1581 vertices) | 34.2 M steps, 27.8 h, 2,265 modules | M06 |
| refutation, Heule (553 / 510) | 1.10 M / 1.41 M steps, ~30 min each | M07 |
| naming one triangle's colours | **20×** on a monolithic refutation | M07 |
| racing solver configurations on trimmed hint count | **10.5×** | M07 |
| sub-copy scan, 1581 points / 7877 edges | **3.6 s**, exact, recovers the 791-point split | M11 |
| editing `Gadget.lean` | 18 CPU s (5 dependents) | M11 § 0(a) |
| editing `Motion.lean` | 118 CPU s (95 of it one module) | M11 § 0(a) |
| a `--` comment upstream of anything | **free downstream** — the `.olean` is byte-identical | M11 § 0(a) |
| a `/--` or `/-!` comment upstream | rebuilds every dependent | M11 § 0(a) |

---

## 8. Honest risks, carried forward

* **A 6-chromatic unit-distance graph may not exist, or may be astronomically large.** χ(ℝ²) is 5, 6
  or 7. Polymath16 and strong SAT researchers stalled at exactly this point. This is a genuine
  gamble; every rung below it has already paid.
* **Refutation cost is not monotone in graph size**, so "find a small candidate" is not the same as
  "find a cheap one", and optimising for solver-friendliness optimises a route that was already
  measured dead one rung up.
* **Ten interface vertices may not be enough.** It is enough for every composition in this repository
  and there is no evidence it is enough for one a search proposes.
* **The five-colour cost is unmeasured in both directions** — refuting *and* finding — and the second
  is the search's inner loop.
* **Symmetry carries no colouring information.** A rotationally symmetric unit-distance graph need
  not be 4-colourable; the counterexample is one line (rotate any graph 180° about a distant point
  and take the union). Symmetry can **promote** a candidate — an invariant colouring is a colouring
  of a `k`-times-smaller quotient — and can never **reject** one. Getting that backwards would be
  unsound, and it is written down here because it is the exact mistake this shape of search invites.
