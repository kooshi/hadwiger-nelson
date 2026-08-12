# M36 — The hexagonal certificate: χ(ℝ²) ≤ 7 in the kernel (PRE-SUBPLAN STUB)

*Written 2026-08-11 at M35's close; CHOSEN by Kooshi the same day ("I agree" to
the close's recommendation A). Read order for a fresh session: this stub WHOLE,
then `plans/M35-k5-transfer.md` §0a C6, §0f D2–D3, §0g G-2, §0j–§0l and §R
(the brick machinery this generalizes and the measured negative that makes the
hexagon necessary), then `Proofs/HadwigerNelson/Brick.lean` (the architecture
to extend — its floor workhorse and window discipline carry over verbatim) and
CLAUDE.md § Grokkings G19–G20.*

## The mission, and why it clears the novelty bar

**Land χ(ℝ²) ≤ 7 as a kernel theorem** — the classical upper bound (the
hexagonal 7-colouring, Isbell's argument), completing the interval
**5 ≤ χ(ℝ²) ≤ 7 entirely kernel-side** on the standard three axioms. Under
the standing policy (formalizing known results is not a goal in itself) this
earns its place three ways: (i) M35 measured that the row-brick family
CANNOT do it (G20: ~2,800 rows, no 7- or 8-colouring at any probed shape —
the hexagon's interlock is load-bearing), so the polygon-cell machinery is
genuinely forced, not decorative; (ii) that machinery is THE promotion path
for every future periodic-avoider find — and an avoider at k = 5 is the open
upper-bound problem itself (M35 §0a C1), so the pipe must exist before any
find can be certified; (iii) the interval-complete repository is what the
eventual write-up trigger wants to stand on. The 7 is the machinery's
validation on a known-true target; the machinery is the product.

## The derivation that makes this milestone SMALL (worked at the M35 close —
## verify at §0, then lean on it)

The Brick certificate needed box-interval arithmetic because rectangles are
long and their conservative hulls are lossy. **Hexagons need none of it — the
crude triangle-inequality bound already clears the bar with margin:**

* Take the hexagonal cell decomposition at diameter D (vertex-to-vertex),
  centres on the triangular lattice at pitch p = D·√3/2 (flat-to-flat).
* **Within one cell**: any two points are ≤ D apart; choose D < 1 and
  distance exactly 1 never occurs inside a cell. One comparison.
* **Colour by cosets of the norm-7 ideal**: colour(a + b·ζ₆) :=
  (a + 3b) mod 7. The kernel of this map is ζ₆-STABLE — multiplying a
  lattice point by ζ₆ multiplies its colour-residue by 3
  ((a,b) ↦ (−b, a+b) ↦ 3a + 2b ≡ 3·(a + 3b) mod 7) — so the kernel is an
  IDEAL containing τ = −3 + ζ₆ of norm 7, hence equals (τ) by index.
  Therefore any two same-coloured distinct centres differ by τ·μ with
  |τ·μ|² = 7·|μ|² ≥ 7 — **norm multiplicativity gives the separation in two
  lines**, no lattice enumeration, no shell census.
* **Cross-cell same colour**: z, z′ in different same-coloured cells at
  centres c ≠ c′: |z − z′| ≥ |c − c′| − |z − c| − |z′ − c′| ≥ √7·p − D
  = D·(√21/2 − 1) ≈ 1.29·D. Choose D with 1.29·D > 1 and D < 1: the whole
  admissible window is D ∈ (2/(√21 − 2), 1) ≈ (0.775, 1); **D = 7/8 gives
  margins ≈ 0.13 on both sides** — comfortably clear of every boundary
  subtlety. Triangle inequality; no slab witnesses, no per-pair decides.
* So the ONLY genuinely geometric obligation left is the **cell assignment**:
  a total function round : ℂ → ℤ[ζ₆]-centres with |z − round(z)| ≤ D/2
  (circumradius). Everything else is the two-line norm argument plus the
  arithmetic above.

**The cell-assignment candidates** (the subplan measures and picks):
(a) axial-coordinate rounding — express z in the (1, ζ₆) basis (a linear
transform with √3), floor both coordinates to a rhombus, then assign the
rhombus's points to one of its ≤ 3 nearby hexagon centres by at most two
sign comparisons (the standard hex-grid rounding, made half-open); (b)
nearest-centre with lexicographic tie-breaking. Route (a) is total by
construction (floors + comparisons) and needs no well-definedness proof
beyond the circumradius bound per rounding case. Note what is NOT needed:
`Brick.lean`'s window/offset enumeration disappears entirely — the norm
argument covers ALL same-colour pairs at once, so the soundness proof never
enumerates offsets and the floor workhorse is not on the critical path. The one
new arithmetic layer: **ℚ(√3) with decidable order** — represent as ℚ × ℚ,
sign of a + b√3 by comparing a² with 3b² through the four sign cases
(~50 lines, or check whether M24-26's ℤ[ζ₆]/π machinery already carries an
ordered layer — it likely does not; it worked with equalities). The
circumradius bound per rounding case is a finite set of ℚ(√3) inequalities.

## What M35 hands this milestone

* `Brick.lean` — the architectural template (noncomputable plane colouring +
  computable rational certificate + `colorQ`-style testable twin + the
  "properness demanded structurally" guard-list discipline). The hexagon
  module is a SIBLING, not an extension: simpler soundness (triangle
  inequality replaces box intervals), one new ordered-field layer.
* The measured negative (G20) that justifies it, and the pixel-square open
  cell: **the cheap first move, run it before building anything** — one
  registered high-cap retry of the §0l pixel rows (32×32 @ 1/8 and
  40×40 @ 1/10, cap 3600–7200 s). If a pixel-brick 7- OR 8-colouring
  exists, `Brick.lean` certifies it TODAY with a bit-packed table (the
  §0l price note: `>>>`/`&&&` are GMP-backed; a match-table would be
  kernel-dead) and the milestone collapses to an instance module. Expected
  [low]: still refused/capped — then the hexagon route as planned.
* The k = 5/6 avoider consumers (`Brick.avoids`, C1 semantics) that any
  future find will route through — the hexagon module should expose the
  same `avoids` surface so richer-family avoider hunts inherit it.
* `tools/periodic.py` — if a candidate SEARCH is ever wanted for hex-cell
  patterns; for the 7 itself NO SEARCH IS NEEDED (the table is
  `(a + 3b) mod 7`, classical — the work is purely the certificate).

## Deliverables

* `Proofs/HadwigerNelson/HexCell.lean` (or the subplan's better name): the
  ℚ(√3) ordered layer, the hexagonal rounding with its circumradius bound,
  the coset colouring, the norm-multiplicativity separation, the soundness
  theorem in `Brick.sound`'s genre (dist² = q form, guards with 1 demanded
  structurally), an `avoids` surface.
* `Proofs/HadwigerNelson/Instances/Seven.lean`: **χ(ℝ²) ≤ 7** at D = 7/8
  (or the subplan's measured choice), `plane_colorable_seven`, and the
  read-aloud interval statement in the docstring: with M06–M09 the
  repository holds **5 ≤ χ(ℝ²) ≤ 7 end to end** on axioms exactly
  `[propext, Classical.choice, Quot.sound]` — the classical state of the
  Hadwiger–Nelson problem, fully kernel-checked, both ends.
* Spec block per house rules: colorQ-twin samples against a Python
  reference, an adversarial table (two adjacent cells same colour) refused,
  the D-window boundary cases (D = 1 and D = 0.775 must FAIL — the margins
  are load-bearing), mutation audit on the coset map (replace 3 by 2 —
  (a + 2b) mod 7's kernel contains norm-3... check: −2+ζ₆ norm 4+... a+2b:
  τ' = −2 + ζ₆ norm 4 − 2 + 1 = 3 < 7 → separation FAILS → the certificate
  must refuse; the audit pins the 3 as load-bearing).
* Frontier close per standing rule; `scripts/Axioms.lean` gains the
  headliners; the ledger row states the attribution honestly (the
  colouring is Isbell's/classical; ours is the first kernel-checked
  formalization and the reusable polygon-cell certificate machinery).

## Registered-expectation sketch (bands at §0, committed before any Lean)

* The pixel retry: refused/capped [low-medium confidence of a find].
* The ℚ(√3) ordered layer: ≤ 100 lines, all decides instant.
* The rounding + circumradius: the milestone's centre of gravity, ≤ 200
  lines; if route (a)'s case analysis balloons past ~12 cases, re-derive
  the rounding rather than grinding (the obligation-modeling dispatch).
* Whole milestone: ≤ 2 desktop-days; no SAT anywhere on the main path.

## Failure clauses (sharpen at registration)

* The ℚ(√3) sign layer fights Lean's simp/norm_num ecosystem: fall back to
  integer-scaled comparisons (clear denominators once, compare in ℤ).
* The rounding case analysis resists: switch to candidate (b)
  (nearest-centre + tie-break) and pay the well-definedness lemma.
* Both resist: the crude-bound margins (0.13) leave room for a COARSER
  assignment (e.g. assign by rhombus alone and 12-colour by a finer coset —
  χ ≤ 12 would still be a certified bound but BELOW the Nine already held —
  so this fallback is worthless; report honestly and re-plan instead).
* Any segfault: HALT and report to Kooshi (standing).
