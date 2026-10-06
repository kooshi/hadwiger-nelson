exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import sys
LANE=sys.argv[1]  # D (the planes' floor: NormOneTarget, FloorPlanes), E (the target at 128), F (ProductFactor, MajorityVote, NegCircleModel)
A="Proofs/HadwigerNelson/Arith/"
T={"D":dict(tree="fs131-w10d",job="FS131-I10D",
     files=f"`{A}NormOneTarget.lean` (two leaves) and `{A}FloorPlanes.lean` (four leaves)",
     what="the planes' floor — from Weil's bound on Kloosterman sums, named as a hypothesis, to seven colours at every usable plane from 98 on",
     stm=[("NormOneTarget.lean","theorem involution_eq_pow "),("NormOneTarget.lean","theorem card_normOne "),("FloorPlanes.lean","theorem sum_quadratic_eq "),("FloorPlanes.lean","theorem circle_sum_eq_kloosterman "),("FloorPlanes.lean","theorem circle_sum_le "),("FloorPlanes.lean","theorem normOne_charSum_ge "),("FloorPlanes.lean","def KloostermanBound ")],
     plan=["### 7.3 Row (ii) — the planes:","**The leaves, per child:**","### 7.1 The ratio bound"],
     order="the plan's children P1–P6 in its order (`involution_eq_pow`, `card_normOne`, `sum_quadratic_eq`, `circle_sum_eq_kloosterman`, `circle_sum_le`, `normOne_charSum_ge`)",
     extra="**`KloostermanBound` stays a hypothesis** (rulings 500 and 510 (c)): it is a `Prop` argument, never an `axiom`, until a held page of its source has been read back against it — that is not this job's. `circle_sum_eq_kloosterman` is also the kernel form of an identity this project has only ever checked numerically (FS-20's open item R4): say so in its docstring when it is proved. The held paper's own theorem for the circle sum is false as printed at radius zero (item 500); your statements carry `a ≠ 0` where they need it — if a proof finds another case the printed sketch glosses, that is a message.",
     nleaf="23 `sorry` leaves on the branch: six yours, five other implementers' in this pass's modules, twelve in `StationaryRatio` and `StandingFive` (proved on other branches)"),
   "E":dict(tree="fs131-w10e",job="FS131-I10E",
     files=f"`{A}Floor128.lean` (one leaf, `charSum_128_ge`, with the six children the plan names)",
     what="the target at 128 needs eight colours — the bridge from a kernel-checked certificate to the character sums of the norm-one target, with no outside theorem",
     stm=[("Floor128.lean","theorem charSum_128_ge "),("Floor128.lean","theorem targetFloor_eight_128 ")],
     plan=["### 7.2 Row (i) — the target at 128, no outside theorem:","### 7.1 The ratio bound"],
     order="the plan's children for `charSum_128_ge`, in its order",
     extra="**The certificate is already kernel-checked** (`order_checks`, `counts_ok` by `decide +kernel`; the planner measured 2.3 s): your leaf is the mathematics between it and the statement — an explicit model of the field with `128²` elements, its generator, the norm-one group, and every non-trivial character's sum read off the counts. The spectrum itself (−19 … 21) is [tools, exact, two routes] (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10e/tools/fs131_k10b_u128.py` and `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10e/tools/fs131_k10b_gen128.py`, on your branch): if a `decide` of yours disagrees with either tool, stop and report. Any new certified computation follows `LEAN.md` § The kernel's cost model — measure before you commit to a shape; no `native_decide`.",
     nleaf="23 `sorry` leaves on the branch: one yours"),
   "F":dict(tree="fs131-w10f",job="FS131-I10F",
     files=f"`{A}ProductFactor.lean` (one leaf, `contVec_prod_eq`), `{A}MajorityVote.lean` (one leaf, `ae_eq_measurable_of_majority`) and `{A}NegCircleModel.lean` (two leaves, `exists_parityHom`, `negCircle_trivial_bot`)",
     what="three short measure-theoretic leaves — the factor of a product with independent noise, a majority vote in place of an ergodic theorem, and the one Lean model the wave still owes",
     stm=[("ProductFactor.lean","theorem contVec_prod_eq "),("MajorityVote.lean","theorem ae_eq_measurable_of_majority "),("NegCircleModel.lean","theorem exists_parityHom :"),("NegCircleModel.lean","theorem negCircle_trivial_bot ")],
     plan=["### 8.1 J45-SI-J — stated at a wider class,","### 8.2 The deriver's lemma FS131-E8-SI5C","### 8.5 A model of `Interface.NegCircle`"],
     order="`ae_eq_measurable_of_majority` (the shortest; it re-prices the rest), `contVec_prod_eq`, then the model's two leaves",
     extra="**Each of the three has a hand argument of one mind behind it, written today**: the majority vote is a deriver's (`/home/kooshi/source/lean-dir/plans/FS131-E8-derivation.md` § 5.1, entry FS131-E8-SI5C — Chebyshev and a closed subspace of `L²`; the planner checked that Mathlib's strong law serves only the narrower class, so Chebyshev is written out); the product's factor is the planner's (inventory item 503: split off the part orthogonal to the first two systems, and a centred cylinder is orthogonal to its own shift once the shift moves its coordinates off themselves); the model is the first implementer's suggestion, checked on paper by the planner (the point mass at the parity character over `ℚ`). A step that fails is a message with its address. **`negCircle_trivial_bot` closes an open gate item**: when it is proved, `sp_if` has a Lean model of all its hypotheses — say which declaration, for the join to name in `sp_if`'s docstring (that file is not on your branch to edit).",
     nleaf="23 `sorry` leaves on the branch: four yours")}[LANE]
TREE,JOB,FILES=T["tree"],T["job"],T["files"]
W=WT+TREE+"/"; KP=W+"plans/FS131-w10-kernel-plan.md"; V=W+A
STMTS="\n".join(Q(V+f,p) for f,p in T["stm"])+"\n"
PLAN="\n".join([Q(KP,p) for p in T["plan"]]+[Q(KP,"### 9.3 Prices"),Q(KP,"### 9.4 For the joining job")])+"\n"
b=f'''# Brief {JOB} — wave 10, {T["what"]}: open leaves of the second planning pass, on `{TREE}`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: one of three implementers of wave 10's second planning pass, split by file — prove the open leaves of {FILES} from the planner's plan, without changing a statement, saving after each leaf or group
  launch: when a slot frees, on a branch cut from the commit at which the wave's second planner handed back, beside the wave's other implementers on branches of their own
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the reason: a statement change goes back through me), a step of a hand argument that fails or does not formalize (with its address), a certificate or tool that disagrees with the kernel, or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from `fs131-w10k` at `330d2f48`): {FILES} — proofs, and new helper declarations under names no other module declares (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name); `scripts/Axioms.lean` (a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner), `plans/{JOB}-implementation.md`, `tools/fs131_i10{LANE.lower()}_*.py`, `data/fs131/i10{LANE.lower()}/`, `data/fs131/reports/{JOB}.md`; **not** the wave's other files (the other implementers', and the four first-pass files, which wait for the join), the planner's record, any landed module beyond new declarations, `main`
  budget: {BUDGET}

Hello. You are proving part of the arithmetic wave of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 10 is fourteen arithmetic rows; three of its four first files are proved on their own
branches, and its second planner has just stated what the first pass left: the *finite-target floor* — certain finite graphs need seven
colours, a hand result a degree-28 field's theorem leans on — as two rows, and three short leaves beside it. This part is yours:
{T["what"]}.

## Why this job

A result counts as held only when its Lean module passes the gate. Until these leaves are proved the wave's standing-five theorem rests on a
floor nobody has put in the kernel, and one of its theorems has no Lean model of its hypotheses. Kooshi, on pricing this work:

{KOOSHI}
What the planner handed back and the rulings in force (read each item whole in the inventory):

{item(509)}
{item(510)}
{item(500)}
{item(503)}
## The statements

No statement changes in this job. Your leaves, as they stand in your tree (read each whole, with its docstring):

{STMTS}The plan (the planner's record, `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/plans/FS131-w10-kernel-plan.md`: read Stages 6–9 whole;
the sections for your files give a route, the Mathlib names it confirmed with `#check`, what is hard, and a price per child):

{PLAN}## Done means

1. **Your readback first**: check the quotations against their sources; read the planner's record (Stages 6–9; Stages 2–5 as far as your
   files rest on the first pass's), your files and the modules they import, and each row's derivation entry at the address the record gives.
   Build the branch once as given ({T["nleaf"]}). Open your record with what you may and may not change. Commit and push.
2. **The leaves**, in this order — {T["order"]}; saving after each leaf or group (a build, the axioms print for it with a control that fires,
   a statement check against `330d2f48`, commit, push). Re-price after your first two leaves or children and say so: the wave's first two
   implementers each came in at a third to two thirds of the planner's line count.
3. {T["extra"]}
4. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch, run the gate, or touch `main`. Leave no background process running, and keep what your record cites under your `data/`
   folder.
5. **Your record**, stages headed "Stage n — SAVED ({JOB})", "Theorems this phase proved", each read against its row; the report in standing
   rule 11's form, ending with what is left and its route. Stopping at a saved stage with part of the leaves proved is a good report.

## What is yours to decide

The route inside each leaf, your helpers, and the order within the plan's dependencies. The plan is one mind's, written today and compiled
only as far as its statements; change a route that does not go and say so. A statement is not yours to change: one that is false, or true
only with a hypothesis the plan did not see, is a message to me, and a finding. Three failed attempts on one route is a dispatch to the
companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-wave10-second.md","w").write(b)
print("written",JOB)
