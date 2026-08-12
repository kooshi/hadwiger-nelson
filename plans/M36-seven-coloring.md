# M36 — χ(ℝ²) ≤ 7 in the kernel (SUBPLAN — §0 registered 2026-08-11, desktop)

> **What changed at subplanning, before any instrument ran.** The stub (written at
> M35's close, preserved below as **§H**) planned a *hexagon* module: a new cell
> family, a rounding function with a circumradius bound, and a ℚ(√3) ordered
> arithmetic layer — ~300 lines of new machinery, because M35's phase-2 sweep had
> measured that no *brick* colouring passes the certificate at seven colours
> (G20). Working the arithmetic out by hand for §0a found the real obstruction,
> and it is **not** the tile family: it is one comparison inside M35's own
> certificate. Half-open cells make the set of realizable difference vectors an
> **open** box, so a sound certificate may accept an offset whose distance
> interval touches a guard at its endpoint; `Brick.check` demanded *strict*
> separation, and the classical seven-colouring in this family is **boundary-tight
> by force** — its cell diagonal is exactly 1. Relaxing one `<` to `≤` (sound,
> proof below) makes the brick family certify χ(ℝ²) ≤ 7 with a 7 × 7 table and no
> new geometry at all. **This is the third time in this repository that a
> registered route was superseded by LESS machinery** (M24's π-adic valuation
> sketch, M25's ζ₁₂ ring); the rule holds — derive before building.
>
> **G20 is corrected by this derivation, not by a measurement**, and the
> correction is registered here before it is confirmed: its measured content
> (no brick colouring passes a *positive-margin* certificate at seven) survives;
> its *reading* — that row-aligned cells cannot seven-colour the plane, that
> interlock is load-bearing — is **false**. See C2.

## The mission

**Land χ(ℝ²) ≤ 7 as a kernel theorem**, completing the classical interval
**5 ≤ χ(ℝ²) ≤ 7 entirely kernel-side** on axioms exactly
`[propext, Classical.choice, Quot.sound]`. The lower end is M06–M09 (de Grey's
graph, certified); the upper end is this milestone. Under the standing policy
(formalizing known results is not a goal in itself) it earns its place three
ways: (i) the certificate machinery is THE promotion path for every future
periodic-avoider find, and an avoider at k = 5 is the open upper-bound problem
itself (M35 §0a C1), so the pipe must exist before any find can be certified;
(ii) the boundary-tight sharpening derived here is a genuine correction to a
Frontier grokking and re-opens the k = 6 question that M35 recorded as closed;
(iii) an interval-complete repository is what the eventual write-up trigger
stands on. **Attribution, fixed now**: the seven-colouring is classical (Isbell's
hexagonal argument, and the half-open brick variant is folklore-adjacent) — we
claim no novelty for the construction. Ours: the kernel certificate, the
open-box soundness sharpening that makes any boundary-tight colouring
certifiable at all, and the G20 correction.

---

# §0 — The registered subplan (2026-08-11, desktop; committed before any
# instrument, any solver, and any Lean run)

## §0a — A priori derivations (worked by hand; every one falsifiable, and each
## carries the failure clause that fires if it is wrong)

**C1 — The half-open cell's difference set is an OPEN box, so a sound
certificate may be boundary-tight.** In the brick model a point `z` sits in its
cell at internal offset `u ∈ [0,w) × [0,h)`. Two points in cells at index offset
`(dc, dr)` differ by `t + (u′ − u)` with `t = (w·dc + s·dr, h·dr)`, and
`u′ − u` ranges over the **open** box `(−w, w) × (−h, h)`. Therefore, writing
`lo`, `hi` for the closed-box interval ends of that offset:

* `d² < hi` **always** — strictly, because each coordinate's excursion is strict;
* `d² > lo` whenever `lo > 0` — strictly, because a positive `lo` means at least
  one coordinate's closed minimum is attained only on the box boundary, which the
  open box excludes.

So the sound certificate condition is `q ≤ lo ∨ hi ≤ q` (given `0 < q`), not
M35's `q < lo ∨ hi < q`. The relaxed check is strictly more permissive and
equally sound; the only change to `Brick.sound` is `abs_lt` where it currently
uses `abs_le`, plus a two-case split for the `lo` branch. **Failure clause:** if
the sharpened soundness proof does not close, the whole milestone reverts to §H
(the hexagon route) with the price already named there.

**C2 — The coset-7 brick pattern is boundary-tight BY FORCE — which is exactly
why M35's phase 2 refused, and why its verdict was an artifact of the
certificate rather than a fact about the plane.** Take cells `w × h`, row shear
`s = w/2`, torus `7 × 7`, table `(i + 3j) mod 7`. That table is the norm-7 coset
map on the hexagonal lattice ℤ[ζ₆]: multiplying by ζ₆ sends `(a,b) ↦ (−b, a+b)`
and the colour to `3a + 2b ≡ 3·(a + 3b)`, so the kernel is ζ₆-stable, hence an
ideal; it contains `τ = −3 + ζ₆` of norm `9 − 3 + 1 = 7`, and by index it **is**
`(τ)`. Two same-coloured cells therefore sit at a lattice offset of norm ≥ 7.
Now two offsets pin the geometry:

* the **self-offset** `(0,0)` always clashes (a cell shares its own colour) and
  its interval is `[0, w² + h²]`, so the certificate needs `hi = w² + h² ≤ 1`
  — the cell diagonal is at most 1;
* the **coset offset** `(dc, dr) = (1, 2)` — the lattice vector `u + 2v` with
  `1 + 3·2 = 7 ≡ 0` — translates by exactly `(2w, 2h)`, whose closed-box gap is
  exactly `(w, h)`, so `lo = w² + h²`, and the certificate needs `lo ≥ 1`.

Provided the `|Δb| = 1` offsets are separated rather than enclosed (i.e.
`(3w/2)² ≥ 1`, the design regime), these two force **`w² + h² = 1` exactly**:
*every* member of the family is boundary-tight, its cell diagonal is the unit
distance itself, and no strictly-separating certificate can accept any of them.
M35 §0j moreover filtered its search grid by `diag² < 1` — the exact condition
the strict check needed — so the solutions were deleted from the search space
twice over. **Failure clause:** if the design script finds any same-colour
offset whose interval strictly contains 1 at the parameters of C3, C2 is wrong;
halt, re-derive, and fall back to §H.

**C3 — The rational instance: the 3–4–5 triangle seven-colours the plane.**
`w² + h² = 1` with the two slack conditions `w ≥ 2/3` (from the `|Δb| = 1`
offsets, `lo = (3w/2)² ≥ 1`) and `h ≥ 1/2` (from the `|Δb| = 3` offsets,
`lo = (2h)² ≥ 1`) has a rational point of smallest denominator at
**`(w, h) = (4/5, 3/5)`, shear `s = 2/5`** — a 4:3 brick whose diagonal is
exactly 1. The remaining offset families are slack by inspection:
`|Δb| = 0` gives `lo = 36w²`; `|Δb| = 2` at the far branch `16w² + h²`;
`|Δb| = 4` gives `4w² + 9h²`; `|Δb| = 5` gives `w²/4 + 16h²`; `|Δb| ≥ 3`
generally `lo ≥ 4h² ≥ 1`. The whole certificate window at guard 1 is
`rowBound = ⌈2/(3/5)⌉ = 4`, `colBound = ⌈(2 + (2/5)·4)/(4/5)⌉ = 5` — a 9 × 11
grid of 99 offsets, each a 49-cell table scan: kernel `decide` scale, ~10× the
already-landed Nine instance. **Failure clause:** if `decide +kernel` cannot
close the check inside a few minutes, the bit-packed-`Nat` table fallback
(M35 §0l's priced pattern, `>>>`/`&&&` GMP-backed) is instance-side and needs no
`Brick.lean` change.

**C4 — What the relaxation does NOT buy, and the control that guards it.** A more
permissive check makes soundness the load-bearing question, so the mass red
control is promoted from empirical hygiene to the milestone's primary instrument
guard: **any k = 4 brick colouring accepted by the relaxed check would
contradict the kernel χ(ℝ²) ≥ 5**. One such SAT is instrument catastrophe —
halt everything, treat the relaxation as unsound until re-derived, report to
Kooshi immediately. This control is now sharper than it was in M35, because the
relaxation is exactly the kind of change that would break it if wrong.

**C5 — The k = 5 and k = 6 questions re-open, honestly.** M35 recorded "no
avoider at k ≤ 6 in the brick family" — a verdict produced by the strict check
and the `diag² < 1` filter, i.e. under exactly the two conditions C2 shows are
artifactual. Both must be re-asked under the corrected check. The stakes are
stated plainly so no result is over-read: **a k = 6 brick colouring would prove
χ(ℝ²) ≤ 6, and a k = 5 one would prove χ(ℝ²) ≤ 5** — either would be the
largest result this repository has produced and neither would be believed on a
SAT model alone; the find is a candidate until the design script re-validates it
independently and `Brick.check` accepts it in the kernel. The prior is low (the
plane's chromatic number has resisted since 1950 and the brick family is thin),
and the honest expectation is refusal at every probed shape, reported as
resolution-bounded ceilings, never as impossibility.

**C6 — The pixel question is retired, not run.** M35's honesty ledger left the
fine-square probe (32 × 32 @ 1/8, capped unknown at 900 s) open as the route to
a brick seven-colouring. The covering-radius arithmetic settles it a priori: a
pixel colouring inherited from the hexagonal assignment needs
`√2/N < min(1/2 − p/√3, (√7·p − 1)/2 − p/√3)`, whose optimum over the lattice
pitch `p` is ≈ 0.063 at `p ≈ 0.757` — i.e. **`N ≥ 12`**, before the
rational-commensurability distortion that a periodic torus additionally
demands. The §0l rows at N = 8 and N = 10 were therefore doomed by resolution,
their 900 s "unknown" is unsurprising, and C3 answers the question they were
asked for at 7 × 7 instead of 32 × 32. **Decision: the pixel retry named as the
stub's cheap first move is NOT run** (it would cost hours to confirm a negative
that the arithmetic already explains, and its positive branch is superseded).

**C7 — The read-aloud gate.** With M09's `5 ≤ χ` over `EuclideanSpace ℝ (Fin 2)`
and this milestone's `Colorable 7` over ℂ, the interval statement transports
through the existing isometry congruence (`chromaticNumber_unitDistance_congr`,
the route `Instances/Triangle.lean` already uses). The sentence that must be
read aloud against the informal claim before the milestone is believed: *the
plane needs at least five colours and at most seven, so that no two points one
unit apart share a colour — both ends checked by the Lean kernel, on the
standard three axioms.*

## §0b — Definitions and contracts (what changes, where, and what may not)

* **`Proofs/HadwigerNelson/Brick.lean`** (the sharpening; no new definitions):
  - `check` — both comparisons relax: `decide (q ≤ lo …) || decide (hi … ≤ q)`.
  - `sound` — gains `(hq0 : 0 < q)`; the interval workhorse `hbound` is promoted
    to two named lemmas with **strict** conclusions (`sq_lt_hi`, `lo_lt_sq`);
    the `lo` branch gains the `mx > 0 ∨ my > 0` case split C1 names.
  - `avoids` — `0 ≤ q` becomes `0 < q` (the `q = 0` guard only ever said
    `z ≠ z'`).
  - `colorable` — statement UNCHANGED (`q = 1 > 0` discharged internally): the
    consumer surface does not move, which is the point of putting the hypothesis
    on `sound`.
  - the module docstring gains the open-box paragraph; the sole reason a reader
    may trust a boundary-tight certificate is stated where the certificate is.
* **`Proofs/HadwigerNelson/Instances/Nine.lean`** (the existing instance, kept
  green): the adversarial guard control `check [1, 8/9] = false` **flips to
  `true` under the corrected check and that flip is CORRECT** — the 3 × 3
  rainbow of 2/3-cells genuinely avoids `√(8/9)`, boundary-tight, and M35's
  control was testing the strictness rather than the mathematics. It is
  re-labelled as a certified avoidance, and the adversarial slot is refilled by
  a **strictly interior** guard (`check [1, 1/2] = false`), which no relaxation
  can accept. The all-one-colour table control is unaffected.
* **`Proofs/HadwigerNelson/Instances/Seven.lean`** (new): `sevenBrick` at
  `(m, n, w, h, s) = (7, 7, 4/5, 3/5, 2/5)` with `table i j = (i + 3j) mod 7`;
  `sevenBrick_check` by `decide +kernel`; `plane_colorable_seven`; the spec
  block (below).
* **`Proofs/HadwigerNelson/Instances/Interval.lean`** (new, tiny): imports
  DeGrey and Seven and states the classical interval — the read-aloud object.
* **`tools/periodic.py`** (UNTRUSTED, as everything in `tools/`): the check
  mirror relaxes identically, the `diag² < 1` grid filter is deleted, and the
  campaign re-runs at k ∈ {7, 6, 5, 4}. The k = 7 rows are now a **positive
  control** the prober has never had (it has never produced a k = 7 SAT).
* **`build/m36-design.py`** (new, free arithmetic only — exact `Fraction`s): the
  independent re-derivation of C2/C3 — every same-colour offset in a window far
  wider than the certificate's, the equality census (which offsets are tight),
  the two shape mutations, the coefficient mutation, and a direct hunt for a
  monochromatic unit-distance pair (sampling can only refute, which is its job).
* **`scripts/Axioms.lean`**: gains `plane_colorable_seven` and the interval
  theorem.

## §0c — Registered predictions (bands committed before any instrument runs)

* **P1 [high]** — the design script confirms C2/C3 exactly at
  `(4/5, 3/5, 2/5)`: every same-colour offset with `|dr| ≤ 8`, `|dc| ≤ 12`
  satisfies `q ≤ lo ∨ hi ≤ q` at `q = 1`; the tight offsets are **exactly** the
  orbit of `(0,0)` (upper end, `hi = 1`) and the orbit of `(±1, ±2)` (lower end,
  `lo = 1`) — a prediction of *which* rows are tight, not merely that some are;
  and ≥ 10⁶ structured unit-distance pairs (including corner-adversarial ones
  within 10⁻⁹ of the tight configurations) yield **zero** monochromatic pairs.
  Any violation ⟹ C2/C3 wrong ⟹ halt, re-derive, revert to §H.
* **P2 [high]** — `sevenBrick.check [1] = true` by `decide +kernel`, under
  60 s of kernel time on the desktop; the whole module builds in one batch.
* **P3 [high]** — the mutation audit refuses in all three directions:
  `{sevenBrick with h := 1/2}` (diagonal² = 89/100 < 1, the `(1,2)` offset
  straddles), `{sevenBrick with w := 1}` (diagonal² = 34/25 > 1, the self-offset
  straddles), and the coset-coefficient mutation `(i + 2j) mod 7` — whose kernel
  is *not* an ideal and contains `−2 + ζ₆` of norm 3, putting a same-colour pair
  at the `(−2, 1)` offset with `lo = 4/25` and `hi = 136/25` — must all give
  `check [1] = false`. This pins the geometry AND the 3 as load-bearing.
* **P4 [high]** — axioms exactly `[propext, Classical.choice, Quot.sound]` on
  `plane_colorable_seven` and the interval theorem; the gate green (build, zero
  sorry, lint silent, spec examples passing).
* **P5 [medium-high]** — the corrected prober finds k = 7 brick colourings —
  its **first k = 7 SAT ever** — at the boundary-tight shapes, and the found
  models re-validate through the independent formula. Failure ⟹ the prober's
  mirror of the relaxed check is wrong (diff it against the design script row by
  row; the Lean side is unaffected either way, since the certificate is decided
  and not searched).
* **P6 [high — the soundness guard]** — every k = 4 row still refuses under the
  relaxed check. **Any k = 4 SAT is instrument catastrophe**: halt everything,
  report to Kooshi, treat the relaxation as unsound.
* **P7 [low — the honest long shot, band stated so a find cannot be over-read]**
  — the k = 6 and k = 5 campaigns refuse at every probed shape, reported as
  resolution-bounded ceilings. If either SATs: **halt the campaign**, re-validate
  in the design script, certify through `Brick.check` in the kernel, and report
  to Kooshi before writing a word of interpretation — a k = 6 find is
  χ(ℝ²) ≤ 6 and a k = 5 find is χ(ℝ²) ≤ 5.
* **P8 [medium-high]** — the whole milestone inside one desktop-day, with **no
  SAT anywhere on the main path**: the certificate is decided, not searched, and
  the campaign is a side probe whose failure cannot block the headline.

## §0d — Instruments to build or touch

`build/m36-design.py` (new, exact rationals, self-testing: a planted violating
offset must be caught, the Nine parameters must reproduce M35's accepted rows,
and the three mutations of P3 must be rejected); `tools/periodic.py` (the check
mirror + filter removal + campaign verbs); the three Lean modules of §0b. No new
visualizer — this milestone produces a theorem, not an explorable object; the
closure explorer and the anatomy pane are untouched.

## §0e — Costs, machine, discipline

Desktop (32 cores, 125 GB; `nproc` confirmed at subplanning). Builds ONLY
through `./scripts/build.sh`; one heavy job at a time; the campaign runs
`python3 -u` in the background with no pipes on its output; on any segfault,
from any process, **halt and report to Kooshi**. Registered-before-run applies
to every campaign grid: a grid not written down here gets its own committed
addendum first (M35 ran four — §0i–§0l — and the discipline is what made its
misses legible). Palette symmetry is not in play (the certificate has no solver
call); the prober keeps its first-occurrence breaking unchanged.

## §0f — Failure clauses

* The open-box soundness proof resists ⟹ revert to §H (hexagons), whose price is
  already named; the milestone's headline is unchanged, only its cost.
* The design script refutes C2 or C3 ⟹ halt, re-derive, and treat the whole
  §0a as suspect before touching Lean.
* `decide +kernel` cannot close the 99 × 49 scan ⟹ bit-packed `Nat` table,
  instance-side (M35 §0l), no `Brick.lean` change.
* The k = 4 mass red fires ⟹ **the relaxation is unsound**; revert `check`,
  halt, report.
* Any segfault ⟹ halt and report to Kooshi (standing, hardware).

---

# §H — The hexagon route (SUPERSEDED by §0a C1–C3 at subplanning; kept live as
# the fallback, per the deprecate-never-delete rule)

*Written at M35's close as the milestone's main path; demoted the moment the
open-box argument showed the existing brick machinery already suffices. It
remains the fallback if the sharpened soundness proof does not close (§0f), and
it is the natural home for any future cell family richer than rectangles.*

The hexagonal cell decomposition at diameter D, centres on the triangular
lattice at pitch `p = D·√3/2`:

* **Within one cell** any two points are ≤ D apart; choose D < 1 and the unit
  distance never occurs inside a cell.
* **Colour by cosets of the norm-7 ideal**, exactly as C2 does — same map, same
  two-line separation argument: same-coloured centres differ by `τ·μ` with
  `|τμ|² = 7|μ|² ≥ 7`, so they are ≥ `√7·p` apart. Norm multiplicativity, no
  lattice enumeration, no shell census.
* **Cross-cell** `|z − z′| ≥ √7·p − D = D(√21/2 − 1) ≈ 1.29·D`, so the
  admissible window is `D ∈ (2/(√21 − 2), 1) ≈ (0.775, 1)`, and D = 7/8 leaves
  margins ≈ 0.13 on both sides.
* The **only** genuinely geometric obligation is the cell assignment: a total
  `round : ℂ → centres` with `|z − round z| ≤ D/2`. Candidates: (a) axial
  rounding to a rhombus plus a nearest-of-three-corners correction (total by
  construction, floors and comparisons only); (b) nearest centre with
  lexicographic tie-break (needs a well-definedness lemma). The new arithmetic
  layer is **ℚ(√3) with decidable order** (ℚ × ℚ, sign of `a + b√3` via `a²`
  against `3b²` over four sign cases, ~50 lines).

Note what §0a bought by comparison: the hexagon's advantage over the brick is a
*positive margin*, and the open-box argument shows a positive margin was never
required. The hexagon route's ~300 lines buy nothing the 49-entry table does not
already deliver — which is precisely why it is the fallback and not the plan.

---

# The skeleton (committed with this subplan; every leaf a `sorry` or a
# `decide` that runs)

`Brick.lean`: `check` relaxed; `sq_lt_hi`, `lo_lt_sq`, `lo_le_sq` stated;
`sound` re-stated with `0 < q`; `avoids` re-stated. `Instances/Seven.lean`:
`sevenBrick`, `sevenBrick_check`, `plane_colorable_seven`, the spec block (the
`colorQ` twin against the design script's samples, the three mutations of P3,
the boundary-tightness `#guard` that `hi` at the self-offset is exactly 1).
`Instances/Interval.lean`: the interval theorem. The specification elaborates
before any proof effort is spent; the proof bodies are the implementation pass.

---

# §R — Results (opened at the skeleton; every verdict at face value)

* **P1 CONFIRMED, including the sharp part** (`build/m36-design.py`, exact
  rationals, self-tests green both ways): at `(w, h, s) = (4/5, 3/5, 2/5)` the
  offset census over a window padded 6 rings beyond the certificate's own found
  **69 clashing offsets, 0 straddling**, and the tight offsets are **exactly**
  the three predicted rows — `(0,0)` tight at its upper end, `(±1, ±2)` tight at
  their lower end — which is the *which-rows* prediction, not merely the
  existence of tightness. The refutation hunt ran **3,803,904 exact
  unit-distance pairs** (624 Pythagorean directions × 6,096 points, including
  points within `10⁻¹²` of every tight corner) and found **no monochromatic
  pair**. The planted red partner (`h := 1/2`) was caught by both the census and
  the hunt.
* **P3 CONFIRMED, one control beyond the registration**: the two shape
  mutations and the coset-coefficient mutation all refuse, and so does a fourth
  added at implementation (shear `0` — unstaggered rows are not the hexagonal
  lattice).
* **P2 CONFIRMED at the skeleton, far inside its band**:
  `sevenBrick.check [1] = true` by `decide +kernel`, with the whole module —
  certificate, twelve `#guard`s, both boundary-tightness pins, all four
  mutations — elaborating in **2.53 CPU-seconds** (desktop, min of three;
  band was 60 s). The bit-packed fallback is not needed.
* **The M35 artifact reproduced, in the same script**: the same object fails
  M35's strict check. The refusal that produced G20 is now a controlled
  observation rather than an inference.
