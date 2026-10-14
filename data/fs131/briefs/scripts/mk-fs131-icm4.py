exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-ICM4: M13's dyadic certificates — the generic binary-field bridge, U_Q four-colourable at Q in {4, 8, 16, 32},
# lambda_min(U_64) >= -15; then ICM2's odd Lemma P folded onto SqZeroInvT.
# Usage: mk-fs131-icm4.py <item of ICM2's hand-back> <item of ICM3's hand-back> <item of KM15's notice>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KL,KH,KM=[int(x) for x in sys.argv[1:4]]
TREE="fs131-wch"; BR="fs131-wcm4"; JOB="FS131-ICM4"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wcm3"
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if not l.startswith("?? data/fs131/")]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
DC=Q(C,"- 2026-10-14 — **The count is typed**","§ Dated lines")
RG=W+"Proofs/HadwigerNelson/"; PH=W+"plans/FS131-ICM3-implementation.md"; PL=W+"plans/FS131-ICM2-implementation.md"
X26="plans/FS100-X26B-derivation.md"; X23="plans/FS100-X23D-derivation.md"
for p in (PH,PL,RG+"Rigidity/ClassRatio.lean",RG+"Arith/Floor128.lean",RG+"Arith/TargetFloors.lean",RG+"Arith/CircleCos.lean",ROOT+X26,ROOT+X23): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: M13's two dyadic certificates

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the implementer of M13's last two leaves on this line — `colorable_four_dyadic_small` (the level-one target at a prime above 2 is four-colourable at residue sizes 4, 8, 16 and 32) and `charSum_64_ge` (its least eigenvalue at 64 is at least −15) — through a generic form of `Floor128`'s binary-field bridge and five certificates; then, if the budget remains, the odd-characteristic Lemma P folded onto the general one so that it is proved once
  launch: now, in the last implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; three other jobs share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if a certificate fails in exact arithmetic, if the bridge's first part prices it above 1,200 lines, and with one line when `ratioAtMost_of_five_le_chromaticNumber` rests on `ratioAtMost_cert` alone; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wcm3` at `{TIP}`; its build is current for that commit, build 4): **proofs, private helpers and import lines only — no statement changes, no definition changes** in `Proofs/HadwigerNelson/Rigidity/ClassRatio.lean`; new modules under `Proofs/HadwigerNelson/Arith/` for the bridge and the certificates, with their lines in the build's lists and `ARCHITECTURE.md`; `Proofs/HadwigerNelson/Arith/Floor128.lean` only to make it read the generic bridge (its public statements unchanged), if that is shorter than leaving it; your generators and checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/icm4/`; `data/fs131/reports/{JOB}.md`. **Not** the count's modules, `Arith/FibreCert*` (another line), `Arith/CircleCos.lean` (proved), any module under `Outside/`, the declared `StandingFive.kloosterman_bound`, the declared printed theorem. Untracked files of earlier jobs under `data/fs131/`: leave them. Nothing on `main`
  budget: {BUDGET}

Hello. M13 — the step of the five-colour chain that turns "every prime's finite plane needs five colours" into a bound
on how large a colour class can be — is proved on this line but for three private leaves. One is the certificate link
at residue sizes 11 and 19, which closes when the lines are joined. You prove the other two, both at primes above 2.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The gate takes no `sorry`, so the chain cannot land on `main` until these two leaves are proved.

## The statements

The dated line of the chain's claim list (`data/fs131/claims-NF2.md`) that says what the count reads from M13:

{DC}
The last two hand-backs on this line and the instances planner's notice, as I logged them (their words in quotation
marks, the rulings mine):

{item(KL)}
{item(KH)}
{item(KM)}
**Your work, in order** (the last implementer's record `{PH}` § Stage 5, "What is left of the dyadic branch", and its
§ Stage 4 for the dyadic glue; the two leaves at `{RG}Rigidity/ClassRatio.lean` ll. 1649 and 1657): (1) **the bridge** —
a primitive polynomial of degree `n` over `𝔽₂` gives, in every field of `2^n` elements, a root whose powers are the
non-zero elements; `{RG}Arith/Floor128.lean` (661 lines) does this for one polynomial, and the generic form is priced
at 400–600 lines. (2) **The five certificates**, each with its generator: two coordinate functionals off the unit circle
for the four-colourings at degrees 4, 6, 8 and 10; counters at most 40 over the classes modulo 63 for the spectrum at
degree 12; about 60–120 lines each. The exact values they certify are X26B-T1's (`{X26}`) and X23D § 2.3's (`{X23}`),
at [tools]. (3) **If the budget remains:** the odd-characteristic Lemma P of the record `{PL}` folded onto
`SqZeroInvT` with `θ = ι`, its private duplicate deleted and its readers redirected, no public statement moved.
Re-price each from its first part and say so.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the two leaves printed from the kernel
   and restated beside their routes; the stored statements of your files dumped from the built tree before any edit.
2. **The bridge** (a saved stage), with `Floor128`'s instance read through it or left as it is (say which and why).
3. **The certificates** (saved stages as they fall), each refusing a planted corrupted entry; the one line to me.
4. **No statement and no definition changed** but the new modules', shown from the kernel's side against item 1's dump
   (a planted change watched firing); one build under the slot with no warning from your files but `ratioAtMost_cert`'s;
   the axioms of every public declaration of your files, of `ratioAtMost_of_five_le_chromaticNumber`, of
   `tca_of_five_le_localBound` and of `ratioAtMost_of_two_notMem` printed from the built tree, each listed, with a planted
   record watched showing; the guarded lint (`lake lint --no-build -- --no-build --trace`) with no finding in your files.
5. **Drafts for the landing**, in your record: the audit's block; any `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued. Stopping at a saved stage with a
   certificate left, named with its route, is a good report.

## What is yours to decide

The proofs; private helpers; the new modules and their names; imports; the order inside each part; the certificate
encodings; another route for a leaf where the recorded one does not go through (tell me which). An unread binder of a
statement in your files is dropped, listed and named. Not yours: any other change to a statement or definition; a new
declared axiom; the files listed as not yours; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 316 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wcm3` at build 4. One file through `lake env lean`: 3 to 24
seconds, 3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name icm4 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`; do not edit a file a running build will compile. The certificate job at size 19 can hold up to 10 GiB of
the slot for long stretches: on exit 75 wait ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit
143, not 137. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your
record cites lives under `data/fs131/icm4/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your branch and do not push**; I copy the branches to a
local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-dyadic-certs.md","w").write(b); print("ok",len(b))
