# FS-91 crunch job J09v — a blind second reading of J09's "no mixing" theorem (J4) and its corollaries (J4-C, J4-A)

*de Bruijn (Opus 5.5), 2026-09-25, acting as a blind verifier under the brief
`data/crunch-2026-09-25/briefs/J09v-M1-no-mixing-blind.md` (with `data/crunch-2026-09-25/briefs/STANDING-RULES.md`). Blind: J09's record
beyond its quoted lines 364–367, J02's record, the M1 plan, the FS-91 derivation and close files, and every other crunch record were not
opened before the stage-3 verdicts were committed. Data `data/fs91/j09v/`; tools `tools/crunch_j09v_*.py`.*

## Stage 1 — SAVED

### 1.1 Quotation check

| quotation in the brief | source | result |
|---|---|---|
| J4, J4-C, J4-A (brief lines 24–27) | `plans/FS91-S0FV-three-colours-blind.md` lines 364–367, read by `sed -n '364,367p'` and nothing else of that file | **verbatim**, character for character, grade tags included |
| CLG, Lemma C/C′ "in the same file" (brief lines 37–40) | `data/fs91/j07/lemma-statements.md` items 7, 8, 13 | the brief's Lemma C/C′ line is a **paraphrase**, not a quotation; faithful to items 7–8 (the exception "possibly at a ramified stable dyadic place" is item 8's). I use items 7–8 verbatim, never the paraphrase |
| J01-7 (brief line 41) | not in any file I may open (the brief gives no address); the lemma file's `H_k` line states the same inclusion ("`Θ_k(R_F) ⊆ T_{N_k}(R_F) + A(R_F)` for every `F ⊆ ℝ`, some finite `N_k` (input: J03a-8 / J01; not J07's)") | consistent with `H_k`; **unchecked as a quotation**. I use `H_3` in the lemma file's words |
| S1 (brief line 13: "for every real number field, `χ(F²) ≤ 3 ⟺ L(F) ≤ 3`") | M1's plan, fenced | **unchecked** (source fenced). I read J4-C's and J4-A's "S1" as that sentence and say so at each verdict |
| FS-89's notation (`Θ_k`, `A`, `T_N`, band) | `plans/FS89-derivation.md` "Notation, fixed once" | consistent with the brief |
| `[Fischer1990]`'s "additive" | the held PDF (`library/papers/1-s2.0-0012365X9090324B-main.pdf`), abstract and §1 | "a map `v: C₀(F^d) → G` to an additive group `G` of order `k` so that `v(ξ) ≠ 0` whenever `‖ξ‖ = 1`, is said to be an additive k-coloring of `F^d`"; `C₀` is the additive group the unit vectors generate, which is `R_F` in the plane (U is a multiplicative group, so `ℤ[U]` is the additive span of `U`) |

### 1.2 Readings fixed before any derivation

- **"additive character"** (the brief offers two readings): (Fi) Fischer's — a homomorphism `R_F → (1/3)ℤ/ℤ` non-zero on every unit
  vector; (Re) a character factoring through a residue map `R_F → O_𝔓/𝔓` at a stable place and then an additive map to `𝔽₃`. I verify
  under both and say whether they coincide.
- **"ramified stable dyadic prime"**: a conjugation-stable prime of `L = F(i)` above 2 that is **ramified in `L/F`** (the only reading
  under which it is Lemma C′'s exception). The other reading, "ramified over ℚ", excludes more fields (ℚ(√3), ℚ(√11)); I note the
  verdict under it too.
- **"prime above 3 of residue field `𝔽₃`"**: a prime `𝔭` of `F` (a prime of `L` cannot have residue field `𝔽₃`, since `i ∈ L`).
- **`N₃`**: the number of such `𝔭`, as the claim's "one quadruple per prime" fixes it.

### 1.3 C0 — probabilities before derivation

*Written after reading the inputs and a mental sketch, before any written derivation or computation.*

| claim | P(TRUE as stated, under the readings above) | the step I expect to decide it |
|---|---|---|
| J4 | 0.85 | whether every band-3 character at a stable place is one of an `𝔽₃`-place's four (level reduction at 3, the inert dyadic places, the usable `q ≥ 7`), and whether a parity summand `{1/2}` at a second place can hide inside a "mixed" character |
| J4-C | 0.85 | the passage from `χ ≤ 3` to `Θ₃ ≠ ∅` (FS81-T2, resting on FS73-T22 ⟹, hand), and the bipartite case |
| J4-A | 0.60 | what `L(F)` and "a prime above 3 of residue field `𝔽₃`" mean for an infinite algebraic field or a transcendental extension (definitional scope), König's lemma over a tower of finite sets, and the bipartite case |

### 1.4 "Would have searched here" log

| # | move by search I would have made | what I did instead |
|---|---|---|
| — | none at stage 1 | — |
