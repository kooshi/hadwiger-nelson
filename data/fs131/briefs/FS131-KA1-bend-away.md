# Brief FS131-KA1 — the outward collar bend planned: `bend_away_part` read back, laid out as named children, and priced, on `fs131-w5a`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KA1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: plan the one bend the arc step needs that is proved nowhere — attack its statement first (two points its author did not check), then lay `bend_away_part` out as named children with `sorry` at each over the collar machinery the toward bend was built on, read each back, a plan and a price per child, the obligation pass, its hypothesis set's inhabitant on a plane map, and a handoff that can split the work between two implementers; plan or prove the second open child `CollarFit.map_hornCount_le`; prove a child yourself where it is short
  launch: now, in the tree FS131-IA1 has handed back (`fs131-w5a` at `78eba0b4`), beside FS131-IR3 (the vertex step's cases, on `fs131-w5c`, which holds `Procedure.lean`) and FS131-E7 (a deriver, on `main`)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a clause of `bend_away_part` that is false or that the construction cannot meet (at once: the arc step's assembly reads this statement), a step with no hand derivation behind it (a deriver takes it), a piece of the collar machinery that is private where you need it, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-KA1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-bendaway-kernel-plan.md` (new, on branch `fs131-w5a`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a` (branch `fs131-w5a`, at `78eba0b4` when this brief was written): `Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean` (the two open children — `bend_away_part`'s proof from your children, `CollarFit.map_hornCount_le`; `bend_away_part`'s statement only after a message to me) and new modules upstream of it for the outward bend, with `Proofs.lean` and `ARCHITECTURE.md` for them; **new declarations only** in `RadialPush`, `CollarMap`, `Pushforward`, `BendCollar` and `UnitArc` (a named form that exposes a construction, or a `private` helper made public — no landed or proved statement or definition changed; ruling 421 (c)); `scripts/Axioms.lean` (a block of your own, headed "FS131-KA1", above the `=== PURCHASED ===` banner), `plans/FS131-bendaway-kernel-plan.md`, `tools/fs131_ka_*.py`, `data/fs131/ka/`, `data/fs131/reports/FS131-KA1.md`; **not** `Procedure.lean` (FS131-IR2 is proving the vertex step in it on `fs131-w5c`; the arc step's assembly there is a later job's), `Terminal.lean`, the move modules, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are planning the last construction on wave 5's path that nobody has laid out. The milestone, FS-131, turns this project's hand-derived
results into kernel-checked ones; waves 1–4, Woodall's chain, MERGE and OPEN are on `main`. Wave 5's termination procedure rests on two steps. The
vertex step is being proved now. The arc step bends a bad unit arc off its circle: toward the centre when the outer colour is absent there — that
bend, the collar bend, is proved, a homeomorphism of the plane that carries colours, degrees and horn counts — and away from the centre when the inner
colour is absent. The implementer who read the arc step against the library, FS131-IA1, found that neither of wave 4's away bends can serve: their
lens is a chord that cuts through whatever sits at the arc's ends, and they export no map the step can read. So the outward bend is needed in the
collar's form, and IA1 wrote its statement. You plan its proof.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and
`exists_terminalMap` — every valid map of the plane has a terminal valid modification — now waits on this bend more than on anything else. The toward
collar bend took a plan and two implementer sessions; this is its mirror with one new feature, the radius-2 contacts the bend must stop at. Kooshi, on
pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

The findings and rulings that launch you:

> 437. **FS131-IA1 done at its Stage 4: wave 5's two lines joined on `fs131-w5a`; question (5) proved; the arc step's toward half prepared; one bend
> — source: plans/FS131-close-inventory.md

> 438. **Rulings on IA1's held items, and its slot.** (a) **`CollarFit.map_hornCount_le` goes to the outward bend's planner, FS131-KA1** (ruling
> — source: plans/FS131-close-inventory.md

> 433. **FS131-IA1, by message: the arc step needs one bend that is proved nowhere, and its statement is fixed** (`bend_away_part`, `sorry`, in
> — source: plans/FS131-close-inventory.md

> 434. **Rulings on item 433.** (a) **`bend_away_part`'s planner takes the next freed slot, ahead of the models' planner FS131-KM1** — a `debruijn`
> — source: plans/FS131-close-inventory.md

> 429. **FS131-IA1, by message at its reading, before any proof: two clauses of `exists_arcStep` are false as stated** (source: IA1's message to "main",
> — source: plans/FS131-close-inventory.md

> 430. **Rulings on item 429** (sent to IA1 by message). (a) **D1**: the degree clause becomes `(∀ x ∈ T, ∀ m, F.HasDegree x m → ∃ m' ≤ m,
> — source: plans/FS131-close-inventory.md

and the ones the toward bend was built under:

> 416. **FS131-CC2 done: the collar bend is proved** (harness ≈ 514k by the task notice; record `fs131-w5k`'s `plans/FS131-collar-C-implementation.md`,
> — source: plans/FS131-close-inventory.md

> 419. **Rulings on LN1's held items; a correction to ruling 417 (b); the slot.** (a) **The three binders are removed** (two theorems become strictly stronger,
> — source: plans/FS131-close-inventory.md

> 427. **Rulings on QA4's list and the rule.** (a) **Before wave 5 lands, at its final sync** (one remedy pass, in the job that joins the branches, so no
> — source: plans/FS131-close-inventory.md

## The statements

The statement you plan to, as IA1 left it (`sorry`; read it whole with its docstring, which states the intended construction), and the second open
child:

> theorem bend_away_part (hF : F.Valid) (hP : F.IsPlaneMap) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean

> theorem CollarFit.map_hornCount_le (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {x : ℂ} {j : ℕ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean

The proved bend it mirrors — its clauses are the family `bend_away_part`'s are written in — and wave 4's whole-arc away bend, whose clearing argument
(`away_clear`) the docstring reuses:

> theorem bend_toward_collar (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean

> theorem bend_away_whole (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean

The hand derivations behind it: FS-112's two rows, and the end case derived for this milestone (read E5's Stage 4 whole — a lens tangent to the circle
at an isolated contact, with an exact curvature threshold):

> | N2-AWAY | `s_in ∉ P_cl(P)` and no `s_in` tile touching `R₂(α)` (ends included) ⟹ the whole arc bends away; the end vertex's only blocker is R2 at the end | hand, one mind | N2-3 |
> — source: plans/FS112-N-proof.md

> | N2-TAN | isolated R2 contacts (and ends of R2 sub-arcs) are cleared by a tangent bend; only R2 along an arc blocks (NB-ISO closed) | hand, one mind (NB's sketch completed); `TAN` exact | N2-3 |
> — source: plans/FS112-N-proof.md

> ## Stage 4 — SAVED: Q2 derived — `bend_away`'s end case goes through by a tangent start; the region beyond the end is never reached
> — source: plans/FS131-E5-derivation.md

IA1's reading, which chose this form (read its Stage 3 whole, and Stage 4 when it is there):

> ## Stage 3 — SAVED (FS131-IA1): the reading — `exists_arcStep` clause by clause against the bends
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/plans/FS131-arcstep-implementation.md

> ### 4.3 The assembly's work list — what `exists_arcStep`'s proof in `Procedure` still needs, clause by clause
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/plans/FS131-arcstep-implementation.md

Wave 4's `bend_away` — the same conclusion without the homeomorphism, left `sorry` — is on branch `fs131-w4ba` at `71cca146` (no worktree; read it with
`git show`), with the fragment `isoFrag`, the hand model with one isolated contact.

## Done means

1. **Your readback first**: check every quotation above against its source; read IA1's record (Stages 3 and 4) and the module `BendStep` whole (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean`); the toward
   bend's plan and implementation records on this branch (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/plans/FS131-collar-kernel-plan.md`,
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/plans/FS131-collar-C-implementation.md`) and its four modules (`RadialPush`, `CollarMap`,
   `Pushforward`, `BendCollar`); `plans/FS112-N-proof.md`'s stage N2-3; E5's Stage 4. Build the branch once as given. Restate in your record what you
   are planning and what you may change. Commit and push.
2. **The statement attacked**, before any skeleton, and written up as its own stage: (i) IA1 did not check R1 — no unit arc created, and the
   constant-sided unit arcs of `M` are `F`'s — **at an interior pinch point**, where two lenses meet tangentially at an isolated radius-2 contact
   inside the arc and unit arcs about other centres may pass through; (ii) whether the horn clause is wanted as the iff it is stated as, or in the
   arc step's `∃ j' ≤ j` form, which is all the assembly reads; (iii) every other clause against N2-AWAY, N2-TAN and E5's end case — the tangent lens
   at a contact end must lie between `ω(P)` and the unit circle about the contact, so its radius is above `1`: is every clause still true there?
   A clause that is false, or true only by a step with no hand derivation, is a message to me at once, with the configuration; a weaker statement
   that the assembly can still read (IA1's § 4.3 says what it reads) is yours to propose in the same message. **One weakening is pre-ruled**
   (inventory item 438 (b)): the horn clause may become the arc step's `∃ j' ≤ j` form without a round trip — say so in one line when you do it.
   A sibling job, FS131-IA2, will build the arc step's assembly over these clauses in a module of its own, so any other change to the clause
   family reaches me the moment you decide it.
3. **The skeleton**: `bend_away_part` reduced to named children with `sorry` at each, in new modules upstream of `BendStep`, building through the
   worktree's `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md` (`tools/check_architecture.py` exit 0) and
   `scripts/Axioms.lean` updated; no statement of a proved declaration changed (checked by script, with a plant that fires); no new `axiom`, no
   `native_decide`. Say which of the toward bend's children are reused as they stand, which generalize to both directions (and whether that is worth
   doing now or is a tidy move), and which are new.
4. **`CollarFit.map_hornCount_le`** (open at IA1's hand-back): a plan (it needs the bent map's chart at an end, which the degree's proof
   avoided), or its proof if it is short. The away bend needs the same fact, so plan the two together.
5. **Your record**, `plans/FS131-bendaway-kernel-plan.md`: a plan per child (route, the Mathlib and library lemmas confirmed with `#check`, what is
   hard, a price), the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), **the inhabitant** — a named Lean object, or its plan,
   satisfying every hypothesis of `bend_away_part` at once on a plane map, with a radius-2 contact so that the last clause is exercised (`LEAN.md`
   § The gate; ruling 419 (d)) — and a handoff for the implementers, with how two of them could split the work by file. A child you can prove in about
   an hour, prove, and say so.
6. The report, in standing rule 11's form. You do not edit `Procedure.lean`, merge another branch into this one, run the gate, or touch `main`. Leave
   no background process running, and keep what your record cites under `data/fs131/ka/`. Stopping at a saved stage with what is left named is a good
   report.

## What is yours to decide

The construction, the modules and their names, the children and their statements, and the order. IA1's intended construction (the docstring's: on
each gap between radius-2 contacts an outward radial push, its lens bounded by circles tangent to `ω(P)` at the gap's ends, the pushes composed) is one
mind's, at hand grade; if a different construction is shorter or reuses more of the toward bend, take it and say why. If the statement can be made
weaker and still serve the assembly, or must be made stronger to compose, propose it — you are closer to it than I am. Three failed attempts on one
route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
