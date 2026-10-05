# Brief FS131-G4 — wave 4 lands: the three moved-out declarations deleted, the tools and carriers settled, the full gate, and `main` fast-forwarded

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-G4
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 4's landing implementer — on `fs131-w4` at `71cca146`, remove the three declarations that left the wave, settle the gate's open items, run the full gate on one commit, merge `main` in, re-run the gate, and fast-forward `main`
  launch: now, beside FS131-I5d (wave 5, on `fs131-w5`), FS131-IP2 (the planar chain, on `fs131-w5p`) and FS131-IX1 (the crossing lemma, on `fs131-w5x`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a gate check that will not go green for a reason outside this brief, a statement the gate shows false or vacuous with no remedy below, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-G4.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate above all), and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I4-implementation.md` (wave 4's record on branch `fs131-w4`; you continue it from Stage 44)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4` (branch `fs131-w4`): wave 4's modules (`Proofs/HadwigerNelson/Plane/StuckChain.lean`, `Proofs/HadwigerNelson/Plane/SVMap.lean` and everything under `Proofs/HadwigerNelson/Plane/ValidMap/`) only for the three deletions, the `framePt` rename and its uses, and whatever the vacuity step needs (inhabitants, docstring lines); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean`, `scripts/vacuity.sh`, `scripts/vacuity-baseline.txt`, `scripts/axioms-controls.txt`, `tools/fs131_k4_decls.py`, `tools/fs131_g4_*.py`, `data/fs131/g4/`, `plans/FS131-I4-implementation.md`, `data/fs131/reports/FS131-G4.md`; and `main` itself, by fast-forward only, at the end. Not `CLAUDE.md`, `LEAN.md` or `tools/claude_md_fact_audit.py` (mine; you draft their lines)
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are landing wave 4 of the Lean backlog — the valid-map machinery that the frontier's local exclusion rests on: the moves on a valid map (SHAVE,
MERGE-RAY), the stuck-vertex structure, the unit-arc steps, the bends, and the foundations under them. The milestone, FS-131, turns this project's
hand-derived results into kernel-checked ones; waves 1, 2 and 3 are on `main`. Fourteen implementers proved wave 4's leaves on `fs131-w4` and its side
branches; the last, FS131-I4n, merged the moves branch and proved the bends, and left exactly three `sorry` on the branch — all three in declarations that
have been ruled out of wave 4, because nothing in the wave reads them. You take the branch through the gate and onto `main`.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 4's landing
gates Woodall's chain (which waits only on wave 4's statements) and wave 5. The ruling that launched you:

> 297. **Ruling: I4n's slot → FS131-G4, wave 4's landing.** Choice: one Opus implementer on `fs131-w4`: delete `bend_away` (`UnitArc`), `exists_merge` (`Contact`)
> — source: plans/FS131-close-inventory.md

(the item continues there: every task of this job, the fast-forward by you, and what follows). The hand-back you start from:

> 296. **FS131-I4n done** (harness ≈ 563k; record `fs131-w4`'s `plans/FS131-I4-implementation.md`, Stages 41–43; report `data/fs131/reports/FS131-I4n.md`; commits
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. What leaves the wave, and why:

> 295. **Ruling: MERGE leaves wave 4; the freed slot goes to FS131-IX1 as ruled.** Choice: (a) wave 4 lands without `exists_merge` — at wave 4's merge-and-gate,
> — source: plans/FS131-close-inventory.md

> 291. **Ruling on item 290: `bend_away` gains the domain hypothesis; `bend_away_whole` is proved directly; `bend_away` leaves wave 4 if it is not done when MERGE
> — source: plans/FS131-close-inventory.md

(`bend_away`'s repaired statement is kept on branch `fs131-w4ba` at `71cca146`; MERGE's on `fs131-w4mm`; delete each declaration with its docstring and its
`#print axioms` record, and nothing else; a header list line that names it — `Contact`'s "* **FS110-W-MERGE**: `exists_merge`." — goes too). The gate's open
items, each ruled earlier:

> 281. **Rulings on I4l's held items, and its slot.** (a) `flankQ_upper`'s `hcN` and `flankQ_lower`'s `hcS` renamed `_hcN`, `_hcS` (ruling 185's reasons: a binder
> — source: plans/FS131-close-inventory.md

(its part (b): `tools/fs131_k4_decls.py` learns `_root_.` names, with a control).

> 271. **Wave 2's filing and its held items.** **Filed now** (this commit, from I2n's drafts 1–4, record "Drafts for the front page (FS131-I2n)"): `CLAUDE.md`
> — source: plans/FS131-close-inventory.md

(it continues there: wave 4 renames its `HadwigerNelson.Plane.framePt` (`Plane/ValidMap/Basic` l. 44), which collides with wave 2's in `Plane/Slack`
(`data/fs131/i2n/dupes.log`); and the second of waves 2 and 4 to land merges the first's vacuity carriers — that is you).

> 260. **Ruling on item 259: I2n applies its fix on `fs131-w2`.** Choice: accept I2n's four edits to `scripts/axioms-controls.txt` — (1)/(2) counts and digest
> — source: plans/FS131-close-inventory.md

(at wave 4's landing the axiom self-test is re-run, since wave 4's counts differ).

> 252. **Ruling: the sides clause becomes form (b), in `stuck_structure` and in `stuck_structure_ua`.** Choice: (b), the point form outside the parabola. Alternative
> — source: plans/FS131-close-inventory.md

> 266. **FS131-IC5 handed back, done** (harness ≈ 510k; report `fs131-w4c`'s `data/fs131/reports/FS131-IC5.md`; commits `9988cbb8`, `f3a5c724`, `f975677b`).
> — source: plans/FS131-close-inventory.md

(both carry a vacuity note: `stuck_structure`, `stuck_structure_flanks` and `stuck_pole_N` take structure hypotheses with no model in the library — build one, or
write `VACUITY DECLARED:` with the theorem that empties the class, under the procedure in `scripts/Vacuity.lean`'s docstring).

> 144. **FS131-QA1 done, harness ≈ 380k** (report `data/fs131/reports/FS131-QA1.md`; record `plans/FS131-QA1-audit.md`; commits `1905567e`, `bbee15f0`, `e7a91c31`, `2153ea8e`,
> — source: plans/FS131-close-inventory.md

(its part (b): the vacuity scan tracks `CPColouring` and `AeProperRegions`, done by FS131-T3; check that wave 4's own carriers are registered beside them).

The plan's landing section:

> 1. Every `sorry` of the five modules gone except `lebesgue_covering_square` (FS131-LEB's); the full gate green on one commit in the worktree:
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md 14.4 How the wave lands

> 3. The branch fast-forwarded onto `main` (Keryx's step, after reading the saved gate logs). Nothing with a `sorry` reaches `main`.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md 14.4 How the wave lands

(step 3 is changed by item 297: you fast-forward, as wave 2's implementer did.) How wave 2 landed, which this landing follows:

> 270. **WAVE 2 LANDED on `main`, held in the kernel** (FS131-I2n, done, harness ≈ 330k; report `fs131-w2`'s `data/fs131/reports/FS131-I2n.md`; `origin/main`
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read the wave-4 record's last three stages and plan § 14; build the branch once as
   given (`71cca146`) before editing anything; open Stage 44 with what you may and may not change. Commit and push.
2. **The deletions** (three declarations, their docstrings, header lines and axiom records), the **`framePt` rename** with every use, and **`tools/fs131_k4_decls.py`**
   taught `_root_.` names (a planted control watched red, the faithful run green). Build. Commit.
3. **The carriers and the vacuity notes**: wave 4's carriers registered in `scripts/Vacuity.lean` beside wave 2's (on the merged tree, keeping both), each with
   its control; the three structure classes of items 252 and 266 inhabited or declared; every change in `sites` and in the verdict counts explained in the record.
4. **The full gate on one commit** in the worktree: `./scripts/build.sh` with zero warnings (count them — `scripts/build.sh` exits 0 with warnings); `scripts/axioms.sh`
   clean (every wave-4 record on the standard three or fewer; no `native_decide`) and `--self-test` green (item 260: fix the controls' expected counts if wave 4's
   state moves them, each shown red before and green after); `scripts/vacuity.sh` and `--self-test` green; `tools/check_architecture.py` exit 0;
   `python3 tools/fs131_k4_decls.py --check` exit 0; zero `sorry` in `Proofs/` by `grep -cP '^\s*sorry\s*$|:= sorry|by sorry'`.
5. **The landing**: merge `main` into `fs131-w4` (run `tools/fs131_qa1_dupes.py` first and resolve every collision by renaming on wave 4's side), re-run the full
   gate on the merged commit, then `git push origin HEAD:main` from the worktree — a fast-forward only, never a force-push. If `main` moved meanwhile, merge again
   and re-run.
6. **Drafts for the filing**, in your record under "Drafts for the front page (FS131-G4)": the `CLAUDE.md` § Trust ledger sentence's counts, § The gate's two
   count lines, `scripts/vacuity-baseline.txt`'s header (which you write yourself), a `GATE_CHANGES` entry for `tools/claude_md_fact_audit.py`, and `LEAN.md`
   § The gate's control count if it changed — each with the log line it comes from. I file them.
7. **Your record** (continue it), stages headed "Stage n — SAVED", "Theorems this phase proved" (none expected, but list any child you add), every gate log's path;
   the report in standing rule 11's form. Stopping at a saved stage, the gate red at a named check, is a good report.

## What is yours to decide

How each gate check is made green within this brief: the new `framePt` name, the inhabitants, whether a class is inhabited or declared, how a merge conflict is
resolved (both sides kept unless they collide). If a gate check shows a wave-4 statement false or vacuous with no remedy here, stop and message me with the
declaration and what the check showed. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no
agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. The gate scripts run the same way (`scripts/axioms.sh` and `scripts/vacuity.sh` under the slot, as `LEAN.md` § The gate
says). Up to two builds from different worktrees may run at once when the slot admits them; four agents are building, so on exit 75 wait ten minutes and
retry. The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

## Amendment, 2026-10-05 — the vacuity note, and item 144 (b) (inventory item 304)

Your question by message is logged and ruled:

> 304. **G4's question, by message, and the ruling.** G4 (FS131-G4, mid-job): the vacuity note on `stuck_structure`, `stuck_structure_flanks`, `stuck_pole_N`
> — source: plans/FS131-close-inventory.md

(the ruling continues there). For you: the docstring notes on `stuck_structure` and `stuck_pole_N` (and `stuck_structure_flanks`, which has one), no marker,
no model; `AeProperRegions` registered IN as you proposed; `CPColouring` the same way if wave 4 carries it, else merged with `main`'s entry. Done means item 3
reads accordingly; everything else stands. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only
review work it knows exists).
