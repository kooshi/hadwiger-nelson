# M52 — the copy-lock objects: anatomy, the cull, the shrink, and the choice (subplan)

*Minted 2026-09-02 on Kooshi's direction, numbered as minted (the earlier "M52" stub on the roadmap
map — the nominated-pairs gadget question — is renumbered to an unnumbered stub,
`plans/STUB-nominated-gadgets.md`, and keeps everything it held). M51 is DEFERRED at its iteration-4
commit, not closed: its next iteration is the milestone AFTER this one. Kooshi's framing, verbatim in
substance: "we hit a phase change … we have brand new objects we need to fully understand … M52's goal
is to study those deeply, find geometric intuitions about them, and decide where we go next … once we
have the strongest, fully studied, culled and shrunk object, then we either pivot based on new
grokkings or begin it-5 in earnest starting from this new object" — and, clarified the same hour:
**that choice is the next milestone; M52 closes at the decision.** Per the stub rule this file
carries everything the deciding session knew. Companion records: `plans/Q8-FIVE-CHROMATIC-OBJECTS.md`
(the object cards), `plans/STANDING-QUESTIONS.md` §Q8/Q9 (the construction and its controls),
`plans/M51-descent-engine.md` §S-CONT (the campaign log), `data/m51/` (the tracked snapshots).*

## 1. Mission context, in plain language

The project hunts new mathematics about the plane's chromatic number. The kernel holds
5 ≤ χ(ℝ²) ≤ 7. The live instrument is the **descent**: start from a graph with two kinds of
edges — unit edges and "cheats" (edges at distance 2, from the Exoo–Ismailescu seed) — that is not
5-colourable, and replace cheats with genuine unit-distance material, batch by certified batch. One
cheat left = a proof that the plane needs six colours (the spindle theorem, `OneDefect.lean`). Four
iterations have run (M49–M51): 446 → 273 cheats, the object growing from 214 to 1,981 points.

On 2026-09-01 Kooshi applied the χ = 5 constructions' own trick to the descended object: **copy the
unit part and rotate the copy** by the distance-2 spindle angle (cos 7/8, sin √15/8 — de Grey's ρ₁₅,
one field above the seam tower) about one of its vertices. The union refuses four colours: **a new
5-chromatic unit-distance graph**, verified at the tools level (three SAT encodings, every cross
chord unit to 250 digits), of a genre no published witness has — fabric grown by a certified descent
from a two-distance seed, plus one spindle copy. The lock is a property of the material: 176 of 186
live seed vertices and 818 of 1,648 halo points serve as centres; it arrived with iteration 3's halo
(depth-2 glue material) and survives the iteration-4 commit. Iteration 4 itself closed with a
**119-point halo** that Kooshi found "surprisingly elegant" — and a first look (2026-09-02, this
subplan's own measurement, §6 P1) says why: every one of its 1,061 unit edges points in one of six
directions, and all six are the seed's three direction families rotated by whole multiples of the
Moser twist arccos(5/6).

So we hold, for the first time, a **family of objects we built and do not yet understand**: the
iteration-4 object, its copies about several centres and both signs, and their compositions (a
four-copy union of 9,789 points). Nobody has finished culling the cheats of any of them (the best
partial cull, on the iteration-3-era object, stands at 184 kept of 298, with 131 asks undecided), and
the culls stalled on cost. This milestone (a) studies the objects until their geometry is named,
(b) builds a faster cull and runs it to completion on the objects that matter, (c) shrinks the
strongest one to a size the next iteration can afford, and (d) closes with the decision — the next
milestone is either iteration 5 from that object or a pivot the study earns.

## 2. The inventory (what exists, with addresses)

| object | points / unit edges / cheats | verdicts held | where |
|---|---|---|---|
| it-3-era base `…-vdel28` (fp `d6460615c957e19f`) | 1,862 / 12,735 / 298 | forcing certified (two encodings); floor 39 | `data/m51/m50-object-…-vdel28.json` |
| **it-4 committed** `…-vdel28-it2v2-depth1` (fp `f0871bab2b915b4f`) | 1,981 / 13,796 / 273 | forcing certified (one-hot + 3-bit); **floor 27, 0 unknown**; χ(unit) = 4 | `data/m51/m50-object-…-vdel28-it2v2-depth1.json`, floor `data/m51/m51-floor-it5-verdicts.jsonl` |
| it-3-era U ∪ R±₂₀₆(U) | 3,695 / 25,486 / — | k = 4 UNSAT, three encodings; 34 chords, 4 load-bearing | `build/m51-copyunion-rot-d2-about206-+28.9550.json` (float graph) |
| it-3-era U ∪ R±ᵥ₀(U) | 3,695 / 25,499 / — | k = 4 UNSAT, three encodings; 58 chords, none load-bearing alone | `build/m51-copyunion-rot-d2-aboutv0-+28.9550.json` |
| it-3-era four-copy union | 9,194 / 63,770 / 298 | k = 4 UNSAT 15 s; k = 5 zero-cheat SAT 4,704 s | stats `build/m51-copymulti-union.json` |
| **the 883-point core** (of it-3-era U ∪ R₂₀₆) | 883 / 4,625 / — | 1-minimal at k = 4, 0 unknown; 24 radicands | `data/m51/m51-copycore-about206-graph.json` |
| it-4 U₅ ∪ R₂₀₆(U₅) | ~3,930 / — / 273 | k = 4 UNSAT 6.3 s (36 chords) | recipe `data/m51/q8-transforms.json` |
| it-4 U₅ ∪ Rᵥ₀(U₅) | ~3,930 / — / 273 | k = 4 UNSAT 4.2 s (64 chords) | recipe |
| **it-4 four-copy union** | 9,789 / 69,091 / 273 | k = 4 UNSAT 6.6 s; 205 chords, 4 fused | stats `build/m51-copymulti-it5-union.json` |
| culls (all STOPPED at checkpoints, nothing running) | it-3-era plain: kept 184, necessary 53, 131 unknown at the 30 M-conflict pass; it-3-era copy: kept 204 (retired); it-4 plain and four-copy: control UNSAT 1,302 s, **zero acceptances** | `build/m51-copycull-*.jsonl` |

The lock-centre map, the controls (perturbed angles SAT; Moser angle SAT; the lock absent on the
seed and iterations 1–2, present from iteration 3), and the floor/endpoint censuses ("no cheat and
no seed vertex becomes redundant ALONE under one copy") are in the object cards. Everything in
`build/` is gitignored; `data/m51/` is the tracked snapshot and is refreshed at every commit
(standing rule from the 2026-09-02 double compaction). M52's own durable outputs go to `data/m52/`.

## 3. What "strongest" means (registered before any object is compared)

An object is a candidate iteration-5 base if its forcing is certified (unit ∪ kept cheats forces
205 = 206 at five colours, two encodings) and its exact geometry is a recipe over the seed
(provenance for glue points; centre + sign for rotated copies). Among candidates, **strongest** is
decided lexicographically:

1. **fewest kept cheats after the cull** (the dial μ; the whole point);
2. ties or near-ties (within 5 %): **fewest points after the shrink** (every downstream phase
   scales with the point count — the depth-1 pool roughly as its square);
3. then the field cost (distinct radicands adjoined — the certificate's price, `tools/field_census.py`).

The zero-cheat separation time (116 s single copy / 4,704 s four copies, k = 5) is recorded as a
hardness reading beside each candidate, never as a criterion: a solver's effort is not a property of
the object (T12, G21).

## 4. Decisions settled at subplanning (each in the four-part shape)

| # | choice | alternative weighed | why this one | confidence |
|---|---|---|---|---|
| D1 | **The cull is done by ENUMERATION**: for a batch B of standing cheats, the Rust enumerator lists every separating-colouring class of the current object with B absent (`descent enumerate` on the edges sidecar — the copies enter as ordinary non-seed material), and a minimum hitting set over the classes' violated-cheat sets is the exact optimal kept subset of B; batches proceed greedily; one certify ask closes each batch. `copy_cull3.py` (group-MUS on incremental solvers) stays as the CONTROL on one batch. | cull3 alone, parallelized on the 128-core server (the same method, more cores). | Exact within each batch and free of unknowns (an enumeration's leaves close by UNSAT under cubes — the same refutations, but cube-split; cull3's probes are whole-object refutations, and its 3 M-conflict pass returned "unknown" on nearly every probe); and its output is REUSED — the class lists are precisely iteration 5's phase 1, and each copy's kill mass over them is the composition dial for free. | medium — the batch-size law on the composed object decides it (§6 P7): if affordable batches stay below ~10 cheats there, F2 fires and cull3 on the server is the method. |
| D2 | The **iteration-4 family** is the subject (plain; copies about 206, v₀, and the top-ranked other centres, both signs; the mirror; the four-copy union). The iteration-3-era family is history and control only; the 883-core stays the certificate object. | Study both families in full. | Monotone containment: every it-3-era object is an induced subgraph of its it-4 sibling with 25 more cheats; the it-3-era culls' partial readings are recorded as what they are (an UPPER bound of 184 on that object's μ, not a completed cull). | high |
| D3 | The it-3-era plain cull is **retired at its checkpoint** (kept 184 / necessary 53 / 131 unknown) and finished ONLY if the server arrives during the milestone — as a decorrelated control on D1's method, at zero attention cost. | Finish it on the desktop (131 probes at 30 M conflicts ≈ 40+ h on three workers). | Superseded object; the exact cull of the better object answers the same question better. | high |
| D4 | **Compositions are RANKED by kill mass before any cull**: each candidate copy exported as a pool (points + unit adjacency, no provenance needed), `descent replay` over ONE fixed class list on the plain it-4 object; the ranking picks the composition(s) to cull. | Cull every candidate composition (days each). | Minutes per copy on the loop's own instrument; the profile is a dial (a fraction), not a search for a positive (G30). | high |
| D5 | **The shrink goes cheap-first**: (i) restrict the copy to the k = 4 core's copy side plus its radius-2 shell about the centre and re-certify (one ask per rung of a ladder), (ii) only then vertex group-MUS with presence selectors and solver cores over the copy side, checkpointed per acceptance, handed to the server if WO-3's replan lands in time; a partial shrink is a valid object (every accepted deletion is an UNSAT-verified step). | Shrink through the design engine per batch (the copy as the pool, a halo per batch) — that IS iteration 5 with copies, i.e. the next milestone. | The next milestone needs a base whose pool it can afford (a 9,789-point object's depth-1 pool is ~25× iteration 4's 1.47 M points); the ladder answers in hours whether the cheap object exists before days are spent. | medium — P8 is the fact. |
| D6 | **Kernel scope = the rotation grammar** (`Copy.lean`: the spindle rotation for a pair distance d as ONE definition with the Moser twist and ρ₁₅ as its d = √3 and d = 2 instances; a copy's self-chords lie exactly on the radius-d circle; the union of a unit drawing with its rotated image is a unit drawing). The **certificate of the 883-core is OUT** — priced in the object cards (per-edge compositum geometry over 24 radicands + the M42 LRAT template) and stubbed as a next-milestone candidate. | Certify inside M52. | The certificate is weeks of new geometry engineering, does not inform the decision this milestone exists to make, and the object may change (the it-4 family's own core). K1 (spare-colour) and K3 (monotone forcing) are already kernel theorems (`SpareColour.lean`, `Forces.mono`, M51 phase 0k). | medium — Kooshi's publication clause ("maybe our own certified 5-chromatic object, if what it reveals is interesting enough") is exactly what §7 phase 2 informs; if the mechanism is interesting the certificate competes with iteration 5 for the next milestone. |
| D7 | The anatomy instruments are **extensions of what exists**: a `copy_anatomy.py` census (direction classes labelled on the twist ladder, ring spectra about centres, cross-chord classification by field and by the kernel's collinearity law, symmetry search), the viewer gaining copy layers (`descentviz_refresh.py --transform`), and the M33 class-avoidance / core-shrink instruments reused unchanged at k = 4 on U. | A new visualizer. | Every instrument here has seen its planted red; the viewer is already published and Kooshi reads it. | high |
| D8 | Housekeeping is phase 0, not a footnote: the nominated-gadgets stub renamed unnumbered; M51 banner DEFERRED with its resumption point; ROADMAP's "next seven days" replaced by this milestone's order; `CLAUDE.md` § Paths forward gets the minting note (the Frontier rewrite is at close, as the rule says). | Leave the numbering as mapped. | Kooshi: "ordered as minted rather than as mapped." | high |

## 5. The cost anatomy this plan is priced on (desktop, 16 physical / 32 logical cores, 125 GB; every number machine-local)

| operation | measured |
|---|---|
| k = 4 ask on a copy union | 6–15 s single copy; 6.6 s four-copy (it-4) |
| k = 5 whole-object refutation (the cull's probe / certify) | one-hot 1,302 s (it-4 plain, cull3 control); 3-bit certify 8,228 s; it-3-era copy union one-shot 716 s; four-copy all-cheats 539 s |
| k = 5 separating witness (SAT) | 116 s single copy; 4,704 s four-copy (it-3-era) |
| cull3 probes | v2 median 737 s, mostly unknown at 900 s wall; v3 at 3 M conflicts nearly all unknown on fresh solvers; 30 M pass unpriced |
| enumeration (Rust, WO-6/7/11) | 85 absent cheats on it-4: 2,588,314 classes, 310,549 solves, **927 s wall at 28 threads** (last continuation); the sub-batch curve 65 → 3,186 / 74 → 37,316 / 75 → 49,780 / 85 → 2.59 M classes (≈ 1.3–1.5× per cheat in this regime) |
| profile (Rust replay, tiers) | 37,316 classes: 26,857 in 1.5 h at 12 workers, the tail complete-solver territory; the pdeg12 restricted pool 3.13× on hard classes |
| design (cover + shrink) | 119-point halo vs 20,758 classes: cover 986 s, shrink 61,287 s, verify 233 s |
| floor census (essential alone) | 273 asks, 2,657 s at 12 workers (plain); 39 asks at 600-s cap with 3 unknown (copy) |
| endpoint census / core / centre sweeps | 184 asks 5.2 h on 3 solvers; 3,412 asks 2.3 h (k = 4 core); 380 asks 1,349 s; 3,296 asks 3.6 h |
| depth-1 pool build | 1.47 M points in 1.5 h at 1,981 object points (vectorized) |

The server (128 cores, dual-socket, 1.5 TB, Arch) is not yet usable: WO-3's replan (courier +
`qualify`) is authorized and unstarted. Nothing in this plan REQUIRES it; phases 4–5 name where it
would change the wall clock.

## 6. Registered predictions (before any campaign instrument runs; scored at close)

* **P1 — the direction ladder.** Every unit edge of the iteration-4 object (seed and all four halos)
  has a direction, mod 60°, in the seed's three families {13.2213°, 46.7787°, 30°} shifted by an
  integer multiple of the Moser twist 33.5573° — i.e. the object's direction set lies in
  ⟨ζ₆, ρ_Moser⟩ up to the seed's frame. *Provenance: measured first on the it-4 halo's 1,061 edges
  (six classes: 30, 46.78, 13.22, 3.56, 56.44, 20.34 — all on the ladder) — an inductive reading
  that the full census on the other 12,735 edges and on the it-3-era halos must REPLICATE (G30).*
  On the copies the ladder gains ρ₁₅: cross-chord directions in ⟨ζ₆, ρ_Moser, ρ₁₅⟩. Confidence
  medium-high. Falsifier: one edge off the ladder (then name its parents' distance).
* **P2 — the cross-chord law.** Every cross chord of a union whose two endpoints both lie in the seed
  field ℚ(√3, √11) is anchor-collinear with the centre (the kernel's `Quadrature.quadrature_rho15`
  applied); chords with a new-root endpoint are unconstrained by it. Confidence high for the
  theorem's reach; the measurement tests the field classification (a violation is an instrument
  error in `field_census`, G21).
* **P3 — self-chords.** A copy point R(p) is at unit distance from p exactly when |p − c| = 2
  (kernel, §8); the 18 "angle-independent" chords about 206 are exactly 206's unit neighbours
  (c–R(p) is unit for every unit neighbour p of c). Confidence high (arithmetic).
* **P4 — Act One.** U (the it-4 unit part, 1,953 live points) at k = 4 has NO colouring avoiding
  monochromatic distance-2 pairs (G16: depth-2 seam material carries the d2 pigeonhole) and its
  1-minimal carrier lies within radius ~2.5 of a lock centre; the √3-pair class does NOT fire (M33:
  that one needed the 1581's assembly). Confidence medium. Falsifier: a validated 4-colouring of U
  with no mono d2 pair — the MORE interesting outcome (F1).
* **P5 — kill-mass ranking.** Over one fixed class list L on the plain it-4 object: each ρ₁₅ copy
  about 206 or v₀ kills ≥ 50 % of L; the mirror and the d = 5 rotation kill < 25 %; the four-copy
  union kills ≥ 90 %. Confidence LOW for the levels (the old-object floor census said one copy makes
  no floor cheat redundant alone, so some classes survive every copy); the RANKING is the
  prediction.
* **P6 — the dial.** The plain it-4 object's exact cull lands ≤ 184 kept (the it-3-era greedy
  reading, on a worse object); the strongest composed object's cull lands ≤ 150. Confidence low
  for the numbers. Falsifier of the second half: composed kept ≥ plain kept — then copies carry no
  cheat-forcing at five colours and F3 fires.
* **P7 — the batch-size law.** For the same batch B, |S(B)| on the composed object is < |S(B)| on
  the plain object by a factor that grows with |B| (copies kill classes), so affordable batches on
  the composed object are ≥ 1.5× larger. Confidence medium.
* **P8 — the cheap shrink.** The composed object's forcing with its culled kept set survives
  restricting the copy to the k = 4 core's copy side plus its radius-2 shell about the centre
  (≤ ~600 copy points), giving a base of ≤ 2,600 points. Confidence low (T11's width regime may
  need copy material far from the centre).
* **P9 — the non-locking centres.** The ten non-locking seed vertices (79, 127, 129, 130, 174, 190,
  199, 203, 205, 208) have fewer than 60 % of the locking centres' median count of depth-≥ 2 halo
  points within radius 2.5. Confidence medium.

## 7. Phases (each closes with its numbers in §R before the next starts; one heavy job at a time)

**Phase 0 — housekeeping and instruments (attended, hours).** D8's renames and banners; commit the
viewer's pending it-4 refresh; `data/m52/` created with a README. Instruments, each with a planted
self-test seen red: (a) `tools/copy_anatomy.py` — direction census with twist-ladder labelling,
ring spectra about named centres, cross-chord classification (field membership via
`field_census`'s catalogue; collinearity with the centre; radius pairs), symmetry search (does any
plane isometry map the union to itself?); (b) `descentviz_refresh.py --transform` — copy layers in
the viewer, republished to the same artifact URL; (c) `tools/copy_pool.py` — a transformed copy
exported in the engine's pool layout (SPEC §"Pool export", points + adjacency to the object +
internal adjacency; the `object.fingerprint` bind), with the it-4 halo itself exported the same way
as the calibration pool; (d) `tools/cull_enum.py` — the enumeration cull driver: batch selection
(cheats-descending by class count from the floor census, sized by a first small batch's measured
class count), the enumerator invocation on the composed object's edges sidecar (`export_edges.py`
extended to include copy material as non-seed points), the hitting set over deduplicated
violated-sets (greedy + ILP verify), the per-batch certify ask, checkpoints per batch. Acceptance of
(d): on a planted object with a known optimal kept set, the driver returns it.

**Phase 0k — the kernel sitting (an afternoon, CPU-light, runs beside any phase).** `Copy.lean` per
§8; build through `scripts/build.sh`; `#print axioms` rows added to `scripts/Axioms.lean`.

**Phase 1 — the atlas (compute ≤ 1 h).** For each object in §2's it-4 family: P1's direction census;
ring spectra about 206, v₀, 205, the four load-bearing halo points, and the seed's crystal centres
(Q6); the shell vocabulary check (Q7's ℚ(√33) ladders on the it-4 halo); P2/P3 on every cross chord;
the field census; degree profiles; the symmetry search. The de Grey comparison: `tools/anatomy.py`'s
direction and ring machinery pointed at our object — is its direction set a half-spindle-group
object (G8), and how many classes? Output: one table per object in `data/m52/atlas.json` and the
viewer republished with the copy layers.

**Phase 2 — the mechanism (compute: hours).** (i) P4: `rigidity.class_avoid` at k = 4 on U for the
distance-2 class and the √3 class (the M33 instrument, two encodings on a fire); on a fire,
`mechanism.py --shrink` for the 1-minimal carrier and its radius about the nearest lock centre.
(ii) The 883-core's colouring anatomy: harvest proper 4-colourings of the core's original side
(434 points) and of its copy side (449) with the M48 mask engine; read which cross chord kills which
(side, copy) colouring pair; report the kill structure as a table, not a story. (iii) P9 on the
non-locking centres. (iv) The composed unions' cross-chord geometry: are the it-4 four-copy union's
205 chords the union of the four copies' own chords plus copy–copy chords, and where do copy–copy
chords sit (P3's radius law between two rotations)?

**Phase 3 — the composition ranking (compute: the heavy job for a day).** Enumerate ONE batch list L
on the plain it-4 object (the first ~12 cheats of the cull order; expected 10⁴–10⁵ classes, minutes).
Export each candidate as a pool: R±₂₀₆, R±ᵥ₀, the mirror across 205–206, the d = 5 rotation about
206, R±c for the two best-connected halo lock centres, and the it-4 halo itself (calibration).
`descent replay` per pool over L (the first pass wall-capped, unknowns never folded). Rank by killed
fraction; P5 scored. The composition = the plain object plus the copies whose union of kills covers
L best per point added (greedy over the profile's per-class kill masks — a set-cover read, free).

**Phase 4 — the cull (compute: the heavy job for one to three days).** (a) The plain it-4 object,
by enumeration (the control dial and P6's first half); cull3 on the same first batch (the method
control: its kept subset is forcing but not smaller than the exact one). (b) The chosen composition,
by enumeration, P7 scored on the first two batches. (c) The floors of the composed candidates
(essential-alone census, 273 asks each) as the first dial. Each batch closes with its certify ask
(the kept set forcing, one-hot; the FINAL kept set in two encodings). Every batch checkpointed; the
class lists kept (they are iteration 5's phase-1 inputs).

**Phase 5 — the shrink (compute: days on the desktop; hours on the server).** D5's ladder (P8);
then vertex group-MUS with presence selectors over the copy side, cores confirmed by a second ask,
checkpoint per acceptance, unknown = kept. Output: the shrunk composed object with its recipe
(provenance for glue points, centre + sign for copies) and its certified forcing (two encodings).

**Phase 4½ — the server gate (attended, an hour).** The first batch's rates and the shrink ladder's
first asks feed §12's extrapolation; the report goes to Kooshi the same day; the desktop continues.

**Phase 6 — the close.** Object cards for every candidate (`plans/Q8-FIVE-CHROMATIC-OBJECTS.md`
extended); `data/m52/` refreshed (recipes, kept sets, atlas, the shrunk object); predictions scored;
`CLAUDE.md` § Frontier + ledger + § Grokkings (the direction ladder and the mechanism verdict, each
at its honest epistemic status); the decision report in the house format with the next-milestone
stub written — `plans/M53-…` is either iteration 5 from the chosen object (D38's provenance dialect
as its first work order) or the pivot the study earns; Kooshi picks.

## 8. The kernel skeleton (phase 0k; statements first, `sorry` at every leaf until the sitting)

```lean
namespace HadwigerNelson.Copy

/-- Rotation of the plane about `c` by the unit complex number `ρ`. -/
noncomputable def rotAbout (c ρ z : ℂ) : ℂ := c + ρ * (z - c)

/-- The spindle rotation for a pair distance `d`: `sin (θ/2) = 1/(2d)`, so
`cos θ = 1 − 1/(2d²)` and `sin θ = √(4d² − 1)/(2d²)`. Kooshi's derived-angle table as one term. -/
noncomputable def spindleRot (d : ℝ) : ℂ := ⟨1 - 1 / (2 * d ^ 2), Real.sqrt (4 * d ^ 2 - 1) / (2 * d ^ 2)⟩

theorem spindleRot_sqrt3 : spindleRot (Real.sqrt 3) = FieldWall.moserTwist := sorry   -- d = √3: (5/6, √11/6)
theorem spindleRot_two   : spindleRot 2 = Quadrature.rho15 := sorry                  -- d = 2: (7/8, √15/8)
theorem normSq_spindleRot (d : ℝ) (hd : 1 / 2 ≤ d) : Complex.normSq (spindleRot d) = 1 := sorry
theorem normSq_one_sub_spindleRot (d : ℝ) (hd : 1 / 2 ≤ d) :
    Complex.normSq (1 - spindleRot d) = 1 / d ^ 2 := sorry

/-- A rotation by a unit complex is an isometry. -/
theorem dist_rotAbout (c ρ z w : ℂ) (hρ : Complex.normSq ρ = 1) :
    dist (rotAbout c ρ z) (rotAbout c ρ w) = dist z w := sorry

/-- The self-chord law: a copy point sits at distance `‖1 − ρ‖ · |z − c|` from its original. -/
theorem dist_self_rotAbout (c ρ z : ℂ) : dist z (rotAbout c ρ z) = ‖1 - ρ‖ * dist z c := sorry

/-- For the d-spindle rotation the self-chord is unit exactly on the radius-`d` circle. -/
theorem self_chord_iff (d : ℝ) (hd : 1 / 2 ≤ d) (c z : ℂ) :
    dist z (rotAbout c (spindleRot d) z) = 1 ↔ dist z c = d := sorry

/-- The union of a unit-distance drawing and its rotated copy is a unit-distance drawing of the
union graph on `ι ⊕ ι` (each side's edges, plus every cross pair at unit distance). -/
-- statement shape fixed in the domain-modeling pass: the union graph as `SimpleGraph (ι ⊕ ι)`
-- with `Adj` = same-side adjacency ∨ unit distance across, and the drawing `Sum.elim q (rotAbout c ρ ∘ q)`.

end HadwigerNelson.Copy
```

Spec examples that would fail if the definitions drifted: `spindleRot 5` has real part `49/50`
(the E–I pair's own spindle, in ℚ(√11)); `self_chord_iff` at `d = 2` names radius 2 — the measured
self-chord shell about 206 (P3). The red control: `spindleRot d` for `d < 1/2` has a negative
radicand and `normSq_spindleRot` is FALSE there — the hypothesis is exact (the `hd` example, as in
`OneDefect`).

## 8½. Phase-1 finding that reprices D6 (2026-09-02, day one)

The 883-core's certificate was priced on a field inventory of 24 radicands and a per-edge
compositum. The exact atlas found the premise false: **the whole iteration-4 object lies in
ℚ(√3, √11)** (T14 — every point in the 4-basis, all 13,796 unit edges exact identities), and a ρ₁₅
copy adjoins exactly √5, so every copy union is in ℚ(√3, √5, √11), inside the kernel's existing
M02 representation (ℚ(√3, √5, √7, √11), height 4). D6's "weeks of new geometry engineering" is
therefore wrong: the geometry half of the certificate is the M06 pipeline with a smaller tower,
and the price is the LRAT at k = 4 over ~880 points (M06-scale, hours of kernel time). D6's
scope ruling (certificate OUT of M52) stands as a scope decision, but its cost basis is corrected
and the decision report will re-present it with the new price.

## 9. Failure clauses (pre-committed)

* **F1 — Act One is not the d2 pigeonhole** (P4's SAT): record it as the finding, run phase 2 (ii)
  to its end (the harvest + masks name the compelled structure at arity ≤ 4 or report "none at
  arity ≤ 4 within the harvest's coverage" with the coverage stated), and write the mechanism as
  measured-unnamed. No reading is promoted on the strength of a single object.
* **F2 — enumeration batches too small** (P7 fails hard: affordable batches < 10 cheats on the
  composed object): cull3 becomes the method, the server the instrument (or the desktop over days,
  reported as a partial reading with its unknown count in the headline).
* **F3 — no composition beats plain on the dial** (P6's second half): the strongest object is the
  plain it-4 object; the copies stand as 5-chromatic unit witnesses only; the recommendation is
  iteration 5 plain, with the certificate as the competing next milestone.
* **F4 — the shrink stalls above ~4,000 points**: iteration 5 on the composed object would need a
  restricted pool (T11's pdeg12 pattern); the decision report prices it and says so.
* **F5 — standing halt clauses, verbatim:** μ ≤ 1 at five colours ⟹ HALT AND VERIFY; a REFUSED
  certificate ⟹ INVESTIGATE, never retry; any hardware event ⟹ HALT and report; an unknown is
  never folded into a verdict; every headline carries its population and its conditioning (G21).

## 10. Discipline

Every phase longer than fifteen minutes checkpoints at its acceptance points and resumes from them
(the standing rule; the audit question "if this process dies now, what does the relaunch redo?" is
answered in each tool's docstring). One heavy job on the box. Registered predictions are scored at
close with their measurements, met or missed. Nothing is worked from memory: the object cards and
`data/m51/` are the record, `build/m51-jobs.txt` the ledger (append a row per event). Sixteen
threads on memory-tight or wall-capped phases. The viewer is republished to the same artifact URL
after every object change.

## 11. Open for Kooshi (ranked; defaults stated)

1. *Decide when convenient* — **the 883-core certificate**: D6 keeps it out of M52 as a priced
   next-milestone candidate. Default: out. The one fact that would move it: phase 2 finding the
   mechanism interesting enough to publish (his clause).
2. *Know but do not decide* — **the server**: phases 4–5 are priced for the desktop and would be
   hours instead of days on the server; WO-3's replan is the gate and is not on this milestone's
   critical path.
3. *Know but do not decide* — **the it-3-era plain cull** (D3): retired at 184 kept; finished only
   on the server as a method control.

## §Bʹ. The domain-modeling pass (2026-09-02, fresh invocation) — what it changed

Run on the four objects the arguments named: the kernel statements, the composed object, the cull's
formulation, and the "strongest" criterion. Each change below removes a representation rather than
adding one.

**1. The composed object is the SAME object with one more recipe constructor (D9, new).** The
descent object is intrinsically (points given by an exact recipe over the seed, the forced pair, the
live seed block, the standing cheats); unit edges are derived, never stored. A rotated copy is not a
second kind of object: its points are recipes `['rot', centre, sign, source]` (cos 7/8, sin ±√15/8
about an exact point — exact by construction, as a glue point is), and coincident recipes denote
one vertex (the copy of the centre IS the centre; the fuse step is the quotient by coincidence,
checked at 250 digits and never assumed — the it-4 four-copy union's "4 fused" are exactly the two
centres × two signs). So phase 0 builds the composed objects as first-class `Obj` files
(`tools/compose.py`: base label + a list of (centre, sign) → object JSON with fingerprints), and
EVERY downstream instrument — `export_edges`, the floor census, the enumerator, `field_census`, the
viewer refresh, the certify's geometry — runs on them unchanged. The ad-hoc in-memory unions of
`copy_probe`/`copy_cull3` are retired for M52's work; D38 (the provenance dialect) collapses to
this constructor on the Python side plus `mp_values` and the fingerprint — the Rust engine never
reads provenance, only the edges sidecar, where copy points are ordinary non-seed material.
Inventory sizes marked "~" in §2 become exact fingerprints at phase 0's close.

**2. The composition ranking needs no pool export (phase 3 simplified; `copy_pool.py` dropped from
M52).** For the same batch B and the same live block, the classes of the composed object are a
SUBSET of the plain object's — restricting a separating colouring of the composed object to the
plain points is a separating colouring with the same projection — and a class in
`S_plain(B) ∖ S_comp(B)` is killed by the copy in the design engine's exact sense (no extension
exists). So two enumerations give the per-copy kill mass (`1 − |S_comp|/|S_plain|`) AND the
per-class kill masks (the set-cover read across copies) exactly, with no tiers and no unknowns —
and the plain enumeration is phase 4's first batch, reused. P5 is scored on these counts; P7 is the
same measurement read as a batch-size law. The engine's pool export stays what it is — iteration
5's instrument for designing a halo out of the copy — and is that milestone's work order.

**3. The mechanism has a finite intrinsic form: two projected colouring sets and a disjointness
table (phase 2 (ii) reshaped).** A 4-colouring of the union is a PAIR (σ, τ) — σ a 4-colouring of
the original side `U[S₁]`, τ a 4-colouring of the copy's source `U[S₂]` (both subsets of U; a point
in `S₁ ∩ S₂` is coloured twice, independently) — coupled only by the fused centre (σ(c) = τ(c)) and
the cross chords (σ(p) ≠ τ(q) for each chord p–R(q)). The refutation says: with the centre's colour
fixed, the projections Σ = {σ|P} and T = {τ|Q} onto the chord endpoints (20 chords ⟹ |P|, |Q| ≤ 20)
contain no componentwise-distinct pair. So the lock is a statement about two sets of ≤ 20-tuples over
four colours, and the load-bearing chords are the coordinates without which a disjoint pair appears.
Phase 2 (ii) enumerates Σ and T (projections to ≤ 21 points; if the fabric is 4-tight they are small
— the M49 lookup engine's regime; if not, the mask engine's harvest with its coverage stated) and
writes the kill table; Act One is then READ from Σ — which patterns on the four load-bearing points
{225, 243, 423, 424} (the same four points on both sides, at 1/√3 and √3) every σ carries — with the
M48 arity instrument on the 883-core's original side at that tuple as the exact form of the question.
P4's distance-2 class-avoidance ask on U stays as the G16 test, now beside a sharper one.

**4. "Strongest" is a Pareto knee, not a lexicographic order (§3 corrected).** Composition is
monotone (`Forces.mono`): more copies never lose forcing, only cost. So criterion 1 alone always
picks the largest composition, and the real decision is the trade between kept cheats and points
after the shrink. The candidates are reported as a front (kept cheats × shrunk points, field cost
beside), and the decision report argues the knee. The known limitation stands: the grown lattice's
kill capacity (G33's compounding) is iteration 5's own measurement, unmeasurable here.

**5. The kernel statements, reshaped.** (a) No graph on `ι ⊕ ι` is defined: the copy union IS
`(unitDistance ℂ).comap (Sum.elim q (rotAbout c ρ ∘ q))` — every unit pair an edge, cross chords
included — already in the repository's vocabulary; the copy construction's content is two
containments (`G ≤ (that).comap Sum.inl` when `q` draws `G` with unit edges, and the same for
`Sum.inr` because `rotAbout` is an isometry) and the self-chord characterization
`Adj (inl z) (inr z) ↔ dist (q z) c = d` for the d-spindle rotation. (b) Unit-ness is EXTRINSIC:
`rotAbout c ρ` takes `ρ : ℂ` with `Complex.normSq ρ = 1` as a per-use hypothesis (the repository's
convention — `moserTwist`, `rho15` are plain complexes with `normSq_*` lemmas), not `ρ : Circle`;
the self-chord law `dist z (rotAbout c ρ z) = ‖1 − ρ‖ * dist z c` needs no hypothesis at all.
(c) `spindleRot d` is parameterized by the pair distance `d` (the intrinsic parameter; the radicand
`4d² − 1` is derived and named by the spec examples: `(spindleRot 2).im = √15/8`,
`(spindleRot 5).re = 49/50` — the Exoo–Ismailescu pair's own spindle). The red control is the
computable one: `Complex.normSq (spindleRot (1/4)) = 49`, so `normSq_spindleRot`'s hypothesis
`1/2 ≤ d` is exact. (d) Mathlib's `Circle`/`rotation` is the neighbour and is cited in the
docstring; the bespoke affine form costs one two-line isometry lemma and spares every consumer a
`Circle` coercion.

**6. Two tools become one.** The vertex shrink of phase 5 is `copy_cull3`'s group-MUS with the
group = a copy point's incident edges instead of a cheat's clauses; one tool, a `--groups` switch,
the same cores/witness pool/checkpoint discipline. Phase 5's question (fewest copy points carrying
the CULLED forcing) and the design engine's (fewest pool points killing one batch's classes) are
different questions and keep different tools; the plan names both.

*Seams validated:* the adversarial member for the cull's exactness is a class whose violated set is
empty — impossible by construction (every class is proper on the standing cheats outside B and
separating, so with K = B it must violate something in B, else the object with all of B present
would not force — the certify of the previous batch guards this, and `cull_enum` asserts it per
class). The unsampled member for D9 is a copy point coinciding with a NON-centre point — never seen,
checked anyway at 250 digits. The next lemma the kernel shape earns for free: the two-copy union
(both signs) is the same comap along `Sum.elim` twice, no new definition.

## §Bʺ. The obligation-modeling pass (2026-09-02, fresh invocation) — proofs walked, invariants stated

**The partition.** *Prove* (kernel): the six `Copy.lean` lemmas below. *Test* (elaboration-time
examples that fail on drift): `spindleRot 2 = rho15`, `spindleRot √3 = moserTwist`,
`(spindleRot 5).re = 49/50`, `(spindleRot 5).im ^ 2 = 99/2500`, and the red
`Complex.normSq (spindleRot (1/4)) = 49` (the radicand is negative there, `Real.sqrt` returns 0, and
the hypothesis `1/2 ≤ d` is shown exact by a computation, not a remark). *Assume* (named per use):
`1/2 ≤ d`; `Complex.normSq ρ = 1` for the isometry; `∀ u v, G.Adj u v → dist (q u) (q v) = 1` for the
containments.

**The kernel proofs, each a two-line transcription once the intermediate is named.**

| lemma | argument | shape |
|---|---|---|
| `normSq_one_sub (h : normSq ρ = 1) : normSq (1 − ρ) = 2 − 2 * ρ.re` | `(1−a)² + b² = 1 − 2a + (a² + b²)` | `normSq_apply`, `sub_re/sub_im`, `linear_combination h` — the general fact that earns every rotation's self-chord length |
| `normSq_spindleRot (hd) : normSq (spindleRot d) = 1` | `(1 − 1/(2d²))² + (4d²−1)/(4d⁴) = 1` | `Real.mul_self_sqrt (by nlinarith)`, `field_simp`, `ring`; `d ≠ 0` from `hd` |
| `normSq_one_sub_spindleRot (hd) : normSq (1 − spindleRot d) = 1/d²` | `2 − 2(1 − 1/(2d²))` | the two lemmas above composed, `field_simp` |
| `norm_of_normSq (h : normSq ρ = r²) (hr : 0 ≤ r) : ‖ρ‖ = r` | `normSq = ‖·‖²`, nonneg square roots | `Complex.normSq_eq_norm_sq` (name to be queried, not recalled), `pow_left_injective`/`nlinarith` |
| `dist_self_rotAbout : dist z (rotAbout c ρ z) = ‖1 − ρ‖ * dist z c` | `z − (c + ρ(z−c)) = (1−ρ)(z−c)` | `Complex.dist_eq`, `show … = ‖(1−ρ)*(z−c)‖ by ring_nf`, `norm_mul` — no hypothesis |
| `dist_rotAbout (hρ) : dist (rotAbout c ρ z) (rotAbout c ρ w) = dist z w` | the difference is `ρ(z−w)`, `‖ρ‖ = 1` | `norm_mul`, `norm_of_normSq hρ` at `r = 1` |
| `self_chord_iff (hd) : dist z (rotAbout c (spindleRot d) z) = 1 ↔ dist z c = d` | `(1/d)·x = 1 ↔ x = d` for `d > 0` | `dist_self_rotAbout`, `norm_of_normSq` at `r = 1/d`, `field_simp` |
| the containments: `G ≤ H.comap Sum.inl`, `G ≤ H.comap Sum.inr`, `H.Adj (inl z) (inr z) ↔ dist (q z) c = d` for `H := (unitDistance ℂ).comap (Sum.elim q (rotAbout c ρ ∘ q))` | unfold `comap`, apply `hq` / `dist_rotAbout` / `self_chord_iff` at the point `q z` | `intro u v h; simpa using …` — the exact `Adj` shape of `distanceGraph` (whether `x ≠ y` is a conjunct) is read at implementation, not assumed |

The instance identities go through `Complex.ext_iff` with `Real.sq_sqrt`, and the chromatic transfer
(`H.chromaticNumber ≤ (unitDistance ℂ).chromaticNumber`, `Sum.elim …` being a graph hom by
definition of `comap`) is existing vocabulary, cited not re-proved. **Mutation audit at the
sitting:** drop `hd` from `normSq_spindleRot` (must fail — the red example is its counterexample);
replace `1/2 ≤ d` by `0 < d` (must fail at `1/4`); drop `hρ` from `dist_rotAbout` (must fail:
`ρ = 2` doubles distances — pin as `example : dist (rotAbout 0 2 1) (rotAbout 0 2 0) = 2`).

**The cull by enumeration: the invariant, and what it buys for free.** Write `Sep(C')` for the
separating colourings (proper on the unit graph and on the cheat set `C'`, with `f A ≠ f B`),
`S(B) = π(Sep(C ∖ B))` for the enumerator's projections to the live seed block, and
`V(s) = {e ∈ B : s e₁ = s e₂}`. **Claim:** for `K ⊆ B`, the object with standing set `C ∖ (B ∖ K)`
forces ⟺ every `s ∈ S(B)` has `V(s) ∩ K ≠ ∅`. *(⇐)* a colouring in `Sep(C ∖ (B∖K))` is in
`Sep(C ∖ B)`, so its projection `s` is in `S(B)`; it is proper on `K`, so `V(s) ∩ K = ∅`. *(⇒)* an
unhit `s` lifts to some `f ∈ Sep(C ∖ B)` proper on `K`, hence `f ∈ Sep(C ∖ (B∖K))`. Two lines each
way, and every step is about projections because cheats are seed pairs — the copies enter only by
shrinking `S(B)`.

Three consequences the driver is built around: (i) **soundness is guarded twice** — the driver
re-scans the whole list after the ILP (every `V(s)` hit by `K`, a numpy check, never trust in the
solver's optimum) AND the batch closes with one certify ask (UNSAT under the new standing set) that
does not depend on the enumerator at all; (ii) **optimality within the batch rests on the
enumerator's exactness alone** (WO-6/7/11's V1–V3), and an incomplete list could only make `K` too
SMALL, which the certify ask refuses — so the failure mode is loud; (iii) **every kept cheat is
individually necessary, with a witness**: an inclusion-minimal `K` leaves, for each `e ∈ K`, a class
`s` with `V(s) ∩ K = {e}`, and since necessity given a standing set is monotone under removing more
cheats (fewer constraints, more separating colourings), that necessity holds forever — so the
final kept set is 1-minimal by construction, the floor's 27 (necessary by census, never batched)
included, and `cull_enum` records the witness class per kept cheat (re-validated in numpy against
the object as a proper separating colouring of the batch's stage). The loop's measure is the
standing count, strictly decreasing per batch or the batch is closed with everything kept.

**The shrink: the invariant is "the current object forces", re-established per acceptance.** A
deletion set `D` of copy points (never seed points, so no cheat moves) is accepted iff the ask on
the object minus `D` is UNSAT (verified, one-hot); a SAT model is a witness that `D` holds a
necessary point (kept, pooled as a signature); a solver core over presence selectors is a candidate
`D`, accepted only after a second ask under exactly the core; unknown at budget ⟹ kept. The
measure is the point count. The output is 1-minimal MODULO unknowns, and the headline carries the
unknown count beside the point count (G21); the final object's forcing is re-refuted on the
decorrelated one-shot path in two encodings before it is called a candidate.

**Where the informal claims stop and the kernel would have to start:** none of the instrument
invariants above is formalized — they are the same soundness architecture the descent has run on
since M50 (certify decides, replay never trusted), stated here so each instrument's correctness
reads in two lines. The 5-chromaticity of the copy unions stays tools-level (D6).

## §Bʹʹʹ. The experience-modeling pass (2026-09-02, fresh invocation) — the surfaces

Three consumers, each holding something different at the moment of use: **Kooshi**, who reads
pictures first and numbers second and wants insight he can push back on; **a fresh session** (this
one after a compaction), which holds only `plans/`, `data/`, and the ledger; and **the tools
downstream** (the enumerator, the certify, the viewer), which hold a fingerprint and an edge list.
Every surface below is designed for the one that consumes it, and nothing is written twice by hand.

**1. Names.** One short name per candidate, defined once in the object cards and used everywhere —
prose, viewer layers, ledger rows, the front table: `it4` (the plain iteration-4 object),
`it4+206p` / `it4+206m` (one ρ₁₅ copy about vertex 206, + or − sign), `it4+206pm` (both signs),
`it4+v0pm`, `it4+quad` (both signs about both centres), and `it4+<centre><sign>` for any other
centre. The filename grammar is the same string appended to the base label (`…-vdel28-it2v2-depth1
+rot2-206p+rot2-v0m`), shell-safe, carrying the intrinsic parameters (pair distance, centre, sign)
and never the derived angle. The it-3-era objects keep their existing names with the prefix `it3`.

**2. The composed object is an object, so it needs no new surface.** With D9 the viewer renders
`'rot'` points as a layer because they are in `prov` — no `--transform` flag (dropped from phase 0):
a composed object is refreshed and republished exactly like any other. What the viewer ADDS, because
Kooshi's two findings (Q6, T13) were made in it: (a) per-copy toggles, with copies coloured by copy
and copied-seed vs copied-halo distinguished; (b) cross chords as their own edge class, the
load-bearing ones bold; (c) the centre marked and the **radius-d circle** drawn about it (P3's
self-chord shell — the one line that makes the spindle geometry visible); (d) **edges coloured by
their twist-ladder index** k (the direction family times ρ_Moserᵏ), the rendering of T13/P1; (e) the
883-core as a highlight layer. Republished to the same artifact URL; the ledger row carries the URL.

**3. The atlas has a machine twin and a human twin from ONE tool.** `copy_anatomy.py` writes
`data/m52/atlas.json` (per object: fingerprint, sizes, the direction census as
`{angle mod 60, ladder index, family, count}` with an explicit `off_ladder` list, ring spectra per
named centre as `{r² exact-or-float, count}`, cross chords as `{p, q, field class, collinear?,
radii}`, the symmetry verdict, the field census) and, with `--md`, the **atlas card** — at most
eight lines per object, appended to `plans/Q8-FIVE-CHROMATIC-OBJECTS.md`: direction classes
(on-ladder / off-ladder counts), the top five rings about the centre, chords by class, the symmetry
verdict, the field. Numbers only; readings live in the report, marked [reading]. An off-ladder edge
is reported with its parents' distance named (P1's falsifier is a line, never a silent "other" bin).

**4. The cull driver talks in the descent's own vocabulary and refuses loudly.** One line per batch:
`[cull it4+206pm] batch 3/20: B = 12 | S = 48,213 classes (enum 214 s, EXACT) | 1,904 distinct
violated-sets | K = 5 (ILP 0.4 s; re-scan OK) | dropped 7 | certify UNSAT 412 s | standing 246 → 239`.
The headline at the end names its population and its conditioning in the sentence:
`[cull it4+206pm] DONE: standing 273 → 141 kept (27 floor + 114 batch-kept, every kept cheat
witnessed and re-validated), 132 dropped over 20 batches, certify final one-hot + 3-bit UNSAT,
0 unknown, 14.2 h desktop`. Three refusals, each naming the branch that fired and only that branch
(G30's third failure mode): a CAPPED enumeration (`list not exact for stage <fp> — batch refused,
shrink B; nothing dropped`), a certify SAT (`the kept set admits a separating colouring — the list
was incomplete for stage <fp>; nothing committed; INVESTIGATE, never retry`), a certify unknown at
cap (`batch held; re-ask on the 10×-then-one-shot ladder`). `cull_enum.py --status <label>` prints
the checkpoint's state and the exact next command. Outputs: `build/m52-cull-<label>.jsonl` (rows
per batch with B, K, dropped, the witness class per kept cheat, the certify verdict, fingerprints)
and `data/m52/kept-<label>.json` (the final kept set with witnesses, the numpy re-validation stamp).

**5. The shrink reports points and unknowns in one breath.** `[shrink it4+206pm] DONE: 3,934 →
2,588 points (1,346 copy points deleted, 0 seed/halo touched), 41 unknown at budget (KEPT),
1-minimal modulo those 41; final forcing re-refuted one-hot + 3-bit` — the unknown count is never in
a footnote.

**6. The decision report is a front, then a knee, then the four parts.** The close's report (house
format, plain English, zero prior context) opens with one table — rows the candidates by short name
with a one-clause gloss each; columns: kept cheats (1-minimal, witnessed), points after the shrink
(with unknowns), radicands, certify status, the hardness reading — then argues the knee in three
sentences, then gives the recommendation with its confidence and the one fact that would change
it, then the decisions in four parts (the next milestone: iteration 5 from the chosen object, or the
pivot, each with its default), then the scored predictions (met / missed with the number), then
the failure clauses that fired. Every claim in it points at a `data/m52/` file or a ledger row.

**7. The ledger stays one file.** M52's events append to `build/m51-jobs.txt` (the name is
historical; one append-only ledger, never two), each row starting with the object's short name.

*Validated as the user:* the cold read of an atlas card by someone who has never seen the
repository must answer "what is this object, how big, what does its geometry say, is it symmetric,
what field" without opening a JSON; the cold read of the cull headline must answer "which object,
how many cheats stood, how many stand, were any asks undecided" without the log. Both are the
test at phase 0's close, run on the planted self-test objects before any real run.

## 12. The server gate (Kooshi, 2026-09-02: "if it's truly a matter of days to hours, then it's worth running on the server")

**The rule.** Phases 4 and 5 start on the desktop regardless. As soon as their rates are measured,
the extrapolation below is computed and REPORTED; Kooshi decides whether the remainder moves to the
server (two sockets, 64 cores / 128 threads each, two NUMA nodes, 1.5 TB, Arch).
The desktop does not wait for the decision.

**What is measured (desktop), per phase, in CPU seconds and wall seconds with the worker count named:**

| phase | the rate | the work | where the number comes from |
|---|---|---|---|
| enumeration (phase 3/4) | classes per second per worker, and per-batch wall at 8 / 16 / 28 threads | classes per batch × batches | the Rust enumerator's own journal (`--threads` sweep on the first batch) |
| hitting set + certify (phase 4) | certify ask CPU seconds (one-hot; 3-bit for the final) | one ask per batch + two at the end | `cull_enum`'s per-batch row |
| the control cull (cull3, phase 4) | probe CPU seconds, decided vs unknown, at 4 / 8 / 16 workers | probes per pass | its checkpoint rows |
| the shrink (phase 5) | ask CPU seconds per accepted / refused / unknown deletion; deletions per hour at 8 / 16 workers | remaining copy points ÷ mean core jump | the shrink's checkpoint rows |
| memory | resident set per worker, per phase | workers × RSS ≤ node memory | `ps` sampled by the launcher |

**The extrapolation model (stated before the numbers exist, so the numbers cannot shape it).**
Solver work on this desktop is memory-bound: 16 copies run at 0.78× a solo copy each, and the
SMT half adds only +8 % in aggregate at 32 threads (T12). So the unit is the PHYSICAL core, and the
desktop's own derating curve — solo → 8 → 16 copies, re-measured on the actual phase — is the
conservative transfer function. Per node: `wall_server = wall_desktop × (desktop physical cores /
64) × (desktop derating at 16 / server derating at 64)`. Two estimates are reported, never one:
**conservative** — the server derates at 64 copies exactly as the desktop does at 16 (a 4× per-node
gain from cores alone, 8× over two nodes); **optimistic** — no derating at 64 (the server's memory system against the desktop's — the memory wall moves), read from
the desktop curve's shape. Two NUMA nodes are two independent pools with replicated inputs
(`numactl --cpunodebind=N --membind=N`, first-touch after pinning), so the two-node figure is twice
the one-node figure minus nothing, and cross-node sharing is never assumed. SMT threads are not
counted as workers for solver phases; they are counted for the enumerator only if its desktop
16 → 28 sweep shows a gain.

**The report to Kooshi (one table, sent the day the first batch's rates exist, updated when phase
5's exist):** rows = the remaining work per phase; columns = desktop hours at the measured rate,
server hours conservative, server hours optimistic, the ferry cost in minutes (bundle size ÷ link,
plus the verification at home), and the saving. Beside it: the per-worker memory and the worker
count that fits each node. Nothing in the report is a prediction of the server's behaviour beyond
the two bracketing estimates, and the first server run is a **calibration run** (one batch, timed)
before any multi-day job.

**The ferry discipline (Kooshi: "both the tool and its data output must be robust and independent
to be ferried back and forth").** A phase that may travel ships as a **bundle**, built by
`tools/ferry.py` and checked on both ends:

* *the tool*: the Rust binary as built (Arch runs it as-is; the mimalloc-v2 pin per INC-3), or the
  `tools/` directory with a pinned `requirements.txt` (python-sat/CaDiCaL 1.9.5, numpy, scipy,
  mpmath, sympy) and a `venv` recipe; a **self-test on arrival** (the planted controls of each
  tool, seen red and green) before any real input is touched;
* *the inputs*: the object JSON, the edges sidecar, the class lists, the checkpoint to resume from —
  every file named in a **manifest with sha256**, and every tool refusing on a fingerprint mismatch
  (the existing discipline: object ↔ sidecar ↔ list bound by fingerprints, stage keys hashed);
* *the outputs*: append-only checkpoints (`.jsonl`, one row per accepted step, resumable after a
  kill at any instant — the standing rule) plus a results bundle with the same manifest, so a
  bundle that arrives torn is refused by its own hashes, never read;
* *independence*: no phase reads anything from `build/` that the manifest does not name, and no
  output is trusted until the desktop's own **certify** re-refutes it (the truth-maker never
  travels: a kept set or a shrunk object coming home is re-certified here in two encodings before
  it is called a candidate).

`tools/ferry.py` is a phase-0 deliverable with its own planted red (a corrupted byte in a bundled
file refuses on arrival). WO-3's replan on the engine side (courier + `qualify`) is the same
discipline for the Rust binary and is not on M52's critical path; the Python bundle follows its
manifest format so the two never diverge.

## 13. Efficiency first (Kooshi, 2026-09-02: "far more useful to have more efficient algorithms implemented in Rust rather than just throwing more compute at it … please prioritize that")

**The priority, as a rule for this milestone:** before any phase is moved to the server, its
algorithm is made efficient in the Rust engine; the server gate (§12) reports savings for the
EFFICIENT implementation, and "as is" only as the baseline row. D1 and D5 are amended accordingly;
the phase-0 Python instruments stay as reference implementations and controls, never as the
campaign's workhorse on a large object.

**The cull and the shrink are one problem, and the efficient algorithm for it is known.** Both ask:
given a satisfiability-refuting set of *groups* (a cheat = five clauses; a copy point = its incident
unit edges) guarded by selector literals on one CNF, find a minimal — and, where the minimal set is
small enough for it to matter, a MINIMUM — subset of groups that still refutes. That is group-MUS
extraction, and the efficient algorithms are established (Belov & Marques-Silva; Ignatiev, Previti,
Liffiton & Marques-Silva):

| lever | what it replaces | expected gain, and what it rests on |
|---|---|---|
| **a long-lived solver per worker, groups as assumptions** | fresh one-shot solves per probe | learned clauses persist across probes: 2.3× on a 207-class sample, up to 250× per hard ask (T12, measured on this object); the engine's WO-13 stub is this regime, and the culler is its first consumer |
| **cores as multi-drop jumps** | one probe per group | one UNSAT under assumptions returns the groups it used; everything outside the core is dropped in one step, confirmed by a second ask under exactly the core (cull3 has this; the Rust version keeps it) |
| **recursive model rotation** | one SAT probe per necessary group | a SAT witness for "group `g` is needed" is rotated into witnesses for other groups with NO solver call — for a vertex `v`: any neighbour holding a colour no other neighbour of `v` holds is a witness by recolouring; for a cheat: recolour one endpoint to tie exactly one other cheat while staying proper. The MUS literature's standing ~10× reduction in SAT calls on structured instances; on our objects the necessary side is the expensive side (witnesses 226 s median vs refutations 0.8 s, WO-2), so this is the lever that matters most |
| **implicit hitting-set dualization for the MINIMUM** | enumerating every class of a batch (exponential in the batch) | classes are generated lazily as SAT counterexamples to a candidate hitting set, each new class one row; the minimum forcing subset over ALL standing cheats without enumerating `S(B)` — the algorithm `tools/hitset.py` implements in Python and measured non-convergent at 446 columns on the seed; at 246 candidates with 27 fixed, seeded with cores and rotation witnesses, it is the registered candidate for the global minimum, with convergence a MEASUREMENT (P10 below) |
| **parallel probes, sequential acceptance, checkpoint per acceptance** | serial ddmin | the WO-5b/5d shrink discipline, already in Rust |
| **cube-and-conquer for the certify's refutations** | the 8,228-s monolithic 3-bit ask | the enumerator's entropy-split cubes on the certify instance (G18: cubes beat monolithic CDCL on composed objects); the certify itself stays Python and reviewed (the truth-maker never travels), the cubes are a parallel front-end whose verdict it re-checks |

**The work order: WO-14, the culler** (`descent-engine/plans/WO-14-culler.md`, stub written today).
One verb, `descent cull --groups cheats|vertices`, on the edges sidecar with the standing cheats and
the forced pair; deletion-based group-MUS with cores and recursive model rotation on WO-13's
long-lived solver; the IHS minimum as a second pass when the minimal set is ≤ ~200 groups; outputs
in the ferry format (§12): checkpoint per acceptance, a witness per kept group re-validated by the
Python numpy check, the unknown count in the headline. Acceptance: agreement with `copy_cull3.py`
on a planted object and on one real small instance (the 39-floor iteration-3-era stage), the kept
set re-certified by the Python certify, and the rotation's saving reported as SAT calls avoided
against the same run with rotation off. Planned NOW in a worktree by its own session
(`wo-chain-pipelining`), while phases 0–2 run on the desktop; its planning brief carries
`REVIEW-METHOD.md` and this section.

**Amended decisions.** *D1′:* the cull's workhorse is WO-14 (`--groups cheats`), with the IHS pass
for the minimum; the enumeration cull (`cull_enum.py`) runs ONCE, on the first batch of the plain
object, as the exact-within-batch control that the Rust culler's kept subset of that batch must not
beat by more than the batch's slack; cull3 is the reference on the planted object. *D5′:* the shrink's
workhorse is WO-14 (`--groups vertices`), after the cheap ladder (P8), which is one certify ask per
rung and needs no engine.

**P10 (registered).** On the plain iteration-4 object at 246 candidates: rotation removes ≥ 60 % of
the SAT probes the deletion pass would otherwise issue (confidence medium; the MUS literature's
range is 70–95 % on structured industrial instances); the IHS pass converges to a proven minimum
within 500 iterations (confidence low — the seed's 446-column run did not converge; if it does not,
the minimal set with its per-group witnesses is the deliverable and the minimum is reported as
open with the gap between the best hitting set and the best forcing set).

**Ordering, restated.** Phase 0 (instruments, kernel) and phases 1–2 (atlas, mechanism: light
compute) proceed on the desktop now; WO-14's planning session starts in parallel; phases 4–5 wait
for WO-14 unless it slips past the study, in which case the Python tools run the plain object's cull
as a baseline only and the composed objects wait for the engine. The server gate fires on WO-14's
measured rates.

## §R0–R2. Day one (2026-09-02): phases 0, 1 and most of 2, landed and measured

**Phase 0 — instruments and kernel (all with planted reds seen).** `batchkill.Obj` gained the
`'rot'` recipe (`add_rot`; `mp_values`/`check`/`load_object` dispatch) and an exact-rejected
`non_unit` set (persisted, re-verified on load); `tools/compose.py` (self-test: the seed's copy
SAT, a deleted centre and a planted coincidence refused; every copy-touching edge verified at 50
digits); `tools/copy_anatomy.py` (exact census, half-twist ladder, rings + PSLQ, chord classes,
symmetry search, the eight-line card; self-test on the seed's copy); `tools/copy_field_probe.py`,
`tools/copy_exact_field.py` (exact coordinates + exact edge identities), `tools/copy_kill_table.py`,
`tools/m52_p4.py`, `tools/cull_enum.py` (self-test with a planted minimum hitting set and a
refused empty violated-set). The viewer carries copy layers, cross chords with load-bearing bold,
the radius-2 circle, ladder colouring and a core highlight, republished to the same artifact URL.
**Kernel:** `Copy.lean` — every leaf proved on the first elaboration pass (two cosmetic fixes),
`scripts/build.sh` green (406 batches), `scripts/axioms.sh` **553 clean, 5 declared purchases**,
the M52 rows added. **WO-14** (the Rust culler) is being planned in its own worktree by its own
session. **Engine defect filed:** D68 — `descent enumerate` prints CONTRADICTION for an undecided
verification.

**The seven compositions of the iteration-4 object**, as object files with exact censuses:

| short name | points | unit edges (exact) | cross chords | k = 4 |
|---|---|---|---|---|
| `it4+206p`, `it4+206m` | 3,933 | 27,610 | 36 (10 self + 18 centre–neighbour + 8 genuine) | UNSAT 4.2 s |
| `it4+0p`, `it4+0m` | 3,933 | 27,627 | 64 (15 + 29 + 20) | UNSAT 2.7 s |
| `it4+206pm` | 5,885 | 41,424 | 72 (20 + 36 + 16); the float census's one "copy–copy chord" was a near-miss, exact-rejected | UNSAT 5.0 s |
| `it4+0pm` | 5,885 | 41,458 | 128 | UNSAT 4.5 s |
| `it4+quad` | 9,789 | 69,086 | 200 (50 + 94 + 56); 0 copy–copy | UNSAT 4.8 s |

**Phase 1 — the atlas (T13 → P1, T14).** P1 **replicated on the whole object, exactly**: all
13,796 unit edges of the plain object lie on the half-twist ladder θ ≡ 30a + m·16.7787° (m ∈
{−2, …, 3}); every copy's edges lie on it one ρ₁₅ step over; the only off-ladder edges anywhere
are the genuine and self cross chords. **T14: every live point of the object has coordinates in
ℚ(√3, √11)**, found by PSLQ and then verified as 13,796 exact Fraction identities; the copies are
derived exactly in ℚ(√3, √5, √11) and every edge of `it4+206p` (27,610) and `it4+quad` (69,086)
verifies exactly. The earlier field census's "new roots" were squares in the field (a G21 on a
classification); the 883-core's certificate geometry reprices to M06-class (§8½). P2 **met** on
every genuine chord of every composition (all collinear with the centre, all endpoints in the seed
field). P3 **met** (self-chords = the radius-2 shell: 10 about 206, 15 about the origin). Symmetry
search: none. The seed-field sub-object is the whole object (the probe's question collapsed).

**Phase 2 — the mechanism (T15).** P4 **met**: the distance-2 class-avoidance ask on U at four
colours is UNSAT in both encodings (5,470 exact pairs, under a second); the √3 class is avoidable
(10,288 pairs). The kill table on the 883-core: |Σ| = 3,516, |T| = 1,062, all 3,733,992 pairs
killed, every one of the 13 genuine chords the sole killer of some pairs (423–R(225): 46,236);
no pair compulsion inside Σ or T; the chord endpoints carry the centre's colour far above chance
(up to 65 %). P9 **missed as registered** (the 60 % threshold: 5 of 10 at R = 2.5, 3 of 10 at
R = 3.0) and met in direction on every column; the sharper separator is the radius-2 shell
(median 5 against 9). Copies never touch each other in any composition (0 copy–copy chords exactly).

**Phase 3 — in flight.** The first enumeration (8 non-floor cheats) hit the 4 M-conflict budget on
its root solve with 0 classes — the batch is probably jointly redundant, so its first solve is a
whole-object refutation — re-running at 40 M; the ranking batch (4 floor + 4 non-floor cheats)
enumerating on the plain object at 8 threads.

## §R3. Phase 3 — the composition ranking: P5 refuted, F3 fired (2026-09-02, evening)

**The measurement.** The ranking batch (four floor cheats 4-90, 4-159, 4-205, 4-208 and four
non-floor 0-55, 0-93, 0-111, 0-132) enumerated on the plain iteration-4 object: **15,218 classes,
exact** (169 s at 8 threads). The same batch on `it4+206p`: **15,218 classes** — projection for
projection the same set (compared on the live seed block up to colour permutation, since the
enumerator's palette pin follows the object's degree order and a copy changes it). **Kill fraction
0.0000.** Decorrelated check: twenty random plain classes forced onto the composed object's original
side all extend to the copy (20 SAT, 0 UNSAT, 0 unknown, one-hot, 300-s cap never reached), and in
ten of ten the copy side is coloured with **four colours only**.

**The reading, with its mechanism.** The copy is a 4-colourable graph (it is U) attached to the
original through 36 chords, each forbidding one colour at one copy vertex. A separating
5-colouring of the original leaves the copy free to take any 4-colouring of its own and any
injection of its four colours into the five, and one of those always avoids the 36 conflicts —
the spare-colour lemma (`SpareColour.lean`) read as a statement about halos: **a (k−1)-colourable
halo attached by chords contributes nothing at k colours unless the chords pin it past its own
spare colour.** The union is 5-chromatic as a unit graph precisely because at FOUR colours there
is no spare colour to colour around with (T15); at five there is. Copies never touch each other
(0 copy–copy chords, exactly), so every composition is copies attached independently to the
original, and the zero transfers to `it4+0p`, `it4+206pm`, `it4+0pm` and `it4+quad` by the same
argument; `it4+0p` runs as the replication at a second centre, the rest are cancelled.

**What it decides.** F3 as registered: the strongest object by the dial is the **plain iteration-4
object**; the copies stand as 5-chromatic unit-distance witnesses (certificate targets, geometry
M06-class after T14) and as MATERIAL for the next iteration's partner lattice (their glue points
with the original are new points in ℚ(√3, √5, √11) — whether THOSE kill classes is iteration 5's
pool question, registered for the it-5 stub, not run here). Phase 5 (the shrink) has no copy
material to shrink and is closed as moot; phase 4 reduces to the plain object's exact cull, which
is running (`cull_enum --loop`, batches of eight; the first two batches were jointly redundant
refutations of ~250 s each: 16 of 246 candidates dropped, the 27 floor cheats never batched).

**Predictions scored so far.** P1 met (exactly, whole object); P2 met; P3 met; P4 met; P5 **refuted**
(kill fraction 0 against ≥ 50 % registered — and the registered low confidence named the floor
census as the reason); P7 moot (no classes killed, so the batch-size law on composed objects equals
the plain one's); P8 moot; P9 missed as registered, met in direction; P6 pending the cull's end;
P10 is WO-14's.

## §13′. Corrections to §13 from the WO-14 planning session (2026-09-02, the planner's findings, credited)

The WO-14 planner (descent-engine, worktree `wo14-plan`, frozen at `e26e6f3`) measured the six
levers and corrected the table in three places that matter; each is the planner's finding:

1. **The lever that is worth an order of magnitude was not in the table: WHICH CNF the probe
   solves.** The reference cull's probes hand the solver the standing cheats as guarded selector
   literals with the palette order taken over the unit edges alone; asked with the cheats as HARD
   clauses and the order over unit ∪ standing, the same question decides — 294.5 s against 4,689 s
   undecided on the iteration-3-era object, **121.2 s against 1,302 s** on the iteration-4 object,
   and twelve of the reference cull's 113 stalled probes decide (0 undecided, 7 droppable) in
   0.9 CPU-hours. My own exact-cull driver corroborates it from the other side: its certify uses
   hard clauses and refuted the plain object at standing 269 in 113.7 s. **Lever 0: the encoding.**
2. **The long-lived assumption solver (§13's first row) is negative on the culler's instance**
   (1.6× slower per conflict on a fat clause database); the 2.3×/250× figures were the enumerator's
   regime, where warm asks decide in milliseconds. WO-13 is neither absorbed nor a dependency.
3. **The witness-pool lever does not exist**: a probe of `kept ∖ {g}` returns a model whose violated
   set meets any later kept set in exactly `{g}`, so the pool can never answer a probe for another
   group. Model rotation, measured against complete ground truth: **0 % for cheat groups**
   (P10's registered bed — refuted there), **3.5 witnesses per solver call for vertex groups** on the
   883-point core (a low-coverage rate; a mixing model prices the full run at ~2×, not 3.5×).
   P10 is scored per mode from now on.
4. Solver cores are demoted from the default path to a measured arm (the one core taken on the
   iteration-4 object was the whole assumption set); the IHS minimum is WO-15 with its threshold
   at ~60 groups, not ~200 (at 200 columns it is a totalizer, not an afternoon); `--census` ships
   and replaces `run_recurse`'s 2,657-s floor census.

The three items the planner handed back are done or in flight: the 883-core edges sidecar for A2
(`data/m52/core883-edges.json`), the honest pre-mark re-export of the retired cull
(`data/m52/premarks-it3-vdel28-cull3.json` — its 'ask' rows carry no cheat identity, so its 35
necessities are not attributable and are re-paid), and `cull_enum.py` running as the D1′ control.
The SPEC amendment (v0.11: operation G, the cull journal with `holds`, the §7 sentence) is the
product owner's and is applied on the merge.

*§13′ addendum, from the planner's close (frozen `3e26fb4`, merged to engine main): the palette
ORDER's 2.1–2.9× was one object at one state — on the iteration-4 object the two orders are within
7 % — so the encoding (hard clauses, no selector guards) is the lever alone; D5 ships because it
costs one sort per probe, and its range is no longer quoted as general (a G21 on a positive, the
planner's own catch after my corroboration). A4 stays reference-free with `cull_enum`'s kept set
reported beside it as a second upper bound, never gated on: two 1-minimal sets of one object can
differ and both be right.*

## §12′. The server gate's first real data point (2026-09-02, from WO-14's A4)

WO-14's deletion pass on the iteration-4 object (273 cheats, one desktop, twelve workers — one
object at one width, the implementer's own qualifier) accepted one drop every ~1.9 minutes
regardless of the
worker count: **a refutation computed against a stale snapshot licenses nothing, so accepted drops
are strictly sequential, and in a drop-heavy phase width buys no wall clock at all** while costing
`W` times the processor seconds. §9's projection divided the probe count by the workers, and the
drop half does not divide. This is the efficiency-before-compute rule (§13) meeting a live
measurement: the 128-core server would have bought this phase NOTHING. The repair is
algorithmic and cheap — same-snapshot refutations unioned into one fresh chunk ask, one acceptance
carrying many drops (exactly what `cull_enum --loop` does with its batches: one refutation, eight to
sixteen drops) — and was ruled built the same hour. **The gate's cost model, corrected:** a phase's
server saving is the saving on its PARALLEL part only; every sequential acceptance chain must be
turned into a chunk chain before a core count means anything. The chunk-size law (acceptances per
wall-hour against chunk size, measured on A4's own journal) is the number the gate now wants.

## §R4. WO-14 delivered (2026-09-02, evening) — the culler exists, and it changes what the loop costs

The Rust culler landed on engine main (merge of `wo14-impl` at `85fdfdd`, 24 commits): `descent
cull --groups cheats|vertices`, `--census`, chunked acceptance; **gate 269 of 269, verified
independently by me on the final commit** (six seconds). Acceptance as measured: A1 met (25 red
patches each seen red); **A2 met** — on the 883-point core in vertex mode, 883 kept / 0 dropped / 0
undecided in both arms, rotation worth 2.04× in asks (432 against 883; the subplan's mixing model
predicted 440); **A3 met** — the census agrees with the floor census on all 273 verdicts, zero
undecided, at 8.64 CPU-hours against `run_recurse`'s 8.68 (the census was never the slow half —
the 10.7× belongs to the cull's guarded encoding alone); **A5 met** — hard beats guarded at 1.65×
the processor time to decide one MORE group, agreeing wherever both decide; A7 met (kill -9 and
resume: the same kept set group for group, no duplicate rows); A8 met (the ferry: a changed byte
refused by its own hash); **A4 partial** — 49 of 273 dropped, 11 witnessed, stopped on my ruling
to return the box to the enumeration cull, resumable from its journal; A6 not run, reported as not
run.

**The finding that matters for every later iteration**: at twelve workers the deletion pass
accepted one drop per ~2 minutes REGARDLESS of width — a refutation against a stale snapshot
licenses nothing, so accepted drops are sequential (§12′). The chunk repair (one fresh ask over the
union of same-snapshot refutations) halved the acceptance steps but did not yet win wall clock,
because licences arriving during a chunk ask are discarded on its acceptance: "ask at two spends
the pool at its emptiest" (D75 — twelve chunks, all size 2, one object, one width; the clean A/B in
WO-16 is what lets it be said without the qualifier). The tuning — hold licences while the batch drains, refine a
colourable chunk without accepting — and a drain-on-signal (D76: a stopped run keeps its journal
and loses its statistics) are the follow-up order, with the clean A/B (same journal, same groups,
input committed) as its first row. Meanwhile my `cull_enum --loop` IS a chunk engine of a different
shape — one enumerator refutation drops a whole batch — which is why it is the run finishing the
plain object's cull tonight.

## §R5. The close (in progress, 2026-09-03) — the scored predictions and the front

**Predictions, scored.** P1 **met** (exact, whole object: 13,796 of 13,796 edges on the half-twist
ladder). P2 **met** (every genuine cross chord collinear with its centre and seed-field, on four
compositions). P3 **met** (self-chords = the radius-2 shell: 10 about 206, 15 about the origin).
P4 **met** (the distance-2 class fires on U at four colours in both encodings; √3 does not).
P5 **refuted** (kill fraction 0.0000 against ≥ 50 % registered; the mechanism is the spare-colour
lemma as a halo statement). P6 — see the front. P7 **moot** (no classes killed, so the composed
law is the plain one). P8 **moot** (no copy material survives as descent material). P9 **missed as
registered** (5 of 10 under the 60 % threshold at R = 2.5, 3 of 10 at R = 3.0), met in direction
on every column; the sharper separator is the radius-2 shell (median 5 vs 9). P10 (WO-14's):
**refuted on its registered bed** (rotation 0 % on cheat groups) and **exceeded on a bed it did not
register** (3.5 witnesses per solver call on the 883-core's vertices; 2.04× in asks measured at
A2) — scored per mode from now on.

**The front (the plain object; the compositions are witnesses, not candidates).**

| candidate | kept cheats | points | field | certify |
|---|---|---|---|---|
| `it4` before M52 | 273 (27 floor) | 1,981 | ℚ(√3, √11) | committed (M51) |
| `it4` after the cull | **149** = 27 floor + 10 loop-kept + 60 witnessed + **52 undecided** at the 3M/30M conflict rungs (held, never folded); 124 dropped (114 by the enumeration loop in 13 batches, 10 by the Rust culler over 320 probes, 24.9 h at twelve workers); the culler's own bracket `[40, 149]`, its final control refutes, its breaking-off control undecided at 30M | 1,981 | ℚ(√3, √11) | **one-hot UNSAT 10,640 s; 3-bit UNKNOWN at the 43,200-s cap — CANDIDATE on one encoding** (the interim 167-set: one-hot UNSAT 944 s, 3-bit unknown at 14,400 s); the 52 undecided being re-asked at 300M conflicts |
| `it4+206p` … `it4+quad` | 273 (the copies kill nothing at five colours) | 3,933–9,789 | ℚ(√3, √5, √11) | k = 4 refusal only (the witnesses) |

The cull's number is the dial reading M52 exists to produce; the decision report follows it.

**The halo shrink, priced and not run.** A 24-point random sample of the 1,767 halo points asked in
vertex mode at the culled standing set (the Rust culler's `--census`, twelve workers): 16 necessary,
3 droppable, 5 undecided at the 3M/30M rungs, 2.7 h wall and 95,025 CPU-seconds — about 1.1
CPU-hours per probe. Extrapolated over the halo: ~200 hours of desktop wall clock (~1,950
CPU-hours; ~15 hours on the server at 128 workers) to remove a fraction bounded by the sample at
12–33 %, i.e. two to six hundred points of 1,981. The plain object goes to iteration 5 at 1,981
points; the shrink is a server job in WO-16's regime, its value bounded by this sample, and the
pool's cost for iteration 5 is priced on the unshrunk object.

## Post-milestone follow-ups (filed, not worked — Kooshi, 2026-09-03: "attention exclusively on the object until the cull and shrink are done")

* **~~The viewer does not show the rotation provenance.~~ RESOLVED 2026-09-04, not a bug (Kooshi): the artifact he read was the plain object, which has no copies; the copy layer renders on composed objects.** The composed object FILES record it
  (every copy point's `prov` record is `['rot', centre, source, sign]`, verified on every load by
  the fingerprint check and re-derived at 30 digits by `Obj.check`), and `descentviz_refresh.py`
  emits copy points as kind `copy` with `copy`/`src` fields — but the published artifact was last
  refreshed on the PLAIN object (the cull's layer), so no copy layer was in it, and the copy
  layers' info panel has not been checked in the artifact build (`descentviz_artifact.py` copies
  the JS verbatim; the template carries the controls). To do after the close: republish a
  composed object with the core and confirm the per-copy toggles and the "copy of … (source
  depth …)" line render in the artifact; if not, the defect is in the template/JS transfer.

**The shrink, re-aimed by F3.** The copies are not descent material, so phase 5's object is the
PLAIN culled object: `descent cull --groups vertices` over its 1,767 halo points (seed points are
never candidates) with `--standing` = the culled cheat set — the fewest halo points that carry the
culled forcing. It runs after the cheat cull ends and before the close.

**CLOSED 2026-09-04.** Predictions: P1–P4 met; P5 refuted; P6 met in its first half (≤ 184
registered, 149 measured), moot in its second; P7/P8 moot; P9 missed as registered, met in direction;
P10 refuted on cheat groups, exceeded on vertex groups. Failure clauses fired: F3. The decision
report is the close's message to Kooshi (M53 recommended; the certificate the competing candidate).
Loose ends carried, each with its home: the 3-bit certificate of the 149-set (R3; the cube front-end),
the 52 undecided cheats (re-asking at 300M conflicts on the desktop; the server), the halo shrink
(priced; WO-16's regime), the out-of-field kill census (M53's first row), the viewer's rotation
provenance (post-milestone), WO-16 (engine).
