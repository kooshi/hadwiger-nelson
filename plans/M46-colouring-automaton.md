# M46 — The description instrument: compute a colouring space, don't just interrogate it
# (STUB — written 2026-08-13. Read order for a fresh session: this file, then
#  `plans/M20-the-extension-problem.md` (the strip automaton — the ONLY description instrument
#  this project ever built, and the only one that produced a structural theorem),
#  `plans/M40-chi-omega-hunt.md` §R (the band atlas), `plans/SHAPES-OF-SIX.md` §3 Shape D.)

## The one-paragraph version, for a reader who knows nothing

Every tool this project has built since its twentieth milestone answers a yes/no question: is this
graph colourable, is this pair forced, is this many colours enough. None of them *describes* the
set of all valid colourings — they only poke it. The one exception was an automaton built early
on: for an infinite strip of the plane it computed the complete state machine of all valid
three-colourings (864 recurring states, one connected component, exactly twelve times as many
colourings per extra column), and that single instrument produced the only structural theorem
about a colouring space we own — that any valid colouring of a two-column window extends to the
whole infinite strip. We never built another. This milestone builds the modern one: the same
machine for the graphs where we currently have a *verdict* (they need seven colours) and no
*explanation* (we cannot say why).

## Why now

M43's autopsy of the fine-tail forcing ended at an absence: the compulsion "is not pair-mediated;
it is genuinely global over ~160 vertices". That is the correct report of what was measured, and
it is also a confession that we have no mechanism. Meanwhile the standing shape-space document's
own kill test for the from-above route reads: *"autopsy the 23-core totally — **its full colouring
space**, its fractional certificate, whether it factors as pigeonhole × kill."* The factorization
test ran at M41 and the fractional certificate was computed exactly. **The colouring space was
never computed.** Shape D's test is half-done, and the unfinished half is the half that would name
a mechanism rather than confirm or deny a template.

There is a second, independent payoff, and it repairs the honesty caveat attached to a dozen rows
of the record. Our fine-scale negative results are *period-bounded*: "no periodic six-colouring of
index ≤ 96", "unknown at cap", "no six-colouring on tori to 24 × 24". A transfer matrix over an
infinite strip has no period bound and no cap — it returns the **exact** chromatic number of the
infinite strip of that width, and any strip refusing six is an unconditional statement about the
whole graph, with a certificate that is a reachability computation rather than a proof log.

## The instrument

The cell-family graphs are lattice graphs, which is precisely the setting a transfer matrix was
invented for. Fix a band (hence a fixed finite edge-offset set), fix a strip width `w`, and sweep
a frontier along the strip:

* **states** = proper colourings of the frontier (the cells whose colours can still constrain
  future cells — a window of `w × r` cells, where `r` is the interaction range, i.e. how far the
  edge offsets reach);
* **transitions** = adding one column consistently;
* the strip is `k`-colourable **iff** the transition relation has a bi-infinite path, i.e. iff the
  reachable part has a non-trivial strongly-connected component. Emptiness of the recurrent set is
  a refutation of `k` colours on the infinite strip.

And the object that comes out is not a verdict but a **description**: which states die, how the
recurrent set decomposes, the growth rate of the colouring count per column, and — the thing we
have never had at any scale above the first milestone — the *structure of the near-miss
colourings*, which is where a mechanism for clique-free forcing would be visible if it is visible
anywhere.

## The cost model, stated before committing (this is the phase-0 gate)

States go like `k^(w·r)`, so this is **exponential in width × interaction range**, and the
feasible region must be measured, not hoped for:

| band | interaction range `r` | affordable? |
|---|---|---|
| classical window and the `9`/`12` bands | small (edge norms ≤ 4, `r` ≈ 2) | yes — `6^(2w)`, several widths |
| `G*` band (norms {3,4,7,9}) | `r` ≈ 3 | yes at small width, and this is the model organism |
| `1/6` flanks | `r` ≈ 5 | marginal |
| `1/7` flanks (degree 114, norms to 63) | `r` ≈ 7 | **dead** — do not attempt |

Two reductions apply before any state is enumerated and both are large: quotient by the palette
symmetry (up to `k!`, and the first-occurrence canonical form is already implemented elsewhere in
the suite), and quotient by the band's point-group stabilizer of the strip direction. Phase 0
measures the post-reduction state count on the smallest band and **the milestone stops there if
the number is wrong** — a description instrument that only runs on the bands we already fully
understand is worth exactly one afternoon of curiosity, not a milestone.

## The phases

* **§0 — feasibility, measured, with a hard stop.** Post-reduction state counts for `G*` and the
  `9`-band at widths 1–4, at six and seven colours. Registered kill: if `G*` at width ≥ 2 does not
  fit, the milestone is a footnote and is reported as one.
* **§1 — the automaton, with its negative control.** Build it; reproduce M20's strip automaton
  numbers as the green control (the graph is different but the machinery is the same genre and the
  early object is fully known); plant a colourable strip and confirm a non-empty recurrent set,
  plant an uncolourable one and confirm emptiness.
* **§2 — the exact strip chromatic numbers**, per band, per width — replacing period-bounded rows
  with unconditional ones wherever it reaches.
* **§3 — the description.** The recurrent-set decomposition, the per-column growth rate, and the
  question that motivated the whole thing: **what dies, and in what pattern, when the sixth colour
  is removed?** This is the phase that either names the mechanism the fine-tail autopsy could not
  find, or reports that the structure is featureless — which would itself be the first direct
  statement about *why* integrality-carried forcing resists explanation.
* **§4 — the certificate question, priced not promised.** If an emptiness result is the shape a
  kernel can replay cheaply (a finite reachability computation over an explicit state table — the
  M04 literal-table pattern, which the kernel handles well), price it against the M06-scale proof
  log that M43 declined. Do not build it in this milestone; price it.

## The honest prior

The feasibility gate is genuinely at risk and is placed first for that reason. If it passes, the
structural payoff is high and unlike anything else on the board, because it is the only instrument
proposed anywhere in the record that returns a *description* rather than a verdict — and the
project's one previous description instrument is also its cleanest structural theorem. If it
fails, it fails in an afternoon and says so.
