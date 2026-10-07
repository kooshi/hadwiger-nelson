exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS132-P1: the asking lane after the outside release (BIBLIOGRAPHY.md [OAIMath2026]) became literature of this project
# (FS-131 inventory items 607-616). The re-rank of the frontier and the question of FS-132, the milestone that opens on it.
import os
RQ="data/external/EXT-OAI1-request.md"; FS="plans/FRONTIER-STUBS.md"
os.makedirs(ROOT+"data/fs132/briefs",exist_ok=True)
KW="\n".join([Q(RQ,"> We have an analysis trigger."),Q(RQ,"> You may use their proof as any other literature."),Q(RQ,"> 1. port or import: let's import and adopt parts piecemeal if needed.")])+"\n"
AIM="\n".join([Q("CLAUDE.md","1. **Given MR, the plane is the measurable problem.**"),Q("CLAUDE.md","3. **Density cannot give six.**"),
               Q("CLAUDE.md","4. **Regular colourings need seven, verified and almost everywhere**"),Q("CLAUDE.md","5. **So, given MR, Hadwiger–Nelson is one question: can vanishing holes save a colour?**"),
               Q("CLAUDE.md","6. **Its tools are Voronov's circle topology made robust, and the density topology**"),Q("CLAUDE.md","1. **Rank a route by its bearing on the answer**")])+"\n"
TOP="\n".join([Q(FS,"| 1 | **FS-124 the (Q) ring**"),Q(FS,"| 2 | **FS-123 the Siamese class**"),Q(FS,"| 3 | **FS-104 `χ_CP(ℝ²)` at six**")])+"\n"
ITEMQ="\n".join(item(n) for n in [607,611,613,614,615,616])+"\n"
b=f'''# Brief FS132-P1 — the frontier after an outside proof of six became this project's literature: the re-rank, and the question of the milestone that opens on it

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word. Launch line: "Your brief is on disk: read it in full first."*

brief: FS132-P1
  identity: Poros — your agent file (`.claude/agents/poros.md`) is your identity and your lane's workflow (job 1: the re-rank and the next question); invoke `poros-anomaly-hunt` fresh with the Skill tool for the re-read, as job 1 says, and `poros-reframing` if the frame itself has moved — it may have
  role: the ask lane at the largest change of ground this project has had — re-read what an outside release proves, in its Lean and in its manuscript, against this project's whole theory; re-rank the frontier with those theorems as literature; say what of the running Lean backlog still bears; and pose the question of FS-132, the milestone that opens on them, aimed at six against seven; and the stub of FS-133, a consequence Kooshi wants built on at once
  launch: into the first slot that frees; a Lean audit of the release is finishing and a reading of its manuscript is on its second half — their records are your inputs, and the reading's last stage reaches you by address when it is saved
  mission: § Why this job
  statements: § What Kooshi asked, and where the ground now is
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind
  channel: message the coordinator ("main") by SendMessage for **the question of FS-132 as soon as its card is saved** (a deriver's slot waits on it), for any consequence of the release that a short job could turn into a result this week (one is already named below — say whether it comes first), and for a question you cannot work around; the report goes to `data/fs132/reports/FS132-P1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/POROS-2026-10-07-after-release.md`
  touches: `plans/POROS-2026-10-07-after-release.md`, `plans/STUB-*.md` (question sections, and the stub you mint for FS-132 — never a banner, never another lane's bearing lines), `data/fs132/p1/`, `data/fs132/reports/FS132-P1.md`; **not** `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md` (your re-rank is a draft in your record: I file it), the outside clone at `/home/kooshi/source/math` (read it; write nothing into it)
  budget: about 350k by the harness's count, as guidance (your launch preloads the grokkings, about 150k); hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. Two weeks ago this project's theory arrived at one sentence — given measure rigidity, the plane's chromatic number is that of
measurable colourings proper at almost every unit pair, and the question is whether holes of vanishing density can save a colour — and
you ranked the frontier under it. Yesterday an outside organisation published, among 722 machine-found manuscripts, a proof that the
plane is not five-colourable. It proves that sentence's reduction outright, for every number of colours, by a rigidity theorem of its
own; then it removes five by deriving interface exclusions from measurable data alone, with no regularity assumed. This project built
its Lean proof today: it compiles at its pinned toolchain on the standard three axioms, and the statement is the claim. Kooshi has
made it literature of this project. The ground you ranked has moved under every stub. Rank it again.

## Why this job

The problem is now six or seven, for everyone, and the proof that made it so is public: every group that works on this problem can
read it today. What this project has that they do not is the other half — months of theory about exactly what the release leaves open:
the regularity programme at six, the tight six-maps, the local exclusions, and a kernel library of thousands of statements about them
— and a reduction it reached independently, so that it already knows what the next question is in its own words. Kooshi's instruction
is to use that: build on the release and move first. Which question is the one to move on is yours, by your lane's one rule — rank a
route by its bearing on the answer, never by its difficulty — and both of its answers must be results.

## What Kooshi asked, and where the ground now is

**His words** (`data/external/EXT-OAI1-request.md`, read whole — the file gives the five questions the third answers; the first is
the trigger of his standing instruction, the second his decision after the build, the third his plan: import; the front page's two
sentences; a stub for the consequence; the backlog paused until your re-rank):

{KW}
**What happened today, item by item** (the FS-131 inventory, `plans/FS131-close-inventory.md`; the first lines are quoted as addresses
— read each item whole: they carry what was checked by whom, and what was not):

{ITEMQ}
**Your inputs, by address** (read them whole; nothing in this brief stands in for them):
- the audit of the release's Lean: `plans/EXT-OAI1-audit.md` — stage 4 (the build, the axioms, the statement), **stage 6 (the proof's
  shape: the chain of named statements with their exact hypotheses, which hold for every number of colours and which for five, and
  the auditor's one-mind reading of where five is used)**, with `data/external/oai1/docindex-five.txt` (232 documented declarations);
- the reading of its manuscript: `plans/EXT-OAI2-reading.md` — stage 1 (the dictionary: their notion is this project's `χ_m⁰`
  object), stage 2 (the transfer, read in full: rigidity proved at the real algebraic numbers, by properties no number field has),
  and stage 3 when it is saved (the obstruction at five against rows 131–154, step by step: which steps are stated for every `k`, and
  for the five-only steps the statement about six that would be needed) — I send you its address the moment it lands;
- the release itself, read-only: `/home/kooshi/source/math` — the manuscript's source under its `preprints` folder for the
  five-colour paper, the Lean under `lean/OAI/Geometry/PlaneColoring`, and a catalogue of 371 other result families
  (`/home/kooshi/source/math/CONTENTS.md`) that nobody here has read.

**The ground as this project wrote it before today** (`CLAUDE.md` § The aim and § Counter-priors; first lines):

{AIM}
**The ranking you made** (`plans/FRONTIER-STUBS.md`, its top three; read the file whole):

{TOP}
## Done means

1. **Your readback and the re-read.** Check the quotations above against their sources; read the two records, the six inventory
   items, the manuscript's introduction and overview, and `plans/FRONTIER-STUBS.md` whole. Then the anomaly hunt, fresh, over the
   release against this project's theory: what does their proof do that this project believed needed more, and what does this
   project hold that their proof does not reach? Register, before you rank: which stub you expect to be first, and whether you
   expect the next milestone's question to be about six-colour measurable colourings directly or about one named step of their
   argument. Commit and push.
2. **The triage of every ranked stub and of the aim's six links**, each in one line with its reason: *answered* by the release
   (FS-104 is the first candidate — say exactly which form is answered and which is not); *unconditional now* (which sentences lose
   "given MR", and — from the reading's stage 2 — which keep it: the field rows do); *re-aimed* (the stubs about tight six-maps and
   the map step: does a finite cyclic core for measurable colourings, proved at five, change what route M's regularity step must
   supply at six?); *unchanged*; *closed as a direction*. Every answered or re-aimed stub gets its banner drafted (I file banners).
3. **The question of FS-132**, as a card in a stub you mint: existence form and structural form (the second not the first
   reworded), provisional bearings, what a YES and a NO each give, and the first claim a deriver should take. The frame to test,
   stated as a question and not as a route: the release closes five by a cover of order two against a disc; at six a point may
   carry three colours and that obstruction is gone — so what, in this project's holdings or in the release's statements that hold
   for every number of colours, takes its place? **Message me when the card is saved.**
4. **The one-class consequence gets a stub of its own — Kooshi's word: "definitely build on it... write the stub".** It is named
   by the manuscript's reader (inventory item 613 (1); its sketch is § 2.6 of `plans/EXT-OAI2-reading.md`): the release's rigidity
   theorem run for one colour class would give `α₁(ℝ²) = m₁(ℝ²)` and its fractional form with no hypothesis — a clause of a 2026
   conjecture and a 1996 question — and the manuscript does not state it; one step is unchecked. **Mint its stub as FS-133** (the
   number is fixed), in the stub rule's full form: the mission context in plain language, the question card with both forms, what
   each answer gives, the question in the literature it answers (`CLOSED-QUESTIONS.md` is this project's list of those;
   `LEDGER.md` row 129 is where this project stands on it), the unchecked step as the first claim a deriver takes, and the
   prior-art risk of someone else drawing it from a public proof. Say whether FS-133 or FS-132 takes the deriver's first slot,
   and list any other consequence a short job could close this week, each the same way.
5. **The backlog is paused, by his word, until this re-rank** ("pause the backlog, lets come to a stopping point, collect ourselves
   and have poros rerank"). FS-131's waves 6 (the saturated class), 7 (the four-colour vertex), 9 (the reductions) and 10 (the
   arithmetic floors) each have briefed jobs waiting; their state is `plans/SESSION-HANDOFF-2026-10-06.md` §§ 2–4. In one table:
   which waves formalize something the new frontier stands on and resume first, which formalize something the release answers or
   supersedes and are retired or re-aimed, and which can wait — so that three agent slots go where they bear. This table is what
   restarts the milestone, or does not.
6. **The re-rank**, as a draft of `plans/FRONTIER-STUBS.md`'s table in your record, with FS-132 placed; and the catalogue's other
   families that a route of the new ranking could use — named from their catalogue entries only, each marked unread.
7. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed; your gate
   (`.claude/skills/poros/scripts/poros_gate.py all` on the card, from its skill directory's conventions) green; the report in
   standing rule 11's form. Stopping at a saved stage with the card sent and the re-rank part-drafted is a good report.

## What is yours to decide

The ranking, the question, its two forms, and what comes first. Attack the frame — including this brief's: if the release shows that
this project's road to seven (the tight map made a map, then a local exclusion) is not the shortest one, or that the question is not
"six against seven for measurable colourings" at all, that is the finding this job exists to make. And attack the release's reach as
hard: what it proves is five; say exactly what it does not prove. Do not lean toward yes: a question whose NO is a theorem is as good
a milestone as one whose YES is. You start no agents of your own (standing rule 1: delegation is one level deep, because the
coordinator can only review work it knows exists).
'''
open(ROOT+"data/fs132/briefs/FS132-P1-rerank.md","w").write(b)
print("written FS132-P1")
