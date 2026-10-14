exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KC13: the chain's eleventh planner — M13's per-prime leaf, and the measurement owed before its price: the cost of
# checking FS-66's exact sum-of-squares certificates (p = 11, 19) in the kernel; the exact spectra at 23 and 31.
# Usage: mk-fs131-kc13.py <item of KR1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KR=int(sys.argv[1])
TREE="fs131-wnf"; BR="fs131-wc13"; JOB="FS131-KC13"; W=WT+TREE+"/"; WC=WT+"fs131-wch/"
fresh(JOB)
assert sh("git","-C",W,"branch","--show-current")==BR and sh("git","-C",W,"status","--porcelain")=="" and os.path.isdir(W+".lake/build")
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
NC=Q(C,"NF2-NC: ","§ Not claimed")
DC=Q(C,"- 2026-10-14 — **The count reads one constant**","§ Dated lines")
PR=WC+"plans/FS131-KR1-chain-map.md"; CR=WC+"Proofs/HadwigerNelson/Rigidity/ClassRatio.lean"
for p in (PR,CR,ROOT+"data/fs66/b1/cert-p11.json",ROOT+"data/fs66/b1/cert-p19.json",ROOT+"LEAN.md"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: what it costs the kernel to check the class-ratio certificates, and the per-prime leaf planned

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the eleventh planner on this chain
  role: the kernel lane's planner for module M13's hard leaf — at each stable prime, one ratio bound below one quarter for every set with no two adjacent points in every level's target — and the measurement the chain's map left owed before that leaf has a price: what it costs this kernel to check FS-66's exact integer sum-of-squares certificates at the residue sizes 11 and 19, where the eigenvalue bound fails, and the exact certificates needed at 23 and 31, where it clears by a hair
  launch: now, in a tree whose last job is long finished, on a branch already cut from `main` (at `{TIP}`) with `main`'s compiled library copied in from the reference tree; three other jobs run in other trees and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** with the first measurement (the smaller certificate's check: wall time, peak memory, and the form that worked), if a check needs more than 16 GiB or more than an hour, and for a statement defect anywhere in the chain; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-certificates.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on its branch `{BR}` (checked out, cut from `main`; its compiled library is `main`'s, copied from `fs131-wrc` by checksum-identical `cp -a`): new modules under `Proofs/HadwigerNelson/Arith/` (the certificate checker, its spec examples, the certificates as Lean literals or data files the checker reads) with their lines in the build's lists and `ARCHITECTURE.md`; your tools under `tools/` named for this job; `plans/{JOB}-certificates.md`; `data/fs131/kc13/`; `data/fs131/reports/{JOB}.md`. **Not** any existing module's statements, `data/fs66/` (read only), the declared theorems. Nothing on `main`
  budget: {BUDGET}; save a stage (a commit on your branch) after the readback, after each measurement, and after the leaf's plan

Hello. The chain's map priced every module but one cost it could not price: the class-ratio module needs, at two
residue sizes, a ratio bound that rests on exact integer certificates this project found and checked with a frozen
Python checker, never in the kernel. One of them is 0.7 MB, the other 10.4 MB. Whether the kernel checks them in
minutes or days decides whether the chain lands this week. You measure it.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
Under it, a certificate checked only by Python is not a result of the library. The chain's map names this measurement
as owed before the module's price, and the module is on the chain's critical path, upstream of the count.

## The statements

What the chain does not claim, and the dated line that says what the count reads from this module:

{NC}
{DC}
The map planner's hand-back as I logged it (its words in quotation marks, the rulings mine):

{item(KR)}
Where everything is: the map planner's record `{PR}` § 2.6 (M13 read: the route by residue size, what Hoffman's bound
gives at each, and at (d) the two certificates' sizes and form — "second-level moment relaxation, translation-Fourier
blocks"); the typed module `{CR}` (its per-prime leaf `ratioAtMost_of_five_le_chromaticNumber`, on the map planner's
branch); the certificates `data/fs66/b1/cert-p11.json` and `data/fs66/b1/cert-p19.json` with their checker and controls in
the same folder and FS-66's records under `plans/` (search them by name); `LEAN.md` § The kernel's cost model (literals,
not built tables; GMP-accelerated `Nat`) and the earlier certificate checkers this library holds (the rung-B LRAT checker,
`Floor128`).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the certificates' form read from FS-66's
   records and its Python checker — what the certificate asserts, about which matrix, and what the checker computes; the
   inequality it certifies stated in words and in the form the per-prime leaf reads.
2. **The smaller certificate checked in the kernel** (a saved stage, and the message to me): a Lean checker whose
   soundness theorem says that an accepted certificate implies the inequality (a theorem, not a `native_decide`), the
   certificate supplied as literals, the check run by `decide` or kernel reduction under the slot — its wall time, peak
   memory and the form that worked, with a planted corrupted certificate watched being refused.
3. **The larger certificate measured or extrapolated** (a saved stage): checked if the first measurement says it fits
   in an hour and 16 GiB; otherwise its cost extrapolated from the first and from a cut of it, with the form that would
   reduce it (block structure, the translation-Fourier symmetry, a smaller relaxation).
4. **The exact spectra at 23 and 31** priced in words: what exact certificate is needed there, and whether the same
   checker serves.
5. **The per-prime leaf planned**: its statement read against the map planner's route; a plan per leaf with the
   certificate checks as leaves; its price in lines and in kernel minutes.
6. **Drafts**: dated lines for the claim list; `LEAN.md` lines for the kernel's cost model; bibliography lines for every
   source you read or cite.
7. The report in the standing rules' form.

## What is yours to decide

The checker's design within the kernel's cost model; how the certificate is encoded; whether to cut a certificate for a
first measurement. Not yours: `native_decide` or any trust beyond the kernel in a checker meant for the library; a
change to a typed statement; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 321 GB of disk free.** One file through `lake env lean`: 3 to
24 seconds and 3.6 GB for ordinary files; a certificate check may take far more — run it under the slot with a time
limit and checkpoint the measurement. A build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name kc13 -- <command>`

Three other jobs share the slot; ask for no more than 12 GiB without telling me first. On exit 75 wait ten minutes and
retry. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your record
cites lives under `data/fs131/kc13/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-certificates.md","w").write(b); print("ok",len(b))
