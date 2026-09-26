# FS-100 / crunch ×2×3 — job X27V: TR-ROT and its flip, blind verification (record)

*Coxeter (Opus 5.5), job X27V, 2026-09-26, from 11:53 UTC; stop 12:50 UTC. Brief:
`data/crunch-2026-09-26-x2x3/briefs/X27V-tr-rot-verifier.md` (with `STANDING-RULES.md`, its clock replaced by the brief's stop). Working
files `data/fs100/x27v/`. Blind to X27D until stage 3 is committed (fences as the brief). One mind.*

## Theorems this phase proved

*(Filled at stage 3; grades as `CLAUDE.md` § Notation.)*

## Stage 1 — SAVED (quotation check; C0 per claim, sealed before any written derivation)

### 1.1 The claims, verbatim from the brief

- **TR-ROT** (from `plans/FS100-X22D-derivation.md` §2.4). "Over a type-(B) field, no translation-invariant random four-colouring `μ` with
  `μ(Pull) = 0` has every `U`-Følner average converge onto Pull" (equivalently, by X22D-RT: none is rotationally transient).
- **TR-ROT-flip** (G79's move, posed by the owner). "Every translation-invariant random four-colouring `μ` of a type-(B) field's plane carries a
  quantity, invariant under translation and continuous under weak-* limits, that is zero on Pull and positive whenever `μ(Pull) = 0`." Name one
  such quantity, or show that none of a stated kind can exist.

### 1.2 Quotation check (standing rule 5)

| quotation | source checked | result |
|---|---|---|
| TR-ROT, the quoted sentence and its parenthesis | `plans/FS100-X22D-derivation.md` §2.4, lines 183–184 | **verbatim** (sentence and parenthesis both) |
| X22D-RT, invoked by TR-ROT's parenthesis | same file §2.3 (statement and proof read) | read from source; it is **conditional on MR** ("Given MR(F) at a type-(B) field: …"). TR-ROT itself is stated with no "given MR"; its "equivalently" is an equivalence given MR only. Noted, not a misquotation |
| "every rotation- and translation-invariant random four-colouring is a pullback from the tight place (X22D-QR, X22V-F2)" (brief, Context) | X22D §2.2 X22D-QR; X22V §2.1 X22V-F2 | faithful paraphrase (both: `R ⋊ U`-invariant `μ` carried by Pull, given MR); both one mind each |
| "every four-colouring outside Pull is rigid-motion-transient (X22D-TRM, X22V-R)" (brief, Context) | X22D §3.1; X22V §2.3 | X22D-TRM verbatim in substance; X22V-R is "affinely transient" (invariant measures of the `R ⋊ U`-orbit closure on Pull), which X22V stage 4 identifies with rigid-motion transience through R88-CL — faithful |
| TR-ROT-flip | posed by the owner in the brief; no earlier source | **not a quotation.** Its nearest source is X22V §2.2: "a continuous, affine, `U`-invariant functional on `M_T` that vanishes on the Pull-measures and is positive on `M′`". The flip differs in two words that matter: it asks for invariance **under translation** (every `μ` in its domain is already translation-invariant, so this is vacuous as a constraint on a functional of `μ`), and it drops **affine** and **`U`-invariant**. Stage 2 treats both readings: the flip as posed, and X22V's form, which is the one an averaging argument can use |
| LEDGER rows 88, 111–113, 120, 121 | `LEDGER.md` | read from source (rows 111–113 in full; 88, 120, 121 in full) |
| R88 §G, T-C′'s last sentence | `plans/R88-derivation.md` §G | read from source |

### 1.3 C0 — probabilities, sealed 11:58 UTC, before any written derivation

*Disclosure:* I read X22D §2–§4 and X22V §2 (both open by the brief) before sealing; they shaped these numbers.

| claim | P(TRUE as a mathematical fact) | P(this job ends TRUE / FALSE / GAP) | the step I expect to decide it |
|---|---|---|---|
| TR-ROT | 0.55 (unconditionally it is weaker than Q-μ; given MR it is Q-μ) | 0.03 / 0.02 / 0.95 | given MR, TR-ROT ⟺ Q-μ at type (B) (every `U`-average limit is on Pull by X22D-QR, so "no `μ ∈ M′` has all averages onto Pull" says `M′ = ∅`); no route to Q-μ is known to me |
| TR-ROT-flip, as posed | 0.9 (a distance to the closed set of Pull-measures looks like it qualifies, vacuously) | — | whether "invariant under translation" is a constraint at all on a functional of translation-invariant `μ` |
| TR-ROT-flip, X22V's form (affine or concave, upper semicontinuous, `U`-invariant) | 0.55 (it is Q-μ, given MR) | naming one: 0.03; a no-go for a stated kind: 0.4 | whether pair-correlation functionals can be shown blind (row 91's C0, an archimedean spectrum meeting every two-point constraint) |

### 1.4 Would have searched here (stage 1)

- None.
