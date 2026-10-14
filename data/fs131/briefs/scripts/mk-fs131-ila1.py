exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-ILA1: lane A — `exists_admissiblePair` (one admissible pair of unit vectors at every real number field), planned
# by FS131-IJ3 and proved here.
# Usage: mk-fs131-ila1.py <item 761> <item of IJ3's lane-A notice> <item of IM11's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
K8,KA,KM=[int(x) for x in sys.argv[1:4]]
TREE="fs132-wi1"; BR="fs131-wla"; JOB="FS131-ILA1"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wm12"
OLD=("data/fs131/km11/","data/fs131/im11/")
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if not any(x in l for x in OLD)]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
DE=Q(C,"- 2026-10-14 — **NF2-LEAF-20 is narrowed: the entropy split is read at one rotation","§ Dated lines")
WQ=WT+"fs131-wq1/"; PI=WQ+"plans/FS131-IJ3-implementation.md"; RG=W+"Proofs/HadwigerNelson/Rigidity/"
for p in (PI,RG+"UnitCircle.lean",RG+"EntropySplitMax.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: one admissible pair of unit vectors at every real number field

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the implementer of lane A — the one `sorry` of `Rigidity/UnitCircle`, `exists_admissiblePair`: at every real number field, a pair of unit vectors of the kind the entropy split needs (its definition, `AdmissiblePair`, is typed and read by `EntropySplitMax`), proved by the valuation route the last chain implementer planned in seven leaves, as private helpers of its file or a new module beside it
  launch: now, in M11's implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; the chain's entropy implementer proves the split and the positive-entropy files in another tree on the same line (it does not touch `UnitCircle`); three other jobs share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if the statement is false as typed or needs a hypothesis it lacks, if the first two leaves price the lane above 1,500 lines, if a classical input is missing at the pin, and with one line when `exists_admissiblePair` prints the standard three; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wm12` at `{TIP}`; its build is current for that commit): **the proof of `exists_admissiblePair`, private helpers and import lines only — no statement changes, no definition changes** in `Proofs/HadwigerNelson/Rigidity/UnitCircle.lean`; a new module `Proofs/HadwigerNelson/Rigidity/AdmissiblePrime.lean` for the leaves if they are better public (its lines in the build's lists and `ARCHITECTURE.md`); their `ARCHITECTURE.md` rows where a cell's state changes; your checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/ila1/`; `data/fs131/reports/{JOB}.md`. **Not** `EntropySplitMax.lean`, `EntropyFibres.lean`, `PositiveEntropy.lean` (another job's, on another branch), M11's modules, the count's modules, any module under `Outside/`, the declared printed theorem. Untracked files of the last two jobs are in `data/fs131/km11/` and `data/fs131/im11/`: leave them. Nothing on `main`
  budget: {BUDGET}

Hello. The entropy split — the chain's positive-entropy half — takes one admissible pair of unit vectors as an input.
Whether such a pair exists at every real number field is the one statement of `Rigidity/UnitCircle` left unproved. The
chain's entropy implementer planned it, priced it at about 1,000 lines, and handed it on so that its own lanes could go
first. You prove it.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
With lane A proved, the models that are conditional on an admissible pair become unconditional (inventory item 801,
ruling 2), and the entropy split reads a pair that exists at every real number field.

## The statements

The dated line of the chain's claim list (`data/fs131/claims-NF2.md`) on the split, and the hand-backs behind this job as
I logged them (their words in quotation marks, the rulings mine; item {K8}'s ruling 4 is a note of mine, unchecked, on a
completely split prime — the planned route below takes another prime and does not need it):

{DE}
{item(K8)}
{item(KA)}
{item(KM)}
**The plan** is item {KA} above — seven leaves A1–A7 at a degree-one, unramified, odd prime of `L = F(i)`, about 1,000
lines — written in full in the last chain implementer's record `{PI}` § 2.5 (in its tree; read it there). Read
`exists_admissiblePair`'s stored statement and `AdmissiblePair`'s definition from your built tree first; restate the
plan against them in your record; then prove A1–A7 in the plan's order or yours.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; `exists_admissiblePair` and
   `AdmissiblePair` printed from the kernel and restated; the plan's seven leaves restated against them, each with the
   Mathlib names it reads `#check`ed at the pin.
2. **The leaves** (saved stages as they fall, and the one line to me when `exists_admissiblePair` prints the standard
   three); re-price from the first two and say so.
3. **No statement and no definition changed**, shown from the kernel's side against a dump of `UnitCircle`'s stored
   statements taken before any edit (a planted change watched firing); one build under the slot with no warning from your
   files; the axioms of every public declaration of your files printed from the built tree, each listed, with a planted
   record watched showing; the guarded lint with no finding in your files.
4. **Drafts for the landing**, in your record: the audit's block; any `LEAN.md` lines; bibliography lines for every source
   you read (X02D's derivation entry by address; Schur's theorem by its printed source if you cite one).
5. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proof; private helpers or the new module; imports; the route of any leaf where the plan's does not go through (tell
me which). Not yours: a change to `exists_admissiblePair`'s statement or `AdmissiblePair`'s definition; the files listed as
not yours; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wm12`. One file through `lake env lean`: 3 to 24 seconds,
3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ila1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`; do not edit a file a running build will compile. The certificate job holds up to 10 GiB of the slot for
long stretches: on exit 75 wait ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137.
Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your record cites
lives under `data/fs131/ila1/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-admissible-pair.md","w").write(b); print("ok",len(b))
