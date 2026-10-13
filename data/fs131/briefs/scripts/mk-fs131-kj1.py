exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KJ1: the joining module of the three-and-four-colours line — merge the four proved modules and main, state the
# statements the implementers named, check the attribution against the paper, prove the ten joining leaves.
# Usage: mk-fs131-kj1.py <inventory item of FS131-IN1's hand-back> [--dry]
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
IN1=int(sys.argv[1]); DRY="--dry" in sys.argv
JOB="FS131-KJ1"; TREE="fs131-wrc"; BR="fs131-wj1"; W=WT+TREE+"/"
assert os.path.isdir(W+".lake/build")
assert sh("git","-C",ROOT,"branch","--list",BR)=="" or DRY, "branch name taken"
assert not os.path.exists(ROOT+"data/fs131/briefs/"+JOB+"-joining-module.md") or DRY
if not DRY:
    assert os.path.exists(ROOT+"Proofs/HadwigerNelson/Arith/UpperHalf.lean"), "the residue module is not on main yet"
    assert sh("git","-C",W,"status","--porcelain")=="", "the implementer's tree is not clean"
tip=lambda b: sh("git","-C",ROOT,"rev-parse","--short=9",b)
T={b:tip(b) for b in ("fs131-wr2","fs131-wc1","fs131-wdq","fs131-wrc","main")}
C="data/fs131/claims-NF4.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
TH=Q(C,"NF4-THEOREM: ","§ The theorem (the asking lane's wording, rank 2)")
NC=Q(C,"NF4-NC: ","§ Not claimed")
DL="\n".join(Q(C,"- 2026-10-13",None,k) for k in ("Three statements widened","NF4-S9 is untrue as written","Two statements added","Two leaves of the criterion's module widened","A third statement of the criterion's module widened"))
ITEMS="\n".join(item(n) for n in (679,685,689,IN1))
P4=WT+"fs131-wr2/plans/FS131-KN4-three-four-colours-plan.md"
P5=WT+"fs131-wr2/plans/FS131-KN5-three-four-colours-passes.md"
JT=WT+"fs131-wr2/data/fs131/kn4/lean/ThreeFourColours.lean"
PDF="/home/kooshi/source/library/papers/1-s2.0-0012365X9090324B-main.pdf"
for p in (P4,P5,JT,PDF): assert os.path.exists(p),p
b=f'''# Brief {JOB} — join the line: four proved modules and the residue module become one, with the statements its implementers named, the attributions read against the paper, and its ten joining leaves proved

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; in this job you also prove what you state, and § Why this job says why one mind does both here
  role: the kernel lane's planner and prover for the joining module of the three-and-four-colours line — merge the four modules proved today on four branches with `main`, state the few statements their implementers named and could not add, read the line's attributions against the paper they credit, and prove the ten leaves of the joining module, so that the line is ready for its landing
  launch: now, in the tree the last implementer of this line handed back; a planner works on another milestone in `fs133-wk1`; no landing is in flight
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect in any of the five modules (untrue as written, vacuous, narrower than it need be — say which), for an attribution the paper does not bear out, for a merge that does not come out clean, and with one line when the joined tree builds; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/FS131-KJ1-joining-module.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its present head (`{T["fs131-wrc"]}`, the last implementer's): the merges named in § Done means; `Proofs/HadwigerNelson/Arith/ThreeFourColours.lean` (new, from the planned text) and any new module you decide an added statement needs, with their lines in the build's lists; in the four proved modules of this line (`Arith/ThreeColourCharacter`, `Arith/TorsionExtraction`, `Arith/ThreeColourCriterion`, `Arith/DyadicQuadratic`) **docstrings, and added statements with their proofs — no existing statement changes** (a defect goes to me first); `plans/FS131-KJ1-joining-module.md`; `data/fs131/kj1/`; `data/fs131/reports/{JOB}.md`. Nothing on `main`; nothing in another tree; nothing under `scripts/` (the audit's lists are the landing's)
  budget: about 400k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, after the merge builds, after the statements are added, after the attribution reading, and after every two or three leaves; hand back at a saved stage rather than start a step you cannot finish — the leaves left are then one implementer's job from your record

Hello. Today four implementers proved the four modules of one line — three and four colours over real number
fields, the finding of this project the field gets first — each on its own branch, each against the others' statements
as typed. Nobody has yet seen the four compile together, and the module that turns them into the theorem's own
sentences is ten `sorry`. This job is the join.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The line's theorem is a hand result of ours (two and three derivations, by the claim list's own line) and is the
second-ranked thing this project has to show; in the kernel it exists today only as four separate modules whose
headline compositions print an unproved dependency, because each was built against a tree where its upstream was
still a skeleton. Why one mind and not a planner then an implementer: the statements to add are few and are named
below by the people who proved their neighbours; the ten joining leaves were planned twice and are, by both planners'
reading, compositions; a hand-off between two minds would cost more than it carries. If a leaf turns out not to be a
composition, that is the moment to save a stage and hand back.

## The statements

The claim list `data/fs131/claims-NF4.md` — its theorem, its "not claimed" line, and the five dated lines that changed
it today:

{TH}
{NC}
{DL}
What the four implementers handed back, with what each named for this job, as I logged it (their words are in
quotation marks inside each item; the rulings are mine):

{ITEMS}
Where the rest is: the planned joining text `{JT}` (ten leaves, J.1–J.10 in the first planner's numbering); the first
planner's plan `{P4}` (its § 4.4 is the plan per joining leaf; § 4.6 what the landing needs; § 4.8 its drafts); the
second planner's record `{P5}` (its § Stage 7 lists, by declaration, what the joining module reads from each line, and
one thing "the join should see": one fact under two names at two levels); the four implementers' reports under
`data/fs131/reports/` on their branches. The paper: K. G. Fischer, Discrete Math. 82 (1990), our copy
`{PDF}` (the bibliography's row `[Fischer1990]` in `BIBLIOGRAPHY.md` says what has been read of it and by whom).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; each public statement of the four
   modules set beside the clause or row of the claim list it answers; the ten joining leaves read against their plans.
2. **The join** (a saved stage): on your new branch, merge `fs131-wr2` (`{T["fs131-wr2"]}`), `fs131-wc1`
   (`{T["fs131-wc1"]}`), `fs131-wdq` (`{T["fs131-wdq"]}`) and `main` (`{T["main"]}`, which now holds the residue
   module, through the gate); move the planned text to its place; build once. Then print the axioms of every public
   declaration of the five modules from the built tree: the unproved dependency the four reports name must be gone
   from every one of them, and the list of records expected to print it (item 679) is emptied by that check, not by
   hand. Send me the one line.
3. **The statements the implementers named** (a saved stage), each typed, proved, and read back aloud against the
   claim list: the two character-form statements of item 679; the two generalizations of item 685 (the headline read
   on the ring of unit vectors; the criterion's forward half for every abelian group and every set of steps, with its
   model); the two-colour statement without squarefreeness and the three docstrings of item 689; whatever the last
   item above says a call site needs. Where a statement says more than the claim list, draft the dated line for it
   in your record — I file it. Where you decide one should not be stated, say why.
4. **The attributions, against the paper** (a saved stage): for each kernel statement of the line whose docstring
   credits Fischer — the value two off the class 3 modulo 4, the value three at 3 and 7 modulo 12, four colours at
   3 modulo 8, and anything else you find — the theorem number and page of the paper, and whether what the paper has
   is the value only, or also the map our proof uses. Correct the docstrings to say exactly that. A credit the paper
   does not bear out comes to me at once.
5. **The ten leaves** proved, and no `sorry` in the five modules; one build with the linters' verdict read from its
   log; the axioms of every public declaration printed from the built tree, with a planted `sorry` watched showing —
   and **the list of headline statements that rest on the declared outside theorem that is Weil's bound**, in plain
   words, because the report to Kooshi must say which of the theorem's clauses stand on the standard three axioms and
   which on that import.
6. **Drafts for the landing and the filing**, in your record: the records the landing registers (clean, and
   imported); the architecture rows; the ledger's rows this line regrades (73, 82, 99) with what each rests on; the
   front page's sentence; the "not claimed" lines as the docstrings now have them.
7. The report in the standing rules' form.

## What is yours to decide

Where each added statement lives and what it is called; which of the two same facts a joining leaf takes; whether a
joining leaf is restated in a form that reads better and says the same (tell me the old and the new form); the batch
size of your builds; whether to save a rebuild by copying compiled files from the tree that gated them — a landing
did that today and I accepted it on the condition that its record says what was copied, from where, and how it was
compared (inventory item 694).

Not yours: the gate and the audit's lists (the landing's); any existing statement of the four modules; the residue
module; the two further values of the ledger's row 52 (a separate small job); the five-colour chain.

## The machine

**This session is on the laptop: 12 cores, 31 GB.** Measured today: one file through `lake env lean` costs 3 to 24
seconds and 3.6 GB; a build with only small modules stale takes 6 to 9 minutes at `BATCH=8`; a build that recompiles
117 real modules took 47 minutes at `BATCH=2`. Run the memory tool as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name kj1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh` from inside the worktree; never `lake build`.
Stop a process by its PID, never by matching its command line, and leave none running or queued when you hand back.
`/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/kj1/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

{NOSPAWN}
'''
out=("/tmp/claude-1000/-home-kooshi-source-lean-dir/97d700e3-0ed0-4032-8dcd-cebbe8c929fe/scratchpad/" if DRY else ROOT+"data/fs131/briefs/")+JOB+"-joining-module.md"
open(out,"w").write(b); print("ok",len(b),out)
