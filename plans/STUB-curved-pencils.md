# FS-126 — curved pencils: can an honest saturated colouring of the plane, with any number of colours, have a curved tangent-type interface? (stub)

*Minted 2026-10-03 by FS-121's close (FS121-Z1; `plans/FS121-Z1-close.md` § 2.5, stage 5), carrying inventory items 24, 49 and 74 and the plan's
not-claimed lines (close record § 4.4). Route M's honest branch; siblings FS-127 (the singular set) and FS-128 (the six-colour rungs); FS-115 is
re-posed beside it. **Solver column: in-ban** — derivation, and constructions by formula with exact checks. Read first: `CLAUDE.md` § The aim and
§ Counter-priors; `plans/FS121-derivation.md` in full; `data/fs121/claims.md` § 0 (D-NF, saturated, honest, Σ, REG-J′, LRA, (Q), (R2)).*

## The question, in plain language

Colour the plane with `k` colours, measurably, so that almost no pair of points at distance 1 shares a colour, every point carries one colour
(*honest*), every boundary point lies at distance exactly 1 from each colour present there (*saturated*), and the singular set is locally finite with
finitely many boundary arcs at each of its points (*REG-J′*). Then every two-colour boundary piece is a segment or a circular arc of integer radius,
and it is of one of two types: a unit arc whose centre carries both colours (*split*), or a curve pinned between two tangent unit discs (*tangent*).
**Does any such colouring, at any `k`, have a tangent-type boundary arc of finite radius?** No held colouring does: R7 has only split unit arcs; SQ9
and HEX9 only segments.

## What FS-121 established (addresses in `plans/FS121-derivation.md`)

- A tangent arc of radius `n` forces concentric tangent arcs of radii `n + 1, n + 2, …` over one window (FS121-O1-OUT, held); toward its centre the
  ladder ends at a (Q) arc or an (R2) arc about a point of Σ of at least three distinct colours (FS121-O1-ENDS, held; FS121-DB1-L5, one mind).
- **The frame (FS121-Z1-NOCURVED, one mind):** a NO here (cusps allowed) makes C121-R2-FOUR vacuous, gives C121-NOLRA, and leaves every curved
  interface a split (Q) arc. An (R2) arc is itself a tangent unit arc, so its outward parallel is one of radius 2.
- **Symmetric colourings have none** (FS121-V5-SYM-CPT, one mind; FS121-D2-PERFIN with C121-PER, a second route; both over M2-INTRAD's per-radius
  finiteness, one mind). So an inhabitant is aperiodic.
- What an inhabitant must carry, cusp-free: a pencil of window `ℓ` with `4 sin(ℓ/2) ≤ 1` (FS121-D1-PENCILWIN); non-concentric band interfaces, which a
  second, offset pencil supplies radially (FS121-D1-DOUBLE, by formula); a transverse subdivision of every sub-band into tiles of diameter at most 1
  whose cuts are transported rung to rung (FS121-D1-VT, held) — **the open step**; LRA, if present, as thin pencils (FS121-D2-THIN).

## The question for Poros's card

*Existence form:* a curved tangent-type interface in an honest saturated REG-J′ colouring at some `k ≥ 7`, by formula. *Structural form, a
suggestion:* what does every aperiodic honest saturated colouring carry that a cocompact symmetry supplies — a lower bound on the windows of its
radius-`r` arcs for one `r ≥ 2` (FS121-D2-SYM, held, then excludes LRA)? D1's suggestion stands: a fresh mind on the transverse subdivision, given
FS121-D1-proof.md §§ 3.2–3.3 and none of D1's attempts.

## Bearing on the answer

**None alone; a colour-generic rung of route M's honest branch, smaller than the answer.** A NO decides three of FS-121's six open claims at every `k`
(C121-R2-FOUR, C121-NOLRA, and C121-CURVED's negation). With FS-127 (REG-J′), FS-128 (TOP₆) and FS-116's NO it is part of seven given MR; on its own
it moves no value. A YES by formula at `k ≥ 7` refutes nothing at six (W-NEG), but it inhabits classes that every lemma of FS121-D1 is about, kills
the reading that honest classes are segments and (Q) arcs, and returns C121-NOLRA and C121-R2-FOUR to separate questions.

## Owed second minds (before anything final rests on them)

FS121-Z1-NOCURVED; FS121-D2-INCURVED, -EXT, -THIN, -PERFIN; FS121-V5-RAY, -SYM-UP, -SYM-CPT, -LOC; FS121-D1-PENCILWIN, -DOUBLE; FS111-M2-INTRAD's
per-radius finiteness (VM2-FIN′), which SYM's symmetric clause and SYM-CPT rest on.

## Registered expectations (provisional; instruments, never caps)

- The open step decided either way within the milestone: 0.3. A curved inhabitant by formula, if decided: 0.4.

## Failure clauses

- A rung stated at six only, or without its held inhabitants (R7, SQ9, HEX9) or "none held", is misfiled.
- Every quotation of REG-J′ carries "each point of Σ meeting finitely many interface arcs", read as a fan (V3 § 3.5).
- A NO with cusps excluded does not give C121-NOLRA (FS121-D2-INCURVED allows cusps): say which class.

## Deliverables

A derivation file in the Ephodos grammar; any object by formula with an exact check whose planted fault fires; a visualizer of a pencil and its
offset partner if one is built.

## Provisional bearings

G84, G85 (contact, integer radii; G85's "what escapes" refined by FS-121), the drafted G88; G21 (no held inhabitant); G62 (two interleaved pencils are
a bilayer); G79. Rows 140–141 and FS-121's. Stubs: FS-115 (re-posed as thin pencils), FS-116, FS-127, FS-128.
