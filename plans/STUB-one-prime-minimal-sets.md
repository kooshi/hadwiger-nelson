# FS-94 — the minimal sets of the one-prime band set (stub)

*Minted 2026-09-25 at FS-91's close (crunch milestone M1) by its close planner (J23a, resumed as J23a2; de Bruijn, Opus 5.5), from J12's
remarks (`plans/FS91-S1D-one-prime.md` §3.3; inventory item 123) and J13's route (`plans/FS91-S1V-one-prime.md` §2.5). Number assigned by the
front-page job (J24); numbered FS-94 there. Written for a session with zero conversation memory. Solver-free.*

## What is known, in plain words

At one split prime `p ≡ 1 (mod 4)`, the ring `R_{{p}} = ℤ[i][1/p]` has band characters at four colours (homomorphisms to the circle keeping
every unit vector in `[1/4, 3/4]`) that are **not** torsion plus archimedean, and the failure is total (`plans/FS91-derivation.md` §6; every
claim two derivations, J12 and its blind check J13):
- **Points** (ONE-a): a heteroclinic character exists at every `p`, gluing the order-3 character on `ℤ[i][1/π̄]` to the parity character on
  `ℤ[i][1/π]` through a `p`-free lens (`√2/6 < 1/4 + 1/12`).
- **Minimal sets** (`MS₄`): at `p = 5` — and at every `p` by J12's route — a closed invariant set, minimal under the unit group, misses
  torsion plus archimedean. **Two constructions:** J12's hierarchy of periodic orbits closed by a two-leaf closing lemma, whose limit is coded
  by a minimal aperiodic **S-adic subshift of continued-fraction kind** (constructive; zero-entropy coding); J13's region `Ω` with two
  admissible blocks from every state, and entropy compression giving a bi-infinite admissible sequence with no ninth power (existence; the
  correspondence has entropy `≥ (log 2)/200` per step).
- **Torsion orders** (ONE-c): unbounded, by two families (J12's `c₀^a0^b`; J13's `b a^p`, orders `≥ 2·5^{p/2}` at 5).
- **The model:** in a rotating frame `Θ₄(U₅)` is the set of bi-infinite orbits in `[−1/4, 1/4]²` of the rotation `ω = (−4−3i)/5` about one of
  nine centres per step, and a character is torsion plus archimedean iff its centre (digit) sequence is periodic.

## The questions

1. **Dimension.** Does J12's minimal set have positive (Hausdorff or topological) dimension? J12's remark leaves it undecided.
2. **Which codings occur.** Is every minimal set off torsion plus archimedean S-adic of J12's continued-fraction kind? Or do J13's two-choice
   regions carry minimal sets of positive entropy — a second kind?
3. **Band 1/5.** The five-colour analogue at one prime: do points, minimal sets and torsion orders fail at `k = 5` as at `k = 4`? (The lens
   and the leaf discs change with the band; FS-89's five-colour corner leaf has radius 1/20.)
4. **Prior art** (the close gate's result 6, `plans/FS91-PA-close.md` §6: "not found as stated"; `[Manners2015]` §5.5 asserts the one-prime
   failure without proof): read Bosio–Vivaldi 2000 (*Round-off errors and p-adic numbers*), Vivaldi 2006 (*The arithmetic of discretized
   rotations*), Adler–Kitchens–Tresser 2001, Akiyama–Pethő 2013, and check `[GrytczukKozikMicek2013]` against J13-L1's use; and search the
   aperiodic-order vocabulary (S-adic subshifts, substitution codings — G62 and FS-63's discipline).

## Why it matters, stated honestly

**Bearing on χ ≥ 6: none.** Every real field's unit-vector ring has infinitely many split primes, where two-prime rigidity applies; the
one-prime set is a model of what the second prime forbids. Its value is mechanism and a clean dynamical object (a piecewise isometry of the
square with nine centres), possibly already classified in the discretized-rotation literature.

## Registered expectations (the stub-writer's guesses)

| id | statement | p |
|---|---|---|
| M-a | J12's minimal set has topological dimension 0 | 0.6 |
| M-b | a minimal set of positive entropy exists (question 2 "a second kind") | 0.4 |
| M-c | all three one-prime failures persist at band 1/5 | 0.55 |

## Routes

Derivation first, on the nine-rotation model; exact arithmetic of seconds only to check a derived claim; a complete enumeration only of a
set a derivation fixes, logged at the ban's edge (to 2026-10-01).

## Provisional bearings

G76 (count the primes; one is not enough), G74 (the reading "disc plus finitely many torsion points" that fired at one prime), G62 and FS-63
(aperiodic order's vocabulary), G49 and G50 (the discretized-rotation literature held unread), G21 (a sampled check is not a witness), G77.

## Addresses

`plans/FS91-derivation.md` §6; `plans/FS91-S1D-one-prime.md`; `plans/FS91-S1V-one-prime.md`; `data/fs91/j12/lemma-statements.md`;
`tools/crunch_j12_*.py`, `tools/crunch_j13_*.py`; `plans/FS89-S0B-band-set.md`; `LEDGER.md` row 97.
