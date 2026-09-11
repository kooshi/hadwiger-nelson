# STUB — reproduce `[Parts2020a]`'s algorithm, end to end

> **OPENED 2026-09-10 as M63** (`plans/M63-parts-reproduction.md`), which supersedes this stub and records
> where its frame was wrong.

*Minted 2026-09-10 at Kooshi's direction: **"the next session will be 100% repro of his algo. The
session after that will be introducing our new angle on it, as described in the stub."** The stub
holding the new angle is `plans/M62-evolutionary-type-m.md`; this file is the rehearsal it needs.
Written for a session with **zero memory of the one that found this** — everything load-bearing is
restated, and every claim carries where it was checked.*

---

## §0 — Why this milestone exists, in one paragraph

We spent a day making the reduction stage fast. It got fast: a certified 1-minimal object now takes
minutes where none finished in 43 minutes before. **And it cannot reach the record, because the
record-holder says so in print.** `[Parts2020a]` §6: *"none of the 376-vertex graphs is an overgraph
of any of the 375-vertex graphs"*, and §5.8 names the mechanism — **"overcompression": "the minimal
asymmetric graph is usually not a subgraph of the minimal symmetric graph (this is especially
noticeable for S-subgraphs)"*. Nine of our 1-minimal descents land at 582–609 with the target 509
**eleven standard deviations** below their mean. That is his theorem, measured on our own arena.
So the deliverable here is not a faster descent; it is **his search shape**, reproduced.

---

## §1 — The reading debt this milestone starts by clearing, because it has bitten three times

`BIBLIOGRAPHY.md` line 27 carried **`READ 2026-09-09 … §§3–5 re-read at the M62 gate — the METHOD`**.
Section 5 has **eleven** subsections and section 6 has **five** tables. FS-31 discovered §5.6 had
been skipped; on 2026-09-10 §5.4, §5.5, §5.7, §5.8, §5.9, §5.10, §5.11 and Tables 2–6 turned out
never to have been opened either — **and they contain both the algorithm and the record's own
specification.** `G50`, three times, on one paper. The entry now carries **per-section markers**;
keep it that way and do not write another whole-paper `READ`.

**Where the paper is.** `~/source/library/pdf/arXiv-2010.12665-parts-509-minimization.pdf`, and a
layout-preserving text extraction at **`~/source/library/notes/parts-2010.12665-layout-text.txt`**
(1,098 lines, made with `pdftotext -layout`). Line numbers below refer to that file.

**Still unread and named so it is not lost:** §5.1–§5.3, §5.9 (SAT encoding) beyond the two levers
quoted in §5 below, §5.10's worked example in detail, §5.11, and Tables 2, 5, 6.

---

## §2 — His algorithm, quoted rather than paraphrased

**The loop (§5.5, line 470).** Alternate **expansion** and **reduction** of an accumulative graph `A`.

1. **Expansion** — add vertices from the base `B` to `A`, giving the working graph `W`.
2. **Reduction, phase 1** — build a **hypergraph `Y`**. *"A hyperedge of degree `n` is a subset of
   `n` vertices of `W` such that deleting all `n` vertices at once leads to loss of the key
   property … any proper subset of the vertices of a hyperedge should not lead to the loss …
   Hyperedges are sought stepwise, in increasing order of their degree."*
3. **Reduction, phase 2** — *"the key property is checked for **all possible subgraphs of `W`
   containing at least one vertex from each hyperedge of `Y`**. The verification is performed
   stepwise **in order of increasing number of vertices**… terminated if at some step at least one
   subgraph with the key property is found."*

Then *"a new accumulative graph `A` is formed, **combining all the found minimal graphs `{M}`**. The
iteration is considered successful if it leads to … either a reduction of the order of the minimum
graph `M` **or else to an expansion of the set `{M}`**."*

**`{M}` is the unit of work and this is the piece we have no analogue for.** Table 1 (line 770): at
374 vertices there are **1,092 non-isomorphic minima** whose union `A` is only 412 vertices; at 375,
282 minima with `A = 403`. We produce **one** 1-minimal object per descent.

**Phase 2's enumeration, concretely (§5.7, line 556).** Operate on the sets of **deleted** vertices,
which are much smaller. Take the **maximal independent sets** of the degree-2 hyperedge graph; to
each add all *free* vertices (in no hyperedge of degree 1 or 2); split on any contained hyperedge of
degree ≥ 3; **order by decreasing number of deleted vertices**; discard any that cannot beat the
current best.

**Degrees actually used (§6):** *"hyperedges of degree 2 or 3 for L-subgraph, and of degrees 3 or 4
for S-subgraph."*

**Expansion (§5.6, line 512).** Fill **partially occupied** base orbits of `A`, and/or add new
orbits from a **reserve graph `R`**. An orbit joins `R` *"if, when added to the graph `A`, the degree
of some of its vertices is at least 4"*; orbits are added in **decreasing vertex degree**. *"priority
should be given to partially filled base orbits, and especially to orbits with a small number of
vertices (6 or 12)."* And on escaping a local minimum (§5.8): *"increasing the number of new vertices
introduced in the expansion stage."*

**L and S are minimized separately.** §5.3 defines the **companion graph `C`** as *"for an L-graph,
it is an S-graph and vice versa"* — the other side is held **frozen as a literal subgraph**, which is
free, rather than enumerated as a pattern set, which is exponential. §5.11: the working graph is kept
to **about 1000 vertices**. Ours was 6,866.

**Accelerators (§5.8, line 578), ~100× in total, excluding SAT ones:** parallel computing;
input/output symmetry; one-time execution of repeated operations (extract the common part of the CNF
once, §5.9); **use of the dependence of SAT check time on the result**; and SAT symmetry breaking.

**Two SAT levers we do not use (§5.9, line 675).** *"symmetry breaking clauses assign different
colours to the vertices of a specific **3-clique** `Q ⊂ V`. **The choice of `Q` significantly affects
the speed.** For M-type graphs, good results are obtained by using the vertices of `L` with
coordinates `(0,0)`, `(1,0)`, `(1/2, √3/2)`."* And: *"We order the vertices by **increasing the
Euclidean distance from graph center**, which gives good results."* `typem.cnf_for` pins exactly one
vertex. **This is a different lever from the value-precedence encoding measured FLAT in FS-32 §R3** —
a rainbow triangle kills the palette symmetry outright for three unit clauses and no new variables.

**His budget (§5.10, §6).** ~10⁵ checks at ~10 s each on a 4-core laptop, *"several tens of hours"*,
Mathematica 10. **Our counterexample-guided search does 10⁵ asks in eight minutes.** Compute is not
the gap by three orders of magnitude.

---

## §3 — The record, specified

**`data/m62/parts509-orbit-fillings.json`** — Tables 3 and 4, transcribed and checksummed here:
**37 L-orbits summing to exactly 374**, **14 S-orbits summing to exactly 136**, sharing the orbit
`(0,0,0,0)` at filling 1, so **374 + 136 − 1 = 509** vertices and 2442 edges (L 1860, S 564). Two
independent checksums: the §6 running text (line 741) and Table 1's own L and S rows.

**A correction to our own record made 2026-09-10:** `BIBLIOGRAPHY.md` had said *"509 = 375 + 135"*.
It is **374 + 136**. The wrong split generated a whole false lead — it made the 510→509 gap look like
shared-centre bookkeeping, when Parts in fact makes `L` one **smaller** and `S` one **larger**.

**What the tables do NOT give:** which members of a *partially* filled orbit are taken. §6 says
unfilled orbits *"usually include exactly half or a quarter"* — i.e. whole orbits of an index-2 or
index-4 subgroup, so the residual choice is a **subgroup** choice, not a subset choice. Six L-orbits
and four S-orbits are partial.

**Where the vertex lists are.** §6: *"Lists of the vertices of some graphs can be found on the
Polymath project website [11]"* — ref [11] is *"Comments in Polymath16, thread 15, comment 24942,
March 7, 2020 (see also Polymath16/Code and data/This dropbox folder/JP/Large)."* All eighteen
threads are held at `~/source/library/notes/polymath16-threads-1-18-text.txt`; comment 24942 is not
in that fetched text, and Parts posts Dropbox links in the corpus. **Fetching it is the cheapest
possible baseline and should be tried first.**

---

## §4 — The base, and the radius that has now bitten twice on the same label

**His base (§5.6):** `B = ⊕⁴H²`, *"choosing orbits that fall **completely or partially** on a disk of
radius `r = 2`"*. Because the order-24 group does **not** preserve a Euclidean disk (FS-31's own
finding: two of the twenty-four elements are Galois, an orbit carries two squared norms `n` and
`σ(n)`), an orbit *meeting* the disk carries points **outside** radius 2. Our `parts_lattice(r)`
keeps points whose **both** disks are within `r`, which is a different set.

**Measured 2026-09-10:**

| `r` | base points | orbits | group-closed | contains Heule-510 | contains `(0,0,6,6)` |
|---|---|---|---|---|---|
| 2.00 | 1,603 | 92 | yes | **no — 473/510** | no |
| 2.44 | 3,433 | 179 | yes | **yes, exactly** | **no** |
| 2.52 | 3,877 | 199 | yes | yes | no |
| **2.60** | **4,513** | **229** | **yes** | yes | **yes** |

`(0,0,6,6)` has true radius **2.5243** and is named in §6 as one of the two orbits whose addition
produced the record. **So the reproduction base is `parts_lattice(2.6)` at minimum**, and the honest
construction is *whole orbits meeting the radius-2 disk*, which should be implemented directly and
compared against the 2.6 truncation rather than assumed equal.

---

## §5 — What exists already, and what it measures

**Tools (all in `tools/`, all written 2026-09-10):**

| file | what it does |
|---|---|
| `typem.py` | the base (`parts_lattice`), the order-24 group, orbits, the `ρ₁₅` cross-edge law, `Arena`, `refuses_four`, `grow_to_refusal`, `shrink` |
| `mkstate.py` | CNF state from an arena + a present-set, at **orbit** or **vertex** granularity |
| `symstate.py` | the same at **intermediate output symmetry** — the `24 → 6 → 3 → 2 → 1` rungs |
| `census.py`, `census_run.py`, `census_worker.py` | the single-deletion census = **his degree-1 hyperedge layer**; parallel, per-ask checkpoint, exact resume, fingerprints |
| `descent3.py`, `descent2_worker.py` | descend-then-census; gallop-then-bisect on the droppable prefix |
| `exact.py` | **his §5.5 in modern form**: implicit hitting set with minimal correction sets; reports a rigorous rising lower bound and an upper bound as a sandwich |
| `hyperedges.py`, `hyperedges_run.py` | the **degree-2** layer, with the rotation collapsing ~187,000 pairs to ~31,000 — **written and never run** |
| `lns_worker.py`, `lns_guided.py`, `lns_run.py` | swap-LNS and counterexample-guided repair |
| `lowerbound.py` | hitting-set bound from harvested correction sets |
| `census_control.py` | the permanence claim's negative control, with its discrimination half |

**Measured on the 757-vertex closure of Heule-510 (`/tmp/arena244.pkl`, `/tmp/st757*.pkl` —
regenerate, do not assume they survive):**

- **The census collapses to 47 asks, not 756, exactly.** All 24 group elements are automorphisms and
  an orbit-closed selection makes `v` and `g(v)` isomorphic deletions. Controls: every member of
  orbits of size 6, 12, 24 gives constant verdicts. Result: 10 critical orbits / **144 vertices**.
- **Heule-510 is exactly vertex-critical**: 509 asked, 509 critical, 0 droppable, **40 s**.
- **Failed-assumption cores give ZERO free drops**, at vertex *and* at orbit granularity. The
  variable is how spread the refutation is, not group size.
- **The symmetry ladder, and it is the session's most useful new number:**

| output symmetry | best 1-minimal | spread |
|---|---|---|
| 24 | **624** — *exact* (OptUx over 47 orbit-halves, 168 s) | — |
| 6 | **576** | 576, 582, 588, 600, 600, 606, 606, 636 |
| 3 | **558** | 558, 582, 582, 585, 585, 585, 588, 594 |
| 1 (free) | 582 | 582 … 609 over ten orders |

**The free search is worse than both constrained ones**, which is exactly why his ladder exists —
and the rungs are **not nested** (overcompression), so 624 → 558 is not a descent.

- Best object here: **559 vertices** (558 + the hard centre), independently census-certified.
- Sandwich for the 757 closure: **147 ≤ minimum ≤ 559**, the lower half rigorous and rising.
- `exact.py` with the minimal-correction-set shrink produces correction sets of size **2 and 3** —
  **literally his degree-2 and degree-3 hyperedges**, discovered one at a time. The systematic
  parallel census in `hyperedges_run.py` is the accelerator for exactly this.

---

## §6 — The plan, and the controls it must pass

**Phase A — the baseline object.** Fetch ref [11]; failing that, reconstruct from
`data/m62/parts509-orbit-fillings.json` at `r = 2.6`, searching only the ten partial orbits over
index-2 and index-4 subgroup choices. **Control:** the result must have 509 vertices and **2442
edges**, and `refuses_four` must return UNSAT. *(Loose end to settle at the same time: our
`tools/heule510.json` has **2,504** edges where Parts's Table 1 gives the 510-vertex record
**2,502**. Our arena reproduces our 2,504 exactly, so the disagreement is with his table, not with
our geometry — but it is unexplained and it is two edges on the object everything is measured
against.)*

**Phase B — the hypergraph.** Degree-1 by the existing census; degree-2 by `hyperedges_run.py` with
the rotation collapse; degree-3 where affordable. **Control:** every hyperedge re-verified by an
independent rebuild of the induced graph, and no hyperedge may contain a lower-degree one entirely.

**Phase C — phase-2 enumeration (§5.7).** Maximal independent sets of the degree-2 graph, plus free
vertices, split on degree ≥ 3, ordered by decreasing deletion count. **The decisive unknown is its
SIZE**: his §5.10 worked example is *"slightly more than 10⁵ checks (compared to 10³⁵ for brute
force)"*. Count it before running it; if it does not fit, that is what the symmetry ladder is for and
the rung to enter at is the one where the count crosses the budget.

**Phase D — the loop.** `A = ⋃{M}`; expansion by partially-filled orbits first, then the reserve `R`
(degree ≥ 4 rule); L and S alternating against a frozen companion; symmetry `24 → 6 → 3 → 2 → 1`.

**Cheap items to fold in at the start, all measured or quoted:** the 3-clique pin, radial vertex
ordering, and the one-time CNF extraction. Solver: **CaDiCaL 1.5.3** measured best here (1.9.5 +19 %
worse on our trace, 3.0.0 ≥ 6× worse — the engineering advisor measured 1.9.5 8 % *better*, so that
row is a live disagreement).

**The standing house rules that apply, since a fresh session will not remember them being paid for:**
no word in a verdict vocabulary may mean "clean"; a cap is never a negative; every count carries its
enumeration; any phase over ~15 minutes checkpoints and resumes exactly; report inside a phase, never
only at its end; never stop a job by matching its command line; build only through `./scripts/build.sh`.

---

## §7 — What is running at the moment this stub was written

Kill or adopt deliberately; none of it is load-bearing for the reproduction.

- `tools/exact.py` on the 757 object, 7,200 s wall, writing `data/m62/exact757.json` (LB was 147).
- `tools/descent3.py` at symmetry 2, writing `data/m62/d757s2/`.
- Scratch states in `/tmp` (`arena244.pkl`, `st757*.pkl`, `heule_groups.json`, `best582.json`) —
  **regenerate rather than trust**; `/tmp` does not survive a reboot and this box has crashed before.
