# FS114-N7 — FS-114's proof side, round 6: three tactic edges, the `(2, 1, 1, 0)` patterns, the pinwheel's E1 and E2

*Job FS114-N7, de Bruijn (Opus 5.5), launched 2026-09-28 12:40 UTC at HEAD `df67fa5f`. Brief `data/fs114/briefs/N7-114-proof-round6.md`, with the
cards `data/fs114/briefs/ROUND4-card.md`, `ROUND3-card.md`, `ROUND2-card.md`, FS114-N's brief `data/fs114/briefs/N114-proof.md` and
`data/fs114/briefs/STANDING-RULES.md` (rule 0 read first). Working files `data/fs114/fs114-n7/`; exact checks `tools/fs114_n7_*.py`; scratch
`scratchpad/fs114-n7/` (my own subdirectory). Resuming check: no record existed at start. Notation is FS114-N's, N2's, N3's, N4's, N5's and N6's
(`plans/FS114-N-proof.md` header; `plans/FS114-N3-proof.md` header and §2; `plans/FS114-N4-proof.md` header; `plans/FS114-N5-proof.md` header;
`plans/FS114-N6-proof.md` header and §2), with NB6's corrections (`plans/FS114-NB6-verification.md`): tiles, `ω(x)`, `P_cl(x)`, `Γ`, `F`, `R`, close / far
(N114-FAR), a **tactic edge**, its inner tile, outer tile, centre and partner, the **ring** `ω(p)`, `κ`, change points, a tile's **cone** at a vertex, the
patterns `+`/`−` and inner counts (N3-SEC), CL and CL-p (NB6 §1b.0), N-E0, N-E1, N-E2, FS112-U1, N3-FACE, N3-HALF, N3-SEC, N3-FLANK, N3-PAIR, N4-LENS,
N4-OPP (NB4's corrected form), N5-SIGHT, N5-BENDG, N6-KAPPA, N6-WIN, N6-RING60, NB6-P60, N6-QOUT. `e(φ)` is the unit vector at angle `φ`. All statements are
for **non-Siamese** valid maps (no two distinct tiles of one colour close) in the **simple class** (a tile's cone at a vertex is one closed interval; a tile
never touches itself) unless said otherwise. FS112-L60 is used only in its corrected form (L60-LE, L60-EQ).*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| N7-QT | Every quotation my brief relies on, where its source is open to me, is found (16 of 16); the brief's restatements compared by hand, all faithful; E1 and E2 (construction side) not checkable | [tools] | §1.2; `tools/fs114_n7_quotes.py` |
| **N7-HUB** | At a four-colour vertex (non-Siamese, simple) whose ring is (Q)-free after the bends, each of the six change points `y_k` is a vertex of at least four colours: the directions toward `p` there lie in tiles of `p` reaching `y_k` (a **tip**, which meets `B(y_{k−1},1) ∩ B(y_{k+1},1)`, so its colour is carried at `y_{k±1}` by no other tile), and the outward directions in tiles of `p`'s colours outside `B̄(p,1)` whose `p`-tiles face away | [hand, one mind; tools exact at named values] | §2.1; `tools/fs114_n7_hub.py` |
| N7-REACH | A tile of `p` reaching `y_k` has cone in `[D_{k−2}, D_{k+1}]`; reaching two change points, they are adjacent and it lies in their Reuleaux triangle on `p` | [hand, one mind; tools] | §2.1 |
| N7-TAN | At `D_m` the circles `ω(y_{m−1})` (clockwise) and `ω(y_{m+2})` (counter-clockwise) are tangent; the tile of `p` holding a branch has a colour absent at that centre, the side decided by the edge's curvature | [hand, one mind; N4-OPP in NB4's form; tools] | §2.1 |
| N7-TAC | On a (Q)-free ring every tactic edge leaves at some `D_m`, a `+` edge along `ω(y_{m+2})`, a `−` edge along `ω(y_{m−1})`; inner tile reaches the centre, outer tile misses its open unit disc | [hand, one mind; over N3-FLANK, N6-RING60] | §2.1 |
| **N7-3T** | **Three or more tactic edges at a degree-4 vertex with a (Q)-free ring are excluded at radius `1 + ε`**, except the open-cap family **OC** (`+−+`, a Reuleaux lens beside a `60°` anti-lens; with a fourth tactic edge, the Reuleaux bowtie whose lenses do not border the caps): the `(2, 1, 1, 0)` patterns, the pinwheel, `γ = 0°` and non-Reuleaux lenses, `++−`, `−++` die in every member | [hand, one mind] | §2.2 |
| N7-FLANK | A tile of `p` with cone `[a, b]` puts its colour at no ring point in `(a ∓ 90°, b ∓ 90°)`; in `W(t) = [b − 90°, a + 90°]` only as itself, in `W̄(t)` only as other tiles; a ring point carries at most two colours of `p` | [hand, one mind; N-E1, N-E2] | §3.1 |
| **N7-QOPP** | Every (Q) arc of a four-colour degree-4 vertex joins opposite tiles (inner `t_i`, outer colour `c_{i+2}`); the other two tiles' colours are absent along it | [hand, one mind; tools] | §3.1; `tools/fs114_n7_oc.py` |
| N7-CHAIN | Change points propagate by `±60°` until the next point lies on a (Q) arc | [hand, one mind; N6-KAPPA] | §3.1 |
| N7-HUBQ | At a change point whose `±60°` points have `κ` defined just outside, a tip exists (N7-HUB (b) with (Q) arcs allowed) | [hand, one mind] | §3.1 |
| N7-OCTB | In OC (`θ_4 ∈ (180°, 240°]`): `top = R_0 | W | R_1 | t2` with `W` of colour 4, `R_0 | W` an arc of `ω(q1)`; `bot = R_4 | t4 | R_3 | W′` with `W′` of colour 2, cone exactly `[240°, 300°]`, bordered by arcs of `ω(q4)`, `ω(q2)` toward `P`, `P′` (`√3` apart) | [hand, one mind; tools] | §3.3 |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|
| enumerate sign patterns, cone vectors and reach assignments at a degree-4 vertex with three tactic edges | N7-HUB's tips, N7-REACH and N7-TAN by hand, pattern by pattern (§2.2); metric facts checked at named values only |
| scan (Q)-arc placements and cone parameters per pattern for survivors | N7-QOPP and N7-FLANK's windows in closed form by hand (§3.1–3.2); no scan |
| build OC as a fragment by formula to see how far it goes | not built (the construction side's kind of object); its forced structure derived (§3.3) |

## Fence log (standing rule 13; brief § Fences)

1. **The harness's start-up context** (not a command of mine) included the auto-memory index, a file under `~/.claude/projects/-home-kooshi-source-lean-dir/`
   (fenced): milestone status lines, no proof content. The start-up git status printed the untracked names `data/fs111/fs111-w/*` (FS-111) and
   `data/fs114/briefs/N7-114-proof-round6.md`, and five commit subjects (FS-114 inventory, FS114-YB4 stages and report). Names and subjects only.
2. At start-up `ls -la data/fs114/briefs/` with `wc -c` printed the **names and sizes** of every brief, the construction side's (`Y…`, `YB…`), the
   verifiers' (`NB…`, `CV…`, `CVB…`), the advisor's and the planner's among them. None opened except mine, the three cards, FS114-N's and
   `STANDING-RULES.md`.
3. `ls plans/FS114-* data/fs114/ data/fs114/reports/` printed the **names** `plans/FS114-Y-construction.md`, `FS114-Y2…Y6-construction.md`,
   `FS114-YB-verification.md`, `FS114-YB2…YB4-verification.md`, `FS114-NB-verification.md`, `FS114-close-inventory.md`, the directory names `fs114-y`,
   `fs114-y2…y6`, `fs114-yb`, `fs114-yb2…yb4`, and **the file names in `data/fs114/reports/`** (a fenced directory; every job's report name). Contents not
   listed or opened.
4. `git log --oneline -15` at start-up showed ten subjects older than the start-up snapshot's five (among them `FS114-Y6: stage 1`, `FS114-YB4: stage 1a`,
   `FS114-NB6: stage …`, `FS111-M3: report (14 lines)`). Subjects only.

## Stage 1 — SAVED: reading, the quotation check

### 1.1 Read from disk (G50)

- `data/fs114/briefs/STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim and § Counter-priors (loaded at start-up as the project's instructions); my
  brief, `ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md`, `N114-proof.md` — all in full.
- `data/fs114/claims.md` in full.
- `plans/FS114-N6-proof.md` in full; `plans/FS114-NB6-verification.md` header, theorem table, logs, §1b and §1c in full; `plans/FS114-N5-proof.md` theorem
  table, §2 and §4 in full; `plans/FS114-NB5-verification.md` theorem table; `plans/FS114-N4-proof.md` theorem table and §2–§5 in full;
  `plans/FS114-NB4-verification.md` N4-OPP's corrected form; `plans/FS114-N3-proof.md` header, theorem table, §2 and §3 in full; `plans/FS114-N-proof.md`
  theorem table and N2-KILL.
- `plans/FS114-L60-audit.md` header and theorem table; `plans/FS114-CV-verification.md`, `plans/FS114-CVB-verification.md`: the CV-EXISTS rows.
- `plans/FS110-N-proof.md` theorem rows of N-E0, N-E1, N-E2; `plans/FS112-derivation.md` the statement of FS112-U1.

### 1.2 The quotation check (standing rule 5)

`tools/fs114_n7_quotes.py` checks 16 statements with whitespace collapsed and `**` removed, nothing else normalised: **16 of 16 FOUND**
(`data/fs114/fs114-n7/quotes.out`, exit 0). **Plant:** N2-ENDS's degree-4 charge `(n − 2)` changed to `(n − 1)` is NOT FOUND and its faithful twin FOUND
(`quotes-plant.out`, exit 0). By hand, the brief's restatements against the sources' words:
- K1, "a degree-4 vertex of a non-Siamese valid map has at most two tactic edges": faithful to N2-KILL's K1.
- "N2-ENDS charges a degree-4 vertex with three tactic edges `−1` and with four `−2`": N2-ENDS's degree-4 charge is `n − 2`, `n` the non-tactic edges; with
  `n = 1, 0` it is `−1, −2`. Faithful.
- "(Q) arc is FS-112's term: a boundary arc along `ω(p)` whose inner and outer colours are both carried at `p`": FS-112's header says "an arc whose centre
  carries both side colours and at least four colours". The brief drops "at least four colours", automatic at the four-colour vertex `p`. Faithful in the
  setting.
- "your side's N6-NOQ excludes it at `1 + ε` when its ring carries no (Q) arc": faithful to N6-NOQ (and NB6-NOQ).
- "N6-CENT: on a (Q)-free ring these need a (Q) arc": faithful to N6-CENT's last clause in NB6-CENT's reading (`0° < γ < 60°`).
- **Not checkable:** E1 and E2 are the construction side's (fenced). I use them at the brief's wording only, and state my reading of E2 where I use it (§3).

## Stage 1 — SAVED

## Stage 2 — SAVED: the (Q)-free ring — a hub lemma, and every configuration with three or more tactic edges but one excluded at radius `1 + ε`

*Setting: `p = 0` a vertex of a non-Siamese valid map in the simple class carrying exactly four colours (so degree 4), tiles `t1 … t4`
counter-clockwise, edges `e_i = t_i | t_{i+1}` leaving `p` at `θ_i`, absent colours `X, X̄`; the map is bent on a fragment of radius `1 + ε`
about `p` (NB6 §1b.0: then every ring `Γ`-arc but the (Q) arcs is removed, and the tactic edges, inner tiles and partners are kept, N5-BENDG). **The ring
is (Q)-free**: then by N6-RING60 (two minds, one blind) its change points are exactly `y_k = e(ψ_k)`, `ψ_k = y + 60k`, and the ring tile `R_k` (colour `X`
for even `k`, `X̄` for odd, say) realises `κ` on `(ψ_k, ψ_{k+1})` and holds `y_k`, `y_{k+1}` in its closure. Write `D_m = y + 30° + 60m` (indices mod 6).
A tile **reaches** `y_k` when `y_k` is in its closure. Metric facts: `tools/fs114_n7_hub.py` (`data/fs114/fs114-n7/hub.out`, 40 lines OK, exit 0; plant
`--plant`, `y_1` moved to `e(64°)`, fails exactly the five lines at `y_0` resting on `|y_0 − y_1| = 1`, `hub-plant.out`, exit 1).*

### 2.1 N7-HUB — the six change points of a (Q)-free ring are four-colour vertices, each with a tip

**N7-HUB [hand, one mind; tools exact at named values].** *At each change point `y_k`:*
- *(a) `R_k`'s cone at `y_k` lies in `[ψ_k + 30°, ψ_k + 150°]` and `R_{k−1}`'s in `[ψ_k + 210°, ψ_k + 330°]`;*
- *(b) the open cone `(ψ_k + 150°, ψ_k + 210°)` at `y_k` (the directions toward `p`) lies in cones of tiles of `p` reaching `y_k`; call such a tile a
  **tip** at `y_k`. A tip meets `B(y_{k−1}, 1) ∩ B(y_{k+1}, 1)`, so its colour is carried at `y_{k−1}` and at `y_{k+1}` by no tile other than itself;*
- *(c) the open cone `(ψ_k − 30°, ψ_k + 30°)` at `y_k` lies in cones of tiles of colours of `p` that are not tiles of `p`; the tile of `p` of each such
  colour has its cone at `p` in `[ψ_k + 90°, ψ_k + 270°]`. So `y_k` carries at least four colours: `X`, `X̄`, a tip's, and an outer tile's.*

*Proof.* (a) `R_k` holds `y_{k+1}`, so `R_k ⊂ B̄(y_{k+1}, 1)`: its cone faces `y_{k+1}` (`y_{k+1} − y_k` points at `ψ_k + 120°`), `[ψ_k + 30°, ψ_k + 210°]`.
`R_{k−2}` holds `y_{k−1}`, has `R_k`'s colour, and is another tile (a tile holding `y_{k−2}` and `y_{k+1}` has diameter 2); by N-E2 at the unit pair
`(y_k, y_{k−1})`, `R_k ∩ B(y_{k−1}, 1) = ∅`: its cone faces away from `y_{k−1}` (at `ψ_k + 240°`), `[ψ_k + 330°, ψ_k + 150°]`. Intersect. Mirror for
`R_{k−1}` (tools, RCONE). (b) For a direction `u` in the open cone, `y_k + tu` lies in `B(p, 1) ∩ B(y_{k−1}, 1) ∩ B(y_{k+1}, 1)` for small `t` (tools,
TIP, with the cone exact: TIP 140°, 220°). A tile at `y_k` whose cone holds `u` has such points. If its colour is absent at `p`, it has points within `< 1`
of `R_{k−1}`'s and `R_k`'s points near `y_k`, so by CL it is `R_{k−1}` or `R_k`, whose cones (a) miss `u`. So its colour is at `p`, and by CL-p it is the tile
of `p` of that colour. A tile of the same colour at `y_{k±1}` other than the tip would put the tip outside `B(y_{k±1}, 1)` (N-E2). (c) A direction `u`
there points outside `B̄(p, 1)`; an absent colour is excluded as in (b); a tile of `p` lies in `B̄(p, 1)`, so its cone at `y_k` faces `p` and misses `u`. The
tile of `p` of the same colour is another tile, and N3-FACE at the unit pair `(p, y_k)` puts its cone in the half-plane facing away from `y_k`. ∎ *Reads:*
the closed disc of radius `1 + ε` about `p`; the vertices `p` and `y_0, …, y_5` (six vertices of `F` on `ω(p)`, by (c)).

**N7-REACH [hand, one mind; tools WIN, DIST].** *A tile of `p` reaching `y_k` has cone `⊂ [ψ_k − 90°, ψ_k + 90°] = [D_{k−2}, D_{k+1}]`. One reaching two
change points reaches two adjacent ones, `y_k` and `y_{k+1}`, lies in `Reul(p, y_k, y_{k+1})` and has cone `⊂ [D_{k−1}, D_{k+1}]`.* Diameter at most 1;
non-adjacent change points are `√3` or `2` apart. ∎

**N7-TAN [hand, one mind; tools TAN].** *At `p`, the circles `ω(y_{m−1})` and `ω(y_{m+2})` are tangent in the direction `D_m`, the first curving clockwise
(toward `y_{m−1}`), the second counter-clockwise. By N-E1 at `y_j` (N4-OPP in NB4's corrected form): the tile of `p` holding the branch of `ω(y_j)` near
`p` has a colour absent at `y_j`. Hence (i) if `D_m` is interior to a tile's cone, that tile's colour is absent at `y_{m−1}` and at `y_{m+2}`; (ii) if exactly
one edge `e` leaves `p` at `D_m`, with signed curvature `κ_e` (counter-clockwise positive), the branch of `ω(y_{m−1})` (curvature `−1`) lies in the tile
clockwise of `e` when `κ_e > −1`, and the branch of `ω(y_{m+2})` (curvature `+1`) in the tile counter-clockwise of `e` when `κ_e < 1`; `κ_e = ∓1` is the edge
along the circle.* The edges are segments and circular arcs, so near `p` the second-order comparison decides the side. ∎

**N7-TAC [hand, one mind; over N3-FLANK, N6-RING60].** *Every tactic edge at `p` leaves at some `D_m`. A `+` edge there (inner tile counter-clockwise) lies
along `ω(y_{m+2})`, centre `y_{m+2}`; a `−` edge (inner tile clockwise) along `ω(y_{m−1})`, centre `y_{m−1}`. Its inner tile reaches the centre; its outer
tile misses the open unit disc about the centre (far from the partner, N-E2) and has cone in the half-plane facing away from it.* Its centre is a change
point (N3-FLANK: the ring carries no `Γ`-arc), so one of the `y_k`; the edge's direction is the centre's `± 90°` (N6-CENT). ∎

### 2.2 N7-3T — three or more tactic edges on a (Q)-free ring

Three tactic edges among four are consecutive; call them `e1, e2, e3` at `D_a, D_b, D_c` (`a < b < c < a + 6` in the cyclic order), so
`t2 = [D_a, D_b]`, `t3 = [D_b, D_c]`, `t4 = [D_c, θ_4]`, `t1 = [θ_4, D_a]`, with `e4` at `θ_4` **tactic or not — no argument below uses its status**. Up to
rotation and reflection (which reverses the order and the signs) the sign patterns are `+++`, `++−`, `+−+`, `−++`. A rotational tile's cone is `60°` or
`120°` (N3-SEC (ii), N7-TAC, N6-PIN180); a lens is Reuleaux (`γ = 60°`, cone `120°`, reaching its two centres) or `γ = 0°` (cone `180°`, one centre); an
anti-lens has cone at most `180°`, possibly `0°` (a cusp in a horn, the two edges tangent at one `D_m`). "`y_k` has no tip" contradicts N7-HUB (b).

**N7-3T [hand, one mind; over N7-HUB, N7-REACH, N7-TAN, N7-TAC].** *At a degree-4 four-colour vertex of a non-Siamese valid map in the simple class whose
ring is (Q)-free after the bends, three tactic edges occur only in the pattern `+−+` (or its mirror `−+−`) with a Reuleaux lens and a `60°` anti-lens: in
the frame above, `t2 ⊂ Reul(p, y_{a+1}, y_{a+2})` with cone `[D_a, D_{a+2}]`, `t3 = [D_{a+2}, D_{a+3}]`, `t4 ⊂ Reul(p, y_{a+4}, y_{a+5})`, `t1` a tip at `y_a`,
`θ_4 ∈ [D_{a+4}, D_{a+5}]` — the **open-cap family OC**. Every other configuration with three or four tactic edges is excluded at radius `1 + ε`.* In
particular: the `(2, 1, 1, 0)` patterns `+++−`, `++−−` (they contain `+++` or `++−`); the pinwheel (N6-NOQ re-derived); the `γ = 0°` lens and every
non-Reuleaux lens; `++−`, `+−−`, `−++`, `−−+` in every member; and `+−+` with a `γ = 0°` lens or an anti-lens other than `60°`. With `e4` tactic OC is the
Reuleaux bowtie whose lenses do not border the caps (N6's K1-OPENCAP), `θ_4 = D_{a+5}`; `θ_4 = D_{a+4}` with `e4` tactic is `+−++`, which contains `−++`.

*Proof, pattern by pattern (every step reads `B̄(p, 1 + ε)`).*

**`+++`.** `t2` reaches `y_{a+2}` and misses `B(y_{b+2}, 1)`; `t3` reaches `y_{b+2}` and misses `B(y_{c+2}, 1)`; `t4` reaches `y_{c+2}`; `t1` misses
`B(y_{a+2}, 1)`, cone in `[D_{a+3}, D_{a+6}]`.
- *`b = a + 1`.* `t2` is not a tip at `y_{a+2}` (it misses `B(y_{a+3}, 1)`); `t4` cannot reach `y_{a+2}` (it reaches `y_{c+2} ∈ {y_{a+4}, y_{a+5}}`), nor `t1`;
  so `t3` is the tip and reaches `y_{a+2}, y_{a+3}` (N7-REACH: cone `⊂ [D_{a+1}, D_{a+3}]`). If `c = a + 3`, the branch of `ω(y_{a+2})` at `D_{a+3}` lies in `t3`
  (N7-TAN (ii): `e3` runs along `ω(y_{a+5})`), against `t3` reaching `y_{a+2}`; so `c = a + 2`, and `t3` misses `B(y_{a+4}, 1)`. At `y_{a+3}` the tip is then
  `t4` (`t2` misses `B(y_{a+3}, 1)`, `t1`'s cone ends at `D_{a+6}`), so `t4 ⊂ Reul(p, y_{a+3}, y_{a+4})`, `θ_4 ≤ D_{a+4}`. `y_{a+5}` and `y_a` can be reached only by
  `t1` (`t4` has two, `t2` reaches `y_{a+2}`), so `t1 ⊂ Reul(p, y_{a+5}, y_a)`, `θ_4 ≥ D_{a+4}`: `θ_4 = D_{a+4}`. Then `t4` reaching `y_{a+3}` needs `e4`'s
  curvature `≤ −1` (the branch of `ω(y_{a+3})`, N7-TAN), and `t1` reaching `y_a` needs it `≥ +1` (the branch of `ω(y_a)`). ∎
- *`b = a + 2`, `c = a + 3`.* `t2` cannot reach `y_{a+1}` (the branch of `ω(y_{a+1})` at `D_{a+2}` lies in `t2`: `e2` runs along `ω(y_{a+4})`). `t3` reaches `y_{a+4}`,
  misses `B(y_{a+5}, 1)`, so the tip at `y_{a+4}` is `t4`: `t4 ⊂ Reul(p, y_{a+4}, y_{a+5})`, `θ_4 ≤ D_{a+5}`. `y_{a+1}` is then reachable only by `t1`, with cone
  `⊂ [D_{a+5}, D_{a+8}]`: `θ_4 = D_{a+5}`, and `e4` would need curvature `≤ −1` (for `t4` at `y_{a+4}`) and `≥ +1` (for `t1` at `y_{a+1}`). ∎
- *`b = a + 2`, `c = a + 4`.* `t2` reaches only `y_{a+2}`, `t3` only `y_{a+4}` (the branch of `ω(y_{a+3})` at `D_{a+4}` lies in `t3`), and `t4` (from `D_{a+4}`) and
  `t1` (to `D_{a+6}`) cannot reach `y_{a+3}`: it has no tip. ∎ (`b = a + 1` covers `c = b + 2` with `b − a = 1`.)

**`++−`** (`t3` the lens). `t2` misses `B(y_{b+2}, 1)`; `t4`, outer to `e3` (centre `y_{c−1}`), misses `B(y_{c−1}, 1)`; `t1` misses `B(y_{a+2}, 1)`.
- *`γ = 0°` (`c = b + 3`, one centre `y_{b+2}`).* `D_{b+1}`, `D_{b+2}` are interior to `t3`, so `t3` reaches only `y_{b+2}` (N7-TAN (i)). If `b = a + 1`: at `y_{a+2}`
  `t2` misses `B(y_{a+3}, 1)`, `t3` does not reach, `t4` has cone from `D_{b+3}` (outside `[D_{b−1}, D_{b+2}]`), `t1` misses `B(y_{a+2}, 1)`: no tip. If
  `b = a + 2`: `y_{b+1}` is reached by none (`t2` from `D_{b−2}` cannot join `y_b` to `y_{b+1}`; `t1 ⊂ [D_{b+3}, D_{b+4}]`, `t4` from `D_{b+3}`). ∎
- *Reuleaux (`c = b + 2`, `t3 ⊂ Reul(p, y_{b+1}, y_{b+2})`).* If `b = a + 1`: `e1` and `e3` both have centre `y_{b+1}`; `y_{b+3}` is reachable only by `t4`, so
  `θ_4 ≤ D_{b+4}`; `t4` cannot reach `y_{b+4}` (the branch of `ω(y_{b+4})` at `D_{b+2}` lies in `t4`: `e3` runs along `ω(y_{b+1})`), so `t1` does — but the branch
  of `ω(y_{b+4})` at `D_{b+5} = D_a` lies in `t1` (`e1` runs along `ω(y_{b+1})`). If `b = a + 2`: `y_{b+5}` is reachable only by `t1` (`t2` is excluded by the
  branch of `ω(y_{b−1})` at `D_b`), and `t1` misses `B(y_b, 1) = B(y_{(b+5)+1}, 1)`: no tip. ∎

**`+−+`** (`t2` the lens, `t3` the anti-lens, missing `B(y_{b−1}, 1)` and `B(y_{c+2}, 1)`; `t1` misses `B(y_{a+2}, 1)`).
- *`γ = 0°` (`b = a + 3`).* `t2` reaches only `y_{a+2}`, and `c(t2) ∉ P(y_a), P(y_{a+1}), P(y_{a+3}), P(y_{a+4})`. `c = a + 3` (a cusp anti-lens) or `a + 4`: `y_{a+1}`
  has no tip (`t1` misses `B(y_{a+2}, 1)`; `t4` reaches `y_{c+2}`, not adjacent, or cannot join `y_a` to `y_{a+1}` from `D_{a+4}`). `c = a + 5`: `y_{a+3}` is reached by
  none. `c = a + 6` puts `e3` on `e1`'s circle in `e1`'s direction. ∎
- *Reuleaux (`b = a + 2`).* `c(t2) ∉ P(y_a), P(y_{a+3})`. `c = a + 2` (cusp anti-lens in the horn at `D_{a+2}`): `c(t1) ∉ P(y_{a+5})` (branch of `ω(y_{a+5})` at
  `D_a`), and `y_{a+5}` is reached by none. `c = a + 4`: `t3` reaches no change point (`D_{a+3}` interior; the branches of `ω(y_{a+4})` at `D_{a+2}` and of
  `ω(y_{a+3})` at `D_{a+4}` lie in `t3`), and `y_{a+3}` is reached by none. `c = a + 5`: `e2`, `e3` both on `ω(y_{a+1})`; `y_{a+3}` reached by none. **`c = a + 3`**:
  `t3` reaches `y_{a+3}` alone (it is excluded at `y_{a+4}` by the branch of `ω(y_{a+4})` at `D_{a+2}`, and at `y_{a+2}` by that of `ω(y_{a+2})` at `D_{a+3}`); `t4`
  reaches `y_{a+4}, y_{a+5}`; `t1` reaches `y_a`; `θ_4 ∈ [D_{a+4}, D_{a+5}]` — **OC**, which passes every check at this radius (§2.3). ∎

**`−++`** (`t2` the anti-lens, missing `B(y_{a−1}, 1)`, `B(y_{b+2}, 1)`; `t1` reaches `y_{a−1}`; `t3` rotational).
- *`c = b + 1`.* `t3` misses `B(y_{b+3}, 1)`, so the tip at `y_{b+2}` is `t4` (`t2`, `t1` cannot reach), `t4 ⊂ Reul(p, y_{b+2}, y_{b+3})`, `θ_4 ≤ D_{b+3}`. `y_{b+4}` is
  reachable only by `t1`, which needs `a ∈ {b + 4, b + 5}` (its two reached points adjacent, its cone ending by `D_{b+5}`); `y_b` only by `t2`, which needs
  `a ∈ {b + 4, b + 5}` too. `a = b + 4`: the branch of `ω(y_{a+2}) = ω(y_b)` at `D_a` lies in `t2`. `a = b + 5`: `c(t2) ∉ P(y_{b+5})` (branch at `D_b`), so `t1` reaches
  `y_{b+4}, y_{b+5}`, `θ_4 ≥ D_{b+3}`; `θ_4 = D_{b+3}` and `e4` needs curvature `≤ −1` (for `t4` at `y_{b+2}`) and `≥ +1` (for `t1` at `y_{b+5}`). `a = b` (cusp) or `b + 3`:
  `y_{b+4}` is reached by none. ∎
- *`c = b + 2`.* `t3` reaches only `y_{b+2}` (branch of `ω(y_{b+1})` at `D_{b+2}`); `y_{b+1}` can be reached only by `t2` with `a = b + 5` — excluded by the branch of
  `ω(y_{a+2}) = ω(y_{b+1})` at `D_a` — or, for `a = b` (a cusp in the horn at `D_b`), by `t2`, which then must be its tip and misses `B(y_{b+2}, 1)`. ∎

The mirrors `−−−`, `+−−`, `−+−`, `−−+` follow by reflection. ∎

### 2.3 What survives, and where six and the controls are spent

- **OC, at radius `1 + ε`** (frame of N4's bowtie: `t1 = [300°, 60°] ⊂ Reul(p, q2, q1)`, `t2 = [60°, 120°]` the tip at `top`, `t3 = [120°, θ_4] ⊂ Reul(p, q3, q4)`,
  `t4 = [θ_4, 300°]` the tip at `bot`, `θ_4 ∈ [180°, 240°]`; tactic edges at `300°` (along `ω(q1)`, partner of colour 4 at `q1`), `60°` (along `ω(q2)`, partner 2 at
  `q2`) and `120°` (along `ω(q4)`, partner 2 at `q4`); the ring's change points `q1, top, q3, q4, bot, q2`, ring tiles alternating `X, X̄` on the six 60° arcs).
  Forced there: `2 ∉ P(q1), P(q3)`; `1 ∉ P(top), P(bot)`; `4 ∉ P(q2), P(q4)`; `top = R_0 | W | R_1 | t2` with `W` of colour 4 the only outer tile (the only tile of `p`
  facing away from `top` is `t4`), and `W ≠ z4`, so `W ∩ B(q1, 1) = ∅`; `bot` carries `{X̄, X, 4, 2}`. Its lunes' rings are N4-FIVE's degenerate kind (one change point
  at `top`), but its caps are not (Q) arcs, so N4-D does not apply. **Named as the survivor; walked at stage 4.**
- **G83:** every step reads `p` and the six change points, vertices of `F` by N7-HUB (c).
- **Six is spent** at N6-RING60 (two absent colours alternate; with a seventh colour the ring can carry three and the change points need not be `60°`-periodic) and
  at N7-HUB (b)'s exhaustion (absent colours only `X`, `X̄`). The hexagonal seven-colouring: silent at N6-RING60, as required.
- **The controls:** the strip's midline four-colour vertex carries four (Q) arcs, and the disk's corners carry unit arcs centred at them, so N7-HUB's hypothesis
  fails at both; no step is tested there, and no NO is claimed beyond K1's configurations.

### 2.4 Registrations

- *Registered* (G21; both outcomes reachable — a derived obstruction or a fragment by formula): *OC dies within radius `√3` about `p`*, p = 0.5.
- *Registered:* *with (Q) arcs allowed, the survivors of three or more tactic edges at radius `1 + ε` are OC, the Reuleaux bowtie family (N4, N5, NB5: dead at `√3`),
  and pinwheels whose ring carries (Q) arcs*, p = 0.4 (the alternative: new (Q)-ring members of `++−`, `−++` or `+++`).

## Stage 2 — SAVED

## Stage 3 — SAVED: tools for rings with (Q) arcs; where the (Q) cases stand; OC's forced structure

*Setting as stage 2, the ring now allowed (Q) arcs (after the bends on a fragment of radius `1 + ε` they are its only `Γ`-arcs). Metric facts:
`tools/fs114_n7_oc.py` (`data/fs114/fs114-n7/oc.out`, 20 lines OK, exit 0; plant `--plant`, `q4` moved to `e(215°)` so that `|q4 − bot| < 1`, fails exactly the
two BOT-inside lines and the line `P = q4 + e(270°)`, `oc-plant.out`, exit 1).*

### 3.1 Four tools that do not need a (Q)-free ring

**N7-FLANK [hand, one mind; N-E1 and N-E2, the continuous form of N7-TAN].** *Let a tile `t` of `p` have cone `[a, b]`, `b − a < 180°`. Its colour occurs at
no ring point `e(ψ)` with `ψ ∈ (a − 90°, b − 90°) ∪ (a + 90°, b + 90°)` (the branch of `ω(e(ψ))` at `p` in direction `ψ ± 90°` runs inside `t`: N-E1); at ring
points of `W(t) = [b − 90°, a + 90°]` it occurs only as `t` itself, and at those of `W̄(t) = W(t) + 180°` only as tiles other than `t` (N-E2 puts a second tile
of `t`'s colour at `e(ψ)` only where `t`'s cone faces away from it).* So a ring point `e(ψ)` with neither `ψ + 90°` nor `ψ − 90°` an edge direction at `p` carries
**at most two colours of `p`**. ∎ *Reads:* `B̄(p, 1 + ε)`.

**N7-QOPP [hand, one mind; tools QOPP].** *Every (Q) arc `[u, v]` of the ring joins opposite tiles: its inner tile is some `t_i` and its outer colour is
`c_{i+2}`. `t_i`'s cone lies in `[v − 90°, u + 90°]`, `t_{i+2}`'s in `[v + 90°, u + 270°]`, and `t_{i+1}`, `t_{i+3}` hold the two gaps `[u + 90°, v + 90°]`,
`[u + 270°, v + 270°]` in their cones, so their colours are absent along the arc.* The inner tile holds the whole arc (diameter); the tile of `p` of the outer
colour faces away from every arc point (N-E2). The two windows are disjoint with gaps of length `v − u > 0`, so two tiles adjacent at `p`, which share a
bounding direction, cannot be the arc's inner tile and its outer colour's tile. ∎ (N6-QOUT's "outer colour `c_{j+3}`" is its pinwheel instance.)

**N7-CHAIN [hand, one mind; N6-KAPPA].** *If `y` is a change point and `κ` is defined on both sides of `y + 60°`, then `y + 60°` is a change point (and
likewise `y − 60°`).* So the change points form chains `y, y + 60°, …, y + 60°k`, each ending where the next point lies in the closure of a (Q) arc. ∎

**N7-HUBQ [hand, one mind; N7-HUB (b)'s proof].** *At a change point `y` (colour `Ā` just clockwise, `A` just counter-clockwise), if `κ` is defined just
clockwise of `y − 60°` and just counter-clockwise of `y + 60°`, then some tile of `p` reaches `y` and meets `B(y − 60°, 1) ∩ B(y + 60°, 1)` (a tip).* `κ` there is
`A` and `Ā` respectively (N6-KAPPA against `y ∓ δ`), carried by tiles holding `y − 60°` and `y + 60°` that differ from the ring tiles at `y` (diameter), so
those ring tiles miss `B(y ∓ 60°, 1)` (N-E2), and the rest is N7-HUB (b). ∎ **This is exactly where (Q) arcs weaken stage 2:** the tip at a change point can
fail only when a (Q) arc starts at `y + 60°` or ends at `y − 60°`, or holds one of them — then a ring tile at `y` may itself reach toward `p`.

### 3.2 The (Q) cases of K1: what the tools give, and the GAP

- **Where the (Q) arcs can be.** By N7-QOPP and N7-FLANK, a (Q) arc whose inner tile `x` is inner to a tactic edge with centre `q` lies in `W(x)` within `60°` of
  `q`, on `x`'s side (for a `+` edge, just clockwise of `q`), with the opposite tile's colour outside. For the pinwheel this is N6-QOUT; for `++−`, `+−+`, `−++` it
  confines each (Q) arc to one zone `W(t_i) ∩ W̄(t_{i+2})` per tile, computed in closed form from the three centres and `θ_4` (§2.2's frame with the angles
  continuous). No zone argument alone kills a pattern: the zones are non-empty for open sets of parameters.
- **Why stage 2's kills do not transfer verbatim.** They used N6-CENT (cones in `60°ℤ`) and a tip at every change point. With (Q) arcs the centres may sit at (Q)
  ends, so the cones are continuous, and N7-HUBQ supplies a tip only at change points whose `±60°` points are free of (Q) arcs. **The (Q) cases of three and four
  tactic edges are a GAP** at that step: every surviving member has a change point or a centre whose `60°`-neighbour on the ring lies on a (Q) arc.
- **The pinwheel's E1 and E2, in my readings** (the construction side's records are fenced from me; the owner's wording only). *R-E1:* a (Q) arc of full length
  `60°` on the ring; by N6-QOUT it is `[φ_j − 60°, φ_j]` with inner `T_{j+1} ⊂ Reul(p, e(φ_j − 60°), q_j)` (L60-EQ), which needs `α_{j+1} ≤ 120°`,
  `α_{j+1} + α_{j+2} ≥ 180°` and (N6-QE1) `α_j ∉ (60°, 120°)`; at `q_j` the clockwise ring branch is `Γ`, so N7-HUBQ is unavailable there. *R-E2:* `α_{j+1} = 60°`
  with `e_{j+1}` running from `p` to `q_j` (`T_{j+2} ⊂ Reul(p, q_j, q_{j+1})`, N6-P60′'s configuration) and a (Q) arc of `T_{j+2}` starting at `q_j`, whose outer
  tile is the partner `z_j` (N7-QOPP: outer colour `c_j`; one tile per colour at `q_j`) — NB6-QSTART's member, where N6-P60′'s hypothesis on `κ` fails. In R-E2
  derived here: `q_j` carries exactly `R | z_j | T_{j+2} | T_{j+1}` (a four-colour vertex at distance 1 from `p`, `R` the ring tile clockwise of `q_j`, since no (Q)
  arc of `T_{j+1}` can end at `q_j` when `α_{j+2} < 120°`), and N-E1 at `q_j` keeps colour `A` off the interior of every tile holding `e(φ_j − 60°)` (where `ω(q_j)` crosses the
  ring), so `R`'s stretch of colour `A` ends at a change point or (Q) end `y ∈ [φ_j − 60°, φ_j)`. **Not closed:** both are GAP; the next step in R-E2 is the chain of `y` (N7-CHAIN) against the
  (Q) arc of `T_{j+2}` at `y + 60°`.

### 3.3 OC's forced structure (the survivor of stage 2), toward radius `√3`

*Frame of §2.3 (N4's bowtie frame), `θ_4 ∈ (180°, 240°]`.* Using N7-FLANK's windows: the colours of `p` that can sit at `top` on tiles other than `p`'s are those
`c` with `90° ∈ W̄(t_c)`: only 4; at `bot`, only 2.

**N7-OCTB [hand, one mind; tools BOT, TOP].**
- *`top = R_0 | W | R_1 | t2`*, `W` of colour 4 with cone in `[60°, 180°]` containing `(60°, 120°)`; `W` is not the partner `z4` (whose cone at `top` would face
  `q1`), so `W ∩ B(q1, 1) = ∅`, and **the edge `R_0 | W` at `top` is an arc of `ω(q1)`** (`R_0 ⊂ B̄(q1, 1)`) — N4-D's arc from `top` toward `P90`.
- *`bot = R_4 | t4 | R_3 | W′`*, `W′` of colour 2 with cone **exactly `[240°, 300°]`**: it is neither partner of colour 2 (`z2` at `q2`, `z2′` at `q4`; their cones at
  `bot` would face `q2`, `q4`), so it misses `B(q2, 1)` and `B(q4, 1)`; **the edges `R_3 | W′` and `R_4 | W′` are arcs of `ω(q4)` and `ω(q2)`**, running from `bot`
  toward `P = √3 e(240°)` and `P′ = √3 e(300°)`, `|P − P′| = √3`.
- **The route to `√3`** (N4-D's shape, not closed): on the arc `A4` of `ω(q4)` from `bot` to `P` (outside `B̄(p, 1)`, inside `B(bot, 1)`, outside `B̄(q2, 1)`: tools
  ARC) colours 4 and `X`, `X̄`, 2, 3 are excluded (4 by `t4 ⊂ B̄(p, 1)`; 3 because `t3`, the tip at `q4`, holds directions near `0°` there), so `A4 ⊂ Γ` when
  `1 ∈ P(q4)`, and then its outer side meets only colours 2 and 1; likewise `ω(q2)`'s arc to `P′` with 3 in place of 1. **If colour 1 is excluded beside `A4` and
  colour 3 beside the other arc, `W′` reaches `P` and `P′` and has diameter `√3`.** Open: a tile of colour 1 (resp. 3) far from the tiles of that colour at `q4`
  (resp. `q2`) beside the arcs, and the cases `1 ∉ P(q4)`, `3 ∉ P(q2)`, `θ_4 = 180°`.

### 3.4 Registrations and K1 after this job

| configuration at a degree-4 vertex, three or four tactic edges | status after FS114-N7 |
|---|---|
| any pattern, ring (Q)-free | **excluded at `1 + ε`** (N7-3T), except OC |
| OC (`+−+`, Reuleaux lens, `60°` anti-lens; K1-OPENCAP when `e4` is tactic) | GAP at `1 + ε`; forced structure N7-OCTB; route to `√3` named (§3.3) |
| Reuleaux bowtie (lenses bordering the caps) | excluded at `√3` (N4, N5, NB5; earlier rounds) |
| pinwheel with (Q) arcs, incl. R-E1, R-E2 | GAP (§3.2) |
| `++−`, `+−+`, `−++`, `(2, 1, 1, 0)` with (Q) arcs; non-Reuleaux lenses | GAP: every survivor has a change point or centre whose `60°`-neighbour lies on a (Q) arc (N7-HUBQ) |

*Registered* (G21; both outcomes reachable): *OC dies within `√3` by §3.3's route* (p = 0.5, carried from §2.4); *every (Q)-ring survivor of three tactic edges has a
(Q) arc of length exactly `60°` or a (Q) arc ending `60°` from a tactic centre* (p = 0.4).

## Stage 3 — SAVED

## Proposed for the close (I edit none of these files)

- `data/fs114/claims.md` / the derivation file: **K1 on (Q)-free rings** — excluded at radius `1 + ε` except OC (N7-3T); **K1-OPENCAP / OC** — GAP, forced
  structure N7-OCTB, route to `√3` in §3.3; **K1-QRING** (every pattern with (Q) arcs, the pinwheel's E1, E2 included) — GAP at N7-HUBQ's hypothesis. Name
  **N7-HUB** (six four-colour vertices on the unit circle of a (Q)-free four-colour vertex) and **N7-QOPP**, **N7-FLANK** beside N4-LENS, N5-SIGHT and N6-WIN as
  tools of the local route.
- Note for C114-LOCAL-F: N7-HUB says a four-colour vertex whose ring carries no (Q) arc has six four-colour vertices at distance 1 in a regular hexagon — a
  propagation statement a local exclusion might iterate. Not pursued here.
- A blind check of N7-3T should take first N7-HUB (b) (the tip) and the `+++`, `b = a + 1` step, then N7-QOPP.
