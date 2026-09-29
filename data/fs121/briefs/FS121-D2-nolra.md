# Brief FS121-D2 — Ephodos: FS-121's large-radius accumulation (¬LRA)

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS121-D2
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job's procedure, opening with `ephodos-recognition` invoked fresh with the Skill tool
  role: a derivation job on FS-121's frozen claim list, round 2
  launch: now, beside FS121-D3 (another derivation job of FS-121, on another claim), FS121-DB1 (a blind verifier on four other claims) and three jobs of FS-116
  mission: § Why this job
  statements: § Your claim
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — a derivation job; but write nothing about your work where FS121-DB1 or FS116-V1 could read it before their verdicts (standing rule 8): only your record, your data directory, your tools and your report
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/fs121/reports/FS121-D2.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` is part of it too if you build an exact check
  record: `plans/FS121-D2-proof.md`
  touches: `plans/FS121-D2-proof.md`, `data/fs121/d2/`, `tools/fs121_d2_*.py`, `data/fs121/reports/FS121-D2.md`
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are Ephodos, on FS-121's second round.

## Why this job

Route M's honest branch reaches a segment-and-arc map only if saturated interfaces cannot pile up at a point with radii of curvature
tending to infinity (LRA). FS-121's opening showed that such an accumulation, if it happens at one point, happens along the whole normal
line through it at unit spacing, in both directions (FS121-O1-LRA-LINE, one mind; its blind check is running). Your claim decides whether it
can happen at all under REG-J′; the plan's P2 (0.3) says what follows: if TRUE, LRA leaves the stuck-ray stub FS-115, and the honest route's
remaining rungs are honest saturation at six and REG-J′ itself; if not, the LRA line goes to FS-115 as its question restated.

## Your claim

> - **C121-NOLRA** (this list): in every honest saturated colouring in D-NF satisfying REG-J′, with any number of colours, ¬LRA holds.
>   *Not claimed:* anything without REG-J′. *Colours:* every `k`. *Inhabitants:* `k = 7`, R7; `k = 9`, SQ9 and HEX9 (none has LRA). A saturated colouring with
>   LRA at any `k ≥ 7` refutes it.
> — source: data/fs121/claims.md § 3. Large-radius accumulation (job FS121-D2)

The plan's § 4.2 names two candidate handles: row 134's N4 (curvature monotonicity along the shadow map) and a density count on the
pencils' ends. They are the plan's suggestions, not instructions.

## What you read

The plan (`plans/FS121-map-step.md`, especially § 1.2's *bears* lines and § 4.1–4.4), the frozen list and its vacuity rule, the stub,
round 1's record `plans/FS121-D1-proof.md` (its lemmas are one-mind inputs; its § 3.2–3.3 names the open step both its claims stalled at),
`plans/FS111-derivation.md` and the FS-111 records it cites, and the grokkings in your context.

## Done means

1. **Your record**, `plans/FS121-D2-proof.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/FS121-D2-proof.md`
   from the repository root before each stage's commit: the readback, the recognition stage, then one `derivation:` entry for the claim
   with its verdict (TRUE, FALSE with a counterexample given by formula and checked exactly, GAP at a named step, or MISSTATED with the
   corrected statement), with its colour count and its inhabitant or the statement that none is held, and an entry for every lemma you prove.
2. **The report** in the standing rules' form. Your last words are exactly "FS121-D2 idle; report sent to the coordinator": the report goes
   by message, and the hand-back carries nothing else.

## What is yours to decide

Your route. The plan's stop rule is yours: three failed attempts on one step, or the claim decided. If the claim or the plan's frame
is wrong, say so: MISSTATED, or a wrong frame reported, is a finding.

## Stages (save and commit each; standing rule 2)

1. The readback, then recognition on the claim.
2. and on: one relay-result per stage.
Last: the report.

Thank you.
