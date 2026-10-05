# Brief FS131-E6 — SHAVE's residual case (F6): can a lone horn, shaveable only at `σ = ±1`, occur where the terminal procedure meets it?

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-E6
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job
  role: derive one fixed question to a verdict — derived impossible in the setting where it would be met, realized (the configuration exhibited exactly), or possible with N4-TERM's route repaired (another move, a repaired procedure, or the smallest repair to `exists_terminal`) — and trace what the answer does to `exists_terminal`, `exists_terminalMap` and N4-TERM
  launch: now (inventory item 374 (b)), beside de Bruijn implementers on their own branches
  mission: § Why this job
  statements: § The question
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a realized configuration, a verdict an implementer can use at once, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-E6.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` § Make the gate fail, and watch it fail, before you build any check
  record: `plans/FS131-E6-derivation.md`
  touches: `plans/FS131-E6-derivation.md`, `tools/fs131_e6_*.py`, `data/fs131/e6/`, `data/fs131/reports/FS131-E6.md`
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. The Lean backlog (FS-131) is turning this project's hand-derived results into kernel-checked ones. Wave 5's last two leaves, `exists_red` and
`exists_terminal` (FS112-N2-RED, FS112-N2-TERM), now rest on one construction, `exists_terminalMap`: infinitely many local moves whose limit is a terminal valid
map. Planning it, FS131-KL1 found a case the filed hand proof does not cover: SHAVE (recolour a horn's tip by its two flanks) at a horn whose colour has a
single sector at the vertex, where the only admissible split is a unit circle (`σ = ±1`) strictly between the horn's two curvatures — every such shave
would create a unit arc, which a modification forbids. FS112-WALK's row 7 covers only splits inside `[−1, 1]`. No counterexample was built. Your question is
whether this case is real.

## Why this job

A result counts as held only when its Lean module passes the gate, and the kernel cannot check a step that has no hand proof. Every answer is a result: a
derivation lets the procedure's implementer proceed; a configuration is a counterexample to N4-TERM's route as filed, and `exists_terminal` must be re-read; a
repair changes a statement, and its consumers must be traced. Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is a
success."* (`plans/STANDING-RULES.md` rule 4). The finding and the rulings that launched you:

> - **F6 — a residual case of SHAVE (a question for the deriver; statement risk for `exists_terminalMap`).** `ShaveAvailable v` (wave 4's
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-limit-kernel-plan.md 3.4 Findings of this stage (to Keryx with the report)

> 373. **FS131-KL1 done: the limit constructions planned** (planner; stage 4 SAVED, harness ≈ 418k by the task notice; record `fs131-w5c`'s
> — source: plans/FS131-close-inventory.md

> 374. **Rulings on KL1's held items, and its slot.** (a) **The moves' new lemmas** are proved on wave 5's branch after it merges `main` (ruling 372 (a)): in a
> — source: plans/FS131-close-inventory.md

The related finding on N4-TERM's descent, ruled (the cleaning step `ArcMap.clean` the procedure now uses):

> 371. **FS131-KL1 (the limit planner), by message: N4-TERM's count does not descend over `main`'s SHAVE as built; a clean step is owed; `exists_red` has a shorter
> — source: plans/FS131-close-inventory.md

The filed rows:

> | N4-SHAVE | the horn tip can be recoloured by its flanks (valid, Condition 5, `Φ(v)` down by one) unless `σ_h < σ_g` with both inside the horn (doubly shadowed); `g = h` never blocks | [hand, one mind] | §2.2 |
> — source: plans/FS110-N-proof.md

> | N4-TERM | every valid map has a terminal valid modification (all vertices, whole plane; each point changed finitely often) | [hand, one mind] | §2.7 |
> — source: plans/FS110-N-proof.md

## The question

The claim list is `data/fs131/claims-E6.md`: `ShaveAvailable`, `exists_shave`, `IsModification` and `exists_terminal`, each copied by script, then the
question. Read it whole. The question:

> **Q — F6, SHAVE's residual case.** Can a valid map (in `exists_terminal`'s setting, or one reached from it by the moves W-MERGE, MERGE-RAY, SHAVE and the whole-arc bends) have a vertex `v` where `ShaveAvailable v` holds through a lone horn — its colour has a single sector at `v`, so `horn_bounds_of_noMerge` gives no curvature bound — whose only admissible split is `σ = ±1` with `κ₁ < σ < κ₂`, so that every shave there adds an arc of `ω(v ± n)` inside the horn, a unit arc `IsModification` forbids? Answer with a derivation that it cannot occur (in the setting where it would be met), a configuration exhibited exactly, or, if it can occur, what N4-TERM's route does there (another move, a repaired procedure, or a defect in `exists_terminal` as stated, with the smallest repair).
> — source: data/fs131/claims-E6.md § The question

*Not claimed*: anything about vertices where the horn's colour has two or more sectors (bounded by `horn_bounds_of_noMerge`), or about splits strictly inside `[−1, 1]` (FS112-WALK row 7).

## Done means

1. **Your readback first**: check the quotations above against their sources and the claim list's statements against theirs; restate the question in your
   record; read FS110-N-proof §§ 2.2 and the N4 rows (`plans/FS110-N-proof.md`), FS112-WALK row 7 and the walk's N4 stages at the addresses
   `plans/FS112-derivation.md` gives, KL1's plan §§ 2.4, 3.1 and 3.4 (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-limit-kernel-plan.md`), and `horn_bounds_of_noMerge` on `main`. Register your prediction before the
   written derivation.
2. **A verdict**, in your lane's derivation form (statement, uses only, not claimed, argument, verdict, grade, minds, model, prior art, handoff). A realized
   configuration is exhibited exactly — its tiles, its arcs, its colouring — and its validity and the setting's hypotheses checked by exact arithmetic or
   computer algebra with a control that goes red on a planted fault (no search; a step a search could decide is a `search request` in your report).
3. **The trace**: whether `exists_terminal`, `exists_terminalMap` (KL1's skeleton on `fs131-w5c`) and N4-TERM read the case; their fate; and any corrected
   statement drafted for me to file (its slot named), with the exact Lean-level change if a repair is needed — and, if the case is impossible, the derivation
   in a form an implementer can formalize as a child of `exists_vertexStep`.
4. Your record in stages headed "Stage n — SAVED", committed by explicit path; your derive gate (`.claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS131-E6-derivation.md`, from `plans/`) green; the report in standing rule 11's form. Stopping at a saved stage with the question open at a named
   step is a good report.

## What is yours to decide

The route, the form of any configuration, and the repair if one is needed. Attack the question itself: if the setting's hypotheses — `F.Valid`, the cleaning
step, terminality's other clauses, the order the procedure takes the moves in (MERGE before RAY, item 373's F7) — already exclude the case for a reason KL1
did not see, that is a finding; say so with the address. If the case is reachable only in maps the procedure never produces, say that too.

## The machine

No Lean builds are needed for this job; if you run a check that needs more than a few gigabytes, run it under the slot
(`/home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 4 -- <command>`, `RUNNING.md` § Building). You start no agents of your own (standing rule
1: delegation is one level deep, because the coordinator can only review work it knows exists).
