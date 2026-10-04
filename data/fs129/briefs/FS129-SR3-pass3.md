# Brief FS129-SR3 — pass 3 of the cross-application audit, lane R: merges, strengthening, vacuity, and the records that disagree

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS129-SR3
  identity: Ephodos, the deriver, read as files — `.claude/skills/ephodos/SKILL.md` in full, then `.claude/agents/ephodos.md` from its line `# Ephodos in lean-dir — the workflow` to its end; invoke `ephodos-recognition` fresh with the Skill tool when two statements look like one
  role: pass 3 of FS-129, lane R (regularity-wall era): the lane's results in the Lean order merged and strengthened, each flagged result sorted for vacuity, the one-mind compositions attacked at their named weak steps, and disagreeing records reconciled
  launch: now, beside FS129-Z1 (the record job's first part) and the day's Searcher, which write only their own files; FS129-SR2 has saved and reported
  mission: § Why this job
  statements: § What Kooshi asked
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in FS-129 is blind (Workflow 3.1); every lane's files are open to you, and each writes only its own
  channel: message the coordinator ("main") by SendMessage only for a question you cannot work around or a finding that cannot wait (a refutation of a held result, a statement defect); the report goes to `data/fs129/reports/FS129-SR3.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Rule 1 matters more for you than for most: you are a general-purpose agent and carry the Agent tool, which the lane agent files withhold
  record: `plans/FS129-SR3-audit.md`
  touches: `plans/FS129-SR3-audit.md`, `data/fs129/sr3/`, `tools/fs129_sr3_*.py`, `data/fs129/reports/FS129-SR3.md`
  budget: about 200k by the harness's count, as guidance; hand back at a saved stage before about 400k — stopping with the rest listed is a good report

Hello. You are the third-pass reader of lane R in an audit Kooshi asked for. Passes 1 and 2 looked outward — which held result
closes an open step, where each mechanism bears unapplied. Your pass looks at what the project already holds and asks whether it holds it
in the best form: two statements that are one; a hypothesis that can be dropped; a result whose hypotheses nothing satisfies; two records
that say different things. Your output is what the Lean backlog will formalize next, so de Bruijn formalizes each statement once, in its
strong form, and never formalizes a vacuous one by accident.
You finish lane R's pass 3. FS129-SR1 and FS129-SR2 did the vacuity sort, the edge sorts and the whole Lean-order sweep; three items
are left, and they are small (`plans/FS129-close-inventory.md` item 120). Your entries go to the record job's second part, FS129-Z2, which
starts when you hand back, so a short, clean record is the goal. Two leads that SR2 also left — a coupling of two circles' windings for
FS106-BIKE, and an O1-OUT for valid maps — are not yours: they are new derivations, and go to stub lines.

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
- **Passes 1 and 2**: `plans/FS129-OA1-audit.md`, `plans/FS129-OR1-audit.md`, `plans/FS129-MA1-audit.md`, `plans/FS129-MR1-audit.md`, `plans/FS129-MA2-audit.md`, and lane R's pass 3 so far, `plans/FS129-SR1-audit.md` and `plans/FS129-SR2-audit.md`,
  and their reports in `data/fs129/reports/`. Their tables of misses list the merges they found and left for you.
- **The derivation files**, `plans/*-derivation.md`, read by entry, never whole; `LEDGER.md` by row.

## Done means

1. **Registered expectations** in your first saved stage, before reading the corpus: how many merges, weakenings, vacuous results and
   disagreements you expect, and your probability that pass 3 finds a held result false.
2. **The named items first**, each a section: (a) **G83's straddle against FS114-K1's (Q)-ring residues** — FS114-Y6-E2RED's survivor S6, the wrap, and the Reuleaux `(2, 1, 1, 0)` past
   `√3` — with FS129-SR1-TWOCIRC tried first, S1 having died to PXKILL (`plans/FS129-SR2-audit.md` § 4.2 states the lead; item 81);
   (b) **a wider V6-ADJ**, DOUBLETIP's analogue for adjacent change points whose outer pairs are off (Q): RING-GERM (ii) at both points, V6-ADJ's
   pinning of the outer tiles to the lens arcs, TWOCIRC for the mirror apex (FS129-MR1-DOUBLETIP is the model; `plans/FS129-MR1-audit.md`
   § Stage 2); (c) **item 63's 8 unread GAP lines** (`plans/FS129-SR2-audit.md` § 4.1, last row): for each, answered elsewhere (with the
   link), answered in place, or an open question for a named frontier stub
3. **The vacuity sort** is done (FS129-SR1 § Stage 5); add to it only a result you find that its lists missed (item 36's four headings).
4. **The Lean-order sweep** is done (FS129-SR1, FS129-SR2); nothing to sweep.
5. **Additions to the list for FS129-L1** (SR1 § 6.2, SR2 § 4.3), in the same form, if any — (the Lean backlog's input) at the end of the record: every merge and every weakening, as "formalize X in place of
   A, B, C", and every result sorted "empty", as "do not formalize as stated".
6. **The heading "Theorems this phase proved"**, one line per entry with its grade and address, or a line saying none.
7. **Your report** in standing rule 11's form.

## What is yours to decide

Which merges deserve an entry and which a line; how far to weaken a hypothesis before the argument stops carrying it; how to read a
disagreement between records. When two records disagree, quote both with their addresses and say which the argument supports; never edit
either (corrections are drafted, item by item, for the record job). If an attack on a one-mind composition succeeds, say exactly where, and
message the coordinator at once: a refutation of something the ranking is about to rest on cannot wait.

## Amendment, 2026-10-03 — one more item, (d): what "simple" FS129-OR1-QFREE's chain uses

The record job (FS129-Z1, running) found, while filing FS129-SR2-QFCASE, that its argument shows FS116-S1-QF's fragments simple **at p** only —
glossing FS-116's "simple" as "one sector per tile at p" (`plans/FS129-SR2-audit.md` line 413) — while FS-116's claim list defines simple for
the whole fragment:

> - **Simple** (`plans/FS114-N-proof.md` l. 444, verbatim): "every tile an open disc whose closure meets each other tile's closure in a connected set or not at
> — source: data/fs116/claims.md § 0

(the definition continues on its next line there). So QFCASE, SR2's line "formalize QFREE in place of S1-QF", and the correction "S1-QF has no
non-simple remainder" (`plans/FS129-close-inventory.md` items 115, 117) hold only if FS129-OR1-QFREE's chain reads simplicity at p alone.

**Item (d), after your items (a)–(c) or before them if you judge it more urgent:** read FS129-OR1-QFREE's chain — FS129-OR1-WHOLE,
FS129-OR1-BENDFRAG, FS129-OR1-QFREE-CLASS, FS129-SR1-BENDANY's class clause, and FS116-Y4-EMPTY by both its routes (FS116-Y4's own: RING-GERM,
Y3-TIPS, FLANK; and FS116-V6's, whose `uses only:` line says simplicity enters only at V6-COUNT's last step, at p, per
`plans/FS116-V6-verification.md`) — and say, step by step, whether each uses "simple" globally or only at p. Then one of: (i) the whole chain
needs simplicity only at p — derive QFREE with "simple at p" as an entry (a weakening), and QFCASE stands; (ii) some step needs it globally —
name the step; QFCASE then fails, S1-QF keeps its own route (S1-LENS, S1-EXIT, S1-CLUSTER), and item 117's correction is withdrawn. Either is a
good result. Standing rules unchanged — start no agent of your own, because staffing is Kooshi's and the coordinator reviews only work it
knows exists; save the item as a stage.
