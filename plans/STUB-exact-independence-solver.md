# FS-65 — an exact independence number for the window planes

*Minted 2026-09-18, out of the `q = 19` measurements (`data/fs62/q19/README.md`), where two off-the-shelf exact
solvers failed on a 361-vertex graph and the reason turned out to be structural rather than a matter of budget.
Read beside: `CLAUDE.md` G56 and G59 (the wall), G57 (the clique numbers), `plans/STUB-fractional-wall.md` (FS-57,
the same target from the other side), `plans/STUB-six-is-not-a-value.md` §2a (the normalization and the failures).*

---

## 1. The question

> **Compute `α(UD(𝔽_q, 2))` exactly at the window members `q ∈ {23, 27, 31, 43, 47}` and at `U₆₄`,** where every
> exact solver anyone ships fails, and where the gap between the best known set and the best certificate is the only
> thing standing between this project and the wall at six.

At `q = 23` the entire question is **four integers**: the best known set is 87, six needs 89, and the certificate
says ≤ 105. *Is `α(23)` equal to 87, or is it 88, 89, …?* An exact answer ends it.

## 2. Why this is a route to the wall, and where it stops

On a vertex-transitive graph `χ_f = q²/α` exactly, so:

* **`α < ⌈q²/6⌉` ⟹ `χ_f > 6` ⟹ `χ ≥ 7`.** An exact `α` below the threshold **closes that member of the wall**
  outright — no relaxation, no certificate, no rounding.
* **The converse does not hold.** `α ≥ ⌈q²/6⌉` leaves `χ ∈ {6, 7}` and still needs an exhibited six-colouring.

So FS-65 can *close* the wall but cannot *open* it, and that asymmetry is the honest headline. It is the same finite
half FS-57 attacks, from the opposite direction: **FS-57 pushes an upper bound on `α` down; FS-65 pushes the exact
value up.** They meet at the same integers, and whichever arrives first retires the other at that member.

## 3. Why the off-the-shelf tools fail — measured, not assumed

`data/fs62/q19/` (2026-09-18). On `UD(𝔽₁₉,2)`: 361 vertices, 20-regular, 3,610 edges, 5.6 % density — which *looks*
squarely inside branch-and-reduce's comfortable range.

| solver | result | the tell |
|---|---|---|
| KaMIS `weighted_branch_reduce` | **70**, timed out, no optimality proof | `reduction_time 0.003` — nothing reduced |
| KaMIS `struction` (`--struction_degree=20`) | **66** | reduction phase finished in 26 ms, nothing reduced |
| local search, 1 h × 24 threads | 76 | finds it in seconds |

Three structural reasons, each of which a new solver must answer:

1. **No reduction rule can ever fire.** Degree-1, degree-2 folding, domination, twins, unconfined — every rule works
   by finding a vertex that *differs from its neighbours*. A vertex-transitive graph has none, by definition. The
   kernel is the whole graph, always.
2. **Triangle-freeness destroys the pruning bound, and it is decided arithmetically.** Branch and bound prunes with a
   clique cover. At `q = 19`, 3 is a non-residue so the graph is triangle-free (G57), its only cliques are edges, the
   best clique cover is a matching, and the bound is `n/2 = 180` against a truth `≤ 80` — off by 2.3×, so nothing
   prunes. Which members suffer this is exactly `ω = 2` in G57's table: **31 and 43**, and 19.
3. **Symmetry multiplies the tree instead of dividing it.** `|Aut| = q²·(q+1)·2` — 14,440 at 19, 25,392 at 23,
   162,712 at 43 (and 122,472 at 27, where Frobenius adds a factor 3 — the value FS-54 records, which checks the formula) — and no MIS solver breaks it, so every partial set is rediscovered thousands of times.

**The property that makes the algebraic instruments work is precisely what defeats the combinatorial ones.**

## 4. Deliverables, cheapest first

| # | deliverable | cost | why it might work |
|---|---|---|---|
| D1 | **Re-ask the decision problem in SAT, with the symmetry breaking this repository's own toolchain section prescribes** — origin pinned by vertex-transitivity, the stabiliser's rotation/reflection symmetry broken, one instance per `k` | hours | ledger row 68 records *"CDCL undecided on every independence instance at 19 and 23"* — but `CLAUDE.md` § Toolchain records a **measured 72×** from breaking value symmetry on colouring instances and states that an unbroken encoding's verdict measures the encoding. At 19 this is four decision problems (`k = 77…80`), not an optimisation |
| D2 | **A MIP with published symmetry handling** — SCIP 10.0's symmetry machinery, or Schreier–Sims cuts, with the ratio bound as cutoff and the best known set as an incumbent | days | the stable set problem under symmetry is exactly the subject of `[HojnyEtAl2023]`; the instrument is off the shelf and the *configuration* is the work |
| D3 | **The circle decomposition — the novel algorithm, and it is specific to these graphs** | a week | §5 |
| D4 | **Orbital branching / isomorph-free generation**: branch on `Aut`-orbits rather than vertices, canonicalise each partial set | open | standard in the symmetry literature, absent from every MIS solver tried |

**D1 RUN 2026-09-18, AND IT IS A CHARACTERISED NEGATIVE** (`data/fs62/q19/README.md`). The instrument is correct — at `q = 11` it reproduces the kernel-checked `α = 28` from both sides (SAT at 28 in 0.2 s, UNSAT at 29 in 22 s), both in the single and the cubed form, and at `q = 19` the encoding is shown to *admit* the known 76-set by pinning that set in, with no solver. **But `k = 78` at `q = 19` does not resolve, and two measurements say why.** (i) **Splitting stops paying**: the split rate rises with depth — 23.3 % at level 1 (multiplier 0.47), 49.2 % at level 2 (0.98), 62 %+ at level 3 (**1.25**) — so the frontier grows instead of shrinking, because level 1 clears the easy space and what remains resists division. (ii) **A bigger budget is not the fix**: three of the 239 level-1 cubes that survived the 90 s cap were re-run at **420 s each and 0 of 3 resolved**, so the cap was never the binding constraint. 1,109 cubes were refuted and **no set of 78 was found anywhere**, which is weak evidence in the reading's direction and nothing more — a refutation needs every cube. A single undivided run is the calibration: **UNKNOWN after a full hour**. *What D1 leaves behind: two controlled instruments, 785 reusable top-level refutations, and the knowledge that the hardness is in the instance rather than in the encoding or the budget — which is the case FOR D2 and D4, the symmetry-aware exact methods, and against any further tuning of this route.*

## 5. The circle decomposition, which is what "novel" means here

`𝔽_{q²}*` is cyclic of order `(q−1)(q+1)` and the unit circle `μ_{q+1}` is its subgroup of order `q+1`. So the plane
is the origin together with **`q − 1` circles of `q + 1` points each** — the norm classes, the cosets of `μ_{q+1}`.

An independent set picks a subset of each circle. Two facts make this a decomposition rather than a relabelling:

* each circle carries a free `ℤ/(q+1)` rotation action, so its subsets need only be enumerated **up to rotation**;
* whether a point of circle `i` and a point of circle `j` are adjacent depends only on their positions, so the
  compatibility between two circles is **one fixed relation, computable once**, not a per-pair test.

That turns `α` into an optimisation over **`q − 1` variables** — 18 at `q = 19`, 22 at 23, 42 at 43 — each ranging
over subsets of a `(q+1)`-cycle, with pairwise constraints and a linear objective. **No existing solver knows this
structure**, which is exactly why the general-purpose ones fall through to blind branching.

**SIZED 2026-09-18, AND IT FAILS — D3 is closed in the form stated above.** The sizing test this paragraph called for was run and the decomposition does not survive it. A circle's induced subgraph is nearly empty: at `q = 19` only **190 of 3,610 edges** lie inside a circle, and **8 of the 18 circles have no internal edge at all**, so the per-circle domain is essentially every subset — `2^(q+1)`, which is **1,048,576 at `q = 19`, 16.8 million at 23 and 1.8 × 10¹³ at 43**. The framing *"an optimisation over 18 variables"* hides that each variable has a million values; the 153 pairwise compatibility tables would hold 10¹² entries each, and the naive product is 10¹⁰⁸. **Precomputed pairwise relations are impossible and the decomposition as stated is dead.** What survives is not an algorithm but a structural fact worth keeping: a circle of norm `r` has internal edges **exactly when `2 − 1/r` is a trace on the unit circle** (`|z−w|² = 2r − Tr(z w̄)`, and `Tr` on the norm-one circle takes `(q+1)/2` values) — derived independently and matching the measurement at `q = 19` on all 18 circles, `r ∈ {2,3,5,6,9,10,11,12,14,16}` predicted and found. *A branch-and-bound over circles that computes compatibility on the fly is not excluded by this count, but it would need pruning strong enough to cross a 10¹⁰⁸ product, and nothing here suggests where that would come from.* **Recorded because the first version of this count checked ONE circle and reported its zero as if it held for all** — the flattering answer, caught by auditing a result that had made the arithmetic clean (G21).

## 6. Expectations, and the clauses that matter

* **D1 succeeds at 19 and fails at 23** (medium-low confidence). If it succeeds at 23 the wall's smallest member is
  settled and this stub's rank jumps.
* **The Paley analogy is a warning, not a verdict.** The independence number of Paley graphs is famously open, with
  the trivial `√q` essentially unimproved, and these are close cousins. But Paley graphs are *pseudo-random* and
  these are not: at `q = 27` an exhaustive subspace-periodic search already found the best known set (117), so
  structure does exist here and the circle decomposition is a bet on that structure.
* **The trap, named in advance because this stub has already sprung it twice:** *"the graph is small"* is not
  evidence that it is easy. 361 vertices at 5.6 % density defeated two exact solvers in an afternoon. Price a method
  by what its bound and its reductions can see, never by `n`.
* **Informative failure:** D3's domain count coming back astronomically large. That is a finding, costs an
  afternoon, and closes the novel half of this stub honestly.

## 7. Prior art owed (WORKFLOW 3a), before any derivation

1. **Exact independence numbers of Cayley graphs on `𝔽_{q²}` with a multiplicative-subgroup connection set** — in
   that literature's words, not ours. Shared with FS-62 §5 item 5, whose first pass already returned a negative:
   `[Hopkins2018]` shows the representation-theoretic route reduces, on abelian groups, to the ratio bound we hold.
2. **Paley and Peisert graph independence numbers** — what is proved, what is open, and what the best exact
   computations reach. This is the family's nearest well-studied neighbour and the honest calibration of difficulty.
3. **Orbital branching and symmetry handling for the stable set problem** — `[HojnyEtAl2023]` (Schreier–Sims cuts, arXiv:2311.06085) is
   the entry point; also whether any published work computes `α` for *these* planes at any `q > 11`.
4. **Under two disciplines (G49):** combinatorial optimisation (stable set, symmetry handling) and finite geometry
   (caps, arcs, and distance-avoiding sets in `𝔽_q²` — where a maximum independent set here is a largest set whose
   difference set misses the unit circle, and that phrasing may already have a literature).

A negative is a finding and goes in §PA either way.
