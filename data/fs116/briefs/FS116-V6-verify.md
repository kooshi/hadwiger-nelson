# Brief FS116-V6 — a blind second mind on one claim of FS-116's list (§ 15)

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS116-V6
  identity: Ephodos in its verification form — your agent file (`.claude/agents/ephodos-verifier.md`) is your identity, your lane's workflow, and the `ephodos-verification` procedure preloaded beside it; `ephodos-recognition` and `ephodos-invention` are yours to invoke fresh with the Skill tool if you choose
  role: blind verifier of one fixed statement; blind, the same model as the mind whose work you may later compare against (Opus 5.5)
  launch: now; no other job of FS-116 is running
  mission: § Why this job
  statements: § The statement
  acceptance: § Done means
  yours: § What is yours to decide
  fences: § Fences
  channel: message the coordinator ("main") by SendMessage with any question mid-flight, including any question of which reading the statement means; the report goes to `data/fs116/reports/FS116-V6.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS116-V6-verification.md`
  touches: `plans/FS116-V6-verification.md`, `data/fs116/v6/`, `tools/fs116_v6_*.py`, `data/fs116/reports/FS116-V6.md`
  budget: about 250k by the harness's count, as guidance; hand back at a saved stage before about 400k

Hello. You are the second mind on one statement. Another mind worked the same statement; nothing more about that work is yours until your
own verdict is committed.

## Why this job

FS-116 asks whether an explicit radius exists within which no valid six-coloured fragment with unit arcs survives about a vertex of at
least four colours, one radius for every complexity, Siamese pairs allowed (`data/fs116/claims.md` § 1). Its case list splits by what the
vertex's ring carries. One statement about the case where the ring carries no arc of Γ was added to the list at round 4 (§ 15). Before anything
rests on it, this project wants a blind mind to re-derive it, fixed in advance. The record shows where hand derivations here fail: the sentence
claims more than the argument carried. So attack the statement, not only your steps, and test
it against every control the list's § 9 names and the preamble's rule on other colour counts. TRUE, FALSE with a counterexample, GAP at a named
step and MISSTATED are all results.

## The statement

Derive or refute it, exactly as written, with its *not claimed* line as part of it. Its setting words are the list's § 0, and
`data/fs114/claims.md` §§ 0, 6 where the list does not restate them. You may use any statement of the list's §§ 2, 8 and 10–14 as an input:
name each one you use, and say where your verdict rests on one. Their grades are not yours to weigh; the close grades your verdict through them.

> - **FS116-Y4-EMPTY** *(proposed at round 4)*: no non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has a ring carrying no arc of Γ *Not claimed:* anything for rings carrying an arc of Γ that is not a (Q) arc (the (Q)-free rings of FS114-N6-RING60 after the bends, with (R2) arcs); anything in the Siamese or non-simple class; anything at k ≥ 7
> — source: data/fs116/claims.md § 15

## What you may read

The list `data/fs116/claims.md` (in `data/fs116/`, only it and your own `data/fs116/v6/` are open to you), `data/fs114/claims.md` and
`plans/FS114-derivation.md` (its entries' statements; not the records their `argument:` lines point to); `CLAUDE.md`; the grokkings (preloaded);
`LEDGER.md`; the held papers (`BIBLIOGRAPHY.md`, `~/source/library/`); and the held inputs' own homes from milestones before FS-114:
`plans/FS110-*.md`, `plans/FS111-*.md`, `plans/FS112-*.md` and their `data/` directories. Anything not named here and not in § Fences: ask
before reading.

## Fences

Until your verdict is committed, do not read any of these (and never `git log -p` or `git show` on them, nor the
bodies of their commits):
- FS-116's plan and records: files matching `plans/FS116-*` other than your own record; the directories `data/fs116/briefs/`, `data/fs116/reports/`,
  `data/fs116/o1/`, `data/fs116/n1/`, `data/fs116/n2/`, `data/fs116/n3/`, `data/fs116/s1/`, `data/fs116/y1/`, `data/fs116/y2/`, `data/fs116/y3/`,
  `data/fs116/y4/`, `data/fs116/v1/`, `data/fs116/v2/`, `data/fs116/v3/`, `data/fs116/v4/`, `data/fs116/v5/`, `data/fs116/cl1/`, and the file `data/fs116/v1-n7-definitions.md`;
  tools named `tools/fs116_*` other than yours.
- The stubs and the question records: files matching `plans/STUB-*`, `plans/POROS-2026-09-28-fs116-question.md`,
  `plans/POROS-2026-09-28-close-reread.md`.
- FS-121's plan and records: files matching `plans/FS121-*`, and the directory `data/fs121/`.
- FS-114's job records, which hold the routes of the statements these re-work: files matching `plans/FS114-N*`, `plans/FS114-Y*` and
  `plans/FS114-C*`, `plans/FS114-close-inventory.md`, `plans/FS114-L60-audit.md`, `plans/FS114-unit-arc-question.md`, and the directories
  matching `data/fs114/fs114-*`, `data/fs114/briefs/` and `data/fs114/reports/`.
- The Clerk's job files: `data/workflow3/cl2/`, `plans/WORKFLOW3-CL2-n7-definitions.md`, `data/workflow3/reports/CL2.md`.
- The session transcripts (`~/.claude/projects/`, `chats-bak/`), the coordinator's scratch, and any other job's scratch directory.

If a search prints fenced text, stop reading and log the touch at once (standing rule 8).

## After your verdict

Once your verdict is committed, your second phase opens the first derivation for the divergence table: the construction record of round 4,
`plans/FS116-Y4-construction.md` § 3. Nothing else in the fence opens.

## Done means

1. **Your record**, `plans/FS116-V6-verification.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS116-V6-verification.md` from the repository root before each stage's commit, holding your procedure's sections: the
   readback, your expected verdict with its probability before any derivation, your derivation or stall, the attack
   on each statement, one `verification:` block, and, after the verdicts' commit, the divergence table with every
   divergence classed.
2. **The report** in the standing rules' form, a RESULT line with your count of minds ("blind, the same model"). Your last
   words are exactly "FS116-V6 idle; report sent to the coordinator".

## What is yours to decide

Your route and your verdict. If the statement is ambiguous, ask "main" which reading is meant; I answer from its
author's definitions, never its argument, or rule it an ambiguity for you to report under both readings. If the statement is wrong as posed,
MISSTATED with the corrected statement is a finding, not a failure. If its setting words are not enough, say so: that is a finding too.

## Stages (save and commit each; standing rule 2)

1. The readback and the registered expectation.
2. Derivation, attack, verdict committed.
3. The divergence table, then the report.

You start no agent of your own (`plans/STANDING-RULES.md` rule 1: staffing is Kooshi's budget, and I can review only work I know exists).

Thank you.
