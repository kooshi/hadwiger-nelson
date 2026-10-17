JOB FS131-ISF2 — DONE   harness≈395k (own≈330k)
RESULT: The fractional chromatic number over ℚ(√3, √11) passes the full gate, green on one commit, `31df25939` (branch `fs131-ksf1`, worktree `kcs1`, `main` merged at `1c8e07920`). Every step exit 0: 0 `sorry`; `dupnames` and its self-test (15 controls); the audit and its self-test; vacuity and its self-test (65 controls); assumptions and its self-test (33 checks); the architecture check; lint (14 linters passed).
RESULT: The merge and the edit changed no stored statement. All 625 constants of the nine touched modules are byte-identical across the build (internal ones included). `SeamFractional` and the four hand-written `G27` modules equal FS131-ISF1's dump (423 of 423). The four `RationalFour` modules equal FS131-IRF1's dump (202 of 202). The build rebuilt exactly 3 modules (`RationalFour.Compulsion`, `RationalFour.Forbid`, the root) with 0 warnings; the other 2,266 `.olean` files are byte-identical.
RESULT: Kernel theorems gated, as informal statement → declaration (all on `[propext, Classical.choice, Quot.sound]`, no outside theorem, no hypothesis):
  - `χ_f(ℚ(√3, √11)²) = 4`, read against `[CranstonRabern2015]`'s "What is the fractional chromatic number of ℚ(√3,√11) × ℚ(√3,√11)?" → `HadwigerNelson.Instances.SeamFractional.fractionalChromaticNumber_seamPlane`;
  - the finitary independence ratio is 1/4 → `finIndepRatio_seamPlane`;
  - the finite subgraphs' fractional chromatic numbers have supremum 4 → `iSup_fractionalChromaticNumber_seamPlane`;
  - the certificate's bound → `G27.density_le_quarter` and `G27.cert_bound`;
  - `G27.good_root`, the kernel's DFS, is on `[propext, Quot.sound]`.
All are FS131-ISF1's proofs. This job proved no theorem.
RESULT: Counts against main's last gate (`data/fs131/irf1/gate/`), each explained by name in the record § 3.3:
  - Audit: 12,291 records (+485, all CLEAN): 11,436 clean (+330), 730 axiom-free (+155), 120 imported, 5 purchases. All of main's 11,806 prints are unchanged.
  - Vacuity: `declarations=23377` (+575 = 485 records + 55 `eq_n` lemmas + 11 matchers + 24 proof-term matchers). `refutations-skipped=247` (+1: `G27.conj_indep`, a set membership that the scan's reducing telescope reads through to `→ False`; it refutes nothing, and its hypothesis is inhabited by `fun _ => false`). Sites and every site row are unchanged.
  - Assumptions: the nine counts and all 1,954 rows are unchanged.
RESULT: Two negative controls were watched beyond the self-tests.
  - Lint (FS131-IRF1 left it unrun): a plant in `RationalFour/Forbid` gave exit 1, with exactly one `unusedArguments` error naming the plant. After the restore the lint is green again and every `.olean` is byte-identical to the gated build.
  - Audit-block generator: four plants, all reported, plus a control that stops the run when the printer cannot show an import (BLIND).
RECORD: plans/FS131-ISF2-seam-fractional.md (on branch fs131-ksf1)   COMMITS: cac318c02 6b9fc22ef d3d9afafa 6e80f1748 31df25939 784b8cb9c 8e8495386 1c5040d1b (and this report's)
INVENTORY: result — the full gate is green on 31df25939, every count reconciled — record § 3
INVENTORY: result — the merge and the docstring edit moved none of 625 stored constants; the build rebuilt 3 modules, 0 warnings — record § 2
INVENTORY: result — ruled docstring edit applied in RationalFour/Compulsion and Forbid (item 1089); code identical to main once block comments are removed (plant fires) — record § 2.2
INVENTORY: result — the lint's negative control watched red, then restored with the build byte-identical — record § 3.5
INVENTORY: correction owed — `Instances/SeamFractional`'s module docstring still says "prior art: FS131-PAS2's to find"; a proposed text is in the ruling's form — record § Drafts, held item
INVENTORY: question for another lane — drafts for CLAUDE.md (§ The gate, § Trust ledger, Last filed), LEDGER.md row 71 and § B FS56-T3 (both to [kernel]), CLOSED-QUESTIONS.md § 1.6, C14's novelty line (quoted verbatim), BIBLIOGRAPHY.md, KERNEL-HOLDS.md, the Proof Atlas, LEAN.md (six lines) — record § Drafts for the front page
INVENTORY: tool defect — the shared gate runner (`data/fs131/clone1/run-gate.sh`) passes no previous log to `gate_report.py`, so each digest reports "no previous complete run" and makes no row comparison; done by hand against main's receipts here — record § 3.3, `data/fs131/isf2/receipt-compare.out`
INVENTORY: slip — a parallel `( … ) & ( … ) & wait` call lost the assumptions run's log redirect ("No such file or directory" on an existing directory; mechanism not read). The run was redone alone, and the vacuity run of the same call finished clean — record § 3 (the pre-gate scans, `data/fs131/isf2/pre/`)
HELD FOR THE COORDINATOR: whether to fix `SeamFractional`'s stale novelty clause before the landing. It needs a gate: about 14 min of build (only SeamFractional and the root recompile) plus the 14-min gate. Alternatively land it stale and fix it at the next gate, as item 1089 did for RationalFour.
HELD FOR THE COORDINATOR: this job went past the brief's 350k hand-back line by the harness's count, ending at a saved stage. Its own work is done, so nothing is left for a successor beyond the held docstring.
HELD FOR THE COORDINATOR: the worktree's `.lake/build` is the gated build of `31df25939`, so the landing can move it in (FS131-LU1's recipe). Since the gate, only `plans/` and `data/` have changed on the branch.
