# M33 — The mechanism hunt: what forces the 5th colour (PRE-SUBPLAN STUB)

*Written 2026-08-10, immediately after M32's close, on Kooshi's direction:
"I think we should continue to pursue the minimal mechanism for 5 coloring, so
that we can understand what makes the leap. We understand 3 and 4 pretty well.
I want to be able to confidently point to the reason why 5 colorings are
forced." This stub re-aims M33 from certification to mechanism. The
certification programme (formerly M33, `plans/M33-witness-closure.md`) is
parked as the standing fallback with a banner; nothing in its handoff decays.*

*Read order for a fresh session: this stub whole → `plans/M32-certified-five.md`
§0a/§0g/§R (the stacking law, the flat verdict, the kernel-checked kill engine)
→ CLAUDE.md § Grokkings G13 and G15 → `plans/M30-degrey-anatomy.md` §R (the
rigidity and anatomy instruments).*

## THE GOLDEN QUESTION (the short-term target, verbatim)

> **What ambient structure delivers the 4th colour onto a circle?**

Everything in this milestone is aimed at answering that question at minimal
scale, and then naming the answer as mathematics.

## Why this question is exactly the leap

The colour ladder as we own it:

* **3 → 4, owned completely [kernel]**: the two circles about a point are
  3-colourable (M19), and a nameable LOCAL mechanism puts all three colours
  on the centre's neighbourhood in every proper 3-colouring — the inner
  circle partitions into unit triangles under 120° rotation, each forced
  rainbow (M18's `rot3_unit_triangle`, M20's rainbow floor). The centre has
  nowhere to go: exactly 4 (M20 `chromaticNumber_concentric`). One sentence,
  one certified chain. **This is the template for what "understanding a
  colour step" means.**
* **4 → 5, shape known, mechanism unknown [measured, G13]**: Heule-510's
  centre v0 is confined at four BY THE AMBIENT WEB — every proper
  4-colouring of 510 − v0 covers v0's 36-point unit circle with all four
  colours (UNSAT 10.1 s, controls green) — while v0's own two-circle system
  provably CANNOT deliver that confinement (kernel: class-only graphs are
  3-colourable, M18; centre + circles caps at exactly 4, M20). The
  5-transition is 100% ambient-delivered. Nobody owns the mechanism that
  delivers it. That gap IS the golden question.

## The two-act theory (G15 — the working reading this milestone tests)

Every known 5-forcing argument factors into two acts:

1. **The pigeonhole (the global act)**: "every 4-colouring of this fabric
   region puts some forbidden pattern SOMEWHERE" — a DISJUNCTIVE compulsion
   over many placements. De Grey's own informal argument is the exemplar
   (some √3-triple goes monochromatic somewhere in his hexagon fabric).
   Because it is a disjunction, it has no small carrier (G10's four
   globality measurements) and it is INVISIBLE to instance-level meters:
   each single placement is floppy (M30/M32 measured zero forced pairs,
   zero compelled single triples, everywhere). The compulsion lives in the
   class, not the instance.
2. **The kill (the local act)**: the detuned overlay refutes each placement
   of the pattern — thin, conic-pinned, law-governed chords. This half is
   now KERNEL-CHECKED (the quadrature law G12, `Quadrature.lean`) and its
   width theory is G14 (the stacking law).

**Why M32's designed stacks were flat, explained**: they built act two over
a fabric never shown unable to stay clean. Kills without a pigeonhole force
nothing — the missing ingredient was never more chords.

**The instrument consequence**: stop asking "is THIS instance forced"
(always no) and ask "can the CLASS be avoided simultaneously" — one SAT
call per (region, pattern-class): SAT("proper 4-colouring of R with no
P-instance anywhere"). UNSAT = the pigeonhole localized. This single
query-shape change is the new instrument of the milestone.

## The phases (subplan registers predictions per phase BEFORE running)

### Phase 1 — the fan onset and the fan-critical core (existing instruments)

The bare hexagram chunk reads min-cover 3 on a pivot circle (M32 base rate);
the full 510 − v0 reads min-cover 4 (the fan). Somewhere in between is the
**onset radius** where the ambient web first forces the 4th colour onto the
circle. Nobody has measured it.

* Sweep: growing induced balls of Heule-510 about v0 (and of the 1581 about
  its centres), plain AND gen-1-enriched (`tools/closure.py --gen1`
  machinery), coverage query at k = 4 on S = ball ∩ unit-circle(centre)
  (`rigidity.min_cover` — built at M32, vacuity-guarded). Find the flip.
* Compare the peripheral fanned vertex 139 (its fan was UNSAT 29.5 s at full
  510): does its onset radius differ from the centre's? Same organ or
  different?
* Then SHRINK: from the smallest fanned ball, delete vertices while the fan
  survives (greedy, the M30 criticality protocol one level down) → the
  **fan-critical core**: the minimal ambient web that delivers the 4th
  colour to one circle. Controls: the final core's UNSAT reproduced by an
  independent re-encode/second seed; spot-check each late deletion's
  necessity (restore → SAT). Honesty rule: the core is solver-measured
  knowledge until phase 3 formalizes it; never call it a theorem.
* Note what this evades: G10 says no small part is 5-CHROMATIC. The fan is
  not 5-chromaticity of the part — it is a CONDITIONAL compulsion, and
  conditionals can be small. Whether the core is 150 vertices or 450 is
  genuinely open; register a band at subplan time.

### Phase 2 — the avoidance ladder / the compulsion spectrum (new instrument)

Between "a pair is forced" (order 2 — zero everywhere) and "the whole circle
is covered" (order ~36 — true at the witness) lies an unexplored ladder.

* Build the **class-avoidance query** into `tools/rigidity.py`: enumerate a
  pattern class P's instances over a region by exact arithmetic (the M32
  `present_triples` pattern generalizes), assert avoidance clauses (mono
  avoidance is palette-symmetric — no WLOG needed), one SAT call.
* Classes to sweep, cheapest first: mono pairs at distance d (d over the
  ring vocabulary — √3 the historic one; note mono-√3-pairs are
  Moser-spindle-killable INSIDE the seam field, G1, so the seam closures'
  4-colourings must avoid them — a registered sanity check on our certified
  tables); mono √3-triples (de Grey's class); rainbow-forcings; coverage-j
  on sub-arcs of a circle.
* The output: the **compulsion spectrum** — for the witness fabric, which
  order of compulsion fires first, and at what radius. This curve is the
  anatomy of the leap.
* **Positive control, already in hand**: the 791-forcer's six forced pairs
  (the axis pair at 4 and five antipodal pairs at 4/√3 — forced central
  symmetry, M30) are an already-measured class-level compulsion; the
  avoidance instrument must reproduce them (avoid-all-six → UNSAT) before
  any new verdict is believed. The forced-symmetry thread folds into this
  phase rather than standing separate.

### Phase 3 — the cascade, formalized (the M20 genre, one field up)

χ ≥ 5 as mechanism: (a) the pigeonhole half as a compulsion theorem — the
genre we have proven once (`no_mono_outer_triple`, a compulsion acting
through no edge, at k = 3); (b) the kill half already kernel-checked
(`quadrature_rho15`, the stacking law's matchings); (c) the assembly, with
no SAT certificate anywhere in the argument. Then "minimal" finally means
what G10 demanded: least geometry whose cascade closes — and the
fan-critical core's closure, not the whole witness's, becomes the object
worth certifying. The certification engine (Quadrature.lean, the pair-web
handoff, the sympy proof-term discipline) is the vehicle for this phase,
not a rival to it.

## Costs and benchmarks (desktop)

Fan queries: 510-scale 10–30 s; B=2-chunk-scale seconds; enriched balls
(~16k vertices) unmeasured — expect minutes, cap and measure; the shrink is
~one query per deletion step (hundreds of calls — budget hours, background,
one job at a time). Avoidance queries: same order as coverage queries.
`unknown ≥ cap` is never a compulsion claim. All standing machine rules bind
(build.sh only; segfault → HALT and report; one heavy job).

## Failure clauses (to be sharpened at subplan registration)

* **The fan-core comes out large AND patternless** (most of 510, no
  compelled class below coverage order): that is the FIFTH globality
  measurement — coverage compulsion itself irreducibly global — reported at
  face value; G15 demotes per its falsifier; fall back to the certification
  programme (`plans/M33-witness-closure.md`) with the mechanism hunt's
  measurements as anatomy.
* **The onset never arrives below the full witness** (every proper ball
  stays min-cover ≤ 3 until the last vertex): itself a sharp finding —
  register it as such, not as a failure.
* **The avoidance ladder reads all-SAT through witness scale at every
  probed class**: the compulsion lives above the probed orders; report the
  probed ceiling honestly and re-rank.
* Any segfault, any process: HALT and report to Kooshi (standing).

## Deliverables

* The onset curve (radius → min-cover, plain and enriched, centre and
  peripheral) as a JSON artifact + a chart in the explorer or anatomy page.
* The fan-critical core: vertex list, its anatomy (shells, direction
  classes — `tools/anatomy.py` re-aimed), and its reproduction controls.
* The compulsion-spectrum table with the 791 positive control shown green.
* The class-avoidance instrument with red/green self-tests.
* Frontier + Grokkings close (G15 confirmed, sharpened, or demoted — with
  the measurement either way), and the phase-3 stub or module if the
  cascade opens.
