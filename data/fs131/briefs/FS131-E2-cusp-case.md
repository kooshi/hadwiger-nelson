# Brief FS131-E2 — the cusp case of the both-kind four-colour clause: derive it, or exhibit the fragment

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-E2
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job
  role: derive three fixed questions to a verdict each — derived, realized (the fragment exhibited exactly), or a GAP at a named step — and trace what the answer does to the results that rest on the clause
  launch: now, beside FS131-I2f, FS131-I3f and FS131-I4 (de Bruijn implementers, each on its own branch)
  mission: § Why this job
  statements: § The questions
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a realized fragment, a derivation the formalizers can use at once, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-E2.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` § Make the gate fail, and watch it fail, before you build any check
  record: `plans/FS131-E2-derivation.md`
  touches: `plans/FS131-E2-derivation.md`, `tools/fs131_e2_*.py`, `data/fs131/e2/`, `data/fs131/reports/FS131-E2.md`
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. The implementer formalizing wave 3 of the Lean backlog (FS131-I3e, de Bruijn) found that a hand lemma this project relies on was argued as if every
tile meeting a point fills a wedge of directions there. A tile can instead meet the point in a cusp — between two tangent arcs, a cone of one direction —
and then the argument's key step (two tiles' cones overlap in an interval, against their disjointness) does not fire. It drew a local picture with three
colours at the point and found no contradiction, but built no whole fragment. I ruled a repair for the Lean (no cusp at the point, a weaker statement);
the mathematical question is yours.

## Why this job

The lemma is FS116-V5-U1's four-colour clause: at a point carrying both side colours of a unit arc, a non-Siamese simple fragment has at least four
colours. FS112-N3-NOBOTH says the same with "or a repeated colour", and several hand results of FS-112 and FS-116 rest on one or the other — the
local-exclusion work behind `LEDGER.md` rows 135–150 and the frontier's door (A) (`CLAUDE.md` § Where the problem stands, item 31). FS-116's own records
know zero-angle cones: FS116-N3-CROSS's statement has "every tile of p at y has a cone at y of zero angle". So whether a cusp can cost the fourth colour
bears on results the frontier is built from. Either answer is a result: a derivation restores the clause in full and the Lean can be strengthened; a
fragment is a counterexample to a filed hand lemma, and the consumers must be re-read. Kooshi: *"A proven theorem about why its impossible is also valid.
All novel knowledge is a success."* (`plans/STANDING-RULES.md` rule 4). His standard for this milestone: the Lean proof is the check (inventory item 111).

## The questions

The claim list is `data/fs131/claims-E2.md`: the hand statement, both formal forms, the finding and ruling, and FS112-N3-NOBOTH, each copied by script,
then the three questions and their common setting. Read it whole. The questions open:

> **Q1 — the cusp case of FS116-V5-U1's four-colour clause.** Is it true, with no further hypothesis, that `z` carries at least four colours, also when
> — source: data/fs131/claims-E2.md § The questions

> **Q2 — the same for FS112-N3-NOBOTH.** Is the centre of a both-kind unit arc a vertex with at least four colours or a repeated colour, also when a tile at
> — source: data/fs131/claims-E2.md § The questions

> **Q3 — the consumers.** For each result that rests on the four-colour clause of FS116-V5-U1 or on FS112-N3-NOBOTH — FS116-V5-DICHO, FS116-V5-CROSS-S, V5's
> — source: data/fs131/claims-E2.md § The questions

## Done means

1. **Your readback first**: check the three quotations against the claim list and the claim list's quotations against their sources; restate the
   questions in your record; read FS116-V5-U1's argument (`plans/FS116-V5-verification.md` § V5-U1's argument, which its entry names), FS112-U1's (`plans/FS112-derivation.md`, its entry, and the records it cites) and FS112-N3-NOBOTH's (N3 stage N3-3; `plans/FS112-NB3-verification.md` §1.4), and the
   definitions of a valid, simple and non-Siamese fragment, with addresses. Register your predictions per question before the written derivation.
2. **A verdict per question**, each in your lane's derivation form (statement, uses only, not claimed, argument, verdict, grade, minds, model, prior art,
   handoff). A realized fragment is exhibited exactly — its tiles, its arcs, its colouring — and its validity checked by exact arithmetic or computer
   algebra with a control that goes red on a planted fault (`plans/STANDING-RULES.md` rule 5 allows exact arithmetic; no search — a step a search could
   decide is a `search request` in your report).
3. **Q3's table**: each consumer, whether it reads the clause where a cusp can occur, and its fate; any filed ledger row or `CLAUDE.md` statement that
   changes, with the correction drafted for me to file (its slot named).
4. Your record in stages headed "Stage n — SAVED", committed by explicit path; your derive gate (`.claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS131-E2-derivation.md`, from `plans/`) green; the report in standing rule 11's form. Stopping at a saved stage with a question left, named, is a
   good report.

## What is yours to decide

The route, the order of the questions, and the form of any fragment. Attack the questions themselves: if the setting hides a hypothesis that makes the
cusp case vacuous or trivially fine (a definition of FS-116's that forbids cusps where the clause is used, say), that is a finding — say so with the
address. If a consumer turns out not to read the clause at all, say that too.

## The machine

No Lean builds are needed for this job; if you run a check that needs more than a few gigabytes, run it under the slot
(`/home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 4 -- <command>`, `RUNNING.md` § Building). You start no agents of your own (standing rule
1: delegation is one level deep, because the coordinator can only review work it knows exists).
