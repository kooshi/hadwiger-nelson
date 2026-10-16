exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KTC1: de Bruijn's planner on the three-colour criterion for lattice Cayley graphs (the asking lane's rank 5, C6;
# ledger row 79, FS73-T21–T24): the converse, periodicity and density, beside the forward half the kernel holds.
# Usage: mk-fs131-ktc1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-KTC1"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
assert sh("git","-C",W,"rev-parse","HEAD")==sh("git","-C",ROOT,"rev-parse","main")
MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main")
POR="plans/POROS-2026-10-13-number-field-findings.md"
TCC="Proofs/HadwigerNelson/Arith/ThreeColourCharacter.lean"
for p in ("LEDGER.md","LEAN.md","plans/FS73-derivation.md","plans/FS73-C3-deBruijn.md","plans/FS73-C3-Coxeter.md",
          "plans/FS73-rigidity-dichotomy.md","CLOSED-QUESTIONS.md","BIBLIOGRAPHY.md",POR,TCC,
          "Proofs/HadwigerNelson/ThreeColour.lean","Proofs/HadwigerNelson/ThetaCert.lean",
          "Proofs/HadwigerNelson/Arith/CharacterColouring.lean"): assert os.path.exists(W+p),p
def wl(path,first,last,must,addr):
    ls=open(ROOT+path).read().split("\n")[first-1:last]
    assert must in ls[0],(path,first,ls[0][:60])
    return "".join("> "+l+"\n" for l in ls)+"> — source: "+path+addr+"\n"
P33=" § 3.3 The first ten, each as the theorem a reader would look for"
W2=Q("data/fs131/REQUEST-2026-10-13.md","W2: ")
THM=wl(POR,406,408,"- *The theorem.* Let `A` be a finitely generated torsion-free abelian group",P33)
OBJ=wl(POR,415,416,"- *The first objection.* Ellenberg asked for every `k`",P33)
R79=Q("LEDGER.md","| 79 |")
FWD=wl(TCC,272,275,"/-- **NF4-S6 for a group**","")
assert "theorem bandSet_three_nonempty_of_proper" in FWD
b=f'''# Brief {JOB} — three-colourings of lattice Cayley graphs at the kernel: the criterion's converse, periodicity and density — the map, the skeleton and the price

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you run on Opus
  role: the kernel lane's planner for one hand result of ours, ledger row 79 (FS-73's three-colour theorem) — its forward half is a kernel theorem; you map the rest against the library, state it in Lean, build the skeleton with `sorry` at every leaf, plan each leaf and price it in lines of Lean
  launch: now, in a worktree of your own cut from `main`; beside you two other jobs (an implementer finishing another module, and a planner of an unrelated theorem), neither of which writes a file you write
  mission: § Why this job
  statements: § The result
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once for a statement defect (the result false or misstated as written) or a generalization; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building
  record: `plans/{JOB}-three-colour-plan.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (cut from `main` at `{MAIN}`; `.lake/packages` a symlink to the main tree's, `.lake/build` a copy of the main tree's build): `plans/{JOB}-three-colour-plan.md`; skeleton modules under `Proofs/HadwigerNelson/` in files you create, each named in your record, and the import lines that bring them into `Proofs.lean`; `ARCHITECTURE.md` rows for your new modules only; your scripts and outputs under `data/fs131/ktc1/`; `data/fs131/reports/{JOB}.md`. Edits to the front files (`CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md`, `ROADMAP.md`, `README.md`) and to existing modules are drafted in your record, not made. Commit on your branch by explicit path; never push
  budget: about 400k by the harness's count, as guidance; save a stage after each of the stages below; hand back at a saved stage before about 500k

Hello. Half of this theorem is already in the kernel, built three days ago for the three-colour results about number
fields; the other half is the part that answers the questions people asked in print.

## Why this job

Kooshi's rule for what this project publishes:

{W2}
The asking lane ranked the project's findings by interest to the field (`{POR}` § 3.2). Of the four above this one,
two are in the kernel, the third is being finished there (all but its density form), and the fourth is planned beside
you. This is its theorem as a reader would look for it:

{THM}
The objection it must meet, from the same entry:

{OBJ}

## The result

Ledger row 79, quoted whole — its kernel sentence says which half is held:

{R79}
The held half, in this library (every abelian group, every step set; on the standard three axioms):

{FWD}
Its neighbours in the same module are `exists_character_of_properAlong` and the plane's forms
`fieldBandSet_three_nonempty_of_colorable`, `…_of_colorable_unitRing`; `bandSet` and `band` are defined in
`Proofs/HadwigerNelson/Arith/CharacterColouring.lean`. Older kernel work on the same objects: `Proofs/HadwigerNelson/ThreeColour.lean` and
`Proofs/HadwigerNelson/ThetaCert.lean` (the winding and the `Θ₃` certificate checker of ledger row 119). The derivation is
`plans/FS73-derivation.md` § 4 (T21–T24, the theorems of this row; T29–T30 the four-colour no-gos; T39–T45 the
ℚ(√167) lattice), with the two independent derivations it merged, `plans/FS73-C3-deBruijn.md` and
`plans/FS73-C3-Coxeter.md`, and `plans/FS73-rigidity-dichotomy.md`. `CLOSED-QUESTIONS.md` § 2.4 records what it answers.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate in your record, in your own
   words, the result, what the kernel holds of it, and what is left; log any mismatch as a finding.
2. **Stage 2 — the map.** Each step of T21–T24 that the unheld parts need (the converse by a character, the periodic
   colouring, the density of periodic colourings, the dichotomy and the forced pairs), set against what this library
   and Mathlib at our pin hold, by declaration name and module; what is missing, with your estimate of each piece in
   lines of Lean. Say which printed results the steps read (the height lift's source, for instance) and whether each is
   formalized here or would be declared (`LEAN.md` § Assumptions: about an hour of agent work is formalized, and when
   unsure, formalize).
3. **Stage 3 — the skeleton and the plan.** The head statements in Lean — the criterion as an equivalence for finitely
   generated torsion-free abelian groups and finite symmetric step sets, the periodic form, the density, and the
   dichotomy if it rides — read back aloud against row 79 in your record, with what is not claimed (Poros's objection:
   `k = 3` only; density at the standard generators); every missing piece as a statement with `sorry`, built through
   `./scripts/build.sh` under the slot; a plan per leaf; the price in lines of Lean in total and per module; then the
   experience-modeling pass on the head statements (`debruijn-experience-modeling`: their names and docstrings as a
   mathematician would cite them). Nothing with a `sorry` reaches `main`; the skeleton stays on your branch.
4. **The report**, in the standing rules' form, with the front-page lines your reading finds owed drafted in your
   record, each naming its slot (row 79's grade sentence among them).

## What is yours to decide

The modules' names and places, the form of every Lean statement (which topology "dense" is read in, in particular,
taken from the derivation), whether a piece is better proved as a general lemma, which parts ride in the first module,
and the order of the leaves. The held forward half is stated for every abelian group: if the converse or the density
holds in a wider class than row 79 says, or fails in the class it says, report it — a wrong statement reported is a
finding, and a better target is welcome with its price.

## The machine

This is the laptop: 12 cores, 31 GB, shared with two other jobs, one of which builds at 16 GiB. Every Lean build and
every `lake env lean` over about 2 GiB goes through the slot with this machine's settings, from inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 6 --cpus 3 -- env MEMMAX=6G BATCH=2 ./scripts/build.sh`
(or `--mem 4 --cpus 1 -- lake env lean …` for one file); never `lake build`. When the slot waits, another job holds the
memory; on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`)
is for iteration only, never evidence that a module is green. The worktree's `.lake/build` is its own copy; never
replace it with a symlink. `/tmp` is a tmpfs: keep anything your record cites under `data/fs131/ktc1/`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-three-colour.md"
open(out,"w").write(b); print(out)
