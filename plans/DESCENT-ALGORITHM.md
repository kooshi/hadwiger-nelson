# The batch descent — the algorithm, self-contained

*Written 2026-08-26 (mid-M51), on Kooshi's instruction that the method be documented to
paper standard before any paper exists. This is the reference statement of the loop that
M49 §R8–R10 discovered, M50 turned into a batch engine, and M51 runs at scale. The
per-milestone records (`plans/M49…M51`, §R sections) carry the measurements and incidents;
this file carries the algorithm. Kernel citations are to `Proofs/HadwigerNelson/`.*

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

**1. Enumerate S.** Delete the batch hypothetically and enumerate **every** proper
5-colouring the weakened object admits, up to palette symmetry, projected to the seed
(verdicts provably depend only on the 214 seed digits — the halo re-solves as free
variables). Exact blocking-clause enumeration, every leaf closed by UNSAT: `S` is the
complete list of jobs the deleted cheats were doing. It grows fast with batch weakness —
684–5,366 per single edge at M49, 51,350 for the seed's floor, 46,350 at iteration 3.

**2. Build the pool.** The continuum of points at unit distance from the object is made
finite by a theorem (`PartnerLattice.lean`): a point useful to any colouring argument must
have ≥ 2 neighbours in the object (a 1-neighbour point is greedily colourable, hence
inert), and every such point is one of exactly two intersections of two unit circles
(`Glue.eq_gluePoint_of_unit_pair`). The **depth-1 pool** is therefore the complete,
enumerable set of pairwise glue points of the current object — 394,604 points over the
1,008-point iteration-3 object — with no number field chosen in advance: the fields are
whatever the intersections generate.

**3. Profile.** For each colouring in S: fix it on the seed, free every halo and pool
variable, and ask whether it extends properly to the **entire** pool. `killed` = some
finite unit-distance subset refuses it (unit material can do this cheat's job here);
`survives` = it extends to the whole pool, a **proof** that no depth-1 halo of any size
kills it; `unknown` = solver cap, never folded into either side. Tiered engine
(empty-domain → strong rung → peel → greedy witness → full solve), every tier individually
sound, order measured not assumed.

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

**6. Certify.** Add the halo with **exact geometry** (every unit edge an algebraic
identity, sympy-verified, labelled-precision fallback recorded per edge), remove the batch,
and certify the new object — kept cheats included — refuses all proper 5-colourings, in
**two independent SAT encodings**. The profile and hitting set are advisory; this
certificate is the sole truth-maker, and it cannot inherit an error from them: a design
misled by any earlier verdict produces a REFUSED certificate ("a separating colouring
exists — investigate"), never a silently weakened object.

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
frontier, which widens the batch, which steepens the descent.

## State of the descent

| Iteration | Object | Cheats removed (cum.) | \|S\| | Profile verdict | Floor after |
|---|---|---|---|---|---|
| seed | 214 pts | 0 / 446 | 51,350 | — | 29 |
| 1–2 (M50) | 1,008 pts | 43 | 45,365 lines (24,810 classes) | 46 survive / 103 unknown | 17 |
| 3 (M51, in flight) | 1,008 → TBD | 43 → 53 pending certify | 46,350 | **0 survive** / 164 unknown | 7 pending |

Every claim above traces to a build artifact (checkpoints, certified commit rows with
stated claim scope, the jobs ledger) or a kernel theorem; the per-milestone §R sections
hold the incident record — including the three instrument bugs found by controls, which a
paper reports as methodology, not omits.
