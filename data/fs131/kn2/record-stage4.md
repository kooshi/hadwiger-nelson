
## Stage 4 — SAVED: a plan per leaf

*For an implementer with none of this record's context. Twenty-four leaves are `sorry`; every other declaration in the three
modules is proved, from the leaves or from the library. **No statement may change**: a change a proof needs comes back through
the coordinator. Names marked ✓ were confirmed with `#check` under the module's own imports
(`data/fs131/kn2/probes/p1.lean`, `p2.lean`, `p3.lean`; outputs in `data/fs131/kn2/logs/`); names marked (read) were read in
Mathlib's or the library's source at the pin and not `#check`ed. I typed no leaf's proof except where a line says "compiled".
No size is given for a leaf I did not type. Iterate with `data/fs131/kn2/lean1.sh <file>` (seconds per run, 3.6 GB).*

Notation: `K = fieldI F` (`F(i) ⊂ ℂ`), `𝓞 = 𝓞 (fieldI F)`, `B = P.localRing`, `σ = conjOn (fieldI_conj F)`.

### A. `Arith/UpperHalf.lean` — twelve leaves, in dependency order

**U1 `mem_localRing`**: `x ∈ P.localRing ↔ ∃ a s : 𝓞, s ∉ P.P ∧ x = (a : K) / (s : K)`.
Route: `P.localRing` is `ValuationSubring.ofSubring (Localization.subalgebra.ofField K _ _).toSubring _`
(`HeightOneSpectrum.valuationSubringAtPrime_toSubring` is `rfl` (read)), whose membership is by definition
`∃ a s (_ : s ∈ P.P.primeCompl), x = algebraMap 𝓞 K a * (algebraMap 𝓞 K s)⁻¹`. The library has this proof verbatim for a
usable prime: `Arith/PlaceHom.lean:113–117` (`rw [ValuationSubring.mem_ofSubring]; show (∃ (a s) (_ : s ∈ _), x = _ * _⁻¹) ↔ _`,
then both directions by `⟨a, s, hs, by rw [div_eq_mul_inv]⟩`). Mathlib destructs the same membership as `⟨a, s, hs, rfl⟩`
(`AdicValuation.lean:486`).

**U2 `conj_mem_localRing`**: `∀ z ∈ B, σ z ∈ B`.
Route: `obtain ⟨a, s, hs, rfl⟩ := (mem_localRing P).1 hz`; give `⟨conjO F a, conjO F s, mt (conjO_mem_iff P).1 hs, _⟩`; the equation is
`map_div₀ σ _ _` with `coe_conjO` (which is `rfl`). The library's general form of this step is
`conj_mem_valuationSubringAtPrime` (`ResidueColouring.lean:501`), stated for ring *equivalences*; `σ` here is a ring
homomorphism, so the three lines above are shorter than adapting it.

**U3 `isUnit_mk_pow`**: for `y ∉ P.P`, `Ideal.Quotient.mk (P.P ^ m) y` is a unit.
Route: `haveI := P.isMaximal`; `Ideal.IsMaximal.exists_inv_pow P.P (hx : ↑y ∉ P.P) m : ∃ z, ∃ i ∈ P.P ^ m, z * ↑y + i = 1` (read,
`Mathlib/RingTheory/Ideal/Operations.lean:1238`); then `IsUnit.of_mul_eq_one` ✓ with `mk z`, the equation by
`Ideal.Quotient.eq` / `Ideal.Quotient.eq_zero_iff_mem` ✓ after `map_mul`, `map_add`.

**U4 `residue_div`**: `P.residue m ⟨a / s, _⟩ * mk s = mk a`.
Route: `Arith/PlaceHom.lean:149–157` verbatim with `L := P.residue m`, `hLa := residue_algebraMap P m`: in `B`,
`⟨a / s, _⟩ * algebraMap 𝓞 B s = algebraMap 𝓞 B a` (`Subtype.ext`, `div_mul_cancel₀`; `s ≠ 0` because `s ∉ P.P` and `0 ∈ P.P`),
then `rw [← residue_algebraMap P m s, ← map_mul, key, residue_algebraMap]`.

**U5 `residue_conj`**: `P.residue m ⟨σ z, _⟩ = Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) (P.residue m z)`.
Route: two ring homomorphisms `B →+* 𝓞 ⧸ P.P ^ m` — `(P.residue m).comp (σ.restrict B.toSubring B.toSubring (conj_mem_localRing P))`
and `(Ideal.quotientMap …).comp (P.residue m)` — agree on `algebraMap 𝓞 B a` (the first is `mk (conjO F a)` by
`residue_algebraMap` after `Subtype.ext rfl`; the second by `residue_algebraMap` and `Ideal.quotientMap_mk` ✓), so they are
equal by `IsLocalization.ringHom_ext` ✓ at `M := P.heightOne.asIdeal.primeCompl`; apply at `z`. The `restrict` form is the one
`colorable_two_unitDistance_induce_of_valuationSubring` states (`TwoColourResidue.lean:149`), so U10 reads this lemma with no
re-proof.

**U6 `coe_mem_nonunits_localRing_iff`**: `(a : K) ∈ B.nonunits ↔ a ∈ P.P`.
Route: `ValuationSubring.mem_nonunits_iff_exists_mem_maximalIdeal` ✓ (used at `PlaceHom.lean:254`), or elementary through
`x ∈ B.nonunits ↔ x = 0 ∨ x⁻¹ ∉ B` (the library uses `ValuationSubring.mem_nonunits_iff_or` at `UnitRing.lean:112` (read)).
(⟸) `a ∈ P.P`, `a ≠ 0`: if `a⁻¹ = b / s` with `s ∉ P.P` then `s = a * b` in `𝓞` (`RingOfIntegers.coe_injective` (read)), so
`s ∈ P.P`. (⟹, contrapositive) `a ∉ P.P` gives `a⁻¹ = 1 / a ∈ B` by U1 and `a ∈ B`, so `a` is a unit of `B`. Mathlib's
`IsLocalization.AtPrime.to_map_mem_maximal_iff` ✓ is the same fact on `B` as a localization, if the instance route is smoother.

**U7 `localRing_ne_top`**. Route: Mathlib proves it inside `valuationSubringAtPrime_eq_valuationSubring`
(`AdicValuation.lean:509–512`): `rw [HeightOneSpectrum.valuationSubringAtPrime_eq_valuationSubring]` ✓, then that proof's last
line (`by simp only [ne_eq, Valuation.valuationSubring_eq_top_iff, not_not]; infer_instance` — note it is written there for
the negated form; read the three lines before copying). Elementary alternative: `P.heightOne.ne_bot` gives `a ∈ P.P`, `a ≠ 0`
(`Submodule.exists_mem_ne_zero_of_ne_bot` ✓); `a⁻¹ ∈ ⊤`; contradiction with U6.

**U8 `exists_hom_levelTarget` — the module's main leaf.** `∃ h : (unitDistance ℂ).induce (planeOver F) →g levelTarget P m, ∀ x y hd, h x - h y = P.residue m ⟨_, hd⟩`, for `1 ≤ m`.
The template is `Arith.exists_hom_of_isPlaceHom` (`Arith/PlaceHom.lean:308–361`), which builds the same homomorphism at a
usable prime with two real coordinates; here there is one complex coordinate. Steps, with `k := 𝓞 ⧸ P.P ^ m`, `r := P.residue m`:
1. `A : AddSubgroup ℂ := (B.toSubring.map K.subtype).toAddSubgroup`; `e := Subring.equivMapOfInjective B.toSubring K.subtype Subtype.val_injective` ✓ and `ψ : A →+ k := (r.comp e.symm.toRingHom).toAddMonoidHom` (the pair `e`, `r'.comp e.symm.toRingHom` is built at `PlaceHom.lean:189–191`).
2. `h x := cosetResidue ψ (x : ℂ)` (`ResidueColouring.lean:193`; reason through `cosetResidue_sub`, `cosetResidue_apply_of_mem`, never by unfolding — the definition is sealed).
3. The formula: from `hd`, `(x : ℂ) - y ∈ A` (`⟨_, hd, rfl⟩`); `rw [cosetResidue_sub ψ hmem, cosetResidue_apply_of_mem ψ hmem]`; `e.symm ⟨_, _⟩ = ⟨_, hd⟩` by `RingEquiv.symm_apply_eq` and `Subtype.ext rfl` (as `PlaceHom.lean:213–214`).
4. Adjacency. `dist x y = 1` gives `u * σ u = 1` for `u := (⟨x, x.2⟩ - ⟨y, y.2⟩ : K)`: `sub_mem_normOne_conj_iff.mpr` (`ResidueColouring.lean:538`) then `Subtype.ext` and `simpa [mem_normOne, map_sub]`, exactly `ResidueColouring.lean:608–612`. So `hd : u ∈ B` by `mem_localRing_of_mul_conj_eq_one` (proved), and with `t := r ⟨u, hd⟩`: `t * quotientMap … t = r ⟨u, _⟩ * r ⟨σ u, _⟩ = r 1 = 1` by `residue_conj`, `← map_mul`, `Subtype.ext hu`, `map_one`.
5. `SimpleGraph.fromRel_adj` ✓: `h x ≠ h y ∧ (rel ∨ rel')`. The relation's left disjunct is step 4 after `rw` with the formula. `h x ≠ h y`: otherwise `t = 0` and `0 = 1` in `k`, but `k` is nontrivial: `Ideal.Quotient.nontrivial_iff` ✓ with `P.P ^ m ≠ ⊤` from `Ideal.pow_le_self (by omega) : P.P ^ m ≤ P.P` ✓ and `P.isMaximal.ne_top`.
What is hard: nothing mathematical. The friction is the three faces of one point — `x : planeOver F`, `⟨x, x.2⟩ : K`, `(x : ℂ)` —
which are definitionally one (`mem_fieldI` is `Iff.rfl`); when `simp` will not see through it, `show` the form wanted.

**U9 `two_mem_of_conj_trivial`**: `hram` gives `2 ∈ P.P`.
Route: `StandingFive.lean:760–775` builds `iO : 𝓞 (fieldI standingField)` with `iO_sq`, `conjO_iO` for one field; do the same
for any `F` (`Complex.I ∈ fieldI F`: `SpectralChain.lean:639`'s example; integral: a root of `X² + 1`, or `IsIntegral.of_pow` ✓
from `I ^ 2 = -1`). Then `StandingFive.lean:1150–1163` (`exists_conjO_sub_notMem`, second branch) is this argument in the
other direction: `conjO i - i = -(2 * i) ∈ P.P`, primality gives `2 ∈ P.P` or `i ∈ P.P`, and `i ∈ P.P` gives `-1 = i² ∈ P.P`.

**U10 `colorable_two_planeOver_of_ramified`**.
Route: `colorable_two_unitDistance_induce_of_valuationSubring (fieldI_conj F) B (conj_mem_localRing P) (k := 𝓞 ⧸ P.P ^ 1) (P.residue 1) hψσ (S := planeOver F) (fun _ hz => hz)` ✓ (`TwoColourResidue.lean:146`). It asks `[IsReduced k] [CharP k 2]`: with
`e : P.P ^ 1 = P.P := pow_one _`, `(P.P ^ 1).IsMaximal` (rewrite `e`), `Ideal.Quotient.field` ✓ makes `k` a field (reduced), and
`CharTwo.of_one_ne_zero_of_two_eq_zero` ✓ gives `CharP k 2` from `mk 2 = 0` (U9, `Ideal.Quotient.eq_zero_iff_mem`). `hψσ z`:
`residue_conj` turns the left side into `quotientMap … (P.residue 1 z)`, and `quotientMap (P.P ^ 1) (conjO F) _ = RingHom.id _`
by `Ideal.Quotient.ringHom_ext` ✓ (`mk (conjO F a) = mk a` because `conjO F a - a ∈ P.P = P.P ^ 1`).

**U11 `exists_stablePrime_of_valuationSubring`**: `A ≠ ⊤`, `A` conjugation-stable ⟹ `∃ P, P.localRing = A`.
Steps: (1) `𝓞 ⊆ A`: `x : 𝓞` is integral over `ℤ` (`RingOfIntegers.isIntegral_coe` ✓), hence over `A` (`IsIntegral.tower_top` ✓),
hence in `A` (`IsIntegrallyClosed.isIntegral_iff` ✓; `IsIntegrallyClosed A` and `IsFractionRing A K` are instances —
`Mathlib/RingTheory/Valuation/LocalSubring.lean:38`, and the probe's `inferInstance`). (2) `Q := {a : 𝓞 | (a : K) ∈ A.nonunits}`
as an ideal — the comap of `IsLocalRing.maximalIdeal A` along the inclusion `𝓞 →+* A` — prime (`Ideal.comap_isPrime` ✓).
(3) `Q ≠ ⊥`: otherwise every nonzero `a : 𝓞` is a unit of `A`, every `a / s ∈ A`, and every `x : K` is such a quotient
(`IsFractionRing.div_surjective` ✓ for `𝓞`), so `A = ⊤`. (4) `Q` maximal: `Ideal.IsPrime.isMaximal` ✓ (a nonzero prime of a
Dedekind domain). (5) `Q.comap (conjO F) = Q`: `σ` maps `A` into `A` and is an involution (`conjOn_conjOn`), so it preserves units
and non-units of `A`. (6) With `P := ⟨Q, _, _⟩`: `P.localRing ≤ A` (`a / s` with `s ∉ Q` a unit of `A`), and
`ValuationSubring.eq_of_le_of_ne_top` ✓ (`[Ring.KrullDimLE 1 P.localRing]` is Mathlib's instance, `AdicValuation.lean:499`)
gives `P.localRing = A`.
What is hard: step (2)–(3)'s bookkeeping between `𝓞`, `A` and `K`; state `hQ : ∀ a : 𝓞, a ∈ Q ↔ (a : K) ∈ A.nonunits` first and
use only it afterwards.

**U12 `inv_natCast_mem_unitRingOver_iff_forall_stablePrime`**.
Route: `rw [UnitRing.inv_natCast_mem_unitRingOver_iff F hn]` ✓ (`UnitRing.lean:191`; its valuation subrings are of
`UnitRing.planeOverSubfield F`, which `fieldI F` abbreviates, and its conjugation is `conjOn (UnitRing.conj_mem_planeOverSubfield F)`,
which `fieldI_conj F` is). (→) at `P`: instantiate with `P.localRing`, `conj_mem_localRing P`, and U6 at `a := (n : 𝓞)`
(`map_natCast` for the cast). (←) a stable `B` with `(n : K) ∈ B.nonunits` is not `⊤` (in `⊤` the nonzero `n` is a unit);
`obtain ⟨P, rfl⟩ := exists_stablePrime_of_valuationSubring B _ hσ`; U6 the other way.

### B. `Arith/QuadraticPrime.lean` — nine leaves

**Q1 `isIntegral_sqrt_natCast`**: `IsIntegral.of_pow (n := 2)` ✓ from `Real.sq_sqrt (Nat.cast_nonneg d)` ✓ and
`isIntegral_algebraMap` ✓ (`((d : ℕ) : ℝ) = algebraMap ℚ ℝ d` by `map_natCast`).

**Q2 `fieldOfRadicands_eq_adjoin`**: `unfold fieldOfRadicands; rw [IntermediateField.adjoin_toSubfield]` ✓, then `le_antisymm`:
`Subfield.closure_mono Set.subset_union_right` ✓, and `Subfield.closure_le` with the range of `algebraMap ℚ ℝ` inside every
subfield (`eq_ratCast`, `SubfieldClass.ratCast_mem`). Template: `Arith/PlaceHom.lean:83–95`.

**Q3 `numberField_fieldOfRadicands`**: the structure is `{ to_finiteDimensional := _ }` (as `SpectralChain.lean:270`). The
inclusion `fieldOfRadicands D → IntermediateField.adjoin ℚ S` (`S := (fun d : ℕ => √d) '' D`; membership by Q2) is an injective
`ℚ`-linear map, so `Module.Finite.of_injective` ✓ (the pattern of `StandingFive.lean:701`) with
`IntermediateField.finiteDimensional_adjoin` ✓ — it asks `[Finite ↑S]` (`(hD.image _).to_subtype`) and
`∀ x ∈ S, IsIntegral ℚ x` (Q1).

**Q4 `isMaximal_ker_and_card`** (compiled, `data/fs131/kn2/probes/p3.lean`):
`haveI : Fact p.Prime := ⟨hp⟩; have hs := ZMod.ringHom_surjective f; exact ⟨RingHom.ker_isMaximal_of_surjective f hs, by rw [Nat.card_congr (RingHom.quotientKerEquivOfSurjective hs).toEquiv, Nat.card_zmod]⟩`.

**Q5 `exists_ringHom_zmod_of_padic`**: `∃ f : 𝓞 K →+* ZMod p, ∀ x z, (z : ℚ_[p]) = ι x → f x = PadicInt.toZMod z`.
Route: for `x : 𝓞 K`, `IsIntegral ℤ (ι x)` (`RingOfIntegers.isIntegral_coe x` ✓ pushed along `ι.toIntAlgHom` by `IsIntegral.map` ✓),
so `IsIntegral ℤ_[p] (ι x)` (`IsIntegral.tower_top` ✓), so `ι x` is the image of some `z : ℤ_[p]`
(`IsIntegrallyClosed.isIntegral_iff` ✓; `IsIntegrallyClosed ℤ_[p]` and `PadicInt.isFractionRing` ✓ are instances — both
`inferInstance` in the probe), i.e. `‖ι x‖ ≤ 1` (`PadicInt.norm_le_one` ✓). `g : 𝓞 K →+* ℤ_[p]` is the corestriction of
`ι.comp (algebraMap (𝓞 K) K)` to `PadicInt.subring p` ✓ (`PadicInt.mem_subring_iff` ✓; `ℤ_[p]` is that subring's carrier);
`f := PadicInt.toZMod.comp g`; the specification is `congrArg _ (Subtype.ext h.symm)`.

**Q6 `exists_padicInt_sq_eq`** (Hensel): `d` a nonzero square modulo odd `p` ⟹ `∃ r : ℤ_[p], r ^ 2 = d`.
Route: `hd` gives `s : ZMod p`, `d = s * s`; pick `n : ℕ` with `(n : ZMod p) = s` (`ZMod.natCast_zmod_surjective` ✓). Apply
`hensels_lemma` ✓ to `F := X ^ 2 - C (d : ℤ) : ℤ[X]` at `a := (n : ℤ_[p])`: `aeval a F = a ^ 2 - d` and
`aeval a (derivative F) = 2 * a` (`simp`). `‖a ^ 2 - d‖ < 1` by `PadicInt.norm_int_lt_one_iff_dvd` ✓ from
`(p : ℤ) ∣ n ^ 2 - d` (`ZMod.intCast_zmod_eq_zero_iff_dvd` ✓); `‖2 * a‖ = 1` because `p ∤ 2 * n` (`p` odd; `p ∤ n` since
`s ≠ 0` by `hd0`): the same lemma negated with `PadicInt.norm_le_one` ✓. So `‖aeval a F‖ < 1 = ‖aeval a F'‖ ^ 2`, and the root
`z` has `z ^ 2 = d` (`sub_eq_zero`).

**Q7 `nonempty_ringHom_padic`**: `Nonempty (fieldOfRadicands D →+* ℚ_[p])`.
Route: `IntermediateField.nonempty_algHom_adjoin_of_splits` ✓ at `F := ℚ`, `E := ℝ`, `K := ℚ_[p]`, `S := (fun d : ℕ => √d) '' D`:
for `√d ∈ S`, integral (Q1) and `((minpoly ℚ √d).map (algebraMap ℚ ℚ_[p])).Splits`: `minpoly.dvd ℚ √d` ✓ gives
`minpoly ∣ X ^ 2 - C (d : ℚ)`; map it (`Polynomial.map_dvd` ✓); the image is `(X - C r) * (X - C (-r))` for `r` the root of Q6
in `ℚ_[p]` (`ring_nf` after `simp`), which splits (`Polynomial.Splits.mul` ✓, `Polynomial.Splits.X_sub_C` ✓); conclude with
`Polynomial.Splits.of_dvd` ✓ (it asks the product `≠ 0`: monic). Compose the algebra homomorphism with the inclusion of Q2.
What may cost an iteration: `↥(E.toSubfield)` and `↥E` are one type up to unfolding; if the composition does not elaborate,
write the ring homomorphism by its five fields with `⟨x, Q2 ▸ x.2⟩`.

**Q8 `nonempty_ringHom_zmod_of_ramified_sqrt` — the largest leaf; none of NF1-MODULE's four instances needs it** (it serves
row 52's two values, at 11 in `K(√5)` and `K(√247)`). Statement: `K₀ : Subfield K`, `ι₀ : K₀ →+* ℚ_[p]`, `p` odd, `π ^ 2 = q`,
`p ∣ q`, `p² ∤ q`, `Subfield.closure (K₀ ∪ {π}) = ⊤` ⟹ `Nonempty (𝓞 K →+* ZMod p)`. Children, to be stated as private lemmas in
this order (each smaller than its parent: it removes one of the five things the parent must build):
- (a) **no square root of `q` in `K₀`**: `∀ c : K₀, (c : K) ^ 2 ≠ q`. Else `ι₀ c ^ 2 = q` in `ℚ_[p]` and
  `2 * (ι₀ c).valuation = (q : ℚ_[p]).valuation = 1` (`Padic.valuation_mul`-type lemmas; `Padic.valuation_natCast`/`padicValNat`
  with `hq`, `hq2`) — an even integer equal to 1. So `π ∉ K₀`.
- (b) **coordinates exist**: `∀ x : K, ∃ a b : K₀, x = a + b * π`. The set of such `x` is a subfield containing `K₀` and `π`
  (inverse: `(a + bπ)(a − bπ) = a² − b²q ≠ 0` unless `a = b = 0`, by (a) applied to `a / b`); conclude with `hgen`. The library
  did this for `ℚ(√47)` over `ℚ`: `Instances/SqrtFortySeven.lean:37–190` (`q47`, `mem_q47_of_mem`, `re47`, `im47`, `coords_add`,
  `coords_mul`) — the template, with `ℚ` replaced by `K₀`.
- (c) **coordinates are unique** (from `π ∉ K₀`), so `re, im : K → K₀` with `coords_add`, `coords_mul`
  (`re (x y) = re x re y + im x im y q`), and `conj' : K →+* K`, `a + bπ ↦ a − bπ`, is a ring homomorphism.
- (d) **integers have integral coordinates**: for `x : 𝓞 K`, `‖ι₀ (re x)‖ ≤ 1` and `‖ι₀ (im x)‖ ≤ 1`. `conj' x` is integral
  (`IsIntegral.map` ✓), so `2 re x = x + conj' x` and `re x² − im x² q = x · conj' x` are integral over `ℤ` and lie in `K₀`
  (`isIntegral_algebraMap_iff` ✓ along the injection `K₀ → K`); their images under `ι₀` are in `ℤ_[p]` as in Q5. `p` odd gives
  `‖ι₀ (re x)‖ ≤ 1`; then `‖ι₀ (im x)‖² · ‖q‖ ≤ 1` with `‖q‖ = p⁻¹` and `‖·‖ ∈ p^ℤ` gives `‖ι₀ (im x)‖ ≤ 1` (the parity step).
- (e) **the homomorphism** `x ↦ toZMod (ι₀ (re x))`: additive by `coords_add`; multiplicative because
  `toZMod (ι₀ (im x) · ι₀ (im y) · q) = 0` (`p ∣ q`); `re 1 = 1`.
What is hard: (d)'s parity step, and keeping `K₀`'s elements, their images in `K`, and their images in `ℚ_[p]` apart. A second
route I did not take: Chevalley's extension (`Ideal.image_subset_nonunits_valuationSubring`, used at row 105) gives a valuation
subring of `K` over `ι₀⁻¹ ℤ_p` and removes (c) and the automorphism at the price of a general-valuation form of the parity
step; it still needs (a) and (b).

**Q9 `exists_maximal_card_eq_of_ramified`** (the glue). With `E := fieldOfRadicands (insert q D)` as the field `K` of Q8:
`K₀ := (fieldOfRadicands D).comap E.subtype`; `ι₀` the embedding of Q7 composed with `K₀ → fieldOfRadicands D`,
`x ↦ ⟨(x : E), x.2⟩`; `π := ⟨√q, sqrt_mem_fieldOfRadicands (Set.mem_insert q D)⟩` (`SquareClass.lean:311`); `hπ` by
`Real.sq_sqrt`; `hgen`: `E`'s elements lie in the closure of the `√d`, `d ∈ insert q D`, each of which is `π` or in `K₀`
(`Subfield.closure_induction` on `x.2`, or `Subfield.closure_le` after mapping to `ℝ`). Then Q4 on the homomorphism of Q8.

### C. `Instances/UpperHalfValues.lean` — three leaves

**I1 `numberField_bot`**: `fieldOfRadicands ∅ = ⊥` (`unfold fieldOfRadicands; rw [Set.image_empty, Subfield.closure_empty]` ✓),
then `h ▸ QuadraticPrime.numberField_fieldOfRadicands Set.finite_empty`.

**I2 `two_le_chromaticNumber_planeOver`**: `0, 1 ∈ planeOver F` (`F.zero_mem`, `F.one_mem`; imaginary parts `0`), adjacent
(`dist 0 1 = 1`), and `SimpleGraph.two_le_chromaticNumber_of_adj` ✓.

**I3 `exists_stablePrime_rat`**: a maximal ideal `P` of `𝓞 (ℚ(i))` with `2 ∈ P`, `P.comap conjO = P`, and `x̄ − x ∈ P` for all `x`.
Route: (1) `2` is not a unit of `𝓞`: `1/2` would be integral over `ℤ` and rational, so an integer
(`IsIntegrallyClosed.isIntegral_iff` ✓ for `ℤ ⊂ ℚ`). `Ideal.exists_le_maximal` ✓ gives a maximal `P ∋ 2`. (2) **`Im x ∈ ℤ` for
`x : 𝓞`**: `Re x, Im x ∈ ℚ` (`x ∈ fieldI ⊥`; `Subfield.bot_eq_of_charZero`, as `Transcendental.lean:381`); `T := 2 Re x = x + x̄`
and `N := Re x² + Im x² = x x̄` are integral and rational, so integers; `(2 Im x)² = 4N − T²` is an integer, so `2 Im x` is one
(integral: a root of `X² − n`); `T² + (2 Im x)² ≡ 0 (mod 4)` forces both even (squares are `0, 1` modulo 4: `decide` over
`ZMod 4`). (3) So `x̄ − x = 2 · (−Im x · i)` with `−Im x · i ∈ 𝓞`, in `P`. (4) `P.comap (conjO ⊥) = P` from (3):
`conjO x = x + (conjO x − x)`, and the other inclusion by `conjO_conjO` (proved in `Arith/UpperHalf`).
`Arith/NegCircleModel.lean:63` (`exists_odd_rep_of_unitVector`) is the library's one other place that does parity in `ℚ(i)`.

### D. The split, and what the landing needs

- **Three implementers at once, no shared file**: one on `Arith/UpperHalf.lean` (U1–U12; order U1, U2, U3, U4, U5, U6, U7,
  U9, U10, U8, U11, U12); one on `Arith/QuadraticPrime.lean` (Q1–Q7, then Q9, then Q8); one on
  `Instances/UpperHalfValues.lean` (I1–I3) — its file reads only the *statements* of the other two, so it compiles against
  the skeleton's `.olean`s from the first minute and is not blocked by either. With two implementers, the instances file goes
  to whoever finishes first. Q8 is separable: it can be handed to a fourth mind, or deferred behind the landing of the rest,
  at the cost of one `sorry` (`exists_maximal_card_eq_of_ramified` through it) and no instance.
- Each implementer makes the statement dump of `LEAN.md` (FS124-I5's `statements.sh`) on the skeleton before its first edit.
- **The landing**, after the leaves: (1) the full build and the `sorry` scan; (2) `scripts/dupnames.sh` — the new names
  `coe_conjO`, `conjO_conjO` are in `HadwigerNelson.UpperHalf` and `StandingFive` has its own `conjO_conjO` under its namespace:
  no clash, but it is the scan's to say; (3) records in `scripts/Axioms.lean` for the public theorems; (4) **the assumptions
  step moves**: `scripts/Assumptions.lean:799` declares `.site ``HadwigerNelson.SpectralChain.chromaticNumber_eq_localBound
  `hUpper "UpperHalf" .ours`, and once `UpperHalf.chromaticNumber_planeOver_le_localBound` proves that binder over the
  theorem's own variables the step fails on it ("a declared hypothesis … a theorem proves over its own variables"): the line
  leaves, `scripts/assumptions-ledger.txt:129` with it, and the new `chromaticNumber_eq_localBound_of_chain` enters as a taker
  of each of the headline's other hypotheses (two written out in binders: `hCLS`, `hRow99` — two `.site` lines). The nine
  counts in `CLAUDE.md` § Trust ledger change (`ours` 23 → 22, `inline` 16 → 15, `takes` by the new theorem's pairs); (5) the
  vacuity scan: no colouring binder is new; `StablePrime F` and `IsUsablePrime` are the carriers to name models for
  (stage 2); (6) two new global instances (`instNumberFieldFieldOfRadicands`, `instNumberFieldBot`) — named, `Prop`-valued.
