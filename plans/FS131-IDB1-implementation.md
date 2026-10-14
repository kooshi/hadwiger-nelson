# FS131-IDB1 — the density bound's first implementer: the `J₀` covering (lane C), then the Bessel lemmas (lane B)

*de Bruijn, the implementer (Opus 5.5), 2026-10-14. Brief: `data/fs131/briefs/FS131-IDB1-covering-bessel.md` (on `main`), with
`plans/STANDING-RULES.md`. Branch `fs131-wdb1`, cut from `fs131-wdb` at `4311c0fe0`; tree `.claude/worktrees/fs131-w10g`. The plan is
the planner's record `plans/FS131-KDB1-density-bound.md` (§ 3.3 per leaf, § 4.2 the kernel cuts, § 5 the lanes). Resuming: read
this file, check its last SAVED stage against `git log -- plans/FS131-IDB1-implementation.md`, continue at the first stage not
SAVED.*

## Theorems this phase proved

Every record below is kernel-checked in the built tree of `fs131-wdb1` (build `data/fs131/idb1/build3.log`, exit 0) and its
axioms are printed from that tree (`data/fs131/idb1/axioms.txt`): **the standard three or fewer; none on `sorryAx`, none on
a native axiom.**

- **`HadwigerNelson.DensityBound.BesselCert.Cells.phiApprox_ge`** (`Plane/DensityBound/Cells/Covering`) — for every list
  `d` with `|dₖ − Dₖ/2⁶⁴| ≤ 2⁻⁶⁴`, `dₖ ≥ 0` (27 terms) and every `t ≥ 0`, `99994/100000 ≤ w₁ + Σₖ Wₖ J₀(t dₖ)` with
  `P23`'s weights at scale `10²⁰`: `[AmbrusEtAl2023]`'s `ϕ(t) ≥ 1 − µ`, `µ = 6·10⁻⁵`, its eq. (22) — [kernel],
  `[propext, Classical.choice, Quot.sound]`.
- `BesselCert.covering_sound`, `chain_sound`, `cellCheck_sound`, `termsOut_sound`, `coreOf_sound`, `defect_bound`,
  `quadOk_sound`, `tailCheck_sound`, `tailSum_sound`, `abs_J0_tail`, `statesValid_init` and the polynomial lemmas
  (`Plane/DensityBound/BesselCert`), with `close_self`, the model of `Close` that `Cells/Covering` instantiates at `P23` — [kernel], the standard three.
- The 847 cells `Cells.cN_ok : CellOk P23 cN` and the 46 `Cells.segNN_ok`, `allCells_ok`, `allCells_linked`, `code0_init`,
  `allCells_tail` — [kernel] by `decide +kernel`, `[propext]`.
- `Bessel` (13): `J0_eq_integral`, `J1_eq_integral`, `J0_zero`, `J1_zero`, `abs_J0_le_one`, `abs_J1_le_one`,
  `hasDerivAt_J0`, `hasDerivAt_J1`, `continuous_J0`, `continuous_J1`, `antitoneOn_norm_Jc`, `abs_J0_sub_le`,
  `circleAverage_exp_inner` — [kernel], the standard three.
- `BesselDefect` (4): `norm_Jc_sub_le_of_defect`, `hasDerivAt_Jc`, `abs_J0_sub_re_le`, `abs_J0_le_of_le` — [kernel], the
  standard three.

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations, against their sources (standing rule 3)

Checked mechanically: every `> ` line of the brief searched verbatim in the file its `— source:` line names, and the inline
quotation of W6.

| # | the brief quotes | source | verdict |
|---|---|---|---|
| Q1 | W2 (2026-10-13) "I choose the second form. Any finding of ours must be formalized. …" | `data/fs131/REQUEST-2026-10-13.md` | verbatim |
| Q2 | dated line 2026-10-14 "The density bound has a route with no periodic reduction and no Bessel citation" | `data/fs131/claims-NF2.md` | verbatim |
| Q3 | dated line 2026-10-14 "The certificate's analytic half is priced in the kernel" | `data/fs131/claims-NF2.md` | verbatim |
| Q4 | item 845 "FS131-KDB1 handed back: …" | `plans/FS131-close-inventory.md` | verbatim |
| Q5 | "Yes, prove the density bound." (W6, inline) | `data/fs131/REQUEST-2026-10-13.md` | verbatim (one occurrence) |

No mismatch.

### 1.2 Each leaf of lanes B and C, restated in one line beside its plan (`plans/FS131-KDB1-density-bound.md` § 3.3)

| leaf (module) | what it says | plan |
|---|---|---|
| `J0_eq_integral` (Bessel) | `J0 x = (2π)⁻¹∫₀^{2π} cos(x sin θ)` | `Real.circleAverage_def`, `circleMap 0 1 θ` has `im = sin θ` |
| `J1_eq_integral` (Bessel) | `J1 x = (2π)⁻¹∫₀^{2π} sin θ sin(x sin θ)` | the same |
| `J0_zero`, `J1_zero` (Bessel) | `J0 0 = 1`, `J1 0 = 0` | `Real.circleAverage_const` (`J0_zero` proved in scratch) |
| `abs_J0_le_one`, `abs_J1_le_one` (Bessel) | `|J0 x| ≤ 1`, `|J1 x| ≤ 1` | circle-average monotonicity (`abs_J0_le_one` proved in scratch) |
| `hasDerivAt_J0` (Bessel) | `J0′ = −J1` at every `x` | differentiation under the integral, bound 1 |
| `hasDerivAt_J1` (Bessel) | `J1′ = J0 − J1/x` at `x ≠ 0` | the same, then one integration by parts over a period |
| `continuous_J0`, `continuous_J1` (Bessel) | continuity | from the derivatives; `J1` at 0 by parametric continuity |
| `antitoneOn_norm_Jc` (Bessel) | `x ↦ ‖J0 x + i J1 x‖` antitone on `[0, ∞)` | `‖Jc‖²′ = −2J1²/x`, `antitoneOn_of_deriv_nonpos` |
| `abs_J0_sub_le` (Bessel) | `|J0 x − J0 y| ≤ |x − y|` | mean value with `|J1| ≤ 1` |
| `circleAverage_exp_inner` (Bessel) | `circleAverage (exp(i⟪ξ, ·⟫)) 0 r = J0(r‖ξ‖)` | rotation by `arg ξ`, the sine part integrates to 0 |
| `norm_Jc_sub_le_of_defect` (BesselDefect) | `‖Jc x − p x‖ ≤ ‖Jc a − p a‖ + (x − a)D` on `[a, b]`, `0 ≤ a`, for `p′ = q` on `[a, b]` and defect `≤ D` on `(a, b)` | `HasDerivAt.norm_sq`, a comparison on `√(‖e‖² + κ²)`, `κ → 0`, `a = 0` by a limit |
| `hasDerivAt_Jc` (BesselDefect) | `Jc′ = besselField x (Jc x)` at `x ≠ 0` | the two components |
| `abs_J0_sub_re_le` (BesselDefect) | `|J0 x − w.re| ≤ ‖Jc x − w‖` | `|re| ≤ ‖·‖` |
| `abs_J0_le_of_le` (BesselDefect) | `0 ≤ a ≤ x → |J0 x| ≤ ‖w‖ + ‖Jc a − w‖` | `antitoneOn_norm_Jc` |
| lane C (`BesselCert`, new) | an accepted cell bounds `w₁ + Σ W_k J0(t d_k)` below on its interval and passes valid states on; the covering of `[0, 800]` and the tail give `ϕ ≥ 1 − µ` on `[0, ∞)` | the planner's § 2.1 R4 (a)–(d); the probe `data/fs131/kdb1/probes/CellProbe.lean` restructured (§ 2 below) |

### 1.3 The stored statements, dumped from the built tree before any edit

`data/fs131/idb1/lean/StatementDump.lean` (every constant of `Bessel`, `BesselDefect`, `Window` from the modules' own compiled
data: kind, name, stored type, a definition's stored value), run under the slot against the tree as built for `4311c0fe0`:
`data/fs131/idb1/statements-before.txt` — 24 constants (16 + 5 + 3), none internal. Reader `tools/fs131_idb1_statement_diff.py`;
its self-test (a changed type, a changed value, a removed constant, a new public constant planted in copies of the dump) fires
on all four, the faithful copy reads 0 differences over 24 constants.

## Stage 2 — SAVED: lane C's checker, its soundness, the generator

### 2.1 The checker, restructured from the probe (`Proofs/HadwigerNelson/Plane/DensityBound/BesselCert.lean`, 1,168 lines)

The probe's fused pass (`data/fs131/kdb1/probes/CellProbe.lean`) is split into list functions that each have a one-line
semantics, so that soundness is a chain of short lemmas:

| piece | kernel function | semantics lemma |
|---|---|---|
| polynomials | `addL`, `smulL`, `absL`, `dL` (via `derivAux`), `affX`/`shiftL`, `powScale`, `homogL`, `evZ`, `evF` (forward homogenized Horner) | `ev_addL`, `ev_smulL`, `abs_ev_le`, `hasDerivAt_ev`, `ev_shiftL`, `ev_powScale`, `ev_homogL`, `cast_evZ`, `evF_eq` + `cast_Wh` |
| Taylor recurrence | `taylor` (the probe's, rounded) | none: **no proof reads it**; the soundness holds for any coefficient lists `a = m0 :: ta`, `b = m1 :: tb` |
| one term, one cell | `coreOf` (defect lists `δ₀ = a′ + b`, `δ₁` by `xList`: `C·g + SC·(s g + b)` at `C ≠ 0`, `g + b/s` at `C = 0`), `termOk` | `defect_bound`, then `coreOf_sound` through `norm_Jc_sub_le_of_defect` |
| all terms | `termsOut` | `termsOut_sound` (with `|dₖ − Dₖ/S| ≤ 1/S` and `abs_J0_sub_le`) |
| the cell polynomial | `cellCheck` (re-centred by `shiftL`, homogenized at `K = 2⁸⁵`, quadratic part by `quadOk`, higher part by `evZ` of absolute values) | `quadOk_sound` (endpoints, and the vertex when inside: exact), `cellCheck_sound` |
| states | packed in one `ℕ` per boundary, three 72-bit fields per term (`decode`) | none needed: the checker reads the decoded lists and the soundness is over any lists |
| chain, tail, whole | `Linked`, `chainEnd`, `chainExit`, `tailCheck` | `chain_sound` (on `[start, end)`), `abs_J0_tail` + `tailCheck_sound` (antitone `‖J‖`), `covering_sound` |

The probe's `rnd` of the exit state is no longer checked as an equality: an exit state is accepted when its radius covers
the error plus its distance to `p(c + h)` (`termOk`), so the generator's rounding is untrusted too. `^` on `ℤ` is avoided
in kernel code (under Mathlib it elaborates through `Monoid.npow`, `data/fs131/idb1/probes/Names.lean`): `pw`.

`covering_sound` (generic in the parameters) is the module's headline: an accepted linked chain from `J(0) = (1, 0)` and an
accepted tail give `TN/TD ≤ w₁ + Σₖ Wₖ J₀(t dₖ)` (scaled) for every `t ≥ 0` and **every** list `d` with
`|dₖ − Dₖ/2⁶⁴| ≤ 2⁻⁶⁴`, `dₖ ≥ 0` (`Close`). The module elaborates with no `sorry` of its own; its axioms reach `sorryAx`
only through lane B's leaves (`norm_Jc_sub_le_of_defect`, `abs_J0_sub_re_le`, `abs_J0_sub_le`, `abs_J0_le_of_le`,
`J0_zero`, `J1_zero`). Built: `data/fs131/idb1/build1.log` (exit 0, 2 modules rebuilt, no warning from the file).

### 2.2 The generator (`tools/fs131_idb1_cells.py`) and its reproducibility

`chain` writes `data/fs131/idb1/gen/Chain.lean`, which runs the chain with **the checker's own** `termNext` and `core` in
Lean's compiled evaluator, prints one packed code per boundary, and runs the compiled `cellCheck` of every cell on the
decoded codes: 848 codes, 847 of 847 cells `true` with the encode–decode round trip `true` (22 s, 3.2 GB). `modules`
refuses unless every cell passed and the tail passes, then writes `Cells/Data.lean` (the parameters), 46 parts
`Cells/Part00 … Part45.lean` (cells grouped to a degree sum ≤ 420, 18–29 cells each), `Cells/Covering.lean`. Tail slack
`0.010040` (the planner's 0.0100). **Run twice from the plan file, identical:** the 50 output files' SHA-256 sums
(`data/fs131/idb1/gen/run1.sha256`, `run2.sha256`) agree.

### 2.3 Measured kernel cost, and the plants

`decide +kernel` on two parts elaborated as standalone files (Data's text + the part's, `data/fs131/idb1/probes/Cut00.lean`,
`Cut40.lean`; under the slot at a 4 GiB cap): Part00 (29 cells, degree sum 419) **51.6 s**, RSS 5.10 GB; Part40
(18 cells, degree sum 414, `N = 23`) **61.4 s**, RSS 4.60 GB (Mathlib's mapped `.olean`s are ~3.1 GB of that; neither run
reached its 4 GiB cgroup cap). That is 0.115–0.14 s per unit of degree per cell — the probe's rate (0.118–0.138) — so the
46 parts are ≈ 41 min of kernel CPU.

Plants (`data/fs131/idb1/probes/Plants.lean`), each beside its faithful partner:
- cell 0 with its exit code's first radius one unit smaller → **refused** by the kernel ("decide proved that the
  proposition … is false"); the faithful cell 0 passes;
- cell 58 (`t ∈ [29, 29.25]`, the plan's least margin `4.24·10⁻⁶`) against the target raised to `99995/100000` →
  **refused**; the faithful cell 58 against `99994/100000` passes.

### 2.4 Re-priced from the first two leaves

The planner priced lane C at 900 lines plus a generator; the checker and its soundness came to 1,168 lines (with docs and
the spec examples) and the generator to 289: **1.3×** the plan on lines, the kernel rate as measured. No message owed.

## Stage 3 — SAVED: the checker split to core; lane B's 17 leaves written

### 3.1 The checker in core, so the cells load no Mathlib and outlive any edit to the Bessel proofs

A finding while lane C stood: Lake rebuilds every module downstream of an edited one (`LEAN.md` § Building, FS131-LU1's
113 dependents recompiled to the same bytes), and the cells imported `BesselCert`, which imports `Bessel`; every edit to a
Bessel proof would have re-run the 41 minutes of kernel time. So the computations moved, unchanged, into a new module
**`Plane/DensityBound/BesselCheck`** (316 lines, core only, no import: `Int`/`Nat` for `ℤ`/`ℕ`), and `BesselCert` (now
the soundness only, 880 lines) imports it; `Cells/Data` and the parts import `BesselCheck`, `Cells/Covering` imports
`BesselCert` and the parts. Measured on Part40 as a standalone file: **60.3 s, RSS 1.95 GB** (against 61.4 s and 4.60 GB
with Mathlib loaded). The chain stage re-run against the core module printed a byte-identical `Chain.out`
(`data/fs131/idb1/gen/run3.sha256` against `run2.sha256`, second line). A new module is outside the letter of the
brief's file list; the brief gives the checker's design to this lane, and this is said in the report.

### 3.2 Lane B, all 17 leaves (written in copies under `data/fs131/idb1/work/` while builds walked, then copied over)

`Bessel` (13): `J0_eq_integral`, `J1_eq_integral`, `J0_zero`, `J1_zero` (one `simp` each through `Real.circleAverage_def`,
`circleMap`); `abs_J0_le_one`, `abs_J1_le_one` (circle-average monotonicity, `|z.im| ≤ ‖z‖ = 1` on the circle);
`hasDerivAt_J0` and a private `hasDerivAt_J1_integral` (`J₁′ = (2π)⁻¹∫ sin²θ cos(x sin θ)` at **every** `x`) from one private
helper `hasDerivAt_integral_sin` (Mathlib's `intervalIntegral.hasDerivAt_integral_of_dominated_loc_of_deriv_le` at
`s = univ`, bound `1`); `hasDerivAt_J1` (`x ≠ 0`) by one integration by parts (`integral_mul_deriv_eq_deriv_mul`, boundary
terms `0` at `0` and `2π`); `continuous_J0`, `continuous_J1` (from the derivatives, `J₁` at `0` included — no limit
argument needed); `antitoneOn_norm_Jc` (`(J₀² + J₁²)′ = −2J₁²/x`, `antitoneOn_of_deriv_nonpos` on `Ici 0`);
`abs_J0_sub_le` (`lipschitzWith_of_nnnorm_deriv_le`); `circleAverage_exp_inner` (`⟪ξ, r e^{iθ}⟫ = r‖ξ‖ sin(θ − β)` with
`β = arg ξ − π/2`, a shift by periodicity, `exp = cos + i sin`, the sine part `0` by `θ ↦ 2π − θ`).

`BesselDefect` (4): `norm_Jc_sub_le_of_defect` — for `κ > 0`, `f = √(‖J − p‖² + κ²)` has derivative
`⟪e, F(e) − δ⟫/f ≤ ‖e‖·D/f ≤ D` on `(a, b)` (the contraction `⟪w, F(x, w)⟫ = −w₁²/x ≤ 0`), so
`Convex.image_sub_le_mul_sub_of_deriv_le` on `Icc a b` gives `‖e(x)‖ ≤ ‖e(a)‖ + κ + (x − a)D`, and `κ → 0`; the planner's
separate limit at `a = 0` is not needed (the mean-value lemma reads continuity on `Icc`, derivatives on `Ioo`);
`hasDerivAt_Jc` (through a private copy `hasDerivAt_Jc_aux` placed before the comparison lemma, which uses it — no
declaration moved); `abs_J0_sub_re_le`; `abs_J0_le_of_le`.

Both copies elaborate with no error and no `sorry` (`lake env lean`, `-DautoImplicit=false`): Bessel 5.4 s, BesselDefect
4.8 s. The text diff against the skeletons removes exactly the 13 + 4 `sorry` lines and adds proofs and the three private
helpers. Re-priced from the first two leaves: the plan's 600 lines for lane B against about 330 written — **0.55×**.
The kernel-side statement check and the build are stage 4's.

## Stage 4 — SAVED: the build, the covering in the kernel, the statements and the axioms from the kernel's side

### 4.1 One build under the slot

`scripts/slot.py --mem 12 --cpus 5 -- env MEMMAX=12G BATCH=5 ./scripts/build.sh` — **exit 0**, 402 batches, 55 modules
rebuilt, 24 m 39 s (`data/fs131/idb1/build3.log`, full log `build3-full.log`). Warnings come from four modules only,
`Autocorr`, `Pattern`, `Window`, `Plane/OneAvoidingDensity` — the other lanes' 36 `declaration uses sorry` lines; **none
from this job's files** (`Bessel`, `BesselDefect`, `BesselCheck`, `BesselCert`, `Cells/*`). `native_decide` appears in
no file under `Proofs/HadwigerNelson/Plane/DensityBound/` (`grep -rl`, exit 1).

### 4.2 Each module's compile time and peak memory

Times are Lake's (`Built … (Ns)`); peaks are the largest resident set of the module's `lean` process, sampled every 2 s
(`data/fs131/idb1/rss/sample.sh`, `samples.txt`; `table.py`). The parts ran five at a time on five cores, so a part's time
here includes the contention (standalone, Part40 took 60.3 s).

| module | compile time | peak RSS |
|---|---|---|
| `Plane.DensityBound.Autocorr` | 1.8s | 2.66 GB |
| `Plane.DensityBound.Bessel` | 2.5s | 2.98 GB |
| `Plane.DensityBound.BesselCert` | 29s | 3.17 GB |
| `Plane.DensityBound.BesselDefect` | 3.5s | 2.98 GB |
| `Plane.DensityBound.Cells.Covering` | 2.5s | 2.87 GB |
| `Plane.DensityBound.Cells.Data` | 308ms | (under 2 s, not sampled) |
| `Plane.DensityBound.Cells.Part00` | 71s | 2.38 GB |
| `Plane.DensityBound.Cells.Part01` | 75s | 2.04 GB |
| `Plane.DensityBound.Cells.Part02` | 75s | 1.90 GB |
| `Plane.DensityBound.Cells.Part03` | 79s | 1.89 GB |
| `Plane.DensityBound.Cells.Part04` | 79s | 1.75 GB |
| `Plane.DensityBound.Cells.Part05` | 82s | 1.86 GB |
| `Plane.DensityBound.Cells.Part06` | 79s | 1.91 GB |
| `Plane.DensityBound.Cells.Part07` | 81s | 1.74 GB |
| `Plane.DensityBound.Cells.Part08` | 80s | 1.75 GB |
| `Plane.DensityBound.Cells.Part09` | 82s | 1.74 GB |
| `Plane.DensityBound.Cells.Part10` | 82s | 1.80 GB |
| `Plane.DensityBound.Cells.Part11` | 79s | 1.72 GB |
| `Plane.DensityBound.Cells.Part12` | 82s | 1.80 GB |
| `Plane.DensityBound.Cells.Part13` | 81s | 1.78 GB |
| `Plane.DensityBound.Cells.Part14` | 79s | 1.74 GB |
| `Plane.DensityBound.Cells.Part15` | 79s | 1.78 GB |
| `Plane.DensityBound.Cells.Part16` | 80s | 1.91 GB |
| `Plane.DensityBound.Cells.Part17` | 80s | 1.87 GB |
| `Plane.DensityBound.Cells.Part18` | 79s | 1.81 GB |
| `Plane.DensityBound.Cells.Part19` | 81s | 1.83 GB |
| `Plane.DensityBound.Cells.Part20` | 81s | 1.87 GB |
| `Plane.DensityBound.Cells.Part21` | 81s | 1.80 GB |
| `Plane.DensityBound.Cells.Part22` | 81s | 1.84 GB |
| `Plane.DensityBound.Cells.Part23` | 80s | 1.89 GB |
| `Plane.DensityBound.Cells.Part24` | 73s | 1.76 GB |
| `Plane.DensityBound.Cells.Part25` | 75s | 1.75 GB |
| `Plane.DensityBound.Cells.Part26` | 72s | 1.81 GB |
| `Plane.DensityBound.Cells.Part27` | 79s | 1.72 GB |
| `Plane.DensityBound.Cells.Part28` | 78s | 1.75 GB |
| `Plane.DensityBound.Cells.Part29` | 75s | 1.90 GB |
| `Plane.DensityBound.Cells.Part30` | 74s | 1.77 GB |
| `Plane.DensityBound.Cells.Part31` | 81s | 1.93 GB |
| `Plane.DensityBound.Cells.Part32` | 73s | 1.89 GB |
| `Plane.DensityBound.Cells.Part33` | 81s | 1.78 GB |
| `Plane.DensityBound.Cells.Part34` | 74s | 1.79 GB |
| `Plane.DensityBound.Cells.Part35` | 78s | 1.80 GB |
| `Plane.DensityBound.Cells.Part36` | 79s | 1.87 GB |
| `Plane.DensityBound.Cells.Part37` | 75s | 1.79 GB |
| `Plane.DensityBound.Cells.Part38` | 73s | 1.85 GB |
| `Plane.DensityBound.Cells.Part39` | 78s | 1.77 GB |
| `Plane.DensityBound.Cells.Part40` | 76s | 1.89 GB |
| `Plane.DensityBound.Cells.Part41` | 72s | 1.84 GB |
| `Plane.DensityBound.Cells.Part42` | 76s | 1.80 GB |
| `Plane.DensityBound.Cells.Part43` | 72s | 1.75 GB |
| `Plane.DensityBound.Cells.Part44` | 63s | 1.79 GB |
| `Plane.DensityBound.Cells.Part45` | 40s | 1.59 GB |
| `Plane.DensityBound.Pattern` | 2.0s | 2.64 GB |
| `Plane.DensityBound.Window` | 2.0s | 2.95 GB |

**The 46 parts: 3,525 s of compile time in all (40–82 s each), peak RSS 1.59–2.38 GB each**, about 14 minutes of wall clock
at five at a time. No part came near the 12 GiB cap or an hour. The covering's assembly (`Cells/Covering`: linking the 847
cells, the initial states, the tail) is 2.5 s.

### 4.3 No statement and no definition changed, from the kernel's side

`data/fs131/idb1/statements-after.txt` (the stage-1 dump re-run on the built tree) against `statements-before.txt`:
`tools/fs131_idb1_statement_diff.py` — **24 constants checked, 0 differences** (every stored type of `Bessel`,
`BesselDefect`, `Window`, every stored value of `J0`, `J1`, `Jc`, `besselField`). The three private helpers are stored as
internal names (`_private.….hasDerivAt_integral_sin`, `hasDerivAt_J1_integral`, `hasDerivAt_Jc_aux`), and no public
constant was added. The reader's self-test (stage 1) fires on a changed type, a changed value, a removed constant and a
new public constant.

### 4.4 The axioms of every public declaration of this job's files

`data/fs131/idb1/lean/AxiomsIDB1.lean` prints `Lean.collectAxioms` of every non-internal constant of the 52 modules
(`Bessel`, `BesselDefect`, `BesselCheck`, `BesselCert`, `Cells/Data`, the 46 parts, `Cells/Covering`);
`tools/fs131_idb1_axioms.py` reads it: **2,015 records, 996 on a subset of the standard three and 1,019 on none; no
`sorryAx`, no native axiom.** The two planted records in the same file show what was planted: `withSorry` →
`[sorryAx]`, `withNative` → `[FS131IDB1Plant.withNative._native.native_decide.ax_1_1]` (the reader fails as blind if
either does not).

## Drafts for the front page (FS133-LD1)

*For the coordinator to file; this job files none of them. Each draft names its slot: the file, the section, and the
exact words it replaces or follows; `data/fs133/ld1/drafts-slots.py` checks that each slot occurs exactly once (on
this branch, whose front files are `main`'s unchanged and whose `ARCHITECTURE.md` rows are the ones the filing edits;
output `data/fs133/ld1/drafts-slots.out`: 29 slots, each once; the control string absent). Each count names the log
line it comes from; the gated commit and its logs are stage 5 (`data/fs133/ld1/gate/*-final.*`; the scans' full
outputs `receipt-axioms-final.log`, `receipt-vacuity-final.log`, `receipt-assumptions-final.log`).*

**Whose it is.** The statement is not new: a paper posted on 8 October 2026 proves the same sentence in dimension four
and up and names the plane as its aim (`[Davies2026]`; the claim list's K133-NC-ALL). The kernel proof — the
statements (FS133-K1's), the proofs (FS133-IA1, -IB1, -IB2, -ICD1, -IPQ1's) and this landing — is this project's.
The transfer and the residual Fourier step (`Outside.OAI158.Spectral.residual_fourier`: the release's Theorem 2.3
composed with the spectral theorem) are `[OAIMath2026]`'s, family 158, its proofs ported (FS131-KO1 to FS131-LP1).
No value moves: the kernel holds `1/7 ≤ m₁(ℝ²) ≤ 1` and nothing else about the number.

**1. `CLAUDE.md` § Trust ledger, the audit's sentence.** *Replaces* "the current audit reads 8961 clean and 5 declared
purchases, and 26 imported (and 32 axiom-free; 9,024 records at the landing of the port of `[OAIMath2026]`'s transfer
proof, FS131-LP1, 2026-10-14)". From `axioms-final.log`, "audited: 9101 records — 9038 clean on the standard axioms,
32 axiom-free, 26 imported (resting on a declared outside theorem), 5 declared purchase(s)":

> the current audit reads 9038 clean and 5 declared purchases, and 26 imported (and 32 axiom-free; 9,101 records at the
> landing of FS-133's density equality, FS133-LD1, 2026-10-14)

9,024 + 77 = 9,101 (the module's records: stage 2.9); clean 8,961 + 77 = 9,038; axiom-free, imported, purchases
unchanged.

**1b. The same paragraph.** *Follows* "its first import, `[Falconer1981]` Lemma 2 (i), is a theorem since FS131-IF1."
*with*

> The release's rigidity step `Outside.OAI158.Spectral.residual_fourier` (`[OAIMath2026]` family 158, `Ergodicity.lean`
> l. 403: its Theorem 2.3 composed with the spectral theorem) never entered `main` as an import: FS-133's branch
> declared it as an axiom over six copied definitions, and at the density equality's landing the copies and the axiom
> were deleted and the port's theorem read, its stored type the declared one's constant for constant (FS133-LD1); the
> fourteen records that rested on it there are clean.

**2. `CLAUDE.md` § The gate, the vacuity scan's counts.** *Replaces* "`declarations=17785 refutations-skipped=232
sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`." From `vacuity-final.log`, "scanned:
declarations=17902 refutations-skipped=234" and "sites: sites=1454 vacuous=0 stale=0 declared=3 witnessed=38
generic=1411 unknown=2":

> `declarations=17902 refutations-skipped=234 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`.

Two counts move: declarations +117, refutations +2, both the module's (stage 5's vacdiff, module by module). No site
is added. The baseline's header is refiled on the branch.

**3. `CLAUDE.md` § Trust ledger, the nine counts.** *No change.* `receipt-assumptions-final.log`'s totals read
`axioms=2 rests=27 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1`, and the step reports
"recorded counts in CLAUDE.md § Trust ledger: match (9 of 9 compared)". The module adds no axiom and no declared
hypothesis; it adds one `.condition` (`OneClass.IsShiftInvariantLaw`, stage 2.10), which no count reads.

**4. `CLAUDE.md` § Frontier, Last filed.** *Replaces* "Last filed: **the landing of the port of `[OAIMath2026]`'s
transfer proof** (FS131-LP1, 2026-10-14:" *by*

> Last filed: **the landing of FS-133, the density equality** (FS133-LD1, 2026-10-14: `Outside/OAI158Rigidity` and
> the seven modules of `Plane/OneClass` through the gate on the standard three axioms — 77 records; `α₁(ℝ²) = α₁(𝒜²) =
> m₁(ℝ²)`, `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`, `f(n)/n → m₁(ℝ²)` and the labelling claim both ways; the rigidity
> step `[OAIMath2026]`'s, ported; FS-133 Closed; the statement not new, `[Davies2026]`; no value moved); before it **the
> landing of the port of `[OAIMath2026]`'s transfer proof** (FS131-LP1, 2026-10-14:

**5. `CLAUDE.md` § Frontier, Open milestones, FS-133.** *Replaces* "**Derived 2026-10-07: FS-133, the one-class
transfer** (`plans/FS133-E1-derivation.md`, 13 entries, each derived, one mind; stub `plans/STUB-one-class-transfer.md`;
a short milestone, unranked — it bears none on six against seven): `α₁(ℝ²) = m₁(ℝ²)` and `χ_f,0(ℝ²) = χ_f(ℝ²) =
1/m₁(ℝ²)` with no hypothesis, over `[OAIMath2026]`'s rigidity theorem (row 129); Closed when its Lean module passes the
gate." *by*

> **Closed 2026-10-14: FS-133, the one-class transfer** (Derived 2026-10-07, `plans/FS133-E1-derivation.md`, 13
> entries, each derived, one mind; stub `plans/STUB-one-class-transfer.md`; a short milestone, unranked — it bears none
> on six against seven; its Lean module through the gate, FS133-LD1): `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, `χ_f,0(ℝ²) =
> χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)` and `f(n)/n → m₁(ℝ²)` with no hypothesis, and for a finite set of labels and forbidden
> pairs at countably many positive algebraic distances an admissible labelling of the plane exists iff one of the
> algebraic plane does, iff a Lebesgue-measurable one admissible almost everywhere does — each kernel-checked on the
> standard three axioms, through `[OAIMath2026]`'s rigidity step `Outside.OAI158.Spectral.residual_fourier`, ported
> (row 129; `OneClass.finIndepRatio_plane_eq_mOne`, `finIndepRatio_algPlane_eq_mOne`,
> `iSup_fractionalChromaticNumber_plane`, `fractionalChromaticNumber_plane`, `fractionalChromaticNumber_algPlane`,
> `tendsto_minIndepNum_div`, `exists_admissibleOn_univ_iff_ae`, `exists_admissibleOn_univ_iff_algPlane`). Not new:
> `[Davies2026]` proves the same sentence in dimension four and up and names the plane as its aim; the kernel proof is
> this project's.

**6. `CLAUDE.md` § Publication, "Held so far".** *Replaces* "with no hypothesis, over `[OAIMath2026]`'s rigidity
theorem, row 129 (FS-133; one mind) answers the first clause of `[DuczVarga2026]`'s Conjecture 1 and `[MatolcsiEtAl2025]`
§2's equality question." *by*

> with no hypothesis, row 129's plane clause (FS-133) answers the first clause of `[DuczVarga2026]`'s Conjecture 1 and
> `[MatolcsiEtAl2025]` §2's equality question — formalized: in the kernel since FS133-LD1, on the standard three axioms,
> through `[OAIMath2026]`'s rigidity step, ported; the statement is not new (`[Davies2026]`, in dimension four and up,
> names the plane as its aim), the kernel proof is this project's.

(The list this clause sits in opens "Held so far at [hand]:"; with this clause in the kernel, the filing may want the
head to say so.)

**7. `CLAUDE.md` § The aim, the program.** *Replaces* "on `[OAIMath2026]`, **FS-132, six by the nerve**, and **FS-133,
the one-class transfer**;" *by* "on `[OAIMath2026]`, **FS-132, six by the nerve**, and **FS-133, the one-class transfer —
closed** (row 129; FS133-LD1);".

**8. `CLAUDE.md` § Where the problem stands, "What the kernel holds, beyond the interval".** *Follows* "The lower bound
of four against every colouring, the three-colour criterion and the clause for subfields are this project's, with every
kernel proof;" *with* (FS133-ICD1's DD4 and FS133-IPQ1's DQ3, corrected: on the standard three, C133-PAIR held)

> **the density equality for the plane** (FS-133, FS133-LD1): `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)` — the infimum of
> `α(G)/|G|` over finite point sets of the plane, and of the algebraic plane, is the supremum of the upper densities of
> the measurable sets with no two points at distance one — and `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`, and
> `f(n)/n → m₁(ℝ²)` (`[DuczVarga2026]` Conjecture 1, first clause; `[MatolcsiEtAl2025]` §2's equality question)
> (`OneClass.finIndepRatio_plane_eq_mOne`, `…_algPlane_eq_mOne`, `fractionalChromaticNumber_plane`,
> `iSup_fractionalChromaticNumber_plane`, `fractionalChromaticNumber_algPlane`, `tendsto_minIndepNum_div`); and
> labellings with forbidden pairs of labels at countably many positive algebraic distances — the plane has one admissible
> at every pair iff the algebraic plane has one, iff the plane has a Lebesgue-measurable one admissible almost
> everywhere (`OneClass.exists_admissibleOn_univ_iff_algPlane`, `…_iff_ae`; the converse at any positive distances,
> algebraic or not, `exists_admissibleOn_of_ae`); all on the standard three axioms, through `[OAIMath2026]`'s
> `Spectral.residual_fourier`, ported. Not claimed: any value of `m₁(ℝ²)` beyond `1/7 ≤ m₁(ℝ²)`, or of a chromatic
> number; `m₁(ℝ²) = δ_Croft`; anything at a number field's plane or at six colours; that the result is new
> (`[Davies2026]`). The kernel proof is this project's;

**9. `LEDGER.md` row 129, its grade.** *Replaces* "the plane's clause since FS-133 not MR's: C133-ONE [hand], one
mind, kernel pending, over `[OAIMath2026]` Theorem 2.3 (kernel-checked in the release's library, audited:
`plans/EXT-OAI1-audit.md`)" *by*

> the plane's clause since FS-133 not MR's: C133-ONE and C133-FN **[kernel]** since FS133-LD1
> (`OneClass.finIndepRatio_plane_eq_mOne`, `finIndepRatio_algPlane_eq_mOne`, `iSup_fractionalChromaticNumber_plane`,
> `fractionalChromaticNumber_plane`, `fractionalChromaticNumber_algPlane`, `tendsto_minIndepNum_div`; each on
> `[propext, Classical.choice, Quot.sound]`), through `[OAIMath2026]` Theorem 2.3 composed with the spectral theorem —
> the release's `Spectral.residual_fourier`, its proof ported (`Outside/OAI158Ergodicity`, FS131-KO1 to FS131-LP1);
> the interval `[4.04876, 4.35987]` for `1/m₁(ℝ²)` is the literature's (`[AmbrusEtAl2023]` Theorem 1; Croft's set), not
> the kernel's, which holds `1/7 ≤ m₁(ℝ²) ≤ 1`

The rest of the row keeps its grade: the field form (given MR), FS-103's certificates and the mechanism.

**10a. `plans/FRONTIER-STUBS.md` § Open milestones, FS-133.** The same slot and the same replacement as draft 5.

**10b. The same file, § Closed, absorbed and demoted.** *Follows* "## Closed, absorbed and demoted" *with* the line

> * **FS-133 the one-class transfer** — `plans/STUB-one-class-transfer.md`. Derivation `plans/FS133-E1-derivation.md`;
>   kernel plan `plans/FS133-kernel-plan.md`; landing `plans/FS133-LD1-landing.md`; close inventory
>   `plans/FS133-close-inventory.md`. **Closed 2026-10-14**: its Lean module (`Outside/OAI158Rigidity`, `Plane/OneClass`,
>   eight files, 77 records) through the gate on the standard three axioms (row 129's plane clause, C133-FN, C133-PAIR);
>   the rigidity step `[OAIMath2026]`'s, ported; the statement not new (`[Davies2026]`).

**10c. `plans/STUB-one-class-transfer.md`, the banner.** *Replaces* the banner line "> **Derived 2026-10-07 (FS133-E1;
FS-133 inventory item 3).** All four posed claims are derived, [hand], one mind, kernel pending: … Closed when its Lean
module passes the gate." (the whole line) *by*

> > **Closed 2026-10-14 (FS133-LD1): its Lean module passed the gate.** `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, `χ_f,0(ℝ²) =
> > χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`, `f(n)/n → m₁(ℝ²)` and the labelling claim both ways are kernel theorems on the
> > standard three axioms (`Plane/OneClass`; `plans/FS133-LD1-landing.md` stage 4 reads each aloud against the claim
> > list), through `[OAIMath2026]` family 158's rigidity step, ported (`Outside.OAI158.Spectral.residual_fourier`). Derived
> > 2026-10-07 (FS133-E1; FS-133 inventory item 3): `plans/FS133-E1-derivation.md`; row 129 carries it. Prior art: the
> > statement is not new — `[Davies2026]` (8 October 2026) proves it in dimension four and up and names the plane as its
> > aim (`plans/FS131-ER1-davies-reading.md`).

**11. `ARCHITECTURE.md`.**
- *(a) § Trust, Imported outside theorems:* the row whose head is "| `Outside.OAI158.Spectral.residual_fourier`
  (`Outside/OAI158Rigidity`) | `[OAIMath2026]` family 158, `lean/OAI/Analysis/PlaneSpectrum/Ergodicity.lean` line 403
  at commit `adc7f124`" *removed* (it came to `main` with this branch; the axiom is gone).
- *(b) the paragraph under the table, following* "is a theorem since FS131-IF1 — `falconer_lemma2_nonempty`, proved in
  `Plane/MetricalBoundary` — and is no longer in this table." *:* " `Outside.OAI158.Spectral.residual_fourier`
  (`[OAIMath2026]` family 158, `Ergodicity.lean` l. 403), declared on FS-133's branch over six copied definitions, never
  reached `main` as a purchase: at the density equality's landing it is the port's theorem (`Outside/OAI158Ergodicity`),
  its stored type the declared one's, and its fourteen consumers are clean (FS133-LD1)."
- *(c) the row of `Outside/OAI158Rigidity`, its description cell* (head "**FS-133 (planned by FS133-K1, proved by
  FS133-IA1; no `sorry`). One imported outside theorem**", to the cell's end "… (the regular representation on `ℓ²` of
  the algebraic plane, the point mass at the origin; on the standard three) are proved.") *replaced by* "**FS-133
  (planned by FS133-K1, proved by FS133-IA1; landed by FS133-LD1; no `sorry`).** Two vectors and a model, over
  `[OAIMath2026]`'s `Spectral.residual_fourier`, a theorem of the port (`Outside/OAI158Ergodicity`; the release's Lean
  lemma, `Ergodicity.lean` l. 403 — its Theorem 2.3 composed with the spectral theorem): `residual_fourier_cross` (two
  rotation-fixed vectors orthogonal to the continuous vectors are uncorrelated at every non-zero translate, by
  polarisation) and `residual_fourier_model` (the regular representation on `ℓ²` of the algebraic plane, the point mass
  at the origin), each on the standard three. The module first declared the lemma as an axiom over six copied
  definitions (FS133-IA1); the landing removed both and reads the port's (`plans/FS131-KO1-port-plan.md` § 4.5)."
- *(d) the seven rows of `Plane/OneClass`, their leads:* `SectionDensity`, `Defs`, `InvariantLaw` — "**FS-133 (FS133-K1;
  a skeleton).**" *by* "**FS-133 (FS133-K1's statements, FS133-IB1's proofs; landed by FS133-LD1; no `sorry`).**" for
  `SectionDensity`; the same with "FS133-IB1's proofs, two lemmas FS133-IB2's" for `InvariantLaw` and "FS133-IB2's
  proofs" for `Defs` (for `SectionDensity` add: "`ofReal_integral_le_measure_pos` for any measure: an unread
  `[IsProbabilityMeasure μ]` dropped at the landing (inventory item 789)"; for `Defs`: "three lemmas made public by
  FS133-ICD1 (`upperDensity_congr_ae`, `card_le_indepNum_induce`, `exists_indep_card_eq_indepNum`)"); `Field` —
  "**FS-133 (FS133-K1 the statement, FS133-IA1 the proof; no `sorry`), on the imported `Spectral.residual_fourier`.**"
  *by* "**FS-133 (FS133-K1 the statement, FS133-IA1 the proof; landed by FS133-LD1; no `sorry`), through `[OAIMath2026]`'s
  `Spectral.residual_fourier`, ported.**"; `Algebraic`, `Fractional`, `Pair` — "**FS-133 (FS133-K1; a skeleton), on the
  imported `Spectral.residual_fourier`.**" *by* "**FS-133 (FS133-K1's statements, FS133-ICD1's proofs [`Pair`: and
  FS133-IPQ1's]; landed by FS133-LD1; no `sorry`), through `[OAIMath2026]`'s `Spectral.residual_fourier`, ported.**" (for
  `Algebraic` add: "its imports include Mathlib's `Analysis.Subadditive` (FS133-ICD1, accepted by inventory item 779
  ruling 2)"; for `Pair`: "one unread binder dropped from `exists_admissibleOn_of_ae`, FS133-IPQ1").
- *(e) two stale names in those rows* (`tools/check_architecture.py` [3] lists both as declared nowhere): in
  `Algebraic`'s row "**C133-ALG** `IsInvariantLaw.measure_zero_le_mOne`" → "**C133-ALG**
  `IsInvariantLaw.measure_origin_le_mOne`"; in `InvariantLaw`'s row "C133-INV-CLASS: `IsShiftInvariantLaw.measure_zero_le`
  (any graph)" → "C133-INV-CLASS: `IsShiftInvariantLaw.measure_origin_le` (any graph)" (FS133-ICD1's naming note).

**12. `LEAN.md`** — the implementers' lines, from their records (none is on `main`), and this landing's.
- *(a) § Assumptions, the item-2 bullet, following* "the landing runs it again on the module as recompiled on the joined
  tree.": FS133-IA1's D5, verbatim from `plans/FS133-IA1-implementation.md` (on this branch) § Drafts, D5.
- *(b) § Searching — Lean, following its last bullet* (ending "and the linter's name must be declared where the
  attribute is elaborated (`data/fs131/lp1/nolint/probes/attrs.lean`; FS131-LP1)."), in this order and verbatim from
  the records on this branch: FS133-IA1's D6 (four bullets), FS133-IB1's DB6 (six), FS133-IB2's DC5 (three),
  FS133-ICD1's DD5 (five), FS133-IPQ1's DQ6 (three), and this landing's three:
  - *"A join that brings a port can turn a simp argument of a proof that stays unused: the port's `@[simp]` lemmas
    enter every module downstream of it, and a fact a proof gave `simp` by hand is found by `simp` itself — the build's
    `unusedSimpArgs` warning, which the gate's zero-warning line reads. `simp?` on a copy names the lemmas that took
    over (`Spectral.kCoeff_inv`, `kCoeff_ne_zero`, `Outside/OAI158Basic`; `residual_fourier_model`, FS133-LD1)."*
  - *"Across a join that deletes copies and reads a port's declarations, a statement dump made per module loses the
    moved constants: dump the old modules' every constant before the merge and, after it, the same names found where
    they are now declared (`env.getModuleIdxFor?`), then compare by name with the moves, the axiom proved and the
    instance-only values ruled (`data/fs133/ld1/lean/StatementDump.lean`, `tools/fs133_ld1_moved.py`, FS133-LD1). A
    statement with two instance binders prints both `inst`; a dropped one is named by its occurrence (`inst#2`)."*
  - *"A structure taken as a hypothesis whose only model is the projection of a child structure's model
    (`(isInvariantLaw_dirac G).toIsShiftInvariantLaw`) reads `undeclared-never-concluded` to the assumptions step:
    no declaration concludes it as stated. Declare it a `.condition` with that model in its reason
    (`OneClass.IsShiftInvariantLaw`, FS133-LD1)."*

**13. `tools/claude_md_fact_audit.py`, `GATE_CHANGES`.** One entry after `(("7531", "5"), ("8961", "5")):`'s:

```python
    (("8961", "5"), ("9038", "5")): "FS-133, the landing of the density equality — Outside/OAI158Rigidity and Plane/OneClass through the gate: alpha_1(R^2) = alpha_1(A^2) = m_1(R^2), chi_f,0(R^2) = chi_f(R^2) = chi_f(A^2) = 1/m_1(R^2), f(n)/n -> m_1(R^2) and the labelling claim both ways, on the standard three axioms through [OAIMath2026]'s Spectral.residual_fourier, ported (the copies and the axiom of FS-133's branch deleted at the join); the statement not new ([Davies2026]), the kernel proof ours (FS133-LD1; copy data/fs133/ld1/gate/receipt-axioms-final.log, gated commit 860538ddf): 9,101 records, 9,038 clean, 32 axiom-free, 26 imported, 5 purchases",
```

**13b. The same file's table of superseded counts.** Every token the drafts retire, in that table's form, each with its
value as the reason: `"8961"` (9038 clean); `"9,024"` and `"9024"` (9,101 records); `"declarations=17785"`,
`"17785"` (17902); `"refutations-skipped=232"`, `"232"` (234 — the bare number, which the audit tokenizes alone: FC4's
ruling on `"228"`); `"declarations=17785 refutations-skipped=232 sites=1454"` (17902, 234). The reason for each:
"superseded gate count, refiled at FS133-LD1's landing from data/fs133/ld1/gate/receipt-axioms-final.log (the vacuity
count from receipt-vacuity-final.log); the old count stays in data/fs131/lp1/gate/ and in GATE_CHANGES". **The next
landing's previous receipts are `data/fs133/ld1/gate/receipt-{axioms,vacuity,assumptions}-final.log`.**

**14. `BIBLIOGRAPHY.md`, `[OAIMath2026]`'s row, what rests on it.** *Follows* "is the release's theorem with its proof
ported since FS131-IPD1's switch and FS131-LP1's landing, and its twelve records are clean;" *with* " its rigidity step
`Spectral.residual_fourier` (`Ergodicity.lean` l. 403; Theorem 2.3 composed with the spectral theorem) is read by
FS-133's density equality as the port's theorem, and its fourteen consumers there are clean (FS133-LD1);".

## Open gate items at this landing

*Each named, with what would close it; none of them is a red check of this gate.*

1. **`lean4checker`** (the publication gate, `LEAN.md` § Trust ledger) has not been run over this module or the port.
2. **The proof edit in a kept declaration** (stage 2.4): `residual_fourier_model`'s `simp [hx, hne]` → `simp [hx]`,
   against the recipe's "character for character"; the `have hne` it fed stays, unread. The coordinator rules whether
   it stands or whether the dead `have` goes too.
3. **`IsShiftInvariantLaw` declared a `.condition`** (stage 2.10), on this landing's word; an alternative is a theorem
   concluding it at its model, which would be a new statement and is not this brief's.
4. **Item 798's three instances-only values** (`approxField`, `approxIndex`, `measurableField`) stand as ruled: their
   values cite other generated proof auxiliaries; nothing downstream stores them.
5. **Carried from the port's landing** (item 840), unchanged here: `scripts/Vacuity.lean` line 561's history paragraph;
   EXT-OAI1's line count; `hexShell_plane5`'s classing; the generator's text-only statement guard; ADAPTED_VALUE.
6. **`ARCHITECTURE.md`'s rows' prose** (draft 11) is the filing's; on this branch the rows still say "a skeleton" and
   "on the imported `Spectral.residual_fourier`", and `check_architecture.py` [3] lists the two stale names of draft
   11 (e), which do not fail it.

### 5.3 The audit's block for this job's files (`scripts/Axioms.lean`, CLEAN section, after the last landing's block)

`data/fs131/idb1/audit-block.txt` — 264 records (157 theorems, 107 definitions), every public theorem and definition of
`Bessel`, `BesselDefect`, `BesselCheck`, `BesselCert` in each module's stored order, and of the generated modules `P23`,
the 46 `segNN_ok` and `Cells/Covering`'s seven. The 847 cell theorems and their 847 definitions are not listed one by one:
each is read by its part's `segNN_ok`, whose proof names it, and `collectAxioms` is transitive; the landing may list them
all instead (1,694 more lines). Every record goes under CLEAN: none reads a declared outside theorem. A banner for it:

> `## FS131-IDB1 — the density bound's covering and the Bessel lemmas (FS-131; plan FS131-KDB1)` — 264 records, every
> public declaration of `Plane/DensityBound/Bessel`, `BesselDefect`, `BesselCheck`, `BesselCert` and the assembly records
> of the generated `Plane/DensityBound/Cells/*`; every record under CLEAN, on the standard three or fewer
> (`data/fs131/idb1/axioms.txt`, `tools/fs131_idb1_axioms.py`).

## Stage 6 — SAVED: a model of `Close`, the last build, the linters

`BesselCert.close_self` (the listed distances themselves satisfy `Close` when nonnegative) and, in the generated
`Cells/Covering`, `example : Close P23.Ds (P23.Ds.map fun D => (D : ℝ) / S)` — a model of `phiApprox_ge`'s one
hypothesis. Regenerated: only `Covering.lean` changed (`data/fs131/idb1/gen/run4.sha256` against `run3.sha256`); the parts'
sources are byte-identical, so the build recompiled 3 modules (`BesselCert`, `Covering`, `Proofs`): **exit 0**, 8 m 12 s,
warnings from the other lanes' four modules only (`data/fs131/idb1/build4.log`). Axioms re-printed on that tree: 2,016
records, 997 on a subset of the standard three, 1,019 on none; both plants seen (`tools/fs131_idb1_axioms.py`, PASS).
Environment linters, `lake lint --no-build -- --no-build --trace` under the slot: exit 0, `-- Linting passed for
Proofs.`, every linter passed, no finding in `Plane/DensityBound/` (`data/fs131/idb1/lint.log`).
