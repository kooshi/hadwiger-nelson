exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-ICS1: de Bruijn's implementer proves part A of FS131-KCS1's plan (row 123's dichotomy, family, CLS, Q(sqrt23, cbrt2),
# and the bridge) from its skeleton, with item 1027's rulings.
# Usage: mk-fs131-ics1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-ICS1"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor","main","HEAD"]).returncode==0
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
PLAN="plans/FS131-KCS1-class-plan.md"
M="Proofs/HadwigerNelson/"
for p in (PLAN,"data/fs131/reports/FS131-KCS1.md",M+"Instances/SqrtFiveClass.lean",M+"Rigidity/FourColourPlaces.lean",
          M+"Instances/SqrtTwentyThreeCbrtTwo.lean",M+"Arith/StableAboveUsable.lean",M+"Rigidity/ClassRatio.lean",
          "data/fs131/clone1/run-gate.sh","data/fs131/ico2/gate/run-pass.out","data/fs131/ico2/statements.py","LEAN.md"):
    assert os.path.exists(W+p),p
def wl(path,first,last,must):
    ls=open(W+path).read().split("\n")[first-1:last]
    t="".join("> "+l+"\n" for l in ls)+"> — source: "+path+"\n"
    assert must in t,(path,first,must); return t
T1=wl(M+"Instances/SqrtFiveClass.lean",39,41,"theorem five_le_chromaticNumber_planeOver_sqrt_iff")
T2=wl(M+"Instances/SqrtFiveClass.lean",64,66,"theorem chromaticNumber_planeOver_sqrt_eq_five")
T3=wl(M+"Rigidity/FourColourPlaces.lean",73,74,"theorem five_le_localBound_iff [NumberField F] :")
T4=wl(M+"Instances/SqrtTwentyThreeCbrtTwo.lean",80,80,"theorem chromaticNumber_planeOver_sqrt23_cbrt2_eq_five")
T5=wl(M+"Arith/StableAboveUsable.lean",44,45,"theorem localBound_le_unitQuadrance")
R123=Q("LEDGER.md","| 123 |")
W2=Q("data/fs131/REQUEST-2026-10-13.md","W2: ")
I1027=item(1027); I1025=item(1025)
b=f'''# Brief {JOB} — prove five colours by field and by class: the quadratic dichotomy, the family, CLS in full, ℚ(√23, ∛2), from the skeleton and its plan

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the implementer of part A of a plan — four skeleton modules (36 leaves, about 1,100 lines) stating row 123's results the kernel does not yet hold as theorems — every `sorry` replaced by a proof without changing a statement, three private lemmas of `Rigidity/ClassRatio` made public by ruling, then the full gate on one commit
  launch: now, in the planner's worktree and on its branch, with `main` merged in; beside you three implementers in other worktrees (the `p`-adic plane, the three-colour criterion, the density form of the collapse); none writes another's files, but the density form's implementer also edits `Rigidity/ClassRatio` at another line (`ratioAtMost_of_charBound`, l. 92, made public): touch no other line of that module than your ruling names
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be proved as typed (a statement defect goes back through me, never edited by you), when a re-price moves the total by more than a third, and when the gate is green on one commit; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: {STAND}
  record: `plans/{JOB}-class.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (at `{HEAD}`: the planner's skeleton with `main` merged in, no Lean from `main` since the planner's build; `.lake/build` current for the skeleton): the four skeleton modules `Proofs/HadwigerNelson/Instances/SqrtFiveClass.lean`, `Proofs/HadwigerNelson/Rigidity/FourColourPlaces.lean`, `Proofs/HadwigerNelson/Instances/SqrtTwentyThreeCbrtTwo.lean`, `Proofs/HadwigerNelson/Arith/StableAboveUsable.lean` (their proofs; their statements only by my word); in `Proofs/HadwigerNelson/Rigidity/ClassRatio.lean` the edit of the plan's § 3.5 item 1 and nothing else; `Proofs.lean`; `ARCHITECTURE.md`'s rows for these modules; the gate's inputs (`scripts/Axioms.lean` and the rest) by the gate's own rules; `plans/{JOB}-class.md`; your scripts and logs under `data/fs131/ics1/`; `data/fs131/reports/{JOB}.md`. Front-file edits (`LEDGER.md` row 123, `CLAUDE.md`, `ROADMAP.md`, `README.md`, `LEAN.md`) are drafted in your record, each naming its slot. Commit on your branch by explicit path; never push
  budget: about 500k by the harness's count, as guidance; save a stage after each module; hand back at a saved stage before about 550k, saying what is left — a successor continues from your record, and that is a good report

Hello. This week the kernel proved that the plane over every real number field needs exactly `L(F)` colours whenever
`L(F) ≤ 5`. What it does not yet say by name is which fields those are. The planner found that the answer for real
quadratic fields needs no list — five colours exactly on three residue classes modulo 168 — and that the family, the
class statement and a field with a complex place are each short over what the library holds. You prove them.

## Why this job

{W2}
Row 123 is that kind of finding, and the quadratic dichotomy answers, for every real quadratic field at once, the
question the literature asks by naming ℚ(√47).

## The statements

Row 123, as the ledger states it now:

{R123}
The skeleton's head statements, on your branch (the plan names every other):

{T1}
{T2}
{T3}
{T4}
{T5}
The plan is `{PLAN}` on your branch: § 1.3 its findings; §§ 2.1–2.5 the map of part A; § 3.1 the skeleton; § 3.2 the
head statements read aloud, with what is not claimed; § 3.3 the plan per leaf; § 3.4 its modeling passes; § 3.5 the
drafts for files it does not write. Part B (§ 2.6, the ring lemma) is not yours: a later planner takes it. Its report is
`data/fs131/reports/FS131-KCS1.md`.

## My rulings

{I1027}
In short, for you: take the plan's § 3.5 item 1 — state `ratioAtMost_dyadic_of_six_le` as a public theorem after
`ratioAtMost_dyadic`, make `chromaticNumber_le_four_of_small` and `chromaticNumber_le_four_dyadic` public (with
docstrings), and call them by name, with no `open private`. Do this edit in your first build, since it recompiles every
module after `ClassRatio`. Each is a ruled change in the statement comparison.

And on history and commits:

{I1025}
So: a commit hook runs the privacy guard on every commit you make; if it refuses one, reword what it names and commit
again, never `--no-verify`; message me if you cannot tell what to reword. The hashes the planner's record cites changed
in the rewrite: `data/fs131/history-rewrite/fs131-kcs1-2026-10-16.txt` maps them.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate the target, the rulings and the
   order of work in your record; report any mismatch as a finding.
2. **The leaves**, in the plan's order, re-pricing from the first two leaves and writing the re-price into your record;
   every module built through `./scripts/build.sh` under the slot; a saved stage after each module.
3. **The gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under `data/fs131/ics1/`, its logs
   there), every count change explained against `main`'s last gate (`data/fs131/ico2/gate/`, the collapse's, gated on
   `7c72b9bf7`, unless I tell you another landed first); the statement comparison against a dump of the skeleton's
   stored statements that you take before your first proof edit (a comparator shaped like
   `data/fs131/ico2/statements.py`, with a planted control watched), the ruled changes listed; the vacuity scan's new
   sites with each structure hypothesis's inhabitant named (`LEAN.md` § The gate); `#print axioms` of every head
   statement (expected, from the plan: those that read the headline on the standard three, `StandingFive.kloosterman_bound`
   and `Rigidity.positive_entropy_rigidity`; CLS and the bridge as their proofs read — the record says which, as
   printed). Commit any statement dump gzipped.
4. **The read-aloud** of each head statement against row 123, in your record, with what is not claimed (the members of
   the ledger's wider "with `L = 5`" that are neither a square modulo 11 nor modulo 19).
5. **The drafts** for the front files, each naming its slot, the planner's § 3.5 items 2–4 among them. No novelty
   wording: CLS's general statement has not been searched for by name (item 1027) — write "prior art not yet searched"
   where a novelty line would go; ℚ(√47)'s value keeps the ledger's attribution.
6. **The report**, in the standing rules' form.

## What is yours to decide

The order within the plan's order, every proof, helper lemmas and their modules, and whether a leaf is better proved
another way than the plan says — say so in your record. Not yours: any stored statement of the skeleton or of `main`
beyond the ruled `ClassRatio` edit (message me with the defect and the form you need).

## The machine

The laptop: 12 cores, 31 GB, shared with three other implementers that build and will run full gates. From inside your
worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 4 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`;
never `lake build`. When the slot waits, another job holds the memory; on exit 75 wait ten minutes and retry. `lake env
lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The worktree's
`.lake/build` is its own copy; never replace it with a symlink. `/tmp` is a tmpfs: keep what your record cites under
`data/fs131/ics1/`. Nothing with a `sorry` reaches `main`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-class.md"
open(out,"w").write(b); print(out)
