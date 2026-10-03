# FS129-OR1 — pass 1 of the cross-application audit, lane R (the regularity-wall era): the record

*Ephodos, the deriver (read as files, by Kooshi's decision 2), as a `general-purpose` agent on Opus. Brief:
`data/fs129/briefs/FS129-OR1-pass1.md`. Plan: `plans/FS129-cross-application-audit.md` (Stage 2). Lane R owns the held results of
FS-104 on, FS-105 included; it reads the whole demand list against them. Started 2026-10-03 23:11 UTC.*

## Theorems this phase proved

Eight compositions, each **[derived], one mind, kernel pending** (grade lines in the identity's grammar; prior art owed for all, in-house inputs):
- **FS129-OR1-WHOLE** — the whole-tile restriction of radius `ρ ≤ √3` keeps a fragment's class and shows no (R2) witness of a ring arc — derived from
  FS116-V4-DICHOTOMY, FS116-V5-NE1 — § Stage 2 (J1).
- **FS129-OR1-BENDFRAG** — on it, every non-(Q) ring arc of a vertex of at least four colours bends away, keeping the class — derived from
  FS129-OR1-WHOLE, FS112-N2-BENDS — § Stage 2 (J1).
- **FS129-OR1-QFREE-CLASS** — in each of four classes, a Γ-free exclusion gives the (Q)-free one — derived from FS129-OR1-BENDFRAG — § Stage 2 (J1, J7).
- **FS129-OR1-QFREE** — no non-Siamese simple valid six-coloured fragment on a disc of radius above 1 about a vertex of at least four colours has a
  (Q)-free ring — derived from FS116-Y4-EMPTY, FS129-OR1-QFREE-CLASS — § Stage 2 (J1: FS-123 question 1 answered yes).
- **FS129-OR1-BEND3** — the same bends at a vertex of exactly three colours make its ring Γ-free — derived from FS129-OR1-WHOLE, FS112-N2-BENDS,
  FS116-V5-U1 — § Stage 3 (J2).
- **FS129-OR1-TOP5** — given REG-J′₅, the honest existence form at five holds iff `χ_m⁰(ℝ²) ≥ 6` (forward at FS106-AE-MAP6's grade) — derived from
  FS111-M-REDUCE-I, FS111-V0-RESCALE — § Stage 3 (J10).
- **FS129-OR1-LOCALDENSE** — LOCAL-DENSE at `r = 3` (possibly vacuous: no fragment on a disc of radius 3 is held) — derived from FS112-DISC1,
  FS112-N3-BASE — § Stage 4 (J19).
- **FS129-OR1-DISCF-NS** — in the non-Siamese simple class, C114-LOCAL-F at radius `R` gives DISC-F at `R + 3` — derived from FS129-OR1-LOCALDENSE,
  FS116-V4-DICHOTOMY — § Stage 4 (J19).

## Stage 1 — SAVED: readback and registered expectations

**Readback.** Read in full: the brief; `.claude/skills/ephodos/SKILL.md`; `.claude/agents/ephodos.md` from `# Ephodos in lean-dir — the
workflow` to its end; `plans/STANDING-RULES.md`; `plans/FS129-cross-application-audit.md` (all sections, § 3, § 5, § 7 first);
`plans/STUB-cross-application-audit.md` lines 1–59 (the request, the instances in § Why now, the precedents, the method). Not yet read
at this stage (on purpose): the demand list `data/fs129/demand-judged.md`, the stub's card (§ The question onward), Poros's card file,
and `plans/FS129-close-inventory.md` item 23 (Poros's expectations).

**Quotation check** (standing rule 3): the brief's three block quotations were checked by script, character for character, against the
sources they name — the request against `plans/STUB-cross-application-audit.md` § The request: match; decisions 1–4 against
`plans/FS129-cross-application-audit.md` § 1: match; the note on roots against the same § 1: match. No mismatch; no finding about the brief.

**Registered expectations** (2026-10-03 23:11 UTC, before the demand list, the card or item 23 was read; scored at the close of this pass):

| quantity | expectation | reasoning |
|---|---|---|
| steps of J1–J24 that a lane-R held result **closes** outright | 0 (P(≥ 1) = 0.15) | the steps are posed in this era's words, so the stubs' authors had this era's results in view; a full close missed by them is rare |
| steps that a lane-R result **shortens or reduces** to another step | 4 (range 2–7) | both instances that prompted the audit were in-era misses of a kind of input held under another name; a reduction or a removed case is the likely shape |
| **nulls** among J1–J24 | 17 (range 13–21) | the complement |
| compositions derived (block entries) | 3 (range 1–6) | a reduction that is real gets an entry; several will be recorded as notes for pass 2 instead |
| compositions found **outside** the demand list | 1 (range 0–3) | |
| new stubs proposed | 1 (range 0–2) | |
| **J10** (the map step at five): some held lane-R result bears on it (reduces or shortens) | P = 0.35 | |
| **J15** (Poros's invention signal): the collision stands after the shared premise is named, as an `invention signal` | P = 0.40 | written before reading what J15 says |
| this lane **moves the bearing on the answer** (a step of FS-123/FS-124/FS-104 or J10 closed or reduced so that a route's shape changes) | P = 0.12 | |
| a held lane-R result found false as read (a refutation to message the coordinator about) | P = 0.04 | |

These are instruments for G21, never caps.

## Stage 2 — SAVED: J1, the bends on a fragment

**How I read** (disclosed, as the brief asks for the kind line before any scan): before working any step I read the demand list in full
(`data/fs129/demand-judged.md`, §§ 1–5), the index's README, and every lane-R statement in `data/fs129/index/statements-R.md` (474 lines,
each cut at about 420 characters by the index), as an orientation pass over my own era's supply. For each step below the kind line is
written before I open any entry for that step; the orientation pass is the one exception, and it is recorded here.

### J1 — FS-123, question 1: the bends, on a fragment

**The step** (`plans/STUB-qfree-ring.md` ll. 29–31, verbatim): "1. **The bends, on a fragment** (the invention signal, below). Does bending a
fragment on a neighbourhood of `B̄(p, 1 + ε)` keep it in FS116-Y4-EMPTY's class and leave its ring free of every arc but the (Q) arcs? If yes,
EMPTY excludes at `1 + ε` every four-colour vertex of the non-Siamese simple class whose ring carries no (Q) arc, and FS114-N7-3T's,
FS114-N7-HUB's and FS114-N6-RING60's classes are empty there."

**Kind of input** (written before reading for the step): a modification lemma on fragments — FS-112's whole-arc bends — together with a
*restriction* lemma that says which fragment the bends run on; checked against the list's § 2: no held no-go excludes modification lemmas
(FS111-M2-NOSEL and FS111-M-DEADLOCK exclude moves that produce honest saturation, which this step does not need). Admissible.

**Read for it** (lane R, by id): FS112-N2-BENDS (its proof: NB2's N2-TOWARD, N2-AWAY, N2-TAN, N2-SIGN, N2-ENV,
`plans/FS112-NB2-verification.md` §§ 1.4), FS112-N2-RED, FS112-N2-TERM (NB2's "whether it is available depends on the map within a bounded
distance … `α`, `P` and `R₂(α)` for a bend"), FS112-LOCK, FS114-N5-BEND and -N5-BENDG (`plans/FS114-N5-proof.md` §§ 2.1, 4.1), FS116-Y4-EMPTY
(statement and *not claimed*), FS116-V4-DICHOTOMY, FS116-V4-MEET, FS116-V5-NE1, FS116-N1-QFREE4; the two verifiers' remarks of side 1
(`plans/FS114-NB5-verification.md` § 1b.3, `plans/FS114-NB6-verification.md` § 1b.0) and `plans/FS116-Z2-close.md` § 1.5; the definitions
(`data/fs116/claims.md` § 0: valid fragment, Siamese, simple, `Γ`, tiles, (Q), (R2)).

**Recognition** (what this step really is). Side 1 and side 2 are about different objects, as FS116-Z2's reading guessed, and there is no
collision: side 2 (N2-RED and every FS-114 use of it) is about a map, where the radius-2 witness of an (R2) arc exists; side 1 is about a
fragment that does not reach it. What the record lacked is the lemma that makes side 1 *carry*: which fragment the bends run on. The literal
recipe — "restrict first" to a round neighbourhood of `B̄(p, 1 + ε)` or of `B̄(p, √3)` (NB5's radius note) — **does not carry the class**: a
fragment's tiles are the components of its open set minus `Γ`, so a round restriction can cut one tile into two pieces of one colour, at
mutual distance below 1 — a Siamese pair — and can disconnect the meeting set of two closures (non-simple); § Control: fs129-or1-cut exhibits
such a tile. The restriction that keeps the class keeps tiles **whole** (all tiles meeting `B(p, ρ)`), and a whole-tile restriction reaches
out to radius `ρ + 1`, where a witness could reappear — but it cannot: a witness tile is far from the arc's inner tile, and the parallelogram
identity `|x − e|² = (|x|² + |x − 2e|²)/2 − 1` puts every point of a witness tile inside `B(p, ρ)` within distance `√((ρ² − 1)/2)` of the arc,
which is below 1 exactly while `ρ < √3`. So **the bends cost no radius below `√3`** — NB5's `√3` is this identity's threshold — and side 1's
conclusion holds, with the restriction repaired. The shared premise of the two sides ("a bend is a modification within the class the exclusion
quantifies over") holds for whole-tile restrictions below `√3`; `ephodos-invention` is not needed.

derivation: FS129-OR1-WHOLE
  statement: let F be a valid k-coloured fragment on a closed disc B̄(p, r) about a point p, r > 1, a map of an open set V, and let 1 < ρ ≤ r;
    let 𝒯_ρ be the tiles of F that meet the open disc B(p, ρ), and F_ρ the map of the open set U_ρ = V ∩ int ⋃_{T ∈ 𝒯_ρ} cl T whose tiles are
    the tiles of 𝒯_ρ with their colours; then F_ρ is a valid k-coloured fragment on B̄(p, ρ′) for every ρ′ < ρ, each of its tiles is a tile of F
    with the same closure, the tiles of F_ρ having p in their closure are those of F, and F_ρ is non-Siamese if F is and simple if F is; and if
    moreover ρ ≤ √3, then for every arc α of Γ on ω(p) of positive length whose inner side is one tile, of colour c, no tile of F_ρ of colour c
    has a point of R₂(ᾱ) = {p + 2u : p + u ∈ ᾱ} in its closure
  uses only: FS116-V4-DICHOTOMY (closure points at distance below 1 make two same-colour tiles near, above 1 far; non-Siamese means distinct
    same-colour tiles are far); FS116-V5-NE1 (a tile lies in B(z, 1) for every z in its closure); the parallelogram identity; local finiteness
    of Γ; the definitions of tile (a component of the open set minus Γ), Siamese and simple (`data/fs116/claims.md` § 0)
  not claimed: that the round restriction — the components of B(p, ρ) ∖ Γ — keeps non-Siamese or simple (it need not: § Control:
    fs129-or1-cut); anything about witness tiles when ρ > √3; simplicity read with closures taken relative to U_ρ (the statement reads them in
    the plane, as `data/fs116/claims.md` § 0 does)
  argument: § Argument for FS129-OR1-WHOLE
  verdict: derived
  grade: derived from: FS116-V4-DICHOTOMY, FS116-V5-NE1
  minds: 1
  model: the capped strip of FS114-Y-DIAL about a midline four-colour vertex P_j, a valid six-coloured fragment on B̄(P_j, 1.8) (it holds every
    radius below φ²/√2 ≈ 1.851), with ρ = √3; its ring ω(P_j) carries four (Q) arcs of positive length (`data/fs116/claims.md` § 0, the capped
    strip's midline configuration)
  prior art: owed — an in-house composition of in-house lemmas; their own prior art is unsearched (`plans/STUB-qfree-ring.md` § Prior-art debts)
  handoff: de Bruijn — the statement and its not claimed, with V4-DICHOTOMY and V5-NE1 as its inputs; the identity is one line of algebra

control: fs129-or1-lens
  of: FS129-OR1-WHOLE — the lens identity, its corner value (ρ² − 1)/2 (sharp at ρ = √3) and a rational sample of the lens at ρ = 17/10
  run: python3 ../tools/fs129_or1_lens.py
  expect: lens ok; cut ok
  fault: python3 ../tools/fs129_or1_lens.py --fault

control: fs129-or1-cut
  of: FS129-OR1-WHOLE — its not claimed line: a U-shaped tile of diameter below 1 that the round restriction to B(0, 11/10) cuts into two pieces
  run: python3 ../tools/fs129_or1_lens.py
  expect: lens ok; cut ok
  fault: python3 ../tools/fs129_or1_lens.py --fault-cut

#### Argument for FS129-OR1-WHOLE

1. *`F_ρ` is a fragment on `B̄(p, ρ′)`.* Each `T ∈ 𝒯_ρ` is open, lies in `V`, and `T ⊆ int cl T`, so `T ⊆ U_ρ`. Conversely a point `z ∈ U_ρ ∖ Γ`
   lies in `cl T` for some `T ∈ 𝒯_ρ`, and `cl T ∖ (Γ ∪ ∂V) ⊆ T`, so `z ∈ T`. Hence `U_ρ ∖ Γ` is the disjoint union of the open connected sets of
   `𝒯_ρ`, which are therefore its components: the tiles of `F_ρ` are the tiles of `𝒯_ρ`, and their closures (in the plane) are those they have in
   `F`. For `|z − p| ≤ ρ′ < ρ ≤ r`, local finiteness gives a neighbourhood `N ⊆ B(p, ρ)` of `z` meeting finitely many arcs of `Γ`; every tile
   meeting `N` meets `B(p, ρ)`, so lies in `𝒯_ρ`, and `N ⊆ cl(N ∖ Γ) ⊆ ⋃_{𝒯_ρ} cl T`; so `z ∈ U_ρ`. Validity and the colour count are
   inherited (the coloured points of `F_ρ` are coloured points of `F`).
2. *Tiles at `p`, non-Siamese, simple.* A tile with `p` in its closure is open with points arbitrarily near `p`, so it meets `B(p, ρ)`. Two
   distinct same-colour tiles of `F_ρ` are tiles of `F`; if `F` is non-Siamese they are far (V4-DICHOTOMY's last clause) and stay far (the same
   sets). Simple is a condition on the tiles and their closures, which are unchanged.
3. *No witness below `√3`.* Let `α ⊂ ω(p)` be an arc of `Γ` of positive length with inner tile `T_in` of colour `c`, so `ᾱ ⊆ cl T_in`, and let
   `W` be a tile of colour `c` with `p + 2u ∈ cl W`, `p + u ∈ ᾱ`. Choose `p + u′ ∈ ᾱ`, `u′ ≠ u`: `|2u − u′|² = 5 − 4 cos∠(u, u′) > 1`, so by
   V4-DICHOTOMY `W` and `T_in` are far (and `W ≠ T_in`). Suppose `W` had a point `x` with `|x − p| < ρ`. By V5-NE1, `|x − p − 2u| < 1`. The
   parallelogram identity on `x − p − u ± u` gives `|x − p − u|² = (|x − p|² + |x − p − 2u|²)/2 − 1 < (ρ² + 1)/2 − 1 = (ρ² − 1)/2 ≤ 1`. So the
   point `x` of `W` and the closure point `p + u` of `T_in` are at distance below 1, and V4-DICHOTOMY makes `W` and `T_in` near — a
   contradiction. So `W ∉ 𝒯_ρ`. The bound is attained at the corners of the lens `B̄(p, ρ) ∩ B̄(p + 2u, 1)` (§ Control: fs129-or1-lens checks
   the identity, the corner value and its sharpness at `√3` exactly), so the argument stops exactly at `ρ = √3`.

derivation: FS129-OR1-BENDFRAG
  statement: let F be a valid six-coloured fragment on a closed disc B̄(p, r), r > 1, about a vertex p of at least four colours, and let
    1 < ρ′ < min(r, √3); then there is a valid six-coloured fragment F″ on B̄(p, ρ′) in which p is a vertex whose tiles at p have the colours
    they have in F, whose arcs of Γ on ω(p) are F's (Q) arcs on ω(p) and no others, so that Γ ∩ ω(p) in F″ is those arcs and finitely many
    points; F″ is non-Siamese if F is, and simple if F is
  uses only: FS129-OR1-WHOLE at ρ = min(r, √3); FS112-N2-BENDS through its proof's two operations — N2-TOWARD (outer colour absent at the centre
    ⟹ the whole arc, ends included, bends toward it, validly, creating no unit arc) and N2-AWAY (inner colour absent at the centre and no
    inner-colour tile touching R₂(ᾱ) ⟹ the whole arc bends away) — read on a fragment; the definition of (Q) (its centre carries both side
    colours and at least four colours); FS116-V4-DICHOTOMY (for non-Siamese after each bend)
  not claimed: anything at radius √3 or more, where an (R2) arc's witness can be seen and FS112-N2-RED's (R2) arcs survive (side 2, about maps);
    that F″ keeps any saturation F has; anything about the rings of other vertices (bending p's ring and a ring point's ring together is not
    claimed: their witnesses see each other); that F″ agrees with F off thin lenses along the bent arcs (true by construction, not part of the
    statement)
  argument: § Argument for FS129-OR1-BENDFRAG
  verdict: derived
  grade: derived from: FS129-OR1-WHOLE, FS112-N2-BENDS
  minds: 1
  model: the capped strip about P_j on B̄(P_j, 1.8) with ρ′ = 1.7 — its four ring arcs are (Q), so F″ is F_√3 with nothing bent; no held
    fragment has a non-(Q) arc on the ring of a vertex of at least four colours (`plans/STUB-qfree-ring.md` § Construction targets), so the bend
    clause has no held fragment as a model, only FS112-N2-RED's maps
  prior art: owed — in-house; FS-112's bends are "not found in print" (FS112-N2-RED's entry)
  handoff: de Bruijn — the statement and its not claimed, over FS112-N2-BENDS as an imported hypothesis until FS-112's module lands

#### Argument for FS129-OR1-BENDFRAG

Put `ρ = min(r, √3)` and let `F_ρ` be FS129-OR1-WHOLE's restriction: a fragment of `F`'s class on `B̄(p, ρ′)`, with `p`'s tiles. Its arcs of `Γ`
on `ω(p)` are finitely many (compactness of `ω(p)`, local finiteness), each maximal with one tile on each side. Take a non-(Q) one, `α`, with
side colours `s_in`, `s_out`. As `p` carries at least four colours and `α` is not (Q), `p` does not carry both side colours.
- If `s_out ∉ P_cl(p)`: N2-TOWARD bends `α` whole toward `p` (NB2 § 1.4: wedge lenses at the ends, contacts on `ω(A)` at `P` excluded by
  `s_out ∉ P_cl(P)`, at `Q_A = P + 2e_A` excluded in both types; where `T_in`'s sector at an end has zero angle, a horn sub-lens tangent to `α`
  with curvature strictly between `α`'s and the neighbouring edge's, which is a segment or an arc whose signed curvature differs from `α`'s, lies
  inside the valid wedge and is valid, recolouring a subset of a validly recoloured set).
- Else `s_in ∉ P_cl(p)`, and by WHOLE (`ρ ≤ √3`) no `s_in` tile of `F_ρ` touches `R₂(ᾱ)`, ends included: N2-AWAY bends `α` whole away from `p`
  (horn lenses at the ends, NB2's sharpened second clause).
*Read on a fragment.* Each lemma's proof examines the coloured points that could lie at distance exactly 1 from a lens point (N2-ENV places them
near `P` or near `R₂(ᾱ)` once the lens is thin) and shows, tile by tile, that none of the colour being placed is there under the stated
condition. It reads only tiles that are present: in `F_ρ` there are no more tiles near `ᾱ`, `ω(A)`, `P` and `R₂(ᾱ)` than in `F`, and points
outside `U_ρ` carry no colour. FS112-N2-TERM records the same locality ("`α`, `P` and `R₂(α)` for a bend").
*Each bend keeps the class.* The lens lies in a thin neighbourhood of `α ⊂ ω(p)`, away from `p`; the growing tile's colour is absent at `p`
(`s_out` toward, `s_in` away), so no tile at `p` changes and no colour reaches `p`; the other ring arcs keep their side colours and `P_cl(p)`,
hence their types, and WHOLE's conclusion for them (the lenses stay near radius 1, far from radius 2). Validity is the lemmas'. *Non-Siamese*:
the growing tile `T′ ⊇ T`; for a same-colour tile `S ≠ T`, `T` and `S` were far, and `T′ ~ S` would make `T ~ S`; so `T′` and `S` are far by
V4-DICHOTOMY in the new valid fragment; the shrinking tile is a subset. *Simple*: a Jordan domain gains, or loses, a crescent attached along the
boundary arc `α` whose closure meets the rest of the boundary only at `α`'s ends, so every tile stays an open disc and no closure meets itself;
`cl T′ ∩ cl S′ = (cl T ∩ cl S ∖ int α) ∪ β` (`β` the new edge, same ends) is connected, because each component of `cl T ∩ cl S ∖ int α`
contains an end of `α` (interior points of `α` are interior points of one edge); every other closure intersection is unchanged (the crescent's
closure meets other closures only at `α`'s ends, already in both). No tile is created, merged or split.
*The ring.* Bending the non-(Q) ring arcs one at a time (finitely many), every one is removed whole and no unit arc is created (NB2: bent arcs
have radius `≠ 1`); the new edges lie strictly inside or strictly outside `B̄(p, 1)` but at their ends, so they meet `ω(p)` in finitely many
points; the (Q) arcs are untouched and stay (Q). Six colours are spent nowhere in this argument (NB2 § 1.5: "nowhere in the reduction").

derivation: FS129-OR1-QFREE-CLASS
  statement: for each of the four classes of valid six-coloured fragments — all of them, the non-Siamese ones, the simple ones, the non-Siamese
    simple ones — if for every r > 1 no fragment of the class on B̄(p, r) about a vertex p of at least four colours has a ring carrying no arc of
    Γ, then for every r > 1 no fragment of the class on B̄(p, r) about a vertex p of at least four colours has a ring carrying no (Q) arc
  uses only: FS129-OR1-BENDFRAG (its fragment F″ is in F's class, on a disc of radius above 1, with p's colours, and its ring's arcs of Γ are
    F's (Q) ring arcs)
  not claimed: the hypothesis for the Siamese or the non-simple classes (FS-123's question 3, open); anything for rings carrying a (Q) arc
  argument: § Argument for FS129-OR1-QFREE-CLASS
  verdict: derived
  grade: derived from: FS129-OR1-BENDFRAG
  minds: 1
  model: the class of non-Siamese simple fragments, where the hypothesis is FS116-Y4-EMPTY (held) and FS129-OR1-QFREE is the conclusion
  prior art: owed — in-house
  handoff: de Bruijn — with FS129-OR1-BENDFRAG, as the bridge that turns any Γ-free exclusion into a (Q)-free one

#### Argument for FS129-OR1-QFREE-CLASS

Given a fragment `F` of the class on `B̄(p, r)`, `r > 1`, with `p` of at least four colours and a ring carrying no (Q) arc, pick
`1 < ρ′ < min(r, √3)`; FS129-OR1-BENDFRAG gives `F″` in the same class (each of non-Siamese and simple is kept), on `B̄(p, ρ′)`, `p` a vertex of
the same colours (at least four), and its ring's arcs of `Γ` are `F`'s (Q) ring arcs — none. So `F″` is a fragment of the class on a disc of
radius above 1 whose ring carries no arc of `Γ`, which the hypothesis excludes.

derivation: FS129-OR1-QFREE
  statement: no non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has a
    ring carrying no (Q) arc
  uses only: FS116-Y4-EMPTY (the same statement with "no arc of Γ" for "no (Q) arc"); FS129-OR1-QFREE-CLASS at the non-Siamese simple class
  not claimed: anything in the Siamese or non-simple classes (FS-123 question 3; FS-124 case 7); anything at k ≥ 7 (EMPTY's own limit); anything
    for rings that carry a (Q) arc (FS-124); that a four-colour vertex with a (Q) ring dies at any radius
  argument: § Argument for FS129-OR1-QFREE-CLASS
  verdict: derived
  grade: derived from: FS116-Y4-EMPTY, FS129-OR1-QFREE-CLASS
  minds: 1
  model: FS114-Y2-BOWTIE, a non-Siamese valid six-coloured fragment on B̄(p, 3√3/5) about a degree-4 vertex of four colours — its ring carries
    two (Q) arcs, the Reuleaux caps (FS-116's erratum under FS114-N7-3T), so the class is inhabited and the statement's alternative holds there
  prior art: owed — in-house
  handoff: de Bruijn — the statement and its not claimed, over FS116-Y4-EMPTY (FS-116's module) and FS129-OR1-BENDFRAG

**Verdict on J1: closed — yes, with the restriction repaired.** Bending a fragment keeps EMPTY's class and leaves only the (Q) arcs on the ring,
on the whole-tile restriction of radius below `√3` (not on a round restriction, which can break non-Siamese and simple). So:
- **FS-123 question 1 is answered yes** (FS129-OR1-QFREE): in the non-Siamese simple class, every vertex of at least four colours on a disc of
  radius above 1 carries a (Q) arc on its ring. FS114-N7-3T's class (OC included), FS114-N7-HUB's and FS114-N6-RING60's are empty at `1 + ε`
  in that class; G83's reading ("what is left is four-colour vertices whose rings carry (Q) arcs") is confirmed there; route T's deficient
  configurations on (Q)-free rings (FS-117's K1) have no instance.
- **J18 is moot** (FS-123 question 2 was conditional on a no). The construction target "a fragment about a vertex of at least four colours whose
  ring carries (R2) arcs and no (Q) arc, past `1 + ε`" is now known not to exist in the non-Siamese simple class.
- **J3, case 2 (SAT-QFREE's touch point)** is vacuous in the non-Siamese simple class: a saturated fragment is a fragment, and FS129-OR1-QFREE
  needs no saturation (FS116-SAT-QFREE has no non-Siamese or simple hypothesis, so its Siamese and non-simple parts stay open, with J7).
- **J7 reduces**: FS129-OR1-QFREE-CLASS turns EMPTY's Siamese or non-simple form, once derived, into the (Q)-free form at no cost — J7's (Q)-free
  half is J7's Γ-free half.
- **FS-124's reach is narrower than Poros's card 1 hoped** (`plans/STUB-qfree-ring.md` § Bearing, "At R2's re-rank"): the bends delete
  non-(Q) arcs from the ring of *one* vertex, on a fragment of radius below `√3`. A statement on FS-124's list that reads radius 1 + ε about `p`
  (FS116-RING-GERM, N3-SEMI, SEMI-PAR3, RING-TWIST-Q) may assume `p`'s ring carries only (Q) arcs; one that reads radius above 2 (RING-Q,
  RING-Q-PRIME, N3-CROSS, RING-TRANSFER-QC, N2-RECIP) may not, and neither may a step that reads a ring point's own ring as well (SEMI-PAR3's
  GAP reads `y`'s ring).
- **The invention signal (`plans/STUB-qfree-ring.md` § The invention signal on the bends) dissolves** as FS116-Z2's reading guessed: the sides
  are about a map and a fragment; side 1's conclusion holds and its recipe needed the whole-tile restriction.

## Stage 3 — SAVED: J2–J10

### J2 — FS-124, case 1: SEMI-PAR3

**The step** (as `data/fs129/demand-judged.md` J2 quotes it, verbatim): (`plans/STUB-q-ring.md` ll. 25–29): "1. **SEMI-PAR3** (inventory items 96, 97): "in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, no change point of the ring is a full parallel semi-hub of exactly three colours" — GAP: "the step from the bowtie's four-colour parallel semi-hub to three colours — removing the tile of p toward y from y (kind O), or the outer tile (kind T) — is excluded by no cone at p, u, y or v; a proof must read y's own ring, which carries three absent colours and no parity". A construction by formula (FS114-Y2-BOWTIE with its tip `t2` removed from `top`) or a reason none exists decides it."

**Kind of input** (written first): an invariant of the colouring of the ring of `y`, a vertex of exactly three colours — its winding (height),
read on a ring free of arcs of `Γ`. § 2 check: G73 excludes cell-local topological certificates on lattice graphs at four colours; a winding on one
circle about one vertex is not that. Admissible.

**Read for it**: FS116-N3-SEMI, -RING-TRANSFER-QC, -N3-STAR2, -N3-PAIR, -V5-DICHO, -V4-TWIST, -V5-U1, -V6-HUG; FS112-N3-NOBOTH; FS110-N2-RING,
-Y3-GP, -N2-ROT, -N2-TRANS, -FLIP; FS112-ROTHEX; FS114-Y2-BOWTIE (the model the step names); FS129-OR1-BENDFRAG (stage 2).

**Verdict: shortened, not closed** (composition FS129-OR1-BEND3). The GAP asks a proof to read `y`'s own ring. That reading can start from a ring free
of arcs of `Γ`: at a vertex of exactly three colours in the non-Siamese simple class no arc of `Γ` on its ring has both side colours at the vertex, so
stage 2's bends run there too (FS129-OR1-BEND3), on a fragment of radius below `√3` about `y` that keeps `y`'s colours and every tile at `p`
(`|p − y| = 1`, so `p`'s tiles meet `B(y, ρ)`). The ring is then exactly the object of **FS110-N2-RING** and **FS110-Y3-GP** (two minds each): "a
three-colour vertex whose unit circle carries no arc of `Γ`" — **FS-110's winding `W` is the height Poros's hunch sought from lane A (G71), held in
lane R under FS-110's name** (Condition-5 era, so never read against FS-116's rings). Caveat, not claimed: the semi-hub's defining data are `p`'s ring
germs at `r(ψ ± 60°)`, which lie on `ω(y)`; to keep them the bends at `y` must be pinned at those two points — a horn lens tangent to the bent arc at a
pin leaves a transversal circle's germs in the tiles they were in, and pins are N2-TAN's device ("corners elsewhere on `α` at non-contact points") —
but that is not derived here. What remains of SEMI-PAR3: whether the winding constraint on `y`'s three-absent-colour ring (Y3-GP: `W ≡ 3 (mod 6)`
when no two change points are `60°` apart) contradicts a full parallel semi-hub — a derivation for FS-124, not a composition.

derivation: FS129-OR1-BEND3
  statement: let F be a non-Siamese simple valid six-coloured fragment on a closed disc B̄(q, r), r > 1, about a vertex q of exactly three colours, and
    1 < ρ′ < min(r, √3); then there is a non-Siamese simple valid six-coloured fragment on B̄(q, ρ′) in which q is a vertex whose tiles at q have the
    colours they have in F, whose ring carries no arc of Γ, and whose tiles include every tile of F meeting B(q, min(r, √3)) other than the side tiles
    of arcs of Γ on ω(q), which it modifies only inside thin lenses along those arcs
  uses only: FS129-OR1-WHOLE; FS112-N2-BENDS (N2-TOWARD, N2-AWAY) read on a fragment, as in FS129-OR1-BENDFRAG's argument; FS116-V5-U1 (at the centre of
    an arc of Γ the inner colour's sectors lie in the facing cone, the outer colour's in the away cone, neither in the two open side cones); that a
    non-Siamese simple fragment has no repeated colour at a vertex (two tiles of one colour at q are near, by FS116-V4-DICHOTOMY; one tile twice at q
    has a closure that meets itself)
  not claimed: that the bends can be pinned at chosen points of ω(q) keeping the germs there of circles that cross ω(q) (J2 needs it; not derived);
    anything at radius √3 or more; anything in the Siamese or non-simple classes; anything about vertices of four or more colours (FS129-OR1-BENDFRAG)
  argument: § Argument for FS129-OR1-BEND3
  verdict: derived
  grade: derived from: FS129-OR1-WHOLE, FS112-N2-BENDS, FS116-V5-U1
  minds: 1
  model: any cubic trichromatic vertex u of the capped strip (FS114-Y-DIAL) whose closed unit disc lies at distance above 1 from the strip's edge, on
    B̄(u, 1.1): a non-Siamese valid fragment about a vertex of three colours (`plans/FS112-NB3-verification.md` § 1.4's killing test 8 reads the strip's
    trichromatic vertices); its ring's arcs of Γ, if any, are bent
  prior art: owed — in-house
  handoff: de Bruijn — with FS129-OR1-BENDFRAG (one module: the bends on a whole-tile fragment below √3)

#### Argument for FS129-OR1-BEND3

*No arc of `Γ` on `ω(q)` has both side colours at `q`.* Let `α ⊂ ω(q)` be one, of angular extent `ℓ > 0`, with side colours `c` (inner), `c′`
(outer), and suppose both are carried at `q`. By FS116-V5-U1 the directions of `c`'s sectors at `q` lie in the closed facing cone and `c′`'s in the
closed away cone, and the two open side cones, each of width `ℓ`, hold neither. Each side cone is covered, but for finitely many edge directions, by
sectors of tiles at `q` of colours outside `{c, c′}`. One sector cannot meet both side cones: a sector is a connected range of directions, and joining
the two side cones it would contain the whole facing cone or the whole away cone, where `c`'s or `c′`'s sector directions lie (a zero-angle cusp
direction of `c` included: a sector containing it in its interior would overlap `c`'s tile near `q`). So `q` has at least two sectors of colours
outside `{c, c′}`, of different colours because `q` has no repeated colour, and `q` carries at least four colours — not three. (This is FS112-N3-NOBOTH
read on a fragment.)
*The bends.* FS129-OR1-BENDFRAG's argument, with "non-(Q)" replaced by "not both side colours at the centre": that argument used "at least four colours
at `p`" only to pass from "not (Q)" to "one side colour absent at the centre", which here holds for every arc of `Γ` on `ω(q)`. So on `F_ρ`,
`ρ = min(r, √3)`, every arc of `Γ` on `ω(q)` bends whole (toward `q` if its outer colour is absent there, else away, no witness by FS129-OR1-WHOLE),
keeping the class, `q`'s colours and every tile away from the lenses; the ring then carries no arc of `Γ`.

### J3 — FS-125: NO-SAT, through its cases

**The step** (as the demand list quotes it): (`plans/STUB-saturated-local.md` ll. 21–22): "**NO-SAT** (`data/fs116/claims.md` § 4): "there are an explicit radius `R`, one `R` for every complexity, Siamese pairs allowed, and a derivation that no valid fragment on the closed disc of radius `R` about a vertex of at least four colours is saturated on the closed disc of radius `R − 1` about it.""

**Kind of input**: contact at distance exactly 1 (SATPIN) against a straddle; for case 1's G3 and case 2, the ring type. Admissible.

**Read for it**: FS116-SAT-STRIP, -SAT-QFREE, -S1-QF, -S1-RUNG, -S1-KAPPA, -S1-LENS, -S1-EXIT, -N1-TOUCH, -N1-ECHO, -N1-F15TOUCH, -O1-SATPIN,
-Y1-STRIPCEIL, -Y1-F15; FS111-M-PINCH, -M4-LADDER; the FS-125 stub's G1–G3 (`plans/STUB-saturated-local.md` ll. 35–37); FS129-OR1-QFREE.

**Verdict: shortened** (no new entry; consequences of FS129-OR1-QFREE, stage 2). Case 2 (SAT-QFREE's touch point) and case 1's G3 (QF's tilt — "crosses
not at right angles") are both about fragments whose ring carries no (Q) arc. FS129-OR1-QFREE excludes every such fragment on any disc of radius above 1
in the non-Siamese simple class — saturated or not, at any crossing angles. So **G3 and SAT-QFREE are closed in the non-Siamese simple class**; what is
left of them is their non-simple part (FS116-S1-QF is stated for non-Siamese fragments without "simple") and their Siamese part (with G2). G1 (rings with
(Q) arcs, the strip-like class) and case 3 are untouched; FS116-N1-F15TOUCH (SAT-QFREE false without "(Q)-free") is consistent, the capped strip's ring
carrying four (Q) arcs.

### J4 — FS-128: TOP₆, a smaller form

**The step**: (`plans/STUB-top-colour.md` ll. 10–11): "boundary point is bound (has a point at distance exactly 1) for every colour present there except the largest (FS121-D3-GRUNDY, held). **TOP₆:** can some Grundy six-colouring, obtained from a tight one, have its largest colour bound too? That is honest saturation at six (C121-SAT6). On the cover"

**Kind of input**: coverage of a top-colour boundary point's unit circle by the lower colours; § 2's FS111-M2-NOSEL and FS111-M-DEADLOCK exclude
selection and local fills, so the admissible kind is a coverage argument that spends six (FS121-D3-EQ). Admissible.

**Read for it**: FS121-D3-GRUNDY, -D3-EQ, -D3-FALLSAT, -D3-SWAP1D, -C1-BOUND, -C1-GMAP, -O1-ABOVE7, -V4-HEXMID, -V4-EDGE; FS111-M-SATC, -M2-NOSEL,
-M-DEADLOCK, -W-FILL-FREE, -VMW-R7-MAX, -M-R7-FORCE, -W-HEXSAT.

**Verdict: null** — no lane-R result gives a statement strictly smaller than C121-SAT6 at six. Near misses: FS121-D3-SWAP1D (on a circle an honest
saturated three-colouring exists where no idomatic partition does — it separates idomatic from honest saturated, it does not bind a top colour);
FS111-VMW-R7-MAX (R7 saturated in the strongest reading — seven colours); FS121-O1-ABOVE7 (the "lies below" form false at seven). FS129-OR1-TOP5 (J10)
shows the five-colour top-colour clause is the five-colour answer restated given REG-J′₅, so no smaller form of TOP₆ comes by analogy with five.

### J5 — FS-124, case 4: the five- and six-colour vertices

**The step**: (`plans/STUB-q-ring.md` ll. 36–39): "4. **The five- and six-colour vertices** (item 61): a five-colour vertex's ring has no change point and (Q) arcs over at least half of it (FS116-N2-FIVERING); a six-colour vertex's ring is six 60° (Q) arcs, one per tile of `p`, with outer colours constrained (FS116-N2-SIXRING). One family dies below `√3` (FS116-Y2-SIXOFF, Siamese pairs allowed); a fragment by formula holds `B̄(p, R)` for every `R < 3/2` (FS116-Y2-SIXFRAG, exact). De Grey and Gibbs left this vertex's next layer undone in 2018 (`[Polymath16threads]` [08.17]–[08.18])."

**Kind of input**: distances between outer tiles at (Q)-arc ends `60°` apart (the identity of V6-HUG on `{p, y}`). Admissible.

**Read for it**: FS116-N2-FIVERING, -N2-SIXRING, -Y2-SIXOFF, -Y2-SIXFRAG, -V6-HUG, -V4-CHORD, -V4-TWIST, -RING-TRANSFER-C; FS112-SIX; FS129-OR1-BENDFRAG.

**Verdict: null.** FS129-OR1-BENDFRAG adds nothing here: FIVERING already forces (Q) arcs over half of a five-colour ring with Siamese pairs allowed,
SIXRING makes the six-colour ring six `60°` (Q) arcs, and any exclusion must read past `3/2` (SIXFRAG), beyond which BENDFRAG (below `√3`) says only
that `p`'s ring carries (Q) arcs and points — already true here. V6-HUG is the hunch's tool; no held result applies it at a five- or six-colour vertex.

### J6 — FS-124, case 2: the disk's corner

**The step**: (`plans/STUB-q-ring.md` ll. 30–33): "2. **The closed change point, the disk's corner** (FS116-RING-Q's GAP; items 40, 97): a change point of two colours whose `±60°` points lie inside (Q) arcs. RING-Q is false below radius `≈ 1.5985` (FS116-N1-QDISK: `[Polymath2021]` Fig. 10's disk about its corner), and any exclusion on `B̄(p, 2)` must read the far side of `p`, in the directions `(ψ + 157.4°, ψ + 324.5°)` (FS116-Y2-DCREAD). A fragment by formula beyond radius 2 holding the configuration makes RING-Q false in its class."

**Kind of input**: points and distances on `p`'s far side, in DCREAD's directions. Admissible.

**Read for it**: FS116-N1-QDISK, -Y2-DCREAD, -RING-GERM, -RING-Q, -RING-Q-PRIME; FS112-CAL-DISK, -DISK-RIM, -DISK-S1, -DISC, -MOVE, -Y3-PIN;
FS114-Y-PENT, -Y-ROUTES.

**Verdict: null**, with a reduction candidate for pass 2. FS114-Y-PENT ("no valid map agrees with the disk near `B_k`, `Z^R_k`, `Z^L_{k+1}`") and
FS112-DISC ("no vertex-centred disc of radius above `φ` lies in any valid extension of the disk") exclude the disk's own combinatorics past `φ`. They
would close J6 only with a rigidity lemma — a fragment holding the disk-corner configuration on `B̄(p, 2)` agrees with the disk near some `B_k` and its
two partners — which no held result supplies, and which DCREAD's directions (outside the disk) may contradict. Not derived.

### J7 — FS-123 question 3 with FS-124 case 7: the Siamese and non-simple classes

**The step**: (`plans/STUB-qfree-ring.md` ll. 35–37): "3. **The Siamese and non-simple forms of EMPTY.** C114-LOCAL-F allows Siamese pairs (tiles of one colour inside each other's exclusion annulus). FS116-V6's route used non-Siamese "only for the uniqueness of `R⁻`, `R⁺` and of the tip" and simplicity only at its last step; FS116-Y4-FLANK is colour-free with Siamese pairs allowed; FS116-N1-GERM-S is RING-GERM without non-Siamese. Does the Γ-free type die at `1 + ε` with Siamese pairs allowed, or with non-simple tiles?"

**Kind of input**: points and distances only, never a count (G86). Admissible.

**Read for it**: FS116-Y4-FLANK, -N1-GERM-S, -RING-Q-PRIME-S, -N1-QFREE4, -S1-KAPPA, -Y3-SIX, -V6-HUBS, -V6-HUG, -V6-COUNT; FS129-OR1-QFREE-CLASS.

**Verdict: reduced** (stage 2's FS129-OR1-QFREE-CLASS): EMPTY's Siamese or non-simple form, once derived, gives the (Q)-free form at no cost, so J7's
(Q)-free half is its Γ-free half. The Γ-free half itself: null — no held lane-R result removes non-Siamese from FS116-Y3-SIX's or FS116-V6's tip
uniqueness; FS116-Y4-FLANK (Siamese allowed) is the held piece the stub already names.

### J8 — FS-126: a curved tangent-type interface, at any number of colours

**The step**: (`plans/STUB-curved-pencils.md` ll. 14–15): "**Does any such colouring, at any `k`, have a tangent-type boundary arc of finite radius?** No held colouring does: R7 has only split unit arcs; SQ9 and HEX9 only segments."

**Kind of input**: a construction meeting FS121-D1's constraints, or an obstruction, for an aperiodic structure — a one-sided pencil of concentric
integer-radius interface arcs. § 2's FS121-D4-TINY16 forbids counts per region, not this. Admissible.

**Read for it**: FS121-D1-PENCILWIN, -D1-DOUBLE, -D1-VT, -D2-THIN, -D2-INCURVED, -D2-SYM, -D2-PERFIN, -V5-SYM-CPT, -V5-SYM-UP, -O1-OUT, -O1-PER,
-O1-LRA-LINE, -DB1-L7; FS112-N2-RAY, -N3-CHAINS, -Y3-R1, -N3-PER, -Y3-END-AB; FS110-N4-FIN, -N4-SHADOW.

**Verdict: null**, with a pass-2 note — one mechanism held twice. FS-112's extremal one-sided stuck chain (FS112-N2-RAY: "the pencil of circles of radius
`k + 1` about `P_{−1}` with straight upper arcs, every shadow tight"; FS112-N3-CHAINS: on an upward-infinite chain the horn at `P_k` needs a boundary arc
of radius at least `k + 1`) and FS-121's tangent-type ladders (FS121-O1-OUT: radii `n, n + 1, n + 2, …`; -D1-PENCILWIN; -D2-THIN) are one object, a
one-sided pencil of concentric integer-radius arcs — met first as a valid map's stuck ray (FS-115), then as a saturated colouring's curved interface
(FS-126). FS112-N3-PER ("a doubly periodic valid map … has no stuck ray") and FS121-D2-PERFIN with -O1-PER are the same periodicity kill. No held
result decides FS-126; FS112-Y3-END-AB (a finite chain realised exactly over ℚ with the recursion taken with equality) is the nearest construction,
and it is finite.

### J9 — FS-127: LAT

**The step**: (`plans/STUB-lateral-extent.md` ll. 12–13): "another `c`-piece of half-width `ρ` across a gap `g` with `2g < ρ²` loses its contact, so `c` has density 1 there. **LAT:** at every accumulation point some colour has two pieces in that position. LAT with FACE gives the claim."

**Kind of input**: distance-exactly-1 facts at an accumulation point — the sagitta of the unit circle (G90). Admissible.

**Read for it**: FS121-D4-FACE, -D4-GRID, -D4-FALL, -D4-HOLE, -D4-LINE, -V5-FACE-SHARP, -V5-RAY, -V5-GRID-CANTOR, -V5-PAIR; FS111-M3-HC, -M4-CUT,
-M4-HC, -M3-BAND.

**Verdict: null**, with a pass-2 note: FS111-M4-CUT's bound `β(u) ≤ n − (n² − (u − z)²)^{1/2}` (a ladder's `n`-th rung over a gap end) and
FS121-D4-FACE's `2g < ρ²` (sharp as `(1 − g)² + ρ² ≥ 1`, FS121-V5-FACE-SHARP) are one sagitta — at radius `n` along a ladder, at radius 1 at a face. LAT's
open case (pieces that shrink faster than the square root of their gaps) is where both are idle.

### J10 — The map step at five: no open stub carries it

**The step**: (`plans/FS111-derivation.md` l. 1350, entry FS111-REG-JP-C5): "statement: if a tight a.e.-proper five-colouring exists, some maximal five-cover has regular classes whose boundaries form a locally finite plane graph"

**Kind of input**: regularity — of maximal covers (a modification lemma keeping maximality) or of honest saturated colourings (a regularity theorem).
Admissible.

**Read for it**: FS111-REG-JP-C5, -VM2-EQ5, -M2-REDUCE-C, -M-REDUCE-I, -C-SIX-M, -C-REG-EQ, -V0-RESCALE, -C-SAT-T-HONEST, -M2-COV, -M2-FIX, -M2-HULLC,
-M3-IRREG, -M3-FIN-U, -M3-MOVE, -M3-COVER, -M4-MOVE, -M3-CASCADE; FS121-SAT6, -REGJ, -D3-GRUNDY, -D3-EQ, -D3-FALLSAT, -C1-GMAP; FS106-AE-MAP6;
FS114-N2-AVG; `plans/STUB-pinch-at-junction.md` ll. 40–47; `plans/STUB-top-colour.md`; `plans/STUB-lateral-extent.md`.

**Verdict: reduced, and the list's carrier line corrected** (composition FS129-OR1-TOP5).
1. *"No open stub carries it" is half true* (a finding about the demand list). Two held routes lead from a regularity statement at five to
   `χ_m⁰(ℝ²) ≥ 6`, both through FS106-AE-MAP6: the cover route (FS111-M2-REDUCE-C — MUA-REG-P and MUA-FIN with D3's clause; REG-JP-C5 is its whole
   statement) and the honest route (FS111-M-REDUCE-I — the honest existence form of C-SAT-T at five, which is FS121-SAT6's `k = 5` clause, with REG-J′₅).
   FS111-C-SAT-T-HONEST's gap line already says honesty "at five … is not needed (FS111-M2-REDUCE-C)". Of the pieces: MUA-FIN is carried by FS-120 (its
   stub l. 44: "at five, the cover statement REG-J′-C₅"); REG-J′₅ by FS-127 (FS121-REGJ is stated "with any number of colours"); **no stub carries
   MUA-REG-P or the top-colour clause at five**.
2. *FS129-OR1-TOP5*: given REG-J′₅, the honest existence form at five holds if and only if `χ_m⁰(ℝ²) ≥ 6` (at AE-MAP6's grade) — the five-colour mirror
   of FS121-D3-EQ. So the honest route at five has one piece that is not the five-colour answer restated: REG-J′₅, which is FS-127's LAT at five. With
   FS111-VM2-EQ5 (the cover route's whole statement is the answer restated), the smaller pieces of the map step at five are colour-generic and already
   carried (FS-127, FS-120), except MUA-REG-P.
3. *A note, not derived*: at five, FS121-C1-GMAP's route needs no C121-NOPAR — FS106-AE-MAP6 excludes every a.e.-proper map-type five-colouring outright,
   so any statement turning a tight five-colouring into an a.e.-equal locally finite map colouring (for instance, FS121-D3-GRUNDY's Grundy colouring
   being one) gives `χ_m⁰(ℝ²) ≥ 6`. The obstacle at five is then regularity where the top colour is unbound (FS111-M-PINCH needs both colours bound) — the
   same obstacle TOP₆ names at six.
4. FS106-AE-MAP6 can be replaced by FS114-N2-AVG's N2-FIVE-PLANE ("no simple non-Siamese valid five-colour map of the plane exists"; one mind; by
   counting; no Townsend's (c)) wherever the map a route produces is simple and non-Siamese (J23).

derivation: FS129-OR1-TOP5
  statement: if REG-J′₅ holds — FS111-M-REDUCE-I's regularity hypothesis at five colours, a saturated colouring whose singular set Σ is locally finite
    with finitely many interface arcs at each point of Σ — then the honest existence form of C-SAT-T at five (every tight a.e.-proper five-colouring can
    be modified, keeping it a.e.-proper with five colours, into an honest saturated one; FS121-SAT6's k = 5 clause) holds if and only if
    χ_m⁰(ℝ²) ≥ 6, the forward direction at FS106-AE-MAP6's grade (modulo Townsend's simplification (c))
  uses only: FS111-M-REDUCE-I ("with FS106-AE-MAP6, χ_m⁰(ℝ²) ≥ 6 follows from those two statements at k = 5"); FS111-V0-RESCALE (a tight a.e.-proper
    k-colouring exists if and only if χ_m⁰(ℝ²) ≤ k); vacuity
  not claimed: REG-J′₅ (FS121-REGJ at five, open — FS-127's LAT); the honest existence form at five; the equivalence without REG-J′₅; the forward
    direction beyond FS106-AE-MAP6's grade; anything at six (FS121-D3-EQ)
  converse: § Argument for FS129-OR1-TOP5
  argument: § Argument for FS129-OR1-TOP5
  verdict: derived
  grade: derived from: FS111-M-REDUCE-I, FS111-V0-RESCALE
  minds: 1
  model: vacuous when χ_m⁰(ℝ²) ≥ 6 (no tight five-colouring exists, by FS111-V0-RESCALE, and every clause holds); no non-vacuous model is known, which is
    the statement's content: at five colours the top-colour clause is the answer restated once REG-J′₅ is granted
  prior art: owed — in-house; the six-colour mirror is FS121-D3-EQ
  handoff: de Bruijn — the statement as a corollary of FS111-M-REDUCE-I's module, over FS106-AE-MAP6 as an imported hypothesis

#### Argument for FS129-OR1-TOP5

*Forward.* Assume REG-J′₅ and the honest existence form at five. FS111-M-REDUCE-I gives REG-I₅ from the two, and with FS106-AE-MAP6, `χ_m⁰(ℝ²) ≥ 6`
(its statement's second clause).
*Converse.* Assume `χ_m⁰(ℝ²) ≥ 6`. By FS111-V0-RESCALE no tight a.e.-proper five-colouring exists, so the honest existence form at five — a statement
about every tight a.e.-proper five-colouring — holds vacuously; REG-J′₅ is not used.

### J2 addendum — the relay from lane A (FS129-OA1, received during this stage, folded in before its commit)

- **FS129-OA1-RINGWIND** (`plans/FS129-OA1-audit.md` l. 348; hand, one mind): on a three-coloured ring proper at `60°`, the hexagonal winding takes values
  in `{−2, 0, 2}` and jumps only where two change points sit exactly `60°` apart. **This is FS-110's held mechanism** — FS110-Y3-GP ("A ring with no two
  change points exactly 60° apart winds `W ≡ 3 (mod 6)`; so `|W| ≤ 2` needs two change points at distance exactly 1", two minds, one blind) and
  FS110-N2-RING (two minds) — with a per-hexagon normalisation in place of FS-110's. **Cross-era merge candidate for pass 3**: one statement, two
  normalisations, lane A's at one mind and FS-110's at two; the strong merged form should name both.
- **Lane A's question, verbatim from `data/fs129/reports/FS129-OA1.md` l. 19**: "compute the winding jump at (u, p, v) on ω(y) from FS116-N3's (Q) arcs
  at u⁺, v⁻ and p's tiles t_a, t_{a′}; a non-zero jump forces a second 60° pair of change points on ω(y) at radius 2". Not computed in this pass —
  **a lead for pass 2 (MR1) and FS-124's opening**. What lane R adds to it: `u = r(ψ + 60°)`, `p` and `v = r(ψ − 60°)` are three consecutive points of
  one hexagon of `ω(y)` (the triangles `p y u` and `p y v` are equilateral), so the jump is read at one hexagon position; FS129-OR1-BEND3 supplies the
  hypothesis "no arc of `Γ` on `ω(y)`" that both RINGWIND and FS110-Y3-GP need, on a fragment about `y` of radius below `√3`, but SEMI-PAR3's own fragment
  is on a disc of radius just above 1 about `p`, which does not contain all of `ω(y)` — reading the whole ring needs radius 2 about `p` (as lane A says)
  or a fragment about `y`.
- Lane A's second relay item (at least 158 of the 418 lowercase "gap" lines of `data/fs129/index/open-steps.md` § 4 are the fan-gap sense, a property of a
  colouring) is taken into my reading of the mechanical half (stage 4).

## Stage 4 — SAVED: J11–J24, the mechanical half, and the cross-era line

### J11 — FS-120: the pinch at a junction
**The step**: (`plans/STUB-pinch-at-junction.md` ll. 28–29): "**The question: where the ladder ends — at a junction of three or more colours, at a class with disconnected local parts, or at an irregular class — is the cascade absorbed?** Three questions, in order:"

**Kind of input**: a modification lemma along the ladder of unit parallels, ending at a junction. Admissible.
**Read for it**: FS111-M4-LADDER, -M4-CUT, -M4-MOVE, -M4-HC, -M3-CASCADE, -M3-MOVE, -M3-COVER, -M3-FIN-U; FS121-D4-FALL, -D4-GRID, -D3-FALLSAT.
**Verdict: null.** M4-MOVE (the classes at every rung agree when two partitions differ only over a gap, "no spare colour enters, at any k") and
M3-CASCADE (every gaining class loses all its old material) are the stub's own inputs; no lane-R result says where the cascade ends at a junction.

### J12 — FS-104 route (c): correlation constraints on stationary colourings
**The step**: (`plans/STUB-cp-plane-six.md` ll. 67–69): "- **(c) `k`-point correlation constraints** on stationary colourings — the tetrahedral embedding at five colours, three- and four-point Bessel kernels à la Bachoc–Oliveira–Vallentin; FS-80's averaged certificate at the real place (FS-80 re-aimed). An optimisation: post-ban unless its shape is derived first (the advisor)."

**Kind of input**: a spectrum or multi-point correlation of an invariant random colouring; § 2's row 91 / G75 note excludes pair correlations on a
real field. Admissible at three or more points.
**Read for it**: FS106-SUP, -EQ, -COMP, -REM, -PDEQ; FS107-W-EQ-K.
**Verdict: null** (lane R, as the list expected). Near miss: FS106-SUP (`µ₆⁰` is attained by a stationary family and by almost every sample of it) supplies
the stationary object route (c) would take correlations of; it constrains nothing.

### J13 — FS-104 routes (0) and (b): Falconer's mechanism, read as a CP statement
**The step**: (`plans/STUB-cp-plane-six.md` ll. 59–61): "- **(0) Read `[Falconer1981]` first, as a CP statement** — the advisor: continuity in probability lets a forced pair's distance vary continuously, which may be Falconer's mechanism. Owed before any route is ranked (G50). With it: Soifer's measurability chapter, the Polymath16 measurable page, Bachoc–Nebe–Oliveira–Vallentin (arXiv:0801.1059), `[AmbrusEtAl2023]`."

**Kind of input**: a compulsion — a pair forced equal or apart at a continuously varying distance. Admissible.
**Read for it**: FS106-REM (kept points never at distance in `[1 − ε, 1 + ε]`; its uniform form false), -COMP, -EQ; FS111-V0-ID1.
**Verdict: null** (lane R). The reading of `[Falconer1981]` is lane A's and the stub's.

### J14 — FS-122: B-RR, a cone-scale bound independent of the holes
**The step**: (`plans/STUB-forced-pair.md` ll. 23–24): "1. **B-RR** — a cone-scale lower bound `s₀`, **independent of `δ`**, at the pairs (A) supplies. The `δ`-dependent form B-NONABS is FALSE as written (`FS111-W-B-NONABS`: a fragment has holes `≲ (ε + s)²` near the forced point at every scale `s`); B-RR cannot be refuted by a wild object."

**Kind of input**: a feature's scale bounded below, priced at the feature's scale (G82 as corrected). Admissible.
**Read for it**: FS107-RR, -R-CP, -V-CP, -W-TAN, -R-SW, -R-OB2, -K-AD, -MEET; FS111-W-B-NONABS, -W-HX-PAIRS, -W-NEG, -C1-FALS, -V0-WIGGLE.
**Verdict: null.** Near misses: FS111-W-HX-PAIRS (HX carries complementary fat-junction pairs blocking toward points inside its voids — the holes sit
where R-CP puts them, at an `ε`-independent scale set by the design) and FS111-V0-WIGGLE (notching raises complexity at fixed slack and fixed cones,
cost `O(α²)`) bound B-RR's form from the construction side; neither is a lower bound.

### J15 — Route R's pairs and route M's four-colour vertices, with unit arcs (Poros's invention signal)
**The step**: (Poros's words): with unit arcs — where route M's open steps live — does every close complementary pair of route R meet a vertex of at
  least four colours at its common unit points, so that FS-123's and FS-124's exclusions bear on route R below the answer?

**Kind of input**: a band-stable form of row 135's rhombus lemma. Admissible.

**Read for it**: FS112-N3-COR3, -STOP, -Y3-R3, -STRIP-SEAMS, -C-PARTNERS, -Y3-T2-BUDGET, -FORCE; FS110-NB-5, -N-SEAM, -Y-T2W; FS107-W-TAN, -R-CP, -MEET,
-RR; FS114-Y-PAIRSHARE; FS129-OR1-QFREE.

**The collision, both sides quoted, no side picked until the premise is named.**
- *Side 1* (`plans/STUB-forced-pair.md` ll. 35–37, verbatim): "Under Condition 5 at bounded complexity no close complementary pair exists in a valid map
  at all (row 134, NB-5), which is why the map line never needed (A); so this route and FS-121's meet nowhere below the answer."
- *Side 2* (`LEDGER.md` row 135, as the demand list quotes it): "a close complementary pair of cubic trichromatic vertices sits on a unit rhombus with
  four-colour corners (FS-110's T2, forced)"; and FS112-STOP (`plans/FS112-derivation.md`, verbatim): "The pinned corner: the strip and the disk stop at
  the same kind of point, the second common unit point of a close complementary trivalent pair saved at its first by a four-colour vertex where both
  members emit arcs of its circle"; FS112-Y3-R3: "At both held positives every close complementary pair of vertices is saved at one common unit point by
  half of T2, at both exactly when it is a rhombus completion (T2 twice), and its unsaved second point is where the positive stops".

**The premise both sides share, named:** that "close complementary pair" names one object across the two routes. Side 1's *reason* is a theorem about
exact valid maps **under Condition 5** (row 134; FS110-NB-5: "Under Condition 5 a tight six-map in `𝓜_K` has no close covering pair"); its *conclusion*
("meet nowhere below the answer") carries no such restriction. With unit arcs — where route M's open steps live — exact valid fragments carry close
complementary pairs (24 per period on the strip, 20 on the disk, FS112-Y3-R3's exact recount), FS112-N3-COR3 forces four-colour vertices at both common
unit points of every cubic trichromatic one in a valid map, and both held positives stop exactly at a pair's unsaved second common unit point — which is
route R's mechanism (FS107-R-CP: a complementary pair blocking toward `w` forces holes at `w`) at `ε = 0`. FS107-MEET already reads W-TAN and R-CP as
"one fact, C-T-TAN's cone case, read as a design rule and as an area".

**Verdict: the invention signal does not stand** — no two held results contradict; side 1 is a stub's bearing sentence whose conclusion exceeds its reason.
It is a **statement defect** in `plans/STUB-forced-pair.md` l. 37 (correction owed, Keryx's file): "meet nowhere below the answer" holds under Condition 5;
with unit arcs the routes meet at the pinned corner (FS112-STOP). **Answer to Poros's question**, in its exact-map form: yes for cubic trichromatic pairs —
in a valid map both common unit points are vertices of at least four colours whose rings carry both-kind, hence (Q), arcs (FS112-N3-COR3), so they are
FS-124's class (FS129-OR1-QFREE confirms none is (Q)-free), and a local exclusion of four-colour vertices with (Q) rings leaves no such pair in any valid
map. At `ε > 0` the bearing on route R needs a band-stable four-colour kill: **J15 reduces to J16's carried card**. Not covered: route R's fat junctions of
higher degree (COR3 is for cubic trichromatic vertices).

### J16 — FS-122: a robust count, and whether the kills survive a band
**The step**: (`plans/STUB-forced-pair.md` ll. 25–27): "2. **What replaces the bicycle's swap at unbounded complexity** — the index of density traces (G71, row 132) is the one integer invariant held for six-colour interfaces, and it fails where a unit-arc interface faces a bowtie; `[Voronov2023]` Lemma 6.1's branch (i) ends at a bicycle, whose swap FS107-R-SW prices at `2εs` and `s³/256`."

**Kind of input**: a margin bounded below at a feature's scale. Admissible.
**Read for it**: FS114-Y4-RSTOPALL, -Y3-RSTOP, -Y5-PXKILL, -Y5-PINALL; FS107-R-SW, -R-OB2; FS106-IND, -IND-X; FS116-V6-HUG.
**Verdict: null.** FS107-R-SW (`2εs` and `s³/256` at a flat swap) and V6-HUG's second-order deficit are the stub's own data; no lane-R kill is stated with
a margin. J15 now reduces to this step.

### J17 — FS-124 cases 3, 5 and 6: crossed reciprocity, the recurrence, FS114-K1's (Q) residues
**The step**: (`plans/STUB-q-ring.md` ll. 34–35): "3. **Crossed reciprocity** (FS116-RING-TRANSFER-Q's third place): whether a crossed semi-hub's placed vertex has `p` as a crossed semi-hub — the order of its outer tiles; and FS116-N3-CROSS's last clause ("p is a semi-hub of kind O of the ring of y"), one mind and a checking reading (item 118)."

**Kind of input**: a label conserved along placements (case 5); points and distances at named configurations (cases 3, 6). Admissible.
**Read for it**: FS116-N2-STAR, -N2-RECIP, -N2-ANTI, -N3-CROSS, -V5-CROSS-S, -RING-TRANSFER-QC; FS114-K1, -N7-QOPP, -Y6-E1CAP, -Y6-E2RED, -Y6-HALF,
-Y4-RSTOPALL; FS129-OR1-BENDFRAG, -QFREE.
**Verdict: shortened, case 6 only** (no new entry). FS114-K1's residues on (Q)-free rings have no instance (FS129-OR1-QFREE, non-Siamese simple — K1's own
class); on rings with (Q) arcs, a residue whose exclusion reads below `√3` about `p` may assume `p`'s ring carries (Q) arcs and finitely many points and no
other arc of `Γ` (FS129-OR1-BENDFRAG) — N7-HUBQ's step and the (Q)-pinwheel's residual at `1 + ε` among them; the Reuleaux `(2, 1, 1, 0)` past `√3` is not
reached. Cases 3 and 5: null in lane R (the recurrence's `KG(4, 2)` reading is lane A's G73).

### J18 — FS-123 question 2: the (R2)-arc ring, directly
**The step**: (`plans/STUB-qfree-ring.md` ll. 32–34): "2. **The (R2)-arc ring, directly.** Inventory item 126: "The successor question: does FLANK's mechanism close the (Q)-free rings that carry (R2) arcs after the bends (FS114-N6-RING60's class, where N7-HUB and N7-3T live), a semi-hub whose tip is shared with the next change point, and OC?" There a change point may end an (R2) arc, RING-GERM's tip is not given, and the double tip's existence is not shown (`plans/FS116-Y4-construction.md` § 3.3)."

**Verdict: moot** — it was conditional on J1's answer being no; J1 closed yes (stage 2, FS129-OR1-QFREE): in the non-Siamese simple class no ring of a
vertex of at least four colours is (Q)-free on any disc of radius above 1, so the (R2)-arc rings of FS114-N6-RING60's class do not occur there.

### J19 — FS-124 case 8: DISC-F and LOCAL-DENSE
**The step**: (`plans/STUB-q-ring.md` ll. 47–50): "8. **The exclusion's two other forms, not worked at FS-116** (`data/fs116/claims.md` § 6): **DISC-F**, "there are an explicit radius `R` and a derivation that no valid fragment exists on any closed disc of radius `R`" (its *not claimed* line: any `R` at most the disk's `≈ 2.1246`), and **LOCAL-DENSE**, "there is an explicit `r ≥ 3` such that every valid fragment on a closed disc `B̄(x, r)` has, in `B̄(x, 3)`, a vertex of at least four colours or a vertex with a repeated colour" — with LOCAL-DENSE, C114-LOCAL-F and DISC-F are one question (`plans/FS116-local-exclusion.md` § 3.6)."

**Kind of input**: a local density lemma — a bounded-radius form of FS112-N3-DENSE3. Admissible.

**Read for it**: FS112-N3-DENSE3, -N3-BASE, -DISC1, -N2-DENSE, -N3-NOBOTH; NB3's walk of the base (`plans/FS112-NB3-verification.md` § 1.4, "every point
whose colours it reads lies in `B̄(u, 2)`", "C-LOCAL: radius 2 about `u`"); NB2's DISC1; FS114-N114-COMPACT, -CV-EXISTS; `plans/FS116-local-exclusion.md`
§ 3.6.

**Verdict: LOCAL-DENSE closed, at `r = 3`** (FS129-OR1-LOCALDENSE), **and DISC-F reduced to C114-LOCAL-F in the non-Siamese simple class**
(FS129-OR1-DISCF-NS). Caveat: no valid fragment on a disc of radius 3 is held, so LOCAL-DENSE may be vacuous; it bears on the YES side's
fragments on discs of every radius, which is where FS-116 § 3.6 wanted it. DENSE3's proof was already local — DISC1 reads `B̄(x, 1)`, the base reads `B̄(u, 2)` — but no record stated the fragment form.
**A correction owed to FS-116's § 3.6** ("with a local form of FS112-N3-DENSE3 … they would be the same question"): LOCAL-DENSE's alternative is a vertex
of at least four colours *or one with a repeated colour*, and C114-LOCAL-F excludes only the first. So DISC-F follows from C114-LOCAL-F with LOCAL-DENSE in
the non-Siamese simple class, where no vertex has a repeated colour; in the Siamese or non-simple class it needs, besides, either the same exclusion about
repeated-colour vertices or four-colour vertices within a bounded distance of every repeated-colour vertex — which is FS114-CV-EXISTS's *not claimed*
("GS-4's density form, which still needs FS-115's (b′) and (b″) for aperiodic maps"). **So FS-115 bears on DISC-F in the Siamese class**, against the
demand list's § 5 ("no bearing on the NO since FS114-CV-EXISTS"): a stub to re-aim (FS-115's bearing line).

derivation: FS129-OR1-LOCALDENSE
  statement: every valid six-coloured fragment on a closed disc B̄(x, 3) has, in B̄(x, 3), a vertex of at least four colours or a vertex with a repeated
    colour
  uses only: FS112-DISC1 (a closed disc of radius 1 holds a vertex of degree at least 3), read on a fragment: its argument nests tiles surrounding x, each
    of diameter at most 1 and so inside B̄(x, 1); FS112-N3-BASE, read on a fragment: if B̄(u, 2) about a cubic trichromatic vertex u holds no vertex of at
    least four colours and none with a repeated colour, the base derives a contradiction from the colours of points of B̄(u, 2) alone, after N2-TOWARD
    bends of inert unit arcs centred in B̄(u, 1) (NB3's walk: "every point whose colours it reads lies in B̄(u, 2)"; "C-LOCAL: radius 2 about u")
  not claimed: that the class is inhabited (no fragment on a disc of radius 3 is held); that the vertex found has at least four colours (it may have
    a repeated colour instead); anything below radius 3; that FS112-N3-BASE's own
    inputs (row 134's base, BASE-V's residue: CUSP-BASE's D5 items 1–4, 6 at one mind) are stronger than their grade
  argument: § Argument for FS129-OR1-LOCALDENSE
  verdict: derived
  grade: derived from: FS112-DISC1, FS112-N3-BASE
  minds: 1
  model: none held — no valid six-coloured fragment on a disc of radius 3 is known (the largest held is FS112-CAL-DISK's disk, radius ≈ 2.1246), and
    the class may be empty (DISC-F at radius 3 would empty it), in which case the statement is vacuous; it carries something exactly on the YES side's
    objects — fragments on discs of every radius (FS116-O1-YESLIM) — each of which it constrains
  prior art: owed — in-house; FS112-N3-DENSE3's own prior art is "not found in print"
  handoff: de Bruijn — with FS112-N3-DENSE3's module (FS-114's stub), stated on fragments

#### Argument for FS129-OR1-LOCALDENSE

Let `F` be a valid fragment on `B̄(x, 3)`, a map of an open set `V ⊇ B̄(x, 3)`. *A vertex in `B̄(x, 1)`.* If `B̄(x, 1)` held no vertex of degree at
least 3, the tile `T₀` at `x` (or one with `x` in its closure) would be bounded near `B̄(x, 1)` by edges with no branch point, so one tile `T₁` lies across
its whole boundary and surrounds it; `T₁` has diameter at most 1 (FS116-V5-NE1) and meets every ray from `x` (it surrounds `x`), so for `y ∈ T₁` the ray
from `x` away from `y` meets `T₁` at some `w`, and `|y − x| ≤ |y − w| ≤ 1`: `T₁ ⊆ B̄(x, 1) ⊆ V`. Repeating gives infinitely many nested tiles in
`B̄(x, 1)`, against local finiteness. (This is NB2's DISC1 argument; it reads only `B̄(x, 1)`.) Let `u` be the vertex found. *If `u` has a repeated
colour or at least four colours*, done (`u ∈ B̄(x, 1) ⊆ B̄(x, 3)`). *Else `u` is cubic trichromatic.* Suppose `B̄(u, 2) ⊆ B̄(x, 3)` held no vertex of at
least four colours and none with a repeated colour (NB3's hypothesis H). FS112-N3-BASE's argument, as NB3 walks it step by step, reads the colours of
points of `B̄(u, 2)` only, and its pre-processing bends inert unit arcs centred in `B̄(u, 1)` toward their centres by N2-TOWARD, whose validity on a
fragment is FS129-OR1-BENDFRAG's "read on a fragment" (fewer tiles, fewer contacts) and which keeps H and `u`'s type (NB3 step 4); all of it lies in `V`.
So the base's contradiction is reached inside `F`: H fails, and `B̄(x, 3)` holds the vertex.

derivation: FS129-OR1-DISCF-NS
  statement: if for some R > 0 no non-Siamese simple valid six-coloured fragment exists on a closed disc of radius R about a vertex of at least four
    colours, then no non-Siamese simple valid six-coloured fragment exists on any closed disc of radius R + 3
  uses only: FS129-OR1-LOCALDENSE; that a non-Siamese simple fragment has no vertex with a repeated colour (two tiles of one colour at a vertex are near,
    FS116-V4-DICHOTOMY; one tile twice at a vertex has a closure that meets itself); that a fragment on a disc is a fragment on every smaller disc inside it
  not claimed: the Siamese or non-simple form (there LOCAL-DENSE's repeated-colour alternative is not covered by C114-LOCAL-F); the hypothesis itself
    (C114-LOCAL-F in the non-Siamese simple class, open — FS-124)
  argument: § Argument for FS129-OR1-DISCF-NS
  verdict: derived
  grade: derived from: FS129-OR1-LOCALDENSE, FS116-V4-DICHOTOMY
  minds: 1
  model: the hypothesis is open, so the model is its class: FS114-Y2-BOWTIE, a non-Siamese valid fragment about a four-colour vertex on B̄(p, 3√3/5),
    inhabits the class the hypothesis quantifies over at radius below 3√3/5
  prior art: owed — in-house
  handoff: de Bruijn — with FS129-OR1-LOCALDENSE

#### Argument for FS129-OR1-DISCF-NS

Let `F` be a non-Siamese simple valid fragment on `B̄(x, R + 3)`. It is a fragment on `B̄(x, 3)`, so FS129-OR1-LOCALDENSE gives a vertex `v ∈ B̄(x, 3)`
of at least four colours or with a repeated colour; the class has no repeated colours, so `v` has at least four. `B̄(v, R) ⊆ B̄(x, R + 3)`, so `F` is a
non-Siamese simple valid fragment on `B̄(v, R)` about a vertex of at least four colours — excluded by the hypothesis.

### J20 — FS-128: C121-NOPAR-C5
**The step**: (`plans/STUB-top-colour.md` ll. 12–14): "route, the map such a colouring would be is in the class `𝒫_6` (FS121-C1-GMAP, held), and **C121-NOPAR** says `𝒫_6` is empty; its part under Condition 5 (every boundary meets every unit circle in finitely many points) is **C121-NOPAR-C5**, where row 134's chain stops at the vertex data and at N4-FIN's strictness, which smooth horns lack (FS121-C1-FLAT, held)."

**Kind of input**: jets of boundaries along unit parallels; § 2's FS121-C1-FLAT excludes germs at the chain's points alone. Admissible.
**Read for it**: FS110-CLOSURE, -N4-FIN, -N4-TERM, -W-MERGE, -NB-4, -NB-5; FS121-C1-GMAP, -C1-SAT, -C1-FLAT, -C1-BOUND, -NOPAR-C5 (its GAP line).
**Verdict: null.** FS110-CLOSURE (row 134) answers the segment-and-arc members under Condition 5, which NOPAR-C5's own GAP line already records ("the
transfer of row 134's chain from segment-and-arc edges to edges lying on unit parallels"); the open part is smooth edges, where C1-FLAT stops the chain.

### J21 — FS-104 route (a): the density family at j = 4
**The step**: (`plans/STUB-cp-plane-six.md` ll. 62–65): "- **(a) The density family.** A CP five-colouring needs `m_j(ℝ²) ≥ j/5` for every `j ≤ 4` (X21D-Y). R1's reading, **unchecked**: disjoint translates of Croft's set into its lattice's deep holes give `m₂ > 2/5` and `m₃ > 3/5`, so `j = 2, 3` die as `j = 1` did; `j = 4` unknown (`m₄(ℝ²) < 4/5`?). [reading, R1; the advisor: "a check on Croft's parameters, not a derivation"]. The route to six, if any, is integrality (G24; X21D's B-3 answer: "a non-density (integrality) argument")."

**Kind of input**: a density of a union of `j` classes. Admissible, but § 2's row 129 caps single-class arguments.
**Read for it**: FS105-W-D1, -W-D2; FS106-EPS2, -COMP. **Verdict: null** (lane R; lane A holds row 129).

### J22 — A root: row 134's base, Lemma 4 at cusps
**The step**: (Poros's words, from the owed-minds lines of every route-M stub, e.g. `plans/STUB-qfree-ring.md` l. 101: "row 134's base, Lemma 4 at
  cusps (BASE-V), before any publication"): derive S–V's Lemma 4 at cusp vertices in the curved, almost-everywhere setting, or locate its failure.

**Kind of input**: a second mind on CUSP-BASE's D5 items at cusp vertices — a verification, not a composition. Admissible.
**Read for it**: FS110-CUSP-BASE, -CE1–CE7, -COR1-NOD2; FS112-N3-BASE, -N3-ANTI, -N3-FAIL; FS114-BV-HEX (BV-L3); `plans/BASE-V-verification.md` §§ 1b.5,
2.5.
**Verdict: null.** BASE-V § 2.5 names the residue that stays at one mind: "CUSP-BASE's D5 items 1–4, 6 (CE)" — Prop. 19(b) at cusps and Lemma 4's final
selection (BASE-V § 1b.5's blind GAP). No held lane-R result is a second route to them; FS110-CE4 and -CE6 are the repairs whose second mind is owed.

### J23 — A root: Townsend's simplification (c), in full
**The step**: (Poros's words, from `plans/STUB-regular-half-residuals.md` l. 7, "what is left is Townsend's (c) in full"): fill Townsend's (c) by a
  derivation, beyond FS106-TW's outline from Woodall's steps 2, 3, 5.

**Kind of input**: a modification that merges two non-adjacent same-colour regions at a vertex — (c) as `[Soifer2024]` ch. 25 reprints it
(`plans/FS110-PA-prior-art.md` stage 4) — or a five-colour map NO that needs no (c). Admissible.

**Read for it**: FS106-TW, -WO, -AE-MAP6; FS110-W-MERGE, -N3-DEG, -N4-SHAVE, -N4-STUCK, -N4-FIN, -N4-TERM, -NB4-CS; FS112-N2-RED, -N2-TERM, -N2-RAY;
FS114-N2-AVG, -N2-FIVE, -CV-EXISTS; `plans/STUB-regular-half-residuals.md` banners.

**Verdict: shortened, by two held results applied where they bear** (no new entry; both statements are held verbatim):
- **Under Condition 5, (c)'s outcome is held**: FS110-W-MERGE is Woodall's step 3 almost everywhere for curved arcs, and FS110-N4-TERM gives a terminal
  valid modification in which "no colour has two sectors at any vertex: every vertex is cubic" — the a.e. curved form of Woodall's steps 3 and 5, which
  V3 named as (c)'s fill. So for Condition-5 maps bounded by segments and circular arcs, AE-MAP6's "modulo (c)" is discharged by FS110-N4-TERM (row 134),
  leaving the rest of Townsend's Thm 5 at FS106-TW's grade. (Unchecked here: that N4's operations spend no sixth colour — NB2 records "six is spent nowhere"
  for FS-112's reduction, not for FS-110's N4.)
- **With unit arcs, in the simple non-Siamese class, no (c) is needed at all**: FS114-N2-AVG's N2-FIVE-PLANE, "no simple non-Siamese valid five-colour map
  of the plane exists" (one mind, by counting) — "maps need six" in that class, by Euler, with no merge.
- What remains of (c) in full: maps with unit arcs that are Siamese or non-simple (there FS112-N2-TERM's terminal map keeps stuck vertices, and N2-RAY's
  one-sided chain is the obstruction — FS-115 again), and map-type maps whose boundaries are not segments and arcs.

### J24 — FS-117: K2′, GAP-μ and COVER-3 (the non-Siamese NO only)
**The step**: (`plans/STUB-route-t-count.md` ll. 41–46): "- **K2′** — strictness: a unit unused in every disc of radius `R₀` (N3-DR1's and N3-DR2's forced non-tactic edges are the first candidate sources). - **GAP-μ** — repeated contacts: a pocket between two tiles meeting twice meets at most 65 tiles (Jung's `2/√3`, non-Siamese), a hole at most five; no payment rule. **And its hull form** (NB6-MTP): the mass-transport route (Kooshi's lead, `[AldousLyons2007]` Ex. 9.5, `[AngelHutchcroftNachmiasRay2018]` Thm 1) needs GAP-μ in the hull, because limits of simple hole-free maps can pinch or open holes — a pointer for FS-111's limit objects. - **COVER-3** (FS114-N2-ENC3): every colour meets `B̄(u, 1)` at every cubic vertex of a non-Siamese valid map — the local content of Sirgedas's"

**Kind of input**: a count (route T) — a unit unused per disc, a payment rule for repeated contacts, a covering of `B̄(u, 1)`. § 2's G86: a count is blind
to Siamese pairs, so the non-Siamese NO at best. Admissible within that.
**Read for it**: FS114-N2-ENDS, -N2-AVG, -N3-JOINT, -N3-DR, -N2-ENC3, -N2-LEMMAS, -ROUTE-T, -K1; FS129-OR1-QFREE.
**Verdict: null for the three named items.** Side note: route T's K1′ on (Q)-free rings has no instance (FS129-OR1-QFREE), so K1′ is owed only on (Q) rings.

### The mechanical half (`data/fs129/index/open-steps.md` §§ 2–4): how far I got

- **§ 2** (12 "stalls at" lines): read in full. Every lane-R line is a step on the list (FS114-GSD, -N7-3T's per-pattern kills, FS116-Y-SAT,
  -N1-F15TOUCH, FS107-HX-STALL, FS112's stuck-ray YES; row 133) or lane A's (FS38).
- **§ 3** (372 GAP lines): counted by file; read line by line for FS106, FS106-TS, FS106-TQ, FS107 and FS110 (about 66 lines), the oldest lane-R files and
  the least likely to be on the list. Two FS-110 GAPs are **leads for pass 2**: FS110-A3-HOLE ("A2-V56 and the four-colour Act One step hold when the
  vertex's unit circle carries no arc of `Γ` and are a GAP when it does") and FS110-N2-SWAP ("TRUE under Condition 5, GAP without") fail exactly where the
  unit circle carries an arc of `Γ` — what FS129-OR1-BEND3 and FS129-OR1-BENDFRAG remove on a whole-tile fragment below `√3` in the non-Siamese simple
  class. Whether their reading radius fits below `√3` is not checked. The rest of the lines read are steps on the list (AE-Q2's G1–G3, AE-FA, C-Q-STAB,
  TW, WO), superseded (SV1, AE-FA, by row 134) or closed in their own entries.
- **§ 4** (418 lowercase "gap" lines): counted by file, not read line by line; lane A finds at least 158 of them in the fan-gap sense (a property of a
  colouring, row 66), not open steps (`plans/FS129-OA1-audit.md` § 4.1 item 3). Lane R's share by file: FS111 23, FS121 15, FS116 14, FS106-TQ 7.

### The cross-era line (results of lane A's era seen bearing on a step; noted for lane A, not derived)

- **G71** (three colours have a height; Chandgotia) on J2 and J17: its lane-R image is FS-110's winding (FS110-N2-RING, -Y3-GP), and lane A's
  FS129-OA1-RINGWIND re-derives the same mechanism — a merge for pass 3 (stage 3, J2 addendum).
- **Row 66 / G13** (a gap frees every pair above it; fans) on J4: the finite face of an unsaturated class growing; not composed here.
- **G73** (`KG(4, 2)`, the `V₄` of `K₄`'s matchings) on J17 case 5: the recurrence's label algebra; lane A's.
- Nothing of lane A's era was seen bearing on J1, J3, J7, J10, J15, J19 or J23.

### Registered expectations, scored (stage 1's table, registered before the demand list was read)

| quantity | registered | outcome |
|---|---|---|
| steps closed outright | 0 (P(≥ 1) = 0.15) | **1½** — J1 closed (FS-123 question 1, yes), J19's LOCAL-DENSE half closed; J18 made moot. Missed low |
| steps shortened or reduced | 4 (2–7) | **7** — J2, J3, J7, J10, J15 (to J16), J17 (case 6), J23; J19's DISC-F half reduced besides. At the top of the range |
| nulls | 17 (13–21) | **14** — J4, J5, J6, J8, J9, J11, J12, J13, J14, J16, J20, J21, J22, J24. In range |
| compositions derived | 3 (1–6) | **8**. Above range |
| compositions outside the list | 1 (0–3) | **0 derived**; 2 leads recorded (FS110-A3-HOLE, FS110-N2-SWAP), and FS112-STOP as route R's and route M's meeting point (J15) |
| new stubs | 1 (0–2) | **0 new**; re-aims of FS-115, FS-122, FS-123, FS-125 proposed for Keryx and Poros |
| J10: a lane-R result bears | 0.35 | **yes** (FS129-OR1-TOP5; carriers corrected) |
| J15: the collision stands | 0.40 | **no** — it dissolves into a statement defect in FS-122's stub |
| this lane moves the bearing on the answer | 0.12 | **yes by the registered definition** (FS-123's step closed, so route M's first half loses its (Q)-free half in the non-Siamese simple class); **no value moved** |
| a held lane-R result found false | 0.04 | **no** (side 1's *recipe* — a round restriction — does not carry its conclusion; the conclusion holds) |

The miss runs one way: I priced closes and compositions low. The step that closed (J1) was the one Poros priced at 0.6; its close came from reading
the definition of a tile (a component of the open set minus `Γ`), which made the restriction's class a question and the lens identity its answer.
