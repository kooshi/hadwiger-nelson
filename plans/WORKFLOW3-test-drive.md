# Workflow 3.0 — the first test drive (the closes of FS-114 and FS-111)

*Opened 2026-09-28 21:40 UTC by Keryx, before the first brief. Keryx is this file's only writer. It registers the instruments the test drive
is scored on, logs every friction as it arises (each a candidate edit to a lane's file), and ends with the comparison against Workflow 2.0
that Kooshi asked for. The architecture is `CLAUDE.md` § The pipeline; the handoff that set this up is `plans/SESSION-HANDOFF-2026-09-28.md`.*

## Kooshi's words

| # | when | words |
|---|---|---|
| K1 | 2026-09-28 ~21:25 UTC | "As for what to do now, this session is a bit confounded regardless, so let's just get to work wrapping up the old milestones. I didn't realize those hadn't finished when I started this session." |
| K2 | 2026-09-28 ~21:35 UTC | "Understood. Let's close up, then hand off to a completely fresh session with a note to check for keryx and be watchful of the new workflow in comparison to the old." |

**The confound, stated once.** This session started before the Keryx output style existed, and a custom output style cannot be selected
from a remote terminal mid-session. So Keryx here is the identity *read from* `.claude/output-styles/keryx.md`, not loaded as the system
prompt, and this session's coordinator also carries a compaction summary of the refactor itself. The lanes are genuine: the agent types
`poros`, `ephodos`, `ephodos-verifier` and `debruijn` loaded in this session. A fresh session is the clean test of the coordinator.

## The instruments (registered before the first brief)

Each is scored at the test drive's close with its evidence address. The probabilities are Keryx's, as instruments, never caps.

| # | instrument | registered expectation |
|---|---|---|
| I1 | A lane agent asks a question its agent file (identity plus lane workflow) should have answered | at least one such question, p 0.6 |
| I2 | A brief fails Keryx's gate (`python3 .claude/skills/keryx/scripts/brief_gate.py all <brief>`) on its first run | at least one, p 0.7 |
| I3 | `derive_gate.py`'s path rule (addresses and controls resolve from the record's own folder) bites a job | at least one job reports it, p 0.4 |
| I4 | A fence fails: a blind mind reads what it was fenced from | not applicable to closes (no blind job is planned); scored only if one runs |
| I5 | A draft the front page needs was written by no lane (the Workflow 2.0 close's gap) | none missing, p 0.6 |
| I6 | Keryx has to author front-page text rather than file a lane's draft verbatim (count the lines, and why) | at most a few merge lines between the two closes' shared units, p 0.7 |
| I7 | The close job's `plans/FSnn-derivation.md`, in the Ephodos entry grammar, passes `derive_gate.py all` | passes by the job's hand-back, p 0.6 |
| I8 | A close job hands back before its work is done (context), so a successor finishes from its saved stage | FS-114's close needs a successor, p 0.5; FS-111's, p 0.2 |

## Frictions, as they arise

| # | when | lane | what happened | source | candidate edit |
|---|---|---|---|---|---|
| F1 | ~16:40 | Keryx (briefing) | **Two closes at once collide on shared files the lane file assigns to "the close job"**: the Proof Atlas facts (`tools/viz_proof_atlas_facts.py`), the bearing lines of open stubs, and four `CLAUDE.md` units (Last updated, open milestones, the programme line, Where-the-problem-stands item 31). Also, the atlas checker quotes ledger rows the close has only drafted, so a close cannot run the atlas build before Keryx files. Resolved in the briefs: FS-114's close writes the stubs; FS-111's drafts its lines; both draft atlas entries; FS-114 drafts the shared units with a `‹FS-111›` marker; ledger rows 137+ to FS-114, placeholders to FS-111; grokkings G84–G85 to FS-111, G86+ to FS-114; stubs FS-116–119 / FS-120–122 | `data/fs114/briefs/C114-close.md` § The files you share; `data/fs111/briefs/C111-close.md` same | `ephodos.md` § The close job: move the atlas facts to Keryx's filing step (they depend on filed rows); say how two closes in flight share the front page |
| F2 | ~16:41 | Keryx (briefing) | **The refactor missed a reader of derivation files.** `tools/fs71_ledger_b_check.py` (the census bridge between `plans/*-derivation.md` and `LEDGER.md` § B) reads only the older bold-header entry shape; the lane file now has closes write the Ephodos `derivation:` grammar, so every new § B row would fail. The coordinator's slip (the refactor's). Job TB1 (de Bruijn) launched to teach the checker both grammars and survey other readers | `data/workflow3/briefs/TB1-ledger-check.md` | after TB1: `ephodos.md` § The close job names the checker and the id rule |
| F3 | ~16:42 | Keryx (briefing) | **I2 fired twice**: the brief gate failed two briefs on their first run. (a) a file under a directory listed in `touches:` is not covered in body text (the record check honours a directory prefix, the body-path check does not); (b) relative addresses `../tools/…` in backticks read as paths. Both fixed in the brief text | gate runs on `data/fs114/briefs/C114-close.md`, `data/workflow3/briefs/TB1-ledger-check.md` | agent-forge: `brief_gate.py`'s body-path check honours directory prefixes in `touches:`, as its record check does |
| F4 | ~16:42 | Keryx (staffing) | **No lane owns project tooling** (a Python checker in `tools/`); de Bruijn's lane file is Lean-shaped. De Bruijn was briefed for it under its engineering standard | TB1's brief | `CLAUDE.md` § The pipeline: name the lane for `tools/` infrastructure |
| F5 | 16:48 | de Bruijn (TB1) | **`derive_gate.py` folds an indented line with an unknown key into the field above it, silently** — tested by TB1: a `rests on it:` line under `handoff:` became part of the handoff. The lane file asks for "what rests on it" in prose under each entry, but nothing stops a writer putting it in the block. Also: the census takes any hyphenated id as written, so the closes must qualify ids (`FS114-N7-3T`). Relayed to both closes as a dated amendment to their briefs | TB1's message to "main", 16:48; amendment 1 in both close briefs | agent-forge: `derive_gate.py` fails (or warns) on an unknown key; `ephodos.md` § The close job states the id rule |
| F6 | 16:49 | Keryx | **The coordinator logged times without checking `date`** (a house rule): F1–F4 and TB1's baseline were written as 16:50–17:00 when the clock read about 16:40; caught by TB1 (its brief was committed 16:43). Corrected here and in TB1's brief | `git log` times of 1df7db6a, 1a2d6020, 4e4e3f21 | none — the rule exists; the slip is the coordinator's |
| F7 | 16:57 | de Bruijn (TB1) | **TB1 DONE** (4e4e3f21, 95efed69, ef05730b; report 1f9f8329; harness ≈ 320k, of which ≈ 165k was the launch context): the census checker reads both grammars through the Ephodos gate's own parser; no other tool reads derivation entries by the older shape (record §3.1). Its held items: (1) file its drafted replacement for the lane file's "what rests on it" bullet (record §2.2); (2) raise with Kooshi a `rests on:` field for the upstream grammar, and the gate's silent folding of unknown keys. Its question for another lane: § B lines drafted from new-grammar entries must carry project grade words (`tools/viz_local_global_map_common.py` folds "computed over: …" to "open"). **Rulings:** (1) held to the test drive's close, filed with the other candidate edits to the lane files, so that the running closes and the drive's evidence are judged against one version of those files — alternative weighed: file now (no effect on the running closes, which loaded their files at launch), lost because a mid-drive edit muddies the comparison Kooshi asked for; confidence high; (2) goes to Kooshi in the final report as an agent-forge item; (3) checked at the filing, where every drafted § B line is read before it is filed. Credit: TB1 found the id rule and the silent fold before either close wrote an entry | `plans/WORKFLOW3-TB1-ledger-check.md`; `data/workflow3/reports/TB1.md` | the §2.2 bullet for `ephodos.md` § The close job; agent-forge items above |
| F8 | 17:16 | Ephodos (FS114-C) | **The close job's findings on its lane file** (record § Drafts, "Questions and findings" item 1): (a) the census counts gapped and stalled entries, so § B needs one line per entry, gaps included — the lane file does not say so; (b) the grammar has no field for "rests on it" and its `model:` field has no form for a statement about a class not known to be non-empty (every valid-map statement — an empty class is exactly the NO); (c) no place for regrades of an earlier close's entries, only errata; (d) grouping a lemma family under one id (150 record ids into 46 entries) is not addressed, and the census cannot see member ids; (e) the brief said items 1–121 when the inventory had 122. And item 2: the previous coordinator's summaries dropped or widened a clause six times; scripted statements fixed it, the one later slip was an unscripted definition — script definitions too. **Instruments:** I7 met (gate PASS, 0/0); I8 not met for FS-114 (no successor), though the job ran to 596k by the task count against its own estimate of 400k — the agent's own count at 67 % of the harness's, as the standing rules warn | `plans/FS114-C-close.md` § Drafts, Questions and findings | `ephodos.md` § The close job: § B one line per entry including gaps; regrades beside errata; a grouping rule; agent-forge: a `rests on:` field, and a `model:` form for a class not known non-empty; Keryx: script definitions as well as statements |
| F9 | 17:26 | Ephodos (FS111-C) | **The second close job's findings on its lane file** (record §6.1): (1) no rule for filing a verifier's re-derivation (it counted re-derivations in `minds:` and filed a verifier's new lemmas as entries); (2) scale — 85 statements make a ~110 kB derivation file in the new grammar, about three times the old one-paragraph shape; price a close from its theorem count; (3) no "rests on" field (as F5, F8); (4) "prior art: new" cannot say "measured at the class, not the step"; (5) a control whose tool exits 1 on a plant needs `; echo $?`, and a tool with a root-relative output path cannot be a control from `plans/`; (6) **§G is read once**: when a milestone's object changes between rounds (tight colourings → maximal covers), nothing re-reads the corpus from inside the new object, and G54's body bore unread on rounds 2–4; (7) **what worked**: the brief's fixed numbers and the `‹FS-111›` markers made two concurrent closes collision-free, and the census on a scratch tree gave a clean before/after. **Instruments:** I7 met (gate PASS, 1 warning); I8 not met (no successor needed), though the job ran to 587k by the task count against its own estimate of 310k (53 %) | `plans/FS111-C-close.md` §6.1 | `ephodos.md` § The close job: re-derivations and verifier lemmas; a derivation job re-reads §G when the object changes; controls' exit convention; Keryx § Staffing: price a close from the theorem count |
| F10 | 17:28 | Keryx (staffing) | **The front-page lane has no named identity**: Keryx's workflow step 7 says "when the filing is large, brief an agent as the front-page lane" without saying which. The filing here is large (five rows, 134 § B lines, eight `CLAUDE.md` units, three grokkings, two bibliographies' rows, a re-rank, the atlas, the audits), so a de Bruijn agent was briefed (X1), under Keryx's verbatim rule, working on a branch in its own worktree so the filing lands as one closing commit. The brief names every merge Keryx ruled (five), so any other word is a question to "main" | `data/workflow3/briefs/X1-front-page.md` | `keryx.md` step 7: name the front-page lane's identity and its branch-and-squash shape |
| F11 | 17:44 | Poros (R1) | **The re-read caught what both closes' drafts overstated** — F1 ("the NO is exactly" where the derivation file says "suffices") and F9 ("seven is the map NO made uniform") — before either reached the front page. This is the boundary re-read doing its job, and it came from the ask lane reading the derive lane's drafts; no rule says who repairs a close's draft after the close job has handed back, so Keryx ruled the re-reader's phrase fixes filed. **And a parallel-close collision the fixed numbers missed:** both closes incremented G72's running count from the same base (F6). Also: `plans/FRONTIER-STUBS.md` claims current state only yet carries eighteen dated re-rank paragraphs | `plans/POROS-2026-09-28-close-reread.md` § Draft re-rank item 6, F7 | `keryx.md` step 7: a close's drafts are corrected by the boundary re-read's findings before filing; running counts in shared entries are summed by Keryx at the filing, not incremented by each close |
| F12 | 17:53 | de Bruijn (X1) | **The front-page lane asked nine questions before filing a word it was not given** (the designed behaviour): a running count's wording (G72), a parenthesis a replacement sentence had no slot for (row 133), a swap that broke punctuation, "add" lines with no slot in six stubs, a column form, five bibliography collisions (a key already defined, a no-op edit, a stale "unread"), instance headers, headings, and F1's conflation in two texts F1 missed. **I6 so far:** the coordinator's own words in the filing — one G72 line, "partly read", "Twenty-first, FS-111:", "row" ×3 in a column, and two F1-pattern substitutions; each ruled in the brief's Amendment 1. Also a close-job slip: FS-114's § B draft heading said 49 lines for 46 | X1's message to "main"; `data/workflow3/briefs/X1-front-page.md` Amendment 1 | `ephodos.md` § The close job: drafts name their exact slot (the section and the words they replace or follow), and bibliography drafts check the key against every section first |
| F13 | 18:23 | de Bruijn (X1); Keryx | **X1 DONE** (cfae8fb8 … 02b27603 on `close-2026-09-28`, merged `--no-ff` as the closing commit `de616ed9`; harness 576k). Twelve questions in all, every answer a ruling on disk (the brief's amendments 1–4). Found in filing: FS111-C's atlas nodes FS111 and MEET had no grade words and crashed the facts writer; dropping two scored registrations broke the atlas checker's own self-test plant (repointed, Amendment 3); the page header lives in `visualizations/proof-atlas/page.tmpl.html`, not in the facts meta Amendment 4 named — **the coordinator's slip**, and X1 edited the template line within the ruling's purpose. Owed to the atlas keeper: README step 6 (the DESIGN.md stage record); FOURC, SRAY and CHAINB's "bearing reduced to the density form"; route wall7's chain beyond D9's three nodes. The coordinator's receipt: re-ran the census, bibliography, identities, atlas checker, mirror check and gate counts on the branch (all pass; `CLAUDE.md` 293,055 bytes); checked row 137's F1 text, Poros's open unit and the G72 line verbatim; read the atlas's full facts diff against the live page before republishing (version 4) | `plans/WORKFLOW3-X1-front-page.md`; `data/workflow3/reports/X1.md` | `keryx.md` step 7: the atlas's facts and page template are filed by the front-page lane after the rows, with the header in the template |

## The instruments, scored (2026-09-28, at the test drive's close)

| # | registered | outcome | evidence |
|---|---|---|---|
| I1 | a lane agent asks what its file should have answered, p 0.6 | **met** — the front-page lane asked twelve questions, most of which a close job's drafts should have answered by naming their exact slots (F12); the close jobs and Poros asked none | F12, F13 |
| I2 | a brief fails the gate on its first run, p 0.7 | **met** — three briefs and one amendment failed first (C114, TB1, X1 before Poros's record existed, amendment 1's bare `derive_gate.py`); C111 and R1 passed first | F3; this file's history |
| I3 | the `derive_gate.py` path rule bites, p 0.4 | **met** — FS-111's close: a tool with a root-relative output path cannot serve as a control from `plans/` | F9 (5) |
| I4 | a fence fails | **not applicable** — no blind job ran; the fence machinery is untested by this drive | — |
| I5 | no front-page draft missing, p 0.6 | **not met** — the atlas bearing edits FS-114's close assigned to Poros were in no lane's brief, and fell to the atlas keeper as owed | F13 |
| I6 | Keryx authors at most a few merge lines, p 0.7 | **met, narrowly** — about a dozen short phrases, each a ruling on disk (a G72 line, "partly read", "Twenty-first", a column's "row", four F1/F9-pattern substitutions, a heading parenthesis, two punctuation marks, the atlas header's date); no sentence of substance | X1's brief, amendments 1–4 |
| I7 | the derivation files pass `derive_gate.py all`, p 0.6 | **met** — FS-114's 46 entries (0/0), FS-111's 85 (0 failures, 1 warning) | F8, F9 |
| I8 | FS-114's close needs a successor p 0.5, FS-111's p 0.2 | **not met** — neither needed one; both ran past their hand-back lines by the harness's count (596k, 587k) while estimating 400k and 310k | F8, F9 |

## The comparison with Workflow 2.0

*Kooshi asked the fresh session to be watchful of the new workflow against the old. This is what the first drive showed. It exercised
the close path only: the opening (Poros's card, Ephodos's reframe, a frozen claim list, a blind verifier behind a fence) has not run.*

**What the split changed, for the better.**
- **Two closes ran at once without a collision** in any file, because the briefs fixed every number in advance (rows, grokkings, stub
  numbers) and gave each shared front-page unit one drafter with a marker for the other (F1, F9 (7)). Under Workflow 2.0 closes ran one at a
  time, each a close-math job (the product owner's identity) and then a front-page job.
- **The boundary re-read caught two overstatements before they reached the front page** (F11): FS-114's "the NO is exactly" and FS-111's
  "seven is the map NO made uniform". Workflow 2.0's close had no step between the close's drafts and the filing; FS-112's ranking went
  to the front-page job by message.
- **No statement was paraphrased in a brief.** Every quotation was copied by script and gated; under the old workflow the owner's
  summaries dropped or widened a clause six times in FS-114 alone (F8's item 2).
- **The coordinator authored almost nothing it filed**, and every word it did add is a ruling on disk (I6), because the front-page lane
  stopped and asked at each gap instead of guessing (F12).
- **Each mind loaded its own identity as its system prompt**, and the lane files carried the procedure: the close jobs worked from their
  lane file with a short brief, not from a workflow file every agent loaded.

**What it cost, or where it was thin.**
- **The refactor missed three joints**: the ledger's census checker could not read the new derivation grammar (F2, fixed by TB1); the
  close job's lane file assumes one close at a time and gives shared files to "the close job" (F1); the atlas edits between lanes fell to
  no one (I5).
- **Unnamed lanes**: no identity for the front-page lane (F10) or for project tooling (F4); de Bruijn served both.
- **The new entry grammar is heavier**: about three times the bytes of the old one-paragraph entries (F9 (2)), with no field for "rests
  on it" and no `model:` form for a class that may be empty (F5, F8), and `derive_gate.py` folds unknown keys silently (F5).
- **Agents' budgets**: every job ran 320k–600k by the harness's count while estimating 53–67 % of it; the closes passed their lines.
  Five agents closed two milestones and fixed a tool, against three for FS-112's one close under Workflow 2.0.
- **The coordinator's own slips**: times written without reading the clock (F6, four times), and a ruling that named the wrong file for
  the atlas header (F13). Neither is new; both are the fluent relay the Keryx identity names.

**The candidate edits to the lane files, pending Kooshi** (none filed during the drive, so it was judged against one version):
- `ephodos.md` § The close job: one § B line per entry, gaps included; verifier re-derivations counted in `minds:` and a verifier's new
  lemmas filed as entries; regrades of an earlier close beside errata; a grouping rule; every draft names its exact slot; bibliography
  drafts check the key in every section; how two closes in flight share the front page; the atlas facts drafted, never written, by a
  close (F1, F8, F9, F12).
- `ephodos.md`: a derivation job re-reads §G when the milestone's object changes (F9 (6)); the controls' exit convention (F9 (5)).
- `keryx.md` step 7: the front-page lane's identity and its branch-and-merge shape (F10, F13); a close's drafts are corrected by the
  boundary re-read's findings before filing, and running counts are summed at the filing (F11); price a close from its theorem count (F9).
- `CLAUDE.md` § The pipeline: the lane that owns `tools/` infrastructure (F4).
- Upstream, for agent-forge: `derive_gate.py`'s silent fold (F5); a `rests on:` field and a `model:` form for a class not known to be
  non-empty (F8); `brief_gate.py`'s directory prefixes in `touches:` (F3), and its spawn-rule regex, which any paragraph mentioning
  spawning, "no" and a reason satisfies.

**What the fresh session should watch**: the opening path, which this drive did not run — Poros's card, Ephodos's reframe and its
§G, the frozen claim list, and above all a blind verifier behind a fence (I4 untested); and whether the pending lane-file edits are
filed before that opening.
