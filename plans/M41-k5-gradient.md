# M41 — The k = 5 gradient hunt: composed 5-forcers, the first probe for 6-tightness, and the Galois orbit
# (SUBPLAN — §0 registered 2026-08-12, LAPTOP, before any instrument runs; the stub below is the mission context, the §0 sections at the end are the registration)

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

> **AMENDED 2026-08-12, after the shapes pass (`plans/SHAPES-OF-SIX.md` — read it
> FIRST; it re-derives this milestone's probes as kill tests for the 6-forcer shape
> inventory).** Three sharpenings, none removing anything: (0) a NEW phase 0 — the
> Shape-D autopsy: complete mechanism analysis of M40's 23-vertex G\* core (its full
> colouring space, its fractional certificate, and whether the smallest known
> clique-free forcer factors as pigeonhole × kill — G15's universality clause tested
> in a decidable universe; hours, and it calibrates what to look for in every other
> probe). (1) The tiling probe is upgraded from per-union SAT asks to the
> **interface-menu lens** (Shape A): measure the interface algebra — menu moments
> first (forced pairs / forced-equal pairs / coverage ACROSS the interface, the
> standing k-generic meters), full conformation relations only if affordable — then
> AIM a frustrated loop rather than hoping one shows up. The M20 strip automaton is
> the exact method precedent. (2) The gen-2 closure probe now carries a registered
> theory reason (Shape B): the k = 4 pigeonhole was depth-switched (invisible at
> B ≤ 1, fired at B = 2), so the k = 5 analogue predicts generation-depth switching —
> and M35's one solver-effort anomaly (the d = 2 class as the uniformly hardest k = 5
> avoidance) points the same way.

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

---

# SUBPLAN §0 — registered 2026-08-12 (laptop), before any instrument

*Shapes context: `plans/SHAPES-OF-SIX.md` §3 — each phase below is a named shape's kill
test. Machine note, registered up front: subplanning, phase 0 (the autopsy), and phase 4
(Galois) are laptop-class; the tiling unions' refusal-side SAT and the gen-2 closure
belong on the DESKTOP (M34's union cubes ran ~800 s each there; laptop timings are not
comparable and are never written next to desktop numbers — per-machine rule).*

## §0a — Derivations and protocols, committed before any instrument

**D1 — The autopsy protocol (phase 0, Shape D; the golden question in a decidable
universe).** Objects: M40's cores — the 23-vertex G\* core (refuses 6; ω = 4), the
53-vertex deep-pocket core (refuses 7), the 117-vertex ω = 3 core (refuses 6;
centre-free). All re-derivable locally in seconds (`celllat.py --shrink`); coordinates
in `build/m40-chiomega.json`. Per core, in order:

* (a) **Colouring-space census at k = χ**: SAT enumeration with first-occurrence
  palette canonicalization and blocking clauses; count capped at 20,000 models
  (reported as `≥ cap` if hit). The census's shape (orbit structure under the core's
  own stabilizer) is the "conformational repertoire" of the finite lab.
* (b) **Exact fractional χ**: LP over the core's independent sets (floats propose via
  scipy if present, else a hand simplex; the certificate — a primal fractional
  colouring and a dual fractional clique — is re-verified in `Fraction` arithmetic
  before any number is quoted; only the verified bracket is reported). Note
  χ_f(core) ≤ 48/7 is inherited from G\* by subgraph monotonicity — the question is
  how far BELOW it sits (registered P2).
* (c) **Symmetry/defect anatomy**: the core's setwise stabilizer in the dihedral-12
  point group; for each group element g, does C ∪ gC still refuse, and does C ∩ gC
  colour? — locating the forcing relative to the broken symmetry (the cores are
  near-symmetric with defects; WHERE the refusal lives when symmetrized is the
  mechanism's first coordinate).
* (d) **The factorization sweep** (G15's universality clause, decided): vocabulary =
  mono-pair and forced-equal-pair classes at each of the core's difference norms,
  plus shell-coverage patterns; regions = the core's norm-balls and its symmetric
  bulk; one class-avoidance SAT ask per (region, class) at k = χ−1 — the M33
  instrument genre on a ≤ 117-vertex object, instant per ask. Output: the fires/clean
  table, read as either a two-act decomposition (some class fires on a subregion and
  its placements are killed by the remainder) or a certified "no class in this
  vocabulary factors it" — either is a first-of-its-kind data point on whether
  pigeonhole × kill is necessary.

**D2 — The interface-menu formalism (phase 2, Shape A).** For copies X₁, X₂ with
interface I = V(X₁) ∩ V(X₂) (exact coordinates): the menu M(Xᵢ, I) = proper-5-colouring
restrictions to I, modulo palette (legitimate: all constraints are colour-symmetric);
the union is 5-colourable iff restrictions can agree, ONE SAT ask. The moments ladder,
cheapest first, each sound on its own: (m0) union SAT; (m1) forced-pair / forced-equal
/ virtual-edge meters ACROSS the interface (the standing k-generic rigidity engine —
these are the menu's pairwise moments); (m2) coverage moments on interface shells;
(m3) interface-colouring enumeration only if |I| and the count are small (blocking-
clause projection, cap 20,000); (m4) transfer RELATIONS (two-interface copies) only if
(m3) was affordable. A frustrated loop hunt runs only on relations that (m4) actually
delivered — no speculative automaton.

**D3 — Overlap arithmetic (phase 2 entry).** The 1581's exact coordinates (the
committed tables, `couple.py` 16-vector currency). Candidate transforms: translations
by 1, ζ₆-orbit, 1+ζ₆, 2, the spindle-centre separation and its ζ₆-orbit; rotations by
ζ₆ powers about each spindle centre. For each: |V ∩ T(V)| by exact key match —
zero-float identification; any near-miss that floats would merge is REPORTED, never
merged. Proceed with the top transforms by shared-vertex count; a transform sharing
< 5% of vertices is recorded and not SAT-probed (near-disjoint unions teach nothing).

**D4 — Gen-2 closure (phase 3, Shape B).** `closure.py`'s graded closure semantics
(one word-length generation at a time about the centre set) iterated once more from
the gen-1 state. SIZE FIRST with a hard point cap (2M points / 20 GB RSS — the laptop
has 31 GB; if the measurement itself wants more, it moves to the desktop and says so);
only then the k = 5 frontier in M31's committed-radius style, desktop. The registered
theory reason (depth-switch): the k = 4 pigeonhole fired only at seam depth 2; gen-2
is the first depth rung anyone will have probed at k = 5.

**D5 — Galois protocol (phase 4).** Flip maps applied coordinatewise (the generator
table in the stub above); per conjugate: (i) invariant screen — ring-spectra multisets
about the two conjugated spindle centres; a mismatch certifies non-congruence,
cheapest exit; (ii) if spectra match, attempt the explicit isometry: solve the rigid
motion from two anchor pairs, verify EVERY vertex maps into the set exactly (field
arithmetic); (iii) verdict per flip, 15 rows. Controls: the identity flip must
canonicalize to congruent; Heule-510's flips are predicted non-self-congruent (its 6
out-of-group residue classes are SAT scars with no arithmetic reason to survive
conjugation) — if the control comes back congruent, the canonicalizer is suspect and
the phase halts.

**D6 — The forced-equivariance query (phase 5, Shape C).** For isometry g with
g(R) = R setwise: assert `⋁_{x∈R} d_x` with clauses `d_x ∧ colour(x)=i → colour(gx)≠i`;
UNSAT ⟺ every proper k-colouring satisfies colour∘g = colour on R. Exactness: this is
necessary-and-sufficient for forced equivariance (G21 statement: the acceptance test
is exact). Control: the 791 forcer's antipodal map on the 2/√3 circle at k = 4 MUST
fire (M30's six forced pairs). Candidates at k = 5: antipodal maps about spindle
centres and rot6/reflections on named shells, on the M34 union and the best tiling.

## §0b — Instruments

New thin drivers over standing engines, all in `tools/` (UNTRUSTED, second-encoding
checks where a verdict is load-bearing): the autopsy driver (celllat cores + class-
avoidance at k = χ−1 + the LP verifier), the union builder (exact identification, the
M34 vertex-order lesson: certificates from the union's OWN numbering), the menu/moment
driver (rigidity meters pointed across interfaces), the equivariance query, the Galois
conjugator (couple.py currency). Artifact: `build/m41-gradient.json`, sections keyed
by phase; every SAT row carries machine + cap + outcome, `unknown` never a verdict.

## §0c — Registered predictions

* **P1 [high]** — the autopsy completes on all three cores within laptop budgets;
  [medium] the 23-core does NOT factor over the pair-class vocabulary (the forcing is
  holistic at 23 vertices). Either branch is the deliverable; a firing class names
  the finite lab's Act One and G15-universality gains its first out-of-plane support.
* **P2 [medium]** — χ_f(23-core) ≤ 6 (an integrality gap ≥ 1 carried by 23 vertices).
* **P3 [high]** — 2-copy tilings at max-overlap transforms are k = 5 SAT (m0);
  [medium] all m1 moments read zero (floppy interfaces — the flat branch, banked as
  the fifth globality measurement if it holds everywhere).
* **P4 [low-medium]** — some ≥ 3-copy arrangement shows a nonzero moment; ANY nonzero
  reading is the milestone's headline (the k = 5 first-gradient).
* **P5 [very low — the jackpot, verbatim from the stub]** — any k = 5 UNSAT on a
  union: halt; re-derive the edge list independently; verify every identification in
  field arithmetic; second encoding; report to Kooshi before interpretation. It would
  be χ(ℝ²) ≥ 6.
* **P6 [medium]** — gen-2 size lands in [100k, 2M] points; [medium-high] k = 5 stays
  SAT at every affordable frontier (a refusal is P5's clause).
* **P7 [split on purpose]** — Galois: the 1581's √11-flip conjugate is plane-congruent
  to the original [low-medium — the conjugate-paired ring spectra (G4) hint at it];
  the √5/√7 flips produce non-congruent free witnesses [medium]; the Heule-510
  control breaks [high — a congruent control halts the phase].
* **P8 [high]** — the 791 equivariance control fires at k = 4; [medium] nothing is
  forced-equivariant at k = 5 on today's objects (any firing = Shape C's Act One).

## §0f — Domain-modeling pass (2026-08-12, laptop, applied before any instrument; amendments sharpen, none weaken)

* **A1 — The menu's true carrier is PARTITIONS, and the union theorem is exact.** A
  palette class of interface labellings is a partition of I into ≤ 5 blocks, and the
  block-matching permutation always extends to S₅, so: *the 2-copy union is
  5-colourable iff the partition menus intersect* — exact, both directions. Instrument
  consequence: menu enumeration must canonicalize the palette BY FIRST OCCURRENCE ON
  THE INTERFACE (not on the copy's global vertex order), else each partition is
  enumerated up to 120 times.
* **A2 — The relation carrier is the JOINT partition, not a pair of partitions.** For
  a copy with interfaces I and J, cross-interface blocks (a 5-colouring forcing an
  I-point and a J-point equal) are exactly what loop frustration is made of, so the
  transfer object is Menu(X, I ∪ J) — partitions of the union — composed by
  amalgamation over the shared middle (the partition-monoid transfer, which is what
  M20's strip automaton was implicitly). Coherence note that falls out: the m1
  forced-equal/virtual-edge meters ARE the cross-block detectors — the moments ladder
  measures the relation's off-diagonal structure before any enumeration is paid for.
* **A3 — The autopsy verdict is a PARAMETRIC record, never an absolute.** Verdict =
  `Factored(R₀, P, placements, kill-certs)` with R₀ a PROPER, (χ−1)-colourable
  subregion (else the decomposition is the trivial one — the full core "fires"
  vacuously), or `Holistic(V, R)` — always RELATIVE to the stated vocabulary V and
  region lattice R. The M33 enumeration warning binds verbatim: fan compulsions live
  on circles about DELETED vertices, so V must include the A1-style fan classes
  (per core vertex v: is N(v) forced to cover k−1 colours in the core minus v?) or
  the `Holistic` verdict has a known blind spot.
* **A4 — The union boundary, parsed not validated.** Union vertices are canonical
  exact-coordinate keys minted once at construction; **edges are re-derived on the
  union's full vertex set from scratch** (all pairs at exact distance 1) — a union of
  the two copies' edge LISTS is an adversarial member: it satisfies "union" while
  missing every cross chord, which is the entire constraint content. Near-miss pairs
  (floats would merge, exact arithmetic distinguishes) are reported, never merged.
* **A5 — Equivariance wellposedness**: the query needs only {x, gx} ⊆ V per probed
  point (the 791's antipodal pairs are the model) — g need not be a symmetry of the
  object; state the domain as the orbit-pair list, not a set R with g(R) = R.
* **A6 — The other passes**: obligation-modeling SKIPPED (no Lean this milestone);
  experience-modeling SKIPPED (no consumer surface; artifact follows standing
  schemas). Reasons recorded per the workflow rule.

## §0g — The measured shape (overlap census run at subplanning, 2026-08-12, laptop — the workflow's measure-before-specifying clause; `tools/gradient.py --overlap`, self-tests green, artifact `build/m41-gradient.json`)

**The census verdict: the wholesale-overlap transforms are the hex rotations about the
witness's own origin pivot, and the witness is HALF-CRYSTAL.** Exactly **787** of the
1581 points are fully rot6-invariant about the origin (their whole hexagonal orbit
stays in the witness); the other ~794 break the symmetry — G5's "two systems" measured
a new way, and the detuned-oligomer signature (G25/Shape A) visible inside the single
witness. The rot180-stable core has **791** points — *exactly the vertex count of de
Grey's 791-point forcer*, whose six forced pairs are M30's forced central symmetry.

* **P9 [medium], registered on the spot**: the centrosymmetric core `V ∩ −V` about the
  origin IS the M13/M30 791-forcer (up to the construction↔committed frame map — the
  M34 numbering lesson applies to the check). If true, the forcer's forced central
  symmetry acquires a structural explanation: it is exactly the 180°-stable half of
  the witness, and the rot180 union probe below gets a theory reading. If false, the
  791 = 791 is numerology and gets said out loud.
* **P10 [reading, registered]**: the 787-point rot6-invariant core is (mostly) the
  origin spindle system's own fabric; the symmetry-breaking half is the second
  system's material. Checkable against the M30 ownership factorization (copy tags).

**The probe ladder, priced exactly** (union vertex counts; every one below the M34
union's 4,749, which solved at ~800 s/cube on the desktop):

| union | vertices | interface | note |
|---|---|---|---|
| V ∪ rot60°(V) | 2,373 | 789 | premier 2-copy probe |
| V ∪ rot180°(V) | 2,371 | 791 | the P9 object |
| V ∪ mirror(V) | 2,767 | 395 | chirality probe |
| V ∪ (V + 1) | 3,008 | 154 | translation probe (all six unit directions tie at 154 — measured isotropy) |
| ⋃ₖ rot6ᵏ(V) | 5,533 | 787-core shared six ways | the six-copy quaternary object — the hex closure of the witness about its own pivot |

Dropped by the < 5% rule (recorded, not probed): √3-translations (52 shared),
2-translations (31 — the spindle-centre separation shares almost nothing),
3-translations (4), rotations about the second centre (≤ 61).

**Why exact-crystal unions are NOT killed by G7** ("exact symmetry adds no colour
constraint"): G7's measured instance was a detuned DISJOINT copy reusing the base's
colouring. Here the copies SHARE the 787-core wholesale, so a colouring of V induces
nothing on rot6(V) unless it is already rot6-equivariant on the core — consistency
across shared vertices is exactly the constraint content. (M26's certified hexagram
colouring was rot6-equivariant BY CHOICE; whether 5-colourings of the witness can be
chosen equivariant on the core is precisely the D6/Shape-C question, and the six-copy
union is where it binds.)

**Menu feasibility (D2 ladder, decided by the interface sizes)**: full partition
enumeration (m3) is out at the 789/791-point interfaces and borderline at the
154-point one (cap 20,000 realized partitions, attempt on the translation union only);
the m1/m2 moments are the instruments of record for the rotational unions — exactly
what the ladder was designed for.

**Phase order, finalized**: 0 the autopsy (laptop-class) → 1 the union k = 5 anatomy
(M34 union, desktop) → 2 the ladder above, m0 then moments, cheapest union first
(desktop for refusal-side caps) → 3 gen-2 size-first (desktop) → 4 Galois
(laptop-class) → 5 equivariance (with the 791 control first; the P9 check folds in
here — same frame machinery).

## §0d — Failure clauses

* Any probe's flat verdict is banked at face value; the milestone lands on the
  autopsy + the moment table + the Galois verdict even if every gradient reads zero.
* Identification near-misses, canonicalizer surprises, catastrophe-class SATs
  (k ≤ 4 anywhere): HALT and report, per the standing rules.
* Solver walls: report the frontier + machine; heavy solves move to the desktop by
  name, never silently.
* Any segfault, any process: HALT and report to Kooshi (standing).
