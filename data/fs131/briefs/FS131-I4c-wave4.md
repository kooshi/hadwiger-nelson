# Brief FS131-I4c — wave 4 of the Lean backlog, continued: the 54 remaining `sorry` declarations on branch `fs131-w4`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I4c
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 4's third implementer — discharge Lebesgue's covering theorem from `main`, prove the remaining leaves (the sector-reading ones once `localSectors` lands on `main`), close the two plan gaps, saving after each; the gate and the landing when the last leaf is proved
  launch: now, beside FS131-I2h (wave 2) and FS131-I3i (`localSectors`, landing on `main`), and FS131-QA2 (an audit, read-only), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I4c.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I4-implementation.md` (on branch `fs131-w4`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4` (branch `fs131-w4`): the five skeleton modules (`Proofs/HadwigerNelson/Plane/StuckChain.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BaseSteps.lean`, `Proofs/HadwigerNelson/Plane/SVMap.lean`), the foundation `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` (the engines, sorry-free), supporting lemmas in the foundation modules § 14.2 names (statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 4's carriers only, at the gate), `plans/FS131-I4-implementation.md`, `tools/fs131_i4_*.py`, `data/fs131/i4/`, a new wave-4 module for `localSectors` if item 126 makes it yours (`Proofs/HadwigerNelson/Plane/ValidMap/Sectors.lean`, say), `data/fs131/reports/FS131-I4c.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are wave 4's third implementer and its first on Opus. Wave 4 is the valid-map machinery the frontier's local exclusion rests on — contacts
between tiles, unit arcs on the circle about a vertex, the stuck chain, the Sokolov–Voronov map steps, the bowtie's base steps. Two Sonnet implementers proved
32 of its 86 leaves. Since then three things it waited on have arrived: Lebesgue's covering theorem is held on `main` (FS131-LEB), wave 3 has landed on `main`,
and the sector structure at a point (`localSectors`) is proved on `fs131-w3b` and landing on `main` now (FS131-I3i).

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). About twenty of
wave 4's open leaves read the sector structure; the rest are fragments and analysis. Kooshi's standing word: formalization is never a cost that ranks routes.

## The statements

The 54 `sorry` declarations on branch `fs131-w4` at `f1f26a8a`, read back in `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` §§ 3.2, 7.2, 8.2,
12.2, planned in § 13, handoff § 14. What you may change:

> **It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md § 14.2 What the implementer may and may not change

Where I4b left it:

> **Readback (brief FS131-I4b).** The four quotations (§ 14.2 "It may", ruling 126, the Wave 4 note, the Stage 3 "Where it stands") match their sources;
> — source: .claude/worktrees/fs131-w4/plans/FS131-I4-implementation.md ## Stage 4 — SAVED (FS131-I4b): readback, six leaves, 54 `sorry` left

(its stage gives routes for what is left and the two plan gaps). The sector structure:

> 163. **FS131-I3i mid-job: `localSectors` proved** (message 2026-10-04; `fs131-w3b` at `d8a3177f`, pushed), in I3h's drafted shape unchanged — `HadwigerNelson.Plane.localSectors
> — source: plans/FS131-close-inventory.md

(the item continues with what it exports). **First steps, in order:** (1) merge `main` into `fs131-w4` (waves 1 and 3, Lebesgue's covering theorem; run
`tools/fs131_qa1_dupes.py` and rename or delete this branch's colliding names — `abs_dot_le` collides with Woodall's branch, not `main`; check what `main` brings);
(2) discharge `lebesgue_covering_square` in `Plane/SVMap` with one line — `:= LebesgueCovering.lebesgue_covering_square c hs F hF hcov hLR hBT`, importing
`Proofs.HadwigerNelson.Topology.LebesgueCovering` (update its `ARCHITECTURE.md` Imports cell), dropping the "disposition owed" sentence, citing the 1948
printing (Hurewicz–Wallman Thm IV 2, p. 42) — inventory item 151; (3) the leaves that read no sectors; (4) once `localSectors` is on `main` (I'll message
you), merge `main` again and write the bridge from its `IsSectorChart` to wave 4's `IsSector` and `hornSet` (inventory item 136: "every `S` with `IsSector v r S`
either has a cone of nonempty interior, or `S = hornSet v β κ₁ κ₂ r` with `κ₁ < κ₂`, and the number of sectors is constant"), then the sector-reading leaves.
**The two plan gaps** (item 143): `lemmaL`'s sweep route needs a two-dimensional covering step; `lock` clause 1 needs N-E2 between the outer tile and a second
tile of colour `c′` — work each out, or message me if one needs new mathematics. **Before the gate**: `AeProperRegions` registered as a vacuity carrier (empty at
`k ≤ 1`; inventory item 144) and TS-T's Condition-5 clause kept in its carried form (item 142).

## Done means

1. **Your readback first**: check the three quotations against their sources; build the branch once as given (`f1f26a8a`) before editing anything; restate in
   your record what you may and may not change. Commit and push.
2. **The first steps above**, then the leaves, saving after each; no statement changed, no new `axiom`, no `native_decide`; re-price from your first two hard
   leaves.
3. **When the last leaf is proved**, the gate as § 14.4 gives it (with the axiom gate's IMPORTED section empty for this wave), then the landing: merge `main`,
   resolve collisions, re-run the gate, fast-forward `main` (`git push origin HEAD:main` from the worktree), never force-push.
4. **Your record** (you continue it), stages headed "Stage n — SAVED", "Theorems this phase proved"; drafts for the front page at the gate; the report in standing
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

## Amendment 2026-10-04 (Keryx) — `localSectors` landed; four items from the impossible-assumption audit

`localSectors` is on `main` (`0131aa59`; `plans/FS131-close-inventory.md` item 171): merge `main` before the sector-reading leaves. From FS131-QA2 (item 172),
before the gate, with no statement changed: an inhabitant of `IsCubicTrichromatic` and a non-degenerate one of `MIn` (`sevenBrickMap` at a brick corner — the
audit's record `plans/FS131-QA2-audit.md` § 2.2, `tools/fs131_qa2_brick.py`); a proved horn (the `bowtie_*` leaves early, or a two-colour cusp fragment as an
`IsHorn` model); `halfDisc.Simple`; `stuck_chain`'s docstring declaring that no model is expected, naming `n4_fin`. You still start no agents of your own
(standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
