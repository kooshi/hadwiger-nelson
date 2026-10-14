exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KO1: the planner of the approved port of the outside release's transfer proof.
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE="fs132-wi1"; BR="fs131-wp1"; JOB="FS131-KO1"; W=WT+TREE+"/"
assert sh("git","-C",ROOT,"branch","--list",BR)=="" and not os.path.exists(ROOT+f"data/fs131/briefs/{JOB}-port-plan.md")
assert sh("git","-C",W,"status","--porcelain")==""
MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main"); WB=sh("git","-C",ROOT,"rev-parse","--short=9","fs133-wb1")
RQ="data/fs131/REQUEST-2026-10-13.md"
W4=Q(RQ,"W4: ")
ROW=Q("plans/EXT-OAI1-audit.md","| `proper_to_borel_weak` (the transfer)","§ The pieces to adopt, and what each rests on (measured)")
ROW2=Q("plans/EXT-OAI1-audit.md","| the headline |","§ The pieces to adopt, and what each rests on (measured)")
IAP=WT+"fs133-wk1/tools/fs133_ia1_port.py"; IER=WT+"fs133-wk1/plans/FS133-IA1-implementation.md"; IEP=WT+"fs131-wch/tools/fs131_ie1_port.py"
for p in (IAP,IER,IEP,ROOT+"tools/fs132_i2_port.py","/home/kooshi/.cache/ext-oai1/lean"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — plan the port of the outside release's transfer proof, so that two declared outside theorems of this library become theorems under their present names

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-14. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: the kernel lane's planner for one approved port — compute what of the outside release must come here for its transfer theorem and its rigidity lemma to be proved in this library, map it against what three earlier ports and one module's copies already hold, price it from a trial of its first modules, and cut it into lanes for implementers with the generator; and say how each declared theorem becomes a theorem under its name without one statement of ours moving
  launch: now, in a tree whose job finished long ago, on a new branch cut from `main`; a planner works on the five-colour chain in `fs131-wq1`, and the Clerk files a landing's drafts in `fs131-wrc`; no landing is in flight; the build slot is shared
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** with your proposal for how the port meets the density equality's unlanded branch (§ Done means item 5) before you plan around either choice; at once if a declared theorem's stored statement cannot be matched by a ported theorem's at this pin; before you build anything of the release beyond the audit's compiled copy (say what and how large); the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/FS131-KO1-port-plan.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from `main` (`{MAIN}`); the tree has no compiled library — bring one in by copying from `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wrc` (the tree whose gate passed last; read it, write nothing there), saying in your record what was copied and how it was compared: new generated modules under `Proofs/HadwigerNelson/Outside/` for the trial, with their lines in the build's lists; your generator and checks under `tools/` named for this job; `plans/FS131-KO1-port-plan.md`; `data/fs131/ko1/`; `data/fs131/reports/{JOB}.md`. **No existing module of this library changes** — not `Outside/OAI158.lean`, not the ported modules, not any statement. Nothing on `main`; nothing in another tree; nothing written or run in the release's clone at `~/source/math`
  budget: about 400k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, after the cone and the overlap map, after the trial, and after the plan; hand back at a saved stage rather than start a step you cannot finish

Hello. Kooshi approved this port this morning; this job turns the approval into a plan implementers can follow.

## Why this job

His words:

{W4}
This library holds several results on two declared outside theorems from the OpenAI release: its transfer from
arbitrary to measurable colourings (`Outside.OAI158.proper_to_borel_weak`, on `main`, with twelve theorems resting on
it — the plane's chromatic number equals its measurable ones, and the disc criterion toward seven), and a rigidity
lemma the density equality's module declares (`Spectral.residual_fourier`, on that module's branch, not yet landed),
whose cone lies inside the transfer's. Each is the release's own theorem, kernel-checked in the release's library and
trusted here. A port brings the proofs here and lets this kernel check them, so that both become theorems and those
results rest on the standard three axioms. Three ports of parts of the same release were made in the last two days,
each needing a few one-word renames per thousand lines; this is the first port of a whole theorem's cone.

## The statements

The audit's measurement of the cone, and of the release's headline (which stays declared — it is not part of this
port):

{ROW}

{ROW2}

What I ruled when scheduling it, with what its planner must settle first:

{item(728)}
The last port of this family, and how its declared statement was matched with the release's by this library's
kernel (its leaf R is the pattern for the switch below):

{item(718)}
Where everything is. The audit `plans/EXT-OAI1-audit.md` (where the release was built and audited, its cones, its
modules); the audit's compiled copy of the release at its own pin, `/home/kooshi/.cache/ext-oai1/lean` (ours; the
clone at `~/source/math` is never written or run); `LEAN.md` § Assumptions: outside theorems and our own (the
bullets on imports and on ports: what a declared theorem carries, how a port is made, the licence). **What is already
here, which the full port must meet without a declaration existing twice:** the nine generated modules of FS-132's
port on `main` (`Proofs/HadwigerNelson/Outside/OAI158Palette.lean` and the eight after it in `Proofs.lean`), made by
`tools/fs132_i2_port.py`; the declared module `Proofs/HadwigerNelson/Outside/OAI158.lean` with its copied
definitions; and on the density equality's branch `fs133-wb1` (at `{WB}`, not on `main`): the generated
`Outside/OAI158Transfer` and the declared `Outside/OAI158Rigidity` with six copied definitions — the generator
`{IAP}` and its record `{IER}`. A port of another family, for the generator's latest form: `{IEP}`.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the audit's sections on the cone
   read; the three earlier ports' generators and records read for what each did at this pin.
2. **The cone and the overlap map** (a saved stage): the used cone of the transfer theorem and of the rigidity
   lemma, computed from the release's compiled constants in the audit's copy, per release module; against it, every
   declaration this library already holds from the release (ported or copied), and how the full port treats each —
   kept and imported, replaced by its ported original, or deleted — so that no name is declared twice and no
   statement of ours moves.
3. **The switch**, for each declared theorem: how the `axiom` becomes a `theorem` under its present name — the
   ported theorem's stored type checked by this kernel to be definitionally equal to the declared one (the last
   port's leaf R did this for the rigidity lemma) — and what the landing then reads: which records move from the
   audit's imported list to its clean one, and how the assumptions counts move.
4. **A trial of the first modules** (a saved stage): two or three modules of the cone generated and elaborated at
   this pin; the patches each needed; the rest priced from them, not from line counts.
5. **The plan** (a saved stage): the cone cut into lanes that share no file, each an implementer's job with the
   generator; their order; what each writes; **and how the port meets the density equality's branch**, which holds
   two of the modules concerned and has not landed — propose (port on `main` and let that branch take it at its
   join; or port on top of that branch; or another way) and **message me before you plan around it**.
6. The report in the standing rules' form, with the residual cone of the release's headline measured for the
   record.

## What is yours to decide

How the cone is cut; the generator's form (one of the three earlier ones, extended); the trial's modules; how the
copies of definitions are retired. Not yours: any statement of ours; a port of the release's headline; anything on
`main`; the choice of branch strategy before my ruling.

## The machine

**This session is on the laptop: 12 cores, 31 GB; 330 GB of disk free.** One file through `lake env lean`: 3 to 24
seconds, 3.6 GB; a build with only small modules stale about 7 minutes. The release's compiled copy is about 11 GB and
its cones were printed there before (the last port's record says how).

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ko1 -- <command>`

One file: `--mem 4 --cpus 2` from inside your worktree. A build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8
./scripts/build.sh`; never `lake build`. On exit 75 wait ten minutes and retry. Stop a process by its PID, never by
matching its command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/ko1/`.
Copies of the release's text outside a generated module stay under the tree's ignored `build/` folder and are in no
commit. **When you hand back, say whether this tree's compiled library is still needed**; finished trees' copies are
deleted to keep the disk free.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-port-plan.md","w").write(b); print("ok",len(b))
