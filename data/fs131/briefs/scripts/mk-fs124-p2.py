exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS124-P2: the asking lane after FS-124's first round — the card's question answered in its third branch at first order; the
# second round's card, with the centre as its unit and the count of six somewhere in it. Run after FS-124 inventory item 9.
import os
RQ="data/external/EXT-OAI1-request.md"; INV4="plans/FS124-close-inventory.md"; CL4="data/fs124/claims.md"
STQ="plans/STUB-q-ring.md"; E1R="plans/FS124-E1-derivation.md"; PL="plans/FS124-tight-pairs.md"; REP="data/fs124/reports/FS124-E1.md"
os.makedirs(ROOT+"data/fs124/p2",exist_ok=True)
def inv(n,c):
    l=line(INV4,f"{n}. **",c); return "> "+l+"\n> — source: "+INV4+" § Items\n"
WORD=Q(RQ,"> I agree with all 3.")
ITEMS="\n".join([inv(6,"FS124-E1, first message"),inv(7,"FS124-E1, verdict on the first claim"),inv(8,"FS124-E1, verdicts on the first-order rule"),inv(9,"FS124-E1 done")])
CARD=Q(STQ,"question: what-does-a-tight-unit-pair-pass-on"); EXP=Q(STQ,"C124-RADIUS (up) derived as posed 0.90;")
DATUM=Q(E1R,"At a rhombus completion `w` of a tight pair")
REPQ="\n".join([Q(REP,"- question for another lane (the asking lane) — the next card's unit:"),Q(REP,"- search request — an inhabitant of C124-SIX's hypothesis:"),
                Q(REP,"- statement defect — the card's control for C124-KIND")])
b=f'''# Brief FS124-P2 — after the first round: one boundary forces nothing past its first step; pose the second round where six is spent

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS124-P2
  identity: Poros — your agent file (`.claude/agents/poros.md`) is your identity and your lane's workflow (a re-posing job on a question whose first answer is in); invoke `poros-anomaly-hunt` fresh with the Skill tool for the re-read, and `poros-reframing` — the deriver has shown that the unit the card was posed on carries no datum, and proposed another
  role: the ask lane after the first round of the milestone on tight unit pairs — read sixteen derived entries against the card that asked for them, say what the first round settled and what it did not touch, and pose the second round's card: its unit, its forms, and first claims at least one of which spends the number six
  launch: now, on `main`, into the slot the deriver freed; two implementers of the kernel lane work on branches and write nothing you write
  mission: § Why this job
  statements: § What the first round found
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind
  channel: message the coordinator ("main") by SendMessage **as soon as the second card is saved** (a deriver's slot waits on it); at once if your re-read finds two entries that cannot both hold, or one stated more widely than its entry; and for a question you cannot work around; the report goes to `data/fs124/reports/FS124-P2.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/POROS-2026-10-07-fs124-round1.md`
  touches: `plans/POROS-2026-10-07-fs124-round1.md`; `plans/STUB-q-ring.md` (a new dated question section under the two that stand; and its "Provisional bearings": the deriver's draft replacement, filed by you as it corrected it — see § Done means); `plans/STUB-*.md` question sections of any other stub you re-pose; `data/fs124/p2/`, `data/fs124/reports/FS124-P2.md`; **not** `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md` (a change of rank is a draft in your record: I file it), the claim lists, the inventories, `plans/SEARCH-QUEUE.md` (a re-posed request is a draft line in your record), any deriver's record, any Lean file, the outside clone at `/home/kooshi/source/math`
  budget: about 300k by the harness's count, as guidance (your launch preloads the grokkings, about 150k); hand back at a saved stage before about 450k — read your token count at every saved stage

Hello. This morning the asking lane posed a milestone's question in one sentence: when near one end of a unit pair one colour
fills the inside of the unit circle about the other end and another colour the outside, what must a measurable six-colouring
carry at the two points one unit from both ends — and does that recur, or run out? A deriver took its six first claims this
afternoon and brought all six to verdicts, with ten statements of its own beside them. Every one stands as derived, by one
mind, by hand. And the card's question has its first answer, the one the card gave least chance to but one: for one such
boundary, at first order, nothing is forced past the first step — and the first step is not special to such boundaries at
all. The deriver also tested its own guess about where the recurrence sits, found it false on one held object, and said so.
What is left is the next question, and it is yours.

## Why this job

Kooshi's word of this morning — "the standard workflow, attacking 6/7" (verbatim in `{RQ}` § Kooshi's sixth word):

{WORD}
The first round was worth its cost: it produced the clause through which either answer to six against seven would be
consumed (colourings of discs), and one lemma that carries everything a single open piece of a colour forces at distance 1.
But look at what kind of statements they are. The deriver tagged its added statements as per class — true at every number of
labels, "silent alone on six against seven" — or across classes, spending the count. By its tags and by the statements' own
words: the radius clause, the one lemma and what it gives at a centre, at a completion and at the opposite point hold at
every number of colours, and a statement true at seven, where a colouring exists, cannot by itself exclude anything at six;
the calibration is a colouring at seven; and the two that do spend a count — the cones at a centre of four labels, and the
rhombus's first half, posed among six labels — are over classes nobody has found a member of.
So the milestone has, so far, sharpened its instruments and has not yet touched the difference between six and seven. A
second round is worth a deriver's slot only if its card says where that difference enters: which statement about a centre
with its tight arcs holds at six and fails at seven — the tight seven-colouring is the object that must survive it — or
which six-coloured object, built outward from such a centre, a formula or a search could reach. Rank by bearing on the
answer, and do not lean toward seven: a construction is a result.

## What the first round found

**As the coordinator logged it** (read each item whole in `{INV4}`, with the rules that judge the milestone above them; each
says what I checked and what nobody has):

{ITEMS}
**The card it answered, and the expectations registered with it** (`{STQ}` § The question (Poros, 2026-10-07) — read the
section whole):

{CARD}
{EXP}
**The deriver's record**, `{E1R}` — read it whole: sixteen entries in your lane's reading form (statement, uses only, not
claimed, verdict, grade, model), each tagged per-class or across-classes in its § 1.1, with nine controls on objects that have
no margin. Its paragraph on what a completion carries begins:

{DATUM}
Its plan, `{PL}`: the invariant question (§IQ) with its assessment of the card's candidate datum — the carrier is an arc, the
relation is a polarity between a label's cones of presence at a centre and the tight windows on the centre's ring — and the
dated line that withdraws its guess about the arcs' ends. Its report, `{REP}`, with what it leaves for you:

{REPQ}
**The claim list** is `{CL4}`: every statement, with its not-claimed line and the dated lines of its verdicts. **Held and
waiting on you**: lines 12 and 13 of `plans/SEARCH-QUEUE.md` (the label skeleton on lattice points, whose rules were to be
the centre's and the completion's; an inhabitant of the count's hypothesis). **The six-coloured objects held**, and the
deriver's loaders and tightness reader for some of them, under `data/fs124/e1/`; the controls it did not run are named in
its report.

## Done means

1. **Your readback and the re-read.** Check the quotations; read the record, the plan's §IQ and the report whole. The
   anomaly hunt over the sixteen entries against the card and against the held objects as the deriver read them: three
   objects carry their tight arcs three different ways (at a lattice point of the tight seven-colouring; at the disk's
   pentagon; at the strip's midline vertices, whose arcs end elsewhere) — what do they share at the centre, exactly, and
   what does the six-coloured one have that the seven-coloured one lacks, or the other way? Reframe on the unit: the
   deriver proposes the centre with all its tight arcs. Register your expectations before you pose. Commit and push.
2. **What the first round settled, in a short table**: each entry as an instrument (what a later statement may cite it
   for), a calibration, or a statement that may exclude nothing — and for each of the two possibly empty classes, what
   would decide whether it has a member.
3. **The second round's card**, in the stub, under a new heading dated today (the two cards above it stand): the question
   at the unit you choose, with its **existence form** and **structural form**, **what each answer gives** toward six and
   toward seven, and **the first claims a deriver takes** — each a statement with its smallest form, its control on an
   object with no margin (say which, and that the tight seven-colouring survives it where it must), and the side it would
   move. **At least one first claim must spend the count** — hold at six and fail at seven, or the reverse — and the card
   says for each claim which kind it is. Answer the deriver's question (does anything at six force a centre of kind both
   to exist one unit from an end; what the strip's ends are), or pose it as a claim. **Message me when the card is
   saved.**
4. **The two held search requests, re-posed or declined**, each as a draft line for the queue with what its yes and its
   no would give; and one paragraph for the kernel lane on which of the sixteen entries the second module should state.
5. **The stub's "Provisional bearings"**: file the deriver's draft replacement (its record § 1.2) with the one correction
   its report names, as a dated block — the original lines left standing above it.
6. **Three lines for Kooshi**: what the first round found, in words a reader with no context can hold; what the second
   round asks and why that is where six and seven differ; what you expect, with a number.
7. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed; your gate
   (`.claude/skills/poros/scripts/poros_gate.py all` on the card) green; the report in standing rule 11's form. **Stopping
   at a saved stage with the card sent is a good report.**

## What is yours to decide

The unit, the card, the first claims and their order, and what to stop. Attack the deriver's proposal as hard as the card it
replaces: "the centre with all its tight arcs" is one mind's reading of three objects — if what they share is something
else, or the next question is not local at all (the radius clause makes "one disc with no six-colouring" the whole NO side),
say so. And attack my framing above: I say the round's solid statements cannot tell six from seven and the two that spend a
count may exclude nothing — if one of them already does more, through a consequence nobody drew, that is the finding. You start no agents of your own (standing rule 1:
delegation is one level deep, because the coordinator can only review work it knows exists).
'''
open(ROOT+"data/fs124/briefs/FS124-P2-round-one.md","w").write(b)
print("written FS124-P2",len(b))
