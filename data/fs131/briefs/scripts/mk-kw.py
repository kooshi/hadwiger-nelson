exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import sys,subprocess
N=sys.argv[1]  # 7, 8 or 9
KP="plans/FS131-kernel-plan.md"
PIDENT="de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow"
T={
"7":dict(title="the twenty rows on four-colour vertices — route T's count, bowties and lunes, pinwheels",
   what="twenty rows about a vertex where four colours meet in a tight six-colour map — the count that gives six room (route T), the bowtie and the lune, the pinwheel — from the milestone FS-114, with one composition of FS-129",
   rowhead="**Wave 7** (20 rows):",table="| 7 | four-colour vertices",
   mods=["- `Plane/RouteT`: ","- `Plane/FourColour/Bowtie`: ","- `Plane/FourColour/Pinwheel`: ","- merged here: FS114-N3-DR"],
   layout="`Plane/RouteT` and `Plane/FourColour/` (the plan names `Bowtie`, `Pinwheel`)",
   ledger="rows 137–138",
   cross="By the backlog's own tags this wave rests on waves 3, 4 and 5 only, all on `main`; nothing of it waits on another wave in flight.",
   special="The plan's § 7.3 item 2 leaves one decision to you by name: what \"simple\" means for a fragment whose tiles cross the domain's boundary (the literal reading over all tiles, or the narrower one over tiles meeting the disc, which would strengthen every class statement). Decide it in the foundation, say what each reading costs, and tell me at once: wave 8's planner states its classes over the same word. The wave's table row names an outside theorem — Euler's formula for cellular torus maps, and the passage from a doubly periodic valid map to one: say whether each is formalized here, taken from Mathlib, or named as a hypothesis with `LEAN.md` § Assumptions' four items."),
"8":dict(title="the twenty-two rows of the ring calculus — the star, semi-hubs, and the emptiness of the Γ-free class",
   what="twenty-two rows about the unit ring of a four-colour vertex in the non-Siamese class — what the ring passes to the vertices it places (the star, the semi-hubs) and the emptiness of the Γ-free class — from the milestone FS-116, with three compositions of FS-129",
   rowhead="**Wave 8** (22 rows):",table="| 8 | the ring calculus",
   mods=["- `Plane/RingCalculus/Star`: ","- `Plane/RingCalculus/SemiHub`: ","- `Plane/RingCalculus/Empty`: ","- merged here: FS116-Y4-EMPTY"],
   layout="`Plane/RingCalculus/` (the plan names `Star`, `SemiHub`, `Empty`)",
   ledger="rows 145–150",
   cross="By the backlog's own tags this wave rests on waves 1, 3 and 4, all on `main`, and three of its rows (FS116-N3-STAR2, FS116-N3-CROSS, FS116-RING-TRANSFER-QC) on one row of wave 7, FS114-N7-QOPP, which a sibling planner is stating now on `fs131-w7`. Take that row as a named hypothesis in those three statements, under a name of your own, read from its derivation entry (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name); the join replaces the hypothesis by wave 7's theorem.",
   special="The plan's § 7.3 item 5 names this wave: a route lemma over a class the backlog proves empty (the V6 lemmas) carries its vacuity in its docstring, in `LEAN.md` § The gate's form. And § 7.3 item 2's open word \"simple\" (a fragment's tiles that cross the domain's boundary) is being decided by wave 7's planner: state your classes with that reading as a parameter or over the literal one, say which, and I relay its decision when it arrives."),
"9":dict(title="the eleven rows of the reductions and the class statements",
   what="eleven rows of two kinds — the reductions behind \"six measurable colours do not suffice at bounded complexity\" (from FS-111, with FS-129's TOP5) and the class statements FS-129 composed (a bend for any arc, the (Q)-free class, DISC-F in the non-Siamese class)",
   rowhead="**Wave 9** (11 rows):",table="| 9 | the reductions",
   mods=["- `Plane/Reduction`: ","- `Plane/Classes`: ","- merged here: FS116-S1-QF"],
   layout="`Plane/Reduction` and `Plane/Classes`",
   ledger="rows 139–141 and 149–153",
   cross="By the backlog's own tags this wave rests on waves 1–5, all on `main`, and one of its rows (FS129-SR3-QFREE-NS) on one row of wave 8, FS129-SR3-EMPTY-NS, which a sibling planner is stating on `fs131-w8`. Take that row as a named hypothesis in that statement, under a name of your own, read from its derivation entry (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name); the join replaces the hypothesis by wave 8's theorem. Nothing here rests on wave 6.",
   special="The wave's table row names its hypothesis from outside the backlog: row 130's conclusion, `χ(ℝ²) = χ_m⁰(ℝ²)`, for the two rows that end \"hence χ(ℝ²) ≥ 6\" given measure rigidity. It enters as a named hypothesis (`Row130Collapse`, as the plan's § 7.4 has it), never an axiom; Kooshi has ruled that measure rigidity itself is not formalized or priced now (inventory item 488), so do not open it. Every \"given MR\" in a row is read for what it hides beyond that one hypothesis."),
}[N]
TREE="fs131-w"+N; JOB="FS131-K"+N
W=WT+TREE+"/"
TIP=subprocess.run(["git","-C",W,"rev-parse","--short","HEAD"],capture_output=True,text=True).stdout.strip()
MODS="\n".join(Q(KP,p) for p in T["mods"])+"\n"
b=f'''# Brief {JOB} — wave {N} planned: {T["title"]}

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {PIDENT}
  role: plan wave {N}'s kernel modules — read its rows' derivation entries in full, write the wave's foundation sorry-free, state every row as a skeleton with `sorry` at each leaf, read each statement back against its row, a plan and a price per leaf, the outside theorems named, and a handoff implementers can split by file; prove a leaf yourself where it is short
  launch: when a slot frees, on a branch cut from `main` — which holds waves 1–5 and, since today, the example maps (`Proofs/HadwigerNelson/Plane/Models/`) — in a tree of your own, beside the planners and implementers of other waves on other branches
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect in a row (at once, with the entry's address: it goes to a deriver), a definition you fix that another wave's planner reads, a generalization or a shorter route, an outside theorem you would import, a row that cannot be stated at the class its argument reads, or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate: the inhabitant rule and the doubled-name check; § Searching — Lean, last bullet: two branches never state one lemma under one name), and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w{N}-kernel-plan.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from `main` at `{TIP}`): new modules under {T["layout"]} — the layout is yours — with `Proofs.lean` and `ARCHITECTURE.md` for them; **new declarations only** in landed modules (no statement, definition or docstring of a landed declaration is edited); `scripts/Axioms.lean` (a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner), `plans/FS131-w{N}-kernel-plan.md`, `tools/fs131_k{N}_*.py`, `data/fs131/k{N}/`, `data/fs131/reports/{JOB}.md`; **not** `main`, another wave's branch, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`
  budget: {BUDGET}

Hello. You are opening wave {N} of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked ones:
259 rows in ten waves. Waves 1–5 are on `main`, with a library of example maps that landed today; waves 6 and 10 are planned and being
proved on their own branches. Wave {N} is {T["what"]}. Nobody has read these rows against Lean yet. You do, and you lay the wave out.

## Why this job

A result counts as held only when its Lean module passes the gate. These rows are the hand results the frontier's next milestones stand on
(`LEDGER.md` {T["ledger"]}; `CLAUDE.md` § Where the problem stands, item 31): a statement defect found now, while the row is being stated, costs
a message; found by a later milestone that built on it, it costs that milestone. Kooshi, on pricing this work:

{KOOSHI}
The milestone's plan is your map; its § 7.3 says what every wave's planning job must hold, and it binds you (read §§ 7.1–7.5 whole):

{Q(KP,"### 7.3 What each wave's planning job must hold")}
{Q(KP,"1. **Reads its rows' derivation entries in full**")}
{Q(KP,"2. **Writes the wave's foundation first**")}
{Q(KP,"3. **States every row at the class its argument reads**")}
{Q(KP,"4. **Names every hypothesis from outside the backlog**")}
{Q(KP,"5. **Checks vacuity at the seam**")}
What the two waves planned before yours handed back — read both items whole: each first pass held the dispositions, the foundation and part of
the skeleton, and each found filed statements that hid a hypothesis:

{item(486)}
{item(484)}
## The statements

The wave's rows, by module, from the plan (each row's address is in `plans/LEAN-BACKLOG.md`, which gives its derivation file's line; the plan's
CSV, `data/fs131/k1/dispositions.csv`, gives its disposition, its merges and any ruling), and the wave's line of the plan's table — its
foundation and its hypotheses from outside:

{Q(KP,T["rowhead"])}
{MODS}{Q(KP,T["table"])}
{T["cross"]}

{T["special"]}

## Done means

1. **Your readback first**: check every quotation above against its source; read the plan's §§ 7.1–7.5 and its CSV rows for wave {N}, each
   row's entry in `plans/LEAN-BACKLOG.md` and its derivation entry in full, with errata; what `Proofs/HadwigerNelson/Plane/` already holds
   that the rows reuse (read `ARCHITECTURE.md`'s rows for waves 3–5 and for `Proofs/HadwigerNelson/Plane/Models/`). Register, before reading the derivations
   closely, which rows you expect to be short, which to need an outside theorem, and which to hide a statement defect. Build the branch once
   as given (no `sorry`). Open your record. Commit and push.
2. **The dispositions**: for each row — the statement at the class its argument reads (G92), what it rests on inside the backlog, every
   hypothesis from outside it (named, with `LEAN.md` § Assumptions' four items for an imported theorem; formalize anything that is about an
   hour of work), and whether it is a theorem, a named-hypothesis implication, or a certified computation (`LEAN.md` § The kernel's cost
   model). A row whose derivation does not support its statement is a message to me at once.
3. **The foundation, sorry-free**: the definitions the rows' words need, each with a spec example that would fail if it drifted and each
   structure with a named inhabitant — the example maps on `main` (`Proofs/HadwigerNelson/Plane/Models/`: every one is the seven-colour brick map read in more
   colours with a picture painted in the spare ones) are where a model of a map-level hypothesis comes from; the domain-modeling pass
   (`debruijn-domain-modeling`, invoked fresh) over it.
4. **The skeleton**: every row a statement with `sorry` at its leaves, building through the worktree's `./scripts/build.sh` with only `sorry`
   warnings; each formal statement read back against its row in your record; `Proofs.lean`, `ARCHITECTURE.md`
   (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated; no new `axiom`, no `native_decide`; `./scripts/dupnames.sh` on
   your tree — no name declared by two modules.
5. **Your record**: a plan per leaf (route, the Mathlib and library lemmas confirmed with `#check`, what is hard, a price — re-priced from the
   first two leaves you prove), the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), the hypotheses' inhabitants and
   the vacuity lines, and a handoff for implementers with how two could split the work by file. A leaf you can prove in about an hour, prove,
   and say so.
6. The report, in standing rule 11's form. You do not merge another branch into this one, run the gate, or touch `main`. Leave no background
   process running, and keep what your record cites under `data/fs131/k{N}/`. The rows may be more than one planning pass holds: stopping
   at a saved stage with the dispositions and the foundation done and the skeleton for one module is a good report — say where a second pass
   takes over.

## What is yours to decide

The modules and their layout, the foundation's definitions, the form of each statement within what its row claims, what is formalized and what
is named as a hypothesis, and the order. The plan's wave table is a planner's first sorting, written before any of these rows was read closely;
where a row belongs with another wave, or two rows are one theorem, say so. Attack the rows: a statement that is true only at a narrower class
than its entry says, or a "given MR" that hides more than MR, is the finding this job is best placed to make — the two waves planned before
yours each found such rows. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-wave"+N+".md","w").write(b)
print("written",JOB,"at tip",TIP)
