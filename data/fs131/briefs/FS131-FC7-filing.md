# Brief FS131-FC7 — file the front-page drafts of a landing that is already on `main`, verbatim, and run the checks that read the front page

*Written 2026-10-15 01:39 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-FC7
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; here you are the coordinator's pen for one filing
  role: the pen for one filing — the five-colour chain's Lean modules landed on `main` just now, and the front page shows the counts and grades from before them; you put the landing agent's drafts into their slots word for word, run the checks that compare the front page with the gate's receipts, and report every place where you would have had to choose
  launch: now, in a tree of your own; no other job is running; the publication pass will quote the front page as it stands after yours
  mission: § Why this job
  statements: § What is filed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a draft's slot is not found exactly once, if two drafts touch the same words, or if a check fails in a way no draft explains; the report goes to `data/fs131/reports/FS131-FC7.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `data/fs131/reports/FS131-FC7.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1` (branch `fs131-f7`, cut from `main` just now; the tree holds a compiled library you do not need and must not touch; no build is run): the files the drafts name — whichever of `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `ARCHITECTURE.md`, `tools/claude_md_fact_audit.py` and `data/fs131/claims-NF2.md` they name — and nothing else of the front files; your own script and outputs under `data/fs131/fc7/`; `data/fs131/reports/FS131-FC7.md`. Commit on your branch by explicit path; the coordinator merges it
  budget: about 200k by the harness's count, as guidance; save a stage (a commit) after the slots are checked, after the drafts are in, and after the checks; hand back at a saved stage if you pass about 300k

Hello. Six filings like this one were done on this machine in the last three days; the last clerks guessed at nothing,
and raised the lost tokens I then ruled on. This is the same job for the landing that followed.

## Why this job

The five-colour chain landed on `main` just now through the full gate: for every real number field F, the plane over F
needs at least the smaller of five and F's local bound, and the plane over ℚ(√47) needs exactly five colours — each with
no hypothesis of ours, on the standard three axioms and two declared outside theorems (Weil's bound and
Einsiedler–Lindenstrauss Theorem 1.3). Its gate-runner wrote 22 drafts for the front page (23 slots), each with the
exact words it replaces or follows. Until they are filed the front page (`CLAUDE.md`) says these values are held by hand
and shows 9,824 records. Kooshi's next step for the repository (publishing it) reads the front page as you leave it.

The drafts are a lane's words and go in verbatim: I coordinate and do not author, and you are my pen. Where you would
otherwise have to guess, write a `CHECK:` line and do not guess.

## What is filed

The landing's hand-back and its merge, as I logged them, with my receipts:

> 943. **FS131-LGT1 — the full gate green on one commit, `eee71c74cb281a6eabe047e5121c7734a0637af7` (notice, logged 2026-10-15 01:34 UTC; by message; branch `fs131-wlc`, tree `fs131-wq1`; record `plans/FS131-LGT1-gate.md` there, § Stage 3).** From its message: "the full gate is green on one commit, eee71c74cb281a6eabe047e5121c7734a0637af7 (fs131-wlc, tree fs131-wq1), second pass. Every step exited 0 except the two controls that must exit 1. No tracked file was modified before or after the pass"; "The audit: 11,284 records, 10,650 clean, 569 axiom-free, 60 imported, 5 purchases, 3 declared imports"; "Vacuity: declarations=22238 refutations-skipped=240 sites=1455, generic=1412, the rest unchanged"; "Assumptions OK: axioms=3 rests=74 takes=108 mentions=2, the other five counts unchanged"; "The statement check found 0 reports and all 5 plants fired; the dump is byte-identical to the lander's build-5 dump"; "The first pass (on de877ff21) failed only at the axiom audit's self-test. Its two controls that read the library's state still expected 26 imported records and 2 declared imports. I updated them by scripts/axioms-controls.txt's own rule". **My receipts:** `eee71c74c` is on `fs131-wlc` (ancestor of the head); `git diff df6579be0 eee71c74c` touches only `data/`, `plans/`, `scripts/` (the gate's inputs) and two new `tools/fs131_lgt1_*.py`, and `git diff 2fcba050a eee71c74c` outside `plans/` and `data/` is those seven files only, so `Proofs/` is build 5's; `run-gate-final.head` names the full hash with no tracked file modified, `run-pass-final.out` "tracked files modified after the pass: 0"; every `*-final.log` ends `exit=0`; `sorry-narrow-final.txt` empty; `axioms-final.log` "audited: 11284 records — 10650 clean …, 569 axiom-free, 60 imported …, 5 declared purchase(s)"; coverage "PUBLIC 1586 … RECORDS 1545 … REACHED 41", 13 plants unreached as planted; statement check "reports 0", "exit=0"; the controls diff read: `baseline` 26/2/2 → 60/3/3, `imported_declared` 27/3/3 → 61/4/4, `banner_dropped` two lines for the third import, by the file's own stated rule, and the 60 decomposes as the record's § 1 says (Weil's bound alone 38, the five-colour theorem 6, E–L alone 8, both 8). From the tree's compiled library at `eee71c74c`, the whole root imported (scratch `lgt1/Ax3.lean`): `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five : (SimpleGraph.induce (planeOver SqrtFortySeven.F47) (unitDistance ℂ)).chromaticNumber = 5` and `Rigidity.min_localBound_five_le_chromaticNumber : ∀ (F : Subfield ℝ) [NumberField ↥F], min (SpectralChain.localBound F) 5 ≤ (SimpleGraph.induce (planeOver F) (unitDistance ℂ)).chromaticNumber`; they, `five_le_chromaticNumber_planeOver_of_five_le_localBound`, and `SqrtClassValues`' values at ℚ(√143), ℚ(√311), ℚ(√335), ℚ(√3,√5) and the bound at ℚ(√167) each on `[propext, Classical.choice, Quot.sound, Rigidity.positive_entropy_rigidity, StandingFive.kloosterman_bound]`; `Plane.oneAvoidingDensityBound` on the standard three; `Outside.OAI158.chromaticNumber_plane_six_or_seven` unchanged. **Announcement rule (item 940):** (a) met; (c) met — the standard three and the two declared outside theorems named there, no `sorryAx`, and the instance's statement has no binder; (b) at the merge below; (d) the read-aloud, the gate-runner's step 4, owed. **Ruling, four parts.** *Choice:* merge `eee71c74c` into `main` now (`--no-ff`; `git merge-tree` clean), check `main` equal to it outside `plans/` and `data/`, push to the backup; the gate-runner's later commits (read-aloud, drafts) are merged at its hand-back once checked to touch records only. *Alternative weighed:* one merge at the hand-back — declined: the merged sources are the gated commit's either way, and merging now lets (b) be checked while the read-aloud runs. *Why:* the gate is the landing; nothing after it moves `Proofs/`. *Confidence:* high; it would change if a later commit on the branch touches `Proofs/` or a gate input. **Credited:** the self-test run before the pass caught two controls left stale by the join, and they were moved by their own rule, not loosened.
> — source: plans/FS131-close-inventory.md

> 944. **FS131-LGT1 handed back: the gate green on `eee71c74c`, read aloud, the front page drafted (logged 2026-10-15 01:37 UTC; "JOB FS131-LGT1 — DONE"; 462k by the harness's count; branch `fs131-wlc` at `194ec35cf`, tree `fs131-wq1`; record `plans/FS131-LGT1-gate.md`, report `data/fs131/reports/FS131-LGT1.md`).** From its hand-back message: "[kernel] `HadwigerNelson.SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five : (SimpleGraph.induce (planeOver SqrtFortySeven.F47) (unitDistance ℂ)).chromaticNumber = 5`, where `F47 = Subfield.closure {√47}`. No hypothesis; the same five axioms. Read against row 121's headline claim `χ(ℚ(√47)²) = 5`: it states exactly that"; the headline "Read against row 123's main clause: word for word, for every real number field, complex places included"; M15's other values with no hypothesis, and "Not stored as theorems: `χ = L` at `L ≤ 5` (it is a two-line composition with the upper half), the family of 44 of 52 fields, CLS in full, and ℚ(√23, ∛2)"; "what the kernel did not check is exactly two declared outside theorems"; 1,439 audit records generated from the kernel's print, 235 of them named by no draft; four declared conditions retired, three declared `.condition`; "statement defect — none found"; drafts 1–22 "each slot checked once on `main` by `data/fs131/lgt1/drafts-slots.py` (23 slots OK; its control at `9fe574044` fails on 10)", novelty "per the 00:33 amendment"; the four raw dumps deleted after the check read them; a question: "E–L Thm 1.3's in-file model, `positive_entropy_rigidity_model`, is degenerate (the one-point solenoid …). I did not check whether PE-1′ is a stated theorem exhibiting a non-degenerate model"; "`lean4checker` was not run. Neither is a gate item." **My receipts:** the four commits after `eee71c74c` touch `plans/` and `data/` only (`git diff eee71c74c 194ec35cf` outside them empty); merged into `main` as `9543a549b` (`--no-ff`, after item 943's `1b589dcb5`), and `git diff eee71c74c main` outside `plans/` and `data/` is empty; my own reading of the instance (item 940 (d)): `F47` is `SquareClass.fieldOfRadicands {47}` = `Subfield.closure ((fun d : ℕ => Real.sqrt d) '' {47})`, the subfield ℚ(√47) of ℝ (`Instances/SqrtFortySeven.lean` l. 39, `SquareClass.lean` l. 306); `planeOver F = {z : ℂ | z.re ∈ F ∧ z.im ∈ F}` (`SquareClass.lean` l. 63), F² in ℂ; `unitDistance ℂ` adjacency `dist x y = 1` (`UnitDistance.lean` l. 40); so the stored type says the unit-distance graph on ℚ(√47)² has chromatic number 5 — row 121's `χ(ℚ(√47)²) = 5`; it has no binder. The degenerate-model question read: the axiom's hypothesis "no virtually cyclic factors" has a non-degenerate inhabitant in `ZdAction.mulTwoThree_model` (`Rigidity/PositiveEntropy.lean` l. 415, FS131-IJN1), and the statement's read-back against the page is `plans/FS131-KN7-chain-next.md` § Stage 3 (one read-back, written again at repair R1). **Announcement rule (item 940): met on its letter** — (a) item 943; (b) `main` at `1b589dcb5` and again at `9543a549b` equal to `eee71c74c` outside `plans/` and `data/`; (c) item 943's print; (d) the gate-runner's stage 4 and my reading above. **W6's trigger is met:** row 121's `χ(ℚ(√47)²) = 5` is through the gate on `main` with no hypothesis of ours. **Rulings, four parts.** (1) *The three `.condition` declarations stand as declared:* alternative, `EntropySplitEvery` as a `.former` of kind `ours` — declined for now: the kernel holds `EntropySplit F` with no such hypothesis, so nothing rests on it; the second filing may reclass it; medium. (2) *The front page from drafts 1–22 by a Clerk filing (base `faa9a919c`), its novelty wording checked by me first:* alternative, file them myself — declined, the filing is verbatim work; high. (3) *`lean4checker` and the comparator* at the publication pass, as `CLAUDE.md` § The mission's publication paragraph names them; alternative, now — declined: no gate item, and the pass's first step is Kooshi's word on its shape; high. (4) *The generalization `χ(F²) = L(F)` at `L(F) ≤ 5` stated by name:* to the publication roadmap with Lemma C′, or a short job if Kooshi wants it before the push; medium. **Correction to my § 7 rule:** the handoff says the merge is mine "after the hand-back"; I merged the gated commit at the green line (item 943) and the records at the hand-back — the sources merged are the gated commit's either way. **Credited:** the 235 records only the kernel's print found; the stale self-test controls caught before the pass.
> — source: plans/FS131-close-inventory.md

**The drafts** are in `plans/FS131-LGT1-gate.md`, section "Drafts for the front page (FS131-LGT1)" (to the heading "Open gate items at
this landing"). Each names its file, its section and the exact words on `main` it replaces or follows. The gate-runner's
checker of those slots is `data/fs131/lgt1/drafts-slots.py`.

**My choices where a draft leaves one to the coordinator** (file what the drafts say; use these only where a draft
offers alternatives or says "the coordinator's"):

1. Whose it is, exactly as the drafts say it: the lower bound of five and its instances are this project's derivation,
   "prior art: not found in print"; the upper half and the plane at 11 are prior art; Weil's bound and
   Einsiedler–Lindenstrauss Theorem 1.3 are declared outside theorems; the kernel check is this landing's. Never "new"
   or "first", and never "not new" for a result of ours. No value of `χ(ℝ²)` moves.
2. No milestone changes state in this filing.
3. The proof atlas is not touched by this job (one rebuild at the publication pass).
4. If `CLAUDE.md` would pass 80,000 bytes, file nothing more in it and write a `CHECK:` with the byte count: the move
   that meets a size budget is mine to rule.

## Done means

1. **Slots first** (a saved stage): run `python3 data/fs131/lgt1/drafts-slots.py main` in your tree; every slot found
   exactly once and the control absent, or you stop and message me with the slot that failed.
2. **The drafts in, by a script** (`data/fs131/fc7/file_fs131_lgt1.py`; the pattern is the last filing's
   `data/fs131/fc6/file_fs131_ldb1.py`): it asserts every slot before it writes anything, replaces or inserts each
   draft's quoted text exactly (the lines under `>` in the record, joined as the target file wraps its lines; nothing
   reworded, nothing added), and prints what it did per draft. A draft that says counts "stand" changes nothing and
   is reported as such. (A saved stage.)
3. **The checks that read the front page**, each with its full output kept under `data/fs131/fc7/`:
   - the three digests of this landing's receipts against the previous landing's:
     `python3 scripts/gate_report.py axioms data/fs131/lgt1/gate/receipt-axioms-final.log data/fs131/ldb1/gate/receipt-axioms-final.log CLAUDE.md`,
     the same with `vacuity` and `scripts/vacuity-baseline.txt` before `CLAUDE.md`, and with `assumptions` and
     `scripts/assumptions-ledger.txt` before `CLAUDE.md`;
   - `python3 tools/claude_md_fact_audit.py --base faa9a919c` and the same tool with `--dupes`. **A token the audit
     reports lost is not allow-listed by you**: list it as a `CHECK:` with where it was and what replaced it;
   - `python3 tools/bib_audit.py`;
   - the size budgets the fact audit enforces (`CLAUDE.md` under 80,000 bytes).
4. **The report** (`data/fs131/reports/FS131-FC7.md`, and the same text as your hand-back): per draft — filed, or
   "stands", or `CHECK:` with the reason; each check's last lines; every `CHECK:`; the commits on your branch.

## What is yours to decide

How the script is written; the order of the drafts; how to join a draft's lines to the target file's wrapping.
Nothing about the words: if a draft looks wrong to you — a count that does not match the receipt it cites, a
sentence that contradicts the record's own table — file nothing for that draft and say what you saw.

## The machine

This session is on the laptop, away from the remote: **commit on your branch and do not push**. No Lean build
is part of this job; do not start one, and do not touch the tree's `.lake` folder. `/tmp` is wiped at power-off: keep
what the report cites under `data/fs131/fc7/`.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## Amendment — 2026-10-15 01:45 UTC

Your stage 3 report (`data/fs131/reports/FS131-FC7.md` in your tree) is read, and every `CHECK:` is ruled here. Thank
you: the size check stopped exactly where the brief said it should.

**CHECK 1, the size budget: two moves first, then drafts 5–12 in full.** The budget is met by moving text a session does
not need to a file that already holds it, never by trimming a draft. In this order, each by your script, asserting its
slot first:

1. **The closed milestone leaves the open-milestones paragraph.** In `CLAUDE.md` § Paths forward, ranked, the paragraph
   that opens "**Open milestones.**" holds a block that opens "**Closed 2026-10-14: FS-133, the one-class transfer**" and
   ends "the kernel proof is this project's. " (just before "**Derived 2026-10-07: FS-132, six by the nerve**"). Its words
   are in `plans/FRONTIER-STUBS.md` § Open milestones, in order, already, and the result's current statement is in
   "What the kernel holds". Replace the block by exactly this text (my words, a pointer):
   "**Closed 2026-10-14: FS-133, the one-class transfer** (`plans/FRONTIER-STUBS.md` § Open milestones, in order). "
2. **The "Last filed" chain keeps only its newest entry.** File draft 5 as written. Then move its three older entries —
   the ones that open "the landing of the density bound** (FS131-LDB1", "the landing of FS-133, the density equality**
   (FS133-LD1" and "the landing of the port of `[OAIMath2026]`'s transfer proof** (FS131-LP1" — verbatim to the top of
   `plans/FILINGS.md`, below its italic header and above its first entry, newest first, each starting "before it **" as
   the file's entries do. In `CLAUDE.md` the line then reads: draft 5's entry, then "; before it, every earlier filing,
   newest first: `plans/FILINGS.md`." (the existing words "before them, every earlier filing, newest first" with "them"
   made "it"). This also settles **CHECK 5**: the words "three → two" travel with the port's entry, and `plans/FILINGS.md`
   records each filing as it was made.
3. **Then drafts 6–12**, as written; for **CHECK 4**, leave the sentence after draft 8 as it is.

If `CLAUDE.md` is still over 80,000 bytes after all three, stop and write a `CHECK:` with the byte count.

**CHECK 2, the twelve lost tokens: allow-list them**, in the form of your draft-20b entries — each an old count that a
draft replaced, its reason naming the new value in the parenthesis (`generic=1411` → 1412, `sites=1454` → 1455,
`refutations-skipped=234` → 240, `355` → 569 axiom-free, `axioms=2` → 3, `rests=27` → 74, `takes=102` → 108,
`mentions=1` → 2, and the code token with `generic=1412`). Tokens the two moves send to `plans/FILINGS.md` take
`EXTERNAL_HOMES` entries in the FS131-FC5 form (`tools/claude_md_fact_audit.py` l. 522 on). Any other lost token is a
`CHECK:`.

**CHECK 3 and CHECK 6: accepted as you did them.**

**Then run the checks again** (the three digests, the fact audit with `--base faa9a919c` and with `--dupes`,
`tools/bib_audit.py`, the size) and add stage 4 to your report. **Touches extended** to `plans/FILINGS.md`. Commit by
explicit path on your branch; do not push.

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).
