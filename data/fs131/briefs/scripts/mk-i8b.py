exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import subprocess
TREE="fs131-w8b"; JOB="FS131-I8B"; W=WT+TREE+"/"
BASE=subprocess.run(["git","-C",W,"rev-parse","--short=8","HEAD"],capture_output=True,text=True).stdout.strip()
assert BASE,"make the worktree first"
A8=subprocess.run(["git","-C",ROOT,"rev-parse","--short=8","origin/fs131-w8a"],capture_output=True,text=True).stdout.strip()
P="Proofs/HadwigerNelson/Plane/RingCalculus/"
KP=W+"plans/FS131-w8-kernel-plan.md"
IP=WT+"fs131-w8a/plans/FS131-I8A-implementation.md"
K1PRE="   under `SimpleOn {x}` the tiles of `x` are the chart's sectors"
H91="§ 9.1 The statements the proofs derive from"; H98="§ 9.8 The handoff"; H55="§ 5.5 The coordinator's ruling on `star_anti`, and what I did with it"
b=f'''# Brief {JOB} — wave 8, the join and the shared part: the first implementer's branch merged, `star_anti` at its ruled statement and proved, and the three lemmas two later implementers share, in a module of their own

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: wave 8's second implementer — merge the first implementer's finished branch into the wave's line, make one ruled statement change (`star_anti` gains two hypotheses) and prove that leaf, and state and prove the three shared helper lemmas the second planner named in prose, in a new module saved first, so that two implementers can start from your tip in parallel
  launch: when a slot frees, on a branch cut from the commit at which the wave's second planner handed back; nobody else works on wave 8 while you do
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job when the helper module is saved (its commit hash and the three statements, at once: two jobs wait on that message), for a merge conflict in a Lean file, if the ruled hypotheses do not close `star_anti` or the leaf is false with them (at once, with the configuration), if a helper cannot be stated so that the uses the plan names go through, or for a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from `fs131-w8` at `{BASE}`): the merge's files; `{P}Star.lean` — `star_anti`'s statement by the ruled change, its docstring, its proof, and helpers under names no other module declares; **a new module** `{P}StarChart.lean` (or a name you prefer) for the shared lemmas, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner); `plans/{JOB}-implementation.md`, `tools/fs131_i8b_*.py`, `data/fs131/i8b/`, `data/fs131/reports/{JOB}.md`; **not** any other statement, the two modules of semi-hub rows (`SemiHub`, `SemiHubPlaces`: their leaves are the next two implementers'), `outerAdj`, the wave's foundation, any landed module, `main`
  budget: {BUDGET}

Hello. You are proving part of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked
ones; waves 1–5, the first half of wave 6 and most of wave 10 are on `main`. Wave 8 is the *ring calculus*: what the unit circle about a
vertex of a valid map (its *ring*) carries, in the class with no Siamese pair. Today its first implementer proved the wave's first
theorem — no four-colour vertex has a ring free of boundary arcs — and its second planner stated nine more rows in two new modules,
twenty-three leaves. Those two lines of work are on two branches, one leaf between them is stuck on a statement that was written too
wide, and the two modules' proofs share three lemmas that exist only as sentences in a plan. You make the ground the next two
implementers stand on.

## Why this job

A result counts as held only when its Lean module passes the gate, and two implementers who each need a lemma the other is writing
either wait on each other or state it twice — which this milestone forbids (`LEAN.md` § Searching — Lean, last bullet: two branches
never state one lemma under one name). So the shared part is written once, first, by one job. Kooshi, on pricing this work:

{KOOSHI}
The hand-backs and rulings behind this brief (read each item whole in the inventory):

{item(567)}
{item(568)}
{item(569)}
{item(572)}
## The statements

**One statement changes, by ruling 568 (a), and no other.** The leaf as it stands in your tree:

{Q(W+P+"Star.lean","theorem star_anti ")}
The row it formalizes excludes a case in its own words, and the hypotheses `hp'`, `hm` above admit that case when a tile's cone at the
vertex is every direction:

{Q("plans/FS116-derivation.md","  not claimed: anything when an edge of p leaves at ψ + 90° or ψ − 90°")}
The ruled change — two binders after `hm`, nothing else — and what the implementer who found the gap handed on about it (by thought
only, not elaborated: attack it before you lean on it):

{Q(IP,"    (hp'' : ",H55)}
{Q(IP,"    (hm'' : ",H55)}
{Q(IP,"- **The binders close the stuck case.**",H55)}
{Q(IP,"- **They are no new content at a proper interval.**",H55)}
{Q(IP,"- **Their form is usable as written**",H55)}
{Q(IP,"- **The route for the rest**",H55)}
The three shared lemmas exist only in the second planner's prose (its own slip, said in its record: "stated in prose, not in Lean").
Its sentences, and its hand-off — **in which the job names differ from mine: what it calls "I8B" on `SemiHub` is FS131-I8C, its "I8C"
on `SemiHubPlaces` is FS131-I8D, and you are the job it says "starts first"**:

{Q(KP,"   `e₁ … e₄`. The repeated chain is one missing lemma",H91)}
{Q(KP,K1PRE,H91)}
{Q(KP,"   sectors share the branch between them",H91)}
{Q(KP,"- **By file**: *I8B* on `Plane/RingCalculus/SemiHub`",H98)}
{Q(KP,"- **`star_anti`** gains two binders",H98)}
## Done means

1. **Your readback first**: check the quotations against their sources; read the second planner's record (`{KP}`, Stages 6–10; its
   § 7.3 on the gap, § 9.1 on the shared lemmas, §§ 9.2–9.3 for every use of C1, K1 and K2 in the two modules' plans), the first
   implementer's record (`{IP}`, Stage 5), the wave's modules in your tree, and the row's entry. Build the branch once as given (26 `sorry` leaves:
   17 and 6 in the two semi-hub modules, 2 in `Star`, 1 in `Empty`). Open your record. Commit and push.
2. **The merge**: `git merge origin/fs131-w8a` (at `{A8}`: the first implementer's last stage — `star_recip` proved, docstrings; your
   base already holds its earlier commits). Trial it first; my trial of it on your base shows no conflict. A conflict in a registry file is adjacent
   additions, keep every side; one in a Lean file is a message to me. Committed as a merge, the index holding the merge and
   nothing else. Build: 25 leaves.
3. **The shared module, saved before anything else of yours**: C1 (`exists_int_of_angleIcc_subset`: an interval inside a union of
   `2π`-translates of an interval shorter than `2π` lies in one), K1 (`IsSectorChart.tileAt_equiv`: under `SimpleOn` at a point its
   tiles are its chart's sectors, one each) and K2 (`IsSectorChart.exists_initialPiece_between`: two consecutive sectors share an
   initial piece of a map arc in both closures) — stated in Lean by you, from the planner's sentences and from **every use the two
   plans make of them** (list the uses in your record, then state each lemma so they go through; where two uses want two forms, state
   the general one and a corollary). `#check` each and read the binders the kernel shows (inventory item 556: a section `variable`
   enters a theorem only if its statement mentions it). Prove them. The planner found the wave-4 lemmas it names for K2 by name and
   did not read them: read them. C2 and the planner's G1 are yours to place — in the shared module if both later jobs need them.
   **Then a build, the axioms print with a control that fires, commit, push, and one message to me with the hash and the three
   statements.**
4. **`star_anti`**: the ruled change exactly — the two binders (their form adjusted only if the proof needs it, and then say what and
   why), a docstring clause naming the excluded case and the row's line — then the proof. Its `sorry` is the only one that leaves
   `Star`. If the hypotheses do not close it, or it is false with them, that is a message, and the leaf stays open with the change
   made and its gap named.
5. **The statement check**: against `{BASE}` and against `{A8}`, on elaborated signatures (two implementers' tools do this, with
   controls: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/tools/fs131_i8a_stmt.py` is the wave's own) — exactly one
   declaration changed, `star_anti`, by exactly the two binders; your additions listed.
6. No other statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do
   not run the gate or touch `main`. `./scripts/dupnames.sh` before each push that adds names; `tools/check_architecture.py` exit 0. **After your last green build, the guarded
   lint** — `lake lint --no-build -- --no-build --trace` under the slot with `--mem 8` (`LEAN.md` § The gate), its output saved: a
   landing's gate went red today on an instance argument a proof did not read, which the build's own linters do not report
   (inventory item 573). A line it reports in what you wrote is yours to repair if no statement of a leaf changes, and a message if one does.
   Leave no background process running, and keep what your record cites under your `data/` folder.
7. **Your record**, stages headed "Stage n — SAVED ({JOB})", "Theorems this phase proved", each read against its sentence; and a
   section **"For the two implementers who start from here"**: the shared lemmas with their statements, which use each serves, and
   anything in the two modules' plans your reading of the foundation shows will not go as written. The report in standing rule 11's
   form. Stopping at a saved stage with the merge and the shared module done and `star_anti` open is a good report: the shared module
   is what two jobs wait on.

## What is yours to decide

The statements of the three shared lemmas (they are helpers, and yours — but two jobs will build on them, so state them for their
uses, not for your convenience), the module's name and layout, the route for `star_anti`, your helpers. The ruled change is not yours
to widen: no third hypothesis, and neither binder dropped, without a message. If the planner's sentence for a shared lemma is false
as it reads, or the plans' uses need something it does not give, that is a finding: state what is true and say so. Three failed
attempts on one route is a dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-wave8-join.md","w").write(b)
print("written",JOB,"base",BASE,"w8a",A8)
