exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-PAS3: Ephodos reads [KubickiLehelMorayne2002] in full against C7 and A3, and settles C7's prior-art form (items 1075, 1080).
# Usage: mk-fs131-pas3.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-PAS3"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",W,"branch","--show-current")==BR
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor","main","HEAD"]).returncode==0
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
PAS="plans/FS131-PAS2-prior-art.md"; PLAN="/home/kooshi/source/lean-dir/.claude/worktrees/il5/plans/FS131-KFS1-four-space-plan.md"
assert os.path.exists(PLAN)
for p in (PAS,"CLOSED-QUESTIONS.md","BIBLIOGRAPHY.md","data/consolidation-2026-09-27/lv/record.md","data/consolidation-2026-09-27/lx/record.md"):
    assert os.path.exists(W+p),p
LIB="/home/kooshi/source/library/pdf/KubickiLehelMorayne2002-patch-rigid-colorings-rational-n-space-jctb-84-45-53.pdf"
assert os.path.exists(LIB)
I1075=item(1075); I1080=item(1080); I1082=item(1082)
b=f'''# Brief {JOB} — read Kubicki, Lehel and Morayne (2002) in full against rational four-space at four colours, and settle its prior-art wording

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity; this job is the prior-art gate (§PA) on one paper and one result, with no derivation of its own
  role: the reader of one 2002 paper that may already hold this project's result on four-colourings of `ℚ⁴` (C7) or its structure clause (A3), deciding between the two drafted forms of C7's prior-art wording, or a third
  launch: now, in a worktree of your own cut from `main`; beside you two Lean implementers in other worktrees — one of them proving C7 and A3 — neither of which writes a file you write
  mission: § Why this job
  statements: § What to read against
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage at once if the paper proves C7's answer itself (the forbidden distances), and when the record is done; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `plans/{JOB}-kubicki-lehel-morayne.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (cut from `main` at `{HEAD}`; no Lean build): `plans/{JOB}-kubicki-lehel-morayne.md`; your scripts and notes under `data/fs131/pas3/`; `data/fs131/reports/{JOB}.md`. `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md` and `LEDGER.md` lines are drafted in your record, each naming its slot, never edited. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard: if it refuses a commit, reword what it names and commit again, never `--no-verify`
  budget: about 120k by the harness's count, as guidance; hand back before about 200k

Hello. Yesterday's prior-art search found that a 2002 paper's withheld summary says "every 4-coloring of Q^4 is rigid",
and held the public wording of this project's result on rational four-space until someone read it. Kooshi saved the
paper this morning. It is nine pages: read all of it.

## Why this job

The finding and my ruling:

{I1075}
The search's hand-back, with the two drafted forms:

{I1080}
## What to read against

- **The paper:** `{LIB}` (J. Combin. Theory Ser. B 84 (2002) 45–53; its abstract: "every 2-coloring of Q 2 or Q 3, and every
  4-coloring of Q 4 is rigid", where a rigid colouring is one that "uniquely extend[s] from any open subset of Q n").
- **C7 and its derivation:** `CLOSED-QUESTIONS.md` § 3's entry "Which distances can a four-colouring of `ℚ⁴` forbid beside
  1?" (the answer and the outline: the component of the origin, the residue map onto `𝔽₄`, Zaks's Lemma 1, the valuation
  law); the derivations LV-T3 (`data/consolidation-2026-09-27/lv/record.md`) and LX (`data/consolidation-2026-09-27/lx/record.md`).
- **A3, the structure clause** — every proper four-colouring of `ℚ⁴` is, on each component, the residue map up to a
  bijection of the colours — as the kernel planner states it: `{PLAN}` § 1.2 (item A3) and § 2.1 — the planner's record, on its branch in another
  worktree, read only (it reaches `main` with the landing); my ruling that the
  implementer states it:

{I1082}
- **The two drafted forms** of the wording: `{PAS}` § 2.4, items 1–3.

## Done means

1. **Stage 1 — the readback.** Check the quotations above against their source; restate in your record C7, A3 and the two
   forms in your own words.
2. **The reading**: the whole paper, with every theorem and lemma about `ℚ⁴` (and any about general `ℚⁿ` that applies at
   `n = 4`) quoted with its page; how "rigid" is defined; and for each of C7's parts — the compulsion law (forced equal,
   forced different, free), A3, and the answer to Johnson's question — whether the paper states it, implies it in a few
   lines (say which lines), or neither. Mine its reference list, and note anything else in it that bears on this
   project's results (its patch-colouring theorem among them).
3. **The verdict and the drafts**: form (A), form (B) or a third form of `{PAS}` § 2.4 items 1–3, brought to what you read,
   each naming its slot; its draft 2 (the periods question) re-worded if the paper bears on it; a `BIBLIOGRAPHY.md` status
   line for `[KubickiLehelMorayne2002]` ("read in full", with what it states); and a novelty line for the C7 module's
   landing, in the project's wording rule ("prior art: not found in print" only for what is not; never "first").
4. **The report**, in the standing rules' form.

## What is yours to decide

How far to follow the paper's references, and the verdict. If C7 or A3 is misstated against the paper, or the paper's
notion of rigidity is stronger or weaker than A3, say exactly how: that is the finding. {NOSPAWN}
'''
out=ROOT+f"data/fs131/briefs/{JOB}-kubicki-lehel-morayne.md"
open(out,"w").write(b); print(out)
