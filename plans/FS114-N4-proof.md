# FS114-N4 — FS-114's proof side, round 3: the Reuleaux bowtie at radius 2, K1 at radius 2, and the local NO

*Job FS114-N4, de Bruijn (Opus 5.5), launched 2026-09-28 07:31 UTC at HEAD `9c81c91b`. Brief `data/fs114/briefs/N4-114-proof-round3.md`, with the
cards `data/fs114/briefs/ROUND3-card.md` and `data/fs114/briefs/ROUND2-card.md`, FS114-N's brief `data/fs114/briefs/N114-proof.md` and
`data/fs114/briefs/STANDING-RULES.md` (rule 0 read first). Working files `data/fs114/fs114-n4/`; exact checks `tools/fs114_n4_*.py`. Notation is
FS114-N's, FS114-N2's and FS114-N3's (`plans/FS114-N-proof.md` header and § Continuation; `plans/FS114-N3-proof.md` header and §2): tiles, `ω(x)`,
`P_cl(x)`, `Γ`, `F`, `R`, close / far, a **tactic edge** (a whole unit arc on `ω(q)`, inner tile `x` with `q ∈ cl x`, and a tile of the outer tile's
colour touching `x` at `q` alone), the **ring** `ω(p)`, a **change point**, N-E0, N-E1, N-E2 (`plans/FS110-N-proof.md` §1.4), N3-FACE, N3-HALF,
N3-FLANK, N3-PAIR, N3-ODD. All statements are for **non-Siamese** valid maps (no two distinct tiles of one colour close) unless said otherwise.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| N4-QT | Every quotation my brief and the cards rely on, where its source is open to me, is found verbatim (29 of 29); the card's summaries compared by hand; one paraphrase noted (LOCAL-F loses "explicit") | [tools] | §1.2; `tools/fs114_n4_quotes.py` |
| N4-OWN | A Reuleaux corner of the bowtie never carries the colour of the lune it bounds (`2 ∉ P_cl(q1), P_cl(q3)`; `4 ∉ P_cl(q2), P_cl(q4)`): `ω(q1)` leaves `p` tangent to the `t2 | t3` edge and curves into `t2` | [hand, one mind; tools exact at a named point] | §2.1; `tools/fs114_n4_bowtie.py` own |
| N4-LENS | If `|u − v| = 1`, a tile meeting the open lens `B(u,1) ∩ B(v,1)` with a colour of `P_cl(u)` is `u`'s tile of that colour (likewise `v`); a colour that `u` and `v` carry on different tiles meets no point of the open lens | [hand, one mind] | §2.1 |
| N4-TOP | In the degenerate member (one change point, at the lune's ring midpoint `top`): the ring tiles `T_R ⊂ B̄(q1,1) ∩ B̄(top,1)`, `T_L ⊂ B̄(q3,1) ∩ B̄(top,1)`; one tile `W` of the far lune's colour fills the outer wedge at `top`, cone exactly `[60°, 120°]`, bordered by arcs of `ω(q1)` and `ω(q3)`; the lune tile reaches `top`, a **degree-4 vertex of four colours `{2, 4, 5, 6}` at distance 1 from `p`** | [hand, one mind] | §2.2 |
| N4-HORN | (N3-DR0's step 3, kept) the ring tile `T_R` and the partner `z4` are never adjacent at `q1` in the degenerate member | [hand, one mind; tools exact at named values] | §2.2; `… horn` |
| N4-DR0 | **N3-DR0's proof fails; its conclusion holds, at radius `√3`** (stage 3's N4-D). N3's step 1 assumes the ring tile at the change point reaches the direction of `p`; it need not, and at radius `1 + ε` the degenerate member passes every check: its corners carry **exactly five colours `{1, 3, 4, 5, 6}`** (degree 5), in one of two orders (O1) `t1 | Y3 | z4 | V6 | T_R` or (O2) `t1 | Y6 | z4 | V3 | T_R`. *(Stage 2 filed this row as "FALSE as stated"; withdrawn at stage 3: the statement is TRUE, the proof is the GAP.)* | [hand, one mind] | §2.2, §3.1 |
| N4-FIVE | **The card's question answered:** five colours at a Reuleaux corner are not forced by the bowtie alone; with the lune rings free of `Γ`, a corner carries five colours iff its lune's ring is degenerate, and otherwise exactly four `{1, 3, 4, X}` (degree 4; N3's (ii) with its exception `t2 ∋ q1` closed by N4-OWN) | [hand, one mind] | §2.3 |
| N4-ARC | At a five-colour corner `q1`: `ω(q1) ∖ Γ` is colour 2 only, and the 60° arc of `ω(q1)` from `P90 = q1 + e(90°)` to `top` lies in `Γ` (its points are in `B(top,1) ∖ B̄(p,1)`, out of reach of every colour-2 tile); so 120° of unit arcs centred at `q1` lie within radius `√3` of `p`, and FS112-SIX's demand adds nothing beyond N-E0 on the far arc | [hand, one mind; tools exact at named values] | §2.4; `… arc` |
| N4-A4NB | At `top` A4SIX is vacuous (`(top, p)` is a covering pair) and NB4P is escaped by the caps (an arc of `ω(p)` ends at `q1`, an orbit point); at a four-colour corner NB4P is escaped by `t1`'s own arc on `ω(q1)`: **neither gives the bowtie a new constraint** | [hand, one mind] | §2.5 |
| N4-L60 | **FS112-L60 is FALSE at exactly 60°**: the Reuleaux cap region `Reul(A, B, C) ∖ B̄(P, 1)` (diameter `≤ 1`) is an outer tile along a whole 60° arc of `ω(P)` with constant sides, and the bowtie's cap tile (N3's `T_top`) is one; its proof's step "T_out contains points (1+ε)e beside each end direction" fails there. Corrected: at most 60°, with equality only when the outer tile lies in `B̄(A,1) ∩ B̄(B,1)` | [hand, one mind; tools exact] | §2.6; `… l60` |
| N4-TANG | In the degenerate member the ring tile `T_R` borders `t1` along `t1`'s arc on `ω(q2)` at `q1`, so it has points outside `B̄(P90, 1)`: `T_R` does not reach `P90` (`ω(q2)` and `ω(P90)` are tangent at `q1` from opposite sides) | [hand, one mind; tools exact at a named point] | §3.1; `tools/fs114_n4_dexcl.py` tang |
| **N4-D** | **The degenerate member does not exist at radius `√3`**: no valid fragment on the closed disc of radius `√3` about `p` holds the Reuleaux bowtie with a lune whose ring is free of `Γ` and changes colour once. `q1`'s colour-3 tile must reach `P90`, which forces the far lune's colour-4 tile `W` at `top` along the whole arc of `ω(q1)` from `top` to `P90`; by the mirror it reaches `P90′ = q3 + e(90°)` too, and `|P90 − P90′| = √3` | [hand, one mind; tools exact at named values] | §3.1; `… dexcl` |
| N4-OPP | (N4-OWN's general form) If an edge at `p` lies on `ω(q)`, `|p − q| = 1`, the other branch of `ω(q)` through `p` enters the tile at `p` on `q`'s side of the opposite direction, whose colour is then absent at `q` — unless that branch runs along `Γ` | [hand, one mind] | §4.1 |
| N4-GP90 | In the general member: the ring tile `U1` at `q1` misses `P90` (N4-TANG's argument), and if the lune tile reaches the change point `y′` nearer `q1`, the partner `z4` reaches `P90` (the lens `B(q1,1) ∩ B(top,1)` leaves it nothing else) and the cap tile's cone at `q1` is exactly `[300°, 0°]`; mirror at `q3` | [hand, one mind] | §4.2 |
| N4-K1 | K1's status after this job: excluded for the Reuleaux bowtie with a degenerate `Γ`-free lune (N4-D, radius `√3`); **GAP** at the general bowtie, at lune rings carrying arcs of `ω(p)`, at non-Reuleaux lenses, and at the pinwheel, the `(2, 1, 1, 0)` patterns and three tactic edges (not walked at radius 2) | [hand, one mind] | §4.3 |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|
| enumerate sector orders at a Reuleaux corner of the bowtie | derived them: colours excluded one by one (N4-OWN, N3-FACE, N4-HORN), leaving the two orders (O1), (O2) |
| scan the lune ring's change-point patterns | the dichotomy N4-FIVE by N-E0 on the 120° lune arc (constant on `(30°, 90°)` or not) |
| check L60 numerically on random arcs | one named counterexample by formula (the Reuleaux cap), checked exactly |

## Fence log (standing rule 13; brief § Fences)

1. At start-up `ls -la data/fs114/briefs/` with `wc -c` printed the **names and sizes** of every brief, among them the construction side's
   (`Y114-construction.md`, `Y2-…`, `Y3-114-construction-round3.md`, `YB114-…`), the verifiers' and the advisor's. None opened except mine, the two cards,
   FS114-N's and `STANDING-RULES.md`.
2. `ls plans/ | grep -i fs114` and `ls data/fs114/` printed the **names** `plans/FS114-Y-construction.md`, `FS114-Y2-construction.md`,
   `FS114-Y3-construction.md`, `FS114-YB-verification.md`, `FS114-close-inventory.md` and the directory names `fs114-y`, `fs114-y2`, `fs114-y3`, `fs114-yb`,
   `reports`. Contents not listed or opened.
3. The harness's start-up git status (not a command of mine) showed the untracked names `tools/fs114_y3_rstop.py`, `tools/fs111_w_*.py` and
   `data/fs111/fs111-w/*`, and the recent subjects `FS114-Y3: stage 1` and `FS111-M: …`. A `git log --oneline -1` of mine printed `543d65f2 FS111-W: stage 3`
   (one subject newer than the snapshot). Subjects and names only.

## Stage 1 — SAVED: reading, the quotation check

### 1.1 Read from disk (G50)

- `data/fs114/briefs/STANDING-RULES.md` (rule 0 first), `CLAUDE.md` § The aim and § Counter-priors (loaded; unchanged on disk), my brief, `ROUND3-card.md`,
  `ROUND2-card.md`, `N114-proof.md` — all in full.
- `plans/FS114-N3-proof.md` in full; `plans/FS114-N-proof.md` in full (stage 1 and § Continuation — FS114-N2); `data/fs114/claims.md` in full.
- `plans/FS114-NB-verification.md` header, theorem table, logs and §1.1–1.2 item 0; `plans/FS114-CV-verification.md` and `plans/FS114-CVB-verification.md`
  headers and theorem tables (CV-EXISTS, CVB-EXISTS, CVB-PINCH, CVB-THOM).
- `plans/FS112-derivation.md` header and §§1–2 (U1, SIX, NB4P, A4SIX, L60, LOCK, BEND, N2-RED, N3-NOBOTH, N3-FAIL, N3-COR3, N3-BASE, N3-DENSE3);
  `plans/FS112-N-proof.md` header, §1.2–1.4 (N112-SIX's proof, A4SIX as walk row 1), stage 2 §2.1–2.6 (N112-NB4′, card W, L60, LOCK, BEND, RED).
- `plans/FS110-N-proof.md` theorem-table rows N-E0, N-E1, N-E2; `data/fs110/claims.md` §0's covering-pair line (as grepped). Tools read, not run:
  `tools/fs114_n3_quotes.py` (my side's).

### 1.2 The quotation check (standing rule 5)

`tools/fs114_n4_quotes.py` checks 29 statements with whitespace collapsed and `**` removed, nothing else normalised: **29 of 29 FOUND**
(`data/fs114/fs114-n4/quotes.out`). **Plant:** FS112-SIX with "at least 180°" changed to "at least 120°" is NOT FOUND and its faithful twin FOUND
(`quotes-plant.out`). The rows marked SUMMARY check the source's own words; the comparison with the card's restatement is by hand:
- The card's FS112-SIX, "a five-colour vertex whose ring lies inside a valid map carries unit arcs about it totalling at least 180°": faithful. SIX is
  stated for a vertex of a valid map; "whose ring lies inside" is the right reading for a fragment (N112-SIX's proof reads only `ω(v)`).
- The card's C114-LOCAL-F, "no valid fragment holds a disc of some radius `R` about a vertex of at least four colours": **drops "explicit"** from the
  claim list's "there are an explicit radius `R` and a derivation that no valid fragment exists on the closed disc of radius `R` about a vertex of at least
  four colours". Logged; I work the claim list's form.
- The card's N3-DR0, N3-DR1/DR2, N3-CONT, N3-PAY, K2-loc, GAP-μ, SIAM-KILL: faithful to `plans/FS114-N3-proof.md`. The card's THOM-TOP ("`M − x` stays
  connected at a pinch point and breaks at a hole"): faithful to FS114-CVB-PINCH.
- **Not checkable:** the card's statements of FS114-Y2-BOWTIE, FS114-Y2-GAPS, FS114-Y-DIAL and the 66.9° about `q1` come from the construction side's
  records, fenced from me. I use them at the card's wording and grade only.

## Stage 1 — SAVED

## Stage 2 — SAVED: the corners of the bowtie — N3-DR0 corrected, the five colours placed, the arcs they force

*Frame (the card's): `p = 0`; `t1 = Reul(p, q1, q2)` (colour 1), `t3 = Reul(p, q3, q4)` (colour 3), `q1 = e(30°)`, `q2 = e(−30°)`, `q3 = e(150°)`,
`q4 = e(210°)`; `t2` (colour 2) in the top lune, cone `[60°, 120°]` at `p`; `t4` (colour 4) in the bottom lune, cone `[240°, 300°]`; `t1`'s cone at `p`
is `[300°, 60°]`, `t3`'s `[120°, 240°]`. The four edges at `p` are tactic (the bowtie, N3's DR, rotated by 90°): `t1 | t2` lies on `ω(q2)` (partner `z2`,
colour 2, at `q2`), `t1 | t4` on `ω(q1)` (partner `z4`, colour 4, at `q1`), and so on round. Absent colours at `p`: 5, 6. `top = e(90°)`, `P90 = q1 + e(90°) =
top + e(30°)`. At `q1`, `t1`'s cone is `[180°, 300°]`; the cap (an arc of `ω(p)`) leaves `q1` at `300°`, `t1`'s arc to `p` (on `ω(q2)`) at `180°`, the ring
branch into the top lune at `120°`. **Scope:** non-Siamese, the simple class (N3's §2 setting: a tile's cone at a vertex is one interval; a tile never
touches itself), each lune's ring arc free of `Γ`-arcs of `ω(p)` (N3's working assumption). Every step reads the closed disc of radius 2 about `p` or
less, and names the points it reads. Metric facts: `tools/fs114_n4_bowtie.py` (`data/fs114/fs114-n4/bowtie.out`, all OK; plants `--plant` (top moved to
`e(80°)`: geo, horn, cones fail, 6 lines) and `--plant-arc` (arc's angles moved onto the lune arc: its three `|y| > 1` lines fail) each fire for their
own reason).*

### 2.1 Two lemmas

**N4-OWN [hand, one mind].** *`2 ∉ P_cl(q1)`.* `q4 = −q1`, so `ω(q1)` and `ω(q4)` are tangent at `p`, both in direction 120° (tools, own). The edge `t2 | t3`
leaves `p` along `ω(q4)`, which curves toward `q4`; `ω(q1)` curves toward `q1`, into `t2`'s sector: its points `q1 + e(210° − δ)`, `δ` small, lie in
`t2` (near `p` the map is the four sectors; the named point `q1 + e(195°)` is in the top lune, tools). By N-E1 at `q1`, no tile at `q1` has colour 2. ∎
Likewise `2 ∉ P_cl(q3)`, `4 ∉ P_cl(q2), P_cl(q4)`. It closes N3-HALF (b)'s exception "or contains `q_i`" at the corners: the lune tile never reaches its own
corners. *Reads:* `p`, `q1`.

**N4-LENS [hand, one mind].** *Let `|u − v| = 1`. A tile meeting the open lens `L = B(u,1) ∩ B(v,1)` with a colour `c ∈ P_cl(u)` is `u`'s `c`-tile.* It has
a point within distance `< 1` of points of `u`'s `c`-tile (which reach `u`), so the two are close unless equal (N114-FAR). ∎ Hence a colour carried at `u`
and at `v` by **different** tiles meets no point of `L`. *Reads:* `u`, `v`.

### 2.2 The degenerate member (one change point, at `top`)

*Setting D:* the top lune's ring `(30°, 150°)` changes colour once, at `top`; `T_R` is the tile of the ring on `(30°, 90°)` (colour 5, say), `T_L` that on
`(90°, 150°)` (colour 6) — one tile each (ring points of one colour less than 60° apart are less than 1 apart, N114-FAR). By N3-FLANK the ring branch at
`q1` lies in an absent-colour tile, which is `T_R`: so `T_R ⊂ B̄(q1, 1) ∩ B̄(top, 1)` and `T_L ⊂ B̄(q3, 1) ∩ B̄(top, 1)`.

**N4-TOP [hand, one mind].**
1. *The outer wedge at `top`.* `T_R`'s cone at `top` lies in `[240°, 60°]` (facing `q1`, since `q1 − top = e(−30°)`), `T_L`'s in `[120°, 300°]` (facing
   `q3`). The open wedge `(60°, 120°)` needs tiles of other colours: 1 and 3 are excluded (`t1`, `t3` have cones at `p` meeting the open half-plane
   facing `top`, and neither contains `top`: N3-FACE), 2 only through `t2 ⊂ B̄(p, 1)`, which misses the outer half at `top`, and 5, 6 are taken. So one
   tile `W` of **colour 4**, whose cone contains `(60°, 120°)`.
2. *`W` is not the partner `z4`,* since a tile at `top` inside `B̄(q1, 1)` has cone in `[240°, 60°]`. Two distinct colour-4 tiles at points 1 apart are
   far: `W ∩ B(q1, 1) = ∅ = z4 ∩ B(top, 1)`, and likewise against the partner `z4′` at `q3`. N3-FACE puts `W`'s cone in `[60°, 240°] ∩ [300°, 120°]`: **exactly
   `[60°, 120°]`**. The edge `T_R | W` at `top` lies in `B̄(q1, 1) ∖ B(q1, 1)`: **an arc of `ω(q1)`**, inner `T_R`, outer `W`; `T_L | W` is an arc of `ω(q3)`.
3. **N4-HORN** (N3-DR0's step 3, in this frame; tools, horn). *`T_R` and `z4` are not adjacent at `q1`.* If they were, their edge would lie in
   `B̄(top, 1) ∖ B(top, 1)`, an arc of `ω(top)` leaving `q1` at `60°`, `T_R` inside. Then for small `t` and `0 < u ≪ t²` the point `z = q1 + t e(60°) +
   u e(150°)` lies outside `B̄(top, 1)`, on `z4`'s side; its translate `z + (top − q1)` lies outside `B̄(q1, 1)` near `top` at a direction in `(60°, 120°)`,
   in `W`. Two interior points of colour 4 at distance 1. ∎
4. *The order at `q1`.* The colours at `q1` lie in `{1, 3, 4, 5, 6}` (N4-OWN). `T_R` reaches `t1` along `t1`'s arc to `p`: the sliver `(120°, 180°)` at `q1`
   lies in `B(p, 1)`, where only tiles at `p` or of colours 5, 6 can sit; `t2` is excluded (N4-OWN), `t3`, `t4` cannot contain `q1`, and a colour-6 tile at
   `q1` has its cone in `[240°, 60°]` (N3-FACE against `T_L` at `top`). Going round from `t1`'s end at `300°`: a tile `Y` (the partner `z4` touches `t1` at `q1`
   alone), then `z4`, then a tile `V` (N4-HORN), then `T_R`. `Y` and `V` have colours in `{3, 6}` and differ (one tile with two sectors, or two Siamese
   tiles, otherwise). **So `q1` has degree 5 and exactly the colours `{1, 3, 4, 5, 6}`**, in one of two orders:
   - **(O1)** `t1 | Y3 | z4 | V6 | T_R`;
   - **(O2)** `t1 | Y6 | z4 | V3 | T_R`.
   The mirror argument at `q3` gives `{1, 3, 4, 5, 6}` there too.
5. *The lune tile reaches `top`.* `6 ∈ P_cl(q1)` puts `T_L`'s cone at `top` in `[60°, 240°]` (N3-FACE); `5 ∈ P_cl(q3)` puts `T_R`'s in `[300°, 120°]`. The
   inner half `(180°, 360°)` at `top` lies in `B(p, 1)` near `top`, where only `t2`, `T_R`, `T_L` can be (`t1`, `t3`, `t4` miss `top`). So `t2`'s cone at
   `top` contains `[240°, 300°]`: **`top` is a vertex of degree 4 and four colours `{2, 4, 5, 6}` (`T_L, t2, T_R, W`), sharing `t2` with `p` at distance 1.** ∎

*Reads:* the closed disc of radius `1 + ε` about `p`; the vertices `p, q1, q3, top ∈ F`.

**N4-DR0 [hand, one mind].** N3-DR0 ("DR's degenerate member … does not exist") is **FALSE as stated**. Its step 1 excludes the colour `A = c(T_C)` after
`T_D` at the corner because "`T_C` … has cone `(180°, 330°)` at `y₀′` and points toward `a`" — in this frame, that `T_R`'s cone at `top` reaches the
direction of `p`. That is not forced: the inner half at `top` is shared by `T_L`, `t2`, `T_R`, and when `t2` reaches `top` (item 5), `T_R` points toward
neither `q3` nor `p`. What survives of N3-DR0 is its horn step (N4-HORN), which now forces the fifth colour instead of a contradiction. The degenerate
member is exactly the card's design shape (each `q_i` of five colours; `top` and `bot` four-colour at distance 1 from `p`).

### 2.3 The card's question: are the five colours at `q_i` forced by the bowtie alone?

**N4-FIVE [hand, one mind].** **No.** With the lune rings free of `Γ`: *a corner carries five colours if and only if its lune's ring is degenerate; otherwise
it carries exactly four, `{1, 3, 4, X}`, in the order `t1 | Y3 | z4 | T_R`, degree 4.* On the 120° lune arc, N-E0 makes the colour at `θ + 60°` the other one
of the colour at `θ`. If the ring is constant (`X`) on `(30°, 90°)`, it is constant `X̄` on `(90°, 150°)`: the degenerate member, and §2.2 gives five. If not,
`X̄` occurs on `(30°, 90°)`, within distance `< 1` of `q1`, so a second `X̄` tile at `q1` would be close to the ring's: `X̄ ∉ P_cl(q1)`. With 2 excluded
(N4-OWN), the cap tile `Y` has colour 3 (it is not `z4`, which touches `t1` at `q1` alone, and not `T_R`, which would then have two sectors), and nothing
fits between `z4` and `T_R`. This is N3's stage-2 item (ii), with its unstated exception (`t4` at the corner, in N3's frame) closed by N4-OWN. The two
lunes' rings are independent a priori, so a bowtie has 0, 2 or 4 five-colour corners. *Reads:* the ring `ω(p)`, `q1`.

### 2.4 FS112-SIX at a five-colour corner

**N4-ARC [hand, one mind].** *At a five-colour corner `q1` (setting D):* `ω(q1) ∖ Γ` meets only tiles of colour 2 (N-E1, SIX's mechanism). Write
`q1 + e(φ)` for its points (`φ = 150°` is `top`, `210°` is `p`, `270°` is `q2`, `90°` is `P90`).
- `φ ∈ [210°, 270°]`: `t1`'s own arc, 60° of `Γ`.
- **`φ ∈ (90°, 150°)`: the points lie in `B(top, 1) ∖ B̄(p, 1)` (tools, arc).** A colour-2 tile there would be close to `t2` (which reaches `top` and `p`) without
  being `t2` (which lies in `B̄(p, 1)`). **So the whole 60° arc of `ω(q1)` from `P90` to `top` lies in `Γ`.** Its end at `top` is the edge `T_R | W`.
- `φ ∈ (150°, 210°)`, the lune arc: in `t2` or on `Γ` (and in `t2` near `p`, N4-OWN's tangency).
- `φ ∈ (270°, 450°)`, the far arc from `q2` round to `P90`: colour 2 or `Γ`, with no two colour-2 points 60° apart (N-E0), so at least 60° of `Γ` there.
So FS112-SIX's 180° is met once the far arc obeys N-E0: **SIX adds nothing beyond N-E1 and N-E0**. What the card's "about 113° more about each `q_i`"
becomes: **60° of it is forced at once, as one arc from `P90` to `top` within radius `√3` of `p`**; the rest (at least 60°) lies on the far arc,
within radius 2. *Reads:* `ω(q1)`, inside `B̄(p, 2)`.

### 2.5 A4SIX and NB4P, where the brief pointed

**N4-A4NB [hand, one mind].**
- *At `top`* (setting D, four colours `{2, 4, 5, 6}`, ring colours `{1, 3}`): `ω(top)` passes through `p` from `t3` (colour 3) into `t1` (colour 1), so `p` is
  a change point and `(top, p)` a covering pair (`{2, 4, 5, 6} ∪ {1, 2, 3, 4} = [6]`). **A4SIX's hypothesis fails.** NB4P with `y₀ = p`: the orbit is `p, q1,
  P90, (0, 2), q3 + e(90°), q3`, and the cap of `t1`, an arc of `Γ` on `ω(y₀)`, has `y₁ = q1` in its closure — **escaped**, by the bowtie's own arcs.
- *At a four-colour corner* (general member, ring colours `{2, X̄}`): a change point `y₀` on the lune arc of `ω(q1)` has `y₀`'s orbit point 60° further in
  `t1`'s own arc on `ω(q1)` — (E1), **escaped**; with no change point A4SIX asks 60° of arcs centred at `q1`, which `t1`'s arc supplies.
So neither lemma constrains the bowtie beyond what it already carries. The constraints at radius 2 come from N-E1 on the rings of `q_i` and `top` (N4-ARC),
from N4-LENS and from N3-FACE, not from A4SIX or NB4P.

### 2.6 FS112-L60 at exactly 60° — a correction owed

**N4-L60 [hand, one mind; tools exact].** FS112-L60 ("A unit arc with constant sides has angular length below 60°") is **FALSE at exactly 60°** as a local
statement. With `P = 0`, `A = e(0°)`, `B = e(60°)`, `C = A + B`: the Reuleaux triangle `Reul(P, A, B)` inside the arc `α ⊂ ω(P)` from `A` to `B`, and the
**Reuleaux cap** `Reul(A, B, C) ∖ B̄(P, 1)` outside it, both of diameter at most 1, border `α` along its whole length (tools, l60: a named point of the cap
next to `A` lies outside `B(P, 1)` and inside `B(A, 1)`, `B(B, 1)`, `B(C, 1)`); small tiles of two further colours about `A` and `B` complete a valid fragment
on a neighbourhood of the closed arc. The proof's step "T_out contains points (1+ε)e beside each end direction" fails: the radial point beyond `A` lies
outside `B̄(B, 1)`, hence outside any tile containing points near `B` (tools). For `ℓ > 60°` the statement holds (NB's route: interior points `w`, `w + 60°`).
**Corrected: `ℓ ≤ 60°`, with equality only when the outer tile lies in `B̄(A, 1) ∩ B̄(B, 1)`, i.e. in the Reuleaux cap.** The bowtie meets the equality case at
once: N3's stage-2 item (ii) (and N4-FIVE's general member) puts one tile of colour 3 along the whole cap of `t1` when both corners' cap tiles have colour 3 —
a 60° arc with constant sides, which the stated L60 would forbid. **Owed:** the correction to `plans/FS112-derivation.md` FS112-L60, and a check of its
dependants FS112-N2-RED and FS112-N3-COR3 for a strict use of "below 60°" (not done here).

## Stage 2 — SAVED

## Stage 3 — SAVED: the degenerate lune excluded at radius `√3`

*Setting D of §2.2 (top lune's ring free of `Γ`, one change point at `top`), frame and scope as stage 2. Metric facts: `tools/fs114_n4_dexcl.py`
(`data/fs114/fs114-n4/dexcl.out`, all OK; plant `--plant`: the tangency point moved just inside `ω(q2)` and `P90′` moved to distance `0.9` from `P90`,
each failing its own line, `dexcl-plant.out`). **Correction to stage 2:** §2.2's N4-DR0 called N3-DR0 "FALSE as stated". Withdrawn: N3-DR0's conclusion
(the degenerate member does not exist) is TRUE by N4-D below; what fails is its proof, which reads radius `1 + ε`, where the member passes every check.
The theorem table carries the corrected row.*

### 3.1 N4-TANG and N4-D

**N4-TANG [hand, one mind; tools exact].** *`T_R` does not reach `P90 = q1 + e(90°)`.* By N4-TOP item 4, `T_R` borders `t1` along `t1`'s arc from `q1`
toward `p`, an arc of `ω(q2)`, and holds the points just outside it near `q1`. `q2 = q1 − e(90°)` and `P90 = q1 + e(90°)`, so `ω(q2)` and `ω(P90)` are
tangent at `q1` and curve apart; a point just outside `ω(q2)` near `q1` lies outside `B̄(P90, 1)` (tools, tang: `x = q2 + 1.001 e(96°)`, 0.105 from `q1`,
in the sliver). A tile holding such a point and reaching `P90` would have diameter above 1. ∎ *Reads:* `q1`, `q2`, `P90`.

**N4-D [hand, one mind; tools exact at named values].** *No valid fragment on the closed disc of radius `√3` about `p` holds the Reuleaux bowtie with the
top lune in setting D.*
1. *What `q1` carries* (N4-TOP item 4): colours 1 (`t1`), 3 (a tile `C3`), 4 (`z4`, which is not `W`), 5 (`T_R`), 6 (a tile which is not `T_L`, since
   `T_L ⊂ B̄(q3, 1)` misses `q1`); 2 is absent (N4-OWN). At `top` (item 5): `t2`, `W`, `T_R`, `T_L`.
2. *The lens `L1 = B(q1, 1) ∩ B(top, 1)`* (corners `p` and `P90`). By N4-LENS, colours 4 and 6 (carried at `q1` and `top` by different tiles) meet no point of
   `L1`; colour 1 meets it only in `t1`, 2 only in `t2`, both inside `B̄(p, 1)`; 5 only in `T_R`; 3 only in `C3`. So the part `Δ` of `L1` outside `B̄(p, 1)` —
   the curvilinear triangle `q1, P90, top` — lies in `T_R ∪ C3 ∪ Γ`.
3. *`C3` reaches `P90`.* Near `P90`, `Δ` is a sector of 120°; `T_R` misses a neighbourhood of `P90` (N4-TANG); so `C3` fills `Δ` there and `P90 ∈ cl C3`.
   (This alone kills the order (O1), where `C3` is the cap tile `Y3`: a tile holding `q1` and `P90` has its cone at `q1` in `[0°, 180°]`, and `Y3`'s starts at
   `300°`. The order (O2) survives it: `C3 = V3`.)
4. *The arc of `ω(q1)` from `P90` to `top` lies in `Γ`* (N4-ARC). *Its outer side lies in `W` along its whole length.* Take `x` just outside it, at angle
   `φ ∈ (90°, 150°)` about `q1`. Then `x ∈ B(top, 1) ∩ B(P90, 1)`, `x ∉ B̄(q1, 1) ∪ B̄(p, 1) ∪ B̄(q3, 1)` (tools, outer). Colour 2 at `x` would be `t2`'s, 5 `T_R`'s,
   6 `T_L`'s (N4-LENS at `top`), and none of those tiles reaches `x`; colour 3 would be `C3`'s (it reaches `P90`, and `x ∈ B(P90, 1)`), which lies in `B̄(q1, 1)`;
   colour 1 would be close to `t1` (`t1`'s points at `q1` in directions `ψ ∈ (180°, φ + 90°)` lie within distance `< 1` of `x`; tools, outer, at
   `ψ = 185°`). So `x` has colour 4, and is in `W`. Letting `φ → 90°`: **`P90 ∈ cl W`.**
5. *The mirror.* Reflection in the vertical axis fixes `p`, `top`, `t2`, `W` and the setting, and exchanges `q1 ↔ q3`, `t1 ↔ t3`, `T_R ↔ T_L`, `P90 ↔ P90′ =
   q3 + e(90°)`. Items 1–4 at `q3` give **`P90′ ∈ cl W`**.
6. `|P90 − P90′| = √3 > 1` (tools, far): `W` has diameter above 1. ∎

*Reads:* the closed disc of radius `√3` about `p` (a neighbourhood of it); the vertices `p, q1, q3, top ∈ F` and the points `P90, P90′`; the arcs of `ω(q1)`
and `ω(q3)` between `top` and `P90`, `P90′`. **It uses the tactic partners** (`z4`, `z4′`, through N4-TOP) and the simple class; no complexity bound.

**What it says.** The degenerate member is the only configuration in which a Reuleaux corner carries five colours (N4-FIVE); so **in a valid map, the Reuleaux
bowtie's lunes with `Γ`-free rings are general members, and all four Reuleaux corners are four-colour vertices of degree 4**. The card's design (each `q_i` of
five colours; `top`, `bot` four-colour at distance 1) is the degenerate member at both lunes; by N4-D it **stops below radius `√3 ≈ 1.732`** about `p`, and
it cannot be extended to radius 2. **The first piece of C114-LOCAL-F:** *no valid fragment on the closed disc of radius `√3` about a degree-4 four-colour vertex
`p` whose four edges are tactic, with two opposite Reuleaux lenses and one lune whose ring is `Γ`-free with one change point.* It is narrow — one
configuration of one vertex type — and its radius `√3` lies below the strip's `1.834` (another configuration, a midline vertex with no tactic edge at its
lune).

**Would-have-searched here.** A fragment by formula with (O2) at both corners, to see how far it goes: not built — the derivation reaches the obstruction first.

## Stage 3 — SAVED

## Stage 4 — SAVED: the general member, a general lemma, and K1's status at radius 2

### 4.1 N4-OWN in general

**N4-OPP [hand, one mind].** *Let an edge `e` at `p` lie on `ω(q)`, `|p − q| = 1`, leaving `p` in direction `θ`. The other branch of `ω(q)` at `p` leaves in
direction `θ + 180°` and curves toward `q`; unless it runs along `Γ`, it enters the interior of the tile at `p` whose sector contains the directions just to
`q`'s side of `θ + 180°`, and that tile's colour is absent at `q`* (N-E1 at `q`). ∎ In the bowtie it is N4-OWN (`q4 = −q1`: the branch of `ω(q1)` runs along
`t2`'s side of the `t2 | t3` edge). At a degree-4 vertex with four tactic edges it gives four colour absences at the four centres, one per edge; in the
pinwheel (`++++`) the opposite tile is never the edge's own outer tile (N3-SEC (i): no sector exceeds 180°), so there it excludes no partner by itself.
*Reads:* `p`, `q`.

### 4.2 The general member (two change points), what is forced, and where it stops

*Setting G:* the top lune's ring changes colour at `y′ = e(s)` and `y″ = e(s + 60°)`, `s ∈ (30°, 90°)`, with tiles `U1` (colour `X`, `∋ q1`), `U2` (`X̄`),
`U3` (`X`, `∋ q3`). By N4-D (and its mirror across the horizontal axis) **every `Γ`-free lune of a Reuleaux bowtie in a valid map is of this kind.**
Carried and re-derived in this frame:
- *Corners* (N4-FIVE): `q1` has degree 4 and colours `{1, 3, 4, X}` in the order `t1 | Y3 | z4 | U1`; `U1` borders `t1` along `ω(q2)` (the sliver argument of
  N4-TOP item 4, with `X̄` excluded because `U2` comes within distance `< 1` of `q1`). Mirror at `q3`: `t3 | Y1 | z4′ | U3`.
- *The caps* (N3's `T_top`, re-derived): with the bottom lune also general, the tiles on `t1`'s cap at `q1` and at `q2` both have colour 3; two distinct ones would
  be far, putting the one at `q1` in the cone `[0°, 180°]` (N3-FACE), while it starts at `300°`. So **one colour-3 tile touches `q1` and `q2`**, inside
  `B̄(q1, 1) ∩ B̄(q2, 1)` and outside `B(p, 1)` — the Reuleaux cap region. Whether it borders the whole cap (the equality case of N4-L60) or leaves an enclosed
  middle tile of colour `X̄` is open (such a tile must touch the cap at angles `θ ∈ [60° − s_b, s − 60°]`, `s_b` the bottom lune's `s`).
- *N3-DR1 in this frame:* `t2` reaches the ring at `y′` or at `y″`; `z4` reaches `y′` or `z4′` reaches `y″`.

**N4-GP90 [hand, one mind].** *`U1` misses `P90`* (N4-TANG verbatim: `U1` borders `t1` along `ω(q2)` at `q1`). *If `t2` reaches `y′`, then `z4` reaches `P90`
and the cap tile's cone at `q1` is `[300°, 0°]`.* In the lens `B(q1, 1) ∩ B(top, 1)` (`top` is interior to `U2` here, so `P_cl(top) = {X̄}`), N4-LENS leaves near
`P90`, outside `B̄(p, 1)`: `q1`'s tiles (`t1` no, the cap tile no — it lies in `B̄(q2, 1)`, 2 away from `P90` —, `U1` no, `z4`), `U2` (no: `|P90 − y″| > 1`), and
colour-2 tiles other than `t2`. Those are far from `t2`, hence miss `B(y′, 1)` when `t2` reaches `y′`, and `P90 ∈ B(y′, 1)` for `s ∈ (30°, 90°)`. So `z4`
reaches `P90`; then `z4 ⊂ B̄(P90, 1)` puts its cone at `q1` in `[0°, 180°]`, and the cap tile ends at `0°`. ∎ Mirror: if `t2` reaches `y″`, `z4′` reaches
`P90′`. *Reads:* `q1`, `top`, `y′`, `y″`, `P90`.

**Where it stops.** N4-D's kill needed one tile forced to reach both `P90` and `P90′`; in G the tiles forced there are the two partners `z4` and `z4′`, which are
different tiles and may do so. What remains to decide G at radius 2 is the placement of `z4` (inside `B̄(q1, 1) ∩ B̄(P90, 1)`, outside `B(p, 1) ∪ B(q3, 1)`)
against the ring of the four-colour vertex N3-DR2 puts at `y′` or `y″`, and the far arcs of `ω(q1)` (colours 2 and `X̄` only). **Not decided here.**
N3's registration (a fragment realising the general member on `B̄(p, 1 + ε)`, p = 0.7) is untouched; its radius-2 form is the open question.

### 4.3 K1 at radius 2: the status

| pattern at a degree-4 vertex (N3-SEC; the card's GAPS shapes) | status after this job |
|---|---|
| `+−+−`, two opposite Reuleaux lenses, a lune whose ring is `Γ`-free with one change point | **excluded at radius `√3`** (N4-D) |
| `+−+−`, Reuleaux lenses, both lunes general (G) | GAP: forced structure §4.2; passes every check made |
| `+−+−`, Reuleaux lenses, a lune ring carrying an arc of `ω(p)` (N3-FLANK's other branch) | not walked (scope of stages 2–4) |
| `+−+−`, a lens with `γ < 60°` (non-Reuleaux) | not walked |
| `++++` (the pinwheel), `+++−` and `++−−` (the `(2, 1, 1, 0)` patterns), three tactic edges | not walked at radius 2; N4-OPP gives one colour absence per tactic edge |

So **K1 remains a GAP**; its one closed case is the card's design. Route T's kill therefore still needs the joint payment (N3-JOINT). What N4 adds to it: at a
bowtie vertex with `Γ`-free lunes the four Reuleaux corners are degree-4 four-colour vertices (N4-FIVE with N4-D), each carrying at least one tactic edge (the
cap: inner `t1`, centre `p`, partner `t3`); whether a corner carries three or more (and is itself deficient) is not derived. N3-PAY's assumption that the
continuation ends are cubic is not re-derived here.

## Stage 4 — SAVED
