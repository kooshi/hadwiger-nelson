# Draft claim list M6-pieces — the pieces: an admissible `Γ`, the modules `M`, and PE-1′ — the pieces meet the printed hypotheses

*Drafted by FS131-KN3 (the chain's planner) for Keryx to fix; a draft, not a fixed claim list. Kind: planner and implementer.*

## The leaves it carries (quoted by script)

> NF2-LEAF-14: **The pieces**: for `Γ = ⟨u, w⟩ ⊂ U` and a finitely generated `ℤ[Γ]`-submodule `M ⊆ ℤ[U_F]` with `ℚM = F(i)`, the dual `M̂` with the action of `Γ ≅ ℤ²`, and the predicates of the printed theorem on a `ℤ^d`-action by automorphisms of a compact abelian group: solenoid, totally irreducible, virtually cyclic. Mathlib: none (searched "solenoid").
> — source: data/fs131/claims-NF2.md § The chain's leaves

> NF2-LEAF-19: Chebotarev's density theorem, for Lemma W at a general field (X02D:156). Mathlib: none (searched "chebotarev"). At a biquadratic `F(i)` Dirichlet suffices and is in Mathlib (`Nat.infinite_setOf_prime_and_eq_mod`, `NumberTheory/LSeries/PrimesInAP.lean:475`; X11K's note at node M1c). My call: import for the general statement; none needed for `ℚ(√47)`.
> — source: data/fs131/claims-NF2.md § The chain's leaves

## Statements

1. to type — admissible `Γ = ⟨u, w⟩ ⊂ U_F` exists (Lemma W, X02D l. 156): over a general field by Chebotarev (to declare, the map's § X5), at a biquadratic `F(i)` by Dirichlet (`Nat.infinite_setOf_prime_and_eq_mod`).
2. to type — for a finitely generated `ℤ[Γ]`-submodule `M ⊆ unitRing F` with `ℚM = F(i)`: `DualGroup M` (M4) is a solenoid, the action of `Γ ≅ ℤ²` on it is a `ZdAction 2`, **totally irreducible and not virtually cyclic** (PE-1′, X02D l. 146).
3. to type — the `M_k` exhaust `unitRing F` and each is stable under `Γ`.

## Derivation addresses

EN1 § 8.1 row 11: `plans/FS100-X02D-derivation.md` l. 100 (Lemma F, in C0), l. 146 (PE-1′), l. 156 (Lemma W)

## Imports

`Rigidity/Solenoid`, M4, C0 (Lemma F)

## Exports

the non-degenerate model of `positive_entropy_rigidity`'s hypotheses (its item 3); the objects of M7

## Can run beside

new files only; after M4

## Not claimed

Any size or price. That the statements marked "to type" elaborate as written. What I read: not read by me beyond the leaf lines; size unknown.

## Since FS131-KN8 (2026-10-14; by hand — the old text above is kept)

Typed in `Rigidity/UnitCircle` (statement 1: `exists_admissiblePair`, at one `u`; admissibility as `AdmissiblePair`, the
page's form with its generators) and `Rigidity/Pieces` (statement 2: `isSolenoid_pieceDual`, `isTotallyIrreducible_pieceAction`,
`not_isVirtuallyCyclic_pieceAction`, each over `IsPiece p M` and the first two with `[NumberField F]`; statement 3:
`exists_pieceChain`), with Lemma Γ and its steps in the same module.
