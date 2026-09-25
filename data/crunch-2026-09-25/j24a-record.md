# J24a — the front-page pointers (crunch 2026-09-25): record

*Job J24a, the front-page lane for one job: apply the index's proposed pointers (`plans/CRUNCH-2026-09-25-INDEX.md` §5.1) to
`CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md` and `BIBLIOGRAPHY.md` — pointers and state only, never a crunch result. Brief:
`data/crunch-2026-09-25/briefs/J24a-front-page-pointers.md` (with `STANDING-RULES.md`). Opus 5.5, 2026-09-25.*

## Theorems this phase proved

None. This job edits pointers, state lines and bibliography rows; it proves nothing.

## Stage 1 — SAVED (baseline gates and the quotation check)

### 1.1 Baseline, before any edit

| gate | command | result |
|---|---|---|
| fact audit | `python3 tools/claude_md_fact_audit.py --base f1226b8a` (FS-89's closing commit: the latest in `git log --oneline -- plans/FS89-close-inventory.md`) | exit 0, "AUDIT PASSED (0 failure(s))" |
| duplicates | `python3 tools/claude_md_fact_audit.py --dupes` | exit 0; "11 repeated runs of >= 10 words" |
| bibliography | `python3 tools/bib_audit.py` | exit 1: **11** bracketed keys cited and undefined (`[BCR1998]`, `[CohenMahboubi2012]`, `[EggletonErdosSkilton1985]`, `[GoelPatilVerma2022]`, `[KechrisMarks2020]`, `[Lang1953]`, `[Marker2002]`, `[Poizat2000]`, `[WangKosheleva1998]`, `[Zapletal2022]`, `[Zhu1998]`) **and 3 arXiv ids** cited and not in the bibliography (1809.02818, 2103.02757, 2201.00275) — the brief names the 11 keys only; the three ids are fixed by the same rows (Goel–Patil–Verma; Zapletal's two papers, which § B lists without the `arXiv:` prefix the audit reads) |
| `CLAUDE.md` size | `wc -c` | 275,129 bytes (budget 300,000) |

### 1.2 Quotation check (standing rule 5)

| quotation in the brief | source | verdict |
|---|---|---|
| `CLAUDE.md` says "**Open milestones, in order.** **None is open.**" | `CLAUDE.md` line 270 | verbatim |
| R. B. Eggleton, P. Erdős, D. K. Skilton, "Colouring the Real Line", *J. Combin. Theory Ser. B* **39** (1985) 86–100 | the held scan's title page (`pdftotext -f 1 -l 1`): "JOURNAL OF COMBINATORIAL THEORY, Series B 39, 86-100 (1985) … Colouring the Real Line" | agrees |
| the 1990 paper: "Colouring prime distance graphs", *Graphs and Combinatorics* **6** (1990), DOI 10.1007/BF01787476 — not held | `BIBLIOGRAPHY.md` line 298 (title, venue, "not held"); the DOI from `plans/M3-S1A-rank-one.md` §1.3 (J18, OpenAlex) | agrees; the DOI is not yet in the row |
| "`tools/bib_audit.py` reports 11 cited keys undefined" | §1.1 | agrees (plus 3 arXiv ids, above) |
| "`CLAUDE.md`'s budget is 300,000 bytes (it stands near 275,000)" | the header; `wc -c` | agrees |
| STANDING-RULES: Kooshi, *"The intent of the ban is to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time."* | `plans/FS89-close-inventory.md` row 2 (Kooshi's ruling, verbatim with "The intent of the ban is") | agrees (`CLAUDE.md` § Toolchain quotes it from "to eliminate") |
| STANDING-RULES: Kooshi, *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."* | memory note `all-novel-knowledge-is-success.md`; `CLAUDE.md` Frontier item 23 | agrees |

### 1.3 Would-have-searched-here log

| # | move I would have made by search | what I did instead |
|---|---|---|
| — | none: no stage of this job calls for a finite-witness search | — |
