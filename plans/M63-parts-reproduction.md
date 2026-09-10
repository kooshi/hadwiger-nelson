# M63 — reproduce `[Parts2020a]`'s minimization algorithm, end to end

*Opened 2026-09-10 on Kooshi's direction: **"the next session will be 100% repro of his algo. The
session after that will be introducing our new angle on it, as described in the stub."** The stub
holding the new angle is `plans/M62-evolutionary-type-m.md`, which stays OPEN and resumes after
this. The handoff that minted this milestone is `plans/STUB-parts-reproduction.md` (FS-33, rank 1);
this file supersedes it and records where its frame was wrong.*

---

## §0 — The product, in one sentence

**Not** *"we can produce his numbers"* — that is a fit, and it is reachable by tuning a dozen free
choices toward published answers one plausible adjustment at a time. The product is:

> **we know why a descent cannot reach the record, we own the loop that can, and it works on a
> problem he did not publish the answer to.**

The measured reason this milestone exists: nine certified 1-minimal descents on our own arena land
at **582–609** with the record **509** eleven standard deviations below their mean, and
`[Parts2020a]` §5.8 names the mechanism in print — **overcompression**, *"the minimal asymmetric
graph is usually not a subgraph of the minimal symmetric graph"*. A descent produces **one**
minimum; his loop's state variable is **`A = ⋃{M}`, the union of ALL minima at the current size**,
and without the whole set there is nothing to carry between iterations and the loop degenerates
into exactly the descent that provably cannot arrive.

---

## §PA — Prior-art gate (WORKFLOW step 3a)

The prior art *is* the object: this milestone reproduces one named paper. The gate therefore runs
inward, and what it found is a reading debt, not a missing citation.

**Read on 2026-09-10, first time:** `[Parts2020a]` §5.1, §5.2, §5.3, §5.4, §5.9, §5.10, §5.11, §6
in full, and Tables 1–7. Added to the §5.4–§5.8 read of the day before. `BIBLIOGRAPHY.md` now
carries per-section markers; **do not write another whole-paper `READ`** — that marker has been
wrong three times on this file (`G50`).

**Still unread and named so it is not lost:** nothing in §§1–7. §8 is acknowledgements. Figures 1–7
are images and have not been examined pixel-wise; Figure 1 is load-bearing for the M6A/M6B/M6C
distinction and its content is recovered from §4's text instead.

**What the gate bought, which is why it is not a formality:**

- **Reference [11] resolves and the data is live.** *"Comments in Polymath16, thread 15, comment
  24942 … see also Polymath16/Code and data/This dropbox folder/JP/Large"* — the folder is
  published on the Polymath wiki's *Hadwiger-Nelson problem* page (recovered through the Internet
  Archive) and is still served by Dropbox. **43 `.vtx` files**, exact Mathematica radicals, one
  vertex per line, plus `graphs.txt` — his own index against Table 1. Held at
  `data/m62/parts-ref11/`, provenance and checksums beside them. **This is the whole milestone's
  test harness and it changes the plan** (§3).
- **His coordinate convention, verbatim** (`JP/Pink/readme.txt`): `(a + sqrt(33)*b)/12 = x`,
  `(sqrt(3)*c + sqrt(11)*d)/12 = y` — identical to ours, so his orbit labels and ours are the same
  objects and not a coincidence of notation.
- **Two disputed rows of Table 1 settled from his own index**, closing the parenthetical the
  consolidation left open in ledger row 59: the 214-vertex non-mono-pair is at **distance 3**
  (`(±3/2, 0)`), not `√3`, and the 312-vertex one is at **1/3** (`(±1/6, 0)`), not `1/√3`. The
  valuation law's prediction is unchanged either way — `v_𝔭` is 0 for all four — which is why the
  ambiguity was survivable, but the record should now say which.

---

## §1 — What was verified before any of this was designed

Every convention this milestone rests on is a guess until it is checked against data we did not
choose. All of the following ran on 2026-09-10 and are the self-test of `tools/parts_repro.py`
(`python3 tools/parts_repro.py`, ~25 s, prints every comparison, exits non-zero on any failure).

**The base, the group, the labels.** `typem.parts_lattice(2.6)` gives **4,513 points in 229
orbits, group-closed exactly** (zero images outside, over all 24 elements), orbit sizes
`{1: 1, 6: 14, 12: 59, 24: 155}`.

**His orbit-label rule, recovered rather than assumed.** His labels are all-even, non-negative and
carry a zero coordinate — but that does not pin a member: the radius-1/3 orbit contains both
`(4,0,0,0)` and `(2,0,2,0)`, and he writes `(4,0,0,0)`. The rule that reproduces **all 41 labels of
Table 2** is *maximize the number of zero coordinates, then take the lexicographic minimum*; the two
obvious alternatives (plain lexicographic minimum; the member on an axis) do not. Under it the 229
orbit labels are **injective**, all 41 Table-2 labels are canonical representatives of our orbits,
and every Table-2 filling fits inside its orbit's size.

**Heule-510 is a type-M object over his base, exactly.** A type-M graph is `G = L ∪ ρS` with `L`
drawn in `K = ℚ(√3,√11)` and `ρ = ρ₁₅ = (7+i√15)/8` adjoining `√15 ∼ √5`, so the split needs no
search — a vertex is on the `L` side exactly when it is `√5`-free. Measured on
`tools/heule510.json`, held here since M06:

- **375 + 136 sharing the origin**, `374 + 135 + 1 = 510`, and **every point of both sides lands on
  his denominator-12 lattice — zero off it.**
- **The L side reproduces Table 2's 375 column on all 41 rows, zero mismatches, zero extra orbits.**
- The S side uses **exactly Table 4's fourteen orbits**, with every filling inside his `{M}` ranges
  — so Heule's `S136` is one of his eight minimal S-graphs.

**The connecting edges are his two orbits with his counts, from our own cross-edge law.** On the
`r = 2.6` base the `ρ₁₅` cross edges give **12 in the reference orbit `(0,4,4,0)` at radius 2** and
**12 in the auxiliary orbit `(0,0,2,6)`**, whose two radii are `√11/2 ∓ √3/6` to machine precision —
his §4 values. And the auxiliary orbit is **ONE orbit at TWO radii**: two of the twenty-four group
elements are Galois, so an orbit carries the conjugate squared norms `n` and `σ(n)`, and
`(0,0,2,6)`'s twelve points sit six at `1.9470` and six at `1.3696`. An auxiliary edge joins one
Galois half on the L side to the other on the S side.

**Both cross-edge families have the same coupling constant, and that is why one rotation realizes
both.** With `t`, `r` the two endpoint radii, a unit cross edge collinear with the centre forces

  `c = (t² + r² − 1) / (2tr) = 7/8 = Re(ρ₁₅)`,

which holds for the reference pair `(2, 2)` and for the auxiliary pair `(√((17±√33)/6))` alike —
checked to 1e-15. **This is the content of his unexplained sentence** *"Unlike graphs of type A, the
existence of triangles of the second kind is essential"*: the second family is not a second
construction, it is the same rotation's conjugate-ring channel — which is M31's quadrature law
(ledger row 27) met from his side.

**The 2504-versus-2502 loose end is CLOSED, and it was never a disagreement.** Decomposed:

| | L | S | reference | auxiliary | total |
|---|---|---|---|---|---|
| our `tools/heule510.json` | 1920 | **566** (Heule's S) | 12 | 6 | **2504** |
| his Table 1 "510" row | 1920 | **564** (his own S) | 12 | 6 | **2502** |
| his Table 1 "509" row | 1860 | 564 | 12 | 6 | **2442** |

Our file holds **Heule's** S with the **same** L; his row holds **his improved** S — and §6 says
*"Here we hardly improved the result of Heule at all; only two edges were removed."* `566 − 564 = 2`.
Measured: his `v136e564.vtx` and Heule's S have the same 136-vertex count and **different vertex
sets**. The `12 + 6` is also the subtype read off the edge count: **M6** means six auxiliary edges.

### What his own files say that his tables do not

`tools/parts_verify.py` parses all 43 `.vtx` files exactly and checks each against its own
filename. **40 of 43 reproduce their vertex AND unit-edge counts exactly**, in exact arithmetic,
with a parse that shares no code with the paper. The three that do not are a finding, not a
failure, and so is what the other 40 settle.

**(i) The record decomposes into four independently attested terms.** `v509e2442` splits as
`L(374) ∪ ρ₁₅S(136)` sharing the origin with **zero points off his lattice**, and

  `2442 = 1860 (L) + 564 (S) + 12 (reference) + 6 (auxiliary)`

with `e(L)` and `e(S)` recomputed here from the vertex lists. The `12 + 6` is the subtype read off
the edges: **M6** *is* six auxiliary edges.

**(ii) Table 3's `A` column has exactly two typos, and his own file names them.** The printed column
sums to **402** against its caption's **412**. `v412e2106.vtx` has **412 vertices in exactly Table
3's 37 orbits**, and differs from the printed column in **two rows only** — `(0,0,2,2)` printed 8,
actually **12**; `(0,0,2,6)` printed 6, actually **12** — each the orbit's full size, and
`(12−8) + (12−6) = 10`, exactly the deficit. **P1 met.** Table 5's (−16) and Table 7's (+3) are
untested; their `A` files are held (`v375e1862`, `v289e1389`) and the same check settles them.

**(iii) A single printed `M` column is NOT reliable, and the `{M}` ranges ARE.** His own
`v374e1860.vtx` has 374 vertices in exactly Table 3's 37 orbits but differs from the printed `M`
column in **four** rows — and **all four differences lie inside the printed `{M}` ranges**
(`(0,0,2,2)` 6 vs 8, range 6–8; `(2,0,6,4)` 4 vs 2, range 0–8; `(4,0,10,2)` 4 vs 0, range 0–4;
`(6,2,8,0)` 8 vs 12, range 8–12), while **all 31 stable orbits agree exactly**. So either the file
is a different member of `{M}` than the column describes, or the column carries typos as the `A`
column demonstrably does — and either way **§3's gate design is vindicated on his own data**: gate
on the ranges and on the stable/unstable partition, never on one printed column.

**(iv) `v136e564` reproduces Table 4's M6A `M` column exactly, all 14 rows**, and `v166e774`'s
fillings dominate it orbit by orbit and sum to 166. Heule's own S — recovered in §1 from
`heule510.json` — has `(0,4,0,0) = 5`, `(6,2,4,0) = 15`, `(6,0,4,6) = 7`, every one inside Table 4's
`{M}` ranges: **Heule's S136 is one of Parts's eight minimal S-graphs.**

**(v) His objects are stored each in its own frame, and containment holds only up to the group.**
`v136e564 ⊄ v166e774` as stored (six vertices outside) — but **six of the twenty-four group elements
map it inside**. A reproduction that tests `M ⊆ A` literally will report a false negative; the test
is `∃g ∈ Aut B : g(M) ⊆ A`. The L-side files happen to be framed compatibly
(`v374e1860 ⊆ v412e2106`, `v374e1868 ⊆ v406e2082`, `v376e1890 ⊆ v451e2400`,
`v375e1920 ⊆ v403e2112`, all literal), which is exactly how this would have gone unnoticed.

**(vi) Three of his objects are on a TRANSLATE of the base, not on a second component of it —
and the first reading of this was wrong, killed by the modelling pass's own seam test.** The three
off-base files are `v214e977` and `v226e1037` (the distance-3 non-mono-pair and its `A`) and
`v312e1502` (the 1/3 one). Every one of their points satisfies `a ≡ b ≡ c ≡ d (mod 2)` with
`a − b + c + d ≡ 2 (mod 4)`, where every other object satisfies `≡ 0`. **It is tempting, and wrong,
to read that as "the lattice has two components and we implement one":** built and measured, the
`≡ 2` set at `r = 2.6` has 4,448 points and **71,168 group images outside itself** — it is not
group-closed and is not a lattice under the order-24 group about the origin, where the `≡ 0` set is
closed exactly (0 outside). What is true is one line further on: `φ(p) = a − b + c + d mod 4` is
additive, so the difference of any two `≡ 2` points is `≡ 0`, and **translating such a graph by any
one of its own vertices lands every point back on the base** (measured: 214 of 214, parities intact).
So they are ordinary base graphs anchored off the origin, and the reason is geometric — their forced
pair sits at `(±3/2, 0)` whose **midpoint is not a lattice point**, so the object cannot be centred
where its symmetry is. None of the three is in the reproduction path or in the held-out set (the
`8/3` mono-pair `v367e1822` and the `√3` non-mono-triple `v221e1006` are both on the base), so this
is a bounded, named residual: **what group those three ARE invariant under is open and this milestone
does not need it.**

---

## §2 — His algorithm as our objects

**His variables (§5.3), which we adopt verbatim** — `M ⊆ A ⊆ W ⊆ R ⊆ B`, `M ∈ {M}`, `⋃{M} = A`:

| his | what it is | ours |
|---|---|---|
| `B` | base graph of the search area | `parts_repro.Base(2.6)` |
| `R` | reserve: a high-symmetry overgraph of `A` to draw new vertices from | to build (§4 D) |
| `W` | working graph — `A` plus candidate new vertices, kept near **1000** (§5.11) | to build |
| `A` | **accumulative graph, `⋃{M}` — the loop's state variable** | **we have no analogue** |
| `{M}` | the set of ALL minima at the current size | **we have no analogue** |
| `M` | one minimum | every descent we have ever run |
| `C` | **companion graph**: reifies the key property as a graph | partly (`typem.cnf_for`) |
| `Y` | **relationships hypergraph**: sets that cannot be wholly deleted | census (deg 1), `hyperedges.py` (deg 2, unrun), `exact.py` (harvested) |

**`C` is the abstraction that gives one paper fifteen results, and it is not "the frozen other
side".** §5.3: *"for an L-graph, it is an S-graph and vice versa, for a mono-pair it is an edge of
the corresponding length, for a non-mono-set it is a 3-clique, each vertex of which is connected to
all vertices of this set."* Modelled as "the other half of a type-M graph" we lose every non-M row
of Table 1 — which is exactly the held-out set §3 depends on. `C` also does a second job: **the
symmetry-setting pendants live in it** (below).

**Symmetry is FOUR things (§5.4), not one**, and our ladder measured the wrong one:

- `Aut B` — the base group, order 24. Ours.
- `Aut W` — of the working graph.
- **input symmetry `Aut(W ∪ C)`** — the group that **deduplicates** candidates.
- **output symmetry `Aut{M}`** — the **granularity of the search variables**: candidates are unions
  of output-orbits, so a higher rung means fewer, bigger variables.

Deduplication uses *"the set of permutations of the **quotient group**"*, so output must be normal
in input. And both are **engineered by modifying the object**: §5.8 — *"The input and output
symmetry can be changed by **adding hanging vertices** to the graph `W`, that is vertices of degree
1, which can be taken as part of the input and output companion graphs `C`. The hanging vertices are
those connected to a high-degree vertex of graph `W`, that are not deleted during reduction."*
Degree-1 pendants on high-degree vertices, living in `C`, never deleted, costing nothing against the
vertex budget. **Symmetry is a dial you set on `W ∪ C`, not a filter on candidates.**

*Consequence, and it retires a comparison the handoff stub invited:* Table 1's symmetry column is
*"taking into account the connection edges"* — the symmetry of `L` **with its connections** — while
our `24/6/3/2/1` ladder was the symmetry of an arena selection. **His 376-at-symmetry-3 and our
558-at-symmetry-3 are two quantities on two objects and must not be compared.** Also: `1 (2)` means
*the set* has output symmetry 1 and *the fewest-edge member* has symmetry 2 — it is not a second
search parameter.

**Phase 1 — build `Y`.** A hyperedge of degree `n` is an `n`-set whose simultaneous deletion loses
the key property, minimal. Sought stepwise in increasing degree. **Degrees used (§6): 2 or 3 for L,
3 or 4 for S and non-mono-triples**; up to 5 where the object is under 250 vertices.

**Phase 2 — enumerate.** Check the key property for all subgraphs containing at least one vertex of
every hyperedge, **in order of increasing vertex count**. Equivalently on the DELETED sets, which
are much smaller (§5.7): the deleted set must be **independent in `Y`**, and we want the largest —
so **maximum independent set of `Y` = minimum hitting set of `Y`**, which is what `tools/exact.py`
already computes by implicit hitting set. His explicit recipe (maximal independent sets of the
degree-2 graph, plus free vertices, split on degree ≥ 3, ordered by decreasing deletion count,
pruned against the incumbent) is the same problem stated as an enumeration.

**Three termination rules, and the first is what makes `{M}` well-defined:** *"The check is
terminated if at some step **at least one** subgraph with the key property is found"* — evaluated at
the END of a step, so **the entire winning level is checked and `{M}` falls out for free**. Then:
only subgraphs no larger than the previous iteration's `M` need checking; and the check may be
terminated if a step's candidate count exceeds a threshold — **so `{M}` is complete-or-truncated and
he does not say which.**

**The loop's success criterion (§5.5), which is the piece with no analogue here:** *"The iteration
is considered successful if it leads to a change in the graph `A`: that is, either to a reduction of
the order of the minimum graph `M` **or else to an expansion of the set of minimal graphs `{M}`**."*

**8-4-2-1 (§5.8), and it belongs in phase 1 where we do not have it.** *"The sets of deleted
vertices are first divided into groups of 8 … If the result is False, then this means that each of
the sets can be deleted individually. If True (which takes relatively little time), then the sets
are grouped in fours … then in pairs … finally individually."* The precondition is the cost split we
measured independently on our own kernel — **refusing asks 10–15 s, colourable asks 0.02–2.8 s** —
so one expensive refusal clears eight candidates. We own this shape in `descent3.py`'s
gallop-then-bisect, in the **descent**; he applies it to **hypergraph construction**.

**Rough reduction (§5.10), and it is what our descent already is.** *"Before using it, one should
use a rough reduction method to obtain an acceptable initial graph"* — trimming by radius, iterative
removal of small-degree vertices, fixing vertices whose removal loses the property, deleting base
orbits largest-first, and selection by cheap numerical indicators (free-vertex count, small-degree
hyperedge counts, the maximum independent set of the degree-2 hyperedge graph). **Our 559-vertex
census-certified object is the INPUT to his fine search, not a competitor to his 509.**

---

## §3 — The acceptance test, and where the handoff stub's version was wrong

The stub proposed gating on six numbers: `|{M}|` and `A` at 376, 375 and 374. **That is the wrong
test in a way that matters, and the advisory pass caught it.**

**(a) `A` is the least reliable quantity in the paper.** Summing the per-orbit `A` columns against
their own captions: Table 3 gives **402** where it claims **412**; Table 5 gives **391** where it
claims **375**; Table 7 gives **292** where it claims **289**; only Table 6 agrees. Errors in both
directions, one of them 4% in the direction of impossibility. Every `M` column checks. *A gate that
cannot fail cleanly is the failure mode this repository has minted four times.*

**(b) `|{M}|` is convention-dependent and possibly truncated.** "Non-isomorphic" means non-isomorphic
under the quotient group his run happened to be configured with (§5.8), not abstract isomorphism;
and §5.5's threshold clause means the enumeration may have stopped early. **1092 is a number
produced by his run, under a convention he does not state, possibly a lower bound.**

**(c) The reliable, convention-free, multi-dimensional target is the orbit-filling RANGES**, and
they are attested twice — Table 2's `{M}` columns and Table 3's `{M}` column agree on all six
varying orbits. The 374-vertex minima differ in **exactly six orbits**, whose fillings total 40:

| orbit | `{M}` range | orbit | `{M}` range |
|---|---|---|---|
| `(0,0,2,2)` | 6–8 | `(4,0,10,2)` | 0–4 |
| `(2,0,6,4)` | 0–8 | `(10,0,2,4)` | 4–12 |
| `(2,0,2,4)` | 8–10 | `(6,2,8,0)` | 8–12 |

and **31 other orbits are stable** — same non-empty vertex set in every minimum. **A pipeline whose
minima vary in an orbit he lists as stable is not running his algorithm, whatever count it reports.**
That is a clean falsifier and the stub did not have one.

**(d) And the archive makes three of these checkable rather than arguable.** We now hold `A` itself
— `v412e2106.vtx`, `v451e2400.vtx`, `v403e2106/2112.vtx`, `v406e2076/2082.vtx`, `v166e774.vtx` —
so "does Table 3's `A` column really sum to 412?" is a computation on his own file, not a reading of
his table. **Phase A settles it.**

### The gate, as it now stands

| rank | what | gate? |
|---|---|---|
| 1 | `\|M\|` — 136, 374, 375, 376 — triply attested (Table 1, caption, a summing decomposition) | **YES, hard** |
| 2 | the `{M}` orbit-filling ranges and the stable/unstable partition — doubly attested | **YES, hard** |
| 3 | edge counts, decomposed as `e(L) + e(S) + 12 + (subtype number)` — four independent terms | **YES, hard** |
| 4 | the loop's second success clause: **`{M}` grows at fixed `M`** (his 78 → 1092 at 374) | **YES, qualitative** |
| 5 | `\|{M}\|` and `\|A\|` | reported, **never gated** |

### And the held-out set, which is what makes it a reproduction rather than a fit

**The lie this milestone can tell is specific:** the pipeline has a dozen free choices (which orbits
to add and in what order; the symmetry rung; the hyperedge degree cap; the enumeration threshold;
which half or quarter of each partial orbit; the isomorphism convention). Every one of them, nudged
to move a count from 84 toward 96, will feel exactly like getting the algorithm right, and the
result is an instrument that reproduces his checkpoints on his path and **generalizes nowhere** —
which is precisely what the next session cannot use, because it runs a different path. `G21`, with
the acceptance criterion being his published answer, and invisible: a green run on every number.

**So: tune on the L path only; then FREEZE; then run untouched on the held-out set, predictions
written down first.** Table 1 gives fifteen result rows over five independent reduction problems:

- **S-subgraph M6A** — `A166 → M136`, `|{M}| = 8`, edges 564–567, and his §5.10 worked example with
  its check count and wall clock. The cheapest complete instance of his algorithm in the paper.
- **mono-pair 8/3** — `A375 → M367`, 27 minima, Table 5 with its own ranges. **Sharpest of the
  held-out set**, because its companion `C` is *an edge*, not an S-graph — it exercises the
  companion abstraction, the piece most likely to be modelled as a special case.
- **non-mono-triple `√3`** — `A238 → M221`, 120 minima, Table 6.
- **L-subgraph M6B and M6C** — 374 at symmetry 2, `|{M}| = 78` and `76`.

---

## §4 — Phases, each with the control it must pass

### Phase A — the calibration corpus *(mostly done; §1)*

Parse all 43 `.vtx` files exactly, check every one against its own filename, and settle the `A`
question. **Controls:** vertex and unit-edge counts equal `v<V>e<E>` for every file; every lattice
graph lies inside `Base(2.6)`; `v509e2442` splits as `L(374) ∪ ρ₁₅S(136)` sharing the origin with
`2442 = 1860 + 564 + 12 + 6`; his `v374e1860`'s orbit fillings equal Table 3's `M` column and
`v136e564`'s equal Table 4's `M6A` column. **Then compute `v412e2106`'s fillings and compare with
Table 3's `A` column** — that decides whether the 402/412 gap is his table or our transcription.

### Phase B — the key-property checker with his companion graph and his accelerators

`key_property(W, C)` = *`W ∪ C` is not 4-colourable*, with `C` one of: a frozen S-graph (for L), a
frozen L-graph (for S), **an edge of the given length** (mono-pair), **a 3-clique joined to every
vertex of the set** (non-mono-set). Plus §5.9's levers, none of which we use:

- the **3-clique pin** at `L`'s `(0,0)`, `(1,0)`, `(1/2, √3/2)` — three unit clauses, no new
  variables. Distinct from the value-precedence encoding measured FLAT in FS-32 §R3.
- **vertex order by increasing Euclidean distance from the centre**.
- **multi-vertex colour assignment** — for a `√3` non-mono-triple, combining symmetry breaking with
  `C` pins **five** vertices at once for a reported ~10×.
- the **cyclic implication chain** `v₁,k ⇒ v₂,k ⇒ … ⇒ v_m,k ⇒ v₁,k` per colour, to force a set
  monochromatic with fewer clauses than a companion graph.
- **one-time extraction of the common part of the CNF** (§5.8).

**Control:** reproduce known verdicts on his own objects (`v374e1860 ∪ ρS136` refuses four;
`v374e1860` alone with `C` = his `S136` refuses four; each with one vertex deleted is colourable
where the census says so). **And each lever is measured separately against the recorded trace, so a
speedup claim names its population** (`G21`, fourth instance).

### Phase C — the hypergraph `Y`

Degree 1 by the existing census. Degree 2 by `hyperedges_run.py` **at the full order-24 collapse,
not 6** — `C(n,2)/24`, roughly `7,900` orbit asks on a 613-candidate object, against the `31,000`
the file currently assumes. **Requires the selection to be orbit-closed**, which is true before a
descent breaks symmetry and false after, so the census runs first. Degree 3 **harvested, never
enumerated** — from failed bisections and from `exact.py`'s minimalized correction sets.

**Controls:** every hyperedge re-verified by an independent rebuild of the induced graph; no
hyperedge contains a lower-degree one; and the count carries its enumeration (which pairs were
asked, which were reached by symmetry).

**Before enumerating anything, compute the three cheap statistics** that say whether phase 2 fits:
the number of non-isolated vertices of the degree-2 graph, its component profile (the maximal
independent set count is exactly multiplicative over components), and its independence number
`α`. A **rigorous lower bound** on the candidate count is `2^m` for an induced matching of size `m`,
computable greedily in milliseconds — and `α(G₂) + |free| < |W| − target` is a genuine impossibility
test that costs one RC2 solve.

### Phase D — phase 2, and `{M}`

Minimum hitting set by `exact.py`, **extended to enumerate the whole optimal level** by blocking
each found optimum and re-solving; deduplicate by the input group *before* verifying (up to 24×
fewer asks, and it is what makes his counts non-isomorphic); `A = ⋃{M}`.

**The level is an antichain** — the incumbent updates once per level, not once per ask — so it is
embarrassingly parallel and the sequential-acceptance floor that has burned this project twice does
not apply here. Polarity, easy to get backwards: **a success keeps the property, hence UNSAT, hence
the expensive ask**; the level costs `L` cheap asks plus `|{M}|` expensive ones.

**Report `A`'s growth curve** and stop when it has not grown for `k` consecutive minima, so the
stopping decision is visible rather than implicit. On the S case, run the level to exhaustion — it
costs minutes and it is the calibration.

### Phase E — the loop

`A = ⋃{M}`; expansion by partially-filled base orbits first (*"especially orbits with a small number
of vertices (6 or 12)"*), then the reserve `R` (an orbit joins `R` *"if, when added to the graph
`A`, the degree of some of its vertices is at least 4"*, added in decreasing vertex degree); L and S
alternating against a frozen companion; the symmetry rung set by pendants in `C`. Escape a local
minimum by *"increasing the number of new vertices introduced in the expansion stage"*.

**The path to walk, and it has FOUR states, not the three the handoff stub recorded:**

| # | output symmetry | `M` | `\|{M}\|` | `A` | move |
|---|---|---|---|---|---|
| 1 | 3 | 376 | 96 | 451 | from Heule-529's `L393` + orbits `(0,0,12,0)`, `(0,0,2,2)`, `(4,0,10,2)`, `(10,0,2,4)` |
| 2 | 1 | 375 | 282 | 403 | reduce `A451` |
| 3 | 2 | 374 | 78 | 406 | + orbits `(0,0,0,4)`, `(0,0,6,6)`, fill `(4,0,0,0)` |
| 4 | 1 | **374** | **1092** | 412 | reduce again — **`M` unchanged, `{M}` grows fourteenfold** |

**State 4 is the single most diagnostic row in his results**: most diagnostic of the algorithm,
least of the answer. A pipeline that can grow `{M}` at fixed `M` is running his loop; one that
cannot, is not — and it costs nothing extra, being the same run.

*We do not hold Heule's 529, so state 1's stated input is unavailable; `v451e2400.vtx` (his `A451`)
is, so states 2→3→4 are runnable end to end on his own data.*

---

## §5 — Registered predictions

| # | prediction | decided by |
|---|---|---|
| P1 | ~~Table 3's `A` column really does sum to 402, and `v412e2106.vtx` has 412 vertices — i.e. the table is missing rows, not mistyped~~ **MET, and sharper than registered: not missing rows but two typos, each under-reporting a FULL orbit, and the deficit is exactly 10** (§1) | phase A, done |
| P2 | reducing `v166e774` returns `M = 136` and `\|{M}\| = 8` with edges in 564–567 | phase D on S |
| P3 | reducing `v451e2400` at output symmetry 1 returns `M = 375`, and its minima vary only in the orbits Table 2's `375` `{M}` column marks unstable | phase D on L |
| P4 | the degree-2 hyperedge count on our own 757 arena is in the **tens**, not 10³–10⁴, because a pair cannot be critical when 248 vertices delete freely | phase C, first 500 orbit asks, < 1 h |
| P5 | maximal-independent-set enumeration on the 757 arena is infeasible at every symmetry rung (induced-matching bound `2^m`), and affordable on his `A412` — the controlling variable is the **gap** `\|W\| − \|M\|`, ~38 for him and ~248 for us | phase C statistics, minutes |
| P6 | the §5.10 numerical indicators are subsumed by `exact.py`'s hitting-set bound; the MIS-of-degree-2 bound never exceeds it | one run of both on the 757 arena |
| P7 | seeding `exact.py --seed-corr` with the degree-2 census moves its lower bound materially (it sat at 176 after 100 iterations on 245 fat correction sets; a size-2 core is worth ~1/2 per vertex against ~1/148) | phase C then `exact.py` |
| P8 | one full iteration at his scale (`A412 → 374`) costs ≈ 3.5 h on the 32-core desktop, ±2×, dominated by ~10⁵ SAT asks at a mean of 2–4 s (phase 2 is dominated by *colourable* asks, which are fast) | phase D |

---

## §6 — What this milestone must NOT do

- **Not beat 509.** That is the next session's job; a rehearsal that wins has stopped being
  calibrated. If a run turns up a 508, certify it and record it — it does not become the product.
- **Not tune on the held-out set.** Freeze after the L path, write predictions down, then run S and
  the 8/3 mono-pair untouched.
- **Not build a minimization loop on the assembled type-M graph.** Table 1's M-type rows have
  **blank** `A` and `{M}` columns: he ran no loop on the 509 itself. L and S are minimized
  separately against a frozen companion and the join is trivial.
- **Not leave the base unfrozen.** `Base(2.6)` is frozen here, with `orbits_meeting_disk(2.0)`
  available so "his stated construction" and "our truncation" can be compared rather than assumed
  equal. The next session's genome is a bitset over a fixed base; if the base moves, nothing compares.
- **Not generalize toward FS-6.** A rehearsal that is also a generalization is neither.
- **Not let `exact.py` stand in for his algorithm.** The mapping is real — his hyperedges are our
  minimal correction sets, his phase 2 is our hitting set — and it is **his algorithm with the beam
  collapsed to one**, which is exactly what overcompression says cannot reach the record. A
  hitting-set solver returns *an* optimum; his phase 2 returns *every* optimum at the first feasible
  size, and that set is the loop's state.
- **Not report an uncertified verdict as a find.** Verdict vocabulary: no word means "clean"; a cap
  is never a negative; every count carries its enumeration; any phase over ~15 minutes checkpoints
  and resumes exactly; report from inside a phase, not only at its end.

---

## §7 — Instruments, costs, addresses

**New this milestone:** `tools/parts_repro.py` (his base, labels, type-M split, fillings, and the
self-test that is §1), `tools/parts_vtx.py` (exact parser for his `.vtx` files, including the nested
radicals `√(5(7±√33)/2) = (√55 ∓ √15)/2` that appear on the S side of the assembled graphs),
`tools/parts_verify.py` (all 43 objects against their own filenames).

**Data:** `data/m62/parts-ref11/` (his archive, trimmed to `JP/` + provenance + checksums, 740 KB —
the 73 MB zip and 57 MB of plots were dropped, with the live URL and checksum kept as the evidence),
`data/m62/parts-table2-orbit-fillings.json`, `data/m62/parts509-orbit-fillings.json`,
`data/m62/parts-ref11-verified.json`.

**Existing and reused:** `typem.py`, `census*.py`, `descent3.py`, `exact.py`, `hyperedges*.py`
(written, never run), `lowerbound.py`, `mkstate.py`, `symstate.py`.

**Not needed, decided rather than deferred:** a Rust engine. The SAT oracle is >99% of the cost and
the enumeration around it is bookkeeping; the host language moves the wall clock by zero, where the
solver version moves it 20% and §5.9's encoding levers a reported 10×. The one trigger that would
change this: a level's candidate list past ~10⁶ after pruning, where orbit canonicalization of
bitsets lands on the critical path.

**Solver:** CaDiCaL 1.5.3 measured best here (1.9.5 +19% on our recorded trace, 3.0.0 ≥ 6× worse);
the engineering advisor measured 1.9.5 8% *better* on its own trace, so that row is a live
disagreement and is not load-bearing for anything in this plan.


---

## §M — The domain-modelling pass (WORKFLOW step 5, `debruijn-domain-modeling`)

The pass was run on his vocabulary before any of it was implemented. It produced one collapse, one
correction to a finding made earlier the same day (§1 vi), and three predictions that were confirmed
on his own files afterwards.

### The collapse: `granularity` and `sym` are the same unnamed role

`mkstate.build(..., granularity="vertex"|"orbit")` and `symstate.build(..., sym=24|6|3|2|1)` are two
parallel mechanisms doing one job — **N declarations identical modulo naming, a role unnamed.** The
role is *the partition of `W`'s deletable vertices into indivisible atoms*, and it always comes from
the same place: **the orbits of a chosen subgroup.** Vertex granularity is the trivial subgroup;
orbit granularity is the whole base group; a symmetry rung is a subgroup in between. One type, three
constructors, and the flag disappears.

### The model

| object | shape | why this and not the alternative |
|---|---|---|
| `Lattice` | `a ≡ b ≡ c ≡ d (mod 2)` **and** `a − b + c + d ≡ 0 (mod 4)` | the mod-4 clause is part of the lattice, not a component choice — dropping it costs group-closure (§1 vi). A graph anchored elsewhere is a **translate**, handled by translating. |
| `Base` | the lattice truncated once at a generous radius, carrying per-orbit `(r_min, r_max)` | *"within radius r"* then becomes a **selection predicate with two honest readings** — `meets` (`r_min ≤ r`, his stated *"completely or partially"*) and `inside` (`r_max ≤ r`, our `parts_lattice`) — instead of a constructor parameter that silently picks one. An orbit carries two conjugate radii, so a disk is not group-invariant and no single number can be the answer. |
| `Drawing` | a vertex set over the base plus its derived edges | `M`, `A`, `W`, `R`, and the `L`/`S` halves are one type in five roles. Five types would be five copies of one thing. |
| `Companion` | **(extra vertices, extra edges)** adjoined to `W`; the key property is *`W ∪ C` refuses four colours* | four constructors — `frozen_side`, `mono_pair` (0 vertices, 1 edge), `non_mono_set` (a 3-clique joined to every member), `pendants` — and **C's vertices are never deletable**, which is exactly why pendants set the symmetry for free. This is our own kernel's bridge (`Pigeonhole.mono_pair_of_not_colorable_append`, ledger row 31) as a data structure, and it is what turns one paper into fifteen results. |
| `Symmetry` | a **pair** `(inp, out)` with `out ◁ inp ≤ Aut(W ∪ C)` | not four ad-hoc parameters. `out` is the **output** symmetry and its orbits are the atoms; `inp` is the **input** symmetry and the quotient `inp/out` is the dedup group. Normality is what makes the quotient act, and it is an invariant of the type rather than an unstated assumption. |
| `Atoms` | the `out`-orbits of `W`'s deletable vertices | derived, never configured. The unit of every deletion, hyperedge and candidate. |
| `Y` | an **antichain** of atom-sets | minimality is an invariant enforced at insertion. *"No hyperedge may contain a lower-degree one"* was going to be a control run afterwards; it is a property of the type. |
| `{M}` | a set of **canonical representatives** under the `inp/out` action (the minimum over the images) | *"quotient or canonical form?"* — the group is finite and small, so canonical form, computed once at insertion. That makes *"non-isomorphic"* a property of the type instead of a convention in prose, which is what §3 needed. |
| `A` | the union over the **full `inp`-orbit** of each representative | **not** the union of the representatives. `A` must be `inp`-invariant, and canonicalizing first would break that — this is finding (v) as a design rule instead of a nuisance. |

### Three predictions the model made before being consulted, all confirmed on his own files

- **Table 1's symmetry column is `|Stab(M)|`.** Measured in `Aut B`: `v374e1860` → **2** (his row reads
  *"1 (2)"*), `v136e564` → **1** (his row reads *"1"*). So the parenthetical is the actual stabilizer
  of the fewest-edge member and the bare number is the `out` subgroup the search was constrained to —
  it is not a second search parameter.
- **The accumulative graph is more symmetric than its minima**, because it carries `inp` where they
  carry `out`: `v412e2106`, `v406e2082`, `v451e2400`, `v403e2112` all have stabilizer **12** against
  `v374e1860`'s **2**; `v166e774` has **6** against `v136e564`'s **1**.
- **Canonicalization separates genuinely different minima and collapses group-images.** The four held
  374-vertex minima give **4 distinct canonical forms**; a planted group-image of `v374e1860`
  canonicalizes equal to it (control fires); `v374e1864` does not (negative control fires).

### What the model refuses to represent

An atom that is not an `out`-orbit; a hyperedge that contains another; a `{M}` holding two
group-images of one graph; a `Symmetry` whose `out` is not normal in `inp`; a `Companion` vertex in
the deletable set. Each of those was reachable in the current tools and each is a way the
reproduction could report a number that means something else.

---

## §O — The obligation-modelling pass (WORKFLOW step 5, `debruijn-obligation-modeling`)

### The space, and the one theorem everything is an instance of

The state space is the finite lattice of subsets `S ⊆ Atoms`. One predicate:

  `R(S)` := *`W[S ∪ fixed] ∪ C` refuses four colours* — the key property.

**`R` is upward closed**, because adding vertices to a graph that is not 4-colourable cannot make it
4-colourable — and *that is a property of the SHAPE the domain pass chose*, not a separate fact:
expressing every key property as non-colourability of `W ∪ C` makes monotonicity structural. Dually
`¬R` (colourability) is downward closed, so the maximal colourable sets and their complements — the
**minimal correction sets** — are the extremal data, and

> **`R(S)` ⟺ `S` meets every minimal correction set.**

That is MCS/MUS hitting-set duality, it is exact in both directions, and it is why Parts's phase 2
and our `exact.py` are the same algorithm: **his hypergraph `Y` IS the family of minimal correction
sets, and his phase-2 enumeration IS minimum hitting set.**

### (1) Completeness, as an invariant rather than a hope

Write `Y*` for the complete family and `Y ⊆ Y*` for what has been harvested. Three obligations:

**(a) Termination of the optimality loop.** Each non-optimal iteration produces a correction set `C`
that the current hitting set `h` misses, so `C ∉ Y` and `|Y|` strictly grows. **Measure:
`|Y*| − |Y|`**, bounded because `Atoms` is finite. At most `|Y*|` iterations.

**(b) The lower bound is rigorous at every instant.** `Y ⊆ Y*` means *fewer* constraints, so
`mhs(Y) ≤ mhs(Y*)`; and when the returned `h` satisfies `R(h)`, `h` is a transversal of `Y*`, giving
`mhs(Y*) ≤ w(h) = mhs(Y)` and hence equality. **The sandwich closing IS the optimality proof** — a
run stopped early still reports an honest interval, which is why a budgeted run here does not lie.

**(c) Completeness of `{M}`.** Enumerate at weight exactly `w*`, holding `E` = optima found:

> **Invariant.** `E ⊆ {S : R(S), w(S) = w*}`, and every `S` with `R(S)` and `w(S) = w*` that is not
> in `E` is still feasible for the current MaxSAT instance.

*Preservation.* A blocking clause removes only a member of `E` (already `R`-true and recorded); a
new correction set removes only sets that are not `R`-true. **Neither ever removes an unrecorded
`R`-true `w*` set.** *Termination.* Each iteration grows `E` or grows `Y`; **measure
`(#{S : w(S) = w*} − |E|, |Y*| − |Y|)`, lexicographic.** *At exit (UNSAT).* No `w*` set both hits
all of `Y` and avoids `E`; every `R`-true `w*` set hits all of `Y* ⊇ Y`; hence it is in `E`. ∎

*The one step that is easy to get wrong and is written down here so it is not:* when `¬R(h)`, **do
not block `h`.** Blocking it would be sound but wasteful; adding the correction set `h` misses
removes `h` and infinitely many like it, and blocking would let the same `h` return under a
different guise. And **every correction set must be verified before insertion** — `exact.py`'s are
derived from an actual colouring, so they are verified by construction; a *guessed* one would let
`mhs(Y)` exceed the truth and turn the lower bound into an unsound optimality claim. Its shrink loop
is also safe under a capped ask, because it treats *undecided* as *still needed*, and a non-minimal
correction set is still a correction set.

### (2) Soundness of the pre-filters — three sound, one NOT, and the one that is not is the report

| filter | obligation | verdict |
|---|---|---|
| degree-1 census fixes criticals | if deleting `{a}` alone loses `R`, every `S` missing `a` is `⊆ Atoms∖{a}`, and `¬R` is downward closed | **sound**, from monotonicity alone |
| correction-set pruning | `R(S) ⟹ S` meets every correction set | **sound**, the duality |
| beat-the-incumbent pruning | we want only the first feasible size; a candidate that cannot reach it cannot be in `{M}` | **sound**, and it is what makes `{M}` the level set rather than everything |
| **the atom partition** | restricting to `out`-symmetric candidates **provably loses minima** — that is overcompression, his own §5.8 | **NOT sound, and must never be reported as if it were** |

**Monotonicity is the hypothesis everything leans on, so name where it breaks:** *"χ is exactly 5"*
is not monotone; *"1-minimal"* is not; *"admits a proper 4-colouring"* is downward, not upward. The
guard is structural — a key property is admissible here **only** if it is expressible as
`¬ Colorable(W ∪ C, 4)`, which is what the `Companion` type enforces.

**The last row is this milestone's sharpest reporting obligation**, and it is exactly where a word
meaning "clean" would lie. The verdict for a search at `out ≠ 1` is **`exact-at-rung`**, never
`exact`; `exact` is available only at `out = 1`; and the rung travels in the same sentence as the
number, per `G21`. Nothing else in the vocabulary may be read as "we found the minimum".

**Canonicalization merges exactly the `inp`-orbits and nothing else** (measured: the four held
374-vertex minima give four distinct forms, a planted group image collapses, a genuine sibling does
not). So the honest report is **`|{M}| up to Aut B`**, never *"up to isomorphism"* — which is also
precisely the ambiguity that makes his own `1092` un-gateable (§3).

### (3) The outer loop has NO measure, and saying so is the finding

Expansion adds vertices, so `|W|` is unbounded above; and his own success criterion fires when
`{M}` grows at fixed `|M|`, so `|M|` is not a measure either. **The loop does not terminate, and
the real stopping rule is "`A` stopped changing".** Therefore:

- report `(|M|, |{M}|, |A|)` **every iteration**, with `A`'s growth curve;
- **`stalled` is a verdict, not a success** — all three unchanged for `k` iterations;
- a stall is a control signal: his own escape is *"increasing the number of new vertices introduced
  in the expansion stage"*, so the monitor feeds the next expansion rather than ending the run.

### (4) What the kernel owes: nothing, and the decline is priced

The reproduction certifies **his** object, not a new one, and *"a formalization of a known theorem
is no longer news"* is standing policy. **But the cheap thing should be named rather than left as a
gap**: `¬ Colorable(Parts-509, 4)` through the existing `UDCert` + LRAT chain would be the
**smallest kernel-certified 5-chromatic unit-distance graph anywhere**, at 509 vertices and 2442
edges — *smaller than Heule-510, which this repository already certifies* — so the machinery is
built and the instance is the smallest it has ever been handed. **Priced at an afternoon on the M06
pipeline and DECLINED for M63**, because it is a control on a calibration corpus rather than a
result, and because the objects that will need certifying are the ones our own pipeline finds.
Recorded so that *"we reproduced the record and never certified it"* is a decision and not an
oversight.

### (5) Vacuity guards, each with its own verdict word

- **`R(Atoms)` must hold before phase 1** — if the working graph itself does not keep the property,
  every claim downstream quantifies over an empty set. Verdict **`base-fails`**, its own word,
  folded into nothing. (This is the base-satisfiability guard the census already carries as control
  flow; it is here promoted to a value, exactly as `Arity.arityFloor_eq_zero_iff` did for the
  emptiness detector.)
- **`w* = w(Atoms)`** — nothing is deletable, `{M} = {W}`. Not vacuous but trivial. Verdict
  **`no-reduction`**.
- **`w* = 0`** — the empty selection keeps the property, i.e. `C` alone refuses four colours, so
  `W` is doing no work at all. Verdict **`companion-suffices`**, and it is a bug in the setup rather
  than a result.
