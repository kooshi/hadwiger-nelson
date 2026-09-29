# Workflow 3.0 — the proposed edits to the lane files, for Kooshi's review

*Written 2026-09-28 by Keryx at Kooshi's word ("Let me review them first", `plans/FS116-close-inventory.md` item 4). Each edit comes from a
friction logged in the first test drive (`plans/WORKFLOW3-test-drive.md`, F1–F13) or this session (`plans/FS116-close-inventory.md`, W-rows),
named in its "from" line. Each shows the text it replaces or follows, quoted from the file, and the proposed text, to be filed verbatim.
Edits already filed by the evening's audit are not repeated here: re-walking §G when the object changes (F9 (6)) and no running counts
(F11) are in the files (`plans/WORKFLOW-AUDIT-2026-09-28.md` § 7), and the front-page lane's default identity is now the Clerk
(`.claude/output-styles/keryx.md` step 7). Kooshi picks; Keryx files the picked ones in one commit.*

**Deferred to 2026-09-29** (Kooshi, 2026-09-29 04:52 UTC): "defer these until tomorrow, and watch for instances or additions throughout this session. […] [W]e've only exercised the closing of Workflow 3.0. This session is the full thing (except formalization)."

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
