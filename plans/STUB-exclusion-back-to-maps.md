# FS-134 — the exclusion back to maps: does FS-132's measurable exclusion, read at a map, give rows 148–149 with no Siamese clause? (stub)

*Minted 2026-10-07 by FS-132's record job, part 2 (FS132-Z2; `plans/FS132-Z2-record.md` Stage 2), from FS132-E3's report
(`data/fs132/reports/FS132-E3.md`, "a short job, 'a map vertex carries hypothesis (a)'"), the coordinator's ruling that it is
"not briefed tonight … the asking lane ranks it" (`plans/FS132-close-inventory.md` item 10 (iii)), and the first record job's
finding that one fact is missing, not two (`plans/FS132-Z1-record.md` § 3.4). State: Not started. **A short job: one derivation
stage and one composition.** Unranked; Poros ranks it. **Solver column: in-ban** — derivation, reading, exact checks of
held fragments by formula. Written for a session with no memory of FS-132: read `plans/FS132-derivation.md` §§ 1–2 (the entries
C132-M-ORBIT, C132-M-EXCL, C132-WITNESS), `LEDGER.md` rows 148–149, and `data/fs116/claims.md` §§ 0, 10, 13 (valid fragment,
tile, ring, (Q) arc, non-Siamese, simple).*

## The question, in plain language

How many colours does the plane need so that no two points at distance exactly 1 share one? Six or seven
(`[OAIMath2026]`), and the plane's number is that of *weak measurable colourings*: measurable maps from the plane to the
colours with `c(z) ≠ c(z + u)` for almost every pair of a point `z` and a unit vector `u`.

This project's sharpest local theorem about six-coloured *maps* is rows 148–149: in a valid six-coloured fragment (a
locally finite map of a disc, tiles of one colour each, no two interior points of one colour at distance exactly 1), a
vertex `p` of at least four colours whose unit circle `ω(p)` (its *ring*) carries no (Q) arc — no arc of the map's
boundary both of whose side colours `p` carries — exists on no disc of radius above 1 about it. Both rows carry the
clause **non-Siamese** (no two tiles of one colour within each other's exclusion annulus); row 149 reaches its class
through FS-112's bends.

On 2026-10-07 FS-132 derived a statement of the same shape with **no map and no Siamese clause**, C132-M-EXCL
(`plans/FS132-derivation.md` § 1; [hand], one mind, with a line-by-line checking reading of its last steps by a second
mind; kernel pending). In words: let `c` be a weak measurable six-colouring of an open set containing the closed unit
disc about `p`; let four labels `a_0, a_1, a_2, a_3` be given and, for each `j` modulo 4, a compact set `K_j` through `p`
holding another point, such that neither `a_j` nor `a_{j+1}` has a point of its closed essential support in the
*straddle set* `Δ(K_j)` (the points with some point of `K_j` nearer than 1 and some point farther than 1). Then it is
**not** the case that the *palette* at `p` (`[OAIMath2026]` Definition 5.1: the labels that show with positive weight on
circles about `p` of radius tending to 1, direction by direction) contains one of the two other labels in almost every
direction.

**The question**: read at a map vertex where four tiles of four colours meet in a cycle, is C132-M-EXCL the statement of
rows 148–149 — and so does it hold for fragments **with Siamese pairs, simple or not**? FS132-E3 says yes *given two
facts about maps*, neither derived by it:

- **F1 — a map's edge carries the two-colour exclusion.** Derived the same night, for tiles that are connected open
  sets, as **C132-WITNESS** (`plans/FS132-derivation.md` § 2; [hand], one mind): a connected open region of one label has
  that label's whole essential support disjoint from `Δ(K)` for every compact `K` in the region's closure — the *whole
  class*, every other tile of that colour included, which is why no Siamese clause is needed. **Nobody has written the
  composition** of C132-WITNESS with C132-M-EXCL.
- **F2 — a map's palette is its ring read two-sidedly.** **Derived by nobody.** What it has to say: at almost every
  direction `e`, the palette `P_p(e)` of a map colouring is the set of colours of the tiles that touch the ring point
  `p + e` from just inside and from just outside the unit circle about `p`. With it, "almost every palette holds a
  colour absent at `p`" is "the ring carries no (Q) arc" (off the boundary a ring point's tile has a colour absent at
  `p`, FS116-RING-TWIST-C; along an arc of the boundary the palette is the arc's two side colours).

So: **one fact to derive (F2), against the release's Definition 5.1 (`M/palettes.tex` ll. 47–68), and one composition to
write.**

## What it would give, stated so that it can be checked

*A target statement, this stub's wording — not an entry, not derived:* no valid six-coloured fragment on a closed disc of
radius above 1 about a vertex `p` at which four tiles of four distinct colours meet in cyclic order, each consecutive
pair along a common edge through `p`, has a ring carrying no (Q) arc — Siamese pairs allowed, simple or not.

**Not covered even then** (FS132-E3's report): a vertex of at least four colours whose tiles about it contain no such
four-cycle — for instance sectors `a, b, c, a, d`, whose edges are `ab`, `bc`, `ca`, `ad` and close no four-cycle. That
vertex stays FS-123's (`plans/STUB-qfree-ring.md`). Nor: anything about rings *with* (Q) arcs (FS-124); anything at seven
colours or more (C132-M-ORBIT's steps M2 and M9 spend six).

## Controls a deriver should run

- **Every held positive must escape at the ring hypothesis.** FS132-E3's control `positives-escape`
  (`data/fs132/e3/positives_check.py`): at each of the eight change points of the held fragments' four-colour vertices,
  at least two of the four germs at ±60° lie on (Q) arcs. Read each held fragment's palette by F2 and confirm the
  measurable hypothesis fails where the map hypothesis does.
- **Nine colours**: SQ9's lattice vertex meets every hypothesis but the count (FS116-V6's control `v6-sq9`).
- **A planted fault in F2**: a one-sided reading of the palette (inside only) must change the answer on a fragment with
  a unit arc on the ring.

## Bearing on the answer

**None on the value, and none on the measurable road** (the coordinator's ruling, item 10 (iii): "it turns a measurable
theorem back into the map class, strengthens rows 148–149, and bears none on the measurable road"). What it buys:

1. **Rows 148–149 lose "non-Siamese" at four-cycle vertices**, and row 149 gains a second route with no bends
   (FS132-E3's report) — by different mathematics from FS-112's.
2. **A test of fit for the measurable theorem**: that C132-M-EXCL, read on this project's own exact fragments, says what
   rows 148–149 say there. A mismatch would be a defect in one of the two — worth more than the agreement.
3. **F2 is the dictionary fact the next milestone needs.** FS-124 (`plans/STUB-q-ring.md`) must be posed for measurable
   colourings, and every positive it holds (rows 136, 138; the seam fragments) is a map: F2 is what lets a held fragment
   stand as a control of a statement about palettes, and what makes "(Q) arc" and "palettes holding no outside label on
   a set of positive measure" one object.
4. FS-123's place on the frontier: the asking lane's drafted banner reads "Absorbed on the measurable road … Demoted
   3 → 8 until the kernel has C132-M-EXCL" (`plans/POROS-2026-10-07-fs132-night.md` § Banners; drafted, not filed). The
   absorption is exactly this stub's composition.

## Owed second minds

C132-M-ORBIT's steps M6 and M8 have one derivation each and readings made with the argument open
(`plans/FS132-derivation.md` § 1, the table); its local form rests on one mind's reading of two proofs of the release
as local (step M0). The kernel is the second check (FS-132's Lean phase, branch `fs132-wk1`). C132-WITNESS: one mind;
"read, not reworked" by its one later user.

## Registered expectations (provisional; instruments, never caps)

F2 derived in one stage, as worded: 0.80. The composition then gives the target statement: 0.85. A defect of fit found
(the palette's definition reads a ring point otherwise than two-sidedly at a map, so the target must be reworded): 0.15.

## Failure clauses

- If F2 fails as worded, state what a map's palette *is* and restate the target; that is the result.
- If a held fragment satisfies the measurable hypotheses and survives past radius 1, a step of C132-M-ORBIT or its local
  reading M0 is wrong: message the coordinator at once; nothing downstream of FS-132's exclusion stands until it is found.
- If the job outgrows one stage, stop at F2 as a relay-result.

## Deliverables

Entries in the deriver's grammar: F2; the composition; what is left for FS-123. A dated note for rows 148 and 149
(drafted for the coordinator). The three controls above, each with a planted fault watched firing.

## Provisional bearings

G86 (a Siamese kill reads points and distances, not tiles — this is one), G91 (the ring; RING-TWIST-C is F2's map half),
G92 (C132-M-EXCL is rows 148–149's argument at the class it reads), G94 (the nerve replaces the map: here the map is put
back, as a control), G21 (every held positive escapes at the hypothesis — check that it escapes for the reason stated);
rows 134, 148–149; stubs FS-123, FS-124.
