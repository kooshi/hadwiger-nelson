exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
W6=WT+"fs131-w6/"; FD=W6+"data/fs131/k6/FanDesign.lean"; KP=W6+"plans/FS131-w6-kernel-plan.md"
b=f'''# Brief FS131-E8 — the bridge under route M's regularity hypothesis: do REG-J′'s frozen words, with saturation, give the fan with end tangents that every consumer reads?

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-E8
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job
  role: derive one fixed question to a verdict — the bridge derived (found in the record, or derived here), refuted by an exhibited saturated colouring, or "not derived; stalls at" a named step — and say what the verdict does to the results that read REG-J′
  launch: now, beside de Bruijn jobs on branches of their own; you write on `main`, to paths no other job writes
  mission: § Why this job
  statements: § The question
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a refutation (at once: the planner of wave 6's second pass states its rows over this hypothesis), a derivation an implementer can formalize, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-E8.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` § Make the gate fail, and watch it fail, before you build any check
  record: `plans/FS131-E8-derivation.md`
  touches: `plans/FS131-E8-derivation.md`, `data/fs131/e8/` (scripts and scratch here, not in `tools/`), `data/fs131/reports/FS131-E8.md`
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 450k — read your token count at every saved stage

Hello. The Lean backlog (FS-131) turns this project's hand-derived results into kernel-checked ones, and its sixth wave is the thirty-five results
on saturated colourings — route M's regularity (`LEDGER.md` rows 139–144; `CLAUDE.md` § The aim, item 6). Reading them against Lean, the wave's
planner found that the hypothesis they share, REG-J′, is used in a stronger form than its written words: every consumer reads a *fan* at each
singular point — finitely many interface arcs, each a polar graph with a limit direction — while the frozen words say only that each singular point
meets finitely many interface arcs. The end tangents are taken silently from C11, whose unit discs hold only inside a neighbourhood that shrinks
toward the singular set. The planner found no derivation of the step from one form to the other. That step is your question.

## Why this job

REG-J′ is the hypothesis of route M, one of the two routes to seven (`CLAUDE.md` § Where the problem stands, item 31), and FS-126 and FS-127 are
posed over it. If the literal form does not give the fan, then the map-step results hold under a stronger hypothesis than the frontier's stubs
state, and what those milestones must supply grows; if it does, a missing lemma is found and can be formalized. Both are results — Kooshi: *"A
proven theorem about why its impossible is also valid. All novel knowledge is a success."* (`plans/STANDING-RULES.md` rule 4). The finding and the
ruling:

{item(481)}
## The question

The planner fixed both forms and the bridge in Lean (a design file, elaborated, not a library module) and in its record's § 6 with the addresses of
the frozen words and of the derivations' uses; read both whole. The three definitions' first lines, and the section:

{Q(FD,"def RegJLiteral ")}
{Q(FD,"def RegJFan ")}
{Q(FD,"def RegJBridge ")}
{Q(KP,"## Stage 6")}
**Q.** For a saturated honest colouring of the plane with `k` colours satisfying REG-J′ in its frozen words, does every singular point have a fan
with end tangents — the four clauses (α)–(δ) by which the planner's § 6 says the fan exceeds the words? Answer, clause by clause: derived (with
the entry that derives it, or your derivation), refuted (a colouring exhibited exactly, saturated, satisfying the words and failing the clause), or
not derived, with the step where it stalls.

*Not claimed*: anything about whether REG-J′ itself holds for any colouring; anything at a fixed number of colours unless your argument reads it.

**A second, smaller question, if budget remains** (from wave 10's planner; inventory item 484): J45-SI-5's step (c) cites ergodic averages along a
tempered Følner sequence — a pointwise ergodic theorem Mathlib lacks (`plans/FS84-SI-D-derivation.md` § 2.2, SI-5 (c)). Is there an argument by
conditional expectation that avoids it? A yes with the argument, or a no with the reason.

## Done means

1. **Your readback first**: check the quotations against their sources; read the planner's § 6 and its design file, REG-J′'s frozen words and
   close note (`data/fs121/claims.md`), C11 and its use of tangents (`plans/FS111-M-regularity.md` § 4.1), and the entries of the rows that read
   the fan (the planner's § 6 lists them). Restate the question in your record; register a prediction per clause before deriving. Commit and push.
2. **A verdict per clause**, in your lane's derivation form (statement, uses only, not claimed, argument, verdict, grade, minds, model, prior art,
   handoff), saving after each. A refuting colouring is exhibited exactly and its saturation and the words checked, with a control that fires on
   a planted fault; no search.
3. **The trace**: which filed results read which clause, what each becomes under your verdict (unchanged, true under the stronger hypothesis only,
   or needing the bridge as a lemma), and one drafted bearing line each for `plans/STUB-curved-pencils.md` and the lateral-extent stub if the
   verdict moves them (I file them).
4. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed; your derive gate
   (`.claude/skills/ephodos/scripts/derive_gate.py all plans/FS131-E8-derivation.md`, from `plans/`) green; the report in standing rule 11's
   form. Stopping at a saved stage with some clauses answered and the rest open at named steps is a good report.

## What is yours to decide

The route to each clause and the form of any counterexample. Attack the question: if the fan is more than the consumers need — if each reads only
some of (α)–(δ) — say which, because the weakest hypothesis they share is what the kernel should carry. If the planner's reading of the frozen
words is wrong, say so with the address. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator
can only review work it knows exists).

## The machine

No Lean build is needed. A check that needs more than a few gigabytes runs under the slot
(`/home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 4 -- <command>`). `/tmp` is a tmpfs: keep what your record cites under
`data/fs131/e8/`.
'''
open(ROOT+"data/fs131/briefs/FS131-E8-regj-bridge.md","w").write(b)
