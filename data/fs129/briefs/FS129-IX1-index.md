# Brief FS129-IX1 — the index of every theorem this project has derived, and its dependency map

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS129-IX1
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your lane's workflow
  role: stage 0 of FS-129, the cross-application audit: a script that indexes every derived theorem and the dependency graph between them
  launch: now, beside FS129-Q1 (Poros's question card), which writes different files
  mission: § Why this job
  statements: none — a mechanical job; Kooshi's words are quoted under § Why this job, and no mathematical statement is in play
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in FS-129 is blind (Workflow 3.1), and no blind job is running
  channel: message the coordinator ("main") by SendMessage only for a question you cannot work around; the report goes to `data/fs129/reports/FS129-IX1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `RUNNING.md` § Make the gate fail, and watch it fail, before you build the script
  record: `data/fs129/index/README.md`
  touches: `tools/fs129_index.py`, `data/fs129/index/`, `data/fs129/reports/FS129-IX1.md`
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the Clerk, building the index that a whole-corpus audit stands on. Nothing in this job is mathematics: every field you
fill is read from a file by a script, and every field the script cannot read is a `CHECK:` line, never a guess. Four Opus readers will
work from what you build, so an honest gap in the index is worth far more than a full-looking column that is partly invented.

## Why this job

Kooshi asked for an audit of everything this project has derived (2026-10-03):

> Right after this close, we'll be refining the workflow again... then I think it might be worth an audit of all previously novel lemmas and theorems in this project, to see where they can be applied across all others, interweaving and strengthening what we have, and potentially finding new paths. File that as a special case stub for after the workflow refinements.
> — source: plans/STUB-cross-application-audit.md § The request

and decided its method in four answers, the first and third of which make this job:

> 1. yes, we don't want O(N^2) here. 2. Yes, keep to the cap, and also use general purpose agents instructed to read the deriver's identity, rather than the agent files which carry the 150k token grokkings. They'll have enough on their plates without needing all that context, and they can read them if needed. 3. yes, excellent idea. 4. definitely. Please set up the plan file and handoff, and I'll restart a new session after restarting the handoff so it'll pick up the latest changes.
> — source: plans/FS129-cross-application-audit.md § 1. Kooshi's words

The questions those answers reply to are in the same section, in the coordinator's words. In short: about 1,300 theorems make about
850,000 pairs, so no one reads them pairwise; instead one index and one dependency map let each reader go straight from an open step to
the results that might close it, and from a mechanism to every place it is used. Answer 3 makes the index also the Lean backlog's input:
the results handed to de Bruijn (the Lean lane), in an order where each comes after what it rests on.

**Read the plan's § 2 (the corpus, with the commands that counted it) and § 3's "Stage 0 — the index"** in
`plans/FS129-cross-application-audit.md` before you build: they are this job's specification, and § 5 is the era split.

## What you work from

- **The derivation files**, `plans/*-derivation.md` — 99 files, 2.9 MB. **Do not read them whole**; your script reads them. Open a file
  only to look at an entry the script could not parse. Two grammars coexist:
  - the **block format** (late September on): a line `derivation: <ID>` followed by indented fields `statement:`, `uses only:`,
    `not claimed:`, `argument:`, `verdict:`, `grade:`, `minds:`, `model:`, `prior art:`, `handoff:`, with continuation lines indented
    further, then a prose paragraph naming what rests on it ("Rests on it: …"). `plans/FS121-derivation.md` from line 20 is a clean
    example;
  - the **older format**: `T1`, `T2`, … entries (FS-73's `T1–T38`, for one), parsed today by `parse_entries`.
- **The census checker**, `tools/fs71_ledger_b_check.py`, already parses both grammars: `full_id` (the id rule — a bare id such as `T3`
  inherits the file's prefix), `parse_entries` (older), `parse_new_entries` (block format, through the Ephodos gate's own parser, which
  it imports from `.claude/skills/ephodos/scripts/derive_gate.py`), `parse_ledger_b` (the § B index), `read_file`, `load`. **Import it as
  a module; never copy its parser**, and never edit it (it is another job's tool). If its parse is wrong for your purpose, wrap it and
  say so in your record.
- **`LEDGER.md`**: § A, the ledger rows 1–148 (one per result; the rows cite theorem ids and grokkings), and § B from line 195, the index
  of theorems proved outside the kernel by milestone, 1,297 lines at the plan's count. § B stops at FS-116 and FS-121; there are no § B
  lines for anything later, by design.
- **The grokkings**, `.claude/skills/grokkings/SKILL.md` (G1–G91): you need only their numbers and titles, read by script.
- **The era split** (plan § 5): arithmetic era (lane A) is every milestone through FS-103 — that includes every `M`-numbered milestone
  (M2 … M64, M63's sub-milestones) and the `FS100-*`, `FS103-*` files; regularity-wall era (lane R) is FS-104 on. Ten files have names
  that carry no milestone number — `ASTRA-2026-09-14`, `MASCOT`, `Q8`, `R52`, `R57`, `R59`, `R88`, `TC1` among them: place each by the
  § B section its theorems are listed under; a theorem you cannot place goes to `CHECK:`.

## Done means

1. **`tools/fs129_index.py`**, standard library plus the census module, with a `--self-test` that plants faults and watches each one
   fire (`RUNNING.md` § Make the gate fail, and watch it fail): at least an entry with no statement, a `uses only:` id that resolves to
   nothing, a dependency cycle, and an id defined in two files. The self-test must also show one clean planted entry indexed correctly,
   field by field.
2. **`data/fs129/index/`**, written by one run of the script, holding the files of the plan's § 3 Stage 0, each with a header line
   saying what it is, the command that wrote it and the commit it was written at:
   - `data/fs129/index/theorems.jsonl` — one record per theorem: id; milestone; era (`A`, `R` or `CHECK`); derivation file and line; statement and
     *not claimed* line verbatim (whitespace joined, nothing else changed); grade; minds; verdict; the `uses only:` ids resolved, and the
     raw `uses only:` text; the "Rests on it" ids, and the paragraph's text where it names no id; `handoff:`; the ledger rows and
     grokkings that cite it (a row cites it when the row's text contains its id). An older-format entry has no field for some of these:
     leave them empty, never filled from prose.
   - `data/fs129/index/edges.csv` — `from,to,source` with an edge from a result to each result that uses it, from both directions of the record
     (`uses only:` and "Rests on it"), the `source` column saying which, and both when both do; a pair the two directions disagree on
     (one says it, the other's text exists and omits it) listed in `data/fs129/index/disagreements.md`.
   - `data/fs129/index/unresolved.md` — every id-shaped reference that resolves to no entry, with its address. This is expected to be long; it is a result.
   - `data/fs129/index/orphans.md`, `data/fs129/index/hubs.md` (by count of dependents, direct and transitive, top 100 with counts, the rest in the jsonl).
   - `data/fs129/index/open-steps.md` — every entry whose verdict is `gap`, `stalls` or `refuted`, and every "stalls at" and "GAP" (any case) in a
     derivation file or a ledger row, each with its address and the line's text.
   - `data/fs129/index/grokking-uses.md` — for each grokking, the theorems and milestones that cite it, and the era by majority (ties to `CHECK:`).
   - `data/fs129/index/lean-order.md` — the results whose `handoff:` names de Bruijn (77 at the plan's count), and everything they rest on transitively,
     ordered so each comes after what it uses; a cycle is reported with its members, not broken silently.
   - `data/fs129/index/statements-A.md`, `data/fs129/index/statements-R.md` — one line per theorem: id, address, statement (truncated at 400 characters, marked `…` where
     cut).
3. **`data/fs129/index/README.md`**, your record: Stage sections headed "Stage n — SAVED" (standing rule 2); the readback (stage 1);
   the corpus re-counted with the plan's § 2 commands, each count beside the plan's and any difference explained; the counts the run
   produced (theorems per era, per grammar, per verdict; edges by source; unresolved; orphans; open steps; lean-order length); the
   heading "Theorems this phase proved" with the line "none — a mechanical job"; and every `CHECK:`.
4. **Five records you choose at random** (say how) written out in the README beside the file text they came from, so the coordinator's
   spot check starts from yours.
5. The report, in standing rule 11's form.

## What is yours to decide

The script's design, its output encodings within the list above, how it resolves an id that two files could own (state the rule), and
how it treats references to ledger rows (`row 120`) and to Lean declarations in `uses only:` lines — record them as nodes such as
`row:120` and `lean:<name>` if they parse cleanly, or leave them in the raw text; say which. If a file in the list above would be more
useful to a reader in another shape, build the listed one and propose the other in your report. If the job, as specified, cannot be
done mechanically somewhere — a field that only judgement could fill — stop there, say so, and leave it for the readers: "this needs a
judgement: <which, where>" is a complete answer.

## Your first stage: the readback

Check the two quotations above against their sources, and restate in your record, in your own words, what `data/fs129/index/edges.csv` and
`data/fs129/index/lean-order.md` must contain. A mismatch is a finding about this brief.

## Amendment, 2026-10-03 23:00 UTC — the roots, and the corrections from the coordinator's review

Thank you for the index, and for the `CHECK:` list: it is exactly the honest-gap report the brief asked for, and the grokkings
description you caught (G1 to G87 against G1–G91) is now fixed. The coordinator re-ran your self-test (PASS) and read five records against
their files; four match, one does not (item 3 below). This amendment continues your job in the same files; the standing rules hold
unchanged — in particular rule 1: start no agent of your own, because staffing is Kooshi's and the coordinator reviews only work it knows
exists. Save each step as a stage, as before.

1. **Roots.** Kooshi, on reading the plan:

> Also a note for the whole plan that not only are "hubs" important, but deep "roots", where a long chain of theorems starts, even if it has only one offshoot
> — source: plans/FS129-cross-application-audit.md § 1. Kooshi's words

   Add to each record of `data/fs129/index/theorems.jsonl` the length of the longest chain of dependents that starts at it (`depth_down`)
   and of the longest chain it rests on (`depth_up`), on the graph with each cycle condensed to one node (say so in the header). Write
   `data/fs129/index/roots.md`: the top 100 by `depth_down`, each with its direct-dependent count and its longest chain written out id by id,
   ties broken by transitive dependents. State in its header that older-format edges come from prose, so every depth is a lower bound.
2. **Grade edges.** Your proposal is accepted: add the edge source `grade` for the ids a `derived from:` grade names.
3. **FS100-TCA** (`plans/FS100-derivation.md`, line 289): its `statement` holds the entry's `*Also:*` sentence, and its own statement is only in
   `title`. Where an older entry's body opens with `*Also:*`, take the statement from the header, as for the 497 with an empty statement.
   And list in `data/fs129/index/checks.md` every `*Also:*` clause in any older entry, with its address and the ids it names (X25B-PZ and
   X25B-LP here): each is a claim with no record of its own.
4. **Eras.** The 51 era-CHECK theorems are lane A (`plans/FS129-close-inventory.md` item 11); FS-105 stays lane R (item 12). Set `era_how` to
   the item, and fold `data/fs129/index/statements-CHECK.md` into `data/fs129/index/statements-A.md`.
5. **The 22 files with no entry** (your CHECK 8): for each, list mechanically the entry-shaped headers and ids it defines, and for each id
   whether it, or an alias of it (`= X23D-TCA` style), appears in any indexed entry. Ids that appear nowhere are the finding; list them in
   `data/fs129/index/checks.md` with their addresses. Do not judge whether they are theorems.
6. The 78 seeds stand, the three `none`-led ones flagged as conditional, as you did (item 13).

Re-run, re-check the self-test (add a plant for the depth computation on a chain with one offshoot, and one for a cycle inside a chain),
update `data/fs129/index/README.md` and the report, and hand back as before. Budget for the amendment: about 150k more by the harness's
count; hand back at a saved stage before about 500k in all.
