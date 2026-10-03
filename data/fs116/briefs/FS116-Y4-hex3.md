# Brief FS116-Y4 — Ephodos: FS-116's construction side, round 4 (the HEX3-star vertex beyond radius 2)

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS116-Y4
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job's procedure, opening with `ephodos-recognition` invoked fresh with the Skill tool
  role: a construction job on FS-116's frozen claim list, round 4: a fragment given by formula and checked exactly, or a derived obstruction at a named radius
  launch: now, beside FS116-V5 (a blind verifier on statements of FS-116's list that this job builds on) and FS121-Z1 (FS-121's close)
  mission: § Why this job
  statements: § Your claims
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — a construction job, not a second mind; but FS116-V5 is blind to every FS-116 record, so write nothing about your work outside your record, your data directory, your tools and your report, and never message another job (standing rules 8 and 11)
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/fs116/reports/FS116-Y4.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` is part of it too: you build exact checkers (its § Make the gate fail, and watch it fail)
  record: `plans/FS116-Y4-construction.md`
  touches: `plans/FS116-Y4-construction.md`, `data/fs116/y4/`, `tools/fs116_y4_*.py`, `data/fs116/reports/FS116-Y4.md`
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are Ephodos, on FS-116's construction side, picking up where round 3 stopped.

## Why this job

FS-116 asks for one radius, uniform in the complexity, within which no valid six-coloured fragment survives about a vertex of at least four
colours (`data/fs116/claims.md` § 1). Its case list splits by the vertex's ring. For a ring that carries no arc of Γ, round 3's construction job
(`plans/FS116-Y3-construction.md`) derived, at one mind, that on a disc of radius √3 the vertex's star must be FS116-N2-HEX3's, with forced outer
colours at its hubs (FS116-Y3-STARFORCE, below; a blind verifier is checking it now, and nothing in this job waits on that). It stopped at the
form quoted below. **An obstruction removes the Γ-free type from FS-116's case list; a fragment by formula gives FS116-N2-RECIP and -HEX6 their
first model** (the close inventory's item 88). Both are results. The list's § 9 still binds every program you write: "No enumeration of maps,
colourings, tile graphs or dual graphs, by any program.", and nor of ring types. Colourings given by formula, exact checks of them, and derived
case analyses are in.

## Your claims

The form round 3 left, verbatim:

> - **The stalled form, for a fresh mind:** *a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 2 about a four-colour vertex
> `p` whose star is HEX3's — tiles `T1` (cone `[−30°, 90°]`), `T3` (`[90°, 150°]`), `T2` (`[150°, 270°]`), `T4` (`[270°, 330°]`), hubs `e(60k)` with outer
> colours as § 4.2 says — or the point inside radius 2 where every such fragment loses all six colours.* RECIP and HEX6 can have models only here.
> — source: plans/FS116-Y3-construction.md § 4.3 What was not reached

The statement it rests on, as frozen:

> - **FS116-Y3-STARFORCE** *(proposed at round 3)*: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius at least √3 about a vertex p of at least four colours whose ring carries no arc of Γ, labelled as FS116-Y3-TIPS, the edges of p are δ_1 = 90°, δ_2 = 150°, δ_3 = 270°, δ_4 = −30° (FS116-N2-HEX3's star); 3 is an outer colour of y_0 and of y_4, and 4 of y_1 and of y_3; each of these four hubs has that outer colour alone or two outer tiles, counter-clockwise 2, 3 at y_0; 4, 2 at y_1; 1, 4 at y_3; 3, 1 at y_4; and near q_1, q_5 the lens points carry colour 2, near q_2, q_4 colour 1 *Not claimed:* that any such fragment exists, at any radius; anything below radius √3; anything in the Siamese or non-simple class; anything at k ≥ 7
> — source: data/fs116/claims.md § 12. Added at round 4

Read your target as: **a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 2 about a four-colour vertex whose ring
carries no arc of Γ and whose star is HEX3's, given by formula and checked exactly — or a derived obstruction at a named radius at most 2.** If you
find the target is wrong as posed (for instance that STARFORCE's forced structure leaves a family the stalled form does not name), say so; that is
a finding. Before you derive anything new, propose each statement you will work in your record's own section, with every term and setting word it
uses defined there, so that the coordinator can freeze it for a later blind check (the list's §§ 13 and 14 are the form).

## What you read

Round 3's construction record `plans/FS116-Y3-construction.md` in full (its tools `tools/fs116_y3_*.py` read-only to you); round 3's proof record
`plans/FS116-N2-proof.md` (hubs, STAR, RECIP, HEX6, HEX3); round 2's construction record `plans/FS116-Y2-construction.md` for the six-colour
fragment and its tools; the frozen list's §§ 0, 9, 10 and 12–14; and the grokkings in your context.

## Done means

1. **Your record**, `plans/FS116-Y4-construction.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS116-Y4-construction.md` from the repository root before each stage's commit: the readback, the recognition stage, the proposed
   statements, and then either an object given by formula with an exact checker (`tools/fs116_y4_*.py`) that accepts the list's § 9 controls first
   and fires on a planted fault, or a derived obstruction at a named radius, or the families tried with their free parameters against the
   configuration's demands, and the step where it stalls.
2. **The report** in the standing rules' form. Your last words are exactly "FS116-Y4 idle; report sent to the coordinator": the report goes by
   message, and the hand-back carries nothing else.

## What is yours to decide

Your families, your checkers, your case split and your order. A candidate that fails the exact check measures the candidate, not the question.
If the question is wrong as posed, say so.

## Stages (save and commit each; standing rule 2)

1. The readback, recognition on the target, and the proposed statements.
2. and on: one family or one obstruction per stage.
Last: the report.

You start no agent of your own (`plans/STANDING-RULES.md` rule 1: staffing is Kooshi's budget, and I can review only work I know exists).

Thank you.
