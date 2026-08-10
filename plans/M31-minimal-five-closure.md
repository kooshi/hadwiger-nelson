# M31 — The minimal 5-closure: the first rung above the field wall (SUBPLAN)

*Stub written 2026-08-09 at the field-jump decision; subplanned 2026-08-10 on
Kooshi's go ("You are go for M31 subplanning AND implementation"). A fresh
session should read `plans/M30-degrey-anatomy.md` first — the mission context and
the registered expectations live there — then this file whole. The stub sections
(down to "Failure clauses") are the inherited context; the subplan proper starts
at §0.*

## The object being hunted

The seam-field ladder proved that closures built from ⟨ζ₆, σ⟩ are exactly
4-chromatic (M24 pair, M25 four-ladder, M26 hexagram). This milestone builds the
first closures in the **de Grey group** (expected ⟨ζ₆, σ, ρ₁₅, ρ₆₃⟩, confirmed or
corrected by M30) and finds the smallest one whose chromatic number is **at least
5** — measured by SAT first, certified later (M32). Two candidate shapes, ranked by
M30's anatomy:

* **The family-bundle closure**: the smallest set of centres + circles closed under
  the group whose chord families include the classes that carry ≥ 70% of the
  1581-graph's edges (M30 E3). This is the bet that the 5-mechanism is a *few*
  interacting webs, the way the 4-mechanism was the spindle twist σ².
* **The witness closure** (fallback if E3 failed): the smallest closure containing
  one whole certified witness (510 is the cheapest — its vertex table and geometry
  are already kernel-certified in `Instances/Heule510`). Its χ ≥ 5 is inherited,
  free, from `heule510` — the question is only how SMALL the closure is and what
  its chord classification looks like.

Either way the object is countable, lattice-structured, and — by the de
Bruijn–Erdős compactness theorem, available since our axiom base includes choice —
its chromatic number is the sup over its finite subgraphs, so SAT on growing chunks
is an honest estimator with one-sided certainty (a 5-chromatic finite chunk settles
χ ≥ 5 forever; only the ≤-direction needs the eventual colour-table proof).

## What transfers from the seam field (cite, don't rebuild)

* **One-pivot floor and cap transfer verbatim**: the two-circle theorem (M19) and
  `chromaticNumber_concentric` (M20) are uncountable statements — every one-pivot
  system in ANY field is exactly 4 with centre, 3 without. Pairs are the floor of
  this hunt.
* **The gluing classification** (M22 `Glue.lean`) is stated for any two centres and
  radii — the circle-intersection bookkeeping is field-free.
* **The engine PATTERN** (bridge → master identity → clearing → parity split →
  finitely many kills → boundary decides → tables): method transfers; the specific
  lemmas do NOT — the new seams have norm-4 and norm-16 algebraic integers
  (M30 E2), so expect **2-adic** clearing arithmetic where M24 had 3-adic. Budget
  real research time for the new kill lemmas; this is the milestone's hard core.
* **The instrument suite**: `tools/couple.py`'s census architecture (exact
  arithmetic in the extended field — sympy number fields are already proven here),
  the rigidity instrument (M30 item 1), and the registered-prediction discipline.
* **Radius inventory warning**: the seam field had circles {1, 1/√3} per centre.
  The new group's spindles act over distances 2 and 4, and the closure operations
  may generate MORE radii per centre (the subplan must derive the closed radius
  set before anything else — in the seam field this derivation is what produced
  the inner circle).

## The M30 handoff (written 2026-08-09 at M30's close — the anatomy's actual numbers)

**What M30 measured, and what it does to this milestone's bets** (full detail in
`plans/M30-degrey-anatomy.md` §R):

* **The true group is the half-spindle group ⟨ζ₁₂, σ, √ρ₁₅, √ρ₆₃⟩** — √ρ₁₅ =
  (√15+i)/4, √ρ₆₃ = (3√7+i)/8. The registered four-generator group covers only
  58% of the 1581's edges as whole words; every remaining direction squares into
  it. Build the closures in half-spindle currency from the start.
* **The family-bundle bet is DEAD** (E3 refuted; its failure clause fires): the
  1581 has 67 direction classes with a flat head (top-6 ≈ 12%), 819 circles
  about one centre, and is **at or near edge-critical** (single random edge
  deletions flip it 4-colourable) — the 5-forcing is distributed, not
  concentrated. No small family bundle carries it; a candidate closure must
  contain a whole witness's structure.
* **The 1581 is the only pure-group witness.** Heule 510/553 each carry 6
  direction classes (9–10 edges) OUTSIDE the half-spindle group — their
  closures need extra generators. The witness-closure route runs through the
  1581 (or a pure-group 5-chromatic subgraph of it, if M31 finds one smaller).
* **The seed content is seam-field**: all 39 construction seeds live in
  ℚ(√3,√11); the whole 1581 is a seam object twisted by two half-spindle
  rotations about two centres ((0,0) and (−2,0), distance 2 apart).

**Candidate closures, ranked (the M30 §1 item-5 deliverable):**

| # | Object | Generators | Why this rank |
|---|---|---|---|
| 1 | **The de Grey pair**: the ⟨ζ₆,σ⟩-ladders of the two spindle centres (0,0), (−2,0), closed under the ρ₁₅-web (the spindle coupling at distance 2) | ζ₆, σ, ρ₁₅ (half forms as needed) | The M21-analogue floor one field up: the smallest genuinely-new coupled object; where the 2-adic engine gets built. Expected χ = 4 — its value is the engine, not the fork. |
| 2 | **The 1581-witness closure**: the 39-seed hex₁₂ orbit's full half-spindle closure | ζ₁₂, σ, √ρ₁₅, √ρ₆₃ | χ ≥ 5 inherited from the certified `degrey` instance — the M32 target object. The radius/centre inventory is THIS milestone's derivation work (819 circles about one centre says it is lattice-like, not few-shell). |
| 3 | Heule-510 closure with residue generators | half-spindle + the 6 residue rotations | Smallest vertex count, dirtiest group; fallback only. |

**A caution from R7's deflation**: near-edge-criticality means SAT χ-measurement
of growing chunks will be NOISY at the boundary (one missing closure edge can
read χ = 4) — chunk truncation must keep whole neighbourhoods, and every χ = 4
reading needs the chunk's boundary audited before it is believed.

**The post-close observations (Kooshi, 2026-08-09, reading the visualizer —
each verified exactly before recording):**

* **De Grey's near-mirror is exact on half the graph and its defect is a
  chirality classifier.** The vertical mirror through x = −2 (the committed
  frame's axis through the two 24-word spindle centres, at (−2.25, 1.98) and
  (−1.75, 1.98)) matches the base and ρ₆₃ copies point-for-point (786 + 3
  fusions) and matches NONE of the 792 ρ₁₅-twisted points — the "asymmetric
  pockets" are exactly the first spindle's chirality (mirroring sends ρ₁₅ to
  ρ₁₅⁻¹, which the graph does not contain). The defect map is an instrument:
  one reflection splits the construction.
* **Every forcing rotation is a small detune off an exact crystal angle**:
  ρ₁₅ is 1.045° off 30°, ρ₆₃ is 0.638° off 15°, the Moser twist 3.557° off
  30°, the seam 1.779° off 75°. Exact symmetry adds no colour constraint (the
  copy reuses the base's pattern); the detune forces the clash — "mitosis" is
  the right image, and the spindle is a forcer mid-division.
* **Heule's 510 contains the certified hexagram as its central organ, with
  the seam appearing by name.** Pivot-signature scan (points on radius-1 and
  radius-1/√3 circles about each vertex, exact arithmetic): the centre v0
  (24 inner + 36 outer) plus EXACTLY SIX pivots at EXACTLY distance 1/√3 in
  a hexagon (18 inner + 24 outer each) — M26's hexagram skeleton — plus
  further ring pivots at exactly (1/√3)·σ̄ = (1/6, −√11/6): **the seam
  rotation σ, appearing explicitly in Heule's published coordinates.**
  Heule 553: centre (36 + 38) plus THREE unit-distance pivots (the M21/M23
  pivot-pair/triangle configurations) plus the 1/√3 ring. The seam-field
  certified objects are the skeleton of the smallest known 5-forcers.

**The ring inventory (Kooshi's second observation, 2026-08-09, verified exact):**
grouping every Heule vertex by its EXACT squared distance from the centre:
510 has just **44 distinct radii** (509 points), 553 has **36** (552 points) —
and **every single one lies in ℚ(√33)**: rational + rational·√33, not one
carrying √5, √7, or √15. The radial structure of the smallest known
5-chromatic graphs is 100% seam-field; the new field's content is purely
ANGULAR. (The invariance argument says why: rotations about the centre
preserve radii, so a graph assembled as half-spindle words applied to
seam-field material keeps seam radii — the measured spectra confirm the
fabric ⊗ detune decomposition at the strongest level.) Identified rings:
r² = 1, 1/3 (pivot ring), 4/3 (the forced-pair radius), 3, 4, **5/3 =
|1 + σ/√3|²** (a unit-distance pivot's inner circle seen from the centre —
and its conjugate |1 − σ/√3|² = 1 lands exactly ON the unit ring: M21/M22's
seam interlock, visible in Heule's published data); the ±√33 conjugate-pair
rings include 12 rings exactly matching the certified hexagram chunk's
spectrum (187/509 and 212/552 points), saturating at height B = 2 — the
remaining conjugate pairs (3/2 ± √33/6, 7/6 ± √33/6, 2 ± √33/3, …) are
other-anchor pivot-web rings, not deeper heights. No near-degenerate ring
pairs exist (Δr < 0.002: zero) — the visual "noise" past the fourth ring is
thin, closely spaced rings, not ring-splitting. 553 is measurably tidier
than 510 (36 rings vs 44, top ring 49 points vs 36). **Consequence for this
milestone**: the closed-radius-set derivation — this stub's biggest warned
unknown — now has an empirical target: build candidate closures on the
measured ℚ(√33) ring inventory with angular words in the half-spindle group.
Caution: the inventory is a property of these two witnesses, not of all
5-forcers; and the 1581's 819-circle mess (E3) came from measuring about a
point that is NOT a global rotation centre of its two-spindle construction —
single-centred objects like Heule's are the clean currency.

**The ownership factorization (Kooshi's third observation, 2026-08-09,
verified exact).** Splitting the 1581 by copy tag — base/spindle15 points
owned by the origin-copy centre (committed vertex 791), spindle63/both
points by its ρ₆₃-image (vertex 0), exactly one shared point (the spindle
pivot (−2,0)) — the 819-circle single-centre mess factors COMPLETELY:
**each half has exactly 29 distinct radii about its own centre, all in
ℚ(√33), and the two spectra are identical ring-for-ring** (the halves are
congruent under ρ₆₃). And the radial vocabulary is SHARED ACROSS WITNESSES:
25 of de Grey's 29 rings are rings of Heule 510's inventory (22 of 553's);
730/791 of a half's points sit on 510-ring radii. **Every known 5-chromatic
witness stands on one ~30–44-value seam-field shell inventory** — measured
three ways, consistently. The closed radius set for closure design is this
inventory. (Instrument note: an ownership overlay — colour by owning
centre — belongs in the visualizer with the defect map.)

**Candidate #0, added on these findings — the mitotic hexagram**: the certified
hexagram (or its Heule variant with seam-conjugate ring pivots) UNION one
detuned copy (a half-spindle rotation sharing the centre or a pivot). The
smallest object that marries a certified 4-chromatic seam organ to the new
field's forcing mechanism. Test order: does its closure's SAT χ reach 5 at
any affordable chunk? The containment fact above is NOT a causal claim (the
1581 is near-edge-critical — deletion cannot localize the forcing); the
mitotic-hexagram SAT run is the causal test. Instruments to promote first:
the defect map and the pivot-signature scan into `tools/anatomy.py` + the
visualizer as overlays.

**The literature check (2026-08-10, Kooshi's find — see the `five-chromatic-papers`
memory and CLAUDE.md Grokkings G7/G11/G3-amendment):** Haugland
(arXiv:2608.04542, five days old) independently builds a Moser-spindle-free
5-chromatic graph (2,131 vertices) by exactly the candidate-#0 design shape:
a fabric (heptagonal, his crystal) with an explicit detune parameter, driven
through the rigidity currency — a virtual edge at √3 (740-vertex gadget) →
a forced-equal pair at distance 2 → the closing spindle, whose rotation is
OUR ρ₁₅. Two consequences for this milestone: (a) the mitotic-assembly route
is independently validated at the mechanism level — and our version starts
from a CERTIFIED fabric with exact-arithmetic instruments where his uses
floats and uncertified SAT; (b) the fabric is a free parameter — if the
hexagonal mitotic hexagram stalls, the design space includes other crystals.
Import targets when convenient: Parts' 509 (arXiv:2010.12665 — the G3/G4
shell test) and Haugland's 2,131 (needs cubic-field machinery, cos 2π/7 —
milestone-scale; kernel-certifying the first Moser-free 5-forcer at sane
size is a possible insertion, Kooshi's call).

## Registered questions for the subplan (predictions before instruments)

* Smallest χ ≥ 5 closure size: how many centres? (The 510-witness spans a bounded
  patch; the anatomy may show a 2–4-centre bundle suffices. Register a guess AFTER
  M30's numbers exist, not before.)
* Is the 5-chromatic closure's χ exactly 5 (SAT finds 5-colourings) or does the
  closure push to 6? **A closure that SAT refuses at k = 5 is the jackpot** — a
  candidate χ(ℝ²) ≥ 6 witness generator — and immediately escalates: verify with
  independent seeds/solvers, extract a finite core, take it straight to the
  kernel pipeline (which has certified 5-refutations before; k = 5 refutation cost
  was measured at M12).
* Does the rigid part of the 510's colour space (rigidity instrument, M30) live
  INSIDE the candidate closure or use points outside it?

## Subplan seeds — implementation notes saved from the M30 sessions (2026-08-10)

*Working knowledge that would otherwise die with the conversation; the subplanning
session should read these before designing instruments.*

* **One field basis everywhere.** `field.py`, `degrey.py`, `couple.py`,
  `anatomy.py`, `hexchunk.py` all use the SAME 16-dim basis (PRIMES [3,5,7,11],
  bit k ⟺ √primes[k]; B1,B3,B11,B33 = 0,1,8,9). Consequence: hexagram chunk
  points (couple/hexchunk representation) can be **exactly** rotated by the new
  field's generators (ρ₁₅, √ρ₁₅ = (√15+i)/4, etc. from `anatomy.py`) with no
  conversion — the mitotic-hexagram object is buildable today: rotate
  `hexchunk.gen_points(B)` about a shared centre/pivot, union, dedup by exact
  key, `unit_edges` sweep, feed `rigidity.py`. Mixed-radical cross-chords are
  just 16-vector arithmetic.
* **The probe order that respects registration**: write §0 (predicted χ of the
  mitotic hexagram at each B; predicted cross-chord counts; the detune-band
  guess), COMMIT, then run. SAT χ first at k = 3, 4, 5 with the vacuity-guard
  discipline; remember chunk-χ is noisy near criticality (audit boundaries
  before believing any 4).
* **Instrument facts**: `rigidity.py --graph X.json --k K [--sym S.json]
  [--census CAP]` takes any n/edges JSON; its violation-query loop settles
  sides completely or reports honest unknowns; the census soundness lives in
  the Python canonical set, blocking clauses only accelerate. The TRIPLE-query
  extension (needed for the compulsion-cascade thread, M32 stub): same
  selector pattern — s_i → (pattern constraint over a triple), one clause
  ⋁s_i; a SAT model teaches, UNSAT mass-confirms. Costs measured on the
  desktop: 791-forcer full pair sweep ≈ 45 min; hexagram B=1 census to cap
  10⁴ ≈ 35 min; 1581 k=5 full pair sweep ≈ 30 s; single 1581 k=4 SAT ≈ 1–30 s,
  monolithic k=4 UNSAT > 80 min (use the kernel fact instead, or cubes).
* **Background-job hygiene**: `python3 -u` (block buffering hides all progress
  otherwise); pipe task output through nothing (a `| tail` truncates the
  record); per-call SAT timeouts always; one heavy job at a time still binds.
* **Viz**: new objects go into `tools/degrey-viz.html` via
  `tools/degreyviz_refresh.py` ONLY (never hand-edit the data block); the
  ownership overlay (colour by owning centre) and defect-map overlay are
  wanted and unbuilt; artifact updates re-publish the same file path.

## Deliverables

* The closed radius set + centre lattice, derived and census-checked.
* Chord censuses of the candidate closures (exact arithmetic, planted-failure
  self-tests, the M26 bin-wrap lesson applied from day one).
* SAT χ-measurements over growing chunks, with the growth curve reported.
* **The closure-explorer visualizer** (deliverable): the candidate closure rendered
  in the `tools/hexagram-viz.html` architecture — circles, per-class chord
  toggles, the certified-witness vertices highlighted inside the closure, forced
  equalities overlaid. This is the instrument Kooshi plays with to "see if
  anything falls out"; treat it as a first-class deliverable, not decoration.
* The M32 handoff: the chosen object, its measured χ, its chord-class list with
  the clearing arithmetic characterized (which primes, which parities).

## Failure clauses (registered)

* If every buildable closure's SAT χ stays 4 until the closure practically
  contains a whole witness: report at face value — the 5-mechanism would then be
  irreducibly global, itself a publishable structural finding, and M32 retargets
  to the witness closure.
* If the census explodes (the extended group's webs too numerous to classify):
  report the measured growth, cut to the smallest honest sub-object, and record
  what was NOT swept — no silent truncation.

---

# SUBPLAN (2026-08-10, committed before any instrument runs)

## §0 — Registered predictions

*Discipline: everything in this section is written and committed BEFORE any new
instrument executes. §0a is pure a-priori derivation (paper arithmetic, no code
run); it is registered as reasoning, and its consequences are predictions the
instruments then test. Where a §0a claim fails in the census, the derivation is
wrong and the failure is reported at face value.*

### §0a — The quadrature law (a-priori derivation, to be script-verified)

Setting: seam-field material (all M24–M26 objects, all de Grey seeds) has both
coordinates in K := ℚ(√3, √11) (4-dim: 1, √3, √11, √33). A **detune word** is a
unit rotation R = s·W with s in the seam-decoration part (any complex number
with both components in K and |s| = 1 — includes ζ₆, ζ₁₂, σ and all their
words) and W a word in the new-field generators √ρ₁₅ = (√15+i)/4,
√ρ₆₃ = (3√7+i)/8. Powers close as follows (checked by hand):

* even powers of √ρ₁₅ (i.e. powers of ρ₁₅ = (7+i√15)/8): Re ∈ ℚ, Im ∈ √15·ℚ;
* odd powers of √ρ₁₅: Re ∈ √15·ℚ, Im ∈ ℚ;
* likewise for √ρ₆₃ with √7 in place of √15;
* any word with BOTH families' content non-trivially: Re/Im spread over
  {ℚ+√105·ℚ} × {√15·ℚ+√7·ℚ}-shaped spans (four independent radical blocks).

For chunk points x = anchor + u, y = anchor + v (u, v seam-field offsets from
the rotation anchor), a unit cross-chord between the detuned copy and the base
means |R·u − v|² = 1, i.e. |u|² + |v|² − 2·Re(W·(s·u·v̄)) = 1. Writing
z = s·u·v̄ = xᵣ + i·yᵣ with xᵣ, yᵣ ∈ K, and expanding Re(W·z) per radical
block, the 16-dim basis splits K, √15·K, √7·K, √105·K into DISJOINT spans, so
the single equation splits into one equation per block. Consequences:

1. **Even (full-spindle) words pin collinearity**: W = ρ₁₅ᵏ (k ≠ 0) forces the
   √15-block to vanish ⟹ Im(s·u·v̄) = 0 — u and s·-twisted v are collinear
   through the anchor — and the K-block gives the **conic**
   t² + r² − 2·Re(W)·(±t·r) = 1 in the radii t = |u|, r = |v| (sign = same/
   opposite ray). For W = ρ₁₅: t² + r² − (7/4)·t·r = 1 with rational solutions
   (2,2) — the classical distance-2 spindle — and (2, 3/2); the opposite-ray
   branch needs r² with denominator 15, impossible for {2,3}-smooth-denominator
   seam lattices (registered: the opposite-ray branch is EMPTY for ladder
   material). For W = ρ₆₃: t² + r² − (31/16)·t·r = 1, rational diagonal (4,4)
   — the distance-4 spindle.
2. **Odd (half-spindle) words pin perpendicularity**: W = √ρ₁₅^(2k+1) forces
   Re(s·u·v̄) = 0 — perpendicular through the anchor — with conic
   t² + r² ± 2·Im(W)·t·r = 1 (for √ρ₁₅: t² + r² ± t·r/2 = 1). The
   half-spindle DIAGONAL (t = r, the naive spindle shell) sits at
   radius² = 8 + 2√15 (i.e. √3+√5) for √ρ₁₅ and 32 + 12√7 for √ρ₆₃ — both
   OUTSIDE the ℚ(√33) ring vocabulary, so half-spindle detunes never couple
   diagonally to seam material; only perpendicular conic pairs can carry.
3. **Mixed words are sterile**: any W with both √ρ₁₅- and √ρ₆₃-content forces
   all four blocks to vanish ⟹ u·v̄ = 0 ⟹ no cross chord at all.
4. **Pure seam words (W = 1)** reduce to the M24–M26 chord theory (the known
   families).

The law in one line: **a detuned union couples to its base only along
anchor-collinear pairs (full spindles) or anchor-perpendicular pairs (half
spindles) whose radii sit on an explicit conic; mixed detunes couple not at
all.** This is the geometric skeleton of the "2-adic web" and the reason
5-forcers must run the forced-pair pipeline (de Grey, Haugland) instead of
relying on chord soup: single detunes are THIN by law.

*Verification protocol: every cross chord found by any census this milestone
is checked against the law at find time (violation = loud abort naming the
chord); the self-test plants both a true spindle chord (must be found) and a
law-violating fake (must be caught). Kernel certification of the ρ₁₅ instance
is DEFERRED to M32 by decision here — it is the first kill lemma of the
2-adic engine and belongs with that engine's Lean work; M31 stays
instruments-only.*

### §0b — Numbered predictions (falsifiable, with confidence)

* **P1 (the law holds)**: zero law-violating chords in every census this
  milestone. Confidence: very high (it is arithmetic). Falsifier: any chord
  whose pin fails — which would mean §0a's block-independence argument is
  wrong, reported at face value.
* **P2 (mitotic hexagram is 4-chromatic)**: for every single-detune union
  H(B) ∪ R·H(B) probed (anchors: metapivot, a hex pivot; R ∈ {ρ₁₅, ρ₆₃,
  √ρ₁₅, √ρ₆₃}; B ≤ 1): cross-chord count ≤ 40 per variant (point estimates:
  0 for ρ₆₃ at any anchor — the (4,4) diagonal is outside the chunk's radial
  reach ≈ 2.16; 0–20 for ρ₁₅; small-unknown for the halves), and SAT
  χ = 4 for every variant. Confidence: 85%. This is the CAUSAL test of G6
  (hexagram-as-central-organ): if χ = 4 everywhere, containment-in-witnesses
  loses causal candidacy at single-detune order and the Grokking is annotated.
* **P3 (de Grey pair is 4-chromatic, and is the engine's build site)**: the
  two-ladder object at centre distance 2 has a nonempty seam chord family
  census (register 10–100 chords at B = 2), the ρ₁₅ mitosis adds the
  pivot-level spindle chord (centre₂ → ρ₁₅·centre₂ — both centres, echoing
  M23's self-gluing) plus ≤ 30 conic chords, and SAT χ = 4. Confidence: 85%.
  Deliverable regardless of χ: the cleared-equation shapes (which primes,
  which parities) — the M32 handoff.
* **P4 (witness-closure growth)**: gen-1 half-spindle closure of the 1581
  (each generator ±1 about both spindle centres, once) lands at 12k–40k
  points after exact dedup. Confidence: medium.
* **P5 (no jackpot)**: no k = 5 refusal at any affordable chunk (P < 5% that
  one fires). If one fires: independent-seed verification, then the finite
  core straight to the kernel certificate pipeline (registered escalation).
* **P6 (ring law)**: single-centre orbits FREEZE the ring inventory
  (invariance — rotations about c preserve radii about c; theorem-shaped,
  trivial); the two-centre gen-1 closure's about-centre ring count grows from
  819 to 2,000–6,000. Confidence: medium.
* **P7 (stub question 3, ranked last, optional)**: Heule-510 minus one vertex
  is 4-colourable (vertex-criticality of SAT-shrunk witnesses; P 80%), and
  its k = 4 forced pairs concentrate at spindle-able distances. Run only if
  the main blocks land early.
* **P8 (the frontier curve)**: growing chunks of the witness closure about
  the spindle axis: no 5-chromatic chunk below 800 vertices (P 70%); the
  SAT-findability transition (k = 4 colouring stops being findable at 300 s)
  sits at 1,200–1,600 committed-scale vertices. Honesty rule: "unknown ≥ cap"
  is never reported as χ = 5; only a cube-split-certified UNSAT (or the
  kernel fact for the full 1581) counts as a 5-chromatic chunk.
* **P9 (the enrichment question — genuinely open, 50/50)**: adding gen-1
  closure points to a sub-1581 chunk enables a 5-chromatic subgraph SMALLER
  than 1581 vertices (the witness was SAT-shrunk under a subgraph constraint;
  the closure offers a denser edge soup). If yes: "least geometry" pays
  immediately and M32's object shrinks. If no: near-edge-criticality binds
  even with enrichment — evidence the 5-mechanism is irreducibly global at
  this scale (the registered failure clause's finding).
* **P10 (the milestone verdict)**: the smallest χ ≥ 5 closure this milestone
  certifies-by-SAT is the 1581-witness closure itself (2 centres, half-spindle
  generators); no smaller-generator or fewer-centre closure reaches 5 at
  affordable chunks. Confidence: 65% — P9 is the branch that would beat it.

### §0c — Scope ladder (committed order; a timeout leaves a coherent prefix)

1. `tools/closure.py` + self-tests (planted spindle chord found; planted law
   violation caught; ζ₆-rotation dedup control; SAT wrapper red/green on
   K₅/K₄ at k = 4).
2. Probe A: mitotic hexagram sweep (cheap; P1/P2).
3. Probe B: de Grey pair (P3 + the clearing-shape handoff).
4. Probe C: witness closure gen-1 (P4/P5/P6), then the frontier curve
   (P8/P9) — the heavy block, background, one job at a time, per-call caps.
5. The closure-explorer visualizer + the ownership/defect overlays promoted
   into the anatomy explorer.
6. Optional if early: P7 rigidity run on 510−v; the triple-query rigidity
   extension remains M32-stub work unless time is abundant.
7. Close: Frontier + Grokkings + M32 stub rewrite + report.

Modeling passes for this milestone: **domain** (always) and **experience**
(the visualizer, the CLI surfaces, the M32 handoff contract are consumer
surfaces) — obligation-modeling is SKIPPED with reason stated: no Lean
obligations this milestone (the quadrature lemma is deferred to M32 by the
§0a decision), matching the M30 instruments-only precedent.

## §1 — Instruments (the shapes, before implementation)

**`tools/closure.py`** (new; imports `couple.py` arithmetic + `hexchunk.py`
points; generators re-declared in couple currency with |g| = 1 asserted
exactly at import):

* `mitosis(points, anchor, R)` → union of base and R-about-anchor copy,
  exact dedup, provenance tags (copy 0/1), fusion record.
* `cross_chords(A, B)` → float triage (numpy) then exact confirm; every
  found chord immediately checked against the §0a law (pin + conic named
  per chord); violation aborts loudly.
* `close_gen(points, centres, gens)` → one word-length generation, growth
  and collision (fusion) reporting; graded, never "the whole orbit".
* `chunk(points, edges, centre, r2max)` → induced ball with whole
  neighbourhoods; rigidity-JSON export (n/edges).
* `chi_probe(graph, k, cap)` → one SAT call via `coloring.base_clauses` +
  `forcer._solve`, three-outcome honest (SAT/UNSAT/unknown-at-cap).
* `--self-test` with the four §0c-item-1 controls.

**Probe A details**: variants = {metapivot, hexPivot 0} × {ρ₁₅, ρ₆₃, √ρ₁₅,
√ρ₆₃} at B = 1 (234-pt chunk → ~468-pt unions). Census + SAT k = 3, 4, 5
each. Cost estimate: < 2 min/variant.

**Probe B details**: the pair object = ⟨ζ₆,σ⟩-ladders (outer+inner circles,
|b| ≤ 2) at centres 0 and 2 (the de Grey spindle distance, on the real
axis), plus the two centre points; census its internal seam chords (the
distance-2 analogue of M24's families — the cleared-equation shapes recorded
per family: constant, parity class, prime content); then mitosis by ρ₁₅
about centre 0; census + SAT as in A.

**Probe C details**: load the committed 1581 (anatomy's tables); gen-1 =
all ±1 applications of {ζ₁₂, σ, √ρ₁₅, √ρ₆₃} about both spindle centres;
growth/fusion/ring numbers (P4/P6); one k = 5 SAT probe on the full gen-1
object (background, cap 3,600 s — P5); the frontier curve: balls about the
axis midpoint at growing radius, plain and gen-1-enriched, k = 4 with 300 s
caps (P8/P9); at most ONE confirmatory cube-split UNSAT at the most
interesting radius (systemd-capped, one job at a time).

**Visualizer**: the closure explorer renders probe objects (base/copy
colour-split, cross chords as a togglable class, the law's pin lines on
hover); the ownership + defect-map overlays go into `tools/degrey-viz.html`
via `degreyviz_refresh.py`; artifacts re-published to the SAME urls.

**Reporting artifacts**: `build/m31-mitosis-*.json`, `build/m31-pair.json`,
`build/m31-closure-gen1.json`, `build/m31-frontier.json` — field names are
the M32 contract: `object`, `anchor`, `detune`, `cross_chords` (each with
`pin`, `conic`, `radii`), `chi` (`{k, status, seconds}` per k), `growth`,
`rings`.

## §0d — Domain pass (2026-08-10, decisions before implementation)

* **Detune = spec + value.** The quadrature class is NOT computable from R's raw
  16-vectors (seam decoration mixes radical blocks); the detune enters factored:
  `(s, a, b)` — seam part, √ρ₁₅-exponent, √ρ₆₃-exponent. Class = total function
  of (a mod 2, b mod 2, a=0, b=0) ∈ {seam, even15, odd15, even63, odd63, mixed};
  `mixed` is representable on purpose (its census is the sterility control).
  Value computed once, |R| = 1 asserted exactly, spec and value travel together.
* **Mitotic union** = hexchunk's table/labels dedup idiom; provenance tag =
  transform index (0 = base); fusions = multi-provenance points, controlled
  against the independently computed R-fixed-point set. Intra-copy edge count
  must equal intra-base (isometry) — a free automorphism control every census
  asserts.
* **Cross-chord = certificate-carrying record** built at find time: {pair, pin
  kind + exact-zero check on the quadrature component of s·u·v̄, conic
  (t², r², t·r, side)}. Pin failure aborts loudly (the P1 falsifier channel).
* **Closure = BFS tree over the group action** (per-point generation/move/parent;
  words recoverable by parent-chasing, never stored whole). Chunks: exact
  complete induced edges; the SAMPLED thing is the vertex set, and the record
  says so.
* **One boundary conversion** couple ⇄ degrey currency (same 16-basis, lists vs
  tuples), two named functions, round-trip self-test; closure.py is internally
  couple-currency.
* **Float triage soundness**: real chords err ~1e-13 in float64; nearest known
  near-miss |d²−1| ≈ 0.035 (M22's near-relation) — window 1e-6 is five orders
  safe both ways; every candidate exactly confirmed, and the planted-chord
  self-test exercises the triage path.

## §0e — Experience pass (2026-08-10, surfaces before implementation)

* **Closure explorer**: per-variant selector (anchor × detune × B); point
  classes base/copy/fusion with the anchor marked; cross chords a distinct
  togglable class whose hover draws the pin geometry in product terms
  ("collinear through the anchor, radii 2 and 3/2"); STERILE variants listed
  with their zero and the law's reason — absences visible, never omitted;
  frontier curve as a badged chart (SAT green / unknown-at-cap amber /
  certified-UNSAT red; plain vs enriched series). Data injected only by the
  refresh script; artifacts re-published to the same URLs.
* **JSON contract** (M32 reads these names): `object`, `detune {s,a,b,class}`,
  `anchor`, `counts {base,copy,fused,union}`, `edges {intra_base, intra_copy,
  cross}`, `cross_chords [{i,j,pin,conic{t2,r2,tr,side}}]`, `chi [{k, outcome
  ∈ sat|unsat|unknown, seconds, cap}]`, `controls {isometry_edge_match,
  fixed_points, law_violations}` — controls travel IN the artifact.
* **CLI failure paths**: law violation → banner naming the chord, the nonzero
  quadrature component, and "registered prediction P1 is FALSIFIED — §0a's
  block-independence argument is wrong", exit 3; empty census → "0 cross
  chords — a RESULT: class X is sterile/thin by law" (bad-goal vs bad-set
  distinguished); `unknown-at-cap` never worded as a χ bound; self-test shows
  every control red on cue then green.

---

# §R — Results (2026-08-10, written as they landed; verdicts at face value)

## The quadrature law and the mitotic censuses (P1, P2, P3)

* **P1 HOLDS.** Zero law violations across all 26 census variants (12 hexagram
  variants at B = 1, 12 at B = 2, 2 pair variants). Mixed detunes: exactly zero
  non-anchor cross chords everywhere probed. The instrument's planted-failure
  self-test (a perpendicular pair handed to an even detune) goes red on cue,
  naming P1.
* **The census learned one honest lesson at first contact**: when the anchor is
  itself a chunk point, every unit-neighbour of the anchor produces a degenerate
  "cross reading" through u = 0 which the law passes vacuously (z = 0). The
  mixed-detune row — sterile by law, yet showing 48 chords — was the tripwire
  that caught it. Anchor-incident chords are now a separate class; the law
  speaks only about genuine coupling.
* **P2 HOLDS**: every mitotic hexagram variant reads χ = 4 (k = 3 unsat,
  k = 4 sat — full three-outcome runs, cap never hit). Cross-chord counts,
  B = 2: metapivot anchor — ρ₁₅: 0, ρ₆₃: 0, √ρ₁₅: **12**, √ρ₆₃: 0, mixed: 0,
  ζ₁₂·ρ₁₅: 0; pivot anchor — ρ₁₅: **6**, √ρ₁₅: **2**, others 0. All ≤ 40 as
  registered. **G6's causal candidacy at single-detune order is dead**: marrying
  the certified hexagram to one new-field detune produces thin, law-pinned
  coupling and no 5th-colour pressure.
* **The couplings land EXACTLY on the a-priori conic**, and the census found a
  channel the derivation admits but the subplan did not anticipate:
  - pivot-anchored ρ₁₅: 2 chords on the **(2, 2) spindle diagonal** (t² = r² =
    4 — the hexagram holds material at exact distance 2 from its pivots), plus
    at B = 2 **four conjugate-ring chords** at t² = (17∓√33)/6, r² = (17±√33)/6,
    t·r = 8/3 — the ℚ(√33) conjugate-pair rings couple to EACH OTHER through
    the full spindle, collinearly. The witnesses' conjugate-ring spectra are an
    ACTIVE coupling channel, not inventory.
  - metapivot/pivot-anchored √ρ₁₅: all chords at the perpendicular diagonal
    t² = r² = 2/3, t·r = −2/3 (2/3 + 2/3 − 1/3 = 1). The half-spindle couples
    the hexagram's inner-scale rings perpendicular-wise.
  - ρ₆₃ and √ρ₆₃: sterile at chunk scale, as predicted (their conic diagonals
    (4,4) and out-of-field sit beyond the chunk's radial reach ≈ 2.16).
* **P3 HOLDS**: the de Grey pair (121 points, ladders at distance 2 + both
  centres). Base coupling: **6 cross-system seam chords + the tangency fusion**
  at the midpoint — 2 hex-family outer–outer chords (pure ℚ(√3)) and 4
  mixed-radius chords at seam heights ±1 whose inner endpoints are exactly
  (1/√3)·σ̄ = (1/6, −√11/6) — **the seam-conjugate point Kooshi spotted in
  Heule's published coordinates, appearing as the distance-2 pair's native
  coupling**. The ρ₁₅ mitosis adds EXACTLY ONE cross chord: the centre-level
  (2,2) spindle chord c₂ → ρ₁₅·c₂ (predicted by name in §0b). χ = 4
  throughout. The M32 clearing handoff: every observed cross equation is
  K-block-split with the §0a pin structure; the conic constants are 7/4 (ρ₁₅),
  1/2 (√ρ₁₅) — denominators 2², 2: the 2-adic engine will clear by powers of 2
  where M24 cleared by √3-powers, and the conjugate-ring channel says the
  clearing must handle ℚ(√33)-conjugate radius pairs, not just rational radii.

## The witness closure (P4, P5, P6)

* **P4 HOLDS**: gen-1 half-spindle closure of the 1581 (8 generator moves × 2
  centres): 1581 → **24,065 points** (+22,484 new, 2,796 collisions) — inside
  the registered 12k–40k. Unit chords: **123,134**; the 1581's own 7,877
  reproduced exactly inside the sweep (the triage path's positive control).
* **P5 HOLDS (no jackpot)**: k = 5 on the whole 24,065-point gen-1 object:
  **SAT in 1.14 s**. The closure stays 5-colourable at gen-1.
* **P6 MISSED LOW, reported at face value**: rings about the origin centre:
  **11,016** exact radii (registered 2,000–6,000; the witness alone had 819).
  Ring growth under the two-centre closure is faster than registered —
  the object is even more lattice-like than the 819-circle reading suggested.

## The frontier curve and the milestone verdict (P8, P9, P10, P7)

* **P8 HOLDS**: the k = 4 SAT-findability frontier over balls about the spindle
  axis midpoint — plain (committed vertices only) and enriched (+ every gen-1
  closure point in the same ball):

  | base ≤ | plain n / outcome | enriched n / outcome |
  |---|---|---|
  | 300 | 300 sat 0.01s | 5,132 sat 0.2s |
  | 600 | 600 sat 0.01s | 8,569 sat 0.4s |
  | 900 | 900 sat 0.02s | 12,120 sat 0.8s |
  | 1200 | 1,200 sat 0.05s | 16,365 sat 17.6s |
  | 1581 | 1,581 **unknown @300s** (UNSAT by the kernel fact) | 23,771 **unknown @300s** |

  No 5-chromatic chunk below 800 vertices (trivially — everything through
  1,200 colours in seconds); the transition sits between 1,200 and 1,581
  committed-scale, inside the registered band. `unknown` rows are cap
  readings, not bounds; the full 1581's refusal is the kernel-certified fact.
* **P9 RESOLVES NO**: gen-1 enrichment does NOT enable a 5-chromatic subgraph
  below the witness scale — the enriched 1200-ball (16,365 vertices, 67,568
  edges, all closure material) 4-colours in 17.6 s. The registered failure
  clause fires AS A FINDING: **the 5-mechanism is irreducibly global at this
  order** — measured now three independent ways (near-edge-criticality M30,
  class-deletion SAT M30, enrichment frontier M31). No cube-split UNSAT was
  spent: no candidate smaller 5-chunk appeared to confirm.
* **P10 HOLDS**: the smallest χ ≥ 5 closure this milestone can certify-by-SAT
  is the 1581-witness closure itself; nothing smaller reached 5.
* **P7 SPLIT, at face value**: Heule-510 minus its centre vertex IS
  4-colourable (registered 80% — confirmed), and the complete pairwise
  rigidity sweep SETTLED in 63 SAT calls / 6 seconds: **zero forced pairs,
  zero virtual edges**. The registered "forced pairs concentrate at
  spindle-able distances" is REFUTED — there are none of ANY kind. One vertex
  below criticality, the 510's colour space has no pairwise rigidity shadow;
  its forcing is even more distributed than de Grey's (whose 791-forcer holds
  six forced pairs). G9 sharpened: rigidity lives at the forcing level and
  NOWHERE below it, not even one vertex below.

## Deliverables shipped

* `tools/closure.py` (self-test: six controls, every one seen red on cue —
  planted conic triple found, planted pin violation caught naming P1, ζ₆
  fusion control, SAT wrapper red/green, mixed sterility, boundary round-trip).
* `build/m31-mitosis-B1.json`, `-B2.json`, `m31-pair.json`,
  `m31-closure-gen1.json` (+ `.pts.json`), `m31-frontier.json`,
  `m31-p7-510-minus-v0.json` — the JSON contract of §0e.
* `tools/closure-viz.html` + `tools/closureviz_refresh.py` — the closure
  explorer (26 variants with pin geometry on hover, gen-1 scatter, the
  badged frontier chart).
* CLAUDE.md § Frontier + § Grokkings updated (G12 minted, G6 causal test
  recorded, G10 third measurement); M32 stub § "The M31 handoff".

## What was NOT done, honestly

* ~~The ownership + defect-map overlays for the ANATOMY explorer~~ — DONE in
  the same session after the core close: both overlays computed in-page from
  the already-spliced tags/coordinates, and both replicate the M30-verified
  facts (790/790/1 ownership split, 792 mirror defects); the explorer
  republished to its standing URL.
* The triple-query rigidity extension: M32-stub work, untouched as planned.
* Stacked mitosis (two+ detunes; the forced-pair pipeline in our fabric):
  NOT probed — it was not registered. It is the natural M32 design question
  the quadrature law points at.
