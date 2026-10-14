exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IDB2: the density bound's second implementer — lanes F (Autocorr) and P (Pattern, Window, OneAvoidingDensity's
# leaf), then lane X (the X23 instance and the theorem), on the first implementer's branch.
# Usage: mk-fs131-idb2.py <item of KDB1's hand-back> <item of IDB1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KD,KI=int(sys.argv[1]),int(sys.argv[2])
TREE="fs131-w10g"; BR="fs131-wdb2"; JOB="FS131-IDB2"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wdb1"
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if "data/fs131/kdb1/build" not in l and not l.startswith("?? data/fs131/idb1/")]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
D1=Q(C,"- 2026-10-14 — **The density bound has a route with no periodic reduction","§ Dated lines")
D2=Q(C,"- 2026-10-14 — **The certificate's analytic half is priced in the kernel","§ Dated lines")
PR=W+"plans/FS131-KDB1-density-bound.md"; PI=W+"plans/FS131-IDB1-implementation.md"; DB=W+"Proofs/HadwigerNelson/Plane/DensityBound/"; KP=W+"data/fs131/kdb1/"
PDF="/home/kooshi/source/library/pdf/arXiv-2207.14179-ambrus-csiszarik-matolcsi-varga-zsamboki-density-planar-sets.pdf"
for p in (PR,PI,PDF,DB+"Autocorr.lean",DB+"Pattern.lean",DB+"Window.lean",DB+"Cells/Covering.lean",W+"Proofs/HadwigerNelson/Plane/OneAvoidingDensity.lean",KP+"leaves/Leaves.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the density bound: the Fourier side and the window proved, then the certificate's instance and the theorem

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-14. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the density bound's second implementer — lane F, the Fourier side (`Autocorr`: the autocorrelation of a window and its positive definiteness by Gaussian regularization), then lane P, the patterns and the window (`Pattern`, `Window`, and the one leaf of `Plane/OneAvoidingDensity`), then lane X, the paper's certificate as a Lean instance and the theorem `m₁(ℝ²) ≤ 0.2470` itself, as far as you reach
  launch: now, in the first implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; four other jobs share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if the first two leaves of a lane price it above twice the planner's lines, if a kernel check needs more than 12 GiB or an hour, if the paper's eq. (22) or Theorem 1 differs in any respect from what the library states, and with one line when `Plane.OneAvoidingDensityBound` is proved; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wdb1` at `{TIP}`; its build is current for that commit — never switch this tree to another line: its 46 cell modules cost 41 minutes of kernel time to rebuild): **proofs, private helpers and import lines only — no statement changes, no definition changes** in `Proofs/HadwigerNelson/Plane/DensityBound/Autocorr.lean` (lane F), `Pattern.lean` and `Window.lean` (lane P), and in `Proofs/HadwigerNelson/Plane/OneAvoidingDensity.lean` the one proof of `upperDensity_le_of_oneAvoidingDensityBound` (approved, item {KD} ruling 1; the statements there are the paper's, unchanged); lane X's new modules `Proofs/HadwigerNelson/Plane/DensityBound/X23*.lean` and `Theorem.lean` with their generator `tools/fs131_kdb1_x23.py` (each named in the planner's record § 5) and their lines in the build's lists and `ARCHITECTURE.md`; rows where a cell's state changes; your checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/idb2/`; `data/fs131/reports/{JOB}.md`. **Not** `Bessel`, `BesselDefect`, `BesselCert`, `BesselCheck` or `Cells/*` (proved), any other module, the paper's certificate files (read only). Untracked logs of the earlier jobs in `data/fs131/kdb1/` and `data/fs131/idb1/`: leave them. Nothing on `main`
  budget: {BUDGET}

Hello. Kooshi asked for the density bound to be proved here. Its planner found a route with no periodic reduction; its
first implementer checked the Bessel covering in the kernel — the paper's function stays above 0.99994 on all of
`[0, ∞)` — and proved the Bessel lemmas. Three lanes are left. You take them in order.

## Why this job

Kooshi's word, and his rule for what goes out:

{Q(RQ,"W2: ")}
His answer of this morning, `data/fs131/REQUEST-2026-10-13.md` W6: "Yes, prove the density bound." The five-colour
chain's count reads the bound through `upperDensity_le_of_oneAvoidingDensityBound`, one of the four leaves its proof now
waits on.

## The statements

The two dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what the route is and what the
certificate costs:

{D1}
{D2}
The planner's and the first implementer's hand-backs, as I logged them (their words in quotation marks, the rulings mine):

{item(KD)}
{item(KI)}
**Your lanes, in order** (the planner's record `{PR}` § 5 for the lanes, § 3.3 for the plan per leaf): (1) **F** —
`Autocorr` (5 leaves; its first, `autocorr_eq_zero_of_norm_eq_one`, is proved in scratch in `{KP}leaves/Leaves.lean` —
fold it in). (2) **P** — `Pattern`, `Window` and `upperDensity_le_of_oneAvoidingDensityBound`. (3) **X** — the data
generator, edges, congruences, distances and the atom check (≈ 75 theorems of ≤ 100 k mask tests each), then `X23_valid`,
`X23_phi` (from `BesselCert.Cells.phiApprox_ge` as the first implementer stated it — its record `{PI}`, and item {KI}'s
question for lane X), `X23_ratio`, and the theorem. **Before lane X proves anything, read the paper's eq. (22) and
Theorem 1 yourself** in `{PDF}` and record, word for word, how the library's `ϕ`, `µ`, `w₀`, `w₁`, `w₂` and the bound
0.2470 match them. Re-price each lane from its first two leaves.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; each leaf's statement restated in one
   line beside its plan; the stored statements of your files dumped from the built tree before any edit.
2. **F, then P** (saved stages as leaves fall); re-priced from their first two leaves.
3. **X** (saved stages): the paper read against the library first; each generated module's kernel time and peak memory in
   a table; a planted corrupted entry refused in each new checker; the generator's output reproducible (run twice,
   identical); and the one line to me when `Plane.OneAvoidingDensityBound` is proved.
4. **No statement and no definition changed**, shown from the kernel's side against item 1's dump (a planted change
   watched firing); one build under the slot with no warning from your files but their remaining leaves'; the axioms of
   every public declaration of your files printed from the built tree, each listed, with a planted record watched
   showing; `native_decide` nowhere.
5. **Drafts for the landing**, in your record: the audit's block; the kernel-cost lines for `LEAN.md`; bibliography lines.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports; the order inside each lane; the checkers' design and the data's encoding within the
kernel's cost model (a checker in a core-only module, its soundness in a second, the generated modules importing only the
first, as the first implementer found); another route for a leaf where the plan's does not go through (tell me which).
An unread binder of a statement in your files is dropped under item 726's word, listed and named. Not yours: any other
change to a statement or definition; `native_decide` or any trust beyond the kernel; the files listed as not yours; the
landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a core-only certificate module 1.6–2.4 GB (the first
implementer's measurement); the atom check's theorems at ≤ 100 k tests each about 15 s and 2.2 GB (the planner's).

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name idb2 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`; do not edit a file a running build will compile. The certificate job may hold up to 10 GiB of the slot
for long stretches: on exit 75 wait ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not
137 (read the system log for "oom-kill"). Stop a process by its PID, never by matching its command line — a `pgrep -f`
pattern matches the shell running it. `/tmp` is wiped at power-off: anything your record cites lives under
`data/fs131/idb2/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-fourier-window-x23.md","w").write(b); print("ok",len(b))
