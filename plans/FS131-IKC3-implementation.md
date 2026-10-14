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
