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
