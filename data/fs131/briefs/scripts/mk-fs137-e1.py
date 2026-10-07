exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS137-E1: FS-137's opening job (§G, §PA, §IQ, the plan), then its six first claims. Run after the claim list
# data/fs137/claims.md is fixed and the inventory is opened.
import os
RQ="data/external/EXT-OAI1-request.md"; INV7="plans/FS137-close-inventory.md"; CL7="data/fs137/claims.md"; INV6="plans/FS136-close-inventory.md"
ST="plans/STUB-collars.md"; DER6="plans/FS136-derivation.md"; PO="plans/POROS-2026-10-07-fs136-derived.md"
assert os.path.exists(ROOT+CL7) and os.path.exists(ROOT+INV7)
os.makedirs(ROOT+"data/fs137/e1",exist_ok=True)
def inv6(n,c):
    l=line(INV6,f"{n}. **",c); return "> "+l+"\n> — source: "+INV6+" § Items\n"
WORD=Q(RQ,"> I agree with all 3.")
CARD=Q(ST,"question: can-a-ring-afford-its-points-at-six")
DEFS=Q(CL7,"**What the count is, in the held words.**")
NAMES=["BUDGET","THREE","SIXTY","OWN","MEET","RING"]
CLAIMS="\n".join(Q(CL7,f"  **C137-{n}** (the card's claim") for n in NAMES)
RULES=Q(INV7,"2. **The announcement rule.**")
ITEMS="\n".join([inv6(11,"FS136-E2, verdicts"),inv6(12,"FS136-E2, the clause I kept fires"),inv6(17,"FS136-Z1 done"),inv6(19,"FS136-K1, mid-phase-1"),inv6(20,"FS136-P2, first message")])
b=f'''# Brief FS137-E1 — opening the milestone on what a ring can afford at six: the re-grokking, the prior-art gate, the invariant question, the plan — and the six first claims

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS137-E1
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; this job is its opening job (§G, §PA, §IQ, the plan) followed at once by its derivation job on the first claims, which are fixed
  role: open the milestone the asking lane chose an hour ago — about the labels a point's own corner pattern leaves on each side of its unit circle, in every direction, and whether at six colours the points round one ring can all afford what the tight seven-colouring's points afford at seven — and take its six first claims in the card's order: a count from plane geometry, three statements under it, a rule for where two forced arcs meet, and the ring itself
  launch: when the asking lane's job has handed back, on `main`; a landing of the kernel lane is in flight on `main` and a planner works blind on a branch — neither writes a file you write, and **your commit subjects say what you did, never how a statement is argued** (the planner is shown recent subjects, and its seven statements are entries you will be reading)
  mission: § Why this job
  statements: § The claims
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind to you
  channel: message the coordinator ("main") by SendMessage **(1) with each claim's exact statement and its *not claimed* line as soon as your plan holds them**, before you derive it; **(2) with each verdict as it is saved** — derived, refuted by an object, a gap at a named step; **(3) at once** for anything that would fix the value of the chromatic number of the plane (it goes to Kooshi as "claimed by one mind, unchecked"), for a count that fires on the tight seven-colouring or on a point a held six-coloured object holds (a defect: stop there), for a label forced along an arc on an object nobody has read, for a defect in a statement, for two results that cannot both hold, or for prior art; and for a question you cannot work around. The report goes to `data/fs137/reports/FS137-E1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` § Make the gate fail, and watch it fail, before you build any check, and § Building (anything past two minutes runs under the slot)
  record: `plans/FS137-E1-derivation.md`
  touches: `plans/FS137-E1-derivation.md`, `plans/FS137-the-ring-budget.md` (the milestone's plan: its §G, §PA, §IQ, the route), `data/fs137/e1/` (every script and its output — not `tools/`: a landing is in flight on `main`), `data/fs137/reports/FS137-E1.md`; **not** the claim list (`{CL7}` is the coordinator's: you send me each statement and I fix it by a dated line), the stub (the asking lane's; a correction to it is a draft in your record), any derivation file of another milestone (a correction owed is a draft in your record), another job's engine, reader or loader (copy it into your folder and say so), `plans/SEARCH-QUEUE.md` (a branch you would have taken is a `search request` line in your report), `CLAUDE.md`, `LEDGER.md`, any Lean file, the outside clone at `/home/kooshi/source/math`
  budget: about 400k by the harness's count, as guidance (your launch preloads the grokkings, about 150k); you cannot read that count, so: a saved stage after the opening and after each claim; **stop at a saved stage and hand back after the fifth claim's verdict if the opening took more than two stages** — the sixth claim is then a successor's, and saying exactly where it stands is a good report

Hello. The Hadwiger–Nelson problem — how many colours the plane needs so that no two points at distance 1 share one — stands
at six or seven, and this project holds it in a form with no infinite object: seven means some disc has no measurable
six-colouring proper at almost every unit pair. Today two milestones worked out what such a colouring must do near a point
whose neighbours one unit away have regions of known colours. Everything they found is a way of reading one thing: at a
point where regions meet, each colour present can sit on a given side of the far unit circle only for some directions.
This evening the asking lane proposed to count that — over all directions, for all the points round a ring — and noticed
that the count comes out one colour short at six of what it is at seven. Whether that shortfall can be afforded is the
milestone you are opening.

## Why this job

Kooshi's word of this morning — "the standard workflow, attacking 6/7" (verbatim in `{RQ}` § Kooshi's sixth word):

{WORD}
Two milestones today sharpened instruments and moved no value: each statement reads regions somebody keeps and excludes
something around them, and the forced steps stall. The card you take is the first that asks for an inequality every
colouring with corner patterns round a ring would have to satisfy — a statement about a class, not about one held object.
It may not exist. The asking lane's own odds for it are low, and it has said what happens if this round ends at a list:
it poses no further card on local configurations. So the round has a real stake in both directions, and the most useful
thing you can bring back is the truth about the count, whichever way it falls. Do not lean toward seven: a labelled ring
that fits is a result, and so is "the count does not decide".

The rules that will judge what you report, written before you start (read the inventory's head whole, `{INV7}`):

{RULES}
## The claims

**The card**, in the asking lane's stub — `{ST}` § The question (Poros, 2026-10-07); read the section whole, and the
stub around it: the card, both forms, what each answer gives, the six first claims with their controls and **what was
run for each (mostly nothing: it says so)**, the registered numbers, its position on the record job's remark, its stop:

{CARD}
**The count's definition, and the six claims, as fixed in the claim list** `{CL7}` (read it whole — each claim is the
card's numbered item copied by script):

{DEFS}
{CLAIMS}
**What they stand on**: the theorem record of the milestone derived this evening, `{DER6}` — its §§ 1–2 (the table; the
forward step; the two lemmas on corners; the closure; the collar) and § 4 (the stops by corners) with their *not
claimed* lines; and the exact engine its second deriver wrote for corners bounded by rays and circular arcs,
`data/fs136/e2/closure.py`, with its outputs under `data/fs136/e2/out/` (copy what you use). The asking lane's record,
`{PO}`, for its evidence and what it expected before it posed. **How that milestone came out, as I logged it** (read each
item whole; item 19 is the kernel planner's four generalizations, found blind — every claim here is to be stated at
those wider forms; item 20 is the card's arrival with four findings, one of them a correction already filed):

{ITEMS}
**Prior art inside this project, to read at its source before any claim is called new.** The asking lane names these
and read some at a statement only: the entry on the ring of a five-colour vertex, `plans/FS116-derivation.md`
(FS116-N2-FIVERING, about its lines 655–658 — **both clauses, and its argument**: the third claim is its second clause
in measure); the entry on the ring of a six-colour vertex beside it (FS116-N2-SIXRING: the fourth claim's map form);
`plans/FS124-derivation.md`'s entries on a pair of sector points (C124-BOTH's second sentence: the second claim restates
it by another route) and `plans/FS112-derivation.md`'s corollary it came from; and route T's count,
`plans/STUB-route-t-count.md` if it exists under that name — find the stub the card calls FS-117 — which counted tiles
where the first claim counts directions. Search the derivation files by file for a sum of angles, a mean number of
labels, or a half-plane count under other words before you write a *restates* line.

## Done means

1. **Your readback first**: the quotations against their sources; the stub whole; the theorem record's sections named;
   the two lanes' records. Open your record. Commit and push.
2. **The opening**, in the plan: the re-walk of the grokkings from inside this question, with *bears* lines and a silent
   list (the newest entry, on forced steps, and the entry on the count of labels left for a ring, are the two this
   question lives next to); the prior-art gate, in this project by file and in print in the words of two disciplines
   (the count is an angle-sum of the kind used for tilings and for discharging; say what you searched); the invariant
   question — what does every colouring with corners at a point and round its ring carry, whatever the corners; the
   routes, the stages, the failure clauses, your registered predictions. **Send me each claim's statement as your
   verdict will be about it, with its *not claimed* line** — each says in its headline that it is about colourings that
   have the named corners, and that no weak six-colouring is known to have one. A saved stage.
3. **Claims one to five, in order**, each derived, refuted or stalled at a named step, with the control the card names
   **run** — exactly where an exact engine exists, on objects with no margin, the tight seven-colouring among them —
   and your own plant. For the first: the engine's scan of a unit circle, summed, against the hand angles the card
   gives. A saved stage and a verdict to me after each.
4. **The sixth claim, the ring.** Say first what an inequality would have to be: over which points, which cells, which
   sums; what the tight seven-colouring's labelling gives for it at seven; what each held six-coloured object gives at
   the points it holds. Then derive one, or show by an assignment of corners that none of the kind you tried holds —
   **a labelled ring that fits at first order is a result, and so is a proof that the budget alone does not decide**.
   Forced steps and exact arithmetic are yours; a choice among assignments is a search request.
5. **For every claim**: what is new beyond the held entry it restates; the class it holds on; whether it reads kept
   corners, forces a region or excludes; a handoff line for the kernel lane. **A count must not fire on the tight
   seven-colouring or on any point a held object holds** — check it there before you report it anywhere else.
6. **Your record** in stages headed "Stage n — SAVED", with "Theorems this phase proved", the predictions scored against
   the card's registered numbers and your own, the sweeps, and where a successor takes over; its gate
   (`.claude/skills/ephodos/scripts/derive_gate.py all`, run from `plans/`) green; the report in standing rule 11's
   form.

## What is yours to decide

The statements' exact forms, the plan, the routes, the scripts, what "the ring" should mean when it is made precise.
Attack the card as hard as you would a claim: its first claim's equality case and its "one label fewer on every side of
every ring" are one mind's hand computation with nothing run; its second claim says it restates a held statement by
another route — if it is the held statement and no more, say so. And attack my framing above: I call the count "the first
statement about a class" — if it reads only vertex figures somebody keeps, like everything before it, that is what it
is. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only
review work it knows exists).
'''
open(ROOT+"data/fs137/briefs/FS137-E1-opening.md","w").write(b)
print("written FS137-E1",len(b))
