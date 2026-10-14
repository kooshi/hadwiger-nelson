# FS131-IKC2 — the class-ratio certificates: the checker proved sound, p = 11 into the library, p = 19 in a form that fits

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-IKC2-soundness-leaves.md` (on `main`). Branch `fs131-wc15`, cut
from `fs131-wc14` at `45f0661c6`, worktree `.claude/worktrees/fs131-wnf`. Working files: `data/fs131/ikc2/`. Commits by
explicit path, not pushed (the brief: the remote is unreachable).*

## Theorems this phase proved

(filled in as the stages fall)

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
