# Brief FS131-KL1 — the limit constructions planned: the limit of a sequence of `ArcMap`s, the strengthened moves, and `exists_red`, `exists_terminal` laid out on `fs131-w5c`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KL1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: plan wave 5's two limit constructions — the limit of a sequence of `ArcMap`s and what passes to it, the strengthened moves `IsModification` needs (and where each must live), the counts' descent, and `exists_red`, `exists_terminal` reduced to named children with `sorry` at each, read back, a plan and a price per child, the obligation pass, the implementer's handoff; prove a child yourself where it is short
  launch: now, beside FS131-IMM4 (MERGE's last two clauses, on `fs131-w4mm`) and FS131-I5o (wave 5's non-`Terminal` lane, on `fs131-w5`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect (if `exists_red` or `exists_terminal` looks false as stated), a strengthened move that needs a change in a file outside wave 5 (`main`'s `Moves`, `fs131-w4mm`'s `MergeMove`), a piece of the literature you find used by statement, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-KL1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-limit-kernel-plan.md` (new, on branch `fs131-w5c`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` (branch `fs131-w5c`): a new module upstream of `Terminal` for the limit infrastructure (your layout), `Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean` (`exists_red`, `exists_terminal` and children beside them; no other statement); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-I5h", which you extend, above the `=== PURCHASED ===` banner), `plans/FS131-limit-kernel-plan.md`, `tools/fs131_kl_*.py`, `data/fs131/kl/`, `data/fs131/reports/FS131-KL1.md`; **not** `Contact` (its `exists_merge` is item 348's), wave 4's modules on this branch (stale copies — a change there would not land), `HexRing`, `Cor3`, `BaseWalk`, `Dense`, `MapGraph`, `BaseDense`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 480k — read your token count at every saved stage

Hello. You are planning the last two leaves of wave 5's `Terminal` half, in the Lean backlog. The milestone, FS-131, turns this project's hand-derived results
into kernel-checked ones; waves 1–4 and Woodall's chain are on `main`, and wave 5 (termination and density) is nearly proved on three branches. Every other
leaf of the `Terminal` half is now proved or proved over these two: `exists_red` (FS112-N2-RED: bend and merge the unit arcs until every one is (Q) or (R2))
and `exists_terminal` (FS112-N2-TERM: a terminal modification). Both are limit constructions — infinitely many local moves, each inside a small ball, whose
limit is again a valid map — and nothing in the repository yet takes the limit of a sequence of `ArcMap`s. FS131-I5p recommended a plan first.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and these two leaves
are on wave 5's path. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

The two leaves, `sorry` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean` at `ff6e917f` (read each whole there), their first lines:

> theorem exists_red (hF : F.Valid) (hP : F.IsPlaneMap) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean

> theorem exists_terminal {F : ArcMap 6} (hF : F.Valid) (hP : F.IsPlaneMap) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean

and the modification they conclude (read it whole in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Chain.lean`):

> structure IsModification (M : ArcMap k) : Prop where
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Chain.lean

Wave 5's plan for them — read §§ 4 and 9.1 in full:

> 2. `exists_red` — **H**. N2's count (`plans/FS112-N-proof.md` N2-3; NB2-RED): enumerate the unit arcs of `Γ` (countable: local finiteness on a plane
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-w5-kernel-plan.md Stage 4 — SAVED (partial): the plan per stated leaf; the obligation-modeling pass is owed

> 3. `exists_terminal` — **H, the wave's hardest leaf.** After `exists_red`, apply W-MERGE, MERGE-RAY, SHAVE (`exists_merge`, `exists_rayMerge`,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-w5-kernel-plan.md Stage 4 — SAVED (partial): the plan per stated leaf; the obligation-modeling pass is owed

> | `exists_red`, `exists_terminal` | derive | The measure is the locally finite count (N2-RED's arcs not (Q)/(R2); N4-TERM's `Φ`), descending per move inside a ball; the limit by local eventual constancy. Children as § 4 leaves 2–3. **Clause 3 needs the axis to propagate along a run** (below) |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-w5-kernel-plan.md 9.1 What the pass decided, statement by statement

What I5p handed back, and the rulings that launch you:

> **Left (2 in `Terminal`)**: **`exists_red`, `exists_terminal`** (H, the limit constructions; not started). They may cite `exists_merge` in ruling 269's
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-I5-implementation.md Stage 44 — SAVED (FS131-I5p): `y3_end_needs_of_not_mem` proved, so `y3_end_needs`, `cv_hd_main` and `cv_hd` are kernel theorems; the handover

> 361. **FS131-I5p handed back** (Stage 44 SAVED, harness ≈ 378k by the task notice; record `fs131-w5c`'s `plans/FS131-I5-implementation.md`, Stages 43–44; report
> — source: plans/FS131-close-inventory.md

> 362. **Ruling on I5p's slot: a planner for the limit constructions, FS131-KL1** (de Bruijn's planner, on `fs131-w5c`): the limit of a sequence of `ArcMap`s
> — source: plans/FS131-close-inventory.md

MERGE, which both leaves cite (only in ruling 269's form, now on this branch's `Contact`):

> 347. **FS131-I5l handed back** (Stage 38 SAVED, harness ≈ 381k by the task notice; record `fs131-w5c`'s `plans/FS131-I5-implementation.md`, Stages 35–38;
> — source: plans/FS131-close-inventory.md

> 348. **Ruling on item 347: MERGE returns to wave 5's path; its continuation takes I5l's slot.** (a) **`exists_red` and `exists_terminal` may cite W-MERGE —
> — source: plans/FS131-close-inventory.md

What wave 5's implementers may change:

> **It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-w5-kernel-plan.md ### 10.2 What the implementer may and may not change

## Done means

1. **Your readback first**: check every quotation above against its source; read the plan's §§ 4 and 9.1, I5n's and I5p's Stages 39–44, `IsModification` and
   the moves' statements (`exists_shave`, `exists_rayMerge`, `exists_merge` on this branch's `Contact`; `bend_toward`, `bend_away` on its `UnitArc` — stale
   copies, cite by statement); build the branch once as given (`ff6e917f`); restate in your record what you are planning and what you may change. Commit and
   push.
2. **The limit**: the definition of the limit of a sequence of `ArcMap`s that is locally eventually constant (arcs, colouring), what passes to it (validity,
   plane map, local finiteness, `IsModification`, `RingArcsWithin`), stated as named declarations, each read back; what Mathlib has, confirmed with `#check`.
3. **The strengthened moves**: what `IsModification` needs of each move (plan § 4 leaf 2: every point of `≥ 4` colours after a move had them before), whether
   it follows from each move's statement as given, and if not, the exact new children and the file each must live in (`main`'s `Moves`, `fs131-w4mm`'s
   `MergeMove`, `main`'s `UnitArc`) — a list for the coordinator, never an edit outside your touches.
4. **The skeleton**: `exists_red` and `exists_terminal` reduced to the limit's declarations, the counts' descent and the moves, `sorry` at every child, building
   through the worktree's `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md` (`tools/check_architecture.py` exit 0) and
   `scripts/Axioms.lean` updated. No statement of the two leaves changed; no new `axiom`, no `native_decide`.
5. **Your record**, `plans/FS131-limit-kernel-plan.md`: a plan per child (route, Mathlib lemmas confirmed, what is hard, a price), the obligation-modeling pass
   (`debruijn-obligation-modeling`, invoked fresh), inhabitants for any structure taken as a hypothesis, and a handoff for the implementer — with whether two
   implementers could split the work by file. A child you can prove in about an hour, prove, and say so.
6. The report, in standing rule 11's form. You do not merge into `fs131-w5`, take `main` into this branch, run the gate, or touch `main`. Stopping at a saved
   stage with what is left named is a good report.

## What is yours to decide

The limit's definition and layout, the cut into children, their names, and where the infrastructure lives within your touches. Formalize any outside fact
under about an hour of agent work; else an `axiom` with `LEAN.md` § Assumptions' four items — never one of our own hand results. If `exists_red` or
`exists_terminal` is false as stated, or the hand derivation's count does not descend as the plan says, that is a finding: message me at once with the
smallest counterexample. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows
exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.
