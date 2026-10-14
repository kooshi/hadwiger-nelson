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
