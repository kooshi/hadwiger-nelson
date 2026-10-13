exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KN4: the kernel lane's planner on rank 2 — three and four colours over real number fields (claims NF4).
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE="fs131-wr2"; JOB="FS131-KN4"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
BASE=sh("git","-C",W,"rev-parse","--short=8","HEAD")
C="data/fs131/claims-NF4.md"; RQ="data/fs131/REQUEST-2026-10-13.md"; MAP="plans/FS131-KN1-number-field-kernel-map.md"; PR="plans/POROS-2026-10-13-number-field-findings.md"
TH="\n".join(Q(C,f"NF4-{n}: ","§ The theorem (the asking lane's wording, rank 2)") for n in ("THEOREM","ENTRIES","RESTS","OBJECTION"))
RW="\n".join(Q(C,f"NF4-ROW-{n}: ","§ The rows as the kernel map has them") for n in (73,82,99))
SL="\n".join(Q(C,f"NF4-{n}: ","§ The shared leaves these rows wait on (the map's § X1)") for n in ("S6","S7","S9"))
NC=Q(C,"NF4-NC: ","§ Not claimed")
UH="/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf"
b=f'''# Brief {JOB} — three and four colours over real number fields, with no hypothesis: which planes over real quadratic fields need four colours, and when a number field's plane needs exactly three — the leaf list, the statements typed, a skeleton, a plan per leaf

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: the kernel lane's planner for the second module of the number-field results — make the leaf list the morning's map left as "unsized, derivation files named", type the statements, read each back against its claim and its derivation entry, build the skeleton with `sorry` at every leaf, and write a plan per leaf for implementers who will have none of your context
  launch: now, in a tree of your own; three other trees hold other modules of the same restart (`fs131-wnf`: the residue upper half, whose theorems your equalities will cite; `fs131-wkc`; `fs131-wch`) — you write in none of them; nothing is landing
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect (untrue as written, vacuous, narrower than it need be, or needing a hypothesis its claim lacks — say which), for an attribution the record states two ways, for a generalization you see while typing, and with one line when the skeleton compiles; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/FS131-KN4-three-four-colours-plan.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from `main` at `{BASE}`; **the tree is a retired landing's, moved: its `.lake/build` is older than the branch by two landings of modules under `Proofs/HadwigerNelson/Plane/` that nothing here imports, so iteration works as it stands and your first build compiles those**): the new modules of this claim list under `Proofs/HadwigerNelson/` and their lines in the build's lists; `plans/FS131-KN4-three-four-colours-plan.md`; `data/fs131/kn4/`; `data/fs131/reports/{JOB}.md`. No existing module's statements; nothing on `main`; nothing in another tree
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, after the leaf list, when the statements are typed, when the skeleton compiles, and after each leaf's plan; hand back when the plan per leaf is final, or earlier at a saved stage

Hello. Four jobs of this lane ran today on the restart of the Lean backlog; this is the fifth, and by the order the
asking lane recommended it is the one the field gets first.

## Why this job

The project is being wound down and published. Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
This morning's ranking of the number-field findings put second — and first in the order to formalize — the one that
needs no hypothesis at all: the exact number of colours for the plane over a real quadratic field, through four, and
the criterion for exactly three over every real number field. It was asked twice in print by name; a paper posted
last week calls the upper bounds "known" and leaves the exact values; and the five-colour theorem that ranks first
names this one among its hypotheses in the kernel. One instance is kernel-checked already (the field of the square
root of 11). The general statements are by hand: two independent derivations for one, three for the other.

The morning's map (`{MAP}`) gave these rows an entry each and three shared leaves, and said plainly that it had not
made their leaf list: "unsized". Making it is the first half of your job. The ranking's entry for this finding
(`{PR}` § 3.3, rank 2) says what a reader would look for and what they would object to first.

## The statements

Fixed in `data/fs131/claims-NF4.md` before your launch, by script:

{TH}
The rows, as the map has them:

{RW}
The shared leaves they wait on:

{SL}
{NC}
**The upper halves are another module's.** Every "=" in the theorem needs an upper bound at the level of a field,
and those are being typed today on branch `fs131-wnf` (its tree: `{UH}`; modules `Arith/UpperHalf`,
`Arith/QuadraticPrime` and an instances file, skeleton compiling, 24 leaves open; claim list
`data/fs131/claims-NF1.md` with its dated lines). Read its statements there. Your module proves the lower halves
and the criterion; the equalities are assembled in a file that imports both, which you plan and do not need to
compile until that module is on `main`.

## Done means

1. **Readback** (a saved stage): the eleven quoted lines checked against the claim list; the theorem's three clauses
   restated with every symbol resolved to a library declaration or marked as missing; the derivation entries the
   ranking names read where they stand, and what each proves set beside the clause it is cited for — a clause wider
   than its entry is a finding to send at once.
2. **The leaf list** (a saved stage): for each clause, the leaves in dependency order from the kernel's present
   theorems to the clause, each exact enough to type, each with its derivation address; the three shared leaves
   placed in it; what is already in the library under another name (search by the statement's shape and say what
   you searched).
3. **The statements typed**, compiled with `sorry`, each read back aloud against its claim: every hypothesis the
   Lean statement has that the claim lacks and every one the claim has that Lean does not need. The attribution
   the ranking flags is answered in the statements themselves and their docstrings: what is this project's (the
   lower bound at four; the three-colour criterion over every real number field), what is an outside model's, what
   is Fischer's and Johnson's, in the words `LEDGER.md` § The claim list and § B use.
4. **The skeleton** compiling in your tree, `sorry` at every leaf and nowhere else, every definition with an
   inhabitant, a spec example per headline, the modules' lines in the build's lists.
5. **A plan per leaf** for an implementer with none of your context; the split two implementers could work on
   without sharing a file; and what the landing needs after them.
6. **Outside statements**: the map says one row's route uses Weil's bound, which the library already declares, and
   the other uses none; confirm it from the entries, and name any other printed statement a leaf reads, with its
   page if the record has it.
7. The report, with drafts for the files you do not write (the ledger rows this would regrade; the sentence a
   reader of the repository would be told).

## What is yours to decide

The module names and layout; whether the quadratic table is one theorem or a family; how much of the character
machinery already in the library (`CharacterColouring`, the winding form of the criterion's forward half, the
relation-lattice modules) each leaf should stand on; the strongest true form of each statement. If the leaf list
shows that one clause is much further than the others, say so and say which you would build first.

Not yours here: the upper halves; the five-colour chain (it has its own architecture on branch `fs131-wch`); a
new derivation — a missing lemma is a question to me, and I route it to a deriver.

## The machine

**This session is on the laptop: 12 cores, 31 GB — the desktop's numbers in `RUNNING.md` and `LEAN.md` do not apply
today.** Measured today by the other planners: one file through `lake env lean` costs 3 to 24 seconds and 3.6 GB; a
build is a 24-minute walk whatever changed, with 4.5 GB for its largest process. Run the memory tool as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --name kn4 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2`, from inside your worktree. A
build: `--mem 10 --cpus 8 -- env MEMMAX=10G BATCH=2 ./scripts/build.sh` from inside the worktree; never `lake build`.
Others build too: on exit 75 wait and retry. Your first build recompiles modules the others' did not, so tell me its
wall time and peak memory. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at
power-off: anything your record cites lives under `data/fs131/kn4/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**;
a failed push is not an error to fix.

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).
'''
open(ROOT+"data/fs131/briefs/FS131-KN4-three-four-colours-plan.md","w").write(b); print("ok",len(b))
