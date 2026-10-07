exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS124-E2: FS-124's second derive round — the save: a close complementary pair and its common unit points. Five claims fixed
# in data/fs124/claims.md by the dated line of FS-124 inventory item 12.
import os
RQ="data/external/EXT-OAI1-request.md"; INV4="plans/FS124-close-inventory.md"; CL4="data/fs124/claims.md"
STQ="plans/STUB-q-ring.md"; E1R="plans/FS124-E1-derivation.md"; PL="plans/FS124-tight-pairs.md"; PO="plans/POROS-2026-10-07-fs124-round1.md"
DER="plans/FS132-derivation.md"
os.makedirs(ROOT+"data/fs124/e2",exist_ok=True)
def inv(n,c):
    l=line(INV4,f"{n}. **",c); return "> "+l+"\n> — source: "+INV4+" § Items\n"
WORD=Q(RQ,"> I agree with all 3.")
CARD=Q(STQ,"question: what-does-a-save-cost")
EXP=Q(STQ,"C124-READ-SAVES: its statement holds on the strip and the disk read whole 0.9;")
WHY=Q(STQ,"**Why the unit changes.**")
DEFS=Q(CL4,"  **Definitions, stated once.**")
NAMES=["READ-SAVES","FORCED","ONE-MEMBER","EDGE","SECOND"]
CLAIMS="\n".join(Q(CL4,f"  **C124-{n}** (") for n in NAMES)
ITEMS="\n".join([inv(8,"FS124-E1, verdicts on the first-order rule"),inv(9,"FS124-E1 done"),inv(12,"FS124-P2, first message")])
b=f'''# Brief FS124-E2 — the second round: what it costs a six-colouring to save a close complementary pair at a common unit point

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS124-E2
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; this is a derivation job on a fixed claim list, in a milestone whose object has just changed — so its first stage walks the grokkings again from inside the new object, as your workflow's opening asks of the job that meets such a change
  role: the second derive round of the milestone on tight unit pairs — read on every held six-coloured object how a pair of three-colour points with all six colours between them, less than 2 apart, is saved at the points one unit from both; then derive, in the asking lane's order, that such a pair forces a boundary along a unit circle there, whether one member can do the saving alone, what the strip's top edge then allows, and what a pair carries from one of its two common unit points to the other
  launch: now, on `main`, into the first free slot; an implementer and a planner of the kernel lane work on branches and write nothing you write
  mission: § Why this job
  statements: § The claims
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind to you
  channel: message the coordinator ("main") by SendMessage **(1) with each claim's exact statement and its *not claimed* line as soon as your plan holds them**; **(2) with each verdict as it is saved** — derived, refuted by an object, a gap at a named step, or, for the reading, what was read; **(3) at once** for anything that would fix the value of the chromatic number of the plane (it goes to Kooshi as "claimed by one mind, unchecked"), for a held object that breaks the card's frame, for a defect in a statement, for two results that cannot both hold, or for prior art; and for a question you cannot work around; the report goes to `data/fs124/reports/FS124-E2.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` § Make the gate fail, and watch it fail, before you build any check
  record: `plans/FS124-E2-derivation.md`
  touches: `plans/FS124-E2-derivation.md`, `plans/FS124-tight-pairs.md` (the milestone's plan: dated additions only — the re-walk, this round's route and predictions — the first round's text left standing), `data/fs124/e2/` (every script and its output — not `tools/`: a landing may be in flight on `main` within the day), `data/fs124/reports/FS124-E2.md`; **not** the claim list (`{CL4}` is the coordinator's: a statement you find wrong is a message), the stub (the asking lane's), the first round's record `{E1R}` or any derivation file of another milestone (a correction owed is a draft in your record), `CLAUDE.md`, `LEDGER.md`, any Lean file, the outside clone at `/home/kooshi/source/math`
  budget: about 400k by the harness's count, as guidance (your launch preloads the grokkings, about 150k); hand back at a saved stage before about 550k — read your token count at every saved stage

Hello. This milestone was opened this morning on one object: a boundary between two colours that runs exactly along a unit
circle, centred on a point one unit away. A colleague took its six first claims this afternoon and brought every one to a
verdict — and found that one such boundary, by itself, forces almost nothing: the two colours are absent at the two points one
unit from both its ends, at any number of colours, and that is all. Then the asking lane went back to the six-coloured objects
this project holds and read them for *why* their boundaries sit where they do. It found one cause, 94 times out of 94: each
centre of such boundaries is the rescue of a pair of three-colour points that between them use all six colours and lie less
than 2 apart. A point one unit from both has no colour left — unless a boundary at one of them runs along its unit circle.
That is where the number six is spent, and it is the unit of your round.

## Why this job

Kooshi's word of this morning — "the standard workflow, attacking 6/7" (verbatim in `{RQ}` § Kooshi's sixth word):

{WORD}
The first round's statements hold at every number of colours, so by themselves they cannot tell six from seven. Four of the
five claims below are posed to hold at six and fail at seven, each with its witness named; the tight seven-colouring survives
them because it has no three-colour point at all. If the central one is derived, it is this milestone's first statement that
spends the count. And one claim asks you to *build*: a rescue by one member of the pair alone, by formula on a small
neighbourhood — or the step that forbids it. If it exists, six has a second kind of centre and the strip has a way upward; if
it does not, every rescue fixes four colours at a point, and there is a rigid incidence to count on. Either is a result;
do not lean toward seven. The card, its reason for the unit, its registered expectations, and how the round came to be posed:

{CARD}
{WHY}
{EXP}
{ITEMS}
## The claims

**The claim list** is `{CL4}` — read it whole, with its dated lines: the first round's statements and verdicts, then this
round's definitions and five claims, as posed (**posed, or read from held objects by sample — none derived**; each claim's
controls, its side and the witness of its kind are in the stub, `{STQ}` § The question (Poros, 2026-10-07, after the first
round) — read that section whole, with the two cards above it):

{DEFS}
{CLAIMS}
**What it stands on.** The first round's record, `{E1R}` — sixteen entries, each [hand] or derived from one, one mind: the one
lemma (an open set carrying a label bars it from almost every point at distance exactly 1), what a tight pair forces at its
centre, at every point one unit from its far end, and at the opposite point; the rhombus's first half and its two-set form,
which the asking lane now reads as the law of every held centre. Last night's record, `{DER}` § 4: the complementary pair's
sharp form (one of six sets lies on the unit circle about a common unit point), one mind, kernel pending, and the one-witness
side statement under it, whose argument the first round's deriver did not read. The asking lane's record, `{PO}`, with its
readers under `data/fs124/p2/` (by sample, one mind, four planted faults firing) and one remark for you, per class and
unchecked, at the end of the card's section. The plan, `{PL}`, with the first round's re-grokking, prior-art gate and
invariant question. **The held objects**: the strip and the disk (read by the asking lane), the capped strip's caps, fragment
T2, the bowtie fragment, the six-colour fragment and the search's kept model (unread for this property), and the tight
seven-colouring; the first round's loaders and its tightness reader are under `data/fs124/e1/` — its report names a reader
it had to repair near an arc's end, and the controls it did not run.

## Done means

1. **Your readback, and the re-walk.** Check this brief's quotations against their sources; read the card's section, the
   first round's record and the asking lane's record whole. Then, in the plan, a dated addition: the grokkings walked again
   from inside the new object — a close complementary pair and its saves — with what each entry that bears dictates for
   this round (G83, G84, G91 and G96 to G98 at least), this round's route, and a prediction per claim registered before you
   derive. Prior art: the pair's exclusion and its rescue by a unit arc, in the map class, are this project's rows 133 to
   136 with the papers they cite — say what is already in print for maps, and search for the measurable form. Commit and push.
2. **Each claim's exact statement, with its *not claimed* line — your first message.** Every one says that it does not claim
   a weak six-colouring has a three-piece point or a close complementary pair. Where a claim as posed can be met by a
   degenerate case, or says less than its wording, restate it and say why.
3. **The reading first** (it tells you what the other four are about): on every held six-coloured object, by formula from
   its own tiles, exact where the object is exact — the pairs, their common unit points, the pattern at each, the rhombus's
   two-set hypothesis read whole, the labels present; every tight arc of kind both, and whether it is an edge of a save.
   The asking lane's counts are by sample: reproduce them or correct them, and say which. Each reader with a planted fault
   watched firing; the tight seven-colouring must return no pair. **A held object that breaks the pattern is a message to
   me at once** — the card says what it would mean.
4. **Then the four claims, in order, each to a verdict saved before the next starts**, in your lane's derivation form: that
   a pair forces a tight arc at each common unit point (with its failure at seven exhibited by formula); the save by one
   member alone — its consequence derived, then **an object by formula with an exact check, or the named step at which none
   exists, or a gap said as a gap**; the strip's top edge; the pair's two saves and the cyclic order. No search: a step a
   search could decide is a `search request` line in your report. **A verdict by message as each is saved.**
5. **If a save by one member is built**: stop and message me before going on — say on what neighbourhood it is a weak
   six-colouring, what checked it, and what it does not show (it is a local object: it fixes no value).
6. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed; your derive gate
   (`python3 ../.claude/skills/ephodos/scripts/derive_gate.py all FS124-E2-derivation.md`, from `plans/`) green; the report
   in standing rule 11's form. **Stopping at a saved stage with the reading done and the forcing claim at a verdict is a good
   report** — say exactly where a successor takes over.

## What is yours to decide

The route to every claim; the statements' final wording (through me, by dated lines); how the reading is made exact; whether
to build or to exclude first in the third claim. Attack the card as hard as an outside claim: its counts are one mind's, by
sample, read this afternoon — if a held object has a centre that is no rescue of a pair, if "exactly one edge of each" is an
artefact of two objects built by one recipe, if the unit should be something else again, that is a finding and the round's
most valuable one. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator
can only review work it knows exists).
'''
open(ROOT+"data/fs124/briefs/FS124-E2-second-round.md","w").write(b)
print("written FS124-E2",len(b))
