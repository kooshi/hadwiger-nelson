# FS-2 — The Kempe classes of K-fabric's 4-colourings: what carries rigidity beyond the additive skeleton (STUB, 2026-09-06; re-aimed at the M57 close; scope note the same day)

> **SCOPE NOTE 2026-09-06 (the finite-plane bound, `reference/Chat-analysis/VERIFICATION.md`): every object this stub
> names lives in K or K(√247), both 5-sealed fields (a degree-one prime above 11; χ(UD(𝔽₁₁,2)) = 5) — fine as MECHANISM
> beds (what carries forcing without rigidity is a question about colouring spaces, and the seed's 252-cheat subset is the
> best bed we have), but no answer found there produces a 6-object. The design consequence of any answer must be carried to
> a 6-open field (`plans/M58-field-sieve.md` decides which). M57 answered the seed half: H's 35-vertex Kempe graph lies
> within two single-vertex moves of its 18 additive colourings (M57 §R2); what remains is K-fabric's 16-pair residue and
> the 252-object's components (T29).**

*Minted at the M56 close. Read beside this: `plans/M56-arithmetic-of-tightness.md` §M1.5 (the Kempe localization),
§R1 (the bed's table: F_true 171 ⊆ F_K 187 ⊆ F_add 2,513), `data/m56/kempe-object-…-k4.json` (every Kempe verdict
with its verified swapped colouring), `plans/M57-additive-rigidity.md` D3 (the coset-component condition), `CLAUDE.md`
G41 (b).*

## 1. Mission context, in plain language

M56 measured, on the 1,953-point K-fabric at four colours, that the eight additive colourings (the two residue
colourings and six ℤ/4-type ones) force exactly the pairs of 2-adic depth ≥ 2, that one Kempe swap of an additive
colouring separates every depth-2 pair, and that after those swaps 187 pairs remain Kempe-forced while the solver
forces only 171. So sixteen pairs are separated by colourings that no single swap of any additive colouring
produces. The question is what those colourings are: two swaps away, or outside the Kempe classes of the additive
family altogether. If every 4-colouring of K-fabric is Kempe-equivalent to an additive one, then K-fabric's
4-rigidity is the intersection of the Kempe closures of eight lattice colourings — a finite, solver-free
description of exactly the phenomenon (rigidity at χ) the 6-hunt needs at five colours, and the same test on a
5-chromatic wall-broken chunk (is its 5-colouring space the Kempe closure of its additive family?) is the
tightness question in computable form.

## 2. What we know

| fact | where |
|---|---|
| F_K on U: 187 pairs (176 at 64/9, 11 at 64/3); the dial's F_true: 171 (163 + 8); every depth-2 pair kempe-separated (2,321 by the sublattice mechanism, 3 by the finite component); 2 depth-3 pairs separated by the component mechanism | M56 §R1, `data/m56/kempe-object-…-k4.json` |
| the swap lemma and the coset lemma (a swap on a component of the {a, a−c}-subgraph is proper; the component lies in one coset of Λ_c^φ) | M56 §M2.1 |
| the seed at five: 18 additive colourings, 17 non-additive at defect 1–2 — a 35-vertex Kempe graph nobody has drawn | M56 §R2, `data/m56/colourings-EI-seed-12graph-k5.json` |
| the residue colouring's {a, b}-subgraphs on the hexagonal lattice are lines (Λ_c of rank 1) | M56 §S6 |
| the 16 residual pairs are all at depth 3 (13 at 64/9 — among the dial's 15 free pairs there — 3 at 64/3) | M56 §R1 |

## 3. Derivations first

**D1 — Kempe-reducibility.** Define the Kempe distance of a colouring c to the additive family as the least number
of swaps from some additive colouring to c. A GREEDY reducer: from c, choose the swap that most lowers the Hamming
defect to the nearest additive colouring; the defect is the potential. Derive when a swap lowers it (the component
must be mostly on the "wrong" side of the palette map) and when greedy stalls. The instrument is the greedy reducer
with a random restart; the claim "c is in the Kempe class of the additive family" is certified by the path found,
never by the reducer's failure (a failure is `undecided`).

**D2 — the 16 pairs.** For each, take the dial's separating 4-colouring (one SAT call with the pair pinned apart)
and reduce it; the number of swaps on the certified path is its Kempe distance. Prediction P1.

**D3 — the seed's Kempe graph.** 35 colourings, edges = one swap: draw it (exact, tiny) — are the 17 non-additive
colourings adjacent to the 18 additive ones? This is the five-colour instance of the whole question, complete
rather than sampled, on the one 5-tight object we have.

**D4 — the connectedness conjecture.** "Every 4-colouring of a K-chunk is Kempe-equivalent to an additive one."
Falsifier: a sampled 4-colouring whose reducer stalls at positive defect AND whose Kempe class, explored by BFS to
a depth cap, contains no additive colouring. What a proof would need: the Kempe classes of 4-colourings of planar
graphs are a classical topic (Meyniel, Mohar); K-chunks are not planar, so nothing transfers directly — the
derivation to attempt is a potential argument on the lattice: each swap on a component that is a proper part of
a coset moves the colouring toward or away from additivity by a computable amount.

## 4. Phases

| phase | what | cost |
|---|---|---|
| 0 | D1–D4 | half a day |
| A | `additive.py kempe-reduce --k --colourings FILE` (the greedy reducer with restarts; verdicts `reduced: d swaps` with the path's colourings verified, `undecided`); `kempe-graph --colourings FILE` (the complete swap graph of a small list); controls: an additive colouring reduces in 0; a one-swap image reduces in 1; the hex ball's colourings all reduce | half a day |
| B1 | the 16 pairs (D2); 200 sampled 4-colourings of U reduced (P2); the reducer's stall population characterized | hours |
| B2 | the seed's 35-vertex Kempe graph (D3) — P3 | minutes |
| B3 | the same reducer at five colours on W's 200 sampled colourings against its 432 additive ones (P4) | hours |
| C | close; if P2 holds, the connectedness conjecture goes to a derivation milestone or is left as a registered conjecture with its falsifier armed | |

## 5. Registered predictions

| # | prediction | basis | confidence |
|---|---|---|---|
| P1 | each of the 16 residual pairs is separated by a colouring at Kempe distance exactly 2 from an additive one | one swap fails by measurement; the second swap is the natural next | medium |
| P2 | every one of 200 sampled 4-colourings of U reduces to an additive colouring (Kempe-connected); the median path is under 20 swaps | the additive skeleton is rich (8 colourings) and every depth-2 pair is one swap away | medium-low |
| P3 | in the seed's Kempe graph every non-additive colouring is adjacent (one swap) to an additive one; the graph is connected | defects 1–2 | medium-high |
| P4 | W's sampled 5-colourings do NOT reduce: the reducer stalls at defect above 400 on most of them (the additive family is a negligible corner; the Kempe classes are not the additive ones) — the five-colour tightness gap seen from the Kempe side | the random-baseline defects | medium |

## 6. Failure clauses

P2 refuted (a stalled class with no additive member found by BFS): K-fabric's 4-rigidity has a non-Kempe
component — record it, it is a NEW mechanism; P3 refuted: the seed's 17 are not one swap from the 18 — the defect-2
colourings are a second family to name; P4 refuted (W's colourings reduce): W's tightness gap is Kempe-shaped and
FS-1's principle gains a mechanism.

## 7. Bearing on 6, honestly

Medium. It does not produce an object; it says what "rigid at χ" IS on the one bed where we can compute
everything, and hands FS-1 its mechanism (or its obstruction). One day of work.

## 8. Addresses

`tools/additive.py` (`kempe`, `defect`, `additive-test`, the stage vocabulary), `data/m56/kempe-object-S29-…-k4.json`
(the 187 kempe-forced pairs and the swap witnesses), `data/m53/rigidity-dial-it4.json` (the 171), `data/m56/
colourings-EI-seed-12graph-k5.json` (the 35), `data/m56/colourings-sample-W-core-8over3-k5.json` (the 200),
`tools/m56_sample_colourings.py` (the sampler, for 4-colourings of U).

## 9. Literature to ingest (from Kooshi's web-Claude analysis, 2026-09-06; second-hand until read — `BIBLIOGRAPHY.md`)

Kempe invariants are the classical instance of a mod-n quantity that sees exactly the integrality of a colour: Heawood's
parity criterion (a planar triangulation is 3-colourable iff every vertex has even degree) is one; Mohar–Salas (2009) built
the 4-colour instance on triangulations — a Kempe invariant that makes the Wang–Swendsen–Kotecký algorithm non-ergodic —
and Mohar (2006) and Bonamy–Bousquet–Feghali–Johnson (2019) carry the Kempe-equivalence theory to regular graphs. The
project's "holonomy" at the 3 → 4 step (G25: rainbow-clique propagation returning shifted) is monodromy in S₃; the Kempe
theory is its 4 → 5 vocabulary. **The question this adds to D4:** is there a mod-n invariant of the 5-colourings of a
unit-distance graph that is constant on Kempe classes and separates the additive family from the rest? On the seed the
Kempe graph of the 35 is connected within two moves of the additive 18 (M57 §R2), so no invariant separates them there;
on the 252-cheat forcing subset (> 5,000 colourings in three defect regimes) the components are unknown (T29) — the first
place an invariant could live. Note the scope of the literature: Heawood and Mohar–Salas are about planar triangulations;
unit-distance graphs are not planar, and nothing transfers directly (FS-2 D4 said so of Meyniel/Mohar already).
