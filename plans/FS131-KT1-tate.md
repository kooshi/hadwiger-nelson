# FS131-KT1 — the five-colour chain: `TateModel F` typed, and lane T (Tate's self-duality in the form the model reads) planned

*de Bruijn, the planner (the seventh on this chain). Brief: `data/fs131/briefs/FS131-KT1-tate.md` (on `main`). Branch `fs131-wkt`,
cut from `fs131-wk9` at `aee998a46`, in the worktree `.claude/worktrees/fs131-wch`. Working files: `data/fs131/kt1/`.*

## Theorems this phase proved

None yet (a planning job; see the last stage).

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
