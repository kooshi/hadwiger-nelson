# Brief FS116-Z2 — the close of FS-116, the local exclusion: part 2 (the sweeps, the stubs and the drafts of the front page)

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS116-Z2
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; invoke `ephodos-verification` fresh with the Skill tool when you read FS116-V6's divergence table
  role: part 2 of FS-116's close job — FS116-V6's verdict folded in, the sweeps, the scored predictions, the successor stubs, the errata, and the drafts of the front page
  launch: now; part 1 (FS116-Z1) and FS116-V6 have both reported, and no job of FS-116 is running
  mission: § Why this job
  statements: § The question as posed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — a close is not a second mind, and no blind job of either open milestone is running
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/fs116/reports/FS116-Z2.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS116-Z2-close.md`
  touches: `plans/FS116-Z2-close.md`, `plans/FS116-derivation.md`, `plans/FS114-derivation.md` (dated erratum entries appended, the original text left standing), `plans/STUB-local-exclusion.md`, `plans/STUB-route-t-count.md`, `plans/STUB-*.md` (your new stubs, and the bearing lines of open stubs FS-116's results bear on), `data/fs116/fs116-z2/`, `tools/fs116_z2_*.py`, `data/fs116/reports/FS116-Z2.md`
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k — a successor on this brief finishes from your last saved stage

Hello. You are Ephodos, finishing the close of FS-116, the local exclusion. Part 1 (FS116-Z1) reconciled every claim, wrote the derivation file and
drafted the headline; you work from its files and do not redo its reading. Where the split close made your job harder or easier, say so in your
report: it is the first close run in two parts, and Kooshi asked the coordinator to watch the new workflow.

## Why this job

FS-116's rounds and their verifiers are all reported. Kooshi's instruction for this run, after the usage-limit halt:

> Please revive your agents with messages, and continue with the milestone.
> — source: plans/FS116-close-inventory.md row 74

FS116-V6 has reported: FS116-Y4-EMPTY is TRUE by a second route, blind, the same model, resting on none of round 3's statements, and the
coordinator ruled the announcement rule met (the inventory's items 138–139). So the Γ-free four-colour vertex leaves C114-LOCAL-F's case list at
radius 1 + ε in the non-Siamese simple class, and the statements of items 124 and 135 are filed as true vacuously. Part 1 reconciled everything
else; this job folds that in and writes what the front page and the successor stubs need.

## The question as posed

> FS-116 — the local exclusion: is there an explicit radius about a four-colour vertex within which no valid six-map fragment with unit arcs exists? (stub)
> — source: plans/STUB-local-exclusion.md

## What you work from

- **Part 1's files**: `plans/FS116-Z1-close.md` (the reconciliation, §§ 2.1–2.6; the headline's draft, § 4.2; part 2's list, § 1.4),
  `plans/FS116-derivation.md` (86 entries; you are its next writer), `data/fs116/fs116-z1/ticks.md` (part 2's items marked), and
  `data/fs116/fs116-z1/ledger-b-draft.md` (86 § B lines).
- **The close inventory**, `plans/FS116-close-inventory.md`, items 1–140 and the W- and O-tables; items 132–140 arrived after part 1. Read every
  number from its source.
- **FS116-V6's record and report**, `plans/FS116-V6-verification.md` and `data/fs116/reports/FS116-V6.md`.
- **FS-121's close, today**, for two things: its drafted lines for the two stubs you write (`plans/FS121-Z1-close.md` D8, to be placed verbatim) and
  its ‹FS-121› clauses for the four `CLAUDE.md` units the two milestones share (D2, to be placed verbatim in your drafts of those units); and its
  § Drafts for the front page as the form to follow.
- **The plan**, `plans/FS116-local-exclusion.md` (§G, §PA, §IQ, § 4.5's registered predictions), and the stub `plans/STUB-local-exclusion.md`.

## The headline rules

- **Grades come from the minds that actually derived**; "held" is the announcement rule's (the inventory's top). Fold V6's verdict into
  FS116-Y4-EMPTY's entry (held, item 139) and turn the conditional notes of items 124 and 135 into "true vacuously"; V6's lemmas (item 140) are
  entries at one mind.
- **Frozen statements are never edited.** The withheld parenthetical of EMPTY's *not claimed* line (the list's § 15 note) is restored in the
  derivation file from the proposing record.
- **The invention signal on the bends** (item 136) is carried, both sources quoted verbatim, into the successor stub whose case list it decides; do not
  settle it by assertion.
- **A no-go is a result** (Kooshi: "All novel knowledge is a success").

## Numbers fixed now

- **Ledger rows:** draft as `‹R116-a›`, `‹R116-b›`, …; the coordinator numbers them after FS-121's three at the filing. Update part 1's § B drafts
  for V6's verdict and re-run `python3 tools/fs71_ledger_b_check.py --strict` on a scratch copy with both milestones' drafts; record the exit status.
- **Grokkings:** from **G91** (FS-121 has G88–G90). **Successor stubs:** **FS-123 to FS-125**. Mint only what the records earn; an unused number is
  skipped, never reused.
- **Sizes.** `CLAUDE.md` is 70,396 bytes against its 80,000 budget, and FS-121's drafts add about 1,400; the re-rank must still fit. Aim your net
  addition at about 2,500 bytes or less, and state your drafts' net bytes. The grokkings file is 162,397 of 200,000, and FS-121 adds about 3,500.

## Done means

1. **`plans/FS116-derivation.md`** updated: EMPTY's entry from V6's verdict, the vacuity notes (items 124, 135), and V6's own lemmas if it states any;
   passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/FS116-derivation.md`.
2. **`plans/FS116-Z2-close.md`**, your record, holding:
   - the readback of this brief's quotations;
   - **the headline in four parts**, final (part 1's draft, § 4.2, with V6's verdict);
   - **the sweeps** your lane file names (§G re-read, §IQ and G79, §PA, the plan's "conjecture" and "not claimed" grep), and **every registered prediction
     scored** (the plan's § 4.5, the predictions copied at the freeze, N7's two carried registrations, and each job's own);
   - the "Theorems this phase proved" heading;
   - **`## Drafts for the front page`**, one subsection per target, in FS-121's form: `LEDGER.md` rows `‹R116-a›`… with the § B lines; the four shared
     `CLAUDE.md` units **in full**, FS-121's clauses placed verbatim at their markers, and every correction owed to `CLAUDE.md`; G91 on in G67's form,
     and new instances for `plans/GROKKING-INSTANCES.md` with their sources (FS116-Y4's G83 instance, item 127, verbatim); `BIBLIOGRAPHY.md` rows
     not yet filed; the `data/fs116/claims.md` notes; the `CLOSED-QUESTIONS.md` note or its decline; the closed banner for
     `plans/STUB-local-exclusion.md`; the Proof Atlas entries; FS-116's `plans/FRONTIER-STUBS.md` row for Poros.
3. **The errata** to `plans/FS114-derivation.md` (items 10, 39 and 110 with FS116-N1's replacement line, 71), each a dated erratum entry with its
   source, the original standing above it, both files' gates and the census passing after.
4. **The successor stubs**, FS-123 to FS-125, under the stub rule (`CLAUDE.md` § The pipeline), carrying every stub-to-mint item and every owed second
   mind (part 1's § 2.6 gathers them; Kooshi left QF's owed, item 115), each placed or declined with its reason; the bearing lines of
   `plans/STUB-local-exclusion.md` and `plans/STUB-route-t-count.md` (FS-121's D8 lines placed verbatim beside yours), and of every other open stub
   FS-116's results bear on.
5. **The report** in the standing rules' form. Your last words are exactly "FS116-Z2 idle; report sent to the coordinator", and the hand-back carries
   nothing else: the report goes by message.

## What is yours to decide

The shape of the successor stubs — merged or kept apart; which results earn ledger rows and which only § B lines; which drafted grokkings earn a place;
the order of your stages. If the inventory, part 1's files or this brief is wrong about something, say so: that is a finding, not a refusal.

## Stages (save and commit each; standing rule 2)

1. The readback, V6's verdict folded into the derivation file, and the errata.
2. The sweeps and the scored predictions.
3. The successor stubs and the bearing lines.
4. `## Drafts for the front page`, then the report.

If you reach your hand-back line mid-way, stop at a saved stage and say what is left; a successor continues from there. You start no agent of your own
(`plans/STANDING-RULES.md` rule 1: staffing is Kooshi's budget, and I can review only work I know exists).

Thank you.
