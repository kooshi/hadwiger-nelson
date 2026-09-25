# The 2026-09-25 crunch — index and wiring audit (J30, the bookkeeper)

*Written by crunch job J30 at Kooshi's request (brief: `data/crunch-2026-09-25/briefs/J30-wiring-audit.md`). Two jobs: that nothing
from today is lost (stage 1), and that everything today produced can be found from the older things it bears on (stages 2–5).*

**This file holds results. It is fenced for every blind verifier:** a blind job does not open it. The pointer blocks this job writes
into stubs and plans carry addresses and neutral titles only.

**This file records; it does not judge.** Grades and verification statuses are copied from the records and reports that state them;
where a record and a report disagree, both are listed with addresses.

## Stage 1 — SAVED (nothing lost)

### 1.1 Git state (read 2026-09-25, about 17:00)

| item | state | owner |
|---|---|---|
| branch | `main`; before this stage's push, three commits were unpushed (J10 stage 3, J15 stage 4 and J15's report); this stage's push carries them | — |
| `data/m3/j18/completion-81-49-M40.txt`, `data/m3/j18/swaptail.txt`, `tools/crunch_j18_swaptail.py` | untracked, **in flight** | J18 (running) |
| `data/m3/j21/`, `tools/crunch_j21_dyadic_hyperbola.py`, `tools/crunch_j21_spectra.py` | untracked, **in flight** | J21 (running) |
| `ARCHITECTURE.md`, `Proofs.lean`, `Proofs/HadwigerNelson/Transcendental.lean`, `scripts/Axioms.lean`, `data/m2/j15/*` | modified or untracked at the brief's writing; **committed since by J15** (`1b5595aa`, report `6cb89847`) | J15 (done) |
| `data/fs91/j10/phase2.out`, `tools/crunch_j10_phase2.py` | untracked at the brief's writing; **committed since by J10** (`16272ed0`) | J10 (done) |

Nothing uncommitted belongs to a finished job. Nothing was committed on another job's behalf.

### 1.2 Commit hashes named in reports

Every hexadecimal token of 7–40 characters in `data/crunch-2026-09-25/reports/*.md` (15 reports, 86 distinct tokens) resolves to a
commit (`git cat-file -e <h>^{commit}`). Control: a planted fake hash `deadbeef1` is reported missing, so the check can fire.

### 1.3 Records: SAVED stages against `git log`

Every record a report names, plus the running jobs' records. "Clean" means the working copy equals `HEAD`.

| record | SAVED headings at `HEAD` | commits touching it; subjects' stages | working copy |
|---|---|---|---|
| `plans/FS91-S0F-three-colours.md` (J02) | 1–4 | 4; stages 1–4 | clean |
| `plans/FS91-S0V-band-to-nine.md` (J01) | 1, 2, the four `k` parts of 3, 3b | 7; stages 1, 2, 3, 3b | clean |
| `plans/FS91-S0V2-SWm-second-reading.md` (J03a) | 1, 2, 3, 5; stage 4 is headed "skipped" | 4; stages 1, 2, 3, 5 | clean |
| `plans/FS91-character-local-global.md` (J03, M1's plan) | 1–5 | 6; stages 1–5 | clean |
| `plans/FS91-S0FV-three-colours-blind.md` (J09) | 1–5 | 5; stages 1–5 | clean |
| `plans/FS91-S1D-character.md` (J07) | 1–5 | 6; stages 1–5 | clean |
| `plans/FS91-S1D-six.md` (J08) | 1–6 | 6; stages 1–6 | clean |
| `plans/FS91-S1V-character.md` (J10) | 1–4 | 4; stages 1–4 | clean |
| `plans/FS91-S1V-six.md` (J11) | 1–4 | 4; stages 1–4 | clean |
| `plans/M2-kernel-lane.md` (J04, M2's plan) | 1–4 | 5; stages 1–4 | clean |
| `plans/M2-S1D-bridge.md` (J17) | 1–3 | 5; stages 1–3 | clean |
| `plans/M2-S1K-chain.md` (J14) | 1–5 | 5; stages 1–5 | clean |
| `plans/M2-S2K-route-c.md` (J15) | 1–4 | 4; stages 1–4 | clean |
| `plans/M3-exotic-colourings.md` (J06, M3's plan) | 1–5 | 7; stages 1–5 | clean |
| `plans/M3-S1A-rank-one.md` (J18, running) | 1–4 | 5; stages 1–4 | clean |
| `plans/M3-S1D-windows-five.md` (J21, running) | 1–2 | 2; stages 1–2 | clean |
| `plans/M2-S3K-unit-ring.md` (J16, running) | 1 | 1; stage 1 | clean |
| J12's record (running) | not yet on disk | — | in flight |

No SAVED stage is missing from the history.

### 1.4 The scratch sweep

The session's scratch directory held 1,928 files outside `owner-*`, `locks` and this job's own `j30/`. Every one is classified in
**`data/rescued-2026-09-25/SWEEP.tsv`** (one line each: path, bytes, class, where it is now). Method: each file's git blob was matched
against `HEAD` and all history (`git hash-object`, `git rev-list --objects --all`); unmatched text was scored by the share
of its lines of 25 characters or more found verbatim in some tracked file (a *successor* at 80 % or more); papers were matched against
`~/source/library` by content hash and by text overlap with the library's extractions.

| class | files | where | note |
|---|---|---|---|
| (a) already in the repository | 362 | an identical blob at `HEAD`, in history or among a running job's untracked files, or a successor file | the matching path is in the manifest |
| (b) rescued into the repository | 598 (39 MB) | `data/rescued-2026-09-25/<same relative path>` | tools, record drafts, briefs, result tables, logs and small data from FS-73 to FS-89 and the crunch; agent-id-shaped tokens redacted on copy (none found) |
| (b) rescued to disk | 55 (1.6 GB) | `~/source/lean-dir-rescue/<same relative path>` | files over 5 MB or binary: CNFs, large JSON and JSONL runs, archives, NumPy arrays, pickles |
| (c) papers already held | 216 | `~/source/library` | 9 byte-identical PDFs; 207 text extractions of library papers (151 in `libtxt/`, the rest copies inside milestone directories — these also copied to disk) |
| (c) papers copied to the library | 7 | `~/source/library/pdf/`, `~/source/library/notes/` | see 1.5 |
| page and figure renders | 168 | `~/source/lean-dir-rescue/` | images of library papers' pages, regenerable; copied anyway |
| (d) junk by type | 281 | left | bytecode, pid and pgid files, git internals and the vendored solver sources (glucose, drat-trim) of one FS-73 verifier, three HTML error pages saved as `.pdf` |
| in flight | 4 | left | `delta.py`, `delta2.py`, `price.py`, `swaptail.py` at the scratch root: J18's (running) |
| older owner-named directories | 240 (181 MB) | **not swept** | `fs73-owner/`, `fs79-owner/`, `fs81-owner/` — held for the owner (1.7) |

Two stray files outside the scratch directory, in `/tmp/claude-1000/`: `o3-drop-imag.txt` (an FS-89 stage-0B control run whose two
siblings are committed as `data/fs89/s0b/control-k3-*.txt`) and `plant.out` (2026-09-24, a plant check printing `Theta_all`), both
rescued to `data/rescued-2026-09-25/tmp-claude-1000/`. The other session directories under `/tmp/claude-1000/-home-kooshi-source-lean-dir/`
are empty.

### 1.5 Papers copied to the library

| scratch file | library copy | `BIBLIOGRAPHY.md` entry |
|---|---|---|
| `degrey2018.pdf` (arXiv:1804.02385) | `pdf/deGrey2018-chromatic-number-plane-at-least-5.pdf` | `[deGrey2018]` exists |
| `ns.pdf` (Goel, Patil, Verma, *Nullstellensätze and Applications*, arXiv:1809.02818) | `pdf/GoelPatilVerma2022-nullstellensatze-and-applications.pdf` | **none** — proposed in stage 5 |
| `fs85-audit/cite/1808.09534.pdf` | `pdf/Hujdurovic2020-strong-cliques-vertex-transitive-graphs.pdf` | `[Hujdurovic2020]` exists |
| `fs85-audit/cite/1809.00527.pdf` | `pdf/ErskineGriggsSiran2022-clique-partitioned-graphs.pdf` | `[ErskineGriggsSiran2022]` exists |
| `fs85-audit/cite/1910.14454.pdf` | `pdf/JanssenMacKeigan2020-orthogonal-colourings-cayley-graphs.pdf` | `[JanssenMacKeigan2020]` exists |
| `fs85-audit/af2021.html`, `af2022.html` (the Polymath wiki page *Algebraic formulation of Hadwiger–Nelson problem*, 2021 and 2022 snapshots) | `notes/polymath16-algebraic-formulation-2021-snapshot.html`, `…-2022-snapshot.html` | the 2018 snapshot's entry; the two dates to be added (stage 5) |

`km.txt` is the text of Kechris–Marks, *Descriptive Graph Combinatorics* (2020 preliminary version); the library holds its PDF
(`pdf/KechrisMarks-descriptive-graph-combinatorics-2020.pdf`), and `BIBLIOGRAPHY.md` has no entry for it — proposed in stage 5.

### 1.6 Quotation check (standing rule 5)

- My brief's quotation of Kooshi ("Inject an Opus bookkeeper … easy to find from related things.") has no source on disk other than the
  brief itself; it is the owner's report of a conversation. Recorded, not checkable by me.
- The brief's correction wording, "`Hom_ℚ(F(i), ℝ) mod 1`", matches `plans/FS91-S1D-character.md` line 21 (its Q7, citing J03a's record
  §3.4, J03a-9) and `plans/FS91-S1D-six.md` line 18. Agrees.

### 1.7 Held for the owner

- `fs73-owner/`, `fs79-owner/` and `fs81-owner/` in the scratch directory are owner directories under an older naming; the brief's skip
  rule names `owner-*`. They hold 240 files (181 MB), some with agent ids. Not read, not copied. **If nothing is done, they die with the
  session.** A copy with ids redacted is one command if the owner wants it.

### 1.8 Would-have-searched-here log

Empty: nothing in this job calls for a finite-witness search.
