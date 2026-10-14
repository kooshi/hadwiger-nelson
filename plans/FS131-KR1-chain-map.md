# FS131-KR1 — the five-colour chain: the rest of its map, read, priced and typed as far as reached

*de Bruijn, the planner (the ninth on this chain). Brief: `data/fs131/briefs/FS131-KR1-chain-map.md` (on `main`). Branch
`fs131-wkr`, cut from `fs131-wk8b` at `fec557c9a`, in the tree `.claude/worktrees/fs131-wch`. Working files:
`data/fs131/kr1/`. Report: `data/fs131/reports/FS131-KR1.md`.*

## Theorems this phase proved

None yet (a planning job). Updated at each saved stage.

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_kr1_readback.py` reads every block quotation of the brief (`> …` lines followed by `> — source: <path>`) and
requires the quoted text, character for character, as one whole line of its source on `main`'s working tree
(`/home/kooshi/source/lean-dir`). Output `data/fs131/kr1/readback.out`: **5 quotations, 5 IDENTICAL** — W2
(`data/fs131/REQUEST-2026-10-13.md` l. 4), NF2-NC (`data/fs131/claims-NF2.md` l. 42), the dated line "takes eight, not nine"
(l. 49), inventory items 791 (l. 9228) and 811 (l. 9248) of `plans/FS131-close-inventory.md`. Control
(`--plant`, `data/fs131/kr1/readback-plant.out`): one character changed in each quotation in memory; **5 of 5 reported**,
exit 0 as the control requires.

One observation, not a mismatch: item 791 is stamped "2026-10-14 12:45 UTC logged" and item 811 "2026-10-14 09:54 UTC by the
clock"; the clock read 09:56 UTC when this job started. 791's stamp is later than 811's although 791 precedes it. Commit
`1649420e0` ("a coordinator's slip on times corrected") may concern it; recorded for the coordinator, nothing rests on it.

### 1.2 The seven modules' rows, restated from the architecture (`plans/FS131-KN3-chain-plan.md` § Stage 6, worktree copy)

| id | the architecture's row (module; leaves; discharges; needs; status then) | its draft claim list, read |
|---|---|---|
| M2 | Herglotz–Bochner; Bochner for an induced topology; leaves 3, 11; `BochnerHerglotz`, `BochnerOn`; needs nothing; "not read (ruling 4)" | two statements: `BochnerHerglotz G` for every countable `AddCommGroup G`; `BochnerOn t` for `t` induced by a homomorphism with dense range into an LCA group, "in the form M10 reads". Since item 757 the uniqueness clause is a theorem at countable `G` (`Rigidity/DualGroup.measure_eq_of_fourier`, a typed leaf): M2's first statement is the **existence half** |
| M3 | Markov–Kakutani; leaf 4; `InvariantMeasureOnClosed`; needs nothing; "not read (ruling 4)" | one statement: `InvariantMeasureOnClosed F` "for every `F` with `unitRing F` countable" |
| M10 | N1 (a) at `S = ∅`: the continuity group is `T + A`; leaf 11; N2 at `T + A`; needs C0; "not read" | (1) the topology `τ′_∅` on `unitRing F` and `contChars τ′_∅ = TA F`, both inclusions; (2) `spectral_carried_iff` read at `TA F` over `BochnerOn τ′_∅` (M2) |
| M11 | A⁺ at `S = ∅`; leaf 12; `(chainInterface F).APlusOfR88`; needs M10, M2; "not read" | one statement: `R88TCA → APlus0` at `T + A` |
| M12 | the count; `m₁(ℝ²) < 1/4` declared; `[S9]`; leaves 7, 9, 10; `(chainInterface F).Count`; needs M9; "not read; its own planner" | (1) `TCA F → R88TCA`; (2) `m₁` and `[AmbrusEtAl2023]` Thm 1 "to type and declare"; (3) `[S9]` "to type" |
| M13 | CLS, with EN1-UQ4 at the dyadic targets; leaf 8; `5 ≤ localBound F → TCA F`; needs the `Arith/` floors; "not read" | (1) `5 ≤ localBound F → TCA F`; (2) EN1-UQ4 at `Q = 2^f ≥ 256`, with the exact spectra at 64 and 128 |
| M15 | the instances, `ℚ(√47)` first; the final statement; leaf 23; row 121's sentence; needs all; "not read" | (1) `NumberField` for `ℚ(√47)`, `5 ≤ localBound` there, **and `NoRamifiedStableDyadic` there**; (2) `χ(ℚ(√47)²) = 5` |

**A correction owed to M15's draft claim list** (not a statement defect; the draft is a draft): its item 1 still lists
`NoRamifiedStableDyadic` "there" as a needed model. Since FS131-KN6 (the dated line quoted in the brief) the headline reads
the scope from `5 ≤ L(F)` (`noRamifiedStableDyadic_of_three_le_localBound`), and since FS131-K8B1 EF⁺ is typed with no scope
(`zeroEntropyCarried_of_numberField`). So M15 needs no scope model; the clause leaves its draft (§ the drafts, at the end).

### 1.3 The headline's eight hypotheses: who discharges each, and on which entry it rests

The headline is `Rigidity.min_localBound_five_le_chromaticNumber_of_closed` (`Rigidity/ChainAtTA.lean` l. 529), read in the
source; its eight hypotheses' definitions read in `SpectralChain.lean` (ll. 114–126, 161–193, 301–351) and
`Rigidity/ChainAtTA.lean` (ll. 364–403).

| hyp. | its type (as the source states it) | discharged by | rests on (derivation entry, address) |
|---|---|---|---|
| `hBH` | `BochnerHerglotz (unitRing F)` | **M2**, existence half; uniqueness: `DualGroup.measure_eq_of_fourier` (M4, typed) | classical: `[Rudin1962]` 1.4.3 (not held, not read); no entry of ours |
| `hL1` | `InvariantMeasureOnClosed F` | **M3** | classical: `[Kakutani1938]` (not held); no entry of ours |
| `hCount` | `(chainInterface F).Count` = `TCA F → (chainInterface F).R88TCA` | **M12** | EN1 § 8.1 row 8: R88-TCA (`plans/R88-derivation.md` l. 161) with R88-TC-ext (l. 114), -TC-reg (l. 130), -TC-count (l. 144), -TC-Yp / -J28V-3 (ll. 135, 140), -TC-tab (l. 152); FS100-TCA (`plans/FS100-derivation.md` l. 291); FS100-CX (l. 293) |
| `hAP` | `(chainInterface F).APlusOfR88` = `R88TCA → APlus0` | **M11**, over **M10** (N1 (a), N2 at `T + A`) | EN1 § 8.1 rows 2, 4, 5, 6, 7: J45 N1 (a), N2, SI-1 to SI-4, A⁺ with remark (ii) (`plans/FS84-SI-D-derivation.md` ll. 105–113, 126–135, 145–162, 240–250); EN1-APLUS (`plans/FS131-EN1-derivation.md` § 3) |
| `hPE` | `EntropySplit F` | M5–M7 (planned by others; `entropySplit`, `Rigidity/EntropySplitMax`) | EN1 row 11: FS100-PE2 |
| `hEF` | `NoRamifiedStableDyadic F → ZeroEntropyCarried F` | M8 (`zeroEntropyCarried_of_numberField`, over `TateModel F`, lane T) — typed with no scope | EN1 row 12: FS100-EFP |
| `hCLS` | `5 ≤ localBound F → TCA F` | **M13** | EN1 § 8.1 row 9: FS100-CLS (`plans/FS100-derivation.md` l. 285), -DLP (l. 287), -G27 (l. 289); EN1-UQ4 (§ 7.3) |
| `hRow99` | `localBound F ≤ 4 → localBound F ≤ χ(F²)` | a theorem on `main` (FS131-LJ1: `ThreeFourColours.localBound_le_chromaticNumber_of_le_four`); not on this branch's ancestry | `LEDGER.md` row 99 |

So five of the eight are this job's modules (M2, M3, M11 with M10, M12, M13), and M15 composes the instance.

## Stage 2 — SAVED: the seven modules read and priced

*Every price below is **from Mathlib's coverage at the pin and from the derivations' structure, not from an elaborated
leaf**, unless it says otherwise; `LEAN.md` § The kernel's cost model says a plan's table prices high, and these should be
re-priced from each lane's first two leaves. Line counts include docstrings. "Days" are agent-days of an implementer.*

### 2.1 M2 — Herglotz–Bochner, existence half; and `BochnerOn` at `τ′_∅`

**As its consumers read it.** `BochnerHerglotz (unitRing F)` is read by `rotInv_of_isTraceSpectral` (the trace spectral
measure exists) and by `ext_of_fourier` (uniqueness). Uniqueness is now `DualGroup.measure_eq_of_fourier` at countable `G`
(item 757), so M2a must prove **existence**: every `PosDef C` on a countable `G` is the Fourier transform of a finite measure
on `AddChar G Circle`. `BochnerOn t` (`SpectralInputs` l. 788) is read once, by `spectral_carried_iff`'s `⟸`, which M11 uses
twice (§ 2.4); M12 does not read it (§ 2.5, C1 is the `⟹` direction).

**M2a, route (mine; not Rudin's).** (i) *Almost-invariant weights* on a countable abelian `G`, with no structure theorem: for
an enumeration `g₁, g₂, …`, let `ν` be the convolution of the uniform measures on `{0, gⱼ, …, (M−1)gⱼ}`, `j ≤ k`, and
`w = ν/‖ν‖₂`; Young's inequality and `‖u * f‖₂² ≥ ‖f‖₂²/M` for `f ≥ 0` give `‖τ_{gⱼ}w − w‖₂ ≤ 2/√M`, so
`⟨w, τ_z w⟩ → 1` for every `z` as `k, M → ∞`. (ii) *Fejér densities*: `p_w(χ) = Σ_{x,y} w(x)w(y)C(x−y)·χ̄(x−y) ≥ 0` is
`PosDef` itself (weights `z_x = w(x)χ̄(x)`; the library's `PosDef` takes a `Finset` and a function, so this is direct).
(iii) `σ_w := p_w • dualHaar G` has `∫ χ(z) dσ_w = C(z)·⟨w, τ_z w⟩` by `isHaarFourier_dualHaar` (M4), mass `C(0)`.
(iv) The `σ_w` lie in a compact set of finite measures on the compact metrizable dual
(`MeasureTheory.isCompact_setOf_finiteMeasure_le_of_compactSpace`, Mathlib `Measure/Prokhorov.lean` l. 69); a convergent
subsequence; `χ ↦ χ(z)` is bounded continuous, so the limit's coefficients are `C(z)` (`FiniteMeasure.tendsto_iff_forall_integral_tendsto`).
**Price: 600–900 lines, about 1.5–2 days.** Needs M4 (`Rigidity/DualGroup`: compactness, `borelSpace_dual`, `dualHaar`
and its Fourier form — typed by FS131-KN8, 13 leaves `sorry` on this branch). **Formalize.**

**M2b, `BochnerOn τ′_∅`: route as messaged to the coordinator (ruled: formalize).** (1) *The archimedean part, Bochner
in support form with no Bochner on `ℝ^m`*: let `ρ` be a finite measure on `R̂` whose transform `ψ` is continuous at `0` for
the archimedean topology. Restrict to the lattices `Λ_k = 5^{−k}c₀𝓞_L ⊆ R` (`1/5 ∈ R`; `c₀𝓞_L ⊆ R` from M9's
`exists_mul_stableIntegers_le`), lift the restricted measure from the torus `Λ̂_k` to `V* = Hom(L ⊗ ℝ, ℝ)` through the box
fundamental domain `{ℓ : ℓ(5^{−k}c₀bⱼ) ∈ (−π, π]}`; a one-variable Dirichlet-kernel inequality bounds the mass outside
`|ℓ(bⱼ)| ≤ C/δ` by `2·sup_{|y|<δ}|ψ(0) − ψ(y)|`, uniformly in `k` (tightness); Prokhorov on `V*` (Mathlib
`isCompact_closure_of_isTightMeasureSet`, `Prokhorov.lean` l. 504) gives a limit `ρ̃` whose characteristic function equals
`ψ` on `ℤ[1/5]c₀𝓞_L`, dense in `V` (M9's density); both are continuous, so they agree on `R`; uniqueness (M4) gives
`ρ = exp_*ρ̃`, carried by `A`. (2) *The profinite part*: for `t ∈ T`, `ψ_t(y) := lim_{N′} |R/N′R|⁻¹ Σ_{c ∈ R/N′R} t̄(x_c)·φ(y + x_c)`
with representatives `x_c` arch-small (density), the limit Cauchy by `τ′`-uniform continuity of the positive-definite `φ`;
`t̄·ψ_t` is positive-definite and arch-continuous, so (1) gives `ν_t` on `t·A`; `Σ_{t ∈ T_N} ψ_t(y)` is the fibre average of
`φ`, which tends to `φ(y)`; `ν := Σ_t ν_t` has transform `φ`, and uniqueness gives `σ = ν`, carried by `T·A = TA F`. Needs
`|R/NR| < ∞` (J28V-7: every finite subset of `R` spans a free group of rank `≤ [L:ℚ]`, so `|R/NR| ≤ N^{[L:ℚ]}`; about 150
lines), M10's `τ′`, M9's density, M4. **Price: 2,000–2,500 lines, about 4–6 days.** **Formalize** (`[Rudin1962]` 1.4.3 is the
printed theorem; this route reads none of it).

### 2.2 M3 — the invariant measure on a closed invariant set

**As its consumer reads it.** `exists_invariantColouring` (`SpectralChain` l. 393) applies `InvariantMeasureOnClosed F` to
`K = X₄(F)`. **Route (mine; no Markov–Kakutani):** the `ℓ¹` form of § 2.1 (i)'s weights on the countable group `R`; average
the push-forwards `(shift_y)_*δ_c` of a point mass at `c ∈ K`; limit points (Prokhorov on the compact metrizable
`unitRing F → Fin 4`, Borel = product σ-algebra for a countable product of finite discrete spaces) are shift-invariant
(weights almost invariant; push-forward along a continuous map is continuous in the weak topology) and carried by the
closed `K` (portmanteau for closed sets). Then the same averaging over the countable abelian group `U` acting by rotations:
`shift_y ∘ rot_u = rot_u ∘ shift_{uy}`, so rotating a shift-invariant measure keeps it shift-invariant, and the limit is
invariant under both. `MeasurableSet K` is used only to state `μ Kᶜ = 0`. **Price: 500–800 lines, about 1–2 days**, sharing
the weights lemma with M2a. **Formalize.**

### 2.3 M10 — the continuity group `T + A`

**As its consumer reads it.** `spectral_carried_iff` needs, for a topology `t` on `R`: `IsTopologicalAddGroup`,
`(𝓝 0).IsCountablyGenerated`, `BochnerOn t` (M2b); and M11 needs `contChars t = TA F`. **The topology `τ′_∅`**: the infimum
(Mathlib's order: the finer, generated topology) of the topology induced by `r ↦ (r mod N·R)_{N ≥ 1}` into a product of
discrete quotients and the topology induced by `r ↦ mixedEmbedding L r`. No profinite completion is constructed: a basic
neighbourhood of `0` is `N·R ∩ B_δ`. **The four statements and their routes.** Group topology: inf of two topologies
induced by additive maps (`topologicalAddGroup_induced`, `topologicalAddGroup_inf`). Countably generated: both inducing
spaces first-countable. `TA ⊆ contChars`: a torsion character kills `N·R` (`χ(Nr) = (χ^N)(r)`), so it is locally constant; an
additive `ψ : R → ℝ` is `Σ qⱼ tⱼ` over `ℚ`-coordinates (`ChainAtTA.exists_rat_coords`, private there — **to be made public
or restated**), and `ℚ`-coordinates along a `ℚ`-basis of `L` are continuous for the mixed embedding (an integral basis maps to
an `ℝ`-basis, `NumberField.mixedEmbedding.latticeBasis`). `contChars ⊆ TA`: from continuity, `Re χ > 0` on `N·R ∩ B_δ`, so
`|arg χ^N(r)| < π/(2k)` on `R ∩ B_{δ/(Nk)}` (no small subgroups); `χ^N` is then arch-continuous; on the lattices
`5^{−k}c₀𝓞_L` it is `exp(iℓ_k)` with `ℓ_k` stabilising (bounded, and consecutive ones differ by a vector of a dual lattice
whose minimum grows like `5^k`), so `χ^N exp(−iℓ)` kills the dense subgroup `ℤ[1/5]c₀𝓞_L` and is arch-continuous, hence
trivial; so `χ^N ∈ A` and `χ ∈ TA` (`ChainAtTA.mem_torsion_mul_arch_iff`, private there). **Price: 800–1,200 lines, about
2–3 days.** Needs M9-R (density, `c₀𝓞_L ⊆ R`). **Formalize** (no classical theorem; J45 N1 (a) at `S = ∅` is ours).

### 2.4 M11 — A⁺ at `S = ∅`

**As its consumer reads it.** `(chainInterface F).APlusOfR88`: for every `InvariantColouring μ` and trace spectral `σ`,
`R88TCA` ⟹ `∫_{TAᶜ} Re χ(1) dσ < 0`. **Route (J45 SI-1, SI-3, SI-4, A⁺ with remark (ii)).** With `g_k` the three
tetrahedral coordinates of `c(0)` in `L²(μ)` (real), `𝒜 := factorSigma` for `𝓝[τ′] 0`, `h_k := E[g_k | 𝒜]`, `r_k = g_k − h_k`:
(a) `σ = ⅓Σσ_{g_k}` (uniqueness); (b) `σ_{g_k} = σ_{h_k} + σ_{r_k}` (cross terms vanish: `contVec` is shift-invariant and so
is its complement); (c) `σ_{h_k}(TAᶜ) = 0` — **N2's `⟸`, over `BochnerOn τ′_∅` and `contChars = TA`**; (d) `σ_{r_k}(TA) = 0` —
**the step no record states as a lemma**: if not, the vector `w ∈` the cyclic subspace of `r_k` with `σ_w = σ_{r_k}|_{TA}`
(trigonometric polynomials are dense in `L²(σ_r)` — by Fourier uniqueness applied to the positive and negative parts of a
complex measure with vanishing coefficients — and real-coefficient ones suffice since `σ_r` and `TA` are symmetric) lies in
`contVec` (N2's `⟹`, dominated convergence) and has `⟨w, r_k⟩ = σ_{r_k}(TA) > 0`, against `r_k ⊥ contVec`; (e) SI-3:
`∫_{TAᶜ} Re χ(u) dσ = −(4/3)Σ_j E[p_j(0)p_j(u)] ≤ 0`; (f) remark (ii): the integral is constant on `U`
(`rotInv_of_isTraceSpectral`, kernel); (g) if it is `0` at `u = 1`, SI-4 (kernel: `si4`, `si4_equivariant`,
`FactorAction.si4_equivariant_factorSigma`) gives the factor colouring `c′`; its law is an `InvariantColouring` (a.s.
equivariance under shifts and rotations; carried by `X₄`); its coordinates are `𝒜`-measurable, so its trace spectral measure is
carried by `TA` (N2's `⟸` again); `R88TCA` refuses it. **Price: 1,500–2,500 lines, about 3–5 days.** Needs M10, M2b, M4.
**Formalize** (ours).

### 2.5 M12 — the count, `TCA F → R88TCA`; `m₁(ℝ²) < 1/4`

**As its consumer reads it.** `(chainInterface F).Count`: every stable prime of all-levels ratio `< 1/4` ⟹ no
`InvariantColouring` has trace spectral measure null off `TA`. **The blocks** (R88-TCA with R88-TC-ext, -J28V-2, -TC-reg,
-TC-count, -J28V-3; FS100-TCA; FS100-CX; J28D § 3.2 C1–C5 read today, `plans/FS86-R88-D-derivation.md` ll. 142–201):
- *C1* spectrum on `TA` ⟹ `P(c(0) ≠ c(y)) → 0` as `y → 0` in `G_∅ = (L ⊗ ℝ) × ∏_{stable} 𝓞_{L_v}` — dominated convergence, **no
  Bochner**; but "torsion characters are stable-continuous" reads Lemma C (d) (item 791 ruling 4's question, **carried to
  M12's planner**: with `τ′`'s profinite part the step is free; with the stable-adic topology it reads `R ∩ ∏𝔔^K ⊆ NR`).
- *C2* extension to `G_∅` and a jointly measurable modification (Doob–Cohn). **Not in Mathlib.**
- *C3* a.e. properness on the edges `x ~ x + w`, `w ∈ T_∅`: the closure of `U` is `T_∅` (weak approximation for the norm-one
  torus at the archimedean places, `[S9]` at each stable level). **Not in Mathlib** (weak approximation for a number field
  at its infinite places is; the torus step is a rational parametrisation over it).
- *C4* regularisation of edge-null sets to independent ones (Lebesgue differentiation along `E_n = C_n × V_n`, which is not
  doubling on the infinite product — R88-J28V-2) and C14.1–C14.4's window lemmas.
- *C5* the count: a product of factors each of ratio `< 1/4` has ratio `max(m₁, sup_v c_v) < 1/4` (X25B-PZ, stationary
  Zhang; `[Zhang2012]` Thm 1.8 in finite form); the archimedean factor `UD(ℝ²)^{×n}` has ratio `m₁` (C14.3's induction); a
  complex place by restriction to its compact real form (FS100-CX). **A uniformity the hypothesis does not give:** `TCA F`
  gives each stable prime its own `c_P < 1/4`; the count needs `sup_P c_P < 1/4`. It holds at every number field because all
  but finitely many stable primes have `q ≥ 37`, where Weil (the declared import) and Lemma P give a uniform Hoffman ratio
  (R88-J28V-3). So the proof of `Count` reads Weil; the uniform-tail lemma goes **once, upstream, in M13** (ruled, item 3 of
  the coordinator's reply) and M12 imports it. No typed statement changes.
- Kernel already holding part of C5: `Arith/StationaryRatio` (929 lines; a stationary ratio at a wider class).
**Price: 6,000–12,000 lines, about 3–6 agent-weeks; its own planner** (as the architecture said). Classical inputs:
Doob–Cohn (formalize, about a week by itself), Lebesgue differentiation along a Vitali family (Mathlib has the doubling case;
the product's is custom), weak approximation for the norm-one torus (formalize), measurable Hoffman (`[BachocEtAl2014]`
Thm 2.2, held; formalize), `m₁(ℝ²) < 1/4` (below).

**`m₁(ℝ²) < 1/4` — source, statement, price.** `[AmbrusEtAl2023]` (held: `~/source/library/pdf/arXiv-2207.14179-…pdf`; read in
full by J26; certificate re-checked exactly at H1–H3, H6 and in ball arithmetic at H4, H5 by J49 — `BIBLIOGRAPHY.md` l. 281),
arXiv v3, **Theorem 1, p. 4**: "Any Lebesgue measurable, 1-avoiding planar set has upper density at most 0.2470." **p. 2**:
"The upper density of A, denoted by δ(A), is defined by δ(A) = lim sup_{R→∞} λ_d(A ∩ B_d(x, R)) / λ_d(B_d(x, R)), where x ∈ ℝ^d is
fixed … The definition is valid since the upper density is known to be independent of the choice of x"; **eq. (1)**:
"m₁(ℝ^d) = sup{δ(A) : A ⊂ ℝ^d is 1-avoiding and measurable}". (Copied from the PDF's text layer today.) **Price as a
formalization: 3–6 agent-weeks**, not from a leaf. What Mathlib lacks: positive-definite functions and autocorrelations on
`ℝ²`; the Bessel function `J₀` (the rotation average of a plane wave) and any rigorous bounds on it; the reduction from upper
density of a measurable set to periodic sets. A **first leaf**: for a periodic 1-avoiding set `A`, `f(x) = δ(A ∩ (A − x))` is
positive-definite and vanishes on the unit circle (`[KMOR2016]` Lemma 3.2 (1)) — Fourier series on a torus (Mathlib
`Analysis/Fourier/AddCircleMulti`) plus a density argument, about 300–500 lines; the 23-point inclusion–exclusion (Lemma 1)
is finite and cheap; the cost is the Fourier side of § 5 (certified `J₀` values at the certificate's points: series with
remainder in exact arithmetic). **Ruling (coordinator, today): typed as a named outside hypothesis, not declared; the four
items drafted here (§ Drafts); Kooshi decides.**

### 2.6 M13 — CLS, `5 ≤ localBound F → TCA F`

**As its consumer reads it.** The headline feeds `hCLS h5` to `hCount`. `TCA F` asks, at each stable prime, one `c < 1/4`
bounding every independent set of every level's target. **Route (FS100-CLS, -DLP, -G27; X26B-L1; EN1-UQ4).** (a) `L ≥ 5`
excludes: ramified stable primes (level-one target two- or three-colourable: the kernel has the dyadic case,
`colorable_two_levelTarget_one_of_isRamified`; the odd ramified one is a cycle `Cay(𝔽_q, {±1})`), inert residue sizes
`q ∈ {3, 7}`, dyadic inert `Q ≤ 32`. (b) Levels: the fibres of `S_m → S_{m−1}` and Lemma P (a character new at level
`m ≥ 2` has `|λ| ≤ 2q^{m−1}`, dyadic `Q^{m−1}`), so an all-levels Hoffman bound follows from level one wherever level one's
normalised least eigenvalue is above `−1/3`. (c) Level one by residue size: `q ≥ 37` (Weil, declared; the kernel's
`RatioBound.card_mul_le_of_indep` and `NormOneTarget.targetFloor_of_charSum` are the Hoffman bound in exactly this shape);
`q ∈ {23, 27, 31}` exact spectra (Hoffman: at 27 `λ_min = −8`, ratio `2/9`, FS100-G27; at 23 and 31 the normalised least
eigenvalue clears `−1/3` by `1.6·10⁻³` and `4.9·10⁻⁶` — an exact certificate is needed there, not floats);
dyadic `Q = 64` exact, `128` in the kernel (`Floor128`; to check that it gives the ratio and not only the floor), `Q ≥ 256`
EN1-UQ4 (the fourth-moment count, about 300 lines, one mind, no printed bound read). (d) **`q = 11, 19`: Hoffman fails
(0.2855, 0.2756); the all-levels ratio rests on FS-66's fibre-share inequality [hand] and its exact integer
sum-of-squares certificates [cert], checked by a frozen Python checker — not in the kernel.** Sizes: `data/fs66/b1/cert-p11.json`
0.7 MB, `cert-p19.json` 10.4 MB (second-level moment relaxation, translation-Fourier blocks). Kernel-checking them is a
**measurement owed before a price** (`LEAN.md`: literals, not built tables; GMP `Nat`); the fibre-share inequality holds for
every twisted cover of `Γ_p` (Lemma T), which is what a ramified base needs. (e) **The uniform tail** (shared with M12):
one `c < 1/4` for all stable primes with `q ≥ 37`, at all levels. **Price: 2,500–5,000 lines plus the two certificate checks
(unmeasured), about 1–2.5 agent-weeks.** **Formalize** (Weil is the one outside theorem, already declared).

### 2.7 M15 — the instances, `ℚ(√47)` first

**Statements.** `NumberField` for the `Subfield ℝ` of `√47`; `5 ≤ localBound` there; `χ(ℚ(√47)²) = 5` from
`min_localBound_five_le_chromaticNumber_closed` (once its hypotheses are theorems) and the kernel's upper half
(`SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five`, and `UpperHalf.chromaticNumber_planeOver_le_localBound` on
`main`). **No scope model is needed** (§ 1.2). **`5 ≤ L(ℚ(√47))`, my reading**: `47 ≡ 7 (mod 8)` puts no stable prime above
2; `3` and `7` are inert in `ℚ(√47)` (residue `𝔽_9`, `𝔽_49` already hold `i`, so they split in `L`); no odd prime ramifies
in `L/F`; so every stable prime lies over a `p ≡ 3 (mod 4)` with `(47/p) = 1` or `p = 47`, residue `𝔽_{p²}` with conjugation
non-trivial, and the floor needed is `χ(Γ_p) ≥ 5` at `p ∈ {11, 19, 23, 31}` (each splits: `(47/p) = 1`) and at every
`p ≥ 43` (Weil from `Q ≥ 34`: `3·2√Q < Q + 1`). The four small floors are M13's level-one facts (11 and 19 by a refutation
certificate or FS-66's bound, 23 and 31 by exact Hoffman). **Price: 800–1,500 lines for the place computations and the
composition (Mathlib's `Ideal.sum_ramification_inertia` and the primed `inertiaDeg'` API, `LEAN.md` § Searching), about
1 week; each further field (`ℚ(√143)`, `ℚ(√311)`, `ℚ(√335)`, `ℚ(√3,√5)`, `ℚ(√167) ≥ 5`) about 300–600 lines once the
machinery stands.**

## Stage 3 — SAVED: shorter routes, and what a consumer does not read

1. **M12 does not read `BochnerOn`** (§ 2.5, C1 is dominated convergence); only M11 does, twice. So M2b blocks M11 and
   nothing else on the path.
2. **M2a and M3 share one lemma** (`exists_almostInvariant_weights`; M3 takes the probability weights `(w n)²`), and neither
   reads Markov–Kakutani, Følner sets or the structure theorem of finitely generated groups.
3. **`Interface.Count`'s hypothesis `TCA F` is read and is not enough by itself**: the count needs one constant for every
   stable prime (`tca_uniform`), which the proof gets from Weil at the tail (sent to the coordinator; ruled: the uniform-tail
   lemma goes once, upstream, in M13 — `Rigidity/ClassRatio`).
4. **`InvariantMeasureOnClosed`'s `MeasurableSet K` is derivable from `IsClosed K`** for a countable product of finite
   discrete spaces (`Pi.opensMeasurableSpace`); the step lemmas keep it (it is in the consumer's `Prop`), and an implementer
   who proves them without it should drop it from the step lemmas, not from the `Prop`.
5. **No headline hypothesis is discharged by anything already proved on the chain's branches** beyond what the coordinator
   already knows (`hRow99` on `main`; `BochnerHerglotz`'s uniqueness clause by item 757). C0's three leaves are proved on this
   branch's ancestry (`ChainAtTA.lean` has no `sorry` in `measurableSet_TA`, `rot_preimage_TA`, `exists_nonTorsion_unitVector`).
6. **Two private lemmas of `Rigidity/ChainAtTA` are needed public by M10**: `mem_torsion_mul_arch_iff` and
   `exists_rat_coords`. Making them public changes no statement; it is an edit to another module's file, so it is a question
   for the coordinator (INVENTORY), not done here.

## Stage 4 — SAVED: six modules typed (31 statements, 18 leaves `sorry`)

New modules, each elaborated alone under `lake env lean` (logs `data/fs131/kr1/logs/*.log`: exit 0, every warning
`declaration uses 'sorry'`), then the whole library through `./scripts/build.sh` (§ 4.4). Domain pass (`debruijn-domain-modeling`,
invoked fresh) and obligation pass (`debruijn-obligation-modeling`, invoked fresh) were run on them; what each changed is in
§ 4.2.

### 4.1 The statements, read aloud against their sources

| module | statement | read against | verdict |
|---|---|---|---|
| `Rigidity/Herglotz` (M2a) | `bochnerHerglotz_of_countable [Countable G] : BochnerHerglotz G` — **proved over three leaves** | the claim list's M2 statement 1; `BochnerHerglotz`'s body (`SpectralChain` l. 124) | the `Prop` itself, at every countable `G`; its taker `unitRing F` is countable at a number field (`countable_unitRing`) |
| | `exists_almostInvariant_weights`, `exists_fejer_measures`, `exists_fourier_eq_of_tendsto` | § 2.1 (i)–(iv) | leaves |
| `Rigidity/InvariantMeasure` (M3) | `invariantMeasureOnClosed_of_countable [Countable (unitRing F)] : InvariantMeasureOnClosed F` — **proved over two leaves** | the claim list's M3 statement ("for every `F` with `unitRing F` countable") | word for word |
| `Rigidity/ContinuityGroup` (M10) | `profTop`, `archTop`, `tauPrime` (definitions); `contChars_tauPrime : contChars (tauPrime F) = TA F` — **proved over two leaves**; four further leaves | J45 N1 (a) at `S = ∅` (`plans/FS84-SI-D-derivation.md` ll. 105–113); EN1 § 3.3 | the claim list's statement 1, both inclusions |
| `Rigidity/BochnerTau` (M2b) | `bochnerOn_tauPrime : BochnerOn (tauPrime F)`; `finite_quotient_nsmul`, `archimedean_support`, `exists_twisted_parts` | `BochnerOn`'s body (`SpectralInputs` l. 788); J45 N2's `⟸` (ll. 128–130) | the claim list's M2 statement 2, at the one topology M10 reads |
| `Rigidity/ClassRatio` (M13) | `tca_of_five_le_localBound : 5 ≤ localBound F → TCA F` — **proved over one leaf**; `tca_iff` (`Iff.rfl`); `exists_uniform_tail`, `tca_uniform` | the headline's `hCLS` binder (`ChainAtTA` l. 532), character for character; FS100-CLS; R88-J28V-3 | the binder's type at every number field |
| `Plane/OneAvoidingDensity` (M12's input) | `OneAvoidingDensityBound` (named outside hypothesis); `mOne`; `oneAvoidingDensityBound_model` (**proved**); `upperDensity_le_of_…` (leaf); `mOne_le_…`, `mOne_lt_quarter` (**proved over the leaf**) | `[AmbrusEtAl2023]` p. 4 Thm 1, p. 2 and eq. (1), quoted in § 2.5 | symbol by symbol in § 6.3 |

### 4.2 What the two passes changed

- *Domain pass.* (a) The `ℓ¹` weights M3 needs were folded into the `ℓ²` lemma (probability weights `(w n)²`; one lemma, not
  two). (b) `tauPrime` is a `def`, never an instance: `unitRing F` is a subtype of `ℂ` and already carries the subspace
  topology, and an instance would make a diamond. (c) The `N + 1` guard in `profTop` (the subgroup `0·R` would make `τ′`
  discrete — the adversarial member of the definition). (d) `RatioAtMost` names the body of `TCA`, so `tca_iff` is `Iff.rfl` and
  the uniform form states in the same vocabulary. (e) `m₁` reuses the library's `Plane.upperDensity` and `BandFree A 0` on `ℂ`;
  the paper's form is kept on `EuclideanSpace ℝ (Fin 2)` with every centre, and no second "1-avoiding" predicate is minted on
  `ℂ`. (f) The three `TopologicalSpace`-valued definitions are `@[reducible]` (the pin's linter asks it of a definition of
  class type).
- *Obligation pass.* (a) Two children were added to make the hard leaves explicit: `archContinuousAt_pow_of_mem_contChars`
  (no small subgroups, M10) and `exists_twisted_parts` (the profinite step, M2b). (b) `BochnerTau` imports `Herglotz`: the
  twisted parts become measures by M2a before `archimedean_support` reads them. (c) Every hypothesis of every leaf is read by
  its route (§ 4.3), except `MeasurableSet K` in M3's steps (Stage 3 item 4). (d) The hard leaf of each module is named in
  § 4.3.

### 4.3 The plan per leaf (routes in § 2; Mathlib names `#check`ed in `data/fs131/kr1/probes/Names.out`)

| leaf | route, children, names | hard? |
|---|---|---|
| `exists_almostInvariant_weights` | enumerate `G`; `ν = u₁ * … * u_k`, `uⱼ` uniform on `{a gⱼ : a < M}`; `‖u * f‖₂² ≥ ‖f‖₂²/M` for `f ≥ 0`; Young `‖a * b‖₂ ≤ ‖a‖₁‖b‖₂` on finitely supported functions (by hand, `Finsupp` sums); `w := ν/‖ν‖₂` | medium |
| `exists_fejer_measures` | density `p_w(χ) = Re Σ_{x,y ∈ supp} w x w y C(x−y) χ̄(x−y) ≥ 0` (`PosDef` at `z x = w x · χ̄ x`); `σ_n = (dualHaar G).withDensity (ofReal ∘ p_w)`; coefficients by `isHaarFourier_dualHaar` | medium |
| `exists_fourier_eq_of_tendsto` | `isCompact_setOf_finiteMeasure_le_of_compactSpace` (root namespace, `Prokhorov.lean` l. 69) on the compact dual (M4's scoped topology, `borelSpace_dual`), sequential compactness (metrizable), `FiniteMeasure.tendsto_iff_forall_integral_tendsto` with `χ ↦ Re/Im χ(y)` bounded continuous (`continuous_evalChar`) | low |
| `exists_shiftInvariant_on` | `μ_n := Σ_y (w n y)² • δ_{c(· + y)}`; limit point as above on `unitRing F → Fin 4` (compact, `Pi.borelSpace`); shift invariance from `Σ_y |w(y)² − w(y+z)²| → 0`; `μ K = 1` by the portmanteau for closed sets | medium |
| `exists_rotInvariant_of_shiftInvariant` | the same over the countable abelian group of unit vectors (a subgroup of `Circle`), with `shift_y ∘ rot_u = rot_u ∘ shift_{u y}` | medium |
| `isTopologicalAddGroup_tauPrime` | `topologicalAddGroup_inf` of `topologicalAddGroup_induced` (each a pull-back by an additive map; `⨅` over `N` needs the `iInf` form, `topologicalAddGroup_iInf`, to `#check`) | low |
| `isCountablyGenerated_nhds_tauPrime` | `nhds_inf`, `Filter.Inf.isCountablyGenerated`; `nhds_iInf` and a countable `iInf` of principal filters; first countability of the mixed space | low |
| `TA_subset_contChars` | torsion: `χ(N r) = (χ^N) r` kills `N·R`, constant on open cosets; arch: `exists_rat_coords` (to be made public) and `mixedEmbedding.latticeBasis` (an integral basis is an `ℝ`-basis), so `ℚ`-coordinates are continuous | medium |
| `archContinuousAt_pow_of_mem_contChars` | a basic neighbourhood `N·R ∩ B_δ` where `Re χ > 0`; the integer-multiples argument | low |
| `mem_archChars_of_continuousAt` | **the hard leaf of M10**: lattices `5^{−k}c₀𝓞_L ⊆ R` (`exists_mul_stableIntegers_le`'s step (b), `1/5 ∈ R`), `ℓ_k` in the box domain, stabilisation, density (`dense_mixedEmbedding_nsmul_unitRing`) | hard |
| `finite_quotient_nsmul` | every finite subset of `R` spans a free `ℤ`-module of rank `≤ [L:ℚ]` (`Module.free_of_finite_type_torsion_free'`), so the image in `R ⧸ N·R` has `≤ N^{[L:ℚ]}` elements | medium |
| `archimedean_support` | § 2.1 M2b (1); `isCompact_closure_of_isTightMeasureSet` (root, `Prokhorov.lean` l. 504); characteristic functions continuous; `measure_eq_of_fourier` | hard |
| `exists_twisted_parts` | **the hard leaf of M2b**: twisted Riemann sums, Cauchy by uniform continuity of a positive-definite function (`|φ(x) − φ(y)|² ≤ 2φ(0)(φ(0) − Re φ(x − y))`), `finite_quotient_nsmul`, density | hard |
| `ratioAtMost_of_five_le_chromaticNumber` | **the hard leaf of M13**, to be cut by its implementer's planner into: the exclusion list (ramified: `colorable_two_levelTarget_one_of_isRamified`; `q ∈ {3, 7}`, `Q ≤ 32` four-colourable by formula, X26B); Lemma P at levels `m ≥ 2`; level one by residue size (Weil via `RatioBound.card_mul_le_of_indep` and `kloosterman_bound`; exact spectra at 23, 27, 31, 64; `Floor128` at 128; EN1-UQ4 for `Q ≥ 256`); FS-66 at 11 and 19 (**the certificate check, to be measured first**) | hard |
| `exists_uniform_tail` | absolute norm above every dyadic and every `q ≤ 31` prime's; then odd inert `q ≥ 37`: Weil and Lemma P, `c = max over the bound's two branches` | medium |
| `tca_uniform` | `Ideal.finite_setOf_absNorm_le`; `StablePrime` determined by its ideal; the maximum of finitely many `c_P` and the tail's | low |
| `upperDensity_le_of_oneAvoidingDensityBound` | `Complex.orthonormalBasisOneI.repr : ℂ ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin 2)` with `LinearIsometryEquiv.measurePreserving`; it maps `ball 0 R` to `ball 0 R` and preserves `dist`; the paper's form at `x = 0` | low |

### 4.4 The build

`./scripts/build.sh` under `scripts/slot.py --mem 10 --cpus 4` (`MEMMAX=10G BATCH=8`): log
`data/fs131/kr1/logs/build-1.log` (result in § 4.5 below).

## Drafts for files I do not write

*(filled at the stages that produce them)*
