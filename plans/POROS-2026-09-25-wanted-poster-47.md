*Poros record, crunch job **J37**, 2026-09-25. The "wanted poster" of a counterexample at one of the conjecture's live walls:
**a four-colouring of the plane over ℚ(√47)**, where the local–global conjecture (G48) predicts exactly five and `4 ≤ χ(ℚ(√47)²) ≤ 5`
is proven. Brief: `data/crunch-2026-09-25/briefs/J37-39-poros-wanted-posters.md` (J37 block), with
`data/crunch-2026-09-25/briefs/STANDING-RULES.md` as part of it. Opus 5.5. No subagents; no finite-witness search (ban to 2026-10-01);
this record (and my report file) are the only files I edit.*

**Owner updates at launch, logged so a successor has them:**
1. Read J36 first (`plans/POROS-2026-09-25-infinitely-many-primes.md` F2–F5, 4.1–4.4) and build the poster on its sharpened forms
   (T-C(A)⁺; rotation averaging at type (A); the Furstenberg remainder; EI-2), not on the literal headline. Test EI-2 in item 6 unless a
   better candidate turns up.
2. `[DuczVarga2026]` already refuted `α₁(ℝ²) = 1/4`, so S1's price on the independence-ratio route is stale (J36 §4.3 R4).
3. Row 88's close is filed (`plans/FS86-row88-rigidity.md` §R-close; `plans/R88-derivation.md`); FS-84 S1's blind check is done
   (`plans/FS84-S1V-verification.md`).
4. A front-page job is editing `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md` now; where something is mid-edit, the close records
   are the source.

## Stage 1 — SAVED: the expectation, written before assembling anything

*Read before writing this: my identity files, the standing rules, the brief, and J36's F1–F8 and 4.1–4.4 (the owner's instruction).
Not yet read: FS-84's plan and stub, S1 and S1V, rows 75/84/92/96 in `LEDGER.md`, `CLOSED-QUESTIONS.md` §1.7, T-C(A) in its two
records. Everything below is written from `CLAUDE.md` items 10 and 14 and J36 only, so that the reading can surprise it.*

**E1 — what the poster will list.** About eight constraints, in three bands:
- *No finite-place structure at all:* not a residue colouring at any prime and any tower level (row 75, `L = 5` at every level); not
  periodic (a periodic colouring is a residue colouring prime by prime); not a character colouring (row 96); not a measurable window
  colouring over finitely many places (row 92).
- *Fractional:* S1's periodic independence ratio `≤ 0.2499972548 < 1/4` (two derivations, at the periodic scope); its GAP at the
  translation-invariant scope.
- *Stationary / spectral:* T-C(A): some translation-invariant measure on the colouring's orbit closure has spectrum on no
  `T + A + Fin_S`; J36's sharpening T-C(A)⁺ (the infinite-type part anticorrelated at unit distance), and at type (A) after rotation
  averaging, at `S = ∅` alone.
- *Measured nulls, kept apart:* row 84's priced-out ball, FS-84's 25 survivors of 127 lattices, no rigid lattice called.

**E2 — redundancy.** I expect T-C(A) to **subsume** rows 92 and 96 and the periodic half of S1: a window colouring over finitely many
places, a character colouring, and a periodic colouring each have a spectral measure carried by some `E_S`, so each is excluded by
T-C(A) directly. If so, the poster has one load-bearing theorem (T-C(A)) and several corollaries, and its independent content is
T-C(A)'s shared inputs (`[AmbrusEtAl2023]`'s `m₁ ≤ 0.2470`, Coxeter's C14 pieces, FS-66 at 11 and 19). *Surprise if:* some row (92 or 96)
was proved by a route that does **not** go through a stationary-ratio count, so that it is independent evidence rather than a corollary.

**E3 — composition: a gap, not one theorem.** Confidence 0.85. The class that evades every constraint is **the four-colourings of
`Cay(R, U)` with no proper factor colouring continuous at finitely many places** — EI-2's failure (J36 §4.1), equivalently colourings
whose every invariant measure has its infinite-type spectral part anticorrelated at unit distance. At the level of spectral measures
this remainder is Furstenberg's zero-entropy question (J36 F5), so it does not close in a week. *Surprise if:* the records hold a lemma
joining S1's fractional count to T-C(A)'s stationary one in a way that already excludes the anticorrelated infinite-type part — then
the poster closes to a theorem.

**E4 — the control.** I expect **no known field or graph** carrying a four-colouring with no finite-place proper factor: every
four-colouring this project can exhibit (residue pullbacks, `[Fischer1994]`'s ℤ/4 colouring, ℚ(√11)'s character colouring, row 92's
windows, J36's noisy colourings) has one. So the gap's class is not known to be non-empty anywhere — the control is missing, and that
absence is itself the poster's most important line. *Surprise if:* some record exhibits a colouring of an abstract abelian Cayley graph
(e.g. `Cay(ℤ, ±{1,3,4,5})`, S1V-7) with no periodic or finite-place factor — that would be the control.

**E5 — the discipline's name.** Symbolic dynamics on a non-finitely-generated abelian group `R ≅ ℤ[1/p : …]`-type: the evasive class
is "free / aperiodic points of a subshift of finite type on `R` with no equicontinuous (Kronecker) factor that is itself a point of the
SFT", i.e. the question whether the SFT `X₄(F)` has a **factor map onto an SFT point over a locally compact completion** — in the
literature's words, whether the shift is *essentially an odometer-type (Toeplitz-like) extension*. Queries will be in "S-adic
odometer", "Toeplitz subshift", "measure rigidity ×p×q", "stationary colouring", "factor of i.i.d.".

**E6 — the example invariant.** EI-2 is the obvious candidate and I expect to keep it, with one refinement: its useful form is on the
**finite-place factor** (a "locality" invariant), and its shadow on the poster is T-C(A)⁺. I expect looking for it to beat closing
the gap directly, because the gap is a Furstenberg wall. Confidence 0.6 that I will not find a better candidate.

**E7 — killing test.** The cheapest way the poster reads stronger than it is: the shared input `m₁(ℝ²) ≤ 0.2470` behind both T-C(A)
derivations — a slip there would drop T-C(A) and with it (under E2) every corollary, leaving rows 92 and 96 only if they have their own
route. Second: a scope slip between "a four-colouring exists" and "a translation-invariant measure on colourings exists with property
P" (amenability and orbit-closure compactness are both needed; I expect both are stated).

**E8 — recommendation, before reading.** Default: a derivation job on EI-2 over the fields where four-colourings exist (ℚ(√11) first),
with its falsifier named; ahead of it, J36-D's SI lemma, because the poster's sharp form rests on it at one mind.
