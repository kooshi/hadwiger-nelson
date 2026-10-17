exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-ISF1: de Bruijn's implementer proves FS131-KFS1's Part B (C14, the fractional chromatic number of the plane over
# Q(sqrt3, sqrt11) is 4), price probe first (item 1082).
# Usage: mk-fs131-isf1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-ISF1"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
PLAN="plans/FS131-KFS1-four-space-plan.md"; M="Proofs/HadwigerNelson/"
for p in (PLAN,"data/fs131/reports/FS131-KFS1.md",M+"Instances/SeamFractional.lean",M+"RationalFour/Basic.lean",
          "data/fs56/g27/cert-g27-mrvz.json","tools/fs56_gf_check.py","plans/FS56-field-blowup.md","plans/FS131-PAS2-prior-art.md",
          "data/fs131/clone1/run-gate.sh","tools/fs131_iru2_statements.py","LEAN.md"):
    assert os.path.exists(W+p),p
def wl(path,first,last,must):
    ls=open(W+path).read().split("\n")[first-1:last]
    t="".join("> "+l+"\n" for l in ls)+"> — source: "+path+"\n"
    assert must in t,(path,first,must); return t
T1=wl(M+"Instances/SeamFractional.lean",56,57,"theorem fractionalChromaticNumber_seamPlane")
T2=wl(M+"Instances/SeamFractional.lean",74,76,"theorem iSup_fractionalChromaticNumber_seamPlane")
CQ=wl("CLOSED-QUESTIONS.md",254,272,"### 1.6 The fractional chromatic number of the plane over `ℚ(√3, √11)`")
W2=Q("data/fs131/REQUEST-2026-10-13.md","W2: ")
I1082=item(1082); I1080=item(1080); I1025=item(1025)
b=f'''# Brief {JOB} — prove that the fractional chromatic number of the plane over ℚ(√3, √11) is 4, from the skeleton and its plan, with the certificate's kernel price measured first

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the implementer of the planner's Part B — `Proofs/HadwigerNelson/Instances/SeamFractional.lean` (its three heads proved from two leaves) and the `G27` certificate pipeline beneath it (about 1,360 lines, a generator of about 350 lines of Python, and generated data) — every `sorry` replaced by a proof without changing a stored statement, through the full gate on one commit
  launch: now, in a worktree of your own on a branch cut from the planner's; beside you one implementer in the planner's worktree proving Part A (rational four-space) on the planner's branch, writing none of your files
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage at once with the price probe's measurement (stage 2), if a statement cannot be proved as typed (a statement defect goes back through me, never edited by you), when a re-price moves the total by more than a third, and when the gate is green on one commit; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: {STAND}
  record: `plans/{JOB}-seam-fractional.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (at `{HEAD}`, the planner's last commit, with both parts' skeletons; `.lake/build` a copy of the planner's, current for the skeleton): `Proofs/HadwigerNelson/Instances/SeamFractional.lean`, the `Plane/G27/` modules the plan names and their generated data modules; the generator `tools/fs131_kfs1_g27.py` (the plan's name) and its outputs under `data/fs131/isf1/`; the removal of Part A's skeleton (the four `Proofs/HadwigerNelson/RationalFour/` modules, their import lines in `Proofs.lean` and their `ARCHITECTURE.md` rows) in your first commit; `Proofs.lean`'s import lines and `ARCHITECTURE.md` rows for your modules; the gate's inputs by the gate's own rules (`scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt`'s header); the merge of `main` before the gate; `plans/{JOB}-seam-fractional.md`; your scripts and logs under `data/fs131/isf1/`; `data/fs131/reports/{JOB}.md`. Front-file lines are drafted in your record, not made. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard: if it refuses a commit, reword what it names and commit again, never `--no-verify`
  budget: about 500k by the harness's count, as guidance; save a stage after the probe and after each module; hand back at a saved stage before about 550k, saying what is left — a successor continues from your record, and that is a good report

Hello. In 2015 Cranston and Rabern asked for the fractional chromatic number of the plane over ℚ(√3, √11). This project
answered 4 by hand; the planner found a route through the library's own invariant random independent set and the 27-point
graph's certificate, with no outside theorem, and built the skeleton. One number in its price is unmeasured — how much
the kernel pays to check the certificate's data — so you measure it first.

## Why this job

{W2}
The question and this project's hand answer:

{CQ}
## The statements

Two of the three head statements, on your branch (already proved from two leaves; the plan's § 3.2 reads each aloud):

{T1}
{T2}
The plan is `{PLAN}` on your branch: § 2.2 the routes compared; § 3.1–3.3 the modules, the heads and the plan per leaf;
§ 3.5 the price; Stage 4 the drafts. Its report is `data/fs131/reports/FS131-KFS1.md`. The certificate is
`data/fs56/g27/cert-g27-mrvz.json`, checked outside the kernel by `tools/fs56_gf_check.py`.

## My rulings

{I1082}
The prior-art search on C14, whose generalization I route to you as optional:

{I1080}
On history and commits:

{I1025}
In short, for you: remove Part A's skeleton from this branch in your first commit; make the price probe your first leaf
— generate the data and check two atom chunks in the kernel, then message me the measurement (time and memory per chunk,
and the extrapolation to all of them) and continue unless it shows the whole check will not fit the machine; the
generalization (every finite unit-distance graph over ℚ(√3, √11) has `χ_gf ≤ 4`, FS131-PAS2 § 4.2) is optional — state and
prove it if it is under about 100 lines in the library's vocabulary, else write its price in your record; merge `main`
before the gate.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate the target, the rulings and the
   order of work in your record; report any mismatch as a finding. Take a dump of the skeleton's stored statements before
   your first proof edit (a comparator shaped like `tools/fs131_iru2_statements.py`, with a planted control watched).
2. **Stage 2 — the price probe**, measured and messaged, as ruled.
3. **The leaves**, in the plan's order, re-pricing from the probe and the first two leaves and writing the re-price into
   your record; every module built through `./scripts/build.sh` under the slot; the generator with a `--check` mode whose
   planted fault is refused; a saved stage after each module.
4. **The gate on one commit**, after merging `main`: the steps of `data/fs131/clone1/run-gate.sh` (copied under
   `data/fs131/isf1/`, its logs there); every count change explained against `main`'s last gate (`data/fs131/iru2/gate/`,
   the ring of unit vectors', unless I tell you another landed first); the statement comparison against your dump; the
   vacuity scan's new sites with each structure hypothesis's inhabitant named (`LEAN.md` § The gate); `#print axioms` of
   every head statement (expected: the standard three, no outside theorem). Commit any statement dump gzipped.
5. **The read-aloud** of each head statement against `CLOSED-QUESTIONS.md` § 1.6 and `[CranstonRabern2015]`'s question, in
   your record, with what is not claimed.
6. **The drafts** for the front files (the plan's Stage 4 brought to what is proved), each naming its slot; for the
   novelty line, FS131-PAS2's C14 line (`plans/FS131-PAS2-prior-art.md` § 4.4, "C14's novelty line"), quoted, not reworded.
7. **The report**, in the standing rules' form.

## What is yours to decide

The order within the plan's order, every proof, the data's format and chunking, helper lemmas and their modules, and
whether a leaf is better proved another way than the plan says — say so in your record. Not yours: any stored statement
of the skeleton or of `main` (message me with the defect and the form you need). {NOSPAWN}

## The machine

The laptop: 12 cores, 31 GB, shared with one other implementer that builds and will run a full gate. From inside your
worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 5 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`;
never `lake build`; a data chunk that needs more memory asks the slot for it (`--mem 12`), and on exit 75 waits ten
minutes and retries. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only,
never evidence. The worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` is a tmpfs: keep what
your record cites under `data/fs131/isf1/`. Nothing with a `sorry` reaches `main`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-seam-fractional.md"
open(out,"w").write(b); print(out)
