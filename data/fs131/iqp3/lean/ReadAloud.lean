import Proofs.HadwigerNelson.PadicPlane.Values
/-! FS131-IQP3 — the head statements of the p-adic plane's landing, printed from the gated build for the read-aloud against
`LEDGER.md` row 75 and FS66-T7 (FS131-KPA1's `data/fs131/kpa1/heads.lean`, with the value at 23 as landed and each head's
axioms). Run from the worktree's root, under a slot:
  lake env lean data/fs131/iqp3/lean/ReadAloud.lean > data/fs131/iqp3/read-aloud.txt -/
set_option pp.fullNames true
set_option pp.funBinderTypes true
#print HadwigerNelson.PadicPlane.borelChromaticNumber
#print HadwigerNelson.PadicPlane.padicPlane
#print HadwigerNelson.unitQuadrance
#print HadwigerNelson.PadicPlane.TowerRatio
#check @HadwigerNelson.PadicPlane.le_borelChromaticNumber_of_charSum
#check @HadwigerNelson.PadicPlane.one_add_div_le_of_borelColoring
#check @HadwigerNelson.PadicPlane.le_borelChromaticNumber_padicPlane
#check @HadwigerNelson.PadicPlane.not_exists_bound_borelChromaticNumber_padicPlane
#check @HadwigerNelson.PadicPlane.borelChromaticNumber_padicPlane_three
#check @HadwigerNelson.PadicPlane.borelChromaticNumber_padicPlane_seven
#check @HadwigerNelson.PadicPlane.borelChromaticNumber_padicPlane_eleven
#check @HadwigerNelson.PadicPlane.borelChromaticNumber_padicPlane_nineteen
#check @HadwigerNelson.PadicPlane.five_le_borelChromaticNumber_padicPlane_twentyThree
#check @HadwigerNelson.PadicPlane.borelChromaticNumber_padicPlane_twentyThree_le_eight
#check @HadwigerNelson.PadicPlane.unitQuadrance_zmod_seven_pow_not_colorable_three
#check @HadwigerNelson.PadicPlane.unitQuadrance_zmod_eleven_pow_not_colorable_four
#check @HadwigerNelson.PadicPlane.unitQuadrance_zmod_nineteen_pow_not_colorable_four
#check @HadwigerNelson.PadicPlane.borelChromaticNumber_le_chromaticNumber
#check @HadwigerNelson.PadicPlane.chromaticNumber_le_borelChromaticNumber
#check @HadwigerNelson.PadicPlane.exists_levelEmbedding
#check @HadwigerNelson.PadicPlane.charSum_levelOne_of_unitCircle
set_option pp.explicit true in
#check @HadwigerNelson.PadicPlane.one_add_div_le_of_borelColoring
#print axioms HadwigerNelson.PadicPlane.le_borelChromaticNumber_of_charSum
#print axioms HadwigerNelson.PadicPlane.one_add_div_le_of_borelColoring
#print axioms HadwigerNelson.PadicPlane.le_borelChromaticNumber_padicPlane
#print axioms HadwigerNelson.PadicPlane.not_exists_bound_borelChromaticNumber_padicPlane
#print axioms HadwigerNelson.PadicPlane.borelChromaticNumber_padicPlane_three
#print axioms HadwigerNelson.PadicPlane.borelChromaticNumber_padicPlane_seven
#print axioms HadwigerNelson.PadicPlane.borelChromaticNumber_padicPlane_eleven
#print axioms HadwigerNelson.PadicPlane.borelChromaticNumber_padicPlane_nineteen
#print axioms HadwigerNelson.PadicPlane.five_le_borelChromaticNumber_padicPlane_twentyThree
#print axioms HadwigerNelson.PadicPlane.borelChromaticNumber_padicPlane_twentyThree_le_eight
#print axioms HadwigerNelson.PadicPlane.unitQuadrance_zmod_seven_pow_not_colorable_three
#print axioms HadwigerNelson.PadicPlane.unitQuadrance_zmod_eleven_pow_not_colorable_four
#print axioms HadwigerNelson.PadicPlane.unitQuadrance_zmod_nineteen_pow_not_colorable_four
#print axioms HadwigerNelson.PadicPlane.borelChromaticNumber_le_chromaticNumber
#print axioms HadwigerNelson.FibreCertSound.sum_le_seven
