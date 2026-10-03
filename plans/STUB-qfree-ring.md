# FS-123 — the (Q)-free ring: does any four-colour vertex whose ring carries no (Q) arc survive past radius 1 + ε, in any class? (stub)

*Minted 2026-10-03 by FS-116's close, part 2 (FS116-Z2; `plans/FS116-Z2-close.md` stage 3), carrying `plans/FS116-close-inventory.md` items 126 and 136
(the invention signal on the bends), the (Q)-free half of FS116-C114-LOCAL-F's case list (`plans/FS116-Z1-close.md` § 2.6), FS114-N7-3T's class with its
open-cap family OC, and the Siamese and non-simple forms of FS116-Y4-EMPTY. FS-116's successor; siblings FS-124 (`plans/STUB-q-ring.md`, the (Q) rings
and the five- and six-colour vertices) and FS-125 (`plans/STUB-saturated-local.md`, the saturated class); FS-117 (`plans/STUB-route-t-count.md`) shares
K1 with it. **Solver column: in-ban** — derivation, reading, and exact checks of fragments given by formula; no program enumerates maps, colourings, tile
graphs, ring types or tip assignments (FS-116's frozen list § 9; Kooshi: *"search for a finite graph is out. It would be huge, not feasible."*). Written
for a session with no memory of FS-116: read `CLAUDE.md` § The aim and § Counter-priors, `LEDGER.md` rows 133–138 and FS-116's rows (‹R116-a›–‹R116-d›
until numbered), `plans/FS116-derivation.md` (round 1's ring lemmas, round 4 and FS-116-V6's lemmas), `data/fs116/claims.md` §§ 0, 10, 13–15 (the
definitions: valid fragment, Siamese, simple, Γ, tile, ring, change point, hub, tip, (Q), (R2)), and `plans/FS114-derivation.md` § 3 with FS-116's erratum
under FS114-N7-3T.*

## The question, in plain language

Colour a disc about a point `p` with six colours by a **valid fragment**: finitely many tiles near each point, bounded by segments and circular arcs (arcs
of radius exactly 1 allowed), no two interior points of one colour at distance exactly 1. Let `p` be a vertex where at least four colours meet, and look at
its **ring** `ω(p)`, the unit circle about `p`. Every valid map of the plane has such a vertex (FS114-CV-EXISTS, two minds), so excluding every fragment
about one, within one radius, is the whole six-map NO with unit arcs (C114-LOCAL-F, FS-116's question). FS-116 sorted the vertices by what their ring
carries, and removed one sort:

> **FS116-Y4-EMPTY (held: two minds, the second blind, the same model).** "no non-Siamese simple valid six-coloured fragment on a closed disc of radius above
> 1 about a vertex p of at least four colours has a ring carrying no arc of Γ"

So a ring with no boundary arc on it at all dies at `1 + ε`. This stub asks for the rest of the rings that carry **no (Q) arc** — a (Q) arc being a ring
arc whose centre `p` carries both its side colours. Such a ring may still carry other arcs of `Γ` (after FS-112's bends, the (R2) arcs). Three questions,
the first cheap and possibly decisive:

1. **The bends, on a fragment** (the invention signal, below). Does bending a fragment on a neighbourhood of `B̄(p, 1 + ε)` keep it in FS116-Y4-EMPTY's
   class and leave its ring free of every arc but the (Q) arcs? If yes, EMPTY excludes at `1 + ε` every four-colour vertex of the non-Siamese simple class
   whose ring carries no (Q) arc, and FS114-N7-3T's, FS114-N7-HUB's and FS114-N6-RING60's classes are empty there.
2. **The (R2)-arc ring, directly.** Inventory item 126: "The successor question: does FLANK's mechanism close the (Q)-free rings that carry (R2) arcs
   after the bends (FS114-N6-RING60's class, where N7-HUB and N7-3T live), a semi-hub whose tip is shared with the next change point, and OC?" There a change point may end an (R2) arc,
   RING-GERM's tip is not given, and the double tip's existence is not shown (`plans/FS116-Y4-construction.md` § 3.3).
3. **The Siamese and non-simple forms of EMPTY.** C114-LOCAL-F allows Siamese pairs (tiles of one colour inside each other's exclusion annulus). FS116-V6's
   route used non-Siamese "only for the uniqueness of `R⁻`, `R⁺` and of the tip" and simplicity only at its last step; FS116-Y4-FLANK is colour-free with Siamese
   pairs allowed; FS116-N1-GERM-S is RING-GERM without non-Siamese. Does the Γ-free type die at `1 + ε` with Siamese pairs allowed, or with non-simple tiles?

## The invention signal on the bends (inventory item 136; G87) — both sides, verbatim, no side picked

*From `plans/FS116-Z2-close.md` § 1.5, where the addresses are checked.*

**Side 1 — on a fragment, the bends leave only (Q) ring arcs.**
- `plans/FS114-NB6-verification.md` § 1b.0: "**Bends on a fragment:** run on a fragment on a neighbourhood of `B̄(p, 1 + ε)`, N2-AWAY sees no radius-2
  witness, so every ring arc but the (Q) arcs is removed (NB5 §1b.3's radius note); "after the bends" then costs no radius, and the ring of a fragment bent
  so is `Γ`-arc-free off its (Q) arcs."
- `plans/FS114-NB5-verification.md` § 1b.3: "**Radius note:** the bends can be run on a fragment on (a small neighbourhood of) `B̄(p, √3)` itself — restrict
  first; no (R2) witness is then visible, so only (Q) arcs are kept, and OUT4 kills those too."
- `plans/FS114-N7-proof.md` ll. 88–89: "the map is bent on a fragment of radius `1 + ε` about `p` (NB6 §1b.0: then every ring `Γ`-arc but the (Q) arcs is
  removed, and the tactic edges, inner tiles and partners are kept, N5-BENDG)."

**Side 2 — after the bends, a (Q)-free ring may carry (R2) arcs.**
- `plans/FS112-derivation.md` l. 90, FS112-N2-RED: "Every valid map has a valid modification by W-MERGE and whole-arc bends, creating no unit arc, in which
  every unit arc is (Q) or (R2)".
- `plans/FS114-derivation.md`, FS114-N5-GRING's *uses only*: "N5-BEND and N5-BENDG (FS-112's bends leave only (Q) and (R2) ring arcs at a degree-4 vertex,
  over FS112-N2-TOWARD, -AWAY, -TAN)".
- `plans/FS116-Y4-construction.md` § 3.3: "The (Q)-free rings that carry (R2) arcs after the bends (FS114-N6-RING60's class, where N7-HUB and N7-3T live)
  are not reached: there a change point of `κ` may end an (R2) arc, RING-GERM's tip is not given, and the double tip's existence is not shown."
- FS116-Y4-EMPTY's *not claimed* line: "anything for rings carrying an arc of Γ that is not a (Q) arc (the (Q)-free rings of FS114-N6-RING60 after the
  bends, with (R2) arcs)".

**What decides it** (FS116-Z2's statement of the question, not a settlement): whether a valid fragment of C114-LOCAL-F's class about `p`, bent on a
neighbourhood of `B̄(p, 1 + ε)` as side 1 says, is again a fragment of EMPTY's class — valid, non-Siamese, simple, six-coloured, `p` a vertex of at least four
colours on a disc of radius above 1 — whose ring carries no arc of `Γ`. Side 1's sentences are verifiers' remarks inside FS-114's records, not entries;
side 2's are about bends on a map (FS112-N2-RED) or assume them. *Reading (FS116-Z2, one mind), to be tested first:* the two sides are about different
objects, a map and a fragment, and the question is only whether FS-112's moves preserve the fragment's class. The opening runs `ephodos-invention` only if
recognition's homes die on one line — that is, if the premise both sides share (that a bend is a modification within the class the exclusion
quantifies over) is the one that fails.

## What FS-116 established that this stands on (addresses in `plans/FS116-derivation.md`)

- **The ring off `Γ` alternates the two absent colours** under the 60° rotation (FS116-RING-TWIST-C, held); **on a (Q)-free ring with Siamese pairs allowed,
  every germ lies in the closure of tiles of exactly one of the two absent colours** and κ's change points are `y + 60°ℤ` in a non-Siamese fragment
  (FS116-S1-KAPPA, held in its ruled reading) — this is the tool for rings carrying non-(Q) arcs of `Γ`.
- **A change point whose `±60°` germs lie off (Q) arcs is a vertex of at least four colours**, with a tip toward `p` and an outer tile (FS116-RING-GERM, held;
  FS116-N1-GERM-S, held, without non-Siamese).
- **The Γ-free type dies at `1 + ε`** by two routes: FS116-Y4's (six hubs, one tip each, a tile tipping two adjacent hubs alone, FLANK's straddle of its two
  flank tiles) and FS116-V6's (six hubs by a tip count; V6-HUG, the exact identity `|a(s) − b(t)|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2)`; an incidence
  count forcing two antipodal doubly tipped hubs; V6-ANTI). Six colours are spent where the ring has exactly two absent colours and where the tip sector holds
  only `p`'s colours.
- **FS114-N7-3T** excludes at `1 + ε` three or more tactic edges on a (Q)-free ring but OC — one mind (FS116-V1's blind check stalled at the per-pattern
  kills); **FS114-N7-HUB** (split from it by FS116-Z2's erratum) is two minds only where the ring carries no arc of `Γ` (FS116-V1's reading), one mind on
  rings with (R2) arcs.

## Bearing on the answer

**A rung of route M's first half, smaller than the answer; possibly cheap.** If question 1 lands yes, C114-LOCAL-F's (Q)-free half is closed at `1 + ε` in
the non-Siamese simple class: what is left of the NO is the (Q) rings and the five- and six-colour vertices (FS-124) and the Siamese and non-simple classes
(question 3 here, and FS-124's last rung) — G83's reading ("what is left is four-colour vertices whose rings carry (Q) arcs") confirmed; K1 on (Q)-free
rings, and so route T's deficient configurations there (FS-117), have no instance. If question 1 lands no, question 2 is the (Q)-free half's main case.
Question 3 is the first step of the whole NO's Siamese half (G86: a Siamese kill reads points and distances, never tile counts). A valid fragment by formula
about a four-colour vertex with a (Q)-free ring carrying (R2) arcs, past `1 + ε`, would be the first object of its kind and a construction target in
its own right. Nothing here moves a value alone.

**At R2's re-rank (2026-10-03).** Question 1's reach is every ring, not only (Q)-free ones: side 1's sentence (`plans/FS114-NB6-verification.md` ll. 106–108) names no ring type, so a yes also deletes from FS-124's case list every change point that ends a non-(Q) arc of `Γ`. In route M's saturated class the same (R2) arcs go another way, by FS-126's NO: FS121-Z1-NOCURVED (one mind) gives "no (R2) arc occurs" from it. NB6 ll. 109–111 record two readings of "(Q)"; this stub uses FS-112's (an arc whose centre carries both side colours) throughout (`plans/POROS-2026-10-03-close-reread.md` §§ 2.3 C1, C3).

## Owed second minds (before anything final rests on them)

FS116-Y4-FLANK (one mind; question 2 runs on it, while EMPTY's held count does not need it); FS114-N7-3T's per-pattern kills and FS114-N7-HUB on rings with
(R2) arcs (one mind each); FS116-V6-HUBS, -HUG, -COUNT, -ANTI (one mind each); FS114-N3-LOCAL's N3-HALF, -SEC, -FLANK, -PAIR, -ODD (one mind; FS-116's stub
listed them); row 134's base, Lemma 4 at cusps (BASE-V), before any publication.

## Construction targets

- A valid fragment by formula about a vertex of at least four colours whose ring carries (R2) arcs and no (Q) arc, on a disc of radius above 1, checked
  exactly with a planted fault that fires (none is held; FS114-Y2-BOWTIE's ring carries two (Q) arcs, its Reuleaux caps — FS-116's erratum).
- OC past `1 + ε` (FS114-N7-OCTB's forced structure; `plans/FS114-N7-proof.md` § 3.3).
- A Siamese valid fragment about a vertex whose ring carries no arc of `Γ`, past `1 + ε` — it would show question 3's answer is no.

## Prior-art debts

FLANK, EMPTY and SPOKE were not searched outside FS-116's records (inventory item 128); the mechanism is held in-house (G83's straddle, FS114-Y5-PXKILL).
Search under H1's names (map colourings avoiding a distance: Woodall, Townsend, Thomassen's "unit-radius tactic") and under "Reuleaux" and "exclusion zone".

## Registered expectations (provisional; instruments, never caps)

Question 1 decided within the milestone: 0.6; if decided, the bends keep the class: 0.55. The (R2)-arc ring excluded at `1 + ε` in the non-Siamese simple
class by a derivation: 0.35. EMPTY's Siamese form derived: 0.4.

## Failure clauses

A NO for the non-Siamese simple class says so in its headline (G21, G86); every exclusion states its reading radius and the controls it fails on (the capped
strip at `φ²/√2`, the disk at `φ`, the bowtie at `3√3/5`, R7 at seven colours, SQ9 at nine); the bends step is a lemma about fragments, derived, never read
off FS112-N2-RED's statement about maps; a statement on a class not yet shown inhabited says so (the lesson of FS-116's round 3: nine statements on a class
later shown empty); no argument one colour class at a time (row 129); no count as a step (G86).

## Deliverables

The plan (the reframe first); a derivation file in the Ephodos grammar; any object by formula with an exact check whose plant fires; the close's drafts.

## Provisional bearings

G83 (the straddle; its reading's residue), G91 (drafted at FS-116's close: the ring rule), G87 (the bends collision), G86, G21, G79, G15; rows 133–138 and
FS-116's; stubs FS-124, FS-125, FS-117, FS-122 (R1's card: EMPTY's margin is second order in the flank edges' lengths).

## Carried card (Poros, R2, 2026-10-03; verbatim from `plans/POROS-2026-10-03-close-reread.md` § 2.5)

question: does-a-fragment-bend-keep-the-class
  evidence: `plans/FS114-NB6-verification.md` ll. 104–108 states both sides one line apart as compatible facts about two domains, and side 1 names no
    ring type ("every ring arc but the (Q) arcs is removed"); the (R2) definition's radius-2 witness lies outside `B̄(p, 1 + ε)` (`data/fs116/claims.md`
    § 0); FS116-Y4-EMPTY (held) "reads radius 1" (`plans/FS116-V6-verification.md` § 2.2); FS-124's change points may end non-(Q) arcs (RING-GERM's
    hypothesis; FS116-S1-KAPPA)
  expected: that the bends question was the (Q)-free half's alone, as `plans/STUB-qfree-ring.md` question 1 poses it
  ask: Does bending a valid fragment on a neighbourhood of `B̄(p, 1 + ε)` by FS-112's moves keep it valid, non-Siamese, simple and four-coloured at `p` — so that every ring in C114-LOCAL-F's class is its (Q) arcs plus finitely many points?
  if it does: FS116-Y4-EMPTY closes every (Q)-free ring at `1 + ε` (N7-3T's, N7-HUB's, N6-RING60's classes are empty there, OC with them); FS-124's case list loses every change point that ends a non-(Q) arc; FS-123's question 2 is moot and its question 3 (Siamese) is next
  if it does not: the class condition the bend breaks is named, and the (R2)-arc rings are FS-123's main case, where card 2's ranking applies; FS-124 keeps (R2) arcs on (Q) rings as a case of its own
  answered by: derivation — Ephodos, FS-123's opening, as its first question, with FS112-N2-RED's moves (W-MERGE, whole-arc bends) and N2-AWAY read on a fragment
  cost: one derivation, under a round
  hunch: it does (`bends-keep-the-class`, 0.6); the record has never held an inhabitant of the (Q)-free class (`qfree-class-is-empty`, 0.65)
  falsifier: a non-Siamese simple valid fragment about a four-colour vertex whose fragment bend creates a Siamese pair or a non-simple tile, or changes `p`'s colours
  rank: 1
