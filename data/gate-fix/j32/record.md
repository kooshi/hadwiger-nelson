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
