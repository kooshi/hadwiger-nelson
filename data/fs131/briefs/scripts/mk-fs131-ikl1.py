exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IKL1: the certificate link — K3 (the level-one target as Cay((Z/q)^2, unit circle)), K4 (fibre shares at every
# level), K5 (the comparison with 1/4) — closing M13's ratioAtMost_cert at q = 11, and at q = 19 over the p = 19 bound.
# Usage: mk-fs131-ikl1.py <item of KC13's hand-back> <item of IKC3's hand-back> <item of ICM3's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KC,KH,KM=[int(x) for x in sys.argv[1:4]]
TREE="fs132-wi1"; BR="fs131-wkl"; JOB="FS131-IKL1"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wla" and sh("git","-C",W,"status","--porcelain")==""
CM=sh("git","-C",ROOT,"rev-parse","--short=9","fs131-wcm3"); C16=sh("git","-C",ROOT,"rev-parse","--short=9","fs131-wc16")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
DT=Q(C,"- 2026-10-14 — **The class-ratio checker is proved sound**","§ Dated lines")
WN=WT+"fs131-wnf/"; WC=WT+"fs131-wch/"; PC=WN+"plans/FS131-KC13-certificates.md"
for p in (PC,WN+"plans/FS131-IKC3-implementation.md",WC+"plans/FS131-ICM3-implementation.md",WC+"plans/FS131-ICM2-implementation.md",
          ROOT+"data/fs66/b1/SOUNDNESS.md",ROOT+"LEAN.md"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: the certificate link at residue sizes 11 and 19

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the implementer of the link between the class-ratio certificates and M13 — the certificate planner's leaves K3 (the level-one target at an inert stable prime of residue size `q²`, `q` prime, as the Cayley graph of `(ℤ/q)²` on the unit circle), K4 (a set with no two adjacent points, at every level, gives fibre shares `φ ∈ [0,1]^V` with `q(φ) ≥ 0` and `|I| = q^{{2(m−1)}}·Σφ`) and K5 (the comparison with 1/4) — composed into the statement M13's private leaf `ratioAtMost_cert` asks for, at `q = 11` from the proved bound, and at `q = 19` over the bound at 19 as a named hypothesis
  launch: now, in a finished tree on a new branch cut from M13's line, with the class-ratio certificates' line merged in; three other jobs work in other trees and share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if the link needs a private lemma of `Rigidity/ClassRatio` or of the certificate modules made public, if the first leaves price the link above 2,500 lines, and with one line when the `q = 11` case prints with no `sorryAx`; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (on `fs131-wla`, clean; its compiled library is that branch's) on a **new branch `{BR}`** that you cut from M13's line (`git checkout -b {BR} fs131-wcm3`, at `{CM}`) and into which you merge the certificates' line (`git merge --no-ff fs131-wc16`, at `{C16}`; `git merge-tree` reports a conflict in `ARCHITECTURE.md` only — keep both sides): new modules for the link (under `Proofs/HadwigerNelson/Rigidity/` or `Proofs/HadwigerNelson/Arith/`, yours to name) with their lines in the build's lists and `ARCHITECTURE.md`; your checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/ikl1/`; `data/fs131/reports/{JOB}.md`. **Not** `Proofs/HadwigerNelson/Rigidity/ClassRatio.lean` (M13's, written now on another branch by FS131-ICM4), any `Arith/FibreCert*` module (the certificates' line, written now by FS131-IKC4), any other existing module's file, any module under `Outside/`, the declared `StandingFive.kloosterman_bound`. Nothing on `main`; no push
  budget: {BUDGET}; save a stage (a commit on your branch) after the readback, after the merge builds, and as leaves fall

Hello. The five-colour chain's class-ratio step is proved but for one private leaf at residue sizes 11 and 19, and the
certificate that settles those sizes is checked by the kernel at 11 (the bound at 19 is being brought in now). Nothing
yet connects the two: the certificate speaks of a quadratic form on `(ℤ/q)²`, the leaf of the plane's finite targets at
a prime of a number field, at every level. You build that connection.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The gate takes no `sorry`, so the chain cannot land on `main` until `ratioAtMost_cert` is proved.

## The statements

The dated line of the chain's claim list (`data/fs131/claims-NF2.md`) that says what the checker holds:

{DT}
The certificate planner's, the last certificate implementer's and M13's last implementer's hand-backs, as I logged them
(their words in quotation marks, the rulings mine):

{item(KC)}
{item(KH)}
{item(KM)}
**The leaf you close** (M13's line, `Proofs/HadwigerNelson/Rigidity/ClassRatio.lean` near l. 2075 on `fs131-wcm3`) is
private: `ratioAtMost_cert [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {{Q : ℕ}} (hQ :
Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) (hQ1119 : Q = 11 ∨ Q = 19) : ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c` — print it from
the kernel in your readback; `RatioAtMost` is defined there (l. 41) from `levelTarget` (`SpectralChain`). **Since
`ClassRatio` is not yours, state the link's conclusion in a module `ClassRatio` can import** — with `RatioAtMost`'s
body written out (its definition is self-contained over `SpectralChain`), so that at the landing `ratioAtMost_cert` is
one line reading your theorem; show that one line compiles in a scratch copy, not in the file. **At `q = 19`** the bound
is being proved now on the certificates' line (FS131-IKC4): take it as a named hypothesis with the shape of
`sum_le_eleven` (`Arith/FibreCert11Bound`) at 19, its constant left as a parameter or the reduced certificate's
`U = 88.643400…` as a rational bound, your choice, and say which; the landing discharges it by that job's theorem.

**Where everything is:** the certificate planner's record `{PC}` § 5.2 (K1–K5, their routes and prices; K4's first half
"is **Lemma P**", proved by FS131-ICM2 on M13's line, private, `{WC}plans/FS131-ICM2-implementation.md`) and § 5.1 (the
case split); FS-66's `data/fs66/b1/SOUNDNESS.md` §§ 1–2 (L1, L2 — the fibre shares); the last certificate implementer's
record `{WN}plans/FS131-IKC3-implementation.md`; `Arith/FibreCert11Bound` (`sum_le_eleven`, `card_le_eleven`,
`model_eleven`), `Arith/NormOneTarget`, `Arith/UpperHalf` in your merged tree; M13's last record
`{WC}plans/FS131-ICM3-implementation.md`.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the branch cut, merged and built;
   `ratioAtMost_cert`, `RatioAtMost`, `levelTarget`, `sum_le_eleven` and `card_le_eleven` printed from the kernel and
   restated in one line each; K3–K5 restated beside their routes, with what each reads.
2. **K3, K4, K5 and the composition** (saved stages as they fall): the `q = 11` case with no `sorryAx` (the one line to
   me), the `q = 19` case over its named hypothesis; each statement with a model.
3. **The scratch check**: a copy of `ClassRatio` whose `ratioAtMost_cert` reads your theorem in one line compiles, and
   `ratioAtMost_of_five_le_chromaticNumber` then prints with no `sorryAx` but through the dyadic children FS131-ICM4 is
   proving and the `q = 19` hypothesis — each named.
4. **The gate's items for your files**: one build under the slot with no warning from them; the axioms of every public
   declaration printed from the built tree, each listed, with a planted record watched showing; the guarded lint
   (`lake lint --no-build -- --no-build --trace`) with no finding in your files; no existing statement or definition
   changed by the merge or by you, shown from the kernel's side (a planted change watched firing).
5. **Drafts for the landing**, in your record: the one line for `ratioAtMost_cert`; the audit's block; any `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued. Stopping at a saved stage with a leaf
   left, named with its route, is a good report.

## What is yours to decide

The proofs; the module cut and names; private helpers; imports; the route of each leaf where the plan's does not go
through (tell me which). An unread binder of a statement of yours is dropped. Not yours: an edit to `ClassRatio` or to a
certificate module (ask me: the owning job makes it); a change to any existing statement or definition; a declared
axiom; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 316 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is `fs131-wla`'s, so the first build compiles the count's modules, M13's and the
p = 11 certificate's (about 21 modules of kernel checks, a few minutes): budget 20–40 minutes and read while it runs.
One file through `lake env lean`: 3 to 24 seconds, 3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ikl1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`; do not edit a file a running build will compile. The p = 19 job can hold up to 10 GiB of the slot for long
stretches: on exit 75 wait ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137. Stop a
process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your record cites lives
under `data/fs131/ikl1/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your branch and do not push**; I copy the branches to a
local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-cert-link.md","w").write(b); print("ok",len(b))
