# Brief FS131-E9 — three gaps under wave 6's ladder: integer curvature on a general chart, finitely many pieces, arc interfaces

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-E9
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job
  role: derive three fixed questions to a verdict each — derived (a derivation an implementer can formalize), refuted by an exhibited saturated colouring, or "not derived; stalls at" a named step — and say what each verdict does to the Lean leaves and the filed results that read it
  launch: when a slot frees, beside de Bruijn jobs on branches of their own; you write on `main`, to paths no other job writes
  mission: § Why this job
  statements: § The questions
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a refutation (at once: three implementer jobs are about to be cut on the line these leaves sit on), a derivation of Q1 an implementer can start from (when it is saved — it need not wait for Q2 and Q3), a defect in a filed entry, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-E9.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` § Make the gate fail, and watch it fail, before you build any check
  record: `plans/FS131-E9-derivation.md`
  touches: `plans/FS131-E9-derivation.md`, `data/fs131/e9/` (scripts and scratch here, not in `tools/`), `data/fs131/reports/FS131-E9.md`; **not** the claim list (`data/fs131/claims-E9.md` is the coordinator's: a statement you find wrong is a message), any derivation file of an earlier milestone (a correction owed is a draft in your record), any Lean file
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 450k — read your token count at every saved stage

Hello. The Lean backlog (FS-131) turns this project's hand-derived results into kernel-checked ones, and its sixth wave is the results on
saturated colourings — route M's regularity (`LEDGER.md` rows 139–144; `CLAUDE.md` § The aim, item 6): off a locally finite singular
set, the interfaces of a saturated colouring are segments and arcs of integer radius. Reading that sentence against Lean, three jobs
reached the same missing mathematics from three sides in one day: wave 9's planner, wave 6's fourth planner, and the implementer who
proved fifteen of the seventeen leaves of the module the sentence lives in and stopped at the other two, saying they were a deriver's
question before they were a fourth attempt. The three questions are yours.

## Why this job

Two kernel leaves have no route, and one named open statement sits under a row of the ledger. If each is derivable, an implementer has
its route and the ledger's row 154 keeps its sentence; if one is not, the front page owes an erratum — it is already drafted as "given
REG-J′₅ and that its interfaces are locally finitely many segments and circular arcs" — and the frontier's stubs on curved pencils and
lateral extent gain a named residue. Every one of those outcomes is a result: Kooshi, *"A proven theorem about why its impossible is also
valid. All novel knowledge is a success."* (`plans/STANDING-RULES.md` rule 4). A deriver's hour here is cheaper than two kernel jobs
spent finding out. What the three jobs found, and the rulings (read each item whole in the inventory, `plans/FS131-close-inventory.md`):

> 576. **FS131-I6L done at its Stage 4: wave 6's cover hull and parallels — fifteen of seventeen leaves proved; the two left have no kernel route and are a deriver's question** (implementer, Opus; harness 588k and 61 minutes by the task notice; record `fs131-w6l`'s `plans/FS131-I6L-implementation.md`; report `data/fs131/reports/FS131-I6L.md`; seven commits, tip `b5b8f4be`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 590. **FS131-I6K done: wave 6's accumulation rows — all ten leaves proved as stated** (implementer, Opus; harness 513k and 95 minutes by the task notice; record `fs131-w6k`'s `plans/FS131-I6K-implementation.md`; report `data/fs131/reports/FS131-I6K.md`; five commits, tip `2a8ed9eb`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 566. **FS131-K6d done at its Stage 25: wave 6's fourth planning pass — the fragment's six rows stated with no statement defect, the cover's cell proved, and a gap in FS111-M-REDUCE-I now carried by a saved stage** (planner; harness 524k and 51 minutes by the task notice; record `fs131-w6`'s `plans/FS131-w6-kernel-plan.md` Stages 16–25; report `data/fs131/reports/FS131-K6d.md`; commits `59ce6b0c`, the merge `4ae5bd36`, `b79d4892`, `87e8968c`, `2aa3f720`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 565. **FS131-K6d, by message mid-job: findings from reading the fragment's six arguments and FS111-M-REDUCE-I — no row refuted; one changes what wave 9's join can use** (source: K6d's message to "main", 2026-10-06; by its word the four new modules elaborate one by one, the full build is running and unread, and nothing is in a saved stage — the artifact is read at its hand-back).
> — source: plans/FS131-close-inventory.md

> 533. **FS131-K9, by message mid-job: five findings from reading wave 9's eleven rows — no row refuted; a supporting lemma that
> — source: plans/FS131-close-inventory.md

## The questions

The claim list is `data/fs131/claims-E9.md`, fixed before this launch: read it whole — it holds the two filed entries, each Lean
statement at its address, and each question's *not claimed* line. The three questions, first lines:

> **Q1.** For a unit-speed curve with 1-Lipschitz tangent angle in the interface of a saturated colouring whose singular set is locally
> — source: data/fs131/claims-E9.md

> **Q2.** (a) Is there an argument for clause (iii) of FS111-M2-INTRAD — finitely many interface pieces of each radius near a point — that
> — source: data/fs131/claims-E9.md

> **Q3.** Does a saturated colouring with locally finite singular set have interfaces that are locally finitely many segments and
> — source: data/fs131/claims-E9.md


**What the kernel's planners wrote about them** (wave 6's plan record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md`):

> 3. `curvature_integer_ae` (FS111-M2-INTRAD (i) along a general chart) has no kernel route yet: the derivation's step (2) is two lines.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

> ## Stage 22 — SAVED: FS111-M-REDUCE-I (`Plane/Saturated/ReduceI`)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

> **The entry's argument does not reach an arc map** (W10; sent to the coordinator for wave 9's planner). § 5.1 builds REG-I's map with
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md


**The implementer's route for Q1 and its note on Q2** — one mind, by hand, not formalized, written to be confirmed or replaced (its
record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-I6L-implementation.md`; read its Stage 4 whole):

> ## Stage 4 — SAVED (FS131-I6L): the two leaves left, and why they are a deriver's first
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-I6L-implementation.md

> **(i), a route [hand, one mind, unformalized — to be confirmed by a deriver].** Chart `γ`, `ν(s) = i e(ψ s)`;
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-I6L-implementation.md

> 1. *Types along the chart.* `curve_type` applies to a chart (`g = γ`, `n = ν`, `μ = −1`, `U = Q`): each parameter is
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-I6L-implementation.md

> 2. *The inequality of the `j`-th parallel.* Write `P_j(s) = γ(s) + σ j ν(s)`. If `s_i → s₀`, `s_i ≠ s₀`, and
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-I6L-implementation.md

> 3. *Where the chain dies.* At `Σ`: `{s : P_j(s) = p}`, `p ∈ Σ`; at an accumulation point of it, differentiating gives
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-I6L-implementation.md

> 4. *Bookkeeping.* The exceptional parameters are the non-differentiability points, countably many sets of isolated
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-I6L-implementation.md

> **(iii).** Read, not worked. One structural point for the planner: the derivation's step (3) takes the *terminal
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-I6L-implementation.md

> **A note on both statements** (no defect found): `IsInterfaceChart A B N y Q γ ψ h` carries no `TwoColourOn A B N`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-I6L-implementation.md


## Done means

1. **Your readback first**: check every quotation here and in the claim list against its source; read the filed argument
   (`plans/FS111-M2-regularity.md` § 4.1, with its verifier's record), the implementer's Stage 4, the planner's Stage 22 and § 15.4,
   and the Lean statements whole — the kernel's statement is the question's exact form, and where it differs from the filed entry say
   so. Restate the three questions in your record; register a prediction per question before deriving. Commit and push.
2. **A verdict per question**, in your lane's derivation form (statement, uses only, not claimed, argument, verdict, grade, minds,
   model, prior art, handoff), saving after each. **Q1 first**: the implementer's four steps are a candidate route — confirm each step,
   repair it, or replace the route; its step 4 (the null set of exceptional parameters) is the part with no counterpart in the filed
   argument. A derivation is written so that an implementer can formalize it: each step names what it reads and at what generality. A
   refuting colouring is exhibited exactly, its saturation and its singular set checked, with a control that fires on a planted
   fault; no search.
3. **The trace**: for each verdict, what becomes of the Lean leaf (`curvature_integer_ae`, `finite_pieces_of_radius` and where it
   should live, `ArcInterfacesOfRegJ`) and of each filed result that reads it — unchanged, true under a stronger hypothesis only, or
   needing a named residue; the drafted erratum sentence for `LEDGER.md` row 154 confirmed, sharpened or withdrawn; and one drafted
   bearing line each for `plans/STUB-curved-pencils.md` and the lateral-extent stub if a verdict moves them (I file them).
4. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed; your derive gate
   (`.claude/skills/ephodos/scripts/derive_gate.py all plans/FS131-E9-derivation.md`, from `plans/`) green; the report in standing
   rule 11's form. Stopping at a saved stage with one question answered and the others open at named steps is a good report.

## What is yours to decide

The route to each verdict and the form of any counterexample. Attack the questions: if the kernel's leaf asks more than its readers
need, say which hypothesis or conclusion is idle, because the weakest statement its readers share is what the kernel should carry —
that kind of finding has already removed two readers of Q2. If the implementer's route is wrong at a step, say so with the step; it
asked for exactly that. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can
only review work it knows exists).

## The machine

No Lean build is needed. A check that needs more than a few gigabytes runs under the slot
(`/home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 4 -- <command>`). `/tmp` is a tmpfs: keep what your record cites under
`data/fs131/e9/`.
