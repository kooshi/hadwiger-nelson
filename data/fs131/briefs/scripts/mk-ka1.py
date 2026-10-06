exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import subprocess,sys
# usage: mk-ka1.py <worktree name> <branch> <"launch" line> — run at launch, when IA1's stage holding the statement is committed
TREE=sys.argv[1] if len(sys.argv)>1 else "fs131-w5a"
BR=sys.argv[2] if len(sys.argv)>2 else TREE
LAUNCH=sys.argv[3] if len(sys.argv)>3 else "now, in the tree FS131-IA1 has handed back, beside FS131-IR2 (the vertex step, on `fs131-w5c`, which holds `Procedure.lean`) and FS131-E7 (a deriver, on `main`)"
A=WT+TREE+"/"
TIP=subprocess.run(["git","-C",A,"rev-parse","--short","HEAD"],capture_output=True,text=True).stdout.strip()
V=A+"Proofs/HadwigerNelson/Plane/ValidMap/"
BS=V+"BendStep.lean"; BC=V+"BendCollar.lean"; UA=V+"UnitArc.lean"
IA=A+"plans/FS131-arcstep-implementation.md"
NP="plans/FS112-N-proof.md"; E5="plans/FS131-E5-derivation.md"
PIDENT="de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow"
b=f'''# Brief FS131-KA1 — the outward collar bend planned: `bend_away_part` read back, laid out as named children, and priced, on `{BR}`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KA1
  identity: {PIDENT}
  role: plan the one bend the arc step needs that is proved nowhere — attack its statement first (two points its author did not check), then lay `bend_away_part` out as named children with `sorry` at each over the collar machinery the toward bend was built on, read each back, a plan and a price per child, the obligation pass, its hypothesis set's inhabitant on a plane map, and a handoff that can split the work between two implementers; plan or prove the second open child `CollarFit.map_hornCount_le`; prove a child yourself where it is short
  launch: {LAUNCH}
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a clause of `bend_away_part` that is false or that the construction cannot meet (at once: the arc step's assembly reads this statement), a step with no hand derivation behind it (a deriver takes it), a piece of the collar machinery that is private where you need it, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-KA1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-bendaway-kernel-plan.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{BR}`, at `{TIP}` when this brief was written): `Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean` (the two open children — `bend_away_part`'s proof from your children, `CollarFit.map_hornCount_le`; `bend_away_part`'s statement only after a message to me) and new modules upstream of it for the outward bend, with `Proofs.lean` and `ARCHITECTURE.md` for them; **new declarations only** in `RadialPush`, `CollarMap`, `Pushforward`, `BendCollar` and `UnitArc` (a named form that exposes a construction, or a `private` helper made public — no landed or proved statement or definition changed; ruling 421 (c)); `scripts/Axioms.lean` (a block of your own, headed "FS131-KA1", above the `=== PURCHASED ===` banner), `plans/FS131-bendaway-kernel-plan.md`, `tools/fs131_ka_*.py`, `data/fs131/ka/`, `data/fs131/reports/FS131-KA1.md`; **not** `Procedure.lean` (FS131-IR2 is proving the vertex step in it on `fs131-w5c`; the arc step's assembly there is a later job's), `Terminal.lean`, the move modules, `main`
  budget: {BUDGET}

Hello. You are planning the last construction on wave 5's path that nobody has laid out. The milestone, FS-131, turns this project's hand-derived
results into kernel-checked ones; waves 1–4, Woodall's chain, MERGE and OPEN are on `main`. Wave 5's termination procedure rests on two steps. The
vertex step is being proved now. The arc step bends a bad unit arc off its circle: toward the centre when the outer colour is absent there — that
bend, the collar bend, is proved, a homeomorphism of the plane that carries colours, degrees and horn counts — and away from the centre when the inner
colour is absent. The implementer who read the arc step against the library, FS131-IA1, found that neither of wave 4's away bends can serve: their
lens is a chord that cuts through whatever sits at the arc's ends, and they export no map the step can read. So the outward bend is needed in the
collar's form, and IA1 wrote its statement. You plan its proof.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and
`exists_terminalMap` — every valid map of the plane has a terminal valid modification — now waits on this bend more than on anything else. The toward
collar bend took a plan and two implementer sessions; this is its mirror with one new feature, the radius-2 contacts the bend must stop at. Kooshi, on
pricing this work:

{KOOSHI}
The findings and rulings that launch you:

{item(433)}
{item(434)}
{item(429)}
{item(430)}
and the ones the toward bend was built under:

{item(416)}
{item(419)}
{item(427)}
## The statements

The statement you plan to, as IA1 left it (`sorry`; read it whole with its docstring, which states the intended construction), and the second open
child:

{Q(BS,"theorem bend_away_part ")}
{Q(BS,"theorem CollarFit.map_hornCount_le ")}
The proved bend it mirrors — its clauses are the family `bend_away_part`'s are written in — and wave 4's whole-arc away bend, whose clearing argument
(`away_clear`) the docstring reuses:

{Q(BC,"theorem bend_toward_collar ")}
{Q(UA,"theorem bend_away_whole ")}
The hand derivations behind it: FS-112's two rows, and the end case derived for this milestone (read E5's Stage 4 whole — a lens tangent to the circle
at an isolated contact, with an exact curvature threshold):

{Q(NP,"| N2-AWAY |")}
{Q(NP,"| N2-TAN |")}
{Q(E5,"## Stage 4 — SAVED: Q2 derived")}
IA1's reading, which chose this form (read its Stage 3 whole, and Stage 4 when it is there):

{Q(IA,"## Stage 3 — SAVED (FS131-IA1): the reading")}
Wave 4's `bend_away` — the same conclusion without the homeomorphism, left `sorry` — is on branch `fs131-w4ba` at `71cca146` (no worktree; read it with
`git show`), with the fragment `isoFrag`, the hand model with one isolated contact.

## Done means

1. **Your readback first**: check every quotation above against its source; read IA1's record (Stages 3 and 4) and the module `BendStep` whole (`/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean`); the toward
   bend's plan and implementation records on this branch (`/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/plans/FS131-collar-kernel-plan.md`,
   `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/plans/FS131-collar-C-implementation.md`) and its four modules (`RadialPush`, `CollarMap`,
   `Pushforward`, `BendCollar`); `plans/FS112-N-proof.md`'s stage N2-3; E5's Stage 4. Build the branch once as given. Restate in your record what you
   are planning and what you may change. Commit and push.
2. **The statement attacked**, before any skeleton, and written up as its own stage: (i) IA1 did not check R1 — no unit arc created, and the
   constant-sided unit arcs of `M` are `F`'s — **at an interior pinch point**, where two lenses meet tangentially at an isolated radius-2 contact
   inside the arc and unit arcs about other centres may pass through; (ii) whether the horn clause is wanted as the iff it is stated as, or in the
   arc step's `∃ j' ≤ j` form, which is all the assembly reads; (iii) every other clause against N2-AWAY, N2-TAN and E5's end case — the tangent lens
   at a contact end must lie between `ω(P)` and the unit circle about the contact, so its radius is above `1`: is every clause still true there?
   A clause that is false, or true only by a step with no hand derivation, is a message to me at once, with the configuration; a weaker statement
   that the assembly can still read (IA1's work list says what it reads) is yours to propose in the same message.
3. **The skeleton**: `bend_away_part` reduced to named children with `sorry` at each, in new modules upstream of `BendStep`, building through the
   worktree's `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md` (`tools/check_architecture.py` exit 0) and
   `scripts/Axioms.lean` updated; no statement of a proved declaration changed (checked by script, with a plant that fires); no new `axiom`, no
   `native_decide`. Say which of the toward bend's children are reused as they stand, which generalize to both directions (and whether that is worth
   doing now or is a tidy move), and which are new.
4. **`CollarFit.map_hornCount_le`**: a plan (it needs the bent map's chart at an end, which the degree's proof avoided), or its proof if it is
   short — unless IA1's hand-back says it is already proved.
5. **Your record**, `plans/FS131-bendaway-kernel-plan.md`: a plan per child (route, the Mathlib and library lemmas confirmed with `#check`, what is
   hard, a price), the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), **the inhabitant** — a named Lean object, or its plan,
   satisfying every hypothesis of `bend_away_part` at once on a plane map, with a radius-2 contact so that the last clause is exercised (`LEAN.md`
   § The gate; ruling 419 (d)) — and a handoff for the implementers, with how two of them could split the work by file. A child you can prove in about
   an hour, prove, and say so.
6. The report, in standing rule 11's form. You do not edit `Procedure.lean`, merge another branch into this one, run the gate, or touch `main`. Leave
   no background process running, and keep what your record cites under `data/fs131/ka/`. Stopping at a saved stage with what is left named is a good
   report.

## What is yours to decide

The construction, the modules and their names, the children and their statements, and the order. IA1's intended construction (the docstring's: on
each gap between radius-2 contacts an outward radial push, its lens bounded by circles tangent to `ω(P)` at the gap's ends, the pushes composed) is one
mind's, at hand grade; if a different construction is shorter or reuses more of the toward bend, take it and say why. If the statement can be made
weaker and still serve the assembly, or must be made stronger to compose, propose it — you are closer to it than I am. Three failed attempts on one
route is a dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/FS131-KA1-bend-away.md","w").write(b)
print("written at tip",TIP)
