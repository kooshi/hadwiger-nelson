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

*Correction to §1.3's timestamp:* C0 was sealed at 11:55 UTC (the commit's time), not 06:58.

## Stage 2 — SAVED (blind derivations, 11:56–12:15 UTC)

**Setting** (R88 notation; X22V §2 names): `F` of type (B); `R = ℤ[U]`, `U = T(F)` the norm-one group of `L = F(i)` (every norm-one element of
`L` is a unit vector); `X₄` the proper four-colourings of `Cay(R, U)`, compact; Pull finite, closed, `R ⋊ U`-invariant (R88-TA (i)); `M_T`
the translation-invariant Borel probabilities on `X₄` (compact, convex, metrizable); `P_Pull = {μ : μ(Pull) = 1}` (closed: `μ ↦ μ(Pull)` is
upper semicontinuous); `M′ = {μ ∈ M_T : μ(Pull) = 0}`; `(u·c)(x) = c(ux)`, so `σ_{u_*μ}` has `σ̂(y) ↦ σ̂(uy)`; `4R = R ∩ 𝔓⁴` (the one dyadic
prime is stable; `R/4R ≅ O_𝔓/𝔓⁴`); `D = (4R)^⊥`, finite, `U`-invariant; `σ_μ` the tetrahedral spectral measure, mass 1. **Input used
throughout, by statement:** X22D-QR = X22V-F2 (two minds): given MR, every `R ⋊ U`-invariant `ν ∈ M_T` lies in `P_Pull`, and a measure
in `P_Pull` has `σ_ν` carried by `D` (every pullback is `4R`-periodic).

**Averaging schemes.** A *scheme* is a sequence of finitely supported probability vectors `α_n` on `U` that is asymptotically invariant
(`‖α_n − δ_g * α_n‖₁ → 0` for every `g ∈ U`) — Følner averages, and convex combinations of translates of one Følner average. For every
`μ ∈ M_T` and every scheme, every weak-* limit of `ν_n = Σ_u α_n(u) u_*μ` is translation- and `U`-invariant, hence (given MR) in `P_Pull`,
and `σ_{ν_n} = Σ_u α_n(u) u^•σ_μ → σ_ν` weak-* (`μ ↦ σ̂_μ(y)` is continuous and affine; `R` is countable). This is X22D-RT's engine; I
re-derived it and use it in this form (**collapse**: given MR, the `U`-averages of `σ_μ` converge onto `D`, along every scheme).

### 2.1 TR-ROT given MR is Q-μ itself, not a step of it

**X27V-EQ [hand, one mind; a few lines].** *Given MR, over a type-(B) field: TR-ROT ⟺ `M′ = ∅` ⟺ Q-μ. Unconditionally, Q-μ ⟹ TR-ROT.*
*Proof.* Given MR, every `μ ∈ M_T` has every `U`-Følner average converging onto `P_Pull` (collapse). So "no `μ ∈ M′` has every average
converge onto Pull" says `M′ = ∅`. And `M′ = ∅` ⟺ Q-μ: if `0 < μ(Pull) < 1`, then `μ(· ∩ X′)/μ(X′) ∈ M′` (`X′` is Borel and
translation-invariant). Unconditionally, Q-μ makes `M′` empty and TR-ROT vacuous. ∎
*Consequence for the record:* X22D §2.4 names TR-ROT as "the step C-1 needs". It is that step, but it is not smaller than C-1: given MR
it **is** C-1 (Q-μ). X22D-RT's content is the property of each `μ` (every `μ` is rotationally transient), not a reduction of Q-μ. X22V
stage 4 already noticed the same for its own (a).

### 2.2 What collapse forces on every spectral measure: the `E`-part is the `D`-part

**X27V-TA [hand, one mind].** *Given MR, over a type-(B) field, every `μ ∈ M_T` has `σ_μ((T + A) ∖ D) = 0`.*
*Proof.* Let `K ⊂ R̂` be compact, `U`-invariant and disjoint from `D`. Along a Følner scheme, `σ_{ν_n}(K) = σ_μ(K)` (`K` is `U`-invariant);
a subsequence has `σ_{ν_n} → σ_ν` with `σ_ν(D) = 1`; portmanteau for the closed `K`: `0 = σ_ν(K) ≥ limsup σ_{ν_n}(K) = σ_μ(K)`. Now
`(T + A) ∖ D` is a countable union of such `K`: (a) for `t ∈ T ∖ D`, the orbit `Ut` is finite (`U` acts on the finite `R/NR`), so compact,
`U`-invariant, `D`-disjoint; (b) `Ut + {χ_ξ : a_j ≤ |ξ_j| ≤ b_j}` (`ξ = (ξ₁, ξ₂) ∈ ℂ²`, one coordinate per complex place of `L`; rational
bounds, not both zero) is compact and `U`-invariant (`|u| = 1` at both complex places, since `uū = 1` and `F` is real), and misses `T ⊇ D`
because a character that is torsion and continuous for the archimedean topology is trivial (`R` is dense in `L ⊗ ℝ = ℂ²`). ∎

**X27V-FS [hand, one mind; one textbook input: weak approximation for the norm-one torus `x² + y² = 1`, a rational conic].** *Given MR,
over a type-(B) field, every `μ ∈ M_T` has `σ_μ(E ∖ (T + A)) = 0`; with X27V-TA, `σ_μ(E ∖ D) = 0`.*
*Proof.* Fix a finite set `S` of split places and one place `w` of `L` above some `v ∈ S`; cover `{χ ∈ E_S : χ = t·e_ξ·∏_{w′}ψ_{w′}(a_{w′}·),
a_w ≠ 0}` by countably many compact pieces `P` (fixed torsion level `N`, `ξ` and every `a_{w′}` in compact sets, `q^{−r} ≤ |a_w|_w ≤ q^r`).
It suffices that `σ_μ(P) = 0`. Write `U = U″ × Λ`, `U″ = {u : ord_{w′} u = 0 at every place above S}`, `Λ ≅ ℤ^{|S|}` (free, so the quotient
splits), with `π ∈ Λ` supported at `w, w̄` (`π = α/ᾱ`, `(α) = w^h`), `ord_w π = h`, `ord_{w̄} π = −h`.
1. *The fine-phase set.* `ι(U″)` in the compact product `C = ∏_{v∈S} T(O_v) × T(F_∞) × (R/NR-image)` has closure `H`, and `H ⊇ H₀ = (1 + 𝔪_w)
   × {1}`: `T(F)` is dense in `∏_{v∈Σ} T(F_v)` for every finite `Σ` (the conic is rational: stereographic projection), and `U″ = T(F) ∩` an
   open subgroup. So for every `L ≥ 1` and `δ > 0` there is a finite `B ⊂ U″` with one `b` per class `γ ∈ (1 + 𝔪_w)/(1 + 𝔪_w^{1+L})`,
   `b_w ∈ γ(1 + 𝔪_w^{1+L})`, and `b` within `δ` of 1 at every other coordinate of `C` except `w̄` (where `b_{w̄} = b_w^{−1}`, a unit).
2. *The w-factor averages to zero over B.* For `a ∈ U″`, `λ ∈ Λ` with `ord_w λ = −hK`, and `χ ∈ P`, put `β = 4a_w·λ_w a_w^{(u)}` (the
   character's parameter times the element's `w`-coordinate). If `q^1 < |β|_w ≤ q^{1+L}`, then `avg_{b∈B} ψ_w(β b_w) = ψ_w(β)·avg_{x ∈ 𝔪_w/𝔪_w^{1+L}}
   ψ_w(βx) = 0` (a non-trivial character of `𝔪_w/𝔪_w^{1+L}`). The `w̄`-factor is identically 1 once `|4a_{w̄}|q^{−hK} ≤ 1` (contracting). Every
   other factor (torsion of level `N`, archimedean, the `w′`-factors with `|λ_{w′}|` bounded by the box) moves by at most `ε(δ)` under
   `u ↦ ub`, uniformly on `P`. So `|avg_{b∈B} χ(4ab λ)| ≤ ε(δ)` uniformly in `a`, `χ ∈ P` and `λ` in the box.
3. *The scheme.* Box `Λ_n` = the `λ` with `ord_w λ ∈ [−K_n − J_n, −K_n]` and the other `|S| − 1` coordinates in `[−J_n, J_n]`; choose
   `L_n, δ_n, B_n` for that box (all `|β|` land in `(q, q^{1+L_n}]` once `K_n ≫ J_n + r`), then `A_n` Følner in `U″` relative to `B_n`. The
   averages `α_n = avg_{a∈A_n, b∈B_n, λ∈Λ_n} δ_{abλ}` form a scheme (a convex combination of translates of the Følner averages over
   `A_n × Λ_n`), and `|Σ_u α_n(u) χ(4u)| ≤ ε(δ_n) → 0` uniformly on `P`.
4. *Collapse.* Along this scheme `Σ_u α_n(u) σ̂_μ(4u) → σ_ν(D)·1 = 1` (on `D`, `χ(4) = 1`). So `∫ (1 − Re Σ_u α_n(u) χ(4u)) dσ_μ(χ) → 0`; the
   integrand is `≥ 0` everywhere and `≥ 1 − ε(δ_n)` on `P`; so `σ_μ(P) = 0`. ∎

**Controls read** (no computation): at ℚ(√11), where Q-μ fails (C9's `⌊4(θ + s)⌋`, spectrum on `T + A`), X22D-QR is not available (Theorem
C fails there), so X27V-TA does not apply — consistent. A `D`-character cannot lie in any piece `P` (its `χ(4u) = 1` would contradict step 2),
so the pieces meet `D` nowhere, as they must. The unconditional Theorem C (row 112) is the case "`σ_μ(E_S) = 1` ⟹ Pull", which X27V-TA/FS
reproduce given MR and extend to `E`.

**X27V-R1 [hand, one mind; a corollary].** *Given MR, over a type-(B) field: a translation-invariant `μ` whose spectral measure is carried
by `E = ⋃_S E_S` is almost surely a pullback.* (`σ_μ(E ∖ D) = 0` ⟹ `σ_μ(D) = 1` ⟹ `c(0) = c(y)` a.s. for `y ∈ 4R` ⟹ periodic ⟹ a pullback, row 88 V3.) **So
T-C′'s case (R1) (`plans/R88-derivation.md` §G: carried by `⋃_S (T + A + Fin_S)` but by no single one — FS-97's first half) is closed given
MR**, with no Haar measure on the non-locally-compact completion: the rotations do the work the Fubini steps could not.

**X27V-R2 [hand, one mind; a corollary].** *Given MR, over a type-(B) field: Q-μ ⟺ TR-ROT ⟺ every `μ ∈ M_T` has `σ_μ(R̂ ∖ E) = 0` ⟺ no
`μ ∈ M_T` has spectrum of T-C′'s type (R2).* And for `μ ∈ M′`: `σ_μ = σ_μ|_D + τ_μ` with `τ_μ = σ_μ|_{R̂∖E}` of mass `1 − σ_μ(D) > 0`,
and `τ_μ`'s `U`-averages converge onto `D` along every scheme.

### 2.3 TR-ROT — verdict: GAP at COL-E

**The named step, COL-E:** *"No non-zero `E`-null part `τ_μ = σ_μ|_{R̂∖E}` of the spectral measure of a translation-invariant random
four-colouring has its `U`-averages converge onto `D` along every averaging scheme."* Given MR, COL-E ⟺ Q-μ ⟺ TR-ROT (X27V-R2), so it is
the whole of what is left, but it is now a statement about one measure on `R̂` and one closed finite set, with the `E`-part gone.

Why the tools I have stop there:
- **MR** speaks of `U`-invariant `E`-null measures. The `U`-averages of `τ_μ` are `E`-null and asymptotically invariant, but `E` is dense
  and not closed, so their limits may charge `E` — and collapse says they charge exactly `D`. Nothing in MR is violated by that.
- **Closed-set rigidity** (rows 95, 98; Berend) and Bergelson–Moragues Prop. 2.7 give it **for points**: if a single character `χ ∉ T + A`
  had an orbit closure carrying an invariant measure off `D`, some scheme would carry `δ_χ` off `D`. But COL-E is about a **measure**, and
  collapse of a measure along every scheme does not follow from non-collapse of each of its points (each point's bad schemes can differ;
  the standard counterexample shape in ℤ: thick bad sets placed at point-dependent locations). So the pointwise route has a
  points-to-measures step, **COL-E(pm)**, that I cannot close.
- **The colouring constraint** `σ̂_μ(u) = −1/3` on `U` survives averaging and is met by Pull-spectra, so it gives no contradiction by itself.

**Shape of a FALSE** (so a counterexample is recognisable): a translation-invariant random four-colouring, not a pullback, whose spectral
measure has **no** mass on `E ∖ D` (no archimedean, no finite-place, no non-`D` torsion part — X27V-TA/FS, given MR) and whose `E`-null
part collapses onto `D` under every rotation scheme: its rotated windows look like pullbacks Banach-almost always (X22D-RT) while its
translations never do. By R88-TA2's logic such a `μ` answers row 88 "no".

**Verdict: TR-ROT — GAP at COL-E** (equivalently, given MR, at Q-μ). Neither TRUE nor FALSE reached.

### 2.4 TR-ROT-flip — verdict: TRUE as posed (vacuously), and in the kind an averaging proof needs it is Q-μ; one quantity named

**(a) As posed.** "Invariant under translation" is no constraint on a functional of translation-invariant `μ`; so the literal flip asks for
a weak-* continuous `Φ ≥ 0` on `M_T`, zero on `P_Pull`, positive on `M′`. **X27V-F1 [hand; trivial]:** `Φ(μ) = d(μ, P_Pull)` for any
compatible metric on `M_T` is one (`P_Pull` is closed and disjoint from `M′`). It carries no information: it is not rotation-invariant, and
given MR its `U`-averages tend to 0 for every `μ` (collapse).

**(b) The kind an averaging argument uses** (X22V §2.2's "continuous, affine, `U`-invariant"). **X27V-F2 [hand; a few lines]:** *given MR,
every `Φ : M_T → ℝ` that is concave (in particular affine), upper semicontinuous and `U`-invariant, with `Φ = 0` on `P_Pull`, satisfies
`Φ ≤ 0` on all of `M_T`.* (`Φ(ν_n) ≥ avg Φ(u_*μ) = Φ(μ)`; `Φ(ν) ≥ limsup Φ(ν_n)`; `ν ∈ P_Pull`.) *So a quantity of this kind positive on `M′`
exists iff `M′ = ∅` iff Q-μ* — naming one is proving Q-μ, and G79's flip does not make the target smaller here. Unconditionally (no MR),
any such `Φ` proves TR-ROT (same two lines).

**(c) The canonical quantity, named — with exactly one property missing.** **X27V-F3 [hand, one mind]:** `Φ₀(μ) := σ_μ(R̂ ∖ D) = 1 − σ_μ(D)
= (4/3)·M_{y∈4R} P_μ(c(0) ≠ c(y))` (the mean, over the finite-index subgroup `4R`, of the probability that `c` breaks `4R`-periodicity) is
affine, translation- and rotation-invariant (`D` is `U`-invariant), zero **exactly** on `P_Pull` (V3), positive on `M′` — and only
**lower** semicontinuous (`D` closed). Given MR: `Φ₀` is weak-* continuous on `M_T` ⟺ Q-μ (⟸: `Φ₀ ≡ 0`; ⟹: for `μ ∈ M′`, `Φ₀(ν_n) = Φ₀(μ) >
0` along a scheme whose limit `ν` has `Φ₀(ν) = 0`); unconditionally, `Φ₀` continuous ⟹ TR-ROT. By X27V-R2, given MR, `Φ₀(μ) = τ_μ(R̂)`: the
flip's quantity **is** the `E`-null spectral mass, and its failure of continuity is COL-E.

**(d) A no-go of a stated kind.** **X27V-F4 [hand, one mind; from X27V-TA/FS]:** *given MR, no quantity that reads the spectral measure
only through its restriction to `E ∖ D` (every archimedean, finite-place and non-`D` torsion character) separates `M′` from `P_Pull`* —
that restriction is 0 for every `μ ∈ M_T`. Whatever separates must read the `E`-null part (as `Φ₀` does) or the `D`-part's total mass.

### 2.5 Would have searched here (stage 2)

- TR-ROT: I would have tried to build, numerically, a random colouring whose rotated windows look like pullbacks (three-phase patchworks
  along split-place regions) to test collapse against its translations. Not done; the shape of a FALSE is stated instead (§2.3).
- COL-E(pm): I would have tested points-to-measures on the ×2×3 circle numerically (empirical measures of random Følner schemes on a
  measure built from thick bad sets). Not done; named as a step.
