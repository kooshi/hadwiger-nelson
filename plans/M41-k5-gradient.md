# M41 — The k = 5 gradient hunt: composed 5-forcers, the first probe for 6-tightness, and the Galois orbit (PRE-SUBPLAN STUB)

*Written 2026-08-12, at the direction discussion after M39's close, when Kooshi re-aimed
the programme at the push to 6 from either direction. M40 (the χ > ω hunt in the
constraint-graph family) is the from-above half; THIS stub is the from-below half, written
in full detail so no thought is lost between sessions. Read order for a fresh session:
CLAUDE.md § Grokkings G15–G19 (the two-act theory and the 5-tight-fabric verdict), then
`plans/M34-act-one-certified.md` §R (the union's construction and currency), then
`plans/M35-k5-transfer.md` §R (the all-clean k = 5 sweep — the negative this milestone
attacks), then `plans/M35-certified-union.md` (demoted stub; the union's Lean pricing).*

## The mission, in one paragraph

G19 is the standing verdict: **the 6-hunt's Act One has no stage until someone builds
5-tight fabric** — no object we hold carries any class compulsion at five colours — and
composition of 5-chromatic objects is the only known constructive route to such fabric.
The load-bearing observation this stub records: **that route has never been probed.**
M35's sweep (the first k = 5 class-compulsion measurement anywhere; 52 clean rows) covered
only FOUND objects — the witnesses, the fabric stages, closure chunks, lattice balls. It
never touched: (1) the M34 union, the only *designed* 5-chromatic object in existence;
(2) unions of overlapping witness copies — crystal-aligned translates sharing fabric
wholesale; (3) the witness closure at generation 2 and beyond at k = 5 (gen-1 was measured
exactly once: 24,065 points, k = 5 SAT in 1.14 s, M31). The milestone is the first
measurement campaign on composed 5-chromatic matter, hunting the k = 5 analogue of M21's
"first nonzero gradient". Every k = 5 satisfiability ask on these objects is literally a
6-forcer probe.

## Why the designed-forcer thread's reopening condition is MET

M32's flat verdict (G14) closed the designed-stack thread for objects coupling through
translation *matchings* — 1-regular, "width without degree carries no colour pressure" —
and the parked-list clause in `plans/M33-witness-closure.md` says the thread reopens only
with a mechanism creating **degree-≥ 2 colour pressure across copies**. Crystal-aligned
translation of a witness by vectors of its OWN fabric is that mechanism: the copies do not
couple through a thin chord web at all — they **share vertices and edges wholesale**
(unbounded degree of interaction), so 5-colourings must agree on the shared region rather
than merely avoid a matching. This is also de Grey's own construction shape one level up:
his 1581 is two congruent systems fused at one point (G5); the probe fuses whole witnesses
along whole fabric chunks.

## The probes, in cost order

### 1. The union's k = 5 anatomy (cheap; instruments standing and k-generic)

The M34 union: 9-core pigeonhole + six 791-forcer kill chains, 4,749 vertices, 23,647
edges, χ ≥ 5 by kernel-covered cubes (`build/m34-union-core9.json`). Never measured at
k = 5. Run: forced-pair / virtual-edge sweep, min-cover meters, and the 8-class avoidance
sweep, all at k = 5 (`tools/rigidity.py` is k-generic since M35; the 3-bit re-encode is
banked). **Heed the M34 numbering lesson**: build every certificate from the union JSON's
own vertex order — the M06-era `degrey_graph.json` and the standing loader are different
orders, and the forced-equal control caught exactly this mix once already.

Expectation to sharpen at registration: the union is *barely*-5 (a composition tree), so
likely floppy at k = 5 everywhere except near the pigeonhole core — but "near the core" is
exactly where a reading would matter: the 9-core's transmuters at five colours are the
k = 5 analogue of the M20 one-pivot-cap question.

### 2. Crystal tilings of the 1581 (the headline probe)

Translate de Grey's witness by Eisenstein/fabric vectors so copies overlap maximally:

* **Overlap census first, exact.** For candidate translations t (the unit hex vectors,
  1 + ζ₆, 2, the spindle-centre separation, and the ζ₆-orbit of each), compute
  |V ∩ (V + t)| and the shared-edge count in exact field arithmetic (Q4 tower currency;
  `tools/anatomy.py` holds the loader). Also rotations by ζ₆ powers about each spindle
  centre. Choose the 2–3 maximal-overlap transforms. A translation with tiny overlap is a
  near-disjoint union and teaches nothing — do not run SAT on it.
* **Then the ladder**: 2 copies → 3 copies → 7 copies (hex arrangement about a shared
  centre if the overlap census supports it). At each rung: k = 5 SAT; if SAT, the k = 5
  class sweep + rigidity meters on the union; record how every meter moves with copy count
  — the GRADIENT is the deliverable, not any single row.
* **The jackpot clause, registered verbatim**: the union of unit-distance graphs with
  shared exact coordinates is a unit-distance graph, so **a k = 5 UNSAT on ANY of these
  unions is χ(ℝ²) ≥ 6**. On any refusal: halt the campaign; re-derive the union's edge
  list by a second independent path; verify every vertex identification exactly (field
  arithmetic, zero floats — an identification bug would fabricate constraints);
  re-run in a second encoding; report to Kooshi before writing one word of
  interpretation. Prior LOW — a union of 5-forcers sharing 4-chromatic fabric has no a
  priori reason to refuse five — but this is the first probe ever aimed at the spot.

### 3. Closure generation 2 at k = 5 (expensive; measure size first)

The 1581's half-spindle-group closure at generation 2: measure the point count FIRST
(gen-1 was 24,065; gen-2 may be 10× that), then the incremental k = 5 frontier in M31's
committed-radius style. If the SAT instances outrun the desktop, ask Kooshi for the
256-core server *with the measurement in hand* — the frontier is embarrassingly parallel.
This probes whether DEPTH (more generations of the group) rather than WIDTH (more copies)
tightens the 5-colour space; M22 measured that depth does not move the k = 4 fork, and
nobody has asked at k = 5.

### 4. The Galois orbit of the 1581 (cheap — hours; can run standalone or first)

**The observation, verified 2026-08-12 (recorded here so no session re-derives it):**
the half-spindle group ⟨ζ₁₂, σ, √ρ₁₅, √ρ₆₃⟩ is **stable under every Galois flip** of
ℚ(√3, √5, √7, √11). A flip applied coordinatewise to a + bi (fixing i) is a ring
automorphism of K(i) and preserves |x − y|² = 1, so it maps unit-distance graphs to
unit-distance graphs, edge-for-edge. The generator images:

| flip | σ = (√3 + i√33)/6 | ζ₁₂ = (√3 + i)/2 | √ρ₁₅ = (√15 + i)/4 | √ρ₆₃ = (3√7 + i)/8 |
|---|---|---|---|---|
| √3 ↦ −√3 | −σ = ζ₆³σ | (−√3 + i)/2 = ζ₁₂⁵ | −(√ρ₁₅)⁻¹ = ζ₁₂⁶(√ρ₁₅)⁻¹ | fixed |
| √5 ↦ −√5 | fixed | fixed | ζ₁₂⁶(√ρ₁₅)⁻¹ | fixed |
| √7 ↦ −√7 | fixed | fixed | fixed | ζ₁₂⁶(√ρ₆₃)⁻¹ |
| √11 ↦ −√11 | σ̄ = σ⁻¹ | fixed | fixed | fixed |

(Each image is in the group; all four moduli are 1 — |σ|² = (3+33)/36, |√ρ₁₅|² = 16/16,
|√ρ₆₃|² = 64/64. Note √33 = √3·√11 and √15 = √3·√5 flip when either factor flips.)

**Consequence**: each of the 15 nontrivial Galois conjugates of the 1581 is a 5-chromatic
unit-distance graph with the SAME direction group. **The question: are they
plane-congruent to the original?** Either answer is structure: self-congruence would be a
hidden arithmetic symmetry of de Grey's graph nobody has noticed (suspicious organization
of the best kind — and a constraint on what 5-forcers can be); non-congruence hands us up
to 15 distinct witnesses for free, whose differences are pure Galois data. Method: apply
each flip to the exact coordinates (`tools/anatomy.py` currency), canonicalize under plane
isometry (centre the spindle hearts, compare ring spectra ring-for-ring, then edge-graph
isomorphism with geometric anchoring — the ring spectra are ℚ(√33)-conjugate-paired per
G4, which already hints the √11-flip may be the interesting one). **Control**: conjugate
Heule-510 — its 6 out-of-group residue direction classes are SAT-shrinking scars and
should BREAK any self-congruence; if the control comes back self-congruent too, suspect
the canonicalizer.

### 5. Optional rider: the forced-equivariance sweep

Generalize M30's forced-pair inventory to forced-SYMMETRY queries: for a candidate
isometry g and region R, is "colour ∘ g = colour on R" forced in every proper
k-colouring? (One SAT call each: assert one violating orbit-pair, ask SAT.) The known
instance is the 791 forcer's five antipodal pairs — forced central symmetry on the
radius-2/√3 circle, still mechanically unexplained. Sweep the antipodal map on named
shells across the witnesses at k = 4, then k = 5 on whatever object probe 2 produces. If
5-colourings of composed objects are forced-symmetric anywhere, symmetry classes become
candidate pigeonhole classes for the 6-hunt's Act One — a class family the M35 vocabulary
sweep did not contain.

## Registered-expectation sketch (finalize at subplan registration)

* Union k = 5 anatomy: floppy everywhere [medium-high]; any reading near the 9-core
  [low-medium] and it is the headline if it appears.
* Tilings: 2-copy k = 5 SAT [high]; 7-copy SAT [medium-high]; ANY nonzero k = 5 meter at
  ≥ 3 copies [low-medium] — a nonzero reading is the milestone's product (the k = 5
  first-gradient). Jackpot [very low, registered above].
* Gen-2 closure: size measurement lands [high]; k = 5 stays SAT at every affordable
  frontier [medium-high] — a refusal is the same jackpot clause as probe 2.
* Galois: genuinely unknown — the fun kind. Report at face value either way; the control
  (Heule-510 scars) must break, or the instrument is suspect.

## Failure clauses (sharpen at registration)

* **All probes flat at k = 5**: bank it as the FIFTH independent globality measurement
  (extending G10/G17 to k = 5 composed matter), close honestly, and redirect per the
  standing ranked list — the from-above track (M40's products) and the certification
  programme both stand.
* **Overlap identification ambiguity**: all vertex identification in exact field
  arithmetic; any float-level near-coincidence that exact arithmetic refuses is a HALT
  (an identification bug fabricates constraints and would counterfeit the jackpot).
* **Solver walls**: report the frontier reached; unknown-at-cap is never a refusal. Ask
  for the server with measurements, per the standing hardware rule.
* **Any segfault, any process: HALT and report to Kooshi** (standing).

## Deliverables

The k = 5 meter table across the composition ladder (the gradient, plotted); the overlap
census; the Galois verdict with the canonicalization evidence; any nonzero reading
promoted to a registered follow-up; explorer pane for the tilings if any union carries
structure worth seeing (`tools/closure-viz.html` genre). Lean surface: none registered —
this is a measurement milestone; any find prices its own certification (the M35-certified-
union stub is the template and reopens on a find).
