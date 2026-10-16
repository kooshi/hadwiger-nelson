# Brief FS131-IFR2 — the density form of the collapse: merge `main`, keep every landing's gate inputs, and run the full gate once

*Written 2026-10-16 21:36 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IFR2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the successor implementer of the density form of the collapse — every proof is done and gated on a commit that predates two landings; you merge `main` into the branch, reconcile the gate's input files so every landing's entries stand, and run the full gate once on that merge commit
  launch: now, in the predecessor's worktree and on its branch; beside you one implementer in another worktree (the ring of unit vectors), writing none of your files
  mission: § Why this job
  statements: § Where the work stands
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once if a merge conflict is not a gate input's list (a proof or a statement), or a gate step fails in a way no rule explains, and when the gate is green on one commit; the report goes to `data/fs131/reports/FS131-IFR2.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IFR2-density.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/kcl1`, on its branch `fs131-kfr1` (at `9e9739eb5`; its `.lake/build` is the predecessor's gated build of `e849029c3`): the merge of `main` (at `64a41b19a` or later) and its conflict resolutions; the gate's inputs by the gate's own rules (`scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt`'s header, `Proofs.lean`, `ARCHITECTURE.md` rows); no proof or statement; `plans/FS131-IFR2-density.md`; your scripts and logs under `data/fs131/ifr2/`; `data/fs131/reports/FS131-IFR2.md`; the counts in the predecessor's drafts brought to your gate, written into your own record. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard: if it refuses a commit, reword what it names and commit again, never `--no-verify`
  budget: about 250k by the harness's count, as guidance; save a stage after the merge and after the gate; hand back before about 350k

Hello. The mathematics here is done and checked; what is left is making the check hold on the tree that will land.

## Why this job

The landing rule is that `main`, after the merge, equals the gated commit in `Proofs/`, `scripts/` and the package files.
Two other modules landed after this branch's gate, and each edits the same gate inputs. My sequencing ruling:

> 1048. **FS131-IFR1, mid-job: the gate green on one commit, on the same stale base; the landings sequenced (logged 2026-10-16 21:01 UTC; by message; branch `fs131-kfr1`, gate on `e849029c3` over `main` at the p-adic plane).** Its words: every step exit 0; item 1034's two binders dropped; the statement comparison CLEAN with six plants fired; against the p-adic gate: records 11,572, clean 10,888, imported 104, axiom-free 575, `rests=145`, `declarations=22548`, skips 245, sites 1,458; the head statement `Collapse.finIndepRatio_planeOver_eq_localRatio` on the standard three and `Rigidity.positive_entropy_rigidity`. **My receipt:** `e849029c3` exists and does not contain the three-colour landing `8ebb647bc`. **Ruling, four parts.** *Choice:* land FS131-ICS1 first (it is already re-merging `main` and re-gating, item 1047); FS131-IFR1 finishes its read-aloud, drafts and report on its gated commit and hands back; then one short successor job (FS131-IFR2) merges `main` — with both the three-colour and five-colour landings — into `fs131-kfr1`, keeps every landing's gate-input entries, and runs the full gate once on that merge commit. *Alternative weighed:* both re-gate now over the three-colour landing, and the second to land re-gates again — declined: one of them would run the gate twice. *Why:* each landing edits the same gate inputs, so landings serialize; this order costs one extra gate run, not two. *Confidence:* medium-high.
> — source: plans/FS131-close-inventory.md

## Where the work stands

The predecessor's hand-back:

> 1050. **FS131-IFR1 handed back DONE: the density form of the collapse, gated on a stale base (logged 2026-10-16 21:10 UTC; about 900k by the harness's count — far past its line, not to be resumed; branch `fs131-kfr1`, worktree `.claude/worktrees/kcl1`, gate on `e849029c3`; record `plans/FS131-IFR1-density.md`, report `data/fs131/reports/FS131-IFR1.md` there).** 75 kernel theorems (54 on the standard three, 21 on declared imports): row 129's field clause at every number field with no MR hypothesis (`Collapse.finIndepRatio_planeOver_eq_localRatio`, on the standard three and `Rigidity.positive_entropy_rigidity`, its print); B-AMEN; `χ_f(F²) = 1/α_loc(F)`; the fractional collapse, with no hypothesis at ℚ(√635087) and de Grey's field; TJ's two clauses (the second by item 1021 (1)); ROUND through `m₁ ≥ π/(8√3)`; TF; a finite triangle-free six-chromatic unit-distance graph (`exists_finite_triangleFree_six_chromatic`, on all three imports); item 1005's splits and model in `Collapse/Headline`; `ratioAtMost_of_charBound` public. Its drafts D-1 to D-9 (record § 5); its list for the successor of every gate-input file it edits and how each block was made. **Its slip, and the defect behind it:** another job's read-aloud arrived in its record through a scratch file of the same name in the session's shared scratch directory; it replaced it before committing. *Fix (mine):* `plans/STANDING-RULES.md` rule 2 now sends every working file, however temporary, under the job's own `data/…` path, with the reason. **My review of the artifacts waits for FS131-IFR2's gate on the merged tree**, where I print the axioms. **Logged:** the ledger question it asks — whether the fractional collapse and the six-chromatic graph get a row of their own (at the landing); the prior-art debts are FS131-PAS1's statement 2. **Credited:** the job carried the module whole, about 2,650 lines, and wrote down exactly what its successor needs.
> — source: plans/FS131-close-inventory.md

The landing that went in just before you, whose gate is your baseline:

> 1055. **FS131-ICS1 handed back DONE; the five-colour fields land on `main` (logged 2026-10-16 21:35 UTC; about 730k by the harness's count — not to be resumed; record `plans/FS131-ICS1-class.md`, report `data/fs131/reports/FS131-ICS1.md`).** All 35 leaves proved; the full gate green on `960882257`, over `main` merged at the three-colour landing (`21a5fc591`); counts against the three-colour gate: audit 11,592 records (clean 10,914, imported 99), assumptions `rests=128`, vacuity `declarations=22566`, sites 1,465. **My receipts:** the commits exist; nothing under `Proofs/`, `scripts/` or the package files changed after the gate on the branch, nor on `main` since its merge; the branch carries no pre-rewrite commit; the guard over `main..fs131-kcs1`: two refusals, both in gzip-compressed statement dumps (`3cda622ff`, `856e831ed`), which decompressed read 0 refusals — a false match in compressed bytes; "tracked files modified after the pass: 1" is the job's own record, written during the run (its record l. 495); **I printed the axioms myself**: `SqrtFiveClass.five_le_chromaticNumber_planeOver_sqrt_iff` (for squarefree `m`: `5 ≤ χ(ℚ(√m)²) ↔ m % 168 ∈ {47, 143, 167}`), `…_sqrt_eq_five` and `SqrtTwentyThreeCbrtTwo.chromaticNumber_planeOver_sqrt23_cbrt2_eq_five` on the standard three, E–L and Weil; `Rigidity.five_le_localBound_iff` and `localBound_sqrt23_cbrt2_eq_five` on the standard three and Weil; `UpperHalf.localBound_le_unitQuadrance` on the standard three — as reported, read against row 123. **Announcement rule (item 1028): met** — merged as `3466820ee`, `main` equal to `960882257` in `Proofs/`, `Proofs.lean`, `scripts/` and the package files; the gated build moved into the main tree. **Filing:** its drafts D1–D14 with FS131-PAS1's held § 4.4 items 1 and 3, by a Clerk (next item). **Logged:** row 123's family wording — the kernel holds `χ = 5` where `d` is a square modulo 11 or 19; `L` is open at the other eight members ≤ 3000 (167, 887, 1055, 1319, 1823, 2351, 2735, 2903); `ratioAtMost_dyadic` keeps its own `f ≥ 6` branch beside the new lemma (a one-line cleanup owed); its slip (an invented hash in its record, corrected) logged as its own. **Credited:** the dichotomy with no list, the family with no field-by-field work, and the second gate run without complaint.
> — source: plans/FS131-close-inventory.md

On history and commits:

> 1025. **The unpushed history rewritten, and the privacy guard made a commit hook (logged 2026-10-16 18:38 UTC; Kooshi: "Go ahead and rewrite the local history, and maybe add a git commit hook to run the privacy guard").** Item 1022's question, answered. **Done on `main`:** the 21 commits after `origin/main` (`66d5e928c`) rewritten by `git filter-branch` with a deterministic rewording filter (two commit messages; four item headings in five versions of this file), kept outside the repository because it holds the refused words; the final tree is unchanged (`main^{tree}` equal before and after), `main` still descends from `origin/main`, and the guard over every message and every added or changed file version of the range reads 0 refusals (17 before). Every commit of the range has a new hash: the old-to-new list is `data/fs131/history-rewrite/main-2026-10-16.txt`, and every hash this file cites from items 1016–1024 is an old one. **Signatures:** `filter-branch` drops them, so the 21 commits are now unsigned. *Choice:* leave them unsigned. *Alternative weighed:* re-sign them. *Why:* re-signing puts a timestamp in each commit, so the job branches' copies of these commits would no longer rewrite to the same hashes at their landing; and 116 of the last 200 commits already on GitHub are unsigned. *Confidence:* medium; Kooshi may want them signed, which can be done once at the next push. **The job branches** (`fs131-kpa1`, `fs131-ktc1`, `fs131-kfr1`, `fs131-kcs1`) carry the old commits through my merges of `main`; each is rewritten by the same filter when its agent hands back and before it merges, so its old commits become `main`'s new ones; the `p`-adic and three-colour branches also need their stopped agents' records reworded (the filter gains those lines then). **The hooks:** `pre-commit` (each staged text file's staged content through the guard; binary files and files over 10 MB skipped and named, left to the push-time check) and `commit-msg` (the message through the guard), in the common hooks folder, so they run in every worktree; untracked, so the guard's location is not published. Controls in a scratch repository: a clean commit passes; a planted phrase is refused in a file, in a message and in a path with spaces; a binary file is skipped.
> — source: plans/FS131-close-inventory.md

The predecessor's record is `plans/FS131-IFR1-density.md`: its last section, "What is left — for the successor FS131-IFR2", lists each gate-input
file this branch edits, how each block was made, and the checks to run after the merge. Follow it.

## Done means

1. **Stage 1 — the readback.** Check the quotations above against their source; restate in your record what the merge
   must keep and the order of work.
2. **The merge.** `git merge main` into `fs131-kfr1`; every conflict in a gate input resolved by keeping both sides' entries
   (lists of `#print axioms` lines, state-control counts, ledger rows, import lines); `main`'s build files copied in by
   checksum (`rsync -a --checksum`, no `--delete`; a dry run first); the build green under the slot; a saved stage.
3. **The gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under `data/fs131/ifr2/`), with the
   predecessor's post-merge checks (the audit block's `--coverage`, the state controls raised by every landing's imported
   records, `--write-ledger` re-run); every count change explained against the five-colour gate
   (`data/fs131/ics1/gate/` on `main`); the density modules' stored statements dumped again and shown unchanged from the
   predecessor's gated dump; `#print axioms` of the head statements (expected as the predecessor printed them). A saved
   stage.
4. **The drafts' counts**: the predecessor's front-page drafts (its record § Drafts for the front page) restated in your
   record with this gate's counts, each naming its slot; nothing else in them changed.
5. **The report**, in the standing rules' form.

## What is yours to decide

How you resolve each gate-input conflict, as long as every landing's entries stand. Not yours: any proof or statement.

## The machine

The laptop: 12 cores, 31 GB, shared with one other implementer. From inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 5 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`;
never `lake build`. On exit 75 wait ten minutes and retry. The worktree's `.lake/build` is its own copy; never replace it
with a symlink. Keep every working file under `data/fs131/ifr2/` (standing rule 2). Nothing with a `sorry` reaches `main`.
