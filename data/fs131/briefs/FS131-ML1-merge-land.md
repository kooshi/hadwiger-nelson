# Brief FS131-ML1 — MERGE lands: `main` merged into `fs131-w4mm`, `exists_merge` and `exists_merge_aux` restored in ruling 269's form, the full gate, and `main` fast-forwarded

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-ML1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: MERGE's landing implementer — merge `main` (wave 4 and Woodall on it) into `fs131-w4mm`, restore `exists_merge_aux` and `exists_merge` in ruling 269's form over `MergeMove`, run the full gate on one commit, and fast-forward `main`
  launch: now, beside FS131-I5o (wave 5's non-`Terminal` lane, on `fs131-w5`) and FS131-KL1 (the limit constructions' planner, on `fs131-w5c`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a gate check that will not go green for a reason outside this brief, a conflict that is more than restoring the two declarations and keeping `main`'s side elsewhere, a statement the merge or the gate shows false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-ML1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate above all), and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IMM-implementation.md` (MERGE's record on branch `fs131-w4mm`; you continue it from Stage 13, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm` (branch `fs131-w4mm`): the merge's files; `Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean` and `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` for the two restored declarations, `Contact`'s header line and the identical-copy deletions (no other statement or definition changes); `Proofs/HadwigerNelson/Plane/ValidMap/MergeMove.lean` for the rename and the deletions; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean`, `scripts/vacuity-controls.lean`, `scripts/vacuity-baseline.txt`, `scripts/axioms-selftest*` (the controls' expected counts, if your state moves them), `plans/FS131-IMM-implementation.md`, `tools/fs131_ml_*.py`, `data/fs131/ml/`, `data/fs131/reports/FS131-ML1.md`; then `main`, by fast-forward only
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are landing MERGE, the third of wave 4's simplifying moves. Wave 4 landed on `main` without it (nothing read it then); FS131-I5l found that wave 5's
last two `Terminal` leaves need it, so wave 5's landing now waits for MERGE's. Four implementers proved it on `fs131-w4mm`: `MergeMove` holds no `sorry`, and
`exists_merge_aux` rests on exactly the standard three. You bring it through the gate and onto `main`.

## Why this job

A result counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). What the last
implementer handed back, and the rulings that launch you:

> 367. **FS131-IMM4 done: MERGE is proved** (harness ≈ 472k by the task notice; record `fs131-w4mm`'s `plans/FS131-IMM-implementation.md`, Stages 10–12; report
> — source: plans/FS131-close-inventory.md

> 368. **Rulings on IMM4's held items, and its slot.** (a) **`_hv1`: kept** — the type is unchanged and dropping the hypothesis would change the assembly's call
> — source: plans/FS131-close-inventory.md

How MERGE left wave 4, the colour clause it carries, and why wave 5 waits for it:

> 295. **Ruling: MERGE leaves wave 4; the freed slot goes to FS131-IX1 as ruled.** Choice: (a) wave 4 lands without `exists_merge` — at wave 4's merge-and-gate,
> — source: plans/FS131-close-inventory.md

> 269. **Ruling on item 268: `exists_merge` and `exists_merge_aux` take `F'.coloursAt v ⊆ F.coloursAt v` in place of the off-rim clause.** Choice: IM2 replaces the
> — source: plans/FS131-close-inventory.md

> 348. **Ruling on item 347: MERGE returns to wave 5's path; its continuation takes I5l's slot.** (a) **`exists_red` and `exists_terminal` may cite W-MERGE —
> — source: plans/FS131-close-inventory.md

Wave 4's landing, which you merge — its correction (1) is yours:

> 318. **WAVE 4 LANDED on `main`, held in the kernel** (FS131-G4, done, harness ≈ 462k; report `fs131-w4`'s `data/fs131/reports/FS131-G4.md`; record Stages 44–48;
> — source: plans/FS131-close-inventory.md

> 319. **Wave 4's filing, and the freed slot.** **Filed now** (this commit, from G4's drafts 1–2, 4–5, record "Drafts for the front page (FS131-G4)", draft 3
> — source: plans/FS131-close-inventory.md

How the last landing went, which this one follows:

> 326. **WOODALL'S CHAIN LANDED: FS131-WL1 done** (harness ≈ 484k by the task notice; record `fs131-ww`'s `plans/FS131-IW-implementation.md`, Stages 18–22 and
> — source: plans/FS131-close-inventory.md

> 327. **Woodall's landing counts filed** (Keryx, drafts 1, 2, 4, 5 verbatim): `CLAUDE.md` § Trust ledger (3633 clean, 3,654 records, FS131-WL1) and § The gate's
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. The two you restore, as they stand on `fs131-w4mm` at `c9623d04` (read each whole there):

> theorem exists_merge_aux (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean

> theorem exists_merge (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean

## Done means

1. **Your readback first**: check every quotation above against its source; read MERGE's record (Stages 1–12) and wave 4's landing record on `fs131-w4`
   (G4's Stages 44–48); build the branch once as given (`c9623d04`) before editing anything; open Stage 13 with what you may and may not change. Commit and push.
2. **The merge**: `main` into `fs131-w4mm`. Take `main`'s side for every wave-4 module (its RAY, SHAVE and every leaf are proved there; this branch's copies
   are stale), then restore `exists_merge_aux` in `Moves` with IMM's proof over `MergeMove` (and `Moves`' import of it) and `exists_merge` in `Contact` as a
   one-line citation of it, both statements byte-identical to the quotations above (check by script against `c9623d04`), with `Contact`'s header line naming
   it and the `ARCHITECTURE.md` mentions; add `MergeMove`'s row and import. On the branch's side apply `framePt → fromFrame` wherever `MergeMove` or the restored
   code uses it, and check that no `framePt` resolves to wave 2's `Plane/Slack.framePt` by accident. Run `tools/fs131_qa1_dupes.py` and delete identical copies
   (rename on the branch's side any that collide and differ); run a three-way statement check (WL1's `tools/fs131_wl_mergestmts.py`, which uses git's virtual
   base). Build. Commit.
3. **The full gate on one commit**: `./scripts/build.sh` with zero warnings (count them); `scripts/axioms.sh` clean (every MERGE record within the standard
   three; no `native_decide`) and `--self-test` green (fix the controls' expected counts if your state moves them, each shown red before and green after);
   `scripts/vacuity.sh` and `--self-test` green (register any new carrier `MergeMove` takes as a hypothesis under the procedure in `scripts/Vacuity.lean`'s
   docstring, each with a control numbered after the last on `main`); `tools/check_architecture.py` exit 0; zero `sorry` in `Proofs/`.
4. **The landing**: if `main` moved meanwhile, merge it again and re-run the gate on the merged commit (or, if the new commits touch only `plans/` and `data/`,
   say so with the `git diff --name-only` that shows it); then `git push origin HEAD:main` from the worktree — a fast-forward only, never a force-push.
5. **Drafts for the filing**, in your record under "Drafts for the front page (FS131-ML1)": the `CLAUDE.md` § Trust ledger sentence's counts, § The gate's two
   count lines, `scripts/vacuity-baseline.txt`'s header (which you write), a `GATE_CHANGES` entry for `tools/claude_md_fact_audit.py`, and `LEAN.md` § The gate's
   control count if it changed — each with the log line it comes from.
6. **Your record**, stages headed "Stage n — SAVED (FS131-ML1)", "Theorems this phase proved"; the report in standing rule 11's form, with `exists_merge`,
   `exists_merge_aux` and `MergeMove`'s count read from the gate's saved axioms log. Leave no background process running. Stopping at a saved stage, the gate red
   at a named check, is a good report.

## What is yours to decide

How each check is made green within this brief: how a conflict resolves (`main`'s side for wave 4's modules; both sides kept elsewhere unless they collide),
which copies are identical, and whether `MergeMove` brings a carrier the vacuity scan should track. If the gate shows a MERGE statement false or vacuous with no
remedy here, stop and message me with the declaration and what the check showed. Three failed attempts on one route is a dispatch to the companion your
identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work
it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. The gate scripts run the same way, as `LEAN.md` § The gate says. Up to two builds from different worktrees may run at
once when the slot admits them; three agents are building, so on exit 75 wait ten minutes and retry. The worktree's `.lake/build` is its own copy; the merge
brings many changed modules, so the first build after it is long. Never replace the build with a symlink. Nothing with a `sorry` reaches `main`.
