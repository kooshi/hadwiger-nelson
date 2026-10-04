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

## Stage 2 — SAVED: the index corrected (items 77, 99, 111, 118; README notes for items 90, 132)

**Tool**: `tools/fs129_z2_index.py` reads `data/fs129/index/edges.csv` and `theorems.jsonl` as FS129-IX1 wrote them (it imports
`tools/fs129_index.py`'s `tarjan`, `depths`, `descendants`, `chain_down` and `lean_order`, so every recomputed file has the original's definitions)
and writes beside them `edges-corrected.csv` (a fourth column `z2` marks each sorted, added or route edge), `edges-dropped.csv`, `hubs-corrected.md`,
`roots-corrected.md`, `cycles-corrected.md`, `lean-order-corrected.md`, `vacuity-corrected.md` and `corrections.md` (edge by edge, with the text each
added edge came from). The notes are `data/fs129/index/README-corrections.md`, a new file beside IX1's README, which I do not edit (my `touches:`
names new files in the index).

**What it applies**: the readers' sorts — FS129-SR1's 26 edges (§ 4.1), FS129-SR2's 23 (§ 2.3), FS129-SA1's 9 lane-A edges and its two
correction edges into FS89-CL2 (§ 4.3), 60 in all, each checked present in `edges.csv` and sorted once; false and reversed edges dropped; a
reversed edge's true direction added where absent (2: FS56-T2 → FS56-T6, FS114-N2-LEMMAS → FS114-ROUTE-T); route edges kept and marked. Then item
111's two defects, by rule: **range citations** (13 middle members restored, each where both ends and the member resolve by IX1's own tiers) and
**milestone prefixes** — in the graph, 14 hyphenated ids written without their prefix in a `uses only:` line (`C-HULL`, `M-PINCH`, `W-EQ-K`, …)
resolved under a strict rule (one candidate; the candidate's milestone not later than the citing entry's), 183 suffix candidates left listed; in
the no-entry lookup, the 16 ids SA1 found filed with a prefix, each checked to be an entry and listed.

**Run** (clean), exit 0:
```
z2 index: edges 1330 -> 1315 (dropped 44: false 35, reversed 9; kept and marked route 9, real 7; added 29: reversed-fix 2, range 13, prefix 14); cycles 30; Lean order 178 (166 on first routes); top root FS112-U1 depth 10; FS111-C-HULL-SO dependents 0; FS121-D4-HOLE dependents 0
z2 index, the readers' sorts alone (no added edges): cycles 30; Lean order 171
```
**Fault** (`--fault`: the false edge FS111-C-HULL-SO → FS111-C-HULL kept; the fault run writes nothing — the defect of item 132 avoided), exit 0:
```
z2 index: edges 1330 -> 1316 (dropped 43: false 34, reversed 9; …); cycles 30; Lean order 179 (167 on first routes); top root FS112-U1 depth 10; FS111-C-HULL-SO dependents 77; FS121-D4-HOLE dependents 0
```
— it fires (C-HULL-SO's dependents 0 → 77, the Lean order 178 → 179). **Control against the readers' own figures**: the sorts alone give the Lean
order 171 and lane-R cycles 2, FS129-SR2's printed line ("Lean order 197 -> 171 …"; "lane-R cycles 11 -> 2"), reproduced; FS121-D4-HOLE's
dependents 0, FS129-SR1's ("61 -> 0"). The script's self-checks (every sorted edge present and sorted once; no dropped edge survives; every added
endpoint an entry; no duplicate edge; the 16 prefixed ids entries) pass.

**The corrected counts**: edges 1,330 → 1,315; cycles 45 → 30 (lane R: 2 left — {FS114-N7-3T, FS114-N7-HUB}, {FS116-V5-LENS, FS116-Y3-SIX,
FS116-Y3-TIPS}); the Lean order 197 → 178 on every kept edge, 166 on first routes, 26 entries leaving and 7 joining (FS110-N3-CONF, -N3-DEG,
-N4-FIN, -N4-SHADOW, -N4-SHAVE, -N4-STUCK, -W-MERGE, through the `prefix` edges into FS114-CV-EXISTS and FS114-CV-HD); the longest chain of
dependents 13 → 10 edges (FS112-U1 or FS112-A4SIX to FS116-C114-LOCAL-F; FS111-V0-ID1's longest is 9, and it stays the top hub with 83); roots'
top 100 by era 87 R / 13 A → 72 R / 28 A; hubs' 90 / 10 → 66 / 34. **Withdrawn figures** (README-corrections § 2): item 18's 13-edge chain;
C-HULL-SO's 78 dependents; D4-HOLE's 60–61 (items 35, 99); M-HULL2's 63 (it came through the false cycle {M-PINCH, D4-HOLE}); FS91-J01-3's rank 45;
item 19's 87 of 100.

**For FS129-L1**: cite `lean-order-corrected.md`; its ROUTE-ONLY flag marks entries in the closure only through a second mind's route; item 116's
errata and FS129-SR1 § 6.2's "do not formalize as stated" list still apply (the index cannot see them).
