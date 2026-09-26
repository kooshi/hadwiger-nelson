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

## Stage 2 — SAVED: quotation check and evidence inventory (read against Stage 1)

### 2.1 Quotation check (standing rule 5)

| # | the brief or the launch message says | the source says | verdict |
|---|---|---|---|
| Q1 | "a four-colouring of ℚ(√47)'s plane, if one exists, has a translation-invariant measure whose spectrum reads infinitely many primes. That result is T-C(A)" | `plans/R88-derivation.md` R88-TCA: "a four-colouring of ℚ(√47)'s plane, if one exists, has an invariant measure on its orbit closure whose spectrum is carried by no `T + A + Fin_S`" | **wider than the source.** "Carried by no `E_S`" admits J28D's case R1 (carried by `⋃_S E_S`, every character reading finitely many split places). "Reads infinitely many primes" is true only after rotation averaging (J36 F4, one mind). The poster below uses the source's words |
| Q2 | "Independent random noise on gapped colourings over ℚ(√11) already puts the spectrum off every T + A + Fin_S (F2)" | J36 F2: "the *literal* counterexample invariant — a spectral measure carried by no `T + A + Fin_S` — is realised by **noise on a finite-place colouring**, at any field with a gap" | agrees (J36 F2 is [hand, one mind; a construction]) |
| Q3 | "T-C(A)⁺: a ℚ(√47) counterexample's infinite-type spectral part must be anticorrelated at unit distance (F3, a sketch by one mind)" | J36 F3: "some `u ∈ U` has `∫_{R̂∖E_S} Re χ(u) dσ_μ(χ) < 0`", graded "[hand, one mind, sketch — for a derivation job]" | agrees; note "for every `μ` and every finite `S`" is part of the statement |
| Q4 | EI-2: "every four-colouring has a proper factor colouring continuous at finitely many places" | J36 §4.1: "every translation-invariant four-colouring has a factor that is itself a proper four-colouring and is continuous in probability at finitely many places" | **narrower object in the source**: EI-2 is about translation-invariant random colourings (measures), not deterministic ones. Used below at the source's scope |
| Q5 | "[DuczVarga2026] already refuted α₁(ℝ²) = 1/4" | `BIBLIOGRAPHY.md` l.182: "`χ_f(ℝ²) > 4` strictly, their Conjecture 1 is disproved, and there is a finite unit-distance graph with independence ratio below `1/4`"; its graph `G29` has points involving `√5` and `η = i√((415 + 79√33)/8)` | agrees in substance; the graph is not in ℚ(√47)² |
| Q6 | "The conjecture predicts exactly five; four is proven (`4 ≤ χ ≤ 5`)" | `CLAUDE.md` item 10; row 84 "Not claimed: `χ(ℚ(√47)²) = 5`, or `≤ 4`" | agrees |

### 2.2 Evidence inventory

- **Row 96, C-47** (`LEDGER.md` l.123; FS89-CL4; re-proved through CLG, row 100, J07-13 and J10-T5) — read against: E2, "a corollary of T-C(A)" — surprised: **yes.**
  Row 96 rests on "Lemma R and Weil — fewer inputs than FS86-CL1 (no `[AmbrusEtAl2023]`, no FS-66, no Zhang)". It is not a corollary of
  T-C(A). A character colouring `⌊4θ⌋` with `θ ∉ E` has spectrum on `ℤθ ∖ 0`, and `ℤθ ∖ 0` misses `E` (a divisibility check: `E_S` is
  divisible and holds all torsion). So it lies **inside** T-C(A)'s evasive class, and row 95's band rigidity is what removes it. **Row 95 is
  the one theorem on the poster that reaches into the evasive class.**
- **Row 92, the ℚ(√47) clause** (l.119) — read against: E2, "subsumed by T-C(A)" — surprised: no. T-C(A) is "FS86-CL1's count moved from
  measurable windows to invariant measures" (R88-TCA). The two share the count and `[AmbrusEtAl2023]`.
- **S1a / S1V-4, not periodic** (`plans/FS84-S1-derivation.md` §1.4; S1V table) — read against: E2, "a corollary" — surprised: **partly.** It
  is logically a corollary, but its route is independent: "Does not rest on: `[AmbrusEtAl2023]`", two derivations. So "not periodic"
  survives a failure of the shared input.
- **S1b-i, ii, iii** (§2.2 there; S1V-5) — read against: E1, "a GAP at translation-invariant scope" — surprised: **yes, twice.** (a) The
  equivalence is proved: four-colourable ⟺ an invariant random four-colouring exists (two derivations for i–ii). (b) S1b-iii puts a **field**
  line on the poster that I had not listed: `ι(ℚ(√47)) = inf_H α(H)/|H|`, so a counterexample needs **every finite unit-distance graph in
  ℚ(√47)² to have independence ratio ≥ 1/4**. With Q5, ℝ² violates this; whether ℚ(√47)² does is open, and G60's cap (`χ_f(Γ₁₁) = 121/28 ≈
  4.32`) does not decide it.
- **T-C(A)** (J28D §3.3, J28V §2.2, R88-TCA) — read against: E7's inputs list — surprised: no. Inputs: `[AmbrusEtAl2023]`, FS-66 at 11
  and 19, Lemma P, C14 window lemmas; the split dyadic step C14.2 (c) at `q = 2` rests on J28V's and M3's derivations.
- **Row 75 and CLOSED-QUESTIONS §1.7** — read against: "no residue target at any depth" — surprised: no. §1.7 adds a posed question:
  Moorhouse's "What about `χ(ℚ(√47)²)`?".
- **Row 84** (l.111) — read against: E1's "measured nulls" — surprised: **yes, in kind.** Besides the 25 survivors (nulls), it holds **102
  certified four-colourable lattices**. These are positive facts about finitely generated pieces, which constrain nothing about a colouring
  of the whole ring. They matter as a control of a different kind (Stage 3, C4).
- **Rows 97, 102** (one prime) — read against: E4, "no control exists" — surprised: no, after a check. At one split prime, band characters
  off `T + A` exist. But `ℤ[i][1/p]` is a cocompact lattice in `ℂ × ℚ_p²`, so every one of its characters is continuous at that place: they
  sit in `Fin_{{p}}`, not in the evasive class. They are controls for "reads a split place", not for "reads infinitely many".
- **Row 98** (band rigidity at every band) — read against: nothing (not listed in E1) — surprised: **yes.** With Steinhaus it extends row 96
  from `⌊4θ⌋` to every measurable circle window `W(θ(x))` (Stage 3, T-J37-1).
- **FS-84 §IQ** (`plans/FS84-five-colours-47.md` §4.1) — read against: E6 — surprised: no. It names "joint window frequencies" (the
  invariant measure) as the forced invariant, and "P-int′: five-chromatic with `χ_f ≤ 4`" as unscored.
- **`plans/PA-ambrus2023-audit.md`** — read against: E7, "the shared input is the weak point" — surprised: no, and it is sharper than I
  expected. H4 (the Bessel obligation) is checked "in double precision … not interval-certified; worst margin 2.3·10⁻⁶".
- **The conditions of the last reading** — J36 read T-C(A) in one session, with its brief's headline in hand. Its F2 already flagged the
  literal headline, so its sharpenings were made against the right scope.

### 2.3 Would-have-searched-here log (Stages 1–2)

- Would have searched a finite ℚ(√47) graph for `α(H) < |H|/4` (a Dúcz–Varga-type graph in the field). Instead: recorded it as a
  post-ban construction problem (Stage 4, R3).
- Would have enumerated small lattices for a four-colourable `Λ` with `Θ₄(Λ) = ∅` (S1V's GAP). Instead: left it on EI-1's line, unchanged
  from J36.
