# Brief FS111-C — the close of FS-111, the cone scale

*Written 2026-09-28 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS111-C
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; invoke `ephodos-verification` fresh with the Skill tool when you read a verifier's divergence table
  role: the close job of FS-111 (the close record, the derivation file, the successor stubs, and the drafts of the front page)
  launch: now, beside FS114-C, the close job of FS-114, which writes other files; neither waits for the other
  mission: § Why this job
  statements: § The question as posed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — a close is not a second mind: it reads every record of its milestone, and no blind job is running
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/fs111/reports/FS111-C.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS111-C-close.md`
  touches: `plans/FS111-C-close.md`, `plans/FS111-derivation.md`, `plans/FS107-derivation.md`, `plans/STUB-reg-scale.md`, `plans/STUB-*.md`, `data/fs111/fs111-c/`, `data/fs111/fs111-c/ticks.md`, `tools/fs111_c_*.py`, `data/fs111/reports/FS111-C.md`
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 500k — a successor on this brief finishes from your last saved stage

Hello. You are Ephodos, closing FS-111. It is one of the first two closes run under the new pipeline (`CLAUDE.md` § The pipeline), so
your lane's workflow is being used for the first time: where it is silent, unclear or wrong for this job, say so in your report as a
finding — Kooshi asked the coordinator to watch the new workflow against the old one, and your friction is the evidence.

## Why this job

FS-111's jobs all finished this morning; nothing about it is running. Kooshi ruled today to close it now, beside FS-114:

> "Understood. Let's close up, then hand off to a completely fresh session with a note to check for keryx and be watchful of the new workflow in comparison to the old."
> — source: plans/WORKFLOW3-test-drive.md row K2

The coordinator's reading of that ruling, which Kooshi accepted, is in the close inventory (item 38): the next step the last job named, the
pinch at a junction, is not run; it goes to a stub. So this close files what three rounds established, at the grades the records support,
and hands the rest forward whole.

## The question as posed

The milestone's question, from its stub's title line:

> FS-111 — the cone scale (REG-SCALE): do near-optimal band-proper six-colourings keep their junctions fat?
> — source: plans/STUB-reg-scale.md

**What its answer bears on.** The stub's § Bearing on the answer: a family refuting it with holes tending to 0 is `χ(ℝ²) ≤ 6` with no
measure-rigidity hypothesis; with FS-114's NO it was read as the route to `χ_m⁰(ℝ²) = 7`. The milestone's first result changed that
reading — seven needs a third statement, the NO made uniform in the complexity bound (inventory item 1, card 1 at two minds) — and the
front page still carries the old reading (item 2). Check every sentence you draft against which of the two routes it belongs to.

## What you work from

- **The close inventory, `plans/FS111-close-inventory.md`, items 1–38**, which the coordinator keeps and alone writes. Read every number
  from the item's source, never from the inventory line. Propose a tick for every item — "done" with where, or "declined" with the
  reason — in a table at `data/fs111/fs111-c/ticks.md`; the coordinator applies it at the filing.
- **The plan**, `plans/FS111-cone-scale.md`: card 1 (stage 2), §G, §PA, §IQ, and stage 6 (6.3's registrations, 6.5's stub drafts, 6.6's
  proposed edits for the close); the stub drafts it names, `data/fs111/fs111-p/STUB-DRAFT-map-step.md` and
  `data/fs111/fs111-p/STUB-DRAFT-forced-pair.md`.
- **The claim list**, `data/fs111/claims.md`, and the briefs in `data/fs111/briefs/`.
- **Every job's record and report**: the reports are in `data/fs111/reports/` (9), each naming its record in `plans/` (`plans/FS111-*`)
  and its commits. Read each record's "Theorems this phase proved" table first. The jobs: P (the planner, card 1), M, M2, M3, M4 (the
  regularity route), W (the wild side), and the verifiers V0, VMW, VM2.
- **The form to follow.** Your identity's entry grammar, and your lane file's § The close job. For the sweeps' coverage, FS-112's close
  is the last worked example: `data/fs112/fs112-c/reconciliation.md` and the §R-close in `plans/FS112-unit-arc-half.md`.

## The headline rules

- **Grades come from the minds that actually derived.** A lemma a blind verifier confirmed is "two minds, one blind"; one it did not
  reach stays at one mind. Name every open step. M3 and M4's results are one mind each (items 34, 37).
- **A reformulation is not progress** (the previous coordinator's ruling, item 31: REDUCE-C is an equivalence at five, so the
  regularity statement it reaches is as strong as `χ_m⁰ ≥ 6` itself). Draft every sentence about it so that no reader takes it
  for a step toward six.
- **Corrections owed.** Side records are never rewritten. A corrected statement goes into `plans/FS111-derivation.md`; an erratum to an
  earlier close's derivation file (item 21: FS107-derivation's HX-STALL, "K-C6 vacuous", counts only hole components) is appended to
  `plans/FS107-derivation.md` as a dated erratum entry with its source, the original text left standing above it. Corrections to
  `LEDGER.md` (item 3: rows 130–131's "not found in print"; item 2: row 133's "two questions"), `CLAUDE.md`, the frozen claim list and
  the bibliography are drafts (below).
- **Posed questions.** Say whether anything this milestone holds answers a question the literature posed (`CLOSED-QUESTIONS.md`; item 4
  names Cohen–Mani's Q5.1 as posed and open), and do not stretch.

## Numbers you may use, fixed now so the two closes do not collide

- **Ledger rows:** write yours in your drafts as `‹R111-a›`, `‹R111-b›`, …; the coordinator numbers them after FS-114's rows at the
  filing. In the files you write directly, cite your results by their derivation-file ids, never by a row number.
- **Grokkings:** **G84 and G85 are yours** — the drafts in your records (item 19's G84, merged with M3's G84′ and M4's draft as rulings 25
  and 35 say; M2's G85). FS-114's close starts at G86.
- **Successor stubs:** yours are **FS-120 to FS-122**; mint only what the records need. An unused number is skipped, never reused.

## The files you share with FS-114's close

- **You alone write** `plans/STUB-reg-scale.md` (its bearing lines; its closed banner is the coordinator's, drafted by you) and your new
  stubs. **FS-114's close alone writes** `plans/STUB-global-step.md`, `plans/STUB-stuck-ray.md` and the bearing lines of every other open
  stub: draft your lines for those files (item 2's bearing correction; M4's link to FS-115, the stuck ray; any stub a new grokking of
  yours bears on), and the coordinator files them.
- **Four units of `CLAUDE.md` belong to both milestones**: the "Last updated" line, the open-milestones line, § The aim's programme line,
  and "Where the problem stands" item 31. FS-114's close drafts each in full with the marker `‹FS-111›`; draft **your clause** for each,
  written to stand at that marker, and the coordinator inserts it verbatim.
- **The Proof Atlas**: draft your entries for `tools/viz_proof_atlas_facts.py` in your drafts section (item 2 names its route wall7 and
  its "doors meet" mark) rather than editing that file; the coordinator applies both closes' drafts after the filing and builds.
- **The paths-forward table and `plans/FRONTIER-STUBS.md`** are Poros's to re-rank after both closes. Write each new stub's bearing on
  the answer so that Poros can rank from it, and draft item 2's and item 11's replacement text for the rank-2 row as input to Poros.
- **`CLAUDE.md`'s size.** It is 288,911 bytes against a 300,000 limit, and both closes plus the re-rank must fit. Aim your net addition
  at about 3,000 bytes or less, and state your drafts' net bytes.

## Done means

1. **`data/fs111/fs111-c/ticks.md`**: a proposed tick for every inventory item, 1–38.
2. **`plans/FS111-C-close.md`**, your record, holding:
   - the readback of this brief's two quotations;
   - **the reconciliation**: every claim and lemma of the three rounds, its verdict, its minds and their blindness, and every divergence
     between a job and its verifier with how it was settled;
   - **the headline in four parts** — what card 1 settled and at what grade; where the regularity route stands and its named gap (the
     cascade at the singular set); what the wild side established; your confidence, with the fact that would change it;
   - **the sweeps** your lane file names (§G re-read, §IQ with G72's count and G79's record, §PA, the plan's "conjecture" and "not claimed"
     grep), and **every registered prediction scored**: the plan's 6.3 and each job's registrations;
   - the "Theorems this phase proved" heading (a close proves none of its own unless it does; say which);
   - **`## Drafts for the front page`**, one subsection per target: `LEDGER.md` rows `‹R111-a›`… with one § B line per theorem (key each § B line by
     its entry's qualified id, `FS111-<name>`; the ledger's census checker, `tools/fs71_ledger_b_check.py`, reads only the older
     derivation-file shape today, and job TB1 is teaching it the new grammar now — when the coordinator tells you it is done, run it
     `--strict` on a scratch copy with your drafts applied and record the exit status; if that message has not come by your last stage,
     say so, and the coordinator runs it at the filing); your clauses for the
     four shared `CLAUDE.md` units, and every correction owed to `CLAUDE.md`; G84 and G85 in G67's form, and new instances for
     `plans/GROKKING-INSTANCES.md` with their sources; `BIBLIOGRAPHY.md` rows (below); the `data/fs111/claims.md` corrections (items 11,
     16, 21, 27); the `CLOSED-QUESTIONS.md` note or its decline; the closed banner for `plans/STUB-reg-scale.md`; your bearing lines for
     the stubs FS-114's close writes; the Proof Atlas entries.
3. **`plans/FS111-derivation.md`**, every theorem the milestone proved outside the kernel as an entry in your grammar, passing
   `python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/FS111-derivation.md` from the repository root (addresses resolve
   from `plans/`, so write ../tools/… and ../data/… there); each entry's `handoff:` its kernel decision, and under each, in prose, what
   rests on it.
4. **The successor stub(s)** under the stub rule (`CLAUDE.md` § The pipeline), carrying the pinch at a junction and every stub-to-mint
   item in the inventory (5, 17, 27, 34 and the rest), each placed or declined with its reason — including item 27's "retire round 1's
   honest saturation stub" — and the bearing-line updates to `plans/STUB-reg-scale.md`.
5. **The report** in the standing rules' form.

**The bibliography.** `tools/bib_audit.py` fails today on these, first seen in FS-111's files: arXiv:1604.08841, arXiv:2407.05071,
arXiv:2512.17606, arXiv:math/0703856, `[Bourgain1986]`, `[CohenMani2025]`, `[FKW1990]`, `[Morgan1994]`, `[RatajZajicek2017]`,
`[RatajZajicek2025]`; the inventory adds Walther 1999, Federer (GMT 4.5.11; 1959), Kershner 1939 and the other works items 4, 16, 21,
27 and 34 name. Draft a row for each, with its read status per section as the records give it ("cited unread" where that is the truth).

## What is yours to decide

The shape of the successor stubs — the planner's two drafts, the pinch at a junction, the saturated chromatic number, MUA-FIN-P, and
the rest — merged or kept apart; which results earn ledger rows and which only § B lines; whether G84 and G85 both earn a place, and in
what merged form; the order of your stages. If the inventory, a record or this brief is wrong about something, say so: that is a
finding, not a refusal. If the milestone's own framing now looks wrong, say that too.

## Stages (save and commit each; standing rule 2)

1. The readback, and `data/fs111/fs111-c/ticks.md`.
2. The reconciliation.
3. `plans/FS111-derivation.md`, passing its gate, and the erratum to `plans/FS107-derivation.md`.
4. The sweeps and the scored predictions.
5. The successor stub(s) and the bearing lines.
6. `## Drafts for the front page`, then the report.

If you reach your hand-back line mid-way, stop at a saved stage and say what is left; a successor continues from there.

Thank you.
