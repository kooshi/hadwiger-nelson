Every line is **[kernel] on branch `fs131-wj1`, not through the gate** (the audit, the scans and the doubled-name check on
the joined tree are the landing's): proved, built by `scripts/build.sh` (the fourth build, exit 0, no warning), and its axioms
printed from the compiled module (`data/fs131/kj1/logs/axioms-final.txt`). Namespace `HadwigerNelson.` before each name.
"std3" is `[propext, Classical.choice, Quot.sound]` or fewer; "Weil" is those and the declared outside theorem
`StandingFive.kloosterman_bound`.

*The ten planned leaves of `Arith/ThreeFourColours`, statements unchanged:*
- `ThreeFourColours.exists_stablePrime_of_maximal` (J.1) — std3
- `ThreeFourColours.exists_unitSet_residue_eq` (J.2; NF4-S9 at level one) — std3
- `ThreeFourColours.exists_maximal_card_three_of_card_nine` (J.3) — std3
- `ThreeFourColours.exists_stablePrime_conj_trivial` (J.4) — std3
- `ThreeFourColours.colorable_three_planeOver_iff` (J.5) — Weil
- `ThreeFourColours.chromaticNumber_planeOver_eq_three_iff` (J.6; NF4-THEOREM (b) as claimed) — Weil
- `ThreeFourColours.localBound_le_chromaticNumber_or_four_le` (J.7; row 99's lower half) — Weil
- `ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_three` (J.8) — std3
- `ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four_of_seven` (J.9) — std3
- `ThreeFourColours.exists_stablePrime_card_four_sqrt` (J.10; NF4-DYADIC-FOUR as worded) — std3

*The planned compositions, now free of the unproved dependency:* `colorable_three_of_card_three`,
`chromaticNumber_planeOver_sqrt_eq_four_of_dyadic`, `chromaticNumber_planeOver_sqrt_eq_two`,
`exists_stablePrime_ramified_sqrt` (NF4-DYADIC-TWO as worded) — std3; `localBound_le_chromaticNumber_of_le_four` — Weil.

*Added in `Arith/ThreeFourColours` (16):* `exists_stablePrime_card_nine`, `exists_maximal_card_three_of_stablePrime_card_nine`,
`levelTarget_colorable_two_of_ramified`, `levelTarget_colorable_three_of_card_nine`, `colorable_three_planeOver_sqrt`,
`chromaticNumber_planeOver_sqrt_eq_three_of_mod`, `colorable_four_planeOver_sqrt_of_seven`,
`chromaticNumber_planeOver_sqrt_eq_four_of_seven_of_mod`, `chromaticNumber_planeOver_sqrt_eq_four`,
`chromaticNumber_planeOver_sqrt_table` (NF4-THEOREM (a), the whole table), `chromaticNumber_planeOver_sqrt_three`,
`fieldBandSet_three_nonempty_sqrt_three`, `exists_maximal_conj_trivial_sqrt_two` — std3;
`chromaticNumber_planeOver_eq_localBound_of_le_four` (row 99: `χ = L` for `L ≤ 4`),
`chromaticNumber_planeOver_le_three_iff` (row 99: `χ ≤ 3 ⟺ L ≤ 3`), `exists_maximal_card_nine_sqrt_three` — Weil.

*Added in the four proved modules (6), each std3:* `TorsionExtraction.colorable_two_of_fieldBandSet_three_nonempty`,
`TorsionExtraction.fieldBandSet_three_eq_empty_of_sqrt_mem`,
`ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable_unitRing`,
`ThreeColourCharacter.bandSet_three_nonempty_zmod_five`, `DyadicQuadratic.colorable_two_planeOver_sqrt_of_mod_four`,
`DyadicQuadratic.mod_four_of_squarefree`.

*New module `Instances/UpperHalfCorollaries` (4), each std3:* `UpperHalf.chromaticNumber_planeOver_eq_two_of_localBound_le_two`,
`UpperHalf.chromaticNumber_planeOver_sqrt_five_le_five`, `UpperHalf.chromaticNumber_planeOver_sqrt_247_le_five`,
`UpperHalf.two_notMem_stablePrime_seven`.

*Made kernel theorems of one tree by the join (proved by FS131-IC1, -IT1, -IN1, -ID1 on four branches; this job proved
none of them):* the 55 public records of `Arith/ThreeColourCharacter` (9), `Arith/TorsionExtraction` (18),
`Arith/ThreeColourCriterion` (17) and `Arith/DyadicQuadratic` (11) as they stood — 50 std3, 5 Weil — among them
NF4-THEOREM (c) (`TorsionExtraction.four_le_chromaticNumber_planeOver_of_inv_three_mem`,
`chromaticNumber_planeOver_ne_three_of_inv_three_mem`) and clause (a)'s lower bound
(`four_le_chromaticNumber_planeOver_of_sqrt_mem`, `…_fieldOfRadicands`), std3.

Nothing here is new mathematics beyond what the claim list holds at `[hand]`: every value and every upper bound is prior
art (stage 4); what is this project's — the lower bound at four, the three-colour criterion, row 99's lower half — was
derived by hand before this job. The routes of J.7's two colourings and of J.10's count are this job's.
