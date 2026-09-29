# Brief FS121-D1 — Ephodos: FS-121's first derivation job (the three-colour ladder end)

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS121-D1
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job's procedure, opening with `ephodos-recognition` invoked fresh with the Skill tool
  role: a derivation job on FS-121's frozen claim list, round 1
  launch: now, beside FS121-DB1 (a blind verifier on four other claims of the same list) and three jobs of FS-116
  mission: § Why this job
  statements: § Your claims
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — a derivation job; but write nothing about your work where FS121-DB1 or FS116-V1 could read it before their verdicts (standing rule 8): only your record, your data directory, your tools and your report
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/fs121/reports/FS121-D1.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` is part of it too if you build an exact check
  record: `plans/FS121-D1-proof.md`
  touches: `plans/FS121-D1-proof.md`, `data/fs121/d1/`, `tools/fs121_d1_*.py`, `data/fs121/reports/FS121-D1.md`
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are Ephodos, on FS-121's first round.

## Why this job

FS-121's opening found that a curved ladder in a saturated colouring ends either on a (Q) arc about a four-colour vertex, which is
FS-116's ring, or on an (R2) arc about a point of the singular set with at least three colours (`plans/FS121-map-step.md` § 3.2–3.4). The
milestone opens on the second branch: if every such centre carries four colours, the two halves of route M share one object; if a
three-colour end exists, the ring question at three-colour centres is FS-121's own. That is the plan's P1, and it decides whether D4
waits on FS-116's ring card or runs on its own.

## Your claims

> - **C121-R2-FOUR** (this list): in every honest saturated colouring in D-NF satisfying REG-J′, with any number of colours, every centre z of an (R2) arc
>   that ends a chain of unit parallels, at which no colour has density 0, carries at least four colours.
>   *Not claimed:* anything at points where a colour has density 0; anything about the (Q) branch. *Colours:* every `k`. *Inhabitant:* **none held** (no held
>   saturated colouring has an (R2) arc; by C121-PER none periodic has one). A three-colour (R2) end at any `k ≥ 7`, given by formula, refutes it.
> — source: data/fs121/claims.md § 2. The ladder ends

> - **C121-CURVED** (this list): for some k ≥ 7 there is an honest saturated colouring in D-NF satisfying REG-J′, with no colour of density 0 at any point,
>   that has a tangent-type interface arc of finite radius.
>   *Not claimed:* anything at `k ≤ 6`. *Role:* the inhabitant the classes of C121-OUT and C121-R2-FOUR lack (G21). A derived obstruction at every `k ≥ 7`
>   is also a result.
> — source: data/fs121/claims.md § 2. The ladder ends

The opening's four statements (C121-ENDS, -OUT, -PER, -LRA-LINE, the list's § 2) are one-mind inputs you may use, graded as filed; a
blind verifier is working them now. FS-116's FS116-O1-SATPIN (`plans/FS116-local-exclusion.md` § 4.1) is one mind as well; FS121-O1
noted that its argument never uses the four-colour hypothesis.

## What you read

The plan (`plans/FS121-map-step.md`, especially § 1.2's *bears* lines, § 3, § 4.2–4.4), the frozen list and its vacuity rule, the stub,
`plans/FS111-derivation.md` and the FS-111 records it cites (M-PINCH, M-C11, M2-INTRAD, W-NOREP, the controls R7, SQ9, HEX9), and the
grokkings in your context.

## Done means

1. **Your record**, `plans/FS121-D1-proof.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/FS121-D1-proof.md`
   from the repository root before each stage's commit: the readback, the recognition stage, then one `derivation:` entry per claim with
   its verdict (TRUE, FALSE with a counterexample given by formula and checked exactly, GAP at a named step, or MISSTATED with the corrected
   statement), each with its colour count and its inhabitant or the statement that none is held.
2. **The report** in the standing rules' form. Your last words are exactly "FS121-D1 idle; report sent to the coordinator": the report
   goes by message, and the hand-back carries nothing else.

## What is yours to decide

Your route and order. The plan's stop rule is yours: three failed attempts on one step, or C121-R2-FOUR decided. A three-colour (R2) end
built by formula at some `k ≥ 7` is a result as good as a proof that none exists. If a claim or the plan's frame is wrong, say so.

## Stages (save and commit each; standing rule 2)

1. The readback, then recognition on each claim.
2. C121-R2-FOUR.
3. C121-CURVED.
4. The report.

Thank you.
