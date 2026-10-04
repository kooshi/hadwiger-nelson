# Brief FS131-W3 — Woodall's chain re-planned on the repaired step 3 (NiceAt on a ball)

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-W3
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: apply FS131-E3's Lean drafts to Woodall's chain (the ∃-form definitions, the adapted statements, the inhabitants and the phantom adversary), re-prove the small adaptations, state the localized step 3 (E3-BALL) with its children and a plan per leaf, and write the implementer's handoff
  launch: now, beside FS131-I3i (`localSectors`, on `fs131-w3b`) and FS131-I2h (wave 2), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect, a draft of E3's that does not elaborate or does not serve, a missing lemma, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-W3.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate's inhabitant rule above all), and `RUNNING.md` § Building before your first build
  record: `plans/FS131-W-kernel-plan.md` (on branch `fs131-ww`; you add stages to it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww` (branch `fs131-ww`): the modules under `Proofs/HadwigerNelson/Plane/Woodall/` (definitions and statements as E3's drafts and this brief allow) and new ones beside them, supporting lemmas in the foundation modules (statements of other waves unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-W-kernel-plan.md`, `tools/fs131_w3_*.py`, `data/fs131/w3/`, `data/fs131/reports/FS131-W3.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. Woodall's chain — "maps need six" over arc maps, route M's link to `χ_m⁰(ℝ²) ≥ 6` — looked nearly proved in Lean until FS131-E3 found that its two
normal-form definitions were unsatisfiable on every real map: `SectorsAt` admits phantom horns, so a condition on *every* picture of a point fails wherever two
colours meet, and `aeMap6_normal`, `aeMap6_merged` and `false_of_four_le_sectors` held only vacuously (inventory item 158). E3 then repaired step 3 in the form
the chain reads — a picture in NiceAt form at every point of three or more colours in a ball — derived it (E3-BALL), found that no route avoids a modification,
and wrote Lean drafts for every changed definition and statement, with non-degenerate inhabitants. Your job is to put that into the chain and plan the
modification's proof.

## Why this job

`CLAUDE.md` § The aim, item 4, and `LEDGER.md` row 132 hold "maps need six for arc maps" at [hand]; the Lean chain is its check (Kooshi, inventory item 111).
Until the definitions are repaired, the chain's Lean theorems certify nothing about real maps.

## The statements

The ruling, as logged:

> 161. **FS131-E3 done, harness ≈ 470k** (report `data/fs131/reports/FS131-E3.md`; record `plans/FS131-E3-derivation.md`; commits `d21f2998`, `69660332`, `64fa012f`, `81e35157`):
> — source: plans/FS131-close-inventory.md

(the item continues there). E3's drafts are its record's § 4.1, which opens:

> def NiceAt (v : ℂ) : Prop :=
> — source: plans/FS131-E3-derivation.md § 4.1 Lean drafts

(the section gives `NiceAt`, `WoodallMerged K`, `WoodallNormal K`, the adapted `exists_woodallMerged … (R : ℝ)`, `NiceAt.normal`, `false_of_four_le_sectors`
with `hN : WoodallNormal (sphere v 1)`, `aeMap6_normal`, `aeMap6_merged`, `aeMap6`, and the inhabitants `halfDisc.NiceAt 0` and `threeSectorDisc : ArcMap 3`).
E3-BALL, E3-W, E3-NICE and E3-CHAIN are its §§ 3.2–3.4. Items 154–155 changed `SectorsAt`'s fifth clause to `v ∈ F.dom` (already on the branch).

## Done means

1. **Your readback first**: check both quotations against their sources; restate in your record what changes and what stays; build the worktree once as
   given (`f73cb1e3`). Commit and push.
2. **E3's drafts applied**, replacing the definitions and statements of the same names; every draft elaborates, or the one that does not comes to me with the
   error. The non-degenerate inhabitants and a **phantom-picture adversary** (a theorem that the old ∀-form fails on `threeSectorDisc`) in, so this class of
   vacuity cannot return unseen (`LEAN.md` § The gate's inhabitant rule).
3. **The small adaptations re-proved or planned**: `aeMap6_merged` on the picture it is handed; `false_of_four_le_sectors` taking the auxiliary point's normal
   picture from `hN`; whatever else reads the old forms. Where a proof breaks, either fix it (prove it, if quick) or state the child it needs. Decide whether
   `exists_sectorsAt` stays as a lemma or leaves the chain, with the reason.
4. **E3-BALL stated with its children** — the localized modification (finitely many merges in `closedBall 0 R`, each by E3-W), the new map's validity, plane
   domain, local finiteness and Condition 5 — each child a `sorry`ed lemma with a plan (route, Mathlib names confirmed with `#check`, an honest price for an
   Opus implementer). Say which children need `localSectors` (FS131-I3i is stating it on `fs131-w3b` from I3h's draft; its form is inventory item 136) and which
   do not.
5. **The obligation-modeling pass** (`debruijn-obligation-modeling`, invoked fresh) over the changed chain, and **the handoff** (§ 9.5's form) brought current.
   Build green with only `sorry` warnings; `tools/check_architecture.py` exit 0; `tools/fs131_w2_decls.py --check` clean.
6. Your stages appended to the record headed "Stage n — SAVED"; the report in standing rule 11's form.

## What is yours to decide

The representation, where E3's drafts can be improved without changing what they say (tell me), the order, and whether E3-BALL's modification should be
one theorem or a few. A statement E3 drafted that turns out false or vacuous is a finding: message me at once.

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`; on exit 75 wait ten minutes and retry. `lake env lean` is for iteration only. The worktree's `.lake/build` is its own
copy; never replace it with a symlink. Wave 3 and Lebesgue's covering theorem have landed on `main`; merge `main` into `fs131-ww` if you want their proofs
(wave 3's landed names collide with two of this branch's — `e_add_int_mul_two_pi`, `e_mul_conj_e` — rename or delete yours, item 142). Nothing with a `sorry`
reaches `main`. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
