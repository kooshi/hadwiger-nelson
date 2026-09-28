*Instance file for job **FS114-YB5**, the blind verifier of FS-114's construction side, round 6 (FS114-Y6). The brief is the template
`data/fs114/briefs/YB114-verify-construction.md`, with the changes below. Written by the product owner, 2026-09-28. **Each statement is copied
verbatim from `plans/FS114-Y6-construction.md`'s theorem table by a script**; grades and proofs withheld.*

## Changes to the template

- **Your record** is `plans/FS114-YB5-verification.md`. Working files go in `data/fs114/fs114-yb5/`, tools in `tools/fs114_yb5_*.py`, the report in
  `data/fs114/reports/FS114-YB5.md`. Subjects are "FS114-YB5: stage n", neutral. Final text: "FS114-YB5 idle; report sent to the owner by SendMessage".
- **Reading adds** the round cards `data/fs114/briefs/ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md`; `plans/FS114-Y5-construction.md` and
  `plans/FS114-YB4-verification.md` (the pinwheel chain: RAINBOW, MU, ALT, POCKET, CASE, REDUCE, PX, PXKILL, PINALL with its exceptions E1 and E2; open to
  you, with their tools); `plans/FS114-Y4-construction.md` and `plans/FS114-YB3-verification.md` (SIDES, W, LUNE); `plans/FS114-L60-audit.md` (FS112-L60's
  equality case, the Reuleaux cap — E1 is that case: read its equality shape closely). Vocabulary is as in `data/fs114/briefs/YB4-114-instance.md`
  (open to you); **E1** is an edge at `p` of exactly 60°; **E2** is a blade whose counter-clockwise side is a unit arc centred at its clockwise edge end.
- **Fences, until your stage 1 is committed:** `plans/FS114-Y6-construction.md`, `data/fs114/fs114-y6/`, `tools/fs114_y6_*`. **Always:** every proof-side
  record, directory and tool (`plans/FS114-N*-proof.md`, `data/fs114/fs114-n*/`, `tools/fs114_n*`) and the proof verifiers' (`plans/FS114-NB*`,
  `data/fs114/fs114-nb*/`) — FS114-N7 works E1 and E2 from the proof side now; `plans/FS114-close-inventory.md`; FS-111's files; the template's other
  fences.

## The statements

1. **FS114-Y6-E1FORM** — in a pinwheel with E1 at edge 1: `w_1 = q_4`, `α_1 = 60°`, `t_1` lies in the Reuleaux cap `Reul(p, q_4, e(φ_1 − 120°)) ∖ B(q_1, 1)`, `t_2 ⊂ Reul(p, q_4, q_1)` with `q_4 ∈ cl t_2`, and `α_2 < 120°`
2. **FS114-Y6-E1Q3** — FS114-Y5-CASE holds at `q_3` in E1 (edge 1 only, no E2 at `t_3`, `t_4`), so `α_4 ≥ 120°`
3. **FS114-Y6-E1OMEGA** — the tile `Ω` at `q_4` holding the directions just above `270°` has colour `m̄_3 = m_2`, and `Ω ≠ μ_3`
4. **FS114-Y6-E1CAP** — **E1 forces a second 60° arc**: `t_2` borders the whole ring arc from `q_4` to `q_1`; the tactic tile `T_4` borders all of it from outside, contains `q_1` and lies in the Reuleaux cap `Reul(q_4, q_1, q_1 + q_4) ∖ B(p, 1)`; `α_4 = 120°` exactly (`φ_3 = φ_1 + 180°`), `α_2 + α_3 = 180°`, CASE (A) at `q_3` with `λ_3 = α_3 − 60°`
5. **FS114-Y6-E1K1** — in E1 with `μ_1` bordering all of `M_1` and `α_2 > 60°`, the P_x kill of FS114-Y5-PXKILL runs at `k = 1` (`T_1` against `O_2`, colour 1) unless `T_4` fills the cap's corner at `q_4` and a tile of colour `m_2` sits at `q_1` between `T_1` and `μ_1`
6. **FS114-Y6-E2RED** — E2 at one blade `t_{c+1}` (no E1) breaks only ALT(`μ_{c−1}`, `μ_c`), hence only POCKET at `w_c` and CASE at `q_c`, and there only case (B)'s `α_c = 60°` and (A)'s `α_c − λ_c ≤ 60°`; (A) at `q_c` still gives `α_{c−1} + α_c ≤ 180°` and so leads to `P_x`; `P_x` is still excluded (Y5-PXKILL at `k = c + 1` reads no pocket beside `t_{c+1}`); the survivors are the cone sequences S1–S6 of §3.2, all with `t_{c+1}` short of the ring's clockwise tangent at `q_c`
7. **FS114-Y6-HALF** — in a `(2, 1, 1, 0)` pattern whose two-edge tile `t_1` is a width-1 Reuleaux triangle, FS114-Y4-SIDES, FS114-YB3-D2T and FS114-Y4-W hold unchanged: the side tiles at its corners are 5 and 6, and the tile along its ring arc is one cap tile `W`, of the colour of the tile opposite `t_1` at `p`; the stop at `√3` is **not** inherited, since Y3's germ condition at `r` needs the slivers that FS114-Y4-DIAG derived from the second Reuleaux triangle

**Priority:** FS114-Y6-E1CAP first (the side asks for it; it makes E1 repeat itself round an equilateral triangle, which is either a strong
structure theorem or a subtle error), then E1FORM and E1K1, then E2RED and the rest. Say whether the residues Y6 names (E1-Z, E1-60, E1-ν; E2's S1–S6)
are exactly what its chain misses.
