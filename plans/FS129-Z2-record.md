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

## Stage 5 — SAVED: dated notes on five records that are not derivation files (items 59, 96)

**Tool**: `tools/fs129_z2_notes.py` (`--apply` once; `--check`: each note present once and directly after its anchor's paragraph, `git diff` deleting
no line; `--check --fault` alters one note in memory — "note present 0 times … it fires"). Each note is a paragraph headed "*Dated note (FS129-Z2,
2026-10-03; the text above stands as written).*", inserted directly after the text it corrects:

| record | under | the note |
|---|---|---|
| `plans/FS114-NB5-verification.md` | § 1b.3, the radius note ("restrict first") | holds for the whole-tile restriction of radius ≤ `√3` (FS129-OR1-WHOLE), not a round neighbourhood, which can make a Siamese pair or a non-simple meeting (OR1 § J1, control `fs129-or1-cut`); true about the arcs, silent on class membership (SR1 § 2.3); on the whole-tile restriction the bends keep the class (BENDFRAG; BENDANY) |
| `plans/FS114-NB6-verification.md` | § 1b.0, "Bends on a fragment" | the same |
| `plans/FS114-N7-proof.md` | the setting paragraph, ll. 88–89 | the same, and: with QFREE and QFREE-NS the setting's class (a (Q)-free ring at a four-colour vertex) has no member on a disc of radius above 1 in the non-Siamese class; the per-pattern kills stand as arguments about an empty class |
| `plans/FS116-Y4-construction.md` | § 3.3, "For C114-LOCAL-F's case list" | the (Q)-free rings with (R2) arcs are now reached (QFREE; QFREE-NS on FS116-V6's route); FLANK is not needed for them |
| `plans/FS116-local-exclusion.md` | § 3.6, the sharper form's bullet | LOCAL-DENSE held at `r = 3` (possibly vacuous); "the same question" only in the non-Siamese simple class (DISCF-NS); elsewhere DISC-F needs besides an exclusion about repeated-colour vertices or GS-4's density form (OR1 § J19) |

`git diff --numstat` on the five: lines added only (one note each, and a blank line around the two plain-paragraph notes), 0 deleted.

## Stage 6 — SAVED: every registered prediction, scored

**Sources**: Poros `plans/POROS-2026-10-03-fs129-card.md` § 1.2 (A1–A7; D1–D4 scored there, § 2.1); OA1 § 1.3 with § 4.2; OR1 § Stage 1 with
§ Registered expectations, scored; MA1 § 1.3 with § 5.3; MA2 § 1.3 with § 4.3; MR1 § Stage 1 with § Registered expectations, scored; SA1 § 1.3 with
§ 6.4; SR1 § Stage 1 with § 6.4; SR2 § Stage 1 with § 4.4; SR3 § 1.1 (`data/fs129/sr3/expectations.md`) with § 5.2 — each `plans/FS129-<job>-audit.md`.
Outcomes are read from the records; where a reader scored its own, I checked the outcome against its sections and kept it unless noted. Brier is
`(p − outcome)²` on binary predictions, by `tools/fs129_z2_scores.py` (its `--fault` flips Poros A6 and the card's Brier moves 0.3742 → 0.3408 — it
fires). A count is scored against its registered value and interval.

| registrant | prediction | registered | outcome | score |
|---|---|---|---|---|
| Poros | A1 a pass-1 composition closes a step | expected 1 (0–3); P(≥ 1) = 0.45 | 1 outright (J1, FS-123 q. 1, OR1) and half of J19 (LOCAL-DENSE) | met; Brier 0.3025 |
| Poros | A2 steps shortened | expected 5 (2–9); P(≥ 3) = 0.6 | pass 1 alone: 10 distinct steps (OA1: J12, J13; OR1: J2, J3, J7, J10, J15, J17, J23, and J19's DISC-F half) | at the top of the interval; Brier 0.16 |
| Poros | A3 share null in both lanes | 0.7 (0.5–0.85) | 12 of 24 = 0.50 (OR1 non-null J1, J2, J3, J7, J10, J15, J17, J19, J23; OA1 non-null J2, J12, J13; J18 moot) | at the interval's lower edge |
| Poros | A4 item 31's open list or the top three changes | P = 0.2 | **yes** — "(Q)-free rings with (R2) arcs", open in item 31, are closed in the non-Siamese class (FS129-OR1-QFREE, FS129-SR3-QFREE-NS; one mind); FS-123's first question answered | Brier 0.64 |
| Poros | A5 lane A shortens a regularity-era step from a result its stub does not cite | P = 0.35 | **yes, by its letter** — J12 and J13 (FS-104 routes (c), (0)/(b)) shortened from row 66 and the kernel's Γ₁₁ tables, which `plans/STUB-cp-plane-six.md` does not cite (inventory item 39); Poros's prior on where named FS-104 first | Brier 0.4225 |
| Poros | A6 pass 2 yields more compositions than pass 1 | P = 0.6 | **no** — pass 1: 13 entries (OA1 5, OR1 8); pass 2: 7 (MA1 3, MA2 3, MR1 1) | Brier 0.36 |
| Poros | A7 another FS116-Y4-type miss | P = 0.6 | **no, strictly** — MA1 0, MA2 0, MR1 "0 strictly"; near kin recorded: 3 citation or re-derivation misses (MR1), FS84-S1e re-derived uncited (SA1), CLOSURE proved three times (SR2), 3 GAPs answered elsewhere unlinked (SR3 § 4.1) | Brier 0.36 |
| Poros | the card's hunch: at least a third of the steps need a kind of input no held result delivers (falsifier: more than two thirds get one) | hunch | not scorable as kept: the readers did not mark "needs a new kind of input" per step; held results bore on 11 of 24 steps, so the falsifier did not fire | — |
| Poros | J2 `semipar3-reads-a-height` (0.35); J17 `skeleton-carries-a-syntheme` (0.5) | hunches | SEMI-PAR3 undecided (FS-110's winding found as the height's home, OR1 § J2; MR1's exploration not derived); the syntheme not worked | not scorable |
| **Poros, six binary** | | | | **Brier 0.374** (1 of 6 on the side registered) |
| OA1 | E1 closes | 0; P(≥ 1) = 0.10 | 0 | Brier 0.01 |
| OA1 | E2 shortened | 1.5; P(≥ 1) = 0.55; P(≥ 3) = 0.15 | 2 (J12, J13) | above expected; Brier 0.2025 and 0.0225 |
| OA1 | E3 nulls | about 85 % | 21 of 24 = 88 % | met |
| OA1 | E4 lane moves the bearing | P = 0.07 | no | Brier 0.0049 |
| OA1 | E5 = Poros A5 | P = 0.30 | yes (as A5) | Brier 0.49 |
| OA1 | E6 a held result false | P = 0.03 | no | Brier 0.0009 |
| OA1 | E7 a composition outside the list | 1; P(≥ 1) = 0.5 | 1 (FALC-RED as a general statement) | Brier 0.25 |
| OA1 | E8 merges, new stubs | 0; 0.3 | 0; 0 | met |
| OA1 | E9 J4 yields | P = 0.3 | no | Brier 0.09 |
| **OA1, eight binary** | | | | **Brier 0.134** |
| OR1 | closes | 0; P(≥ 1) = 0.15 | 1½ (J1; J19's half) | below; Brier 0.7225 |
| OR1 | shortened or reduced | 4 (2–7) | 7 | at the top |
| OR1 | nulls | 17 (13–21) | 14 | in range |
| OR1 | compositions | 3 (1–6) | 8 | above |
| OR1 | compositions outside the list | 1 (0–3) | 0 (two leads) | in range |
| OR1 | new stubs | 1 (0–2) | 0 (four re-aims) | in range |
| OR1 | J10 a lane-R result bears | 0.35 | yes (TOP5) | Brier 0.4225 |
| OR1 | J15 the collision stands | 0.40 | no | Brier 0.16 |
| OR1 | lane moves the bearing | 0.12 | yes (FS-123's step) | Brier 0.7744 |
| OR1 | a held result false | 0.04 | no | Brier 0.0016 |
| **OR1, five binary** | | | | **Brier 0.416** |
| MA1 | E1 mechanisms reached | 22 (12–35) | 23 | met |
| MA1 | E2 bearing unapplied | 6; P(≥ 3) = 0.6 | 3 | below expected; Brier 0.16 |
| MA1 | E3 compositions | 4 (1–8) | 3 | in range |
| MA1 | E4 Y4-kind misses | 1.5; P(≥ 1) = 0.55 | 0 | Brier 0.3025 |
| MA1 | E5 Falconer differs materially | 0.15 | no | Brier 0.0225 |
| MA1 | E6 bearing changes | 0.06 | no | Brier 0.0036 |
| MA1 | E7 a held result false | 0.03 | no | Brier 0.0009 |
| MA1 | E8 new cross-era sites | 1; P(≥ 1) = 0.45 | 0 (two deepenings) | Brier 0.2025 |
| MA1 | E9 share of the seventeen unmentioned bearing | 0.2 | 0 of 17 | below |
| **MA1, six binary** | | | | **Brier 0.115** |
| MA2 | E1 mechanisms reached | 28 (15–47) | 49 | above |
| MA2 | E2 bearing unapplied | 6; P(≥ 3) = 0.65 | 10 | above; Brier 0.1225 |
| MA2 | E3 compositions | 3 (0–7) | 3 | met |
| MA2 | E4 Y4-kind misses | 0.7; P(≥ 1) = 0.4 | 0 | Brier 0.16 |
| MA2 | E5 new cross-era sites | 0.6; P(≥ 1) = 0.35 | 0 | Brier 0.1225 |
| MA2 | E6 bearing changes | 0.05 | no | Brier 0.0025 |
| MA2 | E7 a held result false | 0.03 | no | Brier 0.0009 |
| MA2 | E8 share of nulls from retired methods | 0.3 | 14 of 49 ≈ 0.29 | met |
| MA2 | E9 a root yields a travelling strengthening | 0.2 | no | Brier 0.04 |
| **MA2, six binary** | | | | **Brier 0.075** |
| MR1 | mechanisms worked | about 16 | 17 | met |
| MR1 | bearing unapplied | 6 (3–9) | 8 | in range |
| MR1 | compositions | 4 (2–8) | 1 (DOUBLETIP) | below |
| MR1 | Y4-kind misses | 2 (0–4) | 0 strictly; 3 citation or re-derivation misses | in range strictly |
| MR1 | nulls | 5 (2–9) | 5 | met |
| MR1 | G83's straddle bears on an unapplied held step | 0.55 | yes | Brier 0.2025 |
| MR1 | the bends shorten an FS-110 GAP | 0.45 | no | Brier 0.2025 |
| MR1 | V6-HUG's identity closes or empties a held open step | 0.20 | partly (a configuration of FS-124, not a named step) | left out of Brier |
| MR1 | a held result false | 0.04 | no | Brier 0.0016 |
| MR1 | this pass changes the bearing | 0.10 | no | Brier 0.01 |
| **MR1, four binary** | | | | **Brier 0.104** |
| SA1 | E1 merges with an entry | 3 | 5 | above |
| SA1 | E2 merge lines | 10 | 17 | above |
| SA1 | E3 weakenings derived | 2 | 2 | met |
| SA1 | E4 results sorted empty | 2 | 1 | below |
| SA1 | E5 disagreeing records beyond the two | 2 | 2 | met |
| SA1 | E6 lost theorems of the 68 | 5 | 14 (15 with X25B-PZ) | above |
| SA1 | E7 lane-A "nothing" edges; share false | 6; half | 9; 8 false, 1 reversed | above |
| SA1 | E8 a held result false beyond FS89-CL2 | 0.12 | no in content (wording defects only) | Brier 0.0144 |
| SA1 | E9 an attack on a lane-A composition succeeds | 0.10 | no | Brier 0.01 |
| **SA1, two binary** | | | | **Brier 0.012** |
| SR1 | merge groups one statement or a case | 5 of 7 | 3 of 7 | below |
| SR1 | weakenings derived | 3 | 2 and a refinement | below |
| SR1 | vacuity hyp / no-go / empty / inhabited | 38 / 7 / 6 / 4 | 35 / 4 / 15 / 1 | empties above |
| SR1 | real share of "nothing" edges | 30 % | 23 % (46 % with routes) | below |
| SR1 | seven binary (disagreement settled 0.55 yes; QFREE attack 0.15 no; DOUBLETIP attack 0.15 no; narrower repair 0.25 no; held false 0.22 no; vacuity finished 0.6 yes; inherited 0.30 no) | | | **Brier 0.087** (its own, re-computed) |
| SR2 | merges | 8 (3–15) | 18 | above |
| SR2 | weakenings | 2 (0–5) | 4 | in range |
| SR2 | vacuity misses | 2 (0–6) | 0 | in range |
| SR2 | disagreeing records | 3 (1–8) | 6 | in range |
| SR2 | item 63 answered elsewhere | 4 (1–10) | 1 (8 lines unread; SR3 read them: 3 more) | low |
| SR2 | item 81's three leads and (e) | 0.30, 0.45, 0.10; 0.15/0.15 | not reached by SR2 (SR3 took leads 1–2: lead 1 landed, E2ONE; lead 2 landed, OUTERADJ; lead 3 and (e) went to stubs, unworked) | unscored (SR2's) |
| SR2 | two binary (held false 0.12 no; sweep finished 0.55 yes) | | | **Brier 0.108** |
| SR3 | (a) residues killed | 0.5 (0–2) | 1 (S6) | in range |
| SR3 | (c) answered elsewhere / in place / open | 2 / 2 / 4 | 3 / 3 / 3 | in range |
| SR3 | merges; weakenings; records that disagree | 2; 1; 2 | 3; 3; 5 | above on each |
| SR3 | vacuity additions | 0 | 0 | met |
| SR3 | six binary ((a) kill 0.30 yes; (b) wider V6-ADJ 0.40 yes; (c) false 0.10 no; false 0.08 no; reach all 0.75 yes; (d) simple at `p` alone 0.40 yes) | | | **Brier 0.215** (its own, re-computed) |
| **lane A (OA1, MA1, MA2, SA1), 22 binary** | | | | **Brier 0.102** |
| **lane R (OR1, MR1, SR1, SR2, SR3), 24 binary** | | | | **Brier 0.192** |
| **all readers, 46 binary** | | | | **Brier 0.149** |

**Keryx's priors, noted beside (not scored as a lane's)** — "most of the yield is housekeeping — merges, weaker hypotheses, disagreeing records; a
hit from the arithmetic era on the measurable question is unlikely and would be the most surprising find" (inventory, Registered expectations): the
yield's bulk was indeed merges, weakenings, lost theorems and disagreeing records (SR2 18 merges, SA1 17 merge lines and 15 lost theorems, SR3 5
disagreements); but one result moved the bearing (FS-123's question 1), and the "unlikely" arithmetic-era hit happened (J12, J13, at one mind).

**Reading the scores** (G21's instrument, not a verdict on anyone): the misses run one way where they are large — the probability that a held result
reaches further, or that a step closes, was priced low and landed (OR1's closes and bearing, SR3's three "reach further" questions, Poros's A4 and A5);
the predictions of misses of the FS116-Y4 kind and of new cross-era sites were priced high and did not land (Poros A7, MA1 E4/E8, MA2 E4/E5). This is
the counter-priors' measured direction (`CLAUDE.md` § Counter-priors). Lane R's Brier is twice lane A's because its two largest misses (OR1's close and
bearing) are the audit's two largest results.

## Stage 7 — SAVED: the sweeps

**The plan and the stub, grepped for "conjecture" and "not claimed"** (`grep -n -i "conjecture\|not claimed"` over
`plans/FS129-cross-application-audit.md` and `plans/STUB-cross-application-audit.md`): four hits, none a conjecture or a not-claimed statement —
each names the `not claimed:` field of the block format (plan ll. 37, 53, 98; stub l. 24). **Declined, all four**: field names, no claim to carry.
"conjecture" occurs in neither file.

**Adapted: the 44 FS-129 entries' `not claimed:` lines**, the audit's own nearest-unproved statements, each given a carrier or a decline (read from the
readers' records):

| not claimed (entries) | carried by, or declined |
|---|---|
| the Siamese class (QFREE, QFREE-CLASS, QFREE-NS, EMPTY-NS, BENDLE3, BEND3, DOUBLETIP, OUTERADJ, E2ONE, DISCF-NS) | **FS-123** question 3 (its main question now) and **FS-124** case 7 |
| rings carrying (Q) arcs; "that a vertex with a (Q) ring dies at any radius" (QFREE, QFREE-NS, QFCASE, TOUCHW) | **FS-124** |
| DOUBLETIP's and OUTERADJ's excluded germs on (Q) arcs, two tips, SEMI-PAR3; BEND3's pinned bends; RINGWIND's "that SEMI-PAR3 holds or fails" | **FS-124** case 1 (its bearing now names the pinning caveat) |
| E2ONE: E2 at two or more blades; the E1 residues; E1CAP's wrap | **FS-124** case 6 |
| SIXQ: a fragment with a six-colour vertex beyond 3/2 | **FS-124** case 4 (construction) |
| LOCALDENSE: that the class is inhabited; DISCF-NS's hypothesis | **FS-124** case 8 and the YES side's fragments (FS116-O1-YESLIM) |
| BENDFRAG, BENDANY, WHOLE: anything at radius `√3` or more; saturation kept; other points' rings | **FS-124** (its bearing states the bends' reach); saturation: **FS-125** |
| TOP5: REG-J′₅; the honest existence form at five | **FS-127** (LAT) and the map step at five's carrier — **FS129-P1** (item 26) |
| FALC-RED, OA1-FALC-RED, FALC-11, FALC-19, FALC-RES: the almost-everywhere form | **FS-104** route (0): "it needs Lemma 3 with a positive-measure set of translations, which the 1981 text does not supply (FS103-M § 1.2's table) and the 2005 exposition is reported to" — the 2005 exposition is unread here: a reading debt (report INVENTORY) |
| every fan entry: "that any Falconer fan at five colours exists" | **FS-104** route (b); the finite-witness search is `plans/SEARCH-QUEUE.md` row 3, held for Kooshi |
| FALC-11, FALC-19, FALC-RES: the case `t ≡ a (mod 𝔭)`; HOSTS, FALC-RES: dyadic `U_Q`, `Q ∈ {4, 8, 16}` | search requests already queued (`plans/SEARCH-QUEUE.md` rows 1, 4, 5) |
| NOLIN5, NOAFF5, NOAFF-K, NOAFF-FIELDS: inequalities (format (ii)); degree ≥ 2 identities | **FS-104** route (c) |
| NOPERLAW: pairs forced with probability below 1; near-forcing at a scale | **FS-104** route (b) ("a forced pair whose distance moves continuously") |
| every "anything at `k ≥ 7`" (QFREE, QFREE-NS, EMPTY-NS, DOUBLETIP, OUTERADJ, QFCASE, TOUCHW) | **declined**: the six-map NO is about six colours, and R7 inhabits seven |
| NOAFF-FIELDS: K at `k = 4`; PLACE-HOM: E not purely transcendental; SQRT3-LOCAL: dyadic places where 3 is not a square | **declined**: each is false or uncontrolled as the line says (K's plane carries four-colour forced pairs; G63's Remark-1 caution; ℚ(ζ₇)⁺, ℚ(√7)) |
| CLOSURE: two points of `cl U`; HULLSET: non-compact `C` | **declined**: false (the hexagonal seven-colouring; FS111-C-HULL-SO) |
| SUPK: SUP's second clause at every `k` | **declined**: no consumer reads it (FS106-EQ uses the first clause); for the Lean backlog only if SUP's second clause is formalized |
| TWOCIRC: tiles; RINGBAND: `h` constant across a swap; DISC1TS: a sharper radius; YESLIM-EQ: six with no MR | **declined**: each use adds its own pinning; the swap moves `h` (row 132); no consumer; row 130 already |
| FALC-FAN, DICHO-K, DICHO: the converse | **declined**: false (Harder's 745-point pair at 8/3 over K) |

**§G re-read — adapted (FS-129 had no §G)**: the audit's passes were the re-grokking of the whole corpus. The entries that bore and were not used
before the audit are its table of misses (MA1 § 5.1, MA2 § 4.1, MR1 § Table of misses) and are in the where-else column (stage 3). **Which entry
should have borne at the audit itself and was not used**: G49 (in-house vocabulary hides results from their neighbours, the stub's own precedent) —
its kind recurred three times inside the corpus (CLOSURE proved three times in two eras; the two-circle identity found three times; FS84-S1e re-derived
as NOAFF5 uncited), each found by a row-by-row comparison and none by a mention count; drafted as instances (stage 8), not a rewrite: the retired G49
already names the mechanism.

**§IQ and G79**: G79 — no counterexample: no FS-129 result came from a counterexample invariant alone; QFREE came from a held kill (EMPTY) and a
modification lemma (WHOLE, BENDFRAG) that every bent fragment carries. **§IQ — a partial counterexample, recorded for Poros**: the audit's results came
from the card's existence form ("which held result closes this step?"), step by step, with the structural form serving as a one-line aim before each
step (inventory item 25); the structural form's product — the gap set of steps that need a kind of input no held result delivers — was not tallied by
either pass-1 reader (OR1 never uses the card's phrase; OA1 twice). A result from somewhere other than the structural question, then, with the
structural form as the aiming device; whether that is G72's rule working or bypassed is Poros's to read.

**§PA — recognitions about what the objects are** (each to a drafted grokking or instance, stage 8): (1) **the same lemma in two eras' vocabularies**
(SR2 § 4.4: "most of the extra merges are the same lemma proved in two eras' vocabularies (density sets against open tiles; maps against fragments),
which no pass before this one compared row by row"); (2) **a restriction's class is a question** (OR1 § J1: a round restriction can leave the class an
exclusion quantifies over; the fix is the whole-tile restriction); (3) **a held result reaches its argument's class** (MA1 and MA2's yield, SR3's three
"reach further" landings, MR1's DOUBLETIP: arguments filed at a narrower class than they carry); (4) **row 66 is one mechanism under four grokkings**
(MA1 § 5.2: G13's slack face, G26, G31, G48).

## Stage 8 — SAVED: drafts for the front page

*Written after FS129-Z1's last commit (`a5c4d125`, the report; `plans/FS129-derivation.md` at `3f35c709`, 44 entries, QFREE superseded by QFREE-NS).
Every FS-129 statement quoted below is copied by script from the reader's record (`data/fs129/z2/make_drafts.py`, through
`tools/fs129_z2_stubs.py`'s `stmt()`), so each is verbatim. Grades are as filed: derived, one mind, kernel pending. Current state only.*

## Drafts for the front page

### `LEDGER.md` § A — rows 149–154

**Slot**: `LEDGER.md` § A, the table, directly after row 148 (the row beginning "| 148 | **In non-Siamese simple valid six-coloured fragments, a vertex of
at least four colours whose unit circle carries no arc of the boundary …"). Six new rows; the bundle of merges and weakenings that earns no row of its
own (SUPK, HULLSET, CLOSURE, YESLIM-EQ, SIXQ, RINGBAND, TOUCHW, SQRT3-LOCAL) stays in `plans/FS129-derivation.md`, the theorem record (Workflow 3.1).

| # | Result | Where | When |
|---|---|---|---|
| 149 | **In non-Siamese valid six-coloured fragments, simple or not, a vertex of at least four colours whose unit circle carries no (Q) arc — no arc of the boundary whose two side colours the vertex carries — exists on no disc of radius above 1 about it:** "no non-Siamese valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has a ring carrying no (Q) arc" (FS129-SR3-QFREE-NS). The step is FS-112's bends read on a fragment: on the whole-tile restriction of radius at most `√3` — the tiles meeting the open disc, each with its whole closure — "let F be a valid k-coloured fragment, for any k ≥ 1, on a closed disc B̄(p, r), r > 1, about a point p, and let 1 < ρ′ < min(r, √3); then there is a valid k-coloured fragment F″ on B̄(p, ρ′), with the same colours carried at p as in F, whose arcs of Γ on ω(p) are exactly the arcs of Γ on ω(p) in F both of whose side colours are carried at p, so that Γ ∩ ω(p) in F″ is those arcs and finitely many points; its tiles are the tiles of F meeting B(p, min(r, √3)), each unchanged except the two side tiles of each other ring arc, which differ from F's only inside lenses, as thin as wished, along that arc; and F″ is non-Siamese if F is, and simple if F is" (FS129-SR1-BENDANY, at any `k`; FS129-OR1-WHOLE), while a round restriction can cut one tile into a Siamese pair; so in each class the exclusion of rings with no arc of the boundary gives the (Q)-free one (FS129-OR1-QFREE-CLASS), and row 148's exclusion holds without simplicity, since FS116-V6's route never reads it (FS129-SR3-EMPTY-NS). FS-123's first question is answered yes; the classes of FS114-N7-3T, -N7-HUB and -N6-RING60 are empty there; FS116-S1-QF, the saturated straight cross of row 146, is a case (FS129-SR2-QFCASE). [hand], one mind, kernel pending (FS129-SR1's attacks on the chain's two named steps found no gap — checking readings, not second minds). **Not claimed:** the Siamese class (FS-123's question now); rings carrying a (Q) arc (FS-124); anything at seven colours or more. **Prior art:** owed; the bends are FS-112's moves (FS112-N2-RED, on maps), their reading on a fragment not searched. | `plans/FS129-derivation.md` (FS129-SR3-QFREE-NS, -EMPTY-NS; FS129-OR1-QFREE-CLASS, -WHOLE, -QFREE; FS129-SR1-BENDANY; FS129-SR2-QFCASE); `plans/FS129-OR1-audit.md` § J1; `plans/FS129-SR3-audit.md` § 2; `tools/fs129_or1_lens.py`, `tools/fs129_sr3_simple.py` | FS-129 (2026-10-03) |
| 150 | **The (Q)-ring case list, pruned: two change points 60° apart on a four-colour vertex's ring whose far germs lie off (Q) arcs share neither a sole tip nor a sole outer colour, and one pinwheel residue is empty.** "in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) and y′ = r(ψ + 60°) be change points of the ring of p such that neither the arc of ω(p) just clockwise of r(ψ − 60°) nor the arc just counter-clockwise of r(ψ + 120°) lies on a (Q) arc; then no tile of p is at once the only tile of p whose closure holds y and the only tile of p whose closure holds y′" (FS129-MR1-DOUBLETIP); "in a non-Siamese valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) and y′ = r(ψ + 60°) be change points of the ring such that neither the arc of ω(p) just counter-clockwise of r(ψ − 60°) nor the arc just clockwise of r(ψ + 120°) lies on a (Q) arc; then no colour of p is at once the only colour carried at y by a tile that is not a tile of p and the only colour carried at y′ by a tile that is not a tile of p" (FS129-SR3-OUTERADJ, no simplicity); "in a non-Siamese simple valid fragment containing a neighbourhood of the closed unit disc about p, with a pinwheel at p, no edge at p of length 60° (no E1) and E2 at exactly one blade t_{c+1}, the pocket colours satisfy m_{c−1} ≠ m_c; hence POCKET at w_c and CASE at q_c hold, and no such pinwheel exists at radius 1 + ε; in particular FS114-Y6-E2RED's survivor family S6, (120°, b, 180° − b, 60°), has no member" (FS129-SR3-E2ONE). Behind them, and behind FS114-Y5-PXKILL, FS116-V6-HUG, -V6-ADJ and FS116-Y4-FLANK, one identity: `|a(s) − b(t)|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2) = 2(1 − cos s)(1 − cos t) − 2 sin s sin t` for the points reached by turning about two unit-distance centres toward a common unit neighbour (FS129-SR1-TWOCIRC). [hand], one mind each, kernel pending. **Not claimed:** SEMI-PAR3; germs on (Q) arcs; the Siamese class; E2 at two or more blades and E1's residues. **Prior art:** owed; the identity is held in-house since FS-114 (FS114-YB4-2ND). | `plans/FS129-derivation.md` (FS129-MR1-DOUBLETIP, FS129-SR3-OUTERADJ, -E2ONE, FS129-SR1-TWOCIRC); `plans/FS129-MR1-audit.md` § Stage 2; `plans/FS129-SR3-audit.md` §§ 1.3, 3.1; `tools/fs129_mr1_doubletip.py`, `tools/fs129_sr3_outeradj.py`, `tools/fs129_sr3_e2one.py`, `tools/fs129_sr1_twocirc.py` | FS-129 (2026-10-03) |
| 151 | **A slack residue target kills every linear identity on a colouring, at every number of colours:** "let k ≥ 2, let ρ : G → T be a graph homomorphism, and let φ_v : Fin k → ℝ (v a vertex of G) be functions, all but finitely many identically zero, such that Σ_v φ_v(C(v)) takes one value b on every proper k-colouring C of G; then φ_u is constant for every vertex u of G such that some proper k-colouring of T leaves a colour absent from the closed neighbourhood of ρ(u); and if every vertex of T has such a colouring, every φ_v is constant and b is the sum of their values" (FS129-SA1-NOAFF-K, row 66's single-vertex repaint at any target). Over fields: "let F ⊆ ℝ be a number field, E = F(t₁, …, t_n) ⊂ ℝ with t₁, …, t_n algebraically independent over F (n ≥ 0), and H ⊂ E² a finite unit-distance graph; suppose k = 5 and F has a usable prime of residue field 𝔽₁₁ or 𝔽₁₉ or χ(F²) ≤ 4, or k = 4 and F has a usable prime of residue field 𝔽₇ or χ(F²) ≤ 3; then for every family of functions φ_v : Fin k → ℝ (v a vertex of H) with Σ_v φ_v(C(v)) taking one value on every proper k-colouring C of H, every φ_v is constant" (FS129-SA1-NOAFF-FIELDS, through G63's place `t ↦ 0` with the residue map, FS129-SA1-PLACE-HOM). So FS-104 route (c)'s linear-identity format (G75's annihilator) is empty over those fields. [hand], one mind, kernel pending. **Not claimed:** inequalities (three- and four-point positivity); identities of degree two or more; fields with no such prime and `χ(F²) ≥ k`. **Prior art:** partly — the four-colour form is FS84-S1e (2026-09-25, in-house); a gapped vertex is a non-frozen one (`[BrewsterEtAl2020]`); the field form owed. | `plans/FS129-derivation.md` (FS129-SA1-NOAFF-K, -NOAFF-FIELDS, -PLACE-HOM; superseded FS129-OA1-NOLIN5, FS129-MA1-NOAFF5); `plans/FS129-SA1-audit.md` § 2; `tools/fs129_sa1_family.py`, `tools/fs129_ma1_noaff.py` | FS-129 (2026-10-03) |
| 152 | **Falconer's fan, at every number of colours, and where a five-colour fan can live; route (b)'s literal reading is empty.** "if a finite unit-distance graph H ⊂ ℝ² has a Falconer fan at k colours with apex a and tip t, |t − a| = r > 1/2, and arcsin(1/(2r))/π irrational, then every cover of ℝ² by k measurable sets has two points at distance 1 inside one of the sets, so χ_m(ℝ²) ≥ k + 1 for Falconer's everywhere-proper measurable chromatic number" (FS129-SA1-FALC-RED; `[Falconer1981]` Lemmas 1–4 checked against the paper). "let F ⊆ ℝ be a number field, E = F(t₁, …, t_n) ⊂ ℝ with t₁, …, t_n algebraically independent over F (n ≥ 0), and H ⊂ E² a finite connected unit-distance graph with apex a and tip t forming a Falconer fan at five colours; then (i) χ(F²) ≥ 4, and F has no usable prime of residue field 𝔽₇; (ii) for every usable prime 𝔭 of F of residue field 𝔽₁₁ or 𝔽₁₉, with V and φ as in FS129-SA1-PLACE-HOM at 𝔭, t − a has coordinates in V and φ(t − a) = 0" (FS129-SA1-FALC-RES; with FS129-SA1-FALC-FAN and -FALC-DICHO-K: a fan at `k` colours has `χ(H) ≥ k − 1`, and at `χ(H) = k − 1` gives apex and tip one colour). Over ℚ(√59), ℚ(√83), ℚ(√131) a five-colour fan forces `t − a ∈ R ∩ 𝔓⁴` and every four-colouring of the plane periodic (FS129-MA2-FALC-HOSTS (iv)), so one such fan would settle row 88's question. And "for a stationary random colouring c of ℝ², continuous in probability and proper almost surely on every unit pair, the set Z of vectors x with c(0) = c(x) almost surely is a discrete subgroup of ℝ²; if the law of c is rotation-invariant, Z = {0}" (FS129-OA1-NOPERLAW). [hand], one mind each, kernel pending. **Not claimed:** that any Falconer fan at five colours exists; the almost-everywhere form (it needs a positive-measure set of translations, which the 1981 text does not supply); anything for `χ(ℝ²)` without MR. **Prior art:** `[Falconer1981]` for the mechanism; the fan family and NOPERLAW owed. | `plans/FS129-derivation.md` (FS129-SA1-FALC-RED, -FALC-FAN, -FALC-DICHO-K, -FALC-RES, FS129-MA2-FALC-HOSTS, FS129-OA1-NOPERLAW); `plans/FS129-MA1-audit.md` § 2; `plans/FS129-OA1-audit.md` § 2.3; `tools/fs129_oa1_falconer_fan.py`, `tools/fs129_ma1_falcfan.py`, `tools/fs129_ma2_fangap.py` | FS-129 (2026-10-03) |
| 153 | **A local density lemma for fragments, and DISC-F from the local exclusion in the non-Siamese simple class:** "every valid six-coloured fragment on a closed disc B̄(x, 3) has, in B̄(x, 3), a vertex of at least four colours or a vertex with a repeated colour" (FS129-OR1-LOCALDENSE, FS112-N3-DENSE3 read on a fragment; possibly vacuous — no fragment on a disc of radius 3 is held); "if for some R > 0 no non-Siamese simple valid six-coloured fragment exists on a closed disc of radius R about a vertex of at least four colours, then no non-Siamese simple valid six-coloured fragment exists on any closed disc of radius R + 3" (FS129-OR1-DISCF-NS). [hand], one mind, kernel pending. **Not claimed:** the Siamese or non-simple form (there the repeated-colour alternative is not covered by C114-LOCAL-F and needs GS-4's density form, FS-115); that the vertex found has four colours. **Prior art:** owed. | `plans/FS129-derivation.md` (FS129-OR1-LOCALDENSE, -DISCF-NS); `plans/FS129-OR1-audit.md` § J19 | FS-129 (2026-10-03) |
| 154 | **The map step at five, as an equivalence:** "if REG-J′₅ holds — FS111-M-REDUCE-I's regularity hypothesis at five colours, a saturated colouring whose singular set Σ is locally finite with finitely many interface arcs at each point of Σ — then the honest existence form of C-SAT-T at five (every tight a.e.-proper five-colouring can be modified, keeping it a.e.-proper with five colours, into an honest saturated one; FS121-SAT6's k = 5 clause) holds if and only if χ_m⁰(ℝ²) ≥ 6, the forward direction at FS106-AE-MAP6's grade (modulo Townsend's simplification (c))" (FS129-OR1-TOP5). [hand], one mind, kernel pending. **Not claimed:** REG-J′₅ (FS-127); the honest existence form at five; anything at six. **Prior art:** owed. Which stub carries the map step at five is the re-rank's. | `plans/FS129-derivation.md` (FS129-OR1-TOP5); `plans/FS129-OR1-audit.md` § J10 | FS-129 (2026-10-03) |

**And row 121, its "Where" column** (current state: the result's inputs now have entries). Slot: `LEDGER.md` § A row 121, the Where cell; **append**
"; `plans/FS84-SI-D-derivation.md` (J45-N1, -N2, -SI-4, -SI-5, -SI-J, -SI-C, -SP-oi, -SP-if — the inputs FS100-Q47's grade names, filed as entries by
FS129-Z1)". Why: FS129-SA1 found row 121's lower half resting on eight J45 statements with no entry (inventory item 110); FS129-Z1 filed them; the Lean
backlog's closure for FS100-Q47 reads them.

### `CLAUDE.md` § Frontier

**1. The "Last updated" line.** Slot: § Frontier, the italic paragraph beginning "*Last updated: 2026-10-03 — **Workflow 3.1**:"; replace the words from
"Last filed: **FS-116," to the end of the paragraph ("…and git.*") with:

> Last filed: **FS-129, the cross-application audit**, Derived (rows 149–154; `plans/FS129-derivation.md`, 44 entries, each derived, one mind); before
> it **FS-116, the local exclusion**, and **FS-121, the map step**, both closed undecided (rows 142–148). Earlier closes: `plans/FRONTIER-STUBS.md`'s
> closed list, and git.*

**2. The open-milestones line.** Slot: § Paths forward, ranked, the paragraph beginning "**Open milestones.** **FS-129, the cross-application audit**, is
Opened"; replace the words from "is Opened" through "then the top of the ranking." with:

> is Derived (`plans/FS129-derivation.md`, 44 entries; rows 149–154; the index corrected and given its where-else column, `data/fs129/index/`); it is
> Closed when its compositions pass the Lean gate, in the Lean backlog's session. **Next, in Kooshi's order** (2026-10-03): **the Lean backlog**, in a
> session of its own — the hand results of the milestones closed before Workflow 3.1, with FS-129's compositions and merged forms, from the input FS129-L1
> writes (`plans/LEAN-BACKLOG.md`, on `data/fs129/index/lean-order-corrected.md`) — formalized before the pipeline continues; then the top of FS129-P1's
> ranking.

(The sentence on M63 and M62 that follows stays as it is.)

**3. Item 31 of "Where the problem stands", in full.** Slot: § Where the problem stands, the numbered item beginning "31. **The regularity wall,
verified;" through its last sentence "…now a case list (FS-123–FS-125)."; replace the whole item with:

> 31. **The regularity wall, verified; the question is stability; at bounded complexity, one four-colour vertex** (§ The aim; rows 131–154; FS-117,
>    FS-120, FS-122–FS-128, FS-130). Regular classes need seven almost everywhere — slack, polygons, convex tilings, nice maps — and maps six; closed
>    classes are the tight question itself. With no MR, `χ_m⁰ ≥ 7` ⟺ `lim µ₆(ε) < 1` (row 131). At bounded complexity that is whether a tight six-map
>    exists (row 133): under Condition 5 none does (row 134); with unit arcs every one has a vertex of at least four colours (rows 135, 137), so one
>    exclusion at an explicit radius, above `φ²/√2`, about such a vertex suffices for the NO; where the count gives six room the configurations die at
>    `√3` or `1 + ε` but for named cases, and both printed positives are part of no such map (rows 136, 138). FS-116 and FS-129 (rows 145–150, 153):
>    valid fragments on discs of every radius give `χ(ℝ²) ≤ 6` with no MR, so that exclusion decides both ways; in the non-Siamese class, simple or not,
>    a four-colour vertex whose ring carries no (Q) arc dies at `1 + ε` (row 149: FS-112's bends, run on a whole-tile restriction of radius at most `√3`,
>    keep the class and leave only (Q) arcs); the ring's change points off (Q) arcs are four-colour vertices, and two of them 60° apart whose far germs
>    lie off (Q) arcs share no sole tip and no sole outer colour (row 150); in the non-Siamese simple class DISC-F follows from the exclusion (row 153);
>    open: (Q) rings (SEMI-PAR3, the disk's corner, crossed reciprocity, the recurrence, FS114-K1's residues), five- and six-colour vertices, the
>    saturated cross on rings with (Q) arcs, Siamese fragments. The doors are two routes, not halves (row 139, two minds): seven is the NO's hole bound
>    made uniform in the complexity bound, so FS-114's NO reaches it only through the map step — or through route R's forced pair, where the NO is idle —
>    and each is the answer restated; route M's rungs hold down to the pinch at a junction (rows 140–141; FS-120–FS-122). On route M's map step (rows
>    142–144), at every `k`: honest saturated ladders end inward at (Q) or (R2) arcs and never outward, periodic classes have only segments and (Q) arcs,
>    and honesty is free; what is open is curved tangent interfaces (one question for three claims), the singular set at lateral extent, and the top
>    colour at six, the last the answer restated given a NO; at five, given REG-J′₅, the honest existence form of C-SAT-T is equivalent to
>    `χ_m⁰(ℝ²) ≥ 6` (row 154). FS-104's routes (b) and (c) are narrowed from the arithmetic era: a slack residue target kills linear identities and
>    confines Falconer fans, and route (b)'s literal reading is empty (rows 151–152). Bearing on the answer: no value moved; of door (A)'s local
>    statement the (Q)-free half is closed in the non-Siamese class, and what is left is a case list — the Siamese (Q)-free ring (FS-123), the (Q) rings
>    and many-colour vertices (FS-124), the saturated class (FS-125).

**The theory paragraph** (§ Grokkings, "The theory in one paragraph") — one sentence to replace, so the paragraph is current. Slot: the sentence "such a
vertex whose ring carries no boundary arc dies at `1 + ε` in the non-Siamese simple class (row 148, G91; [hand], two minds)."; replace with: "such a
vertex whose ring carries no boundary arc dies at `1 + ε` in the non-Siamese simple class (row 148, G91; [hand], two minds), and one whose ring carries
no (Q) arc in the non-Siamese class, simple or not (row 149; [hand], one mind)."

### Registered predictions, scored

The table is § Stage 6 above (one table; Brier per registrant, per lane, pooled; Keryx's priors beside). For the close record: Poros's six binary
predictions, Brier 0.374 (A4 and A5 met, both priced low); the readers' 46 binary predictions, Brier 0.149 (lane A 0.102, lane R 0.192).

### `plans/GROKKING-INSTANCES.md` — new instances of existing entries

**Slot 1**: § G49 — The prior-art gate, appended at the end of the section (after its last instance):

> *FS129-Z2, FS-129's record; the mechanism inside the corpus, found by row-by-row comparison and by no mention count:* **one lemma proved three
> times, in two eras** — FS106-DIAM (iii), FS111-V0-CLOSE and FS116-V5-NE1's first clause are FS129-SR2-CLOSURE (`plans/FS129-SR2-audit.md` § 2.2);
> **one law found three times** — the two-circle identity at FS114-YB4-2ND (FS114-Y5-PXKILL's pair), at FS116-V6-HUG and -V6-ADJ, and at FS116-Y4-FLANK's
> least-curved case, one lemma as FS129-SR1-TWOCIRC (`plans/FS129-MR1-audit.md` § Mechanism 3a; Kooshi's "where else can we use that identity?",
> `plans/FS116-close-inventory.md` item 142); **one theorem re-derived uncited** — FS84-S1e (2026-09-25) is the four-colour form of FS129-MA1-NOAFF5
> (`plans/FS129-SA1-audit.md` § 4.2); **three GAPs answered elsewhere with no link back** (FS111-M-PINCH l. 442, FS112-SIX l. 49, FS116-S1-KAPPA l. 816;
> `plans/FS129-SR3-audit.md` § 4.1), and FS110-A3-HOLE's (`plans/FS129-MR1-audit.md` lead (a)). FS129-SR2's reading, verbatim: "most of the extra merges
> are the same lemma proved in two eras' vocabularies (density sets against open tiles; maps against fragments), which no pass before this one compared
> row by row".

**Slot 2**: § G83 — With unit arcs, the tight question lives at one four-colour vertex, appended after FS116-Z2's instance:

> *FS129-Z2, FS-129's record; `plans/FS129-MR1-audit.md` § Table of misses, verbatim:* "G83's straddle / V6-HUG's argument | FS-124 ring types with two
> adjacent change points sharing a sole tip … | composition (an instance filed where the class was carried) | the double tip dies at `1 + ε` on every
> ring when the two outer tip germs are off (Q) arcs | yes — FS129-MR1-DOUBLETIP". The straddle held, its argument carried a wider class than its
> statement named (rings with no arc of `Γ`), and it was carried there only by the audit — FS116-Y4's pattern, one milestone later.

**Slot 3**: § G87 — The invention signal, appended at the end of the section:

> *FS129-Z2, FS-129's record:* both collisions on file dissolved into scope defects, with no side picked first. FS-116's bends signal: side 1 holds for
> the whole-tile restriction of radius at most `√3`, side 2 for maps — "the two sides are about a map and a fragment and do not contradict"
> (`plans/FS129-SR1-audit.md` § 2.3); its repair, read on the definition of a tile, closed FS-123's first question (FS129-OR1-QFREE). Poros's route-R
> signal: "side 1 is a stub's bearing sentence whose conclusion exceeds its reason" — a Condition-5 theorem stated without Condition 5
> (`plans/FS129-OR1-audit.md` § J15).

### Proposed grokking G92 (G67's form)

**Slot**: `.claude/skills/grokkings/SKILL.md`, after G91, as a new entry.

> * **G92 — A held result reaches as far as its argument, not as far as its statement. [method; FS-129, one audit; new, untested]** Measured on the
>   audit of 2026-10-03: the mechanism and merge passes found most of their yield by reading a held composition at the class its argument carries —
>   NOLIN5 to NOAFF5 to NOAFF-K (any target, any `k`), FALC-11 to FALC-T to FALC-FAN, the double tip from Γ-free rings to every ring with outer germs off
>   (Q) arcs (DOUBLETIP), FS106-SUP from six to every `k` (SUPK), EMPTY and QFREE without simplicity (EMPTY-NS, QFREE-NS); the three "does a held result
>   reach further?" questions FS129-SR3 priced below even all landed (`plans/FS129-SR3-audit.md` § 5.2), while predictions of new sites and of misses of
>   the FS116-Y4 kind, priced high, did not (`plans/FS129-Z2-record.md` § Stage 6). The cause is the filing: a result is stated for the milestone that
>   needed it, so its hypotheses name that milestone's class (simple, Γ-free, five colours, a residue field 𝔽₁₁) whether or not its argument reads them.
>   *Do: before applying or citing a held result, read its `uses only:` line, list the hypotheses its argument never consumes, and restate it without
>   them before asking where else it bears; trigger: a statement whose class names a property its proof does not use, or a second milestone about to
>   re-derive a near neighbour.* Killing test: a pass in which the restated (widened) forms fail on attack more often than they hold — then the
>   statements were tight and the reach was not there.

### Bibliography

Checked against every section of `BIBLIOGRAPHY.md` (`grep -c "\[<key>\]"`): every key the FS-129 records cite — `[AldousLyons2007]`,
`[AmbrusEtAl2023]`, `[AngelHutchcroftNachmiasRay2018]`, `[BrewsterEtAl2020]`, `[Croft1967]`, `[ExooIsmailescu2019]`, `[Falconer1981]`, `[Fischer1990]`,
`[Polymath2021]`, `[Soifer2024]`, `[SokolovVoronov2025]`, `[Voronov2023]`, `[Zhang2012]` — is defined. **No new row is drafted.** One change to an
existing row, drafted because it changes the row: `[Falconer1981]` (`BIBLIOGRAPHY.md` l. 169), its "what of ours rests on it" cell gains "FS129-SA1-FALC-RED
and the fan family (FS129-SA1-FALC-FAN, -FALC-DICHO-K, -FALC-RES); Lemmas 1–4 and Theorems 1–2 checked against pp. 185–187 by FS129-MA1 (§ 2.1)".
A reading debt, not a row: the "2005 exposition" said to give Falconer's Lemma 3 with a positive-measure set of translations (`plans/FS103-M-derivation.md`
§ 1.2's table; FS129-OA1-FALC-RED's not-claimed line) is unidentified here — the almost-everywhere form of route (0) waits on it.

### Proof Atlas facts — `tools/viz_proof_atlas_facts.py`

**Slot**: after the node `N("GFREE", …)` and its edge `E("GFREE", "LOCALF", …)` in the "seven" sector; filed after rows 149–154, since each quote is a
filed row's words. Positions are provisional (the filer places them).

```python
N("QFREE", "the (Q)-free vertex dies at 1 + ε", "nogo", "A four-colour vertex whose unit circle carries no (Q) arc has no valid six-coloured "
  "fragment, non-Siamese, simple or not, on any disc of radius above 1: FS-112's bends, read on a fragment, leave only (Q) arcs.", L(149),
  "no non-Siamese valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has a ring carrying no (Q) arc",
  "[hand], one mind, kernel pending", at=(57, 520), sector="seven")
E("GFREE", "QFREE", "rests", L(149), "the exclusion of rings with no arc of the boundary gives the (Q)-free one", label="the bends")
E("QFREE", "LOCALF", "context", L(149), "FS-123's first question is answered yes", label="the (Q)-free half removed")
N("QPRUNE", "(Q) rings pruned", "held", "On a four-colour vertex's ring, two change points 60° apart whose far germs lie off (Q) arcs share no sole tip "
  "and no sole outer colour; one pinwheel residue is empty.", L(150),
  "The (Q)-ring case list, pruned", "[hand], one mind each, kernel pending", at=(40, 540), sector="seven")
E("QPRUNE", "LOCALF", "context", L(150), "The (Q)-ring case list, pruned", label="pruning rules")
N("TOP5", "the map step at five", "held", "Given REG-J′₅, the honest five-colour existence form is equivalent to χ_m⁰(ℝ²) ≥ 6.", L(154),
  "The map step at five, as an equivalence", "[hand], one mind, kernel pending", at=(150, 430), sector="six-up")
```

### Differences from FS129-Z1's file

None that changes a statement. Two placements differ from Z1's prose, by design: FS-123's re-aim is drafted as a banner for Keryx (stage 4) rather
than left in DOUBLETIP's and QFREE-NS's prose; and the O1-OUT analogue for valid maps is placed in FS-115's bearing (stage 4), where Z1's § 5.3 left it
open between FS-126 and FS-115.
