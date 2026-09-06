# FS-3 — Thickened material: redundancy without stars (STUB, carried from the M55 close; re-read 2026-09-06; DEMOTED the same day)

> **DEMOTED 2026-09-06 (the finite-plane bound, `reference/Chat-analysis/VERIFICATION.md`): no 6-chromatic unit-distance
> graph has coordinates in K(√247) — the field has a degree-one prime above 11 and χ(UD(𝔽₁₁,2)) = 5, so every graph in it
> is 5-colourable by the pulled-back colouring (W's 5,773 edges verified to land on the circle). The F₂₄₇ cross thickening can
> move the redundancy dial but can never reach six. The stub is kept for its measurements (T24, the 108 asks, whose result
> is still to be read); it reopens only in a 6-open field (`plans/M58-field-sieve.md`).**

*M55's paths-forward item 1, now a stub of its own so the frontier set holds it. Read beside this:
`plans/M55-absorption.md` §R4 (the F₂₄₇ cross thickening), §R6 (the full-pool critical set: a unit triangle
through the centre), `plans/STANDING-QUESTIONS.md` T24 (the copy-side asymmetry), `CLAUDE.md` G39, G40,
`Proofs/HadwigerNelson/{CriticalSet,Absorb}.lean`.*

## 1. Mission context, in plain language

A 5-tight unit-distance graph must first be REDUNDANTLY 5-chromatic: M54's theorem says a pair forced equal at the
graph's own chromatic number confines the critical vertices (those whose deletion drops the chromatic number) to
the pair's two glue points — none if the pair is more than 2 apart. Every 5-chromatic witness we hold is
vertex-critical or nearly so, and every union of spindle copies over one fabric is ABSORBED (M55): a copy hangs by
its fused centre and one chord, so the base's colourings all extend and nothing among the base is ever forced.
The one construction that moved the redundancy dial is thickening: the witness W (a K-core and its rotated copy
in F₂₄₇ = ℚ(√3, √11, √247)) grown by the glue points of its cross pairs — at depth two the critical set fell from
1,172 to 937, all 238 freed vertices on the copy side (T24), and the full-pool grown stage's critical set is a
single unit triangle through the centre (3 of 10,541). The thickened object is neither a star nor absorbable, and
it is the first object where neither localization theorem applies.

## 2. What we know, and what is in flight

| fact | where |
|---|---|
| depth-2 cross-only thickening: 0.65 % of cross pairs glue in-field; 64 % of the pool at degree ≥ 5; C: 1,172 → 937, copy side only | M55 §R4, `data/m55/cross-lattice-depth2-crossonly-*.json` |
| the full-pool stage (10,541 points): C = a unit triangle through the centre; its 108 theorem-admitted virtual-edge asks at five colours are RUNNING (Kooshi's instruction to leave them; `build/m55/ask-depth2.log`, result `data/m55/ask-W-plus-cross-depth2-k5.json`, exit 3 = jackpot; registered P-M55-10: 0 hits) | M55 §R6; the jobs ledger |
| M56's reading of the same object: no additive 4-colouring on W (the spindle chord ∈ 4Λ); 432 additive 5-colourings; sampled 5-colourings at the random baseline from the additive family | M56 §R3 |
| the copy-side asymmetry has no derivation yet (T24) | T24 |

## 3. Derivations first

**D1 — T24.** Why does the rotation free copy-side vertices only? The construction is symmetric in the two cosets
(glue points of (core, copy) pairs), so the asymmetry is in the rotation against the fabric's ladder structure
(T13). Derive which coset the pool's unit edges favour; predict that adjoining the pool's image under R⁻¹ (the
symmetric thickening) frees both sides.

**D2 — what a thickened object's five-colour compulsion would look like.** With C empty and no absorbable piece,
both localization theorems are silent; the additive theory (M56) still bounds: F_true ⊆ F_add ∩ F_K, and on W
F_add at five has 291 pairs all separated non-additively. On the thickened stage compute F_add first (the
`forced` subcommand with the exact stage — the full-pool stage's coordinates are in F₂₄₇, `five_dial.KExt`) and
sweep only its members: the additive pre-filter makes the five-colour sweep of a 10,000-point object a list of a
few hundred asks instead of 50 million pairs.

## 4. Phases

| phase | what | cost |
|---|---|---|
| 0 | read the 108-ask result (in flight); D1, D2 | a day |
| A | the symmetric thickening (the pool's R⁻¹-image adjoined) and its criticality census; the exact F₂₄₇ coordinates of the grown stages through `KExt` | hours (the census is one 4-colour ask per vertex: 10,541 × ~3 s / 24 workers) |
| B | F_add at five on the thickened stages (`additive.py forced --witness … --k 5 --all`), then the sweep restricted to F_add's members under the jackpot protocol | hours |
| C | depth three if the dial keeps moving; close | |

## 5. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | the 108 asks read 0 hits (P-M55-10 as registered) | high |
| P2 | the symmetric thickening frees core-side vertices (T24's reading) | medium |
| P3 | F_add at five on the depth-2 thickened stage has under 2,000 members, and every one is separated by the solver | medium |

## 6. Failure and jackpot clauses

A five-colour forced pair or virtual edge on any thickened stage — verified by the M55 protocol (second encoding,
jackpot file, exit 3) — is χ(ℝ²) ≥ 6 by the spindle theorem: HALT. P2 refuted: T24's reading is wrong and the
rotation's role is different; derive again before thickening deeper.

## 7. Bearing on 6, honestly

Medium. It is the only construction that has moved a redundancy dial, and it is the natural bed for the additive
pre-filter; but nothing in it says WHY a thickened object would become tight, and the additive gauge (M56) says
W's colourings are far from any algebraic skeleton. It advances by measurement, where FS-1 advances by derivation;
both are worth holding.

## 8. Addresses

`tools/five_dial.py` (`cross-lattice --depth 2 [--cross-only]`, `critical`, `ask`), `tools/absorb_dial.py`
(`cross2`), `data/m55/cross-lattice-depth2-*.json`, `data/m55/critical-W-plus-cross-depth2-crossonly.json`,
`data/m54/critical-W-plus-cross-depth2.json` (untracked at the M56 close — in use by the running asks; move to
`data/m55` when they end), `data/m54/witness-exact-core-8over3.json`.
