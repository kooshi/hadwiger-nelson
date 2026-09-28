# FS114-NB5 — blind verification of FS-114's proof side, round 4 (FS114-N5)

*Job FS114-NB5, de Bruijn (Opus 5.5), launched 2026-09-28 10:06 UTC (start-up snapshot HEAD `28946790`). Brief: the template
`data/fs114/briefs/NB114-verify-proof.md` with the instance `data/fs114/briefs/NB5-114-instance.md` (the instance wins) and
`data/fs114/briefs/STANDING-RULES.md` (rule 0 read first). Working files `data/fs114/fs114-nb5/`; exact checks `tools/fs114_nb5_*.py`; scratch
`scratchpad/fs114-nb5/`. Resuming check: no record existed at start. Stage 1 is blind: every verdict is derived from the thirteen statements in the
instance file alone, before `plans/FS114-N5-proof.md` is opened.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| NB5-QT | Every quotation my brief, instance and standing rules rely on whose source is open to me at stage 1 is verbatim: 20 of 20 FOUND; plant fires | [tools] | §1a.2; `tools/fs114_nb5_quotes.py` |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|

## Fence log (standing rule 13; template and instance § Fences)

1. The harness's start-up context (not a command of mine) included the auto-memory index, a file under
   `~/.claude/projects/-home-kooshi-source-lean-dir/` (fenced): milestone status lines, no proof content. No file under that path opened by me.
2. `ls data/fs114/briefs/` and `ls data/fs114/` (sizing the reading) printed the **names** of every brief and working directory, among them
   `N5-114-proof-round4.md`, `Y4-114-construction-round4.md`, `fs114-n5`, `fs114-y4`, `fs114-yb2`; none opened.
3. `git log --oneline -8` at start-up showed one subject beyond the start-up snapshot: `645ecd06 FS-114: proof round 4 logged; its blind verifier
   launched` (the owner's). Subject only.
4. `grep -n '^#' plans/FS114-unit-arc-question.md` printed the **heading line** of stage 5.3 (the registered expectations, fenced until my stage 1 is
   committed). Heading only; the section not read.

## Stage 1a — SAVED: reading and the quotation check

### 1a.1 Read from disk (G50)

- `data/fs114/briefs/NB114-verify-proof.md`, `NB5-114-instance.md`, `STANDING-RULES.md` in full; `CLAUDE.md` § The aim, § Counter-priors, G83, G82,
  G79, G71, G60, G21, G15, G13, G51 (loaded in context).
- `LEDGER.md` rows 131–136 (134–136 in full; 131–133 to their Not-claimed clauses).
- `data/fs114/claims.md` in full; `data/fs114/briefs/ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md` in full.
- `plans/FS114-unit-arc-question.md` §G part 3, §PA, §IQ, stage 5b (not 5.3).
- `data/fs114/briefs/N114-proof.md` in full (its § Reading, as the template directs).
- `plans/FS114-N4-proof.md`, `plans/FS114-NB4-verification.md`, `plans/FS114-N3-proof.md` in full (open to me by the instance).
- `plans/FS112-derivation.md` header and §1 (U1, SIX, NB4P, A4SIX, L60, LOCK, BEND, ISO, N2-BENDS, N2-RED, FLANK, END, N2-FLANK-Q, N2-RAY, N2-TERM,
  N2-DENSE, DISC1) and FS112-N3-COR3's statement; `plans/FS112-N-proof.md` stage N2-3 (N2-SIGN, N2-ENV, N2-TOWARD, N2-AWAY, N2-TAN, N2-RED) and its
  header's N-E0/N-E1/N-E2 line.
- `plans/FS114-L60-audit.md` header, theorem table, logs and §1.1–1.3 (ii).

### 1a.2 The quotation check (standing rule 5)

`tools/fs114_nb5_quotes.py data/fs114/fs114-nb5/quotes.tsv` (whitespace collapsed, `**` removed, nothing else normalised) checks 20 quotations: Kooshi's
five in the standing rules; the instance's N4-FIVE scope clause "with the lune rings free of `Γ`" against `plans/FS114-N4-proof.md`; FS112-L60 as printed;
the L60 audit's corrected bound; FS112-N3-COR3, the (Q)/(R2) definitions and FS112-N2-RED against `plans/FS112-derivation.md`; the one-line statements of
N2-TOWARD, N2-AWAY, N2-TAN against `plans/FS112-N-proof.md`; the round-4 card's N4-BOWTIE and L60 sentences; N4-D's and N4-G's headlines; N3-DR1's and
N3-FACE's statements. **20 of 20 FOUND** (`data/fs114/fs114-nb5/quotes.out`, exit 0). The first run had row 20 at a wording of my own guess (NOT FOUND);
replaced by the card's sentence — a defect of my TSV, not of a source. **Plant** (`--plant`: one word of the first quotation altered): the altered copy
NOT FOUND, its faithful twin FOUND (`quotes-plant.out`, exit 0). By hand: the card's L60 summary ("at most 60°, not below; at 60° both side tiles lie in
the lens of its ends") is faithful to the audit's L60-LE and L60-EQ. **Not checkable at stage 1:** the thirteen statements of the instance are FS114-N5's,
copied by a script from its record, which is fenced until this stage is committed; they are checked at stage 2.

## Stage 1a — SAVED

## Stage 1b — SAVED: blind derivations, part 1 (setting; N5-SIGHT; the priority claims N5-UP, N5-DEG, N5-R0, N5-ΓRING)

*Derived from the instance's thirteen statements alone; `plans/FS114-N5-proof.md` not opened. Grades are `CLAUDE.md` § Notation's; "one mind" is
mine. Metric facts: `tools/fs114_nb5_check.py` (`data/fs114/fs114-nb5/check.out`, 21 of 21 OK; plant `--plant` moves the gap point of the (R-V) kill
from direction 60° to 70° about `top` and fails exactly its three G lines, because at 70° the point lies inside `B(P90′, 1)`: `check-plant.out`).*

### 1b.0 Setting and tools

N4's frame: `p = 0`; `q1 = e(30°)`, `q2 = e(−30°)`, `q3 = e(150°)`, `q4 = e(210°)`; `t1 = Reul(p, q1, q2)` (colour 1), `t3 = Reul(p, q3, q4)` (3);
`t2` (2) in the top lune, cone `[60°, 120°]` at `p`; `t4` (4) in the bottom lune. Tactic edges `t1|t2 ⊂ ω(q2)` (partner `z2` at `q2`), `t3|t2 ⊂ ω(q4)`
(`z2′`), `t1|t4 ⊂ ω(q1)` (`z4` at `q1`), `t3|t4 ⊂ ω(q3)` (`z4′`). Absent at `p`: 5, 6. `top = e(90°)`, `P90 = q1 + e(90°)`, `P90′ = q3 + e(90°)`. At `q1`,
`t1`'s cone is `[180°, 300°]` and the lune wedge is `(120°, 180°)`; at `q3`, `[240°, 360°]` and `(0°, 60°)`. **Class:** non-Siamese, simple (N4's). Tools,
re-derived: **E0**, **E1**, **FAR** (distinct same-colour tiles are `≥ 1` apart; closures have diameter `≤ 1`), **FACE** (N3-FACE), **LENS** (N4-LENS), **OWN**
(N4-OWN: `2 ∉ P_cl(q1), P_cl(q3)`, `4 ∉ P_cl(q2), P_cl(q4)`; its proof reads only the four edge circles, so it holds whatever the rings carry), **LUNE**
(NB4-LUNE: inside `B(p, 1)` near the top lune only `t2` and colours 5, 6), **TANG** (N4-TANG and its mirror at `q3`). **Ring colour** at `q1`: the colour
`X` of the tile at `q1` in the lune wedge (only absent colours fit there, by LENS at `p` and OWN); likewise `X′` at `q3`. **`κ(θ)`** as the instance defines it.

**Two facts used throughout (hand, one mind).**
- **U1-RING.** A `Γ`-arc of `ω(p)` in the top ring has inner colour in `{2, 5, 6}` (LUNE) and outer colour in `{4, 5, 6}`: by FS112-U1 an outer colour
  `c ∈ P_cl(p)` needs `p`'s `c`-tile to have its cone in the cone of width `180° − ℓ` facing away from the arc, which `t1` (`[300°, 60°]`), `t2`, `t3` fail
  for every arc in `(30°, 150°)` and `t4` (`[240°, 300°]`) passes.
- **OUT4.** An outer tile `O` of colour 4 of such an arc is `z4` or `z4′`, and then the arc lies in `(30°, 90°]` or `[90°, 150°)` respectively. *Proof:* if
  `O ∉ {z4, z4′}` it is far from both, so it misses `B(q1, 1)` and `B(q3, 1)`; its arc points `e(θ)` then need `θ ≥ 90°` and `θ ≤ 90°`. If `O = z4`, `O ∋ q1`
  and diameter gives `θ ≤ 90°`. ∎ So **every arc of outer colour 4 has `z4` or `z4′` as its outer tile, and each of those meets `B(top, 1)`**.

### 1b.1 N5-SIGHT — TRUE (non-Siamese) [hand, one mind]

*Derivation.* Let `T′` be a tile of `T`'s colour at `v` meeting `B(u, 1)`. If `T′ = T`, then `u, v ∈ cl T` and `T ⊂ B̄(v, 1)`, so `T`'s cone at `u` lies in
`{d · (v − u) ≥ 0}`, the closed half-plane facing `v`: against the hypothesis. If `T′ ≠ T`, a point `x ∈ T′` with `|x − u| < 1` is within `< 1` of `T`'s
points near `u`: close, so Siamese. ∎ `|u − v| = 1` is used only to make the first case meaningful; the second case needs nothing but non-Siamese. *Reads:*
`B̄(u, 1)`.

### 1b.2 N5-UP — TRUE [hand, one mind]

*Derivation.* `T` at `top`, `90°` in its cone. The closed half-planes at `top` facing `p`, `q1`, `q3` are `[180°, 360°]`, `[240°, 60°]`, `[120°, 300°]`; none
contains `90°` (tools H1). SIGHT at `(top, p)`: `t1, t2, t3` meet `B(top, 1)` (tools H2), so `colour(T) ∉ {1, 2, 3}`; `t4` lies in the closed bottom lune, in
`{y ≤ 0}`, and misses `B(top, 1)`. So `colour(T) ∈ {4, 5, 6}`. SIGHT at `(top, q1)` and `(top, q3)` gives the next two clauses (the first by its case
`T′ = T`). The ring tile at `q1` (colour `X`) holds points `(1 − ε)e(30° + δ)`, within `< 1` of `top`; likewise at `q3`; so `colour(T) ∉ {X, X′}`, and if
`colour(T) = 4`, `z4` and `z4′` (the colour-4 tiles at `q1`, `q3`) miss `B(top, 1)`. ∎ *Reads:* `B̄(top, 1)` and the tiles at `p, q1, q3` — inside `B̄(p, 2)`.

### 1b.3 N5-DEG — TRUE [hand, one mind]

*Derivation.* After the bends every ring arc has outer colour 4 (N5-BEND, §1c). With `X ≠ X′`, `{X, X′} = {5, 6}` and N5-UP forces `colour(T) = 4`, so
`z4, z4′` miss `B(top, 1)`; by OUT4 no arc survives (its outer tile would be `z4` or `z4′`, which meet `B(top, 1)` at the arc's points). The ring is
`Γ`-free; by NB4-RING it is degenerate or general, and the general member has `X′ = X` (its tile `U3` at `q3` has `U1`'s colour). So it is degenerate, and
N4-D (two minds) excludes it reading `B̄(p, √3)`, the top lune alone. **Radius note:** the bends can be run on a fragment on (a small neighbourhood of)
`B̄(p, √3)` itself — restrict first; no (R2) witness is then visible, so only (Q) arcs are kept, and OUT4 kills those too. So the whole statement reads `√3`.

### 1b.4 N5-R0 — TRUE [hand, one mind; a route different from the statement's parenthesis]

*Derivation.* Residual: `X = X′`, `colour(T) = X̄`; neither corner carries `X̄`.
1. *Corners.* At `q1`: `t1` `[180°, 300°]`; the wedge `(120°, 180°)` holds only absent colours, `X̄` excluded, so it is the ring tile `U1` (`X`), adjacent
   to `t1`. The cap tile (sharing `t1`'s cap edge at `300°`) is not 1, 2 (OWN), 4 (`z4` touches `t1` at `q1` alone), `X` (`U1`'s cone is one interval),
   `X̄`: **colour 3, `C`**. Nothing else fits (every colour is used once). So `q1 = t1 | C | z4 | U1`, degree 4; mirror `q3 = t3 | C′ | z4′ | U3`, `C′` of colour 1. ✓
2. *`C ∋ q2` forces `z4` to start at `≤ 0°`.* `C ⊂ B̄(q2, 1)` puts `C`'s cone at `q1` in `[180°, 360°]`, so `z4`, next after `C`, has a direction `d ≤ 0°`
   (mod 360°) in its cone.
3. *Then `z4` bounds no ring arc.* If `e(θ) ∈ cl z4` for a ring point `θ ∈ (30°, 90°]`, then `z4 ⊂ B̄(e(θ), 1)` and its cone at `q1` lies in
   `{d · (e(θ) − q1) ≥ 0}`; every `d ∈ [300°, 360°]` has `d · (e(θ) − q1) < 0` there (tools R1). Mirror: with `C′ ∋ q4`, `z4′` bounds none.
4. *So the ring is `Γ`-free after the bends* (OUT4: every surviving arc has outer tile `z4` or `z4′`), with `X = X′`: **N4's general member** (NB4-RING).
5. *N4-G (two minds) excludes it*: its item 1 is exactly `C ⊂ B̄(q2, 1)` and the mirror `C′ ⊂ B̄(q4, 1)`, both hypotheses here; its items 2–3 read the top
   lune only. ∎
*Reads:* `B̄(p, √3)` (N4-G's `P90`, `P90′`) and `q2, q4`. **Divergence of route, to check at stage 2:** the statement's parenthesis ("`t2 ∌ top`; `T`
touches the ring on both sides of `top` …; N4-G's diameter kill at whichever side `t2` reaches, and N5-DR1 if it reaches neither") suggests a case split
I do not need: in my derivation the hypothesis `C ∋ q2`, `C′ ∋ q4` makes the ring `Γ`-free outright, and then it is N4-G's own setting.

### 1b.5 N5-ΓRING — TRUE as stated; my derivation reaches further: (R-V) is excluded too [hand, one mind]

*The reduction (TRUE).* After the bends, per lune: `X ≠ X′` → degenerate (N5-DEG), dies alone; `X = X′`, `colour(T) = 4` → general (N5-W); `X = X′`,
`colour(T) = X̄` → a corner carries `X̄` (at most one: N5-XBAR) — (R-V) — or none — (R0). Exhaustive by N5-UP (`colour(T) ∈ {4, 5, 6} ∖ {X, X′}`). In a
general or (R0) lune both corners are degree 4 with cap tiles of colours 3 (at `q1`, `q2`) and 1 (at `q3`, `q4`) — §1b.4 item 1 and its mirrors — and two
distinct colour-3 tiles at `q1`, `q2` are impossible (FACE: the cap tile's cone at `q1` contains `300°+`, which does not face away from `q2`), so `C ∋ q2`;
likewise `C′ ∋ q4`. Hence with both lunes in `{G, R0}`, N4-G or N5-R0 kills each; a degenerate lune dies alone. So **every pair of lunes not involving
(R-V) dies**, reading `√3` in my derivation (the statement says 2; `√3` is stronger and suffices, §1b.3's radius note).

*(R-V) itself (my derivation; the claim N5-RV marks it "Not excluded").* Top lune in (R-V): `X = X′`, `colour(T) = X̄`, `q1` carries `X̄` (tile `V1`).
1. By N5-XBAR (§1c): a (Q) arc `(a, 90°)`, outer `z4`, inner `t2`, ends at `top`; `q3` carries no `X̄`.
2. *`T ⊂` outside `B(q1, 1)`*: `T ≠ V1` (N5-UP), both `X̄`, far, and `V1` has points near `q1`. So `T`'s cone at `top` lies in `[60°, 240°]`.
3. *`z4` at `top`*: it is the outer tile of the (Q) arc up to its end, so its cone at `top` contains `0°`; `z4 ⊂ B̄(q1, 1)` puts it in `[240°, 60°]`.
4. *Nothing else can hold a direction in `(0°, 90°)` at `top`*: colours 1, 3 are absent at `top` (FACE against `t1` at `q1`, `t3` at `q3`); 2 only by `t2`,
   cone in `[180°, 360°]`; 4 only by `z4`; `X̄` only by `T`; an `X`-tile at `top` has its cone in `[240°, 300°]` (SIGHT at `(top, q1)` and `(top, q3)`: `U1`,
   `U3` meet `B(top, 1)`). So **`z4`'s cone ends and `T`'s begins at exactly `60°`**.
5. *`T ∋ P90′`.* In the lens `L′ = B(q3, 1) ∩ B(top, 1)` near its corner `P90′` (the sector `(240°, 360°)` there) every colour is carried at `q3`
   (`{3, 1, 4, X}`, degree 4 as in §1b.4 item 1: `q3` carries no `X̄`) or at `top` (`{4, X̄, 2}`), so LENS leaves: 3 → `t3`, 2 → `t2` (both in `B̄(p, 1)`,
   `|P90′| = √3`); 4 → none (`z4′ ≠ z4`); `X` → `U3`, which misses a neighbourhood of `P90′` (TANG at `q3`; tools T1); 1 → `C′`, **which misses
   `P90′`**: `C′` is `q3`'s cap tile, its cone contains directions just below `240°` (the cap edge leaves `q3` at `240°`), and `C′ ∋ P90′` would need its
   cone in `[0°, 180°]` (tools C1, C2) — this needs no hypothesis on the bottom lune; `X̄` → `T`. So `P90′ ∈ cl T` and **`T ⊂ B̄(P90′, 1)`**.
6. *The gap.* `ω(q1)` and `ω(P90′)` are externally tangent at `top`, both with tangent `60°` there (`|q1 − P90′| = 2`, midpoint `top`; tools D5). The point
   `x = top + t·e(60°)` has `|x − q1|² = |x − P90′|² = 1 + t²` (tools G1–G3): outside `B̄(q1, 1) ⊇ cl z4` and outside `B̄(P90′, 1) ⊇ cl T`. For small `t` it
   lies in the closure of a tile at `top` whose cone contains `60°` (item 4: `z4` or `T`), and it is in neither. **Contradiction.** ∎
So **(R-V) does not exist on `B̄(p, √3)`** (a neighbourhood of it: `P90′` and `top`), whatever the bottom lune does, and with it — every lune now dying or
reducing to `{G, R0}` pairs — **the Reuleaux bowtie (non-Siamese, simple), with any lune rings, does not exist on `B̄(p, √3)`**: K1-ΓRING closed in that
scope, in my derivation. *Audit note (G21): this is the verdict that flatters the NO most; the steps a second mind should take first are item 4 (the colour
exhaustion at `top`, which is the kill) and item 5's colour-1 step (`C′ ∌ P90′`, which frees it from the bottom lune). Plant: at direction `70°` the point
is inside `B(P90′, 1)` and the kill evaporates (`check-plant.out`), as it must.* The mirror: (R-V) at `q3` dies at `P90` by the same argument.

## Stage 1b — SAVED
