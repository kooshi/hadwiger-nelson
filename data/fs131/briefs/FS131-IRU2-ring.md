# Brief FS131-IRU2 — the ring of unit vectors: merge `main`, keep every landing's gate inputs, and run the full gate once

*Written 2026-10-16 22:44 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IRU2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the successor implementer of the ring of unit vectors (Lemma C′, the components clause, the dichotomy) — every proof is done and gated on a commit that predates two landings; you merge `main` into the branch, reconcile the gate's input files so every landing's entries stand, and run the full gate once on that merge commit
  launch: now, in the predecessor's worktree and on its branch; beside you a filing clerk in another worktree, writing none of your files
  mission: § Why this job
  statements: § Where the work stands
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once if a merge conflict is not a gate input's list (a proof or a statement), or a gate step fails in a way no rule explains, and when the gate is green on one commit; the report goes to `data/fs131/reports/FS131-IRU2.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IRU2-ring.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/il5`, on its branch `fs131-kru1` (at `5a22b1a34`; its `.lake/build` is the predecessor's gated build of `e849029c3`): the merge of `main` (at `5ac6f3ef9` or later) and its conflict resolutions; the gate's inputs by the gate's own rules (`scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt`'s header, `Proofs.lean`, `ARCHITECTURE.md` rows); no proof or statement; `plans/FS131-IRU2-ring.md`; your scripts and logs under `data/fs131/iru2/`; `data/fs131/reports/FS131-IRU2.md`; the counts in the predecessor's drafts brought to your gate, written into your own record. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard: if it refuses a commit, reword what it names and commit again, never `--no-verify`
  budget: about 250k by the harness's count, as guidance; save a stage after the merge and after the gate; hand back before about 350k

Hello. The mathematics here is done and checked; what is left is making the check hold on the tree that will land.

## Why this job

The landing rule is that `main`, after the merge, equals the gated commit in `Proofs/`, `scripts/` and the package files.
Two other modules landed after this branch's gate, and each edits the same gate inputs. The predecessor's hand-back and
my rulings on it:

> 1065. **FS131-IRU1 handed back DONE: the ring of unit vectors proved, gated on a stale base (logged 2026-10-16 22:43 UTC; about 600k by the harness's count — past its line, not to be resumed; branch `fs131-kru1` at `5a22b1a34`, worktree `.claude/worktrees/il5`; record and report copied onto `main` unchanged).** All 40 leaves in about 571 lines against a planned 970; the full gate green on `ddb765bac` (against the three-colour gate: +45 clean records, `declarations=22564`, `refutations-skipped=244`); every head statement on the standard three: Lemma C′ as typed (`Rigidity.unitRing_eq_stableIntegers`), its odd part at every real number field (`exists_two_pow_mul_mem_unitRing`), the onto half (`exists_eq_add_mul_of_mem_stableIntegers`), the finite-ring lemma (`closure_normOne_eq_top`), usable and stable primes at every real number field with no outside theorem (`exists_isUsablePrime`, `nonempty_stablePrime`, `localBound_lt_top`), the dichotomy and the components clause. My message to re-merge crossed its hand-back; it began the merge, then aborted it at my second message (the tree clean), and recorded what the merge showed: two gate-input conflicts, a predicted `declarations=22728`, `refutations-skipped=246`. **Rulings, four parts each.** (1) *A successor, FS131-IRU2*, merges `main` and runs the one gate, as FS131-IFR2 did. *Alternative:* resume IRU1 — declined: past its line. *Confidence:* high. (2) *Keep* `Rigidity.exists_stablePrime_natCast_mem` as a second route. *Alternative:* retire it for FS131-ICS1's bridge at the join — declined: a stored statement removed for no reader's gain. *Confidence:* medium-high. (3) *File FS131-PAS1's verdicts*, not "not yet searched", for Lemma C′ and the polynomial fact (as item 1057 did); the dichotomy's own prior art stays "not yet searched". *Confidence:* high. **Owed at the landing:** row 105's Chebotarev clause (its D4 with PAS1 § 6.4 item 1, crediting Nagell and Bauer), row 100 (D3 with PAS1 § 5.4 items 1–2), the roadmap's "taken out of the library" (D6), a superseded banner for FS131-KCS1 § 2.6 (D11). **Credited:** Lemma C′ at 59 % of its planned size, and the clean stand-down.
> — source: plans/FS131-close-inventory.md

## Where the work stands

The landing that went in just before you, whose gate is your baseline:

> 1063. **FS131-IFR2 handed back DONE; the density form of the collapse lands on `main` (logged 2026-10-16 22:42 UTC; about 360k by the harness's count; record `plans/FS131-IFR2-density.md`, report `data/fs131/reports/FS131-IFR2.md`).** `main` (the three-colour and five-colour landings) merged into `fs131-kfr1` with no proof or statement conflict (`Rigidity/ClassRatio` auto-merged, disjoint hunks) and four gate-input conflicts resolved keeping both sides; the full gate green on `2c6896990` (now `b8cef1f36`: the branch rewritten over `main..fs131-kfr1`; map `data/fs131/history-rewrite/fs131-kfr1-2026-10-16.txt`, 29 commits); counts: audit 11,698 records (10,998 clean, 575 axiom-free, 120 imported, 5 purchases), `rests=168`, vacuity `declarations=22683`, `refutations-skipped=245`, `sites=1465` — each change equal to the density landing's own; both landings' 27 recompiled modules' stored statements and 385 records' axioms equal to their gated prints (its two comparison tools, plants fired). **My receipts:** the guard over `main..fs131-kfr1`: eight refusals, all in three gzip-compressed statement dumps, which decompressed read 0; **I printed the axioms myself** from the gated build: `Collapse.finIndepRatio_planeOver_eq_localRatio` (`α₁(F²) = localRatio F` at `[NumberField F]`) and `fractionalChromaticNumber_planeOver_eq_plane_of_thick` on the standard three and E–L; `exists_finite_triangleFree_six_chromatic` on the standard three, E–L, Weil and `no_proper_five_coloring`; `inv_localRatio_lt_five` and `le_volume_selection` on the standard three — as reported, read against row 129. **Announcement rule (item 1006/1023's form): met** — merged as `dfba6bc68`, `main` equal to `b8cef1f36` in `Proofs/`, `Proofs.lean`, `scripts/` and the package files; the gated build moved into the main tree, `build.sh`: up to date. **Ruling, four parts, on item 1050's ledger question:** *Choice:* no new row; the fractional collapse and the six-chromatic graph stay in row 129, with FS131-PAS1's § 3.4 lines (row 129's prior-art field, README § 5, a new `CLOSED-QUESTIONS.md` entry for de Grey's and Haugstrup's questions). *Alternative:* a row of their own. *Why:* both are consequences of row 129's field clause and row 128, and the closed-questions entry is where a reader looks for an answered question. *Confidence:* medium. **Filing next:** its drafts D-1–D-10 (D-1's counts restated by it) with FS131-PAS1's § 3.4 items 1–3, by a Clerk; D-7 (the README row) adapted by me. **Its slip:** two temporary lists written to `/tmp` (standing rule 2), logged as its own. **Next landing:** FS131-IRU1 (its gate green on `ddb765bac`, before two landings) re-merges `main` and re-gates, told by message.
> — source: plans/FS131-close-inventory.md

On history and commits:

> 1025. **The unpushed history rewritten, and the privacy guard made a commit hook (logged 2026-10-16 18:38 UTC; Kooshi: "Go ahead and rewrite the local history, and maybe add a git commit hook to run the privacy guard").** Item 1022's question, answered. **Done on `main`:** the 21 commits after `origin/main` (`66d5e928c`) rewritten by `git filter-branch` with a deterministic rewording filter (two commit messages; four item headings in five versions of this file), kept outside the repository because it holds the refused words; the final tree is unchanged (`main^{tree}` equal before and after), `main` still descends from `origin/main`, and the guard over every message and every added or changed file version of the range reads 0 refusals (17 before). Every commit of the range has a new hash: the old-to-new list is `data/fs131/history-rewrite/main-2026-10-16.txt`, and every hash this file cites from items 1016–1024 is an old one. **Signatures:** `filter-branch` drops them, so the 21 commits are now unsigned. *Choice:* leave them unsigned. *Alternative weighed:* re-sign them. *Why:* re-signing puts a timestamp in each commit, so the job branches' copies of these commits would no longer rewrite to the same hashes at their landing; and 116 of the last 200 commits already on GitHub are unsigned. *Confidence:* medium; Kooshi may want them signed, which can be done once at the next push. **The job branches** (`fs131-kpa1`, `fs131-ktc1`, `fs131-kfr1`, `fs131-kcs1`) carry the old commits through my merges of `main`; each is rewritten by the same filter when its agent hands back and before it merges, so its old commits become `main`'s new ones; the `p`-adic and three-colour branches also need their stopped agents' records reworded (the filter gains those lines then). **The hooks:** `pre-commit` (each staged text file's staged content through the guard; binary files and files over 10 MB skipped and named, left to the push-time check) and `commit-msg` (the message through the guard), in the common hooks folder, so they run in every worktree; untracked, so the guard's location is not published. Controls in a scratch repository: a clean commit passes; a planted phrase is refused in a file, in a message and in a path with spaces; a binary file is skipped.
> — source: plans/FS131-close-inventory.md

The predecessor's record is `plans/FS131-IRU1-ring.md` (on `main` too): its § 3.5 lists the gate inputs this branch edits (its CLEAN audit
block, the retired `.condition` entry for `Arith.IsUsablePrime`, the vacuity header), and its report's last held item says
what the aborted merge showed. The density landing's successor solved the same problem: `plans/FS131-IFR2-density.md`, with
its two comparison tools `tools/fs131_ifr2_statements.py` and `tools/fs131_ifr2_axioms_diff.py`, on `main`.

## Done means

1. **Stage 1 — the readback.** Check the quotations above against their source; restate in your record what the merge
   must keep and the order of work.
2. **The merge.** `git merge main` into `fs131-kru1`; every conflict in a gate input resolved by keeping both sides' entries
   (lists of `#print axioms` lines, state-control counts, ledger rows, import lines); `main`'s build files copied in by
   checksum (`rsync -a --checksum`, no `--delete`; a dry run first); the build green under the slot; a saved stage.
3. **The gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under `data/fs131/iru2/`), with the
   audit block's coverage over this branch's records, `--write-ledger` re-run and the retired `.condition` entry kept
   retired; every count change explained against the density landing's gate (`data/fs131/ifr2/gate/` on `main`); this
   branch's modules' stored statements and axioms shown unchanged from the predecessor's gated prints; `#print axioms` of
   the head statements (expected: the standard three, as the predecessor printed them). A saved stage.
4. **The drafts' counts**: the predecessor's front-page drafts (its record § Drafts for the front page) restated in your
   record with this gate's counts, each naming its slot; nothing else in them changed.
5. **The report**, in the standing rules' form.

## What is yours to decide

How you resolve each gate-input conflict, as long as every landing's entries stand. Not yours: any proof or statement.

## The machine

The laptop: 12 cores, 31 GB, shared with a filing clerk. From inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 5 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`;
never `lake build`. On exit 75 wait ten minutes and retry. The worktree's `.lake/build` is its own copy; never replace it
with a symlink. Keep every working file under `data/fs131/iru2/` (standing rule 2). Nothing with a `sorry` reaches `main`.
