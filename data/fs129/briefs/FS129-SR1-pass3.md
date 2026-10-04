# Brief FS129-SR1 — pass 3 of the cross-application audit, lane R: merges, strengthening, vacuity, and the records that disagree

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS129-SR1
  identity: Ephodos, the deriver, read as files — `.claude/skills/ephodos/SKILL.md` in full, then `.claude/agents/ephodos.md` from its line `# Ephodos in lean-dir — the workflow` to its end; invoke `ephodos-recognition` fresh with the Skill tool when two statements look like one
  role: pass 3 of FS-129, lane R (regularity-wall era): the lane's results in the Lean order merged and strengthened, each flagged result sorted for vacuity, the one-mind compositions attacked at their named weak steps, and disagreeing records reconciled
  launch: now; lane R's passes 1 and 2 (FS129-OR1, FS129-MR1) have reported; FS129-MA2 (lane A, pass 2) is running and writes only its own files
  mission: § Why this job
  statements: § What Kooshi asked
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in FS-129 is blind (Workflow 3.1); every lane's files are open to you, and each writes only its own
  channel: message the coordinator ("main") by SendMessage only for a question you cannot work around or a finding that cannot wait (a refutation of a held result, a statement defect); the report goes to `data/fs129/reports/FS129-SR1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Rule 1 matters more for you than for most: you are a general-purpose agent and carry the Agent tool, which the lane agent files withhold
  record: `plans/FS129-SR1-audit.md`
  touches: `plans/FS129-SR1-audit.md`, `data/fs129/sr1/`, `tools/fs129_sr1_*.py`, `data/fs129/reports/FS129-SR1.md`
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 500k — a successor continues from your record, and stopping with the rest listed is a good report

Hello. You are the third-pass reader of lane R in an audit Kooshi asked for. Passes 1 and 2 looked outward — which held result
closes an open step, where each mechanism bears unapplied. Your pass looks at what the project already holds and asks whether it holds it
in the best form: two statements that are one; a hypothesis that can be dropped; a result whose hypotheses nothing satisfies; two records
that say different things. Your output is what the Lean backlog will formalize next, so de Bruijn formalizes each statement once, in its
strong form, and never formalizes a vacuous one by accident.
Your lane holds almost all of the Lean order: 195 of its 197 results are lane R's, because the results handed to de Bruijn are the
recent, block-format ones. So your pass is the heaviest of the audit, and it is planned to run as successive agents: work the named items
first, then the vacuity sort, then the sweep, saving as you go, and hand back with the rest listed for FS129-SR2.

## Why this job

The plan, `plans/FS129-cross-application-audit.md`, is your specification: § 3's Stage 4 is yours, scoped first to the Lean backlog —
everything in the Lean order, `data/fs129/index/lean-order.md`, before the rest, § 7 sets the grades — **a grade is promoted only where a second route is already on record
and meets the rules of the time the result was filed; otherwise it is listed for the Lean backlog, which is now the promotion path**. The
inventory, `plans/FS129-close-inventory.md`, holds every item routed to you; the ones named below are by item number. The vacuity sort is
Kooshi's approval of item 33 (item 34), after his words under § What Kooshi asked.

## What Kooshi asked

> Right after this close, we'll be refining the workflow again... then I think it might be worth an audit of all previously novel lemmas and theorems in this project, to see where they can be applied across all others, interweaving and strengthening what we have, and potentially finding new paths. File that as a special case stub for after the workflow refinements.
> — source: plans/STUB-cross-application-audit.md § The request

> 1. yes, we don't want O(N^2) here. 2. Yes, keep to the cap, and also use general purpose agents instructed to read the deriver's identity, rather than the agent files which carry the 150k token grokkings. They'll have enough on their plates without needing all that context, and they can read them if needed. 3. yes, excellent idea. 4. definitely. Please set up the plan file and handoff, and I'll restart a new session after restarting the handoff so it'll pick up the latest changes.
> — source: plans/FS129-cross-application-audit.md § 1. Kooshi's words

> Also a note for the whole plan that not only are "hubs" important, but deep "roots", where a long chain of theorems starts, even if it has only one offshoot
> — source: plans/FS129-cross-application-audit.md § 1. Kooshi's words

> **Kooshi's reading** (2026-10-03, verbatim): "Oh... oh I see. Sounds like the vacuity issue we encountered in a lean implementation a while back... and thus gated... will be back to bite us with the hand proofs. Well, hopefully putting them in lean will help check them mechanically. This is another reason for workflow 3.1 and the lean backlog."
> — source: plans/FS129-close-inventory.md § Items

## Who you are, and how to load it

You are a `general-purpose` agent, by Kooshi's decision 2, so that the grokkings are not loaded into you at launch. Read, in order:
`.claude/skills/ephodos/SKILL.md` in full — the deriver's identity, which is yours for this job; then `.claude/agents/ephodos.md` from its
line `# Ephodos in lean-dir — the workflow` to its end, of which `## A derivation job` and `## What leaves your lane` govern you. Read a
grokking by its number when you need it —
`awk '/^\* \*\*G83 —/{p=1;print;next} /^\* \*\*G[0-9]+ —/{p=0} p' .claude/skills/grokkings/SKILL.md` prints G83.

## What you work from

- **The index**, `data/fs129/index/`: `data/fs129/index/lean-order.md` (the results handed to de Bruijn and what they rest on, dependencies
  first; three seeds are conditional, item 13), `data/fs129/index/vacuity.md` (the `none-known` results, the two borderline ones and the 16
  `named` ones that read negative), `data/fs129/index/theorems.jsonl`, `data/fs129/index/edges.csv`, `data/fs129/index/disagreements.md` (257
  pairs where `uses only:` and "Rests on it" disagree), `data/fs129/index/cycles.md` (45 dependency cycles), `data/fs129/index/checks.md`.
  **Two known defects in the edges**: 24 entries whose "Rests on it" begins "nothing" still carry edges to ids their sentence goes on to name
  (item 77; some false — a refuted entry pointing at its corrected form — some perhaps real), and older-format edges come from prose only.
- **Passes 1 and 2**: `plans/FS129-OA1-audit.md`, `plans/FS129-OR1-audit.md`, `plans/FS129-MA1-audit.md`, `plans/FS129-MR1-audit.md` (lane A's second part, `plans/FS129-MA2-audit.md`, is still running — read what it has saved),
  and their reports in `data/fs129/reports/`. Their tables of misses list the merges they found and left for you.
- **The derivation files**, `plans/*-derivation.md`, read by entry, never whole; `LEDGER.md` by row.

## Done means

1. **Registered expectations** in your first saved stage, before reading the corpus: how many merges, weakenings, vacuous results and
   disagreements you expect, and your probability that pass 3 finds a held result false.
2. **The named items first**, each a section: (a) **the attacks on the two one-mind compositions the ranking will rest on**, as checking readings, not second minds:
   FS129-OR1-QFREE's chain (FS129-OR1-WHOLE, -BENDFRAG, -QFREE-CLASS), at the two steps its deriver named — "FS112-N2-BENDS being read on a
   fragment (it depends only on the tiles present)" and "simplicity surviving horn lenses at cusp ends" (item 55) — and FS129-MR1-DOUBLETIP at
   its named step, RING-GERM (i) and N2-STAR at a change point whose other tip germ is free only because its neighbour is a change point (item
   76); (b) **the records that disagree** on what FS-112's bends leave on a ring (the stub's § Why now; `plans/FS116-close-inventory.md` items
   136 and 145), which pass 1's WHOLE may already settle — say whether it does; (c) **the merges lane R's passes found** (items 61, 62, 79):
   V6-HUG / PXKILL (YB4-2ND) / V6-ADJ / FLANK's model; FS112-SIX with FS116-N2-FIVERING and -SIXRING; FS112-U1 = FS116-V5-U1; FS111-V0-ID1 =
   FS116-V5-NE1 and FS111-C-HULL = FS116-V4-DICHOTOMY; the stuck ray and the tangent pencil; FS111-M4-CUT and FS121-D4-FACE; FS129-OA1-RINGWIND
   with FS110-Y3-GP and -N2-RING (lane A asked that this merge sit with lane R, item 70); (d) **the 24 "Rests on it: nothing" edges** (item 77):
   for the lane-R ones, which are real dependencies and which are not, so the record job can correct `data/fs129/index/edges.csv`; (e) the
   unread items lane R's passes left (items 63, 81)
3. **The vacuity sort** for your lane's flagged results (`data/fs129/index/vacuity.md`, by era), each under exactly one of four headings
   (item 36): **inhabited** (name the object, with its address); **empty** (the hypothesis class has no member — say why — so the result
   holds vacuously; then list, from `data/fs129/index/edges.csv` and by reading, every result resting on it, and say for each whether it
   inherits the vacuity or uses only a non-vacuous part); **hypothetical by design** (a step in a proof by contradiction, such as a property of
   a tight six-map, whose emptiness is the goal); **a no-go** (the statement is itself that a class is empty). Only "empty" passes vacuity on.
   The borderline and loose-pattern entries are a second list, sorted the same way (item 37).
4. **The Lean order, lane R's part, swept** after the named items: for each result, one line — merge with (id), hypothesis weakened (to
   what; derive the weaker form as an entry), stated in a stronger form already held elsewhere (by id), or unchanged. A merge or weakening
   is a `derivation:` block (id `FS129-SR1-<NAME>`) gated with `python3 .claude/skills/ephodos/scripts/derive_gate.py all <record>` before
   each stage's commit, with `handoff:` naming the merged form for de Bruijn, so the backlog formalizes it once.
5. **A list for FS129-L1** (the Lean backlog's input) at the end of the record: every merge and every weakening, as "formalize X in place of
   A, B, C", and every result sorted "empty", as "do not formalize as stated".
6. **The heading "Theorems this phase proved"**, one line per entry with its grade and address, or a line saying none.
7. **Your report** in standing rule 11's form.

## What is yours to decide

Which merges deserve an entry and which a line; how far to weaken a hypothesis before the argument stops carrying it; how to read a
disagreement between records. When two records disagree, quote both with their addresses and say which the argument supports; never edit
either (corrections are drafted, item by item, for the record job). If an attack on a one-mind composition succeeds, say exactly where, and
message the coordinator at once: a refutation of something the ranking is about to rest on cannot wait.
