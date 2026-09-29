# Brief FS116-P1 — Poros: the question card for FS-116, the local exclusion

*Written 2026-09-28 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS116-P1
  identity: Poros — your agent file (`.claude/agents/poros.md`) is your identity and your lane's workflow; invoke `poros-anomaly-hunt` fresh with the Skill tool if no question comes, and `poros-reframing` if a frame will not move
  role: posing the next milestone's question (your lane file's job 1), for FS-116
  launch: now, beside a short Ephodos drafting job (TC1) that touches none of your files
  mission: § Why this job
  statements: § The statements you start from
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — no blind job is running; FS-116's claim list is not written yet, and FS-114 and FS-111 are closed
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/fs116/reports/FS116-P1.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/POROS-2026-09-28-fs116-question.md`
  touches: `plans/POROS-2026-09-28-fs116-question.md`, `plans/STUB-local-exclusion.md`, `data/fs116/p1/`, `data/fs116/reports/FS116-P1.md`
  budget: about 250k by the harness's count, as guidance; hand back at a saved stage before about 450k

Hello. You are Poros. This is the first milestone opened under the new pipeline from a clean start (`CLAUDE.md` § The pipeline): you
scout ahead, Ephodos derives, de Bruijn formalizes, and I route every packet between you. Your card is the first packet of FS-116.

## Why this job

The aim, in Kooshi's words:

> "My goal is to fully solve, and then verify in Lean, HN. Then we publish.
> — source: CLAUDE.md § The aim

FS-116 is rank 1 on your own re-rank of this evening, and route M's first half (`plans/FRONTIER-STUBS.md` rank 1;
`plans/POROS-2026-09-28-close-reread.md` § Draft re-rank). Its stub, `plans/STUB-local-exclusion.md`, was written by FS-114's close job
and carries FS-114's local question and round 7's queue, but it has no `## The question (Poros, <date>)` section. Ephodos's opening
job quotes the question's existence form and structural form verbatim from that section into its §IQ, so the opening waits on your
card. The workflow step is `.claude/output-styles/keryx.md` § A milestone, end to end, step 1; your procedure is your lane file's job 1.

Two of your own cards from the close re-read point at this opening and were never answered: card 1, `do-fs114-kills-survive-a-band`
(answered by "a fresh mind at FS-116's opening (its §IQ), on one kill, before round 7's queue"), and card 2,
`which-no-does-route-m-consume` (answered by "FS-121's opening, or FS-116's §IQ if FS-121 is not open"). FS-121 is not open, and
whether it opens beside FS-116 is Kooshi's staffing call, not yet made; plan as if it will not.

## The statements you start from

FS-114's local question, as its claim list fixed it:

> - **C114-LOCAL-F** *(this list; card 2's falsifier as a claim)*: there are an explicit radius `R` and a derivation that no valid fragment exists on the
>   closed disc of radius `R` about a vertex of at least four colours.
> — source: data/fs114/claims.md § 3. The forms of the global step

Its lower bound was corrected at FS-114's close from `√15/4 + √3/2` to `φ²/√2 ≈ 1.8512` (`data/fs114/claims.md` § 9, and the stub's
§ The question, in plain language). Your card 1's ask:

> ask: Does FS114-Y4-RSTOPALL, the bowtie killed at `√3`, survive as an exclusion for band-proper fragments with slack ε and small holes, at a radius and margin independent of ε and the complexity?
> — source: plans/POROS-2026-09-28-close-reread.md § 2.4 The cards

And card 2's:

> ask: Can FS-121's map step, when it produces a segment-and-arc map, produce one of bounded complexity — or must route M's NO cover every locally finite map?
> — source: plans/POROS-2026-09-28-close-reread.md § 2.4 The cards

## What you read

- **The stub**, `plans/STUB-local-exclusion.md`, in full, and what its italic preamble says to read first: `LEDGER.md` rows 133–141,
  `plans/FS114-derivation.md` (its § 3 is the stub's ground), `plans/FS114-C-close.md` stage 2, and `data/fs114/claims.md` § 0 (the
  definitions of a valid map, a fragment, a tactic edge, a (Q) arc).
- **Route M's other half**, for card 2: `plans/STUB-map-step.md` and the FS-111 entries card 2 cites (`plans/FS111-derivation.md`).
- **Your hunch ledger**, carried forward from `plans/POROS-2026-09-28-close-reread.md` (§ 1.3 and § 2.3, scored in § 2.2).
- The grokkings are preloaded into your context (next section). The stub's provisional bearings name G83, G86, G79, G82 and G15 among
  others; read them from your context, not from memory of an earlier session.

## Your first act, before you read any file

The grokkings (G1–G87) moved today into a skill that your agent file preloads at launch (`skills: grokkings`), and a fresh session is
the clean test that the preload works. So before any tool call, look in your own context for a skill block whose base directory ends
in the word grokkings. In your record's readback, write the base-directory line as you see it and the first eight words of G87's entry, both
from your context, not from the file. If there is no such block, say so, read `.claude/skills/grokkings/SKILL.md` in full before you
start, and put a `question for another lane` line in your report. Either outcome is a finding I want.

## Done means

1. **The stub**, `plans/STUB-local-exclusion.md`, carrying a section `## The question (Poros, <date>)` with its three subsections — `###
   The card` in your identity's grammar, `### Existence form`, `### Structural form` (a question about every solution that cannot be
   answered without an invariant every solution carries, `CLAUDE.md` G72; if none comes, "no structural form yet" and why) — and its
   provisional-bearings line and § Bearing on the answer rewritten in place. Leave the rest of the stub as FS-114's close wrote it,
   except where you find it wrong; then say what and why in your record.
2. **Your record**, `plans/POROS-2026-09-28-fs116-question.md`, passing `python3 .claude/skills/poros/scripts/poros_gate.py all
   plans/POROS-2026-09-28-fs116-question.md` from the repository root before each stage's commit: the readback (the quotations
   above checked against their sources, and the grokkings finding), your expectations written before the reading, the survey, the
   hunch ledger carried forward, the card or cards, the `Invention signal:` line, and what you decided about cards 1 and 2.
3. **The report** in the standing rules' form.

## What is yours to decide

The question itself. Whether C114-LOCAL-F as posed is FS-116's question, or whether card 1 (a band-proper form, if the straddle margin
survives) or card 2 (a radius at each complexity rather than one uniform radius) changes what FS-116 should ask; whether one card or
several; what the structural form is. If the stub, its bearing, or this brief frames the milestone wrongly, say so: a wrong frame
reported is a finding, not a refusal. You pose; you do not derive — a card whose answer is a derivation is addressed to Ephodos.

## Stages (save and commit each; standing rule 2)

1. The readback (with the grokkings finding), your expectations, and the hunch ledger carried forward.
2. The survey of the record by provenance, and the card or cards.
3. The stub's new section and its bearings rewritten, then the report.

Thank you.
