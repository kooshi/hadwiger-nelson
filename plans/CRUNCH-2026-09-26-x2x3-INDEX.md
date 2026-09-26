# The 2026-09-26 ×2×3 crunch and the post-crunch jobs — index and wiring (C1, the consolidation's bookkeeper)

*Written by consolidation job C1 (brief: `data/consolidation-2026-09-26/briefs/C1-rescue-and-wiring.md`, with `STANDING-RULES.md` beside it;
its template is J30's brief and `plans/CRUNCH-2026-09-25-INDEX.md`). Two jobs: that nothing from the ×2×3 crunch and the night before it is lost
(stage 1), and that everything they produced can be found from the older files it bears on (stages 2–3).*

**This file records; it does not judge.** Grades and verification statuses are copied from the records and reports that state them; where two
disagree, both are listed with addresses. **It holds results**, so a future blind verifier is fenced from it; the pointer blocks this job writes
into stubs and plans carry addresses only.

## Stage 1 — SAVED (nothing lost)

### 1.1 Git state (read 2026-09-26, about 08:10)

| item | state | disposition |
|---|---|---|
| branch | `main`, level with `origin/main` (no unpushed commits at 08:10; `git log origin/main..main` empty) | — |
| tracked changes | none | — |
| `data/m2/j23b/signatures.txt` (18,217 bytes, 2026-09-25 18:37) | untracked since J23b (M2's close) | **committed by this stage.** It is J23b's working dump of the signatures of 88 declarations in M2's ten Lean files (`Chain`, `Bridge`, `NoParam`, `RealClosed`, `Stripe`, `Transcendental`, `UnitRing`, three `Instances/` files), each headed `### <file>:<line>`, made while drafting M2's ledger rows (`plans/M2-kernel-lane.md` §R-close; its siblings `decls.py`, `decls.json` are committed). Plainly a finished job's product; the open item for it is `plans/CRUNCH-2026-09-25-post-close-inventory.md` row 23. Regenerable only approximately (the Lean files have changed since), so it is kept rather than declared regenerable. |

### 1.2 The `/tmp` survey

`/tmp` is RAM here. Everything under `/tmp/claude-1000/` that could hold work was swept; `data/consolidation-2026-09-26/c1/sweep.py` classifies
by exact content (git blob at `HEAD`, in history or in the working tree; identical bytes in `~/source/library` or `~/source/lean-dir-rescue`;
J30's classification where the file has not changed since 2026-09-25 17:00; a successor holding ≥ 80 % of its lines in one tracked file), and
`data/consolidation-2026-09-26/c1/rescue.py` assigns the final class and copies. **The manifest, one line per file with where it is now:
`data/consolidation-2026-09-26/c1/manifest.tsv`** (2,594 files).

Swept: the session scratch directory (skipping `owner-*` and `locks`, the owner's; **including J30's own `j30/`, which J30 did not sweep**), the
loose files and `j24/` in `/tmp/claude-1000/`, and the session's `tasks/` directory (the owner session's background-shell outputs; its symlinks
point at agent transcripts under `~/.claude/`, on disk, and were skipped). Not swept: `/tmp/claude-1000/bash-edit-diff/` (the harness's own git
snapshots); the seven other session directories under `/tmp/claude-1000/-home-kooshi-source-lean-dir/` (all empty).

| class | files | MB | where | note |
|---|---|---|---|---|
| in the repository | 1,322 | 132.4 | identical blob at `HEAD` (1,170, of them 64 shell outputs), in history (22), or a successor (130, of them 43 shell outputs) | the matching path is in the manifest |
| already on disk | 368 | 1,799.3 | `~/source/library` or `~/source/lean-dir-rescue` (J30's disk rescues) | identical bytes |
| J30's classes, unchanged | 441 | 27.7 | left | 160 paper texts, 281 junk by type (J30's §1.4) |
| paper texts, PDF held | 40 | 2.7 | left | regenerable: `pdftotext` of the library PDF named in the manifest |
| **rescued into the repository** | **266** | **2.2** | `data/consolidation-2026-09-26/rescued/{scratch,tmp}/<same path>` | scripts, gate outputs, drafts and logs of the crunch's and the night's jobs (below); agent-id-shaped tokens checked on copy (none) |
| **rescued to disk: paper material not in the library** | 40 | 3.7 | `~/source/lean-dir-rescue/consolidation-2026-09-26/papers/` | the arXiv source of 2207.14179 (`[AmbrusEtAl2023]`), v1–v3, tarred and extracted (`src-v*`, `x-v1/`–`x-v3/`); its supplementary Mathematica notebook as text (`esm.txt`, `ver.txt`, identical); the text of Lindenstrauss, *Rigidity of multiparameter actions* (arXiv math/0402165; `lin04.txt`), **whose PDF the library does not hold**; four publisher landing pages |
| rescued to disk: the owner's shell outputs | 100 | 0.4 | `~/source/lean-dir-rescue/consolidation-2026-09-26/owner-tasks/tasks/` | the owner's; may hold identifiers, so never the repository (one vanished before the copy) |
| regenerable, copied to disk anyway | 2 | 0.6 | `~/source/lean-dir-rescue/consolidation-2026-09-26/regenerable/` | `old-corpus.md` = `git show fd285b33:CLAUDE.md` + `fd285b33:LEDGER.md` (J55's audit corpus, `data/fs100/j55-record.md` §1.3); `g4950.txt`, an excerpt of `CLAUDE.md` |
| junk | 6 | 0.9 | left | three `pdf/10.1007_*.pdf` and `st.pdf` are HTML landing pages, `adfs.pdf` an HTTP 404 page, one `.pyc` |
| in flight | 9 | 0.1 | left | written after 08:00 today at the scratch root (`arch.txt`, `bib.txt`, `bibaudit.out`, `dupes.txt`, `fa.txt`, `fa1.txt`, `lb.txt`, `wd.txt`, `wd.txt.sum`): the consolidation jobs running beside C1 |

Outside `/tmp/claude-1000/`: `/tmp/tmp3s0c4e3h/` and `/tmp/tmpnrmufa_7/` (2026-09-23, 185 MB each with a `bad.lrat`) are a certificate
checker's self-test directories — planted faults named "an edge dropped from the file", "a point moved by ten units", "faithful twin" —
regenerable by the self-test and left; `/tmp/slot-selftest-*` are `scripts/slot.py --self-test`'s empty ledgers. Every other `/tmp` path the
records name (`/tmp/arena244.pkl`, `/tmp/sdp/…`, `/tmp/claude-1000/solver-h2/…`, …) belongs to milestones before 2026-09-20 and is gone since a
reboot; none is named by the 2026-09-26 crunch.

**The rescued files a record points at** (every other rescued file is a gate output or a scratch step of the same jobs; the manifest names each):

| record and its words | file(s) | now at |
|---|---|---|
| `data/fs100/j55-record.md` header: "the application script lives in the session scratchpad" (J55, the FS-100 and FS-75 front page) | `apply.py` and its outputs `apply-*.out`; its gate runs `arch-*.out`, `audit-*.out`, `bib-*.out`, `dupes-*.out`, `fs71-*.out`, `c1–c7.out`, `p1–p7.out`, `selftest.out`, `sim.out`; `j55-gate/` | `data/consolidation-2026-09-26/rescued/scratch/` |
| `data/fs100/x30f-record.md`: "the scratchpad's `fixderiv4.py`", "`ledger3.py`", "`claude5.py`", "`fs6.py`, `stubs6.py`", "`cq7.py`" (X30F, wave 3's front page); "outputs in the scratchpad" | those six scripts; `b0.out`–`bF.out`, `fa0.out`–`faF.out`, `bib4.py`, `q8.py`, `show.py`, `assemble.py`, `dup*.out` | `data/consolidation-2026-09-26/rescued/scratch/` |
| `data/fs100/x10f-record.md`: "the scratchpad's `fixderiv.py`" (X10F, waves 1–2's front page) | `x10f/` (21 files: `fixderiv.py`, `claude.py`, `fs.py`, `ledger.py`, `bib.py`, the gate outputs) | `data/consolidation-2026-09-26/rescued/scratch/x10f/` |
| `plans/FS100-X13R-check.md` line 89: "Re-run (scratch, 06:07) … both plants go red" | `x13r/ppred.out`, `x13r/proot.out` (the two plants' outputs) | `data/consolidation-2026-09-26/rescued/scratch/x13r/` |
| `plans/FS75-kernel-167.md` lines 511, 604: `cert167` "renamed from its scratch `cert167Data`"; "[kernel, in a scratch module — not committed as a module]" | `cert167.lean` (the scratch data module, emitted by `tools/j52_intcert.py`); `q.lean` (a `#check` probe) | `data/consolidation-2026-09-26/rescued/scratch/` |
| `plans/FS75-K-kernel-167.md` stage 5.1's mutation table ("scratch copies, `lake env lean`") | the mutation runs' outputs `MutHs1.out`, `MutHs2.out`, `MutSign.out`, `SignFalse.out` (the mutated `.lean` copies themselves are gone) | `data/consolidation-2026-09-26/rescued/scratch/` |
| J52K's gate (`plans/FS75-K-kernel-167.md`) | `j52k-gate/` (build, axioms, vacuity, architecture logs and exit codes) | `data/consolidation-2026-09-26/rescued/scratch/j52k-gate/` |
| `plans/CRUNCH-2026-09-25-INDEX.md` §1.4: "in flight … J18's (running)" | `delta.py`, `delta2.py`, `price.py`, `swaptail.py` — J18 finished since | `data/consolidation-2026-09-26/rescued/scratch/` |
| J30's own tools (`plans/CRUNCH-2026-09-25-INDEX.md` §1.4's method; J30 excluded its own directory from its sweep) | `j30/` (`sweep.py`, `overlap.py`, `classify.py`, `rescue.py`, `reverse.py`, `wire.py`, their `.tsv`, `rescue.log`, `reverse.json`, `idfiles.txt`) | `data/consolidation-2026-09-26/rescued/scratch/j30/` |
| J24's fact-audit outputs (2026-09-25 19:08–19:32) | `/tmp/claude-1000/j24/`, `j24_m1drafts.out`, `j24_m3.out` | `data/consolidation-2026-09-26/rescued/tmp/` |
| J49's record draft and a DOM stub | `/tmp/claude-1000/kt1.txt` (a one-line flattening of an early draft of `plans/FS100-KT1-ambrus-ball.md`), `stub.js` | `data/consolidation-2026-09-26/rescued/tmp/` |
| the owner's inventory drafts, 06:05–06:07 | `new_inventory_rows.txt`, `new_inventory_rows2.txt` — **all 81 rows' text is in the two ×2×3 close inventories** (checked) | `data/consolidation-2026-09-26/rescued/scratch/` |

### 1.3 Every path and hash the records name — present and committed?

`data/consolidation-2026-09-26/c1/paths.py` reads 84 files — the crunch's reports and records, the post-crunch reports J50–J55, every
`plans/FS100-*.md` and `plans/FS75-*.md`, the queue, the advisor's record, and `data/fs100/*` records — and checks 958 path and hash tokens
(output `data/consolidation-2026-09-26/c1/paths.tsv`; control: a planted path and the fake hash `deadbeef1` are reported missing). The 178 short
hexadecimal tokens in the reports were checked as commits too. **Nothing named is lost.** Every token not in the tree is one of these:

| token(s) | named by | what happened | status |
|---|---|---|---|
| `data/fs100/j51/el2021.pdf`; `data/crunch-2026-09-26-x2x3/poros/el2021-2101.11120.pdf` | J51, X01D, X01V, X02D, X02V, the advisor, FS-100's plan and inventories | moved to `~/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` (J53 stage 2, `0c61c274`; X10F) | moved; the records' address is stale by design |
| `data/crunch-2026-09-26-x2x3/poros/einsiedler-fish-0804.3586.pdf` | the advisor, X01V, X12B, X10F, FS-100's plan | moved to `~/source/library/pdf/EinsiedlerFish2010-rigidity-measures-multiplicative-semigroup-polynomial-growth.pdf` (X10F) | moved |
| `data/fs100/x24r/LacaWarren2018-1801.07802.pdf`, `data/fs100/x03d/bekka-francini-2002.07497.pdf`, `data/fs100/x01d/huang2017-1606.06078.pdf`, `data/fs100/x01d/hlsx2023-1908.02611.pdf` | X03D, X24R, X01D, X10F, X30F, FS-100's plan | moved to `~/source/library/pdf/` under `<Key>-<title>.pdf`, md5 identical, then `git rm` (`data/fs100/x30f-record.md`, "File moves") | moved |
| `data/fs100/x11k/skeleton/Sqrt47.lean`, `…/SqrtFortySeven.lean`, `…/skeleton/` | X11K, X11K2, X11K3, `plans/FS100-K-kernel-47.md` | committed at X11K stages 3–4 and X11K2 stage 1, deleted by X11K3 (`ca025af0`, `077fa8b0`) when gated into `Proofs/`; the history holds both | in history |
| `data/fs75/j52k/`, `data/fs75/j52k/Work.lean` | `plans/FS75-K-kernel-167.md` | committed at J52K stages 1–2, retired at stage 6 (`3cb77e06`, "working copy retired") | in history |
| `data/fs100/j51/CLAUDE-snapshot.md`, `data/fs75/j52/CLAUDE-snapshot.md` | `plans/FS100-three-field-lemma.md`, `plans/FS75-kernel-167.md` | uncommitted by design and deleted at the last stage, as the records say | regenerable: `git show 179c6c5b:CLAUDE.md` (the commit the records name) |
| `data/fs100/x27d/`, `data/fs100/x27v/` | `plans/FS100-X27D-derivation.md`, `plans/FS100-X27V-verification.md` (working-file directories) | exist and are **empty**; X27D's and X27V's files are elsewhere (stage 2's index) | nothing to lose |
| `tools/x11k_*.py` | `plans/FS100-K-kernel-47.md` §G ("every `tools/x11k_*.py` check gets a plant") | no such tool was written; X11K's checks are Lean files | a plan line, not a file |
| `data/fs100/x25b/fs66-check-p…`, `data/fs100/x25b/t1-check--plant…`, `data/fs100/x21v/plant-…`, `plans/POROS-2026-09-25-wanted-poster-…` | X25B, X21V, the wave-3 inventory, J48 | written with a brace or a suffix; every expansion is tracked | tracked |
| `1a32060a…`, `897f264e…`, `1a32060a31636fcad481901dfa1c7e7b` | J53, FS-100's plan, J51D | md5 digests of PDFs, not commits | — |

### 1.4 Held for the owner

- The owner's `tasks/` shell outputs went to disk, off-repository, beside the owner's own scratch copy
  (`~/source/lean-dir-rescue/owner-scratch-2026-09-26-x2x3/`); the owner may want them merged there or dropped.
- **Owed, not mine to do:** the library holds no PDF of Lindenstrauss 2004 (arXiv math/0402165), which `BIBLIOGRAPHY.md` gained at X10F; the
  text read at the crunch is on disk (1.2). The arXiv source and supplementary notebook of `[AmbrusEtAl2023]` are on disk too, outside the
  library. Both are C2's to place (the bibliography and library lane).

### 1.5 Would-have-searched-here log

Empty: nothing in this job calls for a finite-witness search.
