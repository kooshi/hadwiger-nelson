# FS-131, wave 10 — implementation record: the planes' floor (`NormOneTarget`, `FloorPlanes`)

*Job FS131-I10D (de Bruijn, the implementer), 2026-10-06, branch `fs131-w10d` (cut from the second planner's `330d2f48`). Brief:
`data/fs131/briefs/FS131-I10D-wave10-second.md`. Plan: `plans/FS131-w10-kernel-plan.md` §§ 7.1, 7.3, 9.3, 9.4.*

**What I may change, and what I may not.** Mine: the proof of each open leaf of `Proofs/HadwigerNelson/Arith/NormOneTarget.lean`
(`involution_eq_pow`, `card_normOne`) and of `Proofs/HadwigerNelson/Arith/FloorPlanes.lean` (`sum_quadratic_eq`,
`circle_sum_eq_kloosterman`, `circle_sum_le`, `normOne_charSum_ge`); new helper declarations in those two files, under names no other
module declares; the docstring of `circle_sum_eq_kloosterman`, extended when it is proved (the brief's item 3); a block "FS131-I10D" in
`scripts/Axioms.lean` above the `=== PURCHASED ===` banner; this record; `tools/fs131_i10d_*.py`; `data/fs131/i10d/`; the report. Not
mine: any statement, hypothesis, conclusion or definition of the skeleton — `KloostermanBound` stays a `Prop` argument (rulings 500 and
510 (c)); a new `axiom`; `native_decide`; the wave's other files; the planner's record; any landed module; `main`; the gate; another
branch.

## Theorems this phase proved

*(filled at each saved stage)*

## Stage 1 — SAVED (FS131-I10D): the readback, the build as given

**Quotations** (standing rule 3), by script — `grep -F` of each quoted string in the file the brief names, with a planted string that
must read missing (`data/fs131/i10d/logs/quotations.sh`, output `data/fs131/i10d/logs/quotations.txt`): **seventeen of seventeen
match** — `CLAUDE.md` § Counter-priors; inventory items 500, 503, 509, 510 (`plans/FS131-close-inventory.md` on `main`, where they are
filed; this branch's copy predates them); the six leaves' first lines and `KloostermanBound`'s in my two files; the plan's five
headings.

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and watch it fail
(to its two-sided-plant paragraph); the plan's "Theorems this phase proved (FS131-K10b)" and Stages 6–9; inventory items 500, 509,
510 (503 is `ProductFactor`'s, read for its first sentence only); `NormOneTarget.lean` and `FloorPlanes.lean`; `StandingFive.lean`
ll. 1–25, 104–156 (`normOneCayley`, `TargetFloor`, `StandingFloor`); `RatioBound.lean` ll. 1–40, 148–201. The row's entry: G56's
"every usable plane … refuses six by Weil from 98" as the plan's § 7.3 reads it back, and `BIBLIOGRAPHY.md`'s `[MMST1996]` and
`[Weil1948]` rows on `main` (the second now held: its p. 207 displays the bound for a field of `q` elements, characteristic not 2 —
the read-back against `KloostermanBound` is the importing job's, not mine).

**The branch as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0, "all 1781 modules
already up to date", **23** `declaration uses sorry` warnings — `NormOneTarget` 2 and `FloorPlanes` 4 (mine), `Floor128` 1,
`ProductFactor` 1, `MajorityVote` 1, `NegCircleModel` 2 (the pass's other implementers'), `StandingFive` 9, `StationaryRatio` 3
(proved on other branches): the brief's count (`data/fs131/i10d/logs/build-0-as-given.log`).

**The statement check** (`tools/fs131_i10d_statements.py`, against `330d2f48`): every declaration of the base version of a file must
be in the working tree with its statement verbatim — a theorem to its first ` :=`, a definition whole — and its docstring verbatim or
*extended* (listed on every run, not a failure: the brief asks one docstring to gain a sentence). `--self-test` plants a theorem fault,
a definition fault and a mid-docstring fault, each required to fire, and a docstring extension required to pass and be listed; where
a file declares no definition the control says "NOT RUN" instead of passing in silence (the copied tool printed "FIRED" there).
Output at the base: 3 + 7 declarations kept, both self-tests as required (`data/fs131/i10d/logs/statements-0.txt`).

**Mathlib names confirmed by `grep` in the pinned source before any proof** (the plan's ✓ list, and the ones it left to me):
`FiniteField.bijective_frobeniusAlgHom_pow`, `FiniteField.orderOf_frobeniusAlgHom`, `FiniteField.pow_card`,
`FiniteField.forall_pow_eq_one_iff`, `FiniteField.even_card_iff_char_two`, `FiniteField.isSquare_neg_one_iff`,
`FixedPoints.finrank_eq_card`, `Subfield`'s `RingHom.eqLocusField`, `quadraticChar_card_sqrts`, `quadraticChar_sq_one`,
`gaussSum_mulShift`, `gaussSum_sq`, `AddChar.sum_mulShift`, `AddChar.sum_eq_zero_of_ne_one`, `AddChar.to_mulShift_inj_of_isPrimitive`,
`AddChar.card_eq`, `AddChar.exists_apply_ne_zero`.

Token count at this stage: about 120k by my own estimate (the launch context is most of it).

## Stage 2 — SAVED (FS131-I10D): `NormOneTarget` — P1 `involution_eq_pow`, P2 `card_normOne`

**P1, by another route than the plan's** (said here, and in a `--` comment at the head of the proof; the theorem's docstring is the
planner's and still describes the fixed-field argument, which is a true proof and not the one the kernel holds). The plan: the fixed
field has `[k : k₀] = 2` by Artin (`FixedPoints.finrank_eq_card`), then the polynomial `(T − x)(T − σ x)`; hard part named, "the group
action's instances". Taken instead: `σ` is an algebra endomorphism of `k` over its prime field (`ZMod.subsingleton_ringHom` gives
`commutes'`), so it is `Frob ^ j` for one `j < n = [k : 𝔽_p]` (`FiniteField.bijective_frobeniusAlgHom_pow`, in Mathlib at the pin);
`σ² = 1` gives `n ∣ 2j` (`FiniteField.orderOf_frobeniusAlgHom`), `σ ≠ 1` gives `j ≠ 0`, so `2j = n`, `Q² = p^n = (p^j)²`, `Q = p^j`
and `σ x = x ^ p ^ j`. No group action, no fixed field, no polynomial. 43 lines against the plan's 120; one elaboration round.

**P2** over a new helper, **`card_filter_pow_eq_one`**: in a finite field, `u ^ d = 1` has exactly `d` solutions when `d ∣ |k| − 1`,
`d ≠ 0` (`IsCyclic.card_powMonoidHom_ker` on `kˣ`, carried to `k` by an explicit equivalence). `card_normOne` is its instance at
`d = Q + 1`; Stage 3 reads it again at `d = Q − 1`. 30 lines for the two against the plan's 50; two rounds (one unknown constant,
`Nat.sq_sub_sq'`, replaced by a two-line case split).

**Re-priced from these two leaves** (the brief's item 2): 85 inserted lines in `NormOneTarget` — proofs, the helper, comments and one
spec example — against the plan's 170 for P1 + P2, so **half the plan's line count**, as the wave's first two implementers found. The
remaining four leaves, planned at 440 lines, are re-priced at about 220; the whole job at about 250k by the harness's count in place of
the plan's 300k.

**New imports** in `NormOneTarget.lean`: `Mathlib.Algebra.Algebra.ZMod`, `Mathlib.FieldTheory.Finite.Basic`,
`Mathlib.GroupTheory.SpecificGroups.Cyclic` (none was reached through `StandingFive`; `lake env lean` said so by an unknown constant).

**Evidence.** Build under the slot, exit 0, 454 of 454 batches, 5 modules rebuilt (`NormOneTarget`, `FloorPlanes`, `Floor128`,
`TargetFloors`, `Proofs`), every warning a `sorry` of another leaf: 21 left — `FloorPlanes` 4 (mine), the eleven-less-six of this
pass's other files (5), `StandingFive` 9, `StationaryRatio` 3 (`data/fs131/i10d/logs/build-1-p1-p2.log`). Axioms
(`data/fs131/i10d/axioms-group1.lean`, log `data/fs131/i10d/logs/axioms-group1.log`): `involution_eq_pow`, `card_filter_pow_eq_one`,
`card_normOne` and `targetFloor_of_charSum` (the planner's composition, now over proved leaves) each on
`[propext, Classical.choice, Quot.sound]`; the control, `sum_quadratic_eq` (open at this stage), prints `sorryAx`, as it must.
Statement check against `330d2f48`: 3 + 7 declarations kept, PASS (`data/fs131/i10d/logs/statements-1.txt`). `scripts/Axioms.lean`:
block "FS131-I10D" opened with these four.

Token count at this stage: about 190k by my own estimate.
