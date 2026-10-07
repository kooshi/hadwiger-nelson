exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS124-E1: FS-124's opening job (§G, §PA, §IQ, the plan), then the first claims in the asking lane's order. Run after the
# claim list data/fs124/claims.md is fixed (FS-124 inventory item 3).
import os
RQ="data/external/EXT-OAI1-request.md"; INV4="plans/FS124-close-inventory.md"; CL4="data/fs124/claims.md"
STQ="plans/STUB-q-ring.md"; DER="plans/FS132-derivation.md"; PO="plans/POROS-2026-10-07-fs124-question.md"
assert os.path.exists(ROOT+CL4)
os.makedirs(ROOT+"data/fs124/e1",exist_ok=True)
def inv(n,c):
    l=line(INV4,f"{n}. **",c); return "> "+l+"\n> — source: "+INV4+" § Items\n"
WORD=Q(RQ,"> I agree with all 3."); THIRD=Q(RQ,"> 3. **Whether to open the unit-arc configuration next.**")
CARD=Q(STQ,"question: what-does-a-tight-unit-pair-pass-on")
DEFS="\n".join([Q(CL4,"**The class.**"),Q(CL4,"**The object, stated once.**")])
NAMES=["RADIUS","CENTRE","COMPLETION","KIND","SIX","HALF"]
CLAIMS="\n".join(Q(CL4,f"**C124-{n}** (") for n in NAMES)
EXP=Q(STQ,"C124-RADIUS (up) derived as posed 0.90;")
CARRY=Q(STQ,"**What to carry over from the map class first, and how.**")
ITEMS="\n".join([inv(1,"Chosen by Kooshi"),inv(2,"FS124-P1, first message"),inv(3,"The claim list is fixed")])
b=f'''# Brief FS124-E1 — opening the milestone on tight unit pairs: the re-grokking, the prior-art gate, the invariant question, the plan — and the first claims

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS124-E1
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; this job is its opening job (§G, §PA, §IQ, the plan) followed at once by its derivation job on the first claims, which are fixed
  role: open the milestone Kooshi chose this morning — what a boundary between two colours that runs along a unit circle about a point one unit away forces on a measurable six-colouring of the plane — and derive its first claims in the asking lane's order: the clause that makes six-coloured fragments at every radius decide the problem, then what such a boundary forces at its centre and at the two points one unit from both its ends
  launch: now, on `main`; two implementers of the kernel lane work on branches and write nothing you write; the asking lane has handed back (its record is named below; its re-rank is being filed while you work — read `CLAUDE.md` from disk)
  mission: § Why this job
  statements: § The claims
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind
  channel: message the coordinator ("main") by SendMessage **(1) with each claim's exact statement and its *not claimed* line as soon as your plan holds them** (I fix them in the claim list by dated lines while you derive); **(2) with each verdict as it is saved** — derived, refuted by an object, or stalls at a named step; **(3) at once** for anything that would fix the value of the chromatic number of the plane (it goes to Kooshi as "claimed by one mind, unchecked"), for a defect in a statement, for two results that cannot both hold, or for prior art; and for a question you cannot work around; the report goes to `data/fs124/reports/FS124-E1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` § Make the gate fail, and watch it fail, before you build any check
  record: `plans/FS124-E1-derivation.md`
  touches: `plans/FS124-E1-derivation.md`, `plans/FS124-tight-pairs.md` (the milestone's plan: its §G, §PA, §IQ, the route), `data/fs124/e1/` (every script and its output — not `tools/`: a landing may be in flight on `main` within the day), `data/fs124/reports/FS124-E1.md`; **not** the claim list (`{CL4}` is the coordinator's: a statement you find wrong is a message), the stub (its question section is the asking lane's; your replacement for its "Provisional bearings" lines is a draft in your record), any derivation file of another milestone (a correction owed is a draft in your record), `CLAUDE.md`, `LEDGER.md`, any Lean file, the outside clone at `/home/kooshi/source/math` (read it; write nothing into it)
  budget: about 400k by the harness's count, as guidance (your launch preloads the grokkings, about 150k); hand back at a saved stage before about 550k — read your token count at every saved stage

Hello. The Hadwiger–Nelson problem is now "six or seven", and by the same outside proof the plane's chromatic number is that
of measurable colourings proper at almost every unit pair. Last night this project ran its first milestone on that ground.
Three rounds of derivation each excluded what they could and each ended at one configuration: a boundary between two colours
that runs exactly along a unit circle, centred on a point one unit away. This morning the asking lane read all of it again and
turned the picture over: that boundary is not what the exclusions left behind — it is what they *force*. So the milestone you
are opening does not ask whether such a boundary can be excluded. It asks what it passes on.

## Why this job

Kooshi chose this milestone this morning; his word, and the item it answers (verbatim in `{RQ}` § Kooshi's sixth word — "the
standard workflow, attacking 6/7"):

{WORD}
{THIRD}
Every six-coloured fragment this project holds is built from such boundaries. Last night's record says of itself that nothing
in it "excludes, builds or bounds a boundary that is a unit arc about a ring point"; the one exclusion held on a ring that
carries the centre's own labels is the outside proof's two-pair theorem read at six (the asking lane's record, § 1.1, where it
caught a wider sentence of mine). If what a tight pair forces at the two points one unit from both its ends reproduces itself, a six-colouring's
tight pairs span a labelled piece of the unit triangular lattice, and the problem becomes one question about that skeleton
at every radius — a place to build from for six, or a place where a count fails for seven. If it runs out, the distance at
which it does is an explicit radius. Either is the first statement of this kind in the class the problem lives in. The asking
lane's card, its registered expectations, and how this milestone came to be posed (read each item whole in `{INV4}`, with
the rules that will judge the milestone above them):

{CARD}
{EXP}
{ITEMS}
Do not lean toward seven, or toward six: a refutation by an exhibited object, a stall at a named step, and "this claim is
true but says less than its wording" are results, and the last night's three cards were each answered off their branch table.

## The claims

**The claim list** is `{CL4}` — read it whole. Its class, its object, and its six claims, as posed (**posed, none derived**;
each claim's expected route, its controls and its side are in the stub, `{STQ}` § The question (Poros, 2026-10-07) — read
that section whole, and the card of 2026-10-03 above it, which is the same question for maps):

{DEFS}
{CLAIMS}
**What the asking lane says to carry over from the map class, and how**:

{CARRY}
**What it stands on.** Last night's theorem record, `{DER}` — 57 entries, each [hand] or derived from [hand] entries, one
mind, kernel pending: its § 2 (the side rule for an open one-label piece, C132-SHADOW, which the asking lane expects two of
the claims to be instances of; the one-witness side rule), § 4 (the complementary pair's sharp form, whose residue the last
claim starts from), § 5 (the lens and the placed point), § 12 (which side of the line each entry sits on). This library's
own N-EASY (`Proofs/HadwigerNelson/Plane/YesLimit.lean`, `chromaticNumber_plane_le_chiM0`) and the declared outside theorem
`Outside.OAI158.proper_to_borel_weak` (`Proofs/HadwigerNelson/Outside/OAI158.lean`), which the first claim's two halves are
expected to use. The map-class theorems, at their filed grades: `LEDGER.md` rows 133 to 138 and 145 to 150, with the
derivation files they name. **The six-coloured objects held, which are your controls**: the fragments those rows name (the
capped strip, the disk, fragment T2, the bowtie fragment, the six-colour fragment), the tight seven-colouring R7, and the
one model yesterday's search kept (`plans/SEARCH-2026-10-07.md`; `data/search/2026-10-07/KEEP-turning-4label-arcs.json`);
last night's derivers left loaders and checks for several of them under `data/fs132/e2/` to `data/fs132/e6/` (one of them,
the hexagon relation in `data/fs132/e2/ring_checks.py`, compares strictly in floating point and is unreliable at circumradius
1/2: do not reuse it unrepaired). The asking lane's record is `{PO}`; its control for the fifth claim is
`tools/fs124_p1_cones.py`.

## Done means

1. **Your readback, and the opening**, in the milestone's plan (`plans/FS124-tight-pairs.md`). Check this brief's quotations
   against their sources. **§G** — every grokking walked from inside this question, G96 to G98 included (filed today; read
   the file from disk), each *bears* line and the silent list; G83, G84 and G91 are the ones the last milestone's sweep
   found it should have used earlier — say what each dictates here. Your replacement for the stub's "Provisional bearings"
   lines as a draft in your record, with one correction the asking lane found owed (inventory item 2). **§PA** — the
   prior-art gate, before the derivation and again before your report: the object in the vocabulary of its disciplines (a
   measurable partition of the plane with an interface along a unit circle about a point of the partition's own singular
   set; sets avoiding a distance and their contact structure; the first claim's "local to global" for almost-proper
   colourings of discs); **the searches last night could not make** — the reviews database returned an error at every
   attempt, and nine entries of last night's record still say "owed": run them now, for this milestone's object and for
   the triple junction of a measurable partition, and say what was searched and what was only seen in a listing. **§IQ** —
   the invariant question, with the structural form checked not to be the existence form reworded: the card names a
   candidate datum; say whether it is the one. Register a prediction per claim before you derive. Commit and push.
2. **Each claim's exact statement, with its *not claimed* line — your first message.** Where a claim as posed can be met by
   a degenerate case, is vacuous on the held objects, or says less than its wording, restate it and say why: the wording is
   where last night's cards failed.
3. **The claims, in order, each to a verdict saved before the next starts**, in your lane's derivation form (statement, uses
   only, not claimed, argument, verdict, grade, minds, model, prior art, handoff): the first claim's two halves; the
   centre's property; the completion's; the calibration at seven, by formula with an exact check of its two margins; the
   count at a four-label centre; the rhombus's first half. **Controls on the held objects, read by formula from their own
   tiles, each with a planted fault watched firing** — a claim that must hold at the capped strip's midline vertices is
   shown holding there, not assumed to. No search: a step a search could decide is a `search request` line in your report.
   **A verdict by message as each is saved.**
4. **If the first-order rule is derived** (the third claim): say, in one paragraph and before going on, what the datum at a
   completion is and whether the completion is forced to be an end of a tight pair again — the card's three branches turn
   on it, and the asking lane and I will want it the moment it exists.
5. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed; your derive gate
   (`python3 ../.claude/skills/ephodos/scripts/derive_gate.py all FS124-E1-derivation.md`, from `plans/`) green; the report
   in standing rule 11's form. **Stopping at a saved stage with the opening done and the first three claims at verdicts is a
   good report**, and a likely one: a second job takes the rest from your record. Say exactly where it takes over.

## What is yours to decide

The route to every claim; the statements' final wording (through me, by dated lines); the order after the third claim; what
the plan's route is once the first-order rule is known. Attack the card as hard as an outside claim: it is one mind's, posed
this morning — if the object is not one object, if a claim is true for a reason that makes it useless, if the datum the card
names is not the invariant, say so; that is the opening's job. You start no agents of your own (standing rule 1: delegation
is one level deep, because the coordinator can only review work it knows exists).
'''
open(ROOT+"data/fs124/briefs/FS124-E1-opening.md","w").write(b)
print("written FS124-E1",len(b))
