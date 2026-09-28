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
| F7 | 17:04 | de Bruijn (TB1) | **TB1 DONE** (4e4e3f21, 95efed69, ef05730b; report 1f9f8329; harness ≈ 320k, of which ≈ 165k was the launch context): the census checker reads both grammars through the Ephodos gate's own parser; no other tool reads derivation entries by the older shape (record §3.1). Its held items: (1) file its drafted replacement for the lane file's "what rests on it" bullet (record §2.2); (2) raise with Kooshi a `rests on:` field for the upstream grammar, and the gate's silent folding of unknown keys. Its question for another lane: § B lines drafted from new-grammar entries must carry project grade words (`tools/viz_local_global_map_common.py` folds "computed over: …" to "open"). **Rulings:** (1) held to the test drive's close, filed with the other candidate edits to the lane files, so that the running closes and the drive's evidence are judged against one version of those files — alternative weighed: file now (no effect on the running closes, which loaded their files at launch), lost because a mid-drive edit muddies the comparison Kooshi asked for; confidence high; (2) goes to Kooshi in the final report as an agent-forge item; (3) checked at the filing, where every drafted § B line is read before it is filed. Credit: TB1 found the id rule and the silent fold before either close wrote an entry | `plans/WORKFLOW3-TB1-ledger-check.md`; `data/workflow3/reports/TB1.md` | the §2.2 bullet for `ephodos.md` § The close job; agent-forge items above |

## The comparison with Workflow 2.0 (written at the test drive's close)

*To be written from the instruments and the frictions above: what the split into lane files changed, what it cost, and what the fresh
session should watch.*
