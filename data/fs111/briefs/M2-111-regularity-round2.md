*Brief for job **FS111-M2**, FS-111 (the cone scale and the regularity step), round 2, the regularity side. Opus 5.5. Written by the product owner,
2026-09-28. **Sized for about 400k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS111-M's, `data/fs111/briefs/M-111-regularity.md`, plus
this file; where they differ, this file wins.** Read `data/fs111/briefs/STANDING-RULES.md` in full, rule 0 first.

## Where round 1 left route M (the owner's comparison; every record below is open to you)

- `plans/FS111-M-regularity.md` (your side), `plans/FS111-W-wild.md` (the wild side, now open), and `plans/FS111-VMW-verification.md` (their blind
  verifier): read all three first.
- **Settled by VMW, blind, exact:**
  - **R7 (de Grey's Reuleaux 4+3 seven-colouring) is saturated**, and it is a maximal admissible cover. So **C-SAT-T's existence form is TRUE at
    `k ≥ 7`, a GAP at `k = 5, 6`.** W-P1 and W-P2 are FALSE.
  - REG-B: its existence form is TRUE and its universal form is FALSE (DECO-B); these are two statements, not a divergence.
  - C-HULL-REG's common form is M-PINCH/M-C11, which needs no partner density. It has three minds on its cases.
  - W-NEG is TRUE: no wild object refutes an existence rung except by proving `χ_m⁰ ≤ k`. So round 2 runs no wild competitor.
- **M-REDUCE-I** (TRUE as you stated it, VMW): honest saturation plus a locally finite singular set Σ at five colours gives `χ_m⁰(ℝ²) ≥ 6`, so
  `χ(ℝ²) ≥ 6` given MR. This is FS-104's statement, reached by regularity.

## The owner's ruling on route M's first rung (your held item and W's)

**Run the regularity rungs on maximal admissible covers, where M-SATC (Zorn) gives saturation with no gap, and move the selection — from a cover to one
colour per point — to the end, as the one step where the colour count enters.** The alternative was to keep honest saturation first. The ruling's reason is
G24: the step to a colour count is integrality, and a route should spend the count in one named place. Here that place is the selection at `k = 5, 6`,
which R7 shows is free at seven.

## Your side, round 2

Each stage is SAVED and committed. Every rung is stated for every `k` and inhabited at `k = 7` (R7, SQ9 at nine), checked exactly.
1. **The rungs on covers.** State and prove C-HULL-REG and REG-J′ (Σ locally finite) for maximal admissible covers. Name where a cover's overlaps change a
   round-1 proof.
2. **The selection at `k = 5`**: from a maximal cover of a tight five-colouring to an honest saturated colouring whose Σ is locally finite. Together with
   M-REDUCE-I this is `χ_m⁰(ℝ²) ≥ 6`. Derive it, or name the step and the configuration that blocks it.
   - M-DEADLOCK is the known obstacle at seven: no change near an edge saturates the hexagonal colouring.
   - Say what a five-colour deadlock would need, and whether the count forbids it.
3. **If context remains, the six-colour top rung**: REG-A₆ through REG-CHAIN or NO-C11 (chains of unit-parallel curves straight or ending at unit arcs,
   through row 134's shadow map). Given FS-114's NO this is seven (C-SEVEN-M).
   - FS-114's news, read as context only: **every valid unit-arc map has a vertex of at least four colours** (FS114-CV-EXISTS, two minds), so its NO is
     one local exclusion about a four-colour vertex (C114-LOCAL-F).
   - FS-114's working files stay fenced; `plans/STUB-global-step.md` is open.

## Rules

- **Your record** is `plans/FS111-M2-regularity.md` (the usual headings; SAVED stages). Working files go in `data/fs111/fs111-m2/`, tools in
  `tools/fs111_m2_*.py`, the report in `data/fs111/reports/FS111-M2.md`. Subjects are "FS111-M2: stage n".
- Fences: the session transcripts, `chats-bak/`, other agents' scratchpad files, `plans/FS111-close-inventory.md`, other briefs, and FS-114's working
  files (`plans/FS114-*`, `data/fs114/`, `tools/fs114_*`).
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is left.
- **The ban** (standing rule 3): objects by formula, checked exactly; no search. Keep the would-have-searched log.
- **Contact:** only `"main"`. Report per standing rule 9 to `data/fs111/reports/FS111-M2.md` and to `"main"`. Final text: "FS111-M2 idle; report sent to
  the owner by SendMessage".

Thank you.
