# FS-105 — harden MR where the collapse uses it (stub)

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
