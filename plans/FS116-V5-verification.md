# FS116-V5 — a blind second mind on eight statements of FS-116's list (§§ 12–14)

*Job FS116-V5 (Ephodos, verification form; blind, the same model as the minds whose work it may later compare against, Opus 5.5).
Brief: `data/fs116/briefs/FS116-V5-verify.md`, with `plans/STANDING-RULES.md`. Started 2026-10-03 15:37 UTC.*

## Theorems this phase proved

*(Filled stage by stage; each line a statement, its grade and its address.)*

- Stage 1: V5-NE1 (a tile lies in the open unit disc about each point of its closure) — hand; known (N-E1) — § 1.4.
- Stage 2: V5-RING, V5-GERM, V5-OUT, V5-TIPSET — hand, one mind each, prior art partly in FS-114's held statements — §§ 2.1; V5-LENS (each lens beside a
  single tip forces its double-tip hub's tip tight at `p`, so at radius √3 the star is `(90°, 150°, 270°, −30°)`) — hand, one mind, novelty owed — § 2.5;
  FS116-Y3-SIX, -TIPS, -NBTIP, -TIGHTLENS, -STARFORCE: TRUE, hand, § 2.8 (SIX and TIGHTLENS thin truths; NBTIP's first two clauses a checking reading).
- Stage 3: V5-QCOL, V5-U1 (known: FS112-U1), V5-OUT2, V5-DICHO (the crossed-or-parallel dichotomy, every degree) — hand, one mind each — § 3.1;
  FS116-N3-SEMI and -PAIR: TRUE, hand (PAIR a thin truth); FS116-N3-CROSS: GAP at its last clause, every other clause TRUE — § 3.6.

## "Would have searched here" log

*(The ban ran to 2026-10-01 and the standing rules still carry it; this job runs no search in any case: every check is a hand derivation or an
exact computation at named points.)*

- Stage 2: none — no move of this stage would have been a search; the controls are exact identities at named values.
- Stage 3: none.

## Fence log

- No fenced path opened. Read, all open to me: the brief; `plans/STANDING-RULES.md`; `data/fs116/claims.md` (whole); `data/fs114/claims.md`
  (whole); `plans/FS114-derivation.md` lines 1–23 and 411–770 (the header and § 3's entries, statements and their fields only; no
  `argument:` target opened); `plans/FS112-derivation.md` lines 1–30 and a grep for `U1`; a grep of `plans/FS112-N-proof.md` for N-E0–N-E2
  (lines 6–7, 75, 88, 93, 158–159, 168, 172, 187 printed — FS-112's own record, open by the brief); the gate script's docstring.

## Stage 1 — SAVED

### 1.1 Readback

The brief's eight quotations were checked mechanically against `data/fs116/claims.md` (a script comparing each quoted line, character for
character, with the list's line of the same name): **all eight match verbatim** (SIX, TIPS in § 14; NBTIP, TIGHTLENS, STARFORCE in § 12; SEMI,
PAIR, CROSS in § 13). No mismatch to report.

The statements, restated in my own words (the quotations themselves are in the `verification:` blocks of stages 2–3, verbatim):

- **SIX.** Six colours, non-Siamese, simple, fragment on a closed disc of radius > 1 about a vertex `p` with ≥ 4 colours, `Γ ∩ ω(p)` containing
  no arc. Then: the ring has six change points and no more, spaced 60°; each is a hub (no germ on a (Q) arc); `p` lies in the closure of exactly
  four tiles.
- **TIPS.** Same setting, hubs placed at `e(60k)`. Each hub lies in the closure of exactly one tile of `p`; antipodal hubs' tips are opposite at
  `p`; up to relabelling, the four tiles ccw are `T1` (tips `y_0`, `y_1`, cone at `p` inside `[−30°, 90°]`), `T3` (tips `y_2`, inside
  `[30°, 210°]`), `T2` (tips `y_3`, `y_4`, inside `[150°, 270°]`), `T4` (tips `y_5`, inside `[210°, 30°]`).
- **NBTIP.** In TIPS's setting: each hub's tip has points in `B(y_{k±1}, 1)`; hence no hub has an outer tile of a neighbour's tip colour; `y_2`'s
  outer colours are exactly `{4}`, `y_5`'s exactly `{3}`.
- **TIGHTLENS.** Radius ≥ √3, TIPS labels. Four disjunctions on the edge directions `δ_i`, one per lens `L_1, L_2, L_4, L_5`; the gloss: for each
  such lens one of its two hubs has its tip tight at `p`; so ≥ 2 edges of `p` lie along flanking directions of hubs, and the star is never generic.
- **STARFORCE.** Radius ≥ √3, TIPS labels. The edges are exactly `(90°, 150°, 270°, −30°)`; named outer colours at `y_0, y_1, y_3, y_4` with
  "alone or two outer tiles" in a named ccw order; colours of "the lens points" near `q_1, q_5` (2) and `q_2, q_4` (1).
- **SEMI.** Non-Siamese simple fragment, radius > 1, `p` ≥ 4 colours (rings may carry (Q) arcs). At a semi-hub `y = r(ψ)`: `y` has ≥ 4 colours; or
  exactly three, with an edge at `y` a unit arc about `r(ψ ± 60°)` whose two side colours are carried at that centre, the centre then a ≥ 4-colour
  vertex; or `y` is a full parallel semi-hub with exactly three colours, named (the two absent at `p` and one tip/edge colour by kind).
- **PAIR.** If both germs of one pair at a change point lie on (Q) arcs with the same colour pair, the arcs are oppositely oriented (inner of
  one = outer of the other).
- **CROSS.** Radius > 2. A crossed full semi-hub of kind O: every tile of `p` at `y` has a zero-angle cone at `y`; the outer colours at `y` lie in
  `{a′, b′}`; and with four colours and positive cones at `y`, a further structure of `y`'s own ring at `p`.

Readings I adopt now, before deriving (each checked again where it bites):
- **(R-QARC)** A germ is an arc of `ω(p)`; an arc of `Γ` containing a sub-arc of `ω(p)` lies on `ω(p)`, so "a germ lies on a (Q) arc" means
  a (Q) arc **centred at `p`** contains that germ. Every (Q) arc of § 13 is then a unit arc of `ω(p)` whose two side colours are carried at `p`.
- **(R-CHG)** "Change point" is reading L: a point of `Γ ∩ ω(p)` with the ring off `Γ` on both sides near it and the colours differing.
- **(R-TIP)** A tile "tips" a hub when it is a tip at that hub (§ 13's: a tile of `p` whose closure holds it).
- **(R-OUT)** "Outer colour of a hub": the colour of an outer tile at it, outer tile = a tile of a colour of `p` that is not a tile of `p`, whose
  closure holds the hub (§ 14's note: § 13's `O_y`).
- **(R-LENSPT)** and **(R-ORDER)** for STARFORCE's two undefined phrases: stated at stage 2, before STARFORCE's verdict.

### 1.2 What I was given

The brief (the eight statements; that other minds worked them; the ask to attack the statement; the hint that hand derivations here fail by
over-claiming; the order of work); `data/fs116/claims.md` in full — including § 14's setting passages, which **restate conclusions of SIX and
TIPS as labels** (the hubs at `e(60k)`, the ring's colours `X` on `(0°, 60°)`, `(120°, 180°)`, `(240°, 300°)`, the tiles' roles, colours `1, 3, 2, 4`
and the `δ` ranges), the definitions of tight lens, generic star and "tight at `p`" (with the claim about which values are such edges cut), and
§§ 10–12's other statements (RING-GERM, RING-TWIST-C, GERM-R, GERM-S, TOUCH, S1-KAPPA, S1-RUNG, S1-QF) — and § 8's FS114-N7-3T, whose statement
carries **N7-HUB's sketch** ("the directions toward `p` there lie in tiles of `p` reaching `y_k`, a tip, which meets `B(y_{k−1},1) ∩
B(y_{k+1},1)`, so its colour is carried at `y_{k±1}` by no other tile …"); `data/fs114/claims.md` in full; `plans/FS114-derivation.md` § 3's entry
statements (N3-LOCAL's lemmas, N6-RING60, N6-CENT, N7-QOPP, N7-FLANK, N7-CHAIN, the bowtie entries) — routes in outline only, no argument
opened; `CLAUDE.md` and the grokkings (G83–G86 among them). I knew nothing of FS-116's records before this job. The expectations below were
written **after** reading all of this and thinking about the statements for some minutes: they are informed, not naive.

### 1.3 Registered expectations (before any derivation)

| statement | expected verdict | p | likeliest break |
|---|---|---|---|
| SIX | derived (TRUE) | 0.85 | the count "exactly six": a window holding three colour changes must be killed, and non-Siamese is the only lever |
| TIPS | derived (TRUE) | 0.55 | "each hub has exactly one tip": two tips of one hub sharing an edge from `p` to the hub may survive; or a closed-range endpoint |
| NBTIP | derived (TRUE) | 0.6 | the tip reaching into the neighbour's open disc when its cone at the hub is extreme (a tangency) |
| TIGHTLENS | derived (TRUE) | 0.4 | the lens argument at exactly √3 (the far vertex `q_k` on the disc's boundary), or a disjunct that is not forced |
| STARFORCE | derived (TRUE) | 0.3 | (Q1)–(Q5) also admit other boundary stars (e.g. `δ_1 = 30°, δ_3 = 210°`); STARFORCE must kill each, and its outer-tile order rides on an undefined phrase |
| SEMI | derived (TRUE) | 0.45 | the second alternative's "which is then a vertex of at least four colours", or the kind-O/kind-T colour in the third |
| PAIR | derived (TRUE) | 0.8 | that the inner tile of a (Q) arc on `ω(p)` is `p`'s own tile needs non-Siamese; if it were not, two inner tiles of one colour could be distinct |
| CROSS | derived (TRUE) | 0.35 | the clause "every tile of `p` at `y` has a cone of zero angle", or the description of `y`'s ring at `p` |

### 1.4 Tool lemmas (no statement of the list is touched)

derivation: V5-NE1
  statement: in a valid k-coloured fragment, for any k, Siamese pairs allowed, if a point x lies in the closure of a tile of colour c, then no point z interior to a tile of colour c has |z − x| = 1; in particular every tile T lies in B(x, 1) for every x in cl T, so cl T lies in B̄(x, 1) and T has diameter at most 1
  uses only: tiles open and connected; validity (no two interior points of one colour at distance exactly 1)
  not claimed: that T lies in the open disc B(x, 1) when x is a closure point of another tile of T's colour (only that z ∉ ω(x)); anything about points of Γ
  argument: § V5-NE1's argument
  verdict: derived
  grade: hand
  minds: 1
  model: any tile of the hexagonal seven-colouring (k = 7), cells of diameter below 1
  prior art: known — N-E1 of `plans/FS112-N-proof.md` § 1.3 ("ω(u) meets no tile of a colour of P_cl(u)"), re-derived here
  handoff: none — a relay-result for the stages that follow

#### V5-NE1's argument

Let `x ∈ cl S`, `S` a tile of colour `c`, and `z ∈ T`, `T` a tile of colour `c`, with `|z − x| = 1`. `T` is open: a disc `B(z, ε) ⊂ T`.
Choose `s ∈ S` with `|s − x| < ε` (`x ∈ cl S`). Then `z′ = z + (s − x) ∈ B(z, ε) ⊂ T` and `|z′ − s| = |z − x| = 1`: two interior points of colour
`c` at distance exactly 1, against validity. For the second clause take `S = T`: for `x ∈ cl T` the continuous function `w ↦ |w − x|` on the
connected set `T` never takes the value 1 and takes values below 1 (points of `T` near `x`), so it is below 1 on all of `T`.

## Stage 2 — SAVED

*The first group: SIX, TIPS, NBTIP, TIGHTLENS, STARFORCE. Derived from the statements, § 0's definitions and § 14's setting words alone;
no record of FS-116 opened. `p` is the origin, `e(θ)` the unit vector at angle `θ`, `r(θ) = e(θ)`, angles in degrees, ccw positive.*

### 2.0 Readings fixed before the verdicts

- **(R-LENSPT)** STARFORCE's "near `q_k` the lens points carry colour `c`": every point of the lens `L_k` close enough to its far vertex `q_k`
  lies in a tile of colour `c` or on `Γ`. (The alternative reading, "the points `q_k`", is not a reading of "lens points"; I give no verdict under
  it.)
- **(R-ORDER)** "counter-clockwise 2, 3 at `y_0`": turning counter-clockwise about `y_0` through its outer tiles, from the ring tile on the
  clockwise side of `y_0` toward the one on the counter-clockwise side, the tile of colour 2 comes first and the tile of colour 3 second.
  Under the reverse reading (3 first) the order clause is FALSE at all four hubs; I report both.
- **Hub tiles.** At a ring point `y = r(ψ)` I write `X₊` for the ring colour just counter-clockwise of `y` and `X₋` for the one just clockwise.

### 2.1 Common lemmas

derivation: V5-RING
  statement: at a point p of a valid six-coloured fragment on a closed disc of radius above 1 about p, non-Siamese, with at least four colours at p and Γ ∩ ω(p) containing no arc: Γ ∩ ω(p) is finite; every point of ω(p) off Γ is interior to a tile of one of the colours absent at p; p has exactly four colours, so exactly two are absent, X and X̄; the ring colour c satisfies c(θ + 60°) ≠ c(θ) off Γ; every tile T meeting ω(p) at r(θ₀) meets it only inside the open arc (θ₀ − 60°, θ₀ + 60°); two ring points off Γ of one colour less than 60° apart lie in one tile; and the change points are exactly y + 60°ℤ for one ring point y
  uses only: V5-NE1; the non-Siamese hypothesis (for "one tile"); six colours (for "exactly two absent"); a locally finite union of segments and circular arcs not containing an arc of ω(p) meets ω(p) in finitely many points
  not claimed: anything with Siamese pairs (the step "one tile" fails there); anything at k ≥ 7; that the ring tile over an arc between consecutive change points touches no other ring point
  argument: § V5-RING's argument
  verdict: derived
  grade: hand
  minds: 1
  model: none held — no fragment of the class is known, and the class may be empty (the list's preamble: a statement about a possible object)
  prior art: partly: FS114-N6-NOQ's N6-RING60 (`plans/FS114-derivation.md` § 3, "a four-colour vertex whose ring carries no (Q) arc has ring change points exactly y + 60°ℤ"), stated there, not read here as an argument
  handoff: none — a relay-result for SIX and everything after it

#### V5-RING's argument

1. *Finite.* In a neighbourhood of the compact ring, `Γ` is finitely many segments and circular arcs; one that is not an arc of `ω(p)` meets
   `ω(p)` in at most two points.
2. *Absent colours.* A ring point `z` off `Γ` is interior to a tile; if its colour `c` were carried at `p`, V5-NE1 (with `x = p`) is violated,
   since `|z − p| = 1`.
3. *Four colours.* Choose `θ` with `r(θ)` and `r(θ + 60°)` both off `Γ` (all but finitely many `θ`): they are interior points at distance
   exactly 1, so of different colours, both absent at `p`. So at least two colours are absent; with six colours and at least four at `p`,
   exactly four are carried and two, `X, X̄`, are absent, and `c(θ + 60°) = c(θ)′` (the other one).
4. *Short arcs.* If `r(θ₀) ∈ T`, V5-NE1 (with `x = r(θ₀) ∈ cl T`) puts `T ⊂ B(r(θ₀), 1)`, and `|r(θ) − r(θ₀)| < 1` iff `|θ − θ₀| < 60°`.
5. *One tile.* Two ring points of one colour at angular distance below 60° are interior points at distance below 1; non-Siamese tiles of one
   colour have all cross-distances at least 1, so they are one tile.
6. *Six change points.* The change points (reading L) are the points where `c` changes; the set `K` is finite and `K + 60° = K` (step 3). In a
   half-open window `[θ, θ + 60°)` the colour at the window's end is the other colour, so the window holds an odd number of changes. Suppose
   one holds `m ≥ 3`, `κ₁ < … < κ_m`, so `κ_m − κ₁ < 60°` and the next change after `κ_m` is `κ₁ + 60°`. With `B` the colour on `(κ₁, κ₂)`, the
   arcs alternate, `(κ_{m−1}, κ_m)` has colour `B′` (`m − 1` even) and `J = (κ_m, κ₁ + 60°)` has colour `B`; by step 3 the arc
   `(κ_{m−1} − 60°, κ_m − 60°)` has colour `B`. By step 5 the points `κ_m − 60° − ε`, `κ₁ + ε`, `κ₂ − ε`, `κ_m + ε`, `κ₁ + 60° − ε` of colour
   `B` lie in one tile `T_B` (consecutive gaps `κ₁ − κ_m + 60° + 2ε`, then within `(κ₁, κ₂)`, `κ_m − κ₂ + 2ε`, then within `J`, all below 60°).
   But `κ₁ + 60° − ε` and `κ_m − 60° − ε` differ by `κ₁ − κ_m + 120° > 60°`, against step 4. So every window holds exactly one change point,
   and `K = y + 60°ℤ`.

derivation: V5-GERM
  statement: in V5-RING's setting, let y = r(ψ) be a change point, X₊ the ring colour just counter-clockwise of y and X₋ the one just clockwise; for β − ψ in each open interval below, every point y + t e(β′) with t > 0 small and β′ near β that is off Γ lies in a tile of the colours named: (−30°, 30°) a colour of p, on a tile that is not a tile of p (an outer tile); (30°, 90°) X₊ or an outer tile; (90°, 150°) X₊ or a tile of p; (150°, 210°) a tile of p; (210°, 270°) X₋ or a tile of p; (270°, 330°) X₋ or an outer tile; at y there is exactly one tile of colour X₊, the ring tile R₊ over the ring arc counter-clockwise of y, and one of X₋, R₋; so y is a vertex whose tiles, counter-clockwise, are outer tiles (covering ψ + (−30°, 30°)), R₊ (containing ψ + 90°), tiles of p (covering ψ + (150°, 210°)), R₋ (containing ψ + 270°), no tile colour being both a tip colour and an outer colour
  uses only: V5-RING, V5-NE1, non-Siamese; the first-order motion of the two points of ω(z) ∩ ω(p) (control `germ-first-order`)
  not claimed: anything at the six boundary directions ψ + 30°k (second order decides there); anything when a germ lies on Γ
  argument: § V5-GERM's argument
  verdict: derived
  grade: hand
  minds: 1
  model: none held — V5-RING's class is not known to be non-empty
  prior art: partly: RING-GERM (i)–(iii) (data/fs116/claims.md § 10) states the tip and outer cones; re-derived here with the four other intervals
  handoff: none — a relay-result for TIPS onward

#### V5-GERM's argument

For `z = y + t e(β)`, `y = e(0)` (rotate), write `z = ρ e(φ)`; `ω(z) ∩ ω(p) = {e(φ ± arccos(ρ/2))}`, and at first order in `t` the upper
point is at `60° + t·(2/√3) sin(β − 30°)` and the lower at `−60° + t·(2/√3) sin(β + 30°)` (radians in `t`; exact symbolic check,
`germ-first-order`), while `ρ = 1 + t cos β + O(t²)`. Where both coefficients are non-zero the two points lie, for small `t`, on the four germs:
upper on `u⁺` (`sin(β − 30°) > 0`) or `u⁻`, lower on `v⁺` (`sin(β + 30°) > 0`) or `v⁻`. By V5-RING step 3 the germs carry `u⁻, v⁻: X₊` and
`u⁺, v⁺: X₋` (colour at `θ ± 60°` is the other colour), and they are off `Γ` (finite), so they are interior ring points. A point `z` off `Γ`
of colour `c` at distance exactly 1 from an interior point of colour `c` violates validity. Reading the signs: `β ∈ (−30°, 30°)`: `u⁻, v⁺`, so
`c ∉ {X₊, X₋}`; `(30°, 90°)`: `u⁺, v⁺`, `c ≠ X₋`; `(90°, 150°)`: `u⁺, v⁺`; `(150°, 210°)`: `u⁺, v⁻`, `c ∉ {X₊, X₋}`; `(210°, 270°)`: `u⁻, v⁻`,
`c ≠ X₊`; `(270°, 330°)`: `u⁻, v⁻`. And `ρ < 1` iff `cos β < 0`, i.e. on `(90°, 270°)`. A point of colour `c ∈ P` with `ρ < 1` lies within
distance below 1 of `p`'s `c`-tile (which has points near `p`), so by non-Siamese it is in that tile; with `ρ > 1` its tile is not a tile of `p`,
since V5-NE1 puts every tile of `p` inside `B(p, 1)`. The colour `X₊` at `y` is carried by the ring tile `R₊` (it holds the ring arc just
counter-clockwise, which reaches `y` along direction `90°⁺`), and non-Siamese allows one tile of each colour at `y`; the same for `X₋`.
Tiles are sectors at the vertex `y` (local finiteness), each tile one sector (simple), so the cyclic order is as stated, and a colour carried
by a tile of `p` at `y` and by an outer tile at `y` would be two tiles of one colour at one point.

derivation: V5-OUT
  statement: in V5-RING's setting, let y = r(ψ) be a ring point and O a tile of colour c ∈ P, not a tile of p, with points y + s e(γ) for arbitrarily small s > 0 along a direction γ with cos(γ − ψ) > 0; then the cone at p of p's tile of colour c lies in the closed half-plane of directions [ψ + 90°, ψ + 270°]
  uses only: validity; tiles open and connected; the expansion |e(ψ) + s e(γ) − s′ e(δ)|² = 1 + 2s cos(γ − ψ) − 2s′ cos(δ − ψ) + O(s² + s′²) (control `out-expansion`)
  not claimed: anything about the boundary directions ψ ± 90° of that cone (second order); anything when cos(γ − ψ) ≤ 0
  argument: § V5-OUT's argument
  verdict: derived
  grade: hand
  minds: 1
  model: none held — V5-RING's class is not known to be non-empty
  prior art: partly: FS114-N7-QOPP's N7-FLANK (data/fs116/claims.md § 8 and plans/FS114-derivation.md § 3: "A tile of p with cone [a, b] puts its colour at no ring point in (a ∓ 90°, b ∓ 90°)") is the same shadow read at the ring
  handoff: none — a relay-result for NBTIP, TIGHTLENS and STARFORCE

#### V5-OUT's argument

Suppose `p`'s `c`-tile `S` has a direction `δ` in its cone with `cos(δ − ψ) > 0` in the interior of the cone (an open condition, so any cone
meeting the open half-plane `(ψ − 90°, ψ + 90°)` in more than a boundary point has one; a cusp in that half-plane is handled the same way along
its curve). Then `S ⊃ {p + s′e(δ′) : 0 < s′ < r}` for `δ′` near `δ`. Fix `z = y + s e(γ) ∈ O` with `s` small; along `w(s′) = p + s′e(δ)`,
`|z − w(s′)|² → 1 + 2s cos(γ − ψ) + s² > 1` as `s′ → 0`, and at `s′ = 2s cos(γ − ψ)/cos(δ − ψ)` (inside `S` for `s` small) it is
`1 − 2s cos(γ − ψ) + O(s²) < 1`. By continuity some `w ∈ S` has `|z − w| = 1`: two interior points of colour `c` at distance exactly 1.

derivation: V5-TIPSET
  statement: in V5-RING's setting with the change points at y_k = e(60°k), let a tile T of p be a tip at y_k (y_k ∈ cl T); then cl T lies in B̄(y_k, 1) ∩ B̄(p, 1), its cone at p lies in [60°k − 90°, 60°k + 90°] and its cone at y_k in [60°k + 90°, 60°k + 270°]; T is a tip at no hub other than y_{k±1}, and at y_k and y_{k+1} only if its cone at p lies in [60°k − 30°, 60°k + 90°]; a tip at y_k and a tip at y_{k+3} have closures meeting only at p
  uses only: V5-NE1; |y_k − y_{k+2}| = √3, |y_k − y_{k+3}| = 2 (control `hub-distances`)
  not claimed: that every hub has a tip (that is V5-GERM's (150°, 210°) clause); anything about tiles of p tipping no hub
  argument: § V5-TIPSET's argument
  verdict: derived
  grade: hand
  minds: 1
  model: none held — V5-RING's class is not known to be non-empty
  prior art: partly: FS114-N3-LOCAL's N3-FACE ("one tile at both lies in B̄(u,1) ∩ B̄(w,1)", plans/FS114-derivation.md § 3), the same step
  handoff: none — a relay-result for TIPS

#### V5-TIPSET's argument

V5-NE1 with `x = y_k` and `x = p` gives `T ⊂ B(y_k, 1) ∩ B(p, 1)`. The directions along which an open subset of an open unit disc
approaches a point of the disc's boundary circle lie in the closed half-plane facing the centre: at `p` facing `y_k` (`[60°k ± 90°]`), at `y_k`
facing `p`. If `y_j ∈ cl T` too, `|y_j − y_k| ≤ 1`, so `j = k ± 1`; then the cone lies in both half-planes, `[60°k − 90°, 60°k + 90°] ∩
[60°k − 30°, 60°k + 150°]`. Finally `B̄(y_k, 1) ∩ B̄(−y_k, 1) = {p}` (equality in the triangle inequality `|2y_k| ≤ 2`).

### 2.2 SIX — derivation

V5-RING gives everything but the hubs and the tiles: `Γ ∩ ω(p)` is finite, so no germ lies on any arc of `Γ`, a fortiori on no (Q) arc, and
every change point is a hub; `p` has exactly four colours and, non-Siamese, at most one tile of each colour at `p`, so exactly four tiles.
**The hypothesis "simple" is never used** (a thin truth, § Attack on FS116-Y3-SIX). Six colours enter once, at V5-RING step 3; non-Siamese
at steps 5 and at the count of tiles.

### 2.3 TIPS — derivation

1. *Every hub has a tip.* V5-GERM's `(150°, 210°)` clause: the directions toward `p` at `y_k` lie in tiles of `p`.
2. *Exactly one.* Let `T ≠ T′` be tips at `y_0`, and `S` a tip at `y_3` (step 1). By V5-TIPSET `cl S ∩ cl T = cl S ∩ cl T′ = {p}`, and `S ≠ T,
   T′`. The four tiles of `p` (SIX) are four sectors at `p` (simple: one closed interval of directions each), and two cyclically consecutive
   sectors share the edge between them, so their closures meet in more than `p`. So `S` is consecutive with neither `T` nor `T′`; but of the
   three other sectors of a 4-cycle exactly one is not consecutive with `S`. So `T = T′`. Each hub has one tip `τ(k)`, and `τ(k)`, `τ(k + 3)`
   are the opposite tiles of `p` (non-consecutive, distinct).
3. *The pattern.* Each tile tips at most two hubs, and two only if consecutive (V5-TIPSET). Call `τ(0) = A`, `τ(3) = C` (opposite). If
   `τ(1) = A` then `τ(4) = C`, and `τ(2) ∉ {A, C}` (each would tip three hubs), so `τ(2)` and `τ(5)` are the other two tiles: the pattern
   `{y_0, y_1}, {y_2}, {y_3, y_4}, {y_5}`. If `τ(1) ≠ A`, it is one of the two tiles `B, D` consecutive with `A` (not `C`: `y_1`, `y_3` are not
   consecutive), say `B`, with `τ(4) = D`; then `τ(2) = B` (giving `{y_0}, {y_1, y_2}, {y_3}, {y_4, y_5}`) or `τ(2) = C` (giving `{y_5, y_0}, {y_1},
   {y_2, y_3}, {y_4}`); `A` or `D` at `y_2` would tip non-consecutive hubs. Both are the first pattern rotated by `±60°`. So, rotating the labels,
   the tiles are `T1` tipping `y_0, y_1`, `T3` tipping `y_2`, `T2` tipping `y_3, y_4`, `T4` tipping `y_5`, with `X` the ring colour on `(0°, 60°)`.
4. *Ranges and order.* V5-TIPSET gives the cones at `p`: `T1 ⊂ [−30°, 90°]`, `T3 ⊂ [30°, 210°]`, `T2 ⊂ [150°, 270°]`, `T4 ⊂ [210°, 30°]`. The
   counter-clockwise order must be `T1, T3, T2, T4`: in the order `T1, T4, T2, T3` the sector after `T1` would start at a direction at most
   `90°`, so `T4`'s cone would end at most at `30°`, and `T2`'s would start there, below `150°`.

### 2.4 NBTIP — derivation

The tip `τ(k)` covers the inner directions `60°k + (150°, 210°)` at `y_k` (V5-GERM), and for `β` there `|y_k + t e(β) − y_{k±1}|² =
1 − 2t cos(β − arg(y_{k±1} − y_k)) + t²`, with `y_{k±1} − y_k = e(60°k ± 120°)`, so the angle is in `(30°, 90°)` for `y_{k+1}` and in `(−90°, −30°)` for `y_{k−1}` and the cosine is positive: the tip has points in `B(y_{k±1}, 1)`.
An outer tile at `y_{k±1}` of the tip's colour has points within distance below 1 of those points, so by non-Siamese it would be the tip
itself, a tile of `p`, which an outer tile is not. So the outer colours of `y_2` avoid its own tip's colour 3 (V5-GERM's last clause) and the
neighbours' tip colours 1 (`y_1`) and 2 (`y_3`), and they are not empty (V5-GERM's `(−30°, 30°)` clause): they are exactly `{4}`. The same at
`y_5`: not 4 (own), 2 (`y_4`), 1 (`y_0`), so `{3}`.

### 2.5 The lens lemma

derivation: V5-LENS
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius at least √3 about a vertex p of at least four colours whose ring carries no arc of Γ, labelled as FS116-Y3-TIPS, at the lens L_1 (hubs y_1, y_2, far vertex q_1 = √3 e(90°)): (a) every interior point of L_1 off Γ has colour X̄, 2 or 4; (b) no tile of colour X̄ has q_1 in its closure, and no tile of colour 4 with points in L_1 does; (c) every point of L_1 near q_1 lies in one tile Z of colour 2 or on Γ; (d) y_1 carries an outer tile of colour 4, its outer colours are 4 alone or 4 and 2, and in the second case the 2-tile is Z and comes after the 4-tile counter-clockwise from the ring tile R_{0,1}; (e) δ_4 = −30°; and, by the reflection in the line at 30° and the half-turn, the same at L_5 (δ_1 = 90°, Z of colour 2 at q_5, y_0's outer colours 3 alone or 2 then 3), at L_4 (δ_2 = 150°, colour 1 at q_4, y_4's outer colours 3 alone or 3 then 1) and at L_2 (δ_3 = 270°, colour 1 at q_2, y_3's outer colours 4 alone or 1 then 4)
  uses only: V5-NE1, V5-RING, V5-GERM, V5-OUT, V5-TIPSET, FS116-Y3-TIPS and -NBTIP as derived here (§§ 2.3–2.4); radius √3 (only to have a neighbourhood of q_k); the exact facts of controls `hub-distances` and `astar-arc`
  not claimed: that any fragment of the class exists; anything below radius √3; anything in the Siamese or non-simple class; anything at k ≥ 7
  argument: § V5-LENS's argument
  verdict: derived
  grade: hand
  minds: 1
  model: none held — the class is not known to be non-empty, at any radius (FS116-Y3-STARFORCE's own not-claimed line)
  prior art: owed — no search run; the statement is in the vocabulary of this project's records only
  handoff: Keryx — V5-LENS proves more than FS116-Y3-TIGHTLENS states (each lens forces its first disjunct); the divergence table at stage 4 compares routes

#### V5-LENS's argument

1. *(a)* Let `z` be interior to `L_1`: `|z − y_1| < 1`, `|z − y_2| < 1`, `|z| > 1`. Since `z ∈ B(y_j, 1)` iff `|z| < 2 cos(arg z − 60°j)`, `|z| > 1`
   puts `arg z = φ` in `(0°, 120°) ∩ (60°, 180°)`. The ring points inside `B(z, 1)` are the open arc `(φ − α, φ + α)`, `α = arccos(|z|/2) < 60°`;
   it holds `y_1` and `y_2`, so `φ − α ∈ (0°, 60°)` and `φ + α ∈ (120°, 180°)`: both points of `ω(z) ∩ ω(p)` lie on arcs of colour `X`. A tile is
   open, so for `z` in a tile we may move `z` within it to put both points off `Γ`; so `z`'s colour is not `X`. The tips `T1` at `y_1` and `T3` at
   `y_2` have points within distance below 1 of `z` (they have points arbitrarily near their hubs); a tile of colour 1 or 3 at `z` would be that
   tip (non-Siamese), a tile of `p`, inside `B(p, 1)`, against `|z| > 1`. Left: `X̄, 2, 4`.
2. *(b), `X̄`.* `A* = ω(q_1) ∩ B(p, 1) = {q_1 + e(θ) : 240° < θ < 300°}`, and `A*` meets `B̄(y_0, 1)` only at its end `y_1 = q_1 + e(300°)`
   (`|q_1 + e(θ) − y_0|² = 5 + 4 cos(θ − 120°)`, control `astar-arc`). Near `y_1`, `A*` leaves along direction `210°` (the tangent of `ω(q_1)`
   at `y_1`), curving toward `q_1`, so its points have directions from `y_1` just below `210°`. At `y_1` (`X₊ = X̄`, the colour of `(60°, 120°)`),
   V5-GERM puts directions `(150°, 210°)` in `X̄` or a tip; the tip at `y_1` is `T1` alone (TIPS), `T1 ⊂ B(y_0, 1)`, so `T1`'s closed sector at `y_1`
   lies in `B̄(y_0, 1)`, which `A*` avoids near `y_1`. So `A*`'s points near `y_1` lie in the sector of the `X̄` tile `R_{1,2}` and off its two edges
   (one has direction at most `150°`, the other lies in `cl T1`): interior points of colour `X̄` at distance exactly 1 from `q_1`. By V5-NE1 no tile
   of colour `X̄` has `q_1` in its closure.
3. *(b), 4.* The outer colours of `y_2` are `{4}` (NBTIP), carried by one tile `O_2`. A tile of colour 4 with points in `L_1 ⊂ B(y_2, 1)` is within
   distance below 1 of `O_2`'s points near `y_2`, so it is `O_2`. If `q_1 ∈ cl O_2`, then `O_2 ⊂ B(q_1, 1)` (V5-NE1). The tiles at `y_2` are exactly
   `R_{1,2}` (`X̄`), `O_2`, `R_{2,3}` (`X`), `T3`, counter-clockwise (V5-GERM; a fifth tile would carry colour 1 or 2, so be a tip or an outer tile
   of `y_2`, and it is neither, by TIPS and NBTIP): `O_2` and `R_{2,3}` are consecutive and share an edge. But `R_{2,3} ⊂ B(y_3, 1)` (`y_3` is in
   the closure of its ring arc), and `B̄(q_1, 1) ∩ B̄(y_3, 1) = {y_2}` (`|q_1 − y_3| = 2`, control `hub-distances`). Contradiction.
4. *(c).* The directions `(210°, 330°)` at `q_1` point into the interior of `L_1` (into `B(y_1, 1)`: `(210°, 390°)`; into `B(y_2, 1)`:
   `(150°, 330°)`). So every tile at `q_1` with a point of `L_1` has colour `X̄, 2` or `4` (step 1), not `X̄` and not 4 (steps 2, 3): colour 2, hence
   one tile `Z` (non-Siamese), and every point of `L_1` close to `q_1` is in a sector at `q_1` — so in `Z` — or on an edge.
5. *(d).* The outer colours of `y_1` avoid its tip's colour 1 and `y_2`'s tip's colour 3 (NBTIP), so lie in `{2, 4}`, one tile each, at least one
   tile (V5-GERM). If `y_1` carries a tile `W` of colour 2, it is not a tile of `p` (the tip at `y_1` is `T1`), and `Z` has points in `B(y_1, 1)`,
   so `W = Z`, `q_1 ∈ cl W` and `W ⊂ B(q_1, 1)`. The `X` tile at `y_1` is `R_{0,1}` (it holds `(0°, 60°)`), `R_{0,1} ⊂ B(y_0, 1)`, and
   `B̄(q_1, 1) ∩ B̄(y_0, 1) = {y_1}`: `W` and `R_{0,1}` are not consecutive. By V5-GERM the order at `y_1` is outer tiles, `R_{1,2}`, `T1`, `R_{0,1}`;
   so a further outer tile lies between `R_{0,1}` and `W` — of colour 4. If `y_1` carries no tile of colour 2, its outer tiles have colour 4. So
   `y_1` carries an outer 4-tile `O`, and with two outer tiles the order counter-clockwise from `R_{0,1}` is `O`, `W`.
6. *(e).* `O`'s sector at `y_1` follows `R_{0,1}`'s, whose cone lies in `[210°, 30°]` (`R_{0,1} ⊂ B(y_0, 1)`), and either precedes `W`'s, which
   lies in `[30°, 210°]`, or covers `(30°, 90°)`; so `O` has points near `y_1` along directions `γ` near `30°` or in `(30°, 90°)`, with
   `cos(γ − 60°) > 0`. V5-OUT puts `T4`'s cone `[δ_3, δ_4]` in `[150°, 330°]`; with `δ_4 ∈ [−30°, 30°]`, `δ_4 = −30°`.
7. *The images.* The reflection `θ ↦ 60° − θ` maps the class to itself, fixes `T1`, `T2`, `X`, swaps the roles of `T3` and `T4` (so the colours 3
   and 4), reverses orientation, and maps `L_5` to `L_1`; the edge `δ_4` of the image is the image of `δ_1`, so `60° − δ_1 = −30°`. The half-turn
   maps `L_4` to `L_1`, swaps `T1 ↔ T2`, `T3 ↔ T4` (colours `1 ↔ 2`, `3 ↔ 4`) and `X ↔ X̄`, preserves orientation, and carries `δ_2` to the image's
   `δ_4`: `δ_2 + 180° = −30°`. Their composite maps `L_2` to `L_1` and gives `δ_3 = 270°`. The colours and orders in the statement are the images of
   (c)–(d) under the same maps (at `y_0`, orientation reversed: counter-clockwise from `R_{5,0}`, 2 then 3).

### 2.6 TIGHTLENS and STARFORCE — derivations

**TIGHTLENS.** V5-LENS (e) and its images give `δ_4 = −30°`, `δ_1 = 90°`, `δ_2 = 150°`, `δ_3 = 270°`: each of (Q1), (Q2), (Q4), (Q5) holds by its
first disjunct (`δ_4 = −30°`, `δ_3 = 270°`, `δ_2 = 150°`, `δ_1 = 90°`). The gloss holds: the lens `L_1` beside the single tip `T3` makes the
tip `T1` of its other hub `y_1` tight at `p` (`δ_4 = −30° = 60° − 90°`, a flanking direction of `y_1`, with `T1` on its side); likewise `L_2`
(`T2` for `y_3`), `L_4` (`T2` for `y_4`), `L_5` (`T1` for `y_0`). All four edges lie along flanking directions, so at least two do, and no
`δ_i` is interior to its range: no generic star. **Reading the derivation against the statement:** it carries each disjunction's first disjunct
outright, so TIGHTLENS is TRUE and weaker than what its own hypotheses give — the other disjuncts (`δ_1 = 30°`, `δ_2 = 210°`, `δ_4 = 30°`,
`δ_3 = 210°`) never hold in the class.

**STARFORCE.** (i) The edges: as above, `(90°, 150°, 270°, −30°)`. (ii) "3 is an outer colour of `y_0` and of `y_4`, and 4 of `y_1` and of `y_3`":
V5-LENS (d) and its images. (iii) "each of these four hubs has that outer colour alone or two outer tiles, counter-clockwise 2, 3 at `y_0`; 4, 2
at `y_1`; 1, 4 at `y_3`; 3, 1 at `y_4`": V5-LENS (d) and its images, under reading (R-ORDER); FALSE under the reverse reading, by the same lemma.
(iv) "near `q_1, q_5` the lens points carry colour 2, near `q_2, q_4` colour 1": V5-LENS (c) and its images, under (R-LENSPT).

### 2.7 Attacks

#### Attack on FS116-Y3-SIX

- *Degenerate cases.* Five or six colours at `p`: V5-RING step 3 refuses them (one absent colour cannot alternate), consistent with the
  statement's "exactly four tiles". A ring point of `Γ` that is not a change point (an edge crossing the ring with one colour on both sides): it
  splits no ring tile (step 5) and is no change point; the count is unaffected.
- *Each hypothesis removed.* **Six colours:** spent at step 3; at `k ≥ 7` there are three or more absent colours, `c(θ + 60°)` is no longer the
  other colour, and the window parity of step 6 is gone (the not-claimed line's SQ9). **Non-Siamese:** spent at step 5 (two ring arcs of one colour
  less than 60° apart are one tile) and at the count of tiles at `p`; without it the step that kills three changes in a window fails. **Simple:**
  never used — **a thin truth**: SIX holds for non-simple fragments of the class too. **Radius above 1:** puts the ring inside the fragment.
  **Γ-free:** makes every change point a hub (no germ on any arc of `Γ`) and `Γ ∩ ω(p)` finite.
- *Where the attack succeeds.* The nearest statements that fail or are not carried: SIX with Siamese pairs allowed (step 5 has no replacement);
  SIX at `k = 7`. The two controls of the list (the capped strip's midline vertices, the disk's corners) are outside the class — their rings
  carry (Q) arcs — so the route is silent on them, at the hypothesis "no arc of `Γ`".

#### Attack on FS116-Y3-TIPS

- *Degenerate cases.* A tile of `p` with a zero-angle cone at `p`: `T3`, `T2` have cones of width at least 60° by the ranges; `T1` (`T4`) is a
  cusp only if `δ_4 = δ_1 = 30°` (`δ_3 = δ_4 = 210°`, impossible: `δ_4 ≥ −30°`); the statement's ranges allow `T1`'s cusp and the derivation does
  not need to exclude it (at radius √3 V5-LENS does: `δ_4 = −30°`, `δ_1 = 90°`). Two tips at one hub sharing an edge from `p` to the hub — the
  break I registered — is killed by the antipodal hub's tip (§ 2.3 step 2), never by the hub's own neighbourhood.
- *Each hypothesis removed.* **Simple:** spent at step 2 (four sectors, consecutive ones sharing an edge); with a tile of `p` holding two sectors
  at `p` the 4-cycle argument fails — not decided. **Non-Siamese:** spent in SIX and in V5-GERM's tip clause (RING-GERM (i)'s tile is GERM-S's,
  not a tile of `p`, the statement's own not-claimed line).
- *Where the attack succeeds.* "Each `δ` is free in its interval" is the statement's own not-claimed line, and it is the right one: at radius
  √3 every `δ` is pinned to an endpoint (V5-LENS), so a reader who took TIPS's ranges as attained would be wrong there.

#### Attack on FS116-Y3-NBTIP

- *Degenerate cases.* For the double tips the first clause is immediate (`T1 ⊂ B(y_1, 1)` entirely); the content is at `y_2`, `y_5` and at the
  far neighbour of each double-tip hub. The inner cone `(150°, 210°)` is open, so a tip that touches its hub only along a cusp is excluded by
  V5-GERM, not assumed away.
- *Each hypothesis removed.* **Non-Siamese** is the whole second clause (an outer tile of the tip's colour within distance below 1 of the tip);
  without it the clause fails as stated. **Γ-free:** V5-GERM's tip cone needs the tip pair's germs off (Q) arcs; with (Q) arcs on the ring the
  tip may not exist (RING-GERM (i)'s hypothesis).
- *Where the attack succeeds.* The outer colours of `y_0, y_1, y_3, y_4` are not decided by NBTIP (two colours left at each); the statement does
  not claim them ("anything about outer tiles of other colours").

#### Attack on FS116-Y3-TIGHTLENS

- *Where the attack succeeds, first:* the statement is **weaker than its hypotheses give**. Each lens forces its first disjunct alone (V5-LENS
  (e) and images); the other disjuncts never hold. So TIGHTLENS is TRUE and a thin truth in content: its "or" is idle.
- *Each hypothesis removed.* **Radius √3:** spent at V5-LENS step 4 (a neighbourhood of `q_k`); below √3 the route is silent, as the not-claimed
  line says. **Six colours:** spent at V5-LENS step 1 — at `k = 7` a third absent colour `X′` is allowed in `L_k` and at `q_k` (the not-claimed
  line's own words), and step 4's corner has a colour with no constraint. **Non-Siamese:** steps 1, 3, 5 (each "is that tile"). **Simple:** step 3
  (the four tiles at `y_2` as consecutive sectors) and step 5.
- *Kill-test on the controls.* The capped strip and the disk are outside the class (their rings carry (Q) arcs): the route fails on them at its
  hypothesis, before any step.

#### Attack on FS116-Y3-STARFORCE

- *The undefined phrases.* (R-LENSPT) is the only reading I find of "the lens points … near `q_k`"; under it (iv) holds. For the order, (R-ORDER)
  reads "counter-clockwise" literally inside the outer arc of the hub; the reverse order is FALSE at all four hubs (V5-LENS (d): at `y_1` the
  2-tile, when present, is `Z`, never next to `R_{0,1}`). I do not count the reverse as a second reading of "counter-clockwise".
- *The alternative stars.* The other solutions of (Q1)–(Q5) — `δ_1 = 30°` with `δ_3 = 210°`, `δ_2 = 210°` with `δ_4 = 30°`, and the rest — are
  each excluded by V5-LENS (e), which pins every `δ` without reading the disjunctions. My registered break (that they survive) failed.
- *"alone or two outer tiles".* Not decidable further by this route: at `y_1` both "4 alone" and "4, then 2 = `Z`" survive V5-LENS, and the
  statement claims exactly that disjunction.
- *Each hypothesis removed.* As for TIGHTLENS. Existence is not claimed and is not decided here: the class may be empty at radius √3.

### 2.8 The verdicts (first group)

verification: FS116-Y3-SIX
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring carries no arc of Γ, the ring has exactly six change points, 60° apart, each a hub, and p has exactly four tiles *Not claimed:* anything in the Siamese class (there RING-GERM's tip is GERM-S's tile, not necessarily a tile of p, and the count is not run); anything at k ≥ 7 (SQ9 at k = 9 has twelve); that any such fragment exists
  given: the statement with its not-claimed line; § 14's setting words and notes (which restate SIX's and TIPS's conclusions as labels); the rest of data/fs116/claims.md (§ 8's FS114-N7-3T carries N7-HUB's outline; §§ 10–12 hold RING-GERM, GERM-S and S1-KAPPA); data/fs114/claims.md; plans/FS114-derivation.md § 3's entry statements (N6-RING60 among them); CLAUDE.md and the grokkings; that other minds worked the statement — no FS-116 record and no route of this statement (§ 1.2) — and, bearing on this statement: N6-RING60's held statement and S1-KAPPA's proposed one assert its count (change points exactly y + 60°ℤ) in neighbouring classes, so its main clause's truth was expected before I derived it; their arguments were not seen
  committed: 2026-10-03
  predicted: derived — 0.85 — likeliest break: the count "exactly six"
  verdict: derived
  method: V5-RING: window parity from the alternation c(θ + 60°) ≠ c(θ), three changes in a window killed by merging ring arcs into one tile (non-Siamese) against the 60° reach of a tile; the first derivation's method not known until stage 4
  attack: § Attack on FS116-Y3-SIX
  divergences: none — the first derivation stays fenced until this group's verdicts and the second group's are committed; the table is stage 4's
  counterexamples: thin truth: SIX with "simple" deleted — V5-RING never uses simplicity, so the hypothesis is idle
  minds: 2 — blind to: the proposing record's argument, every FS-116 record and every other mind's verdict (fenced until stage 4); method: not known until stage 4; blind, the same model (Opus 5.5)
  grade: hand

verification: FS116-Y3-TIPS
  statement: in FS116-Y3-SIX's setting, with the hubs y_k = e(60k), each hub has exactly one tip, the tips of antipodal hubs are opposite tiles of p, and up to rotation of the labels the four tiles of p, counter-clockwise, are T1 tipping y_0 and y_1 (cone at p in [−30°, 90°]), T3 tipping y_2 (in [30°, 210°]), T2 tipping y_3 and y_4 (in [150°, 270°]) and T4 tipping y_5 (in [210°, 30°]) *Not claimed:* anything in the Siamese or non-simple class; that the cones fill their ranges (each δ is free in its interval); that any such fragment exists
  given: the statement with its not-claimed line; § 14's setting words and notes (which restate SIX's and TIPS's conclusions as labels); the rest of data/fs116/claims.md (§ 8's FS114-N7-3T carries N7-HUB's outline; §§ 10–12 hold RING-GERM, GERM-S and S1-KAPPA); data/fs114/claims.md; plans/FS114-derivation.md § 3's entry statements (N6-RING60 among them); CLAUDE.md and the grokkings; that other minds worked the statement — no FS-116 record and no route of this statement (§ 1.2) — and, bearing on this statement: RING-GERM (i) and N7-HUB's outline assert that the directions toward p at a hub lie in tips; the uniqueness of the tip and the pattern were not given
  committed: 2026-10-03
  predicted: derived — 0.55 — likeliest break: "each hub has exactly one tip"
  verdict: derived
  method: a hub's two tips both non-consecutive at p with the antipodal hub's tip, against a 4-cycle (V5-TIPSET, § 2.3); the pattern by enumerating the tip map; the first derivation's method not known until stage 4
  attack: § Attack on FS116-Y3-TIPS
  divergences: none — the first derivation stays fenced until this group's verdicts and the second group's are committed; the table is stage 4's
  counterexamples: none — cusp tiles at p, two tips sharing an edge to their hub, and the four labellings up to rotation, searched by hand in § Attack on FS116-Y3-TIPS
  minds: 2 — blind to: the proposing record's argument, every FS-116 record and every other mind's verdict (fenced until stage 4); method: not known until stage 4; blind, the same model (Opus 5.5)
  grade: hand

verification: FS116-Y3-NBTIP
  statement: in FS116-Y3-TIPS's setting, the tip of each hub meets the open unit disc about each of the two neighbouring hubs; so no hub has a neighbour's tip colour as an outer colour, and the only outer colour of y_2 is 4 and of y_5 is 3 *Not claimed:* anything about outer tiles of other colours; anything outside the Γ-free class (there consecutive change points need not be 60° apart)
  given: the statement with its not-claimed line; § 14's setting words and notes (which restate SIX's and TIPS's conclusions as labels); the rest of data/fs116/claims.md (§ 8's FS114-N7-3T carries N7-HUB's outline; §§ 10–12 hold RING-GERM, GERM-S and S1-KAPPA); data/fs114/claims.md; plans/FS114-derivation.md § 3's entry statements (N6-RING60 among them); CLAUDE.md and the grokkings; that other minds worked the statement — no FS-116 record and no route of this statement (§ 1.2) — and, bearing on this statement: N7-HUB's outline in § 8 ("a tip, which meets B(y_{k−1},1) ∩ B(y_{k+1},1), so its colour is carried at y_{k±1} by no other tile") is the route and the conclusion of this statement's first two clauses
  committed: 2026-10-03
  predicted: derived — 0.6 — likeliest break: the tip reaching the neighbour's open disc when its cone is extreme
  verdict: derived
  method: the tip covers the open inner cone (V5-GERM), which points into both neighbours' open discs; non-Siamese then removes the colour; the first derivation's method not known until stage 4
  attack: § Attack on FS116-Y3-NBTIP
  divergences: none — the first derivation stays fenced until this group's verdicts and the second group's are committed; the table is stage 4's
  counterexamples: none — cusp tips at the hub and the double tips' far neighbours, by hand in § Attack on FS116-Y3-NBTIP
  minds: 1 — a checking reading on the first two clauses (their route and conclusion were in N7-HUB's outline, given); the third clause's derivation is mine, but follows from the first two in one line; blind to the proposing record, the same model (Opus 5.5)
  grade: hand

verification: FS116-Y3-TIGHTLENS
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius at least √3 about a vertex p of at least four colours whose ring carries no arc of Γ, labelled as FS116-Y3-TIPS, the edges of p satisfy (Q1) δ_4 = −30° or δ_1 = 30° or δ_2 = 210°; (Q2) δ_3 = 270° or δ_1 = 30° or δ_2 = 210°; (Q4) δ_2 = 150° or δ_4 = 30° or δ_3 = 210°; (Q5) δ_1 = 90° or δ_4 = 30° or δ_3 = 210° — for each lens beside a single tip, the tip of one of its two hubs is tight at p for that hub; so at least two edges of p lie along flanking directions of hubs, and no such fragment has a generic star *Not claimed:* that any star satisfying (Q1)–(Q5) occurs; anything below radius √3 (a generic star there is neither excluded nor built); anything in the Siamese or non-simple class; anything at k ≥ 7 (a third absent colour survives near q_k)
  given: the statement with its not-claimed line; § 14's setting words and notes (which restate SIX's and TIPS's conclusions as labels); the rest of data/fs116/claims.md (§ 8's FS114-N7-3T carries N7-HUB's outline; §§ 10–12 hold RING-GERM, GERM-S and S1-KAPPA); data/fs114/claims.md; plans/FS114-derivation.md § 3's entry statements (N6-RING60 among them); CLAUDE.md and the grokkings; that other minds worked the statement — no FS-116 record and no route of this statement (§ 1.2) — nothing bearing on lenses beyond § 14's definitions
  committed: 2026-10-03
  predicted: derived — 0.4 — likeliest break: a disjunct not forced at exactly √3
  verdict: derived
  method: V5-LENS: the corner of each lens at its far vertex can carry only the double tip's opposite colour, which forces an outer tile of the single tip's colour at the double-tip hub, and V5-OUT pins the edge; the first derivation's method not known until stage 4
  attack: § Attack on FS116-Y3-TIGHTLENS
  divergences: none — the first derivation stays fenced until this group's verdicts and the second group's are committed; the table is stage 4's
  counterexamples: thin truth: (Q1)–(Q5) — each holds by its first disjunct alone (V5-LENS (e)); the second and third disjuncts never hold in the class
  minds: 2 — blind to: the proposing record's argument, every FS-116 record and every other mind's verdict (fenced until stage 4); method: not known until stage 4; blind, the same model (Opus 5.5)
  grade: hand

verification: FS116-Y3-STARFORCE
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius at least √3 about a vertex p of at least four colours whose ring carries no arc of Γ, labelled as FS116-Y3-TIPS, the edges of p are δ_1 = 90°, δ_2 = 150°, δ_3 = 270°, δ_4 = −30° (FS116-N2-HEX3's star); 3 is an outer colour of y_0 and of y_4, and 4 of y_1 and of y_3; each of these four hubs has that outer colour alone or two outer tiles, counter-clockwise 2, 3 at y_0; 4, 2 at y_1; 1, 4 at y_3; 3, 1 at y_4; and near q_1, q_5 the lens points carry colour 2, near q_2, q_4 colour 1 *Not claimed:* that any such fragment exists, at any radius; anything below radius √3; anything in the Siamese or non-simple class; anything at k ≥ 7
  given: the statement with its not-claimed line; § 14's setting words and notes (which restate SIX's and TIPS's conclusions as labels); the rest of data/fs116/claims.md (§ 8's FS114-N7-3T carries N7-HUB's outline; §§ 10–12 hold RING-GERM, GERM-S and S1-KAPPA); data/fs114/claims.md; plans/FS114-derivation.md § 3's entry statements (N6-RING60 among them); CLAUDE.md and the grokkings; that other minds worked the statement — no FS-116 record and no route of this statement (§ 1.2) — nothing bearing on lenses beyond § 14's definitions; the star's values (90°, 150°, 270°, −30°) were given by the statement itself, as FS116-N2-HEX3's
  committed: 2026-10-03
  predicted: derived — 0.3 — likeliest break: the other boundary stars solving (Q1)–(Q5) survive
  verdict: derived
  method: V5-LENS and its images under the reflection at 30° and the half-turn; under readings (R-LENSPT) and (R-ORDER) of § 2.0; the first derivation's method not known until stage 4
  attack: § Attack on FS116-Y3-STARFORCE
  divergences: none — the first derivation stays fenced until this group's verdicts and the second group's are committed; the table is stage 4's
  counterexamples: none — the alternative stars solving (Q1)–(Q5), the two orders at each hub and both cases at y_1 (4 alone; 4 then 2), by hand in § Attack on FS116-Y3-STARFORCE
  minds: 2 — blind to: the proposing record's argument, every FS-116 record and every other mind's verdict (fenced until stage 4); method: not known until stage 4; blind, the same model (Opus 5.5)
  grade: hand
### 2.9 Controls (exact, `tools/fs116_v5_geom.py`; each with a planted fault)

control: hub-distances
  of: V5-TIPSET — the distances the tip and lens steps consume, with the hubs at 60° spacing
  run: python3 ../tools/fs116_v5_geom.py dist 60
  expect: exact 10/10
  fault: python3 ../tools/fs116_v5_geom.py dist 61

control: germ-first-order
  of: V5-GERM — the first-order motion of the two points of ω(z) ∩ ω(p)
  run: python3 ../tools/fs116_v5_geom.py germ 30
  expect: germ first-order exact
  fault: python3 ../tools/fs116_v5_geom.py germ 31

control: astar-arc
  of: V5-LENS — the arc A* = ω(q_1) ∩ B(p, 1) and its external tangency with ω(y_0) and ω(y_3)
  run: python3 ../tools/fs116_v5_geom.py astar 5
  expect: astar exact
  fault: python3 ../tools/fs116_v5_geom.py astar 4

control: out-expansion
  of: V5-OUT — the first-order expansion of |e(ψ) + s e(γ) − s′ e(δ)|²
  run: python3 ../tools/fs116_v5_geom.py out 2
  expect: out exact
  fault: python3 ../tools/fs116_v5_geom.py out 3

## Stage 3 — SAVED

*The second group: SEMI, PAIR, CROSS. Rings may now carry (Q) arcs. Setting: a non-Siamese simple valid six-coloured fragment on a closed
disc of radius above 1 about a vertex `p` of at least four colours, `y = r(0)` a change point (reading L), `X` the ring colour just
counter-clockwise of `y`, `X̄` just clockwise, `R`, `R′` their tiles at `y`, `u = r(60°)`, `v = r(−60°)`, germs as § 13. Readings (R-QARC),
(R-CHG) of § 1.1 hold throughout.*

### 3.1 Lemmas for rings with (Q) arcs

derivation: V5-QCOL
  statement: in this setting p has exactly four colours and X, X̄ are the two absent; a germ that lies on no (Q) arc "carries" an absent colour — the ring colour there if the germ is off Γ, else an absent side colour of the arc of Γ on ω(p) it lies on — namely X at u⁻ and v⁻ and X̄ at u⁺ and v⁺, and the hub's partner point (u or v) lies in the closure of a tile of that colour; a germ on a (Q) arc lies on an arc of ω(p) whose inner tile is p's tile of the inner colour and whose outer tile is not a tile of p; the two germs of one pair never lie on one (Q) arc, and a (Q) arc holding u⁺ (v⁻) and not u⁻ (v⁺) ends at u (v)
  uses only: V5-NE1; non-Siamese; reading L at y; a circular arc of Γ containing a sub-arc of ω(p) lies on ω(p)
  not claimed: that a germ off (Q) lies off Γ; anything at k ≥ 7
  argument: § V5-QCOL's argument
  verdict: derived
  grade: hand
  minds: 1
  model: none held — no fragment of the class is known
  prior art: partly: RING-GERM's first clause (data/fs116/claims.md § 10) and FS116-N1-GERM-R's exclusions (§ 11)
  handoff: none — a relay-result for SEMI, PAIR, CROSS

#### V5-QCOL's argument

`X ≠ X̄` (reading L), both absent at `p` (V5-NE1), so at most four colours are carried, and at least four by hypothesis. A germ, say
`v⁻ = r(−60° − ε)`, is at distance 1 from `r(−ε)`, an interior point of colour `X̄`; if `v⁻` is off `Γ` its colour is absent and not `X̄`, so
`X`; if it lies on an arc of `Γ` (on `ω(p)`), `ω(r(−ε))` crosses that arc transversally, so neither side tile has colour `X̄`, and if the arc is not
(Q) one side colour is absent at `p` — so `X`. The same pairing (`u⁻` with `r(−ε)`, `u⁺` and `v⁺` with `r(ε)`) gives the others, and the side tile
borders the germ up to `v`, so `v` is in its closure. The inner tile of an arc of `ω(p)` has points inside `B(p, 1)`, within distance below 1 of
`p`'s tile of its colour, so is that tile (non-Siamese); the outer tile lies outside `B̄(p, 1)` and is not a tile of `p` (V5-NE1). One (Q) arc
holding `v⁻` and `u⁺` would contain `y` (excluded by reading L) or span more than 120°, so its inner tile would have closure points more than 1
apart (V5-NE1); the same for `u⁻`, `v⁺`. A (Q) arc holding `u⁺` but not `u⁻` starts at `u`.

derivation: V5-U1
  statement: let A be an arc of Γ on ω(z), of angular extent [θ₁, θ₂] about z, θ₂ − θ₁ = ℓ > 0, with inner side colour c and outer side colour c′; a tile of colour c with z in its closure has its cone at z in the closed cone [θ₂ − 90°, θ₁ + 90°] facing A; one of colour c′ has it in the closed cone [θ₂ + 90°, θ₁ + 270°] facing away; the two open side cones (θ₁ − 90°, θ₂ − 90°) and (θ₁ + 90°, θ₂ + 90°) hold neither colour; so if z carries both c and c′ (A is both-kind), the side cones hold two further colours and, in a non-Siamese simple fragment, z has at least four colours
  uses only: validity; first order of |z + (1 ∓ η) e(θ) − z − s e(δ)| = 1 ∓ η − s cos(δ − θ) + O(s² + η²)
  not claimed: anything when ℓ = 0; anything about tiles at z of other colours
  argument: § V5-U1's argument
  verdict: derived
  grade: hand
  minds: 1
  model: the disk's corners (data/fs116/claims.md § 9's controls: four-colour vertices carrying (Q)-type unit arcs), as stated by FS114-N7-QOPP's model line
  prior art: known — FS112-U1 (plans/FS112-derivation.md, line 42), re-derived
  handoff: none — a relay-result

#### V5-U1's argument

Points `z + (1 − η)e(θ)`, `θ ∈ (θ₁, θ₂)`, `η` small, are in the inner tile; a point `z + s e(δ)` of a `c`-tile at `z` is at distance
`1 − η − s cos(δ − θ) + O(·)` from it, which equals 1 for some small `s, η` exactly when `cos(δ − θ) < 0` for some `θ` in the arc; so the `c`-cone
lies where `cos(δ − θ) ≥ 0` on the whole arc. For `c′` the outer points give `1 + η − s cos(δ − θ)`, so its cone lies where `cos(δ − θ) ≤ 0`. In
a side cone `cos(δ − θ)` changes sign along the arc. The two side cones are separated by the facing and away cones, each of which holds a
sector of `c` (resp. `c′`); a sector meeting both side cones would contain one of those sectors; so (one sector per tile, one tile per colour)
two more colours.

derivation: V5-OUT2
  statement: in V5-QCOL's setting (or V5-RING's), if an outer tile of colour c has a ring point r(θ) in its closure, then p's tile of colour c has its cone at p in [θ + 90°, θ + 270°]
  uses only: an outer tile is open and disjoint from B(p, 1) (non-Siamese), hence lies in |w| > 1; |w − s e(δ)| = 1 has a small root s > 0 when w·e(δ) > 0 and |w| > 1 is close to 1
  not claimed: anything about the boundary directions of that cone
  argument: § V5-OUT2's argument
  verdict: derived
  grade: hand
  minds: 1
  model: none held — no fragment of the class is known
  prior art: partly: V5-OUT (this record), which assumed a direction of the outer tile with positive cosine; this form needs none
  handoff: none — a relay-result for CROSS

#### V5-OUT2's argument

An outer tile `O` of colour `c ∈ P` has no point in `B(p, 1)` (such a point would be within distance below 1 of `p`'s `c`-tile); `O` is open, so
`O ⊂ {|w| > 1}`. If `p`'s `c`-tile holds `s e(δ)` for small `s` with `cos(δ − θ) > 0`, take `w ∈ O` near `r(θ)`: `|w − s e(δ)|² − 1 =
s² − 2s (w·e(δ)) + |w|² − 1` vanishes at `s = w·e(δ) − √((w·e(δ))² − |w|² + 1) ≈ (|w|² − 1)/(2 cos(δ − θ))`, small and positive — two
interior points of colour `c` at distance exactly 1.

derivation: V5-DICHO
  statement: in V5-QCOL's setting, if both germs of one pair at y lie on (Q) arcs A₁, A₂ with colour pairs Π₁, Π₂, then Π₁ = Π₂ (and then the inner colour of each is the outer colour of the other) or Π₁ ∩ Π₂ = ∅
  uses only: V5-QCOL, V5-U1 at p, V5-NE1; simple (one sector per tile at p) and the four tiles of p
  not claimed: that either case occurs
  argument: § V5-DICHO's argument
  verdict: derived
  grade: hand
  minds: 1
  model: none held — no fragment of the class is known
  prior art: partly: FS114-N7-QOPP (data/fs116/claims.md § 13's note: "(Q) arc … joins opposite tiles"), stated for degree 4, not read as an argument
  handoff: none — § 13's note asks that the dichotomy be checked, not given; here it is derived for every degree

#### V5-DICHO's argument

Tip pair (the outer pair is the mirror image): `A₁ = [60°, 60° + ℓ₁] ∋ u⁺`, `A₂ = [−60° − ℓ₂, −60°] ∋ v⁻` (V5-QCOL: each ends at its hub's
partner), `ℓ_i ≤ 60°` (V5-NE1 on the inner tile). V5-U1 at `p`: inner colour of `A₁` in `[−30° + ℓ₁, 150°]`, outer in `[150° + ℓ₁, 330°]`, side
cones `(−30°, −30° + ℓ₁)`, `(150°, 150° + ℓ₁)`; inner of `A₂` in `[210°, 390° − ℓ₂]`, outer in `[30°, 210° − ℓ₂]`, side cones `(30° − ℓ₂, 30°)`,
`(210° − ℓ₂, 210°)`. *Equal inner colours:* `p`'s tile of that colour borders both germs, points more than 1 apart: excluded. *Exactly one shared
colour, the outer:* its tile lies in `[150° + ℓ₁, 210° − ℓ₂]`; the side cones `(150°, 150° + ℓ₁)` and `(210° − ℓ₂, 210°)` hold neither shared
colour nor their own arc's inner colour, and the other arc's inner colour does not reach them, so both lie in the fourth tile, on both sides of
the shared tile — two sectors. *Exactly one shared, inner of one = outer of the other:* the same count puts the fourth tile in two side cones
on either side of the shared colour's tile. The outer pair is identical with `A₁ = [60° − ℓ₁, 60°]`, `A₂ = [−60°, −60° + ℓ₂]` (cases written in my
working; each ends in two sectors or in the diameter). So the pairs are equal, with opposite orientation, or disjoint.

### 3.2 SEMI — derivation

At `y`, `X` and `X̄` are carried (`R`, `R′`). V5-GERM's first-order computation needs no Γ-freeness: for `z = y + t e(β)` off `Γ`, the upper
point of `ω(z) ∩ ω(p)` is on `u⁺` for `β ∈ (30°, 210°)`, on `u⁻` for `(210°, 390°)`; the lower on `v⁺` for `(−30°, 150°)`, on `v⁻` for
`(150°, 330°)`; and `z` avoids each colour carried there (V5-QCOL: a germ off (Q) its carried colour; a (Q) germ its two side colours, in `P`).
Inside `B(p, 1)` a colour of `P` is `p`'s tile; outside, an outer tile, in `|w| > 1`.

**Kind O** (`u⁻`, `v⁺` off (Q), carrying `X`, `X̄`). `(−30°, 30°)` sees both, so lies in outer tiles: `y` has at least three colours. Let it have
exactly three, `X, X̄, o`, tiles `R, R′, O`; then no tip (a tip's colour is never an outer colour at `y`), `O`'s sector lies in `[−90°, 90°]`, and
the inner half is `R ∪ R′`: `(90°, 150°)` sees `v⁺`, so is `R`; `(210°, 270°)` sees `u⁻`, so is `R′`.
- `v⁻` off (Q) (it carries `X`): `(150°, 210°)` is `R′`; the edge `R | R′` leaves `y` along `150°`, the tangent of `ω(v)`. `v` carries `X` and `X̄`
  (V5-QCOL), so no point of `R` or `R′` is at distance 1 from `v`; an edge (segment or circular arc) tangent to `ω(v)` at `y` and distinct from it
  leaves `ω(v)` strictly inside one of the two adjacent sectors near `y`; so the edge is an arc of `ω(v)`, both side colours carried at `v`, and
  `v` has at least four colours (V5-U1). Alternative (b).
- `u⁺` off (Q): the mirror, the edge along `210°` an arc of `ω(u)`. (b).
- both on (Q) (full), colour pairs `Π_u` (at `u⁺`), `Π_v` (at `v⁻`). `(30°, 90°)` sees `u⁺` and `v⁺`: `R`, or `O` if `o ∉ Π_u`; `(270°, 330°)`:
  `R′`, or `O` if `o ∉ Π_v`. If `o ∈ Π_u`, the edge `O | R` lies along `30°`, the tangent of `ω(u)`, and `u` carries `X` (`u⁻`) and `o` (the side
  tiles of the (Q) arc reach `u`): an arc of `ω(u)`, (b). If `o ∈ Π_v`: the edge `R′ | O` along `330°`, an arc of `ω(v)`, (b). Otherwise
  `o ∉ Π_u ∪ Π_v`, so by V5-DICHO `Π_u = Π_v = {c₁, c₂}`, `A_u` inner `c₁`, `A_v` inner `c₂`: `y` is full parallel. V5-U1 puts `T_{c₁}` in
  `[30°, 150°]`, `T_{c₂}` in `[210°, 330°]`; the side cones `(150°, 150° + ℓ_u)`, `(210° − ℓ_v, 210°)` and `(−30°, −30° + ℓ_u)`, `(30° − ℓ_v, 30°)`
  hold neither, so the two other tiles fill the two gaps, one each, the one round `180°` holding `180°` in its interior. V5-OUT2 (`O` outer at
  `y`): `T_o ⊂ [90°, 270°]`, so `T_o` is that tile. Alternative (c), kind O.

**Kind T** (`v⁻`, `u⁺` off (Q)). `(150°, 210°)` lies in tips; with exactly three colours `X, X̄, τ`, tiles `R, R′, T`, no outer tile, the outer
half is `R ∪ R′`: `(30°, 90°)` sees `u⁺` (`R`), `(270°, 330°)` sees `v⁻` (`R′`). `v⁺` off (Q): `(−30°, 30°)` is `R`, the edge `R′ | R` along
`330°` an arc of `ω(v)`, (b). `u⁻` off (Q): mirror, along `30°`, `ω(u)`, (b). Both on (Q), pairs `Π_{u⁻}`, `Π_{v⁺}`: `(90°, 150°)` is `R` or `T`
(the latter only if `τ ∉ Π_{v⁺}`), `(210°, 270°)` is `R′` or `T` (only if `τ ∉ Π_{u⁻}`); `τ ∈ Π_{v⁺}` gives the edge `R | T` along `150°`, an arc
of `ω(v)` (`v` carries `X` and `τ`), (b); `τ ∈ Π_{u⁻}` the edge `T | R′` along `210°`, `ω(u)`, (b); otherwise V5-DICHO makes `y` full parallel,
the gap tiles hold `0°` and `180°`, and `T ⊂ B(y, 1)` has its cone at `p` in `[−90°, 90°]`: `τ` is the colour of the tile holding `0° = ψ` in its
interior. (c), kind T.

So every semi-hub is (a), (b) or (c). **TRUE.**

### 3.3 PAIR — derivation

By V5-QCOL the two germs lie on distinct (Q) arcs of `ω(p)`, whose inner tiles are `p`'s tiles of their inner colours. Equal inner colours would
put one tile of `p` along both germs, which are more than 1 apart (angular separation near 120° for the outer pair, above 120° for the tip pair),
against V5-NE1. With one colour pair, the inner colours then differ and each is the other's outer. **TRUE.** "Simple" and the four colours'
count beyond V5-QCOL are not used: a thin truth (simple idle).

### 3.4 CROSS — derivation, and where it stops

CROSS's names: `A_u ∋ u⁺` inner `a`, outer `a′`; `A_v ∋ v⁻` inner `b`, outer `b′`; `{a, a′} ∩ {b, b′} = ∅`, so `P = {a, a′, b, b′}`; `u⁻`, `v⁺`
off (Q).
1. *Cones at `p`* (V5-U1, V5-QCOL): `T_a ⊂ [−30° + ℓ_u, 150°]`, `T_{a′} ⊂ [150° + ℓ_u, 330°]`, `T_b ⊂ [210°, 390° − ℓ_v]`, `T_{b′} ⊂ [30°, 210° − ℓ_v]`;
   each side cone holds neither colour of its arc and only one of the other two fits it: `(−30°, −30° + ℓ_u) ⊂ T_b`, `(150°, 150° + ℓ_u) ⊂ T_{b′}`,
   `(30° − ℓ_v, 30°) ⊂ T_a`, `(210° − ℓ_v, 210°) ⊂ T_{a′}` (so also `ℓ_u + ℓ_v ≤ 60°`).
2. *No tile of `p` has `y` in its closure* — stronger than CROSS's first clause, which therefore holds vacuously. A tip lies in `B(y, 1)`, so its
   cone at `p` lies in `[−90°, 90°]`: not `T_{b′}`, not `T_{a′}` (their side cones at `160°`-ish, `200°`-ish); `T_a`'s closure holds points of `A_u`
   beyond `u`, more than 1 from `y`; likewise `T_b`.
3. *Outer colours in `{a′, b′}`.* V5-OUT2 at `y = r(0°)`: an outer `c`-tile at `y` needs `T_c ⊂ [90°, 270°]`; `T_a ∋ (30° − ℓ_v, 30°)` and
   `T_b ∋ (330°, 330° + ℓ_u)` fail.
4. *Four colours.* With no tip, `y`'s colours are `X, X̄` and its outer colours: four means exactly `a′, b′`; the missing pair is `{a, b}`. The
   hypothesis "every tile at `y` a cone of positive angle" is not used.
5. *`p` on `y`'s ring.* `ω(y)` passes through `p` with tangent `90°/270°`, curving toward `y`. Its points are at distance 1 from `y`, which
   carries `X, X̄, a′, b′`, so they lie in no tile of those colours. Just clockwise of `p` on `ω(y)` (directions `→ 90°⁻`) the only tiles of `p`
   allowed are `T_a` and `T_{b′}` (by step 1), and `T_{b′}` is excluded; just counter-clockwise (`→ 270°⁺`), `T_b` or `T_{a′}`, and `T_{a′}` is
   excluded. So unless an edge of `p` runs along `ω(y)` at `p`, `y`'s ring is `a` just clockwise and `b` just counter-clockwise of `p`, both off
   `Γ`: `p` is a change point of `y`'s ring.
6. *`p`'s germs on `y`'s ring.* `p = y + e(180°)`, so `y`'s `u` and `v` for `p` are `y + e(240°) = v` and `y + e(120°) = u`; the tip pair
   `{u_y⁺, v_y⁻}` is the two germs outside `B(p, 1)` (at `v` along `330°`, at `u` along `30°`), the outer pair `{u_y⁻, v_y⁺}` the two inside.
   - *Tip pair on (Q).* At `v`, outside `B(p, 1)`, every tile has colour `X`, `X̄` or a colour of `P` on an outer tile at `v`, and V5-OUT2 at
     `v = r(−60°)` excludes `a` (`T_a ∋ (30° − ℓ_v, 30°) ⊄ [30°, 210°]`) and `b` (`T_b ∋ (330°, 330° + ℓ_u)`): every tile there has a colour of
     `y`. So `ω(y)` leaving `v` along `330°` meets no tile's interior: it is an edge of `Γ`, an arc of `ω(y)` whose two side colours are carried at
     `y`, which has four colours — a (Q) arc of `y`'s ring holds `u_y⁺`. The mirror at `u` puts `v_y⁻` on one too.
   - *Outer pair: the GAP.* `p` is a semi-hub of kind O of `y`'s ring iff `u_y⁻` and `v_y⁺` lie on no (Q) arc. At `v`, inside `B(p, 1)`, the tiles
     have colours `a, b, X, X̄` (`T_{a′}`, `T_{b′}` do not reach `v`: their side cones lie outside the half-plane `[−150°, 30°]` facing `v`), so
     `u_y⁻` lies on a (Q) arc only if `ω(y)` there is an edge with `X̄` inside `B(y, 1)` and `X` outside — and the first-order exclusions at `v`
     allow exactly that split (`X̄` only in directions `(−30°, 150°)` at `v`, `X` only in `(150°, 330°)`). What I can show: such an `X`-tile at `v`
     forces the edge `R | R′` at `y` to `150°` (else points of `R` near `y` and of that tile near `v` are at distance exactly 1), and the mirror at
     `u` forces it to `210°`, so **at most one** of `u_y⁻`, `v_y⁺` lies on a (Q) arc. I do not exclude one. With one, `p` is a closed change point of
     `y`'s ring, not a semi-hub.

**Verdict: GAP at "p is a semi-hub of kind O of the ring of y"** — every other clause derived (the first two vacuously or strictly stronger,
the positive-cone and radius-2 hypotheses unused in what I derived); the missing step is to exclude an arc of `ω(y)` through `v` (or `u`)
inside `B(p, 1)` with `X̄` on `y`'s side and `X` beyond.

### 3.5 Attacks (second group)

#### Attack on FS116-N3-SEMI

- *Degenerate cases.* A semi-hub with two colours: impossible (kind O has an outer colour, kind T a tip colour). An edge at `y` tangent to
  `ω(u)` or `ω(v)` but not on it: excluded wherever both its side colours are carried at the centre (the separation step); that is exactly when
  (b) fires. A (Q) arc longer than 60°: excluded by V5-NE1 on its inner tile.
- *Each hypothesis removed.* **Non-Siamese:** used throughout (one tile per colour at `y`; inner tiles are `p`'s). **Simple:** used in V5-DICHO
  (one sector per tile at `p`) and for the sector order at `y`. **Six colours:** at `k ≥ 7` a third absent colour can sit in the inner or outer
  half at `y` and alternative (b)'s edge is not forced.
- *Where the attack succeeds.* The nearest false statement: "a semi-hub of exactly three colours is full parallel" — (b) also occurs in the
  semi-hub's own derivation (every non-full case lands in (b)), so (c) cannot be dropped and (b) cannot either. And the colour in (c) is not the
  tile at `y` in kind O but `p`'s tile *opposite* `y`: a reader who took "the colour of the tile of `p` whose cone holds `ψ + 180°`" for the
  tip's colour would be wrong.

#### Attack on FS116-N3-PAIR

- *Each hypothesis removed.* **Non-Siamese** is the whole step "the inner tile is `p`'s tile": with Siamese pairs two inner tiles of one colour
  can be distinct and the statement is not derived (I build no counterexample). **Simple:** idle — a thin truth.
- *Where the attack succeeds.* The same statement for two (Q) arcs at germs of *different* pairs (e.g. `u⁻` and `u⁺`): not claimed, and not
  derived by this route (the germs are adjacent and the diameter step is silent).

#### Attack on FS116-N3-CROSS

- *Where the attack succeeds.* At the last clause (§ 3.4 step 6): an `X̄ | X` arc of `ω(y)` through `v` inside `B(p, 1)` is not excluded, and
  with it `p` is closed in `y`'s ring. This is a GAP in my derivation, not a counterexample: I built no fragment.
- *Thin parts.* The first clause holds vacuously (no tile of `p` reaches `y`); the hypotheses "every tile at `y` a cone of positive angle" and
  "radius above 2" are unused in every clause I derived.

### 3.6 The verdicts (second group)

verification: FS116-N3-SEMI
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) be a semi-hub of the ring of p; then y is a vertex of at least four colours, or y is a vertex of exactly three colours one of whose edges at y is an arc of the unit circle about r(ψ + 60°) or about r(ψ − 60°) whose two side colours are both carried at that centre, which is then a vertex of at least four colours, or y is a full parallel semi-hub of exactly three colours — the two absent at p and the colour of the tile of p whose cone holds ψ + 180° (kind O) or ψ (kind T) in its interior. *Not claimed:* that a semi-hub has four colours; that the third alternative occurs, or that it is excluded; anything at a closed change point (the disk's corner); Siamese or non-simple fragments; anything at `k ≥ 7`.
  given: the statement with its not-claimed line; § 13's setting words (its Notation paragraph) and notes; the rest of data/fs116/claims.md (§ 2's FS112-N3-NOBOTH, "The centre of a both-kind unit arc is a vertex with at least four colours or a repeated colour"; § 10's RING-GERM; § 11's GERM-R and GERM-S; § 13's note quoting FS114-N7-QOPP); data/fs114/claims.md; plans/FS114-derivation.md § 3's entry statements; plans/FS112-derivation.md's header and its U1 and NOBOTH entries (statements and their addresses); CLAUDE.md and the grokkings; that other minds worked the statement — no FS-116 record and no route of this statement; my own stage-2 results
  committed: 2026-10-03
  predicted: derived — 0.45 — likeliest break: the centre in (b) having four colours, or the colour named in (c)
  verdict: derived
  method: a case split by kind and by which germs of the other pair lie on (Q) arcs; the edges at y forced to the tangents of ω(u), ω(v) by first-order germ exclusions, the centre's four colours by V5-U1, and (c)'s colour by V5-DICHO's gaps and V5-OUT2; the first derivation's method not known until stage 4
  attack: § Attack on FS116-N3-SEMI
  divergences: none — the first derivation stays fenced until this commit; the table is stage 4's
  counterexamples: none — degenerate semi-hubs (two colours, tangent non-arc edges, long (Q) arcs) and the single-shared-colour pairs, by hand in § Attack on FS116-N3-SEMI and V5-DICHO
  minds: 2 — blind to: the proposing record's argument, every FS-116 record and every other mind's verdict (fenced until stage 4); method: not known until stage 4; blind, the same model (Opus 5.5)
  grade: hand

verification: FS116-N3-PAIR
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, if both germs of one pair at a change point of the ring lie on (Q) arcs and the two arcs have the same pair of colours, then the inner colour of each is the outer colour of the other. *Not claimed:* anything about two (Q) arcs not at one pair's germs.
  given: the statement with its not-claimed line; § 13's setting words (its Notation paragraph) and notes; the rest of data/fs116/claims.md (§ 2's FS112-N3-NOBOTH, "The centre of a both-kind unit arc is a vertex with at least four colours or a repeated colour"; § 10's RING-GERM; § 11's GERM-R and GERM-S; § 13's note quoting FS114-N7-QOPP); data/fs114/claims.md; plans/FS114-derivation.md § 3's entry statements; plans/FS112-derivation.md's header and its U1 and NOBOTH entries (statements and their addresses); CLAUDE.md and the grokkings; that other minds worked the statement — no FS-116 record and no route of this statement; my own stage-2 results
  committed: 2026-10-03
  predicted: derived — 0.8 — likeliest break: the inner tile of a (Q) arc not being p's own tile
  verdict: derived
  method: the inner tiles are p's (non-Siamese), and one tile of p along both germs would have closure points more than 1 apart (V5-NE1); the first derivation's method not known until stage 4
  attack: § Attack on FS116-N3-PAIR
  divergences: none — the first derivation stays fenced until this commit; the table is stage 4's
  counterexamples: thin truth: PAIR with "simple" deleted — the derivation never uses simplicity
  minds: 2 — blind to: the proposing record's argument, every FS-116 record and every other mind's verdict (fenced until stage 4); method: not known until stage 4; blind, the same model (Opus 5.5)
  grade: hand

verification: FS116-N3-CROSS
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours, let y = r(ψ) be a crossed full semi-hub of kind O of the ring of p, u⁺ on a (Q) arc of inner colour a and outer colour a′ and v⁻ on one of inner colour b and outer colour b′; then every tile of p at y has a cone at y of zero angle, and the outer colours at y lie in {a′, b′}; if y has four colours and every tile at y a cone of positive angle at y, its outer colours are a′ and b′ and its missing pair is {a, b}, and, unless an edge of p runs along ω(y) at p, p is a change point of the ring of y, that ring being b just counter-clockwise of p and a just clockwise, and p is a semi-hub of kind O of the ring of y. *Not claimed:* that y has four colours; that p is a crossed semi-hub of y's ring; anything about y's ring away from p; anything at `k ≥ 7`.
  given: the statement with its not-claimed line; § 13's setting words (its Notation paragraph) and notes; the rest of data/fs116/claims.md (§ 2's FS112-N3-NOBOTH, "The centre of a both-kind unit arc is a vertex with at least four colours or a repeated colour"; § 10's RING-GERM; § 11's GERM-R and GERM-S; § 13's note quoting FS114-N7-QOPP); data/fs114/claims.md; plans/FS114-derivation.md § 3's entry statements; plans/FS112-derivation.md's header and its U1 and NOBOTH entries (statements and their addresses); CLAUDE.md and the grokkings; that other minds worked the statement — no FS-116 record and no route of this statement; my own stage-2 results
  committed: 2026-10-03
  predicted: derived — 0.35 — likeliest break: the clause on tiles of p at y, or the description of y's ring at p
  verdict: gap: p is a semi-hub of kind O of the ring of y — an arc of ω(y) through v (or u) inside B(p, 1) with X̄ on y's side and X beyond, which would put a (Q) arc on the outer pair, is not excluded (at most one of the two is); every other clause derived
  method: V5-U1's cones at p put every side cone in a named tile, so no tile of p reaches y and V5-OUT2 removes a, b from y's outer colours; y's ring at p read through the four tiles' ranges; the first derivation's method not known until stage 4
  attack: § Attack on FS116-N3-CROSS
  divergences: none — the first derivation stays fenced until this commit; the table is stage 4's
  counterexamples: thin truth: CROSS's first clause — no tile of p has y in its closure at all, so it holds vacuously; thin truth: the hypotheses "every tile at y a cone of positive angle" and "radius above 2" — unused in every clause derived
  minds: 2 — blind to: the proposing record's argument, every FS-116 record and every other mind's verdict (fenced until stage 4); method: not known until stage 4; blind, the same model (Opus 5.5) — for the clauses derived; the last clause has no second mind here
  grade: hand
