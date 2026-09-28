*Brief for job **FS111-VM2**, the blind verifier of FS-111's round 2 (FS111-M2). Opus 5.5. Written by the product owner, 2026-09-28. **Sized for about
300k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), a blind verifier, in `/home/kooshi/source/lean-dir`. **`data/fs111/briefs/STANDING-RULES.md` is part of this
brief; read it in full, rule 0 first**, then `CLAUDE.md` § The aim, § Counter-priors, G82, G24, G21, from disk. Derive first, read second. **M2-REDUCE-C
flatters the answer**: if it holds, `χ(ℝ²) ≥ 6` given MR is one regularity statement away. Audit it at the rate of a result you would want false.

## The statements (verbatim from `plans/FS111-M2-regularity.md`'s theorem list; proofs withheld until your stage 1)

1. **M2-REDUCE-C** — "if some maximal `k`-cover has regular classes whose boundaries form a locally finite plane graph (REG-J′-C_k), then REG-I_k; at
   `k = 5`, with FS106-AE-MAP6, `χ_m⁰(ℝ²) ≥ 6`, hence `χ(ℝ²) ≥ 6` given MR — with **no** honest saturation: the selection is the free colouring of the
   arrangement's faces, and the colour count enters only at FS106-AE-MAP6 — [derived, one mind; over FS106-AE-MAP6's grade]". **The step to check hardest:**
   whether colouring the faces of a maximal cover's boundary arrangement (a cover's classes overlap) gives an a.e.-proper *map-type* colouring in
   FS106-AE-MAP6's class, with the same five colours, and whether AE-MAP6's hypotheses hold for it.
2. **M2-INTRAD** — "in an honest saturated colouring whose singular set Σ is locally finite with finitely many interface arcs at each point (REG-J′), the
   unit parallel of every (tangent) interface arc is again an interface arc, so radii of curvature drop by exactly 1 toward the centre and must stop at 1:
   every interface has **integer** radius of curvature a.e., and is a chain of segments and circular arcs with finitely many of each radius locally —
   REG-CHAIN in a strong form; accumulation with radii → ∞ (LRA, FS-115's stuck ray) not excluded — [hand, one mind]". Check it on R7, the strip, SQ9 and
   HEX9.
3. **M2-REDUCE-A** — "REG-A_k ⟸ honest C-SAT-T_k ∧ REG-J′_k ∧ ¬LRA; at six with Q-NO, `χ_m⁰(ℝ²) ≥ 7` — [derived, one mind]".
4. **M2-SELCOMP** — "in a saturated colouring, for every unit-avoiding enlargement `A` of a class, no interface point lies in `int Ã`, so the class is null
   or full on each component of `int Ã`: saturated means maximal at interfaces; from a regular maximal cover a saturated selection is a choice of whole
   components forming a partition; if every component has exclusive points, a saturated selection exists only if the cover is a partition; and a regular
   maximal partition (a measurable fall colouring) is saturated — [hand, one mind; over Federer 4.5.11, external]". With **M2-NOSEL**: "DISC7 has no
   saturated selection (the lens)".
5. **M2-DISCK7** — "translates of a smooth non-circular body of constant width 1 (support `1/2 + sin³(3θ)/200`) at hex7's colour lattices form a regular
   maximal seven-cover with a locally finite arrangement: the cover form of REG-A is FALSE at seven, and on the cover route the NO at six must cover
   self-parallel curved boundaries (NO-PAR) — [hand + tools exact (sympy + rationals, three plants), one mind]". Rebuild and check it exactly.
6. **M2-HULLC** — "C-HULL-REG on maximal covers: every component of a regular maximal class lies inside or outside each unit circle centred in the class,
   so it satisfies the exterior ball condition of radius `1/2`, is semiconcave with constant 1 where its boundary is a graph, and has finite perimeter; near
   any point the class is carved by the unit circles about its own points …; on the pinch set of two classes M-PINCH/M-C11 hold verbatim. Semiconvexity
   (`|κ| ≤ 1` on the convex side) FAILS on covers (DISC7: curvature 2) — [hand, one mind; finite perimeter over a classical fact]".

**Priority:** 1 first, then 2 and 3, then 5, 4 and 6.

## Reading

`data/fs111/claims.md` in full; `data/fs106/claims.md` §0–§1 and §5; `plans/FS106-derivation.md` (FS106-AE-MAP6, AE-NICE, AE-POLY: statements and grades)
and the records they point to; `plans/FS111-VMW-verification.md` and `plans/FS111-V0-verification.md` (open); `plans/FS111-M-regularity.md` and
`plans/FS111-W-wild.md` (round 1, open).

**Fences, until your stage 1 is committed:** `plans/FS111-M2-regularity.md`, `data/fs111/fs111-m2/`, `tools/fs111_m2_*`, `data/fs111/reports/`.
**Always:** the session transcripts (everything under `~/.claude/projects/-home-kooshi-source-lean-dir/`), `chats-bak/`, every shared scratchpad file you
did not create (work in `fs111-vm2/`), `plans/FS111-close-inventory.md`, every other brief, FS-114's files (`plans/FS114-*`, `data/fs114/`,
`tools/fs114_*`), `git log` beyond the start-up snapshot and `git log -p`. Log any touch.

## Stages

1. **Blind:** the quotation check; your verdicts on 1–6 (TRUE, FALSE, GAP at a named step, or MISSTATED); exact tools in `tools/fs111_vm2_*.py`, each with a
   planted fault beside a faithful twin. Commit before opening any fenced file.
2. **Reconcile:** read M2's record; list every divergence of truth, statement or grade, with addresses.

## Rules

- **Touch only** `plans/FS111-VM2-verification.md` (headings "Theorems this phase proved", the would-have-searched log, the fence log; SAVED stages),
  `data/fs111/fs111-vm2/` and `tools/fs111_vm2_*.py`. Neutral subjects "FS111-VM2: stage n"; push after each commit; never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is left.
- **The ban** (standing rule 3): objects by formula, checked exactly; no search; keep the would-have-searched log.
- **Contact:** only `"main"`. Report per standing rule 9 to `data/fs111/reports/FS111-VM2.md` and to `"main"`. Final text: "FS111-VM2 idle; report sent to
  the owner by SendMessage".

Thank you.
