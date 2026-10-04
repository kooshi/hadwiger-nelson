# Brief FS129-Z2 — the record job, part 2: the stubs, the index's corrections and its where-else column, the scored predictions, and the drafts of the front page

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS129-Z2
  identity: Ephodos, the deriver, read as files — `.claude/skills/ephodos/SKILL.md` in full, then `.claude/agents/ephodos.md` from its line `# Ephodos in lean-dir — the workflow` to its end; its `## The record job` is your job, split in two
  role: part 2 of FS-129's record job — new and re-aimed stubs, the index corrected and given its where-else column, every registered prediction scored, dated notes on non-derivation records, and the drafts of the front page
  launch: now, beside FS129-Z1 (part 1: `plans/FS129-derivation.md`, the lost theorems, the errata to derivation files) and the day's Searcher; draft the front page only after Z1 has committed the derivation file
  mission: § Why this job
  statements: § What Kooshi asked
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in FS-129 is blind (Workflow 3.1)
  channel: message the coordinator ("main") by SendMessage only for a question you cannot work around or a finding that cannot wait; the report goes to `data/fs129/reports/FS129-Z2.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Rule 1 matters more for you than for most: you are a general-purpose agent and carry the Agent tool, which the lane agent files withhold
  record: `plans/FS129-Z2-record.md`
  touches: `plans/FS129-Z2-record.md`, `plans/STUB-*.md` (new stubs; in open stubs, the provisional-bearings line, the "Bearing on the answer" section and dated correction notes only — never Poros's question sections, never a banner), `data/fs129/index/` (new files, and the where-else column added to `data/fs129/index/theorems.jsonl`), `plans/FS114-NB5-verification.md`, `plans/FS114-NB6-verification.md`, `plans/FS114-N7-proof.md`, `plans/FS116-Y4-construction.md`, `plans/FS116-local-exclusion.md` (dated notes appended only, the original standing), `data/fs129/z2/`, `tools/fs129_z2_*.py`, `data/fs129/reports/FS129-Z2.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 550k — a successor continues from your record

Hello. You are writing the second half of FS-129's record: what the audit changes outside its own derivation file. Kooshi asked the audit to
find where each result bears, to interweave and strengthen, and to find new paths; your stubs are the new paths, your where-else column is
the first deliverable of his request, your scored predictions say how well the audit's minds knew their ground, and your drafts are how
the front page will read once Keryx files them. Part 1 (FS129-Z1) is writing `plans/FS129-derivation.md` beside you; you do not write it.

## Why this job

The plan, `plans/FS129-cross-application-audit.md`, § 3's Stage 5, and the stub's § Deliverables (`plans/STUB-cross-application-audit.md`)
set what the record must hold: "For each novel lemma and theorem, where else it applies, with addresses"; the compositions (Z1's); the
strengthenings; and "New stubs for the new paths, ranked by Poros" (Poros ranks them next, in FS129-P1; you write them). The inventory,
`plans/FS129-close-inventory.md` (items 1–134), is your worklist: every line routed "for FS129-Z2", "for FS129-Z1 (bearing lines)", or naming a
stub, a note or a score is yours, and its source is your evidence. Read every number from its source, never from the inventory line — its own
receipts have been wrong (items 19, 99, 107).

## What Kooshi asked

> Right after this close, we'll be refining the workflow again... then I think it might be worth an audit of all previously novel lemmas and theorems in this project, to see where they can be applied across all others, interweaving and strengthening what we have, and potentially finding new paths. File that as a special case stub for after the workflow refinements.
> — source: plans/STUB-cross-application-audit.md § The request

> Also a note for the whole plan that not only are "hubs" important, but deep "roots", where a long chain of theorems starts, even if it has only one offshoot
> — source: plans/FS129-cross-application-audit.md § 1. Kooshi's words

## Who you are, and how to load it

You are a `general-purpose` agent, by Kooshi's decision 2. Read `.claude/skills/ephodos/SKILL.md` in full, then `.claude/agents/ephodos.md`
from its line `# Ephodos in lean-dir — the workflow` to its end; its `## The record job` describes the job — you do "Stubs", "What you draft for
Keryx" and "The sweeps". Read a grokking by number when you need it —
`awk '/^\* \*\*G83 —/{p=1;print;next} /^\* \*\*G[0-9]+ —/{p=0} p' .claude/skills/grokkings/SKILL.md`.

## What you work from

- **The readers' records and reports**: `plans/FS129-OA1-audit.md`, `plans/FS129-OR1-audit.md`, `plans/FS129-MA1-audit.md`,
  `plans/FS129-MA2-audit.md`, `plans/FS129-MR1-audit.md`, `plans/FS129-SA1-audit.md`, `plans/FS129-SR1-audit.md`, `plans/FS129-SR2-audit.md`,
  `plans/FS129-SR3-audit.md`, with `data/fs129/reports/`; Poros's card record `plans/POROS-2026-10-03-fs129-card.md` and the demand list
  `data/fs129/demand-judged.md`; Z1's record `plans/FS129-Z1-record.md` and `plans/FS129-derivation.md` once committed.
- **The index**, `data/fs129/index/` (its `data/fs129/index/README.md` and CHECK lists), and the edge sorts: `tools/fs129_sr1_edges.py`,
  `tools/fs129_sr2_cycles.py`, and SA1's lane-A sort (`plans/FS129-SA1-audit.md` § 4.3). `tools/fs129_index.py` is another job's tool: do not edit
  it; write your corrections as `tools/fs129_z2_*.py`, which reads the index and writes corrected files beside it.
- **The day's Searcher** may report while you work (`plans/SEARCH-QUEUE.md` rows 1, 2, 4, 5): the coordinator will relay its results; fold any
  that settle an exception into the drafts and stubs.

## Done means

1. **Stubs** (the stub rule, `CLAUDE.md` § The pipeline: full context, a fresh mind can plan from it): a new stub for each new path the audit
   surfaced that no open stub carries — at least the two new derivations item 120 sent to stubs (a coupling of two circles' windings for
   FS106-BIKE; an O1-OUT for valid maps, with item 101), unless you place each in an open stub instead, saying why; and in open stubs, the
   bearing lines and dated correction notes items 28, 42, 58, 60, 80, 82, 87, 101, 117, 129 and 133 call for. Poros writes question sections and
   ranks; Keryx files banners (FS-123's first question is answered — draft its banner for Keryx, do not write it).
2. **The index corrected**, by a script with a planted fault: the false and reversed edges dropped and the route edges marked (items 77, 99, 111,
   118: SR1's 26, SR2's 23, SA1's lane-A 9 and its two correction edges into FS89-CL2); the milestone-prefix and range-citation defects of item
   111 fixed or listed; corrected `edges`, `hubs`, `roots`, `cycles`, `lean-order` and `vacuity` files written beside the originals with a
   `-corrected` suffix; the README's notes (item 90's homonyms; item 132's fault-run file; the withdrawn figures). Report the corrected counts.
3. **The where-else column**: for each theorem in `data/fs129/index/theorems.jsonl` that an FS-129 reader found bearing somewhere else — a
   composition, a merge, a miss, a stronger form held — a field `where_else` listing each site with its address. Built by a script from the
   readers' tables of misses, merge lists and entries, with a count per lane in your record.
4. **Dated notes** on the five non-derivation records in `touches:` (items 59, 96), each sourced, the original left standing.
5. **Every registered prediction scored**, in one table in your record: Poros's A1–A7 (item 23), each reader's registration (items 47, 64, 73,
   84, 92, 102, 114, 122, 133), with Brier where binary; Keryx's priors (the inventory's top) noted beside, not scored as a lane's.
6. **`## Drafts for the front page`**, after Z1's file is committed, each draft naming its slot (file, section, exact words it replaces or
   follows): `LEDGER.md` rows from **149** (graded "[hand], one mind, kernel pending" or as derived); `CLAUDE.md` § Frontier — the "Last updated"
   line, the open-milestones line, and item 31 of "Where the problem stands" in full, rewritten to current state (the (Q)-free ring closed in the
   non-Siamese class, simple or not); new instances of existing grokkings for `plans/GROKKING-INSTANCES.md` (one law found three times, one lemma
   proved three times — G49's kind — and others you find); any proposed grokking from **G92**, in G67's form; bibliography rows not yet filed,
   checked against every section of `BIBLIOGRAPHY.md`; Proof Atlas facts for `tools/viz_proof_atlas_facts.py`. Current state only (`CLAUDE.md`'s
   head): no narration, no dated amendments.
7. **The sweeps** your identity's record job names, adapted — FS-129 has no §G; grep the plan and the stub for "conjecture" and "not claimed",
   and give each hit a stub or a decline.
8. **`plans/FS129-Z2-record.md`** in saved stages, with the heading "Theorems this phase proved" (none expected — say so), and **your report** in
   standing rule 11's form.

## What is yours to decide

Which candidates deserve their own stub and which a line in an open one; the where-else column's encoding; the order of the work (drafts
last). If a draft would state more than its source carries, state less and say so. If you find an entry of Z1's that you would draft
differently, draft from the source and report the difference; never edit Z1's file.
