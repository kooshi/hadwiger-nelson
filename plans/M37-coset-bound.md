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
* Any crash: HALT and report to Kooshi (standing, hardware).


## §0e — Domain modeling pass (2026-08-11, fresh invocation)

**D1 — The plane is the ADDRESS SPACE, and ℂ enters through exactly one
lemma.** Every point the proof constructs — the deep holes, the collinear sweep
points, the corner sweep points — is the embedding of a *rational* address:
`h = emb p (1/3, 1/3)`, and `s·u` for `u = d/‖d‖` is `emb p` of a real multiple
of `d`. So the whole argument lives in `ℝ × ℝ` under the form
`hexQ (x,y) = x² + xy + y²`, with `dist (emb p u) (emb p v) ^ 2 = p² · hexQ (u − v)`
as the single bridge. **No `Real.sqrt 3` appears anywhere**, which is the
difference between this module and the existing ℤ[ζ₆] machinery
(`Ladder`/`Hexagram`/`MetaLadder` all carry radicals because they work in ℂ
coordinates). The lattice is `latt p v = emb p (v : ℝ × ℝ)` for integer
addresses; Mathlib's `ZLattice`/`Zspan` were considered and rejected — they
would buy covolume and fundamental-domain theory this proof never uses, and
would hide the form, which is the whole content.

**D2 — One form, used at integer and real addresses alike.** `hexQ` over `ℝ`
serves the geometry; the arithmetic facts (Loeschian, the shell table) are
stated as ℤ-polynomial claims and cross the boundary by `push_cast`. A parallel
`ℤ`-valued copy was considered and rejected as the Bool/Prop-drift smell in
another costume. The polarization `hexIP u v = 2u₁v₁ + u₁v₂ + u₂v₁ + 2u₂v₂`
(twice the inner product, so it stays integral on the lattice) with
`hexQ (u − v) = hexQ u − hexIP u v + hexQ v` is the only identity the geometry
needs.

**D3 — The colour map is a homomorphism, and that hypothesis is LOAD-BEARING in
a way worth stating in the docstring.** `φ : (ℤ × ℤ) →+ A` with `A` an additive
group: the proof needs exactly `φ d = 0 → φ (j • d) = 0` (C3/C4) and
`φ u = φ v → φ (u − v) = 0` (C6), which is precisely what a hom into a group
gives and nothing more. Drop homomorphy and the theorem is FALSE as stated —
an arbitrary colouring of the lattice addresses by nearest-point rounding is a
colouring of an annulus graph on the lattice, whose chromatic number at fine
scales is the plane's own open question. So the milestone bounds *coset*
colourings and says so; the gap between coset and arbitrary is exactly where a
six-colouring would have to live.

**D4 — The conclusion is the rainbow, not the cardinal.** Primary statement:
the seven closed-shell addresses receive pairwise distinct colours — a concrete
seven-point object, and the same one M35's hex shell already names. The
cardinality reading (`7 ≤ Fintype.card A`) is a corollary for readers who want
the number. This keeps `Fintype` out of the main theorem's hypotheses.

**D5 — One interface to the rounding hypothesis.** `rnd` is used only through
`rnd_eq_of_lt`: *if the address `w` is strictly closer to `v` than to every
other lattice address, then `rnd (emb p w) = v`* — which is where "any
tie-breaking" is discharged once and for all. Both sweep families instantiate
it; naming it is a collapse, not speculation.

**D6 — C4's six cases are DATA, not a transport.** The six norm-4 vectors each
need a deep hole whose functional takes the value 2 there. Transporting one case
by the lattice's ζ₆-automorphism would require the automorphism as an object
plus its compatibility with `rnd`, `φ` and distance — three lemmas to save six
instantiations of one. Instead: `hole : Fin 6 → ℝ × ℝ` explicitly, the two
master facts (`hexIP (hole i) v ≤ hexQ v` for every `i` and integer `v`; every
`Q = 4` vector has an `i` with `hexIP (hole i) d = 2`) proven by `Fin`-case
analysis and finite arithmetic, and the C4 argument stated ONCE, parametrized
by `(d, i)`.

**D7 — Non-vacuity, honestly.** The hypothesis set includes properness, which
is the expensive half of C7, so the Lean module does NOT exhibit a proper coset
colouring — and a theorem whose hypotheses might be unsatisfiable proves
nothing. Two mitigations, both stated in the docstring rather than implied:
(i) the CONCLUSION is exhibited — the norm-7 coset map does give the seven
shell addresses seven distinct colours (one `decide`), so the theorem's
consequent is achievable; (ii) satisfiability of the full hypothesis set is
C7, confirmed tools-side (the admissible window `p ∈ (0.671, 0.866]`), with the
Lean instance named as priced future work. The honest reading is the
contrapositive, which is manifestly non-vacuous: *a coset colouring with six or
fewer colours always has two points one unit apart sharing a colour.*

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

* **P6 CONFIRMED, and P8's stretch goal landed too** — `Proofs/HadwigerNelson/Coset.lean`,
  zero `sorry`, axioms exactly `[propext, Classical.choice, Quot.sound]`, build green,
  lint silent, 459 clean at the audit. Both halves:
  - **the bound** — `Coset.seven_values` (in a proper coset colouring the seven lattice
    points of the closed first shell take seven pairwise distinct colours) and
    `Coset.seven_le_card` (hence at least seven colours);
  - **sharpness** — `Coset.exists_proper_coset_colouring`: the norm-7 ideal at scale
    `6/7` IS a proper nearest-point coset colouring with seven colours, so the bound is
    attained; and `Coset.coset_chromatic_eq_seven` states the two together.
  **The coset chromatic number of the plane is exactly seven.**
* **The four sweeps landed as designed** and the obligation pass's reframing held: the
  covering argument became explicit WITNESSES (a gap lemma for kernel norms below four,
  `j = ⌊(T+1)/2⌋` with a seam case at norm exactly four), so no induction over `j` was ever
  needed. Every rounding claim goes through one `NearestUnique` interface, which is where
  "ties broken arbitrarily" is discharged once and for all.
* **One instrument event, diagnosed not worked around**: Lean panicked
  (`Lean.Expr.appArg!`) on a `fin_cases i <;> [tac; tac; …]` list combinator. It is
  deterministic and input-caused — not the hardware fault the standing halt rule is about
  — and the fix was to define `hole`/`holeF` by pattern matching and use named cases, which
  is the shape the obligation skill asks for anyway.
* **Citation drift, again as M35 warned**: `le_or_lt` → `le_or_gt`, `lt_or_le` → `lt_or_ge`
  at this pin; `zsmul_eq_mul` rewrites `j • d` on `ℤ × ℤ` through the RING structure and
  must be avoided in favour of `Prod.smul_fst`/`smul_eq_mul`.

## What was NOT done (honesty ledger)

* **The general-lattice case is open and priced.** The theorem is about the TRIANGULAR
  lattice. For a general planar lattice the same four sweeps give the shape of the
  argument, but the endgame changes: the Loeschian arithmetic is replaced by the values of
  an arbitrary binary quadratic form, and the bound `k ≥ 7` needs Hermite's constant plus
  the covering-radius optimum — both attained only by the hexagonal lattice — so the case
  `k = 6` requires a near-equality rigidity argument (reduction theory). Worked by hand at
  subplanning: the crude chain gives `k > 16/3`, i.e. `k ≥ 6`, for every lattice, and the
  square lattice needs `≥ 9`; the missing piece is the shape-space case analysis. Not
  attempted tonight.
* The theorem bounds COSET colourings. Dropping homomorphy makes it false (the module says
  so), and that gap is exactly where a six-colouring would have to live.
* `lean4checker` replay — deferred per standing policy (publication gate).
