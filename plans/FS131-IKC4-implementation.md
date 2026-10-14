# FS131-IKC4 — the class-ratio certificates: the bound at p = 19 from the reduced certificate

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-IKC4-cert-p19.md` (on `main`). Branch `fs131-wc17`, cut
from `fs131-wc16` at `af4eb1ab2`, worktree `.claude/worktrees/fs131-wnf`. Working files: `data/fs131/ikc4/`. Commits by
explicit path, not pushed (the brief: the remote is unreachable).*

## Theorems this phase proved

Each [kernel], printed from the built tree (`data/fs131/ikc4/axioms.txt`; 420 public records and 438 private theorems of
the 81 modules printed, every one a subset of the standard three):

- `HadwigerNelson.FibreCert.cert19_ok : certOK cert19 = true` (`Arith/FibreCert19Bound`) — the reduced certificate at
  `p = 19` passes the checker of `Arith/FibreCert`, unchanged; `[propext, Classical.choice, Quot.sound]`.
- `HadwigerNelson.FibreCertSound.sum_le_nineteen` — every `φ : (ℤ/19)² → [0, 1]` with `q(φ) ≥ 0` has
  `Σφ ≤ 8864340098471101020193379809808304 / 10^32` (= 88.6434…); the standard three.
- `HadwigerNelson.FibreCertSound.card_le_nineteen` — an independent set of `Cay((ℤ/19)², {a² + b² = 1})` has at most
  that many points; the standard three.
- `HadwigerNelson.FibreCertSound.bound_nineteen_lt_quarter` — `U/(361·L) < 1/4` (`0.24555…`); the standard three.
- `HadwigerNelson.FibreCertSound.card_div_lt_quarter_nineteen` — such a set has `|I|/361 < 1/4`; the standard three.
- `HadwigerNelson.FibreCertSound.model_nineteen` — the hypotheses inhabited together (`φ = 0`; `I = {0}`).
- `Arith/FibreCertFast` (core only): `globalOK_eq_K`, `globalOKKZ_eq`, `globalOKKZ_eq_P`, `p1stepZ_eq`, `p1stepF_eq`,
  `segCheck_eq_Z`, `foldl_O3`, `foldl_O4`, `ktEq_eq`, `eq_flatten_of_pieces`, `fold_p1stepZ_rd_co`, `fold_chunk`,
  `fold_drop_chunk`, `readIter_qj`, `readIter_eq_rdAt`, `readK_add`, `rows_flatten`, `pairCoefs_eq`, `coefFrom_eq`,
  `p1AtF_eq`, `fold_drop_chunkF` and their helpers — each fast form equal to the checker's part for every certificate.
- The 41 check declarations (`cert19_kt0_ok` … `cert19_kt7_ok`, `cert19_p1c0` … `cert19_p1c7`, `cert19_globalP`,
  `cert19_seg0` … `cert19_seg3`, `cert19_psd0` … `cert19_psd18`, `cert19_psdq0`), each `decide +kernel`, and the
  assembly lemmas `ktable_cert19`, `cert19_phase1`, `cert19_global`; the four `rfl` facts `cert19_p`, `_unum`,
  `_scale`, `_nseg`.

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_ikc2_quotes.py` (FS131-IKC2's, run, not edited) on the brief against `main`'s files: **all ten blocks
FOUND** — W2 in `data/fs131/REQUEST-2026-10-13.md`; the six dated lines in `data/fs131/claims-NF2.md`; items 848, 902
and 908 in `plans/FS131-close-inventory.md` (`data/fs131/ikc4/quotes.txt`, exit 0). Its control (`--plant`, one
character of the first block changed) reports that block NOT FOUND and exits 1 (`quotes-control.txt`). No mismatch.
The certificate the brief names, `data/search/2026-10-14/certs/v-p19-phi0-13-qs.json`, has sha256 `f94ed6360c11…`, the
search record's (§ 3.3).

### 1.2 The work, restated beside its plans

| item | restated | plan |
|---|---|---|
| K1 at p = 19 | the reduced certificate re-encoded for the present checker (`FibreCert.certOK` unchanged), cut into modules, each check one `decide +kernel` declaration under the build's 10 GB cap, assembled into `cert19_ok : certOK cert19 = true` with no evaluation | KC13 record § 5.4 (K1); IKC3 record § Stage 2 (the p = 11 pattern: data module, chained check modules, an assembly module) |
| measure first | the K table's declaration (it alone exceeded 12 GiB at FS-66's certificate, KC13 § 3.1), each identity segment and each PSD block, under the present checker | brief § Your work (1) |
| F2, only as needed | (b) the K table as a checked literal; the `2^40` witness scale (converter only); per-block modules well under 100 MB; nothing of (c) phase 1 by orbit range or (d) the scatter by position unless the measurement demands it | IKC3 record § 3.3 (F2's design) and § 3.4 (its price); brief § Your work (2) |
| the bound | `sum_le_nineteen`, `card_le_nineteen` from `sum_le_of_certOK` and `card_le_of_certOK` at `cert19`, and the comparison with `1/4` | brief § Your work (3); KC13 record § 5.2 (K5's comparison) |

### 1.3 The stored statements before any edit

`data/fs131/ikc4/lean/StatementDump.lean` (FS131-IKC3's dumper, copied; only its header comment, paths and namespace
changed) against the tree's built library at `af4eb1ab2`, under the slot, before any edit:
`data/fs131/ikc4/statements-before.txt` — 791 constants of `FibreCert`, `FibreCert3` and `FibreCertSound`, sha256
`62f292bc668f7ea3bba111df15088f51bb0a872ecb74ce1ff196d597bb19f390`, **byte-identical to FS131-IKC3's
`statements-after.txt`**, so the chain of comparisons runs unbroken from the planner's dump (4.9 s, 1.9 GB).

## Stage 2 — SAVED: the measurement, and the decision it forces

### 2.1 The data

`tools/fs131_ikc4_gen.py` (this job's copy of FS131-IKC1's converter; changes: `--scale-bits`, `--split`/`--prefix`
for per-block modules, `--kt-maps` for the K table as literals, `--p1-chunks` for phase 1's checkpoints; the model
and the encoding of every field unchanged) on the reduced certificate, `--nseg 4 --scale-bits 40 --kt-maps 5`: model
**20,274 ops, 1,783 slots, 984 orbits, identity HOLDS, 20 blocks diagonally dominant at `2^40`**, slot width 127
bits (`data/fs131/ikc4/gen/gen19n4.log`). 29 modules, 44.5 MB of text, the largest 2.2 MB: 19 times-1 blocks
(1.3–2.2 MB each), one times-q block, the K table in 8 modules of 5 maps (2.1 MB each), the rest 1.4 MB. Two runs are
byte-identical but for the main module, whose `nseg` differs (`--nseg 1` then `--nseg 4`). Compiled one at a time
(`lean -o` into a scratch farm, `data/fs131/ikc4/farm.sh`): a block module 5.5 s / 0.48 GiB, a K-table module 14 s /
0.49 GiB, the main module 12.9 s / 0.71 GiB (`logs/farm1`, `farm2`).

### 2.2 The table (the laptop; each probe one declaration in its own slot, `lake`-free `lean` on the farm, GNU time)

Peak is the `lean` process's maximum resident set; a cap kill is read from the kernel log (`logs/oom-kills.txt`), its
time from the slot's admission to the kill. "Present" is the checker as it stands (`FibreCert.certOK`'s parts).

| declaration | form | time | peak | verdict |
|---|---|---|---|---|
| the K table alone: `ktEq (ktable cert19) cert19_kt` (all 40 maps) | present (`ktable` computed) | killed at 99 s | **> 12 GiB** (cap) | **does not fit** |
| `globalOK` with the K table read from literals, phase 1 whole (`globalOKKZ`) | literal K table, zero pairs' increments skipped | killed at ≤ 81 s | **> 12 GiB** (cap) | **does not fit** |
| identity segment 0 of 4: `segCheck cert19 0` | present | killed at 67 s | **> 12 GiB** (cap) | **does not fit** |
| identity segment 0 of 1, zero ops left out (`segCheckZ`) | zero ops skipped | killed at 75 s | > 9 GiB (cap) | — |
| identity segments 0, 1, 2, 3 of 4 (`segCheckZ`) | zero ops skipped | 71.5 / 36.4 / 37.4 / 28.4 s | 7.25 / 6.32 / 6.08 / 5.61 GiB | fit |
| one PSD block (`psdCheck cert19_b1`), witness `2^40` | present | 55.6 s | 4.82 GiB | fits |
| two PSD blocks in one file, default options | present | 95.7 s | 5.56 GiB | fits (memory is freed between declarations) |
| K table maps 5–9 against the literal (one piece) | present `ktable` | 28.2 s | 3.37 GiB | fits |
| phase 1, pairs 0–2,080 (`p1stepZ`, 19 blocks) | literal K table | 82.5 s | 6.99 GiB | fits |
| the same with 1 / 4 blocks | | 16.4 / 24.2 s | 3.10 / 3.75 GiB | (0.22 GiB a block) |
| the same, `p1stepF` (no `let` chain), 19 / 1 blocks | | 34.1 / 18.8 s | 5.62 / 2.97 GiB | fits |
| phase 1, the last 2,082 pairs, start read from the stream's beginning (`p1At`) | `p1stepZ` | killed at 78 s | > 12 GiB (cap) | does not fit |
| the same, start placed directly (`p1AtF`: `rdAt`, `coefFrom`) | `p1stepF` | 55.5 s | 6.56 GiB | fits |

### 2.3 The decision

Under the present checker the p = 19 certificate does not check: the K table alone, phase 1 alone and one identity
segment each exceed 12 GiB in one declaration. The PSD blocks fit (4.8 GiB each, 5.6 GiB two to a file). So:

* **the K table as literals** (F2 item (b)) — needed;
* **phase 1 cut into chunks** (the need F2 item (c) answered) — needed, because even with the table read and the zero
  pairs' row increments skipped phase 1 is over 12 GiB: about 2.5 MB of kernel memory a pair, 16,653 pairs. Eight
  chunks of 2,081–2,082 pairs, each at most about 6.6 GiB;
* **the identity's zero ops left out** — needed, and not anticipated by F2: the reduced certificate has 20,274 ops of
  non-zero value but its orbit rows and q-part still generate about 520,000 ops of value zero (984 orbit rows × 361
  shifts, 21 q-monomials × 361 × 22), each of which the present `segCheck` builds and passes by. Left out, four
  segments fit at 5.6–7.3 GiB;
* F2's scatter by position (item (d)) — **not needed**: with the zero ops left out the present scatter fits;
* the `2^40` witness scale — taken (converter only); per-block modules — taken (the largest 2.2 MB).

**None of these changes `certOK`.** Each is done at the proof's level, in a new module `Arith/FibreCertFast`: a second
way to compute one part of the check, proved equal to the checker's part for every certificate (`globalOK_eq_K`,
`globalOKKZ_eq`, `p1stepZ_eq`, `p1stepF_eq`, `segCheck_eq_Z`, `fold_drop_chunk`, `p1AtF_eq`), so that the kernel
evaluates the fast form on `cert19` and the proof rewrites it into `certOK cert19 = true`. The soundness theorems, the
checker, `cert3` and `cert11` are untouched, and K2's proof is not reopened.

## Stage 3 — SAVED: the bound at p = 19

### 3.1 The modules (every one generated but `Arith/FibreCertFast`)

* Data (`tools/fs131_ikc4_gen.py … --nseg 4 --scale-bits 40 --kt-maps 5 --p1-chunks 8`, 37 modules, 49.0 MB, the largest
  2.2 MB): `FibreCert19B0` … `B18`, `Q0` (the blocks), `K0` … `K7` (the K table, 5 maps each), `P1` … `P8` (phase 1's
  orbit rows and bound after each chunk, 0.3–0.6 MB), `FibreCert19` (the rest, `cert19`, the K table's flatten).
* `Arith/FibreCertFast` (core, about 700 lines): the fast forms and their equalities (§ Theorems).
* Checks (`tools/fs131_ikc4_checks.py`, 27 modules chained by imports): `Kt0` … `Kt3` (two K-table pieces each),
  `C0` … `C7` (phase 1's chunks), `Global`, `Seg0` … `Seg3`, `Psd0` … `Psd9` (two blocks each).
* `Arith/FibreCert19Bound`: `cert19_ok` assembled with no evaluation — `ktable cert19 = cert19_kt` from the eight
  pieces (`eq_flatten_of_pieces`); phase 1 = the last chunk's result by eight `fold_drop_chunkF` rewrites; `globalOK`
  through `globalOK_eq_K`, `globalOKKZ_eq`, `globalOKKZ_eq_P`; the segments through `segCheck_eq_Z`; PSD by blocks — then
  the bound from `sum_le_of_certOK`, `card_le_of_certOK`, and `norm_num` for `1/4`.
* Registered in `Proofs.lean` and `ARCHITECTURE.md` (66 rows; `tools/check_architecture.py` PASS, `logs/arch1.txt`).

### 3.2 Each declaration (the build under the slot, `--mem 10 --cpus 4`, `MEMMAX=10G BATCH=8`; time is Lake's per module,
peak the module's `lean` resident set sampled every half second, `logs/build1-rss.txt`)

| module | declarations | time | peak |
|---|---|---|---|
| `Kt0` … `Kt3` | K table, maps 0–39, two pieces each | 46 / 45 / 45 / 42 s | 3.81–3.82 GiB |
| `C0` … `C7` | phase 1, 2,081–2,082 pairs each | 30 / 38 / 39 / 37 / 38 / 40 / 42 / 45 s | 5.36 / 6.40 / 6.29 / 6.27 / 6.18 / 6.47 / 6.58 / 6.61 GiB |
| `Global` | the shape at phase 1's result | 0.9 s | 0.59 GiB |
| `Seg0` … `Seg3` | the identity, four segments | 62 / 34 / 31 / 27 s | 7.28 / 6.33 / 6.11 / 5.64 GiB |
| `Psd0` … `Psd9` | PSD, two blocks each (`Psd9`: block 18 and the q-block) | 80–85 s each, `Psd9` 40 s | 5.56–5.85 GiB, `Psd9` 4.85 GiB |
| data | 37 modules, eight at a time | 0.6–36 s each | 0.47–0.71 GiB |
| `Bound` | `cert19_ok` and the bounds | 4.0 s | — |
| **the whole p = 19 check** | **41 kernel declarations** | **1,422 s (23.7 min)** | **at most 7.28 GiB** |

### 3.3 The builds

* `logs/build1.log` (full: `logs/build1-full.log`): 65 modules rebuilt, every check module green, 0 modules with
  warnings; the batch of `FibreCert19Bound` failed — the copy in `Proofs/` was generated before a fix of the
  generator (`show l = l.drop 0 from rfl` sent the elaborator into evaluating the pair list: maximum recursion depth).
* `logs/build2.log`: `FibreCert19Bound` failed at two `by rw [hpl]; decide` steps that `rw` had already closed
  ("No goals") — written as terms (`Nat.le_trans (by decide) (Nat.le_of_eq hpl.symm)`).
* `logs/build3.log` (full: `logs/build3-full.log`): **OK, 264 of 264 batches, 2 modules rebuilt (`FibreCert19Bound`
  4.0 s, `Proofs` 7.6 s), 0 modules with warnings, 7 m 13 s.**

### 3.4 What the bound says, read against the claim

`sum_le_nineteen`: FS-66's L4 at `p = 19` (`data/fs66/b1/SOUNDNESS.md` § 0), with the reduced certificate's
`U = 88.6434…` in place of FS-66's 77.5117…; `card_le_nineteen` and `card_div_lt_quarter_nineteen`: at level one,
an independent set of `Cay((ℤ/19)², S)` has density below `1/4` (`0.2455…`, margin `1.607` points of `361/4 = 90.25`,
the search record's). The tower to every level is K4's (Lemma P), not this module's.

## Stage 4 — SAVED: the new parts, each refusing a planted fault

The parts are proof-level forms, not changes to `certOK`; each new check refuses one corrupted entry, the kernel
*proving* the check `= false` (`data/fs131/ikc4/plants/`, logs `logs/plants1` … `plants3`). Each twin is the library
declaration named in the file.

| part | plant | time | peak | verdict |
|---|---|---|---|---|
| K table vs literal, first entry compared | slot 5 of map 5, block 0, +1 in the literal (`PlantKt`) | 0.5 s | 0.49 GiB | `= false` proved |
| K table vs literal, last entry compared | the last block of map 39, `N` + 1 (`PlantKtLast`) | 22.3 s | 3.39 GiB | `= false` proved |
| phase-1 chunk, rows | first orbit row of the checkpoint `+1` (`PlantChunk`) | 1.1 s | 0.63 GiB | `= false` proved |
| phase-1 chunk, bound (its last conjunct) | bound `+1` (`PlantChunkBound`) | 36.7 s | 5.35 GiB | `= false` proved |
| the shape at phase 1's result | first / last orbit row `+1` (`PlantGlobal`, `PlantGlobalLast`) | 0.6 / 0.5 s | 0.5 GiB | `= false` proved |
| identity without zero ops | `U_num − 1` (`PlantSeg`, segment 0) | 73.6 s | 7.24 GiB | `= false` proved |
| PSD at `2^40` | `M[0][0]` doubled in block 1 (`PlantPsd`) | 7.8 s | 1.94 GiB | `= false` proved |

The short times are `&&` stopping at the corrupted entry; the last-entry plants force the whole comparison.
`PlantSeg` first ran with the default heartbeat limit and stopped there after 73 s (`(deterministic) timeout at
isDefEq`), the library's `Seg0` (62 s) did not: rerun with the limit lifted, refused. **The proofs' reopened part:
none** — `certOK`, `FibreCertSound` and K2 are untouched (§ 5), so nothing was re-proved; the first implementer's
counterexample controls are about `certOK`'s definition, which is unchanged.
