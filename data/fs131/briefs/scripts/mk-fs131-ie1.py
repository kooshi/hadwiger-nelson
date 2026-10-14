exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IE1: the five-colour chain's first implementer — the port of three entropy files of the outside release, then the entropy file's leaves.
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE="fs131-wch"; BR="fs131-we1"; JOB="FS131-IE1"; W=WT+TREE+"/"
assert sh("git","-C",ROOT,"branch","--list",BR)=="" and not os.path.exists(ROOT+f"data/fs131/briefs/{JOB}-entropy-base.md")
assert sh("git","-C",W,"status","--porcelain")=="" and sh("git","-C",W,"branch","--show-current")==TREE
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
L13=Q(C,"NF2-LEAF-13: ","§ The chain's leaves (the map's, numbered as there)")
D18=Q(C,"- 2026-10-14 — **NF2-LEAF-18 is answered")
PLAN=W+"plans/FS131-KN6-chain-first-layer.md"; K3=W+"data/fs131/kn3/"
IA=WT+"fs133-wk1/plans/FS133-IA1-implementation.md"
for p in (PLAN,K3+"claims-M0-entropy-port.md",K3+"claims-M1-entropy.md",IA,ROOT+"tools/fs132_i2_port.py"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the entropy base of the five-colour chain: port three files of the outside release, then prove the chain's own entropy file over them

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the first implementer on the chain under "five colours at the square root of 47" — two of the four lanes its planner cut for the entropy base: the port of three files of the outside release (made by the generator, kernel-checked here, no axiom), and over them the leaves of the chain's own entropy file
  launch: now, in the planner's tree on a new branch — the planner has handed back and nobody else writes there; a landing of another line is in flight in `fs131-wrc` and has priority on the build slot; an implementer of another milestone works in `fs133-wk1`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if the port needs a patch on anything but a proof line, if a scan of a file you are about to copy has a hit, and with one line when the three ported files build; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`{TIP}`; its build is current for that commit): the three new generated modules the plan names for its lane P, with their lines in the build's lists and their rows in `ARCHITECTURE.md`; `Proofs/HadwigerNelson/Rigidity/Entropy.lean` — **proofs and private helpers only, no statement changes, no definition changes**; your generator and its checks under `tools/` (named for this job); `plans/{JOB}-implementation.md`; `data/fs131/ie1/`; `data/fs131/reports/{JOB}.md`. Nothing on `main`; nothing in the other three files of the chain's first layer; nothing in the outside release's clone, which is read only and in which nothing is run
  budget: {BUDGET}

Hello. This chain is the first-ranked thing this project has to show and the longest road left. Two planners laid
it out; yesterday its first four files went through a build for the first time; and the derive lane removed two
classical theorems from its path. You are the first to prove anything in it.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
Under "the plane over the field of the square root of 47 needs exactly five colours" sit two deductions of ours from
one printed theorem, and both speak of the entropy of a measure-preserving map. Mathlib has none. The outside
release this library already builds on has an entropy development, and its planner measured that four of its files
compile at this library's version of Mathlib after seven one-word renames. So the chain's entropy comes in two
layers: the release's files by port — every proof checked by this kernel, no axiom — and over them the chain's own
definitions, with the bridge that says the two entropies are one number. Everything later in the chain reads this
base.

## The statements

The leaf of the chain's claim list your two lanes answer, and the dated line that says what the zero-entropy side
now reads (the whole list is `data/fs131/claims-NF2.md`):

{L13}
{D18}
**Your leaves**: the plan's lane **P** — three ported modules (its § 5.1 names the release's files, their line
counts, what each needed at this pin by trial, and the scan each passed) — and lane **E**, the leaves of
`Proofs/HadwigerNelson/Rigidity/Entropy.lean` that the plan's § 5.4 numbers 1 to 9; the tenth waits on a port that
is not planned yet and is **not yours**. Their statements are the file's; read them in the source. **The plan**:
`{PLAN}` — § 5.1 (the port), § 5.2 (why the chain's entropy is an infimum, and what that makes safe), § 5.3–5.4 (the
statements and a plan per leaf), § 5.6 (the lanes), § 3c (a trap its last pass found: with two measurable-space
binders in scope a bare measure takes the last). The planner's draft claim lists for the two modules:
`{K3}claims-M0-entropy-port.md`, `{K3}claims-M1-entropy.md`. A port of the same release made yesterday by another
implementer, as a worked pattern: `{IA}` (its stage 2: the generator, the read-back, what the port needed).

## Done means

1. **Readback** (a saved stage): the three quoted lines checked against their sources; each leaf's statement
   restated in one line beside the plan's route; the stored statements of the entropy file dumped from the built
   tree before any edit.
2. **Lane P, the port** (a saved stage): each of the three modules made with the generator the earlier ports used
   (`tools/fs132_i2_port.py` is the pattern: it refuses a patch to a statement or a definition), the licence text
   beside them (`Proofs/HadwigerNelson/Outside/OAIMath2026-LICENSE.txt`), and every ported declaration printing the
   standard three axioms and nothing else. **Before any file of the release is copied, the scan**: the text is
   searched for anything that runs code while a file elaborates, with its planted control — the planner's
   `tools/fs131_kn6_release_copy.py` does this on the branch; a hit is a message to me before anything is compiled.
   **The read-back across the two pins**: for the two files that import only Mathlib, as the earlier ports did it;
   for the maximal inequality, the generator's refusal to patch a statement is enough — its read-back would need 89
   files of the release compiled, and a port's proofs are checked here, so the read-back is an instrument and not a
   gate. The release's stored statements at its pin are printed from our audit's working copy of it
   (`/home/kooshi/.cache/ext-oai1/lean`, a copy of ours — the clone at `~/source/math` stays untouched): elaborating
   the two scanned files there, one `lake env lean` at a time under the slot and writing no compiled file, is
   within this job; compiling anything more of the release there is a question for me first. Send me the one line
   when the three build.
3. **Lane E, leaves 1 to 9** (saved stages as they fall): 1–4 need nothing; 5–9 read the first two ported files.
   Re-price what is left from the first two you finish and say so in your record.
4. **No statement and no definition changed**, shown from the kernel's side against the dump of item 1 (a planted
   change watched firing); no `sorry` left in your files but the tenth leaf; one build under the slot with no
   warning from them but that leaf's; the axioms of every public declaration of your files printed from the built
   tree — the standard three and nothing else (the entropy file must not read the chain's declared printed theorem),
   with a planted record watched showing.
5. **Drafts for the landing**, in your record: the audit's block for your files; the model for each hypothesis;
   what the port needed, per file, as a measurement.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; how the ported text is cut into modules beyond the plan's three names; another route
for a leaf where the plan's does not go through (tell me which). Not yours: any statement or definition; the tenth
leaf; the chain's other lanes; the declared printed theorem; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB.** Measured: one file through `lake env lean` costs 3 to 24 seconds
and 3.6 GB; a build with only small modules stale takes about 7 minutes. Write against `lake env lean` and build
rarely; do not edit a module file while a build walks.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ie1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree (the
planner's `{W}data/fs131/kn6/lean1.sh` does this). The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8
./scripts/build.sh` from inside the worktree; never `lake build`. **A landing's gate steps have priority on the
slot**, and another implementer builds from time to time: on exit 75 wait ten minutes and retry; a third build of
12 GiB was starved yesterday, so ask for 10. Stop a process by its PID, never by matching its command line. `/tmp`
is wiped at power-off: anything your record cites lives under `data/fs131/ie1/`. Scratch copies of the release's
text are kept under the tree's ignored `build/` folder and are in no commit: the release's text enters this
repository only inside a ported module that carries its licence.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-entropy-base.md","w").write(b); print("ok",len(b))
