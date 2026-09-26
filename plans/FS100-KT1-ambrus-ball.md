# FS-100 KT-1 — `[AmbrusEtAl2023]`'s obligation H4 in ball arithmetic (crunch job J49)

*de Bruijn, Opus 5.5, 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J49-KT1-ambrus-ball-arithmetic.md` (with `STANDING-RULES.md`).
Resuming: read this file and the brief, check the last SAVED stage against `git log -- plans/FS100-KT1-ambrus-ball.md`, and continue at
the first stage not SAVED.*

## Theorems this phase proved

*(filled at Stage 3)*

## "Would have searched here" log

- Would have located the true minimum of `W` on `[0, 10⁴]` by a root-finder on `W′` and certified around it — not done: the brief fixes
  J26's own evaluation points and derived constants, so the check is a fixed, finite set of ball evaluations whose extent J26's covering
  fixed first (a complete exact evaluation of a finite set, logged here as at the edge of the ban, allowed).
- Would have tuned the grid until the margin closed — not done; the grid is J26's, unchanged. A refinement is run only if the verdict is
  `inconclusive`, and then with its shape fixed before it runs (Stage 3).

## Stage 1 — SAVED: the obligation, J26's repair, and what "certified" means here

### 1.1 Every quotation in the brief, checked against its source (standing rule 5)

| # | the brief says | the source says | verdict |
|---|---|---|---|
| Q1 | "`m₁(ℝ²) ≤ 0.2470`" | the paper (held v3, p. 4), Theorem 1: "Any Lebesgue measurable, 1-avoiding planar set has upper density at most 0.2470." | matches (the formula is the theorem's content; `m₁` is the supremum of upper densities, eq. (1)) |
| Q2 | "the paper's "interval arithmetic" for H4" | the paper p. 18: "This can be lower bounded by using interval arithmetic (note that \|J0′ (t)\| = \|J1 (t)\| < 1), which shows that ϕ(t) > 1 − µ with µ = 0.00006 for t ∈ [0, T ]" | matches |
| Q3 | "grid sampling plus a derivative bound, and that bound omitted chain-rule factors" | `plans/PA-ambrus2023-audit.md` §2.4, row "H4, the argument": "the step "min on a grid of spacing h, plus L·h" uses a Lipschitz constant that omits the chain-rule factors `d_ij` and the weights … "interval arithmetic" in the paper and notebook means *grid sampling plus a derivative bound*" | matches in substance; an unquoted paraphrase that drops "and the weights" (the notebook's constant omits both the factors `d_ij` and the weights `\|w0\|, \|w2\|`) — a narrowing, harmless here since the repaired constant carries both |
| Q4 | "not interval-certified", "a worst margin of 2.3·10⁻⁶" | `plans/PA-ambrus2023-audit.md` line 19 (J26-T1): "H4 in double precision (two independent Bessel implementations agree; not interval-certified; worst margin 2.3·10⁻⁶)" | matches |
| Q5 | "`python-flint` 0.9.0 is installed in `build/venv-flint`, and `arb.bessel_j` exists" | `build/venv-flint/bin/python -c "import flint; print(flint.__version__)"` → `0.9.0`; `arb.bessel_j(self, n)` present (docstring: "Bessel function `J_n(z)`, where the argument *z* is given by *self*") | matches; **the venv holds only `flint`** (no numpy, scipy, sympy, mpmath), which shapes the tool (§1.5) |
| Q6 | the rows the bound feeds: "T-C and T-C(A) (`plans/R88-derivation.md`); row 92's clause at ℚ(√47); T-J37-1 (the case with an archimedean part); FS-84's A⁺ and SP-Cor; T-J38-1/2/3" | `plans/STUB-measure-rigidity-three-fields.md` §6.2 table: "P4 (row 92's ℚ(√47) clause) \| loses its input"; "P5 (T-J37-1) \| … loses the case with an archimedean part"; "P7 (T-C(A)), P8 (A⁺), P9's SP-Cor \| lose their input"; "T-J38-1/2/3, row 112 (Theorem C) \| lose their input"; "T-J39-4 \| loses `Y_{F,4}`'s refusal"; `plans/R88-derivation.md` line 88: "`[AmbrusEtAl2023]` Thm 1 (`m₁(ℝ²) ≤ 0.2470`; external, computer-assisted; its certificate re-checked by J26 …)" | matches; the stub's table also lists **T-J39-4**, which the brief's list omits — carried into Stage 3's row table |
| Q7 | the stub's §6.2 quotation of J37 §4.2 | `plans/POROS-2026-09-25-wanted-poster-47.md` line 293: "*The test:* evaluate J26's own covering (`tools/j26_ambrus_check.py`'s points and derived Lipschitz constants) in ball arithmetic." | matches |

### 1.2 H4 as the paper states it (verbatim, held v3 pp. 17–18)

The function (eq. (22)): "ϕ(t) = w0 J0 (t) + Σ_{i∈[n]} w1 (i) + Σ_{{i,j}} w2 (i, j)J0 (t|xi − xj |)" — *(sums transcribed from the display)*,
"Note that, in particular, w1 (i) = 0 except for i = 1, for which we have w1 (1) = 1.059383649998022."

The obligation: "Set T = 10000. … Therefore, we have to find the minimum of ϕ(t) on the interval [0, T ]. This can be lower bounded by
using interval arithmetic (note that |J0′ (t)| = |J1 (t)| < 1), which shows that ϕ(t) > 1 − µ with µ = 0.00006 for t ∈ [0, T ] (the
global minimum of ϕ(t) is attained at t = 3.77488 . . . with ϕ(t) = 0.99995003 . . .)." Then: "we divide all the coefficients w by the
factor (1 − µ). This ensures that W (t) ⩾ 1 holds for all t ⩾ 0". So what Proposition 1 consumes is **`ϕ(t) ≥ 1 − µ` for every
`t ∈ [0, 10⁴]`** (the tail `t > 10⁴` is H5, not this job). Below, `W` is the paper's `ϕ` (J26's notation; the paper's `W` is `ϕ/(1 − µ)`).

### 1.3 H4 as J26 repaired it (addresses)

- **The derivative** (`plans/PA-ambrus2023-audit.md` line 21, J26-T2, verbatim): "`W′(t) = −w0 J₁(t) − Σ w2(i,j) d_ij J₁(t d_ij)`, so `|W′| ≤
  1.5365` on `[0, 100]`, `≤ 0.1773` on `[100, 1000]` and `≤ 0.0561` on `[1000, 10000]`".
- **The constants' derivation** (same file, §3.2 row H4b, verbatim): "`L ≤ sup|J₁| · (|w0| + Σ|w2| d_ij)` on `[0, 100]`; on `t ≥ 100`,
  `|J₁(u)| ≤ C/√u` for `u ≥ 10` with `C = √10 · M₁(10) = 0.79937` (`M₁² = J₁² + Y₁²`; `x M₁(x)²` is decreasing for `ν = 1 > 1/2`, Watson
  §13.74, sampled on `[10, 10⁴]`), so `L ≤ C (|w0| + Σ|w2| √d_ij)/√t_min`". In code: `tools/j26_ambrus_check.py` lines 288–298 (`supJ1`
  by `mpmath.findroot` of `J₀(x) − J₁(x)/x` at 1.84, times `1 + 10⁻¹²`; `C` at 40 digits; `L_a = supJ1·S1`, `L_b = C/√100·Sh`,
  `L_c = C/√1000·Sh`).
- **The grid** (lines 276–281, 314–316): the points `0`; `k·0.001` for `k = 1 … 100000`; for each of the **2,629** `k` with
  `W(k·0.001) < 0.99995 + 0.001` (scipy `j0` in double precision), the 201 points `(k − 1)·0.001 + j·0.00001`, `j = 0 … 200`;
  `100 + k·0.1` and `1000 + k·1.0` for `k = 1 … 9000`; then `np.unique` (sorted, exact duplicates merged). All IEEE doubles, hence
  exact dyadic rationals.
- **The covering** (§3.2 row H4c and lines 317–326): for consecutive points `a < b`, "`W ≥ (W(a) + W(b))/2 − L (b − a)/2` there", `L` by
  the region of `a` (`a < 100`, `100 ≤ a < 1000`, `a ≥ 1000`); J26's result: "**min lower bound 0.999942348 ≥ 1 − μ = 0.99994** (worst
  interval `[3.77488, 3.77489]`, the minimum)".
- **Provenance:** `tools/j26_ambrus_check.py` sha256 `6d46a459…`, last commit `47129311` (J26: stage 4); `g23.csv` sha256 `cbfe22f5…`;
  `verification23.nb` sha256 `7d230f20…` (the digests J26 recorded).

### 1.4 What "certified" means here

The covering inequality is sound for any Lipschitz bound `L` on `[a, b]`: for `t ∈ [a, b]`, `W(t) ≥ max(W(a) − L(t − a), W(b) − L(b − t))
≥` their average `= (W(a) + W(b))/2 − L(b − a)/2`. **Certified** means, with every number an enclosure:

1. **The constants.** Each region's `L` is an arb upper bound of J26's formula, every factor enclosed: `d_ij = √(a + b√3 + c√11 + d√33)`
   from the exact squared distance; the weights from `g23.csv` as exact rationals; `C` from arb's `J₁(10)`, `Y₁(10)`; and `sup_{u≥0}|J₁(u)|`
   bounded by a ball-arithmetic grid on `[0, 10]` with a second-derivative remainder (`|J₁″| ≤ 1`, because `J₁″ = (J₃ − 3J₁)/4` and
   `|J_n| ≤ 1` by Bessel's integral), and by `C/√u ≤ C/√10` on `u ≥ 10`. The inputs taken on citation are the two J26 took: Watson §13.74
   (`x(J₁² + Y₁²)` decreasing), and `d_ij ≥ 0.1` on the `w2` pairs (re-checked here by a ball).
2. **The points.** Each point `t` of J26's grid, an exact dyadic, gets `W(t)` as an arb ball (arb's `J₀`, whose enclosures are rigorous).
3. **The cells.** For each consecutive `a < b`: `LB(a, b) = (W̲(a) + W̲(b))/2 − L̄ (b − a)/2`, computed exactly from the ball endpoints.
   **Certified iff `min LB ≥ 1 − µ = 0.99994`** — every cell's lower enclosure plus the rigorous Lipschitz slack stays above the target.

**The three verdicts** (exit codes fixed by the brief):
- `certified` (exit 0): every cell's `LB` (from lower endpoints) is `≥ 0.99994`.
- `violated` (exit 2): some cell's margin is **certified below zero** — its `LB` computed from the *upper* endpoints is `< 0.99994`. That
  is a failure of J26's covering argument, not yet of H4; the tool reports separately whether some **point value** `W(t)` is certified
  below `0.99994` (which would falsify H4 itself at `µ = 6·10⁻⁵`). Also exit 2: a Lipschitz constant supplied to the covering that is
  below its derived bound (the argument as supplied is invalid) — reachable only by a plant, since the faithful run derives its constants.
- `inconclusive` (exit 1): neither — some cell's `LB` enclosure straddles `0.99994`.

### 1.5 The tool's shape, fixed by the environment

`build/venv-flint` holds only `flint`; J26's module needs numpy, scipy, sympy and mpmath. So **two files**:
- `tools/fs100_kt1_grid.py` (system `python3`): imports J26's module read-only (its `read_points`, `read_coeffs`, `sqdist`), rebuilds J26's
  grid with J26's own expressions, and writes `data/fs100/kt1/j26-grid.json`: the 2,629 selected `k`, the exact squared distances of the
  26 `w2` pairs, J26's float constants and float worst cell (for comparison), and the sha256 of the point list.
- `tools/fs100_kt1_ball.py` (`build/venv-flint/bin/python`, flint + stdlib only): reads `g23.csv` itself, the JSON for the grid shape and
  the squared distances, regenerates the points in Python floats (the same IEEE operations as numpy) and **asserts the point list's
  sha256 equals the exporter's**, then runs §1.4. The selection step (scipy, double precision) chooses *where* the grid is fine; it is not
  a certification step — any grid gives a sound covering — so it needs no enclosure.

## Stage 2 — SAVED: the ball-arithmetic checker and its controls

**Files.** `tools/fs100_kt1_grid.py` (system `python3`; imports `tools/j26_ambrus_check.py` read-only) → `data/fs100/kt1/j26-grid.json`;
`tools/fs100_kt1_ball.py` (`build/venv-flint/bin/python`; flint + stdlib). The exporter reproduces J26 exactly: "ok len(sel) == 2629", "ok
J26 worst lb 0.999942348 reproduced", "ok J26 worst cell [3.77488, 3.77489] reproduced"; **493,471** unique points (not ~640,000: the
refined 201-point grids of adjacent `k` overlap), sha256 `2ec0c4f6ec5e10f8…`, which the checker regenerates in Python floats bit for bit.

**What the checker does** (§1.4, implemented): `W(t)` as an arb ball at every point, from exact weights (`g23.csv`), exact squared
distances and arb's `J₀`; the constants re-derived by J26's formulas with enclosures — `Λ₁ = 0.58186522429…` (grid on `[0, 10]` step
10⁻³, 37 cells re-cut at 10⁻⁵, remainder `h²/8`; tail `C/√10`), `C ≤ 0.79936575579`, `d_min ≥ 0.2149367` (every `d² > 1/100` certified),
giving `L_a ≤ 1.536536086806`, `L_b ≤ 0.177256630507`, `L_c ≤ 0.056053468277` (J26's floats: 1.53653608678, 0.177256630507,
0.0560534682769 — agreement to the printed digits; the certified `L_a` is larger by ~2·10⁻¹¹, from the `h²/8` term); every cell's
`LB` computed exactly (Fractions) from the balls' endpoints; a necessary-condition check that no cell's difference quotient certifiably
exceeds its constant; point values certified below target counted separately. **Precision: 80 bits.** Justification: the largest Bessel
argument is `10⁴ · 2.291 ≈ 2.3·10⁴`, so an input radius of `2.3·10⁴ · 2⁻⁸⁰ ≈ 2·10⁻²⁰` per term, 27 terms, weights `|w| < 1.1`: a
predicted `W` radius near 10⁻¹⁸, twelve orders below the double-precision margin 2.3·10⁻⁶; observed on the self-test windows: max
radius **7.3·10⁻²²**. Runtime 1.4 s for 20,856 points on 4 workers, so the full grid is about 30 s on 16.

**Supplementary, beside H4 (not in its exit code):** S-H5, the tail `t > 10⁴`, by eq. (23) with a zero of `J₁` isolated in
`[999.8114, 999.8116]` by a certified sign change and `|J₀|` enclosed over that interval; S-NB, whether the notebook's "Derivative is
less than 0.03" on `[1000, 10⁴]` is certifiably false at `t = 1289.72` (the point from a double-precision scan of `W′`, max `|W′| ≈ 0.030110`
there — a measurement; the claim is then one ball).

**Controls** (`--self-test`, `data/fs100/kt1/selftest.out`, exit 0, 12.7 s; on the windows `[0.85, 0.95] ∪ [3.70, 3.85]`, 20,856 points,
containing J26's worst cell). Each plant's reason and two-sided bound are asserted:

| plant | must | result |
|---|---|---|
| none (faithful) | certify | exit 0, margin 2.348·10⁻⁶ |
| `halfL` (`L_a` halved) | red for INVALID-LIPSCHITZ, region `a` only | exit 2, `['INVALID-LIPSCHITZ']`, `['a']`; derived/used = 2 exactly; `0 <` margin rise 3.841·10⁻⁶ `≤` 3.841·10⁻⁴ |
| `notebookL` (1, 0.1, 0.03) | INVALID in all three regions | exit 2, `['a', 'b', 'c']` |
| `tinyL` (`L_a/16 ≈ 0.096`) | REFUTED by difference quotients near `t = 0.9` | exit 2, 99 refuted cells `≤` 20,736, examples in `[0.85, 0.95]` |
| `target_past_min` (0.99996) | VIOLATED, points below target | exit 2, 3,098 points below; margin drop = target shift 2·10⁻⁵ exactly |
| `target_between` (0.999945) | VIOLATED, no point below target | exit 2, 0 points below; drop = shift 5·10⁻⁶ exactly |
| `lowprec` (12 bits) | INCONCLUSIVE | exit 1; enclosure width 0.294 > 1.3·10⁻²¹; the two enclosures overlap |
| `h5_w1` (`w1 − 0.011`) | the tail check fails, H4 unaffected | tail 0.99967 not > 1; the drop encloses 0.011 exactly |
| `nb_thr` (threshold 0.0302) | S-NB must not fire | not refuted |
| `sel_drop` (one refined `k` dropped; `data/fs100/kt1/j26-grid-plant-sel_drop.json`) | NOT RUN, exit 3 | sha256 `319c3646…` (n = 493,421) ≠ `2ec0c4f6…` |

CLI failure paths read directly: `--plant target_between` → exit 2 with a stderr banner; the planted grid → exit 3 with a banner;
`--plant lowprec` → exit 1 with a banner. Success prints one line.
