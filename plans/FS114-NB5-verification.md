# FS114-NB5 — blind verification of FS-114's proof side, round 4 (FS114-N5)

*Job FS114-NB5, de Bruijn (Opus 5.5), launched 2026-09-28 10:06 UTC (start-up snapshot HEAD `28946790`). Brief: the template
`data/fs114/briefs/NB114-verify-proof.md` with the instance `data/fs114/briefs/NB5-114-instance.md` (the instance wins) and
`data/fs114/briefs/STANDING-RULES.md` (rule 0 read first). Working files `data/fs114/fs114-nb5/`; exact checks `tools/fs114_nb5_*.py`; scratch
`scratchpad/fs114-nb5/`. Resuming check: no record existed at start. Stage 1 is blind: every verdict is derived from the thirteen statements in the
instance file alone, before `plans/FS114-N5-proof.md` is opened.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| NB5-QT | Every quotation my brief, instance and standing rules rely on is verbatim: 20 of 20 at stage 1; the thirteen N5 statements 13 of 13 at stage 2; plant fires | [tools] | §1a.2, §2.2; `tools/fs114_nb5_quotes.py` |
| NB5-OUT4 | In the Reuleaux bowtie every ring arc of outer colour 4 has outer tile `z4` (then in `(30°, 90°]`) or `z4′` (`[90°, 150°)`) | [hand, one mind] | §1b.0 |
| NB5-SIGHT | N5-SIGHT: TRUE in the non-Siamese class | [hand, one mind] | §1b.1 |
| NB5-UP, -DEG, -W | N5-UP, N5-DEG, N5-W: TRUE | [hand, one mind; DEG over N4-D, two minds] | §1b.2, 1b.3, 1c.6 |
| NB5-R0 | N5-R0: TRUE — with `C ∋ q2`, `C′ ∋ q4`, `z4` and `z4′` bound no ring arc, so the ring is `Γ`-free, general, and N4-G kills it | [hand, one mind; over N4-G, two minds] | §1b.4 |
| NB5-RVKILL | **(R-V) does not exist on `B̄(p, √3)`**: `T ⊂ B̄(P90′, 1)`, `z4 ⊂ B̄(q1, 1)`, and the direction `60°` at `top` between the externally tangent `ω(q1)`, `ω(P90′)` has no colour; no hypothesis on the bottom lune | [hand, one mind; tools exact at named points] | §1b.5; `tools/fs114_nb5_check.py` G, C, T, D5 |
| NB5-BOWTIE | **The Reuleaux bowtie (non-Siamese, simple) with any lune rings does not exist on `B̄(p, √3)`** (after the bends): K1-ΓRING closed in that scope, over NB5-RVKILL, N5-DEG, N5-R0, N4-D, N4-G | [hand, one mind] | §1b.5 |
| NB5-GRING | N5-ΓRING: TRUE as stated (the reduction), at `√3` | [hand, one mind] | §1b.5 |
| NB5-BEND, -BENDG | N5-BEND: TRUE, its length bound derived for (R2) arcs only (GAP if read for (Q) arcs); N5-BENDG: TRUE | [hand, one mind; over N2-TOWARD, -AWAY, -TAN] | §1c.1, 1c.5 |
| NB5-KAPPA, -XBAR, -DR1 | N5-KAPPA (in the interior sense of "60° apart"), N5-XBAR, N5-DR1: TRUE | [hand, one mind] | §1c.2, 1c.3, 1c.7 |
| NB5-RV | N5-RV: structural clauses TRUE (`q1 = t1 | V1 | (W3) | z4 | U1` as stated; my stage-1 "no `W3`" withdrawn at stage 2, §2.5); **"Not excluded" FALSE** (NB5-RVKILL) | [hand; clauses two minds, one blind; the kill one mind] | §1c.4, §2.4, §2.5 |
| NB5-PIN0 | N5-PIN0: structural clauses TRUE; "no contradiction at `1 + ε`" not established | [hand, one mind] | §1c.8 |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|
| a formula fragment for (R-V) at `1 + ε`, pushed outward | derived the kill at `√3` (§1b.5) |
| a scan of the (Q) arc's end `a` for a length bound | recorded as not derived (§1c.1) |
| enumerate the tiles at `top`, `q1`, `P90` | colour-by-colour exclusion by hand (§1b.5, §1c.4) |

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

*Dated note (FS129-Z2, 2026-10-03; the text above stands as written).* The radius note's "restrict first" holds for the **whole-tile restriction** of radius at most `√3` — the tiles meeting the open disc, each with its whole closure (FS129-OR1-WHOLE) — and not for a round neighbourhood: a fragment's tiles are the components of its open set minus `Γ`, so a round restriction can cut one tile into two pieces of one colour less than 1 apart (a Siamese pair) and can disconnect the meeting set of two closures (non-simple) (`plans/FS129-OR1-audit.md` § J1 and its control `fs129-or1-cut`). The sentence is true about the arcs — a round restriction also removes every non-(Q) ring arc — but does not carry class membership (`plans/FS129-SR1-audit.md` § 2.3). On the whole-tile restriction the bends keep validity, non-Siamese, simplicity and `p`'s colours and leave only the (Q) arcs (FS129-OR1-BENDFRAG; at any `k`, FS129-SR1-BENDANY; derived, one mind, kernel pending). Source: FS-129 inventory items 59, 96.

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

## Stage 1c — SAVED: blind derivations, part 2 (N5-BEND, -KAPPA, -XBAR, -RV, -BENDG, -W, -DR1, -PIN0); the stage-1 table

### 1c.1 N5-BEND — TRUE, with one scope reading [hand, one mind, over FS112-N2-TOWARD, N2-AWAY, N2-TAN (two minds each)]

*Derivation.* A ring arc of the top lune has inner colour in `{2, 5, 6}` and outer in `{4, 5, 6}` (U1-RING). Outer 5 or 6 is absent at `p`: N2-TOWARD
bends it toward `p`, ends included, into its inner tile's sectors. Outer 4 with inner 5 or 6 and no inner-colour tile along the radius-2 circle: N2-AWAY
bends it away; isolated radius-2 contacts are cleared by N2-TAN. What is left: outer 4 with inner `t2` (the centre carries 2, 4 and four colours: **(Q)**),
or outer 4 with inner absent and a witness along an arc of the radius-2 circle (**(R2)**). *Kept:* the lenses lie at the ring, inside the arc's side tiles'
sectors at its ends, with corner angle chosen small; the four tactic edges are arcs of `ω(q_i)` leaving `p`, the caps are arcs of `ω(p)` outside the lune
rings, and the partners keep their points at the corners (a bend at an arc ending at `q1` recolours a small corner lens only, and `t2 ∌ q1` by OWN). The
bends add no colour at `p` or at any `q_i` except, possibly, the second absent colour at a corner (a toward bend of an arc ending there) — which is why the
ring colours must be read after the bends. *Length:* for an (R2) arc the witness is one tile (two inner-colour tiles along one connected witness arc would
be close), its closure holds `2e(θ)` across the arc, so `4 sin(ℓ/2) ≤ 1`, `ℓ ≤ 2 arcsin(1/4) ≈ 28.955°` (tools B1). **For (Q) arcs I derive no such bound**:
a (Q) arc has outer tile `z4` (OUT4) and lies in `(30°, 90°]`, and FS112-L60 (corrected, "at most 60°") is all I have. So I read the statement's "each of
angular length at most `2 arcsin(1/4)`" as applying to the (R2) arcs; read as applying to (Q) arcs too, it is a GAP in my derivation. *Reads:* a
neighbourhood of `B̄(p, 2)` (the witness circle), as stated.

### 1c.2 N5-KAPPA — TRUE [hand, one mind]

*Derivation.* (i) `κ(θ + 60°) ≠ κ(θ)`: both off `Γ` — E0 on the ring; one on an (R2) arc with inner colour `c`, the other interior to a `c`-tile — the inner
tile's points `(1 − ε)e(θ)` and that tile's points `(1 ± η)e(θ + 60°)` are at distances on both sides of 1: E0; both on (R2) arcs — excluded by (ii).
(ii) Every surviving arc has outer colour 4; two arcs whose 60°-rotations overlap in an interval give outer points `(1 + a)e(θ)`, `(1 + b)e(θ + 60° + γ)`,
`γ < 0`, at distance `< 1`, and the same tiles hold pairs at distance `> 1`: E0 (tools K1). The statement's "never 60° apart" is true in this interior
sense; arcs meeting 60° apart only at an end point are not excluded by this argument (tools K2). (iii) An arc containing `top` in its interior would have
its outer tile `z4` or `z4′` (OUT4), which confine it to `θ ≤ 90°` or `θ ≥ 90°`. (iv) N5-ONE: a constant-`κ` stretch is one tile (ring tiles and (R2) inner
tiles of one colour within angular distance `< 60°` are close, hence equal), so NB4-RING's argument runs verbatim: at most one change in `(30°, 90°)`. ∎
*Reads:* `B̄(p, 1 + ε)` and the outer tiles.

### 1c.3 N5-XBAR — TRUE [hand, one mind]

*Derivation.* Residual, `V1` of colour `X̄` at `q1`. `V1 ∩ B(top, 1) = ∅` is N5-UP. `κ ≠ X̄` on `(30°, 90°)`: an `X̄` ring tile or (R2) inner tile there is
within `< 1` of `q1`, so it is `V1`, which would then meet `B(top, 1)`. `κ(150° − δ) = X` (the ring at `q3` is in `U3`; a (Q) arc cannot end at `q3`, OWN),
so `κ(90° − δ) ≠ X`, hence undefined: a (Q) arc covers `(90° − δ₀, 90°)`, ends at `top` (N5-KAPPA (iii)), outer `z4` (OUT4). `z4 ∋ q1, top` gives
`z4 ⊂ B̄(q1, 1) ∩ B̄(top, 1)`; its cone at `q1` lies in `[60°, 240°]` (facing `top`) and `[300°, 120°]` (FACE against `t4`): `[60°, 120°]`. *Just after 90°*: an
arc there would have outer tile `z4′`, at `top` beside `z4` — close; so the ring is off `Γ` there, in an `X̄` tile (an `X` tile there would be close to `U1`'s
ring points near `30°`), which is `T` (one `X̄` tile at `top`). *At most one corner:* at both, (Q) arcs with outer `z4` and `z4′` would both end at `top`. ∎
*Reads:* `B̄(p, 1 + ε)` and `B̄(top, 1)`.

### 1c.4 N5-RV — structural clauses TRUE (one sharpened); "Not excluded" FALSE in my derivation [hand, one mind]

*Derivation of the clauses* (R-V at `q1`; the order at `q1` needs no bottom-lune hypothesis):
- *`V1 ∌ P90`*: E1 at `P90`. `T`'s cone at `top` contains `[60°, 180°]` (§1b.5 item 4 and XBAR), so its interior crosses `ω(P90)`, whose tangent at `top` is
  `120°`: `X̄ ∉ P_cl(P90)`.
- *`P90` carries only 1, 3, 4*: E1 at `P90` also removes `X` (`U1`'s interior at `q1` holds `ω(P90)`'s branch leaving `q1` at `180°`) and 2 (`t2`'s cone at `top`
  is `[β, 360°]` with `β ≤ 300°`, since an `X`-tile there lies in `[240°, 300°]` and `T` in `[60°, 240°]`; it holds `ω(P90)`'s branch leaving `top` at `300°`).
- *The half-plane `(0°, 180°)` at `P90` only 1, 3*: a colour-4 tile at `P90` other than `z4` is close to `z4`, which holds `top + s·e(30°)` (interior of its
  cone `[0°, 60°]` at `top`) at distance `1 − s` from `P90`; `z4 ⊂ B̄(q1, 1) ∩ B̄(top, 1)` has its cone at `P90` in `[180°, 300°]`.
- *`q1`'s cap tile is `V1`, cone containing `[300°, 0°]`, `q1 = t1 | V1 | (W3) | z4 | U1`*: the sector `(300°, 360°)` at `P90` can hold only colour 3 (a
  colour-1 tile at `P90` faces away from `t1` at `q1`: `[0°, 180°]`; colour 4 as above), so a colour-3 tile `C3` sits at `P90` with cone `⊇ [300°, 360°]`; its
  interior then holds `ω(q1)`'s branch leaving `P90` at `0°`, so by E1 at `q1`, **`3 ∉ P_cl(q1)`**: `W3` does not exist. The direction `0°+` at `q1` carries
  `ω(P90)`'s branch; not `3`, so it is in `V1`. With `V1 ⊂` outside `B(top, 1)` (cone in `[240°, 60°]`) and `z4`'s cone in `[60°, 120°]`: **`q1 = t1 | V1 | z4 |
  U1`, degree 4, `V1`'s cone exactly `[300°, 60°]`, and the `V1 | z4` edge runs along `ω(top)` from `q1`.** The statement's optional `(W3)` is therefore empty
  (a sharpening, not a disagreement of truth).
- *`T ∋ P90′`*: §1b.5 item 5 (no hypothesis on the bottom lune needed; the statement's "`C′ ∋ q4`" is not used).
- **"Not excluded: K1-ΓRING is GAP at (R-V)" — FALSE in my derivation**: (R-V) dies at `B̄(p, √3)` by §1b.5 items 2–6 (the direction `60°` at `top` lies
  between two externally tangent unit circles, `ω(q1) ⊇ ∂`-side of `z4` and `ω(P90′)` bounding `T`, and no colour is left for it). **The brief's question
  answered:** yes, (R-V) is excluded within radius 2 — at `√3` — and the step is the colour exhaustion at `top` in direction `60°`, after `T ⊂ B̄(P90′, 1)`.

### 1c.5 N5-BENDG — TRUE [hand, one mind]

It is N2-RED's classification restricted to arcs centred at one vertex: N2-TOWARD removes every arc whose outer colour is absent at the centre, N2-AWAY and
N2-TAN every arc whose inner colour is absent there and lacks radius-2 support along an arc. Nothing in it uses degree 4 (it reads `P_cl(p)` and the
radius-2 circle). "Survives … only if" is exactly what the lemmas give; the converse (that such arcs cannot be removed by other moves) is not claimed.

### 1c.6 N5-W — TRUE [hand, one mind]

`colour(T) = 4`: N5-UP makes `z4, z4′` miss `B(top, 1)`; by OUT4 no arc survives the bends; with `X = X′` NB4-RING leaves only the general member. ∎

### 1c.7 N5-DR1 — TRUE [hand, one mind; N3-DR1 re-derived with (R2) arcs]

The `X`-stretch `(30°, s)` is one tile `U1 ∋ q1` (§1c.2 (iv)), the stretch `(s + 60°, 150°)` one tile `U3 ∋ q3`; far (diameter), so FACE puts their
cones at `y′`, `y″` on opposite sides of `n = y″ − y′`. The `X̄`-stretch tile lies in `B̄(y′, 1) ∩ B̄(y″, 1)` and misses `y′ ± tτ`, `y″ ± tτ`
(`τ = e(s + 30°)`). At a change point that is an edge point, N3-PAIR puts the edge on the other change point's circle, so the `X` tile holds both tangent
rays; at an (R2) end the outer `z4` / `z4′` is present. Unblocked, `y′ ± tτ ∈ U1` and `y″ ± tτ ∈ U3` are `X` points at distance 1. Outside, colours 1, 3
are excluded at `y′, y″` (FACE against `t1`, `t3` at `p`), 2 by `t2 ⊂ B̄(p, 1)`, and a colour-4 tile at `y′` is `z4` (within `< 1` of `q1`); inside, only `t2`.
So `t2` reaches `y′` or `y″`, and `z4` reaches `y′` or `z4′` reaches `y″`. ∎

### 1c.8 N5-PIN0 — every structural clause TRUE; "No contradiction at this radius" not established [hand, one mind]

With `e_j` between `t_j` and `t_{j+1}`, inner `t_{j+1}`, centre `q_j = p + e(θ_j + 90°)` (N3-HALF (a) puts the centre on the inner side). `α_j ∈ [60°, 180°]`:
N3-SEC. `t_j ⊂ B̄(p, 1) ∩ B̄(q_{j−1}, 1) ∖ B(q_j, 1)`: diameter, and far from the partner at `q_j`; hence its ring contacts. `c_j, c_{j−1} ∈ P_cl(q_{j−1})`:
`t_j` and the partner. `c_{j+1} ∉`: N3-HALF (b) (`t_{j+1}`'s cone meets the open half-plane facing `q_{j−1}` unless `α_j = 180°`, and `t_{j+1} ∋ q_{j−1}`
needs `|q_j − q_{j−1}| ≤ 1`, i.e. `α_j = 60°`). `c_{j+2} ∉` when `α_j + α_{j+1} < 180°`: the same, `|q_{j+1} − q_{j−1}| ≥ √3` (tools P1). The last clause is
SIGHT at `(q_{j−1}, p)`. "No contradiction" is a claim of existence at `1 + ε`; I derived none and built no fragment: consistent, not established.

### 1c.9 Radii read, the controls, six

| claim | verdict (stage 1) | radius it reads (derived) |
|---|---|---|
| N5-UP | TRUE | `B̄(top, 1)` and the tiles at `p, q1, q3` (within `B̄(p, 2)`) |
| N5-DEG | TRUE | `√3` (N4-D), the bends run on a `√3` fragment |
| N5-R0 | TRUE (route differs) | `√3` (N4-G's `P90, P90′`) and `q2, q4` |
| N5-ΓRING | TRUE; my derivation also excludes (R-V) | `√3` (stated 2) |
| N5-BEND | TRUE, the length bound for (R2) only | a neighbourhood of `B̄(p, 2)` |
| N5-KAPPA | TRUE ("60° apart" in the interior sense) | `B̄(p, 1 + ε)` |
| N5-XBAR | TRUE | `B̄(p, 1 + ε) ∪ B̄(top, 1)` |
| N5-RV | clauses TRUE (no `W3`); "Not excluded" **FALSE** | `√3` (`P90`, `P90′`) |
| N5-SIGHT | TRUE (non-Siamese) | `B̄(u, 1)` |
| N5-BENDG | TRUE | the centre's ring and its radius-2 circle |
| N5-W | TRUE | `B̄(top, 1)` |
| N5-DR1 | TRUE | `B̄(p, 1 + ε)` |
| N5-PIN0 | clauses TRUE; "no contradiction" not established | `1 + ε` |

**Controls.** The strip and the disk hold no Reuleaux bowtie (their four-colour vertices carry arcs centred at them, not tactic edges forming two Reuleaux
triangles; NB4 §1c.3 checked the same), so every kill above fails on them at its hypothesis and none is refuted by them; N5-SIGHT and N5-KAPPA's E0 steps
hold on both (they are true statements about every non-Siamese valid map). **Six is spent** at colour exhaustions: `top`'s outward tile (N5-UP), the
direction `60°` at `top` in (R-V), the sector `(300°, 360°)` at `P90`, and N4-D's and N4-G's steps; with a seventh colour each has a colour left.
**C114-FIVE-COUNT:** not applicable — no claim is a counting claim.

### 1c.10 Would-have-searched log (added)

- A formula fragment for (R-V) at radius `1 + ε`, to see whether it survives to `√3` → not built; the derivation reached the kill (§1b.5).
- A scan of the (Q) arc's end `a` for a length bound → not done; the bound is recorded as not derived (§1c.1).

## Stage 1c — SAVED (end of the blind stage)

## Stage 2 — SAVED: FS114-N5's record read; divergences; verdicts after reading

### 2.1 Read (after stage 1's commit `d0f68196`)

`plans/FS114-N5-proof.md` in full (header, theorem table, logs, stages 1–4); `tools/fs114_n5_ring.py` read and re-run by me: `RESULT OK`, output identical
to `data/fs114/fs114-n5/ring.out`; its `--plant` (`top` at `e(80°)`) fails exactly the six lines its record names (my copies in `scratchpad/fs114-nb5/`).

### 2.2 The quotation check of the instance against N5's record (standing rule 5)

`tools/fs114_nb5_quotes.py data/fs114/fs114-nb5/quotes-n5.tsv` (the thirteen statements, extracted from the instance by script): **13 of 13 FOUND** verbatim in
`plans/FS114-N5-proof.md` (`quotes-n5.out`, exit 0). The owner's script-copy did its job; no paraphrase.

### 2.3 Divergences from my stage-1 verdicts (each with both addresses)

| # | claim | kind | mine (stage 1) | N5 | changes a verdict? |
|---|---|---|---|---|---|
| 1 | **N5-RV** "Not excluded" / **N5-K1** / **N5-ΓRING**'s "unless (R-V)" | **truth** | §1b.5 items 2–6: (R-V) dies at `√3` (NB5-RVKILL) | §3.2 Verdict: "No contradiction at radius `√3`. **K1-ΓRING is GAP at (R-V)**" | **yes** — see 2.4; N5-RV's last clause FALSE, K1-ΓRING closed at `√3` in the non-Siamese simple class, one mind |
| 2 | N5-RV's hypothesis "`C′ ∋ q4`" | scope | not needed: `C′ ∌ P90′` because its cone at `q3` contains `240°−` (§1b.5 item 5) | §3.2 item 1 uses `C′ ⊂ B̄(q4, 1)` | no for the clauses; it is what makes my kill free of the bottom lune |
| 3 | N5-RV's `(W3)` | **my error** | §1c.4: "`W3` does not exist" (E1 at `q1`: the colour-3 tile at `P90` holds `ω(q1)`'s branch at `0°`) | §3.2 item 6: `W3`, if it exists, is bounded at `0°` by an arc of `ω(q1)` | **yes, mine withdrawn** — see 2.5; N5's optional `(W3)` is right |
| 4 | N5-R0 | route | §1b.4: `C ∋ q2` makes `z4` start at `≤ 0°`, so `z4` bounds no ring arc; the ring is `Γ`-free and general; N4-G | §2.4: `t2 ∌ top`, then `T` misses `P90`, `P90′`, then N4-G's diameter kill or N5-DR1 | no — both TRUE; mine needs no case split |
| 5 | N5-UP | route | colours 1–3 by SIGHT at `(top, p)` (`t1, t2, t3` meet `B(top, 1)`) | FACE at `(p, top)` on the `p`-cones | no |
| 6 | N5-KAPPA | wording | "never 60° apart" true in the interior sense; end-point coincidence not excluded (tools K2) | §2.2 item 1: arc–arc gives disjoint side sets, read at interior points | no — same reading |
| 7 | N5-BEND | scope reading | length bound derived for (R2) arcs only | §2.1: the bound is stated for "(R2) pieces" | no — the same scope; the theorem-table sentence's "each" means (R2) |
| 8 | N5-ΓRING | radius | the reduction reads `√3` (bends run on a `√3` fragment) | "radius 2" | no — mine stronger, theirs true |
| 9 | grades | grade | N4-D, N4-G two minds (NB4) | N5-ΓRING "over N4-D, N4-G at N4's grade (one mind each)" | no — N5 wrote before NB4 reported; now two minds each |
| 10 | N5-SIGHT, -DEG, -W, -XBAR, -DR1, -BENDG, -PIN0 | none | TRUE (PIN0's last clause not established) | the same routes | no |

### 2.4 Divergence 1 audited (G21: this is the verdict that flatters the NO)

**What N5 held and where it stopped.** N5 §3.2 has every ingredient: `z4` "`[0°, 60°]`-bounded at `top`"; `T`'s "cone at `top` in `[60°, 240°]` (far from `V1`)";
item 1, "`T ⊂ B̄(P90′, 1)`". It then walks to `P90` and stops. **The step it did not take is second-order at `top`:** first order, both `B̄(P90′, 1)` and "outside
`B(q1, 1)`" allow `T`'s cone to start at `60°`, and `z4 ⊂ B̄(q1, 1)` allows `z4`'s to end there, so a cone check passes. But `ω(q1)` and `ω(P90′)` are **externally
tangent at `top`** (`|q1 − P90′| = 2`, midpoint `top`), so `cl z4 ∩ cl T ⊆ B̄(q1, 1) ∩ B̄(P90′, 1) = {top}`: the two tiles cannot share an edge at `top`, the
direction `60°` there needs a third tile, and N5's own colour list at `top` (its N5-UP and N5-SIGHT; my §1b.5 item 4) leaves none. **Re-checked by hand
against N5's text, step by step:** `T`'s cone `[60°, 240°]` (N5 §3.2 setting line) ✓; `z4 ⊂ B̄(q1, 1)` (N5-XBAR) ✓; `T ⊂ B̄(P90′, 1)` (N5 §3.2 item 1, and mine
without `C′ ∋ q4`) ✓; no colour-1, -3 tile at `top`, colour 2 only `t2` inside, 4 only `z4`, `X̄` only `T`, `X` only in `[240°, 300°]` ✓. **Verdict: N5-RV's
"Not excluded" is FALSE; (R-V) dies at `B̄(p, √3)`.** Tools: G1–G3, D5 (and the plant at `70°`, where the gap closes because the point enters `B(P90′, 1)`).
**Consequences.** N5-ΓRING's reduction then ends with no survivor: **the Reuleaux bowtie (non-Siamese, simple) with any lune rings is excluded at radius `√3`**,
over N4-D, N4-G (two minds each), N5-DEG, N5-R0 (two minds each now: N5 and mine), N5-XBAR (two) and NB5-RVKILL (one mind, mine). N5's registration "(R-V)
dies within radius 2 about `p`, p = 0.4" is **met** (at `√3`, one mind). N4's registration (p = 0.6, "excluded by the same three moves at radius at most 2") is met
in its conclusion, not in its method: the bends, N5-UP and a tangency kill were needed.

### 2.5 My stage-1 slip (divergence 3)

§1c.4 said the colour-3 tile `C3` filling the sector `(300°, 360°)` at `P90` "holds `ω(q1)`'s branch leaving `P90` at `0°`", hence `3 ∉ P_cl(q1)` and no `W3`. **False
step:** the branch leaves `P90` tangent to `0°` and bends toward `q1`, into that sector, but `C3` may be bounded exactly along it (`C3 ⊂ B̄(q1, 1)` there), with the
next tile (colour 1, outside `B(q1, 1)`) beyond; then E1 at `q1` is not violated and `C3` may be `q1`'s tile `W3`, which then lies in `B̄(q1, 1) ∩ B̄(P90, 1)` with its
cone at `q1` in `[0°, 60°]` — N5 §3.2 item 6, which I read as the refutation of my step. **Withdrawn:** N5's `q1 = t1 | V1 | (W3) | z4 | U1` stands as stated, and
"`V1`'s cone exactly `[300°, 60°]`" holds only when `W3` is absent. **The kill does not use it** (NB5-RVKILL reads `top`, `q3`, `P90′`; nothing at `q1` but `z4 ⊂
B̄(q1, 1)` and `V1`'s existence). Kind: slip of this job, caught at stage 2 by reading.

### 2.6 Verdicts after stage 2

| claim | verdict | grade (minds) | radius read |
|---|---|---|---|
| N5-UP | TRUE | hand; two, one blind (N5; NB5) | `B̄(top, 1)` and the tiles at `p, q1, q3` |
| N5-DEG | TRUE | hand; two, one blind | `√3` |
| N5-R0 | TRUE | hand; two, one blind, different routes | `√3` |
| N5-ΓRING | TRUE as stated; **stronger in my derivation: no survivor, the bowtie excluded at `√3`** | hand; two, one blind, for the reduction; one (NB5) for closing (R-V) | `√3` |
| N5-BEND | TRUE ((R2) bound) | hand; two, one blind, over N2-TOWARD, -AWAY, -TAN | a neighbourhood of `B̄(p, 2)` |
| N5-KAPPA | TRUE (interior sense) | hand; two, one blind | `1 + ε` |
| N5-XBAR | TRUE | hand; two, one blind | `1 + ε` and `B̄(top, 1)` |
| **N5-RV** | clauses **TRUE** (my "no `W3`" withdrawn); **"Not excluded: K1-ΓRING is GAP at (R-V)" FALSE** | hand; clauses two, one blind; the kill one mind (NB5) | `√3` |
| N5-SIGHT | TRUE (non-Siamese) | hand; two, one blind | `B̄(u, 1)` |
| N5-BENDG | TRUE | hand; two, one blind | ring and radius-2 circle |
| N5-W | TRUE | hand; two, one blind | `B̄(top, 1)` |
| N5-DR1 | TRUE | hand; two, one blind (three with N3, N4 for the `Γ`-free form) | `1 + ε` |
| N5-PIN0 | clauses TRUE; "No contradiction at this radius" consistent, not established | hand; two, one blind, for the clauses | `1 + ε` |

**Controls (template item 3).** No step of N5's or mine reads the strip or the disk in a way they refute: neither holds a Reuleaux bowtie (§1c.9), so every kill fails
there at its hypothesis; the tools (N5-SIGHT, N5-KAPPA's E0, N5-BENDG) are true statements about every non-Siamese valid map and hold on both. No step the side calls
local reads beyond its stated radius: N5-UP, -XBAR, -DR1 read `1 + ε` about `p` plus `B̄(top, 1)`; N5-R0, -DEG and my kill read `√3`; N5-BEND reads `B̄(p, 2)`, as
stated. **Proposed for the close** (I edit none of these files): FS-114's derivation file — N5-RV's last clause FALSE and NB5-RVKILL/NB5-BOWTIE filed at one mind,
with a blind second mind owed on NB5-RVKILL first; K1-ΓRING closed at `√3` in the non-Siamese simple class (K1 still GAP at non-Reuleaux lenses, the pinwheel, the
`(2, 1, 1, 0)` patterns and three tactic edges); the stub K1-RV proposed by N5 §4.5 is moot.

## Stage 2 — SAVED
