exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS132-Z1: the record job, part 1 — FS-132's derivation file and the errata, from six derivers' records, one search and the
# kernel planner's second reading. Part 2 (stubs, predictions, the front page's drafts) waits for Kooshi's word on scope.
import os
RQ="data/external/EXT-OAI1-request.md"; INV2="plans/FS132-close-inventory.md"; CL="data/fs132/claims.md"
os.makedirs(ROOT+"data/fs132/z1",exist_ok=True)
KW="\n".join([Q(RQ,"> […]"),Q(RQ,"> […] I'll hand the reins over to you […].")])+"\n"
def inv(n,c):
    l=line(INV2,f"{n}. **",c); return "> "+l+"\n> — source: "+INV2+" § Items\n"
ITEMS="\n".join(inv(n,c) for n,c in ((6,"FS132-E3, first verdict"),(21,"FS132-P3, first message"),(25,"FS132-K1, still blind"),(28,"FS132-E6, first verdict"),(30,"FS132-K1 done at its Stage 3")))+"\n"
RECS=", ".join(f"`plans/FS132-E{i}-derivation.md`" for i in range(1,7))
b=f'''# Brief FS132-Z1 — the record job, part 1: FS-132's derivation file, with every statement at the grade its source gives it, and the errata

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), in the session Kooshi handed over. Launch line: "Your brief is on disk: read it in full first."*

brief: FS132-Z1
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its `## The record job` is your job, split in two, and you do its first half ("The derivation file" and "Errata")
  role: part 1 of FS-132's record job — one derivation file in which every statement six derivers, one search and one kernel planner produced in one night stands as an entry, in its strongest merged form, at exactly the grade and the number of minds its source gives it; the stalls and gaps entered as stalls and gaps; and the dated corrections the night's records owe each other and earlier milestones
  launch: now; no other job is running. Part 2 (the stubs, the predictions scored, the front page's drafts) follows after Kooshi has answered a question about what this milestone delivers
  mission: § Why this job
  statements: § What Kooshi asked, and what the night found
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind any longer (the kernel planner's fence was lifted at its phase-1 commit)
  channel: message the coordinator ("main") by SendMessage only for a question you cannot work around or a finding that cannot wait — two entries that cannot both hold, a merged form that would drop a hypothesis, an entry graded above its source; the report goes to `data/fs132/reports/FS132-Z1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS132-Z1-record.md`
  touches: `plans/FS132-Z1-record.md`, `plans/FS132-derivation.md` (new), the six derivers' records {RECS} and earlier milestones' derivation files `plans/*-derivation.md` (dated entries and errata appended only, the original text left standing), `plans/FS132-six-by-the-nerve.md` (one dated correction to its dictionary), `data/fs132/z1/`, `data/fs132/reports/FS132-Z1.md`; **not** `CLAUDE.md`, `LEDGER.md`, the grokkings file, any stub, the claim list, the inventories, any Lean file (a line owed to one of those is a draft in your record, with its slot)
  budget: about 400k by the harness's count, as guidance (your launch preloads the grokkings, about 150k); hand back at a saved stage before about 550k — a successor continues from your record

Hello. Three days ago an outside proof, now this project's literature, moved the Hadwiger–Nelson problem to six or seven and
showed the plane's chromatic number is that of measurable colourings proper at almost every unit pair. In the night since, this
project's first milestone on that ground — FS-132 — went through three rounds: six derivers, one exact search, the asking lane
three times, and a planner of the kernel lane who first found its own route blind and then read the central argument as a
second mind. About fifty statements were derived, several stalled at named steps, three of the asking lane's cards were
corrected by the derivers who took them, and at least five sentences in the night's records are known to be wrong as written.
None of it is yet in one place. You make it one file that a kernel planner, the asking lane and Kooshi can each read without
the night's history — and that says of every statement exactly how far it has been checked.

## Why this job

A milestone here is Derived when its record job is filed; later milestones then open on its results. What would cost most is
an entry that overstates its source: a merged form that drops a hypothesis, a "two minds" that was one mind and a checking
reading, a statement carried at the class of all measurable colourings when its argument reads clean steps. The night's
records were written fast and corrected each other; the inventory (`{INV2}`, items 1–30) says which corrections were
accepted. Read every statement and every number from its source, never from an inventory line — the inventory's own wording
was wrong twice tonight (its items 21 and 23 say where).

## What Kooshi asked, and what the night found

{KW}
**The night as the coordinator logged it** — read `{INV2}` whole, items 1 to 30; these five first lines are addresses:

{ITEMS}
**The claim list** is `{CL}`: read it whole. Its dated lines are the exact history of what was posed, restated, derived,
stalled, withdrawn and corrected — including two corrections of the coordinator's own lines.

**Your sources**, each with its entries in your identity's grammar and its report under `data/fs132/reports/`:
- round one: `plans/FS132-E1-derivation.md` (the extraction at every number of colours; centres exist), `plans/FS132-E2-derivation.md`
  (card 3: the filled target, the index, the strips, where the forcing statement stalls), `plans/FS132-E3-derivation.md` (the
  exclusion with no map — the orbit form and its nine steps; the two readings; the two-pair ring);
- round two: `plans/FS132-E4-derivation.md` (the complementary pair; what a ring is forced to do where it changes; the
  alternating ring), `plans/FS132-E5-derivation.md` (witnesses: the two-point forms, the margin, the one-side statement, the
  superlevel form);
- round three: `plans/FS132-E6-derivation.md` (the shadow of an open piece; the lens; the placed point);
- the day's search: `plans/SEARCH-2026-10-07.md` (results graded [cert], each with its family);
- the kernel planner's record, on a branch that must not be merged (it holds unproved skeletons): read it by
  `git -C /home/kooshi/source/lean-dir show origin/fs132-wk1:plans/FS132-kernel-plan.md` — its § 3.2 is the second reading of
  the exclusion's last three steps, its § 2.3 the generalizations found blind, its § 3.5 a statement it posed;
- the asking lane's two records of the night, for the readings they contain and the defects they found — never as sources of
  a grade: `plans/POROS-2026-10-07-fs132-night.md`, `plans/POROS-2026-10-07-fs132-round2.md`;
- the milestone's plan, `plans/FS132-six-by-the-nerve.md`, and its stub, `plans/STUB-six-by-the-nerve.md`.

## Done means

1. **Your readback**, then a table in your record of every entry of the six records and the planner's (name, verdict, grade,
   minds, what it is derived from, where a later entry widens, narrows, restates or corrects it). Commit and push.
2. **The derivation file, `plans/FS132-derivation.md`**: every derived statement once, in its strongest merged form, with its
   weaker forms as corollaries named under it and each superseded entry's name kept. The chains the inventory already knows —
   check each against the entries, do not take it from here: the exclusion (its fixed form, its orbit form, the four-point
   form the planner made the leaf, the witness card's restatement); the strips (a limiting direction; a fixed witness; the
   one-side statement with no properness; the ring card's step; the shadow of an open piece); the complementary pair (as
   posed; the sharp form; the covering count); centres exist (radius 8; any disc of radius above 1; the planner's square,
   posed); the extraction (as posed; on a disc; with its two added clauses, one of which contradicts a sentence of the
   manuscript and has two named consumers); the two-pair ring (**the release's own Lean theorem at six — attribute it**); the
   index lemmas (the planner says they are one lemma: compare its statement with the second deriver's two). **Every stall
   and gap as an entry of its own**, with its step and its smallest open form; every claim posed and not started named as
   that. **Grades and minds exactly as the sources give them**: the exclusion's nine steps have different readers — say for
   each who derived it, who reworked it, who read it line by line, and that the coordinator's hand checks of four steps are
   receipts, not minds. **For every entry, on which side of one line it sits**: whether it holds where a boundary is an arc
   of the unit circle about a point of the centre's own ring — the hard case every round ended at — or only where none is.
3. **The dated corrections**, each appended under the text it corrects, the original left standing, each with its source:
   the ring card's read-off line "pure sides are opposite at antipodes" (the third-round deriver drafted the line, with its
   slot); the second round's seven-colour controls, which a re-run at another circumradius showed to be controls of the
   margin case; the plan's dictionary term for a tip (too wide; the readings deriver's report gives the term that carries
   the step); the asking lane's "generalization" that is a restatement; the stripe colouring, which is not a witnessed
   triangle with a wild ring; the search's hand argument, one of whose steps fails for germs that are only measurable; the
   first deriver's clause (5), with the two consumers it actually has; the attribution of the two-pair ring. And to earlier
   milestones' derivation files, as dated entries: that the Γ-free four-colour vertex's exclusion (rows 148–149's entries)
   holds for measurable colourings with no Siamese clause wherever four classes meet in a cycle — at one mind's derivation
   and a second mind's reading, kernel pending, given two standard facts about maps nobody derived tonight.
4. **Drafts for files that are not yours**, in your record, each with its slot and the exact words it follows or replaces:
   the sharpening of `LEDGER.md` row 133 the ring card's report drafted; a note for rows 148–149; nothing else — the front
   page is part 2's.
5. **The gates**: `python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/FS132-derivation.md` from `plans/`, green;
   and on every file you append to, before and after — a file that already failed is reported, not repaired beyond your
   entry. Controls that an entry cites must still run from where the derivation file puts them (the six records' scripts
   live under `data/fs132/e1/` to `data/fs132/e6/`; edit nothing there).
6. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed; the report in standing rule 11's
   form. **Stopping at a saved stage with the table and the derivation file's first chains written is a good report**; say
   exactly where a successor takes over.

## What is yours to decide

How the file is ordered; which form of a statement is the entry and which the corollary; how a stall is stated as an entry.
If two entries cannot both hold, or a statement the night called derived is not derived by what its record holds, say so —
that is a finding, the most valuable kind this job can make, and it comes to me at once. Raise no grade; lower one where the
source does not carry it, and say why. You start no agents of your own (standing rule 1: delegation is one level deep,
because the coordinator can only review work it knows exists).
'''
open(ROOT+"data/fs132/briefs/FS132-Z1-record.md","w").write(b)
print("written FS132-Z1",len(b))
