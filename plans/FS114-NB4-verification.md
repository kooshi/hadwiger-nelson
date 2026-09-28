# FS114-NB4 — blind verification of FS-114's proof side, round 3 (FS114-N4)

*Job FS114-NB4, de Bruijn (Opus 5.5), launched 2026-09-28 (start-up snapshot HEAD `949b1bb3`). Brief: the template
`data/fs114/briefs/NB114-verify-proof.md` with the instance `data/fs114/briefs/NB4-114-instance.md` (the instance wins) and
`data/fs114/briefs/STANDING-RULES.md` (rule 0 read first). Working files `data/fs114/fs114-nb4/`; exact checks `tools/fs114_nb4_*.py`.
Stage 1 is blind: every verdict is derived from the nine statements in the instance file alone, before `plans/FS114-N4-proof.md` is opened.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| NB4-QT | Every quotation my brief, instance and standing rules rely on that I can check is verbatim: 17 of 17 FOUND; plant fires | [tools] | §1a.2; `tools/fs114_nb4_quotes.py` |
| NB4-RING | A `Γ`-free lune ring (non-Siamese, simple) has either one change point, at `top` (degenerate), or exactly two, at `e(s)`, `e(s + 60°)`, `30° < s < 90°` (general) | [hand, one mind] | §1b.1 |
| NB4-OWN | N4-OWN: TRUE, by E1 at the corner; needs only the four edge circles and degree 4 at `p` | [hand, one mind] | §1b.2 |
| NB4-LENS | N4-LENS: TRUE in the non-Siamese class (the instance's scope); FALSE without it | [hand, one mind] | §1b.2 |
| NB4-OPP | N4-OPP: MISSTATED in general (an edge leaving `p` opposite, curving toward `q` with curvature `> 1`, captures the branch); corrected form given; TRUE in the bowtie | [hand, one mind] | §1b.2 |
| NB4-FIVE | N4-FIVE: TRUE — five colours `{1, 3, 4, X, X̄}` at a corner iff its lune ring is degenerate, else exactly `{1, 3, 4, X}` | [hand, one mind] | §1b.2 |
| NB4-TOP | N4-TOP: TRUE — `W` (colour 4) with cone exactly `[60°, 120°]` at `top`, bordered along `ω(q1)`, `ω(q3)`; `L2` reaches `top`; `top` degree 4, `{2, 4, 5, 6}` | [hand, one mind] | §1b.2 |
| NB4-D | N4-D: TRUE — the degenerate member dies at `R* = q1 + top`, `|R*| = √3`: no colour for the lens sector at `R*` (case `c(T_cap) = 3`) or for the tile outside `ω(q1)` at `R*` (case `c(S) = 3`) | [hand, one mind; its metric facts tools exact] | §1b.2; `tools/fs114_nb4_check.py` |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|

## Fence log (standing rule 13; template and instance § Fences)

1. At start-up `ls data/fs114/briefs/` and `ls data/fs114/` listed file and directory **names** only (among them `N4-114-proof-round3.md`,
   `fs114-n4`, `fs114-y*`, `fs114-yb*`, `fs114-l60`, `reports`); none opened.
2. `git log --oneline -5` at start-up showed one subject beyond the start-up snapshot: `639a15df FS-114: construction verifier logged; blind check of
   the proof side's exclusion launched` (the owner's). Subject only.
3. A `grep` over `LEDGER.md` produced output large enough that the harness saved it to a file under `~/.claude/projects/…/tool-results/`; I did **not**
   open that file (it is inside the fenced transcript tree) and re-extracted the rows into my own scratch directory instead.

## Stage 1a — SAVED: reading and the quotation check

### 1a.1 Read from disk (G50)

- `data/fs114/briefs/NB114-verify-proof.md`, `NB4-114-instance.md`, `STANDING-RULES.md` in full; `CLAUDE.md` § The aim, § Counter-priors, G83, G82,
  G79, G71, G60, G21, G15, G13, G51 (loaded in context).
- `LEDGER.md` rows 131–136 in full.
- `data/fs114/claims.md` in full; `data/fs114/briefs/ROUND2-card.md`, `ROUND3-card.md` in full.
- `plans/FS114-unit-arc-question.md` §G part 3, §PA, §IQ, stage 5b (not 5.3).
- `data/fs114/briefs/N114-proof.md` in full (its § Reading, as the template directs).
- `plans/FS114-N3-proof.md` in full (round 2's proof side; open to me by the instance).
- `plans/FS112-derivation.md` header and §1 through FS112-L60 (FS112-U1, -SIX, -NB4P, -A4SIX, -L60), the entry titles of §§1–4, and FS112-N3-COR3;
  `data/fs112/claims.md` §0 (notation: `Γ`, `P_cl`, `ω`, contact kinds); the N-E0/N-E1/N-E2 line of `plans/FS112-N-proof.md` (l. 6–7).
- **Not used:** FS112-L60's strict form (under audit, instance). Where a derivation below needs an arc bound it says which.

### 1a.2 The quotation check (standing rule 5)

`tools/fs114_nb4_quotes.py data/fs114/fs114-nb4/quotes.tsv` checks 17 quotations — Kooshi's five in the standing rules (rule 0, rule 4, rule 3 twice,
rule 10), N3's statement of N3-DR0 and its tactic-edge and non-Siamese definitions, the FS112 statements the instance and claim list name (SIX, A4SIX,
NB4P, N3-COR3, U1, L60, N3-DENSE3), and two claim-list definitions (Siamese, "reads radius") — with whitespace collapsed and `**` removed:
**17 of 17 FOUND** (`data/fs114/fs114-nb4/quotes.out`). **Plant:** `--plant` alters one word of the first quotation: the altered copy NOT FOUND, its
faithful twin FOUND (`quotes-plant.out`). **Not checkable at stage 1:** the nine statements of the instance are FS114-N4's, quoted from its record,
which is fenced until this stage is committed; they are checked at stage 2. The round cards' restatements of construction-side results (FS114-Y2-BOWTIE,
-GAPS) come from fenced records and are used only at the card's wording and grade, never as inputs to a derivation.

## Stage 1a — SAVED

## Stage 1b — SAVED: blind derivations (setting, the ring lemma, N4-OWN, -LENS, -OPP, -FIVE, -TOP, -D)

*Derived from the instance's nine statements alone; `plans/FS114-N4-proof.md` not opened. Grades are `CLAUDE.md` § Notation's; "one mind" is mine.*

### 1b.0 Setting and labels

`p = 0`, `e(θ) = (cos θ, sin θ)`. **Labels (mine, fixed by N4-OWN's wording):** `q1 = e(30°)`, `q2 = e(−30°)`, `q3 = e(150°)`, `q4 = e(210°)`;
`t1 = Reul(p, q1, q2)` colour 1, `t3 = Reul(p, q3, q4)` colour 3; the upper lune tile `L2` (colour 2, cone `[60°, 120°]` at `p`) and the lower `L4`
(colour 4, cone `[240°, 300°]`). Edges at `p`: `e_A ⊂ ω(q2)` (`t1 | L2`), `e_B ⊂ ω(q4)` (`t3 | L2`), `e_C ⊂ ω(q1)` (`t1 | L4`), `e_D ⊂ ω(q3)` (`t3 | L4`),
leaving `p` in directions `60°, 120°, 300°, 240°`. So `q1, q3` bound lune 2 and `q2, q4` lune 4, as N4-OWN's "`2 ∉ P_cl(q1), P_cl(q3)`" requires. Tactic
partners: `Z2` (colour 2) at `q2`, `Z2′` at `q4`, `Z4` (colour 4) at `q1`, `Z4′` at `q3`, each touching its Reuleaux tile at the corner alone. `top = e(90°)`,
`R* = q1 + top = √3·e(60°)` (on `∂B̄(p, √3)`). The class: non-Siamese, simple (tiles open discs; a tile's cone at a vertex one closed interval; one tile
per colour at a vertex). Tools used, all standard and re-derived: **E0** (no two interior points of one colour at distance 1); **E1** (`ω(u)` meets no
tile of a colour of `P_cl(u)` — valid Siamese or not); **FAR** (distinct tiles of one colour are at distance `≥ 1`; each tile has diameter `≤ 1`);
**FACE** (N3-FACE: two far tiles of one colour at `u, w`, `|u − w| = 1`, have cones in the closed half-planes facing away from each other; one tile at both
lies in `B̄(u, 1) ∩ B̄(w, 1)`). `Λ_up = B̄(p,1) ∖ (B(q2,1) ∪ B(q4,1))` (corners `p, q1, q3`); the lune ring `A_up = {e(θ) : 30° < θ < 150°}`.

### 1b.1 Lemmas used below (each hand, one mind)

- **NB4-LUNE.** `L2 ⊂ Λ_up` (`L2 ⊂ B̄(p,1)`; far from `Z2`, `Z2′`). Every tile meeting `int Λ_up` is `L2` or has colour 5 or 6 (N4-LENS at `u = p`;
  `t1, t3, L4` miss `int Λ_up`, since `B(p,1) ∖ {p} ⊂ ⋃ B(q_i, 1)`). Every point of `A_up` off `Γ` is interior to a tile of colour 5 or 6 (E1 at `p`).
- **NB4-RING (the ring lemma).** A `Γ`-free lune ring has at most one change point in `(30°, 90°)`: **either no change there and one at `top`
  (the degenerate member, ring tiles `U` (X) on `(30°, 90°)`, `U′` (X̄) on `(90°, 150°)`), or exactly one at `e(s)`, `30° < s < 90°`, and one at `e(s + 60°)`
  (the general member, ring tiles `U₁` (X) on `(30°, s)`, `U₂` (X̄) on `(s, s + 60°)`, `U₃` (X) on `(s + 60°, 150°)`).** *Proof.* E0 gives
  `c(θ + 60°) = c̄(θ)`; a constant-colour stretch of the ring is one tile (non-Siamese); a ring tile spans at most `60°` (diameter). With two changes
  `s₁ < s₂` in `(30°, 90°)`, colour X̄ fills `(s₁, s₂)`, `(90°, s₁ + 60°)` and `(s₂ + 60°, s₃ + 60°)`; consecutive ones are within angular distance
  `< 60°`, hence one tile, which then holds `e(s₁)` and `e(s₂ + 60°)`, more than `60°` apart. ∎ So N4's "degenerate" and "general" members exhaust the
  `Γ`-free rings, and the general member has exactly the three ring tiles above.
- **NB4-TOPCOL (colours at `top`, any member).** A colour-1 tile at `top` is impossible (FACE against `t1` at `q1`: `t1`'s cone `[180°, 300°]` at `q1` is not in
  `{v·e(150°) ≤ 0}`); likewise colour 3 against `t3` at `q3`. A colour-2 tile at `top` is `L2` (FACE against `L2`'s cone `[60°, 120°]` at `p`), and then
  its cone at `top` lies in `[180°, 360°]`. A colour-4 tile at `top` is not `L4` (`L4` lies in the open lower lune).

### 1b.2 Verdicts

**N4-OWN — TRUE** [hand, one mind]. *Derivation.* `e_C ⊂ ω(q1)` leaves `p` in direction `300°`; the other branch of `ω(q1)` leaves in direction `120°`,
which is `e_B`'s tangent, and curves toward `q1` (to second order `p + t·e(120°) + (t²/2)·e(30°)`), while `e_B ⊂ ω(q4)` curves toward `q4`
(`… − (t²/2)·e(30°)`). So the branch lies in the open sector between `e_A` and `e_B`, which at a degree-4 `p` is `L2`. By E1 at `q1`, `2 ∉ P_cl(q1)`. The same
at `q3` (`ω(q3)`'s branch at `60°` enters `L2`) and at `q2, q4` for colour 4. *Reads:* `B̄(p, ε)` and the corner. *Uses:* only the four edges' circles and
degree 4 at `p` — no tactic partner, no non-Siamese hypothesis.

**N4-LENS — TRUE in the non-Siamese class; FALSE without it** [hand, one mind]. *Derivation.* A tile `T` of colour `c ∈ P_cl(u)` meeting the open lens
has a point `w` with `|w − u| < 1`; if `T` is not `u`'s `c`-tile `T_u`, the pair is far (non-Siamese), but `T_u` has points arbitrarily near `u`. The second
clause follows by applying the first at `u` and at `v`. `|u − v| = 1` is not used. *Without* non-Siamese: a Siamese partner of `T_u` inside the lens is a
counterexample (two same-colour tiles within distance `< 1` of each other are allowed there). The instance places every N4 claim in the non-Siamese class,
so read there it is TRUE.

**N4-OPP — MISSTATED as a general statement; TRUE in the bowtie** [hand, one mind]. *The gap.* The branch of `ω(q)` leaving `p` opposite the edge's tangent
curves toward `q` with curvature 1. If an edge `E` of `Γ` leaves `p` in exactly that direction and curves toward `q` with curvature **greater than 1**, the
branch lies on the far side of `E`, inside the tile **beyond** `E`, not in "the tile at `p` on `q`'s side of the opposite direction". *Counterexample sketch*
(`q = (0, 1)`): `e ⊂ ω(q)` leaving `p` rightward, `E` the circle of radius `1/2` about `(0, 1/2)` leaving `p` leftward, a vertical edge up from `p`; tiles
`A` (right, above `e`, small), `A′` = the left half of the disc of diameter `pq` (colour 2, `q ∈ cl A′`, diameter exactly 1), `B` below `e ∪ E` (colour
3). The branch `(−t, t²/2)` lies below `E` (`y ≈ t²`), in `B`; `A′` — the tile on `q`'s side of the opposite direction — misses `ω(q)` near `p`
(its disc is internally tangent to `ω(q)` at `p`) and carries a colour present at `q`. **Corrected statement:** *the other branch of `ω(q)` through `p`
lies, for small `t`, in the tile at `p` containing `p + t·d + (t²/2)·ν` (`d` the opposite direction, `ν` the unit normal toward `q`), unless it runs
along `Γ`; that tile's colour is absent at `q`.* In the bowtie the edge in the opposite direction curves away from `q`, so the stated form holds there
(N4-OWN is its instance).

**N4-FIVE — TRUE** (its second sentence) [hand, one mind]; the first sentence is a reading of the second. *Derivation (corner `q1`; the others by the
symmetries).* Cones at `q1`: `t1` `[180°, 300°]`; the lune part `[120°, 180°]`; the outside of `B(p,1)` `(−60°, 120°)`. `2 ∉ P_cl(q1)` (N4-OWN). The lune part
holds only colours 5, 6 (NB4-LUNE). `Z4` lies outside `B(p, 1)` (far from `L4`). The tile `T_cap` beside `t1`'s cap at `q1` is not colour 1 (adjacent to
`t1`), 2 (OWN), 4 (a second colour-4 tile at `q1`), nor the ring tile's colour X (the ring tile would have to wrap round `Z4`'s cone): **`c(T_cap) ∈ {3, X̄}`**.
- *General member:* an X̄ tile at `q1` would be within `< 1` of `U₂`'s ring points `e(s + δ)`, hence `U₂` itself, but `|q1 − e(s + 60°)| > 1`. So
  `c(T_cap) = 3`, nothing lies between `Z4` and `U₁`, and **`P_cl(q1) = {1, 3, 4, X}`**, degree 4, order `t1, T_cap, Z4, U₁`.
- *Degenerate member:* see N4-TOP's derivation: **`P_cl(q1) = {1, 3, 4, X, X̄}`**, degree 5, order `t1, T_cap, Z4, S, U`, `{c(T_cap), c(S)} = {3, X̄}`.
So a corner carries five colours iff its lune's ring is degenerate. "Not forced by the bowtie alone" is true in the sense that corner-local reasoning
leaves the general member four colours; read as a statement about fragments at radius `√3` it is vacuous once N4-G holds (no bowtie exists there at all).

**N4-TOP — TRUE** [hand, one mind]. *Derivation (degenerate upper lune).* `U ⊂ B̄(q1,1) ∩ B̄(top,1)`, `U′ ⊂ B̄(q3,1) ∩ B̄(top,1)` (diameter); at `top` their
cones lie in `[−120°, 60°]` and `[120°, 300°]`. The open wedge `(60°, 120°)` at `top` cannot be colour 1, 3 (NB4-TOPCOL), 2 (`L2` lies inside `B̄(p,1)`),
5 or 6 (a second X or X̄ tile at `top` is Siamese with `U` or `U′`): it is one colour-4 tile `W`. `W = Z4` would put its cone at `top` in `[−120°, 60°]`;
so `W ≠ Z4, Z4′`, and FACE against both gives **`W`'s cone `[60°, 120°]` exactly**, `W ∩ (B(q1,1) ∪ B(q3,1) ∪ B(p,1)) = ∅`, and the borders `U | W ⊂ ω(q1)`,
`U′ | W ⊂ ω(q3)` (nothing else can sit between them at `top`). **The corner.** `Z4 ∩ B(top, 1) = ∅` (far from `W`), so `Z4`'s cone at `q1` lies in
`[−60°, 60°]`; an X̄ tile at `q1` is far from `U′` (`q1 ∉ B̄(q3,1)`), so its cone lies in `[−120°, 60°]` — hence the lune part at `q1` is all `U`. If `Z4`
and `U` were adjacent at `q1`, their edge would lie on `ω(top)` and `W`'s on `ω(q1)`: with `z = top + e(−30° + φ)`, `w = q1 + e(150° − ψ)` one has
`|z − w|² = |e(φ) + e(−ψ) − 1|² = 1 − 2φψ + O(3)`, so `Z4` and `W` would come within `< 1` — Siamese. So a tile `S` sits between them; its colour is in
`{3, X̄}` and differs from `T_cap`'s: five colours at `q1`, and by the mirror five at `q3`, with `X ∈ P_cl(q3)`. **`L2` reaches `top`:** an X̄ tile at `q1`
forces (FACE against `U′`) `U′`'s cone at `top` into `[120°, 240°]`; the X tile at `q3` forces `U`'s into `[−60°, 60°]`; the gap `[240°, 300°]` can only be
`L2`. So `top` has degree 4, tiles `U, W, U′, L2`, colours `{X, 4, X̄, 2} = {2, 4, 5, 6}`, at distance 1 from `p`. *Reads:* `B̄(p, 1 + ε)`; uses `Z4, Z4′`
(tactic `e_C, e_D`) and `L4`.

**N4-D — TRUE** [hand, one mind; reads `B̄(p, √3)` through a neighbourhood of `R* = √3·e(60°)`]. *Derivation* (upper lune degenerate; the lower lune is
not used). With N4-TOP's structure:
1. *The open lens `B(q1,1) ∩ B(top,1)` (corners `p`, `R*`) meets only `t1`, `L2`, `U` and `q1`'s colour-3 tile `C3`* (N4-LENS at `q1` and `top`:
   `P_cl(q1) = {1, 3, 4, X, X̄}`, `P_cl(top) = {2, 4, X, X̄}`; colour 4 is carried on different tiles `Z4 ≠ W`, colour X̄ on different tiles (`q1`'s ≠ `U′`),
   so neither meets the lens).
2. *`U ∌ R*`:* `U` fills the lune part at `q1` up to `t1`'s arc, so it holds `q1 + t·e(180°)` (above the arc, which bends toward `q2`), at distance
   `√(1 + t²) > 1` from `R* = q1 + e(90°)`; diameter.
3. *Case `c(T_cap) = 3` (`C3 = T_cap`, `S` colour X̄):* `T_cap`'s cone at `q1` contains `300°`, so `T_cap` holds points at distance `> 1` from `R*`:
   `T_cap ∌ R*`. `t1, L2 ⊂ B̄(p, 1)` miss `R*`. So **no tile can fill the sector of the lens at `R*`** (`[180°, 300°]`): contradiction.
4. *Case `c(S) = 3` (`C3 = S`, `T_cap` colour X̄):* take the tile `T` beside the arc `ω(q1)` from `top` to `R*` **outside** it, at `R*`. By E1 at `q1`
   (colours `{1, 3, 4, 5, 6}` there) that arc lies wholly in `Γ` (a colour-2 tile on it would be within `< 1` of `top`, hence `L2`, which lies in `B̄(p,1)`).
   `T`'s colour: not 1 (its points `q1 + (1 + δ)e(90° + α)` are within `< 1` of `t1`'s points near `q1` in directions just past `180°`); not 3 (within `< 1`
   of `S`, whose cone at `q1` contains `60°`; and `S ⊂ B̄(q1, 1)` cannot be `T`); not 2, 5, 6 (within `< 1` of `top`: `L2, U, U′` are the only candidates and
   none lies outside `B(q1,1)` there); not 4 (`W` holds points of `ω(R*)` near `top` — the branch of `ω(R*)` leaving `top` at `120°` bends toward `e(30°)`,
   into `W` — so by E1 at `R*` no colour-4 tile has `R*` in its closure). **No colour is left for `T`**: contradiction.
So the degenerate member dies at `R*`, a point at distance exactly `√3` from `p`. Each step is local; the radius is read exactly (a fragment on the closed
disc gives a neighbourhood of `R*`). **Audit note (G21):** this is the verdict I would want false; the steps most worth a second mind are the colour-1
exclusion in item 4 (a first-order distance estimate, checked exactly below) and step 2.

**Exact checks** (`tools/fs114_nb4_check.py`, sympy over ℚ(√3), small angles as Pythagorean rotations; `data/fs114/fs114-nb4/check.out`): D0 the named
unit distances and `|R*|² = 3`; D1 `|e(φ) + e(−ψ) − 1|² = 1 − 2φψ + O(3)` (the `Z4`–`W` step); D2 a lune-part point of `U` near `q1` is `> 1` from `R*`;
D3 a point beside `t1`'s cap near `q1` is `> 1` from `R*`; D4a–c the colour-1 witness (a point of `t1` and a point just outside `ω(q1)` near `R*`, inside
`B(top,1)`, at distance `< 1`); D5 `ω(R*)`'s branch at `top` lies in `W`'s region; D6 the lens corners. **9 of 9 OK.** **Plant** (`--plant`: the witness at
`α = 0`, where the derivation says the exclusion fails): exactly D4b goes red (`check-plant.out`).

## Stage 1b — SAVED
