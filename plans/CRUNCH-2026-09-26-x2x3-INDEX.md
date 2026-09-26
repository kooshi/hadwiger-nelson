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

## Stage 2 — SAVED (the index)

### 2.0 The crunch's map (addresses only)

| what | where |
|---|---|
| the queue (claim lists §2, reframe §3, jobs §4 and §7, expectations §5, advice §6) | `plans/CRUNCH-2026-09-26-x2x3-queue.md` |
| the milestone it ran | FS-100, stage 5: plan `plans/FS100-three-field-lemma.md`; stub `plans/STUB-measure-rigidity-three-fields.md` |
| the three closes (mathematics half) | `plans/FS100-three-field-lemma.md` §R-close (stage 5) [X09C], §R-close (stage 5, wave 3) [X29C], §R-close (stage 5, wave 3b) [X31C] |
| the derivation register | `plans/FS100-derivation.md` §3 (stage 5), §4 (wave 3), §5 (wave 3b), §G, §K |
| the close inventories | `plans/FS100-x2x3-close-inventory.md` (waves 1–2); `plans/FS100-x2x3-wave3-close-inventory.md` (wave 3) |
| the front-page records | `data/fs100/x10f-record.md` (rows 120–122), `data/fs100/x30f-record.md` (rows 123–125), `data/fs100/x31c-record.md` (rows 126–127) |
| the ledger rows | `LEDGER.md` rows 120–127 (and the corrections to rows 113, 117, 118, 120, 121 the records list) |
| new in `CLAUDE.md` | § Frontier item 29; grokking G80 (X10F, `data/fs100/x10f-record.md`) |
| the stub minted | FS-101, `plans/STUB-main-clause-five-kernel.md` (X29C; the kernel port of row 123) |
| briefs, reports, the clerk's list | `data/crunch-2026-09-26-x2x3/briefs/`, `…/reports/` (one per job; `FOLDED.txt` the clerk's), `…/READY.md` |
| the advisor | `plans/POROS-2026-09-26-x2x3-crunch.md`; its reading copies moved to the library (1.3) |

### 2.1 Per job

Brief = `data/crunch-2026-09-26-x2x3/briefs/<name>.md`; report = `data/crunch-2026-09-26-x2x3/reports/<job>.md`. "Rows" are the `LEDGER.md` rows
whose address cell names the job's record or tool, or which the job applied; "entries" are the `plans/FS100-derivation.md` entries whose text names
the job (`data/consolidation-2026-09-26/c1/entry-jobs.txt`, prefix `FS100-` dropped). Commits: each report's COMMITS line, and
`data/consolidation-2026-09-26/c1/jobfiles.py <job>`.

| job | brief | record | tools | data | rows | entries |
|---|---|---|---|---|---|---|
| planner | `PLN-x2x3-planner` | `plans/CRUNCH-2026-09-26-x2x3-queue.md` (commits "X23 planner") | — | `data/crunch-2026-09-26-x2x3/READY.md` | — | — |
| advisor (Poros) | `ADV-x2x3-poros` | `plans/POROS-2026-09-26-x2x3-crunch.md` (commits "X23 advisor") | — | `data/crunch-2026-09-26-x2x3/poros/` | — | — |
| J00, clerk | `J00-clerk`, `K0-clerk-budget-line` | the inventories and §4 statuses (commits "Crunch clerk") | — | `reports/FOLDED.txt` | — | — |
| X01D | `X01D-einsiedler-fish-derivation` | `plans/FS100-X01D-derivation.md` | `tools/x01d_unit_check.py` | `data/fs100/x01d/` | 120 | EFP, EFZ, MR, Q47, EFG, EFX |
| X01V | `X01V-einsiedler-fish-verifier` | `plans/FS100-X01V-verification.md` | `tools/x01v_entropy_check.py` | `data/fs100/x01v/` | 120 | EFP, HX1, MR, Q47, EFG, EFX |
| X02D | `X02D-pe-lim-derivation` | `plans/FS100-X02D-derivation.md` | `tools/x02d_pe1_counterexample.py`, `tools/x02d_circle_measure.py` | `data/fs100/x02d/` | 120 | PE1, HX1, PE2, CE1 |
| X02V | `X02V-pe-lim-verifier` | `plans/FS100-X02V-verification.md` | `tools/x02v_checks.py` | `data/fs100/x02v/` | 120 | PE1, HX1, PE2, MR, EFG, CE1, FR1, ED1 |
| X03D | `X03D-fourier-flip-derivation` | `plans/FS100-X03D-derivation.md` | `tools/x03d_factor_minima.py`, `tools/x03d_weyl.py` | `data/fs100/x03d/` | 122 | FR1, ED1, ED2, FLK, SPEC, FLH, X22 |
| X05V | `X05V-sp-cor-flip-verifier` | `plans/FS100-X05V-verification.md` | `tools/x05v_checks.py` | `data/fs100/x05v/` | 121, 122 | Q47, FLK, SPEC, FLH |
| X11K | `X11K-lean-47-dependencies` | `plans/FS100-K-kernel-47.md` | — | `data/fs100/x11k/` (the skeleton in history, 1.3) | 127 | EFP, MR, Q47 |
| X12B | `X12B-ef-plus-blind-derivation` | `plans/FS100-X12B-derivation.md` | `tools/x12b_multiplier_count.py` | — | 120 | EFP, EFZ, MR, EFG |
| X13R | `X13R-ed2-z-reading-check` | `plans/FS100-X13R-check.md` | `tools/x13r_check.py` | rescued plant outputs (1.2) | 122 | ED2 |
| X09C, close | `X09C-close-math` | `plans/FS100-three-field-lemma.md` §R-close (stage 5) | — | `data/fs100/x09c/` (empty) | drafted 120–122 | wrote §3 |
| X10F, front page | `X10F-front-page` | `data/fs100/x10f-record.md` | (`tools/claude_md_fact_audit.py` ALLOW lines) | scripts rescued (1.2) | applied 120–122; corrected 118 | — |
| X11K2 | `X11K2-lean-47-gate-and-upper-bound` | `plans/FS100-K-kernel-47.md` §X11K2 | — | `data/fs100/x11k/` | 127 | CLS, SPC, COR, Q35 |
| X11K3 | `X11K3-lean-gate-general` | `plans/FS100-K-kernel-47.md` §X11K3 | — | `data/fs100/x11k/` (build, axiom, vacuity logs) | 127 | — |
| X21D | `X21D-167-and-family-derivation` | `plans/FS100-X21D-derivation.md` | `tools/x21d_family.py` | `data/fs100/x21d/` | 123, 125 | Q0, FAM, K0b, 167, B12, B3 |
| X21V | `X21V-167-and-family-verifier` | `plans/FS100-X21V-verification.md` | `tools/x21v_checks.py` | `data/fs100/x21v/` | 123, 125 | Q0, FAM, K0b, 167, B12, B3 |
| X22D | `X22D-type-B-derivation` | `plans/FS100-X22D-derivation.md` | `tools/x22d_checks.py` | `data/fs100/x22d/` | 124 | X22, X27D-EQ, X27D-E |
| X22V | `X22V-type-B-verifier` | `plans/FS100-X22V-verification.md` | `tools/x22v_c0.py`, `tools/x22v_simplex.py` | `data/fs100/x22v/` | 124 | X22, X27D-E, X27D-FL |
| X23D | `X23D-spcor-every-field-derivation` | `plans/FS100-X23D-derivation.md` | `tools/x23d_class.py`, `tools/x23d_norm_one_spectrum.py` | `data/fs100/x23d/` | 123 | FAM, CLS, DLP, G27, TCA, CX, SPC, EXC, COR, Q35, D1, CTL |
| X23V | `X23V-spcor-every-field-verifier` | `plans/FS100-X23V-verification.md` | `tools/x23v_places.py`, `tools/x23v_hoffman.py` | `data/fs100/x23v/` | 123 | the same, and GF |
| X24R | `X24R-prior-art-gate` | `plans/FS100-X24R-prior-art.md` | (`data/fs100/x24r/arx.py`) | `data/fs100/x24r/` | the gate sentence of 121, 123 (`data/fs100/x30f-record.md`) | EFX, CE1, FR1, FLK, SPEC, FLH, FAM, 167, CLS, COR |
| X25B | `X25B-tca-class-blind-derivation` | `plans/FS100-X25B-derivation.md` | `tools/x25b_t1_check.py` | `data/fs100/x25b/` | 123 | FAM, TCA, CX |
| X26B | `X26B-cls-every-field-blind-derivation` | `plans/FS100-X26B-derivation.md` | `tools/x26b_spectra.py`, `tools/x26b_uq_colour.py` | `data/fs100/x26b/` | 123 (through §4's entries; its address cell does not name X26B) | CLS, DLP, G27, CX, EXC, COR |
| X27D | `X27D-tr-rot-derivation` | `plans/FS100-X27D-derivation.md` | `tools/x27d_ramanujan.py` | — (`data/fs100/x27d/` empty) | 126 | X22, X27D-EQ, -E, -ATT, -FL, -SIERP |
| X27V | `X27V-tr-rot-verifier` | `plans/FS100-X27V-verification.md` | — | — (`data/fs100/x27v/` empty) | 126 | the same, and X27V-PM |
| X28D | `X28D-complex-place-scope` | `plans/FS100-X28D-derivation.md` | `tools/x28d_check.py` | `data/fs100/x28d/` | 123 | COR, X22, X28D-P, -S, -CP1, -CP2, -CP3, -ODD, -CUBE |
| X29C, close | `X29C-close-math-wave3` | `plans/FS100-three-field-lemma.md` §R-close (stage 5, wave 3); FS-101's stub | — | — | drafted 123–125 | wrote §4 |
| X30F, front page | `X30F-front-page-wave3` | `data/fs100/x30f-record.md` | (`tools/claude_md_fact_audit.py` ALLOW lines) | scripts rescued (1.2) | applied 123–125; corrected 113, 117, 120, 121 | — |
| X31C, fold and front page | `X31C-tr-rot-fold` | `plans/FS100-three-field-lemma.md` §R-close (stage 5, wave 3b); `data/fs100/x31c-record.md` | (`tools/claude_md_fact_audit.py`; `scripts/vacuity-baseline.txt` comment) | — | applied 126, 127 | wrote §5 |

### 2.2 The ledger rows, read back to their jobs

| row | subject (the row's own opening words, truncated) | jobs | close |
|---|---|---|---|
| 116 | "Kronecker selection is false as stated, and at ℚ(√47) its corrected form is the question." | J51D, J51V | J53, J53b; front page J55 |
| 117 | "T-C(A)'s class among real quadratic fields is the conjecture's `L ≥ 5` family, and SP-Cor holds over it." | J51, J51V | J53, J53b; J55 |
| 118 | "Rank one of Kronecker selection, and why Einsiedler–Lindenstrauss's classification does not apply." | J51, J51D, J51V | J53, J53b; J55 |
| 119 | "`χ(ℚ(√167)²) ≥ 4` in the kernel, with no finite graph" | J52, J52K | J54; J55 |
| 120 | "Measure rigidity for the unit-vector group" | X01D, X01V, X02D, X02V, X12B | X09C; X10F |
| 121 | "`χ(ℚ(√47)²) = 5`: the local–global conjecture's cheapest exposed five-clause is met." | X05V (with J45, J46 and R88-TCA); X24R's gate | X09C; X10F |
| 122 | "Where the other routes to MR stop" | X03D, X05V, X13R | X09C; X10F |
| 123 | "The local–global conjecture's main clause through five" | X21D, X21V, X23D, X23V, X25B, X26B, X28D; X24R's gate | X29C; X30F |
| 124 | "The type-(B) fields given MR" | X22D, X22V | X29C; X30F |
| 125 | "Six at ℚ(√167) contains a question about the real plane alone." | X21D, X21V | X29C; X30F |
| 126 | "TR-ROT is Q-μ, and its spectral side is closed on `E`." | X27D, X27V | X31C |
| 127 | "The main clause through five in the kernel, conditional on named hypotheses" | X11K, X11K2, X11K3 | X31C |

### 2.3 The post-crunch jobs of the night before (J50–J55)

They are indexed in the 2026-09-25 index, which lacked them: `plans/CRUNCH-2026-09-25-INDEX.md`, "Addendum — the jobs after the crunch's close
(C1, 2026-09-26; addresses only)".

## Stage 3 — SAVED (wiring: the reverse index)

**Method.** For every older file the 2026-09-26 work bears on — the stubs of the fields, questions and lemmas `LEDGER.md` rows 116–127 and
`plans/FS100-derivation.md` §1–§5 name or feed, the milestone plans and derivation registers whose results they use or extend — the rows it
already names were read by a parser (`named_rows` in `data/consolidation-2026-09-26/c1/wire.py`, which expands "rows 116–119" and "rows 120, 121").
Where a bearing row was not named, an **address-only pointer block** headed `## Where the 2026-09-26 work on this lives` was appended: each
missing row with the derivation entries or files it lives in, and this index. No result, verdict or grade is written into any of them. The
table, machine-readable: `data/consolidation-2026-09-26/c1/wire.tsv`. The derivation-register gate (`tools/fs71_ledger_b_check.py --strict`)
reads the same before and after the blocks (PASS, 784 § B rows), since a block has no `**<id> — …**` entry line.

| older file | why the work bears on it | rows borne | already named | block adds |
|---|---|---|---|---|
| `plans/STUB-measure-rigidity-three-fields.md` (FS-100) | the milestone itself | 116–118, 120–127 | all but 127 | 127 (and the three §R-close sections) |
| `plans/STUB-four-colours-167.md` (FS-59) | its field, ℚ(√167), at four, five and six | 117, 119, 123, 125 | none | all four |
| `plans/STUB-five-colours-47.md` (FS-84) | its field, ℚ(√47) | 121, 122, 127 | 121 (and 116, 117, 120, 123) | 122, 127 |
| `plans/STUB-ultrametric-continuation.md` (FS-98) | T-B1 over the type-(B) fields, given MR | 120, 124, 126 | 124, 126 | 120 |
| `plans/STUB-adelic-window-colouring.md` (FS-64) | windows over ℚ(√167); cut-and-project five-colourings | 117, 125 | 117 (and 116, 118) | 125 |
| `plans/STUB-windows-five-nonmixing.md` (FS-96) | `PL(23, 43)` | 125 | none | 125 |
| `plans/STUB-infinite-place-spectra.md` (FS-97, absorbed into FS-100) | its measure half is FS-100's MR | 120, 121, 122, 126 | none | all four, and FS-100's stub |
| `plans/STUB-biquadratic-table.md` (FS-48) | ℚ(√3,√5), ℚ(√2,√3) in the class table | 123 | none | 123 (FS100-Q35, CTL, CLS) |
| `plans/STUB-last-lattice.md` (FS-72) | five over ℚ(√3,√5) | 123 | none | 123 (FS100-Q35) |
| `plans/STUB-six-is-not-a-value.md` (FS-62) | the main clause through five; six at ℚ(√167) | 123, 125 | none | both |
| `plans/STUB-certificate-at-43.md` (FS-69) | `PL(23, 43)`; the plane at 43 | 125 | none | 125 |
| `plans/STUB-residue-tower-drop.md` (FS-66, closed) | all-levels ratios; its lemma at `e ≥ 3` derived (FS100-DLP) | 117, 123 | none | both |
| `plans/STUB-rigidity-dichotomy.md` (FS-73, closed) | its certificate T41 in the kernel | 119 | none | 119 |
| `plans/STUB-unit-vector-ring-kernel.md` (FS-47) | MR's hypothesis `R = O′`; row 100's exception (FS100-EXC) | 120, 123 | none | both |
| `plans/STUB-twenty-seven.md` (FS-54) | `λ_min(Γ₂₇)` and G56's floor at 27 (FS100-G27) | 123 | none | 123 |
| `plans/STUB-isometric-measure-rigidity.md` (FS-89's stub) | measure rigidity | 120 | none | 120 |
| `plans/STUB-dyadic-rigidity-triangle-free.md` (FS-86) | the type-(B) fields | 124, 126 | none | both |
| `plans/STUB-three-colour-criterion-kernel.md` (FS-75) | its minimal instance | 119 | 119 | — (wired) |
| `plans/STUB-quadratic-witnesses-kernel.md` (FS-60) | row 119's consumer | 119 | 119 | — (wired) |
| `plans/STUB-main-clause-five-kernel.md` (FS-101) | minted by the crunch | 123, 127 | 123, 127 | — (wired) |
| `plans/FS84-five-colours-47.md` (FS-84's plan) | its question answered at hand grade | 121, 122, 127 | none | all three, and §R-close (stage 5) |
| `plans/FS84-SI-D-derivation.md`, `plans/FS84-SI-V-verification.md` (J45, J46) | SP-Cor, used for row 121, re-derived blind (X05V) and carried to every field (FS100-K0, K0b, SPC) | 117, 121, 123 | none | all three |
| `plans/FS86-row88-rigidity.md` (row 88's plan) | row 88 given MR | 120, 124, 126 | none | all three, and two §R-close sections |
| `plans/FS86-dyadic-rigidity.md` (FS-86's plan) | the type-(B) fields | 124, 126 | none | both |
| `plans/FS89-rational-band-rigidity.md` (FS-89's plan) | measure rigidity | 120 | none | 120 |
| `plans/M3-exotic-colourings.md` (M3's plan) | windows at five over ℚ(√167) | 125 | none | 125 |
| `plans/FS91-character-local-global.md` (FS-91's plan) | one character carries the selection, given row 98 | 116, 118 | none | both |
| `plans/FS73-rigidity-dichotomy.md` (FS-73's plan) | T41 in the kernel | 119 | none | 119 |
| `plans/FS66-residue-tower-drop.md` (FS-66's plan) | FS100-DLP | 123 | none | 123 |
| `plans/FS54-twenty-seven.md` (FS-54's plan) | FS100-G27 | 123 | none | 123 |
| `plans/R88-derivation.md` (row 88's register) | R88-TCA's class form; row 88 given MR | 117, 121, 123, 124, 126 | 123, 126 | 117, 121, 124 |

**Orphans found and where they now hang** (a file on disk and committed that no older file's reader would reach):

| file | reachable before | now |
|---|---|---|
| `plans/FS100-X26B-derivation.md`, `tools/x26b_spectra.py`, `tools/x26b_uq_colour.py` (X26B, a blind derivation feeding row 123) | its own report; one mention in FS-100's plan; the derivation entries name "X26B" but give no path; row 123's address cell names neither | this index (2.1); proposed for row 123's address cell (below) |
| `tools/x02d_circle_measure.py` (X02D) | X02D's record, `plans/FS100-derivation.md`, the inventory; not row 120's address cell | this index (2.1) |
| the rescued scratch scripts of X10F, X30F, J55 and the scratch module of J52K | nowhere (they were only in `/tmp`) | 1.2's table; `data/consolidation-2026-09-26/c1/manifest.tsv` |

**Proposed for the front-page lane (C3a, C3b, C2 — this job edits none of those files):**
- `LEDGER.md` row 123's address cell: add `plans/FS100-X26B-derivation.md` Stage 2 (§2.1–§2.4) and `tools/x26b_spectra.py`, `tools/x26b_uq_colour.py` (X26B is one of
  FS100-CLS's three derivations and FS100-DLP's two, per their grades).
- `BIBLIOGRAPHY.md` / the library (C2): Lindenstrauss 2004 (arXiv math/0402165) has no PDF in `~/source/library`; its text and
  `[AmbrusEtAl2023]`'s arXiv source and supplementary notebook are at `~/source/lean-dir-rescue/consolidation-2026-09-26/papers/` (1.2).
- Nothing else: every ledger row 116–127 names its records, and each stub the rows feed now points back (the table above).

## Stage 4 — SAVED (the report)

The report is `data/consolidation-2026-09-26/reports/C1.md`. Would-have-searched-here log for the whole job: empty.
