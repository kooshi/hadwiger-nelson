# (DRAFT for the close to mint) — the map step: does a tight colouring of the plane become a map? (REG-I and REG-A)

*Drafted by the milestone planner FS111-P, 2026-09-27, as FS-111's first product (card 1's answer: `plans/FS111-cone-scale.md` stage 2, §2.5–§2.6;
claims `data/fs111/claims.md` §3). Not minted: `plans/` stubs are the close's to write. Solver column: none — derivation and reading. Written for a
session with no memory of FS-111: read `CLAUDE.md` § The aim (links 5–6) and § Counter-priors first, then `LEDGER.md` rows 130–136,
`plans/FS111-cone-scale.md` stages 2 and 5, and `data/fs111/claims.md`.*

## The question

A **tight** colouring (no band of slack; FS-106's D-SLACK) of the plane with `k` colours, measurable and proper at almost every unit pair, exists
exactly when `χ_m⁰(ℝ²) ≤ k` (row 130). The known NOs are for **maps** — the plane cut into finitely many regions per bounded set by Jordan curves
(`[SokolovVoronov2025]` Conditions 2–4): "maps need six" (FS106-AE-MAP6, one mind per link, the fill in outline) and, at six colours, the map NO for
boundaries of segments and circular arcs (row 134 without unit arcs; FS-114 with them). **The map step asks whether a tight colouring can always be
replaced by a map one:**
- **REG-I_k** (claims §3): if a tight a.e.-proper `k`-colouring exists, then a map-type colouring is a.e.-proper with `k` colours.
- **REG-A_k**: the same with the map's boundaries segments and circular arcs.

## Bearing on the answer

- **At five colours, decisive for the lower bound:** REG-I₅ with FS106-AE-MAP6 gives `χ_m⁰(ℝ²) ≥ 6`, so `χ(ℝ²) ≥ 6` given MR (C-SIX-M) — FS-104's
  statement, by a route FS-104's stub does not list. A counterexample to REG-I₅ is a tight measurable five-colouring, so `χ_m⁰(ℝ²) = 5` and
  `χ(ℝ²) = 5` with no MR (row 131, link 2).
- **At six colours, decisive for seven jointly with FS-114's NO:** REG-A₆ with Q-NO gives `χ_m⁰(ℝ²) ≥ 7`, so `χ(ℝ²) = 7` given MR (C-SEVEN-M).
- **Honesty (C-REG-EQ):** given the NO at `k`, REG at `k` is equivalent to the answer at `k`; it is the answer stated where a proof would live. Its value
  is its method, and its lower rungs (FS-111's M1: C-FILL, C-HULL, C-SAT-T, C-HULL-REG, REG-B, REG-J) are genuinely smaller statements, testable on
  tight seven-colourings.

## The room and the prior art (FS-111 §PA)

Regularity of optimal partitions and of sets with positive reach or `r`-convex boundaries (Rataj–Zajíček, arXiv:2512.17606, arXiv:1604.08841); the
compactness and supersaturation theory of distance-avoiding sets (`[Bukh2008]`; Cohen–Mani, arXiv:2407.05071), whose one-class form of this question
is Cohen–Mani's open Question 5.1 (*"Does there exist a set A with block structure and δ(A) = m 1 ?"*); regularisation at positive slack is in print
(`[Voronov2023]` Prop. 2.1), and at zero slack Voronov writes *"The problem on measurable chromatic number seems to be substantially more difficult"*.

## Registered expectations (instruments, never caps)

REG-I₅ within one milestone at one mind: 0.05; a GAP at a named step: 0.8; an obstruction (a tight seven-colouring by formula whose every modification
keeps a non-map feature): 0.15.

## Provisional bearings

G82, G79, G24/G60 (no argument one class at a time), G22 (the target class contains arcs), G83 (unit arcs at four-colour vertices), G21; rows 130–136;
stubs FS-111 (its M1 is this stub's first lemma either way), FS-114, FS-104, FS-108 (Townsend's (c), under FS106-AE-MAP6).
