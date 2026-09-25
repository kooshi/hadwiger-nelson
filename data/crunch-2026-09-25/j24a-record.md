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

## Stage 2 — SAVED (`CLAUDE.md` and `plans/FRONTIER-STUBS.md`: C1–C4, F1–F3)

Each proposal read in the index (`plans/CRUNCH-2026-09-25-INDEX.md` §5.1) and checked against the file's text on disk first.

| # | decision | reason |
|---|---|---|
| **C2** | **applied, amended** — `CLAUDE.md` § Paths forward, "**None is open.**" → "**Three are open, as the 2026-09-25 crunch** (queue …; index …, which carries results and which blind verifiers do not open; none of the crunch's work enters this file before its milestone closes): **M1** = FS-91 (plan path); **M2** = the kernel lane, FS-45, FS-39, and FS-87 or FS-47 (plan path); **M3** = FS-76 in rank one and FS-64 at five colours (plan path)." | the state was false. Two amendments against J30's text: (i) M2's list is "FS-45, FS-39, and FS-87 or FS-47", as `plans/M2-kernel-lane.md`'s title and targets state it (K3 is FS-87's stripe lemma *or* FS-47's prime inversion, chosen by pricing), where J30 listed all four as if both were in; (ii) C1's two extra facts folded in (below). |
| **C1** | **declined as a separate paragraph; its content folded into C2** | one home per fact (`CLAUDE.md`'s header): C1 restated C2's three milestones in the *Last updated* paragraph. What C1 said that C2 did not — the plan-file paths, that the index carries results and blind verifiers do not open it, and that none of the crunch's work is in this file until each milestone closes — went into C2's one line. |
| **C3**, **C4** | **not applied** (the brief: M2's close) | trust and vacuity counts wait for M2's last kernel job |
| **F1** | **applied** — `plans/FRONTIER-STUBS.md` § Open milestones: "**No FS milestone is open. FS-89 closed 2026-09-25**" → "**The 2026-09-25 crunch holds three milestones open:** M1 = FS-91 (rank 2 below; plan), M2 = the kernel lane (FS-45, FS-39, and FS-87 or FS-47; plan), M3 = FS-76 in rank one and FS-64 at five colours (plan); queue …, index … (it carries results; blind verifiers do not open it). **FS-89 closed 2026-09-25** …" | the state was false (M1 is an FS milestone); the same amendment to M2's list as C2's |
| **F2** | **applied** — an italic pointer line just above the ranked table, after the two re-rank paragraphs (placed there so the "The earlier re-rank's paragraph follows" chain is not split) | verified first: all sixteen stubs it names carry the section "Where the 2026-09-25 work on this lives" (`grep` on each stub file) |
| **F3** | **applied, amended to address only** — the FS-82 row's status column gains "crunch work bearing on it: `plans/FS91-close-inventory.md` rows 8, 15, 117 (applied at FS-91's close)" | J30's text, "A CLOSED banner and a correction to the stub's text are owed", states a verdict (that FS-82's question is answered, inventory row 117) in a file blind verifiers read; the brief forbids any crunch verdict here. The pointer keeps the address and drops the verdict. |
| — | **not touched:** the "**Next:** Kooshi's choice, with a next-step advisor" clauses in both files | not proposed; they describe what follows the open milestones and stay true of that. The considered alternative, rewriting them to "the three closes", was not a pointer J30 proposed and would have edited unproposed state in files blind verifiers read. |

**Gates after the `CLAUDE.md` edit:** `python3 tools/claude_md_fact_audit.py --base f1226b8a` exit 0, "AUDIT PASSED (0 failure(s))";
`--dupes` exit 0, "11 repeated runs". `CLAUDE.md` 275,129 → 275,608 bytes (+479). `plans/FRONTIER-STUBS.md`: 53 ranked rows, no FS number
twice.

## Stage 3 — SAVED (`LEDGER.md`: L1–L4)

| # | decision | reason |
|---|---|---|
| **L1** | **applied verbatim** — a header line after "…the story goes to git.*": "*Work of the 2026-09-25 crunch not yet folded into rows is indexed in `plans/CRUNCH-2026-09-25-INDEX.md`, with its items in `plans/FS91-close-inventory.md`, `plans/M2-close-inventory.md` and `plans/M3-close-inventory.md`.*" | address only; no result |
| **L2** | **declined, for FS-91's close** | "Corrections owed: … rows 3, 61, 69, 70, 78" at row 95's end asserts that FS-89's row 95 is wrong somewhere — a crunch finding, in a file blind verifiers may read |
| **L3** | **declined, for M3's close** | "Correction owed: … row 18" at row 92's end asserts the same of row 92 |
| **L4** | **declined, for FS-91's close** | "Re-derivations and extensions since" (row 96) and "Extended to every real number field" (row 82) state results; the second names the result itself |

L1 alone therefore reaches the ledger; the declined pointers stay in the index's §5.1 for the closes (J24's first batch).

**Gates after the `LEDGER.md` edit:** fact audit `--base f1226b8a` exit 0, "AUDIT PASSED (0 failure(s))"; `--dupes` exit 0, "11 repeated
runs"; `python3 tools/fs71_ledger_b_check.py --strict` exit 0, "RESULT: PASS" (544 theorems, 544 § B rows; the same before the edit).
