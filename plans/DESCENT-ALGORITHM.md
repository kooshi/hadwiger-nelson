# The batch descent — the algorithm, self-contained

*Written 2026-08-26 (mid-M51), on Kooshi's instruction that the method be documented to
paper standard before any paper exists. This is the reference statement of the loop that
M49 §R8–R10 discovered, M50 turned into a batch engine, and M51 runs at scale. The
per-milestone records (`plans/M49…M51`, §R sections) carry the measurements and incidents;
this file carries the algorithm. Kernel citations are to `Proofs/HadwigerNelson/`.
**Revised 2026-08-31** (Kooshi: "update the descent algorithm document with everything you've
discovered or improved upon") with iteration 3's commit, the second descent move (vertex
deletion), the sub-batch step and the class-count law that forces it, the minimum-halo theorem,
the adoption discipline for engine-produced lists, the engine's own findings, and the loop as a
product. Every number here traces to `plans/M51-descent-engine.md` §S-CONT or the engine's
`plans/WO-*-outcome.md`.*

## The object and the dial

The seed is Exoo–Ismailescu's 214-point graph `H` on distances {1, 2}: kernel-checkably
6-chromatic material whose forcing leans on 446 distance-2 edges — the **cheats**. Define
**μ** = the fewest non-unit edges of any non-5-colourable {1, d}-graph reachable from the
seed by this construction. The two ends are theorems (`OneDefect.lean`): μ = 0 is a
6-chromatic unit-distance graph, i.e. χ(ℝ²) ≥ 6 outright; and **μ = 1 already suffices** —
one forced-equal pair at distance ≥ ½ closes χ(ℝ²) ≥ 6 through the spindle theorem
(`not_colorable_of_forced_equal`). So the campaign is a descent of the dial: replace cheat
edges by unit-distance material, one certified batch at a time, until one cheat remains.

Two waypoints are guaranteed en route, both armed as halt clauses:

- **The crossing.** The spare-colour lemma (`SpareColour.lean`: a k-colourable graph admits
  no pair compulsion at k+1 colours) forces the unit-distance part to become 5-chromatic
  before the cheats grow scarce — at that commit the campaign has minted a **new
  5-chromatic unit-distance graph**, an independently certifiable intermediate result. The
  χ(unit-part) monitor runs at every commit.
- **The jackpot.** Any state with μ ≤ 1 HALTS the loop for verification: the kernel finishes
  from there with no further search.

## One iteration

**0. The floor.** Recompute which cheats are provably essential *alone*: a cheat is in the
floor iff deleting only it admits a separating colouring (a proper 5-colouring the full
object refuses). The floor is a rigorous lower bound on μ for the current object, and it is
the batch: the edges worth attacking are exactly the ones proven to carry load. (Widening
beyond the floor was measured empty at M51 §1w — present edges have zero mono-mass on
separating lists, so no principled ordering of non-floor cheats exists yet.)

**0′. Vertex deletion — the second descent move** (found 2026-08-28 on Kooshi's question
"what about shrinking the entire graph?"). A seed vertex made **edgeless** — its index kept, its
point kept as a possible glue parent, every edge at it removed — takes all of its cheats off
the dial at **zero geometry**: nothing is added, so nothing needs exact coordinates or a halo.
It is legal exactly when the object minus that vertex still refuses every proper 5-colouring
(the same certificate as a commit: one-hot and 3-bit encodings both UNSAT). Deletion is
monotone — a vertex deletable now stays deletable as vertices go, not as halo material
arrives — so a single-vertex census followed by greedy composition (largest cheat-load
first, confirmed by the certificate at each step) gives a maximal, not maximum, set; three
orders were measured within 2 of each other (95, 95, 93 cheats freed). On iteration 3's
object this removed **28 seed vertices carrying 102 cheats (95 live)** in one certified
commit, 393 → 298 — three times the campaign's largest halo commit, for nothing. The rule for
re-running it: after any halo commit, since new material can make a vertex deletable again
(the one case monotonicity does not cover). Consequence for the object model: the seed block
that names a class is no longer a prefix of the vertex order but a **gather** of the live seed
vertices (186 of 214 here) — every consumer of a class key had to learn this, and the engine's
first real run on such an object refused rather than enumerate a different stage (WO-7, INC-2).

**0″. The cull — the third descent move, and the one the record never had** (M52,
2026-09-02/03). A standing cheat is **redundant** when the object's committed material together
with the OTHER standing cheats already forces the pair without it; redundancy is JOINT, not
single — a set `D` of cheats may be dropped together exactly when `unit ∪ (standing ∖ D)` still
forces `205 = 206`. Like deletion it costs **zero geometry**: nothing is added, so nothing needs a
halo or exact coordinates, and the dial falls by the size of `D`. Two exact instruments: (i) **by
enumeration** — for a batch `B`, the enumerator lists every separating-colouring class of the
object with `B` absent (a class is exact by V1–V3), and the minimum hitting set of the classes'
violated-cheat sets is the exact optimal kept subset of `B` (`tools/cull_enum.py --loop`; a batch
that is JOINTLY redundant is one refutation with zero classes — the cheapest possible verdict, and
how the first 100 of 246 candidates fell on the iteration-4 object); (ii) **by group-MUS** —
`descent cull --groups cheats` (WO-14): a fresh hard-clause probe per candidate over the standing
set, refutations accepted as drops, satisfiable answers folded as witnesses, several same-snapshot
refutations unioned into ONE fresh chunk ask. The invariant both keep: **every kept cheat is
individually necessary, with a witness** — a separating colouring proper on everything else that
violates exactly it — and necessity is monotone under removing more cheats, so a kept cheat stays
kept forever and the final standing set is 1-minimal. After a cull the floor IS the standing set.
Two facts fixed the cull's cost, both measured at M52: the reference cull had stalled on the CNF
it handed the solver (guarded selector literals with the palette order over the unit edges alone
sat undecided at 1,302 s where hard clauses decide in 121 s — the encoding, not the compute), and
near minimality the refutations dominate and accepted drops are sequential (a refutation against a
stale snapshot licenses nothing: at twelve workers one drop per ~2 minutes whatever the width — the
chunk is the repair, the licence-holding tuning is WO-16). **The rule for re-running it: after
every halo commit** — new material makes more cheats jointly redundant (G33's compounding, seen
directly: at the iteration-4 object's floor 246 of 273 cheats were droppable ALONE, and the joint
cull dropped 122 of them in a day), so the cull is a standing per-iteration phase, and its number
is the object's certified upper bound on μ. What the cull cannot do: a copy of the unit part
rotated by a spindle angle is 4-colourable material attached by a few dozen chords, and at five
colours the fifth colour colours around it — the copies that make a 5-chromatic unit graph (M52,
T15) kill no class and drop no cheat; they are witnesses, not descent material.

**1. Enumerate S.** Delete the batch hypothetically and enumerate **every** proper
5-colouring the weakened object admits, up to palette symmetry, projected to the seed
(verdicts provably depend only on the 214 seed digits — the halo re-solves as free
variables). Exact blocking-clause enumeration, every leaf closed by UNSAT: `S` is the
complete list of jobs the deleted cheats were doing. It grows fast with batch weakness —
684–5,366 per single edge at M49, 51,350 for the seed's floor, 46,350 at iteration 3 —
and **2,588,314 at iteration 4** (batch 85: 46 replaced + 39 floor), the class count
multiplying by roughly **1.11 per added cheat** (46,350 · 1.11²⁵ ≈ 2.9 M). The reference
enumerator (Python, one solver process per class, ~3.7 s/class) cannot produce a list of that
size in any useful time; the Rust engine did it in about 45 minutes of restarts on 4–28
threads, with every leaf's closing refutation observed and the written file re-verified on
fresh solvers (V1 ∧ V2 ∧ V3 — self-verification by an independent code path, which is a
different kind of evidence from an oracle comparison and is recorded as such).

**1′. The sub-batch.** A class list for batch `B` contains, for free, the list of every
sub-batch `B′ ⊆ B`: exactly the lines proper on the put-back edges `B ∖ B′` (putting an edge
back is adding a constraint; nothing is re-solved). So the full floor is enumerated **once**,
the **put-back curve** is read from it (`tools/subbatch.py`: per class one bit per floor edge;
greedy put-back of the edge that leaves the fewest survivors), and the iteration spends the
largest sub-batch whose class count sits at the scale the later phases are priced for.
Iteration 4's curve: two floor edges at one vertex carry 69 % of all 2.59 M classes; putting
back 11 of the 39 leaves **37,316 classes with 28 cheats still spent**; 20 leaves 3,186. The
chosen sub-batch is then enumerated **fresh** (its own palette-canonical representatives — a
filtered list carries the parent batch's breaking order, which downstream must never read),
and the fresh count must equal the filter's prediction: two code paths that share nothing,
agreeing (37,316 = 37,316; 3,186 = 3,186).

*What the sub-batch costs, honestly.* (i) Fewer cheats per iteration — 28 of 39 here; the
held-back edges stay in the floor and return next iteration against a richer lattice (G33).
(ii) The deferred edges are, by construction, the ones whose removal opens the most colouring
freedom — the width-shaped kills, thousands of weak points cooperating — so the greedy choice
defers exactly the removals that are most expensive per cheat; this is a cost we would have
paid anyway, moved later, and possibly cheapened by growth. (iii) Not lost: soundness (the
certificate is unchanged) and composition-by-construction within the iteration (the halo is
still designed against the whole sub-batch's list). (iv) Genuinely lost: whatever a halo
designed against the FULL batch would have learned from the interaction of all 39 removals at
once — the classes outside `S′` are exactly the colourings that are monochromatic on some
put-back edge, and they stay killed the old way, by that edge, until it is spent. Whether the
joint design would have been smaller than the sum of the sequential ones is unmeasured; the
minimum-halo theorem below says the halo is dominated by single wide classes, which argues the
loss is small. (v) The greedy put-back optimizes class count, not dial progress per unit of
compute; each cheat counts one on the dial, so this is the right proxy unless a cheat's
downstream cost is known — which the profile measures only after the choice.

**2. Build the pool.** The continuum of points at unit distance from the object is made
finite by a theorem (`PartnerLattice.lean`): a point useful to any colouring argument must
have ≥ 2 neighbours in the object (a 1-neighbour point is greedily colourable, hence
inert), and every such point is one of exactly two intersections of two unit circles
(`Glue.eq_gluePoint_of_unit_pair`). The **depth-1 pool** is therefore the complete,
enumerable set of pairwise glue points of the current object — 394,604 points over the
1,008-point iteration-3 object — with no number field chosen in advance: the fields are
whatever the intersections generate. On a vertex-deleted object the pool is built about
**live** pairs only, with every object location — deleted vertices included — excluded as a
candidate. Engineering note: the reference pool build is a serial Python pass over ~1.7 M
pairs (40+ minutes on the desktop for the 1,862-point object); it is the first phase the loop
binary (below) must own, since the engine consumes the pool only as an export.

**2′. The pool by field (Kooshi, 2026-09-03; conditional).** Every point of the object is in
K = ℚ(√3, √11) (T14), and a glue point of two K-points adjoins one square root of an element of K
(the lattice-closure lemma, `plans/STUB-field-wall.md`), so the depth-1 pool splits by the square
class of its radicand: on the iteration-4 object 15 % in-field, 3 % in the √5/√35/√2/√14 classes,
81 % in non-rational classes — and every committed point so far is in-field. If the out-of-field
kill census (M53's first row) reads zero, the pool is RESTRICTED to the in-field slice for every
iteration until a wall: ~6× off the pool build, the profile's memory and the design's candidate
set, with the compute exponent paid in the smaller currency. Soundness is the restricted-pool rule
already in force (T11, K3): a kill on the restricted pool transfers; a survival is adopted as
unknown against the full pool. The monitor that survives the restriction: once per iteration, one
batch's in-field survivors re-asked on the full pool — an out-of-field-only kill is the field wall
arriving (RISKS R1), and it lifts the restriction.

**3. Profile.** For each colouring in S: fix it on the seed, free every halo and pool
variable, and ask whether it extends properly to the **entire** pool. `killed` = some
finite unit-distance subset refuses it (unit material can do this cheat's job here);
`survives` = it extends to the whole pool, a **proof** that no depth-1 halo of any size
kills it; `unknown` = solver cap, never folded into either side. Tiered engine
(empty-domain → strong rung → peel → greedy witness → full solve), every tier individually
sound, order measured not assumed. From iteration 4 the profile is the Rust engine's
(`descent replay`, verdict-exact against 45,365 reference lines at WO-2; the ask phases learned
the gathered block at WO-10). Thread count is a measured rule, not a preference: on the
desktop's 16 physical / 32 logical cores, concurrent solvers run at 0.78× solo speed already at
16 copies (memory-bound at the physical core count) and aggregate throughput rises only 8 %
from 16 to 32 while per-ask latency worsens 2.5× — so memory-tight and wall-capped phases run
at the physical core count and only bulk conflict-capped phases oversubscribe.

**3′. The profile's tail, and the pool choice that pays for it** (iteration 4, 2026-08-31). The
shortcut tiers decide the bulk of a list in minutes (26,857 of 37,316 classes at iteration 4, all
killed, 0.4 % reaching the complete solver); the cost is the classes that need the complete
solver over the whole pool — 100–1,800 s each at 1.47 M points, arriving in RUNS of consecutive
class keys. Measured on the 42 hardest: a pool **restricted to points with ≥ 3 object neighbours
or unit-degree ≥ 12** (285,973 points, 19 % of the pool) kills all 42 in 6,582 s against 20,609 s
on the full pool — 3.1× faster with identical verdicts — while a pool restricted harder (109,654
points) kills 26 with 16 undecided at the conflict budget, and the 5,151 points with ≥ 3 object
neighbours alone kill none: **too small a pool makes the refutation harder, not easier**, and the
width regime lives in the two-object-neighbour points cooperating (1,464,545 of the 1,469,696
have exactly two). So the profile is tiered by POOL as well as by ask: the tail runs on the
restricted pool first (an acknowledged pool choice — kills transfer to the full pool by
monotonicity, and the smaller solver admits more workers), and only its survivors and unknowns
are re-asked on the full pool. Two measurement cautions the same experiments produced: **a
class's complete-solver time is not reproducible on the same export** unless each ask starts a
fresh solver (the engine keeps a worker's solver across asks for the learned-clause reuse it
measured; the same seven classes read 0.02–1.9× of their earlier times under a different history —
paired comparisons need `--solver-reset`) — and that reuse is worth a great deal: the same 207
classes cost 3,073 s from cold against 1,361 s with each worker's solver kept, single hard asks up
to 250× cheaper warm, so a worker's solver is kept for the run and never rebuilt per ask; and the
cheap tiers are contention-sensitive too (the same 200 refutations cost 302 s at twelve busy
workers and 186 s beside seven).

**4. Hitting set.** Every colouring not provably killed (survivors AND unknowns — the
conservative fold) must stay dead the old way: each is monochromatic on some batch cheats,
so compute the exact minimum set of cheats hitting every such colouring (ILP). Those are
**kept**; the rest of the batch is **committable**. The kept count is the next floor
estimate — provisional downward only, since an `unknown` later resolved can shrink it
retroactively (the checkpoint's verdict order permits exactly that revision and no other).

**5. Design.** For the committable sub-list: extract from the pool **one halo killing every
colouring at once** — greedy set-cover over per-colouring kill cores, then chunked
delta-debugging of the union down toward minimality. Designing one halo against the whole
batch's list is what makes removals **compose by construction** (M50's correction of M49,
where kills designed edge-by-edge proved context-dependent and composed only sequentially).

*How small a halo can be — a theorem, and the regime it exposes* (WO-9, 2026-08-31). The shrink
reaches a **1-minimal** halo, and 1-minimal is not minimum: different deletion orders reach
different 1-minimal halos. But a **criticality witness** for a point `v` — a colouring that
survives on halo ∖ {v} — is downward-closed (fewer points, fewer constraints), so every halo
that is a *subset* of the current one must keep every witnessed point. Iteration 3's halo has
**845 witnessed points of 854**: no point-removing pass can save more than nine (1.05 %), and
switching classes among their recorded alternative kill sets saves nothing (a from-scratch
greedy hitting set lands at 1,694). The reason is structural: **four classes cover the whole
halo, and one class alone needs 844 of the 854 points** — a single colouring whose kill is
thousands of weak points cooperating. This is the *width regime* the design phase meets as
"stalls" (277 at iteration 2, 32 in iteration 3's single fresh run — the "zero stalls" first
recorded there came from fifteen invocations adopting a Python cover's points, a G21 instance
now corrected), seen from the halo's side: the halo IS the union of a few wide kills, and the
kills are wide because the colourings they answer have that much freedom. The one lever left
is the shrink's deletion order; nothing in the mechanism family can reach below the witnessed
floor.

**6. Certify.** Add the halo with **exact geometry** (every unit edge an algebraic
identity, sympy-verified, labelled-precision fallback recorded per edge), remove the batch,
and certify the new object — kept cheats included — refuses all proper 5-colourings, in
**two independent SAT encodings**. The profile and hitting set are advisory; this
certificate is the sole truth-maker, and it cannot inherit an error from them: a design
misled by any earlier verdict produces a REFUSED certificate ("a separating colouring
exists — investigate"), never a silently weakened object. Two disciplines added at
iteration 4: **adoption by re-derivation** — an engine-produced class list becomes the
campaign's only after the campaign re-derives its stage fingerprint from the object and the
header's batch, checks the batch is a sub-batch of the recorded floor, reads the engine's
exact-and-verified claim, and re-validates every line against its own definition of a
separating colouring (a planted corrupted line is refused); and **the certificate is
checkpointed** — the lookup re-check per colouring is parallel and resumable, exact geometry
is resolved lazily (an eager pass over every deep halo point cost one commit 10.9 idle hours),
and no phase longer than fifteen minutes may hold its state only in a process.

**7. Iterate.** The committed points spawn new pairwise glue points, so the next pool is
strictly richer — the search space compounds rather than the search trying harder (G33).
Measured: colourings that provably survived iteration 2's whole pool (46 of them) are
extinct against iteration 3's — 46,186 killed / **0 provable survivors** / 164 capped.

## The computability tightrope

*(Kooshi's observation, 2026-08-26, adopted as the sizing principle.)* Each iteration is
sized at the edge of the affordable: a wider batch admits a superlinearly larger S
(hundreds of thousands of colourings), a narrower one makes no provable progress. The
floor is what keeps the loop on the line — the batch is *discovered* (the provably
essential set) rather than chosen by ambition, and |S| is the price signal. The
consequence for engineering: solver throughput is not a convenience but the **dial's own
gearing** — the Rust engine (descent-engine repo, WO-1 landed: solver-free tiers ~250×
per core, verdict-exact against 45,365 reference lines) exists to move the affordability
frontier, which widens the batch, which steepens the descent. Two of the engine's own findings
belong in the algorithm's record because they are about the search, not the code: the
enumerator's cube tree was **grown blind** — when no class exists yet the split rule falls back
to the first vertex of the degree order, which the palette breaking pins to colour 0, so four
of five children are empty by construction and the tree collapses to one leaf (WO-11's
diagnosis, retrodicting every earlier run's leaf sizes exactly; the fix is that growth is
never blind, a 64-class census sufficing for the loop); and **a task boundary costs about one
second** — the first solve on a rebuilt solver, 30× the price previously recorded — which is
what makes leaves a budget rather than a free resource. Accumulated blocking clauses, by
contrast, cost nothing measurable (first-hundred vs last-hundred solve medians 0.9–1.5×).

**On memory locality** (Kooshi's proposal, 2026-08-31: assemble the graph in memory so that
cache-level groups hold unit-distance material — driven by the unit edges, not by position, since
"the vast majority of points near a point are not at all useful to it"). The measurement that
bounds it: on the 1.47 M-point pool, the fraction of unit edges whose endpoints share a cache-sized
block is 0.000 (L2-sized, 512 points) / 0.021 (L3-sized, 32,768) in the raw order, and a fast
cache-topology-sized grouping (`tools/pool_groups.py`: capped two-level multi-source-BFS cells on
the unit graph, sizes read from sysfs, 25 s, approximate by design) lifts it to **0.056 / 0.198** —
while RCM and a Morton curve barely move the median index gap between unit neighbours (429 k →
255 k / 207 k). **The unit-distance graph of a dense point set is well-mixed**: a point's ~8 unit
neighbours lie on a circle through ~280,000 other points, so no ordering makes most propagation
local; grouping bounds the spread to a ring of blocks rather than eliminating it. Whether the
remaining locality buys measurable time is the paired A/B (fresh solver per ask) recorded in
`plans/M51-descent-engine.md`; the loop binary treats the grouping as a cheap stage-assembly
pass whose size parameters are measured on the host, never configured. The timed verdict on this
object (paired, fresh solver per ask, verdicts identical): totals favoured the grouping 1.53× on
seven complete solves, but per-class ratios scattered 0.20–3.87× — **permuting the variables
changes the solver's search trajectory, and that variance dwarfs the locality effect at any
affordable sample** — so the grouping is filed as a cheap bounded pass, not a multiplier, and any
future locality claim must be measured against trajectory noise first.

## State of the descent

| Iteration | Object | Cheats removed (cum.) | \|S\| | Profile verdict | Floor after |
|---|---|---|---|---|---|
| seed | 214 pts | 0 / 446 | 51,350 | — | 29 |
| 1–2 (M50) | 1,008 pts | 43 | 45,365 lines (24,810 classes) | 46 survive / 103 unknown | 17 |
| 3 (M51) | 1,008 → 1,862 pts | 53 / 446 (certified 2026-08-28; halo 854) | 46,350 | **0 survive** / 164 unknown | 20 |
| 3′ vertex deletion | 1,862 pts, 186 live seed | 28 vertices → cheats 393 → **298** (certified, zero geometry) | — | — | 39 |
| 4 (M51) | 1,862 → **1,981 pts** | 78 / 446 (25 by a 119-point halo, certified 2026-09-02; sub-batch 28 of 39) | full 2,588,314 → sub 37,316 | 0 survive / 142 unknown (never folded) | 27 |
| 4″ the cull (M52) | 1,981 pts, zero geometry | **273 → 151 standing at the last reading** (122 dropped jointly redundant; 27 floor + kept cheats each witnessed; the Rust culler finishing the tail) | per batch: 0 … 307,716 classes | — | after the cull the floor is the standing set |
| the copies (M52, a tangent) | 3,933–9,789 pts | none — a ρ₁₅ copy kills 0 of 15,218 classes at five colours | 15,218 = 15,218 | — | the unions are 5-chromatic unit witnesses; every point of the object in ℚ(√3, √11), the copies in ℚ(√3, √5, √11) |

Every claim above traces to a build artifact (checkpoints, certified commit rows with
stated claim scope, the jobs ledger) or a kernel theorem; the per-milestone §R sections
hold the incident record — including the three instrument bugs found by controls, which a
paper reports as methodology, not omits.

## The loop as a product — the server target

*(Kooshi, 2026-08-31: "the deliverable for the 128-core server could be a single binary that
runs the whole algo in a loop, churning out iterations, until it hits some unforeseen wall and
we can analyze its output and refine." The server: 128 cores, 1.5 TB.)*

The loop above is one iteration; the product is the loop run unattended, each iteration's
artifacts written in the forms this document names, halting only on a clause it can state.
The **halt clauses** are already defined: μ ≤ 1 (the jackpot — halt and verify); the unit-part
crossing 4 → 5 (halt and certify the new 5-chromatic witness); a REFUSED certificate (halt and
investigate, never retry); an empty floor with cheats remaining (the dial has stalled below
the floor's reach — a mathematical wall); a sub-batch curve with no affordable point (the
computability tightrope failing — an engineering wall); and any hardware event. Everything
else is a phase that must run without a person: the table is the honest coverage today.

| phase | reference (Python, `tools/batchkill.py`) | engine (Rust, `descent`) | for the loop binary |
|---|---|---|---|
| 0 floor recompute | `--recurse` (single-deletion census, cadical, checkpointed) | **`cull --census`** (WO-14: 273/273 agreement, hard encoding) | done |
| 0″ the cull | `tools/cull_enum.py --loop` (exact per batch over `enumerate` + hitting set; one refutation per jointly-redundant batch) | **`cull --groups cheats`** (WO-14: group-MUS, chunked acceptance; WO-16 tunes the licence pool) | done; run after every commit |
| 0′ vertex census + deletion commit | `--vertex-census`, `tools/vertex_delete.py`, `--commit-deletions` | `cull --groups vertices` (WO-14, the halo shrink; seed deletion still Python) | port the seed-deletion commit; the halo shrink is done |
| 1 enumerate | cubes (3.7 s/class) | **`enumerate`** (verified gather; WO-11 makes it parallel) | done |
| 1′ sub-batch curve + fresh enumeration | `tools/subbatch.py` + `enumerate` | WO-8 stub (the filter) | port the curve (bit masks, trivial); the enumeration is done |
| 2 pool | `--pool-only` (serial, 40+ min) | export consumer only | port: pairwise glue points, dedupe, neighbour structure — geometry in f64 with the provenance triples the certificate resolves exactly |
| 3 profile | Python tiers | **`replay`** | done |
| 4 hitting set | scipy MILP over survivors ∪ unknowns | — | port: tiny instance (tens of columns); exact ILP or branch-and-bound |
| 5 design + shrink | cover + ddmin (Python) | **`design`** (checkpointed, resumable) | done; WO-9's order knob pending |
| 6 certify + commit | lookup re-check, one-hot + 3-bit UNSAT, exact geometry (mpmath 250-digit from provenance; sympy for shallow edges) | — | port: the two SAT asks are the engine's own ask; exact geometry needs arbitrary-precision arithmetic in Rust (a provenance-driven evaluator at fixed high precision, with the labelled-precision fallback the record already uses) |
| monitors | χ(unit-part), field census, weighted-ladder scan | — | χ(unit-part) is one ask; the others are columns, not gates |

Three consequences for the binary's shape. **The certificate stays the sole truth-maker**: a
loop that trusts its own profile is the M49 warning ("profile advises, certificate decides")
turned into a bug, so phase 6 is the first port to review, not the last. **Every phase
checkpoints at its acceptance points** and the binary resumes from the last one — the
standing rule, and on a 128-core box the rule is what makes a multi-day run survivable.
**Thread counts are derived from measurement per phase** (physical-core count for memory-tight
and wall-capped phases; oversubscription only for bulk conflict-capped asks), and the memory
model prices each phase before it runs — 1.5 TB removes the profile's narrowing on this
object but not the discipline. **And the server is dual-socket, so the binary is NUMA-aware**
(Kooshi, same day): workers pinned per node, every solver's memory first-touched by its own
pinned thread, the pool export replicated per node rather than shared across the interconnect,
cross-socket traffic a printed column that can refuse a phase — because the solvers are
memory-bound at the physical core count, and remote memory would make two sockets perform as
one. The order of work: land WO-11 (parallel enumeration) and the
v0.9/v0.10 contract, then port phases 2, 0, 4 and 6 in that order (pool first because it is the
serial bottleneck today; certify last because it needs the arithmetic and the review), then
the driver loop with its halt clauses. That is the engine's roadmap after the current work
orders, filed as its own stub.

