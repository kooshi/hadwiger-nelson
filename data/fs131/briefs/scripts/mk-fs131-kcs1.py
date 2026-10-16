exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KCS1: de Bruijn's planner on the public roadmap's section 3, items 1-2: row 123's instances not stored as theorems
# (the quadratic family, CLS in full, Q(sqrt23, cbrt2)) and row 100's Lemma C' (the ring of unit vectors).
# Usage: mk-fs131-kcs1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-KCS1"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor","main","HEAD"]).returncode==0
MAIN=sh("git","-C",W,"rev-parse","--short=9","HEAD")
POR="plans/POROS-2026-10-13-number-field-findings.md"
for p in ("LEDGER.md","LEAN.md","ROADMAP.md",POR,"plans/FS131-LGT1-gate.md","plans/FS100-derivation.md",
          "plans/FS100-X28D-derivation.md","plans/FS91-derivation.md","data/fs131/lch1/ring-scope-lemma-c-prime.lean",
          "Proofs/HadwigerNelson/Instances/SqrtClassValues.lean","Proofs/HadwigerNelson/Rigidity/MainClauseFive.lean",
          "BIBLIOGRAPHY.md"): assert os.path.exists(W+p),p
def wl(path,first,last,must,head=""):
    ls=open(W+path).read().split("\n")[first-1:last]
    assert must in ls[0],(path,first,ls[0][:60])
    return "".join("> "+l+"\n" for l in ls)+"> — source: "+path+((" "+head) if head else "")+"\n"
W2=Q("data/fs131/REQUEST-2026-10-13.md","W2: ")
RM=wl("ROADMAP.md",96,106,"1. **Not stored as theorems**","§ 3. Planes over number fields")
GT=wl("plans/FS131-LGT1-gate.md",508,509,"4. **Row 123's family**")
R123=Q("LEDGER.md","| 123 |")
R100=Q("LEDGER.md","| 100 |")
P1=wl(POR,321,328,"- *The theorem.* (Given the printed theorem of Einsiedler and Lindenstrauss.)","§ 3.3")
P8=wl(POR,435,441,"**Rank 8 — C8. The ring of unit vectors.**","§ 3.3")
I995=item(995)
b=f'''# Brief {JOB} — five colours at the kernel, instance by instance and as a class; and the ring of unit vectors — the map, the skeleton and the price

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you run on Opus
  role: the kernel lane's planner for the public roadmap's § 3 items 1–2 — row 123's results the kernel does not yet store as theorems (the quadratic family, CLS in full, ℚ(√23, ∛2)) and row 100's Lemma C′ — the map of what each rests on, the statements in Lean, the skeleton with `sorry` at every leaf, a plan per leaf, priced in lines of Lean
  launch: now, in a worktree of your own cut from `main`; beside you three implementers taking other modules to the gate (the `p`-adic plane, the three-colour criterion, the density form of the collapse), none of which writes a file you write
  mission: § Why this job
  statements: § The results
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage at once for a statement defect (a result false or misstated as written) or a generalization; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building
  record: `plans/{JOB}-class-plan.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (cut from `main` at `{MAIN}`; `.lake/packages` a symlink to the main tree's, `.lake/build` a copy of the main tree's build, current for `main`): `plans/{JOB}-class-plan.md`; skeleton modules under `Proofs/HadwigerNelson/` in files you create, each named in your record, and the import lines that bring them into `Proofs.lean`; `ARCHITECTURE.md` rows for your new modules only; your scripts and outputs under `data/fs131/kcs1/`; `data/fs131/reports/{JOB}.md`. Edits to the front files (`CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md`, `ROADMAP.md`, `README.md`) and to existing modules are drafted in your record, not made. Commit on your branch by explicit path; never push
  budget: about 400k by the harness's count, as guidance; save a stage after each of the stages below; hand back at a saved stage before about 500k — if the two parts will not both fit, finish part A's plan and say what part B needs; a successor plans it from your record, and that is a good report

Hello. This week the library proved the main clause through five as one theorem: `χ(F²) = L(F)` whenever `L(F) ≤ 5`, at
every real number field, on two declared outside theorems (`Rigidity.chromaticNumber_planeOver_eq_localBound_of_le_five`).
What the public roadmap says is still missing from it is the part a reader would look up by field: which fields, by
name or by class, need five colours. And beside it, a ring lemma that was taken out of the library unproved.

## Why this job

Kooshi's rule for what this project publishes:

{W2}
My ruling, in the order the asking lane set, that these items take the next free slot:

{I995}
## The results

**Part A — five colours, by field and by class.** The roadmap's entry:

{RM}
The chain's gate record says the same and why they were left:

{GT}
The ledger's row 123, quoted whole (the family's list of `d` and the 8 of 52 that are not `L = 5` are in it or in the
derivation it names):

{R123}
The asking lane's statement of the theorem a reader would look for, which also names the quadratic dichotomy — "at
least five colours exactly when `n ≡ 47, 143, 167 (mod 168)`" — whose other half the kernel already holds
(`ThreeFourColours.chromaticNumber_planeOver_sqrt_table`):

{P1}
The derivation is `plans/FS100-derivation.md` (FS100-Q47, FS100-COR with CLS, SPC and TCA); the complex-place field
ℚ(√23, ∛2) is X28D-CP2 in `plans/FS100-X28D-derivation.md`. The kernel's per-field route for the four named quadratic
instances is `Proofs/HadwigerNelson/Instances/SqrtClassValues.lean`; the headline is in
`Proofs/HadwigerNelson/Rigidity/MainClauseFive.lean`.

**Part B — the ring of unit vectors.** Row 100, quoted whole (Lemma C′ is in its peel):

{R100}
The asking lane's entry:

{P8}
The statement as typed when it was taken out, and its hand route: `data/fs131/lch1/ring-scope-lemma-c-prime.lean`. The
derivation is `plans/FS91-derivation.md` § 2.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate in your record, in your own
   words, each result of parts A and B, what each rests on, and what the library holds; log any mismatch as a finding.
2. **Stage 2 — the map.** For each result: each step set against what this library and Mathlib at our pin hold, by
   declaration name and module; what is missing, with your estimate in lines of Lean. In part A, in particular: whether
   `5 ≤ L(ℚ(√d))` holds at every squarefree `d ≡ 47, 143, 167 (mod 168)` from CLS's criterion (so that the dichotomy
   "`5 ≤ χ(ℚ(√d)²)` exactly at those classes" is one theorem with no list), and what the equality `χ = 5` needs at each
   field of the family (a five-colourable residue target, by a uniform argument or field by field); how CLS in full is
   best stated; and what the complex place of ℚ(√23, ∛2) asks of the library's notion of a real number field and its
   stable primes. Any printed theorem a step reads: formalize it if that is about an hour of agent work, and when
   unsure, formalize; otherwise say what declaring it would take (`LEAN.md` § Assumptions, its four items).
3. **Stage 3 — the skeleton and the plan.** The head statements in Lean, read back aloud against the results in your
   record, with what is not claimed; every missing piece as a statement with `sorry`, built through `./scripts/build.sh`
   under the slot; a plan per leaf; the price in lines of Lean in total and per module; then the experience-modeling pass
   on the head statements (`debruijn-experience-modeling`: their names and docstrings as a mathematician would cite them).
   Nothing with a `sorry` reaches `main`; the skeleton stays on your branch. Part A first; part B in the same stages if it
   fits, as its own module.
4. **The report**, in the standing rules' form, with the front-page lines your reading finds owed drafted in your record,
   each naming its slot; novelty as the ledger words it, and the posers credited by name. The ring lemma's novelty is
   unchecked (the asking lane: "**novelty unchecked** where a number theorist would look first"): word nothing about it
   as new.

## What is yours to decide

The modules' names and places, the form of every Lean statement, which instances ride as theorems by name and which as
one class statement, whether a piece is better proved as a general lemma, and the order of the leaves. If a result is
misstated, or holds in a wider form, say so: a wrong statement reported is a finding, and a better target is welcome
with its price.

## The machine

The laptop: 12 cores, 31 GB, shared with three implementers that build and will run full gates. Every Lean build and
every `lake env lean` over about 2 GiB goes through the slot with this machine's settings, from inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 6 --cpus 3 -- env MEMMAX=6G BATCH=2 ./scripts/build.sh`
(or `--mem 4 --cpus 1 -- lake env lean …` for one file); never `lake build`. When the slot waits, another job holds the
memory; on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`)
is for iteration only, never evidence that a module is green. The worktree's `.lake/build` is its own copy; never
replace it with a symlink. `/tmp` is a tmpfs: keep anything your record cites under `data/fs131/kcs1/`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-class.md"
open(out,"w").write(b); print(out)
