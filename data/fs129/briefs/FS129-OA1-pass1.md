# Brief FS129-OA1 — pass 1 of the cross-application audit, lane A: which held result of the arithmetic era closes, shortens or reduces an open step

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS129-OA1
  identity: Ephodos, the deriver, read as files — `.claude/skills/ephodos/SKILL.md` in full, then `.claude/agents/ephodos.md` from its line `# Ephodos in lean-dir — the workflow` to its end; invoke `ephodos-recognition` fresh with the Skill tool when a known result almost applies
  role: pass 1 of FS-129, lane A (arithmetic era): the demand list read against this era's held results; each composition that closes, shortens or reduces a step derived; each null recorded
  launch: now, beside FS129-OR1 (lane R), which writes only its own files; FS129-IX1 (the index) and FS129-Q1 (the card) have reported
  mission: § Why this job
  statements: § What Kooshi asked
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in FS-129 is blind (Workflow 3.1); the other lane's files are open to you, and it writes only its own
  channel: message the coordinator ("main") by SendMessage only for a question you cannot work around or a finding that cannot wait (a statement defect, a refutation of a held result); the report goes to `data/fs129/reports/FS129-OA1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Rule 1 matters more for you than for most: you are a general-purpose agent and carry the Agent tool, which the lane agent files withhold
  record: `plans/FS129-OA1-audit.md`
  touches: `plans/FS129-OA1-audit.md`, `data/fs129/oa1/`, `tools/fs129_oa1_*.py`, `data/fs129/reports/FS129-OA1.md`
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are one of two readers on the first pass of an audit Kooshi asked for: everything this project has derived was derived for
the milestone that needed it, and the audit asks the reverse question — where else does each result bear? Your pass is the one aimed at
new paths: for each open step on the demand list, does a result this project already holds close it, shorten it, or reduce it to
another? You own lane A, the held results of the arithmetic era; the other reader owns the regularity-wall era (FS-104 on), and you both read the whole demand list.
Your era is every milestone through FS-103 — every `M`-numbered milestone, FS-25 to FS-103 with `FS100-*` and `FS103-*`, and the eight
files with no milestone number (`ASTRA-2026-09-14`, `MASCOT`, `Q8`, `R52`, `R57`, `R59`, `R88`, `TC1`; `plans/FS129-close-inventory.md`
item 11): fields, residue targets, finite planes, the compulsion toolkit, measure rigidity. **You are the reader Kooshi's decision 4 is
addressed to**: does any of it bear on the measurable question? A hit and a careful null are equally findings here; decision 4 asks for
whichever is true. The index's verdict-level open steps are all regularity-era (the list's § 4), so your pass is supply against the list. **Work
Poros's four lane-A sites first** — J4 (TOP₆ as coverage: G13, row 66, G54), J12 and J13 (FS-104: rows 111–113, 124, G73, G75, row 91, the
compulsion toolkit), J2 (G71's height on a three-colour ring), J17 (G73's Kneser graphs on the recurrence) — then the rest of the list in
its rank order (item 25). One limit of the index bites you hardest: older-format entries name what they rest on only in prose, so 87 of
`data/fs129/index/roots.md`'s 100 are lane R and your era's long chains may be missing there (item 19); find them by reading.

## Why this job

Kooshi's request and his decisions on its method are under § What Kooshi asked. The plan, `plans/FS129-cross-application-audit.md`, is
your specification: read § 3 (the stages; yours is Stage 2), § 5 (the era split) and § 7 (grades, expectations, failure) before you start.
The stub, `plans/STUB-cross-application-audit.md`, holds the instances that prompted the audit (§ Why now) — read them: each is a held
result that was not applied where it bore, which is exactly what you are looking for — and Poros's question card, which aims the audit.

## What Kooshi asked

> Right after this close, we'll be refining the workflow again... then I think it might be worth an audit of all previously novel lemmas and theorems in this project, to see where they can be applied across all others, interweaving and strengthening what we have, and potentially finding new paths. File that as a special case stub for after the workflow refinements.
> — source: plans/STUB-cross-application-audit.md § The request

> 1. yes, we don't want O(N^2) here. 2. Yes, keep to the cap, and also use general purpose agents instructed to read the deriver's identity, rather than the agent files which carry the 150k token grokkings. They'll have enough on their plates without needing all that context, and they can read them if needed. 3. yes, excellent idea. 4. definitely. Please set up the plan file and handoff, and I'll restart a new session after restarting the handoff so it'll pick up the latest changes.
> — source: plans/FS129-cross-application-audit.md § 1. Kooshi's words

> Also a note for the whole plan that not only are "hubs" important, but deep "roots", where a long chain of theorems starts, even if it has only one offshoot
> — source: plans/FS129-cross-application-audit.md § 1. Kooshi's words

His decision 4 answers the coordinator's question whether to ask, explicitly, if any arithmetic-era result bears on the measurable
question; the four questions are in the plan's § 1 in the coordinator's words.

## Who you are, and how to load it

You are a `general-purpose` agent, by Kooshi's decision 2, so that the grokkings (about 150k tokens) are not loaded into you at launch.
Read, in order: `.claude/skills/ephodos/SKILL.md` in full — the deriver's identity, which is yours for this job; then
`.claude/agents/ephodos.md` from its line `# Ephodos in lean-dir — the workflow` to its end — the lane's workflow, of which `## A
derivation job` and `## What leaves your lane` govern you (the opening job and the record job are other jobs'). Where that text says the
grokkings are preloaded, read instead: you read a grokking by its number when you need it —
`awk '/^\* \*\*G83 —/{p=1;print;next} /^\* \*\*G[0-9]+ —/{p=0} p' .claude/skills/grokkings/SKILL.md` prints G83 — and `CLAUDE.md`
§ Grokkings' theory-in-one-paragraph is the map. `ephodos-recognition` is in your skill list: invoke it fresh with the Skill tool
whenever "a known theorem almost applies", which is this audit's whole question.

## What you work from

- **The demand list, in two halves.** Poros's ranked half, `data/fs129/demand-judged.md` — 24 steps, J1–J24 — worked first, in the order
  your lane note gives; it already places all 30 of the index's verdict-level open steps (its § 4). Then the index's mechanical half,
  `data/fs129/index/open-steps.md` §§ 2–4 (12 "stalls at" lines, 372 GAP lines, 418 gap lines), for any step not already on Poros's list,
  in its stub's rank order (`plans/FRONTIER-STUBS.md`); deciding that a line there is a step already on the list is yours
  (`plans/FS129-close-inventory.md` item 24). §§ 2–4 are long (375 KB with § 1): skim them by milestone, and say in your record how far
  down you got.
- **Before you scan any statements for a step, write one line: the kind of input every argument that closes it must read**, checked
  against the list's § 2 (the held no-gos that exclude kinds). This is FS-129's question card (`plans/STUB-cross-application-audit.md`
  § The question), and the list's "How to read this list" says it in full. Both instances that prompted the audit were misses of a kind of
  input held under another name. **The list's § 1, the words that mean two things across the eras, is required reading before your first
  step**: you have not loaded the grokkings, and "tight", "window", "ring", "forced pair" and "fall/saturated" each mean two or three things
  here, so a scan by word will match wrongly or miss.
- **The index**, `data/fs129/index/` (its `data/fs129/index/README.md` says how each file was made and what it cannot see): `data/fs129/index/statements-A.md`, your
  era's statements one per line (821 theorems, 296 KB — read it in slices, by milestone, rather than whole); `data/fs129/index/theorems.jsonl`, one record per theorem with its fields; `data/fs129/index/edges.csv`; `data/fs129/index/hubs.md` and
  `data/fs129/index/roots.md` — the results most depended on, and the results where the longest chains start (Kooshi's note above: weigh a deep root as you
  weigh a hub) — but 87 of `data/fs129/index/roots.md`'s 100 are lane R, because older-format entries name their dependencies only in prose, so an
  arithmetic-era root of a long chain may be missing from it (`plans/FS129-close-inventory.md` item 19); `data/fs129/index/grokking-uses.md`; `data/fs129/index/lean-order.md`;
  `data/fs129/index/checks.md`, which lists claims with no record of their own (item 20). Read the README's CHECK list first: older-format dependencies come from prose, so
  "orphan" means only that no record names it by id, and many references are unresolved.
- **The derivation files**, `plans/*-derivation.md`, read by entry, never whole (2.9 MB in all); `LEDGER.md` by row.

## Done means

1. **Registered expectations** in your record's first saved stage, before you read the demand list: how many steps you expect lane A's
   results to close, shorten or reduce, how many nulls, and your probability that this lane moves the bearing on the answer. Poros registered P = 0.35 that your lane closes or shortens a regularity-era step from a result its stub does not cite (A5,
   `plans/FS129-close-inventory.md` item 23); register yours before you open its record, so the two are scored side by side.
2. **For each demand-list step you reach**, in your record: the step quoted with its address; the held results of your era you read
   against it (by id); and one of —
   - **a composition**: a `derivation:` block in your identity's grammar (id `FS129-OA1-<NAME>`), its statement, `uses only:` the held
     results by id, `not claimed:`, its argument in your record, verdict, grade (`hand`, or `derived from:` the held ids), `minds: 1`,
     `handoff:` de Bruijn, and a line naming the step it closes, shortens or reduces — gated with
     `python3 .claude/skills/ephodos/scripts/derive_gate.py all <record>` before each stage's commit;
   - **a null**: "no lane-A result bears", with what you read and why each near miss misses. A null is a result (plan § 7).
3. **A cross-era line**: every result of the other lane's era you saw bear on a step, noted for that lane, not derived.
4. **The heading "Theorems this phase proved"**, one line per composition with its grade and address, or a line saying none.
5. **Your report** in standing rule 11's form; `search request` items for any step a search could decide (no job searches).

## What is yours to decide

How you read — by step, by mechanism, by the hubs and roots outward — and when a near miss deserves a derivation. If the demand list
misstates a step, or the era split hides something, say so: that is a finding. If you see a composition outside the demand list —
a held result that bears somewhere nobody asked — record it; pass 2 (mechanisms) will want it. If a held result looks false as you read
it, stop and message the coordinator: a refutation of a held result cannot wait.
