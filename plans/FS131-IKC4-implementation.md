# FS131-IKC4 — the class-ratio certificates: the bound at p = 19 from the reduced certificate

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-IKC4-cert-p19.md` (on `main`). Branch `fs131-wc17`, cut
from `fs131-wc16` at `af4eb1ab2`, worktree `.claude/worktrees/fs131-wnf`. Working files: `data/fs131/ikc4/`. Commits by
explicit path, not pushed (the brief: the remote is unreachable).*

## Theorems this phase proved

(filled at the stage that proves them)

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
