# J32 — `scripts/gate_report.py` reads the counts it claims to compare against

*Crunch job J32, 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J32-gate-report-fix.md` (with
`STANDING-RULES.md`). Owner of this file: J32 alone.*

## Theorems this phase proved

None. This is a tool repair; no mathematical claim is made.

## "Would have searched here" log

No move in this job would have been a search. (The job is a gate script and its controls.)

## Stage 1 — SAVED

**Quotation check (standing rule 5).**

| quotation in the brief | source | verdict |
|---|---|---|
| J23bd's defect line, "tool defect — scripts/gate_report.py:106–117 prints "recorded counts (…baseline's header, CLAUDE.md § The gate): match" but reads only the baseline, never CLAUDE.md (fails open) — data/m2/j23bd/vacuity-after-baseline.out line 6" | `data/crunch-2026-09-25/reports/J23bd.md` line 7 | verbatim |
| "the baseline's header reads 7051/304/279/257" | `scripts/vacuity-baseline.txt` lines 25–26 (`declarations=7051 refutations-skipped=304 sites=279`, `generic=257`) | matches |
| `CLAUDE.md` § The gate records "`declarations=6795 refutations-skipped=278 sites=275`, `generic=253`" | `CLAUDE.md` lines 1910–1911 | matches (a line break falls inside the first code span) |
| the success line quoted by J23bd | `data/m2/j23bd/vacuity-after-baseline.out` line 6: "    recorded counts (scripts/vacuity-baseline.txt's header, CLAUDE.md § The gate): match" | matches |
| standing rules' Kooshi quotes ("All novel knowledge is a success"; the ban's intent) | `CLAUDE.md` Frontier item 23; `plans/CRUNCH-2026-09-25-queue.md` line 104 (CLAUDE.md § Toolchain holds only the fragment from "to eliminate") | match |

**The defect, confirmed by reading the code** (`scripts/gate_report.py` at `7d8ac03c`):
- `vacuity()` lines 106–117 call only `recorded_vacuity(baseline)`; no path to `CLAUDE.md` reaches the vacuity mode at all
  (`main` passes three paths, and `scripts/vacuity.sh:140` passes the baseline). The success line names
  "CLAUDE.md § The gate" anyway, and the stale line tells the reader to update `CLAUDE.md` without having read it.
- Same class, further instances found in the same file:
  1. `recorded_vacuity` compares only the keys the header happens to list; a header missing a key reports "match" on
     the keys it has (a partial fail-open), and a header with no counts prints a quiet "none found" and exits 0.
  2. `axioms()` does read the `CLAUDE.md` path it is given, but searches the **whole file** for "current audit reads N
     clean and M declared purchases" while its lines name "§ Trust ledger", takes the first match silently, and on no
     match prints a quiet "not found" and exits 0.
- A related defect outside this job's reach (not edited: `scripts/vacuity.sh` needs no path option): `vacuity.sh
  --baseline` (lines 195–202) rewrites the baseline with a fixed six-line header and **no counts**, so the next plain run
  finds no recorded counts in the baseline. With the repair below, that becomes a loud failure instead of a quiet line.

## Stage 2 — SAVED

**The repair** (`scripts/gate_report.py`; `scripts/vacuity.sh` only to pass the new path).

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| The vacuity digest takes `CLAUDE.md` as a required fourth path; `scripts/vacuity.sh:141` passes `"${REPO}/CLAUDE.md"` | an optional path defaulting to the repository's `CLAUDE.md`, leaving `vacuity.sh` untouched | the caller names every file the digest reads, as `axioms.sh` already does; a stale caller of the old three-path form gets the usage text and exit 2, never a quiet default | high |
| One line per recorded source: `recorded counts in <source>: match (9 of 9 compared)` or `RECORDED COUNTS ARE STALE in <source> — update it: …` | keep one combined line | a source is named on a "match" line only if it was read and compared, which is the brief's rule | high |
| Every source must record all nine counts (`declarations`, `refutations-skipped`, `sites`, six verdicts), each exactly once, else it is unreadable | compare whatever keys are present (the old behaviour) | a partial record reported "match" on the counts it lacked | high |
| `CLAUDE.md` is read inside its `## The gate` section only (to the next heading of level 1–3 outside a code fence); `## Trust ledger` likewise for the axiom sentence, which must occur exactly once there | search the whole flattened file (the old axioms behaviour) | the report names the section, so the section is what is read; a second copy of the sentence elsewhere can no longer be read silently | medium — if the counts are ever moved into a `###` subsection of § The gate, the digest fails loudly until the reader follows them |
| An unreadable source prints `RECORDED COUNTS NOT COMPARED — could not read the counts in <source>: <why>`, the digest finishes, then `==> gate report: FAIL — …` and **exit 3** | exit 0 with a loud line (drift's policy) | a comparison that could not run is a check that could not run, which this repository fails (as `vacuity.sh` does on an untelescoped declaration); drift stays flagged-not-failed, unchanged | medium — the wrappers' own message on any nonzero exit still says "no digest could be built from this run's output", which is wrong for exit 3; the digest's FAIL line says so explicitly. Rewording the wrappers is held for the owner |
| A baseline that does not exist is reported (`RECORDED COUNTS NOT COMPARED — … does not exist`) and not failed here | fail it | `vacuity.sh` fails on a missing baseline itself, and `--baseline` must be able to create one | high |

Smoke run on the real inputs (the latest saved scan, `build/gate/vacuity/20260926T000121Z-315327.log`): baseline header
"match (9 of 9 compared)"; "RECORDED COUNTS ARE STALE in CLAUDE.md § The gate — update it: declarations 6795 → 7051,
refutations-skipped 278 → 304, sites 275 → 279, generic 253 → 257"; exit 0. Axioms on the latest saved audit: "RECORDED
COUNT IS STALE in CLAUDE.md § Trust ledger — update it: 1034 clean → 1130"; exit 0. The old three-path call: exit 2.

**Instrument note.** Before editing `scripts/vacuity.sh`, `pgrep -f` matched the shell running it (CLAUDE.md's
self-match rule, in a checker's costume); the check that was used is `fuser` on the file's inode (exit 1: no holder),
itself controlled on a scratch script that `bash` held open (exit 0). The edit was made on a copy and moved into place
(new inode), so a running `bash` would have kept reading the old file.

## Stage 3 — SAVED

**Controls** (`data/gate-fix/j32/controls.py`; its output `data/gate-fix/j32/controls.out`; exit 0, "17 of 17 behaved").
Fixtures: the saved scan `fixture-vacuity-scan.log` (= `build/gate/vacuity/20260926T000121Z-315327.log`, sha256
`d98927309cf1fdf5…`) and audit `fixture-axioms-audit.log` (= `build/gate/axioms/20260926T000008Z-313215.log`,
`9c373af661e42da3…`); their counts are read by the controls' own parser, never by `gate_report.py`'s. Copies of
`CLAUDE.md` and the baseline are made in a temporary directory by string edits that must apply exactly once (else the
controls refuse to run), passed to the digest by path, and deleted after. Each run is bounded on both sides: the planted
source gets exactly the planted verdict (a STALE line whose items are exactly the planted count; or NOT COMPARED with the
planted reason and exit 3), every other source reads "match (9 of 9 compared)", no source is reported twice or omitted,
and the exit status is exactly the expected one.

| control | plant | verdict seen |
|---|---|---|
| V1 | faithful copies (the baseline, and `CLAUDE.md` with § The gate's counts set to the scan's) | both "match (9 of 9 compared)", exit 0 |
| V2 | `witnessed=18` in the `CLAUDE.md` copy | "RECORDED COUNTS ARE STALE in CLAUDE.md § The gate (read from …) — update it: witnessed 18 → 17"; baseline match |
| V3 | `generic=256` in the baseline copy | "RECORDED COUNTS ARE STALE in …/vacuity-baseline.txt's header — update it: generic 256 → 257"; CLAUDE.md match |
| V4, V5 | `unknown=` deleted; `sites=` doubled (CLAUDE.md) | NOT COMPARED "no unknown" / "sites recorded more than once", exit 3 |
| V6 | `## The gate` heading renamed | NOT COMPARED "0 '## The gate' headings, not one", exit 3 |
| V7 | the nine counts moved from § The gate into § The package | NOT COMPARED, all nine missing, exit 3 (the section, not the file, is read) |
| V8 | `declarations=` deleted from the baseline header | NOT COMPARED naming the baseline, exit 3; CLAUDE.md match |
| V9 | no baseline file | "does not exist (scripts/vacuity.sh fails on that)", exit 0 (documented) |
| A1–A3 | Trust ledger faithful / 1131 clean / 6 purchases | match; "1131 clean → 1130"; "6 purchases → 5" |
| A4–A6 | sentence reworded / moved to § Toolchain / doubled in § Trust ledger | NOT COMPARED "0 / 0 / 2 sentences …", exit 3 |
| V2, A5 against `7d8ac03c`'s script | the two plants the defect hides | **RED for their own reason**: the old version exits 0 and prints "recorded counts (…'s header, CLAUDE.md § The gate): match" (V2) and "recorded count (CLAUDE.md § Trust ledger): match" for a sentence outside the section (A5) |

**A wrong-reason red, caught on the way** (the file's own warning, reproduced): the first draft of the controls omitted
the mode argument, so every run printed the usage text and exited 2 — and the two runs against the old version "went
red" for that reason alone, while the fifteen others failed. The red-against-old check now also requires the old
version to exit 0 and to print the false "match" line itself; with the argument restored all seventeen behave.
