exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS136-E1: FS-136's opening job (§G, §PA, §IQ, the plan), then its five first claims. Run after the claim list
# data/fs136/claims.md is fixed and the inventory is opened.
import os
RQ="data/external/EXT-OAI1-request.md"; INV6="plans/FS136-close-inventory.md"; CL6="data/fs136/claims.md"; INV4="plans/FS124-close-inventory.md"
ST="plans/STUB-covering-pairs.md"; DER4="plans/FS124-derivation.md"; P3="plans/POROS-2026-10-07-fs124-round2.md"
assert os.path.exists(ROOT+CL6) and os.path.exists(ROOT+INV6)
def inv4(n,c):
    l=line(INV4,f"{n}. **",c); return "> "+l+"\n> — source: "+INV4+" § Items\n"
WORD=Q(RQ,"> I agree with all 3.")
CARD=Q(ST,"question: is-the-point-across-forced-empty")
DEFS=Q(CL6,"**Definitions, stated once.**")
NAMES=["RINGS-READ","COVER","ONE","PARTNERS","STOP"]
CLAIMS="\n".join(Q(CL6,f"**C136-{n}** (") for n in NAMES)
ITEMS="\n".join([inv4(21,"FS124-E2 done"),inv4(26,"FS124-P3, its verdict"),inv4(28,"FS124-Z1 done")])
b=f'''# Brief FS136-E1 — opening the milestone on the point across: the re-grokking, the prior-art gate, the invariant question, the plan — and the first claims

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS136-E1
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; this job is its opening job (§G, §PA, §IQ, the plan) followed at once by its derivation job on the first claims, which are fixed
  role: open the successor of today's milestone — about a point where four or more colours of a six-colouring meet, two rich points on its unit circle whose colours together are all six, and the one other point one unit from both — and take its five first claims in the asking lane's order: an exact reading of every held six-coloured object at such points, then what a pair whose colours are all six forces, and whether the three places where the held objects stop can be closed by the lemma today's milestone derived
  launch: now, on `main`; a landing of another milestone is in flight on `main` and a planner of the kernel lane works blind on a branch — neither writes a file you write, and **your commit subjects say what you did, never what a statement's verdict is or how it is argued** (the planner is shown recent subjects, and four of its nine statements are entries you will be reading)
  mission: § Why this job
  statements: § The claims
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind to you
  channel: message the coordinator ("main") by SendMessage **(1) with each claim's exact statement and its *not claimed* line as soon as your plan holds them**; **(2) with each verdict as it is saved** — derived, refuted by an object, a gap at a named step, or, for the reading, what was read; **(3) at once** for anything that would fix the value of the chromatic number of the plane (it goes to Kooshi as "claimed by one mind, unchecked") — **an exclusion on a disc is such a thing, by today's disc criterion** — for a held object that breaks the card's frame, for a defect in a statement, for two results that cannot both hold, or for prior art; and for a question you cannot work around; the report goes to `data/fs136/reports/FS136-E1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` § Make the gate fail, and watch it fail, before you build any check
  record: `plans/FS136-E1-derivation.md`
  touches: `plans/FS136-E1-derivation.md`, `plans/FS136-the-point-across.md` (the milestone's plan: its §G, §PA, §IQ, the route), `data/fs136/e1/` (every script and its output — not `tools/`: a landing is in flight on `main`), `data/fs136/reports/FS136-E1.md`; **not** the claim list (`{CL6}` is the coordinator's: a statement you find wrong is a message), the stub (the asking lane's; your replacement for its provisional bearings is a draft in your record), any derivation file of another milestone (a correction owed is a draft in your record), another job's reader or loader (copy it into your folder and say so), `CLAUDE.md`, `LEDGER.md`, any Lean file, the outside clone at `/home/kooshi/source/math`
  budget: about 400k by the harness's count, as guidance (your launch preloads the grokkings, about 150k); you cannot read that count, so: a saved stage after the opening, after the reading, and after each claim; **stop at a saved stage and hand back after the third claim's verdict if the reading took more than two stages**, and in any case say exactly where a successor takes over

Hello. The Hadwiger–Nelson problem — how many colours the plane needs so that no two points at distance 1 share one — stands
at six or seven, and since this afternoon this project holds it, by hand and on a branch of its Lean library, in a form with
no infinite object: seven means some disc has no measurable six-colouring proper at almost every unit pair; six means every
disc has one. Three six-coloured objects of that kind are held, exact, and each can be grown only so far. Today's milestone
found out why each stops, and the asking lane then saw that the three stopping places are one kind of point. You are opening
the milestone about that point.

## Why this job

Kooshi's word of this morning — "the standard workflow, attacking 6/7" (verbatim in `{RQ}` § Kooshi's sixth word):

{WORD}
If the point across can never be coloured — for some pair on the ring of every point where four or more colours meet — then
no six-colouring with such a point reaches radius 2 about it: an exclusion at an explicit radius, of the kind that would
decide the map question and, with a point of that kind in every colouring, the problem. If some ring can be built with every
such point filled, it is the first six-coloured piece past anything in print. The asking lane expects neither: it expects
the answer to turn on the kind of ring, and each case to be a finite exact computation. All three are results. What this
milestone must not do is what today's two cards did: pose as new a statement this project already holds for maps. **Every
first claim names the held entry it would restate, and your verdict on each says what is new beyond that entry** — the
class, the hypothesis dropped, or nothing. The card, and how the milestone came to be posed (read each item whole in
`{INV4}`; this milestone's own inventory and rules are `{INV6}`):

{CARD}
{ITEMS}
## The claims

**The claim list** is `{CL6}` — read it whole. Its definitions and its five claims, as posed (**posed, none derived**; each
claim's controls, the held entry it would restate, and its kind are in the stub, `{ST}` § The first claims a deriver takes —
read the stub whole: its mission section says in plain words why the point across is where six colours run out):

{DEFS}
{CLAIMS}
**What it stands on.** Today's theorem record, `{DER4}` — thirty entries, each [hand] or derived from one, one mind, kernel
pending: its § 2 (the one lemma; the lemma on one piece and one side, which every claim here is expected to use), § 3 (the
forcing on pieces, whose argument the asking lane reads as reaching any two pieced points whose labels are all six — that
reading is your second claim, not an entry), § 4 (the strip's closed edge: the method your last claim is asked to repeat on
two other objects). **This project's theorems for maps, at their filed grades** — the entries the claims name are in the
derivation files of FS-112, FS-114 and FS-116 (`plans/FS112-derivation.md`, `plans/FS114-derivation.md`,
`plans/FS116-derivation.md`), with `LEDGER.md` rows 135 to 138 and 145 to 150: read each named entry whole, with its grade
and its *not claimed* line, before you derive the claim that restates it. The asking lane's record, `{P3}`: its § 1.2 sorts
ten map-class steps by what each reads; its § 1.3 is the reading of the stops (two held, two by one reader, not exact).
**The held objects and today's readers**: the second round's reader for three-label members, with its per-object outputs,
under `data/fs124/e2/` (the stub says a reader for members of three or more labels is needed: a new one in your folder); the
asking lane's under `data/fs124/p3/`.

**Arrived as this brief was written, for your information** — from the kernel lane's planner, working blind from nine of
today's statements (its own, one mind, typed in a Lean skeleton and not yet in the kernel; unchecked by me; it has not seen
the derivations): (a) the forcing on pieces holds for **any two families of pieces at the two points whose labels together
are all the labels**, at any finite number of labels — it reads the count in one sentence, "every label is the label of a
piece of `x` or of a piece of `y`", and reads neither the covering clause of a decomposition nor the distinctness of labels
at one point. That is your second claim, reached by a second mind before you start: derive it yourself, and say whether your
route is its; (b) under it, a statement for each of the four regions cut near the common unit point by the two unit circles:
almost every point on a chosen side of each has the label of a piece of one member lying on the closed corresponding side of
the point's own unit circle; (c) the lemma on one piece and one side does not use that the point is at distance 1 from the
member, and its two clauses are one: where a piece lies with respect to the point's unit circle decides where its label may
lie with respect to the member's. After its fence lifts, its skeleton is on branch `fs124-wk2`.

## Done means

1. **Your readback, and the opening**, in the milestone's plan (`plans/FS136-the-point-across.md`). Check this brief's
   quotations against their sources. **§G** — every grokking walked from inside this question (G96 to G98 were filed this
   morning and one of them failed its killing test this afternoon; a replacement and a new entry are drafted, not filed:
   `plans/FS124-Z1-record.md`, its drafts section); each *bears* line and the silent list; your replacement for the stub's
   provisional bearings as a draft in your record. **§PA** — the prior-art gate, before the derivation and again before
   your report: in this project first (the named entries, and anything in the three map milestones' files about a second
   common unit point, a "stop", or a ring's partners); then in print, in the vocabulary of the disciplines (colourings of
   the plane with forbidden distance by regions; the six-colourings in print and why each stops; contact of a region with
   unit circles). **§IQ** — the invariant question, with the structural form checked not to be the existence form reworded.
   Register a prediction per claim before you derive. Commit and push.
2. **Each claim's exact statement, with its *not claimed* line — your first message.** Every one says it does not claim
   that a weak six-colouring has a pieced point or a covering pair. Where a claim as posed can be met by a degenerate case
   (today's forcing claim was, by pieces meeting at one point), restate it and say why.
3. **The reading first**: on every held six-coloured object, exact where the object is exact, at every point of four or
   more labels — the pieced ring points, the covering pairs, the point across of each, who separates there, the labels
   present, or its distance from the centre if it lies outside. The asking lane's counts are one reader's: reproduce them
   or correct them, and say which. Each reader with a planted fault watched firing; the tight seven-colouring must return
   no covering pair. **A held object whose stop is not a point across is a message to me at once.**
4. **Then the four claims, in order, each to a verdict saved before the next starts**, in your lane's derivation form, each
   verdict with **what is new beyond the held entry it restates**. For the last — the disk's rim and the flower's far
   vertex — an exact computation of the kind that closed the strip's edge, or the named step at which the first-order
   lemma does not reach (the flower's held exclusion is "second order": whether the lemma reaches it is the claim's
   content). No search: a step a search could decide is a `search request` line in your report. **A verdict by message as
   each is saved.**
5. **If the reading and the claims point to one of the card's three branches**, say which, in one paragraph, before your
   report — the asking lane and I will want it the moment it exists.
6. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed, **every commit subject neutral**;
   your derive gate (`python3 ../.claude/skills/ephodos/scripts/derive_gate.py all FS136-E1-derivation.md`, from `plans/`)
   green; the report in standing rule 11's form. **Stopping at a saved stage with the opening and the reading done is a
   good report** — say exactly where a successor takes over.

## What is yours to decide

The route to every claim; the statements' final wording (through me, by dated lines); how the reading is made exact; the
order after the reading. Attack the card as hard as an outside claim: it is one mind's, posed this afternoon from one
reader's output — if the three stops are not one kind of point, if a held object stops somewhere else, if the claims are
all restatements and the milestone's real content is a single exact computation, say so; that is the opening's job. You
start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it
knows exists).
'''
open(ROOT+"data/fs136/briefs/FS136-E1-opening.md","w").write(b)
print("written FS136-E1",len(b))
