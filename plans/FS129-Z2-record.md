# FS129-Z2 — the record job, part 2: stubs, the index corrected and its where-else column, the scored predictions, dated notes, and the drafts of the front page

*Job FS129-Z2 (2026-10-03, from about 02:00 UTC (next day)), a `general-purpose` agent on Opus reading the deriver's identity
(`.claude/skills/ephodos/SKILL.md` in full, then `.claude/agents/ephodos.md` from "# Ephodos in lean-dir — the workflow" to its end). Brief:
`data/fs129/briefs/FS129-Z2-record.md`, with `plans/STANDING-RULES.md`. I write this record, `plans/STUB-*.md` (new stubs; in open stubs only the
provisional-bearings line, the "Bearing on the answer" section and dated correction notes), `data/fs129/index/` (new `-corrected` files and the
`where_else` column), dated notes appended to five non-derivation records, `data/fs129/z2/`, `tools/fs129_z2_*.py` and
`data/fs129/reports/FS129-Z2.md`. `plans/FS129-derivation.md` is FS129-Z1's; I do not write it. No agent of my own (standing rule 1).*

## Theorems this phase proved

None. The record job's second part files and corrects; it derives nothing new, and no statement was re-derived.

## Stage 1 — SAVED: readback, quotation check, the worklist, decisions

### 1.1 Readback

FS-129 is the cross-application audit Kooshi asked for (`plans/STUB-cross-application-audit.md` § The request): for each novel result, where
else it bears; interweave (compositions), strengthen (merges, weaker hypotheses), and find new paths. Eight reader jobs in two era lanes and
three passes derived the entries FS129-Z1 files in `plans/FS129-derivation.md`. My half is what the audit changes outside that file: (1) stubs —
two new ones at least (item 120: a coupling of two circles' windings for FS106-BIKE; an O1-OUT for valid maps, with item 101) and bearing lines
and dated correction notes in open stubs (items 28, 42, 58, 60, 80, 82, 87, 101, 117, 129, 133), FS-123's banner drafted for Keryx; (2) the index
corrected by a script with a planted fault (items 77, 99, 111, 118), `-corrected` files beside the originals, README notes (items 90, 132); (3)
the `where_else` column in `theorems.jsonl`, built by script from the readers' tables; (4) dated notes on five non-derivation records (items 59,
96); (5) every registered prediction scored in one table; (6) the drafts of the front page, after Z1's file is committed; (7) the sweeps; (8) this
record and the report. Every number is read from its source, never from an inventory line.

### 1.2 Quotation check (standing rule 3)

| quotation in the brief | source | verdict |
|---|---|---|
| "Right after this close, we'll be refining the workflow again... then I think it might be worth an audit … File that as a special case stub for after the workflow refinements." | `plans/STUB-cross-application-audit.md` § The request | verbatim (script: substring match, the full text) |
| "Also a note for the whole plan that not only are "hubs" important, but deep "roots", where a long chain of theorems starts, even if it has only one offshoot" | `plans/FS129-cross-application-audit.md` § 1. Kooshi's words | verbatim (script: substring match) |
| "For each novel lemma and theorem, where else it applies, with addresses"; "New stubs for the new paths, ranked by Poros" | `plans/STUB-cross-application-audit.md` § Deliverables | verbatim (script) |

No mismatch.

### 1.3 State of part 1 at launch

`plans/FS129-derivation.md` is committed at `adf2267a` (stage 2, 40 entries) and `7c388842` (stage 3, part 1); FS129-Z1's record shows stage 5
written and not yet committed, and inventory item 134 says Z1 files FS129-SR3's entries too. So the drafts wait for Z1's last commit; everything
else starts now. Z1's § 5.3 item 1 ("File FS129-SR3's entries … into `plans/FS129-derivation.md`", addressed to Z2) predates item 134 and is
outside my `touches:`; I leave it to Z1 and say so in the report.

### 1.4 The worklist (inventory items routed to this job)

| deliverable | inventory items | stage |
|---|---|---|
| index corrections and README notes | 77, 99, 111, 118; 90, 132; 35 and 19 (receipts that inherit the defect) | 2 |
| `where_else` column | plan § 3 Stage 5; the readers' misses, merge lists, entries | 3 |
| new stubs | 120 (with 81's third lead, 101), 26 (map step at five — P1's carrier call; noted) | 4 |
| open-stub bearing lines and dated notes | 28, 42 (FS-104), 58 (FS-122), 60 and 133 (FS-123, FS-124, FS-125, FS-115), 80, 82 (FS-124, FS-125), 87 (FS-104), 101 (FS-123), 117 (FS-125), 129 (FS-120, FS-124/FS-117) | 4 |
| FS-123's banner (drafted for Keryx) | 54, 125, 133 | 4 |
| dated notes on five records | 59, 96 | 5 |
| scored predictions | 23 (A1–A7), 39, 47, 57, 64, 73, 84, 92, 102, 114, 122, 133; Keryx's priors noted | 6 |
| sweeps | the plan and the stub, "conjecture" / "not claimed" | 7 |
| drafts for the front page | 6 of the brief's Done means; 126, 131 (Lean cautions, for the drafts) | 8 |

### 1.5 Decisions (the brief's "yours to decide")

1. **Order**: index first (the where-else column and the drafts read the corrected graph), then the column, stubs, notes, scores, sweeps; drafts last.
2. **The index corrections are additive**: `tools/fs129_index.py` is not touched; `tools/fs129_z2_index.py` reads the original files and writes
   `<name>-corrected.<ext>` beside each, re-deriving hubs, roots, cycles, the Lean order and vacuity's dependent counts from the corrected edges
   with the same definitions the original files state in their headers.
3. **The `where_else` column** is written into `theorems.jsonl` in place (the brief: "a field `where_else`"), by `tools/fs129_z2_whereelse.py`,
   which keeps every other field byte-identical (checked) and also writes `data/fs129/index/where-else.md`, the same content as a table.
