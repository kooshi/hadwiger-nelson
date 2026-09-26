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

## Stage 2 — SAVED: quotation check and inventory of the record (read against Stage 1)

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

- **Row 96, C-47** (`LEDGER.md` l.123; FS89-CL4; re-proved through CLG, row 100, J07-13 and J10-T5) — read against: E2, "a corollary of T-C(A)" — surprised: yes
  Row 96 rests on "Lemma R and Weil — fewer inputs than FS86-CL1 (no `[AmbrusEtAl2023]`, no FS-66, no Zhang)". It is not a corollary of
  T-C(A). A character colouring `⌊4θ⌋` with `θ ∉ E` has spectrum on `ℤθ ∖ 0`, and `ℤθ ∖ 0` misses `E` (a divisibility check: `E_S` is
  divisible and holds all torsion). So it lies **inside** T-C(A)'s evasive class, and row 95's band rigidity is what removes it. **Row 95 is
  the one theorem on the poster that reaches into the evasive class.**
- **Row 92, the ℚ(√47) clause** (l.119) — read against: E2, "subsumed by T-C(A)" — surprised: no. T-C(A) is "FS86-CL1's count moved from
  measurable windows to invariant measures" (R88-TCA). The two share the count and `[AmbrusEtAl2023]`.
- **S1a / S1V-4, not periodic** (`plans/FS84-S1-derivation.md` §1.4; S1V table) — read against: E2, "a corollary" — surprised: yes (partly) It
  is logically a corollary, but its route is independent: "Does not rest on: `[AmbrusEtAl2023]`", two derivations. So "not periodic"
  survives a failure of the shared input.
- **S1b-i, ii, iii** (§2.2 there; S1V-5) — read against: E1, "a GAP at translation-invariant scope" — surprised: yes (a) The
  equivalence is proved: four-colourable ⟺ an invariant random four-colouring exists (two derivations for i–ii). (b) S1b-iii puts a **field**
  line on the poster that I had not listed: `ι(ℚ(√47)) = inf_H α(H)/|H|`, so a counterexample needs **every finite unit-distance graph in
  ℚ(√47)² to have independence ratio ≥ 1/4**. With Q5, ℝ² violates this; whether ℚ(√47)² does is open, and G60's cap (`χ_f(Γ₁₁) = 121/28 ≈
  4.32`) does not decide it.
- **T-C(A)** (J28D §3.3, J28V §2.2, R88-TCA) — read against: E7's inputs list — surprised: no. Inputs: `[AmbrusEtAl2023]`, FS-66 at 11
  and 19, Lemma P, C14 window lemmas; the split dyadic step C14.2 (c) at `q = 2` rests on J28V's and M3's derivations.
- **Row 75 and CLOSED-QUESTIONS §1.7** — read against: "no residue target at any depth" — surprised: no. §1.7 adds a posed question:
  Moorhouse's "What about `χ(ℚ(√47)²)`?".
- **Row 84** (l.111) — read against: E1's "measured nulls" — surprised: yes Besides the 25 survivors (nulls), it holds **102
  certified four-colourable lattices**. These are positive facts about finitely generated pieces, which constrain nothing about a colouring
  of the whole ring. They matter as a control of a different kind (Stage 3, C4).
- **Rows 97, 102** (one prime) — read against: E4, "no control exists" — surprised: no, after a check. At one split prime, band characters
  off `T + A` exist. But `ℤ[i][1/p]` is a cocompact lattice in `ℂ × ℚ_p²`, so every one of its characters is continuous at that place: they
  sit in `Fin_{{p}}`, not in the evasive class. They are controls for "reads a split place", not for "reads infinitely many".
- **Row 98** (band rigidity at every band) — read against: nothing (not listed in E1) — surprised: yes With Steinhaus it extends row 96
  from `⌊4θ⌋` to every measurable circle window `W(θ(x))` (Stage 3, T-J37-1).
- **FS-84 §IQ** (`plans/FS84-five-colours-47.md` §4.1) — read against: E6 — surprised: no. It names "joint window frequencies" (the
  invariant measure) as the forced invariant, and "P-int′: five-chromatic with `χ_f ≤ 4`" as unscored.
- **`plans/PA-ambrus2023-audit.md`** — read against: E7, "the shared input is the weak point" — surprised: no, and it is sharper than I
  expected. H4 (the Bessel obligation) is checked "in double precision … not interval-certified; worst margin 2.3·10⁻⁶".
- **The last reading's conditions** (J36) — read against: made under the brief's headline, it carries its scope — surprised: no.
  (`plans/POROS-2026-09-25-infinitely-many-primes.md`.) J36 read T-C(A) with its brief's headline in hand, but its F2 already
  flagged the literal headline, so its sharpenings were made against the right scope.

### 2.3 Would-have-searched-here log (Stages 1–2)

- Would have searched a finite ℚ(√47) graph for `α(H) < |H|/4` (a Dúcz–Varga-type graph in the field). Instead: recorded it as a
  post-ban construction problem (Stage 4, R3).
- Would have enumerated small lattices for a four-colourable `Λ` with `Θ₄(Λ) = ∅` (S1V's GAP). Instead: left it on EI-1's line, unchanged
  from J36.

## Stage 3 — SAVED: the poster, and its composition

*Notation (J36 and the row-88 records): `R = ℤ[U]` for `F = ℚ(√47)`; `X₄(F)` the proper four-colourings of `Cay(R, U)` (one per
`R`-coset of `F²`, so colouring `F²` is colouring `Cay(R, U)`); `σ_μ` the trace spectral measure of the tetrahedral embedding;
`E_S = T + A + Fin_S` (torsion, archimedean, continuous at the finite set `S` of split places); `E = ⋃_S E_S`.*

### 3.1 The poster — theorems (one row per constraint on a four-colouring `c` of ℚ(√47)²)

| # | the constraint, verbatim | scope | grade | address | instrument |
|---|---|---|---|---|---|
| P1 | "no level at 11 or 19 is four-colourable" (row 75); "the four-colour sign at ℚ(√47)'s usable primes refuses at 23, 31, 43" (row 84, T25); "the tower's Hoffman ratio is `L/(p+1+L)` … at every level" (S1a-P); the dyadic place "is split" (J28D §3.3) | every stable place of ℚ(√47, i), every tower level; so `c` is a residue colouring at no place and no depth | [cert + hand] at 11, 19; [tools exact] at 23, 31, 43; [hand, two derivations] for every level | `LEDGER.md` rows 75, 84; `plans/FS84-S1-derivation.md` §1.3 step 7 | residue maps; Hoffman; FS-66's all-levels certificates |
| P2 | "No proper four-colouring of `Cay(R, U)` is invariant under a finite-index subgroup `L ≤ R`." | every finite-index period | [hand + cert + tools exact; two derivations (S1, S1V blind)]; **no `[AmbrusEtAl2023]`** | S1 §4.3 claim 2; S1V-4 | Zhang's product rule over the stable places; Hoffman; weak approximation |
| P3 | "ℚ(√47)'s plane has no character four-colouring (`Θ₄ = ∅`)" | every `θ ∈ R̂`, colouring `x ↦ ⌊4θ(x)⌋` | [hand; two derivations (FS89-CL4; re-proved through CLG, J07-13 and J10-T5)]; **no `[AmbrusEtAl2023]`** | rows 96, 100 | Berend-type closed-set rigidity (rows 95, 98), then a Weil count |
| P4 | "no measurable window four-colouring exists at all" (over ℚ(√47)), with the dyadic split place allowed (row 110's correction) | windows reading finitely many places measurably, proper off a null set (C14′) | [hand, two derivations]; rests on `[AmbrusEtAl2023]` | rows 92, 110 | FS86-CL1's count: a measurable Zhang product rule |
| P5 | **T-J37-1** (this record, §3.4): no four-colouring `x ↦ W(θ(x) + t)`, `θ ∈ R̂` arbitrary, `W : ℝ/ℤ → [4]` measurable, proper for almost every `t` | one character of any type, any measurable circle window | [hand, one mind; a composition of Steinhaus, row 98 and T-C(A) at `S = ∅`]; rests on `[AmbrusEtAl2023]` when `θ` has an archimedean part | §3.4 | band rigidity at every band (row 98) |
| P6 | "If `G` is amenable: `Γ` is `k`-colourable ⟺ `Col_k(Γ)` carries a `G`-invariant Borel probability measure", with `G` the group of translations, rotations, reflections and the Galois flip | the existence of `c` is equivalent to that of an invariant random colouring | [hand; two derivations (S1b-i; S1V-5, which also shows amenability is load-bearing)] | S1 §2.2, §2.3 item 1 | Følner averaging (Markov–Kakutani) |
| P7 | **T-C(A):** "no translation-invariant Borel probability on `X₄(F)` has spectral measure carried by `T + A + Fin_S` for a finite set `S` of split places, dyadic ones included; so a four-colouring of ℚ(√47)'s plane, if one exists, has an invariant measure on its orbit closure whose spectrum is carried by no `T + A + Fin_S`" | translation-invariant measures; each finite `S` separately | [hand; two derivations at ℚ(√47), J28D and J28V blind]; rests on `[AmbrusEtAl2023]`, FS-66 at 11 and 19, Lemma P, C14.1–C14.3, C14.2 (c) at `q = 2` (J28V and M3) | R88-TCA in `plans/R88-derivation.md` | the stationary Zhang count on the completion `G_S` |
| P8 | **T-C(A)⁺:** "for every translation-invariant `μ` on `X₄(F)` and every finite `S`, some `u ∈ U` has `∫_{R̂∖E_S} Re χ(u) dσ_μ(χ) < 0`" | as P7 | [hand, one mind, sketch] | J36 F3 (Lemma SI) | the tetrahedral inner product, spectral projections |
| P9 | **Rotation-averaged:** "a four-colouring of ℚ(√47)'s plane, if one exists, has an `R ⋊ U`-invariant measure … whose `U`-invariant spectral measure satisfies `∫_{R̂∖E} Re χ(1) dσ < 0`"; uses T-C(A) only at `S = ∅` | `R ⋊ U`-invariant measures | [hand, one mind, sketch] | J36 F4 (Lemma R-U) | a wandering action at split places |
| P10 | "`ι_G = inf_H α(Γ[H])/|H|`" with `ι_G ≥ 1/k` for `k`-colourable `Γ`: **every finite unit-distance graph `H ⊂ ℚ(√47)²` has `α(H) ≥ |H|/4`** | the field, not the colouring | [hand; S1b-ii two derivations, S1b-iii one] | S1 §2.2; S1V-5 | Følner blow-up (`[MatolcsiEtAl2025]`'s mechanism) |

*Context, not constraints:* `χ(ℚ(√47)²) ≥ 4` (row 82), so `c` uses exactly four colours; the plane has no triangles (G57) and is
`K_{2,3}`-free (S1d-K).

### 3.2 Kept apart — measured nulls and readings (these constrain nothing)

| # | item | kind | address |
|---|---|---|---|
| N1 | 25 of 127 candidate lattices survive capped screens, 10 minimal; "none called rigid, none with an additive four-colouring" | measured null (capped screens) | row 84 |
| N2 | no band character of order dividing 168, or of stable prime order ≤ 47, on the ten minimal survivors | tools exact, but a statement about ten lattices; at the field level row 96 already says more | S1c |
| N3 | the ratio route's "price": P-int 0.03, "as hard as refuting a published conjecture" | **stale** (Q5; J36 R4) | S1 §2.3 item 3 |
| Rd1 | "for all colourings the obstruction is the real place" | [reading] | G76 |
| Rd2 | the finite-place product principle | [reading] | J36 F6 |

### 3.3 Composition

**(a) Do the theorem rows add up to one statement?** They add up to this, and no further:

> *If ℚ(√47)² is four-colourable, then it carries an `R ⋊ U`-invariant random four-colouring (P6), and every translation-invariant
> random four-colouring of it has spectrum carried by no `T + A + Fin_S` (P7); and no four-colouring is a residue, periodic, character,
> one-character measurable-window or finite-place measurable-window colouring (P1–P5).*

Grade: [hand, two derivations] except P5 (one mind). It rests on `[AmbrusEtAl2023]` for P4, P5 and P7. It does **not** decide
`χ(ℚ(√47)²)`: every row names a class the colouring avoids, and none says the classes exhaust the colourings.

**(b) The gap, named.** The class that evades every row is **the translation-invariant random four-colourings of `Cay(R, U)` with no proper
factor colouring continuous at finitely many places** — EI-2's failure. By J36's Lemma SI (one mind), this is the same as saying that for
every `S`, the part of `σ_μ` off `E_S` is anticorrelated at some unit vector. As deterministic colourings: colourings of the plane that are
not measurable functions of any locally compact completion of `R`. The gap has two layers, told apart by the method that could reach each:
- **The pure-point layer** (colourings `x ↦ W(Θ(x) + t)` for a homomorphism `Θ : R → K` into a compact group, `W` measurable): FS-64's
  adelic windows over infinitely many places are here. **Rank one is closed** (P5). **Rank `n ≥ 2` is open.** Its natural statement, "`Θ(U)`
  avoids a neighbourhood of 0 in `T^n` ⟹ `Θ ∈ (T + A)^n`", is **false**: take `Θ = (θ₁, θ₂)` with `θ₁` arbitrary and `θ₂` a band character.
  The right statement is a selection — `W` can be replaced by a proper window reading only the `(T + A)`-coordinates. That is the pure-point
  case of EI-2 (§3.3 (d), J1). The method is closed-set (Berend), not measure rigidity.
- **The continuous layer.** After rotation averaging (P9), an atom of the `U`-invariant `σ` has a finite `U`-orbit. Its stabiliser `u ≠ 1`
  makes the character vanish on `(u − 1)R`, an ideal of finite index (Levitz–Mott, row 88's J28V-7), so the atom is torsion. So off `E` the
  averaged spectrum is **atomless**. This is J36 F5's Furstenberg-type measure question, with `T` in the role of the finitely supported
  measures. Averaging turns a pure-point colouring's spectrum continuous, so this layer is not disjoint from the first: the first is the
  part a closed-set method can reach **before** averaging.

**(c) Is the gap known to be non-empty for a related field or graph (a control)?** **No, nowhere.** This is the poster's most important
line.
- **C1. Every four-colouring any record exhibits has a finite-place proper factor:** residue pullbacks and `[Fischer1994]`'s ℤ/4 colouring
  over K (row 89); pullbacks over the type-(B) fields; C9 over ℚ(√11) (spectrum in `T + A`, row 94); J36 F2's noisy colourings (the
  finite-place colouring survives as a factor); the random shift of a two-colouring over row 94's quartic.
- **C2. The one-prime objects of rows 97 and 102** (band characters off `T + A`, a minimal aperiodic S-adic set) are continuous at their one
  place (`ℤ[i][1/p]` is cocompact in `ℂ × ℚ_p²`), so they lie in `Fin_{{p}}`, not in the gap. They show that one split place can be read
  essentially; they do not show that infinitely many can.
- **C3. The finite pieces** (an exact tally of seconds on the existing certificate log `data/fs81/phaseD/d47/K1-checker-run.txt`):
  - Row 84's 177 certified four-colourings of 102 finitely generated lattices over ℚ(√47) are of these kinds: 73 additive into ℤ/4; 11
    periodic mod `4Λ` or `8Λ`; 36 residue at the ramified 47 (images of 8–20 of its 48 circle points) and 4 at a stable place above 67 (20 or 28 of 68), each through an image smaller than the full residue
    circle; 22 residue at the split primes 17, 37, 53 and 61; 31 linear forms (characters of the lattice, orders 2 to about `3·10¹⁵`).
  - **Every kind dies in the whole ring by a theorem on the poster, or by the ring's arithmetic.** The dyadic kinds die because
    `1/2 ∈ R` (G35), the split-prime residues because `R` inverts those primes, the stable residues by P1 once the image fills the circle,
    and the linear forms by P3.
  - So the pieces are four-colourable only through places or images that the limit removes. This is the finite shadow of P7 and row 95
    [reading; the tally is exact]. It is also a control of a kind: a counterexample would have to be a limit of piece-colourings of none
    of these kinds, or a limit that no fixed place survives.

**(d) Redundancy, and where constraints almost meet.**
- **Logically** P1 ⊂ P2 ⊂ P4 ⊂ P7: a residue colouring is periodic, a periodic colouring is a finite-place window, and a window's
  random placement has spectrum in some `E_S`. P3's `T + A` half and P5 reduce to P7 once `θ` is known to lie in `T + A`.
- **Evidentially they are not redundant.**
  - P2 and P3 avoid `[AmbrusEtAl2023]`; P4, P5 and P7 rest on it.
  - P3's other half, row 95, is the **only** theorem that enters the evasive class: it removes the character colourings whose `θ` reads
    infinitely many split places, which P7 cannot see.
  - If the shared input failed, the poster would keep "not residue, not periodic, not a character colouring" and lose every window and
    stationary line.
- **J1 (P5 and P7 almost meet on the pure-point layer).** The joining lemma, **Kronecker selection**:
  - *Statement:* "Let `Θ : R → T^n` and `W : T^n → [4]` measurable with `W(t) ≠ W(t + s)` for a.e. `t` and every `s ∈ cl Θ(U)`. Then there is a
    measurable proper window `W′` on the closure of the image of `Θ`'s `(T + A)`-coordinates."
  - At `n = 1` it is P5's step (row 98).
  - Its tool is row 109's mixing selection: delete the coordinates whose characters have Fourier coefficients below `1/3` on a measure
    on `cl Θ(U)`. The missing input is an equidistribution statement for the `U`-values of an infinite-type character — stronger than band
    rigidity, which only says they are not confined to a band.
- **J2 (P10 and P7 almost meet on single classes).**
  - P7 bounds the stationary ratio of each locally compact completion. P10 says the invariant ratio of the whole ring is
    `inf α(H)/|H|`.
  - The join is a **fractional local–global principle**: `ι(F²) = max(m₁(ℝ²), max_stable r_v)` — J36 F6's killing test, read the other
    way. At ℚ(√47) it would give `ι < 1/4`, hence five, with no colouring structure at all.
  - It is not small. For `F = ℝ` it would say `α₁(ℝ²) = m₁(ℝ²)`, which no record claims. But `[DuczVarga2026]` moves its price: the plane's
    ratio is already below 1/4.
- **J3 (P3 and four-colourability of pieces).** This is S1V's GAP / J36's EI-1, unchanged.

### 3.4 T-J37-1, with its proof [hand, one mind; a composition]

> **T-J37-1.** Over ℚ(√47) there is no proper four-colouring of the form `c_t(x) = W(θ(x) + t)` with `θ ∈ R̂`, `W : ℝ/ℤ → {0,1,2,3}`
> Lebesgue measurable, and `c_t` proper for almost every `t ∈ ℝ/ℤ`.

*Proof.*
1. Put `A_j = W⁻¹(j)`. For `u ∈ U`, properness of `c_t` on the edge `{0, u}` for a.e. `t` gives `|A_j ∩ (A_j − θ(u))| = 0` for every `j`.
   By continuity of translation in `L¹`, `f_j(s) = |A_j ∩ (A_j + s)|` is continuous and vanishes on `cl θ(U)`.
2. Some `A_j` has `|A_j| ≥ 1/4`, so `f_j(0) > 0` and `f_j > 0` on some `(−δ, δ)` (Steinhaus). Hence `θ(U) ⊆ [δ, 1 − δ] + ℤ`.
3. With `k ≥ 1/δ`, `θ ∈ Θ_k(R_F)`, so by row 98 `θ ∈ T_{N_k}(R_F) + A(R_F) = E_∅`.
4. The random placement (`t` Haar) is a probability on `X₄(F)`. It is supported there because countably many edges are each proper for a.e.
   `t`. It is translation-invariant, because translating by `y` moves `t` to `t + θ(y)`. Its spectral measure is carried by `ℤθ ⊆ E_∅`,
   since `x ↦ g(c_t(x))` is a function of one circle rotation.
5. T-C(A) at `S = ∅` excludes it. ∎

*Inputs:* row 98 (two blind readings); T-C(A) (two derivations; `[AmbrusEtAl2023]` when `θ`'s archimedean part is non-zero, otherwise S1a
suffices). *Scope:* four colours, ℚ(√47), one character, any measurable window. *Consequence:* FS-64's windowed one-character case is
closed at ℚ(√47). Row 96 closed the windowless case.
*Not claimed:* rank ≥ 2 (J1); five colours (the count fails at the real place).
*Control:* over ℚ(√11) the theorem must fail, and does: C9 is `⌊4θ⌋` with `θ ∈ T + A`, and step 5 fails there (the stable 7 has ratio `2/7`).

## Stage 4 — SAVED: the name, the killing test, the example invariant, the recommendation, the ledgers

### 4.1 In its discipline's words, and the queries a prior-art job should run (not run here)

**The object.** `X₄(F)` is a **hom-shift** — the subshift of `{0,1,2,3}^R` of graph homomorphisms `Cay(R, U) → K₄` — on the countable
abelian group `R`. `R` is not finitely generated; it is a ring of `S`-integers with `S` infinite. A translation-invariant measure on the
hom-shift is an **invariant random proper colouring** (a *stationary colouring* in probability).

**The gap, for a stranger.** *Does the four-colour hom-shift of this Cayley graph carry an invariant measure with no factor onto a proper
colouring that is a model set — a measurable function of a cut-and-project scheme whose internal space is locally compact?*
- The pure-point layer is the theory of **model sets and pure point dynamical spectrum**. There, pure point spectrum is characterised by
  regular model sets (recalled, not read: Baake–Lenz–Moody 2007). The question becomes whether the internal space can be taken to be the
  completion of `R` at finitely many places.
- The continuous layer is **Furstenberg's ×p×q measure problem on an `S`-adic solenoid** (J36 F5), with `T` playing the finite orbits.

**The example invariant in these words.** EI-2: "every invariant random proper four-colouring of a field plane factors onto a model-set
colouring with locally compact internal space".

**Queries**, each tagged with its discipline:
1. *Aperiodic order:* "model set" & "pure point" & ("p-adic" | "adelic") & "internal space"; "Toeplitz" & "cut and project" & "S-integers";
   Baake–Moody weighted and adelic model sets; Sing's p-adic internal spaces.
2. *Symbolic dynamics:* "hom-shift" & "invariant measure" & "abelian group" (not ℤ^d); "frozen" & "proper colourings" & "non-finitely
   generated".
3. *Probability:* "finitely dependent" & "coloring" (Holroyd–Liggett; four-colourings of ℤ that are stationary but not block factors);
   "factor of i.i.d." & "proper coloring" & "abelian".
4. *Measure rigidity:* "S-adic solenoid" & "invariant measures" & "commuting automorphisms" (Einsiedler–Lindenstrauss 2003, Lindenstrauss's
   survey); "×p ×q" & "S-integers" & "Fourier".
5. *Descriptive combinatorics:* "Borel chromatic number" & "Cayley graph" & "countable abelian group" (Kechris–Marks survey, Weilacher);
   whether a Borel or measurable four-colouring of `Cay(R, U)` with respect to a free action is a Borel-Hedetniemi instance (row 109's frame).
6. *Fractional, for J2 and EI-F:* zbMATH `ab:"fractional chromatic number" & ab:"measurable" & ab:"unit distance"`; "independence ratio" &
   "measurable independence" & "equal" (is `α₁(ℝ²) = m₁(ℝ²)` posed?); `[Johnson2000]` and Johnson 2000 (Geombinatorics 9(3)).
7. *The question by name:* Moorhouse's "What about `χ(ℚ(√47)²)`?" — the citation graph of `[Moorhouse2010slides]` and of `[DuczVarga2026]`.

### 4.2 The killing test

**KT-1, cheapest and sharpest.**
- *Target:* `[AmbrusEtAl2023]`'s continuous obligation H4. It is P4's, P5's and P7's one external, computer-assisted input, and it is
  shared with row 92 and T-C.
- *Current state:* checked "in double precision … not interval-certified; worst margin 2.3·10⁻⁶" (`plans/PA-ambrus2023-audit.md` Stage 3,
  H4c).
- *The test:* evaluate J26's own covering (`tools/j26_ambrus_check.py`'s points and derived Lipschitz constants) in ball arithmetic.
  This is an exact check of an existing certificate, allowed under the ban, and costs minutes.
- *If it fails,* the poster keeps P1–P3, P6 and P10 and loses every window and stationary line. The composition in §3.3 (a) would then
  read "not residue, not periodic, not a character colouring" only.
- *If it passes,* those three rows move from "external, double precision" to [cert] on their shared input.

**KT-2, scope (already visible).** P7 does not say "reads infinitely many primes" (Q1). Only P9 does, at one mind, and P9 is being derived
now by J45/J46. **Until J45/J46 land, the poster's sharpest line with two derivations is P7, and P7's literal content is cheap.** J36 F2's
noise realises "carried by no `E_S`" over ℚ(√11). The content sits in P8/P9, at one mind.

**KT-3, grade on the way.** The brief's "two independent derivations proved … whose spectrum reads infinitely many primes" merges P7's
grade with P9's scope. Report them as two rows.

### 4.3 Flip the poster: the example invariant

**(a) EI-2, kept, with its first rung made testable.**
- *The property* (J36 §4.1): "every translation-invariant four-colouring has a factor that is itself a proper four-colouring and is
  continuous in probability at finitely many places".
- *Every colouring we can prove exists carries it* (§3.3 (c), C1 and C3).
- *Its shadow on the poster is P8* (T-C(A)⁺). P8's counterexample invariant is exactly EI-2's failure, by Lemma SI (one mind; J45/J46 are
  deriving it).
- *Held by all colourings, it empties the class:* with P7, `χ(ℚ(√47)²) = 5`.
- *Restricted to ℚ(√47) it is the goal restated* (J36's caution). Its value lies in proving it where colourings exist: ℚ(√11), ℚ(√23), the
  type-(B) fields, K.
- **New here: its pure-point rung is Kronecker selection (J1),** a closed-set statement reachable by rows 95/98's method with no measure
  rigidity. Rank one is P5. **So the part of EI-2 that avoids Furstenberg is named, and its first case is proved.**

**(b) A second candidate, EI-F, the single-class form: *a field plane's invariant independence ratio is its largest local stationary
ratio*, `ι(F²) = max(m₁(ℝ²), max_stable r_v)` (split places contributing 0).**
- *The easy half:* `ι ≥ max_v r_v` always holds, because a local stationary independent set pulls back.
- *The content is `ι ≤ max_v r_v`:* finite unit-distance graphs in `F²` witness every local ratio.
- *Examples:* K, where `ι(K²) = 1/4 = r_𝔓` at the tight dyadic place, witnessed by a finite graph (`[MatolcsiEtAl2025]`'s `G27`; row 71).
  ℚ(√11) and the type-(B) fields are untested: `ι ≥ 2/7` and `≥ 1/4` are the pullbacks, with no finite graph near them known.
- *At ℚ(√47) it gives `ι ≤ 0.2499972 < 1/4`* (P2's local maximum), hence five, **by a finite graph** (S1b-iii). This is the strongest
  possible outcome.
- *Its shadow on the poster:* P10 with P7's count.
- *It predicts, for `F = ℝ`, `α₁(ℝ²) = m₁(ℝ²) ≤ 0.2470`.* That is far below `[DuczVarga2026]`'s 1/4.0007. This is a sharp, checkable
  prediction about finite plane graphs; `α₁ ≥ m₁` holds by averaging random congruent copies.
- **Registered: EI-F true at ℚ(√47), 0.30.**

**(c) Does the milestone's §IQ already name them?** Half, as J36 found for row 88.
- FS-84's §IQ item 3 names the **carrier**, "the invariant random colouring's joint window frequencies", and the single-class **quantity**
  `ι(F)`. It names neither **property**: the finite-place factor (EI-2) or the local maximum (EI-F).

**(d) Does looking for an example invariant beat closing the gap directly?** Yes, for EI-2's pure-point rung. Closing the gap directly
means the continuous layer, which is F5's Furstenberg wall.
- *Kronecker selection is a closed-set question.* Its answer is informative either way. A proof closes FS-64's adelic windows at four
  colours over ℚ(√47). A counterexample over ℚ(√11) — a two-character window colouring with no finite-place proper factor — is **the first
  control the gap has ever had**.
- *EI-F ranks second.* Its proof would need more than pair correlations (J28V C0; Hoffman's 0.2871 at the real place). Its natural test is
  a finite-graph search, banned until 2026-10-01.
- Confidence: medium that J1 is the better next derivation. It would change on a proof that Kronecker selection needs the same
  equidistribution as the continuous layer.

### 4.4 The card

question: does-kronecker-selection-hold
  evidence: `plans/POROS-2026-09-25-wanted-poster-47.md` §3.4 T-J37-1 (rank one closed via `LEDGER.md` row 98 + T-C(A)); §3.3 (b) the naive vector form is false (Θ = (θ₁, band θ₂)); row 109 mixing selection; §3.3 (c) no control anywhere
  expected: an infinite-type coordinate of a measurable window colouring can always be deleted, because band rigidity (row 98) forbids it from being confined
  ask: over a real field, if a measurable window W on T^n is proper for cl Θ(U), is there a proper window reading only Θ's T + A coordinates?
  if yes: EI-2's pure-point rung lands; FS-64's adelic windows at four colours are closed over ℚ(√47); the gap is the continuous layer alone
  if no: the witness is the first colouring with no finite-place proper factor — the control the poster lacks — and the ℚ(√47) counterexample's template
  answered by: derivation
  cost: one derivation job and a blind verifier, solver-free; about one crunch slot each
  hunch: yes at n = 2 by an equidistribution of U-values for characters off E, but the needed Weyl-type bound is not in the records
  falsifier: a character θ ∉ E of some real field's R whose U-values are neither band nor equidistributed along any averaging of U
  rank: 1

### 4.5 Recommendations (ranked, with the default)

| rank | recommendation | alternative weighed | why this one | confidence |
|---|---|---|---|---|
| R1 | **KT-1:** ball-arithmetic re-evaluation of J26's H4 covering (a tools job, minutes, in-ban) | leave H4 in double precision | three poster rows, row 92 and T-C rest on it; it is the only external computer-assisted input; the cost is minutes | high that it passes; the value is the grade, not the answer |
| R2 | **A derivation job on Kronecker selection (J1)**, after J45/J46; statement verbatim: "Let `F ⊆ ℝ` be a real number field, `R = ℤ[U_F]`, `n ≥ 1`, `Θ : R → T^n` a homomorphism and `W : T^n → {0,1,2,3}` measurable with `W(t) ≠ W(t + s)` for almost every `t` and every `s ∈ cl Θ(U)`. Prove or refute: there is a closed subgroup `K′ ⊆ T^n`, the closure of the image of `Θ`'s `(T + A(R_F))`-part, and a measurable `W′ : K′ → {0,1,2,3}` proper for the closure of that part's image of `U`. Rank one is T-J37-1. Control: over ℚ(√11) with `Θ = (θ_{C9}, θ₁)`, `θ₁ ∉ E`, W reading only the first coordinate must pass." | fold into J45/J46 | it is EI-2's rung that a closed-set method can reach; either answer is new | medium-low (0.4) that it is true as stated; changes on a character off `E` whose `U`-values admit no measure with small Fourier coefficients |
| R3 | **A blind check of T-J37-1** (one-mind composition), added to J46's list or to the next verifier | leave it at one mind | cheap (five steps); it is a new poster row | high that it is true |
| R4 | **A post-ban construction stub:** a finite `H ⊂ ℚ(√47)²` with `α(H) < |H|/4` (Dúcz–Varga-type, triangle-free), proving five outright (P10); register **EI-F at ℚ(√47) (0.30)** and **EI-F for ℝ² (`α₁ = m₁`)** as predictions. Replaces S1's stale price (J36 R4; FS-84 inventory `1d6c4fc2`) | keep P-int at 0.03 | the price rested on a refuted conjecture; the route is now of unknown cost and is the only one that proves five by a finite object | medium on the ranking; 0.30 on EI-F |
| R5 | **A reading debt:** a prior-art job on §4.1's queries 1, 4, 6 first (model sets over `S`-adic internal spaces; solenoid measure rigidity; `α₁` vs `m₁`) | skip | the pure-point layer may be a known characterisation; the continuous layer is a known open problem whose partial results (positive entropy) bound what a derivation can hope for | medium |

**If Kooshi does nothing:**
- J45/J46 derive J36's sketches (P8, P9).
- FS-84's post-ban stages colour or refuse the ten minimal survivors. By C3 they can find only kinds of colouring that the limit kills, or
  a refusal.
- The poster, T-J37-1 and EI-F stay in this record.
- The pure-point layer stays unnamed in the stubs.

### 4.6 Evidence inventory (Stage 1 re-read) and the hunch ledger

- `Stage 1 E2`, the expectation that T-C(A) subsumes rows 92, 96 and S1a — read against: §3.3 (d) — surprised: yes (row 95 and S1a are evidentially independent; row 95 is the only line inside the gap)
- `Stage 1 E3`, gap not theorem — read against: §3.3 (a)–(b) — surprised: no (sharpened into two layers)
- `Stage 1 E4`, no control — read against: §3.3 (c) — surprised: no (C3 added: the finite pieces' colourings are all of limit-killed kinds)
- `Stage 1 E7`, the shared input as the killing test — read against: `plans/PA-ambrus2023-audit.md` H4c — surprised: no

hunch: t-c-a-subsumes-the-rest
  claim: rows 92 and 96 and the periodic half of S1 are corollaries of T-C(A), so the poster has one load-bearing theorem
  basis: derived
  falsifier: a row proved by a route not through a stationary-ratio count
  registered: 2026-09-25
  status: killed (by: row 96 rests on "Lemma R and Weil — fewer inputs than FS86-CL1"; S1a "Does not rest on: [AmbrusEtAl2023]"; row 95 excludes characters T-C(A) cannot see)

hunch: the-gap-has-no-control
  claim: no field or graph is known to carry a four-colouring with no finite-place proper factor
  basis: read
  falsifier: a record exhibiting such a colouring
  registered: 2026-09-25
  status: confirmed (by: §3.3 (c) C1–C3; the tally of `data/fs81/phaseD/d47/K1-checker-run.txt`)

hunch: kronecker-selection-true
  claim: a measurable window colouring over a real field can always drop its infinite-type coordinates
  basis: analogy
  falsifier: a two-character window four-colouring of some real field's plane with no proper window on its T + A part
  registered: 2026-09-25
  status: open

hunch: ei-f-at-47
  claim: ι(ℚ(√47)²) equals its largest local stationary ratio, so a finite H ⊂ ℚ(√47)² has α(H) < |H|/4
  basis: analogy
  falsifier: a derivation that ι(ℚ(√47)²) ≥ 1/4, or ι > max local ratio at any field
  registered: 2026-09-25
  status: open

**Scored against Stage 1:**
- E1 partly: it missed P10 and row 98's consequence.
- E2 killed as above.
- E3, E4 and E7 confirmed.
- E5 partly: model sets name the pure-point layer better than Toeplitz does.
- E6 confirmed for EI-2, with EI-F added as a second candidate.
- E8 moved: J36-D is already queued as J45/J46, so R2 takes its place.

### 4.7 Would-have-searched-here log (Stages 3–4)

- Would have searched ℚ(√11) for a two-character window four-colouring with no finite-place factor (J1's falsifier). Instead: stated J1 as
  a derivation (R2).
- Would have sampled finite graphs in ℚ(√47)² for independence ratio below 1/4. Instead: EI-F registered and a post-ban stub proposed (R4).
- The tally in §3.3 (c) C3 is a count over an existing certificate log (seconds), not a search.

## Theorems this phase proved

| id | statement | grade | address |
|---|---|---|---|
| T-J37-1 | over ℚ(√47) no proper four-colouring `x ↦ W(θ(x) + t)` exists (`θ ∈ R̂` any, `W` measurable, proper for a.e. `t`) | hand, one mind; composition of Steinhaus, row 98, T-C(A) at `S = ∅` | §3.4 |
| T-J37-2 | if `θ ∉ E` then `ℤθ ∖ 0` misses `E` (each `E_S` is divisible and holds all torsion), so a character colouring off `E` lies in T-C(A)'s evasive class | hand, one mind | §2.2 (row 96 item) |
| T-J37-3 | for an `R ⋊ U`-invariant `μ`, every atom of `σ_μ` is torsion (finite `U`-orbit; Levitz–Mott); so off `E` the averaged spectrum is atomless | hand, one mind | §3.3 (b) |
| T-J37-4 | the naive vector band statement "`Θ(U)` avoids a neighbourhood of 0 in `T^n` ⟹ `Θ ∈ (T + A)^n`" is false for `n = 2` | hand, one line | §3.3 (b) |
| T-J37-5 | row 84's 177 certified lattice colourings over ℚ(√47): 73 additive into ℤ/4, 11 periodic mod `4Λ`/`8Λ`, 40 residue at the stable 47 and 67 through a partial image, 22 residue at split 17, 37, 53, 61, 31 linear forms | tools exact (a count of an existing log) | §3.3 (c) C3 |
