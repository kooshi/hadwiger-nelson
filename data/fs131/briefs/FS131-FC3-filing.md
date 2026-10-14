# Brief FS131-FC3 — file the ten front-page drafts of a landing that is already on `main`, verbatim, and run the checks that read the front page

*Written 2026-10-14 04:09 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-FC3
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; here you are the coordinator's pen for one filing
  role: the pen for one filing — a line of Lean modules landed on `main` just now and the front page shows the counts from before it; you put the landing agent's ten drafts into their slots word for word, run the checks that compare the front page with the gate's receipts, and report every place where you would have had to choose
  launch: now, in a tree of your own; two other jobs work in other trees and write no file you write; no landing is in flight, and the next landing will quote the front page as it stands after yours
  mission: § Why this job
  statements: § What is filed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a draft's slot is not found exactly once, if two drafts touch the same words, or if a check fails in a way no draft explains; the report goes to `data/fs131/reports/FS131-FC3.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `data/fs131/reports/FS131-FC3.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wrc` (branch `fs131-f3`, cut from `main` just now; the tree holds a compiled library you do not need and must not touch; no build is run): the files the drafts name — whichever of `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `ARCHITECTURE.md` and `tools/claude_md_fact_audit.py` they name — and nothing else of the front files; your own script and outputs under `data/fs131/fc3/`; `data/fs131/reports/FS131-FC3.md`. Commit on your branch by explicit path; the coordinator merges it
  budget: about 150k by the harness's count, as guidance; save a stage (a commit) after the slots are checked, after the drafts are in, and after the checks; hand back at a saved stage if you pass about 250k

Hello. Two filings like this one were done on this machine since yesterday; the last clerk raised eight checks,
guessed at nothing, and caught a mistake of mine. This is the same job for the landing that followed.

## Why this job

A line of six Lean modules landed on `main` just now through the full gate: for real quadratic fields, which planes
need two, three and four colours; over every real number field, exactly when three colours suffice; a lower bound of
four for any subfield of the reals whose unit vectors generate one third. Its landing agent wrote ten drafts for the
front page, each with the exact words it replaces or follows. Until they are filed the front page (`CLAUDE.md`) shows
7,506 records where the library has 7,602.

The drafts are a lane's words and go in verbatim: I coordinate and do not author, and you are my pen. Where you would
otherwise have to guess, write a `CHECK:` line and do not guess.

## What is filed

The landing as I logged it, with my receipt:

> 739. **FS131-LJ1 handed back, and the three-and-four-colours line is on `main` (2026-10-14 04:09 UTC logged; "JOB FS131-LJ1 — DONE"; 504k by the harness's count — past its line, not to be resumed; branch `fs131-wj1` at `41c920d7e`; merged into `main` as `c18944ace`, a merge commit).** "The full gate is green on one commit, `def7c07f8` … in one pass from 03:40 to 04:03 UTC." "the audit, \"7602 records — 7531 clean, 28 axiom-free, 38 imported, 5 declared purchase(s)\". 84 records are under CLEAN …. 12 are under IMPORTED, on the three and `StandingFive.kloosterman_bound` alone"; vacuity "`declarations=16125 refutations-skipped=228 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`"; assumptions "`axioms=3 rests=39 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1`" — "`inline:Row99` is retired", "rests 26 → 39: the 12 imported records and one private helper". **Held, read aloud by it:** clause (a), the table for the planes over ℚ(√m), "[kernel, standard three]: matches the claim term for term. It also covers m = 1"; clause (b), "[kernel, standard three + Weil's bound]: matches term for term"; clause (c), "[kernel, standard three]: it assumes `¬ Colorable 2` where the claim says \"F² has an odd cycle\""; row 99's first three sentences "[kernel] on the standard three + Weil's bound. \"No mixing\" and χ(ℚ(α,√7)²) = 4 are not in the kernel". "No statement says less than its claim." **Whose it is** (item 708): the values two and three and the upper bounds are Fischer's (1990); this project's are the lower bound of four for every squarefree radicand 11 modulo 12 against every colouring, the three-colour criterion over every real number field, and the clause for subfields of the reals. **My receipt:** the gated commit is an ancestor of the tip, nothing differs after it outside `plans/` and `data/`, `git grep` finds no `sorry` under `Proofs/`, the final pass log ends "tracked files modified after the pass: 0 / pass-exit=done"; **run by me from the gated tree**: the four headline theorems elaborate with their axioms printed (item 720's prints: the table and clause (c) on the standard three; clause (b) and row 99 also on Weil's bound); after the merge `main` equals the gated commit outside `plans/` and `data/`; the backup remote updated. Its drafts: ten, "21 slots, each found exactly once" — my run of its checker on `main`: "slots: 21 checked, 0 bad". Open items it names: three lines of `SpectralChain.lean` still list row 99 as a hand input (to the docstring sweep); the assumptions step's blindness to discharged binders, second instance; whether the chain's headline is restated without `hRow99` (item 720 (d), for the chain's planner). **Told to Kooshi.** **The tree `fs131-wrc` now holds the compiled library of `main` as gated, and replaces `fs131-wnf` as the reference copy** once the planner that names `fs131-wnf` has handed back.
> — source: plans/FS131-close-inventory.md

**The ten drafts** are in `plans/FS131-LJ1-landing.md`, section "Drafts for the front page (FS131-LJ1)" (from its line 611 to the
heading "Open gate items at this landing"; the same text is `data/fs131/lj1/drafts.md`). Each names its file, its
section and the exact words on `main` it replaces or follows. The landing agent's checker of those slots is
`data/fs131/lj1/drafts-slots.py`; I ran it against `main` just before writing this.

**My choices where a draft leaves one to the coordinator** (file what the drafts say; use these only where a draft
offers alternatives or says "the coordinator's"):

1. Draft 10, the optional sentence for the theory paragraph, is filed if its slot is found; if the paragraph's words
   differ, it is dropped, as the draft itself says, and you report that.
2. Whose each value is, exactly as the drafts say it: the values two and three and the upper bounds are Fischer's;
   what is this project's is the lower bound of four against every colouring, the three-colour criterion over every
   real number field, and the clause for subfields of the reals.
3. The milestone this belongs to (the Lean backlog) changes no state by this filing.
4. The proof atlas is not touched by this job (one rebuild at the cleanup pass).

## Done means

1. **Slots first** (a saved stage): run `python3 data/fs131/lj1/drafts-slots.py main` in your tree; every slot found
   exactly once and the control absent, or you stop and message me with the slot that failed.
2. **The drafts in, by a script** (`data/fs131/fc3/file_fs131_lj1.py`; the pattern is the last filing's
   `data/fs131/fc2/file_fs131_lu1.py`): it asserts every slot before it writes anything, replaces or inserts each
   draft's quoted text exactly (the lines under `>` in the record, joined as the target file wraps its lines; nothing
   reworded, nothing added), and prints what it did per draft. A draft that says counts "stand" changes nothing and
   is reported as such. (A saved stage.)
3. **The checks that read the front page**, each with its full output kept under `data/fs131/fc3/`:
   - the three digests of this landing's receipts against the previous landing's:
     `python3 scripts/gate_report.py axioms data/fs131/lj1/gate/receipt-axioms-final.log data/fs131/lu1/gate/receipt-axioms-final.log CLAUDE.md`,
     the same with `vacuity` and `scripts/vacuity-baseline.txt` before `CLAUDE.md`, and with `assumptions` and
     `scripts/assumptions-ledger.txt` before `CLAUDE.md`;
   - `python3 tools/claude_md_fact_audit.py --base b603c6291` and the same tool with `--dupes`. **A token the audit
     reports lost is not allow-listed by you**: list it as a `CHECK:` with where it was and what replaced it;
   - `python3 tools/bib_audit.py`;
   - the size budgets the fact audit enforces (`CLAUDE.md` under 80,000 bytes).
4. **The report** (`data/fs131/reports/FS131-FC3.md`, and the same text as your hand-back): per draft — filed, or
   "stands", or `CHECK:` with the reason; each check's last lines; every `CHECK:`; the commits on your branch.

## What is yours to decide

How the script is written; the order of the drafts; how to join a draft's lines to the target file's wrapping.
Nothing about the words: if a draft looks wrong to you — a count that does not match the receipt it cites, a
sentence that contradicts the record's own table — file nothing for that draft and say what you saw.

## The machine

This session is on the laptop, away from the remote: **commit on your branch and do not push**. No Lean build
is part of this job; do not start one, and do not touch the tree's `.lake` folder. `/tmp` is wiped at power-off: keep
what the report cites under `data/fs131/fc3/`.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
