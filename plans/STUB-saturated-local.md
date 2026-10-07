# FS-125 — the saturated local exclusion: is there an explicit radius about a four-colour vertex within which no saturated valid six-coloured fragment exists? (stub)

> **Demoted, 2026-10-07 (FS132-P2, FS124-P1), 4 → 7: on the road again on one condition — C124-KIND true and FS-124's exclusions needing 'of kind both', which saturation supplies (FS116-O1-SATPIN).**

> **Re-ranked 2026-10-03 (FS129-P1; 4 → 5).** FS-128 enters above it carrying the map step at five's top
> colour, FS-104's question in route M's form; NO-SAT's bearing is unchanged, and its (Q)-free part is closed in the non-Siamese class (row 149).

*Minted 2026-10-03 by FS-116's close, part 2 (FS116-Z2; `plans/FS116-Z2-close.md` stage 3), carrying FS-116's phase D0 (`data/fs116/claims.md` § 4:
SAT-STRIP, SAT-QFREE, SATPIN-PER, NO-SAT), its construction target Y-SAT, `plans/FS116-close-inventory.md` items 45, 56, 83, 108 and 115 (FS116-S1-QF's
blind second mind, owed by Kooshi's ruling: *"agree, leave it owed"*), and the saturated row of FS116-C114-LOCAL-F's case list. FS-116's successor; siblings
FS-123 (`plans/STUB-qfree-ring.md`) and FS-124 (`plans/STUB-q-ring.md`); its consumer is route M's honest branch, FS-121's successors (FS-128,
`plans/STUB-top-colour.md`, above all). **Solver column: in-ban** — derivation, reading, exact checks of fragments by formula; no enumeration of maps,
colourings, tile graphs or ring types (FS-116's frozen list § 9). Written for a session with no memory of FS-116: read `CLAUDE.md` § The aim and
§ Counter-priors, `LEDGER.md` rows 140–141 and FS-116's rows (‹R116-a›–‹R116-d› until numbered), `plans/FS116-derivation.md` (FS116-O1-SATPIN, round 2
and round 3's SAT-STRIP section), `plans/FS116-S1-proof.md` § 1.3 (the recognition), and `data/fs116/claims.md` §§ 0, 4, 11–12 (saturated, the essential
boundary, the cross's labels).*

## The question, in plain language

A **valid fragment** colours a disc about a point `p` with six colours by finitely many tiles near each point, bounded by segments and circular arcs (unit
arcs allowed), with no two interior points of one colour at distance exactly 1. It is **saturated** on a disc when every boundary point there lies at
distance exactly 1 from each colour present at it — every boundary is held in place by a partner one unit away. Route M's honest branch hands the
six-map NO exactly such maps (FS111-M2-REDUCE-A derives REG-A_k "in an honest saturated k-colouring"), so a NO for saturated fragments is all route M's
first half needs, with the top colour bound at six (FS-128's TOP₆):

> **NO-SAT** (`data/fs116/claims.md` § 4): "there are an explicit radius `R`, one `R` for every complexity, Siamese pairs allowed, and a derivation that no
> valid fragment on the closed disc of radius `R` about a vertex of at least four colours is saturated on the closed disc of radius `R − 1` about it."

What FS-116 learned of this class (addresses in `plans/FS116-derivation.md`):
- **Saturation pins every edge at a four-colour vertex** (FS116-O1-SATPIN, held, in its corrected wording): each edge is a unit arc about a point of `ω(p)`
  carrying both its side colours (split, a (Q)-type arc) or a segment or arc of radius at least 1 whose partners sit at the two points of `ω(p)` on its
  normal (tangent).
- **The straight right-angled cross dies at `R = 2` when its ring carries no (Q) arc and the fragment is non-Siamese** (FS116-S1-QF) — **two derivations by
  different routes, the second told the verdict by the coordinator's brief; not held**; its blind second mind is owed (items 108, 115). Its inputs are held:
  FS116-S1-KAPPA (on a (Q)-free ring each germ carries exactly one of the two absent colours, the germ 60° on the other) and FS116-S1-RUNG (a saturated
  straight edge's rung tile reaches no farther than 1 from the rung's points, Siamese pairs allowed).
- **The mechanism** (FS116-S1's recognition, `plans/FS116-S1-proof.md` § 1.3): "SAT-STRIP is a collision between a rung and a contact: the east edge's
  tangent partner carries `c_IV` along `y = 1` from `q_N` out to `(L_E, 1)`, while the ring forces a tile of `c_IV` against `ω(p)` from outside somewhere in
  quadrant II; one connected family of `c_IV` tiles cannot be within distance below 1 of that tile at `q_N` and above 1 at `(L_E, 1)`."
- **SAT-STRIP** ("no valid fragment on `B̄(p, 2)` saturated on `B̄(p, 1)` has at `p` a degree-4 vertex of four colours whose four edges are segments") is
  GAP, open in three places: **G1**, rings with (Q) arcs (the strip-like class, where κ's 60° rule breaks); **G2**, Siamese fragments (a Siamese tile inside
  an edge's lens, or a four-sector vertex on its interface); **G3**, crosses not at right angles.
- **SAT-QFREE** is GAP at a **touch point** — a SATPIN point off the arcs of `Γ` on `ω(p)` with one ring colour on both sides (FS116-N1-TOUCH, held), echoed
  at `2w − p` where saturated (FS116-N1-ECHO, held in reading B); without "(Q)-free" it is false (FS116-N1-F15TOUCH, exact).
- **The construction side**: the capped strip, saturated on `B̄(P₀, 1/5)`, is valid on `B̄(P₀, 6/5)` (FS116-Y1-F15, exact), and no fragment agreeing with the
  strip on `B(P₀, 1)` is saturated past `R − 1 ≈ 0.491` (FS116-Y1-STRIPCEIL) — so Y-SAT in the strip family is a dial with a derived ceiling; a positive at
  SAT-STRIP's configuration must carry a (Q) arc on its ring, a Siamese pair inside an edge's lens, or edges not at right angles (FS116-Y-SAT's stall).
- **Not worked:** SATPIN-PER (finitely many radii: every edge a tangent segment or a (Q) arc) and NO-SAT itself.

## Questions, in order

0. **FS116-S1-QF's blind second mind**, on a clean brief (the frozen list's § 12 statement and its definitions only; no verdict, no "rests on").
1. **SAT-STRIP's three open places**, G3 first (crosses not at right angles: does QF's rung-and-contact collision survive a tilt?), then G1 (the strip-like
   class), then G2 (Siamese).
2. **SAT-QFREE's touch point**: exclude it using (Q)-freeness at the ends of the ring arc about `w`, or build it.
3. **SATPIN-PER**, then **NO-SAT**: the edge dichotomy read through every ring type of FS-123 and FS-124, in the saturated class — the (Q) types there are
   split unit arcs, so the saturated class may be the smaller case list.
4. **Y-SAT**: a saturated six-coloured fragment past `R = 2` about a four-colour vertex whose edges' first rungs do not collide inside `B̄(p, 1)` (FS116-Y2's
   recognition), by formula.

## Bearing on the answer

**Route M's first half in the class route M needs, smaller than the answer alone.** NO-SAT, with FS-128's TOP₆ (honest saturation at six) and FS-121's
other successors (FS-126, FS-127), gives `χ_m⁰(ℝ²) = 7`, hence `χ(ℝ²) = 7` given MR; FS121-C1-SAT (held) puts the saturated segment-and-arc NO inside the
cover route's NO-PAR, and FS-128 un-parks the cover route when NO-SAT lands. The all-fragments NO (FS-123, FS-124) is what answers `[SokolovVoronov2025]`
Question 2. A family of saturated fragments on discs of every radius gives `χ(ℝ²) ≤ 6` with no MR, as any family of valid fragments does (FS116-O1-YESLIM,
held). Each SAT-STRIP place alone is a piece.

**At R2's re-rank (2026-10-03).** Given FS-126's NO (cusps allowed), no (R2) arc occurs in an honest saturated REG-J′ colouring (FS121-Z1-NOCURVED, one mind), so NO-SAT's rings would carry (Q) arcs only; FS116-Y4-EMPTY (held) removes the Γ-free type. The saturated case list is then the (Q) rings and the five- and six-colour vertices (`plans/POROS-2026-10-03-close-reread.md` § 2.3 C3).

*At FS-129's audit (FS129-Z2, 2026-10-03; from the readers' records, each FS-129 result derived, one mind, kernel pending, prior art owed unless named).* Case 2 (SAT-QFREE's touch point) and case 1's G3
(crosses not at right angles) concern fragments whose ring carries no (Q) arc, so FS129-OR1-QFREE closes both in the non-Siamese simple class, saturated
or not, at any crossing angles (`plans/FS129-OR1-audit.md` § J3), and FS129-SR3-QFREE-NS without simplicity: **what is left of G3 and SAT-QFREE is their
Siamese part, with G2**; G1 (the strip-like class) and question 3 are untouched. **FS116-S1-QF is a case of QFREE** — **FS129-SR2-QFCASE**: "FS116-S1-QF's statement — no non-Siamese valid fragment on B̄(p, 2), saturated on B̄(p, 1), whose ring ω(p) carries no (Q) arc, has at p a degree-4 vertex of four colours whose four edges are segments at right angles — is a case of FS129-OR1-QFREE", read as
citing FS129-SR3-QFREE-NS (`plans/FS129-SR3-audit.md` § 2.3) — so the saturated cross whose ring carries no (Q) arc is closed in S1-QF's whole class: a
second route to S1-QF, at one mind; question 0, S1-QF's own blind second mind, stays as Kooshi ruled it. FS116-S1-KAPPA's last clause is over a class
empty by QFREE-NS (`plans/FS129-SR3-audit.md` § 4.1). Two questions for the opening, from FS129-MR1 (`plans/FS129-MR1-audit.md` § Stage 4, G84 and G85;
neither derived): **which side's binding each kill reads** — FS116-S1-QF, -SAT-STRIP and -S1-RUNG assume each side colour bound at each edge point, while
FS121-D3-GRUNDY makes every colour but the largest bound for free, so a kill reading only the lower colour's binding would hold for Grundy fragments and,
by FS121-D3-EQ, bypass TOP₆; and **whether FS111-M2-INTRAD's one-step argument makes FS116-O1-SATPIN's tangent edges segments or arcs of integer
radius**, given saturation one unit beyond toward the centre (a reading radius of about `R ≥ 3`).

## Owed second minds (before anything final rests on them)

FS116-S1-QF (blind; question 0); FS116-S1-PAIR, -CLUSTER, -LENS, -EXIT (one mind each); FS116-V4's lemmas (CHORD, DICHOTOMY, MEET, TWIST, PARTNER, OUTER;
one mind each); FS116-Y1-STRIPCEIL, FS116-Y1-NOTCH (one mind each); FS111-M2-REDUCE-A's class and FS111-C-SAT-T-HONEST at six (FS-121's and FS-128's).

## Prior-art debts

FS116-V4-DICHOTOMY, -MEET, -TWIST, -PARTNER, -OUTER: no search run (item 113). The saturated class in print: FS-111's gate found none for maps
("chromatic & plane & (measurable | map) & (tight | saturat* | maximal)", 7 hits); search the fall-colouring and idomatic vocabularies (FS-121's
recognition) and morphology (the ladder of unit parallels).

## Registered expectations (provisional; instruments, never caps)

QF held by a blind second mind: 0.75. SAT-STRIP's G3 decided: 0.4. A saturated six-coloured fragment past `R = 2` by formula: 0.15. NO-SAT within the
milestone: 0.15.

## Failure clauses

A saturated-class NO says it serves route M only with TOP₆ (honest saturation at six) and the rest of route M (FS116-O1-SATPIN's and NO-SAT's not-claimed
lines); a NO for the non-Siamese class says so in its headline; every exclusion states its reading radius and the controls it fails on (SQ9 at nine colours,
saturated, with such vertices; R7 at its non-cusp points; the strip off its midline; FS116-Y1-F15 to `6/5`); no argument one colour class at a time
(row 129); a candidate that fails its exact check measures the candidate.

## Deliverables

The plan (the reframe first); a derivation file; any object by formula with an exact check whose plant fires; the close's drafts.

## Provisional bearings

G84 (contact; SAT-STRIP's rung-and-contact collision is its instance at a vertex), G85, G89 (drafted at FS-121's close: honesty is free, the six-colour
content is the top colour), G21 (the strip's dial is unsaturated), G86, G79; rows 140–141 and FS-116's; stubs FS-128, FS-126, FS-127, FS-120 (a rung is the
first step of a pinch's ladder), FS-123, FS-124.

*At FS-129's audit (FS129-Z2, 2026-10-03):* FS129-OR1-QFREE,
FS129-SR3-QFREE-NS, FS129-SR2-QFCASE, -TOUCHW (FS116-N1-TOUCH without its idle hypothesis); G84 with G89 (the binding question), G85 (INTRAD at a vertex).

*Since FS-132 (FS132-Z2, 2026-10-07):* the exclusions FS-132 derived for weak measurable colourings — the outside-labelled
four-cycle (C132-M-EXCL), the complementary pair (C132-COMP-SHARP), the alternating ring in step form (C132-ALT); each [hand],
one mind, kernel pending — read no arc and no normal form, and each stops at one object, a boundary that is a unit arc about a
ring point (`plans/FS132-derivation.md` § 12). So NO-SAT is on the measurable road only if a normal form is chosen for the *existence* step, and
nothing yet says that it is saturation: the asking lane's line for this stub reads "Demoted … on the road again only on the
condition its row names" (`plans/POROS-2026-10-07-fs132-night.md` § Banners; drafted, not filed). One statement of FS-132's is
a normal-form statement and bears here — **three labels on a strip**: on the unit circle about a point with a witnessed
triangle, do the three outside labels change finitely often (C132-RING-TAME's first clause, a stall; "its first clause is
false wherever local slack exists along the strip, so it is a statement for a normal form or false at six",
`plans/FS132-close-inventory.md` item 7)? Declined as a stub by the asking lane on the night; placed here and at FS-128
(`plans/STUB-top-colour.md`). G95, G84.
