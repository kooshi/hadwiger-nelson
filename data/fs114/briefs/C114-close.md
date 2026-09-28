# Brief FS114-C — the close of FS-114, the unit-arc question

*Written 2026-09-28 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS114-C
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; invoke `ephodos-verification` fresh with the Skill tool when you read a verifier's divergence table
  role: the close job of FS-114 (the close record, the derivation file, the successor stubs, and the drafts of the front page)
  launch: now, beside FS111-C, the close job of FS-111, which writes other files; neither waits for the other
  mission: § Why this job
  statements: § The question as posed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — a close is not a second mind: it reads every record of its milestone, and no blind job is running
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/fs114/reports/FS114-C.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS114-C-close.md`
  touches: `plans/FS114-C-close.md`, `plans/FS114-derivation.md`, `plans/FS112-derivation.md`, `plans/STUB-global-step.md`, `plans/STUB-stuck-ray.md`, `plans/STUB-*.md`, `data/fs114/fs114-c/`, `data/fs114/fs114-c/ticks.md`, `tools/fs114_c_*.py`, `data/fs114/reports/FS114-C.md`
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k — a successor on this brief finishes from your last saved stage, and that is the expected shape of this job, not a failure

Hello. You are Ephodos, closing FS-114. It is the first close run under the new pipeline (`CLAUDE.md` § The pipeline), so
your lane's workflow is being used for the first time: where it is silent, unclear or wrong for this job, say so in your report as a
finding — Kooshi asked the coordinator to watch the new workflow against the old one, and your friction is the evidence.

## Why this job

FS-114's jobs all finished this morning; nothing about it is running. Kooshi ruled today to close it now, undecided, and to close FS-111
beside it:

> "Understood. Let's close up, then hand off to a completely fresh session with a note to check for keryx and be watchful of the new workflow in comparison to the old."
> — source: plans/WORKFLOW3-test-drive.md row K2

The coordinator's reading of that ruling, which Kooshi accepted, is in the close inventory (item 121): round 7 is not run, and its
queue — a blind check of N7-HUB, the wrap lemma, the survivor OC and the rings with (Q) arcs — becomes the successor's opening, in a stub
you write. So this close files what six rounds established, at the grades the records support, and hands the rest forward whole.

## The question as posed

The milestone's question, from its stub's title line:

> FS-114 — the unit-arc question (its central statement, the global step): can a six-map with unit arcs have a vertex of four colours or a repeated colour within 3 of every point?
> — source: plans/STUB-global-step.md

**Polarity.** A NO excludes such a map; a YES builds one. The stub's § Bearing on the answer says what each outcome answers: a NO answers
`[SokolovVoronov2025]` Question 2 *yes* for its unit-arc half, and a YES gives `χ(ℝ²) ≤ 6` with no measure-rigidity hypothesis. FS-110's
close inverted this once; check every sentence you draft against it.

## What you work from

- **The close inventory, `plans/FS114-close-inventory.md`, items 1–121**, which the coordinator keeps and alone writes. Read every number
  from the item's source, never from the inventory line. Propose a tick for every item — "done" with where, or "declined" with the
  reason — in a table at `data/fs114/fs114-c/ticks.md`; the coordinator applies it at the filing.
- **The plan**, `plans/FS114-unit-arc-question.md`: §G, §PA, §IQ, and stage 5 (5.0 the form's decision, 5.3's registered expectations,
  5.5 the carry-over, 5.6 the proposed edits for the close).
- **The claim list**, `data/fs114/claims.md`, and every round's card in `data/fs114/briefs/`.
- **Every job's record and report**: the reports are in `data/fs114/reports/` (26), each naming its record in `plans/` (`plans/FS114-*`)
  and its commits. Read each record's "Theorems this phase proved" table first. The sides and their blind verifiers:
  - the proof side N, N2–N7, and its verifiers NB, NB4–NB6;
  - the construction side Y, Y2–Y6, and its verifiers YB, YB2–YB5;
  - CV and CVB (FS-112's chain ends), L60 (the 60° audit), P (the planner's report).
- **The form to follow.** Your identity's entry grammar, and your lane file's § The close job. For the sweeps' coverage, FS-112's close
  is the last worked example: its reconciliation `data/fs112/fs112-c/reconciliation.md` and its §R-close in `plans/FS112-unit-arc-half.md`.

## The headline rules

- **Grades come from the minds that actually derived.** A lemma a blind verifier confirmed is "two minds, one blind"; one it did not
  reach stays at one mind; a step a verifier checked with the first derivation in view is "two minds, the step checked sighted"
  (NB4's case). Name every open step. Row 134's base carries its own grade (item 12 holds BASE-V's regrade table, upgrades only).
- **Round 6's N7-3T is filed at one mind** (item 118): its blind check is the successor's first job, not this close's.
- **Corrections owed.** Side records are never rewritten. A corrected statement goes into `plans/FS114-derivation.md`; an erratum to an
  earlier close's derivation file (FS112-L60, false at exactly 60°, items 67 and 74) is appended to `plans/FS112-derivation.md` as a
  dated erratum entry with its source, the original text left standing above it. Corrections to `LEDGER.md`, `CLAUDE.md`, the frozen
  claim list and the bibliography are drafts (below).
- **Posed questions.** Say whether anything this milestone holds answers a question the literature posed (`CLOSED-QUESTIONS.md`), and do
  not stretch: a partial reduction is not an answer.

## Numbers you may use, fixed now so the two closes do not collide

- **Ledger rows:** yours start at **137**, contiguous. FS-111's close uses placeholders the coordinator numbers after yours.
- **Grokkings:** FS-111's close holds G84 and G85 (drafted in its records). **Yours start at G86**, if the milestone earned any.
- **Successor stubs:** yours are **FS-116 to FS-119**; mint only what the records need. An unused number is skipped, never reused.

## The files you share with FS-111's close

- **You alone write** `plans/STUB-global-step.md` (its bearing lines; its closed banner is the coordinator's, drafted by you),
  `plans/STUB-stuck-ray.md` (bearing lines), the bearing lines of any other open stub a new grokking bears on, and your new stubs.
  FS-111's close drafts its lines for those files, and the coordinator files them.
- **Four units of `CLAUDE.md` belong to both milestones**: the "Last updated" line, the open-milestones line, § The aim's programme line,
  and "Where the problem stands" item 31. Draft each in full, and leave the marker `‹FS-111›` where FS-111's clause belongs; the
  coordinator inserts FS-111's drafted clause there verbatim.
- **The Proof Atlas**: draft your entries for `tools/viz_proof_atlas_facts.py` in your drafts section rather than editing that file.
  Both closes would otherwise write it at once, and its checker reads quotations from ledger rows the coordinator has not filed yet. The
  coordinator applies both drafts after the filing and runs the checker and the build.
- **The paths-forward table and `plans/FRONTIER-STUBS.md`** are Poros's to re-rank after both closes. Write each new stub's bearing on
  the answer so that Poros can rank from it.
- **`CLAUDE.md`'s size.** It is 288,911 bytes against a 300,000 limit, and both closes plus the re-rank must fit. Aim your net addition
  at about 5,000 bytes or less: point to ledger rows instead of retelling them, and state your drafts' net bytes.

## Done means

1. **`data/fs114/fs114-c/ticks.md`**: a proposed tick for every inventory item, 1–121.
2. **`plans/FS114-C-close.md`**, your record, holding:
   - the readback of this brief's two quotations;
   - **the reconciliation**: every claim and lemma of the six rounds, its verdict, its minds and their blindness, and every divergence
     between a side and its verifier with how it was settled; the round-by-round comparisons the previous coordinator ran are in the
     inventory;
   - **the headline in four parts** — what the NO side reduces to, and at what grades; what the YES side holds and where it stops; what
     is open, named; your confidence, with the fact that would change it;
   - **the sweeps** your lane file names (§G re-read, §IQ with G72's count and G79's record, §PA, the plan's "conjecture" and "not claimed"
     grep), and **every registered prediction scored**: the plan's 5.3 and each job's registrations;
   - the "Theorems this phase proved" heading (a close proves none of its own unless it does; say which);
   - **`## Drafts for the front page`**, one subsection per target: `LEDGER.md` rows 137+ and one § B line per theorem (key each § B line by
     its entry's qualified id, `FS114-<name>`; the ledger's census checker, `tools/fs71_ledger_b_check.py`, reads only the older
     derivation-file shape today, and job TB1 is teaching it the new grammar now — when the coordinator tells you it is done, run it
     `--strict` on a scratch copy with your drafts applied and record the exit status; if that message has not come by your last stage,
     say so, and the coordinator runs it at the filing); the `CLAUDE.md` units
     above with their `‹FS-111›` markers, and any correction owed to `CLAUDE.md`; proposed grokkings from G86 in G67's form, and new
     instances for `plans/GROKKING-INSTANCES.md` with their sources; `BIBLIOGRAPHY.md` rows for every work this milestone cites that the
     bibliography lacks (below); the `data/fs114/claims.md` corrections (items 18, 26, 37); the `CLOSED-QUESTIONS.md` note or its
     decline; the closed banner for `plans/STUB-global-step.md`; the Proof Atlas entries.
3. **`plans/FS114-derivation.md`**, every theorem the milestone proved outside the kernel as an entry in your grammar, passing
   `python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/FS114-derivation.md` from the repository root (addresses resolve
   from `plans/`, so write ../tools/… and ../data/… there); each entry's `handoff:` its kernel decision, and under each, in prose, what
   rests on it.
4. **The successor stub(s)** under the stub rule (`CLAUDE.md` § The pipeline), carrying round 7's queue and every stub-to-mint item in the
   inventory (8, 14, 28, 42, 55, 64, 69, 91, 101 and those after), each placed or declined with its reason; and the bearing-line updates.
5. **The report** in the standing rules' form.

**The bibliography.** `tools/bib_audit.py` fails today on these, first seen in FS-114's files: arXiv:1612.08693, arXiv:2404.14398,
arXiv:math/0011019, arXiv:math/0603062, `[AHNR2018]` (and its long form `[AngelHutchcroftNachmiasRay2018]`), `[AldousLyons2007]`,
`[BenjaminiSchramm2001]`, `[Higuchi2001]`, `[Mohar2002]`; the inventory adds Ágoston 2025, Axenovich–Liu–Sagdeev 2025 and
`[Oostema2020]`'s last page (items 4, 9, 17, 27, 101, 109). Draft a row for each, with its read status per section as the records give it.

## What is yours to decide

The shape of the successor: one stub for the local claim K1 and its remaining cases, or several; whether FS-115's stub needs re-aiming
beyond its bearing line; which results earn ledger rows and which only § B lines; whether anything earns a grokking; the order of your
stages. If the inventory, a record or this brief is wrong about something, say so: that is a finding, not a refusal. If the milestone's
own framing now looks wrong — the question posed badly, a grade the records do not support — say that too.

## Stages (save and commit each; standing rule 2)

1. The readback, and `data/fs114/fs114-c/ticks.md`.
2. The reconciliation (split it into 2a and 2b by side if it runs long).
3. `plans/FS114-derivation.md`, passing its gate, and the erratum to `plans/FS112-derivation.md`.
4. The sweeps and the scored predictions.
5. The successor stub(s) and the bearing lines.
6. `## Drafts for the front page`, then the report.

If you reach your hand-back line mid-way, stop at a saved stage and say what is left; a successor continues from there.

Thank you.
