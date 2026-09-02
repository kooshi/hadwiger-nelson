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

* **T13 — the direction ladder** [measured on ONE halo; registered for replication as M52 P1].
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
