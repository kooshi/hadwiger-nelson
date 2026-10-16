import Proofs.HadwigerNelson.Collapse.Headline
-- FS131-ICO2 experience probe (iteration): does `exact?` find the headlines from goals written without the abbrevs?
open HadwigerNelson
example : ((unitDistance ℂ).induce (planeOver (SquareClass.fieldOfRadicands {635087}))).chromaticNumber =
    (unitDistance ℂ).chromaticNumber := by exact?
example : ((unitDistance ℂ).induce (planeOver (SquareClass.fieldOfRadicands {3, 5, 7, 11}))).chromaticNumber =
    (unitDistance ℂ).chromaticNumber := by exact?
example : 6 ≤ ((unitDistance ℂ).induce (planeOver (SquareClass.fieldOfRadicands {635087}))).chromaticNumber := by exact?
