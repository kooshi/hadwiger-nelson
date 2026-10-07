exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS124-K1: the kernel lane's planner on FS-124's first module (the radius clause), blind first from data/fs124/claims-K1.md.
# Worktree fs124-wk1, cut from main (make it first, with the build recipe).
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
TREE="fs124-wk1"; W=WT+TREE+"/"; assert os.path.isdir(W),"make the worktree first"
BASE=sh("git","-C",W,"rev-parse","--short=8","HEAD")
CK="data/fs124/claims-K1.md"; RQ="data/external/EXT-OAI1-request.md"; M="Proofs/HadwigerNelson/Outside/OAI158.lean"
Y="Proofs/HadwigerNelson/Plane/YesLimit.lean"; A="Proofs/HadwigerNelson/Plane/AeColouring.lean"
os.makedirs(ROOT+"data/fs124/k1",exist_ok=True)
NAMES=["C124-RADIUS-GRAPH","C124-RADIUS-COUNTABLE","C124-RADIUS-UP","C124-RADIUS-DOWN","C124-RADIUS-FIVE"]
CLAIMS="\n".join(Q(CK,f"**{n}** — statement:") for n in NAMES)
OURS="\n".join([Q(A,"structure AeColouring "),Q(Y,"theorem AeColouring.exists_motion "),Q(Y,"theorem chromaticNumber_plane_le_chiM0 "),
                Q(M,"axiom no_proper_five_coloring :"),Q(M,"axiom proper_to_borel_weak ")])
IDENT_P="de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow: blind first from the claim list, then open"
b=f'''# Brief FS124-K1 — the kernel module for the radius clause: five statements about measurable colourings of an open set, planned blind from the statements, then open

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS124-K1
  identity: {IDENT_P}
  role: the kernel lane's planner for the first module of the milestone opened today — state in Lean five statements claimed by hand this afternoon about measurable colourings of an open set of the plane that are proper at almost every unit pair; find your own route to each, or to its failure, before you see the deriver's; then, with the derivation open, give an implementer a skeleton and a plan per leaf
  launch: now, in a tree of your own cut from `main`; a deriver works under `plans/` and `data/` on `main`, and implementers of another milestone work on branches of their own
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: § Fences
  channel: message the coordinator ("main") by SendMessage **when your phase-1 plan is committed** (the fence lifts by my reply, dated by that commit); **at once** for a statement defect (a statement that is false as written, vacuous, or not what its words say once typed), a generalization, a missing lemma, or a definition this library should share with other modules; and for a question you cannot work around; the report goes to `data/fs124/reports/FS124-K1.md` on your branch, and its text is your final message
  standing rules: {STAND}
  record: `plans/FS124-kernel-plan.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from `main` at `{BASE}`; its `.lake/build` is its own copy, made today): new modules of this milestone under `Proofs/HadwigerNelson/Plane/` (statements, definitions, and `sorry` at every leaf — nothing with a `sorry` reaches `main`), `Proofs.lean`, `ARCHITECTURE.md`; `plans/FS124-kernel-plan.md`, `data/fs124/k1/`, `data/fs124/reports/FS124-K1.md`; **not** the import module's two axioms or copied definitions, any statement on the main line, the claim lists (`{CK}` is the coordinator's: a statement you find wrong is a message), `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `main`, the outside clone at `/home/kooshi/source/math` (read it; write nothing into it)
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 450k — read your token count at every saved stage

Hello. The Hadwiger–Nelson problem — how many colours the plane needs so that no two points at distance 1 share one — stands
at six or seven since an outside proof of four days ago, and by that proof the plane's chromatic number is the least number of
colours in a measurable colouring proper at almost every unit pair. Both of its theorems are declared outside theorems of this
library. Today this project opened a milestone on what such a colouring is made of, and its first claim is about how the two
possible answers would be reached at all: through measurable colourings of *discs*. The claim is five short statements,
written by hand this afternoon by one mind. You are the lane that turns them into something the kernel has checked.

## Why this job

If these statements stand, the problem has a form with no infinite object in it: seven means one disc has no such
six-colouring; six means every disc has one. Every later result of the milestone — an exclusion on a disc, a six-coloured
fragment of any regularity — would be consumed through this module, so its statements must say exactly what they are cited
for, and the definition under them (a weak colouring of an open set) will be shared by other modules of this library. A
milestone here closes only when its Lean module passes the gate; until then a result is one mind's. Your blind phase is the
second look in its strongest form: a route found without seeing the first. Kooshi's word of this morning, and what he has
said of formalizing:

{Q(RQ,"> I agree with all 3.")}
{KOOSHI}
His last sentence binds you: what a planned statement rests on that this library does not hold is planned too — stated as a
leaf, or ported — and nothing becomes a new hypothesis or a new axiom without a message to me first.

## The statements

The kernel claim list is `{CK}`: the five statements and their not-claimed lines, copied by script, in the order you take
them, with the three terms they use. Read it whole. Their first lines:

{CLAIMS}
**What they are stated over** (none of it fenced — read all of it): this library's measurable colourings of the whole plane and
its theorem that such a colouring bounds the plane's chromatic number, and the import module with its two declared outside
theorems and the release's definitions as this library holds them:

{OURS}
Also open to you: every module on the main line (search the tree by the shape of a statement before you state a helper — Mathlib's and
this library's forms of the de Bruijn–Erdős theorem, of Haar measure on the plane's motions, of a null set under a
diffeomorphism), `LEAN.md`, and the release's Lean, read-only, under `/home/kooshi/source/math/lean/OAI/Geometry/PlaneColoring/`.

## Fences

**Until your phase-1 plan is committed and I have replied, do not read** — by file, by `git show`, `git log -p`, or search
output — any of: `plans/FS124-E1-derivation.md` and `plans/FS124-tight-pairs.md` (the deriver's record and plan),
`plans/FS124-close-inventory.md` (my receipts describe the route), `data/fs124/claims.md` (its dated lines do too),
`plans/STUB-q-ring.md` and `plans/POROS-2026-10-07-fs124-question.md` (the asking lane's card names what it expects each
statement to use), `plans/SESSION-HANDOFF-2026-10-07.md`, everything under `data/fs124/e1/`, `data/fs124/p1/`,
`data/fs124/reports/` and `data/fs124/briefs/` but this brief, and the commit bodies that touch those paths. The session
transcripts and the shared scratch directory are closed to you throughout. If you touch one by accident, say so in your record
with what you saw: a disclosed touch costs the second route for that statement and nothing else — the blindness serves
discovery and carries no grade. The kernel claim list, the import, the release and every module on the main line are open.

## Done means

1. **Your readback**: this brief's quotations against their sources; `LEAN.md` whole; the import module; the two modules of
   this library quoted above. Build your branch once as given, under the slot. Open your record. Commit and push.
2. **Phase 1, blind — the statements in Lean and your own routes.** In the list's order:
   - **the definition first**: a weak colouring of an open set — against the import's definition for the whole plane (it must
     be that definition at the whole plane, by a theorem, not by a remark) and against this library's own structure for the
     whole plane; **with a model**, so that no statement is empty by accident (the gate's inhabitant rule); and placed where
     other modules can import it. Say what a rigid motion is here and which measure "almost every rigid motion" refers to;
   - **each statement typed and read back aloud against its words**, clause by clause, with the *not claimed* line as the list
     of what your Lean statement must not say; for each, which declared outside theorem it rests on, if any;
   - **your own route to each**, as a plan per leaf: what each leaf states, from what, in what order. Where you see no route,
     say where you stop. Where a statement does not survive typing — untrue as written, vacuous, or narrower than it need be — that is a message to me at once;
   - **the skeleton**: modules that build with `sorry` at every leaf, statements only, under the slot.
   **Commit the phase-1 plan and message me.** That commit dates your blindness.
3. **Phase 2, open — after my reply.** Read the deriver's entries for these statements with their arguments. For each: where
   your route and theirs part, which is the better route for an implementer and why, and a plan per leaf in final form —
   each leaf with the Mathlib statements it will use, found by shape at this pin and `#check`ed, and its size.
4. **The price, from a leaf tried**: take one leaf of your choice through the kernel to measure the rate, and say what the module costs.
5. Your record in stages headed "Stage n — SAVED (FS124-K1)", committed by explicit path and pushed; no `axiom`, no
   `native_decide`; you merge nothing and nothing with a `sorry` reaches `main`. The report in standing rule 11's form.
   **Stopping at a saved stage with phase 1 committed is a good report** — say exactly where a successor takes over.

## What is yours to decide

The form of the definition and of each statement within what its words say; the module's name and place; your routes; the
order after the definition. The statements are one mind's, written this afternoon: a difference you find between a statement's
words and what can be typed is the most valuable thing this job can report. Three failed attempts on one route is a dispatch
to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs124/briefs/FS124-K1-kernel-plan.md","w").write(b)
print("written FS124-K1 base",BASE,len(b))
