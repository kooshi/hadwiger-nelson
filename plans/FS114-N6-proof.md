# FS114-N6 — FS-114's proof side, round 5: the pinwheel (K1-PIN), the `(2, 1, 1, 0)` patterns, three tactic edges

*Job FS114-N6, de Bruijn (Opus 5.5), launched 2026-09-28 10:32 UTC at HEAD `ac5fc592`. Brief `data/fs114/briefs/N6-114-proof-round5.md`, with the
cards `data/fs114/briefs/ROUND4-card.md`, `ROUND3-card.md`, `ROUND2-card.md`, FS114-N's brief `data/fs114/briefs/N114-proof.md` and
`data/fs114/briefs/STANDING-RULES.md` (rule 0 read first). Working files `data/fs114/fs114-n6/`; exact checks `tools/fs114_n6_*.py`; scratch
`scratchpad/fs114-n6/` (my own subdirectory). Resuming check: no record existed at start. Notation is FS114-N's, N2's, N3's, N4's and N5's
(`plans/FS114-N-proof.md` header; `plans/FS114-N3-proof.md` header and §2; `plans/FS114-N4-proof.md` header; `plans/FS114-N5-proof.md` header): tiles,
`ω(x)`, `P_cl(x)`, `Γ`, `F`, `R`, close / far (N114-FAR), a **tactic edge** (a whole unit arc on `ω(q)`, inner tile `x` with `q ∈ cl x`, and a tile of the
outer tile's colour — the **partner** — touching `x` at `q` alone), the **ring** `ω(p)`, a tile's **cone** at a vertex, the patterns `+`/`−` and inner
counts (N3-SEC), N-E0, N-E1, N-E2 (`plans/FS110-N-proof.md` §1.4), FS112-U1, N3-FACE, N3-HALF, N3-SEC, N3-FLANK, N3-PAIR, N3-ODD, N4-OWN, N4-LENS,
N4-OPP (in NB4's corrected form), N4-TANG, N5-SIGHT, N5-UP, N5-BENDG. `e(φ)` is the unit vector at angle `φ`. All statements are for **non-Siamese**
valid maps (no two distinct tiles of one colour close) in the **simple class** (a tile's cone at a vertex is one closed interval; a tile never touches
itself) unless said otherwise. **FS112-L60 is used only in its corrected form, "at most 60°"** (FS114-L60).*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| N6-QT | Every quotation my brief and the cards rely on, where its source is open to me, is found (18 of 18); the brief's restatements compared by hand, all faithful | [tools] | §1.2; `tools/fs114_n6_quotes.py` |
| N6-PIN180 | In the pinwheel every cone satisfies `60° ≤ α_j < 180°`: a 180° cone would put `T_{j+1}`'s sector outside `B̄(q_j, 1)` beside `e_{j+1}` | [hand, one mind; tools exact at a named point] | §2.1; `tools/fs114_n6_pin.py` |
| N6-KAPPA | At a four-colour vertex after the bends, `κ(θ + 60°) = κ̄(θ)` wherever both are defined (`κ`: ring tile colour, or an (R2) arc's inner colour) | [hand, one mind; N5-KAPPA's argument] | §2.2 |
| N6-WIN | **The window lemma**: at a `κ`-change point `y` (`Ā | A`), if `κ` is defined just beyond `y + 60°`, the window `(y, y + 60°)` carries no `Ā` and all its `A`-contacts are one tile, which reaches `y + 60°` (a change point when `κ` is defined just before it too); mirror for `(y − 60°, y)` | [hand, one mind] | §2.2 |
| N6-RING60 | A four-colour vertex whose ring carries no (Q) arc has ring change points exactly `y + 60°ℤ`: six ring tiles alternating the absent colours, each spanning a closed 60° arc | [hand, one mind] | §2.2 |
| N6-QOUT | A (Q) arc on the pinwheel's ring has inner `T_{j+1}`, lies in `[φ_j − min(60°, 180° − α_{j+1}), φ_j + min(0, α_{j+1} + α_{j+2} − 180°)]`, and has outer colour `c_{j+3}` (outer `c_j`, `c_{j+2}` impossible by U1) | [hand, one mind; tools exact at named values] | §2.3 |
| N6-P60′ | *(Stage 2's N6-P60, "a 60° cone is impossible", is withdrawn: its step 1 misread the Reuleaux triangle's corner cone as 60°; it is 120°.)* If `α_{j+1} = 60°` and `κ` is defined on the two 60° windows beside `q_j`, then `T_{j+2}` reaches `q_j`, lies in `Reul(p, q_j, q_{j+1})`, borders the whole side `e_{j+1}` from `p` to `q_j`, and `α_{j+1} + α_{j+2} < 180°` | [hand, one mind; tools exact] | §3.1 |
| **N6-NOQ** | **No pinwheel has a ring free of (Q) arcs** (after the bends); in particular none with a `Γ`-free ring, at radius `1 + ε`. *(Stage 2's added clause "and the pinwheel `α ≡ 90°`" is withdrawn: N6-QOUT admits (Q) arcs there.)* Proof corrected in §3.1: a 60° cone forces the next cone below 120° (N6-P60′), so all four would be 60° | [hand, one mind, over N5-BENDG and FS112-U1] | §2.4, §3.1 |
| N6-ADJ | If `T_{j+2}` reaches `q_j` then `α_{j+1} = 60°` and `α_{j+1} + α_{j+2} < 180°` | [hand, one mind; tools exact] | §3.1 |
| N6-QE1 | If `α_{j+1} ∈ (60°, 120°)`, no (Q) arc of `T_{j+2}` (outer colour `c_j`) holds `e(φ_j + 60°)` inside: `ω(q_j)` would enter a `c_j`-tile (N-E1 at `q_j`, which carries `c_j` by `z_j`); the pinwheel `α ≡ 90°` with full-zone (Q) arcs dies | [hand, one mind] | §3.2 |
| N6-PIN | K1-PIN after stage 3: the pinwheel is excluded at radius `1 + ε` unless its ring carries (Q) arcs of N6-QOUT's kind; **GAP** there | [hand, one mind] | §3.3 |
| **N6-CENT** | At a non-Siamese degree-4 vertex whose ring carries no (Q) arc (after the bends), all tactic centres lie in one class mod 60°: every cone between tactic edges is a multiple of 60°, and a lens is Reuleaux or `γ = 0°`; **non-Reuleaux lenses need a (Q) arc** | [hand, one mind] | §Stage 4 |
| N6-COV | At a tactic centre that is a change point with `κ` defined on both windows beside it, the directions toward `p` are covered only by `p`'s own tiles reaching it; a unit gap between consecutive centres of one tile pushes that tile aside and forces a neighbour into a Reuleaux triangle on `p` | [hand, one mind] | §Stage 4 |
| N6-MTP | For every `K`, a valid map in `𝓜_K` has a stationary random valid map in its hull whose Palm version is unimodular and hyperfinite, so of average curvature zero (Euler in expectation, pinch points included by multiplicity); route T's counts and N3-JOINT's assignment (a mass transport) hold as intensity identities: the aperiodic averaging step for Q-full_K closes by printed theorems; GAP-μ, K1, K2-loc, the Siamese class and unbounded complexity are untouched | [hand, one mind, over `[AldousLyons2007]` Ex. 9.5, `[AHNR2018]` Thm 1, 3.4 (external) and W-EQ-K's compactness] | §Stage 5 |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|
| scan cone vectors `(α_1, …, α_4)` and ring patterns for a consistent pinwheel | the window lemma N6-WIN by hand, which forces all centres into one class mod 60° unless a (Q) arc intervenes; checked at named values only |

## Fence log (standing rule 13; brief § Fences)

1. **The harness's start-up context** (not a command of mine) included the auto-memory index, a file under `~/.claude/projects/-home-kooshi-source-lean-dir/`
   (fenced). Its lines name milestone status and standing rules; no proof content. The start-up git status printed the untracked names
   `data/fs111/fs111-w/*` (FS-111) and `data/fs114/briefs/N6-114-proof-round5.md`, and five commit subjects (FS111-VM2, FS-114, FS114-Y4). Names and subjects
   only.
2. At start-up `ls -la data/fs114/briefs/` with `wc -c` printed the **names and sizes** of every brief, the construction side's among them (`Y114-…`, `Y2-…`,
   `Y3-…`, `Y4-…`, `YB…`, `YB3-114-instance.md`), the verifiers' (`NB…`, `NB5-114-instance.md`, `CV…`, `CVB…`) and the advisor's. None opened except mine,
   the three cards, FS114-N's and `STANDING-RULES.md`.
3. `ls plans/ | grep -i fs114` and `ls data/fs114/` printed the **names** `plans/FS114-Y-construction.md`, `FS114-Y2-construction.md`,
   `FS114-Y3-construction.md`, `FS114-Y4-construction.md`, `FS114-YB-verification.md`, `FS114-YB2-verification.md`, `FS114-NB5-verification.md`,
   `FS114-close-inventory.md` and the directory names `fs114-y`, `fs114-y2`, `fs114-y3`, `fs114-y4`, `fs114-yb`, `fs114-yb2`, `fs114-yb3`, `fs114-nb5`,
   `reports`. Contents not listed or opened.

## Stage 1 — SAVED: reading, the quotation check

### 1.1 Read from disk (G50)

- `data/fs114/briefs/STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim and § Counter-priors (loaded at start-up as the project's instructions); my
  brief, `ROUND4-card.md`, `ROUND3-card.md`, `ROUND2-card.md`, `N114-proof.md` — all in full.
- `plans/FS114-N5-proof.md` in full; `plans/FS114-N4-proof.md` in full; `plans/FS114-N3-proof.md` in full; `data/fs114/claims.md` in full.
- `plans/FS114-NB4-verification.md`: header, theorem table, logs, §1a, §1b.2 (N4-OWN, N4-LENS, **N4-OPP's corrected form**, N4-FIVE, N4-TOP, N4-D).
- `plans/FS114-L60-audit.md`: header, theorem table, logs, the proposed statement (§1.3's end).
- `plans/FS114-N-proof.md`: header and theorem table (FS114-N and N2 rows).
- `plans/FS110-N-proof.md` §1.4: N-E0, N-E1, N-E2 in full. `plans/FS112-derivation.md`: the statements of FS112-U1, -SIX, -L60, -N2-BENDS.

### 1.2 The quotation check (standing rule 5)

`tools/fs114_n6_quotes.py` checks 18 statements with whitespace collapsed and `**` removed, nothing else normalised: **18 of 18 FOUND**
(`data/fs114/fs114-n6/quotes.out`, exit 0). **Plant:** N5-PIN0's cone range `[60°, 180°]` changed to `[60°, 120°]` is NOT FOUND and its faithful twin FOUND
(`quotes-plant.out`, exit 0). By hand, the brief's restatements against the sources' words:
- "FS112's bends leave only (Q) and (R2) ring arcs at any degree-4 vertex (N5-BENDG)": faithful (at a non-Siamese degree-4 vertex, "outer colour carried at
  `p` and inner colour carried at `p`" is (Q)'s "centre carries both side colours and at least four colours").
- "N4-BOWTIE (Γ-free lune rings; two minds, the general member's kill step sighted)": faithful to NB4-G2.
- N5-PIN0's centres and cones, "no contradiction there", "the 120° cone (K1-PIN120) is N5's first target": faithful to N5 §4.2 and §4.5.
- "The collapse gives `χ_CP = χ_m⁰` with no MR (row 130)": faithful to `CLAUDE.md` § Where the problem stands, item 30.
- **Not checkable:** FS114-Y4-RSTOPALL, FS114-YB3 and every construction-side statement are fenced from me; I use them at the cards' and brief's wording and
  grade only, and **build nothing on RSTOPALL** (brief).

## Stage 1 — SAVED

## Stage 2 — SAVED: the pinwheel at radius `1 + ε` — no 180° cone, the ring's window lemma, and the ring must carry a (Q) arc

*Frame and names (N5-PIN0's, shifted by one index so that each tile is named by the centre it is inner to): `p = 0`, degree 4, tiles
`T_1, …, T_4` counter-clockwise with colours `c_1, …, c_4`, absent colours `5, 6`. The edge `e_j` (between `T_j` and `T_{j+1}`) leaves `p` in
direction `θ_j` and is tactic with inner tile `T_{j+1}`, centre `q_j = e(φ_j)`, `φ_j = θ_j + 90°`, partner `z_j` (colour `c_j`, at `q_j`, touching
`T_{j+1}` at `q_j` alone). `T_{j+1}` has cone `[θ_j, θ_{j+1}]` at `p`, of width `α_{j+1} = φ_{j+1} − φ_j`; `T_{j+1} ⊂ B̄(p, 1) ∩ B̄(q_j, 1)`,
`q_j ∈ cl T_{j+1}`, `T_{j+1} ∩ B(q_{j+1}, 1) = ∅` (N-E2 against `z_{j+1}`); `z_j ∩ B(p, 1) = ∅`. `w_±^{(j)} = e(φ_j ± 60°)` are the ring points unit
from `p` and `q_j`. Angles "rel `φ_j`" are measured from `φ_j`. Every metric fact at a named point is in `tools/fs114_n6_pin.py`
(`data/fs114/fs114-n6/pin.out`, 15 lines OK, exit 0; plant `--plant`, `q_{j+1}` of the 60° case moved to `e(70°)`, fails exactly the two lines resting on
`|q_j − q_{j+1}| = 1`, `pin-plant.out`, exit 1).*

### 2.1 N6-PIN180 — no cone of 180°

**N6-PIN180 [hand, one mind; tools exact at a named point].** *In the pinwheel every cone satisfies `60° ≤ α_j < 180°`.* The lower bound is N3-SEC (ii).
If `α_{j+1} = 180°` then `q_{j+1} = e(φ_j + 180°) = −q_j`, and `e_{j+1}`, an arc of `ω(−q_j)`, leaves `p` in the direction `θ_j + 180°` curving toward
`−q_j`, away from `q_j`. `T_{j+1}`'s sector at `p` is the whole closed half-plane `[θ_j, θ_j + 180°]`, so it holds the points just on its side of
`e_{j+1}` near `p`; these lie outside `B̄(q_j, 1)` (whose boundary `ω(q_j)` leaves `p` in the same direction curving the other way; tools, PIN180, at
`(−t, −t²/2 + t³)`, `t = 1/10`). But `T_{j+1} ⊂ B̄(q_j, 1)`. ∎ *Reads:* `p`, `q_j`, `q_{j+1}`; radius `1`. It closes N5-PIN0's exception "`α_j = 180°`".

### 2.2 N6-KAPPA and N6-WIN — the ring's window lemma, with (Q) arcs as holes

After N5-BENDG (the bends, two minds each, at FS112's grade; they recolour thin lenses along ring `Γ`-arcs away from `p`'s edges, the centres' sectors
and the partners, as N5 §2.1 argues for the bowtie — the same words apply here), every `Γ`-arc of `ω(p)` is (Q) or (R2). Define `κ(θ)` as the colour of
the tile holding `e(θ)`, or the inner colour of the (R2) arc through it; undefined on (Q) arcs. Off `Γ` the ring meets only colours 5, 6 (N-E1 at `p`),
and an (R2) arc's inner colour is 5 or 6 by definition.

**N6-KAPPA [hand, one mind; N5-KAPPA's argument, general].** *Where `κ(θ)` and `κ(θ + 60°)` are both defined they differ.* Tile–tile: N-E0. Tile at one,
(R2) arc at the other: the unit circles about the tile's points near the one cross the arc at the other transversally (the circles `ω(p)`, `ω(e(θ))` meet at
`e(θ + 60°)` at 60°) and so enter its inner side tile. (R2)–(R2): the same, both ways. ∎ So `κ(θ + 60°) = κ̄(θ)`, the other absent colour.

**N6-WIN [hand, one mind].** *Let `y` be a change point of `κ` (`κ = Ā` just clockwise of `y`, `A` just counter-clockwise), and call `R_A`, `R_Ā` the tiles
realising `κ` there (ring tiles or (R2) inner tiles; both have `y` in their closure).*
- *(i) If `κ(y + 60° + δ)` is defined for small `δ > 0`, then every ring contact of colour `A` in `(y, y + 60°)` belongs to `R_A` and none of colour `Ā`
  occurs there; if moreover `κ(y + 60° − δ)` is defined, `y + 60°` is a change point (`A` clockwise, `Ā` counter-clockwise) and `R_A` has it in its
  closure.*
- *(ii) The mirror: if `κ(y − 60° − δ)` is defined, `(y − 60°, y)` carries no `A`.*

*Proof.* An `A`-tile touching the ring at `e(θ)`, `θ ∈ (y, y + 60°)`, has a point within `< 1` of `y`, where `R_A` has points arbitrarily close: distinct
tiles of one colour are far (N114-FAR, non-Siamese), so it is `R_A`. An `Ā`-contact at `θ ∈ (y, y + 60°)` is likewise `R_Ā`; it is also within `< 1` of
`y + 60°`, which carries `Ā` by the tile realising `κ(y + 60° + δ) = κ̄(y + δ) = Ā` (N6-KAPPA), so that tile is `R_Ā` too, which then holds contacts near
`e(y − δ)` and `e(y + 60° + δ)`, more than 1 apart. The rest is N6-KAPPA at `y + 60° ± δ`. (ii) is (i) reflected. ∎ *Reads:* `ω(p)` and the tiles
touching it: a neighbourhood of the closed unit disc about `p`.

**Corollary (N6-RING60) [hand, one mind].** *A four-colour vertex of a non-Siamese valid map whose ring carries no (Q) arc (after the bends) has its ring
change points exactly at `y + 60°ℤ`: six ring tiles (or (R2) inner tiles), alternately of the two absent colours, each holding in its closure both ends
of its 60° arc.* (N3-ODD's "odd number per window" is exactly one.) By N6-WIN (i) from one change point round the circle; a change point exists, since a
constant `κ` contradicts N6-KAPPA.

### 2.3 N6-QOUT — which (Q) arcs the pinwheel's ring can carry

**N6-QOUT [hand, one mind; tools exact at named values].** *A (Q) arc `[φ_j + b_1, φ_j + b_2]` of the pinwheel's ring has inner tile `T_{j+1}` for some `j`,
lies within `−min(60°, 180° − α_{j+1}) ≤ b_1 < b_2 ≤ min(0, α_{j+1} + α_{j+2} − 180°)` (just clockwise of `q_j`), and its outer colour is `c_{j+3}`.*
- The inner side lies in `B(p, 1)`, so its tile has a colour of `p` (a (Q) arc's inner colour is carried at `p`) and is `p`'s tile of that colour: some
  `T_{j+1}`. FS112-U1: `T_{j+1}`'s cone `[φ_j − 90°, φ_j − 90° + α_{j+1}]` lies in the closed cone `[β_2 − 90°, β_1 + 90°]` facing the arc, so `b_2 ≤ 0` and
  `b_1 ≥ α_{j+1} − 180°`; and `T_{j+1} ⊂ B̄(q_j, 1)` keeps its ring contacts within 60° of `q_j`, `b_1 ≥ −60°`.
- The outer colour `c_m` has its `p`-tile's cone in the closed cone `[β_2 + 90°, β_1 + 270°]` facing away (U1). Rel `φ_j`: `T_j`'s cone `[270° − α_j, 270°]`
  needs `b_1 ≥ 0` — impossible. `T_{j+2}`'s cone `[α_{j+1} − 90°, α_{j+1} + α_{j+2} − 90°]` needs `α_{j+1} − 90° ≥ b_2 + 90°`, i.e. `b_2 ≤ α_{j+1} − 180° ≤ b_1`
  — impossible. `T_{j+3}`'s cone `[α_{j+1} + α_{j+2} − 90°, 270° − α_j]` fits iff `α_{j+1} + α_{j+2} ≥ 180° + b_2` (its end condition `b_1 ≥ −α_j` holds
  always). ∎ *Reads:* `p`, `q_j` and the arc; radius `1 + ε`. Tools, QOUT: at four named cone triples and three named arcs, `c_j` and `c_{j+2}` are never
  admissible and every admissible `c_{j+3}` meets the stated inequality.

Two consequences used below: **(Q) arcs never start at a centre from the counter-clockwise side** (a (Q) arc of `T_{j+2}` starting at `q_j` needs
`α_{j+1} = 60°` and `T_{j+2} ∋ q_j`, excluded in §2.4), and **at every centre `q_j` either both ring branches are `κ`-defined, with different colours
(N3-FLANK, its argument unchanged for an (R2) inner tile) — `q_j` is a change point — or the clockwise branch is a (Q) arc of `T_{j+1}` ending at `q_j`**
(then `α_{j+1} + α_{j+2} ≥ 180°`).

### 2.4 N6-P60 and N6-NOQ — without a (Q) arc there is no pinwheel

*[Corrected at stage 3 (§3.1): N6-P60's step 1 is wrong — the Reuleaux triangle `Reul(p, q_j, q_{j+1})` has a 120° corner cone `[φ_j − 30°, φ_j + 90°]`
at `p`, so `T_{j+2}` may reach `q_j`; the tool line "P60: point near p in direction −30 …" tested the wrong side of `e_{j+1}`. N6-NOQ survives with the
corrected proof of §3.1; its last sentence (the pinwheel `α ≡ 90°`) is withdrawn. The text below is kept as written.]*

**N6-P60 [hand, one mind; tools exact].** *Let `α_{j+1} = 60°`, let `q_j` be a change point with `κ` defined on `(φ_j − 60° − δ, φ_j + 60° + δ)`
(no (Q) arc there). Then there is no pinwheel.* Here `q_{j+1} = w_+ := w_+^{(j)}`.
1. *Inside `q_j`, only four tiles can sit.* A tile at `q_j` whose cone meets the open half-plane facing `p` has points in `B(p, 1)`; with a colour of `p`
   it is `p`'s tile of that colour (N4-LENS's argument). `T_{j+1}` is there; `T_{j+2}` would contain `p`, `q_j`, `q_{j+1}`, mutually unit apart, so it would
   lie in their Reuleaux triangle, whose cone at `p` is `[φ_j, φ_j + 60°]`, while `T_{j+2}`'s cone starts at `θ_{j+1} = φ_j − 30°` (tools, P60): excluded;
   `T_{j+3} ⊂ B̄(q_{j+2}, 1)` and `|q_j − q_{j+2}| ≥ √3`; `T_j ∩ B(q_j, 1) = ∅`. Of colours 5, 6 there is one tile each (non-Siamese): the ring-branch
   tiles `R_+` (colour `X`, counter-clockwise) and `R_−` (`X̄`).
2. *Their cones.* By N6-WIN (i) and (ii) at `y = φ_j` (defined on both windows), `R_+` realises `κ = X` on all of `(φ_j, φ_j + 60°)` and has `w_+` in its
   closure, so `R_+ ⊂ B̄(w_+, 1)`; and the `X`-tile at `w_− = e(φ_j − 60°)` (realising `κ(φ_j − 60° − δ) = X`) is a different tile, so far: `R_+ ∩
   B(w_−, 1) = ∅`. Hence `R_+`'s cone at `q_j` lies in `[30°, 150°]` rel `φ_j` (tools, RCONE). Mirror: `R_−`'s in `[210°, 330°]`.
3. *`T_{j+1}` far from `q_{j+1}` at unit distance* puts its cone at `q_j` in the half-plane facing away from `q_{j+1}`: `[210°, 390°]` rel, with the inner
   half: `[210°, 270°]` (tools, P60).
4. The open directions `(150°, 210°)` rel `φ_j` at `q_j` — toward `p` — lie in no tile's cone. A contradiction at a vertex of a locally finite map. ∎
*Reads:* the closed disc of radius `1 + ε` about `p`; the points `p, q_j, q_{j+1} = w_+, w_−` (G83: `p` and `q_j, q_{j+1} ∈ F`).

**N6-NOQ [hand, one mind].** *No pinwheel (non-Siamese, simple class) has a ring free of (Q) arcs after the bends.* Every centre is then a change point
(§2.3), so by N6-RING60 all `φ_j` agree modulo 60°: every `α_j ∈ {60°, 120°}` (N6-PIN180), and `Σ α_j = 360°` forces two of them to be 60°. N6-P60 at one
of those. ∎ In particular: **no pinwheel with a `Γ`-free ring exists, at radius `1 + ε`**; the symmetric pinwheel `α_j ≡ 90°` needs a (Q) arc, and by
N6-QOUT (with `b_2 > −60°`) it has none — **the pinwheel `α ≡ 90°` does not exist at radius `1 + ε`**.

*What stage 3 takes up:* the pinwheel whose ring carries (Q) arcs — each just clockwise of a centre `q_j` with inner `T_{j+1}` and outer colour `c_{j+3}`,
possible only where `α_{j+1} + α_{j+2} > 180° + b_2`.

## Stage 2 — SAVED

## Stage 3 — SAVED: the correction, N6-NOQ re-proved, and the (Q)-pinwheel's first constraint

### 3.1 The correction (G21: a result I liked, audited)

**Stage 2's N6-P60 was wrong at step 1.** The Reuleaux triangle `Reul(p, q_j, q_{j+1})` (`|q_j − q_{j+1}| = 1`) has a corner cone of **120°** at `p`,
`[φ_j − 30°, φ_j + 90°]` (the intersection of the half-planes facing `q_j` and `q_{j+1}`), not 60°; `T_{j+2}`'s cone starts at `φ_j − 30°`, its boundary.
The tool line that "checked" it tested a point on the wrong side of `e_{j+1}` (a true fact, irrelevant to the inference). Found by re-deriving the
Reuleaux cone while checking a (Q) arc of full length, which used the same cone. The tool now checks the 120° cone (`P60′` lines) and N6-ADJ below.
N6-NOQ's conclusion survives with this proof; its extra clause "the pinwheel `α ≡ 90°` does not exist" does not (N6-QOUT admits (Q) arcs there:
`α_{j+1} + α_{j+2} = 180° ≥ 180° + b_2`) and is withdrawn.

**N6-ADJ [hand, one mind; tools exact].** *If `T_{j+2}` reaches `q_j`, then `α_{j+1} = 60°` and `α_{j+1} + α_{j+2} < 180°`.* `T_{j+2} ⊂ B̄(q_{j+1}, 1)` reaching `q_j`
gives `|q_j − q_{j+1}| ≤ 1`, so `α_{j+1} = 60°`. `T_{j+2} ⊂ B̄(q_j, 1)` puts its cone at `p` in `[φ_j − 90°, φ_j + 90°]`; at equality `θ_{j+2} = φ_j + 90°` the edge
`e_{j+2}` lies on `ω(q_{j+2}) = ω(−q_j)`, curving away from `q_j`, and `T_{j+2}`'s points just clockwise of it near `p` lie outside `B̄(q_j, 1)` (tools, ADJ;
N6-PIN180's argument). ∎ *Reads:* `p, q_j, q_{j+1}, q_{j+2}`.

**N6-P60′ [hand, one mind; tools exact].** *Let `α_{j+1} = 60°` and let `κ` be defined on `(φ_j − 60° − δ, φ_j + 60° + δ)`. Then `T_{j+2}` reaches `q_j`, lies
in `Reul(p, q_j, q_{j+1})`, borders the whole Reuleaux side `e_{j+1}` from `p` to `q_j` (simple class: the common boundary of two tiles is connected), and
`α_{j+2} < 120°` (N6-ADJ).* Stage 2's items 1–3 stand with `T_{j+2}` kept as a candidate: inside `q_j` sit only `T_{j+1}` (cone at `q_j` in `[210°, 270°]` rel
`φ_j`), `T_{j+2}`, and one tile of each absent colour, `R_+ ⊂ [30°, 150°]`, `R_− ⊂ [210°, 330°]` (N6-WIN); the directions `(150°, 210°)` must be `T_{j+2}`'s. ∎

**N6-NOQ, re-proved.** With no (Q) arc, every centre is a change point, so every `α_j ∈ {60°, 120°}` and two are 60° (stage 2). By N6-P60′ a 60° cone
`α_{j+1}` forces `α_{j+2} < 120°`, i.e. `α_{j+2} = 60°`: every 60° cone is followed by another, so all four are 60° and `Σ α_j = 240°`. ∎ **The pinwheel has a
(Q) arc on its ring, at radius `1 + ε`.**

### 3.2 N6-QE1 — the (Q) arcs meet `N-E1` at the neighbouring centre

**N6-QE1 [hand, one mind].** *If `α_{j+1} ∈ (60°, 120°)`, no (Q) arc of `T_{j+2}` holds `w_+^{(j)} = e(φ_j + 60°)` in its interior.* By N6-QOUT at the centre `q_{j+1}`,
a (Q) arc of `T_{j+2}` has outer colour `c_{(j+1)+3} = c_j`, and its outer tile borders the whole arc from outside. `ω(q_j)` passes through `w_+^{(j)}`, crossing
`ω(p)` there at 60°, so it meets that outer tile's interior; `z_j` (colour `c_j`) has `q_j` in its closure: N-E1 at `q_j`. ∎ (`α_{j+1} ∈ (60°, 120°)` is exactly when
`w_+^{(j)}` lies inside `T_{j+2}`'s zone `[φ_{j+1} − 60°, φ_{j+1}]`.) *Reads:* `q_j`, `w_+^{(j)}`; radius `1 + ε`.

**An instance: the four-fold pinwheel `α ≡ 90°` with full-zone (Q) arcs dies.** Its zones are `[φ_k − 60°, φ_k]`; a (Q) arc filling a zone holds
`w_+^{(k−1)} = e(φ_k − 30°)` inside (N6-QE1 with `α_k = 90°`). This is the member the first-order constraints (N6-QOUT, FS112-U1, L60's equality) all admit:
`T_{k+1} = Reul(p, e(φ_k − 60°), q_k) ∖ B(q_{k+1}, 1)`, ring tiles on `(φ_k, φ_k + 30°)`, each centre `q_k = T_{k+1} | O_k | z_k | R_k` of degree 4. So for `α ≡ 90°`
every (Q) arc lies in one half `[φ_k − 60°, φ_k − 30°]` or `[φ_k − 30°, φ_k]` of its zone.

### 3.3 K1-PIN's status after this stage

| pinwheel member | status |
|---|---|
| ring free of (Q) arcs after the bends (in particular `Γ`-free) | **excluded at radius `1 + ε`** (N6-NOQ; one mind) |
| a 180° cone | excluded (N6-PIN180) |
| ring with (Q) arcs | **GAP**: each (Q) arc has inner `T_{j+1}`, outer colour `c_{j+3}`, lies within `[φ_j − min(60°, 180° − α_{j+1}), φ_j + min(0, α_{j+1} + α_{j+2} − 180°)]` (N6-QOUT), and does not straddle `w_+^{(j−1)}` when `α_j ∈ (60°, 120°)` (N6-QE1); `α ≡ 90°` with full-zone arcs dies |

*Registered* (G21; both outcomes reachable — a derived contradiction, or a fragment by formula on the construction side): *every pinwheel with a (Q) arc dies within
radius `√3` about `p`*, p = 0.5. The mechanism that worked here (N6-WIN's rigidity of the ring, broken only by (Q) holes, and N-E1 at the centres through the
points `w_±`) reads radius `1 + ε`; the next reads are the (Q) arcs' outer tiles `O_j` (colour `c_{j+3}`, in the Reuleaux cap over the arc when it is 60° long) at the
rhombus corners `q_j + e(φ_j − 60°)`.

## Stage 3 — SAVED

## Stage 4 — SAVED: brief item 2 — the (2, 1, 1, 0) patterns and three tactic edges, reduced by the same two tools

*Setting: any degree-4 vertex `p` of a non-Siamese valid map (simple class), four colours, after the bends; tactic edges of either sign (N3-SEC). A tactic
edge leaving `p` in direction `θ` has its centre at `p + e(θ ± 90°)`, the sign by which side its inner tile lies.*

**N6-CENT [hand, one mind].** *If `p`'s ring carries no (Q) arc, the centres of all tactic edges at `p` lie in one class `y + 60°ℤ`; hence all tactic edge
directions lie in one class modulo 60°, and every cone between two tactic edges is a multiple of 60°.* Each tactic centre is a `κ`-change point (N3-FLANK:
its two ring branches lie on (R2) arcs or in tiles of the absent colours, of different colours), and by N6-RING60 the change points are exactly `y + 60°ℤ`.
The direction of an edge is its centre's direction `± 90°`, and `90° ≡ −90° (mod 60°)`. ∎ *Reads:* the closed disc of radius `1 + ε` about `p`.

**Consequences for K1's open shapes (each at radius `1 + ε`).**
- **Non-Reuleaux lenses need a (Q) arc.** A lens has its two centres `γ ≤ 60°` apart (N3-SEC (iii)); with a (Q)-free ring `γ ∈ {0°, 60°}`: the lens is Reuleaux
  (`γ = 60°`, cone 120°) or the degenerate `γ = 0°` (cone 180°, both edges on one circle `ω(q)`). **K1's "non-Reuleaux lenses" (`0 < γ < 60°`) reduce to rings
  with (Q) arcs.**
- **The (2, 1, 1, 0) patterns and three tactic edges with a (Q)-free ring** have every cone between consecutive tactic edges in `{60°, 120°, 180°}` (N3-SEC (i):
  a tile beside a tactic edge has cone at most 180°), rotational tiles `≥ 60°`, lenses `120°` or `180°`.
- **N6-COV, the coverage step, general [hand, one mind].** *At a tactic centre `q = e(φ)` that is a change point with `κ` defined on both 60° windows beside it,
  the directions `(150°, 210°)` rel `φ` (toward `p`) lie in the cones of `p`'s own tiles that reach `q`.* The two absent-colour tiles at `q` have cones in
  `[30°, 150°]` and `[210°, 330°]` (N6-WIN, as in N6-P60′); every other tile at `q` meeting `B(p, 1)` is a tile at `p`. The inner tile of `q`'s edge reaches `q`;
  when the tile's other bounding centre is at distance exactly 1 from `q`, its cone at `q` is pushed to one side (`[210°, 270°]` or `[90°, 150°]`), and a
  neighbouring tile of `p` must reach `q` — which puts it in a Reuleaux triangle on `p` and costs it the cone bound of N6-ADJ. This is the mechanism that
  closed the (Q)-free pinwheel; applied to `+++−` and `++−−` it is a finite list of cone vectors in `60°ℤ`, **not walked here**.

**The Reuleaux bowtie in this language.** Its caps are (Q) arcs (inner `t1`, outer the colour-3 cap tile), so N4's and N5's bowtie is a (Q)-ring configuration;
N6-CENT holds for its centres `e(±30°), e(180° ± 30°)` (all `≡ 30° mod 60°`) without contradiction. A bowtie whose lenses do **not** border the caps (the caps'
ring arcs in absent-colour tiles) is (Q)-free and passes N6-COV at the corners (checked at `q1`: `R′ ⊂ [90°, 150°]`, `t1 ⊂ [150°, 270°]`, `R ⊂ [210°, 270°]` rel
`φ = 30°`); **it is outside N4-BOWTIE's scope** (reading R-T takes the lenses to be whole Reuleaux triangles) and is named here as an open member of K1.

### K1 after stage 4

| degree-4 shape with three or four tactic edges | status |
|---|---|
| `++++` pinwheel | (Q)-free: **excluded at `1 + ε`** (N6-NOQ); with (Q) arcs: GAP (N6-QOUT, N6-QE1 constrain it) |
| `+−+−` Reuleaux bowtie (lenses whole Reuleaux triangles) | N4-BOWTIE (`√3`, `Γ`-free lune rings, two minds), N5-ΓRING (radius 2 except (R-V), one mind); (R-V) GAP |
| `+−+−` with lenses not bordering the caps | (Q)-free is possible only with `γ ∈ {0°, 60°}`; GAP, not walked |
| non-Reuleaux lenses `0 < γ < 60°` | need a (Q) arc (N6-CENT); GAP there |
| `+++−`, `++−−`; three tactic edges | (Q)-free: cones in `60°ℤ` (N6-CENT), N6-COV applies; GAP, not walked |

## Stage 4 — SAVED

## Stage 5 — SAVED: brief item 3 — the mass-transport lead for route T's aperiodic step

### 5.1 Read (G50; copies in `~/source/library/pdf/`, fetched from arXiv 2026-09-28)

| key (proposed) | work | read |
|---|---|---|
| `[AldousLyons2007]` | D. Aldous, R. Lyons, *Processes on unimodular random networks*, arXiv:math/0603062 (venue as recalled: Electron. J. Probab. 12 (2007), unchecked against the paper) — `arXiv-math-0603062-aldous-lyons-processes-on-unimodular-random-networks.pdf` | **Definition 2.1** (unimodular = the Mass-Transport Principle (2.1)); **Example 9.5** (tilings: a `Γ`-invariant measure on graphs embedded in Euclidean space, rooted at a uniform vertex of a test region, is unimodular and independent of the region — "the Palm measure … except that µ is a measure on isomorphism classes"; "a limit measure obtained from translates of a given tiling"). Theorem 8.5 read only as AHNR restate it. Rest not read |
| `[AHNR2018]` | O. Angel, T. Hutchcroft, A. Nachmias, G. Ray, *Hyperbolic and parabolic unimodular random maps*, arXiv:1612.08693v2 (venue as recalled: GAFA 28 (2018), unchecked) — `arXiv-1612.08693-angel-hutchcroft-nachmias-ray-hyperbolic-parabolic-unimodular-maps.pdf` | abstract; §1 to Theorem 1 (the Dichotomy Theorem, statement (1)–(9) read); §3.2 (invariant Cheeger constant, invariant amenability), §3.3 (hyperfiniteness, Theorem 3.4 = [AL, Thm 8.5] with its proof); §4 opening (angle sum `θ(v)`, curvature `κ(v) = 2π − θ(v)`, faces with multiplicity; Examples 4.1, 4.2) and the mass transport of Example 4.3's proof. Rest not read |
| `[BenjaminiSchramm2001]` | I. Benjamini, O. Schramm, *Recurrence of distributional limits of finite planar graphs*, arXiv:math/0011019 — `arXiv-math-0011019-benjamini-schramm-recurrence-distributional-limits.pdf` | abstract, §1.1–1.2 (distributional limits; bounded-degree limits of finite planar graphs are recurrent). Not about Euler counts; rest not read |

Not read (named in AHNR and AL as the stochastic-geometry side): Mecke-type intensity relations for stationary planar tessellations. **Would-have-searched:** none (reading only).

### 5.2 The answer, at its grade

**N6-MTP [hand, one mind, over `[AldousLyons2007]` Ex. 9.5 and `[AHNR2018]` Thm 1, Thm 3.4 at their printed grade; external].** *For every `K`, a valid map in `𝓜_K`
has a translation-invariant random valid map in its hull; its Palm version is a unimodular random rooted planar map with `E[deg ρ] < ∞`, hyperfinite, hence of
average curvature zero: **Euler's formula holds in expectation**, and N114-EULER, N2-SLACK, N2-ENDS and N3-JOINT's fractional assignment hold as identities of
intensities, with no boundary term.*
1. *The hull.* Average the translates of `M` over growing squares and take a weak limit point: a translation-invariant law `ν`. It is carried by valid maps in
   `𝓜_K` because `𝓜_K`'s limit class is closed under local limits (the compactness step C114-COMPACT rests on, `plans/FS107-derivation.md` W-EQ-K, at its grade).
   Rotations are optional (SO(2) is compact); Euler needs only translations.
2. *Unimodular.* `[AldousLyons2007]` Ex. 9.5 applies verbatim to the 1-skeleton `Γ` with its faces (the tiles); `E[deg ρ] < ∞` from the complexity bound.
3. *Hyperfinite, so invariantly amenable* (my step): keep the edges with both ends in one cell of a randomly shifted dyadic grid of side `2^i` (one shift for all
   `i`, so the percolations nest); each is finitary (finite intensity), and every edge is eventually inside one cell. `[AHNR2018]` Thm 3.4 gives invariant
   amenability, and Theorem 1 (2) ⟹ (1) average curvature zero: `E[2 − Σ_{f ⊥ ρ} (deg f − 2)/deg f] = 0`, faces counted with multiplicity at their corners — so
   **pinch points are inside the identity**. A tile with a hole needs `Γ` connected: add a bridge edge from the hole's boundary outward (local, colour-free).
4. *Route T's counts* are Euler plus local double counting, so each becomes an identity of Palm expectations times intensities; **N3-JOINT's assignment is a mass
   transport**, and the Mass-Transport Principle is exactly "expected mass received = expected mass sent", so its torus statement transfers to stationary maps
   unchanged.

**What it closes, and what it does not.**
- **Closes:** the averaging in route T's aperiodic step for Q-full_K (brief N114 stage 3's "averaging over the plane"; N2-AVG's disc accounting; C114-BUDGET's
  "averaging to that value on the plane"): at each `K` the torus-form local statements imply the NO for aperiodic maps in `𝓜_K`, by printed theorems, with no
  Følner estimate.
- **Does not close GAP-μ.** `μ` is a local deficit in the rainbow count (pockets lower the demand `(d − 2)(d − 3)` by repeated face contacts), not an averaging
  error; stationarity makes `μ` an intensity and still leaves it uncharged. AHNR's multiplicity convention settles only the Euler side of pinch points.
- **Does not touch** K1, K2-loc, the Siamese class (N2-SIAM: the count is blind there), or unbounded complexity (without `𝓜_K`'s compactness a limit of translates
  may leave the locally finite maps; N2-AVG's direct route is the one that reaches non-Siamese maps of any complexity).
- **Row 130's sentence in the lead** ("one may assume a random colouring invariant under rigid motions") concerns `χ_m⁰`; a CP colouring is not a map, so it gives no
  random valid map. For FS-114's maps the stationarity comes from the hull, at bounded complexity.

## Stage 5 — SAVED
