# Brief FS132-K1 — the kernel module for the first night's results on six against seven: planned blind from the statements, then open

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), in the session Kooshi handed over. Launch line: "Your brief is on disk: read it in full first."*

brief: FS132-K1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow: blind first from the claim list, then open
  role: the kernel lane's planner for FS-132 — state in Lean seven statements claimed by hand last night, the first of them about every measurable six-colouring of the plane and read by no second mind; find your own route to each — or to its failure — before you see the derivers'; then, with the derivations open, give an implementer a skeleton and a plan per leaf, and say which statements of an outside Lean library are imported and which are ported
  launch: now, in a tree of your own cut from `main` after the outside theorems landed there; two other jobs work under `plans/` and `data/` on `main`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: § Fences
  channel: message the coordinator ("main") by SendMessage **when your phase-1 plan is committed** (the fence lifts by my reply, dated by that commit); **at once** for a statement defect (a statement that is false as written, vacuous, or not what its words say once typed), a generalization, a missing lemma, or a leaf you can already see is the hard one; and for a question you cannot work around; the report goes to `data/fs132/reports/FS132-K1.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS132-kernel-plan.md` (new, on branch `fs132-wk1`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wk1` (branch `fs132-wk1`, cut from `main` at `808ef9bf`): new modules of this milestone under `Proofs/HadwigerNelson/` (statements, definitions, and `sorry` at every leaf — nothing with a `sorry` reaches `main`), `Proofs.lean`, `ARCHITECTURE.md`; `plans/FS132-kernel-plan.md`, `data/fs132/k1/`, `data/fs132/reports/FS132-K1.md`; **not** the import module's two axioms or copied definitions, any landed statement, the claim list (`data/fs132/claims-K1.md` is the coordinator's: a statement you find wrong is a message), `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, the outside clone at `/home/kooshi/source/math` and the audit's working copy under `/home/kooshi/.cache/ext-oai1` (read; write nothing)
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 550k — read your token count at every saved stage

Hello. Four days ago an outside organisation published a Lean-formalized proof that the plane is not five-colourable, with a
transfer that makes the plane's chromatic number that of measurable colourings proper at almost every unit pair. Its two
theorems are now declared outside theorems of this library (`Proofs/HadwigerNelson/Outside/OAI158.lean`). So the whole problem is whether a measurable six-colouring
exists — and tonight three derivers produced this project's first statements about every such colouring. They are by hand, each
by one mind, a few hours old. You are the lane that turns them into something the kernel has checked, and you are the first
second mind any of them will have.

## Why this job

A milestone here closes only when its Lean module passes the gate; until then a result is "derived, one mind". The first
statement below is the one that matters most and is least checked: it claims that a configuration this project had excluded only
for maps is excluded for every measurable six-colouring, on one mind's hand argument that nobody has re-read. Your blind phase
is that second reading in the strongest form there is — a route found without seeing theirs. A statement defect found by you
tonight is worth more than the module. Kooshi's instruction for the night, and his standing word on what formalization is:

> > […] I'll hand the reins over to you […]. Keep us on track to 6 or 7. I suggest walking the standard workflow at this point once things settle into a clear direction. I'll go with whatever you recommend on the open questions with that in mind. Keep your handoff current in case of auto compaction.
> — source: data/external/EXT-OAI1-request.md

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

The kernel claim list is `data/fs132/claims-K1.md`: the statements and their not-claimed lines, copied by script, in the order you take them. Read
it whole. Their first lines:

> **C132-M-ORBIT** — statement: let U be an open set of the plane containing the closed unit disc about a point p, let c be a weak measurable six-colouring of U (a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair (z, u) of a point z of U and a unit vector u with z + u in U), let a_0, a_1, a_2, a_3 be four of the labels and X, Y the other two, and for each j modulo 4 let K_j be a compact set containing p and a point other than p with H_{a_j} ∩ Δ(K_j) = ∅ and H_{a_{j+1}} ∩ Δ(K_j) = ∅, where H_a is the closed essential support of the class of a and Δ(K) is the set of z with min over q ∈ K of |z − q| below 1 and max over q ∈ K of |z − q| above 1; then there are no angle ψ and number δ > 0 such that (i) for every integer k and almost every θ with |θ − ψ − kπ/3| < δ the palette P_p(e(θ)) (`[OAIMath2026]` Definition 5.1, read at the centre p with samplings inside U) contains X or Y, and (ii) for every η > 0 the set of θ in (ψ − η, ψ + η) whose palette contains X and the set of those whose palette contains Y both have positive measure
> — source: data/fs132/claims-K1.md

> **C132-M-EXCL** — statement: let U, p, c, the labels a_0, a_1, a_2, a_3, X, Y and the sets K_0, K_1, K_2, K_3 be as in C132-M-ORBIT; then it is not the case that for almost every unit vector e the palette P_p(e) contains X or Y
> — source: data/fs132/claims-K1.md

> **C132-DIAG-WIDE** — statement: let U be an open set of the plane containing the closed unit disc about a point p, c a weak measurable six-colouring of U, and D, D′ two disjoint pairs of labels; then there is no measurable map w from the unit circle to {D, D′} with w(e) ⊂ P_p(e) and w(Re) ≠ w(e) for almost every unit vector e, R the rotation by π/3
> — source: data/fs132/claims-K1.md

> **C132-CONFINE** — statement: let K be a compact connected set and H a set with H ∩ Δ(K) = ∅; then for every z ∈ H, either K ⊂ B̄(z, 1) or K ∩ B(z, 1) = ∅; in particular, if x ∈ K and z ∈ H with |z − x| < 1 then K ⊂ B̄(z, 1), and if x ∈ K, z ∈ H, |z − x| = 1 and (q_m) is a sequence in K ∖ {x} tending to x with (q_m − x)/|q_m − x| → v, then v·(z − x) ≥ 0 when K ⊂ B̄(z, 1) and v·(z − x) ≤ 0 when K ∩ B(z, 1) = ∅
> — source: data/fs132/claims-K1.md

> **C132-CORES-FREE** — statement: for every integer k ≥ 1 and every weak measurable k-colouring of the plane, every closed disc of radius greater than 1 contains a cyclic centre
> — source: data/fs132/claims-K1.md

> **C132-INDEX** — statement: Let a, b, c be three labels, Θ the union of the edges ab, bc, ca of the simplex of probability vectors, and φ a continuous map from the unit circle S to Θ such that for every e in S no label has a positive coordinate both at φ(e) and at φ(Re); then the degree of φ, for the orientation a → b → c of Θ, is congruent to 3 modulo 6
> — source: data/fs132/claims-K1.md

> **C132-RING-WIND** — statement: let N be a set of three labels, Π a measurable function from the unit circle S to the non-empty subsets of N with Π(e) ∩ Π(Re) = ∅ for almost every e, and J the set of the directions e having no arc about e on which Π is almost everywhere equal to one set; if J is finite and no two of its points are at angle π/3, then on each arc of S ∖ J the function Π is almost everywhere one singleton or one pair, two consecutive arcs carry subsets of one pair, and the closed walk they make around the triangle on N has winding number congruent to 3 modulo 6
> — source: data/fs132/claims-K1.md

*Not on your list, on purpose*: the release's extraction with its interface continua at every number of colours. A job running
tonight decides which form of it the road needs; it comes to this lane when that is answered.
**What they are stated over** (none of it fenced — read all of it):
- the import module, `Proofs/HadwigerNelson/Outside/OAI158.lean`: the release's definitions as this library holds them (`WeakColoring` and its companions, for the
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
output — any of: `plans/FS132-E1-derivation.md`, `plans/FS132-E2-derivation.md`, `plans/FS132-E3-derivation.md` (the three derivations), `plans/FS132-six-by-the-nerve.md` (the milestone's plan),
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
   - **your own route to each**, as a plan per leaf: what each leaf states, from what, in what order. For the first two this
     is the second derivation they have not had. Where you see no route, say where you stop. Where you see the statement is
     false, vacuous or wider than it need be, that is a message to me at once;
   - **the skeleton**: modules that build with `sorry` at every leaf, statements only.
   **Commit the phase-1 plan and message me.** That commit dates your blindness.
3. **Phase 2, open — after my reply.** Read the three derivations' entries for these statements with their arguments. For
   each statement: where your route and theirs part, which is the better route for an implementer and why, and a plan per
   leaf in final form. Any step of theirs you cannot make a leaf of is a message to me with the step's address; when
   the fence lifts I will name the steps their own authors flag.
4. **The outside statements.** Which statements of the release your plan stands on, by their Lean names, and for each: declared
   here as a further outside theorem in the import's form (definitions copied, stored terms compared, the four items), or
   ported to this toolchain — priced from the first two pieces you try (`LEAN.md`'s re-pricing rule), not from a table. The
   fifth statement of the list — a cyclic centre in every disc, at every number of colours — is the release's cover argument
   with the count removed: its Lean types much of that at five labels; say what of it is general already, what a port would
   be, and whether an implementer should start it or wait.
5. **The price**, re-read from the first two leaves you actually attempt: leaves per statement, which are finite checks, which
   are analysis, what an implementer starts with tomorrow.
6. **Your record**, stages headed "Stage n — SAVED (FS132-K1)", committed by explicit path and pushed on your branch; the
   report in standing rule 11's form. Stopping at a saved stage with phase 1 committed for the first three statements is a
   good report.

## What is yours to decide

The modules and their names, the form of each definition, the order inside each phase, how far the skeleton goes for the last
two statements, and every route. If a statement as written is not the right thing to formalize — a hypothesis that should be
a definition, a clause that is a consequence of the others, a class that should be wider — say so; the claim list is amended
by me from your message, after the deriver's lane has seen it. Do not soften a defect into a remark. Three failed attempts on
one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
