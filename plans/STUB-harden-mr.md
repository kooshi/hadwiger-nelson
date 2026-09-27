# FS-105 — harden MR where the collapse uses it (stub)

> **Closed 2026-09-26: Paid (hardening)** (record `plans/FS105-harden-mr.md`, §R-close first; `plans/FS105-derivation.md`; close inventory
> `plans/FS105-close-inventory.md`). MR (`LEDGER.md` row 120) stands, its grade rewritten. The proof of EL2021 Thm 1.2 is in neither paper
> the record named: EL2003 is an announcement whose §6 is an outline; Thm 1.2 follows from EL2021 Thm 1.3 by a deduction EL2021 never writes
> (FS105-DED, [hand], two minds, one blind), with one forced reading ("virtually cyclic factor" means a non-trivial one). PE-2 sits inside
> Thm 1.3's hypotheses at ℚ(√635087) and de Grey's field (FS105-PEH); a reading gap, not a mathematical one, at EL2021's cited leafwise-measure
> machinery (`[10]`, `[11]`, `[5]`; the fetch declined for now by the owner). EF_F⁺ has a third derivation blind to the other two, at
> ℚ(√635087), with EF_F⁰ (FS105-B-EFP). C-MR16: MR at de Grey's field walked at degree 16, one checking reading (FS105-MR16). Row 129's
> killing test is correct as stated; a refutation must be (W) or (W′) (FS105-W-D2), and nothing in print comes near. **Left:** the cited
> machinery's reading (`[11]` Prop. 6.4 first); MR off the totally real fields and at row 100's exception fields (FS-100's left items).
> The text below is the stub as it stood when the milestone opened.

> **Re-aimed at FS-103's close (2026-09-26).** Rows 121–130 now rest on MR (row 120), the collapse and the fractional equality included. Add:
> **C-MR16** — MR at de Grey's field walked at degree 16 (PE-2's admissibility; EF_F⁺'s count `c·M^{1/16}`), unreached by both FS-103 verifiers;
> and **row 129's finite-graph test** — any proof that `α₁(ℝ²) > m₁(ℝ²)` (a statement about finite unit-distance graphs) refutes MR at
> ℚ(√635087): the audit should look for one (FS103-F's held item: "an extra-hard audit of MR"). The close recommends this stub above FS-104
> (Kooshi's call): everything FS-104 would build rests on MR.

*Minted 2026-09-26 by job R3 from R1's N3 (`plans/RERANK-2026-09-26.md` §3.1, after the advisor's point (3): "Make MR's hardening an explicit
rank"). Rank 3 in `plans/FRONTIER-STUBS.md`. **Solver column: none** — reading and derivation, in-ban. Written for a session with zero
conversation memory.*

**Kooshi's words** (2026-09-26, on the re-rank): *"I agree and approve all suggestions. Set things up, then prepare for compaction, and we'll
focus on that as the milestone."* This stub is the base under that milestone (FS-103).

## Why this stub exists

Every consequence of rows 121–125, and FS-103's candidate collapse, rests on **MR** — `LEDGER.md` row 120: *"for every real number field `F`
with `R_F = O′` (row 100 — every `F` without a ramified stable dyadic place), every `U_F`-invariant finite positive measure on `R̂` with
`τ(E) = 0` is a multiple of Haar measure (MR(F))."* Its grade, verbatim: *"[hand; PE-2 two derivations blind to each other (X02D, X02V), EL2021
Thm 1.2 by statement (external, in print; its proof in EL2021 §§2–9, unread here); EF_F⁺ two derivations blind to each other (X01D, X12B) and a
checking reading (X01V, after its blind GAP, withdrawn as its own error); MR a composition, three minds]"*. The advisor calls MR's external
step and its two-mind steps the collapse's weakest link (its stage 3, advice item 3).

## The work (R1's N3)

1. **Read `[EinsiedlerLindenstrauss2022]`'s proof** ("EL2021", arXiv:2101.11120) as far as the hypotheses PE-2 uses. Read so far: §1, §2
   (pp. 5–9, set-up only) and §4.1–§4.3 (pp. 14–17); **§§3, 5–9 unread** (`BIBLIOGRAPHY.md`). PE-2 applies its Thm 1.2 (EL2003's Thm 1.1) on
   the finitely generated pieces `M̂` "only under admissibility — every finite-index subgroup of `Γ` spans `L`" (row 120). The copy is
   `library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` — grep `BIBLIOGRAPHY.md` by arXiv id before
   fetching (G50: this paper was fetched three times under wrong addresses).
2. **A third derivation of EF_F⁺, blind** to X01D and X12B, at `ℚ(√635087)` — FS-103's checkable instance (degree 2; wall broken; usable
   places from 103). EF_F⁺ is `[EinsiedlerFish2010]` Lemmas 3.1–3.2 transferred: *"one non-torsion `u` of zero entropy puts a `U`-invariant
   measure on `T + A` (EF_F⁺, Einsiedler–Fish's pigeonhole with the rational unit vectors as multipliers and the product formula as the
   Diophantine step)"* (row 120).
3. **PE-2's admissibility written out at `ℚ(√635087)`**, and the list of what changes at degree 16 (de Grey's field, FS-103's statement):
   the pieces `M̂`, their `Γ`, and admissibility there.

**Alternative weighed (R1):** fold this into FS-103's verification — loses because a blind third derivation of EF_F⁺ is a separate mind's work
and should run in parallel with FS-103.

## Outcomes (each reachable)

- EL2021's proof read and PE-2's use of Thm 1.2 confirmed within its hypotheses; EF_F⁺ re-derived blind: MR's grade gains a mind and a reading.
- A hypothesis of Thm 1.2 PE-2 does not meet, or a step of EF_F⁺ that fails at ℚ(√635087): MR drops to the named gap, and rows 121–125 and
  FS-103 with it — corrected before anything else is built.

## Provisional bearings

G80 (the mechanism: `U_F` has polynomially many elements of bounded height), G50 (read what the search found; EL2021 §§3, 5–9 are a debt),
G51 (a blind third mind), G21 (audit a result you like), G76. Stubs: FS-103, FS-100 (MR's home; its left items), FS-101 (MR as a named
hypothesis `hMR`), FS-102 (the write-up's grades).

## Bearing on χ ≥ 6

Derived: FS-103's collapse, and every result of rows 121–125, are only as good as MR. None on six directly.

*Would have searched here:* nothing.
