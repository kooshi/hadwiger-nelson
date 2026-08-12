# M43 — The fine-tail campaign: the from-above six-hunt at the open scales
# (STUB — written 2026-08-12 at the M42 close. Not yet subplanned; read order for a
#  fresh session: `plans/M40-chi-omega-hunt.md` WHOLE (the band decomposition, the
#  corrected census, §R), `plans/M42-gap-kernel.md` §R (the certificate template any
#  find here promotes through), CLAUDE.md § Frontier rows 37/39 and G23/G24.)

## The mission, in plain language

For every scale `p`, a proper colouring of the constraint graph `G(p)` (join two
triangular-lattice addresses when their cells hold a unit pair) IS a proper colouring
of the plane: `χ(ℝ²) ≤ χ(G(p))`. M39–M40 mapped the family: sevens in the classical
window, twelve then nine just below it, sevens forced WITHOUT cliques all the way down
to `p = 0.2236` (G24). **Nobody has ever refuted six on the fine tail's open scales,
and nobody has found a six-colouring** — and any six-colouring of ANY band is
`χ(ℝ²) ≤ 6`, new mathematics of the first order. This campaign attacks the two open
regions directly, with instruments that already exist.

## The target list, ranked (M40's measured verdicts)

1. **The `p = 1/7` region** — the sharpest open scale. Measured: ω = 3 (the plane's
   own clique number), balls to radius 225 remain **six-colourable** (SAT), tori
   refuse six only to period 36 (UNSAT — period-bounded, NEVER a chromatic claim).
   Undecided in BOTH directions, with signals both ways. CAUTION (M40 band re-keying):
   `T = 7` is itself a threshold scale — every integer `T` is, since the `(n+1, 0)`
   class arrives at `T² = n²` — so "p = 1/7" means the FLANKING BANDS, keyed by
   point-group class, not the boundary scale; run the band decomposition first and
   name the band intervals exactly (the 1/6 flanks came out ω = 3, χ = 7 — gap four;
   the 1/7 flanks are the open siblings).
2. **The unprobed tail below `p = 0.2236`** — no census at all: band decomposition,
   exhaustive ω, ball χ probes per band. The scaled-shell recursion (the M = k copy of
   the closed shell at `p ≈ 1/(2k)`-ish windows) predicts sevens RECUR; between those
   windows the six-question is open at every band.

## The two outcomes, and what each costs

* **Refutation** (a ball at some radius refuses k = 6): `χ(G(p)) ≥ 7` OUTRIGHT for
  that band — the last fine-tail door closes, G24 extends, and the result promotes
  same-day through the **M42 template**: derive the ball's edges in Lean from
  addresses + the norm filter (`Instances/Core23/Edges.lean` is the model), emit CNF
  from Lean (`scripts/Dimacs.lean`), `tools/emit_mask.py --colours 6`, Gadget palette
  closure over any clique (ω = 3 here — pin a triangle, expect the palette lever to be
  weaker: measured 160× at the 23-core's 4-clique; Mycielski's edge pin was 26×).
  1-minimal shrink (`tools/celllat.py --shrink`) before certifying.
* **A six-colouring** (SAT on a torus or any periodic/aperiodic scheme): this is the
  standing JACKPOT clause — **χ(ℝ²) ≤ 6 candidate. HALT AND VERIFY**: independent
  re-derivation of the edge set, a second encoding checking the colouring directly,
  report to Kooshi BEFORE interpretation. Promotion needs a plane-properness
  certificate for cell-constant colourings (the M37-sharpness-style covering-radius
  argument — necessity of the band criterion — which M42 deliberately did NOT build;
  price it only if a colouring is found).

## Instruments (all standing, `tools/celllat.py` M40 suite)

Class-keyed band decomposition (`bands`), exact `edge_reach`, exhaustive
`max_clique40` (cap ≥ 13), ball SAT probes at k = 6 with radius escalation, torus
probes with Sinz exact-α machinery, batched 1-minimal shrink with necessity
certificates, colouring anatomy (stabilizer/coset tests — the witnesses' structure if
one appears). Multicore per the standing rule (threads within a tool run, RAM the only
hazard). Bigger tori (periods 42–72) and deep balls may want the DESKTOP — ask which
machine before believing core counts; timings never compared across machines.

## Registered-prediction discipline (write §0 BEFORE running)

Predictions to register at subplan time, at minimum: (i) the 1/7 flank bands' exact
intervals and class keys, hand-derived from D1-style threshold arithmetic; (ii) an ω
prediction per band; (iii) a prior on six per band with the evidence both ways stated;
(iv) the failure clauses — `unknown ≥ cap` is never a verdict, torus UNSAT is
period-bounded only, any SAT six-colouring fires the halt-and-verify clause verbatim.
Acceptance criteria must be exact (necessary AND sufficient) — G21 discipline, stated
at registration.

## Also in scope, priced before claimed

* **The interval-distance bridge**: `χ_{[1−ε,1+ε]}(ℝ²) ≥ χ(G(p))` at `ε = 2p/√3` —
  before ANY novelty claim about interval-distance chromatic numbers, check the Exoo
  line of literature (Exoo's ε-unit-distance graphs; also Grytczuk et al.) — the
  bridge may already be beaten by known interval results.
* The explorer (`build/m40-spectrum.html`, artifact "The Gap Atlas" 🔺) gains the new
  bands/verdicts — update, never re-mint.

## Why this is worth a milestone

It is the highest-expected-information experiment the from-above direction owns: every
outcome moves the map (a refutation closes the sharpest open scale and extends the gap
law; a six-colouring is the result). The alternation discipline (Kooshi, 2026-08-12:
"attack from both directions, narrowing the cuts") has the from-below thread parked
with its reduction sharp (G26: one k = 5 gadget closes χ ≥ 6); this is the from-above
thrust that either finds the entry or proves the fine tail is all sevens.
