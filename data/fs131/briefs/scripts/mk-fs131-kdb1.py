exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KDB1: the planner of the density bound's formalization — [AmbrusEtAl2023] Theorem 1, m₁(ℝ²) ≤ 0.2470, by Kooshi's
# word (W6: "Yes, prove the density bound.").
# Usage: mk-fs131-kdb1.py <item of W6> <item of the density-bound ruling> <item of KR1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KW,KD,KR=[int(x) for x in sys.argv[1:4]]
TREE="fs131-w10g"; BR="fs131-wdb"; JOB="FS131-KDB1"; W=WT+TREE+"/"; WC=WT+"fs131-wch/"
fresh(JOB)
assert sh("git","-C",W,"branch","--show-current")==BR and sh("git","-C",W,"status","--porcelain")=="" and os.path.isdir(W+".lake/build")
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD"); WKR=sh("git","-C",ROOT,"rev-parse","--short=9","fs131-wkr")
RQ="data/fs131/REQUEST-2026-10-13.md"
PDF="/home/kooshi/source/library/pdf/arXiv-2207.14179-ambrus-csiszarik-matolcsi-varga-zsamboki-density-planar-sets.pdf"
KM="/home/kooshi/source/library/pdf/arXiv-1501.00168-keleti-matolcsi-oliveira-ruzsa-planar-sets-avoiding-unit-distances.pdf"
PR=WC+"plans/FS131-KR1-chain-map.md"; OA=WC+"Proofs/HadwigerNelson/Plane/OneAvoidingDensity.lean"
for p in (PDF,KM,PR,OA,ROOT+"plans/FS100-KT1-ambrus-ball.md",ROOT+"plans/FS100-K-kernel-47.md"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the density bound `m₁(ℝ²) ≤ 0.2470`, planned for the kernel to its leaves and priced

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-14. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: the kernel lane's planner for one published, computer-assisted theorem the five-colour chain reads — `[AmbrusEtAl2023]` Theorem 1, every Lebesgue-measurable planar set with no two points at distance one has upper density at most 0.2470 — typed as the library's named hypothesis `Plane.OneAvoidingDensityBound`, now to be proved: its route chosen, its statements typed to their leaves, each classical input and the certificate's arithmetic priced from first leaves written in scratch
  launch: now, in a tree whose last job is long finished, on a branch already cut from `main` (at `{TIP}`) with `main`'s compiled library copied in from the reference tree; four other jobs run in other trees and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if the paper's statement differs from the typed one in any respect, if a classical input (Bessel functions, positive-definite functions, the reduction to periodic sets) is priced over two thousand lines from its first leaf, and if the certificate's arithmetic looks out of the kernel's reach (more than an hour or 16 GiB for a cut of it); the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-density-bound.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on its branch `{BR}` (checked out, cut from `main`; its compiled library is `main`'s, copied from `fs131-wrc`): first, `Proofs/HadwigerNelson/Plane/OneAvoidingDensity.lean` taken from branch `fs131-wkr` (at `{WKR}`) by `git checkout fs131-wkr -- <that path>`, **text unchanged**, with its line in the build's lists and its row in `ARCHITECTURE.md`; then new modules under `Proofs/HadwigerNelson/Plane/` or `Proofs/HadwigerNelson/Analysis/` for the proof, with their lines and rows; your tools under `tools/` named for this job; `plans/{JOB}-density-bound.md`; `data/fs131/kdb1/`; `data/fs131/reports/{JOB}.md`. **Not** the statement of `OneAvoidingDensityBound` (it is the paper's, read aloud by its typist; a change comes to me), any other existing module's statements, the paper's certificate files (read only), the declared theorems. Nothing on `main`
  budget: {BUDGET}; save a stage (a commit on your branch) after the readback, after the route's choice, after each part's statements and after each priced first leaf

Hello. The five-colour chain's count reads one published bound: no measurable planar set avoiding distance one has
upper density above 0.2470. Its authors proved it with a computer-assisted Fourier argument, and this project already
re-checked their certificate outside the kernel, exactly and in ball arithmetic. Kooshi has decided it is to be proved
here, not assumed. You plan it.

## Why this job

Kooshi's word, and his rule for what goes out:

{Q(RQ,"W2: ")}
His answer this morning, `data/fs131/REQUEST-2026-10-13.md` W6: "Yes, prove the density bound." The chain's map priced
the formalization at three to six agent-weeks from Mathlib's coverage alone; this project's measured rate is about 900
lines of Lean per active hour, and implementers have been coming in at half to three quarters of their planners' lines.
A price from first leaves is what decides how it is staffed.

## The statements

My rulings on the bound, the map planner's hand-back, and Kooshi's answer as I logged them (their words in quotation
marks, the rulings mine):

{item(KD)}
{item(KR)}
{item(KW)}
**The statement to prove** is the definition `Plane.OneAvoidingDensityBound` in `{OA}` (on branch `fs131-wkr`; it
comes onto your branch by your first commit), read aloud there against the paper and the subject of its four drafted
items in the map planner's record `{PR}` § 6.3. Its proof is the theorem `Plane.oneAvoidingDensityBound :
OneAvoidingDensityBound` (or your name) — the statement unchanged.

Where everything is: the paper, held and read in full by an earlier job, `{PDF}` (Theorem 1 p. 4; the definitions p.
2 and eq. (1); its §§ 2–5: the reduction, Lemma 1's configuration, the Fourier side and its function `ϕ`); the earlier
bound it builds on, `{KM}` (`[KMOR2016]`; Lemma 3.2 (1) is the first leaf the map planner named); this project's checks of
the certificate — `plans/FS100-KT1-ambrus-ball.md` (J49: the obligation H4 in ball arithmetic, its covering of `[0, 10⁴]`
and its Lipschitz enclosures) and the records it cites for J26 (the exact checks H1–H3 and H6); `plans/FS100-K-kernel-47.md`
(row X-AMB: what a kernel certificate would need); the map planner's record `{PR}` § 2.5 (what Mathlib lacks: J₀,
positive-definite functions on the plane). `LEAN.md` § The kernel's cost model.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; your first commit (the statement module,
   unchanged) built; the paper's proof restated in your record as a chain of steps, each with its page and what it reads.
2. **The route** (a saved stage): for each step, what Mathlib at the pin holds (searched by name), what must be built,
   and the choice among routes where there are two — the Fourier side in the plane (autocorrelation, positive
   definiteness, the radial reduction), the Bessel function `J₀` (a definition and the bounds the paper's `ϕ` needs:
   power series, integral representation, or the enclosures J49 used), the reduction from upper density to periodic sets,
   Lemma 1's inclusion–exclusion over its configuration, and the certificate's arithmetic in the kernel (exact rationals,
   interval or ball arithmetic as literals; no `native_decide`).
3. **The statements typed** (saved stages): with `sorry` at the leaves only, each read aloud against the paper, each with a
   model, a plan per leaf naming Mathlib's declarations; the composition proving `OneAvoidingDensityBound` from the parts.
   **The domain pass as a fresh skill invocation on every new definition, and the obligation pass on every new statement.**
4. **Priced from first leaves** (written in scratch, elaborated, measured): at least KMOR's Lemma 3.2 (1), one `J₀` bound
   of the kind `ϕ` needs, and a cut of the certificate's arithmetic in the kernel — its time and memory, extrapolated to the
   whole covering.
5. **Lanes**, sharing no file, each with its measured price and what it waits on.
6. **Drafts**: dated lines for the chain's claim list (`data/fs131/claims-NF2.md`); bibliography lines for every source you
   read or cite; `LEAN.md` lines.
7. The report in the standing rules' form.

## What is yours to decide

The route; how the modules are cut; how the certificate is encoded; the order after item 1. Not yours: the statement;
`native_decide` or any trust beyond the kernel; a declared axiom (the bound is now to be proved, by Kooshi's word); a change
to a typed statement of another module; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 316 GB of disk free.** One file through `lake env lean`: 3 to 24
seconds and 3.6 GB for ordinary files; a certificate cut may take far more — run it under the slot with a time limit and
checkpoint the measurement. A build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name kdb1 -- <command>`

Four other jobs share the slot; ask for no more than 12 GiB without telling me first. On exit 75 wait ten minutes and
retry. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your record
cites lives under `data/fs131/kdb1/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-density-bound.md","w").write(b); print("ok",len(b))
