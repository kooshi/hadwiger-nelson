# M21 — Coupled circle systems

*Subplanned 2026-08-05 (desktop, 32 cores). Replaces the stub written at M20's close. The
mission: the one-pivot cap (M20) proved the 5th colour needs structure spanning ≥ 2 pivots;
this milestone studies the smallest such structure — two pivots' circle systems and the
chords that couple them.*

## 0. Measurements first

Predictions were registered in the session scratchpad (`m21-predictions.md`) before each
instrument ran; §0-D's block was registered after §0-A's census (which named its object)
and before any §0-D code existed. All §0 artifacts are UNTRUSTED tools-side triage
(`build/m21-*.json`); nothing here is a claim until the kernel route re-derives it.

### 0.1 The instruments

| Instrument | What it measures | Artifact |
|---|---|---|
| Coupling census (`m21census.py`) | For every pivot pair of the closure (n=4678, 24,405 edges): cross-chord count between cover sets, exact d², far/near split (far = disjoint cover sets) | `build/m21-census.json` |
| Periodicity probe (`m21phase.py`) | Exact multiplicative-relation search `u^{2m}σ^lζ₆^k = 1` (u = coupling phase, σ = the M19 seam), \|m\|,\|l\| ≤ 6; annulus table per circle pair; is d in the field | `build/m21-phase.json` |
| Joint profile (`m21joint.py`) | At the strongest-coupled far pair + a zero-coupling null pair: sampled pattern pairs (π_a pinned, π_b as a partition — π_b's palette stays free because π_a's pinning spends the colour symmetry), one SAT verdict each at k=5; k=3 kill-path control | `build/m21-joint-695-2044.json` |
| Pair-system probe (`m21pair.py`) | The d = 1 two-pivot system generated exactly in the seam field ℚ(√3,√11): the coupled chord lattice (six moves, memberships re-derived at insertion), every exact unit pair, SAT at k = 4 (k = 3 control must be UNSAT) | `build/m21-pair-d1.json` |
| Kill verifier (`m21verify.py`) | Every sampled joint kill re-tested through an independent formulation (π_b's concrete colour injections through M20's validated pin-only path); the k=3 SAT-layer control the local checker had short-circuited | `build/m21-verify-695-2044.json` |
| Mesh scan (`m21mesh.py`) | Sector-colouring meshability at d = 1: continuous-ψ sweep × reflection × palette injection against 4,000-sample cross-chord curves and the glue points, layered so the killing constraint family is named | stdout (triage) |
| Floor check (inline) | Coupled coverage floor: forbid-last-t on S_a ∪ S_b, coupled and null pairs | stdout (triage) |

### 0.2 Predictions vs outcomes

| # | Prediction (registered) | Outcome | Verdict |
|---|---|---|---|
| A1 | d² spectrum concentrated: ≥ 60% of weight on ≤ 10 values | top-10 share **39.0%** — broad spectrum, 3,585 d² classes | **refuted** |
| A2 | max coupling at a near pair, d² ∈ {1/3, 1}; far max ≥ 8 and < half near max | near max 181 chords (at d² ∈ {1/3,1}: confirmed by class table); far max **40** at **d² = 1** ≥ 8 ✓, < 90 ✓ | confirmed |
| A3 | d² = 1/3 and 1 in top-3 classes by total weight | top-3 by weight: **1** (1.24M), **1/3** (916k), 5/3 (403k) | confirmed |
| A4 | pivot count ~3,000 in [1000, 4678] | **4,615** of 4,678 — nearly every closure vertex is a pivot | interval ✓, estimate low |
| C1 | unit-distance pairs: lattice relation found for some | **NONE** — even closure edge directions are not ⟨ζ₆,σ⟩-words to exponent 6 | **refuted** |
| C2 | strongest far pair: no relation (incommensurate strips) | NONE at every probed pair (d² = 1, 1/3, 5/3 ± (2/9)√33) | confirmed |
| C3 | ≤ half of top-10 d² are field squares | d² = 1, 1/3 rational squares; the √33 family's squareness untested (u² trick used throughout) | as designed |
| B1 | zero joint kills at k=5, coupled and null; no hardness gap | **785/1500 (52%) killed by cross chords alone (local), then 229/715 (32%) of the locally-feasible KILLED by the ambient graph**; 0 unknown; null pair 1500/1500 sat, 0 conflicts. Kills re-verified: 25/25 sampled confirmed through the independent pin-only injection encoding (0 false kills, ~2.2 valid injections per instance, all refuted). **The first nonzero extension pressure this project has ever measured.** | **REFUTED** |
| B2 | k=3 control kills everything; local-checker Hall control | local checker caught all 20 k=3 instances *before* SAT (an unplanned control path); the SAT-layer unsat path validated separately: 5/5 pin-only k=3 instances unsat through the solver; Hall-violation control ✓ | confirmed (route amended) |
| D1 | pair system at d=1 stays 4-colourable at sample scale (LOW-MEDIUM confidence — first live-fork measurement of the milestone) | SAT at every depth: 580 pts/1,729 edges (depth 12), 1,444/4,321 (30), 2,884/8,641 (60) — k=4 sat instantly each time; 8 glue points found, ~1 exact cross chord per point (2,893 at depth 60) | confirmed |
| D2 | if SAT, model is not sector-structured | stronger: **NO pair of M19 sector colourings meshes at d = 1 at all** — 0 of 48 (reflection × palette-injection) combos × full continuous ψ sweep survive even the outer–outer curve family alone (69,113 of 69,120 first-violations are oo); glue constraints also independently infeasible | confirmed, sharpened |
| D3 | k=3 control UNSAT (9-point witness present in each half) | unsat at every depth ✓ | confirmed |
| — | coupled coverage floor (unregistered follow-up, measured after B): does coupling raise the union's floor above the singles' rainbow floor 3? | floor(S_a ∪ S_b) = **3** at the coupled pair AND the null pair (forbid-last-t method, t* = 2 both) — coupling is pattern-selective, not floor-raising | measured |

### 0.3 What the measurements name

1. **Coupling is generic, not special.** 4,615 of 4,678 closure vertices carry a 1/3-class;
   1.11M pivot pairs are coupled; the d² spectrum is broad (A1 refuted). There is no
   distinguished "spindle distance" to hunt at — the closure couples everything to
   everything at short range.
2. **The far-coupling spectrum lives in the seam's field.** The top twelve d² classes by
   far-pair weight are ALL of the form r + s·√33 (r, s rational) — pivot separations in
   the closure are organized by the seam lattice ℚ(√33), M19's "resistance family"
   reappearing as the geometry of pivot pairs. The individually strongest far pairs sit at
   **d² = 1** (40 cross chords between two cover sets) and d² = 1/3 (34).
3. **The naive coupled automaton is dead, by exact arithmetic.** No multiplicative relation
   `u^{2m}σ^lζ₆^k = 1` exists at any probed pair within the bound — the coupling phase is
   incommensurate with the strip lattice everywhere, including at d² = 1. Two coupled
   strips do NOT form a finite-state product system on the naive quotient; M20's transfer
   structure does not extend by tables. (The stub's "classify which" — answered: none.)
4. **The canonical coupled object is the unit-distance pair.** Strongest far coupling;
   each pivot lies ON the other's outer circle; the whole four-circle system lives in the
   seam field ℚ(√3,√11) — and its eight circle-intersection points are generated by the
   strip's own operators applied across systems: outer∩outer = the partner pivot's
   hexSteps, outer∩inner = seam images, inner∩inner = one new direction ⟨1/2, ±√3/6⟩
   (a scaled 12th root of unity — the half-sector direction). All four annuli admit cross
   chords at every probed d (every circle pair couples).
5. **The coupling exerts real, selective pressure — the hunt's first nonzero gradient.**
   At the strongest coupled pair, half of all pattern pairs die on the 40 cross chords
   alone and a third of the survivors are killed by the ambient graph (all verified
   through an independent encoding; the null pair is perfectly flat). Yet the pressure
   is *selective*, not aggregate: the union's coverage floor stays at the singles'
   rainbow floor 3, and the pair system itself stays 4-colourable at every affordable
   sample depth. The 5th colour is not hiding in one coupled pair at closure scale —
   but the coupled-pattern space is the first place the ambient graph has ever pushed
   back, and each of the 229 kills is already in kernel-certifiable shape (a pin-cube
   UNSAT, exactly `Fan.of_unsat`'s cube form).
6. **No sector colouring survives the pair.** The mesh scan kills the entire M19
   sector-colouring family for the d = 1 pair — under every relative rotation
   (continuous ψ), reflection, and palette injection, the outer–outer cross-chord
   family alone always produces a monochromatic unit chord. So the pair probe's
   4-colourings are necessarily non-sector, and any χ ≤ 4 proof for the continuum
   pair needs a construction shape this project has not yet seen. Caveat held
   honestly: the probe's lattice is move-closed but NOT cross-partner-closed (partners
   generically leave ℚ(√3,√11) — one square root per partner generation), so D1's SAT
   readings sample the continuum thinly; the χ question for the full pair system is
   OPEN in both directions.

### 0.4 Incidents

* The census's first run compared a list against a tuple (`distsq` returns a list) and
  found zero pivots; cost one 3-minute rerun. The joint profile's first run passed
  already-local indices through a second reindex (`induced` reindexes internally) and
  crashed on a KeyError before any SAT call; cost one relaunch. Neither touched the
  machine; both are the class of bug the self-test-and-refuse discipline exists for, and
  the promoted instrument (§4) carries regression checks for both.
* No OOM, no crash, one heavy job at a time throughout; enumeration caps mandatory
  everywhere (`enum_canonical` refuses by name; the pair probe's frontier cap reports
  when it cut).

## 1. The object, reframed by measurement

The stub asked four questions; §0 answered three and reshaped the fourth:

* *Which d couple, with what structure?* — All short d couple (annuli open below
  d = 1 + r₁ + r₂ per circle pair); the far spectrum is the ℚ(√33) family; the strongest
  and most canonical coupling is d = 1.
* *The coupled automaton?* — Not finite-state (incommensurability, exact). The coupled
  system must be studied on the exact point lattice, not a label quotient.
* *The hunt question at closure scale?* — Answered with the project's first nonzero
  pressure reading: coupling kills 52% of pattern pairs locally and 32% of the rest
  ambiently, verified; but selectively — no floor raise, no χ jump at sample scale.
* *The Lean side?* — reshaped to the d = 1 pair system (below).

**The d = 1 pair system.** `pairSystem p q = system p ∪ system q` with `dist p q = 1`,
where `system p = insert p (sphere p 1 ∪ sphere p (√3/3))` is M20's cap object. Facts
that make it the right first target: χ ≥ 4 immediately (cap + monotonicity); each pivot
is a vertex ON the partner's outer circle, so the systems interlock through the M20
compulsion machinery (hexStep, seamImage) with no new analytic apparatus; the coordinate
field is the seam field; and the χ question is a genuine two-sided fork:

* **χ(pairSystem) = 4** would be the *two-pivot cap* — the barrier theorem extended one
  rung, naming precisely what the 5th colour still lacks at two pivots.
* **χ(pairSystem) ≥ 5** would be a two-point, four-circle, continuum χ ≥ 5 witness —
  qualitatively smaller than any known finite witness (de Grey: 1,581 vertices), and
  new mathematics outright.

§0-D read the fork tools-side: 4-colourable at every affordable depth (so no cheap ≥ 5
witness exists in the move-closed lattice), while the mesh scan killed every known
explicit-colouring shape for the ≤ 4 direction. **The milestone therefore takes neither
branch as its headline**: the χ of the pair system is carried as measured-but-open, the
committed Lean core is the fork-independent structure (§2.1–2.3), and the fork's two
branches are named stretch goals with their gates (§2.4).

## 2. The Lean targets

*(Skeleton in `Proofs/HadwigerNelson/Coupled.lean`; every statement `sorry` at subplan
commit; shapes below are pre-modeling drafts, reforged by the three passes.)*

### 2.1 The gluing classification (fork-independent)

Four lemmas, one per circle pair, each an equality of sets with explicit two-point
right-hand sides, all witnesses one strip operator applied across systems:

* `outer_inter_outer : sphere p 1 ∩ sphere q 1 = {hexStep p q, hexStepConj p q}`
* `outer_inter_inner : sphere p 1 ∩ sphere q (√3/3) = {seamImage q p, seamImageConj q p}`
* `inner_inter_outer` — the swap image of the previous
* `inner_inter_inner : sphere p (√3/3) ∩ sphere q (√3/3) = {p + ζ₁₂/√3·(q−p), conj}`
  (the new half-sector direction; `ζ₁₂/√3 = ⟨1/2, √3/6⟩`)

with `hexStepConj`/`seamImageConj` the conjugate-rotation companions (two small defs).

### 2.2 The interlock lemmas (fork-independent)

* `pivot_mem_outer : dist p q = 1 → q ∈ sphere p 1` (and the swap) — the pair premise
  restated as membership;
* `seamImage_interlock : seamImage p q ∈ sphere p (√3/3) ∩ sphere q 1` — the seam of one
  system lands on the other's outer circle (conjunction of two M20 lemmas, newly named
  because the pair reads it as structure).

### 2.3 The lower bound (fork-independent)

* `four_le_chromaticNumber_pairSystem : dist p q = 1 →
   4 ≤ ((unitDistance ℂ).induce (pairSystem p q)).chromaticNumber`
  — cap + chromatic monotonicity under induced-subgraph inclusion (comap of the
  inclusion, M19's pattern).

### 2.4 The headline question, carried open (the fork's resolution)

The fork did not resolve to a cheap branch; the honest state, with each branch's gate:

* **χ(pairSystem) ≤ 4 (the two-pivot cap)** — blocked on a construction: the sector
  family is dead (§0.3 item 6 — the risk named at registration materialized in its
  strongest form: not merely "no mesh at 72 combos" but no mesh at any continuous
  offset, killed by the outer–outer family alone). The gate to reopening: a non-sector
  explicit 4-colouring found by structure inspection of the probe's models or by
  construction (the strip's window-extension freedom is the one known source of
  non-sector colourings). Until then: no Lean statement is committed.
* **χ(pairSystem) ≥ 5 (the continuum witness)** — blocked on evidence: every sampled
  finite sub-lattice is 4-colourable. The gate to reopening: a partner-closed sample
  (adjoining cross-chord partners, one √-extension per generation — the named
  enrichment) going UNSAT at k = 4. Until then: no Lean statement is committed.
* **The candidate second theorem in reach now — the mesh barrier**: "no pair of
  rotated/reflected/re-paletted M19 sector colourings is proper on the d = 1 pair" —
  the two-pivot analogue of M19's local-barrier theorem (it names why the pair is
  rigid). Cost warning: the honest statement quantifies over a continuous offset and
  needs the cross-chord curves' sector coverage in Lean — an analytic reduction plus a
  finite decide core. The domain-modeling pass decides whether a clean finite statement
  exists; if it does not shape well, the mesh impossibility stays a tools-side triage
  fact and the milestone's Lean content is §2.1–2.3.

### 2.5 Deferred with reasons

* **The incommensurability theorem** (the Lean face of §0-C): the honest statement — the
  cross-chord partner map leaves the pair lattice / no relation `u^{2m}σ^lζ₆^k = 1` —
  needs a shape the modeling passes must find (the naive ∀-statement quantifies over a
  group we have not defined in Lean). Deferred to a named slot; if the passes do not
  produce a clean statement it moves to M22 with this note.
* **General-d classification** — parked (Frontier path 4 unchanged): the d = 1 case
  carries the milestone; the ℚ(√33) family census names which d matter next.

## 3. Module and shape decisions

### 3.1 Domain-modeling pass (2026-08-05)

* **The reflection is the model.** The skeleton's three conjugate-companion constants
  (`zeta6Conj`, `seamRatioConj`, `iiRatioConj` + their step versions) were one role
  unnamed: reflection across the pivot axis. Replaced by ONE operator
  `reflAcross p q z = p + (q−p)²·conj(z−p)` — an involutive isometry fixing both pivots
  (exactly at `dist p q = 1`, the module premise; verified numerically on 200 random
  configurations before committing). Every gluing pair is now `{X, reflAcross p q X}`,
  and every ±-branch fact is the +-branch fact plus one isometry application.
  Alternative weighed: componentwise conj constants (M20 house style for single
  constants) — rejected because six defs collapse to one and the isometry buys the
  mirror memberships wholesale. Confidence high.
* **Gluing statements: three set equalities + one swap corollary**, heterogeneous
  witnesses (`hexStep p q`, `seamImage q p`, `seamImage p q`, `p + innerGlueRatio·(q−p)`)
  — a uniform "crossImage" family was weighed and rejected: the finding IS that the glue
  points are the strip's existing operators, and a fresh 3-case def would obscure it.
  `inner_inter_outer` is stated (consumer surface) but derived from `outer_inter_inner`
  by the p↔q swap + `Set.inter_comm`.
* **`innerGlueRatio` stays an explicit-component constant** `⟨1/2, √3/6⟩` (M20's
  seamRatio precedent: components make every norm fact arithmetic); its `ζ₁₂/√3`
  identity is a comment, not a def.
* **The lower bound is superset-quantified** (the M20 lesson):
  `four_le_chromaticNumber_of_system_subset : system p ⊆ D → 4 ≤ χ(induce D)`, with the
  pairSystem form a term-mode corollary (it already closes off `Set.subset_union_left`
  in the skeleton — zero sorries spent).
* **`system`/`pairSystem` are named set defs downstream of M20** (M20 modules settled,
  nothing upstream edited; the cap is re-stated in Coupled's vocabulary as a one-line
  bridge when needed). `pairSystem` stays a binary union — an indexed ⋃ over pivot sets
  was weighed for M22's three-pivot future and rejected as speculative structure before
  a second use.
* **The mesh-barrier theorem does NOT shape well**: its honest statement quantifies over
  a continuous offset ψ, and the finite sector-table core only connects to the geometry
  through curve-coverage intervals (arccos monotonicity, interval images) — analytic
  machinery, high cost, negative-knowledge payoff. It stays tools-side triage; the plan's
  §2.4 third bullet resolves to "no clean shape".
* Skeleton after the pass: 13 sorries (reflection package 6, interlock 2, gluing 4,
  superset lower bound 1); elaborates clean.

### 3.2 Obligation-modeling pass (2026-08-05)

* **The χ-monotonicity route is a citation, not a derivation**: Mathlib's
  `SimpleGraph.Colorable.of_hom` (Coloring/Vertex.lean:297) composed with `induceHom
  Hom.id` (Maps.lean:577, `MapsTo` from the subset premise) transports 3-colourability
  from `induce D` down to `induce (system p)`; then M20's headline route (by_contra +
  `chromaticNumber_le_iff_colorable` + `Order.le_of_lt_add_one`) closes against
  `concentric_not_colorable_three` — `system p` unfolds definitionally onto the cap's
  inline set, so no bridge lemma is needed.
* **The ⊆ spine of all three gluing lemmas is minted once** (the repeated-simp-chain
  smell, prevented): `unit_frame` (a point on both spheres = `p + v·(q−p)` with both
  norms of `v` pinned — the frame move is `·conj(q−p)`, norms preserved because the
  axis is a unit), `re_of_norms` (`v.re = (1 + r₁² − r₂²)/2`), `im_sq_of_norm`
  (`v.im² = r₁² − v.re²`). Each classification instantiates radii — oo: re 1/2,
  im² 3/4 (= ζ₆); oi: re 5/6, im² 11/36 (= seam ratios); ii: re 1/2, im² 1/12
  (= innerGlueRatio) — then `Complex.ext` on the two sign roots, mirror branch via the
  verified identity `u·conj(ratio) = reflAcross`-image. The ⊇ directions are M20 dist
  lemmas (`hexStep_mem_sphere`, `dist_self_hexStep`, `dist_seamImage_pivot`,
  `dist_self_seamImage`) plus the reflection package.
* **The reflection package computes in norms, never components**: isometry =
  `‖(q−p)²·conj(z−w)‖ = ‖q−p‖²·‖z−w‖`; fixes/involution = `mul_conj` +
  `normSq (q−p) = 1`. Two private premise-conversion lemmas (`norm_q_sub_p`,
  `normSq_q_sub_p`) are the engines.
* **A dead hypothesis was deleted** (the mutation audit run at design time):
  `reflAcross_pivot_left` needs no distance premise (`conj 0 = 0`).
* **A missing child was forced by the swap corollary**: `reflAcross_swap`
  (`reflAcross q p = reflAcross p q` under the premise — their difference telescopes to
  `(p−q) + (q−p)·normSq(q−p) = 0`); with it, `inner_inter_outer` is
  `Set.inter_comm` + `outer_inter_inner q p` + one rewrite.
* **Prove/test/assume partition**: 19 proof obligations (13 statements + 6 spine/premise
  children); 2 spec examples (premise non-vacuity `dist 0 1 = 1`; the adversarial
  member `1 ∉ oo-gluing set` — pins that the classification really is two points);
  the assumption `dist p q = 1` stays per-statement (no section variable — the
  experience pass may revisit). Skeleton: 21 sorries, elaborates clean.
* **Mutation audits scheduled for implementation**: drop `h` from
  `reflAcross_pivot_right` (must break), add a third point to a gluing RHS (must break
  ⊆), swap `seamImage q p` for `seamImage p q` in `outer_inter_inner` (must break).

### 3.3 Experience-modeling pass (2026-08-05)

* **`pivot_mem_outer` deleted**: it was `Metric.mem_sphere'.mpr h` wearing a fresh name —
  an alias `exact?` users must wade past, teaching less than the Mathlib lemma the
  search already finds. The module doc points at `mem_sphere'` instead. (Alternative:
  keep for narrative — rejected; one unrequested byte.)
* **Zero simp tags**, the M19/M20 house precedent upheld: `reflAcross_pivot_left` was
  the only safe candidate (hypothesis-free, normalizing) but the repo's domain simp-set
  is deliberately empty and automation here closes with cited leaves; the
  hypothesis-carrying involution/isometry lemmas as conditional simp lemmas would
  silently never fire (side condition not simp-normal) — a tag that implies usability
  it doesn't have.
* **Names kept**: `reflAcross` (Mathlib's `EuclideanGeometry.reflection` weighed —
  affine machinery for a module that computes in ℂ norms; the doc names the deliberate
  avoidance), `reflAcross_reflAcross` (the `conj_conj` involution convention),
  `dist_reflAcross`/`_mem_sphere_left/right` (house `dist_seamImage`/`hexStep_mem_sphere`
  precedent), the four gluing names (domain vocabulary, namespace-disambiguated;
  `rw?`/`exact?` find by shape, not name), `four_le_chromaticNumber_of_system_subset`
  (conclusion-first + `of_`-hypothesis, the Mathlib shape).
* **Spine lemmas stay `private`** (`unit_frame`, `re_of_norms`, `im_sq_of_norm`,
  premise converters): one consumer today; promotion with proper names waits for M22's
  second use.
* **Spec set as the cold consumer reads it**: 4 examples — premise inhabited
  (`dist 0 1 = 1`), gluing set inhabited (`hexStep 0 1 ∈` both spheres), interlock
  inhabited (`seamImage 0 1`), and the adversarial member (`1 ∉` the oo set, with the
  *why* in the docstring). Positive + negative on the same object.
* **`tools/couple.py` CLI**: subcommands `--census`, `--phase`, `--joint` (verification
  of kills runs inside it, never separable), `--pair`, `--mesh`, `--floor`,
  `--self-test`. Refusals by name (enumeration cap, foreign pool digest, non-far pair,
  sampler dead-end). Self-test: Hall-violation control, σ/ζ₆ phantom-relation control,
  the list-vs-tuple and double-reindex regressions on tiny fixtures, sampler
  properness/canonicity, mesh-curve residual sanity (each sampled (α,β) satisfies the
  chord equation to 1e-9); the closure-dependent pin-only k=3 control stays a
  documented invocation (M20 precedent). `scripts/regen-check.sh` gains the FAIL-loud
  `--self-test` line at implementation.
* Skeleton after the pass: 22 sorries (19 proofs + 3 added/1 deleted spec examples),
  elaborates clean.

## 4. Instrument promotion

At implementation, the scratch scripts consolidate into ONE promoted tool
(`tools/couple.py`): census + phase probe + joint profile (with the injection
re-verifier built in, never separate again) + pair builder + mesh scan + union-floor
as subcommands, carrying the self-tests (the Hall-violation control, the σ/ζ₆
phantom-relation control, the list-vs-tuple and double-reindex regressions from §0.4,
mandatory caps, the pin-only k=3 SAT-path control) and the artifact-identity discipline
(edges digest, refuse foreign pools). The sampling honesty note travels in the
docstring: the joint sampler is a seeded greedy walk, not uniform — verdicts are facts,
coverage claims are bounded to the sampled frame. Scratch scripts are session-mortal;
anything §5's scope keeps live must survive in `tools/` with its controls.

## 5. Scope and standing

* In scope: §2.1–2.3's skeleton burned down; the promoted instrument; the mesh-barrier
  theorem IF the domain pass finds it a clean statement. Out of scope: general d; any
  coupled-automaton table theory (killed by §0-C); the χ fork's two branches (each
  carries a named reopening gate, §2.4); three-pivot systems.
* M22 candidates this milestone generates (stub at close): the partner-closed sample
  (one √-extension per generation) to force the fork; kernel certification of the 229
  verified kills (each already a `Fan.of_unsat` pin cube) if a claim needs them;
  the kill-structure census (WHICH pattern pairs die — the shape of the pressure);
  non-sector construction search via the probe's model corpus.
* Standing: writeups/upstreaming deferred (2026-08-04 policy); `lean4checker` a
  publication gate; builds via `scripts/build.sh` only; crash ⇒ halt and report; one
  heavy job at a time; killed patterns become claims only through the kernel route.
* Gate additions at close: `#print axioms` rows for every public `Coupled` declaration;
  the promoted tool's `--self-test` wired into `scripts/regen-check.sh` FAIL-loud; the
  negative-control sweep (break each new check, watch it fail, restore).

## 6. Implementation record (2026-08-08, desktop)

* **The skeleton burned down in one pass**: all 22 obligations closed on the first
  elaboration but for a single `linear_combination` coefficient (computed against the
  pre-rationalized hypothesis; one-line fix). The obligation pass's designs held
  exactly: everything in the reflection package is a `linear_combination` of the one
  engine identity `(q−p)·conj(q−p) = 1`; the three-lemma ⊆-spine carried all three
  classifications; the mirror branches came free through `reflAcross_ratio`
  (`reflAcross` conjugates the axis ratio — the pass's "verified identity", minted as
  a private lemma alongside `mul_conj_q_sub_p` and `conj_mk`).
* **Mutation audits 3/3 red, culprit named each time**: the dropped premise broke at
  its consumption site (and the premise-free statement is false: `reflAcross p q q =
  p + (q−p)·|q−p|²`); the third RHS point left the two-root case split open; the
  swapped seam orientation failed the frame pin (`⟨1/6,√11/6⟩` has norm 1/√3, not 1).
* **Axioms**: all 14 public `Coupled` declarations on exactly
  `[propext, Classical.choice, Quot.sound]` (261 clean total); zero purchases; the
  audit's fail-loud path re-verified against a nonexistent constant.
* **The promoted instrument, validated against the §0 artifacts**:
  - `--census` reproduces the committed artifact *exactly*: 4,615 pivots, 1,108,572
    coupled pairs, 3,585 d² classes, 39.0% top-10 weight share, d²=1 weight 1,235,562
    with far-max 40 at (695,2044), d²=1/3 far-max 34 at (30,426). (Two far pairs tie
    at 40 chords; the ordering of the tie differs, nothing else.)
  - `--phase` reproduces *exactly*: 0 relations at all seven probes, d² spectrum
    1, 1/3, 5/3 ± (2/9)√33, field flags and annulus tables identical.
  - `--pair`: the session-mortal original's exact move/seed list died with its
    session. Reconstruction recovered the growth engine exactly (48 points/step at
    every depth, all 8 glue points, k=3 UNSAT, k=4 SAT) with a documented constant
    offset: seeds = the pivots + the eight gluing points (the Lean module's cast)
    give 984 points at depth 20 vs the original's 964 — a +20 seed-detail constant,
    honesty-noted in the tool. Membership-directed moves: outers {ζ₆, seam, seam⁻¹,
    seamImage}, inners {ω}.
  - `--joint`/`--floor`/`--mesh`: the phenomenon reproduces (small-frame joint run:
    local kills + verified ambient kills at the coupled pair, flat null; floor 3 at
    t\* = 2; mesh: zero survivors, oo-dominant first violations) — sample frames are
    seeded fresh, so §0's exact tallies are not re-claimed. Self-test: 10 controls
    green; the sabotage negative control turns 2 red and exits 1.
* **One deviation from the pass designs**: the spec example `dist (0:ℂ) 1 = 1` was
  factored into a private lemma (`dist_zero_one`) so the other three spec examples
  could consume it — the skeleton had each example self-contained. No public surface
  change.
