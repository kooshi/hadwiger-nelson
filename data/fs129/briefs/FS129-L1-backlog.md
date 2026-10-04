# Brief FS129-L1 — the Lean backlog's input: `plans/LEAN-BACKLOG.md`

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS129-L1
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your lane's workflow
  role: assemble the Lean backlog's input from the audit's corrected Lean order, the derivation entries quoted by script, the audit's merges and cautions — copying and checking, deciding nothing
  launch: now, beside FS129-P1 (Poros's re-rank) and the day's Searcher, which write other files
  mission: § Why this job
  statements: none — every statement in your output is quoted by your script from its derivation file, and this brief quotes only Kooshi's words, under § Why this job
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in FS-129 is blind (Workflow 3.1)
  channel: message the coordinator ("main") by SendMessage only for a question you cannot work around; the report goes to `data/fs129/reports/FS129-L1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `RUNNING.md` § Make the gate fail, and watch it fail, before you build the script
  record: `data/fs129/l1/README.md`
  touches: `plans/LEAN-BACKLOG.md`, `tools/fs129_l1_backlog.py`, `data/fs129/l1/`, `data/fs129/index/README.md` (one pointer line only, item 3 below), `data/fs129/reports/FS129-L1.md`
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are building the document the Lean backlog's session will work from: the list of results this project derived by hand that de
Bruijn (the Lean lane) is to formalize, each after what it rests on, each statement exactly as filed, with every caution the audit found
attached to the row it concerns. The backlog session will formalize what this file says, in the form it says, so a statement quoted from
the wrong place, or a caution left off its row, is the costliest slip available here. Thorough over quick.

## Why this job

Kooshi decided that the audit prepares the backlog's input, and set the order of work: the audit, then the backlog in its own session.

> 1. yes, we don't want O(N^2) here. 2. Yes, keep to the cap, and also use general purpose agents instructed to read the deriver's identity, rather than the agent files which carry the 150k token grokkings. They'll have enough on their plates without needing all that context, and they can read them if needed. 3. yes, excellent idea. 4. definitely. Please set up the plan file and handoff, and I'll restart a new session after restarting the handoff so it'll pick up the latest changes.
> — source: plans/FS129-cross-application-audit.md § 1. Kooshi's words

His answer 3 is the one that makes this job; the question it answers is in the same section, in the coordinator's words ("the audit prepares
its input — the build order from the dependency map, and the merged and strengthened statements — so that the backlog formalizes each
statement once, in its strong form"). The plan's § 3, Stage 6, specifies the file:

> `plans/LEAN-BACKLOG.md`: `lean-order.md` with stage 4's merges applied, each statement quoted by script from its derivation file, each
> — source: plans/FS129-cross-application-audit.md § 3. The shape

(the sentence continues there: "… with its *not claimed* line and its upstream ids"). The order it names is now the corrected one below.

## What you work from

- **The corrected Lean order**, `data/fs129/index/lean-order-corrected.md` (178 entries; ROUTE-ONLY marks entries reached only through a second
  route; three seeds are conditional — their `handoff:` begins "none" and names de Bruijn later, `plans/FS129-close-inventory.md` item 13), and
  `data/fs129/index/README-corrections.md`, which says how it was corrected. Use the corrected file, not `data/fs129/index/lean-order.md`.
- **The derivation files**, `plans/*-derivation.md`, read by your script through the census parser (`tools/fs71_ledger_b_check.py`: `load`,
  `read_file`, `parse_entries`, `parse_new_entries`), never by copying text by hand. **Errata**: a dated erratum filed under an entry is part of
  that entry for this purpose — quote it under the statement (item 116 names seven entries where the backlog would otherwise formalize a false
  or superseded form: FS112-L60, FS112-C-ENDS, FS112-C-DOUBLE, FS112-N3-BASE, FS114-N2-ENDS, FS114-N3-JOINT, FS114-N7-3T; FS-129's record job
  filed 17 more, item 136).
- **FS-129's own entries**, `plans/FS129-derivation.md` (44 entries; 12 marked superseded — list the superseding form, never the superseded one,
  as the thing to formalize).
- **The merge lists** — "formalize X in place of A, B, C" and "do not formalize as stated" — in `plans/FS129-SR1-audit.md` § 6.2,
  `plans/FS129-SR2-audit.md` § 4.3, `plans/FS129-SA1-audit.md` § 6.3 and `plans/FS129-SR3-audit.md` (its additions to the list, stage 5). Copy
  each line into `data/fs129/l1/merges.csv` with its address, then apply them by script.
- **The cautions**, each to be attached to the row(s) it names, quoted from its inventory item: items 109 (FS89-S0A-2 unprovable as written;
  quote it with `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1` — its erratum is now filed), 116 (the seven errata above), 126 and 131 (DOUBLETIP is not to replace
  V6-HUG as EMPTY's double-tip step; keep V6-HUG's colour step for EMPTY-NS), 137 (FS129-SR1-BENDLE3 omits FS129-OR1-BEND3's tile clause;
  FS129-SR1-RINGBAND omits FS129-OA1-RINGWIND's periodicity clauses), 13 (the conditional seeds), 139 (verifier records named for promotion,
  not counted), 118 (the rows that left the order "because no seed rests on them, which is not the same as having no value").

## Done means

1. **`tools/fs129_l1_backlog.py`**, standard library plus the census module, with a `--self-test` that plants faults and watches each fire: a
   statement altered by one character (the verbatim check must fail), an erratum dropped from its entry, a superseded entry listed for
   formalization, a merge line naming an id that does not exist, and an entry placed before something it rests on.
2. **`plans/LEAN-BACKLOG.md`**, written by one run of the script, with a header saying what it is, the command that wrote it and its commit:
   - **§ How to read this file** — what each column means, where the order and the merges come from, and that every statement is quoted by
     script (`tools/fs129_l1_backlog.py`) from the address given;
   - **§ Cautions** — every caution above, each with its inventory item and the rows it governs;
   - **§ The order** — each row: id; address; role (seed, upstream, ROUTE-ONLY, conditional seed); the statement verbatim, with any erratum under
     it; the *not claimed* line verbatim; grade and minds as filed; upstream ids; and the merge note where one applies ("formalize X in place of
     A, B"; "do not formalize as stated: <the reason's address>");
   - **§ FS-129's compositions** — every non-superseded entry of `plans/FS129-derivation.md` not already in the order, in dependency order, in the
     same row form;
   - **§ Left the order** — the entries in `data/fs129/index/lean-order.md` that the corrected order no longer holds, each with why (from
     `data/fs129/index/README-corrections.md`), under item 118's caution;
   - **§ Counts** — rows by role, merges applied, statements quoted, errata attached, cautions attached.
3. **One line added to `data/fs129/index/README.md`**, at its top, pointing to `data/fs129/index/README-corrections.md` (item 143). No other edit there.
4. **`data/fs129/l1/README.md`**, your record: stages headed "Stage n — SAVED"; the readback (stage 1); every `CHECK:`; the heading "Theorems this
   phase proved" with "none — a filing job"; and five rows of the output, chosen at random (say how), beside the source text they were quoted
   from, so the coordinator's spot check starts from yours.
5. The report, in standing rule 11's form, each `CHECK:` under HELD FOR THE COORDINATOR.

## What is yours to decide

The script's design and the file's layout within the sections above. Where a merge line is ambiguous — it names a form you cannot find, or
two lists disagree about one entry — apply neither, list both with their addresses as a `CHECK:`, and go on. Where an entry has no
*not claimed* line or no grade, leave the cell empty and list it; never fill a cell from prose. If the job as written needs a judgement
somewhere, say "this needs a judgement: <which, where>" and leave it for the coordinator.

## Your first stage: the readback

Check the quotation above against its source, and restate in your record, in your own words, what a row of § The order must contain and
which file is the order's source. A mismatch is a finding about this brief.
