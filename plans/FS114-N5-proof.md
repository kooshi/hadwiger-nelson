# FS114-N5 — FS-114's proof side, round 4: finishing K1 (K1-ΓRING, K1-PIN)

*Job FS114-N5, de Bruijn (Opus 5.5), launched 2026-09-28 09:03 UTC at HEAD `07af44a0`. Brief `data/fs114/briefs/N5-114-proof-round4.md`, with the
cards `data/fs114/briefs/ROUND4-card.md`, `ROUND3-card.md`, `ROUND2-card.md`, FS114-N's brief `data/fs114/briefs/N114-proof.md` and
`data/fs114/briefs/STANDING-RULES.md` (rule 0 read first). Working files `data/fs114/fs114-n5/`; exact checks `tools/fs114_n5_*.py`; scratch
`scratchpad/fs114-n5/` (my own subdirectory). Resuming check: no record existed at start. Notation is FS114-N's, N2's, N3's and N4's
(`plans/FS114-N-proof.md` header and § Continuation; `plans/FS114-N3-proof.md` header and §2; `plans/FS114-N4-proof.md` header): tiles, `ω(x)`,
`P_cl(x)`, `Γ`, `F`, `R`, close / far (N114-FAR), a **tactic edge** (a whole unit arc on `ω(q)`, inner tile `x` with `q ∈ cl x`, and a tile of the
outer tile's colour — the **partner** — touching `x` at `q` alone), the **ring** `ω(p)`, a **change point**, a tile's **cone** at a vertex, the
patterns `+`/`−` and the inner counts (N3-SEC), N-E0, N-E1, N-E2 (`plans/FS110-N-proof.md` §1.4), N3-FACE, N3-HALF, N3-SEC, N3-FLANK, N3-PAIR, N3-ODD,
N4-OWN, N4-LENS, N4-OPP, N4-TANG. `e(φ)` is the unit vector at angle `φ`. All statements are for **non-Siamese** valid maps (no two distinct tiles of
one colour close) unless said otherwise, in the **simple class** where N3's lemmas need it (a tile's cone at a vertex is one closed interval; a tile
never touches itself). **FS112-L60 is used only in its corrected form, "at most 60°"** (FS114-L60).*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| N5-QT | Every quotation my brief and the round-4 card rely on, where its source is open to me, is found (19 of 19); the card's summaries compared by hand, one scope clause dropped (N4-FIVE's "with the lune rings free of `Γ`") | [tools] | §1.2; `tools/fs114_n5_quotes.py` |
| N5-BEND | In the Reuleaux bowtie (non-Siamese, simple), every Γ-arc of `ω(p)` in a lune ring can be removed by FS112-N2-TOWARD / N2-AWAY / N2-TAN (two minds each) keeping validity, the four tactic edges, their partners and the caps, **except** arcs of outer colour 4 (in the top lune) whose inner side is `t2` — (Q) arcs — or an absent colour with an inner-colour tile along the radius-2 circle over the arc — (R2) arcs, each of angular length at most `2 arcsin(1/4) ≈ 28.96°`. Reads a neighbourhood of `B̄(p, 2)` | [hand, one mind, over N2-TOWARD, N2-AWAY, N2-TAN at their grade] | §2.1 |
| N5-KAPPA | After N5-BEND, with `κ(θ)` the colour of the ring point `e(θ)` or of the inner side of the (R2) arc through it (undefined on (Q) arcs): `κ(θ + 60°) ≠ κ(θ)` wherever both are defined; two ring Γ-arcs are never 60° apart; an arc never contains `top` in its interior; and without (Q) arcs `κ` changes colour at most once in `(30°, 90°)` (**N5-ONE**: two change points in all, `s` and `s + 60°`, or one, at `top`) | [hand, one mind] | §2.2 |
| N5-DR1 | N3-DR1 in this setting: without (Q) arcs and with `κ` changing at `y′ = e(s)`, `y″ = e(s + 60°)`, `t2` reaches `y′` or `y″`, and `z4` reaches `y′` or `z4′` reaches `y″` | [hand; one mind here, N3's and N4's the Γ-free form] | §2.2 |
| **N5-UP** | Let `T` be a tile at `top` whose cone contains the direction 90° (straight out). Then `colour(T) ∈ {4, 5, 6}`, `T` is not `q1`'s or `q3`'s tile of its colour, and every tile of `T`'s colour at `q1` or `q3` misses `B(top, 1)`. Since `q1` carries its ring colour `X` (and `q3` its `X′`) by a tile meeting `B(top, 1)`, **`colour(T) ∉ {X, X′}`**, and if `colour(T) = 4` then `z4`, `z4′` miss `B(top, 1)` | [hand, one mind; tools exact at named points] | §2.3; `tools/fs114_n5_ring.py` |
| **N5-DEG** | If the two corners of a lune carry different ring colours (`X ≠ X′`), the lune's ring is free of Γ after N5-BEND and the lune is N4's degenerate member: **excluded at radius `√3` by N4-D** | [hand, one mind, over N5-BEND, N5-UP, N4-FIVE, N4-D] | §2.3 |
| N5-W | If `X = X′` and the up-tile `T` has colour 4, the lune's ring is free of Γ after N5-BEND and the lune is N4's general member | [hand, one mind] | §2.3 |
| N5-XBAR | In the residual (`X = X′`, `T` of colour `X̄`): at most one of `q1`, `q3` carries `X̄`; if `q1` does (tile `V1`), then `V1 ∩ B(top, 1) = ∅`, `κ ≠ X̄` on `(30°, 90°)`, a (Q) arc `(a, 90°)` with inner `t2` and outer `z4` ends at `top`, `z4 ⊂ B̄(q1, 1) ∩ B̄(top, 1)` has its cone at `q1` in `[60°, 120°]`, and `T` touches the ring just after 90° | [hand, one mind] | §2.4 |
| **N5-R0** | The residual with no `X̄` at either corner has corners `t1 | C | z4 | U1` and `t3 | C′ | z4′ | U3` (degree 4, `C` of colour 3, `C′` of colour 1); **if `C ∋ q2` and `C′ ∋ q4` it does not exist at radius `√3`** (`t2 ∌ top`; `T` touches the ring on both sides of `top`, so misses `P90`, `P90′`; then N4-G's diameter kill at whichever side `t2` reaches, and N5-DR1 if it reaches neither) | [hand, one mind; tools exact at named points] | §2.4 |
| **N5-ΓRING** | **K1-ΓRING reduced**: a Reuleaux bowtie whose lune rings carry arcs of `ω(p)` (non-Siamese, simple class) does not exist on the closed disc of radius 2 about `p` unless a lune is in the residual **(R-V)** of N5-XBAR (one corner carries both absent colours; a (Q) arc `t2 | z4` ends at the lune's ring midpoint): every lune is degenerate (N4-D), general (N4-G), or (R0) (N5-R0), and every pair of lunes not involving (R-V) dies | [hand, one mind, over N4-D, N4-G at N4's grade (one mind each)] | §2.5 |
| N5-SIGHT | (N3-FACE in the form N5-UP uses, for any configuration) If `|u − v| = 1` and a tile `T` at `u` has a cone not contained in the closed half-plane facing `v`, then `T`'s colour is carried at `v` by no tile meeting `B(u, 1)` | [hand, one mind] | §3.1 |
| **N5-RV** | (R-V) walked to `P90` (one corner, `q1`, carrying `X̄`; `C′ ∋ q4` at the other): `V1 ∌ P90`; `q1`'s cap tile is `V1`, its cone contains `[300°, 0°]`, and `q1 = t1 | V1 | (W3) | z4 | U1`; `P90` carries only colours 1, 3 and 4, the half-plane `(0°, 180°)` at `P90` only 1 and 3; `T ∋ P90′`. **Not excluded: K1-ΓRING is GAP at (R-V)** | [hand, one mind] | §3.2 |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|
| enumerate ring patterns of a lune with Γ-arcs (side colours, positions) | reduced them by FS112's bends to two arc types, and read the alternation `κ(θ + 60°) ≠ κ(θ)` by hand (N5-KAPPA, N5-ONE) |
| scan which tile can cover the direction straight out at `top` | one lemma, N5-UP, from N3-FACE at the two unit distances `q1–top`, `q3–top` |

## Fence log (standing rule 13; brief § Fences)

1. **The harness's start-up context** (not a command of mine) included the auto-memory index, a file under `~/.claude/projects/-home-kooshi-source-lean-dir/`
   (fenced). Its lines name milestone status and standing rules; no proof content. The start-up git status printed the untracked names
   `data/fs114/briefs/Y4-114-construction-round4.md`, `data/fs111/fs111-m2/*`, `data/fs111/fs111-w/*`, `tools/fs111_m2_disck7.py` and five commit
   subjects (FS114-L60, FS111-M2). Names and subjects only.
2. At start-up `ls data/fs114/briefs/` with `wc -c` printed the **names and sizes** of every brief, the construction side's among them (`Y114-…`,
   `Y2-…`, `Y3-…`, `Y4-114-construction-round4.md`, `YB…`, `NB4-114-instance.md`), the verifiers' and the advisor's. None opened except mine, the three
   cards, FS114-N's and `STANDING-RULES.md`.
3. `ls plans/FS114*` and `ls data/fs114/` printed the **names** `plans/FS114-Y-construction.md`, `FS114-Y2-construction.md`, `FS114-Y3-construction.md`,
   `FS114-YB-verification.md`, `FS114-YB2-verification.md`, `FS114-NB-verification.md`, `FS114-close-inventory.md` and the directory names `fs114-y`,
   `fs114-y2`, `fs114-y3`, `fs114-yb`, `fs114-yb2`, `fs114-nb`, `reports`. Contents not listed or opened. (No `FS114-NB4` record or directory existed then.)

## Stage 1 — SAVED: reading, the quotation check

### 1.1 Read from disk (G50)

- `data/fs114/briefs/STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim and § Counter-priors (loaded at start-up; the file is the project's
  instructions); my brief, `ROUND4-card.md`, `ROUND3-card.md`, `ROUND2-card.md`, `N114-proof.md` — all in full.
- `plans/FS114-N4-proof.md` in full; `plans/FS114-N3-proof.md` in full; `data/fs114/claims.md` in full.
- `plans/FS114-N-proof.md`: header, theorem table (FS114-N and N2 rows), logs, §1.3 (N114-FAR, anchoring), §N2-2.1 to §N2-2.3 (N2-ABS, N2-SLACK,
  N2-ENDS, N2-VCAP, N2-DIAM, N2-KILL).
- `plans/FS114-L60-audit.md`: header, theorem table, logs, the proposed statement (§1.3's end), L60-WALK's verdict line.
- `plans/FS114-CV-verification.md` and `plans/FS114-CVB-verification.md`: theorem tables and the CV/CVB reconciliation table (A-1 to A-12, B-1, B-2).
- `plans/FS110-N-proof.md` §1.4: N-E0, N-E1, N-E2 in full.
- `plans/FS112-derivation.md`: header and the entry titles of §§1–4; U1, SIX, NB4P, A4SIX, L60, LOCK in full.
- `LEDGER.md` rows 134–136 (statements and grades).
- Tools read, not run: `tools/fs114_n4_quotes.py` (my side's, as a model).

### 1.2 The quotation check (standing rule 5)

`tools/fs114_n5_quotes.py` checks 19 statements with whitespace collapsed and `**` removed, nothing else normalised: **19 of 19 FOUND**
(`data/fs114/fs114-n5/quotes.out`, exit 0). **Plant:** the corrected L60 statement with "at most 60°" changed to "below 60°" is NOT FOUND and its faithful
twin FOUND (`quotes-plant.out`, exit 0) — the plant is the old, false form of L60, which my brief forbids. By hand, the card's restatements against the
sources' words:
- Card 4's L60 ("at most 60°, not below; at 60° both side tiles lie in the lens of its ends"): faithful to FS114-L60's proposed statement.
- Card 4's "The chain N2-RED → COR3 → N3-BASE → DENSE3 → CV-EXISTS is intact (one mind)": faithful to L60-WALK (one mind).
- Card 4's N4-BOWTIE: faithful. **Card 4's N4-FIVE** ("five colours at a corner iff the lune's ring is degenerate, otherwise four") drops the source's scope
  "With the lune rings free of `Γ`"; the card carries that scope one line earlier (N4-BOWTIE). Noted; I use the source's form.
- My brief's "N4's three moves (sector orders, the lens N4-LENS empties, a diameter)": faithful to N4 §5.2. "The pinwheel (each tile inner for one edge)" and
  "the `(2, 1, 1, 0)` patterns": faithful to N3-SEC's pattern list (`++++` four rotational; `+++−`, `++−−` one lens, two rotational, one anti-lens).
- **Not checkable:** FS114-Y2-GAPS, FS114-Y2-BOWTIE, FS114-Y3-RSTOP, Y3-R's E1/E2, Y3-D2, YB2-EMPTY13 come from the construction side's records, fenced from me.
  I use them at the cards' wording and grade only.

## Stage 1 — SAVED

## Stage 2 — SAVED: K1-ΓRING — the bends, the alternation, the up-tile, and the residual

*Frame N4's (`plans/FS114-N4-proof.md` §2): `p = 0`, `t1 = Reul(p, q1, q2)` (colour 1), `t3 = Reul(p, q3, q4)` (colour 3), `q1 = e(30°)`, `q2 = e(−30°)`,
`q3 = e(150°)`, `q4 = e(210°)`, `t2` (colour 2) in the top lune with cone `[60°, 120°]` at `p`, `t4` (colour 4) in the bottom lune; partners `z4` (colour 4)
at `q1`, `z4′` at `q3`, `z2` at `q2`, `z2′` at `q4`; absent colours at `p`: 5, 6. `top = e(90°)`, `P90 = q1 + e(90°)`, `P90′ = q3 + e(90°)`, the lens
`L1 = B(q1, 1) ∩ B(top, 1)` and its part `Δ` outside `B̄(p, 1)` (near `P90` the wedge `(180°, 300°)`). The top lune is worked; the bottom lune is its mirror in
the horizontal axis (colours 2 ↔ 4, `q1 ↔ q2`, `q3 ↔ q4`). Every metric fact at a named point is checked in `tools/fs114_n5_ring.py`
(`data/fs114/fs114-n5/ring.out`, 30 lines OK; plant `--plant`, `top` moved to `e(80°)`, fails exactly the six lines resting on `|q1 − top| = |q3 − top| = 1` and
the wedge at `top`, `ring-plant.out`).*

### 2.1 N5-BEND — only two kinds of ring arc survive the bends

A Γ-arc `α` of `ω(p)` in the top lune's ring (an edge with constant sides) has inner side `t2` or an absent colour (a tile meeting `B(p, 1)` has a colour absent
at `p` or is a tile at `p`; only `t2` of those lies in the top lune), and outer side of colour 4, 5 or 6 (U1 at `p`: an outer colour in `{1, 2, 3}` needs its
`p`-cone facing away from `α`, which `[300°, 60°]`, `[60°, 120°]`, `[120°, 240°]` never do for `α` in `(30°, 150°)`).
- Outer colour 5 or 6 (absent at `p`): **FS112-N2-TOWARD** bends the whole arc toward `p`, recolouring a thin lens inside `α` (in `T_in`'s sectors at the ends)
  with the outer colour; validity kept, no unit arc created, the ends fixed.
- Outer 4, inner 5 or 6, and no inner-colour tile along the radius-2 circle over any sub-arc: **N2-AWAY** (and **N2-TAN** at isolated contacts) bends it away.
- What is left: **(Q) arcs** — inner `t2`, outer colour 4 — and **(R2) pieces** — outer 4, inner `X ∈ {5, 6}`, an `X`-tile along the radius-2 circle over the
  piece. One `X`-tile carries a connected piece (two would touch, hence be close); its diameter is at most 1, so the piece's angular length is at most
  `2 arcsin(1/4) ≈ 28.96°`.
- **What the bends keep.** They recolour lenses touching `ω(p)` inside the lune or just outside it, away from the edges at `p`, the caps, `t1`, `t3` and the
  partners' contacts at the corners (an away-lens at a corner takes a corner of angle `ψ → 0` from the outer tile's sector, which keeps a sector there). The
  non-Siamese property survives (a new pair at distance `< 1` would, with the old pairs `> 1`, put 1 in an interval of distances — the bend is valid). The simple
  class survives (the lens joins the outer tile along the arc, next to its sector).
- **Colour 4 outside the ring.** A colour-4 tile touching the ring at `e(θ)`, `θ ∈ (30°, 90°)`, has points within `< 1` of `q1`, so it is `z4` (the colour-4 tile
  at `q1`); on `(90°, 150°)` it is `z4′`; `z4 ≠ z4′` (a tile holding `q1` and `q3` has diameter `√3`).
*Reads:* a neighbourhood of `B̄(p, 2)` (the bends' validity reads the unit discs about lens points; `R₂(α)` is the radius-2 circle). **Setting B** below is the
bowtie after these bends.

### 2.2 N5-KAPPA, N5-ONE, N5-DR1 — the alternation survives the (R2) arcs

`κ(θ)`: the colour of `e(θ)` if interior to a tile (5 or 6, by N-E1 at `p`), the inner colour of the (R2) arc through `e(θ)`, undefined on (Q) arcs.
1. *`κ(θ + 60°) ≠ κ(θ)`.* Interior–interior: N-E0. Interior at `θ + 60°`, arc at `θ`: `ω` of points of the interior tile near `e(θ + 60°)` crosses `ω(p)`
   transversally near `e(θ)` (two unit circles 1 apart meet at 60°) and so enters both side tiles there; its colour differs from both (N-E0). Arc–arc: the same
   gives disjoint side sets, impossible as both contain 4. So **two ring Γ-arcs are never 60° apart**.
2. *No arc contains `top` in its interior:* its outer tile would be `z4` and `z4′` at once.
3. *N5-ONE.* All `X̄`-tiles touching ring points in an open 60° window are one tile (their points are within `< 1`, so they are close). Without (Q) arcs, if `κ`
   changed at `c₁ < … < c_m` in `(30°, 90°)` with `κ(30°+) = X` and `m ≥ 3`, the `X̄`-tiles on `(c₁, c₂)`, on `(c_m, c₁ + 60°)` and on `(c_{m−1} + 60°, c_m + 60°)`
   would be one tile (consecutive pieces are within 60°) touching `e(c₁)` and `e(c_m + 60°)`, more than 1 apart. So `κ` changes once in `(30°, 90°)` (general:
   `s`, `s + 60°`) or not at all (degenerate: once, at `top`).
4. **N5-DR1.** General `κ` without (Q) arcs: `U1` (the `X`-tile on `(30°, s)`, which holds `q1`), `U2` (`X̄` on `(s, s + 60°)`, holding `y′`, `y″` in its closure,
   so `U2 ⊂ B̄(y′, 1) ∩ B̄(y″, 1)`), `U3` (`X` on `(s + 60°, 150°)`). With `τ = e(s + 30°)`, the points `y′ ± tτ`, `y″ ± tτ` are pairwise 1 apart in the pairs
   `(y′ + tτ, y″ + tτ)`, `(y′ − tτ, y″ − tτ)` and miss `U2`. So in each pair one point is in a tile of colour neither `X` nor `X̄`: inside `B(p, 1)` that is `t2`,
   outside it is `z4` near `y′` or `z4′` near `y″` (colours 1, 2, 3 are excluded outside by N3-FACE against `t1`, `t2`, `t3`). As N3-DR1: **`t2` reaches `y′` or
   `y″`; `z4` reaches `y′` or `z4′` reaches `y″`.** (R2) arcs change nothing: the rays leave the ring at 30° to its normal and the argument reads only colours.
*Reads:* the closed disc of radius `1 + ε` about `p`.

### 2.3 N5-UP — the tile straight out at `top`

**N5-UP [hand, one mind].** Let `T` be a tile at `top` whose cone contains the direction 90°.
- `T` is none of `t1, …, t4` (`t2 ⊂ B̄(p, 1)` has its cone at `top` in `[180°, 360°]`; the others miss `top`). A tile of colour 1, 2 or 3 at `top` other than
  `t1`, `t2`, `t3` would be far from it, so by N3-FACE at the unit pair `(p, top)` that tile's cone at `p` would lie in `{v · e(90°) ≤ 0}` — false for
  `[300°, 60°]`, `[60°, 120°]`, `[120°, 240°]`. So `colour(T) ∈ {4, 5, 6}`.
- If `q1` carries `T`'s colour by a tile `T′`: `T′ = T` would put `T ⊂ B̄(q1, 1)` and its cone at `top` in `[240°, 60°]`, which misses 90° (`q1 − top = e(−30°)`,
  tools). So `T′ ≠ T`, they are far, and **`T′ ∩ B(top, 1) = ∅`** (N-E2 at the unit pair `(q1, top)`). Likewise at `q3` (`q3 − top = e(210°)`).
- `q1` carries its ring colour `X` by a tile meeting `B(top, 1)`: the ring branch at `q1` lies in an absent-colour tile `T_R` or on a Γ-arc whose inner tile `S`
  sits in the sliver (N3-FLANK); either tile has interior points near `e(30° + η)`, within `< 1` of `top` (tools). Likewise `X′` at `q3`. So **`colour(T) ∉ {X, X′}`**.
- If `colour(T) = 4`, then `z4`, `z4′` miss `B(top, 1)`. ∎ *Reads:* `q1, q3, top, p` (four points of `F`), radius `1 + ε`.

**N5-DEG [hand, one mind].** Let `X ≠ X′`. Then `T` has colour 4, so `z4`, `z4′` miss `B(top, 1)`; in setting B every ring arc has outer tile `z4` or `z4′` with
points just outside `e(θ)`, `θ ∈ (30°, 150°)`, within `< 1` of `top` — so **the ring is Γ-free**. With a Γ-free ring N4-FIVE's dichotomy applies: the general
member has `X` at both corners, so this is the degenerate member, which **N4-D excludes at radius `√3`**. ∎ (N4-D reads the top lune and the partners only.)

**N5-W [hand, one mind].** `X = X′` and `colour(T) = 4`: the same step makes the ring Γ-free, and N4-FIVE makes it the general member. ∎

So in each lune: **degenerate** (dies alone, N4-D), **general** (Γ-free; N4-G kills it when the other lune's corner caps are right, below), or the **residual**:
`X = X′` and `T` of colour `X̄`.

### 2.4 The residual

**N5-XBAR [hand, one mind].** Residual; suppose `q1` carries `X̄` by `V1`. `V1 ≠ T` (N5-UP), so `V1 ∩ B(top, 1) = ∅` and `V1`'s cone at `q1` lies in
`[240°, 60°]`. An `X̄`-tile touching `e(θ)`, `θ ∈ (30°, 90°)`, is within `< 1` of `q1`, hence is `V1`, which cannot come within `< 1` of `top`: so `κ ≠ X̄` on
`(30°, 90°)`. `κ(90°−)` (if defined) is paired with `κ(150°−) = X` and must be `X̄`: so `90°−` lies in a (Q) arc `(a, 90°)` — `t2 ∋ top`, `z4 ∋ top`, so
`z4 ⊂ B̄(q1, 1) ∩ B̄(top, 1)`, cone at `q1` in `[60°, 120°]` (facing `top`, and outside `B(p, 1)`), at `top` in `[0°, 60°]`. Then `90°+` is not in a (Q) arc
(`z4′` would touch `z4` at `top`), so `κ(90°+) = X̄` (paired with `κ(30°+) = X`), and its tile holds `top`: it is `T`. The mirror argument at `q3` would put a
(Q) arc `(90°, b)` at `top` too, with `z4′ ∋ top`: so **at most one corner carries `X̄`**. ∎

**The corners with no `X̄`.** If `q1` carries no `X̄`: its sliver `(120°, 180°)` lies in `B(p, 1)` and holds only absent colours, so it is `U1` alone (the `X`-tile),
which borders `t1` along `ω(q2)` (N4-TANG applies); the cap tile has colour in `{3, 5, 6}`, is not `U1` (simple class: `U1`'s cone would run from 300° round to
180°, leaving no room for `z4`), and not `X̄`: **colour 3**, `C`. No colour is left: **`q1 = t1 | C | z4 | U1`, degree 4** — N4-FIVE's general corner. Mirror at
`q3`: `t3 | C′ | z4′ | U3`, `C′` of colour 1.

**N5-R0 [hand, one mind; tools exact].** *Residual, neither corner carrying `X̄`, and `C ∋ q2`, `C′ ∋ q4`: no valid fragment on the closed disc of radius `√3`.*
`C ∋ q2` puts `C ⊂ B̄(q2, 1)`, its cone at `q1` in `[180°, 360°]`, so `z4` starts at `≤ 0°`. **The P90 step** (N4-G's, with the lens emptied colour by colour):
if colour 2 is excluded near `P90`, then `Δ` near `P90` lies in `z4 ∪ T ∪ Γ` — colour 1: only `t1`; 3: only `C` (N4-LENS at `q1`), which misses `P90`
(`|P90 − q2| = 2`); `X`: only `U1`, which misses `P90` (N4-TANG); 4: only `z4`; `X̄`: only `T` (N4-LENS at `top`; `q1` has no `X̄`). And if `z4` meets `Δ` near
`P90` with `T` absent there, `z4 ∋ P90` makes its cone at `q1` start at exactly 0°, and N4-G's diameter step (a point at direction 5°, one at `(1 − ε)e(95°)`)
kills it.
1. *`t2 ∌ top`.* Otherwise colour 2 is excluded near `P90` and `P90′` (N4-LENS at `top`); so `T ∋ P90` and, by the mirror, `T ∋ P90′`: `|P90 − P90′| = √3`.
2. *`T` touches the ring on both sides of `top`.* No (Q) arc ends at `top` (step 1), so `κ(90°±)` are defined, paired with `κ(150°−) = κ(30°+) = X`: both `X̄`, by
   tiles holding `top`, i.e. by `T`. So `T ⊂ B̄(e(t), 1)` for some `t > 90°` and some `t < 90°`, and `|P90 − e(t)| > 1` for `t > 90°` (`|P90 − e(t)|² =
   4 − 2√3 cos(t − 60°)`, tools): **`T` misses `P90` and `P90′`.**
3. If `t2` reaches a ring point in `(30°, 90°)`, colour 2 is excluded near `P90` (a second colour-2 tile is far from `t2`, and `P90` is within `< 1` of that point),
   so `z4` alone fills `Δ` near `P90`: dead. Mirror if it reaches `(90°, 150°)`. If it reaches neither, there is no (Q) arc, `κ` is general (step 2 and the
   corners), and N5-DR1 makes `t2` reach `y′` or `y″`: dead. ∎
*Reads:* the closed disc of radius `√3` about `p`; the points `p, q1, q2, q3, q4, top, P90, P90′`.

### 2.5 N5-ΓRING — what K1-ΓRING comes to

Each lune is degenerate (dies alone), general, (R0), or **(R-V)** — the residual with one corner, say `q1`, carrying `X̄` (N5-XBAR). N4-G kills a general lune
and N5-R0 an (R0) lune as soon as the other lune's corners have the caps of colour 3 at `q2` and 1 at `q4`; a general or (R0) lune supplies exactly those caps
(mirror of "the corners with no `X̄`": `q2 = t1 | C | z2 | U1_b`). So **every pair of lunes dies except those with a lune in (R-V)** (a pair (R-V) with anything,
or an (R0)/general lune facing an (R-V) lune whose corner at `q2` or `q4` carries no colour 3 or 1 there).

**(R-V), named (the survivor of this stage).** `q1` carries `X̄` (`V1`, cone in `[300°, 60°]`, missing `B(top, 1)`), a (Q) arc `(a, 90°)` — `t2` inside, `z4` outside —
ends at `top`; `z4 ⊂ B̄(q1, 1) ∩ B̄(top, 1) ∖ B(p, 1)` (the Reuleaux cap over the ring arc `q1–top`), its cone at `q1` in `[60°, 120°]`; `T` (`X̄`) holds `top` and
the ring just after it; `q3 = t3 | C′ | z4′ | U3`. It is the construction side's escape **E2** in shape (a tile at `q1` — here `z4` — whose sector starts after
60°, of a colour with no tile at `q2`: `4 ∉ P_cl(q2)` by N4-OWN), reached from the proof side with a Γ-arc on the ring. Stage 3 walks it.

## Stage 2 — SAVED

## Stage 3 — SAVED: the residual (R-V) walked to `P90`, and one tool

### 3.1 N5-SIGHT

**N5-SIGHT [hand, one mind].** *If `|u − v| = 1` and a tile `T` at `u` has a cone not contained in `{w : w · (v − u) ≥ 0}`, then no tile at `v` meeting
`B(u, 1)` has `T`'s colour.* A tile of that colour at `v` is `T` (then `T ⊂ B̄(v, 1)`, cone facing `v`) or far from it (then it misses `B(u, 1)`, N-E2). ∎ It is
N3-FACE read at the target point; N5-UP is its instance at `(top; q1, q3)`. *Warning, recorded because I made the slip and caught it:* a tile at `v` meets
`B(u, 1)` only when its cone at `v` meets the open half-plane facing `u` (or it has points there otherwise) — `t4` at `p` does not meet `B(top, 1)`, which is why
the degenerate member's `W` (colour 4 at `top`) exists. *Reads:* `u`, `v`.

### 3.2 N5-RV — (R-V) at `P90`

*Setting (R-V1), from N5-XBAR: `q1` carries `X̄` (`V1`, cone in `[300°, 60°]`, `V1 ∩ B(top, 1) = ∅`); the (Q) arc `(a, 90°)` (`t2` inside, `z4` outside) ends at
`top`; `z4 ⊂ B̄(q1, 1) ∩ B̄(top, 1) ∖ B(p, 1)` (cone `[60°, 120°]`-bounded at `q1`, `[0°, 60°]`-bounded at `top`); `T` (`X̄`) holds `top`, its cone at `top` in
`[60°, 240°]` (far from `V1`), crossing the ring at `90°+`; `q3 = t3 | C′ | z4′ | U3`; and `C′ ∋ q4` (the bottom lune's corner cap at `q4` of colour 1).*
1. *`T ∋ P90′`.* Near `P90′` the lens `B(q3, 1) ∩ B(top, 1)` outside `B̄(p, 1)` holds: colour 1 only in `C′` (N4-LENS at `q3`), which lies in `B̄(q4, 1)` and misses
   `P90′`; 2 nothing (`t2 ∋ top`); 3 only `t3`; 4 nothing (`z4′` at `q3`, `z4` at `top`, different: N4-LENS both ways); `X` only `U3` (N4-TANG, mirror); `X̄` only
   `T`. So `T` fills it: `T ⊂ B̄(P90′, 1)`, and `T ∌ P90` (`|P90 − P90′| = √3`).
2. *What `P90` can carry.* By N5-SIGHT at `(P90; q1, top)` and N4-LENS: colour 2 nowhere (a second colour-2 tile misses `B(e(θ), 1)`, `θ ∈ (a, 90°)`, which
   holds `P90`); `X` nowhere (`U1` meets `B(P90, 1)` near `e(30°+)` and misses `P90`, N4-TANG); `X̄` nowhere (`T` meets `B(P90, 1)` — its points near `top` in the
   directions `(60°, 120°)` — and misses `P90`; `V1` is excluded in item 3); 4 only `z4` (which meets `B(P90, 1)`: `z4` lies in `Reul(q1, top, P90)`), with cone at
   `P90` in `[180°, 300°]`. **So `P_cl(P90) ⊆ {1, 3, 4}`, and the half-plane `(0°, 180°)` at `P90` — outside `B̄(q1, 1)` — carries only colours 1 and 3** (at most
   one tile each).
3. *`V1 ∌ P90`.* `ω(P90)` passes through `top` in the directions 120° and 300°, curving toward `P90`; near `top` it enters `T` (direction `120° − ε`, inside `T`'s
   cone). If `V1 ∋ P90`, `X̄ ∈ P_cl(P90)` and N-E1 at `P90` forbids that.
4. *The sector `(300°, 360°)` at `P90`* (inside `B(q1, 1)`, outside `B̄(top, 1)`) holds a tile of a colour of `P_cl(q1)` only if it is `q1`'s tile of that colour
   reaching `P90` — `t1`, `U1`, `z4` (cone at `P90` in `[180°, 300°]`), `V1` (item 3) cannot — or a colour absent at `q1`: 2 is excluded, so **colour 3**.
5. *The cap tile is `V1`.* The cap tile (the tile after `t1` at 300°) has colour 3 or `X̄`. If it were `q1`'s colour-3 tile `W3`, then — 3 being in `P_cl(q1)` —
   the colour-3 tile filling the sector `(300°, 360°)` at `P90` (item 4) would be `W3` (a colour-3 tile meeting `B(q1, 1)` is `W3`), so `W3 ⊂ B̄(P90, 1)` and its
   cone at `q1` would lie in `[0°, 180°]`, against its start at 300°. So the cap tile is `V1`, and **`q1 = t1 | V1 | (W3) | z4 | U1`**. `V1`'s cone contains
   `[300°, 0°]`: a `W3` after it reaches `P90` (as just said) and so starts at 0° or later; with no `W3`, `z4` starts at 60° or later.
6. *If `W3` exists* it fills the sector `(300°, 360°)` at `P90` (item 4, one colour-3 tile per vertex), bounded at 0° by an arc of `ω(q1)` (N-E1 at `q1`), and
   `W3 ⊂ B̄(q1, 1) ∩ B̄(P90, 1)`. If not, that sector is a colour-3 tile absent at `q1`.
*Reads:* the closed disc of radius `√3` about `p` (the points `q1, q3, q4, top, P90, P90′`).

**Verdict.** No contradiction at radius `√3`. **K1-ΓRING is GAP at (R-V)**, with the forced shape above: a Reuleaux-cap tile `z4` over the ring arc `q1–top`
(sector at `q1` starting at 60° or later, colour 4 absent at `q2` by N4-OWN) — the card's escape E2 in shape, found from the proof side through a (Q) arc on the ring.
Its next reads are the other side of the colour-1/colour-3 pair at `P90` and the cap region `Reul(q1, q2, r) ∖ B̄(p, 1)`, where `V1` (colour `X̄`) now sits at `q1`
in place of N4-G's colour-3 cap tile — so an (R-V) lune also removes the cap that N4-G and N5-R0 need to kill the *other* lune from the `q2` side.
**Registered** (G21; both outcomes reachable — a derived contradiction, or a fragment by formula on the construction side): *(R-V) dies within radius 2 about `p`*,
p = 0.4.

**Would-have-searched here.** A fragment by formula for (R-V) to see where it stops: not built (the construction side's kind of object); the derivation stops
at the named reads instead.

## Stage 3 — SAVED
