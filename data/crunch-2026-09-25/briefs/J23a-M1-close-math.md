*Brief for crunch job **J23a**: milestone M1's close-math (WORKFLOW step 9, the mathematics half). Opus 5.5, 2026-09-25. Written by the
product owner from `plans/CRUNCH-2026-09-25-queue.md` §4.5, in the form of `data/fs89/briefs/CL2-close-planner-brief.md`.*

Hello. You are de Bruijn (`DEBRUIJN.md`), working as **M1's close planner** in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk (WORKFLOW step 9 in full).
**`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** I'm the product owner; I coordinate and
review by artifact. **Kooshi's close rules:** *"close out with the findings"*; *"I don't want to lose anything from before"*; *"All novel
knowledge is a success."* Every result goes in at its exact scope, grade and verification status.

**If your outputs already exist, you are resuming:** read this brief and `plans/FS91-close-inventory.md`; the ticked items and the
`Stage n — SAVED` headings in the plan's §R-close are your map; check them against `git log -- plans/FS91-character-local-global.md
plans/FS91-derivation.md plans/FS91-close-inventory.md`, and continue at the first stage not SAVED.

## The milestone

**M1 = FS-91, "character colourings of a real number field's plane"** — plan `plans/FS91-character-local-global.md`, stub
`plans/STUB-band-rigidity-six.md`. Its jobs, all DONE unless marked: J01 and J03a (band rigidity at every band, two blind readings),
J02 and J09 (three colours, two independent derivations), J07 and J10/J10b (the class theorem CLG, derivation and blind check), J08 and
J11 (six at the exposed fields, derivation and blind check), J12 (one prime) and **J13** (its blind check — RUNNING when this brief was
written; its verdicts must be in before stage 3 below, so if `data/crunch-2026-09-25/reports/J13.md` does not say DONE, do stages 1–2 and
then report to me and wait).

**Your sources, in this order:** the close inventory `plans/FS91-close-inventory.md` (every item: tick "done at <hash>" or "declined, with
the reason"; read every number from the item's source, never from the inventory); the job records (`plans/FS91-S0V-band-to-nine.md`,
`plans/FS91-S0V2-SWm-second-reading.md`, `plans/FS91-S0F-three-colours.md`, `plans/FS91-S0FV-three-colours-blind.md`,
`plans/FS91-S1D-character.md`, `plans/FS91-S1V-character.md`, `plans/FS91-S1D-six.md`, `plans/FS91-S1V-six.md`,
`plans/FS91-S1D-one-prime.md`, and J13's record); the reports in `data/crunch-2026-09-25/reports/`; and the bookkeeper's index
`plans/CRUNCH-2026-09-25-INDEX.md` (§2 is M1), which cross-references all of them.

## Outputs — all in the plan and the derivation file; never in the four front-page files

1. **`plans/FS91-derivation.md`** — every theorem M1 proved outside the kernel, one entry each per WORKFLOW 9: statement, grade,
   **verification status** (one mind / two independent derivations / blind-verified, by which job), the proof's address, what rests on
   it, a kernel decision (kernel / stub / declined, with the reason). Use `plans/FS89-derivation.md` as the model. Every "Theorems this
   phase proved" line in every M1 record gets its entry or an explicit merge. And one line each in `LEDGER.md` § B — **drafted in the plan**
   (§R-close), not written into `LEDGER.md`.
2. **The plan's §R-close:** the §G re-read (which extractions paid; which entry should have borne and was not used); the §PA sweep (what
   did the milestone learn about what its object IS — promote each to a drafted grokking line or stub); the §IQ re-read and G72's count
   (did the result come through the structural question?); the predictions scored once (the plan's §P and every job's C0, one table);
   the verdict ruled in four parts (WORKFLOW's report format); the honesty tally (every owner error and agent slip in the inventory); the
   would-have-searched log counted across M1's jobs, with every "at the ban's edge" note listed.
3. **Drafts, written in the plan's §R-close, never in the files themselves:** the new `LEDGER.md` rows (the next free row number after
   97, stated at exact scope); the `CLAUDE.md` Frontier lines and grokking edits (**at most 4,000 bytes net**: `CLAUDE.md` holds current
   state only, one home per fact — details go to the ledger rows and plans), including every correction owed (FS89-CL2's "archimedean",
   row 95's wording, G74's and G76's killing tests, item 25, the L ≤ 4 range now "every real number field"); the stub banners and
   re-aims (FS-91 closed or re-aimed; FS-82 CLOSED; FS-83, FS-59, FS-64, FS-84, FS-75, FS-47, FS-48 re-aimed as the inventory says); the
   `plans/FRONTIER-STUBS.md` re-rank; the new stubs the milestone surfaced (minted as stub files, `plans/STUB-*.md`, which you may write).
   A front-page job applies the drafts later.
4. **The prior-art position of each headline result**, at exact scope, from the records and the inventory's prior-art debts. A separate
   job (J23p) runs M1's close-time prior-art gate in parallel and writes `plans/FS91-PA-close.md`; fold its verdicts in when its report
   lands (I will forward it). Until then write "pending the close gate" and never "new".

## Stages (each saved and committed, headed `Stage n — SAVED` in the plan's §R-close)

1. The inventory walk: tick or decline every item that needs no drafting (≈ 60k). Save.
2. `plans/FS91-derivation.md` — every theorem filed (≈ 120k). Save.
3. §R-close: re-reads, predictions, verdict, tallies (≈ 60k). Save. Report to me (STAGE 3 SAVED).
4. The drafts: ledger rows, Frontier lines, grokking edits, stub banners and re-aims, re-rank; new stub files (≈ 80k). Save. Report.

## Rules

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. **A successor on this brief is expected** if
  the work outgrows one context: stop at a saved stage, with the inventory's ticks current, and tell me what is left.
- **Never judge a verdict the records reached**; you file it at its grade and status. Where two records disagree, file both with
  addresses and say so.
- **You are the inventory's only writer** while you run (no clerk runs beside you).
- **Touch only:** the plan `plans/FS91-character-local-global.md` (its §R-close), `plans/FS91-derivation.md`, `plans/FS91-close-inventory.md`,
  new stub files, and `data/fs91/j23a/`. Not the four front-page files, not any job record, not the index, not any Lean file.
- **No finite-witness search** (the ban to 2026-10-01); keep the "would have searched here" log.
- **Commits by explicit path** (`git diff -- <path>` first; `git commit <paths> -m …`, never a bare `git commit`). Subjects "J23a: stage n".
  End commit messages with your harness's attribution lines. Push after each stage; never force-push.
- **Budget:** about 350k by the harness's count; hand back with the stage saved by 420k. Agents' own counts run at 40–70 % of the
  harness's.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J23a.md`, committed, and by SendMessage
  `to: "main"`. Keep your turn's final text content-free: "J23a idle; report sent to the owner by SendMessage".

Thank you. M1 is the crunch's headline; its close is where the findings become the project's.
