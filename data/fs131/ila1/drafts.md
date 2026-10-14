## Drafts for the landing

**D1. The audit's block** (`scripts/Axioms.lean`, CLEAN section; every public declaration of the two modules this job
writes whose axioms are the standard three at build 1 of `fs131-wla`):

```
-- FS131-ILA1: Rigidity/AdmissiblePrime (new), and lane A's leaf of Rigidity/UnitCircle
#print axioms HadwigerNelson.Rigidity.exists_residueHom_unramified
#print axioms HadwigerNelson.Rigidity.exists_unitPair
#print axioms HadwigerNelson.Rigidity.exists_admissiblePair
```

**D2. `UnitCircle`'s docstrings, which still describe the plan's route** (not mine to edit: the brief gave me the proof,
helpers and imports only). Slot: `Proofs/HadwigerNelson/Rigidity/UnitCircle.lean`.
- Module title (l. 7), the words "proved by FS131-IDG1 but `exists_admissiblePair`" → "proved by FS131-IDG1;
  `exists_admissiblePair` by FS131-ILA1".
- Module doc, l. 26, "`exists_admissiblePair` (X02D's Lemma W construction at one `u`)" → "`exists_admissiblePair`
  (from `Rigidity.exists_unitPair`: one degree-one unramified prime for `w`, a second for `u`)".
- **Models**, ll. 28–29, "(`exists_admissiblePair`, a leaf) — at `ℚ` by `u = (3 + 4i)/5`, `w = (5 + 12i)/13` (the
  leaf's plan)" → "(`exists_admissiblePair`) — at `ℚ`, for instance, by `u = (3 + 4i)/5`, `w = (5 + 12i)/13`".
- `exists_admissiblePair`'s docstring, the sentences from "Plan: a rational prime `p` splitting completely" to the end →
  "Proved from `exists_unitPair` (`Rigidity/AdmissiblePrime`): `w = z/z̄` at a degree-one unramified prime `𝔓` above an
  odd `p` (`z ∈ 𝔓²`, in no other prime above `p`), `ℚ(wᵏ) = F(i)` for every `k ≥ 1` by the `p`-adic valuations of the
  norms of `wᵏ − p` and `w²ᵏ − p`; `u = z′/z̄′` at a second such prime, independent by membership;
  `AdmissiblePair.ofPow`. No completely split prime and no principal power is needed."

**D3. Bibliography** (`BIBLIOGRAPHY.md`; Keryx files). One proposed row, and one reading line:
- New row: `| **[Schur1912]** | I. Schur, *Über die Existenz unendlich vieler Primzahlen in einigen speziellen
  arithmetischen Progressionen*, Sitzungsber. Berl. Math. Ges. 11 (1912) 40–50 — **cited from memory: title, venue and
  pages unchecked** | the classical fact that a nonconstant integral polynomial has prime divisors of its values outside
  any finite set; proved in the kernel here by the textbook argument (`Rigidity/AdmissiblePrime`, private `schur_prime`,
  FS131-ILA1); nothing rests on the paper, and the module's docstrings name it as "Schur's argument" with no key | not
  held | **recalled, not read** |`. If the landing prefers no row for a fact proved with its argument, the docstrings carry no
  key and nothing breaks.
- `FS100-X02D` is a derivation entry, not a bibliography row: read by this job at `plans/FS100-X02D-derivation.md`
  ll. 144–166 (PE-1′'s admissible `Γ`, l. 146, and Lemma W, ll. 156–163), in full.

**D4. `LEAN.md` lines** (§ Searching — Lean, appended at its end; each measured in this job's rounds, `data/fs131/ila1/logs/`):
- A prime of degree one above `p`, unramified, at every number field needs no Chebotarev and no residue map built by
  hand: an integral primitive `θ` (`Field.exists_primitive_element`, then `(IsFractionRing.isAlgebraic_iff ℤ ℚ K).mpr …
  |>.exists_integral_multiple`), Mathlib's Kummer–Dedekind isomorphism `RingOfIntegers.ZModXQuotSpanEquivQuotSpan`
  (at `¬ p ∣ RingOfIntegers.exponent θ`) followed by evaluation at a root of `minpoly ℤ θ` modulo `p`
  (`Ideal.Quotient.lift`, `eval_intCast_map`, `Int.cast_id`); the exponent is nonzero because the conductor times the
  different is `(f′(θ))` (`conductor_mul_differentIdeal`) and `(absNorm C : 𝓞) ∈ C` (`Ideal.absNorm_mem`,
  `Int.ideal_span_absNorm_eq_self`); `p ∉ 𝔓²` from `p ∤ discr K` through `NumberField.not_dvd_discr_iff_forall_mem`,
  `Ideal.ramificationIdx_eq_one`, `Ideal.ramificationIdx'_eq_ramificationIdx` (its `LiesOver` by
  `Ideal.liesOver_span_iff`) and `Ideal.ramificationIdx'_ne_one_iff` (`Rigidity.exists_residueHom_unramified`, FS131-ILA1).
- `ℚ⟮α⟯ = L` with no ring of integers of the subfield: for `y : ℚ⟮α⟯`, `N_{L/ℚ}(y) = N_{ℚ⟮α⟯/ℚ}(y)^d` by
  `rw [← IntermediateField.algebraMap_apply, ← Algebra.norm_norm (S := ℚ⟮α⟯), Algebra.norm_algebraMap, map_pow]`, so `d`
  divides `padicValRat p (N y)` (`padicValRat.pow`); `IntermediateField.finrank_eq_one_iff_eq_top` closes. The `p`-adic
  valuation of the norm of an integral `x` is `padicValNat p (absNorm (span {x}))` through `Algebra.coe_norm_int`,
  `padicValRat.of_int`, `padicValInt` (a definition: unfold it by `rw`) and `Ideal.absNorm_span_singleton` (FS131-ILA1).
- `Algebra.IsAlgebraic ℤ K` is not an instance at the pin for a number field `K`; `IsFractionRing.isAlgebraic_iff ℤ ℚ K`
  gives `IsAlgebraic ℤ x`. `Algebra.norm R` is a `MonoidHom`: `map_zero` does not rewrite `Algebra.norm ℤ 0` ("failed to
  synthesize `ZeroHomClass`"); `Algebra.norm_zero` does. `padicValNat.zero` is deprecated for `padicValNat_zero_right`.
  `rw [pow_succ]` on `z ^ (n + 1) ∈ P ^ 2` rewrites `P ^ 2` first: name the base, `pow_succ z` (FS131-ILA1).
