# FS131-IDB3 — the density bound's third implementer: lane X, `[AmbrusEtAl2023]`'s certificate as a Lean instance, and `Plane.OneAvoidingDensityBound` proved

*de Bruijn, the implementer (Opus 5.5), 2026-10-14. Brief: `data/fs131/briefs/FS131-IDB3-x23-theorem.md` (on `main`), with
`plans/STANDING-RULES.md`. Branch `fs131-wdb3`, cut from `fs131-wdb2` at `3e70e00e8`; tree `.claude/worktrees/fs131-w10g`. The
design is `plans/FS131-IDB2-implementation.md` § 5.2; the plan `plans/FS131-KDB1-density-bound.md` (§ 3.3's typed block, § 4.2).
Resuming: read this file, check its last SAVED stage against `git log -- plans/FS131-IDB3-implementation.md`, continue at the first
stage not SAVED. Working files: `data/fs131/idb3/`.*

## Theorems this phase proved

Every record below is kernel-checked in the built tree of `fs131-wdb3` (build `data/fs131/idb3/build2-full.log`, exit 0,
0 modules with warnings; the 21 check modules compiled in `build1-full.log`) and its axioms are printed from that tree
(`data/fs131/idb3/axioms.txt`, read by `tools/fs131_idb3_axioms.py`): **427 records of 27 modules, 218 axiom-free and 209 on
a subset of `[propext, Classical.choice, Quot.sound]`; none on `sorryAx`, none on a native axiom.**

- **`HadwigerNelson.Plane.oneAvoidingDensityBound : Plane.OneAvoidingDensityBound`** (`Plane/DensityBound/Theorem`) —
  `[AmbrusEtAl2023]` Theorem 1, "Any Lebesgue measurable, 1-avoiding planar set has upper density at most 0.2470" (p. 4),
  at every centre — [kernel], `[propext, Classical.choice, Quot.sound]`.
- `HadwigerNelson.DensityBound.X23_valid : X23.Valid` (`Plane/DensityBound/X23`) — the paper's certificate is valid: the
  2,321 congruences, `V ≥ −ν` (`ν = 10⁻⁵`) on every nonempty independent atom, `bound ≥ 0` — [kernel], the standard three.
- `HadwigerNelson.DensityBound.X23_phi` (`Theorem`) — `∀ t ≥ 0, 1 − 6/10⁵ ≤ X23.phi X23w0 t` (eq. (22), p. 18's `µ`) —
  [kernel], the standard three.
- `HadwigerNelson.DensityBound.X23_ratio` (`Theorem`) — `X23.bound / (1 − 6/10⁵) ≤ 0.2470` (p. 19) — [kernel], the standard
  three.
- `HadwigerNelson.DensityBound.X23_close` (`Plane/DensityBound/X23Dist`) — the certificate's 27 distances within `2⁻⁶⁴` of
  the covering's `P23.Ds` — [kernel], the standard three.
- The checker's semantics (`X23`): `X23Check.collect_sound` (every set passing the DFS's refusals is reached, with its sum),
  `dfsG_eq_all`, `dfsG_append`, `sum_groups`, `L_eq` (`L(S)·10²¹` is the sum of the terms in `S`), `X23_atoms`,
  `congruent_of_rowOk`, `dist_of_sqd`, `dist_of_adj`, `distOk_sound`, `ev_mul` and the field algebra — [kernel], the
  standard three or fewer.
- The kernel checks themselves (`X23Data`, `X23Cong00`–`07`, `X23Atoms00`–`12`, `X23All`): `encl_ok`, `adj_ok`, `terms_ok`,
  `groups_eq`, `one_group`, `verts_length`, `frontier_eq`, `frontier_rt`, `wc00_ok`–`wc07_ok`, `fr00_ok`–`fr102_ok`, `wcR_ok`,
  `frL_ok` — [kernel], `decide +kernel`, on `[propext]` or none.

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations, against their sources (standing rule 3)

`data/fs131/idb3/quotes_check.py` searches every `> ` line of the brief verbatim in the file its `— source:` line names (on
`main`), and the inline W6; a control with one letter changed (`formalized` → `formalised`) is not found.

| # | the brief quotes | source | verdict |
|---|---|---|---|
| Q1 | W2 (2026-10-13) "I choose the second form. Any finding of ours must be formalized. …" | `data/fs131/REQUEST-2026-10-13.md` | verbatim |
| Q2 | dated line 2026-10-14 "The density bound has a route with no periodic reduction and no Bessel citation" | `data/fs131/claims-NF2.md` | verbatim |
| Q3 | dated line 2026-10-14 "The certificate's analytic half is priced in the kernel" | `data/fs131/claims-NF2.md` | verbatim |
| Q4 | item 845 (FS131-KDB1 handed back) | `plans/FS131-close-inventory.md` | verbatim |
| Q5 | item 866 (FS131-IDB1 handed back) | `plans/FS131-close-inventory.md` | verbatim |
| Q6 | item 895 (FS131-IDB2 handed back at stage 5) | `plans/FS131-close-inventory.md` | verbatim |
| Q7 | "Yes, prove the density bound." (W6, inline) | `data/fs131/REQUEST-2026-10-13.md` | verbatim (one occurrence) |

No mismatch. The statement of `BesselCert.Cells.phiApprox_ge` that item 866 quotes in words is read from the module itself
(`Plane/DensityBound/Cells/Covering.lean`): `∀ d : List ℝ, Close P23.Ds d → ∀ t : ℝ, 0 ≤ t → (P23.TN : ℝ) / P23.TD ≤
P23.w1N / P23.WS + jsum P23.Ws d t / P23.WS`, with `Close Ds d := List.Forall₂ (fun D x => |x − D/S| ≤ 1/S ∧ 0 ≤ x) Ds d`,
`S = 2⁶⁴` (`BesselCert`, `BesselCheck`).

### 1.2 The certificate files, checksummed (read only)

| file | sha256 |
|---|---|
| `data/pa-ambrus2023/g23.csv` (2,350 rows: `w_0`, `w_T`, `w_1` ×1, `w_2` ×26, `w_C` ×2,321) | `cbfe22f5028f23a84f17d97802a93517e702eea0181d692ad7f5477763cf7274` |
| `data/pa-ambrus2023/verification23.nb` (the notebook; its `X = {…}` cell is the point list) | `7d230f20d41a2a3355bee78241c9d626134548c18eeec4de8a1d1217a74cecec` |
| `data/pa-ambrus2023/verification23.pdf` | `cab617df632c675c6239080350d9eceaef0bd8ce07e1a9cbd612c52743c0af11` |
| the paper, `~/source/library/pdf/arXiv-2207.14179-ambrus-csiszarik-matolcsi-varga-zsamboki-density-planar-sets.pdf` (v3) | `12850eb7d4ddc3f909799422d46f18e790730efb8003a35f9a66fd347aff315b` |

The generator records these checksums in its output and refuses to run on a file whose checksum differs.

### 1.3 The paper's eq. (22) and Theorem 1, restated from the last implementer's reading (`FS131-IDB2-implementation.md` § Stage 4)

Re-read by me this job from the held v3 (`pdftotext -layout`): p. 17 (eq. (22)), p. 18 (`µ`), p. 19 (the final bound), p. 23
(Table 1, read as a rendered image) and p. 24 (Table 2). Theorem 1 (p. 4): "Any Lebesgue measurable, 1-avoiding planar set has
upper density at most 0.2470." — `Plane.OneAvoidingDensityBound`, read aloud by the planner (FS131-KDB1 § 1.3); unchanged.

| the paper | the library, and what this lane fixes |
|---|---|
| `ϕ(t) = w0 J0(t) + Σ_{i∈[n]} w1(i) + Σ_{{i,j}} w2(i, j) J0(t|xi − xj|)`, "with xi being defined by Table 1 and the non-zero coefficients w specified by Table 2" (eq. (22), p. 17) | `DualCert.phi w0 t = w0 * J0 t + ∑ i, C.w1 i + (C.w2.map fun e => e.2.2 * J0 (t * ‖C.X e.1 - C.X e.2.1‖)).sum`; this lane's `X23.w2` lists the 26 `w_2` rows in `g23.csv`'s order, which is `P23`'s term order 1–26 (`Cells/Data`'s docstring), so `X23_phi` reads `phiApprox_ge` with no permutation |
| Table 1, `x1 … x23` (p. 23) | `X23.X i = (ev Pᵢ.re + ev Pᵢ.im · i)/12`, `Pᵢ = 12 xᵢ` with integer coordinates in the basis `1, √3, √11, √33`; the generator compares the notebook's list with my transcription of Table 1 (point by point, exactly) and the kernel reads only the notebook's |
| Table 2: `w0`, `wT`, `w1(1)`, the 26 `w2(i, j)` (p. 24) | the generator compares each with `g23.csv`'s row exactly (as decimals) |
| `µ = 0.00006` (p. 18) | `X23_phi : ∀ t, 0 ≤ t → 1 − 6/10⁵ ≤ X23.phi X23w0 t` |
| `ν = 10⁻⁵`, "changing wT to w̃T = wT + ν" (p. 16) | `X23.bound = wT + 10⁻⁵` (item 895's ruling 1: the paper's value, not the planner's typed `10⁻⁶`) |
| "m1(R²) ⩽ (wT + ν)/(1 − µ) = 0.24699 … < 0.2470" (p. 19) | `X23_ratio : X23.bound / (1 − 6/10⁵) ≤ 0.2470` |
| `C(X)`, `wc(I, J)`, "X\|J = ϕ(τ(X\|I))" (p. 9) | `X23.wc` from the 2,321 `w_C` rows, `I`, `J` as `Finset (Fin 23)` (indices shifted to 0-based); `Valid.cong` by an explicit isometry per row with the row's own order as the correspondence (FS131-IDB2 § 4.1 found all 2,321 so) |
| `V(ε) ≥ −ν` on every independent atom (eq. (20), p. 16) | `Valid.atoms : S.Nonempty → IsIndep S → L S ≤ bound` |

### 1.4 Lane X's parts, beside the design (FS131-IDB2 § 5.2)

| part (module) | what it holds | the design | change |
|---|---|---|---|
| `Plane/DensityBound/X23Check` (core, no import) | exact arithmetic in `ℤ⁴` (`a + b√3 + c√11 + d√33`) and its complex pairs; the edge check on adjacency masks; the congruence check per `w_C` row (`b`, `U`, `m`, `V` with `|U|² = m²` and `U·(b ? P̄ : P)ₖ + V = m·P_{Jₖ}`, `u = U/m`, `v = V/(12m)`); the packed terms (`mask + 2²³·(c + 2⁶⁸)`), their grouping by highest vertex; the DFS `dfsG` with a leaf predicate and its list-valued twin `collect`; the distance enclosure check | the same | the DFS is cut at a depth `k` by a literal frontier of states checked equal to `collect`'s output, then chunk by chunk (one soundness lemma, `collect`'s, serves both halves) |
| `Plane/DensityBound/X23Data` (+ `X23Cong*`, `X23Atoms*`, generated by `tools/fs131_kdb1_x23.py`) | the points, the tables, the witnesses, adjacency, groups, frontier; one `decide +kernel` theorem per part | the same | the congruence and atom parts in several modules, so the build runs them in parallel |
| `Plane/DensityBound/X23` (Mathlib) | `X23 : DualCert 23`, `X23w0`; the soundness lemmas; `X23_valid` | the same | — |
| `Plane/DensityBound/X23Dist` | `Close P23.Ds (1 :: X23.w2.map (‖X i − X j‖))` | the same | — |
| `Plane/DensityBound/Theorem` | `X23_phi`, `X23_ratio`, `HadwigerNelson.Plane.oneAvoidingDensityBound` | the same | — |

The statements are the planner's typed block (FS131-KDB1 § 3.3) with `bound = w_T + 10⁻⁵`: `X23_valid : X23.Valid`;
`X23_phi : ∀ t : ℝ, 0 ≤ t → 1 - 6 / 10 ^ 5 ≤ X23.phi X23w0 t`; `X23_ratio : X23.bound / (1 - 6 / 10 ^ 5) ≤ 0.2470`;
`Plane.oneAvoidingDensityBound : Plane.OneAvoidingDensityBound`. No existing statement or definition is touched.

## Stage 2 — SAVED: the checker, its soundness, and the planted faults

### 2.1 What was built (all new files; no existing module touched)

| file | lines | what |
|---|---|---|
| `Proofs/HadwigerNelson/Plane/DensityBound/X23Check.lean` (core, no import) | 330 | the checker (§ 1.4), 12 spec examples by `decide` |
| `tools/fs131_kdb1_x23.py` | 560 | the generator: checksums, read-backs (Table 1 transcribed in `data/fs131/idb3/paper-table1.txt`, Table 2's text in `paper-table2.txt`, `P23`), the integer data, an exact Python mirror of every check, the modules |
| `Proofs/HadwigerNelson/Plane/DensityBound/X23Data.lean`, `X23Cong00`–`07`, `X23Atoms00`–`12`, `X23All` (generated, core) | — | the data and 8 + 103 + 8 `decide +kernel` theorems, assembled in `X23All` (`wcR_ok`, `frL_ok`) |
| `Proofs/HadwigerNelson/Plane/DensityBound/X23.lean` (Mathlib) | 790 | the semantics and `X23_valid` |
| `Proofs/HadwigerNelson/Plane/DensityBound/X23Dist.lean`, `Theorem.lean` | 60, 85 | `X23_close`, `X23_phi`, `X23_ratio`, `Plane.oneAvoidingDensityBound` |

**Deviations from the design, and one finding.** (i) The scale is `10²¹`, not `10²⁰`: one `w_C` row of `g23.csv`,
`5.4369049825320215e-05`, has 21 decimals, and is not an integer at `10²⁰` — the planner's prototype `proto_atoms.py` read
it with `int(v * WS)`, truncating it silently (its assertion `Fr(c, WS) * WS == c` is true of every integer). The kernel
check here is exact at `10²¹`; `phiApprox_ge`'s weights (`w₀`, `w₂` at `10²⁰`) are exact and are matched to `X23`'s by
`w₂·10²¹ = 10·Ws` (checked by `decide +kernel` in `X23_phi`). The truncation moved one coefficient by `< 10⁻²⁰` and changes
no verdict (min V is reproduced here, exactly, at `10²¹`: `−6.712244·10⁻⁸`). (ii) The DFS is cut at depth 15 (the design
said "a prefix enumeration"): 492 frontier states, 7,123,866 mask tests below them in 103 chunks of ≤ 80,000; the prefix
itself is checked by `frontier_eq` (the DFS's own frontier, packed, equals the literal) and `frontier_rt` (packing
round-trips). (iii) The atom DFS's term groups are computed by the kernel from the coefficient tables (`groups_eq`,
`one_group`), so the terms `L(S)` sums can be no other than the certificate's; the semantics is one induction
(`collect_sound`) used once, through `dfsG_append` and `dfsG_eq_all`.

### 2.2 Read-backs and the exact mirror (`python3 tools/fs131_kdb1_x23.py --plan`)

Table 1 (23 points, transcribed from the rendered p. 23) equals the notebook's list exactly, point by point; Table 2 (`w₀`,
`w_T`, `w₁(1)`, the 26 `w₂(i, j)`, from p. 24's text) equals `g23.csv`'s rows exactly; `P23.Ws` is `w₀` then the 26 `w₂` in
`g23.csv`'s order and `P23.w1N = w₁(1)·10²⁰`. Mirror: 47 edges; 2,321 rows, an isometry for each (`m ≤ 444`); 4,669 terms;
13,552 independent sets reached, `max L = w_T + 6.712244·10⁻⁸`, so min `V = −6.712244·10⁻⁸ ≥ −ν` (J26's number);
26 distances pass with `K = 2¹²⁸`.

### 2.3 The kernel on the first parts (farm, `data/fs131/idb3/farm.sh`; each under the slot)

| module | time | peak RSS |
|---|---|---|
| `X23Check` | 0.8 s | 0.52 GB |
| `X23Data` (the 8 small checks) | 74–78 s | 3.13–3.16 GB |
| `X23Cong00` (300 rows) | 8.0 s | 1.64 GB |
| `X23Atoms00` (8 chunks, 598 k tests) | 90.7 s | 2.40 GB |
| `X23`, `X23Dist`, `Theorem` (against a farm stub of `X23All` whose two theorems are `sorry`) | 10.9 s, 1.8 s, 2.1 s | 3.3 GB |

A module of eight ≤ 80 k-test theorems peaks at one theorem's memory (item 845's question, answered again).

### 2.4 Planted faults, each refused by the kernel (`data/fs131/idb3/plants/Plants.lean`, log `plants.log`)

| plant | the kernel | partner (unplanted) |
|---|---|---|
| a wrong distance: `w₂` distance 6 moved by `2·2⁻⁶⁴` | "`decide` proved that the proposition `distsOk … = true` is false" | `distsOk ptsL enclL P23.Ds.tail w2T = true` passes |
| a missing congruence: row 115 (`{2,6,8} ↦ {3,8,6}`, 1-based) with `J`'s last point moved, claiming `{2,6,8} ≅ {3,8,1}` (different side lengths) | `rowOk ptsL badRow = true` is false | the row itself passes |
| an atom with `V < 0`: bound lowered to `w_T + 6·10⁻⁸` | chunk 26's check is false | at `w_T + 7·10⁻⁸` chunk 26 passes: the check is tight at the true min V |
| a changed `w₁` against the groups | `groups_eq` with `w1N + 1` is false | `groups_eq` passes |
| the frontier with one state dropped | `frontier_eq` with `frL.tail` is false | `frontier_eq` passes |

## Stage 3 — SAVED: the data, the build, the theorem

### 3.1 The modules in the build's lists

`Proofs.lean`: the 27 modules after `Plane.DensityBound.Window`, in dependency order; `ARCHITECTURE.md`: 27 rows after
`Plane/DensityBound/Window`'s; `tools/check_architecture.py` PASS. The generator run twice gives identical output (`git
status` empty after a second `--write`; `data/fs131/idb3/gen/summary.json` holds each module's sha256).

### 3.2 Two builds under the slot

1. `slot.py --mem 7 --cpus 3 -- env MEMMAX=7G BATCH=2 ./scripts/build.sh` (`build1-full.log`; Lake's log
   `build/gate/build/20261014T190103Z-191486.log`): **the 21 check modules and `X23Data` all accepted by the kernel**, then
   `X23All` refused with "maximum recursion depth has been reached" in its assembly (`show` and `simp` over a 103-deep `++`).
   Not a check failing: the assembly's elaboration. Fixed in the generator (`set_option maxRecDepth 100000 in`; a term chain of
   `all_app` was tried first and timed out at `whnf`, unfolding the literals).
2. The same with `BATCH=10` (`build2-full.log`; `build/gate/build/20261014T192236Z-251041.log`): **exit 0**, 209 batches,
   5 modules rebuilt (`X23All` 3.3 s, `X23` 12 s, `X23Dist` 2.1 s, `Theorem` 2.2 s, `Proofs` 3.6 s), **"0 module(s) with
   warnings"**, 6 m 40 s.

(The brief's `--mem 10 … BATCH=8` waited behind two other slots for ten minutes; a 7 GiB slot at two modules per batch keeps
two 2.4 GB parts and the walk inside its cap.)

### 3.3 Each generated module's kernel time and peak memory

Times are Lake's (`Built … (Ns)`; two modules at a time on three cores); peaks the largest resident set of the module's
`lean`, sampled every 2 s (`data/fs131/idb3/rss/sample.sh`, `samples.txt`, `table.py` → `table.md`).

| module | compile | peak RSS | | module | compile | peak RSS |
|---|---|---|---|---|---|---|
| `X23Check` | 1.0 s | (< 2 s) | | `X23Atoms06` | 99 s | 2.15 GB |
| `X23Data` | 91 s | 2.99 GB | | `X23Atoms07` | 82 s | 2.13 GB |
| `X23Cong00` | 9.8 s | 1.51 GB | | `X23Atoms08` | 98 s | 2.31 GB |
| `X23Cong01` | 12 s | 1.81 GB | | `X23Atoms09` | 104 s | 2.31 GB |
| `X23Cong02` | 13 s | 1.96 GB | | `X23Atoms10` | 105 s | 2.23 GB |
| `X23Cong03` | 16 s | 2.11 GB | | `X23Atoms11` | 98 s | 2.32 GB |
| `X23Cong04` | 15 s | 2.11 GB | | `X23Atoms12` | 75 s | 2.15 GB |
| `X23Cong05` | 17 s | 2.22 GB | | `X23All` | 3.3 s | 0.64 GB |
| `X23Cong06` | 20 s | 2.46 GB | | `X23` | 12 s | 3.09 GB |
| `X23Cong07` | 12 s | 1.88 GB | | `X23Dist` | 2.1 s | (< 2 s) |
| `X23Atoms00` | 106 s | 2.33 GB | | `Theorem` | 2.2 s | 3.03 GB |
| `X23Atoms01` | 87 s | 2.26 GB | | | | |
| `X23Atoms02` | 117 s | 2.34 GB | | | | |
| `X23Atoms03` | 128 s | 2.27 GB | | | | |
| `X23Atoms04` | 91 s | 2.29 GB | | | | |
| `X23Atoms05` | 98 s | 2.17 GB | | | | |

**Kernel time in all: about 25 minutes of CPU** — the atom check 1,288 s (the planner's 12 minutes, × 1.8: the terms decoded
per test and the depth-15 cut), the congruences 115 s, the data's eight checks 91 s. No module near the cap or an hour; the
largest 3.09 GB. The planner's lane X at 700 lines and the last implementer's 900–1,400: this lane is 1,265 hand-written
lines of Lean (`X23Check` 330, `X23` 790, `X23Dist` 60, `Theorem` 85) and a 560-line generator — **1.8× the planner's, inside
the last implementer's range**.

### 3.4 The theorem, read aloud

`Plane.OneAvoidingDensityBound` (`Plane/OneAvoidingDensity`, unchanged): for every `A ⊆ EuclideanSpace ℝ (Fin 2)` that is
`NullMeasurableSet A volume` (Lebesgue measurable) with `∀ a ∈ A, ∀ b ∈ A, dist a b ≠ 1` (1-avoiding), and every centre `x`,
`limsup_{R→∞} vol(A ∩ ball x R)/vol(ball x R) ≤ 0.2470`. The paper's Theorem 1 (p. 4): "Any Lebesgue measurable, 1-avoiding
planar set has upper density at most 0.2470." The same statement (the planner's reading, FS131-KDB1 § 1.3: at every centre
where the paper fixes one and calls the value independent of it). `HadwigerNelson.Plane.oneAvoidingDensityBound` proves it
with no hypothesis: `DualCert.oneAvoidingDensityBound_of X23 X23_valid (mu := 6/10⁵) (by norm_num) X23_phi X23_ratio`.

**Models of the hypotheses** of this lane's structure-taking lemmas, all inhabited by the certificate itself:
`congruent_of_rowOk` by each of the 2,321 rows (`wcR_ok`); `distOk_sound`, `forall₂_of_distsOk` by `enclL` (`encl_ok`)
and the 26 rows (`dists_ok`); `dist_of_sqd`, `dist_of_adj` by the 47 listed edges (`adj_ok`); `collect_sound` by `vertsL`
at the mask of any independent set (used so in `X23_atoms`); `tval_pack` by every term (`terms_ok`).

## Stage 4 — SAVED: statements unchanged, axioms, linters

- **No statement and no definition changed, from the kernel's side.** The dump of every constant of the 56 existing modules
  of the density bound (`data/fs131/idb3/lean/StatementDump.lean`: kind, name, stored type, a definition's value by hash),
  made before the first build (`statements-before.txt`, 3,335 constants) and after the last (`statements-after.txt`), are
  **byte-identical** (`cmp`); `tools/fs131_idb3_statement_diff.py` reads 3,335 constants, 0 differences. Its self-test
  (`--self-test`: a changed type, a changed value, a removed constant, a new public constant, each planted in a copy) fires on
  all four, and the faithful copy reads 0. No existing module was recompiled by either build (only `Proofs`).
- **Axioms**, from the built tree: `data/fs131/idb3/lean/AxiomsIDB3.lean` → `axioms.txt`; `tools/fs131_idb3_axioms.py`
  PASS — 27 modules, 427 records (227 DEF, 191 THM, 3 IND, 3 CTOR, 3 REC), 218 axiom-free, 209 on the standard three or
  fewer; `THEOREM HadwigerNelson.Plane.oneAvoidingDensityBound [propext, Classical.choice, Quot.sound]`. The planted records
  show what was planted: `withSorry → [sorryAx]`, `withNative → [FS131IDB3Plant.withNative._native.native_decide.ax_1_1]`.
- **`native_decide`** in none of the 27 files (`grep -rln`, exit 1); **`sorry`** in none (`grep -c`, all 0).
- **Linters**: `lake lint --no-build -- --no-build --trace` under the slot — exit 0, "-- Linting passed for Proofs.", every
  linter "(2/2) Passed!" (`data/fs131/idb3/lint.log`). No planted lint control was run (it needs a rebuild of a planted
  module); the landing's gate runs the lint's own.
- Not run by this job (the landing's): `scripts/axioms.sh` over the library, `vacuity.sh`, `assumptions.sh`, `dupnames.sh`.
  The new public names are all under `HadwigerNelson.DensityBound.X23Check`, `HadwigerNelson.DensityBound.X23*` and
  `HadwigerNelson.Plane.oneAvoidingDensityBound`; no hypothesis of any new statement is an assumption (none is declared or
  owed to `scripts/Assumptions.lean`).
