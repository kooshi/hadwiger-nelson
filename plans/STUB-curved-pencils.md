# FS-126 — curved pencils: can an honest saturated colouring of the plane, with any number of colours, have a curved tangent-type interface? (stub)

> **Demoted, 2026-10-07 (FS132-P2): the exclusions derived for measurable colourings read no arc and no normal form; on the road again only on the condition its row names.**

> Demoted 2026-10-07 (FS132-P1): `[OAIMath2026]`'s extraction reads no arcs, so this question is on the road to seven only if FS-132's card 1 finds a step of the exclusions that reads one.

> **Re-ranked 2026-10-03 (FS129-P1; 7 → 9).** The map step at five reads REG-J′₅ and no ¬LRA
> (FS129-OR1-TOP5), so FS-120 and FS-127, which carry rungs at five, move above it; it stays the honest route's rung at six.

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

**At FS-116's close (2026-10-03, FS116-Z2).** The same split-or-tangent dichotomy, read at a vertex of a saturated fragment: every edge at a four-colour vertex is a unit
arc about a ring point carrying both side colours, or a tangent segment or arc of radius at least 1 (FS116-O1-SATPIN, held). A NO here would leave, in an
honest saturated REG-J′ colouring, only segments as tangent edges at such a vertex — the cross of FS116-S1-QF's class (FS-125).

**At R2's re-rank (2026-10-03).** The class has no held inhabitant, and FS-116 worked an empty class for two rounds (`plans/FS116-Z2-close.md` D3, the G21 instance): ask first for an inhabitant by formula at some `k ≥ 7`, or an obstruction, with FS121-D1's lemmas as the constraints it must meet. A NO here also removes the (R2) arcs FS-123's question 2 is about, in the class route M consumes (FS121-Z1-NOCURVED: "no (R2) arc occurs"; `plans/POROS-2026-10-03-close-reread.md` §§ 2.3 C3, 2.5 card 3).

*At FS-129's audit (FS129-Z2, 2026-10-03; from the readers' records, each FS-129 result derived, one mind, kernel pending, prior art owed unless named).* FS-112's stuck ray and this stub's tangent pencil are
one picture in two settings, not one statement (`plans/FS129-SR1-audit.md` § Stage 3, group 5); the valid-map side, an analogue of FS121-O1-OUT for valid
maps, is carried in FS-115's bearing. FS111-M2-INTRAD's one-step argument, read at a vertex of a saturated fragment, would put FS-125's tangent edges in
this stub's class (arcs of integer radius at least 2) given saturation one unit beyond (`plans/FS129-MR1-audit.md` § G85; not derived).

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

Since FS131-E8: REG-J′'s fan reading is derived from its first clause (FS131-E8-BRIDGE; [hand], one mind, kernel pending), so this stub's class is the
honest saturated colourings with locally finite Σ; the failure clause on quoting REG-J′ stays as a quotation rule.

## Carried card (Poros, R2, 2026-10-03; verbatim from `plans/POROS-2026-10-03-close-reread.md` § 2.5)

question: is-the-curved-tangent-class-inhabited
  evidence: `plans/STUB-curved-pencils.md` § The question: "No held colouring does: R7 has only split unit arcs; SQ9 and HEX9 only segments"; FS121-Z1
    § 2.6 item 4 names "a curved tangent-type interface in an honest saturated colouring at some `k ≥ 7`, given by formula" as the fact that would change
    its confidence; three open claims (C121-R2-FOUR, -CURVED, -NOLRA) and FS121-D1's lemmas sit on this class; FS-116 worked an empty class for two
    rounds (Z2 D3, G21 instance)
  expected: that FS-126 opens on its open step (the transverse subdivision), as its stub's structural form and D1's suggestion order it
  ask: At some `k ≥ 7`, is there an honest saturated REG-J′ colouring of the plane with a curved tangent-type interface, given by formula — or an obstruction at every `k`?
  if one is built: the honest route cannot take its map step colour-blind; C121-NOLRA and C121-R2-FOUR become separate questions; route M's honest branch is six-specific at REG-A₆ and FS-128 carries it; FS-126's lemmas describe a real class
  if an obstruction: FS-126's NO at every `k`, cusps allowed, gives by FS121-Z1-NOCURVED no (R2) arc in route M's maps and ¬LRA; the honest branch's open rungs are REG-J′ (FS-127) and TOP₆ (FS-128), and C3's joint deletes (R2) arcs from FS-125's case list
  answered by: derivation — Ephodos, FS-126's opening, construction side first, with FS121-D1's lemmas (PENCILWIN, DOUBLE, VT) as the constraints an inhabitant must meet
  cost: one round
  hunch: an inhabitant exists at large `k` (`curved-tangent-inhabited-above-six`, 0.4)
  falsifier: a derivation that at every `k` honest saturated REG-J′ colourings have only segments and split unit arcs
  rank: 3
