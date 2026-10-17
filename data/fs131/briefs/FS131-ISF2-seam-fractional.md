# Brief FS131-ISF2 — the fractional chromatic number over ℚ(√3, √11): merge `main`, make one ruled docstring edit, and run the full gate once

*Written 2026-10-17 02:45 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-ISF2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the successor implementer of the fractional chromatic number over ℚ(√3, √11) — every proof is done and the build is green; you merge `main` into the branch, make one docstring edit I ruled, run the full gate once on one commit, and restate the count drafts
  launch: now, in the predecessor's worktree and on its branch; no other agent is running
  mission: § Why this job
  statements: § Where the work stands
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once if a merge conflict is not a gate input's list (a proof or a statement), or a gate step fails in a way no rule explains, and when the gate is green on one commit; the report goes to `data/fs131/reports/FS131-ISF2.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-ISF2-seam-fractional.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/kcs1`, on its branch `fs131-ksf1` (at `39a5dd2a4`; its `.lake/build` is the predecessor's green build of that commit): the merge of `main` (at `790c060c6` or later) and its conflict resolutions; the module docstrings (only) of `Proofs/HadwigerNelson/RationalFour/Compulsion.lean` and `Proofs/HadwigerNelson/RationalFour/Forbid.lean`, as ruled; the gate's inputs by the gate's own rules (`scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt`'s header, `Proofs.lean`, `ARCHITECTURE.md` rows); no proof or stored statement; `plans/FS131-ISF2-seam-fractional.md`; your scripts and logs under `data/fs131/isf2/`; `data/fs131/reports/FS131-ISF2.md`. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard: if it refuses a commit, reword what it names and commit again, never `--no-verify`
  budget: about 250k by the harness's count, as guidance; save a stage after the merge and after the gate; hand back before about 350k

Hello. The mathematics here is done and checked by the build: the kernel holds that the fractional chromatic number of
the plane over ℚ(√3, √11) is 4, through a certificate it checks in full. What is left is making the gate hold on the tree
that will land, after another landing went in beside it.

## Why this job

The predecessor's hand-back and my ruling:

> 1092. **FS131-ISF1 handed back at stage 5, past its line: every leaf proved, the gate left (logged 2026-10-17 02:44 UTC; about 744k by the harness's count — not to be resumed; record `plans/FS131-ISF1-seam-fractional.md`, report `data/fs131/reports/FS131-ISF1.md`; branch `fs131-ksf1` at `39a5dd2a4`, worktree `kcs1`).** `Instances/SeamFractional`'s two leaves proved, so its three heads stand — `fractionalChromaticNumber_seamPlane` (`χ_f(ℚ(√3, √11)²) = 4`), `finIndepRatio_seamPlane`, `iSup_fractionalChromaticNumber_seamPlane` — over `Plane/G27/` (four hand-written modules, `Check`, `Sound`, `Law`, `Bound`, and 47 generated ones, 47.3 MB, the largest 9.0 MB, from `tools/fs131_kfs1_g27.py`, whose `--check` refuses a planted digit): `[MatolcsiEtAl2025]`'s certificate for `G27` checked in full by the kernel (16,829 congruence rows, 28,496 weights, every independent set by a residual DFS), read against an invariant random independent set — no blow-up, no measure rigidity; build green, zero warnings, zero `sorry`; stored statements unchanged (7 SAME, 3 plants fired). Two tool defects found and fixed (the literal-hash collision; deep recursion on a closed `2¹⁰⁰⁰` offset); the plan's `X23`-scan route replaced (974M mask tests against 2.76M list elements). Generalization (PAS2's `χ_gf ≤ 4` over the field) priced, not stated: about 40 lines to define `χ_gf`, 100–150 for the bound. **My receipts:** the commits exist; `data/fs131/isf1/head-axioms.txt` lists the heads on `[propext, Classical.choice, Quot.sound]` (I print them myself at the landing); `sorry` absent from `Plane/G27/` and `SeamFractional`. **Ruling, four parts:** *Choice:* a successor (FS131-ISF2) runs what is left, from the record's § 5.3 — merge `main` (rank 7's `RationalFour` in it; baseline `data/fs131/irf1/gate/`), item 1089's docstring amendment in the merged tree, the full gate on one commit, the count drafts. *Alternative:* resume FS131-ISF1. *Why:* it is past its line (the replacement rule). *Confidence:* high. **Its slip (budget):** past the brief's 550k line, stopped at a saved stage — not a slip by the rule on budgets; recorded only for the replacement. **Credited:** the residual DFS that made the certificate fit the kernel, and the two kernel-performance defects found and fixed. Running: none until FS131-ISF2.
> — source: plans/FS131-close-inventory.md

## Where the work stands

The landing that went in beside it, whose gate is your baseline, and my ruling on the two stale docstrings:

> 1089. **FS131-IRF1 handed back DONE; rational four-space at four colours lands on `main` (logged 2026-10-17 02:15 UTC; about 556k by the harness's count — not to be resumed; record `plans/FS131-IRF1-four-space.md`, report `data/fs131/reports/FS131-IRF1.md`).** All 36 `sorry`s proved (1,375 lines against the plan's 1,190); A3 stated and proved (`RationalFour.exists_equiv_coloring_add_eq_residue`); `[KubickiLehelMorayne2002]` Thm 4.3's rigidity proved as a corollary of A3 in the paper's p. 49 form (`RationalFour.coloring_eq_of_eqOn_isOpen`, 68 lines — item 1086's offer taken); the gate green on `6ab6248fe`: audit 11,806 records (11,106 clean, +63), vacuity `declarations=22802`, `sites=1477`, `witnessed=52` (+12, all witnessed), assumptions unchanged; the 59 skeleton constants' stored statements unchanged (five plants fired). **My receipts:** `#print axioms` of its eleven head and model statements, run by me on the gated build (`data/fs131/irf1-review/Ax.lean`): all on `[propext, Classical.choice, Quot.sound]`; the guard over every message and new blob of `main..fs131-kfs1` (14 commits, 97 blobs): 0 refusals; no history rewrite (cut from rewritten `main`). **Announcement rule (items 995, 1083): met** — merged as `cb4ed8079`, `main` equal to `6ab6248fe` in `Proofs/`, `Proofs.lean`, `scripts/` and the package files; the gated build moved into the main tree (the old one deleted), `build.sh`: all 2190 modules up to date. **Its held items, ruled (four parts as one):** *Choice:* (1) C7's row is **169**; (2) its drafts' "prior art: pending `[KubickiLehelMorayne2002]`" become FS131-PAS3's novelty line (`plans/FS131-PAS3-kubicki-lehel-morayne.md` § 3.4 item 5) in the ledger row and "not found in print (FS131-PAS2, FS131-PAS3)" elsewhere; (3) the two stale module docstrings are fixed inside FS131-ISF1's gated merge (told by message), since a docstring edit must pass a gate and that one is next; (4) its two `LEAN.md` lines are filed with the drafts. *Alternative:* land the docstrings stale until a later gate, or fix them now and re-gate this landing. *Why:* the next gate carries the fix at no extra cost; the public pages carry the right wording now. *Confidence:* high. **Filing next, by a Clerk:** drafts 1–6 and 8 of its record § Drafts for the front page, with the substitutions above; not draft 7 (the Proof Atlas, owed). **Mine after its merge:** the README row and section, `RESULTS.md`'s section, `CLAUDE.md`'s "In short:" clause. **Its slips (own):** `main` merged before the modules' commit (no file touched by both; the gate ran on the merged tree); the lint's negative control not run (two 19-minute walks). **Credited:** A3 and the printed theorem proved as its corollary, so the library holds both side by side. Running: FS131-ISF1 — 1 slot.
> — source: plans/FS131-close-inventory.md

The predecessor's record is `plans/FS131-ISF1-seam-fractional.md`: its § 5.3, "What is left", lists every step of the gate, the scripts it prepared
(`data/fs131/isf1/lean/AxiomsAll.lean` over `data/fs131/isf1/modules.txt` for the `scripts/Axioms.lean` block; its
statement comparator `tools/fs131_isf1_statements.py`), and § 5.2 its drafts. Follow it.

## Done means

1. **Stage 1 — the readback.** Check the quotations above against their source; restate in your record what the merge
   must keep, the docstring edit, and the order of work.
2. **The merge and the edit.** `git merge main` into `fs131-ksf1`; every conflict in a gate input resolved by keeping both sides'
   entries; `main`'s build files copied in only for modules that are `main`'s and not this branch's (the main tree's build
   is current for `main`); the docstring edit in both modules — "prior art: pending `[KubickiLehelMorayne2002]`" →
   "prior art: not found in print (FS131-PAS2, FS131-PAS3; `CLOSED-QUESTIONS.md` § 3)" — and nothing else in them; the build
   green under the slot; a saved stage.
3. **The gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under `data/fs131/isf2/`, its logs
   there); every count change explained against `main`'s last gate (`/home/kooshi/source/lean-dir/data/fs131/irf1/gate/` in the main tree; in yours after the merge); the statement comparison
   against the predecessor's dump (its `SeamFractional` and `G27` statements unchanged) and against `main`'s `RationalFour`
   statements (unchanged: the edit is docstrings only); the vacuity scan's new sites with each structure hypothesis's
   inhabitant named (`LEAN.md` § The gate); `#print axioms` of every head statement (expected: the standard three, no
   outside theorem). A saved stage.
4. **The drafts' counts**: the predecessor's front-page drafts (its record § 5.2) and the count lines for `CLAUDE.md`
   (§ The gate, § Trust ledger, "Last filed"), restated in your record with this gate's counts, each naming its slot; for
   C14's novelty line, FS131-PAS2's line as the predecessor quoted it.
5. **The report**, in the standing rules' form.

## What is yours to decide

How you resolve each gate-input conflict, as long as every landing's entries stand. Not yours: any proof or stored
statement. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

The laptop: 12 cores, 31 GB; no other job builds. From inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 10 -- env MEMMAX=16G BATCH=4 ./scripts/build.sh`;
never `lake build`. The generated `G27` modules need up to about 5 GB each. On exit 75 wait ten minutes and retry. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Keep every working file under
`data/fs131/isf2/` (standing rule 2). Nothing with a `sorry` reaches `main`.
