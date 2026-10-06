exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
B=WT+"fs131-wmb/"; MD=B+"Proofs/HadwigerNelson/Plane/Models/"
RB=B+"plans/FS131-MB1-implementation.md"; KP=B+"plans/FS131-models-kernel-plan.md"
b=f'''# Brief FS131-MB2 — the example maps, half B continued: the doubly shadowed band's model and the outward bend's, on `fs131-wmb`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-MB2
  identity: {IDENT}
  role: FS131-MB1's successor — the two models it did not begin: `shadowModel` (seven leaves; the model of `flank_ne_of_doublyShadowed`) and `awayModel` (four leaves; the plane-map model for the outward bend and for `bend_toward`), every leaf proved without changing a statement, saving after each model
  launch: now, in the tree FS131-MB1 has handed back, beside FS131-MA1 (the other half, `Paint` and `Moves`, on `fs131-wm`) and wave 5's landing on another branch
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the reason), a hypothesis of a landed theorem the model turns out not to satisfy (at once: the finding this lane exists to catch), or a question you cannot work around; the report goes to `data/fs131/reports/FS131-MB2.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/FS131-MB1-implementation.md` (on branch `fs131-wmb`; MB1's record, your stages from 5, headed FS131-MB2)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wmb` (branch `fs131-wmb`, at `b7fbe6f9`): `Proofs/HadwigerNelson/Plane/Models/Stuck.lean` and `Proofs/HadwigerNelson/Plane/Models/Bends.lean`; new helpers as new declarations there, under names that begin with the model's name (`LEAN.md` § Searching — Lean, last bullet, read from the main checkout `/home/kooshi/source/lean-dir/LEAN.md`: two branches never state one lemma under one name, and the other half holds `Paint`); `scripts/Axioms.lean` (a block of your own, headed "FS131-MB2", above the `=== PURCHASED ===` banner), `plans/FS131-MB1-implementation.md`, `tools/fs131_mb2_*.py`, `data/fs131/mb2/`, `data/fs131/reports/FS131-MB2.md`; **not** `Proofs/HadwigerNelson/Plane/Models/Paint.lean` nor `Moves.lean` (the other half's), any landed module, `main`
  budget: {BUDGET}

Hello. You are finishing the second half of the example maps in the Lean backlog. The milestone, FS-131, turns this project's hand-derived results
into kernel-checked ones, and its gate asks that every theorem's hypotheses hold together on some real object. A planner reduced the missing objects
to one construction — the seven-colour brick map read in more colours, with a picture painted in spare colours — and your predecessor built two of
this half's four: the cusp fragment's arc for the two older bends, and the stuck vertex's twelve-colour map. Two remain, each a painted picture with
its local facts.

## Why this job

`flank_ne_of_doublyShadowed` is on `main`, kernel-checked, with only a hand model of its hypotheses (FS131-E7's `P₄`); the outward bend
`bend_away_part`, proved yesterday on wave 5's line, has none in Lean at all. Until these land nothing in Lean shows those hypothesis sets are not
empty (`LEAN.md` § The gate, the inhabitant bullet). Kooshi, on pricing this work:

{KOOSHI}
What the last jobs handed back, and the rulings in force:

{item(470)}
{item(471)}
{item(460)}
{item(461)}
## The statements

No statement changes in this job. The heads of the two models (read every leaf's docstring in the two files, which states its route):

{Q(MD+"Stuck.lean","theorem shadowModel_flank_ne ")}
{Q(MD+"Bends.lean","noncomputable def awayModel ")}
MB1's handoff — what is left, its routes, the helpers of its that you can reuse — and the planner's plan for these leaves:

{Q(RB,"### 4.1 What is left, and its route")}
{Q(KP,"## Stage 3 — SAVED")}
## Done means

1. **Your readback first**: check every quotation above against its source; read MB1's record whole (§ 3 for how `stuckModel` went: its helpers
   are the pattern), the planner's §§ 2–3, FS131-E7's § 6 for `shadowModel` (`plans/FS131-E7-derivation.md` in the main checkout,
   `/home/kooshi/source/lean-dir/plans/FS131-E7-derivation.md`) and the outward bend's planner's § 5 for `awayModel`
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/plans/FS131-bendaway-kernel-plan.md`). Build the branch once as given (expect it up
   to date: 43 distinct `sorry` warnings — 31 the other half's, 8 in `Stuck`, 4 in `Bends`). Open your stages. Commit and push.
2. **`shadowModel`**, then **`awayModel`**, saving after each (a build, the receipt in MB1's form — its `#mb_receipt` tells a `sorry` of yours from
   one reached through the other half's `Paint` — the statement check, commit, push). `shadowModel` reads four of `Paint`'s open leaves; say which
   of your theorems rest on `sorryAx` through `Paint` alone.
3. **Not yours**: `stuckModel_terminal` and the plane-map model of `bend_away_whole` (a sub-arc of `awayModel`'s arc inside a gap; ruling 471 (c))
   wait for wave 5 to reach `main`; the docstring lines on landed theorems are applied when the lane lands.
4. No statement or definition changed anywhere; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch into this one, run the gate, or touch `main`. Leave no background process running, and keep what your record cites under
   `data/fs131/mb2/`.
5. **Your record**, stages headed "Stage n — SAVED (FS131-MB2)", "Theorems this phase proved"; the report in standing rule 11's form. One model
   whole is worth more than two half done; stopping at a saved stage with `shadowModel` whole is a good report.

## What is yours to decide

The route inside each leaf, your helpers, and the order if `awayModel` turns out to fix a form `shadowModel` needs. The planner's routes for these
leaves have not been read against proofs by anyone; change one that does not go and say so. A leaf's statement is not yours to change: one that is
false is a message to me, and a finding. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth.
{NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/FS131-MB2-models-shadow.md","w").write(b)
