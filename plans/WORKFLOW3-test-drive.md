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
| F1 | 16:50 | Keryx (briefing) | **Two closes at once collide on shared files the lane file assigns to "the close job"**: the Proof Atlas facts (`tools/viz_proof_atlas_facts.py`), the bearing lines of open stubs, and four `CLAUDE.md` units (Last updated, open milestones, the programme line, Where-the-problem-stands item 31). Also, the atlas checker quotes ledger rows the close has only drafted, so a close cannot run the atlas build before Keryx files. Resolved in the briefs: FS-114's close writes the stubs; FS-111's drafts its lines; both draft atlas entries; FS-114 drafts the shared units with a `‹FS-111›` marker; ledger rows 137+ to FS-114, placeholders to FS-111; grokkings G84–G85 to FS-111, G86+ to FS-114; stubs FS-116–119 / FS-120–122 | `data/fs114/briefs/C114-close.md` § The files you share; `data/fs111/briefs/C111-close.md` same | `ephodos.md` § The close job: move the atlas facts to Keryx's filing step (they depend on filed rows); say how two closes in flight share the front page |
| F2 | 16:55 | Keryx (briefing) | **The refactor missed a reader of derivation files.** `tools/fs71_ledger_b_check.py` (the census bridge between `plans/*-derivation.md` and `LEDGER.md` § B) reads only the older bold-header entry shape; the lane file now has closes write the Ephodos `derivation:` grammar, so every new § B row would fail. The coordinator's slip (the refactor's). Job TB1 (de Bruijn) launched to teach the checker both grammars and survey other readers | `data/workflow3/briefs/TB1-ledger-check.md` | after TB1: `ephodos.md` § The close job names the checker and the id rule |
| F3 | 16:58 | Keryx (briefing) | **I2 fired twice**: the brief gate failed two briefs on their first run. (a) a file under a directory listed in `touches:` is not covered in body text (the record check honours a directory prefix, the body-path check does not); (b) relative addresses `../tools/…` in backticks read as paths. Both fixed in the brief text | gate runs on `data/fs114/briefs/C114-close.md`, `data/workflow3/briefs/TB1-ledger-check.md` | agent-forge: `brief_gate.py`'s body-path check honours directory prefixes in `touches:`, as its record check does |
| F4 | 16:58 | Keryx (staffing) | **No lane owns project tooling** (a Python checker in `tools/`); de Bruijn's lane file is Lean-shaped. De Bruijn was briefed for it under its engineering standard | TB1's brief | `CLAUDE.md` § The pipeline: name the lane for `tools/` infrastructure |

## The comparison with Workflow 2.0 (written at the test drive's close)

*To be written from the instruments and the frictions above: what the split into lane files changed, what it cost, and what the fresh
session should watch.*
