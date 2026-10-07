exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-K10d: wave 10's fourth planning pass — the carrier for the two measure rows, the two rows stated, and the link from the
# norm-one Cayley graph to the finite plane as a row (ruling 555 (c)).
# ORDER (item 600 (c)): FS131-I10G merges `origin/fs131-w10k` into a branch cut from `main` and sends the merge's hash; the coordinator
# fast-forwards `fs131-w10k` onto it; THEN this generator is run for the brief that launches. `DRY=1` writes to the scratch path given
# in OUT for a gate dry run before that (the brief then names a tip that is not the launch tip: never launch a dry run).
import subprocess,os
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
KP="plans/FS131-kernel-plan.md"
PIDENT="de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow"
TREE="fs131-w10k"; JOB="FS131-K10d"; W=WT+TREE+"/"
TIP=sh("git","-C",W,"rev-parse","--short=8","HEAD")
READY=subprocess.run(["git","-C",W,"merge-base","--is-ancestor","3b2e9848","HEAD"]).returncode==0
DRY=os.environ.get("DRY")=="1"
assert READY or DRY,"fast-forward fs131-w10k onto FS131-I10G's merge commit first (item 600 (c)), or run with DRY=1 OUT=<scratch path>"
A="Proofs/HadwigerNelson/Arith/"; REC=W+"plans/FS131-w10-kernel-plan.md"
ITEMS=[555,575,491,503,556,568,592,596]
ITEMQ="\n".join(item(n) for n in ITEMS)+"\n"
RQ=["- **Where a fourth pass (FS131-K10d) takes over**","### 14.3 What stating J45-SI-C and J45-SI-5 needs","**The model must be the canonical one, and `SpectralChain.InvariantColouring` does not serve.**",
    "**J45-SI-C**, over `IsPlaceFilter l`","**J45-SI-5**, over `IsPlaceFilter l`, a **(G2) datum**","Price: the fourth planning pass about 120k","Not invoked as fresh Skill passes in this job",
    "**The link it could not check: the kernel does not hold it.**","| candidates, unpriced into a job |"]
RECQ="\n".join(Q(REC,p) for p in RQ)+"\n"
LQ="\n".join([Q(W+A+"PlaceFilter.lean","structure IsPlaceFilter "),Q(W+A+"PlaceFilter.lean","theorem isPlaceFilter_profiniteFilter "),Q(A+"SpectralInputs.lean","theorem si4 "),
              Q(A+"MajorityVote.lean","theorem ae_eq_measurable_of_majority "),Q(A+"StandingFive.lean","def normOneCayley "),Q(A+"StandingFive.lean","def TargetFloor "),
              Q(A+"WeilKloosterman.lean","theorem targetFloor_seven_weil "),Q("Proofs/HadwigerNelson/UnitQuadrance.lean","def unitQuadrance "),Q("Proofs/HadwigerNelson/UnitQuadrance.lean","abbrev finitePlane ")])+"\n"
E8Q=Q("plans/FS131-E8-derivation.md","derivation: FS131-E8-SI5C")
ASSUME=Q("LEAN.md","- **Every assumption in hypothesis form is declared to the gate**","§ Assumptions")
b=f'''# Brief {JOB} — wave 10's fourth planning pass: the two measure rows stated over a carrier you design, and the link to the finite plane

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {PIDENT}
  role: wave 10's fourth planner — design the carrier for a random proper colouring on its canonical space, state the two rows the third pass designed and did not state (J45-SI-C and J45-SI-5) over the place-filter interface, close one step of the second on paper or send it to a deriver, and state the link from the norm-one Cayley graph to the finite plane as a row; `sorry` at each leaf, each statement read back against its row, a plan and a price per leaf, the inhabitants, and a handoff implementers can split by file
  launch: when a slot frees, in the wave's planning tree, which the coordinator has moved onto the commit where the wave's implementer merged `main`; that implementer proves the third pass's three leaves on its own branch at the same time
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for SI-5's step (d) if it does not close on paper (at once, as a question a deriver can take: the two σ-algebras, the formula, where it fails), a statement defect in a row (at once, with the entry's address and the line of the argument), a generalization or a shorter route, an outside theorem you would import, or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate: the inhabitant rule and the doubled-name check; § Assumptions; § Searching — Lean, last bullets), and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w10-kernel-plan.md` (on branch `{TREE}`; the three earlier passes' record — your stages continue its numbering from Stage 18, headed {JOB})
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `{TIP}`): **new modules only under `{A}`** (the carrier and the two rows; the link), with `Proofs.lean`, `ARCHITECTURE.md` and `scripts/Axioms.lean` (a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner) for them; `plans/FS131-w10-kernel-plan.md`, `tools/fs131_k10d_*.py`, `data/fs131/k10d/`, `data/fs131/reports/{JOB}.md`; **not** `{A}LevelGraph.lean` and `{A}UsablePlace.lean` (an implementer is proving them on a branch of its own), `{A}PlaceFilter.lean` and `{A}WeilKloosterman.lean` beyond new declarations, any landed module, `scripts/Assumptions.lean`, `main`, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 450k — read your token count at every saved stage

Hello. You are the fourth planner of wave 10 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones. Wave 10 is the arithmetic: the floors on the chromatic numbers of the finite targets a number field's primes
supply, and the measure-theoretic chain that carries them to a field's plane. It has landed twice — the floors rest on one outside
theorem, Weil's bound, and nothing else. Its third planner stated what it could, and designed the last two rows without stating them,
because their carrier is a modeling decision it did not have the budget to make well. It said so, and named the one step of the second
row it could not close on paper. Those are yours, with one row no pass has stated: the sentence the front page wants to say about "every
usable plane".

## Why this job

A result counts as held only when its Lean module passes the gate. The two rows are the last of the chain's measure half. And the link
decides what the project may say in public: the kernel's floors are about the norm-one Cayley graph of the field of `Q²` elements, and
"every usable finite plane refuses six colours from `Q = 98` on" is a kernel sentence only once an isomorphism of about 150 lines is
stated and proved; until then the ledger's row and the grokking owe a rewording, which is drafted and held. Kooshi, on pricing this work:

{KOOSHI}
What the earlier passes, the landing and the deriver handed back, and the rulings in force (read each item whole in the inventory,
`plans/FS131-close-inventory.md`; the first lines are quoted here as addresses):

{ITEMQ}The milestone's plan binds every wave's planning job (read its §§ 7.1–7.5 whole):

{Q(KP,"### 7.3 What each wave's planning job must hold")}
{Q(KP,"3. **States every row at the class its argument reads**")}
{Q(KP,"5. **Checks vacuity at the seam**")}
And since today the gate lists what the library assumes:

{ASSUME}
## The statements

**What the third pass left you, in its words** — the first lines of the paragraphs that are yours; read its record whole
(`/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/plans/FS131-w10-kernel-plan.md`, Stages 10–17):

{RECQ}
**The deriver's answer on SI-5's step (c)** — majority decoding, no pointwise ergodic theorem — which the second pass put in the kernel
at a wider class as `ae_eq_measurable_of_majority`:

{E8Q}
**The Lean you build over** (each head's first line; the interface is on your branch, the rest on `main` and in your tree):

{LQ}
## Done means

1. **Your readback first**: check every quotation above against its source; read the record whole, the wave's modules, and the plan's
   §§ 7.1–7.5. Your tree holds `main` as of the wave's second landing (the wave's implementer merged it): build it once as given — three
   `sorry` leaves, none yours. Register, before you design: whether step (d) closes on the canonical space, whether the carrier's
   `Equality` is better stated on the canonical space or on any system with a factor map, and how many leaves the two rows will have.
   Open your stages in the record with what you may and may not change. Commit and push.
2. **The carrier**, by `debruijn-domain-modeling` invoked fresh — the modeling decision of this wave still open, and the third pass's
   sketch is not elaborated: a random proper colouring on the canonical space with its shift, its factor at a filter, and the two
   predicates the rows read, each with a spec example and an inhabitant. **Before you state a helper, search the tree for its
   statement's shape, not for a name** (inventory items 584, 596).
3. **SI-5's step (d), on paper first** (`debruijn-obligation-modeling`, invoked fresh): the conditional law of `c(x)` given the
   extension's factor against the canonical factor — the third pass's own words on where it stopped are quoted above. If it closes,
   the statement's form follows; if it does not, **message me at once with the question as a deriver can take it**, state SI-5 over
   that one step as a named hypothesis of the row (never an axiom), and go on.
4. **The two rows, stated** — J45-SI-C and J45-SI-5 over `IsPlaceFilter` — each with `sorry` at its leaves, read back against its
   row and its *not claimed* line, and **`#check`ed, the kernel's statement compared with the file's** (inventory item 556: a section
   `variable` enters a theorem only if its statement mentions it; items 568, 592: twice a planner's binder did not match its row and
   the build could not see it). Weigh the third pass's sharper clause for SI-C (the uniform `1/28`): say which you state and why.
5. **The link, as a row** (ruling 555 (c)): `normOneCayley k σ ≃g unitQuadrance k₀` at `Q ≡ 3 (mod 4)`, and from it and
   `targetFloor_seven_weil` the sentence about `finitePlane p` for primes `p ≡ 3 (mod 4)`, `p ≥ 98` (and the floor at six from 62).
   About 150 lines by the third pass: if it is within about an hour, prove it and say so; otherwise a leaf with its plan. Either way
   draft the sentence the ledger's row 53 and the grokking may then say, and the sentence they must say until it is proved.
6. **Inhabitants and assumptions.** Every structure-valued hypothesis has a named Lean inhabitant or an owed one named (the third
   pass names a model for SI-5's hypotheses at once: build it with the statement or state it as a leaf). **And list, for the wave's
   next landing, every assumption in hypothesis form your statements take** — named or written out in a binder — each with its kind
   (an outside theorem, a hand result of ours, an open question) and source, in the form of `LEAN.md` § Assumptions. You declare
   nothing yourself and run no gate.
7. **The skeleton**: builds through the worktree's `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md`
   (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated; no new `axiom`, no `native_decide`; `./scripts/dupnames.sh`
   on your tree — no name declared by two modules.
8. **Your record**: a plan per leaf (route, the Mathlib and library lemmas confirmed with `#check`, what is hard, a price **in lines of
   Lean and in implementer jobs, never in days** — inventory item 541), and a handoff for implementers by file. A leaf you can prove
   in about an hour, prove, and say so. Then the report, in standing rule 11's form. You merge no branch, run no gate, and do not
   touch `main`. Leave no background process running, and keep what your record cites under `data/fs131/k10d/`. Stopping at a saved
   stage and saying what is left is a good report.

## What is yours to decide

The carrier and its layout; the form of each statement within what its row claims; whether SI-5 is stated on the canonical space or
over a factor map; which clause of SI-C is stated; whether the link is proved here or left a leaf; and the order after the readback.
Three minds planned what you stand on, and the third told you where it was least sure: if step (d) fails on paper, that is a finding,
and a deriver's question is the right outcome. Attack the rows: a statement true only at a narrower class than its entry says is what
this job is best placed to find. Three failed attempts on one route is a dispatch to the companion your identity names, never a
fourth. {NOSPAWN}

{MACHINE}'''
OUT=os.environ.get("OUT") if DRY else ROOT+"data/fs131/briefs/"+JOB+"-wave10-fourth.md"
open(OUT,"w").write(b)
print("written",JOB,"at tip",TIP,"| ready:",READY,"| dry:",DRY,"->",OUT)
