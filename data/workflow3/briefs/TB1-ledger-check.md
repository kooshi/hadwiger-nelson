# Brief TB1 — teach the ledger's census checker the new derivation-file grammar

*Written 2026-09-28 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: TB1
  identity: de Bruijn — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; this job is a Python tool, held to your engineering standard
  role: a tooling job: extend one checker so that it reads both derivation-file grammars
  launch: now, beside FS114-C and FS111-C, the two close jobs whose drafts this checker will judge
  mission: § Why this job
  statements: none — a tooling job; the two grammars it must read are named by address in § The two grammars
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — no blind job is running, and nothing here is a second mind
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/workflow3/reports/TB1.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/WORKFLOW3-TB1-ledger-check.md`
  touches: `plans/WORKFLOW3-TB1-ledger-check.md`, `tools/fs71_ledger_b_check.py`, `data/workflow3/tb1/`, `data/workflow3/reports/TB1.md`
  budget: about 150k by the harness's count, as guidance; hand back at a saved stage before about 250k

Hello. You are de Bruijn. This is a small engineering job on the project's own tooling, and it is on the critical path of today's two
milestone closes.

## Why this job

This morning the project's workflow was split into lane files (`CLAUDE.md` § The pipeline). The deriver's lane file,
`.claude/agents/ephodos.md` § The close job, now has each close write its derivation file, `plans/FS*-derivation.md`, in the Ephodos entry
grammar — `derivation: <id>` blocks with field lines, checked by `.claude/skills/ephodos/scripts/derive_gate.py`. Files written before
2026-09-28 keep their older shape.

The refactor missed one reader of those files. `tools/fs71_ledger_b_check.py` is the bridge between the derivation files and `LEDGER.md`
§ B: every entry id must appear in exactly one § B row and every § B row must have an entry. It reads only the older shape, a bold header
`**<id> — <title>. [<grade>; <prover>]**` with the fields *Proof:*, *Proof verdict:*, *Rests on it:*, *Prior art:*, *Kernel:*. So an entry
in the new grammar is invisible to it, and every § B row the closes add for FS-114 and FS-111 would fail as "has no derivation entry".
The two close jobs, FS114-C and FS111-C, are running now and will write the first two files in the new grammar. The coordinator runs this
checker when it files their § B lines.

## The two grammars

- **The older one**: the checker's own docstring and `ENTRY_RE`, and any existing file, for example `plans/FS112-derivation.md`.
- **The new one**: your identity's sibling, the `ephodos` skill — `.claude/skills/ephodos/SKILL.md`'s entry section, and its worked
  examples `.claude/skills/ephodos/scripts/example-clean.md` and `.claude/skills/ephodos/scripts/example-verification.md`. Its entries are
  `derivation: <id>` blocks. `control:` blocks are not entries.

## Done means

- **`tools/fs71_ledger_b_check.py` reads both grammars.** An entry in the new grammar is counted in the census under its file's prefix, by
  the same id rule the older grammar uses (a qualified id such as `FS114-N7-3T` stands; a bare one inherits the prefix). Under `--strict`,
  a new-grammar entry must carry the fields that grammar makes mandatory; name the mapping from the old five fields in your record.
- **No regression.** On today's tree, before any close has written a file, the run reads exactly as it does now. The coordinator's
  baseline, taken 2026-09-28 21:55 UTC: `python3 tools/fs71_ledger_b_check.py --strict` exits 0 with "census: 1003 theorems in 72
  derivation files" and "LEDGER § B rows: 1003 | placeholders: 0". Show your run beside it.
- **Controls that fire.** The existing `--self-test` still passes. Extend it with new-grammar plants, each seen to fire once and for its
  own reason: a new-grammar entry with no § B row; a § B row whose new-grammar entry is missing; a new-grammar entry lacking a mandatory
  field under `--strict`; and a faithful new-grammar entry beside them that must pass, so a refusal is seen to come from the cause and not
  the scaffolding (`CLAUDE.md` § Make the gate fail).
- **A survey, reported and not fixed.** List every other tool in `tools/` that reads `plans/*-derivation.md` entries by their older shape,
  with what each would miss in a new-grammar file. That list goes to the coordinator; fixing those tools is not this job.
- **The report** in the standing rules' form.

## What is yours to decide

How the checker tells the grammars apart (per file or per entry), the field mapping, and the code's shape. If you find that the
new grammar lacks something the census needs — the older shape's *Rests on it:* has no field in the new grammar, where the lane file asks
for it in prose under each entry — say so, with what you would do about it: that is a finding, not a refusal. If the right fix is
somewhere other than this checker, say that too, and make no change outside your touches.

## Stages (save and commit each; standing rule 2)

1. The readback of this brief, the two grammars read, and the baseline run reproduced.
2. The change, the regression run, and the extended self-test.
3. The survey, and the report.

Thank you.
