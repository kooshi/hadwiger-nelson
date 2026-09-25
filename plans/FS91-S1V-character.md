# FS-91 S1V — blind verification of the character local–global theorem (crunch job J10, milestone M1)

*De Bruijn (Opus 5.5), blind verifier of J07, 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J10-M1-character-blind-verifier.md`,
with `data/crunch-2026-09-25/briefs/STANDING-RULES.md`. The verdicts are mine. Fence honoured: of `plans/FS91-character-local-global.md`
only the quoted statement lines were opened (lines 430–436, 439–441, 452–456, 519–521, located by `grep`); no J07 file, no J02 record, no
other crunch record was opened.*

*Owner's news at launch (statements only), used below: (1) J01-7 verified by two blind readings — RQ_k at every k, and
`Θ_k(R_F) ⊆ T_{N_k} + A(R_F)` for every `F ⊆ ℝ` and every `k`; (2) over `R_F` the archimedean part is the **wide**
`A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`, never one embedding's `λ_e`; (3) J02's three-colour theorems have two derivations; fence stands.*

## Stage 1 — SAVED (quotation check and C0)

### 1.1 Quotation check (standing rule 5)

| brief item | source | result |
|---|---|---|
| the definitions block ("`F` a real number field (a subfield of ℝ … `H_k` is the hypothesis `Θ_k(R_F) ⊆ T + A` for every real number field `F`.") | `plans/FS91-character-local-global.md` lines 431–436 | **verbatim**; the source continues after "real number field `F`" with a parenthetical of `H_k`'s evidence ("row 95 and the gluing at `k = 4, 5`; PA-B3 with the gluing at `k ≤ 9`, verified by J01; every `k` given J01-7"), which the brief cut — harmless truncation |
| V1 = CLG_k | same file, lines 439–441 | **verbatim** |
| V2 = the κ-form | same file, lines 520–521, inside §M.1 (heading at line 515) | **verbatim** (the source also defines `κ(G, S) = max{β : …}` on line 519, as the brief says) |
| V3 = CLG-g | same file, lines 454–455 | **verbatim**; the source adds after the closing quote "— with the exception made explicit" |
| V4 = CLG-f | same file, lines 452–453 | **paraphrased, one item dropped.** Source: "`[Fischer1994]`'s ℤ/4 colouring of K (row 89) returns a dyadic target at level 3; row 94's C9 on ℚ(√11) returns Γ₇; row 96's HD1, C-47, C-167 and J02-T1 fall out." Brief: "… row 96's three corollaries follow." **J02-T1 is dropped**, and "fall out" of the class theorem (CLG-a to CLG-g) became "consequences of V1". I verify the brief's fixed list (Fischer, C9, HD1, C-47, C-167) as consequences of V1 and of V1's proof separately, and I cannot check J02-T1 (J02's records are fenced; its statement is not in any file I may open) |
| the wide `A` (owner's news 2) versus FS-89's §0.1 `A` | `plans/FS89-rational-band-rigidity.md` §0.1: "`A` (archimedean): `λ_e(x) = Re(ē x) mod 1`, `e ∈ ℂ`" | FS-89's `A` is one embedding's, on `Q ⊂ ℚ(i)` (where it is the whole of `Hom_ℚ(ℚ(i), ℝ)`, so no conflict there). Over `R_F` I read `A(R_F) = {x ↦ ℓ(x) mod 1 : ℓ ∈ Hom_ℚ(F(i), ℝ)}` throughout, as instructed |

### 1.2 C0 — probabilities per claim, registered before the derivation is written

Honest timing: formed after reading the verified inputs (FS-89 §0.1–0.3, FS89-derivation §1, FS86 Lemma R and CL2, ledger rows 88, 89,
94–97), during which a route sketch had already begun; registered before any line of the derivation below was written.

| claim | P(TRUE as stated) | the reason, and the most likely failure |
|---|---|---|
| V1 (CLG_k) | 0.85 | ⟸ looks unconditional (a residue map sends unit vectors into the local norm-one image). ⟹ needs a torsion character of `R_F` to factor through finitely many stable places — the place Lemma R's scope (CL2) could bite — and a "one factor carries the band" step, which could fail for a Minkowski sum of value sets |
| V2 (κ-form) | 0.85 | stands or falls with V1's ⟹; a reading risk in "`κ(O_𝔓, S_𝔓)`" (completion or localisation) and in "max" over infinitely many places |
| V3 (CLG-g) | 0.75 | needs V1 plus a descent from level `m` to level one at `p > k/2`; the exception clause may be misplaced (ramified dyadic places) |
| V4 (controls from V1) | 0.55 | Fischer and C9 look like instances; but HD1 is a statement about **every** band character, which an existence equivalence cannot give, and "at level 3" is a property of one explicit functional, not of V1 |

### 1.3 The would-have-searched-here log (no finite-witness search to 2026-10-01)

| # | the move I would have made by search | what I did instead |
|---|---|---|
| — | (stage 1: none) | — |
