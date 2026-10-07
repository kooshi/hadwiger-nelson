exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS132-P3: the asking lane after FS-132's second round (the ring card, the witness card) and the day's search — the bridge
# between a cyclic centre and the witnesses on its unit circle, posed as the third round's card. Run AFTER the search has a
# saved result (plans/SEARCH-2026-10-07.md exists with a saved stage): its result is quoted by address.
import os
RQ="data/external/EXT-OAI1-request.md"; ST="plans/STUB-six-by-the-nerve.md"
E4="plans/FS132-E4-derivation.md"; E5="plans/FS132-E5-derivation.md"; PO="plans/POROS-2026-10-07-fs132-night.md"
INV2="plans/FS132-close-inventory.md"; CL="data/fs132/claims.md"; SR="plans/SEARCH-2026-10-07.md"
assert os.path.exists(ROOT+SR),"launch after the day's search has a saved stage"
os.makedirs(ROOT+"data/fs132/p3",exist_ok=True)
def inv(n,c):
    l=line(INV2,f"{n}. **",c); return "> "+l+"\n> — source: "+INV2+" § Items\n"
ITEMS="\n".join(inv(n,c) for n,c in ((15,"FS132-E4, first verdict"),(16,"FS132-E4, verdicts 2 and 3"),(18,"FS132-E5, two verdicts"),(19,"FS132-E5 handed back")))+"\n"
STALL4=Q(E4,"### Where C132-TURN stalls","Stage 3")
NEED4=Q(E4,"### What a colouring by formula would need (not built)","Stage 3")
SUPER=Q(E5,"derivation: C132-WIT-SUPER")
MARG=Q(E5,"derivation: C132-WIT-MARGIN")
ROAD=Q(PO,"### 2.1 The road to seven, and the road to six, in the vocabulary of measurable colourings","Stage 2")
FORM=Q(PO,"### What to formalize, ranked for Kooshi","Stage 3")
KW=Q(RQ,"> […] I'll hand the reins over to you […].")
b=f'''# Brief FS132-P3 — after the second round: both cards stalled at one place from two sides; pose the bridge

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), in the session Kooshi handed over. Launch line: "Your brief is on disk: read it in full first."*

brief: FS132-P3
  identity: Poros — your agent file (`.claude/agents/poros.md`) is your identity and your lane's workflow (a re-posing job on two stalls, and the next question); invoke `poros-anomaly-hunt` fresh with the Skill tool for the re-read, and `poros-reframing` — a deriver has shown that the object your last card was posed about is not the object the results are about
  role: the ask lane after the milestone's second round — read two derivers' results and one search against each other, say where the existence side of six against seven now stands, and pose the third round's card: the bridge between a point where colour classes meet and the data on its unit circle that every exclusion reads
  launch: now, into a free slot; a planner of the kernel lane is working blind on the first night's exclusion — you do not message it, and your commit subjects say what you did, not what was found
  mission: § Why this job
  statements: § What the second round found
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **as soon as the next card is saved** (a deriver's slot waits on it); at once if your re-read finds two results that cannot both hold, or one stated more widely than its entry; and for a question you cannot work around; the report goes to `data/fs132/reports/FS132-P3.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/POROS-2026-10-07-fs132-round2.md`
  touches: `plans/POROS-2026-10-07-fs132-round2.md`, `plans/STUB-*.md` (question sections, and any stub you mint — never a banner, never another lane's bearing lines), `data/fs132/p3/`, `data/fs132/reports/FS132-P3.md`; **not** `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md` (a re-rank is a draft in your record: I file it), the claim list (`{CL}` is the coordinator's), any deriver's or the Searcher's record, the outside clone at `/home/kooshi/source/math` (read it; write nothing into it)
  budget: about 300k by the harness's count, as guidance (your launch preloads the grokkings, about 150k); hand back at a saved stage before about 450k — read your token count at every saved stage. **The week's budget is tight: one card, well posed, is worth more than a full re-rank**

Hello. Four hours ago you re-posed the existence side of six against seven as two cards. Both have been worked, by two derivers,
and both were answered off their branch tables — again — and this time for one reason, which the second deriver put in a
sentence: the data every exclusion reads is a property of the *unit circle about a point*, and a meeting of colour classes is a
property of *every small ball about the point*, and no finite set of points records the second. The ring card derived what it
could and stalled at one edge; the witness card derived what it could and stalled at one selection step; a search has been run
on the one configuration no argument reached. The next question sits between those three results, and it is yours to cut.

## Why this job

Kooshi's instruction for the night:

{KW}
Two rounds have each moved the road and each ended one step short of the hinge — must a point where more than three classes
meet exist. A third round is worth its cost only if its card is about the right object. Say what that object is. And say
plainly, if it is what you find, that the existence side is not converging and the better-posed half is now the other one —
a six-coloured structure to build outward — or the centres' hypothesis. Rank by bearing on the answer.

## What the second round found

**As the coordinator logged it** (`{INV2}` — read items 13 to 19 whole; each says what was derived, at what grade, and what I
checked by hand and what nobody has):

{ITEMS}
**The claim list** is `{CL}`: read every dated line — it is the exact state of what is posed, derived, stalled and withdrawn.

**The ring card's stall and what a colouring would need** (`{E4}`, Stages 2–3; its report `data/fs132/reports/FS132-E4.md`
lists where a successor takes over and its smallest open form — one edge, not a cycle):

{STALL4}
{NEED4}
**The witness card's two statements that change the frame** (`{E5}`, Stages 2–4, read whole — § The stall holds its smallest
open form (O); its report `data/fs132/reports/FS132-E5.md` holds two questions addressed to you):

{MARG}
{SUPER}
**The day's search**, on the turning ring — the one way to spend a ring that neither round excluded: its record is `{SR}`
(read it whole: what family was enumerated, the result, and what the result is and is not a result about). In short, at its own grades: with three-way ring points the turning ring does not exist in its family — four certified refutations, which I re-verified, and beside them a five-step hand argument of the Searcher's own (its § 1.5; one mind, unchecked) whose last step reads only half-planes at the centre; where the turning ring does exist there, alternate ring points carry four labels, in a shape this project already holds. Its report asks the derivers' lane whether that argument's first four steps hold for germs that are only measurable: if they do, the ring card's stalled claim may be derivable without the flagged clause — a candidate for your card.

**Your own table of the road, and of what to formalize, from four hours ago** — to be corrected, not redone:

{ROAD}
{FORM}
## Done means

1. **Your readback and the re-read.** Check the quotations; read the two records' stages, the two reports and the search's
   record. The anomaly hunt over them and the first round: what do the ring card's one edge, the witness card's selection
   step and the extraction's flagged clause (each edge of the returned cycle is an edge of the centre's own transition graph —
   one mind, contradicting a sentence of the manuscript, and now load-bearing) say *together*? Reframe on the object axis:
   your cards were posed about "a centre with a witnessed cycle"; the derivers found two objects there. Register your
   expectation before you pose. Commit and push.
2. **The road's table, corrected** — only the rows that moved: the complementary pair; the alternating and the turning ring;
   the witnesses; the centres' hypothesis; what the search decided. One paragraph on whether the existence side is
   converging, and what the evidence for your answer is.
3. **The third round's card** — in the stub, with both forms, what each answer gives, and the first claim a deriver takes,
   stated so that it cannot be met by a margin or answered off its branch table a third time. Candidates on the table, none
   chosen for you: the bridge itself (does a point whose every small ball holds a cycle of adjacent classes carry witnesses of
   that cycle on its unit circle — the extraction's selection step with no isolated centre, the witness card's form (O), the
   ring card's one edge); a second reading of the flagged clause; the turning ring by formula, if the search left it alive;
   colourings with no margin (do this project's tight seven-colourings have a disc with none); the honest class, re-posed or
   dropped. **Message me when the card is saved.** One card. A second only if it shares no claim with the first and you
   would put it in the next slot yourself.
4. **Three lines for the morning**, for Kooshi: where six against seven stands after two rounds, in words a reader with no
   context can hold; the one thing you would do next with one deriver; and what you would stop doing.
5. **Corrections to your formalization table**, as lines: what the second round adds (a covering count with no properness
   and its corollary; the one-side statement the strips rest on) and whether anything moves above the first night's exclusion.
6. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed; your gate on the card green; the
   report in standing rule 11's form. Stopping at a saved stage with the card sent is a good report.

## What is yours to decide

The object, the card, and what to stop. Attack my framing: I logged that "both cards stalled at one place from two sides"
(item 18's ruling (d)) — if they did not, say where each stalled and why the two only look alike. You start no agents of your
own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
'''
open(ROOT+"data/fs132/briefs/FS132-P3-round-two.md","w").write(b)
print("written FS132-P3",len(b))
