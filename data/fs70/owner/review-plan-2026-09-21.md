# FS-70 — the owner's review of the planner's subplan (2026-09-21, night)

*Scored by artifact: the plan `plans/FS70-five-over-sqrt3-sqrt5.md` (commits `7ecbe09a` … `d53ac206`), the skeleton, the
bibliography, the planner's records — and the two claims that change the milestone's shape re-derived with my own code.
Planner: Fable 5.1, ≈530k tokens (over the 500k it was asked to stay under; every artifact is on disk), no agents started.*

## 1. Verdict: ACCEPTED, with two grade corrections and one credit move applied

| what | how I checked | result |
|---|---|---|
| **The additive screen kills the √3 virtual edge and the distance-2 forced pair on 2-unit fabric** (plan §2.2, §3.4 — the claim that redirected phase 1) | `po_additive_screen.py` (mine; unit vectors by a box enumeration over the four real embeddings, the lattice by sympy's HNF, all 4⁸ homomorphisms): on `ℤ⟨ζ₁₂, u, ū⟩` **rank 8, g = 36, ℤ/4: 1,296 proper additive colourings, 432 with φ(i√3) = 0, 432 with φ(2) = 0, all 1,296 with φ(4/3) = φ(8/3) = 0; Klein: 1,296, none with φ(i√3) = 0** — the planner's numbers exactly | **confirmed** |
| The plan's stronger sentence, *"dead on every lattice of 2-units"* (P1: "a theorem given the screen") | `po_additive_screen_rich.py`: the lattice spanned by **all** 2-unit vectors up to denominator 14 (212 vectors) and up to 30 (660 vectors; 2-integrality by the characteristic polynomial), constrained by all of them: **48 ℤ/4 colourings, 16 with φ(i√3) = 0 and 16 with φ(2) = 0; 216 Klein — identical at 14 and at 30** | the kill **holds on far richer fabric than the plan screened and is stable from denominator 14 to 30**; it is *not* a theorem for all 2-unit lattices (a richer lattice can only remove colourings), so **P1 is re-graded "measured, stable to denominator 30"**. The survivors' structure (16 = ?) is worth one sentence in phase 0's record |
| The 3-adic gate (§3.1): the pilot lattices `ζ₁₂, v` and `ζ₁₂, w` are 3-unit lattices, hence 3-colourable through `UD(𝔽₉²)`, hence carry no four-colour compulsion | by hand: `v = (1+i√15)/4` and `w` have denominators 4, so they and their conjugates are 3-integral and `v v̄ = 1` makes both 3-units; row 72's mechanism and `χ(UD(𝔽₉²)) = 3` (`[Moorhouse2010]` Table 6.1, our row 72); the spare-colour argument is correct at both compulsion kinds | **confirmed**; the planner's own catch of its pilot's misreading (G21) is the right kind of record |
| **Harder's forced pair at 8/3 over K is prior art for M56's 588-vertex forcer** (§PA.3) | read in the held thread text: Jannis Harder, Polymath16 first thread, 28 April 2018, 1:13 pm — *"The graph V + V + H not only precludes monochromatic triples, but forces the point (8/3, 0) to have the same color as the origin. This allows for a simple spindle construction with the angle arccos(119/128) … 745 vertices"*; Parts, 10 March 2021: the 4H4 strip, 61,216 vertices, the mono-pair `(0,0)–(8/3,0)` | **confirmed; credit moved** in `CLAUDE.md` G55 and row 47 and in `plans/STUB-chain-theorem.md` (M56's core stands as a smaller rediscovery, 588 against 745) |
| The skeleton `Instances/ThreeFive.lean` | `lake env lean`: 2.0 s, one `sorry` at the expected leaf, nothing else | elaborates |
| Bibliography | `tools/bib_audit.py` clean; `[Polymath2021]` row, `[Soifer2024]` ch. 54 and `[Heule2021]` extensions read | in order |
| Nothing running | `ps`, `nvidia-smi` | idle; the planner's one background solve is gone |

## 2. What I did not re-derive (and why)

`[Soifer2024]` ch. 54's statement that Heule's 1,441 lives in ℚ(√2,√3,√5)² with fabric `T721` in ℚ(√2,√3)² — a book's relay of a
paper we do not hold; the stub records it as such. The residue-plane values at 5 and 7 (χ ≥ 5) — screen inputs only, re-derived in
phase 0.4. The covolumes and the ball law with exponent 4 — plausible (four embeddings), and the conclusion (balls are out on
dense lattices) is checked in phase 0 by the sizes the tools report.

## 3. Rulings

1. **Phase 0 goes to one fresh Opus implementer now**, alone — its products (the screen table with `Λ_forced` per lattice, the
   3-adic gate per lattice, Haugland's `G₁` as the positive control, the structure instruments with their `3Λ` control) are what I
   score before any ask runs. Phase 1 gets a fresh implementer after that review.
2. **P1 re-graded** as above; phase 0.2 records the survivor counts on its richest 2-unit lattice beside mine (48 / 16 / 216).
3. **The plan's phase-1 order stands**: L1 (`S₂`, Harder's shape, `eq 4/3`, `eq 8/3`) before L2/L3 (wall-breakers, where the
   control itself can refuse). The stub's route 2 wording ("Haugland's shape, `A = B` pinned") is superseded for 2-unit fabric and
   kept for L2/L3 — the stub says so.
4. **The credit move is done** (G55, row 47, the chain stub). The `[Polymath2021]` paper joins the loan list's "wanted, less
   urgent" tier — Soifer's quotation and Parts's thread comment are its content for now.
5. **Budget note for the record:** the planner used ≈530k tokens against a 500k cap; the overrun cost nothing (everything
   persisted), and the next brief says 400k for an implementer, per the memory rule (errors rise past ~500k).

## 4. Files

`po_additive_screen.py`, `po_additive_screen_rich.py` (this directory; both runnable in seconds: `python3 … [DMAX]`), this note.
