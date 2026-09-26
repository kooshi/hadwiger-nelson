# FS-100 / crunch ×2×3 — job X27D: TR-ROT and its flip (derivation record)

*de Bruijn (Opus 5.5), job X27D, 2026-09-26, from 11:52 UTC. Brief: `data/crunch-2026-09-26-x2x3/briefs/X27D-tr-rot-derivation.md`
(with `STANDING-RULES.md`, its clock replaced by the brief's stop, 12:50 UTC). Working files `data/fs100/x27d/`; checks `tools/x27d_*.py`.
One mind. A blind verifier, X27V, works on the same claims; no contact.*

## Theorems this phase proved

*(Filled at each stage; grades as `CLAUDE.md` § Notation.)*

| id | statement (one line) | grade | address |
|---|---|---|---|

## Stage 1 — SAVED (quotation check; C0 per claim, sealed before any derivation)

### 1.1 The claims, verbatim from the brief

- **TR-ROT** (brief, "from `plans/FS100-X22D-derivation.md` §2.4"): "Over a type-(B) field, no translation-invariant random four-colouring `μ`
  with `μ(Pull) = 0` has every `U`-Følner average converge onto Pull" (equivalently, by X22D-RT: none is rotationally transient).
- **TR-ROT-flip** (brief, "G79's move, posed by the owner"): "Every translation-invariant random four-colouring `μ` of a type-(B) field's plane
  carries a quantity, invariant under translation and continuous under weak-* limits, that is zero on Pull and positive whenever `μ(Pull) = 0`."
  Name one such quantity, or show that none of a stated kind can exist.

### 1.2 Quotation check (standing rule 5)

| quotation | source checked | result |
|---|---|---|
| TR-ROT | `plans/FS100-X22D-derivation.md` §2.4 (lines "> **TR-ROT.** …") | **verbatim**, including the parenthesis |
| X22D-RT, X22D-QR, X22D-TRM, X22D-EF, X22D-FLK2 (used below) | same file §2.2, §2.3, §3.1, §4.1 | read from source |
| "X22D and X22V (blind) named the step independently" (brief) | `plans/FS100-X22V-verification.md` §2.2 | **true in substance, not in words**: X22V's GAP is "a translation-invariant `μ` with `μ(Pull) = 0` has an `R ⋊ U`-invariant weak-* limit with `ν(Pull) < 1`" — the negation-free form of TR-ROT; same step |
| TR-ROT-flip | posed in the brief; its nearest held source is X22V §2.2: "**a continuous, affine, `U`-invariant functional on `M_T` that vanishes on the Pull-measures and is positive on `M′`**" | **the flip drops two of X22V's three qualifiers** ("affine", "`U`-invariant") and keeps a third that is vacuous on its domain ("invariant under translation": every `μ` in question is translation-invariant). As worded the flip has a trivial witness (Stage 3). I answer the literal flip and the form X22V named (the one that would prove TR-ROT), separately |
| Row 111 (Q-μ, Q-tr), row 112 (Theorem C), row 113, row 120 (MR) | `LEDGER.md` rows 111, 112, 113, 120 | read from source (first 900 characters of each; MR's statement read in full in row 120) |
| MR(F) | row 120: "every `U_F`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure (MR(F))" | verbatim; C-0 (X22D Stage 1) puts ℚ(√59), ℚ(√83), ℚ(√131) inside its scope |

### 1.3 C0 — probabilities before derivation (11:58 UTC, sealed)

| claim | P(TRUE) | P(FALSE) | P(GAP at a named step) | the step I expect to decide it |
|---|---|---|---|---|
| TR-ROT | 0.10 | 0.03 | 0.87 | FALSE is a colouring outside Pull, i.e. row 88's "no" — out of reach in an hour. TRUE needs a way from translation- to rotation-invariance; I expect to be able to push the counterexample's **spectrum** off every part of `E` by the dynamics of `U` on `R̂` (isometric at the archimedean and stable places, hyperbolic at the split ones) and to be stopped by the `E`-null part |
| TR-ROT-flip, literal | 0.90 | 0.02 | 0.08 | as worded ("invariant under translation", no rotation-invariance, no affineness) a weak-* distance to the Pull-measures is a witness; the flip is then empty |
| TR-ROT-flip, X22V's form (affine, `U`-invariant, upper semicontinuous) | 0.10 | 0.05 | 0.85 | such a functional proves TR-ROT outright, so it is as hard as TR-ROT; I expect "no functional of a stated **spectral** kind" to be provable |

### 1.4 Would have searched here (Stage 1)

- None.
