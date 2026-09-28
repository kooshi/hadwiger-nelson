# FS114-Y4 — the construction side of FS-114, round 4 (the escapes from RSTOP)

*Job FS114-Y4 (de Bruijn, Opus 5.5), 2026-09-28, from `data/fs114/briefs/Y4-114-construction-round4.md`, the cards `ROUND4-card.md`,
`ROUND3-card.md`, `ROUND2-card.md`, FS114-Y's brief `Y114-construction.md` and `STANDING-RULES.md` (all read in full, rule 0 first). Working files
`data/fs114/fs114-y4/`; exact checks `tools/fs114_y4_*.py`; my scratch `scratchpad/fs114-y4/` (regenerable only). Every statement about a valid map
is about a possible object: the class is not known to be non-empty. Notation as `plans/FS114-Y3-construction.md` (its header): `p = 0`,
`q1 = e(30°)`, `q2 = e(−30°)`, `q3 = e(210°)`, `q4 = e(150°)`, `top = (0, 1)`, `bot = (0, −1)`, `r = q1 + q2 = (√3, 0)`; `t1` the Reuleaux triangle
`(p, q1, q2)` (colour 1), `t3` its mirror (colour 3), `t2` above `p` (2), `t4` below (4); `T_i` the tactic tile of the outer colour at `q_i`; angles at
a vertex are directions from it, counter-clockwise from the positive x-axis; a tile's **sector** at a vertex is the closed cone of directions it
fills there. **The proof side's vocabulary** (the owner's message of 2026-09-28, verbatim from its records): the **ring** at `p` is `ω(p)`; a
**lune** is the region at `p` in the cone between the two Reuleaux triangles; "the top lune's ring `(30°, 150°)`"; the **degenerate member**: "the
top lune's ring `(30°, 150°)` changes colour once, at `top`"; a ring **free of `Γ`** carries no boundary arc along `ω(p)` in the lune's cone;
**simple**: "every tile an open disc whose closure meets each other tile's closure in a connected set or not at all, and does not meet itself".*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| FS114-Y4-SIDES | Let `t1 = Reul(p, q1, q2)` be a tile of a valid map; the tile `X1` along its side `p q1` at `q1` and the tile `X2` along its side `p q2` at `q2` (both outside `t1`) are distinct and of **different colours**, Siamese pairs allowed: the side points `q2 + e(90° + ε)`, `q1 + e(270° − ε)` are `2cos ε − 1 < 1` apart, and the two tiles have points more than 1 apart. In a non-Siamese Reuleaux bowtie `{c(X1), c(X2)} = {5, 6}` | [hand; tools exact at named points (S1, S2, C1) and on FS114-Y2-BOWTIE (P1); one mind] | §2.1; `tools/fs114_y4_sides.py`; `data/fs114/fs114-y4/sides.out` |
| FS114-Y4-D2ALL | **Every `y ↦ −y`-symmetric Reuleaux bowtie acts on colours 5, 6 by the swap** (SIDES), so the class of my brief — Y2's `x`-action with `y ↦ −y` acting as `(2 4)` — **is empty**, with no neighbourhood of `top` needed; with YB2-EMPTY13 (`x ↦ −x` fixing 5, 6: empty) and FS114-Y3-D2 (both swaps: stops before `r`), **no `D2`-symmetric Reuleaux bowtie containing `top` contains a neighbourhood of `r`** | [hand; one mind over YB2-EMPTY13 (one mind) and Y3-D2 (two minds), all under R-T] | §2.1 |
| FS114-Y4-UPDOWN | If `|u − v| = 1`, a tile at `u` with a direction `ψ` at `u` with `cos(ψ − arg(v − u)) > 0` has points within `< 1` of `v`, hence of every tile at `v`: in a non-Siamese map its colour is absent at `v` unless it is that tile | [hand; one mind; the straddle computation of Y3 §2] | §2.2 |
| FS114-Y4-W | In a non-Siamese simple Reuleaux bowtie the tile along `t1`'s outer side at `q1` and the one at `q2` are **one tile `W`, of colour 3** (the colour of `t3`); `W ⊂ B̄(q1, 1) ∩ B̄(q2, 1)`, so its sector is inside `[300°, 360°]` at `q1` and `[0°, 60°]` at `q2`, pointing toward `r` at both. Likewise `t3`'s outer tile is one tile of colour 1 | [hand; one mind] | §2.2 |
| FS114-Y4-E2X | In the class with `x ↦ −x` acting as `(1 3)(5 6)` (no `y`-symmetry assumed; FS114-Y3-D2 steps 1–4 hold), **E2 is impossible**: `λ > 60°` makes the sliver between `T1` and `L` colour 3 (colour 6 would straddle `σ_x(L) ∋ top`), and then `W` has colour 6 = `c(X2)` and cannot reach `q2`, contradicting FS114-Y4-W | [hand; one mind] | §2.3 |

## Would-have-searched-here log (standing rule 3)

- Stage 2: I would have varied the bowtie's tiles near `r` (sector boundaries at `q1`, `q2`, the colour of the sliver) and run the checker on
  each; instead each sector at `r` was read against the germs at `q1` and `q2` (the table of §2.2) and the tiles' colours derived from SIDES,
  UPDOWN and W. The exact check was run once, on named points and on Y2's object recoloured by the action in question.

## Fence log (standing rule 13; the brief's § Fences)

1. At start-up `ls -la data/fs114/briefs/` listed every brief's file name (the proof side's `N*-114-*.md`, the verifiers' `NB*`, `YB*`, `CV*`,
   the advisor's `A114-advisor.md`, `L60-114-audit.md`); `ls plans/FS114-* data/fs114/ tools/fs114_*` listed by name the fenced records
   `plans/FS114-N-proof.md`, `plans/FS114-N3-proof.md`, `FS114-N4-proof.md`, `FS114-N5-proof.md`, `FS114-NB-verification.md`,
   `FS114-CV*-verification.md`, `plans/FS114-close-inventory.md`, the directories `data/fs114/fs114-n*`, `fs114-nb`, `fs114-cv*`, `reports`, and the
   proof side's tools `tools/fs114_n*_*.py`. **Names only**; nothing in them opened, listed inside or grepped.
2. The harness's start-up `git status` named FS-111's untracked `data/fs111/fs111-w/*.out` and five commit subjects. Names only.
3. The owner's message of 2026-09-28 quoted five definitions from the proof side's records (N3 header, N3 §2.2, N4 §2.2, N-proof N2-3); vocabulary,
   sent by the owner, recorded in the header above.

## Stage 1 — SAVED: reading, the quotation check, calibration

### 1.1 Read from disk (reading status, G50)

- `STANDING-RULES.md` (rule 0 first: `CLAUDE.md` § The aim and § Counter-priors, in context from disk), my round-4 brief, the three cards, FS114-Y's
  brief: **in full**.
- `plans/FS114-Y3-construction.md`, `plans/FS114-Y2-construction.md`, `plans/FS114-YB2-verification.md`: **in full**. `plans/FS114-L60-audit.md`: the
  theorem table, fence log and §1.1–1.3(ii) **in full**; the rest not read (L60-WALK's chain is not mine to use).
- `data/fs114/claims.md`: **in full**.
- Tools, data layout first (G46): `tools/fs114_y2_k1.py` (the bowtie, every tile) and `tools/fs114_y3_rstop.py` **in full**;
  `tools/fs114_yb_exact.py` header and API (lines 1–140 and the function list), `tools/fs114_yb_run.py` `check_finite`; `tools/fs114_yb2_run.py` header.

### 1.2 Quotation check (standing rule 5)

`tools/fs114_y4_quotes.py`: **23 of 23 FOUND** (`data/fs114/fs114-y4/quotes.out`) — Kooshi's seven quotations; Question 2 against the claim list and
the paper's text; K1 on the round-4 card against the round-2 card; E1, E2 and "E2 survives" against Y3's record; YB2-EMPTY13 against YB2's record;
L60-LE, FS112-U1, FS112-SIX, C114-LOCAL-F, de Grey's Siamese, YB2-DE. Self-test PASS (`quotes-selftest.out`). **By hand:** the round-4 card's E2
("a tile at `q1` whose sector starts after 60°, and whose colour has no tile at `q2` pointing toward `r`") summarises Y3's "has its whole sector after
`60°` … no tile at `q2` pointing within 90° of `30°`" — faithful, with "toward `r`" meaning "within 90° of the direction `30°` to `r`"; the card's and
my brief's "where E2 survives" drops Y3's condition "when `λ > 60°`" (`λ` the start of `L`'s sector at `q1`), which this record keeps. The card's
N4 statements summarise fenced records; I work them as the card states them. My brief quotes nothing but its hand-back sentence.

### 1.3 Calibration (claim list §6)

Run unedited in this session under `scripts/slot.py --mem 2 --cpus 1`:
- **FS114-YB's checker**: `tools/fs114_yb_run.py selftest` → SELF-TEST PASSED, every checker plant flipping its predicted controls
  (`yb-selftest.out`); `calib` → brick, hexagonal seven-colouring, strip, disk, FS112-BOWTIE **all ACCEPT**, pairs examined printed against pairs held
  (3/17, 3/11, 24/90, 52/71, 18/21), each object plant REJECT (`yb-calib.out`).
- **FS114-YB2's checker**: `tools/fs114_yb2_run.py selftest` → SELFTEST PASSED (`yb2-selftest.out`); `calib` → the same five **all ACCEPT** (11/11,
  11/11, 82/82, 71/71, 21/21 examined), plants AS PREDICTED (`yb2-calib.out`).
- `tools/fs114_y2_k1.py all` → FS114-Y2-BOWTIE ACCEPT (46 pairs, 40 examined), plants `v5`, `wide_t1`, `wide_t1b` as in Y2's record
  (`y2-k1-rerun.out`).

## Stage 1 — SAVED

## Stage 2 — SAVED: two general lemmas, and the symmetric escapes closed

*Setting (R-T, the round-4 card's reading): a valid map, non-Siamese unless said, with a Reuleaux bowtie at `p`: `t1`, `t3` Reuleaux of width 1
corner to corner, all four edges at `p` tactic; `T1` (colour 4) at `q1`, `T2` (2) at `q2`, `T3` (2) at `q3`, `T4` (4) at `q4`. At `q1` the tiles run
counter-clockwise `t1 [180°, 300°]`, the outer gap, `T1`, the inner gap back to `180°`. `X1` is the inner-gap tile along `t1`'s side `p q1` (the last
before `t1`), `X2` the tile at `q2` along `t1`'s side `p q2` (the first after `t1`), `X4`, `X3` likewise for `t3`.*

### 2.1 FS114-Y4-SIDES and FS114-Y4-D2ALL [hand; tools exact; one mind]

**SIDES.** `t1`'s side `p q1` is the arc `q2 + e(θ)`, `θ ∈ [90°, 150°]`; its side `p q2` is `q1 + e(θ)`, `θ ∈ [210°, 270°]`. `X1` borders the first
along a positive length from `q1`, so `cl X1 ∋ x1 = q2 + e(90° + ε)` for small `ε > 0`; `X2` borders the second from `q2`, so `cl X2 ∋ x2 = q1 + e(270° − ε)`.
Then `x1 − x2 = (−sin ε + sin ε, cos ε + cos ε − 1)`, so `|x1 − x2| = 2cos ε − 1 < 1`, and interior points of `X1`, `X2` near them are within `< 1`.
And `X1` has points `q1 + ρe(ψ)`, `ψ ∈ (0°, 180°)`, `X2` points `q2 + ρ′e(ψ′)`, `ψ′ ∈ (180°, 360°)`, whose difference has vertical component
`1 + ρ sin ψ − ρ′ sin ψ′ > 1`. So `min < 1 < max`: one tile would have diameter above 1, and two tiles of one colour straddle — **`X1`, `X2` are distinct
and differently coloured, Siamese pairs allowed.** In a non-Siamese bowtie both lie in `B(p, 1)` near `q1`, `q2` and are not tiles at `p` (`t2 ∌ q1`,
`t4 ∌ q2`, by the diameter bound), so their colours are absent at `p` (FS114-Y2-GAPS): `{c(X1), c(X2)} = {5, 6}`. ∎
*Exact* (`tools/fs114_y4_sides.py`, `sides.out`; YB's checker and Y2's builder unedited; registered in the docstring before the run): S1 at
`sin ε = 20/101`: `|x1 − x2|² = 9409/10201 = (2cos ε − 1)²`; S2: a strip `X1` of height `1/10` along the side from `q2 + (−20/101, 99/101)` to `q1`
against its mirror `X2`: **REJECT** (min < 1 < max); C1 (control): the mirror moved down `1/5`, off the side: **ACCEPT**, min ≥ 1; P1: FS114-Y2-BOWTIE
as built ACCEPT, and recoloured by `y ↦ −y` acting as `(2 4)` with 5, 6 fixed (`L2 := 5`, `L3 := 6`, `V′ := 6`, `V‴ := 5`): **REJECT exactly
`(L1, L2)`, `(L3, L4)`**, as registered. **All as registered.**

**D2ALL.** `σ_y : (x, y) ↦ (x, −y)` fixes `t1` and maps `q1 ↦ q2`, `X1 ↦ X2`; so `c(X2) = σ_y(c(X1)) ≠ c(X1)`, both in `{5, 6}`: **`σ_y` swaps 5 and 6.**
Hence the four `D2` colour actions (`σ_x ∈ {(1 3), (1 3)(5 6)}`, `σ_y ∈ {(2 4), (2 4)(5 6)}`) all fail to reach `r`: `σ_x = (1 3)` is empty
(YB2-EMPTY13, one mind, which uses no `σ_y`); `σ_x = (1 3)(5 6)` with `σ_y = (2 4)` is **empty by SIDES** (the brief's class; no `top` needed — two
tiles at `q1`, `q2` suffice); `σ_x = (1 3)(5 6)` with `σ_y = (2 4)(5 6)` stops before `r` (FS114-Y3-D2, two minds with YB2's D2). **So every bowtie
that reaches `r` is asymmetric under `y ↦ −y`, or symmetric under `x ↦ −x` or `z ↦ −z` alone.** Where it bears: the brief's "start with Y2's
`x`-action with `y ↦ −y` acting as `(2 4)`, where E2 survives" — Y3's E2 survived there only because that class had not met SIDES.

### 2.2 FS114-Y4-UPDOWN, FS114-Y4-W, and the germ table at `r` [hand; one mind]

**UPDOWN.** `|u − v| = 1`, `z = u + ρe(ψ)`: `|z − v|² = 1 − 2ρ cos(ψ − arg(v − u)) + ρ² < 1` for small `ρ` when the cosine is positive; every tile at `v`
has `v` in its closure, so its minimum distance to that tile is below 1. ∎ (For `u = q1`, `v = q2`: **a tile at `q1` pointing down** — a direction in
`(180°, 360°)` — **carries a colour absent at `q2`** unless it is at `q2` too; **a tile at `q2` pointing up** carries a colour absent at `q1`.)

**W.** Let `W1` be the outer-gap tile at `q1` along `t1`'s side `q1 q2` (it contains the direction `300°⁺`) and `W2` the one at `q2` (`60°⁻`). `c(W1) ∉
{1, 2, 4, c(X1)}` (`t1`; 2 absent at `q1`, since `t2` straddles a neighbourhood of `q1`; `T1 ≠ W1`, since `T1` lies in the away cone `[300° + β₁,
120°]` of the tactic edge, `β₁ > 0`; `X1 ≠ W1` in a simple map), so `c(W1) ∈ {3, c(X2)}`; likewise `c(W2) ∈ {3, c(X1)}`. If `W1 ≠ W2`: `W1` points down
at `q1`, so (UPDOWN) `c(W1) ∉ P_cl(q2) ∋ c(X2)`, so `c(W1) = 3 ∉ P_cl(q2)`, so `c(W2) = c(X1)`; but `W2` points up at `q2`, so `c(W2) ∉ P_cl(q1) ∋
c(X1)`. Contradiction: **`W1 = W2 = W`, colour 3.** `W ∋ q1, q2` has diameter at most 1, so `W ⊂ B̄(q1, 1) ∩ B̄(q2, 1)`: its sector at `q1` lies in
`[180°, 360°] ∩ [300°, 180°] = [300°, 360°]` and at `q2` in `[0°, 60°]`. ∎ (Held instances: Y2's `W` (3), YB2's `V` (3), both inside these cones.)

**The germ table at `r`** (the same computation, Y3 §2): with `r = q1 + e(330°) = q2 + e(30°)`, the four sectors at `r` are `S_out = (−60°, 60°)`
(outside both discs), `S_1 = (60°, 120°)` (inside `B(q1, 1)` only), `S_12 = (120°, 240°)` (inside both), `S_2 = (240°, 300°)` (inside `B(q2, 1)` only).
A colour's tiles at `q1` are **toward** `r` (every direction in `(240°, 60°)`), **away** (every direction in `(60°, 240°)`), **both**, or **absent**; likewise
at `q2` with `(300°, 120°)`. Toward blocks the colour outside that disc near `r`, away blocks it inside, both blocks it everywhere (tangent directions
exactly `60°`, `240°`, `120°`, `300°` are second order and are treated where they occur, YB2-RPREC). So near `r`: colour 1 is blocked (`t1` is both at
`q1`); 3 is allowed only in `S_12`, and only as `W` (W); 2 (absent at `q1`) is allowed outside `B(q2, 1)` iff `T2` is away (E1), inside iff `T2` is
toward; 4 (absent at `q2`, since `t4` straddles a neighbourhood of `q2`) inside `B(q1, 1)` iff `T1` is toward, outside iff away (E1′); `c(X1)` is away or
both at `q1`, so only in `S_2 ∪ S_out`; `c(X2)` is away or both at `q2`, so only in `S_1 ∪ S_out`. Every arc of `ω(q1)` or `ω(q2)` through `r` with both
side colours present at the centre leaves, by FS112-U1, two cones of its own width at the centre for tiles of other colours (Y2-GAPS' count).

### 2.3 FS114-Y4-E2X — the `x`-symmetric class has no E2 [hand; one mind]

With `σ_x` acting as `(1 3)(5 6)`, FS114-Y3-D2 steps 1–4 (which use `σ_x` alone) give `q1` exactly the tiles `t1, W, T1, V, L`, `L = X1 ∋ top` with
sector `[λ, 180°]`, `{c(W), c(V)} = {3, c̄(L)}`, 2 absent. E2's only candidate is `L`, with `λ > 60°` (Y3). Then `V` covers `(θ_T, λ) ∋ 60°`: its points
`q1 + ρe(ψ)`, `ψ ∈ (60°, λ)`, are within `< 1` of `top` (`|q1 + ρe(ψ) − top|² = 1 + 2ρ cos(ψ − 330°) + ρ²`, the cosine negative), and `top ∈ cl σ_x(L)`,
of colour `c̄(L)`: so `c(V) ≠ c̄(L)`, `c(V) = 3`, `c(W) = c̄(L)`. By FS114-Y4-W, `c(W) = 3`. Contradiction. ∎ **So E2 needs a map with no
`x`-symmetry of this kind**, and FS114-Y4-D2ALL leaves no `y`-symmetry either (E1 in the `x`-symmetric class is not decided here).

## Stage 2 — SAVED
