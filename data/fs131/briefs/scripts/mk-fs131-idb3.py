exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IDB3: the density bound's third implementer — lane X (the X23 certificate as a Lean instance, its checks, and the
# theorem Plane.OneAvoidingDensityBound), on the second implementer's branch.
# Usage: mk-fs131-idb3.py <item of KDB1's hand-back> <item of IDB1's hand-back> <item of IDB2's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KD,KI,K2=[int(x) for x in sys.argv[1:4]]
TREE="fs131-w10g"; BR="fs131-wdb3"; JOB="FS131-IDB3"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wdb2"
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if "data/fs131/kdb1/build" not in l and not l.startswith("?? data/fs131/idb1/") and not l.startswith("?? data/fs131/idb2/")]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
D1=Q(C,"- 2026-10-14 — **The density bound has a route with no periodic reduction","§ Dated lines")
D2=Q(C,"- 2026-10-14 — **The certificate's analytic half is priced in the kernel","§ Dated lines")
PR=W+"plans/FS131-KDB1-density-bound.md"; PI=W+"plans/FS131-IDB1-implementation.md"; P2=W+"plans/FS131-IDB2-implementation.md"; DB=W+"Proofs/HadwigerNelson/Plane/DensityBound/"; KP=W+"data/fs131/kdb1/"
PDF="/home/kooshi/source/library/pdf/arXiv-2207.14179-ambrus-csiszarik-matolcsi-varga-zsamboki-density-planar-sets.pdf"
for p in (PR,PI,P2,PDF,DB+"Autocorr.lean",DB+"Pattern.lean",DB+"Window.lean",DB+"Cells/Covering.lean",W+"Proofs/HadwigerNelson/Plane/OneAvoidingDensity.lean",KP+"leaves/Leaves.lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the density bound: the paper's certificate as a Lean instance, and `m₁(ℝ²) ≤ 0.2470` proved

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-14. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the density bound's third implementer — lane X: `[AmbrusEtAl2023]`'s dual certificate as Lean data (the 27 points, their distances, the 2,321 congruences, the atoms with no two points at distance one), its validity checked in the kernel by a core-only checker with its soundness proved, the identification with the Bessel covering already proved, and the theorem `Plane.OneAvoidingDensityBound` itself
  launch: now, in the second implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; three other jobs share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a check refuses the paper's certificate, if a kernel check needs more than 12 GiB or an hour, if the lane prices above twice its plan from its first two parts, and with one line when `Plane.OneAvoidingDensityBound` is proved; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wdb2` at `{TIP}`; its build is current for that commit — never switch this tree to another line): lane X's new modules `Proofs/HadwigerNelson/Plane/DensityBound/X23*.lean` and `Theorem.lean` (or the module names the last implementer's design gives), with the generator `tools/fs131_kdb1_x23.py`, their lines in the build's lists and `ARCHITECTURE.md`; your checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/idb3/`; `data/fs131/reports/{JOB}.md`. **Not** any existing module's text (all proved), the paper's certificate files (read only). Untracked logs of the earlier jobs in `data/fs131/kdb1/`, `idb1/`, `idb2/`: leave them. Nothing on `main`
  budget: {BUDGET}

Hello. Every lemma the density bound needs is proved but the certificate's own data. The last implementer read the
paper against the library line by line — they match, the library asking for less in three places — designed lane X, and
checked two of its identities exactly in Python as planning instruments. You build it in the kernel.

## Why this job

Kooshi's word, and his rule for what goes out:

{Q(RQ,"W2: ")}
His answer of this morning, `data/fs131/REQUEST-2026-10-13.md` W6: "Yes, prove the density bound." With lane X the bound is
a kernel theorem, and the chain's count reads it with no outside hypothesis.

## The statements

The two dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what the route is and what the
certificate costs:

{D1}
{D2}
The planner's and the two implementers' hand-backs, as I logged them (their words in quotation marks, the rulings mine;
item {K2}'s ruling 1 fixes ν = 10⁻⁵, the paper's value):

{item(KD)}
{item(KI)}
{item(K2)}
**Your work** — the last implementer's design, `{P2}` § 5.2: five modules with a core-only checker (the first implementer's
rule: the checker in a module importing nothing, its soundness in a second, the generated data modules importing only the
first), about 900–1,400 lines plus the generator, about 12 minutes of kernel time; the atom check in theorems of ≤ 100 k
mask tests each (the planner's record `{PR}` § 4.2); `X23_valid`, `X23_phi` from `BesselCert.Cells.phiApprox_ge` through the
identification the last implementer checked exactly (item {KI}'s question), `X23_ratio`, and the theorem by
`DualCert.oneAvoidingDensityBound_of`. The paper is `{PDF}`; the last implementer's reading of eq. (22) and Theorem 1 is its
record § Stage 4 — restate it in yours before generating the data.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; lane X's parts restated beside their
   design; the certificate files' checksums recorded.
2. **The checker and its soundness** (a saved stage): a planted corrupted entry refused by the kernel in each check (a
   wrong distance, a missing congruence, an atom with negative value); the unplanted certificate accepted.
3. **The data and the theorem** (saved stages): each generated module's kernel time and peak memory in a table; the
   generator's output reproducible (run twice, identical); `Plane.OneAvoidingDensityBound` proved, and the one line to me.
4. **No statement and no definition changed** in the existing modules, shown from the kernel's side; one build under the
   slot with no warning from your files; the axioms of every public declaration of your files and of the theorem printed
   from the built tree, each listed, with a planted record watched showing; `native_decide` nowhere.
5. **Drafts for the landing**, in your record: the audit's block for the whole density bound; the kernel-cost lines for
   `LEAN.md`; the bibliography lines (`[AmbrusEtAl2023]`, `[KMOR2016]`, with p. 18's sign of `J₀′` noted).
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; the checker's design and the data's encoding within the kernel's cost model; how the atom check is cut into
theorems; another route for a part where the design does not go through (tell me which). Not yours: a change to an
existing statement or definition; ν (fixed at 10⁻⁵ unless a kernel margin fails — then message me); `native_decide` or
any trust beyond the kernel; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** A core-only certificate module is 1.6–2.4 GB; an atom-check theorem of ≤ 100 k tests about 15 s and 2.2 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name idb3 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`; do not edit a file a running build will compile. The certificate job may hold up to 10 GiB of the slot
for long stretches: on exit 75 wait ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not
137. Stop a process by its PID, never by matching its command line — a `pgrep -f` pattern matches the shell running it.
`/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/idb3/`. Report at once any disk, memory
or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-x23-theorem.md","w").write(b); print("ok",len(b))
