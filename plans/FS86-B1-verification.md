# FS-86 stage B — verifier B1: the blind verification of the frame (V0–V4, V3-ram, VK)

*Verifier B1 (de Bruijn standard; Opus 5.5), briefed by the product owner, 2026-09-24. Brief: `data/fs86/briefs/B1-verifier-brief.md`
(committed at d3a523c1). Tools under `data/fs86/b1/`. No subagents; finite-witness-free week (no SAT, no enumeration, no finders).*

## Exposure log (what I saw of the frame before C1, stated so the owner can weigh independence)

1. **Start-up context, commit subjects** (harness snapshot, not opened by me): 632c24de's subject names the plan's frame in outline —
   "`F(R) ∈ {0, P(R)}`, `P(R) = R ∩ 𝔓⁴`, the question is `F(R)`; the K classification as a candidate" (the statements I am asked to
   verify, no proofs) and "the vector-colouring handle: Godsil–Roberson–Rooney 2017 … Zhang 2012's MIS-normal half"; cbeb1903's names
   "item 11's hypothesis closed by hand (the ramified 59-tower)" and "G54's ratio bound for a ramified base".
2. **`git log -- CLAUDE.md`** (run to check CLAUDE.md's freshness) printed commit 46f42ca1's message: "FS-86 chosen …; the close
   inventory opened; the session handoff". No route in it. I opened no diff from 46f42ca1 on.
3. **`BIBLIOGRAPHY.md` row `[Zhang2012]`** (read while locating prior art, which the brief allows): it records that Thm 1.8(i) — with
   a strict ratio inequality and `H` connected, every maximum independent set of `G × H` is a preimage from `G` — "makes every
   periodic four-colouring of a type-(B) field plane a pullback from the dyadic tower (FS-86 plan §0.3 (iii), Poros's FR-1)".
   So I know the plan's V3 route passes through a categorical product and Zhang's structure theorem. I derive V3 my own way
   (Hoffman's equality case on the product, FS38-D2-A), and use Zhang only where my route cannot run; §C2 compares.

## C0 — predicted verdicts, written before any written derivation or computation

Written after reading the brief, `CLAUDE.md` (G21, G30, G43, G54–G59, G66, G68, G75), `LEDGER.md` rows 66, 67, 75, 78, 82, 85,
`plans/FS38-derivation.md` D2-A/D2-B/L1–L3, `plans/FS79-derivation.md` T1/T2/T6, `plans/FS85-derivation.md` dB6/C9/R3a/V2-T8 and the
stub — and after some unwritten thinking about the shape of V1–V3 while reading. Probabilities are that the verdict will be **proved
as stated** (the scope and hypotheses exactly as written in the brief).

| statement | predicted verdict | P(proved as stated) | the risk I see now |
|---|---|---|---|
| V0 | proved | 0.97 | none beyond arithmetic slips; `ℚ₂(√d) = ℚ₂(√3)` for `d ≡ 3 (mod 8)` |
| V1 | proved | 0.95 | the compactness step (`forces_iff_exists_finite`) and translation-invariance of `F`; the inclusion `P(Λ) ⊆ P(R) ∩ Λ` looks elementary |
| V2 | proved | 0.85 | "every non-zero ideal of `R` has finite index": `R = ℤ[U_F]` is not a finitely generated ℤ-module (it holds `1/3`), so this needs `R` to sit with finite index in a Dedekind overring |
| V3 | proved, perhaps with a scope repair | 0.55 | (a) that `R/nR` is the product of the local quotients at the stable places (needs `R` locally maximal and the norm-one group dense in the product of local norm-one groups); (b) that every odd stable place's tower has independence ratio `< 1/4` at **every** level — at 11 I do not yet know whether Hoffman's ratio bound is below `1/4`, and if not the argument needs row 75's certificate plus a product theorem for independence (Zhang), i.e. a heavier input than "free"; (c) the thin margin at 31 |
| V3-ram | proved (with "ratio" read as Hoffman's ratio bound) | 0.7 | "ratio at level 1" is ambiguous (Hoffman bound or true independence ratio); `2/62` looks like a primitive-character Hoffman bound `2·59^{m−1}` against degree `60·59^{m−1}` |
| V4 | proved given V2, V3 | 0.85 | the "distance-4 pair" clause: every `δ` with `|δ| = 4` is `4u`, `u ∈ U`, so the pair `(0,4)` stands for all of them; the finite-graph clause by compactness |
| VK | gap or scope repair | 0.4 | needs `F(R_K) ≠ 0` (Harder's `8/3`, or row 85's `8Λ`, which rests on Parts's trees), V2 over K, and V3's product argument at **two** tight dyadic factors plus K's odd stable places (the two ramified 11-towers, then 83, …); the two-tight-factor step needs dB6's tetrahedron splitting in the product; the 11-adic question is the same risk as V3(b) |

