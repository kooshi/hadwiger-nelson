# M34 — Act One as a kernel theorem, and the union question (PRE-SUBPLAN STUB)

*Written 2026-08-10 at M33's close, minutes after the P12 gate fired OPEN.
Read order for a fresh session: `plans/M33-mechanism-hunt.md` WHOLE (§0a
carries the criticality factorization and the phase-3 architecture A5; §R
carries every measured verdict), then CLAUDE.md § Grokkings G15–G17.*

## What M33 handed this milestone

* **The object**: `build/m33-core-hexchunkB2-eq-pair-2.json` — 122 vertices
  of the M26-certified hexagram chunk at seam depth B = 2 (object ids into
  the chunk's point list, `closure.hexagram_points(2)` currency), with:
  every proper 4-colouring making some distance-2 pair monochromatic
  (solver-UNSAT in TWO independent encodings — one-hot with
  first-occurrence breaking, and binary-2bit), 1-minimality (every member's
  deletion un-fires, each with a validated countermodel IN the artifact),
  12 near-rot6 shells about the metapivot. De Grey's L was 121 vertices —
  the size echo is striking and unexplained.
* **The law it instantiates** (G16): the seam fabric cannot stay clean at
  d = 2 once it has seam depth ≥ 2 — measured on four objects; d = 2 is
  the ρ₁₅ spindle distance (4·2² − 1 = 15), so every kill needs √15: the
  field wall (G1) is the wall between the acts.
* **The lesson**: shrink from slack, not onset (onset-radius cores stay
  floppy: fabric 276/330, 510 201/280 vs the chunk's tight 122/378).
* **The 3-cover companion** (G17): 13 interior points on
  (7−√33)/6 ∪ {1/3} ∪ (9−√33)/6 deliver min-cover 3 onto Heule-510's
  36-circle — the 3rd colour's delivery web, with addresses.
* Annex (may land after this stub): the 1581 √3-pair core (assembly-created
  pigeonhole, onset at the √21 shell).

## The three rungs (expected order)

1. **The pigeonhole certificates.** FIRST the free one: the 1581's
   9-vertex √3-pair core (M33 §R annex) as a kernel theorem by plain
   `decide` (4⁹ colourings) over M18's certified √3-triangle geometry —
   likely a same-day landing that exercises the whole statement shape.
   THEN the main one: "Every proper 4-colouring of the
   122-core has a mono d2 pair among its instances" is ONE finite CNF
   UNSAT — route it through the M05/M06 kernel-LRAT pipeline (emit CNF via
   the M33 encoding, CaDiCaL proposes LRAT, the kernel checks). The CNF is
   ~1/50th the 1581's; the geometry (every vertex a chunk lattice point,
   every edge a certified chord family member) is ALREADY kernel-certified
   at M26 — the statement composes `Hexagram.lean`'s objects with the
   avoidance clause set. Also state A1 (fan ⟺ χ, the two-line general
   lemma — `Coverage.lean` vocabulary meeting `Compulsion.lean`'s genre)
   while the file is open; §0f F6 named its shape.
2. **The kill act, per placement.** Each mono-d2 placement dies by a ρ₁₅
   spindle (Quadrature.lean holds the ρ₁₅ instance of the law; the M26
   transport genre collapses congruent placements). The census question
   FIRST (design script, before Lean): how many of the core's d2 instances
   are congruent under the chunk's symmetries — the A3 width budget.
   Warm-up option if the engine wants it: the pair-web completeness at
   axis 2 (`build/m32-pairweb.json`, the standing Lean warm-up).
3. **The union question — the research.** fabric ∪ (a kill gadget per
   placement class) : is it 5-chromatic, and what is the LEAST such union?
   The honest gap: the pigeonhole forces a mono pair SOMEWHERE; the union
   must kill EVERY placement; the composition theorem (χ ≥ 5 of the union
   from certificate + transported kills, no monolithic SAT) is the M20
   compulsion genre at assembly scale. If the union lands, its closure
   becomes the certification programme's new, far smaller object
   (`plans/M33-witness-closure.md` remains the fallback).

## Standing adoptions for this milestone

* The write-up trigger's artifact shape is now decided (Kooshi,
  2026-08-10): the zeta-23 comparator pattern — see the memory note and
  CLAUDE.md § paths. If rung 1 lands, consider standing up `comparator/`
  (ChallengeDeps + Challenge with the pigeonhole statement) EARLY so the
  trusted surface accretes; `leanprover/comparator` with nanoda can serve
  as the deferred independent-kernel gate.
* All M33 instruments (`tools/mechanism.py`, `rigidity.class_avoid`) are
  standing; the m33-core schema is the handoff contract; the parallelism
  rule (threads bounded by RAM) is standing.

## Beyond this milestone — the k = 5 transfer (recorded 2026-08-11, the
## close discussion with Kooshi; NOT M34 scope, the first stone of the 6-hunt)

The class-avoidance instrument transfers to five colours with one flag,
and the question it asks there has never been asked: a 6-forcer needs an
Act One over 5-COLOURINGS ("no 5-colouring of this region avoids pattern
P everywhere"), and all prior k = 5 measurements were instance meters —
structurally blind to it (that blindness is exactly what M33 broke at
k = 4). The natural first class is the fan itself: "every 5-colouring
puts 5 colours on some circle-plus-centre" is the 6-transition in our own
coverage vocabulary. Sweep objects: the witnesses, their gen-1 closures,
enriched assemblies. If ANY class fires at k = 5, it is the first
concrete piece of a χ ≥ 6 argument anyone has held. Minimality note from
the same discussion: "smallest 5-witness" is now an explicit optimization
— minimize |pigeonhole| + #placement-classes × |kill gadget| — with the
pigeonhole term measured to be a rounding error (9 vertices); the game is
placement symmetry and kill-gadget size.

**Hunting heuristics (the M33 patterns, stated once for reuse):**
(1) compulsion onsets land on NAMED shells — predict from the shell
vocabulary (glue shell, √33 family, cross-system √21) before running
solvers; (2) seam DEPTH switches compulsions on where radius does not —
probe deep, not wide; (3) cores concentrate where class instances
organize into secondary structure (√3-pairs → triangles with shared unit
circumcentres) — hunt the organizing gadget, not the bare class;
(4) the field ladder — each colour step's pigeonhole is native to the
current field, its kills one field up (4: seam group; 5: seam pigeonhole,
√15 kills) — if it echoes, it names the 6-forcer's kill arithmetic in
advance.

## Failure clauses (sharpen at subplan registration)

* The LRAT certificate for the 122-core exceeds kernel budget: measure the
  certificate size FIRST (it should be tiny next to M06's); if it somehow
  balloons, the M05 spike's segmentation machinery exists.
* The placement census fragments (no small congruence-class set): the A3
  width budget explodes — report the measured shape; the union question
  re-ladders rather than rescoping silently.
* The union goes 4-colourable at every affordable size: THE two-act
  assembly reading (G15's remaining [reading] half) is refuted for this
  pigeonhole — a first-class finding; report and re-rank.
* Any segfault, any process: HALT and report to Kooshi (standing).

## Deliverables

* The kernel-checked pigeonhole theorem (rung 1) + A1 stated.
* The placement census + width budget (design script artifact).
* The union experiment's registered predictions and face-value verdicts.
* Frontier/Grokkings close per standing rule; the explorer gains the
  union object if one lands.

---

# §0 — The registered subplan (2026-08-11, desktop; committed before any solver or Lean run)

*Machine: the desktop (32 cores, 128 GB). The free geometry in this section was
computed by `build/m34-design.py` (gitignored) — exact 16-basis field arithmetic
through `tools/mechanism.py`'s own loaders (the M33 object-id currency), ZERO
colour queries, zero Lean. Everything below §0a cites those numbers.*

## §0a — A priori derivations (before any instrument, before any proof)

**B1 — The bridge identity.** A proper k-colouring of a graph (V, E) that
avoids making any pair in a list P monochromatic IS a proper k-colouring of
the augmented graph (V, E ++ P), and conversely. So the pigeonhole theorem
("every proper 4-colouring of the core makes some listed pair mono") is
exactly `¬ (edgeGraph n (E ++ P)).Colorable k` plus a ten-line bridge lemma
— and the ENTIRE certified SAT chain (coloringCNF, the mask checker, the
emitters, the cube machinery) applies to the augmented edge list VERBATIM,
zero new trusted code. M33 §0f F1 observed the clause identity tools-side
("avoidance clauses at arity 2 are edge clauses"); B1 is the same fact
promoted to the kernel side. The one care: `edgeGraph` must tolerate the
pair list's entries exactly as edges (i < j normalization, no duplicates
against E — the design script confirms E and P are disjoint: unit and
distance-2/√3 are different exact numbers).

**B2 — The transmuter factorization (the 9-core's proof, derived from the
measured structure).** `build/m34-design.py` confirms the M33 annex exactly:
13 induced unit edges, 6 √3-pairs (the two triangles {794,868,995} and
{1187,1262,1390}), hub 791 adjacent to both centres 793/1186 AND to exactly
the non-pinned rim members {868,995}/{1262,1390}, one rim–rim edge 794–1187.
Consequence, derived: the pigeonhole factors through a FIVE-vertex lemma —
the **transmuter**: for colours (h, z, a, b, c) with edges z–a, z–b, z–c,
h–z, h–b, h–c and the class conditions a≠b, a≠c, b≠c, necessarily h = a
(the triangle is rainbow in the three colours ≠ z; h avoids z, b, c; one
colour is left and it is a's). Decidable at 4⁵ = 1,024 — instant — and the
9-core theorem is two transmuter instances composed through the 794–1187
edge: c(794) = c(791) = c(1187), refused. NO 4⁹ search is ever run.
Geometric aside, measured exactly: |791 − 794| = |791 − 1187| = 2 — the
transmuter's forced-equal transfer happens across the ρ₁₅ SPINDLE distance;
the √3-avoidance hypothesis manufactures forced-equal d = 2 pairs, i.e. the
√3 pigeonhole and the d2 currency are linked INSIDE the gadget. (This is an
observation for the Frontier, not a claim to lean on.)

**B3 — A1's Lean shape: `deleteIncidenceSet`, not vertex deletion.**
`Critical.lean` already models "G − v" as `G.deleteIncidenceSet v` (drop the
edges, keep the vertex) — no subtypes, no casts, and the module's isolating-
colouring machinery is exactly A1's extension move. The statement:

> `theorem not_colorable_iff_covers (v : V) (hdel : (G.deleteIncidenceSet v).Colorable k) : ¬ G.Colorable k ↔ ∀ C : (G.deleteIncidenceSet v).Coloring (Fin k), ∀ c : Fin k, ∃ w, G.Adj v w ∧ C w = c`

← : a G-colouring is proper on the subgraph (deleteIncidenceSet ≤ G), its
copy covers N(v), so v's own colour sits on a G-neighbour — refused. → :
contrapositive; a subgraph colouring missing colour c on N(v) recolours v
to c and every G-edge survives (edges at v: neighbours avoid c; edges off
v: untouched, present in the subgraph). Two short proofs, the M18
`fan_iff_coverage` recolouring move at a deleted vertex. Spec example at
decide scale (the pendant-triangle genre). Home: the new milestone module,
NOT `Critical.lean` — that module is imported by certificate instances and
a docstring-bearing edit there rebuilds hours of certificates (the M11
trace rule).

**B4 — The plane corollaries, with honest attribution.** Each core theorem
plus its geometry certificate yields a plane-level compulsion in M20's
genre: **every proper 4-colouring of the plane makes some pair at distance
√3 monochromatic** (from the 9), and **some pair at distance 2
monochromatic** (from the 122). Attribution, stated now so the docstrings
cannot drift: the √3 statement is classical folklore (the spindle
literature's virtual-edge distance; de Grey's paper argues the triple
form), and the d = 2 statement is the pigeonhole shadow of what Haugland
(arXiv:2608.04542, 2026) builds as a forced-EQUAL pair; neither plane
statement is new mathematics. What IS ours: the 1-minimal nine-vertex and
122-vertex carriers (instrument-found), and — to our knowledge — the first
kernel-checked formalizations of either compulsion. The write-up policy is
unchanged; these are rungs.

**B5 — The union arithmetic, priced a priori (rungs 2–3).** The kill
currency is the virtual edge (forced-DISTINCT pair at the class distance).
In-house material: the 791-forcer's six forced-EQUAL pairs (axis at 4,
five antipodal at 4/√3 — solver-measured, M30, promotable per-pair by
LRAT). One unit-edge chain converts forced-equal at δ into forced-distinct
at any d with |δ − 1| ≤ d ≤ δ + 1: δ = 4/√3 ≈ 2.309 reaches BOTH √3 and 2.
Per-placement gadget ≈ 792 vertices. Bands: 9-core union ≈ 9 + 6·792 ≈
4.8k vertices; 122-core union ≈ 122 + 40·792 ≈ 31.8k. The composition
needs NO monolithic SAT: pigeonhole certificate + per-placement kill
certificates + chain edges ⟹ χ ≥ 5 structurally (A5's architecture, live).
The measured obstacle, derived before running anything: the chain
PLACEMENT rotation leaves the certified tower — the triangle (x, y, w)
with |xy| = √3, |xw| = 4/√3, |yw| = 1 has cos α = 11/12, sin α = √23/12
(√23!), and the d = 2 variant picks up √429 = √(3·11·13) (√13). So rung 3
is TOOLS-SIDE this milestone (sympy-exact geometry, CaDiCaL verdicts);
its Lean certification is priced as field-tower growth and deferred to
the milestone after, gated on the union actually landing.

**B6 — The organizing-distance law (why 9 vs 122, named).** A mono-d-pair
class concentrates into a tiny core exactly when its instances organize
into equilateral d-triangles with a common UNIT neighbour — and the
circumradius of a d-triangle is d/√3, which equals 1 iff **d = √3**. The
√3 class is the unique pair class whose organizing gadget (triangle +
unit circumcentre, M18's `exists_unit_triangle_iff` object) exists in
unit-distance geometry; d = 2's circumradius would be 2/√3, not a unit
distance, so its carrier stays spread (122, no local gadget). One line of
arithmetic, and it explains the M33 annex's "why this core is tiny"
observation structurally. Recorded as a remark; no new Lean needed (M18
owns the geometry).

## §0b — Definitions and contracts

* **New hand module** `Proofs/HadwigerNelson/Pigeonhole.lean` (imports
  EdgeList/Fan-side vocabulary only — never a certificate): the bridge
  lemma (B1) as an iff, the `MonoPair` vocabulary, the transmuter (B2),
  and A1 (B3). Every definition with a spec example; negative controls
  (an avoidable class on a colourable graph refuses the pigeonhole; a
  non-covering vertex refuses A1's ←).
* **The 9-core instance** `Proofs/HadwigerNelson/Instances/Core9.lean`
  (one module — 9 points, 13 + 6 distance decides): a `UDCert 9` with
  denom **512** (the design script's lcm; coordinates from the committed
  1581 table's own values, basis touching √3/√5/√7 products, NO √11),
  edges = the 13 unit pairs; the 6 √3-pairs certified by the generalized
  pair check (below); the pigeonhole theorem via B2's transmuters; the
  plane corollary (B4). The certificate JSON is emitted by
  `build/m34-design.py --emit` (untrusted); Lean re-decides everything.
* **The generalized pair check**: `UDCert.PairsAt c es r : Bool` — every
  listed pair's stored squared distance is `r · denom²` — with soundness
  `dist (eval …) (eval …) = Real.sqrt r` (at r = 3) / `= 2` (at r = 4,
  where the root is rational and stated rationally). Lives in
  `Certificate.lean`?? NO — new module `Pigeonhole.lean` or Core9 itself;
  `Certificate.lean` is imported by every certificate table and a
  declaration edit there rebuilds the world (M11 rule). Home decided at
  the modeling pass; the CONTRACT is: decidable Bool over the same Q4
  arithmetic, soundness by the same `valid_sound` route.
* **The 122-core instance** `Proofs/HadwigerNelson/Instances/Core122/`
  (generated directory, emit_cert.py / emit_mask.py):
  - `Table.lean` — 122 points, denom **12**, coordinates in the seam
    sub-basis {1, √3, √11, √33} (design script: basis indices {0,1,8,9},
    chunk currency `closure.hexagram_points(2)` ids recorded in a `--`
    comment, free downstream);
  - `Edges.lean` — the 421 induced unit edges; `Pairs.lean` — the 40
    d2 pairs; `Aug.lean` (or in Edges) — `core122Aug = core122Edges ++
    core122Pairs`, the augmented list the CNF is built from;
  - `Geom*.lean` / `Valid.lean` — ValidOn chunks for the 421 + PairsAt
    for the 40;
  - `Cnf/` — clause table + segments + `core122_unsat :
    (coloringCNF 4 122 core122Aug).Unsat`, NO pins, NO cubes (the CNF is
    488 vars / ~1,966 clauses; the plain refutation is expected trivial,
    and skipping the Gadget/ports layer keeps the assembly to
    `not_colorable_of_unsat` alone);
  - `Core122.lean` (or `Bound.lean`) — the pigeonhole theorem + the
    plane d = 2 corollary.
* **Statement shapes, fixed now** (read-aloud gate anchors):
  - core: `∀ C : (edgeGraph n E).Coloring (Fin 4), ∃ p ∈ P, C p.1 = C p.2`
    — properness over the LISTED unit edges only (weaker hypothesis =
    stronger theorem; the plane colouring restricts to it);
  - plane: `∀ C : (unitDistance ℂ).Coloring (Fin 4), ∃ x y : ℂ,
    dist x y = 2 ∧ C x = C y` (and `= Real.sqrt 3` for the 9) — via the
    certificate's `eval` embedding; transfer to `EuclideanSpace ℝ (Fin 2)`
    by the standing congruence.
* **Rung-2 census artifact** `build/m34-census.json`: the 40 instances
  classified under the hexagram's exact symmetries about the metapivot
  (rot6 × the mirror), plus the per-class placement frames — the A3 width
  budget as data. Exact arithmetic, no SAT.
* **Rung-3 union artifact** `build/m34-union-*.json`: object inventory
  (pigeonhole vertices, per-placement gadget copies, chain vertices),
  the k = 4 SAT verdict with model-validation on SAT, three-outcome
  honesty, `promotion` fields per M33's ladder. Sympy-exact coordinates
  (√23 enters); float prefilter + exact confirm for every edge.

## §0c — Registered predictions (bands committed before any solver or Lean run)

* **P1 [high]** — the transmuter decides at 4⁵ instantly; the 9-core
  pigeonhole composes in ≤ 30 lines; `Core9.lean` (13 + 6 decides at
  denom 512) elaborates in ≤ 60 s; the plane √3 corollary lands the same
  day. Failure would implicate the B2 derivation, not the machinery.
* **P2 [high]** — the 122 augmented CNF is UNSAT by CaDiCaL in < 1 s;
  the LRAT certificate is ≤ 300k propagation steps, ≤ 20 segments, ≤ 3 MB
  (calibration: Heule-510 = 10.5k clauses → 1.41M steps, 86 segments,
  13 MB; ours is 5.4× smaller in clauses and was instant for M33's
  solver); the kernel replay of all segments completes in ≤ 30 desktop-
  minutes of wall clock through `scripts/build.sh`.
* **P3 [medium]** — the Core122 geometry (461 decides, denom 12, seam
  sub-basis) elaborates at ≤ 0.05 s/edge marginal (de Grey's was 0.16 at
  denom 768 with full basis; smaller integers are cheaper), single Geom
  batch, peak module memory ≤ 8 GB (measured before the batch width is
  chosen, per the standing rule). What would change it: the fixed 28 s +
  3.9 GB per-module floor dominating — then split, nothing else moves.
* **P4 [high]** — A1 states and proves in ≤ 40 lines against
  `deleteIncidenceSet`, no new axioms, with a decide-scale spec example
  and a negative control; the 510 factorization REMARK (its fan reading +
  A1 + the M31-validated 4-colouring of 510 − v0 re-derive χ(510) ≥ 5)
  is stated as a comment, not re-certified (the LRAT bound already
  exists; re-deriving it through A1 would add a redundant trust path).
* **P5 [medium]** — the 40 d2 instances fall into ≤ 8 congruence classes
  under rot6 × mirror about the metapivot (the core is near-rot6: ten of
  twelve shells at counts 12/6). Failure branch (≥ 20 classes): the
  width budget explodes; report the measured shape, re-ladder the union
  question — registered as the stub's census-fragmentation clause.
* **P6 [medium]** — the 9-core union (9 + six 791-forcer chains at the
  4/√3 antipodal pairs, √23 geometry, ≈ 4.8k vertices) reads UNSAT at
  k = 4. The logic PREDICTS UNSAT independent of the solver (pigeonhole
  + kills compose); the SAT run therefore controls the GEOMETRY and the
  encoding, not the argument — a SAT verdict would mean a placement bug
  or a forced-pair reading that fails to transport, and is reported at
  face value either way. Cost band: minutes (4.8k vertices ≈ M31's
  gen-1 closure scale, which solved in ~1 s at k = 5).
* **P7 [implementation checkpoint, not a prediction]** — before building
  any chain: read `build/m30-rigidity-forcer791.json` for whether the
  791 already carries forced-DISTINCT pairs (virtual edges) at √3 or 2 —
  if yes, the chain vertex is unnecessary at those placements and the
  field obstruction may shrink. The file already holds the answer; no
  new query is run to consult it.
* **P8 [high, gating]** — controls, all seen red AND green before any
  new verdict is believed: (i) the bridge lemma's negative control (an
  explicit avoiding colouring on a colourable augmented graph — spec
  example in `Pigeonhole.lean`); (ii) the Core9/Core122 cert negative
  controls (a perturbed vertex makes `badEdges`/the pair check name the
  culprit — the DeGrey `#guard` pattern); (iii) the 122 UNSAT
  re-confirmed through M33's binary re-encode BEFORE the LRAT is
  emitted (decorrelation, standing); (iv) an id-shuffle control on the
  dense reindexing of the 40-pair list.
* **P9 [medium]** — cost: the whole milestone ≤ 3 desktop-days wall
  including builds; the Core122 certificate build ≤ 1 h; no single SAT
  call over 300 s (cap; `unknown ≥ cap` is never a claim).
* **P10 — the rung-3 gate (a decision rule)**: IF the 9-core union reads
  UNSAT with validated geometry AND the placement census (P5) stays
  ≤ 8 classes, the NEXT milestone's headline candidate is the certified
  union (χ ≥ 5 by composition, no monolithic SAT — A5 realized (mod the
  791-forcer's six pair-LRATs and the field-tower growth, both priced));
  ELSE the certification fallback stands unchanged and the union verdict
  is reported at face value.

## §0d — Instruments to build or touch

* `build/m34-design.py` (exists; gitignored): grows `--emit` (cert JSONs
  for Core9/Core122 in `emit_cert.py`'s format + the pair lists + the
  augmented DIMACS for CaDiCaL) and `--census` (P5's congruence classes).
* `tools/emit_cert.py`, `tools/emit_mask.py`: reused as-is (the augmented
  edge list is just an edge list to both). Any change they DO need is a
  finding, reported.
* The rung-3 union builder: `build/m34-union.py` (gitignored), sympy-exact
  placements, CaDiCaL verdicts, model validation on SAT, M33's artifact
  conventions (`promotion`, three-outcome honesty, object ids).
* `tools/rigidity.py` / `tools/mechanism.py`: consulted read-only
  (P7; the standing instruments are not modified this milestone).
* The explorer: gains the union object IF one lands (standing artifact
  URL, update never re-mint); otherwise untouched.

## §0e — Costs, machine, discipline

Desktop (32 cores, 128 GB). Builds ONLY through `./scripts/build.sh`
(never `lake build`, bare or named); generated Core122 modules enter
`scripts/build_order.py`'s world — measure the Geom/Seg module peak RSS
before choosing batch width. One heavy job at a time (a certificate
build IS a heavy job); the standing parallelism rule applies WITHIN a
tool run (the union SAT sweeps thread-pool at cores − 2). `python3 -u`
for background runs, no pipes on task output. Segfault, any process:
HALT and report to Kooshi. Lean iteration via `lake env lean` never
concludes a module green (autoImplicit trap). Predictions above are
committed before the first solver call and the first `lake` invocation
of the milestone; any mid-milestone additional experiment registers a
§0-addendum first (the M32/M33 pattern). The statement-reading gate
(read the final statement aloud against the informal claim) runs at
close on all four headline statements (two cores, two plane
corollaries) — B4's attribution wording is part of that gate.

## §0f — Domain modeling pass (2026-08-11, fresh invocation)

**D1 — The bridge is honestly two graphs.** The augmented graph (E ++ P) is
the CERTIFICATE's subject — the SAT vehicle — while the base-graph statement
(∀ proper colourings of E, some P-pair mono) is the PRODUCT the plane
consumes. The bridge is the seam, proven once. Proof-run refinement: the
forward lemma (`mono_pair_of_not_colorable_append`) needs NO `p.1 ≠ p.2`
hypothesis — building the augmented colouring from an avoiding one never
meets a loop; the iff's other direction genuinely needs it (a loop pair is
stripped by `edgeGraph` and cannot be avoided). `hP` moves to the iff only.
Unsampled members checked: P = [] (vacuous-consistent), duplicates and
swapped pairs (harmless).

**D2 — Completeness is extrinsic.** "P is ALL pairs at exact distance d
among these points" is consumed by the INTERPRETATION (the M33 class
semantics), never by a downstream proof. Side check per core: kernel
`decide` over all C(n,2) pairs if affordable (measure first), else the
compiled `#guard` in the DeGrey pattern — the fallback NAMED in the file as
a compiled cross-check, not a kernel fact.

**D3 — The transmuter stays k = 4, pure colour.** The general-k form has no
second consumer and trades an instant `decide` for Finset machinery. All 9
inequality hypotheses believed load-bearing (mutation audit at the
obligation pass). The graph content (which hypothesis is an edge, which is
class avoidance) wires in at the instance. A concrete non-vacuity example
(z,a,b,c,h) = (0,1,2,3,1) joins the spec block.

**D4 — The pair check gets its own small module.** `PairDist.lean` (imports
Certificate.lean; nothing frozen is edited — Certificate.lean is imported
by every certificate table and a declaration edit there rebuilds hours):
`pairsAt (c : UDCert n) (ps) (r : ℤ) : Bool` + ONE soundness lemma
`… → dist (eval i) (eval j) = Real.sqrt r`, nonnegativity of r DERIVED
inside the proof from the real geometry (the Glue.lean precedent), never
assumed. Instances specialize (√3 stays as `Real.sqrt 3`; √4 rewrites to 2
by a one-line instance step).

**D5 — A1's RHS stays raw.** No existing predicate names the mixed-graph
form (colouring on `deleteIncidenceSet v`, adjacency from G), and a mint
for one consumer is speculative structure. Found and recorded: since v is
ISOLATED in the deleted graph, the raw coverage RHS is exactly
`Fan (G.deleteIncidenceSet v) k v N(v)` read through v's colour freedom —
the instrument's `fan(G − v, N(v))` query shape, literally. Docstring
remark now; the Fan-form corollary is minted only when a consumer (the
510-fan promotion) actually arrives.

**D6 — Q4 reuse and bare existentials confirmed.** The fixed 16-basis
tower is pipeline-intrinsic (all trusted machinery is Q4-fixed); dead
coordinates at denom 12 are cheap and buy the whole certificate chain.
Plane corollaries: bare ∃ over `unitDistance ℂ` (house model, M20's
genre); the finite core theorems ARE the constructive strong forms
carrying addresses; no EuclideanSpace transfer (a ∀-colourings statement
has no consumer there).

## §0g — Obligation modeling pass (2026-08-11, fresh invocation)

**G-1 — A1 is UNCONDITIONAL (the pass's find).** Neither direction of
`not_colorable_iff_covers` touches the `(G.deleteIncidenceSet v).Colorable k`
hypothesis: if the deleted graph refuses k colours the RHS is vacuously true
over an empty domain AND the LHS holds (a G-colouring would restrict), so
the iff survives; when it is colourable both directions are the M18
recolouring move (→ contrapositive: a deleted-colouring missing colour c on
N(v) extends by φ = if · = v then c else C ·, properness split at-v /
off-v through `deleteIncidenceSet_adj`; ← : restrict along
`deleteIncidenceSet_le`, coverage at colour D v hands a neighbour wearing
D v, refused by D.valid). The hypothesis was the fan INTERPRETATION, not
the mathematics — it moves to the docstring. Stronger statement, same
proof.

**G-2 — The bridge proves iff-first.** `colorable_append_iff_exists_avoiding`
carries the one four-case properness construction (mpr — the
`fan_iff_coverage` house pattern over `List.mem_append`: E-edge /
P-pair × orientation, each one line) and the restriction (mp — needs `hP`,
via `edgeGraph_adj_mono` + `List.subset_append_left`);
`mono_pair_of_not_colorable_append` becomes a three-line corollary
(by_contra + mpr). One construction, stated once.

**G-3 — The transmuter's mutation audit is ONE decide**: nine existential
conjuncts (each hypothesis dropped admits a countermodel with h ≠ a),
4⁵ each — the audit that certifies every hypothesis load-bearing, in one
named example.

**G-4 — Core9 wiring checked against the measured edges.** Dense relabel
[791,793,794,868,995,1186,1187,1262,1390] → 0..8; the six ¬MonoPair facts
apply pointwise (membership by decide); transmuter instance 1 consumes
C.valid at dense edges (1,2),(1,3),(1,4),(0,1),(0,3),(0,4) — all present,
orientations match the hypothesis order as stated; instance 2 at
(5,6),(5,7),(5,8),(0,5),(0,7),(0,8); the refusal at edge (2,6) = 794–1187.
A have-chain of ~15 named lines; no 4⁹ anywhere.

**G-5 — pairsAt soundness needs NO nonnegativity anywhere** (simpler than
§0f D4 thought): the route mirrors `dist_toPlane_eq_one` — eval the exact
identity into ℝ, `normSq (diff) = (r : ℝ)` by field_simp +
linear_combination, then `dist = Real.sqrt (r : ℝ)` is `Complex.dist_eq` +
`norm_def` + the rewrite. A negative r merely makes the hypothesis
unsatisfiable. The instance step: `Real.sqrt 4 = 2` via `4 = 2^2` +
`Real.sqrt_sq`.

**G-6 — The Core122 chain, every intermediate named**: `core122 : UDCert
122` → `core122_valid` (chunked ValidOn decides) → `core122_pairs_dist`
(pairsAt … 4 = true, decide) → `core122Aug := core122.edges ++
core122Pairs` (the CNF's subject; the emitted `agreesWithCNF` cites this
name) → `core122_unsat : (coloringCNF 4 122 core122Aug).Unsat` (segments;
emit_mask.py's no-pins path is an implementation checkpoint — if the
emitter hardcodes a cube, pass the empty cube and discharge `cubeCNF … []
= []` by rfl, or make the minimal emitter change and report it) →
`core122_not_colorable` (not_colorable_of_unsat, 0 < 4 by norm_num) →
`core122_pigeonhole` (the bridge) → `core122_plane` (embed by
`core122.point`, properness from valid_sound, witnesses from the
pigeonhole pair, distance from pairsAt soundness + √4 = 2). Core9: same
chain with decide in place of the LRAT and √3 left as `Real.sqrt 3`.

**G-7 — Completeness checks sized.** Core9: C(9,2) = 36 distSq decides —
kernel, unconditional. Core122: C(122,2) = 7,381 — ONE measured kernel
attempt (band ≤ 10 min; the deGrey marginal was 0.16 s/edge at denom 768,
ours is denom 12), with the compiled `#guard` as the standing floor and
the demotion NAMED in the file if the kernel attempt exceeds budget.

**G-8 — The partition.** PROVE (kernel): both bridge lemmas, transmuter +
audit, core9 pigeonhole + plane, A1 + both controls, pairsAt soundness,
core122 valid/pairs/unsat/pigeonhole/plane, core9 completeness. TEST
(compiled #guard + spec examples): cert shape pins (counts, dedup, i < j,
denom), badEdges cross-check + adversarial member per cert, completeness-
122 floor, per-def non-vacuity examples. ASSUME (named in artifacts, not
in Lean): CaDiCaL's UNSAT until the kernel replays it (then nothing); the
tools-side identification of dense ids with m33-core object ids (the
DeGrey provenance-note genre: the theorem is about the points as written;
that they are M33's points is a generator property, controlled tools-side
by an exact re-derivation check, never claimed as a theorem).

## §0h — Experience modeling pass (2026-08-11, fresh invocation)

**H1 — The headline docstrings' wording anchors (the read-aloud gate's
fixed targets).** Each of the four carries, in this order: the claim in
plane English; what the kernel checked (the distance identities, the
forcing — "two transmuter instances composed through one edge, no search"
for the 9 / "an LRAT certificate replayed step by step — CaDiCaL proposed
it and is trusted for nothing" for the 122); what is NOT claimed (the
provenance clause, DeGrey pattern: "that these points are M33's core is a
generator property, controlled tools-side; the theorem is about the
points as written"). The plane corollaries add the §0 B4 attribution with
the fixed clause: "**what is new is the carrier, not the compulsion**" —
√3 classical folklore; d = 2 the pigeonhole shadow of Haugland's
fixed-pair form, plus the G16 sentence (distance 2 is the ρ₁₅ spindle
distance; killing this pigeonhole is what needs √15).

**H2 — Pigeonhole.lean's API surface.** The advertised entry is
`mono_pair_of_not_colorable_append` (module header says so); the iff is
its two-way form for controls. Minted: `not_monoPair_iff :
¬ MonoPair P C ↔ ∀ p ∈ P, C p.1 ≠ C p.2` — the one lemma the bridge
proof and every instance would otherwise re-derive by the same
push/simp preamble. No `@[simp]` anywhere in the module (nothing here is
a rewrite target; the global speech act is not spent). The transmuter's
docstring names the reuse contract (gadget vocabulary for union
assemblies: properness facts in, forced transfer out). A1's docstring
carries three sentences: the instrument mapping (`fan(G − v, N(v))` — the
min-cover top row IS this statement), the Fan-isolated-vertex reading
(§0f D5), and the 510-factorization remark (its fan reading + this lemma
+ the validated 4-colouring of 510 − v0 re-derive χ(510) ≥ 5; not
re-certified — the LRAT bound already exists).

**H3 — Instance-module control surfaces, fixed.** Per instance file, in
the DeGrey pattern: shape `#guard`s (vertex/edge/pair counts, dedup,
i < j, the denom literal); the compiled `badEdges.isEmpty` cross-check;
the adversarial guard (vertex 0 perturbed → the check names it); the
dense-id ↔ object-id table as `--` comments (free downstream, M11). The
completeness demotion wording is written NOW so a budget failure has its
honest sentence ready: "the kernel decide at C(122,2) pairs exceeded the
measured budget (N min) and was demoted per §0g G-7 to the compiled
check below; the pigeonhole theorem does not depend on completeness."

**H4 — Artifact vocabulary.** `build/m34-census.json`: {schema:
"m34-census v1 (plans/M34-act-one-certified.md §0b)", object, core
{n, class}, instances (object-id pairs), group: "rot6 × mirror about
meta", classes: [{rep, members, frame}], n_classes, status}.
`build/m34-union-*.json`: {schema: "m34-union v1 (…)", pigeonhole
{core, n, instances}, kills: [{placement, forcer_pair, chain_vertex,
field_growth, n_vertices}], union {n, n_edges}, verdict {k, outcome,
seconds, promotion}, model_validated, status}. All M33 conventions bind
(exact string + float radii, promotion rungs, object ids only, verdicts
never claim past caps).

**H5 — The close's gate additions.** `Proofs.lean` gains the new modules
(the flat import surface is the gate's domain); `scripts/Axioms.lean`
gains the four headline theorems (the trust receipt names them). The
close report leads with the two-act price table (pigeonhole 9 / 122
vertices ≈ free; kills ≈ 792 vertices per placement) and the rung-3
verdicts at face value.

---

# §R — Results (2026-08-11, desktop; filled as verdicts land, every one at face value)

## Measured so far (mid-milestone; the scorecard completes at close)

* **The 122 CNF matched its band exactly**: 488 vars, 1,966 clauses. Unpinned
  refutation 3.5 s / 34 MB ASCII LRAT (above the ≤ 3 MB band — the full 4!
  palette symmetry); the PINNED route (triangle 0–1–84 to colours 0,1,2, the
  Heule-510 pattern) refutes in 0.10 s at 1.76 MB / 12,578 lines — inside the
  band, and the route taken. Registered controls before believing it: the
  binary re-encode UNSAT and the id-shuffle UNSAT, both green.
* **emit_mask on the augmented list, unchanged**: 9,861 clauses
  (1,966 + 3 + 7,892 derived), 173,075 hints, 16 segments, 1.4 MB of source,
  projected kernel replay 0.06 h.
* **P5 CONFIRMED, sharper than the band**: the forty d2 instances fall into
  **FIVE congruence classes** (11 + 11 + 6 + 6 + 6; band was ≤ 8) under the
  full order-12 dihedral group about the metapivot — which preserves the
  CHUNK exactly (all twelve isometries; the 122-core itself is preserved
  only by the identity, consistent with M33's near-rot6 defects). Every
  class endpoint lands on named shells: 1/2 + √33/18 ↔ 13/6 − √33/18,
  5/6 − √33/18 ↔ 13/6 − √33/18, 4/3 ↔ 4/3, the ±√33/9 conjugate pair, and
  1 ↔ 1 (the unit ring about the metapivot). The width budget: five kill
  theorems cover forty placements. `build/m34-census.json`.
* **P7 checkpoint read**: the 791-forcer's virtual-edge sweep holds ZERO
  confirmed forced-distinct pairs (970 unsettled at cap, status unknown) —
  no free chain shortcut; the forced-equal + unit-edge chain stands as
  registered, √23 growth and all.
