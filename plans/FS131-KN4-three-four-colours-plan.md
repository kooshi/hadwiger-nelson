# FS131-KN4 — three and four colours over real number fields: the leaf list, the statements, the skeleton, a plan per leaf

*The kernel lane's planner (de Bruijn), 2026-10-13, on branch `fs131-wr2`. Brief: `data/fs131/briefs/FS131-KN4-three-four-colours-plan.md`.
Claim list: `data/fs131/claims-NF4.md`. Working files: `data/fs131/kn4/`. Nothing here is blind (the brief's `fences: none`).*

## Theorems this phase proved

None in the kernel: this is a planning job, and every leaf of its three modules is `sorry`. Three **routes** are this job's and are
findings, each at [hand, one mind, the planner; unchecked by a second]:

- **R-1, the rational layer with no cell list** (§ 2.3): FS81-T3's dichotomy from two integer relations and the bound `6·(1/6) = 1`.
  Checked by exact arithmetic on the four corners and on the bound's tightness (`data/fs131/kn4/layer_check.py`, two plants).
- **R-2, the three-part and the two-part with no Teichmüller section and no weak approximation** (§ 2.5): compose the functional
  with a power of Frobenius; it then lives on the reduced quotient, and the Hilbert-90 set is carried to itself.
- **R-3, Weil's bound covers every residue field from 27 up** (§ 2.5): `TargetFloor 4 Q` for `Q ≡ 3 (mod 4)`, `Q ≥ 14`, by the ten
  lines of `WeilKloosterman.targetFloor_six_of_kloosterman`; the exact checks at 27 and 243 are not needed.

## Stage 1 — SAVED: the readback

### 1.1 The eleven quotations

`data/fs131/kn4/check_quotes.py`: the brief's eleven quoted lines against `data/fs131/claims-NF4.md`, byte for byte — **11 MATCH, 0
mismatches, no claim line unquoted** (exit 0). Control: `--plant` changes `m ≡ 11 (mod 12)` to `(mod 24)` in the claim text in memory;
the check reports `mismatches=1` on NF4-THEOREM and exits 1.

### 1.2 The three clauses, every symbol resolved

| the claim's symbol | the library's declaration | where |
|---|---|---|
| a subfield `F ⊆ ℝ` | `F : Subfield ℝ` | — |
| `F²`, the plane over `F` | `planeOver F : Set ℂ` (`z.re ∈ F ∧ z.im ∈ F`) | `SquareClass.lean:63` |
| `χ(F²)` | `((unitDistance ℂ).induce (planeOver F)).chromaticNumber : ℕ∞` | `UnitDistance.lean:40` |
| `F²` bipartite / has an odd cycle | `((unitDistance ℂ).induce (planeOver F)).Colorable 2` / its negation | Mathlib |
| a unit vector | `SpectralChain.unitVectors F` (`u ∈ planeOver F ∧ ‖u‖ = 1`) | `SpectralChain.lean:62` |
| `ℤ[U_F]`, "integer combinations of unit vectors" | `SpectralChain.unitRing F = UnitRing.unitRingOver F : Subring ℂ`; additive span by `UnitRing.exists_sum_eq_of_mem_unitRingOver` | `UnitRing.lean:151, 201` |
| `1/3 ∈ ℤ[U_F]` | `(3 : ℂ)⁻¹ ∈ unitRing F` | — |
| `ℚ(√m)` | `fieldOfRadicands {m} : Subfield ℝ`, `sqrt_mem_fieldOfRadicands` | `SquareClass.lean:306` |
| a real number field | `F : Subfield ℝ` with `[NumberField F]` | Mathlib |
| "some prime of `F` above 3 has residue field `𝔽₃`" | `∃ 𝔭 : Ideal (𝓞 F), 𝔭.IsMaximal ∧ Nat.card (𝓞 F ⧸ 𝔭) = 3` — the form `fs131-wnf`'s `QuadraticPrime.exists_maximal_card_eq` concludes | Mathlib; **no declaration on `main` relates such a prime to `ℤ[U_F]`** |
| `Θ₃(R_F)`, characters with `θ(U_F) ⊆ [1/3, 2/3]` | `CharacterColouring.fieldBandSet F (band 3)` | `Arith/CharacterColouring.lean:57, 84, 248` |
| `T₆`, characters killed by 6 | `CharacterColouring.torsionBy (unitRing F) 6` | `Arith/CharacterColouring.lean:60` |
| a winding | `ThreeColour.Winding s`, from `ThreeColour.nonempty_winding` | `ThreeColour.lean:59, 257` |
| a stable prime; its target; `L(F)` | `SpectralChain.StablePrime F`, `levelTarget P 1`, `localBound F` | `SpectralChain.lean:279–301` |
| the residue target of a finite field | `StandingFive.normOneCayley k σ`, `StandingFive.TargetFloor n Q` | `Arith/StandingFive.lean:1202` |
| Weil's bound | the axiom `StandingFive.kloosterman_bound`; `normOne_charSum_ge`, `targetFloor_of_charSum` | `Arith/WeilKloosterman.lean:51`, `FloorPlanes.lean:374`, `NormOneTarget.lean:117` |

**Missing on `main`, each a leaf below:** the character of a three-colouring (NF4-S6); the layer dichotomy and the torsion extraction
(NF4-S7); a two-colouring as a character with value `1/2`; conjugation on `ℤ[U_F]`, its prime ideals, its finite quotients; and the
dictionary from a maximal ideal of `ℤ[U_F]` to a prime of `𝓞 F` — which needs `fs131-wnf`'s `UpperHalf.exists_stablePrime_of_valuationSubring`
and `StablePrime.residue`, so it is planned in the joining file and not compiled here.

### 1.3 The entries, read where they stand, beside the clause each is cited for

| clause | cited entry | what the entry proves | verdict |
|---|---|---|---|
| (c) | `plans/FS81-derivation.md` T1–T5 (:29–:99) | T5's corollary F-T4: "every `F ⊆ ℝ` with `1/3 ∈ ℤ[U_F]` and `F²` not bipartite has `χ(F²) ≥ 4`" | the clause is the entry. T2 and T4 two derivations, T3 two with a computed cell list, T1 one line |
| (a), the lower bound | T5, same corollary: "`χ(ℚ(√d)²) ≥ 4` for every squarefree `d ≡ 11 (mod 12)`" | the clause is the entry; **squarefreeness is not used** (§ 1.4, G-1) | — |
| (a), the values 2 and 3 | not T1–T7: the values are "printed" (`[Fischer1990]`, `[Johnson2000]`); the lower bound `3` at `m ≡ 3 (mod 4)` is the odd closed walk from `1 = 2n − nv − nv̄` (T4's relation) | elementary; a leaf here (`not_colorable_two_of_sqrt_mem`) | — |
| (a), "= 4 … outside the classes 47, 143, 167 (mod 168)" | the upper bounds are `fs131-wnf`'s: at `m ≡ 11 (mod 24)` the dyadic prime is inert in `F(i)/F` with target `Cay(𝔽₄, μ₃) = K₄` (a **stable** prime, NF1-S1B, not a usable one); at `m ≡ 23 (mod 24)` a prime with residue field `𝔽₇` when `m` is a square mod 7 or `7 ∣ m` | the three excluded classes are exactly `m ≡ 23 (mod 24)`, `m ≡ 3, 5, 6 (mod 7)`: checked (`47 ≡ 5`, `143 ≡ 3`, `167 ≡ 6 (mod 7)`) | consistent |
| (b) | `plans/FS91-derivation.md` FS91-J02-T2 (:214), J02-T3 (:244), J09-J4 (:192) | J02-T2 = S1: "`χ(F²) ≤ 3 ⟺ … ⟺` (the two prime types) `⟺ L(F) ≤ 3`, every real number field"; its alias J09's J4-C: "`χ(F²) = 3 ⟺` non-bipartite and a prime above 3 of residue field `𝔽₃`" | the clause is J4-C. J02-T3 (S2) is wider than the clause (it is row 99's `χ = L` at `L ≤ 4`) and J09-J4 (the classification of all of `Θ₃`) is not needed for it |

**T5 carries a correction owed** (`plans/FS81-derivation.md:101`, to `plans/FS91-S0FV-three-colours-blind.md` §2.5, J4-T6): it concerns
T6's open item (additive three-colourings are Fischer's), not T5's statement; nothing in the clauses moves.

### 1.4 Findings of the readback (sent to "main" mid-job)

- **G-1, generalization of (a).** The lower bound needs neither squarefreeness nor that `F` is the quadratic field: **every subfield
  `F ⊆ ℝ` holding `√d` for a natural `d ≡ 11 (mod 12)` has `χ(F²) ≥ 4`** — `1/n = 2 − v − v̄` with `d + 1 = 4n`, `v = ((2n−1) + i√d)/(2n)`,
  and `3 ∣ n`. It is (c) at once, in the shape row 73's `four_le_chromaticNumber_planeOver_of_sqrt_eleven_mem` already has at 11.
  Likewise `χ(F²) ≥ 3` for every `F ∋ √d`, `d ≡ 3 (mod 4)`.
- **G-2, the strongest form of (c).** `1/3 ∈ ℤ[U_F]` gives `Colorable 3 → Colorable 2`: **`χ(F²) ≠ 3`**. The claim's "(c)" is this with
  the hypothesis "not bipartite" moved across.
- **G-3, (b) does not need the two-colour classification.** In the ⟹ direction the case "the dyadic part" ends in a character with value
  `1/2` on every unit vector, which *is* a two-colouring; the hypothesis "not bipartite" closes it with no prime above 2 named. The
  outside model's two-colour theorem (GPT Astra's Thm 2.1) is needed only for the form row 127 takes (`localBound F ≤ 4 → localBound F ≤ χ`),
  planned separately (§ 2.6).
- **S-1, Weil.** NF4-RESTS's "row 99's route uses Weil's bound, row 82's uses none" is confirmed from the entries (J02-L4(a) is the one
  use; FS81 T1–T5 use none). The map's "exact at 27, 243" is not needed: R-3.
- **S-2, T3's computed input is not needed**: R-1.
- No clause is wider than its entry. No statement defect found in the claim list.
