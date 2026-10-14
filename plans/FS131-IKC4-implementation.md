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
