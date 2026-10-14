# FS131-KN8 — the five-colour chain, next: what the split reads, typed; the split's module typed; the zero-entropy side's second module

*de Bruijn, the planner; the fourth on this chain, after FS131-KN3, FS131-KN6 and FS131-KN7. Brief:
`data/fs131/briefs/FS131-KN8-chain-split.md` (on `main`). Branch `fs131-wk8`, cut from `fs131-wk7` at `6b7ec2426`, in the
worktree `.claude/worktrees/fs131-wq1`. Claims: `data/fs131/claims-NF2.md`. Stands on `plans/FS131-KN7-chain-next.md` (cited
KN7 § n), `plans/FS131-KN6-chain-first-layer.md` (KN6 § n), `plans/FS131-KN3-chain-plan.md` (KN3 § n) and the deriver's
`plans/FS131-EN2-derivation.md` (EN2 § n), `plans/FS100-X02D-derivation.md` (X02D), `plans/FS100-X01D-derivation.md` (X01D),
the last three on `main`. Working files: `data/fs131/kn8/`.*

## Theorems this phase proved

(Filled at the hand-back.)

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_kn8_readback.py` (KN7's tool with the brief's path changed): every line `> <text>` of the brief whose next line
is `> — source: <path>` must be one whole line of that file, character for character. Run against `main`'s tree, where the
brief and its sources live:

- `quotations=6 identical=6 differing=0`, exit 0 (`data/fs131/kn8/logs/readback.out`): W2
  (`data/fs131/REQUEST-2026-10-13.md`); NF2-NC, NF2-LEAF-20, NF2-LEAF-21 and the dated line of 2026-10-14 narrowing
  NF2-LEAF-20 (`data/fs131/claims-NF2.md`); item 750 (`plans/FS131-close-inventory.md`).
- Control (`--plant`: the last character of every matching source line changed in memory): `identical=0 differing=6`, exit 1
  (`readback-control.out`).
- The words item 750 quotes from the last planner ("clause (4) now uses `borel (X ⧸ G j)` …", "`EntropySplit` asks for
  entropy zero at one rotation …", "M7b is planned in words only, and M8b was not reached") are in KN7's record § 3.1, § 6.1
  and § 6.4 in substance; its report is on `fs131-wk7` and I did not re-run a byte check on it.

No mismatch: nothing for the coordinator from the readback of text.

### 1.2 The declared theorem, the split and its consumer, as the kernel prints them

`data/fs131/kn8/lean/Readback.lean` against the tree's compiled library (`logs/lean-Readback.log`; its four errors are
in the Mathlib name checks below it, none in the prints):

```
@positive_entropy_rigidity : ∀ {X : Type u_1} [inst : AddCommGroup X] [inst_1 : TopologicalSpace X]
  [inst_2 : MeasurableSpace X] [BorelSpace X],
  IsSolenoid X → ∀ {d : ℕ}, 2 ≤ d → ∀ (α : ZdAction d X), α.NoVirtuallyCyclicFactors →
  ∀ (μ : Measure X), IsProbabilityMeasure μ → α.IsErgodicOn ⊤ μ →
  ∃ Λ J ν G, Λ.FiniteIndex ∧ 0 < J ∧ μ = (↑J)⁻¹ • ∑ j, ν j ∧ (∀ (i j : Fin J), i ≠ j → ν i ⟂ₘ ν j) ∧
    ∀ (j : Fin J), IsProbabilityMeasure (ν j) ∧ α.IsErgodicOn Λ (ν j) ∧
      (IsClosed ↑(G j) ∧ α.InvariantOn Λ (G j) ∧
        ∀ g ∈ G j, ∀ (B : Set X), MeasurableSet B → (ν j) ((fun x => x + g) ⁻¹' B) = (ν j) B) ∧
      (∀ (n : Fin d → ℤ), ∃ k, Measure.map (⇑(α.toFun n)) (ν j) = ν k ∧ AddSubgroup.map (α.toFun n) (G j) = G k) ∧
      ∀ n ∈ Λ, ∀ (h : G j ≤ AddSubgroup.comap (α.toFun n) (G j)),
        ksEntropy (Measure.map (⇑(QuotientAddGroup.mk' (G j))) (ν j)) ⇑(QuotientAddGroup.map (G j) (G j) (α.toFun n) h) = 0

def HadwigerNelson.Rigidity.EntropySplit : Subfield ℝ → Prop := fun F =>
  ∀ (τ : Measure (Dual F)), IsFiniteMeasure τ → RotInv F τ →
    ∃ a b m ρ, IsHaarFourier m ∧ IsProbabilityMeasure ρ ∧ RotInv F ρ ∧
      (∃ u, (∀ (n : ℕ), n ≠ 0 → ↑u ^ n ≠ 1) ∧ ksEntropy ρ (rot u) = 0) ∧ τ = a • m + b • ρ

mrPlus_of_split_of_carried : ∀ (F : Subfield ℝ), EntropySplit F → ZeroEntropyCarried F → MRPlus F
'HadwigerNelson.Rigidity.mrPlus_of_split_of_carried' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The default print of clause (4) hides the σ-algebra on `X ⧸ G j`; KN7 § 3.2 read it with every argument shown
(`@ksEntropy (X ⧸ G j) (borel (X ⧸ G j)) (@Measure.map … (borel (X ⧸ G j)) …)`) and nothing has touched the module since
(the tree is KN7's last commit). As item 750 says, the consumer is on the standard three axioms.

### 1.3 The last planner's § 6.3, restated (M7b, the split's own module, as left in words)

M7b proves `entropySplit` from M7a (`Rigidity/HaarMultiple`), Lemma Γ, the release's ergodic decomposition
(`action_ergodic_decomposition`, lane P2) and mixture lemma (`ksEntropy_bind_eq_zero`, lane E's leaf 9 over P), Fourier
uniqueness and Haar existence. Its vocabulary, as decided there:
1. the unit vectors as a group, `unitCircle F : Subgroup Circle` (the `z` with `(z : ℂ) ∈ planeOver F`), with
   `unitVectors F ≃ unitCircle F`;
2. the rotation action `MulAction (unitCircle F) (Dual F)`, `g • χ = rot g χ`, owing `rot (u * v) = rot u ∘ rot v` and
   `rot 1 = id`; a subgroup `Γ` acts by restriction and is countable;
3. admissibility in X02D's operational form or in the page's ("every finite-index subgroup generates `F(i)`") — the M6
   planner's call;
4. `StandardBorelSpace (Dual F)` for the cylinder σ-algebra.

Its statements, in the deriver's order (EN2 § 5.2): (a) `RotInv` of `τ − maxMultiple τ m • m`; (b) step 2, the Haar set of
the kernel is null; (c) step 3, entropy zero at every `γ ∈ Γ`; (d) `entropySplit` from (a)–(c) and a non-torsion generator,
with `b = 0` and `ρ` the point mass at the trivial character when the remainder is `0`. Lemma Γ belongs with the pieces (M6)
and `haar_or_zero_entropy` (M5), whose proof may take `[PolishSpace X]`.
