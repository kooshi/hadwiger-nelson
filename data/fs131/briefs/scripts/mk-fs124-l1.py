exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS124-L1: the landing of FS-124's first module (the disc criterion) — fs124-wk1 through the full gate and onto main.
# Worktree fs124-wl1, cut from fs124-wk1's tip (make it first; build copied from the last landing's tree).
import subprocess,os
TREE="fs124-wl1"; JOB="FS124-L1"; L=WT+TREE+"/"
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
TIP=sh("git","-C",L,"rev-parse","--short=8","HEAD"); assert TIP,"make the worktree first"
MAIN=sh("git","-C",ROOT,"rev-parse","--short=8","origin/main")
RQ="data/external/EXT-OAI1-request.md"; INV4="plans/FS124-close-inventory.md"; INV2="plans/FS132-close-inventory.md"
P=L+"Proofs/HadwigerNelson/Plane/"
os.makedirs(ROOT+"data/fs124/l1",exist_ok=True)
IDENT_L="de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus"
def inv(path,n,c):
    l=line(path,f"{n}. **",c); return "> "+l+"\n> — source: "+path+" § Items\n"
ITEMS="\n".join([inv(INV4,19,"FS124-K1 done"),inv(INV4,24,"FS124-I1 done"),inv(INV2,51,"FS132-L2 done")])
THM="\n".join([Q(P+"WeakColouringOn.lean","def AeProperOn "),Q(P+"Radius.lean","theorem radius_graph "),Q(P+"Radius.lean","theorem radius_up "),
               Q(P+"RadiusOutside.lean","theorem radius_down "),Q(P+"RadiusOutside.lean","theorem radius_five "),
               Q(P+"RadiusOutside.lean","theorem colorable_iff_forall_ball "),Q(P+"RadiusOutside.lean","theorem seven_le_chromaticNumber_plane_iff_exists_ball ")])
ROW=Q("LEDGER.md","| 161 | **The disc criterion, in measure")
GATE="\n".join([Q("CLAUDE.md","as a set); the current audit reads ","§ Trust ledger"),Q("CLAUDE.md","**What the library assumes, in both forms**","§ Trust ledger"),Q("CLAUDE.md","`declarations=","§ The gate")])
b=f'''# Brief {JOB} — the landing: the disc criterion — seven exactly when some disc has no weak six-colouring — through the full gate and onto `main`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT_L}
  role: the landing implementer of the first module of the milestone opened and derived today — take a branch on which three modules stand proved, join it with `main` (which has moved: another milestone's theorem landed on it two hours ago), finish its registrations, run the full gate on one commit, fast-forward `main`, and draft the counts and the front-page sentences for the filing
  launch: now, in a tree of your own cut from the branch's tip; a deriver works under `plans/` and `data/` on `main` and a planner of the kernel lane works blind on a branch cut from the same tip — neither writes a file you write; no other landing is in flight
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you; a planner is working blind from nine other statements of this milestone and is shown recent commit subjects, so your commit subjects say what you did and name no statement outside this module
  channel: message the coordinator ("main") by SendMessage mid-job, **at once**, for: a gap between a theorem below and the sentence it is read aloud against; a declaration that prints an axiom other than the ones its record files; the vacuity scan reading a new site as vacuous or unknown, or the assumptions step asking for a declaration you cannot class; a merge conflict in a Lean file; a gate step red for a reason you cannot repair within your touches; or a question you cannot work around. **And one line when the gate is green on the commit you will push, before you push.** The report goes to `data/fs124/reports/{JOB}.md` on your branch, and its text is your final message
  standing rules: {STAND}
  record: `plans/{JOB}-landing.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from branch `fs124-wk1` at `{TIP}`; its `.lake/build` is its own copy, made today from the last landing's tree): the merge of `main`; docstrings and module headers of the three modules of this landing; **one sentence in the module docstring of `Proofs/HadwigerNelson/Outside/OAI158.lean`** naming the release's licence (see § Done means, item 4); `Proofs.lean`, `ARCHITECTURE.md`; `scripts/Axioms.lean` (the branch's block as merged; its section prose where a count is said), `scripts/Assumptions.lean` and `scripts/assumptions-ledger.txt` (the second by `--write-ledger` only), `scripts/axioms-controls.txt` only if a control's expected count moves with your state, `scripts/vacuity-baseline.txt` (its header's count lines only, after the scan's final run; an entry is a message to me); `plans/{JOB}-landing.md`, `tools/fs124_l1_*.py`, `data/fs124/l1/`, `data/fs124/reports/{JOB}.md`; `main` by the one fast-forward push this brief names; **not** the statement of any theorem or definition (a statement that must change is a message), either axiom of the import module, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `tools/claude_md_fact_audit.py`, the derivation files (drafts for those go in your record), the outside clone at `/home/kooshi/source/math`
  budget: about 300k by the harness's count, as guidance; you cannot read that count, so use this: **save a stage after each numbered item below, and if you have made three full gate runs without a green one, stop at a saved stage and hand back**

Hello. The Hadwiger–Nelson problem — how many colours the plane needs so that no two points at distance 1 share one — stands
at six or seven. This afternoon a deriver of this project showed by hand that the question has a form with no infinite object
in it; a planner stated it in Lean working blind from the statements; and an implementer proved the module in half an hour.
On the branch you stand on, the last theorem reads: `7 ≤ χ(ℝ²)` if and only if some open disc about the origin has no
measurable six-colouring proper at almost every unit pair — on the standard three axioms and one declared outside theorem.
It has not been through the gate. You take it there, and onto `main`.

## Why this job

Every later result of this milestone and of its successor — an exclusion on a disc, a six-coloured fragment of any
regularity — will be consumed through this module. Until it passes the gate the ledger's row says "kernel-checked on a
branch, not held". The gate is what turns a proof that compiles into a statement a reader who trusts none of us may rely
on. Kooshi's word of this morning, and what he has said of formalizing:

{Q(RQ,"> I agree with all 3.")}
{KOOSHI}
How the branch came to be, and the landing that went before yours two hours ago, whose record is your pattern (read each
item whole in its inventory):

{ITEMS}
## The statements

**No statement changes in this job.** The definition and the theorems the landing is for, in your worktree (read each whole,
with its docstring):

{THM}
**The row they are read aloud against**, as filed today:

{ROW}
and the theorem record's entries, `plans/FS124-derivation.md` § 1 (C124-RADIUS-GRAPH, -COUNTABLE, -UP, -DOWN, -FIVE): the
Lean module states wider forms as its cores (any function proper at almost every unit pair, any subset) and the entries'
words as corollaries — say, for each entry, which theorem is its read-back.

**The gate's recorded state on `main`**, which your counts are reconciled against (refiled an hour ago, after the last
landing):

{GATE}
**The records to read**, in your worktree: the planner's (`{L}plans/FS124-kernel-plan.md`: the definition, each statement's
read-back, § 3.5 what the landing needs, § 4.4 its drafts) and the implementer's (`{L}plans/FS124-I1-implementation.md`: the
57 theorems with their axioms, the counts measured on the branch, its twelve drafts). And on `main`: the last landing's
record, `plans/FS132-L2-landing.md`, for the gate's procedure step by step, with its receipts under `data/fs132/l2/gate/`
and its gate runner `data/fs132/l2/run-gate.sh`.

## Done means

1. **Your readback first**: check every quotation above against its source; read the two records and the last landing's
   record; `LEAN.md` § The gate, § Assumptions and § Trust ledger as they stand on `main` (refiled today: read them from
   `main`, not from your branch). Build the branch once as given. Open your record. Commit and push.
2. **`main` merged in** (at `{MAIN}` when this was written). Trial it first and name the conflicts before you make it: both
   sides added lines to `Proofs.lean`, `ARCHITECTURE.md` and `scripts/Axioms.lean` — keep both; I expect no conflict in a
   file under `Proofs/`, and one there is a message to me. Build.
3. **The registrations**: the branch's audit block as merged (57 records: 52 clean, five resting on a declared outside
   theorem — four on the Borel transfer, one on the five-colour theorem — each filed on exactly the one it uses, the
   wrong-filing control still firing); the prose of the audit script's imported section where it says how many records
   rest on each import; the architecture rows; `tools/check_architecture.py` exit 0; the doubled-name check.
4. **One loose end of the last landing, yours because your build pays for it**: the import module's docstring
   (`Proofs/HadwigerNelson/Outside/OAI158.lean`, hand-written; it copies ten declarations of the release) does not name the
   release's licence. Add one sentence to its module docstring naming it and pointing at the copy beside it
   (`Proofs/HadwigerNelson/Outside/OAIMath2026-LICENSE.txt`). Nothing else in that file changes; re-run the import's
   stored-term comparison (`tools/fs132_i1_readback.py`) to show its eight declarations are untouched.
5. **What the library assumes.** `./scripts/assumptions.sh --self-test`, then `./scripts/assumptions.sh`: the implementer
   measured that it fails only on the ledger rows of the five theorems that rest on an import, and that the definition's
   conditions ask no declaration — read every failure before `--write-ledger`, and list every row the ledger gains (the
   count of statements resting on a declared outside theorem goes from 18 to 23).
6. **The vacuity step**: `scripts/vacuity.sh` and its `--self-test`; say how the scan classes every new site (the
   implementer measured one new site, nothing vacuous or unknown); and, since the last landing found the scan silent on
   modules whose colourings are maps under a predicate it does not track, **name by hand the model of each hypothesis of
   the seven theorems above** and whether the kernel holds it (the planner's record names the tight seven-colouring as the
   definition's model).
7. **Read aloud.** In your record: the two join theorems, `radius_up`, `radius_down` and `radius_five` against the row's
   sentences and the entries' statements, clause by clause; **and which half of the criterion rests on the outside
   theorem and which on the standard three alone**, with the two theorems that say so.
8. **The full gate on one commit**: `./scripts/build.sh` with zero warnings; zero `sorry` in `Proofs/` (a search whose plant
   fires); the doubled-name check and its `--self-test`; `scripts/axioms.sh` clean with `--self-test` green — three
   declared outside axioms as before; `scripts/vacuity.sh` and `--self-test` green, the counts reconciled against the line
   above; `./scripts/assumptions.sh` and its `--self-test` green; `tools/check_architecture.py` exit 0; the guarded lint
   (`lake lint --no-build -- --no-build --trace` under the slot with `--mem 8`), silent; the notes check and the records
   check as the last landing ran them. Take the three digests against the last landing's receipts
   (`data/fs132/l2/gate/receipt-axioms-final.log`, `data/fs132/l2/gate/receipt-vacuity-final.log`,
   `data/fs132/l2/gate/receipt-assumptions-final.log`). Save every step's log under `data/fs124/l1/` and name them.
   **Message me one line when it is green, before you push.**
9. **The landing**: if `main` moved meanwhile, merge it again; when the new commits touch only `plans/`, `data/`,
   `.claude/`, `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md`, `RUNNING.md`, say so with the diff that shows it, otherwise re-run
   the gate on the merged commit. Name the merged commit by its hash in every check. Then `git push origin HEAD:main` from
   the worktree — a fast-forward only, never a force-push; on a rejected push, fetch, merge and try again.
10. **Drafts for the filing**, in your record under "Drafts for the front page ({JOB})", each with the log line it comes
    from and **the exact words on `main` it replaces**: `CLAUDE.md` § Trust ledger (the audit's sentence; the nine
    assumption counts and the sentence that says how many theorems rest on each outside theorem) and § The gate's count
    lines; a `GATE_CHANGES` entry; § Where the problem stands — the planner's sentence on the disc criterion and which
    half needs the import (its § 4.4), checked against the landed names; the phrase "kernel-checked on a branch" wherever
    the front page and row 161 now say it of this module; `LEDGER.md` row 161's grade sentence; the theorem record's dated
    line; `LEAN.md` (the planner's and the implementer's lines not yet filed); the atlas grade of the criterion's node.
    And **the open gate items at this landing**, by name, if any.
11. **Your record**, stages headed "Stage n — SAVED ({JOB})"; the report in standing rule 11's form, the counts read from
    the gate's saved logs. Leave no background process running. **Stopping at a saved stage with the gate red at a named
    check is a good report** — say which check, its log, and what you would try next.

## What is yours to decide

How the merge is resolved; the wording of the docstring sentence and of rows; how each gate step's finding is repaired
within your touches. Not yours: any statement — if the gate shows a theorem says less or other than its row, that is the
most valuable message this job can send, and nothing is repaired around it. Three failed attempts on one route is a
dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs124/briefs/"+JOB+"-landing.md","w").write(b)
print("written",JOB,"tip",TIP,"main",MAIN,len(b))
