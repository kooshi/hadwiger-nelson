# FS-113 — measure rigidity for the unit-vector group, in full, in Lean (stub)

*Minted 2026-09-27 by the product owner at Kooshi's ruling (the consolidation run, `plans/CONSOLIDATION-2026-09-27.md` item 6): asked whether "MR
in full in Lean" gets its own stub, he chose *"Yes, mint the stub (Recommended)"*. The gap it fills was named by the 2026-09-27 ranking pass
(`plans/RERANK-2026-09-27.md` § 4): *"No row of the ranked table carries MR in full in Lean, the first item of § The aim's Lean program; FS-101
carries its consumers with MR as a named hypothesis."* Solver column: **none** (a formalization of derived and published statements; no search at
any stage).*

## The target

**MR(F)** as `LEDGER.md` row 120 states it: for every real number field `F` with `R_F = O′` (every `F` without a ramified stable dyadic place),
every `U_F`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure — as a theorem in `Proofs/`, on the standard
three axioms, with **no declared purchase** (Kooshi, 2026-09-26, `CLAUDE.md` § Publication: *"no declared purchases for the final one"*). First
at the fields the direction uses: ℚ(√635087) (row 128) and de Grey's field (degree 16, FS105-MR16), then every `F` of the class.

## Why this stub exists — its bearing on the answer

- **Link 1 of `CLAUDE.md` § The aim runs through it.** Given MR, `χ(ℝ²) = χ(ℚ(√635087)²) = χ_CP(ℝ²) = χ_m⁰(ℝ²)` (rows 128, 130). So if the
  regularity wall's lower route lands — `χ_m⁰(ℝ²) = 7` (FS-112 with FS-111, rows 131–134) — then `χ(ℝ²) = 7` **given MR**, and publishing that
  answer by the aim's bar needs MR in the kernel. The other answer does not: a sequence of periodic colourings giving `χ(ℝ²) ≤ 6` needs no MR
  (link 2; row 131).
- **Every field result above four waits on it**: rows 121–126 (five at ℚ(√47), ℚ(√143), ℚ(√311), ℚ(√335), ℚ(√3,√5); the main clause through
  five) and the algebraic `χ(ℝ²) ≥ 5` (§ Where the problem stands) are [hand] through MR, and row 127 holds them in the kernel only over the
  named hypothesis `hMR` (with PE-2 and EF_F⁺ as named propositions).
- **Bearing, stated plainly:** none on deciding `χ(ℝ²)`; on the publication path of the answer "seven" through the measurable route, and of
  every MR row, it is required. It is FS-101's precondition: FS-101 discharges its named hypothesis `hMR` only once this stub lands.

## What the proof consists of (the pieces to formalize)

From row 120 and `plans/FS105-derivation.md`:
1. **PE-2, the entropy split:** every `U`-invariant `τ` is `a·m + τ′`, `τ′` of zero entropy for every `u` — through **Einsiedler–Lindenstrauss
   2021 Thm 1.3** (`[EinsiedlerLindenstrauss2022]`, held: `~/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf`),
   applied on the finitely generated pieces `M̂` under admissibility, with **FS105-DED** (Thm 1.3 ⟹ Thm 1.2; two minds, one blind) — the
   leafwise-measure machinery EL2021 cites is unread (row 120: *"a reading gap, not a mathematical one"*).
2. **EF_F⁺, the zero-entropy half:** one non-torsion `u` of zero entropy puts a `U`-invariant measure on `T + A` — **Einsiedler–Fish's pigeonhole**
   (`[EinsiedlerFish2010]`, held) with the rational unit vectors as multipliers and the product formula as the Diophantine step; the height count
   (FS105-W-H, W-G: polynomially many elements of bounded height, any positive exponent).
3. **The composition** FS100-MR (field-free), and HX-1 (closed `U`-invariant subgroups of `R̂` are finite).

**What Mathlib lacks** (FS-105 §K, every kernel decision declined for this reason): *"solenoid actions, Kolmogorov–Sinai entropy, restricted-product
duality, `m₁`, `α₁`"* are *"not on Mathlib's surface"*. So the stub's first phase is a survey of what Mathlib and its neighbours hold (ergodic
theory, entropy, Pontryagin duality for locally compact abelian groups, adeles) and a price table built from the first two leaves, never from a
plan's guess (`CLAUDE.md` § What compute actually helps: kernel phases re-priced five to thirty times lower once begun).

## Registered expectations and failure clauses

- The deep leaf is EL2021 Thm 1.3 (positive entropy on solenoids, via leafwise measures). Formalizing it means reading its cited machinery in full —
  which also closes row 120's reading gap. A proof of MR avoiding Thm 1.3 at the fields the direction uses would be a finding.
- Counter-priors (`CLAUDE.md`): the length of this formalization never ranks it. What ranks it is its bearing, above.

## Provisional bearings

G80 (infinite rank is the resource; the height count is the hypothesis), G81 (where every place mixes, the field is the plane — the consumer), G76
(the measure half of four-colour rigidity), G21 (a reading gap is named, never smoothed over); rows 120, 127, 128, 130; FS-101 (its consumer),
FS-105 (its hardening, closed), FS-100 (its origin).
