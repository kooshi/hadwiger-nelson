# FS131-ICM3 — the five-colour chain: M13's last three leaves on this line

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-ICM3-m13-last-leaves.md` (on `main`). Branch `fs131-wcm3`, cut
from `fs131-wcm2` at `a7501c681`, in the tree `.claude/worktrees/fs131-wch`. Working files: `data/fs131/icm3/`. Report:
`data/fs131/reports/FS131-ICM3.md`. Commits by explicit path, not pushed (the brief: the server is unreachable).*

## Theorems this phase proved

Read from the built tree after build 1 (`data/fs131/icm3/axioms1.out`, `axioms1-read.out`): 187 records of `Arith/CircleCos`,
`Rigidity/ClassRatio`, `CountCompletion`, `CountModels` and `count_of_oneAvoidingDensityBound` — **CLEAN 175, IMPORTED 7,
UPSTREAM 5, FAIL 0**.

- `HadwigerNelson.CircleCos.circleCos_ge` (`Arith/CircleCos`, public, new) — [kernel], `[propext, Classical.choice,
  Quot.sound]`: at `q ∈ {23, 31}` some `κ < 1/3`, `κ ≥ 2/(q + 1)`, bounds every non-trivial character sum over the circle
  `a² + b² = 1` of `ZMod q` by `−κ(q + 1)`. Read against KC13 § 5.3's "at 23 and 31 the normalised least eigenvalue clears
  `−1/3` by `1.6·10⁻³` and `4.9·10⁻⁶`". With it, public and on the standard three (or `[propext]` alone for the
  `decide +kernel` checks): `taylorCos_sub_le_cos` (Taylor's bound for `cos` at a rational), `cosLow_le_cos`,
  `piLo_lt_pi`, `pi_lt_piLo_add`, `re_I_pow`, `sum_circle_eq`, `circCheck_sound`, `circleCos_of_check`, `circ23_eq`,
  `circ31_eq`, `circ23_nodup`, `circ31_nodup`, `tab23_ok`, `tab31_ok`, `check23`, `check31`.
- `circleCos_bound` (private, `Rigidity/ClassRatio`) — [kernel], the standard three: the leaf, by `circleCos_ge`.
- `charBound_one_exact_27` (private) — [kernel], `[propext, Classical.choice, Quot.sound,
  StandingFive.kloosterman_bound]`: at `Q = 27`, `κ = 2/7` (ratio `2/9`). Read against FS100-G27's "`λ_min = −8`, ratio
  `2/9`" — the leaf proves the bound `Re Σ ≥ −8`, not the equality.
- So `charBound_one_exact` (private) is proved, on the standard three and Weil's bound.
- Still `sorry` (two, private): `ratioAtMost_dyadic`, `ratioAtMost_cert` (stays named). `ratioAtMost_of_five_le_chromaticNumber`
  and `tca_of_five_le_localBound` rest on these two and Weil's bound.

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_icm3_quotes.py` (FS131-ICM2's checker with this brief's path) requires each block quotation of the brief, the
`> ` prefix and a list marker removed, as one whole line of its source on `main`'s working tree. Output
`data/fs131/icm3/quotes.out`: **7 quotations, 7 IDENTICAL** — W2 (`data/fs131/REQUEST-2026-10-13.md`), the two dated lines
of 2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 823, 848, 905 and 886 (`plans/FS131-close-inventory.md`).
Control (`--plant`, `data/fs131/icm3/quotes-plant.out`): one character changed in each quotation in memory, **7 of 7
reported**. The brief's pointers to the last implementer's record (§ Stage 4's table) and to KC13 § 5.3 were read: the
three leaves and their recorded routes are as § 1.3 below has them.

### 1.2 The stored statements, dumped before any edit

`data/fs131/icm3/lean/StatementDump.lean` (FS131-ICM2's dumper, renamed; the same four modules: `Rigidity/ClassRatio`,
`CountCompletion`, `CountDescent`, `CountModels`), run by `lake env lean` under the slot (`data/fs131/icm3/lean1.sh`) on the
tree as given — its compiled library current for `a7501c681` (the `.olean` of `ClassRatio` is later than its source, and
`a7501c681` differs from build 3's commit `80f40724b` only by the report): `data/fs131/icm3/statements-before.txt` —
**275 constants** (ClassRatio 145, CountCompletion 50, CountDescent 25, CountModels 55). It is **byte-identical**, `PP` lines
included, to FS131-ICM2's last dump (`data/fs131/icm2/statements-after3.txt.xz`), and the comparator
(`tools/fs131_icm3_statements.py`, ICM2's, renamed) reads it against that dump **SAME 44, PRIVATE-SAME 129, CHANGED 0 —
PASS** (`statements-vs-icm2.out`): the tree holds what the last implementer left.

### 1.3 The three leaves, restated (as the kernel holds them), beside their routes

*All private, all in `Rigidity/ClassRatio`. `S_m` is `levelSet P m`, `CharBound P m κ`: every non-trivial additive character
of `𝓞 ⧸ P^m` sums to real part at least `−κ·|S_m|` over `S_m`.*

| leaf | stored statement (from `statements-before.txt`, `PP`) | recorded route (ICM2 § Stage 4; KC13 § 5.3; KR1 § 2.6 (c)) |
|---|---|---|
| `circleCos_bound` | `∀ {Q : ℕ}, Q = 23 ∨ Q = 31 → ∀ [inst : NeZero Q], ∃ κ < 1 / 3, 2 / (↑Q + 1) ≤ κ ∧ ∀ (α β : ℕ), α < Q → β < Q → α ≠ 0 ∨ β ≠ 0 → -(κ * (↑Q + 1)) ≤ ∑ v with v.1 ^ 2 + v.2 ^ 2 = 1, Real.cos (2 * Real.pi * ↑((α * v.1.val + β * v.2.val) % Q) / ↑Q)` | rational lower bounds on `cos(2πj/Q)` (`Complex.exp_bound'`, `π` bracketed), then one kernel check over the 528 and 960 pairs |
| `charBound_one_exact_27` | `∀ {F : Subfield ℝ} [NumberField ↥F] (P : StablePrime F), 2 ∉ P.P → ∀ {Q : ℕ}, Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2 → Q = 27 → ∃ κ < 1 / 3, 2 / (↑Q + 1) ≤ κ ∧ CharBound P 1 κ` | `λ_min = −8` (FS100-G27): a model of `𝔽₇₂₉` and its `𝔽₃`-functionals |
| `ratioAtMost_dyadic` | `∀ {F : Subfield ℝ} [NumberField ↥F] (P : StablePrime F), 2 ∈ P.P → ¬IsRamified P → 5 ≤ (levelTarget P 1).chromaticNumber → ∃ c < 1 / 4, RatioAtMost P c` | `Q ≤ 32` four-colourable; a dyadic Lemma P; `Q = 64` exact; `128` by `Floor128`; `Q ≥ 256` by EN1-UQ4 |

`ratioAtMost_cert` (`Q ∈ {11, 19}`) stays named, by the brief.

## Stage 2 — SAVED: `circleCos_bound` proved (a new module, `Arith/CircleCos`); its margins in exact arithmetic

**The route** is the recorded one, in a public module of its own (its checks then compile once, and the Taylor bound is a
reusable lemma): `Arith/CircleCos`, 297 lines, Mathlib only (`Mathlib.Analysis.Real.Pi.Bounds`, `Mathlib.Data.ZMod.Basic`).

- `taylorCos_sub_le_cos`: for a rational `r` with `|r|/(n + 1) ≤ 1/2`, `T_n(r) − |r|ⁿ/n!·2 ≤ cos r` — `Complex.exp_bound'`
  at `r·i`, real parts (`re_I_pow`: `Re iᵐ` is `1, 0, −1, 0`).
- `cosLow q j` (a rational): Taylor with 26 terms at `r = 2π₀j′/q`, `j′ = min(j, q − j)`, `π₀ = 3.1415926535`, less the
  remainder bound and the Lipschitz error `2j′/q·10⁻¹⁰` (`Real.abs_cos_sub_cos_le`; `π₀ < π < π₀ + 10⁻¹⁰` from
  `Real.pi_gt_d20`, `Real.pi_lt_d20`; `cos(2πj/q) = cos(2πj′/q)` by `Real.cos_two_pi_sub`). `cosLow_le_cos` for every `q ≥ 1`.
- The certificate (generated by `tools/fs131_icm3_circlecos.py`, `data/fs131/icm3/circle23.lean.txt`, `circle31.lean.txt`):
  the circle as a list of pairs below `q` (24 and 32 points; `circ23_eq`, `circ31_eq` say it is exactly the solutions of
  `a² + b² ≡ 1`, with `…_nodup`), a table `C_j = ⌊10⁹·cosLow q j⌋` (`tab23_ok`, `tab31_ok`), and one pass over the
  `q² − 1` non-zero `(α, β)` (`check23`, `check31`: `Σ_{(a,b)} C_{(αa+βb) mod q} ≥ −M`), each `decide +kernel`. The kernel
  time, measured on a probe at 31 (`data/fs131/icm3/lean/probes/Kernel31.lean`): the table 0.7 s, the pass about 9 s; the
  module compiled in 18 s in the build.
- `sum_circle_eq` carries the leaf's sum over `univ.filter (v.1² + v.2² = 1)` of `ZMod q × ZMod q` to the list; then
  `circleCos_of_check` gives `κ = M/(10⁹(q + 1))`, and `circleCos_ge` is the leaf's statement at `q ∈ {23, 31}`.
  `circleCos_bound` is `CircleCos.circleCos_ge hQ`.

**The margins, in exact arithmetic** (`tools/fs131_icm3_circlecos.py`, rational arithmetic mirroring `cosLow` term for
term; `data/fs131/icm3/circlecos.out`):

| `q` | least table sum (at `(α, β)`) | `M` | `κ = M/(10⁹(q + 1))` | `(q + 1)/3 − M/10⁹` (exact) | `2·10⁹ ≤ M` |
|---|---|---|---|---|---|
| 23 | `−7960687200` at `(3, 9)` | `7960687200` | `3316953/10000000` | `49141/1250000 = 3.931·10⁻²` | yes |
| 31 | `−10666510510` at `(0, 11)` | `10666510510` | `1066651051/3200000000` | `46847/300000000 = 1.562·10⁻⁴` | yes |

The true least sums (mpmath at 60 digits, a reading): `−7.96068718657` and `−10.6665104938`; `cosLow` lies below the cosine
by at most `8.8·10⁻¹¹` (checked `≥ 0` at every `j`). So the certificate keeps all but `1.6·10⁻⁸` of the margin at 31. The
kernel checks the inequalities `3M < 10⁹(q + 1)` and `2·10⁹ ≤ M` itself (`norm_num` in `circleCos_ge`). **Controls:** at
`q = 11` and `19`, where Hoffman fails, the same construction **FAILS** (`circlecos-plant.out`: `(q + 1)/3 − M/10⁹ = −0.796`,
`−0.943`); in the module, the check at 11 with `M = 4·10⁹` (the largest `3M < 10⁹·12` allows) is `false` by `decide +kernel`
(a spec example); `cosLow 23 0 = 1` and `−10⁻⁹ < cosLow 4 1 < 0` (the angle `π/2`).

**Re-priced:** ≈ 300 lines (ICM2's 300–600 for the child; KC13's 700–1,200 for the whole of 23 and 31).

## Stage 3 — SAVED: `charBound_one_exact_27` proved, by another route; build 1; the job's state from the kernel's side

**Route changed** (the brief allows another route; the recorded one, "a model of `𝔽₇₂₉` and its `𝔽₃`-functionals", is
not needed). At `Q = 27` (≈ 125 lines, private, in the leaf's proof):

1. Weil at level one (`charBound_one_weil`, already in the file): `Re Σ_{S₁} ψ ≥ −2√27 > −10.4` (`√27 < 26/5`).
2. The residue field has characteristic 3 (`|k| = 3⁶`), so `ψ(x)³ = ψ(3x) = 1`: `ψ` takes cube roots of unity, and one
   other than `1` has real part `−1/2` (from `z² + z + 1 = 0` in coordinates). So `Re Σ = N₀ − (28 − N₀)/2`,
   `N₀ = #{s ∈ S₁ : ψ s = 1}`.
3. `s ↦ −s` is a fixed-point-free involution of those `s` (`ψ(−s) = ψ(s)⁻¹`; `−s = s` would give `2s = 0`, and `2` is a
   unit and `s ≠ 0`), so `N₀` is even (`Equiv.Perm.card_fixedPoints_modEq` at `p = 2`).
4. Weil gives `N₀ ≥ 3`, parity `N₀ ≥ 4`, so `Re Σ ≥ −8 = −(2/7)·28`: `κ = 2/7 < 1/3`, `2/28 ≤ 2/7`.

**What this changes:** the leaf rests on Weil's bound (the library's declared import) where the recorded route would have
rested on the standard three. Its consumers already did — `ratioAtMost_of_five_le_chromaticNumber` reads Weil at `q ≥ 35` —
so no public declaration's axioms move. It proves `λ_min ≥ −8`, not FS100-G27's equality. **Re-priced:** ≈ 125 lines (KC13's
400–600 for the model route).

**Build 1** under the slot (`--mem 10 --cpus 4`, `MEMMAX=10G BATCH=8`; `data/fs131/icm3/logs/build-1.log`, full output
`logs/build-1-full.log.xz`, `build/gate/build/20261014T195400Z-374984.log`): **OK — 257 of 257 batches, 8 modules rebuilt,
8 m 42 s, exit 0** (`Arith/CircleCos` 18 s, `Rigidity/ClassRatio` 19 s, the count's five downstream modules, `Proofs`). The
only warnings from this job's files are the two remaining leaves' `declaration uses 'sorry'` (`ClassRatio.lean` lines 963,
1035); `Arith/CircleCos` built with none. `tools/check_architecture.py`: **PASS** (`logs/architecture-1.log`; the new row
`Arith/CircleCos`, `ClassRatio`'s imports cell and state sentence); with `Arith/CircleCos` dropped from `ClassRatio`'s
imports cell, **FAIL** "imports of Rigidity/ClassRatio: … real-only ['Arith/CircleCos']" (`logs/architecture-plant.log`),
then restored.

**No statement and no definition changed** (`statements-after1.txt` against stage 1's dump; `statements-compare1.out`):
**SAME 44, PRIVATE-SAME 129, CHANGED 0, MISSING 0, ADDED-PUBLIC 0**, ADDED-INTERNAL 33, NEW-MODULE 27 (`Arith/CircleCos`'s
public constants) — PASS, across the new import (no stored term of `ClassRatio` or the count moved). Five plants fire
(`statements-plant1.out`, among them one character of the private `card_fibre`'s stored type, read PRIVATE-CHANGED).

**Axioms** (`data/fs131/icm3/lean/Axioms.lean`, FS131-ICM2's printer with `Arith/CircleCos` added; reader
`tools/fs131_icm3_axioms.py`, the two remaining leaves named by `--leaves`; `axioms1-read.out`): **187 records — CLEAN 175,
IMPORTED 7, UPSTREAM 5, FAIL 0**. IMPORTED (Weil and the standard three): `tca_uniform`, `exists_uniform_tail`,
`charBound_one_weil`, `ratioAtMost_weil`, `ratioAtMost_weil_lt`, and now `charBound_one_exact_27`, `charBound_one_exact`.
UPSTREAM: the two leaves; `ratioAtMost_of_five_le_chromaticNumber`, `tca_of_five_le_localBound` over them;
`count_of_oneAvoidingDensityBound` over `Plane.upperDensity_le_of_oneAvoidingDensityBound` and
`Rigidity.noRamifiedStableDyadic_of_tca` only. Without the leaf list **FAIL 4** (`axioms1-read-noleaves.out`, exit 1); the
planted `sorry` and axiom **2 of 2 FAIL** (`axioms1-plant-read.out`).
