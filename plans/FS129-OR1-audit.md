# FS129-OR1 — pass 1 of the cross-application audit, lane R (the regularity-wall era): the record

*Ephodos, the deriver (read as files, by Kooshi's decision 2), as a `general-purpose` agent on Opus. Brief:
`data/fs129/briefs/FS129-OR1-pass1.md`. Plan: `plans/FS129-cross-application-audit.md` (Stage 2). Lane R owns the held results of
FS-104 on, FS-105 included; it reads the whole demand list against them. Started 2026-10-03 23:11 UTC.*

## Theorems this phase proved

*(Filled at each stage; see the last stage for the current list.)*

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
