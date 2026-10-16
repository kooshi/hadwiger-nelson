exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KFR1: de Bruijn's planner on the density form of the collapse (the asking lane's rank 3, C23; ledger row 129's
# field clause, FS103-F-FRAC, F-TJ, F-ROUND, F-TF, B-AMEN), now that row 128's field equality is a kernel theorem.
# Usage: mk-fs131-kfr1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-KFR1"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
assert sh("git","-C",W,"rev-parse","HEAD")==sh("git","-C",ROOT,"rev-parse","main")
MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main")
POR="plans/POROS-2026-10-13-number-field-findings.md"; DER="plans/FS103-derivation.md"
for p in ("LEDGER.md","LEAN.md",DER,"plans/FS103-collapse-cp-plane.md","data/fs103/claims.md",POR,
          "plans/FS131-ICO2-collapse.md","plans/FS131-KCL1-collapse-plan.md","Proofs/HadwigerNelson/Collapse/Headline.lean",
          "plans/FS133-E1-derivation.md","Proofs/HadwigerNelson/Plane/OneClass/Algebraic.lean"): assert os.path.exists(W+p),p
def wl(path,first,last,must,addr):
    ls=open(W+path).read().split("\n")[first-1:last]
    assert ls[0].startswith(must),(path,first,ls[0][:60])
    return "".join("> "+l+"\n" for l in ls)+"> — source: "+path+addr+"\n"
W2=Q("data/fs131/REQUEST-2026-10-13.md","W2: ")
THM=wl(POR,372,378,"- *The theorem.* (Given the same printed theorem.)"," § 3.3 The first ten, each as the theorem a reader would look for")
R129=Q("LEDGER.md","| 129 |")
FRAC=Q(DER,"**FS103-F-FRAC —"); TJ=Q(DER,"**FS103-F-TJ —"); ROUND=Q(DER,"**FS103-F-ROUND —")
TF=Q(DER,"**FS103-F-TF —"); AMEN=Q(DER,"**FS103-B-AMEN —")
I1005=item(1005)
b=f'''# Brief {JOB} — the density form of the collapse at the kernel: a number field's finitary independence ratio is the larger of the plane's and its primes' — the map, the skeleton and the price

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you run on Opus
  role: the kernel lane's planner for the density form of ledger row 128's collapse — row 129's field clause and the theorems beside it in FS-103's derivation — mapped against the library now that the collapse is a kernel theorem, stated in Lean, built as a skeleton with `sorry` at every leaf, planned per leaf and priced in lines of Lean
  launch: now, in the collapse's worktree on a fresh branch cut from `main`; beside you two kernel implementers and a clerk in other worktrees, none of which writes a file you write
  mission: § Why this job
  statements: § The results
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once for a statement defect (a result false or misstated as written) or a generalization; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building
  record: `plans/{JOB}-density-plan.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (cut from `main` at `{MAIN}`; `.lake/packages` a symlink to the main tree's, `.lake/build` the collapse's gated build, which is `main`'s): `plans/{JOB}-density-plan.md`; skeleton modules under `Proofs/HadwigerNelson/` in files you create, each named in your record, and the import lines that bring them into `Proofs.lean`; `ARCHITECTURE.md` rows for your new modules only; your scripts and outputs under `data/fs131/kfr1/`; `data/fs131/reports/{JOB}.md`. Edits to the front files and to existing modules (the `Collapse/` modules among them) are drafted in your record, not made. Commit on your branch by explicit path; never push
  budget: about 400k by the harness's count, as guidance; save a stage after each of the stages below; hand back at a saved stage before about 500k

Hello. The collapse landed on `main` an hour ago: the plane over ℚ(√635087) needs exactly as many colours as the whole
plane, in the kernel with no hypothesis of ours. Its derivation had a density form beside it, which nobody has planned
for the kernel; it may now be mostly built.

## Why this job

Kooshi's rule for what this project publishes:

{W2}
The asking lane's rank 3 (`{POR}` § 3.2) is the collapse together with its density form; the collapse is held, and this
is the rest of it, as the lane wrote it:

{THM}
My log of the collapse's landing, with two items owed to the next job that touches `Collapse/` (its rulings (1) and (2)):

{I1005}
## The results

Ledger row 129, quoted whole — its plane clause is a kernel theorem since FS133-LD1; its field clause is what this job
plans:

{R129}
The derivation's entries (`{DER}`; FS-103's fixed claim list `data/fs103/claims.md`; the close's assembly
`plans/FS103-collapse-cp-plane.md` § R-close):

{FRAC}
{TJ}
{ROUND}
{TF}
{AMEN}
Measure rigidity at a number field, which these entries are "given", is now proved in the library (`Rigidity.mrPlus`, on
the standard three and `Rigidity.positive_entropy_rigidity`), and the collapse's planner showed that it discharges the
derivation's one use of MR in the load-bearing step (`plans/FS131-KCL1-collapse-plan.md` § Stage 2). Whether the same holds
at each use above is part of your map. The plane's density equality is FS-133's (`plans/FS133-E1-derivation.md`, its landing `plans/FS133-LD1-landing.md`;
in the kernel as `OneClass.finIndepRatio_plane_eq_mOne` in `Proofs/HadwigerNelson/Plane/OneClass/Algebraic.lean` and its
neighbours, `CLAUDE.md` § Where the problem stands).

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate in your record, in your own
   words, each result, each hypothesis it rests on, and what the library holds; log any mismatch as a finding.
2. **Stage 2 — the map.** Each step of the five entries, and of the two owed items of item 1005, set against what the
   library (the seven modules under `Proofs/HadwigerNelson/Collapse/`, those under
   `Proofs/HadwigerNelson/Plane/OneClass/` and `Proofs/HadwigerNelson/Rigidity/`) and Mathlib at our pin hold, by declaration name and
   module; for every use of MR, whether `Rigidity.mrPlus` discharges it; what is missing, with your estimate of each piece in
   lines of Lean. Also say whether "a finite triangle-free six-chromatic unit-distance graph exists" (the asking lane's
   corollary) is within reach from the held `6 ≤ χ(ℚ(√635087)²)` and a de Bruijn–Erdős step, and at what price.
3. **Stage 3 — the skeleton and the plan.** The head statements in Lean, read back aloud against row 129 and the
   entries in your record, with what is not claimed; every missing piece as a statement with `sorry`, built through
   `./scripts/build.sh` under the slot; a plan per leaf; the price in lines of Lean in total and per module; then the
   experience-modeling pass on the head statements (`debruijn-experience-modeling`). Nothing with a `sorry` reaches
   `main`; the skeleton stays on your branch.
4. **The report**, in the standing rules' form, with the front-page lines your reading finds owed drafted in your
   record, each naming its slot.

## What is yours to decide

The definitions (which of the library's independence ratios each entry's `α₁`, `α_inv` and `α_loc` is, or a new one), the
modules' names and places, the form of every Lean statement, which results ride in the first module, and the order of the
leaves. If an entry is misstated, or holds in a wider form (as the collapse did: every real number field, not only totally
real ones), say so: a wrong statement reported is a finding, and a better target is welcome with its price.

## The machine

The laptop: 12 cores, 31 GB, shared with two implementers and a clerk. Every Lean build and every `lake env lean` over
about 2 GiB goes through the slot, from inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 6 --cpus 3 -- env MEMMAX=6G BATCH=2 ./scripts/build.sh`
(or `--mem 4 --cpus 1 -- lake env lean …` for one file); never `lake build`. When the slot waits, another job holds the
memory; on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`)
is for iteration only, never evidence that a module is green. The worktree's `.lake/build` is its own copy; never
replace it with a symlink. `/tmp` is a tmpfs: keep anything your record cites under `data/fs131/kfr1/`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-density.md"
open(out,"w").write(b); print(out)
