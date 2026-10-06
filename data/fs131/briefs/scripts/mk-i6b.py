exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import sys
LANE=sys.argv[1]  # C (Curve, then LocalGraph), D (FanBridge's existence half) or E (FanBridge's five Fan lemmas)
T={"C":dict(tree="fs131-w6c",job="FS131-I6C",
     files="`Proofs/HadwigerNelson/Plane/Saturated/Curve.lean` (six leaves) and then `Proofs/HadwigerNelson/Plane/Saturated/LocalGraph.lean` (five leaves, `local_graph` the large one)",
     what="unit-speed curves with 1-Lipschitz tangent, and the local graph of an interface off the cusps",
     mods="`Curve`, then `LocalGraph`",
     stm=[("Curve.lean",p) for p in ["theorem IsUnitCurve.chord ","theorem IsUnitCurve.sin_le_inner ","theorem IsUnitCurve.strictMonoOn_dist ","theorem IsUnitCurve.norm_sub_le ","theorem IsUnitCurve.one_le_dist ","theorem lipschitzOnWith_of_chord "]]
         +[("LocalGraph.lean",p) for p in ["theorem AeColouring.notMem_essBdry_of_mem_densitySet ","theorem AeColouring.ae_one_colour_of_isConnected ","theorem AeColouring.closure_essBdry_subset ","theorem local_graph ","theorem AeColouring.local_graph "]],
     planrows=["| `Plane/Saturated/Curve` (imports","| `Plane/Saturated/LocalGraph` (imports","| `local_graph` | "],
     order="`Curve`'s six first (they are short and re-price the rest), then `LocalGraph`'s three small leaves, then `local_graph` by its children (a)–(i), then the colouring's form of it",
     extra="**`local_graph` is the wave's first large leaf** (the plan prices it at five days, its child (h) — the curve by arclength — at two): Mathlib has no arclength reparametrization, and the plan says not to follow the hand derivation's regularity step but the kernel-checked `norm_sub_le_of_discs` with `lipschitzOnWith_of_chord`. Two of its children are another implementer's leaves in `Pinch` (`c11_discs`, `TwoColourOn.essBoundary_inter_eq`): use them as stated — they are `sorry` on your branch and your theorems then rest on them, which is expected and said in your record. The unit circle as the sharpness example of `chord` is owed with its proof (the plan's § 12.2), and `local_graph`'s inhabitant note names one owed fact (no cusp in the edge ball of `sq9`): prove it if it is short.",
     nleaf="31 `sorry` leaves over five files: eleven yours"),
   "D":dict(tree="fs131-w6f",job="FS131-I6D",
     files="`Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean` — its existence half: `gamma`, `IsUnitCurve.exists_polarGraph`, `beta`, `alpha`, `fan_of_isolated`, `regJLiteral_of_saturated`, `finite_arcs_of_isBounded` (seven leaves) — and the owed model `sq9.SingLocallyFinite` in `Proofs/HadwigerNelson/Plane/Saturated/FanExamples.lean`",
     what="the fan at an isolated singular point exists",
     mods="`FanBridge` (its existence half)",
     stm=[("FanBridge.lean",p) for p in ["theorem gamma ","theorem IsUnitCurve.exists_polarGraph ","theorem beta ","theorem alpha ","theorem fan_of_isolated ","theorem regJLiteral_of_saturated ","theorem finite_arcs_of_isBounded "]],
     planrows=["| `Plane/Saturated/FanBridge` (imports","| `gamma` | ","| `alpha` | ","| `fan_of_isolated` | "],
     order="`IsUnitCurve.exists_polarGraph` (no colouring; it re-prices the rest), `gamma`, `beta`, `alpha`, `fan_of_isolated`, then the two corollaries, then the model",
     extra="**The other five leaves of the file are not yours** (`two_le_n`, `col_ne`, `branch_outside_discs`, `branch_contacts`, `sector_alone` in the namespace `AeColouring.Fan`): a deriver has checked their statements (inventory items 504–505) and another implementer takes them on `fs131-w6g` — leave their `sorry`s and do not add helpers between them; put your helpers above `gamma` or in a new module of your own, so the two branches merge without touching the same lines. Your leaves use `Curve`'s and `LocalGraph`'s statements, which a third implementer is proving on `fs131-w6c`: they are `sorry` on your branch and your theorems rest on them, which is expected and said in your record. **The model is part of done**: `sq9.SingLocallyFinite` (the vertex analysis of `FanExamples` at every grid vertex; the plan's § 10.3 says what is owed), which with `regJFan_of_saturated` gives `sq9.RegJFan`, the model of every theorem over `RegJFan`; name it in those docstrings. If `gamma` proves large — the plan says it may — stop at a saved stage and say so: every consumer still lands over a `Fan`.",
     nleaf="31 `sorry` leaves over five files: seven yours"),
   "E":dict(tree="fs131-w6g",job="FS131-I6E",
     files="`Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean` — its five lemmas about any fan, in the namespace `AeColouring.Fan`: `two_le_n`, `col_ne`, `branch_outside_discs`, `branch_contacts`, `sector_alone` (five leaves; `sector_unique` is already proved from the last)",
     what="what every fan carries — two sides of two colours, branches outside the tangent unit discs, the contacts at a branch, one sector per colour",
     mods="`FanBridge` (its five `Fan` lemmas)",
     stm=[("FanBridge.lean",p) for p in ["theorem two_le_n ","theorem col_ne ","theorem branch_outside_discs ","theorem branch_contacts ","theorem sector_alone "]],
     planrows=["| `Plane/Saturated/FanBridge` (imports","| `Fan.two_le_n`, `Fan.col_ne` | ","| `Fan.branch_outside_discs` | ","| `Fan.branch_contacts` | ","| `Fan.sector_alone` | ","### 10.2 The two facts the design's `Fan` has no field for"],
     order="`two_le_n` and `col_ne` (no saturation; they re-price the rest), `branch_outside_discs`, `branch_contacts`, then `sector_alone` — the row FS121-V2-SECTOR, whose argument is `plans/FS121-V2-verification.md` §§ 2.2–2.3",
     extra="**A deriver checked these five statements today, and its check is your second plan** (the deriver's record, Stage 6, §§ 6.1–6.3 and 6.5; inventory items 504–505, quoted above). Three things it found bind you: (i) `branch_contacts`' alternative is **inclusive** — a unit arc with a further contact at the antipode is of both types — so no proof may case-split on it as exclusive, and you amend that theorem's docstring to say so (a docstring line is not a statement change; your statement check says which lines it allows); (ii) the branch's tangent at `z` does not come from `beta` alone: go through `gamma` and `IsUnitCurve.exists_polarGraph`; (iii) `branch_contacts`' first alternative needs no bound `1/2` and no saturation beyond the one common contact. **The other seven leaves of the file are not yours** (`gamma`, `IsUnitCurve.exists_polarGraph`, `beta`, `alpha`, `fan_of_isolated`, `regJLiteral_of_saturated`, `finite_arcs_of_isBounded`): another implementer takes them on `fs131-w6f` — use them as stated (they are `sorry` on your branch and your theorems rest on them, expected and said in your record), leave their `sorry`s, and put your helpers directly above `namespace Fan` or between your own leaves, never above `gamma`, so the two branches merge without touching the same lines. Each of the five names its Lean model in its docstring (`sq9Fan`; the plan's § 12.2 says with which facts).",
     nleaf="31 `sorry` leaves over five files: five yours")}[LANE]
TREE,JOB,FILES=T["tree"],T["job"],T["files"]
W=WT+TREE+"/"; K6=W+"plans/FS131-w6-kernel-plan.md"; E8="plans/FS131-E8-derivation.md"
V=W+"Proofs/HadwigerNelson/Plane/Saturated/"
STMTS="\n".join(Q(V+f,p) for f,p in T["stm"])+"\n"
EXTRAITEMS=(item(504)+"\n"+item(505)+"\n") if LANE=="E" else ""
PLAN="\n".join([Q(K6,"## Stage 11 — SAVED: the bridge's eight rows"),Q(K6,"### 11.4 The plan per leaf")]+[Q(K6,p) for p in T["planrows"]]+[Q(K6,"### 12.1 For implementers: the split by file"),Q(K6,"### 12.2 Vacuity and inhabitants")])+"\n"
b=f'''# Brief {JOB} — wave 6, the bridge: {T["what"]} — the open leaves of {T["mods"]}, on `{TREE}`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: one of the implementers of wave 6's bridge, split by file — prove the open leaves of {FILES} from the planner's plan and the deriver's argument, without changing a statement, saving after each leaf or group
  launch: when a slot frees, on a branch cut from the commit at which the wave's second planner handed back; other implementers work the wave's other files on branches of their own, and a third planner will add modules downstream
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me, and three other jobs read these statements), a step of the deriver's argument that fails or does not formalize (with its address: it goes to a deriver), a definition or lemma of another file you need changed or exported, or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from `fs131-w6` at `32f2ab4c`): {FILES} — proofs, and new helper declarations under names no other module declares (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name); a new module of your own beside them if the helpers want one, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner), `plans/{JOB}-implementation.md`, `tools/fs131_i6{LANE.lower()}_*.py`, `data/fs131/i6{LANE.lower()}/`, `data/fs131/reports/{JOB}.md`; **not** `Basic`, `Pinch`, `MapColouring`, `Fan`, the planners' record, the wave's files that are not yours, any landed module beyond new declarations, `main`
  budget: {BUDGET}

Hello. You are proving part of the bridge of wave 6 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 6 is about *saturated* colourings — measurable colourings whose classes are carved by unit
circles about their own points. Every result of the wave about a singular point reads a *fan* there: finitely many curves leaving the point,
each with a direction, one colour between neighbours. This morning a deriver showed that the fan is no extra assumption — in a saturated
colouring it exists at every singular point that is isolated among the singular points — and the wave's second planner stated that argument in
Lean as three modules with `sorry` at the leaves, proving the bridge itself from the fan lemma. The leaves are the mathematics. This part is
yours: {T["what"]}.

## Why this job

A result counts as held only when its Lean module passes the gate. With the bridge in the kernel, every wave-6 result reads, under saturation,
one hypothesis — the singular set is locally finite — which is exactly what the frontier's next milestone asks; until then the wave rests on one
mind's hand argument. Kooshi, on pricing this work:

{KOOSHI}
What the planner and the deriver handed back and the rulings in force (read each item whole in the inventory):

{item(501)}
{item(502)}
{item(490)}
{item(499)}
{EXTRAITEMS}## The statements

No statement changes in this job. Your leaves, as they stand in your tree (read each whole, with its docstring):

{STMTS}The plan (the planners' record, `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/plans/FS131-w6-kernel-plan.md`: read Stages 9–12 whole —
§ 11.3 reads each statement against the deriver's entry, § 11.4 is the plan and the price per leaf, § 11.5 the planner's findings) and the
argument it formalizes (the deriver's record on `main`, `/home/kooshi/source/lean-dir/plans/FS131-E8-derivation.md`, Stage 3: read §§ 3.1–3.7
whole, with the dated erratum under its § 3.1; its Stage 6 is the deriver's check of the planner's statements, read-backs included):

{PLAN}
{Q(E8,"## Stage 3 — SAVED: the derivation — the four clauses, the fan, the bridge")}
## Done means

1. **Your readback first**: check the quotations against their sources; read the planners' record (Stages 9–12; the first pass's Stages 3 and
   5 for the foundation), the modules `Basic`, `Pinch`, `Fan`, `Curve`, `LocalGraph`, `FanBridge` as far as your leaves read them, and the
   deriver's Stage 3. Build the branch once as given ({T["nleaf"]}). Open your record with what you may and may not change. Commit and push.
2. **The leaves**, in this order — {T["order"]}; saving after each leaf or group (a build, the axioms print for it with a control that fires,
   a statement check against `32f2ab4c`, commit, push). Re-price after your first two leaves and say so: the planner expects its prices for
   the computational leaves to be high by a factor of two to three, and not for the large ones.
3. {T["extra"]}
4. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch, run the gate, or touch `main`. Leave no background process running, and keep what your record cites under your `data/`
   folder.
5. **Your record**, stages headed "Stage n — SAVED ({JOB})", "Theorems this phase proved", each read against its entry; the report in
   standing rule 11's form, ending with what is left and its route. This is priced at more than one job: stopping at a saved stage with part
   of the leaves proved, and a work list a successor can start cold from, is a good report.

## What is yours to decide

The route inside each leaf, your helpers and where they live, and the order within the plan's dependencies. The plan is one mind's on paper
and the argument under it another's, each written today and neither yet compiled past its statements; change a route that does not go and say
so. A statement is not yours to change: one that is false, or true only with a hypothesis the plan did not see, is a message to me, and a
finding — the planner's mutation audit (its § 11.5, last paragraph) says which hypotheses it believes each statement needs. Three failed
attempts on one route is a dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-wave6-bridge.md","w").write(b)
print("written",JOB)
