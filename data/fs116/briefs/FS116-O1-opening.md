# Brief FS116-O1 — Ephodos: FS-116's opening job (the reframe, the plan, the proposed claim list)

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS116-O1
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § The opening job is this job's procedure. Invoke `ephodos-recognition` fresh with the Skill tool for the recognition sentence §PA searches in, and `ephodos-invention` if two held descriptions collide
  role: the opening of FS-116, the local exclusion: §G, §PA, §IQ, the plan proper, and the proposed claim list
  launch: now, beside FS-121's opening job (FS121-O1), another Ephodos on route M's other half; neither writes the other's files
  mission: § Why this job
  statements: § The question you open on
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — this is not a blind job; FS-121's opening runs beside you and its records are readable, but you write none of them
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/fs116/reports/FS116-O1.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` is part of it too if you build an exact check (its § Make the gate fail, and watch it fail)
  record: `plans/FS116-local-exclusion.md`
  touches: `plans/FS116-local-exclusion.md`, `data/fs116/claims.md`, `data/fs116/o1/`, `tools/fs116_o1_*.py`, `data/fs116/reports/FS116-O1.md`, and new stub files `plans/STUB-*.md` numbered FS-123 to FS-125 only
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are Ephodos. FS-116 is the first milestone opened under the new pipeline from a clean start: Poros posed its question an
hour ago, and your plan and claim list are what every later job of this milestone works from.

## Why this job

The aim, in Kooshi's words:

> "My goal is to fully solve, and then verify in Lean, HN. Then we publish.
> — source: CLAUDE.md § The aim

FS-116 is route M's first half and rank 1 on the frontier (`plans/FRONTIER-STUBS.md`). Its stub is `plans/STUB-local-exclusion.md`,
written by FS-114's close and given its question today by Poros (job FS116-P1, record `plans/POROS-2026-09-28-fs116-question.md`).
The stub's bearing states what either answer decides; read it before anything else in the stub. Kooshi has also opened FS-121, the map
step (route M's other half), beside this milestone: its opening job runs now, in another mind.

## The question you open on

The existence form, from Poros's card:

> **Is there a radius `R` — one `R` for every complexity, Siamese pairs allowed — such that no valid fragment exists on the closed disc of radius `R`
> about a vertex of at least four colours?**
> — source: plans/STUB-local-exclusion.md § Existence form

The structural form:

> **In every valid fragment with any number `k ≥ 4` of colours, what does the unit circle about each vertex of at least four colours carry — its (Q)
> arcs, its change points, and the vertices of at least four colours it places at distance 1 — and which of these ring types can recur at every such
> vertex a ring places?**
> — source: plans/STUB-local-exclusion.md § Structural form

Your §IQ quotes both verbatim. The definitions they use (a valid map, a fragment, a tactic edge, a (Q) arc) are `data/fs114/claims.md`
§ 0; quote any you use, with their address, into your claim list.

## What you read

- **The stub in full**, `plans/STUB-local-exclusion.md`, and what its italic preamble names: `LEDGER.md` rows 133–141 (with row 131),
  `plans/FS114-derivation.md` in full, `plans/FS114-C-close.md` stage 2, `data/fs114/claims.md` § 0.
- **Poros's record**, `plans/POROS-2026-09-28-fs116-question.md` § 2 (the three cards for this opening, ranked, with the survey behind
  them) and its hunch ledger.
- **The grokkings**, preloaded in your context (confirmed this session: two lanes found the block at launch). §G reads them there.

## The cards addressed to this opening

Poros addressed three cards to you (the stub's § The question (Poros, 2026-09-29), and the record's § 2.4):
- `the-yes-needs-no-map` (rank 2): "a check at the §IQ, under an hour". Its answer decides whether the stub's bearing holds as written
  (a failure of the NO would then give `χ(ℝ²) ≤ 6` with no MR), so answer it inside §IQ.
- `what-does-saturation-pin` (rank 1): "an hour to one round". Its answer decides the class the claim list poses the NO in first.
  Answer it in the plan if it comes within that; otherwise make it the first claim of the first derivation round. Which, is yours.
- `what-do-q-rings-force` (rank 3, one round): a derivation round's, not the opening's.

FS-121's card `do-ladders-end-on-q-rings` asks whether FS-121's ladders end on this milestone's (Q) rings; FS-121's opening answers
it, not you. Poros's card says FS-121's opening is "to be told the answer" of `what-does-saturation-pin`: send your answer to "main"
the moment it is committed, and I route it. Do not message FS-121's opening yourself (standing rule: every arrow passes through me).

## Done means

1. **The plan**, `plans/FS116-local-exclusion.md`, in your lane file's order: §G (reasons only for *bears* and *falsifiable here*,
   the rest listed by number, ledger rows the stub cites plus rows 137–141, the last close's), §PA (the stub's § Prior-art debts
   first: Sirgedas's thread and the HNT simulator thread; the eight questions), §IQ (five items, with `the-yes-needs-no-map` answered
   there), then the plan proper: routes, stages, failure clauses, and only predictions whose outcome decides what runs next, each
   naming that decision. The stub's § The opening queue (round 7 of FS-114) and § Owed second minds are inputs to the plan; order them
   against Poros's cards as you judge.
2. **The proposed claim list**, `data/fs116/claims.md`, in `data/fs114/claims.md`'s form: statements fixed verbatim, each with its
   *not claimed* line, the definitions they use quoted with addresses, and nothing else (no grade, no prior, no route). I freeze it
   before any derivation job launches; a statement that lives only in the plan would be fenced from the verifiers with it.
3. **An erratum draft**, in the plan: Poros reports that `plans/FS114-derivation.md` l. 239, FS114-N2-ENDS's model line ("each with
   four tactic edges (`n = 0`, charge −2)"), is wrong for the capped strip's midline vertices, which have four straight edges (`n = 4`,
   charge 2), and that l. 261's N3-JOINT model line inherits it (Poros's evidence: `data/fs114/fs114-y6/survey.out`,
   `plans/FS114-N-proof.md` l. 299). Check it, and draft the corrected lines with their exact slots, or say why they stand.
4. **The report** in the standing rules' form, with proposed bibliography rows as INVENTORY lines the day you find the papers.

## What is yours to decide

The plan: its routes, their order, its stages, its claim list, and whether the NO is posed first in the honestly saturated class.
Whether the question as posed is the right one: if the card's forms, the stub's bearing or this brief frame the milestone wrongly, say
so — a wrong frame reported is a finding. Stub numbers FS-123 to FS-125 are yours for any stub you mint; FS-121's opening has FS-126 to
FS-128, so the two never collide.

## Stages (save and commit each; standing rule 2)

1. The readback (every quotation above checked against its source), then §G.
2. §PA.
3. §IQ, with `the-yes-needs-no-map`'s check.
4. The plan proper, the erratum draft, and `what-does-saturation-pin` if it fits.
5. The proposed claim list, then the report.

Thank you.
