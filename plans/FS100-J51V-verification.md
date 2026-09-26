# FS-100 stage 4 — J51V, blind verification of the Kronecker-selection claims (KS-1 to KS-5, KS-C, K0)

*Verification record of crunch job **J51V** (Coxeter, Opus 5.5, 2026-09-25). Brief:
`data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md`, with `data/crunch-2026-09-25/briefs/STANDING-RULES.md` as part of it, and the
owner's launch notes (the fence does not cover J51V's own commits and report; commits are seen by subject only). No subagents; no finite-witness
search (ban to 2026-10-01); I touch only this file, `data/fs100/j51v/`, `tools/j51v_*` and my report. A derivation job (J51D) works the same
claims; I have not contacted it and have not opened its files.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| J51V-L0 | `T + A` is pure in `R̂`; so `K̂′` is a direct summand of `ℤⁿ` and `Θ = (Φ, B)` after a unimodular change of basis, `K′ ≅ cl Φ(R)` | [hand] | §2.0 |
| J51V-KS2 | KS-2: under KS-sat, any measurable selection from the essential colours on the `K₀`-cosets is a proper `W′` on `K′` | [hand] | §2.3 |
| J51V-X1 | over ℚ, `Θ = (θ + ψ_w, θ + ψ_w̄)` (`θ` the dyadic parity, `ψ_w, ψ_w̄` the two primes above 5) and `W = 2⌊2t₁⌋ + ⌊2t₂⌋` satisfy KS-1's hypothesis with `K̂′ = 0`: KS-1 and KS-3 are FALSE | [hand + tools exact] | §2.4, §2.5; `tools/j51v_cross.py` |
| J51V-X2 | the same over every real number field with a stable dyadic place ramified in `L/F`; the `k²`-colour analogue of KS-1 fails over every real number field; `0 ∉ cl Θ(U)` forces no non-zero `m·Θ` into `T + A` (no naive vector band rigidity) | [hand] | §2.4 |
| J51V-N1 | KS-1 holds at `n = 1` over every real number field, given row 98 | [hand] | §2.4 |
| J51V-EQ | over any real number field where T-C(A) holds at `S = ∅`, KS-1 at `F` ⟺ X at `F`; X holds for `Θ ∈ Eⁿ` given T-C(A) at every finite `S`, and at `n = 1` given row 98 | [hand] | §2.6 |
| J51V-K4, K5 | the controls KS-4, KS-5 hold (KS-5 with "image" read "closure of the image") | [hand + tools exact (C5)] | §2.1, §2.2 |
| J51V-K0 | J45's SP-Cor and A⁺ at `S = ∅` hold with J45's proofs over every real number field where T-C(A) holds at `S = ∅`; ℚ(√143), ℚ(√311), ℚ(√335) are in T-C(A)'s class | [hand; membership tools exact, not blind] | §2.7; `tools/j51v_class.py` |

## Stage 1 — SAVED (quotation check, fence log, C0)

### 1.1 Quotation check (standing rule 5)

| # | quoted in the brief | source | result |
|---|---|---|---|
| Q1 | the fixed claim list KS-1 … K0 ("verbatim; written before any claim was derived") | the FS-100 plan, which is **fenced** | **not checkable** blind; logged. KS-1 compared instead with the stub's open quotation of J37 §4.5 R2 (`plans/STUB-measure-rigidity-three-fields.md` §3, first block quote): KS-1 is a *formalization*, not a quotation — J37's `K′` is "a closed subgroup `K′ ⊆ Tⁿ`, the closure of the image of `Θ`'s `(T + A(R_F))`-part", KS-1's is the quotient `K/K₀` by the annihilator of the combinations `m` with `m·Θ ∈ T + A`; J37's `W` lives on `Tⁿ`, KS-1's on `K`; J37 says "Prove or refute", KS-1 asserts. KS-4 agrees in substance with J37's control ("over ℚ(√11) with `Θ = (θ_{C9}, θ₁)`, `θ₁ ∉ E`, W reading only the first coordinate must pass"). |
| Q2 | Notation: "`T` the torsion characters, `A(R_F)` the archimedean ones, `E = ⋃_S (T + A + Fin_S)` (`Fin_S`: continuous at the finite set `S` of split places) — `LEDGER.md` rows 98, 113" (not in quotation marks) | rows 98, 113 | agrees: row 98 "`A(R_F) = Hom_ℚ(F(i), ℝ) mod 1` the archimedean characters of every place of `F(i)`"; row 113 "`T + A + Fin_S` (`S` a finite set of split places, the dyadic one included)". `E = ⋃_S` is the stub's §2 notation, not the rows' |
| Q3 | "row 98 (band rigidity at every band, `Θ_k(R_F) ⊆ T + A`)" | row 98 | agrees; the row has the sharper `T_{N_k}(R_F) + A(R_F)`. Band: `Θ_k = {θ : θ(U) ⊆ B_{1/k}}`, `B_β = {z : ‖z‖ ≥ β}` (`plans/FS91-derivation.md` notation) |
| Q4 | "row 109 (M3-J21-MX, the mixing selection, `plans/M3-derivation.md`)" | row 109 | agrees |
| Q5 | "row 96 (`Θ₄(ℚ(√47)) = ∅`)" | row 96 | agrees ("ℚ(√47)'s plane has no character four-colouring (`Θ₄ = ∅`)") |
| Q6 | "row 94 (C9)" | row 94 | agrees |
| Q7 | "R88-TCA (T-C(A), `plans/R88-derivation.md`)" | `plans/R88-derivation.md` §2 | agrees; the statement: "over ℚ(√47), and (J28D) over every real field whose stable places all have all-levels ratio `< 1/4`, no translation-invariant Borel probability on `X₄(F)` has spectral measure carried by `T + A + Fin_S` for a finite set `S` of split places, dyadic ones included" — two derivations at ℚ(√47), **one mind (J28D) over the class** |
| Q8 | "row 105 and Lemmas C, C′ (`R = O′`)" | rows 105, 100 | **mild mismatch:** row 105 is prime inversion in valuation form and does not state `R = O′`; `R_F = O′` is Lemma C′ (row 100, FS91-J07-4). Harmless |
| Q9 | "J45's lemma statements (`plans/FS84-SI-D-derivation.md` §5.4: SI-1 to SI-5, RU, SP-oi, SP-if, A⁺, B⁺)" | J45 §5.4 | **mismatch:** §5.4 lists SI-1 … SI-5, R-U, SP-if, A⁺, B⁺ (and N1, N2, SI-J, G2-11, SI-C, SP-Cor) but **not SP-oi**; SP-oi is in J45's theorems table ("J45-SP-oi — SP's 'only if'") and §4.2 ("Lemma SP-only-if"). Harmless |
| Q10 | "Berend 1983/1984 and Furstenberg 1967 (held)" | `BIBLIOGRAPHY.md` | keys `[Berend1983]`, `[Berend1984]`, `[Berend1984min]`, `[Furstenberg1967]` resolve |

### 1.2 Fence log — one accidental breach, recorded

While looking for Lemma P I ran `grep -rn "Lemma P" plans/*.md`, which does not exclude fenced files. Its output printed **eight lines of the
fenced `plans/FS100-three-field-lemma.md`** (its lines 44, 52, 59, 60, 74, 82, 91, 172) and **one line of `plans/FS100-close-inventory.md`**
(row 1; that file is not on the fence list, but it carries J51's results, so I treat it as fenced in spirit). What I saw, in substance: a result
"J51-T1: real quadratic ℚ(√d) is in T-C(A)'s class ⟺ `d ≡ 47, 143, 167 (mod 168)` ⟺ `L ≥ 5`; ℚ(√143), ℚ(√311), ℚ(√335), ℚ(√167) in class",
a table row "ℚ(√143) … 11 ramified: FS-66 via Lemma P (ii); 31 split: Hoffman … yes", and pointers to `plans/FS86-B1-verification.md` Lemma P (ii).
**What it contaminates:** K0's parenthetical (class membership of the three fields) — my check of it is **not blind**. Nothing I saw bears on
KS-1 to KS-5 or KS-C. **Repair:** from here on every search excludes the fenced files by name. Opened on purpose, all open: rows 94–113;
`plans/FS84-SI-D-derivation.md`; `plans/R88-derivation.md`; `plans/FS84-S1-derivation.md` §1.3; `plans/FS86-B1-verification.md` (grep only);
the stub up to and including §3's first block quote.

### 1.3 C0 — probabilities per claim

*Honest timing note (G21).* The first column is my estimate on first reading the claim list. Before I wrote this table, while reading the inputs,
the split-place torus (`y ↦ (y, y⁻¹)` at a place split in `L/F`) came to mind as a way to make `cl Θ(U)` thin — so KS-3's and KS-1's
numbers at the time of writing are informed by a candidate counterexample not yet checked. Both columns are given; stage 2 scores the first.

| claim | first read: TRUE / FALSE / GAP | at writing: TRUE / FALSE / GAP | note |
|---|---|---|---|
| KS-1 | 0.55 / 0.20 / 0.25 | 0.15 / 0.75 / 0.10 | the selection must lose nothing when it drops the non-`(T + A)` combinations |
| KS-2 | 0.85 / 0.03 / 0.12 | 0.85 / 0.03 / 0.12 | Fubini over `K₀`-cosets; risk: measurability of the selection |
| KS-3 | 0.35 / 0.35 / 0.30 | 0.10 / 0.85 / 0.05 | a strong universal (every `F`, `n`, `Θ`) |
| KS-4 | 0.92 / 0.02 / 0.06 | 0.92 / 0.02 / 0.06 | `W` reads only the `(T + A)` coordinate |
| KS-5 | 0.88 / 0.04 / 0.08 | 0.85 / 0.05 / 0.10 | as KS-4 after a unimodular change of basis; wording of "the image" |
| KS-C | 0.75 / 0.05 / 0.20 | 0.70 / 0.05 / 0.25 | an implication; the pull-down's spectrum must land on `T + A` |
| K0 | 0.80 / 0.05 / 0.15 | 0.80 / 0.05 / 0.15 | "the same proofs": does anything in A⁺ / SP-Cor read ℚ(√47) itself? |

### 1.4 Would-have-searched-here log (running)

- (none yet)

## Stage 2 — SAVED (blind derivation, claim by claim; controls first)

**Conventions.** Characters additive, `R̂ = Hom(R, ℝ/ℤ)`. `‖z‖` is the distance to 0 in `ℝ/ℤ`. "Proper" for `W` on `K` is read as
"for every `s ∈ cl Θ(U)`, `W(t) ≠ W(t + s)` for Haar-a.e. `t`" (the order that the colouring's properness produces, J51V-L2); every example
below satisfies the stronger "for every `t`", so no verdict turns on the order.

### 2.0 Three lemmas used throughout [hand]

- **J51V-L0 (purity).** `T + A` is pure in `R̂`: if `kθ = τ + α` (`k ≥ 1`, `τ ∈ T`, `α = f mod 1`, `f ∈ Hom_ℚ(L, ℝ)`) then `α/k := (f/k) mod 1 ∈ A`
  and `k(θ − α/k) = τ` is torsion, so `θ − α/k ∈ T` and `θ ∈ T + A`. Hence `K̂′` is saturated in `ℤⁿ`, a direct summand, and a unimodular change
  of basis (an automorphism of `Tⁿ`, carrying `K`, `K₀`, `cl Θ(U)` and `W`) puts `Θ = (Φ, B)` with `K̂′ = ℤ^r × 0`, `Φ ∈ (T + A)^r`, and
  `m·B ∉ T + A` for `m ≠ 0`. Then `K₀ = K ∩ (0 × T^{n−r})` and `π` is the projection `K → cl Φ(R)`, an isomorphism `K/K₀ ≅ cl Φ(R)` (a
  continuous bijective homomorphism of compact groups).
- **J51V-L1.** `cl π(Θ(U)) = π(cl Θ(U))` (`π` continuous, `K` compact).
- **J51V-L2.** For measurable `W` on compact `K`, `s ↦ m{t : W(t) = W(t + s)} = Σ_c ⟨1_{W=c}, 1_{W=c}(· + s)⟩` is continuous, so properness at every
  `s ∈ Θ(U)` gives it at every `s ∈ cl Θ(U)`; and `x ↦ W(Θ(x) + t)` is proper for a.e. `t ∈ K` iff `W(t) ≠ W(t + Θ(u))` for a.e. `t`, every `u`
  (countably many pairs; `t ↦ Θ(x) + t` preserves Haar). If `t` is read in `Tⁿ` instead of `K`, Fubini over `Tⁿ/K` gives a coset `c + K` on which
  `W_c = W(c + ·)` is proper on `K`: the two readings of "the colouring is proper for almost every `t`" feed KS-1 the same hypothesis.

### 2.1 Control KS-4 — TRUE [hand + tools exact (C5)]

`θ_{C9} = τ₇ + α`: `τ₇ = (2x + 3y)/7` read at a stable prime above 7 (torsion, order 7), `α ∈ A` with `a := sup_U ‖α‖ < 1/28` (my reading of
"an archimedean term below `1/28`"). On the 8 points of `x² + y² = 1` over `𝔽₇`, `2x + 3y ∈ {2, 3, 4, 5}` (C5, exact), so
`θ_{C9}(U) ⊆ [2/7 − a, 5/7 + a] ⊆ [1/4, 3/4]`, and so is its closure. `K̂′ = {m : m₁θ_{C9} + m₂θ₁ ∈ T + A} = {m : m₂θ₁ ∈ T + A} = ℤ × 0` (L0:
`m₂ ≠ 0` would put `θ₁ ∈ T + A ⊆ E`). So `K₀ = K ∩ (0 × T)`, `π = p₁`, `K′ ≅ cl θ_{C9}(R)`, and `W = ⌊4t₁⌋ = W′ ∘ p₁` with `W′ = ⌊4·⌋`. Every
`s ∈ cl Θ(U)` has `p₁(s) ∈ [1/4, 3/4]`, and two points of one half-open quarter `[j/4, (j + 1)/4)` are at distance `< 1/4`: `W(t) ≠ W(t + s)` for
**every** `t`. `W′` is proper on `K′` for `cl π(Θ(U)) = p₁(cl Θ(U)) = cl θ_{C9}(U)` by the same line. ∎
**What a wrong-reason pass looks like.** `W` factors through `π`, so the control passes for **every** definition of `K̂′` that keeps
`(1, 0)` — `E` in place of `T + A`, or J37's per-component "`(T + A)`-part" — and whatever `cl Θ(U)` is: it never exercises KS-sat or a
selection. Its failure is reachable only through a `K̂′` that drops `A` (with `T` alone, `α ≠ 0` gives `K̂′ = 0`, `K′ = {0}`, and no `W′` exists).
So a pass certifies that `A` is in `K̂′`'s definition, and nothing about KS-1 for a `W` that reads a non-`(T + A)` coordinate.

### 2.2 Control KS-5 — TRUE, with one wording repair [hand]

`Θ = (θ_{C9}, θ_{C9} + θ₁)`: `m·Θ = (m₁ + m₂)θ_{C9} + m₂θ₁ ∈ T + A` iff `m₂ = 0` (L0). So `K̂′ = ℤ × 0`, `K₀ = K ∩ (0 × T)`, `π = p₁`,
`W = ⌊4t₁⌋ = W′ ∘ p₁`, proper for every `t` as in KS-4; `W′ = ⌊4·⌋` ✓. **"`K′` is the image of `θ_{C9}`"** holds as "`K′ ≅ cl θ_{C9}(R)` via `p₁`":
`θ_{C9}(R)` itself is countable, and dense (not closed) whenever `α` is not torsion, so "image" must be read "closure of the image" and "is" as
"is identified with, by the first coordinate". A wording repair, not a mathematical one.
**Wrong-reason pass.** As KS-4, and in addition the identification passes under J37's per-component reading too (there `K′` is the closure of the
diagonal `(θ_{C9}, θ_{C9})(R)`, isomorphic to the same group), so the control does not tell the two formalizations apart; and it passes whether or
not `cl Θ(U)` is `K₀`-saturated (that depends on `θ₁`, which `W` never reads).
**The control neither has.** A `W` that reads a non-`(T + A)` coordinate. §2.4's example is one; it fails KS-1.

### 2.3 KS-2 — TRUE [hand]

Assume KS-1's hypotheses and KS-sat. Let `m₀` be Haar on `K₀` and `P_c(t) = m₀{k : W(t + k) = c}` — Borel on `K` (Tonelli; replace `W` by a Borel
version off a null set), `K₀`-invariant, so `P_c = Q_c ∘ π` with `Q_c = P_c ∘ σ` for a Borel section `σ` of `π` (compact metrizable groups).
Fix `s′ ∈ cl π(Θ(U)) = π(cl Θ(U))` (L1) and `s ∈ cl Θ(U)` with `π(s) = s′`. By KS-sat every `s + k`, `k ∈ K₀`, lies in `cl Θ(U)`, so
`∫_K 1[W(t) = W(t + s + k)] dt = 0`; integrating over `k` and swapping (Tonelli), `∫_K P_{W(t)}(t + s) dt = 0`. By Weil's formula
`∫_K f = ∫_{K′} ∫_{K₀} f(σ(t′) + k) dk dt′`, this is `∫_{K′} Σ_c Q_c(t′) Q_c(t′ + s′) dt′ = 0`. So for a.e. `t′` the essential colour sets
`M(t′) = {c : Q_c(t′) > 0}` (never empty: `Σ_c Q_c = 1`) and `M(t′ + s′)` are disjoint, and any measurable selection `W′(t′) ∈ M(t′)` — which is
the claim's "any measurable selection from the colours `W` takes on a positive-measure part of `t + K₀`" — has `W′(t′) ≠ W′(t′ + s′)` for a.e.
`t′`. ∎ No step reads the field.

### 2.4 KS-1 — FALSE, with a counterexample over ℚ [hand + tools exact]; TRUE at `n = 1` [hand]

**Counterexample (J51V-X1).** `F = ℚ`, `L = ℚ(i)`, `R = ℤ[i][1/q : q ≡ 1 (mod 4)]`, `U = {z/z̄ : z ∈ ℤ[i] ∖ 0}` (Hilbert 90). Take `p = 5 = ππ̄`,
`π = 2 + i`, `ι : ℚ(i) → ℚ₅` with `ι(i) ≡ 3 (mod 5)` (so `v(ι(π)) = 1`, `ι(π̄)` a unit), `ψ₅ : ℚ₅ → ℚ₅/ℤ₅ ⊂ ℝ/ℤ` the fractional part, and
- `ψ_w(x) = ψ₅(ι(x))`, `ψ_w̄(x) = ψ₅(ι(x̄))` — characters of `R` continuous at the split place 5 (they read the two primes above it);
- `θ(x) = ½·(x mod (1 + i))` — the dyadic parity character (`R/(1 + i)R = 𝔽₂`; `(1 + i)` is stable and ramified in `L/ℚ`); `θ(u) = ½` for every
  `u ∈ U` (`uū = 1` makes `u ≢ 0`, so `u ≡ 1`).

Let `n = 2`, `Θ = (θ + ψ_w, θ + ψ_w̄)`, `W(t₁, t₂) = 2⌊2t₁⌋ + ⌊2t₂⌋`.
1. *The cross.* For `u ∈ U`, `ι(ū) = ι(u)⁻¹`; of `y = ι(u) ∈ ℚ₅^×` and `y⁻¹` one lies in `ℤ₅`, so one of `ψ_w(u)`, `ψ_w̄(u)` is 0 and
   `Θ(u) ∈ ({½} × T) ∪ (T × {½})`, a closed set; so `cl Θ(U)` lies in it.
2. *`W` is proper* — for every `t` and every `s` in that set: adding `½` to a coordinate flips `⌊2·⌋` in it.
3. *`K̂′ = 0`.* `m·Θ = (m₁ + m₂)θ + m₁ψ_w + m₂ψ_w̄`, so `m ∈ K̂′` iff `χ := m₁ψ_w + m₂ψ_w̄ ∈ T + A`. Say `χ = τ + α`, `Nτ = 0`, `α = f mod 1`. `χ`
   vanishes on `R₀ = {x ∈ R : x integral at π, π̄}`, so `Nf(R₀) ⊆ ℤ`; `R₀ ∋ 13^{−k}, i·13^{−k}` gives `f(1) = f(i) = 0`, so `f = 0` and `χ` is
   torsion. But `χ(π^{−k}) = m₁ψ₅(ι(π)^{−k})` (`ι(π̄)^{−k}` is a unit) has order `5^k / gcd(5^k, m₁)`, unbounded unless `m₁ = 0`; and `π̄^{−k}` gives
   `m₂ = 0`. (`π^{−1} = π̄/5 ∈ R`.)
4. So `K = T²` (its annihilator lies in `K̂′ = 0`), `K₀ = ann_K(0) = K`, `K′ = {0}`, `cl π(Θ(U)) = {0}`, and KS-1's conclusion asks for
   `W′(0) ≠ W′(0)`: **false**, while its hypothesis holds (steps 1–2). ∎

*The colouring it describes* is `x ↦ W(Θ(x) + t)`, a proper four-colouring of ℚ² for every `t`: the parity two-colouring written twice, each copy
hidden inside a character that is not in `T + A`. The quotient `K/K₀` keeps only the combinations lying in `T + A`, and here there are none: the
`T + A` information lives only *inside* components that are not themselves in `T + A`, and the combination-based `K̂′` discards it. Checked
exactly by `tools/j51v_cross.py` (C1–C4 on a complete enumeration fixed in advance: 3,920 unit vectors `z/z̄`, `|m|, |n| ≤ 40`, 1,272 with a
pole above 5; properness on 4,000 edges `(x, x + u)` with rational `t`; the orders in step 3 for `k ≤ 8`); plants `same-prime` (both coordinates read
`w`: 865 failures) and `no-parity` (7,180 failures) fire, exit 1 (`data/fs100/j51v/cross-*.out`).

**How far it reaches (J51V-X2) [hand].** (a) The same construction works over every real number field with a stable dyadic place ramified in
`L/F` (every unit vector is `≡ 1` there — G56's ramified case — so a functional `λ` of the residue field with `λ(1) = 1` gives `θ(U) = {½}`) and
any place split in `L/F` (normalise `ψ_w` to kill exactly `O_v`); ℚ(√5) and ℚ(√2) are examples. (b) With any band character `θ` (`I = cl θ(U) ∌ 0`)
and a `k`-colouring `g` of `(T, I)` in place of parity, `Θ = (θ + ψ_w, θ + ψ_w̄)` has `cl Θ(U) ⊆ (I × T) ∪ (T × I)`, `K̂′ = 0`, and
`(g(t₁), g(t₂))` is a proper `k²`-colouring: the `k²`-colour analogue of KS-1 fails over **every** real number field (take `k = χ_char(F²)`, finite
by CLG). (c) **Vector band rigidity is false:** `0 ∉ cl Θ(U)` does not force any non-zero `m·Θ` into `T + A` (so row 98 has no naive vector form).
(d) At four colours the mechanism needs `k = 2`, a two-colour `T + A` character, i.e. a bipartite plane; over ℚ(√47) it is unavailable, and any
four-colour counterexample there would be a four-colouring of the plane (see KS-C).

**KS-1 at `n = 1` is TRUE over every real number field, given row 98 (J51V-N1) [hand].** If `θ ∈ T + A`, `K̂′ = ℤ` (mod the annihilator),
`K₀ = 0`, `K′ = K`, `W′ = W`. If `θ ∉ T + A` and a proper `W` exists, then `0 ∉ cl θ(U)` (else `s = 0` violates properness), so
`‖θ(u)‖ ≥ ε > 0` on `U`, `θ ∈ Θ_k` for `k ≥ 1/ε`, and row 98 puts `θ ∈ T + A` — a contradiction; so the hypothesis never holds. ∎ (This is the
rank-one statement T-J37-1 at the level of the selection.)

### 2.5 KS-3 — FALSE [hand + tools exact]

The example of §2.4: `K₀ = K = T²` and `cl Θ(U) ⊆ ({½} × T) ∪ (T × {½}) ≠ T²`, so `s + K₀ ⊄ cl Θ(U)` for every `s ∈ cl Θ(U)`. Even without
parity, `Θ = (ψ_w, ψ_w̄)` has `cl Θ(U) ⊆ (T × 0) ∪ (0 × T)` with `K = K₀ = T²`. **The mechanism:** at a place `v` split in `L/F` the norm-one torus
is `F_v^×` embedded as `y ↦ (y, y⁻¹)` in `L_w × L_w̄`, and characters reading the two primes see only a cross — one coordinate is always
integral. KS-sat fails at every real number field (every field has split places). **Not decided:** KS-sat at `n = 1` (there it says `θ(U)` is
dense in `cl θ(R)` for `θ ∉ T + A`); not needed for any verdict.

### 2.6 KS-C — TRUE as an implication; the route is circular at ℚ(√47) [hand]

*The derivation.* Let `x ↦ W(Θ(x) + t)` be proper for a.e. `t`. By L2, `W` (on `K`, after choosing a coset if `t` was read in `Tⁿ`) satisfies
KS-1's hypothesis. KS-1 gives `W′` on `K′`, and `c′_{t′}(x) = W′(π(Θ(x)) + t′)`, `t′` Haar on `K′`, is proper almost surely (countably many pairs,
L2), translation-invariant (`c′_{t′}(x + y) = c′_{t′ + πΘ(y)}(x)`), and its trace spectral measure is
`Σ_{χ ∈ K̂′} (Σ_j |f̂_j(χ)|²) δ_{χ∘π∘Θ}`, `f_j` the coordinates of `e_{W′}` — carried by `{m·Θ : m ∈ K̂′} ⊆ T + A = T + A + Fin_∅`. T-C(A) at
`S = ∅` forbids it. So "KS-1 over ℚ(√47) ∧ T-C(A) at `S = ∅` ⟹ X", X the claim's conclusion. ∎
*What it is worth.* (i) KS-1 as stated is FALSE (§2.4), so read as a material conditional with KS-1's universal statement as antecedent the claim
is vacuously true. (ii) Read with KS-1 restricted to ℚ(√47), the step is valid but **the input is equivalent to the output** (J51V-EQ, below).
(iii) What is proved of X without KS-1: **X for `Θ ∈ Eⁿ`** — every component in `E` puts every `m·Θ` in one `E_S`, `S` the union of the
components' sets, and T-C(A) at that `S` (two derivations at ℚ(√47), the split dyadic place included) forbids the spectrum; **X at `n = 1`** — J51V-N1
plus T-C(A) at `S = ∅` (T-J37-1's content). **Open:** `n ≥ 2` with some `m·Θ ∉ E` — the pure-point layer of FS-100's gap, unchanged.

**J51V-EQ [hand].** Over any real number field where T-C(A) holds at `S = ∅`: KS-1 at `F` ⟺ X at `F`. (⟸: if X holds no proper `W` exists,
by L2, so KS-1 holds vacuously; ⟹: the derivation above.) So the Kronecker selection cannot be an *independent* input to X at ℚ(√47): a proof of
KS-1 there must use the field's arithmetic (the uniform statement is false), and whatever it uses would already prove X.

### 2.7 K0 — TRUE, with a scope note on A⁺ [hand; the class membership tools exact, **not blind** (§1.2)]

*The same proofs.* J45's A⁺ (Stage 3) uses SI-4, N2 and T-C(A) at the `S` in question; SP-Cor (§4.2) uses the existence of an `R ⋊ U`-invariant
measure on `X₄(F)` (compact, `R ⋊ U` amenable; `v ∈ U` is a unit of `R` with `vU = U`, so `x ↦ vx + y` is an automorphism of `Cay(R, U)`),
R-U (proved by J45 "for every real number field"), A⁺ at `S = ∅` with its remark (ii) (`σ_μ` and `E_S` are `U`-invariant) — and nothing else.
N1's density step is weak approximation for the norm-one torus, valid over every real number field; SI-1 to SI-4 and N2 are field-free. No step
reads ℚ(√47) except through T-C(A). So over every real number field `F` (quadratic or not) where T-C(A) holds at `S = ∅`: **SP-Cor holds**
("if every finite positive `U`-invariant `E`-null measure on `R̂` is a Haar multiple, `χ(F²) ≥ 5`"), and **A⁺ holds at `S = ∅`**; **A⁺ at a
given finite `S` needs T-C(A) at that `S`**. *Scope note:* "A⁺ … given T-C(A) there at `S = ∅`" delivers J45's A⁺ (every finite `S`) only if
"in T-C(A)'s class" is read as supplying T-C(A) at every `S` — which J28D's class form does (one mind outside ℚ(√47)); from `S = ∅` alone the
proof yields A⁺ at `S = ∅`, which is all SP-Cor uses.
*The parenthetical.* By `tools/j51v_class.py` (Legendre symbols, exact; controls ℚ(√47) in, ℚ(√59), ℚ(√11), ℚ(√23), ℚ(√31) out; plant
`forget-seven` fires on ℚ(√23)): ℚ(√143), ℚ(√311), ℚ(√335) have `d ≡ 7 (mod 8)` (dyadic place split in `L/F`) and neither 3 nor 7 stable; their
stable odd places below 100 are {11 ram, 31, 43, 47, 59, 67, 71, 79}, {11, 19, 23, 31, 43, 59, 71}, {11, 23, 31, 47, 67 ram, 79, 83}. With FS-66's
certificates at 11 and 19 (the ramified 11 of ℚ(√143) through Lemma P (ii), `plans/FS86-B1-verification.md`), Hoffman + Lemma P at 23, 31, 43, 47
(`plans/FS84-S1-derivation.md` §1.3 step 8) and Weil + Hoffman + Lemma P from 37, every stable place has all-levels ratio `< 1/4`: all three are in
the class. (That the ramified 11 is covered through Lemma P (ii) I learned from a fenced line before checking it in the open source; the
Legendre work was done before the breach.)

### 2.8 Would-have-searched-here log (stage 2)

- Would have searched for a four-colour counterexample to KS-1 over ℚ(√47) with non-`E` characters (random character vectors, a finder for `W`
  on a discretised torus). Instead: derived the split-place cross; showed any four-colour counterexample at ℚ(√47) is a four-colouring of the
  plane (J51V-EQ), so there is nothing to search for short of the conjecture's falsifier.
- Would have sampled `cl Θ(U)` in floating point to test KS-sat. Instead: derived `ψ_w(u)ψ_w̄(u) = 0`-type identity from `u_w u_w̄ = 1` and
  checked it exactly on an enumeration fixed in advance (3,920 unit vectors) — at the ban's edge, logged as such.
- Enumerated the 49 linear forms mod 7 on the `𝔽₇` circle, only to diagnose an unreachable plant (8 forms land in `{2..5}/7`): a complete
  enumeration of a set the question fixes — at the edge, logged.

### 2.9 Instrument slips (G21), recorded

- Two plants that could not fire: `c9-shift` as first written ((2x + 4y)/7 is one of the 8 forms that work — the circle's symmetry orbit of
  (2, 3)), and `forget-seven` aimed at ℚ(√11) (already out through its stable dyadic place). Both replaced by plants that fire; both kept in the
  tools' docstrings.
- The fence breach of §1.2.

## Stage 3 — SAVED (the write-up; committed before anything fenced is opened)

### 3.1 Verdicts, per claim (the fixed list)

| claim | verdict | grade | the one-line reason |
|---|---|---|---|
| KS-4 (control) | **TRUE** | [hand + tools exact] | `W` factors through `π = p₁`; `θ_{C9}(U) ⊆ [1/4, 3/4]` |
| KS-5 (control) | **TRUE**, with "image" read "closure of the image" | [hand] | `K̂′ = ℤ × 0` after the basis change; `W` factors |
| KS-2 | **TRUE** | [hand] | Fubini over `K₀`-cosets: adjacent cosets' essential colour sets are disjoint |
| KS-1 | **FALSE** — counterexample over ℚ (J51V-X1) | [hand + tools exact] | a proper four-colouring of ℚ² whose `T + A` information sits only inside non-`(T + A)` components, so `K′ = {0}`; TRUE at `n = 1` (J51V-N1) |
| KS-3 | **FALSE** — the same example; also `(ψ_w, ψ_w̄)` alone | [hand + tools exact] | at a split place the torus `y ↦ (y, y⁻¹)` shows two characters only a cross |
| KS-C | **TRUE as an implication** (the step KS-1 at ℚ(√47) ∧ T-C(A)@∅ ⟹ X is valid); **hollow**: KS-1 is false as stated, and at ℚ(√47) KS-1 ⟺ X (J51V-EQ) | [hand] | the pulled-down colouring's spectrum is on `{m·Θ : m ∈ K̂′} ⊆ T + A` |
| K0 | **TRUE**, with a scope note | [hand; membership not blind] | no step of A⁺ or SP-Cor reads ℚ(√47) except through T-C(A); A⁺ at a finite `S` needs T-C(A) at that `S` |

**What stays open, stated once.** X ("no four-colouring of ℚ(√47)'s plane of the form `x ↦ W(Θ(x) + t)`") is proved for `Θ ∈ Eⁿ` (T-C(A) at a
finite `S`) and for `n = 1` (row 98 + T-C(A)@∅); for `n ≥ 2` with a combination outside `E` it is open, and no uniform selection lemma can close
it — any proof must use ℚ(√47)'s arithmetic, as T-C(A)'s count does.

### 3.2 The mechanism, in the discipline's words [reading, from J51V-X1/X2]

At a place split in `L/F` the two primes above it see complementary halves of the norm-one torus, so `x ↦ (ψ_w(x), ψ_w̄(x))` sends every unit
vector into the cross `(T × 0) ∪ (0 × T)`. Composed with a band character `θ`, `Cay(R, U)` maps homomorphically into the Cayley graph on `T²` with
connection set `(I × T) ∪ (T × I)`, `I = cl θ(U)` — which is the **co-normal (disjunctive) product** `Cay(T, I) ∗ Cay(T, I)` — and a co-normal
product is `χ(G)²`-colourable. So colourings "local at no place" in KS-1's quotient sense exist cheaply wherever `χ(G)² ≤ k`; at four colours that
needs a bipartite `G`, i.e. a bipartite plane. *Killing test of the reading that this is the only cheap mechanism:* a four-colouring of the form
`W(Θ(x) + t)` over a field with no two-colour `T + A` character and `K̂′` too small to carry it — which at ℚ(√47) would falsify the conjecture.

### 3.3 C0 scored (the first-read column)

KS-1: modal TRUE (0.55) — **lost** (FALSE). KS-2: TRUE (0.85) — met. KS-3: TRUE/FALSE tied (0.35/0.35) — FALSE. KS-4, KS-5: TRUE (0.92, 0.88) —
met. KS-C: TRUE (0.75) — met, but the substance (circularity) was not in the prior. K0: TRUE (0.80) — met. The two misses are the two claims that
quantify over every field, every `n` and every `Θ`; the split-place torus was the whole difference.

### 3.4 Corrections owed and proposals (the front-page lane decides)

1. **The Kronecker selection, as KS-1 states it, is false** (J51V-X1); FS-100's stage 4 cannot finish the pure-point layer at ℚ(√47) by a uniform
   lemma. The stub's §2.3 table cell "Kronecker selection — finishes the pure-point layer" (ℚ(√47) column) should read: the `E`-part is finished by
   T-C(A) at finite `S` directly, rank one by row 98 with T-C(A)@∅; the rank `≥ 2` non-`E` part is open, and at ℚ(√47) the selection is equivalent
   to it (J51V-EQ).
2. **The controls KS-4 and KS-5 cannot see KS-1's failure** (their `W` factors through `π`). J51V-X1 is the missing control: a `W` that reads the
   non-`(T + A)` coordinates. Any future formulation of a selection should be run against it (and against its `k²` form, J51V-X2 (b), at five
   colours: `k = 2` gives four colours ≤ five).
3. **Row 98's "Not claimed" list** could add: no naive vector form — `0 ∉ cl Θ(U)` does not force a non-zero `m·Θ` into `T + A` (J51V-X2 (c)).
4. KS-5's wording: "the image of `θ_{C9}`" → "the closure of the image of `θ_{C9}`, via the first coordinate".
5. K0's scope: "given T-C(A) there at `S = ∅`" yields SP-Cor and A⁺ at `S = ∅`; J45's full A⁺ needs T-C(A) at every finite `S` (J28D's class form).
6. The brief's input list: SP-oi is not in J45 §5.4 (it is in J45's theorems table and §4.2); row 105 does not state `R = O′` (Lemma C′ does).
7. **G21 / method:** two plants that could not fire (§2.9); and a fence breached by a broad `grep plans/*.md` (§1.2) — a blind job's searches
   should exclude the fenced files by name.

### 3.5 Stage 4 (the fallback) — not triggered

Stage 2 reached a verdict on every claim; nothing stalled, so J51D's lemma statements were not read. Nothing fenced was opened on purpose at any
stage.
