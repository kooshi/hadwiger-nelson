# Brief FS116-S1 — Ephodos: SAT-STRIP from both sides, a fresh mind on its stalled form

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS116-S1
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job's procedure, opening with `ephodos-recognition` invoked fresh with the Skill tool
  role: a derivation-and-construction job on FS-116's frozen claim list, round 3: decide SAT-STRIP by an exclusion or by a fragment given by formula and checked exactly
  launch: now, beside FS116-N2 (RING-TRANSFER; not blind to you), FS116-V3 (a blind verifier) and FS-121's jobs
  mission: § Why this job
  statements: § Your claims
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — a derivation job; but write nothing about your work where FS116-V3 or FS121-V3 could read it before their verdicts (standing rule 8): only your record, your data directory and your report
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/fs116/reports/FS116-S1.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` is part of it too: you may build exact checkers (its § Make the gate fail, and watch it fail)
  record: `plans/FS116-S1-proof.md`
  touches: `plans/FS116-S1-proof.md`, `data/fs116/s1/`, `tools/fs116_s1_*.py`, `data/fs116/reports/FS116-S1.md`
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are Ephodos, on the proof side of FS-116's first round.

## Why this job

SAT-STRIP decides the plan's P1, and P1 decides which class the milestone's exclusion is posed in first (`plans/FS116-local-exclusion.md`
§ 4.5). Both sides stalled at the same place. The proof side (`plans/FS116-N1-proof.md` § 4.3, its end: the stalled form) derived the
right-angled cross's axis structure (FS116-N1-AXIS): at each axis point q of the ring, either a touch point whose colour saturation places at
2q − p, or a change point fed by a (Q) arc at a named inner germ, neither excluded; its advice is a fresh mind on that stalled form, not a
fourth push. The construction side (`plans/FS116-Y1-construction.md` § 2.2–2.4, `plans/FS116-Y2-construction.md`) showed the capped strip
cannot be saturated at radius 1 (FS116-Y1-STRIPCEIL) and restated what a positive must carry: AXIS at all four axis points, saturation on all
of `B̄(p, 1)`, and ECHO's tiles at radius 2. You are that fresh mind, on both sides at once: exclude the configuration, or build it.

## Your claims

> - **SAT-STRIP** *(this list)*: no valid fragment on `B̄(p, 2)` saturated on `B̄(p, 1)` has at `p` a degree-4 vertex of four colours whose four edges are
>   segments. *Not claimed:* anything at `k ≥ 7` (at `k = 9` the square nine-colouring of side 1/2 has such vertices, saturated); anything about unsaturated
>   fragments (the capped strip holds such a vertex to `φ²/√2`, FS114-Y-DIAL).
> — source: data/fs116/claims.md § 4. D0 — the saturated class

> - **Y-SAT** *(this list)*: a valid fragment on `B̄(p, R)`, saturated on `B̄(p, R − 1)`, about a vertex `p` of at least four colours, for the largest `R`
>   reached (first: the capped strip made saturated at its midline, which decides SAT-STRIP from the other side) — or a derived obstruction at a named radius.
> — source: data/fs116/claims.md § 7. Y — construction (each checked exactly on an object given by formula)

Read Y-SAT's target as round 1 corrected it: "a geometry differing from the strip inside the unit disc, saturated on `B̄(p, 1)`". Held inputs
at two minds: FS116-O1-SATPIN (corrected wording) and the list's § 10. One-mind inputs from round 1's stage 4: FS116-N1-AXIS, -TOUCH, -ECHO,
-QFREE4, -GERM-R, -GERM-S, -F15TOUCH (a blind check of five of them runs now); FS116-Y1-F15 and -STRIPCEIL. Crosses whose edges are not at
right angles were not worked.

## What you read

The records named above (round 1's § 4 above all), the plan (`plans/FS116-local-exclusion.md` § 4.3–4.6), the frozen list and its § 9
controls and killing tests, FS-111's saturation entries (`plans/FS111-derivation.md`: M-PINCH, VM2-STRIP-MID, W-SQ9, W-LADDER), and the
grokkings in your context. Other jobs' tools are read-only to you (standing rule 7).

## Done means

1. **Your record**, `plans/FS116-S1-proof.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/FS116-S1-proof.md`
   from the repository root before each stage's commit: the readback, the recognition stage, then a `derivation:` entry for each claim
   with its verdict (TRUE, FALSE with a counterexample given by formula with an exact checker that accepts the list's § 9 controls first
   and fires on a planted fault, GAP at a named step, or MISSTATED with the corrected statement) and one for every lemma.
2. **The report** in the standing rules' form. Your last words are exactly "FS116-S1 idle; report sent to the coordinator": the report
   goes by message, and the hand-back carries nothing else.

## What is yours to decide

Which side to push first, your families and your route. SAT-STRIP TRUE and a Y-SAT fragment are the two outcomes, and a GAP at a named step
narrower than round 1's is a result too. Stop rule: three failed attempts on one step, then `ephodos-recognition`, then `ephodos-invention`
if every home dies on one line; three failed construction families, then report their free parameters against the configuration's.

## Stages (save and commit each; standing rule 2)

1. The readback, then recognition on both claims.
2. and on: one relay-result per stage.
Last: the report.

Thank you.
