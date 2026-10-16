# Brief FS131-ICT1 — implement the three-colour skeleton: every `sorry` proved, the build, the gate on one commit and the drafts

*Written 2026-10-16 14:38 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-ICT1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the implementer of the modules a planner typed and planned (FS131-KTC1) — the three-colour criterion for Cayley graphs of abelian groups — three-colourable exactly when a character puts every step in the middle third of the circle, exactly when (for finitely generated groups) a periodic three-colouring exists — and the density of periodic three-colourings — every `sorry` replaced by a proof without changing a statement, then the full gate on one commit
  launch: now, in the planner's worktree and on its branch; beside you two other jobs (the collapse's implementer, which may be gating, and the implementer of the other skeleton planned this afternoon), neither of which writes a file you write
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be proved as typed (a statement defect goes back through me, never edited by you), for a generalization, and when the gate is green on one commit; the report goes to `data/fs131/reports/FS131-ICT1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-ICT1-three-colour.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/kel1`, on its branch `fs131-ktc1` (at `60e16a8c1`: the planner's last commit `29be81111` with `main` merged in, no Lean changed; `.lake/build` holds the built skeleton): `Proofs/HadwigerNelson/CayleyThree/` (`Circular`, `Fibre`, `Density`) — their proofs, and their statements only by my word; new helper modules you create, each named in your record; `Proofs.lean`; `ARCHITECTURE.md`'s rows for these modules; the gate's inputs (`scripts/Axioms.lean` and the rest) by the gate's own rules; `plans/FS131-ICT1-three-colour.md`; your scripts and logs under `data/fs131/ict1/`; `data/fs131/reports/FS131-ICT1.md`. Front-file edits (`LEDGER.md`, `CLAUDE.md`, `LEAN.md`, `ROADMAP.md`, `README.md`, `CLOSED-QUESTIONS.md`, `BIBLIOGRAPHY.md`) are drafted in your record, each naming its slot. Commit on your branch by explicit path; never push
  budget: about 450k by the harness's count, as guidance; save a stage after each module; hand back at a saved stage before about 550k, saying what is left — a successor continues from your record, and that is a good report

Hello. The planner who typed these modules handed back an hour ago with a plan per leaf and a skeleton that builds
green; you prove the leaves.

## Why this job

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

This row of the ledger (row 79) is a finding of ours held by hand; with this module it becomes a kernel theorem. My
rulings on the planner's open choices, from the inventory:

> 996. **FS131-KTC1's generalization, mid-job (logged 2026-10-16 13:50 UTC; by message; branch `fs131-ktc1` at `b9f1fcab0`, record `plans/FS131-KTC1-three-colour-plan.md` § 1.3 there).** Its readings, [hand, one mind each], wider than ledger row 79's class: (i) the character criterion — `Cay(A, S)` 3-colourable iff some `θ : A → ℝ/ℤ` has `θ(S) ⊆ [1/3, 2/3]` — for every abelian group and every `S` with `0 ∉ S`, the ⟹ being the kernel's `bandSet_three_nonempty_of_proper` and the ⟸ the colouring `x ↦ ⌊3{θ(x)}⌋`; (ii) the periodic form for `A` finitely generated and `S` finite, torsion, asymmetry and non-generating `S` allowed — finite generation necessary: `A = ℚ`, `S = {1}` is 3-colourable (`θ(x) = x/2`) and `ℚ` has no proper subgroup of finite index; (iii) density of periodic colourings with no torsion-freeness or symmetry (Dickson's lemma for a tight integer relation, residual finiteness for the period), `S` finite, generation removable by cosets. **My receipts:** the commit exists and its § 1.3 is there; by hand, the ⟸ step — a step `d` with `{θ(d)} ∈ [1/3, 2/3]` moves `3{θ(x)}` by an amount in `[1, 2]` modulo 3, so the floors differ modulo 3 — and the control at `ℚ` (`{x/2}` and `{(x+1)/2}` differ by `1/2`; a colouring periodic under `ℚ` is constant). **Ruling, four parts.** *Choice:* the head statements in the widest form the plan proves, with row 79's class as a named corollary so the ledger's statement is visibly an instance, the `ℚ` control stated as a theorem beside the periodic form, and what of the widening is in print recorded as a prior-art question in the record (circular colourings of abelian Cayley graphs are old; the ⟸ in particular), never as novelty. *Alternative weighed:* keep row 79's class and note the widening — declined: the kernel is the check, the wider proofs are no longer, and ruling 4 of item 988 took the same choice for the collapse. *Why:* the general statement is the one a reader cites. *Confidence:* high for (i) and (ii), medium for (iii); it would change if a density leaf turns out to need saturation — then that statement falls back to row 79's class and the record says so.
> — source: plans/FS131-close-inventory.md

> 1000. **FS131-KTC1 handed back: the three-colour criterion planned, its skeleton green (logged 2026-10-16 14:36 UTC; "JOB FS131-KTC1 — DONE"; about 455k by the harness's count — not to be resumed; branch `fs131-ktc1` at `29be81111`; record `plans/FS131-KTC1-three-colour-plan.md`, report `data/fs131/reports/FS131-KTC1.md`).** Three skeleton modules `CayleyThree/{Circular, Fibre, Density}`, 53 `sorry` leaves, about 2,230 lines (440, 1,020, 770), no axiom and no hypothesis of ours; head statements in the widest form (item 996): `CayleyThree.colorable_three_iff_bandSet_nonempty` (every abelian group, `0 ∉ S`), `colorable_three_iff_exists_isPeriodic` (`[AddGroup.FG A]`, `S` finite), `exists_isPeriodic_eqOn` and `coloring_mem_closure_isPeriodic` (density; `S` finite and generating), `periodicForcedSubgroup_three_eq_forcedSubgroup`, `inheritanceQuestion_three`, `forcedSubgroup_finiteIndex_iff_finite` (every `k`), `exists_affine_of_forall_three_nsmul`, the control `colorable_three_rat` with `not_isPeriodic_rat`, and row 79's class as two one-line corollaries. Its findings: Mathlib at the pin has no LP duality, so H-ii's step goes through Dickson's lemma (`Pi.wellQuasiOrderedLE`); `0 ∉ S` dropped from the periodic form and density; density without generation by a coset reduction (§ 3.5, about 150 lines, planned, not in the skeleton); the dichotomy's cell clause (§ 2.5, about 450 lines, a later module); the prior-art question (§ 3.6); front-page drafts (§ 3.8). It stopped its first build deliberately, by process group, before any of its modules compiled, and said so. **My receipts:** the five commits exist; `data/fs131/ktc1/build2.log` reads "build: OK — 1088 of 1088 batches, 4 module(s) rebuilt" with 53 `sorry` warnings; I read the statements at `Circular.lean` ll. 80–81, 100–101, 107, 113 and `Density.lean` ll. 105–106 and `IsPeriodic` (`Kempe.lean` l. 386: the periods form a subgroup of finite index) — as reported. Records, report and data copied onto `main`; the guard over the 13 files and the branch's messages: 0 refusals. **Ruling, four parts.** *Choice:* one implementer on the three modules in the plan's order (`Circular` first: alone it gives the periodic form, Ellenberg's question at `k = 3`), re-pricing at the plan's two marked leaves, handing back at its line for a successor; the coset reduction rides only if the re-price leaves room; the cell clause is a later module. *Alternative weighed:* land `Circular` alone first, then plan again — declined: the plan is per leaf already, and one gate for the three costs less than two. *Why:* the whole row reaches the kernel in one landing. *Confidence:* medium-high; it would change if the first two `Fibre` leaves re-price far above the plan, and then `Circular` lands alone. **Owed before the landing's novelty wording:** the prior-art search § 3.6 asks for, in two disciplines. **Announcement rule (item 995):** held only when its module passes the full gate on `main` and I have printed its axioms (expected: the standard three).
> — source: plans/FS131-close-inventory.md

**Item 1000's ruling, in practice:** the plan's order — `Circular` first (alone it gives the periodic form), then
`Fibre`, then `Density` — re-pricing at the two leaves the plan marks (`exists_le_mul_of_imp_eq_zero`,
`exists_slack_bound`) and writing the re-price into your record. If the re-price is far above the plan, say so by message:
`Circular` may then land alone. The coset reduction (plan § 3.5) rides only if the re-price leaves room; the dichotomy's
cell clause (§ 2.5) is a later module.

## The statements

The head statements as the skeleton types them on your branch (the plan names every other):

> /-- **The three-colour criterion, character form (FS73-T22), every abelian group and every set of steps.** -/
> theorem colorable_three_iff_bandSet_nonempty (hS : (0 : A) ∉ S) :
>     (addCayley S).Colorable 3 ↔ (bandSet S (band 3)).Nonempty := by
>   sorry
> 
> /-! ## §3 The periodic form -/
> 
> /-- **A character of finite order has a kernel of finite index**: its range lies in the finite `N`-torsion of `ℝ/ℤ`. -/
> theorem finiteIndex_ker_of_nsmul_eq_zero {θ : A →+ UnitAddCircle} {N : ℕ} (hN : N ≠ 0) (h : N • θ = 0) :
>     θ.ker.FiniteIndex := by
>   sorry
> 
> /-- **The band set over finitely many steps of a finitely generated group has a point of finite order** (FS73-T22's
> "rational vertex"; `plans/FS131-KTC1-three-colour-plan.md` § 2.1, R2). Route: lift `θ` on a generating family that lists `S`
> first, keep the box faces the lift lies on, `exists_rat_solution_near`, then `exists_character_of_box_point`. -/
> theorem exists_torsion_mem_bandSet [AddGroup.FG A] (hSfin : S.Finite) (h : (bandSet S (band 3)).Nonempty) :
>     ∃ θ ∈ bandSet S (band 3), ∃ N : ℕ, N ≠ 0 ∧ N • θ = 0 := by
>   sorry
> 
> /-- **The three-colour criterion, periodic form**: a finitely generated abelian group with finitely many steps. (`0 ∈ S` is
> harmless here: `addCayley (S \ {0}) = addCayley S`, `SimpleGraph.addCayley_erase_zero`.) -/
> theorem colorable_three_iff_exists_isPeriodic [AddGroup.FG A] (hSfin : S.Finite) :
>     (addCayley S).Colorable 3 ↔ ∃ C : (addCayley S).Coloring (Fin 3), IsPeriodic C := by
>   sorry
> 
> /-! ## §4 The control: finite generation is needed -/
> 
> /-- Over `ℚ` with the step `1` the Cayley graph is 3-colourable (the character `x ↦ x/2`). -/
> theorem colorable_three_rat : (addCayley ({1} : Set ℚ)).Colorable 3 := by
>   sorry
> 
> /-- **No 3-colouring of `addCayley {1}` over `ℚ` is periodic**: `ℚ` is divisible, so its only subgroup of finite index is
> `ℚ` itself, and a colouring with every period is constant. With `colorable_three_rat`, the periodic form fails without
> finite generation. -/
> theorem not_isPeriodic_rat (C : (addCayley ({1} : Set ℚ)).Coloring (Fin 3)) : ¬ IsPeriodic C := by
>   sorry
> 
> /-! ## §5 Row 79's class -/
> 
> /-- **Row 79, as an instance**: for a finitely generated torsion-free abelian group and a finite symmetric generating set
> of steps without `0`, three-colourable ⟺ a character puts every step in `[1/3, 2/3]` ⟺ periodically three-colourable. -/
> theorem colorable_three_iff_of_fg_torsionFree [AddGroup.FG A] [_htf : IsAddTorsionFree A] (hSfin : S.Finite) (_hsymm : -S = S)
>     (_hgen : AddSubgroup.closure S = ⊤) (hS : (0 : A) ∉ S) :
>     ((addCayley S).Colorable 3 ↔ (bandSet S (band 3)).Nonempty) ∧
>       ((addCayley S).Colorable 3 ↔ ∃ C : (addCayley S).Coloring (Fin 3), IsPeriodic C) :=
>   ⟨colorable_three_iff_bandSet_nonempty hS, colorable_three_iff_exists_isPeriodic hSfin⟩
> — source: Proofs/HadwigerNelson/CayleyThree/Circular.lean

> /-- **Periodic 3-colourings are dense** (row 79, FS73-T24): for an abelian group generated by a finite set of steps,
> every proper 3-colouring of `addCayley S` agrees on every finite set with a periodic one. -/
> theorem exists_isPeriodic_eqOn {S : Set A} (hSfin : S.Finite) (hgen : AddSubgroup.closure S = ⊤)
>     (C : (addCayley S).Coloring (Fin 3)) (B : Finset A) :
>     ∃ C' : (addCayley S).Coloring (Fin 3), IsPeriodic C' ∧ Set.EqOn (⇑C') (⇑C) (B : Set A) := by
>   sorry
> 
> /-- **Density, topological form**: in `A → Fin 3` with the product topology, every proper 3-colouring is a limit of
> periodic ones. -/
> theorem coloring_mem_closure_isPeriodic {S : Set A} (hSfin : S.Finite) (hgen : AddSubgroup.closure S = ⊤) (C : (addCayley S).Coloring (Fin 3)) :
>     (C : A → Fin 3) ∈ closure {f : A → Fin 3 | ∃ C' : (addCayley S).Coloring (Fin 3), IsPeriodic C' ∧ ⇑C' = f} := by
>   sorry
> — source: Proofs/HadwigerNelson/CayleyThree/Density.lean

The plan is `plans/FS131-KTC1-three-colour-plan.md` on your branch (also on `main`): its read-aloud of the head statements against ledger row 79, the
plan per leaf with routes, Mathlib names at the pin and line counts, the price, and its drafts for the front files. Its
report is `data/fs131/reports/FS131-KTC1.md`.

## Done means

1. **Stage 1 — the readback.** Check the quotations above against their sources; restate in your record the targets and
   the order of work; dump the skeleton's stored statements before your first proof, for the gate's comparison (the
   collapse job's method: `/home/kooshi/source/lean-dir/.claude/worktrees/kcl1/data/fs131/ico1/lean/StatementDump.lean`
   and `/home/kooshi/source/lean-dir/.claude/worktrees/kcl1/data/fs131/ico2/statements.py`, in that job's worktree; read
   them, never write there).
2. **The leaves**, in the plan's order, re-pricing from the first two leaves of each kind and writing the re-price into
   your record; a saved stage after each module.
3. **The build** through `./scripts/build.sh` under the slot, with no `sorry` in the landing's modules, and `lake lint`.
4. **Merge `main`**, then **the gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under
   `data/fs131/ict1/`, its logs pointed there), every count change explained against the last gate on `main` (at present
   `data/fs131/il5/gate/`, gated on `113ca8ece`; if the collapse lands on `main` before your gate, its gate is the
   baseline, and I will tell you), the statement comparison against your stage-1 dump, the vacuity scan's new sites with
   each structure hypothesis's inhabitant named (`LEAN.md` § The gate), and `#print axioms` of every head statement
   (expected: the standard three, on every head statement).
5. **The read-aloud** of each head statement against ledger row 79, in your record, with what is not claimed.
6. **The drafts** for the front files (the planner's, brought to what is proved), each naming its slot; novelty in the
   ledger's words ("prior art: not found in print" only where that is the finding).
7. **The report**, in the standing rules' form.

## What is yours to decide

Every proof, helper lemmas and their modules, the order within the plan's order, and whether a leaf is better proved
another way than the plan says — say so in your record. Not yours: any stored statement of the skeleton or of `main`
(message me with the defect and the form you need).

## The machine

The laptop: 12 cores, 31 GB, shared with two other jobs, one of which builds at 16 GiB until its gate is done. From inside
your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 5 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`
(or `--mem 4 --cpus 1 -- lake env lean …` for one file); never `lake build`. When the slot waits, another job holds the
memory; on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`)
is for iteration only, never evidence. The worktree's `.lake/build` is its own copy; never replace it with a symlink.
`/tmp` is a tmpfs: keep what your record cites under `data/fs131/ict1/`. Nothing with a `sorry` reaches `main`.
