# X11K — the kernel lane for `χ(ℚ(√47)²) = 5`: dependency map, skeleton, first leaves

*Job X11K (de Bruijn, kernel engineer), 2026-09-26, briefed by the product owner ("main") at Kooshi's request: "If 47 lands at 5, tell
all running agents the news, and launch one to start formalizing the dependencies in Lean." Brief:
`data/crunch-2026-09-26-x2x3/briefs/X11K-lean-47-dependencies.md`, with `STANDING-RULES.md` (not its 06:50 clock). Working files:
`data/fs100/x11k/`. Nothing here is in `Proofs/` until it is sorry-free and gated.*

## Theorems this phase proved

All in `data/fs100/x11k/skeleton/Sqrt47.lean`, checked by Lean's kernel under `lake env lean` (a skeleton, not the gated build);
axioms read by `#print axioms` (stage 4):
- `Interface.mr_of_pe2_efPlus` — node M: PE-2 and EF_F⁺ (interface form) give MR (Fourier form) [Lean, standard three axioms, sorry-free].
- `x4_nonempty_of_colorable` — node L0: a proper four-colouring of `F²` restricts to `X₄(F)` [Lean, standard three, sorry-free].
- `measurable_eval`, `measurable_rot` — evaluation and rotation are measurable on `R̂` [Lean, standard three, sorry-free].
- `rotInv_of_isTraceSpectral` — node L3: the trace spectral measure is rotation-invariant, given Herglotz–Bochner with uniqueness [Lean;
  sorry-dependent only through the leaf `posDef_corr`].
- `Interface.x4_eq_empty` — node L6, SP-Cor's composition: X-BH, R-U, A⁺ at `S = ∅`, MR ⟹ `X₄(F) = ∅` [Lean; sorry-dependent only
  through the leaves `exists_invariantColouring`, `posDef_corr`].
- `Interface.five_le_chromaticNumber`, `chromaticNumber_planeOver_sqrt47_eq_five`, `chromaticNumber_planeOver_sqrt47_le_five` — the
  compositions L, H, U [Lean; sorry-dependent through the three leaves].
- [hand, this record §1.3 M1c] At ℚ(√47), Lemma W's Chebotarev input is Dirichlet's theorem: every prime `p ≡ 1 (mod 188)` splits
  completely in `ℚ(√47, i)` (`p ≡ 1 (mod 4)`; `(47/p) = (p/47) = 1` by reciprocity, `p ≡ 1 (mod 47)`).

## Would-have-searched-here log

- (none so far — nothing in this job is a search; the kernel lane is statement and proof work)

## Stage 1 — SAVED (quotation check; §D, the dependency map)

### 1.1 Quotation check (standing rule 5)

| # | quotation in the brief | source checked | result |
|---|---|---|---|
| Q1 | Kooshi: "If 47 lands at 5, tell all running agents the news, and launch one to start formalizing the dependencies in Lean." | owner-supplied; no file carries it | not checkable here; recorded as the owner's |
| Q2 | "EF_F, in X01D's stronger form EF_F⁺ … a second mind's checking reading (X01V's stage 4, VALID …)" | `plans/FS100-X01V-verification.md` line 315: "**Verdict: X01D's step is VALID; EF_F⁺ holds, and with it EF_F** [hand: one derivation (X01D) and this checking reading, not independent]." | **matches**; grade is one derivation + a non-independent checking reading |
| Q3 | "PE-2 (PE-lim): X02D, and X02V blind — both TRUE, given Einsiedler–Lindenstrauss 2021 Thm 1.2 … (X02D's PE-1′, X02V's (★)); PE-1 as first stated is FALSE" | reports X02D, X02V (`data/crunch-2026-09-26-x2x3/reports/`) | **matches** |
| Q4 | "SP-Cor: X05V blind, TRUE, given J45's N1, N2, R-U … and R88-TCA at `S = ∅`" | report X05V, first INVENTORY line: "SP-Cor re-derived P0–P8 from lemma statements [hand; given N1, N2, R-U (J45, one mind) and R88-TCA at S=∅]" | **matches** |
| Q5 | "`χ(ℚ(√47)²) ≤ 5`: held (row 84)" | `LEDGER.md` row 113: "It does not decide `χ(ℚ(√47)²)` (`4 ≤ χ ≤ 5` stands; FS-84)"; `CLAUDE.md` item 10 "a proven 4 ≤ χ ≤ 5 (row 84; FS-84)" | **matches**; the upper half is Theorem A at 11, **not in the kernel** (§1.3, node U) |
| Q6 | MR(F): "every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure" | `plans/FS100-X01D-derivation.md` §1.2 Q1, quoting `plans/STUB-measure-rigidity-three-fields.md` line 58 | **verbatim** (taken from X01D's check, not re-opened) |

### 1.2 Notation (verbatim, `plans/CRUNCH-2026-09-26-x2x3-queue.md` §2)

"`F ⊆ ℝ` a real number field, `L = F(i)`, `U = U_F` the unit vectors (norm-one elements of `L/F`), `R = ℤ[U]`, `R̂` its dual; `T` the
torsion characters, `A(R_F)` the archimedean ones, `E = ⋃_S (T + A + Fin_S)` (`Fin_S`: continuous at the finite set `S` of split places)."
"`U` acts on `R̂` by `(u·χ)(x) = χ(ux)`; `m` is Haar probability on `R̂`; `h_μ(u)` is the Kolmogorov–Sinai entropy of `χ ↦ u·χ` for `μ`."

### 1.3 §D — every lemma on the path, one line each

Status key: **K** in the kernel (declaration named) · **M** Mathlib has it (name found by grep) · **F** formalizable now (price in harness
tokens, a guess until stage 4 re-prices) · **X** external (enters as a named hypothesis; what Mathlib lacks) · **P** the project's own
[hand] step (formalizable only after the X-nodes under it; price given).

**The headline.** H: `χ(ℚ(√47)²) = 5` ⟸ U ∧ L.

**U — the upper half, `χ(ℚ(√47)²) ≤ 5`** (Theorem A at the prime 11: `47 ≡ 3 ≡ 5² (mod 11)`, so 11 splits in ℚ(√47) with residue field
𝔽₁₁, and `11 ≡ 3 (mod 4)`).

| node | statement (quoted, address) | uses | status |
|---|---|---|---|
| U1 | "`chromaticNumber_finitePlane11 : (finitePlane 11).chromaticNumber = 5`" | — | **K** `Proofs/HadwigerNelson/Instances/FinitePlane11.lean:104` |
| U2 | "**Colourability pulls back through a subring that holds every unit vector.**" (`unitQuadrance_colorable_of_subring`) | — | **K** `Transcendental.lean:109` |
| U3 | "The chromatic number of the plane over `L ⊆ ℝ` is that of `unitQuadrance L`." (`chromaticNumber_planeOver_eq`) | — | **K** `Transcendental.lean:99` |
| U4 | normal form: every element of `fieldOfRadicands {47}` is `a + b√47`, `a, b ∈ ℚ`, uniquely | `Nat.Prime.irrational_sqrt` (**M**), `Subfield.closure_le` | **F** ~40k |
| U5 | the subring `A = {a + b√47 : a, b ∈ ℤ₍₁₁₎}` and `φ : A →+* ZMod 11`, `√47 ↦ 5` | U4, `47 ≡ 5² (mod 11)` | **F** ~30k |
| U6 | every unit vector `(x, y)` of `ℚ(√47)²` has `x, y ∈ A` (descent: with `11 ∣ n`, `(a+b√47)² + (c+e√47)² = n²` forces `a ± 5b ≡ c ± 5e ≡ 0`, hence `11 ∣ a, b, c, e`) | U4, `sq_add_sq_eq_zero_iff` (**K**, `LocalGlobal.lean:285`) | **F** ~30k |
| U | `χ(ℚ(√47)²) ≤ 5` | U1–U6 | **F** (sum ~100k) |

**L — the lower half, `χ(ℚ(√47)²) ≥ 5`**, SP-Cor's chain (`plans/FS84-SI-D-derivation.md` §4.2, §5.4).

| node | statement (quoted, address) | uses | status |
|---|---|---|---|
| L0 | a proper four-colouring of the plane restricts to `X₄(F)` (proper four-colourings of `Cay(R, U)`) | — | **F** ~5k |
| L1 | SP-Cor's first step: "If `X₄(F) ≠ ∅`, it is compact and invariant under the countable amenable (abelian-by-abelian) group `R ⋊ U` acting by `c ↦ c(v· + y)`; take an invariant `μ`." (§4.2) | Tychonoff (**M**), compactness of probability measures on a compact metrizable space, **Markov–Kakutani** twice (average over `R`, then `U` acts on the `R`-invariant ones) | **F** ~200k: Mathlib has Følner filters (`MeasureTheory/Group/FoelnerFilter.lean`) and Riesz–Markov–Kakutani, no Markov–Kakutani fixed point and no invariant-measure existence for amenable actions |
| L2 | "Trace spectral measure `σ_μ`. The finite positive measure on `R̂` with `∫ χ(y) dσ_μ(χ) = C(y) := E_μ⟨g(0), g(y)⟩` for every `y ∈ R` (Bochner on the discrete group `R` …)" (§1.2) | **X-BH** | **X** (Herglotz–Bochner) |
| L3 | "`C(vy) = C(y)` (a rotation about 0 fixes `c(0)`), so `σ_μ` is `U`-invariant" (§4.2) | L2's uniqueness (Fourier uniqueness on `R̂`) | **F** given X-BH with uniqueness, ~15k |
| L4 | R-U: "every finite `U`-invariant measure on `R̂` gives `E_S ∖ (T + A)` measure 0, for every finite `S`." (§5.4) | N1 (b); class number `h` of `L` (**M** `NumberField.classNumber`); split-place valuations | **P** [hand, J45, J46 blind]; months (needs N1) |
| L5 | A⁺ at `S = ∅`, remark (ii): "If `μ` is also rotation-invariant (`R ⋊ U`), `σ_μ` and `E_S` are `U`-invariant, so `u ↦ ∫_{R̂∖E_S} χ(u) dσ_μ` is constant on `U`: strict at every `u`, in particular at `u = 1`." (§3) | SI-3, SI-4, N2, R88-TCA at `S = ∅` | **P** [hand, J45; X05V blind] |
| L5a | SI-1 / SI-3: "`∫_{R̂∖E_S} Re χ(u) dσ_μ = −(4/3) Σ_j E[P(c(0) = j | 𝒜_S) P(c(u) = j | 𝒜_S)]`; it is `0` iff the supports at `x` and `x + u` are a.s. disjoint for every `x`." (§5.4) | N2; `MeasureTheory.condExp` (**M**) | **P**, ~80k after N2 |
| L5b | SI-4: "if equality holds for every `u ∈ U`, then `x ↦ min supp P(c(x) = · | 𝒜_S)` is an `𝒜_S`-measurable, translation-equivariant proper four-colouring." (§5.4) | SI-3 | **P**, ~40k after SI-3 |
| L5c | N2: "for `f ∈ L²(μ)`, `σ_f(R̂ ∖ E_S) = 0` iff `y ↦ V_y f` is `τ′_S`-continuous, and these `f` are exactly `L²(𝒜_S)` for a translation-invariant σ-algebra `𝒜_S`." (§5.4) | **X-ST** (spectral measures of a unitary representation of `R`), N1 | **P** over **X** |
| L5d | N1: "`T + A + Fin_S` equals the group of `τ′_S`-continuous characters of `R`; `R` is dense in `G′_S`; `E_S` is a proper, dense, Haar-null Borel subgroup of `R̂`." (§5.4) | profinite completion, `L ⊗ ℝ`, `L_v` at split `v` (Mathlib has adic completions and infinite places, no Pontryagin duality for them) | **P**; months |
| L5e | R88-TCA at `S = ∅` (row 113), verbatim as quoted in §3: "no translation-invariant Borel probability on `X₄(F)` has spectral measure carried by `T + A + Fin_S` for a finite set `S` of split places" | row 112's inputs: **X-AMB** (`m₁(ℝ²) ≤ 0.246989`), FS-66's certificates at 11 and 19 (Python-checked, not kernel), Hoffman tail (**X-WEIL**), Lemma P (ramified 47), split places ratio 0, weak/strong approximation (**X-APP**), a stationary Zhang count, C14.2 (c) at `q = 2` (only for `S ∋` the dyadic place; not at `S = ∅`) | **P** [hand, two derivations J28D, J28V]; months |
| L6 | SP-Cor: "Over ℚ(√47): if every finite positive `U`-invariant measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure, then `χ(ℚ(√47)²) ≥ 5`." (§4.2) — the composition: `τ := σ_μ|_{R̂∖E}` is `U`-invariant, `E`-null, `∫ Re χ(1) dτ < 0`; a Haar multiple has `∫ χ(1) dτ = 0` | L0–L5, MR | **F** at the level of an interface (stage 3), ~20k |
| M | MR(ℚ(√47)) ⟸ PE-2 ∧ EF_F⁺ (`plans/FS100-X01D-derivation.md` §4.1, §4.3): `τ = a·m + τ′`, `τ′` zero-entropy ⟹ (EF_F⁺) carried by `T + A ⊆ E`; `m(E) = 0` (N1) ⟹ `τ′(E) = τ(E) = 0` ⟹ `τ′ = 0` | M1, M2, N1 | **F** at the interface level, ~10k |
| M1 | PE-2: "For every real number field `F` and every `U`-invariant finite positive measure `τ` on `R̂`: `τ = a·m + τ′` with `a ≥ 0`, `τ′` a `U`-invariant finite positive measure, and `h_{τ′}(u) = 0` for every `u ∈ U`." (queue §2) | M1a–M1e | **P** [hand, X02D; X02V blind] over **X-EL** |
| M1a | Lemma Γ: "For an admissible `Γ` … and a `Γ`-invariant, `Γ`-ergodic probability measure `ρ` on `R̂`: `ρ = m`, or `h_ρ(γ) = 0` for every `γ ∈ Γ`." (`plans/FS100-X02D-derivation.md` line 84) | PE-1′, **X-EL**, inverse limit of solenoids `M̂` (Haar mass constant up the system, X02V-4) | **P** |
| M1b | PE-1′: "For admissible `Γ` and `M ⊂ R` a finitely generated `ℤ[Γ]`-submodule with `ℚM = L`: `M̂` is a solenoid, the `Γ`-action is by automorphisms, totally irreducible, not virtually cyclic and without virtually cyclic factor; so EL2021 Thm 1.2 applies …" (X02D line 146) | EL2021's definitions | **P** |
| M1c | Lemma W: "For every non-torsion `u ∈ U` there is `w ∈ U` with `ℚ(wᵏ) = L` for all `k ≥ 1` and `u, w` multiplicatively independent" (X02D line 156) | "Chebotarev (in the Galois closure)"; class number | **P**; **at ℚ(√47) Chebotarev is not needed** — `L = ℚ(√47, i)` is biquadratic and every prime `p ≡ 1 (mod 188)` splits completely (`p ≡ 1 (mod 4)`, and `(47/p) = (p/47) = 1` by reciprocity), so Dirichlet suffices: **M** `Nat.infinite_setOf_prime_and_eq_mod` (`NumberTheory/LSeries/PrimesInAP.lean:475`) |
| M1d | Γ-ergodic decomposition; "entropy affine over decompositions" (Jacobs) | **X-ED**, **X-JAC** | **X** |
| M2 | EF_F⁺: "every `U`-invariant finite positive Borel measure `μ` on `R̂` such that `h_μ(u*) = 0` for **one** non-torsion `u* ∈ U` satisfies `μ(R̂ ∖ (T + A)) = 0`." (X01D line 194) | **X-SMB**, the product formula (**M** `NumberField.prod_abs_eq_one`, `ProductFormula.lean:98`), pigeonhole, wandering shells | **P** [hand, X01D; X01V stage 4 checking reading, not independent] |

**External theorems (the named hypotheses), and what Mathlib lacks.**

| name | statement (quoted) | Mathlib lacks |
|---|---|---|
| **X-EL** | EL2021 Thm 1.2, verbatim via X02D line 53: "Theorem 1.2. [7, Thm. 1.1] Let α be a totally irreducible, not virtually-cyclic Z^d-action by automorphisms of a solenoid X. Let µ be an α-invariant and ergodic probability measure. Then either µ = m_X is the Haar measure of X, or the entropy h_µ(α^n) = 0 vanishes for all n ∈ Z^d." (held: `~/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf`, p. 2) | Kolmogorov–Sinai entropy (none at all), solenoids, ℤ^d-actions by automorphisms, total irreducibility |
| **X-BH** | Herglotz–Bochner for a countable discrete abelian group `R`: a positive-definite `C : R → ℂ` is `C(y) = ∫ χ(y) dσ` for a unique finite positive measure `σ` on `R̂` (Rudin, *Fourier Analysis on Groups* 1.4.3; not quoted from a held copy) | positive-definite functions; only `Measure.ext_of_charFun` on inner-product spaces |
| **X-ST** | spectral measures of a unitary representation of `R` (for N2, SI-1) | spectral theorem for unitary representations |
| **X-SMB** | Shannon–McMillan–Breiman | entropy, SMB |
| **X-ED**, **X-JAC** | ergodic decomposition; Jacobs's formula | both |
| **X-AMB** | `[AmbrusEtAl2023]` Thm 1, `m₁(ℝ²) ≤ 0.246989` (certificate re-checked J26, J49; row 112) | the certificate's arithmetic would be a kernel certificate job, not a library gap |
| **X-WEIL** | Weil's bound for Kloosterman sums (the Hoffman tail from 37 up; G44) | Weil bounds |
| **X-APP** | weak and strong approximation for number fields (row 112) | strong approximation |

**What is *not* an input at `S = ∅`** (so it stays out of the map): C14.2 (c) at `q = 2` (row 113 needs it only when `S` holds the dyadic
place), Lemma C, Lemma R (J45 chose `G′_S` so that nothing below needs them; `plans/FS84-SI-D-derivation.md` §1.2).

### 1.4 The graph

```
H: χ(ℚ(√47)²) = 5
├── U: χ ≤ 5 ── U2 (K) ── U1 (K: χ(Γ₁₁)=5) ── U3 (K) ── U6 descent (F) ── U5 φ: A → ZMod 11 (F) ── U4 normal form (F)
└── L: χ ≥ 5 ── L6 SP-Cor (F at the interface)
    ├── L0 restriction (F)
    ├── L1 invariant μ on X₄ (F: Markov–Kakutani ×2)
    ├── L2 spectral measure σ_μ ── X-BH
    ├── L3 σ_μ U-invariant ── X-BH uniqueness
    ├── L4 R-U (P) ── L5d N1 (P)
    ├── L5 A⁺ at S=∅ (P)
    │   ├── L5a SI-1/SI-3 (P) ── L5c N2 (P) ── X-ST, L5d N1
    │   ├── L5b SI-4 (P) ── L5a
    │   └── L5e R88-TCA at S=∅ (P, row 113) ── X-AMB, X-WEIL, X-APP, FS-66 certs (tools), Lemma P, Zhang count
    └── M: MR (F at the interface) ── L5d N1 (m(E)=0, T+A ⊆ E)
        ├── M1 PE-2 (P) ── M1a Lemma Γ (P) ── M1b PE-1′ (P) ── X-EL
        │                ├── M1c Lemma W (P; Dirichlet M at ℚ(√47))
        │                └── M1d X-ED, X-JAC
        └── M2 EF_F⁺ (P) ── X-SMB, product formula (M)
```

**Reading of the map.** The upper half is formalizable now, from three kernel theorems and three new leaves (~100k). The lower half splits
into a **composition layer** (L0, L3, L6, M — formalizable now once the deep nodes are stated as hypotheses about an interface) and a
**deep layer**: every P-node under it sits on at least one X-node Mathlib lacks entirely (entropy, spectral measures, Bochner, ergodic
decomposition) or on the adelic topology `τ′_S` (N1). The cheapest P-node that is *not* over an X-node is **M1c at ℚ(√47)** (Dirichlet
suffices), but it is consumed only through M1, which is over X-EL.

## Stage 2 — SAVED (the reframe, kernel-sized: §G and §PA; a kernel milestone has no §IQ)

### §G — what bears on the lane (one line each; entries not listed are silent: they concern search, forcing or construction, none of which a kernel port of a derived chain does)

| entry | verdict | what it changes |
|---|---|---|
| G35 / G43 (Theorem A is kernel over rings; the field-level step is row 57's gap) | **bears** | node U: avoid the gap for one field by an **elementary descent at 11** (U6), as Theorem B avoided valuation theory by a parity descent (row 57) — no number-field machinery, no valuation subring |
| G63 ("one lemma under two methods") | **bears** | reuse `unitQuadrance_colorable_of_subring` (U2), the lemma under both Theorem A's finite places and `t = 0` |
| G44 / G56 (usable primes; residue degree) | **bears** | 11 is usable for ℚ(√47): `47 ≡ 3 ≡ 5² (mod 11)`, `11 ≡ 3 (mod 4)`; the colouring is `φ : a + b√47 ↦ a + 5b` |
| G48 (the conjecture; `L(F)`) | **bears** | the headline is the five-clause at ℚ(√47): `L = 5` from 11 (upper), `χ ≥ 5` the chain (lower); read the statement against this at stage 3 |
| G30 items 5 and 7 (a theorem over an empty domain; a hypothesis implied by the conclusion's emptiness) | **bears** | the lower half is stated over an **interface** of named hypotheses; each structure hypothesis ships a model, and the headline's hypotheses must be ones the true mathematics satisfies — never a bundle that is empty or that implies `X₄ = ∅` outright |
| G21 (a control must be reachable; the plant must fire) | **bears** | every `tools/x11k_*.py` check gets a plant watched firing |
| G76, rows 112–113 | **bears** | L5e's inputs are row 112's (X-AMB, FS-66's certificates, Weil, approximation, Lemma P, Zhang's count); at `S = ∅` C14.2 (c) is not one |
| G79 (example invariants) | **bears (method)** | SP-Cor's σ_μ is an example invariant (the spectrum of an actual colouring); the kernel lane ports it, and the close records it as such |
| row 105 (prime inversion in valuation form, kernel) | **bears (cross-check)** | U6 is the easy half of "no stable prime above 11 inverts": unit vectors are 11-integral; the kernel's valuation form is not reused because U avoids valuation subrings |
| row 118 and inventory item 5 (EL2021 "never applies" on `R̂`) | **bears** | X-EL's scope in the map is `M̂` for finitely generated `ℤ[Γ]`-submodules (M1b), never `R̂` |
| row 119 (FS-75) | **bears** | the headline's shape is row 119's: `((unitDistance ℂ).induce (planeOver (SquareClass.fieldOfRadicands {47}))).chromaticNumber` |
| § What compute helps (M2, FS-75: kernel leaves priced high; grep Mathlib by shape at the skeleton) | **bears** | the stage-1 prices are provisional; re-price from the first two leaves closed |
| G72 / §IQ | silent | a kernel milestone (WORKFLOW 3.3 exempts it) |

### §PA — is the combination formalized anywhere? (ten minutes)

- **Mathlib** (grep of `.lake/packages/mathlib`, this session): no Kolmogorov–Sinai entropy, no Shannon–McMillan–Breiman, no ergodic
  decomposition, no Bochner/Herglotz for groups (only `Measure.ext_of_charFun` on inner-product spaces), no Markov–Kakutani, no
  compactness of the dual of a discrete group (`Topology/Algebra/PontryaginDual.lean` has local compactness only). **Has:** Følner filters
  (`MeasureTheory/Group/FoelnerFilter.lean`), Dirichlet's theorem (`Nat.infinite_setOf_prime_and_eq_mod`), the product formula
  (`NumberField.prod_abs_eq_one`), the class number (`NumberField.classNumber`), `Nat.Prime.irrational_sqrt`.
- **Community** (two web searches, "Lean 4 formalization Kolmogorov-Sinai entropy measure rigidity Mathlib ergodic theory project";
  "Lean Mathlib Bochner theorem positive definite functions locally compact abelian group Pontryagin duality formalization"): one
  project, `github.com/marcmorningstar/lean4-ergodic-theory`, whose issue #13 describes "Kolmogorov–Sinai entropy of a system as a
  supremum over partitions" as done and the relative theory as requested — **seen in a search listing only, not read** (G50: to open
  before any entropy node is formalized). No formalization of Einsiedler–Lindenstrauss, Einsiedler–Fish, Rudolph–Johnson or Host found;
  no Bochner theorem for groups found.
- **Verdict:** nothing found formalizing the combination; the negative measures two searches' words (G21).

### Stage 2 addendum (the owner's update, received during stage 2): EF_F⁺ has two derivations

Node M2 (EF_F⁺) rests on **two derivations**: X01D (`plans/FS100-X01D-derivation.md` §3: SMB, local injectivity by the product formula,
pigeonhole with `U_ℚ` multipliers, the two-scale identity, wandering shells) and **X12B, blind** (`plans/FS100-X12B-derivation.md`, verdict
line 42: "The route is Einsiedler–Fish's Lemma 3.2 run at the places where `u*` expands, followed by a second step EF does not need (on `𝕋`
there are no other places): a finite `U`-invariant measure on the non-compact adelic group of the remaining places must vanish at every
finite split place. Neither step uses ergodicity."), plus X01V's checking reading. **The graph uses X12B's route**: its second step (Lemma Z)
is R-U's wandering-set mechanism on the same adelic model of `R̂` (Tate duality, X12B §2.0), so it shares N1's infrastructure; its first
step is Einsiedler–Fish Lemma 3.1–3.2, an entropy lemma of a held paper (X-SMB-level inputs either way). Both routes need
Kolmogorov–Sinai entropy, which Mathlib lacks; neither is formalizable before X-SMB. M2's line in §D now reads: **P** [hand, two
derivations: X01D; X12B blind] over X-SMB and (X12B) EF 2010 Lemmas 3.1–3.2.

## Stage 3 — SAVED (the skeleton)

**File:** `data/fs100/x11k/skeleton/Sqrt47.lean` (one file: a skeleton outside `Proofs/` cannot import a sibling). **Elaborates** under
`scripts/slot.py --mem 12 --cpus 4 -- lake env lean …`, exit 0, log `data/fs100/x11k/sqrt47.log`: **7 `sorry` leaves**, every other
declaration proved, the headline included.

| declaration | node | status |
|---|---|---|
| `chromaticNumber_planeOver_sqrt47_le_five` | U | **proved** from U1–U3 (kernel) and the leaf `exists_residue11` |
| `exists_residue11` | U4–U6 | leaf |
| `unitVectors`, `unitRing` (`R = ℤ[U]` as `Subring.closure`), `X4`, `Dual` (`AddChar R Circle`, cylinder σ-algebra), `rot`, `RotInv`, `InvariantColouring`, `tetra`, `corr`, `IsTraceSpectral`, `PosDef` | notation | definitions |
| `BochnerHerglotz` | X-BH | named `Prop`, docstring quotes the statement (Rudin; not from a held copy) |
| `Interface` (`E`, `TA`, `h`, measurability, `TA ⊆ E`, `E` rotation-stable) with model `Interface.trivial` | the interface | structure + inhabitant |
| `Interface.RU`, `.APlus0`, `.PE2`, `.EFPlus` | L4, L5, M1, M2 | named `Prop`s, docstrings quoting §5.4 / queue §2 / X01D line 194 |
| `Interface.MR` (Fourier form) | M's conclusion | definition |
| `Interface.mr_of_pe2_efPlus` | M | leaf |
| `x4_nonempty_of_colorable` | L0 | leaf |
| `exists_invariantColouring` | L1 | leaf (formalizable: Markov–Kakutani twice) |
| `posDef_corr` | L2's input | leaf |
| `rotInv_of_isTraceSpectral` | L3 | leaf |
| `Interface.x4_eq_empty` | L6 (SP-Cor) | leaf |
| `Interface.five_le_chromaticNumber` | L | **proved** from L0, L6, M |
| `chromaticNumber_planeOver_sqrt47_eq_five` | H | **proved** from U and L |

**The headline, read aloud against the informal claim.** *Lean:* "for `F = fieldOfRadicands {47}`: if Herglotz–Bochner (with uniqueness)
holds on the ring `ℤ[U]`, and some rotation-stable measurable set `E` of characters of `ℤ[U]`, with a measurable subset `TA`, and some
function `h` from measures and unit vectors to `[0, ∞]` satisfy R-U (`τ(E ∖ TA) = 0` for rotation-invariant finite `τ`), A⁺ at `S = ∅`
(`∫_{TAᶜ} Re χ(1) dσ < 0` for the trace spectral measure of every translation- and rotation-invariant random proper four-colouring of
`Cay(ℤ[U], U)`), PE-2 in consequence form (every rotation-invariant finite `τ` is an `E`-null part with vanishing Fourier coefficients off `0`
plus a part with `h = 0` at every unit vector) and EF_F⁺ at every `u` (a rotation-invariant finite measure with `h = 0` at every unit vector
is carried by `TA`), then the unit-distance graph on `ℚ(√47)²` has chromatic number exactly 5." *Informal claim:* "`χ(ℚ(√47)²) = 5`, given
Einsiedler–Lindenstrauss 2021 Thm 1.2 and standard theorems (Bochner, spectral theorem, SMB, ergodic decomposition, Jacobs), and the
project's [hand] lemmas." **Where they differ, stated so nobody reads more into the Lean than is there:**
1. `E`, `TA`, `h` are **abstract**: the theorem certifies the *composition* (SP-Cor and MR ⟸ PE-2 ∧ EF_F⁺), valid for every choice. That the
   arithmetic `E = ⋃_S (T + A + Fin_S)`, `TA = T + A` and Kolmogorov–Sinai entropy satisfy the four `Prop`s is the content of the [hand]
   lemmas (R-U, A⁺, PE-2 over EL2021, EF_F⁺) and of N1, which the Lean does not see. The honest name for the hypothesis list is "the
   chain's four project lemmas and one classical theorem", **not** "EL2021 Thm 1.2" alone: no hypothesis here is an external theorem stated
   in its own terms except X-BH, because EL2021's own terms (entropy, solenoids) are not definable on the budget of this job.
2. **VACUITY NOTE (G30 item 7).** `APlus0` quantifies over invariant random four-colourings, of which there are none exactly when the
   conclusion holds, so the conclusion implies `APlus0`. This is the shape of R88-TCA itself ("no translation-invariant Borel probability on
   `X₄(F)` has …"), and its content is its derivation from row 113, which never assumes emptiness. Every other hypothesis is about measures
   on `R̂` (never empty: Haar), and `Interface.trivial` inhabits the structure.
3. PE-2's `a·m` is recorded by the two properties used (`E`-null; Fourier coefficients vanish off `0`), and MR by its Fourier form: each is
   implied by the source statement (Haar's coefficients vanish off `0`; `m(E) = 0` is N1), so the Lean hypotheses are **no stronger** than
   the sources. EF_F⁺ is weakened to "zero entropy at every `u`" (the source needs one non-torsion `u*`): weaker, hence also implied.
4. The upper half is unconditional once `exists_residue11` closes.

**Spec examples:** `tetra 0 0 = 1`, `tetra 0 1 = -1/3`, `(Interface.trivial F47).E = ∅` (in the file).

## Stage 4 — SAVED (leaves burned, cheapest first)

**Closed:** node M (`Interface.mr_of_pe2_efPlus`, one elaboration), node L0 (`x4_nonempty_of_colorable`, two), node L6
(`Interface.x4_eq_empty`, SP-Cor's composition, six), node L3 (`rotInv_of_isTraceSpectral`, two), with the measurability lemmas
`measurable_eval`, `measurable_rot`. One statement was corrected on the way: `Interface.PE2` first omitted "`τ′` a `U`-invariant"
from its existential, which the source states and M's proof needs (caught by the proof, fixed before any use).
**Left in the skeleton: three leaves** — `exists_residue11` (U4–U6), `exists_invariantColouring` (L1), `posDef_corr` (L2's input).
Log: `data/fs100/x11k/sqrt47.log` (exit 0, three `sorry` warnings).

**Re-price from the leaves closed** (§ What compute helps): the stage-1 prices for composition leaves ran **2–3× high** (M priced ~10k,
closed in ~2k; L0 ~5k → ~3k; L6 ~20k → ~15k; L3 ~15k → ~8k), the M2/FS-75 pattern. Revised: `posDef_corr` ~10–15k (shift invariance and a
Gram identity for the tetrahedron); `exists_residue11` ~40–60k (U4's normal form for `fieldOfRadicands {47}` is the bulk; U6's descent is
cleanest in `ℚ_[11]` with `PadicInt.toZMod`, or over `ℚ` with 11-integral rationals); L1 ~100–200k (Markov–Kakutani is not in Mathlib).

**Not moved to `Proofs/`:** the sorry-free declarations (M, L0, the measurability lemmas, the interface) could move as one module now; the
gate (build, `axioms.sh`, `vacuity.sh` counts, `ARCHITECTURE.md`, `scripts/Axioms.lean`) was not run on this job's budget. Price: one
build plus ~20k.

## Stage 5 — the report (the price of the rest)

| layer | nodes | status |
|---|---|---|
| in the kernel (reused) | U1 `chromaticNumber_finitePlane11`, U2 `unitQuadrance_colorable_of_subring`, U3 `chromaticNumber_planeOver_eq`, `sq_add_sq_eq_zero_iff` | kernel |
| proved in the skeleton (Lean, sorry-free) | M, L0, measurability | move to `Proofs/` with the gate, ~20k + a build |
| proved in the skeleton over leaves | U, L3, L6, L, H | follow the leaves |
| skeleton leaves, formalizable now | `posDef_corr` ~10–15k; `exists_residue11` ~40–60k; L1 ~100–200k | **U is unconditional after ~60k** |
| named hypotheses: the project's lemmas in interface form | R-U, A⁺ at `S = ∅`, PE-2, EF_F⁺ | to be discharged for the true `E`, `T + A`, `h`: needs N1's adelic dual (months), N2/SI (after X-ST), R88-TCA (row 112's inputs, months), entropy theory |
| named hypothesis, external classical | X-BH (Herglotz–Bochner) | weeks: Riesz–Markov–Kakutani is in Mathlib, compactness of the dual and Stone–Weierstrass on it are not |
| external, not yet statable here | X-EL (EL2021 Thm 1.2), X-SMB, X-ED, X-JAC, X-ST, X-AMB, X-WEIL, X-APP | Kolmogorov–Sinai entropy absent from Mathlib (a community project claims it: unread, §PA); each a formalization project |

**Proposed for the front page** (the front-page lane decides): a `LEDGER.md` § B line for the [hand] Dirichlet sharpening of Lemma W at
ℚ(√47); a stub for the kernel lane's next slot (the three leaves, then the gate for U, then the entropy decision); a `BIBLIOGRAPHY.md`
candidate row for Rudin, *Fourier Analysis on Groups* (1.3.6, 1.4.3; not held here, cited by statement for X-BH).
