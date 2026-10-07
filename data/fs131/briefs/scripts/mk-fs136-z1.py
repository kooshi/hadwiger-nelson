exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS136-Z1: FS-136's record job (twenty entries of two rounds): the derivation file, the corrections, the stubs — a new one for
# what collars force — the predictions scored, the drafts for the front page. Its filing makes FS-136 Derived.
import os
RQ="data/external/EXT-OAI1-request.md"; INV6="plans/FS136-close-inventory.md"; CL6="data/fs136/claims.md"
E1R="plans/FS136-E1-derivation.md"; E2R="plans/FS136-E2-derivation.md"; PL="plans/FS136-the-point-across.md"; STQ="plans/STUB-covering-pairs.md"
PO="plans/POROS-2026-10-07-fs136-round1.md"; DER4="plans/FS124-derivation.md"; INV4="plans/FS124-close-inventory.md"
os.makedirs(ROOT+"data/fs136/z1",exist_ok=True)
def inv(n,c,path=INV6):
    l=line(path,f"{n}. **",c); return "> "+l+"\n> — source: "+path+" § Items\n"
WORD=Q(RQ,"> I agree with all 3.")
ITEMS="\n".join(inv(n,c) for n,c in ((4,"FS136-E1, verdicts through its Stage 3"),(5,"FS136-E1, the last two claims"),(6,"FS136-E1 done"),(8,"FS136-P1, first message"),
                                     (10,"FS136-E2, first message"),(11,"FS136-E2, verdicts"),(12,"FS136-E2, the clause I kept fires"),(14,"FS136-E2 done")))
KERN="\n".join([inv(40,"FS124-L1 done",INV4),inv(42,"FS124-I3 done",INV4)])
b=f'''# Brief FS136-Z1 — the record job: FS-136's derivation file from two rounds, the corrections they owe, the stubs, and the drafts of the front page

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS136-Z1
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its `## The record job` is your job, whole (twenty entries: one job)
  role: the record job of the milestone on covering pairs — one derivation file in which every statement two derivers produced today stands once, in its strongest merged form, at exactly the grade and number of minds its source gives it; the dated corrections the two rounds owe each other, the asking lane's cards and the milestone before; the stubs this milestone moved and the one it opens; every registered prediction scored; and the front page's drafts — so that the coordinator's filing can call the milestone Derived
  launch: now, on `main`, into the slot the second deriver freed; an implementer and a planner of the kernel lane work on branches and write nothing you write; no landing is in flight and no mind is blind
  mission: § Why this job
  statements: § What Kooshi asked, and what the two rounds found
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind
  channel: message the coordinator ("main") by SendMessage only for a question you cannot work around or a finding that cannot wait — two entries that cannot both hold, a merged form that would drop a hypothesis, an entry graded above its source, a draft that would state a result more widely than its entry; the report goes to `data/fs136/reports/FS136-Z1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS136-Z1-record.md`
  touches: `plans/FS136-Z1-record.md`; `plans/FS136-derivation.md` (new); `{E1R}`, `{E2R}`, `{DER4}` and earlier milestones' derivation files `plans/*-derivation.md` (dated entries and errata appended only, the original text left standing); `plans/STUB-*.md` (new stubs; in open stubs the provisional-bearings lines and dated correction notes only — never a question section, which is the asking lane's, never a banner, which is the coordinator's); `data/fs136/z1/` (your scripts live here), `data/fs136/reports/FS136-Z1.md`; **not** `CLAUDE.md`, `LEDGER.md`, the grokkings file, `plans/FRONTIER-STUBS.md`, `plans/GROKKING-INSTANCES.md`, `BIBLIOGRAPHY.md`, `plans/SEARCH-QUEUE.md`, the claim lists, the inventories, any Lean file — a line owed to one of those is a draft in your record, with its slot
  budget: about 400k by the harness's count, as guidance (your launch preloads the grokkings, about 150k); you cannot read that count, so: a saved stage after each numbered item of § Done means, and hand back at a saved stage if the front page's drafts are not begun by your fifth stage — a successor continues from your record

Hello. This afternoon the asking lane named a milestone: two meeting points of a measurable six-colouring whose colours
together are all six, and the points one unit from both — where every six-coloured object this project holds stops. Since
then two derivers have taken two cards of it. Twenty statements are derived, by hand, one mind each: a head statement about
which side of a unit circle a label may sit on; the count it gives for a pair; exclusions at four held stops, first on whole
tiles and then on the corner patterns at two points alone; the same statement run forward, forcing a corner where one label
is left, and the closure it generates — which stalls on every object tried; and, found after the verdicts, that a point
carrying five of six labels forces the sixth along arcs of its unit circle. Three sentences that I carried to Kooshi on the
way were corrected by the next job to read the objects. None of it is in one place, and none of it is on the front page.
That is your job.

## Why this job

A milestone is Derived when its record job is filed. What would cost most is an entry or a front-page sentence larger than
its source, and this milestone has a particular way of being overstated: **every one of its statements is about colourings
that already have named regions or corners, and no weak six-colouring is known to have one** — so no entry excludes a
colouring of a disc, none fixes or bears on the plane's number, and the one result that forces a region of definite extent
(the collar) starts from a five-label point somebody must supply. Say that where it belongs, once, and let no draft lose
it. Read every statement and number from its source, never from an inventory line: my own lines were corrected three times
in this milestone (items 8, 10 and 12 say where).

## What Kooshi asked, and what the two rounds found

{WORD}
**The path, as the coordinator logged it** (read `{INV6}` whole, with the rules that judge the milestone above the items;
these first lines are addresses):

{ITEMS}
**Your sources.** The two derivers' records, each with its entries in your identity's grammar: `{E1R}` (ten entries: the
reading of every held object; the table; the count for two members and for one; the bound on partners; five exclusions at
four held stops, one of them by germs) and `{E2R}` (ten: two lemmas on corners; the forward step; the closure, as a
statement and computed on three objects; the stops by corners, with their radius law; the collar). The plan, `{PL}`, with
both rounds' re-grokking, prior art and predictions. The claim list, `{CL6}`, with its dated lines — the exact history of
what was posed, restated, added and derived. The asking lane's record, `{PO}` — for readings, scored predictions, the
defects it found and its re-drafted ranking row, never as a source of a grade. The milestone's stub, `{STQ}`, with its two
cards. **The kernel lane's state, to be said exactly** (read both items whole): the disc criterion of the milestone before
is held; the nine statements of that milestone's second module — among them the one-member form of this milestone's head
statement — are kernel-checked on a branch, not through the gate; nothing of this milestone's own twenty is in the kernel:

{KERN}
## Done means

1. **Your readback**, then a table in your record of every entry of the two records (name, verdict, grade, minds, what it
   is derived from, its class, whether it reads the number six or "all the labels", and where a later entry widens,
   narrows, restates or corrects it). Commit and push.
2. **The derivation file, `plans/FS136-derivation.md`**: every derived statement once, in its strongest merged form, its
   weaker forms as corollaries named under it, each superseded name kept; every calibration and every reading marked as
   one. The chains to check against the entries: the table, and under it the count for two members and for one (each "on
   labels", with the posed forms and the degenerate case that restated them) and the forward step; the closure, with the
   three computed closures as what they are — computed over named corners, exact; the stops — the corner forms and the
   whole-tile forms of the same four exclusions (say for each which is the entry and which the corollary, and where
   neither contains the other, as the strip's two do with the milestone before's closed edge); the bound on partners, with
   its grade said whole (it rests on an entry of the milestone before, kernel-checked on a branch in another form); the
   collar. **For every entry: its class and what it does not claim**, in the deriver's words. **Grades and minds exactly
   as the sources give them**; where one statement was reached by two jobs on one route (the table and the kernel
   planner's lemma; the count), the source says "not two independent derivations" — keep that. The reading of held objects
   is [tools], and says on which objects and what was exact.
3. **The dated corrections**, each appended under the text it corrects, the original left standing, each with its source:
   under the first round's closing section (its § 6.4 item 1), the erratum the second deriver drafted (its § 7.5); under
   the first round's entry for the bowtie fragment, which corner the vertex figures empty; in the stub, as dated correction
   notes — the table row on rigidity at seven, the card's third seed, the existence form's "a fragment" (a closure is
   corners at points); **in the milestone before's theorem record, `{DER4}`**: under its entry for the save by one member,
   that the step its deriver flagged has had a second look and has passed the kernel on a branch in the planner's
   statement of it (`{INV4}` items 33, 41 — use those items' words for what was and was not checked), and under its § 7
   (the reading), whatever the next sentence finds. **A reader of that milestone has a suspected defect**: the second
   round's reader of FS-124 (`data/fs124/e2/saves_read.py`) rounds vertices to nine decimals and tests "an edge lies on
   the circle" at `10⁻⁹`; the same rounding gave 2,296 false violations in a copy. Re-run it with the tolerance repaired
   (a copy under your own directory; the original left as it is), compare every count that the theorem record's § 7 and
   ledger row 163 quote, and append a dated line saying whether any moves.
4. **Stubs.** **A new stub, FS-137 — what collars force**: the full mission context in plain language, the entry it
   starts from with its *not claimed* line, the smallest open form the second deriver wrote (its Stage 8), the held map
   entry it restates, the controls (the seven-colouring reads zero; the flower's centre gives isolated points), and
   provisional bearings — written so that a mind with no memory of today can open it; its question section is the asking
   lane's, left for it. In the milestone's own stub: a dated line on what it delivered. In the open stubs this milestone
   moved — lateral extent, the seed remainder, the (Q) ring, the exclusion back to maps: bearing lines or dated notes,
   each from an entry.
5. **Every registered prediction scored**, in one table: the asking lane's two cards (scored in part by the derivers
   already — reconcile, do not redo), the two derivers', with Brier where binary.
6. **`## Drafts for the front page`** in your record, each draft naming its slot — the file, the section, the exact words
   it replaces or follows — and written as it should stand, current state only: `LEDGER.md` rows from **165**, few, each a
   result a later milestone will cite, each with its class, its grade in the source's words and what it does not claim;
   `CLAUDE.md` § Frontier — the "Last updated" line, the open-milestones paragraph (this milestone Derived; what its
   Lean phase would state first: the asking lane's and the second deriver's handoff lines say), item 31's sentences this
   milestone changes, the ranked table's first row (the asking lane re-drafted it in its record, § Draft re-rank: carry
   it, and say where the collar's stub would sit until the asking lane ranks it); **say each draft's net change in
   bytes** (the file holds 65,425 of 80,000); proposed grokkings from **G100**, in G67's form, and new instances of
   existing entries for `plans/GROKKING-INSTANCES.md`, verbatim with sources — both derivers and the asking lane drafted
   some; Proof Atlas facts; bibliography rows only if a section lacks one (one was filed today: `[Bauslaugh1998]`).
7. **The sweeps** your identity's record job names (§G: which entry should have borne and was not used; §IQ and G79;
   §PA — the second deriver lists prior-art debts on map entries cited at a statement only; the plan and the stubs
   grepped for "conjecture" and "not claimed").
8. **The gates**: `python3 ../.claude/skills/ephodos/scripts/derive_gate.py all FS136-derivation.md` from `plans/`, green
   (a record with many controls can take minutes to gate: run long gates in the background, under the slot if past two
   minutes, and say so); every file you append to gated before and after.
9. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed; the report in standing rule
   11's form. **Stopping at a saved stage with the derivation file filed and the corrections appended is a good report** —
   say exactly where a successor takes over.

## What is yours to decide

How the file is ordered; which form of a statement is the entry and which the corollary; how many ledger rows the
milestone deserves; which grokkings are worth proposing. Raise no grade and no count of minds; lower one where the source
does not carry it, and say why. Write no sentence larger than the entry it summarizes — where you are unsure, quote the
entry's statement and its *not claimed* line beside the draft and let the coordinator choose. If two entries cannot both
hold, or a statement the day called derived is not derived by what its record holds, that is a finding and comes to me at
once. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only
review work it knows exists).
'''
open(ROOT+"data/fs136/briefs/FS136-Z1-record.md","w").write(b)
print("written FS136-Z1",len(b))
