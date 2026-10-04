# Brief FS131-E4 — GAP-ELEVEN: the eleventh point of row 134's base with unit arcs — close it, exhibit the configuration, or repair the statement

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-E4
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job
  role: derive four fixed questions to a verdict each — derived, realized (the configuration exhibited exactly), or a GAP at a named step — and trace what the answer does to rows 134, 135 and 137 and to the base's consumers
  launch: now, beside FS131-I2m, FS131-I4h and FS131-IC2 (de Bruijn implementers, each on its own branch)
  mission: § Why this job
  statements: § The questions
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a realized configuration, a verdict the formalizers can use at once, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-E4.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` § Make the gate fail, and watch it fail, before you build any check
  record: `plans/FS131-E4-derivation.md`
  touches: `plans/FS131-E4-derivation.md`, `tools/fs131_e4_*.py`, `data/fs131/e4/`, `data/fs131/reports/FS131-E4.md`
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. The planner laying out the Lean proof of row 134's base step with unit arcs (FS131-KB, de Bruijn) found a step that every source argues only after
filling the holes of the map's tiles, in a setting where hole-filling is not available. The step finds an "eleventh" three-colour point near the vertex `u`,
which the walk's pigeonhole count needs. In the local base `u` is fixed, so a tile of one of `u`'s colours that wraps all the way round `u` inside `B(u, 1)`
cannot be filled without destroying `u` — and then the outer rim of `u`'s component borders that one tile, and the sources' argument gives no point. The
planner found no local contradiction for that picture but built no configuration; FS110-CD had named the same case and left it open. I ruled no statement
change before your verdict (inventory item 218 (a)).

## Why this job

Row 134's base with unit arcs is the step under FS112-N3-BASE, and through it under FS112-N3-DENSE3 and FS114-CV-EXISTS — the results behind rows 135 and 137,
which say that with unit arcs a six-map is governed by its four-colour vertices, the frontier's door (A) (`CLAUDE.md` § Where the problem stands, item 31).
So whether the eleventh point exists in the local setting bears on results the frontier is built from. Every answer is a result: a derivation closes the step
and the Lean proceeds as planned; a configuration is a counterexample to a step of a filed walk, and the rows above must be re-read; a repair changes
statements, and the consumers must be traced. Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."*
(`plans/STANDING-RULES.md` rule 4). His standard for this milestone: the Lean proof is the check (inventory item 111).

## The questions

The claim list is `data/fs131/claims-E4.md`: the finding, the sources it cites (FS110-CD's eleventh point and its open seam, the walk's own eleventh-point
step, FS110-CE's E6), `Row134BaseUA`'s Lean text, and the filed rows 134, 135 and 137, each copied by script, then the four questions. Read it whole.
The questions:

> **Q1 — the enclosure case.** In the base's setting (a valid six-coloured fragment covering `B̄(u, 2)`, unit arcs allowed, `u` cubic trichromatic, `BaseHyp u`
> — source: data/fs131/claims-E4.md § The questions

> **Q2 — the count without the eleventh point.** If the enclosure case can occur, does the 10 + 1 count of the walk close in that case by another route —
> — source: data/fs131/claims-E4.md § The questions

> **Q3 — the repair.** If neither Q1 nor Q2 closes the step: which repair holds — (b) a no-enclosure hypothesis on `Row134BaseUA`, with `localDense` choosing an
> — source: data/fs131/claims-E4.md § The questions

> **Q4 — the filed rows.** Do rows 134, 135 and 137, as filed and as their derivations prove them, rest on the local base at a fixed `u` (where the step is
> — source: data/fs131/claims-E4.md § The questions

## Done means

1. **Your readback first**: check the four quotations against the claim list and the claim list's quotations against their sources; restate the questions in
   your record; read the walk's base stage (`plans/FS112-N-proof.md` § Stage N3-3, in full), FS110-CB's D5 and FS110-CD's § 2.6 and § 2.8, FS110-CE's E6, the
   definitions of a valid fragment, `BaseHyp` and `NoInertNear` (their Lean text is in the claim list's file and on branch `fs131-w5b`), and the derivations
   of rows 134, 135 and 137 at the addresses `LEDGER.md` gives. Register your prediction per question before the written derivation.
2. **A verdict per question**, each in your lane's derivation form (statement, uses only, not claimed, argument, verdict, grade, minds, model, prior art,
   handoff). A realized configuration is exhibited exactly — its tiles, its arcs, its colouring — and its validity and the base's hypotheses checked by exact
   arithmetic or computer algebra with a control that goes red on a planted fault (no search; a step a search could decide is a `search request` in your
   report).
3. **Q3 and Q4's tables**: each consumer and row, whether it reads the step where enclosure can occur, its fate, and any corrected statement drafted for me to
   file (its slot named) — including, if a repair is needed, the exact Lean-level change to `Row134BaseUA` and to the four consumers in `Plane/ValidMap/BaseDense`.
4. Your record in stages headed "Stage n — SAVED", committed by explicit path; your derive gate (`.claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS131-E4-derivation.md`, from `plans/`) green; the report in standing rule 11's form. Stopping at a saved stage with a question left, named, is a
   good report.

## What is yours to decide

The route, the order of the questions, the form of any configuration, and the repair if one is needed. Attack the questions themselves: if the base's
hypotheses already forbid enclosure for a reason the planner missed (a distance bound inside the hole, say, or `NoInertNear` read at the enclosing tile's
boundary), that is a finding — say so with the address. If a row turns out not to read the local base at all, say that too.

## The machine

No Lean builds are needed for this job; if you run a check that needs more than a few gigabytes, run it under the slot
(`/home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 4 -- <command>`, `RUNNING.md` § Building). You start no agents of your own (standing rule
1: delegation is one level deep, because the coordinator can only review work it knows exists).
