# Brief FS131-K10b — wave 10's second planning pass: the four rows not yet stated, the finite-target floor as two rows, a majority-vote lemma in place of an ergodic theorem, and the first implementer's statements read back

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K10b
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: wave 10's second planner — state the rows the first pass left (J45-N1 (a)(b), J45-SI-J, J45-SI-5, J45-SI-C) with their foundation, `sorry` at each leaf, a plan and a price per leaf; plan the finite-target floor as two rows (one with no outside theorem, one over an imported bound, with the four items an import carries); state the deriver's majority-vote lemma under J45-SI-5; read back the five statements the first implementer added; plan a Lean model for the one named hypothesis that has none; and a handoff implementers can split by file
  launch: when a slot frees, in a tree of your own cut from the first implementer's tip, beside the wave's other two implementers (on `fs131-w10b` and `fs131-w10c`) and jobs of other waves
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect in a row or in one of the first implementer's five statements (at once, with the address), a gap in the deriver's lemma, an outside theorem you would import beyond the one ruled, a generalization or a shorter route, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K10b.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ Assumptions: the four items an imported theorem carries; § The gate: the inhabitant rule and the doubled-name check; § Searching — Lean, last bullet: two branches never state one lemma under one name), and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w10-kernel-plan.md` (on branch `fs131-w10k`; the first pass's record — your stages from 6, headed FS131-K10b)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k` (branch `fs131-w10k`, cut from `fs131-w10` at `ace98a35`): **new modules only** under `Proofs/HadwigerNelson/Arith/` (the layout is yours), with `Proofs.lean` and `ARCHITECTURE.md` for them; `scripts/Axioms.lean` (a block of your own, headed "FS131-K10b", above the `=== PURCHASED ===` banner; an imported theorem's record under the banner, as `LEAN.md` § Trust ledger says); `plans/FS131-w10-kernel-plan.md`, `tools/fs131_k10b_*.py`, `data/fs131/k10b/`, `data/fs131/reports/FS131-K10b.md`; `BIBLIOGRAPHY.md` is the coordinator's — a row you need is a draft in your report; **not** the wave's four existing files (`SpectralInputs` and `CharacterColouring` wait for the joining job; `StationaryRatio` and `StandingFive` are being proved on other branches — you import them, you do not edit them), any landed module beyond new declarations, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are finishing the plan of the arithmetic wave of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 10 is fourteen arithmetic rows — the character colouring, the spectral inputs under the
five-colour proof at `ℚ(√47)`, the stationary ratio, a degree-28 field. Its first planner stated eleven of them, proved four on the way, and found
two filed statements that hid a hypothesis. The first of three implementers has since proved every leaf of two of the four files. What is left to
plan is what the first pass had no room for, plus four things the work since has added.

## Why this job

A result counts as held only when its Lean module passes the gate. Two of the wave's rows lean on a hand result this project has never put in the
kernel — the *finite-target floor*, that certain finite graphs need seven colours — and one on a hypothesis with no Lean model yet; a step of a
third cited an ergodic theorem Mathlib does not have, and a deriver replaced it this morning with a majority vote. Each of those is the difference
between a row held and a row held over something unexamined. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the first pass, the first implementer and the deriver handed back, and the rulings in force (read each item whole in the inventory):

> 484. **FS131-K10 done at its Stage 5: wave 10 planned — dispositions for all fourteen rows, a foundation, a skeleton of eleven, four rows
> — source: plans/FS131-close-inventory.md

> 485. **Rulings on K10's held items, and its slot.** (a) **Three implementers by file, as it splits them**; the first, FS131-I10A
> — source: plans/FS131-close-inventory.md

> 493. **FS131-I10A done: all nine leaves of wave 10's first file pair proved — `SpectralInputs` and `CharacterColouring` hold no `sorry`, over
> — source: plans/FS131-close-inventory.md

> 494. **Rulings on I10A's held items, and its slot.** (a) **The two unread instance arguments are dropped from the statements** —
> — source: plans/FS131-close-inventory.md

> 491. **FS131-E8 done: nine entries derived, none stalled — the bridge (item 490, its §§ 3.1–3.7 unchanged since), the consumers traced row by
> — source: plans/FS131-close-inventory.md

> 492. **Rulings on E8's held items, and its slot.** (a) **REG-J′ and C121-REGJ keep their frozen words in the stubs' question sections and
> — source: plans/FS131-close-inventory.md

The milestone's plan binds every wave's planning job (read its §§ 7.1–7.5 whole):

> ### 7.3 What each wave's planning job must hold
> — source: plans/FS131-kernel-plan.md

> 3. **States every row at the class its argument reads** (G92), reports each widening to Keryx as a generalization, and reads each statement back in
> — source: plans/FS131-kernel-plan.md

> 4. **Names every hypothesis from outside the backlog** in the declaration's docstring and in § 7.4's list; never imports a hand result of ours as an
> — source: plans/FS131-kernel-plan.md

## The statements

The rows not stated, in the first pass's words (its record's § 3.3; read the section whole, and §§ 2, 3 and 5 for the foundation they stand on):

> ### 3.3 The rows not stated, and what stating them needs
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md

> - **J45-N1 (a), (b)**: the topology `τ′_S` on `R = unitRing F` as an infimum of three induced topologies — profinite (finite-order characters),
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md 3.3 The rows not stated, and what stating them needs

> - **J45-SI-J**: complex `L²`, spectral measures of vectors, the spectral measure of a tensor of independent factors as a convolution, and
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md 3.3 The rows not stated, and what stating them needs

> - **J45-SI-5**: SI-J, SI-3 (not a row), rotation by `U`, and the frequency argument "its colour has frequency ≥ 2/3" — as written it cites ergodic
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md 3.3 The rows not stated, and what stating them needs

> - **J45-SI-C**: SI-J with no `c₂`, and four finite facts about `γ = ⌊4(2x + 3y)/7⌋` on `Γ₇` (49 vertices, 392 directed edges): a `decide`,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md 3.3 The rows not stated, and what stating them needs

The floor, as the first pass priced it (its § 5.5; the hypothesis is `StandingFive.StandingFloor`, in the file `StandingFive`), and the ruling that
makes it two rows (item 485 (b), quoted above): the target at 128 with no outside theorem; the planes `Γ_Q`, `Q ≥ 347`, over Weil's bound,
imported — `BIBLIOGRAPHY.md` holds the keys `[Weil1948]`, `[MMST1996]` and `[Hoffman1970]`, and what each row says of how much was read:

> **What proving the floor in Lean would take** (Keryx's ask; a candidate row for a later wave). (i) `χ(U₁₂₈) ≥ 7`: Hoffman's ratio bound for a
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md

The deriver's lemma for J45-SI-5's step (c) — [hand], one mind, kernel pending — in its record on `main`
(`/home/kooshi/source/lean-dir/plans/FS131-E8-derivation.md`, § 5.1 and the entry under it; read both whole, with the entry's *not claimed*):

> derivation: FS131-E8-SI5C
> — source: plans/FS131-E8-derivation.md

>   handoff: de Bruijn — it replaces "ergodic averages along a tempered Følner sequence" in J45-SI-5 (c) for wave 10's second planning pass:
> — source: plans/FS131-E8-derivation.md

The first implementer's two findings that are yours (its record's § Findings, items 2 and 3; the five statements owed a read-back are named in
item 493, and stand in `SpectralInputs` on your branch):

> 2. **`sp_if`'s hypothesis `hcirc : I.NegCircle` has no model in the file.** The plan's § 5.5 prices one at `Interface.trivial` at "an hour"
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-I10A-implementation.md

> 3. **To apply `si4_equivariant` to `𝒜 = factorSigma`** one needs `(factorSigma T hT l).comap (T x) = factorSigma T hT l`.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-I10A-implementation.md

## Done means

1. **Your readback first**: check every quotation above against its source; read the first pass's record whole (Stages 1–5) and its report
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/data/fs131/reports/FS131-K10.md`), the first implementer's record and the two
   files it proved, the four rows' entries in `plans/LEAN-BACKLOG.md` and their derivation entries in full, with errata, and the plan's §§
   7.1–7.5. Register, before reading the derivations closely: which of the four rows you expect to hide a statement defect, and your price for
   each floor row. Build the branch once as given (twelve `sorry` leaves, in the two files that are other jobs'). Open your stages in the record
   with what you may and may not change. Commit and push.
2. **The read-back of the five statements** (`condExpL2_mem_contVec`, `condExpL2_eq_self_iff`, `inner_sub_condExpL2_eq_zero`, `si4_equivariant`,
   `condExp_comp_measurePreserving`): each against the sentence of its row it formalizes, in your record; and the lemma that applies
   `si4_equivariant` at the factor σ-algebra, stated at the class it holds (an action by bijections, by the implementer's finding). A statement
   that says less or more than its row is a message to me.
3. **The four rows**: for each, the disposition revised against its argument, the foundation it needs (sorry-free definitions, each with a spec
   example, each structure with a named inhabitant), the statement with `sorry` at its leaves read back against the row, a plan and a price per
   leaf. Under J45-SI-5, the deriver's lemma as a statement of its own at the class its entry gives, and step (c) over it; say whether Mathlib
   at the pin has the strong law in a form that serves or the Chebyshev route is written out (`#check`, not memory). J45-SI-C's four finite
   facts follow `LEAN.md` § The kernel's cost model.
4. **The floor, two rows**: (i) the target at 128 — the statement, the ratio bound it needs stated once at the class it holds (no Hoffman
   bound is in the library: say where it lives), the certified computation's shape and its cost by the kernel's cost model, leaves and prices;
   (ii) the planes — the statement for every `Q ≡ 3 (mod 4)`, `Q ≥ 347`, over Weil's bound as **one imported theorem with the four items of
   `LEAN.md` § Assumptions**: its Lean statement read back against the paper's own wording in your record (if our copy of the paper is not held,
   or the bound for these sums is in a different paper than the bibliography's row says, that is a prior-art debt in your report and the
   import waits — do not state an axiom from memory), a model of its hypotheses, the `ARCHITECTURE.md` § Trust line as a draft. Then
   `StandingFloor 7` from the two, so that `StandingFive`'s theorems lose that hypothesis at the join.
5. **A Lean model for `Interface.NegCircle`**: plan it, with the implementer's cheaper candidate checked (the point mass at the parity
   character over `ℚ`), and prove it if it is short; until it lands `sp_if` is an open gate item under the inhabitant rule.
6. **The skeleton**: builds through the worktree's `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md`
   (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated; no `native_decide`; no new `axiom` but the one ruled import, and
   that one only with its four items in place; `./scripts/dupnames.sh` on your tree — no name declared by two modules.
7. **Your record**: the plan per leaf (route, the Mathlib and library lemmas confirmed with `#check`, what is hard, a price — re-priced from the
   first two leaves you prove), the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), the inhabitants and vacuity lines,
   and a handoff saying how implementers split by file and what the joining job of the wave's branches must do (it also drops the two unread
   instance arguments, ruling 494 (a)). A leaf you can prove in about an hour, prove, and say so.
8. The report, in standing rule 11's form. You do not merge another branch into this one, run the gate, or touch `main`. Leave no background
   process running, and keep what your record cites under `data/fs131/k10b/`. The order of value, if this is more than one pass holds: item 2
   (it is short and the wave's landing needs it), item 4 (the floor is the wave's largest unexamined assumption), items 3 and 5. Stopping at a
   saved stage and saying exactly where a successor takes over is a good report.

## What is yours to decide

The modules and their layout, the foundation's definitions, the form of each statement within what its row claims, what is formalized and what
is named as a hypothesis, the shape of the certificate, and the order. The first pass's prices are one mind's, made before any of these rows was
stated; the deriver's lemma is one mind's, written this morning. Attack both: a row true only at a narrower class than its entry says, a step of
the majority vote that does not formalize as written, a floor whose Lean statement is not the hand result's — each is a message to me and a
finding. If you find the imported bound can be avoided for the planes that matter (a weaker bound that still gives seven from 347 on), or that
it cannot be stated without more than the bibliography holds, say so before stating it. Three failed attempts on one route is a dispatch to the
companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
