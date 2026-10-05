# Brief FS131-WL1 — Woodall's chain lands: `main` merged into `fs131-ww`, the brick-map model, the full gate, and `main` fast-forwarded

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-WL1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: Woodall's chain's landing implementer — merge `main` (wave 4 now on it) into `fs131-ww`, apply wave 4's `framePt → fromFrame` rename on the branch's side, delete the identical copies, add QA2-1's plane-map model, run the full gate on one commit, re-run it on the merged commit, and fast-forward `main`
  launch: now, beside FS131-IP4 (the planar chain, on `fs131-w5p`), FS131-I5g (wave 5, on `fs131-w5`) and FS131-E5 (an Ephodos re-derivation, in the main tree)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a gate check that will not go green for a reason outside this brief, a statement the merge or the gate shows false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-WL1.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate above all), and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IW-implementation.md` (Woodall's record on branch `fs131-ww`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww` (branch `fs131-ww`): the merge's files; the modules under `Proofs/HadwigerNelson/Plane/Woodall/` for the rename, the deletions of identical copies and the model (no definition or statement changes); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean`, `scripts/vacuity-controls.lean`, `scripts/vacuity-baseline.txt`, `plans/FS131-IW-implementation.md`, `tools/fs131_wl_*.py`, `data/fs131/wl/`, `data/fs131/reports/FS131-WL1.md`; and `main` itself, by fast-forward only, at the end. Not `CLAUDE.md`, `LEAN.md` or `tools/claude_md_fact_audit.py` (mine; you draft their lines)
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read the harness's count, not your own

Hello. You are landing Woodall's chain — "maps need six" over arc maps (FS106-WO, FS106-TW, FS106-AE-MAP6), route M's link to `χ_m⁰(ℝ²) ≥ 6` at five
colours. Four implementers proved it on `fs131-ww`: all five Woodall modules are free of `sorry`, and its chain theorems waited only on wave 4's statements
in `Plane/SVMap`. Wave 4 has now landed on `main` (gated green, `origin/main` at `60ff1843` or later). You bring the branch through the gate and onto `main`.

## Why this job

A result counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). What the last
implementer left, and the plane-map model QA2 asked for before this landing:

> 190. **FS131-IWd handed back at stage 17, harness 595k** (the agent's own figure "≈300" read low; report `data/fs131/reports/FS131-IWd.md` on `fs131-ww`; branch at
> — source: plans/FS131-close-inventory.md

> 172. **FS131-QA2 done** (report `data/fs131/reports/FS131-QA2.md`; record `plans/FS131-QA2-audit.md`; commits `a16446fd` … `bf15a62d`, and `d1777466`, a merge of
> — source: plans/FS131-close-inventory.md

(its ruling (a): the model is wanted before the landing). The model, as carried in the last Woodall brief:

> From FS131-QA2 (`plans/FS131-close-inventory.md` item 172, QA2-1): Woodall's normal forms are modelled only on small discs, never on a plane map. Before the chain's
> — source: data/fs131/briefs/FS131-IWd-woodall-merge.md

Wave 4's landing, which you merge — read its corrections owed, the first of which is yours:

> 318. **WAVE 4 LANDED on `main`, held in the kernel** (FS131-G4, done, harness ≈ 462k; report `fs131-w4`'s `data/fs131/reports/FS131-G4.md`; record Stages 44–48;
> — source: plans/FS131-close-inventory.md

> 319. **Wave 4's filing, and the freed slot.** **Filed now** (this commit, from G4's drafts 1–2, 4–5, record "Drafts for the front page (FS131-G4)", draft 3
> — source: plans/FS131-close-inventory.md

How the waves before you landed, which this landing follows:

> 270. **WAVE 2 LANDED on `main`, held in the kernel** (FS131-I2n, done, harness ≈ 330k; report `fs131-w2`'s `data/fs131/reports/FS131-I2n.md`; `origin/main`
> — source: plans/FS131-close-inventory.md

> 271. **Wave 2's filing and its held items.** **Filed now** (this commit, from I2n's drafts 1–4, record "Drafts for the front page (FS131-I2n)"): `CLAUDE.md`
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. The chain's three theorems, at `792434f0`:

> /-- **FS106-AE-MAP6** (arc maps): no map of the plane bounded by a locally finite family of segments and circular arcs, coloured with at most
> five colours, is almost-everywhere proper (no two interior points of one colour at distance exactly `1`; boundary points carry no colour).
> "Boundaries of measure 0" is not used (the row's last clause). The chain: steps 1–2 (free for arcs), step 3 localized to `closedBall 0 3`
> (`exists_woodallMerged`, FS131-E3's E3-BALL), strict step 5, step 6, E1-NO45, and a vertex from FS106-TS-T (FS131-E1's E1-MAPS6, E3-CHAIN);
> no step reads an angle equal to `π/3`, and nothing of Woodall's steps 7–8 is used. -/
> theorem aeMap6 (F : ArcMap k) (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) : False := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww/Proofs/HadwigerNelson/Plane/Woodall/Steps.lean

> /-- **FS106-AE-MAP6 under Condition 5** (no boundary meets a unit circle in infinitely many points): a corollary of `aeMap6`, Condition 5 unused
> (FS131-E1: "the Condition-5 form becomes a corollary"). -/
> theorem aeMap6_of_condition5 (F : ArcMap k) (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) (h5 : F.Condition5) : False := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww/Proofs/HadwigerNelson/Plane/Woodall/Steps.lean

> /-- **FS106-WO, Woodall's Theorem 6** ("R(b) ≥ 6", `[Woodall1973]` p. 195), for arc maps: the plane is not covered by five sets
> simultaneously divisible into regions by one map of the plane (each region in one set, every point in exactly one set) with no set realizing
> the distance `1` — a colouring `col` agreeing with the map's colour at its interior points and proper at every unit pair. A corollary of
> `ArcMap.aeMap6`: properness at every pair gives validity. -/
> theorem woodall_thm6 {k : ℕ} (hk : k ≤ 5) (F : ArcMap k) (hP : F.IsPlaneMap) (col : ℂ → Fin k)
>     (hdiv : ∀ x ∈ F.interiorPts, col x = F.col x) (hproper : ∀ x y : ℂ, dist x y = 1 → col x ≠ col y) : False := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww/Proofs/HadwigerNelson/Plane/Woodall/Steps.lean

They and every Woodall leaf keep their statements; after the merge they should print the standard three, since wave 4's `lemmaL`, `ts_t` and the rest are now
proved — if any still prints `sorryAx`, find which leaf it reaches and message me.

## Done means

1. **Your readback first**: check every quotation above against its source; read the Woodall record's last stages and `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww/plans/FS131-W-kernel-plan.md` § 14;
   build the branch once as given (`792434f0`) before editing anything; open your stage with what you may and may not change. Commit and push.
2. **The merge**: `main` into `fs131-ww`; on the branch's side apply `framePt → fromFrame` (wave 4's rename, item 318's correction (1)) in every Woodall file
   that uses it, and check that no `framePt` resolves to wave 2's `Plane/Slack.framePt` by accident; run `tools/fs131_qa1_dupes.py` and delete the identical
   copies (`abs_dot_le`, `dot_add_left`, `dot_e_e`, `isOpen_shadow`, and any other it finds identical), renaming on the branch's side any that collide and
   differ; run `tools/fs131_i4_mergestmts.py` three-way (no statement changed). Build. Commit.
3. **The model** (QA2-1): `sevenBrickMap.WoodallNormal univ` with `WoodallMerged univ`, or the `ArcMap 7` the amendment names, proved, with its docstring.
4. **The full gate on one commit**: `./scripts/build.sh` with zero warnings (count them); `scripts/axioms.sh` clean (every Woodall record within the standard
   three; no `native_decide`) and `--self-test` green (fix the controls' expected counts if your state moves them, each shown red before and green after);
   `scripts/vacuity.sh` and `--self-test` green — register Woodall's carriers under the procedure in `scripts/Vacuity.lean`'s docstring, each with a control, and
   number new controls after the last on `main` (wave 4's run to 50); `tools/check_architecture.py` exit 0; zero `sorry` in `Proofs/`.
5. **The landing**: if `main` moved meanwhile, merge it again and re-run the gate on the merged commit (or, if the new commits touch only `plans/` and `data/`,
   say so with the `git diff --name-only` that shows it); then `git push origin HEAD:main` from the worktree — a fast-forward only, never a force-push.
6. **Drafts for the filing**, in your record under "Drafts for the front page (FS131-WL1)": the `CLAUDE.md` § Trust ledger sentence's counts, § The gate's two
   count lines, `scripts/vacuity-baseline.txt`'s header (which you write), a `GATE_CHANGES` entry for `tools/claude_md_fact_audit.py`, and `LEAN.md` § The gate's
   control count if it changed — each with the log line it comes from.
7. **Your record**, stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form, listing every chain theorem with its
   axioms read from the gate's saved log. Stopping at a saved stage, the gate red at a named check, is a good report.

## What is yours to decide

How each check is made green within this brief: which copies are identical, how a conflict resolves (both sides kept unless they collide), the model's form,
and which Woodall carriers enter the vacuity scan. If the gate shows a Woodall statement false or vacuous with no remedy here, stop and message me with the
declaration and what the check showed. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no
agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. The gate scripts run the same way, as `LEAN.md` § The gate says. Up to two builds from different worktrees may run at
once when the slot admits them; several agents are building, so on exit 75 wait ten minutes and retry. The worktree's `.lake/build` is its own copy; the
merge brings many changed modules, so the first build after it is long. Never replace the build with a symlink. Nothing with a `sorry` reaches `main`.
