# FS116-V5 — a blind second mind on eight statements of FS-116's list (§§ 12–14)

*Job FS116-V5 (Ephodos, verification form; blind, the same model as the minds whose work it may later compare against, Opus 5.5).
Brief: `data/fs116/briefs/FS116-V5-verify.md`, with `plans/STANDING-RULES.md`. Started 2026-10-03 15:37 UTC.*

## Theorems this phase proved

*(Filled stage by stage; each line a statement, its grade and its address.)*

- Stage 1 proves nothing.

## "Would have searched here" log

*(The ban ran to 2026-10-01 and the standing rules still carry it; this job runs no search in any case: every check is a hand derivation or an
exact computation at named points.)*

- none yet.

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
