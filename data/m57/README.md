# data/m57 — M57, additive rigidity (2026-09-06; `plans/M57-additive-rigidity.md`, results in §R)

The milestone's object is the **additive family** of a chunk — its admissible homomorphisms into a group of order k
(M56's `additive.py homs`) — inside the chunk's proper k-colourings, which carry moves (single-vertex recolourings,
Kempe swaps). The family is *additively rigid* when it is the whole colouring space; the reduction theorem
(`Proofs/HadwigerNelson/AdditiveRigid.lean`) turns rigidity at five colours plus a pair at a 5Λ-difference into
χ(ℝ²) ≥ 6. A necessary, solver-free condition is that the family is closed under every move, measured by the gauge

    γ(X, k) = Σ over (additive colouring, colour pair {a, b}) of (components of the {a, b}-subgraph − 1),

whose isolated-vertex part counts the *loose incidences* (a vertex whose neighbours miss some colour) and whose
remainder is the Kempe part. Every record carries the stage's edge-list fingerprint, its exact coordinate frame and a
`claim_scope`. Regenerate with `tools/additive.py` (`self-test-rigid` first: 17 planted controls, reproducing §S6).

**What a row licenses.** *`additively-rigid` is the untrusted enumeration's claim (a SAT blocking loop that ended
UNSAT) — it licenses nothing by itself; the kernel consumes it as a hypothesis. `not-rigid` carries a verified proper
non-additive colouring — a CERTIFICATE that the stage is not rigid. γ is exact when the family is complete and a lower
bound (printed `γ ≥ N`) when the family is a SAT sample; every `kempe-open` row carries a swapped colouring verified
proper on the stage's full edge list, and one tested `non-additive` (exact partition test against a complete family)
is a certificate of non-rigidity; γ = 0 proves nothing about rigidity. `capped` licenses nothing. A richness row with
zero homs licenses "no additive 5-colouring of that chunk" only when a unit vector lies in 5Λ (exact); a SAT UNSAT is
the solver's claim.*

| artifact | stage | subcommand | instantiates | what a reader may conclude |
|---|---|---|---|---|
| `closure-core122-k4`, `closure-core588-k4`, `closure-EI-seed-unit-k4`, `closure-hexball-{2,3}-k4` | the 122-core (seam lattice, field16 frame), the 588-core (K8), the seed's unit part (EI4), hex balls | `closure --k 4` | D3/D3′ (§M1.1): the Kempe-closure gauge | every K-chunk at four colours is `family-kempe-open` with loose incidences under BOTH residue colourings (γ = 200 / 182 / 126 / 36 / 60); every swap listed is a verified non-additive 4-colouring |
| `rigid-core122-k4`, `rigid-core588-k4`, `rigid-EI-seed-unit-k4` | the same three | `rigid --k 4 --cap 2000` | the enumeration | `not-rigid: 2000 of 2000` — the solver's first 2,000 four-colourings are all non-additive, at defects near the random baseline (67–78 of 122; 143–153 of 588; 128–147 of 214) |
| `closure-heule510-k5`, `closure-W-core-8over3-k5`, `closure-degrey1581-k5` | Heule-510 (field16), W (K247-16), the 1581 (field16; a 300-hom SAT sample, census capped at 200) | `closure --k 5` | D3′ at five | every additive 5-colouring of every witness is loose on 16–24 % of the vertices (γ = 3,014 / 147,456 / ≥ 76,115); every swap on Heule and W verified non-additive; the 1581's swaps `undecided` (sampled family) |
| `extend-W-core-8over3-k5` | W with its 71 depth-one cross points | `extend --pool … --colourings …` | D5 / §M1.5: the family delta | 71 of 71 extend (67 in-lattice, 4 of index 5); γ̄ moves by at most −1.4 % (the four index-5 points, by killing a third of the homs under the extension condition); the high-degree in-lattice points kill up to 110 of 200 sampled colourings and no additive one |
| `b2-seed-k5` | Exoo–Ismailescu's G and H (units + cheats), M49's 19 separating lists, the 252-cheat forcing subset | `tools/m57_b2.py` | D3′ on the {1, 2}-graphs; P3, P9, P10 | G: γ = 0 and its 18 colourings all additive (Kempe-closed and rigid, complete enumeration); H: γ = 12 = its 12 defect-1 colourings; H − e keeps its separating colourings within defect 5 for 13 of 19 refusers and admits random-baseline ones (79–90) for six; the 252-cheat object forces the pair with > 5,000 colourings in three defect regimes (≤ 14 / 16–28 / 94–105) |
| `richness-{degrey,heule,f247}-k5` | balls by squared radius in the gen-1 closure (regenerated exactly), Heule-510, the depth-2 F₂₄₇ stage | `tools/m57_richness.py` | D4 / §M1.6: the dial | Heule-510 keeps 3,456 homs to r² ≤ 3 and 96 on the whole; the F₂₄₇ depth-2 stage has NO ℤ/5-hom at any radius — 98 % of every ball's unit vectors lie in 5Λ (exact: L7 at depth one); the de Grey gen-1 closure (crystalline: 329 directions among 11,053 points within radius 1, rank 32, no unit in 5Λ) KEEPS ≥ 300 homs at every radius, the whole 24,065-point closure included (358 directions, 269 unit classes mod 5, no unit in 5Λ): the family never dies on de Grey's crystalline closure (§R5 addendum) |
| (no `extend-W-plus-cross-depth1` record) | the depth-one grown stage (W + its 63 cross points) | `extend --depth1 …` | D5 | `vacuous`: the grown stage has no admissible hom (500 of W's unit vectors lie in 5Λ of the joint lattice), so there is no family to extend — the cumulative dial in §R5 shows 1,728 → 960 → 640 → 0 as the points accumulate |

The kernel piece: `Proofs/HadwigerNelson/AdditiveRigid.lean` — `IsAdditive`, `AdditivelyRigid`, the bridge from homs,
`forces_of_additivelyRigid`, the plane corollaries, the unit path as the model (χ(ℝ²) ≥ 3) and two reds; on axioms
exactly `[propext, Classical.choice, Quot.sound]` (`scripts/Axioms.lean`, the M57 block).
