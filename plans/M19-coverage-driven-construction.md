# M19 — Coverage-driven construction, and the colourings as objects (stub)

*Carry-forward notes, written 2026-08-03 as M18 closed. Not yet subplanned. Direction agreed
with Kooshi 2026-08-03: the lower-bound hunt stays the spine, and the χ = 5 perspective rides
along for nearly free — the separating colourings our instruments already produce are local
fragments of hypothetical plane 5-colourings, and M19 §0 studies them as objects for the
first time.*

## 1. The inheritance from M18 — what this milestone stands on

* **The objective function is a theorem.** `Fan.of_coverage` / `fan_iff_coverage`
  (`Proofs/HadwigerNelson/Coverage.lean`): a pivot is fanned by its class **iff** every
  proper 5-colouring puts all 5 colours on `N(p) ∪ C`. Confinement = `minCov = 5`, measured
  by `tools/coverage.py`.
* **The starting position is known exactly.** Both ℤ/3 closures sit at `minCov = 3` — the
  rainbow floor their triangles guarantee, with `N(p)` contributing *nothing* — and the full
  4,615-pivot sweep of a closure finds `minCov ≤ 3` everywhere ({2: 598, 3: 4,017}). The
  constructive problem: **force two more colours onto a pivot's unit-neighbourhood whose
  1/3-class is closed.** Nothing about deletion or class-internal enrichment can help
  (`FanMono.lean`, `not_fan_classOnlyGraph` — both kernel-checked).
* **The one phenomenon measured to act at a distance: mechanism (b).** M18's resist join
  split M17's histogram: (a) in-class colour budget (1/3's triangles, 178 calls; r²=3's
  paths, 46) and (b) **ambient near-forcing at structureless classes** — the top irrational
  resisters (2−⅓√33: 34 calls, 7/6−⅙√33: 22, 3/2∓⅙√33: 21+19) have *zero* in-class edges;
  the ambient graph correlates their members' colours with the pivot's. A member fully
  forced would BE confinement (M13's `Forces`), so these classes sit near that cliff. This
  is the tool to point at `N(p)`.

## 2. §0 measurement obligations (next round, before specifying)

1. **The colourings as objects — the χ = 5 lens, near-free.** The pool from one closure
   sweep holds 3,054 proper 5-colourings of a 4,678-point graph; nothing has ever *looked*
   at them. Measure: colour-class sizes/densities; how classes distribute over the rainbow
   triangles (which 3-subsets of 5 colours appear on triangles, and how the leftover pair
   is used); spatial structure (periodicity/quasi-periodicity against the known lattice
   vectors, √33-vector correlations); and whether structure *tightens* as graphs grow
   (compare de Grey → closure → any M19 candidate). A property forced in every 5-colouring
   of every large candidate is simultaneously (i) the thing a 6-chromatic construction must
   break and (ii) a brick in the χ = 5 structure theory. Literature numbers to re-derive
   before use, not trusted from memory: the measurable unit-avoiding density record
   (≈ 0.247?) and the fractional-χ cap (≈ 4.36?).
2. **Characterize mechanism (b).** For the top structureless resisters at a pivot: measure
   the *forcing margin* per member (how many of the pool's colourings give the member the
   pivot's colour; SAT-check whether any colouring separates a chosen member — `forcer.py`'s
   vocabulary already asks this per pair). Identify the ambient subgraphs that transmit the
   correlation (candidate: the √3-rhombus/H-lattice seams — √33 = √3·√11 suggests the two
   generator scales interacting). The deliverable is a *named* forcing gadget, not a
   histogram.
3. **Coverage-target design experiments, cheap tier.** Before any big candidate: take the
   closure, union it with small gadgets aimed at `N(630)` (spindled copies pinning
   neighbourhood vertices; second closures at other pivots of `N(p)`; mechanism-(b) seams
   relocated to touch `N(p)`), and watch `minCov` per edit. The instrument answers in ~3 SAT
   calls warm; the experiment loop is minutes per idea. §0 decides which gadget family, if
   any, moves 3 → 4; the milestone proper industrializes whatever moves.

## 3. Candidate deliverables (to be refined at subplanning)

1. **A candidate with `minCov = 4` somewhere** — one colour from confinement, with the SAT
   hunt for the last colour then a targeted (cube-split) search, not a sweep. Stretch: 5.
2. **The colouring-structure instrument** (`tools/` + ledger discipline): pool statistics as
   first-class, versioned measurements.
3. **The forcing-gadget lemma** — whatever mechanism (b) turns out to be, stated and
   kernel-checked at the level M18 set (small, exact, no purchases).
4. **If everything pins to the floor**: the honest write-down of a coverage *ceiling*
   conjecture for the construction algebra — the barrier-theorem thread, promoted from
   consolation to finding if the measurements say so.

## 4. Strategy decisions recorded 2026-08-03 (Kooshi agreed)

* **Spine**: coverage-driven hunt; the colouring-mining rides in §0 on existing instruments.
* **Designated perspective shift, when coverage goes flat across families**: the certified
  6-colouring angle (Hoffman–Soifer-style parameter ranges, periodic exact geometry — our
  toolkit's natural upper-bound purchase). Not before.
* **Parked, with reasons**: fractional route to ≥ 6 (provably capped below 5 — instrument
  only); measurable ≥ 6 (single-class density provably insufficient; multi-class SDP is the
  wrong toolkit today — noted: rational SDP dual certificates are kernel-checkable data,
  someday); axiom-sensitivity (Shelah–Soifer — native medium, but perspective without
  progress until another angle feeds it).
* **Rotation policy**: rotate on measurement (an angle gone flat), never on cadence;
  perspectives must share instruments so knowledge compounds.

## 5. Operational rules in force (unchanged, recorded in CLAUDE.md)

All builds through `scripts/build.sh`; on any segfault halt and report immediately; one heavy
job at a time; write-up and `lean4checker` replays deferred indefinitely (publication gates);
`tools/` untrusted; a `minCov = 5` reading becomes a claim only through M16's kernel route.
