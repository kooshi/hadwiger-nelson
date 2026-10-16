# Brief FS131-ICO2 — finish the collapse: the last three modules, the build, the gate and the drafts

*Written 2026-10-16 13:23 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-ICO2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus
  role: the successor implementer of the collapse (ledger row 128's field equality) — the previous implementer proved four of its seven modules and the two approved edits and handed back at its budget line; you prove the last three, build, run the gate on one commit, and draft the front page
  launch: now, in the same worktree and on the same branch as the job before you; no other job is running
  mission: § Why this job
  statements: § Where the work stands
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be proved as typed (a statement defect goes back through me), and when the gate is green on one commit; the report goes to `data/fs131/reports/FS131-ICO2.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-ICO2-collapse.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/kcl1`, on its branch `fs131-ico1` (at `ebeb126d1`, clean): the modules under `Proofs/HadwigerNelson/Collapse/` (proofs; statements only as ruled below or by my word); `Proofs.lean`; `ARCHITECTURE.md`'s seven module rows; the gate's inputs by the gate's own rules; `plans/FS131-ICO2-collapse.md`; your scripts and logs under `data/fs131/ico2/`; `data/fs131/reports/FS131-ICO2.md`. Front-file edits are drafted in your record, each naming its slot. Commit on your branch by explicit path; never push
  budget: about 450k by the harness's count, as guidance; save a stage after each module, after the build, after the gate and after the drafts; hand back at a saved stage before about 550k

Hello. You arrive at a good point: the hard new mathematics of this module — thickness by Weil's bound, the mixing on
the compact factor, the colour dichotomy — is proved, and what is left is mostly a copy of landed modules at `k` colours
and the headline assembly, about 600 lines on the last job's own re-price.

## Why this job

The collapse is the statement that the plane over ℚ(√635087) needs exactly as many colours as the whole plane, proved
with no hypothesis of ours, on the two outside theorems the five-colour results already rest on. My log of the planner's
hand-back, with the announcement rule this landing must meet:

> 988. **FS131-KCL1 handed back: the collapse planned, its skeleton green (logged 2026-10-16 04:42 UTC; "JOB FS131-KCL1 — DONE"; about 560k by the harness's count — past its line, not to be resumed; branch `fs131-kcl1` at `dc2889c73`; record `plans/FS131-KCL1-collapse-plan.md` and report `data/fs131/reports/FS131-KCL1.md` there).** Seven modules under `Proofs/HadwigerNelson/Collapse/` build green through `build.sh` (16 m 3 s), every assembly proved over 48 `sorry` leaves: `Collapse.chromaticNumber_planeOver_sqrt635087` (`χ(ℚ(√635087)²) = χ(ℝ²)`, no hypothesis), `chromaticNumber_planeOver_eq_plane_of_thick` (every real number field whose stable primes are uniformly `c`-thick, `c < 1/5` — wider than row 128: no "totally real"), `chromaticNumber_planeOver_deGrey`, and with `[OAIMath2026]`'s import `6 ≤ χ(ℚ(√635087)²) ≤ 7`; the plan per leaf, about 3,270 lines; thickness at ℚ(√635087) by Weil's bound (`2√103/104 = 0.1952 < 1/5`) and a `decide` over 13 primes, no place list; R-U, I-C′, I-CPUP, I-MERGE and the random threshold off the path; drafted edits D-E1, D-E2 (about 140 lines, no stored statement moves), D-E3 (not recommended); the experience-modeling pass not run; a stub to mint (the four-colour chain as the `k = 4` case). **My receipts:** four commits on the branch; the three headlines' types read in `Collapse/Headline.lean` (ll. 70–71, 116–117, 165–166): `F635087 := SquareClass.fieldOfRadicands {635087}` and `FdG := …{3, 5, 7, 11}`, both sides `SimpleGraph.chromaticNumber` of `unitDistance ℂ`, the field's induced on `planeOver F`; `Thick F c := ∀ P : StablePrime F, ThickAt P c` with `ThickAt` the normalized character-sum bound at every level (`Collapse/Thick.lean` ll. 41–47); the plan's mutation audit names `c < 1/5` as load-bearing. **Rulings, four parts.** (1) *Launch the implementer now on the plan* (FS131-ICO1, in the planner's worktree, branch `fs131-ico1` = `fs131-kcl1` with `main` merged, `2e28d8a07`); alternative, wait for Kooshi — declined: W2 makes every finding of ours a formalization target and the handoff's next mathematics names this one; high. (2) *D-E1, D-E2 approved*, with a stop if their dependents' rebuild runs far over an hour; alternative, the 350-line copy — declined: the public two-sided bound is the better surface; medium-high. (3) *D-E3 declined* (it moves a landed statement); high. (4) *De Grey's field in the same job* (about 65 lines); high. (5) *The general form kept as typed*; a leaf needing total reality is a statement defect back to me; high. **Announcement rule, written now:** row 128's field clause is announced as held when the module passes the full gate on one commit merged into `main`, with the three headlines' axioms printed by me (the standard three, `positive_entropy_rigidity`, `kloosterman_bound`) and read aloud against the row. **Credited:** the answer that MR⁺ suffices, with the implication in Lean; thickness from Weil's bound alone; the general form's wider scope.
> — source: plans/FS131-close-inventory.md

## Where the work stands

> 993. **FS131-ICO1 handed back at stage 5, past its line (logged 2026-10-16 13:23 UTC; "JOB FS131-ICO1 — STAGE 5 SAVED"; about 600k by the harness's count — not to be resumed; branch `fs131-ico1` at `32da5595c`; record `plans/FS131-ICO1-collapse.md` there, § Stage 5 the list of what is left).** Proved: every leaf of `Collapse/Thick`, `Mixing`, `Colouring` and `Dichotomy` (28 of 48), each compiled with the lakefile's options in a scratch farm but not yet through `build.sh` or the gate — no kernel grade claimed; D-E1 (`StandingFive.norm_normOne_charSum_le`, `Arith/FloorPlanes`) and D-E2 (`Rigidity.norm_charSum_le_weil`, `Rigidity/ClassRatio`) through the build (25 dependents recompiled in 17 m 16 s, under the hour, so the edits stand). Left: `Collapse/Slice` (4 leaves), `Selection` (8), `Headline` (8), the experience pass, the build, merging `main`, the gate, the read-aloud, the drafts — about 600 lines on its re-price (the four modules done took about 1,540 lines against the plan's 2,450). **My receipts:** the six commits exist; the worktree is clean; `grep -cw sorry` reads 0 in the four modules, 4, 8 and 9 in `Slice`, `Selection` and `Headline`; both new theorems stand at `FloorPlanes.lean` l. 375 and `ClassRatio.lean` l. 2075. **Ruling, four parts, on its finding that my ruling 5 rested on a false premise** (the `omit [NumberField ↥F] in` at `Collapse.ThickAt.mono` does move that skeleton statement's stored type: it drops an instance binder the proof never reads). *Choice:* (a) keep the `omit`, here and at `Collapse/Slice`'s `measure_ne_eq_k`; the gate's statement comparison lists each as a ruled change (an unused instance binder dropped, the statement strictly more general), shown from the kernel's side as `LEAN.md`'s one-binder check asks. *Alternative weighed:* (b) `set_option linter.unusedSectionVars false in`, leaving the binder — declined: it keeps a hypothesis no proof reads in a public statement only so that a skeleton's dump stays still, and no statement on `main` moves either way. *Why:* the skeleton's statements are not yet anyone's citation. *Confidence:* high. **My slip, credited to the job:** ruling 5 called the `omit` statement-neutral without reading the stored type; the job read it. The two new Mathlib imports in `Collapse/Thick` go to the gate's statement comparison, as it says.
> — source: plans/FS131-close-inventory.md

The brief the previous job worked to is `data/fs131/briefs/FS131-ICO1-collapse.md`: its § The statements (the three
headlines and my rulings 1–4 and 6), § Done means and § The machine are part of this brief and still hold. Its ruling 5
is replaced by item 993's ruling above. Your starting list is § Stage 5 of `plans/FS131-ICO1-collapse.md` (each remaining leaf with its route);
the plan per leaf is `plans/FS131-KCL1-collapse-plan.md` § 4.3. Item 993's ruling, in practice: keep the committed
`omit` at `Collapse.ThickAt.mono`, use an `omit` at `Collapse/Slice`'s `measure_ne_eq_k` if it does not read
`[NumberField F]`, and list both in the gate's statement comparison as ruled changes, from the kernel's side.

## Done means

1. **Stage 1 — the readback**: check the quotations; check the branch against the previous record's stage 5; restate
   the order of work.
2. **`Collapse/Slice`, `Collapse/Selection`, `Collapse/Headline`**, in that order, a saved stage after each; then the
   experience pass the brief before you owes (`debruijn-experience-modeling`: the headline names and docstrings as a
   mathematician would cite them).
3. **The build** through `./scripts/build.sh` under the slot, with no `sorry` anywhere in `Proofs/HadwigerNelson/Collapse/`.
4. **Merge `main`**, then **the gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under
   `data/fs131/ico2/`), every count change explained against `main`'s last gate (`data/fs131/il5/gate/`, the named
   theorem's, gated on `113ca8ece`), the statement comparison against `data/fs131/ico1/statements-before.txt.gz` with the
   ruled changes listed, the vacuity scan's new sites with each structure hypothesis's inhabitant named, and
   `#print axioms` of the three headlines and of D-E1 and D-E2.
5. **The read-aloud** of each headline against `LEDGER.md` row 128, in your record.
6. **The drafts** for the front files (the planner's § 4.7 brought to what is proved), each naming its slot.
7. **The report**, in the standing rules' form.

## What is yours to decide

Every proof, helper lemmas, the order within each module. Not yours: any stored statement beyond the ruled `omit`s.

## The machine

The laptop, 12 cores, 31 GB, and no other job running: from inside the worktree,
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 10 -- env MEMMAX=16G BATCH=6 ./scripts/build.sh`;
never `lake build`; `lake env lean` for iteration only; keep what your record cites under `data/fs131/ico2/`.
