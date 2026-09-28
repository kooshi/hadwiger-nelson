# FS114-Y2 — the construction side of FS-114, round 2 (the meeting point, from the other end)

*Job FS114-Y2 (de Bruijn, Opus 5.5), 2026-09-28, from `data/fs114/briefs/Y2-114-construction-round2.md`, the round-2 card
`data/fs114/briefs/ROUND2-card.md`, FS114-Y's brief `data/fs114/briefs/Y114-construction.md` and `data/fs114/briefs/STANDING-RULES.md` (all
four read in full, rule 0 first). Working files `data/fs114/fs114-y2/`; exact checks `tools/fs114_y2_*.py`; my scratch
`scratchpad/fs114-y2/` (regenerable only). Every verdict here is about a possible object: the class of valid maps is not known to be non-empty.*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| FS114-Y2-BOWTIE | **K1's killing test fires as a local statement:** a non-Siamese valid fragment by formula (twenty tiles over `ℚ(√3)`) holds the closed disc of radius `3√3/5 ≈ 1.0392` about a degree-4 vertex `p` of four colours whose **four** edges are tactic — unit arcs about four-colour vertices `q1…q4` at distance 1, each with a tile of the outer tile's colour meeting the inner tile at `q_i` alone. So no argument reading only the closed disc of radius `3√3/5` about the vertex proves K1 | [tools, exact; one mind: FS114-YB's checker, unedited, recalibrated on the five controls; two plants fire as registered, a third fired at two unregistered pairs for a named reason] | §1b; `tools/fs114_y2_k1.py`; `data/fs114/fs114-y2/k1.out` |
| FS114-Y2-GAPS | About every valid map: at the centre `q` of a tactic edge `e` from `p` whose arc subtends `β` at `q`, the inner tile lies at `q` in the cone `[d + β − 90°, d + 90°]` and the tile `T` of the outer colour in `[d + 90° + β, d + 270°]` (`d` the direction from `q` to `p`, `e` turning counter-clockwise about `q`); so `q` carries further tiles in two cones of width at least `β`, one of them inside `B(p, 1)`; and in a non-Siamese map every tile meeting the open unit disc about a vertex `p` is a tile at `p` or has a colour absent at `p` | [hand; one mind] | §1b.2 |

## Would-have-searched-here log (standing rule 3)

- Stage 1b: (a) the fragment's shapes — I would have searched tile layouts around `p`; instead each tile was derived from the constraints of §1b.2
  (GAPS, the diameter bound, the colours blocked near `p`), and the free choices (the rim points) were taken as rational points on the derived circles.
  (b) The `wide_t1` miss — I would have scanned plant positions until four REJECTs appeared; instead the extra two were explained and a second plant was
  derived and registered before its run.

## Fence log (standing rule 13; the brief's § Fences)

1. At start-up `ls plans/FS114* data/fs114/ data/fs114/*` listed, by **name only**, the fenced `plans/FS114-N-proof.md`,
   `plans/FS114-NB-verification.md`, `plans/FS114-close-inventory.md`, the directories `data/fs114/fs114-n`, `fs114-n2`, `fs114-nb` with their file
   names (`count.out`, `quotes.out`, …), `data/fs114/reports/` with its six file names, and the brief file names in `data/fs114/briefs/` (among them
   the proof side's round-2 brief `N3-114-proof-round2.md`). Nothing in them was opened or grepped.
2. At start-up `git log --oneline -15` showed ten commit subjects beyond the five of the start-up snapshot (all neutral: `FS114-N2: stage 2/3`,
   `FS114-YB: stage 1a/1b/1/2`, `FS114-NB: stage 1/2`, `FS-114 inventory: …`, `YB instance: date`). Subjects only; no `git log -p`.
3. `ls tools/fs114_* tools/fs112_*` listed by name the proof side's round-1 tools (`tools/fs114_n_count.py`, `fs114_n2_count.py`, `fs114_nb_*`,
   …). Not opened.
4. FS114-Y's quotation tool reads a paper text from FS114-Y's scratch subdirectory (`scratchpad/fs114-y/sv.txt`), a file this job did not create;
   so I did **not** run it and wrote my own (`tools/fs114_y2_quotes.py`), regenerating the text into `scratchpad/fs114-y2/`.

## Stage 1a — SAVED: reading, the quotation check, and the shared result from FS114-CV

### 1a.1 Read from disk, in this order (reading status per section, G50)

- `data/fs114/briefs/STANDING-RULES.md` (rule 0 first; `CLAUDE.md` § The aim and § Counter-priors in context from disk at start-up); my round-2
  brief; the card; FS114-Y's brief.
- `plans/FS114-Y-construction.md`, in full; `plans/FS114-YB-verification.md`, in full (with YB's rainbow third-case fragment, `tools/fs114_yb_run2.py`
  `rainbow()` and `data/fs114/fs114-yb/rainbow.out`; the checker's header, `tools/fs114_yb_exact.py` lines 1–80).
- `plans/FS114-unit-arc-question.md` §G part 3, §IQ, 5.0–5.4 (5.3 open to this job, per my brief).
- `data/fs114/claims.md`, in full.
- `plans/FS112-Y-construction.md` stages 4–5 (the disk's rules, tiles, colours and read-off), for the disk's four-colour corners' edges.
- `plans/FS114-CV-verification.md`: the theorem table's CV-EXISTS row and the rows at lines 189–192 (after the owner's message; see 1a.3).

### 1a.2 Quotation check (standing rule 5)

`tools/fs114_y2_quotes.py`: **21 of 21 FOUND** (`data/fs114/fs114-y2/quotes.out`) — Kooshi's three quotations and Question 2 in FS114-Y's brief
(Question 2 against the claim list and against the paper's text); the standing rules' four Kooshi quotations; the card's seven sentences this record
works (K1, K2, the extreme's shape, the tactic-edge sentence, the charge sentence, repeat (A), the meeting point); the claim list's C114-LOCAL-F and
de Grey's Siamese definition; CV-EXISTS, FS114-Y-PAIRSHARE and YB's third rainbow case from their open records. Self-test PASS
(`quotes-selftest.out`: an altered word MISSING, its faithful twin FOUND, the faithful quotation against the wrong file MISSING).
**What cannot be checked:** the card's statements about the proof side (N114-RD, N114-EULER, N2-SLACK, N2-ENDS, N2-KILL, N2-GSD, N2-VCAP, N2-DIAM)
are the owner's quotations or summaries of fenced records; I work them **as the card states them** and quote the card. My round-2 brief quotes nothing
but its own hand-back sentence.

### 1a.3 The shared result (the owner's message during stage 1a), and where it bears

FS114-CV's **CV-EXISTS** (one mind; `plans/FS114-CV-verification.md` theorem table, verbatim): "every valid map has a vertex of at least four colours —
in the map itself, no modification needed, no residue, no ray step". With it, the owner notes, C114-LOCAL-F alone is the NO. **Where it bears here:**
every fragment I build that holds a disc of radius `R` about a vertex of at least four colours is a point on C114-LOCAL-F's dial; only `R > φ²/√2 ≈
1.8512` (FS114-Y-DIAL, two minds) moves it. K1's fragment holds a four-colour vertex `p`, so its radius about `p` is read on that dial too.

## Stage 1a — SAVED

## Stage 1b (in progress): K1's killing test — registered before the first run (G21; both outcomes reachable)

**The second shared result** (the owner's message during stage 1b): FS114-CVB, blind, confirms CV-EXISTS (now two minds, blind to each other), needing
neither CV-HD nor C-ENDS; so C114-LOCAL-F alone is the unit-arc NO, Siamese or not, at two minds. Also, 2–1: in C114-THOM-TOP `M − x` stays connected at
a pinch point and breaks at a hole (`plans/FS114-CVB-verification.md`, open). Where it bears: as 1a.3 — every fragment here is read on C114-LOCAL-F's dial.

**The object** (`tools/fs114_y2_k1.py`, its docstring the rule in words): **the Reuleaux bowtie** — a vertex `p` where two Reuleaux triangles of width 1,
`t1 = (p, q1, q2)` and `t3 = (p, q4, q3)` (`q1 = e(30°)`, `q2 = e(−30°)`, `q3 = e(210°)`, `q4 = e(150°)`), meet corner to corner, with `t2` above and
`t4` below; all four edges at `p` are unit arcs about `q1…q4`. Twenty tiles, every point in `ℚ(√3)`, the design `D2`-symmetric with the colour maps
`(1 3)(5 6)` and `(2 4)(5 6)`. How each shape was derived (no search): §1b.1, written after the run.

**Registered predictions** (before the first run):
- faithful: **ACCEPT** on every same-colour pair; **no distinct same-colour pair at minimum below 1** (non-Siamese); every non-rim piece shared by exactly
  two tiles; the rim at distance at least `R0 = 3√3/5 ≈ 1.039` from `p`; `p` a degree-4 vertex of colours 1–4 whose four edges are unit arcs about
  `q1…q4`; each `q_i` a vertex of at least four colours (five: `t_in`, `W`, `T`, `V`, `L`); each `T_i` of the outer tile's colour, meeting the closed unit
  disc about `p` only at `q_i`. **Reachable otherwise:** a REJECT (the derivation of §1b.1 wrong at a named pair), a distinct pair at minimum below 1, a
  piece unmatched, a `T_i` touching its inner tile elsewhere.
- plant `v5` (`V` coloured 5, images by the colour maps): **REJECT exactly** `(L1,V)`, `(L4,V'')`, `(L2,V')`, `(L3,V''')`.
- plant `wide_t1` (the `T1 | W` edge leaves `q1` at 300° instead of 330°, all four images): **REJECT exactly** `(t4,T1)`, `(t4,T4)`, `(t2,T2)`, `(t2,T3)`.
- **Run 1 (faithful, `v5`, `wide_t1`), before `wide_t1b` existed:** faithful and `v5` as registered. `wide_t1` fired at the four registered pairs **and at
  two I did not register**, `(t1,W')` and `(t3,W)`: moving `c` to `q1 + e(300°)/5` also moves `W`'s rim chord `c′c` to `x ≈ 0.966`, inside the unit disc
  about `p`, so `W` reaches within 1 of `p ∈ cl t3` — a registration miss of mine, named. **Registered now, before its run:** plant `wide_t1b` (the same
  edge direction, `c = (3√3/5, 1/5)` on `W`'s unmoved rim line): **REJECT exactly** `(t4,T1)`, `(t4,T4)`, `(t2,T2)`, `(t2,T3)`.

### 1b.1 The result (`data/fs114/fs114-y2/k1.out`; plants `k1-plant-*.out`; the checker's calibration re-run, `yb-calib-rerun.out`)

**FS114-Y2-BOWTIE** [tools, exact; one mind]. The fragment of `tools/fs114_y2_k1.py` (its docstring states every tile by rule):
- **Validity:** ACCEPT on all 46 same-colour pairs (a tile with itself included; 40 examined exactly, 6 dismissed by an exact bounding-box gap ≥ 1).
- **Non-Siamese:** no distinct same-colour pair has minimum below 1. Eighteen distinct pairs touch distance 1 exactly (listed in `k1.out`); ten tiles have
  diameter exactly 1 (`t1…t4`, `L1…L4`, `W`, `W′`).
- **A map of its domain:** every non-rim piece is shared by exactly two tiles in opposite directions (YB's `consistency`); the float area sum equals the rim
  polygon's area to 12 digits; the rim's 28 segments keep distance at least `3√3/5` from `p`, attained (exact).
- **The vertex `p`:** tiles `t1, t2, t3, t4`, colours 1–4, degree 4; its four edges are unit arcs about `q1 = (√3/2, 1/2)`, `q2 = (√3/2, −1/2)`,
  `q3 = (−√3/2, −1/2)`, `q4 = (−√3/2, 1/2)`.
- **Each `q_i`:** a corner of five tiles of five colours; `T_i` has the outer tile's colour (`T1`, `T4`: 4 = `t4`; `T2`, `T3`: 2 = `t2`); and `T_i` meets
  the closed unit disc about `p` only at `q_i` (exact, piece by piece), so it meets its inner tile (`t1` or `t3`, inside that disc) at `q_i` alone. Each of
  `p`'s four edges is therefore repeat (A) of the card at the inner tile — a tactic edge.
- **Class:** a fragment (a map of a bounded open set containing the closed disc of radius `3√3/5` about `p`), not periodic, bounded complexity (at most nine
  pieces per tile), no Siamese pair, `D2`-symmetric.
- **Controls and plants.** YB's checker re-run unedited on the five controls in this session: all ACCEPT, their plants REJECT as YB registered. Plants of
  this object: `v5` REJECT exactly at the four registered pairs; `wide_t1b` exactly at the four registered pairs; `wide_t1` at the four registered pairs and
  two unregistered ones, for the reason named above.

**What it does and does not settle.** K1 as stated ("a degree-4 vertex of a non-Siamese valid map has at most two tactic edges") is about maps, and a
fragment does not refute it. What the fragment fixes: **any proof of K1 must read beyond the closed disc of radius `3√3/5 ≈ 1.039` about the vertex**, and it
must kill this configuration — two width-1 Reuleaux triangles meeting corner to corner at `p`, each carrying two tactic edges — at a named step beyond that
radius. The card says K1 "reads radius 2": so the fragment does not reach the proof's radius; the gap between 1.039 and 2 is where the proof must spend its
argument, and a proof that fails on this fragment inside radius 1.039 is wrong. On C114-LOCAL-F's dial it is below the strip (1.039 < 1.8512) and moves
nothing.

### 1b.2 How each shape was derived (no search)

- **FS114-Y2-GAPS** [hand; one mind]. Let `e` be a tactic edge from `p`, a unit arc about `q` subtending `β` at `q`, inner tile `x`, outer tile `y`, and `T`
  of `y`'s colour touching `x` at `q` alone. `x ∋ p, q` has diameter at most 1, so `x ⊂ B̄(z, 1)` for every `z ∈ e`: at `q` its cone lies within 90° of every
  direction from `q` to `e`, i.e. in `[d + β − 90°, d + 90°]`. `T` has `y`'s colour and `y ⊃ e` in closure, so `T` avoids `B(z, 1)` for `z ∈ e`: its cone
  lies in `[d + 90° + β, d + 270°]`. The two remaining cones, `[d + 90°, d + 90° + β]` and `[d + 270°, d + 270° + β]`, have width `β > 0` and hold other
  tiles; the second points into `B(p, 1)`. Any tile with a point `w`, `|w − p| < 1`, has points within `< 1` of points of every tile at `p` near `p`; in a
  non-Siamese map distinct same-colour tiles are at least 1 apart; so such a tile is a tile at `p` or has a colour absent at `p`. ∎
- **The inner tiles.** A tile at `p` inner for both its edges has angle at least 120° at `p` (its two centres are both in its closure, so at most 1 apart);
  at exactly 120° it is the Reuleaux triangle on `p` and the two centres. The bowtie takes two opposite such tiles, `t1`, `t3`.
- **The gap tiles.** By GAPS each `q_i` needs a tile inside `B(p, 1)` of a colour absent at `p` (5 or 6): `L_i`. `L1` and `L2` come within 1 of each other
  near `q1`, `q2` (the two sides of `t1` converge on `p`), so they differ; likewise `L3`, `L4`. Points of the arc of `ω(p)` between `q1` and `q4` and just
  inside it admit only colours 5, 6 or `t2` itself (colours 1, 3 and 2 are blocked by `t1`, `t3`, `t2` near `p`; 4 by `T1 ∋ q1` and `T4 ∋ q4`); `L1` and `L4`
  of one colour would both border the region over `t2`, whose width is below 1 — so the pattern is diagonal (`L1 = L3 = 5`, `L2 = L4 = 6`); two
  colour-5/6 tiles meeting inside the disc over the arc then come within 1 of the far `L`, which is why `t2` itself reaches the arc (`t2 ∋ top = (0, 1)`,
  the arc from `e(60°)` to `e(120°)`), with the four-colour vertex `top` (`t2`, `L1`, `N`, `L4`). These are design steps [hand; one mind], checked only
  through the object. `L1 ⊂ {z · e(60°) ≥ 1/2}` keeps it at least 1 from `L3 = −L1`.
- **The top.** Above `top` only colour 4 is free, in the cusp between `ω(q1)` and `ω(q4)` (outside `B(q1, 1) ∪ B(q4, 1)`): `N`. `N`'s boundary on `ω(q1)`
  up to the rim point `a` makes `T1` avoid `B(a, 1)` while `L1 ∋ top` stays in `B̄(top, 1)`: the two tangents at `q1` differ by the angle `∠top q1 a`, and
  the sliver between them needs a colour other than 1, 3, 4, 5 — 2 is blocked by `t2 ∋ m1` — so 6: `V`. `T1 | W` leaves `q1` at the least direction GAPS
  allows `T1` (330°), and `W` (colour 3, `σ_y`-symmetric) fills `t1`'s outer arc.
- The rim points (`a`, `b`, `b′`, `c` and the three between `b` and `a`) are rational points of the named circles, chosen so every point lies in `ℚ(√3)`.

## Stage 1b — SAVED
