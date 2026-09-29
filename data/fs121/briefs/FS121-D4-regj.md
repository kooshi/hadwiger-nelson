# Brief FS121-D4 — Ephodos: FS-121's singular set (REG-J′), the milestone's structural form

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS121-D4
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job's procedure, opening with `ephodos-recognition` invoked fresh with the Skill tool
  role: a derivation job on FS-121's frozen claim list, round 3
  launch: now, beside FS121-V3 and FS121-V4 (blind verifiers on other claims of the same list) and FS-116's jobs
  mission: § Why this job
  statements: § Your claim
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — a derivation job; but write nothing about your work where FS121-V3, FS121-V4 or FS116-V3 could read it before their verdicts (standing rule 8): only your record, your data directory, your tools and your report
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/fs121/reports/FS121-D4.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` is part of it too if you build an exact check
  record: `plans/FS121-D4-proof.md`
  touches: `plans/FS121-D4-proof.md`, `data/fs121/d4/`, `tools/fs121_d4_*.py`, `data/fs121/reports/FS121-D4.md`
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are Ephodos, on FS-121's second round.

## Why this job

FS-121's structural form asks where the ladder of unit parallels of an interface can end, and what every end carries that bounds how many ends
meet a bounded set (`plans/STUB-map-step.md` § Structural form); REG-J′'s universal form is that question's answer, and the plan put it last
(`plans/FS121-map-step.md` § 4.2). Tonight's rounds hold, at two minds, the ladder ends (C121-ENDS: every curved ladder ends on a (Q) arc about
a four-colour vertex or an (R2) arc about a point of Σ with three colours, reading (a)), C121-OUT, C121-PER and DB1-L3; at one mind, FS121-D2's
no-LRA on every doubly periodic colouring, FS121-D3-GRUNDY, and FS121-D1's corner lemmas. FS-116's ring lemmas RING-GERM and RING-TWIST-C
hold at two minds (`data/fs116/claims.md` § 10). The plan had D4 wait on D1's answer to C121-R2-FOUR, which stalled; D4 now runs on the inputs
as they stand.

## Your claim

> - **C121-REGJ** (this list): in every honest saturated colouring in D-NF, with any number of colours, the singular set Σ is locally finite and each point
>   of Σ meets finitely many interface arcs.
>   *Not claimed:* any bound on how many points of Σ a set of given size holds. *Colours:* every `k`. *Inhabitants:* `k = 7`, R7; `k = 9`, SQ9 and HEX9. A
>   saturated colouring at any `k ≥ 7` whose Σ is not locally finite refutes it. **A derivation of it may not rest on C121-ENDS, C121-OUT, C121-PER or
>   C121-LRA-LINE, which assume REG-J′.**
> — source: data/fs121/claims.md § 4. Honest saturation and the singular set (jobs FS121-D3, FS121-D4)

The claim's last line binds: a derivation of it may not rest on C121-ENDS, C121-OUT, C121-PER or C121-LRA-LINE, which assume REG-J′. The plan's
§ 4.2 names a handle (what every end carries bounds the ends in a bounded set; M-EXTREME's two points of Σ per region); it is the plan's
suggestion, not an instruction.
## What you read

The plan (`plans/FS121-map-step.md`, especially § 1.2's *bears* lines and § 4.1–4.4), the frozen list and its vacuity rule, the stub,
the round records `plans/FS121-D1-proof.md`, `plans/FS121-DB1-verification.md`, `plans/FS121-D2-proof.md`, `plans/FS121-D3-proof.md`,
`plans/FS121-V2-verification.md` and `plans/FS121-C1-proof.md` (their lemmas are inputs at the grades filed),
`plans/FS111-derivation.md` and the FS-111 records it cites, and the grokkings in your context.

## Done means

1. **Your record**, `plans/FS121-D4-proof.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/FS121-D4-proof.md`
   from the repository root before each stage's commit: the readback, the recognition stage, then one `derivation:` entry for the claim
   with its verdict (TRUE, FALSE with a counterexample given by formula and checked exactly, GAP at a named step, or MISSTATED with the
   corrected statement), with its colour count and its inhabitant or the statement that none is held, and an entry for every lemma you prove.
2. **The report** in the standing rules' form. Your last words are exactly "FS121-D4 idle; report sent to the coordinator": the report goes
   by message, and the hand-back carries nothing else.

## What is yours to decide

Your route. The plan's stop rule is yours: three failed attempts on one step, or the claim decided. If the claim or the plan's frame
is wrong, say so: MISSTATED, or a wrong frame reported, is a finding.

## Stages (save and commit each; standing rule 2)

1. The readback, then recognition on the claim.
2. and on: one relay-result per stage.
Last: the report.

Thank you.
