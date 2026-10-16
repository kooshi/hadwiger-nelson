#!/usr/bin/env python3
"""FS131-IQP1 — docstring corrections after the leaves are proved (no declaration touched): the titles' "skeleton" tag,
and Values' claims at 23 brought to what is proved there (4 ≤ χ_Bor(ℚ₂₃²) ≤ 8; the level clause at 23 not stated)."""
import sys
root = sys.argv[1] if len(sys.argv) > 1 else '.'
d = root + '/Proofs/HadwigerNelson/PadicPlane/'
edits = {
 'Basic.lean': [('(FS131-KPA1, skeleton)', '(FS131-KPA1, proved by FS131-IQP1)')],
 'Measure.lean': [('(FS131-KPA1, skeleton)', '(FS131-KPA1, proved by FS131-IQP1)')],
 'Upper.lean': [('(FS131-KPA1, skeleton)', '(FS131-KPA1, proved by FS131-IQP1)')],
 'Tower.lean': [('(FS131-KPA1, skeleton)', '(FS131-KPA1, proved by FS131-IQP1)')],
 'Values.lean': [
  ('and its values at 3, 7, 11, 19 and 23 (FS131-KPA1, skeleton)',
   'its values at 3, 7, 11 and 19, and bounds at 23 (FS131-KPA1, proved by FS131-IQP1)'),
  ('''* The values: `χ_Bor(ℚ₃²) = 3` (the bound alone), `χ_Bor(ℚ₇²) = 4`, `χ_Bor(ℚ₁₁²) = 5`, `χ_Bor(ℚ₁₉²) = 5`, and
  `6 ≤ χ_Bor(ℚ₂₃²) ≤ 8` — lower halves from FS-66's fibre-share certificates (`TowerRatio p (U/p²)`), upper halves from the
  finite planes' colourings (`PadicPlane/Upper`, `[Madore2015]` Prop. 3.2 with the values of `[Moorhouse2010]` Table 6.1).''',
   '''* The values: `χ_Bor(ℚ₃²) = 3` (the bound alone), `χ_Bor(ℚ₇²) = 4`, `χ_Bor(ℚ₁₁²) = 5`, `χ_Bor(ℚ₁₉²) = 5`, and
  `4 ≤ χ_Bor(ℚ₂₃²) ≤ 8` — lower halves from FS-66's fibre-share certificates (`TowerRatio p (U/p²)`; at 23 the bound
  alone, FS-66's certificate there not yet in the kernel), upper halves from the finite planes' colourings
  (`PadicPlane/Upper`, `[Madore2015]` Prop. 3.2 with the values of `[Moorhouse2010]` Table 6.1).'''),
  ('''  four-colourable, none at 23 five-colourable (`unitQuadrance_zmod_seven_pow_not_colorable_three`, … — named as''',
   '''  four-colourable (`unitQuadrance_zmod_seven_pow_not_colorable_three`, … — named as'''),
  ('from below nor compute; any value at 23 beyond `[6, 8]`.', 'from below nor compute; any value at 23 beyond `[4, 8]`.'),
 ],
}
bad = 0
for f, reps in edits.items():
    s = open(d + f, encoding='utf-8').read()
    for old, new in reps:
        if s.count(old) != 1:
            print(f'{f}: expected one occurrence of {old[:60]!r}, found {s.count(old)}'); bad += 1; continue
        s = s.replace(old, new)
    open(d + f, 'w', encoding='utf-8').write(s)
print('edits applied' if not bad else f'{bad} edits refused'); sys.exit(1 if bad else 0)
