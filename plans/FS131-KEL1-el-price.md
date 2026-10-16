# FS131-KEL1 — what it would take to prove Einsiedler–Lindenstrauss Theorem 1.3 in this library: a price from first leaves

*de Bruijn, the kernel lane's planner. Brief: `data/fs131/briefs/FS131-KEL1-el-price.md` (Keryx, 2026-10-16 03:57 UTC).
Worktree `.claude/worktrees/kel1`, branch `fs131-kel1`, cut from `main` at `69dc6b0be`. A price is a decision input for
Kooshi, not a commitment; formalization effort ranks no route (`CLAUDE.md` § Counter-priors).*

## Theorems this phase proved

On branch `fs131-kel1` only (the skeleton beside them holds two `sorry`s; nothing here reaches `main`):
- `ELRigidity.exists_eq_mul_abs_of_homogeneous_of_antitone` — `[EinsiedlerLindenstrauss2022]` Lemma 7.2's elementary core; [kernel], standard three (`Proofs/HadwigerNelson/ELRigidity/Linearity.lean`), with `exists_nat_btwn`, `mul_le_mul_of_homogeneous_of_antitone`, `mul_abs_le_of_homogeneous_of_antitone`, `linearity_model`.
- `ELRigidity.isClosed_realLeafPeriods`, `realLeafPeriods_top_or_cyclic` and four lemmas — `[OAIMath2026]` family 015's, ported by hand at this pin; [kernel], standard three; and their generalization `ELRigidity.isClosed_leafPeriods` (periods of a locally finite regular measure on a locally compact abelian group are a closed subgroup), `leafPeriods_eq_tests`, model `leafPeriods_volume_eq_top`; [kernel], standard three (`ELRigidity/LeafPeriods.lean`).
- `ELRigidity.eq_of_le_of_sum_le` — (7.8′)'s equality forcing; [kernel], standard three; and `ELRigidity.haar_or_zero_entropy_of_core` — Thm 1.2 from the skeleton's core; [kernel] over `sorryAx` (the core) and the standard three, **with no declared theorem** (`ELRigidity/Skeleton.lean`; `data/fs131/kel1/logs/axioms.log`).

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

Six block quotations in the brief, each checked verbatim (as a substring of its named source, `> ` prefixes stripped,
lines joined) by `data/fs131/kel1/quote_check.py`; its planted control alters one character of the first quotation and
must report it missing (it does, exit 1). Run 2026-10-16 04:05 UTC on this worktree:

| # | source | verdict |
|---|---|---|
| 1 | `data/fs131/REQUEST-2026-10-13.md` (W2) | verbatim |
| 2 | same (W5; its double space "cap to  4" is the source's) | verbatim |
| 3 | `plans/FS131-close-inventory.md` (item 825) | verbatim |
| 4 | `data/fs131/REQUEST-2026-10-13.md` (W4) | verbatim |
| 5 | `Proofs/HadwigerNelson/Rigidity/PositiveEntropy.lean` (the axiom, ll. 81–93) | verbatim |
| 6 | `BIBLIOGRAPHY.md` (the `[EinsiedlerLindenstrauss2022]` row) | verbatim |

No mismatch; nothing for Keryx about the brief.

### 1.2 The theorem

`Rigidity.positive_entropy_rigidity` (`Proofs/HadwigerNelson/Rigidity/PositiveEntropy.lean` ll. 81–93) is
`[EinsiedlerLindenstrauss2022]` Theorem 1.3, § 1.1, pp. 2–3 (arXiv:2101.11120v1). The page, quoted in that module's
docstring (ll. 17–24) and re-read today against the library's PDF (text layer, p. 2 l. 43 – p. 3 l. 9):

> Let `α` be a `ℤ^d`-action (`d ≥ 2`) by automorphisms of a solenoid `X`. Suppose `α` has no virtually cyclic factors, and
> let `µ` be an `α`-invariant and ergodic probability measure on `X`. Then there exists a subgroup `Λ ⊆ ℤ^d` of finite index
> and a decomposition `µ = (1/J)(µ₁ + … + µ_J)` of `µ` into mutually singular measures with the following properties for
> every `j = 1, …, J`. (1) The measure `µ_j` is `α_Λ`-ergodic, where `α_Λ` is the restriction of `α` to `Λ`. (2) There exists
> an `α_Λ`-invariant closed subgroup `G_j` such that `µ_j` is invariant under translation with elements in `G_j`, i.e.
> `µ_j(B) = µ_j(B + g)` for all `g ∈ G_j` and every measurable set `B ⊆ X`. (3) For `n ∈ ℤ^d`, `αⁿ_* µ_j = µ_k` for some
> `k ∈ {1, …, J}` and `αⁿ(G_j) = G_k`. (4) The measure `µ_j` induces a measure on the factor `X/G_j` with
> `h_{µ_j}(αⁿ_{X/G_j}) = 0` for any `n ∈ Λ`. (Here `α_{X/G_j}` denotes the action induced on `X/G_j`.)
> — source: `Proofs/HadwigerNelson/Rigidity/PositiveEntropy.lean` ll. 17–24

**The declared statement against the page, re-read by me** (the clause-by-clause read-back of record is
`plans/FS131-KN7-chain-next.md` § 3.3; I re-did it without relying on it, then compared). Hypotheses: `IsSolenoid`,
`2 ≤ d`, `ZdAction`, `NoVirtuallyCyclicFactors` (the sense FS105-VC chose; a closed invariant `Y ≠ X` whose quotient is
virtually cyclic — `X/Y` is then a compact connected group with dual inside `X̂`, so a solenoid, so the page's "factor"),
`IsProbabilityMeasure`, `IsErgodicOn ⊤` (strict invariance; equal to the page's for the countable `ℤ^d`). Conclusion:
`Λ.FiniteIndex`, `0 < J`, the average, mutual singularity, probability, `IsErgodicOn Λ`, `G j` closed and `Λ`-invariant,
translation invariance (`(· + g)⁻¹' B = B − g`), the permutation clause with one `k` for measure and subgroup, and the
entropy clause over the Borel σ-algebra of `X ⧸ G j` in the infimum form (the safe direction). **I find no clause that
says more or less than the page.** Nothing was sent to Keryx on this account.

### 1.3 Its one use in the library

The declared theorem is read once, by `Rigidity.haar_or_zero_entropy` (the paper's Theorem 1.2, deduced here from 1.3 —
FS105-DED, [kernel] since FS131-IJ3; `PositiveEntropy.lean` l. 523), and that is read once, by Lemma Γ:

```
Rigidity.positive_entropy_rigidity                (Thm 1.3, declared)
└─ haar_or_zero_entropy                           (Thm 1.2: totally irreducible, not virtually cyclic ⟹ Haar ∨ ∀ n, h = 0)
   └─ isHaarFourier_or_ksEntropy_eq_zero          (Lemma Γ, Rigidity/Pieces l. 797: Thm 1.2 at each piece M̂_k)
      └─ ksEntropy_eq_zero_of_not_smul_le         (Rigidity/EntropySplitMax: ergodic decomposition + Lemma Γ + mixtures)
         └─ entropySplit_of_admissiblePair → entropySplit F   (PE-2 at one non-torsion rotation, Rigidity/ZeroEntropyClosed)
            └─ mrPlus F, min_localBound_five_le_chromaticNumber, χ(ℚ(√47)²) = 5, … (the five-colour chain)
```

`positive_entropy_rigidity_of_polishSpace` also reads it; nothing reads that form (only `scripts/Axioms.lean`).
**What the chain actually consumes is Theorem 1.2, at one family of actions**: `X = M̂ = PieceDual M` for `M` a finitely
generated `ℤ[Γ]`-submodule of `unitRing F ⊆ F(i)` with `ℚM = F(i)`, `Γ = ⟨u, w⟩` an admissible pair (two multiplicatively
independent unit vectors of `F(i)`, every finite-index subgroup generating the field; `Rigidity/UnitCircle`), `ℤ²` acting
by the duals of multiplication by `u^{n₀} w^{n₁}` (`pieceAction`), totally irreducible and not virtually cyclic (PE-1′,
[kernel]); and from the conclusion it reads only "some `αⁿ` has positive entropy ⟹ Haar".

### 1.4 What a price must contain (the brief's stage 4, restated)

Lines of Lean per node of the proof tree and in total, low and high; the calibration from two attempted leaves (one on
the release's port path, one fresh); conversion at the measured rate (`plans/FS131-close-inventory.md` item 825: 850–913
hand-written lines per active hour; ported code ran at about 2,600 per active hour on one night); the split between
porting `[OAIMath2026]` family 015 at this pin and new work; a build order; and whether a narrower statement serves the
library's one use (the entropy split at one non-torsion rotation), with what it saves. Nothing with a `sorry` reaches
`main`.

## Stage 2 — SAVED: the tree

### 2.1 Reading status (standing rule 10)

`[EinsiedlerLindenstrauss2022]` (library PDF, text layer): **§1 read in full; §2 (2.1–2.4: Lemma 2.1, Props 2.2–2.3, Lemma
2.4 with proofs) read in full; §3 (3.1–3.3, Props 3.2, 3.4, 3.5, Lemma 3.3, Def 3.1) read in full; §4 (Thm 4.1, Lemmas
4.2–4.3 with proofs, §4.3, §4.4) read in full; §5 (Thm 5.1 and its proof) read in full; §6 (6.1–6.4: Thm 6.1, Lemmas
6.2–6.3, Prop 6.4, the proof of Thm 6.1) read in full; §7 (Thm 7.1, Lemmas 7.2–7.4, Prop 7.5, Cor 7.6, the proof of Thm
4.1) read in full; §§8–9 not read** (not used by Thm 1.3). This raises the bibliography row's §3.1–3.3, §5, §6 and §7 from
"at their statements" to "in full". The works it cites for Thm 1.3's proof, and where they are:

| cited | what is invoked | held? |
|---|---|---|
| `[10]` EL, *Diagonal actions on locally homogeneous spaces* (Clay Math. Proc. 10, 2010) = `[EinsiedlerLindenstrauss2010]` | §6–7: leafwise measures, Thm 6.30 (growth function `f_V`), Lemma 7.16 (equivariance (3.4)), Lemma 7.27 (thin boundaries), §7 (Prop 3.4's proof, "in the spirit of this paper"), Thm 7.6 (first equality of (6.3)), §8 and Cor. 8.6 (product structure, Prop 7.5) | **not held, unread** |
| `[5]` Einsiedler–Katok 2005 = `[EinsiedlerKatok2005]` | Thm 8.2 "or more precisely its proof" (Thm 6.1), Lemma 5.10, Prop 6.2 (proof of Thm 4.1) | **not held, unread** |
| `[11]` EL, Publ. IHÉS 2019 = `[EinsiedlerLindenstrauss2019]` | Prop 6.4 (Prop 3.5, "the proof there works verbatim"), Lemma 5.2 (supporting subgroup) | **not held, unread** |
| `[9]` EL, JMD 2008 (rank one, low entropy method), Lem. 3.2; `[28]` Lindenstrauss, Ann. Math. 2006, §3 | Prop 3.2 (leafwise measures supported on a subgroup) | **not held, unread**; no bibliography entry (proposed below) |
| `[8]` EL, Duke 2007 (joinings), Prop 3.1 | Prop 3.5 ("cf.") | **not held, unread**; no entry |
| `[3]` Einsiedler–Katok, CPAM 2003 | the product structure (§6 opening) | **not held, unread**; no entry |
| `[25, 26]` Ledrappier–Young 1985 | Prop 3.4 ("essentially well known") | **not held, unread**; no entry |
| `[27]` Lindenstrauss, Israel J. Math. 2001, Thm 2.4 | a special case of Thm 5.1 | **not held, unread**; no entry |
| `[38]` Weil, *Basic number theory*, Ch. I–IV | adeles, `Â ≅ A`, `ℚ^⊥ = ℚ`, the product formula (p. 75) | not held (the product formula is in Mathlib: `NumberField.prod_abs_eq_one`) |
| `[7]` EL 2003 announcement = `[EinsiedlerLindenstrauss2003]` | §4 ("cf. [7, Thm 4.1]", Lemma 4.2) | held, read in full (FS105-R) |

**I stopped at the paper itself.** Two places where the paper proves a step only by pointing at another proof in another
setting are reading gaps for any formalization, and both are named in the price: **footnote 3, p. 13** — "In [10, § 7] it is
assumed that the acting group acts in a semisimple way on the leaves … the arguments of [10, § 7] can be easily modified to
handle this situation; we leave the details to the readers" — and **the proof of Thm 6.1, p. 28** — "the product structure
… follows from [5, Thm. 8.2] (or more precisely its proof)". The library's one use is semisimple (§ 2.4), so footnote 3's
unwritten modification is not on the narrow route; the product structure is, in a weakened form (§ 2.4).

### 2.2 The tree of Theorem 1.3, as the paper gives it

Holdings by declaration name: **M** = Mathlib at the pin (v4.32.0, located by grep in `.lake/packages/mathlib`; `#check`ed
where marked ✓), **L** = this library, **R** = `[OAIMath2026]` family 015 at `~/source/math/lean/OAI/NumberTheory/` (read,
not built; v4.34.1), **P** = already ported here (`Outside/OAI015*`).

```
T   Thm 1.3 (declared)                                                    L: the axiom; Thm 1.2 from it (FS105-DED, kernel)
├─ R1  Lemma 4.2: the lift X ≅ X_m/K, X_m = 𝔸^m/ℚ^m, K = V^⊥ (X̂ = V ⊆ ℚ^m); µ_K (Haar on fibres); an ergodic component; push down; merge equal components
│   ├─ R1a  Lemma 2.1, (2.2)–(2.3): ℚ^m discrete cocompact in 𝔸^m; Â ≅ A with ℚ^⊥ = ℚ (Tate)        M: `NumberField.AdeleRing` (definition, `principalSubgroup`) only; no discreteness, cocompactness or duality
│   ├─ R1b  ergodic decomposition, countable group, standard Borel                                 P: `Outside.OAI015.action_ergodic_decomposition`; L: `condExpKernel_ergodicDecomposition`
│   └─ R1c  lifting a measure through a compact-kernel quotient                                   gap (fresh)
├─ R2  Lemma 4.3: a good Λ (A-irreducible factors stay irreducible; Λ′-invariant adelic ⟺ Λ-invariant)
│   ├─ Prop 2.2 (A-irreducible ⟹ multiplication by ζ_1…ζ_d in a number field K), Lemma 2.4 (filtration)   gap; M has `Module.End` Jordan–Chevalley pieces, `IsSemisimple`, minpoly
│   └─ roots of unity in a Galois closure; Zariski density of finite-index Λ for polynomial maps     gap
├─ R3  §4.3 assembly: µ = J⁻¹ Σ µ_j (α_Λ-ergodic, finite index), transitivity, Thm 4.1 at µ_1, transport   L: `ZdAction.eq_of_isErgodicOn_of_invariant_component`, mixtures (`ksEntropy_finite_mixture_eq_zero`)
└─ C   Thm 4.1 (adelic): µ invariant under an adelic G, h(αⁿ on X/G) = 0
    ├─ C0  §4.4: maximal invariant adelic Y; Lemma 2.4; Abramov–Rokhlin addition; X → X_pos → X_base, Y_irred ≅ 𝔸_K/K      gap (Rokhlin addition absent from R by name — KN3 § 4.2)
    ├─ C1  §3: the machinery
    │   ├─ C1a  leafwise measures µ̃_x^V for S-linear V on X × Ω: existence, (3.1), Def 3.1, growth f_V ([10] Thm 6.30) ⟹ (3.2)→(3.3), Prop 3.2, (3.4)
    │   │        R (for one-dimensional real root leaves of SL_n only): `intrinsicRootLeaf`, `ae_leafMeasure_of_ambient`, `prefixLeafMeasure_unique`, `ae_intrinsicRootLeaf_diagonal_restrict`, `regularLeafKernel`, `locallyFiniteRealVersion` (PrimePackets/IntrinsicLeaves, AmbientLeaves, LeafSupport, LeafNormalization; Geometry/RootPrefixLeafMeasure); M: `condExpKernel`, `Measure.condKernel`, `Measure.ext_of_integral_eq_on_compactlySupported`
    │   ├─ C1b  thin-boundary partitions (Lemma 3.3 = [10] Lemma 7.27), (3.7), increasing V-subordinate C_V        R: `SummablePartitionBoundaries`, `SubordinateFutureBoxes` (SL_n boxes); gap for S-linear V
    │   ├─ C1c  **Prop 3.4**: h(T,V) := H(C_V | T⁻¹C_V) is well defined, = ∫ vol(T,V,x) (3.9), vol = 0 ⟺ µ̃_x^V trivial, h(T,V) ≤ h(T|Ω), equality at V = U_T⁻     R: the root-future entropy layer (`Entropy/*`: `conditionalEntropy_eq_leafMeasure`, `RootPrefixFutureEntropy`, `WholeFutureEntropyCriterion`, `regular_entropy_le_root_form_neg`, …); P: Shannon, conditional Shannon, generating supremum, mixtures; L: `ksEntropy`, `tendsto_blockEntropy_div`, `ksEntropy_eq_iSup_ksEntropyOn`
    │   └─ C1d  Prop 3.5 ([11] Prop 6.4): contributions over a factor                                       gap
    ├─ C2  **Thm 5.1**: h(αⁿ,V | X_base×Ω) ≤ h_λ(αⁿ_irred, V∩V_irred)/h_λ(αⁿ_irred) · h(αⁿ | X_base×Ω)
    │        (5.2) invariant subspaces of 𝔸_K = ∏ K_σ; Haar contributions Σ δ_σ log 1/|ζⁿ|_σ ((2.1)); product formula (Prop 2.3); the atom estimate (5.4); (5.6)
    │        M: `NumberField.prod_abs_eq_one` ✓-located, `MeasureTheory.Measure.addHaar_smul` (real spaces), `modularCharacter`; R: the SL_n analogue is the "entropy ≤ root form" upper bound (`Entropy/RegularRootEntropyUpper`, `negative_diagonal_entropy_le_root_sum`)
    ├─ C3  **Thm 6.1**: product structure µ̃_x^{V⁻} ∝ ∏_[χ] µ̃_x^{V[χ]} and (6.3) additivity ([5] Thm 8.2's proof)
    │   ├─ §6.1–6.2 Lyapunov weights χ_σ(n) = Σ nᵢ log|ζᵢ|_σ, coarse classes, W^[χ] = ⋂_{χ·n<0} U⁻_{αⁿ}, (6.2)        gap (linear algebra over local fields)
    │   ├─ supporting subgroup ([11] Lemma 5.2)                                                               gap
    │   └─ no shearing: Lemmas 6.2–6.3, Prop 6.4 (real Jordan blocks)                                       gap; **vacuous for a semisimple action**
    └─ C4  §7
        ├─ Thm 7.1 (h(αⁿ, W^[χ] | …) = κ h_λ(αⁿ, W^[χ])) ⟸ Lemma 7.2 (linearity), Lemma 7.3 (zero contributions inside V_pos), Abramov–Rokhlin, (7.5)–(7.8′), Thms 5.1, 6.1
        ├─ Lemma 7.4 (two linearly independent weights): Dirichlet's unit theorem + "no virtually cyclic factors"     M: `NumberField.Units.logEmbedding`, `logEmbedding_eq_zero_iff`, `unitLattice` (DirichletTheorem.lean)
        ├─ Prop 7.5 (κ_{µ̃,Ω} = κ_µ): leafwise measures of W^[χ] constant along W^[χ′]-leaves; Ω = projective classes of locally finite measures on W, compact metric
        │        R (real leaves): `ae_rootBox_intrinsicLeaf_eq_of_nonparallel`, `exists_synchronized_annular_equal_leaf_returns`, `exists_annular_return_with_equal_leaves` (Dynamics/RootLeafHopf, SynchronizedReturns, LeafReturnCovariance)
        ├─ Cor 7.6
        └─ proof of Thm 4.1: periods W_x of µ^W_x closed; W̃_x the largest S-linear subgroup; Luzin, Poincaré recurrence, Chabauty limits ⟹ W̃_x ≠ 0 a.s.; conditional measures on φ⁻¹B_F; G_x = closure of W̃_x + ℚ^m adelic; countably many ⟹ G_x = G; Λ normalizes G; ergodicity
                 R (real leaves): `realLeafPeriods`, `isClosed_realLeafPeriods`, `realLeafPeriods_top_or_cyclic` (PrimePackets/LeafPeriods), `root_invariant_of_nonzero_intrinsic_period` (RootInvariance), `root_invariant_of_leafwise_constant_nonatomic`, `isHaar_of_projective_leaf_symmetries` (Dynamics/PublishedEKL); M: `MeasureTheory.Conservative.ae_mem_imp_frequently_image_mem` (Poincaré recurrence), `AddSubgroup.dense_or_cyclic` (for ℝ only); no Chabauty topology
```

### 2.3 What the release's Lean is, measured

`data/fs131/kel1/release_closure.py` (the import closure of a release module inside the release, by its `import OAI.…`
lines): **the closure of `DukePrimeDegree/Entropy/RegularEntropyDischarge` — the file whose `eklPrimeInput_unconditional`
proves Einsiedler–Katok–Lindenstrauss's prime-degree positive-entropy rigidity for the diagonal action on
`SL_{d+1}(ℝ)/SL_{d+1}(ℤ)` (`EKLPrimeInput`, `MainConditional.lean` l. 28) — is 801 files and 114,907 lines**: 41,650 in
`PrimePackets/` (of which about 18,000 are the family's analytic number theory — zeta, theta, Mellin, ideals, sieves — that
the closure drags in through shared files, and about 14,600 its entropy and leaf layers), 30,975 `Geometry/`, 23,544
`Dynamics/`, 18,439 `Entropy/`. **So a complete Lean proof of a positive-entropy leafwise-measure rigidity theorem of the
same method exists, and is about 90,000–97,000 lines once the unrelated analytic number theory is taken out.** It is the one
measured comparison for this price. KN3 § 4.3 found the theorem; this measures it.

What transfers. The release's leaves are **one-dimensional real** (`Measure ℝ`, root subgroups of `SL_n`, charts by
"root boxes"); its space is **non-compact and non-commutative** (cusp mass, escape of mass, Weyl reindexing, the
high- and low-entropy cases). EL's leaves are **products of real, complex and `p`-adic fields** and its space is **compact
and abelian**. So: the generic entropy layer ports (some of it already has: `Outside/OAI015Shannon`, `OAI015Generating`,
`OAI015Mixtures`, `OAI015Maximal`, `OAI015ErgodicDecomposition`, 3,018 lines); the leaf and contribution layers are
templates to be **generalized from `ℝ` to S-linear groups**, not copied; the SL_n geometry (root boxes, atlas, cusp, Weyl
group) does not transfer and EL needs none of it.

### 2.4 The library's one use, and the narrower statement it needs

From § 1.3: the chain consumes **Thm 1.2 at the pieces** — `ℤ²` acting on `M̂` by the duals of multiplication by
`u^{n₀} w^{n₁}` in `K = F(i)`. Read through the paper, that is the **A-irreducible, semisimple** case of Thm 4.1:

* total irreducibility at every finite-index `Λ` (the admissible pair's `generates` field) makes the lifted action
  A-irreducible with `Y_irred` the whole lift and `X_base = 0` — no filtration (Lemma 2.4), no Lemma 4.3, no `X_pos`/`X_base`
  bookkeeping (Lemma 7.3, (7.4)–(7.7)), no Prop 3.5, no Abramov–Rokhlin over a base;
* multiplication by field elements is **semisimple** — `α_uni` trivial, so §6.4 (Lemmas 6.2–6.3, Prop 6.4) and footnote 3's
  unwritten modification are not needed;
* with `X_base = 0`, (7.8′) needs from Thm 6.1 **only the inequality** `h(αⁿ) = h(αⁿ, U⁻) ≤ Σ_[χ] h(αⁿ, W^[χ])`: Thm 5.1
  gives each `h(αⁿ, W^[χ]) ≤ κₙ h_λ(αⁿ, W^[χ])`, these sum to `κₙ h_λ(αⁿ) = h(αⁿ)`, so every inequality is an equality.
  Prop 7.5 still needs the leafwise measures of `W^[χ]` to be constant along `W^[χ′]`-leaves, which has a Hopf-type proof
  (the release proves its real-leaf form) and needs no full product structure. [reading, mine: the equality-forcing step is
  an elementary observation; whether the subadditive inequality needs product structure in this abelian setting is
  `[10]`'s §8 and is unread here — named as a risk in the price];
* the lift goes to an **S-adic** solenoid, not the adeles: `M` is a finitely generated module over `ℤ[Γ] ⊆ O_{K,T}` (`T`
  the finite places where `u^{±1}` or `w^{±1}` is not integral), so `M̂ ≅ (K_∞ × ∏_{v∈T} K_v)/M^∨` — finitely many places,
  as EL say on p. 6 ("for irreducible actions it would suffice to consider only finitely many places (see also [7])"); no
  Tate self-duality of `𝔸` (R1a), only the duality of one finitely generated `O_{K,T}`-type module, on the library's
  countable-group Pontryagin duality (`Rigidity/Duality`: `evalDualHom_surjective`, `dualAnnihilator_dualCoannihilator`).

**So the narrow statement is Thm 1.2 itself** (as `haar_or_zero_entropy` states it, for every solenoid) **or Thm 1.2 for the
pieces' actions** — and Thm 1.3 is not needed by the chain at all. A narrower *declared* statement (Thm 1.2 as an axiom in
place of 1.3) is printed (`[EinsiedlerLindenstrauss2022]` Thm 1.2, p. 2, = `[EinsiedlerLindenstrauss2003]` Thm 1.1) but its
only printed proof is via Thm 1.3; declaring it would retire FS105-DED's role (already kernel-checked) and change no price.
For a *formalization*, the narrow route is what is priced in stage 4.

### 2.5 The deepest node

**C1c, Prop 3.4, with C1a–C1b under it**: that the Kolmogorov–Sinai entropy of `αⁿ` (relative to an extension `Ω`) is the
entropy contribution of the full stable subgroup `U⁻`, computed as the exponential volume growth of the leafwise measures
`µ̃_x^{U⁻}` — Ledrappier–Young's identification, in `[10]` §7's form, on a compact S-adic quotient, for S-linear leaves
mixing real, complex and `p`-adic directions. It needs: leafwise measures on S-linear groups (with their growth bound and
equivariance), partitions with thin boundaries in every direction, increasing subordinate σ-algebras, and the conditional
entropy of countably generated σ-algebras. Every later node — Thm 5.1, Thm 7.1, Prop 7.5, the invariance argument — reads
entropy only through it. Its nearest Lean is the release's root-future entropy layer for real root leaves (`Entropy/`,
18,439 lines, with parts of `Geometry/`). Its source proof is in `[10]`, which is not held.

## Stage 3 — SAVED: the top typed, two leaves proved

### 3.1 The modules (branch `fs131-kel1` only; nothing here reaches `main` while `Skeleton` holds a `sorry`)

| module | what | lines (total / code) | `sorry` |
|---|---|---|---|
| `Proofs/HadwigerNelson/ELRigidity/Skeleton.lean` | the narrow route's top: the core `exists_infinite_invariant_of_ksEntropy_ne_zero` (EL Thm 4.1 read at a totally irreducible action on a solenoid); **`haar_or_zero_entropy_of_core`, proved from it** — Thm 1.2 exactly as `Rigidity.haar_or_zero_entropy` states it, with no declared theorem under it; **`eq_of_le_of_sum_le`, proved** — (7.8′)'s equality forcing, with a model; Lemma 7.4's arithmetic `virtuallyCyclic_of_proportional_weights` over Mathlib's `InfinitePlace`/`FinitePlace` | 94 / 49 | 2 |
| `Proofs/HadwigerNelson/ELRigidity/Linearity.lean` | **the fresh leaf**: Lemma 7.2's elementary core, `exists_eq_mul_abs_of_homogeneous_of_antitone`, three lemmas under it, a model exercising every clause | 122 / 89 | 0 |
| `Proofs/HadwigerNelson/ELRigidity/LeafPeriods.lean` | **the port leaf**: `[OAIMath2026]` `PrimePackets/LeafPeriods.lean` ll. 103–207 (8 declarations, the periods of a locally finite measure on `ℝ` a closed subgroup, `ℝ` or cyclic), copied by hand at this pin; then **generalized** to every locally compact Hausdorff topological abelian group (`leafPeriods`, `leafPeriods_eq_tests`, `isClosed_leafPeriods`) — EL p. 33's closed subgroup `W_x`, whose leaves are products of local fields; a model | 207 / 141 (ported 73, generalized 63) | 0 |

`Proofs.lean` imports the three; `ARCHITECTURE.md` has a row for each (`tools/check_architecture.py`: PASS). The skeleton's
statements were read aloud against the page: the core's conclusion is what Thm 4.1 gives at a totally irreducible action
(an adelic `G ≠ 0` on the lift, pushed down closed and infinite; EL p. 14 and § 7.2) and is true given Thm 1.3 (FS105-DED's
step 1–2 read it); Lemma 7.4's typed form is the page's with "Lyapunov weight" written out at every place, `χ = 0`
included (then every `ζᵢ` is a root of unity and `Λ` the multiples of their orders).

### 3.2 The calibration

**The fresh leaf** (Lemma 7.2's core). Designed and written 04:09–04:12 UTC, elaborated twice (one fix: `nsmul_eq_mul`
had rewritten the `ℤ^d`-smul in the model; and a deprecated import), green at 04:14 under `lake env lean` (2.9 s, 1.8 GB).
**89 code lines.** A plan line for "Lemma 7.2" would have read 100–200: it came in at the low end.

**The port leaf.** The release's 88 non-blank lines became 73 code lines here with **one proof patch** (`mem_ofPred_eq` →
`mem_setOf_eq`, a rename already in `LEAN.md`'s list of pin differences) and the release's `open scoped CompactlySupported`;
it elaborated on the first try (04:15). **The generalization from `ℝ` to a locally compact abelian group took 63 lines and
one added hypothesis (`[ν.Regular]`, an instance on `ℝ`)**, elaborated on the first try, because the release's proof is
generic (a convolution with `1`, Riesz uniqueness); the release's ℝ-only step (`AddSubgroup.dense_or_cyclic`) does not
generalize, and EL's replacement — the largest S-linear subgroup of `W_x` — is new work.

**What the two leaves calibrate, and what they cannot.** (1) The release's generic measure theory ports to this pin at about
one patch per hundred lines, consistent with FS131-IE1 and FS131-IP23 (2 to 6 patches per 500 lines). (2) Its real-leaf layer
generalizes to S-linear leaves at roughly its own size where the argument is generic, and must be rewritten where it reads
`ℝ`'s order, intervals or Besicovitch density on `ℝ` — the pattern for pricing nodes C1a–C1c. (3) Elementary glue (Lemma 7.2,
(7.8′), the core-to-Thm-1.2 step, 14 lines) lands at the low end of a plan's figure. (4) **Neither leaf calibrates the deep
nodes** (C1c, C1a, C3's subadditive half, Prop 7.5): for those the calibration is the release's measured size for the same
method on `SL_n` (§ 2.3), not these leaves.

### 3.3 The build

`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 scripts/slot.py --mem 10 --cpus 4 -- env MEMMAX=10G BATCH=4 ./scripts/build.sh`, from the
worktree, 04:17–04:32 UTC: **OK — 557 of 557 batches, 4 modules rebuilt (the three and the root), 14 m 54 s**; the one module
with warnings is `ELRigidity/Skeleton`, its two `declaration uses 'sorry'` (ll. 34, 83) and nothing else
(`data/fs131/kel1/logs/build1.log`; the tool's full output `build/gate/build/20261016T041706Z-2787094.log`). `#print axioms`
(`data/fs131/kel1/AxiomsKEL1.lean`, `logs/axioms.log`): every proved declaration on the standard three;
`haar_or_zero_entropy_of_core` on the standard three and `sorryAx` — **not** on `Rigidity.positive_entropy_rigidity`.

## Stage 4 — SAVED: the price

### 4.1 Per node, in lines of Lean, low–high

**The narrow route** (what the chain reads: Thm 1.2, through the core of § 3.1, at A-irreducible semisimple actions lifted to
an S-adic solenoid; § 2.4). Each figure is new Lean unless marked; "R ≈ n" is the release's measured size for the analogous
layer on `SL_n(ℝ)/SL_n(ℤ)` (§ 2.3), the one comparison the method has.

| node | contents | Mathlib / library / release | lines |
|---|---|---|---|
| N-A arithmetic | local fields `K_v` with EL's normalized `\|·\|_v`, Haar scaling (2.1) at real, complex and `p`-adic places; the S-integer lattice discrete and cocompact in `K_∞ × K_T`; the duality `M̂ ≅ (K_∞ × K_T)/M^∨`, equivariant, homeomorphic, measurable; the product formula in δ-form; Lemma 7.4 (skeleton `sorry`) | M: completions, `prod_abs_eq_one`, `logEmbedding`, `unitLattice`, Minkowski `O_K ⊂ K_∞`; L: countable Pontryagin duality (`Rigidity/Duality`) | 4,000–10,000 |
| N-B leafwise measures (C1a) | `µ̃_x^V` for S-linear `V` on `X × Ω`: construction from subordinate σ-algebras and `condExpKernel`, normalization, (3.1), (3.4), growth bound ⟹ (3.3), Prop 3.2, measurability into locally finite measures | R ≈ 9,000 for real root leaves; generic parts port (§ 3.2) | 6,000–15,000 (port ≈ 1,500–3,000 of it) |
| N-C entropy contributions (C1b–C1c, **the deepest node**) | thin-boundary partitions in every direction, increasing subordinate `C_V`, `H(C_V \| T⁻¹C_V)` for countably generated σ-algebras, Prop 3.4 relative to `Ω` (well defined, = volume growth, trivial ⟺ 0, `≤ h(T\|Ω)` with equality at `U⁻`) | R ≈ 22,000 (`Entropy/` with the root-future parts of `Geometry/`); P: 3,018 lines already ported (`Outside/OAI015*`) | 12,000–28,000 (port ≈ 3,000–6,000 of it) |
| N-D Thm 5.1 | (5.2), Haar contributions, the atom estimate (5.4) via thin boundaries and the product formula, (5.6) | none; the release's upper bound has another mechanism | 2,000–5,000 |
| N-E Lyapunov algebra and the subadditive half of (6.3) | weights and coarse classes over local fields (§§ 6.1–6.2, semisimple), `W^[χ] = ⋂ U⁻`, (6.2); `h(αⁿ, U⁻) ≤ Σ h(αⁿ, W^[χ])` | none | 2,500–7,000 (**+4,000–8,000 if the inequality needs the product structure**: `[10]` § 8 unread) |
| N-F § 7, narrow | Lemma 7.2 (proved: 89 lines, + its wrapper on contributions), Thm 7.1 without a base, Prop 7.5 (Hopf-type constancy along `W^[χ′]`; `Ω` = projective classes of locally finite measures, a compact metric space), Cor 7.6, the invariance argument (periods closed — the port leaf; largest S-linear subgroup; Luzin, Poincaré recurrence, Chabauty limits; conditional measures over `φ`; invariance from invariant leafwise measures) | M: `Conservative.ae_mem_imp_frequently_image_mem`, `Measure.ext_of_integral_eq_on_compactlySupported`; R (real leaves): `RootLeafHopf`, `SynchronizedReturns`, `RootInvariance`, `PublishedEKL` ≈ 6,000–8,000 | 7,000–17,500 |
| N-G glue | core ⟹ Thm 1.2 (proved, 14 lines); transport across `M̂ ≅ (K_∞ × K_T)/M^∨` of ergodicity, entropy (`ksEntropy_map`) and Haar; the chain switched from `haar_or_zero_entropy` | L: `ksEntropy_map`, `isAddHaarMeasure_of_add_invariant` | 800–2,000 |
| **narrow total** | | | **34,000–85,000** (93,000 with N-E's risk); port share ≈ 5,000–10,000 |

**The full route** (Thm 1.3 as declared) adds: X1 adeles — the restricted-product topology, `K` discrete and cocompact in
`𝔸_K`, Tate's self-duality `𝔸̂ ≅ 𝔸` with `K^⊥ = K`, Lemma 2.1 (Mathlib has `NumberField.AdeleRing` as a definition only):
6,000–14,000; X2 Prop 2.2, Lemma 2.4, Lemma 4.3 (Jordan decomposition over `ℚ`, roots of unity in a Galois closure,
Zariski density of finite-index `Λ`): 2,000–5,000; X3 Lemma 4.2's lift and § 4.3's assembly: 1,500–4,000; X4 the base —
Prop 3.5, the Rokhlin addition formula, Lemma 7.3, (7.4)–(7.7), every contribution relative to `X_base`: 3,000–7,000; X5
Jordan blocks — footnote 3's unwritten modification of `[10]` § 7, §6.4 (Lemmas 6.2–6.3, Prop. 6.4), supporting subgroups,
the full product structure of Thm 6.1 from `[5]`'s proof: 6,000–14,000. **Extra 18,500–44,000; full total 53,000–130,000.**

### 4.2 The calibration applied

Both leaves came in at or below a plan's figure (§ 3.2), as `LEAN.md` § The kernel's cost model predicts; they bear on the
glue and port shares, which I therefore read at the low half of their ranges. They do not bear on the deep nodes, whose
ranges come from the release's measured layers (§ 2.3): the release proved the same method — leafwise measures, entropy
contributions, Hopf-type returns, invariance from leafwise periods — for `SL_n` in about 90,000–97,000 lines, and the narrow
route's midpoint (≈ 55,000) sits below it for reasons named in § 2.3 (compact, abelian, semisimple, no Weyl group, no cusp)
against one that raises it (mixed real, complex and `p`-adic leaves). **Central figures: narrow ≈ 50,000 lines, full ≈
80,000 lines.**

### 4.3 Converted at the measured rate

At 850–913 hand-written lines per active hour (`plans/FS131-close-inventory.md` item 825), with the port share at the
2,600 per hour one ported night measured (low ends at 913 and the small port share, high ends at 850 and the large):

| route | lines | of which port | active hours |
|---|---|---|---|
| narrow (Thm 1.2 at the pieces; retires the axiom) | 34,000–85,000 (central 50,000) | 5,000–10,000 | **34–92** (central ≈ 51) |
| full (Thm 1.3 as declared) | 53,000–130,000 (central 80,000) | 5,000–10,000 | **55–145** (central ≈ 85) |

### 4.4 The narrower statement, and what it saves

**The library's one use needs Thm 1.2, and the narrow route proves it with no declared theorem**: once the core
(`exists_infinite_invariant_of_ksEntropy_ne_zero`) is proved, `haar_or_zero_entropy_of_core` (proved here) replaces
`Rigidity.haar_or_zero_entropy` in Lemma Γ, and **`positive_entropy_rigidity` is then read by nothing on the chain** (its
other reader, `positive_entropy_rigidity_of_polishSpace`, has no consumer) — the import leaves the trust ledger without Thm
1.3 being proved. The saving against the full route: **18,500–44,000 lines (about a third), 21–50 active hours**, and two
reading gaps the full route cannot avoid (footnote 3's unwritten non-semisimple modification; the product structure "from
[5, Thm 8.2] (or more precisely its proof)"); the narrow route keeps one risk from `[10]` § 8 (N-E). A narrower still form —
Thm 1.2 only for the pieces' actions, `ℤ²` by multiplication in `F(i)` — saves nothing further of substance: the core's proof
already runs at that generality (one number field, semisimple), and `haar_or_zero_entropy_of_core` costs nothing extra.

**No route around the theorem was found** for PE-2: every route seen goes through positive-entropy rigidity at some
non-virtually-cyclic `ℤ²` (searched: the paper, its § 1 history, the release's statements; not searched further).

### 4.5 The order I would build it in

1. **In parallel, no dependencies:** N-A (arithmetic and the duality `M̂ ≅ (K_∞ × K_T)/M^∨`, Lemma 7.4's `sorry`); the port
   of the release's remaining generic conditional-entropy layer at this pin (the `tools/fs131_ie1_port.py` method).
2. **Read `[10]` §§ 6–8 first** (not held; arXiv/ETH) — the source proofs of N-B, N-C and N-E's inequality — and settle N-E's
   risk before typing N-C.
3. N-B (leafwise measures on S-linear groups, generalizing the release's real-leaf files; the periods leaf is done), then
   **N-C, the critical path** (Prop 3.4).
4. N-D and N-E, in parallel once N-C's interface is typed.
5. N-F and N-G: the core proved; Lemma Γ switched to `haar_or_zero_entropy_of_core`; the axiom's records audited off the
   chain. The full route's extras (X1–X5), if Thm 1.3 itself is wanted, come after and touch nothing the chain reads.
