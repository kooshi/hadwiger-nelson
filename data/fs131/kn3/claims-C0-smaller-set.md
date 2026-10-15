# Draft claim list C0-smaller-set — the smaller set: `T + A` measurable and rotation-stable; a non-torsion unit vector; Lemma F

*Drafted by FS131-KN3 (the chain's planner) for Keryx to fix; a draft, not a fixed claim list. Kind: an implementer's job, no planner: the routes are in the module's docstrings.*

## The leaves it carries (quoted by script)

> NF2-LEAF-01: `T + A` as a set of `SpectralChain.Dual F` — the torsion characters plus the characters with an additive real lift (`CharacterColouring.torsionBy`, `.archimedean` are the same sets in the model `M →+ ℝ/ℤ`; one bridge between the two models of a character). Its stability under `rot u`, and its measurability: `T` is countable because `R/NR` is finite (X02D:100, Lemma F: "A torsion-free abelian group `A` of rank `n` has `|A/mA| ≤ mⁿ`"), and `A` is the image of a finite-dimensional real space.
> — source: data/fs131/claims-NF2.md § The chain's leaves

## Statements

1. `Rigidity.measurableSet_TA [NumberField F] : MeasurableSet (TA F)` — typed, `sorry`. Route: `TA F = ⋃_N {χ | χ^N ∈ archChars}`; `archChars = Φ⁻¹(S)` for the evaluation map `Φ : Dual F → (unitRing F → ℂ)` and `S` a countable union of continuous images of closed balls of `unitRing F →+ ℝ`, which is finite-dimensional because `unitRing F ⊆ F(i)` has finite rank.
2. `Rigidity.rot_preimage_TA (u : unitVectors F) : rot u ⁻¹' TA F = TA F` — typed, `sorry`.
3. `Rigidity.exists_nonTorsion_unitVector : ∃ u : unitVectors F, ∀ n : ℕ, n ≠ 0 → (u : ℂ) ^ n ≠ 1` — typed, `sorry`. Route: `(3 + 4i)² ≡ 3 + 4i (mod 5)`, so `(3 + 4i)ⁿ ≠ 5ⁿ` for `n ≥ 1`.
4. to type — **Lemma F**: a torsion-free abelian group `A` of rank `n` has `|A/mA| ≤ mⁿ` (the leaf's quotation of X02D:100). Stated here once, upstream of M6 and M10, which both read it.

## Derivation addresses

EN1 § 8.1 row 1: J45 § 2.1 Lemma N1 (ll. 105–109) at `S = ∅` (`plans/FS84-SI-D-derivation.md`); `plans/FS131-EN1-derivation.md` § 4.1 step 3; `plans/FS100-X02D-derivation.md` l. 100

## Imports

none beyond `Rigidity/ChainAtTA`'s

## Exports

`chainInterface` with no `sorry` under it; `mrPlus_of_split_of_carried` on the standard three axioms; Lemma F

## Can run beside

edits `Rigidity/ChainAtTA.lean` (the three proofs only) and one new file for Lemma F; shares no file with any other module if M6–M9 wait for it or work in files of their own

## Not claimed

Any size or price. That the statements marked "to type" elaborate as written. What I read: typed by me; proofs not attempted.
