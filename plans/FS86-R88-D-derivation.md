# Row 88's question — J28D's derivation record (crunch job J28D, de Bruijn, Opus 5.5, 2026-09-25)

*Brief: `data/crunch-2026-09-25/briefs/J28D-row88-derivation.md` (with `STANDING-RULES.md`). Plan: `plans/FS86-row88-rigidity.md` §S.0–S.2,
§M. Targets T-A, T-B1, T-B2, T-C, T-C(A), T-C′ (verbatim in §S.1 there; quoted in §1.1 below). Blind verifier J28V: not read, not messaged.
Data `data/fs86r88/j28d/`; tools `tools/crunch_j28d_*.py`. Grades are `CLAUDE.md` § Notation's.*

## Theorems this phase proved

*(one line each; filled per stage)*

- Stage 1: none (quotation check and priors).

## Stage 1 — SAVED (quotation check, C0, the log)

### 1.1 The quotation check (standing rule 5)

| # | quoted in the brief | source | result |
|---|---|---|---|
| Q1 | §S.0's six definitions and §S.1's six statements, with the controls paragraph (34 non-empty lines) | `plans/FS86-row88-rigidity.md` §S.0–S.1 | **verbatim**: `diff` of the brief's block against the plan's block is empty (the two blocks extracted by `awk`, blank lines dropped) |
| Q2 | S2's gloss "real fields with exactly one stable place whose local planes have `χ_f ≤ 4`, that place four-tight at every level" | `plans/FS86-derivation.md` Notation | **verbatim** (the source breaks the line after "stable place") |
| Q3 | J21-MX, "a compact factor with `λ* < 1/(k−1)` can be deleted from a Borel `k`-colouring of a product" (plan §0.3) | `plans/CRUNCH-2026-09-25-INDEX.md` line 560 | **verbatim**; the theorem itself read in `plans/M3-S1D-windows-five.md` §3.2 |
| Q4 | Theorem C "under H*", D's `𝒳 = T + A + Fin` | `plans/FS86-V-D-verification.md` § VD-C (2) | matches; D's proof is the spectral one with weights, **not** the continuity route of §S.2 |
| Q5 | C14 "with `[AmbrusEtAl2023]`'s `m₁ ≤ 0.2470`", C14′ "proper off a null set" | `plans/FS86-C-Coxeter.md` Round 2 step 5; `plans/FS86-derivation.md` §9 | matches; **scope note carried forward**: C14 reads the tight place at finite level `m` only (its "Not covered (1)": infinite depth), and C14′'s format is "`W(z) ≠ W(z+τ)` whenever `z`, `z+τ` both lie in a conull `Ω`" — not the edge-a.e. format a random extension produces (used in §3) |

**One conflict in the instructions, logged:** standing rule 6 says "never push"; the brief and the launching message say "push; never
force-push". I follow the brief (the job-specific instruction, restated by the owner at launch).

### 1.2 C0 — probabilities per claim (written after reading the sources and one mental pass, before any written derivation)

| claim | TRUE | FALSE | GAP | note |
|---|---|---|---|---|
| T-A (i)–(vi) | 0.90 | 0.03 | 0.07 | (v) rests on the Furstenberg-correspondence lemma for clopen cylinders; (i) needs `τ(U) = U` |
| T-C | 0.55 | 0.05 | 0.40 | the plan's step (2)–(3) cannot use C14′ or J21-MX as black boxes (formats differ); a stationary count is needed |
| T-C(A) | 0.50 | 0.05 | 0.45 | tied to T-C's count |
| T-B1 | 0.05 | 0.01 | 0.94 | a FALSE is a non-pullback, i.e. decides row 88 "no" |
| T-B2 | 0.10 | 0.01 | 0.89 | the same: a FALSE decides row 88 "no" |

*Coherence note on the plan's §P (for the owner):* P-TB1 prices FALSE at 0.10 and P-TB2 at 0.15, while P-decide prices "row 88 decided no" at
0.02. A FALSE for either (a converging family of non-pullbacks; a sparse defect) exhibits a non-pullback four-colouring, hence `F(R) = 0` by
the frame — the two sets of numbers cannot both be right.

### 1.3 Would-have-searched-here log (running)

- (stage 1) Would have sampled colourings of lattice balls over ℚ(√59) agreeing with a pullback on a patch, to price T-B1 and T-B2. Not done
  (ban); both are posed as derivations in §4.
