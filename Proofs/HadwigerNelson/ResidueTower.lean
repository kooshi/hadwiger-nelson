import Proofs.HadwigerNelson.UnitQuadrance

/-!
# The residue tower: colourability pulls back, and the ceiling is monotone along divisibility

Every upper bound this repository holds on the number of colours a plane over a number field needs comes
from one move: reduce coordinates modulo a prime and colour the finite plane over the residue field
(`UnitQuadrance.lean`). That uses the **first** residue level. Reduction modulo `p²`, `p³`, … is a ring
homomorphism too, so it is a graph homomorphism of unit-quadrance graphs, and

    χ(unitQuadrance (ZMod (p^k))) ≤ … ≤ χ(unitQuadrance (ZMod p²)) ≤ χ(unitQuadrance (ZMod p)).

FS-66 asks whether any of those inequalities is strict — whether the ceiling **drops up the tower**.
`Instances/ZMod121Four.lean` answers the pilot: at `p = 11` it does not at level two.

**Prior art.** The chain is `[Madore2015]` Proposition 3.8, for a valuation ring `A` with maximal ideal
`𝔪`: *"χ(K^d) = χ(A^d) ≤ χ((A/𝔪²)^d) ≤ χ((A/𝔪)^d)"*. He needs the `𝔪²` form at the prime 2, where level
one is isotropic, and never asks whether the last inequality is strict at an odd prime. What is ours is
the kernel form and the instance.

## What is here

* `unitQuadrance_colorable_of_ringHom` — the colouring face of `unitQuadrance.map`: colourability pulls
  back along any ring homomorphism into a nontrivial ring. No metric, no finiteness, no `ZMod`.
* `chromaticNumber_unitQuadrance_zmod_le_of_dvd` — the tower inequality, stated along divisibility, so
  one statement covers the tower `p ∣ p² ∣ p³`, CRT composites, and (at `n = 0`) `ℤ` itself.
* `unitPairNat` and `unitPairNat_eq_true_iff` — the per-pair edge check on natural-number
  representatives, as a `Bool` the kernel evaluates, and the one bridge from it to adjacency over
  `ZMod n`. **Generic in `n`**: the next instance (`n = 361`) reuses it unchanged.
* `unpackPt` — a generated vertex table read out of ONE packed natural-number literal.

## Why the data is `ℕ × ℕ` and not `ZMod n × ZMod n`

A numeral at a type index is paid per numeral, at elaboration (`CLAUDE.md` § The kernel's cost model:
FS-38 measured 32.9 GB and a timeout for a 48-point literal at an unsimplified index, against 2.5 GB for
the same points at a simplified one — and then a defeq wall on every access). So a witness table is a
single `ℕ` literal, every edge check runs on `ℕ`, and the **only** cast in the path is inside
`unitPairNat_eq_true_iff`, which is applied once per listed pair at the instance.

`1 < n` is the single hypothesis and it is load-bearing twice, with a counter-model for each: at `n = 1`
the check says `true` of a point and itself, so the bridge would assert a loop is an edge; at `n = 0` the
shifted subtraction truncates. It is an explicit hypothesis rather than a `Fact` instance because every
caller would otherwise open with `haveI : Fact (1 < n) := …` — an instance everyone supplies by hand is
the argument being the bug.
-/

open SimpleGraph

/-- The shifted natural subtraction IS subtraction in `ZMod n`. False at `n = 0` (`a = 0`, `b = 1`),
hence `NeZero`. In Mathlib's namespace, as `ZMod.exists_eq_add_mul_of_castHom_eq` (`Lift.lean`) is: it is
a fact about `ZMod`. NOT `@[simp]` and not `@[push_cast]` — it is cited by name at its one use; the cast
normal form is Mathlib's to legislate. -/
theorem ZMod.natCast_add_self_sub_mod {n : ℕ} [NeZero n] (a b : ℕ) :
    ((a + n - b % n : ℕ) : ZMod n) = (a : ZMod n) - (b : ZMod n) := by
  have hb : b % n ≤ a + n := (Nat.mod_lt b (NeZero.pos n)).le.trans (Nat.le_add_left n a)
  rw [Nat.cast_sub hb, Nat.cast_add, ZMod.natCast_self, add_zero, ZMod.natCast_mod]

namespace HadwigerNelson

/-! ### The tower -/

/-- Colourability pulls back along a ring homomorphism: the colouring face of `unitQuadrance.map`, named
in the house pattern of `unitQuadrance_forces_eq_of_ringHom` (`FanGap.lean`). -/
theorem unitQuadrance_colorable_of_ringHom {R S : Type*} [CommRing R] [CommRing S] [Nontrivial S]
    (f : R →+* S) {k : ℕ} (h : (unitQuadrance S).Colorable k) : (unitQuadrance R).Colorable k :=
  Colorable.of_hom (unitQuadrance.map f) h

/-- **The residue ceiling is monotone along divisibility** — up the tower `ZMod (p^k)`, across CRT
composites, and (at `n = 0`) from `ℤ` itself: the kernel form of the second inequality of
`[Madore2015]` Prop. 3.8. -/
theorem chromaticNumber_unitQuadrance_zmod_le_of_dvd {m n : ℕ} (hm : 1 < m) (h : m ∣ n) :
    (unitQuadrance (ZMod n)).chromaticNumber ≤ (unitQuadrance (ZMod m)).chromaticNumber :=
  haveI : Fact (1 < m) := ⟨hm⟩
  chromaticNumber_le_of_forall_imp fun _ hk => unitQuadrance_colorable_of_ringHom (ZMod.castHom h (ZMod m)) hk

/-! ### The edge check the kernel evaluates, and its one bridge -/

/-- Over a nontrivial ring unit quadrance already excludes equality (`0 ≠ 1`): adjacency is the one
equation. The argument was inlined in `unitQuadrance.map`; minted once here because the bridge below
needs it again. **NOT `@[simp]`:** `unitQuadrance_adj` already is, with the same left side, and the set's
normal form (`u ≠ v ∧ …`) is not ours to fork. -/
theorem unitQuadrance_adj_iff_quadrance {R : Type*} [CommRing R] [Nontrivial R] {u v : R × R} :
    (unitQuadrance R).Adj u v ↔ (u.1 - v.1) ^ 2 + (u.2 - v.2) ^ 2 = 1 := by
  rw [unitQuadrance_adj]
  refine ⟨fun h => h.2, fun h => ⟨?_, h⟩⟩
  rintro rfl
  simp at h

/-- The per-pair check on natural-number representatives, as a `Bool` the kernel evaluates; no `ZMod`
literal is carried. `v`'s coordinates are reduced first, so the subtraction never truncates and no
"entries are `< n`" hypothesis is needed. -/
def unitPairNat (n : ℕ) (u v : ℕ × ℕ) : Bool :=
  ((u.1 + n - v.1 % n) ^ 2 + (u.2 + n - v.2 % n) ^ 2) % n == 1 % n

/-- **The bridge, both ways.** `1 < n` is load-bearing twice: at `n = 1` the check says `true` of a point
and itself (the adversary below), and at `n = 0` its subtraction truncates. The ONLY place a cast
appears. -/
theorem unitPairNat_eq_true_iff {n : ℕ} (hn : 1 < n) (u v : ℕ × ℕ) :
    unitPairNat n u v = true ↔
      (unitQuadrance (ZMod n)).Adj ((u.1 : ZMod n), (u.2 : ZMod n)) ((v.1 : ZMod n), (v.2 : ZMod n)) := by
  haveI : Fact (1 < n) := ⟨hn⟩
  haveI : NeZero n := ⟨by omega⟩
  rw [unitQuadrance_adj_iff_quadrance, unitPairNat, beq_iff_eq, ← ZMod.natCast_eq_natCast_iff']
  push_cast [ZMod.natCast_add_self_sub_mod]
  rfl

/-- Entry `i` of a vertex table packed into ONE literal: the `w`-bit field at offset `w·i` holds `a·n + b`.
Parametric in `(n, w)` because the next instance is already planned (`n = 361`, `w = 17`). -/
def unpackPt (n w packed i : ℕ) : ℕ × ℕ :=
  let id := (packed >>> (w * i)) &&& (2 ^ w - 1)
  (id / n, id % n)

/-! ### Spec — the definitions are pinned by examples that would fail if they drifted -/

section Spec

#guard unpackPt 121 14 (120 + (5747 <<< 14)) 1 == (47, 60)
#guard unitPairNat 121 (0, 0) (0, 120)                                       -- `(0,0) ~ (0,−1)`
#guard unitPairNat 121 (0, 120) (47, 60) && unitPairNat 121 (0, 0) (47, 60)  -- a triangle of `UD(ℤ/121,2)`
#guard !unitPairNat 121 (0, 0) (11, 0)                                       -- `11² = 121 ≡ 0`, not `1`
#guard !unitPairNat 121 (5, 7) (5, 7)                                        -- a point is not its own neighbour

/-- The adversary: why `1 < n` cannot be dropped from `unitPairNat_eq_true_iff`. At `n = 1` the check
says `true` of a point and itself, while `unitQuadrance` is loopless at every ring. -/
example : unitPairNat 1 (0, 0) (0, 0) = true := rfl

/-- The consumer's path at an instance — an explicit `1 < n`, discharged inline, no `haveI` ceremony. -/
example : (unitQuadrance (ZMod 121)).Adj ((0 : ℕ), (0 : ℕ)) ((0 : ℕ), (120 : ℕ)) :=
  (unitPairNat_eq_true_iff (by norm_num) (0, 0) (0, 120)).mp rfl

example : (unitQuadrance (ZMod 121)).chromaticNumber ≤ (unitQuadrance (ZMod 11)).chromaticNumber :=
  chromaticNumber_unitQuadrance_zmod_le_of_dvd (by norm_num) (by norm_num)

end Spec

end HadwigerNelson
