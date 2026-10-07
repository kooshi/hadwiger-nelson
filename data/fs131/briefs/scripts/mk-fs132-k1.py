exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS132-K1: the kernel lane's planner on FS-132's first derived statements, blind first. Run AFTER the import has landed on main
# (it asserts the import's module is on main) and after the worktree fs132-wk1 exists (cut from main). Writes the kernel claim
# list data/fs132/claims-K1.md (statements and not-claimed lines only, copied from the derivers' entries by script) and the brief.
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
M="Proofs/HadwigerNelson/Outside/OAI158.lean"
assert os.path.exists(ROOT+M),"run after the import has landed on main"
TREE="fs132-wk1"; L=WT+TREE+"/"
assert os.path.isdir(L),"make the worktree first: git -C ROOT worktree add -q -b fs132-wk1 .claude/worktrees/fs132-wk1 main (+ the build recipe)"
MAIN=sh("git","-C",ROOT,"rev-parse","--short=8","origin/main")
E1="plans/FS132-E1-derivation.md"; E2="plans/FS132-E2-derivation.md"; E3="plans/FS132-E3-derivation.md"
def entry(path,name):
    ls=open(ROOT+path).read().split("\n")
    k=[i for i,l in enumerate(ls) if l==f"derivation: {name}"]; assert len(k)==1,(name,len(k))
    st=nc=None
    for l in ls[k[0]+1:]:
        if not l.startswith("  "): break
        if l.startswith("  statement: "): st=l[len("  statement: "):]
        if l.startswith("  not claimed: "): nc=l[len("  not claimed: "):]
    assert st and nc,name
    return st,nc
ORDER=[(E3,"C132-M-ORBIT"),(E3,"C132-M-EXCL"),(E2,"C132-INDEX"),(E2,"C132-RING-WIND"),(E1,"C132-CONFINE"),(E1,"C132-CORES-FREE"),(E1,"C132-EXT-DISC")]
body=[]
for path,name in ORDER:
    st,nc=entry(path,name)
    body.append(f"**{name}** — statement: {st}\n\n*Not claimed ({name}):* {nc}\n")
CK="data/fs132/claims-K1.md"
open(ROOT+CK,"w").write('''# FS-132 — the kernel lane's claim list (FS132-K1)

*Fixed by Keryx, 2026-10-07 (UTC), for the kernel lane's planner: the statements and their not-claimed lines, copied by script
from the derivers' entries, and nothing else — no grade, no route, no model. Terms a statement uses and does not define are
those of `[OAIMath2026]` family 158 (its manuscript's Definitions 1.2, 5.1, 6.1; its Lean under
`lean/OAI/Geometry/PlaneColoring/` of the clone) and of the import module `Proofs/HadwigerNelson/Outside/OAI158.lean`. In the
order the planner takes them. A later change is a dated line at the end.*

'''+"\n".join(body))
Qs={name:Q(CK,f"**{name}** — statement:") for _,name in ORDER}
IDENT_P="de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow: blind first from the claim list, then open"
b=f'''# Brief FS132-K1 — the kernel module for the first night's results on six against seven: planned blind from the statements, then open

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), in the session Kooshi handed over. Launch line: "Your brief is on disk: read it in full first."*

brief: FS132-K1
  identity: {IDENT_P}
  role: the kernel lane's planner for FS-132 — state in Lean seven statements derived by hand tonight, the first of them a theorem about every measurable six-colouring of the plane that no second mind has read; find your own route to each before you see the derivers'; then, with the derivations open, give an implementer a skeleton and a plan per leaf, and say which statements of an outside Lean library are imported and which are ported
  launch: now, in a tree of your own cut from `main` after the outside theorems landed there; two other jobs work under `plans/` and `data/` on `main`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: § Fences
  channel: message the coordinator ("main") by SendMessage **when your phase-1 plan is committed** (the fence lifts by my reply, dated by that commit); **at once** for a statement defect (a statement that is false as written, vacuous, or not what its words say once typed), a generalization, a missing lemma, or a leaf you can already see is the hard one; and for a question you cannot work around; the report goes to `data/fs132/reports/FS132-K1.md` on your branch, and its text is your final message
  standing rules: {STAND}
  record: `plans/FS132-kernel-plan.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from `main` at `{MAIN}`): new modules of this milestone under `Proofs/HadwigerNelson/` (statements, definitions, and `sorry` at every leaf — nothing with a `sorry` reaches `main`), `Proofs.lean`, `ARCHITECTURE.md`; `plans/FS132-kernel-plan.md`, `data/fs132/k1/`, `data/fs132/reports/FS132-K1.md`; **not** the import module's two axioms or copied definitions, any landed statement, the claim list (`{CK}` is the coordinator's: a statement you find wrong is a message), `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, the outside clone at `/home/kooshi/source/math` and the audit's working copy under `/home/kooshi/.cache/ext-oai1` (read; write nothing)
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 550k — read your token count at every saved stage

Hello. Four days ago an outside organisation published a Lean-formalized proof that the plane is not five-colourable, with a
transfer that makes the plane's chromatic number that of measurable colourings proper at almost every unit pair. Its two
theorems are now declared outside theorems of this library (`{M}`). So the whole problem is whether a measurable six-colouring
exists — and tonight three derivers produced this project's first statements about every such colouring. They are by hand, each
by one mind, a few hours old. You are the lane that turns them into something the kernel has checked, and you are the first
second mind any of them will have.

## Why this job

A milestone here closes only when its Lean module passes the gate; until then a result is "derived, one mind". The first
statement below is the one that matters most and is least checked: it says a configuration this project had excluded only for
maps is excluded for every measurable six-colouring, and two steps of its hand proof have no second reader. Your blind phase
is that second reading in the strongest form there is — a route found without seeing theirs. A statement defect found by you
tonight is worth more than the module. Kooshi's instruction for the night, and his standing word on what formalization is:

{Q("data/external/EXT-OAI1-request.md","> […] I'll hand the reins over to you […].")}
{KOOSHI}
## The statements

The kernel claim list is `{CK}`: the statements and their not-claimed lines, copied by script, in the order you take them. Read
it whole. Their first lines:

{Qs["C132-M-ORBIT"]}
{Qs["C132-M-EXCL"]}
{Qs["C132-INDEX"]}
{Qs["C132-RING-WIND"]}
{Qs["C132-CONFINE"]}
{Qs["C132-CORES-FREE"]}
{Qs["C132-EXT-DISC"]}
**What they are stated over** (none of it fenced — read all of it):
- the import module, `{M}`: the release's definitions as this library holds them (`WeakColoring` and its companions, for the
  whole plane) and the dictionary to this library's own (`weakColoring_iff_unitPairsNull`);
- the release's Lean, read-only, under `/home/kooshi/source/math/lean/OAI/Geometry/PlaneColoring/` (its palettes, transition
  graph, straddle sets and extraction — at Lean v4.34.1, where this library is at v4.32.0) and its manuscript's section files
  under `/home/kooshi/source/math/preprints/The-Euclidean-plane-is-not-five-colorable-September-23-2026/build/sections/`, for
  the definitions the statements name by number; the audit's account of that Lean, `plans/EXT-OAI1-audit.md` stage 6, and of
  what it would cost to bring pieces of it here, its stage 8;
- the import's record, `plans/FS132-I1-implementation.md` and the landing's, `plans/FS132-L1-landing.md`: how a statement of
  the release is declared here as an outside theorem — the definitions copied, the stored terms compared across the two
  toolchains by `tools/fs132_i1_readback.py`, the four items of `LEAN.md` § Assumptions.

## Fences

**Until your phase-1 plan is committed and I have replied, do not read** — by file, by `git show`, `git log -p`, or search
output — any of: `{E1}`, `{E2}`, `{E3}` (the three derivations), `plans/FS132-six-by-the-nerve.md` (the milestone's plan),
`plans/FS132-close-inventory.md` and `plans/FS131-close-inventory.md` (my receipts describe the routes), `data/fs132/claims.md`
(its dated lines do too), `plans/POROS-2026-10-07-fs132-night.md`, `plans/SESSION-HANDOFF-2026-10-07.md`, everything under
`data/fs132/e1/`, `data/fs132/e2/`, `data/fs132/e3/`, `data/fs132/p2/`, `data/fs132/reports/` and `data/fs132/briefs/` but this
brief, and the commit bodies that touch those paths. The session transcripts and the shared scratch directory are closed to
you throughout. If you touch one by accident, say so in your record with what you saw: a disclosed touch costs the second
route for that statement and nothing else — the blindness serves discovery and carries no grade. The kernel claim list, the
import, the release and every landed module are open.

## Done means

1. **Your readback**: check this brief's quotations against the kernel claim list; read `LEAN.md` whole, the import module,
   and the release's definitions the statements name. Open your record. Commit and push.
2. **Phase 1, blind — the statements in Lean and your own routes.** In the list's order:
   - **the definitions first**: what each statement is over that this library does not yet hold — a weak measurable colouring
     of an *open set* (the import's is of the whole plane), the closed essential support of a class, the straddle set of a
     compact set, a palette at a centre — each against the release's own Lean definition where it has one (copied, as the
     import copied five, or re-stated: say which and why), each with a model so that no hypothesis is empty by accident;
   - **each statement typed and read back aloud against its words**, clause by clause — for the first, its two-clause
     hypothesis on the ring above all — with the *not claimed* line as the list of what your Lean statement must not say;
   - **your own route to each**, as a plan per leaf: what you would prove, from what, in what order. For the first two this
     is the second derivation they have not had. Where you see no route, say where you stop. Where you see the statement is
     false, vacuous or wider than it need be, that is a message to me at once;
   - **the skeleton**: modules that build with `sorry` at every leaf, statements only.
   **Commit the phase-1 plan and message me.** That commit dates your blindness.
3. **Phase 2, open — after my reply.** Read the three derivations' entries for these statements with their arguments. For
   each statement: where your route and theirs part, which is the better route for an implementer and why, and a plan per
   leaf in final form. Any step of theirs you cannot make a leaf of — the two in the first statement's argument that its
   deriver names as unread by a second mind, above all — is a message to me with the step's address.
4. **The outside statements.** Which statements of the release your plan stands on, by their Lean names, and for each: declared
   here as a further outside theorem in the import's form (definitions copied, stored terms compared, the four items), or
   ported to this toolchain — priced from the first two pieces you try (`LEAN.md`'s re-pricing rule), not from a table. The
   last two statements of the list are the release's extraction at every number of colours: its Lean types much of that at
   five labels; say what of it is general already, what a port would be, and whether an implementer should start it or wait.
5. **The price**, re-read from the first two leaves you actually attempt: leaves per statement, which are finite checks, which
   are analysis, what an implementer starts with tomorrow.
6. **Your record**, stages headed "Stage n — SAVED (FS132-K1)", committed by explicit path and pushed on your branch; the
   report in standing rule 11's form. Stopping at a saved stage with phase 1 committed for the first four statements is a
   good report.

## What is yours to decide

The modules and their names, the form of each definition, the order inside each phase, how far the skeleton goes for the last
two statements, and every route. If a statement as written is not the right thing to formalize — a hypothesis that should be
a definition, a clause that is a consequence of the others, a class that should be wider — say so; the claim list is amended
by me from your message, after the deriver's lane has seen it. Do not soften a defect into a remark. Three failed attempts on
one route is a dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs132/briefs/FS132-K1-kernel-plan.md","w").write(b)
print("written claims-K1 and FS132-K1 at main",MAIN,len(b))
