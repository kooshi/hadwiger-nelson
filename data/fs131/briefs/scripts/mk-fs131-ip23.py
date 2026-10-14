exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IP23: the chain's port lanes P2 (the ergodic decomposition) and P3 (the generating-sequence theorem) of the
# release's family 015, then the two leaves they close: the entropy file's tenth and the split's first.
# Usage: mk-fs131-ip23.py <item of KN7's hand-back> <port-rule items, comma-separated> <item of IG1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
K7=int(sys.argv[1]); RU=[int(x) for x in sys.argv[2].split(",")]; KG=int(sys.argv[3])
TREE="fs131-wq1"; BR="fs131-wp23"; JOB="FS131-IP23"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"branch","--show-current")=="fs131-wpg"
assert [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if not any(x in l for x in ("iq1/stmt","data/fs131/idg1/","data/fs131/ig1/"))]==[]
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
D17=Q(C,"- 2026-10-14 — **NF2-LEAF-17 is answered in part","§ Dated lines")
P7=W+"plans/FS131-KN7-chain-next.md"; IE=W+"plans/FS131-IE1-implementation.md"; GEN=W+"tools/fs131_ie1_port.py"; RG=W+"Proofs/HadwigerNelson/Rigidity/"
for p in (P7,IE,GEN,RG+"Entropy.lean",RG+"EntropySplitMax.lean",W+"tools/fs131_kn7_release_copy.py",W+"Proofs/HadwigerNelson/Outside/OAI015Maximal.lean"): assert os.path.exists(p),p
RULES="\n".join(item(n) for n in RU)
b=f'''# Brief {JOB} — the five-colour chain: two more files of the outside release ported, and the two leaves they close

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: an implementer on the chain under "five colours at the square root of 47" — its port lanes P2 and P3: the outside release's ergodic decomposition for a countable group acting, and its generating-sequence theorem for entropy, made modules of this library by the first implementer's generator with every proof kernel-checked here; then the two leaves of the chain they close, the entropy file's tenth and the positive-entropy split's first
  launch: now, in the last implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; the chain's zero-entropy planner works in `fs131-wch`, the port of the other release family in `fs132-wi1`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a scan of a file you are about to copy has a hit, if the port needs a patch on anything but a proof line beyond the classes ruled below, if a leaf is false as stated or needs a hypothesis it lacks, and with one line when the two ported bundles build; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wpg` at `{TIP}`; its build is current for that commit): new generated modules under `Proofs/HadwigerNelson/Outside/` for the two bundles, with their lines in the build's lists and their rows in `ARCHITECTURE.md`; the generator `tools/fs131_ie1_port.py` only by a change that comes to me first; in `Proofs/HadwigerNelson/Rigidity/Entropy.lean` the proof of `ksEntropy_eq_iSup_ksEntropyOn` and in `Proofs/HadwigerNelson/Rigidity/EntropySplitMax.lean` the proof of `condExpKernel_ergodicDecomposition` — **proofs, private helpers and import lines only, no statement changes**; your checks under `tools/` named for this job; `plans/{JOB}-implementation.md`; `data/fs131/ip23/`; `data/fs131/reports/{JOB}.md`. **Not** any other leaf, any other module, the declared printed theorem. Untracked files from older jobs are in this tree (`data/fs131/iq1/stmt/`, plain-text dumps under `data/fs131/idg1/` and `data/fs131/ig1/`): leave them, commit none of them. Nothing on `main`; nothing in the outside release's clone, which is read only and in which nothing is run
  budget: {BUDGET}

Hello. The chain reads two more theorems of the outside release than its first port brought in: the ergodic
decomposition of a measure invariant under a countable group, in canonical form, and the generating-sequence theorem
for entropy. The chain's third planner measured both by trial: hours, not days. You port them and close the two leaves
waiting on them.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The release's proofs are checked by this kernel when ported, so they add no axiom; and the chain's positive-entropy
split, whose pieces were just proved, waits on the decomposition for its first leaf.

## The statements

The dated line of the chain's claim list (`data/fs131/claims-NF2.md`) that says what of the release the chain reads:

{D17}
The third planner's hand-back; the port rules this project ruled for the other release family, which bind this port
too with the same conditions (a site outside them comes to me); and the last implementer's hand-back:

{item(K7)}
{RULES}
{item(KG)}
**Your work, in order.** (1) **Lane P2**, the ergodic decomposition: the third planner's bundle (its record `{P7}` §
Stage 4: `/home/kooshi/source/math/lean/OAI/NumberTheory/PrimePackets/KernelEntropy.lean` ll. 4–47 and 220–558, `/home/kooshi/source/math/lean/OAI/NumberTheory/PrimePackets/ErgodicDecomposition.lean` ll. 4–179,
three renames inside proofs), its statement `PrimeDegreePackets.action_ergodic_decomposition` kept as the release's.
(2) **Lane P3**, the generating-sequence theorem: the eleven files of `/home/kooshi/source/math/lean/OAI/NumberTheory/PrimePackets/EntropyGeneratingSupremum.lean`'s cone beyond the
two already ported, one rename. Both by the first implementer's generator `{GEN}` (its record `{IE}` is the worked
pattern: the scan before any copy, the licence notice, the read-back across pins), with the trial's copy tool
`{W}tools/fs131_kn7_release_copy.py` for the scan. (3) **The entropy file's tenth leaf** `ksEntropy_eq_iSup_ksEntropyOn`
in `{RG}Entropy.lean`, by the route the third planner wrote against the ported theorem's exact hypotheses (§ Stage 4,
"What each needs at the consumer"). (4) **The split's first leaf** `condExpKernel_ergodicDecomposition` in
`{RG}EntropySplitMax.lean`, the ported decomposition at the rotation action (its docstring names the release's theorem).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the two bundles' file lists and line
   counts restated from the trial; the stored statements of the two leaves' files dumped before any edit.
2. **Lanes P2 and P3** (saved stages): the scan with its planted control before any copy; each module generated,
   elaborated with 0 errors and 0 warnings, its declarations' axioms the standard three and nothing else (a planted
   `sorry` watched firing), its read-back across pins IDENTICAL, UP-TO-INSTANCES, or in a ruled class; the one line to
   me when both build.
3. **The two leaves** (a saved stage each), no statement changed, shown from the kernel's side (a planted change
   watched firing).
4. One build under the slot with no warning from your files; the axioms of every public declaration of the two
   leaves' files printed from the built tree, each listed — the standard three, or `sorryAx` only through named leaves
   of other modules.
5. **Drafts for the landing**, in your record: the audit's block; the `LEAN.md` lines for what the port needed.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; imports; the modules' names and cuts beyond the trial's bundles; another route for a leaf
where the plan's does not go through (tell me which). An unread binder of a statement in your two files is dropped
under item 726's word, listed and named. Not yours: any statement of the release outside the ruled classes; any other
leaf; the generator beyond a change I rule; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with small modules stale about 7 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ip23 -- <command>`

One file: `--mem 4 --cpus 2` from inside your worktree. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8
./scripts/build.sh`; never `lake build`. On exit 75 wait ten minutes and retry; the port's landing may hold the slot
for up to an hour. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off:
anything your record cites lives under `data/fs131/ip23/`. Scratch copies of the release's text stay under the tree's
ignored `build/` folder; the release's text enters a commit only inside a generated module that carries its licence
notice. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-ports-p2-p3.md","w").write(b); print("ok",len(b))
