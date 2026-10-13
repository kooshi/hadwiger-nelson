# Brief FS131-KC1 — the chromatic number of the plane equals its measurable chromatic number: a short lemma from a paper of last week, composed with a theorem the library already imports — statements typed, a skeleton, a plan per leaf

*Written 2026-10-13 16:46 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KC1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; this is a port of one small derived packet, so it needs no reframe of its own
  role: the kernel lane's planner for one short module — type a six-line printed lemma and the two statements a reader composed from it, read them back against the page and the claim list, build the skeleton with `sorry` at every leaf, and write a plan per leaf; if a leaf falls to you while typing, prove it
  launch: now, in a tree of your own; another planner types a number-field module on branch `fs131-wnf` and a reader works on `main` under `plans/` and `data/` — you touch neither; nothing is landing
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect (untrue as written, vacuous, narrower than it need be, or a definition of the library's that is not the paper's), for a generalization that comes free (another dimension, a finite set of distances), and with one line when the skeleton compiles; the report goes to `data/fs131/reports/FS131-KC1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-KC1-measurable-number-plan.md` (new, on branch `fs131-wkc`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wkc` (branch `fs131-wkc`, cut from `main` at `63e633d1`; **the tree is a retired landing's, moved, and its `.lake/build` is one landing older than the branch: the eight modules that landing added under `Proofs/HadwigerNelson/Plane/` are not built there, nothing you import has changed since, and your first build will compile those eight**): one new module under `Proofs/HadwigerNelson/Plane/` (the name is yours) and its lines in the build's lists; `plans/FS131-KC1-measurable-number-plan.md`; `data/fs131/kc1/`; `data/fs131/reports/FS131-KC1.md`. No existing module's statements; nothing on `main`
  budget: about 250k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, when the statements are typed, when the skeleton compiles, and after each leaf's plan; hand back when the plan per leaf is final, or earlier at a saved stage

Hello. This is a small module with an unusual reason to be quick about it.

## Why this job

The project is being wound down and published. Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

This library already proves that the chromatic number of the plane equals the least number of colours in a measurable
colouring that is proper at *almost every* unit pair — on one declared outside theorem. The ledger has always listed the
next step as a gap: equality with the classical measurable chromatic number, where the colouring is proper at *every*
unit pair. This morning a reader of a paper posted five days ago found that step printed there as a short appendix
lemma, checked its six lines, and composed it with the theorem the library imports. The result is the plane case of the
question that paper's abstract raises and says it only hopes to reach; the paper does not draw it. Kooshi's word on it:

> W3: (2026-10-13, after the report on the new paper and the corollary a reader drew from it) which new paper is that? sorry, […] I won't be able to keep up with the minutia. It sounds like a great candidate to formalize too.
> — source: data/fs131/REQUEST-2026-10-13.md

Two things follow for how you work. Anyone who reads both papers can draw the same corollary, so it is worth having in
the kernel soon. And the mathematics is other people's: the module's docstrings and your record say so in plain words —
a printed lemma with its page, formalized here; a declared outside theorem; a composition.

## The statements

Fixed in `data/fs131/claims-NF3.md` before your launch, copied by script from the reader's record:

> NF3-PRINTED: **Lemma B.1** (p. 44). "Suppose that A₁, …, A_k ⊆ ℝ^d are measurable D-avoiding sets whose union is conull. Then ℝ^d admits a measurable proper k-colouring of its D-distance graph." (Appendix B's standing hypotheses, p. 44: "Throughout, D = {d₁, …, d_t} ⊆ (0, ∞) is finite and nonempty, d ⩾ 2, and k ⩾ 2." Before the lemma: "We first show that a measurable proper colouring of a conull set can, after changes on a null set, be extended to a measurable proper colouring of ℝ^d. We suspect that this is a folklore result, but have not found it in the literature.")
> — source: data/fs131/claims-NF3.md § Statements

> NF3-WEAK-TO-PROPER: **ER1-WEAK-TO-PROPER** — a weak measurable `k`-colouring of `ℝ^d` (Lebesgue measurable, proper at almost every pair at a distance in a finite `D`) gives a Lebesgue-measurable `k`-colouring proper at every such pair; so `χ_m⁰(ℝ²) = χ_m(ℝ²)`. **[hand]**, one mind, over `[Davies2026]` Lemma B.1 as printed (p. 44; its proof checked here) and the density-point step printed in `[DeCorteOliveiraVallentin2022]` (proof of Lemma 5.6). § M.
> — source: data/fs131/claims-NF3.md § Statements

> NF3-PLANE: **ER1-PLANE-FALCONER** — `χ(ℝ²) = χ_m(ℝ²)`, Falconer's number. **[derived]** from ER1-WEAK-TO-PROPER and the declared outside theorem `Outside.OAI158.proper_to_borel_weak`; one mind; in neither paper as far as each was read. § M.
> — source: data/fs131/claims-NF3.md § Statements

> NF3-NC: that either statement is this project's theorem (each is a composition of two outside results); any value of the plane's chromatic number; anything about Borel classes where the statements say Lebesgue; anything in dimension other than two or for distance sets other than the unit distance beyond what a planner finds comes free; that the printed lemma is new (its paper says it suspects the lemma is folklore).
> — source: data/fs131/claims-NF3.md § Not claimed

The library's objects they are to be typed over:

> noncomputable def chiM0 : ℕ∞ := ⨅ (k : ℕ) (_ : Nonempty (AeColouring k)), (k : ℕ∞)
> — source: Proofs/HadwigerNelson/Plane/AeColouring.lean

> noncomputable def chiM : ℕ∞ :=
> — source: Proofs/HadwigerNelson/Plane/FalconerReduction.lean

> theorem chromaticNumber_plane_eq_chiM0 : (unitDistance ℂ).chromaticNumber = Plane.chiM0 :=
> — source: Proofs/HadwigerNelson/Outside/OAI158.lean

The paper: `/home/kooshi/source/library/pdf/Davies2026-measurable-obstructions-unmeasurable-colourings.pdf` (its Appendix B, p. 44, for the lemma and its proof; the density-point step it uses is on p. 46).
The reader's record: `plans/FS131-ER1-davies-reading.md` — its § 2.1 sets the paper's definitions beside this project's, and it is still being
written: a section with the composition's steps numbered, each with source and page, is on its way; read what is
there when you reach the readback and again before you finish.

## Done means

1. **Readback** (a saved stage): the eight quoted lines checked against their sources; **the lemma read on the page
   yourself**, with its standing hypotheses; and the two definitions read from the Lean source — say exactly what
   `Plane.chiM` and `Plane.chiM0` require of a colouring (which σ-algebra; everywhere or almost everywhere; classes or
   a map) and whether each is the paper's notion. A mismatch here is the statement defect that matters most.
2. **The statements typed** (a saved stage): the printed lemma for the plane and the unit distance; the step from a
   weak colouring to sets with no unit pair (density points of one class); the equality of the two measurable numbers;
   and the equality with the plane's chromatic number, on the declared outside theorem and nothing else new. Each
   compiled with `sorry` and read back aloud against its claim and against the page.
3. **The skeleton** compiling in your tree, `sorry` at every leaf and nowhere else, a spec example per headline, the
   module's lines in the build's lists; `#print axioms` of the headline showing the standing three and the one
   declared outside theorem (with `sorryAx` until the leaves are done).
4. **A plan per leaf** for an implementer with none of your context — the printed proof's six lines mapped to Lean
   steps, the Mathlib lemmas by full name as you found them (Lebesgue density, de Bruijn–Erdős — the library has its
   own form; say which you use), what you tried that failed. Where a leaf falls to you in a few lines, prove it and
   say so.
5. **What comes free**: whether the same proof gives the lemma for a finite set of distances and in every dimension
   at no cost in this library's vocabulary; if so, state the general form beside the plane's and say what it would
   need.
6. The report, with drafts for the files you do not write: the ledger row's "not claimed" line that this closes, and
   the sentence a reader of the repository would be told — which names both outside works and claims only the
   composing.

## What is yours to decide

The module's name and place; the statements' exact form; whether the density-point step is stated for the library's
weak colourings or for sets; how much of the printed proof to follow and where the library's own lemmas give a
shorter road. If the library already holds part of this under another name — the ledger speaks of a reduction to a
null-set step — find it and build on it.

Not yours here: anything about the paper beyond this lemma; a claim of novelty in any docstring.

## The machine

**This session is on the laptop: 12 cores, 31 GB — the desktop's numbers in `RUNNING.md` and `LEAN.md` do not apply
today.** Run the memory tool as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --name kc1 -- <command>`

One file through `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration: under the
slot with `--mem 8 --cpus 2` from inside your worktree — measured today by the other planner at 3 to 24 seconds and
3.6 GB. A build is one at a time on this machine, and the other planner may be building: on exit 75 wait and retry.
`--mem 18 --cpus 10 -- env MEMMAX=18G BATCH=2 ./scripts/build.sh` from inside the worktree; never `lake build`. The
build's numbers are mine and unmeasured here: tell me what the first one used. Stop a process by its PID, never by
matching its command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/kc1/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**;
a failed push is not an error to fix.

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).
