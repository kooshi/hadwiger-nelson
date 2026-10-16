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

## Stage 4 — SAVED: the skeleton and the plan

### 4.1 The target, read back aloud against row 128

```lean
theorem Collapse.chromaticNumber_planeOver_sqrt635087 :
    ((unitDistance ℂ).induce (planeOver F635087)).chromaticNumber = (unitDistance ℂ).chromaticNumber
-- F635087 := SquareClass.fieldOfRadicands {635087}
```

*Read aloud:* the unit-distance graph of `ℂ` induced on the points with both coordinates in `ℚ(√635087)` — `F²`'s graph,
`planeOver F` being `F + F·i` — has the same chromatic number, in `ℕ∞` (`SimpleGraph.chromaticNumber`), as the unit-distance
graph of the whole of `ℂ ≅ ℝ²`. Against row 128: its first member, `χ(F²) = χ(ℝ²)`, at its first instance, **with no MR
hypothesis** (MR is `Rigidity.mrPlus`, on `[EinsiedlerLindenstrauss2022]` Thm 1.3) and no hypothesis of ours. Not stated:
row 128's third member `χ_CP(ℝ²)` (not defined in the library; `χ(ℝ²) = χ_m⁰(ℝ²)` is `Outside.OAI158.chromaticNumber_plane_eq_chiM0`,
and row 130's `χ_CP = χ_m⁰` is [hand]). The general form, `chromaticNumber_planeOver_eq_plane_of_thick` — every real number field
whose stable primes are uniformly `c`-thick with `c < 1/5` — is **wider than row 128**: no "totally real", no MR hypothesis
(§ 2.4, finding 1); `chromaticNumber_planeOver_eq_plane_of_forall_thickAt` states it in row 128's per-place words. The mutation
audit of the statement: with `c < 1/4` (5-thick) in place of `c < 1/5` the general theorem would claim what V1 shows unproved
(`χ(F²) = 6 < χ_CP = 7` not excluded) — the proof needs `5c < 1` at `k = 6`, so the hypothesis is load-bearing.

### 4.2 The skeleton

Seven modules under `Proofs/HadwigerNelson/Collapse/`, namespace `HadwigerNelson.Collapse`, imported by `Proofs.lean`; built
through `./scripts/build.sh` under the slot (`data/fs131/kcl1/build1.log`; § 4.6). Every leaf is a `sorry`; every assembly is
proved, so the composition is checked now: `exists_invColouring_TA` (the dichotomy closed by MR⁺), `exists_slice_of_colorable`,
`mixing_K` (the limit over levels), `exists_aeColouring_of_slice` (the threshold arithmetic), `chromaticNumber_plane_le_of_thick`,
`chromaticNumber_planeOver_eq_plane_of_forall_thickAt`, `stablePrime_sqrt635087`, `thick_sqrt635087`,
`chromaticNumber_planeOver_sqrt635087`, the de Grey chain and the six-or-seven corollary. Stage 2's two theorems are placed,
proved, in `Collapse/Dichotomy` (`IsSPWitness`, `not_isSPWitness_of_mrPlus`, `not_isSPWitness`; `MRLiteral` stays in the scratch
file — no consumer reads it).

| module | imports (beyond the line) | what it states | leaves |
|---|---|---|---|
| `Collapse/Thick` | `Rigidity/CountCompletion` | `ThickAt`, `Thick`, `thickAt_weil`, `thick_of_card`, `thick_of_forall_thickAt`, `not_isRamified_of_thickAt`, `exists_addChar_extend`, `norm_sum_piFinset_le`, `image_levR_unitVectors_of_unramified`, `LevImg`, `levU`, `levelThick` | 10 |
| `Collapse/Colouring` | `Rigidity/APlus` | `Xk`, `InvColouring`, `xk_nonempty_of_colorable`, `exists_invColouring`, models | 6 |
| `Collapse/Dichotomy` | `Collapse/Colouring`, `Rigidity/ZeroEntropyClosed` | the SP witness and MR⁺ (proved); `IsColourSpectral`, `condLawK`, `factorK`; SI-3 at `T + A`; `exists_factorLawK`; `exists_invColouring_TA` (proved over its leaves) | 8 |
| `Collapse/Slice` | `Collapse/Dichotomy`, `Rigidity/CountExtension` | `measure_ne_eq_k`, `tendsto_measure_ne_k`, `exists_extension_k`, `SliceEdgeNullK`, `exists_slice_k`, `exists_slice_of_colorable` (proved) | 4 |
| `Collapse/Mixing` | `Collapse/Thick`, `Arith/RatioBound` | `finite_mixing`, `levelFill`, `levelResid`, `tendsto_levelResid`, `mixing_at_level`, `mixing_K` (proved), `not_both_ge_of_mixing` | 4 |
| `Collapse/Selection` | `Collapse/Slice`, `Collapse/Mixing`, `Plane/AeColouring` | `fibreMass`, `ae_slice_edge`, `not_both_heavy`, `selCol`, `unitPairsNull_selCol`, `exists_aeColouring_of_slice` (proved) | 8 |
| `Collapse/Headline` | `Collapse/Selection`, `Plane/YesLimit`, `Bridge`, `Reduction`, `Rigidity/SqrtClassFive`, `Outside/OAI158` | the general theorems; ℚ(√635087); de Grey's field; `not_thick_bot`; the six-or-seven corollary | 8 |

**Validation at the skeleton.** Spec examples per module (the `## Spec` sections: `Thick` against `ThickAt`; `Xk F 1 = ∅`;
the shift; D-SP's four clauses; the threshold arithmetic at `c = θ = 1/5`; the constant slice's fibre mass; `635087` prime,
`≡ 7 (mod 8)`, a non-square modulo 3 and 7 and a square modulo 103 — the last three by `decide`). **Models of the hypotheses**:
`InvColouring ⊥ 2` (`nonempty_invColouring_bot`, proved over its leaves); `Thick` at `c < 1/5` at ℚ(√635087) and de Grey's field
(`thick_sqrt635087`, `thick_deGrey`, proved over leaves); **adversaries**: `Xk_one_eq_empty`, `not_thick_bot` (ℚ), and the ℚ(√11)
control in `Collapse/Selection`'s docstring. Every library and Mathlib lemma this plan cites is confirmed by `#check` at the pin
under the modules' imports (`data/fs131/kcl1/lean/Checks.lean`, 46 names, exit 0).

### 4.3 The plan, per leaf

Each leaf: route; what it reads; named children the implementer may add as private lemmas; what is hard. "Copy" means the
four-colour proof with `Fin 4 → Fin k`, the module's own names, and the tetrahedral constants gone.

**`Collapse/Thick`**
- `thickAt_one` — `|ψ s| = 1` on a finite group (`ψ s ^ |G| = 1`), then `norm_sum_le` and the card. 15 lines.
- `thickAt_weil` — **the two-sided Weil bound at every level.** Level one: `StandingFive.circle_sum_le_weil` through the
  identification of the norm-one set of `𝓞 ⧸ P ≅ 𝔽_{Q²}` with the circle (the body of `Rigidity`'s private `charBound_one_weil`,
  which runs through `StandingFive.normOne_charSum_ge` — one-sided only because its last line takes `neg_le_of_abs_le`). Higher
  levels: the private two-sided descent `norm_charSum_le_of_resT` and the induction of `charBound_of_charBound_oneT` with norms;
  `henselCount_of_two_notMem`, `newCharBound_of_two_notMem` public. **Two routes**: (a) the drafted edits D-E1, D-E2 (§ 4.5): ~140
  lines in `Arith/FloorPlanes` and `Rigidity/ClassRatio`, then this leaf is a few lines; (b) a copy of the private chain here,
  ~350 lines. Recommend (a). Hard: none — the mathematics is in the library.
- `weil_const_anti` — `2√x/(x + 1)` decreases for `x ≥ 1` (`√x(√B + ...)`; square both sides: `B(Q+1)² ≥ Q(B+1)²` ⟺
  `(Q − B)(QB − 1) ≥ 0`). 25 lines.
- `thick_of_forall_thickAt` — case `c₀ ≤ 0`: a stable prime would be `c`-thick with `c < 0`, false at level one (`1` is of norm
  one and `𝓞 ⧸ P` has a non-trivial character), so there is none and `Thick` is vacuous at `c₀ − 1`. Case `c₀ > 0`: Weil gives
  `ThickAt P (2√Q/(Q + 1))` at every non-dyadic `P`, below `c₀/2` once `Q ≥ Q₀`; the rest — dyadic primes and `Q < Q₀` — have
  absolute norm at most `max(2^{[L:ℚ]}, Q₀²)`, finitely many (`Ideal.finite_setOf_absNorm_le`); take the `max` of their `c_P` and
  `c₀/2`. 80 lines. Hard: bookkeeping only.
- `not_isRamified_of_thickAt` — at a ramified `P`, `𝓞 ⧸ P` has characteristic 2 (`IsRamified.isDyadic`) and conjugation is the
  identity on it, so `normOneQ P 1 = {x : x² = 1} = {1}`; `AddChar.exists_apply_ne_zero` at `1 ≠ 0` gives `ψ` with `ψ 1 ≠ 1`,
  and `‖ψ 1‖ = 1 > c`. 40 lines.
- `exists_addChar_extend` — restriction `AddChar G ℂ → AddChar H ℂ` is a hom; its kernel is the characters trivial on `H`,
  equivalent to `AddChar (G ⧸ H) ℂ`; `AddChar.card_eq` thrice and Lagrange give surjectivity. 60 lines. Hard: the quotient's
  dual as a type.
- `norm_sum_piFinset_le` — `ψ s = ∏_i ψ (Pi.single i (s i))` (additivity over `Finset.univ_sum_single`), so
  `Σ_{piFinset} ψ = ∏_i Σ_{S i} ψ_i` (`Finset.prod_univ_sum`); some `ψ_i ≠ 1`; the other factors are at most `|S i|`. 80 lines.
- `image_levR_unitVectors_of_unramified` — `Rigidity.Counting.image_levR_unitVectors`'s proof with `ratio_unramified_of_tca h P`
  replaced by `hun P`. 30 lines (a copy; or drafted edit D-E3 weakens the landed lemma's hypothesis — not recommended, it moves a
  stored statement).
- `levelThick` — extend `ψ` to `Lev F k` (`exists_addChar_extend`); `levU` is the image of `normOneLev` (`[S9]` with
  `not_isRamified_of_thickAt`), a product set; `norm_sum_piFinset_le` with `ThickAt P c` at `m = k` for `P ∈ level F k`. 60
  lines. Hard: the coercions between `LevImg F k`, `Lev F k` and `Fintype.piFinset`.
- `levU_nonempty` — `levR F k 1 = 1` and `1 ∈ normOneLev`. 10 lines.

**`Collapse/Colouring`** (copies of `SpectralChain` ll. 200–400 and `Rigidity/InvariantMeasure`): `xk_nonempty_of_colorable`
(`x4_nonempty_of_colorable`, 15), `isClosed_Xk`, `measurableSet_Xk` (`X4_eq_iInter`, `setOf_pair_eq` at `Fin k`, 40),
`rot_mem_Xk` (15), `exists_invColouring` (`InvariantMeasure` at `Fin k`: `exists_shiftInvariant_on`,
`exists_rotInvariant_of_shiftInvariant`, `OneClass.exists_common_fixed`; 180), `Xk_one_eq_empty` (`0, 1` adjacent; 10). 260 lines.

**`Collapse/Dichotomy`**
- `exists_isColourSpectral` — `Rigidity.exists_isSpectralMeasureOf` for each `e_j = indicatorConstLp` (`colourShiftK`,
  `colourShiftK_add`), `σ := Σ_j σ_j`; the coefficient is `Σ_j P(c(0) = j = c(y)) = P(c(0) = c(y))` (TraceSplit's
  `integral_colourInd_mul_comp`, copied at `Fin k`). 80 lines.
- `IsColourSpectral.rotInv` — `P(c(0) = c(uy)) = P(c(0) = c(y))` from `rot_inv` (the rotation fixes `0`), then
  `measure_eq_of_fourier` for `σ` and `σ.map (rot u)` (`integral_map`, `measurable_rot`). 60 lines.
- `IsColourSpectral.integral_unit` — `μ (Xk)ᶜ = 0` and `c 0 ≠ c u` on `Xk`. 15 lines.
- `setIntegral_compl_TA_re_k`, `integral_condLawK_mul_nonneg`, `setIntegral_compl_TA_rot_k`, `equalAtUnitsK_of_not_neg` — copies of
  `TraceSplit`'s `setIntegral_compl_TA_re`, `integral_condLaw_mul_nonneg`, `setIntegral_compl_TA_rot` and `APlus`'s
  `equalAtUnits_of_not_neg`, each simpler: the decomposition is `σ = Σ_j σ_{e_j}` itself, no `3σ + δ₁ = 4Σσ_j`. Reads
  `isSpectralMeasureOf_condExpL2` at `tauPrime F` with `contChars_tauPrime`, `bochnerOn_tauPrime`, `isTopologicalAddGroup_tauPrime`,
  `isCountablyGenerated_nhds_tauPrime`. 230 lines.
- `exists_factorLawK` — SI-4 at `Fin k` (copy of `SpectralInputs` ll. 1036–1269: `condSupport`, `measurable_selection`,
  `ae_mem_condSupport`, `si4`, `si4_equivariant`; 230) and `APlus`'s factor (`minSel` with a default from `k ≠ 0` — a probability
  on `R → Fin 0` cannot exist; `factorColouring`, `comap_colourRot_colourFactor`, `factorLaw*`, `factorLaw_trace_null`; 300).
  530 lines. Hard: the equivariance clause and `factorLaw_trace_null` (the `𝒜`-measurable indicators' spectra on `T + A`,
  `spectral_carried_iff`).

**`Collapse/Slice`** — copies of `Rigidity/CountExtension` at `Fin k`: `measure_ne_eq_k` (now `P(c(0) ≠ c(y)) = 1 − Re ∫ χ(y) dσ`:
the coefficient is `P(c(0) = c(y))` and `σ(R̂) = 1`; 30), `tendsto_measure_ne_k` (dominated convergence; 60),
`exists_extension_k` (Borel–Cantelli; 150), `exists_slice_k` (Tonelli over the sample; 90). 330 lines. Hard: none new.

**`Collapse/Mixing`**
- `finite_mixing` — write `f = a + f₀`, `g = b + g₀` (`f₀`, `g₀` mean zero); `Σ_x f(x) Σ_s g(x + s) = |G||S|ab + Σ_x f₀(x)
  Σ_s g₀(x + s)` (cross terms vanish: `Σ_x g₀(x + s) = 0`); expand `g₀` in characters (`AddChar.sum_apply_eq_ite` orthogonality,
  as `RatioBound.fourier_sq_mul_charSum`), so the last sum is `|G| Σ_{ψ ≠ 1} \overline{f̂₀(ψ)} ĝ₀(ψ) λ_ψ` with `|λ_ψ| ≤ c|S|`;
  Cauchy–Schwarz over `ψ` and Parseval (`RatioBound.sum_fourier_sq` generalised from indicators to functions) bound it by
  `c|S||G| ‖f₀‖‖g₀‖`, and `‖f₀‖² = E f² − a² ≤ a − a²` (`f ≤ 1`). 200 lines. Hard: Parseval for real functions — RatioBound
  has it for finset indicators only.
- `tendsto_levelResid` — `levelFill A k` is constant on level-`k` cosets with mean `Haar(A ∩ coset)/Haar(coset)`; the residual
  is `∫_A (1 − fill)² + ∫_{Aᶜ} fill² ≤ ∫_A (1 − fill) + ∫_{Aᶜ} fill = 2∫_A (1 − fill)` (the coset averages agree); on `A` the
  integrand is at most `1` on `{fill ≤ 1 − κ}` and at most `κ` elsewhere: `≤ 2(Haar(bad_k) + κ)` with
  `Rigidity.Counting.tendsto_haarK_bad`; `κ → 0`. 100 lines. Hard: measurability of `levelFill` (it factors through the finite
  `proj F k`).
- `mixing_at_level` — children: (i) `levelFill` factors as `α ∘ proj F k` with `α g = |G|·Haar(A ∩ proj⁻¹{g})`
  (`haarK_proj_preimage`); (ii) for `t ∈ K`, `∫ fill_A(x)·r_B(x + t) = 0` (`r_B = 1_B − fill_B` integrates to `0` on each coset,
  and `x ↦ x + t` permutes cosets, `haarK` translation invariant); (iii) `∫ fill_A(x) fill_B(x + t) = |G|⁻¹ Σ_g α(g) β(g + proj t)`;
  (iv) `|∫ r_A(x) r_B(x + t)| ≤ √resA √resB` (Cauchy–Schwarz, `integral_mul_le_Lp_mul_Lq` at `p = q = 2`, translation
  invariance); (v) each `s ∈ levU F k` is `proj F k (ιK F u)` for some `u ∈ U` (`image_levR_unitVectors_of_unramified`,
  `proj_ιK`). Then average the null edge integrals over representatives and apply `finite_mixing` on `LevImg F k` with
  `levelThick`. 230 lines. **The hardest leaf of the job.**
- `not_both_ge_of_mixing` — `a, b ≥ θ > c/(1 + c)` gives `ab > c√(a(1−a)b(1−b))`: if `a = 1` or `b = 1` the right side is `0`;
  else `√(ab/((1−a)(1−b))) ≥ θ/(1−θ) > c`. 40 lines (`nlinarith` on squared forms, per `LEAN.md`'s advice: small lemmas).

**`Collapse/Selection`**
- `measurable_fibreMass` — `measurable_measure_prodMk_left` on `φ ⁻¹' {j}`, then `ENNReal.measurable_toReal`. 15 lines.
- `sum_fibreMass` — the fibres partition `K`; `measure_biUnion_finset`, `haarK` a probability. 25 lines.
- `ae_slice_edge` — per `u`: the set is measurable; transport `((ℂ × K) × ℝ)` to `((ℂ × ℝ) × K)` by
  `MeasurableEquiv.prodAssoc` and `prodComm` (measure-preserving for the product measures), `Measure.measure_prod_null`; then
  `ae_all_iff` over the countable `unitVectorsR F`. 120 lines. Hard: the measure-preserving reorder of three factors.
- `not_both_heavy` — `mixing_K` at `A = {x | φ(z, x) = j}`, `B = {x | φ(w, x) = j}`: `A ∩ (· + ιK u)⁻¹' B` lies in the null set;
  `not_both_ge_of_mixing`. 30 lines.
- `le_fibreMass_selCol` — pigeonhole: some `j` has mass `≥ 1/k > θ₀` (`Finset.exists_le_of_sum_le` with `sum_fibreMass`), so the
  filter is non-empty and `min'` is in it. 30 lines.
- `measurable_selCol` — each fibre `selCol⁻¹{j} = {θ₀ ≤ m_j} ∩ ⋂_{i < j} {m_i < θ₀}` (or `measurable_to_countable'`). 40 lines.
- `unitPairsNull_selCol` — `unitPairSet` of a class lies in the complement of `ae_slice_edge`'s set (`not_both_heavy` at
  `z = p.1`, `w = p.1 + e p.2`, both heavy by `le_fibreMass_selCol`); `measure_mono_null`. 40 lines.
- the spec example (constant colouring) — `haarK` a probability. 10 lines.

**`Collapse/Headline`**
- `not_colorable_one_planeOver` — `0, 1 ∈ planeOver F` adjacent. 15 lines.
- `chromaticNumber_planeOver_eq_plane_of_thick` — `le_antisymm (Bridge.chromaticNumber_planeOver_le_plane F)`; for `≥`, cases on
  `χ(F²)` in `ℕ∞`: `⊤` trivial; `n ≥ 7` by `Bridge.chromaticNumber_complex_le_seven`; `2 ≤ n ≤ 6` by
  `SimpleGraph.chromaticNumber_le_iff_colorable` and `chromaticNumber_plane_le_of_thick` (`c(n − 1) ≤ 5c < 1`); `n ≤ 1` by
  `not_colorable_one_planeOver`. 50 lines.
- `isSquare_635087`, `isSquare_deGrey` — `SquareClass.sqrt_mem_fieldOfRadicands`, `Real.mul_self_sqrt`. 10 lines each.
- `le_of_isSquare_635087` — `by_contra`, `interval_cases p` below 103, `omega` on `p % 4`, `norm_num` on primality, `decide` on
  `¬ IsSquare (635087 : ZMod p)` at the 13 primes. 30 lines; price the `decide`s (each a search over `ZMod p`, `p ≤ 83`: cheap).
- `le_of_isSquare_deGrey` — the same below 131 with four `IsSquare` facts; 31 primes `≡ 3 (mod 4)` below 131 in all, each refuted
  by one of `3, 5, 7, 11`. 40 lines.
- `weil_103_lt_fifth`, `weil_131_lt_fifth` — `Real.sqrt_lt'` and `norm_num` (`√103 < 10.4`, `√131 < 11.5`). 15 lines each.
- `not_thick_bot` — `UpperHalf.exists_stablePrime_rat` (ramified) and `not_isRamified_of_thickAt`. 10 lines.

### 4.4 The price

| module | lines (route (a)) |
|---|---|
| `Collapse/Thick` | 410 |
| drafted edits D-E1, D-E2 (`FloorPlanes`, `ClassRatio`) | 140 |
| `Collapse/Colouring` | 260 |
| `Collapse/Dichotomy` | 1,000 |
| `Collapse/Slice` | 330 |
| `Collapse/Mixing` | 570 |
| `Collapse/Selection` | 310 |
| `Collapse/Headline` (both fields) | 250 |
| **total** | **about 3,270** |

The stage-3 estimate (3,000) rises by the leaves the skeleton surfaced (`thick_of_forall_thickAt`, `not_thick_bot`, the spec
examples). About 1,600 lines are copies; re-price from the first two leaves of each kind (`LEAN.md`): a copy leaf
(`exists_isColourSpectral`) and a new leaf (`finite_mixing`).

**De Grey's field** costs `isSquare_deGrey`, `le_of_isSquare_deGrey` and `weil_131_lt_fifth` — about 65 lines. What it adds: the
plane over the field of de Grey's coordinates has the plane's chromatic number, so his 1581-vertex graph lives in a field whose
plane is exactly as hard as `ℝ²`; and it discharges row 128's "MR at degree 16 walked at FS-105, one checking reading" — in the
kernel MR⁺ holds at every degree. Recommended: in the same job.

**Order of the leaves** (the implementer's): `Collapse/Thick` and `Collapse/Mixing`'s `finite_mixing` first (new, independent of
the copies — they decide the price); then the copies `Colouring → Dichotomy → Slice`; then `tendsto_levelResid`,
`mixing_at_level`, the selection; the headline last.

### 4.5 Drafted edits (not made; each for the coordinator)

- **D-E1** — `Arith/FloorPlanes.lean`, before `normOne_charSum_ge`: a new public theorem `norm_normOne_charSum_le` with the
  same hypotheses and conclusion `‖∑ u ∈ univ.filter (fun u : k => u ^ (Q + 1) = 1), ψ u‖ ≤ 2 * Real.sqrt Q` — the present proof
  of `normOne_charSum_ge` up to its last line, which becomes `hle`'s conclusion; `normOne_charSum_ge`'s proof becomes
  `neg_le_of_abs_le ((Complex.abs_re_le_norm _).trans (norm_normOne_charSum_le …))`. Its stored statement is unchanged.
- **D-E2** — `Rigidity/ClassRatio.lean`, after `newCharBound_of_two_notMem`: a new public theorem
  `norm_charSum_le_weil (P : StablePrime F) (h2 : 2 ∉ P.P) (hQ : Nat.card (𝓞 ⧸ P.P) = Q ^ 2) (hQ1 : 1 ≤ Q) (hm : 1 ≤ m) (hfin)
  (ψ) (hψ : ψ ≠ 1) : ‖∑ s ∈ hfin.toFinset, ψ s‖ ≤ 2 * √Q / (Q + 1) * hfin.toFinset.card` — `charBound_one_weil` with D-E1, and
  `charBound_of_charBound_oneT`'s induction with norms over the private `norm_charSum_le_of_resT`. No stored statement moves;
  `ClassRatio`'s dependents recompile.
- **D-E3** (not recommended) — weaken `Rigidity.Counting.image_levR_unitVectors`'s hypothesis from `TCA F` to "no ramified stable
  prime": it would move a landed stored statement; the copy is 30 lines.
- **`ARCHITECTURE.md`**, the module map: seven rows, after the `Rigidity/` block — `Collapse/Thick` (C1, thickness of places and
  levels; imports `Rigidity/CountCompletion`), `Collapse/Colouring` (C2; `Rigidity/APlus`), `Collapse/Dichotomy` (C3; C2,
  `Rigidity/ZeroEntropyClosed`), `Collapse/Slice` (C4; C3, `Rigidity/CountExtension`), `Collapse/Mixing` (C5; C1,
  `Arith/RatioBound`), `Collapse/Selection` (C6; C4, C5, `Plane/AeColouring`), `Collapse/Headline` (C7; C6, `Plane/YesLimit`,
  `Bridge`, `Reduction`, `Rigidity/SqrtClassFive`, `Outside/OAI158`) — each "skeleton, FS131-KCL1; not on `main`" until it lands.

### 4.6 The modeling passes (this job's)

- **Domain** (`debruijn-domain-modeling`, run at stage 3): uniform thickness as a `Prop` beside the field, per-place form as a
  corollary; the `k`-colour line as new parallel modules (the four-colour chain is an instance of it — a named debt, § 3.2); the
  colour spectral measure `Σ_j σ_{e_j}` in place of the simplex measure (the incidental constants of the paper's embedding
  removed); `AeColouring` as the output, the library's `χ_m⁰` object. Unsampled member: `k = 1` (`Xk_one_eq_empty`);
  adversaries `ℚ`, `ℚ(√11)`.
- **Obligation** (`debruijn-obligation-modeling`, run at stage 4): every hard leaf has a local decomposition (§ 4.3); the one
  global argument — mixing on the profinite `K` — is localised to finite levels, where the obligation is a finite-group
  inequality plus a residual that a library theorem sends to `0`. Statements checked for truth at their edge cases:
  `thick_of_forall_thickAt` at `c₀ ≤ 0` (vacuous or contradictory, both handled), `exists_factorLawK` at `k = 0` (no probability).
- **Experience**: not run — the job is out of budget (§ report). The public names follow the library's (`F635087` beside
  `F47`; `chromaticNumber_planeOver_…`); owed before the landing.

### 4.7 Front-page corrections and updates owed (drafted; Keryx files)

- **`LEDGER.md` row 128, its grade bracket** — after "MR row 120's grade", add: "MR is in the kernel in a stronger form: the
  one step that uses it (excluding the SP witness) follows from `Rigidity.mrPlus` at every real number field, on
  `[EinsiedlerLindenstrauss2022]` Thm 1.3 (FS131-KCL1 stage 2, scratch-checked); what remains [hand] is the load-bearing step
  and the selection (FS103-LB, FS103-SEL), planned for the kernel at about 3,300 lines (`plans/FS131-KCL1-collapse-plan.md`)".
  At the landing the row's "given MR" is struck from its headline and its "Not claimed: the complex-place widening" replaced by
  the general form's scope.
- **`LEDGER.md` row 128, "MR at degree 16 walked at FS-105, one checking reading"** and **row 120's "Not claimed: MR at row
  100's exception fields"** — both predate `mrPlus`, which holds MR⁺ at every real number field with no scope. This is FS131-PR1's
  owed correction "row 120's grade" (inventory item 951), seen again; no new slot.
- **`CLAUDE.md` § The aim, link 1** ("Given MR at a number field (row 120) it also equals `χ(F²)` at each totally real field where
  every stable place mixes at six colours, ℚ(√635087) and de Grey's field among them (row 128; [hand, two minds])") — at the
  landing: "It also equals `χ(F²)` at every real number field whose stable places all mix at six colours, ℚ(√635087) and de
  Grey's field among them — in the kernel since <landing>, on the two declared outside theorems (row 128)". Before the landing,
  only "Given MR at a number field (row 120)" is stale: "MR's one use there is a kernel theorem (`Rigidity.mrPlus`); the step that
  uses it is [hand]".

### 4.8 The build

`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 scripts/slot.py --mem 12 --cpus 6 -- env MEMMAX=12G BATCH=4 ./scripts/build.sh`: **OK — 557 of
557 batches, 8 modules rebuilt (the seven `Collapse/` modules and `Proofs`), 16 m 3 s** (`data/fs131/kcl1/build1.log`; the
full output `data/fs131/kcl1/build1-full.log`). Warnings: the `sorry` leaves, and one `unusedSectionVars` at `ThickAt.mono`
(`[NumberField F]`): the implementer adds `omit [NumberField ↥F] in` (no statement moves — the binder is not in the stored type).
For iteration the modules were elaborated by `lake env lean`, each upstream new module written to `.lake/build` with `-o` first;
the build recompiled all seven from source (no trace existed), so nothing it reports rests on those files. Nothing with a
`sorry` reaches `main`: the skeleton stays on `fs131-kcl1`.
