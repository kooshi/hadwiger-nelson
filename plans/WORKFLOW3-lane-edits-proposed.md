# Workflow 3.0 — the proposed edits to the lane files, for Kooshi's review

*Written 2026-09-28 by Keryx at Kooshi's word ("Let me review them first", `plans/FS116-close-inventory.md` item 4). Each edit comes from a
friction logged in the first test drive (`plans/WORKFLOW3-test-drive.md`, F1–F13) or this session (`plans/FS116-close-inventory.md`, W-rows),
named in its "from" line. Each shows the text it replaces or follows, quoted from the file, and the proposed text, to be filed verbatim.
Edits already filed by the evening's audit are not repeated here: re-walking §G when the object changes (F9 (6)) and no running counts
(F11) are in the files (`plans/WORKFLOW-AUDIT-2026-09-28.md` § 7), and the front-page lane's default identity is now the Clerk
(`.claude/output-styles/keryx.md` step 7). Kooshi picks; Keryx files the picked ones in one commit.*

**Deferred again, to after FS-116's close** (Kooshi, 2026-10-03 14:52 UTC): "Re: the workflow suggestions, we'll discuss them after this milestone closes. If any suggestions are only in your context, record them so we can discuss them then."

**Earlier: deferred to 2026-09-29** (Kooshi, 2026-09-29 04:52 UTC): "defer these until tomorrow, and watch for instances or additions throughout this session. […] [W]e've only exercised the closing of Workflow 3.0. This session is the full thing (except formalization)."

## Kooshi's ruling for the refinement (2026-10-03 20:08 UTC, verbatim)

*It governs every edit below: an edit it makes moot is dropped at the filing. Keryx's reading of each edit under it is in the session's reply of the
same time; the decisions it leaves open are listed there.*

> I rescind my earlier ruling that we can't assume outside proofs when writing in Lean.
> We need to streamline our workflow […], and this is how: eliminate the verifier and the re-reader. Instead, a lean implementation is required to close a milestone.
> Expensive third party proofs may be assumed, and well documented, for the sake of the milestone.
> I know the blind derivation and reread have produced useful results, but it's a partial duplication of effort, almost never refutes a proof, […]. […]
> De Bruijn is just as capable of finding optimizations and generalizations of the proof - and we should ask for that explicitly in its workflow - but we will miss out on possible second paths to the same statement, though I think those were rare anyway...
> Actually, we found at least one useful second path just last session, so here's one option: We could have the deBruijn planner use the blind input that the verifier would have used in the previous workflow.
> The pipeline still stands. We may also assume the result of our own hand proof for the sake of beginning the next which depends on it, though if de Bruijn finds a critical issue or generalization, it should immediately be relayed to the agent working on the frontier.
> Also the de Bruijn agent should be broken into subplanning and implementation agents, with the implementation agent moved to sonnet.
>
> So, a single milestone's workflow would look like:
>  - Poros - Opus - Ask
>  - Ephodos - Opus - Opening
>  - Ephodos - Opus - Derive
>  - de Bruijn - Opus - Plan the kernel module (blind?)
>  - de Bruijn - Sonnet - Implement the kernel module, with both the plan and the original derivation available.
>  - Conditional and Closing jobs remain the same. I'd like to streamline the closing, but everything there has its place for now.
>
> We can keep the verifier agent definition around in case we need it, but we won't use it as part of the standard workflow.
>
> We will of course need to handle the backlog of lean work before we can continue forward with this. We'll handle that in a dedicated session after the cross audit.
>
> Ok, now in regards to the edits to the workflow: I'd like to generally relax restrictions and rules, and allow for a bit more flow. The bureaucracy may be costing more tokens than occasional slips do. As long as our final proofs are valid, our path to them is allowed to be a little messy. That said, I do like the general structure that we've built for the repo, so I don't want to get too loose, I just want this in consideration as we look at the suggested edits.
>
> Now, with all my requests above in mind, what edits still matter? Where can we streamline our workflow, and maybe thin out the context a bit? Also any context which is loaded every time an agent runs must only reflect the current state of affairs, and cut narration and old instances and dated edit history.

## A. Ephodos's close job (`.claude/agents/ephodos.md` § The close job)

These shrink the close and remove the questions the filing agent had to ask (twelve, at the last close).

**E1 — "what rests on it" gets a fixed marker.** From F7 (TB1's draft, `plans/WORKFLOW3-TB1-ledger-check.md` § 2.2). Replaces:
> Under each entry, in prose, write what rests on it.

with:
> Under each entry, after its block's blank line, a prose paragraph opening "Rests on it:" names what rests on it (the census,
> `tools/fs71_ledger_b_check.py --strict`, requires the words "rests on" there; an indented `rests on it:` line inside the block
> is not a field of the grammar, and the gate folds it silently into the field above it).

**E2 — one § B line per entry, gaps included, in the project's grade words.** From F8 (a), F7 (3). Replaces:
> `LEDGER.md`: the milestone's row, or rows, and one § B line per theorem;

with:
> `LEDGER.md`: the milestone's row, or rows, and one § B line per entry of the derivation file, gapped and stalled entries included
> (the census counts every entry), each carrying its grade in the project's words ([hand], [derived], [tools], [cert], [kernel], GAP),
> never the grammar's (the atlas tools read "computed over: …" as "open");

**E3 — the id rule.** From F5. Added after the bullet "Enter every theorem the milestone proved outside the kernel …":
> Qualify every entry id with the milestone's prefix (`FS114-N7-3T`, not `N7-3T`): the census takes an id containing a hyphen as
> written and prefixes only bare ones, so an unqualified hyphenated id matches no § B line.

**E4 — every draft names its exact slot.** From F12. Added as the first line under "**What you draft for Keryx to file**":
> Every draft names its slot: the file, the section, and the exact words it replaces (first to last) or follows. A draft with no slot
> becomes a question from the filing lane, and each question costs a round trip. A bibliography row is checked against every section
> of `BIBLIOGRAPHY.md` first: a key already defined, or a row that would change nothing, is reported, not drafted.

**E5 — regrades of an earlier close.** From F8 (c). Added after E4:
> An entry of an earlier milestone's derivation file whose grade, verdict or mind count this milestone changed is drafted as a regrade:
> the earlier file, the entry id, the field, the old value and the new, and the address of what changed it. Regrades are filed beside
> errata; the earlier entry is never rewritten silently.

**E6 — families and verifiers' lemmas.** From F8 (d), F9 (1). Added under the derivation-file bullets:
> One entry per theorem cited on its own. A family of lemmas never cited separately may share one entry; list the members' record ids
> in its `argument:`. A verifier's re-derivation of an entry counts in that entry's `minds:`; a lemma the verifier proved that the
> derivation lacked is an entry of its own, its mind the verifier.

**E7 — the Proof Atlas facts are drafted, not written, by a close.** From F1, F13. Replaces the bullet "**The Proof Atlas facts**: the
entries of `tools/viz_proof_atlas_facts.py` for this milestone's results. Then run the checker and the build
(`visualizations/proof-atlas/README.md`); Keryx republishes the page." (moved from "What you write directly" to "What you draft"):
> - the Proof Atlas facts: the entries for `tools/viz_proof_atlas_facts.py`, each with its grade in the project's words. The front-page
>   lane writes them after the ledger rows are filed (the atlas checker quotes filed rows), with the page header in
>   `visualizations/proof-atlas/page.tmpl.html`, then runs the checker and the build.

**E8 — the close's size.** From F8, F9 (2). Added at the head of § The close job:
> A close is priced from its theorem count, not from the milestone's length: 46 and 85 entries ran to about 596k and 587k tokens in
> the first test drive, past both jobs' lines. Above about 50 entries, Keryx briefs two close jobs: the derivation file first, then the
> drafts and sweeps from it.

## B. Ephodos's derivation job (`.claude/agents/ephodos.md` § A derivation job)

**E9 — the controls' exit convention.** From F9 (5). Added after the gate paragraph ("The gate resolves every address …"):
> A control passes when its command exits 0. A tool that exits 1 on a planted fault is run as its own control with the plant in place
> and `; test $? -eq 1`. A tool that writes to a path relative to the repository root cannot be a control from `plans/`: give it an
> output flag, or run it from its own folder.

## C. Keryx's workflow (`.claude/output-styles/keryx.md`)

**E10 — two closes, or two milestones, in flight.** From F1, F9 (7). **Now live: FS-116 and FS-121 are both open.** Added to step 7:
> When two milestones close together, their briefs fix in advance every number each may use (ledger rows, grokking numbers, stub
> numbers) and give each shared front-page unit (the "Last updated" line, the open-milestones line, a shared item of "Where the
> problem stands") one drafter, who marks the other's place `‹FS-nnn›`. Shared files a close writes directly (a stub's bearings)
> go to one close; the other drafts its lines.

**E11 — the boundary re-read corrects a close's drafts.** From F11. Added to step 7's re-read bullet:
> Where the re-read finds a close's draft overstated, its replacement text is filed in the draft's place; the re-read is the draft's
> second reader.

**E12 — the front-page lane's shape.** From F10, F13. Added to step 7's last paragraph ("When the filing is large …"):
> It works on its own branch in its own worktree, and its stage commits are merged as one closing commit (`--no-ff`).

**E13 — definitions are scripted too.** From F8 (item 2). Added to § Why the workflow is split this way, or to the brief rules:
> Every statement in a brief is copied by a script, and so is every definition it relies on: the one paraphrase that survived
> scripting in FS-114 was an unscripted definition.

## D. `CLAUDE.md` § The pipeline

**E14 — the lane that owns project tooling.** From F4. Added after the lanes table:
> Project tooling in `tools/` and `scripts/` (checkers, audits, generators) is de Bruijn's, under its engineering standard, unless a
> job builds the tool as its own control.

## E. Upstream, for agent-forge (not lean-dir's files; the identities are imported unchanged)

| # | tool | defect | from |
|---|---|---|---|
| U1 | `derive_gate.py` | an indented line with an unknown key folds silently into the field above it; should fail or warn | F5 |
| U2 | the Ephodos entry grammar | no `rests on:` field (E1 is the local workaround); no `model:` form for a class not known to be non-empty (every valid-map statement: an empty class is exactly the NO) | F8 |
| U3 | `brief_gate.py` | the body-path check ignores directory prefixes in `touches:` (the record check honours them); a backticked word with a slash reads as a path (W2, this session) | F3, W2 |
| U4 | `brief_gate.py` | the standing-rules check passes any paragraph that mentions spawning, "no" and a reason | the handoff § 5 |

## F. An owed cleanup

`plans/FRONTIER-STUBS.md` says it holds current state only, yet § Ranked stubs opens with about nineteen dated re-rank paragraphs. Moving
them to git history is the next re-rank's to do unless Kooshi rules otherwise (the handoff § 5).

## G. Instances and additions, as they arise this session (FS-116 and FS-121, the opening path)

*One line per friction that is a new instance of an edit above (its E-number) or a new candidate (numbered on from E15). Each points to
its W-row in `plans/FS116-close-inventory.md`, which is the time-ordered log.*

| edit | instance or addition | W-row |
|---|---|---|
| U3 | the brief gate's path check read a backticked word as a path (FS116-P1's brief) | W2 |
| E13 | the coordinator's brief dropped a qualifier from the context around a quoted statement (Poros's "can stand") | W4 |
| E10 | two openings in flight: stub numbers fixed in advance in their briefs | W8 |
| E14 | a defect in `tools/claude_md_fact_audit.py` found by a derivation job, with no lane named to fix it | W9 |
| E8 | a four-text drafting job ran to ≈ 357k against 200k; a card job to ≈ 413k, its own count 46 % of the harness's | W7 |
| E1 | a job record's four theorems had no "Rests on it" prose; the census failed until the coordinator generated it | W10 |
| E15 (new) | a drafting job that proves theorems writes them in a `plans/<job>-derivation.md` of its own, so the census sees them without a copy | W10 |
| E16 (new) | Ephodos hand-backs carried full reports in prose, three of three tonight; Poros's was content-free | W5, W11 |
| E17 (new) | a proposed claim list asserted one of its own claims and gave a mind count, which its blind verifier would read | W12 |
| U5 (new) | the brief gate reads a "…" inside a quoted statement's own text as an elision | W13 |
| U3 | a fence section's "except" clause is invisible to the gate: every backticked path there is fenced (the gate caught the resulting self-fence, so this is a note on wording, not a defect) | W13 |
| E17 | a frozen list quoted an earlier milestone's statement whose terms were defined only in records fenced from its verifier; the verifier had to ask (FS116-V1) | W16 |
| E17 | five reading questions from three blind verifiers, each about a term the frozen list used without defining; answered from the proposing records' definitions when the authors were past their lines | W18 |
| E18 (new) | the session scratch directory is shared: jobs wrote files into it, and it was cleared during the halt | W21 |

## H. Suggestions that lived only in the coordinator's context, recorded at Kooshi's request (2026-10-03 14:52 UTC)

*Each was a practice or an observation the coordinator acted on during FS-116 and FS-121 without writing it down as a proposal. Each names
the inventory rows that show it; nothing here is filed in a lane file.*

**E19 — how Keryx answers a blind verifier's reading question.** Five times, a blind verifier asked which reading of a term was meant while
the term's author was past its context line. Keryx answered from the author's own record, quoting **definitions only**, never a proof's
text, and treated anything the record left undefined as an ambiguity, so the verifier reported both readings. Proposed for
`.claude/output-styles/keryx.md` (near `<independence>`'s lean-dir notes): *"A verifier's reading question goes to the statement's author while
the author is below its line. Otherwise Keryx answers from the author's record, quoting only its definitions, with their addresses; a term the
record does not define is ruled an ambiguity, and the verifier reports its verdict under each reading."* (FS-116 items 26, 47, 65; FS-121 items
18, 32, 38, 56; W18.)

**E20 — a statement must not carry a proof sketch.** FS114-N7-3T's filed statement embeds N7-HUB's argument in a parenthesis. Quoted
into FS-116's frozen list, that sketch reached two blind verifiers, who had to disclose it, and Keryx had to rule on the mind count twice.
Proposed for `.claude/agents/ephodos.md` (the entry grammar's use): *"A `statement:` field states one claim and no argument; a second claim
inside it is a separate entry, and a sketch belongs in `argument:`."* Upstream, the `derive_gate.py` lint could warn on a statement containing
"so", "since" or a colon-introduced reason. (FS-116 items 32, 49, 76; FS116-V1 § 3.3.)

**E21 — briefs built from templates carry stale counts.** Two verifier briefs built from earlier ones kept "all three statements" in their
fence sections for five statements. Proposed: Keryx's briefs never state a count in prose, or the brief gate warns when a number word before
"statements" differs from the number of quotations in the statements section (an agent-forge item). (FS-116 item 78; FS-121 item 65.)

**E22 — dated addenda to a frozen claim list.** New claims arising mid-milestone (a corrected statement, a lemma others will build on, a
route's NO stated by its own job) were added as dated sections, frozen at their own time, with every earlier statement left unchanged.
Proposed for `.claude/output-styles/keryx.md` § `<rulings>`'s lean-dir note: *"A frozen list grows only by dated addenda; a frozen statement is
never edited — its correction is filed at the close from the verifier's wording."* (FS-116 §§ 10–11, items 42, 59, 76; FS-121 §§ 5–8.)

**E23 — the Clerk folds reports into the inventories.** The coordinator wrote every inventory line itself; over two milestones this was
the largest single use of its context, which is the project's review budget. The Clerk's file already lists "folding job reports into … a
close inventory" as its kind of job. Proposed: Keryx reviews each report's artifacts (commits, gate, one checked step), writes its rulings,
and has the Clerk fold the report's items into the inventory verbatim. (Keryx's own context use, FS-116 and FS-121; `.claude/agents/clerk.md`.)

**E24 — a different model for some blind verifiers.** Every blind verifier tonight was the same model as the deriver, so each two-mind
count is independent in what each mind saw and in route, not in prior (FS121-V3's own words: "2 minds on information and route, 1 prior").
The Keryx identity says to offer the principal a different model with its cost; the coordinator did not. Proposed for discussion: for a
headline claim, one blind verifier on a different model (Sonnet 5.5, or another family), with the cost stated. (FS-121 item 57; every
verifier report's `minds:` lines.)

**E25 — resuming After a halt.** All six running jobs died at once on the account's halt (2026-09-29 02:42). Saved stages
cost little; resuming each by message kept its context, and each continued from its record. Proposed for `.claude/output-styles/keryx.md`
§ Staffing: *"After a halt, resume each job by message, naming its last committed stage and its uncommitted files; at most three agents
afterwards unless Kooshi says otherwise."* (FS-116 item 74.)

- **E26 (2026-10-03, from FS116-Z1, FS-116 item 137): the verifier lane writes its own lemmas as `derivation:` blocks.** V1–V3 wrote theirs as prose,
  V4 and V5 as blocks; the close then judged, lemma by lemma, what each prose lemma claimed and at what grade. One line in
  `.claude/agents/ephodos-verifier.md` ("a lemma of your own route that you state for later use is a `derivation:` block in your record") saves it.
  Also from today, for the same review: **U6** (the brief gate's § address match takes the first heading with the same number-stripped name, W25),
  **U7** (the gate warns on verdict words beyond "prove" and "confirm", W26), **U8** (the derive gate checks "Rests on it:", W27).

- **Search policy after the ban (Kooshi, 2026-10-03 18:30 UTC, FS-116 item O7)**: the ban is not deleted outright; Kooshi is considering "restricting search to a
  wallclock budget per day and per week", and asked first for a count of where the ban hindered (job CL3, `data/workflow3/briefs/CL3-ban-audit.md`).
  For the workflow refinement: the budget's shape, who holds it, how a job asks for it, and whether the "would have searched here" log stays.

- **Also from the closes of 2026-10-03, for the same review** (FS-116 W-table W27–W31):
  - **E8, evidence**: the split close worked — part 2 read about 150k and redid nothing (W30). Its one cost: part 2's brief restated part 1's
    list of owed errata instead of quoting it, and drifted (FS-116 item 146). Proposal: a part-2 brief quotes part 1's list by address.
  - **E16, evidence**: the hand-back as one content-free line held for four of the day's jobs and failed for four (W27–W29), all of them Ephodos's
    or the Clerk's, each with the exact line in its brief. Proposal: the lane files, not only the briefs, say the hand-back is that line alone.
  - **E17, evidence**: freezing the decisive statement without its route's lemmas, and withholding a route-naming phrase until no blind job
    remains, gave a blind route resting on none of the first's lemmas (FS-116 items 123, 138, 147; W29).
  - **U9**: `data/rerank-2026-09-27/rk_mirror_check.py` still expects the 30-row paths table `CLAUDE.md` dropped on 2026-09-28, so it fails on
    every run (W31). Update it to the top-ten table, or retire it.
  - **The verifier lane writes its own lemmas as blocks** (E26, already above), and **the reading-question practice** (E19) refined: quote the
    author's defining sentence when the record has one; ask the author only when it does not (W24).

