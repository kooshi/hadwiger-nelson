*Instance file for job **FS114-NB4**, the blind verifier of FS-114's proof side, round 3 (FS114-N4). The brief is the template
`data/fs114/briefs/NB114-verify-proof.md`, with the changes below. Written by the product owner, 2026-09-28. The statements are FS114-N4's, quoted from
its record, with grades and proofs withheld.*

## Changes to the template

- **Your record** is `plans/FS114-NB4-verification.md`. Working files go in `data/fs114/fs114-nb4/`, tools in `tools/fs114_nb4_*.py`, the report in
  `data/fs114/reports/FS114-NB4.md`. Subjects are "FS114-NB4: stage n". Final text: "FS114-NB4 idle; report sent to the owner by SendMessage".
- **Reading adds** `data/fs114/briefs/ROUND2-card.md` and `data/fs114/briefs/ROUND3-card.md`; `plans/FS114-N3-proof.md` (round 2's proof side: DR,
  N3-DR1/DR2, N3-CONT — the frame N4 works in; open to you); FS112-SIX, FS112-A4SIX, FS112-NB4P, FS112-U1, FS112-N3-COR3 (`plans/FS112-derivation.md`).
- **Fences, until your stage 1 is committed:** `plans/FS114-N4-proof.md`, `data/fs114/fs114-n4/`, `tools/fs114_n4_*`. **Always:** every construction-side
  record, directory and tool (`plans/FS114-Y*`, `data/fs114/fs114-y*/`, `tools/fs114_y*`), including the construction verifiers' (`plans/FS114-YB*`,
  `data/fs114/fs114-yb*/`) — the construction side reached radius `√3` by another route, and your derivation must stay independent of it;
  `plans/FS114-L60-audit.md` and `data/fs114/fs114-l60/`; FS-111's files; and the template's other fences.
- **The lemma FS112-L60 is under audit** (it may be false at exactly 60°; a separate job checks it). Do not use its strict form. Where your derivation
  needs an arc bound, state the one you use and say whether equality at 60° matters.

## The statements (the bowtie: two width-1 Reuleaux triangles meeting corner to corner at a degree-4 vertex `p`, all four edges at `p` tactic — unit arcs about `q_i = e(±30°), e(180° ± 30°)`; the lunes between them, with rings on `ω(p)`)

1. **N4-BOWTIE**: no valid fragment (non-Siamese, simple class) on the closed disc of radius `√3` about `p` holds a Reuleaux bowtie whose lune rings are
   free of `Γ`. It is the union of the next two.
2. **N4-D**: the degenerate member does not exist at radius `√3`. No valid fragment on the closed disc of radius `√3` about `p` holds the Reuleaux bowtie
   with a lune whose ring is free of `Γ` and changes colour once.
3. **N4-G**: the general member does not exist at radius `√3`, both lune rings `Γ`-free.
4. **N4-FIVE**: five colours at a Reuleaux corner are not forced by the bowtie alone. With the lune rings free of `Γ`, a corner carries five colours iff
   its lune's ring is degenerate, and otherwise exactly four, `{1, 3, 4, X}`.
5. **N4-OWN**: a Reuleaux corner of the bowtie never carries the colour of the lune it bounds (`2 ∉ P_cl(q1), P_cl(q3)`; `4 ∉ P_cl(q2), P_cl(q4)`).
6. **N4-LENS**: if `|u − v| = 1`, a tile meeting the open lens `B(u, 1) ∩ B(v, 1)` with a colour of `P_cl(u)` is `u`'s tile of that colour (likewise
   `v`), and a colour that `u` and `v` carry on different tiles meets no point of the open lens.
7. **N4-TOP**: in the degenerate member (one change point, at the lune's ring midpoint `top`), one tile `W` of the far lune's colour fills the outer wedge
   at `top` with cone exactly `[60°, 120°]`, bordered by arcs of `ω(q1)` and `ω(q3)`. The lune tile reaches `top`, a degree-4 vertex of four colours
   `{2, 4, 5, 6}` at distance 1 from `p`.
8. **N4-OPP**: if an edge at `p` lies on `ω(q)` with `|p − q| = 1`, the other branch of `ω(q)` through `p` enters the tile at `p` on `q`'s side of the
   opposite direction, whose colour is then absent at `q`, unless that branch runs along `Γ`.
9. **N4-DR0**: N3-DR0's conclusion (the degenerate member does not exist) holds at radius `√3`, but its proof fails at step 1: at radius `1 + ε` the
   degenerate member passes every check, with exactly five colours at its corners.

**Priority:** 2 and 3 (the exclusions, which flatter the NO: audit them at the rate of a result you would want false), then 4, 5, 6, then the rest.
