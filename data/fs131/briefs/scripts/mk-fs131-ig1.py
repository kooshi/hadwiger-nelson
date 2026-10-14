exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IG1: the chain's fourth implementer — lane G, the pieces (Rigidity/Pieces), PE-1′ and Lemma Γ.
# Usage: mk-fs131-ig1.py <item of KN8's hand-back> <item of KPD1's hand-back> <item of IDG1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
K8,KP,KD=[int(x) for x in sys.argv[1:4]]
TREE="fs131-wq1"; BR="fs131-wpg"; JOB="FS131-IG1"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wdg"
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if "iq1/stmt" not in l and "data/fs131/idg1/" not in l]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
L20=Q(C,"NF2-LEAF-20: ")
D3=Q(C,"- 2026-10-14 — **PE-1′'s connectedness is a third duality fact","§ Dated lines")
P8=W+"plans/FS131-KN8-chain-split.md"; PP=W+"plans/FS131-KPD1-pontryagin.md"; ID=W+"plans/FS131-IDG1-implementation.md"
RG=W+"Proofs/HadwigerNelson/Rigidity/"
for p in (P8,PP,ID,RG+"Pieces.lean",ROOT+"plans/FS100-X02D-derivation.md"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the five-colour chain: the pieces, PE-1′ and Lemma Γ, proved

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the chain's fourth implementer — lane G: the fifteen leaves of the pieces' module (the dual of a finitely generated piece of the ring as a solenoid, the rotation action on it totally irreducible, the chain of pieces, and Lemma Γ), over the dual group and Pontryagin duality the last implementer proved
  launch: now, in the last implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; the chain's planner works in `fs131-wch` (it may type statements in `Rigidity/PositiveEntropy.lean`, among them a binder dropped from `haar_or_zero_entropy`; I join the two); the port's implementer works in `fs132-wi1`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if a leaf reads a statement of another module that is not yet typed or reads it in a form it does not have, and with one line when half the leaves are proved; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wdg` at `{TIP}`; its build is current for that commit): `Proofs/HadwigerNelson/Rigidity/Pieces.lean` — **proofs, private helpers and import lines only, no statement changes, no definition changes**; and, from the last implementer's drafts (its record § Drafts for the landing: the `ARCHITECTURE.md` rows of its six modules, and the stale module and theorem docstrings it lists), those rows and those docstrings (prose only); your checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/ig1/`; `data/fs131/reports/{JOB}.md`. **Not** `Rigidity/PositiveEntropy.lean`, `Rigidity/EntropySplitMax.lean`, `Rigidity/ChainAtTA.lean`, `Rigidity/Entropy.lean`, `exists_admissiblePair`, any module under `Outside/`. Untracked files from older jobs are in this tree (`data/fs131/iq1/stmt/`, and the last implementer's plain-text dumps `data/fs131/idg1/*.txt`, which it committed compressed): leave them, commit none of them. Nothing on `main`
  budget: {BUDGET}

Hello. The chain's positive-entropy half reads one classical theorem, Einsiedler and Lindenstrauss's rigidity for
commuting automorphisms of solenoids, declared as an axiom. To apply it, the chain cuts the dual of its ring into
pieces, each a solenoid on which the rotations act totally irreducibly, and proves Lemma Γ there. The last
implementer proved the dual group and the Pontryagin duality these pieces read. You prove the pieces.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The pieces are where the declared theorem meets the chain: Lemma Γ is the statement the positive-entropy split reads,
and its hypotheses are exactly what the release's ergodic decomposition outputs. Proving it makes the split's module
the last of the positive-entropy half.

## The statements

The leaf of the chain's claim list (`data/fs131/claims-NF2.md`) the pieces serve, and the dated line that re-routed
their connectedness:

{L20}
{D3}
The three hand-backs that typed and prepared this module, as I logged them (their words in quotation marks, the
rulings mine):

{item(K8)}
{item(KP)}
{item(KD)}
**Your leaves** are the fifteen `sorry`s of `{RG}Pieces.lean`. Their statements are the file's; read them in the
source. **The plans**: the split planner's record `{P8}` § 2.5 (leaves 1–7 and 10–14), the duality planner's record
`{PP}` § 4.2 (leaves 8 and 9, re-pointed to the duality theorems, which are now proved), and the derivation
`plans/FS100-X02D-derivation.md` (PE-1′, § 3.1 Lemma Γ). Some leaves read statements of other modules that are still
leaves there (`haar_or_zero_entropy` in `Rigidity/PositiveEntropy`; the entropy file's tenth leaf): use them as stated;
your records will print `sorryAx` through them until those land, and your report lists which. The last implementer's
record `{ID}` is the worked pattern for this chain's files.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; each leaf's statement restated in one
   line beside its plan; the stored statements of `Pieces` dumped from the built tree before any edit.
2. **The leaves** (saved stages every few, and the one line to me at half); re-price what is left from the first two.
3. **The rows and docstrings** from the last implementer's drafts; `tools/check_architecture.py` passes.
4. **No statement and no definition changed**, shown from the kernel's side against item 1's dump (a planted change
   watched firing); no `sorry` left in `Pieces`; one build under the slot with no warning from it; the axioms of every
   public declaration of `Pieces` printed from the built tree — the standard three, the declared printed theorem where
   a record applies it, and `sorryAx` only through the named leaves of other modules — each listed, with a planted
   record watched showing.
5. **Drafts for the landing**, in your record: the audit's block for `Pieces`; the model for each hypothesis that lacks
   one (PE-1′'s non-degenerate model of the declared theorem's hypotheses is one the earlier planners named); any
   `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports a proof needs; another route for a leaf where the plan's does not go through (tell
me which). An unread binder of a statement in `Pieces` is dropped without asking, listed in your statement check as a
ruled difference and named in your report (the standing word of item 726). Not yours: any other change to a statement
or definition; the files listed as not yours; the declared printed theorem; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with small modules stale about 7 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ig1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh` from inside the worktree; never `lake build`.
On exit 75 wait ten minutes and retry; the port's build of the whole library may hold the slot for up to an hour. Stop
a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your record cites
lives under `data/fs131/ig1/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-pieces.md","w").write(b); print("ok",len(b))
