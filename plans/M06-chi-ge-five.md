# M06 — χ(ℝ²) ≥ 5

> The plane needs five colours: a kernel-checked proof that de Grey's 1581-vertex unit-distance
> graph has no 4-colouring, composed with M04's certified geometry. Terminal test:
> `chromaticNumber_plane_ge_five` green, zero `sorry`, axioms exactly
> `[propext, Classical.choice, Quot.sound]`, `lean4checker` re-check — **zero native purchases**.

*Subplanned 2026-07-29 on the desktop (32 cores, 125 GB), idle. Kernel timings are CPU seconds
(user + sys), minimum of three runs, baseline subtracted. Solver runs are single-threaded CaDiCaL
2.1.2 from the toolchain.*

---

## 0. What this subplan overturned — the planned route is dead, and a better one is real

Four measurements, each complete rather than projected. The first three kill the route every plan
since M03 assumed; the fourth replaces it with one that is **44× cheaper**.

### (a) The refutation of de Grey's graph is 115× larger than the spike claimed

`plans/spike-kernel-lrat.md` § 4 recorded the depth-5 colour-cube split at **1.30 × 10⁷ hint
entries** in total, and every cost estimate in the project since has rested on that number. It was
measured on a sample and extrapolated. Measured in full — all 1,024 cubes solved to UNSAT, 258 s
wall over 30 jobs, 99 minutes of processor time:

| depth-5 cube split, complete | |
|---|---|
| additions | 71,894,855 |
| **hint entries** | **3,060,367,937** |
| after backward trimming | 30,713,125 additions, **1,503,477,208 hint entries** (2.04×) |
| cubes needing real work | 576 of 1,024 |
| largest single cube | 27,823,805 trimmed hints, 597 MB of textual LRAT |
| derived clause length | p50 13, p90 44, p99 90, max 203, mean 19.4 |

The split's configuration is the spike's own: a unit triangle (vertices 0, 5, 10) pinned to colours
0, 1, 2 and the five highest-degree remaining vertices (791, 25, 26, 27, 28) as cube coordinates.

### (b) The checker is exactly as fast as M05 predicted — the problem was never the checker

Measured end to end on a **real** de Grey cube (15 pinned vertices, a 33,530-clause emitted table,
427 actions, 3,560 hint entries, 2.28 MB of Lean source), through `decide +kernel`:

| | CPU s | per unit |
|---|---|---|
| elaborate the emitted literals alone (baseline) | 11.4 | — |
| the kernel builds `coloringCNF 4 1581 deGrey.edges` from the edge list | 21.3 | 0.64 ms/clause |
| `agreesWithCNF` over 33,104 clauses | +114.6 | **3.46 ms per clause** |
| `maskCheck` over 3,560 hint entries | +4.8 | **1.35 ms per hint entry** |

M05 § 1 projected 1.5–2.5 ms per hint entry. The real figure is 1.35 ms. **Nothing about M05 was
wrong**; the milestone it was built for was mis-sized.

### (c) So the planned route costs 563 hours, and the native-evaluation fallback fails too

1.50 × 10⁹ trimmed hint entries × 1.35 ms = **563 hours of processor time**, against M05's stated
abandon threshold of 40 hours. Fourteen times over.

**And `native_decide` does not rescue it.** The fallback recorded in M05 § 8 — and the position this
project has held since M03, that χ(ℝ²) ≥ 5 would ship carrying one native-evaluation axiom per cube
— assumed the obstacle was trust. It is not: 1.5 × 10⁹ hint entries is **~4 GB of packed `Nat`
literals**, and the spike already measured that Lean will not elaborate certificate data at that
volume (§ 7b: 22 GB of `Array IntAction` "does not elaborate at all"; packing wins ~13×, which is
not enough). Compiled evaluation checks the same certificate the elaborator has to accept first.

**The wall is data volume, not trust.** That correction is the most important thing in this subplan,
because it means the route was never open, in either the kernel or the native form.

### (d) Everything obvious was tried, and the direction of every knob is now measured

| lever | result |
|---|---|
| **split deeper** | strictly worse: re-splitting the largest cube on one further unit triangle took 27,823,805 trimmed hints to **199,094,778** — **7.16× worse** for three more pinned vertices |
| **split shallower / monolithic** | six configurations (pinned/unpinned × ± at-most-one clauses × `--unsat`/default/`--plain`/`--sat`) — **none terminated**; each passed 1.5 GB of LRAT at ~2.9 M conflicts in 213 s |
| **add at-most-one-colour clauses** | no help; 42,575 clauses instead of 33,089 and the same runaway |
| **enlarge the point set** (trade cheap linear geometry for expensive refutation) | no help: adding `Y`, the mirror rotations, or `Sa ∪ Sb` adds vertices with **zero** crossing edges — average degree stays exactly 10.0, so the additions are disconnected copies |
| **split on the graph's own cut** (§ 1) | 1.97 × 10⁹ raw hints over 64 cubes — better than depth 5 by 1.6×, still 20× over budget |

### (e) The route that works: de Grey's own argument, recovered by measuring the graph

`deGrey.edges` is not an unstructured 7,877-edge list. It decomposes **exactly**:

```
G  =  Ya  ∪  Yb          two 791-vertex copies of Y, one per rotation about (−2,0)
      3938    3938       edges inside each copy
      shared vertex: 14  |Ya ∩ Yb| = 1
      crossing edge: 11 — 802     exactly one
                                  3938 + 3938 + 1 = 7877 ✓
```

and one level further down, `Y = Sa ∪ Sb`, two ~396-vertex copies sharing one vertex with 6 crossing
edges over 12 cut vertices.

**The forcing lemma, verified by SAT.** Pin vertex 14 to colour 0 in the half-graph `edgeGraph 1581
E_Ya` and ask for vertex 11:

| vertex 11's colour | 0 | 1 | 2 | 3 |
|---|---|---|---|---|
| half A (`E_Ya`, vertex 11) | **SAT** | UNSAT | UNSAT | UNSAT |
| half B (`E_Yb`, vertex 802) | **SAT** | UNSAT | UNSAT | UNSAT |

So *every* proper 4-colouring of either half gives its crossing-edge endpoint the same colour as the
shared vertex 14 — and 11–802 is an edge, so the two endpoints cannot agree. **That is the whole
proof of non-4-colourability**, and it is de Grey's own argument rather than a brute-force search.

It genuinely needs the 791-vertex layer: on the 395-vertex `Sa` layer all four pin combinations are
**satisfiable**, so the forcing does not appear one level down. Measured, not assumed.

## 1. The cost, and the kill criterion it now clears

Two refutations, one per half, each on a 17,335-clause formula. Configuration chosen by racing ten
CaDiCaL configurations and four seeds and taking the smallest **trimmed hint count** — `--sat
--seed=0` won both halves, at 1.39× better than `--unsat` on half A:

| | half A | half B | total |
|---|---|---|---|
| raw additions / hint entries | 430,112 / 25,699,681 | 423,530 / 24,641,353 | |
| **trimmed additions / hint entries** | 300,117 / **18,441,901** | 261,710 / **15,727,670** | **34,169,571** |
| derived clause length (max / mean) | 190 / 18.9 | 227 / — | |
| **kernel check at 1.35 ms/hint** | **6.9 h** | **5.9 h** | **12.8 h** |
| table agreement at 3.46 ms/clause | 60 s | 60 s | 2 min |
| certificate payload at 19-bit fields | 43.8 MB | 37.4 MB | 81 MB |
| clause table, per-chunk slot width | ~45 MB | ~40 MB | ~85 MB |

**12.8 hours of processor time, ~166 MB of artifact.** The threshold is 40 hours and the route is a
factor of three inside it, against 563 hours for the planned route — **44× cheaper**. Wall clock is
25–35 minutes on this machine, because § 2.4 checks one certificate in many parallel segments.

**Decision — take the structural route, not the cube split.** *Alternative:* the planned depth-5
colour-cube split, with the certificate volume attacked by a better checker. *Why this one:* the gap
is 14× and the per-hint cost is already within 1.3× of what the design can reach — a clause lookup
must unpack ~19 literals and that is the whole cost — so no checker improvement closes it, while the
structural route closes it with two certificates. *Confidence: high* — both halves' refutations are
in hand and the cost is measured, not projected.

## 2. The shape

```
                    chromaticNumber_plane_ge_five                  [Instances/DeGrey/Bound.lean]
                                │  M04's geometry, unchanged
                    ¬ Colorable 4 (edgeGraph 1581 deGrey.edges)
                                │  a proper 4-colouring C, normalised so C 14 = 0
        ┌───────────────────────┼────────────────────────┐
   C 11 = C 14              C 802 = C 14           11 — 802 is an edge
   [forcing, half A]        [forcing, half B]      so C 11 ≠ C 802 — contradiction
        │                        │
   3 colour cases,          3 colour cases,
   1 certificate            1 certificate         [HalfA/…, HalfB/… — generated]
   + colour symmetry        + colour symmetry
```

### 2.1 The edge list becomes a concatenation, and the geometry regenerates

The forcing lemmas are about the halves, and the contradiction is about the whole graph, so the
proof needs "every edge of half A is an edge of `deGrey`" — as a **`List` fact with no computation
in it**, because deciding `E_Ya ⊆ deGrey.edges` costs 3938 × 7877 pair comparisons in the kernel.

**Decision — `deGrey.edges` is defined as `halfAEdges ++ halfBEdges ++ [crossEdge]`**, with the
chunking aligned to the split so `deGreyChunks.flatten` still gives it by `rfl`. *Alternative:*
keep M04's edge order and prove the inclusion by `decide`. *Why this one:* with the concatenation,
inclusion is `List.subset_append_left` and its mirror — no kernel work at all — where `decide` over
3.1 × 10⁷ comparisons is minutes at best. *Confidence: high.* The cost is regenerating M04's
geometry (158 chunk theorems, ~7 minutes of kernel time, parallel across 16 modules); the *content*
of the geometry claim does not change, only the order in which the same 7,877 edges are listed.

This overrides the M06 stub's note "do not reorder `deGrey.edges` after M04": that note protected
LRAT clause ids against an edge reordering, and every certificate in this milestone is generated
after the reordering.

### 2.2 The clause table gets a per-chunk slot width

M05 § 2.5 chose one uniform slot width and recorded *medium* confidence: "if learned clauses turn
out to have a long tail, the per-chunk width goes in." They do — p50 19, p99 86, **max 227** — and
it does.

| half A's table | uniform slot width | per-chunk slot width |
|---|---|---|
| 317,452 clauses at 14-bit fields | 145 MB | **68 MB** at 256 clauses/chunk |

**Decision — the slot capacity moves from `ClauseTable` into each `Chunks.leaf`; `perChunk` stays
uniform.** *Alternative:* keep the uniform width and pay 2.1× the artifact. *Why this one:* a
2.1× artifact is the difference between a downloadable proof and an awkward one, and the change
costs one pair projection per lookup — nothing in M05 unfolds `ClauseTable.get`, so **no soundness
proof changes**, which is the whole point of having sealed it. Uniform `perChunk` is what keeps the
index arithmetic `id / perChunk` rather than a search. *Confidence: high — the sizes are measured
and the proof surface is unaffected by construction.*

### 2.3 No prefix lemma, no shared table, no 1024 modules

M05 § 7 carried a warning that re-checking `agreesWithCNF` per cube would cost 96 × 85 s ≈ 2.3
hours and would need a prefix lemma or a two-part table. The real figure was worse — the check is
per *cube*, so at depth 5 it is 1,024 × 136 s = **39 hours on its own** — and with the structural
route it evaporates: **two formulas, 60 s each.** The prefix lemma is not needed and is not built.

### 2.4 One certificate, checked in parallel segments

A single 18.4 M-hint certificate is 6.9 hours of kernel time, and a certificate is checked in
order, so on its own it is 6.9 hours of *wall* clock. But M05's checker already threads a
**watermark**, which is exactly the state that makes the check splittable: segment *k* proves an
*implication* between watermarks, so the segments elaborate independently and in parallel, and only
their composition is sequential.

M05 collapses the chunk loop straight to `Option CertFault`, which hides the watermark. The fix
generalises rather than duplicates:

```lean
/-- Run a certificate segment, reporting where the watermark got to. -/
def runSegment (t : ClauseTable) (decode : Nat → Option (List Action)) :
    Nat → List Nat → Outcome
```

`runStream` is then *defined* from `runSegment` and `runStream_sound` follows from
`runSegment_sound`, so M05's surface (`maskCheck`, `whyNot`, `maskCheck_sound`) is unchanged and one
of its two chunk-list inductions disappears.

**Decision — segments are `Justified → Justified` implications, one module each.** *Alternative:*
one module per half holding the whole certificate. *Why this one:* 6.9 hours of wall clock per half
against minutes per segment in parallel, and a segment that fails names its own watermark interval
instead of failing somewhere inside a six-hour reduction. *Confidence: high.*

**The segment size is set by memory, and the number was found the hard way.** Measured peak resident
size of one segment check:

| certificate chunks in the segment | peak RSS | kernel time |
|---|---|---|
| 57 (128 segments per half) | **49.5 GB** | 356 s |
| 7 (1024 segments per half) | 9.07 GB | 37 s |

so **peak ≈ 3.4 GB + 0.81 GB per chunk**, and time is linear in chunks. Twenty-four concurrent
57-chunk segments took the desktop down with an out-of-memory kill. The corrected shape: **6 chunks
per segment — 1222 segments for half A, 1043 for half B — twelve concurrent, ~8.3 GB each.** Wall
clock depends only on the job count, not the segment size, because the total kernel work is fixed:
13,590 chunks × 6.25 s ÷ 12 ≈ **2 hours**.

Where the memory goes: `unpackAux` builds one intermediate literal set per literal decoded, and the
kernel retains every intermediate in a segment's reduction. At ~19 literals per clause and ~2,500
hints per chunk that is the 0.81 GB. It is not the certificate's size and not the table's.

**The composition is a flat `<|` chain, and the watermarks are checked by the elaborator.** Segment
*k* concludes at the watermark segment *k+1* assumes, so a miscounted addition anywhere in the
emitter is a type error naming the two segments that disagree — there is no arithmetic in the
generated composition that can be wrong quietly. Written as a right-associative chain rather than a
1222-deep parenthesis nest so that error is readable.

**And the two descent shapes in this project are genuinely different.** The geometry cites 45
independent chunk theorems through `List.forall_iff_forall_mem.mp` on a tuple; the certificate chains
2,265 dependent segment implications. `Sat/Encoding.lean` states a preference for one shape for "the
big obligation is the conjunction of generated small ones" — there are **two**, and which applies is
decided by whether the small obligations are independent. An unordered conjunction cannot express the
chain (segment *k*'s statement mentions a watermark that depends on every earlier segment), and the
chain cannot express the conjunction without inventing an order.

### 2.5 Colour symmetry, at last, and only the part that is needed

Three of the four colour cases per half are the same instance up to relabelling, so one certificate
covers all three. This is the colour-permutation reduction the roadmap deferred to M09 — but only
its easy half: **relabel colours by a bijection of `Fin 4`**, no clique and no triangle.

```lean
theorem exists_perm_apply_eq (a b : Fin k) : ∃ σ : Equiv.Perm (Fin k), σ a = b
```
plus the observation that composing a proper colouring with an injection is a proper colouring.

**Decision — normalise by permutation at the top and case-split on three colours.**
*Alternative:* emit three certificates per half (six in all), no symmetry argument. *Why this one:*
6.9 h → 2.3 h saved per half, 25.6 h → 12.8 h in total, for perhaps 40 lines. *Confidence: high.*

**Decision — do NOT use the two halves' geometric isomorphism.** *Alternative:* emit one
certificate and transport it to the other half along the rotation that maps `Ya` to `Yb`, halving
the artifact again. *Why this one:* it needs a vertex permutation as emitted data, a graph-iso
transport lemma, and the edge list defined as the image of half A's — three new things on the
critical path to save 5.9 hours of a 12.8-hour budget that is already inside the threshold.
*Confidence: medium — if the artifact size becomes the binding constraint, this is the first thing
to add, and it is worth 2×.*

## 3. The statements

The whole milestone is these, in dependency order. Every one is stated before any is proved.

### 3.1 `Sat/MaskCheck.lean` — segmented checking

```lean
def runSegment (t : ClauseTable) (decode : Nat → Option (List Action)) :
    Nat → List Nat → Outcome

theorem runSegment_sound {t : ClauseTable} {f : CNF Nat} {w : Nat} {cert : List Nat}
    (decode : Nat → Option (List Action)) (hJ : Justified t f w) :
    (runSegment t decode w cert).Sound t f

/-- A segment advances the watermark. The table, field width, segment and target watermark are all
explicit: nothing determines them, and a generated module must not name arguments. -/
theorem justified_of_segment {f : CNF Nat} (t : ClauseTable) (fw w : Nat) (seg : List Nat)
    (w' : Nat) (hJ : Justified t f w)
    (h : runSegment t (decodeChunk fw) w seg = .more w') : Justified t f w'

/-- The last segment derives the empty clause. -/
theorem unsat_of_segment {f : CNF Nat} (t : ClauseTable) (fw w : Nat) (seg : List Nat)
    (hJ : Justified t f w) (h : runSegment t (decodeChunk fw) w seg = .done) : f.Unsat
```

### 3.2 `Sat/ClauseTable.lean` — per-chunk slot width

```lean
inductive Chunks where
  | leaf : Nat → Nat → Chunks          -- this chunk's slot capacity, and its packed data
  | node : Nat → Chunks → Chunks → Chunks

def Chunks.get : Chunks → Nat → Nat × Nat        -- (slot capacity, chunk word)

def ClauseTable.get (t : ClauseTable) (id : Nat) : LitSet
```
`ClauseTable` loses its `lits` field. `slotBits` becomes a function of the chunk. No theorem
statement in the file changes.

### 3.3 `Sat/Encoding.lean` — colour symmetry and the pinned bridge

```lean
/-- Relabelling colours by any injection sends proper colourings to proper colourings. -/
theorem valid_comp_of_injective {G : SimpleGraph (Fin n)} {f : Fin n → Fin k}
    (hf : ∀ i j, G.Adj i j → f i ≠ f j) {σ : Fin k → Fin k} (hσ : Function.Injective σ) :
    ∀ i j, G.Adj i j → σ (f i) ≠ σ (f j)

/-- Some permutation of the colours sends `a` to `b`. -/
theorem exists_perm_apply_eq (a b : Fin k) : ∃ σ : Equiv.Perm (Fin k), σ a = b

/-- **The bridge from a refuted cube to a colouring that cannot exist.** A proper colouring of the
graph, together with unsatisfiability of the formula pinned to the cube *that colouring induces*,
is a contradiction. -/
theorem not_pinned {E : List (Fin n × Fin n)} (W : List (Fin n)) (f : Fin n → Fin k)
    (hf : ∀ i j, (edgeGraph n E).Adj i j → f i ≠ f j)
    (h : (coloringCNF k n E ++ cubeCNF k n (cubeOf W f)).Unsat) (hk : 0 < k := by norm_num) : False

/-- An edge-list graph is monotone in its list. -/
theorem edgeGraph_mono {E₁ E₂ : List (Fin n × Fin n)} (h : E₁ ⊆ E₂) :
    edgeGraph n E₁ ≤ edgeGraph n E₂
```

### 3.4 `Instances/DeGrey/Split.lean` — the decomposition as data

```lean
def deGreyHalfAEdges : List (Fin 1581 × Fin 1581)     -- 3938 edges inside Ya
def deGreyHalfBEdges : List (Fin 1581 × Fin 1581)     -- 3938 edges inside Yb
def deGreyCrossEdge  : List (Fin 1581 × Fin 1581)     -- [(11, 802)]

theorem deGrey_edges_split :
    deGrey.edges = deGreyHalfAEdges ++ deGreyHalfBEdges ++ deGreyCrossEdge := rfl
```

### 3.5 `Instances/DeGrey/Forcing.lean` — the two lemmas the certificates buy

```lean
/-- **Half A forces its endpoint.** In every proper 4-colouring of the half graph, vertex 11 takes
vertex 14's colour. One certificate plus colour symmetry covers all three failing cases. -/
theorem halfA_forces (f : Fin 1581 → Fin 4)
    (hf : ∀ i j, (edgeGraph 1581 deGreyHalfAEdges).Adj i j → f i ≠ f j) :
    f 11 = f 14

theorem halfB_forces (f : Fin 1581 → Fin 4)
    (hf : ∀ i j, (edgeGraph 1581 deGreyHalfBEdges).Adj i j → f i ≠ f j) :
    f 802 = f 14
```

### 3.6 `Instances/DeGrey/Bound.lean` — the headline

```lean
/-- **de Grey's graph has no 4-colouring.** The two halves each force their crossing-edge endpoint
to the shared vertex's colour, and the crossing edge forbids that. -/
theorem deGrey_not_colorable_four : ¬ (edgeGraph 1581 deGrey.edges).Colorable 4

/-- **χ(ℝ²) ≥ 5.** The plane needs five colours: no assignment of four colours to the points of the
plane avoids giving two points at distance exactly 1 the same colour. -/
theorem chromaticNumber_plane_ge_five :
    5 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  deGrey_bound_of_not_colorable deGrey_not_colorable_four
```

The last line is M04's hand-off, consumed unchanged. That it is one citation is the readout on
M01–M05.

## 4. The generated data, and the emitter

`tools/emit_mask.py`, new and untrusted, takes the base formula (printed by Lean), the cube, and a
raw LRAT certificate, and emits per half:

| module | what |
|---|---|
| `HalfA/Table00…15.lean` | the clause table in 16 subtrees, ~3 MB of source each — the size M04 proved workable at 2.4 MB / 3.8 GB |
| `HalfA/Table.lean` | the 16 subtrees joined by a `Chunks` spine, plus `agreesWithCNF` by `decide +kernel` |
| `HalfA/Seg000…127.lean` | one certificate segment each: its chunks, and `Justified → Justified` by `decide +kernel` |
| `HalfA/Cert.lean` | the 128 segments composed; ends in `f.Unsat` |

**Decision — the table is split across modules and joined by a `Chunks` spine.** *Alternative:* one
module per table. *Why this one:* M04 measured a 2.4 MB table literal at 3.8 GB of elaboration
memory, and 45 MB in one module extrapolates to ~70 GB — inside this machine's 125 GB but with no
parallelism and no margin. Sixteen subtrees elaborate concurrently, and the kernel pays one delta
step per subtree during descent. *Confidence: medium — if the extrapolation is wrong in the other
direction, the split costs nothing; if 3 MB modules are still too big, split further.*

The emitter's contract is M05's table in `Sat/MaskCheck.lean`, unchanged, plus two rows:

| the emitter must | or you get |
|---|---|
| backward-trim from the empty clause, so every kept clause is reachable | (nothing: an untrimmed certificate is merely 2× slower) |
| give each `Chunks.leaf` a slot capacity at least the longest clause in it | `TableFault.slotMismatch` |

## 4.5 What implementation cost, and what it corrected

*Written 2026-07-30, during the run.*

**The workflow ran out of order, and that is worth recording before anything else.** WORKFLOW puts the
three modeling passes between the subplan and the implementation. Here the measurements *were* the
milestone's hard part — five hours of solving, trimming and kernel timing — and I went from subplan
straight to code, then ran the passes afterwards with 22 hours of kernel checking already in flight.
Each pass still found something (below), but two of the findings could only be recorded, and one had to
be applied mid-run at the cost of invalidating everything built so far. The order is a real
constraint, not ceremony.

**Six things the subplan did not anticipate:**

| what | why it was missed |
|---|---|
| a segment check peaks at **49.5 GB** | the subplan sized segments by *time* (~3 min each) and never asked what one costs in memory. Twenty-four concurrent took the desktop down. Peak = 3.4 GB + 0.81 GB per certificate chunk — `unpackAux`'s intermediate literal sets, which the kernel retains for a whole reduction |
| the decoder needs `maxRecDepth` ~10⁶ | it peels one field per reduction step and a chunk holds ~2,600. Without it a segment runs 149 s and dies with a message too large to print |
| the per-hint cost is **2.36 ms**, not 1.35 ms | 1.35 ms was measured on a 33,530-clause table with a depth-8 chunk tree; the real tables are 317,451 clauses and depth 13. The total moved from 12.8 h to ~23 h — still inside the threshold |
| `agreesWithCNF` needs the *unpinned* formula as input | the emitter was handed the solved instance, whose clause count already includes the cube, and double-counted it by two. Caught by `halfA_size` failing, not by review |
| editing anything upstream of the generated modules invalidates all 2,265 | obvious in hindsight; it cost one restart, and it is why the experience pass had to run before the build rather than during it |
| M04's `#guard` on the chunk count | the split needs 179 edges per chunk (3938 = 22 × 179), not 50, so `deGreyChunks.length` moved from 158 to 45 |

**What each modeling pass found**, all three run after implementation:

* **Domain.** The gluing is the *construction's* structure, not the proof's: the argument consumes
  three list inclusions and nothing else, so there is no glued-graph type and the vertex-sharing counts
  are spec rather than model. That inverted into the milestone's best extraction —
  `not_colorable_of_forcing` over an arbitrary graph, which makes the headline one citation. Also: M03's
  reason for a lax `Cube` type had silently stopped applying, and Mathlib already has colour relabelling
  (`SimpleGraph.recolorOfEmbedding`), found by grep rather than recalled.
* **Obligation.** The two segment corollaries are the elimination rules for a non-invertible motive, not
  duplication. The 2,265-deep composition is not a hand-written fold — a list of *declarations* is not a
  Lean value — and its watermarks are checked by the elaborator, which is the guarantee worth stating.
  Found a **false justification in my own comment** about the joining edge. And: this project has two
  descent shapes, not one, and neither can express the other.
* **Experience.** A build-fault table, because M06's faults are build faults that no `CertFault` covers —
  including the one I needed myself, that a failed segment is diagnosed by `#eval` of the same
  expression. `runSegment` renamed `runSegment` so the code and the theorems share one vocabulary.

**And a negative control falsified a claim I had made twice.** I wrote, in a docstring and in a commit
message, that a degenerate cube makes the pinned formula trivially unsatisfiable. It does not — the
encoding has no at-most-one-colour clauses, so `[(u,0),(u,1)]` asks for two different variables to be
true. Now committed as a theorem that it is *satisfiable*. This is the second milestone running where
writing the control corrected the prose it was checking.

## 5. Negative controls — every check watched to fail

| control | must fail with |
|---|---|
| one clause slot in a table corrupted | `TableFault.slotMismatch` naming the id and both values |
| a segment's target watermark off by one | `decide +kernel` fails in that segment, naming it |
| two segments swapped | the second segment's `decide` fails; the composition does not typecheck |
| half A's certificate filed against half B's formula | `agreesWithCNF` false, `firstFault` naming the id |
| the crossing edge deleted from `deGreyCrossEdge` | `deGrey_not_colorable_four` fails — the last step has nothing to contradict |
| the forcing lemma stated at vertex 12 instead of 11 | the final contradiction does not close |
| a **satisfiable** pin (vertex 11 at vertex 14's own colour, the SAT row of § 0(e)) handed the same table | no certificate checks; recorded as a `#eval` of `whyNot` |
| colour symmetry applied with a non-injective relabelling | `valid_comp_of_injective` does not apply — the hypothesis is the guard |

The seventh is the one that matters: the SAT row of the forcing table is the reason the lemma is
`f 11 = f 14` and not something stronger, and it is the control that shows the checker cannot
certify what is false.

## 6. Measured, do not re-derive

* de Grey's formula: `coloringCNF 4 1581 deGrey.edges` = **33,089 clauses, 6,324 variables**; each
  half formula is **17,335 clauses**.
* **1.35 ms per hint entry, 3.46 ms per clause of table agreement, 0.64 ms per clause to build the
  formula** — kernel, desktop, measured on real data (§ 0(b)).
* Deeper cube splits are worse by **7.16× per three pinned vertices**; monolithic does not finish;
  at-most-one clauses do not help; enlarging the point set adds disconnected components.
* CaDiCaL configuration matters and **raw file size does not predict trimmed hint count**:
  `--satplain` gave a smaller file than `--sat --seed=0` on half A (226.0 MB vs 229.9 MB) and 31%
  *more* trimmed hints (24.2 M vs 18.4 M). Select on trimmed hints.
* Backward trimming: **2.0×** on the big cube certificates, **1.4×** on the half certificates, up to
  **20×** on deeply pinned ones.
* The structure: shared vertex **14**, crossing edge **11–802**, halves of **791** vertices and
  **3,938** edges each; `Y = Sa ∪ Sb` shares one vertex with **6** crossing edges over 12 cut
  vertices; the forcing does **not** hold on the `Sa` layer.

## 7. Unmeasured, ranked by what it would move

1. **Racing more solver configurations on trimmed hint count.** The first race moved half A by
   1.39×; it was ten configurations and four seeds chosen by hand. Straight multiplier on the
   12.8-hour total, and each run is ~4 minutes.
2. **The halves' geometric isomorphism** (§ 2.5) — worth exactly 2× on both time and artifact.
3. **Whether the `Sa`/`Sb` interface gives a cheaper decomposition than the `Ya`/`Yb` one.** The
   interface is 13 vertices rather than 2, so the case analysis is larger, but the primitive
   refutations would be on 396-vertex graphs. This is M09's question arriving early.
4. **The 128-segment split point.** Chosen for ~3 minutes per segment; unswept.
5. **Chunk-size sweep** for tables and certificates, worth ~10% as at M05.

## 8. Fallbacks

* If the colour-symmetry argument resists, emit three certificates per half: 25.6 hours instead of
  12.8, still inside the threshold. Costs time, not the milestone.
* If a 3 MB table module will not elaborate, split further — the `Chunks` spine takes any fan-out.
* **There is no `native_decide` fallback and there never was** (§ 0(c)). If the structural route
  fails, rung B does not ship, and that is what gets reported.
