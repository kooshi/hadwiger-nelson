# M13 — Re-finding χ ≥ 5 with the search

*Subplanned 2026-08-01, immediately after M12 landed. § 0 is measurement taken **before** the shape
was specified, per WORKFLOW's rule; it overturned two things the carry-forward stub asserted.*

**The hunt is M14.** This milestone was inserted ahead of it for one reason, and it is a measurement
rather than a preference:

> **A search instrument that cannot re-discover the witness for the rung below is not credible for
> the rung above.**

The same discipline the project already runs on — the Moser spindle was rung A's calibration
instance for the whole pipeline, deliberately small enough that `decide` could cross-check the SAT
bridge. This milestone applies it to the *search itself*.

---

## 0. Measured before specifying

Desktop (32 cores, 125 GB), 2026-08-01. Everything here is new to this milestone.

### 0(a) de Grey's construction is **four primitive moves**, and only one of them is missing

`tools/degrey.py` follows arXiv:1804.02385v3 § 5.1 verbatim and was read step by step against the
primitives `tools/construct.py` already has. The result is an exact identity, not a resemblance:

```
G = spindle( delete₂( spindle( orbit(S, hex₁₂), (0,0), (2,0) ) ), (−2,0), (2,0) )
```

verified by **exact equality of the point sets** after the one named field rotation that relates the
two conventions (his step rotates both copies by ±a about the centre; the spindle move holds one
copy still).

| move | points out | radicand | in the tool? |
|---|---|---|---|
| `orbit(S, hex₁₂)` — six 60° rotations and reflection | 397 (paper: 397) | — | **no** |
| `spindle(·, (0,0), (2,0))` | 793 | `4·4−1 = 15` → **√15** | yes |
| `delete {(±⅓, 0)}` | 791 (paper: 791) | — | no |
| `spindle(·, (−2,0), (2,0))` | **1581** (paper: 1581), 7877 edges | `4·16−1 = 63 = 9·7` → **3√7** | yes |

**The stub was wrong that a third primitive — "rotation about an arbitrary centre by a chosen
angle" — is needed.** Both of de Grey's rotations are *spindles about a vertex of the configuration*:
his step 3 rotates by `2·arcsin(1/4)`, which is the spindle at `|pq| = 2`, and his steps 5–6 rotate
by `π/2 ± arcsin(1/8)`, whose relative angle is the spindle at `|pq| = 4`. The move already in the
tool is exactly the general one.

And the field's contents are again a consequence rather than a choice: **√15 and √7 are in
ℚ(√3,√5,√7,√11) precisely because they are the spindle radicals of de Grey's two rotations.**

### 0(b) The deletion is **not** load-bearing — it saves four vertices

The stub asserted that de Grey removes `(±⅓, 0)` "because they are the ones that make the graph
4-colourable". Measured, at four colours, on the same pair his argument uses:

| set | points | edges | is the pair forced? |
|---|---|---|---|
| `S_a` (orbit only) | 397 | 1974 | **no** — a 4-colouring separating them exists, found in 0 s |
| `S_a ∪ S_b` (**before** the deletion) | 793 | 3954 | **yes** — refuted in 27 s |
| `Y` (after the deletion) | 791 | 3938 | yes — refuted in 32 s |

So the deletion buys 4 vertices in the final graph (1581 rather than 1585) and nothing else.
Skipping it yields a 1585-vertex 5-chromatic graph by the identical argument. `delete` is still
worth building — it is the shrinker's only move — but it is not on the critical path.

### 0(c) The forcing is one pair in 312,445, at the one distance the field can spindle

`Y` is de Grey's half. Pin its vertex 14 — the point `(−2,0)`, which is the copies' shared vertex —
to a colour and compute the **backbone**: every vertex whose colour is then fixed in every proper
4-colouring.

| | |
|---|---|
| forced to the pivot's colour | **exactly one vertex: 11**, the point `(2,0)` |
| forced to any other colour | none |
| its squared distance from the pivot | **16**, radicand `63 = 9·7` — spindle available |
| candidate pairs in `Y` | 312,445 |
| cost | 9 SAT calls, 109 s |

Vertices 14 and 11 are exactly the ones M06's proof names. The win condition of the entire search is
**one pair out of 312,445, and it sits at the one distance the field was extended to spindle.**

### 0(d) All 39 of de Grey's seed points are load-bearing — **the needle has no gradient**

Drop one seed point, rebuild orbit → spindle, re-ask the forcing question. Thirty-nine trials,
46 s total:

> **39 of 39 kept. Not one seed point can be removed.** Every proper subset of `S` yields a
> configuration in which a 4-colouring separates the pair, found in under half a second.

This is the milestone's central fact and it is what any honest expectation must be built on. A
search that grows or perturbs seed sets has **no signal to climb**: every proper subset of the
answer scores exactly zero, so the objective is flat everywhere except at the answer itself. This is
not a compute shortfall — adding cores to a flat landscape buys nothing, which is the same shape
M12 found when the blind spindle search *exhausted* at 1,961 graphs.

**It also names the search that can work.** Polymath16 got from 1581 to 553 to 510 by *shrinking a
rich set*, never by growing a seed set. Shrinking has a gradient — every successful deletion is
progress and every failed one is information — and the same oracle answers both questions. § 5
specifies the search accordingly, and it is a different algorithm from the one M12 measured.

### 0(e) The oracle is free where it must be and expensive only where it matters

The forcing oracle on nested subsets of `Y`, one pivot each:

| points | edges | backbone | one pair, one SAT call | pairs at spindle-able `r²` |
|---|---|---|---|---|
| 50 | 16 | 0.1 s | 0.00 s | 56 of 1,225 |
| 100 | 72 | 0.1 s | 0.00 s | 236 of 4,950 |
| 200 | 274 | 0.1 s | 0.01 s | 946 of 19,900 |
| 400 | 1,018 | 0.5 s | 0.01 s | 3,759 of 79,800 |
| **791** (tight) | 3,938 | **112 s** | **32 s** | 14,615 of 312,445 |

The same asymmetry M12 measured for rejection against certification: **a configuration that forces
nothing says so almost instantly, and only a configuration that actually forces costs anything.**
About **4.7%** of vertex pairs sit at a rational squared distance whose spindle radicand is a square
in the field, so the distance filter alone removes 95% of candidates for free.

Two corollaries the search is built on. The **backbone** asks one question per *pivot* and returns
every partner that pivot forces, so the oracle is O(vertices) rather than O(pairs). And the orbit
group collapses the pivots further: in a hex₁₂-symmetric configuration the pivots come in orbits of
up to 12, so **the orbit primitive earns its keep twice — it builds the configuration and it divides
the search over pivots by up to twelve.**

---

## 1. What this milestone is for

Three deliverables, in the order they matter.

1. **The closing step, certified and general.** "Spindle a forced pair and the colour count goes up
   by one" is the argument behind *both* known rungs — the Moser spindle at three colours and de
   Grey's graph at four — and it exists nowhere in this repository as a theorem. M06 hand-composed
   it for one graph. Making it a lemma turns the search's win condition into something a found
   candidate is certified *through*, rather than something re-argued each time.
2. **The missing primitive and the win-condition oracle**, so the instrument can express de Grey's
   route and recognise its target.
3. **The search, run, and reported honestly** — including the verdict that § 0(d) makes likely.

---

## 2. The shape

### 2.1 The win condition, in one definition

> Two vertices are **forced** at `k` colours when no proper `k`-colouring separates them.

That is the entire target of the search. Everything else is machinery for producing one or for
cashing one in.

### 2.2 The closing lemma

Two copies of a forcer, glued at the pivot, with the two partner-images a unit apart:

```
        φ(q) ──1── ψ(q)         φ, ψ : the two placements
          │          │          φ(p) = ψ(p)  : the copies share the pivot
       forced     forced        C(φ q) = C(φ p) = C(ψ p) = C(ψ q)  — but φ(q) ~ ψ(q)
          │          │
        φ(p) ═════ ψ(p)
```

The proof is four rewrites and needs nothing about geometry, `Fin`, or which graph is which: pull a
colouring of the big graph back along each placement, apply the forcer twice, walk the joining edge.
The placements are arbitrary functions, so `Assembly`'s copies, a hand-written embedding and a
search's output all satisfy it without adaptation.

**Read against the informal claim, out loud:** *if every k-colouring of a configuration paints two
of its points the same, and you can place two copies of it sharing the first point with the second
points a unit apart, then the union has no k-colouring.* That is the Moser spindle's argument
verbatim, and de Grey's.

### 2.3 The two instances, and why the small one is not a toy

* **The Moser spindle is literally two rhombi glued at a vertex.** Its 11 edges split as
  `{(0,1),(0,2),(1,2),(1,3),(2,3)}` — which is `Gadget.rhombus` on the nose — plus the same five
  under `0,1,2,3 ↦ 0,4,5,6`, plus the joining edge `(3,6)`. The pivot is vertex 0, the partner is
  vertex 3, and `rhombusGadget` (already committed, already kernel-decided) is the forcer at three
  colours. So rung A's witness is re-derived through the general lemma **for the cost of naming two
  maps**, with no new certificate.
* **de Grey's graph is the same picture one colour up**, with `Y` as the forcer, vertex 14 as the
  pivot, vertex 11 as the partner and `(11, 802)` as the joining edge — which is exactly the shape
  M06's `Instances/DeGrey/Forcing.lean` composes by hand today.

---

## 3. The skeleton — `Proofs/HadwigerNelson/Forcer.lean`

One new module, importing `Gadget.lean`. Every signature and full statement, `sorry` at every leaf.

```lean
/-- Two vertices are **forced to agree** at `k` colours: no proper `k`-colouring separates them. -/
def Forces (n k : ℕ) (E : List (Fin n × Fin n)) (p q : Fin n) : Prop :=
  ∀ f : Fin n → Fin k, Proper n E f → f p = f q

/-- **A two-port gadget that rules out the ports differing is a forcer.** The bridge from the
algebra's producers (`ofUnsat`, `ofExhaustion`) to the search's win condition. -/
theorem Forces.of_gadget (hk : 2 ≤ k) (g : Gadget k n 2 E ![p, q])
    (h : ∀ q' : Fin 2 → Fin k, q' 0 ≠ q' 1 → g.admits q' = false) : Forces n k E p q

/-- **The spindle closes a forcer.** Two copies of a forced pair, sharing the pivot, with the
partners adjacent: the union has no `k`-colouring. -/
theorem not_colorable_of_spindled_forcer {n N k : ℕ}
    {E : List (Fin n × Fin n)} {F : List (Fin N × Fin N)} (φ ψ : Fin n → Fin N)
    (hφ : ∀ e ∈ E, e.1 ≠ e.2 → (edgeGraph N F).Adj (φ e.1) (φ e.2))
    (hψ : ∀ e ∈ E, e.1 ≠ e.2 → (edgeGraph N F).Adj (ψ e.1) (ψ e.2))
    {p q : Fin n} (hpiv : φ p = ψ p) (hjoin : (edgeGraph N F).Adj (φ q) (ψ q))
    (hforce : Forces n k E p q) : ¬ (edgeGraph N F).Colorable k
```

### 3.0 What the domain pass changed — and it closed every leaf

The skeleton above stated the closing lemma over **edge lists and `Fin`**, because that is what
everything else in this repository decides over. The domain pass moved it to **`SimpleGraph` and
graph homomorphisms**, and that single change turned all eight sorried leaves into transcriptions.
The module now builds green in 1.8 s with zero `sorry`.

| | skeleton | after the pass |
|---|---|---|
| indices carried | `n`, `N`, `k` | `k` only |
| hypotheses of the closing lemma | 6 | **3** |
| the proof | not written | **`exact C.valid hjoin ((h.comap φ C).symm.trans (hpiv ▸ h.comap ψ C))`** |

Four decisions, each with what it was weighed against.

* **`Forces` lives at `SimpleGraph`, not at edge lists.** *Alternative:* state it over `Fin n` plus an
  edge list, matching `Gadget` and everything around it. *Why this won:* the general statement is the
  easier one — pulling a colouring back along a placement is `SimpleGraph.Coloring.comap`, which
  Mathlib already has, so the whole argument is three rewrites and no index arithmetic. It also
  applies to graphs on infinite vertex types, which is the form the plane's own unit-distance graph
  has; the `Fin`-indexed statement could never reach it. *Confidence: high* — the mutation audit
  below confirms nothing was lost.
* **`Forces` is not a `Gadget`.** *Alternative:* reuse the two-port gadget, which already expresses
  the same fact — `rhombusGadget` **is** the rhombus forcer. *Why this won:* `Gadget` is the
  computable over-approximation, carrying five indices because *composition* needs them; the closing
  lemma composes nothing and needs only the proposition. This is the same `Prop`/`Bool` split the
  repository already runs for `SamePattern`/`samePattern`, with `Forces.of_gadget` as the bridge.
  *Confidence: high.*
* **No `Spindle` structure bundling the geometry with the combinatorics.** *Alternative:* one object
  carrying (forcer, pivot, partner, the two motions, the certificate), so a search's output is a
  single value. *Why this won:* the closing argument genuinely does not care *why* the partners are
  an edge — bundling would tie it to `UDCert` and `Pt` and stop it serving `K₅`, Mycielski, or the
  plane. Geometry and combinatorics meet at exactly one place, "this pair is an edge", and that is
  intrinsic rather than a convenience of the current pipeline. *Confidence: high.*
* **The `e.1 ≠ e.2` guard was dropped where `Adj` implies it and kept where it does not.** In the
  abstract statement `Adj` already carries the disequality, so the guard was a hypothesis the proof
  never touched; in the list-side `edgeHom` builder nothing implies it, so there it does real work.

**And the field condition stays out of Lean.** Whether a spindle at squared distance `r²` exists is
`4r²−1` being a square in ℚ(√3,√5,√7,√11) — a fact about *motions*, while the closing lemma needs
only that the two partner-images are an edge. Deriving the edge from the rotation instead of
checking it would need a trigonometric identity in the field to save **one** edge at 7.1 ms. Not
worth it, and the two facts stay independent. *Confidence: high.*

### 3.0.1 The mutation audit, run

Every hypothesis deleted in turn, and the proof must stop compiling:

| mutation | result |
|---|---|
| drop `hpiv` (the copies share the pivot) | breaks |
| drop `hjoin` (the partners are adjacent) | breaks |
| drop `hforce` (the pair is forced) | breaks |
| weaken `Forces` from "every colouring agrees" to "some colouring agrees" | cannot be closed |

Seams checked rather than assumed: `p = q` and `φ = ψ` both make `hjoin` a **self-loop**, which
`SimpleGraph` forbids — so the degenerate placements are excluded by the model itself and no `p ≠ q`
side condition is needed. `k = 0` and `k = 1` are harmless (the conclusion is true in both). The
Moser spindle instance inhabits every hypothesis at once, so nothing here quantifies over an empty
domain.

### 3.0.2 What the obligation pass added

The Lean leaves were already closed, so this pass went after the obligations the *rest* of the
milestone rests on — the ones outside Lean, which is where this project has twice had a gate fail
open. Four findings, three of them changing the design.

**(a) The placements must be *derived*, not checked — 31 million comparisons avoided.** The closing
lemma takes the ambient graph as given and asks whether each placement lands edges on edges. Checked
by list membership that is `|E| × |F|` comparisons: **at a 791-point forcer with 3,938 edges against
7,877, thirty-one million**. That is precisely the wall M06 hit and escaped by ordering its edge
list so each half was a contiguous segment.

So the assembled edge list is now **defined** as the two placed copies followed by the joining edge
(`spindleEdges`), and each placement is a homomorphism *structurally* — `List.mem_append_left` of
`List.mem_map`, no search. The joining edge is free for the same reason: it is the list's last
element by construction. What remains is one disequality per edge (the placement must not collapse
an edge to a loop), which is linear rather than quadratic. `not_colorable_spindleEdges` is the
resulting statement, and it is what a candidate the search proposes is certified through.
*Alternative:* keep the membership check and pay it once per candidate. *Why this won:* 31 million
kernel comparisons is hours, and M06 already paid for learning it. *Confidence: high.*

**(b) The pivot-orbit collapse is sound, and an endomorphism suffices.** The search wants to try one
pivot per symmetry orbit rather than all of them — worth up to 12× on the hexagonally-built
universe. That needs "a symmetry carries a forced pair to a forced pair", which turns out to be
`Forces.comap` with source and target the same graph, so `Forces.map` is one line and needs only a
graph **endomorphism**, not an automorphism.

**But the saving stops where the symmetry does.** The hypothesis is a symmetry *of the graph*, and
shrinking destroys it — so the 12× applies to *finding* a forced pair in the symmetric universe and
**not** to the shrink that follows. The tool must therefore read the configuration's actual
symmetries rather than assume the hexagonal group survived a spindle; `tools/scan.py` already
recovers the isometries a point set exhibits, and did so for de Grey's 791-point split in 3.6 s.

**(c) The backbone's invariant, stated — because the timeout is the fail-open case.** The algorithm
takes one model, then tests each surviving candidate literal. Writing `BB` for the true set of
literals forced in every colouring, the loop maintains

> `confirmed ⊆ BB ⊆ confirmed ∪ candidates ∪ unknown`

and at exit `candidates` is empty, so **the answer is exact exactly when `unknown` is empty**. A
timeout on any single test lands that literal in `unknown`, and the two ways of sweeping it away are
both wrong in a named direction: discarding it makes the report an *under*-approximation (a forced
pair is missed, so "searched and found nothing" becomes a lie), and confirming it makes the report
an *over*-approximation (a non-forcer is sent to Lean, which rejects it after hours).

Under-approximation is the one that matters, because "searched X, found nothing" is a result this
project publishes. So `backbone` returns `unknown` **as a set, not a flag**, the search's negative
claim is conditioned on it being empty, and the count is printed on every run whether it is zero or
not — failure path louder than the success path. *Alternative:* a boolean `gave_up`. *Why this won:*
a boolean says the answer is incomplete; the set says which pivots to re-ask with more budget.
*Confidence: high — this is the exact shape of both earlier fail-open gates.*

**(d) The shrink loop: the claim decides the loop, not the reverse.** Invariant: the forcing holds
at every step. Measure: the point count, strictly decreasing on each accepted deletion, bounded
below by 2. Termination is immediate; what is *not* immediate is what may be claimed at exit.

| loop | what may honestly be claimed |
|---|---|
| batch-greedy (drop a block, halve on failure) | only "no block in the sequence tried was removable" — **not** irredundant |
| single-point sweep, every remaining point tried since the last success | **irredundant**: no single point can be removed |
| either, with any oracle time-out | irredundant *among the points whose deletion the oracle settled* |

The claim wanted in the report is **irredundant** — it is the strong one, and it is what makes the
39-of-39 measurement in § 0(d) mean something. So the loop is derived from it: batch-greedy for
speed, then a **certifying final sweep** at block size one over every survivor, and the output
carries both `irredundant` and the list of points whose deletion the oracle could not settle. A
shrink that cannot certify says so rather than claiming the strong word.

### 3.0.3 The negative controls, per tool primitive

| break this | what must go red | where |
|---|---|---|
| `orbit` under a set of motions that is not closed | orbit is not idempotent: `orbit(orbit(C,M),M) ≠ orbit(C,M)` | tool self-test |
| `delete` removing the pivot or the partner | the oracle reports "no pivot", never "not forced" | tool self-test |
| the forcing oracle handed a satisfiable instance | the rhombus at **four** colours must come back `sat` | tool self-test, and the Lean countermodel `¬ Forces (edgeGraph 4 rhombus) 4 0 3` |
| the backbone reporting a literal that is not forced | the rhombus at **three** colours must yield exactly the far corner and nothing else | tool self-test |
| the shrink returning a set that no longer forces | one fresh oracle call on the output, asserted | tool self-test |
| **the claim that a pair is forced at all** | **the tool cannot check this** — it is `forces_of_edges (by decide +kernel)` at spec size, `Forces.of_gadget` from a certificate at scale | **Lean only** |

The last row is the division the whole project runs on: the tool's assertions are self-consistency,
and the theorem is Lean's.

### 3.0.4 What the experience pass changed

The consumer that matters is M14 — the hunt for χ ≥ 6 — which will call this in a loop at five
colours and whose most common experience is *failure*. So the pass went at the failure path first.

**The machine user was audited rather than imagined.** Handing `exact?` the three goals a caller
actually holds returns exactly the intended lemma each time: `not_colorable_of_spindled_forcer` for
the abstract goal, `not_colorable_spindleEdges` for the constructed one, and `Forces.map` for "one
pivot per orbit is enough". Discoverability is not a hope here; it was run.

**Three changes.**

* **A general module must not depend on an instance.** `Forcer.lean` imported
  `Instances/Spindle.lean` purely so its spec could mention the Moser spindle — so everything M14
  stacks on top would have dragged a coordinate table with it. The instantiation moved to
  `Instances/SpindleBound.lean`, which is a leaf, and it lands **beside the three routes to the same
  theorem it is a fourth alternative to** — better for the reader than being a file away.
  *Alternative:* leave it and accept a 7-point table. *Why this won:* the DAG statement "the algebra
  depends on no instance" is worth more than the move cost, and M14 is where it gets paid.
* **`forces_of_edges` became `Forces.of_edges`,** beside `Forces.of_gadget`. Two producers of one
  property that were spelled differently is a name that teaches a reader a false rule.
* **The four distinguishable failures each got a sentence, and both directions are pinned.** A new
  `ForcerDiagnose.lean` — `#eval`-only, downstream, nothing imports it, so it is rewritable for the
  cost of one file — reports *which* side condition refused a candidate: the copies do not share the
  pivot (naming where each lands), the partners coincide (so there is no joining edge), or a
  placement collapses an edge (naming the edge and the vertex it lands on). Six `#guard_msgs` pin
  all four messages plus the passing case, because a diagnostic that renders nothing when it cannot
  run is worse than none.

**And the one thing the diagnostic deliberately does not say.** Whether the pair really *is* forced
is settled only by `Forces.of_edges (by decide +kernel)` or by a certificate through
`Forces.of_gadget`. A report that said "forced" would be a check reporting what it could not run,
which is the exact shape of both gates that have failed open in this project.

**The failures that belong to the tool, not to Lean:** a configuration that forces nothing, and a
pair forced at a squared distance whose spindle radicand is not a square in the field. The second is
the *actionable* one — `field.py`'s `missing_root` already names the root that would be needed, and
the refusal says so rather than rounding to something Lean would later reject for unreadable
reasons.

### 3.1 Spec — the instance, and the controls that must go red

```lean
/-- The rhombus forces its far corners at three colours — `rhombusGadget`, read as a forcer. -/
theorem rhombus_forces : Forces 4 3 Gadget.rhombus 0 3

/-- **The Moser spindle, re-derived.** Two rhombi sharing vertex 0, far corners joined. -/
theorem moserSpindle_not_colorable_three_spindled :
    ¬ (edgeGraph 7 moserSpindleEdges).Colorable 3
```

Negative controls, each an `example` that must fail to be provable or a claim that goes red:

| break it here | what must happen |
|---|---|
| the rhombus at **four** colours | not a forcer — `example : ¬ Forces 4 4 rhombus 0 3`, by `decide` |
| the joining edge deleted (`(3,6)` removed) | the spindle **is** 3-colourable — an exhibited colouring |
| the pivots not shared (`ψ 0 = 4` instead of `0`) | the hypothesis is false and the instance will not build |
| a forcer filed at the wrong pair (`0,1` instead of `0,3`) | `Forces.of_gadget`'s hypothesis fails |

---

## 4. The tools

Untrusted throughout; Lean re-derives every claim.

| what | where | why |
|---|---|---|
| `orbit(cfg, motions)` — close a configuration under a finite group | `construct.py` | § 0(a): the one missing primitive |
| `hex12()` — the order-12 group as motions | `construct.py` | de Grey's step 2, and the pivot-collapsing symmetry |
| `delete(cfg, idxs)` | `construct.py` | the shrinker's only move |
| `forces(cfg, p, q, k)` and `backbone(cfg, p, k)` | `tools/forcer.py` (new) | § 0(c)/0(e): the win condition, asked per pivot |
| `spindleable(r²)` filter | reuse `field.py` | 95% of pairs removed for free |
| de Grey rebuilt from the four primitives | `construct.py` self-test | the calibration of § 0(a), as a committed control |

**The control that matters**: `construct.py` rebuilds de Grey's 1581 points from the 39 seed points
and four moves, and `scripts/regen-check.sh` asserts **exact equality with the committed
coordinates**. That converts the committed table from transcribed data into *derived* data — the
"state the construction, not only the coordinates" standard, discharged.

---

## 5. The search

**Shrink a rich universe toward a minimal forcer.** Not grow from seeds — § 0(d) measured that
landscape flat.

1. **Universe.** `orbit(seed-rich set, hex₁₂)` then `spindle`, at a size the oracle still answers
   (§ 0(e) puts that near a thousand points).
2. **Recognise.** Backbone from each pivot orbit representative; a forced pair at a spindle-able
   squared distance is a win.
3. **Shrink.** Greedy deletion preserving the forcing — every successful deletion is progress, every
   failure is information, and both cost one oracle call.
4. **Close.** Spindle the minimal forcer; the result is 5-chromatic *by the closing lemma*, with no
   whole-graph refutation needed at all.

Step 4 is the reason the closing lemma is deliverable #1: **a forcer of `m` points certifies a
`2m−1`-point 5-chromatic graph at the cost of refuting `m` points once.** M06 refuted de Grey's
halves rather than the whole graph for exactly this saving, at 44× — here it is the lemma rather
than a bespoke composition.

**If the search re-finds de Grey's own configuration, that is reported as a re-find and the graph is
not re-certified** — M06 certified it already, and a second certificate of the same theorem is
28 hours for nothing.

---

## 6. The cost model

Carried forward from M07/M08/M11/M12 and extended by § 0. Desktop.

| quantity | value |
|---|---|
| one search step, M12's blind loop | ~17 ms |
| forcing oracle, loose configuration (≤ 400 pts) | **0.1–0.5 s** |
| forcing oracle, tight configuration (791 pts) | 31 s one pair · 109 s full backbone |
| reject a candidate (find a 5-colouring), 553 pts | 0.02 CPU s |
| certify one (refute at 4 colours), 553 pts | 37.4 CPU s — ~3,000× |
| kernel, per propagation step | ~1.35 ms projected; 1.4–2.9 ms with elaboration |
| 553-point witness at four colours (M07) | 1,104,106 steps |
| de Grey's 1581 points at four colours (M06) | 34,169,571 steps, 27.8 h, 2,265 modules |
| emitted literal coordinates | 7.1 ms per edge |
| **computed** coordinates by `decide` | 0.33 CPU s per edge — 47× worse |
| computed coordinates through `Assembly` | **free** — no per-edge reduction |
| terminal check, interface vertices at 5 colours | 10 (86,472 partitions, 257 s) |

---

## 7. Explicitly *not* in this milestone

* **χ ≥ 6.** That is M14. Everything at *five* colours — where M12 measured that nothing this
  project owns forces any port property, and the tightness threshold is unmeasured — carries there.
* **Re-certifying de Grey's graph** if the search re-finds it. Already done at M06.
* **Deriving de Grey's coordinates inside Lean.** The orbit's dedup does not fit `Assembly`'s
  disjoint-copy indexing, and the payoff is a table we already certify. The derivation lands in the
  tool with an exact-equality control instead (§ 4).

---

## 8. Honest risks

* **The search will probably not re-find de Grey's seed set.** § 0(d) is decisive: 39 irredundant
  points, no gradient. The milestone is designed to deliver the closing lemma, the primitive and the
  oracle regardless, and to report the search verdict as a result rather than a shortfall.
* **A universe rich enough to contain a forcer may be too tight for the oracle.** § 0(e) shows the
  cost is driven by tightness, not size; the one tight configuration measured cost 109 s per pivot.
  If the universe search is unaffordable the fallback is de Grey's own universe, and the claim
  weakens honestly to "re-found *given* his seed set".
* **Re-finding χ ≥ 5 may be a second wall rather than a stepping stone.** If so the milestone falls
  back to the best chromatic number the search reaches, reported plainly.
* **Symmetry carries no colouring information.** A rotationally symmetric unit-distance graph need
  not be hard to colour — rotate any graph 180° about a distant point and union. Symmetry can
  **promote** a candidate and can never **reject** one. The orbit primitive makes this mistake
  easier to make, which is why it is written here.
* **Refutation cost is not monotone in graph size** (M07), and at five colours instances of the same
  size varied by two orders of magnitude (M12). "Smaller" is not "cheaper".

---

## 9. What landed

*Implementation, 2026-08-01, desktop. Written after the gate, against § 0's predictions.*

### 9.1 Lean — the argument both rungs share, as a theorem

`Proofs/HadwigerNelson/Forcer.lean`, zero `sorry`, axioms exactly `[propext, Classical.choice,
Quot.sound]` on every declaration (and `edgeHom` needs none at all).

| declaration | what it is |
|---|---|
| `Forces G k p q` | no proper `k`-colouring of `G` separates `p` from `q` — the search's win condition, named |
| `Forces.comap` | a forcer speaks about every graph it maps into; the only step that does work |
| `Forces.mono` | more edges only force more — the analogue of `Gadget.mono` |
| `Forces.map` | a symmetry carries a forced pair to a forced pair; **an endomorphism suffices** |
| `not_colorable_of_spindled_forcer` | **the closing lemma**, over any graph and any colour count |
| `Forces.of_edges` | a forcer by exhausting the colourings — `by decide +kernel` |
| `Forces.of_gadget` | a forcer from a SAT certificate, through the gadget algebra |
| `edgeHom`, `spindleEdges`, `spindleHomLeft/Right` | placements, and the spindle as a construction |
| `not_colorable_spindleEdges` | the form a search's output arrives in: no membership search anywhere |

**The payoff at spec scale**: `moserSpindle_not_colorable_three_spindled`, a **fourth** independent
route to rung A's witness, and the only one that never looks at all seven vertices — it decides a
four-vertex rhombus and places it twice.

`Proofs/HadwigerNelson/ForcerDiagnose.lean` says which side condition refused a candidate, with six
`#guard_msgs` pinning all four failure messages and the passing case.

### 9.2 Tools — the missing primitive, and the committed table made derived

`tools/construct.py` gained `Motion`, `motion_group`, `hex12`, `orbit`, `delete`, and `index_of`
(so a pivot is named by its coordinates, not by an index the previous move renumbered). Eight new
controls, each with a negative partner.

`tools/forcer.py` is new: `forces` (three outcomes, and the third is never folded into the second),
`backbone` (carrying `unknown` as a set), and `shrink` (claiming "irredundant" only after a
certifying single-point sweep). Fourteen controls.

**The result that matters for a reviewer**: `degrey_from_primitives()` rebuilds de Grey's 1581-point
graph from his 39 seed points by four moves and matches the committed coordinate table **point for
point in the exact field**, in 13 s. `scripts/regen-check.sh` asserts it. The committed table is now
*derived* data rather than transcribed data — "state the construction, not only the coordinates",
discharged.
