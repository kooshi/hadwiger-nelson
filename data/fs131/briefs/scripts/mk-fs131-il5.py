exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IL5: de Bruijn's implementer stores χ(F²) = L(F) at L(F) ≤ 5 as one named theorem, through the gate.
# Usage: mk-fs131-il5.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-IL5"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
assert sh("git","-C",W,"rev-parse","HEAD")==sh("git","-C",ROOT,"rev-parse","main")
MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main")
for p in ("ROADMAP.md","LEDGER.md","LEAN.md","scripts/Axioms.lean","data/fs131/clone1/run-gate.sh","data/fs131/clone1/gate/run-pass.out",
          "Proofs/HadwigerNelson/Rigidity/ChainHeadline.lean","Proofs/HadwigerNelson/Arith/UpperHalf.lean"): assert os.path.exists(W+p),p
RM=Q("ROADMAP.md","1. **`χ(F²) = L(F)` whenever `L(F) ≤ 5`, as one named theorem.**")
def lean_lines(path,first,last):
    ls=open(ROOT+path).read().split("\n")[first-1:last]
    return "".join("> "+l+"\n" for l in ls)+"> — source: "+path+"\n"
HEAD=lean_lines("Proofs/HadwigerNelson/Rigidity/ChainHeadline.lean",52,53)
UP=lean_lines("Proofs/HadwigerNelson/Arith/UpperHalf.lean",296,297)
assert "theorem min_localBound_five_le_chromaticNumber (F : Subfield ℝ) [NumberField F] :" in HEAD
assert "theorem chromaticNumber_planeOver_le_localBound :" in UP
I980=item(980)
b=f'''# Brief {JOB} — store `χ(F²) = L(F)` whenever `L(F) ≤ 5` as one named theorem, through the gate

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus
  role: the implementer of one short theorem the public roadmap lists as not yet stored — the main clause through five as an equality — with its audit record, its docstring, and the gate run on one commit
  launch: now, in a worktree of your own cut from `main`; beside you two kernel planners in other worktrees, which may build; none writes a file you write
  mission: § Why this job
  statements: § The statement
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage when the gate is green on one commit, and at once if the composition does not go through as stated; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/{JOB}-equality.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (cut from `main` at `{MAIN}`; `.lake/packages` a symlink to the main tree's, `.lake/build` a copy of the main tree's gated build): the one module you choose for the theorem (an existing module of `Rigidity/` or a new one, named in your record, with its import in `Proofs.lean` if new); `scripts/Axioms.lean` and any other gate input the new record needs, by the gate's own rules; `plans/{JOB}-equality.md`; your scripts and logs under `data/fs131/il5/`; `data/fs131/reports/{JOB}.md`. Front-file edits (`ROADMAP.md`, `LEDGER.md` row 123, `CLAUDE.md`, `README.md`) are drafted in your record, each naming its slot, not made. Commit on your branch by explicit path; never push
  budget: about 200k by the harness's count, as guidance; save a stage after the readback, after the theorem builds, and after the gate; hand back at a saved stage before about 300k

Hello. This is a short job: one theorem the public roadmap says is missing, two lines of proof, and the gate around it.

## Why this job

The repository went public this morning, and its roadmap lists, first among what the kernel does not yet store:

{RM}
A reader looking for the main clause through five as one statement finds two inequalities and an instruction to compose
them. Stored, it is the theorem a reader cites. The full gate was green on `main` this morning:

{I980}
## The statement

The two theorems it composes, as the library states them:

{HEAD}
{UP}
The target: for every real number field `F` (`F : Subfield ℝ` with `[NumberField F]`), `localBound F ≤ 5` implies
`((unitDistance ℂ).induce (planeOver F)).chromaticNumber = localBound F`. A conditional version already exists over the
chain's named hypotheses (`UpperHalf.chromaticNumber_eq_localBound_of_chain`, `Proofs/HadwigerNelson/Arith/UpperHalf.lean` l. 300); the new one
takes none of them.

## Done means

1. **Stage 1 — the readback.** Check the quotations against their sources; restate the target in your record.
2. **Stage 2 — the theorem**, with a docstring that says what it states in words, what it rests on (the declared
   outside theorems it inherits), and whose each half is (the upper half prior art, as `LEDGER.md` row 52 says; the
   lower half this project's derivation, "prior art: not found in print" at ℚ(√47), as row 121 says), built through
   `./scripts/build.sh` under the slot; `#print axioms` on it, recorded.
3. **Stage 3 — the gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (the run that passed this morning;
   copy it under `data/fs131/il5/` and point its log folder there), the audit's coverage taking the new record by the
   gate's own rules, and the counts' changes explained one by one against this morning's (`data/fs131/clone1/gate/`).
   Read the statement aloud against `ROADMAP.md`'s item 1 in your record.
4. **Stage 4 — the drafts**: `ROADMAP.md` item 1, `LEDGER.md` row 123's "Not claimed" line, `README.md` if it lists the
   statement as missing, and `CLAUDE.md` § The gate and § Trust ledger counts — each draft naming its slot.
5. **The report**, in the standing rules' form.

## What is yours to decide

The theorem's name and module (a name that reads as the statement, in the library's style), and how the gate's inputs
take the new record. If a stronger statement is as short — for instance the equality at every field where the lower
bound reaches `L(F)` — say so with its form, and store the brief's target unless it is strictly implied.

## The machine

This is the laptop: 12 cores, 31 GB, shared with two planners that build. From inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 10 --cpus 4 -- env MEMMAX=10G BATCH=4 ./scripts/build.sh`;
the gate's steps each take up to 8 GiB under the slot. On exit 75 wait ten minutes and retry. Never `lake build`. `/tmp`
is a tmpfs: keep what your record cites under `data/fs131/il5/`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-equality.md"
open(out,"w").write(b); print(out)
