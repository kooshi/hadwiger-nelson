# FS129-Z1 — the record job, part 1: FS-129's derivation file, the lost theorems, the errata

*Job FS129-Z1 (2026-10-04, from 01:21 UTC), a `general-purpose` agent on Opus reading the deriver's identity (`.claude/skills/ephodos/SKILL.md`,
then `.claude/agents/ephodos.md` from "# Ephodos in lean-dir — the workflow"). Brief: `data/fs129/briefs/FS129-Z1-record.md`, with
`plans/STANDING-RULES.md`. I write `plans/FS129-derivation.md`, dated entries and errata appended to earlier `plans/*-derivation.md` files,
`data/fs129/z1/`, this record and `data/fs129/reports/FS129-Z1.md`. No agent of my own (standing rule 1).*

## Theorems this phase proved

None. The record job files what FS-129's readers derived and derives nothing new; no statement was re-derived. Two record-job notes judge an
argument against its own sources without re-deriving it (FS129-SR2-QFCASE's reading of "simple"; FS129-SR1-BENDLE3 and FS129-SR1-RINGBAND as
merged forms): § Stage 2, the notes.

## Stage 1 — SAVED: readback, quotation check, the worklist

### 1.1 Readback

FS-129 is the cross-application audit Kooshi asked for (`plans/STUB-cross-application-audit.md` § The request). Eight reader jobs in two lanes
(A, the arithmetic era through FS-103; R, the regularity-wall era from FS-104) and three passes (open steps; mechanisms; merges and strengthening)
derived 40 entries. My job is the first half of the record job: (1) `plans/FS129-derivation.md` with every one of those entries, in its strongest
merged form, superseded forms kept and marked, each with what rests on it and a short head section; (2) the fifteen lost theorems of inventory item
110 and X22D-FLK2 (item 113), each filed in its milestone's derivation file under its original id, statement verbatim from where SA1 found it,
grade and minds as the source gives them; (3) dated errata under the earlier entries the audit found wrong in wording (items 78, 96, 108, 117),
the original text left standing; (4) corrections inside FS-129's own entries (items 67/106, 100, 117). Z2 does the stubs, the index, the scored
predictions and the front-page drafts. Read every statement from its source, never from an inventory line.

### 1.2 Quotation check (standing rule 3)

| quotation in the brief | source | verdict |
|---|---|---|
| "Right after this close, we'll be refining the workflow again... File that as a special case stub for after the workflow refinements." | `plans/STUB-cross-application-audit.md` § The request (line 9) | verbatim (script: substring match) |
| "1. yes, we don't want O(N^2) here. 2. Yes, keep to the cap, … so it'll pick up the latest changes." | `plans/FS129-cross-application-audit.md` § 1. Kooshi's words | verbatim (script: substring match) |

No mismatch.

### 1.3 The derive gate on every file I may append to, before any edit

Saved in `data/fs129/z1/gate-before/` (one file per derivation file). PASS before: FS111, FS114, FS116, FS121. FAIL before, each with the one
failure "no derivation entry" (older-format files): ASTRA-2026-09-14, FS100, FS100-X22D, FS100-X25B, FS103, FS106, FS106-TQ, FS110, FS112,
FS84-S1, FS84-SI-D, FS89. A file that failed only for want of an entry passes once a clean entry is appended; I report that, and repair nothing
beyond my entries.

### 1.4 Decisions taken here (the brief's "yours to decide")

1. **Order of `plans/FS129-derivation.md`**: the head section; then lane A's family (the merged forms first, each followed by the forms it
   supersedes), lane A's other entries; then lane R's chain (WHOLE → BENDANY/BENDLE3 → QFREE-CLASS → QFREE and its consumers), lane R's other
   entries, the superseded lane-R forms after their merged forms.
2. **Supersession**: a superseded entry keeps the reader's block verbatim except its `handoff:`, which reads "none — superseded by <id> …" and
   quotes the reader's handoff; a line "**Superseded** by <id>" heads its prose. Its statement stays verbatim, so `derive_gate.py quotes` over
   this file and the reader's record stays the verbatim check.
3. **Assembly by script** (`tools/fs129_z1_assemble.py`): the blocks are copied from the readers' records by name, each `§` address re-pointed
   to the reader's record; my fields and prose are written in the script and listed in Stage 2's table of changes. A block I change says so in
   its prose.
4. **Prior art**: kept as each reader measured it, "owed" where owed (the brief's Done means 1). The debts of items 45, 72, 84, 92, 113 are not
   searched here; held for the coordinator.
5. **Where the lost theorems go**: FS-100's to `plans/FS100-derivation.md` (X25B-PZ, X25B-L1, X22D-FLK2), FS-106's to `plans/FS106-derivation.md`
   (HOLE-t); FS-84 has no milestone-level file, so its job files are its derivation files: `plans/FS84-SI-D-derivation.md` (the eight J45
   statements, first) and `plans/FS84-S1-derivation.md` (S1b, S1b-47, S1d-K, S1e). Each entry's argument points into the job file where the
   proof is.
6. **Where an erratum goes**: a dated paragraph directly under the entry it corrects, original text standing above it.

### 1.5 Mid-job message sent (standing rule 11)

To the coordinator, 2026-10-04 about 01:33 UTC: FS129-SR2-QFCASE's step "simple at p" meets FS129-OR1-QFREE's hypothesis only if "simple" is read
at p; `data/fs116/claims.md` § 0 defines it globally. Stage 2's note under QFCASE carries it.
