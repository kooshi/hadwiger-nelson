exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-ITK1: the chain's implementer — lane T's last lane (T-K, the kernel and the surjectivity of the model's map),
# then the zero-entropy side's second half (M8b's five lanes) over the adelic model.
# Usage: mk-fs131-itk1.py <item of KT1's hand-back> <item of K8B1's hand-back> <item of ITT1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KT,KB,KI=[int(x) for x in sys.argv[1:4]]
TREE="fs131-wq1"; BR="fs131-wt2"; JOB="FS131-ITK1"; W=WT+TREE+"/"; WC=WT+"fs131-wch/"
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wt1"
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if not any(x in l for x in ("iq1/stmt","data/fs131/idg1/","data/fs131/ig1/","data/fs131/ip23/","data/fs131/itt1/"))]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
DB=Q(C,"- 2026-10-14 — **M8b's parts 2–4 are typed over `TateModel F`","§ Dated lines")
DS=Q(C,"- 2026-10-14 — **EF_F⁺'s Steps 6–7 on a shorter route","§ Dated lines")
PT=WC+"plans/FS131-KT1-tate.md"; PB=WC+"plans/FS131-K8B1-zero-entropy-second.md"; PI=W+"plans/FS131-ITT1-implementation.md"
RG=W+"Proofs/HadwigerNelson/Rigidity/"
for p in (PT,PB,PI,RG+"TateKernel.lean",RG+"PlaceSizes.lean",RG+"Multipliers.lean",RG+"ThinBoxes.lean",RG+"GlobalPoint.lean",RG+"WanderingShells.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: the adelic model finished, then the zero-entropy side's second half proved

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the chain's implementer — lane T's last lane (the kernel of the adelic model's map, its surjectivity and its cocompactness, four leaves the existence of the model waits on), then the five lanes of the zero-entropy side's second half (place sizes, multipliers, thin boxes with Lemma 3.1′, the global point, the wandering shells) over the model, as far as you reach
  launch: now, in the last implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; four other jobs run in other trees (the port's landing, the class-ratio certificates, the density bound's planner) and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, and with one line when `exists_tateModel` prints the standard three; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wt1` at `{TIP}`; its build is current for that commit): **proofs, private helpers and import lines only — no statement changes, no definition changes** — in `Proofs/HadwigerNelson/Rigidity/TateKernel.lean`, `PlaceSizes.lean`, `Multipliers.lean`, `ThinBoxes.lean`, `GlobalPoint.lean` and `WanderingShells.lean`; their `ARCHITECTURE.md` rows where a cell's state changes; your checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/itk1/`; `data/fs131/reports/{JOB}.md`. **Not** `ZeroEntropyClosed.lean` (a composition, proved), `ChainAtTA.lean`, `RingScope.lean`'s `unitRing_eq_stableIntegers` (off the path), any module under `Outside/`, the declared printed theorem. Untracked files from older jobs are in this tree (`data/fs131/iq1/stmt/`, plain-text dumps under `data/fs131/idg1/`, `ig1/`, `ip23/`, `itt1/`): leave them. Nothing on `main`
  budget: {BUDGET}

Hello. The adelic model the zero-entropy side reads is one lane from done: its last implementer proved twenty-nine
leaves and left four, all in the kernel of the model's map. The zero-entropy side's second half is typed over it, with
its shells on a short route the last planner found. You finish the model and prove the second half.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
With these lanes proved, the chain's zero-entropy half — every zero-entropy rotation-invariant measure is carried by the
smaller set — holds over every real number field on the standard three, if its planner's reading holds in the kernel.

## The statements

The two dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what the second half now is:

{DB}
{DS}
The three hand-backs behind this job, as I logged them (their words in quotation marks, the rulings mine):

{item(KT)}
{item(KB)}
{item(KI)}
**Your leaves**, in order: (1) **T-K**, the nine leaves of `{RG}TateKernel.lean` (the plan: `{PT}` § 4.2–4.3; the last
implementer's record `{PI}` names the four `exists_tateModel` waits on). (2) **The five M8b lanes** (`{PB}` § 6.1, a plan
per leaf in its §§ 2–4): K8-A `PlaceSizes`, K8-M `Multipliers`, K8-B `ThinBoxes`, K8-G `GlobalPoint`, K8-S `WanderingShells`,
in the order § 6.1 gives. The last implementer's record is the worked pattern for this chain's files.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; each leaf's statement restated in one
   line beside its plan; the stored statements of your six files dumped from the built tree before any edit.
2. **T-K** (a saved stage, and the one line to me when `exists_tateModel` prints the standard three).
3. **The M8b lanes** (saved stages as leaves fall); re-price what is left from the first two leaves of each and say so.
4. **No statement and no definition changed**, shown from the kernel's side against item 1's dump (a planted change
   watched firing); one build under the slot with no warning from your files but their remaining leaves'; the axioms of
   every public declaration of your files printed from the built tree, each listed, with a planted record watched showing;
   and whether `zeroEntropyCarried_of_numberField` now prints the standard three.
5. **Drafts for the landing**, in your record: the audit's block; the models; any `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports; the order inside the M8b lanes; another route for a leaf where the plan's does not
go through (tell me which). An unread binder of a statement in your files is dropped under item 726's word, listed and
named. Not yours: any other change to a statement or definition; the files listed as not yours; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 316 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with small modules stale about 7 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name itk1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. The certificate job may hold
12 GiB of the slot for long stretches: on exit 75 wait ten minutes and retry. Stop a process by its PID, never by matching
its command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/itk1/`. Report at once
any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-tate-m8b.md","w").write(b); print("ok",len(b))
