# FS131-IKL1 — the five-colour chain: the certificate link at residue sizes 11 and 19

*The implementer's record (de Bruijn, Opus 5.5), on branch `fs131-wkl` in the worktree `.claude/worktrees/fs132-wi1`.
Brief: `data/fs131/briefs/FS131-IKL1-cert-link.md`. Working files: `data/fs131/ikl1/`.*

## Theorems this phase proved

*(filled at the last stage)*

## Stage 1 — SAVED: the readback, the branch, the merge, build 1

### 1.1 The quotations (standing rule 3)

`tools/fs131_ikl1_quotes.py` checks each of the brief's five quotations, character for character, against its source as
one whole line in the main tree. All five are **IDENTICAL**: W2 in `data/fs131/REQUEST-2026-10-13.md`; the dated line of
`data/fs131/claims-NF2.md`; inventory items 848, 902 and 922 of `plans/FS131-close-inventory.md`
(`data/fs131/ikl1/quotes.out`). Control: the same check with one character of each quotation changed in memory reports
all five MISMATCH (`quotes-plant.out`).

### 1.2 The branch and the merge

* `git checkout -b fs131-wkl fs131-wcm3` at `c0b6798ed`; `git merge --no-ff fs131-wc16` at `af4eb1ab2`. One conflict, in
  `ARCHITECTURE.md`: two blocks of module rows added at the same place (M13's line's `Rigidity/*` rows; the certificates'
  line's `Arith/ThreeColour*`, `TorsionExtraction`, `DyadicQuadratic`, `ThreeFourColours`, `Instances/UpperHalfCorollaries`
  rows). Kept both, markers removed, no row doubled. `tools/check_architecture.py`: PASS. Merge commit `13902eb15`.
* **The merge changed no file's text but `Proofs.lean` and `ARCHITECTURE.md`.** From the merge base `82b4bc2b9`, each side
  only adds `.lean` files (`git diff --stat`: 51 files, 18,936 insertions, 0 deletions on M13's side; 22 files, 8,768
  insertions, 0 deletions on the certificates' side). The only paths both sides touch are `ARCHITECTURE.md` and
  `Proofs.lean` (import lines added on both sides). So every module's source, and the source of every module it imports, is
  one side's text.
* **From the kernel's side** (`data/fs131/ikl1/lean/StatementDump.lean`, `tools/fs131_ikl1_statements.py`): every constant
  of the merged build's `Arith/CircleCos`, `Rigidity/ClassRatio`, `CountCompletion`, `CountDescent`, `CountModels`, against
  FS131-ICM3's last dump (`data/fs131/icm3/statements-after4.txt.xz`; no `Proofs/` change between that stage and
  `c0b6798ed`), and of `Arith/FibreCert`, `FibreCert3`, `FibreCertSound`, against FS131-IKC3's dump
  (`data/fs131/ikc3/statements-after.txt`; those three files are unchanged after it): **SAME 1,209, CHANGED 0, MISSING 0,
  ADDED 0** — every stored type and every definition's value, generated and private constants included
  (`statements-merge-vs-lines.out`). Controls, on the merged dump changed in memory: one character of a stored type
  (CHANGED), a constant dropped (MISSING), a constant added (ADDED) — 3/3 fired.

### 1.3 Build 1

`./scripts/build.sh` under the slot (`--mem 10 --cpus 4`, `MEMMAX=10G BATCH=8`): **OK — 262 of 262 batches, 32 modules
rebuilt, 17 m 24 s** (`data/fs131/ikl1/logs/build-1.log`; full output `build/gate/build/20261014T213050Z-723675.log`).
The ten modules that warned print only `declaration uses 'sorry'`, each a known skeleton leaf on M13's line
(`ClassRatio` ll. 1649, 1657, 2075 — the two dyadic children and this job's leaf; `BochnerTau`, `ChainAtTA`,
`EntropyFibres`, `EntropySplitMax`, `InvariantMeasure`, `PositiveEntropy`, `RingScope`, `UnitCircle`,
`Plane/OneAvoidingDensity`). No certificate module warned.

### 1.4 The statements, printed from the kernel (`data/fs131/ikl1/lean/Readback.lean` → `readback.out`)

* `Rigidity.ratioAtMost_cert` (private): `∀ {F : Subfield ℝ} [NumberField ↥F] (P : StablePrime F), 2 ∉ P.P → ∀ {Q : ℕ},
  Nat.card (𝓞 ↥(fieldI F) ⧸ P.P) = Q ^ 2 → Q = 11 ∨ Q = 19 → ∃ c < 1 / 4, RatioAtMost P c`; axioms `[propext, sorryAx,
  Classical.choice, Quot.sound]`. *In words:* at a stable prime not above 2 whose residue field has 11² or 19² elements,
  some `c < 1/4` bounds the ratio at every level.
* `Rigidity.RatioAtMost P c := ∀ m, 1 ≤ m → ∀ s : Finset (𝓞 ⧸ P.P ^ m), (levelTarget P m).IsIndepSet ↑s →
  ↑s.card ≤ c * ↑(Nat.card (𝓞 ⧸ P.P ^ m))`. *In words:* every independent set at every level `m ≥ 1` has at most a
  fraction `c` of the points.
* `SpectralChain.levelTarget P m := SimpleGraph.fromRel fun x y => (x - y) * quotientMap (P.P ^ m) (conjO F) _ (x - y) = 1`.
  *In words:* the Cayley graph of `𝓞 ⧸ P^m` on the norm-one set.
* `FibreCertSound.sum_le_eleven : ∀ φ : V 11 → ℝ, (∀ x, 0 ≤ φ x) → (∀ x, φ x ≤ 1) → 0 ≤ qform 11 φ →
  ∑ x, φ x ≤ 28204320001863099628721379861820 / 1000000000000000000000000000000`, on the standard three. *In words:*
  FS-66's region at 11 has total mass at most 28.2043….
* `FibreCertSound.card_le_eleven : ∀ I : Finset (V 11), (∀ x ∈ I, ∀ y ∈ I, y - x ∉ unitCircle 11) →
  ↑I.card ≤ 28204…820 / 10^30`, on the standard three. *In words:* level one at 11.
* With them: `qform p φ = 2 * ∑ x, φ x * (1 - φ x) - ∑ x, ∑ s ∈ unitCircle p, φ x * φ (x + s)`,
  `unitCircle p = {x | x.1 ^ 2 + x.2 ^ 2 = 1}`, `V p = ZMod p × ZMod p` (reducible).
* The consumer: `ratioAtMost_of_five_le_chromaticNumber` rests now on `[propext, sorryAx, Classical.choice, Quot.sound,
  StandingFive.kloosterman_bound]`.

### 1.5 K3–K5, beside their routes (KC13 § 5.2), and what each reads

| leaf | the plan's statement | route here | reads |
|---|---|---|---|
| K3 | `levelTarget P 1 ≃g Cay((ℤ/q)², unitCircle q)` at a stable prime not above 2, `q` prime | an additive isomorphism `𝓞 ⧸ P → (ℤ/q)²`, `x ↦ (e(u(x + x̄)), e(−uι(x − x̄)))` through the fixed field `k₀ ≅ ZMod q`, carrying `{x·x̄ = 1}` onto `{a² + b² = 1}` (the coordinates of `ClassRatio`'s private `charBound_one_of_circleCos`, restated as a map) | `StandingFive.card_fixed_of_involution`, `Arith.nonempty_ringEquiv_zmod_of_card`, `UpperHalf.conjO_conjO` |
| K4 | L1 and L2 at every level: fibre shares `φ ∈ [0,1]^V`, `q(φ) ≥ 0`, `|I| = q^{2(m−1)} Σ φ` | L2 in characters on an abstract finite abelian group with a quotient (`Arith/FibreShareIneq`), then transported; **L1 and Hensel's count are hypotheses** (the coordinator's ruling, § 2.1) | `RatioBound.sum_fourier_sq_mul_charSum_eq_zero`, `RatioBound.sum_fourier_sq`, Mathlib's `AddChar.sum_apply_eq_ite`, `AddChar.compAddMonoidHom_injective_left` |
| K5 | `U₁₁/121 < 1/4`, `U₁₉/361 < 1/4` | `norm_num` on the literal at 11; at 19 `U < 361/4` is the hypothesis's own clause | — |

## Stage 2 — SAVED: K3, K4, K5, the composition, the scratch checks

### 2.1 The route, and the coordinator's ruling

The link must sit **upstream** of `Rigidity/ClassRatio` (ClassRatio's leaf reads it), so it cannot import ClassRatio. But
K4 reads two facts that are proved only privately in ClassRatio: Hensel's count of norm-one lifts, and Lemma P's bound on
characters new above level one. I set out three options (inventory: question). The coordinator ruled for **(c)**: the
link takes the two facts as hypotheses, stated in public vocabulary, and ClassRatio discharges them where it reads the
link (about 40 lines drafted here). The alternatives were declined: (a), a 600-line public copy of Lemma P, would leave the
same proof in the library twice; (b), moving Lemma P out of ClassRatio, would disturb a live job. The hypotheses
(`Rigidity/CertLink`):

* `HenselCount P Q`: `∀ n (hfin : (normOneSet P (n + 1)).Finite) {t}, t ∈ normOneSet P 1 →
  (hfin.toFinset.filter fun x => toLevelOne P n x = t).card = Q ^ n`;
* `NewCharBound P Q`: `∀ n (hfin : (normOneSet P (n + 1)).Finite) (ψ : AddChar (𝓞 ⧸ P.P ^ (n + 1)) ℂ),
  (∃ e, toLevelOne P n e = 0 ∧ ψ e ≠ 1) → ‖∑ s ∈ hfin.toFinset, ψ s‖ ≤ 2 * (Q : ℝ) ^ n`;

over two public definitions: `normOneSet P m` (the connection set of `levelTarget P m`) and `toLevelOne P n` (the factor
map from `𝓞 ⧸ P^{n+1}` to `𝓞 ⧸ P^1`). Both definitions have the same bodies as ClassRatio's private `levelSet` and `res`,
so the discharge is by definitional unfolding. The cost of public definitions is the four definitions above plus
`FibreShareBound`: about 30 lines, far below the coordinator's 200.

At 19: `∃ U : ℝ, U < 361 / 4 ∧ FibreShareBound 19 U`, with
`FibreShareBound p U := ∀ φ : V p → ℝ, (∀ x, 0 ≤ φ x) → (∀ x, φ x ≤ 1) → 0 ≤ qform p φ → ∑ x, φ x ≤ U` — the shape of
`sum_le_eleven` and of FS131-IKC4's `sum_le_nineteen` (same `V 19`, same `qform 19`, same order of hypotheses), so the
landing discharges it by `⟨_, by norm_num, FibreCertSound.sum_le_nineteen⟩`. **The constant is a parameter** (my
choice, as the brief allowed); IKC4's `U = 8864340098471101020193379809808304 / 10^32 = 88.643…` clears `361/4 = 90.25`.

### 2.2 What was built (three new modules, 753 lines)

* `Arith/FibreShareIneq` (275 lines; Mathlib and `Arith/RatioBound`): FS-66's L2 in the abstract, by characters, on
  finite abelian groups `π : G → H`. `fibreShare_le`: with Hensel's count (`π` carries `S` into `T`, `c` points over each
  point of `T`) and L1 (`Re Σ_S ψ ≥ −2c` for every character not trivial on `ker π`), a set `I` with no difference in `S`
  has `c·|H|·Σ_y Σ_{t∈T} n(y)·n(y + t) ≤ 2c·(|G|·|I| − |H|·Σ_y n(y)²)`. The route is SOUNDNESS § 2 with no adjacency
  operator. The characters trivial on the kernel are exactly the `χ ∘ π` (`exists_eq_compAddMonoidHom`, injective by
  Mathlib's `compAddMonoidHom_injective_left`). Their part of `Σ_ψ |f̂(ψ)|²·Re λ_ψ = 0` is the weighted triple sum on `H`
  (`sum_weighted_sq_mul_charSum`). The rest is at least `−2c` times its Parseval mass. Also `card_fibre_mul` (every fibre
  has `|G|/|H|` points). The model is `fibreShare_le_model`.
* `Rigidity/CertLink` (424 lines): the definitions above; `fibreShareBound_eleven` (`sum_le_eleven`); the tower's maps
  (`finite_quotient_pow`, `toLevelOne_mk`, `toLevelOne_surjective`, `toLevelOne_mem_normOneSet`,
  `zero_notMem_normOneSet`); **K3** `exists_addEquiv_zmod`; **K4** `card_le_of_fibreShareBound`; **K5 and the
  composition** `ratioAtMost_eleven`, `ratioAtMost_nineteen`, `ratioAtMost_cert_link`. One private helper,
  `exists_I_mem` (`i` is an integer of `F(i)`). It is the fourth copy in the library of an 8-line private fact; `UpperHalf`,
  `ThreeFourColours` and `ClassRatio` hold the other three (inventory: generalization).
* `Rigidity/CertLinkModels` (54 lines): `exists_stablePrime_sqrt_three` (a stable prime of `ℚ(√3)` not above 2 with
  `|𝓞 ⧸ P| = 3²`, from `ThreeFourColours.exists_maximal_card_nine_sqrt_three` and `exists_stablePrime_card_nine`; on Weil's
  bound through them) and `exists_addEquiv_zmod_sqrt_three` (K3 there).

**K3 as built** is an additive isomorphism `e : 𝓞 ⧸ P^1 ≃+ ZMod q × ZMod q` with `x ∈ normOneSet P 1 ↔ (e x).1² + (e x).2² = 1`.
It is the plan's graph isomorphism `levelTarget P 1 ≃g Cay((ℤ/q)², S)` in the form the transport reads. The coordinates are
`ClassRatio`'s private `charBound_one_of_circleCos` restated as maps: `A x = e₀(u(x + x̄))` and `B x = e₀(−uι(x − x̄))`, with
`u = 1/2` and `e₀ : k₀ ≃+* ZMod q` the fixed field. **K4 as built**: with
`φ(v) = n(e⁻¹v)/K`, `K = |𝓞 ⧸ P^{n+1}|/|𝓞 ⧸ P|` the fibre size, `0 ≤ φ ≤ 1`, `K²·q(φ) = 2Σ n(K − n) − Σ_u Σ_t n_u n_{u+t} ≥ 0`
by `fibreShare_le`, and `Σ φ = |I|/K ≤ U` gives `|I| ≤ (U/q²)·|𝓞 ⧸ P^m|`. **K5**: `U₁₁/121 < 1/4` by `norm_num`; at 19,
`U < 361/4` is the hypothesis's own clause.

**The statements, read aloud against the informal claims.**
* `card_le_of_fibreShareBound` — at a stable prime `P` of `F(i)` not above 2 with `|𝓞 ⧸ P| = q²`, `q` prime: if every
  norm-one residue at level one has `q^n` lifts at level `n+1`, every character new above level one sums to at most `2qⁿ`
  over the norm-one set, and FS-66's region at `q` has total mass at most `U`, then every independent set of
  `levelTarget P m`, `m ≥ 1`, has at most `(U/q²)·|𝓞 ⧸ P^m|` points. This is SOUNDNESS § 0's claim with L1 and L2
  carried to the ring `𝓞 ⧸ P^m`, symbol for symbol except that `p^{2(k−1)}·U` is written `(U/q²)·|𝓞 ⧸ P^m|`.
* `ratioAtMost_cert_link` — `ratioAtMost_cert`'s statement with `RatioAtMost P c` written out, and `HenselCount P Q`,
  `NewCharBound P Q` and the bound at 19 as hypotheses. `ratioAtMost_eleven`: the same at `Q = 11` with no hypothesis
  at 19. `ratioAtMost_nineteen`: at `Q = 19` over the bound at 19.

**Proved: K3, K4, K5 and the composition.** The q = 11 case rests on the standard three (over its two hypotheses), and so
does the q = 19 case over its third. Each statement has a model, with one gap: `HenselCount` and `NewCharBound` cannot
be inhabited in this module's closure, since they are ClassRatio's theorems. The full model of `card_le_of_fibreShareBound`
is therefore drafted for the landing (§ 4.3).

### 2.3 The scratch checks (brief item 3)

`tools/fs131_ikl1_scratch.py` writes a copy of `ClassRatio` with four insertions, each asserted to apply once:
1. `import Proofs.HadwigerNelson.Rigidity.CertLink`;
2. a stand-in `FibreCertSound.sum_le_nineteen := sorry` (IKC4's statement as the coordinator printed it; scratch only);
3. the two discharge lemmas, before `ratioAtMost_cert`;
4. the one line, in place of the leaf's `sorry`.

It also appends a footer that prints each consumer's axioms and the leaves its `sorryAx` comes from (after FS131-IN1's
`AxiomsCore`). Each copy is compiled as the module `Proofs.HadwigerNelson.Rigidity.ClassRatio` (`lean -R`) into a farm, a
symlink copy of the tree's compiled library (`data/fs131/ikl1/farm.sh`), so the tree's own library is untouched.

* **Against wcm4's ClassRatio** (the coordinator's final names; `git show fs131-wcm4:…` at `ff3ac0c73`). wcm4's two new
  modules, `Arith/BinaryField` and `Arith/DyadicCerts`, were compiled into the farm from that commit; **fs131-wcm4 was not
  merged**, and my branch is unchanged by this check. The discharge is 21 lines (`scratch/discharge-wcm4.lean.txt`, § 4.1).
  Output (`scratch/compile-wcm4.out`):
  `SORRY-FROM ratioAtMost_of_five_le_chromaticNumber : [FibreCertSound.sum_le_nineteen]`, with axioms
  `[Classical.choice, StandingFive.kloosterman_bound, Quot.sound, propext, sorryAx]`; the same for
  `tca_of_five_le_localBound`, `ratioAtMost_of_two_notMem` and `ratioAtMost_cert`. `henselCount_of_two_notMem`,
  `newCharBound_of_two_notMem` and `CertLink.ratioAtMost_cert_link` are on the standard three. **So once IKC4's
  `sum_le_nineteen` replaces the stand-in, the chain's per-prime leaf is free of `sorry`.** Control (`--plant`: the leaf's
  body left `sorry`): every consumer's `SORRY-FROM` then names `ratioAtMost_cert` itself (`compile-wcm4-plant.out`).
* **Against this branch's ClassRatio** (wcm3's names, `scratch/discharge.lean.txt`, 53 lines: the odd Lemma P chain's
  `card_res_fibre`, `norm_charSum_new_le`, `exists_addChar_descent`, `card_fibre`, by induction). Same verdict, with the two
  dyadic children `charSum_64_ge` and `colorable_four_dyadic_small` also named, since wcm3 has not proved them
  (`compile-wcm3.out`).
* **The import changes no stored statement of ClassRatio.** Every constant of the scratch module was compared with the
  real module's (`tools/fs131_ikl1_statements.py`). Against wcm3 (my merged build's dump): **SAME 230, CHANGED 0, MISSING 0**.
  Against wcm4 (FS131-ICM4's last dump, `data/fs131/icm4/statements-after2.txt.xz` on `fs131-wcm4`, its ClassRatio module extracted to `scratch/icm4-classratio.txt.xz`; no `Proofs/` change after it): **SAME 173, CHANGED 0,
  MISSING 0**. Only the new declarations and their generated names were added (16 ADDED-ALLOWED: the two lemmas, the
  stand-in, the footer). Controls 3/3 in each run (`scratch/statements-wcm3.out`, `statements-wcm4.out`).
