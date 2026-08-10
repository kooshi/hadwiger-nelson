# M32 — The first certified infinite 5-chromatic object (PRE-SUBPLAN STUB)

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
