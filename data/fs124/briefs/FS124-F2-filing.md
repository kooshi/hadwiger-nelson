# Brief FS124-F2 — file the fifteen front-page drafts of a landing that is already on `main`, verbatim, and run the checks that read the front page

*Written 2026-10-13 16:04 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS124-F2
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; here you are the coordinator's pen for one filing
  role: the pen for one owed filing — a Lean module landed on `main` six days ago and the front page still shows the counts from before it; you put the landing agent's fifteen drafts into their slots word for word, run the checks that compare the front page with the gate's receipts, and report every place where you would have had to choose
  launch: now, in a tree of your own; two other jobs are running (a ranking under `plans/` and `data/fs131/` on `main`, a planner on branch `fs131-wnf`) — neither writes a file you write, and nothing is landing
  mission: § Why this job
  statements: § What is filed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a draft's slot is not found exactly once, if two drafts touch the same words, or if a check fails in a way no draft explains; the report goes to `data/fs124/reports/FS124-F2.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `data/fs124/reports/FS124-F2.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wf2` (branch `fs124-f2`, cut from `main` today; no build is needed and none is run): the files the drafts name — `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `ARCHITECTURE.md`, `plans/FRONTIER-STUBS.md`, `plans/FS124-derivation.md`, `tools/claude_md_fact_audit.py`, `tools/viz_proof_atlas_facts.py`, `visualizations/proof-atlas/` — and nothing else of the front files; your own script and outputs under `data/fs124/f2/`; `data/fs124/reports/FS124-F2.md`. Commit on your branch by explicit path; the coordinator merges it
  budget: about 150k by the harness's count, as guidance; save a stage (a commit) after the slots are checked, after the drafts are in, and after the checks; hand back at a saved stage if you pass about 250k

Hello. This is a filing that was left undone when the last session ran out of its weekly budget, and everything after it
waits on it.

## Why this job

On 2026-10-07 the second Lean module of the milestone on unit arcs landed on `main` through the full gate. Its landing
agent wrote fifteen drafts for the front page — the audit's counts, the gate's counts, three ledger rows' grades, the
sentences that say what is now kernel-checked — each with the exact words it replaces. They were never filed. So the
front page (`CLAUDE.md`) still reads 7,015 records where the library has 7,420, and the script that compares the front
page with a gate's receipts fails against it. The next landing cannot pass until this is filed, and the project is
being prepared for publication, where the front page is the first thing a reader checks against the kernel.

The drafts are a lane's words and they go in verbatim: I coordinate and do not author, and you are my pen. Where a
draft leaves something to "the coordinator", my choices are in § What is filed; where you would otherwise have to
guess, you write a `CHECK:` line and do not guess.

## What is filed

The landing as I logged it, with my receipt:

> 50. **FS124-L2 — LANDED: the second module is on `main` (its message 20:5x UTC, logged 20:58 UTC; `origin/main` at `e89c4e92d`, a fast-forward; the gate ran at `da96003b1`; record `plans/FS124-L2-landing.md`; receipts `data/fs124/l2/gate/`).** Its words: "the full gate is green on its first pass at da96003b (every step exit 0 but the one planted control; zero sorry; 7420 records = 7364 clean, 28 axiom-free, 23 imported, 5 purchases; vacuity declarations=15928 refutations-skipped=228 sites=1448, no new site; the nine assumption counts unchanged)"; "No statement changed (523 stored constants compared); no gap found in the read-aloud; C124-BOTH's second clause is now a kernel theorem in the claim list's words." **Three departures from the brief's expectations, each in its record**: "(1) 405 records filed, not 355 — every declaration a person typed, definitions and structures with the theorems, as the last two landings filed; (2) the assumptions step asked for two declarations, which I classed and added as `.condition` lines (Plane.IsTriod, Plane.IsTriodCut: concluded by no library theorem; none of the nine counts moves, the ledger gains no row); (3) the pushed tip differs from the gated commit in data/, plans/ and ONE line under scripts/ — the vacuity baseline header's count line, refiled after the scan's final run as the brief says, with the vacuity step run again on it (exit 0, header match 9 of 9)." "The front-page drafts are written, in the record (15 drafts, 17 slots each found once on main at 07290735)." **My receipt** (by artifact, 20:56–20:58 UTC): `git merge-base --is-ancestor da96003b1 origin/main` — the gated commit is in `origin/main`; local `main` fast-forwarded to `e89c4e92d`; `rg -c '\bsorry\b'` on each of the eight modules under `Proofs/HadwigerNelson/Plane/` (`CircleCrossing`, `OnePiece`, `ThreePiece`, `ClosePair`, `ClosePairWitness`, `ClosePairModel`, `SectorPoint`, `ThreeArcs`) — 0 in every one; `SectorPoint.lean` line 56 is `theorem IsSector.hasArcEdges … : D.HasArcEdges` and line 75 the spec example `example : sectorPoint.HasArcEdges := sectorPoint_isSector.hasArcEdges`; `data/fs124/l2/gate/axioms-final.log` ends "axioms: OK — 7364 clean, 28 axiom-free, 23 imported, 5 declared purchase(s)", `exit=0`; `axiom-lines-final.txt` holds four `axiom` lines, the three declared outside theorems and the checker's docstring example, no `sorryAx`; the vacuity and assumptions digests end `exit=0`. **Not checked by me**: the three digests against the previous receipts (they are run after the counts are filed), the read-aloud, the list of which of the thirty entries are kernel theorems, the two `.condition` lines' classing. Ruling: **the nine statements of the second module are held** — kernel-checked through the gate on the standard three axioms, no statement changed; alternative weighed: holding the word "held" until the three digests run against the filed counts — declined, because the digests compare the front page's numbers with the receipts and say nothing about the theorems; confidence high in the landing, medium that departure (2) needs no ruling (read the record's section on it at the filing). **OWED, FIRST WHEN THE BUDGET RETURNS — the filing was not made in this session (the wind-down)**: `CLAUDE.md`'s gate counts, audit counts and the open-milestones sentence still read the state before this landing, so `scripts/gate_report.py` will fail against it until the 15 drafts are filed (script on the pattern of `data/fs124/l1/file_fs124_landed.py`; slots checked by the landing's own `data/fs124/l2/drafts-slots.py`; fact audit `--base 07bf6096` and `--dupes`; the atlas rebuilt locally), then the asking lane's re-rank draft, then whether FS-124 is Closed.
> — source: plans/FS124-close-inventory.md

**The fifteen drafts** are in `plans/FS124-L2-landing.md`, section "Drafts for the front page (FS124-L2)" (from its line 569 to the heading
"Open gate items at this landing"). Each names its file, its section and the exact words on `main` it replaces or
follows. The landing agent's own checker of those slots is `data/fs124/l2/drafts-slots.py`; I ran it against `main`
just before writing this and it found every slot once.

**My choices where a draft or the record leaves one to the coordinator** (mine, each a ruling already logged; file what
the drafts say and use these only where a draft offers alternatives or says "the coordinator's"):

1. The milestone stays **Derived**, not Closed: fourteen of its thirty entries are kernel theorems, and five entries
   handed to the kernel lane were planned by nobody (the record's stage 6 table and its open gate item 6).
2. The two predicates declared to the assumptions step as conditions stand as declared (the record's stage 4); the
   one-line theorem that would make the declarations unnecessary is an open gate item, not part of this filing.
3. The entry whose sentence the kernel holds by a different witness than the entry's own (open gate item 7) is **not
   regraded**; if a draft already says, in the landing agent's words, that the kernel holds the sentence by another
   witness, that sentence is filed as drafted.

## Done means

1. **Slots first** (a saved stage): run `python3 data/fs124/l2/drafts-slots.py main` in your tree; every slot found
   exactly once and the control absent, or you stop and message me with the slot that failed.
2. **The drafts in, by a script** (`data/fs124/f2/file_fs124_l2.py`; a pattern is `data/fs124/l1/file_fs124_landed.py`):
   it asserts every slot before it writes anything, replaces or inserts each draft's quoted text exactly (the lines
   under `>` in the record, joined as the target file wraps its lines; nothing reworded, nothing added), and prints
   what it did per draft. A draft that says counts "stand" changes nothing and is reported as such. (A saved stage.)
3. **The checks that read the front page**, each with its full output kept under `data/fs124/f2/`:
   - the three digests of the landing's receipts against the previous landing's:
     `python3 scripts/gate_report.py axioms data/fs124/l2/gate/receipt-axioms-final.log data/fs124/l1/gate/receipt-axioms-final.log CLAUDE.md`,
     the same with `vacuity` and `scripts/vacuity-baseline.txt` before `CLAUDE.md`, and with `assumptions` and
     `scripts/assumptions-ledger.txt` before `CLAUDE.md` (run `python3 scripts/gate_report.py --help` if a form is
     refused, and report the form that worked);
   - `python3 tools/claude_md_fact_audit.py --base 07bf6096` and the same tool with `--dupes`. **A token the audit
     reports lost is not allow-listed by you**: list it as a `CHECK:` with where it was and what replaced it — the
     allow-list takes a reason, and the reason is my ruling;
   - `python3 tools/bib_audit.py`;
   - the size budgets the fact audit enforces (`CLAUDE.md` under 80,000 bytes).
4. **The atlas, local only**: if a draft gives facts for the proof atlas, write them into
   `tools/viz_proof_atlas_facts.py` as drafted, then run the four steps of `visualizations/proof-atlas/README.md`
   (facts, check with its self-test, contrast, build) and commit the rebuilt page. **Publish nothing.** If the layout
   lint reports overlaps or a node needs a position no draft gives, that is a `CHECK:` — do not choose a position.
5. **The report** (`data/fs124/reports/FS124-F2.md`, and the same text as your hand-back): per draft — filed, or
   "stands", or `CHECK:` with the reason; each check's last lines; every `CHECK:`; the commits on your branch.

## What is yours to decide

How the script is written; the order of the drafts; how to join a draft's lines to the target file's wrapping. Nothing
about the words: if a draft looks wrong to you — a count that does not match the receipt it cites, a sentence that
contradicts the record's own table — file nothing for that draft and say what you saw. That is a finding, and I would
much rather have it than a tidy filing.

## The machine

This session is on the laptop, away from the remote: **commit on your branch and do not push** — the server is
unreachable, and a failed push is not an error to fix. No Lean build is part of this job; do
not start one. `/tmp` is wiped at power-off: keep what the report cites under `data/fs124/f2/`.

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).
