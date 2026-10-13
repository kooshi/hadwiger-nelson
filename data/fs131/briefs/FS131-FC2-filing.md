# Brief FS131-FC2 — file the sixteen front-page drafts of a landing that is already on `main`, verbatim, and run the checks that read the front page

*Written 2026-10-13 21:50 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-FC2
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; here you are the coordinator's pen for one filing
  role: the pen for one filing — a Lean module landed on `main` two hours ago and the front page shows the counts from before it; you put the landing agent's sixteen drafts into their slots word for word, run the checks that compare the front page with the gate's receipts, and report every place where you would have had to choose
  launch: now, in a tree of your own; two other jobs work in other trees and write no file you write; no landing is in flight, **and the next landing waits on this filing**, because its own drafts will quote the front page
  mission: § Why this job
  statements: § What is filed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a draft's slot is not found exactly once, if two drafts touch the same words, or if a check fails in a way no draft explains; the report goes to `data/fs131/reports/FS131-FC2.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `data/fs131/reports/FS131-FC2.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf` (branch `fs131-f2`, cut from `main` just now; the tree holds a compiled library you do not need and must not touch; no build is run): the files the drafts name — `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `plans/FS131-KN1-number-field-kernel-map.md`, `data/fs131/claims-NF1.md`, `tools/claude_md_fact_audit.py` — and nothing else of the front files; your own script and outputs under `data/fs131/fc2/`; `data/fs131/reports/FS131-FC2.md`. Commit on your branch by explicit path; the coordinator merges it
  budget: about 150k by the harness's count, as guidance; save a stage (a commit) after the slots are checked, after the drafts are in, and after the checks; hand back at a saved stage if you pass about 250k

Hello. This morning a clerk filed the drafts of the day's first landing, guessed at nothing, and raised five checks
that were all real. This is the same job for the landing that followed.

## Why this job

Two hours ago a module landed on `main` through the full gate: every real number field's plane needs no more colours
than its residue targets, with four values closed by it — prior art in the kernel, none of it this project's
mathematics. Its landing agent wrote sixteen drafts for the front page, each with the exact words it replaces or
follows. Until they are filed the front page (`CLAUDE.md`) shows 7,454 records where the library has 7,506, and the
script that compares the front page with a gate's receipts reports it stale. The next landing — three and four
colours over number fields — is being joined now and waits on this, because its own drafts will quote the front page
as it stands after yours.

The drafts are a lane's words and go in verbatim: I coordinate and do not author, and you are my pen. Where you would
otherwise have to guess, write a `CHECK:` line and do not guess.

## What is filed

The landing as I logged it, with my receipt:

> 702. **FS131-LU1 handed back, and the first number-field module is on `main` (2026-10-13 21:29 UTC logged; "JOB FS131-LU1 — DONE"; 688k by the harness's count — far past its line, not to be resumed; branch `fs131-wnf` at `0f61fba66`, clean; merged into `main` as `33f713682`, a merge commit).** "the gate is green on one commit, c2f4e4f546c93f833d9c04a692d138a9a897cbc1, on its first full pass … FS-131's first number-field module — Arith/UpperHalf, Arith/QuadraticPrime, Instances/UpperHalfValues — is through it. 49 theorems and 3 definitions, each [kernel], each under CLEAN on exactly [propext, Classical.choice, Quot.sound]. This job proved none and changed no statement … None of the values is new mathematics." **Held, each on the standard three axioms:** every real number field's plane needs at most its local bound (`UpperHalf.chromaticNumber_planeOver_le_localBound`), by homomorphisms **into** the residue targets at usable primes and at stable primes of every level; the primes that make it usable for fields of square roots (`QuadraticPrime.exists_maximal_card_eq`, any set of radicands; the ramified clause as corrected); four values — the plane over the field of √11 needs exactly 4, the rational plane exactly 2, at most 8 at √167 and at most 5 at √47 as controls; row 63's two-colour theorem at a real number field and row 105's reading over the stable primes. "Upper bounds and values are prior art ([Fischer1990], [Moorhouse2010], Woodall); the kernel proofs are ours." The five-colour chain's headline is restated without its upper-half hypothesis (`UpperHalf.chromaticNumber_eq_localBound_of_chain`, the standard three "AND nine declared hypotheses"); "No lower bound at ℚ(√47) is gained: χ(ℚ(√47)²) = 5 stays conditional." **Counts, by its word from the final logs:** "7506 records — 7447 clean on the standard axioms, 28 axiom-free, 26 imported, 5 declared purchase(s)"; vacuity "declarations=16029 refutations-skipped=228", "sites=1454 vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2"; assumptions "axioms=3 rests=26 named=19 inline=15 outside=7 ours=22 open=5 takes=106 mentions=1" — the prediction scored exact. **My receipt:** item 701's, and at the merge: the gated commit is an ancestor of the tip; the tip differs from it under `plans/` and `data/` only; after the merge `git diff --stat c2f4e4f54 HEAD` outside those two folders is empty, so `main`'s library is the gated tree. **What it names for others, in its words:** "corollaries one line away that no file states: localBound F = 2 → χ(F²) = 2; row 52's two values (the ramified clause at 11 for K(√5), K(√247)); row 105's reading at K(√7) — open gate item 6 (readings, not checked)"; "`1/2 ∉ ℤ[U_ℚ]` and `2 ≤ L(ℚ)` are kernel-checked terms of data/fs131/lu1/checks.lean, not library theorems"; "Instances/SqrtEleven.lean:29 cites \"[Fischer1990] Thm 9\" for χ(ℚ(√11)²) ≤ 4; BIBLIOGRAPHY.md's row lists Theorems 8–10 with four colours at N ≡ 3 (mod 8) third; not re-read here"; "older docstrings the landing makes stale, not edited: SpectralChain.lean:240, :624–625; Instances/SqrtEleven.lean:29; UnitRing.lean:98, :106, :189; Instances/SevenUnitRing.lean:11, :45". Tool defect, as item 694: the assumptions step cannot find a written-out hypothesis that has been proved. **Rulings.** (a) *The corollaries it names go to the joining module's job, which has the residue module in its tree* — alternative: a separate small job and a landing of its own for row 52's two values (item 674's ruling); changed, since the lander reads each as one application and the joining job lands next; confidence medium-high. (b) *The older theorem keeps its binder for now*, with a docstring pointer owed at the cleanup pass (item 694): changing a statement in that module recompiles most of the library and the chain's successor planner will re-cut that interface. (c) *The eight stale docstrings in older modules are one sweep at the cleanup pass* (one long rebuild for all), drafted by whoever reads them first; the citation of Fischer's theorem number is read against the paper by the joining job, which drafts the correction and does not edit that file. (d) **The filing**: sixteen drafts, 29 slots, in `plans/FS131-LU1-landing.md` § Drafts for the front page; the fact-audit base is `147e38bc8`; the Clerk files when a half-slot frees. **Stale on the front page until then, by its word:** the trust ledger's "7395 clean" (now 7447) and "inline 16 … ours 23 … takes 98" (now 15, 22, 106); the gate's "declarations=15969" (now 16029). Credit: a first-pass green gate; the assumptions mechanism found by running the step before editing; a read-aloud that corrected the claim list in four places.
> — source: plans/FS131-close-inventory.md

**The sixteen drafts** are in `plans/FS131-LU1-landing.md`, section "Drafts for the front page (FS131-LU1)" (from its line 629 to the
heading "Open gate items at this landing"). Each names its file, its section and the exact words on `main` it
replaces or follows. The landing agent's checker of those slots is `data/fs131/lu1/drafts-slots.py`; I ran it against
`main` just before writing this: "slots: 29 checked, 0 bad", the control absent.

**My choices where a draft leaves one to the coordinator** (file what the drafts say; use these only where a draft
offers alternatives or says "the coordinator's"):

1. Every homomorphism of a plane to a residue target is **into** it. Where the landing's draft for a ledger row
   differs from an earlier planner's draft of the same row, the landing's is the one filed.
2. Nothing of this landing is filed as this project's mathematics: the values and upper bounds are prior art, the
   kernel proofs are ours; a draft that says so already is filed as drafted.
3. The milestone this belongs to (the Lean backlog) changes no state by this filing.
4. No draft gives facts for the proof atlas; the atlas is not touched by this job.

## Done means

1. **Slots first** (a saved stage): run `python3 data/fs131/lu1/drafts-slots.py main` in your tree; every slot found
   exactly once and the control absent, or you stop and message me with the slot that failed.
2. **The drafts in, by a script** (`data/fs131/fc2/file_fs131_lu1.py`; the pattern is this morning's
   `data/fs131/fc1/file_fs131_lc1.py`): it asserts every slot before it writes anything, replaces or inserts each
   draft's quoted text exactly (the lines under `>` in the record, joined as the target file wraps its lines; nothing
   reworded, nothing added), and prints what it did per draft. A draft that says counts "stand" changes nothing and
   is reported as such. (A saved stage.)
3. **The checks that read the front page**, each with its full output kept under `data/fs131/fc2/`:
   - the three digests of this landing's receipts against the previous landing's:
     `python3 scripts/gate_report.py axioms data/fs131/lu1/gate/receipt-axioms-final.log data/fs131/lc1/gate/receipt-axioms-final.log CLAUDE.md`,
     the same with `vacuity` and `scripts/vacuity-baseline.txt` before `CLAUDE.md`, and with `assumptions` and
     `scripts/assumptions-ledger.txt` before `CLAUDE.md`;
   - `python3 tools/claude_md_fact_audit.py --base 147e38bc8` and the same tool with `--dupes`. **A token the audit
     reports lost is not allow-listed by you**: list it as a `CHECK:` with where it was and what replaced it;
   - `python3 tools/bib_audit.py`;
   - the size budgets the fact audit enforces (`CLAUDE.md` under 80,000 bytes).
4. **The report** (`data/fs131/reports/FS131-FC2.md`, and the same text as your hand-back): per draft — filed, or
   "stands", or `CHECK:` with the reason; each check's last lines; every `CHECK:`; the commits on your branch.

## What is yours to decide

How the script is written; the order of the drafts; how to join a draft's lines to the target file's wrapping.
Nothing about the words: if a draft looks wrong to you — a count that does not match the receipt it cites, a
sentence that contradicts the record's own table — file nothing for that draft and say what you saw.

## The machine

This session is on the laptop, away from the remote: **commit on your branch and do not push**. No Lean build
is part of this job; do not start one, and do not touch the tree's `.lake` folder. `/tmp` is wiped at power-off: keep
what the report cites under `data/fs131/fc2/`.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## Amendment 1 (2026-10-13 21:55 UTC) — my rulings on your eight checks, and three small things to do before the merge

Thank you: nothing guessed, and check 3 caught a mistake of mine — I told you no draft gives facts for the atlas
after a search that missed the words because they are capitalised in the draft.

**Check 1 — the five lost tokens: each is a superseded count or a replaced clause, and each is allowed, by these
entries.** Add them to the table named `ALLOW` in `tools/claude_md_fact_audit.py`, the key exactly the token the
audit printed, the reason exactly as written here:

- key `axioms=3 rests=26 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1` — reason: `superseded gate counts (the assumptions step's nine), refiled at FS131-LU1's landing from data/fs131/lu1/gate/receipt-assumptions-final.log (inline=15, ours=22, takes=106); the old line stays in data/fs131/lc1/gate/ and in GATE_CHANGES`
- key `declarations=15969 refutations-skipped=228 sites=1454` — reason: `superseded gate count (the vacuity scan's), refiled at FS131-LU1's landing from data/fs131/lu1/gate/receipt-vacuity-final.log (declarations=16029); the old line stays in data/fs131/lc1/gate/ and in GATE_CHANGES`
- key `15969` — the same reason as the previous entry.
- key `7454` — reason: `superseded gate count, the token form of 7,454 records; refiled at FS131-LU1's landing from data/fs131/lu1/gate/receipt-axioms-final.log (7,506 records); the old count stays in data/fs131/lc1/gate/ and in GATE_CHANGES`
- key `ℤ[i]` — reason: `LEDGER row 63's clause "no instance over a real field yet; the only inhabitant is the ring form on ℤ[i], deferred to FS-37" is superseded at FS131-LU1's landing: the library now holds the theorem over a real number field with the rational field's prime above 2 as its instance (UpperHalf.exists_stablePrime_rat, UpperHalf.chromaticNumber_planeOver_rat)`

If an entry does not silence its token (the table matches some other way), stop and tell me what the tool wants;
do not widen a key.

**Check 2 — draft 16 is filed.** `BIBLIOGRAPHY.md` is added to your touches. For each of the three keys the draft
names, append the draft's quoted sentence, as one sentence ending in a full stop, at the end of that row's cell that
says what of ours rests on the work (the row is the table line that begins with the key in bold; the cell is the one
after the citation). If a row or that cell is not found exactly once, that is a check, not a choice.

**Check 3 — the atlas part of draft 14 is not filed by this job.** The draft gives grade changes in prose, not facts
with positions, and the same ledger rows are regraded again by the next landing; the atlas gets one rebuild at the
cleanup pass. Nothing for you to do.

**Check 4 — draft 10 is not for a front file.** I have taken its text into my own tooling list. Nothing for you to do.

**Checks 5 to 8 — accepted as you did them**: the connector "; before it " is the list's own form; the joins stand;
the unwrapped long lines stand.

**Then**: run the fact audit again against the same base (it must exit 0), the same tool with its duplicates flag,
the bibliography audit, and the three digests; keep each output under your data folder beside the first run's; add a
short section to your report saying what this amendment changed and each check's last lines; commit by explicit
path; hand back. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
