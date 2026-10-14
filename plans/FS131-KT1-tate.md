# FS131-KT1 — the five-colour chain: `TateModel F` typed, and lane T (Tate's self-duality in the form the model reads) planned

*de Bruijn, the planner (the seventh on this chain). Brief: `data/fs131/briefs/FS131-KT1-tate.md` (on `main`). Branch `fs131-wkt`,
cut from `fs131-wk9` at `aee998a46`, in the worktree `.claude/worktrees/fs131-wch`. Working files: `data/fs131/kt1/`.*

## Theorems this phase proved

A planning job; the theorems below are a few lines each, proved where the interface or the measurement needed them.
- `Rigidity.TateModel.ker_eq` — `ker π = ι(Λ)` over any Tate model — [kernel], the standard three — `Rigidity/TateModel`.
- `Rigidity.TateModel.mem_TA` — `π(L + L_∞) ⊆ TA F` over any Tate model — [kernel] over one leaf (`sorryAx` through
  `toSAdele_mem_torsionChars`) — `Rigidity/TateModel`.
- `Rigidity.exists_tateModel` — the assembly, one field per fact — [kernel] over lane T's leaves — `Rigidity/TateExists`.
- (Definitions with their proof fields closed: `toSplitAdele`, `TateModel.Λ`, `tatePi`.)
- **In scratch, not in the library** (elaborated at the pin, not landed): form G's `G1b_crt`, `G1_approx`, `G2_trace_int`
  (`data/fs131/kt1/scratch/FormG.lean`, closed); form L's `L1map`, `L1tower`, `L1continuous`, `L2decomp`
  (`data/fs131/kt1/scratch/FormL.lean`, closed; `L2char` open). The first three are lane T-L's route copies.

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`data/fs131/kt1/readback.py` reads every block of the brief that begins with `> ` and ends with `> — source: <path>`, and checks
its text, character for character, as a substring of the source on `main`. **Six quotations, six matches** (`logs/readback.log`):
W2 (`data/fs131/REQUEST-2026-10-13.md`), NF2-LEAF-21 and the two dated lines (`data/fs131/claims-NF2.md`), inventory items 791
and 775 (`plans/FS131-close-inventory.md`). **The control**: `--plant` changes one character of the first quotation
("formalized" → "formalised"); the run reports exactly that quotation as `MISMATCH` and the others `MATCH`
(`logs/readback-plant.log`, exit 0 as the plant mode requires). No finding about the brief.

### 1.2 The five facts, restated from FS131-KN9 § 4.1, each with where M8b reads it

KN9's table has seven rows; its interface paragraph names five of them as the structure's fields, and the other two (finite
`U`-orbits on `L/Λ`; `φ_t` a Borel isomorphism onto its image) are consequences of fields 3 and 4 that M8b-4 proves. The five,
in KN9's words, with the steps of `plans/FS100-X01D-derivation.md` that read each (X01D § 3, ll. 203–311, read in full here):

| # | the fact (KN9 § 4.1) | where M8b reads it (X01D) |
|---|---|---|
| 1 | "`π` with continuity and equivariance": `π : W → R̂` a continuous homomorphism, `π(u a) = rot u (π a)` | everywhere: Lemma 3.1′ (ii) (`u*`-images of a cell's lifts, l. 233), Step 3 (`μ(vB) = μ(B)`, `vB = π(v(x̃ + Q))`, l. 254), Step 6 (iii) (`u·φ_t(a) = φ_t(ua)`, l. 295), Step 7 (`g^k` on the shells, l. 304) |
| 2 | "surjectivity" | the lifts `x̃` of Lemma 3.1′ ("every lift", l. 228) and of Steps 3–5 ("a fixed lift", l. 254) |
| 3 | "`Λ` with `ker π = ι '' Λ`, `R`-stability and the two-sided bound by `O′`" (`d·O′ ⊆ Λ ⊆ d⁻¹·O′`) | Lemma PF (`C_Λ < ∞`, the upper bound, l. 205); Lemma 3.1′ (ii) (`y′ ∈ Λ`, l. 234); Step 3 (`r ∈ Λ`, l. 256); Step 4 (`z ∈ Λ` since `Λ` is an `R`-module, l. 271); Step 6 (i) (`W_{v*} ∩ Λ = 0`, from `Λ ⊆ L`, l. 291) and (ii) (finite orbits, the lower bound) |
| 4 | "`W = K + ι(O′)` with `K` compact" | in lane T: the surjectivity (`π(W)` closed); in M8b: Lemma 3.1′ (i) (`π(Q(ε))` open, so finitely many translates cover `R̂`, l. 230) — openness from the open mapping theorem, `W` being σ-compact as `⋃_{x ∈ O′} (K + ι x)` |
| 5 | "`TA F = π '' (ι L + L_∞)`" | the conclusion: Step 7 ("`μ` is carried by `⋃_t π(t + L_∞) = T + A`", l. 306) |

Two observations for stage 2, both from this reading:
- **M8b reads one inclusion of fact 5**: Step 7 concludes that `μ` is carried by `π(ι L + L_∞)`, and `ZeroEntropyCarried` asks
  `ρ (TA F)ᶜ = 0`; so it needs `π '' (ι L + L_∞) ⊆ TA F` only. The other inclusion is the bridge "from the kernel's
  `Rigidity.TA` to the derivation's `T + A`" (KN8 § Stage 4) that no consumer reads.
- **Fact 3's lower bound is read twice, and its form matters to both readers.** Step 6 (ii)'s finite orbits need `O′/nO′`
  finite with either form; fact 4's use for surjectivity and openness needs `ι(O′) ⊆ ker π`, which `d·O′ ⊆ Λ` gives only through
  the finiteness of `O′/dO′`. For the standard character `ψ(ι x) = 1` for every `x ∈ O′` (X01D l. 120: `R^∨ = 𝔡⁻¹R` up to the
  choice of `ψ`, and `𝔡⁻¹ ⊇ 𝓞`), so `O′ ⊆ Λ` holds: the sharper lower bound with `d = 1`. Stage 2 decides the form.

## Stage 2 — SAVED: the interface typed (`Rigidity/TateModel`, `Rigidity/TateExists`)

Two new modules, with their lines in `Proofs.lean` and `ARCHITECTURE.md` § 3. Elaborated under `lake env lean` with the
lakefile's two options passed by hand (`logs/TateModel-5.log`, `logs/TateExists-1.log`: exit 0, `sorry` warnings only, at the
four leaves of `TateModel` and the one of `TateExists`); the build is § 2.6. The kernel's print of every statement is
`logs/KernelSigs2.log` (probe `probes/KernelSigs2.lean`); `TateModel.ker_eq` prints the standard three, `TateModel.mem_TA`
the standard three and `sorryAx` (through its one leaf).

### 2.1 The vocabulary

| declaration | what it is | X01D |
|---|---|---|
| `IsStablePlace F v` | conjugation fixes the prime `v` of `𝓞(F(i))` (`v.asIdeal.comap (conjO F) = v.asIdeal`) | "stable" (l. 116) |
| `SplitPlace F` | the primes it moves, `{v : HeightOneSpectrum (𝓞 L) // ¬ IsStablePlace F v}` | "`w split`" (l. 118) |
| `SplitAdeleRing F` | `Πʳ w : SplitPlace F, [L_w, O_w]` (Mathlib's `RestrictedProduct` over `adicCompletion`, `adicCompletionIntegers`; cofinite) | `∏′_{w split} L_w` |
| `SAdeleRing F` | `mixedSpace L × SplitAdeleRing F` | `W = L_∞ × ∏′ L_w` (l. 118) |
| `toSplitAdele`, `toSAdele` | the diagonals `L →+* ∏′ L_w`, `L →+* W` (proved: an element of `L` is integral at all but finitely many primes, `HeightOneSpectrum.Support.finite`) | "`t ∈ L` diagonal" (l. 281) |
| `ofUnitRing`, `unitL` | `R = ℤ[U_F]` and the unit vectors, read in `L` | — |
| **`TateModel F`** | the structure, nine fields (one datum, eight facts) | § 2.0's duality |
| `TateModel.Λ` | `{y ∈ L : π(ι y) = 1}` as an additive subgroup (proved) | `R^∨` (l. 119) |

One spec example per definition, each `rfl` or `Iff.rfl` and each failing if its definition drifts (the module, after `unitL`).

### 2.2 The domain pass (`debruijn-domain-modeling`, a fresh invocation, scoped to the interface's definitions)

- **`π` a field; `Λ` derived, not a field.** `Λ` is determined by `π` (`Λ = ι⁻¹(ker π)`), so a datum `Λ` beside a field
  `ker π = ι '' Λ` is two fields that must agree; the agreement is made structural by defining `Λ` from `π` and keeping as the
  field only the content, `ker π ⊆ range ι` (`ker_subset`). `ker_eq` (X01D's form) is then proved in five lines. `R`-stability
  is not a field either: `Λ` is stable under the unit vectors by the equivariance (`π(ι(u y)) = rot u (π(ι y)) = rot u 1`), hence
  under the ring they generate (`mul_mem_Λ`, a leaf). `π` stays a datum: M8b reads no formula for it, so lane T is free in the
  form of `ψ` (stage 3).
- **`π : AddChar W (Dual F)`.** `Dual F` is itself `AddChar R Circle`; a homomorphism from the additive `W` to the
  multiplicative `R̂` is an `AddChar`, and `AddChar.toMonoidHom` is the form the open mapping theorem takes.
- **The lower bound is `O′ ⊆ Λ`, not `d·O′ ⊆ Λ`.** Both hold for the standard character (X01D l. 120: `R^∨ = 𝔡⁻¹R` up to the
  choice of `ψ`, `𝔡⁻¹ ⊇ 𝓞`; on the weaker reading `R^∨ ⊇ O′^∨ = 𝔡⁻¹O′ ⊇ O′`, since `R ⊆ O′`). The sharper form costs lane T
  nothing (`ψ(ι x) = 1` for `x ∈ O′` is one line of either form of `ψ`, stage 3) and saves both readers of fact 4 the finiteness
  of `O′/dO′`: with it, `π(W) = π(K)` at once.
- **Fact 5's field is the half M8b reads, `π(L_∞) ⊆ A`** (`arch_mem`). Step 7 reads `π(L + L_∞) ⊆ T + A` only (stage 1); its
  torsion half follows from fact 3 (`N t ∈ 𝓞 L ⊆ O′ ⊆ Λ`, `toSAdele_mem_torsionChars`) and its sum from the multiplicativity of
  `π` (`mem_TA`, proved, two lines). The reverse inclusion `T + A ⊆ π(L + L_∞)` is the bridge no consumer reads; it is
  planned as an optional theorem of lane T's construction (§ 4), not as a field. **This narrows the ruling's "each stated as
  X01D states it" for fact 5 to the half X01D's own proof reads** — sent to the coordinator as a finding (§ 2.5).
- **The archimedean factor is Mathlib's mixed space, not `InfiniteAdeleRing L`.** Both are `L ⊗ ℝ`
  (`InfiniteAdeleRing.ringEquiv_mixedSpace`); every tool both readers need is stated on the mixed space —
  `mixedEmbedding.latticeBasis` (an `ℝ`-basis from an integral basis, `latticeBasis_repr_apply`, `mem_rat_span_latticeBasis`),
  the `ZSpan` fundamental domain of `𝓞 L` (`fundamentalDomain_integerLattice`), `normAtPlace` (the ordinary modulus at an
  archimedean place, which Lemma 3.1′'s boxes read). `L` is totally complex, so the real factor is a function out of the empty
  type.
- **`W` an `abbrev`.** It is the product and nothing more: consumers read `a.1`, `a.2 w` and componentwise multiplication, and
  every instance (`CommRing`, the topology, `IsTopologicalRing`, `T2Space`) is the product's.
- **Validation at the seams.** *A model of the hypotheses*: none without the construction — the five facts together are a Tate
  model, at every real number field; `exists_tateModel` supplies one (its module's docstring says so, and the structure's
  docstring names it). *The adversarial member*: `π ∘ (multiplication by a unit of `O′`)` satisfies every field and is a
  different model — the choice of `ψ` X01D allows ("up to the choice of `ψ`"); M8b's proof works for any, so it is no defect.
  *The next lemma*: "`π` is open" states in the vocabulary in one line (`isOpenMap`), as do "two lifts differ by `Λ`"
  (`π_eq_π_iff`) and "global points are torsion"; all three derive from the fields alone (§ 2.3).

### 2.3 The obligation pass (`debruijn-obligation-modeling`, a fresh invocation, scoped to the interface's statements)

- `mul_mem_Λ` — **derived from the equivariance alone.** Route: the stabiliser `M := {x ∈ L : x·Λ ⊆ Λ}` is a subring
  (`Λ` an additive subgroup); `unitL u ∈ M` by `π_unit_mul` and `rot u 1 = 1`; so `M ⊇` the image of `R = Subring.closure S`
  (`Subring.closure_le` read through `(fieldI F).subtype`). About 25 lines.
- `π_eq_π_iff` — from `ker_eq`: `π a = π b ↔ π (a − b) = 1` (`AddChar.map_sub_eq_div`, `div_eq_one`). About 8 lines.
- `toSAdele_mem_torsionChars` — stated as `∈ torsionChars`, the word its consumer `mem_TA` reads (changed by this pass from
  `∃ N, N ≠ 0 ∧ … ^ N = 1`, the same set unfolded). Route: `N t ∈ 𝓞 L` for some `N ≥ 1` (`exists_integral_multiple`, or the
  `IsLocalization` denominator of `𝓞 L ⊆ L`, to confirm at the pin), `𝓞 L ⊆ O′` (an integral element lies in every stable
  valuation subring), `stableIntegers_le`, and `AddChar.map_nsmul_eq_pow`. About 20 lines.
- `mem_TA` — proved here (two lines: `AddChar.map_add_eq_mul`, `Set.mul_mem_mul`).
- `isOpenMap` — **derived from facts 1, 2 and 4 with `L` countable**: `W = ⋃_{x ∈ O′} (K + ι x)` is a countable union of
  compact sets (`SigmaCompactSpace.of_countable`), so `MonoidHom.isOpenMap_of_sigmaCompact` applies to `D.π.toMonoidHom` on
  `Multiplicative W` (`R̂` compact Hausdorff, so Baire). About 30 lines; `Countable (fieldI F)` from finite dimension over `ℚ`.
- `exists_tateModel` — true at every real number field, every field checked against the construction of § 4; it is lane T.
- **No field is unread**: dropping surjectivity loses the lifts; `ker_subset`, Lemma PF; `stableIntegers_le`, the torsion half of
  fact 5 (`mem_TA`) and Step 6's finite orbits; `exists_nat_mul_mem`, Lemma PF's `C_Λ`;
  `exists_isCompact`, openness; `arch_mem`, the conclusion. (By reading M8b's steps; the kernel checks it when M8b-2..4 are
  proved over `D`.)

### 2.4 Read aloud against X01D § 2.0

"`W = L_∞ × ∏′_{w split} L_w` (restricted product w.r.t. `O_w`)" — `SAdeleRing F`, with `L_∞` the mixed space. "`a ↦ (r ↦
ψ(ar))` induces `W / R^∨ ≅ R̂`" — `π` continuous (`continuous_π`), onto (`surjective_π`), with kernel `ι(Λ)` (`ker_subset`,
`ker_eq`); the openness of the induced map is `isOpenMap`. "`R^∨ = {y ∈ L : ψ(yR) = 1}` a fractional `R`-ideal (`= 𝔡⁻¹R` up to
the choice of `ψ`)" — `Λ`, an `R`-module (`mul_mem_Λ`), with `O′ ⊆ Λ ⊆ d⁻¹O′` (`stableIntegers_le`, `exists_nat_mul_mem`),
which is "fractional" on the weaker reading. "discrete and cocompact in `W`" — `exists_isCompact` (discreteness of `ι(Λ)` is not
read by M8b: `W_{v*} ∩ Λ = 0` uses `Λ ⊆ L` only). "with `u·χ` ↔ multiplication by `u`" — `π_unit_mul`. "Under this
identification `T = L/R^∨`, `A = image of L_∞`" — `toSAdele_mem_torsionChars`, `arch_mem`, `mem_TA` (the half read).
"`Fin_S` = image of `∏_{w ∈ S} L_w`" — not typed: no step of M8b reads `Fin_S` (X01D § 3.8 l. 307, "`T + A = T + A +
Fin_∅`", the case `S = ∅`).

### 2.5 Findings sent to the coordinator at this stage

1. **Fact 5's field is `π(L_∞) ⊆ A`**, and `π(L + L_∞) ⊆ T + A` is a theorem over the structure (`mem_TA`, proved); the reverse
   inclusion, which no consumer reads, is not asked of lane T. A narrowing of ruling 1's "each stated as X01D states it" to the
   half X01D's own proof reads (Step 7, l. 306).
2. **Fact 3's lower bound is `O′ ⊆ Λ` (`d = 1`)**, sharper than FS131-KN9's `d·O′ ⊆ Λ` and true of the standard character on
   the weaker reading; it gives `π(W) = π(K)` with no finiteness of `O′/dO′`.
3. **`Λ` and its `R`-stability are derived, not fields**; the archimedean factor is the mixed space.

None changes a typed statement of another module.

### 2.6 The build and the checks

- **Build 1** (`./scripts/build.sh` under the slot, `MEMMAX=10G BATCH=8`): `exit=0`, 251 of 251 batches, 3 modules rebuilt
  (`TateModel` 5.8 s, `TateExists` 1.8 s, `Proofs`), 6 m 57 s; the two modules' only warnings are their `sorry`s
  (`logs/build1.log`). The openness instance (`splitAdeleRing_isOpen_integers`, below) was added after build 1 and elaborated
  under `lake env lean` (`logs/TateModel-6.log`, exit 0); the next build covers it.
- **The instance M8b and lane T need on `W`**: `Fact (∀ w, IsOpen O_w)`, the hypothesis of Mathlib's
  `RestrictedProduct.isTopologicalRing` (as `FiniteAdeleRing`'s instance takes it), declared for `SplitPlace F` only. With it
  `IsTopologicalRing`, `IsTopologicalAddGroup` and `T2Space` of `SAdeleRing F` are found (`probes/Instances.lean`,
  `logs/Instances.log`). `LocallyCompactSpace (SAdeleRing F)` is not claimed: it needs the compactness of each `O_w` (lane T,
  § 4).
- **Architecture** (`tools/check_architecture.py`): coverage `[1]` passes (366 rows, 366 modules); `[2]` reports one failure,
  `Rigidity/ZeroEntropyNames`' imports cell, inherited from the base and fixed on `fs131-wdg` by FS131-IDG1 (FS131-KN9 § 5.3);
  the two new rows pass (`logs/architecture-2.log`).
- **For the landing**: `TateModel F` is a structure of data, not a `Prop`; M8b's statements take `(D : TateModel F)`, a binder
  the vacuity scan reads `GENERIC`, inhabited by `exists_tateModel` (lane T) and by nothing before it.

## Stage 3 — SAVED: the two forms of the local character, measured on their first two leaves

The two forms FS131-KN9 § 4.3 names, each carried in scratch through its first two leaves, at a general number field `K` (the
leaves are about `K`, not about `F(i)`), under `lake env lean` with the lakefile's options (`data/fs131/kt1/lean1.sh`).

**Form G (global, by approximation)** — `data/fs131/kt1/scratch/FormG.lean`, 90 lines with docstrings:
`ψ_v(z) := e(−Tr_{K/ℚ}(t))` for any `t ∈ K` integral at every prime `≠ v` with `z − t ∈ O_v`. This is KN9's "global definition
on `L` by approximation", with the approximant taken for `z ∈ K_v` directly, so no extension by uniform continuity is needed.
- **G1** (`G1_approx`, with its child `G1b_crt`): such a `t` exists. The density of `K` in `K_v` (`denseRange_algebraMap`,
  `DenseRange.exists_mem_open`, `Valued.isOpen_valuationSubring`), then the Chinese remainder step: write `s = n/c` with
  `n, c ∈ 𝓞` (`IsLocalization.surj`); take `y ≡ n` modulo `v^{v(c)}` and `y ≡ 0` modulo `w^{w(c)}` at the other primes dividing
  `c` (`IsDedekindDomain.exists_forall_sub_mem_ideal`, `Ideal.finite_factors`, `intValuation_eq_exp_neg_multiplicity`,
  `intValuation_le_pow_iff_mem`); then `t := y/c`. **Closed: 65 lines, 3 elaboration rounds** (`logs/FormG-1.log`–`FormG-3.log`).
- **G2** (`G2_trace_int`): `Tr(t − t′) ∈ ℤ`, so the definition is independent of `t`. An element integral at every prime is in
  `𝓞` (`mem_integers_of_valuation_le_one`), and its trace is an integral rational (`Algebra.isIntegral_trace`,
  `IsIntegrallyClosed.isIntegral_iff`). **Closed: 7 lines, first round.**
- `logs/FormG-3.log`: exit 0, no `sorry`, no warning.

**Form L (local trace)** — `data/fs131/kt1/scratch/FormL.lean`, 89 lines:
`ψ_w(z) := ψ_p(Tr_{L_w/ℚ_p}(z))`.
- **L1**: `L_w` as an algebra over `K_v` for `w | v`, with the two instances Mathlib's `Module.Finite Kv Lw` takes as hypotheses
  (`IsScalarTower K Kv Lw`, `ContinuousSMul Kv Lw`). Mathlib has no such algebra (FinitePlace.lean l. 490 takes it as a
  `variable`), but it has the uniform continuity of `K → L` for the two valuations (`uniformContinuous_algebraMap_liesOver`,
  `Mathlib/NumberTheory/RamificationInertia/Valuation.lean`). The map is `UniformSpace.Completion.mapRingHom` of it, read
  through `adicCompletion.equiv`. **Closed: map, instance, tower and continuity in 25 lines, 4 rounds** (two of them on the
  `WithVal`/`Completion` coercion layer).
- **L2**: `ψ_p`, an additive character of `ℚ_[p]` trivial on `ℤ_[p]` and not on `p⁻¹`. Its decomposition step `L2decomp`
  (`x = m/p^k + y`, `y ∈ ℤ_p`: `Padic.norm_eq_zpow_neg_valuation`, `PadicInt.appr_spec`) is **closed: 28 lines, 4 rounds**. The
  character itself, `L2char` (the definition by choice and the additivity from `ℤ_p ∩ ℤ[1/p] = ℤ`), is **open (`sorry`)**. Its
  price is about forty lines, the size of G2 plus form G's additivity.
- `logs/FormL-1.log`–`FormL-7.log`; the last: exit 0, one `sorry` (`L2char`).

**The first two leaves cost about the same** (form G: 72 lines, both closed; form L: 53 lines closed and about 40 open). They
are not what decides. **What decides is what each definition obliges next**, read from the same leaves:
- **Form L**: the product formula on `O′`, that `ψ(ι x) = 1` for `x ∈ O′` (fact 3's lower bound, ruling (2) of the coordinator's
  reply), needs `Σ_{w | p} Tr_{L_w/ℚ_p}(x) = Tr_{L/ℚ}(x)`. That needs the decomposition `L ⊗_ℚ ℚ_p ≅ ∏_{w | p} L_w`, of which
  Mathlib holds only the surjectivity of `Kv ⊗[K] L → Lw` (FinitePlace.lean l. 498; no other `adicCompletion` file mentions a
  tensor product). It also needs `Tr_{L_w/ℚ_p}(O_w) ⊆ ℤ_p`, the integrality of `O_w` over `ℤ_p`, at the stable places as well
  as the split ones; Mathlib has no trace on `adicCompletion` at all. And it needs ℚ's own product formula for `ψ_p`,
  `Σ_p {r}_p ≡ −r (mod ℤ)`. These are three classical inputs absent at the pin, the first of FLT-project size.
- **Form G**: the same product formula is the integrality of one element, `x − Σ_{w ∈ supp} t_w ∈ 𝓞` (G1's `t_w` are integral
  off `w`; `x ∈ O′` is integral at every stable place), so G2 closes it with a finite sum. Local non-degeneracy is: some
  `t ∈ 𝓞[1/𝔭]` has `Tr(t) ∉ ℤ`, because `𝔭^{-k} ⊄ 𝔡⁻¹` for large `k` (Mathlib's `FractionalIdeal.dual`,
  `RingTheory/DedekindDomain/Different.lean`). No input outside Mathlib.

**Chosen: form G**, by the leaves after the first two, which form L's first two show it cannot reach without three absent
inputs. Form L stays recorded as the second route, with its two leaves on disk. Lane T is planned on form G (stage 4).

## Stage 4 — SAVED: lane T typed to its leaves (form G), a plan per leaf

Four new modules (`Rigidity/TateLocal`, `TateArch`, `TateCharacter`, `TateKernel`), with `Rigidity/TateExists` now the
assembly; their lines in `Proofs.lean` and `ARCHITECTURE.md` § 3. **Elaborated** in dependency order inside one slot
(`data/fs131/kt1/seq.sh s4a`): every module exit 0, warnings only `sorry` — 4, 6, 3, 13, 8 leaves — and `TateExists` none of
its own (`logs/*-s4a.log`); `#print axioms exists_tateModel` reads the standard three and `sorryAx`. Each statement below is as the kernel prints it
(`probes/KernelSigs4.lean`, `logs/KernelSigs4.log`); every name a route cites is checked at the pin (`probes/Names.lean`,
`logs/Names-s4b.log`: 56 names, exit 0 — the first run found five spelled wrong, `Module.Basis.constr_basis`,
`continuous_of_continuousAt_one` (root), `IsAlgebraic.exists_integral_multiple`, and two outside the probe's imports).

```
TateLocal (K any number field)   TateArch (K any number field)
          \                        /
           TateCharacter (F: ψ, π, facts 1, 3-lower, 5)  ← TateModel (the interface)
                    |
           TateKernel (F: kernel, bound, cover, surjectivity; reads Duality's D2 and RingScope's c·O′ ⊆ R)
                    |
           TateExists (exists_tateModel: the structure, one field per fact; no leaf of its own)
```

### 4.1 Why the stable places never appear, and why `O′ ⊆ Λ` costs nothing (the coordinator's ruling (2))

Form G's character on `W` is `ψ(a) = e(Tr_∞(a_∞) − Tr(t))` for an approximant `t ∈ O′` of `a`. It *is* the restriction of
the adelic standard character to `W`: at each split `w` the local factor `ψ_w(z) = e(−Tr(t_z))` with `t_z` integral off `w`
(stage 3), and `∏_{w ∈ supp} ψ_w(a_w) = e(−Tr(Σ t_{a_w}))`, `Σ t_{a_w}` being an approximant of `a`. For `x ∈ O′` the point
`ι x` has the approximant `x` itself, so `ψ(ι x) = e(Tr_∞(ι_∞ x) − Tr x) = 1` by `archTrace_mixedEmbedding` alone: the product
formula on `O′` is the definition read at one point (`tateChar_toSAdele_of_mem`, about ten lines), and `π(ι x)(r) = ψ(ι(x r))`
with `x r ∈ O′` (`R ⊆ O′`). **So the field `O′ ⊆ Λ` is true for the standard character and is the cheapest field of the
structure**; `d·O′ ⊆ Λ` would be proved by the same lines. No change to the interface is needed.

### 4.2 Tate's `O′^⊥ ⊆ L` on form G: the argument the kernel leaves transcribe

For `a ∈ oAnn F` (`ψ(a s) = 1` for every `s ∈ O′`):
1. subtract an approximant `t_a ∈ O′` (`ι(O′) ⊆ oAnn` by § 4.1): `b := a − ι t_a` is integral at every split prime;
2. test `b` on `s ∈ 𝓞 L`: `b·ι s` is integral at every split prime, so `ψ(b ι s) = e(Tr_∞(b_∞ s))` (`tateChar_of_integral`);
   all these are `1`, so `b_∞ = ι_∞(y)` with `Tr(y s) ∈ ℤ` for `s ∈ 𝓞` (`exists_eq_mixedEmbedding_of_archTrace_int`);
3. `d₀ y ∈ 𝓞` (`exists_nat_mul_integral_of_trace_int`); put `c := d₀(b − ι y)`: `c_∞ = 0`, `c_w = d₀ b_w − d₀ y ∈ O_w`, and
   `c ∈ oAnn` (for `s ∈ O′`: `ψ(c ι s) = ψ(b ι(d₀ s)) · ψ(ι(d₀ y s))⁻¹`, the first `1` since `d₀ s ∈ O′`, the second `1` by § 4.1
   since `d₀ y s ∈ O′`);
4. **local non-degeneracy** (`eq_zero_of_mem_oAnn`): suppose `c_{w₀} ≠ 0` at a split `w₀`. Take `t₀ ∈ L` integral off `w₀`
   with `Tr t₀ ∉ ℤ` (`exists_trace_not_int_away`), and `s ∈ L` integral off `w₀` with `s ≡ t₀/c_{w₀}` modulo `O_{w₀}`
   (`exists_approx_completion`); `s ∈ O′`. Then `c·ι s` is integral off `w₀` and `≡ t₀` at `w₀` (as `c_{w₀} O_{w₀} ⊆ O_{w₀}`),
   so `t₀` is an approximant of `c ι s` and `ψ(c ι s) = e(−Tr t₀) ≠ 1`, against `c ∈ oAnn`. Hence `c = 0` (`c_∞ = 0` was
   given), `b = ι y`, `a = ι(t_a + y)`, and `d₀(t_a + y) ∈ O′`. No local character on `L_{w₀}` and no single-place element of
   `W` is needed.

**The step that differs from FS131-KN9 § 4.1**: KN9 tested `c := a − r − y` directly, which needs `ι y ∈ ker π` for
`y ∈ 𝔡⁻¹` and so the local description of `𝔡⁻¹`; multiplying by the denominator `d₀` first (step 3) puts every test element in
`O′`, where § 4.1 applies, and the inverse different never enters. For `R` (fact 3): `π a = 1` gives `c·a ∈ oAnn` through
`c·O′ ⊆ R`, so `ker π ⊆ ι L` and `Λ ⊆ (d₀ c)⁻¹ O′`.

### 4.3 A plan per leaf

| module | leaf | route (Mathlib names, checked) | lines (est.) | hard |
|---|---|---|---|---|
| `TateLocal` | `exists_valuation_le_one_away` | **route copy** `G1b_crt` (scratch): `IsLocalization.surj`, `Ideal.finite_factors`, `IsDedekindDomain.exists_forall_sub_mem_ideal`, `Ideal.prime_of_isPrime`, `intValuation_eq_exp_neg_multiplicity`, `intValuation_le_pow_iff_mem`, `valuation_of_algebraMap`, `multiplicity_eq_zero`, `div_le_one₀` | 45 (done) | — |
| | `exists_approx_completion` | **route copy** `G1_approx`: `denseRange_algebraMap`, `DenseRange.exists_mem_open`, `Valued.isOpen_valuationSubring`, `valuedAdicCompletion_eq_valuation'` | 20 (done) | — |
| | `exists_int_trace_of_integral` | **route copy** `G2_trace_int`: `mem_integers_of_valuation_le_one`, `Algebra.isIntegral_trace`, `IsIntegrallyClosed.isIntegral_iff` | 7 (done) | — |
| | `exists_trace_not_int_away` | a uniformizer `π` at `v` (`valuation_exists_uniformizer`); `t` from `exists_valuation_le_one_away` at `s := π^{−N}` has `v(t) = v(π)^{−N}`; if every such `t` had integral trace, `d₀ t` would be integral at `v` (`exists_nat_mul_integral_of_trace_int` applied to `t`: `t·s` is again integral off `v` for `s ∈ 𝓞`), false for `N > v(d₀)` | 45 | the valuation bookkeeping in `ℤᵐ⁰` |
| | `exists_nat_mul_integral_of_trace_int` | the dual basis of the integral basis for the trace form (`traceForm_nondegenerate`, `LinearMap.BilinForm.dualBasis`, `dualBasis_repr_apply`): `y = Σ Tr(y eᵢ) eᵢ^∨`; `d₀` clears the denominators of the `eᵢ^∨` (`IsLocalization.exist_integer_multiples_of_finset`); integral at every prime by `valuation_of_algebraMap` | 50 | — |
| | `compactSpace_adicCompletionIntegers` | `Valued.integer.compactSpace_iff_completeSpace_and_isDiscreteValuationRing_and_finite_residueField`: complete (`IsClosed.completeSpace_coe`, the integers closed), DVR (Mathlib's instance, FinitePlace.lean l. 76), finite residue field — the map `𝓞 ⧸ v → 𝓀` is onto (density of `K`, then `exists_valuation_sub_lt_of_integer`), and `𝓞 ⧸ v` is finite (`Ideal.finiteQuotientOfFreeOfNeBot` or the number-field instance) | 80 | **the residue field**: no Mathlib statement; the hardest leaf of the module |
| `TateArch` | `archTrace_mixedEmbedding` | both sides `ℚ`-linear in `x`; agree on the integral basis (`latticeBasis_apply`, `Module.Basis.constr_basis`); `x` in the `ℚ`-span (`integralBasis` is a `ℚ`-basis) | 25 | — |
| | `exists_eq_mixedEmbedding_of_archTrace_int` | coordinates of `b` in `latticeBasis` (`Basis.repr`); the Gram matrix `Tr(eᵢ eⱼ)` (`Algebra.traceMatrix`), invertible over `ℚ` (`Algebra.discr_def`, `NumberField.discr_ne_zero`); `c·G ∈ ℤⁿ` gives `c ∈ ℚⁿ`, so `b = ι_∞(Σ cᵢ eᵢ)` (`mem_rat_span_latticeBasis`) | 70 | **the matrix step**: a solve over `ℚ` read back in `ℝ` |
| | `archTrace_mixedEmbedding_one` | `archTrace_mixedEmbedding`, `Algebra.trace_algebraMap` | 5 | — |
| `TateCharacter` | `mem_stableIntegers_iff_valuation` | `mem_stableIntegers`, `UpperHalf`'s `StablePrime.heightOne`, `valuationSubringAtPrime_eq_valuationSubring`; a stable `HeightOneSpectrum` gives a `StablePrime` (`HeightOneSpectrum.isMaximal`) | 30 | the two-way bijection of stable primes |
| | `exists_isApprox` | the finite set `{w : a.2 w ∉ O_w}` (`RestrictedProduct`'s `eventually` in `cofinite`); a `Finset.sum` of `exists_approx_completion`'s `t_w`; at each split `w` the other summands are integral (ultrametric `Valuation.map_sum_le`); in `O′` by `mem_stableIntegers_iff_valuation` (each `t_w` integral off `w`, `w` split) | 55 | the restricted-product bookkeeping |
| | `exists_int_trace_sub_of_isApprox` | `t − t′` integral at split primes (difference of the two congruences) and at stable ones (`O′`); `exists_int_trace_of_integral`; the split/stable dichotomy is `IsStablePlace`'s excluded middle | 20 | — |
| | `tateCharFun_eq` | `exists_int_trace_sub_of_isApprox` for `t` and the chosen approximant; `Circle.exp` is `2π`-periodic (`Circle.exp_two_pi_mul_int`; both spellings exist) | 15 | — |
| | `tateCharFun_zero`, `tateCharFun_add` | the approximants `0` and `t_a + t_b`; `map_add` of `archTrace`, `Algebra.trace` | 20 | — |
| | `tateChar_of_integral`, `tateChar_toSAdele_of_mem` | `tateCharFun_eq` at `0` and at `x`; `archTrace_mixedEmbedding` | 15 | — |
| | `continuous_tateChar` | on the open subgroup `U₀ = L_∞ × ∏ O_w` (`RestrictedProduct.isOpen_forall_mem`) it is `e ∘ 2π Tr_∞ ∘ fst`; a homomorphism continuous at `1` is continuous (`continuous_of_continuousAt_one` on `AddChar.toMonoidHom`) | 30 | — |
| | `continuous_tatePi` | `isClosedEmbedding_coe` (the pointwise topology of `R̂`), `continuous_pi_iff`, `continuous_tateChar.comp (continuous_mul_right _)` | 20 | — |
| | `tatePi_unit_mul` | `AddChar.ext`; `ofUnitRing (uvRing u * r) = unitL u * ofUnitRing r` by `Subtype.ext`; `mul_comm`, `mul_assoc` | 15 | — |
| | `tatePi_toSAdele_of_mem` | `UnitRing.coe_mem_unitRingOver_iff`, `unitRing_le_stableIntegers`, `Subring.mul_mem`, `tateChar_toSAdele_of_mem` | 15 | — |
| | `tatePi_arch_mem` | `(b, 0)·ι r = (b·ι_∞ r, 0)` is integral at every split prime; `tateChar_of_integral`; the lift `r ↦ 2π Tr_∞(b · ι_∞ r)` as an `AddMonoidHom` | 20 | — |
| `TateKernel` | `exists_eq_mixedEmbedding_of_mem_oAnn` | § 4.2 step 2; `tateChar_of_integral`, `exists_eq_mixedEmbedding_of_archTrace_int`, and `Circle.exp (2π x) = 1 → x ∈ ℤ` (`Circle.exp_eq_one` or `Real.Angle`; check) | 35 | — |
| | `eq_zero_of_mem_oAnn` | § 4.2 step 4: `exists_trace_not_int_away`, `exists_approx_completion` at `t₀ / c_{w₀}` (`div` in the field `L_{w₀}`, `Valuation.map_mul`), `tateCharFun_eq` at the approximant `t₀`, and `Circle.exp (2π x) = 1 → x ∈ ℤ` | 55 | the congruence `c s ≡ t₀` read through `Valued.v` |
| | `exists_nat_forall_mem_oAnn` | § 4.2 steps 1–3 over the two leaves above | 50 | — |
| | `tatePi_ker_subset`, `tatePi_exists_nat_mul_mem` | `exists_mul_stableIntegers_le` (lane M9-R's statement), `exists_nat_forall_mem_oAnn`; `a = ι(c⁻¹)·(ι c · a)` | 45 | — |
| | `tatePi_exists_isCompact` | `K := closure (ι_∞-fundamental domain) ×ˢ (structure map image of `∏ O_w`)`; `ZSpan.fundamentalDomain_isBounded`, `Metric.isCompact_of_isClosed_isBounded` (`ProperSpace` of the finite-dimensional mixed space); `isCompact_univ_pi` with `compactSpace_adicCompletionIntegers`, `RestrictedProduct.isEmbedding_structureMap`; the decomposition by `exists_isApprox` then `ZSpan.exist_unique_vadd_mem_fundamentalDomain` (`mixedEmbedding.fundamentalDomain_integerLattice`) | 90 | the compact set inside the restricted product |
| | `tatePi_eq_one_forall_imp` | for `r ≠ 0`, `ι_∞ r` is a unit of the mixed space (each component a nonzero complex number); `b := (2[L:ℚ])⁻¹ · (ι_∞ r)⁻¹` gives `Tr_∞(b ι_∞ r) = 1/2` (`archTrace_mixedEmbedding_one`), so `π(b,0)(r) = e(π) = −1` | 40 | — |
| | `surjective_tatePi` | `π(W) = π(K)` (fact 4 with `O′ ⊆ ker π`), compact, so closed (`IsCompact.isClosed`); its co-annihilator is `⊥` by the leaf above; `eq_top_of_isClosed_of_dualCoannihilator_eq_bot` on `MonoidHom.range π.toMonoidHom`, its `[Countable (unitRing F)]` from `SpectralChain.countable_unitRing` | 40 | — |
| `TateModel` (interface) | `mul_mem_Λ`, `π_eq_π_iff`, `toSAdele_mem_torsionChars`, `isOpenMap` | § 2.3's routes (`Subring.closure_le`; `AddChar.map_sub_eq_div`; `IsAlgebraic.exists_integral_multiple`, `AddChar.map_nsmul_eq_pow`; `SigmaCompactSpace.of_countable`, `MonoidHom.isOpenMap_of_sigmaCompact`, `continuous_of_continuousAt_one`) | 85 | — |

**Total: 34 leaves, about 1,050 lines**, of which 72 are written (the three route copies).

### 4.4 Models (the statements whose hypotheses are a structure)

`exists_eq_mixedEmbedding_of_mem_oAnn`, `eq_zero_of_mem_oAnn` and `exists_nat_forall_mem_oAnn` take `a ∈ oAnn F`: `0 ∈ oAnn F`
(`tateChar 0 = 1`), and `ι x` for `x ∈ O′` (§ 4.1), are inhabitants exercising every clause (the second is integral at every
split prime and has archimedean part `ι_∞ x`, nonzero for `x ≠ 0`); `eq_zero_of_mem_oAnn`'s three hypotheses hold together at
`0` only — it is a uniqueness statement, and its docstring's route says so. `tatePi_eq_one_forall_imp`'s hypothesis holds at
`r = 0` only, likewise. Every other leaf is over a number field or `F` alone.

### 4.5 The domain pass (`debruijn-domain-modeling`, a fresh invocation, scoped to lane T's definitions)

- `archTrace` is defined through a basis (`latticeBasis.constr`), an incidental choice; its characterization is intrinsic: an
  `ℝ`-linear map on `K ⊗ ℝ` is fixed by its values on `ι_∞(K)`, which spans, so `archTrace_mixedEmbedding` determines it, and
  no consumer unfolds the definition. Mathlib's `Algebra.trace ℝ (mixedSpace K)` is the basis-free twin; equating it with
  `Tr_{K/ℚ}` on `K` needs the base change `mixedSpace K ≅ ℝ ⊗_ℚ K`, so the constructed form is the cheaper one.
- `IsApprox` is a **relation**, not a function: an element has many approximants, and the clause `t ∈ O′` is what makes the
  character well defined (without it `Tr t` moves by stable-place denominators). The choice lives in `tateCharFun` alone, and
  `tateCharFun_eq` — over *every* approximant — is its reasoning surface; no consumer reads the chosen one.
- `tatePi` is the formula X01D writes (`tatePi_apply`, `rfl`); `oAnn` is a set, read by membership.
- Nothing is indexed. The unsampled member: with no split prime `IsApprox` is `t ∈ O′ = 𝓞` and `ψ = e ∘ Tr_∞` — consistent.

### 4.6 The obligation pass (`debruijn-obligation-modeling`, a fresh invocation, scoped to lane T's statements)

- Each leaf's statement is the one its route consumes, and each route above names the statement it closes. Two are
  **uniqueness shapes**: `eq_zero_of_mem_oAnn` (its hypotheses hold together at `c = 0`, which satisfies every clause) and
  `tatePi_eq_one_forall_imp` (at `r = 0`). Both are satisfiable, neither vacuous, and § 4.4 names their inhabitants.
- `exists_isApprox` decomposes into four children the implementer should state as `have`s: the finite set of split primes
  where `a` is not integral; a per-prime approximant; the ultrametric bound on the sum at each split prime; membership in `O′`.
  `eq_zero_of_mem_oAnn` decomposes as § 4.2 step 4 writes it, five `have`s.
- **Dependencies on other lanes' statements**: `tatePi_ker_subset` and `tatePi_exists_nat_mul_mem` read
  `exists_mul_stableIntegers_le` (lane M9-R); `surjective_tatePi` reads `eq_top_of_isClosed_of_dualCoannihilator_eq_bot`
  (lane PD). Both are typed; `exists_tateModel` prints `sorryAx` through them until they land.
- The assembly `exists_tateModel` is proved, one field per fact. The kernel's print of the structure it builds is the
  interface's own (stage 2's `KernelSigs2.log`).

## Stage 5 — SAVED: the lanes, the price, and the drafts

### 5.1 The lanes (none shares a file with another)

| lane | writes | reads (statements only) | who |
|---|---|---|---|
| **T-L** — `Rigidity/TateLocal`, 6 leaves | that file | Mathlib | an implementer; folds the three route copies first (`data/fs131/kt1/scratch/FormG.lean`), then `exists_nat_mul_integral_of_trace_int`, `exists_trace_not_int_away`, `compactSpace_adicCompletionIntegers` |
| **T-A** — `Rigidity/TateArch`, 3 leaves | that file | Mathlib | an implementer (small); may share a session with T-L, not a file |
| **T-C** — `Rigidity/TateCharacter`, 15 leaves | that file | T-L, T-A, the interface | an implementer; beside T-L and T-A |
| **T-K** — `Rigidity/TateKernel`, 9 leaves | that file | T-C, T-L, T-A; `exists_mul_stableIntegers_le` (lane M9-R), `eq_top_of_isClosed_of_dualCoannihilator_eq_bot` (lane PD) | an implementer; beside T-C |
| **T-I** — `Rigidity/TateModel`'s 4 derived leaves | that file | the fields | an implementer (small); first, since M8b-2..4 read `isOpenMap` and `π_eq_π_iff` |
| (assembly) | `Rigidity/TateExists` | — | none: `exists_tateModel` is proved, one field per fact |

`exists_tateModel` prints `sorryAx` until T-L, T-A, T-C, T-K are proved **and** lanes M9-R (`exists_mul_stableIntegers_le`)
and PD (D2's case) land. M8b-2..4 are planned and proved over `(D : TateModel F)` beside all of this.

### 5.2 The price (from stage 3's leaves and stage 4's table)

Measured: form G's first two leaves, 72 lines, closed in three elaboration rounds of a few minutes each. Planned: 30 leaves,
about 1,050 lines (§ 4.3), of which three leaves (72 lines) are written. The table prices each leaf against the measured ones;
four leaves are marked hard (the residue field of `O_v`, the Gram-matrix step, the split step, the compact set in the restricted
product), and I price those at two to three times the measured rate. **Price: about two agent-days of implementer work in
all** — about half a day for each of T-L and T-C (each about 250 lines), a little more for T-K, an hour or two each for T-A and T-I — **and about one
day of wall time with three lanes running at once.** That is under a week; no fallback is planned and no axiom is drafted.
`LEAN.md`'s rule applies: re-price from the first two leaves each implementer closes. FS131-KN9's price, made from Mathlib's
state and not from a leaf ("several days, two to four thousand lines"), was high: the inverse different, the local traces and
strong approximation all leave the route.

### 5.3 Drafts for files I do not write

- **`data/fs131/claims-NF2.md` § Dated lines** (each follows the last line there):
  - "2026-10-14 — **The model of the dual is typed as an interface, `Rigidity.TateModel F` (FS131-KT1).** `W = L_∞ × ∏′_{w
    split} L_w` (`Rigidity.SAdeleRing`, the archimedean factor Mathlib's mixed space) and a continuous `π : W → R̂`, equivariant
    for the unit vectors, onto, with kernel on the diagonal, `O′ ⊆ Λ ⊆ d⁻¹O′`, `W = K + O′` with `K` compact, and `π(L_∞) ⊆ A`;
    `π(L + L_∞) ⊆ T + A`, `Λ`'s `R`-stability and the openness of `π` are theorems over it. M8b-2..4 are proved over
    `(D : TateModel F)`; its existence is `Rigidity.exists_tateModel` (lane T). A typed interface, not a theorem."
  - "2026-10-14 — **Tate's self-duality in the form the model reads, on a global character (FS131-KT1; a plan, the kernel its
    test).** The standard character of `W` is `ψ(a) = e(Tr_∞(a_∞) − Tr(t))` for any `t ∈ O′` congruent to `a` modulo `O_w` at
    every split prime; it needs no local trace. Two inputs carry it, both over every number field and both elaborated in
    scratch: approximation away from one prime, by the Chinese remainder theorem, and the integrality of the trace of an
    element integral at every prime. The product formula on `O′` is then the definition read at one point. `O′^⊥ ⊆ L` follows
    from the archimedean trace duality, the denominators of the trace dual of `𝓞`, and one element integral off a split prime
    with a non-integral trace. The inverse different, the local traces `L_w → ℚ_p`, strong approximation and Lusin–Souslin
    leave lane T's inputs. Priced at about two agent-days."
- **`LEAN.md` § Searching — Lean**, new lines:
  - "Mathlib at the pin has the uniform continuity of `K → L` for the adic valuations of a prime and one above it
    (`IsDedekindDomain.HeightOneSpectrum.uniformContinuous_algebraMap_liesOver`, `valuation_liesOver`,
    `Mathlib/NumberTheory/RamificationInertia/Valuation.lean`), so the map `K_v → L_w` is `UniformSpace.Completion.mapRingHom`
    of it through `adicCompletion.equiv`. But it constructs no `Algebra (v.adicCompletion K) (w.adicCompletion L)`: its
    `Module.Finite Kv Lw` takes one as a `variable`. It has no trace on an `adicCompletion`, no decomposition
    `L ⊗_K K_v ≅ ∏_{w | v} L_w`, no additive character of `ℚ_[p]`, and no finiteness of the residue field of
    `adicCompletionIntegers` (FS131-KT1, `data/fs131/kt1/scratch/FormL.lean`)."
  - "Approximation away from one prime of a Dedekind domain (`s ∈ K` congruent at `v`, modulo the integers, to an element
    integral at every other prime) is 45 lines over `IsDedekindDomain.exists_forall_sub_mem_ideal` (write `s = n/c`, solve
    `y ≡ n` mod `v^{v(c)}` and `y ≡ 0` at the other primes dividing `c`, take `y/c`); its form in `K_v` adds
    `HeightOneSpectrum.denseRange_algebraMap` and `DenseRange.exists_mem_open` (FS131-KT1, `scratch/FormG.lean`)."
  - "The restricted product of topological rings is a topological ring only given `Fact (∀ i, IsOpen (A i))`, which Mathlib
    supplies by a local `haveI` for `FiniteAdeleRing`; a restricted product over another index set needs its own instance
    (`Rigidity.splitAdeleRing_isOpen_integers`, FS131-KT1)."
  - "`IsDedekindDomain.HeightOneSpectrum.uniformContinuous_algebraMap_liesOver` takes `K L v w` explicitly in that order (the
    file's `variable (K)` comes after `(L)`), and `adicCompletion.continuous_toCompletion K v` takes both explicitly
    (FS131-KT1)."
- **`BIBLIOGRAPHY.md`**: no new row. `[Tate1950]` (§ 4.1, the additive self-duality) and `[ChothiEverestWard1997]` (the
  `S`-integer duality) are cited in `Rigidity/TateExists`' docstring, and `[Weil1967]` (IV.2) beside them; **none was read by
  this job** (the rows' status stands: not held, not read). The route of lane T is this job's own and needs none of them.
- **`ARCHITECTURE.md`**: written by this job (six rows: `Rigidity/TateModel`, `TateExists`, `TateLocal`, `TateArch`,
  `TateCharacter`, `TateKernel`); § Trust: nothing new (no axiom).
- **The draft claim list** `data/fs131/kn3/claims-M8-zero-entropy-carried.md`: a section "Since FS131-KT1" added in place (its
  old text kept above it and in git).

### 5.4 The checks at the hand-back

- **Build 2** (`./scripts/build.sh` under the slot, `MEMMAX=10G BATCH=8`): `exit=0`, 252 of 252 batches, 7 modules rebuilt (the
  six of this job and `Proofs`), 6 m 58 s; this job's modules warn only of their `sorry`s (`logs/build2.log`).
- **Lint** (`lake lint --no-build -- --no-build --trace` under the slot): `exit=0`, `-- Linting passed for Proofs.`, 14
  linters `Passed` (`logs/lint.log`).
- **Architecture**: coverage `[1]` passes (370 rows, 370 modules); the one failure is the inherited `Rigidity/ZeroEntropyNames`
  imports cell (§ 2.6) (`logs/architecture-4.log`).
- **No axiom** declared; `#print axioms exists_tateModel`: the standard three and `sorryAx` (`logs/KernelSigs4.log`).
