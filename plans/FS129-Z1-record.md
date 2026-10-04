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

## Stage 2 — SAVED: `plans/FS129-derivation.md`

**Built** by `tools/fs129_z1_assemble.py` (copy by name, addresses re-pointed, the record job's changes in code and named under each entry).
Its check (`--check`: every statement equal to its source's, spacing aside; all 40 present; every superseded entry marked) printed
"z1 assemble check: 40 entries, 0 problems"; with a fault planted (`--check --fault`, "simple" dropped from FS129-OR1-QFREE in memory) it printed
"STATEMENT DIFFERS FS129-OR1-QFREE … 1 problems" and exited 1 — it fires.

**Gates.** `derive_gate.py all plans/FS129-derivation.md` under `scripts/slot.py`: **PASS (0 failures, 50 warnings)**, 40 entries derived, 22
controls, all fired on their faults (`data/fs129/z1/gate-all.txt`); the warnings are the owed prior-art lines and cited entries outside the file.
`derive_gate.py quotes` over this file and the eight reader records: PASS, "statements named in more than one place: 40"
(`data/fs129/z1/gate-quotes.txt`) — every statement here is its reader's, verbatim.

**Changes made by the record job** (each named in the file under its entry):
1. Eleven superseded entries (table below): `handoff:` reads "none — superseded by …", the reader's handoff quoted.
2. FS129-MA2-FALC-HOSTS: `handoff:` splits clause (i) (superseded by FS129-SA1-FALC-RES (i)) from (ii)–(iv) (over FALC-FAN (B), DICHO-K).
3. FS129-MR1-DOUBLETIP: FS116-N2-STAR dropped from `uses only:`, `grade:`, `handoff:` (SR1 § 2.2; items 95, 100); the original lines quoted.
4. FS129-OA1-RINGWIND: `prior art:` names FS110-N2-RING and FS110-Y3-GP (item 100); the original line quoted.
5. Prose under every entry: what rests on it; the supersessions; three record-job notes (below).

**The record-job notes, in short** (full text under each entry):
- **FS129-SR2-QFCASE** — its step "simple at p" reads FS-116's "simple" (global, `data/fs116/claims.md` § 0) at p only; QFREE as stated does not
  apply to S1-QF's fragments; carried if QFREE's chain reads simplicity at p alone, which FS116-V6's route says of itself; FS116-Y4's own route
  unchecked. Verdict left as derived; the handoff and item 117's J3 correction hold only under that reading. Sent to the coordinator.
- **FS129-SR1-BENDLE3** — omits FS129-OR1-BEND3's tile clause, which FS129-SR1-BENDANY carries; no hypothesis dropped.
- **FS129-SR1-RINGBAND** — does not restate FS129-OA1-RINGWIND's periodicity clauses (immediate from h's definition); no hypothesis dropped.

**Merged forms against their sources — checked for a dropped hypothesis** (the brief's statement-defect test): NOAFF-K/NOAFF-FIELDS against
NOLIN5 and NOAFF5 (NOLIN5's "prime of residue field 𝔽₁₁" is a usable prime; its conclusion c_v = 0 follows from φ_v constant by the simplex's
injectivity); FALC-FAN against FALC-T (clause (3) from (B)'s second clause) and GAP4; DICHO-K against DICHO; FALC-RES against FALC-11, FALC-19
(clause (ii) at n = 0) and HOSTS (i) (χ(F²) ≥ 4 excludes usable 𝔽₃ primes by row 52 and ramified dyadic places by G35); SA1-FALC-RED against
OA1-FALC-RED (identical statement); BENDANY against BENDFRAG (at k = 6 and ≥ 4 colours, "both side colours carried at p" is (Q)); BENDANY with
BENDLE3 against BEND3; RINGBAND against RINGWIND. **None drops a hypothesis its source needed.** The one defect found is QFCASE's, above — a
statement read against a weaker hypothesis than the one it cites, not a merge that drops one.

### 2.1 Every FS-129 entry, with its address

| entry | `plans/FS129-derivation.md` line | source block | status here |
|---|---|---|---|
| FS129-SA1-PLACE-HOM | 55 | `plans/FS129-SA1-audit.md` line 199 | stands |
| FS129-SA1-NOAFF-K | 81 | `plans/FS129-SA1-audit.md` line 165 | stands |
| FS129-SA1-NOAFF-FIELDS | 117 | `plans/FS129-SA1-audit.md` line 223 | stands |
| FS129-SA1-FALC-FAN | 141 | `plans/FS129-SA1-audit.md` line 245 | stands |
| FS129-SA1-FALC-DICHO-K | 174 | `plans/FS129-SA1-audit.md` line 276 | stands |
| FS129-SA1-FALC-RES | 193 | `plans/FS129-SA1-audit.md` line 293 | stands |
| FS129-SA1-FALC-RED | 233 | `plans/FS129-SA1-audit.md` line 331 | stands |
| FS129-MA2-FALC-HOSTS | 258 | `plans/FS129-MA2-audit.md` line 144 | superseded in part (clause (i)) |
| FS129-OA1-NOPERLAW | 297 | `plans/FS129-OA1-audit.md` line 284 | stands |
| FS129-SA1-SQRT3-LOCAL | 317 | `plans/FS129-SA1-audit.md` line 681 | stands |
| FS129-OA1-NOLIN5 | 353 | `plans/FS129-OA1-audit.md` line 143 | superseded by FS129-SA1-NOAFF-K with FS129-SA1-NOAFF-FIELDS |
| FS129-MA1-NOAFF5 | 382 | `plans/FS129-MA1-audit.md` line 138 | superseded by FS129-SA1-NOAFF-K |
| FS129-MA1-FALC-T | 413 | `plans/FS129-MA1-audit.md` line 183 | superseded by FS129-SA1-FALC-FAN |
| FS129-MA2-FALC-GAP4 | 437 | `plans/FS129-MA2-audit.md` line 124 | superseded by FS129-SA1-FALC-FAN |
| FS129-MA2-FALC-DICHO | 465 | `plans/FS129-MA2-audit.md` line 107 | superseded by FS129-SA1-FALC-DICHO-K |
| FS129-OA1-FALC-11 | 485 | `plans/FS129-OA1-audit.md` line 238 | superseded by FS129-SA1-FALC-RES |
| FS129-MA1-FALC-19 | 513 | `plans/FS129-MA1-audit.md` line 216 | superseded by FS129-SA1-FALC-RES |
| FS129-OA1-FALC-RED | 547 | `plans/FS129-OA1-audit.md` line 205 | superseded by FS129-SA1-FALC-RED |
| FS129-OR1-WHOLE | 573 | `plans/FS129-OR1-audit.md` line 93 | stands |
| FS129-SR1-BENDANY | 610 | `plans/FS129-SR1-audit.md` line 266 | stands |
| FS129-SR1-BENDLE3 | 635 | `plans/FS129-SR1-audit.md` line 289 | stands; record-job note |
| FS129-OR1-QFREE-CLASS | 654 | `plans/FS129-OR1-audit.md` line 198 | stands |
| FS129-OR1-QFREE | 671 | `plans/FS129-OR1-audit.md` line 220 | stands |
| FS129-SR2-QFCASE | 688 | `plans/FS129-SR2-audit.md` line 368 | stands; record-job note |
| FS129-MR1-DOUBLETIP | 706 | `plans/FS129-MR1-audit.md` line 110 | stands; corrected (item 100) |
| FS129-SR1-TWOCIRC | 751 | `plans/FS129-SR1-audit.md` line 197 | stands |
| FS129-SR1-SIXQ | 788 | `plans/FS129-SR1-audit.md` line 241 | stands |
| FS129-SR1-RINGBAND | 808 | `plans/FS129-SR1-audit.md` line 319 | stands; record-job note |
| FS129-OR1-LOCALDENSE | 843 | `plans/FS129-OR1-audit.md` line 600 | stands |
| FS129-OR1-DISCF-NS | 865 | `plans/FS129-OR1-audit.md` line 633 | stands |
| FS129-OR1-TOP5 | 883 | `plans/FS129-OR1-audit.md` line 444 | stands |
| FS129-SR2-CLOSURE | 904 | `plans/FS129-SR2-audit.md` line 144 | stands |
| FS129-SR2-HULLSET | 922 | `plans/FS129-SR2-audit.md` line 160 | stands |
| FS129-SR2-SUPK | 940 | `plans/FS129-SR2-audit.md` line 176 | stands |
| FS129-SR2-DISC1TS | 959 | `plans/FS129-SR2-audit.md` line 193 | stands |
| FS129-SR2-YESLIM-EQ | 977 | `plans/FS129-SR2-audit.md` line 352 | stands |
| FS129-SR2-TOUCHW | 995 | `plans/FS129-SR2-audit.md` line 384 | stands |
| FS129-OR1-BENDFRAG | 1017 | `plans/FS129-OR1-audit.md` line 147 | superseded by FS129-SR1-BENDANY |
| FS129-OR1-BEND3 | 1043 | `plans/FS129-OR1-audit.md` line 279 | superseded by FS129-SR1-BENDANY with FS129-SR1-BENDLE3 |
| FS129-OA1-RINGWIND | 1067 | `plans/FS129-OA1-audit.md` line 348 | superseded by FS129-SR1-RINGBAND; corrected (item 100) |
