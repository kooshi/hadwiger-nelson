# M04 — de Grey's graph as certified data

> **Terminal test.** `deGrey.Valid = true` — every one of de Grey's 7877 claimed edges has exact
> squared distance `768²` in `ℚ(√3,√5,√7,√11)`, kernel-checked — plus `deGrey_unit_distances`, the
> same fact restated in the plane, and the data-shape guards (1581 vertices, 7877 distinct edges,
> no isolated vertex) that stop a vacuously-satisfied `Valid` from passing for a certificate.

M04 is **geometry only**. Non-4-colourability is M05, and this milestone deliberately does not
claim it: the hand-off is `deGrey_bound_of_not_colorable`, which states `χ(ℝ²) ≥ 5` with exactly
one hypothesis left open.

---

## 1. What the measurements said

Everything below is measured on the real de Grey data (1581 vertices, 7877 edges, denominator 768),
real files, toolchain v4.32.0, this machine (12 cores, 31 GB, ~20 GB free). Peak RSS by polling
`VmHWM`; wall clock for one `lean` process.

### The vertex table is the whole cost, and `![…]` is the wrong shape for it

| vertex table | 50 lowest-index edges | 50 highest-index edges |
|---|---|---|
| `![p₀, …, p₁₅₈₀]` (`Fin.cons`, 1581 deep) | 5.5 s | **15.9 s** |
| `PtTable` (range split at a pivot) | 4.5 s | **4.8 s** |

A `![…]` literal makes `verts i` walk `i` constructors, so the check costs *more for later
vertices*. On a uniform sample of 100 edges — mean endpoint sum 1539, against 1565 for the whole
list, so the sample is representative:

| vertex table | 100 uniform edges | per edge | peak |
|---|---|---|---|
| `![…]` | 23.5 s | **0.218 s** | 5.62 GB |
| `PtTable` | 8.1–8.6 s | **0.066 s** | 3.56 GB |

Projected over 7877 edges: **29 minutes of kernel time versus 9**, at 2 GB less peak — and, the part
that matters more for scheduling, every chunk now costs the same, so a parallel build is balanced
instead of 4:1 skewed.

### `decide` evaluates everything twice; `decide +kernel` does not

| | 50 edges | 250 edges |
|---|---|---|
| `by decide` | 13.4 s | **fails — `maxHeartbeats`** |
| `by decide +kernel` | 5.8 s | 23.3 s |

Plain `decide` reduces the `Decidable` instance in the elaborator and then again in the kernel. At
50 edges that is a 2.3× tax; at 250 it exhausts the heartbeat budget outright. This is not an
optimisation, it is what makes a chunk of useful size possible without disabling a safety net.

### Many small theorems beat one large one, on memory

Same 250 edges, same module:

| | wall | peak |
|---|---|---|
| one 250-edge `ValidOn` | 23.3 s | **5.28 GB** |
| five 50-edge `ValidOn`s | 21.2 s | **3.74 GB** |
| ten 50-edge `ValidOn`s (500 edges) | 39.3 s | 4.10 GB |
| twenty 50-edge `ValidOn`s (1000 edges) | 55.2 s | 4.50 GB |

Each `decide +kernel` reduction is transient; only the (tiny) proof term survives. So peak memory
tracks the *chunk*, not the module: ~1.8 MB per edge accumulated versus ~10 MB per edge held. Lower
peak buys more parallel `lean` processes, which is the actual wall-clock lever.

### The remaining fixed costs

| | wall | peak | note |
|---|---|---|---|
| baseline: importing the Mathlib chain | 1.5–1.7 s | 2.74 GB | irreducible; `Real.sqrt` pulls it in |
| defining the table (1581 points) | 32 s | 3.75 GB | needs `maxRecDepth 100000`, `maxHeartbeats 2000000` |
| defining 158 chunk lists + the certificate | 11 s | 3.22 GB | |
| the gluing theorem over 158 chunks | 2.0 s | 2.82 GB | measured with the leaves sorried |

Splitting `Certificate.lean` to shrink the 2.74 GB baseline was measured and rejected: importing
only the field tower instead of the full geometry saves 230 MB, not enough to change the parallel
job count.

**Projected total: ~7 minutes of kernel work across 16 modules, ~3.7 GB each, `-j5` safe → roughly
2 minutes wall clock.** Against the naive shape (`![…]` + plain `decide`): ~58 minutes at 5.6 GB per
module, if it completed at all.

---

## 2. The shape

```
Certificate.lean                    PtTable, PtTable.get, PtTable.toVerts     ← hand-written
Instances/DeGrey/Table.lean         deGreyTable : PtTable                     ← generated (487 KB)
Instances/DeGrey/Edges.lean         deGreyChunk000…157, deGreyChunks, deGrey  ← generated (107 KB)
Instances/DeGrey/Geom00…15.lean     158 chunk theorems, 10 per module         ← generated
Instances/DeGrey/Valid.lean         deGrey_valid, by valid_of_chunks          ← generated
Instances/DeGrey.lean               the claims, the guards, the hand-off      ← hand-written
```

Generated files hold data and mechanical proofs; the hand-written file holds every claim a human
makes. `tools/emit_cert.py` emits either one module (`--out`, for the spindle) or this directory
(`--dir`), and `--skeleton` swaps every geometry proof for `sorry`.

**The skeleton is committed and green:** 3178 jobs, `sorry` at exactly the 158 geometry leaves and
nowhere else. Implementation is `emit_cert.py` without `--skeleton`.

### The specification validated itself before the kernel time was spent

Every `#guard` in `Instances/DeGrey.lean` runs compiled, so all of these already pass with the
geometry still sorried:

* 7877 edges, all distinct, all `i < j`, 158 chunks, 1581 vertices with none left out, denominator
  768;
* **`deGrey.badEdges.isEmpty`** — the same unit-distance predicate the kernel will check, evaluated
  by the *compiler* instead. The data is already known good; the 158 kernel reductions are there to
  make it a theorem rather than a test;
* two negative controls — move vertex 0 to the origin and the check must fail, naming only edges at
  that vertex.

---

## 3. Decisions

| # | Choice | Alternative weighed | Why this one | Confidence |
|---|---|---|---|---|
| 1 | Vertex table as `PtTable`, a range split at a stored pivot | Keep `![…]` and raise the limits | 3.3× faster on a representative sample, 2 GB lower peak, and lookup cost stops depending on the vertex index — so chunks cost the same and the parallel schedule is balanced | **High** — both measured on the same data and file shape |
| 2 | Pivot split, not a bit-trie on the index | Perfect binary trie, padded to 2048 leaves | Within 6% on lookup (8.6 s vs 8.1 s per 100 edges — one run each, inside noise), but the trie needs 467 junk padding leaves: 21% more source, and a junk value where the model has none | **Medium** — if a later measurement shows the 6% is real and not noise, 40 s over the full run is the price of dropping the padding, and I would still pay it |
| 3 | `by decide +kernel` everywhere | `by decide` with `maxHeartbeats 0` | Plain `decide` reduces twice and *fails outright* at 250 edges; `+kernel` needs no `set_option` at all | **High** |
| 4 | 50 edges per theorem, 10 theorems per module, 16 modules | One `ValidOn` per module over 250–500 edges | Peak memory tracks the chunk, not the module: 3.74 GB versus 5.28 GB for the same 250 edges. Lower peak → more parallel jobs → shorter wall clock | **Medium** — the 1.8 MB/edge accumulation figure comes from a 1000-edge run and every module here is under 1000. If one overruns, split it further; the shape does not change |
| 5 | The edge list is *defined as* the chunks flattened | Emit `deGreyEdges` separately and prove the join by `rfl` | Removes 90 KB of duplicated literals, makes `valid_of_chunks`' join hypothesis syntactically `rfl` (glue measured at 2.0 s over 158 chunks), and makes drift between the certificate and its chunking impossible. `flatten` preserves order, which M03 requires | **High** — `#guard deGrey.edges.length = 7877` passes |
| 6 | One emitter code path: the spindle moves onto `PtTable` too | Threshold — table above N vertices, `![…]` below | With two paths the tested one is the small one and the one that matters is untested. With one, the spindle's instant `decide` is a live regression test of the table. Its edge list, CNF, and M03 certificates are untouched | **High** — full build green after regenerating |
| 7 | `PtTable` lives in `Certificate.lean` | Its own module | Twelve lines with no consumer independent of `UDCert`. A module for it is structure the problem did not ask for | **High** |
| 8 | The table gets no lemmas and no correctness theorem | Prove `deGreyTable.get i` is the intended point | There is nothing to prove: a certificate never claims provenance, it claims geometry. A wrong table makes `Valid` false, never a theorem false | **High** |
| 9 | M04 stops at geometry; the bound is stated with its colouring hypothesis open | Push M05's colouring work forward and land `χ(ℝ²) ≥ 5` here | A file that read as finished would misreport where the ratchet stands. `deGrey_bound_of_not_colorable` names the one remaining obligation in its signature | **High** |

### A count in the terminal test that Lean cannot check

`ARCHITECTURE.md` records the terminal test as "vertex/edge counts match the paper (397 / 1581 /
7877)". Lean guards **1581 and 7877**. The **397** is the size of an intermediate set in de Grey's
construction; it never reaches Lean, and it is checked by `tools/degrey.py`'s own output. That is
recorded plainly in `Instances/DeGrey.lean` rather than papered over: the certificate claims
geometry, not provenance, and a bound proved from *some* 1581-point unit-distance graph is a bound
on the plane whoever first drew it.

---

## 4. Domain-modeling pass

**Measurement correction first.** § 1's figures were wall clock, taken while another project on this
machine was saturating all 12 cores. Re-measured as **CPU seconds (user + sys), minimum of three
runs**, they hold: `![…]` **0.219 s/edge** against `PtTable` **0.059 s/edge**, baseline 1.6–1.8 s.
Read every projection in § 1 as CPU seconds. All figures below use the corrected method.

### The one change the pass forced: squared distance is a sum of *squares*

`Pt.distSq` was written `(p.x - q.x) * (p.x - q.x) + (p.y - q.y) * (p.y - q.y)`. The kernel cannot
see that the two factors are the same term, so it ran the general product — and in a quadratic
extension the general product is genuinely more expensive than a square:

| | sub-products per level | leaf multiplications per `Q4` operation |
|---|---|---|
| `(a + b√d)(c + e√d)` | 4 | 256 |
| `(a + b√d)²` | 3 | 136 |

So the definition was asking the kernel to pay for a generality the expression never had. `FastSq`
is the fix — a class carrying a fast squaring together with the proof that it agrees with the
product, which is the *second* member of the family `NatScalar` already started in the same file for
the same reason. Measured in situ against the real certificate, 400 edges, minimum of three:

| `Pt.distSq` spelled as | per edge | full 7877 edges |
|---|---|---|
| `x * x` | 0.0625 s | 492 s |
| `FastSq.sq x` | **0.0453 s** | **357 s** |

The 1.38× matches the 512→272 leaf-multiplication prediction, which is the reason to believe it is
structural rather than a lucky run.

### The other four questions, and why nothing else moved

**The pivot is memoization, not redundancy.** `node m l r`'s `m` is `l`'s leaf count and *is*
recoverable from `l` — but recovering it costs a traversal per lookup, which is the whole structure
thrown away. Storing it makes illegal states (pivot ≠ subtree size) representable, and that turns
out to be harmless for a reason worth stating precisely, because the pass established it rather than
assumed it: the reduction pulls a colouring **back** along the vertex map, so it needs neither
injectivity nor any correctness property of the table. *Any* map `Fin n → Pt` whose listed pairs
check out yields a true bound. A wrong table makes `Valid` false; it cannot make a theorem false.

Indexing the table by its size — `PtTable : ℕ → Type` with `node : PtTable a → PtTable b →
PtTable (a + b)` and `get : PtTable n → Fin n → Pt` — would make the junk unrepresentable and the
truncating `Nat` subtraction total-by-discharge. **Rejected**: it taxes every context that mentions
the type with an index no consumer inspects, and it buys protection against a failure mode the
soundness argument already makes impossible. Extrinsic placement, per the rule.

**`toVerts {n}` correctly discards the bound** — the table inspects `n` nowhere.

**The chunking is incidental structure, correctly kept out of the type.** The test: if the memory
budget changed tomorrow, what would move? Only the generated term (`edges := [one big literal]`). No
type, no theorem, no consumer. That is exactly the mark of incidental structure that belongs in the
term, and the type — a flat `List (Fin n × Fin n)` — stays the honest image of what an edge list is.

**Chunk lists stay `List (Fin n × Fin n)`.** Grouping by source vertex (`List (Fin n × List (Fin n))`)
would cut lookups from 2 per edge to ~1.2, worth roughly 45 s. **Rejected**: it makes the flat edge
list derived rather than primary, and M05's certificates index edges by position.

**The representation earns the next lemma.** M06 (shrinking) will want "a sublist of a valid edge
list is valid". It states in one line from `validOn_iff`, in the existing vocabulary, with no
restatement — which is the convergence signal this pass looks for.

| # | Choice | Alternative weighed | Why this one | Confidence |
|---|---|---|---|---|
| 10 | `Pt.distSq` uses a fast squaring (`FastSq`) | Leave `x * x` — 2.5 minutes is not a bottleneck | The definition is a sum of squares and was not saying so; the speed follows from the faithfulness. 1.38× measured, matching the leaf-count prediction, and it compounds through M06's repeated re-verification | **High** on the number (measured in situ, min of 3, theory-confirmed); **medium** on whether ~25 lines was worth 2.5 minutes — if M06 turns out not to re-verify geometry repeatedly, this was a thin win |
| 11 | The vertex table keeps its junk value out of range | Index `PtTable` by its size so the index arithmetic discharges the bound | The soundness argument needs nothing at all from the table, so the index would protect against an impossible failure while taxing every context that mentions the type | **High** — established by reading the reduction, not assumed |

## 5. Carried forward

### From M02 (superseded where noted)

* ~~"All 7877 edges in one `decide` would want ~95 GB; plan ~32 chunks of ~250 edges, ~3 GB each."~~
  **Superseded** — measured against `decide +kernel` and `PtTable`, the shape is 158 chunks of 50 in
  16 modules at ~3.7 GB. The 0.16 s/edge figure was `![…]` plus plain `decide` on low-index edges;
  the honest number for that combination on a representative sample is 0.44 s/edge.
* ~~"The fixed cost is the vertex table elaborating … so the table gets its own module."~~ **Still
  right, and confirmed**: 32 s and 3.75 GB, paid once.
* Routing arithmetic through Mathlib's hierarchy still costs nothing, provided `Adjoin` keeps
  exactly one arithmetic instance.
* `CLAUDE.md` says this machine has 32 cores. It has **12**. Parallelism is capped by memory at ~5
  concurrent `lean` processes anyway.

### To M05

* **Do not reorder the edge list.** M05's certificates will index clauses by edge position.
  `deGrey.edges` is `deGreyChunks.flatten`, so reordering *chunks* reorders edges too.
* `deGrey_bound_of_not_colorable` is the entry point: prove
  `¬ (edgeGraph 1581 deGrey.edges).Colorable 4` and the bound follows.
* M03's cube machinery (`allCubes`, `cubeCNF`, `not_colorable_of_cubes`, `badCubes`) is ready and
  unused. The open question it left — which vertex set `W` to split on — is M05's.
* The DIMACS emitter (`scripts/Dimacs.lean`) reads `deGrey.edges` through compiled evaluation, so the
  `flatten` presentation costs it nothing.
