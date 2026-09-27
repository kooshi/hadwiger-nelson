*Brief for job **FS105-C**: the close of FS-105, harden MR (WORKFLOW step 9) — its mathematics and drafts. Opus 5.5, 2026-09-26. Written by
the product owner. Its template is FS-103's close brief (`data/fs103/briefs/C103-close-math.md`); follow its form where this brief is silent.
**Sized for about 220k harness tokens; hand back by 320k.** A front-page job (FS105-X) applies your drafts afterwards.*

Hello. You are de Bruijn (`DEBRUIJN.md`), the close planner, in `/home/kooshi/source/lean-dir`. **`data/fs105/briefs/STANDING-RULES.md` is part
of this brief.** Read from disk `CLAUDE.md`'s header rules, `WORKFLOW.md` step 9 in full, and `LEDGER.md` rows 116–130 with their § B lines.
**If `plans/FS105-harden-mr.md` already has a section "§R-close", you are resuming.**

## What you work from

- **`plans/FS105-close-inventory.md`** (items 1–33): tick each "done" or "declined, with the reason" (you may edit its status column). Read
  every number from the item's source.
- The reports `data/fs105/reports/` and the records they name: `plans/FS105-R-reading.md`, `plans/FS105-D-deduction.md`,
  `plans/FS105-B-derivation.md`, `plans/FS105-W-walk.md` (each "Theorems this phase proved" first). Also the advisor's
  `plans/POROS-2026-09-26-fs105-harden-mr.md` (its §2.1 holds the key for classifying B's result against X01V's stall) and the plan
  `plans/FS105-harden-mr.md` (§G, §PA, §IQ, §E).

## The headline rules

- **MR's grade is rewritten, not re-rowed**, unless a new theorem earns its own row: row 120's grade and its prior-art cell, and FS100-PE2's
  and FS100-EFP's entries, in current-state wording.
  - EL2021 Thm 1.2 rests on EL2021 Thm 1.3 [external, published], plus the deduction 1.3 ⟹ 1.2 [hand, two minds: FS105-R; FS105-D blind].
    EL2003 is an announcement, not a proof.
  - PE-2's use is within the hypotheses [reading, one mind; the advisor's three items confirmed].
  - EF_F⁺ has three blind derivations plus one checking reading; EF_F⁰ is TRUE.
  - MR at degree 16 has a checking walk, one mind (C-MR16).
  - The reading gap at EL2021's cited leafwise-measure machinery is named as a reading gap, not a mathematical one.
- **Row 129's test:** the two forms a finite-graph refutation of MR must take, (W) and (W′), with their margins. Say whether they earn a row
  or a sentence in row 129.
- The owner's rulings stand: ℚ(√635087) stays FS-103's headline carrier (item 33); fetching EL2021's [10], [11] and [5] is declined for now
  (item 21).
- **The covert channels** (items 12, 24): the session transcripts, `chats-bak/` and the shared harness scratchpad were open to every blind job
  of FS-103 and FS-105. None reported reading them; FS105-B confirmed "none". Draft:
  - the G51 instance for `plans/GROKKING-INSTANCES.md`;
  - the fence-template fix for `plans/PROTOCOL-competitor-and-advisor.md` and `plans/PROTOCOL-crunch.md`: fence the transcripts and
    `chats-bak/` by name; give each blind job its own scratchpad subdirectory.

## Stages (save after each)

1. Reconciliation: claims (a0)–(a9), (b), (c), (d1)–(d3) and the advisor's items, with each verdict, its minds and blindness. Save.
2. `plans/FS105-derivation.md` (new), in `plans/FS100-derivation.md`'s entry form. Save.
3. §R-close in `plans/FS105-harden-mr.md`: the §G re-read, the §PA sweep, the §IQ re-read with G72's count and G79's record, §E scored, the
   verdict in four parts, the would-have-searched lines. Save.
4. Drafts in §R-close, never in the target files:
   - row 120's grade and prior-art cell, and row 129's sentence or a new row;
   - `LEDGER.md` § B lines;
   - the `CLAUDE.md` lines: "Last updated"; "Open milestones"; the paths-forward rows (FS-105 closed, FS-104 or the next at rank 1); G80's
     Do line (W §5.3); any correction owed (items 19, 23, 30);
   - `BIBLIOGRAPHY.md`: EL2003 and Sataev held and read; EL2021's reading status; `[BekkaFrancini2022]`; the unread titles;
   - `plans/FRONTIER-STUBS.md`: FS-105 to the closed list;
   - the FS-105 stub's banner (a file you may edit);
   - the GROKKING-INSTANCES entries and the two protocol-template fixes.

   Keep `CLAUDE.md` under 300,000 bytes after the front page (it is at 296,232). Save; the report.

## Rules

- **Touch only:** `plans/FS105-derivation.md`, `plans/FS105-harden-mr.md` (§R-close), `plans/FS105-close-inventory.md` (status cells),
  `plans/STUB-harden-mr.md`, `data/fs105/fs105-c/`. Never the front files, the protocols or the instances file (the front page writes those).
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about.
- **Commits:** by explicit path, subjects "FS105-C: stage n". Never amend; push; never force-push.
- **Report** (standing rule 9) to `data/fs105/reports/FS105-C.md`, committed, and by SendMessage to "main". Final turn text: "FS105-C idle;
  report sent to the owner by SendMessage".

Thank you.
