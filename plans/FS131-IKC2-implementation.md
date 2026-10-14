# FS131-IKC2 — the class-ratio certificates: the checker proved sound, p = 11 into the library, p = 19 in a form that fits

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-IKC2-soundness-leaves.md` (on `main`). Branch `fs131-wc15`, cut
from `fs131-wc14` at `45f0661c6`, worktree `.claude/worktrees/fs131-wnf`. Working files: `data/fs131/ikc2/`. Commits by
explicit path, not pushed (the brief: the remote is unreachable).*

## Theorems this phase proved

- `HadwigerNelson.FibreCertSound.sum_le_of_certOK` (`Arith/FibreCertSound`): an accepted certificate bounds FS-66's
  region, `Σφ ≤ U_num/L` for every `φ : (ℤ/p)² → [0, 1]` with `q(φ) ≥ 0`, every `p` with `NeZero p`. [kernel], the
  standard three (§ Stage 6 for the built tree's print). Statement unchanged (§ Stage 6).
- `HadwigerNelson.FibreCertSound.card_le_of_certOK`: an independent set of `Cay((ℤ/p)², S)` has at most `U_num/L` points.
  [kernel], the standard three. Statement unchanged.
- Private, in `Arith/FibreCertSound`, each [kernel] on the standard three: the four leaves `psd_of_psdCheck` (L1),
  `blockT_nonneg` (L2), `opSum_O23_eq` (L3), `opSum_O4_eq` (L4), and their helpers (§§ Stage 2–5).
- **Not reached**: K1 at p = 11 (the library modules at eight segments) and F2 at p = 19 — § What is left.

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_ikc2_quotes.py` reads every `>` block of the brief with its `— source:` line and searches for the block's
text, whitespace-normalised, in the named file on `main`. All nine blocks FOUND: W2 in `data/fs131/REQUEST-2026-10-13.md`;
the five dated lines in `data/fs131/claims-NF2.md`; items 848, 853 and 869 in `plans/FS131-close-inventory.md`. Its
control (`--plant`: one character of the first block changed) reports that block NOT FOUND and exits 1. No mismatch.

### 1.2 The four leaves, one line each beside their route

| leaf | restated | route (first implementer's record § Stage 5, checked against the checker's text) |
|---|---|---|
| L1 `psd_of_psdCheck` | an accepted PSD check makes the block's matrix `R = triGet b.tri` positive semidefinite on its `m` indices | `Blk.tri`'s rows have exactly `m − k` entries, so `symRows` row `i` is `R[i][0..m−1]`; each packed row of `M` is the sum of its digits; digit `m + 1` of `row_i · rev_j` is `Σ_{k=1}^m d_ik d_jk` (the product's base-`B` coefficients are below `B` by `(m+1)·4^wm < 2^wB`); so `E = s·R − G` with `G` the Gram matrix of `d − Cm`; `E` symmetric and diagonally dominant gives `vᵀEv ≥ 0`, so `s·vᵀRv ≥ 0` |
| L2 `blockT_nonneg` | a block whose matrix is PSD contributes a non-negative number at every `φ` | `p·blockT = Σ_j Σ_γ vᵀRv` per weight, `v₀ = c`, `v₁₊ₐ = Σ_x g_j(x) Π_{y ∈ A_a} φ(γ(y + x))`, `g_j(x) = f(j + ⟨u, x⟩)` (`u ≠ 0`) or `f(0)`; the linear terms by translation invariance, the quadratic by `x' = x + t` and the shift `j ↦ j − ⟨u, x⟩` (no primality) |
| L3 `opSum_O23_eq` | the times-1 constant, linear and orbit-row ops are, at the moments, the times-1 blocks' terms | O2 term by term; O3 through phase 1's invariant (each orbit row's slot `t` is `Σ_{pairs → ρ} Σ_b mult·R_b[1+i][1+j]·K_b(g t)`, the bound keeping digits below `2^w`); each pair's transporter moves its sum onto `(a_i, a_j)` (`g` linear, a bijection of `V`; the swap by a translation and `K` even); `i ≤ j` with doubling, `R` symmetric |
| L4 `opSum_O4_eq` | the times-q ops are `q(φ)` times the q-blocks' terms over the one monomial `[0]` | `Q(m)(Y) = q(φ)·Y(m)` (`γ` a bijection of `V`, its linear part a bijection of `S`); every `t` moved onto its class's representative (`g(t_ν) = t`, `g 0 = 0`), then regrouped by class |

I checked each leaf's statement against the checker before proving it, for the failure item 853 found (a check whose
acceptance does not imply the step): none found. L1 needs the exact row lengths of `Blk.tri`, which the decoder gives (it
reads exactly `m` and then `m − k` fields); over an arbitrary triangle with a short row the dominance check would skip
entries, so L1 is true for `b.tri` and would be false for a general `tri` — the statement is the former.

### 1.3 The stored statements before any edit

`data/fs131/ikc2/lean/StatementDump.lean` (FS131-IKC1's dumper, copied) against the tree's built library at `45f0661c6`
(its `.olean`s newer than their sources; FS131-IKC1's last build), under the slot, before any edit:
`data/fs131/ikc2/statements-before.txt` (441 constants: 217 in `FibreCert`, 3 in `FibreCert3`, 221 in `FibreCertSound`;
sha256 `7d01d5e40ec00cc0f98d5d8ea8f0f2a841985ce0777f421fe376d784eda4b41d`). It is byte-identical to FS131-IKC1's
`statements-after.txt`, so the chain of comparisons runs from the planner's dump through FS131-IKC1's to this one.

## Stage 2 — SAVED: L1 `psd_of_psdCheck` proved

No `sorry`; the module elaborates with three `sorry` warnings left (L2, L3, L4). 460 lines (the record priced 250–350),
in `Arith/FibreCertSound` § Leaf L1, every helper private:

* the decoder's shape — `readK_length`, `trows_length`, `tri_rows` (`Blk.tri`'s row `k` has exactly `m − k` entries);
  `rec_iter` (a `Nat.rec` loop is `f^[n]`), `symStep_iter`, `symRows_eq` (`symRows` is `triGet` on `m × m`);
* the check's parts named (`pDigs`, `pRev`, `pSig`, `pE`, `pFold`, `pRowOK`, `pAll`, `pOkB`) with `psdCheck_eq : psdCheck b =
  (pOkB b && (pAll b).2) := rfl`, and the two folds computed (`rowFold`, `allFold`);
* the arithmetic — `base_expand` (a number below `B^K` is the sum of its digits), `horner`, `cauchy` (the product of two
  base-`B` numbers coefficient by coefficient), `kron` (digit `m + 1` of `row_i · rev_j` is `Σ_{k=1}^m d_ik d_jk` when every
  digit is below `A` and `(m+1)·A² < B`), `pE_eq` (the entry the check computes is `s·R_ij − Σ_k (d_ik − Cm)(d_jk − Cm)`);
* `dd_nonneg` (a symmetric, diagonally dominant matrix is PSD), `gram_sum`; then `s·vᵀRv = Σ_k (Σ_i u_ik v_i)² + vᵀEv ≥ 0`.

What the proof reads from the check: `|mrows| = m`; each row below `2^(wB(m+1))`; every digit below `2^wm`;
`(m+1)·4^wm < 2^wB`; and each row's dominance. It does not read the tag digit's value, `Cm`'s value or `s`'s beyond `s > 0`.

## Stage 3 — SAVED: L2 `blockT_nonneg` proved; the price re-made from the first two leaves

No `sorry` in L2; two left (L3, L4). In `Arith/FibreCertSound`:

* **shared with L3 and L4** (§ Codes, weights and moments, about 155 lines): `sum_codes` (a sum over the codes below `p²`
  is a sum over `V`), `sum_range_zmod`, `dotP_eq` (`dotP p u t = ⟨pt u, pt t⟩.val`), the weights read on points (`fz`,
  `gw` the virtual weight `x ↦ f(j + ⟨u, x⟩)`, or `f(0)` at `u = 0`; `kz`), `kappa_eq` (`κ(t) = kz(pt t)` for a weight in
  range), `sigma_eq` (`σ = p·Σ_j g_j(z)` at every `z`), `sum_gw_mul` (`p·Σ_j g_j(z) g_j(z') = κ(z' − z)`: the shift
  `j ↦ j + ⟨u, z⟩`, no primality), `Psi`, `sum_Psi` and `sum_Psi_mul` (translation invariance), `Ym_pair`;
* **L2 itself** (about 180 lines): `bvec_quad` (the form on `(c, w₀, …, w_{N−1}, 0, …)`, `R` symmetric), `quad_expand`,
  `sum_wv` (`p·Σ_{γ,j} w_a = p²·σ·Y(A_a)`), `sum_wv_mul` (`p·Σ_{γ,j} w_a w_a' = p²·Σ_t κ(t) Y(A_a ∪ (A_a' + t))`: the
  pair's moment moved by `−z`, then `z' = z + w`), `weight_nonneg` (`p·Σ_{γ,j} vᵀRv = p²·(the weight's terms)`, the left
  side `≥ 0` by `PSDN`).

**Re-priced from the first two leaves** (LEAN.md: re-price from two leaves, never from a plan's table). L1 took 460
lines against 250–350, L2 about 335 with the shared part against 200–300: about 1.3–1.5 times the record's figures.
L3 (priced 350–500) and L4 (150–250) at that ratio are about 500–700 and 150–300 (L4 reuses the shared part), so K2 is
about **2,200–2,500 lines** in all (600 before this job, 795 now, 650–1,000 left) — inside the planner's 2,000–4,000 and
above FS131-IKC1's 1,550–2,000. No message owed (the brief's line is 4,000).

## Stage 4 — SAVED: L4 `opSum_O4_eq` proved

No `sorry` in L4; one left (L3). About 340 lines (§ Leaf L4: the q-part; the record priced 150–250). The route is
the record's:

* `opSum_qmono` — one q-form's ops are `cf·q(φ)·Y(m)`: per point `x` the three families are, at every map `γ`,
  `Π_m φγ · cf·(2φ(γx) − 2φ(γx)² − Σ_{s∈S} φ(γx)φ(γ(x + s)))` (`sum_sList`: the codes `sList` are the circle, which
  needs `p ≥ 2`, read from `globalOK`); then `qbracket` (`act_add`, `sum_lin_S`: the linear part of `γ` permutes `S`;
  `sum_act`: `γ` permutes `V`) makes the bracket `q(φ)`;
* the q-part's coefficients read off `qcoefs` (`qfold`, `foldl_cond`, `zip_range_map`), the transporter at every `t`
  (`Ym_transport`, with `gList_getD_le`: a map of `gList`, or the default, has coordinates at most `p`), and the classes
  regrouped (`Finset.sum_ite_eq`, the class below `|tnu|` from the check); the double list sum over blocks and weights
  handled as one functional (`Lam`, `Lam_add`, `Lam_mul`, `Lam_fsum`, `Lam_congr`).

What it reads from `globalOK`: `p ≥ 2` and the q-part's verdict (every `t` has a class `ν < |tnu|` and a unit map `g`
with `g(t_ν) = t`).

## Stage 5 — SAVED: L3 `opSum_O23_eq` proved; the module holds no `sorry`

`Arith/FibreCertSound` elaborates with no `sorry` and no warning (`lake env lean`, iteration only; the build is § Stage 6).
From a scratch copy with `#print axioms` appended (`data/fs131/ikc2/work/AxSrc.lean`): `sum_le_of_certOK`,
`card_le_of_certOK` and the four leaves each `[propext, Classical.choice, Quot.sound]`. L3 is about 620 lines (the record
priced 350–500), in four sections:

* **buckets** — `Bk` (buckets of at most 16, all but the last full), `Bk_getD`, `Bk_mem`, `Bk_mod` (on a bucketed list,
  `bget`, `bmem`, `bmod` are the flattened list's `getD`, bound and `modify`), `brec_spec`, `bucket16_spec`;
* **the transport, the swap and the pairs** — `kz_neg` (`κ` even), `Yv_pair_swap`, `sum_pair_swap`, `transport_w` (an
  orbit row's slots read at a pair through its checked map: `g` linear, a bijection of `V`, the bags multisets by
  `bag_perm`; the swap by a translation and `κ` even), `W_symm`, `repPairs_sum`, `pairs_double` (over `i ≤ j`, `mult·F`
  is the full double sum of a symmetric `F`, by induction on `N`);
* **one pair** — `krow_eq` (the packed rows), `kmax_ge`, `kblock_eq`, `p1step_eq` (`rfl`: the step's parts named) and
  `Inv1_step`: the invariant `Inv1` (ghost slot values `P`, `N` with the rows `(A0, A1, Σ_t P_t B^t, Σ_t N_t B^t)` in
  buckets, every slot pair at most the running bound, and, while every check holds, the rows at the moments equal to the
  pairs' shares so far) survives a pair; a default table entry adds nothing and fails the unit check;
* **the fold and its ends** — `Inv1_fold`, `Inv1_init`, `pairCoefs_eq` (the triangle's rows `1..` read along the pairs,
  from `m = |reps| + 1`), `contrib_sum`, `opSum_O2`, `digit_sum`; then the leaf: phase 1's final rows are the literal
  `orows` (`orowsOK`), their digits are the ghosts (bound below `2^w`), and the identity's O2 and O3 parts are the blocks'
  terms.

**K2 in all**: `Arith/FibreCertSound` is 2,665 lines against 794 at this job's start; with FS131-IKC1's part, K2 took
about 2,450 lines of proof — inside the planner's 2,000–4,000, and as § Stage 3's re-price said. **No change to
`certOK`'s definition was needed** (none made): every check the proof reads was already in FS131-IKC1's checker.

## What is left (not reached in this job)

* **K1 at p = 11** (brief item 3): not started. The converter is `tools/fs131_ikc1_gen.py` (FS131-IKC1's; `--nseg 8`,
  `--doc`/`--tail` write library modules). The work: generate the data module and one check module per declaration
  (`globalOK`, eight `segCheck`s, `psdAll`), register them in `Proofs.lean` and `ARCHITECTURE.md`, build under the slot
  and measure each declaration (FS131-IKC1 § Stage 6 measured nseg = 4 at 7.1–9.5 GB a segment, a segment's fixed cost
  about 4.5 GB; nseg = 8 is extrapolated near 7 GB, not run); then `cert11_ok : certOK cert11 = true` and the bound at
  p = 11, `sum_le_of_certOK cert11 cert11_ok` (with `NeZero 11`), which now rests on the standard three plus whatever
  `cert11_ok` prints (`[propext]`, as `cert3_ok` does).
* **F2 at p = 19** (brief item 4): not started; the planner's record § 3.2 is the design. Every new part of the checker
  will need its own soundness lemma in the style of this job's (§§ Stage 2–5): the per-segment op lists and the bitmask
  cover replace `sum_shadow`/`seg_shadow`'s "every segment reads every op", and the tree literals replace the list reads.
  So F2 changes `certOK`'s definition and reopens K2's computation half; it is a checker job plus a proof job.

## Stage 6 — SAVED: the build, the statements from the kernel's side, the axioms

* **The build** (`./scripts/build.sh` under the slot, `--mem 10 --cpus 4`, `MEMMAX=10G BATCH=8`): OK, 249 of 249
  batches, 2 modules rebuilt (`Arith/FibreCertSound`, `Proofs`), **0 modules with warnings**, 6m35s
  (`data/fs131/ikc2/logs/build1-full.log`, the gate's copy `build1-gate.log`).
* **No conclusion weakened.** `StatementDump.lean` on the built library (`data/fs131/ikc2/statements-after.txt`)
  against § 1.3's dump, read by FS131-IKC1's `tools/fs131_ikc1_statements.py` (not edited): `sum_le_of_certOK`,
  `card_le_of_certOK`, `V`, `unitCircle`, `qform`, `Cert.p`, `Cert.scale`, `Cert.unum` — SAME, raw stored text
  identical (`statements-compare.txt`, exit 0). Its control plants `LE.le → LT.lt` in the after-dump's type of
  `sum_le_of_certOK` and exits 1 naming it (`statements-compare-control.txt`). Public constants: none removed, none
  changed; one added, `qform.congr_simp`, which Lean generates on demand in the module that defines `qform` (L4's `simp`
  asked for it; a reserved name, in the module of its definition, so no second copy elsewhere). `FibreCert` and
  `FibreCert3` are byte-for-byte as § 1.3 has them (217 and 3 constants, unchanged): **no change to `certOK`'s definition.**
* **Axioms** (`data/fs131/ikc2/lean/Axioms.lean`, FS131-IKC1's printer copied, → `data/fs131/ikc2/axioms.txt`; read by
  `tools/fs131_ikc2_axioms.py` → `axioms-read.txt`, exit 0): 205 public records of the three modules and 418 private
  theorems of `Arith/FibreCertSound`, every one a subset of the standard three; `sum_le_of_certOK`, `card_le_of_certOK`,
  `model` — `[propext, Classical.choice, Quot.sound]`; `cert3_ok` — `[propext]`. The planted record
  `FS131IKC2Axioms.planted` reads `[sorryAx]`; the reader's control (`--control`, `sorryAx` planted into the first public
  record) exits 1 naming it (`axioms-control.txt`). `native_decide`: nowhere in the three modules.
* Not run: the axiom audit, the vacuity scan, the assumptions step, the lint and the doubled names over the whole library
  — the landing's. For the vacuity scan's reading: `sum_le_of_certOK`'s hypotheses are inhabited together by `model`
  (`cert3`, `φ = 0`).

## Drafts for the front page

### `scripts/Axioms.lean`, CLEAN (for the landing)

`HadwigerNelson.FibreCertSound.sum_le_of_certOK`, `HadwigerNelson.FibreCertSound.card_le_of_certOK`,
`HadwigerNelson.FibreCertSound.model`, `HadwigerNelson.FibreCert.cert3_ok` — each a subset of the standard three in the
built tree (§ Stage 6).

### `data/fs131/claims-NF2.md` § Dated lines (to follow the last)

- 2026-10-14 — **The class-ratio checker is proved sound** (FS131-IKC2): `FibreCertSound.sum_le_of_certOK` and
  `card_le_of_certOK` are kernel theorems on the standard three, their stored statements unchanged since FS131-KC13 typed
  them; `certOK`'s definition unchanged since FS131-IKC1 strengthened it. An accepted certificate now implies `Σφ ≤ U_num/L`
  on FS-66's region at its `p`. The p = 11 certificate's library modules (K1) and p = 19's form F2 are not yet built.

### `LEAN.md` § Searching — Lean (after the last bullet)

- In a module importing only `Mathlib.Data.ZMod.Basic`, `Mathlib.Data.Real.Basic` and the big-operator files,
  `List.getD_append`, `List.getD_append_right`, `List.getD_eq_default`, `List.getD_eq_getElem`, `Finset.sum_range_reflect`,
  `Finset.sum_div` and `abel` are unknown (they live in `Mathlib.Data.List.GetD`, `Mathlib.Algebra.BigOperators.Intervals`,
  …); a three-line local version through `List.getElem?_append_left`/`_right` and `List.getElem?_eq_none` serves, and
  adding the import changes which instances later statements store (§ above) (FS131-IKC2).
- A checker written as one long `let` chain is reasoned about through an `rfl` restatement with each part a named
  private definition (`FibreCertSound.psdCheck_eq`, `p1step_eq`): the parts can then be unfolded one at a time. A fold
  lemma whose step function is `fun a x => … R a.1 x …` does not rewrite by `simp` (`R a.1 x` is not a pattern);
  instantiate it with the function and `rw` with the instance, or let `exact` check it by definitional unfolding
  (`allFold`, `qfold`) (FS131-IKC2).
