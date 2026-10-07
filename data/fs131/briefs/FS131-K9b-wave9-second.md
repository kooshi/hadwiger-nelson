# Brief FS131-K9b — wave 9's second planning pass: the long leaf split for implementers, and the wave's two joins

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K9b
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: wave 9's second planner, a short pass — put the wave's long leaf (`bendAny`, the bend on a fragment at any number of colours) through the obligation-modeling pass the first planner did not run, decide its hard child's route against the landed source, and state its children as `sorry` leaves in a split that fits implementers' budgets; retire a leaf that wave 8 has proved; make the join with wave 8 and plan the join with wave 6; list the wave's assumptions for its landing
  launch: when a slot frees, in the tree the first pass (FS131-K9) handed back; no implementer has started on `Classes/`, and an implementer may be at work on `Reduction/` on a branch of its own while you plan
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement of landed wave 5 you find you need a twin of (at once, with the statement: I rule where it lives), a defect in `bendAny`'s statement (at once — three proved theorems read its clauses), a statement you change at a join, a generalization or a shorter route, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K9b.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate: the inhabitant rule and the doubled-name check; § Assumptions; § Searching — Lean, last bullets), and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w9-kernel-plan.md` (on branch `fs131-w9`; the first pass's record — your stages continue its numbering from Stage 6, headed FS131-K9b)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9` (branch `fs131-w9`, at `50c0edc5`): `Proofs/HadwigerNelson/Plane/Classes/Bend.lean` and `Proofs/HadwigerNelson/Plane/Classes/QFree.lean` (new declarations and `sorry` children; an existing statement only as items 5 and 6 below say, or after a message), new modules under `Proofs/HadwigerNelson/Plane/Classes/`, with `Proofs.lean`, `ARCHITECTURE.md` and `scripts/Axioms.lean` (a block of your own, headed "FS131-K9b", above the `=== PURCHASED ===` banner) for them and for the merge; `plans/FS131-w9-kernel-plan.md`, `tools/fs131_k9b_*.py`, `data/fs131/k9b/`, `data/fs131/reports/FS131-K9b.md`; **not** anything under `Proofs/HadwigerNelson/Plane/Reduction/` (three of its leaves and a new models module are an implementer's, on a branch cut from `50c0edc5`), `Proofs/HadwigerNelson/Plane/SimpleOn.lean` and `Proofs/HadwigerNelson/Plane/RingCalculus/` (wave 8's), any landed module (a twin of a landed statement goes in a module of yours, never into the landed file), wave 6's tree, `main`, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 450k — read your token count at every saved stage

Hello. You are the second planner of wave 9 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5, wave 10 and half of wave 6 are on `main`, and wave 8 is landing as you start: a landing job is running the gate on its joined tree. Wave 9 is eleven rows: the reductions from a
measurable colouring to a map, and the bend on a fragment that carries the "no (Q) arc" results from the simple class to every class. Its
first planner stated all eleven and proved five; five leaves are left, and one of them — `bendAny` — is priced above what one implementer
holds and was decomposed from a reading alone. The planner said so plainly, and asked for exactly this pass.

## Why this job

A result counts as held only when its Lean module passes the gate. `bendAny` is the wave's weight: three theorems are already proved from
it and are not theorems until it is, among them the statement that in the class with no Siamese pair a four-colour vertex whose ring
carries no (Q) arc dies just past radius 1 (`LEDGER.md` row 149). Its fourth child bends *away* on a fragment of radius below 2, where
the landed away bend's hypothesis is false — the one place in this wave where a new geometric lemma, or a twin of a landed one, may be
owed. An implementer started on the leaf as it stands would meet that question at 300k tokens with no way to split the work; you meet it
first, with the landed source open. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the first pass handed back, what has happened since, and the rulings in force (read each item whole in the inventory,
`plans/FS131-close-inventory.md`; the first lines are quoted here as addresses):

> 533. **FS131-K9, by message mid-job: five findings from reading wave 9's eleven rows — no row refuted; a supporting lemma that
> — source: plans/FS131-close-inventory.md

> 536. **FS131-K9 done at its Stage 5: wave 9's first planning pass — all eleven rows disposed and stated, five proved; five
> — source: plans/FS131-close-inventory.md

> 566. **FS131-K6d done at its Stage 25: wave 6's fourth planning pass — the fragment's six rows stated with no statement defect, the cover's cell proved, and a gap in FS111-M-REDUCE-I now carried by a saved stage** (planner; harness 524k and 51 minutes by the task notice; record `fs131-w6`'s `plans/FS131-w6-kernel-plan.md` Stages 16–25; report `data/fs131/reports/FS131-K6d.md`; commits `59ce6b0c`, the merge `4ae5bd36`, `b79d4892`, `87e8968c`, `2aa3f720`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 593. **FS131-I8C, by message mid-job: nine of `SemiHub`'s seventeen leaves built and pushed (`1e605b60`), the other eight written and elaborating; a wave 9 leaf has a short proof there; helpers its sibling may want** (source: I8C's message to "main", 2026-10-06 — everything past `1e605b60` is "elaborated, not yet built", its words; the artifact is read at its hand-back).
> — source: plans/FS131-close-inventory.md

> 556. **FS131-I7A, by message mid-job: a defect of the skeleton — four leaves of route T's count are false as stated, because
> — source: plans/FS131-close-inventory.md

> 568. **FS131-K8b, by message mid-job (its Stage 6 saved at `5d4e4d12`; no Lean of its own yet): three answers from the arguments — `star_anti`'s gap is a defect of the skeleton's hypothesis; `doubleTip`'s extra hypotheses were a route's; FS116-V5-OUT2 is `star_outer_cone`** (source: K8b's message to "main", 2026-10-06).
> — source: plans/FS131-close-inventory.md

> 592. **FS131-I8D, by message mid-job: a statement defect — five statements of `SemiHubPlaces` read "exactly four colours at `p`" and were stated with "at least four", which is four only at six colours** (source: I8D's message to "main", 2026-10-06 — the artifact is read at its hand-back).
> — source: plans/FS131-close-inventory.md

The milestone's plan binds every wave's planning job (read its §§ 7.1–7.5 whole):

> ### 7.3 What each wave's planning job must hold
> — source: plans/FS131-kernel-plan.md

> 3. **States every row at the class its argument reads** (G92), reports each widening to Keryx as a generalization, and reads each statement back in
> — source: plans/FS131-kernel-plan.md

> 5. **Checks vacuity at the seam**: a route lemma over a class the backlog proves empty (wave 8's V6 lemmas, ruling R4) carries
> — source: plans/FS131-kernel-plan.md

And since today the gate lists what the library assumes:

> - **Every assumption in hypothesis form is declared to the gate**, in `AssumptionAudit.declared` at the end of
> — source: LEAN.md § Assumptions

## The statements

**What the first pass left you, in its words** — the first lines of the paragraphs that are yours; read its record whole
(`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/plans/FS131-w9-kernel-plan.md`):

> - **A second planning pass** is small: put `bendAny`'s decomposition through `debruijn-obligation-modeling`, decide B4's
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/plans/FS131-w9-kernel-plan.md

> - **Two implementers split by file.** *I9A*: `Plane/Classes/Bend` (`bendAny`: B1–B5) and `Plane/Classes/QFree`'s leaf D.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/plans/FS131-w9-kernel-plan.md

> - **At the join with wave 8**: `GammaFreeEmptyNS` is discharged by `fun F p hF hN hp h4 hΓ => emptyNS hF hN hp h4 hΓ`.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/plans/FS131-w9-kernel-plan.md

> **B. `bendAny`** (`Classes/Bend`) — the wave's long leaf. Route, with `ρ = min r √3` and `G = F.wholeRestrict p ρ`:
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/plans/FS131-w9-kernel-plan.md

> - B1. *`G` is `F` near the ring.* `G.Valid` (`Valid.wholeRestrict`), `G.Covers p ρ'` (`wholeRestrict_covers`), non-Siamese and
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/plans/FS131-w9-kernel-plan.md

> - B2. *Finitely many pieces.* The constant-sided arcs of `G` at `p` with a side colour absent at `p`, cut at the finitely many
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/plans/FS131-w9-kernel-plan.md

> - B3. *The toward bend* (outer colour absent): `bend_toward_collar`† as landed (no domain hypothesis). It gives a
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/plans/FS131-w9-kernel-plan.md

> - B4. *The away bend on a fragment* (inner colour absent) — **what is hard**. `bend_away_gap`† asks `radiusTwoArc ⊆ F.dom`,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/plans/FS131-w9-kernel-plan.md

> - B5. *The induction* over the pieces: valid; domain fixed; `h p = p` (`ε < 1`), so the colours at `p` stay; kept arcs survive
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/plans/FS131-w9-kernel-plan.md

> - **Price**: 400–700k tokens; B4 is half of it. Two implementer sittings, or B4 alone to one.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/plans/FS131-w9-kernel-plan.md

> **D. `not_hasRepeatedColour_of_simpleOn`** (`Classes/QFree`): two sectors of colour `c` at `y` lie in tiles of colour `c` with
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/plans/FS131-w9-kernel-plan.md

> **M. Models owed before the wave's gate** (`LEAN.md` § The gate's inhabitant rule), a new module `Plane/Reduction/Models`:
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/plans/FS131-w9-kernel-plan.md

> - **FS129-SR1-BENDANY** — row quoted in § Stage 2's source (`plans/FS129-derivation.md` l. 618). Lean: `bendAny`, clause by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/plans/FS131-w9-kernel-plan.md

> | `Row130Collapse` | `χ(ℝ²) = χ_m⁰(ℝ²)` (row 130, given MR); one half is N-EASY (`row130Collapse_iff`) | `six_le_chromaticNumber_of_regA`, `six_le_chromaticNumber_of_regJC` (wave 9) | FS-113 with FS-103's collapse |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/plans/FS131-w9-kernel-plan.md

> | `WEqKLimit K k` | FS107-W-EQ-K's `⟹` (`plans/FS107-derivation.md` l. 79; VW-CPT): `δ₀(K) = 0` gives a full a.e.-proper `k`-colouring by tiles of complexity at most `K` | `delta0_pos_of_mapNO`, `c1_pw` (wave 9) | a job of its own (stub to mint) |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/plans/FS131-w9-kernel-plan.md

> | `MapNO 6` (Q-NO) | row 134 with FS-114's NO, over arc maps | `c1_pw`, `seven_le_chiM0_of_mapNO_of_regA` | open: FS-116's successors |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/plans/FS131-w9-kernel-plan.md

> Inside the milestone, discharged at a join: `GammaFreeEmptyNS` (wave 8's `emptyNS`, one line); `ReduceToMap P RegJ` (wave 6's
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/plans/FS131-w9-kernel-plan.md


**Wave 9's statements this pass works on** (each head's first line; the whole statement is at its address):

> theorem bendAny (hF : F.Valid) {p : ℂ} {r : ℝ} (hp : F.Covers p r) (hr : 1 < r) {ρ' : ℝ} (h1 : 1 < ρ')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/Proofs/HadwigerNelson/Plane/Classes/Bend.lean

> theorem not_hasRepeatedColour_of_simpleOn {F : ArcMap k} (hF : F.Valid) (hN : F.NonSiamese) {y : ℂ} (hy : y ∈ F.dom)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/Proofs/HadwigerNelson/Plane/Classes/QFree.lean

> def GammaFreeEmptyNS : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/Proofs/HadwigerNelson/Plane/Classes/QFree.lean

> theorem qfreeNS (hE : GammaFreeEmptyNS) {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/Proofs/HadwigerNelson/Plane/Classes/QFree.lean

> def ReduceToMap (P : AeColouring k → Prop) (RegJ : Prop) : Prop := ExistenceForm P → RegJ → RegA k
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/Proofs/HadwigerNelson/Plane/Reduction/Maps.lean

> theorem top5 {P : AeColouring 5 → Prop} {RegJ : Prop} (hRed : ReduceToMap P RegJ) (hJ : RegJ) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/Proofs/HadwigerNelson/Plane/Reduction/Maps.lean

> theorem exists_arcMap_of_arcBounded {C : Fin k → Set ℂ} {𝒜 : Set Arc} (h𝒜 : IsArcSystem 𝒜) (hfr : ArcBounded 𝒜 C)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/Proofs/HadwigerNelson/Plane/Reduction/Basic.lean


**Two theorems wave 8 has proved** — the first is your leaf `not_hasRepeatedColour_of_simpleOn`, binder for binder but for names (compared
by me, by reading both); the second is what `GammaFreeEmptyNS` abbreviates:

> theorem simpleOn_not_hasRepeatedColour (hF : F.Valid) (hN : F.NonSiamese) {w : ℂ} (hw : w ∈ F.dom)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem emptyNS {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean


**Wave 6's statements at the other join** (on `origin/fs131-w6` at `2aa3f720`, a planning line with open leaves; not on your branch and
not to be merged into it):

> def HasArcInterfaces (c : AeColouring k) : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/Proofs/HadwigerNelson/Plane/Saturated/ReduceI.lean

> theorem exists_arcMap_of_hasArcInterfaces (c : AeColouring k) (h : c.HasArcInterfaces) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/Proofs/HadwigerNelson/Plane/Saturated/ReduceI.lean

> def ArcInterfacesOfRegJ (k : ℕ) : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/Proofs/HadwigerNelson/Plane/Saturated/ReduceI.lean

> theorem reduce_i_of_arcInterfaces (hJ : ArcInterfacesOfRegJ k)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/Proofs/HadwigerNelson/Plane/Saturated/ReduceI.lean


**The landed bends your record's B3 and B4 name** (wave 5, on `main`):

> structure CollarFitOut (F : ArcMap k) (P : ℂ) (θ₁ θ₂ : ℝ) (c c' : Fin k) (ε R' R R'' : ℝ) : Prop where
> — source: Proofs/HadwigerNelson/Plane/ValidMap/CollarMapOut.lean

> theorem exists_collarFitOut (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c') (hin : c ∉ F.coloursAt P)
> — source: Proofs/HadwigerNelson/Plane/ValidMap/BendGap.lean

> theorem bend_away_gap (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c') (hin : c ∉ F.coloursAt P)
> — source: Proofs/HadwigerNelson/Plane/ValidMap/BendGap.lean

> theorem bend_away_whole (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
> — source: Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean

> theorem bend_toward_collar (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
> — source: Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean

> theorem not_mem_closure_wholeRestrict_R₂ {p : ℂ} {ρ : ℝ} (hF : F.Valid) (hρ : ρ ≤ √3) {c : Fin k} {T : Set ℂ}
> — source: Proofs/HadwigerNelson/Plane/Tiles.lean


## Done means

1. **Your readback first**: check every quotation above against its source; read the record whole, the wave's five modules, and the
   plan's §§ 7.1–7.5. Register, before you read the landed bends' source: whether B4 will need a twin of a landed statement, how many
   children `bendAny` will have, and how many implementer jobs. Open your stages in the record with what you may and may not change.
   Commit and push.
2. **`main` is merged on my message.** Wave 8 — the ring calculus, with the two lemmas quoted above — is landing as you start.
   When it has landed I send you one message with `main`'s hash: at your next saved stage merge `origin/main` then (my trial of `origin/main` into `origin/fs131-w9` conflicts in `ARCHITECTURE.md`, `Proofs.lean` and `scripts/Axioms.lean` and nowhere else — registry files, adjacent lines, both sides kept; `Plane/SimpleOn` and `Plane/RingCalculus/Basic` are the same files on both sides, by ancestry);
   to spare a rebuild of everything `main` gained since your branch left it, copy a green build of `main`'s line over
   yours before you build — `cp -a /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8l/.lake/build/. /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/.lake/build/` — and only
   while no `lake` runs in that source tree (`pgrep -x lake`, then `readlink /proc/<pid>/cwd` for each); build; and tell me the hash. Items 5 and 6 below wait for that merge; items 3, 4 and 7 do not. Until then build the
   branch once as given (five `sorry` leaves).
3. **`bendAny` through `debruijn-obligation-modeling`** (invoked fresh) — the first pass's disclosed omission: its B1–B5 are from a
   reading. `#check` the leaf as stated and compare the kernel's statement with the file's (a section `variable` enters a theorem only
   if its statement mentions it: inventory items 556, 564), and read its binders against the row's *not claimed* line (items 568, 592:
   twice today a planner's hypothesis did not match its row, and the build could not see it). A defect is a message to me before you
   change anything: `bendLE3`, `exists_gammaFree_of_qFree` and `qfree_class` are proved from its clauses.
4. **B4's route, decided against the landed source.** Read `CollarFitOut`'s fields, `exists_collarFitOut`'s use of the domain, and
   `bend_away_whole`, with N2's route in `plans/FS129-SR1-audit.md` § 2.1. Either the collar away bend follows from the landed
   statements with `hR2` in place of the domain hypothesis, and your plan says how; or a twin of a landed statement is needed — then
   **message me at once with the twin's statement**, and state it in a module of yours as a `sorry` leaf (the landed file is not
   edited). A fit of that structure on a concrete map is being built at this moment by an implementer on another branch — a named
   `CollarFitOut` on `awayModel`'s gap; its record,
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wd2/plans/FS131-MD2-implementation.md`, shows how each field is met in
   practice, and bears on your model M4 too. It is not landed: read it, cite nothing from it.
5. **Leaf D is not proved again** (inventory item 593). Once `main` is merged, `not_hasRepeatedColour_of_simpleOn` is wave 8's
   `simpleOn_not_hasRepeatedColour`: close it by that citation, or remove the name and have its readers cite wave 8's — yours; say
   which in your record. Before the merge, leave it.
6. **The join with wave 8**, once `main` is merged: `GammaFreeEmptyNS` is discharged by `emptyNS` (check the two binder for binder as
   `emptyNS` stands today), and the hypothesis `hE` leaves `qfreeNS` and every statement that carried it — the gate's new step lists
   every named hypothesis a theorem takes, and one that is a theorem of the library is not an assumption. Each statement this changes
   is named in your record and your report.
7. **The join with wave 6, planned and not made** (rulings 533 (a), 566 (a)). You do **not** merge wave 6's line: it holds sixty-two
   open leaves, two of them a deriver's, and a merge would chain this wave's landing to all of them. Read `ReduceI` at its path and
   write in your record the exact declaration that will make `top5`'s instance — which `P`, which `RegJ`, and
   `reduce_i_of_arcInterfaces` over `ArcInterfacesOfRegJ 5` discharging `ReduceToMap` — to be made at whichever of the two landings
   comes second. And compare your proved `exists_arcMap_of_arcBounded` with wave 6's open leaf `exists_arcMap_of_hasArcInterfaces`: if
   the leaf follows from the theorem in a few lines, write the lines, so that wave 6's implementer cites it after this wave lands in
   place of proving it from nothing (one statement, one proof); if it does not, say what the leaf needs beyond it.
8. **The children, stated**: `bendAny`'s decomposition as `sorry` leaves beneath it, each `#check`ed, in a split that fits
   implementers — a job proves about 1,300 lines (inventory item 541) — with which jobs can run side by side and from which commit.
   **Before you state a helper, search the tree for its statement's shape, not for a name** (items 584, 596: today an implementer wrote
   two weaker copies of landed theorems, and three lemmas a plan called missing were in the library).
9. **Inhabitants and assumptions.** The five models M1–M5 are a condition of the wave's gate (ruling 536 (c)); for M4 and M5, which go
   with `bendAny`'s implementer, read the candidate's statement and say whether it is the model or what is missing. **And list, for the
   wave's landing, every assumption in hypothesis form that any statement of the wave takes** — `Row130Collapse` (declared on `main`
   already), `WEqKLimit`, `MapNO`, the binder `ReduceToMap P RegJ` of `top5`, and any other — each with its kind (an outside theorem, a
   hand result of ours, an open question) and source, in the form of `LEAN.md` § Assumptions: the landing declares from your list. You
   declare nothing yourself and run no gate.
10. **Both readings of "simple" land** (ruling 536 (b)): there is nothing to collapse, whatever the first pass's handoff says.
11. **The skeleton**: builds through the worktree's `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md`
   (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated; no new `axiom`, no `native_decide`; `./scripts/dupnames.sh`
   on your tree — no name declared by two modules.
12. **Your record**: a plan per child (route, the Mathlib and library lemmas confirmed with `#check`, what is hard, a price **in lines
   of Lean and in implementer jobs, never in days**), and a handoff for implementers by file. A child you can prove in about an hour,
   prove, and say so. Then the report, in standing rule 11's form. You run no gate and do not touch `main`. Leave no background
   process running, and keep what your record cites under `data/fs131/k9b/`. Stopping at a saved stage and saying what is left is a
   good report.

## What is yours to decide

B4's route; the children and their statements; the split into jobs; what happens to leaf D's name; the form of the two joins within the
rulings quoted; and the order after the readback. One mind planned what you stand on, and it flagged B4 as the place it was least sure of:
if the landed source shows the route does not go, say so with the line that decides it — that is the finding this pass exists to make,
and a deriver's question if it comes to that. Three failed attempts on one route is a dispatch to the companion your identity names,
never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
