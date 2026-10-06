exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import sys,subprocess
N=sys.argv[1]  # 1 (stuckModel.IsTerminalMap whole) or 2 (the three smaller closers: a clean map, the contact fact, the collar package)
TREE="fs131-wd"+N; JOB="FS131-MD"+N; W=WT+TREE+"/"
BASE=subprocess.run(["git","-C",W,"merge-base","HEAD","main"],capture_output=True,text=True).stdout.strip()[:8]
assert BASE,"make the worktree first"
P="Proofs/HadwigerNelson/Plane/"
MC="plans/FS131-MC1-landing.md"; KM="plans/FS131-models-kernel-plan.md"
if N=="1":
    TITLE="the stuck example map is a terminal map — `stuckModel.IsTerminalMap` whole, so three landed theorems name a Lean model of all their hypotheses"
    FILES=f"a new module `{P}Models/StuckTerminal.lean` (the three target declarations and your helpers), with `Proofs.lean` and `ARCHITECTURE.md` for it; `{P}Models/Applied.lean` at the three `example`s that take `Terminal` or `IsTerminalMap` as given, and nowhere else in that file; the docstrings — docstrings only — of `n3_end_chain`, `cv_l0` and `hornBoundsQR_of_isChainVertex` in `{P}ValidMap/Terminal.lean`"
    NOT=f"any statement on `main`; the landed example-map modules (`{P}Models/Stuck.lean` and its three siblings) beyond new declarations you cannot place in your own module; the docstrings of `c_ends`, `run_ends` and `horn_upper_ne_one` (ruling 482: their open-question and refutation lines stay untouched); the heads the other closer serves (`Procedure`, `FlankUA`, `BendGap`, `CollarMapOut`, `BendAway`)"
    INTRO='''You are closing an open gate item of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 and a set of *example maps* are on `main`. The example maps are explicit valid maps of the plane, built so
that each landed theorem about maps can be applied in Lean to an object meeting all its hypotheses at once (this project's gate asks for
that: `LEAN.md` § The gate, the inhabitant rule). One of them, `stuckModel` — a twelve-colour map with a *stuck* vertex — serves nineteen
theorems today. Three more take one hypothesis it has not been proved to meet: that the whole map is *terminal* (no move available at any
point, and every unit arc of one of two kinds). The job that landed the maps wrote the route and left it for a successor. That is you.'''
    WHY='''A result counts as held only when its Lean module passes the gate, and the gate's inhabitant rule is open at these three heads: their
docstrings say a hand model exists and no Lean one. Truth is not in question — the three theorems are kernel-checked — but a hypothesis set
nobody has inhabited in Lean is the place a vacuous theorem hides, and this one is a few hundred lines from closed.'''
    ITEMS=[482,496,497]
    SQ=[(MC,"### 3.2 The work list for a successor: `stuckModel.IsTerminalMap` whole"),(MC,"**Target** (two declarations"),(MC,"    theorem stuckModel_terminal : stuckModel.Terminal"),(MC,"    theorem stuckModel_qrOnly : stuckModel.QROnly"),(MC,"    theorem stuckModel_isTerminalMap : stuckModel.IsTerminalMap :="),(MC,"It serves `cv_l0`"),
        (P+"ValidMap/Basic.lean","def Terminal : Prop :="),(P+"ValidMap/Chain.lean","def QROnly : Prop :="),(P+"ValidMap/Chain.lean","def IsTerminalMap : Prop :="),
        (P+"Models/Stuck.lean","theorem stuckModel_isStuck "),(P+"Models/Stuck.lean","theorem stuckModel_hyps "),
        (P+"Models/Applied.lean","example (hT : stuckModel.Terminal) :="),(P+"Models/Applied.lean","example (hM : stuckModel.IsTerminalMap) := ArcMap.cv_l0"),(P+"Models/Applied.lean","example (hM : stuckModel.IsTerminalMap) (β : ℝ) :=")]
    PQ=[(MC,"**The route for `Terminal`, read against wave 5's library"),(MC,"| general: "),(MC,"| off the closure of `stuckW`"),(MC,"| the closed disc about the vertex"),(MC,"| the two closed squares"),(MC,"| assembly |"),(MC,"500 to 650 lines"),(MC,"**`QROnly` is not routed here**"),(KM,"| `Terminal`'s any-`k` family, `cv_l0`, `IsTerminalMap`, `QROnly` |")]
    DONE=f'''2. **`stuckModel_terminal`**, by the route above or a better one, in your module, staged by the table's parts (the general lemmas; off the
   painted pieces; the disc; the squares; the assembly), saving after each. The route is one mind's, read against the library and never
   compiled: re-price after the first part and say so.
3. **`stuckModel_qrOnly`**: no route is written — one paragraph of the landing job's record and one cell of the models' plan, both quoted
   above, are all there is. Write yours in your record before the Lean. If it comes out larger than the `Terminal` half, save `Terminal`,
   say so by message, and go on only as far as budget allows: `stuckModel_terminal` alone closes `n3_end_chain`.
4. **The close**: `stuckModel_isTerminalMap`; the three `example`s in `Applied` lose their binder; the three heads' docstrings name the
   model in `LEAN.md` § The gate's form in place of the hand-model sentence (docstring edits rebuild everything downstream of
   that module: make them last, in one pass, and show by a statement check that no statement moved).
5. **Checks, each saved**: the build with 0 warnings; no `sorry`; the axioms print for your declarations with a control that fires;
   `./scripts/dupnames.sh`; `python3 tools/fs131_qa4_notes.py` (no CONFLICT); `python3 tools/fs131_mc_gateitems.py` — the count of open
   gate items it reads from the docstrings, before and after (29 at the landing).'''
    ORDER=""
else:
    TITLE="three smaller closers on the example maps — a clean map for the procedure's steps, the contact fact at the stuck vertex, a collar package on the outward bend's gap"
    FILES=f"a new module `{P}Models/Closers.lean` (or modules, under names of your choice) for every new declaration, with `Proofs.lean` and `ARCHITECTURE.md` for it; `{P}Models/Applied.lean` at the one `example` that takes `IsClean` as given, and nowhere else in that file; the docstrings — docstrings only — of the sixteen heads you serve, in `{P}ValidMap/Procedure.lean`, `{P}ValidMap/FlankUA.lean`, `{P}ValidMap/BendGap.lean`, `{P}ValidMap/CollarMapOut.lean` and `{P}ValidMap/BendAway.lean`"
    NOT=f"any statement on `main`; the landed example-map modules (`{P}Models/Stuck.lean` and its three siblings) beyond new declarations you cannot place in your own module; `{P}ValidMap/Terminal.lean` and the three `example`s of `Applied` that take `Terminal` or `IsTerminalMap` as given (the other closer's); the six heads left untouched by design and the three that wait on another job's objects (the landing job's list, quoted below)"
    INTRO='''You are closing open gate items of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 and a set of *example maps* are on `main`. The example maps are explicit valid maps of the plane, built so
that each landed theorem about maps can be applied in Lean to an object meeting all its hypotheses at once (this project's gate asks for
that: `LEAN.md` § The gate, the inhabitant rule). Thirty-three of sixty-two such items closed when the maps landed. Sixteen of the
twenty-nine left wait on three facts about maps that already exist: that one of them is *clean* (eleven heads), that a colour at the stuck
vertex has no contact but one (one head), and a named collar package on the outward bend's example (four heads). They are yours.'''
    WHY='''A result counts as held only when its Lean module passes the gate, and the gate's inhabitant rule is open at these sixteen heads: each
docstring says which hypothesis no Lean object is yet proved to meet. Truth is not in question — every one of the theorems is
kernel-checked — but a hypothesis set nobody has inhabited in Lean is the place a vacuous theorem hides.'''
    ITEMS=[496,497]
    SQ=[(P+"ValidMap/Limit.lean","def IsClean : Prop :="),(P+"ValidMap/Procedure.lean","theorem exists_vertexStep "),(P+"Models/Applied.lean","example (hc : hornModel.IsClean) :="),
        (P+"ValidMap/FlankUA.lean","theorem hasSectors_one_of_contacts "),(P+"ValidMap/FlankUA.lean","    (hcont : ∀ w, F.IsContact v j w →"),
        (P+"ValidMap/CollarMapOut.lean","structure CollarFitOut "),(P+"ValidMap/CollarMapOut.lean","theorem CollarFitOut.pushOutProfiles "),(P+"ValidMap/BendGap.lean","theorem CollarFitOut.map_R1 "),(P+"ValidMap/BendGap.lean","theorem CollarFitOut.map_R2 "),
        (P+"ValidMap/BendAway.lean","structure AwayBend "),(P+"ValidMap/BendAway.lean","theorem AwayBend.idle "),(P+"Models/Bends.lean","theorem awayModel_hyps ")]
    PQ=[(MC,"     - one hypothesis not a Lean fact (1):"),(MC,"     - a clean map (11, `Procedure`):"),(MC,"     - a collar or bend package no declaration states for `awayModel` (4):"),(MC,"     - untouched as ruled, by design (6):"),(MC,"     - FS131-E7's `F₀`, `F₁` (3, `UnitArc`):"),
        (MC,"**Not served, and why.**"),(MC,"| `exists_vertexStep` (`Procedure`) | `hornModel` | an `example` **taking"),(KM,"| `exists_vertexStep` (`Procedure`) — `Valid`, `IsClean`, `Covers v 1`")]
    DONE=f'''2. **A clean map** (eleven heads): `hornModel.IsClean` — every point of `Γ` carries two colours; the models' plan priced it M and names
   the argument (quoted above). Then the `example` in `Applied` loses its binder, and for each of the other ten heads of
   `Procedure` either an application to a model in your module, or one line in your record naming the hypothesis that model still does not
   meet — an honest list is the deliverable, not eleven ticks. My reading of that row, unchecked: `twoHornModel` should be clean by the same argument, if a head wants a
   repeated colour.
3. **The contact fact** (one head): that colour `7` at `stuckModel`'s vertex has no contact but the pole, in the form
   `hasSectors_one_of_contacts`'s `hcont` asks; then the application.
4. **A collar package** (four heads): a named `CollarFitOut` — and an `AwayBend` if `AwayBend.idle` needs one — on `awayModel`'s gap, the
   sub-arc the landed applications already use; then the four applications. If the package's fields ask more than the gap gives, say which
   field, and stop there: that is a finding about the heads' hypotheses.
5. **The close**: each served head's docstring names its model in `LEAN.md` § The gate's form in place of its open-item sentence
   (docstring edits rebuild everything downstream: make them last, in one pass, and show by a statement check that no statement moved).
   **Checks, each saved**: the build with 0 warnings; no `sorry`; the axioms print for your declarations with a control that fires;
   `./scripts/dupnames.sh`; `python3 tools/fs131_qa4_notes.py` (no CONFLICT); `python3 tools/fs131_mc_gateitems.py` — the count of open
   gate items it reads from the docstrings, before and after (29 at the landing).'''
ITEMQ="\n".join(item(n) for n in ITEMS)+"\n"
STMTS="\n".join(Q(f,p) for f,p in SQ)+"\n"
PLAN="\n".join(Q(f,p) for f,p in PQ)+"\n"
b=f'''# Brief {JOB} — {TITLE}

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: one of two closer jobs on the example maps — prove the facts below about maps that are already on `main`, apply the landed theorems to them, and correct the docstrings that say no Lean model exists; no statement on `main` changes
  launch: when a slot frees, on a branch cut from `main`; the other closer works on a branch of its own, in other files
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a target that is false of the object (at once, with the point or the arc: that is a finding about a landed model), a hypothesis of a landed theorem that no example map can meet, a step of the written route that fails (with its address), or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from `main` at `{BASE}`): {FILES}; `scripts/Axioms.lean` (a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner), `plans/{JOB}-implementation.md`, `tools/fs131_md{N}_*.py`, `data/fs131/md{N}/`, `data/fs131/reports/{JOB}.md`; **not** {NOT}, `main`
  budget: {BUDGET}

Hello. {INTRO}

## Why this job

{WHY} Kooshi, on pricing this work:

{KOOSHI}
What the landing job handed back and the rulings in force (read each item whole in the inventory):

{ITEMQ}## The statements

No statement on `main` changes in this job. The targets and what they serve, from the landing job's record and the library (the same files
are in your tree; read each declaration whole, with its docstring):

{STMTS}What is written about the routes — the landing job's record (`plans/FS131-MC1-landing.md` §§ 3.2, 3.4 and its fifth draft) and the models'
plan (`plans/FS131-models-kernel-plan.md` §§ 3.3–3.8); read both sections whole:

{PLAN}## Done means

1. **Your readback first**: check the quotations against their sources; read the two records' sections named above, the example maps'
   modules (`{P}Models/`), and the heads you serve with their docstrings. Build the branch once as given (no `sorry` anywhere: this is
   `main`). Open your record with what you may and may not change. Commit and push.
{DONE}
6. No statement or definition on `main` changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. **You do not
   land**: you do not merge another branch, run the full gate, or touch `main` — the next landing job merges your branch (my ruling: a full
   gate for a handful of docstring lines is a landing spent on nothing new, and nothing waits on these). Leave no background process
   running, and keep what your record cites under your `data/` folder.
7. **Your record**, stages headed "Stage n — SAVED ({JOB})", "Theorems this phase proved"; the report in standing rule 11's form, ending
   with what is left and its route, and the gate items by name: closed, and still open with the reason. Stopping at a saved stage with part
   done is a good report.

## What is yours to decide

The routes, your helpers and their names, the layout of your module, and the order within what depends on what. What is written about the
routes is one mind's each and none of it was compiled; change what does not go and say so. A target that is false of the object is not
yours to restate: it is a message to me, and a finding. Three failed attempts on one route is a dispatch to the companion your identity
names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-closers.md","w").write(b)
print("written",JOB,"base",BASE)
