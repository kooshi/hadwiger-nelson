# Brief FS131-I5 — wave 5 of the Lean backlog: merge the base's branch, apply the eleventh-point repair, and prove the wave's leaves on `fs131-w5`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I5
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's first implementer — merge `fs131-w5b` into `fs131-w5`, apply FS131-E4's repair to the base's statements, run the base's owed obligation pass, then prove wave 5's leaves in the plan's order, saving after each
  launch: now, beside FS131-I2m (wave 2), FS131-I4i and FS131-IC3 (wave 4), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I5.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (new, on branch `fs131-w5`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5` (branch `fs131-w5`): the wave-5 modules (`Proofs/HadwigerNelson/Plane/ValidMap/Chain.lean`, `Terminal.lean`, `Dense.lean`, `HexRing.lean`, `MapGraph.lean`, and from the merge `BaseWalk.lean`, `BaseDense.lean`), supporting lemmas in wave 3–4's foundation modules as § 10.2 allows (statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (your own block, headed "FS131-I5"), `plans/FS131-I5-implementation.md`, `tools/fs131_i5_*.py`, `data/fs131/i5/`, `data/fs131/reports/FS131-I5.md`; not wave 4's modules (`Contact`, `UnitArc`, `BaseSteps`, `SVMap`, `StuckChain`), which wave 4's implementers edit on their own branches
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are wave 5's first implementer, on Opus. The milestone is FS-131, the Lean backlog: it turns this project's hand-derived results into
kernel-checked ones, wave by wave. Waves 1 and 3 are landed; waves 2 and 4 are being proved now. Wave 5 is **termination and density**: the terminal valid
map the simplifying moves reach, the ends of stuck chains, row 134's base step with unit arcs, and the density results built on it. Three planners wrote it:
FS131-K5 and FS131-K5b on `fs131-w5` (the foundation `Chain`, 41 `sorry` leaves in `Terminal`, `Dense`, `HexRing`, `MapGraph`; the handoff is the plan's § 10)
and FS131-KB on `fs131-w5b` (the base `row134BaseUA` laid out as 19 leaves in `BaseWalk`, with it and its four consumers moved into `BaseDense`). A deriver,
FS131-E4, then settled the base's one gap — the eleventh three-colour point is open only at a vertex enclosed by a tile of one of its colours — by adding one
hypothesis to two statements, with every consumer's statement kept.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 5 lands after
wave 4 (its statements cite wave 4's); you can prove its leaves now. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Every `sorry` on `fs131-w5` (at `764cc558`) and, after the merge, on `fs131-w5b`'s modules (at `49ed9cc4`), read back in
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md` §§ 3.2 and 8.2 and in `.claude/worktrees/fs131-w5b/plans/FS131-w5base-kernel-plan.md`. Where to work from and in what order:

> **The plan to work from**: § 4 (leaves 1–22, K5's) and § 9 (the pass's children, and leaves 23–39). The read-backs (§§ 3.2, 8.2) say what each
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md ### 10.1 Where it is, and how the implementer works

(the paragraph continues there with the full order). What you may change:

> **It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md ### 10.2 What the implementer may and may not change

(the section continues there with what you may not change: no statement of §§ 3.2, 8.2, no definition of `Chain`, `HexRing` or `MapGraph`). **One
statement change is ruled, and it is yours to apply first** — FS131-E4's repair:

> 227. **Ruling: repair (b) adopted as drafted** (E4 § 5.2). Choice: `UnenclosedC` on `Row134BaseUA` and `n3_base`, `BaseCtx.unenclosed`, `localDense`'s proof
> — source: plans/FS131-close-inventory.md

The Lean text to apply is `plans/FS131-E4-derivation.md` § 5.2, verbatim (`UnenclosedC`, `Unenclosed` in `Chain`; `Row134BaseUA` and `n3_base` gaining
`F.UnenclosedC u`; `BaseCtx.unenclosed`; `exists_unenclosed_or_bad` stated; `localDense`'s proof routed through it; `not_row134BaseUA_seven`'s extra
conjunct), its four children stated as `sorry` leaves with their arguments' addresses in E4's record. The other rulings that reach you:

> 218. **Rulings on KB's and IC1's held items** (four parts each, compressed where the alternative is plain).
> — source: plans/FS131-close-inventory.md

(the item continues there: (b) `cor3_local` as a new lemma for the base, `cor3` unchanged; (c) the planar-infrastructure job is separate and later; (d) KB's
owed obligation pass and `#check`s for the base are your first stage after the repair; (e) the merge of `fs131-w5b` is your first step; (g) engine 2 lives on
`fs131-w4`). `cvb_thom_reduced`: price it from its first two children and report; I decide then whether it becomes its own job (item 208 (a)).

## Done means

1. **Your readback first**: check the quotations above against their sources; build `fs131-w5` once as given (`764cc558`); open your record with what you may
   and may not change. Commit and push.
2. **The merge**: merge `fs131-w5b` (`49ed9cc4`) into `fs131-w5` (append-only conflicts in `scripts/Axioms.lean`, `Proofs.lean`, `ARCHITECTURE.md`, and
   `Dense.lean`'s moved block); build; run `tools/fs131_qa1_dupes.py`. A merge commit is the one commit made without paths; say so in its message.
3. **The repair**: E4 § 5.2 applied verbatim, its children stated, the docstrings updated, read back against E4's statements; build green with only `sorry`
   warnings. Commit. Then **the base's obligation pass** (`debruijn-obligation-modeling`, invoked fresh, over `BaseWalk`'s and `BaseDense`'s statements) and
   the `#check` of its Mathlib names. Commit.
4. **Leaves proved** in § 10.1's order (yours to change), saving after each; no other statement changed, no new `axiom`, no `native_decide`; re-price from
   your first two hard leaves. Do not edit a file while a build of it runs.
5. **Your record**, stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. The gate and the landing are a later
   implementer's, after wave 4 lands. Stopping at a saved stage with leaves left, and naming them, is a good report.

## What is yours to decide

The proofs, their children and order, where a supporting lemma lives within § 10.2's allowance, and how you split the repair's children. If a leaf cannot be
proved as written, stop that leaf, message me at once with the declaration, the reason, and the smallest counterexample or the missing hypothesis, and go on
with the others. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own
(standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; four agents are building
today, so on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never
evidence; if you mirror oleans for iteration, use a scratch directory of your own (wave 4's `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/data/fs131/i4/iter.sh` reads it from the variable `S`). The worktree's
`.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

## Amendment 2026-10-04 (Keryx) — `IsRetArc` gains CD's β

Your finding on `BaseCtx.retArcs_nested` is logged as `plans/FS131-close-inventory.md` item 231 and ruled in item 232: you may change `IsRetArc`'s definition in
`Proofs/HadwigerNelson/Plane/ValidMap/BaseWalk.lean` to require CD's β — some connected `K` with `r(s), r(t) ∈ K ⊆ closure T₁ ∩ closure T₂ ∩ closedBall u 1` —
with its docstring citing `plans/FS110-CD-verification.md` § 2.4 (Lemma R, l. 200) and item 232, and update `retArcs_nested`, `reduce` and `exists_endpoint`'s
uses to match. Record the change, with the configuration that forced it, in your record. No other definition or statement changes; you still start no agents
of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
