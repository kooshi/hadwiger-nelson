# Brief FS131-E8 — the bridge under route M's regularity hypothesis: do REG-J′'s frozen words, with saturation, give the fan with end tangents that every consumer reads?

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-E8
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job
  role: derive one fixed question to a verdict — the bridge derived (found in the record, or derived here), refuted by an exhibited saturated colouring, or "not derived; stalls at" a named step — and say what the verdict does to the results that read REG-J′
  launch: now, beside de Bruijn jobs on branches of their own; you write on `main`, to paths no other job writes
  mission: § Why this job
  statements: § The question
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a refutation (at once: the planner of wave 6's second pass states its rows over this hypothesis), a derivation an implementer can formalize, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-E8.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` § Make the gate fail, and watch it fail, before you build any check
  record: `plans/FS131-E8-derivation.md`
  touches: `plans/FS131-E8-derivation.md`, `data/fs131/e8/` (scripts and scratch here, not in `tools/`), `data/fs131/reports/FS131-E8.md`
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 450k — read your token count at every saved stage

Hello. The Lean backlog (FS-131) turns this project's hand-derived results into kernel-checked ones, and its sixth wave is the thirty-five results
on saturated colourings — route M's regularity (`LEDGER.md` rows 139–144; `CLAUDE.md` § The aim, item 6). Reading them against Lean, the wave's
planner found that the hypothesis they share, REG-J′, is used in a stronger form than its written words: every consumer reads a *fan* at each
singular point — finitely many interface arcs, each a polar graph with a limit direction — while the frozen words say only that each singular point
meets finitely many interface arcs. The end tangents are taken silently from C11, whose unit discs hold only inside a neighbourhood that shrinks
toward the singular set. The planner found no derivation of the step from one form to the other. That step is your question.

## Why this job

REG-J′ is the hypothesis of route M, one of the two routes to seven (`CLAUDE.md` § Where the problem stands, item 31), and FS-126 and FS-127 are
posed over it. If the literal form does not give the fan, then the map-step results hold under a stronger hypothesis than the frontier's stubs
state, and what those milestones must supply grows; if it does, a missing lemma is found and can be formalized. Both are results — Kooshi: *"A
proven theorem about why its impossible is also valid. All novel knowledge is a success."* (`plans/STANDING-RULES.md` rule 4). The finding and the
ruling:

> 481. **FS131-K6, by message mid-job (`fs131-w6` at `c3ffb4e7`, build OK by its word): five rows of wave 6 hold at a wider class than filed;
> — source: plans/FS131-close-inventory.md

## The question

The planner fixed both forms and the bridge in Lean (a design file, elaborated, not a library module) and in its record's § 6 with the addresses of
the frozen words and of the derivations' uses; read both whole. The three definitions' first lines, and the section:

> def RegJLiteral (c : AeColouring k) : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/data/fs131/k6/FanDesign.lean

> def RegJFan (c : AeColouring k) : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/data/fs131/k6/FanDesign.lean

> def RegJBridge (k : ℕ) : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/data/fs131/k6/FanDesign.lean

> ## Stage 6 — SAVED: REG-J′, both forms, and the bridge (for the deriver's job; ruled, inventory item 481)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

**Q.** For a saturated honest colouring of the plane with `k` colours satisfying REG-J′ in its frozen words, does every singular point have a fan
with end tangents — the four clauses (α)–(δ) by which the planner's § 6 says the fan exceeds the words? Answer, clause by clause: derived (with
the entry that derives it, or your derivation), refuted (a colouring exhibited exactly, saturated, satisfying the words and failing the clause), or
not derived, with the step where it stalls.

*Not claimed*: anything about whether REG-J′ itself holds for any colouring; anything at a fixed number of colours unless your argument reads it.

**A second, smaller question, if budget remains** (from wave 10's planner; inventory item 484): J45-SI-5's step (c) cites ergodic averages along a
tempered Følner sequence — a pointwise ergodic theorem Mathlib lacks (`plans/FS84-SI-D-derivation.md` § 2.2, SI-5 (c)). Is there an argument by
conditional expectation that avoids it? A yes with the argument, or a no with the reason.

## Done means

1. **Your readback first**: check the quotations against their sources; read the planner's § 6 and its design file, REG-J′'s frozen words and
   close note (`data/fs121/claims.md`), C11 and its use of tangents (`plans/FS111-M-regularity.md` § 4.1), and the entries of the rows that read
   the fan (the planner's § 6 lists them). Restate the question in your record; register a prediction per clause before deriving. Commit and push.
2. **A verdict per clause**, in your lane's derivation form (statement, uses only, not claimed, argument, verdict, grade, minds, model, prior art,
   handoff), saving after each. A refuting colouring is exhibited exactly and its saturation and the words checked, with a control that fires on
   a planted fault; no search.
3. **The trace**: which filed results read which clause, what each becomes under your verdict (unchanged, true under the stronger hypothesis only,
   or needing the bridge as a lemma), and one drafted bearing line each for `plans/STUB-curved-pencils.md` and the lateral-extent stub if the
   verdict moves them (I file them).
4. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed; your derive gate
   (`.claude/skills/ephodos/scripts/derive_gate.py all plans/FS131-E8-derivation.md`, from `plans/`) green; the report in standing rule 11's
   form. Stopping at a saved stage with some clauses answered and the rest open at named steps is a good report.

## What is yours to decide

The route to each clause and the form of any counterexample. Attack the question: if the fan is more than the consumers need — if each reads only
some of (α)–(δ) — say which, because the weakest hypothesis they share is what the kernel should carry. If the planner's reading of the frozen
words is wrong, say so with the address. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator
can only review work it knows exists).

## The machine

No Lean build is needed. A check that needs more than a few gigabytes runs under the slot
(`/home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 4 -- <command>`). `/tmp` is a tmpfs: keep what your record cites under
`data/fs131/e8/`.

## Amendment, 2026-10-06 (inventory items 499 and 501–502): a check of the planner's statements of your bridge

*Sent to the job by one message pointing here. You are resumed for this stage only; your harness count stood at about 441k when you handed
back, so this is sized at about 60k more — hand back by about 520k whatever is done, and say what is left.*

Wave 6's second planner (FS131-K6b, on `fs131-w6`, handed back at `32f2ab4c`) stated your eight entries in Lean, proved the bridge from the
fan lemma, and proved one lemma that replaces a step of yours. It asks for a deriver's eye on four things before implementers build on them.
Its findings, in its record (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md` § 11.5, five items; read the
section whole, with § 11.3, its read-back of each of your entries, and § 11.4's rows for the leaves named below):

> ### 11.5 Findings on the bridge (sent to the coordinator mid-job)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md

> 1. **A step that does not formalize as written, and a shorter route** — E8 § 3.1 (4), *Regularity*: "At a point where `g″` exists the graph stays
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md 11.5 Findings on the bridge

> 3. **A generalization**: FS131-E8-FAN's "at least two [curves]" and "regions on the two sides of a curve being of different colours" read no
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md 11.5 Findings on the bridge

> 4. **Three statements are the planner's assembly**, for a deriver's check: `IsUnitCurve.one_le_dist` (E8's § 4.6 offered
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md 11.5 Findings on the bridge

The statements, as they stand in its tree (read each whole in the file, with its docstring; `two_le_n`, `col_ne` and `branch_contacts` are in
the namespace `AeColouring.Fan`):

> theorem IsUnitCurve.one_le_dist {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {ℓ : ℝ} (h : IsUnitCurve γ ψ (Icc 0 ℓ))
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/Proofs/HadwigerNelson/Plane/Saturated/Curve.lean

> theorem norm_sub_le_of_discs {x y νx νy : ℂ} (hx : ‖νx‖ = 1) (hy : ‖νy‖ = 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/Proofs/HadwigerNelson/Plane/Saturated/Curve.lean

> theorem fan_of_isolated (c : AeColouring k) {z : ℂ} {R : ℝ} (hR : 0 < R) (hS : c.singularSet ∩ ball z R ⊆ {z})
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

> theorem two_le_n (hz : z ∈ c.singularSet) : 2 ≤ F.n := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

> theorem col_ne {i j : Fin F.n} (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n)) : F.col j ≠ F.col i := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

> theorem branch_contacts (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {i j : Fin F.n}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

**What is asked, in this order** (each saved as you go; stopping after the first two is a good report):

1. **`branch_contacts`**: derive or refute it at its exact Lean hypotheses — above all the planner's claim that a branch of a fan is of split
   type along its whole length or of tangent type along it. Every sector row will read it. An entry in your record's form, with a model and a
   *not claimed* line; a refutation is a message to me at once.
2. **`two_le_n` and `col_ne` without saturation**: the planner's argument is in its § 11.4 (a continuous polar graph is null; equal colours on
   the two sides would make branch points density points). Derive or refute, as an entry; say whether FS131-E8-FAN's entry should be amended
   to say so.
3. **`one_le_dist`** (the coordinator redid its derivative by hand and found it right; yours is the check that it is the statement the sector
   rows need, where your § 4.6 offered `arcsin(t)/2`), and **`fan_of_isolated` at every `z`**, singular or not, without `R ≤ 1/2`: confirm
   or correct, a line each.
4. **An erratum in your own record** under FS131-E8-LOCAL: § 3.1 (4)'s regularity step ("where `g″` exists … absolutely continuous") is
   replaced in the kernel by `norm_sub_le_of_discs` and a lens-in-`N` step; read the planner's item 1, check its `3.5δ`, and write the dated
   line — the entry's text left standing, as your lane's rule has it.
5. **The planner's read-backs** (its § 11.3): one line for any of your eight entries whose Lean statement says less or more than you meant
   beyond what it already names as wider.

Your record and gate as before (`plans/FS131-E8-derivation.md`, a new stage headed "Stage 6"; the derive gate green); the report appended to
`data/fs131/reports/FS131-E8.md` as a second section, and its text your final message. You read the planner's branch; you do not write it.
You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
