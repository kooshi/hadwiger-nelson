# FS131-KCL1 — the collapse at the kernel: row 128's measure rigidity against `MRPlus`, and the module that would say `χ(ℚ(√635087)²) = χ(ℝ²)`

*Planner's record (de Bruijn, the kernel lane's planner, on Opus). Brief: `data/fs131/briefs/FS131-KCL1-collapse.md` (on `main` at
`4cd2cd0cc`). Worktree `.claude/worktrees/kcl1`, branch `fs131-kcl1`, cut from `main` at `16a2d4499`. Scripts and outputs under
`data/fs131/kcl1/`. Nothing here is blind: the brief fences nothing.*

## Theorems this phase proved

A planning job; it proves no theorem of the library. Two scratch theorems were checked by `lake env lean` (iteration only, never
evidence that a module is green), both at stage 2:

- `KCL1Scratch.not_isSPWitness_of_mrPlus` — `MRPlus F` excludes every SP witness at every `E ⊇ T + A` — [kernel, scratch;
  standard three axioms] — `data/fs131/kcl1/lean/Stage2.lean`.
- `KCL1Scratch.mrLiteral_of_mrPlus` — `MRPlus F` gives row 120's literal MR (a multiple of Haar measure) at every `E ⊇ T + A` —
  [kernel, scratch; standard three axioms] — same file. With the library's `Rigidity.mrPlus`, both hold at every real number field
  on the standard three and `Rigidity.positive_entropy_rigidity` (`not_isSPWitness`, `mrLiteral`).

## Stage 1 — SAVED: the readback

**Every quotation of the brief, against its source.** `data/fs131/kcl1/quote_check.py` reads each run of `> ` lines that ends in a
`> — source: <path>` line and looks for it, verbatim, in that file. All eight are verbatim, in the main tree and in this worktree
(`data/fs131/kcl1/quote_check.out`): W2 and the W6 sentence (`data/fs131/REQUEST-2026-10-13.md` l. 4 and l. 28 — the second is under
the label W6, as the brief says), inventory item 951 (`plans/FS131-close-inventory.md`), rows 128 and 120 (`LEDGER.md`), `MRPlus`
(`Rigidity/ChainAtTA.lean`), `mrPlus` (`Rigidity/ZeroEntropyClosed.lean`) and `chromaticNumber_plane_eq_chiM0`
(`Outside/OAI158Collapse.lean`). Control: with one letter of the first quotation changed (`--plant`), the script reports it NOT FOUND
with the first differing position and exits 1. **No mismatch.**

**The result, in my words.** Row 128 says: take a totally real number field `F` such that at every conjugation-stable place, at
every level, every non-trivial additive character averages to less than `1/5` in modulus over the norm-one residues (6-thick, both
signs). Assume measure rigidity for `F` (MR(F)). Then the unit-distance graph on `F²` needs exactly as many colours as the one on
`ℝ²` (and as many as a translation-invariant random colouring continuous in probability, `χ_CP`). The instances are ℚ(√635087) and
de Grey's field. The one step that carries the weight needs no MR: a proper `k`-colouring of `F²` (`k ≥ 2`, every stable place
`k`-thick) gives either a CP `k`-colouring of the plane or a *spectral witness* — a finite, rotation-invariant, `E`-null measure on
the characters of `R = ℤ[U]` whose integral of `Re χ(1)` is negative. MR forbids the witness. Grade: [hand + tools exact]; the
step two blind derivations and two held; MR at row 120's grade.

**The hypothesis it is given.** MR(F), row 120: for a real number field with `R_F = O′`, every rotation-invariant finite positive
measure on `R̂` that gives `E` measure `0` is a multiple of Haar measure. `E` is J45's union `⋃_S (T + A + Fin_S)` over finite sets
`S` of split places (D-TAE, `data/fs103/claims.md` § 0); its part at `S = ∅` is `T + A`.

**What the library holds.** `Rigidity.MRPlus F`: every finite rotation-invariant measure on `R̂` (the library's `Dual F`, with
the cylinder σ-algebra — the Borel one, `R` being countable) that gives `T + A` (`Rigidity.TA F`) measure `0` has every Fourier
coefficient off `0` equal to `0`. `Rigidity.mrPlus` proves it at **every** real number field, with no scope, on the standard
three axioms and `Rigidity.positive_entropy_rigidity` (`[EinsiedlerLindenstrauss2022]` Thm 1.3). And
`Outside.OAI158.chromaticNumber_plane_eq_chiM0`: `χ(ℝ²) = χ_m⁰(ℝ²)`, on the standard three.

**The forms set side by side.** Three differences, each in MR⁺'s favour:
1. *The null set.* MR⁺ asks `τ(T + A) = 0`; MR asks `τ(E) = 0`. `T + A ⊆ E`, so `τ(E) = 0` implies `τ(T + A) = 0`: MR⁺ applies to
   every measure MR applies to, and more. MR⁺ is the stronger statement.
2. *The conclusion.* MR⁺ concludes in Fourier form; MR says "a multiple of Haar measure". On the compact dual of a countable
   group a finite measure is fixed by its coefficients (`Rigidity.measure_eq_of_fourier`), and Haar measure's coefficients vanish
   off `0` (`Rigidity.isHaarFourier_dualHaar`): the two conclusions are equivalent. Stage 2 proves MR⁺ ⟹ MR(F) literally.
3. *The scope.* Row 120 states MR for `R_F = O′` only and does not claim it at row 100's exception; the kernel's `mrPlus` has no
   scope (its scope binder was read by no step and dropped, FS131-IJN1). Row 120's grade and its "Not claimed" line predate the
   kernel: this is the correction FS131-PR1 already drafted ("row 120's grade", inventory item 951), seen again here, not a new one.

## Stage 2 — SAVED: the answer

**Answer: yes.** Row 128's derivation uses MR at exactly one step — to exclude the spectral witness (case (B) of the load-bearing
step) — and `MRPlus F` implies what that step uses, at every set `E ⊇ T + A`, in a few lines checked by `lake env lean`. With the
library's `mrPlus`, MR is discharged at every real number field on `[EinsiedlerLindenstrauss2022]` Thm 1.3. What stands between
row 128 and the kernel is not MR: it is the load-bearing step itself (FS103-LB and its selection FS103-SEL, [hand]) and the
thickness of ℚ(√635087)'s stable places — named below with their kernel routes.

### 2.1 Every use of MR in the derivation

The filed theorem's proof, `plans/FS103-derivation.md` l. 42 (FS103-F1):

> `χ(F²) ≤ χ(ℝ²) ≤ χ_CP(ℝ²)` (FS103-CPUP); if `χ(F²) = k ≤ 6`, every stable place is `k`-thick (`1/(k−1) ≥ 1/5`), FS103-LB gives a CP `k`-colouring or an SP witness, and MR excludes the witness; if `χ(F²) = 7`, `χ_CP ≤ 7`.
> — source: plans/FS103-derivation.md

The first blind derivation, at the end of Theorem V1-LB, `plans/FS103-V1-verification.md` ll. 176–177:

> **Given MR(F): (B) is impossible** (`τ = a·Haar` and `∫ χ(1) dHaar = 0`, `χ ↦ χ(1)` being a non-trivial character of the compact group
> `R̂` since `1 ≠ 0` in `R`), so `k`-colourability of `F²` gives (A).
> — source: plans/FS103-V1-verification.md

The second, its assembly C-635-F1, `plans/FS103-V2-verification.md` ll. 180–182:

> - **C-635-F1: TRUE given MR(ℚ(√635087))** (the field is outside row 100's exception, §2.1). Let `k = χ(F²) ≤ 7`. C-CPUP:
>   `k ≤ χ(ℝ²) ≤ χ_CP(ℝ²) ≤ 7` (I-CP57). If `k ≤ 6`: `N_k = ∅`, C-LB gives (A) or (B); (B) is a non-Haar `U`-invariant `E`-null measure
>   (`∫ χ(1) d(Haar) = 0`), excluded by MR; so `χ_CP(ℝ²) ≤ k`. If `k = 7`: `χ_CP ≤ 7 = k`. Either way all three are equal.
> — source: plans/FS103-V2-verification.md

V1's own assembly (ll. 221–224) applies "C-LB with MR" twice — at `k = 4`, to get `χ(F²) ≥ 5`, and at `k = χ(F²)` — each time
through the sentence of l. 176. The fractional half of FS-103 (FS103-F-FRAC, F-DV) also uses MR, but it is row 129's, off row 128's
path. **So there is one use, made at one or two values of `k`.**

**The set, the measure and the conclusion.**
- *The set* is `E`, by the claim list's definitions:

> - **D-SP** (BC §1.2): "**SP witness** …: a finite positive `U`-invariant Borel measure `τ` on `R̂` with `τ(E) = 0` and `∫ Re χ(1) dτ < 0`."
> — source: data/fs103/claims.md

  with `E = ⋃_S E_S`, `E_S = T + A + Fin_S` (D-TAE, the same file, l. 41).
- *The measure* is `τ := σ|_{R̂∖(T+A)}`, `σ` the spectral measure of the simplex embedding `g(x) = e_{c(x)}` of an `R ⋊ U`-invariant
  random proper `k`-colouring of `Cay(R, U)` (V1-L0, L1, L3, ll. 90–124; V2 Step 1 and Step 2, ll. 102–122). It is finite,
  positive and rotation-invariant; `τ(E) = σ(E ∖ (T + A)) = 0` **by R-U** — "the one place R-U is used, and it is what makes (B)'s
  witness `E`-null rather than merely `(T + A)`-null" (V1 l. 120).
- *The conclusion* drawn from MR: `τ = a·Haar`, so `∫ χ(1) dτ = 0` (`χ ↦ χ(1)` is a non-trivial character, `1 ≠ 0`), against
  `∫ Re χ(1) dτ < 0`.

### 2.2 The implication, as Lean statements, proved

`data/fs131/kcl1/lean/Stage2.lean`, elaborated by `lake env lean` under the slot (exit 0; `Stage2.out`):

```lean
def IsSPWitness (E : Set (Dual F)) (τ : Measure (Dual F)) : Prop :=
  IsFiniteMeasure τ ∧ RotInv F τ ∧ τ E = 0 ∧ ∫ χ, ((χ 1 : Circle) : ℂ).re ∂τ < 0

def MRLiteral [Countable (unitRing F)] (E : Set (Dual F)) : Prop :=
  ∀ τ : Measure (Dual F), IsFiniteMeasure τ → RotInv F τ → τ E = 0 → τ = τ Set.univ • dualHaar (unitRing F)

theorem not_isSPWitness_of_mrPlus (h : MRPlus F) {E : Set (Dual F)} (hE : TA F ⊆ E) (τ : Measure (Dual F)) :
    ¬ IsSPWitness F E τ
theorem mrLiteral_of_mrPlus [Countable (unitRing F)] (h : MRPlus F) {E : Set (Dual F)} (hE : TA F ⊆ E) :
    MRLiteral F E
theorem not_isSPWitness [NumberField F] {E : Set (Dual F)} (hE : TA F ⊆ E) (τ : Measure (Dual F)) :
    ¬ IsSPWitness F E τ                                   -- := not_isSPWitness_of_mrPlus (mrPlus F) hE τ
```

`#print axioms`: the first two on `[propext, Classical.choice, Quot.sound]`; `not_isSPWitness` and `mrLiteral` on those and
`Rigidity.positive_entropy_rigidity`. Proofs: `τ(T + A) ≤ τ(E) = 0`; MR⁺ at `r = 1` (`one_ne_zero` in the subring); the integral of
the real part is the real part of the integral (`integral_re`, `|χ(1)| = 1` integrable against a finite measure); Fourier
uniqueness for the literal form. **Control** (`Stage2Control.lean`, `.out`): with `hE` dropped, the step `τ(T + A) = 0` is refused
("Type mismatch … `τ E = 0` … expected `τ (TA F) = 0`") — the one place the inclusion is read.

**A shortening on the library's route.** The measure the step builds is `σ|_{R̂∖(T+A)}`, which gives `T + A` measure `0` by its
construction. MR⁺ reads only that, so **R-U leaves the path**: the witness need not be `E`-null, and `E` need not be defined. This
is FS131-EN1's EN1-SPCOR (the five-colour chain's "R-U is `τ(∅) = 0`", `Rigidity.five_le_chromaticNumber_of_mrPlus`) seen at the
collapse — not a new observation, but it removes I-RU (`plans/FS84-SI-D-derivation.md` § 4.1, [hand, two blind]) from row 128's
inputs.

### 2.3 Every other hypothesis on the path that is ours or open

Read from V1 § Stage 2a ("Inputs used") and V2 § 2.3 ("Inputs used"), set against the library. "Off the route" means the kernel
route of § 3 does not read it.

| input | grade | where the derivation uses it | on the kernel route |
|---|---|---|---|
| MR(F) (I-MR, row 120) | [hand] | excluding (B) | **discharged**: `mrPlus` (§ 2.2), on EL Thm 1.3 |
| FS103-LB, the load-bearing step | [hand], two blind + two held | the whole of `χ(ℝ²) ≤ χ(F²)` | **open in the kernel**: its parts L0–L5 have four-colour kernel counterparts (the five-colour chain's modules); `k` colours and the selection are new (§ 3) |
| FS103-SEL, the mixing selection | [hand], two blind | V1-L6, V2-L3 | **open in the kernel** (§ 3); in the format the library reads (`AeColouring`) the random threshold is not needed |
| thickness at ℚ(√635087): every stable place 6-thick, uniformly (FS103-635) | [tools exact + hand] | V1-L7 (`sup_v λ*_v < 1/(k−1)`) | **open in the kernel**, with a finite certificate (below) |
| I-WEIL, level one: `|λ| ≤ 2√q/(q+1)` | classical | V1-L7 | the declared outside theorem `StandingFive.kloosterman_bound` (already on the five-colour chain), through `circle_sum_le_weil` |
| I-WEIL, new levels: `≤ 2/(q+1)` (X26B-L1, row 123) | [hand, two] | V1-L7 | **a kernel theorem**: `Rigidity.newCharBound_of_two_notMem` (Lemma P, `Rigidity/ClassRatio`) |
| I-RU (J45) | [hand, two blind] | V1-L3, V2 Step 2 | **off the route** (§ 2.2) |
| I-C′, `R = O′` (row 100) | [hand, three] | V1-L2 (a), V1-L4, V2 L1 | **off the route**: the library's completion `K F` is *defined* as the closure of `R`'s image; the count "reads neither `R = O′` nor `NoRamifiedStableDyadic`" (`Rigidity/CountResidue`, l. 24) |
| C-CPUP / I-CPUP (row 125), `χ_CP ≤ 7` | [hand, two] | the sandwich | **off the route**: the library's N-EASY `Plane.chromaticNumber_plane_le_chiM0` on an `AeColouring`, and `χ(ℝ²) ≤ 7` (M36) |
| I-MERGE / V1-L8 (the diagonal merge), weak approximation | [hand] / classical | V1-L8, V2 L-WA, L4 | **in the kernel** in another shape: one plane `Δ` in `L ⊗ ℝ`, with `Rigidity.Counting.mem_closure_ιG` and `Delta_circle_mem_closure` (`Rigidity/CountCompletion`, `CountTorus`) |
| the measurable version (Doob–Cohn / V2-MV) | classical / [hand] | V1-L5, V2-L2 | **in the kernel** at four colours: `Rigidity.Counting.exists_extension` (Borel–Cantelli) |
| Herglotz–Bochner; the invariant measure (amenability); Bochner on `τ′_∅`; `contChars = T + A` | classical / [hand] | V1-L0–L2 | **in the kernel**: `bochnerHerglotz_of_countable`, `invariantMeasureOnClosed_of_countable`, `bochnerOn_tauPrime`, `contChars_tauPrime` |
| "totally real" | the claim's scope | V1-L6/L8 (one real factor per real place) | **off the route**: "one plane for every number field, totally real or not" (`Rigidity/CountTorus`, l. 24) — see the generalization below |
| `χ_CP(ℝ²)` itself | — | row 128's third member | **not formalized**: the kernel statement is `χ(F²) = χ(ℝ²)` (`= χ_m⁰(ℝ²)` by the library); `χ_CP = χ_m⁰` is row 130's [hand] |

**How "every stable place 6-thick" is established, over infinitely many places, and with what certificate.**
- *In the derivation:* the stable places below 1000 by PARI (`tools/fs103_v1_checks.py`, `tools/fs103_v2_places.py`; three plants);
  the exact level-one spectrum at 103 (`λ* = 0.192617`); Weil's `2√q/(q+1)` above, decreasing in `q`; new levels `≤ 2/(q+1)` by
  X26B-L1; no stable dyadic place (2 splits in `L/F`). Tools-grade lists with hand reasoning for the infinite tail.
- *For the kernel, a finite certificate and two theorems.* Weil's bound alone suffices — `2√103/104 = 0.19517… < 1/5` — so the exact
  spectrum at 103 is not needed. What must be shown is **every stable prime `P` of `L = F(i)` lies over a prime `p ≥ 103`**. It is a
  single elementary lemma applied 26 times: *if `x ∈ 𝓞_L` has `x x̄ ∈ pℤ` and `x + x̄ ∉ pℤ`, no stable prime lies over `p`* (a stable
  `P ∋ x x̄` holds `x` or `x̄`, hence both, hence `x + x̄ ∈ P ∩ ℤ = pℤ`). Witnesses, checked by exact arithmetic (stage 4's tool):
  `p = 2`: `x = (1 + i√635087)/2`, `x x̄ = 158772`, `x + x̄ = 1`; `p ≡ 1 (mod 4)`, the twelve odd primes `5 … 101`: `x = b + i`
  with `b² ≡ −1`; `p ≡ 3 (mod 4)`, the thirteen primes `3 … 83`: `x = a + i√635087` with `a² ≡ −635087`, `a ≢ 0` — they exist
  because each of these is inert in `F` (`(635087/p) = −1`). Then at `p ≥ 103` the residue field has `Q²` elements, `Q ≥ p ≥ 103`
  (`Rigidity`'s `exists_card_sq`, private in `ClassRatio`), Weil gives `≤ 2√Q/(Q+1) ≤ 0.1952` at level one, and Lemma P gives
  `≤ 2/(Q+1)` above it. No PARI, no floating point, no list of places.

### 2.4 Findings for the coordinator

1. **Generalization (a planner's reading of the library's statements; the `k`-colour route is not built).** On the library's route
   the collapse needs neither "totally real" nor `R = O′`: the slice `Δ × K` carries one plane at every number field
   (`Rigidity/CountTorus`), and the completion is the closure of `R` (`Rigidity/CountCompletion`). So the kernel statement can be
   *every real number field all of whose stable primes are uniformly 6-thick* — FS103-CX's complex-place widening (V2, one mind, "not
   claimed" in row 128) arrives with no extra leaf. A ramified stable dyadic prime has `λ* = 1` and is excluded by thickness itself.
2. **Shortening.** R-U, I-C′, I-CPUP, I-MERGE and the random threshold all leave row 128's path on the kernel route; the exact
   spectrum at 103 is not needed (Weil's bound is below `1/5` there).
3. **No statement defect** in rows 128 or 120 as quoted. Row 120's grade predating the kernel is FS131-PR1's correction, already owed.

## Stage 3 — SAVED: the map

The route the kernel takes is the five-colour chain's (`Rigidity/ChainHeadline`'s modules) run at `k` colours, with the count's
last step (`Rigidity.Counting.false_of_slice`, a density contradiction) replaced by a **mixing selection** that produces a
measurable colouring of the plane, proper at almost every unit pair (`Plane.AeColouring k`), which the library's N-EASY turns into
`χ(ℝ²) ≤ k`. Its spine, for a real number field `F` all of whose stable primes are uniformly `λ`-thick with `λ(k − 1) < 1`:

```
F² k-colourable
 → an invariant random proper k-colouring of Cay(R, U)                         (L0)
 → its colour spectral measure σ = Σ_j σ_{1{c(0)=j}} on R̂, rotation-invariant   (L1)
 → ∫_{R̂∖(T+A)} Re χ(1) dσ = −Σ_j E[p_j(0) p_j(1)] ≤ 0                           (L2, SI-3 at T + A)
 → it is 0, else σ|_{R̂∖(T+A)} is an SP witness, which MR⁺ excludes (stage 2)    (L3)
 → the factor colouring min supp p: an invariant k-colouring with σ on T + A    (L3, SI-4)
 → a measurable colouring φ of the slice Δ × K, monochromatic edges null       (L5)
 → mixing on K at every level, from thickness                                   (L6, L7)
 → the threshold selection: an AeColouring k of ℂ                               (L6)
 → χ(ℝ²) ≤ k                                                                    (N-EASY)
```

and the headline is the sandwich `χ(F²) ≤ χ(ℝ²)` (`chromaticNumber_planeOver_le_plane`), `χ(ℝ²) ≤ 7`
(`chromaticNumber_plane_le_seven`), and the spine at `k = χ(F²)` when `χ(F²) ≤ 6`.

### 3.1 Each step against the library

| step (V1 / V2) | the library holds | missing | lines |
|---|---|---|---|
| **sandwich**: `χ(F²) ≤ χ(ℝ²)` (C-CPUP's second half) | `chromaticNumber_planeOver_le_plane` (`Bridge`) | — | 0 |
| `χ(ℝ²) ≤ 7` (I-CP57's upper half) | `chromaticNumber_plane_le_seven` (`Instances/Seven`) | — | 0 |
| **N-EASY**: an `AeColouring k` gives `χ(ℝ²) ≤ k` (replaces C-CPUP's first half and the CP format) | `Plane.chiM0_le` (`Plane/AeColouring`), `Plane.chromaticNumber_plane_le_chiM0` (`Plane/YesLimit`) | — | 0 |
| **L0** — a proper `k`-colouring of `F²` gives an `R ⋊ U`-invariant random proper `k`-colouring of `Cay(R, U)` (V1-L0; V2 Step 1) | at **four** colours: `SpectralChain.X4`, `InvariantColouring`, `x4_nonempty_of_colorable`, `exists_invariantColouring`; `Rigidity.invariantMeasureOnClosed_of_countable` (`Rigidity/InvariantMeasure`; Markov–Kakutani over a Følner-free fixed point, `OneClass.exists_common_fixed`) | the same at `Fin k`: a copy, `Fin 4 → Fin k` | 300 |
| **L1** — the spectral measure, rotation-invariant (V1-L1) | four colours: `IsTraceSpectral`, `posDef_corr` (tetrahedral), node L3 `rotInv_of_isTraceSpectral`; generic: `Rigidity.exists_isSpectralMeasureOf` (`Rigidity/SpectralSubspace`, over `bochnerHerglotz_of_countable`), `Rigidity.measure_eq_of_fourier` | the **colour spectral measure** `σ := Σ_j σ_{e_j}` (`e_j = 1{c(0) = j}`): it needs no simplex Gram identity — `∫ χ(y) dσ = P(c(0) = c(y))`, mass `1` — and its rotation invariance per colour | 150 |
| **L2** — the `T + A` factor: `Π = E[· | 𝒜]`, and SI-3 (V1-L2 (c), V1-L3's identity; V2 L1 (d)–(e), Step 2) | generic: `Rigidity.isSpectralMeasureOf_condExpL2` (spectral measure of `E[f | 𝒜_t]` is `σ_f` on the `t`-continuous characters), `Rigidity.contChars_tauPrime : contChars (tauPrime F) = TA F`, `bochnerOn_tauPrime`, `measurableSet_TA`, `rot_preimage_TA`; four colours: `Rigidity.colourFactor`, `setIntegral_compl_TA_re`, `setIntegral_compl_TA_rot`, `trace_decomp` (`Rigidity/TraceSplit`) | `TraceSplit` at `Fin k`, on `σ = Σ_j σ_{e_j}` (its own route already reads colour indicators, "not tetrahedral coordinates": the constants `3, 4` disappear) | 250 |
| **L3** — the dichotomy; (B) excluded by MR; the factor colouring (V1-L3; V2 Step 2, SI-4) | stage 2's `not_isSPWitness` (scratch, to be placed); four colours: `SpectralInputs.condLaw`, `condSupport`, `si4`, `si4_equivariant` (`Arith/SpectralInputs` ll. 1040–1269), `Rigidity.factorColouring`, `factorLaw`, `factorLaw_trace_null`, `integral_condLaw_mul_eq_zero_of_adj`, `comap_colourRot_colourFactor` (`Rigidity/APlus`) | SI-4's block and `APlus`'s factor at `Fin k` (copies); the assembly: an invariant `k`-colouring has a sibling whose colour spectrum is carried by `T + A` | 550 |
| **L4** — density of `R` in the completion (V1-L4; V2 L1 (b)) | `Rigidity.Counting.denseRange_ιG`; the completion is *defined* as the closure (`Kgrp`, `K`) — I-C′ not read | — | 0 |
| **L5** — extension to the completion, the measurable version, the slice (V1-L5, V1-L8; V2 L2, L-WA, L4) | four colours: `Rigidity.Counting.tendsto_measure_ne`, `exists_extension` (Borel–Cantelli, no Doob–Cohn), `SliceEdgeNull`, `exists_slice` (`Rigidity/CountExtension`); generic: `mem_closure_ιG` (the edges in the closure), `Delta`, `Delta_circle_mem_closure` (`Rigidity/CountTorus`: one plane at every number field) | `CountExtension` at `Fin k`; `measure_ne_eq` becomes `P(c(0) ≠ c(y)) = 1 − Re ∫ χ(y) dσ` with the colour spectral measure | 350 |
| **L7** — thickness is uniform, at every level (V1-L7; V2 Step 0, V2-NL) | `Rigidity.henselCount_of_two_notMem`, `newCharBound_of_two_notMem` (Lemma P, public); level one, one-sided only: `charBound_one_weil` (private), from `StandingFive.normOne_charSum_ge` (`Arith/FloorPlanes`, one-sided), whose proof holds the two-sided `‖Σ‖ ≤ 2√Q` one line before its end; the descent `norm_charSum_le_of_resT` (private, two-sided) | **two-sided** level-one and all-level bounds: a drafted edit to `FloorPlanes` (split off `norm_normOne_charSum_le`, ~10 lines) and to `ClassRatio` (a public `norm_charSum_le_of_weil`, ~130 lines) — or a copy in the new module (~350) | 140 (edits) / 350 (copy) |
| **L7′** — from primes to the levels of `K`: `[S9]`, the product, characters of the level group | `Rigidity.Counting.level`, `Lev`, `levR`, `normOneLev`, `image_levR_unitVectors` (stated over `TCA F`, reading only "no stable prime ramified"), `exists_normOneL_residues`, `range_proj` | `[S9]` over "no ramified stable prime" (30); `not_isRamified_of_thick` (40); a character of a product sums over a product set as the product of the sums (80); a character of a subgroup of a finite abelian group extends (60) | 210 |
| **L6** — the mixing inequality on `K` | `Rigidity.Counting.haarK`, `haarK_proj_preimage` (cosets of level `k` have measure `1/|level-k image|`), `tendsto_haarK_bad` (density along cosets); `RatioBound`'s Fourier technique on a finite abelian group (`fourier_sq_mul_charSum`, `sum_fourier_sq`; one-sided, sets) | the finite-group mixing inequality, two-sided, for `[0, 1]`-valued functions (200); the level decomposition on `K` (cross terms vanish, Cauchy–Schwarz) (150); `‖1_A − E_k 1_A‖₂ → 0` from `tendsto_haarK_bad` (100); assembly (80) | 530 |
| **L6′** — the threshold selection: an `AeColouring k` from the slice (V1-L6; V2 L3; FS103-SEL) | `Plane.AeColouring`, `UnitPairsNull`, `unitPairSet`, `arcLength`, `e` (`Plane/UnitPairs`, `Plane/Basic`) | fibre masses measurable (60); Tonelli on the slice's null edges (120); the pigeonhole and the threshold (60) — **no random threshold**: the `AeColouring` format asks properness almost everywhere and measurability, not continuity in probability | 240 |
| **thickness at ℚ(√635087)** (FS103-635; C-635-THK) | `Rigidity.two_notMem_of_isSquare` (no stable prime above 2 when a square `d ≡ 7 (mod 8)` is in `F`), `Rigidity.stablePrime_card_of_two_notMem` (a stable prime not above 2 lies over `p ≡ 3 (mod 4)`, residue size `(pⁿ)²`, and every square of `F` is a square mod `p`) (`Rigidity/SqrtClassFive`); `SquareClass.fieldOfRadicands`, its `NumberField` instance | a `decide` that `635087` is a non-square modulo each of the 13 primes `p ≡ 3 (mod 4)` below 103, and `2√Q/(Q + 1) ≤ 2√103/104 < 1/5` for `Q ≥ 103` | 60 |
| **the headline**, general and at the instance | — | `chromaticNumber_plane_le_of_thick` (each `k`); `chromaticNumber_planeOver_eq_plane_of_thick`; the instance | 100 |
| **de Grey's field** (FS103-DG) | the same two `SqrtClassFive` lemmas (`d = 7`), `fieldOfRadicands {3, 5, 7, 11}` | a `decide` that no prime `p ≡ 3 (mod 4)` below 131 has 3, 5, 7 and 11 all squares mod `p` (the 3, 7, 11 themselves included); `2√131/132 < 1/5` | 60 |

**Total: about 3,000 lines of Lean** (2,980 with the two drafted edits; 3,190 with the copy route), of which about 1,600 are copies
of landed four-colour proofs with `Fin 4` replaced by `Fin k` and the tetrahedral constants removed, about 1,000 are new
mathematics in Lean (thickness to levels, the two mixing inequalities, the selection), and about 400 are assembly and instances.
Re-price from the first two leaves (`LEAN.md` § The kernel's cost model): the copies are the likeliest to come in under, the
selection's Fubini step over `((ℂ × K) × ℝ)` the likeliest over.

**What the result will rest on**: the standard three axioms, `Rigidity.positive_entropy_rigidity` (through `mrPlus`) and
`StandingFive.kloosterman_bound` (through thickness) — the five-colour chain's two declared outside theorems, and no hypothesis.

### 3.2 Decisions the map rests on

1. **New parallel modules over `Fin k`, not the landed four-colour modules generalized in place.** Generalizing in place would move
   the stored statements of the five-colour chain's landed theorems (`InvariantColouring F` would take `k`), and its landing's
   statement dumps, audit blocks and read-backs would all be redone. The cost is about 1,600 lines that are the four-colour proofs
   at `k`. The debt is named (§ 4's domain pass): the true model is the `k`-colour one, of which the four-colour chain is an
   instance; re-deriving the chain from it is a later refactor, not this job's.
2. **The colour spectral measure `Σ_j σ_{e_j}`, not the simplex trace measure.** The derivation's spectral measure is "that of the
   simplex embedding" (D-TAE); the library's `TraceSplit` already routes through colour indicators. Taking `σ := Σ_j σ_{e_j}` drops
   the Gram identity, the `posDef` proof and every `k/(k − 1)`: `∫ χ(y) dσ = P(c(0) = c(y))`, `σ(R̂) = 1`, and off `T + A`
   `σ = Σ_j σ_{e_j − Πe_j}`. The SP witness is `σ|_{R̂∖(T+A)}` exactly as in V1-L3.
3. **The finite-level route to mixing on `K`, not Fourier analysis on `K`.** `K` is the closure of `R` in `∏_k Lev F k`; its
   characters are never named. At level `k` the conditional expectation onto the level's cosets commutes with every translation, so
   the edge integral splits into a finite-group term (the level group, connection set the image of `U`, Fourier there) and a
   remainder bounded by `‖1_A − E_k 1_A‖₂ ‖1_B − E_k 1_B‖₂`, which `tendsto_haarK_bad` sends to `0`. No Haar measure on the
   norm-one torus, no Parseval on a profinite group, no weak approximation beyond `mem_closure_ιG`.
4. **A fixed threshold.** V1-L6 and V2-L3 draw the threshold at random to keep continuity in probability (the CP format). The
   library's number is `χ_m⁰`, whose colourings need properness almost everywhere and measurability only; any fixed
   `θ ∈ (λ/(1 + λ), 1/k)` works.
