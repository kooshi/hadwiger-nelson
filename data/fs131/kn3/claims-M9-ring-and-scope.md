# Draft claim list M9-ring-and-scope — the ring and the scope: the class lies in the scope; `R = O′`; the density of `R` — with the two results the leaf list did not number

*Drafted by FS131-KN3 (the chain's planner) for Keryx to fix; a draft, not a fixed claim list. Kind: planner and implementer; pure number-field arithmetic over Mathlib's API.*

## Statements

1. `Rigidity.noRamifiedStableDyadic_of_tca [NumberField F] (h : TCA F) : NoRamifiedStableDyadic F` — typed, `sorry` (FS100-EXC: at a ramified stable dyadic prime `x·x̄ = 1` reads `x² = 1`, the level-one target is a perfect matching, ratio `1/2`).
2. to type — `IsRamified P` ⟺ the ramification index of `P` over `F` is 2, for a stable prime (a check on the definition, against Mathlib's `Ideal.ramificationIdx'`).
3. to type — **`R = O′`** (Lemma C′, FS91-J07-4): under `NoRamifiedStableDyadic F`, `unitRing F` is the subring of `fieldI F` of elements integral at every stable prime. *The deriver's row 14; not a numbered leaf.*
4. to type — **density**: `unitRing F` is dense in the completion that carries `T + A` (J45 N1 (b) at `S = ∅`; or EN1 § 8.2 route 4, from `1/5 ∈ R`). *The deriver's row 3; not a numbered leaf.* Read by M12's extension step.

## Derivation addresses

EN1 § 8.1 rows 3, 14: `LEDGER.md` row 100; `plans/FS91-derivation.md` l. 136 (FS91-J07-4); FS100-EXC (`plans/FS100-derivation.md` l. 297); J45 N1 (b) (`plans/FS84-SI-D-derivation.md` ll. 114–120); `plans/FS86-R88-D-derivation.md` ll. 148–150

## Imports

`SpectralChain`, `Rigidity/ChainAtTA` (for the predicate)

## Exports

the scope of M8 and the density M12 reads

## Can run beside

new files, and one proof in `Rigidity/ChainAtTA.lean`; can start now

## Not claimed

Any size or price. That the statements marked "to type" elaborate as written. What I read: FS91-J07-4 and FS100-EXC read at their entries; not typed beyond the first statement.

## Dated lines

- 2026-10-14 (FS131-KN6, Amendment 1 of its brief) — **the scope lemma is off the headline's path and stays stated.** `Rigidity.noRamifiedStableDyadic_of_tca` (FS100-EXC in its own words: `TCA F → NoRamifiedStableDyadic F`) is no longer read by `Rigidity.min_localBound_five_le_chromaticNumber_of_closed`, which takes eight closed hypotheses and derives the scope from `5 ≤ localBound F` (`Rigidity.noRamifiedStableDyadic_of_three_le_localBound`, proved, over `Arith/UpperHalf`). The leaf stays a statement of this module (the hand record under `LEDGER.md` row 121 cites it); its route is now one step: a colour class of `Rigidity.colorable_two_levelTarget_one_of_isRamified` is independent and holds at least half of `𝓞 ⧸ P`, against T-C(A)'s `c < 1/4` at level one (if `𝓞 ⧸ P` were infinite, `Nat.card` is `0` and a one-point set already contradicts the bound). New for this module, a readability lemma owed: `IsRamified P` is equivalent to ramification index 2 over `P ∩ 𝓞_F` in Mathlib's sense (`LEAN.md` § Searching — Lean names the two ramification APIs at the pin).

## Since FS131-KN9 (2026-10-14; by hand — the text above is kept)

Typed in `Rigidity/RingScope` (`plans/FS131-KN9-chain-zero-entropy.md` § Stage 3): `stableIntegers F` (`O′`); **proved** `R ⊆ O′`
(`unitRing_le_stableIntegers`); statement 3 as `unitRing_eq_stableIntegers` — **off the headline's path** after M8b's plan, which
reads `R ⊆ O′` and `c·O′ ⊆ R` only (`exists_mul_stableIntegers_le`, FS91-J10-L1 (e), every real number field; the coordinator's
ruling of 2026-10-14), planned in words only; whether M12's T-C(A) reads the equality or only Lemma C (d) is M12's planner's
question. Statement 4 as `dense_mixedEmbedding_nsmul_unitRing` (`N·R` dense in `L ⊗ ℝ` for every `N ≥ 1`; EN1 § 8.2 route 4).
Statement 1's plan: § 3.4 there. Statement 2 (the ramification-index readability lemma) not typed: it needs an
`Algebra F (fieldI F)` no consumer reads; its route in words, § 3.1 there.
