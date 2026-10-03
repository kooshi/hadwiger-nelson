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
