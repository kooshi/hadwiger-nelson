# Brief FS131-W — Woodall's theorem in the kernel: plan FS106-WO, FS106-TW and FS106-AE-MAP6 (maps need six, almost everywhere)

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-W
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: plan the kernel module for Woodall's chain — the three rows as a skeleton with `sorry` at every leaf, each read back against its row and against the papers, any foundation they need, a plan per leaf, and the implementer's handoff
  launch: now, beside FS131-I3c (wave 3's implementer) and FS131-K2c (wave 2's re-planner), each in its own worktree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect, a generalization or shorter route, a missing lemma, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-W.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-W-kernel-plan.md`
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww` (branch `fs131-ww`): new modules under `Proofs/HadwigerNelson/Plane/` for Woodall's chain (the layout is yours), supporting lemmas in the foundation modules (statements of other waves unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-W-kernel-plan.md`, `tools/fs131_w_*.py`, `data/fs131/w/`, `data/fs131/reports/FS131-W.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. You are planning the formalization of a classical theorem in the form this project repaired: every map colouring of the plane with five colours
has two points at distance exactly 1 in the same colour, almost everywhere — "maps need six". Woodall proved it in 1973 (`[Woodall1973]` Thm 6, our copy
`~/source/library/pdf/jcta-1973-woodall-distances-realized-covering-plane.pdf`); Townsend's note (`[Townsend1981]`,
`~/source/library/papers/townsend-1981-every-5-coloured-map-monochrome-unit-jcta-30-114-115.pdf`) prints no proof, and his 1979 manuscript
(`[Townsend1979ms]`, see `BIBLIOGRAPHY.md`) is the other half; this project found that each repairs the other, and derived the almost-everywhere form
(`LEDGER.md` row 132; the opening plan's ruling R9: their mathematics enters as ours, not as an axiom). It is one of the milestone's longest single
proofs, which is why it runs as its own job (inventory ruling 54). Its consumers are three wave-9 rows (FS111-C-SIX-M, FS111-M2-REDUCE-C, FS129-OR1-TOP5):
it lands before wave 9.

## Why this job

The backlog formalizes every hand result the frontier rests on. "Maps need six, almost everywhere" is the input to route M's reduction of `χ_m⁰(ℝ²) ≥ 6`
(wave 9), so until it is held, every result downstream of that reduction carries it as a hand result. Kooshi, on pricing Lean work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your three rows, each quoted here from the backlog (with its errata and merge notes at the row's heading there; their definitions in
`plans/FS106-derivation.md` at the addresses the backlog gives, and FS-106's records those entries cite):

> No map-type colouring (Conditions 2–4) with five colours is almost-everywhere proper, modulo Townsend's simplification (c) as filled by Woodall's steps 2, 3, 5; no step uses "boundaries of measure 0", which only identifies D-AEMAP with Leb ⊗ σ-a.e. properness.
> — source: plans/LEAN-BACKLOG.md § 8. FS106-AE-MAP6

> `[Townsend1981]` states "Every 5-coloured map in the plane contains a monochrome unit" and a lemma (constant π/3), with no proof of the theorem; the lemma is TRUE. Townsend's 1979 manuscript proves the ⅓π lemma, his Thm 2 and the Corollaries of Thms 3–4 region-only (Thm 4 itself GAP in its generality, petal-shaped sets; its Corollary repaired, sketch), and his Thm 5 (maps need six) is a GAP at simplification (c), which Woodall's steps 2, 3, 5 fill.
> — source: plans/LEAN-BACKLOG.md § 7. FS106-TW

> `[Woodall1973]` Thm 6 (maps need six): step 6 is a GAP (it rests on the assertion Townsend's ⅔π counterexample refutes), repaired by Townsend's ⅓π lemma; Woodall's step-4 lemma holds for arcs strictly longer than ⅔π, by lemma (L).
> — source: plans/LEAN-BACKLOG.md § 6. FS106-WO

They rest on FS106-L and FS106-TS-T, stated in wave 4 (`Plane/SVMap` on your branch: `lemmaL`, and TS-T's three clauses), and FS106-WO's handoff
reads FS106-L. Two rulings bind you: **inventory item 67** — FS106-L holds only for a change point in the open set (an adversary,
`not_lemmaL_of_not_mem`, records that it is false at a frontier point), so apply (L) only at points of the open set, in Townsend's annulus and at
Woodall's step 4; and **the opening plan's ruling R9** — the verdict clauses of FS106-WO and FS106-TW are dropped and their mathematics formalized (the CSV's
reason column; `plans/FS131-kernel-plan.md` § 4.3). Wave 4's handoff (`.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 14) and its vocabulary
(`Plane/ValidMap/Basic`, `Plane/SVMap`, wave 3's local geometry) are what you build on; TS-T's first clause is Lebesgue's covering theorem for the square,
a separate job (FS131-LEB, item 66) — use it as stated.

## Done means

1. **The read-back against the papers**: for each row, the formal statement read against its row and against the step of Woodall's or Townsend's argument
   it formalizes, with a reading status per section of each paper in your record (standing rule 10); where the papers and the derivation differ, say how.
2. **Any foundation the chain needs** (map-type colourings with Conditions 2–4 may already be in wave 4's `Plane/SVMap`; Euler-type counting on a map, if the
   argument uses one, may be new), sorry-free with spec examples and inhabitants, one fresh `debruijn-domain-modeling` pass.
3. **The skeleton**: the three rows in Lean with `sorry` at every leaf, building through the worktree's `./scripts/build.sh` with only `sorry` warnings;
   `Proofs.lean`, `ARCHITECTURE.md` (architecture check passing) and `scripts/Axioms.lean` updated on the branch.
4. **A plan per leaf** (route, Mathlib lemmas confirmed with `#check`, children, an honest price), the obligation-modeling pass, and the implementer's handoff
   in the form of wave 4's § 14. Outside theorems the chain needs beyond Lebesgue's: decided per `LEAN.md` § Assumptions, each with its reason.
5. Your record with stages headed "Stage n — SAVED" and "Theorems this phase proved" (usually none); the report in standing rule 11's form. If your context
   runs short, save the foundation and the read-backs first and hand back with the rest named — every planner on this milestone so far has needed a successor.

## What is yours to decide

The representation, the module layout, the order of the steps, and whether the three rows are best stated in the derivation's order or merged into one
theorem with its lemmas (every row must still be read back to a declaration). If a row cannot be stated without a hypothesis the derivation hid, or a
step of the papers fails when formalized, that is a finding: message me at once. A widening is a generalization: message me as well.

## Stages

1. **The readback**: check the four quotations above against their sources; restate the rows and rulings in your record; read the papers' relevant sections and
   record their status. Confirm the worktree builds (one `./scripts/build.sh` run under the slot). Commit on the branch and push it (`git push -u origin fs131-ww`).
2. **The foundation**, if any. Commit.
3. **The skeleton and the read-backs.** Commit, and message me the commit.
4. **The leaf plans, the obligation-modeling pass, the handoff.** Commit, then report.

## The machine

- **The worktree is ready**: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww`, branch `fs131-ww` at `f620977c` (wave 4's full skeleton, which holds
  waves 1, 3 and 4's statements), `.lake/packages` a symlink to the main tree's and `.lake/build` its own copy; never replace that copy with a symlink.
- **Builds** only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
  ./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5); on exit 75
  wait ten minutes and retry. `lake env lean` is for iteration only.
- **Nothing with a `sorry` reaches `main`**: the chain lands after waves 3 and 4 do, by merging `main` and its implementer's gate.
