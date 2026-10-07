# Brief FS124-I5 — three arcs from a point, each bordering exactly two of three regions: twenty leaves of a planner's skeleton, on `fs124-wk3`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS124-I5
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus
  role: the implementer of one module of plane topology — replace every `sorry` in a planner's skeleton with a proof, changing no statement — on which one clause of this milestone's nine statements rests
  launch: now, in the planner's own worktree — the planner has handed back and nobody else writes there; another implementer works in another worktree on the module's witnesses and holds a file you do not write; a record job works under `plans/` and `data/` on `main`; no landing is in flight
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a leaf that is false as stated, vacuous, or provable only with a hypothesis it lacks (say which: the *statement* needs it, or your *route* does); **with one line when the module's last theorem prints its axioms**; and for a question you cannot work around. The report goes to `data/fs124/reports/FS124-I5.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS124-I5-implementation.md` (new, on branch `fs124-wk3`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk3` (branch `fs124-wk3`, at `8cd74a6b`; its `.lake/build` is its own, built by the planner an hour ago): `Proofs/HadwigerNelson/Plane/ThreeArcs.lean` (proofs only; helpers under names no other module declares); `plans/FS124-I5-implementation.md`, `data/fs124/i5/`, `data/fs124/reports/FS124-I5.md`; **not** any statement or definition; **not** `Proofs/HadwigerNelson/Plane/SectorPoint.lean` — the other implementer holds it, and the two lines that close its leaf over your theorem are already written and checked (the planner's record § 3.1): they go in at the join, by another job; not the library's plane-topology module or any other proved module (a lemma they lack is a helper of yours); not `scripts/Axioms.lean`, `scripts/Assumptions.lean` (you draft your audit block as a file under `data/fs124/i5/`), `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `main`
  budget: about 300k by the harness's count, as guidance; you cannot read that count, so use this: **a saved stage after every five leaves; a leaf on which three attempts fail stays `sorry` with a note in your record, and you go on; if three leaves are so left, stop at the next saved stage and hand back**

Hello. Today this project stated and proved in Lean nine statements about measurable six-colourings of the plane. One clause
of one of them speaks of a point from which three arcs run to the rim of a small disc, cutting it into three regions, and
needs that every two of the regions share an initial part of one of the arcs. That is half of a classical fact about three
arcs in a disc. A planner found this afternoon that the other half — that there are exactly three regions — is already
assumed by the definition in use, and that the half that is owed follows from two lemmas this library holds: the plane's
unicoherence and the crossing of two continua in a disc. It stated the fact in a module of its own, proved twenty-one of its
forty-one theorems, and left a route for each of the other twenty. They are yours.

## Why this job

Kooshi's word of this morning is that what a module rests on is formalized in the milestone's own Lean phase, not declared:

> > I agree with all 3. let's keep the lean backlog paused. We move to the standard workflow, attacking 6/7. During the lean phase of the workflow, if any dependencies need to be formalized, have those done as well.
> — source: data/external/EXT-OAI1-request.md

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

I weighed the other way out — redefining the point so that no such fact is needed — against the planner's price, and ruled
that the fact is proved (read both items whole):

> 44. **FS124-K3, the price (18:49 UTC logged; its message at 18:48 UTC; branch `fs124-wk3`, tip `aa978778`; record `plans/FS124-kernel-plan-3.md`, Stages 1–3) — and my ruling: the θ-lemma is built.** "The three-arc leaf is about 500 to 600 lines of proof in all, 151 of them already through the build, and it needs no Jordan curve theorem and no port." **Why it is cheap, in its words**: "The classical theta-curve theorem has two halves: the cut disc has exactly three components, and each arc borders exactly two. `IsSector` as typed (and the claim list's own words: 'such that the three components ... are the pieces') ASSUMES the first half. Only the second is owed, and it follows from two lemmas this library already holds: unicoherence of the plane and the crossing lemma." **Its route**: a rim point off the far ends lies in one piece's closure; each rim arc borders one piece and the crossing lemma makes the three different; the closed disc is unicoherent, so the part of the three arcs inside one piece's closure is connected and holds two far ends, hence both arcs between them; one more use of the crossing lemma gives "exactly two". **What exists**: nothing here or in Mathlib at the pin; in the outside release a crosscut theorem for arbitrary arcs, "over the Jordan–Schoenflies theorem taken from a third party's package that is not on this machine — a module cone of 247 files, 24,695 lines, plus that package, at another Mathlib. I do not recommend a port." **Measured**: a new module `Plane/ThreeArcs`, 34 theorems stated, 17 proved in 151 lines (estimated at 235); the 17 left estimated at 545 on that scale, "so 350 to 450 at the measured ratio"; "No leaf I cannot price." The leaf itself is two lines over `IsTriodCut.exists_arc`, checked to elaborate. **The alternative, entry by entry** (its § 3.4): unchanged but for a word — C124-BOTH, C124-FORCED's first sentence, C124-SECOND, C124-EDGE-CLOSED, the model lines; **more than a word, two entries** — C124-FORCED's second sentence (it uses that off the arcs there is nothing but the pieces) and C136-PARTNERS (it reads the edge as one arc); "I wrote down two configurations of three pieces, arc-edged by the letter, where those two steps fail (a comb; an edge holding arcs of two circles). They are topology only, one mind". "MY READING: keep the list's definition and build the leaf." **Two statement notes, "neither a defect"**: the definition's sixth clause is implied by its seventh and the decomposition's fields; and C124-FORCED's `uses only` line "can cite a theorem proved here from two held lemmas, in place of 'the theta-curve form of the Jordan–Schoenflies theorem: recalled, not read' — once an implementer closes the 17". **My receipt**: the tip read on `origin`; the new module there holds 34 theorems and 17 `sorry` in 432 lines; against the implementers' tip the branch changes one file under `Proofs/`, the new one. Not checked by me: its route; its two counterexamples; its reading of the release. **Ruling** (sent to it): **keep the claim list's definition and prove the leaf.** Weighed: re-fixing "sector point" as the arc-edged point by a dated line (saving the 350 to 450 lines left). Why: the price is small and every leaf is priced; the alternative changes two hand entries by more than a word and gives up two "exactly" facts; and Kooshi's word is that what a module rests on is formalized. Confidence: high; a leaf of the 17 that will not go at several times its estimate would reopen it. **Kooshi was told the choice was coming and that he could weigh in; he is told the ruling and may reverse it.** **Credit, here**: the observation that the definition already assumes the hard half — in the claim list's words since this afternoon, read by three jobs and by me, drawn by none. **Then**: an implementer on `Plane/ThreeArcs` after its hand-back; the correction to C124-FORCED's `uses only` line is owed when the 17 are closed.
> — source: plans/FS124-close-inventory.md § Items

> 46. **FS124-K3 done (19:06 UTC logged; hand-back 19:05 UTC; 504k by the harness's count — not resumed): the θ-lemma is planned, half of its module already proved** (branch `fs124-wk3`, tip `8cd74a6b`; record `plans/FS124-kernel-plan-3.md` there, Stages 1–5; report `data/fs124/reports/FS124-K3.md` there). **Its words**: the leaf is "PLANNED, TRUE by a route by hand (one mind), not yet proved: a new module `Plane/ThreeArcs` states it as `IsTriodCut.exists_opposite` with 41 theorems, 21 proved [kernel, on a branch], 20 left at about 420 lines; the leaf itself is then two lines, checked to elaborate". **In the kernel on that branch, standard three axioms**: the closed disc is unicoherent; no preconnected set of the closed disc off two of three arcs reaches the rim on both sides of their far ends. "The statement as typed (`IsSector`, `HasArcEdges`) — no defect; neither vacuous nor stronger than its consumers need." **A generalization**: the statement holds for any three open preconnected pairwise disjoint sets filling the cut disc — the point in each closure and the pieces' nonemptiness "are conclusions, not hypotheses". **Corrections it lists**: C124-FORCED's `uses only` line, once the 20 are closed (draft in its § 4.5); **the module planner's sketch for this leaf "does not go as written, as I read it: its continuum ends at the arc's own far end, which interleaves with nothing it avoids"** — a sketch, never an entry; logged. **A question for the derive lane**: its two configurations, "arc-edged by the letter and not sector points (a comb under an arc; one edge holding arcs of two circles), topology only, one mind: does any weak colouring admit one? It bounds how far C124-FORCED's second sentence and C136-PARTNERS reach beyond sector points" — to the record job of the successor as a question for its stubs, not a job. **Prior-art debt**: the θ-curve lemma is cited in the hand record as recalled, not read; "the kernel route cites none". **Its slips, disclosed**: two stages in one commit; the pricing message after the stage it was due before; the skeleton grew after the price (34, then 41 theorems; 17, then 20 left; "350 to 450", then "about 420" lines) — "the ruling's ground is unchanged"; the pass on the surface not run. **Held for me**: only the θ-leaf of the sector module depends on this one (an import line and two lines, in its report); the model of the lemma's hypotheses is a leaf of the witnesses' job; the landing owes one spec example. **My receipt**: the tip read on `origin`; the module there holds 41 theorems and 20 `sorry` in 513 lines; against the implementers' tip the branch adds that file and one line each in the module list and the architecture file; the worktree is clean. Not checked by me: the route; the 21 proofs' axioms. **Ruling 44 stands** (the lemma is built). **Launched on this hand-back: FS124-I5**, an implementer on `Plane/ThreeArcs` in that worktree — the 20 leaves; it does not write the sector module, which the witnesses' job holds; the two lines that close the leaf go in at the join.
> — source: plans/FS124-close-inventory.md § Items

## The statements

**The skeleton**, in your worktree: `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk3/Proofs/HadwigerNelson/Plane/ThreeArcs.lean` — 41 theorems, 21 proved, 20 `sorry`. The two structures and the
two theorems the module is for (first lines; read each whole in its file, with its docstring):

> structure IsTriod (x : ℂ) (r : ℝ) (J : Fin 3 → C(unitInterval, ℂ)) : Prop where
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk3/Proofs/HadwigerNelson/Plane/ThreeArcs.lean

> structure IsTriodCut (x : ℂ) (r : ℝ) (J : Fin 3 → C(unitInterval, ℂ)) (P : Fin 3 → Set ℂ) : Prop
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk3/Proofs/HadwigerNelson/Plane/ThreeArcs.lean

> theorem exists_opposite (h : IsTriodCut x r J P) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk3/Proofs/HadwigerNelson/Plane/ThreeArcs.lean

> theorem exists_arc (h : IsTriodCut x r J P) {N : Set ℂ} (hN : N ∈ 𝓝 x) {i j : Fin 3} (hij : i ≠ j) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk3/Proofs/HadwigerNelson/Plane/ThreeArcs.lean

**The planner's record**, `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk3/plans/FS124-kernel-plan-3.md` — read it whole: Stage 2 (what exists, here and outside), § 3.1 (the statement and the
two lines that close the consumer's leaf), § 3.2 (the route), §§ 4.1–4.2 (its two passes, and what they changed), **§ 4.3
(the plan per leaf for the twenty, with the Mathlib and library names it checked under the module's own imports)**, § 4.4
(where you start), Stage 5 (the price in final form). Its first line on your start:

> 1. **Start**: `Proofs/HadwigerNelson/Plane/ThreeArcs.lean` on branch `fs124-wk3`: 41 theorems, 21 proved, 20 `sorry`,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk3/plans/FS124-kernel-plan-3.md § 4.4

**What the route stands on**, held by this library: `/home/kooshi/source/lean-dir/Proofs/HadwigerNelson/Plane/PlaneTopology.lean`
(unicoherence; two continua in a closed disc joining interleaved points of its circle meet; the frontier of a
complementary component of a closed preconnected set is preconnected) and the module yours imports.

## Done means

1. **Your readback first**: the quotations against their sources; the planner's record; the module whole and the
   statements it uses from the plane-topology module. Build the branch once as given, under the slot (it should end with
   26 `declaration uses sorry` warnings and no other). Open your record. Commit and push.
2. **The twenty leaves, in the order of § 4.3**, each by its route unless it fails — then yours, said in your record.
   **Before you prove a helper, search this library and Mathlib for its statement's shape, not for a name.** After every
   five leaves: build under the slot, commit by explicit path, push, a saved stage.
3. **Statements**: unchanged. An unused hypothesis is reported, not dropped; anything that must change is a message to me.
4. **When the last leaf is in**: the axioms of every theorem of the module printed (a scratch file under
   `data/fs124/i5/`, its output saved), with a control that fires; **message me the line of the module's last theorem**;
   check once more that the two lines of the planner's § 3.1 elaborate against your finished module (a scratch file — you
   do not edit the consumer's file); your audit block drafted as a file; `tools/check_architecture.py` exit 0;
   `./scripts/dupnames.sh`. You do not run the full gate, merge another branch, or touch `main`.
5. **Read aloud**, in your record: the module's two headline theorems against the sentence "each of three arcs from the
   centre of a disc to its rim borders exactly two of the three complementary regions, and every two regions share one" —
   and say which half of the classical fact the hypotheses assume.
6. **Your record**, in stages headed "Stage n — SAVED (FS124-I5)", with "Theorems this phase proved", the price as measured
   (leaves, lines, builds), every leaf left `sorry` by name with what was tried, and drafts for the landing (the audit
   block; the count of records; any line for `LEAN.md`). The report in standing rule 11's form. **Stopping at a saved
   stage with ten of the twenty proved is a good report** — say exactly which leaves are left.

## What is yours to decide

The route for a leaf whose planned route fails; the helpers; how you iterate. The planner's routes were checked for names
under the module's imports and twenty-one of them through the build; one earlier sketch of this proof, by another
planner, did not go as written — where a route does not go, change it and say so. Three failed attempts on one route is a
dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
