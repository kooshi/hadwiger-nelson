# STUB — overcompression as a face phenomenon: the orbit-filling polytope of a level set

> **SUPERSEDED 2026-09-10 by `plans/M64-orbit-filling-polytope.md`, which is the subplan.** Kept
> verbatim below because it is the record of what was believed when the milestone was minted, and
> two of its beliefs were overturned during subplanning. **(a)** §3's C1 — that `Prof` is the integer
> points of a low-complexity polytope — is the *small* half: the dominant structure is a perfect
> matching of 24 atom pairs derived from the degree-2 layer of `Y`, giving two exact conservation
> laws that account for 100 of the L side's 108 box exclusions before convexity is invoked at all.
> **(b)** §5's claim that the harvested correction sets are *"the `hypergraph` field of each reduction
> record"* is **FALSE** — that field holds cardinalities only, and `Y` itself was discarded; making it
> an artifact is M64 phase A. §4's phases 1, 2 and the core of 4 were run during subplanning and their
> results are M64 §0.

*Minted 2026-09-10 at Kooshi's direction, at the M63 mid-point, to be worked in the session after
this one's compaction. Written for a reader with **zero memory of the session that minted it** —
every term is defined, every number carries where it was measured, and the falsifiers are named
before the work starts. The seed was Poros's advisory spitball at the M63 subplanning gate; the
data that makes it live was measured the same day and is on disk.*

---

## §0 — Why this exists

**The record's own author names an obstruction and does not explain it.** `[Parts2020a]` §5.8:

> *"the minimal asymmetric graph is usually not a subgraph of the minimal symmetric graph (this is
> especially noticeable for S-subgraphs)"*

and §6, concretely:

> *"none of the 376-vertex graphs is an overgraph of any of the 375-vertex graphs"*

He calls it **overcompression**, treats it as a search-engineering nuisance, and moves on. It is why
a straightforward shrink cannot reach 509: nine certified 1-minimal descents on our own arena land
at **582–609** with 509 **eleven standard deviations** below their mean, which is his sentence
measured on a different object.

**A mechanism for it would be derivation-shaped, which is what the goalposts ask for.** Kooshi,
2026-09-06: *"The derivations are an order of magnitude more important than individual objects."*
And it would transfer: whatever governs *"the best symmetric object is not above the best
asymmetric one"* is a statement about search landscapes over orbit-filling spaces, and M62/FS-6's
own search lives in exactly that space.

**The conjecture in one sentence:** *overcompression is not a fact about graphs, it is a fact about
faces — the minima at different symmetry rungs are minimisers of one linear functional over
different affine slices of one lattice polytope, and two faces of a polytope generally have no
containment relation.*

---

## §1 — The objects, defined

Fix the base `B` (`tools/parts_repro.Base`, `[Parts2020a]` §5.6's lattice, radius 2.6), with
**orbit set `O`** under the order-24 group `Aut B`; an orbit has size 1, 6, 12 or 24.

- **Profile.** A selection `S ⊆ B` has `f(S) ∈ ℤ^O` with `f_o(S) = |S ∩ o|`, so `|S| = Σ_o f_o`.
  Parts's Tables 2–7 are exactly these vectors, and he says they are the informative view:
  *"The orbit-filling tables are usually more informative than the graph image, and allow one to
  compare different graphs and to devise directions of further attack."*
- **`R`** = the refusing selections (`W u C` not 4-colourable). **Upward closed** — M63 §O.
- **`{M}`** = the minimum-size members of `R`; **`Prof` = f({M})`**, its profile set.
- **`Box`** = the bounding box of `Prof` intersected with the hyperplane `Σ f_o = |M|` — i.e. what
  Parts's per-orbit `{M}` ranges tell you and nothing more.
- **Stable / varying orbits** — his own vocabulary (§6): an orbit is *stable* when every minimum
  fills it identically, *varying* otherwise.
- **Rung.** For `H ≤ Aut B`, an `H`-invariant selection has each `f_o` equal to a sum of `H`-orbit
  sizes inside `o`, so `Prof(H) ⊆ Λ_H`, an **affine sublattice** of `ℤ^O`. `H = Aut B` forces
  `f_o ∈ {0, |o|}` (the box's vertices); `H = 1` allows the whole box. **The rung is a slice.**

---

## §2 — The measurement already in hand, and it is the first of its kind

**Nobody has had this data before.** Parts held 1,092 minima at 374 and published only per-orbit
*ranges*; the complete profile set was never reported. M63 produced **two complete level sets** —
every minimum at a level, with a proof that the level is complete (`exhaustive-level`, zero
undecided asks) — so `Prof` itself is computable rather than boxed.

Measured 2026-09-10, `data/m62/m63-profiles-S.json` and `-L.json`:

| | S-side, 136-vertex level | L-side, 375-vertex level |
|---|---|---|
| minima (as found) | **48** | **3,264** |
| **distinct profiles** | **4** | **27** |
| minima per profile | 12.0 | 120.9 |
| orbits touched | 14 | 35 |
| **stable / varying** | **11 / 3** | **31 / 4** |
| slack over the stable floor | 2 vertices | 10 vertices |
| integer points of `Box` | 5 | **135** |
| **fill fraction `\|Prof\|/\|Box\|`** | **0.80** | **0.20** |

**Two things fall out immediately.**

**(i) The profile is a huge compression of the level set and the profiles are sparse in the box.**
3,264 minima collapse to 27 profiles, and those 27 occupy one fifth of the integer points the
per-orbit ranges permit. If `Prof` were simply *"every box point with the right sum"* there would be
no polytope to find and this stub would be empty. It is not.

**(ii) The varying orbits reproduce his published ranges, and where they differ that is itself a
finding.** S-side, against his Table 4 M6A `{M}` column — **three for three, exactly**:

| orbit | his range | ours |
|---|---|---|
| `(0,4,0,0)` | 4–5 | **4–5** |
| `(6,2,4,0)` | 14–16 | **14–16** |
| `(6,0,4,6)` | 7–9 | **7–9** |

L-side, against Table 2's `375` `{M}` column — the same four varying orbits, two ranges identical
and **two of ours WIDER**:

| orbit | his range | ours |
|---|---|---|
| `(4,0,10,2)` | 2–6 | **2–6** |
| `(6,2,8,0)` | 6–10 | **6–10** |
| `(2,0,6,4)` | 0–4 | **0–6** |
| `(10,0,2,4)` | 8–12 | **6–12** |

**Two live explanations, and separating them is the first phase's job.** Either his enumeration at
375 was truncated — §5.5 grants him *"The check can also be terminated if the number of checked
subgraphs at some step exceeds a threshold"*, and M63 §3 flagged `|{M}|` as possibly-truncated with
no way to check — or our stage is a genuinely wider problem, since `A451 u ρS136` carries **24**
connection edges where his minimal subtype M6A uses **18**, and more connection edges is a weaker
constraint on the L side. **This is checkable and it decides whether `|{M}| = 282` is a count or a
lower bound.**

---

## §3 — The conjecture, in three parts, each with its falsifier

### C1 — `Prof` is the integer points of a low-complexity polytope

> There is a polytope `P` with few facets beyond the box and the sum hyperplane such that
> `Prof = P ∩ ℤ^O`, and the facets have a reading in terms of the hypergraph `Y` (the minimal
> correction sets).

*Why it is plausible rather than decorative.* A minimum must hit every correction set, and a
correction set that lies inside a single orbit gives a **linear** lower bound on that orbit's
filling; one spanning two orbits gives a linear inequality across them. So the hitting-set
constraints project to inequalities on profiles, and `Prof` is contained in that projection. **The
conjecture is that the containment is tight, or nearly so.**

*Falsifier.* `Prof` is not convex-representable — i.e. some integer point of `conv(Prof)` on the sum
hyperplane is not in `Prof` and cannot be excluded by any inequality derived from `Y`. Measurable
directly at 4 varying coordinates: 135 candidate points, 27 realised, so **108 exclusions to
explain.** If fewer than half are explained by `Y`-derived inequalities, C1 is weak.

### C2 — Overcompression is non-comparability of faces

> For `H' ≤ H ≤ Aut B`, `min{|S| : S ∈ R ∩ Fix(H)}` is attained on `Prof ∩ Λ_H`. Because `Λ_H` and
> `Λ_{H'}` cut `P` in different faces, a minimiser at the finer rung need not lie below one at the
> coarser rung — and *that* is overcompression, not a property of graphs.

*What would make it a theorem rather than a picture.* A condition on `P` under which containment
**does** hold (e.g. `P` a box, or the minimisers unique), plus a demonstration that the record's own
data violates it. The best shape: *if `Prof` is a full box then every rung's minimum is below the
next coarser rung's; the record's `Prof` is not a box (fill fraction 0.20), and the specific missing
points are exactly the ones a coarser rung would need.*

*Falsifier.* On our own symmetry ladder — best 1-minimal **624** (rung 24) / **576** (6) / **558**
(3) / **582** (1) — express each object as a profile and test containment directly. If the finer
rung's object **is** below the coarser one's every time, overcompression is not a face phenomenon
here and the conjecture dies on our own data.

*A trap to avoid, and it is our own number:* **the ladder's non-monotonicity (582 at rung 1, worse
than 558 at rung 3) is NOT evidence for C2.** Rung 1 admits every rung-3 selection, so its true
minimum is ≤ 558 by definition; 582 is a statement about our *search* failing in a bigger space, not
about the objects. C2 is about **containment**, never about the size ordering. Any phase that
conflates the two is measuring the search.

### C3 — The payoff: the expansion step becomes an integer program

> If `Prof` has a small inequality description, then *"which base orbits to add, and how much of
> each"* — Parts's expansion stage, the half of his loop that is entirely hand-driven — is
> optimisation over that description.

This is the one that pays. M63 §O(3) established that **his outer loop has no termination measure at
all**, and his own escape from a local minimum is *"increasing the number of new vertices introduced
in the expansion stage"*. Meanwhile the reduction half is now **exact and ~150× faster than his own
implementation** (M63 §R1), so the expansion is where every remaining gain lives — and it is the
one place M62's population method has something an exact solver does not.

*Falsifier.* The inequality description exists but is useless for expansion because the interesting
directions leave the current base's orbit set entirely — i.e. progress always comes from orbits with
`f_o = 0` in every current minimum, which no inequality over the present support can see.

---

## §4 — What to compute first, in order

1. **Fit `P` to the two level sets we hold.** 3 and 4 varying coordinates: enumerate the box, mark
   the realised points, compute `conv(Prof)`'s facets exactly (rational arithmetic, tiny), and
   report `|Prof|`, `|Box|`, `|conv(Prof) ∩ ℤ^O|`. **If `Prof = conv(Prof) ∩ ℤ^O`, C1 is met on
   this data and the facets are the object to explain.** Half a day, no solver.
2. **Explain the facets from `Y`.** Project the harvested correction sets (773 on the S side, 703 on
   the L side, both on disk) onto orbit coordinates and check which facets they generate. The
   degree-1 hyperedges give the stable orbits for free; the interesting ones are degrees 2–4.
3. **Separate the two explanations of the wider L ranges** (§2 ii): re-run the L reduction with the
   connection edges restricted to the M6A subtype's 18, and see whether `Prof` narrows to his. That
   also settles whether `|{M}| = 282` is a count or a truncation.
4. **Test C2 on the ladder** — containment, never size — using the four ladder objects and the
   held minima.
5. **Only then**, C3: state the expansion as an IP and test it against one of Parts's own recorded
   moves (his path is four states, M63 §4 phase E).

---

## §5 — Instruments, data, addresses

**On disk already** (all committed):

| what | where |
|---|---|
| the two complete level sets, with every minimum | `data/m62/m63-S166-reduction.json`, `m63-L451-reduction.json` |
| their profile sets, boxes and varying orbits | `data/m62/m63-profiles-S.json`, `-L.json` |
| the harvested correction sets by size | the `hypergraph` field of each reduction record |
| Parts's own 43 objects, exact | `data/m62/parts-ref11/JP/Large/` |
| his Tables 2–4 as checked data | `data/m62/parts-table2-orbit-fillings.json`, `parts509-orbit-fillings.json` |
| the base, group, labels, profiles | `tools/parts_repro.py` (`Base`, `fillings`, self-test) |
| the stage, the reduction, the level analysis | `tools/parts_stage.py`, `parts_reduce.py`, `parts_minima.py` |
| the reporting types that refuse a bare count | `tools/parts_report.py` |

**To build:** a profile/polytope module — box enumeration, realised set, exact facet computation,
and the projection of correction sets onto orbit coordinates. Small; the varying dimension is 3–4.

**Cost:** phases 1–2 are half a day and need no solver. Phase 3 is one reduction run (~10 min).
Phases 4–5 are a day.

**Bearing on χ(ℝ²) ≥ 6: indirect and honest.** This is a theory of search landscapes over
orbit-filling spaces, not a construction. Its value is that it would give M62's expansion step a
measure it does not have, and that it converts the record-holder's stated nuisance into a statement
with a proof. If it comes out empty — `Prof` a plain box, containment holding everywhere — that is a
clean negative that costs a day and retires the idea.
