# STANDING QUESTIONS — the durable ledger of theory, ideas, and refutations from the descent campaigns

*Created 2026-08-24 at the M50 close, on Kooshi's direction: nothing discussed, theorized, or
questioned in that long milestone may be lost, and it must live outside M50's own file. This is
the standing shape-space for the descent era, maintained like `plans/SHAPES-OF-SIX.md`: updated
when an entry matures or dies, deprecate-never-delete, every claim carrying its epistemic status
and its falsifier where one exists. Entries are SELF-CONTAINED statements; the M50 plan's §R/§S
sections remain the archival evidence, cited by address. Milestone homes: the descent's
continuation is `plans/M51-descent-engine.md`; the gadget question is
`plans/STUB-nominated-gadgets.md`.*

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
  `plans/STUB-nominated-gadgets.md`) must decorrelate "the dial nominates" from "E–I was built
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

## §Q (continued, 2026-09-01) and §T (continued) — the M51 iteration-4 week

* **Q6 — the seed's two crystals and the Moser interface** (Kooshi, from the descent visualizer:
  "most of the cheats are subgraphs of dodecahedral lattices… multiple offset crystals… not
  rotated relative to each other"; measured exact 2026-08-31, `plans/M51-descent-engine.md`
  §S-CONT 11:20Z). The Exoo–Ismailescu seed's unit AND cheat edges fall in nine direction
  classes: two triangular-lattice families at 13.2213° and 46.7787° (mirror images about 30°;
  the angle BETWEEN them is arccos(5/6) = 33.5573° = the Moser twist, `FieldWall.lean`'s ρ) with
  ~19 translated cosets each, plus a sparse axis family {30°, 90°, 150°}. The 12 axis cheats are
  the INTERFACE: three side-2 equilateral triangles (22-112-134, 56-78-168, 206-210-211), three
  diameters through the origin (21-38, 77-94, 133-150 — the hex-shell diameter genre at the
  seed's own centre), and 210-211. Ten of the twelve were already removed by M49/M50 — the
  descent consumed the interface first — and the only two standing are the heavy pair
  206-210 / 206-211 (206 an endpoint of the forced pair 205–206 at distance 5). No single global
  mirror maps the seed to itself (0/214). **[measured]** *Reading, falsifiable: the 5-forcing
  IS the interface, and the two crystals are 4-chromatic fabric in G1's sense. Falsifier: the
  heavy pair falls to a halo that lives entirely inside one crystal; or the unit part stays
  4-colourable after both are gone.*
* **Q7 — the halo's ring system** (Kooshi: "two incredibly distinct rings… order of 0.2… the
  outer rings just touch, like electron shells"; measured exact 2026-08-31, §S-CONT 12:05Z).
  The halo-to-seed distance census below 0.5 is pure spikes, every major one in ℚ(√33) on
  √3-ladders: r² = (6−√33)/3 (r = 0.2918, n = 1,782; its ÷3 partner r = 0.1685, n = 1,374),
  (9−√33)/18 (r = 0.4253), (7−√33)/6 (r = 0.4574 — literally the M33 3-cover-core shell; ÷3
  partner 0.2641). His two rings at ~0.2 are 0.1685 and 0.2149. Rings sit on 213 of 214 seed
  vertices and halo points ring each other (5,059 pairs at 0.2918). The touching: nearest
  halo–halo spike 0.0492 with d² = (23−4√33)/9, its √3-partner (23−4√33)/3; then (29−5√33)/18
  and (75−13√33)/18 — the shells touch at fixed algebraic gaps and rarely closer (one 0.0362
  family beyond the √3/√11 field). **[measured]** *So G4's seam-shell vocabulary generates the
  E–I halo's micro-geometry: one shell language across the seed object and the seam fabric.
  Kernel-shaped question: the ring radii as glue-point corollaries of `Glue.lean` over ℚ(√33)
  rings — stateable; not yet stated.*
* **T10 — the sub-batch and what it loses** [engineering fact + open question]. The class count
  grows ~1.11× per added cheat (a batch counts every cheat absent from the stage: it-3's 60 →
  46,350 classes; it-4's full floor, 46 already removed + 39 floor = 85 → 2,588,314), so iteration
  4 ran a 28-cheat sub-batch (37,316 classes) chosen by the put-back curve
  (`tools/subbatch.py`; WO-8): a class list for B contains every sub-batch's list as the lines
  proper on the put-back edges, so no solving is spent. What is lost: the halo is designed
  against the sub-batch's separating colourings only, so cross-cheat interactions with the
  put-back cheats are invisible this iteration — a kill that needed two of them removed together
  waits. Open: is the sub-batch's hitting set a subset of the full batch's, and by how much per
  iteration? First data point: the full-floor stage (all 39 spent, 2.59 M classes) as the server's first courier run
  (ROADMAP A.3), compared against the sub-batch commit.
* **T11 — width stalls and the pool as a choice** [measured]. The classes that refuse point-kills
  are killed by thousands of weak points cooperating (capped minimizations 2,551–14,960 points
  and descending); on iteration 4's hard tail a RESTRICTED pool (`nobj ≥ 3 ∨ pdeg ≥ 12`,
  285,973 of 1,469,696 points) killed 42/42 hard classes at 3.13× the speed, while a mixed pool
  left 16 undecided and the strong-3 pool killed nothing. A restricted-pool kill transfers
  (monotonicity, K3); a restricted-pool survive says nothing about the named pool and is adopted
  as unknown, never folded (`tools/adopt_rust_profile.py`). Open: is width a property of the
  class or of the pool? Does the stall fraction grow across iterations (G33's falsifier)?
* **T12 — engine facts that bound what the server buys** [measured]. Solver reuse across asks
  2.3× on a 207-class sample, up to 250× per hard ask (per-class times are not reproducible
  without `--solver-reset`); memory-locality grouping (`tools/pool_groups.py`, cache-sized cells
  from sysfs, 25 s) changes verdicts not at all and time inconclusively — a different variable
  order changes the CDCL trajectory and that variance dwarfs the locality effect at affordable
  n; SMT: 16 copies at 0.78× solo each, aggregate 32/16 = 1.083, so physical cores are the unit
  on memory-tight or wall-capped phases; head-of-line blocking (index-order issue, one 2 M-conflict
  budget, a rate-based ETA) cost 9.8 h once and is now a rule (first pass wall-capped).

* **T13 — the direction ladder** — *renamed 2026-09-09 (FS-23): the literature calls this object the **Moser lattice** (`[MatolcsiEtAl2025]`, `[Ducz2026]`, `[Aggarwal2025]`); the result keeps its title, new writing uses theirs* [measured on ONE halo; registered for replication as M52 P1].
  The iteration-4 halo (119 glue points, provenance depths 1:1 / 2:13 / 3:32 / 4:41 / 5:32 — 93 of
  them glue points of two HALO parents) carries 1,061 unit edges in exactly SIX directions mod 60°:
  30.00, 46.78, 13.22, 3.56, 56.44, 20.34 — the seed's three families (Q6's two crystals at 13.22°
  and 46.78° and the axis family at 30°) shifted by whole multiples of the Moser twist
  33.5573° = arccos(5/6) (3.56 = 30 + 33.56 − 60; 56.44 = 30 − 33.56 + 60; 20.34 = 13.22 + 2·33.56
  − 60 = 46.78 + 33.56 − 60). Measured 2026-09-02 at the M52 subplanning, on the halo only; the
  whole object (12,735 older edges), the it-3-era halos and the copies (where the ladder should
  gain ρ₁₅) are the replication. *Reading, not promoted: the object's direction group is
  ⟨ζ₆, ρ_Moser⟩ up to the seed's frame — G8's half-spindle-group observation for de Grey's witness,
  met on a descended object, one generator fewer. This is what Kooshi saw as the halo's
  elegance.* [measured, single object]

* **T14 — the descended object never left the seed field** [measured EXACTLY, 2026-09-02, M52
  phase 1]. Every live point of the iteration-4 object (186 seed + 1,767 glue points, depths 1–5)
  has coordinates in ℚ(√3, √11): found by PSLQ at 50 digits (1,953 of 1,953) and then VERIFIED
  with exact rational arithmetic — every one of its 13,796 unit edges is an exact identity
  `Δx² + Δy² = 1` in the basis (1, √3, √11, √33) (`tools/copy_exact_field.py`,
  `data/m52/exact-<label>.json`). It is implied by T13/P1, now replicated on the whole object
  (13,796 of 13,796 directions on the half-twist ladder, `tools/copy_anatomy.py`): a glue point is a
  parent plus a unit vector of ladder direction, and those unit vectors are in the field. **The
  correction it makes to the record:** `field_census.py`'s "new-root" class (167 points on the
  it-4 object; the 883-core's "24 distinct radicands, tower height ≤ 24, per-edge compositum
  geometry") counted radicands that are not catalogue values or RATIONAL squares of one — the
  census never asked whether a radicand is a square IN THE FIELD, and they all are (G21, on a
  classification). Consequences: (i) the copy union U ∪ R(U) lives in ℚ(√3, √5, √11) — the copy
  adjoins exactly √5 (ρ₁₅ = (7 + i√3·√5)/8), no √7 — the same field as Heule-510 (G27) and inside
  M02's kernel tower ℚ(√3, √5, √7, √11), so the 883-core's certificate geometry is M06-class, not
  the priced compositum; (ii) G1 read from below: the 4-chromatic unit part is a seam-field object
  and the 5-chromatic union is one square root up, with √5 the root; (iii) `Obj` now carries an
  exact-rejected `non_unit` set — the two-sign composed object's single "copy–copy chord" was a
  float near-miss at 1e-7, caught by the exact census. [measured; exact identities]

* **T15 — the copy lock in its finite form: two large projected colouring sets across thirteen
  chords, with the distance-2 pigeonhole underneath** [measured 2026-09-02, M52 phase 2;
  `tools/copy_kill_table.py`, `tools/m52_p4.py`, `data/m52/killtable-*.json`,
  `data/m52/p4-class-avoid.json`]. (a) **Act One is G16's**: on the it-4 unit part U (1,953 live
  points) no proper 4-colouring avoids a monochromatic pair at distance 2 (5,470 exact pairs; UNSAT
  in the one-hot and the 2-bit encodings, each under a second), while the √3 class (10,288 exact
  pairs) is avoidable — P4 met as registered, the fabric-borne pigeonhole met from below. (b) **The
  kill is not a small pattern.** On the 883-point 1-minimal core of U ∪ R₂₀₆(U) (13 genuine chords
  between the sides, 7 centre–neighbour chords folded into the copy side), the side-1 4-colourings
  project onto the 13 chord endpoints as **3,516 distinct patterns** and the side-2 ones as
  **1,062**; with the fused centre fixed to colour 0, all **3,733,992** pairs (σ, τ) are killed by
  some chord (unkilled 0 — the refutation re-read as a table), the killer-count histogram running
  1: 124,458 … 8: 203,820, and **every one of the 13 chords is the sole killer of some pairs**
  (423–R(225) alone: 46,236 pairs; 225–R(423): 18,576; the four load-bearing chords among the top
  eight). Inside Σ and T there is **no pair compulsion** on the 13 points — no forced-equal pair, no
  virtual edge (G9's floppiness, exact here); what the chords exploit is a bias: the chord endpoints
  wear the CENTRE's colour far above chance (σ(423) = colour(206) in 65 % of side-1 patterns,
  σ(225) 63 %, τ(R225) 58 %), so a chord p–R(q) kills where both ends share the centre's colour.
  (c) **Copies never touch each other**: in every composition (both signs about 206, about the
  origin, all four) the exact census finds 0 copy–copy unit chords; the copies interact only through
  the original, and every cross chord is collinear with its centre and has both endpoints in
  ℚ(√3, √11) (P2 met on 8 + 20 + 16 + 56 genuine chords). *Reading, not promoted: the lock is a
  coverage-style compulsion — the centre's colour propagates outward on the depth-2 fabric strongly
  enough that thirteen well-placed unit chords to a rotated copy cannot all be satisfied — G13's
  genre; the falsifier is a core on another centre whose chord endpoints show no centre-colour bias.*
  [measured]

* **Q8 regime (b), ANSWERED 2026-09-02 (M52 phase 3):** a ρ₁₅ copy of U as a HALO against the
  descent's classes at five colours kills **nothing** — 0 of 15,218 classes of an 8-cheat batch
  (exact enumeration on the composed object equals the plain object's list, projection for
  projection; 20/20 sampled classes extend by direct SAT, 10/10 with the copy side using four
  colours). The spare-colour lemma as a halo statement: 4-colourable material attached by thin
  chords is coloured around by the fifth colour. The copies' value is as 5-chromatic unit witnesses
  (regime (a), T15) and as it-5 lattice material, never as cheat-killers. M52 §R3.

* **The halt clause, read exactly (2026-09-03, Kooshi's question at the M52 cull).** The kernel's
  one-defect theorem (`add_one_le_chromaticNumber_unitDistance_of_one_defect`) fires on a graph
  that is NOT 5-colourable and has ONE non-unit edge: its unit part then forces that edge's
  endpoints equal, and a spindle at that distance — anywhere, any d ≥ ½ — closes χ ≥ 6. The
  descent's frame is different: it maintains "unit ∪ standing cheats forces 205 = 206", i.e. that
  graph plus one more non-unit edge (the pair) is not 5-colourable — so with one cheat standing the
  object has TWO defects, and the distance-5 spindle that removes the pair doubles the cheat. What
  one standing cheat gives is a DISJUNCTION on the unit part: 205 = 206 or the cheat's endpoints
  equal; each branch is a forced pair a spindle kills, but every copy brings its own disjunction,
  so whether a finite union closes it is a search (HALT AND VERIFY), not a theorem. **The theorem
  fires at zero standing cheats.** G32's "μ = 1 IS the theorem" counted defects in the finished
  graph's frame (K = X ∪ R₅(X), whose cheats come in pairs); in the descent's frame the halt clause
  is exactly as written — verify — and "done" is standing = 0. [kernel + reading; a sharpening of
  this project's own record]

* **Q8, the copy's timing (Kooshi, 2026-09-03: his intuition was that the copy plus its partner
  lattice would strengthen the object POST iteration — new attachment points for more exotic
  chords).** The reading after M52: the intuition is right in shape and gated by 5-tightness. A copy
  of 4-colourable fabric is coloured around at five colours whatever the chords (§R3), exactly as
  de Grey's copies of 4-TIGHT fabric are NOT coloured around at four; the copy trick's value at
  five colours switches on when the unit part's own 5-colourings are rigid on the chord endpoints —
  i.e. after the χ(unit) 4 → 5 crossing the spare-colour theorem requires anyway. **Monitor
  (registered):** at every iteration after the crossing, re-run the copy kill census (two
  enumerations, `tools/rank_copies.py`); prediction: kill fraction 0 while χ(unit) = 4, positive
  after. The partner-lattice half is weaker than it looks: a glue point between a copy point and an
  original is out-of-field material that generically has only its two parents as unit neighbours
  (the R1 blind-spot mechanism), and a point needs ≥ 5 pinned neighbours to kill alone (M49) — so
  those points kill only in the width regime, unless the ρ₁₅ union's rigid chord structure (every
  cross chord collinear and seed-field, T15) gives them alignment coincidences; that is the pool
  census on the composed object (`plans/M53-iteration-5.md`), unmeasured. [reading; monitor]

## §D (continued, 2026-09-01)

Objects: `m50-object-S29-depth2r-it2v2-depth1-it2v2-depth1.json` (it-3, 1,862 pts) and
`…-vdel28.json` (28 seed vertices deleted; 298 cheats — the it-4 object). It-4 lists:
`m51-S-…-vdel28-full85-rust.jsonl` (2,588,314), `m50-S-…-vdel28-it2v2.jsonl` (37,316, the
sub-batch, adopted). Pool `m51-pool-c62ecd80a01087ca-depth1.{json,npz}` (1,469,696 pts, fp
c446d855e42cb512) with `-pdeg12/-groups/-rcm/-morton/-strong3/-mixed16` re-exports. Profiles
`m51-profile-it4-{rust,pdeg12,pdeg12b,full2}/`. Viewer: `tools/descent-viz.html`, artifact
https://claude.ai/code/artifact/d35ad805-f5dd-483a-a03d-6160704ae6cf. Ledger `build/m51-jobs.txt`.

## §Q (continued, 2026-09-01) — Kooshi's duplication ideas, stated and sharpened the same night

* **Q8 — duplicate the descended object and DETUNE the copy by rotation until it locks
  into five** (Kooshi, 2026-09-01: "directly utilize the tricks we learned from the χ = 5 graphs
  … copy, then rotate within the angles we found effective before until it locks into 5, or as
  rigid as we can make it"). Heule's witnesses are a crystal rotated about its middle pivot; de
  Grey's is closer to a mirrored copy; our descended object shows the ℚ(√33) shell vocabulary
  (Q7) but not yet the duplication-and-detuning that made those objects five. **Sharpened by
  arithmetic the same night.** The lock angle is not searched; it is DERIVED: a copy rotated
  about one endpoint of a pair at distance d moves the other endpoint by exactly 1 when
  sin(θ/2) = 1/(2d) — the spindle theorem (`OneDefect.not_forces_of_forced_equal` genre,
  kernel: a forced-EQUAL pair at any d ≥ ½ at k colours refutes k-colourability). The table:

  | pair distance d | 4d² − 1 | θ | field |
  |---|---|---|---|
  | √3 | 11 | 33.5573° = the Moser twist (arccos 5/6) | ℚ(√11) — seam |
  | 2 | 15 | 28.9550° = 30° − 1.045° (ρ₁₅) | √15 — one field up |
  | √7 | 27 = 9·3 | 21.7868° | ℚ(√3) — seam |
  | 4 | 63 | 14.3615° = 15° − 0.638° (ρ₆₃) | √7 |
  | **5 (the forced pair 205–206, confirmed 5.000)** | **99 = 9·11** | **11.4783°** | **ℚ(√11) — inside the seed's own field** |
  | 3 · 2√3 · √13 | 35 · 47 · 51 | — | outside every owned field |

  So G7's "effective angles" ARE the spindle angles of the crystal's own pair distances, and the
  Exoo–Ismailescu spindle at d = 5 lives in ℚ(√11) — which is why their construction never
  left the seam tower. Two regimes, kept apart because they have different theorems behind them:
  **(a) at FOUR colours on the UNIT part U** — if U forces some pair EQUAL at k = 4 at a
  spindle-able distance, then U ∪ R_θ(U) is a **5-chromatic unit-distance graph by theorem**,
  no search: the χ(unit) 4 → 5 crossing manufactured rather than awaited (K1 says the crossing
  must happen before the descent ends; this makes it happen now). Prerequisite measurement,
  registered: the complete k = 4 forced-equal sweep of U (1,862 points, 12,735 unit edges;
  `tools/rigidity.py`'s lattice). **(b) at FIVE colours with the cheats** — a rotated or
  mirrored copy of U (cheats omitted, as he suggested) is a candidate HALO: a 1,862-point pool
  whose kill mass over the current sub-batch's classes is exactly what `descent replay` measures.
  A copy that kills every class is a one-shot batch commit with no shrink; the copy's field is
  the rotation's (d = 5: no new radicand). Priors from our own record, stated honestly: copies
  of 4-chromatic SEAM fabric at every detune couple thinly (G12, one conic of chords) and forced
  nothing at M31/M32 — but those objects carried no forced pair and the copy was asked to force
  alone; here the copy is asked only to kill separating colourings of a rigid carrier (T4's
  deep-frozen regime), a different question. **[registered; probes below]**
* **Q9 — duplicate and MIRROR across the line through the forced pair** (Kooshi, same message:
  "copy, then mirror our whole graph across the line formed by the forced pair 205 and 206").
  The reflection fixes both endpoints, so the copy carries the SAME forced pair — no spindle,
  no new field (the axis direction is a field element) — and doubles the material about the
  pair; the seed has no global mirror symmetry (Q6: 0/214), so the mirror copy is genuinely new
  and its cross-chords to the original are exactly the axis-symmetric pairs. Same two regimes
  as Q8: (a) χ(U ∪ mirror U) at k = 4 — one SAT ask; (b) mirror(U) as a halo against the
  sub-batch's classes. De Grey's own object is the calibration (the 791-forcer is V ∩ −V —
  centrosymmetric, G27; the forced central symmetry at four colours, G9).
* **The probe for both (`tools/copy_probe.py`, registered before it runs):** for each transform
  T ∈ {mirror across 205–206; rotation about 205, about 206, and about the seed origin v0 by
  the spindle angles of d ∈ {5, 2, √3, √7, 4}}: build T(U), fuse coincident points, count exact
  cross unit chords, and ask k = 4 on U ∪ T(U) — UNSAT = a 5-chromatic unit graph, HALT AND
  CERTIFY; plus the k = 4 forced-equal sweep of U alone. Predictions, registered: P-Q8a — U
  alone has NO forced-equal pair at k = 4 (K1's cousin: the seed's own 4-colour space is loose;
  M49 measured > 20,000 colourings on a 122-point 4-colour object), so regime (a) reads SAT
  for every transform (confidence medium); P-Q8b — the d = 5 rotation about 205 or 206
  produces the most cross chords of the rotations (its angle is the seed's own); P-Q9 — the
  mirror produces more cross chords than any rotation (every axis-symmetric pair locks) and
  still reads SAT at k = 4. If any transform reads UNSAT the reading is a new 5-chromatic
  unit-distance witness and the jackpot protocol applies. Regime (b) is the follow-up: the
  copies exported as pools for `descent replay` on the it-4 sub-batch list.

## Q8 — RESULT (2026-09-01, the same night; verified at the tools level, kernel pending)

* **A new 5-chromatic unit-distance graph, by Kooshi's construction.** U = the unit part of the
  iteration-4 object (1,834 live points, 12,735 unit edges, 4-colourable); R = the rotation by
  2·arcsin(1/4) = 28.955° (cos 7/8, sin √15/8 — the ρ₁₅ detune, de Grey's own angle) about
  vertex 206. **U ∪ R(U): 3,695 points, 25,486 unit edges, refuses four colours** — three encodings
  (one-hot with and without breaking, 2-bit), all 34 cross chords unit to 250 digits (the rotation
  is exact; the copy of 206 fuses to 206). Same about the origin (58 chords, both signs, two
  encodings). Only 4 chords are individually load-bearing at 206, joining two pairs of depth-1
  glue points {225, 423}, {243, 424} at distance 1/√3 (the two-circle inner radius), 225–243 and
  423–424 at √3. **[measured; `tools/copy_probe.py`, `copy_verify.py`, `copy_exact.py`]**
* **It is a property of the material, not of a centre.** The same angle about the four
  load-bearing halo points (his autocomplete's suggestion) locks with MORE chords (48–52); the
  full sweeps: **176 of 186 live seed vertices lock** (380 asks, 0 unknown; non-locking both
  signs: 79, 127, 129, 130, 174, 190, 199, 203, **205** — the forced pair's other endpoint,
  while 206 locks — and 208) and **818 of 1,648 halo points lock** (3,296 asks, 0 unknown; the
  two signs NEVER disagree; depth-1 locks 308:68, degree median 15 vs 10) — a map of where the
  depth-2 fabric is 4-tight. **[measured; `tools/copy_centres.py`; final numbers in
  `plans/Q8-FIVE-CHROMATIC-OBJECTS.md`]**
* **Controls (`tools/copy_controls.py`).** The angle perturbed by ±0.3°, ±1°, +5°: chords fall to
  the 18 angle-independent ones and the union is SAT. The Moser angle (√3) with hundreds to
  thousands of chords: SAT on every object. The seed's unit part alone, iteration 1 (690) and
  iteration 2 (1,008): SAT at the ρ₁₅ angle. **Iteration 3 (1,862): UNSAT** — the lock arrived
  with the iteration-3 halo, which is glue points of glue points: seam-field material at depth 2
  from the seed. That is G16's depth switch (the distance-2 pigeonhole fires on seam fabric at
  depth ≥ 2, clean at depth ≤ 1) and 2·arcsin(1/4) is de Grey's rotation: **the descent has
  grown de Grey-grade fabric without being asked to, and one de Grey spindle about almost any of
  its vertices makes a 5-chromatic unit graph.** [reading: the mechanism is G15's two acts —
  a disjunctive distance-2 pigeonhole on the depth-2 fabric × the ρ₁₅ kill; falsifier: the vertex
  core (`tools/copy_core.py`, running) containing no distance-2 pair with its image at unit
  distance, or a core that 4-colours once its radius-2 material about the centre is removed while
  the rest stays.] What the k = 4 rigidity of U alone says: 137 forced-equal pairs at 8/3 and
  8/√3 (radicands 247/9 and 253/3, outside every owned field), none at distance 2 — so the lock is
  not a pair spindle; it is disjunctive, as G16 is.
* **What it does to the dial (Kooshi's question).** Floor census on X ∪ R₂₀₆(U): of the 39 floor
  cheats, 0 redundant alone, 36 essential, 3 unknown ((118,212), (126,203), (132,134)); the jackpot
  ask (zero cheats) SAT; the composed four-copy union (9,194 points, 63,770 unit edges, 189
  chords) k = 4 UNSAT in 15 s, k = 5 all-cheats control UNSAT 539 s, and its zero-cheat jackpot
  ask **SAT at 4,704 s** (no χ ≥ 6; ~40× harder than the single copy's 116 s — a hardness
  reading, not a verdict); the endpoint census: 0 of 184 seed vertices deletable alone, plain
  and copied alike. The joint counts — the delta-debugging cull over all 298 cheats
  with and without the copy, the cheat-endpoint census with and without — are running; results
  land in this entry. **What it changes strategically:** the χ(unit-part) 4 → 5 crossing (T7)
  is manufactured rather than awaited, so K1's obstruction (a 4-colourable unit part carries no
  pair compulsion at five) is gone in the copied object: pair compulsions at FIVE colours in
  the unit material become possible for the first time — the 6-hunt's Act One has a stage
  (G19). Adopting the copy as object material needs a provenance dialect for rotated points
  (Python `Obj` + the Rust readers, D38) — a work order.
* **Certification path (HALT-AND-CERTIFY):** the vertex core is DONE — **883 points**
  (434 original: 102 seed + 332 halo; 449 copy), 4,625 unit edges, 20 cross chords, 1-minimal
  at 0 unknown over 3,412 asks — a distributed, de Grey-like refutation; its provenance closure
  adjoins **24 distinct radicands** (18 catalogue + 6 new roots), so the certificate's geometry
  is per-edge compositums (+ 588 parent chords free by `Glue.lean`) feeding the M42 LRAT
  template at k = 4. Priced, not started. **The lock survives the it-4 commit** (monotonicity
  measured: 36 chords UNSAT 6.3 s about 206; 64 chords UNSAT 4.2 s about v0 on the 1,981-point
  object). Full object cards + machine-readable recipes: `plans/Q8-FIVE-CHROMATIC-OBJECTS.md`,
  `data/m51/q8-transforms.json`.

* **T16 — The field wall is a theorem (2026-09-05, `~/field-wall-conjecture.md` §5; Kooshi's other
  session).** χ(G(K²)) = 4 for K = ℚ(√3, √11): colour a point by its residue modulo a conjugation-fixed
  prime 𝔭 of K(i) above 2 (2 = (𝔭₁𝔭₂)² in ℚ(i, √3, √11), residue fields 𝔽₄, decomposition field
  ℚ(√33) real so conjugation fixes each 𝔭ⱼ); a unit vector u has v(u) + v(ū) = 0 and v(ū) = v(u), so
  it is a 𝔭-adic unit and a unit step changes the residue. Woodall's 2-colouring of ℚ² is the case
  𝔭 = (1 + i). Checked here (`tools/residue_colouring.py`): the seed (1,004/1,004 proper, 446/446
  distance-2 pairs mono, A ≠ B) and the it-4 object (13,796/13,796, 344/344, A ≠ B), both 2-adic
  branches. **Consequences:** T7's crossing cannot happen inside K (Theorem 7.1: no pair compulsion at
  five colours in K), so the descent must leave K to end; the wall's location is 2-adic — it falls
  for a real field F iff −1 is a square in some completion of F above 2, for multiquadratic F iff an
  odd square class is ≡ 7 (mod 8): √5, √7 break it, √2/√10/√14/√35/√70 do not; spindles at even
  distance always break it (4d² − 1 ≡ 7 mod 8). M50's forced pairs at 8/3 and 8/√3, M34's mono
  distance-2 pairs, M24–M26's χ = 4 closures, and M52's P5 (copies at ρ₁₅ make 5-chromatic unit
  graphs; in-field commits never do) are all instances. G1 is promoted from reading to theorem
  (hand-proved; kernel formalization the next milestone's). Open after it (the note's §8): whether
  χ(G(ℚ(√3, √5, √11)²)) = 5 (Heule-510 lives there; residue bounds cannot reach 5), √7 without √5,
  the quadratic fields ℚ(√d) with d ≡ 7 (mod 8) (triangle-free planes), exactness of the bound for
  ℚ(√3), ℚ(√5), ℚ(√11), and whether Fischer (1990) already contains the criterion.

* **T17 — The residue obstruction: what in-field material can never do, decided by a 2-SAT
  (2026-09-05, the session holding the proof; `~/field-wall-conjecture.md` §7.2–§7.4,
  `tools/residue_floor.py`, `data/m53/residue-floor-it4c.json`).** [theorem + measured] The residue
  colouring r with a fifth colour on a vertex set S is a separating 5-colouring of unit ∪ C′ iff S is
  an independent exact transversal of the cheats C′ (exactly one endpoint per cheat, no unit edge
  inside S, not both A and B) — the 2-SAT Σ(C′) on the seed vertices — and it extends to any finite
  set of K-points by r itself. Hence Σ(C′) SAT ⟹ no in-field halo at any depth makes C′ force; every
  in-field-reachable standing set has Σ UNSAT (an odd cycle of distance-2 pairs, or every side choice
  blocked). Lemma: two points of K² at distance 2 from a common K-point are never unit-apart (needs
  √15), so two cheats always admit a transversal: **μ ≥ 3 inside K**, the three a distance-2 triangle
  or a collinear five-point blockade. Measured on the culled it-4 object: standing cheat graph 24
  components, 8 non-bipartite (13, 12, 11, 9, 9, 9, 8, 8), shortest odd cycle 3, Σ UNSAT; 0 of 149
  single removals turn Σ SAT; the two-cheat batch keeps all 8 odd components; 0 of its 3,936 in-field
  survivors are residue-type (both primes). The seed's 446 cheats: 16 components, all non-bipartite.
  *Reading:* the in-field loop is far from its residue floor, which is why in-field material did the
  intermediate kills; the floor and the theorem together say the loop's only value is in-context
  reduction of the standing set, never termination.
* **T18 — The wall-breaking material at depth one, classified exactly (2026-09-05,
  `tools/wall_break_test.py` — the classifier the halt record asked for; `data/m53/wallbreak-it4.json`).**
  [measured + derived] Over the it-4 object's 950,371 pairs at distance < 2: 1,435 radicands;
  32 in-field (140,195 pairs); **5 break the wall alone (4,221 pairs, 0.44 %)** — the √5 class
  (4,092 pairs, distances 4/3 and 2√5/3) and three others (129 pairs); 205 radicands (81,592 pairs)
  break at exactly one 2-adic prime and need a partner (the pairs (−1,1)+(1,−1), (2,·)+(−2,·) and
  their six relatives, 8 two-class combinations in all); **523,608 pairs are squares in ℚ₂(√3) at both
  primes — useless in any combination.** Only 16 class pairs occur, an 𝔽₂-subspace of rank 4 of 8:
  DERIVED — every object point keeps the Exoo–Ismailescu shape (x ∈ √3·ℚ(√33), y ∈ ℚ(√33)), so
  every radicand lies in ℚ(√33) and is 2-adically rational, and ℚ₂'s square classes inside ℚ₂(√3) are
  exactly ⟨−1, 2⟩ (3 ≡ 1, 5 ≡ −1). Self-test: 21 planted radicands (the note's §6.2 table plus
  1 + √3, 2 + √3, (2 + √3)², 5(2 + √3)², √33, 4) classified as derived. *Consequence:* the endgame's
  depth-one pool is ~8,000 √5-class points, or partner pairs from the one-prime classes; the rest of
  the 1.6 M-point out-of-field pool is provably inert for the endgame.
* **Q10 — Is the residue colouring rigid? (2026-09-05.)** [question] Are r₁, r₂ (up to relabelling
  and coset choice) the only proper 4-colourings of G(K²)? For ℚ² the analogue holds (bipartite ⟹ one
  2-colouring per component). Finite K-point graphs have many other 4-colourings — none of the it-4
  object's 5,470 distance-2 pairs is forced mono at four colours, while 137 pairs at 8/3 and 8/√3 are —
  so the question is about the infinite graph. A positive answer would explain the distance-2
  pigeonhole (M33/M34) as the shadow of uniqueness, and the copy lock's arrival at iteration 3 as the
  fabric becoming residue-rigid on the chord pairs. Dial to measure: for each distance class d of
  positive 𝔭-adic valuation, the fraction of d-pairs forced mono at four colours, against depth.
  **First reading of the dial (2026-09-05, `tools/mono_census.py`, `data/m53/mono-census-it4.json`,
  joined to M51's four-colour forced-equal sweep — CAVEAT: the sweep ran on the 1,834-point
  pre-it-4 unit part, the census on the 1,953-point it-4 object, a superset):** the classes the residue
  colouring makes monochromatic, with their pair counts on it-4 — d² = 4: 5,470; 4/3: 6,669; 12: 767;
  16: 179; 16/3: 2,145; 64/9: 178; 64/3: 11 — and the forced-mono counts M51 found: **131 at 64/9 and
  6 at 64/3, zero in every other class**. Forcing at four colours lives ONLY in the two classes of
  2-adic valuation 6, at 74 % and 55 % of their pairs, and nowhere at valuation 2 or 4. Reading,
  falsifiable by the exact sweep on it-4 (15,419 mono-class pairs, the `Rigidity` engine; queued after
  the partner replay): rigidity toward the residue colouring arrives from the deepest valuations
  down, and distance 2 — the pigeonhole's own class — is the LAST to become rigid pairwise.
  **The exact sweep on it-4 (`tools/rigidity_dial.py`, `data/m53/rigidity-dial-it4.json`; complete on
  the forced-equal side, 136 calls, 2,155 s):** 171 forced-equal pairs at four colours on the
  1,953-point unit part — **163 of 178 at d² = 64/9 (91.6 %) and 8 of 11 at 64/3 (72.7 %), both
  valuation 6; 0 of 6,669 at 4/3, 0 of 5,470 at 4, 0 of 2,145 at 16/3, 0 of 767 at 12, 0 of 179 at
  16 (valuations 2 and 4).** Against the pre-it-4 sweep (131/178 → 163/178 as the object grew by
  one halo) the deepest classes moved toward total rigidity while the shallow classes stayed at
  zero: the reading stands and is now a two-point curve. What would falsify it next: a valuation-4
  class acquiring forced pairs before valuation 6 saturates, or any forced pair at distance 2 while
  8/3 is still below 100 %.
  **The zero rows are a theorem, not a measurement (2026-09-05).** The residue colouring r is a proper
  4-colouring of every K-point graph with r(x) = r(y) iff v_𝔭(x − y) > 0. Hence in ANY K-point
  unit-distance graph, at four colours, a pair forced EQUAL lies at positive 𝔭-adic valuation (a
  valuation-0 pair is separated by r) and a pair forced DISTINCT — a virtual edge — lies at valuation
  0 (a positive-valuation pair is equated by r). So the dial's valuation-0 rows read 0 forced-equal
  by theorem, and the measured content is only the distribution over the positive-valuation classes;
  likewise every virtual edge at four colours the programme ever found on K-fabric (M45's 27/28/31
  offsets were on the cell family, not K) must sit at valuation 0. Two lines, kernel-ready once
  Theorem B is.

* **T19 — Single wall-breaking points kill nothing; the quadratic planes classified (2026-09-05).**
  [measured; derived] (a) The new plan's first row: the 8,442 glue points of the five wall-breaking
  radicands, exported as a pool of their own (`tools/wall_pool.py`, `depth1-wallfield`, 34,518 pool–pool
  unit edges; each point has exactly two object neighbours), replayed against the two-cheat stage's
  3,936 in-field survivors (`data/m53/replay-wall-b2/`): **0 killed, 3,936 extend, 19 ms median** —
  breaking the wall is necessary for the endgame and a few thousand degree-two points are not
  sufficient; the 572,992-point partner pool (every nontrivial 2-adic class; 2,237,572 pool–pool edges),
  sampled at every tenth survivor — 394 rows, 16 workers, 300-s walls, 2 M conflicts:
  **394 unknown, 0 killed, 0 survive** (`data/m53/replay-partner-sample/`). Read exactly: the
  instance (a 5-colour list-colouring over 574,759 variables) is undecidable at that wall for every
  sampled class, the same shape as M53's pdeg12 pass (5 killed, 3,676 unknown of 3,681); a five-minute
  wall on a half-million-point pool measures the wall, not the material. Whether wall-relevant depth-one
  material kills at five colours is UNDECIDED here, and the next honest ask is a smaller pool (the
  partner classes restricted to high pool-degree, the pdeg12 recipe) with an hour-scale wall. (b) Corollary 6.5 of the note (`plans/FIELD-WALL-THEOREM.md`): for squarefree d > 1 the
  unit-distance graph of ℚ(√d)² is **bipartite when d is even or d ≡ 1 (mod 8)** (Woodall's parity
  transplants), **at most 4-chromatic when d ≡ 3, 5 (mod 8)**, and beyond the residue method when
  d ≡ 7 (mod 8); the last class is not degenerate — ℚ(√7)² carries an explicit unit 5-cycle
  (steps −1, ζ, ζ, (w/2)(−1 ± i) with ζ = (3 + i√7)/4, w = (1 + i√7)/2, verified exactly), so
  χ(G(ℚ(√7)²)) ≥ 3 with no equilateral triangle available; 3, 4 or more is open.

* **T20 — The fabric's own forced distance, spindled: a 5-chromatic unit-distance graph in
  ℚ(√3, √11, √247) (2026-09-05, `tools/forced_spindle.py`, `data/m53/forced-spindle-full.json`).**
  [measured, derived first] The rigidity dial (Q10) found 163 pairs at distance 8/3 forced equal in
  every proper 4-colouring of the it-4 unit part U (pure K-fabric, no √5, no √7). The spindle theorem
  then says U ∪ R(U), R the rotation about one endpoint x with cos θ = 1 − 1/(2d²) = 119/128 and
  sin θ = √(4d² − 1)/(2d²) = 3√247/128, has no proper 4-colouring — and 247 = 13·19 ≡ 7 (mod 8), so
  this spindle breaks the wall exactly as Theorem B requires of any 5-forcer (the wall's
  even-distance rule generalised: 4d² − 1 ≡ 7 mod 8 up to squares). Built for the pair (35, 1859):
  **3,905 points (1,953 + 1,952, the centre fused), 27,593 unit edges, 8 cross chords at 60 digits
  with a 1e-6 near-miss refusal; refuses four colours by a DIRECT SAT ask (not via the theorem), and
  is 5-colourable (control).** So the seam-field fabric grown by the descent is 4-rigid enough to
  mint 5-chromatic witnesses by itself, at a distance nobody had spindled — M51's "at distances
  nobody can spindle" meant outside the kernel's tower, not outside mathematics — and the field
  ℚ(√3, √11, √247) is new for 5-chromatic unit-distance graphs (de Grey: √5, √7; Heule: √5; the 8/√3
  pairs give ℚ(√3, √11, √23) the same way — BUILT: pair (246, 614), 10 cross chords, one genuine
  near-miss at |d − 1| = −7.2·10⁻⁷ rejected at 60 digits, direct 4-refusal, 5-colourable;
  `data/m53/forced-spindle-full-8oversqrt3.json`). **The small witness (`data/m53/forced-spindle-core-8over3.json`):**
  the greedy outside-in shrink of the 8/3 pair's forcing core is **588 vertices, 2,886 unit edges,
  1-minimal (every vertex's deletion admits a separating 4-colouring, all 586 witnessed)**, and
  core ∪ R(core) is a **1,175-point, 5,773-edge 5-chromatic unit-distance graph** (6 cross chords, the
  centre fused; direct 4-refusal; 5-colourable) — de Grey's forcer at distance 4 needed 791 points
  and √5, √7; this K-fabric forcer at 8/3 needs 588 and neither. *Consequence for the endgame:* the wall-breaking
  adjunction need not be an external angle — the fabric names its own (its valuation-6 forced
  distances), and the Q10 dial is the instrument that finds them.

* **T21 — Theorem A′, the 3-adic wall, and the residue chromatic number (2026-09-05, note §6.2′).**
  [theorem, hand-proved] Colouring by the residue class modulo an additive subgroup H of the residue
  field that avoids the norm-one group C refines Theorem A to [k : H] colours. For a prime 𝔮 of F above
  an odd p ≡ 3 (mod 4) with residue field 𝔽_p, the prime above it in F(i) is conjugation-fixed with
  residue field 𝔽_{p²}, C has p + 1 elements, and exactly (p + 1)/2 of the p + 1 lines avoid C: so
  χ(G(F²)) ≤ p. At p = 3: **any real field with a degree-one prime above 3 has χ ≤ 3** — hence
  χ(ℚ(√3)²) = 3 (the prime 3 ramifies; the triangle needs 3) and χ(ℚ(√7)²) = 3 (3 splits; the 5-cycle
  needs 3), while K = ℚ(√3, √11) escapes (11 is not a square mod 3, so its primes above 3 have
  residue 𝔽₉ ∋ √−1 and split in K(i)) — consistent with the Moser spindle. The residue method's
  thresholds below 7 are exactly 2, 3, 4; 5, 6, 7 are invisible to it, so **no residue argument can
  ever distinguish a field that hosts 5-chromatic graphs from one that hosts 6-chromatic ones**.
  χ_res(F) := the least [k : H]; χ_res(ℚ) = 2, χ_res(ℚ(√3)) = χ_res(ℚ(√7)) = 3, χ_res(K) = 4 (all
  tight), χ_res(ℚ(√3, √5, √11)) = 11 (above the plane's 7). The first quadratic planes past both walls
  are ℚ(√d), d ≡ 23 (mod 24). *Kooshi's cheat question, first data (`tools/witness_cheats.py`):* the
  1,175-point witness W plus ALL its distance-2 pairs stays 5-colourable (850 pairs), likewise plus
  all √3 pairs (2,370); both together refuse five colours only through the hexagonal shell's K₇ —
  not a seed. The E–I-shape question is settled NO: the complete five-colour sweep of W + its 850 distance-2
  cheats finds **0 forced-equal pairs and 0 virtual edges** over all pairs (81 calls, 858 s;
  `data/m53/witness-cheats-w5-rigidity.json`) — 4-rigid, 5-chromatic, 5-floppy, G9 one level up.

* **T22 — The critical-set localization theorem, and the witness is vertex-critical (M54, 2026-09-06).**
  [kernel: `CriticalSet.lean`; measured] With C(G) = {v : G − v is k-colourable}, a pair forced EQUAL at
  k + 1 colours has C(G) ⊆ N(p) ∩ N(q) (neither endpoint critical), a non-adjacent pair forced DISTINCT
  has C(G) ⊆ N(p) ∪ N(q), and a fan at p over Q has C(G) ⊆ N(p) ∪ Q — all instances of one lemma (a
  critical vertex isolates any independent set through it, painted with the spare colour). The
  spare-colour lemma is the case C = V. In the plane two points have at most two common unit
  neighbours (the glue point and its mirror), so **a unit-distance graph forcing a pair equal at χ(G)
  colours has at most two critical vertices, and none if the pair is more than 2 apart**; a virtual
  edge caps |C| by deg p + deg q. Consequences: (i) the 6-forcer built as "5-rigid fabric + a spindle
  at d > 2" needs fabric whose 5-chromaticity survives EVERY single vertex deletion — redundancy before
  rigidity, the dial's first rung, one 4-colour ask per vertex; (ii) single-centre spindle unions are
  dead for the dial by theorem (the fused centre is critical); (iii) every descent stage's critical set
  is empty (it forces a pair five apart) — a free regression control. **Measured:** the E–I seed's
  C = ∅ (214/214 deletions refuse four colours — the theorem's calibration, 1 s); **the 1,175-point
  witness W is VERTEX-CRITICAL, |C(W)| = 1,175 of 1,175** (every deletion 4-colourable, each certified
  by a verified colouring, 24 workers, ~4 min), so T21's exhaustive five-colour zero (858 s) was an
  instance of the theorem; the census-then-candidates pipeline (`tools/five_dial.py`) subsumes the
  exhaustive sweep whenever |C| > 2Δ, with the K₅ − e end-to-end positive and the K₇-minus-matching
  planted sweep on W (both planted pairs found in 25 s) as its controls. The vertex-critical case
  (every deletion drops χ ⟹ no pair compulsion) is folklore of the critical-graph literature; the
  localization and its plane form are M54's.

* **T23 — Literature reconciliation: Fischer 1990 owns the additive framework and the quadratic
  planes; Corollary 6.5 corrected (2026-09-06, Kooshi obtained the papers).** [read in full] K. G.
  Fischer, Discrete Math. 82 (1990) 181–195: additive k-colourings (group homomorphisms from the
  subgroup Σ₀ generated by unit vectors, nonzero on them) — every residue colouring of the note is one;
  Theorem 8: ℚ(√N)² is 2-colourable iff N ≢ 3 (mod 4); Theorem 9: N ≢ 2 (mod 3) gives 3 colours, hence
  **χ(ℚ(√3)²) = χ(ℚ(√7)²) = 3 is Fischer's** (T21 claimed it); Theorem 10: N ≡ 3 (mod 8) gives 4, and
  N ≡ 23 (mod 24) admits no additive k ≤ 6 because 1/2, 1/3 ∈ Σ₀ (the same first candidates as
  §6.2′, by a slicker obstruction). **The note's Corollary 6.5 was wrong at d ≡ 5 (mod 8): those planes
  are BIPARTITE**, not "≤ 4" — 2 is inert with residue 𝔽₄ and then ramifies in ℚ(√N, i), so conjugation
  lies in inertia, acts trivially on 𝔽₄, the reduced norm-one group is {1}, and the line {0, ω} avoids
  it (Theorem A′'s general form: C̄ = the norm-one group of the residue field over its σ-fixed subfield
  when σ is nontrivial, {±1} when σ lies in inertia). Ours: the local criterion in field-theoretic form,
  the multiquadratic case, Theorem B's exact 4 for K = ℚ(√3, √11) (Fischer's Theorem 10(i) gives only
  ≤ 4, on ℚ(√N) alone), the descent consequences, and the 2-adic reading of the classical 5-forcers.
  Open from his table: χ(ℚ(√11)²) ∈ {3, 4}, triangle-free. Note §10.1; handoff §4; Johnson DM 79 (the
  2-adic 2-colourings of ℤ₍₂₎ⁿ forbidding all √(p/q), p, q odd) is the lineage.

* **T22, closed (2026-09-06 ~03:00Z) — the dial read on C = ∅ objects.** [measured, complete] The forcing-
  critical sets F of the 1,953-point fabric for (35, 1859) and (813, 1939) are 7 and 5 vertices and
  DISJOINT (one 3-s forcing ask per vertex); hence U ∪ R₁U ∪ R₂U (5,857 points) has no critical vertex by
  the derivation C ⊆ F₁ ∩ F₂ (34/34 load-bearing deletions checked), and the two 1-minimal cores (588,
  543, overlap 31) give a 2,229-point union with C = ∅ measured on all 31. **Its exhaustive five-colour
  sweep: 0 forced-equal pairs, 0 virtual edges, complete (78 models, 38 calls, 31 s).** So the theorem's
  precondition is necessary, not sufficient; the live obstruction is the absorption principle
  (`plans/M54-five-colour-dial.md` §3 D2, §R7): a 4-colourable piece attached by outside-degree-one chords
  is coloured around by the spare colour. Also: the single-centre full-fabric union has C = F ∪ R(F)
  exactly (13 of 3,905); ν(H) = 38 exact, ν(W) = 1; the witness exact in K(√247); the F₂₄₇ cross lattice
  is the K-lattice's shadow (71 points, 20 fusions, 114 edges, two components) and moves the witness's
  critical set by three remote vertices. The big union's sweep continues as the scale twin.

* **T24 — The F₂₄₇ cross thickening frees the copy side only (M55, 2026-09-06).** [measured, exact]
  The depth-two cross-only glue census over the 1,175-point witness W = core₁ ∪ R(core₁) and its
  63-point depth-one pool adds 1,195 points (0.65 % of 345,704 cross pairs glue in-field; 309 fusions;
  64 % of the pool at total degree ≥ 5), and the criticality census of the grown stage on W's vertices
  reads 937 critical of 1,175 — **238 freed, every one in R(core₁), none in core₁** (M54's depth one had
  freed three, also copy-side). The construction is symmetric in the two cosets (glue points of (core,
  copy) pairs and their descendants), so the asymmetry must come from the rotation R = (119 + 3i√247)/128
  against the fabric's own ladder structure (T13: every unit edge of U lies on one of three direction
  families rotated by multiples of the Moser twist). Question: derive which coset the pool's unit edges
  favour and why; prediction to test: thickening both cosets symmetrically (the pool's image under R⁻¹
  adjoined) frees both sides. Falsifier of the reading: a depth-three census freeing core-side vertices
  without the symmetric adjunction. Data: `data/m55/cross-lattice-depth2-crossonly-W-core-8over3.json`,
  `data/m55/critical-W-plus-cross-depth2-crossonly.json`.
* **T25 — The ν = number-of-spindles law (M55, open).** [measured on three objects; a derivation waiting]
  On every spindle union built here a copy hangs on its fabric by its fused centre's neighbourhood plus
  ONE chord, the spindle chord, so `Absorb.extends_of_hubs` gives ν ≤ m (D5), and M54's C = ∅ gives
  ν ≥ 2: ν = 2 exactly on both two-spindle objects, ν ∈ [2, 3] on the three-spindle star. Conjecture:
  with pairwise-disjoint forcing-critical sets, ν = m outright. The cardinality ladder is unfit above
  ~2,000 points (its s = 1 rung exceeded 30 min on 2,229) and the hitting-set engine is untested beyond
  controls; the derivation should come first.
* **T26 — The additive localization, and K-fabric's 16-pair residue (M56, 2026-09-06).** [kernel for the bound;
  measured, exact] A homomorphism of a chunk's difference lattice into a group of order k, nonzero on the edge
  vectors, is a proper colouring (`Additive.lean`), so F_true ⊆ F_add := ∩ ker over admissible homs, and every
  difference in kΛ lies in F_add (L1); Kempe swaps of the additive colourings sharpen it to F_true ⊆ F_K (the swap
  on a component of the {a, a−c}-subgraph, whose vertices lie in one coset of Λ_c^φ = ⟨u : φ(u) = ±c⟩). On the
  1,953-point fabric at four colours: eight additive colourings (two residue, six ℤ/4-type), F_add = the pairs of
  2-adic depth ≥ 2 (2,513), F_K = 187, the dial's F_true = 171 — the 16 depth-3 pairs (13 at 64/9, 3 at 64/3)
  Kempe-forced under every additive colouring yet separated by the solver are the non-additive residue.
  *Question:* are those 16 separated by two swaps (a Kempe-graph walk from the eight colourings), and is every
  4-colouring of U Kempe-equivalent to an additive one? `data/m56/kempe-object-…-k4.json`.
* **T27 — The additive spindle theorem (M56 L8).** [derived; measured on both spindle witnesses] If (c, q) is
  additively forced on a fabric with q − c ∈ 4Λ and R is a rotation about c with |Rq − q| = 1, the chord vector
  (Rq − Rc) − (q − c) lies in 4Λ(union): every spindle over an additively forced pair puts its chord in 4Λ, so the
  union has no additive 4-colouring. Measured: the 1581's unique 4Λ unit vector is its single cross edge (11, 802),
  depth 2 (de Grey's forced distance 4 = 4u); W's is the spindle chord (565, 1152), depth 3 (8u/3 ∈ 8Λ);
  Heule-510 (a SAT-shrinking) keeps twelve 2Λ units and no 4Λ one; the 791-forcer has no additive 4-colouring by
  hyperplane cover. *Reading:* the additive theory reproduces the spindle mechanism exactly at the
  additively-forced level, which on K-fabric is depth ≥ 2 — one depth shallower than the truth.
* **T28 — The Exoo–Ismailescu seed's tightness is arithmetic, and G's colouring space is its additive family
  (M56 §R2).** [measured, exact; the paper re-read — no algebra in it] Over the seed's 21,787 non-adjacent pairs the
  unique pair identified by every ℤ/5-hom of its unit lattice is the forced pair (205, 206); every cheat and every
  pair at d² = 9, 16 is additively separated; 18 of the 35 five-colourings are additive and the other 17 have
  additive defect 1 (12) or 2 (5); Exoo–Ismailescu's G (205 points, exactly 18 five-colourings by their Claim 2.1)
  has exactly 18 additive colourings and they are its colourings. *Questions:* which lattice property makes every
  colouring additive (G has it, the seed nearly, U at four colours not at all); is a unit-distance chunk in a
  wall-broken field with that property buildable — that would be 5-tightness by arithmetic; are the seed's 17
  non-additive colourings Kempe-images of the 18.

### M57 (2026-09-06)

* **T29 — the reconfiguration graph of a forcing object.** The seed's 252-cheat subset forces (205, 206) with > 5,000
  colourings up to palette, one of them additive, in three defect regimes (≤ 14 / 16–28 / 94–105); H has 35, all within
  two single-vertex moves of its 18 additive ones. How many components does the move graph (single-vertex recolourings,
  Kempe swaps) of the 252-object have, and is the forced pair constant on each? Falsifier for "forcing is carried by
  finitely many Kempe classes": a component on which the pair takes both values. FS-2's re-aimed question.
* **T30 — 5-divisibility as a design invariant.** Which thickenings keep a chunk's joint lattice 5-indivisible (D1 of
  FS-6): the F₂₄₇ cross lattice does not (500 of W's units in 5Λ at depth one); in-lattice and new-direction points
  never cause it; rational points of order divisible by 5 do. Is the half-spindle closure of the 1581 5-indivisible at
  any radius holding new directions?
* **T31 — the loose-incidence count as a tightness gauge for CHEATS.** On the seed, G's cheats close every {a, b}-subgraph
  (γ 1,098 → 0) and H's attachment leaves 12; the 252-subset keeps the forcing with the family open. Does γ over the
  cheat set predict the size of the colouring space (35 vs > 5,000), i.e. is γ the dial the descent should have read?

### The finite-plane pivot (2026-09-06)

* **T32 — which finite planes refuse five colours, and is 11 the last 5-sealing prime? ANSWERED at M58 (2026-09-06):** every p ≥ 67 refuses five by Weil + Hoffman (λ(c) = −K(1, c/4)); 59 by its exact spectrum (5.022); 19 does NOT (χ(UD(𝔽₁₉,2)) = 5, measured) — so 11 is not the last 5-sealing prime in general, but for every field containing K it is the ONLY usable prime below 67, hence the only sealing prime: F ⊇ K is 6-open ⟺ the 2-adic wall is broken ∧ 11 is inert. 23, 31, 43, 47 are the remaining undecided planes (Hoffman floor 5; SAT in flight at the close). Original text: χ(UD(𝔽_p, 2)) is 3, 4, 5, 5 at
  p = 3, 7, 11, 13 (13 ≡ 1 mod 4: not usable). For the usable primes 19, 23, …, 83, 107, 131: the first p whose plane
  refuses five is the first prime that seals nothing; if every usable p ≥ 19 has χ ≥ 6, then for multiquadratic fields
  "6-open" is exactly "the 2-adic wall broken and some radicand a quadratic non-residue mod 11" — de Grey's field and K(√7) are
  open pending their planes (K(√35) is 11-inert but its 2-adic wall stands: χ = 4). FS-7.
* **T33 — the reduction as a kernel theorem. ANSWERED at M58 in its certificate form:** `UDCert.drawing_adj` (any commutative ring, any subring of the tower with a hom, an inverse of the denominator), `chromaticNumber_finitePlane11 = 5`, `chromaticNumber_heule510 = 5`; the field-level statement (integrality of unit vectors at the primes above 11) stays a hand argument, priced in `plans/M58-field-sieve.md` §S3. Original text: The homomorphism for a SPECIFIC certified graph is a decide over its edge
  list (Heule-510 → UD(𝔽₁₁,2): 2,504 checks), and χ(UD(𝔽₁₁,2)) = 5 follows in the kernel from the 121-point colouring plus
  Heule-510's certified refusal of four colours — no LRAT. The GENERAL statement "χ(ℚ(√3,√5,√11)²) ≤ 5" quantifies over all
  finite unit-distance graphs in the field and needs the integrality of unit vectors at the inert prime (a valuation
  argument); priced in FS-7 phase C.
* **T34 — the shadow sieve as a dial on the closure. PARTLY ANSWERED at M58:** the spectral floor of the 1581's 55-direction shadow at 131 is 4.96 (≥ 5 only) and at 479 4.32; the gen-1 closure's shadow at 131 is the whole plane (≥ 8) and at 479 has floor 8.38; whether the 1581's shadow is 5-chromatic (P7) is a 17,161-vertex SAT question, in flight at the close. Original text: At p = 131 the 1581's directions reduce to 55 of the circle's 66
  residue pairs and its gen-1 closure's to all 66; at 479, 64 and 210 of 240. The closure's shadow at 131 is the whole
  plane; is the 1581's own 55-direction shadow 5-chromatic (P7 of FS-7)? If so, no 6-forcer uses only the 1581's
  directions, and a 6-forcer in de Grey's field needs new directions — which ones, i.e. which direction sets D have
  χ(Cay(𝔽₁₃₁², D)) ≥ 6: a design vocabulary computed without geometry.
* **T35 — the topological bound of the 791-forcer.** V ∩ −V of the 1581 is centrally symmetric (a free ℤ₂-action); its
  neighbourhood complex is, by FS-9's D1, homotopy 2-dimensional (bound ≤ 4); what is its box-complex coindex?
* **T36 — the Nullstellensatz degree of the certified cores.** The spindle at 3 colours, the 9-core and 122-core at 4, the
  23-core at 6: the least degree of a polynomial-identity refutation — does it read the integrality gap (the 23-core's
  χ = ω + 3) where the relaxations read nothing?

* **T37 — can a 6-critical subgraph of a finite plane be lifted to the field?** A lift of H ⊆ UD(𝔽_p,2) — one point of F² per
  vertex, in its residue class, every edge unit — is a copy of H in F², so a lifted 6-critical subgraph of UD(𝔽₁₃₁,2) would be
  a 6-chromatic unit-distance graph. The system is overdetermined (|E| ≥ 5|V|/2 quadratics in 2|V| unknowns); the local
  𝔭-adic test (Hensel) decides cheaply whether any core can lift. FS-11.
  **ANSWERED IN PART at M59 (2026-09-06).** The lift is a first-order rigidity problem: modulo p² it exists iff the defect pairs
  to zero with every self-stress of the residue framework (kernel: `Lift.lean`), and for a framework rigid at its residues a
  Laman basis Hensel-lifts uniquely up to isometry, the remaining edges decide at a finite level, and a local lift is ALGEBRAIC —
  its field has an unramified degree-one prime above p; real iff that field has a real place. A 6-critical H carries ≥ |V|/2 + 3
  independent first-order conditions, so it lifts only if it is a shadow; the finite plane's own 6-forcing gives no reason it
  should be. The lift needs an UNRAMIFIED prime (at 11 the spindle and Heule-510 are provably not ℤ₁₁-lifts). Measured: the 1581
  is recovered from its residues at 131 to 131²⁰; its merged image is obstructed (a 48-edge witness, in the kernel); the 6-critical
  cores at 131 were not reached (the whole plane at k = 5 undecided at one hour — FS-13). Open: whether ANY 6-critical
  subgraph of any finite plane is a shadow — no mechanism suggests one, and the count says a random one is not.
* **T38 — the exact values χ(UD(𝔽_p,2)) at p = 23, 31, 43, 47, and the growth law.** The values known: 3, 4, 5, 5 at 3, 7, 11,
  19; ≥ 6 from 59 on by the spectrum. Is the sequence monotone in p? Does χ(UD(𝔽_p,2)) − Hoffman(p) stay bounded (Hoffman is
  tight for very regular graphs; the planes at 11 and 19 sit 1.5 and 1.4 above it)? The instrument is `fplane.py chi` with
  the clique pin; 23 and 47 (ω = 3) may need cube-and-conquer.

* **T39 — what configuration are the 1581's hubs a piece of?** (M59.) The finite plane finds 3,739 exact points of ℚ(√3,√5,√7,√11)²
  at unit distance from 3–13 vertices of de Grey's 1581 (none in its half-spindle closure; the count at 479 and the intersection
  with 131 are FS-12's completeness check), and 1,171 for Heule-510 of which 11 are Heule-553's discarded vertices. De Grey's
  construction is a Minkowski-sum-and-shrink; are the hubs the discarded points of the un-shrunk sum (then their count and
  supports are computable from the construction, and the scan is a derivation check), or new coincidences of the partner lattice?
  Either way: the object the 1581 is a piece of, with its hubs restored, is a 5-chromatic unit-distance graph with far more
  redundancy (M54's dial) — and the hub scan is its constructor.
* **T40 — the lift at the unramified primes, the sieve at the ramified one.** (M59.) For fields over K the sealing prime 11 is
  ramified and never a lift's prime; 83, 107, 131 are lift primes and none seals. Is that a coincidence of K, or a rule — does a
  sealing prime of a field always fail to be a lifting prime of its objects (a sealing plane's colourings are too free to be a
  shadow's colourings)? FS-14's F₁₁/S₁₁ is where the answer starts.

* **T41 — is any finite Euclidean plane exactly 6-chromatic?** (FS-15's first digit.) The values known: 3, 4, 5, 5 at 3, 7, 11,
  19; the planes at 23, 31, 43, 47 (floors 4.0–4.7) and 59, 67, 79, 83 (floors 5.0–5.7) undecided at four solver-hours each;
  from p ≈ 100 every plane is ≥ 7. Under tightness a plane at exactly 6 names, by congruences, a field that hosts a 6-chromatic
  unit-distance graph; no plane at 6 says the answer to Hadwiger–Nelson is never 6. The instrument is cube-and-conquer over a
  neighbourhood's colourings, or an exact count through the torus structure (T38, FS-13 D1).
* **T42 — is de Grey's field's plane 7-chromatic?** (FS-15's bold form.) Its local bound is 8 (first usable prime 131) and the
  hexagonal cap is 7; tightness in its bold form says χ = 7 there, i.e. χ(ℝ²) = 7. A 6-colouring of that field's plane would
  refute the bold form and be the first colouring of a field plane that is local at no prime — the genre the upper-bound side
  needs either way.

* **T43 — is the sealing plane's arity floor 4 or 5?** (M60.) `arityFloor(UD(𝔽₁₁,2), 5) ∈ {4, 5}`: `≥ 3` and `≤ 5` in the kernel,
  no arity-3 compulsion by verified colourings (31,602 questions). Arity 4 is 4.2 million questions through the origin — the mask
  engine's size. De Grey's witness sits at the same bracket (M48); a plane at exactly 4 would be the first object anywhere with a
  compulsion strictly below the degree bound.
* **T44 — why do the theorem-admitted five-colour candidates concentrate at residue norm 1?** (M60 §R3, FS-16.) Of M55's 86
  undecided asks on the grown witness, 51 have residue difference of norm 1 at 11 — the residue-allowed class — against a uniform
  1/11; they are 41 distinct exact squared distances, 41 of them cross–cross pairs. If structural (the critical-set localization and
  the residue theorem selecting overlapping populations), the residue filter is weakest exactly where the localization admits.
* **T45 — the 19 → 23 cliff.** (M61 §R5.) The 5-colouring at 19 (361 vertices) took 18 s and an independent set of 76 (21 %) 200 s;
  at 23 (529 vertices) neither a 5-colouring (4 h, pinned clique) nor an independent set of 106 (20 %, 2 h) returned. ϑ = Hoffman at
  both, ω = 2 at 19 and 3 at 23. Is the cliff the value (χ(23) = 6 and the instances are refutations in disguise) or the encoding (a
  symmetric or cube-split instance decides in minutes)? FS-17's first phase.
* **T46 — is any finite Euclidean plane exactly 6-chromatic?** (M61, the conjecture's first digit.) Candidates 23, 31, 43, 47 (χ ∈ {5, 6}),
  59, 67, 79, 83 (≥ 6). Under T1 a plane at 6 names the 6-chromatic fields by congruences; none at 6 (all small planes 5, all others ≥ 7)
  says no field plane is exactly 6-chromatic. G48 decouples this from the mechanism: the answer is integrality-carried.
