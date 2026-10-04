# Brief FS129-Z1 — the record job, part 1: FS-129's derivation file, the lost theorems, and the errata to earlier derivation files

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS129-Z1
  identity: Ephodos, the deriver, read as files — `.claude/skills/ephodos/SKILL.md` in full, then `.claude/agents/ephodos.md` from its line `# Ephodos in lean-dir — the workflow` to its end; its `## The record job` is your job, split in two
  role: part 1 of FS-129's record job — the derivation file, the theorems the record lost, and the dated errata to earlier milestones' derivation files
  launch: now, beside FS129-SR3 (lane R's last pass-3 items) and the day's Searcher, which write only their own files; part 2 (FS129-Z2) follows you and SR3
  mission: § Why this job
  statements: § What Kooshi asked
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in FS-129 is blind (Workflow 3.1)
  channel: message the coordinator ("main") by SendMessage only for a question you cannot work around or a finding that cannot wait; the report goes to `data/fs129/reports/FS129-Z1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Rule 1 matters more for you than for most: you are a general-purpose agent and carry the Agent tool, which the lane agent files withhold
  record: `plans/FS129-Z1-record.md`
  touches: `plans/FS129-Z1-record.md`, `plans/FS129-derivation.md`, `plans/*-derivation.md` (dated entries and errata appended only, the original text left standing), `data/fs129/z1/`, `tools/fs129_z1_*.py`, `data/fs129/reports/FS129-Z1.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 550k — a successor continues from your record

Hello. You are writing the theorem record of FS-129, the cross-application audit Kooshi asked for. Eight reader jobs, in two lanes and three
passes, have derived some forty statements and found a good deal the record already held but had lost, misstated or filed twice. Your job is
to make that durable: one derivation file in which every statement FS-129 derived stands as an entry, in its strongest merged form; the lost
theorems filed back where they belong; and dated errata under the earlier entries the audit found wrong in their wording. The Lean backlog
formalizes from what you write, so an entry that overstates its source, or a merged form that drops a hypothesis, is the error that would cost
most here.

## Why this job

The plan, `plans/FS129-cross-application-audit.md`, § 3's Stage 5, splits the record job in two because FS-129 passes fifty theorems: you
write the derivation file; FS129-Z2 then writes the stubs, the index corrections, the scored predictions and the drafts of the front page. The
inventory, `plans/FS129-close-inventory.md`, is your worklist: every line routed "for FS129-Z1" is yours, and the readers' records are your
sources. Read every number and statement from its source, never from an inventory line — the inventory's own receipts have been wrong twice
(items 19, 99), and that is why you read the source.

## What Kooshi asked

> Right after this close, we'll be refining the workflow again... then I think it might be worth an audit of all previously novel lemmas and theorems in this project, to see where they can be applied across all others, interweaving and strengthening what we have, and potentially finding new paths. File that as a special case stub for after the workflow refinements.
> — source: plans/STUB-cross-application-audit.md § The request

> 1. yes, we don't want O(N^2) here. 2. Yes, keep to the cap, and also use general purpose agents instructed to read the deriver's identity, rather than the agent files which carry the 150k token grokkings. They'll have enough on their plates without needing all that context, and they can read them if needed. 3. yes, excellent idea. 4. definitely. Please set up the plan file and handoff, and I'll restart a new session after restarting the handoff so it'll pick up the latest changes.
> — source: plans/FS129-cross-application-audit.md § 1. Kooshi's words

## Who you are, and how to load it

You are a `general-purpose` agent, by Kooshi's decision 2. Read `.claude/skills/ephodos/SKILL.md` in full, then `.claude/agents/ephodos.md`
from its line `# Ephodos in lean-dir — the workflow` to its end; its `## The record job` describes the whole job, and you do its first half:
"The derivation file" and "Errata" under "What you write directly". Read a grokking by number when you need it —
`awk '/^\* \*\*G83 —/{p=1;print;next} /^\* \*\*G[0-9]+ —/{p=0} p' .claude/skills/grokkings/SKILL.md`.

## What you work from

- **The readers' records**, each with its entries in your identity's grammar and its report in `data/fs129/reports/`:
  `plans/FS129-OA1-audit.md`, `plans/FS129-OR1-audit.md` (pass 1); `plans/FS129-MA1-audit.md`, `plans/FS129-MA2-audit.md`,
  `plans/FS129-MR1-audit.md` (pass 2); `plans/FS129-SA1-audit.md`, `plans/FS129-SR1-audit.md`, `plans/FS129-SR2-audit.md` (pass 3). FS129-SR3 is
  running; its entries are Z2's to add, not yours.
- **The inventory**, `plans/FS129-close-inventory.md`, items 1–122; the lines "for FS129-Z1" are yours. The ones that write derivation files:
  - **merges and supersessions** — pass 3's merged forms stand in place of the forms they merge (items 97, 106, 115; SA1's § 6.3, SR1's § 6.2 and
    SR2's § 4.3 say which forms replace which); each superseded entry stays in the file, marked superseded by its id;
  - **the lost theorems** (item 110, and X22D-FLK2 in item 113; SA1's § 4.1–4.2 has each statement's source): each filed in its own milestone's
    derivation file under its original id, as a dated entry, its statement verbatim from where SA1 found it, its grade and minds exactly as
    that source gives them — never raised; where the source gives none, say so in the entry. The eight J45 statements are inputs of row 121
    (χ(ℚ(√47)²) = 5); file them first;
  - **errata to earlier derivation files**, each a dated entry with its source, the original text left standing: item 78 (FS110-A3-HOLE's link);
    item 96 (FS116-Y4-EMPTY's *not claimed* line, now reached by FS129-OR1-QFREE in the non-Siamese simple class); item 108 (the FS89 Notation —
    `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1` — repairing CL2, S0A-2 and S0A-10 at once; ASTRA-2026-09-14-T10; FS100-T1's grade line); item 117
    (FS111-M-COVER-SC's handoff; FS106-EQ to cite SUPK; FS114-Y3-RSTOP's membership; FS111-W-NOREP's GAP); SA1's and SR1's drafted errata are in
    their records — use them, checked against the entries they correct;
  - **corrections inside FS-129's own entries**: FALC-RED's argument in Falconer's p. 188 order (items 67, 106 — SA1's FS129-SA1-FALC-RED is the
    form); DOUBLETIP's `uses only:` without FS116-N2-STAR (item 100); RINGWIND's prior art partly in-house (item 100); `plans/FS129-OR1-audit.md`
    § J3's non-simple remainder, empty for S1-QF (item 117).
- **The derivation gate**: `python3 .claude/skills/ephodos/scripts/derive_gate.py all <file>` from the repository root; an earlier milestone's
  file you append to must pass it after your entry as it did before (run it before and after; a file that already failed is reported, not
  repaired beyond your entry).

## Done means

1. **`plans/FS129-derivation.md`**: every statement FS-129's readers derived, as an entry — its argument an address in the reader's record, its
   `uses only:` by id, its `not claimed:`, its grade and minds as derived (one mind throughout, unless a record says otherwise), its prior art
   as the reader measured it ("owed" where owed), its `handoff:` the kernel decision (de Bruijn, naming the merged form to formalize once), and
   under each, in prose, what rests on it. Superseded forms kept and marked. A short head section: what FS-129 is, the passes, and where each
   lane's records are. It passes `derive_gate.py all`.
2. **The lost theorems filed** in their milestones' derivation files, each gated as above.
3. **The errata filed**, each dated, sourced, the original standing.
4. **`plans/FS129-Z1-record.md`**: stages headed "Stage n — SAVED"; your readback (stage 1); a table of every inventory line routed to Z1 with
   what you did (done, or declined with the reason); a table of every FS-129 entry with its address; a list of what you leave for FS129-Z2;
   the heading "Theorems this phase proved" (the record job derives nothing new: say so, or name any statement you had to re-derive and why).
5. **Your report** in standing rule 11's form.

## What is yours to decide

The order of the file, the head section's form, and how to mark supersession. Where two readers' forms of one statement differ, quote both
and choose the one the argument supports, saying why; where a merged form drops a hypothesis its source needed, keep the source's form and
report it — that is a statement defect, and the coordinator wants it at once. If an entry cannot be stated faithfully from its record, file
it as "not filed: <why>" in your record rather than smoothing it.
