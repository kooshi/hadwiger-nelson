# M23 — The pivot triangle and the metapivot system (STUB)

*Stub written at M22 close (2026-08-08). Carry-forward notes only; the real subplan is
written when M23 opens, per WORKFLOW step 3. Sources: the M21-close horizon (preserved
verbatim at the bottom of `plans/M22-partner-closure.md`), Kooshi's triangle/metapivot/
recursion observations (2026-08-08, recorded there), and what M22 landed.*

## What M22 hands this milestone

* **The general gluing classification is certified** (`Glue.lean`,
  `sphere_inter_sphere`): any two distinct centres, any radii under the annulus
  condition — intersection = {gluePoint, its reflAxis mirror}; empty cases both ways;
  the unit-axis bridge to M21's `reflAcross`. The metapivot's axis-1/√3 couplings are
  *already spec-exampled* (the centroid's 120°-partners about a pivot are the
  `(1, 1/√3)` instance — proven in the module's example set). The triangle work opens
  with its geometry lemma base in place, general-radius trigger fired and paid.
* **The near-relation spectrum is a committed artifact** (`build/m22-near.json`,
  regenerable by `tools/couple.py --near`): ladder records at the CF denominators
  l = 1, 4, 5, 9, 59; every probed far pair almost-cycles under 0.3°. The l = 9 row is
  kernel-certified in Lean (`Glue.zeta6_mul_seam_pow_nine_ne_one` — it does NOT close;
  `normSq_zeta6_mul_seam_pow_nine_sub_one_lt` — it misses by chord < 1/50).
* **The kill mechanism has a named clamp specification** (`build/m22-kills-695-2044.json`,
  `tools/couple.py --kills`): outer relaxation revives every kill, inner 75%; π_a cores
  are 4–8 pins (median 6) leaning inner-a. Gadget design starts from this, not from the
  closure algebra (M20's battery: zero kills from closure-flavoured gadgets).
* **The partner web is nearly closed** (`--partner`): 67–70% gen-1 collisions, k = 4
  SAT through two generations — depth alone will not force the fork; the triangle's
  *cyclic* constraint flow is the structurally new ingredient this line needs.

## The object (from the horizon, unspent)

Three pivots pairwise at distance 1 — at 0, 1, ζ₆ the coupling directions are 1, ζ₆,
ζ₃: **hex-commensurate, so exact closed loops exist that the pair's incommensurability
forbids** (M21 phase scan: no relation at any pair; M22 §0-B: near-cycles only). The
circumcentre = centroid sits at 1/√3 from all three pivots — on all three inner
circles, the first triple glue point, and by M18's identity the pivots are a rainbow
unit triangle in its 1/3-class: a self-seeding fourth system. Full object: 8 circles,
4 centres; pivot/metapivot duality (the metapivot of {c, rot3 p c, rot3² p c} is p);
recursion 8·3 + 2 = 26 circles with a three-layer role-overlapping incidence structure
and 3 free rotational phase moduli — the spindle-tunable witness factory.

## Candidate threads (rank when the subplan opens)

1. **The triangle's exact loop algebra** — the analogue of M21 §0-C at the three
   coupled pairs simultaneously: which words in the three systems' operators close
   exactly (they exist here — hex-commensurate directions). Instrument first, then
   Lean for anything that lands. The cyclic flow A→B→C→A is the entanglement
   mechanism Kooshi's feedback-loop intuition names; the pair could not have it.
2. **χ of the triangle system** — the M21 joint instrument at the three-pivot object:
   sampled pattern triples, cross-chord + ambient kills, coverage floor. The
   coupled pressure was 52%/32% at one pair; three mutually-coupled systems plus the
   metapivot is the smallest configuration where compounding is possible.
3. **Colour closure at the gap distance** (the M22 exactness thread's open question) —
   does a 4-colour equality-transmitting gadget exist at d = |ζ₆σ⁹ − 1| (chord
   ≈ 0.0176, exact in ℚ(√3,√11,√33))? SAT-testable with the M17 gadget machinery; a
   negative is reportable. The kill census's 6-pin cores say transmission at gadget
   scale is real in this system.
4. **The metapivot as a fifth system** — adjoin the centroid's two circles to the
   pair/triangle lattice (Glue supplies every intersection); re-run floor and joint.
   Smallest-witness angle (Kooshi): the recursion is a structured witness factory —
   `construct.spindle` + `field.py` already hold the spindle move.

## Registered-prediction candidates for the M23 §0 pass

* **Seam alignment of kill cores** (from M22 §6.4, post-hoc at one pair, refuted for
  near-cycle specificity but strongly carried by the pure seam lattice): at fresh far
  pairs, core-pin angular separations concentrate on {j·θσ mod 60°} and deplete at
  the half-offset. Register the effect size and the decoy protocol BEFORE running.
* The clamp-design consequence: a candidate killing gadget whose pins sit at
  seam-multiple separations outperforms one at random lattice separations, measured
  by profile shrinkage (M20's battery metric).

## Mined from the `opus-larp` branch (Opus 5's parallel M21/M22, evaluated 2026-08-08)

* **Adopted into main** (verified, negative-controlled): the `inter_eq_pair`
  factoring of `Coupled.lean` — the four unit-axis gluing classifications as four
  instances of one ratio-parametrized lemma. M23's three unit-separated pivot pairs
  will instantiate it directly (no discriminant work — two norm facts per gluing).
* **sympy 1.14 is installed** and does exact arithmetic in nested-radical fields
  (~35 µs/op at degree 8) — it lifts `tools/field.py`'s multiquadratic-only ceiling.
  Use it as the arbiter for field-membership questions (the branch caught its own
  checker bug that way, with five planted controls).
* **Field-growth numbers, superseding M22's C3 triage**: branch-side sympy-exact
  measurement — 76% of (point, circle) adjunction instances are FREE (radicand
  already square in ℚ(√3,√11)); 51.4% of distinct radicand classes; 92→162→249
  non-free radicands by depth 12→30 (no global tower). M22's 37.5% PSLQ figure
  sampled only non-collided partners — narrower population, weaker method.
* **Branch-side triage worth re-validating if the ≤ 5 thread opens** (its parallel
  instrument, NOT validated by ours): free-partner closure to 10,548 all-exact points
  stays k = 4 SAT with edge density FALLING (2.52 vs 2.98 edges/point — "boundary
  faster than interlock"); the bi-sector cell family (cells = circle × sector-p ×
  sector-q) is 4-colour UNSAT / 5-colour SAT on the continuum at every width 60°→5°.
  Its `PairColouring.lean`/`SphereInter.lean` skeletons (all-`sorry`, honest banners)
  hold a reusable DESIGN: sign-test sectors on `ZMod 6` (no `arg`), the two-reals
  `signSeq` reduction via ζ₆² = ζ₆ − 1, and a `Locus` inductive naming the
  double-membership points as constructors. Its claim that the ten double-membership
  points *explain* the mesh failure is unsupported by our curve-level data — treat as
  hypothesis, not finding.
* **Naming hazard**: Mathlib's root-namespace `discrim a b c` is the quadratic
  discriminant, same arity as a circle-pair discriminant — an unqualified `discrim`
  def would shadow silently. If M23 mints the discriminant as a def, name it
  distinctly.

## Standing constraints

Writeups/upstreaming deferred (2026-08-04). Builds via `scripts/build.sh` only.
Segfault ⇒ halt and report. One heavy job at a time. Killed patterns become claims
only through the kernel route. Predictions registered BEFORE instruments (the M22
discipline held and paid — B2/C3 refuted cleanly; keep it).
