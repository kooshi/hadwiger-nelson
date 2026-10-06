#!/usr/bin/env python3
"""FS131-L10A, stage 3: the ruled tidies (rulings 494 (a), 507 (a)), as exact text replacements.

  data/fs131/l10a/tidy.py sr <path-to-StationaryRatio.lean>
  data/fs131/l10a/tidy.py si <path-to-SpectralInputs.lean>
  data/fs131/l10a/tidy.py ax <path-to-scripts/Axioms.lean>

Every replacement names its old text whole and must match exactly once, or the script stops and
writes nothing: a file that is not the one these edits were read against is refused.
"""
import sys


def apply(path, edits):
    s = open(path, encoding="utf-8").read()
    for i, (old, new, count) in enumerate(edits, 1):
        n = s.count(old)
        if n != count:
            sys.exit(f"edit {i}: expected {count} occurrence(s), found {n}: {old[:80]!r}")
        s = s.replace(old, new)
    open(path, "w", encoding="utf-8").write(s)
    print(f"{path}: {len(edits)} edit(s) applied")


SR = [
    # --- the module docstring: the rows, at the class their proofs read; the inhabitants, now declarations
    ("""(`StationarySet.AEIndependent`) — no Haar measure on `G` enters the definition, so the rows are stated for measurable groups
and σ-finite symmetric `ν`, a wider class than the entry's "LCA Cayley graphs".
""",
     """(`StationarySet.AEIndependent`) — no Haar measure on `G` enters the definition, so the rows are stated for commutative groups
with a σ-algebra and a measurable negation, and σ-finite symmetric `ν`: a wider class than the entry's "LCA Cayley graphs".
**Each row is stated at the class its proof reads** (FS131-I10B's findings; inventory ruling 507 (a)): no measurable addition
anywhere, and in X25B-L1 any family of open subgroups entering every neighbourhood of `0`, an s-finite `ν_Y`, any `ν_X`.
""", 1),
    ("""* **X25B-L1** (`ratio_prod_le_iSup_levels`): for a compact `Y` with open subgroups `K_k` shrinking to `0`,
""",
     """* **X25B-L1** (`ratio_prod_le_iSup_levels`): for a compact `Y` with open subgroups `K_k` entering every neighbourhood of `0`,
""", 1),
    ("""**Inhabitant.** `StationarySet.empty` (one point, the empty event) is a.e.-independent for every `ν`
(`StationarySet.empty_aeIndependent`); a model with `P(B) = 1/2` is `ZMod 2` acting on itself with `B = {0}`, `ν = δ₁`.
""",
     """**Inhabitants.** `StationarySet.empty` (one point, the empty event) is a.e.-independent for every `ν`
(`StationarySet.empty_aeIndependent`); a model with an edge and `P(B) = 1/2` is `StationarySet.parity` — `ZMod 2` acting on
itself with `B = {0}`, a.e.-independent for `ν = δ₁` (`StationarySet.parity_aeIndependent`, `parity_prob`), where the ratio is
evaluated (`ratio_dirac_one_zmod_two`); X25B-L1's levels at a profinite factor that is not finite are `cantorLevel` on
`ℕ → ZMod 2` (`exists_cantorLevel_subset`). The three rows are instantiated at these in the Spec section.
""", 1),
    # --- X25B-P: the name on the general statement, the twin's wrapper deleted
    ("""/-- X25B-P at the class its proof reads (FS131-I10B): a measurable negation and a σ-finite symmetric `ν`; the group's
addition need not be measurable. `prob_le_ratio_mul` is this with one more instance argument. -/
theorem StationarySet.prob_le_ratio_mul_of_symm [MeasurableNeg G] (W : StationarySet G) {ν : Measure G}
""",
     """/-- **X25B-P** (Zhang's Prop. 1.7, stationary form; a child of X25B-PZ, not a backlog row): "If `A` is a `G`-stationary random
a.e.-independent set, `P(0 ∈ A) ≤ r(G,T)·P(0 ∈ N[A])`." At the class its proof reads: a measurable negation and a σ-finite
symmetric `ν`; the group's addition need not be measurable. Inhabitant of the hypotheses: `StationarySet.parity` with `ν = δ₁`
(`map_neg_dirac_one`, `StationarySet.parity_aeIndependent`), where it reads `1/2 ≤ r · P(N[A])` (the Spec section). -/
theorem StationarySet.prob_le_ratio_mul [MeasurableNeg G] (W : StationarySet G) {ν : Measure G}
""", 1),
    ("""/-- **X25B-P** (Zhang's Prop. 1.7, stationary form; a child of X25B-PZ, not a backlog row): "If `A` is a `G`-stationary random
a.e.-independent set, `P(0 ∈ A) ≤ r(G,T)·P(0 ∈ N[A])`." -/
theorem StationarySet.prob_le_ratio_mul [MeasurableAdd₂ G] [MeasurableNeg G] (W : StationarySet G) {ν : Measure G}
    [SigmaFinite ν] (hsymm : ν.map Neg.neg = ν) (hW : W.AEIndependent ν) :
    W.P W.B ≤ ratio ν * W.P (W.B ∪ W.nbhd ν) := by
  -- `MeasurableAdd₂ G` is not read by the proof (FS131-I10B, a finding; the form without it is
  -- `prob_le_ratio_mul_of_symm`): consumed here for the unused-arguments linter.
  have _ := ‹MeasurableAdd₂ G›
  exact W.prob_le_ratio_mul_of_symm hsymm hW

""", "", 1),
    # --- X25B-PZ's proof calls X25B-P in each factor: the name alone changes
    ("""  have hPY := (W.pull (AddMonoidHom.inr G H) hinr _ hY).prob_le_ratio_mul_of_symm hH hWH
  have hPA := (W.pull (AddMonoidHom.inl G H) hinl _ hA).prob_le_ratio_mul_of_symm hG hWG
""",
     """  have hPY := (W.pull (AddMonoidHom.inr G H) hinr _ hY).prob_le_ratio_mul hH hWH
  have hPA := (W.pull (AddMonoidHom.inl G H) hinl _ hA).prob_le_ratio_mul hG hWG
""", 1),
    # --- X25B-PZ
    ("""/-- X25B-PZ at the class its proof reads (FS131-I10B): measurable negations and σ-finite symmetric connection measures;
neither addition need be measurable. `ratio_prod_le` is this with two more instance arguments. -/
theorem ratio_prod_le_of_symm {H : Type*} [AddCommGroup H] [MeasurableSpace H] [MeasurableNeg G] [MeasurableNeg H]
""",
     """/-- **X25B-PZ**: "the stationary ratio of a categorical product of two LCA Cayley graphs is at most the larger factor's"
(Zhang 2012 §2's argument, measure form). At the class its proof reads: commutative groups with a σ-algebra, measurable
negations and σ-finite symmetric connection measures; neither addition need be measurable. Inhabitant of the hypotheses:
`G = H = ZMod 2`, `ν_G = ν_H = δ₁` (`map_neg_dirac_one`), where it reads `r(K₂ × K₂) ≤ 1/2` (the Spec section). -/
theorem ratio_prod_le {H : Type*} [AddCommGroup H] [MeasurableSpace H] [MeasurableNeg G] [MeasurableNeg H]
""", 1),
    ("""/-- **X25B-PZ**: "the stationary ratio of a categorical product of two LCA Cayley graphs is at most the larger factor's"
(Zhang 2012 §2's argument, measure form) — for measurable groups and σ-finite symmetric connection measures. -/
theorem ratio_prod_le {H : Type*} [AddCommGroup H] [MeasurableSpace H] [MeasurableAdd₂ G] [MeasurableNeg G]
    [MeasurableAdd₂ H] [MeasurableNeg H] (νG : Measure G) (νH : Measure H) [SigmaFinite νG] [SigmaFinite νH]
    (hG : νG.map Neg.neg = νG) (hH : νH.map Neg.neg = νH) :
    ratio (νG.prod νH) ≤ max (ratio νG) (ratio νH) := by
  -- `MeasurableAdd₂ G` and `MeasurableAdd₂ H` are not read by the proof (FS131-I10B, a finding; the form without them
  -- is `ratio_prod_le_of_symm`): consumed here for the unused-arguments linter.
  have _ := ‹MeasurableAdd₂ G›
  have _ := ‹MeasurableAdd₂ H›
  exact ratio_prod_le_of_symm νG νH hG hH

""", "", 1),
    # --- X25B-L1
    ("""/-- X25B-L1 at the class its proof reads (FS131-I10B): any family of open subgroups of a compact second-countable group
`Y` that enters every neighbourhood of `0` — not a decreasing sequence — an s-finite `ν_Y`, any `ν_X` on any measurable
group `X`, and no separation axiom on `Y`. `ratio_prod_le_iSup_levels` is the case of a decreasing sequence. -/
theorem ratio_prod_le_iSup_levels_of_shrink {ι X Y : Type*} [AddCommGroup X] [MeasurableSpace X] [AddCommGroup Y]
""",
     """/-- **X25B-L1**: "a profinite factor's stationary ratio in a product is at most the supremum over its finite levels (fibre
shares above `1/2` form an a.e.-independent set)". `Y` compact and second countable; the level-`k` graph is `X × Y` with `ν_Y`
smoothed by the Haar probability of `K k` (the pull-back of `X × Y/K_k`). At the class its proof reads: any family
`K : ι → OpenAddSubgroup Y` that enters every neighbourhood of `0` — no order on `ι`, so not only a decreasing sequence — an
s-finite `ν_Y`, any `ν_X` on any commutative group `X` with a σ-algebra, and no separation axiom on `Y`. Inhabitant of the
hypotheses: `Y = ℕ → ZMod 2` with the levels `cantorLevel` (`exists_cantorLevel_subset`), `X = ZMod 2` (the Spec section). -/
theorem ratio_prod_le_iSup_levels {ι X Y : Type*} [AddCommGroup X] [MeasurableSpace X] [AddCommGroup Y]
""", 1),
    ("""/-- **X25B-L1**: "a profinite factor's stationary ratio in a product is at most the supremum over its finite levels (fibre
shares above `1/2` form an a.e.-independent set)". `Y` compact with open subgroups `K k` shrinking to `0`; the level-`k` graph is
`X × Y` with `ν_Y` smoothed by the Haar probability of `K k` (the pull-back of `X × Y/K_k`). -/
theorem ratio_prod_le_iSup_levels {X Y : Type*} [AddCommGroup X] [MeasurableSpace X] [MeasurableAdd₂ X]
    [AddCommGroup Y] [TopologicalSpace Y] [IsTopologicalAddGroup Y] [CompactSpace Y] [LocallyCompactSpace Y] [T2Space Y]
    [SecondCountableTopology Y] [MeasurableSpace Y] [BorelSpace Y] (νX : Measure X) [SigmaFinite νX] (νY : Measure Y)
    [IsFiniteMeasure νY] (K : ℕ → OpenAddSubgroup Y) (hK : Antitone K)
    (hK0 : ∀ V ∈ nhds (0 : Y), ∃ k, (K k : Set Y) ⊆ V) :
    ratio (νX.prod νY) ≤ ⨆ k, ratio (νX.prod (Measure.conv νY (cosetAverage (K k)))) := by
  -- Not read by the proof (FS131-I10B, findings; the form without them is `ratio_prod_le_iSup_levels_of_shrink`):
  -- `MeasurableAdd₂ X`, `SigmaFinite νX`, `T2Space Y`, and that `K` is antitone — one level inside a small neighbourhood
  -- of `0` is enough. Consumed here for the unused-arguments linters.
  have _ := ‹MeasurableAdd₂ X›
  have _ := ‹SigmaFinite νX›
  have _ := ‹T2Space Y›
  have _ := hK
  exact ratio_prod_le_iSup_levels_of_shrink νX νY K hK0

""", "", 1),
    # --- the Spec section: the two instances of X25B-L1 no longer pass an antitone proof
    ("""  ratio_prod_le_iSup_levels _ _ (fun _ => ⟨⊥, isOpen_discrete _⟩) antitone_const
    (fun V hV => ⟨0, fun y hy => by""",
     """  ratio_prod_le_iSup_levels _ _ (fun _ : ℕ => ⟨⊥, isOpen_discrete _⟩)
    (fun V hV => ⟨0, fun y hy => by""", 1),
    ("""  ratio_prod_le_iSup_levels _ _ cantorLevel cantorLevel_antitone fun _ hV => exists_cantorLevel_subset hV
""",
     """  ratio_prod_le_iSup_levels _ _ cantorLevel fun _ hV => exists_cantorLevel_subset hV
-- the levels of the Cantor group do decrease (the row's "finite levels"), though the statement no longer asks it.
example : Antitone cantorLevel := cantorLevel_antitone
""", 1),
]

SI = [
    # --- sp_if: the countability of R is not read (ruling 494 (a)); the gate's sentence on `NegCircle`
    ("""`NegCircle`; Fourier uniqueness is Herglotz–Bochner's uniqueness clause. INHABITANT: over the arithmetic `E` the hypothesis is
the open zero-entropy question; at `Interface.trivial` it is met by the point mass at the trivial character. -/
theorem sp_if (I : Interface F) [Countable (unitRing F)] (hBH : BochnerHerglotz (unitRing F)) (hmul : I.MulStable)
""",
     """`NegCircle`; Fourier uniqueness is Herglotz–Bochner's uniqueness clause. INHABITANT: over the arithmetic `E` the hypothesis is
the open zero-entropy question; at `Interface.trivial` it is met by the point mass at the trivial character. **`hcirc :
I.NegCircle` has no Lean model on file**: `Interface.trivial` meets `MulStable` (its `E` is empty) and, with that point mass
for `ν`, the measure hypotheses, and no declaration proves `NegCircle` of it or of any interface — one is planned at `F = ℚ` by
the parity character (`negCircle_trivial_bot`, `Arith/NegCircleModel`, on the wave's second pass and not on this line), and
until it lands this theorem is an open gate item under the inhabitant rule (`LEAN.md` § The gate). `hBH` is the named
classical hypothesis `BochnerHerglotz`, with no kernel model. -/
theorem sp_if (I : Interface F) (hBH : BochnerHerglotz (unitRing F)) (hmul : I.MulStable)
""", 1),
    ("""  classical
  -- the countability of `R` is not read by this argument
  have _hcount : Countable (unitRing F) := inferInstance
  haveI := hm.1
""",
     """  classical
  haveI := hm.1
""", 1),
    # --- spectral_carried_iff: that μ is a probability measure is not read (ruling 494 (a))
    ("""theorem spectral_carried_iff [IsProbabilityMeasure μ] (t : TopologicalSpace R)
""",
     """theorem spectral_carried_iff (t : TopologicalSpace R)
""", 1),
    ("""  -- that `μ` is a probability measure is not read by this argument (`σ` carries `‖f‖²`)
  have _hprob : IsProbabilityMeasure μ := inferInstance
  letI := t
""",
     """  letI := t
""", 1),
    ("""/-- **J45-N2, first sentence**: "`σ_f(R̂ ∖ E_S) = 0` iff `y ↦ V_y f` is `τ′_S`-continuous" — for a first-countable group topology
`t` on `R` satisfying Bochner's theorem and an action by measure-preserving maps. -/
""",
     """/-- **J45-N2, first sentence**: "`σ_f(R̂ ∖ E_S) = 0` iff `y ↦ V_y f` is `τ′_S`-continuous" — for a first-countable group topology
`t` on `R` satisfying Bochner's theorem and an action by measure-preserving maps of any measure space (`σ` carries `‖f‖²`: that
`μ` is a probability measure is not read). -/
""", 1),
    # --- the module docstring's inhabitants paragraph
    ("""rotation-invariant `E`-null measure — is the open zero-entropy question over the arithmetic `E` (J45 §4.2, "Not claimed"); at
`Interface.trivial` (`E = ∅`) it is met by the point mass at the trivial character.
-/
""",
     """rotation-invariant `E`-null measure — is the open zero-entropy question over the arithmetic `E` (J45 §4.2, "Not claimed"); at
`Interface.trivial` (`E = ∅`) it is met by the point mass at the trivial character. **`Interface.NegCircle` has no Lean model on
file** (one is planned at `F = ℚ`, `Arith/NegCircleModel` on the wave's second pass): `sp_if` is an open gate item until it lands.
-/
""", 1),
]

AX = [
    ("#print axioms HadwigerNelson.StationaryRatio.StationarySet.prob_le_ratio_mul_of_symm\n", "", 1),
    ("#print axioms HadwigerNelson.StationaryRatio.ratio_prod_le_of_symm\n", "", 1),
    ("#print axioms HadwigerNelson.StationaryRatio.ratio_prod_le_iSup_levels_of_shrink\n", "", 1),
    ("""/-! ## FS-131 wave 10 (job FS131-I10B) — the stationary ratio: X25B-P, X25B-PZ, X25B-L1, their forms at the class the
proofs read, the toolkit, and the models (`StationarySet.parity`, `cantorLevel`) -/
""",
     """/-! ## FS-131 wave 10 (job FS131-I10B) — the stationary ratio: X25B-P, X25B-PZ, X25B-L1 (each at the class its proof
reads: the `_of_symm` / `_of_shrink` twins were folded into the rows at the join, FS131-L10A, ruling 507 (a)), the toolkit,
and the models (`StationarySet.parity`, `cantorLevel`) -/
""", 1),
]


def main(argv):
    if len(argv) != 2 or argv[0] not in ("sr", "si", "ax"):
        print(__doc__)
        return 2
    apply(argv[1], {"sr": SR, "si": SI, "ax": AX}[argv[0]])
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
