# Brief FS131-E5 — two steps the kernel could not take: NB3-END item 2 (`n3_end`'s first case) and `bend_away`'s end case — derive each, exhibit the configuration, or repair the statement

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-E5
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job
  role: derive two fixed questions to a verdict each — derived, realized (the configuration exhibited exactly), or a GAP at a named step with a repaired statement — and trace what each answer does to FS112-N3-END, FS112-N2-BENDS and row 135
  launch: in the next free slot (inventory item 306), beside de Bruijn implementers on their own branches
  mission: § Why this job
  statements: § The questions
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a realized configuration, a verdict an implementer can use at once, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-E5.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` § Make the gate fail, and watch it fail, before you build any check
  record: `plans/FS131-E5-derivation.md`
  touches: `plans/FS131-E5-derivation.md`, `tools/fs131_e5_*.py`, `data/fs131/e5/`, `data/fs131/reports/FS131-E5.md`
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. The Lean backlog (FS-131) is turning this project's hand-derived results into kernel-checked ones, and two of its implementers have each reached a
step of a filed hand proof that they could not take. Both steps sit under row 135 (with unit arcs, a six-map is governed by its four-colour vertices). The
first is in FS112-N3-END, the end of a stuck chain: NB3-END's item 2 says two tiles of the flank colour at `S′` are two sectors there, and FS131-I5e found a
configuration the text does not exclude, in which they are one sector, with a repair checked only to leading order. The second is in FS112-N2-BENDS: the
tangent bend `bend_away`, already repaired once (FS131-I4n's counterexample: the radius-2 arc must lie in the domain), has an end case at `q_A` that I4n asked
to have re-derived before anyone formalizes it. Neither implementer built a counterexample to a statement; each named the step.

## Why this job

A result counts as held only when its Lean module passes the gate, and the kernel cannot check a step that has no hand proof. Every answer is a result: a
derivation lets the implementers proceed; a configuration is a counterexample to a step of a filed walk, and row 135 must be re-read; a repair changes
statements, and their consumers must be traced. Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."*
(`plans/STANDING-RULES.md` rule 4). The findings, and the ruling that launched you:

> 305. **I5e's GAP at NB3-END item 2, by message** (FS131-I5e, mid-job, 2026-10-05) — the step behind `n3_end_of_not_inType`'s repeated colour; not a
> — source: plans/FS131-close-inventory.md

> 296. **FS131-I4n done** (harness ≈ 563k; record `fs131-w4`'s `plans/FS131-I4-implementation.md`, Stages 41–43; report `data/fs131/reports/FS131-I4n.md`; commits
> — source: plans/FS131-close-inventory.md

> 306. **Ruling on item 305, and the next derivation job.** Choice: `n3_end_of_not_inType` stays `sorry` in I5e's job and goes to an Ephodos re-derivation,
> — source: plans/FS131-close-inventory.md

## The questions

The claim list is `data/fs131/claims-E5.md`: `n3_end`, `n3_end_of_not_inType`, NB3-END items 1–5 and `bend_away`, each copied by script, then the two
questions. Read it whole. The questions:

> **Q1 — NB3-END item 2.** In `n3_end_of_not_inType`'s setting, does "the two `g`-tiles are two sectors of `g` at `S′`" hold — in particular in item 305's configuration (one `g`-sector at `S′` with cone `[α+π, α+2π]`, `c` carried at `S′` only by a `c`-horn along `−a` on the `+n` side of it, possible only when `κ₄ < 1`)? Answer with a derivation of the step (I5e's leading-order repair, made exact with the closure property it names, or another), or that configuration exhibited exactly, or a repaired statement of `n3_end_of_not_inType` and `n3_end` with what changes in FS112-N3-END and in row 135.
> — source: data/fs131/claims-E5.md § The questions

> **Q2 — `bend_away`'s end case.** In `bend_away`'s setting, at the arc's end `q_A`, where `ω(A)` (curvature 1) bounds the uncovered region beyond the arc's end (item 296's fourth piece), does the tangent bend go through? Answer with a derivation of the end case, or a configuration exhibited exactly, or a repaired statement of `bend_away`, with what changes in FS112-N2-BENDS (N2-TAN) and in row 135.
> — source: data/fs131/claims-E5.md § The questions

## Done means

1. **Your readback first**: check the quotations above against the claim list and the claim list's quotations against their sources; restate the questions in
   your record; read NB3's stage 1 (`plans/FS112-NB3-verification.md`) and the walk's N3 stages (`plans/FS112-N-proof.md`), FS112-N2-BENDS and N2-TAN at the
   addresses `plans/FS112-derivation.md` gives, inventory items 288–291 and 296, I5d's and I5e's notes under `n3_end` in
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md` (Stages 18 on), and I4n's Stages 41–43 in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/plans/FS131-I4-implementation.md`
   (also on branch `fs131-w4ba`, by `git show`). Register your prediction per question before the written derivation.
2. **A verdict per question**, each in your lane's derivation form (statement, uses only, not claimed, argument, verdict, grade, minds, model, prior art,
   handoff). A realized configuration is exhibited exactly — its tiles, its arcs, its colouring — and its validity and the setting's hypotheses checked by
   exact arithmetic or computer algebra with a control that goes red on a planted fault (no search; a step a search could decide is a `search request` in your
   report).
3. **The trace**: for each answer, whether FS112-N3-END, FS112-N2-BENDS and row 135 as filed read the step; their fate; and any corrected statement drafted for
   me to file (its slot named) — including, if a repair is needed, the exact Lean-level change to the statements in the claim list.
4. Your record in stages headed "Stage n — SAVED", committed by explicit path; your derive gate (`.claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS131-E5-derivation.md`, from `plans/`) green; the report in standing rule 11's form. Stopping at a saved stage with a question left, named, is a
   good report.

## What is yours to decide

The route, the order of the questions, the form of any configuration, and the repair if one is needed. Attack the questions themselves: if the setting's
hypotheses already exclude I5e's configuration for a reason neither implementer saw (terminality at `S′`, say, or a horn bound read elsewhere), that is a
finding — say so with the address. If row 135 turns out not to read a step at all, say that too.

## The machine

No Lean builds are needed for this job; if you run a check that needs more than a few gigabytes, run it under the slot
(`/home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 4 -- <command>`, `RUNNING.md` § Building). You start no agents of your own (standing rule
1: delegation is one level deep, because the coordinator can only review work it knows exists).
