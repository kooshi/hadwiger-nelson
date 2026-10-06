# FS-131, wave 10 — the kernel plan: the fourteen arithmetic rows

*Job FS131-K10 (de Bruijn, the planner), 2026-10-06, branch `fs131-w10`. Brief: `data/fs131/briefs/FS131-K10-wave10.md`. The milestone's
plan is `plans/FS131-kernel-plan.md` (§§ 7.1–7.5 bind this job); the claim list is `plans/LEAN-BACKLOG.md`. Nothing in this milestone is
blind (inventory ruling 1), so the derivations are read from the start.*

## Theorems this phase proved

All kernel-checked on this branch by `./scripts/build.sh` (exit 0, only `sorry` warnings elsewhere); `scripts/Axioms.lean`'s block "FS131-K10"
lists them. The branch does not run the gate (the brief), so the axiom audit of these is the landing's.

- **`CharacterColouring.gluing`** — FS89-S0A-2 at the class its argument reads: a ring with an invertible integer `m ≥ 2`, a module spanned by a
  set stable under the base's units, any band. [kernel on this branch] `Proofs/HadwigerNelson/Arith/CharacterColouring.lean`.
- **`CharacterColouring.gluing_field`** — FS89-S0A-2 in the row's words, with the erratum's `A`. [kernel on this branch] same file.
- **`CharacterColouring.gluing_iff_uniform`**, **`gluing_iff_of_orderBound`** — FS89-S0A-10: the uniform form unconditional at every band; the
  row's form over the band's order bound as a named hypothesis. [kernel on this branch] same file.
- **`CharacterColouring.cl2`** — FS89-CL2, over RQ₄, N₀, RQ₅ and J08-11's bound as named hypotheses. [kernel on this branch] same file.
- **`CharacterColouring.mem_archimedean_of_layers`**, `mem_torsionBy_sup_archimedean_of_nsmul`, `inv_five_mem_Qring`,
  `int_eq_zero_of_forall_pow_dvd` — the gluing's children. [kernel on this branch] same file.
- **`SpectralInputs.sp_only_if`**, `sp_only_if_interface` — J45-SP-oi, at its class and in the row's words. [kernel on this branch]
  `Proofs/HadwigerNelson/Arith/SpectralInputs.lean`.
- `SpectralInputs.contVec_id`, `bochnerOn_bot`; `StationaryRatio.StationarySet.empty_aeIndependent`, `prob_le_ratio`; `StandingFive.K_le`,
  `targetFloor_zero`, and (over the leaves `usable_card_ge`, `le_localBound`) `no_small_usable`, `seven_le_localBound`,
  `five_le_chromaticNumber` — models and compositions. [kernel on this branch; the last three rest on `sorry` leaves]

Outside the kernel, by exact arithmetic with a planted fault each ([tools]): the least usable residue field of `K·E₇` has 347 elements
(`tools/fs131_k10_usable.py`); the period polynomial of `E₇` is `x⁷ + x⁶ − 12x⁵ − 7x⁴ + 28x³ + 14x² − 9x + 1`, irreducible mod 2 and mod 7, with no
usable degree-one place below 347 (`tools/fs131_k10_period.py`).

## Stage 1 — SAVED: the readback, the build as given, the registered expectations

### 1.1 The brief's quotations against their sources (standing rule 3)

Checked by script (`grep -F` of each quoted string in the file the brief names; the script's text is in this job's log,
`data/fs131/k10/logs/quotations.txt`): **eleven of eleven match.**

| quotation (first words) | source | result |
|---|---|---|
| "Do not consider Lean formalization a cost. …" | `CLAUDE.md` § Counter-priors | match (the brief stops before "Your predecessor formalized …") |
| "### 7.3 What each wave's planning job must hold" | `plans/FS131-kernel-plan.md:556` | match |
| "1. **Reads its rows' derivation entries in full** …" | `:560` | match (the brief's line ends at the source's line break) |
| "3. **States every row at the class its argument reads** …" | `:568` | match (same) |
| "4. **Names every hypothesis from outside the backlog** …" | `:570` | match (same) |
| "**Wave 10** (14 rows):" and its four module lines | `:550–554` | match, all five |
| "\| `Row123Chain` \| row 123's chain …" | `:584` | match |

The CSV (`data/fs131/k1/dispositions.csv`, lines 179 and 248–260) gives all fourteen rows `formalize`, wave 10, with one ruling mark
(TC1-STANDING-FIVE: "its unconditional clauses (the field, its places above 2, no usable residue field of size <= 47, so L(F) >= 7) in
wave 10; 'given MR, chi(F^2) >= 5' as an implication from row 123's chain") and the C109 reason on the three FS-89 rows.

### 1.2 The branch as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` in this worktree, 2026-10-06: exit 0, "all 1767 modules
already up to date, nothing built, 0 module(s) with warnings" (`data/fs131/k10/logs/build-0-as-given.log`).

### 1.3 What `Proofs/HadwigerNelson/Arith/` and its neighbours already hold (read before the derivations)

- `Arith/NoAffine`, `Arith/FalconerFan` (wave 1), `Arith/PlaceHom`, `Arith/FalconerField`, `Arith/Dyadic` (wave 2): none defines a
  character group, a band set or a spectral measure. `Arith/Dyadic` holds `sqrt3_dyadic` (TC1-SQRT3-DYADIC, merged), TC1-STANDING-FIVE's one
  upstream id.
- `UnitRing`: `unitRingOver F : Subring ℂ` (`R_F = ℤ[U_F]`), `planeOverSubfield F` (`F(i)`), `exists_sum_eq_of_mem_unitRingOver` (every
  element a finite sum of unit vectors), `inv_five_mem_unitRing_conj`.
- `SpectralChain` (FS-100): `unitVectors`, `unitRing`, `Dual F = AddChar (unitRing F) Circle` with the cylinder σ-algebra, `rot`, `RotInv`,
  `InvariantColouring`, `IsTraceSpectral`, `BochnerHerglotz`, the `Interface` (`E`, `TA`, `h` as data; R-U, A⁺, PE-2, EF_F⁺, MR as named
  `Prop`s), SP-Cor (`Interface.x4_eq_empty`), `StablePrime`, `levelTarget`, `localBound`, and the headline
  `min_localBound_five_le_chromaticNumber` — **row 123's chain already stands in the kernel over named hypotheses**, so `Row123Chain`'s
  Lean form is that theorem's conclusion, `min (localBound F) 5 ≤ χ(F²)`.

### 1.4 Registered expectations (written after reading the fourteen backlog entries and the modules above, before reading any derivation)

- **X1** rows I can state as theorems with no named hypothesis from outside the backlog: median 6 of 14, 80 % interval [3, 10].
- **X2** at least one statement defect beyond the known C109 (the Notation's `A`): 0.7.
- **X3** TC1-STANDING-FIVE's "so `L(F) ≥ 7`" needs more than `Row123Chain` — lower bounds for the finite targets, held outside the kernel:
  0.8. (Reason: `L(F)` is an infimum of chromatic numbers over every stable prime, an infinite family of finite graphs, and nothing in the
  backlog bounds them.)
- **X4** J45-N1, -N2, -SI-J need a foundation Mathlib lacks at the pin (spectral measures on the dual of a countable discrete ring,
  Bochner): 0.85; they are stated over `SpectralChain`'s `Dual` with Bochner as a named hypothesis: 0.6.
- **X5** leaves I prove in this job: J45-SP-oi 0.9; FS89-S0A-10 as a composition 0.6; FS89-CL2 as a composition over named hypotheses
  0.6; X25B-PZ 0.3.
- **X6** at least two rows "are one theorem" or belong elsewhere (SP-if and SP-oi read as one iff): 0.7.
- **X7** the wave's close (all fourteen sorry-free): median three implementer jobs, 80 % interval [1.5, 8]. Short: SP-oi, SP-if, S0A-10,
  CL2, S0A-2. Long: N1, N2, SI-J, TC1-STANDING-FIVE's arithmetic.

## Stage 2 — SAVED: the dispositions, and what the rows' derivations do and do not support

Read in full: `plans/TC1-derivation.md` (whole), `plans/FS89-derivation.md` lines 1–110 and 318–345 with the erratum at line 32,
`plans/FS89-S0A-gluing-verification.md` §§ C1 (G1, N₀), C3, `plans/FS84-SI-D-derivation.md` §§ 1.2, 2.1–2.3, 4.1–4.2 and the eight filed entries
(lines 419–556), `plans/FS100-derivation.md` lines 385–440, `plans/FS100-X25B-derivation.md` § Stage 2. Corrections owed that the entries point to
were followed: J08-11 (`plans/FS91-S1D-six.md:259–335`), J03a-9, J07-14 (by their theorem lines).

### 2.1 The fourteen rows

| row | what it is in Lean | rests on, inside the backlog | named hypotheses from outside it | state on this branch |
|---|---|---|---|---|
| FS89-S0A-2 | a theorem, at a wider class (`gluing`), and the row (`gluing_field`) | — | none | **proved** |
| FS89-S0A-10 | a theorem in uniform form (`gluing_iff_uniform`); the row's form an implication from the band's order bound (`gluing_iff_of_orderBound`) | FS89-S0A-2 | `OrderBound (unitSet ⊥) B N` — FS89-S0A-3 at `k = 4`, J08-11 at 5, J08-10 at 6; derived at no other band | **proved** |
| FS89-CL2 | a named-hypothesis implication (`cl2`): S0A-2 at two bands | FS89-S0A-2, -S0A-10 | RQ₄ (FS89-D2-T1), N₀ (FS89-S0A-3, on Weil), RQ₅ (FS89-D5-T2), `N₅` (J08-11) | **proved** |
| J45-SP-oi | a theorem at a wider class (`sp_only_if`) and the row (`sp_only_if_interface`) | — | none (`IsHaarFourier` is a definition) | **proved** |
| J45-SP-if | a named-hypothesis implication over the interface (`sp_if`) | — | `BochnerHerglotz` (uniqueness); `Interface.MulStable` (J28V-7); `Interface.NegCircle` (a Bessel value) | stated, `sorry` |
| J45-N2 | two theorems: the factor of a filter (`measurableSet_factorSigma_iff`, `contVec_eq_lpMeas`, `measurableSet_preimage_factorSigma`), and the spectral half (`spectral_carried_iff`) | J45-N1 (b), through `BochnerOn` | `BochnerOn t` (Bochner on an LCA group with a dense image of `R`) | stated, `sorry` |
| J45-N1 | (c), the clause the chain consumes: `contChars_haar_null`; (a), (b) not stated | — | `BochnerHerglotz`; for (a), (b): weak approximation on the norm-one torus, J28V-7 | (c) stated, `sorry`; (a), (b) **not stated** (§ 3.3) |
| J45-SI-4 | a theorem at a wider class (`si4`): any countable graph, any sub-σ-algebra | J45-N2 only to read `𝒜 = 𝒜_S`; SI-3's form of equality is its hypothesis | none | stated, `sorry`; equivariance clause a child not yet stated |
| J45-SI-5, -SI-J, -SI-C | SI-J a theorem about an independent product; SI-5, SI-C theorems over it; SI-C's finite facts a `decide` over `Γ₇` | J45-N1 (c), -N2, -SI-J | `BochnerHerglotz`; Bernoulli shifts have Lebesgue spectrum (formalizable) | **not stated** (§ 3.3) |
| X25B-PZ | a theorem at a wider class (`ratio_prod_le`), with its child X25B-P (`prob_le_ratio_mul`, not a backlog row) | — | none | stated, `sorry` |
| X25B-L1 | a theorem (`ratio_prod_le_iSup_levels`), the levels pulled back to `X × Y` | — | none | stated, `sorry` |
| TC1-STANDING-FIVE | unconditional clauses as theorems; "so `L(F) ≥ 7`" and the MR clause as named-hypothesis implications | TC1-SQRT3-DYADIC is **not** used (the elementary route below reads the residue fields directly) | `StandingFloor n` (G56: Weil from 98, `U₁₂₈`'s Hoffman floor); `Row123Chain` | stated, `sorry` at nine leaves |

No certified computation enters a statement. Two enter proofs: the period polynomial's identities (`decide` on vectors of length 29) and the
finite checks below 347, both in `StandingFive`'s plan.

### 2.2 Statement findings (sent to Keryx mid-job; ruled, inventory items 477–478)

1. **TC1-STANDING-FIVE hides more than MR.** `plans/TC1-derivation.md:60`: "so L(F) ≥ 7, and given MR, χ(F²) ≥ 5"; its `uses only` line: "G56
   (every usable plane from 59 up refuses six; U₁₂₈'s Hoffman floor is 8)". `SpectralChain.localBound` is an infimum over every stable prime, and `F`
   has infinitely many usable places, so both clauses need a floor for an infinite family of finite graphs, held at [tools]/[hand] on Weil's
   bound, in neither the kernel nor the backlog; the CSV calls the clause unconditional. **The bound used, and how it was counted** (Keryx's ask):
   the hypothesis `StandingFloor n` asks the floor at `U₁₂₈` and at every `Γ_Q`, `Q ≡ 3 (mod 4)`, **`Q ≥ 347`** — the least class the row reads.
   Count: a usable residue field of `F` has `p ≡ 3 (mod 4)` and odd residue degree `f = lcm(f_K, f_7)`, `f_K ∈ {1, 2}`, `f_7 ∈ {1, 7}`, so `f = 7`
   (`Q = p⁷ ≥ 11⁷`; at `p = 3` and at `p = 7` the degree is even or divisible by 7) or `f = 1` (`p` splits completely: 3 and 11 squares mod `p` and
   `p⁴ ≡ 1 (mod 29)`); the primes `p < 347`, `p ≡ 3 (mod 4)`, `p⁴ ≡ 1 (mod 29)` are 59, 191, 307, 331, each with `f_K = 2`, and 347 splits
   completely. Exact arithmetic on the splitting law, `tools/fs131_k10_usable.py` (PASS; its fault, dropping the condition on 11, gives 59), and
   again from the period polynomial's roots, `tools/fs131_k10_period.py` (PASS; fault fires). So every usable target of `F` is in the Weil range
   (`Q ≥ 98`) and no certificate at 59–83 is an input. The Lean clause `usable_card_ge` proves the count; `no_small_usable` is the row's "at most 47".
2. **FS89-S0A-10's "every band" is held at `k ∈ {4, 5, 6}` only**: its `⟹` needs the band's order bound, derived at 4 (S0A-3), 5 (J08-11:
   35,112) and 6 (J08-10: 105,336). The uniform equivalence is unconditional at every band and is proved.
3. **FS89-S0A-2 generalizes**, with a shorter route (no limit): proved in that form.

Further findings of the modeling passes, each a generalization (the statements above are already written at these classes):

4. **J45-SP-oi reads one hypothesis of its four**: a measure with `∫ Re χ(r) dτ < 0` at some `r ≠ 0` is not a multiple of Haar; `U`-invariance,
   finiteness and `τ(E) = 0` are not read.
5. **J45-N2's second sentence needs no spectral theory, no group and no topology**: for any family of measure-preserving maps and any filter on
   the index set, the vectors continuous along the filter are `L²` of a σ-algebra, and the projection is the conditional expectation.
6. **J45-N1 (c) has a Fourier-side route** with no topology on the dual and no Steinhaus–Weil (`contChars_haar_null`'s docstring): it needs only
   Herglotz–Bochner's uniqueness, measurability, separation and properness — not that `R` is torsion-free, nor that `t` is a group topology.
7. **J45-SI-4 reads neither the properness of `c` nor that `𝒜` is `𝒜_S`**: any countable graph, any sub-σ-algebra.
8. **X25B-PZ and X25B-L1 read no Haar measure on the group**: almost-sure a.e.-independence of a stationary set is one equation at the origin,
   so the class is measurable groups with σ-finite symmetric connection measures (the entry: "LCA Cayley graphs"). **To be confirmed by the
   implementer's first pass**: the widening is read off the derivation, not yet off a proof. In L1, with the levels pulled back to `X × Y`, the
   independence of `{φ_k > 1/2}` is a pigeonhole (two events of share above `1/2` under one Haar probability meet), shorter than the entry's integral
   bound; and "martingale convergence on the fibres" is `L¹`-continuity of a jointly measurable action.
9. **TC1-STANDING-FIVE needs neither TC1-SQRT3-DYADIC nor a decomposition law**: the residue fields are read from explicit integral elements
   (`i`, `ω = (−1 + √3·i)/2`, `(1 ± √33)/2`, `η`) and one identity `Σ e·f = 56` (§ 5.4).

### 2.3 Registered expectations, scored

X1 (rows stated with no outside hypothesis; median 6, [3, 10]): **5 of the 11 stated** (S0A-2, SP-oi, SI-4, PZ, L1) — in the interval. X2 (a defect
beyond C109, 0.7): **yes, two.** X3 (STANDING-FIVE needs more than `Row123Chain`, 0.8): **yes.** X4 (the J45 rows need a foundation Mathlib lacks,
0.85): **yes**; (stated over `SpectralChain`'s dual with Bochner named, 0.6): N2 and N1 (c) yes, SI-J not stated. X5: SP-oi proved (0.9, yes);
S0A-10 proved (0.6, yes); CL2 proved (0.6, yes); PZ proved (0.3, **no**). X6 (two rows one theorem, 0.7): **yes** — CL2 and S0A-10's `⟹` are
S0A-2 at parameters. X7 (the close, median three jobs, [1.5, 8]): re-priced at five to six (§ 5.6), above the median, inside the interval.

## Stage 3 — SAVED: the foundation (`debruijn-domain-modeling`, invoked fresh)

Four modules under `Proofs/HadwigerNelson/Arith/`, each with a module docstring read against its rows. Every definition has a spec example or a
model lemma; the one structure (`StationarySet`) has a named inhabitant.

### 3.1 The model, and why this shape

- **Characters are additive maps into `UnitAddCircle`** (`M →+ ℝ/ℤ`), not `AddChar M Circle`: the rows speak of bands in `ℝ/ℤ`, `Nθ = 0` and real
  lifts, all additive. `T_N` and `A` are subgroups (`torsionBy`, `archimedean`), so "`T_N + A`" is `⊔` and membership is `AddSubgroup.mem_sup`.
  **`A` is "has an additive lift to `ℝ`"**: intrinsic to the group, with no field and no embedding in the definition, which is what removes the
  C109 defect at its root; `mem_archimedean_unitRing_iff` (a leaf) reads it back as the erratum's `Hom_ℚ(F(i), ℝ) mod 1`. `SpectralChain`'s
  `Dual F` (multiplicative circle) is the other costume of the same characters; no row here crosses, so no bridge is minted (the bridge is
  `AddCircle.toCircle`, owed the day an `E`-set is built from `T + A`).
- **The band is any subset of `ℝ/ℤ`** and the base any ring with an invertible integer: the class the gluing reads. The module structure is what
  makes kernels divisible; an abstract "family of layers" without it would need `M` torsion-free.
- **Haar measure is `IsHaarFourier`** (Fourier coefficients vanish off 0): no topology on `AddChar G Circle` is needed anywhere in the wave, and
  `SpectralChain.Interface.PE2` already speaks this language.
- **The `E_S`-factor is the factor of a filter** (`contVec`, `factorSets`, `factorSigma`): `factorSigma` is `generateFrom factorSets`, so the
  foundation is sorry-free, and "the generating family is already a σ-algebra" is the leaf.
- **A stationary random set is an event in a system** (`StationarySet`): a jointly measurable measure-preserving action and an event. Rejected:
  a jointly measurable random subset with stationary finite-dimensional laws (every derived set — `N(A)`, the fibre shares — is an integral
  functional, whose stationarity then costs a moment argument each time). The quotient `Y/K_k` never appears: level `k` is the connection measure
  smoothed by `K_k`'s Haar probability (`cosetAverage`). `Ω : Type` is fixed in universe 0, so `ratio` is a supremum over a set-sized family.
- **`F = K·E₇` is `Subfield.closure {√3, √11, η}` in `ℝ`**, `η = 2cos(2π/29) + 2cos(24π/29)`, so it meets `SpectralChain.localBound` with no cast. The
  usable clause is stated on `𝓞 F` (the row's "places of F") and again on `StablePrime F` (what `localBound` reads); the bridge is a leaf's child.
  `TargetFloor` quantifies over abstract finite fields with an involution, so it does not mention `𝓞`, and `targetFloor_zero` shows it satisfiable.

### 3.2 Validation (the seams)

- Models: `half` (a band character of `(ℤ, {1})` at band `1/2`, killed by 2); `contVec_id`; `bochnerOn_bot`; `StationarySet.empty` with
  `empty_aeIndependent`; `targetFloor_zero`. Adversarial members kept as examples: `1/4 ∈ band 4`; `∫ χ(0) dm = 1` for `IsHaarFourier` (the
  `r ≠ 0` guard); `orderOf (2 : ZMod 29) = 28`; `{1, 12, 17, 28}` are the fourth roots of unity mod 29.
- **A kernel fact measured here** (draft for `LEAN.md` § Searching, Keryx's file): a `rfl` for
  `((Subring.inclusion h a : unitRing F) : ℂ) = a` at the concrete pair `unitRing ⊥ ≤ unitRing F` is accepted by the elaborator and times out in
  the kernel, which compares the two subtypes and descends into `F =?= ⊥`. Stated generically in the two subrings
  (`coe_inclusion_subring`) it is checked once with variables. Logs: `data/fs131/k10/logs/cc-2.log`, `cc-3.log` (the timeout), `cc-4.log` (clean).
- Vacuity, as the gate will read it: `sp_if`'s and `sp_only_if_interface`'s hypotheses are open questions over the arithmetic `E` (their docstrings
  say so and name the model at `Interface.trivial`); `cl2`'s hypotheses are sets of characters, GENERIC.

### 3.3 The rows not stated, and what stating them needs

- **J45-N1 (a), (b)**: the topology `τ′_S` on `R = unitRing F` as an infimum of three induced topologies — profinite (finite-order characters),
  archimedean (`fieldI F →+* ℂ`, the pi topology), `S`-adic (`IsDedekindDomain.HeightOneSpectrum.adicValued` at the split places) — then
  `contChars τ′_S = T · A · Fin_S` (the three continuity groups multiply up), which is the content of "R is dense there". Its inputs: weak
  approximation on the norm-one torus (the rational parametrization and weak approximation in `F`), J28V-7 (`|R/NR| < ∞`: a torsion-free group of
  finite rank). "Borel-isomorphic to the dual group" needs `G′_S` itself; its one consumer is R-U, not a row of this wave.
- **J45-SI-J**: complex `L²`, spectral measures of vectors, the spectral measure of a tensor of independent factors as a convolution, and
  "Bernoulli has Lebesgue spectrum" (the centred coordinate functions are orthogonal across translates: formalizable, no outside theorem).
- **J45-SI-5**: SI-J, SI-3 (not a row), rotation by `U`, and the frequency argument "its colour has frequency ≥ 2/3" — as written it cites ergodic
  averages along a tempered Følner sequence (Lindenstrauss's pointwise theorem, not in Mathlib); a conditional-expectation argument may replace it,
  **a question for the deriver if the second pass cannot** (not derived here).
- **J45-SI-C**: SI-J with no `c₂`, and four finite facts about `γ = ⌊4(2x + 3y)/7⌋` on `Γ₇` (49 vertices, 392 directed edges): a `decide`,
  statable today against the library's `Γ₇`; left with its row so the row lands whole.

A second planning pass (K10b) states these four; they are one implementer wave of their own (§ 5.6).

## Stage 4 — SAVED: the skeleton, and each statement read back against its row

Build: `data/fs131/k10/logs/build-1-skeleton.log` and `build-2-skeleton.log` (exit 0; every warning is `declaration uses 'sorry'`; 21 leaves:
`CharacterColouring` 1, `SpectralInputs` 8, `StationaryRatio` 3, `StandingFive` 9). `tools/check_architecture.py`: PASS (it failed on the four
modules before their rows were added: the control). `./scripts/dupnames.sh`: the one known pair, `Plane.conj_e`, and nothing of this job's.
No `axiom`, no `native_decide`.

| row, verbatim | the Lean statement, read aloud | differences |
|---|---|---|
| FS89-S0A-2: "`Θ_k(ℤ[U_ℚ]) ⊆ T_N + A` ⟹ `Θ_k(R_F) ⊆ T_N + A` for every subfield `F ⊆ ℝ`, at every band" | `gluing_field B N h F`: if the band set of `(unitRing ⊥, unitSet ⊥)` at `B` lies in `torsionBy N ⊔ archimedean`, so does that of `(unitRing F, unitSet F)` | `B` any subset of `ℝ/ℤ`; `A` the erratum's; `N = 0` allowed (`T_0` is everything, the statement is then empty of content, not false) |
| FS89-S0A-10: "`Θ_k(ℤ[U_ℚ]) ⊆ T + A` ⟺ `Θ_k(R_F) ⊆ T + A` for every subfield `F ⊆ ℝ`, every band" | `gluing_iff_of_orderBound B hN0 hN`: the same iff, with `T = AddCommGroup.torsion`, given `OrderBound (unitSet ⊥) B N`, `N ≠ 0` | **the added hypothesis** (finding 2); `gluing_iff_uniform` has none |
| FS89-CL2: "`Θ₄(R_F) ⊆ T₁₆₈ + A` and `Θ₅(R_F) ⊆ T + A`" | `cl2 hRQ4 hN0 hRQ5 hN5pos hN5 F`: the conjunction, at `band 4` and `band 5` | the four inputs are arguments; `band k` is the image of `[1/k, 1 − 1/k]` |
| J45-SP-oi: "If a finite positive `U`-invariant `τ` has `τ(E) = 0` and `∫ Re χ(1) dτ < 0`, then `τ` itself is a `U`-invariant finite measure with `τ(E) = 0` that is not a multiple of Haar" | `sp_only_if_interface I hfin hrot hE hneg`: the three properties, and `τ ≠ a • m` for every `IsHaarFourier m` and every `a` | "Haar" is `IsHaarFourier`; "a multiple" is an `ℝ≥0∞` multiple |
| J45-SP-if: "If some finite positive `U`-invariant `ν` with `ν(E) = 0` is not a multiple of Haar, then some finite positive `U`-invariant `τ` has `τ(E) = 0` and `∫ Re χ(1) dτ < 0`" | `sp_if I hBH hmul hcirc hfin hrot hE hm hnh` | the two properties of `E` the proof reads are hypotheses on the interface; `Countable (unitRing F)` assumed (true over a number field) |
| J45-N2: "the vectors of `L²(μ)` with spectral measure on `E_S` are `L²(𝒜_S)` for a translation-invariant σ-algebra, and `Π(E_S) = E[·\|𝒜_S]`" | `spectral_carried_iff` (spectral measure null off `contChars t` iff `f ∈ contVec T (𝓝 0)`), `contVec_eq_lpMeas` (`contVec = lpMeas (factorSigma)`), `measurableSet_preimage_factorSigma` | real `L²`; "`Π(E_S) = E[·\|𝒜_S]`" is `contVec_eq_lpMeas` with Mathlib's `condExpL2` (the projection onto `lpMeas`), **not a separate statement** — a child to state at the first leaf; the spectral projection `Π` is not defined |
| J45-N1: "`E_S` … is a proper dense σ-compact subgroup, Haar-null, `U`-invariant, Borel-isomorphic to the dual group" | `contChars_haar_null`: measurable, separating, proper ⟹ `m (contChars t) = 0` | **only the Haar-null clause**; density enters as separation of points; (a), (b), σ-compact, `U`-invariant, the Borel isomorphism not stated |
| J45-SI-4: "equality at every `u` ⟹ every selection from the supports is an `𝒜_S`-measurable equivariant proper four-colouring" | `si4`: orthogonal conditional laws across every edge ⟹ `f ∘ condSupport` is `𝒜`-measurable, a.s. proper, and `c x ∈ condSupport` a.s. | "equality" in SI-3's form; **"equivariant" not stated** (child `si4_equivariant`, needs the action and an invariant `𝒜`) |
| X25B-PZ: "the stationary ratio of a categorical product of two LCA Cayley graphs is at most the larger factor's" | `ratio_prod_le νG νH hG hH`: `ratio (νG.prod νH) ≤ max (ratio νG) (ratio νH)` | measurable groups, σ-finite symmetric measures (finding 8) |
| X25B-L1: "a profinite factor's stationary ratio in a product is at most the supremum over its finite levels" | `ratio_prod_le_iSup_levels νX νY K hK hK0` | level `k` is `νY ∗ cosetAverage (K k)` on `Y`, not a measure on `Y/K_k` |
| TC1-STANDING-FIVE (§ 2.2 item 1's sentence) | `numberField_`, `finrank_` (28), `isTotallyReal_standingField`, `K_le`; `ncard_primes_above_two` (2), `comap_conj_of_two_mem`, `card_quotient_of_two_mem` (`128²`, conjugation not the identity); `no_small_usable` (47 <), from `usable_card_ge` (347 ≤); `seven_le_localBound (hFloor : StandingFloor 7)`; `five_le_chromaticNumber (hFloor : StandingFloor 5) (hRow123 : min (localBound F) 5 ≤ χ)` | "totally real" as "every embedding into `ℂ` has real values"; "inert, of norm 128" as residue size `128²` with a non-trivial involution; the two conditional clauses each carry the floor |

## Stage 5 — SAVED: the plan per leaf (`debruijn-obligation-modeling`, invoked fresh), the prices, the hand-off

Mathlib names marked ✓ were confirmed with `#check` at the pin in a scratch file (2026-10-06); the others are **to be confirmed by the
implementer before use** — a remembered name is a guess.

### 5.1 `CharacterColouring` — one leaf

`mem_archimedean_unitRing_iff`. `⟸`: restrict. `⟹`: child `exists_ratLinear_extension` — an additive `ψ : S →+ ℝ` on an additive subgroup `S`
of a `ℚ`-vector space `V` extends to `V →ₗ[ℚ] ℝ`: `ℝ` is divisible, so Baer's criterion extends `ψ` over `ℤ` (`Module.Baer.extension_property`,
with `ℝ` Baer over `ℤ` — to confirm; else extend by hand on `Submodule.span ℚ S`, each element `n⁻¹ • s`, then `LinearMap.exists_extend`), and an
additive map of `ℚ`-spaces is `ℚ`-linear (`AddMonoidHom.toRatLinearMap`, to confirm). About 60 lines.

### 5.2 `SpectralInputs` — eight leaves

- `exists_isHaarFourier`: `δ₀` is `PosDef` (the double sum is `Σ |z_x|²`); Herglotz–Bochner gives `σ`; its mass is the coefficient at 0. 40 lines.
- `sp_if`, five children: (a) some `ν̂(r₀) ≠ 0`, `r₀ ≠ 0` — else `ν` and `ν(univ) • m` share the coefficients of a `PosDef` function and
  uniqueness makes them equal (child `posDef_fourier`: the transform of a finite measure is positive definite); (b) `ν̂(r₀)` is real, from the
  rotation by `−1`; (c) `mulDual r₀`, measurable, commuting with `rot`; `τ′ = ν.map (mulDual r₀)` is finite, rotation-invariant, `E`-null by
  `MulStable`, with `τ̂′(1) = ν̂(r₀)`; (d) if negative, done; (e) if positive, `τ = τ′ ∗ λ` (`Measure.mconv`; child: `MeasurableMul₂ (Dual F)` for
  the cylinder σ-algebra), `τ̂(1) = ν̂(r₀)·λ̂(1)`, `E`-null by `NegCircle`'s set `S`. What is hard: Fubini's bookkeeping in (e). 350 lines.
- `measurableSet_factorSigma_iff`: **the statement the proof derives from** — `contVec` is a closed subspace containing the constants and stable
  under `f ↦ φ ∘ f` for `φ` Lipschitz with `φ 0 = 0`. Children: `contVec` add/smul; `isClosed_contVec` (three-ε, `V_y` an isometry:
  `Lp.norm_compMeasurePreserving`); `const_mem_contVec`; `lipschitz_comp_mem_contVec` (`LipschitzWith.compLp`); then complements (`1 − 1_A`),
  intersections (`min` through `|·|`), increasing unions (dominated convergence and closedness); conclude by `MeasurableSpace.generateFrom` of a
  σ-algebra. Each child is one norm inequality. 250 lines.
- `contVec_eq_lpMeas`: `⊇` by the induction principle for `lpMeas` (`Lp.induction_stronglyMeasurable`, to confirm) and closedness; `⊆`: for
  `f ∈ contVec` with representative `g`, each `{g > t}` is in `factorSets` (its indicator is the `L²`-limit of `min(1, n(g − t)⁺)`), so `g` is
  `factorSigma`-measurable (`measurable_of_Ioi`). Then state and prove the child `condExpL2_eq_proj` ("`Π = E[·|𝒜]`") from Mathlib's `condExpL2`.
  250 lines.
- `measurableSet_preimage_factorSigma`: through the iff; `‖V_y V_x f − V_x f‖ = ‖V_y f − f‖` by commutation. 40 lines.
- `spectral_carried_iff`: (a) `‖V_y f − f‖² = 2(‖f‖² − σ̂(y))`; (b) `⟹` dominated convergence along sequences (`hcount`); (c) `⟸` continuity at 0
  spreads (`|σ̂(x) − σ̂(y)| ≤ ‖f‖·‖V_{x−y} f − f‖`), then `BochnerOn`. 200 lines.
- `contChars_haar_null`: the Fourier-side route in its docstring; children `map_mul_right_eq` (Haar is translation-invariant, by uniqueness),
  `fourier_restrict_eq_zero`, `posDef_fourier`. 150 lines.
- `si4`: children `measurable_condSupport` (`stronglyMeasurable_condExp`), `ae_mem_condSupport` (SI-2, `setIntegral_condExp` on `{p_j ≤ 0}`),
  `ae_disjoint_condSupport` (`condExp_nonneg`, `integral_eq_zero_iff_of_nonneg`), the assembly; then state `si4_equivariant`. 200 lines.

### 5.3 `StationaryRatio` — three leaves

- `prob_le_ratio_mul` (X25B-P): children `StationarySet.prod` (the independent coupling: product space, diagonal action), `measurableSet_nbhd`
  (`measurable_measure_prodMk_left`, to confirm), independence of `(S ∖ N[A]) ∪ A`, the product-measure computation, and the supremum step in
  `ℝ≥0∞` (`ratio ≤ 1`). 400 lines.
- `ratio_prod_le` (X25B-PZ): children — the two restricted systems (the same `Ω`, the action through `G × 0` and `0 × H`); the events
  `Y = B ∖ N_H(B)`, `A = B ∩ N_H(B)`, `P(B) = P(Y) + P(A)`; `Y` is `H`-independent and `A` is `G`-independent; **the local obligation**: one lemma
  `null_of_edges` (a positive measure of `(ω, s, t)` with both ends in `B` contradicts independence) to which each of the derivation's four cases
  reduces by one translation; the sum. What is hard: the signs. 700 lines.
- `ratio_prod_le_iSup_levels` (X25B-L1): children — `share k` (the average of `1_B` over `K k`), `K k`-invariant; `{share k > 1/2}` independent
  for the smoothed measure (the pigeonhole of finding 8); `P(B) ≤ P(share k > 1/2) + E[share k; share k ≤ 1/2]`; and `tendsto_share` (`share k → 1_B`
  in `L¹`), from `continuous_translate_L1` — a jointly measurable measure-preserving action of a second-countable locally compact group is
  `L¹`-continuous (averages against bump functions are dense, by Fubini; no separability of `L¹(P)` needed). What is hard: the last child. 800 lines.

### 5.4 `StandingFive` — nine leaves, one certificate

**The statement everything derives from**: the period polynomial `g = x⁷ + x⁶ − 12x⁵ − 7x⁴ + 28x³ + 14x² − 9x + 1` has `g(η) = 0`, is irreducible
mod 2 and mod 7, and for no prime `p < 347`, `p ≡ 3 (mod 4)`, does it have a root mod `p` while 3 and 11 are squares mod `p`
(`tools/fs131_k10_period.py`, exact, fault fires). In Lean: `g(η) = 0` by a computable model of `ℤ[ζ]/(ζ²⁹ − 1)` (vectors of length 29 under
cyclic convolution, an evaluation map into `ℂ` shown multiplicative once, then `decide`); irreducibility mod `p` by exhausting the monic
divisors of degree ≤ 3; the last by `decide`. No decomposition law, no Galois theory, no cyclotomic inertia theorem.

- `numberField_`, `finrank_` (28), `isTotallyReal_`: `√3`, `√11`, `η` integral; `[E₇:ℚ] = 7` because `g` is irreducible over `ℚ` (monic, irreducible
  mod 2); `[K:ℚ] = 4` (grep the library first: Theorem B's modules work in this field); 28 by coprime degrees; totally real because `g` has seven
  real roots (eight sign changes at rational points). 300 lines.
- The dyadic three: at a prime `P ∋ 2` of `𝓞 (F(i))`, `e ≥ 2` (`(1 + i)² = 2i`), the residue field contains `𝔽₄` (the image of `ω`) and a root of
  `g` mod 2, hence `𝔽_{2¹⁴}`; at least two primes (each contains exactly one of `(1 ± √33)/2`, whose product is `−8` and sum 1, and not all contain
  the same one, else `(1 + √33)/16` would be integral); `Σ e·f = 56` (`Ideal.sum_ramification_inertia`, to confirm) forces exactly two, `e = 2`,
  `f = 14`. Stable: conjugation fixes `(1 ± √33)/2`. Inert: `ω̄ ≠ ω̄²`. 400 lines.
- `usable_card_ge`: at `w` with residue field of `Q = p^f` elements, `Q ≡ 3 (mod 4)`: `p ≡ 3 (mod 4)`, `f` odd; `f = 1` gives a root of `g` and
  square roots of 3 and 11 in `𝔽_p`, so `p ≥ 347` by the `decide`; `f ≥ 3` gives `Q ≥ 347` except `p ∈ {3, 7}`, where `f` is even (11 is not a
  square mod 3) or divisible by 7 (`g` irreducible mod 7). 300 lines.
- `stablePrime_card`: at a stable `P ∌ 2`, conjugation is not the identity on the residue field (`2i ∉ P`), its fixed field has `Q` elements with
  `Q ≡ 3 (mod 4)` (else `−1` has two square roots in the fixed field and two more outside it), and the fixed field is the residue field of
  `P ∩ 𝓞 F` (`x = (x + x̄)/2 + i·(x − x̄)/(2i)`, 2 a unit); then `usable_card_ge`. `le_localBound`: transport along `P ^ 1 = P`; the quotient is a
  finite field; `levelTarget P 1` is `normOneCayley`; apply the floor. 300 lines. What is hard: the algebra instance `𝓞 F → 𝓞 (fieldI F)`.

### 5.5 The named hypotheses, with `LEAN.md` § Assumptions' four items, and what each would take

None is an `axiom`: each is a `Prop` argument, so `ARCHITECTURE.md` § Trust gains no purchase from this wave. Draft rows for the plan's § 7.4:

| name | states | its source and read-back | model in the file | an hour, a job, or an import |
|---|---|---|---|---|
| `SpectralChain.BochnerHerglotz` (existing) | Herglotz–Bochner on a discrete abelian group, with uniqueness | Rudin, *Fourier Analysis on Groups* 1.4.3 and 1.3.6, "not quoted from a held copy" (its docstring) — **the read-back against the page is owed** | none in the kernel | a job (Riesz–Markov on the compact dual is in Mathlib; positive-definite ⟹ positive functional is the work) |
| `SpectralInputs.BochnerOn t` | a measure with `t`-continuous transform is carried by the `t`-continuous characters | Bochner on an LCA group (the same 1.4.3) with a dense image of `R`; false for some non-locally-compact group topologies (stated) | `bochnerOn_bot` | a job, after J45-N1 (b) |
| `OrderBound (unitSet ⊥) (band k) N` | the order bound at band `1/k` | ours: FS89-S0A-3 (`k = 4`, on Weil), J08-11, J08-10 | — (true or not is the hand result) | a job each, and Weil's bound an import |
| RQ₄, RQ₅ (`cl2`'s `hRQ4`, `hRQ5`) | `Θ_k(ℤ[U_ℚ]) ⊆ T + A`, `k = 4, 5` | ours: FS89-D2-T1, -D5-T2 (rows 95–97) | — | a milestone's worth (Berend's method `p`-adically) |
| `Interface.MulStable`, `Interface.NegCircle` | the two properties of `E` SP-if reads | ours: J45 §4.2 steps 2–3, on J28V-7 (`[LevitzMott1972]`) | at `Interface.trivial`: `MulStable` holds; `NegCircle` needs the circle | `∫₀^π cos(π cos θ) dθ < 0`, an hour; the arithmetic `E` itself, with J45-N1 (a) |
| `StandingFive.StandingFloor n` | the floor at `U₁₂₈` and every `Γ_Q`, `Q ≡ 3 (4)`, `Q ≥ 347` | ours: G56 | `targetFloor_zero` | below |
| `Row123Chain` (`five_le_chromaticNumber`'s `hRow123`) | `min (L(F)) 5 ≤ χ(F²)` | ours: row 123; in the kernel over named hypotheses (`SpectralChain.min_localBound_five_le_chromaticNumber`) | — | FS-101 |

**What proving the floor in Lean would take** (Keryx's ask; a candidate row for a later wave). (i) `χ(U₁₂₈) ≥ 7`: Hoffman's ratio bound for a
Cayley graph on a finite abelian group (not in the library: `ARCHITECTURE.md` has no Hoffman) and the exact spectrum — in characteristic 2 the
additive characters are `±1`-valued, so the 127 eigenvalue classes are integers, each a sum of 129 signs of traces in `𝔽_{2¹⁴}`: a certified
computation of about 16,000 field multiplications. One implementer job, no outside theorem. (ii) `χ(Γ_Q) ≥ 7` for every `Q ≥ 347`: Hoffman again
and `|λ| ≤ 2√Q` for the sums over the norm-one torus — Weil's bound, absent from Mathlib. With Weil **imported** (an `axiom` with the four items;
the paper's statement for these sums is a prior-art debt, not read here): one job. Without: the moment bounds reach only `|λ| ≤ 2Q^{3/4}`, which
gives seven from about `Q ≥ 20,736` and nothing at 347, so Weil's bound itself would have to be formalized — a separate multi-job formalization,
my estimate one million tokens, 80 % interval [0.5, 3] million.

### 5.6 Prices, and the hand-off

Re-priced from the two leaves proved here: the gluing with its field form, the equivalences and CL2 — 330 lines with their foundation, four
elaboration rounds; SP-oi — one round. The plan's table had priced none of this wave.

| job | file (no two jobs share one) | leaves | lines, about | harness tokens, about |
|---|---|---|---|---|
| I-A | `Arith/SpectralInputs`, and `CharacterColouring`'s one leaf | 9 | 1,550 | 300k |
| I-B | `Arith/StationaryRatio` | 3 | 1,900 | 350k (cut at `prob_le_ratio_mul` + `ratio_prod_le` / L1 if it runs long) |
| I-C | `Arith/StandingFive` | 9 | 1,300 | 300k |
| K10b, then I-D | the four rows not stated (J45-N1 (a)(b), -SI-J, -SI-5, -SI-C) | — | planner 150k; implementer one to two jobs | — |

I-A, I-B and I-C are independent (no file, no lemma shared) and can run at once in three trees. **The ten J45 and X25B rows are more than one
implementer wave**: cut as I-A + I-B now, K10b + I-D after. Order inside I-A: the factor trio first (it prices the rest), then `si4`, `sp_if`.

**For implementers.** No statement here may be changed; a change comes back through Keryx. `usable_card_ge`'s 347 and the period polynomial are
[tools] until `decide` has them: if either `decide` disagrees with `tools/fs131_k10_*.py`, stop and report. In `CharacterColouring`, keep `algebraQ`
local and never write a `rfl` between `unitRing ⊥` and `unitRing F` (§ 3.2). `Interface.MulStable` and `.NegCircle` are declared in
`SpectralInputs` under `SpectralChain`'s namespace (new names; `SpectralChain` itself is untouched).

### 5.7 Drafts for files this job does not write

- `plans/FS131-kernel-plan.md` § 7.4: the rows of § 5.5's table; § 7.2's wave-10 line unchanged (the four modules stand as planned).
- `data/fs131/k1/dispositions.csv` line 179, reason: "its unconditional clauses (the field, its places above 2, no usable residue field below 347);
  'so L(F) >= 7' as an implication from the finite-target floor (G56; named hypothesis StandingFloor, outside the backlog) and 'given MR,
  chi(F^2) >= 5' from that floor at five with row 123's chain (Row123Chain)".
- `LEAN.md` § Searching — Lean: § 3.2's kernel fact.
- `BIBLIOGRAPHY.md`: no new key used. Debts: Rudin 1.4.3 / 1.3.6 read against the page (for `BochnerHerglotz`, `BochnerOn`); Weil's bound for the
  norm-one torus sums, if the floor is imported.

---

# FS131-K10b — wave 10's second planning pass (stages 6–9)

*Job FS131-K10b (de Bruijn, the planner), 2026-10-06, branch `fs131-w10k` (cut from `fs131-w10` at `ace98a35`). Brief:
`data/fs131/briefs/FS131-K10b-wave10-second.md`. Stages 1–5 above are FS131-K10's and are not changed.*

**What I may change, and what I may not.** Mine: new modules under `Proofs/HadwigerNelson/Arith/`, with their lines in `Proofs.lean` and
`ARCHITECTURE.md`; a block "FS131-K10b" in `scripts/Axioms.lean`; this record from here down; `tools/fs131_k10b_*.py`; `data/fs131/k10b/`;
the report. Not mine: the wave's four existing files (`SpectralInputs` and `CharacterColouring` wait for the joining job; `StationaryRatio`
and `StandingFive` are being proved on `fs131-w10b` and `fs131-w10c` — I import them and edit nothing in them), any landed module beyond
new declarations, `main`, the gate, `BIBLIOGRAPHY.md` (drafts in the report), an `axiom` (ruled mid-job: none in this pass, § 7.3).

## Theorems this phase proved (FS131-K10b)

Kernel-checked on this branch by `./scripts/build.sh` (§ 9.1's log); the branch does not run the gate, so the axiom audit is the landing's.

- **`RatioBound.card_mul_le_of_indep`** — the ratio bound for a finite abelian group by characters: any finite `S`, `Re Σ_{s∈S} ψ(s) ≥ −m` at
  every non-trivial `ψ`, a set `I` with no difference in `S` has `|I|(|S| + m) ≤ m|G|`. [kernel on this branch]
  `Proofs/HadwigerNelson/Arith/RatioBound.lean`. Not in Mathlib or this library before (§ 7.1).
- **`RatioBound.le_chromaticNumber_of_charSum`** — its chromatic corollary, `(N − 1)m < |S| + m ⟹ N ≤ χ`. [kernel on this branch] same file.
- **`SpectralInputs.comap_factorSigma_eq`**, `comap_factorSigma_eq_of_action`, **`si4_equivariant_factorSigma`** — J45-SI-4's "equivariant"
  at the factor σ-algebra, for a map of the family with a left inverse in the family. [kernel on this branch]
  `Proofs/HadwigerNelson/Arith/FactorAction.lean`.
- The further leaves proved are listed at § 9.2, with the stage that proved each.

Outside the kernel, with a planted fault each: **`[MMST1996]` Theorem 3 is false as printed at `a = 0`** (`q = 13`, `b = (1, 5)`:
`|λ_b| = 12 > 2√13`; `tools/fs131_k10b_circle.py --fault`, [measured], and by hand, the coordinator's and mine) and holds with `a ≠ 0` on
twelve small fields, four of them prime powers [measured]; **the non-trivial spectrum of `U₁₂₈` is the eleven odd integers −19, −15, …, 21**,
so its Hoffman floor is `1 + 129/19 > 7.78`, i.e. `χ(U₁₂₈) ≥ 8` (`tools/fs131_k10b_u128.py`, exact, two routes agreeing; [tools]).

## Stage 6 — SAVED (FS131-K10b): the readback, the registered expectations, the five statements read back

### 6.1 The brief's quotations (standing rule 3)

By script (`data/fs131/k10b/logs/quotations.sh`, `grep -F` of each quoted string in the file the brief names; output
`data/fs131/k10b/logs/quotations.txt`): **twenty of twenty match** — `CLAUDE.md` § Counter-priors; inventory items 484, 485, 491, 492, 493,
494 (`plans/FS131-close-inventory.md` on `main`, where they are filed); the plan's § 7.3 heading and items 3, 4; the first pass's § 3.3
heading and its four bullets, and § 5.5's floor paragraph; `plans/FS131-E8-derivation.md`'s entry line and its handoff line; I10A's findings
2 and 3.

### 6.2 Read, and the branch as given

Read whole: the brief, `plans/STANDING-RULES.md`, `LEAN.md`, `RUNNING.md` § Building, Stages 1–5 above, the first pass's report, I10A's
record, inventory items 484–485 and 491–494, the plan's §§ 7.1–7.5, the six J45 backlog entries (`plans/LEAN-BACKLOG.md:7201–7347`) with
caution C139, `StandingFive.lean` whole, `SpectralInputs.lean` lines 1–62, 200–280, 348–377, 694–793, 1017–1245 (the foundation and the five
new statements with their proofs), then — after the registration below — `plans/FS84-SI-D-derivation.md` § 1.2, §§ 2.1–2.3 and the six
entries (lines 419–521), and `plans/FS131-E8-derivation.md` Stage 5 with its entry and control. `[MMST1996]` pp. 225–232 from the held PDF.

**The branch as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0, "all 1771 modules already
up to date", twelve `sorry` leaves — `StandingFive` 9, `StationaryRatio` 3, the other two files none
(`data/fs131/k10b/logs/build-0-as-given.log`).

### 6.3 Registered expectations (committed in `data/fs131/k10b/registered.md` at `git log`'s first K10b commit, before the derivations were read)

Y1 J45-N1 (a)(b) hides a statement defect: 0.4. Y2 J45-SI-J: 0.35. Y3 J45-SI-5: 0.5. Y4 J45-SI-C: 0.4. Y5 at least one of the four: 0.8.
Y6 the majority-vote lemma formalizes as written: 0.75; Mathlib's strong law serves as it stands: 0.4. Y7 floor (i): one implementer job,
about 500 lines, 200–250k, kernel cost under a minute; proved in this job: 0.2. Y8 floor (ii): one job, about 400 lines beside the ratio
bound, 200k; the import statable in this job: 0.6 before opening `[MMST1996]`, 0.85 after its p. 231. Y9 the import avoidable at 347 by a
moment bound: 0.1. Y10 a model of `Interface.NegCircle` at `F = ℚ` short enough to prove here: 0.35. Scored at § 9.6.

### 6.4 The five statements read back (the brief's item 2; ruling 494 (b))

| statement (in `SpectralInputs`) | the sentence of its row | read aloud | verdict |
|---|---|---|---|
| `condExpL2_mem_contVec` | J45-N2: "and `Π(E_S) = E[·\|𝒜_S]`"; Lemma N2 (`plans/FS84-SI-D-derivation.md:126–127`): "the spectral projection `Π(E_S)` is `E[· \| 𝒜_S]`" | for every `f ∈ L²(μ)` (real), Mathlib's `condExpL2` for `factorSigma T hT l` lies in `contVec T hT l` | **says what the clause says, in three parts** — with the next two it is "`condExpL2` is the orthogonal projection of `L²(μ)` onto the `l`-continuous vectors": range inside, fixes exactly them, residual orthogonal. Two recorded differences, neither a defect: (i) **real `L²`** (the row's `L²` carries complex characters; the subspace is closed under conjugation, Lemma N2's proof, so a complex vector lies in it iff its real and imaginary parts do, and every consumer — SI-1, SI-4 — reads real vectors); (ii) **`Π(E_S)` is not defined as a projection-valued measure**: it is read as the orthogonal projection onto the vectors whose spectral measure is carried by `E_S`, and that set is `contVec T hT (𝓝 0)` by `spectral_carried_iff` over `BochnerOn t` — so the clause reaches `E_S` through that named hypothesis and no other way |
| `condExpL2_eq_self_iff` | the same | `condExpL2 f = f ↔ f ∈ contVec` | as above; says no more than the row |
| `inner_sub_condExpL2_eq_zero` | the same | `⟨f − condExpL2 f, g⟩ = 0` for `g ∈ contVec` | as above |
| `condExp_comp_measurePreserving` | § 2.2 (`:142`): "set `p_j(x) := p_j(0) ∘ T_x` (a version of `P(c(x) = j \| 𝒜_S)`, `𝒜_S` being invariant)" | for `S` measure-preserving with `𝒜.comap S = 𝒜` and `g` integrable, `E[g\|𝒜] ∘ S = E[g ∘ S\|𝒜]` a.s. | **says the sentence, at the class it holds**: "invariant" is the equality `S⁻¹𝒜 = 𝒜` (for a group action the inclusion at every `x` gives it; for one map it does not, I10A's one-sided shift). `[IsProbabilityMeasure μ]` is more than the argument reads (a σ-finite trim would do); no consumer wants the wider class |
| `si4_equivariant` | J45-SI-4: "an `𝒜_S`-measurable **equivariant** proper four-colouring"; § 1.2 (`:62–63`): "`c′_{T_y ω} = c′_ω(· + y)`"; Lemma SI-4 (`:162`): "`M(x + y) = M(x) ∘ T_y` by the choice of versions" | for measure-preserving `S` with `S⁻¹𝒜 = 𝒜` and `c (S ω) x = c ω (π x)`: a.s., for every `x`, `M(S ω)(x) = M(ω)(π x)` | **says the clause almost surely, the row says it surely** ("by the choice of versions"): with Mathlib's fixed version of the conditional expectation the identity holds off a null set for each map, hence for countably many at once. For the consumer (A⁺: the push-forward of `μ` under `ω ↦ f ∘ M(ω)` is an invariant measure on colourings) almost-sure equivariance is what is read. **Not a defect; a difference to file with the row** |

**The lemma that applies it at the factor σ-algebra** (I10A's finding 3), stated at the class it holds and proved:
`comap_factorSigma_eq` — for a commuting family of measure-preserving maps and `T x' ∘ T x = id`, `(factorSigma T hT l).comap (T x) =
factorSigma T hT l`; `comap_factorSigma_eq_of_action` for an additive group action with `T 0 = id`; `si4_equivariant_factorSigma`, the
composition. The class is "a map of the family with a left inverse in the family", which is weaker than a group action and is exactly what
the second inclusion reads (`A = (T x)⁻¹((T x')⁻¹A)`). New module `Arith/FactorAction.lean`, namespace `SpectralInputs` (the joining job may
move the three into `SpectralInputs.lean`; the names are new).

**No statement says less or more than its row in a way that changes a consumer**; nothing here was a message to the coordinator.

## Stage 7 — SAVED (FS131-K10b): the floor, two rows (`debruijn-obligation-modeling`, invoked fresh, for the leaves)

Mathlib names marked ✓ were found by `grep` in the pinned source (2026-10-06); the rest are **to be confirmed by the implementer**.

### 7.1 The ratio bound — where it lives, and its class

Neither Mathlib (0 files mention Hoffman or "ratio bound") nor this library (0 declarations) holds it. It now lives in
`Arith/RatioBound.lean`, **proved**, stated once at the class its argument reads: a finite abelian group, any finite `S` (no symmetry),
`Re Σ_{s∈S} ψ(s) ≥ −m` at every non-trivial character. No adjacency matrix and no spectral theorem: orthogonality of characters
(`AddChar.sum_apply_eq_ite` ✓) gives `Σ_ψ |f̂|² λ_ψ = 0` and Parseval; `card_mul_le_of_indep`, `le_chromaticNumber_of_charSum`. Two
elaboration rounds, 170 lines. `NormOneTarget.targetFloor_of_charSum` (proved over two leaves) carries it to `StandingFive.TargetFloor`.

### 7.2 Row (i) — the target at 128, no outside theorem: `Floor128.targetFloor_eight_128 : TargetFloor 8 128`

**The statement, read back.** G56: "U₁₂₈'s Hoffman floor is 8". Lean: every field of `128²` elements with a non-trivial involution has a
level-one target needing at least 8 colours (and 7, the form `StandingFloor 7` reads). Both are proved over one leaf, the bridge
`charSum_128_ge`: in a field of `2¹⁴` elements every non-trivial additive character sums to at least `−19` over `{u : u¹²⁹ = 1}`.

**The spectrum** ([tools], `tools/fs131_k10b_u128.py`, exact; `data/fs131/k10b/logs/u128.out`): the 127 non-trivial classes take the
values `−19` (7 classes), `−15` (14), `−11` (14), `−7` (7), `−3` (21), `1` (14), `5` (7), `9` (21), `13` (8), `17` (7), `21` (7); sum of
squares `16255 = 2¹⁴ − 129`. Two routes agree (the shift register's coordinate-0 bit; the absolute trace with field multiplication). Fault
(`--fault`, a non-primitive irreducible modulus): the order check fails, exit 1. So `1 + 129/19 > 7.78`: the floor is 8, and Weil is not
needed at 128 (it would give only `−21`, i.e. 8 as well).

**The certificate's shape and its cost** (`LEAN.md` § The kernel's cost model; measured, `data/fs131/k10b/lean/U128Cost.lean`,
`logs/u128cost.log`): `𝔽₂[x]` coded in `Nat`; one pass of the shift register over the 16,383 powers of `g`, the bit added into 127 packed
8-bit counters (one `Nat` accumulator, no table built, 127 comparisons at the end) — **2.31 s in the kernel** (141 µs a step), 1.2 GB.
The whole module with its five checks (`clmul_P_qBig` on a 16,371-bit literal, `bezout4`, `bezout128`, `order_checks`, `counts_ok`)
elaborates in 6.4 s, 4.4 GB (`logs/f128-1.log`). The control `countsOk 73 = false` is in the Spec. Literals are written by
`tools/fs131_k10b_gen128.py` from `data/fs131/k10b/u128-certificate.json`; `--check` passes and `--fault` (one bit of `qBig` flipped) fails.

**The bridge, per child** (each strictly smaller; the statement each derives from in italics):
- B1 `code`: `φ_t(n) = Σ bit_i(n) tⁱ` in a commutative ring of characteristic 2. *`φ_t` turns `^^^` into `+`, `<<< 1` into `t·`, and
  `clmul fuel a b` into a product for `a < 2^fuel`* — induction on `fuel` generalizing `a b` (the recursor of `clmul`). 80 lines.
- B2 a root: at `t = X` in `k[X]`, `clmul_P_qBig` reads `φ_X(P)·φ_X(qBig) = X^(2¹⁴) + X = ∏_{a∈k}(X − a)`; a divisor of positive degree of a
  split polynomial has a root `g` (the product formula for a finite field: name to be confirmed). 60 lines.
- B3 a basis: *`φ_g(n) = 0 ∧ n < 2¹⁴ → n = 0`*. Else `𝔽₂[g]` is a subfield of `2^d` elements, `d | 14`, `d < 14`, so `g⁴ = g` or
  `g¹²⁸ = g`; `bezout4`, `bezout128` evaluated at `g` give `1 = 0`. **Hard**: the subfield's size. 120 lines.
- B4 the register: *`pass n x i acc = (step^[n] x, acc + Σ_{j<n} (bit₀(step^[j] x)) <<< (8·((i + j) mod 127)))` for `i < 127`,
  `x < 2¹⁴`*, generalizing `x i acc` (`fun_induction pass`); `φ_g(step x) = g·φ_g(x)`; `orderOf g = 16383` from `order_checks` and B3.
  **Hard**: the packed-counter read-out (no carry: counters ≤ 129 < 256). 120 lines.
- B5 the characters: `ψ₀ = (−1)^(coordinate 0)` is a non-trivial additive character; every `ψ ≠ 1` is `ψ₀(a ·)`, `a ≠ 0`
  (`AddChar.IsPrimitive.of_ne_one` ✓, `AddChar.to_mulShift_inj_of_isPrimitive` ✓, `AddChar.card_eq` ✓). 60 lines.
- B6 the sum: `{u : u¹²⁹ = 1} = {g^(127j) : j < 129}`; `Σ ψ₀(gⁱ u) = 129 − 2·c_{i mod 127} ≥ −19` by `counts_ok`. 80 lines.

**Price**: about 520 lines, one implementer job, about 300k — the file `Arith/Floor128.lean` alone.

### 7.3 Row (ii) — the planes: `targetFloor_seven_of_kloosterman`, over one named classical hypothesis

**The ruling in force** (the coordinator, mid-job, on my message): the import is Weil's bound for Kloosterman sums over a finite field;
the completion from the circle sum is formalized; **no `axiom` in this pass** — the bound is the `Prop` `StandingFive.KloostermanBound F`
and becomes an imported axiom with the four items only when a held source's page has been read back against it (the fetch is the
coordinator's: `[Weil1948]` first, then a source stating it at prime powers).

**The exact statement the hypothesis carries** (`Arith/FloorPlanes.lean`):
`KloostermanBound F : Prop := ∀ ψ : AddChar F ℂ, ψ ≠ 1 → ∀ a b : F, a ≠ 0 → b ≠ 0 → ‖∑ x : Fˣ, ψ (a * x + b * x⁻¹)‖ ≤ 2 * √(card F)`,
for a finite field `F` with decidable equality (the instance is what makes `Fˣ` a `Fintype`; it carries no content).
**Which fields it must cover**: `standingFloor_seven` asks it at every finite field with `q ≡ 3 (mod 4)` and `q ≥ 347` elements — so at
**prime powers** `p^f`, `p ≡ 3 (mod 4)`, `f` odd, not only primes (the standing field's own usable residue fields are `p ≥ 347` and
`p⁷ ≥ 11⁷`, but `StandingFloor` quantifies over every `Q`). The row's theorem is stated at the class the argument reads, `Q ≥ 98`. Model:
`kloostermanBound_of_card_le_five` (proved: `q − 1 ≤ 2√q` for `q ≤ 5`), instantiated at `ZMod 3`.

**The read-back of the row.** G56: "every usable plane … refuses six by Weil from 98". Lean, `targetFloor_seven_of_kloosterman`: for
`Q ≡ 3 (mod 4)`, `Q ≥ 98`, if Weil's bound holds at the fields of `Q` elements then every field of `Q²` elements with a non-trivial
involution has a level-one target needing 7 colours. Differences: empty of content at a `Q` that is no prime power (no field of `Q²`
elements); the threshold 98 is sharp for the argument (Spec: `98 < 10√97`).

**The fallback (α), written down.** `[MMST1996]` (held; pp. 225–232 read by me from the PDF, 2026-10-06). p. 225: "Let 𝔽_q be a finite
field with q = p^r elements, where p is an odd prime"; formula (2), `d(x, y) = Σ(x_j − y_j)²`. p. 226, Definition: "Given a ∈ 𝔽_q, the
Euclidean graph … E_q(n, a) … Two vertices are adjacent iff d(x, y) = a"; p. 227: "when a = 0 we are allowing the graph to have loops".
p. 230: `e(u) = exp{2πi Tr(u)/p}`, `e_b(x) = e(ᵗb·x)` (6); Proposition 2: "For b ∈ 𝔽_qⁿ, e_b is an eigenfunction of A_a corresponding to
the eigenvalue λ_b = Σ_{d(s,0)=a} e_b(s)." p. 231, **Theorem 3**: "Let λ_b denote the eigenvalue of the adjacency operator A_a of the graph
E_q(n,a) corresponding to the eigenfunction e_b(x) defined in (6). Then |λ_b| ≤ 2q^{(n−1)/2}, for b ≠ 0 in 𝔽_qⁿ. Moreover, the eigenvalues
λ_b, for b ≠ 0, are expressed as generalized Kloosterman sums in Eq. (11)." Its proof (pp. 231–232) is a sketch: (7)–(9) complete the
square, (11) `λ_{2b} = (1/q)·G₁ⁿ·K(χⁿ | a, d(b,0))`, (13) "The Kloosterman sum is bounded as in [42, pp. 386–389] (or see [34], or [23,
Theorem 16])" — Weil's Collected Works, i.e. `[Weil1948]`, and `[LiFeng1992]`; neither held. As an axiom (α) would read: `F` of odd
characteristic `p`, `a ≠ 0`, `b ≠ 0 : F × F`: `‖Σ_{s₁²+s₂²=a} e(b₁s₁ + b₂s₂)‖ ≤ 2√|F|`. It is the fallback if no held page states the
Kloosterman bound at prime powers; in Lean it is `circle_sum_le` with `hK` discharged.

**Statement defect in the printed theorem** (draft note for `BIBLIOGRAPHY.md`'s `[MMST1996]` row, after "…used with Weil's bound."):
"**Theorem 3 (p. 231) is false as printed at `a = 0`**: it carries no restriction on `a`, the paper allows `a = 0` (p. 227), and at `n = 2`,
`−1` a square, `b ≠ 0` isotropic, `λ_b = q − 1 > 2√q` (`q = 13`, `b = (1, 5)`: 12 > 7.22; its inequality (13) fails when `a = d(b,0) = 0`).
It holds with `a ≠ 0` on `𝔽_3 … 𝔽_23`, `𝔽_9`, `𝔽_25`, `𝔽_27`, `𝔽_49` [measured, `tools/fs131_k10b_circle.py`; `--fault` finds the
violation at `q = 9, 13, 17, 25, 49`]. Read 2026-10-06 (FS131-K10b): pp. 225–232." The row's status moves from "held, not read" to
"read: §§ 2–3 (pp. 225–232)". The identity `λ(c) = −K(1, c/4)` (FS-20's item R4) is `circle_sum_eq_kloosterman` once proved.

**Result: no elementary bound replaces the import at 347.** The fourth moment, with the multiplicity `Q + 1` of each class, gives
`|λ| ≤ (2Q³ − 2Q² − 3Q − 1)^{1/4} < (2Q³)^{1/4}` (two circles meet in at most two points, so `E₄ ≤ 3d² − 2d`); seven needs
`|λ| < (Q + 1)/5`, which this reaches only from about `Q ≥ 1250` (at 347 it gives 95.6 against 69.6). The first pass's `2Q^{3/4}` is this
bound without the multiplicity. The sixth moment would suffice at 347 (`≈ 1.31·Q^{2/3} = 64.6`) but its evaluation is not elementary
(a point count on a threefold). [hand, one mind]

**The leaves, per child:**
- P1 `involution_eq_pow` (`NormOneTarget`): the fixed field `k₀` has `[k : k₀] = 2` (`FixedPoints.finrank_eq_card` ✓ for the group
  `{1, σ}`), so `Q` elements; *`x ^ Q` is a root of `(T − x)(T − σ x) ∈ k₀[T]`*, and `x ^ Q = x` only on `k₀`. 120 lines. **Hard**: the
  group action's instances.
- P2 `card_normOne`: `kˣ` cyclic of order `(Q − 1)(Q + 1)` (`IsCyclic.card_powMonoidHom_ker` ✓). 50 lines.
- P3 `sum_quadratic_eq`: `r y² + c y = r(y + c/(2r))² − c²/(4r)`, re-index, then `Σ_y ψ(r y²) = Σ_x (1 + χ(x)) ψ(r x) = χ(r)·G`
  (`quadraticChar_card_sqrts` ✓, `gaussSum_mulShift` ✓). 80 lines.
- P4 `circle_sum_eq_kloosterman`: *`q·LHS = Σ_r Σ_s ψ(r(s₁² + s₂² − a) + b·s)`* (`AddChar.sum_mulShift` ✓); `r = 0` gives 0; `r ≠ 0` is two
  P3's and `G² = χ(−1) q` (`gaussSum_sq` ✓, `quadraticChar_sq_one` ✓). 120 lines. **Hard**: the two re-indexings.
- P5 `circle_sum_le`: P4 and `hK`; when `b₁² + b₂² = 0` the sum is `Σ_{x≠0} ψ(−a x) = −1`. 40 lines.
- P6 `normOne_charSum_ge`: `k₀ = {x : x ^ Q = x}` has `Q` elements; `−1` is a square in `k`, not in `k₀`
  (`FiniteField.isSquare_neg_one_iff` ✓), so `k = k₀ ⊕ k₀·ι`, `u ^ (Q + 1) = u₁² + u₂²`; a non-trivial character of `k` is
  `ψ₀(b₁u₁ + b₂u₂)`, `b ≠ 0` (counting, `AddChar.card_eq` ✓); re-index; P5 at `a = 1`. 200 lines. **Hard**: the coordinates.

**Price**: about 610 lines; one implementer job, about 300k — `Arith/NormOneTarget.lean` and `Arith/FloorPlanes.lean` together.

### 7.4 `StandingFloor 7` from the two (`Arith/TargetFloors.lean`, compositions, proved over the leaves)

`standingFloor_seven`, `standingFloor_five`, `seven_le_localBound_of_kloosterman`: over
`∀ F` finite field, `card F % 4 = 3 → 347 ≤ card F → KloostermanBound F`. At the join `StandingFive.seven_le_localBound` and
`five_le_chromaticNumber` are applied to them and lose the hypothesis `StandingFloor`.

**Draft for `ARCHITECTURE.md` § Trust** (for the day the bound is an axiom, not before): "`StandingFive.kloosterman_bound` — Weil's bound
for Kloosterman sums over a finite field, `|Σ_{x≠0} ψ(ax + b/x)| ≤ 2√q` for `ψ ≠ 1`, `ab ≠ 0` ([source key, section, page]); read back
against the page in `plans/FS131-w10-kernel-plan.md` § 7.3; model `kloostermanBound_of_card_le_five` at `ZMod 3`; rests on it:
`standingFloor_seven`, `seven_le_localBound_of_kloosterman` and what the join derives from them."

## Stage 8 — SAVED (FS131-K10b): the four rows, the majority vote, the model, and the two additions (`debruijn-domain-modeling`, invoked fresh)

### 8.1 J45-SI-J — stated at a wider class, by a route with no spectral theory (`Arith/ProductFactor.lean`)

**The row**: "the `E_S`-factor of an independent product of a finite translation system, a Bernoulli process and `c₂` is `σ(Φ) ∨ 𝒜_S(c₂)`".
**Lean, read aloud** (`contVec_prod_eq`, the leaf): for a finite discrete system whose maps are eventually the identity along a filter
`l`, any second system, and a third whose σ-algebra is generated by independent coordinates indexed by `R` that the maps shift, if `l` is
not eventually inside a finite set, the `l`-continuous vectors of the product are the `L²` vectors measurable for
`prodFactorSigma = σ(first coordinate) ⊔ (second coordinate)⁻¹(𝒜_l)`. **Differences**: any filter (the row: `𝓝 0` for `τ′_S`); "is" is
equality of the two `L²` spaces, i.e. of the σ-algebras up to null sets (with `contVec_eq_lpMeas`); real `L²`; identical distribution not
read. Reported and adopted (inventory item 503).

**What the instance at `E_S` discharges, and from where** (the coordinator's ask): `h₁` (eventually the identity) — the kernel of `R →
O/𝔓` has finite index, hence is open for `τ′_S` *by the definition of `τ′_S`* (its profinite component); no theorem. `hl` (not eventually
finite) — "`τ′_S` is T₁ and not discrete": T₁ from `R ↪ L ⊗ ℝ` (definition), non-discrete from weak approximation on the norm-one torus,
**which is J45-N1 (b)'s content**. So **the instance of SI-J at `E_S` rests on N1 (b)**, not on N1 (c) as the row's route did; N1 (a)(b)
is not stated in this pass (§ 8.4), so neither is the instance — the join and K10c see this dependency here.

**Downstream readers of SI-J** (the coordinator's ask): J45-SI-5 (c) and (d) read `𝒜_S(c) ⊆ σ(Φ) ∨ 𝒜_S(c₂)` — the σ-algebra form, which
is `contVec_prod_eq` with `comap_factorSigma_le` (proved here: the factor of a factor system); SI-5 (c)'s "its `L²` is spanned by
eigenfunctions of torsion characters" becomes "a finite-valued process moved through a finite quotient is eventually fixed along `l`"
(`mem_factorSets_iff`), also filter-form. J45-SI-C reads the same inclusion with no `c₂`, **and its last clause, `σ_μ(R̂ ∖ E) > 0`, is the
one place a row reads the spectral form** ("spectral measure `≪ Haar`, which gives `E` measure 0 (N1 (c))"): in the kernel's vocabulary
it is "the centred noise `1[c(0) = 3] − p₃(0)` is a non-zero vector orthogonal to `L²(𝒜_S)` for every `S`", and the literal clause
follows from that only through a spectral projection the library does not define. K10c states SI-C's clause in the orthogonality form and
says so.

**Children**: C1 the splitting `F = F₀ + F₁` by the conditional expectation on the first two coordinates, preserved by the maps; C2
cylinders on finite coordinate sets are dense in the `L²₀` part (**hard**: a density over a directed family of σ-algebras); C3 *shifted
cylinders on disjoint coordinate sets are orthogonal when centred* (`iIndepFun.indepFun_finset` ✓); C4 `‖V_y F′ − F′‖ = √2‖F′‖`
frequently, so `F₁ = 0`; C5 the fibre lemma on a finite `Ω₁`; C6 measurability for `prodFactorSigma` is fibrewise (**hard**). About 500
lines, one job with § 8.2.

### 8.2 The deriver's lemma FS131-E8-SI5C (`Arith/MajorityVote.lean`, `ae_eq_measurable_of_majority`, the leaf)

Stated at the class its argument reads, wider than the entry's in three ways (an infinite index set; probabilities **at most** `p < 1/2`;
"almost surely" one index at a time), reported here as a generalization. **Attacked, it stands**: no step fails to formalize as written;
the one care is that the entry's "strict majority" needs `2·#{errors among n} < n`, which Chebyshev gives with probability
`≥ 1 − 1/(4n(1/2 − p)²)` for pairwise uncorrelated indicators of probability `≤ p`. **Mathlib's strong law at the pin**
(`ProbabilityTheory.strong_law_ae` ✓, Etemadi's: pairwise independent **identically distributed**) serves the entry's class (equal
probabilities) and not the wider one, so **the Chebyshev route is written out**: `ProbabilityTheory.meas_ge_le_variance_div_sq` ✓,
`ProbabilityTheory.IndepFun.variance_sum` ✓, then a subsequence converging almost surely
(`TendstoInMeasure.exists_seq_tendsto_ae` ✓) in place of the closedness of `L²(σ(c))`. Children: M1 an injective sequence in `I`; M2 the
Chebyshev bound; M3 `Maj_n` is measurable for `⨆ x, comap (c x)`; M4 the limit. About 150 lines. **Step (c) over it**: `G = γ_Φ(ρ)` for
each of the finitely many residue classes `ρ`, `E x = {ε(x) = 1}`, `p = 1/3` — stated with SI-5 (§ 8.3).

### 8.3 J45-SI-C and J45-SI-5 — the finite facts proved; the measure-theoretic statements not stated

**Proved** (`Arith/GapSeven.lean`, each a `decide +kernel` against `finitePlane 7`; 16 s, 5.3 GB for the module): C9's `γ = ⌊4θ⌋` is
proper (`gamma_proper`); the gapped vertices are exactly those with `7θ ∈ {0, 5}` (`gapped_iff`), all missing colour 3
(`gapped_eq_three`); `Z̄ = {θ = 0}` is the set of gapped vertices of colour 0 (`zbar_iff`) and is independent (`zbar_indep`); the supports
are disjoint on every edge (`supp_disjoint`); (G2)'s adjacent gapped pair exists (`exists_adjacent_gapped`); 392 directed edges, 28
between gapped vertices (`card_edges`). **These confirm `tools/crunch_j45_gap7.py`'s items (1)–(5) in the kernel**: SI-C's grade loses
its tools half, and (G2) at 7 is a theorem about the plane `Γ₇`.

**Not stated — where K10c takes over.** Both rows are statements about translation-invariant random proper four-colourings of
`Cay(R, U)`, and need, beyond what stands: (i) the shift system on `R → Fin 4` and "`μ` over `F`" (`SpectralChain.InvariantColouring`
is the candidate); (ii) "equality at `S`" as `si4`'s `hdisj` at `𝒜 = factorSigma shift (𝓝[τ′_S] 0)` — which needs `τ′_S`, § 8.4; a
statement **parametrized by an arbitrary filter `l`** in place of `τ′_S` is available today and is the form I recommend (SI-5's argument
reads of `l` exactly SI-J's two hypotheses and `U`-invariance); (iii) the reduction `R → O/𝔓 ≅` the residue plane (wave 2's
`exists_hom_finitePlane_of_card`); (iv) the noisy colouring as a factor of `prodMap₃` (`comap_factorSigma_le`). Dispositions revised:
SI-5 a theorem over SI-J, the majority vote and (G2) as a hypothesis on a finite coloured graph (met at 7 by `GapSeven`); SI-C a theorem
over SI-J and `GapSeven`, its last clause in the orthogonality form (§ 8.1). Price: about 700 lines for the two, one job after K10c's
statements.

### 8.4 J45-N1 (a), (b) — not stated

Stating `τ′_S` needs the `S`-adic completions of `L` at split places against `unitRing F ⊆ ℂ`
(`IsDedekindDomain.HeightOneSpectrum.adicCompletion` over `𝓞 (fieldI F)`), the profinite topology on `R`, and the three continuity
groups; the first pass's list stands. Two things this pass adds: **what the wave's other rows read of N1 (a)(b) is two facts about the
filter `𝓝[τ′_S] 0`** — every subgroup of finite index is a neighbourhood of 0, and it is not eventually finite (§ 8.1) — so a K10c that
states those two as the interface (`contChars` and `BochnerOn` are already stated over an arbitrary topology) lets SI-J's instance, SI-5
and SI-C land without the adic foundation; and (a)'s "`T`" is safe from the C109 defect — the `τ′_S`-continuous archimedean characters are
`Hom_ℝ(L ⊗ ℝ, ℝ) mod 1`, the erratum's `A`.

### 8.5 A model of `Interface.NegCircle` (`Arith/NegCircleModel.lean`; two leaves, not proved)

**The cheaper candidate, checked on paper: it works.** Over `F = ℚ`, the valuation subring of `ℚ(i)` at `1 + i` is fixed by conjugation
(the prime is ramified), so it contains `unitRing ⊥` (`UnitRing.normOne_subset_valuationSubring`, in the library); its residue field has
two elements, and `u·ū = 1` forces `u ↦ 1`. So `χ₀(r) = (−1)^(r mod (1+i))` is a character with `χ₀(u·) = χ₀` for every unit vector and
`χ₀(1) = −1`; the point mass at `χ₀` is a rotation-invariant probability with `∫ Re χ(1) = −1 < 0`; at `Interface.trivial` the carrier
clause holds with `S = univ` (`E = ∅`). No analysis, no Bessel value, margin 1 instead of 0.04. Leaves: `exists_parityHom` (about 150
lines: the `(1 + i)`-adic valuation subring and its residue field; **the library holds no `unitRing ⊥ →+* ZMod 2` today** — searched) and
`negCircle_trivial_bot` (60 lines: `Measure.dirac`, `Measure.map_dirac`, `integral_dirac`). **Until they land `sp_if` stays an open gate
item under the inhabitant rule.** The same character is Woodall's two-colouring of `ℚ²`, so row 63's modules may shorten the first leaf.

### 8.6 The second implementer's statements read back (the coordinator's addition, ruling 507 (c); statements read on `fs131-w10b` at `423cd8e8`, proofs not read)

| statement | sentence | verdict |
|---|---|---|
| `StationarySet.prob_le_ratio_mul_of_symm` | X25B-P: "`P(0 ∈ A) ≤ r(G,T)·P(0 ∈ N[A])`" | says it: `W.P W.B ≤ ratio ν * W.P (W.B ∪ W.nbhd ν)`, `ν` σ-finite and symmetric, no `MeasurableAdd₂` |
| `StationarySet.prob_le_max_ratio`, `ratio_prod_le_of_symm` | X25B-PZ: "at most the larger factor's" | say it, per stationary set and as a supremum; both symmetries are hypotheses and its finding 5 (`ℤ/3 × ℤ/5`) shows they bite — **a hypothesis the row's words do not carry** ("LCA Cayley graphs" are symmetric by convention; no defect) |
| `StationarySet.prob_le_ratio_level_add`, `ratio_prod_le_iSup_levels_of_shrink` | X25B-L1: "at most the supremum over its finite levels" | say it **for the levels pulled back to `X × Y`** (`νY ∗ cosetAverage (K k)`), any family of open subgroups entering every neighbourhood of 0; the comparison with the graphs on `Y/K_k` is § 8.7's row |
| `tendsto_measure_symmDiff_shift` | "martingale convergence on the fibres" (the entry), as the first pass re-read it | says the replacement: `P(T_u⁻¹C ∆ C) → 0` as `u → 0`, for a compact second-countable group |
| `StationarySet.ae_majority`, `measure_le_majority_add`, `lintegral_prod_conv_cosetAverage` | "fibre shares above `1/2` form an a.e.-independent set" and its two companions | say them: the pigeonhole on `{ω : κ{z : T_{e z}ω ∈ D} > 1/2}`; `P(D) ≤ P(majority) + ∫ P(T⁻¹D ∆ D) dκ`; a `K`-invariant integrand does not see the smoothing |
| models `StationarySet.parity` (`parity_aeIndependent`, `parity_prob`), `ratio_dirac_one_zmod_two`, `cantorLevel` (`exists_cantorLevel_subset`) | the inhabitant rule | `ratio (δ₁ on ZMod 2) = 1/2` evaluates the definition at `K₂` and would fail if `ratio` drifted; `cantorLevel` is L1's hypothesis at an infinite profinite group. Not read: `cantorLevel_antitone`, the Spec instantiations |

**None says less or more than its sentence beyond the pulled-back level**, by statement; the proofs are the kernel's.

### 8.7 The new row (ruling 507 (b)): X25B-L1's levels against the finite graphs — disposition, not stated

It belongs to the wave: the row's words are about the graphs on `Y/K_k` and nothing states the comparison. **Shape**: for `Y` as in L1,
`K` an open subgroup, `νY` finite and symmetric with `νY(K) = 0`, and `S̄ = {c ∈ Y ⧸ K : νY(π⁻¹c) > 0}`:
`ratio (νY ∗ cosetAverage K) ≤ (Cay(Y ⧸ K, S̄)).indepNum / |Y ⧸ K|` (`SimpleGraph.indepNum` is Mathlib's; with `νY(K) > 0` the left side
is 0 and the finite graph would have a loop). With X25B-PZ applied first it bounds the level in the product. Leaves (the implementer's
route, its finding 4, which I read and find sound on paper): L-a almost surely the cosets of positive share form an `S̄`-independent set;
L-b `P(B) = E[share of the origin's coset] ≤ P(0̄ ∈ I_ω)`; L-c stationarity makes `P(c ∈ I_ω)` constant in `c`, so it is
`E|I_ω|/|Y ⧸ K| ≤ α/|Y ⧸ K|`. About 300 lines. **Left**: the Lean statement (K10c; my budget ended here), and the form X25B-T's chain
reads, which I did not open.

## Stage 9 — SAVED (FS131-K10b): the skeleton's evidence, the prices, the hand-off

### 9.1 Evidence

- **Build**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0, 454 of 454 batches
  (`data/fs131/k10b/logs/build-2-skeleton.log`); every warning is `declaration uses 'sorry'`: this pass's eleven (`NormOneTarget` 2,
  `FloorPlanes` 4, `Floor128` 1, `ProductFactor` 1, `MajorityVote` 1, `NegCircleModel` 2) and the twelve of the two files proved on other
  branches (`StandingFive` 9, `StationaryRatio` 3). An earlier build failed on `FloorPlanes` (a missing `Fintype Fˣ` instance and a missing
  import), `logs/build-1-floor.log`: the control that the build reads these files.
- `tools/check_architecture.py`: PASS (`logs/arch-final.log`). `./scripts/dupnames.sh`: exit 1 on the one pair known before this job,
  `Plane.conj_e` (`Plane/Chord`, `Plane/SixFragment`); nothing of this pass's ten modules is listed (`logs/dupnames.log`).
- No `native_decide`, no `axiom` in the ten modules (grep). `scripts/Axioms.lean` block "FS131-K10b": 25 sorry-free declarations for
  the landing's audit; nothing under IMPORTED.
- Tools, each with its fault watched to fire: `fs131_k10b_circle.py` (`--fault`: exit 1, five violations), `fs131_k10b_u128.py`
  (`--fault`: exit 1), `fs131_k10b_gen128.py` (`--fault`: exit 1).

### 9.2 Leaves proved in this pass (each [kernel on this branch], by the build above)

Stage 6: `RatioBound.card_mul_le_of_indep`, `le_chromaticNumber_of_charSum` (with `fourier_sq_mul_charSum`,
`sum_fourier_sq_mul_charSum_eq_zero`, `sum_fourier_sq`); `comap_factorSigma_eq`, `comap_factorSigma_eq_of_action`,
`si4_equivariant_factorSigma`. Stage 7: `kloostermanBound_of_card_le_five`; the certificate `clmul_P_qBig`, `bezout4`, `bezout128`,
`order_checks`, `counts_ok`; `targetFloor_mono`, `standingFloor_mono`. Stage 8: `preimage_mem_factorSets`, `comap_factorSigma_le`; the
eight theorems of `GapSeven`. **Proved over open leaves** (not in the Axioms block): `targetFloor_of_charSum`,
`targetFloor_seven_of_kloosterman`, `targetFloor_eight_128`, `targetFloor_seven_128`, `standingFloor_seven`, `standingFloor_five`,
`seven_le_localBound_of_kloosterman`.

### 9.3 Prices (re-priced from this pass's proved leaves: the ratio bound, 170 lines in two rounds; `GapSeven`, eight facts in one)

| job | files (no two jobs share one) | leaves | lines, about | harness tokens, about |
|---|---|---|---|---|
| I-D1 | `Arith/NormOneTarget`, `Arith/FloorPlanes` | 6 | 610 | 300k |
| I-D2 | `Arith/Floor128` | 1 (six children) | 520 | 300k |
| I-D3 | `Arith/ProductFactor`, `Arith/MajorityVote`, `Arith/NegCircleModel` | 4 | 860 | 350k (cut `NegCircleModel` off if it runs long) |
| K10c, then I-D4 | J45-SI-5, J45-SI-C (measure part), J45-N1 (a)(b) or its two-fact interface, the X25B level row | — | planner 150k; one implementer job | — |

I-D1, I-D2, I-D3 are independent: no file and no lemma shared (`Floor128`'s leaf does not read `NormOneTarget`'s leaves; the shared
`RatioBound` and `targetFloor_of_charSum` are already proved). `Arith/TargetFloors`, `Arith/GapSeven`, `Arith/FactorAction`,
`Arith/RatioBound` have no open leaf.

### 9.4 For the joining job

- Merge order is free (new modules only; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` are append-only conflicts).
  **Run `./scripts/dupnames.sh` on the joined tree before the axiom audit.** This pass declares in three existing namespaces from new
  modules: `SpectralInputs` (`comap_factorSigma_eq`, `comap_factorSigma_eq_of_action`, `si4_equivariant_factorSigma`,
  `preimage_mem_factorSets`, `comap_factorSigma_le`, `prodMap₃`, `measurePreserving_prodMap₃`, `prodFactorSigma`, `contVec_prod_eq`,
  `exists_parityHom`, `negCircle_trivial_bot`) and `StandingFive` (`involution_eq_pow`, `card_normOne`, `targetFloor_of_charSum`,
  `KloostermanBound`, `kloostermanBound_of_card_le_five`, `sum_quadratic_eq`, `circle_sum_eq_kloosterman`, `circle_sum_le`,
  `normOne_charSum_ge`, `targetFloor_seven_of_kloosterman`, `targetFloor_mono`, `standingFloor_mono`, `standingFloor_seven`,
  `standingFloor_five`, `seven_le_localBound_of_kloosterman`) — none may be re-declared by the branches proving those files.
- **Drop the two unread instance arguments** (ruling 494 (a)): `[Countable (unitRing F)]` from `sp_if`, `[IsProbabilityMeasure μ]` from
  `spectral_carried_iff`. **Drop the seven arguments `StationaryRatio`'s proofs do not read**, each row keeping its name on the general
  statement, and track `StationarySet` as a carrier of the vacuity scan with its three inhabitants (ruling 507 (a), (d)).
- Apply `StandingFive.seven_le_localBound` and `five_le_chromaticNumber` to `standingFloor_seven` / `standingFloor_five`
  (§ 7.4), so the wave's statements carry `KloostermanBound` in place of `StandingFloor`.
- `sp_if` is an open gate item until `negCircle_trivial_bot` lands; `contVec_prod_eq`'s docstring names its model and does not build it.
- Nothing with a `sorry` reaches `main`.

### 9.5 Drafts for files this job does not write

- `BIBLIOGRAPHY.md`, `[MMST1996]`: § 7.3's note, and the status "read: pp. 225–232 (FS131-K10b)". `[Weil1948]`: unchanged until fetched;
  its row's "`≤ 2√p`" is the prime case and the floor needs prime powers.
- `plans/FS131-kernel-plan.md` § 7.4, new rows: `KloostermanBound` (states: Weil's bound at a finite field; used: `standingFloor_seven`;
  path: an imported axiom with the four items once a page is read back, or `circle_sum_le`'s fallback (α)); `StandingFloor` leaves the
  table at the join. § 7.2, wave 10: the ten new modules of § 9.3.
- `plans/LEAN-BACKLOG.md`: J45-SI-J's state — stated at a wider class (`contVec_prod_eq`), its route's inputs "Bernoulli shifts have
  Lebesgue spectrum; spectral measures of independent tensor products convolve; J45-N1 (c)" no longer read; J45-SI-C — finite facts
  [kernel on branch], `GapSeven`; J45-SI-4 — the equivariance clause holds almost surely, and at the factor σ-algebra for a map with a
  left inverse in the family.
- `LEDGER.md`, G56's row: "`U₁₂₈`: non-trivial spectrum `−19 … 21` exactly [tools]; certificate kernel-checked on `fs131-w10k`."

### 9.6 Registered expectations, scored

Y1 (N1 (a)(b) hides a defect, 0.4): **not scored** — not stated. Y2 (SI-J, 0.35): **no defect; a generalization instead**. Y3 (SI-5,
0.5), Y4 (SI-C, 0.4): **not scored** — measure parts not stated; SI-C's finite facts hold as filed. Y5 (at least one of the four, 0.8):
**not met in what was stated** (one of four stated). Y6 (the majority vote formalizes as written, 0.75): **yes on paper**; (the strong law
serves as it stands, 0.4): **yes for the entry's class, no for the class stated**. Y7 (floor (i): one job, 500 lines, 200–250k, kernel
under a minute; proved here 0.2): the certificate is 2.3 s; the bridge re-priced at 520 lines and 300k; **not proved here**. Y8 (floor
(ii) one job; the import statable here, 0.6 then 0.85): **no — ruled a named hypothesis**, because the held paper's theorem is false as
printed in a case; the registration did not price that. Y9 (avoidable at 347, 0.1): **no**, with the bound's constant computed. Y10
(`NegCircle` model proved here, 0.35): **no**; the candidate checks on paper.
