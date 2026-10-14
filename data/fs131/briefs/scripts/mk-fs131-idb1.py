exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IDB1: the density bound's first implementer — lane C (the J0 covering: checker, soundness, generated cell modules,
# the tail) first, then lane B (Bessel, BesselDefect), on the planner's branch.
# Usage: mk-fs131-idb1.py <item of KDB1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KD=int(sys.argv[1])
TREE="fs131-w10g"; BR="fs131-wdb1"; JOB="FS131-IDB1"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wdb"
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if "data/fs131/kdb1/build" not in l]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
D1=Q(C,"- 2026-10-14 — **The density bound has a route with no periodic reduction","§ Dated lines")
D2=Q(C,"- 2026-10-14 — **The certificate's analytic half is priced in the kernel","§ Dated lines")
PR=W+"plans/FS131-KDB1-density-bound.md"; DB=W+"Proofs/HadwigerNelson/Plane/DensityBound/"; KP=W+"data/fs131/kdb1/"
for p in (PR,DB+"Bessel.lean",DB+"BesselDefect.lean",DB+"Window.lean",KP+"probes/CellProbe.lean",KP+"proto/plan800.json",
          KP+"proto/lean-states.txt",KP+"proto/proto_chain.py",KP+"leaves/Leaves.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the density bound: the Bessel covering checked in the kernel, then the Bessel function's lemmas proved

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-14. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the density bound's first implementer — lane C, the covering of `[0, 800]` by 847 cells that bounds the paper's function `ϕ` below through the Bessel function `J₀` (its checker, the checker's soundness theorem, the generated cell modules checked by `decide +kernel`, the tail at 800), then lane B, the Bessel function's own lemmas (its definition by circle averages, its derivatives, its energy, the defect bounds the checker reads), as far as you reach
  launch: now, in the planner's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; three other jobs work in other trees (the density equality's landing, the class-ratio certificates, the chain's implementer) and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if a cell fails in the kernel, if the first two leaves of a lane price it above twice the planner's lines, if a kernel check needs more than 12 GiB or an hour, and with one line when the whole covering passes in the kernel; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wdb` at `{TIP}`; its build is current for that commit): **lane C** — new modules `Proofs/HadwigerNelson/Plane/DensityBound/BesselCert.lean` and generated `Proofs/HadwigerNelson/Plane/DensityBound/Cells/*.lean` with their lines in the build's lists and `ARCHITECTURE.md`, and the generator `tools/fs131_kdb1_cells.py` (each named in the planner's record § 5); **lane B** — proofs, private helpers and import lines only, **no statement changes, no definition changes**, in `Proofs/HadwigerNelson/Plane/DensityBound/Bessel.lean` and `BesselDefect.lean`; their `ARCHITECTURE.md` rows where a cell's state changes; your checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/idb1/`; `data/fs131/reports/{JOB}.md`. **Not** `Autocorr.lean`, `Pattern.lean`, `Window.lean`, `Plane/OneAvoidingDensity.lean` (lanes F and P), the instance modules and the theorem (lane X), any other module, the paper's certificate files (read only). Untracked build logs from the planner are in `data/fs131/kdb1/`: leave them. Nothing on `main`
  budget: {BUDGET}

Hello. Kooshi asked for the density bound to be proved here rather than assumed, and its planner has just finished:
a route with no periodic reduction and no citation to Watson's book on Bessel functions, typed to 28 leaves, priced
from three first leaves and two cuts of the certificate's arithmetic in the kernel. You take the critical lane — the
covering, whose kernel time is the longest single item — and the Bessel lemmas it reads.

## Why this job

Kooshi's word, and his rule for what goes out:

{Q(RQ,"W2: ")}
His answer of this morning, `data/fs131/REQUEST-2026-10-13.md` W6: "Yes, prove the density bound." The five-colour
chain's count reads the bound as a named hypothesis; with it proved, the count rests on nothing of anyone else's but
what the library holds.

## The statements

The two dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what the route is and what the
certificate costs:

{D1}
{D2}
The planner's hand-back as I logged it (its words in quotation marks, the rulings mine):

{item(KD)}
**Your lanes, in order.** (1) **Lane C** (the planner's record `{PR}` § 5, its row C; § 4.2 for the measured cuts; § 3.3
for the leaves `BesselCert` reads from lane B — `norm_Jc_sub_le_of_defect`, `abs_J0_le_of_le`, `abs_J0_sub_le` — which
you may read as `sorry` while you build C): the checker as a function on literal data, its soundness theorem (an
accepted cell implies the bound on its interval), the generator writing the ≈ 45 cell modules from
`{KP}proto/plan800.json` with the states as literals (`{KP}proto/lean-states.txt`; the record's measurement: literal
states 1.5 s per cell, computed states 21.8 s), the covering assembled, the tail at `T₁ = 800` by the energy. The
probe `{KP}probes/CellProbe.lean` is a measured prototype, not a statement: restructure it as you see fit. (2) **Lane B**,
the 17 leaves of `Bessel` and `BesselDefect` (§ 3.3's plan per leaf); two of them, `abs_J0_le_one` and `J0_zero`, are
already proved in scratch (`{KP}leaves/Leaves.lean`) — fold them in first; the third leaf proved there,
`autocorr_eq_zero_of_norm_eq_one`, is lane F's: leave it.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; each leaf's statement restated in one
   line beside its plan; the stored statements of `Bessel`, `BesselDefect` and `Window` dumped from the built tree
   before any edit.
2. **Lane C** (saved stages as it goes, and the one line to me when the covering passes): the checker and its
   soundness theorem, a planted corrupted cell watched being refused by the kernel; every generated cell module built
   under the slot, each module's kernel time and peak memory in a table; the generator's output reproducible from the
   plan file (run twice, identical); re-price the lane from its first two leaves and say so.
3. **Lane B** (saved stages as leaves fall); re-price it from its first two leaves.
4. **No statement and no definition changed** in `Bessel`, `BesselDefect` and `Window`, shown from the kernel's side
   against item 1's dump (a planted change watched firing); one build under the slot with no warning from your files but
   their remaining leaves'; the axioms of every public declaration of your files printed from the built tree — the
   standard three, or `sorryAx` only through named leaves — each listed, with a planted record watched showing;
   `native_decide` nowhere.
5. **Drafts for the landing**, in your record: the audit's block for your files; the kernel-cost lines for `LEAN.md`.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports; the checker's design and the data's encoding within the kernel's cost model; how
the cells are grouped into modules; the order inside each lane; another route for a leaf where the plan's does not go
through (tell me which). An unread binder of a statement in your files is dropped under item 726's word, listed and
named. Not yours: any other change to a statement or definition; `native_decide` or any trust beyond the kernel; the
files listed as not yours; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a cell module 1.5–3.1 s per cell and at most 1.8 GB
(the planner's measurement). The covering is about 43 minutes of kernel CPU in all: build its modules in batches the
slot admits, not one process at a time.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name idb1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. The certificate job may
hold 12 GiB of the slot for long stretches and the density equality's landing runs whole-library gate steps of about
5.5 GiB: on exit 75 wait ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137 (read the
system log for "oom-kill"; the planner's probe was one). Stop a process by its PID, never by matching its command line.
`/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/idb1/`. Report at once any disk, memory
or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-covering-bessel.md","w").write(b); print("ok",len(b))
