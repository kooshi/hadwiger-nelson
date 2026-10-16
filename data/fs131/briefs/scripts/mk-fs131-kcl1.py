exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KCL1: de Bruijn's planner on ledger row 128 (the collapse): does the kernel's MR⁺ discharge the MR it is "given",
# and if so, the module that states χ(ℚ(√635087)²) = χ(ℝ²) with no hypothesis of ours.
# Usage: mk-fs131-kcl1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-KCL1"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
assert sh("git","-C",W,"rev-parse","HEAD")==sh("git","-C",ROOT,"rev-parse","main")
MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main")
for p in ("LEDGER.md","LEAN.md","plans/FS103-derivation.md","plans/FS103-collapse-cp-plane.md","data/fs103/claims.md",
          "plans/FS103-V1-verification.md","plans/FS103-V2-verification.md","plans/STUB-mr-in-lean.md",
          "Proofs/HadwigerNelson/Rigidity/ChainAtTA.lean","Proofs/HadwigerNelson/Rigidity/ZeroEntropyClosed.lean",
          "Proofs/HadwigerNelson/Outside/OAI158Collapse.lean","plans/FS131-EN1-derivation.md"): assert os.path.exists(W+p),p
W2=Q("data/fs131/REQUEST-2026-10-13.md","W2: ")
W6=Q("data/fs131/REQUEST-2026-10-13.md","Once the chain lands, we'll do some sanitization")
R128=Q("LEDGER.md","| 128 |")
R120=Q("LEDGER.md","| 120 |")
I951=item(951)
def lean_lines(path,first,last):
    ls=open(ROOT+path).read().split("\n")[first-1:last]
    return "".join("> "+l+"\n" for l in ls)+"> — source: "+path+"\n"
MRP=lean_lines("Proofs/HadwigerNelson/Rigidity/ChainAtTA.lean",365,370)
MRT=lean_lines("Proofs/HadwigerNelson/Rigidity/ZeroEntropyClosed.lean",48,50)
PLANE=lean_lines("Proofs/HadwigerNelson/Outside/OAI158Collapse.lean",51,51)
assert "def MRPlus : Prop :=" in MRP and "theorem mrPlus (F : Subfield ℝ) [NumberField F] : MRPlus F :=" in MRT
assert "theorem chromaticNumber_plane_eq_chiM0" in PLANE
b=f'''# Brief {JOB} — the collapse at the kernel: does the measure rigidity the library now proves discharge ledger row 128's hypothesis, and if it does, the module that says the plane over ℚ(√635087) has the plane's chromatic number

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you run on Opus
  role: the kernel lane's planner for one hand result of ours, ledger row 128 — first a question about which form of measure rigidity its derivation uses, answered from the derivation and the library; then, if the answer allows, the map of what the result rests on, the skeleton and a plan per leaf, priced in lines of Lean
  launch: now, in a worktree of your own cut from `main`; beside you at most one other job, which writes no file you write
  mission: § Why this job
  statements: § The result and the hypothesis
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **with the answer to the question as soon as stage 2 is saved**, and at once for a statement defect (row 128 false or misstated as written) or a generalization; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (rules 6 and 13 changed today: never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building
  record: `plans/{JOB}-collapse-plan.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (cut from `main` at `{MAIN}`; `.lake/packages` a symlink to the main tree's, `.lake/build` a copy of the main tree's gated build): `plans/{JOB}-collapse-plan.md`; skeleton modules under `Proofs/HadwigerNelson/` in files you create, each named in your record, and the import lines that bring them into `Proofs.lean`; your scripts and outputs under `data/fs131/kcl1/`; `data/fs131/reports/{JOB}.md`. Edits to the front files (`CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `ARCHITECTURE.md`) and to existing modules are drafted in your record, not made. Commit on your branch by explicit path; never push
  budget: about 400k by the harness's count, as guidance; save a stage after each of the stages below; hand back at a saved stage before about 500k

Hello. This is the next piece of mathematics after the repository went public, and it may be the most striking statement
the library can reach about planes over number fields.

## Why this job

Kooshi's rule for what this project publishes:

{W2}
The repository is now public as a Lean repository (W6, below); the rule above still governs any write-up, and every
hand result of ours is to reach the kernel.

{W6}
Ledger row 128 is the project's hand result that the plane's chromatic number is a number field's: for a totally real
field whose stable places all mix at six colours, and given measure rigidity there (MR), `χ(F²) = χ(ℝ²)`; its first
instance is ℚ(√635087). Since the landing of the five-colour chain (2026-10-15), the library proves a form of measure
rigidity for every real number field, `Rigidity.mrPlus`, resting on the standard three axioms and the declared outside
theorem `Rigidity.positive_entropy_rigidity` (Einsiedler–Lindenstrauss Theorem 1.3). The README job asked whether that
form is the one row 128 uses, and nobody has checked:

{I951}
If it is, then `χ(ℚ(√635087)²) = χ(ℝ²)` can be stated and proved in the kernel with no hypothesis of ours — a quadratic
field whose plane needs exactly as many colours as the whole plane, whatever that number turns out to be. If it is not,
the gap between the two forms is the finding, and it is just as useful: it says what the next deduction is.

## The result and the hypothesis

The result, ledger row 128, quoted whole (its grade and its prior-art line are part of it):

{R128}
Measure rigidity as the ledger states it (row 120; MR(F) is defined in its first sentence):

{R120}
What the library proves (`MRPlus` and the theorem that holds it at every real number field):

{MRP}
{MRT}
And the plane's half, which row 128 notes holds with no MR since `[OAIMath2026]`; in the library, on the standard three
axioms:

{PLANE}
The derivation is `plans/FS103-derivation.md` § 1 (its fixed claim list `data/fs103/claims.md`), the close's assembly
`plans/FS103-collapse-cp-plane.md` § R-close, and the two blind checks `plans/FS103-V1-verification.md`,
`plans/FS103-V2-verification.md`; the computations of the places are `tools/fs103_v1_checks.py` and
`tools/fs103_v2_places.py`. How MR⁺ came to be proved, and what it was derived for, is `plans/FS131-EN1-derivation.md`
(the five-colour chain needed only `T + A`).

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate in your record, in your own
   words, the result, the hypothesis it is given, and what the library holds; log any mismatch as a finding.
2. **Stage 2 — the answer.** Find every step of row 128's derivation that uses MR, and quote each with its address:
   which set `E` it asks the measure to vanish on, which measures it applies MR to, and what it concludes. Then say,
   for each, whether `MRPlus F` implies what the step uses, with the implication stated as a Lean statement and, where it
   is short, proved in a scratch file under `data/fs131/kcl1/` and checked with `lake env lean` (iteration only) — or
   name the gap exactly. Also name every other hypothesis on the result's path that is ours or open (for instance how
   "every stable place 6-thick" is established over infinitely many places, and with what certificate). **Message me the
   answer when this stage is saved.**
3. **Stage 3 — the map** (if stage 2's answer is yes, or the gap is a named deduction): each step of the derivation set
   against what the library holds, by declaration name and module, and what is missing, with your estimate of each
   missing piece in lines of Lean.
4. **Stage 4 — the skeleton and the plan.** The target statement in Lean — `χ(ℚ(√635087)²) = χ(ℝ²)` in the library's
   own terms (`planeOver`, `unitDistance ℂ`), read back against row 128 aloud in your record — and every missing piece
   as a statement with `sorry`, built through `./scripts/build.sh` under the slot; a plan per leaf; the price in lines of
   Lean in total. Where de Grey's field `ℚ(√3,√5,√7,√11)` comes at small extra cost, say what it would add. Nothing with
   a `sorry` reaches `main`; the skeleton stays on your branch.
5. **The report**, in the standing rules' form, with the front-page corrections your reading finds drafted in your record.

A "no" at stage 2 is a complete job: stop after stage 2's report if the gap is not a named deduction, and say what
the next derivation would have to prove.

## What is yours to decide

The modules' names and places, the form of every Lean statement, whether a piece is better proved as a general lemma,
and the order of the leaves. If row 128 is misstated, or holds in a wider form than the ledger says (the ledger itself
notes a complex-place widening, one mind, not claimed), say so: a wrong statement reported is a finding. If you see a
better target than the one above — for instance a statement at every totally real field with `N₆(F) = ∅` rather than
the one instance — propose it with its price.

## The machine

This is the laptop: 12 cores, 31 GB. Every Lean build and every `lake env lean` over about 2 GiB goes through the slot
with this machine's settings, from inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 12 --cpus 6 -- env MEMMAX=12G BATCH=4 ./scripts/build.sh`;
never `lake build`. On exit 75 another job holds the memory: wait ten minutes and retry. `lake env lean` (with
`-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence that a module is green. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` is a tmpfs: keep anything your record
cites under `data/fs131/kcl1/`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-collapse.md"
open(out,"w").write(b); print(out)
