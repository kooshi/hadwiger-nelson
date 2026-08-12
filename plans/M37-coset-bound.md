# M37 — The coset bound: every lattice colouring of the plane needs seven colours
# (SUBPLAN — §0 registered 2026-08-11, desktop, before any instrument)

*Chosen under Kooshi's autonomy authorization (2026-08-12 03:52 UTC, expiring
12:00 UTC 2026-08-12): "find rungs toward narrowing the `5 ≤ χ(ℝ²) ≤ 7`
interval, aiming for geometric intuition and Lean proofs over SAT searches."*

## The mission, and why it is a rung

M36 closed the classical interval by exhibiting a seven-colouring. The obvious
next question is whether any of the natural colouring FAMILIES can do better —
and the most natural family of all is the one every construction in the
literature belongs to: **colour each point of the plane by which class its
nearest lattice point falls into.** The classical hexagonal seven-colouring is
exactly this (triangular lattice, classes = cosets of the norm-7 ideal), and so
is every "Voronoi + coset" scheme anyone has proposed.

**The claim: that family cannot beat seven, ever — at any scale, for any
sublattice, under any tie-breaking.** Not "no member we searched": no member.
This is the kind of rung the authorization asks for — a theorem with a geometric
reason, replacing a search with an argument, and it says precisely where a
六-colouring cannot come from. It also composes with the standing programme: a
`k = 5` or `k = 6` avoider would settle the upper half of Hadwiger–Nelson
(M35 §0a C1), and this milestone rules the whole lattice-coset family out of
that hunt for a reason rather than by exhaustion.

Attribution, fixed before the work: the *statement* is folklore-adjacent (that
the hexagonal colouring is optimal among lattice colourings is the sort of thing
tiling people know); I have not found it stated in this form with a complete
elementary proof, and no novelty is claimed for the construction it bounds. What
is ours is the proof shape below, the kernel formalization, and the packaging as
a limitation theorem for the upper-bound hunt.

---

# §0 — The registered subplan (2026-08-11, desktop; committed before any
# instrument, any script, and any Lean run)

## §0a — The derivation, worked by hand and committed before it is checked

**The setting.** Fix `p > 0`. Let `Λ_p = { p·(a + b·ζ₆) : (a,b) ∈ ℤ² }`, the
triangular lattice with minimal distance `p`. Let `φ : ℤ² →+ A` be a
homomorphism to an additive group (the colour map on lattice addresses; its
kernel is the "same colour" sublattice, and homomorphy is exactly what makes the
colouring a COSET colouring). Let `rnd : ℂ → ℤ²` choose, for each point of the
plane, a **nearest** lattice address — any nearest one; ties may be broken
arbitrarily. The colouring is `c(x) = φ(rnd x)`.

**Theorem.** If `c` has no two points at distance exactly 1 sharing a colour,
then the seven addresses `0, ±1, ±ζ₆, ±ζ₆²` — the origin and the six units, i.e.
the closed first shell — receive **pairwise distinct** colours. In particular
`c` uses at least seven colours.

The whole proof runs on the integral quadratic form `Q(a,b) = a² + ab + b²`,
because `‖p·(a + bζ₆)‖² = p²·Q(a,b)`. Every quantity below is rational; no
square roots enter until the final comparisons.

**C1 — The inscribed disc.** If `‖x − λ‖ < p/2` then `λ` is the *unique* nearest
lattice point, so `rnd x = λ` whatever the tie-breaking: any other `λ'` has
`‖x − λ'‖ ≥ ‖λ − λ'‖ − ‖x − λ‖ > p − p/2 > ‖x − λ‖`. *(One triangle inequality;
this is the only fact needed about `rnd` in three of the four steps.)*

**C2 — The deep hole, and `p ≤ √3/2`.** Let `h = p·(1 + ζ₆)/3` — the
circumcentre of the triangle `0, p, pζ₆` — with `‖h‖² = p²/3`. In lattice
coordinates the inner product satisfies `2⟨h, p·(a+bζ₆)⟩ = p²·(a + b)`, so
`rnd(±t·h) = 0` for every `t ∈ [0,1)` **iff** `a + b ≤ Q(a,b)` for all `(a,b)`,
which is an identity in disguise:
`2(Q(a,b) − a − b) = (a+b)² + (a−1)² + (b−1)² − 2 ≥ 0`, with equality exactly at
`(0,0), (1,0), (0,1)` — i.e. `h` is equidistant from precisely the three
lattice points it is the circumcentre of, as it must be. Hence `+t·h` and
`−t·h` are the same colour and lie at distance `2t·p/√3`, which sweeps
`[0, 2p/√3)`. Properness therefore forces **`2p/√3 ≤ 1`, i.e. `p ≤ √3/2`.**
*(This is the only step that needs the cell's corner rather than its inscribed
disc; it is what stops the cells from being too big.)*

**C3 — The collinear sweep.** Let `d ∈ ker φ`, `d ≠ 0`, and `j ≥ 1`; then
`j·d ∈ ker φ` too. Put `u = j·d/‖j·d‖`. For `s, s' ∈ [0, p/2)` the points
`s·u` and `j·d + s'·u` round to `0` and `j·d` by C1, so they share a colour,
and their distance `‖j·d‖ + s' − s` sweeps the open interval
`(‖j·d‖ − p, ‖j·d‖ + p)`. Properness therefore forces `1` outside every one of
these intervals.

**C4 — The corner sweep, for the norm-4 directions.** C3 alone kills
`Q(d) ∈ {1, 3}` (their intervals overlap and cover `1`) but NOT `Q(d) = 4`:
there the intervals `((2j−1)p, (2j+1)p)` merely *touch*, and `1` can hide in the
seams at `p = 1/odd`. The corner closes the seams. For any `d` with `Q(d) = 4`
one of the six vertex functionals `±a, ±b, ±(a+b)` takes the value `2` at `d`;
let `h'` be the corresponding deep hole (`‖h'‖² = p²/3`). Then `−t·h'` and
`j·d + t·h'` round to `0` and `j·d` (C2 plus uniqueness of the nearest point),
share a colour, and their squared distance is
`p²·[4j² + 4jt + 4t²/3]`, sweeping `[4j²p², ((2j+1)² + 1/3)p²)`. Together with
C3 the realized squared distances cover `((2j−1)²p², ((2j+1)² + ⅓)p²)`, whose
right end **strictly exceeds** the next interval's left end — the union over
`j ≥ 1` is `(p², ∞)`. Since `p ≤ √3/2 < 1`, `1` lies in it. Contradiction.

**C5 — The arithmetic.** By C3/C4 no nonzero kernel vector has `Q ∈ {1, 3, 4}`.
`Q` takes only Loeschian values, and **2, 5 and 6 are not of the form
`a² + ab + b²`** (a finite check: `|a|, |b| ≤ 3` suffices). Hence every nonzero
`d ∈ ker φ` has `Q(d) ≥ 7`.

**C6 — The packing.** The seven addresses `0` and the six units have pairwise
differences of `Q`-value in `{1, 3, 4}` — every difference is a unit, a
`√3`-vector, or a diameter of the shell. All are `< 7`, so no difference lies in
`ker φ`, so the seven colours are pairwise distinct. ∎ **This is the same
seven-point object as M35's hex-shell K7** (`Instances/HexShell.lean`), meeting
the programme from the other side: there it forced a mono pair at `√3` or `2`
below seven colours; here it forces seven distinct colours in any coset scheme.

**C7 — Sharpness.** Seven is attained inside the family: the classical
hexagonal colouring is the coset colouring of the norm-7 ideal `(−3 + ζ₆)` at
any `p ∈ (1/(√7 − 2/√3), √3/2] = (0.671, 0.866]`  *[the registered text first
wrote the left end as `2/(√7 − 2/√3)`, a slip carried over from M36's
diameter parametrization; the design script caught it — see §R]* — e.g. `p = 0.86`, cell diameter `0.993 < 1`,
nearest same-colour separation `√7·p = 2.275`, realized distances from `1.28`
up. So **the coset chromatic number of the plane is exactly 7** and the
milestone's bound is tight. (M36's `χ(ℝ²) ≤ 7` already holds the upper half
kernel-side by a different, brick, witness; formalizing this hexagonal instance
is a stretch goal, not a requirement.)

## §0b — Definitions and contracts

* `Proofs/HadwigerNelson/Coset.lean` (new): `hexPt p v` (the lattice embedding),
  `hexQ v` (the form), `hexPt_normSq`, the inner-product lemma, the six vertex
  functionals, C1–C6 as named lemmas, and the theorem in the rainbow form
  (`the seven shell addresses get pairwise distinct colours`) plus the
  cardinality corollary (`7 ≤ Fintype.card A`).
* The colouring is modelled as `φ : (ℤ × ℤ) →+ A` composed with
  `rnd : ℂ → ℤ × ℤ` carrying `∀ x v, ‖x − hexPt p (rnd x)‖ ≤ ‖x − hexPt p v‖`.
  Homomorphy is the coset hypothesis; the nearest-point hypothesis is stated
  with `≤` so EVERY tie-breaking is covered.
* `build/m37-design.py` (new, exact rationals): the independent re-derivation —
  the `Q`-identity of C2, the vertex-functional table, the interval unions of
  C3/C4 at a grid of `p` and `j`, the Loeschian gap check of C5, the shell
  difference table of C6, and the C7 feasibility window; plus planted reds.
* `scripts/Axioms.lean`: the M37 headliners.
* No SAT, no search, no solver anywhere in this milestone.

## §0c — Registered predictions (committed before any instrument runs)

* **P1 [high]** — the design script confirms C2's identity
  `2(Q − a − b) = (a+b)² + (a−1)² + (b−1)² − 2` exactly over a grid, with
  equality exactly at `(0,0), (1,0), (0,1)`.
* **P2 [high]** — the six vertex functionals `±a, ±b, ±(a+b)` attain the value
  `2` at each of the six `Q = 4` vectors; the maximum is exactly 2 (not more).
* **P3 [high]** — the interval unions close as claimed: for `Q(d) ∈ {1,3}` the
  C3 intervals alone cover `1` for every `p ≤ √3/2`; for `Q(d) = 4` the C3
  intervals leave exactly the seam points `p = 1/(2j+1)` uncovered and the C4
  corner covers them.
* **P4 [high]** — 2, 5, 6 are not Loeschian; 1, 3, 4, 7 are; so
  `Q ∉ {1,3,4}` ⟹ `Q ≥ 7`.
* **P5 [high]** — the seven shell addresses have pairwise `Q`-differences in
  `{1, 3, 4}` (21 pairs).
* **P6 [medium-high]** — the Lean module lands with axioms exactly
  `[propext, Classical.choice, Quot.sound]`, zero `sorry`, ≤ 400 lines. The
  risk named in advance: the `rnd` hypothesis is an inequality over ALL lattice
  addresses, so each rounding claim is a `∀ v`-statement discharged by the
  `Q`-inequality — if that shape fights, the fallback is to carry the three
  needed rounding facts as explicit hypotheses of a helper lemma.
* **P7 [medium]** — the whole milestone inside four hours, no instrument beyond
  the design script.
* **P8 [low]** — the C7 hexagonal instance also lands (stretch; if it costs more
  than an hour it is deferred with its price named).

## §0d — Failure clauses

* If the nearest-point formalization resists, retreat to the Voronoi-cell
  formulation (state the colouring on a fundamental domain) and price it.
* If C4's corner argument does not close in Lean, the theorem still holds with
  the extra hypothesis `Q(d) ≠ 4` for kernel vectors — a strictly weaker
  statement that must be labelled as such, never quietly.
* If any design-script check refutes C1–C6, halt and re-derive; the whole §0a
  is suspect and nothing goes into Lean until it is repaired.
* Any segfault: HALT and report to Kooshi (standing, hardware).


---

# §R — Results (opened at the design check; every verdict at face value)

* **P1–P5 CONFIRMED, but the first run of the design script read REFUTED on
  three rows, and all three were the CHECKER.** Recorded in full because a
  self-test that fails for its own reasons is exactly what G21 warns about, and
  the only defence is to diagnose rather than patch:
  1. *"the corner covers every seam" failed at `p = 1`* — the seam grid ran
     over `p = 1/m` for all odd `m` including `m = 1`, but C2 already bounds
     `p ≤ √3/2 < 1`. Scope bug in the check; the script now enforces the C2
     bound and says so on the excluded row.
  2. *"Q = 1: C3 covers 1" failed at `p = 1/200`* — C3's union for `Q = 1` is
     `(0, ∞)`, but reaching `1` needs `j ≈ 1/p = 200` and the loop stopped at
     199. Loop-bound artifact; the bound is now adaptive.
  3. *"the C7 window is non-empty" failed* — and this one was a genuine error
     **in the registered §0a text**, not just the script: the left end of the
     admissible window is `1/(√7 − 2/√3) = 0.671`, and I had written
     `2/(√7 − 2/√3) = 1.341`, a factor carried over from M36's
     diameter-based parametrization. With the correct constant the window is
     `(0.671, 0.866]` — non-empty, so C7 stands and seven is attained. The
     registered text is corrected in place with the slip named.
* After the three fixes, every check is green: the C2 identity and its exact
  equality set `{(0,0), (1,0), (0,1)}`, the deep hole's `‖h‖² = 1/3` and
  `2⟨h,v⟩ = a+b`, the six `Q = 4` vectors being exactly `2 ×` units with a
  vertex functional of value exactly 2 on each, the seam census (C3 alone
  leaves every `p = 1/odd` uncovered; the corner covers all of them), the
  full-grid sweeps at `Q ∈ {1,3,4}` over 173 values of `p`, the Loeschian list
  `{0,1,3,4,7,9,12,13,16,19}` with 2, 5, 6 absent, the 21-pair shell
  difference table `{1,3,4}`, and the norm-7 ideal's ζ₆-stability and minimum.
  **The planted red fires**: with the WRONG vertex (functional value 0 instead
  of 2) the seams survive uncovered — the corner argument is load-bearing and
  is seen to be.
