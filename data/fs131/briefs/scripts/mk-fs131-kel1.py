exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KEL1: de Bruijn's planner prices the formalization of Einsiedler–Lindenstrauss Theorem 1.3 (W2), from first leaves.
# Usage: mk-fs131-kel1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-KEL1"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
assert sh("git","-C",W,"rev-parse","HEAD")==sh("git","-C",ROOT,"rev-parse","main")
MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main")
PDF="/home/kooshi/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf"
assert os.path.exists(PDF) and os.path.isdir("/home/kooshi/source/math/lean/OAI/NumberTheory/DukePrimeDegree")
for p in ("plans/FS131-KN7-chain-next.md","plans/STUB-mr-in-lean.md","Proofs/HadwigerNelson/Rigidity/PositiveEntropy.lean",
          "Proofs/HadwigerNelson/Rigidity/ZeroEntropyClosed.lean","plans/EXT-OAI1-audit.md","LEAN.md"): assert os.path.exists(W+p),p
W2=Q("data/fs131/REQUEST-2026-10-13.md","W2: ")
W4=Q("data/fs131/REQUEST-2026-10-13.md","W4: ")
W5=Q("data/fs131/REQUEST-2026-10-13.md","W5: ")
I825=item(825)
BIB=Q("BIBLIOGRAPHY.md","| **[EinsiedlerLindenstrauss2022]** |")
def lean_lines(path,first,last):
    ls=open(ROOT+path).read().split("\n")[first-1:last]
    return "".join("> "+l+"\n" for l in ls)+"> — source: "+path+"\n"
AX=lean_lines("Proofs/HadwigerNelson/Rigidity/PositiveEntropy.lean",81,93)
assert AX.startswith("> axiom positive_entropy_rigidity") and "= 0\n> — source" in AX
b=f'''# Brief {JOB} — what would it take to prove Einsiedler–Lindenstrauss Theorem 1.3 in this library? A price from first leaves

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you run on Opus
  role: the kernel lane's planner pricing one outside theorem — the library's one declared outside theorem from ergodic theory, `Rigidity.positive_entropy_rigidity` — as a formalization: its proof's tree read from the paper and what it cites, each node set against what Mathlib, this library and the outside release's Lean hold, the top of the tree as a skeleton, the first two leaves attempted, and a price in lines of Lean
  launch: now, in a worktree of your own cut from `main`; beside you a second kernel planner (on another question, in another worktree) and a filing job; none writes a file you write
  mission: § Why this job
  statements: § The theorem
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if the declared statement says more or less than the printed theorem, or if a route around the theorem appears for the library's one use of it; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (rules 6 and 13 changed today: never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building
  record: `plans/{JOB}-el-price.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (cut from `main` at `{MAIN}`; `.lake/packages` a symlink to the main tree's, `.lake/build` a copy of the main tree's gated build): `plans/{JOB}-el-price.md`; skeleton and leaf modules under `Proofs/HadwigerNelson/` in files you create, each named in your record, and their import lines in `Proofs.lean`; your scripts and outputs under `data/fs131/kel1/`; `data/fs131/reports/{JOB}.md`. Never the declared axiom's module or any existing module (draft edits in your record); nothing in `~/source/math` (read it, never write it). Commit on your branch by explicit path; never push
  budget: about 400k by the harness's count, as guidance; save a stage after each stage below; hand back at a saved stage before about 500k

Hello. Kooshi asked for this price two days ago and it was right to wait until the chain that uses the theorem had
landed; it has, and the repository is public. This is the question of what the last outside theorem under the
number-field results would cost to bring inside.

## Why this job

{W2}
The chain landed on 2026-10-15: `χ(ℚ(√47)²) = 5` and the main clause through five (`Rigidity.min_localBound_five_le_chromaticNumber`)
are kernel-checked on the standard three axioms and two declared outside theorems — Weil's bound and this one. Every
measure-rigidity consequence in the library (`Rigidity.mrPlus`, the entropy split) rests on it. A price is a decision input
for Kooshi, not a commitment; the counter-priors in `CLAUDE.md` say formalization effort never ranks a route, and the price
is asked for so he can plan, not so a route is chosen by it.

How a price is computed here — in lines of Lean, converted at the project's measured rate:

{W5}
{I825}
And the library's pin, which any port of outside Lean must meet:

{W4}
## The theorem

The declared statement (its docstring, above it in the module, quotes the page and gives its reading choices):

{AX}
The paper, and how much of it this project has read:

{BIB}
The paper is in the document library at `{PDF}`. The statement's read-back against the page is
`plans/FS131-KN7-chain-next.md` § Stage 3. The library's own entropy (`Rigidity.ksEntropy`, the pinning theorem
`Rigidity.tendsto_blockEntropy_div`) and the theorem's one consumer are in `Proofs/HadwigerNelson/Rigidity/`. The outside
release `[OAIMath2026]` (cloned at `~/source/math`, Apache-2.0, Lean 4.34.1, a later toolchain than this library's) holds
a Lean folder, `~/source/math/lean/OAI/NumberTheory/DukePrimeDegree/` (886 files), that names conditional entropy for countable
partitions, leafwise measures and steps of Einsiedler–Katok; the stub `plans/STUB-mr-in-lean.md` (FS-113) records what was
known of it on 2026-10-07; the release's earlier ports into this library and their method are `plans/EXT-OAI1-audit.md` and
the `Outside/OAI158*` modules.

## Done means

1. **Stage 1 — the readback.** Check each quotation above against its source; restate in your record the theorem, its
   one use in the library, and what a price must contain.
2. **Stage 2 — the tree.** The proof of Theorem 1.3 as the paper gives it, down to what it cites (its sections, and each
   outside result it invokes, with the citation's own statement found and read where it is held — the document library
   first, then `BIBLIOGRAPHY.md`), as a tree of statements; per node, what Mathlib at this pin, this library and the
   release's Lean hold (by declaration name), and the gap. Name the deepest node and what it needs. A reading status per
   section of every paper you open (standing rule 10), and `BIBLIOGRAPHY.md` rows proposed for what you read.
3. **Stage 3 — two leaves, attempted.** The tree's top as Lean statements with `sorry`, built through `./scripts/build.sh`
   under the slot, and two leaves of your choice proved or taken as far as they go — chosen to calibrate, one from the
   release's port path (if its Lean is usable here) and one written fresh. Their lines and active hours are the price's
   calibration (`CLAUDE.md` § What compute actually helps: re-price from the first two leaves, never from a plan's table).
4. **Stage 4 — the price.** Lines of Lean per node and in total, low and high, with the calibration from stage 3, converted
   at the measured rate; what part is porting the release (at this pin) and what part is new; the order you would build it
   in; and whether a narrower statement suffices for the library's one use (the entropy split at one non-torsion rotation)
   and what it would save. Nothing with a `sorry` reaches `main`; the skeleton stays on your branch.
5. **The report**, in the standing rules' form.

## What is yours to decide

Which leaves calibrate best, the skeleton's shape, whether to price a port of the release's development or a fresh proof
or both, and how deep to read the cited machinery — say where you stopped and why. If the declared statement is stronger
or weaker than the page, or a shorter road to the library's one use exists (a weaker rigidity theorem that the entropy
split could rest on), report it: that is a finding at least as valuable as the price.

## The machine

This is the laptop: 12 cores, 31 GB, shared with another planner. Every Lean build and every `lake env lean` over about 2 GiB
goes through the slot with this machine's settings, from inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 10 --cpus 4 -- env MEMMAX=10G BATCH=4 ./scripts/build.sh`;
never `lake build`. On exit 75 another job holds the memory: wait ten minutes and retry. Never build the release itself
(it is on a later toolchain, v4.34.1, and no build of it exists on this machine); read its sources. `lake env lean` (with
`-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only. `/tmp` is a tmpfs: keep anything your record
cites under `data/fs131/kel1/`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-el-price.md"
open(out,"w").write(b); print(out)
