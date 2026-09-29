# FS116-V3 — a blind second mind on five round-3 statements of FS-116's list

*Job FS116-V3 (Ephodos, verification form; blind, the same model as the minds whose work it will later compare against, Opus 5.5).
Brief: `data/fs116/briefs/FS116-V3-verify.md`; standing rules `plans/STANDING-RULES.md`. The statements are `data/fs116/claims.md` § 11,
frozen by Keryx 2026-09-29 07:09 UTC. Record written 2026-09-29 from 07:10 UTC.*

## Theorems this phase proved

*(Filled at each stage. Stage 1 proves nothing: it is the readback and the registered expectations.)*

## Would-have-searched-here log (standing rule 5)

- Stage 1: none — a readback and predictions.

## Fence log (standing rule 8)

- 2026-09-29 07:10–07:24 UTC: no fenced path opened. Searches this stage were `grep` for headings inside open files
  (`plans/FS114-derivation.md`, `plans/FS110-N-proof.md`, `plans/FS112-N-proof.md`, `plans/FS111-M-regularity.md`,
  `.claude/skills/ephodos/scripts/derive_gate.py`, `.claude/agents/ephodos.md`) and printed no fenced text.

## Stage 1 — SAVED: the readback and the registered expectations

### 1.1 Files read, in order

1. The brief, `data/fs116/briefs/FS116-V3-verify.md` (in full), and `plans/STANDING-RULES.md` (in full).
2. `data/fs116/claims.md` (in full: §§ 0–11), and `data/fs114/claims.md` (in full).
3. `plans/FS114-derivation.md`: the header and § 3's entries (lines 1–23, 411–770) — statements, *uses only*, *not claimed*, minds,
   models; not the records their `argument:` lines point to.
4. `plans/FS112-derivation.md`, header and § 1's first entries (FS112-WALK, FS112-U1, FS112-SIX, FS112-NB4P).
5. `plans/FS110-N-proof.md` § 1.3–1.4 (N-E0, N-E1, N-E2 with their proofs); `plans/FS112-N-proof.md` headings and the lines naming N-E0–N-E2.
6. `plans/FS111-M-regularity.md` § 2.1–2.2 (the two readings of saturation, M-SATC) and § 3 (M-PINCH's setting and proof).
7. `.claude/skills/ephodos/scripts/derive_gate.py` (the grammar and the verification lint), `example-verification.md`, and
   `.claude/agents/ephodos.md` lines 490–520 (the two vocabularies).

### 1.2 Quotation check (standing rule 3)

`tools/fs116_v3_quotes.py` extracts each of the five statements the brief quotes and the same statement from the claim list's § 11 and
compares them character for character: **identical: 5 of 5** (731, 1204, 834, 547 and 1144 characters). Planted fault (one character
of the first quotation changed in memory): **identical: 4 of 5** — it fires (control `v3-quotes` below). Each of the five `> — source:`
lines names `data/fs116/claims.md § 11`, which holds the statements.

**One slip in the brief, not in a quotation:** § Fences reads "Until your verdicts on all three statements are committed"; the job has
five statements. I read it as five: nothing fenced opens before all five verdicts are committed.

### 1.3 The statements restated (the readback)

Notation mine, fixed here: `p` the centre, `r(θ) = p + e(θ)`, `e(θ) = (cos θ, sin θ)`, angles counter-clockwise; "just clockwise of
`r(θ)`" is the germ `{r(θ − t) : 0 < t < t₀}` of `ω(p)`, "just counter-clockwise" `{r(θ + t)}`. A tile *approaches* a point `y` along
`β` when it has points `y + s·d` with `s → 0⁺` and `d → e(β)`, equivalently when `β` lies in the closed cone of one of its sectors at
`y` (a cusp horn along `β` included). `P_cl(x)` is the set of colours of tiles whose closure contains `x` ("the colours of `x`");
"absent at `p`" means not in `P_cl(p)`. An arc of `Γ` on `ω(p)` is an arc of radius 1 centred at `p`, so it is (Q) exactly when `p`
carries both of its side colours (`p` having at least four colours).

- **GERM-R.** For any `k`, any point `p`, any `y = r(ψ)`: if the germ `v⁻` (just clockwise of `r(ψ − 60°)`) lies in the closure of a
  colour-`c` tile, no colour-`c` tile approaches `y` along any `β` with `β − ψ ∈ (150°, 330°)`; the other three germs likewise, with
  the intervals as stated. The six boundary directions are not claimed.
- **GERM-S.** Six colours, `p` with at least four colours, `y` a change point (the ring off `Γ` on both sides of `y`, colours `X`
  counter-clockwise and `X̄` clockwise, `X ≠ X̄`). Then `|P_cl(p)| = 4` and `{X, X̄}` is the absent pair; (i) with `v⁻`, `u⁺` off (Q)
  arcs, each direction of the open 60° cone at `y` about the direction to `p` is in the cone of a tile whose colour `c` is a colour of
  `p` and every `c`-tile at `p` lies in `B̄(y, 1)`; (ii) with `u⁻`, `v⁺` off (Q) arcs, each direction of the open 60° cone about the
  direction away from `p` is in the cone of a tile that is not a tile at `p`, whose colour `c` is a colour of `p`, and every `c`-tile
  at `p` misses `B(y, 1)`; (iii) with all four off (Q) arcs, `y` has at least four colours.
- **TOUCH.** Six colours, `|P_cl(p)| = 4`, `w ∈ ω(p) ∩ cl(T)` for a tile `T` of a colour of `p`, `w` not a change point and on no
  arc of `Γ` on `ω(p)`, the four germs at `w ± 60°` off (Q) arcs. Then both ring germs at `w` are in tiles of one absent colour `X`;
  each of the four germs is in the closure of an `X̄`-tile and of no `X`-tile; no `X̄`-tile has `w` in its closure.
- **ECHO.** Any `k`, disc of radius above 2, `w ∈ ω(p)` with both ring germs at `w` in tiles of one colour `X ∉ P_cl(p)`; if the
  fragment is saturated at `w` and `X ∈ P(w)`, then `2w − p ∈ cl` of an `X`-tile. Not claimed: `X` of density 0 at `w`.
- **AXIS.** Six colours, `p` a degree-4 vertex of four colours, edges the four half-axes, quadrant tiles `T_I … T_IV` of colours
  `c_I … c_IV`, absent `X, X̄`, the fragment saturated on some disc about `p`. At `q_N = (0, 1)` (with `p` the origin): (a) tiles
  approaching along directions in `(180°, 360°)` are `X` or `X̄`; (b) a `c_IV`-tile approaches along `0⁺` and a `c_III`-tile along
  `180⁻`, both above `y = 1`; (c) the germs just counter-clockwise of `r(30°)` and just clockwise of `r(150°)` lie on no (Q) arc;
  (d) if the germs just clockwise of `r(30°)` and just counter-clockwise of `r(150°)` lie on no (Q) arc, the tiles approaching along
  `(180°, 360°)` have one colour and `q_N` is not a change point; the same at `q_E, q_W, q_S` turned.

**Terms not fixed, asked, and ruled** (asked 2026-09-29 07:22 UTC; Keryx's answer, quoted in part: *"Treat it as an ambiguity of the
statement: give ECHO's verdict under (A) and under (B), and say which reading the statement should name (MISSTATED with the corrected
wording is a finding). (2) Your reading of "at distance exactly 1 from the support of each colour" stands: the unit circle T₁(x) meets
supp S_j, as FS111-M-regularity § 2.1 derives it"*):
- **"saturated at w"** (ECHO). (A) § 0's property at the one point `w`: if `w` is an essential boundary point, it is at distance
  exactly 1 from the support of each colour of `P(w)`; otherwise nothing to check. (B) `w` is an essential boundary point
  (`|P(w)| ≥ 2`) and is so saturated (FS111-M's "saturated point", which presupposes `x ∈ ∂_e S_j`). ECHO is worked under both.
- **"at distance exactly 1 from the support"** (ECHO, AXIS): `ω(x) ∩ supp S_j ≠ ∅`, `supp S_j = cl S̃_j` — the contact reading. The
  literal `dist(x, supp S_j) = 1` is empty for `j ∈ P(x)`.

### 1.4 What I was given (the `given:` line's long form)

Before any verdict: the five statements verbatim; the whole frozen claim list (§§ 0–11), which holds, beside definitions, the statements
of RING-GERM (§ 10: the non-Siamese form GERM-S extends) and of FS114-N7-3T (§ 8), whose statement carries N7-HUB's one-sentence sketch
("the directions toward `p` there lie in tiles of `p` reaching `y_k`, a tip, which meets `B(y_{k−1},1) ∩ B(y_{k+1},1)`, so its colour
is carried at `y_{k±1}` by no other tile, and the outward directions in tiles of `p`'s colours outside `B̄(p,1)` whose `p`-tiles face
away"); FS114-N3-LOCAL's lemma statements (N3-FACE, -HALF, -SEC, -FLANK, -PAIR, -ODD) and the other § 3 entries of
`plans/FS114-derivation.md` (N6-RING60, N7-QOPP, N7-FLANK, N7-CHAIN among them); N-E0–N-E2 with proofs; M-PINCH with its proof; the
brief's sentence that "two extend a ring lemma to fragments with Siamese pairs, which the question allows, and three describe the
configurations its saturated-class claims stall at". Not given: any verdict on these five, their proposing record, any sketch of their
proofs, the round-1 and round-2 records. I had met none of the five statements before this session.

### 1.5 The registered expectations (honest about their timing)

These were written at 07:24–07:30 UTC, **after** reading the statements and the held inputs and after working the arguments in my head
during the readback for about twenty minutes — so they are informed predictions, not naive ones, and a high hit rate here measures
little. Nothing of the derivations was written before them.

| statement | expected verdict | probability | likeliest break |
|---|---|---|---|
| GERM-R | derived | 0.95 | a tile reaching `y` only along a boundary direction, or a cusp at `y` — both outside the claim as posed |
| GERM-S | derived | 0.90 | a germ at `y ± 60°` on a non-(Q) arc of `Γ` whose absent side colour is not the one the exclusion needs |
| TOUCH | derived | 0.85 | an idle hypothesis ("in the closure of a tile of one of `p`'s colours" looks unused: a thin truth, not a break), or `w` an end of a `Γ`-arc on `ω(p)` |
| ECHO | refuted (a monster at "saturated at `w`") | 0.75 | reading (A) with `w` inside an `X`-tile, where saturation at `w` checks nothing; under (B) I expect it true |
| AXIS | derived | 0.85 | (b)'s "above the line `y = 1`", or (d) when the germ at `r(30°)` lies on `Γ` with both absent colours |

### 1.6 The blocks as registered at stage 1

Each block below carries its prediction; its verdict line is a placeholder until stage 2 or 3 writes the derived verdict, and the
stage-1 gate run scores the placeholders, which count for nothing.

verification: FS116-N1-GERM-R
  statement: in a valid k-coloured fragment on a closed disc of radius above 1 about a point p, for any k, Siamese pairs allowed, let y = r(ψ) be a
    point of ω(p), c a colour, and v⁻, v⁺, u⁻, u⁺ the arcs of ω(p) just clockwise and just counter-clockwise of r(ψ − 60°) and r(ψ + 60°); if v⁻ lies
    in the closure of a tile of colour c, no tile of colour c approaches y along a direction β with β − ψ in (150°, 330°); for v⁺ the interval is
    (−30°, 150°), for u⁻ (−150°, 30°), and for u⁺ (30°, 210°) *Not claimed:* anything about tiles that approach y only along the boundary directions ψ
    + 150°, ψ + 330°, ψ − 30°, ψ + 30°, ψ + 210°, ψ − 150°; anything when a germ lies on Γ with colour c on neither side
  given: the statement verbatim, the whole frozen claim list (with RING-GERM's statement and N7-HUB's one-sentence sketch in FS114-N7-3T's),
    FS114-derivation § 3's entry statements, N-E0–N-E2 and M-PINCH with their proofs, the brief's one-line description of the five; no verdict, no
    proposing record, no sketch of these statements' proofs (§ 1.4)
  committed: 2026-09-29, stage 1 (placeholder verdict; the derived verdict is committed at stage 2 or 3)
  predicted: derived — 0.95 — likeliest break: a tile reaching y only along a boundary direction, or a cusp at y (both outside the claim as posed)
  verdict: stalls at: stage 1 — not yet derived; the placeholder is replaced at stage 2 or 3
  method: not yet — stage 2 or 3
  attack: § 1.3 The statements restated (the readback)
  divergences: none — the first derivation is fenced until all five verdicts are committed (stage 4)
  counterexamples: none — nothing searched yet (stage 1)
  minds: 1 — blind to: the first derivation; method: not yet derived
  grade: hand

verification: FS116-N1-GERM-S
  statement: in a valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, Siamese pairs allowed, let y be a
    change point of the ring, X the colour of the ring just counter-clockwise of y and X̄ the colour just clockwise, and u⁻, u⁺, v⁻, v⁺ the arcs of
    ω(p) just clockwise and just counter-clockwise of the ring points y + 60° and y − 60°; then p has four colours and no more, X and X̄ are the
    colours absent at p, and (i) if neither v⁻ nor u⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction to p lies in
    the cone of a tile of a colour c of p every tile of p of which colour lies in B̄(y, 1); (ii) if neither u⁻ nor v⁺ lies on a (Q) arc, every
    direction at y in the open cone of 60° about the direction away from p lies in the cone of a tile, not a tile of p, of a colour c of p every tile
    of p of which colour misses B(y, 1); (iii) if none of the four lies on a (Q) arc, y is a vertex of at least four colours *Not claimed:* anything
    at k ≥ 7; that the tile in (i) is a tile of p (that is RING-GERM, in the non-Siamese class); that a change point with a germ on a (Q) arc has
    fewer than four colours
  given: the statement verbatim, the whole frozen claim list (with RING-GERM's statement and N7-HUB's one-sentence sketch in FS114-N7-3T's),
    FS114-derivation § 3's entry statements, N-E0–N-E2 and M-PINCH with their proofs, the brief's one-line description of the five; no verdict, no
    proposing record, no sketch of these statements' proofs (§ 1.4)
  committed: 2026-09-29, stage 1 (placeholder verdict; the derived verdict is committed at stage 2 or 3)
  predicted: derived — 0.90 — likeliest break: a germ at y ± 60° on a non-(Q) arc whose absent side colour is not the one the exclusion needs
  verdict: stalls at: stage 1 — not yet derived; the placeholder is replaced at stage 2 or 3
  method: not yet — stage 2 or 3
  attack: § 1.3 The statements restated (the readback)
  divergences: none — the first derivation is fenced until all five verdicts are committed (stage 4)
  counterexamples: none — nothing searched yet (stage 1)
  minds: 1 — blind to: the first derivation; method: not yet derived
  grade: hand

verification: FS116-N1-TOUCH
  statement: in a valid fragment on a closed disc of radius above 1 about a vertex p of four colours and no more, Siamese pairs allowed, let w be a
    point of ω(p) in the closure of a tile of one of p's colours which is not a change point of the ring and lies on no arc of Γ on ω(p), and suppose
    none of the four arcs of ω(p) just clockwise and just counter-clockwise of w + 60° and w − 60° lies on a (Q) arc; then the ring just clockwise and
    just counter-clockwise of w lies in tiles of one colour X absent at p, each of the four arcs lies in the closure of a tile of the other absent
    colour X̄ and of no tile of colour X, and no tile of colour X̄ has w in its closure *Not claimed:* that such a point exists in any fragment of
    SAT-QFREE's class; anything at k ≥ 7; anything when a germ lies on a (Q) arc
  given: the statement verbatim, the whole frozen claim list (with RING-GERM's statement and N7-HUB's one-sentence sketch in FS114-N7-3T's),
    FS114-derivation § 3's entry statements, N-E0–N-E2 and M-PINCH with their proofs, the brief's one-line description of the five; no verdict, no
    proposing record, no sketch of these statements' proofs (§ 1.4)
  committed: 2026-09-29, stage 1 (placeholder verdict; the derived verdict is committed at stage 2 or 3)
  predicted: derived — 0.85 — likeliest break: an idle hypothesis (a thin truth, not a break), or w an end of a Γ-arc on ω(p)
  verdict: stalls at: stage 1 — not yet derived; the placeholder is replaced at stage 2 or 3
  method: not yet — stage 2 or 3
  attack: § 1.3 The statements restated (the readback)
  divergences: none — the first derivation is fenced until all five verdicts are committed (stage 4)
  counterexamples: none — nothing searched yet (stage 1)
  minds: 1 — blind to: the first derivation; method: not yet derived
  grade: hand

verification: FS116-N1-ECHO
  statement: in a valid k-coloured fragment on a closed disc of radius above 2 about a point p, for any k, Siamese pairs allowed, let w be a point of
    ω(p) whose ring just clockwise and just counter-clockwise of w lies in tiles of one colour X absent at p; if the fragment is saturated at w and X
    is in w's essential multicolour, the point 2w − p lies in the closure of a tile of colour X *Not claimed:* anything when X has density 0 at w (a
    cusp); that the X-tile at 2w − p exists in any fragment of SAT-STRIP's class
  given: the statement verbatim, the whole frozen claim list (with RING-GERM's statement and N7-HUB's one-sentence sketch in FS114-N7-3T's),
    FS114-derivation § 3's entry statements, N-E0–N-E2 and M-PINCH with their proofs, the brief's one-line description of the five; no verdict, no
    proposing record, no sketch of these statements' proofs (§ 1.4)
  committed: 2026-09-29, stage 1 (placeholder verdict; the derived verdict is committed at stage 2 or 3)
  predicted: refuted — 0.75 — likeliest break: a monster at "saturated at w" (reading A, w inside an X-tile); under reading B I expect it true
  verdict: stalls at: stage 1 — not yet derived; the placeholder is replaced at stage 2 or 3
  method: not yet — stage 2 or 3
  attack: § 1.3 The statements restated (the readback)
  divergences: none — the first derivation is fenced until all five verdicts are committed (stage 4)
  counterexamples: none — nothing searched yet (stage 1)
  minds: 1 — blind to: the first derivation; method: not yet derived
  grade: hand

verification: FS116-N1-AXIS
  statement: let p be a degree-4 vertex of four colours of a valid fragment on a closed disc of radius above 1 about p, saturated on a disc about p,
    whose four edges are segments along the four half-axes, with tiles coloured c_I, c_II, c_III, c_IV by quadrant and absent colours X, X̄; then at
    q_N = p + (0, 1): (a) every tile approaching q_N along a direction below the horizontal has colour X or X̄; (b) a tile of colour c_IV approaches
    q_N along 0⁺ and one of colour c_III along 180⁻, both above the line y = 1; (c) the arcs of ω(p) just counter-clockwise of r(30°) and just
    clockwise of r(150°) lie on no (Q) arc; (d) if the arcs just clockwise of r(30°) and just counter-clockwise of r(150°) lie on no (Q) arc, every
    tile approaching q_N along a direction below the horizontal has one colour, and q_N is not a change point; and at each of the axis points q_E,
    q_W, q_S, read with the quadrants turned with it *Not claimed:* anything for four segments not at right angles; anything at k ≥ 7 for (d) (at k =
    9 SQ9 fails it); that the axis points are touch points in any fragment saturated on B̄(p, 1); SAT-STRIP
  given: the statement verbatim, the whole frozen claim list (with RING-GERM's statement and N7-HUB's one-sentence sketch in FS114-N7-3T's),
    FS114-derivation § 3's entry statements, N-E0–N-E2 and M-PINCH with their proofs, the brief's one-line description of the five; no verdict, no
    proposing record, no sketch of these statements' proofs (§ 1.4)
  committed: 2026-09-29, stage 1 (placeholder verdict; the derived verdict is committed at stage 2 or 3)
  predicted: derived — 0.85 — likeliest break: (b)'s "above the line y = 1", or (d) when the germ at r(30°) lies on Γ with both absent colours
  verdict: stalls at: stage 1 — not yet derived; the placeholder is replaced at stage 2 or 3
  method: not yet — stage 2 or 3
  attack: § 1.3 The statements restated (the readback)
  divergences: none — the first derivation is fenced until all five verdicts are committed (stage 4)
  counterexamples: none — nothing searched yet (stage 1)
  minds: 1 — blind to: the first derivation; method: not yet derived
  grade: hand

control: v3-quotes
  of: FS116-N1-GERM-R — the readback: the five statements the brief quotes against the claim list's § 11, character for character
  run: python3 ../tools/fs116_v3_quotes.py --root .. | tail -1
  expect: identical: 5 of 5
  fault: python3 ../tools/fs116_v3_quotes.py --root .. --plant | tail -1

## Stage 1 — SAVED
