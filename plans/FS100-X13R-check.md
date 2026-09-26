*Record of crunch job **X13R**: a reading check (not blind) of two results of X03D, `plans/FS100-X03D-derivation.md` rows X03D-ED2 and
X03D-Z (lines 18–19) and their proofs in §4.1–§4.4. Coxeter, Opus 5.5, 2026-09-26, from 11:04 UTC; hard stop 06:50. Brief:
`data/crunch-2026-09-26-x2x3/briefs/X13R-ed2-z-reading-check.md`, with `STANDING-RULES.md` as part of it. No subagents; no finite-witness
search. I touch only this file, `tools/x13r_*.py` and my report.*

## Theorems this phase proved

None: a check. (The check's findings are verdicts on X03D's theorems, below.)

## Stage 1 — SAVED (quotation check)

| quotation in the brief | source | result |
|---|---|---|
| "rows **X03D-ED2** and **X03D-Z** (lines 18–19)" | `plans/FS100-X03D-derivation.md` lines 18–19 | **verbatim**: line 18 is X03D-ED2, line 19 is X03D-Z |
| ED-2 and ED-1's hypothesis "quoted there verbatim in §1.1 (from `plans/CRUNCH-2026-09-26-x2x3-queue.md` §2)" | queue lines 88–89 against X03D lines 36–37 | **verbatim**: ED-1 "If, for every `χ ∈ R̂ ∖ E`, `lim_{N→∞} (1/#U_N) Σ_{u ∈ U_N} χ(u) = 0`, then MR(F) holds."; ED-2 "Over `F = ℚ`, the hypothesis of ED-1 holds." |
| "`E = ⋃_S (T + A + Fin_S)`" | X03D §1.1 notation, quoting J51V's brief | **verbatim** |
| "`∏_{P′}(1 − 1/p) ≠ 0`" | X03D line 18: "tend to `∏_{p∈P′}(1 − 1/p) ≠ 0`" | same formula, index written shorter |
| "the one classical equidistribution input" | X03D line 18: "on one classical input (joint equidistribution of Pythagorean points at finitely many places)" | **not verbatim; same substance** (the brief's paraphrase). I check the source's wording (§4.3 "*The input:*"). |
| "`χ_{P′}` is a well-defined character of `R = ℤ[U_ℚ]`" | the brief's own instruction, not a quotation | — |
| "R-U's wandering-set argument" | X03D §4 verdict paragraph: "R-U's wandering-set argument, run at infinitely many places" | **verbatim** |
| "the summable set `Z`" | X03D line 19 | **verbatim** |

The sources I check against, read in full for this job: X03D §1.1, §2.2 (ED-1, used by ED1′), §4.1–§4.4; J45's
`plans/FS84-SI-D-derivation.md` §1.2 (notation, `G′_S`), §2.1 (Lemma N1), §4.1 (R-U), §4.2 (SP-if step (2)); `tools/x03d_weyl.py` and
`data/fs100/x03d/weyl-check.out`.

Owner's 06:08 news (χ(ℚ(√47)²) = 5 [hand] by another route) noted; it does not bear on ED-2 or Z, and it does not change this check.

### Would-have-searched-here log

- (stage 1) none.

## Stage 2 — SAVED (X03D-ED2)

**Verdict: VALID.** ED-2 is FALSE over ℚ, with the explicit character `χ_{P′}`; every step below checks. Four wording corrections are owed
(none changes the verdict), and the tool's pass line is looser than the record says (G21 note, (d)).

### (a) `χ_{P′}` is a character of `R`

- `R = ℤ[U_ℚ] = ℤ[i][1/P]` (row 98). Re-checked: `i ∈ U`; `U ⊆ ℤ[i][1/P]` (a primitive triple's `c` is a product of primes of `P`); and
  `π²/p = π/π̄ ∈ U`, `π̄²/p ∈ U` with `(π², π̄²) = ℤ[i]` give `1/p ∈ ℤ[U]`. Only `R ⊆ ℤ[i][1/P]` is used below.
- For `r ∈ R` and `p ∈ P′` not dividing `r`'s denominator, `ι_{π̄_p}(r) ∈ ℤ_p`, so `ψ_p(ι_p(r)) = 1`: the product "`∏_{p∈P′} ψ_p(ι_p(r))`"
  (§4.2) has finitely many non-trivial factors. Each factor is additive in `r`; so is the product (supports are finite unions). `R` is
  discrete, so every homomorphism `R → S¹` is in `R̂`. **Checks.**

### (b) `χ_{P′} ∉ E`

- Only the easy half of J45-N1 (a) is used: every element of `E_S = T + A + Fin_S` is continuous for `τ′_S` (a product of a
  profinite-continuous, an archimedean-continuous and an `S`-adic-continuous character). So a `χ` continuous for no `τ′_S` is outside `E`.
  (Robust to reading `S` as any finite set of places: at a non-split place `v`, `R ⊆ O_v` and `R ∩ 𝔭_v^M O_v ⊇ N R` has finite index, so
  `v`-adic continuity adds only torsion characters.)
- The basic neighbourhoods "`W = {r ∈ nR : |r|_∞ < ε, ι_v(r) ∈ 𝔭_v^M (v ∈ S)}`" are a base at 0 for `τ′_S`: finite-index subgroups of `R`
  contain some `nR`. ✓ (Read "`𝔭_v^M`" at a split `v` as the condition at both places above `v`; `σ = ∏_{v∈S} p_v` then gives it.)
- The witness `r = λ₀(y/p − z/q′^j)`: `n | λ₀` and `p, q′ ∈ P` give `r ∈ nR`; `p, q′ ∉ S` give the `S`-conditions from `σ^M`; the lattice
  `λ₀ℤ[i]/q′^j` has mesh `→ 0`, so `|r|_∞ < ε` is attainable; at `p″ ∈ P′ ∖ {p}` the denominators `p, q′` are units; at `p`,
  `{ι_p(r)}_p = ⌊p/2⌋/p` because `ι_p(λ₀ y) ≡ ⌊p/2⌋ (mod p)` and `λ₀ z/q′^j` is `p`-integral. `|e(⌊p/2⌋/p) − 1| = 2cos(π/(2p)) ≥ 2cos(π/10) =
  1.9021 > 1.9` for `p ≥ 5`. **Checks**, and `q′ ∉ P′` is load-bearing: with `q′ ∈ P′` the product formula makes `χ(r) ≈ e(−r) ≈ 1` (below).
- **Built exactly** (`tools/x13r_check.py` (B)): `S = {13}`, `n = 6`, `M = 2`, `ε = 1/1000`, `P′` by X03D's rule; the construction picks
  `p = 5`, `q′ = 29`, `j = 5`; `r ∈ nR`, `|r| < ε`, both 13-adic coordinates in `13²ℤ₁₃`, and `χ(r) = e(2/5)` exactly (every prime of `P′`
  dividing `r`'s denominator evaluated), `|χ(r) − 1| = 1.9021`. **Plant** `--plant-q` (take `q′ = 17 ∈ P′`): `χ(r) = e(1014/7099285)`,
  `|χ(r) − 1| = 0.0009`, red — for the right reason (the second `P′`-denominator's factor cancels the first up to `e(−r)`).

### (c) The Weyl limit `∏_{p∈P′}(1 − 1/p)`

- **`H(u) = c`** for `u = (a + bi)/c` primitive: `u = z/z̄` (or `i z/z̄`) with `z` primitive, `N(z) = c`, `v_π(u) = −v_π̄(u) = v_π(z)`; so
  `U_N` is the primitive Pythagorean points with `c ≤ N` (including `±1, ±i`) and `#U_N ~ (4/π)N` (tool: 509,356 at 400,000, ratio 1.2734). ✓
- **Local factor.** `ι_{π̄_p}(u) = ι_{π_p}(ū) = t⁻¹` ✓. Limit measure = uniform on each `ℙ¹(ℤ/p^k)` (`p^{k−1}(p+1)` classes) ✓; mass of
  `{v(t) = k}` is `(p−1)p^{−k}/(p+1)` ✓; on it `t⁻¹` is uniform on `p^{−k}ℤ_p^×` (inversion preserves Haar on `ℤ_p^×`) ✓; `ψ_p` averages to
  `μ(p^k)/φ(p^k)`: `−1/(p−1)` at `k = 1`, 0 at `k ≥ 2` ✓. `I_p = 1 − 1/(p+1) − 1/(p(p+1)) = 1 − 1/p` ✓.
- **The one classical input, named exactly:** *counting Gaussian integers in a disc of radius `√N` in a fixed residue class modulo a fixed
  `m ∈ ℤ` (area `πN/m²` plus `O(√N/m + 1)`), with Möbius inversion over rational `d` for primitivity, transported through Hilbert 90
  (`u = z/z̄` or `iz/z̄`, two `z` per `u`) and CRT over the primes of `Σ`.* It gives: for every finite `Σ ⊂ P`, every `k ≥ 1` and every class
  `(α_p) ∈ ∏_{p∈Σ} ℙ¹(ℤ/p^k)`, `#{u ∈ U_N : t_p(u) ≡ α_p ∀p ∈ Σ}/#U_N → ∏_{p∈Σ} 1/(p^{k−1}(p+1))` — weak-* convergence to X03D's product
  measure. **Correctly stated and applicable**, with one wording slip: X03D writes "residue classes mod `∏ π^k`"; the class of `t_p` needs
  `z` modulo `p^k = π^k π̄^k` (both components), i.e. residue classes mod `∏ p^k`. The substance is unchanged. Checked directly at finite
  `N` (tool (A)): at `N = 100,000`, the 30 classes of `ℙ¹(ℤ/25)` are hit with maximal relative deviation 0.0025 and the 84 joint classes of
  `ℙ¹(𝔽₅) × ℙ¹(𝔽₁₃)` with 0.0443 (about 1,516 per class, so `√count` scale); plant `--plant-root` (a non-root for `ι_{π_p}(i)`) leaves 5 of 30
  and 44 of 84 classes empty — red.
- **Tail.** `χ(u) ≠ χ_M(u)` needs `π_p | z(u)` for some `p ∈ P′`, `p > M`; `#{z : N(z) ≤ N, π_p | z} ≤ πN/p + O(√(N/p)) + 1 ≤ CN/p` for
  `p ≤ N`, and 0 for `p > N`. So the discrepancy fraction is `≤ C′Σ_{P′, p>M} 1/p`, uniformly in `N`, `→ 0` as `M → ∞` ✓.
- **Levels.** `ψ_p(t⁻¹)` is locally constant but of unbounded level (on `v(t) = k` it depends on `t mod p^{2k}`), so the finite-level
  input needs truncation: `#{u ∈ U_N : v(t_p) ≥ J} ≤ C N p^{−J}` uniformly (lattice points of `π^Jℤ[i]`) ✓. X03D writes "`v(t) ≥ J` has mass
  `≤ p^{−J}`, uniformly"; at finite `N` it is `≤ C p^{−J}` — wording only.
- **Conclusion.** `|A_N(χ) − A_N(χ_M)| ≤ 2C′ tail_M`, `A_N(χ_M) → ∏_{P′∩[1,M]}(1 − 1/p)`; `M → ∞` gives the limit, positive since
  `Σ_{P′} 1/p < ∞`. **Checks.**

### (d) The exact tool `tools/x03d_weyl.py` (G21)

Re-run (scratch, 06:07): output identical to `data/fs100/x03d/weyl-check.out`; both plants go red.
1. **It tests the local factor on finitely many places, not the claim's character.** Every `P′` it evaluates (`{5}`, `{13}`, `{5,13}`, nine
   primes) is finite, so every character it evaluates lies in `Fin_{P′} ⊂ E`. The claim's `χ ∉ E` and its tail step are hand-only. X03D's
   table row says "the local factor and the limit checked exactly"; **correction owed:** "the local factor, and finite-`P′` averages at
   `N = 400,000` (a float of exact roots of unity, tolerance `5·10⁻³`), checked; the infinite-`P′` limit is hand".
2. **The nine-prime row's PASS line cannot see its five largest primes.** Their combined effect is `1 − ∏_{p≥1033}(1 − 1/p) = 1.29·10⁻³`,
   below the tolerance `5·10⁻³`, so the check passes whether or not those primes contribute. The printed number does discriminate: measured
   `0.73856`, nine-prime prediction `0.73878` (difference `2.2·10⁻⁴`), four-prime prediction `0.73974` (difference `1.18·10⁻³`).
3. **`--plant-root` fires for a different reason than its label.** The tool and the record say the plant makes "`χ` … no character". It
   does not: `a + bi ↦ a + b r′` is `ℤ[1/P]`-linear on `R = ℤ[1/P]²`, so `ψ_p` of it is a character of `R`, just not of the form `ψ ∘ ι`. Its
   pole sits in both residue discs, not one, and its averages match `∏(1 − 2/p)`: `0.59966` against `0.6` at `{5}`, `0.84609` against
   `0.84615` at `{13}`, `0.50724` against `0.50769` at `{5,13}`, `0.50918` against `0.50958` for the nine primes. So the plant goes red
   because the local factor depends on which disc carries the pole — a reason tied to the mechanism, and a second confirmation of it — but
   not for the reason given. **Tool-docstring defect** (label only).
4. **`--plant-pred` fires at `{13}` by a hair:** `|diff| = 5.24·10⁻³` against the tolerance `5·10⁻³` (the planted shift is
   `1/13 − 1/14 = 5.49·10⁻³`); it fires by `3.4·10⁻²` on the other rows.

### Would-have-searched-here log (stage 2)

- None. `tools/x13r_check.py` enumerates the fixed finite set `U_N` at `N = 100,000` (seconds; extent fixed before the run) and builds one
  witness by the §4.2 construction at parameters chosen before the run; neither searches.

## Stage 3 — SAVED (X03D-Z)

**Verdict: VALID.** "Every `U`-invariant finite positive `ν` on `R̂` has `ν(Z ∖ (T + A)) = 0`" (§4.4) checks step by step. The one step X03D
left unwritten (measurability, "one line, not written out") holds, with the line supplied in (0); it needs the adelic model to be the
`S`-adic one, which I state.

### (0) The model, and measurability (the unwritten line)

- Let `S_f` be the places of `L` above `P` and `𝔸_S = L_∞ × ∏′_{v∈S_f} L_v` (restricted product with respect to `O_v`). `R = ℤ[i][1/P]` is
  the ring of `S`-integers and is a **cocompact lattice** in `𝔸_S`: discrete (`|x|_∞ < 1` and `x ∈ O_v` for all `v ∈ S_f` force `x ∈ ℤ[i]`,
  `x = 0`) and cocompact (`𝔸_L = L + (L_∞ × ∏_v O_v)`, class number 1, gives `𝔸_S = R + (L_∞ × ∏_{S_f} O_v)`, and `[0,1)² × ∏_{S_f} O_v` is
  compact). So `R̂ ≅ 𝔸_S/R^⊥` with `R^⊥ ⊂ L` diagonally (the elements `k ∈ L` with `k ∈ 𝔡_v^{−1}O_v` off `S`); this is X03D's
  "`ξ ∈ 𝔸_L` modulo `L + 𝒪^⊥`" with the non-`S` components quotiented out. Every `χ` has representatives, each with `ξ_v ∈ O_v` at all but
  finitely many `v ∈ S_f`.
- Let `Ã ⊂ 𝔸_S` be the summable representatives: Borel (a countable sum of Borel functions converges). Step 1 below shows the quotient
  map `q` is **injective on `Ã`**. `q|_Ã` is continuous and injective on a Borel subset of a Polish space, so by Lusin–Souslin `Z = q(Ã)` is
  Borel and `(q|_Ã)⁻¹ : Z → Ã` (the canonical representative) is Borel. **Checks.** (In X03D's `𝔸_L` model injectivity fails through `o ∈ 𝒪^⊥`;
  only the `P`- and `∞`-components are canonical there, which is all the proof uses, but the `S`-adic model makes the line one line.)

### (1) Canonical representative

- Summability, as defined ("`Σ_{p∈P} Σ_{v∣p} p^{−1−v(ξ_v)} < ∞`", over the places with `ξ_v ∈ O_v`, `p^{−∞} = 0`), is equivalent to
  `Σ_{Q(ξ)} 1/p < ∞` with `Q(ξ) = {p : v(ξ_v) ≤ 0 at some v | p}`: places with `v(ξ_v) ≥ 1` contribute `≤ 2p^{−2}`, summable over all `p`.
- Two summable representatives `ξ, ξ′` differ by `k ∈ R^⊥ ⊂ L`; off `Q(ξ) ∪ Q(ξ′)` (a set of finite `Σ 1/p`), `v(k) ≥ 1` at both places above
  `p`. `P ∖ (Q ∪ Q′)` is infinite because `Σ_P 1/p = ∞` (Dirichlet). A non-zero `k ∈ L` has finitely many non-zero valuations, so `k = 0` ✓.
- `U`-invariance: `(u·χ_ξ)(r) = ψ(ξ u r)`, so `u·χ_ξ = χ_{uξ}`; `u` is a unit at all but finitely many places, so `uξ` is summable; and
  `(uξ)_v = ι_v(u) ξ_v` — the canonical representative is `U`-equivariant ✓.

### (2) Wandering sets at one `p` (R-U's argument)

- `u_p = π_p/π̄_p ∈ U` (norm `1`). `ι_{π_p}(u_p) =: t` has `|t|_p = p^{−1}`; `ι_{π̄_p}(u_p) = ι_{π_p}(π̄_p/π_p) = t⁻¹`; `u_p` is a unit at every other
  finite place and has `|u_p|_∞ = 1`. So on the `p`-component `(x, y) ∈ L_{π_p} × L_{π̄_p} ≅ ℚ_p²`, `u_p` acts by `(x, y) ↦ (tx, t⁻¹y)` ✓.
- `ν|_Z` is `U`-invariant (`Z` is `U`-invariant, `ν` is); by (0)–(1) the map `Φ_p : Z → ℚ_p²` (the canonical `p`-component) is Borel and
  `Φ_p(u·χ) = M_u Φ_p(χ)`, so `Φ_{p*}(ν|_Z)` is a finite `M_{u_p}`-invariant measure ✓.
- `M_{u_p}` carries `{|x| = p^{−n}} × ℚ_p` onto `{|x| = p^{−n−1}} × ℚ_p`: the sets `tⁿ{1 ≤ |x| < p}` (`= {|x| = p^{−n}}`) are disjoint, of equal
  mass, with union `{x ≠ 0}`; finite total mass forces each to be 0, so `x = 0` a.e.; `u_p⁻¹` gives `y = 0` a.e. ✓ This is R-U's step verbatim
  in route (J45 §4.1: "The sets `uⁿ{ξ : 1 ≤ |ξ₁|_v < |t|_v⁻¹}`, `n ∈ ℤ`, are disjoint, of equal `ν_S`-measure, with union `{ξ₁ ≠ 0}`"), run at
  one place at a time. What makes it legitimate at infinitely many places is only that `Φ_p` is a well-defined equivariant Borel map on `Z`,
  which (0)–(1) supply; R-U got the same from N1's Borel isomorphism at finite `S`.

### (3) All places

- `P` is countable: `ν`-a.e. `χ ∈ Z` has every `P`-component 0 (both places above every `p`, including the finitely many where `ξ_v ∉ O_v`).
  Then `χ(r) = ψ_∞(ξ_∞ r)` in the `S`-adic model — archimedean — or, in X03D's `𝔸_L` model, that times `∏_{v∉P∪∞} ψ_v(ξ_v r)`, which is
  non-trivial at finitely many `v` (where `ξ_v ∉ 𝔡_v^{−1}O_v`) and depends on `r` modulo a finite-index subgroup there: torsion. So
  `χ ∈ T + A` ✓. (Also `T + A ⊆ Z`: torsion characters live at non-`P` places, since `P` is inverted in `R`.)

### Side note on X03D-ED1′ (not in my brief; one line, because it uses `Z`)

ED1′'s step "`x·χ ∈ Z ∪ E ⟹ χ ∈ Z ∪ E` (multiplying a summable `ξ` by `x⁻¹` changes finitely many valuations …)" skips that `χ ↦ x·χ` is not
injective: `x·χ` determines `χ` only on `xR`, so `χ = χ_{x⁻¹η}·τ` with `τ` trivial on `xR ⊇ MR`, a torsion character. The conclusion still
holds, because `Z` is stable under `T` (torsion characters have zero `P`-components). **Not a failure; a one-clause gap in the written
reason**, for whoever checks ED1′.

### Would-have-searched-here log (stage 3)

- None: a reading check of a hand proof.
