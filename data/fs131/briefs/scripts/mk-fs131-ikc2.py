exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IKC2: the class-ratio certificates' second implementer — K2's four remaining leaves, p = 11's library modules at
# nseg = 8, then form F2 at p = 19, on the first implementer's branch.
# Usage: mk-fs131-ikc2.py <item of KC13's hand-back> <item of IKC1's notice> <item of IKC1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KC,KN,KH=[int(x) for x in sys.argv[1:4]]
TREE="fs131-wnf"; BR="fs131-wc15"; JOB="FS131-IKC2"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wc14"
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if not (l.startswith("?? data/fs131/kc13/") or l.startswith("?? data/fs131/ikc1/") or l=="?? Proofs/HadwigerNelson/Arith/FibreCert3.lean.summary.json")]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
D1=Q(C,"- 2026-10-14 — **FS-66's p = 11 certificate is kernel-checked","§ Dated lines")
D2=Q(C,"- 2026-10-14 — **The p = 19 certificate does not fit the present checker's form","§ Dated lines")
D3=Q(C,"- 2026-10-14 — **M13's per-prime leaf at q ∈ {11, 19} is priced","§ Dated lines")
D4=Q(C,"- 2026-10-14 — **The certificate checker as first typed accepted","§ Dated lines")
D5=Q(C,"- 2026-10-14 — **The certificate checker is strengthened; p = 11 passes it**","§ Dated lines")
PI=W+"plans/FS131-IKC1-implementation.md"
PR=W+"plans/FS131-KC13-certificates.md"; AR=W+"Proofs/HadwigerNelson/Arith/"; KP=W+"data/fs131/kc13/"
for p in (PI,PR,AR+"FibreCert.lean",AR+"FibreCert3.lean",AR+"FibreCertSound.lean",W+"tools/fs131_kc13_gen.py",
          ROOT+"data/fs66/b1/cert-p11.json",ROOT+"data/fs66/b1/cert-p19.json",ROOT+"plans/SEARCH-QUEUE.md"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the class-ratio certificates: the checker proved sound, p = 11 into the library, p = 19 in a form that fits

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the second implementer of the class-ratio certificates for the five-colour chain — first the four leaves left in the soundness theorem of the strengthened certificate checker (positive definiteness from the PSD check, the blocks' nonnegativity, two op-sum identities), so that an accepted certificate implies the class-ratio bound on FS-66's region; then the p = 11 certificate's data and kernel checks as library modules at eight segments; then the p = 19 certificate in the form its planner priced, as far as you reach
  launch: now, in the first implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; three other jobs work in other trees (the density equality's landing, the density bound's covering, the chain's implementer) and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if the soundness theorem is false as typed or needs a hypothesis it lacks, if a kernel check needs more than 12 GiB or an hour, if K2's first two children price it above 4,000 lines, and with one line when `sum_le_of_certOK` prints the standard three and when p = 19's check passes; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wc14` at `{TIP}`; its build is current for that commit): `Proofs/HadwigerNelson/Arith/FibreCertSound.lean` — proofs and private helpers, **the conclusions of `sum_le_of_certOK` and `card_le_of_certOK` unchanged**; `Proofs/HadwigerNelson/Arith/FibreCert.lean` — the strengthened checker, which you may extend for F2's parts; any change to `certOK`'s definition only adds checks, each listed beside the proof step that needs it; `Proofs/HadwigerNelson/Arith/FibreCert3.lean`; new generated modules under `Proofs/HadwigerNelson/Arith/` for p = 11 and p = 19 (data and checks) with their lines in the build's lists and `ARCHITECTURE.md`; the converter `tools/fs131_kc13_gen.py` and your tools under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/ikc2/`; `data/fs131/reports/{JOB}.md`. **Not** `data/fs66/` (read only), any other module, the chain's `Rigidity/ClassRatio` (on another branch; its leaves K3–K5 are a later job). Untracked files from the planner and the first implementer are in `data/fs131/kc13/` and `data/fs131/ikc1/`, and a generator summary beside `FibreCert3.lean`: leave them. Nothing on `main`
  budget: {BUDGET}

Hello. The first implementer of this checker found it unsound — a certificate it accepted proved a false bound —
strengthened it so that the kernel refuses that certificate and one planted for each gap of the same kind, checked FS-66's
p = 11 certificate against the strengthened checker in about five minutes, and proved the computation half of the
soundness theorem. Four leaves are left; then the certificates come into the library.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
Under it, a certificate checked only by Python is not a result of the library; an accepted certificate is one only
once the checker is proved sound. The class-ratio module is on the chain's critical path, upstream of the count.

## The statements

The dated lines of the chain's claim list (`data/fs131/claims-NF2.md`) that say what is checked, what was wrong with
the first checker, what is left, and what it costs:

{D1}
{D2}
{D3}
{D4}
{D5}
The planner's hand-back, the counterexample and the first implementer's hand-back, as I logged them (their words in
quotation marks, the rulings mine):

{item(KC)}
{item(KN)}
{item(KH)}
**Your work, in order.** (1) **K2's four leaves** in `{AR}FibreCertSound.lean` — `psd_of_psdCheck`, `blockT_nonneg`,
`opSum_O23_eq`, `opSum_O4_eq` — each with its route in the first implementer's record `{PI}` (§ Stage 4, § Stage 5) and
priced there at 250–350, 200–300, 350–500 and 150–250 lines; the planner's record `{PR}` § 5.2 (K2's table) behind them.
(2) **K1 at p = 11** as library modules at eight segments (ruling 1 of the hand-back above), each built under the slot
and measured; `BATCH=1` for those modules alone if a segment exceeds the build's 10 GB; `cert11_ok`, and the bound at
p = 11 from `sum_le_of_certOK`. (3) **F2 at p = 19** (the planner's record § 3.2), its parts measured, a planted
corrupted entry refused in each new part. Row 24 of `plans/SEARCH-QUEUE.md` asks the Searcher whether a smaller
relaxation clears 1/4; if its answer arrives first, I will tell you, and you switch.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the four leaves restated in one line
   each beside their route; the stored statements of the three `FibreCert` modules dumped from the built tree before any
   edit.
2. **K2's four leaves** (saved stages as they fall, and the one line to me when `sum_le_of_certOK` prints the standard
   three); re-price what is left from the first two and say so.
3. **K1** (a saved stage): p = 11's modules built under the slot, each declaration's kernel time and peak memory in a
   table; `cert11_ok` from them, and the bound at p = 11 from `sum_le_of_certOK` if it is proved by then.
4. **F2** (saved stages): its parts built and measured, a planted corrupted entry watched being refused in each new
   part; `cert19_ok` if it passes.
5. **No conclusion weakened**: the soundness theorems' stored statements shown from the kernel's side against item 1's
   dump (a planted change watched firing), every change to `certOK`'s definition listed; one build under the slot with
   no warning from your files but their remaining leaves'; the axioms of every public declaration of your files printed
   from the built tree, each listed, with a planted record watched showing; `native_decide` nowhere.
6. **Drafts for the landing**, in your record: the audit's block; the kernel-cost lines for `LEAN.md`.
7. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; the checker's design within the kernel's cost model (the planner's record § 2.1 and its
cost facts are measurements, not statements); the data's encoding; how declarations are cut into modules; the order
inside each item; another route for a child where the plan's does not go through (tell me which). Not yours: a change
to what the soundness theorems conclude; `native_decide` or any trust beyond the kernel; the files listed as not
yours; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a certificate declaration up to 12 GB (the
planner's measurements, record § 2.2 and § 3.1). The kernel's caches hash a `Nat` literal by its low 64 bits (record
§ 2.1): tag the low digit of packed data.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ikc2 -- <command>`

Ask for at most 12 GiB without telling me first, and for what a declaration needs, not more. The build: `--mem 10 --cpus
4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. The density equality's landing runs whole-library
gate steps of about 5.5 GiB and the density bound's covering builds cell modules of up to 1.8 GB each: on exit 75 wait
ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137 (read the system log for
"oom-kill"). Stop a process by its PID, never by matching its command line — a `pgrep -f` pattern matches the shell
running it. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/ikc2/`. Report at once any
disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-soundness-leaves.md","w").write(b); print("ok",len(b))
