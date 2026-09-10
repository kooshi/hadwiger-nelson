# FS-32 — The reduction stage is a solved problem in another literature

> **RENUMBERED 2026-09-10: minted as FS-29, a number already taken by the overclaim check
> (`plans/STUB-vacuity-coverage.md` §Phase C, minted one day earlier on 2026-09-09). The older
> mint keeps the number; no content here changed.**

> **CORRECTED 2026-09-10 by Kooshi, and the correction changes the stub's whole shape: WE ALREADY
> HAVE GROUP-LEVEL MUS EXTRACTION, in `~/source/descent-engine`, and this stub's own gate — "does
> the tool take clause GROUPS rather than single clauses" — was answered in the affirmative a week
> ago by our own code. I recorded it as unverified without looking.**
>
> `crates/descent-sat/src/subset.rs`, `SubsetSolver`: one **presence literal per pool point** (a
> group of clauses, never a single clause), assumed true when present and false when absent; a
> refutation's **failed assumptions ARE a sufficient subset**, read by sweeping `allowed` so that
> `core ⊆ allowed` is structural; `search()` proposes that core and `confirm()` re-asks over exactly
> it, **descending while the core keeps shrinking** (`CORE_ROUNDS = 4`, a ceiling and not a target);
> and the universe can be **extended** with new points and edges while keeping everything learned.
> `crates/descent-cull/` is the group-level cull built on it — `GroupKind::{Cheats, Vertices}`, the
> necessity-is-permanent / droppability-is-not asymmetry as its concurrency argument, journal,
> resume, a fingerprinted group list, and a termination bound asserted in the shipped binary.
> Gate 269/269, verified independently by the owner.
>
> **And the ask's shape is an exact match for the type-M box test, which nobody noticed because the
> two milestones use different words for the same thing.** `decide(allowed, masks, budget)` takes a
> present subset and a **per-variable forbidden-colour mask** — and a *box* IS such a mask. So:
>
> | type-M descent (M62) | descent engine |
> |---|---|
> | the current `L` or `S` selection, by orbit | `allowed`, the present pool subset |
> | one box (the other side's pattern on the cross endpoints) | `masks`, a class |
> | — *nothing; the Python descent throws this away* — | **`core`: which orbits actually killed that box** |
>
> **That last row is the prize.** M62's descent asks *"does this drop still block every box?"* and
> gets one bit back, so it finds a drop size by a doubling probe: measured 2026-09-10, ~14 probe
> steps × 18,408 boxes ≈ **258,000 solves to choose one drop**. The engine's ask returns, per box,
> the minimal set of orbits that killed it — and since blocking is monotone upward in the selection,
> **the union of the per-box cores is a sufficient selection**, computed in **one** pass of 18,408
> solves as a by-product of refuting. That is ~14× fewer solves *and* a better answer than a prefix
> of a shuffled list. `subset.rs` says this in its own words: *"a refutation's failed assumptions are
> a kill set, computed by the solver as a by-product of refuting, where the reference finds one by
> deleting points and re-asking."* **M62's Python descent is "the reference" in that sentence.**
>
> **So the work is ADAPT, not import, and it is smaller than this stub assumed:**
> 1. a third `GroupKind::Orbits` — structurally identical to `Vertices` (a group whose deletion
>    removes a set of edges), and the type-M orbits are 1, 6, 12 or 24 vertices each;
> 2. the box test as the engine's ask — already its native shape, per the table above;
> 3. drive the descent from the **union of cores** instead of the doubling probe.
>
> **What is still genuinely NOT ours, and stays the literature import:** `confirm()` reaches a
> *locally* minimal core in at most four rounds; Liffiton–Sakallah / `forqes` reach the **minimum**
> by MCS hitting-set dualization. Parts's own algorithm is the dualization — so the minimum-seeking
> half of this stub survives intact, and the extraction half is already built and gated.
>
> *(Today's parallel box sweep, `tools/boxsweep.py`, is a crude stand-in for what the engine does
> properly: it wins 4× by fanning out and loses half of that by starting every worker cold, where
> the engine keeps one incremental solver and never rebuilds.)*

*Minted 2026-09-10 at Kooshi's direction ("stub all 3; I suspect we won't get anywhere until those
are addressed"). Found by Poros in the M62 review, `plans/POROS-2026-09-10-m62.md`. **Not yet acted
on.** Read `plans/M62-evolutionary-type-m.md` §R6, §R15 and §R11 first — they hold the measurements
this stub rests on.*

## The situation, for a session with no memory of M62

The goal of M62 is a 5-chromatic unit-distance graph smaller than the record of **509 vertices**
(`[Parts2020a]`, held at `~/source/library/pdf/arXiv-2010.12665-parts-509-minimization.pdf`).

The construction is `G = L ∪ ρS` — a large and a small point set, both drawn in `K = ℚ(√3,√11)`,
one rotated by `ρ` about a shared centre. Building it has two stages: **expansion** (add material)
and **reduction** (delete vertices while the graph still refuses four colours). M62 spent a night on
reduction, three rewrites, and got from 14,345 vertices to ~5,200. Parts got to 509.

## The finding

**"Smallest vertex subset preserving unsatisfiability" is a named, solved problem, and Parts
reinvented the standard algorithm in Mathematica without naming it.** Line numbers below are from
`pdftotext -layout` of the held PDF.

| his text | the standard name |
|---|---|
| `parts:479` — a set of vertices whose deletion loses the property | a **minimal correction set (MCS)** |
| `parts:560-566` — enumerate subsets "containing at least one vertex of each hyperedge", in increasing size | **minimal hitting-set enumeration over MCSes** — the Liffiton–Sakallah MUS/MCS duality |
| `parts:645-655` — his "8-4-2-1" grouping | **QuickXplain / delta debugging** |
| `parts:640-644` — *"to get the result True it takes an order of magnitude less time than to get the result False"* | the cost asymmetry M62 §R6 rediscovered by measurement and reported as a surprise |

**The literature has a dedicated smallest-MUS algorithm and a tool:**
- Ignatiev, Previti, Liffiton, Marques-Silva, *Smallest MUS Extraction with Minimal Hitting Set
  Dualization*, CP 2015 — `https://link.springer.com/chapter/10.1007/978-3-319-23219-5_13`
- `forqes` — `https://alexeyignatiev.github.io/software/forqes/`

**Not verified and it is the only thing the gate turns on:** whether the algorithm/tool accepts
**groups** of clauses (all clauses of one vertex, or of one symmetry orbit) rather than single
clauses. Our unit of deletion is a vertex or an orbit, not a clause. **Check that before anything
else** — Poros flagged this as recalled and unread.

## The calibrated test, which is the whole point

Do **not** point it at a fresh object. Point it at one whose answer is known:

> Run it on **Heule's 393-vertex `L`-subgraph with the `S`-subgraph fixed**, and see whether it
> reproduces the record's **374/375**. Parts took *"several tens of hours"* on a 4-core laptop in
> 2020 (`parts:722-726`). We have 32 cores and a 2015 algorithm he did not use.

- **If it reproduces 375 in an afternoon: the reduction stage is bought outright**, and everything
  left in M62 is the *expansion* stage — which is exactly where this project's own theorems live
  (the rotation sieve, FS-30) and where Parts's method has no arithmetic.
- **If it does not**, we learn the shape of the gap on an object with a known answer rather than on
  a search.

**Starting graphs are obtainable**: `parts:748` says the vertex lists are on the Polymath16 site.
Our own copy of Heule-510 with exact tower coordinates is at `tools/heule510.json`, and M62 §R3
verified that all 375 of its in-field points lie in the seam base.

## Why this is ranked as blocking

Parts's paper says **twice** that pure reduction is insufficient to reach a minimum —
`parts:622-623` (*"the minimal asymmetric graph is usually **not** a subgraph of the minimal
symmetric graph"*) and `parts:806-808` (*"none of the 376-vertex graphs is an overgraph of any of the
375-vertex graphs"*). His method **alternates** expansion with reduction over an accumulative graph
`A = ⋃{M}` carrying *all* minimal graphs. M62's descent is pure reduction. So either we buy the
reduction stage cheaply and spend our effort on expansion, or we keep rebuilding his 2020 tooling by
hand at ten times his working scale (`parts:727-729`: *"the number of vertices is limited to about
1000"*; ours ran at 5,191–14,346).

## Deliverables

An honest verdict on the calibrated test with its wall-clock, the group-granularity check answered
yes or no, and — if it lands — the reduction stage replaced in `tools/typem.py` by a call-out, with
M62's own exact-box acceptance test (§R11) kept as the *expansion*-side filter where it belongs.
