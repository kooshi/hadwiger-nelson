# M31 — The minimal 5-closure: the first rung above the field wall (PRE-SUBPLAN STUB)

*Written 2026-08-09 at the field-jump decision; consumes M30's outputs. A fresh
session should read `plans/M30-degrey-anatomy.md` first — the mission context and
the registered expectations live there — then this stub.*

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
