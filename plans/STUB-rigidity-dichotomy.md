# FS-73 — the rigidity dichotomy: when does a lattice force a pair? (stub)

> **CLOSED 2026-09-23** (record `plans/FS73-rigidity-dichotomy.md`, its §R-close first; `LEDGER.md` rows 78–79; theorems `plans/FS73-derivation.md`; G71). Question (1), inheritance: **a theorem at three colours** for every Cayley graph of a finitely generated torsion-free abelian group (row 79), **open at four** (FS-76). Question (2), the classification: de Grey's lattice has `F = P = 8Λ` at four colours (the lattice form of Hubai's 2018 count for the Moser ring) and is the only rigid rank-4 CM lattice in the table (row 78). Question (3), rank 6: decided by membership in the fibre-collision group, not the index (T33); KR6 → FS-77. The stub below is kept as written.

*Minted 2026-09-22 at FS-70's close, from G69 and the derivation file's C1–C3. Rank 3: mechanism, no compute to speak of.*

## The question

G69 says: a lattice's periodic four-colourings are its residue colourings prime by prime; a forced pair needs every periodic
colouring's Kempe component to reach the target (the index `[NΛ : V]`); over `K` the hexagonal lattice is dense and rigid, over
ℚ(√3,√5) every lattice of rank ≤ 6 is loose and rigidity is possible only at rank 8 where density starts at 10⁷ points.
**Three things are unproved in that sentence:**

1. **Inheritance (C3).** *Rigid under every periodic colouring ⟹ some finite ball forces the pair?* Over K it is true by Harder's
   23,083-point object; nothing says why. The converse direction is row 66's; this one is the tower's "says nothing about any
   finite chunk" (row 67) turned into a question. A counterexample — a lattice rigid at every period whose balls all separate the
   pair — would be a non-periodic escape and G69's killing test.
2. **The classification.** For which real fields `F` does a rank-4 CM lattice exist that is (a) 3-non-integral, (b) 2-unit or
   wall-broken as the route needs, and (c) rigid — every odd prime's target refusing four colours? The six quartic CM subfields of
   ℚ(√3,√5,i) all fail (T5, T9: a loose prime at 5 or 7 in each); K's `ℚ(√−3,√−11)` passes at 5, 7, 11, 13. The FS-48 siblings
   ℚ(√3,√23), ℚ(√3,√47) and FS-59's ℚ(√167) (at three colours) get this test before any ball. C1 — commensurate ⟹ 2-unit exactly
   when the prime above 2 is not split over the real subfield — is one column of the table.
3. **The rank-6 mechanism.** L2 (with `v`) and L3 (with `w`) are both loose, differently (L2 by a gapped period-5 colouring, L3 by
   Kempe escapes at 2 and 4 with `[2Λ : V] = 81`); at rank 6 the quotient is not a field's residue ring and T9's reading does not
   apply. What decides the index? C2 (a twisted bilayer's cross-edge set is fixed by the rotation) may be the same fact seen from
   the arena side.

## What it produces

A theorem or a counterexample for (1); a table for (2) over the fields the stubs name, computed by the screens (minutes per
field); the kernel forms of T2, T6, T10 (FS-2's two targets) as the statements the theorem would rest on.

## Provisional bearings

G69 (the whole entry is this stub's question), G68, G54 (tight towers force — the 2-adic half of rigidity), G61(4), G62, G27,
`[Polymath16wikiR2]` (the one hand proof of a rigidity step, over K). Rows 66, 67, 73 (the three-colour instance over ℚ(√11)).
**Added at FS-71's close (2026-09-22):** **G70** — Coxeter's theorem that a √3-clean four-colouring of the Moser lattice is one of the two
residue colourings (`plans/MASCOT-derivation.md` T6–T11): rigidity over K is "which colourings are √3-clean", and the inheritance question
C3 is whether that criterion transfers to a finite ball; **G51** — Kooshi's competitor design is to be run here, on the inheritance
question, with the count of retractions recorded (a derivation wall with a known positive instance, Harder's object). The briefs to fill in and the rules: `plans/PROTOCOL-competitor-and-advisor.md`. The
theorems FS-71 filed that this stub consumes: MASCOT-T6–T8, FS70-T9/T10, FS38-D2-A/B, FS25-T1.
**Next milestone (Kooshi, 2026-09-22, at FS-71's close).**

## Bearing on χ ≥ 6

None directly; high on the programme — it is the statement of *where a forcer can live* in a field, which every six-forcer
question over a window field will need in the same words.

## Where the 2026-09-26 work on this lives

*Pointer block (consolidation job C1, 2026-09-26): addresses only — each result lives in its ledger row and derivation entry; the per-job index is `plans/CRUNCH-2026-09-26-x2x3-INDEX.md`.*

See: `LEDGER.md` row 119 (`plans/FS75-derivation.md` FS75-C, FS75-H).
