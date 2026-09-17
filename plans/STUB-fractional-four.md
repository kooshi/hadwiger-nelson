# FS-58 — four colours beyond the residue method: the fractional route over number fields

*Minted 2026-09-16 at FS-56's close. Written for a session with zero conversation memory. Read beside: `plans/FS56-quadratic-167.md`
(§1 the field blow-up, §2 the ratio-bound reading, **§D the measurements this stub starts from**), `plans/FS56-field-blowup.md`,
`CLAUDE.md` G55, G59, **G60**; `BIBLIOGRAPHY.md` `[MatolcsiEtAl2025]`, `[DuczVarga2026]`, `[AmbrusEtAl2023]`, `[BachocEtAl2014]`,
`[OliveiraVallentin2010]`.*

## 1. The question, in plain language

Our local–global conjecture says the plane over a real number field `F` needs exactly `L(F)` colours when `L(F) ≤ 6`, where
`L(F)` is the best bound its usable residue planes give. The first two levels are theorems for every real field (GPT Astra, G55):
`χ = 2 ⟺ L = 2`, and `L = 3 ⟹ χ = 3`. **Whether `L(F) ≥ 4` forces `χ(F²) ≥ 4` is open for every field without `√3`** — and for
every field with no small usable prime it is out of reach of every instrument this project had before FS-56, because a lower
bound over such a field cannot come from a residue plane, and the chain theorem needs a finite forcer nobody knows how to build
without triangles.

FS-56 found the instrument that can see it: **a fractional colouring argument**. For any finite `H ⊂ F²`, the geometric fractional
chromatic number `χ_gf(H)` bounds `χ(F²)` from below, because `[MatolcsiEtAl2025]`'s blow-up never leaves the field
(`plans/FS56-field-blowup.md`, proved there; it gives `χ_f(ℚ(√3,√11)²) = 4`). So **`χ(F²) ≥ 4` follows from one finite `H` with
`χ_gf(H) > 3`**, checked by `tools/fs56_gf_check.py`.

## 2. What is known, and what stopped FS-56

* **Ceilings** [theorem]: `χ_f(F²) ≤ χ_f` of every usable residue plane, and `≤ 4.36` (Croft). A field with an `𝔽₃` place is capped
  at 3 (and is 3-colourable anyway); `ℚ(√11)`, `ℚ(√23)` at `χ_f(Γ₇) = 3.5`; `ℚ(√167)` at 4.36. So the route can prove at most
  `χ ≥ 5`, and `χ ≥ 5` needs `χ_gf > 4`, which `[DuczVarga2026]` achieved in the full plane only with a hand-guided augmentation.
* **The ratio-bound reading** [reading, `data/fs56/local-ratios.out`]: the Delsarte–Hoffman bound on pieces `Cay(ℤ⁴, W)` should
  approach `1 − 1/m` with `m` the least local character mean over the places where the unit circle is compact — the real place
  gives `J₀`'s minimum −0.40276, `𝔽₃` gives −1/2, `𝔽₇` −0.5617, `𝔽₂₃` −0.3317 — provided the split places are controlled. For ℚ(√167)
  every compact place reads above −1/2, which would give `χ_f(ℚ(√167)²) ≥ 3.48` and `χ ≥ 4`.
* **Small height is starved** [exact, `data/fs56/q1/`]: unit vectors of ℚ(√167)(i) with denominator dividing 84 … 10,920 number
  20 … 324; **no triangles, no 5-cycles**, shortest odd cycle **7** (at denominators 420 and 2184); the lattices they span admit
  additive 4- or 5-colourings up to denominator 5,460; the 125-point union of all 7-cycles through a point has `χ_f ≤ 2.75`; the
  radius-3 balls — **37,681 points at denominator 420 and 215,409 at 2184 — are 3-colourable** (verified exhaustively). A triangle-rich
  graph (`G27`) starts from `χ_f = 3` and pairs lift it to 3.722; ℚ(√167)'s pieces start below 2.75.

## 3. Routes, cheapest first

* **R1 — the equidistribution theorem (a derivation, the programme's preferred shape).** State and prove: for a real number field
  `F` and a Følner-type family of weighted unit vectors (bounded height, weights balancing the split places' valuation shells), the
  least character mean over `Cay(ℤ[W], W)` tends to the least local mean over the compact places. Consequence: `χ(F²) ≥ 4` for every
  real field whose compact places all read above −1/2 — a class theorem, with ℚ(√167), ℚ(√887), ℚ(√1055), ℚ(√2351), ℚ(√4703) as
  instances and the conjecture's level-4 clause for all of them. The analytic core is character sums over rational points of the
  norm-one torus of `F(i)/F` (Weyl-type sums over the conic `x² + y² = 1` over `F`; the split places are where `z ↦ τ/τ̄` has
  unbounded valuations). *Prior-art gate first*: equidistribution of rational points of bounded height on tori and conics over number
  fields (Duke; Peyre; the Manin-conjecture literature for tori), and the Hoffman bound for Cayley graphs of discrete abelian groups
  (`[BachocEtAl2014]`).
* **R2 — the level-2 programme at height.** Pair-geometric fractional colourings of structured pieces at denominator ≥ 2,184,
  solved by stabilised column generation (FS-56 measured plain column generation degenerate at level 2) or on symmetry-reduced
  orbit variables; the certificate needs a new proof of inequality (iii) — "every independent set weighs ≤ 1" — for graphs whose
  independent sets cannot be enumerated (a pseudo-boolean proof log, or a decomposition of the weights).
* **R3 — SAT at height.** Radius-4 balls, or denominator 10,920 at radius 3 (10⁶–10⁷ points); a refusal is an LRAT certificate and
  a kernel-reachable `χ(ℚ(√167)²) ≥ 4`. Cheapest to try, least likely to land: the fractional ceiling is not the obstacle, the boundary
  of a finite ball is.
* **Side target**: `ℚ(√11)` and `ℚ(√23)` (`L = 4`) by R2 or R3, where a certificate proves the conjecture's value exactly; the
  ceiling 3.5 leaves a narrow window, and R1 does not apply (their `𝔽₇` place reads −0.5617).

## 4. Registered expectations (candidates, to be registered at the subplan)

* R1's statement is true for ℚ(√167) (medium; the reading has held at every field where `χ` is known).
* R3 at radius 4, denominator 420, is 3-colourable (high).
* Both outcomes of each must be confirmed reachable before running (`CLAUDE.md` § The gate).

## 5. Failure and jackpot clauses

* **Jackpot:** R1 proved — the conjecture's level-4 clause for an infinite family of fields beyond the residue method, and the first
  lower bound above 3 for any real quadratic field's plane.
* **Informative failure:** a field in R1's class with a 3-colourable plane — the reading and the conjecture's level-4 clause fail
  together, at a field with no small usable prime.
* **Not a failure:** R2/R3 plateaus; they measure finite pieces.

**Bearing on χ(ℝ²) ≥ 6:** none directly — the route caps at proving five. Its value is the conjecture's lower levels over the fields
the residue method cannot touch, which is where FS-56's prediction for ℚ(√167) (six or seven colours) lives.
