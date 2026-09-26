import sys
SP=sys.argv[1]
sk=open('data/fs100/x11k/skeleton/Sqrt47.lean').read()
i=sk.index("/-- The tetrahedron's"); j=sk.index('end Chain')
chain=sk[i:j]
k=sk.index('section Every'); l=sk.index('end Every')
every=sk[k:l].replace('section Every\n\nvariable {F : Subfield ℝ}\n','')
newL1=open(SP+'/newL1.lean').read()
R=[('(hBH : BochnerHerglotz (unitRing F)) (hRU : I.RU) (hA : I.APlus0)\n    (hMR : I.MR) : X4 F = ∅',
  '(hBH : BochnerHerglotz (unitRing F)) (hL1 : InvariantMeasureOnClosed F)\n    [Countable (unitRing F)] (hRU : I.RU) (hA : I.APlus0) (hMR : I.MR) : X4 F = ∅'),
 ('exists_invariantColouring (Set.nonempty','exists_invariantColouring hL1 (Set.nonempty'),
 ('theorem Interface.five_le_chromaticNumber (I : Interface F) (hBH : BochnerHerglotz (unitRing F)) (hRU : I.RU)',
  'theorem Interface.five_le_chromaticNumber (I : Interface F) (hBH : BochnerHerglotz (unitRing F))\n    (hL1 : InvariantMeasureOnClosed F) [Countable (unitRing F)] (hRU : I.RU)'),
 ('I.x4_eq_empty hBH hRU','I.x4_eq_empty hBH hL1 hRU')]
for a,b in R:
    assert chain.count(a)==1, a[:50]; chain=chain.replace(a,b)
E=[('(hBH : BochnerHerglotz (unitRing F))\n    (I : Interface F)','(hBH : BochnerHerglotz (unitRing F))\n    (hL1 : InvariantMeasureOnClosed F) (I : Interface F)'),
 ('(hBH : BochnerHerglotz (unitRing F)) (I : Interface F)','(hBH : BochnerHerglotz (unitRing F)) (hL1 : InvariantMeasureOnClosed F) (I : Interface F)'),
 ('I.five_le_chromaticNumber hBH hRU','I.five_le_chromaticNumber hBH hL1 hRU'),
 ('min_localBound_five_le_chromaticNumber hBH I','min_localBound_five_le_chromaticNumber hBH hL1 I'),
 ('min_localBound_five_le_chromaticNumber_of_totallyReal hBH I','min_localBound_five_le_chromaticNumber_of_totallyReal hBH hL1 I'),
 ('''chromaticNumber := by
  by_cases h5''','''chromaticNumber := by
  haveI : Countable F := Countable.of_moduleFinite ℚ F
  haveI : Countable (unitRing F) := countable_unitRing
  by_cases h5''')]
for a,b in E:
    assert every.count(a)>=1, a[:50]; every=every.replace(a,b)
print('hL1 counts', chain.count('hL1'), every.count('hL1'))
p='Proofs/HadwigerNelson/SpectralChain.lean'
s=open(p).read()
s=s.replace('import Proofs.HadwigerNelson.UnitRing\n','import Proofs.HadwigerNelson.UnitRing\nimport Mathlib.LinearAlgebra.Countable\n',1)
ins='noncomputable section Composition\n\nvariable {F : Subfield ℝ}\n\n'+newL1+chain.rstrip()+'\n\nend Composition\n\nsection Headline\n\nvariable {F : Subfield ℝ}\n\n'+every.strip()+'\n\nend Headline\n\n'
a='-- Spec for Part G.'
assert s.count(a)==1
s=s.replace(a, ins+a,1)
open(p,'w').write(s)
