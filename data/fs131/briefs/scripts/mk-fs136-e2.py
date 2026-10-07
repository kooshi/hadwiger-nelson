exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS136-E2: FS-136's second derive round — the table run forward: a cell with one label left is that label; the forced closure of
# a seed. Three claims fixed in data/fs136/claims.md by the dated line of FS-136 inventory item 8.
import os
RQ="data/external/EXT-OAI1-request.md"; INV6="plans/FS136-close-inventory.md"; CL6="data/fs136/claims.md"
STQ="plans/STUB-covering-pairs.md"; E1R="plans/FS136-E1-derivation.md"; PL="plans/FS136-the-point-across.md"; PO="plans/POROS-2026-10-07-fs136-round1.md"
os.makedirs(ROOT+"data/fs136/e2",exist_ok=True)
def inv(n,c):
    l=line(INV6,f"{n}. **",c); return "> "+l+"\n> — source: "+INV6+" § Items\n"
WORD=Q(RQ,"> I agree with all 3.")
CARD=Q(STQ,"question: how-far-does-a-seed-force")
EXP=Q(STQ,"C-FORCED derived as posed 0.9;")
FAIL="\n".join([Q(STQ,"- If C-FORCED is already held"),Q(STQ,"- If the closure on R7 empties a cell, stop:"),Q(STQ,"- If every closure stalls at its first step,"),Q(STQ,"- Every statement says in its headline")])
CLAIMS="\n".join(Q(CL6,f"  **C136-{n}** (the card's") for n in ["FORCED","CLOSE","STOP-GERMS"])
HEAD=Q(CL6,"  **C136-TABLE** — verdict:")
ITEMS="\n".join([inv(4,"FS136-E1, verdicts through its Stage 3"),inv(5,"FS136-E1, the last two claims"),inv(8,"FS136-P1, first message")])
b=f'''# Brief FS136-E2 — the second round: run the table forward — where one label is left it must be there — and see how far two meeting points force a colouring

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS136-E2
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; this is a derivation job on a fixed claim list, in a milestone whose unit has just changed — so its first stage walks the grokkings again from inside the new unit, as your workflow's opening asks of the job that meets a re-posed question
  role: the second derive round of the milestone on covering pairs — derive that a cell near a point in which the pieces at the points one unit away leave exactly one label is almost all that label; define what a finite family of pieces forces by repeating that step; and compute, by exact arithmetic and forced steps only, how far the pieces at one pair force a colouring on three objects — the tight seven-colouring first, where nothing may come out empty
  launch: now, on `main`, into the slot the asking lane freed; an implementer of the kernel lane works on a branch and writes nothing you write; no landing is in flight
  mission: § Why this job
  statements: § The claims
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind
  channel: message the coordinator ("main") by SendMessage — **at once** if the closure on the seven-colouring empties a cell (a defect in the statement or the script, never a finding: stop there); **at once** if a closure closes round a ring with no cell empty and none free, or reaches any six-coloured piece beyond the printed radius `φ²/√2` about its seed (it goes to Kooshi as "claimed by one mind, unchecked"); at once if a statement is false as posed, or already held under another name; with each claim's statement and *not claimed* line before you derive it; with each verdict as it is saved; and for a question you cannot work around. The report goes to `data/fs136/reports/FS136-E2.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `RUNNING.md` § Building (anything that runs longer than two minutes runs under the slot)
  record: `plans/FS136-E2-derivation.md`
  touches: `plans/FS136-E2-derivation.md`; `plans/FS136-the-point-across.md` (a dated second-round section under what stands); `data/fs136/e2/`, `data/fs136/reports/FS136-E2.md`; **not** `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, the stubs, the claim list (`{CL6}` is mine: you send me each statement and I fix it by a dated line), the inventories, `plans/SEARCH-QUEUE.md` (a branch you would have taken is a `search request` line in your report), the first round's record, the asking lane's record and reader (copy what you need under your own directory), any Lean file, `tools/`
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so use this: **a saved stage after the first claim with its controls, after each seed's closure, and after the third claim; if the seven-colouring's control is not green after three attempts at the script, stop at a saved stage and hand back**

Hello. This milestone asks about two meeting points of a measurable six-colouring whose colours together are all six, and
the points one unit from both. Its first round, three hours ago, gave one head statement — near such a point, almost every
point's label lies, at each meeting point that carries it, wholly on the matching side of the far unit circle — and used
it to close every stopping point of every six-coloured object this project holds. Every one of those results reads regions
somebody hands it and concludes that something cannot be coloured. The asking lane then read the same statement the other
way: where the regions at the two meeting points leave a cell with exactly one label, that label must fill the cell — a
region nobody kept — and that region is a meeting point's region for the points one unit further on. Nobody has drawn that
step or run it. It is yours.

## Why this job

Kooshi's word of this morning — "the standard workflow, attacking 6/7" (verbatim in `{RQ}` § Kooshi's sixth word):

{WORD}
Every statement of two milestones about measurable colourings begins "if the colouring has these regions". None gives a
colouring a region. The step posed here is the first that would: not a first region — nothing here says a colouring has
one — but new regions from old ones, at new points. Run to its end from a seed of two meeting points it has three
outcomes, and each is worth having: a cell with no label left (that pair of vertex figures is excluded from every
colouring, by its own two points and nothing else kept); cells with two or more labels left (the list of them is the whole
room six has near the seed, and the place where a search may begin); or a closed ring (a six-coloured fragment given by
formula from its seed). None of the three fixes the plane's number by itself. Do not lean toward any: the asking lane's own
odds are below, and its last card's odds were wrong in the interesting direction.

The line between your lane and the search lane, ruled for this job: **a forced step — exactly one label left — computed in
exact arithmetic is a derivation's step; a choice among two or more labels is a branch, and a branch is never taken here**:
it is a line in your report for the search queue. The fixpoint of forced steps does not depend on their order, and that is
what makes it a statement and not a search.

## The claims

**The card**, in the asking lane's stub — `{STQ}` § The question, second round (Poros, 2026-10-07, after FS136-E1); read the
section whole: the card, both forms, what each answer gives, the three first claims with their controls, the registered
expectations, the failure clauses:

{CARD}
{EXP}
{FAIL}
**The three claims, as fixed in the claim list** `{CL6}` (its last dated block; read it whole — each is the card's bullet
copied by script: the statement, its smallest form, its controls, what it would restate, its side):

{CLAIMS}
**The head statement they stand on**, as its verdict is about it (the same file, the block before):

{HEAD}
**How it came to be, as I logged it** (read each item whole in `{INV6}`, with the rules that judge the milestone above
them; item 8 holds the announcement rule for this round, written before any verdict):

{ITEMS}
**What to read**: the first round's record, `{E1R}` — the entries C136-TABLE, C136-COVER, C136-ONE with their two
arguments, § 2.2's table of the reading, Stage 5's cell argument and the exact checker it names
(`data/fs136/e1/stop_check.py`), § 6.4; the asking lane's record, `{PO}`, Stages 1–3 (its three readings, the reframe, the
home), with its reader and outputs under `data/fs136/p1/`; the milestone's plan, `{PL}`. **The kernel lane holds the head
statement's one-member form**: `ae_onSide_of_label`, proved today on a branch with the nine statements of the other
milestone's second module (FS-124 inventory items 34–41) — a handoff line for each claim says what a kernel statement of
it would be.

**Prior art inside this project, to read at its source before the first claim is called new** — the asking lane names it
and did not read it: the paragraph of `plans/FS132-E3-derivation.md` that `plans/STUB-seed-remainder.md` (its third
question) keeps as "a region where one label is forced survives"; and the entry C124-SIX-CONES of
`plans/FS124-derivation.md`. Search the six derivation files by file for the forward step under other words before you
write a *restates* line: `plans/FS107-derivation.md`, `plans/FS110-derivation.md`, `plans/FS112-derivation.md`,
`plans/FS114-derivation.md`, `plans/FS116-derivation.md`, `plans/FS124-derivation.md`, and `plans/FS132-derivation.md`.

**One thing I noticed reading the card, unchecked — yours to settle in the first stage**: the closure uses the forced cell
as a *piece* at the point, and a piece is a connected open set with the point in its closure. The first claim as posed
concludes "almost every point of the cell near the point has the label"; say where the cell's connectedness near the point
comes from (it is cut by finitely many unit circles through the point), or state the closure over what the argument
really uses in place of "piece" — the kernel planner found that the one lemma under all of this asks only for a
connected set with a point on each side, and nothing of its being a whole region.

## Done means

1. **Your readback first**: the quotations against their sources; the card's section, the two records and the prior-art
   paragraph read; the re-walk of the grokkings from inside the new unit (a seed and what it forces), with *bears* lines;
   recognition, fresh, on the three claims. **Send me each claim's statement as your verdict will be about it, with its
   *not claimed* line, before you derive it** — each says in its headline that it is about colourings that have the seed,
   and that no weak six-colouring is known to have one. Open your record. Commit and push.
2. **The first claim** (the forward step), derived or refuted, with the controls the card names — on objects with no
   margin, the seven-colouring among them — and your own plant. A saved stage; the verdict to me.
3. **The second claim**: the closure defined, and "every weak colouring that has the seed has its closure" derived; then
   the three seeds **in the card's order, the seven-colouring first**. For each: the closure by exact arithmetic in the
   object's own field, forced steps only, out to the object's edge; at each point reached, the cells forced, free and
   empty; where it agrees with the object and where the object has more. The checker has a control that fires (a planted
   wrong bar must change the closure), and every step it takes is listed so that a second script could replay it. A
   saved stage after each seed; each verdict to me as it is saved.
4. **The third claim** (three stops in germ form), short: derived or refuted, with the radius law the card states and the
   exact witnesses; say in its entry what it corrects in the first round's closing section, in one sentence.
5. **For every claim**: what is new beyond the held entry it restates; the class it holds on; the side it moves, if any;
   a handoff line for the kernel lane. **For every free cell**: a `search request` line (the seed, the point, the labels
   left) — the list is a result.
6. **Your record** in stages headed "Stage n — SAVED", with "Theorems this phase proved", the predictions scored against
   the card's registered numbers and your own, the sweeps, and where a successor takes over; its gate
   (`.claude/skills/ephodos/scripts/derive_gate.py all`, run from `plans/`) green; the report in standing rule 11's form.
   **Stopping at a saved stage with the first claim and the seven-colouring's closure done is a good report** — say
   exactly which seeds are left.

## What is yours to decide

The statements' exact forms, the definition of the closure, the route, the script, the order within a stage. Attack the
card as hard as you would a claim: it says the forward step is "one line" from the head statement — if it needs more
(connectedness; a cell that meets every ball; a label of no family, which the head statement leaves unconstrained), that is
where the statement changes, and a changed statement reported is a finding. And attack my framing above: I call the
closure "a statement and not a search" because its fixpoint is order-free — if the step is not monotone in the way that
needs (a forced piece is only a germ, with a radius that shrinks at every step), say what the closure really is. You
start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work
it knows exists).
'''
open(ROOT+"data/fs136/briefs/FS136-E2-forward.md","w").write(b)
print("written FS136-E2",len(b))
