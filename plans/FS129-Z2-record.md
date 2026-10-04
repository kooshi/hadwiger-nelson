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

## Stage 3 — SAVED: the where-else column

**Tool**: `tools/fs129_z2_whereelse.py` adds to every record of `data/fs129/index/theorems.jsonl` two fields, `where_else` and `near_misses`
(each item `{"site", "kind", "address", "as", "by", "lane"}`; a near miss names a failing hypothesis and is not a bearing, so it is kept apart),
and writes `data/fs129/index/where-else.md` (the same items as tables, the counts, and a section for ledger rows, which have no record here).
**Encoding decisions** (mine to make): (1) sources are sections of the readers' records found by heading — the tables of misses (MA1 § 5.1,
MA2 § 4.1, MR1), the merge lists and sweeps (SR1 Stage 3 and § 6.1; SR2 §§ 2.1, 3.1, 4.1; SA1 §§ 2.2, 4.2, 6.1; SR3 § 4.1; OA1 § 3.3), OA1's and
OR1's verdict paragraphs (site: the demand step, J<n>), and every FS-129 entry's `uses only:` line in the reader's record (site: the entry; kind
"composition"; FS129-MR1-DOUBLETIP's line with FS116-N2-STAR dropped, as `plans/FS129-derivation.md` has it); (2) in a table row the theorems are
the ids of the first cell that names one, the sites the ids of the other cells; merges, shared steps and answers elsewhere are made symmetric
when the row names at most six ids; (3) **a site already joined to the theorem by an edge of `edges-corrected.csv` is dropped** — a recorded use
is not "elsewhere"; (4) a row that says "not read here" or begins "unchanged" with no merge is skipped; (5) the kind is read from the row's
words (`kind_of`). Ids are index ids as written, or a hyphenated token with exactly one id ending in it (`V6-HUG`).

**Checks**: every other field byte for byte (each record re-serializes to its original line, and each new line begins with the old one less its
closing brace — asserted); every item's address re-read, the theorem's token and the site's on that line (an entry's header and block for a
composition). **Fault** (`--fault`: every address moved one line down; nothing written): "address check failures 225" — it fires; clean: 0.

**Counts** (from `where-else.md`): **97 theorems have at least one site, 200 sites** (era A 3, era R 94); near misses 28 on 27 theorems; ledger
rows 6 with 23 sites (row 66 with 13: the Falconer-fan and slack-plane family; rows 78, 88, 104, 111, 1).

| reading lane | theorems with a site | composition | merge | stronger form held | answered elsewhere | closes | shortens | reduces | shared step | bears unapplied | bears | near miss |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| A (OA1, MA1, MA2, SA1) | 4 | 2 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 |
| R (OR1, MR1, SR1, SR2, SR3) | 93 | 43 | 55 | 12 | 18 | 5 | 18 | 19 | 14 | 0 | 12 | 28 |

**Reading the lane-A line**: lane A's bearings land on ledger rows (row 66 above all, through the kernel's `Slack` theorems) and on grokkings,
not on `LEDGER.md` § B theorems; the column is per theorem, so lane A's yield shows in `where-else.md` § Ledger rows and in the grokking tables
of FS129-MA1 § 3 and FS129-MA2 § 3.1 (bearing per mechanism), which this column does not encode. **Not encoded**: grokking-level bearings
("bears unapplied" per mechanism), and steps of OR1/OA1 prose outside their verdict paragraphs. Re-running `tools/fs129_index.py` drops the two
fields; the README note (`data/fs129/index/README-corrections.md` § 5) says to re-run this script after it.

## Stage 4 — SAVED: stubs — one minted, nine open stubs given FS-129's lines; FS-123's banner drafted

**Tool**: `tools/fs129_z2_stubs.py` (`--apply` once; `--check`: each insertion present exactly once, the new stub equal to the tool's text, and
`git diff` deleting no line of an open stub; `--check --fault` alters one insertion in memory — "insertion present 0 times … it fires"). Every FS-129
statement quoted in a stub is read by the tool from the reader's record (`stmt()`), so each quotation is verbatim by construction. In open stubs only
three places are written: the end of the bearing section, a sentence after the provisional-bearings line, and a closing section "Dated correction notes
(FS129-Z2, 2026-10-03)" naming the line each note corrects. Poros's question sections and banners are untouched. `git diff --numstat`: 29, 5, 15, 11, 35,
32, 10, 15, 21 lines added and 0 deleted in FS-104, FS-126, FS-122, FS-120, FS-124, FS-123, FS-117, FS-125, FS-115.

**Minted — FS-130, the bicycle's windings** (`plans/STUB-bicycle-windings.md`; item 120's first derivation, item 81's third lead): C-T-BIKE (a proper
three-colouring of `T₁(u) ∪ T₁(v)` by finitely many arcs, each `d ∈ (1, 2)`), with what is held (FS106-BIKE's lower bound; the one-circle winding of
FS110-N2-RING, FS110-Y3-GP and FS129-SR1-RINGBAND; FS110-Y-BIKE-3C off grid corners; FS107-R's narrow failure of the `π/3` ansatz at `d = 1.9`; row 1's
near miss) and what is missing (a coupling of the two circles' windings across the cross curve). **Its bearing, stated as none known**: the route that
consumed C-T-BIKE (FS-107's R-S) is closed (row 133); whether it bears on FS-122's robust Lemma 6.1 count is Poros's first question. Not ranked.

**Placed in an open stub, not minted — the O1-OUT analogue for valid maps** (item 120's second derivation, with item 101): in FS-115's bearing
(`plans/STUB-stuck-ray.md`), with SR1's stall quoted verbatim, SR2's note on FS121-DB1-L7, and its smallest open form. **Why**: its object is FS-115's (the
stuck chains' pencil, FS112-N2-RAY), its use is FS-115's own sub-question N3-ALPH ((b″)), and its bearing is FS-115's; a separate stub would split one
object across two files. FS-126 gets a one-line cross-reference (the saturated side, where O1-OUT is held). Item 101's second lead (the V5-RING family
holds without simplicity) is in FS-123's bearing as a lead for question 3.

**Open stubs, item by item**

| stub | items | what was added |
|---|---|---|
| FS-123 `plans/STUB-qfree-ring.md` | 54, 60, 101, 125, 133 | bearing: question 1 answered yes with the restriction repaired (QFREE, QFREE-NS, EMPTY-NS); question 2 moot; question 3's Siamese half is the main question; leads; what FS-124 may assume (BENDFRAG); K1 for FS-117. Notes: the invention signal settled; the first construction target does not exist in the non-Siamese class; N7-3T's class; the card's hunches' outcomes (scoring left to the opening) |
| FS-124 `plans/STUB-q-ring.md` | 60, 80, 82, 129, 130, 133 | bearing: DOUBLETIP and OUTERADJ as pruning rules (and the Lean caution of items 126, 131); TWOCIRC; the bends' reach and BENDLE3 for case 1 (FS-110's winding at `y`); SEMI-PAR3's winding exploration (not derived); case 6 (E2ONE; PINALL's and PIN120's exceptions narrowed; the Reuleaux residue is HALF's whole class; RSTOP's R-T line unplaced); case 4 (FS112-SIX subsumed; its covering GAP); case 8 (LOCALDENSE, DISCF-NS); route R's pairs fall in this case list |
| FS-125 `plans/STUB-saturated-local.md` | 60, 80, 117, 130 | bearing: G3 and SAT-QFREE closed in the non-Siamese class (QFREE, QFREE-NS); S1-QF a case of QFREE (QFCASE citing QFREE-NS), a second route at one mind, question 0 unchanged; KAPPA's last clause over an empty class; MR1's two questions (the binding each kill reads; INTRAD at a vertex) |
| FS-104 `plans/STUB-cp-plane-six.md` | 28, 39, 42, 87, 26 | bearing: route (c) (NOAFF-FIELDS), route (0) (FALC-RED), route (b) (NOPERLAW; FALC-RES, FALC-FAN, DICHO-K; HOSTS (iv) ↔ row 88), the map step at five (TOP5; carrier left to the re-rank). Notes: line 53 (F1 held given MR: rows 128, 130); lines 55, 87 (Falconer held and read) |
| FS-122 `plans/STUB-forced-pair.md` | 27, 58 | bearing: J15's verdict — routes R and M meet at the pinned corner with unit arcs; the exact-map form; the band form reduces to J16's card; pointer to FS-130. Note: line 37 holds under Condition 5 only (`plans/FRONTIER-STUBS.md` rank 5's line is the re-rank's) |
| FS-115 `plans/STUB-stuck-ray.md` | 60, 101, 120 | bearing: DISC-F in the Siamese and non-simple classes; the O1-OUT analogue for valid maps, placed here with its reason |
| FS-120 `plans/STUB-pinch-at-junction.md` | 129, 59 | bearing: FS111-M2-INT's GAP open, not refuted by M3-IRREG, its maximal-set form question 3; TOP5 and HULLSET bear on its rungs |
| FS-117 `plans/STUB-route-t-count.md` | 129, 133, 117 | bearing: K1 on (Q)-free rings has no instance in the non-Siamese class; FS114-Y3-RSTOP's R-T line unplaced between here and FS-124 case 6; RSTOP ⊂ RSTOPALL only on the non-Siamese simple part |
| FS-126 `plans/STUB-curved-pencils.md` | 62, 101 | bearing: stuck ray and tangent pencil one picture, not one statement; the valid-map side carried in FS-115; INTRAD at a saturated vertex would put FS-125's tangent edges in this class (not derived) |

**Not done here, and why**: item 26 (the map step at five's carrier) and item 43 (Poros's FS-128 card wording) are FS129-P1's; item 59's J10 line in
`data/fs129/demand-judged.md` is Poros's file (FS-104's bearing records the correction); `plans/FRONTIER-STUBS.md` rank 5's line (item 58) is Keryx's
file and the re-rank's.

### FS-123's banner, drafted for Keryx (not written; Keryx files banners)

Slot: `plans/STUB-qfree-ring.md`, directly under the title line `# FS-123 — the (Q)-free ring: …` and above the italic "*Minted 2026-10-03 by FS-116's
close, part 2 …*" paragraph, as a blockquote in the form of FS-115's banners:

> **Re-aimed 2026-10-03 (FS-129's audit).** Question 1 is answered yes in the non-Siamese class, simple or not: bending a fragment on a whole-tile
> restriction of radius at most `√3` keeps its class and leaves only (Q) arcs on the ring, so no non-Siamese valid six-coloured fragment on a closed disc
> of radius above 1 about a vertex of at least four colours has a ring carrying no (Q) arc (FS129-OR1-QFREE, simple; FS129-SR3-QFREE-NS, without
> simplicity; derived, one mind, kernel pending; `plans/FS129-derivation.md`). Question 2 is moot. **This stub's question is now question 3's Siamese
> half**: does any Siamese valid six-coloured fragment about a vertex of at least four colours whose ring carries no (Q) arc survive past `1 + ε`?
> FS129-OR1-QFREE-CLASS reduces it to the ring with no arc of `Γ`. The bearing section's paragraph "At FS-129's audit" has the detail.
