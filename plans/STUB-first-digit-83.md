# FS-40 — The first digit at 83: is UD(𝔽₈₃, 2) six-colourable? (STUB, 2026-09-13; minted at the FS-38 close from the advisor's card, `plans/POROS-2026-09-13-fs38-subplan.md` § The question cards)

*Read beside: `plans/STUB-first-digit-23.md` (FS-17, the same question one colour down, with the priced routes),
`plans/M61-local-global-tightness.md` (the conjecture and its first digit), `CLAUDE.md` G48 and G54, ledger rows 64 and 67,
`data/fplane/spectral-p83.json`, `spectral-p131.json`, `spectral-below-600.json`, `data/fplane/map.md` (the row for K(√7)).*

## 1. Mission context, in plain language

The finite Euclidean plane UD(𝔽₈₃, 2) — 6,889 points, each joined to the 84 points at "unit distance" modulo 83 — is the
first residue plane of the field ℚ(√3,√7,√11): the field is 6-open (no usable prime below 83, because √7 makes 11 inert),
and it is the field in which this project built its own five-chromatic unit-distance graph (the `ρ₆₃` arena, ledger row 64).
The plane's spectrum puts its chromatic number at 6 or more (Hoffman's bound 5.743); nobody has asked whether six colours
suffice. Every other usable prime of the field has a spectral floor of 8 or more (131, 167, 227, 479, 503, 563), so the best
bound any residue plane can give the field's plane is 6 if this plane is six-colourable and nothing below 7 otherwise. The
local–global conjecture (`CLAUDE.md` G48: χ(F²) equals its best local bound wherever that bound is ≤ 6) therefore makes one
computation decisive for what it predicts about the only 6-open field we have built an object in: **six-colourable ⟹ the
conjecture predicts χ(K(√7)²) = 6; not ⟹ it predicts 7.** De Grey's field ℚ(√3,√5,√7,√11), whose usable primes 131 and 479
have floors 8 and 13, is predicted 7 either way.

FS-38 made the question sharper without touching it: the plane at 83 is **slack** at six colours (λ_min ≈ −17.71 against
−84/5 = −16.8), so if a six-colouring exists a six-colouring with a fan gap is the empirical expectation (P-D4's pattern at
7, 11, 19), and then, by ledger row 66 one colour up, every unit-distance graph over a field that 83 seals at six colours is
pairwise free at six colours — a fact decided by 84 lookups once the table exists. Slackness says nothing about whether the
colouring exists; that is this stub's question.

## 2. What we know

| fact | trust | where |
|---|---|---|
| χ ≥ 6 (Hoffman 5.743; Weil floor 6) | a derivation on exact character sums, floats to 1e-12 | `data/fplane/spectral-p83.json` |
| χ ≤ 8 is NOT on record for 83 — the periodic family was measured below 71 only | — | `data/fplane/periodic-below-71.json` (scope) |
| no line-periodic six-colouring: 42 directions degenerate, 42 UNSAT (solver), 0.5 s | the solver's; the positive control at 11 reads `chi_circ = 6` as the instrument should | `plans/POROS-2026-09-13-fs38-subplan.md` § Evidence inventory |
| every other usable prime of K(√7) has floor ≥ 8; de Grey's 131 and 479 have floors 8 and 13 | derivation | `spectral-below-600.json`, `spectral-p131.json` |
| the plane is slack at six colours (λ_min ≈ −17.7 against −16.8) | computed | `plans/FS38-derivation.md` D-3 |
| the `ρ₆₃` arena, 51,133 vertices in K(√7), is exactly 5-chromatic | solver refusals (untrusted) plus a verified colouring | ledger row 64 |

## 3. Derivations first

**D1 — the equivariant ask.** Colourings invariant under the order-84 rotation group up to a colour permutation collapse
the instance to orbits (`fplane.py equivariant`, M61's instrument): minutes. A hit is a verified table and closes the
question; a miss says only that no symmetric six-colouring exists (at 23 the analogous miss was total).

**D2 — the α route.** `card_le_mul_of_colorable` (kernel): a six-colouring needs an independent set of size 1,149 =
⌈6,889/6⌉. Cube-and-conquer on the cardinality instance is the one route whose refusal is a certified χ ≥ 7 modulo the
solver, and whose success needs no colouring search.

**D3 — what each answer means.** Six-colourable: χ(K(√7)²) ≤ 6 by the finite-plane bound (the hand step of M58), the
conjecture predicts 6 there, and the `ρ₆₃` line is the platform where a 6-forcer would confirm its first digit; the
six-colour arity-2 question at 83 is then row 66's theorem one level up. Not six-colourable: the first plane exactly
7-chromatic or more at a 6-open field's first usable prime, the conjecture predicts 7 for K(√7) and for de Grey's field,
and every 6-open field we hold has no residue plane below 7 — the residue method then predicts the plane's own value at
every field this project has built in.

## 4. Phases

| phase | what | cost |
|---|---|---|
| A | the equivariant six-colouring ask at (83, 6); if SAT, verify on all 289,338 edges and keep the table | minutes |
| B | if A misses: α ≥ 1,149 by cube-and-conquer on one hexagon's colourings; direct SAT with a pinned clique | a desktop-day per route, priced as FS-17's |
| C | if six is found: the plane joins the kernel as a 6,889-entry table (or a symmetric one); the fan-gap census (84 lookups per vertex) | a day |

## 5. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | UD(𝔽₈₃, 2) is six-colourable | low-medium — from nothing better than the floor's dip (71 → 7, 83 → 6, 107 → 7) and Hoffman sitting 1.4 below the truth at 11 and 19 |
| P2 | no equivariant six-colouring exists (as at 23 for five) | medium |
| P3 | if a six-colouring exists, one with a fan gap exists | medium — the pattern at 7, 11, 19; the falsifier is a six-colourable plane all of whose six-colourings are gap-free |

## 6. Bearing on 6, honestly

**Medium.** It does not find a 6-forcer. It decides what the conjecture predicts for the one 6-open field we built an object
in, cheaply, and it names the platform: a 6-forcer in K(√7) is consistent with the conjecture only if the plane at 83 is
six-colourable. It is also the six-colour instance of FS-38's whole frame — tight or slack — one level above where the
five-colour question was closed.

## 7. Addresses

`tools/fplane.py` (`equivariant`, `alpha`, `chi --pin-clique`, `theta`), `data/fplane/`, `Proofs/HadwigerNelson/LocalGlobal.lean`
(`card_le_mul_of_colorable`), `Proofs/HadwigerNelson/FanGap.lean` (the six-colour arity-2 question once a table exists).
