# M32 — The first certified infinite 5-chromatic object
# (SUBPLANNED 2026-08-10 — committed scope: the designed-forcer probe phase +
# the 2-adic engine's first Lean ascent; certification-at-scale is gated by the
# §0c checkpoint and scopes to M33 if the probes come up flat. §0 below is the
# registered block; the stub sections are kept verbatim as context.)

*Written 2026-08-09 at the field-jump decision; consumes M31's object. Read
`plans/M30-degrey-anatomy.md` and `plans/M31-minimal-five-closure.md` first —
context accumulates through the three stubs and is not repeated here.*

## The M31 handoff (2026-08-10, written at M31's close)

* **The object is the 1581-witness closure** — M31's registered failure clause
  fired exactly as written: every smaller closure's SAT χ stayed 4, the gen-1
  enrichment did NOT enable a 5-chromatic chunk below the witness scale
  (enriched balls at 1200-committed radius, 16,365 vertices with all closure
  material, 4-colour in seconds), and the 5-mechanism is **irreducibly global
  at this order** — the structural finding, now measured three ways
  (near-edge-criticality M30, class-deletion SAT M30, enrichment frontier M31).
* **The quadrature law is the first kill lemma, and it is DERIVED and
  script-verified** (M31 §0a/§R): a detune R = s·W (s seam, W in the
  half-spindle generators) couples seam material only along s-twisted
  anchor-collinear pairs (W an even power: Re(W) ∈ ℚ) or anchor-perpendicular
  pairs (odd: Re(W) ∈ √d·ℚ) on the conic t² + r² − 2·Re(W)(±tr) = 1 resp.
  t² + r² + 2·Im(W)(±tr) = 1; words mixing √ρ₁₅- and √ρ₆₃-content couple
  NOWHERE. Kernel-certifying the ρ₁₅ instance is the natural first Lean
  theorem of this milestone (the M31 §0a deferral): the proof is the 16-basis
  block split — K = ℚ(√3,√11) vs √15·K vs √7·K vs √105·K — an
  ℚ-independence argument in the M24 `sqrt_indep` genre.
* **The measured coupling inventory to certify** (all law-pinned, all exact):
  the (2,2) spindle diagonal (the classical distance-2 chord), the (2/3, 2/3)
  perpendicular half-spindle diagonal, and the **conjugate-ring channel**
  t² = (17∓√33)/6, r² = (17±√33)/6, t·r = 8/3 — the clearing must handle
  ℚ(√33)-CONJUGATE radius pairs, not just rational radii. Conic constants
  7/4, 1/2, 31/16: denominators 4, 2, 16 — the 2-adic clearing measured at
  M30 (norms 4 and 16) shows up here as the conic's arithmetic.
* **The de Grey pair's exact seam coupling** (M31 probe B): 6 chords + the
  tangency fusion — the hex family and four seam-height-±1 chords through
  (1/√3)·σ̄ — is the smallest complete two-centre web one field up; its Lean
  classification is the M24-engine warm-up before the witness closure's webs.
* **The lower bound has a named shape now (G13, verified 2026-08-10)**: the
  5-transition at Heule-510's centre is a FAN — every proper 4-colouring of
  510 − v0 covers the centre's 36-point unit circle with all four colours
  (SAT-verified, UNSAT 10.1 s), while the centre's own system provably cannot
  self-confine (M18/M20 kernel theorems). So the geometric χ ≥ 5 argument's
  final step is exactly M18's `fan_iff_coverage` vocabulary one field up:
  prove the ambient detuned web forces coverage 4 on a centre's outer circle.
  The compulsion cascade should target THAT statement, and the coverage-order
  SAT query (restrict N(v) to k−1 colours — one call by palette symmetry) is
  the cheap instrument the pairwise rigidity sweep was structurally blind to:
  build it into `tools/rigidity.py` alongside the triple-query extension.

## The design fork (opened by Kooshi, 2026-08-10, the morning after M31's close —
## DECIDED same day: Kooshi approved the B-first hybrid ("Sounds good to me")
## and authorized the M32 run. M32's subplan takes Route B's probe phase as its
## opening block, Route A as the standing fallback whose engine work overlaps.)

Two routes to "the first certified infinite 5-chromatic object", and they differ
by an order of magnitude in certification surface:

* **Route A — certify the found object**: the 1581-witness closure. χ ≥ 5 is
  free (kernel-inherited). The cost is the upper bound: a colour table proper
  on EVERY chord family of a two-centre closure with 11,016+ rings, 67
  direction classes, and no global symmetry — the M24–M26 engine at ~50×
  its proven scale. The object is found, messy, and SAT-shrunk (scars).
* **Route B — design our own 5-forcer from the certified vocabulary**
  (Kooshi's gut: "something smaller and cleaner built from our own
  vocabulary — how small can we get by detuning something built on our
  hexagram?"): run the forced-pair pipeline INSIDE the hexagram fabric —
  build a gadget from hexagram material whose 4-colourings force a pair
  (equal at 2 or 4, the conic-friendly spindle distances), then close with
  ρ₁₅. Then certify THAT object, whose theory we own end-to-end: rot6
  symmetry, self-seeding, the quadrature law giving the complete cross-web,
  a small shell inventory. "Small" here means LEAST GEOMETRY (G10): fewest
  shells × smallest word set — NOT fewest vertices.
* **The measured constraints on Route B** (all from M30/M31, nothing new run):
  single detunes are thin by law (one conic of chords — can never force);
  the hexagram chunk is pairwise-floppy at 4 (M30 E4) so no spindle can
  start from it bare; every 5-forcer measured is a tapestry of coverage
  compulsions (G13) — the gadget's job is to CREATE a fan (coverage 4 on a
  circle) or a forced pair, from stacked/multi-anchor detunes. Benchmarks
  for scale expectations: Haugland's designed route on a heptagon fabric
  cost 740 vertices for ONE virtual edge at √3, 1066 for the forced-equal
  pair at 2, 2131 total; de Grey's forcer is 791 for six pairs; nothing
  measured suggests our fabric lands radically below ~10³ vertices — the
  win is CLEANNESS (description length, symmetry, certifiability), not
  vertex count.
* **Route B's opening probes, sketched for registration at subplan time
  (NOT run — the registration discipline binds)**: (1) the coverage-query
  instrument into `tools/rigidity.py` (one SAT call per vertex per k; the
  510 fan test cost 10–30 s at 509 vertices); (2) stacked mitosis — H ∪
  R·H ∪ R'·H for R, R' at the same/different anchors (incl. the chirality
  question: de Grey's graph contains ρ₁₅ but NOT ρ₁₅⁻¹ — mirror-stacking
  is unexplored); sweep cross-chord growth AND rigidity/coverage onset;
  cost ~minutes per variant at B ≤ 2 via `tools/closure.py`; (3) the
  virtual-edge hunt: which small fabric assemblies force a DISTINCT pair
  at any distance at k = 4 (Haugland's G₁ analogue — his was at √3);
  (4) register the fan-design question: what ambient material forces
  coverage 4 on one pivot's outer circle — G13's target, hunted forward.
* **Recommendation (de Bruijn, 2026-08-10): hybrid, B-first.** Open M32
  with Route B's probe phase (cheap, uses standing instruments, and its
  FAILURE is informative — if no small assembly forces anything, the
  irreducibly-global finding extends to designed objects and Route A is
  the only road). Fall back to Route A — whose engine work (the quadrature
  lemma, the pair web, the coverage instrument) is IDENTICAL through the
  first weeks, so nothing is lost by opening with B. Confidence: medium —
  the one fact that would flip it is a measured probe showing forced
  structure needs witness-scale assemblies even in our fabric, in which
  case go straight at Route A and treat B as closed.

## Fresh-session pointers (2026-08-10)

* Read order: this stub whole → `plans/M31-minimal-five-closure.md` §0a/§R
  (the law and every measured number) → `plans/M30-degrey-anatomy.md` §R.
* Instruments: `tools/closure.py` (mitosis/census/law-check/closure/χ —
  `--self-test` first, six controls), `tools/rigidity.py` (pairwise
  forced/virtual; the coverage query is DESIGNED, § above, unbuilt),
  `tools/anatomy.py`, `tools/hexchunk.py`. SAT costs (desktop): 509-vertex
  full pairwise sweep 6 s when floppy; single k=4 SAT at 1581-scale
  seconds; monolithic k=4 UNSAT > 80 min (kernel fact or cubes); 24k-vertex
  k=5 SAT ~1 s; fan query 10–30 s at 510-scale.
* Artifacts (UPDATE, never re-mint): closure explorer
  https://claude.ai/code/artifact/43da2efc-d00e-4e29-a786-64cee5a1b2d8,
  anatomy explorer
  https://claude.ai/code/artifact/b0333b53-c301-4873-824e-d04f69048be3,
  hexagram explorer
  https://claude.ai/code/artifact/6edcfda5-8b26-4e7e-b69e-5102a5e1056c.

## The target theorem

For the closure X chosen at M31 (countable, closed under the de Grey group,
containing a certified 5-forcer or the concentrated family bundle):

> `chromaticNumber_X = 5` (or whatever M31 measured), **unconditionally, on axioms
> exactly `[propext, Classical.choice, Quot.sound]`** — the first exact chromatic
> number of an infinite 5-chromatic unit-distance object anyone has.

The lower bound is expected cheap: if X contains the Heule-510 vertex set, χ ≥ 5
transports through a subset inclusion exactly the way M26's
`not_colorable_three_hexagram` transported M24's nine-point witness
(`hc.of_hom` through a set inclusion — the pattern is proven and mechanical).
The upper bound is the research: a colour table proper on EVERY chord family of X,
which requires the complete chord classification one field up.

## What the M24–M26 engine hands over, and where it breaks

* **The proof shape is identical**: per-web bridge → master identity → uniform
  clearing → parity split → finitely many kill lemmas → boundary decides against
  tables → per-family completeness ↔ table membership → fusion inventory → decode
  with read lemmas → properness by family pair → χ assembly. Every one of these
  stages has a worked, committed exemplar in `Hexagram.lean` (M26) with its
  session lessons recorded in the project memory (stale-olean trap, omega
  nonlinearity, ZMod-6 numeral congruences by `decide`, fin_cases on compound
  members, the classify-don't-refute shape lemma design).
* **The ring changes**: M24 cleared by √3-powers into ℤ[ζ₆, π] (π² = π − 3, norm
  3) and killed 3-adically. The new seams bring (1+i√15)/2 (x² = x − 4, norm 2²)
  and (1+i√63)/2 (x² = x − 16, norm 2⁴) — **2-adic structure, possibly with the
  two new seams sharing the prime 2**, which the old parity-split trick (one live
  class, three pins) may not survive unchanged. M31 must hand over the measured
  clearing behaviour; the subplan here designs the new kill lemmas against it,
  script-verified (the `build/m26-shapes.py` pattern: every decide, boundary row,
  reverse certificate and colour agreement verified by a planted-failure script
  BEFORE Lean states it — M26's ~40 decides passed first-or-second try because of
  this; treat it as mandatory).
* **Multi-generator words**: seam addresses go from (x : ZMod 6, b : ℤ) to
  (x, b₁, b₂, b₃)-shaped — the trace machinery (`hexTrace`, `gTr`/`uTr`,
  clearing at signed heights) needs a multi-height generalization. Expect this to
  be the largest single Lean work item; consider whether the M31 object can be
  chosen to use ONE new generator only (a closure inside ⟨ζ₆, σ, ρ₁₅⟩, say) to
  halve the first ascent — register that trade explicitly at subplan time.
* **k = 5 tables**: colour tables go from Fin 4 to Fin 5; the SAT probes and the
  equivariance story (is there a symmetry like rot6/τ? the de Grey group is not
  6-fold symmetric about one centre — expect less symmetry, bigger tables, more
  decides; measure before believing).

## The geometric-forcing route (Kooshi's direction, 2026-08-09: "formalize and
minimize the geometry behind the colourings rather than brute forcing them")

The lower bound χ ≥ 5 currently rests on the LRAT certificate — kernel-checked
but mechanism-free. The target worth the milestone: replace it with a
**compulsion cascade** in the M20 genre. The M30 measurements say where that
argument must live: pairwise rigidity is provably ZERO on the relevant objects
(the hexagram chunk at 4 colours: no forced pairs, settled exactly; the 1581
at 5: none either) — while de Grey's own informal argument is TRIPLE-shaped
(every 4-colouring of his hexagonal fabric H puts a monochromatic triple
somewhere; the twisted overlay kills each placement). So the geometric
lower bound lives at triple order or higher, exactly like M20's
`no_mono_outer_triple` (a compulsion acting through no edge) — the genre we
have already formalized once. Sketch: (1) compulsion theorems for the
seam-field fabric at 4 colours (what patterns are forced — triples, not
pairs); (2) the detuned overlay's interlock chords (the 2-adic web theorems)
contradicting every compelled pattern; (3) χ ≥ 5 with no SAT anywhere in the
artifact. SAT's role reduces to scouting (the M24–M26 division of labour:
census verifies design, kernel checks structure). "Minimize" then changes
meaning: not fewest vertices (Heule's 510 is a SAT-shrinking artifact with
out-of-group scars) but LEAST GEOMETRY — fewest rings × smallest angular word
set whose cascade closes. A minimal mechanism may have more vertices than 510
and be worth far more, and its countable closure is this milestone's object.
Instrument prerequisite (build at M31): extend `tools/rigidity.py` from pair
queries to triple/pattern queries — the pairwise instrument is structurally
blind to the compulsion level where the 5-forcing actually operates.

## Deliverables

* The Lean module (working name `Proofs/HadwigerNelson/FiveClosure.lean`), zero
  sorry, axioms-clean, full gate (build.sh, axioms.sh, lint, registered mutation
  audits — and note axioms.sh's 64 KB here-string fix is already in).
* The census promoted into `tools/couple.py` with planted-disagreement self-tests
  (the M26 `--hexagram-census` pattern).
* **The certified-object visualizer** (deliverable): the M31 explorer upgraded to
  the certified state — every chord generated from the PROVEN tables, the
  5-colouring rendered, the numeric completeness sweep — the
  `tools/hexagram-viz.html` architecture with a 5-colour palette. The visual
  standard: a reader should be able to SEE where the 5th colour lives.
* Frontier update: the ledger entry, and the paths-forward rewrite toward the
  6-hunt (every extension-pressure instrument from M21–M23 re-aimed at the
  certified 5-object: where the 6th colour cannot live is the new clamp).

## The stakes, stated at registration

* Landing at χ = 5 exactly: the first certified infinite 5-chromatic object — new
  mathematics, the write-up-policy trigger question goes to Kooshi.
* Landing at χ = 6 for some closure (M31's jackpot branch): χ(ℝ²) ≥ 6 territory —
  everything stops and the finite-core extraction goes through the M05/M06 kernel
  certificate pipeline, which is measured and waiting.
* NOT landing (the engine does not survive the 2-adic seams at affordable cost):
  report at face value, keep the SAT-measured χ as registered-but-uncertified
  knowledge, and rescope — the anatomy and closure results (M30–M31) stand on
  their own regardless.

---

# §0 — The M32 subplan (registered 2026-08-10, committed BEFORE any instrument runs)

*Discipline as at M31: everything below is written and committed before any new
instrument executes. §0a is pure a-priori derivation (paper arithmetic — no code
was run to produce it); its consequences are predictions the census then tests.
Where a §0a claim fails in the census, the derivation is wrong and the failure
is reported at face value.*

## Scope, refined at subplan time (WORKFLOW step 3 authority)

**The committed scope of M32 is two blocks**: (1) the Route-B probe phase — the
designed-forcer hunt inside our own fabric, with the compulsion meters built
first; (2) the 2-adic engine's first Lean ascent — the three-prime independence
lemma, the quadrature kill lemma, and the distance-2 seam pair web, which serve
Route A and Route B identically. **Certification of a witness-scale object is
NOT committed inside M32**: the §0c checkpoint decides M33's object. If a probe
lands a small designed forcer, its certification becomes M32's continuation
with the engine warm; if the probes come up flat, M33 = Route A on the
1581-witness closure and its stub receives the complete handoff. Reason: Route
A at ~50× M26 scale is multi-milestone work under any outcome; committing it
inside M32 would guarantee a rescope, and the workflow prefers the honest split
now. (Alternative weighed: keep the stub's full target inside one milestone —
rejected because every measured number says the upper-bound work at 24k points
/ 123k chords dwarfs M24+M25+M26 combined.)

**The one-generator trade, registered as the stub demanded**: probes and engine
work in the SINGLE new family — words in √ρ₁₅ with seam decorations, i.e. the
group ⟨ζ₆, ζ₁₂, σ, √ρ₁₅⟩ — and ρ₆₃ enters only if a design needs the
distance-4 spindle. Reasons: (a) M31 measured ρ₆₃/√ρ₆₃ STERILE at chunk scale
(their conic diagonals (4,4) and 32+12√7 sit beyond the chunk's radial reach
≈ 2.16); (b) the Lean first ascent then adjoins only √5 (the 8-dim basis
{1,√3,√5,√11,√15,√33,√55,√165}) rather than √5 and √7 (16-dim); (c) the
question "can ρ₁₅-family words alone force?" is itself structural — de Grey
needed both families; one-family forcing would be the cleanness win, and
one-family saturation below forcing would be evidence both families are
necessary. Either outcome is a finding.

## §0a — The stacking law (a-priori derivation; the copy↔copy analogue of M31's law)

Setting as M31 §0a: seam material has both components in K = ℚ(√3,√11); a
detune is R = s·W (s a seam decoration, |s| = 1, components in K; W a word in
√ρ₁₅ = (√15+i)/4 this milestone — even exponent = full spindle, Re(W) ∈ ℚ,
Im(W) ∈ √15·ℚ; odd = half spindle, reversed). A **stack** is
H ∪ R₁·H ∪ R₂·H ∪ … with R_i acting about anchors a_i. M31's law governs every
copy↔base pair. The new object is the **copy↔copy** coupling, and the anchors
decide its width:

**1. Same anchor (a₁ = a₂).** Both rotations fix the anchor, so the pair
(R₁H, R₂H) is isometric to (H, R₁⁻¹R₂·H): copy↔copy is the SINGLE-WORD law at
the relative word — same-anchor stacks never escape thinness, however many
copies. Registered instances:
  * **Chirality pair** (R = ρ₁₅, R′ = ρ₁₅⁻¹): relative word ρ₁₅⁻², even,
    2·Re(ρ₁₅²) = 17/16 (ρ₁₅² = (17+7i√15)/32). Conic t² + r² − (17/16)(±tr)
    = 1. Diagonal t = r → t² = 16/15: denominator 15, outside the {2,3}-smooth
    seam vocabulary — EMPTY. The (t²=1, r=17/16) solution needs a ring at
    289/256, not in the chunk inventory as far as we know. **Registered: the
    chirality pair's copy↔copy channel carries ZERO chords at B ≤ 2**
    (confidence 70%; a hit names its ring and is a find, not a bug).
  * (ρ₁₅, √ρ₁₅) same anchor: relative word √ρ₁₅⁻¹ (odd) — the same
    perpendicular conic t² + r² ± tr/2 = 1 as base↔half-copy; expect counts
    of the measured order (≤ 12).

**2. Different anchors, same word, same decoration (a₁ ≠ a₂, R₁ = R₂ = sW).**
The channel WIDENS — this is the milestone's registered mechanism claim. With
u = x − a₁, v = y − a₂ (seam offsets) and A = a₁ − a₂ (a K-vector), the two
copy points differ by p₁ − p₂ = A + sW·(u − v): the word factors onto the
DIFFERENCE w = u − v. Writing ζ = s·w·Ā = ξ + iη (ξ, η ∈ K) and splitting
|A + sWw|² = 1 over the radical blocks, an even word W = q + i√15·q′ gives:
  * √15-block: **η = Im(s·w·Ā) = 0** — the difference vector w is collinear
    with the s̄-twisted anchor axis (a pin on PAIRS, not on points);
  * K-block: |w|² ± 2q|A|·|w| + (|A|² − 1) = 0 — a quadratic fixing |w| to at
    most two admissible lengths per ray sign.
  Consequences, each falsifiable at the census:
  * **The translation matching at unit anchor separation**: w = 0 is a root
    iff |A| = 1, and then EVERY pair with u = v gives a unit chord — the two
    copies are unit translates of one rotated lattice, coupled by a perfect
    matching of size |H ∩ (H + A)| = O(n). Our fabric provides unit anchor
    pairs natively: the M23 triangle's pivots (0, 1, ζ₆ — second neighbours
    in the hexagram hexagon) are pairwise at distance 1. **This is the
    arithmetic reason de Grey's construction has two spindle centres: one
    anchor is thin by law; two anchors at a tuned separation buy O(n)
    coupling.** Registered: the (pivot 0, pivot 1) ρ₁₅ stack's copy↔copy
    census reads 100–800 chords at B ≤ 2 (vs ≤ 12 for every same-anchor
    variant), dominated by the exact translation matching.
  * **The second root at |A| = 1**: |w| = 2q = 7/4 for W = ρ₁₅ (|w|² = 49/16,
    2-smooth) — a second, thinner family beyond the matching, present only if
    the lattice realizes collinear differences at length 7/4. Registered as
    present-or-absent-honestly (no confidence assigned; the census answers).
  * **The sterile separation 1/√3**: for anchors pivot↔metapivot
    (|A|² = 1/3) and W = ρ₁₅, the quadratic's roots have |w|² ∉ K (the
    discriminant carries √59: |w| = ∓7/(8√3) + √59/8 → |w|² picks up
    √177-content). **Registered: the pivot↔meta ρ₁₅ same-word stack couples
    copy↔copy NOWHERE** — an a-priori emptiness the census must reproduce
    (confidence 85%; a violation falsifies the §0a block arithmetic itself).
  * **The conjugate channel at 2/√3**: for opposite-pivot anchors
    (|A|² = 4/3), the admissible lengths are |w|² = (41 ± 7√33)/24 — a
    ℚ(√33)-CONJUGATE PAIR, echoing M31's conjugate-ring channel. Whether the
    lattice realizes them is open: registered band 0–200 chords.

**3. Different anchors, different words.** The general pair
p₁ − p₂ = A + s₁W₁u − s₂W₂v carries THREE word-bearing terms (words W₁, W₂,
W₁W̄₂ on the K-vectors s₁uĀ, s₂vĀ, s₁s̄₂uv̄), and the block split yields a
2-equation system in the 4 lattice parameters (u, v) that does NOT factor
through per-point pins — a codim-2 pair-variety, generically far richer than
the same-anchor conic. Special structure: for W₁ = W₂ (case 2) the system
degenerates to the matching analysis above; for W₁, W₂ of opposite parity the
blocks mix Re- and Im-parts of all three terms. No point predictions are
registered for the general case beyond: every found chord must satisfy the
exact per-block vanishing of its own decomposition (the instrument recomputes
it at find time — the P1-style tripwire, generalized), and mixed-FAMILY words
remain sterile in the z₃ term exactly as in M31's law.

*Verification protocol: every copy↔copy chord found by any census is checked
at find time against its class's necessary condition — case 1 via the
single-word law at the relative word; case 2 via the difference-pin
(collinearity + admissible length, both exact); case 3 via the general
block-split recompute. A violation aborts loudly naming this section. The
self-test plants a translation-matching chord (must be found) and a
pin-violating fake (must be caught).*

## §0b — Numbered predictions (falsifiable, with confidence)

* **Q1 (instrument validation)**: the coverage meter reproduces the verified
  510−v0 fan (UNSAT at the 36-point circle, k = 4) and the v139 fan; its
  vacuity guard fires when the base graph is not k-colourable at all; the
  triple meter reproduces M20's compulsion on a finite two-circle chunk
  containing a witness triangle (mono-query UNSAT at k = 3) and goes SAT when
  the witness triangle is removed. Confidence: very high (mostly re-runs of
  verified queries through the new path).
* **Q2 (base rates — the bare fabric's compulsion floor at k = 4)**: on the
  hexagram chunk (B ≤ 2): (a) no pivot is fanned and full-cover-set min-cover
  is exactly 3 — LOGICAL consequences of M26's kernel χ = 4 plus the rainbow
  floor (the inner circle's rot3 partition into unit triangles forces ≥ 3);
  recorded as sanity checks, not findings. The genuine measurements: (b) the
  OUTER-circle-only min-cover per pivot — registered prediction 3 (the
  ambient seam web forces a third colour on the outer circle alone;
  confidence 55%, genuinely open — a reading of 2 means the outer circles
  retain 2-colour slack in full ambient, a real discovery about where
  coverage pressure does NOT live); (c) NO outer 120°-triple is compelled
  non-mono at k = 4 in the bare chunk (confidence 65% — the > 10⁴-colouring
  floppiness argues slack; a compulsion found in the BARE fabric would be
  M20's genre surviving one colour higher and would reshape the design
  thread immediately).
* **Q3 (same-anchor stacks stay thin)**: every same-anchor copy↔copy census
  obeys the relative-word single law (very high); the chirality pair reads 0
  copy↔copy chords at B ≤ 2 (70%); ALL same-anchor stacks probed (≤ 3
  copies) read χ = 4 (85%).
* **Q4 (the wide channel)**: the unit-separation same-word ρ₁₅ stack (anchors
  = two triangle pivots) carries 100–800 copy↔copy chords at B ≤ 2,
  dominated by the exact translation matching (85% — the matching is
  arithmetic; the band is the uncertainty); the pivot↔meta ρ₁₅ stack carries
  ZERO copy↔copy chords (85% — §0a's √59 emptiness); the opposite-pivot
  stack's conjugate-pair lengths (41±7√33)/24 carry 0–200 (band, no point
  estimate). χ of every wide stack: 4 (75%). Falsifier of the χ claims = the
  jackpot; escalation protocol below.
* **Q5 (the design meters on stacks — the milestone's live question)**: does
  any probed stack show (a) a forced pair — predict NO (70%); (b) a compelled
  120°-triple (mono-query UNSAT at k = 4) — genuinely open, registered 40%
  that SOME stack compels one; (c) a coverage rise — some target circle's
  min-cover strictly above its bare-fabric base rate — registered 35%; a
  full fan (min-cover 4) — predict NO (85%). ANY positive is the design
  gradient: the checkpoint's movement branch fires.
* **Q6 (the Lean ascent lands)**: `sqrt_indep₈` — ℚ-independence of
  {1,√3,√5,√11,√15,√33,√55,√165} — lands by the M24 descent plus a
  √5 ∉ ℚ(√3,√11) bridging lemma (90%); the quadrature kill lemma
  `quadrature_rho15` — for K-coordinate u, v: |ρ₁₅·u − v|² = 1 →
  Im(u·v̄) = 0 ∧ |u|² + |v|² − (7/4)·Re(u·v̄) = 1 — lands on the block
  lemma K ∩ √15·K = 0 (85%); the distance-2 seam pair web — the M31-measured
  6 chords + midpoint fusion as a completeness theorem via the axis-general
  M24 engine at constant 2 (75%; the risk is sporadic-table size, not
  method). Every statement script-verified in `build/m32-design.py` BEFORE
  Lean states it (the M26 discipline, mandatory).
* **Q7 (the verdict)**: the probe phase does NOT produce a sub-1,000-vertex
  designed 5-forcer (85%); M33's default object is the 1581-witness closure
  (Route A) with the engine warm. Falsifiers: the jackpot, or a compulsion
  gradient that iterating design inside M32 climbs to forcing.
* **Q8 (cost honesty)**: the probe phase completes in ≤ 2 desktop-days of
  background compute; χ probes capped 300 s, meter queries 600 s, pairwise
  sweeps ≤ 30 min per stack (run complete only on the three most-coupled
  stacks); one heavy job at a time; `unknown ≥ cap` is never a χ bound.

**Escalation protocol (registered, fires only on a k = 4 refusal)**: (1)
independent re-encode (the M21 pin-injection style or a second seed) must
reproduce UNSAT; (2) cube-split certified UNSAT; (3) only then is the object
called 5-chromatic, and the finite core goes to the M05/M06 kernel-certificate
pipeline. Everything else stops while this runs.

## §0c — Scope ladder (committed order; a timeout leaves a coherent prefix)

1. **Instruments**: the coverage + triple meters into `tools/rigidity.py`
   (palette-WLOG single SAT calls; vacuity guards; three-outcome honesty);
   stack support into `tools/closure.py` (n-copy unions, per-pair
   relative-class routing, the §0a certificate checks). Controls red/green
   before any verdict (Q1).
2. **Probe A — base rates**: the bare hexagram chunk's meters (Q2).
3. **Probe B — same-anchor stacks**: thin controls + the chirality pair (Q3).
4. **Probe C — different-anchor stacks**: the wide channel — the de Grey
   mimic at unit anchor pairs, the sterile 1/√3 control, the conjugate
   channel at 2/√3 — with all meters on the coupled results (Q4, Q5).
5. **CHECKPOINT (registered decision rule)**: **jackpot** (a stack refuses
   k = 4 and survives escalation) → M32's object is that stack, everything
   else yields; **movement** (any Q5 meter positive) → at most TWO registered
   iteration rounds of ≤ 12 design variants each, chosen by the gradient,
   same caps, then re-checkpoint; **flat** → the probe phase closes honestly,
   M33 = Route A, and the finding "designed one-family stacks at ≤ 2,400
   vertices carry no compulsion" joins the irreducibly-global ledger line.
6. **The Lean ascent** (runs regardless of the checkpoint — it serves both
   routes): `build/m32-design.py` script-verifies every statement → skeleton
   `Proofs/HadwigerNelson/Quadrature.lean` → `sqrt_indep₈` → the block lemma
   → `quadrature_rho15` → the distance-2 pair web (working module name
   `PairWeb.lean`; may fold into Quadrature.lean at the domain pass's
   discretion). Design-script iteration may interleave with probe background
   waits; full builds only via `./scripts/build.sh` and only when no probe
   is running.
7. **Visualizer**: the stack view + meters into the closure explorer (same
   URL, never re-mint).
8. **Close**: quality gate, Frontier + Grokkings, the M33 stub (object per
   checkpoint), the report.

**Modeling passes** (fresh Skill invocations, each committed): domain →
obligation → experience — the centre of gravity is the engine and the probes,
not the consumer surface. Obligation-modeling is IN scope this milestone
(unlike M30/M31): the ascent's three theorems are real proof obligations.

## §1 — Instruments (the shapes, before implementation)

**`tools/rigidity.py` extensions** (the meters; every query palette-WLOG'd to
one SAT call, three-outcome honest):

* `--coverage`: for graph G, target set S (a vertex's neighbourhood, or an
  explicit circle-point list), level j at colours k: SAT("proper k-colouring
  with S restricted to colours {0..j−1}") — palette symmetry makes the
  restriction WLOG. min-cover(S) = least SAT j; fan ⟺ min-cover = k ⟺ the
  j = k−1 query is UNSAT. Vacuity guard: G must be k-colourable first, else
  the banner says so and no fan claim is emitted.
* `--triple x y z --mode mono|rainbow`: mono pins all three to colour 0
  (WLOG); rainbow pins them to 0,1,2 (WLOG). UNSAT at mono = compelled
  non-mono (M20's genre); UNSAT at rainbow = compelled non-rainbow.
* Both meters emit `{query, outcome ∈ sat|unsat|unknown, seconds, cap}` rows
  into the JSON artifact; `unknown` is never worded as a bound.

**`tools/closure.py` extensions**:

* `stack(base, [(anchor_i, det_i), …])` → union with per-copy provenance
  (0 = base), exact dedup, fusion record, per-copy isometry control
  (intra-copy edge count = intra-base).
* Per-PAIR census with relative-class routing: same-anchor pairs → the
  single-word law at the relative word (M31 `law_check`); same-word
  different-anchor pairs → the difference-pin certificate (collinearity of
  u − v with the twisted axis + admissible |w|², both exact); general pairs →
  the block-split recompute. Violation aborts naming §0a. Anchor-incident
  readings stay a separate class (the M31 lesson).
* Self-test additions: planted translation-matching chord found; planted
  difference-pin violation caught; the chirality-empty and 1/√3-empty
  controls run as censuses whose ZERO is asserted (absence as a checked
  result, not an omission).

**Probe grids** (sizes: B ≤ 2 chunk ≈ 700–800 points; stacks of 2–3 copies ≈
1,500–2,400 points — squarely the Haugland-G₁ band):

* A: bare chunk, meters on all 7 pivot outer circles + ~20 sampled outer
  120°-triples.
* B: same-anchor at metapivot and at pivot 0: {(ρ₁₅, ρ₁₅⁻¹), (ρ₁₅, √ρ₁₅),
  (ρ₁₅, ζ₁₂ρ₁₅)} — census + χ + meters on the most-coupled.
* C: different-anchor same-word: (pivot 0, pivot 1)·ρ₁₅ [unit separation —
  the wide channel], (pivot 0, meta)·ρ₁₅ [the sterile control], opposite
  pivots·ρ₁₅ [the conjugate channel], plus one half-spindle variant
  (pivot 0, pivot 1)·√ρ₁₅ and one three-copy de Grey mimic
  (base + ρ₁₅ about pivot 0 + ρ₁₅ about pivot 1). Census + χ + all meters.

**The Lean skeleton statements** (the .lean file lands immediately after the
domain pass settles the coordinate representation — the one open shape
question; every statement is script-verified first):

```
theorem sqrt_indep₈ {e₁ e₃ e₅ e₁₁ e₁₅ e₃₃ e₅₅ e₁₆₅ : ℚ}
    (h : (e₁:ℝ) + e₃*√3 + e₅*√5 + e₁₁*√11 + e₁₅*√15 + e₃₃*√33
         + e₅₅*√55 + e₁₆₅*√165 = 0) :
    e₁ = 0 ∧ e₃ = 0 ∧ e₅ = 0 ∧ e₁₁ = 0 ∧ e₁₅ = 0 ∧ e₃₃ = 0 ∧ e₅₅ = 0 ∧ e₁₆₅ = 0
-- proof shape: regroup as (A) + (B)·√5 with A, B ∈ span{1,√3,√11,√33};
-- bridging lemma √5 ∉ ℚ(√3,√11) by the M24 sqrt_indep + squaring casework;
-- then the 4-dim sqrt_indep twice.

theorem quadrature_rho15 (u v : K-complex, coordinates as ℚ-4-vectors) :
    normSq (ρ₁₅ * u - v) = 1 →
    Im (u * conj v) = 0 ∧ normSq u + normSq v - (7/4) * Re (u * conj v) = 1
-- the kill lemma: the √15-block of the chord equation vanishes alone
-- (K ∩ √15·K = 0, a corollary of sqrt_indep₈); the K-block is the conic.
-- Seam decorations fold in as z = s·u·v̄ without changing the statement's shape.

-- The distance-2 pair web (M31-measured: 6 chords + the midpoint fusion):
-- pair2_oo_complete / pair2_oi_complete / pair2_ii_complete / pair2_fusion,
-- the M24 axis-general engine at constant 2 — exact statements fixed by
-- build/m32-design.py before Lean states them.
```

**JSON contract** (M33 reads these names): `object`, `stack [{anchor, detune
{s,a,b,class}}]`, `counts`, `pairwise [{i, j, relative_class, cross_chords
[{pin, certificate}], law}]`, `chi [{k, outcome, seconds, cap}]`, `meters
{forced_pairs, triples [...], coverage [{target, min_cover, rows [...]}]}`,
`controls` — controls travel IN the artifact.

## §0d — Domain pass (2026-08-10, decisions before implementation)

* **Detunes form a group; the pair class is the spec quotient.** A stack is a
  LIST of copies, copy = (anchor, detune spec); the base is copy 0 with the
  identity spec (M31's `make_detune()` already produces it). The copy-pair
  class is a total function computed by quotienting specs —
  `make_detune(s̄ᵢ·sⱼ, aⱼ−aᵢ, bⱼ−bᵢ)` — exactly as M31 made the quadrature
  class total in (a, b) parities. Three intrinsic classes: `same_anchor`
  (→ M31's single-word law at the relative spec; base↔copy is this case),
  `translation` (identical R, different anchors — the §0a difference-pin
  law; the relative isometry is a translation), `general` (different words
  or different decorations at different anchors — the composed rotation
  centre picks up new-field or divided coordinates, so no K-offset law
  applies). `mitosis` stays as the 2-copy wrapper.
* **The general class is recorded-only, and saying so is the rigor.** For a
  chord already confirmed exactly unit, "each 16-basis block of the exact
  equation vanishes" is TRIVIALLY true (independence of the basis) — a
  per-block recheck would be fake rigor. The structured, falsifiable claims
  live exactly in the two lawful classes (specific geometric quantities
  vanish: Im(s·u·v̄) = 0, resp. the difference pin); the general class
  records its relative spec and block decomposition as M33 design data,
  checked only for exact unitness. Census paths: `law-checked` /
  `difference-checked` / `recorded`.
* **Certificates compute on PREIMAGE offsets** (u = x_src − aᵢ, always in K
  by construction — the premise guard never fires on stack-internal pairs),
  and a fused point contributes one reading per provenance pair: the census
  iterates (tag, src)-pairs, not point pairs. Anchor-incident readings stay
  a separate class (the M31 lesson, carried).
* **The meter's vacuity guard is structural and free**: the min-cover
  ladder's top row j = k IS the unrestricted colourability check — no fan or
  compulsion claim is emitted unless that row reads `sat`. min-cover is
  monotone in j, and unknown rows widen it to an honest interval [lo, hi].
  Palette-WLOG soundness lives in ownership: the meter builds its clause set
  itself from (n, edges, k) — no API accepts foreign (possibly
  symmetry-broken) clauses.
* **Lean representation: explicit ℚ-coefficients, the M24 interface.** The
  consumers of the kill lemma hold cleared explicit coefficients, never
  membership proofs — so no Subfield/IntermediateField machinery. Three
  statements in `Proofs/HadwigerNelson/Quadrature.lean`: `sqrt_indep₈`
  (8 explicit ℚ-coefficients — the primitive; proof = regroup as
  (A) + √5·(B) over the 4-basis + a bridging lemma √5 ∉ ℚ(√3,√11) + M24's
  `sqrt_indep` twice), `sqrt15_block` (the (A) + √15·(B) = 0 regrouping with
  2×4 coefficients — the workhorse M33 cites), `quadrature_rho15` (the
  geometric instance over 16-coordinate points — the Frontier-citable spec
  witness, proven from the block lemma; non-vacuity example u = v = 2, the
  (2,2) spindle chord: 4 + 4 − 7 = 1). **Documentation-first gate: Loogle/
  LeanSearch for a Mathlib linear-independence-of-√squarefree lemma BEFORE
  hand-rolling sqrt_indep₈** — three claims of absence have been wrong here.
* **PairWeb.lean never edits Ladder.lean** (the rebuild cascade reaches
  MetaLadder and Hexagram): it imports Ladder for `sqrt_indep` and any
  genuinely general trace machinery, and states its own masters at axis
  constant 2. The address space (x : ZMod 6, b : ℤ) and the ℤ[ζ₆,π]
  clearing carry unchanged; only master constants and tables change, and
  `build/m32-design.py` re-derives every table before Lean states it.
* **Probe targets are exact-membership sets, no new address machinery**: a
  target circle is {i : nsq(pts[i] − c) = 1} computed exactly; a 120°-triple
  is an exact rot3-orbit membership test about its pivot.

## §0e — Obligation pass (2026-08-10, proof spines before implementation)

* **The registered bridging route hides a division wall, and the better spine
  dodges it.** Expressing √5 = −C/D in explicit coefficients needs field
  inversion in ℚ(√3,√11) (a conjugate-product norm block, ~70 lines the
  registration did not see). Superseded by LESS machinery: the primitive is
  **`sqrt5_split`** — (a₀+a₁√3+a₂√11+a₃√33) + √5·(b₀+b₁√3+b₂√11+b₃√33) = 0 →
  all eight coefficients zero — proven division-free: square to A² = 5B²
  (real arithmetic), expand through M24's existing `sqrt_indep` (the ONLY
  4-dim oracle needed — splitting √5 off with inner field ℚ(√3,√11) reuses
  it verbatim, which is why √5 and not √11 is the split prime), yielding four
  quadratic equations E0–E3 in eight rationals; kill by **mod-5 descent**:
  the system mod 5 has only the trivial solution — ONE `decide` over
  (ZMod 5)⁴, 625 tuples, the house mod-p congruence style — so an integer
  solution is divisible by 5 componentwise (a,b,c,d first, then p,q,r,s via
  the shifted system), and strong induction on the ℓ¹-norm closes; the
  ℚ-statement clears denominators once (E0–E3 are homogeneous of equal
  degree on both sides, so scaling is free). This spine generalizes to
  M33's √7 by a numeral change (mod-7 decide, 2401 tuples); the casework
  route would explode there. `sqrt15_block` (the citable kill: √15·K-part =
  √5·(√3-recombined K-part), rational recombination √15√3 = 3√5 etc.) and
  `sqrt_indep₈` (the Frontier-stated completeness) are corollaries.
  **Fallback registered**: if the design script finds the mod-5 system
  NON-trivial (625-loop check runs before Lean), the norm-inversion +
  5-case-bridging route stands (kills at rational squares {5,11,15,55,165},
  all no_rat_sq-style).
* **quadrature_rho15 is a have-chain, never a swamp.** Named intermediates:
  ξ = Re(u·v̄), η = Im(u·v̄) as real expressions; h1: normSq u + normSq v −
  (7/4)ξ + (√15/4)η = 1 by linear_combination from the chord hypothesis
  (ring-level, no coefficients yet); then the coefficient expansions of
  ξ, η, normSq u, normSq v as explicit 4-tuples (quadratic ℚ-polynomials in
  the 16 inputs, each closed by ring after the product identities); then ONE
  `sqrt5_split` application kills η's four coefficients and hands the K-block
  as the conic conjunct. No nlinarith anywhere. Non-vacuity example
  u = v = 2 (the (2,2) spindle chord: 4 + 4 − 7 = 1) as an `example`;
  wrong-constant refusal (7/8 in place of 7/4 → 12.5 ≠ 1 by norm_num) as a
  negative example.
* **The pair web owes the script everything first.** M31's 6-chord census
  was at TRUNCATION |b| ≤ 2; the Lean theorems quantify over all heights, so
  the completeness needs the M24 engine's infinite-part kills, and
  `build/m32-design.py` must deliver, per family (oo/oi/ii at axis
  constant 2): the master identity, the full symbolic clearing (sympy), the
  parity classes, the mod-3 kill residues — note 4 ≡ 1 (mod 3), so the
  axis-2 cleared constants may land on M24's residue landscape verbatim (the
  script confirms or refutes) — the telescope's survival, the sporadic
  inventory (must reproduce the 6 measured chords and the empty families),
  the fusion inventory at norm-0 constant (must be exactly the midpoint
  tangency), and decide-ready boundary tables. **Scope pinned: the pair web
  is CLASSIFICATION ONLY** — no χ theorem for the distance-2 pair is
  committed (it is the engine warm-up, not a chromatic object).
* **Prove/test/assume partition**: PROVE sqrt5_split (descent core + ZMod-5
  decide), sqrt15_block, sqrt_indep₈, quadrature_rho15, pair2_*_complete +
  pair2_fusion. TEST the (2,2) example, the recombination identities on
  numerals, each of the six pair chords as a positive `example`, one
  non-chord refusal. ASSUME nothing beyond ℚ/ℝ arithmetic.
* **Mutation audits (registered)**: plant 4 in place of 5 in the descent —
  the mod-2 analogue system HAS the nontrivial solution (A,B) = (2,1), so
  the script must show the discriminating check failing on the square;
  perturb the conic constant — the example breaks; drop the chord
  hypothesis — the conclusion is unprovable; every decide table row
  script-verified with a planted wrong row first (M26 discipline).
* **Axiom expectations**: plain `decide` (kernel) throughout — every public
  theorem lands on exactly [propext, Classical.choice, Quot.sound].
* **Burn-down order** (strictly descending): skeleton with sorries → irr
  leaf lemmas (decide) → the ZMod-5 decide lemma → the ℤ-descent → the
  ℚ-clearing → sqrt5_split → corollaries → quadrature_rho15 → PairWeb
  skeleton → masters → kills → tables → completeness assembly.

## §0f — Experience pass (2026-08-10, surfaces before implementation)

* **The Lean lemma API is named for its consumers, not its construction**:
  `sqrt5_indep` (the primitive, hypothesis-last with implicit ℚ-coefficients
  — the exact shape of M24's `sqrt_indep`, so M33's reflexes carry),
  `sqrt15_split` (the workhorse the 2-adic clearings cite: (A) + √15·(B) = 0
  → both coefficient blocks vanish), `sqrt_indep₈` (the flat 8-term
  completeness, greps beside `sqrt_indep`). Conclusion conjunctions mirror
  term order; NO simp tagging (surgical kills, not rewrites); docstrings
  carry the block picture in one line each plus the pointer "the √7 analogue
  is a numeral change". PairWeb family lemmas are `pair2_oo_complete` etc. —
  M24's genre names with the axis constant visible, iff-shaped completeness.
* **Explorer (same URL)**: stacks selected by product-term names ("ρ₁₅ about
  pivot 0 + ρ₁₅ about pivot 1 — unit anchors, the wide channel"); copy-pair
  chords coloured by class with class-true hovers; the translation matching
  rendered AS a matching (parallel bundle) with an honest cap — "showing 60
  of N", the badge carrying the true count; the meter panel as dials
  (min-cover j of 4; 4 = fan = the design goal highlighted), compulsions
  flagged on their triples and listed even when the list is empty; sterile
  controls listed with their §0a reason ("would need √59"); the checkpoint
  verdict as a banner.
* **CLI wording (the M31 rules carried, extended)**: `--coverage` banners —
  FANNED only when j = k−1 reads unsat AND j = k reads sat; "VACUOUS: the
  graph itself refuses k colours — no coverage claim follows" when the free
  guard fires; `unknown` never worded as a bound or a fan. `--triple` —
  "COMPELLED non-mono at k (M20's genre)" on unsat, "moot: a colouring
  realizes it" on sat. `--stack` failure paths — a difference-pin violation
  names §0a case 2 and the Q-prediction and halts; recorded-only chords
  print `[recorded]` and never wear a law badge; every empty census prints
  its class's reason. Self-test shows every control red on cue, then green.
* **JSON contract (M33 reads these names)**: top-level `checkpoint {verdict ∈
  jackpot|movement|flat, reason, follow_ups}`; `pairwise [{i, j, anchors,
  relative {s,a,b,class}, census {cross, anchor_incident, matching},
  chords [{pi, pj, certificate {kind ∈ relative-law|difference-pin|recorded,
  …}}]}]`; meters with base-and-stack side by side per target
  (`{target, base_min_cover, stack_min_cover, rows}`) so the delta is the
  product term; controls in-artifact. Baseline meters also standalone in
  `build/m32-base.json`.
* **Instrument layering**: the meters are plain importable functions in
  `rigidity.py` (`coverage_query`, `triple_query`); `closure.py`'s stack
  driver imports them — no shelling out, one clause-construction owner.
* **The closing report** follows the house format with every P/Q verdict at
  face value and the checkpoint decision in four parts.

## Failure clauses (registered)

* **Probes flat + ascent lands**: M32 closes as "the stacking law + the
  compulsion map + the 2-adic engine's first theorems; no designed forcer at
  probe scale" — a complete, honest milestone; M33 = Route A.
* **The ascent stalls** (sqrt_indep₈'s casework explodes or the pair web's
  sporadic tables defeat the axis-general engine at affordable cost): report
  at face value with the measured cost, land what stands, and the M33 stub
  records the wall's exact shape.
* **Jackpot**: the escalation protocol above; nothing is claimed without the
  independent re-encode and the cube-split certificate.
* **Any segfault, any process**: HALT and report to Kooshi (standing rule).
