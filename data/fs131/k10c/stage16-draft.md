
## Stage 16 — SAVED (FS131-K10c): the two open gate items, the plan per leaf, the prices, the hand-off

Mathlib names marked ✓ were confirmed with `#check` at the pin in a scratch file (2026-10-06, `import Mathlib`); the rest are
**to be confirmed by the implementer**.

### 16.1 A usable place of the standing field — the leaf `exists_usable_place` (`Arith/UsablePlace.lean`)

`∃ w : Ideal (𝓞 standingField), w.IsMaximal ∧ Nat.card (𝓞 standingField ⧸ w) % 4 = 3`; over it
`exists_usable_place_card_ge` (proved) exhibits the family `usable_card_ge` and `no_small_usable` bound. **Route: the prime
83**, not 347 — at 347 one must show a residue degree is exactly 1, which needs all 28 primes above 347 or the index of
`ℤ[√3, √11, η]` in `𝓞 F`; at 83 an odd residue degree is forced by a count of three. `83 ≡ 3 (mod 4)`; `13² ≡ 3`,
`29² ≡ 11`; `g` has no root mod 83 (all three in the Spec, by `decide`).
- U1 a maximal `w ∋ 83` (`Ideal.exists_le_maximal` ✓; `83` is no unit of `𝓞 F`), its residue field finite of `83^f`
  elements. 40 lines.
- U2 **`7 ∣ f`** — *the residue field holds a root `η̄` of `g` and `𝔽₈₃` holds none*. What is hard: "no root in `𝔽₈₃`" gives
  degree `> 1`, and degree 7 needs the irreducibility of `g` mod 83 (exhausting monic cubics, 571,787 of them, is too much
  for one `decide`: cut it by the first coefficient into 83 generated checks, or use the conjugates — the roots of `g` are
  polynomials in `η` with denominators prime to 83, so `𝔽₈₃(η̄)` holds all seven roots and every irreducible factor of `ḡ`
  has one degree, a divisor of 7). `dvd_of_pow_pow_eq` (landed) then gives `7 ∣ f` as it gave `14 ∣ n` at 2. 200 lines.
- U3 **at least three primes above 83** — *each prime above 83 contains exactly one of `√d ± r_d` for `d ∈ {3, 11, 33}`
  (their product is `d − r_d² ∈ 83ℤ`, their difference `2r_d` a unit mod 83), and not every prime contains the same one*:
  else the other is a unit mod `83·𝓞 F`, so `(√d − r_d)/83` is integral, against its minimal polynomial
  `Y² + (2r_d/83)Y + (r_d² − d)/83²` (`minpoly.isIntegrallyClosed_eq_field_fractions'` ✓ — the pattern of the landed
  `two_sq_ne_of_isIntegral`). Three such splittings leave at least three sign classes non-empty (a two-class configuration
  is always constant on one of `√3`, `√11`, `√33`). 150 lines.
- U4 `Σ e·f = 28` (`Ideal.sum_ramification_inertia` ✓, the primed API, as the landed dyadic leaves use it) with three primes
  and `7 ∣ f` at each: `f = 7`, so `|𝓞 F ⧸ w| = 83⁷ ≡ 3 (mod 4)`. 60 lines.
About 450 lines; U2 is the hard child. **If U2's irreducibility does not close in one job, the fallback is a named
hypothesis on the leaf, never an axiom.**

### 16.2 The inhabitant notes the four J45 heads owe (the docstring edits are the second landing's)

| theorem | the note its docstring should carry | a model leaf? |
|---|---|---|
| `si4` | "MODEL: a deterministic proper colouring — `μ` a point mass, `c ω = c₀` with `c₀ x ≠ c₀ y` across `adj`: each conditional law is a point mass and `hdisj` holds for every `𝒜`. A model with a non-trivial `𝒜` is J45-SI-C's noisy colouring with `𝒜 = σ(Φ)` (`GapSeven.supp_disjoint` is its `hdisj` on the finite plane), not built." | the point-mass model is about 25 lines; **to state and prove at the landing** (not stated here) |
| `si4_equivariant` | "MODEL: any additive action with `T 0 = id`, `𝒜` its factor σ-algebra — `comap_factorSigma_eq_of_action` supplies `hS𝒜`, and `si4_equivariant_factorSigma` is this theorem there (`Arith/FactorAction`)." | none needed: the model is a landed theorem |
| `spectral_carried_iff` | "MODEL: the discrete topology (`bochnerOn_bot`), the trivial action `T y = id`, and `σ = ‖f‖² • δ₁`, the point mass at the trivial character — then both sides hold. At `τ′_S` the hypothesis `BochnerOn` is Bochner's theorem on `G′_S` with J45-N1 (b), not in the kernel." | `IsSpectralMeasureOf (fun _ => id) _ f (‖f‖² • δ₁)`, about 30 lines; **to state and prove at the landing** |
| `contChars_haar_null` | "MODEL: given `hBH`, `R = ℤ` with the profinite topology — the continuous characters are those of finite order, a countable (so measurable) proper subgroup separating the points of `ℤ`; `m` from `exists_isHaarFourier`. `hBH` is Herglotz's theorem, classical and not in the kernel: as for `sp_if`, a statement to prove and not a structure to inhabit. No finite `R` is a model (a separating group of characters of a finite group is the whole dual, against `hproper`)." | a leaf `contChars_haar_null_hypotheses_int (hBH)`, about 100 lines; candidate, low value until `BochnerHerglotz` is discharged |

### 16.3 The plan per leaf, `Arith/LevelGraph.lean` (`debruijn-obligation-modeling`'s question answered by hand: each child is one identity)

`StationarySet.prob_mul_card_le_indepNum`. Write `κ = cosetAverage K`, `φ(ω) = ∫ 1_B(T_u ω) dκ(u)` (the share of the origin's
coset), `φ_c = φ ∘ T_{y_c}` for a section `c ↦ y_c` of `Y → Y ⧸ K` (finite, so any function), `I_ω = {c : φ_c(ω) > 0}`.
- L-a *for every `c` and every `s` with `ν(π⁻¹ s) > 0`: `∫ φ_c · φ_{c+s} dP = 0`* — the integrand is at most
  `ν(π⁻¹s)⁻¹ · ∫∫ 1_B(T_y ω) 1_B(T_{y+t} ω) d(ν∗κ)(t) dκ_c(y)`, whose mean is `(ν∗κ × P){ω ∈ B, T_t ω ∈ B} = 0` by
  `hW` and measure preservation (`MeasurePreserving.lintegral_comp` ✓, `lintegral_prod` ✓, the landed
  `lintegral_prod_conv_cosetAverage` and `cosetAverage_preimage_add`). So a.s. `I_ω` is independent in `levelGraph ν K`
  (finitely many `c, s`). **Hard**: the Tonelli bookkeeping with `ν ∗ κ`. 130 lines.
- L-b `P(B) = ∫ φ dP ≤ P(φ > 0)` (`φ ≤ 1`). 30 lines.
- L-c `P(φ_c > 0) = P(φ > 0)` (measure preservation), so `|Y ⧸ K| · P(φ > 0) = ∫ |I_ω| dP ≤ α`
  (`SimpleGraph.IsIndepSet.card_le_indepNum` ✓, `[Finite (Y ⧸ K)]` from `AddSubgroup.quotient_finite_of_isOpen` ✓). 70 lines.
`map_neg_conv_cosetAverage`: `κ.map Neg.neg = κ` (Haar on a commutative group is negation-invariant —
`Measure.IsNegInvariant` ✓ is the class, `Measure.map_neg_eq_self` ✓ its lemma; the instance for `addHaar` to confirm — and
`K = −K`), then negation distributes over the convolution in a commutative group. 50 lines.

### 16.4 Prices (in lines and jobs; re-priced from what this pass proved — the import's module, 190 lines in three elaboration rounds; the interface with its model, 90 lines in three)

| job | files (no two jobs share one) | leaves | lines, about | jobs |
|---|---|---|---|---|
| I-K10c-1 | `Arith/LevelGraph`, `Arith/UsablePlace` | 3 | 280 + 450 = 730 | one (half a job's lines; U2 may hand back) |
| K10d (a fourth planning pass) | J45-SI-5, J45-SI-C: the carrier `RandomColouring`, the two statements, their read-backs | — | planner, about 120k | — |
| I-K10d | the two SI rows | — | 900 | one |
| candidates, unpriced into a job | the link `normOneCayley ≃g unitQuadrance` (150); the two model leaves of § 16.2 (55); J45-N1 (a), (b) proper (1,500–2,500, two jobs after a planning pass); the floor at six for `U₆₄` (410) | | | |

### 16.5 For implementers

No statement of this pass may be changed; a change comes back through Keryx. `Arith/WeilKloosterman` and `Arith/PlaceFilter`
hold no leaf. `LevelGraph`'s `map_neg_conv_cosetAverage` is stated for s-finite `ν`; if the convolution's symmetry reads
`[SFinite]` on the result the statement stands as it is. In `UsablePlace` write nothing that needs
`NumberField standingField` as an anonymous instance (§ 15.3): take `numberField_standingField` by `haveI` until the landing
makes it global. **Cite, do not restate**: `kloostermanBound_of_ringChar_ne_two` for any use of Weil's bound; a second
`axiom` is a statement defect.

### 16.6 For the wave's second joining job (replacing § 9.4's list where they differ)

- The branch `fs131-w10k` at this pass's tip holds: `main` as of `c20b57a0`, the whole second pass proved (`d4adcd40`,
  `f65c2aa5`), the import (the commit sent mid-job), and three skeleton modules with **three `sorry` leaves**
  (`LevelGraph` 2, `UsablePlace` 1). **The second landing is cut from the import's commit `<hash, § 17>`, which holds no
  `sorry`**; the three skeleton modules follow when their leaves are proved. Nothing with a `sorry` reaches `main`.
- **The import at the gate** (`LEAN.md` § Trust ledger): the `declareImport` line and the eight IMPORTED records are in
  `scripts/Axioms.lean`; run `./scripts/axioms.sh --self-test`, then `./scripts/axioms.sh`. Expected: declared imports
  **two** (`Plane.falconer_lemma2_nonempty`, `StandingFive.kloosterman_bound`); **imported records 4 + 8 = 12**; no record
  moves out of CLEAN (the eight are new). `standingFloor_seven`, `standingFloor_five`,
  `seven_le_localBound_of_kloosterman`, `targetFloor_seven_of_kloosterman` (hypothesis forms) stay CLEAN.
- Names this pass declares in existing namespaces from new modules — none may be re-declared: `StandingFive`
  (`kloosterman_bound`, `sum_units_eq_sum_ne_zero`, `four_mul_mul_ne_zero_iff`, `kloosterman_page_of_kloostermanBound`,
  `kloosterman_bound_model`, `kloostermanBound_of_ringChar_ne_two`, `ringChar_ne_two_of_card_mod_four`,
  `targetFloor_seven_weil`, `targetFloor_six_of_kloosterman`, `targetFloor_six_weil`, `circle_sum_le_weil`,
  `standingFloor_seven_weil`, `standingFloor_five_weil`, `seven_le_localBound_weil`, `five_le_chromaticNumber_weil`,
  `exists_usable_place`, `exists_usable_place_card_ge`); `StationaryRatio` (`levelGraph`, `levelGraph_adj`,
  `StationarySet.prob_mul_card_le_indepNum`, `ratio_conv_cosetAverage_le`, `map_neg_conv_cosetAverage`,
  `ratio_prod_le_max_iSup_levelGraph`); `SpectralInputs` (`IsPlaceFilter`, `profiniteFilter`,
  `IsPlaceFilter.eventually_map_eq_zero`, `IsPlaceFilter.infinite_of_mem`, `isPlaceFilter_profiniteFilter`).
  `FloorPlanes` also holds a `sum_eq_zero_add_sum_units` (I10D's); mine is `sum_units_eq_sum_ne_zero`, a different statement.
- **Edits owed in landed or fixed modules, the landing's**: `local instance` → `instance` for `NumberField standingField`
  (§ 15.3); the four docstring notes of § 16.2 and `sp_if`'s (§ 15.4); `Floor128`'s docstring on the Bézout pair (§ 15.2);
  `involution_eq_pow`'s docstring (ruling 538 (b)); `ae_eq_measurable_of_majority`'s two unread hypotheses and
  `[Countable K]` (ruling 542); `FloorPlanes`' module docstring and `KloostermanBound`'s, which still say "`[Weil1948]` …
  not held … never an `axiom`, until a page is read back" — now: "the import is `StandingFive.kloosterman_bound`
  (`Arith/WeilKloosterman`), at characteristic not 2"; `ARCHITECTURE.md`'s rows for `NormOneTarget`, `FloorPlanes`,
  `ProductFactor`, `MajorityVote`, `NegCircleModel` still say "skeleton" (their implementers did not own the file).
- `StandingFive.seven_le_localBound` and `five_le_chromaticNumber` keep their hypothesis forms; the wave's headline
  statements are `seven_le_localBound_weil` and `five_le_chromaticNumber_weil`.

### 16.7 Drafts for files this job does not write

- **`CLAUDE.md` § Trust ledger**, at the second landing: "… N clean and 5 declared purchases, and **12 imported**" — the
  imported count is of *records*: 4 (on `falconer_lemma2_nonempty`) + 8 (on `kloosterman_bound`); the library's declared
  outside theorems go from one to two. Inventory item 515 (c)'s "from 4 to 5" counted axioms where the audit counts records.
- **`LEAN.md` § Trust ledger**: no new line is needed — the table's row "an `axiom` importing an outside theorem" covers
  it. One sentence to weigh for § Assumptions, after item 2: "State the axiom in the paper's own form and derive the form the
  library uses: the translation is then kernel-checked and the read-back is symbol against symbol (`kloosterman_bound`)."
- **`BIBLIOGRAPHY.md`**, `[Weil1948]`: status "read: pp. 204–207 (FS131-K10c, 2026-10-06; pp. 206–207 at 300 dpi), read
  back against the Lean statement in `plans/FS131-w10-kernel-plan.md` Stage 12"; "It is the import … `KloostermanBound`, a
  named hypothesis … until" → "**It is imported**: `StandingFive.kloosterman_bound` (`Arith/WeilKloosterman`), the second
  display of p. 207 in the page's form, characteristic not 2"; add "a slip in print on p. 206: `ω(1 + x₁T + …) = −ψ(x₁)`,
  read `ψ(−x₁)`; it does not touch the displayed bound"; and "`> 5` for `p ≥ 62`" is `targetFloor_six_weil` [kernel over the
  import], about the norm-one target of `𝔽_{p²}` (§ 15.1). `[MMST1996]`: § 15.1's correction sentence.
- **`plans/FS131-kernel-plan.md` § 7.4**: `KloostermanBound` leaves the table of named hypotheses (it is an import, in
  `ARCHITECTURE.md` § Trust); `StandingFloor` likewise is discharged. New row: `IsPlaceFilter (𝓝[τ′_S] 0)` — what J45-N1
  (a), (b) owe the wave's rows; used by J45-SI-J's instance, -SI-5, -SI-C; path: J45-N1 (a), (b) proper.
- **`LEDGER.md`**, G56's row and row 53: the floor at seven for `Q ≡ 3 (mod 4)`, `Q ≥ 98`, and `χ(U₁₂₈) ≥ 8`, are [kernel]
  on `fs131-w10k` — the first over one import (`[Weil1948]`), the second over none — **as statements about the norm-one
  Cayley graph of `𝔽_{Q²}`**; "the plane `Γ_Q`" waits for the link of § 15.1.
- **`plans/LEAN-BACKLOG.md`**: TC1-STANDING-FIVE — "so `L(F) ≥ 7`" [kernel over one import] (`seven_le_localBound_weil`);
  J45-N1 — (c) landed, (a), (b) as the interface `IsPlaceFilter`, proper not stated; X25B-L1 — the comparison with the
  finite levels stated (`ratio_conv_cosetAverage_le`, two leaves); J45-SI-5, -SI-C — measure parts not stated (§ 14.3).
