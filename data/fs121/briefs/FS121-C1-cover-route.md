# Brief FS121-C1 — Ephodos: FS-121's cover route, opened by the plan's trigger (NO-PAR)

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS121-C1
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job's procedure, opening with `ephodos-recognition` invoked fresh with the Skill tool
  role: a derivation job on FS-121's cover route: first state its claim precisely for the coordinator to freeze, then derive it
  launch: now, beside FS121-D2 (another derivation job of FS-121), FS121-V2 (a blind verifier on other claims) and FS-116's jobs
  mission: § Why this job
  statements: § The question you open on
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — a derivation job; but write nothing about your work where FS121-V2 or FS116-V2 could read it before their verdicts (standing rule 8): only your record, your data directory, your tools and your report
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/fs121/reports/FS121-C1.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` is part of it too if you build an exact check
  record: `plans/FS121-C1-proof.md`
  touches: `plans/FS121-C1-proof.md`, `data/fs121/c1/`, `tools/fs121_c1_*.py`, `data/fs121/reports/FS121-C1.md`
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are Ephodos, opening FS-121's second route.

## Why this job

FS-121's plan registered a decision before any round ran: if honest saturation at six is not reduced to a named step, the cover route opens
(`plans/FS121-map-step.md` § 4.1, "Trigger for the cover route"). Round 2's FS121-D3 (`plans/FS121-D3-proof.md`) found honesty free
(FS121-D3-GRUNDY: every a.e.-proper colouring becomes a measurable Grundy colouring with the lower colour bound at every interface) and the
claim open at its upper colour (TOP₆), which is at least as strong as the claim itself. I ruled that no smaller step was reached, so the
trigger fired (`plans/FS121-close-inventory.md`). The cover route needs its own NO — NO-PAR, a NO for a class of maps whose boundaries need
not be arcs — and with MUA-FIN at six (FS-120's rung) it gives seven. FS121-D3 § 3.5 adds a reading (one mind): the cover route can run on
measurable Grundy partitions, which are honest and have no lenses, so FS111-M2-NOSEL's obstruction is not met.

## The question you open on

The stub's statement of the rung, verbatim:

> 1. **At six, the cover route: NO-PAR** — no map whose boundaries lie on unit parallels (outer and far) of their own classes' components carries an
> — source: plans/STUB-map-step.md § The question

(The stub's sentence continues on its next lines; read it there in full, with the note on row 134's N4 step.) The plan's trigger, verbatim:

> **Trigger for the cover route.** D3's stop rule fires with honest saturation not reduced to a named step. The cover route then opens as the next slot,
> starting from N4.
> — source: plans/FS121-map-step.md § 4.1 The route, and the alternative weighed

NO-PAR is **not yet on the frozen list**. Your first stage states it precisely — the class of maps (or of Grundy partitions, if you take
D3's reading), the colour count, what "outer and far" parallels are, its *not claimed* line, its seven-colour inhabitant or where six is
spent (the list's vacuity rule), and any lemma you will derive on the way — in a file named proposed-claims.md in your data directory (data/fs121/c1), in the frozen list's
form (statements only: no grade, no route, no verdict, no mind count). Commit it, send its path to "main", and carry on: I freeze it into
the list as a dated addendum, and a blind verifier takes it from there later.

## What you read

The plan (`plans/FS121-map-step.md` § 4.1–4.4), the frozen list, the stub in full, round 2's `plans/FS121-D3-proof.md` (§ 2.1–2.2 and § 3.5),
row 134's chain and its N4 step (`LEDGER.md` row 134 and the records it cites), FS-111's cover-route entries (`plans/FS111-derivation.md`:
M2-COV, M2-FIX, M2-HULLC, M2-NOSEL, M2-DISCK7, M2-REDUCE-C), and the grokkings in your context.

## Done means

1. The proposed-claims file in your data directory, committed at the end of stage 1, and its path sent to "main".
2. **Your record**, `plans/FS121-C1-proof.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/FS121-C1-proof.md`
   from the repository root before each stage's commit: the readback, the recognition stage, the proposed statements, then a `derivation:`
   entry for NO-PAR with its verdict (TRUE, FALSE with a counterexample given by formula and checked exactly, GAP at a named step, or
   MISSTATED), and an entry for every lemma.
3. **The report** in the standing rules' form. Your last words are exactly "FS121-C1 idle; report sent to the coordinator": the report goes
   by message, and the hand-back carries nothing else.

## What is yours to decide

The precise statement of NO-PAR, whether to run the route on maximal covers or on Grundy partitions, and your route through N4. If NO-PAR as
the stub frames it is the wrong target for the cover route, say so: a wrong frame reported is a finding.

## Stages (save and commit each; standing rule 2)

1. The readback, recognition, and the proposed statements (sent to "main").
2. and on: one relay-result per stage.
Last: the report.

Thank you.
