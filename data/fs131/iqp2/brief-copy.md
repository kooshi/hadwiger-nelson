# Brief FS131-IQP2 — the p-adic plane to the gate: the ruled drops, five colours at 23, lint, the gate on one commit, the read-aloud and the drafts

*Written 2026-10-16 15:54 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IQP2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the successor implementer of the p-adic plane's Borel bound and values (ledger row 75, FS66-T7) — every leaf of the landing is proved and built by the job before you; you apply two ruled drops, prove five colours at 23 in place of four, run lint and the full gate on one commit with the statement comparison, read the head statements aloud against row 75, and draft the front page
  launch: now, in the same worktree and on the same branch as the job before you, with `main` merged in by me; beside you the three-colour implementer and the density planner in other worktrees, writing none of your files
  mission: § Why this job
  statements: § Where the work stands
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be kept or a gate step fails in a way no rule explains, and when the gate is green on one commit; the report goes to `data/fs131/reports/FS131-IQP2.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so, as the job before you did)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IQP2-padic.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/il5`, on its branch `fs131-kpa1` (at `ab6a2f288`: the previous job's last commit with `main` merged in — the collapse's Lean and the joined import blocks of `Proofs.lean`; `.lake/build` is a copy of `main`'s current build, so the first build recompiles the eight landing modules and the root): the modules under `Proofs/HadwigerNelson/PadicPlane/` and the three `Arith/FibreCert7*` modules (proofs; statements only as ruled below); `Proofs.lean`; `ARCHITECTURE.md`'s rows for these modules; the gate's inputs by the gate's own rules; `plans/FS131-IQP2-padic.md`; your scripts and logs under `data/fs131/iqp2/`; `data/fs131/reports/FS131-IQP2.md`. Front-file edits are drafted in your record, each naming its slot. Commit on your branch by explicit path; never push
  budget: about 400k by the harness's count, as guidance; save a stage after the drops and the value at 23, after the gate, after the read-aloud and after the drafts; hand back at a saved stage before about 500k

Hello. You arrive with the mathematics done but for one small improvement: every leaf of the landing is proved and the
build is green. What is left is that improvement and the check that makes it a landing.

## Why this job

The rule this project publishes by is Kooshi's W2 (`data/fs131/REQUEST-2026-10-13.md`): any finding of ours is
formalized. The p-adic bound answers a question posed in print (`[BardestaniMallahiKarai2017]` Question 1). The brief the
job before you worked to, `data/fs131/briefs/FS131-IQP1-padic.md`, holds the head statements as typed and its § Done
means steps 3–7, which still hold.

## Where the work stands

My log of the previous job's hand-back, with my rulings on its two findings:

> 1014. **FS131-IQP1 handed back at stage 4, past its line (logged 2026-10-16 15:53 UTC; "JOB FS131-IQP1 — STAGE 4 SAVED"; about 560k by the harness's count — not to be resumed; branch `fs131-kpa1` at `7244519f7`; record `plans/FS131-IQP1-padic.md` there).** Every leaf proved but the three at 23 (moved out, item 1002; kept in `data/fs131/iqp1/leaves-23.lean`); the build green (736 of 736 batches, 6 modules rebuilt, 0 with warnings, 21 m 12 s); its statement dump unchanged (56 the same, 0 changed, 0 missing, no planted control yet); FS-66's certificate at 7 checked by three `decide +kernel` theorems, no `native_decide`; at 23 the kernel states `4 ≤ χ_Bor(ℚ₂₃²) ≤ 8`. Its findings: `hk` in `PadicPlane.exists_levelEmbedding` and `hpP` in `charSum_levelOne_of_unitCircle` unread (referenced by `have _ := h`); `5 ≤ χ_Bor(ℚ₂₃²)` about 50–70 lines away through the public `CircleCos.circleCos_ge`; two `LEAN.md` lines; the Values docstring and its `ARCHITECTURE.md` row corrected to what is proved. **The harness refused its report file**; I filed the hand-back's text verbatim at `data/fs131/reports/FS131-IQP1.md` on its branch (`dbfaf1d0c`'s parent), its first line, the request, left out; a tool friction to watch. **My receipts:** the five commits exist; `grep -cw sorry` reads 0 in the eight landing modules; `build2.log` "build: OK — 736 of 736 batches". `main` merged into the branch (`dbfaf1d0c`; `Proofs.lean`'s import blocks conflicted and were joined, main's then the branch's; `check_architecture` PASS) and `main`'s build copied in. **Rulings, four parts each.** (1) *Drop `hk` and `hpP`*, call sites updated, listed as ruled changes; alternative, keep them referenced — declined, items 993, 998, 1012; medium-high. (2) *Take `5 ≤ χ_Bor(ℚ₂₃²)`* in the successor, `five_le_borelChromaticNumber_padicPlane_twentyThree` in place of `four_le_…` (a public theorem new on this branch, not on `main`); alternative, land `4 ≤` and leave five for later — declined: about 60 lines for the better value; if it runs far over, `four_le` stays and the record says so; medium-high. **Next:** FS131-IQP2 from stage 5.
> — source: plans/FS131-close-inventory.md

And the ruling on the three leaves at 23 that wait on a search:

> 1002. **FS131-IQP1: three leaves at 23 wait on the certificate, not one (logged 2026-10-16 14:42 UTC; by message).** Besides `six_le_borelChromaticNumber_padicPlane_twentyThree`, `fibreShareBound_twentyThree` (the certificate itself) and `unitQuadrance_zmod_twentyThree_pow_not_colorable_five` (needs `5U/529 < 1`) need `U < 105.8`; neither Weil's bound (`5 · 0.2855 > 1`) nor the `κ` form at `κ = 7.97` (`5κ/(24 + κ) = 1.25 > 1`) reaches them. **Ruling, four parts.** *Choice:* all three leave the landing's modules with their statements and plans kept verbatim in the record, no other statement touched; the new closed theorem `four_le_borelChromaticNumber_padicPlane_twentyThree` (from `le_borelChromaticNumber_padicPlane 23`: `⌈1 + 24/(2√23)⌉ = 4`) is added beside `…_twentyThree_le_eight`; if the `κ` form's character-sum bound at 23 (`κ ≈ 7.97`, giving `⌈4.01⌉ = 5`) is a finite check the job prices as cheap, `5 ≤` is the better lower end, its call. *Alternative weighed:* keep the two other leaves with `sorry` on a side module — declined: nothing with a `sorry` reaches `main`, and the record keeps them whole. *Why:* item 999's ruling (2) meant every leaf that waits on search request 26. *Confidence:* high. **Credited:** the job found the two leaves my ruling missed.
> — source: plans/FS131-close-inventory.md

Its record is `plans/FS131-IQP1-padic.md` (§ What is left, for a successor, lists the remaining steps in order); its report is
`data/fs131/reports/FS131-IQP1.md`; the leaves at 23 are kept in `data/fs131/iqp1/leaves-23.lean`. The plan is
`plans/FS131-KPA1-padic-plan.md`. The cosine bound at 23 is in `Proofs/HadwigerNelson/Arith/CircleCos.lean`.

## Done means

1. **Stage 1 — the readback**: check the two quotations above; restate in your record what is left and the order.
2. **The ruled changes**: drop `hk` from `PadicPlane.exists_levelEmbedding` and `hpP` from
   `charSum_levelOne_of_unitCircle`, their call sites updated; prove `five_le_borelChromaticNumber_padicPlane_twentyThree`
   from `CircleCos.circleCos_ge` through `le_borelChromaticNumber_of_charSum`, in place of `four_le_…` (or keep `four_le_…`
   and say why, if it runs far over its 50–70 lines); the build green; `lake lint` (a saved stage).
3. **The gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under `data/fs131/iqp2/`, its logs
   there), every count change explained against `main`'s last gate (`data/fs131/ico2/gate/`, the collapse's, gated on
   `7c72b9bf7`, unless I tell you another landed first); the statement comparison against
   `data/fs131/iqp1/statements-before.txt` (the dumper `data/fs131/iqp1/lean/StatementDump.lean`, the three `FibreCert7`
   modules added to its list; a comparator shaped like `data/fs131/ico2/statements.py`, with a planted control watched),
   the ruled changes listed (the three leaves at 23 moved out, the two drops, `four_le` → `five_le`, the new helpers); the
   vacuity scan's new sites with each structure hypothesis's inhabitant named (the previous record names one: the colouring
   binders at `p = 3`, `k = 3`); `#print axioms` of every head statement (expected: the bound by characters on the standard
   three; the Weil form, the unboundedness, the value at 3 and the lower end at 23 with `StandingFive.kloosterman_bound` or
   on the standard three as the proofs read it — the record says which; the values at 7, 11, 19 on the standard three).
   Commit any statement dump you add gzipped (inventory item 1011).
4. **The read-aloud** of each head statement against ledger row 75 and FS66-T7, in your record, with what is not claimed
   (the plain chromatic number of `ℚ_p²`; `6 ≤ χ_Bor(ℚ₂₃²)`; the level clause at 23).
5. **The drafts** for the front files (the planner's § 5.2–5.6 brought to what is proved, the two `LEAN.md` lines the
   previous report names among them), each naming its slot; the posers' question credited to them.
6. **The report**, in the standing rules' form.

## What is yours to decide

Every proof the changes need, and how the comparator is built. Not yours: any stored statement beyond the ruled changes.

## The machine

The laptop: 12 cores, 31 GB, shared with two other jobs. From inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 5 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`;
never `lake build`. When the slot waits, another job holds the memory; on exit 75 wait ten minutes and retry. `lake env
lean` is for iteration only. The worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` is a
tmpfs: keep what your record cites under `data/fs131/iqp2/`. Nothing with a `sorry` reaches `main`.
