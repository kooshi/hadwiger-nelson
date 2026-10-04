# Brief FS131-I4d — wave 4 of the Lean backlog, continued: the 51 remaining `sorry` declarations on branch `fs131-w4`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I4d
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 4's fourth implementer — merge `main` (which now holds `localSectors`), write the bridge to wave 4's sector vocabulary, prove the sector-reading leaves and the rest, the audit's four items and `lock` clause 1, saving after each; the gate and the landing when the last leaf is proved
  launch: now, beside FS131-I2i (wave 2) and FS131-IWc (Woodall's chain), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I4d.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I4-implementation.md` (on branch `fs131-w4`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4` (branch `fs131-w4`): the five skeleton modules (`Proofs/HadwigerNelson/Plane/StuckChain.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BaseSteps.lean`, `Proofs/HadwigerNelson/Plane/SVMap.lean`), the foundation `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` (the engines, sorry-free), supporting lemmas in the foundation modules § 14.2 names (statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 4's carriers only, at the gate), `plans/FS131-I4-implementation.md`, `tools/fs131_i4_*.py`, `data/fs131/i4/`, a new wave-4 module for `localSectors` if item 126 makes it yours (`Proofs/HadwigerNelson/Plane/ValidMap/Sectors.lean`, say), `data/fs131/reports/FS131-I4d.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are wave 4's fourth implementer, on Opus. Wave 4 is the valid-map machinery the frontier's local exclusion rests on. Three implementers
proved 35 of its 86 leaves; the last, FS131-I4c, discharged Lebesgue's covering theorem from `main`, proved FS106-L (`lemmaL`) by a shorter route than the plan's,
and proved FS106-TS-T's first clause, so `ts_t` is sorry-free. The sector structure at a point (`localSectors`) is now on `main`; about twenty of the 51 open
leaves read it through wave 4's own sector vocabulary, so the bridge between the two is your first real work.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Woodall's chain lands
only after wave 4 does.

## The statements

The 51 `sorry` declarations on branch `fs131-w4` at `2e42278a` (Contact 10, UnitArc 20, BaseSteps 20, SVMap 1), read back in
`.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` §§ 3.2, 7.2, 8.2, 12.2, planned in § 13, handoff § 14. What you may change:

> **It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md § 14.2 What the implementer may and may not change

Where I4c left it:

> **The merge** (`52fe62fd`): `origin/main` (waves 1 and 3 landed, FS131-LEB) into `fs131-w4`. Conflicts at the append points only — `ARCHITECTURE.md` (`main`'s
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/plans/FS131-I4-implementation.md ## Stage 6 — SAVED (FS131-I4c): `main` merged, Lebesgue discharged, FS106-L and TS-T's first clause proved; 51 `sorry` left

What landed:

> 171. **FS131-I3i done; `localSectors` LANDED on `main`** (report `data/fs131/reports/FS131-I3i.md`; record on `fs131-w3b`; `origin/main` fast-forwarded to `0131aa59`, whose Lean
> — source: plans/FS131-close-inventory.md

**Your order** (I4c's handoff, its report): (1) merge `main` (`0131aa59` or later; `tools/fs131_qa1_dupes.py`); (2) the bridge (inventory item 136: every `S`
with `IsSector v r S`, for `r` small, either has a cone of nonempty interior or is `hornSet v β κ₁ κ₂ r` with `κ₁ < κ₂`, and the number of sectors is constant),
then `exists_hasDegree_of_mem_dom` (route in I4c's Stage 6), which frees `ts_t_trichromatic` and `ts_t_degree_three`; (3) the audit's items (item 172): inhabitants
of `IsCubicTrichromatic` and a non-degenerate `MIn` at a `sevenBrickMap` corner (`plans/FS131-QA2-audit.md` § 2.2, `tools/fs131_qa2_brick.py`), a proved horn (the
`bowtie_*` leaves early, or a two-colour cusp fragment), `halfDisc.Simple`, and `stuck_chain`'s docstring naming `n4_fin` as the refutation; (4) `lock` clause 1
(item 143's second gap: N-E2 between the outer tile at `w` and a second tile of colour `c′`) — work it out, or message me if it needs new mathematics; (5) the
remaining leaves; (6) before the gate, `AeProperRegions` registered as a vacuity carrier (item 144), TS-T's Condition-5 clause kept in its carried form (item
142). Name collisions with Woodall's branch (`abs_dot_le`, `isOpen_shadow`, `dot_add_left`) are resolved by whichever branch lands second.

## Done means

1. **Your readback first**: check the three quotations against their sources; build the branch once as given (`2e42278a`) before editing anything; restate in your
   record what you may and may not change. Commit and push.
2. **The order above**, saving after each leaf; no statement changed, no new `axiom`, no `native_decide`; re-price from your first two hard leaves.
3. **When the last leaf is proved**, the gate as § 14.4 gives it (warnings counted — `scripts/build.sh` exits 0 with warnings), then the landing: merge `main`,
   resolve collisions, re-run the gate, fast-forward `main` (`git push origin HEAD:main` from the worktree), never force-push.
4. **Your record** (continue it), stages headed "Stage n — SAVED", "Theorems this phase proved"; drafts for the front page at the gate; the report in standing
   rule 11's form. Stopping at a saved stage with leaves left, and naming them, is a good report.

## What is yours to decide

The proofs, their children and order within § 14.1's, where a supporting lemma lives, and each carrier's in-or-out call at the gate. If a leaf cannot be
proved as written, stop that leaf, message me at once with the declaration, the reason, and the smallest counterexample or the missing hypothesis, and go
on with the others: implementers on this milestone have already found several statements that needed a hypothesis the hand derivation hid, and each was a correction to the record. Three failed attempts
on one route is a dispatch to the companion your identity names, never a fourth.

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5), and
several trees are building today, so on exit 75 wait ten minutes and retry. `lake env lean` (with § 14.1's flags) is for iteration only, never evidence.
The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`. You start no agents of your own
(standing rule 1).
