exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-E9: a deriver's job on the cluster three kernel jobs of wave 6 and wave 9 reached from three sides (ruling 576 (a)).
# Writes the claim list data/fs131/claims-E9.md (fixed before launch) and the brief. Re-runnable while unlaunched.
import subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
S="Proofs/HadwigerNelson/Plane/Saturated/"
WL=WT+"fs131-w6l/"; W6=WT+"fs131-w6/"; WK=WT+"fs131-w6k/"; WZ=WT+"fs131-w6z/"; W9=WT+"fs131-w9/"
PAR=WL+S+"Parallel.lean"; RI=W6+S+"ReduceI.lean"; ACC=WK+S+"Accumulation.lean"; CEN=WZ+S+"Centre.lean"
D111="plans/FS111-derivation.md"; KP6=W6+"plans/FS131-w6-kernel-plan.md"; RL=WL+"plans/FS131-I6L-implementation.md"
TIPS={n:sh("git","-C",ROOT,"rev-parse","--short=8","origin/"+n) for n in ["fs131-w6l","fs131-w6","fs131-w6k","fs131-w6z","fs131-w9"]}
INTRAD="\n".join([Q(D111,"derivation: FS111-M2-INTRAD"),Q(D111,"  statement: in an honest saturated colouring whose singular set Σ is locally finite with finitely many interface arcs"),
                  Q(D111,"  uses only: FS111-M-C11 off Σ; (i) the near side of the parallel"),Q(D111,"  not claimed: exclusion of large-radius accumulation")])+"\n"
REDI="\n".join([Q(D111,"derivation: FS111-M-REDUCE-I"),Q(D111,"  statement: REG-I_k follows from the honest existence form of C-SAT-T at k together with REG-J′_k"),
                Q(D111,"  not claimed: honest C-SAT-T at five; REG-J′₅;")])+"\n"
LQ1="\n".join([Q(PAR,"theorem curvature_integer_ae "),Q(PAR,"theorem radius_integer ")])+"\n"
LQ2="\n".join([Q(PAR,"theorem finite_pieces_of_radius "),Q(CEN,"theorem ends_centre "),Q(ACC,"theorem no_arc_of_cocompact ")])+"\n"
LQ3="\n".join([Q(RI,"def HasArcInterfaces "),Q(RI,"def ArcInterfacesOfRegJ "),Q(RI,"theorem reduce_i_of_arcInterfaces "),Q(RI,"theorem exists_arcMap_of_hasArcInterfaces "),
               Q(W9+"Proofs/HadwigerNelson/Plane/Reduction/Basic.lean","theorem exists_arcMap_of_arcBounded ")])+"\n"
PQ="\n".join([Q(KP6,"3. `curvature_integer_ae` (FS111-M2-INTRAD (i) along a general chart) has no kernel route yet"),Q(KP6,"## Stage 22 — SAVED: FS111-M-REDUCE-I"),
              Q(KP6,"**The entry's argument does not reach an arc map**")])+"\n"
IQ="\n".join([Q(RL,"## Stage 4 — SAVED (FS131-I6L): the two leaves left, and why they are a deriver's first"),Q(RL,"**(i), a route [hand, one mind, unformalized"),
              Q(RL,"1. *Types along the chart.*"),Q(RL,"2. *The inequality of the `j`-th parallel.*"),Q(RL,"3. *Where the chain dies.*"),Q(RL,"4. *Bookkeeping.*"),
              Q(RL,"**(iii).** Read, not worked."),Q(RL,"**A note on both statements** (no defect found)")])+"\n"
claims=f'''# FS131-E9 — the claim list: integer curvature along a general chart, finitely many pieces of each radius, and arc interfaces

*Fixed by Keryx, 2026-10-07 (UTC), before the job launches. Every statement below is copied by script from its source, first line as the
address; read each whole at its address. Branch tips at this writing: `origin/fs131-w6l` `{TIPS["fs131-w6l"]}`, `origin/fs131-w6`
`{TIPS["fs131-w6"]}`, `origin/fs131-w6k` `{TIPS["fs131-w6k"]}`, `origin/fs131-w6z` `{TIPS["fs131-w6z"]}`, `origin/fs131-w9` `{TIPS["fs131-w9"]}`. A later change to this file
is a dated line at its end.*

## The filed entries

{INTRAD}
{REDI}
## E9-Q1 — integer curvature along a general chart

The Lean leaf (open), and the case that is proved (a circular arc):

{LQ1}
**Q1.** For a unit-speed curve with 1-Lipschitz tangent angle in the interface of a saturated colouring whose singular set is locally
finite, of tangent type along its length: is its radius of curvature an integer at almost every parameter — by an argument that does
not presuppose the curve piecewise circular? Verdict: derived (a derivation whose every step an implementer can formalize, each step at
its grade), refuted (a saturated colouring exhibited exactly), or not derived, with the step where it stalls.

*Not claimed*: that the curve is piecewise circular; anything about how many pieces there are (that is Q2); anything without the
singular set locally finite.

## E9-Q2 — finitely many pieces of each radius

The Lean leaf (open), the theorem its filed argument passes through (proved, in a module downstream of the leaf's), and the theorem that
has since removed two of its readers:

{LQ2}
**Q2.** (a) Is there an argument for clause (iii) of FS111-M2-INTRAD — finitely many interface pieces of each radius near a point — that
does not pass through the finiteness of the terminal centres (FS121-O1-ENDS, the Lean `ends_centre`)? If not, say so: the leaf then
belongs after that theorem's module. (b) Which filed results still read clause (iii), now that under a cocompact symmetry no arc of
radius other than 1 lies in the interface's closure at all (`no_arc_of_cocompact`)? Verdict per part, as for Q1.

*Not claimed*: exclusion of large-radius accumulation; anything without REG-J′'s finitely-many-arcs clause.

## E9-Q3 — arc interfaces from saturation and a locally finite singular set

The named open statement (proved nowhere; a hypothesis where used), the theorem that takes it, and the two statements at the join of
waves 6 and 9:

{LQ3}
**Q3.** Does a saturated colouring with locally finite singular set have interfaces that are locally finitely many segments and
circular arcs (`ArcInterfacesOfRegJ k`)? Answer ingredient by ingredient: what follows from held entries (FS111-M2-INTRAD (i) and (iii),
at the verdicts of Q1 and Q2), and what stays open — the filed entry names large-radius accumulation as not claimed; the kernel's
planner adds locally finitely many straight pieces. The verdict wanted is the exact residue: the weakest named open statement or
statements that, with the held entries, give `ArcInterfacesOfRegJ k` — or a derivation of it, or a colouring that refutes it.

*Not claimed*: REG-J′ for any colouring; honest C-SAT-T at any `k`; any value of a chromatic number.
'''
open(ROOT+"data/fs131/claims-E9.md","w").write(claims)
CL="data/fs131/claims-E9.md"
CQ="\n".join([Q(CL,"**Q1.** For a unit-speed curve with 1-Lipschitz tangent angle"),Q(CL,"**Q2.** (a) Is there an argument for clause (iii)"),Q(CL,"**Q3.** Does a saturated colouring with locally finite singular set")])+"\n"
b=f'''# Brief FS131-E9 — three gaps under wave 6's ladder: integer curvature on a general chart, finitely many pieces, arc interfaces

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-E9
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job
  role: derive three fixed questions to a verdict each — derived (a derivation an implementer can formalize), refuted by an exhibited saturated colouring, or "not derived; stalls at" a named step — and say what each verdict does to the Lean leaves and the filed results that read it
  launch: when a slot frees, beside de Bruijn jobs on branches of their own; you write on `main`, to paths no other job writes
  mission: § Why this job
  statements: § The questions
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a refutation (at once: three implementer jobs are about to be cut on the line these leaves sit on), a derivation of Q1 an implementer can start from (when it is saved — it need not wait for Q2 and Q3), a defect in a filed entry, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-E9.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` § Make the gate fail, and watch it fail, before you build any check
  record: `plans/FS131-E9-derivation.md`
  touches: `plans/FS131-E9-derivation.md`, `data/fs131/e9/` (scripts and scratch here, not in `tools/`), `data/fs131/reports/FS131-E9.md`; **not** the claim list (`data/fs131/claims-E9.md` is the coordinator's: a statement you find wrong is a message), any derivation file of an earlier milestone (a correction owed is a draft in your record), any Lean file
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 450k — read your token count at every saved stage

Hello. The Lean backlog (FS-131) turns this project's hand-derived results into kernel-checked ones, and its sixth wave is the results on
saturated colourings — route M's regularity (`LEDGER.md` rows 139–144; `CLAUDE.md` § The aim, item 6): off a locally finite singular
set, the interfaces of a saturated colouring are segments and arcs of integer radius. Reading that sentence against Lean, three jobs
reached the same missing mathematics from three sides in one day: wave 9's planner, wave 6's fourth planner, and the implementer who
proved fifteen of the seventeen leaves of the module the sentence lives in and stopped at the other two, saying they were a deriver's
question before they were a fourth attempt. The three questions are yours.

## Why this job

Two kernel leaves have no route, and one named open statement sits under a row of the ledger. If each is derivable, an implementer has
its route and the ledger's row 154 keeps its sentence; if one is not, the front page owes an erratum — it is already drafted as "given
REG-J′₅ and that its interfaces are locally finitely many segments and circular arcs" — and the frontier's stubs on curved pencils and
lateral extent gain a named residue. Every one of those outcomes is a result: Kooshi, *"A proven theorem about why its impossible is also
valid. All novel knowledge is a success."* (`plans/STANDING-RULES.md` rule 4). A deriver's hour here is cheaper than two kernel jobs
spent finding out. What the three jobs found, and the rulings (read each item whole in the inventory, `plans/FS131-close-inventory.md`):

{item(576)}
{item(590)}
{item(566)}
{item(565)}
{item(533)}
## The questions

The claim list is `data/fs131/claims-E9.md`, fixed before this launch: read it whole — it holds the two filed entries, each Lean
statement at its address, and each question's *not claimed* line. The three questions, first lines:

{CQ}
**What the kernel's planners wrote about them** (wave 6's plan record, `{KP6}`):

{PQ}
**The implementer's route for Q1 and its note on Q2** — one mind, by hand, not formalized, written to be confirmed or replaced (its
record, `{RL}`; read its Stage 4 whole):

{IQ}
## Done means

1. **Your readback first**: check every quotation here and in the claim list against its source; read the filed argument
   (`plans/FS111-M2-regularity.md` § 4.1, with its verifier's record), the implementer's Stage 4, the planner's Stage 22 and § 15.4,
   and the Lean statements whole — the kernel's statement is the question's exact form, and where it differs from the filed entry say
   so. Restate the three questions in your record; register a prediction per question before deriving. Commit and push.
2. **A verdict per question**, in your lane's derivation form (statement, uses only, not claimed, argument, verdict, grade, minds,
   model, prior art, handoff), saving after each. **Q1 first**: the implementer's four steps are a candidate route — confirm each step,
   repair it, or replace the route; its step 4 (the null set of exceptional parameters) is the part with no counterpart in the filed
   argument. A derivation is written so that an implementer can formalize it: each step names what it reads and at what generality. A
   refuting colouring is exhibited exactly, its saturation and its singular set checked, with a control that fires on a planted
   fault; no search.
3. **The trace**: for each verdict, what becomes of the Lean leaf (`curvature_integer_ae`, `finite_pieces_of_radius` and where it
   should live, `ArcInterfacesOfRegJ`) and of each filed result that reads it — unchanged, true under a stronger hypothesis only, or
   needing a named residue; the drafted erratum sentence for `LEDGER.md` row 154 confirmed, sharpened or withdrawn; and one drafted
   bearing line each for `plans/STUB-curved-pencils.md` and the lateral-extent stub if a verdict moves them (I file them).
4. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed; your derive gate
   (`.claude/skills/ephodos/scripts/derive_gate.py all plans/FS131-E9-derivation.md`, from `plans/`) green; the report in standing
   rule 11's form. Stopping at a saved stage with one question answered and the others open at named steps is a good report.

## What is yours to decide

The route to each verdict and the form of any counterexample. Attack the questions: if the kernel's leaf asks more than its readers
need, say which hypothesis or conclusion is idle, because the weakest statement its readers share is what the kernel should carry —
that kind of finding has already removed two readers of Q2. If the implementer's route is wrong at a step, say so with the step; it
asked for exactly that. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can
only review work it knows exists).

## The machine

No Lean build is needed. A check that needs more than a few gigabytes runs under the slot
(`/home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 4 -- <command>`). `/tmp` is a tmpfs: keep what your record cites under
`data/fs131/e9/`.
'''
open(ROOT+"data/fs131/briefs/FS131-E9-wave6-gaps.md","w").write(b)
print("written claims-E9 and FS131-E9")
