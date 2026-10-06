# Brief FS131-K6d — wave 6's fourth planning pass: the landed half of the wave merged into its line, the fragment's six rows stated, the pinch's consequences on a cover, and the plan for the inhabitants the wave owes

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K6d
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: wave 6's fourth planner — first merge the landed half of the wave into its line and model the third pass's new definitions afresh; then read the arguments nobody in this milestone has read and state the six rows about a saturated fragment of an arc map, and the two consequences of the pinch for sets that may overlap, as new modules, `sorry` at each leaf, each statement read back against its row; state the facts the wave's example objects still owe; a plan and a price per leaf, and a handoff implementers can split by file
  launch: when a slot frees, in the tree the third pass (FS131-K6c) handed back; the wave's implementers prove the earlier passes' files on branches of their own, cut from commits of this branch
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect in a row (at once, with the entry's address and the line of the argument: it goes to a deriver — and say which kind you have: a *statement* that needs a hypothesis its entry lacks, or a *route* that reads more than the statement needs), a definition of the third pass that your modeling pass finds wrong (at once: three implementers are building on it), a change you find you need in a module that is fixed (below), a generalization or a shorter route, an outside theorem you would import, the hash of a module another wave reads, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K6d.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate: the inhabitant rule and the doubled-name check; § Searching — Lean, last bullet: two branches never state one lemma under one name), and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w6-kernel-plan.md` (on branch `fs131-w6`; the three passes' record — your stages from 16, headed FS131-K6d)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6` (branch `fs131-w6`, at `6fc27fa1`): the one merge this brief names, and no other; then **new modules only** under `Proofs/HadwigerNelson/Plane/Saturated/` (the plan names `Fragment`; the layout is yours), with `Proofs.lean` and `ARCHITECTURE.md` for them; `scripts/Axioms.lean` (a block of your own, headed "FS131-K6d", above the `=== PURCHASED ===` banner), `plans/FS131-w6-kernel-plan.md`, `tools/fs131_k6d_*.py`, `data/fs131/k6d/`, `data/fs131/reports/FS131-K6d.md`; **not** the wave's existing modules beyond what that merge brings (eighteen after the merge: implementers have proved them, are proving them, or are queued to, each on a branch cut from this one — a statement you need there is a message, a lemma you need beside them goes in a module of your own), any landed module beyond new declarations, `main`, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are finishing the plan of wave 6 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 6 is thirty-five rows about *saturated* colourings — classes carved by unit circles about
their own points. Three planning passes have stated twenty-nine of them, and two implementers have finished: the pinch at a two-colour
point is proved, and so is the map-colouring row, with the nine-colour square grid built as an arc map. Six rows are left, all about a
saturated *fragment* — an arc map on a disc — and no mind in this milestone has read their arguments. They are yours, with three smaller
things the earlier passes left.

## Why this job

A result counts as held only when its Lean module passes the gate. The six rows are the saturated-fragment results of the milestone that closed the local exclusion
(FS-116; `LEDGER.md` rows 145–148; `CLAUDE.md` § Where the problem stands, item 31), and they are the last of this wave to be read against
their arguments. The third planner registered that it expected four statement defects among its rows and found none that stood; it did not
reach these six, and one question about the first of them (whether "saturated on a disc" needs a hypothesis its statement lacks) is still
open. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the earlier passes and the implementers handed back, and the rulings in force (read each item whole in the inventory):

> 531. **FS131-K6c done at its Stage 15: wave 6's third planning pass — seventeen of the twenty-three rows left, and one clause of
> — source: plans/FS131-close-inventory.md

> 530. **FS131-I6B done: `sat_inP` proved (FS121-C1-SAT), at a wider class than filed, with its Lean model — the nine-colour grid as
> — source: plans/FS131-close-inventory.md

> 539. **FS131-I6C done: `Curve` and `LocalGraph` are proved — all eleven leaves, as stated; the local graph theorem of the
> — source: plans/FS131-close-inventory.md

> 540. **FS131-I6D done: the existence half of the bridge is proved — all seven leaves, as stated — so the deriver's theorem "a
> — source: plans/FS131-close-inventory.md

> 544. **FS131-I6E done: `FanBridge`'s five lemmas about any fan are proved, as stated — with the three cell lemmas of a fan as
> — source: plans/FS131-close-inventory.md

> 526. **FS131-K6c retracts item 522 (2): FS121-DB1-L7 stands as filed — "at every point off Σ", no REG-J′, no neighbourhood; the
> — source: plans/FS131-close-inventory.md

> 516. **FS131-I6A done: all seven leaves of wave 6's `Pinch` proved as stated — the pinch, its impossible case, the two tangent
> — source: plans/FS131-close-inventory.md

> 487. **Rulings on K6's held items, and two slots.** (a) FS121-D1-VT is declared under its own name as VT-W's `C¹` case (its merge condition
> — source: plans/FS131-close-inventory.md

> 533. **FS131-K9, by message mid-job: five findings from reading wave 9's eleven rows — no row refuted; a supporting lemma that
> — source: plans/FS131-close-inventory.md

The milestone's plan binds every wave's planning job (read its §§ 7.1–7.5 whole):

> ### 7.3 What each wave's planning job must hold
> — source: plans/FS131-kernel-plan.md

> 1. **Reads its rows' derivation entries in full** (the CSV gives each row's address in `plans/LEAN-BACKLOG.md`, which gives the derivation file's line),
> — source: plans/FS131-kernel-plan.md

> 3. **States every row at the class its argument reads** (G92), reports each widening to Keryx as a generalization, and reads each statement back in
> — source: plans/FS131-kernel-plan.md

> 5. **Checks vacuity at the seam**: a route lemma over a class the backlog proves empty (wave 8's V6 lemmas, ruling R4) carries
> — source: plans/FS131-kernel-plan.md

## The statements

The six rows, as the first pass disposed them from their entries (its record's § 2; read the table whole):

> | FS116-O1-SATPIN | `ArcMap k` fragment, `SaturatedAt` on a disc, no cusp at `p` | PINCH, C11 **in a local form** (§ 7.2 item 1) | — | T | second pass |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

> | FS116-N1-AXIS | `ArcMap k` (clause (d) at `k ≤ 6`: its not-claimed line) | wave 3 GERM-R, GERM-S; SATPIN | — | T | second pass |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

> | FS116-S1-RUNG | `ArcMap k`, saturated along a segment | SATPIN, wave 3 CLUSTER | — | T | second pass |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

> | FS116-V4-PARTNER | `ArcMap k`, `SaturatedAt x` at an interior point of a segment edge | wave 3 DICHOTOMY | — | T | second pass |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

> | FS116-S1-KAPPA | **`ArcMap 6`** ("the two colours absent at p" is `k = 6`; its not-claimed line: "anything at k ≥ 7"), without its last clause | wave 3 CHORD, DICHOTOMY, MEET, TWIST; V4-PARTNER | — | T | second pass |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

> | FS116-S1-PAIR | `ArcMap 6`, as KAPPA | KAPPA | — | T | second pass |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

What the third pass leaves, in its words (its record's §§ 14.4, 14.6, 15.3, 15.7; read Stages 13–15 whole):

> ### 15.3 What a fourth planning pass takes, exactly
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

> - **The fragment's six, none stated, no argument read**: FS116-O1-SATPIN, -N1-AXIS, -S1-RUNG, -V4-PARTNER, -S1-KAPPA, -S1-PAIR (the last
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

> - **FS111-M-C11 on a cover** (HULLC (v)'s second half): `c11_discs` and `local_graph` restated without `TwoColourOn.disj`. Not stated;
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

> - **FS111-W-NOBEND's own argument** (`plans/FS111-W-wild.md` § 2.2) is still unread; its merge into FS131-E8-LOCAL stands on its entry.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

> - **Owed inhabitants** (§ 14.6): `sq9.SingLocallyFinite`; R7 as a colouring with a fan; `sq9`'s periods; a chart for `sq9`.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

> ### 14.4 The modules, and each statement against its row (`data/fs131/k6/backlog-rows-w6.md`)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

> - **Owed, named in the docstrings**: `sq9.SingLocallyFinite` (the second pass's § 10.3) — the model of every theorem here that takes it;
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

> ### 15.7 After the map-colouring implementer's hand-back (the coordinator's message, FS131-I6B at `2e55a2d6` on `fs131-w6m`)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

> 2. **`ArcMap.bound_of_saturatedOn`** (the bound lemma on an open set, for a family) is read by no row of this pass; it is the fourth
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

The two things an implementer proved that these rows may read, on `origin/fs131-w6m` at `2e55a2d6` (they reach your branch by the merge
below, from `main`):

> theorem ArcMap.bound_of_saturatedOn (F : ArcMap k) {C : Fin k → Set ℂ} (hC : ∀ j, C j =ᵐ[volume] F.region j)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6m/Proofs/HadwigerNelson/Plane/Saturated/MapColouring.lean

> noncomputable def sq9Map : ArcMap 9 where
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6m/Proofs/HadwigerNelson/Plane/Saturated/Sq9Map.lean

A supporting lemma that moved to this wave today (ruling 533 (a)) — its entry, `plans/FS111-derivation.md` l. 617:

> derivation: FS111-M-REDUCE-I
> — source: plans/FS111-derivation.md

>   statement: REG-I_k follows from the honest existence form of C-SAT-T at k together with REG-J′_k (a saturated colouring whose singular set Σ is locally
> — source: plans/FS111-derivation.md

>   uses only: FS111-M-C11 off Σ; the finitely-many-arcs clause for S–V Condition 3 at Σ; FS111-M-EXTREME or V0-CLEAN's island fill for loops;
> — source: plans/FS111-derivation.md

>   not claimed: honest C-SAT-T at five; REG-J′₅; the statement without the finitely-many-arcs clause (the owner's brief dropped it; VMW's blind stage 1
> — source: plans/FS111-derivation.md

What your statement of it must meet — wave 9's hypothesis and the theorem that takes it, on `origin/fs131-w9` at `045fada3` (not on your
branch; the names are wave 9's own, and you declare none of them):

> def ExistenceForm (P : AeColouring k → Prop) : Prop := ∀ c : AeColouring k, c.Tight → ∃ c' : AeColouring k, P c'
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/Proofs/HadwigerNelson/Plane/Reduction/Maps.lean

> def ReduceToMap (P : AeColouring k → Prop) (RegJ : Prop) : Prop := ExistenceForm P → RegJ → RegA k
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/Proofs/HadwigerNelson/Plane/Reduction/Maps.lean

> theorem top5 {P : AeColouring 5 → Prop} {RegJ : Prop} (hRed : ReduceToMap P RegJ) (hJ : RegJ) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/Proofs/HadwigerNelson/Plane/Reduction/Maps.lean

> def RegA (k : ℕ) : Prop := (∃ c : AeColouring k, c.Tight) → ∃ F : ArcMap k, F.IsPlaneMap ∧ F.Valid
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/Proofs/HadwigerNelson/Plane/Reduction/Basic.lean

## Done means

1. **Your readback first**: check every quotation above against its source; read the three passes' record whole (Stages 1–15), the wave's
   modules, and the plan's §§ 7.1–7.5. Register, before reading the unread arguments: which of the six you expect to hide a statement
   defect, which pairs to be one theorem, and how many you will state. Open your stages in the record with what you may and may not change.
   Commit and push.
2. **Merge `origin/main` first** — the one merge this brief asks. The wave's first fourteen modules are landed there, proved, through
   the full gate (FS131-L6A; inventory items 544–545): `Pinch`, `MapColouring` with `MapEdge` and `Sq9Map`, `Curve`, `LocalGraph`, the
   whole of `FanBridge` with four new modules beside it. Your branch holds the first eight as the skeleton they were, unchanged since
   the second pass, so they come from `main` whole; `Proofs.lean`, `ARCHITECTURE.md` and `scripts/Axioms.lean` keep both sides (the
   third pass's four modules and their lines stay). After it: the build (the `sorry` count falls from 65 to the third pass's 34),
   `./scripts/dupnames.sh`, a statement check on the third pass's four modules (none may move), commit, push. A conflict in a Lean
   file, or a third-pass module that does not build against the landed statements, is a message to me with the call site, not an edit.
   **Send me the hash at once**: three implementers' unstarted branches are fast-forwarded to it, so that their proofs stand on proved
   leaves.
3. **A fresh domain-modeling pass over the third pass's new definitions** (`debruijn-domain-modeling`, invoked fresh; the definitions are
   listed in its § 14.4): that pass was not run there — its planner disclosed it, and was past its budget. Each definition against the
   arguments that read it, with its spec example. A definition you find wrong is a message to me at once and not an edit: three
   implementers hold those statements.
4. **The six rows**: each argument read in full (the third pass's § 15.3 names the records) before its row is stated; then stated over
   wave 3's fragment vocabulary and what this wave holds — `pinch_of_cover`, `ArcMap.bound_of_saturatedOn`, `partner_point`'s argument
   for a family — with `sorry` at its leaves, read back against its row. Rulings in force: FS116-S1-KAPPA and -S1-PAIR at `ArcMap 6`
   (487 (e)); if any of the six reads FS111-M2-HULLC's finite-perimeter conclusion, say so (ruling 531 (a) stated that row without it).
   The open expectation X5 (d) is settled or reported.
5. **The pinch's consequences on a cover**: `c11_discs` and `local_graph` for two sets that may overlap, in a module of yours, if their
   arguments allow. The implementer who proved `local_graph` (FS131-I6C, inventory item 539; `origin/fs131-w6c` at `d62406a2`, its record
   § 5.3) answers the question the third pass left: the proof reads disjointness at four places through two lemmas — the lens, existence
   on the normal segment, the sides, and the trichotomy of the neighbourhood — and the last three are false for overlapping sets as they
   stand. So `local_graph` on a cover is a different lemma, to be stated only if a row reads it; `c11_discs` on a cover follows from
   `pinch_of_cover` as the third pass says. And FS111-W-NOBEND's own argument, read, with its merge into FS131-E8-LOCAL confirmed or corrected.
6. **FS111-M-REDUCE-I** (ruling 533 (a)): the implication its entry states, read from its argument and stated over this wave's foundation
   (`SingLocallyFinite`, `RegJFan` for REG-J′; the rows its `uses only` names). Wave 9's planner has proved the composition that reads it
   (`top5`, quoted above) for an abstract predicate `P` and a bare proposition `RegJ`: state yours so that at the join it gives a term of
   `ReduceToMap P RegJ` at `k = 5` for your `P`. You cannot import wave 9's module, so write the conclusion out over landed names —
   `(∃ c : AeColouring 5, c.Tight) → ∃ F : ArcMap 5, F.IsPlaneMap ∧ F.Valid`. That planner's three notes, relayed as it wrote them: `P` is
   a predicate on a colouring (`AeColouring 5`), not on a family of classes, so "honest, saturated" is said of the colouring (through its
   classes if your foundation speaks of families); `RegJ` is one bare `Prop`, so if REG-J′₅ is meant of the colouring the existence form
   produces, put it inside `P` and take `RegJ := True`; and the conclusion is an arc map — segments and circular arcs — so the map
   M-REDUCE-I builds must have such interfaces, which FS111-M2-INTRAD's integer radii give under REG-J′, and with Jordan interfaces only
   it does not meet `RegA`. If this item is more than the pass holds, leave it stated as a named hypothesis with what a later pass reads.
7. **The inhabitants the wave owes**, stated as leaves with a plan each (the third pass's § 14.6): the colouring that pass calls R7, with a
   fan at a lattice point; `sq9`'s two periods; a chart and a two-branch fan for `sq9` at a regular point; and, for `sq9Map`, the facts
   no one has proved — `Valid` and `NonSiamese` first — which the fragment rows' inhabitant lines and wave 8's main refutation both need (ruling 530 (c): one map, declared once; wave 8's job will take your module by ancestry).
   `sq9.SingLocallyFinite` is another implementer's (FS131-I6D) and is not yours.
8. **Vacuity and inhabitants** for what you state, in `LEAN.md` § The gate's form: a named Lean inhabitant, an owed one named, or
   "satisfiability open" with the question and the object meeting the local hypotheses but one.
9. **The skeleton**: builds through the worktree's `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md`
   (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated; no new `axiom`, no `native_decide`; `./scripts/dupnames.sh`.
10. **Your record**: a plan per leaf (route, the Mathlib and library lemmas confirmed with `#check`, what is hard, a price **in lines of Lean
   and in implementer jobs, never in days** (inventory item 541: this milestone's planners' line counts have been right to within a factor of
   two and their day counts high by ten in jobs; one job proves about 1,300 lines) — re-priced from the first two leaves you prove; this wave's implementers have beaten the planners' prices by an order of magnitude on set-algebra
   leaves), the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), and a handoff for implementers by file. A leaf
   you can prove in about an hour, prove, and say so.
11. The report, in standing rule 11's form. You do not merge any other branch, run the gate, or touch `main`. Leave no background process
    running, and keep what your record cites under `data/fs131/k6d/`. If this is more than one pass holds: the merge, the modeling pass and
    the six rows first, the inhabitants after; stopping at a saved stage and saying exactly what is left is a good report.

## What is yours to decide

The modules and their layout, the form of each statement within what its row claims, which rows are one theorem and its corollary, what
is formalized and what is named as a hypothesis, the inhabitants' statements, and the order after the merge. Three minds planned what you
stand on and none read these six arguments: where the foundation does not carry what a row reads, say so by message before working
around it. Attack the rows: a statement true only at a narrower class than its entry says is the finding this job is best placed to make.
Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
