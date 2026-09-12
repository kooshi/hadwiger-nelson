# FS-6 — A family-keeping thickening: where M57's principle could bite (STUB, 2026-09-06, minted at the M57 close; restricted to de Grey's field the same day)

> **NAMING 2026-09-10 (frontier-stubs sync).** This stub was chosen as M62 at the M61 close, but the number went
> to the milestone that ran first — the evolutionary type-M search (`plans/M62-evolutionary-type-m.md`), of which
> FS-6 is the sequel: the same search one colour up, over a 5-sealed field. FS-6 takes a milestone number when it
> runs. Where §H below says "M62", it means this stub.

> **RESTRICTED 2026-09-06 (the finite-plane bound, `reference/Chat-analysis/VERIFICATION.md`): F₂₄₇ = K(√247) is a
> 5-sealed field (a degree-one prime above 11, χ(UD(𝔽₁₁,2)) = 5), so nothing built there can be 6-chromatic; this stub's
> F₂₄₇ half is struck. Its de Grey half stands and is strengthened: de Grey's field ℚ(√3,√5,√7,√11) has no usable prime
> below 131 (√7 makes 11 inert), and the gen-1 half-spindle closure keeps ≥ 300 ℤ/5-homs at every radius (M57 §R5
> addendum) — the one field we hold that is both 6-open (pending the plane at 131, `plans/M58-field-sieve.md`) and
> family-keeping. Run phase B on de Grey's field only.**

*Read beside this: `plans/M57-additive-rigidity.md` §R4–§R5 (the F₂₄₇ cross lattice's 5-divisibility, the cumulative
dial 1,728 → 960 → 640 → 0, Heule-510's 3,456 → 96), §M1.6 (the dial's axis is the direction set), M56 §M1.7 (L7:
1/5 ∈ Σ₀ of every plane), `CLAUDE.md` G42.*

## 1. Mission context, in plain language

M57's design principle — make every 5-colouring of a unit-distance chunk additive, so a 5Λ-pair is forced and a spindle
gives χ(ℝ²) ≥ 6 — needs two things at once: a NONZERO additive family (some ℤ/5-hom of the chunk's lattice nonzero on
its unit vectors) and a CLOSED one (every {a, b}-subgraph of every hom connected, γ = 0). Every unit-distance object we
hold fails the second by orders of magnitude, and the one way we know to add material where the first still holds —
in-field (K) points, always in-lattice — sits on 4-colourable unit parts that can never be rigid. The wall-broken
thickening that moves M54's redundancy dial (F₂₄₇'s cross lattice) kills the family at depth one: the 63 cross points'
unit vectors generate a lattice in which 500 of W's unit vectors are 5-divisible. Fischer's 1/5 ∈ Σ₀ says every plane's
rich chunks lose their ℤ/5-homs eventually; the question is whether ANY construction adds directions slowly enough —
keeps the joint lattice 5-indivisible — to close the Kempe subgraphs before the family dies.

## 2. What we know

| fact | where |
|---|---|
| W (1,175, F₂₄₇): 1,728 homs; W + first 48 cross points: 640; W + 63: 0 with 500 units in 5Λ | M57 §R5 |
| the depth-2 F₂₄₇ stage: no hom at any radius; 98 % of every ball's units in 5Λ | M57 §R5 |
| Heule-510: 3,456 homs on its inner 428 points, 96 on the whole (the last ring, |S₅| 42 → 60) | M57 §R5 |
| the 1581: ≥ 2,981 homs (rank 16); its gen-1 half-spindle closure (24,065 points, 358 directions, rank 32): ≥ 300 homs at every radius, no unit in 5Λ — the family never dies | M56 §R3; M57 §R5 addendum, `data/m57/richness-degrey-k5.json` |
| in-lattice points never kill a hom by coverage; a new-direction point kills a hom iff its neighbours' colours cover the group | M57 D5 / §M1.5 |

## 3. Derivations first

**D1 — when does a new unit vector make an old one 5-divisible?** u ∈ 5Λ′ with Λ′ = Λ + ℤv means u = 5(a + m v), a ∈ Λ:
5m v ∈ u − 5Λ. Derive the condition on v's coordinates in ℚΛ (v ∈ ℚΛ ∖ Λ of order m with 5 | m is the F₂₄₇ case —
the index-5 points of §R4); a new-direction v (v ∉ ℚΛ) can never do it. So a thickening keeps the family iff its new
points are in-lattice or new-direction, never rational of order divisible by 5 — a per-point exact test, before any
hom is computed.

**D2 — the closure's growth.** The half-spindle words act on the 1581's 67 direction classes; the gen-1 closure's
directions are their images plus the chords between orbit points. Predict: rank grows past 16 (new-direction points)
and the family survives longer than in F₂₄₇ (whose cross points are all rational-of-order-5 or in-lattice).

## 4. Phases

| phase | what | cost |
|---|---|---|
| 0 | D1 as an exact per-point classifier (`additive.py extend` already reports the case; add the 5 ∣ m flag) | an hour |
| A | the de Grey dial (finish), the Heule-field closure (the 510 under its own words), each with the classifier's tally | a day |
| B | on the best field: grow by in-lattice and new-direction points only, read γ̄ per step | a day |

## 5. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | the gen-1 closure keeps ℤ/5-homs on its r² ≤ 1 ball (11,053 points) and loses them by r² ≤ 4 | low — **SCORED at the M57 close: refuted in the favourable direction; the whole closure keeps ≥ 300 (M57 §R5 addendum), so phase B runs on de Grey's field first** |
| P2 | no in-lattice-plus-new-direction thickening of W reaches γ̄ below half its value before its family falls below 100 | medium |

## 6. Failure and jackpot clauses

P2 refuted on any object: the principle is live — HALT the survey, run `rigid` on that object under the jackpot protocol.
P1 refuted in the "loses" direction (homs survive the whole closure): the family is far more robust than F₂₄₇'s, and B
runs on de Grey's field first.

## 7. Bearing on 6, honestly

Medium. It is the only place M57's principle could apply; a negative closes the principle at five colours as a design
route and hands the question back to FS-2 (what carries forcing without rigidity).

**A route this target does NOT have, measured 2026-09-11 (M63 phase G).** A rotation of Parts's type joins only
points collinear with its centre, so the admissible rotations enumerate exactly over the base's lines rather than
being sampled from a sieve. Run exactly on his §5.6 base and on a second base: **26 candidate rotations, 6 surviving
the 2-adic filter — and not one of the survivors is 6-open.** Every one sits in a field where the prime 11 stays
usable, which is precisely the condition that seals a field at five colours (G43, G48). **So the six-level design
target is not reachable by choosing a different rotation of this type on this lattice** — the rotation degree of
freedom is exhausted, and a 6-open field has to come from somewhere else (a new base lattice, or a spindle over a
forced pair as G48 describes). This is a genuine narrowing of FS-6's search space, not a failed experiment: it
removes an option that looked free. Recorded from `plans/M63-phaseG-bases-and-rotations.md`; the filter rests on a
field-level gap this project has not closed, so each elimination is a **testable prediction, not a proof**.

---

## §H. Handoff for the session that opens M62 (written 2026-09-08 at the M61 close, on Kooshi's "FS-6 it is", before his compaction)

**Kooshi's decision, not to be re-decided: the next milestone is M62 = FS-6, this stub, RE-AIMED by G48.** Open it per
WORKFLOW step 3 onward: `git mv plans/STUB-family-keeping-thickening.md plans/M62-family-keeping-thickening.md`, re-point every
reference (`grep -rn STUB-family-keeping-thickening CLAUDE.md plans/ tools/` and the memory file), mark the FS-6 row of
`plans/FRONTIER-STUBS.md` "opened as M62", then the subplan §S with the derivations FIRST (G46), the skeleton, three FRESH modeling
passes each committed, implement, gate, Frontier, re-rank, report.

**Read, in this order.** (1) `CLAUDE.md` § Frontier — the M60 and M61 paragraphs and G47–G48 (the compulsion face of sealing; the
mechanism of tightness). (2) This stub §1–§7 and the M58 restriction banner above (F₂₄₇'s half was struck because F₂₄₇ is 5-SEALED —
under G48 that is no longer a reason to strike it: a 5-sealed field is exactly where the new target lives). (3)
`plans/M61-local-global-tightness.md` §S5 and §R7 (the mechanism: forced at five over a sealed field ⟹ `11 ∣ d²` ⟹ the spindle
adjoins `√(4d² − 1) ≡ √−1 (mod 11)` ⟹ the spindle's field is 6-open by construction). (4) `plans/M60-five-colour-residue-obstruction.md`
§S3 and §R7 (the residue filter `tools/fpcompel.py filter`: a five-colour forced-pair ask over a sealed field is decided by residue in
milliseconds unless `11 ∣ d²`). (5) `plans/M54-five-colour-dial.md` §R and `plans/M55-absorption.md` §R (the two obstructions a forced
pair at five colours must clear — the critical set inside the pair's common neighbourhood, and no absorbable 4-colourable piece — and
the objects that clear the first: the two-core union, the two-spindle full-fabric union, the F₂₄₇ cross-thickened witness whose critical
set moved). (6) `plans/M57-additive-rigidity.md` §R4–§R5 (the stub's original question, the family-keeping dial, now the secondary
instrument). (7) `data/fplane/README.md`, `data/m54/`, `data/m55/`, `data/m57/` for every record's licence.

**What G48 changed, in one paragraph.** This stub was minted to ask where M57's principle (make every 5-colouring additive) could
bite, and it restricted itself to de Grey's field because only a 6-open field can host a 6-forcer. M61 derived that the 6-forcer's
field is 6-open BY CONSTRUCTION and need not be chosen: over a field sealed at five by the prime 11 (Heule's `ℚ(√3, √5, √11)`, K(√247),
K(√23)), any pair forced equal at five colours has `11 ∣ d²` (M60's law), and the spindle over it adjoins `√(4d² − 1)`, which is `≡ √−1
(mod 11)` and so makes 11 inert — the spindled graph lands in a wall-broken, 11-inert field whose every usable prime is ≥ 67, i.e. 6-open.
**So the design target is a pair forced equal at five colours over a SEALED field, at a distance with `11 ∣ d²`; the spindle then does
the rest, and the field jumps by itself** — exactly as K's 4-rigid fabric at `8/3` jumped to K(√247). The family-keeping question (a
nonzero, closed additive family) is one localization of where such a pair can live (G41/G42) and is kept as an instrument, not the target.

**The first derivations to make at opening (G46).**

* **D1 — the forced-distance vocabulary, per sealed field.** Over Heule's field the squared distances realizable between unit-graph points
  with `11 ∣ d²`: `d² ∈ {11, 33, 44, 99, 11/4, 11/9, 44/9, 11/3, …}` — list which occur among the pairs of the objects we hold (Heule-510
  and its closure, W and its F₂₄₇ cross lattice at depths 1–2, the two-core union) by exact arithmetic (`fpcompel.py filter --pairs` already
  reports every pair's residue norm; `0` is the class). Per distance, the spindle's radicand and field: `d² = 11 → √43`; `33 → √131`;
  `44 → √175 = 5√7`, i.e. **a forced pair at distance `2√11` over Heule's field spindles into ℚ(√3, √5, √7, √11) — de Grey's field, the one
  6-open field where 5-chromatic material already exists**; `99 → √395`; `11/4 → √10`; `11/9 → √35/3` (K(√5, √35) is 6-open). Derive the
  Heron/glue conditions (M59 §S1) for each: which of these distances admit a spindle at all in the field (the `d ≥ 1/2` clause is trivial;
  the field must hold the rotation's cosine `1 − 1/(2d²)`, always rational, so every one does).
* **D2 — what a five-colour forced pair over a sealed field looks like at the residues.** Its two endpoints reduce to ONE point of
  UD(𝔽₁₁, 2) (M60), so every pulled-back colouring identifies them for free, and forcing is a statement about the graph's colourings that
  are NOT pullbacks. Derive: a graph G over Heule's field forces a `√11`-pair at five colours iff every proper 5-colouring of G agrees on the
  pair; the pullbacks agree automatically; so the question is whether G's colouring space can be confined to (something like) the
  pullbacks — the finite-plane analogue of M57's additive rigidity ("every colouring is a pullback"). State the exact relation between
  "all colourings pull back from the plane" and the forced-pair property: the former implies the latter for every `11 ∣ d²` pair at once,
  and a G whose colourings all pull back is 5-chromatic AND pairwise rigid at every residue-coincident pair. **Is any object we hold
  pullback-rigid at five?** — a decidable question on Heule-510 (its 5-colourings vs the 121-table's translates and rotations, `fpcompel`'s
  harvest), on W at 11 (reduce_K), and on the thickened stages. This is the milestone's central computation and it costs colourings, not
  refutations.
* **D3 — the residue filter as the ask-pruner.** The five-colour forced-pair sweep on any sealed-field object need only ask the pairs with
  `11 ∣ d²` (every other pair is separated by a verified colouring — M60): count them on each object before any solver; the M54/M55 sweeps
  that read 0/0 complete did so over ALL pairs, so their zeros already cover this class — say so, and aim the new asks at objects those
  sweeps never saw (the depth-2 cross-thickened stage, the Heule closure).
* **D4 — the family-keeping dial (the stub's own D1–D2), re-scoped to the sealed fields**: on Heule's field and K(√247) the additive family
  of a thickened stage vs its 5-divisibility, as the secondary localization of where a forced pair can be.

**Phases (proposed; the subplan re-prices).** 0: D1–D3 as exact enumerations on the objects held (a day). A: pullback-rigidity at 11 on
Heule-510, W, the cross-thickened stages; the pruned forced-pair asks on the objects the M54/M55 sweeps never covered (a day). B: if any
object is pullback-rigid or any `11 ∣ d²` pair is forced — HALT AND VERIFY (the jackpot protocol: two encodings, exact geometry, the spindle
built, its field named, the kernel's `Forces.isEmpty_ringHom_of_spindle_radicand_11` instantiated); otherwise the family-keeping dial (the
stub's phase B) on the sealed fields as the standing instrument. Registered predictions to write at opening: P1 no object we hold is
pullback-rigid at five (medium-high — G31's floppiness at the top rung); P2 the depth-2 cross-thickened stage carries ≥ 1 pair at `11 ∣ d²`
(measure); P3 the number of `11 ∣ d²` pairs among a 10,000-point stage is ≲ 1 % of pairs (a 1/11 density heuristic, one norm class of ten).

**Standing rules that bit M61** (so they are not paid again): a property-constrained SAT instance (equivariance, or "every colouring pulls
back") needs AT-MOST-ONE-colour clauses or its models are proper but not the property — always assert the property on the model
(`INSTRUMENT CATASTROPHE` on failure); pysat's wall is inert on big instances — the external cadical under `timeout`; a bare `rw` on an
abbrev has nothing to rewrite (`show`); name an implicit unconstrained by a lemma's conclusion (`(y := b)`); a `Fact` instance before the
spec that needs it; ALWAYS `./scripts/build.sh`; one heavy job; HALT on an unexplained crash; checkpoint anything over fifteen minutes;
every headline names its population and its trust (G21); the bibliography rule.

**Machine and tree at the close:** the desktop (32 cores, 125 GB). Nothing in flight. The working branch is `backlog`, which Kooshi
checked out at the M61 close commit (`main` and `backlog` coincide at `b54942a`); the handoff commit lands on `backlog` — merge or rebase
is his call. Scratch (gitignored): `build/m61/` (`derive.py`, `alpha.py`, the probes, CNFs, logs).

---

## PRIOR ART, ADDED 2026-09-09 (FS-23) — this milestone's design target was posed in 2018, and one instance is already settled

**The Polymath16 project asked FS-6's question, eight years early.** Fourth thread, 2018
(`[Polymath16threads]`, archived at `library/notes/polymath16-threads-1-18-text.txt`), verbatim:

> *"Question. Does `5/3` receive the same color as `0` in every 5-coloring of `R`? These two points are always
> monochromatic for homomorphic colorings, and if this behavior persists for general colorings, then a
> spindling argument implies `χ ≥ 6`."*

That is exactly G48's mechanism and this stub's target: **find a pair forced equal at five colours over a
5-sealed field, spindle it, and the field jumps by itself.** Two things follow, and both are useful.

1. **Their specific instance is dead, and our own theorem kills it.** M60's distance law (ledger row 55) says a
   pair forced equal at five colours over a field where 11 is usable has `11 ∣ d²`. `(5/3)² = 25/9 ≡ 4 ≢ 0
   (mod 11)`. So the behaviour cannot persist to general colourings at `5/3`, over `K` or over any field the
   descent ever used. **The residue law is the filter they did not have** — they were looking at the additive
   ("homomorphic") colourings and had no way to tell which of their forced pairs survive non-additive ones.
2. **So this milestone's first move is now free**: enumerate the residue-ALLOWED distances (`11 ∣ d²` — the
   FS-16 list) *before* any search, and never spend a solver on a distance the law forbids. That is the
   difference between the 2018 question and this one.

**Also relevant to the thickening question itself**: `[Polymath16wiki]`'s ring table records that the Moser
spindle ring is 4-colourable with **all** 4-colourings periodic of period 8, and asks which additional
generators reduce it to linear colourings only — the additive-family-survival question of §B, in the ring
language, in 2018. Read `library/notes/polymath16-algebraic-formulation-2018.txt` before designing the sweep.
