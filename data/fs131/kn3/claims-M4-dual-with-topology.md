# Draft claim list M4-dual-with-topology — the dual of a countable discrete group as a compact group: Haar measure in the page's form and in Fourier form

*Drafted by FS131-KN3 (the chain's planner) for Keryx to fix; a draft, not a fixed claim list. Kind: planner and implementer.*

## The leaves it carries (quoted by script)

> NF2-LEAF-15: **Haar measure on the dual in the page's own form.** `SpectralChain.Dual` carries a σ-algebra and no topology; the chain reads Haar only through Fourier coefficients (`SpectralInputs.IsHaarFourier`). To declare a statement that says "`µ = m_X`" term for term, state it over Mathlib's `PontryaginDual` of the discrete `M` and derive the Fourier form.
> — source: data/fs131/claims-NF2.md § The chain's leaves

## Statements

1. to type — for a countable `AddCommGroup M`: a compact Hausdorff additive topological group structure on a type `DualGroup M` with a measurable bijection to `AddChar M Circle` (cylinder σ-algebra) that is a group isomorphism; `BorelSpace (DualGroup M)`.
2. to type — under that bijection, `μ.IsAddHaarMeasure` for a probability `μ` on `DualGroup M` ⟺ `SpectralInputs.IsHaarFourier` of its image.
3. to type — the dual of `DualGroup M` is `M` (Pontryagin duality for a discrete countable group, the half that says the characters of `DualGroup M` are the evaluations), so `IsSolenoid (DualGroup M)` when `M` is torsion-free of finite rank.
4. to type — restriction `AddChar R Circle → AddChar M Circle` for `M ≤ R` is measurable, onto, and carries Haar to Haar.

## Derivation addresses

the leaf; `plans/FS100-X02D-derivation.md` § 3.1 steps 1, 3, 4 (what Lemma Γ reads of the maps `π_k`)

## Imports

`Rigidity/Solenoid`, `Arith/SpectralInputs`, Mathlib's `PontryaginDual`

## Exports

the object the pieces are, and the passage between the axiom's `X` and `Dual F`

## Can run beside

new files only; can start now

## Not claimed

Any size or price. That the statements marked "to type" elaborate as written. What I read: not typed; whether Mathlib's `PontryaginDual` at the pin has the duality half needed is unchecked.
