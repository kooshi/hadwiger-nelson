# FS131-IKC3 — the class-ratio certificates: p = 11 into the library, p = 19 in a form that fits

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-IKC3-certs-p11-p19.md` (on `main`). Branch `fs131-wc16`, cut
from `fs131-wc15` at `1e0990dad`, worktree `.claude/worktrees/fs131-wnf`. Working files: `data/fs131/ikc3/`. Commits by
explicit path, not pushed (the brief: the remote is unreachable).*

## Theorems this phase proved

Each [kernel], printed from the built tree (`data/fs131/ikc3/axioms.txt`):

- `HadwigerNelson.FibreCert.cert11_ok : certOK cert11 = true` (`Arith/FibreCert11Bound`) — FS-66's `p = 11` certificate
  passes the strengthened checker; `[propext, Quot.sound]`. Assembled from `cert11_seg0` … `cert11_seg7`,
  `cert11_global`, `cert11_psd` (`Arith/FibreCert11Seg0` … `Psd`, each `decide +kernel`, each `[propext]`).
- `HadwigerNelson.FibreCertSound.sum_le_eleven` — every `φ : (ℤ/11)² → [0, 1]` with `q(φ) ≥ 0` has
  `Σφ ≤ 28204320001863099628721379861820 / 10^30` (FS-66's L4 at `p = 11`); the standard three.
- `HadwigerNelson.FibreCertSound.card_le_eleven` — an independent set of `Cay((ℤ/11)², S)` has at most that many points;
  the standard three.
- `HadwigerNelson.FibreCertSound.model_eleven` — the hypotheses of both inhabited together (`φ = 0`; `I = {0}`); the
  standard three.
- `cert11_p`, `cert11_unum`, `cert11_scale`, `cert11_nseg` — the certificate's stored numbers, by `rfl`; no axioms.
- In a probe file, not the library (`data/fs131/ikc3/f2/KtabSound.lean`): `FS131IKC3KT.ktable_eq_of_chk` — F2's K-table
  pieces passing, with the lengths, give `ktable C = kt`; `[propext, Quot.sound]` (`logs/ktabsound-axioms.txt`).

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_ikc2_quotes.py` (FS131-IKC2's, run, not edited) reads every `>` block of the brief with its `— source:` line
and searches for the block's text, whitespace-normalised, in the named file on `main`. All ten blocks FOUND: W2 in
`data/fs131/REQUEST-2026-10-13.md`; the six dated lines in `data/fs131/claims-NF2.md`; items 848, 869 and 886 in
`plans/FS131-close-inventory.md` (`data/fs131/ikc3/quotes.txt`). Its control (`--plant`, one character of the first block
changed) reports that block NOT FOUND and exits 1 (`quotes-control.txt`). No mismatch.

### 1.2 The work, restated beside its plans

| item | restated | plan |
|---|---|---|
| K1 at p = 11 | FS-66's `cert-p11.json` re-encoded by `tools/fs131_ikc1_gen.py --nseg 8` (FS131-IKC1's converter, run, not edited) into a data module `Arith/FibreCert11`; one check module per declaration (`globalOK`, eight `segCheck`s, `psdAll`), each `decide +kernel`; built under the slot and measured per declaration; `cert11_ok : certOK cert11 = true` assembled from them with no evaluation; the bound at p = 11 from `sum_le_of_certOK` and `card_le_of_certOK` | KC13 record § 5.4; IKC1 record § Stage 6 (nseg = 4 measured 7.1–9.5 GB a segment, a base of about 4.5 GB); IKC2 record § What is left |
| F2 at p = 19 | a checker form in which no declaration repeats phase 1 or reads another's ops: the K table as a checked literal, phase 1 cut, the scatter cut so that each op is processed once, PSD one block per declaration; every change to `certOK` listed beside the proof step that needs it; K2's computation half (`sum_shadow`, `seg_shadow`, `opSum_eq_zero`) re-proved for the changed checker; then the p = 19 modules, `cert19_ok`, the bound at p = 19 | KC13 record § 3.2 (extrapolated: about 30 min of kernel CPU in about 40 declarations of at most 10 GB); IKC2 record § What is left (F2 reopens K2's computation half) |

### 1.3 The stored statements before any edit

`data/fs131/ikc3/lean/StatementDump.lean` (FS131-IKC2's dumper, copied; only its header comment and namespace changed)
against the tree's built library at `1e0990dad`, under the slot, before any edit:
`data/fs131/ikc3/statements-before.txt` — 791 constants (217 in `FibreCert`, 3 in `FibreCert3`, 571 in
`FibreCertSound`), sha256 `62f292bc668f7ea3bba111df15088f51bb0a872ecb74ce1ff196d597bb19f390`, **byte-identical to
FS131-IKC2's `statements-after.txt`**, so the chain of comparisons runs from the planner's dump through FS131-IKC1's and
FS131-IKC2's to this one (6.8 s, 1.9 GB).

## Stage 2 — SAVED: K1, the `p = 11` certificate in the library

### 2.1 The modules

* `Arith/FibreCert11` — data only: `tools/fs131_ikc1_gen.py data/fs66/b1/cert-p11.json … --nseg 8 --module
  Proofs.HadwigerNelson.Arith.FibreCert --doc data/fs131/ikc3/gen/cert11.doc` (the converter run, not edited; its model:
  53,813 ops, 3,760 slots, 218 orbits, identity HOLDS, 22 blocks diagonally dominant; slot width 120 bits, `ds = 3`).
  5.9 MB of text (sha256 `bb7ed037…`; the input's `683236677e0d…`). The converter's summary is
  `data/fs131/ikc3/gen/FibreCert11.summary.json` (moved out of `Proofs/`).
* `Arith/FibreCert11Seg0` … `Seg7`, `Global`, `Psd` — one `decide +kernel` declaration each. **They import each other in a
  chain** (`Seg0` the data, `Seg1` `Seg0`, …, `Psd` `Global`): `scripts/build_order.py` cuts batches from one level of
  the import graph, so ten modules importing only the data would sit on one level and be compiled side by side in one
  batch under the 10 GB cap. Chained, each heavy module is the only module of its batch that needs compiling (the
  batch plan was read before the build: `python3 scripts/build_order.py 8`).
* `Arith/FibreCert11Bound` — `cert11_ok` assembled with no evaluation (`change` to `certOK`'s and `segAll`'s bodies,
  `cert11_nseg`, a `match` over the eight segments, the ten theorems rewritten in); `sum_le_eleven`, `card_le_eleven`
  from `sum_le_of_certOK` and `card_le_of_certOK` at `cert11` (`V cert11.p` is `V 11` by unfolding `cert11.p`;
  `NeZero cert11.p` by `cert11_p`); `model_eleven`.
* Registered in `Proofs.lean` and `ARCHITECTURE.md` (`tools/check_architecture.py`: PASS, `logs/arch1.txt`).

### 2.2 The measurement (the laptop; the build under the slot, `--mem 10 --cpus 4`, `MEMMAX=10G BATCH=8`)

Time is Lake's per-module time in the build log (`logs/build1-full.log`: elaboration and kernel together, one module per
declaration). Peak memory is the module's `lean` process's resident set, sampled every half second during the build by
`data/fs131/ikc3/rss_sampler.sh` (`ps`, read-only; `logs/build1-rss.txt`, 834 samples):

| declaration | module | time | peak RSS |
|---|---|---|---|
| (data) `cert11` | `FibreCert11` | 29 s | 0.58 GiB |
| `cert11_seg0 : segCheck cert11 0 = true` | `FibreCert11Seg0` | 56 s | 6.82 GiB |
| `cert11_seg1` | `Seg1` | 36 s | 5.82 GiB |
| `cert11_seg2` | `Seg2` | 39 s | 5.90 GiB |
| `cert11_seg3` | `Seg3` | 38 s | 5.88 GiB |
| `cert11_seg4` | `Seg4` | 37 s | 5.85 GiB |
| `cert11_seg5` | `Seg5` | 37 s | 5.97 GiB |
| `cert11_seg6` | `Seg6` | 37 s | 6.02 GiB |
| `cert11_seg7` | `Seg7` | 27 s | 5.02 GiB |
| `cert11_global : globalOK cert11 = true` | `FibreCert11Global` | 43 s | 5.95 GiB |
| `cert11_psd : psdAll cert11 = true` | `FibreCert11Psd` | 44 s | 6.26 GiB |
| `cert11_ok`, the bounds, `model_eleven` | `FibreCert11Bound` | 1.3 s | 1.85 GiB |
| **the whole p = 11 check** | **ten declarations** | **394 s** | **at most 6.82 GiB** |

So nseg = 8 fits the build's 10 GB batch with about 3 GB to spare per declaration; `BATCH=1` was not needed. FS131-IKC1's
extrapolation ("about 7 GB each") holds. The segment base (generating and skipping all 53,813 ops) is about 4.5–5 GB,
as FS131-IKC1 measured; halving the segments again would save little.

### 2.3 The builds

* `logs/build1.log` (the gate's copy `logs/build1-full.log`): every heavy module built, 0 modules with warnings; the batch
  of `FibreCert11Bound` failed at `model_eleven` (`simp [unitCircle]` left `¬(0 : ZMod 11) = 1`), retried once by the
  script, failed again; fixed (`simp only […]; decide`), elaborated alone (`logs/bound-iter1.log`, exit 0).
* `logs/build2.log` (`logs/build2-full.log`): **OK, 251 of 251 batches, 2 modules rebuilt (`FibreCert11Bound` 1.3 s,
  `Proofs`), 0 modules with warnings**, 6 m 53 s.

### 2.4 No conclusion weakened; the axioms

* `StatementDump.lean` on the built tree after the build (`statements-after.txt`) is **byte-identical** to § 1.3's
  dump (791 constants): `FibreCert`, `FibreCert3` and `FibreCertSound` are untouched, `certOK`'s definition unchanged.
  `tools/fs131_ikc1_statements.py` (FS131-IKC1's, run, not edited): PASS (`statements-compare.txt`); its control (one
  character planted in the after-dump's type of `sum_le_of_certOK`) exits 1 naming it (`statements-compare-control.txt`).
* `data/fs131/ikc3/lean/Axioms.lean` (FS131-IKC2's printer, its module list extended to this job's twelve modules) →
  `axioms.txt`: 224 public records and 418 private theorems, every one a subset of the standard three; the planted
  record `FS131IKC3Axioms.planted` reads `[sorryAx]`. `tools/fs131_ikc2_axioms.py` (run, not edited): PASS
  (`axioms-read.txt`); its control (`sorryAx` planted into the first record) exits 1 naming it (`axioms-control.txt`).
  The new records: `cert11` `[]`; `cert11_seg0` … `seg7`, `cert11_global`, `cert11_psd` `[propext]`; `cert11_ok`
  `[propext, Quot.sound]`; `sum_le_eleven`, `card_le_eleven`, `model_eleven` the standard three; the four `rfl` facts `[]`.
  `native_decide`: nowhere in these files (`grep`).

## Stage 3 — SAVED: F2 at p = 19 — the parts measured, the design, and what the data weighs

`certOK`'s definition is **not changed** in this job (§ 2.4: `FibreCert` byte-identical). F2's new checker parts are
written and run as **probes** under `data/fs131/ikc3/` (each imports the built library and adds definitions beside it),
because any change to `Cert` or `certOK` regenerates `cert3` and `cert11` and reopens K2 at once, and that is one job —
§ 3.4. Every probe ran under the slot, one at a time, `lake env lean` with `/usr/bin/time -v`
(`data/fs131/ikc3/run_probes.sh`; logs `data/fs131/ikc3/logs/probes1` … `probes5`). Time and peak RSS are the whole
process: Lean's start (about 0.75 s, 0.84 GB, the tiny block `B2`), the file's literal parse, and the kernel.

### 3.1 The parts measured

| part (F2 item, KC13 record § 3.2) | probe | p | time | peak RSS | verdict |
|---|---|---|---|---|---|
| PSD, one 183 × 183 block, witness scale `2^120` (item 4) | `p19/psd/B1.lean` (2.7 MB) | 19 | 62.4 s | 5.93 GB | `psdCheck blk = true` |
| the same, block 35 | `B35.lean` | 19 | 62.6 s | 5.91 GB | true |
| the same block, witness scale `2^40` | `B1s40.lean` (1.3 MB) | 19 | 44.9 s | 5.27 GB | true |
| a 2 × 2 times-q block | `B2.lean` | 19 | 0.75 s | 0.84 GB | true |
| **control**: `M[0][0]` doubled | `B1digit.lean` | 19 | 25.6 s | 2.21 GB | `= false` proved |
| **control**: `R[1][2] = R[2][1]` moved by `2^200` | `B1entry.lean` | 19 | 27.1 s | 2.25 GB | `= false` proved |
| K table as a literal, maps 0–4 of 40 against `ktable` (item 1) | `f2/KT19.lean` (17.4 MB) | 19 | 113.6 s | 3.61 GB | `ktabChk mini kt 5 0 = true` |
| **control**: one slot of map 0 moved by one | `KT19bad.lean` | 19 | 104.5 s | 0.84 GB | `= false` proved |
| the same check, maps 5–9 of 24 | `KT11.lean` (1.8 MB) | 11 | 9.9 s | 1.05 GB | true |
| **control**: one slot of map 5 moved by one | `KT11bad.lean` | 11 | 5.9 s | 0.84 GB | `= false` proved |
| phase 1, orbits [0, 55) of 218 (item 2) | `f2/p1/P1R0.lean` | 11 | 21.9 s | 3.41 GB | `p1Chk … = true` |
| orbits [55, 110) | `P1R1.lean` | 11 | 24.4 s | 3.66 GB | true |
| orbits [110, 165) | `P1R2.lean` | 11 | 25.9 s | 3.72 GB | true |
| orbits [165, 2^14) | `P1R3.lean` | 11 | 22.9 s | 3.48 GB | true |
| **control**: orbit 60's row moved by one | `P1R1bad.lean` | 11 | 22.5 s | 3.38 GB | `= false` proved |
| cross-check of § 2.2's sampler: `cert11_seg0` | `FibreCert11Seg0.lean` | 11 | 52.7 s | 7.14 GB (6.81 GiB) | sampler: 6.82 GiB |

Readings:
* **PSD per block needs no new checker part**: `psdAll` is `(blocks1 ++ blocksq).all psdCheck`, so one declaration per
  block, assembled by `List.all_eq_true`, is the cut. At p = 19 that is 19 large blocks at 45–62 s and 5.3–5.9 GB each
  (about 15–20 min of kernel CPU), against the planner's 15–25 s each. The parse is in the price: the controls, which
  stop at row 0, still take 25–27 s.
* **A witness scale of `2^40` instead of `2^120` is a converter-only change**: `psdCheck` reads `sb`, `wm`, `wB` from the
  block, and L1's proof reads only the check's bounds (FS131-IKC2 § Stage 2). The converter's model still finds block 1
  diagonally dominant at `2^40` (`tools/fs131_ikc3_psdprobe.py` exits on a failing block). It halves the witness (2.7 →
  1.3 MB of text per block) and the time (62 → 45 s). At p = 11 the model holds at `2^30` too (block 1). Every block must
  be tried before it is adopted.
* **The K table check** (`ktabChk`, defined in the probe: maps `[r·k, r·k + k)` of `ktable C` against the literal, entry by
  entry, by `Nat.beq`) costs about 10 s and 2.8 GB for five maps at p = 19 once the literal is parsed; the parse of the
  17.4 MB literal is about 100 s (the control stops at map 0 and still takes 104 s). Eight pieces of five maps: about
  80 s of kernel time. In the library the parse is paid once, in the data module.
* **Phase 1 by orbit range** (`p1stepR`: a pair whose orbit lies in `[lo, hi)` is exactly the library's `p1step`, any
  other only advances the stream and the coefficients; `p1Chk`: the in-range verdict, the bound share, the in-range rows
  against `orows`). The four shares sum to phase 1's bound exactly and the compiled evaluation passes all four pieces
  (`f2/p1/P1Eval.lean`, `logs/p1eval.log`). In the kernel each piece is 22–26 s and 3.4–3.7 GB at p = 11, **including the
  K table, which each piece recomputes** (14.7 s and 2.5 GB alone, KC13 record § 3.1); with the K table as a literal
  (item 1) a piece pays the stream and coefficient walk over every pair plus its own pairs. At p = 19 that is not measured
  (it needs the p = 19 data compiled, § 3.3).

### 3.2 The data at p = 19 — a finding

The converter's output at p = 19 (`tools/fs131_ikc1_gen.py data/fs66/b1/cert-p19.json … --nseg 1`, 6 min 20 s, 0.97 GB;
model: 602,989 ops, 52,370 slots, 16,653 pairs in 984 orbits, identity HOLDS, 38 blocks diagonally dominant, slot width
131 bits) is **96.0 MB of text** in one `def`: the blocks 51.3 MB (19 PSD witnesses of 183 rows of 54.5 kbit), `orows`
23.3 MB (984 × 2 rows of 361 × 131 bits), `keys` 14.1 MB (52,370 bag keys of `3n + 1 = 1,084` bits), the op stream
5.1 MB, the rows 2.1 MB. F2's K table adds 17.4 MB. Elaborated as one probe file it **stopped at the elaborator's
default 200,000 heartbeats after 3 min 14 s (1.06 GB), in the fourth of the 19 large blocks**
(`logs/probes3/Cert19probe.log`, `isDefEq` timeout at line 2083); the run with `maxHeartbeats 0` is § 3.5's.
So the p = 19 data must be cut into many definitions (one per block, one per long field), each in its own module so they
elaborate in parallel, and about 110 MB of generated text in git is the coordinator's decision. What reduces it:
the witness at `2^40` (about −25 MB, converter only); denser slot keys (the sorted point codes of a monomial, 4 × 9 bits,
instead of `Σ 8^x`: −13.6 MB, but `opGood`'s key check and `dec_bag` change, so K2's computation half reopens there).

### 3.3 F2 as designed here

`certOK C` becomes a conjunction of indexed families, each element one declaration:
`shapeOK C && kAll C && p1All C && segAll C && psdAll C`, each `…All C = (List.range n).all (piece C)`.

| item | the check | its soundness step | what of K2 it reopens | lines |
|---|---|---|---|---|
| (a) PSD | unchanged; one declaration per block | none (assembly) | nothing | 0 |
| (b) K table | new field `ktab`; `ktabChk C r` as in the probe; `phase1` folds `p1step C C.ktab km` | the pieces and `ktab.length = (gList p).length` give `C.ktab = ktable C` (entry equality from `Nat.beq`, `rowsEq` by induction) | L3 reads `ktable C` through `ktable_getD` and `Inv1_step`: one rewrite | 40–60 |
| (c) phase 1 | `p1stepR`/`p1Chk` as in the probe, cuts `lo_0 = 0 < … < lo_last`, the last range to `2^k1` (so a pair naming no orbit is in range somewhere and fails `bmem` as now); new fields: the cuts, the shares; `shapeOK`: `Σ shares < 2^w` | a simulation lemma by induction over the pairs: a pair's orbit, verdict, row increment and share depend on the pair and the shared stream state only (`bmod` leaves `A0`, `A1` and the bucket shape alone), so the full fold's verdict is the conjunction of the pieces', its bound their sum, its rows in each range the piece's — the three facts `globalOK` gave L3 (verdict, bound, `orowsOK`) | none of L3's proof; `globalOK_of`'s use | 250–350 |
| (d) the scatter | each segment's own stream lists its ops **by position in `opList`**, strictly increasing, with slot and witness; the op at a position generated directly (`opAt`: O1, O2 by offset; O3 `(ρ, t)` from `orows` by a cursor or a tree; O4 `(μ, x, j)`; O5 `(row, j)` from the rows); `segOf[pos] = k` read from a packed tree literal (603k × 5 bits); the entry count equal to `cnt[k]`; `shapeOK`: `Σ cnt = N`. Leaves balanced as now | `opSum (opList …) = Σ_{pos < N} v(opAt pos)·Y(…)` (one generic flatMap-indexing lemma per family); the cover (strictly increasing ⇒ distinct; `segOf` ⇒ disjoint; counts ⇒ the union is `[0, N)`); `Inv` as now with the op from `opAt` and the slot from the entry | `sum_shadow`, `seg_shadow`, `covered`, `rdNext`, `contrib`, `shadow`, `opSum_eq_zero`; `Inv_step`'s key and witness half reused as is | 450–650 |
| assembly | `certOK`'s families; `cert3`, `cert11` regenerated in the new form | `opSum_eq_zero` from (b)–(d) | — | 50 |

The alternative to (d), checkpointed source ranges (one segment over all slots, leaves in a tree, the fold cut by the
leaf state as a literal every 40–50k ops), was rejected on data: 14 checkpoints × 1.7 MB of leaf state is about 48 MB of
text more. A tree is still needed in (d) for random access to `orows` and the rows (or a cursor, which the sorted
positions allow).

### 3.4 F2's price, re-made from what was measured

* **Kernel at p = 19**: PSD 19 × 45–62 s (15–20 min; 10–14 min at `2^40`); the K table about 80 s in 8 pieces; phase 1
  about 150 s of processing (planner, extrapolated) plus each piece's walk over all 16,653 pairs; the scatter about 20 min
  (planner, extrapolated, not run); the data modules' elaboration (§ 3.5). **About 40–50 minutes of kernel CPU** in about
  45–60 declarations, each under about 7 GB where measured — against the planner's 30 minutes, the difference PSD's.
* **Lines**: checker about 300 (b–d), converter about 350 (a copy of `tools/fs131_ikc1_gen.py` emitting the new fields
  and per-definition data modules), proof 800–1,100 (the table), and `cert3`/`cert11` regenerated. A checker job plus a
  proof job, as FS131-IKC2 said; F2's checker parts (b) and (c) are written and refused their planted faults here, (d)
  is designed only.

### 3.5 The p = 19 data module with unlimited heartbeats

See § Stage 4.

## Stage 4 — SAVED: the p = 19 data elaborated whole, the K-table check proved sound in a probe, the smaller witness checked

* **The p = 19 data as one `def`, with `maxHeartbeats 0` and `maxRecDepth 400000`** (`p19/Cert19probeH.lean`, the
  converter's output with those two options, `logs/probes5/`): elaborates in **10 min 36 s at 1.51 GB**. So the 96 MB
  of literals parse at about 0.15 MB/s in one process; cut into per-block and per-field definitions in about ten modules
  they would elaborate in parallel in about a minute each. The default heartbeat limit is the only thing that stopped
  § 3.2's run.
* **The K-table check is sound** (F2 item (b)'s soundness step, written ahead of the wiring): `ktable_eq_of_chk` in
  `data/fs131/ikc3/f2/KtabSound.lean` (core Lean, about 50 lines with `rowsEq_eq`, `entEq_eq`): if
  `(ktable C).length = kt.length`, `kt.length ≤ R·k` and `ktabChk C kt k r = true` for every `r < R`, then
  `ktable C = kt`. `[propext, Quot.sound]`, printed with a planted `sorry` record reading `[sorryAx]`
  (`logs/ktabsound-axioms.txt`).
* **The `2^40` witness holds at every block** in the converter's model: all 22 blocks at p = 11 and all 38 at p = 19
  stay diagonally dominant (`data/fs131/ikc3/f2/witness_scale.py`, imports the converter's own `mp_cholesky_int` and
  `check_dd`; `logs/witness11.log`, `logs/witness19.log`, `FAILS 0`; its failure path is the converter's model, whose
  refusal of a non-dominant block is the `SystemExit` exercised by `tools/fs131_ikc3_psdprobe.py`). The kernel check of
  one such block passed (§ 3.1, `B1s40`). Adopting it is a converter option, no proof change.
* **The environment linters**: `lake lint --no-build -- --no-build --trace` under the slot: `-- Linting passed for
  Proofs.`, exit 0 (`logs/lint.log`).
* **Not run** (the landing's): the axiom audit, the vacuity scan, the assumptions step and the doubled-names scan over the
  whole library. For the vacuity scan's reading: `sum_le_eleven`'s and `card_le_eleven`'s hypotheses are inhabited by
  `model_eleven` (`φ = 0`; `I = {0}`, a non-empty independent set). Their only structure is `cert11`, a closed term
  whose acceptance is `cert11_ok`.

### Slips, my own

* A waiter on build 1 was armed on `==> build:`, which `build.sh` prints as its first line, so it fired at once (the
  documented failure, `RUNNING.md` § Make the gate fail). Seen in its output at once; nothing was acted on; the waiters
  after it were armed on the exit file, each checked absent before arming.

## Drafts for the front page

### `scripts/Axioms.lean`, CLEAN (for the landing; a block after FS131-IKC2's)

```
-- FS131-IKC3 block: `Arith/FibreCert11*` — 17 records: FS-66's p = 11 certificate accepted, the bound at p = 11
#print axioms HadwigerNelson.FibreCert.cert11_seg0
#print axioms HadwigerNelson.FibreCert.cert11_seg1
#print axioms HadwigerNelson.FibreCert.cert11_seg2
#print axioms HadwigerNelson.FibreCert.cert11_seg3
#print axioms HadwigerNelson.FibreCert.cert11_seg4
#print axioms HadwigerNelson.FibreCert.cert11_seg5
#print axioms HadwigerNelson.FibreCert.cert11_seg6
#print axioms HadwigerNelson.FibreCert.cert11_seg7
#print axioms HadwigerNelson.FibreCert.cert11_global
#print axioms HadwigerNelson.FibreCert.cert11_psd
#print axioms HadwigerNelson.FibreCert.cert11_p
#print axioms HadwigerNelson.FibreCert.cert11_unum
#print axioms HadwigerNelson.FibreCert.cert11_scale
#print axioms HadwigerNelson.FibreCert.cert11_nseg
#print axioms HadwigerNelson.FibreCert.cert11_ok
#print axioms HadwigerNelson.FibreCertSound.sum_le_eleven
#print axioms HadwigerNelson.FibreCertSound.card_le_eleven
#print axioms HadwigerNelson.FibreCertSound.model_eleven
-- FS131-IKC3 block end
```
(18 lines; each a subset of the standard three in the built tree, § 2.4.)

### `data/fs131/claims-NF2.md` § Dated lines (to follow the last)

- 2026-10-14 — **FS-66's p = 11 certificate is accepted in the library, and the class-ratio bound at p = 11 is a kernel
  theorem** (FS131-IKC3): `FibreCert.cert11_ok : certOK cert11 = true` from ten `decide +kernel` declarations (eight
  identity segments, the shape, positive definiteness), each at most 6.82 GiB and 56 s, 394 s in all;
  `FibreCertSound.sum_le_eleven` (`Σφ ≤ U/L = 28.2043…` for `φ : (ℤ/11)² → [0,1]` with `q(φ) ≥ 0`) and
  `card_le_eleven`, on the standard three. `certOK`'s definition and the soundness theorems' statements unchanged.
- 2026-10-14 — **F2 at p = 19 is designed and three of its parts probed; not built** (FS131-IKC3 § Stage 3): PSD per block
  (no checker change; 45–62 s and 5.3–5.9 GB a block), the K table as a checked literal (10 s and 2.8 GB per five maps
  after a 100 s parse; its soundness lemma proved in a probe), phase 1 by orbit range (four pieces at p = 11, each
  22–26 s and 3.7 GB, shares summing to phase 1's bound), each refusing a planted fault in the kernel. The p = 19 data is
  96 MB of text (17 MB more with the K table) and elaborates in 10 min 36 s only with the heartbeat limit lifted. F2 is
  re-priced at about 40–50 minutes of kernel CPU and 800–1,100 proof lines; the scatter by position is designed, not
  written.

### `LEAN.md` § Building (after the bullet on the laptop)

- **Heavy generated modules that import only their data sit on one level of the import graph, and `build.sh` cuts its
  batches from one level**: ten certificate checks of 5–7 GB importing one data module would be compiled side by side
  under one cap. Chained by imports (each check module imports the previous), each is the only module of its batch that
  needs compiling, and the build stays under `MEMMAX=10G` at `BATCH=8` (`Arith/FibreCert11Seg0` … `Psd`; read the plan
  with `python3 scripts/build_order.py 8` first) (FS131-IKC3).
- A module's peak resident set during the build can be read by sampling `ps -C lean -o pid=,rss=,args=` every half
  second for its file name (`data/fs131/ikc3/rss_sampler.sh`): 6.82 GiB sampled against 6.81 GiB from `/usr/bin/time -v`
  on the same module (FS131-IKC3).

### `LEAN.md` § The kernel's cost model (after the last bullet)

- **One `def` holding about 96 MB of hex literals exceeds the elaborator's default `maxHeartbeats` (200,000)**: it
  stopped after 3 min 14 s, and with the limit lifted (and `maxRecDepth 400000`) elaborated in 10 min 36 s at 1.51 GB,
  about 0.15 MB/s. A 17.4 MB file of 1,520 literals of 47 kbit parses in about 100 s. Cut certificate data into a
  definition per block or field, in modules that elaborate in parallel (FS131-IKC3, p = 19).
- **A PSD witness's scale is a converter choice the proof does not see** (`psdCheck` reads `sb`, `wm`, `wB` from the
  block): FS-66's blocks stay diagonally dominant at `2^40` as at `2^120` (22 at p = 11, 38 at p = 19), and a 183 × 183
  block's check went from 62 s and 5.9 GB to 45 s and 5.3 GB, its text from 2.7 to 1.3 MB (FS131-IKC3).
