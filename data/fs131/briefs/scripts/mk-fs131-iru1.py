exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IRU1: de Bruijn's implementer proves FS131-KRU1's skeleton (row 100's Lemma C', the components clause, the dichotomy)
# with item 1044's rulings.
# Usage: mk-fs131-iru1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-IRU1"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor","main","HEAD"]).returncode==0
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
PLAN="plans/FS131-KRU1-ring-plan.md"
M="Proofs/HadwigerNelson/"
for p in (PLAN,"data/fs131/reports/FS131-KRU1.md",M+"Rigidity/NormOneGen.lean",M+"Rigidity/UnitRingEq.lean",M+"Rigidity/UsablePrime.lean",
          M+"Rigidity/PlaneComponents.lean",M+"Instances/UnitRingModels.lean",M+"Rigidity/AdmissiblePrime.lean",
          "data/fs131/clone1/run-gate.sh","data/fs131/ict3/gate/run-pass.out","data/fs131/ico2/statements.py","LEAN.md"):
    assert os.path.exists(W+p),p
def wl(path,first,last,must):
    ls=open(W+path).read().split("\n")[first-1:last]
    t="".join("> "+l+"\n" for l in ls)+"> — source: "+path+"\n"
    assert must in t,(path,first,must); return t
T1=wl(M+"Rigidity/UnitRingEq.lean",103,104,"theorem unitRing_eq_stableIntegers")
T2=wl(M+"Rigidity/UnitRingEq.lean",115,116,"theorem exists_two_pow_mul_mem_unitRing")
T3=wl(M+"Rigidity/UsablePrime.lean",101,101,"theorem nonempty_stablePrime")
T4=wl(M+"Rigidity/PlaneComponents.lean",62,64,"theorem connected_or_infinite_planeOver")
T5=wl(M+"Rigidity/PlaneComponents.lean",80,81,"theorem infinite_connectedComponent_planeOver")
R100=Q("LEDGER.md","| 100 |")
W2=Q("data/fs131/REQUEST-2026-10-13.md","W2: ")
I1044=item(1044); I1040=item(1040); I1025=item(1025)
b=f'''# Brief {JOB} — prove the ring of unit vectors: Lemma C′, the components clause and the dichotomy, from the skeleton and its plan

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the implementer of a planner's five skeleton modules (40 leaves, about 970 lines) — row 100's Lemma C′, its per-prime form, the statement that the plane over every real number field has infinitely many components, and the dichotomy — every `sorry` replaced by a proof without changing a statement, three private lemmas of `Rigidity/AdmissiblePrime` made public by ruling, then the full gate on one commit
  launch: now, in the planner's worktree and on its branch, with `main` merged in; beside you two implementers in other worktrees (the density form of the collapse, and the five-colour fields — the latter's branch holds the bridge `UpperHalf.exists_stablePrime_card_eq_sq` your plan reads if it lands first); none writes another's files
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be proved as typed (a statement defect goes back through me, never edited by you), when a re-price moves the total by more than a third, and when the gate is green on one commit; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: {STAND}
  record: `plans/{JOB}-ring.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (at `{HEAD}`: the planner's skeleton with `main` merged in — the three-colour criterion's modules among what it brought; `main`'s build files copied in by checksum, so the first build recompiles little beyond the root): the five skeleton modules `Proofs/HadwigerNelson/Rigidity/NormOneGen.lean`, `Proofs/HadwigerNelson/Rigidity/UnitRingEq.lean`, `Proofs/HadwigerNelson/Rigidity/UsablePrime.lean`, `Proofs/HadwigerNelson/Rigidity/PlaneComponents.lean`, `Proofs/HadwigerNelson/Instances/UnitRingModels.lean` (their proofs; their statements only by my word); in `Proofs/HadwigerNelson/Rigidity/AdmissiblePrime.lean` the edit of the plan's § 3.7 item 1 and nothing else; `Proofs.lean`; `ARCHITECTURE.md`'s rows for these modules; the gate's inputs by the gate's own rules; `plans/{JOB}-ring.md`; your scripts and logs under `data/fs131/iru1/`; `data/fs131/reports/{JOB}.md`. Front-file edits are drafted in your record, each naming its slot. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard: if it refuses a commit, reword what it names and commit again, never `--no-verify`
  budget: about 500k by the harness's count, as guidance; save a stage after each module; hand back at a saved stage before about 550k, saying what is left — a successor continues from your record, and that is a good report

Hello. The planner before you found an elementary proof that every real number field has a prime of the kind this
library calls stable, so the statement that the unit-distance graph of every such plane falls into infinitely many pieces
needs no outside theorem; and it halved the price of the ring lemma. The skeleton builds; you prove its leaves.

## Why this job

{W2}
Row 100's Lemma C′ is that kind of finding, and so is the components clause beside it. Row 100 as the ledger states it:

{R100}
## The statements

The skeleton's head statements, on your branch (the plan names every other):

{T1}
{T2}
{T3}
{T4}
{T5}
The plan is `{PLAN}` on your branch: § 1.3 its findings; § 2 the map; § 3.5 the modules, leaves and price; § 3.7 the
drafts for files it does not write. Its report is `data/fs131/reports/FS131-KRU1.md`.

## My rulings

{I1044}
The ruling it builds on, with my check of the elementary route:

{I1040}
And on history and commits:

{I1025}
In short, for you: make the three private lemmas of `Rigidity/AdmissiblePrime` public as the plan's § 3.7 item 1 drafts
(with docstrings; ruled changes), in your first build; the dichotomy rides; if FS131-ICS1's bridge has not landed on `main`
when you need the stable prime above a usable prime, take the plan's fallback (`Arith.placeHom_base` with row 105's prime
inversion, about 45 lines) and say so.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate the target, the rulings and the
   order of work in your record; report any mismatch as a finding.
2. **The leaves**, in the plan's order, re-pricing from the first two leaves and writing the re-price into your record;
   every module built through `./scripts/build.sh` under the slot; a saved stage after each module.
3. **The gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under `data/fs131/iru1/`, its logs
   there), every count change explained against `main`'s last gate (`data/fs131/ict3/gate/`, the three-colour criterion's,
   unless I tell you another landed first); the statement comparison against a dump of the skeleton's stored statements
   that you take before your first proof edit (a comparator shaped like `data/fs131/ico2/statements.py`, with a planted
   control watched), the ruled changes listed; the vacuity scan's new sites with each structure hypothesis's inhabitant
   named (`LEAN.md` § The gate); `#print axioms` of every head statement (expected: the standard three, no outside theorem).
   Commit any statement dump gzipped.
4. **The read-aloud** of each head statement against row 100, the roadmap's typed form and the asking lane's C8, in your
   record, with what is not claimed.
5. **The drafts** for the front files (the plan's § 3.7 brought to what is proved — row 105's Chebotarev clause among them),
   each naming its slot. No novelty wording: Lemma C′'s general statement and the sign-change route to degree-one primes
   are unsearched (item 1044) — write "prior art not yet searched" where a novelty line would go.
6. **The report**, in the standing rules' form.

## What is yours to decide

The order within the plan's order, every proof, helper lemmas and their modules, and whether a leaf is better proved
another way than the plan says — say so in your record. Not yours: any stored statement of the skeleton or of `main`
beyond the ruled `AdmissiblePrime` edit (message me with the defect and the form you need).

## The machine

The laptop: 12 cores, 31 GB, shared with two other implementers that build and will run full gates. From inside your
worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 4 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`;
never `lake build`. When the slot waits, another job holds the memory; on exit 75 wait ten minutes and retry. `lake env
lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The worktree's
`.lake/build` is its own copy; never replace it with a symlink. `/tmp` is a tmpfs: keep what your record cites under
`data/fs131/iru1/`. Nothing with a `sorry` reaches `main`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-ring.md"
open(out,"w").write(b); print(out)
