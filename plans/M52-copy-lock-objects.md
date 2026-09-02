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
