# FS-129 close inventory (opened by Keryx, 2026-10-03 22:38 UTC; Keryx is its only writer until the close)

*Milestone: FS-129, the cross-application audit (`plans/STUB-cross-application-audit.md`; the plan `plans/FS129-cross-application-audit.md`).
One line per item with its source; no narration. Each line is ticked done or declined with its reason by the close.*

## Rulings in force

1. **Kooshi's four decisions** (2026-10-03, verbatim in the plan § 1): open steps, then mechanisms, then merges, never pairwise; the cap of
   three agents, the readers `general-purpose` agents reading the deriver's identity, not the agent files that preload the grokkings; the audit
   prepares the Lean backlog's input; the arithmetic era is asked whether it bears on the measurable question.
2. **Poros runs as its own agent type** (`poros`, grokkings preloaded) for the card and the re-rank — Keryx's default, since decision 2 named
   the readers. Alternative weighed: a `general-purpose` agent reading Poros's identity. Why: ranking is reasoning from the theory, which the
   preload carries. Confidence: medium; Kooshi's word overrides.
3. **No announcement rule beyond Workflow 3.1's**: a composition is "derived, one mind" until its Lean module passes the gate; nothing in
   FS-129 is blind.

## Registered expectations

- **Keryx's priors** (stated to Kooshi 2026-10-03 before any job; Keryx's, not a lane's, and not scored as a lane's): most of the yield is
  housekeeping — merges, weaker hypotheses, disagreeing records; a hit from the arithmetic era on the measurable question is unlikely and
  would be the most surprising find.
- The lanes' expectations: copied here from each reader's first saved stage and from Poros's card (plan § 7).

## Items

1. Opened 2026-10-03 22:38 UTC: the plan, this inventory, the stub's method section, `CLAUDE.md`'s and `plans/FRONTIER-STUBS.md`'s open-milestone lines. Source: this commit.
2. **Workflow friction:** `/clear` reloads `CLAUDE.md` but not the output style, so a cleared session ran Keryx on Workflow 3.0's
   instructions (its system prompt lacked "Workflow 3.1"); FS-129's first jobs therefore launch from a restarted session. Rule: after a change
   to `.claude/output-styles/keryx.md`, restart, never clear. Source: this session; `plans/SESSION-HANDOFF-2026-10-03.md` § 1.
3. **The prompting instances** that pass 2 must cover (stub § Why now): FS116-Y4 and G83's straddle (`plans/FS116-close-inventory.md` items
   122, 124, 127); V6-HUG and "where else can we use that identity?" (item 142); FS-112's bends stated two ways (item 136, pass 3). FS-121's
   three-into-one (`plans/FS121-Z1-close.md` § 2.5) is already FS-126.
4. **Closed in the Lean backlog's session**: FS-129's compositions join the backlog's queue (plan § 3, Closed).
5. **Launched 2026-10-03 22:45 UTC** (Kooshi's word: "You are go for the audit."): FS129-IX1, the index (`clerk`, Sonnet;
   `data/fs129/briefs/FS129-IX1-index.md`), and FS129-Q1, the question card (`poros`, Opus; `data/fs129/briefs/FS129-Q1-card.md`), both at
   `ddf5abfd`. IX1's brief gated PASS; Q1's FAIL twice, judged false (item 6). Two agents running, of the cap of three.
6. **Tool defect — the brief gate, U8:** a backticked path that a parallel job writes fails "does not exist"; Q1's brief names
   `data/fs129/index/`, which IX1 writes. Noted in the brief, launched, filed in agent-forge (its forge/STATUS.md, Keryx section,
   agent-forge commits `bf2d79c` and `a9427a5`, the second adding a repro script beside the earlier defects' evidence; not pushed). Source: `data/fs129/briefs/FS129-Q1-card.md` § Gate note.
7. **Ruling — the eight derivation files with no milestone number** (`ASTRA-2026-09-14`, `MASCOT`, `Q8`, `R52`, `R57`, `R59`, `R88`, `TC1`)
   are placed in an era by the `LEDGER.md` § B section their theorems are listed under; unplaceable ones go to `CHECK:`. Alternative weighed:
   by each file's first commit date against FS-104's opening. Why: § B's sections already name the milestone, so the rule needs no date
   judgement. Confidence: high. Source: IX1's brief § What you work from.
8. **Ruling, pending — the merged demand list** (plan § 3 Stage 1 says pass 1 "works the merged list" without saying who merges): the pass-1
   readers get both halves — Poros's ranked `data/fs129/demand-judged.md` first, then the index's mechanical `data/fs129/index/open-steps.md`
   entries not on it, in their stubs' rank order — and no separate merge job. Alternative weighed: the Clerk merges them into one file first.
   Why: a merge needs a judgement about which mechanical step is the same as a judged one, which is the readers' work, not the Clerk's.
   Confidence: medium; changes if Poros's list already absorbs the mechanical half.
9. **FS129-IX1 reported DONE** (`data/fs129/reports/FS129-IX1.md`; commits `21bf0b1d`, `46ed4113`, `777c88f4`, all present): 1,295 theorems
   (A 770, R 474, CHECK 51), 1,328 edges, 197 results in the Lean order from 78 seeds. **Keryx's receipt**: re-ran `tools/fs129_index.py
   --self-test`, exit 0, PASS; drew five records at random (seed 20261003) and read each against its file line — FS111-REG-A6
   (`plans/FS111-derivation.md:1367`), M63H4-T3 (`plans/M63H4-derivation.md:64`), ASTRA-2026-09-14-T9 (`plans/ASTRA-2026-09-14-derivation.md:51`),
   FS70-T9 (`plans/FS70-derivation.md:76`) match field for field; **FS100-TCA** (`plans/FS100-derivation.md:289`) does not — its
   `statement` holds the entry's `*Also:*` sentence (X25B-PZ, X25B-LP), its own statement is only in `title`; the one older entry of 1,003
   whose body opens so (Keryx's count). Correction owed to the index: item 15.
10. **Kooshi's note on roots** (2026-10-03 22:56 UTC), verbatim in the plan § 1 and applied to § 3 Stage 0: deep roots weigh as hubs do. The
    index gains `data/fs129/index/roots.md` (item 15), and every reader's brief names roots beside hubs.
11. **Ruling — the 51 era-CHECK theorems go to lane A** (ASTRA-2026-09-14, MASCOT, Q8, R52, R57, R59, R88, TC1): every one is filed under a date
    from 2026-09-08 to 2026-09-14 or a ledger row at or below 88, all before FS-104 opened. Alternative weighed: leave them CHECK for the readers
    to place. Why: their § B lines already date them inside the arithmetic era; a reader placing them would spend judgement on bookkeeping.
    Confidence: high. Supersedes item 7's rule where § B gives a date or a row.
12. **Ruling — FS-105 stays in lane R**, by its number (plan § 5: "The boundary is by milestone number"), although its § B column holds rows
    120, 128, 129 (measure rigidity, the collapse). Alternative weighed: move it to A, whose description in § 5 names the collapse. Why: the
    collapse states the plane's number as the measurable one, which is lane R's subject; lane A still reads it, since each lane reads the whole
    corpus. Confidence: medium.
13. **Ruling — the Lean order keeps all 78 seeds**, the three `none`-led handoffs that name de Bruijn on a later line (FS116-Y4-SPOKE,
    TC1-SQRT3-DYADIC, TC1-STANDING-FIVE) flagged as conditional: each crosses "with" another result or "if" something is formalized. The
    backlog session decides; FS129-L1 quotes the handoff text. Alternative: drop them to match the plan's 77. Why: dropping hides a
    condition the backlog needs. Confidence: high.
14. **Accepted from IX1's proposals**: an edge source `grade` for the ids a `derived from:` grade names. Declined: hubs split by grammar
    (the roots file and the orphans caveat carry the same warning more cheaply).
15. **Amendment to FS129-IX1** (dated 2026-10-03 in its brief): `roots.md` and depth columns; `grade` edges; FS100-TCA's statement and every
    `*Also:*` claim listed; items 11–12's eras applied; the 22 files with no entry checked for theorems no indexed entry carries. IX1
    continued by message (well below its line).
16. **Statement defect, found by IX1 — credit to the Clerk**: the grokkings skill's description says "entries G1 to G87"; the file holds
    G1–G91. Keryx's file; fixed in the same commit as this line.
17. **Tool defect — the brief gate, U9:** a backticked `dir/file:line` address to an existing file fails "does not exist"; met on the
    first draft of IX1's amendment, reworded to pass. Filed in agent-forge with a repro (agent-forge commit `fa3de16`, not pushed), beside U8
    (item 6), at Kooshi's word ("quickly file the defects in the brief checker to ../agent-forge alongside the others, so I can fix them
    later", 2026-10-03).
18. **FS129-IX1's amendment reported DONE** (commit `02a4a553`; report `data/fs129/reports/FS129-IX1.md`). **Keryx's receipt**: the commit's
    18 files are all under `data/fs129/` or `tools/fs129_index.py`; `--self-test` re-run, exit 0, PASS; `data/fs129/index/roots.md` read — the
    longest chain of dependents has 13 edges, from FS111-V0-ID1 or FS111-C-HULL-SO to FS121-Z1-NOCURVED. Eras now A 821, R 474, CHECK 0.
    FS100-TCA corrected. IX1 closed; its context (≈210k by its count) is not reused.
19. **Finding for the readers — the roots ranking leans to lane R**: 87 of `roots.md`'s 100 are lane R (FS-111 to FS-121); the 13 lane-A rows
    are FS-89, FS-91 and one FS-66 (ranks 21 to 100, chains of 5 to 8 edges), all milestones whose records name their dependencies by id.
    Older-format entries carry no `uses only:`, so their edges come from prose (IX1's CHECK), and an arithmetic-era root of a long chain may
    be missing. Every reader's brief says so; lane A finds the rest of its roots by reading. Source: `data/fs129/index/roots.md` (header and
    the era column); IX1's report. *Corrected 2026-10-03 by Keryx: the first text of this line said "all 100 … are lane R", written from
    the top rows before counting the era column; the count is 87 R, 13 A.*
20. **For the readers — two `*Also:*` claims with no record**: X25B-PZ and X25B-LP (`plans/FS100-derivation.md` line 289); and 68 ids defined in
    the no-entry files appear in no indexed entry, three files wholly (FS100-X28D, FS84-S1, FS84-SI-D). Lane A's pass 3 (merges) owns them.
    Source: `data/fs129/index/checks.md`.
21. **Slip, IX1's, self-reported**: stage 4 committed with `git commit -a` against standing rule 6; the commit holds only its own files
    (checked, item 18). No harm; logged because the rule exists for a shared tree.
