# STANDING QUESTIONS — the durable ledger of theory, ideas, and refutations from the descent campaigns

*Created 2026-08-24 at the M50 close, on Kooshi's direction: nothing discussed, theorized, or
questioned in that long milestone may be lost, and it must live outside M50's own file. This is
the standing shape-space for the descent era, maintained like `plans/SHAPES-OF-SIX.md`: updated
when an entry matures or dies, deprecate-never-delete, every claim carrying its epistemic status
and its falsifier where one exists. Entries are SELF-CONTAINED statements; the M50 plan's §R/§S
sections remain the archival evidence, cited by address. Milestone homes: the descent's
continuation is `plans/M51-descent-engine.md`; the gadget question is
`plans/M52-nominated-gadgets.md`.*

## §K. Kernel-ready pieces (statements with proof sketches, none yet in Lean)

* **K1 — the spare-colour lemma.** A (k−1)-colourable graph admits no pair compulsion of either
  polarity between non-adjacent vertices at k colours: take a (k−1)-colouring; recolour one
  endpoint with the unused k-th colour (kills forced-equal — and if the colouring already
  separates them, it kills it directly), or recolour BOTH endpoints to k (proper because they
  are non-adjacent; kills forced-distinct). Two lines each; an afternoon in Lean, Greedy.lean-
  adjacent. Consequences: (a) **every virtual-edge gadget at five colours is itself a
  ≥ 5-chromatic unit-distance graph** — the hard floor under any gadget hunt, and G25's "each
  level's kill is the previous level's forcer" as a pair-level theorem; (b) a carrier forcing
  A = B with zero non-unit edges has a non-4-colourable unit part, so the descent's χ(unit-part)
  monitor must cross 4 → 5 NO LATER than the final commit — the crossing mints a new
  5-chromatic witness (see T7); (c) retro-explanation: every pair-meter zero ever measured on
  4-colourable material at k = 5 (M31's flat table, M32's stacks, the hexagram chunks) was a
  theorem, not a finding — scope: pair-level only, class pigeonholes untouched.
* **K2 — the field-agnostic compactness bridge.** For any point set Γ ⊆ ℂ and the seed-minus-
  batch H−B: (every finite subset of (H−B) ∪ Γ admits a separating 5-colouring) ⟺ (the whole
  does). ⇐ is restriction; ⇒ is Tychonoff on (Fin 5)^Γ with discrete factors — properness and
  separation are closed cylinder conditions, finite satisfiability gives the finite-intersection
  property. Mathlib holds Tychonoff; predicted 40–80 lines; the awkward part is only closedness
  bookkeeping. Consequence: "the descent stalls forever" ⟺ "the INFINITE constructible closure
  admits a separating colouring" — a stall becomes a statement about one infinite object
  (Kooshi's closure-transfer angle, Q3). The field-restricted closure Γ_F needs no kernel
  definition for this — the bridge quantifies over arbitrary Γ.
* **K3 — the absorbing lemma.** Forcing is monotone under augmentation: if no separating
  colouring of X exists, none exists for any X′ ⊇ X (restriction, one line). The licence the
  whole descent uses implicitly; kernel-worthy for hygiene. Its tempting sibling —
  odds-MONOTONICITY (committing material never lowers the separation odds) — is FALSE as a
  theorem: both counts move by extension factors that can favour either side. Odds are a
  dashboard metric, never a lemma.
* **K4 — the entropy floor.** If χ(G) ≤ k−1 on n vertices then G has ≥ 2^⌈n/(k−1)⌉ proper
  k-colourings: fix a (k−1)-colouring, let C be its largest class (|C| ≥ ⌈n/(k−1)⌉); S ↦
  "recolour S to colour k" injects subsets of C into proper k-colourings (S is recoverable as
  the k-preimage). Up to palette divide by k! ≤ 120. **Scope, learned the hard way (the M50
  adversarial pass): the contrapositive applies only to the SAME graph** — "few colourings ⟹
  not-4-colourable" is valid for a pure unit graph, and FALSE if you count one graph's
  colourings and conclude about its unit part (the seed: 35 classes, 4-chromatic unit part).
  Correct consumer: the generator screen — 5-tight FABRIC must be 5-chromatic, so fabric for
  the 6-hunt is built by fusing 5-forcers, never by decorating 4-chromatic lattice.

## §T. Theory frames (status-tagged)

* **T1 — the two-ladders principle** [instrument, validated]. The SUPPORT ladder asks which
  patterns are realizable (compulsions, virtual edges, the arity floor — swept to completion at
  M45/M48); the WEIGHTED ladder asks how often each pattern occurs under the class-uniform
  measure on a held colouring list. The weighted ladder was never climbed globally until M50 —
  and first contact found the 148 absolute virtual edges and 412 pigeonhole triangles four
  complete support sweeps could not see (they were cast-limited). Exact pricing: for a pair
  absent from the stage, mono-mass × |S| is EXACTLY the number of classes a halo must kill to
  force that pair distinct **in every separating colouring** — a cover cost in the design
  engine's own units (the separating scope word is mandatory; absolute pair-targets are priced
  by no held list). Instrument discipline: palette-canonicalized lists support only
  palette-invariant functionals; solver-witness halo columns are never measured (M19's lesson).
  The PID/"synergy" naming was DEMOTED as costume (vocabulary with no attached instrument);
  the distinction itself is the value.
* **T2 — the nominated distances / polarization** [measured, seed-native; replication
  registered]. The E–I stage's ensemble is polarized: distances {3, 4} near-forced-distinct
  class-wide (the six d = 4 pairs are the diameters through hub v0 — forced central
  ANTI-symmetry at five colours, M30's forced-symmetry genre sign-flipped), {√3, √7, 2√3}
  carrying excess mono-mass. Seed-native (class means barely move between iterations), NOT
  descent-driven. Before this may inform design: the Parts-{1,φ} replication (registered in
  `plans/M52-nominated-gadgets.md`) must decorrelate "the dial nominates" from "E–I was built
  this way". Vocabulary caution: the triangle census's fifth family sits at √13, whose spindle
  radicand 51 = 3·17 is OUTSIDE the owned fields.
* **T3 — the colouring MRF unification** [frame]. The uniform measure over proper colourings of
  a graph is a Markov random field — separators give exact conditional independence — so five
  instruments are functionals of ONE object: forcing = perfect long-range correlation; the
  separation odds = a likelihood ratio; entropy screening = its growth rate; the
  closure-transfer question = the support of the MRF on the infinite lattice; the M20 strip
  automaton = its transfer operator. The Markov property on finite graphs is provable
  (factorization over components); correlation DECAY is physics-grade and stays a measured
  quantity, never an assumption promoted.
* **T4 — the freezing reading** [reading; falsifier named]. Rigid-at-k = the frozen/condensed
  phase of the k-state model; "rigidity lives only at the forcing level" (G9/G17) = freezing
  only at criticality. The engine's own tractability is the phase diagnostic: lookup design
  works exactly while the separating list is enumerable (deep-frozen); M49's k = 4 calibration
  failure (> 20,000 colourings) was the phase boundary. Falsifier: an object with huge S where
  batch design still succeeds, or small S where it fails.
* **T5 — dual certificates** [REFUTED as a gadget bound; salvage stated; do not revive as
  written]. The LP dual of the cover ("1/max-kill-mass lower-bounds gadget size") is UNSOUND
  for the engine's actual primal: killing is a property of the SET (joint kills — the K₃,₃
  caveat), so the per-point dual bounds only single-point-kill covers, and M49's own record
  explodes the claimed bound (depth-1-exhausted refusers with 87–267-point depth-2 gadgets —
  the LP reads +∞ where gadgets exist). Salvage: the degenerate dual IS the whole-set
  monotonicity test the engine already owns; nothing more.
* **T6 — K₅ projectivity** [confirmed; consequences tightened]. For k ≥ 3, K_k is projective —
  all polymorphisms are dictators up to palette permutation (Greenwell–Lovász 1974; Larose–
  Tardif, "Strongly projective graphs", Canad. J. Math. 2002). Licensed: no pointwise
  combination of proper colourings exists — crossover/averaging search over colourings is dead
  on arrival, and enumeration+masks is the only representation of a colouring list. Tightened
  (Inv–Pol): with a trivial polymorphism clone, every S₅-invariant relation is pp-definable
  from ≠ abstractly — **the colour side was never where an obstruction could live; every
  obstruction to gadget existence is unit-distance realizability** (the field wall, G1). NOT
  licensed: "the lists have no exploitable structure" — they keep the palette quotient, the
  seed's automorphisms, and the cluster structure the cube enumeration exploits.
* **T7 — the phase monitor** [instrument, armed]. One SAT ask per commit: is the object's pure
  unit part still 4-colourable? By K1 the answer flips before the descent ends, and the
  flipping commit holds a NEW 5-chromatic unit-distance graph (glue-lattice-grown — no
  published witness's genre). Standing halt-and-certify event. Reads 4-colourable at 1,008
  points (M50 close).
* **T8 — the compounding lattice** [measured — see Frontier G33]. The committed material's own
  partner lattice grows faster than the rigidity it must break (the core probe: five refusers
  fall clean, six at zero provable survivors on the grown object). Falsifiers registered in
  G33; the width-stall fraction across iterations is the dial to watch.
* **T9 — the information-theory programme's unmatured items** [registered, unbuilt]:
  (i) fabric colourings as 2-D constrained coding — entropy rate = capacity, strip transfer
  matrices bound it; the Berger–Wang caveat: capacity zero ≠ empty, and a zero-rate-but-
  colourable crystal would mean FORCED QUASIPERIODIC 5-colourings, a find in itself;
  (ii) separator data-processing + measured decay ⟹ width lower bounds on forcing gadgets (the
  quantitative form of G14's zero-flux matchings) — the one theorem-shaped IT item;
  (iii) compression/MDL as calibrated rigidity proxies (G10's "least geometry" formalized);
  (iv) learned models PROPOSE only (cross-entropy over crystal parameters; marginal-predictor
  loss as a conditional-entropy bound at unenumerable scale) — and T6 warns crossover off.

## §Q. Kooshi's registered ideas (his; verify-and-develop, never silently drop)

* **Q1 — the crystal generator.** Sweep pivot distances (or prove the pivot-ring classification
  in Lean) while recursing through unit-radius connections to build arbitrary crystals, then
  apply the copy-and-rotate (detune) trick that got the field to five. Surviving form after the
  entropy floor (K4): the generator must FUSE 5-FORCERS (M34 union / G25 grammar) — all seam
  crystals are 4-chromatic and are rejected by their own screen. Ranking metric wanted:
  transfer-matrix entropy-rate screening (what the flat M32 campaign lacked).
* **Q2 — the no-stall reframing.** If EVERY reachable non-5-colourable {1,2}-graph with a
  distance-2 edge admits a unit augmentation removing one, induction on the cheat count gives
  χ(ℝ²) ≥ 6 WITHOUT exhibiting the final graph. Correctly stated it quantifies over reachable
  objects (per-edge removability does not compose — the all-19-SAT measurement), and in full
  generality the lemma is EQUIVALENT to χ ≥ 6. Value: χ ≥ 6 reframed as "stalls have impossible
  anatomy", with the near-stall anatomy already sharply constrained (the pigeonhole
  quadrilateral family, blind centres, live distances). A RESTRICTED no-stall lemma for the
  class the descent provably stays inside, plus the concrete chain, would BE the theorem.
* **Q3 — the closure-transfer angle.** By compactness (K2), the descent stalls forever iff the
  infinite constructible closure of (seed − batch) admits a separating 5-colouring — so proving
  the closure FORCES A = B yields a finite certificate nonconstructively. The tame first bite
  (the ⟨ζ₆,σ⟩ seam closure) was DEMOTED to a cheap pre-test by the adversarial pass (the M50
  halos are glue points mostly outside the seam orbit, and the seam bite risks a boring NO via
  M24–M26's own 4-colourability): attempt the ambient-4-colouring patch on H−B explicitly
  first. The intrinsic object is Γ_F(X) — the smallest superset closed under glue points whose
  radicand is a square in F — a FIELD object, no anchors (the M49 59-radicand census already
  speaks this language; M50's P5 census counted 60 exact values, flag unresolved).
* **Q4 — the rigidity currency.** Rigidity at 5 = −log N(X); a cheat's worth = its deletion's
  entropy jump; a halo's = the entropy it removes. Measured exchange rates (M49–M50): ~1
  pt/cheat at depth-1 kills, ~24 pts/cheat for the 19-batch, ~13 for the 24-batch, 87–267 for
  depth-2 single-edge gadgets. MANDATORY refinements from the adversarial rounds: the currency
  is CONDITIONAL (separating vs total counts are different events — two adversarial members
  recorded); the right functional is the separation odds N_sep : N_eq, with log-odds the
  progress metric; raw entropy diverges from forcing progress. The 10⁴–10⁵ full-replacement
  estimate was demoted (in-context rates extrapolated context-free — the P4b/G30 quantifier
  slip); no size number is quoted.
* **Q5 — the refuser-core geometry** (his visualizer observations, all verified exact, M50
  §R5): the blind centres v58/v115 with six exact locks each; the perfect equilateral hexagon
  about v0 at ring radius (34+√33)/12 (a ℚ(√33) ring at a pivot distance nobody has swept);
  the quadrilateral {98,118,107,126}'s total cross-pair pigeonhole with {98,107} = v115's unit
  neighbours and {118,126} = v58's. The refuser-core TOOL:
  https://claude.ai/code/artifact/53172e9e-9e01-4398-9eae-614060d555f2 (source
  `refuser_core.html` in the M50 job scratchpad); the dial explainer:
  https://claude.ai/code/artifact/97ebb92e-066d-42ea-93aa-662a4cc3cff8.

## §D. Data assets (build/, gitignored — regenerable, addresses recorded)

Objects: `m50-object-S29-depth2r.json` (690 pts), `m50-object-S29-depth2r-it2v2-depth1.json`
(1,008 pts, the current object). Lists: `m50-S29.jsonl` (51,350), `m50-S-S29-depth2r-it2v2.jsonl`
(45,365), per-edge `m50-S-coreprobe-*.jsonl`. Weighted-ladder scans (148 virtual edges, 412
triangles, polarization, floor-edge costs): `m50-skewscan-{S29,S29-depth2r-it2v2}.json`. The
diet probe: `m50-support-probe.json`. The P5 census + core probe + all campaign rows:
`m50-batch.json`. Regeneration: `tools/batchkill.py` (self-testing), `tools/m50_skewscan.py`.

## §F. Refuted / do-not-revive (each with its killer)

The LP-dual gadget bound (T5 — joint kills); the entropy-floor contrapositive across graphs
(K4's scope — the seed's 35-classes/4-chromatic-unit-part record); PID-as-instrument (no
attached measurement); odds-monotonicity as a theorem (K3); weight trends as design signals
(the quadrilateral's mass inversion between iterations); positive counts over casts presented
as object censuses (the "16 triangles" that were 412 — G21 applies to positive counts);
verdict messages naming causes they did not check (incident 3 — one bug became two); the
seam-closure bite as the closure-transfer opener (Q3's demotion); the 10⁴–10⁵ replacement-size
estimate (Q4). Full incident anatomy: `plans/M50-batch-descent.md` §R6, §Sⁱᵛ-adv.
