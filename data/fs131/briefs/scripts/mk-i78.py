exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import sys
LANE=sys.argv[1]  # 7 (wave 7: RouteT/Count, then Rainbow's anchor) or 8 (wave 8: RingCalculus/Empty, then Star)
SQ9=sys.argv[2] if len(sys.argv)>2 else None  # wave 8 only: the commit of wave 6's branch that holds `sq9` as an `ArcMap 9`
P="Proofs/HadwigerNelson/Plane/"
if LANE=="7":
    TREE,JOB,BASE,WAVE,PLANNER="fs131-w7a","FS131-I7A","b5ef0e39","7","FS131-K7"
    FILES=f"`{P}RouteT/Count.lean` (nineteen leaves, and the two inhabitants of `CountData` the plan derives) and, if budget remains, `{P}RouteT/Rainbow.lean` (one leaf, `anchor`)"
    WHAT="route T's count on a combinatorial map"
    STM=[("RouteT/Count.lean","theorem "+n+" ") for n in ["sigma_bijOn","card_slotSet","nbrs_subset_slotFace","mu_eq_zero_iff","card_edgeNbrs","card_vertNbrs","absent_nonneg","deg_le","tile_identity","absentNbrs_le","two_mul_card_tac_le","count_poly","five_count","room","slack","ends_identity","joint_first","kill","joint"]]+[("RouteT/Rainbow.lean","theorem anchor ")]
    PLANQ=["### 3.2 The outside theorem — decided","### 3.3 What is on the branch","### 3.5 The plan per leaf","**Inhabitants owed before the gate**","### 4.4 The handoff","- **I7A, `Plane/RouteT/Count`**","- **I7B, `Plane/RouteT/Rainbow`'s `anchor`**"]
    ITEMS=[512,513]
    INTRO='''Wave 7 is twenty rows: the seven of *route T's count* — a count over the tiles of a map that bounds how many colours it can
carry — and thirteen about four-colour vertices. Its first planner stated the seven on a *combinatorial map* (a rotation system on darts, with
`V − E + F = 0` a hypothesis; Euler's formula is not imported), proved three of them in part or whole, and left the count's leaves open.
They are yours. A second planner will state the thirteen four-colour rows in new modules; nothing of yours waits on it.'''
    WHY='''A result counts as held only when its Lean module passes the gate. These rows are what the frontier's open stub on route T's count
(FS-117; `CLAUDE.md` § The aim, the program) stands on, and the planner found them wider than filed: the count holds at every Euler
characteristic at most 0, not only on a torus.'''
    ORDER="the handoff's order for `Count` (its four groups, quoted above), then the two grids as `CountData` inhabitants, then `anchor` if budget remains"
    NLEAF="20 `sorry` leaves: nineteen in `Count`, one in `Rainbow`"
    EXTRA=f'''**The inhabitants are part of done**: `CountData 9` on the `3 × 3` square torus and `CountData 15` on the `4 × 4`, as the plan derives
   them by hand (quoted above; no search — if a field fails in the kernel, the hand derivation is wrong at a named place, and that is a message).
   Their fields are closed terms over a finite type: measure the kernel's time on one field before choosing the shape (`LEAN.md` § The kernel's
   cost model; no `native_decide`). Each is a named declaration with its record in `scripts/Axioms.lean`, an `example` applies a proved theorem
   of yours to it, and the count's theorems name it in their docstrings in `LEAN.md` § The gate's form. `five_count` is a refutation: its
   docstring says no `CountData 5` at Euler characteristic at most 0 exists, and names the object meeting every other hypothesis.
4. **What the kernel will not hold, and no docstring may suggest** (ruling 512 (i)): that a doubly periodic valid map gives such a combinatorial
   map. The rows are theorems about `CMap` and `CountData`; write "a combinatorial map with `chi2 = 0`", never "a torus map" of an `ArcMap`.
5. **`anchor` last, if budget remains** (my ruling: the planner proposed it ride with the second pass's first implementer; no such job exists
   until that pass hands back, the file is nobody else's, and its price is about 60k). It reads wave 3's `localSectors`; its model is `sixFrag`'s
   centre, by the plan. If your count at the last saved stage of `Count` is past about 350k, leave it and say so.'''
    NEXTN=6
else:
    TREE,JOB,BASE,WAVE,PLANNER="fs131-w8a","FS131-I8A","f1c13612","8","FS131-K8"
    FILES=f"`{P}RingCalculus/Empty.lean` (six leaves on the route to `emptyNS`: `ringPt_sixth_dist_le_one`, `v6_count`, `exists_ne_mem_closure_inter_of_split`, `v6_hug`, `v6_hubs`, `emptyNS`) and, if budget remains, `{P}RingCalculus/Star.lean` (two leaves, `star_recip`, `star_anti`)"
    WHAT="the empty class — no Γ-free four-colour vertex in a non-Siamese six-map"
    STM=[("RingCalculus/Empty.lean","theorem "+n+" ") for n in ["ringPt_sixth_dist_le_one","v6_count","exists_ne_mem_closure_inter_of_split","v6_hug","v6_hubs","emptyNS","v6_hubs_vacuous","v6_hug_vacuous"]]+[("RingCalculus/Star.lean","theorem star_recip "),("RingCalculus/Star.lean","theorem star_anti ")]
    PLANQ=["### 5.1 Prices, from the first leaves","### 5.2 `Empty` — the route to `emptyNS`","- **`v6_hubs`** (the hard leaf","- **`ringPt_sixth_dist_le_one`**:","- **`v6_hug`**:","- **`v6_count`**:","- **`exists_ne_mem_closure_inter_of_split`**:","- **`emptyNS`**:","### 5.3 `Star` — the two open leaves","- **`star_recip`**","- **`star_anti`**","### 5.4 The statements, attacked","| `emptyNS` | a refutation;","| `star_flank`, `star_outer_cone`, `v6_anti`,","### 5.6 The handoff","- **Two implementers, by file**:"]
    ITEMS=[518,524,525]
    INTRO='''Wave 8 is twenty-two rows of the *ring calculus*: what the unit circle about a vertex of a valid map (its *ring*) carries, in the class
with no Siamese pair (two tiles of one colour nearer than 1). Its first planner wrote the foundation, proved three rows, and stated eight more
with ten leaves. Six of those leaves are one route, to the theorem that no valid non-Siamese six-coloured map covering a disc about a vertex of at
least four colours has a ring carrying no boundary arc (`emptyNS`). That route is yours; two leaves of a second file follow if budget remains.'''
    WHY='''A result counts as held only when its Lean module passes the gate. `emptyNS` is the kernel form of the frontier's sentence that a
four-colour vertex whose ring carries no boundary arc dies at `1 + ε` (`CLAUDE.md` § Where the problem stands, item 31; `LEDGER.md` row 148;
its entry is FS129-SR3-EMPTY-NS in `plans/FS129-derivation.md`); the statement here reads the non-Siamese class and no simplicity. The next
milestones' case list starts from it.'''
    ORDER="the handoff's order for `Empty` — `ringPt_sixth_dist_le_one`, `v6_count`, `exists_ne_mem_closure_inter_of_split`, `v6_hug`, `v6_hubs`, then `emptyNS`; then `star_recip`, `star_anti` if budget remains"
    NLEAF="10 `sorry` leaves: eight in `Empty` (six yours; `outerAdj` and `doubleTip` wait for the second planning pass and stay), two in `Star`"
    if SQ9:
        MODEL=f'''**The model is owed, and is not yours** (ruling 525 (c), amended by inventory item 530): `emptyNS` is a refutation at six colours, and the
   gate's inhabitant rule asks for a Lean object meeting its hypotheses but the one it fails. That object is wave 6's nine-colour grid map,
   which now exists: `sq9Map : ArcMap 9`
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6m/Proofs/HadwigerNelson/Plane/Saturated/Sq9Map.lean`, on `origin/fs131-w6m` at
   `{SQ9}`), with `IsPlaneMap` proved and nothing yet about `Valid`, `NonSiamese`, `Covers`, the colours at a lattice vertex or its ring.
   Those five facts are a job after yours, on a line that holds both waves: do not merge that branch (it carries another wave's open
   leaves) and do not build a nine-colour map of your own. `emptyNS`'s docstring says the model is owed and names the map and the facts.'''
    else:
        MODEL='''**The model is owed, and is not yet yours** (ruling 525 (c)): `emptyNS` is a refutation at six colours, and the gate's inhabitant rule asks
   for a Lean object meeting its hypotheses but the one it fails — wave 6's nine-colour grid map, which another implementer is building now.
   If I send you its commit mid-job, the model becomes your last item (a new module importing it: `Valid`, `NonSiamese`, `Covers`, four
   colours, `GammaFreeRing` at the lattice vertex the plan names); otherwise `emptyNS`'s docstring says the model is owed and names it.'''
    EXTRA=f'''{MODEL}
4. **Declared vacuity stays as the planner left it** (ruling 518): `v6_hubs` and `v6_hug` are public, each with its `VACUITY DECLARED` line and a
   companion (`v6_hubs_vacuous`, `v6_hug_vacuous`) deriving `False` from its exact hypotheses through `emptyNS`. Do not make them private, and
   do not weaken the companions: when `emptyNS` is proved they are kernel facts. The planner's caution on `v6_hubs` is in its plan — the count
   alone does not give one change point per sixth of the ring, and the colour argument is a child (H4, H7) — read it before you start that leaf.
5. **`v6_count` is a certified computation**: measure the kernel's time on the encoded statement before choosing between `decide +kernel` and
   the five-line hand count (the plan gives both; `LEAN.md` § The kernel's cost model; no `native_decide`). The planner's tool
   (`/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/tools/fs131_k8_count.py`) counts 72 configurations: if the kernel disagrees, stop
   and report.'''
    NEXTN=6
W=WT+TREE+"/"; KP=W+f"plans/FS131-w{WAVE}-kernel-plan.md"; V=W+P
STMTS="\n".join(Q(V+f,p) for f,p in STM)+"\n"
PLAN="\n".join(Q(KP,p) for p in PLANQ)+"\n"
ITEMQ="\n".join(item(n) for n in ITEMS)+"\n"
b=f'''# Brief {JOB} — wave {WAVE}, {WHAT}: the open leaves of the first planning pass, on `{TREE}`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: wave {WAVE}'s first implementer — prove the open leaves of {FILES} from the planner's plan, without changing a statement, saving after each leaf or group
  launch: when a slot frees, on a branch cut from the commit at which the wave's first planner ({PLANNER}) handed back; a second planning pass may run beside you on the planner's branch, adding modules
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me), a step of the plan's route that fails (with its address), a certificate or tool that disagrees with the kernel, a definition in the wave's foundation you need changed, or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from `fs131-w{WAVE}` at `{BASE}`): {FILES} — proofs, and new helper declarations under names no other module declares (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name; run `./scripts/dupnames.sh` before each push that adds names); a new module of your own beside them if the helpers or a model want one, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner), `plans/{JOB}-implementation.md`, `tools/fs131_i{WAVE}a_*.py`, `data/fs131/i{WAVE}a/`, `data/fs131/reports/{JOB}.md`; **not** the wave's foundation modules or any statement, the planner's record, any landed module beyond new declarations, `main`
  budget: {BUDGET}

Hello. You are proving part of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked ones;
waves 1–5 are on `main`. {INTRO}

## Why this job

{WHY} Kooshi, on pricing this work:

{KOOSHI}
What the planner handed back and the rulings in force (read each item whole in the inventory):

{ITEMQ}## The statements

No statement changes in this job. Your leaves, as they stand in your tree (read each whole, with its docstring):

{STMTS}The plan (the planner's record, `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/plans/FS131-w{WAVE}-kernel-plan.md`: read it whole; the
sections quoted give a route per leaf, the lemmas it confirmed, what is hard, and a price):

{PLAN}## Done means

1. **Your readback first**: check the quotations against their sources; read the planner's record whole, your files and the modules they
   import, and each row's derivation entry at the address the record gives. Build the branch once as given ({NLEAF}). Open your record with
   what you may and may not change. Commit and push.
2. **The leaves**, in this order — {ORDER}; saving after each leaf or group (a build, the axioms print for it with a control that fires, a
   statement check against `{BASE}`, commit, push). Re-price after your first two leaves and say so: this milestone's implementers have come in
   at a third to two thirds of their planners' line counts.
3. {EXTRA}
{NEXTN}. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch but as this brief says, run the gate, or touch `main`. Leave no background process running, and keep what your record cites
   under your `data/` folder.
{NEXTN+1}. **Your record**, stages headed "Stage n — SAVED ({JOB})", "Theorems this phase proved", each read against its row; the report in standing
   rule 11's form, ending with what is left and its route. Stopping at a saved stage with part of the leaves proved is a good report.

## What is yours to decide

The route inside each leaf, your helpers, and the order within the plan's dependencies. The plan is one mind's, written today and compiled
only as far as its statements; change a route that does not go and say so. A statement is not yours to change: one that is false, or true
only with a hypothesis the plan did not see, is a message to me, and a finding. Three failed attempts on one route is a dispatch to the
companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+f"-wave{WAVE}-first.md","w").write(b)
print("written",JOB)
