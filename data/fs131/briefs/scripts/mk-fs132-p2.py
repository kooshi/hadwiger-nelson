exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS132-P2: the asking lane after FS-132's first night — the stall on the existence side re-posed, the road to seven restated in
# the measurable vocabulary, the frontier re-ranked on the night's results, and what to formalize ranked for Kooshi's.
import os
RQ="data/external/EXT-OAI1-request.md"; ST="plans/STUB-six-by-the-nerve.md"
E1="plans/FS132-E1-derivation.md"; E2="plans/FS132-E2-derivation.md"; E3="plans/FS132-E3-derivation.md"
INV2="plans/FS132-close-inventory.md"; CL="data/fs132/claims.md"; FS="plans/FRONTIER-STUBS.md"
os.makedirs(ROOT+"data/fs132/p2",exist_ok=True)
def inv(n,c):
    l=line(INV2,f"{n}. **",c); return "> "+l+"\n> — source: "+INV2+" § Items\n"
KW="\n".join([Q(RQ,"> […]"),Q(RQ,"> […] I'll hand the reins over to you […].")])+"\n"
ITEMS="\n".join(inv(n,c) for n,c in ((3,"FS132-E1, second message"),(6,"FS132-E3, first verdict"),(7,"FS132-E2, second message")))+"\n"
STALL="\n".join([Q(E2,"### Where the forcing statement stalls","Stage 3"),Q(E2,"### The stalled step, as a statement of its own","Stage 3"),
                 Q(E2,"**The smallest open forms** (for the asking lane; each about one circle at one centre):","Stage 3"),
                 Q(E2,"### The YES side's first sketch (what a six-colouring that lives on triangles alone must look like at the stall)","Stage 3")])+"\n"
EXC="\n".join([Q(E3,"derivation: C132-M-ORBIT","Stage 3"),Q(E3,"### What this bears on, not entered (for the coordinator)","Stage 3")])+"\n"
EXT="\n".join([Q(E1,"### Card 2, answered on the way (not stretched for)","Stage 3"),Q(E1,"### Footholds at six (statements about every weak measurable six-colouring; each at its grade)","Stage 3")])+"\n"
TOP="\n".join([Q(FS,"| 1 | **FS-132 six by the nerve**"),Q(FS,"| 2 | **FS-124 the (Q) ring**"),Q(FS,"| 3 | **FS-123 the Siamese class**")])+"\n"
C3=Q(ST,"question: where-does-five-enter")
b=f'''# Brief FS132-P2 — after the first night on six against seven: the stall re-posed, the road restated, the frontier and the Lean priorities re-ranked

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), in the session Kooshi handed over. Launch line: "Your brief is on disk: read it in full first."*

brief: FS132-P2
  identity: Poros — your agent file (`.claude/agents/poros.md`) is your identity and your lane's workflow (a re-posing job on a stall, and job 1: the re-rank and the next question); invoke `poros-anomaly-hunt` fresh with the Skill tool for the re-read, and `poros-reframing` if the frame has moved — one deriver says a card of yours had an empty first branch
  role: the ask lane after three derivers' results in one night — say what the road to seven now is, step by step, in the vocabulary of measurable colourings; re-pose the existence side at the place it stalled; choose the next two questions with their first claims; re-rank the frontier on what was derived; and rank what should be formalized, for Kooshi's decision in the morning
  launch: now, into the slot the second deriver freed; the third deriver is still on its second reading and an implementer is landing the outside theorems on the main branch — you touch neither
  mission: § Why this job
  statements: § What was found tonight, and what Kooshi asked
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind
  channel: message the coordinator ("main") by SendMessage **as soon as the next question's card is saved** (a deriver's slot waits on it); **at once** if your re-read finds two of tonight's results that cannot both hold, or a result stated more widely than its entry; and for a question you cannot work around; the report goes to `data/fs132/reports/FS132-P2.md`, and its text is your final message. The third deriver's later messages are relayed to you by me as they arrive
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/POROS-2026-10-07-fs132-night.md`
  touches: `plans/POROS-2026-10-07-fs132-night.md`, `plans/STUB-*.md` (question sections, and any stub you mint — never a banner, never another lane's bearing lines), `data/fs132/p2/`, `data/fs132/reports/FS132-P2.md`; **not** `CLAUDE.md`, `LEDGER.md`, `{FS}` (your re-rank is a draft in your record: I file it — and nothing outside `plans/` and `data/` is committed while the landing is in flight), the claim list (`{CL}` is the coordinator's), any deriver's record, the outside clone at `/home/kooshi/source/math` (read it; write nothing into it)
  budget: about 350k by the harness's count, as guidance (your launch preloads the grokkings, about 150k); hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. This morning you ranked one new question first: does this project's six-colour theory need a map, or only what an
outside proof's extraction hands any measurable colouring? Three derivers have worked it since, and the ground has moved again —
this time by this project's own results. The exclusion you asked about holds for arbitrary measurable six-colourings, by an
argument that reads less of the extraction than anyone expected. The existence side — must a meeting point of four or more
classes exist — is mapped step by step against the classical proof and stalls at one named place, with the first description
this project has ever had of what a six-colouring on three-way points alone would be forced to do. Kooshi has
handed over with one instruction: keep us on track to six or seven, and walk the standard workflow once the direction
is clear. The direction is yours to state.

## Why this job

Workflow 3.1 sends a stall to you, and a milestone's results to you before the next launches. Tonight both happened at once.
What is at stake in your ranking is the remaining budget of the week — two derivers and one kernel job at a time — and the
question Kooshi will be asked: what to formalize. His words:

{KW}
Rank by bearing on the answer, never by difficulty (`CLAUDE.md` § Counter-priors — read it from disk: the front page was refiled
today and says six or seven). And attack what follows as hard as you would an outside claim: every result below is one mind's,
by hand, a few hours old.

## What was found tonight, and what Kooshi asked

**The night's results, as the coordinator logged them** (`{INV2}` — read items 2 to 8 whole: each says what was derived, at
what grade, what I checked by hand and what nobody has checked):

{ITEMS}
**The claim list** is `{CL}`: read it whole, with its dated lines — it is the exact statement of everything named below.

**The existence side, at its stall** (`{E2}`, Stage 3 — read from "Where the forcing statement stalls" to "Predictions scored"
whole; the deriver's report, `data/fs132/reports/FS132-E2.md`, proposes the rewording of your card and three stubs):

{STALL}
**The exclusion side** (`{E3}`, Stage 3 — the entries, the route table, and its closing section):

{EXC}
**The extraction** (`{E1}`, Stage 3 — your card 2 is answered there at the level of the argument):

{EXT}
**Your card that was corrected**, and the ranking you made this morning (`{FS}`, as filed — read the file whole):

{C3}
{TOP}
**Still arriving**: the third deriver is on its second reading (does the map-class existence argument restate — C132-RUN-CV;
the second deriver's result says its statement stalls with C132-LONG), then two posed statements (C132-DIAG, C132-RADIUS), and
one paragraph I asked of it: whether the mechanism of its step lemma — which makes a measurable ring's state a step function
from properness alone, at a four-cycle centre — has a form at a triangle centre with three outside labels. I relay each as it
lands; re-read `{E3}` at your last stage.

## Done means

1. **Your readback and the re-read.** Check the quotations above against their sources; read the three records' Stage 3, the
   inventory's items and the claim list. Then the anomaly hunt, fresh, over the three records *against each other* and against
   this project's rows 131–150: what do two of tonight's results say together that neither says alone; where does one result
   lean on something another shows is not needed (the exclusion reads no isolation of the centre and none of the flagged
   clause; the existence chain reads both); which held row is now stated in the wrong class. Register your expectations before
   you rank. Commit and push.
2. **The road to seven, as one table**, in the vocabulary of measurable colourings: each step from "a measurable six-colouring
   proper at almost every unit pair" to a contradiction — the hypothesis on the centres; a centre that is not a triangle; each
   kind of centre's exclusion (the binary four-cycle; four-cycles with palettes that hold no outside label; five- and
   six-cycles) — with, for each: held, derived tonight (by whom, one mind), stalled at a named statement, or unposed; and the
   same for the YES side (what a six-colouring must do at each step to survive). Say which steps still need a normal form
   (this project's saturated colourings, rows 140–144) and which need a map, if any.
3. **The stall, re-posed.** For the existence side: in which class C132-RING-TAME should be posed (every weak colouring, where
   its own entry says local slack breaks it; or the saturated normal form); which of the deriver's three smallest forms is the
   next question; what, if anything, can stand where the classical proof's last two steps stand (two centres of one type; the
   bicycle), or whether the existence side should be asked another way entirely. A card in the stub, with both forms, what
   each answer gives, and the first claim a deriver takes. **Message me when it is saved.** If a second question deserves the
   other deriver's slot — the hypothesis on the centres (your card 2, answered only at the level of the argument), or the next
   exclusion — pose it the same way and say which goes first.
4. **The re-rank**, as a draft of `{FS}`'s table in your record, in full for every row that moves or whose question or bearing
   changes (this morning's draft left two cells as "as filed with clauses struck" — ranks 7 and 11: write those in full now),
   with the closed list's changes and the top three as `CLAUDE.md` § Paths forward should carry them. Debts to settle in it,
   each in a line: the rewording of card 3 its deriver proposes; the wording of the stub's existence form (the extraction
   returns a centre, not a prescribed one); the first deriver's two proposed stubs (the extraction for countable closed sets
   of centres; lateral extent re-aimed at "an essential centre is isolated"); the sibling milestone's two candidates (does a
   three-point constraint transfer; the field form of the measure-rigidity test) and the sweep's two (the periodic-colouring
   answer; a fixed-dimension form of the release's Ramsey criterion) — ranked, or declined with a reason.
5. **What to formalize, ranked for Kooshi** — one table, by bearing on the answer and by what is one mind's and unverified:
   tonight's exclusion (its step lemma and its kill have no second reader); the extraction at every number of colours (a port
   of the release's five-colour Lean); the colouring-free index lemma; the sibling milestone's density equality (Derived,
   bears none on six against seven, decays with the calendar); and the paused backlog's waves (6 the saturated class, 7 the
   four-colour vertex, 9 the reductions, 10 the arithmetic) — for each: on the road, off it, or needed only if a named step
   lands. This table is what restarts the backlog, or retires parts of it.
6. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed (`plans/` and `data/` only); your gate
   (`.claude/skills/poros/scripts/poros_gate.py all` on each card, from its skill directory's conventions) green; the report in
   standing rule 11's form. Stopping at a saved stage with the road's table and the first card sent is a good report.

## What is yours to decide

The ranking, the questions, their forms, and what comes first. Attack the frame, including mine: I called the direction "the
measurable road" on the exclusion's result, and ruled that the stall goes to you and not straight to a deriver; if tonight's
results say the road is something else — that the normal form is the road and the measurable class a detour, that the YES side
is now the better-posed half, that the existence side should be dropped for the centres' hypothesis — that is the finding
this job exists to make. Do not lean toward seven: a six-colouring by formula on triangles alone, with turning rings, is a
result. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).
'''
open(ROOT+"data/fs132/briefs/FS132-P2-night-rerank.md","w").write(b)
print("written FS132-P2",len(b))
