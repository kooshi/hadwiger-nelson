# FS132-Z1 — the record job, part 1: FS-132's derivation file and the dated corrections

*Ephodos (the record job, first half), 2026-10-07 (UTC). Brief: `data/fs132/briefs/FS132-Z1-record.md`. Report:
`data/fs132/reports/FS132-Z1.md`. Working files: `data/fs132/z1/` (`extract_entries.py`, the six `entries-E*.txt`,
`entries-index.tsv`, `assemble.py`). Each stage is saved and committed before the next starts.*

## Theorems this phase proved

None: a record job. It derives nothing and raises no grade. The milestone's theorems are the entries of
`plans/FS132-derivation.md`, each at the grade and the number of minds its source gives it; where this job lowered a count
or entered a statement as a gap, the prose under that entry says so and why.

## Stage 1 — SAVED: the readback, the brief's quotations, what was read

### 1.1 Readback

FS-132's night produced six derivers' records, one search record, a kernel planner's record on an unmerged branch and two
records of the asking lane. My job is its first half of the record job: (1) a table of every entry of the six records and
of the planner's, with what later entries did to each; (2) `plans/FS132-derivation.md`, in which every derived statement
stands once in its strongest merged form with its weaker forms named under it, every stall and gap is an entry of its own,
every posed and unstarted claim is named as that, every grade and count of minds is exactly its source's, and every entry
is placed on one side of one line — whether it holds where a boundary is an arc of the unit circle about a point of the
centre's own ring, or only where none is; (3) the dated corrections the night's records owe each other and earlier
milestones' derivation files, each appended under the text it corrects with the original left standing; (4) drafts, with
their slots, for the files that are not mine (`LEDGER.md` row 133's sharpening; a note for rows 148–149); (5) the gates,
before and after, on every file I append to. Not mine: the stubs, the scored predictions, the front page — part 2's. I
start no agents; I raise nothing; a statement the night called derived that its record does not carry is a finding for
the coordinator at once.

### 1.2 The brief's quotations against their sources

| quotation | source | result |
|---|---|---|
| Kooshi, "[…] …" | `data/external/EXT-OAI1-request.md` § Kooshi's fourth word | matches, character for character |
| Kooshi, "[…] I'll hand the reins over to you […]. …" | the same file, § Kooshi's fifth word | matches |
| inventory item 6, first line | `plans/FS132-close-inventory.md` l. 147 | matches (`grep -F`) |
| inventory item 21, first line | l. 648 | matches |
| inventory item 25, first line | l. 779 | matches |
| inventory item 28, first line | l. 848 | matches |
| inventory item 30, first line | l. 904 | matches |

No mismatch. The brief's § What Kooshi asked says the inventory's own wording "was wrong twice tonight (its items 21 and 23
say where)": read — item 21 withdraws ruling 16 (c) and replaces ruling 18 (d)'s sentence; item 23 corrects item 21's point
(4) about the one tight seven-colouring held by formula.

### 1.3 What was read, and how

- **Whole**: the brief; `plans/STANDING-RULES.md`; `plans/FS132-close-inventory.md` items 1–30; `data/fs132/claims.md`;
  the six reports `data/fs132/reports/FS132-E1.md` … `-E6.md`.
- **Every entry block of the six records, whole and verbatim** (51 `derivation:` blocks, 32 `control:` blocks), extracted
  by `data/fs132/z1/extract_entries.py` into `data/fs132/z1/entries-E1.txt` … `-E6.txt` with `entries-index.tsv`.
- **Sections, by address**: `plans/FS132-E5-derivation.md` § The exclusion, step by step (the step table);
  `plans/FS132-E6-derivation.md` § The gap in clause (ii), § The two things the brief asks to carry visibly, § The two
  riding controls; `plans/FS132-E4-derivation.md` § Where C132-TURN stalls, item (i); `plans/SEARCH-2026-10-07.md`
  § Theorems this phase proved, § 1.3 (head), § 1.5, Stages 3 and 4; the kernel planner's record at
  `origin/fs132-wk1:plans/FS132-kernel-plan.md` (tip `e3695302`) — its head, § 2.2 from C132-M-ORBIT on, § 2.3 whole,
  Stage 3 whole (§§ 3.1–3.7); `plans/POROS-2026-10-07-fs132-round2.md` ll. 66–76 (clause (5)'s consumers);
  `plans/POROS-2026-10-07-fs132-night.md` ll. 74–82 (finding A); `LEDGER.md` rows 133, 148, 149.
- **Not read**: the arguments of the six records beyond the sections named (each statement, `uses only:` and `not
  claimed:` line was read; the proofs were not reworked — this job checks chains of entries, not steps of proofs); the
  asking lane's two records beyond the lines named; the stub beyond the lines quoted in the claim list and ll. 244–254;
  `plans/FS132-six-by-the-nerve.md` beyond its dictionary line; the Lean skeleton on the branch; the search's formulas
  and tables. Every number in the derivation file is copied by script from a source entry or quoted with its address.

## Stage 1 — SAVED
