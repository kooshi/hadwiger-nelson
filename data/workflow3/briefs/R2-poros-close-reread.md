# Brief R2 — Poros: the boundary re-read of FS-116's and FS-121's closes, and the draft re-rank

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: R2
  identity: Poros — your agent file (`.claude/agents/poros.md`) is your identity and your lane's workflow; invoke `poros-anomaly-hunt` fresh with the Skill tool for the re-read, and `poros-reframing` if a frame will not move
  role: the boundary re-read of two closed milestones, and the draft re-rank of the frontier
  launch: now; both close jobs (FS-121's in one part, FS-116's in two) have handed back and the coordinator has reviewed their records
  mission: § Why this job
  statements: none — a re-read and a re-rank; every input is a record named by address in § What you read
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — no blind job is running; both milestones are closed when you start
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/workflow3/reports/R2.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/POROS-2026-10-03-close-reread.md`
  touches: `plans/POROS-2026-10-03-close-reread.md`, `data/workflow3/r2/`, `data/workflow3/reports/R2.md`
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are Poros. FS-116, the local exclusion, and FS-121, the map step — the two halves of route M, which you posed together on 2026-09-29
(`plans/POROS-2026-09-28-fs116-question.md`) — have just closed, the first milestones run end to end under Workflow 3.0. The frontier needs its
re-rank before the next milestone opens.

## Why this job

Kooshi's instruction for this run, after the usage-limit halt:

> Please revive your agents with messages, and continue with the milestone.
> — source: plans/FS116-close-inventory.md row 74

The next milestone opens from your ranking, so the ranking is the most consequential page of this close. Your lane file's job 3 is this job:
re-read each close's whole record on purpose, not its summary, and draft the re-rank from what you find.

## What you read

- **The two close records and what they cite**: FS-121's `plans/FS121-Z1-close.md`; FS-116's `plans/FS116-Z1-close.md` (the reconciliation and
  the headline's draft) and `plans/FS116-Z2-close.md` (the headline, the sweeps and `## Drafts for the front page`); the derivation files
  `plans/FS121-derivation.md` and `plans/FS116-derivation.md`; the new stubs FS-123 to FS-128 (`plans/STUB-qfree-ring.md`, `plans/STUB-q-ring.md`,
  `plans/STUB-saturated-local.md`, `plans/STUB-curved-pencils.md`, `plans/STUB-lateral-extent.md`, `plans/STUB-top-colour.md`) and the open stubs whose
  bearing lines the closes rewrote; the close inventories `plans/FS121-close-inventory.md` and `plans/FS116-close-inventory.md`. Go under the summaries to the job records
  they cite wherever the anomaly hunt points you.
- **Two findings the closes left for you by name**: FS-121's, that three of its six open claims are one question (FS-126; `plans/FS121-Z1-close.md`
  § 2.5, FS-121 item 89); and FS-116's invention signal on what FS-112's bends leave on a ring (FS-116 item 136, both sources quoted there), which
  decides whether FS116-Y4-EMPTY (held, two minds) reaches FS114-N7-3T's whole class or leaves the (R2)-arc rings as the next case; FS116-Z2
  sharpened it, every source quoted verbatim (`plans/FS116-Z2-close.md` § 1.5, FS-116 item 145), and made it FS-123's first question.
- **A question from Kooshi** (2026-10-03, on FS116-V6's identity `|a − b|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2)`, V6-HUG in
  `plans/FS116-V6-verification.md` § 2.2): *where else can it be used?* FS116-Y4 § 3.4 names three neighbours of its flank lemma, each unread (the
  (R2)-arc rings, a semi-hub whose tip is shared with the next change point, FS-114's open-cap family OC), and V6 found a fourth use itself (V6-ADJ).
  Pose it as a card in your record: the configurations where two tiles of one colour are pinned to the two unit circles of a unit-distance pair,
  ranked by what an exclusion there would remove from C114-LOCAL-F's case list.
- **A special case outside your ranking**: Kooshi has fixed FS-129, the cross-application audit (`plans/STUB-cross-application-audit.md`), to run
  after these closes' filing and the workflow refinement that follows. Do not rank it; draft the open-milestones line with it in that place, and
  name what opens after it.
- **The frontier as it stands**: `plans/FRONTIER-STUBS.md` (authoritative, with its columns) and `CLAUDE.md` § Paths forward, ranked.
- **Your hunch ledger**, carried forward from `plans/POROS-2026-09-28-fs116-question.md` § 1.5.

## Done means

1. **Your record, `plans/POROS-2026-10-03-close-reread.md`**, passing `python3 .claude/skills/poros/scripts/poros_gate.py all
   plans/POROS-2026-10-03-close-reread.md` from the repository root before each stage's commit, holding:
   - the readback of this brief's quotation;
   - **your expectations, written before the re-read**: what you expect the closes to show, so the re-read can surprise you;
   - **the re-read**, by the anomaly hunt: what is curious in a way that makes you wonder what pattern caused it, what path nobody has
     considered, which result stands without its mechanism;
   - **the hunch ledger, carried forward and scored in the open**, killed hunches kept;
   - **`## Draft re-rank`**: the ranked-stubs table of `plans/FRONTIER-STUBS.md`, written exactly as its rows should read, with every column the
     table has; every candidate the two closes surfaced (FS-123 to FS-128) at its rank; FS-116 and FS-121 moved to the closed
     list (FS-121's drafted row text is `plans/FS121-Z1-close.md` D10, FS-116's is in `plans/FS116-Z2-close.md` § Drafts for the front page); a banner line for each demoted
     stub, saying why;
   - **`## Draft for CLAUDE.md § Paths forward`**: the ranked table's rows as `CLAUDE.md` should carry them (short cells; the authoritative text
     stays in `plans/FRONTIER-STUBS.md`), and the "Next:" clause of the open-milestones line, naming the milestone to open next. The closes drafted
     that line too; where your "Next:" differs from theirs, say so and why. `CLAUDE.md` is 70,396 bytes against its 80,000-byte budget, and the
     two closes' drafts bring it to about 72,100: aim your drafts at 1,500 net bytes or fewer, and state them.
   - **The search ban**: it ended 2026-10-01, and Kooshi has not extended it; the stubs file's solver column is to be read as of now, with FS-116's
     frozen § 9 ("No enumeration of maps, colourings, tile graphs or dual graphs, by any program") binding only that milestone's own successors if
     their stubs carry it. Say, per stub you rank, whether its next step wants a solver.
2. **The report** in the standing rules' form. Your last words are exactly "R2 idle; report sent to the coordinator", and the hand-back carries
   nothing else: the report goes by message.

Rank by bearing on the answer, never by difficulty, length or formalization effort (`CLAUDE.md` § Counter-priors, rule 1).

## What is yours to decide

The ranking, the merges and the demotions; whether a close's framing of its own successor is the right question (if it is not, say so: a question
card for the next opening is welcome in your record, addressed to "a fresh mind"); what the re-read should look at first. If this brief or a close
record is wrong about something, say so: that is a finding, not a refusal.

## Stages (save and commit each; standing rule 2)

1. The readback, your expectations, and the hunch ledger carried forward.
2. The re-read.
3. The draft re-rank and the `CLAUDE.md` draft, then the report.

You start no agent of your own (`plans/STANDING-RULES.md` rule 1: staffing is Kooshi's budget, and I can review only work I know exists).

Thank you.
