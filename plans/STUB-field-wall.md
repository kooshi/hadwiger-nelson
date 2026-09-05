> **PROVED 2026-09-05** — by Kooshi's other session while writing the conjecture up: `~/field-wall-conjecture.md`
> §5 (Theorem B: χ(G(ℚ(√3, √11)²)) = 4, the residue colouring modulo a conjugation-fixed prime of K(i)
> above 2). Statement 2 below is settled in the affirmative; statement 1 is Lemma 7.2 of the note. The
> theorem's kernel formalization is the next milestone, planned by that session; this stub is kept as
> the record of how the question was posed. Checked here: `tools/residue_colouring.py` (the seed:
> 1,004/1,004 proper, 446/446 mono; the it-4 object: 13,796/13,796 proper, 344/344 mono).

# The field wall, formalized (pre-subplan stub, UNNUMBERED — Kooshi, 2026-09-03: "sounds like we need to formalize the field wall — new milestone?")

*Numbered if minted. The evidence: `plans/RISKS.md` R1/R5; T14 (`plans/STANDING-QUESTIONS.md`);
G1 (`CLAUDE.md` § Grokkings); M24–M26's seam-field closures, all χ = 4 exactly; M30's de Grey
anatomy (the 5-forcers need √5 and √7); `tools/pool_field_census.py` (which roots one iteration can
reach, with counts).*

## The two statements

1. **The lattice-closure lemma** (easy, kernel-shaped, `Glue.lean`'s corollary). A glue point of two
   points `a, b` with coordinates in a field `K ⊆ ℝ` at squared distance `d² ∈ K` has coordinates in
   `K(√(4/d² − 1))` — one square root, of an element of `K`, per point. Hence the depth-1 lattice over
   a `K`-point object lies in `K(√r₁, …, √rₘ)` for the finite radicand set `R = {4/d² − 1}` over its
   pairs, and the reachable extensions in ONE iteration are the square classes of `R` in `K*/K*²`.
   For `K = ℚ(√3, √11)`: `3` and `11` are squares, so the rational classes are `{1, 2, 5, 7, 10, 14,
   35, 70}`; `√5` needs a pair at `d² = 4/(1 + 5q²)` with `q ∈ K`, `√7` at `4/(1 + 7q²)`, `√15` at
   `4/(1 + 15q²)` (`d = 1/2` at `q = 1` — ρ₁₅'s field). The census tool measures which of these the
   current object's pairs realize and how many pool points carry each.
2. **The field-wall conjecture** (the research statement). *Every finite unit-distance graph whose
   points all lie in `K = ℚ(√3, √11)` is 4-colourable.* Evidence for: every seam-field closure
   certified here is exactly 4-chromatic (the ladder pair, the four-ladder, the hexagram — M24–M26),
   the Moser twist is a seam-group word (`FieldWall.lean`), and no known 5-forcer lives in `K`
   (de Grey: √5, √7; Heule-510: √5; Parts: φ; Haugland: a cubic field). Evidence against: none —
   but no argument either; the certified closures are the ⟨ζ₆, σ⟩-lattices, not arbitrary K-point
   sets. What it decides: TRUE ⟹ the descent must leave K to end (R1 is a theorem, and the
   mitigation is mandatory); FALSE ⟹ its counterexample is a seam-field 5-chromatic unit graph,
   which is exactly what the descent's unit part would be if it ended inside K.

## The programme, in phases (to be subplanned)

* **Kernel**: the lattice-closure lemma over an arbitrary subfield (a few dozen lines over
  `Glue.gluePoint`); the square-class reading for `K = ℚ(√3, √11)` as a spec example.
* **Measure**: the pool field census on every committed object (which roots, how many points); the
  kill census by field (of the profile's killing points, how many are out-of-field — the direct test
  of the "blind spot" reading); a design run restricted to out-of-field pool points as a control.
* **Attack the conjecture from both sides**: (a) search for a K-point 5-chromatic unit graph with the
  copy trick restricted to K-rotations (the seam group's own angles — the Moser twist, the seam σ,
  the d = 5 spindle in ℚ(√11)): every such union stayed SAT at four colours in M52's probes (the
  d = 5 rotation, the mirror, the Moser angle), which is the conjecture's evidence so far;
  (b) a proof shape for it, if one exists, would have to be a colouring of ALL of `K²`'s unit
  graph — a periodic/algebraic colouring of a countable dense set, the genre of M37–M38's cell
  colourings one level up — priced as a research question, not a sitting.

## Halt clauses

A K-point unit graph refusing four colours (found by (a)) is a HALT AND CERTIFY event twice over:
a new 5-chromatic witness AND the refutation of the wall.
