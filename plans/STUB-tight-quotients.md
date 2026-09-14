# FS-42 — 5-tight quotients of 6-open planes: the one residue route to a five-colour forced pair that FS-38 leaves open (STUB, 2026-09-13; minted at the FS-38 close; a READING with its falsifier)

*Read beside: `CLAUDE.md` ledger rows 66–67, G48, G54; `plans/FS38-derivation.md` D-2 (a) (Theorem D2-A) and D-3 (the
classifier); `plans/M58-field-sieve.md` (which primes are usable where); `plans/M61-local-global-tightness.md` (the
periodic quotient `unitQuadrance_colorable_of_quotient`, `addCayleyMap`); `[Moorhouse2010]` §9; `[Shitov2019]`.*

## 1. Mission context, in plain language

FS-38 closed the six-level's only known mechanism over sealed fields: a residue plane that seals a field at five colours is
slack, and slackness frees every pair. But the same milestone found the case where a residue graph forces pairs — when it is
Hoffman-tight, every k-colouring is periodic under the common kernel of the minimising characters (Theorem D2-A). So there
is exactly one residue-shaped route to a five-colour forced pair left, and it lives in the 6-open fields: map the field's
plane F² onto a finite abelian group by a lattice Λ (not necessarily a prime ideal), take the image S̄ of the unit vectors as
the connection set, and ask whether the Cayley graph Cay(F²/Λ, S̄) is both 5-colourable and 5-tight. If it is, every one of its
5-colourings is H_min-periodic, every pair of F² with difference in the preimage of H_min is forced equal at five colours by
every colouring that factors through the quotient — and, since the plane's colourings need not factor through the quotient,
what is forced in F² is only what the quotient's colourings force; the route then needs a fabric in F² all of whose
5-colourings factor, which is the tower question again. That is the honest shape: a tight quotient names a forced pair *in
the quotient*; G48's spindle over it lands in a field that is still 6-open; whether the forcing descends to a finite
unit-distance graph is the transfer FS-38 showed is one-directional (row 67: freeness transfers, forcing does not).

## 2. What we know

| fact | trust | where |
|---|---|---|
| tight ⟹ forced by H_min ∧ gap-free; slack ⟹ gap ⟹ free | derived / kernel | row 67, row 66, G54 |
| no usable prime above 3 gives a tight plane at any k ≤ 7 (Weil cutoff; the committed table) | computed, with two scope riders | `plans/FS38-derivation.md` P-D5 |
| every usable prime's plane of a 6-open field refuses five colours (from 59 up by the spectrum; 11 and 19 are not usable there) | derived + kernel at 131 | `plans/M58-field-sieve.md`, ledger row 53 |
| `[Moorhouse2010]` §9: a composite ideal cannot beat the minimum over primes without refuting Hedetniemi's conjecture | his argument; **Hedetniemi's conjecture is refuted** (`[Shitov2019]`), so this is not a bar | `BIBLIOGRAPHY.md` |
| the periodic quotient is an instance of `[CervantesKrebs2023]`'s matrix method; `addCayleyMap` is Moorhouse §4.2 | kernel (`unitQuadrance_colorable_of_quotient`) | ledger row 56 |
| forcing inside a Cayley tower transfers nothing to a finite chunk; freeness transfers | derived (row 67, §S4 of the FS-38 plan) | `plans/FS38-derivation.md` D-2 (c) corollary (6) |

## 3. Derivations first

**D1 — which quotients.** A lattice Λ ⊂ O_F² (or of the complex form O_{F(i)}) with finite index; the unit vectors must map to
nonzero elements (else the quotient has a loop and no colouring). Candidates: (a) composite ideals 𝔞 with O/𝔞 not a field —
products of usable primes, and prime powers (the towers, already classified: tight iff level one is); (b) wall-broken 2-adic
quotients where the prime above 2 is not conjugation-stable, so Theorem B's map does not exist but a quotient graph still
does; (c) sublattices that are not ideals. The screen for each is one character sum: λ_min against −d/4.

**D2 — the census shape.** Enumerate small-index quotients of the planes of K(√7), K(√13), de Grey's field; compute the
spectrum; report (index, d, λ_min, −d/4, tight?). Tightness is rare (it failed at every usable prime above 3), so the
expected reading is "none", and the stub is then closed as a direction with its census as the record.

**D3 — if one is tight.** Then ask 5-colourability (a Cayley SAT with the palette symmetry); if five is refused, the quotient
bounds nothing and the tightness is moot; if a 5-colouring exists, every 5-colouring is H_min-periodic — a forced pair in the
quotient, kernel-consumable through `forces_of_tight` (FS-41) — and the question becomes which unit-distance graphs in F²
have all their 5-colourings factoring through the quotient. That last question is the one FS-38 answered "none we hold" for
the 2-adic tower at four colours, and it is where this reading most likely dies.

## 4. Phases

| phase | what | cost |
|---|---|---|
| A | the census of D2 over three 6-open fields, indices up to ~10⁴ | a day |
| B | only on a tight hit: the 5-colouring ask and the H_min forced set | a day |

## 5. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | no small-index quotient of any 6-open plane is 5-tight | medium-high — tightness needs a rational λ_min at a very specific value, and it failed at 18 of 18 usable primes ≤ 149 |
| P2 | if one is tight, it refuses five colours | medium |

## 6. Bearing on 6, honestly

**Medium-low, a reading.** It is the only residue-shaped route the fan-gap theorem leaves open, and the honest expectation
is that its census closes it. Its value is that closing it would say: the residue method — level one, towers, quotients —
names no five-colour forced pair anywhere, sealed or 6-open, and a 6-forcer's compulsions must come from elsewhere (FS-2's
Kempe classes, or a mechanism not yet named). The falsifier is exact: the candidates' spectra computed and none 5-tight,
or every 5-tight candidate refusing five colours.

## 7. Addresses

`tools/fplane.py` (spectra; a `quotient` subcommand to write), `build/fs38-d/fpspec.py` (the character-sum screen, gitignored
scratch), `Proofs/HadwigerNelson/LocalGlobal.lean` (`addCayleyMap`, `unitQuadrance_colorable_of_quotient`), FS-41's
`forces_of_tight`.
