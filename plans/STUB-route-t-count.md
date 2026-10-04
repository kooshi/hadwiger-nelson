# FS-117 — route T, the count: does no non-Siamese valid six-map with unit arcs exist, by Euler's formula and local payments? (stub)

*Minted 2026-09-28 by the close job FS114-C at FS-114's close (inventory items 42, 55, 101; Kooshi's ruling of item 121, as FS-116's header quotes it).
FS-114's second successor; its sibling FS-116 (`plans/STUB-local-exclusion.md`) holds K1, which this route needs too. **Solver column: in-ban** — derivation,
reading, exact identities on torus maps given by formula; no enumeration of maps, tile graphs or vertex types. Written for a session with no memory of
FS-114: read `CLAUDE.md` § The aim and § Counter-priors, `LEDGER.md` rows 135 and 137–138, `plans/FS114-derivation.md` §2 in full, and
`plans/FS114-N-proof.md` § Continuation — FS114-N2 and `plans/FS114-N3-proof.md` §3.2 and stage 4.*

**Provisional bearings:** G86 (a tile count reaches the non-Siamese part only), G15 (count × local kill), G68 (the torus first), G83, G91 (drafted at FS-116's close: the ring rule; the Γ-free type empty), G72, G30 (the planar-map
discipline: discharging, combinatorial curvature), G49 and G50 (Sirgedas's program is in print only as group posts); rows 135, 137–138; stubs FS-116, FS-111.

*At FS-129's audit (FS129-Z2, 2026-10-03):* FS129-OR1-QFREE, FS129-SR3-QFREE-NS
(K1 on (Q)-free rings has no instance).

## The question, in plain language

Every valid map's tiles meet like the faces of a planar map, and Euler's formula fixes their average number of neighbours. A six-colouring can afford
the neighbours only where colours repeat around a tile, and in a valid map a repeat is paid by a unit arc or by a Siamese pair (FS114-N114-RD). FS-114
made the count exact: on a torus map with no Siamese pair and no repeated contact, a charge of `n`, `n − 2`, `n`, `n + 6` at vertices of degree 3–6 (`n`
the non-tactic edges) plus the unused capacity `2U` sums to zero (FS114-N2-ENDS), and it averages on discs of the plane at every complexity
(FS114-N2-AVG, two minds). The charge is negative only at a degree-4 four-colour vertex with three or four tactic edges. So:

> **Route T's NO.** No non-Siamese simple valid six-map exists, at any complexity, once three local statements hold: **K1′** (every deficient
> configuration paid from nearby non-tactic edge-ends — K1, FS-116's, is its own-ends case), **K2′** (a unit left unused in every disc of radius `R₀`),
> and **GAP-μ** (repeated contacts between two tiles paid). (FS114-ROUTE-T; FS114-N3-JOINT.)

## Bearing on the answer

**Partial, never the whole NO.** Route T is blind to Siamese pairs by theorem (FS114-N2-LEMMAS: with Siamese pairs no density bound exists), so it
reaches at best the non-Siamese part — de Grey's target (`[16.317]`: "to prove that the plane cannot be 6-tlled with a non-Siamese tiling"), which would
strengthen `[Thomassen1999]` (nice colourings need seven) by dropping scalability, for segment-and-arc maps. The whole NO is FS-116's C114-LOCAL-F. A
torus YES (a doubly periodic valid map, non-Siamese) would be FS-116's YES as well. Its instruments — the exact charge, the absent-colour capacities — also
say which configurations FS-116 must exclude, so it can aim FS-116 even where it cannot finish.

**At FS-121's close (2026-10-03).** Whether honest saturation excludes Siamese pairs (G86) is unanswered; the honest route's maps are honest saturated (FS111-M2-REDUCE-A), so a yes would let this count serve the honest route's NO.

**At FS-116's close (2026-10-03, FS116-Z2).** K1's (Q)-free case: FS116-Y4-EMPTY (held) excludes at radius `1 + ε`, in the non-Siamese simple class, every vertex of at
least four colours whose ring carries no arc of `Γ`; whether FS114-N7-3T's whole class — and so K1′'s deficient configurations on (Q)-free rings — is empty
turns on whether a fragment's bends keep it in that class, FS-123's first question (`plans/STUB-qfree-ring.md`). FS116-V1-FRAME (one mind, true vacuously)
re-derives "every tactic centre is a change point" there. No FS-116 step was a count: every kill landed is a straddle.

*At FS-129's audit (FS129-Z2, 2026-10-03; from the readers' records, each FS-129 result derived, one mind, kernel pending, prior art owed unless named).* K1's (Q)-free case has no instance in the non-Siamese
class: FS129-OR1-QFREE (simple) and FS129-SR3-QFREE-NS (without simplicity) exclude at `1 + ε` every vertex of at least four colours whose ring carries no
(Q) arc, so route T's K1′ is owed only on (Q) rings (`plans/FS129-OR1-audit.md` § J24). An open line unplaced between this stub and FS-124's case 6:
FS114-Y3-RSTOP's "Y3-D2 without reading R-T" — a Reuleaux bowtie with a non-tactic edge, which no held result reads; this stub's if the count pays it
(`plans/FS129-SR3-audit.md` § 4.1). FS114-Y3-RSTOP is a member of FS114-Y4-RSTOPALL only on the non-Siamese simple part (FS-129 item 117; the erratum
under FS114-Y3-RSTOP in `plans/FS114-derivation.md`).

## What is open, named

- **K2′** — strictness: a unit unused in every disc of radius `R₀` (N3-DR1's and N3-DR2's forced non-tactic edges are the first candidate sources).
- **GAP-μ** — repeated contacts: a pocket between two tiles meeting twice meets at most 65 tiles (Jung's `2/√3`, non-Siamese), a hole at most five; no
  payment rule. **And its hull form** (NB6-MTP): the mass-transport route (Kooshi's lead, `[AldousLyons2007]` Ex. 9.5,
  `[AngelHutchcroftNachmiasRay2018]` Thm 1) needs GAP-μ in the hull, because limits of simple hole-free maps can pinch or open holes — a pointer for
  FS-111's limit objects.
- **COVER-3** (FS114-N2-ENC3): every colour meets `B̄(u, 1)` at every cubic vertex of a non-Siamese valid map — the local content of Sirgedas's
  "a valid tiling can't have an enclosed vertex with 3 neighbors".
- **Sirgedas's metagraph**: "no quadrilateral" (N2-QUAD: the all-β configuration, a unit rhombus of degree-4 vertices with equidiagonal pentagons, passes
  every local check — a GAP) and "only triangles".
- **The torus design**: a doubly periodic skeleton meeting the K6 screen and PAIRSHARE at every close pair (FS114-Y's first torus design, not tried;
  family F3, Sirgedas's non-Siamese 5-regular class, has its budget derived — `n/2` quads, at least `2n` of `5n/2` edges unit arcs — and is undecided).

## Prior-art debts

Sirgedas's "Graph Coloring by Simulation" thread (`J_Tw1_hUxQI`, about 4,300 lines unread) and the HNT simulator thread `a701Kwnhp_A` (unheld); Ágoston
2025 beyond §2.1 (his Lemma 7 and the nice plane case by `3n − 6`); `[Mohar2002]` beyond §3 (discharging on infinite planar graphs); `[Higuchi2001]`.

## Registered expectations (provisional)

K2′ derived under K1 at one mind (0.35); GAP-μ paid by a local rule (0.4); COVER-3 TRUE (0.5).

## Failure clauses

A NO here is stated for non-Siamese simple maps and never as the NO; a count that uses a complexity bound says so (route T needs none); no argument one
colour class at a time.

## Deliverables

The plan; the derivation file; drafts. Ranked by Poros against FS-116; the planner may merge it into FS-116 if the opening finds K1′ and K1 inseparable.
