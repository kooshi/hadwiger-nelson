# Session handoff — 2026-09-28 evening: FS-114 and FS-111 closed; a fresh session opens the next milestone

*Rewritten ~23:00 UTC, 2026-09-28, by the session that ran Workflow 3.0's first test drive (the closes of FS-114 and FS-111), for a
completely fresh session with no memory of today. Current state only. This morning's version of this file (the refactor's merge, the
test-drive choice) is in git.*

## 1. Read first — who you are, and whether it loaded

1. **Check your system prompt for the heading `# Keryx in lean-dir — the workflow`.** If it is there, you are Keryx, the coordinator,
   and your identity and workflow are `.claude/output-styles/keryx.md` (selected by `outputStyle` in `.claude/settings.json`).
   - **If it is not there**, tell Kooshi at once. The session that wrote this note never had the style loaded: it started before the
     style existed, and a custom output style cannot be selected mid-session from a remote terminal ("Custom output styles can't be
     selected over Remote Control or from a relayed message"). A headless probe this morning saw a fresh session load it from the settings
     file with no manual step; an interactive start has not been seen yet. Kooshi can also select it in the session itself with
     `/output-style keryx`. Until it loads, read `.claude/output-styles/keryx.md` in full and work from it.
2. **Check the Agent tool's types**: `poros`, `ephodos`, `ephodos-verifier`, `debruijn` must be listed. They were, in the last session.
3. **Kooshi's instruction for you**, verbatim (2026-09-28 ~21:35 UTC): *"Understood. Let's close up, then hand off to a completely fresh
   session with a note to check for keryx and be watchful of the new workflow in comparison to the old."*

## 2. Be watchful: the new workflow against the old

Workflow 3.0 (merged 2026-09-28, `64a47e97`): Keryx coordinates from the output style; Poros (ask), Ephodos (derive), `ephodos-verifier`
(blind second mind) and de Bruijn (formalize) are agent files, each its identity verbatim with its lane's workflow beneath
(`CLAUDE.md` § The pipeline). Its first test drive was the two closes. **Read `plans/WORKFLOW3-test-drive.md` in full**: the instruments
registered before the first brief, every friction as it arose (F1–F12 and after), and the comparison with Workflow 2.0 at its end.

What to watch at the next opening, which is the first under the new workflow from a clean start:
- **The lane files have pending edits** (the "candidate edit" column of the test-drive file). None was filed during the drive, so the
  evidence was judged against one version of the files. Kooshi decides which to file; see § 5.
- **§G is read once per milestone.** When a milestone's object changes between rounds, nothing re-reads the corpus (F9 (6)): re-read it
  at each round's brief if the object moved.
- **Running counts in shared entries** (G72's) are summed by Keryx at the filing, never incremented by each lane (F11).
- **Scripts quote; people paraphrase.** Every statement in a brief is copied by a script, definitions too (F8's item 2): the previous
  coordinator's paraphrases dropped clauses six times in FS-114 alone.
- **Read the clock before writing a time.** The last session wrote times from memory four times and was wrong by up to 20 minutes (F6):
  generate every logged time with `date` inside the command that writes it.

## 3. The state of the science

- **FS-114 (the unit-arc question) and FS-111 (the cone scale) are CLOSED, undecided**, filed in one closing commit, `de616ed9`:
  `LEDGER.md` rows 137–141, `CLAUDE.md` § Frontier, `plans/FRONTIER-STUBS.md` re-ranked by Poros
  (`plans/POROS-2026-09-28-close-reread.md`). The close records are `plans/FS114-C-close.md` and `plans/FS111-C-close.md`; the derivation
  files `plans/FS114-derivation.md` (46 entries) and `plans/FS111-derivation.md` (85), both in the Ephodos entry grammar.
- **Next, by Poros's re-rank: FS-116, the local exclusion** (`plans/STUB-local-exclusion.md`), **alone**, opening with Poros's card 1
  (`plans/POROS-2026-09-28-close-reread.md` §2.4: does FS-114's straddle kill survive an ε-band uniformly in the complexity?) and round 7's
  queue. **FS-121, the map step** (`plans/STUB-map-step.md`) is route M's other half and a second slot only if Kooshi staffs one — his
  call, not yet made; the default is FS-116 alone.
- The opening follows Keryx's workflow § A milestone, end to end: Poros's question card in the stub (step 1) if the stub lacks one, then
  the inventory, then Ephodos's opening job.
- **The search ban runs to 2026-10-01** (`CLAUDE.md` § Toolchain).

## 4. Rules easy to miss

- Brief by agent type, with the brief on disk in the keryx skill's header form, gated with
  `python3 .claude/skills/keryx/scripts/brief_gate.py all <brief>`; `plans/STANDING-RULES.md` is part of every brief.
- Only Keryx launches agents; nothing about an open milestone goes into the auto-memory; commit subjects stay neutral once blind jobs run.
- You coordinate and do not author: lanes draft, Keryx files verbatim. A large filing goes to a front-page job on its own branch and
  worktree, squashed into one closing commit (the shape used today, F10).
- Push freely to origin; never force-push. Budgets in briefs are guidance; replace an agent past about 500k tokens by the harness's count
  (agents' own counts ran at 53–67 % of it today).

## 5. Open items for Kooshi (from today's report)

- Whether FS-121 opens beside FS-116 (staffing).
- Which of the test drive's candidate edits to the lane files to file (`plans/WORKFLOW3-test-drive.md`).
- D6: whether to write the unit-arc question's statement in Lean now (FS-114 inventory item 6; four kernel handoffs wait on it).
- For agent-forge (upstream identities): `derive_gate.py` silently folds an unknown indented key into the field above it (F5); the entry
  grammar has no "rests on" field and no `model:` form for a class not known to be non-empty (F8); `brief_gate.py`'s body-path check
  ignores directory prefixes in `touches:` (F3); its standing-rules check passes any paragraph that mentions spawning, "no" and a reason.
- An owed cleanup: `plans/FRONTIER-STUBS.md` says it holds current state only, yet § Ranked stubs opens with nineteen dated re-rank
  paragraphs; moving them to git is the next re-rank's to do unless Kooshi rules otherwise.

## 6. The closing commit, and what is owed

- **`de616ed9`** — the front-page job X1's branch `close-2026-09-28`, merged `--no-ff` (its stage commits stay reachable; the branch is on
  origin). Gates re-run by the coordinator on the branch: the census, the bibliography audit, identities, the atlas checker, the re-rank
  mirror, the gate counts; `CLAUDE.md` 293,055 bytes. The fact audit's twelve flags against FS-112's close are explained in
  `plans/WORKFLOW3-X1-front-page.md` § Stage 3.
- **The Proof Atlas** is republished (artifact 7zzeXoXvTLHzqf4mTQujzx, version 4). Owed to its keeper: README step 6 (the DESIGN.md stage
  record); FOURC, SRAY and CHAINB's bearing "reduced to the density form (row 137)"; route wall7's chain beyond FS-120–FS-122.
- **Both close inventories** are ticked to their last item (FS-114 1–127, FS-111 1–44).
- **The test drive's scores and its comparison with Workflow 2.0** are the last sections of `plans/WORKFLOW3-test-drive.md`.

## Addendum, 2026-09-28 evening — the workflow lightened (read before launching any lane)

The session after the closes changed what every mind loads; the record is `plans/WORKFLOW-AUDIT-2026-09-28.md` (§1, §7, §8).
- The grokkings (G1–G87) live in `.claude/skills/grokkings/SKILL.md`, preloaded by `poros`, `ephodos`, `ephodos-verifier` and
  `debruijn` through their `skills:` field; `CLAUDE.md` § Grokkings keeps the rules, the one-paragraph theory and a pointer. Keryx
  and the Clerk read an entry by number. Retired entries (seven workflow grokkings, and G47) are `plans/GROKKINGS-RETIRED.md`.
- `RUNNING.md` holds the toolchain, the process rules (two PROTECTED paragraphs) and "Make the gate fail"; briefs for jobs that run
  processes or build checkers name it.
- `CLAUDE.md` is about 70 KB. Its milestone table shows the top ten and a count.
- **First act of the next session:** launch one lane agent with no tools and ask it to quote G87's first words from a loaded
  `grokkings` skill block (a "Base directory for this skill: …/grokkings" line). A same-session probe loaded it in full; the
  harness picks up an agent file's `skills:` field with a lag, so a fresh session is the clean confirmation.
- **Corrections owed to the theory** (G56, G35, item 1; row 139's opening): `plans/WORKFLOW-AUDIT-2026-09-28.md` §9. A short Ephodos
  drafting job, or FS-116's opening re-grokking, which reads G56 anyway.
