exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS136-P2: the asking lane at FS-136's Derived — the re-rank of the frontier, the next milestone chosen, its question card.
# Run after FS-136 inventory item 17 (the filing that made FS-136 Derived).
import os
RQ="data/external/EXT-OAI1-request.md"; INV6="plans/FS136-close-inventory.md"; DER="plans/FS136-derivation.md"
ST7="plans/STUB-collars.md"; FS="plans/FRONTIER-STUBS.md"; ZR="data/fs136/reports/FS136-Z1.md"; STQ="plans/STUB-covering-pairs.md"
os.makedirs(ROOT+"data/fs136/p2",exist_ok=True)
def inv(n,c):
    l=line(INV6,f"{n}. **",c); return "> "+l+"\n> — source: "+INV6+" § Items\n"
WORD=Q(RQ,"> I agree with all 3.")
ITEMS="\n".join(inv(n,c) for n,c in ((10,"FS136-E2, first message"),(11,"FS136-E2, verdicts"),(12,"FS136-E2, the clause I kept fires"),(14,"FS136-E2 done"),(17,"FS136-Z1 done")))
ROWS="\n".join([Q(FS,"| 1 | **FS-136 the point across: what a seed forces**"),Q(FS,"| 2 | **FS-135 the seed remainder**"),Q(FS,"| 3 | **FS-127 lateral extent**"),Q(FS,"**Unranked, minted 2026-10-07 (FS136-Z1): FS-137, collars**")])
ZQ="\n".join([Q(ZR,"INVENTORY: question for another lane — the asking lane:"),Q(ZR,"INVENTORY: question for another lane — the next deriver on collars:")])
b=f'''# Brief FS136-P2 — a milestone is derived: re-rank the frontier, choose the next milestone, and pose its question

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS136-P2
  identity: Poros — your agent file (`.claude/agents/poros.md`) is your identity and your lane's workflow (job 1: the re-rank, the next milestone's question card); invoke `poros-anomaly-hunt` fresh with the Skill tool for the re-read, and `poros-reframing` — the milestone just derived changed its unit twice in one afternoon, and its one result with extent was found on seeds no card had named
  role: the ask lane as a milestone reaches Derived — re-read its record against what was held before, re-rank the frontier on it, choose the next milestone, and pose that milestone's question with its existence and structural forms, what each answer gives, and the first claims a deriver takes
  launch: now, on `main`; a landing of the kernel lane is in flight on `main` and a planner works blind on a branch — neither writes a file you write; the coordinator files nothing on the front page until the landing is back, so your re-rank is a draft
  mission: § Why this job
  statements: § What is derived, and what is asked of you
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you; a planner of the kernel lane is working blind from seven statements of the milestone just derived and is shown recent commit subjects, so your commit subjects say what you did, never how a statement is argued
  channel: message the coordinator ("main") by SendMessage **as soon as the question card is saved** (the next milestone's opening job waits on it); at once if your re-read finds two entries that cannot both hold, or one stated more widely than its entry; and for a question you cannot work around; the report goes to `data/fs136/reports/FS136-P2.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/POROS-2026-10-07-fs136-derived.md`
  touches: `plans/POROS-2026-10-07-fs136-derived.md`; `plans/STUB-*.md` (question sections, and any stub you mint — never a banner, never another lane's bearing lines: the dated lines a record job wrote today stand as written); `data/fs136/p2/`, `data/fs136/reports/FS136-P2.md`; **not** `CLAUDE.md`, `LEDGER.md`, `{FS}` (your re-rank is a draft in your record: I file it), the claim lists, the inventories, `plans/SEARCH-QUEUE.md`, any deriver's or record job's record, any Lean file, the outside clone at `/home/kooshi/source/math`
  budget: about 350k by the harness's count, as guidance (your launch preloads the grokkings, about 150k); hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. The milestone the asking lane named this afternoon — two meeting points of a measurable six-colouring whose colours
together are all six, and the points one unit from both — is derived: twenty-one statements, one mind each, filed an hour
ago. It closed every stopping point of every six-coloured object this project holds; it ran its own lemma forward and found
that what is forced is corners at isolated points, with every chain stalling within two steps; and, on seeds no card had
named, it found the one thing in two milestones that forces a region of definite extent: a point carrying five of six
colours forces the sixth along arcs of its unit circle. A stub for that was minted an hour ago with its question section
left empty. The ranking has not been touched. Both are yours.

## Why this job

Kooshi's word of this morning — "the standard workflow, attacking 6/7" (verbatim in `{RQ}` § Kooshi's sixth word):

{WORD}
Two milestones today have each sharpened instruments and moved no value. Every one of their statements begins "if the
colouring has these regions", and nothing gives a colouring a region; the existence step was parked this morning after
stalling three times. So the choice of what comes next is not obvious, and it is the most consequential decision of the
day: three agents work on whatever you pose. Say what the next milestone should be and why — the collar, the existence
step in whatever form today's results give it, the case list the last two milestones left open, a construction — ranked by
bearing on the answer, with a number, and do not lean toward seven: a construction is a result.

And one thing about this lane's own cards, said plainly because the record job counted it: of this milestone's first card,
the unit was read by nothing; a control at seven was false as reasoned; a third seed named no object; the third branch
asked a closure for a fragment it cannot give. Each was caught by the deriver who took it. The cheapest fix is the one the
newest grokking's *Do* names: before a card says "forced", count the labels at each point of its seed; before it names a
control, say what was run; before it says no held entry covers a statement, search the derivation files by file.

## What is derived, and what is asked of you

**The theorem record**, `{DER}` — read it whole: twenty-one entries in seven chains, each with its class, its *not
claimed* line and what is new beyond the held entry it restates; its § 7 says what the file does not hold.

**How the two rounds came out, as I logged them** (read each item whole in `{INV6}`; items 10 and 12 are where my own
framing was corrected, and item 17 is the filing):

{ITEMS}
**The new stub**, `{ST7}` — read it whole: the entry it starts from, what is held on objects, the second deriver's
smallest open form, the map entry it restates, the controls, and one remark of the record job's that no control has
checked. **Its question section is empty, for you.** **The milestone's own stub**, `{STQ}`, with its two cards, the dated
corrections under them, and the record job's dated block on what it delivered.

**What the record job asks of you** (from its report, `{ZR}`):

{ZQ}
**The ranking as filed**, the rows nearest the question (read the whole table, and its closed list):

{ROWS}
**The search queue**, `plans/SEARCH-QUEUE.md`: lines 15 and 17 to 20 are open for tomorrow's search (a labelled skeleton
with the corner table as its screen; the free corners the forced closures left), line 16 held on 15 — say whether today's
entries change what tomorrow's search should run first.

## Done means

1. **Your readback and the re-read.** Check the quotations; read the theorem record and the new stub whole. Then the
   anomaly hunt, fresh, over three things read against each other: the collar (what it forces, from what, and why the
   seven-colouring's six-label points never do it); the forced closures' stalls (what a stall is made of — a forced corner
   carries one label); and the existence stubs parked this morning (lateral extent; the seed remainder). Is there a
   statement about every colouring anywhere in reach of these — and if a five-label point is the only source of extent,
   what does a six-colouring with no five-label point look like, and is that the object the ranking should be asking
   about? Register your expectations before you pose. Commit and push.
2. **The re-rank**, as a full draft of the ranked table's rows that move or whose question or bearing changes, each
   written in full: where the milestone just derived goes (it is Derived; its kernel planner is at work); where the
   collar's stub ranks; where the eight cases of the milestone before now live (they "passed to its successor", which
   did not take them one by one); the top three as `CLAUDE.md` § Paths forward should carry them; the closed list's
   changes; any banner drafted for me to file.
3. **The next milestone, chosen, and its question card** — in its stub, under a heading dated today: the question, its
   **existence form** and **structural form**, **what each answer gives** toward six and toward seven, and **the first
   claims a deriver takes** — each a statement with its smallest form, its control on an object with no margin (say
   which, and what was run), whether it reads regions somebody keeps or forces one, and the side it would move. Take a
   position on the record job's remark (a collar's first consequence one unit on is an exclusion). **Message me when
   the card is saved.**
4. **For the search lane and the kernel lane, one paragraph each**: what tomorrow's search should run first and what its
   yes and its no would give; and which statements of the milestone just derived, beyond the seven its planner holds,
   have a consumer in the card you pose.
5. **Three lines for Kooshi**: what the derived milestone found, in words a reader with no context can hold; what the
   next one asks and where six and seven differ in it; what you expect, with a number.
6. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed; your gate
   (`.claude/skills/poros/scripts/poros_gate.py all` on the card) green; the report in standing rule 11's form.
   **Stopping at a saved stage with the card sent is a good report** — the re-rank can be a successor's.

## What is yours to decide

The ranking, the next milestone, its question, its first claims and their order, and what to stop. Attack my framing as
hard as the stubs': I have told Kooshi that the collar is "the first time something with real extent is forced where
nobody put it" and that the forced chains "stall because one colour is too few to rule anything out one unit further on" —
if either is larger than its entry, or if the better-posed next question is not about collars at all, that is the finding
this job exists to make. You start no agents of your own (standing rule 1: delegation is one level deep, because the
coordinator can only review work it knows exists).
'''
open(ROOT+"data/fs136/briefs/FS136-P2-rerank.md","w").write(b)
print("written FS136-P2",len(b))
