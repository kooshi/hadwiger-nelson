# FS131-IKC3 — the class-ratio certificates: p = 11 into the library, p = 19 in a form that fits

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-IKC3-certs-p11-p19.md` (on `main`). Branch `fs131-wc16`, cut
from `fs131-wc15` at `1e0990dad`, worktree `.claude/worktrees/fs131-wnf`. Working files: `data/fs131/ikc3/`. Commits by
explicit path, not pushed (the brief: the remote is unreachable).*

## Theorems this phase proved

(filled at each saved stage)

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
