# FS114-N3 — FS-114's proof side, round 2: the kills (K1 first)

*Job FS114-N3, de Bruijn (Opus 5.5), launched 2026-09-28 at HEAD `9b226434`. Brief `data/fs114/briefs/N3-114-proof-round2.md`, with the round-2
card `data/fs114/briefs/ROUND2-card.md`, FS114-N's brief `data/fs114/briefs/N114-proof.md` and `data/fs114/briefs/STANDING-RULES.md` (rule 0 read
first). Working files `data/fs114/fs114-n3/`; exact checks `tools/fs114_n3_*.py`. Notation is FS114-N's and FS114-N2's (`plans/FS114-N-proof.md`
header and § Continuation): tiles, `ω(x)`, `P_cl`, `F`, `R`, close / far, `N[x]`, a **tactic edge** (a whole unit arc on `ω(q)`, inner tile `x` with
`q ∈ cl x`, and a tile of the outer tile's colour touching `x` at `q` alone), `n(p)` the non-tactic edges at `p`. New here: at a vertex `p`, the **ring**
is `ω(p)`; a **change point** of the ring is a point of `Γ ∩ ω(p)` where the colour of the ring off `Γ` differs on its two sides; `σ` is the rotation by
`60°` about `p`. All statements are for **non-Siamese** valid maps unless said otherwise; there every vertex carries distinct colours on its tiles.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| N3-QT | Every quotation this record and its brief rely on is verbatim: 27 of 27 FOUND (two needed a single-asterisk emphasis kept, named) | [tools] | §1.2; `tools/fs114_n3_quotes.py` |
| N3-FACE | Two distinct tiles of one colour at vertices `u, w` with `|u − w| = 1` have their cones in the closed half-planes facing away from each other; one tile at both lies in `B̄(u, 1) ∩ B̄(w, 1)` | [hand, one mind; N-E2's cone form] | §2.1 |
| N3-HALF | At a tactic edge at `p` (centre `q`, inner `x`, outer `y`): `x` faces `q`, `y` faces away; every other tile at `p` meeting the open half-plane facing `q` has a colour absent at `q` or contains `q`; at `q` the open half-plane facing `p` meets only `x` and tiles of the two colours absent at `p` (one of each at most) | [hand, one mind] | §2.1 |
| N3-SEC | Every tile adjacent to a tactic edge at `p` has cone `≤ 180°`; two consecutive tactic edges with the tile between inner to one and outer to the other have it `≥ 60°`; a tile inner to both its edges at `p` (a **lens**) has cone `180° − γ ∈ [120°, 180°]`, `γ ≤ 60°` the angle between the two centres | [hand, one mind] | §2.1 |
| N3-FLANK | In the simple class, each branch of `p`'s ring at a tactic centre `q` lies on `Γ` or in a tile of a colour absent at `p`; two such tiles are distinct and of the two different absent colours: `q` is a change point of the ring or an end of a `Γ`-arc of `ω(p)` | [hand, one mind] | §2.1 |
| N3-PAIR | If `y` is an edge point between tiles of colours `c, c′` and `y′` carries `c, c′` at distance 1, the edge through `y` is an arc of `ω(y′)` | [hand, one mind; NB4P's mechanism, local form] | §2.1 |
| N3-ODD | Off `Γ`-arcs of `ω(p)`, every half-open 60° window of the ring of a four-colour vertex holds an odd number of change points | [hand, one mind] | §2.1 |
| N3-DR | **The escaping configuration DR**: a degree-4 vertex with two opposite Reuleaux lenses and all four edges tactic forces, at radius `≤ 1 + ε`: partners `c₂, c₄, c₄, c₂` at `a, b, −a, −b`; one tile of `c₃` over `R1`'s cap (so `R1` is inner to three tactic edges), each corner of degree exactly 4; each lune's ring carrying change points at `s, s + 60°` | [hand, one mind] | §2.2 |
| N3-DR0 | DR's **degenerate member** (a change point `60°` from a Reuleaux corner, `s′ ∈ {0°, −60°}`) does not exist: the partner at the corner and the forced `c₂` tile at the change point realise distance 1 | [hand, one mind; tools exact at named values] | §2.2 (iv); `tools/fs114_n3_dr.py` |
| N3-CONT | In DR (general member) the continuation of each tactic lens arc beyond its end is non-tactic: every end of a tactic edge at `p` and every Reuleaux corner carries a non-tactic edge | [hand, one mind] | §2.2 (v) |
| N3-K1 | **K1: GAP** — not derivable from structure within radius `1 + ε` by any lemma here; DR's general member passes every check made; rotational patterns not walked | [hand, one mind] | §2.3 |
| N3-DR1 | In DR (general member, minimal ring pattern) the two same-colour ring tiles at the change points `y′, y″` (distance 1) would realise distance 1 along the tangent rays `±τ` unless blocked; the only blockers are the lune's `p`-tile (inside) and the corner partners (outside), so **`t₄` reaches the ring at `y′` or `y″`, and `z_a` reaches `y″` or `z_{−b}` reaches `y′`** | [hand, one mind] | §3.1 |
| N3-DR2 | In N3-DR1's case (i) `y″` is a four-colour vertex `{X̄, c₄, X, c₂}` sharing `t₄` with `p` at distance 1, and its ring forces the edge `U₁ | U₂` to run along `ω(y″)` across the whole lune, from `y′` to `R3`'s arc at `y″ − a` | [hand, one mind] | §3.1 |
| N3-JOINT | Route T's count restated: `N + U + 3V₆ = V₄` (non-tactic edges); the non-Siamese simple torus NO ⟸ a fractional assignment giving every degree-4 vertex two units among non-tactic edge-ends (its own or free ones within radius `R`), `U`, and six units per degree-6 vertex, with a unit unused in every disc of radius `R₀` (K1 ∧ K2-loc is the own-ends case) | [hand; N2-SLACK restated] | §3.2 |
| N3-PAY | DR vertices pay: in DR the four continuation ends (N3-CONT) supply `½` each, and a cubic continuation end is claimed by at most two deficient vertices, so DR never breaks the assignment's capacities at cubic ends | [hand, one mind] | §3.2 |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|
| enumerate orientation patterns and sector angles at a degree-4 vertex with three or four tactic edges, to find a realisable one | the lemmas N3-HALF, N3-SEC, N3-FLANK by hand; one configuration (DR) derived from them and walked by hand, its metric facts checked exactly at named values |
| search the lune ring's change-point positions `s′` for a consistent one | N3-ODD's parity by hand; the degenerate member killed by derivation (N3-DR0), the general member walked at `s′ = −30°` only as an instance |
| build and check a DR fragment by solver or by a parameter scan | not done: the fragment is the construction side's kind of object; stated as K1's killing test (§2.3) |

## Fence log (standing rule 13; brief § Fences)

1. At start-up `ls plans/FS114* data/fs114/` listed the **names** `plans/FS114-Y-construction.md`, `plans/FS114-YB-verification.md`,
   `plans/FS114-close-inventory.md` and the directory names `fs114-y`, `fs114-yb`, `reports` (contents not listed); `ls data/fs114/briefs/` with `wc -c`
   listed the other briefs' names and sizes. None opened or grepped.
2. `git log --oneline -8` at start-up showed three subjects older than the start-up snapshot (`06a8c395 FS114-YB: stage 2`, `6f906407 FS114-N2: stage 2`,
   `8ac5aa39 FS114-YB: stage 1`); a later `git log --oneline -3` showed `4d342ef8 FS114-Y2: stage 1a` (the construction side's round-2 subject). Subjects
   only.
3. The owner's mid-stage message (FS114-CV's result) unfenced `plans/FS114-CV-verification.md`; I read its theorem table lines 20–24 and its §1.5 rows
   for GS-1, C-COMPOSE (3) and C114-LOCAL-FR (grep hits), nothing else yet.
4. The owner's second message (FS114-CVB confirms CV-EXISTS, two minds; THOM-TOP settled 2–1) unfenced `plans/FS114-CVB-verification.md`; not opened.

## Stage 1 — SAVED: reading, the quotation check, and where FS114-CV's result bears

### 1.1 Read from disk (G50)

- `data/fs114/briefs/STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim and § Counter-priors (loaded); `data/fs114/briefs/N3-114-proof-round2.md`,
  `ROUND2-card.md`, `N114-proof.md` in full.
- `plans/FS114-N-proof.md` in full (stage 1, § Continuation — FS114-N2, stages N2-2 and N2-3); `plans/FS114-NB-verification.md` in full.
- `plans/FS114-unit-arc-question.md` §G part 3, §IQ, 5.0–5.4 (5.3 included); `data/fs114/claims.md` in full.
- `plans/FS112-derivation.md` header, §1 through FS112-A4SIX, and every entry title of §§1–4; `data/fs110/claims.md` §0 (covering pair, types) and the
  ring notation (the setting before N2-TRANS); `plans/FS112-Y-construction.md` §1.3 (the strip) and stage 4 (the disk's tiles, edges, colours).

### 1.2 The quotation check (standing rule 5)

`tools/fs114_n3_quotes.py` checks 27 statements — the card's restatements of FS114-N2's lemmas (K1, K2-loc, GAP-μ, N2-ENDS, N2-DIAM, N2-SLACK, N2-VCAP,
N2-SIAM, N2-REFINE, the extreme's shape), N114-RD and NB's reading radius, the tactic-edge definition, NB-A1, FS112-NB4P, -U1, -A4SIX, -N3-COR3, -SIX,
C114-LOCAL-F, GS-D, CV-EXISTS as the owner's message states it, and Kooshi's two quotations in the standing rules — with whitespace collapsed and `**`
removed: **27 of 27 FOUND** (`data/fs114/fs114-n3/quotes.out`). Two failed on a first run because the source keeps single-asterisk emphasis
(`*(a claim)*`, `*(this list)*`); the quotations were corrected to the source's form, nothing normalised further. **Plant:** K1 with "at most two" changed to
"at most three" is NOT FOUND and its faithful twin FOUND (`quotes-plant.out`). The card's statements of FS114-Y-DIAL, -PAIRSHARE and -K6 come from the
construction side's round-1 record, fenced from me: **not checked** (I use them only at the card's grade and wording). **No quotation in my brief or the
card differs from its source** among those I could check; the card's "`n` (degree 3)" is N2's "`n` (cubic)", a rewording with no change of content.

### 1.3 Where FS114-CV's result bears (the owner's message, 2026-09-28)

CV-EXISTS (one mind; "every valid map has a vertex of at least four colours — in the map itself, no modification needed, no residue, no ray step") makes
C114-LOCAL-F alone the NO. It bears here in three places:
1. **K1's object is C114-LOCAL-F's object.** In the non-Siamese class a degree-4 vertex carries four colours, so a K1-escaping vertex is a four-colour vertex,
   and a valid fragment about it of radius `R` is exactly what C114-LOCAL-F must exclude at its `R`. Any configuration I derive as K1's escape is therefore
   also a candidate for the radius dial (FS114-Y-DIAL's `φ²/√2 ≈ 1.8512` is the strip's).
2. **Route T and the local route meet at one vertex type.** Route T needs K1 (at most two tactic edges at a degree-4 vertex) because the count's only negative
   charge sits there; the local route needs every four-colour vertex excluded at some radius. A local exclusion of the degree-4 vertices with three or four
   tactic edges would serve both.
3. **The Siamese half.** CV-EXISTS holds Siamese or not; route T does not. If CV-EXISTS is confirmed, SIAM-KILL (my stage 4) is subsumed by C114-LOCAL-F
   about a four-colour vertex of a Siamese map — the count need not reach it.

## Stage 1 — SAVED

## Stage 2 — SAVED: K1 — the local lemmas, the escaping configuration DR, its degenerate member killed; K1 GAP

*Setting throughout: a non-Siamese valid map, in the simple class where a lemma says so (every tile an open disc meeting each other tile's
closure in a connected set and not touching itself — the plane form of `μ = 0`). At a vertex a tile's **cone** is its set of limit directions
(its sector, a closed interval of directions in the simple class, possibly a single direction at a cusp). `p` is a vertex of degree 4 with tiles
`t₁ … t₄` counter-clockwise, colours `c₁ … c₄`, absent colours `c₅, c₆`; `e_i` separates `t_i` (clockwise side) from `t_{i+1}` and leaves `p` in the
tangent direction `θ_i`; a tactic `e_i` has centre `q_i`, inner `x_i`, outer `y_i`, partner `z_i` (colour `c(y_i)`, touching `x_i` at `q_i` alone).
Every lemma reads the disc of radius `1 + ε` about `p` unless it says otherwise, and uses no complexity bound. Which vertices of `F ∪ R` each reads
(G83) is named with it.*

### 2.1 The local lemmas

**N3-FACE [hand, one mind].** *Let `T ∋ u`, `T′ ∋ w` (closures) be distinct tiles of one colour with `|u − w| = 1`. Then `T`'s cone at `u` lies in
`{v : v·(w − u) ≤ 0}` and `T′`'s at `w` in `{v : v·(u − w) ≤ 0}`. A single tile with `u, w` in its closure lies in `B̄(u, 1) ∩ B̄(w, 1)`.* Proof: the pair
is far (non-Siamese), so `dist(T, T′) ≥ 1`; a limit direction `v` of `T` at `u` with `v·(w − u) > 0` gives points `u + t_k v_k ∈ T` with
`|u + t_k v_k − w|² = 1 − 2t_k v_k·(w − u) + t_k² < 1`, while `T′` has points arbitrarily near `w`. The second sentence is diameter `≤ 1`. ∎ *Reads:* `u, w`.

**N3-HALF [hand, one mind].** *At a tactic `e_i`: (a) `x_i`'s cone at `p` lies in `{v·(q_i − p) ≥ 0}` and `y_i`'s in `{v·(q_i − p) ≤ 0}`; (b) every
tile `t ≠ x_i` at `p` whose cone meets the open half-plane `H_i⁺ = {v·(q_i − p) > 0}` has a colour absent at `q_i`, or contains `q_i`; (c) every tile at
`q_i` other than `x_i` with a colour of `P_cl(p)` has its cone in `{v·(p − q_i) ≤ 0}` unless it contains `p`; so the open half-plane at `q_i` facing `p`
meets only `x_i`'s cone and cones of tiles of colours `c₅, c₆`, at most one of each.* Proof: (a) `x_i ⊂ B̄(q_i, 1)`; `z_i ≠ y_i` (one shares an arc
with `x_i`, the other touches it at a point alone) are of one colour, at `q_i` and `p`: N3-FACE. (b), (c): N3-FACE's contrapositive; a tile at `p`
containing `q_i` is the one exception, and there at most one tile of each colour sits at `q_i`. ∎ *Reads:* `p`, `q_i ∈ F`.

**N3-SEC [hand, one mind].** *(i) Both tiles adjacent to a tactic edge at `p` have cones `≤ 180°`. (ii) If `t_{i+1}` is inner to `e_i` and outer to
`e_{i+1}` (both tactic), its cone `α_{i+1} ≥ 60°`. (iii) A tile inner to both its edges at `p` (a **lens**; centres `q, q′`, the angle `γ = ∠qpq′`)
has `γ ≤ 60°` and cone exactly `180° − γ ∈ [120°, 180°]`.* Proof: (i) N3-HALF (a). (ii) `t_{i+1} ∋ q_i` lies outside `B(q_{i+1}, 1)`, so
`|q_i − q_{i+1}| ≥ 1`, and the angle between them at `p` is `α_{i+1}`. (iii) `q, q′ ∈ cl` of the lens, so `|q − q′| ≤ 1`; its cone is the intersection
of the two closed half-planes facing `q` and `q′`, bounded by the two edges, which are tangent to those half-planes' lines. ∎ **The patterns.** Mark a
tactic `e_i` `+` when its inner tile is `t_{i+1}` and `−` when it is `t_i`; a tile's **inner count** is the number of tactic edges at `p` it is inner
to (0, 1 or 2: **anti-lens**, **rotational**, **lens**), and the counts sum to the number of tactic edges. Four tactic edges: `++++` (four rotational),
`+−+−` (two opposite lenses, two anti-lenses), and the mixed `+++−`, `++−−` (one lens, two rotational, one anti-lens). *Reads:* `p`, its tactic centres.

**N3-FLANK [hand, one mind; the simple class].** *At a tactic centre `q` of an edge at `p`, each of the two branches of `ω(p)` leaving `q` lies, near
`q`, on `Γ` or in a tile of colour `c₅` or `c₆`; when both lie in tiles, these are two distinct tiles, one of each absent colour. So `q` is a change
point of `p`'s ring, or an end of a `Γ`-arc of `ω(p)`.* Proof: a tile of a colour of `P_cl(p)` holding an interior point `w ∈ ω(p)` realises distance
1 with the `p`-tile of its colour (radial motion of `w` inside the tile moves the distance through 1) — FS-110's N-E1. The branches curve toward `p`,
into the open half-plane at `q` facing `p`; there `x`'s cone lies (it is in `B̄(p, 1)`), and the partner `z`'s cone lies in the far closed half-plane
(N3-HALF (c); `z ∌ p`, since a second tile of `z`'s colour at `p` would be Siamese with `y`). A single tile holding both branches would be one interval of
directions containing `x`'s cone or `z`'s, or a tile touching itself at `q`. At most one tile per colour sits at `q` (non-Siamese). ∎ *Reads:* `q ∈ F`, `p`.

**N3-PAIR [hand, one mind; FS112-NB4P's mechanism in local form].** *If `y` is an edge point between tiles `U, U′` of colours `c, c′`, and a point `y′`
with `c, c′ ∈ P_cl(y′)` lies at distance 1 from `y`, then the edge through `y` is an arc of `ω(y′)` near `y`.* Proof: both branches of `ω(y′)` at `y` must
avoid the interiors of `U` and `U′` (N-E1 at `y′`; a tile containing `y′` lies in `B̄(y′, 1)` and has no interior point on `ω(y′)`), so both lie on the
edge. ∎ *Reads:* `y, y′`.

**N3-ODD [hand, one mind].** *At a four-colour vertex `p` (non-Siamese), where both `θ` and `θ + 60°` are off `Γ`-arcs of `ω(p)`, the ring's colours
there differ (FS-110's N-E0 with N-E1: two colours only); hence change points are `σ`-invariant where their `σ`-images are off `Γ`-arcs, and every
half-open 60° window of an arc of the ring free of `Γ`-arcs holds an odd number of change points.* ∎ *Reads:* `ω(p)`.

### 2.2 The escaping configuration DR, derived

Take pattern `+−+−` in its most symmetric form: `p = 0`, `a = e^{i60°}`, `b = e^{i120°}`, **`R1 = Reul(0, a, b)` (colour `c₁`) and `R3 = Reul(0, −a, −b)`
(colour `c₃`)**, Reuleaux triangles of width 1; `t₂` (colour `c₂`) in the left lune `L` (cone `[150°, 210°]`, bounded by `R1`'s arc on `ω(a)` and
`R3`'s on `ω(−b)`), `t₄` (colour `c₄`) in the right lune `L′` (cone `[330°, 30°]`). All four edges at `p` are unit arcs: `e₁ ⊂ ω(a)`, `e₂ ⊂ ω(−b)`,
`e₃ ⊂ ω(−a)`, `e₄ ⊂ ω(b)`, each lens inner to two of them. **What four tactic edges force** (each step N3-FACE/-HALF/-FLANK/-PAIR/-ODD at named points):

**(i) Partners.** `e₁` tactic needs a tile `z_a` of colour `c₂` at `a` separated from `R1` there; likewise `z_b` (`c₄`), `z_{−a}` (`c₄`), `z_{−b}` (`c₂`).
N3-HALF (b) at `e₁` puts `c₄ ∉ P_cl(a)` (`t₄` meets the half-plane facing `a`), and so on round the four corners.

**(ii) The corners and the cap.** At `a`, `R1`'s cone is `[150°, 270°]`. The ring branch of `ω(p)` at `a` on the lune side lies in a tile `U_a` of an
absent colour `X` (N3-FLANK), which starts at `270°` (a tile between would have the other absent colour and be Siamese with the lune's ring tile of that
colour, below). Between `z_a` and `R1`'s cap at `150°` sits one more tile: colours `c₄` (N3-HALF) and `X̄` (Siamese, below) are excluded, `c₁, c₂, X` are
taken, so it is **`c₃`** — at `b` the same step forces `c₃`, and the two `c₃` tiles are one, **`T_top`**, spanning the cap `ab` (a `c₃` tile at `a`
reaching the cap points toward `b`, N3-FACE); `T_top ⊂ B̄(a, 1) ∩ B̄(b, 1)` outside `B(p, 1)`. So **the cap arc is tactic** (inner `R1`, centre `p`,
partner `R3`), `R1` is inner to three tactic edges, and **each corner has degree exactly 4**: `a` carries `{c₁, X, c₂, c₃}` in the order `R1, U_a, z_a,
T_top`. (N2-ABS's identity at `R1` reads `3·5 + 3 = 15 + 3`, `u = 0`: consistent.)

**(iii) The lunes' rings.** `R1`'s and `R3`'s caps are `Γ`-arcs of `ω(p)` on `[60°, 120°]` and `[240°, 300°]`; N3-ODD on each lune arc forces change points
`y′ = e^{is′}`, `y″ = e^{i(s′+60°)}` with `s′ ∈ [−60°, 0°]` on the right (and `s, s + 60°`, `s ∈ [120°, 180°]` on the left): ring tiles `U₁ (X)` on
`(−60°, s′)`, `U₂ (X̄)` on `(s′, s′ + 60°)`, `U₃ (X)` on `(s′ + 60°, 60°)`. The tile beyond each tactic arc's end (the continuation's outer tile, inside
`B(p, 1)`, hence of an absent colour) differs in colour from the ring tile at the corner it faces (that tile points toward it, N3-FACE), which fixes the
colours round the lunes: `U_a = U₃` and `U_{−b} = U₁` carry `X`, the left lune's corner tiles at `b, −a` carry `X̄`, its middle tile `X`.

**(iv) N3-DR0 — the degenerate member dies [hand, one mind; tools exact].** Suppose `s′ = 0`: the change points are `y₀′ = 1` and `a` itself, `U₂ = T_D`
spans `(0°, 60°)` and contains `y₀′` and `a`. Then:
1. `T_D ⊂ B̄(y₀′, 1)`, so `T_D`'s cone at `a` ends at `30°` at the latest (within 90° of `a → y₀′`, which is `300°`). The next tile at `a` cannot have colour
   `c₄` (`t₄` points toward `a`) or `A = c(T_C)` (`T_C`, the ring tile on `(−60°, 0°)`, has cone `(180°, 330°)` at `y₀′` and points toward `a`), and a `c₃`
   tile there would leave no colour for a tile between `z_a` and the cap; so **`z_a` follows `T_D` directly and its cone contains the direction `30°`**,
   its boundary there along `ω(y₀′)` (`T_D` inside that disc, `z_a` outside).
2. At `y₀′`, `T_C ⊂ B̄(−b, 1)` ends at `330°` and `T_D ⊂ B̄(a, 1)` starts at `30°`; the wedge `(330°, 30°)` needs a tile whose colour is not `c₁, c₃, c₄`
   (`R1, R3, t₄` all point toward `y₀′`) and not `A, B` (taken at `y₀′`): **`c₂`**, filling the whole wedge.
3. `a − y₀′ = e^{i120°}` is a unit vector orthogonal to `e^{i30°}`. For small `t` and `0 < s < t²/2` the point `z = a + te^{i30°} − se^{i120°}` lies in `z_a`
   (between the tangent ray and `ω(y₀′)`), and `z + (y₀′ − a)` lies in the open wedge `(330°, 30°)` at `y₀′`, outside `B(a, 1)` and `B(−b, 1)` — in the
   `c₂` tile of step 2. Two interior points of colour `c₂` at distance exactly 1. ∎ (A cusp `z_a` at `30°` does not escape: the translate still lands inside
   the wedge.) `tools/fs114_n3_dr.py` checks every metric fact at named values (`data/fs114/fs114-n3/dr.out`, all OK); **plant**: `y₀′` moved to
   `e^{i10°}` fails exactly the five metric identities of the conflict and nothing else (`dr-plant.out`). By the symmetries the same holds for `s′ = −60°`,
   `s = 120°`, `s = 180°`. *Reads:* the disc of radius `1 + ε` about `p` — the corners `a, −b` and the ring point `y₀′`.

**(v) The general member (`s′ ∈ (−60°, 0°)`) passes every check I made.** At `a`: `U₃ ∋ a, y″` with `|a − y″| < 1`, `z_a` after `U₃`, `T_top` after `z_a`
(`T_top ⊂ B̄(b, 1)` puts its cone at `a` in `[90°, 150°]`); no tile at distance exactly 1 from `a` carries `c₂` in a tangent position (the ring point
`y₀′ = σ⁻¹a` is now interior to `U₂`); `ω(a)` meets `t₄` (allowed), the cap and `z_b`'s side at `b` (T_top's boundary at `b` is `ω(a)`); the ring
pattern satisfies N3-ODD; the change points `y′, y″` are edge points with their `U|U` edges along each other's circles (N3-PAIR), `U₂ ⊂ B̄(y′, 1) ∩
B̄(y″, 1)`, `U₁, U₃` facing away. **N3-CONT:** the continuation of `e₄` beyond its end (the edge `R1 | U₃` on `ω(b)`) is non-tactic — its partner would be
a tile of colour `c(U₃) = X` at `b`, and `X` at `b` is Siamese with the left lune's middle tile (`|b − e^{is}| < 1`); likewise at all four arcs. So every
end of a tactic edge at `p` and every Reuleaux corner carries a non-tactic edge. **Not built:** the lune interiors — `t₂, t₄` against the `U`-tiles, with the
rings of the lunes' interior cubic vertices (colours `{c₄, X, X̄}` on the right) forced to lie in `t₂` where they cross the left lune, and conversely.

### 2.3 K1's verdict

**K1: GAP** — a degree-4 vertex with four tactic edges is **not excluded by any structure within radius `1 + ε`** that the lemmas of §2.1 read: DR's general
member passes every check made, while its degenerate member dies (N3-DR0). K1 is therefore not a radius-2 lemma of the kind N2 hoped for unless the
lune interiors fail — a question about a finite, explicit configuration. **Scope:** non-Siamese, simple, no complexity bound; rotational patterns (`++++`,
and `+++` on three edges) and the mixed ones **not walked**. **K1's killing test, stated for the owner to route** (standing rule 12: a route hint, not
sent to the other side by me): *a valid fragment by formula on `B̄(p, 1 + ε)`, better on `B̄(p, 2)`, realising DR with `s′ = −30°`, `s = 150°` — four
tactic edges at `p`, charge `−2`.* If it exists, K1 is FALSE and route T's kill must be joint (stage 3). **Registration** (G21; both outcomes reachable,
by that fragment or by a derived obstruction in a lune interior): I expect such a fragment to exist on `B̄(p, 1 + ε)`, p = 0.7.

**Where FS114-CV's result bears.** DR's `p` is a four-colour vertex; a valid fragment realising DR on `B̄(p, R)` would put C114-LOCAL-F's radius above
`R`. N3-DR0 is the first local obstruction derived here about a four-colour vertex at radius `1 + ε`, and it is narrow: it kills one ring pattern of one
configuration.

## Stage 2 — SAVED

## Stage 3 — SAVED: DR's forced structure continued; the joint form of the kill

### 3.1 N3-DR1 and N3-DR2 — the change points carry the lune's `p`-tile and a corner partner

*Setting: DR's general member (§2.2 (v)), right lune, minimal ring pattern (exactly the change points `y′ = e^{is′}`, `y″ = e^{i(s′+60°)}`,
`s′ ∈ (−60°, 0°)`); `n = y″ − y′` (a unit vector), `τ ⊥ n` the direction `s′ + 30°` (outside the ring at both points), `−τ` inside.*

**N3-DR1 [hand, one mind].** `U₁ ∋ −b, y′` and `U₃ ∋ a, y″` carry one colour `X` and are distinct (a tile holding `a` and `−b` has diameter `√3`), hence far;
N3-FACE puts `U₃`'s cone at `y″` in `{u·n ≥ 0}` and `U₁`'s at `y′` in `{w·n ≤ 0}`. If `y″` were an edge point (`U₂ | U₃` only), N3-PAIR makes that edge an arc of
`ω(y′)`, so `U₃` holds all of the region outside `B(y′, 1)` near `y″`, including both tangent rays `y″ ± tτ`; likewise `U₁` at an edge point `y′` holds
`y′ ± tτ`. Then `y″ + tτ` and `y′ + tτ` (or the `−τ` pair) are interior points of colour `X` at distance `|n| = 1`. So each ray direction must be **blocked** —
covered by another tile — at `y′` or at `y″`. The only tiles that can sit there: **inside the ring**, a tile of a colour of `P(p)` containing the point must
be a tile at `p` (anything else within distance `< 1` of `p` is Siamese with it), and only `t₄` can reach (`R1 ⊂ B̄(b, 1)`, `R3 ⊂ B̄(−a, 1)` miss both points);
**outside**, `c₁, c₃, c₄` are excluded (`R1, R3, t₄` all point toward `y′` and `y″`), the two absent colours are taken, so the tile is `c₂`, and then it is
`z_a` at `y″` (`|a − y″| < 1`) or `z_{−b}` at `y′`. Hence **`t₄` reaches the ring at `y′` or `y″`, and `z_a` reaches `y″` or `z_{−b}` reaches `y′`.** ∎
Three cases: (i) both at `y″`; (ii) both at `y′` (the mirror); (iii) mixed. *Reads:* the disc of radius `1 + ε` about `p`; vertices `p, a, −b` (`F`) and the
change points.

**N3-DR2 [hand, one mind].** In case (i) `y″` is a vertex of degree 4 with tiles `U₂, t₄, U₃, z_a` in that order — **a four-colour vertex `{X̄, c₄, X, c₂}` at
distance 1 from `p`, sharing `t₄` with it** — and its ring carries only `c₁, c₃`. `t₄, U₂, U₃` contain `y″`, so they lie in `B̄(y″, 1)`; `U₁` does not, faces
away from `y″` at `y′`, and is connected, so it lies outside `B(y″, 1)`. The arc of `ω(y″)` inside the right lune runs from `y″ − a` (on `R3`'s arc `ω(−a)`,
between `p` and `−b`) to `y′`, and separates `U₁` from `t₄ ∪ U₂ ∪ U₃`: **it lies in `Γ`**. So the lune is cut by a unit arc centred at a four-colour
vertex, `U₁` on its outer side; the piece of it bordering `t₄` is not tactic (its would-be partner `U₃` is adjacent to `t₄` at `y″`). The rings of `y″` at
`p` fall in `R1` and `R3` (tangents `s′ + 150°`, `s′ − 30°`, strictly inside their cones for `s′ < 0`), as they must. ∎ *Reads:* as N3-DR1, and `y″ ∈ F`.

**What this says about DR.** Four tactic edges at one vertex propagate: the lune's `p`-tile must reach the ring (diameter 1 realised toward a change
point), a corner partner must reach the same or the twin change point, and in case (i) a new four-colour vertex appears on `p`'s ring whose own unit
circle is forced into `Γ` across the lune. Every step is local (radius `1 + ε`) and none has yet produced a contradiction beyond N3-DR0's member. **The
next steps, not taken:** cases (ii), (iii); the left lune; whether `y″`'s own tactic edges (it is a degree-4 four-colour vertex) make it deficient too.

### 3.2 The joint form of the kill (K1 is not available)

**N3-JOINT [hand; N2-SLACK restated].** On a non-Siamese simple torus map, N2-SLACK reads `N + U + 3V₆ = V₄`, `N` the non-tactic edges. So the NO follows
from any **fractional assignment** in which every degree-4 vertex receives two units, each unit being half of a non-tactic edge (one of its own ends, or a
**free** end — an end at a vertex of degree 3 or 5, or beyond the first two at a degree-4 vertex), a unit of `U`, or one of six units per degree-6 vertex,
every source used at most once, **and some source left unused in every disc of radius `R₀`**. K1 ∧ K2-loc is the special case where every degree-4 vertex
uses its own ends only. Stated this way the kill is local and joint: it asks where the non-tactic ends near a deficient vertex are, not whether it has them.

**N3-PAY [hand, one mind].** A DR vertex takes `½` from the continuation end at each of its four tactic ends `p′_i` (non-tactic by N3-CONT). At a cubic
`p′_i` the continuation end is free, and at most two deficient vertices can claim it (the cubic `p′_i`'s other two edges are its tactic edge from `p` and
one more), so its capacity 1 is never exceeded. **Not covered:** a `p′_i` of degree 4 or 5; the rotational and mixed patterns and non-Reuleaux lenses
(**K1′**: the deficient configurations other than DR, with their local payment); and the unused unit (**K2′**: strictness), where N3-DR1/-DR2's forced
structure is the first handle (each non-tactic edge it forces — the `ω(y″)` arc's pieces, the continuations — is a candidate unused source).

**Verdicts of this stage.** K2-loc as stated ("under K1") is **moot** while K1 is a GAP with a live escape; its content moves into N3-JOINT's leftover
clause (K2′). Route T's kill is **GAP at K1′ ∧ K2′ ∧ GAP-μ** for the non-Siamese class; DR is paid for (N3-PAY) but not yet shown to leave a surplus.

## Stage 3 — SAVED

## Stage 4 — SAVED: GAP-μ and the Siamese class, after FS114-CV and FS114-CVB

**GAP-μ (brief step 3).** What the count needs is the tile identity (N2-ABS) with repeated contacts: a tile `z` meeting `x` twice lies in no (A) or (B) slot
as N114-RD defines them ("touching `x` at `q` alone"). Derived here, for the record only: in the non-Siamese class a pocket (the region enclosed by two
tiles meeting twice) lies in the convex hull of their union, of diameter `≤ 2`, hence in a disc of radius `2/√3` (Jung), so by N2-GROW's packing it meets at
most `⌊6(4/√3 + 1)²⌋ = 65` tiles, and a hole at most five (N2-MU). No payment rule for `μ` is derived: **GAP-μ stands as stated**. With CV-EXISTS it matters only to route T.

**SIAM-KILL (brief step 4).** FS114-CV and FS114-CVB (two minds, blind to each other) give CV-EXISTS for every valid map, Siamese or not, so **C114-LOCAL-F
alone is the unit-arc NO**; the Siamese class needs no count and no separate kill — it needs C114-LOCAL-F's radius. What an argument there must read (the
brief's question), given N2-REFINE: any count over tiles is blind in the Siamese class (tile density is unbounded), so a Siamese kill must read **points
and distances, not tiles** — a local exclusion about a four-colour vertex whose steps cite distances between points of colour classes (as N3-DR0 does), and
never a tile count. FS112-N3-DENSE3's `R` half is subsumed. Not worked further.

**Where the two routes now stand (a reading, one mind).** Route T reaches only the non-Siamese simple class and stops at K1′ ∧ K2′ ∧ GAP-μ; the local route
reaches every valid map and stops at C114-LOCAL-F's radius. They meet at the vertex type this job studied: **every step of §§2–3 is already a
C114-LOCAL-F step** (it reads radius `1 + ε` about a four-colour vertex and cites only distances), and N3-DR0 is the first derived local exclusion of a
four-colour configuration. *Killing test of the reading:* a derivation of K1′ ∧ K2′ that uses a step no local exclusion about a four-colour vertex could use
(a global average).

## Stage 4 — SAVED
