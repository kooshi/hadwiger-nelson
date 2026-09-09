# Poros note, 2026-09-08 — the mascot challenge: the dial's rungs are sieved, and the realized ones are dead

*Written by the advising session (`a69b3a4f8ae868bc5`) for de Bruijn and Coxeter. Not a milestone.
Adopt the card into `plans/FRONTIER-STUBS.md` or delete this file; it exists so the question survives a
compaction. Nothing here is a new measurement — every number is recomputed from the record and cited.*

## The finding

`plans/FIELD-WALL-SESSION-HANDOFF.md` §3(b) (lines 111–124) tabulates, for each distance `d` that
K-fabric could force equal at four colours, the field the spindle adjoins. `plans/M58-field-sieve.md`
(§R, line 408) proves: **a field `F ⊇ K` is 6-open iff its 2-adic wall is broken and 11 is inert in it**,
i.e. iff the odd squarefree part is `5` or `7 (mod 8)` and is a non-residue mod 11. Nobody has run the
second table over the first. Doing so, exactly (`QR mod 11 = {1,3,4,5,9}`), and cross-referencing
`plans/M56-arithmetic-of-tightness.md` §R1 (line 723) for the 2-adic depth and the dial's verdict:

| depth | `v₂` | `d` | `d²` | `4d²−1` | adjoins | dial's verdict on `U` (1,953 pts) | sieve |
|---|---|---|---|---|---|---|---|
| 1 | 2 | `2/√3` | `4/3` | `13/3` | `√13` | free — separated by explicit ℤ/4-homs | **6-OPEN** |
| 1 | 2 | `2` | `4` | `15` | `√5` | free — separated by explicit ℤ/4-homs | 5-sealed |
| 1 | 2 | `2√3` | `12` | `47` | `√47` | free — separated by explicit ℤ/4-homs | 5-sealed |
| — | — | `4/3` | `16/9` | `55/9` | `√5` | (depth 2 in `Λ`) | 5-sealed |
| 2 | 4 | **`4`** | `16` | `63` | **`√7`** | **free (0 of 179), non-additively — Kempe-separated** | **6-OPEN** |
| 2 | 4 | **`4/√3`** | `16/3` | `61/3` | **`√61`** | **free (0 of 2,145), non-additively** | **6-OPEN** |
| 3 | 6 | `8/3` | `64/9` | `247/9` | `√247` | **forced, 163 of 178** — REALIZED (§7.5) | 5-sealed |
| 3 | 6 | `8/√3` | `64/3` | `253/3` | `√23` | **forced, 8 of 11** — REALIZED (§7.5) | 5-sealed |

**The project realized the deep rung and got two fields in which no 6-chromatic unit-distance graph can
exist. Both fields that can host one sit at the rung it measured free once, on one 1,953-point object,
and never re-measured at scale.** G37 already notes the backward half of this ("every endgame the
descent could have run was provably ≤ 5"); the forward half — *therefore aim the four-colour dial one
rung shallower* — is nowhere in the ranked frontier set.

Depth 1 is closed by a theorem-shaped fact and not by size: twelve explicit ℤ/4-homomorphisms separate
all 6,669 + 5,470 + 767 depth-1 pairs (M56 line 723). Depth 3 is realized. **Depth 2 is the only live
rung, and it is the 6-open one.** Its blocker is not the homs — every depth-2 difference lies in `4Λ`
and is additively forced — but their Kempe swaps: 2,321 of 2,324 depth-2 pairs are separated "by the
sublattice mechanism" and only 3 "by the finite component" (M56 §R1). Whether the sublattice mechanism
is a rank argument valid at every fabric size, or dissolves as components grow, is the card.

## The card

```
question: is-the-distance-4-separation-structural-or-finite
  evidence: M56 §R1 line 723-724 — at depth 2 (d² = 16/3, 16; 2,145 + 179 pairs) every pair is
    additively forced and then Kempe-separated, 2,321 by the sublattice mechanism and only 3 by a
    finite component; at depth 3 (178 + 11 pairs) 171 are forced and the count grew 131 → 163 in one
    growth step (FIELD-WALL-THEOREM §8.7, line 627)
  expected: the depth-2 freedom is boundary freedom, the same finite-size effect §8.7 names for depth 3
  ask: is the depth-2 Kempe separation a rank argument valid at every fabric size, or a
    finite-component effect that a larger K-fabric dissolves?
  if structural: no K-point graph ever forces a pair at 4 or 4/√3 at four colours, so K-fabric's only
    reachable spindle fields are K(√247) and K(√23), both 5-sealed — K-fabric is a proved dead end for
    χ ≥ 6, and M62 must start from wall-broken fabric, not from K
  if finite: grow the fabric, re-run the standing dial on the 179 distance-4 pairs, and the spindle
    mints a 5-chromatic unit-distance graph in K(√7) = ℚ(√3, √7, √11) — degree 8, no √5, 6-OPEN —
    answering FIELD-WALL-THEOREM §8 item 2, a stated open question of this project's own note
  answered by: derivation — M57 line 496 derives Λ_c rank ≤ 3 on three-ladder material; carry that
    rank count to n-ladder material, then ask whether a proper Λ_c can miss 4u at every size
  cost: hours, no solver; cross-check is one growth step of the existing dial
  hunch: finite — the depth-3 counts grew under exactly this operation
  falsifier: a rank argument showing some Λ_c^φ misses 4u for every fabric of every size
  rank: 1
```

## Amendment, 2026-09-09 — the card splits, and it gets cheaper

`BIBLIOGRAPHY.md` line 25 (rewritten 2026-09-09 from the held copy of `[ExooIsmailescu2019]`,
arXiv:1805.00157, which had sat marked "second-hand" since 2026-09-05) records that their `G40` — **forty
points, in `K`** — has a forced pair at `8/3` **conditional on no monochromatic `√(11/3)`-pair**, spindled
about one endpoint by `arccos(119/128)`. Their proof, §2 lines 127–133 of the extracted text, is T20's
move in print in 2018. Where the project's unconditional forcer at the same distance in the same field
needs **588** points, theirs needs **40**.

**Conditional forcing is roughly fifteen times cheaper at the same distance.** Every odd-`d²` class is
separated by both residue colourings (`d² = 11/3` and `d² = 3` alike), so a condition of that shape is
exactly "assume the colouring is not residue-adjacent" — the natural hypothesis to carry. So the card
above should be asked in two halves, both smaller than the whole:

1. **Can K-fabric force a distance-4 pair *conditionally*, on some odd-valuation class being clean?**
   Forty points sufficed at depth 3; this is the depth-2 version.
2. **Can the condition then be discharged** — by fabric growth (their `G40` → our 588-core), by a second
   spindle (their route, which costs a third act and yields a pigeonhole), or not at all?

If half 1 lands and half 2 lands only by spindling, the object is still a 5-chromatic unit-distance graph
in `K(√7)`; it has three acts rather than one, exactly as theirs does. The demand for one act was never
justified and is withdrawn.

## Three smaller things

1. **The handoff already asked this.** §6 item 2 (line 222): *"derive whether valuation 4 (distance 4)
   must come before valuation 2 (distance 2), which would predict K(√7) witnesses before K(√5) ones."*
   Written 2026-09-05, unattempted, and in no ranked list. §3(b) closes with *"each a new 5-forcer
   without search"* — the mascot challenge, three days early.
2. **`[Parts2020a]` is held and unread** (`BIBLIOGRAPHY.md` line 27): *Graph minimization, focusing on
   the example of 5-chromatic unit-distance graphs in the plane*, arXiv:2010.12665, on disk. It is the
   paper on the word "minimal". `[Soifer2024]` ch. 64 records that order lower bounds of this genre
   exist (≥ 6993 for 7-chromatic; Pritikin 1998: 6198). Thirty minutes; G50's third instance.
3. **The Hajós construction is cited nowhere in this repository.** A graph forcing `u ≠ v` at `k`
   colours is exactly a vertex-splitting of a `(k+1)`-critical graph, and Hajós generates every
   `(k+1)`-critical graph from `K_{k+1}` constructively. That does not settle unit-distance
   realizability over `K`, but it is the discipline that owns the object, and it has not been looked at.
