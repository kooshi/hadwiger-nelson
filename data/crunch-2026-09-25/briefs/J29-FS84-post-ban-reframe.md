*Brief for crunch job **J29**: the reframe and post-ban plan of FS-84, "ℚ(√47): five colours". Opus 5.5, 2026-09-25. Written by the
product owner per `plans/CRUNCH-2026-09-25-queue.md` §4.2. **The reframe template is J03's brief**
(`data/crunch-2026-09-25/briefs/J03-M1-reframe.md`): read it in full and follow it, with the changes below, which override it where they
differ.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **FS-84's planner**, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`.
Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief.**
I'm the product owner.

**If your plan already exists, you are resuming:** read it and this brief, check the last SAVED stage against
`git log -- plans/FS84-five-colours-47.md`, and continue at the first stage not SAVED.

## The milestone (replaces J03's milestone block)

**FS-84**, stub `plans/STUB-five-colours-47.md` (read it in full). Its mission, verbatim from the stub:

> `4 ≤ χ(ℚ(√47)²) ≤ 5` (rows 72–73: four by a certified witness, now also by FS-81's theorem, row 82; five by the plane at 11). The
> local–global conjecture predicts **exactly five** — L(ℚ(√47)) = 5 at every tower level (row 75) — and ℚ(√47) is the cheapest field where
> that clause is exposed (also ℚ(√143), ℚ(√311), ℚ(√335), ℚ(√3,√5)). A certified refusal of four colours would make χ(ℚ(√47)²) = 5
> **exactly**: the first real quadratic field with its value pinned at five. It confirms the conjecture and cannot falsify it; the
> falsifier is a four-colouring of the whole plane local at no prime (FS-83's `Θ₄` question at this field).

**This is a plan for after the ban.** The finite-witness ban runs to 2026-10-01. Your reframe (§G, §PA, §IQ, subplan, modeling passes)
runs now; **the plan's stages after the reframe run from 2026-10-01**. Write their briefs, and price each solver run against:
- row 84's band (the degree law's four-colour aim is about `d_ball ≈ 18.4`, G65; a triangle-free survivor over ℚ(√47) needs ≥ 1,284 times
  the control's points);
- rows 92 and 96: measurable windows over finitely many places, and every character, are excluded as four-colourings of this plane — so a
  falsifier of the five-clause is a colouring no window or character gives;
- the advisor's point: if M1's stage 0 lands, `L = 5` is the only testable range below the problem itself. **It has landed**: M1 proved
  the conjecture's `L ≤ 4` clause for every real number field (two independent derivations; `plans/FS91-S0F-three-colours.md`,
  `plans/FS91-S0FV-three-colours-blind.md`), and M1's class theorem CLG (verified blind; `plans/FS91-S1D-character.md`) says every
  character colouring is local at one stable place. M1 closes in the crunch; read its records for statements, and consume them as
  verified only where its close inventory `plans/FS91-close-inventory.md` says two derivations or blind-verified.

**Change J03's other blocks accordingly:** the verdict columns are FS-84's alone (one milestone); the §PA disciplines are the ones the stub
names plus "four-colourings of lattice unit-distance graphs over real quadratic fields" and "forcing / rigidity at four colours without
triangles" (ℚ(√47) has no √3, so its plane has no triangles — G57; Soifer's Open Problem 55.1, `CLOSED-QUESTIONS.md` §3); the briefs you
write are the post-ban stages' (dated to run from 2026-10-01, each with its solver, its budget, its stop rule, its checkpoint and resume
command — `CLAUDE.md`'s PROTECTED checkpointing paragraph); the paths are `plans/FS84-five-colours-47.md`, `data/fs84/j29/`,
`tools/crunch_j29_*`.

## Rules (in addition to J03's)

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved stage and tell me what is left.
- **No solver runs now**, not even a pricing sample: price from recorded measurements (row 84, FS-81's records, G65). The would-have-searched
  log records each run you would have made.
- Do not edit `plans/CRUNCH-2026-09-25-INDEX.md`, any M1–M3 file, or the four front-page files.
- **Commits by explicit path**, subjects "J29: stage n"; push; never force-push.
- **Budget:** about 350k by the harness's count; hand back by 420k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J29.md`, committed, and by SendMessage
  `to: "main"`, with the post-ban jobs as Q-lines marked "post-ban (from 2026-10-01)". Keep your turn's final text content-free: "J29 idle;
  report sent to the owner by SendMessage".

Thank you.
