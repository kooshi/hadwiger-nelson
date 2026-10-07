exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS136-P1: the asking lane after FS-136's first round — ten entries, every held stop closed in measure by its own pair's tiles, the
# card's third branch with its unit corrected; the next card and its home. Run after FS-136 inventory item 6.
import os
RQ="data/external/EXT-OAI1-request.md"; INV6="plans/FS136-close-inventory.md"; CL6="data/fs136/claims.md"
STQ="plans/STUB-covering-pairs.md"; E1R="plans/FS136-E1-derivation.md"; PL="plans/FS136-the-point-across.md"; REP="data/fs136/reports/FS136-E1.md"
SQ="plans/SEARCH-QUEUE.md"; FS="plans/FRONTIER-STUBS.md"
os.makedirs(ROOT+"data/fs136/p1",exist_ok=True)
def inv(n,c):
    l=line(INV6,f"{n}. **",c); return "> "+l+"\n> — source: "+INV6+" § Items\n"
def RQL(prefix,contains=None):
    l=line(REP,prefix,contains); return "> "+l.strip()+"\n> — source: "+REP+"\n"
WORD=Q(RQ,"> I agree with all 3.")
ITEMS="\n".join([inv(3,"FS136-E1, first message"),inv(4,"FS136-E1, verdicts through its Stage 3"),inv(5,"FS136-E1, the last two claims"),inv(6,"FS136-E1 done")])
CARD=Q(STQ,"question: is-the-point-across-forced-empty")
LEFT="\n".join([Q(E1R,"1. **The question the table leaves.**","§ 6.4"),Q(E1R,"2. **The structural form's second half**","§ 6.4")])
REPQ="\n".join([RQL("  question for another lane — the asking lane:"),RQL("  stub to mint or re-aim —"),RQL("  generalization — the count is not special to six"),
                RQL("  generalization — \"four or more labels at p\""),RQL("  statement defect — the stub's control"),RQL("  search request —")])
QUEUE="\n".join([Q(SQ,"| 15 |"),Q(SQ,"| 16 |")])
ROWS="\n".join([Q(FS,"| 1 | **FS-136 the point across"),Q(FS,"| 3 | **FS-127 lateral extent**")])
b=f'''# Brief FS136-P1 — after the first round: every held stop is closed by its own pair's regions, and what closes it is a region's extent; pose what comes next, and say where it lives

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS136-P1
  identity: Poros — your agent file (`.claude/agents/poros.md`) is your identity and your lane's workflow (a re-posing job on a question whose first answer is in); invoke `poros-anomaly-hunt` fresh with the Skill tool for the re-read, and `poros-reframing` — the deriver has shown that the unit the card was posed on is an index, and that nothing in its results reads it
  role: the ask lane after the first round of the milestone on the point across — read ten derived entries against the card that asked for them and against the map entries they restate, say what the round settled and what it did not touch, and pose the next card: its unit, its forms, its first claims, and which milestone it belongs to
  launch: now, on `main`, into the slot the deriver freed; an implementer of the kernel lane works on a branch and a landing is in flight on `main` — neither writes a file you write
  mission: § Why this job
  statements: § What the first round found
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind
  channel: message the coordinator ("main") by SendMessage **as soon as the next card is saved** (a deriver's slot waits on it); at once if your re-read finds two entries that cannot both hold, or one stated more widely than its entry; and for a question you cannot work around; the report goes to `data/fs136/reports/FS136-P1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/POROS-2026-10-07-fs136-round1.md`
  touches: `plans/POROS-2026-10-07-fs136-round1.md`; `plans/STUB-covering-pairs.md` (a new dated question section under the one that stands; dated corrections to the two lines named below; its "Provisional bearings": the deriver's draft replacement, filed by you as a dated block, the original left standing); `plans/STUB-*.md` question sections of any other stub you re-pose, and any stub you mint; `data/fs136/p1/`, `data/fs136/reports/FS136-P1.md`; **not** `CLAUDE.md`, `LEDGER.md`, `{FS}` (a change of rank is a draft in your record: I file it), the claim lists, the inventories, `{SQ}` (a re-posed or declined request is a draft line in your record), any deriver's record, any Lean file, the outside clone at `/home/kooshi/source/math`
  budget: about 300k by the harness's count, as guidance (your launch preloads the grokkings, about 150k); hand back at a saved stage before about 450k — read your token count at every saved stage

Hello. This afternoon the asking lane named a successor to the milestone on unit arcs: every six-coloured object this project
holds stops at one kind of point — the second point one unit from two meeting points whose colours together are all six —
and the card asked whether such a point is forced empty. A deriver took the card's five claims and brought all five to
verdicts in one sitting, ten entries, each derived by hand by one mind. Every held stop is now closed for measurable
colourings, by the regions at its two meeting points alone. And the deriver says three things about the card that change
what the next question is: the object the card was posed on is read by nothing; the count the card rests on is not special
to six; and what empties a stop is how far a region reaches, which nothing in this class bounds. The next card is yours.

## Why this job

Kooshi's word of this morning — "the standard workflow, attacking 6/7" (verbatim in `{RQ}` § Kooshi's sixth word):

{WORD}
The round did what was asked and no value moved. Each of its exclusions is about colourings that keep named regions of one
held object; none is a statement about every colouring of a disc, and by the disc criterion (ledger row 161) that is the
only kind of exclusion that reaches seven. So a second round is worth a deriver's slot only if its card says how a
statement about regions somebody hands us becomes a statement about regions every colouring must have — or says that it
cannot, and that the better-posed half is now a construction. The deriver's closing sentence to me: "an exclusion for every
colouring would need what no table gives — that some piece at a member reaches across the point's circle." Rank by bearing
on the answer, and do not lean toward seven: a ring every one of whose points across is coloured is a result.

One more reason, about this lane's own cards, said plainly because it has cost three rounds today: **the cards' "restates"
lines missed held prior art three times** (the third was FS-110's covering pair, held for maps under the same name:
inventory item 3 below, ruling (b)), and one control of this card was false as reasoned and was only caught by running it.
Before you write that no held entry covers a statement, search the derivation files by file — `plans/FS107-derivation.md`,
`plans/FS110-derivation.md`, `plans/FS112-derivation.md`, `plans/FS114-derivation.md`, `plans/FS116-derivation.md`,
`plans/FS124-derivation.md` — and before you register a control, say what was run. This is the grokkings' newest entry's
*Do*, filed this afternoon from your own finding.

## What the first round found

**As the coordinator logged it** (read each item whole in `{INV6}`, with the rules that judge the milestone above them; each
says what I re-ran and what nobody has checked):

{ITEMS}
**The card it answered** (`{STQ}` § The question (Poros, 2026-10-07) — read the section whole, with its three branches, its
first claims, its registered expectations and its failure clauses):

{CARD}
**The deriver's record**, `{E1R}` — read it whole: ten entries in your lane's reading form, each with what is new beyond the
held entry it restates; § 2.2, the table of the reading with its five numbered findings; § 3.0, where it answers a relay
from the kernel lane (the head statement was reached blind the same afternoon by the kernel planner of the other milestone,
on the same route); Stage 5's two arguments; § 6.2, its sweeps; § 6.3, the corrections it lists for you. What it says is
left (first lines; read § 6.4 whole):

{LEFT}
Its plan, `{PL}` (§PA item 1: the prior art the card missed; §IQ; its registered predictions, each scored in the record),
and from its report, `{REP}`:

{REPQ}
**The claim list** is `{CL6}`: every statement as its verdict is about it, with the dated lines. **The reading's files** —
every table of every held ring, for whoever looks — are under `data/fs136/e1/out/`, with the reader and the exact checker
beside them. **The two held search requests** this job rules on:

{QUEUE}
**The ranking as filed**, the rows this may move:

{ROWS}
## Done means

1. **Your readback and the re-read.** Check the quotations; read the record, the plan's §PA and §IQ and the report whole.
   The anomaly hunt over the ten entries against the card, against FS-124's entries they stand on
   (`plans/FS124-derivation.md` §§ 2–4) and against the map entries each names as restated: the two kinds of stop (neither
   member separates; a member separates and a cell is still empty) — what, exactly, differs between the objects of the two
   kinds; the two-label points paid for by one four-label member — where they sit on each object and what they do to the
   card's count; the seven-colouring's 54 covering pairs with full tables — what its regions have that the six-coloured
   objects' regions lack at a point across. Reframe on the unit: the deriver proposes "a point with the members on its
   unit circle", the centre an index. Register your expectations before you pose. Commit and push.
2. **What the round settled, in a short table**: each of the ten entries as an instrument (what a later statement may cite
   it for), an exclusion on a named family, or a reading — and for each, in the deriver's own words, what is new beyond the
   held entry it restates.
3. **The next card**, with its home said first: a second round of this milestone, or the question section of another stub
   (the lateral-extent stub is ranked third and asks an existence question of this shape for all colourings), or a stub
   you mint. The question at the unit you choose, its **existence form** and **structural form**, **what each answer
   gives** toward six and toward seven, and **the first claims a deriver takes** — each a statement with its smallest
   form, its control on an object with no margin (say which, what was run, and that the tight seven-colouring survives it
   where it must), and the side it would move. Say for each claim whether it reads regions somebody keeps, or forces a
   region on every colouring — the round's ten are all of the first kind. Take a position on the deriver's question
   (which pieces at the members must reach across the far circle) and on its second (a relation between the tables of one
   ring): pose each as a claim, or say why not. **Message me when the card is saved.**
4. **The stub**: dated corrections to the two lines the deriver names (the control at seven — a dated correction of mine
   already stands under it: check it says what you would; the "restates" line that missed FS-110); the deriver's draft
   replacement for the provisional bearings (its record, Stage 0) as a dated block, corrected by you where its later
   stages overtook it.
5. **The two search requests, re-posed or declined**, each as a draft line for the queue with what its yes and its no
   would give — the screen line 15 was held for is now a derived statement. **And one paragraph for the kernel lane**: the
   head statement, the label form of the count and the one-point form are three short statements over a leaf the other
   milestone's module already holds — say whether this milestone's module should state more than those three, and whether
   any of the five exclusions has a consumer.
6. **The ranking**: if a rank moves, the rows in full as a draft, the top three as `CLAUDE.md` § Paths forward should carry
   them, and any banner drafted for me to file. If nothing moves, one sentence saying so.
7. **Three lines for Kooshi**: what the round found, in words a reader with no context can hold; what the next card asks
   and where six and seven differ in it; what you expect, with a number.
8. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed; your gate
   (`.claude/skills/poros/scripts/poros_gate.py all` on the card) green; the report in standing rule 11's form. **Stopping
   at a saved stage with the card sent is a good report.**

## What is yours to decide

The unit, the card, its home, the first claims and their order, and what to stop. Attack the deriver's reading as hard as
the card it corrects: "what bars is a region's extent, not its germ" is one mind's reading of four objects, and the flower
is its own counterexample at a tangency — if germs with a named geometric condition suffice more widely, that is a
statement about every colouring with such germs, which is a different and better thing. And attack my framing: I told
Kooshi this round "points back to the existence question he parked this morning, in a sharper form" — if it does not, or
if the sharper form is not an existence question at all (a relation between the tables of one ring is a structural one),
say so. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only
review work it knows exists).
'''
open(ROOT+"data/fs136/briefs/FS136-P1-round-one.md","w").write(b)
print("written FS136-P1",len(b))
