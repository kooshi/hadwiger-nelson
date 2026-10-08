#!/usr/bin/env python3
import sys, subprocess
sys.path.insert(0, "/home/kooshi/source/lean-dir/data/fs131/briefs/scripts")
from mkbrief import Q
now = subprocess.run(["date", "-u", "+%Y-%m-%d %H:%M UTC"], capture_output=True, text=True).stdout.strip()
out = f'''# Brief FS127-Q1 — the question that stalled three times, written so that someone outside this project can try it

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word. Launch line: "Your brief is on disk: read it in full first."*

brief: FS127-Q1
  identity: Ephodos, the deriver — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; load `ephodos` fresh with the Skill tool
  role: the writer of one outward document — the existence step that stalled three times in the milestone on six by the nerve, posed as a self-contained question for a mathematician who has never seen this repository; you state, you do not re-derive
  launch: now; nobody else writes the files you touch, and no landing is in flight
  mission: § Why this job
  statements: § What you are writing up
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if the record shows the three stalls to be something other than what § What you are writing up says, if two records state the open step differently, or if while writing you see the step close; the document goes to the record, and a short hand-back to "main" when it is committed
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS127-Q1-question-for-a-third-party.md` (new)
  touches: `plans/FS127-Q1-question-for-a-third-party.md`, `data/fs127/q1/provenance.md` (new), `data/fs127/reports/FS127-Q1.md` (new); on `main`, committed by explicit path. Nothing else
  budget: about 250k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit) when the statements are fixed and again when the document is drafted, and hand back before you would guess 400k

Hello. This is a writing job with a real reader at the end of it. Three times in one milestone a derivation reached the
same step and could not take it, and Kooshi wants to hand that step to someone outside the project and see what they do
with it. The reader will have the document and nothing else: not this repository, not our vocabulary, not you.

## Why this job

Kooshi's words:

{Q("data/fs127/REQUEST-third-party.md", "K1: ")}
Why it is worth an outsider's time: this project's statements about six colours all begin "if a colouring has a point
with such-and-such data on its unit circle". Whether every colouring has such a point is the step nobody here has taken;
with it, the exclusions held downstream would say something about every colouring. A fresh mind with other tools —
geometric measure theory, descriptive set theory, ergodic theory — may see what three attempts from inside one
vocabulary did not. A proof, a counterexample and a clean reduction are all results.

Kooshi sends the document himself. No agent posts, mails or publishes anything.

## What you are writing up

The front page's own description of the step, copied by script (the row is one long line):

{Q("CLAUDE.md", "| 3 | **FS-127 lateral extent**", "§ Paths forward, ranked")}
Where the record is — fixing the exact statements from it is the first half of your job, and they are not copied here
because choosing the smallest open form of each is the judgment I am asking you for:

- the stub of the step: `plans/STUB-lateral-extent.md` (its title is the older, map-class form; its bearing lines carry
  the current one);
- the milestone's theorem record: `plans/FS132-derivation.md` — § 3 (centres exist; the extraction) and § 8 (stalls and
  gaps, each with its step and its smallest open form in its handoff line);
- the milestone's inventory: `plans/FS132-close-inventory.md` — search it for the step's number, FS-127; the entries near
  lines 735 and 987 record how the existence forms left the milestone, and at whose word;
- the neighbouring open steps, for the boundary of this one: `plans/STUB-seed-remainder.md`, and the stub named for the
  top colour at six in `plans/FRONTIER-STUBS.md`;
- the outside work the milestone stands on, as read here: `plans/EXT-OAI2-reading.md` (§ 3.4 and § 4.3), with its entry
  in `BIBLIOGRAPHY.md` under the key OAIMath2026;
- the translation table from this project's coined words to the literature's: `BIBLIOGRAPHY.md` § E.

## Done means

1. **The statements, fixed first** (a saved stage). From the record: the existence step in its smallest open form, as a
   precise statement with every quantifier; the variants the record distinguishes (every colouring, or only colourings of
   a restricted kind; which data count as usable); and, for each of the three attempts, the one statement it could not
   prove. Where two records word a statement differently, say so to me before choosing.
2. **The document**, self-contained, for a reader with a research background in analysis or combinatorial geometry and no
   knowledge of this project:
   - the setting and every definition in standard mathematical language. No word coined here appears undefined, and
     where the literature has a word, use the literature's; no job id, ledger row, stub number or file path anywhere in
     the outward text;
   - the question, then its variants, each stated exactly;
   - what the reader may assume: printed theorems, each with its citation and what it states; and, kept visibly apart,
     this project's own results that give context — each stated in full and marked as derived by hand by one mind and
     not independently checked. Pose the question so that it stands whether or not those are right, or say exactly which
     of them it rests on;
   - the three attempts: for each, the route in a paragraph, the precise step it could not take, and what is missing;
   - what is known to be false — natural strengthenings that fail, with the example — so that nobody spends a week on
     them; and two or three colourings the reader can test an idea against;
   - what would count as an answer (a proof, a counterexample, a reduction to a named statement), and what each would
     and would not imply for the chromatic number of the plane, said without inflation;
   - what is not claimed.
   As short as completeness allows. Mathematics in LaTeX notation inside Markdown.
3. **Words about outside work** say what its files state and nothing else — nothing about its authors or how it was
   made.
4. **A provenance file** beside it (`data/fs127/q1/provenance.md`): for each statement in the outward document, where in
   the record it comes from and at what grade. That file is how I review the document by artifact, and it is the only
   place the addresses go.
5. **Read it cold before you hand back**: as the reader, with nothing else open — is there a term you would have to ask
   about, a quantifier you would have to guess, a claim whose status you could not tell? Then a short hand-back: where the
   document is, the statements you fixed, anything in the record you found inconsistent.

## What is yours to decide

Which form of the step is the smallest honest one to lead with; the order and length of the document; which of the
project's results a reader needs as context and which only clutter; the examples. If the record supports a sharper or a
different question than the front page's row, pose that one and tell me why.

Not yours in this job: a new derivation of the step. If the step closes under your hands while you write, stop and
message me — that is a result and it changes what Kooshi sends.

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists). Your session may be halted mid-job; that
is the budget and not you, and stopping at a saved stage with a clear "what is left" is a good hand-back.
'''
open("/home/kooshi/source/lean-dir/data/fs127/briefs/FS127-Q1-third-party-question.md", "w").write(out)
print("ok", len(out))
