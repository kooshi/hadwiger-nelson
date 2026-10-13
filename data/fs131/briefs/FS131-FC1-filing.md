# Brief FS131-FC1 — file the fourteen front-page drafts of a landing that is already on `main`, verbatim, and run the checks that read the front page

*Written 2026-10-13 20:09 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-FC1
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; here you are the coordinator's pen for one filing
  role: the pen for one filing — a Lean module landed on `main` an hour ago and the front page shows the counts from before it; you put the landing agent's fourteen drafts into their slots word for word, run the checks that compare the front page with the gate's receipts, and report every place where you would have had to choose
  launch: now, in a tree of your own; two implementers work in other trees and write no file you write; no landing is in flight, **and the next landing waits on this filing**, because its own drafts will quote the front page
  mission: § Why this job
  statements: § What is filed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a draft's slot is not found exactly once, if two drafts touch the same words, or if a check fails in a way no draft explains; the report goes to `data/fs131/reports/FS131-FC1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `data/fs131/reports/FS131-FC1.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wkc` (branch `fs131-f1`, cut from `main` just now; no build is needed and none is run): the files the drafts name — `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `ARCHITECTURE.md`, `BIBLIOGRAPHY.md`, `data/fs131/claims-NF3.md`, `tools/claude_md_fact_audit.py`, `tools/viz_proof_atlas_facts.py`, `visualizations/proof-atlas/` — and nothing else of the front files; your own script and outputs under `data/fs131/fc1/`; `data/fs131/reports/FS131-FC1.md`. Commit on your branch by explicit path; the coordinator merges it
  budget: about 150k by the harness's count, as guidance; save a stage (a commit) after the slots are checked, after the drafts are in, and after the checks; hand back at a saved stage if you pass about 250k

Hello. This morning a clerk filed the drafts of the last landing in four minutes, guessed at nothing, and raised five
checks that were all real. This is the same job for the landing that followed.

## Why this job

An hour ago a module landed on `main` through the full gate: the chromatic number of the plane equals its
Lebesgue-measurable chromatic number — a corollary of two outside results, formalized here. Its landing agent wrote
fourteen drafts for the front page, each with the exact words it replaces or follows. Until they are filed the front
page (`CLAUDE.md`) shows 7,420 records where the library has 7,454, and the script that compares the front page with
a gate's receipts reports it stale. The next landing — the first module of the number-field results — is ready and
waits on this, because its own drafts will quote the front page as it stands after yours.

The drafts are a lane's words and go in verbatim: I coordinate and do not author, and you are my pen. Where you would
otherwise have to guess, write a `CHECK:` line and do not guess.

## What is filed

The landing as I logged it, with my receipt:

> 682. **HELD — the measurable-number module is on `main` through the full gate (2026-10-13 20:05 UTC; FS131-LC1's green line; `main` fast-forwarded by me from `8cf1401b0` to `1fbef575c`, local — the server is unreachable).** Its line: "the gate is green on one commit, 10892a8f2, on its first full pass; branch fs131-wkc at 1fbef575c holds main (8cf1401b0) and differs from the gated commit under plans/ and data/ only … Counts from the saved logs (data/fs131/lc1/gate/): build 0 warnings; zero sorry; audit 7454 records — 7395 clean, 28 axiom-free, 26 imported, 5 purchases; vacuity declarations=15969 refutations-skipped=228 sites=1454, generic=1411, six new sites all GENERIC; assumptions rests=26, the other eight unmoved; lint silent, its control red; no statement changed (87 constants compared from the kernel's side); the outside theorem's stored term still the release's on the recompiled module." **My receipt**: `git merge-base --is-ancestor 10892a8f2 fs131-wkc` holds, and no path outside `plans/` and `data/` differs between the gated commit and the tip; `data/fs131/lc1/gate/axioms-final.log` ends "axioms: OK — 7395 clean, 28 axiom-free, 26 imported, 5 declared purchase(s)", `exit=0`; `vacuity-final.log` "vacuity: OK", `exit=0`; `assumptions-final.log` "3 outside theorem(s) as axioms, with 26 theorem(s) resting on them; 19 named and 16 inline hypotheses (7 outside, 23 ours, 5 open), taken by 98 statement(s)", `exit=0`; `build-final.log` "0 module(s) with warnings", `exit=0`; the axiom lines hold four `axiom` declarations and no `sorryAx`; no file under `Proofs/` on the branch holds a `sorry`; in `receipt-axioms-final.log`, `Plane.chromaticNumber_plane_eq_chiLebesgue` depends on the standard three and `Outside.OAI158.proper_to_borel_weak`, and `Plane.chiM0_eq_chiLebesgue` and `Plane.davies_lemma_B1` on the standard three alone; the headline's statement and docstring read on `main`. **What is held, at its grade — [kernel], through the gate**: `Plane.chromaticNumber_plane_eq_chiLebesgue : (unitDistance ℂ).chromaticNumber = chiLebesgue` — the chromatic number of the plane equals its Lebesgue-measurable chromatic number — on the standard three axioms and the one declared outside theorem `Outside.OAI158.proper_to_borel_weak`; `Plane.chiM0_eq_chiLebesgue` and the printed lemma (`davies_lemma_B1`, in a general form) on the standard three alone. **It is a corollary of two outside results, formalized here: the lemma is `[Davies2026]`'s (Lemma B.1, p. 44), the transfer `[OAIMath2026]`'s; what is this project's is the formalization and the composing.** Not claimed: anything about Borel colourings; any value; the step for other dimensions or distance sets beyond the printed lemma (item 667). **The first thing through the gate on this machine**: each whole-library step under 5 GiB. **The front page is stale until its drafts are filed** — the audit's and the gate's count lines and the trust ledger's — and the next landing's drafts quote the front page, so **the Clerk files this landing's drafts before the next landing launches** (my ruling: alternative, launch the next landing at once and file both later — declined, its slots would quote words the first filing then changes; confidence high).
> — source: plans/FS131-close-inventory.md

**The fourteen drafts** are in `plans/FS131-LC1-landing.md`, section "Drafts for the front page (FS131-LC1)" (from its line 607 to the
heading "Open gate items at this landing"). Each names its file, its section and the exact words on `main` it
replaces or follows. The landing agent's checker of those slots is `data/fs131/lc1/drafts-slots.py`; I ran it against
`main` just before writing this: fourteen slots, each found once, the control absent.

**My choices where a draft leaves one to the coordinator** (file what the drafts say; use these only where a draft
offers alternatives or says "the coordinator's"):

1. The result is filed as **a corollary of two outside results, formalized here** — never as this project's theorem;
   if a draft's sentence says so already, it is filed as drafted.
2. The clause for every dimension and a finite set of distances stays **by hand** (the claim list's dated line); a
   draft that regrades only the plane clause and the equality is filed as drafted.
3. The milestone this belongs to (the Lean backlog) changes no state by this filing.

## Done means

1. **Slots first** (a saved stage): run `python3 data/fs131/lc1/drafts-slots.py main` in your tree; every slot found
   exactly once and the control absent, or you stop and message me with the slot that failed.
2. **The drafts in, by a script** (`data/fs131/fc1/file_fs131_lc1.py`; the pattern is this morning's
   `data/fs124/f2/file_fs124_l2.py`): it asserts every slot before it writes anything, replaces or inserts each
   draft's quoted text exactly (the lines under `>` in the record, joined as the target file wraps its lines; nothing
   reworded, nothing added), and prints what it did per draft. A draft that says counts "stand" changes nothing and
   is reported as such. (A saved stage.)
3. **The checks that read the front page**, each with its full output kept under `data/fs131/fc1/`:
   - the three digests of this landing's receipts against the previous landing's:
     `python3 scripts/gate_report.py axioms data/fs131/lc1/gate/receipt-axioms-final.log data/fs124/l2/gate/receipt-axioms-final.log CLAUDE.md`,
     the same with `vacuity` and `scripts/vacuity-baseline.txt` before `CLAUDE.md`, and with `assumptions` and
     `scripts/assumptions-ledger.txt` before `CLAUDE.md`;
   - `python3 tools/claude_md_fact_audit.py --base 94bb3f35c` and the same tool with `--dupes`. **A token the audit
     reports lost is not allow-listed by you**: list it as a `CHECK:` with where it was and what replaced it;
   - `python3 tools/bib_audit.py`;
   - the size budgets the fact audit enforces (`CLAUDE.md` under 80,000 bytes).
4. **The atlas, local only**: if a draft gives facts for the proof atlas, write them into
   `tools/viz_proof_atlas_facts.py` as drafted, then run the four steps of `visualizations/proof-atlas/README.md`
   (facts, check with its self-test, contrast, build) and commit the rebuilt page. **Publish nothing.** If the layout
   lint reports overlaps, a node's grade words are no longer in its ledger row, or a node needs a position no draft
   gives, that is a `CHECK:` — do not choose.
5. **The report** (`data/fs131/reports/FS131-FC1.md`, and the same text as your hand-back): per draft — filed, or
   "stands", or `CHECK:` with the reason; each check's last lines; every `CHECK:`; the commits on your branch.

## What is yours to decide

How the script is written; the order of the drafts; how to join a draft's lines to the target file's wrapping.
Nothing about the words: if a draft looks wrong to you — a count that does not match the receipt it cites, a
sentence that contradicts the record's own table — file nothing for that draft and say what you saw.

## The machine

This session is on the laptop, away from the remote: **commit on your branch and do not push**. No Lean build
is part of this job; do not start one. `/tmp` is wiped at power-off: keep what the report cites under
`data/fs131/fc1/`.

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).
