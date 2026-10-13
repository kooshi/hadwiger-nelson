#!/usr/bin/env python3
"""FS131-KN2: the changes the domain-modeling pass made to the skeleton, applied once after the first build
(the module files are not edited while a build walks). Every replacement asserts its pattern is present."""
import pathlib, re, sys
ROOT = pathlib.Path(__file__).resolve().parents[3]
u = ROOT / "Proofs/HadwigerNelson/Arith/UpperHalf.lean"; s = u.read_text()
def sub(s, old, new, count=1):
    assert s.count(old) >= 1, old
    return s.replace(old, new) if count == 0 else s.replace(old, new, count)
# (a) dot notation: P.heightOne, P.localRing, P.residue m
s = sub(s, "def heightOne (P : StablePrime F)", "def _root_.HadwigerNelson.SpectralChain.StablePrime.heightOne (P : StablePrime F)")
s = sub(s, "noncomputable abbrev localRing (P : StablePrime F)", "noncomputable abbrev _root_.HadwigerNelson.SpectralChain.StablePrime.localRing (P : StablePrime F)")
s = sub(s, "noncomputable def residue (P : StablePrime F) (m : ℕ) : localRing P", "noncomputable def _root_.HadwigerNelson.SpectralChain.StablePrime.residue (P : StablePrime F) (m : ℕ) : localRing P")
s = sub(s, "(heightOne P)", "P.heightOne", 0)
s = sub(s, "localRing P", "P.localRing", 0)
s = sub(s, "residue P m", "P.residue m", 0)
s = sub(s, "`heightOne P`; `P.localRing` abbreviates it and `P.residue m : P.localRing →+*", "`P.heightOne`; `P.localRing` abbreviates it and `P.residue m : P.localRing →+*")
# (b) the two-colour theorem: `2 ∈ P` follows from conjugation being trivial modulo `P`
old = s[s.index("/-- **Two colours at a ramified dyadic stable prime**"):s.index("/-! ### The converse half")]
new = '''/-- A stable prime modulo which conjugation is the identity holds `2`: `ī − i = −2i` and `i` is a unit. -/
theorem two_mem_of_conj_trivial (P : StablePrime F) (hram : ∀ x : 𝓞 (fieldI F), conjO F x - x ∈ P.P) :
    (2 : 𝓞 (fieldI F)) ∈ P.P := by
  sorry

/-- **Two colours at a ramified stable prime** (`LEDGER.md` row 63's two-colour theorem, at a real number field): if
conjugation is the identity modulo a stable prime `P` of `F(i)` — `P` is ramified over `F`, and then dyadic
(`two_mem_of_conj_trivial`) — the plane over `F` is two-colourable. (`colorable_two_unitDistance_induce_of_valuationSubring`
at `𝓞_P` with the residue map into the field `𝓞 ⧸ P` of characteristic 2, on which conjugation acts trivially.) -/
theorem colorable_two_planeOver_of_ramified (P : StablePrime F) (hram : ∀ x : 𝓞 (fieldI F), conjO F x - x ∈ P.P) :
    ((unitDistance ℂ).induce (planeOver F)).Colorable 2 := by
  sorry

'''
s = s.replace(old, new)
s = sub(s, "* **Two colours**: at a stable prime holding `2` on whose residue field conjugation is the identity, `χ(F²) ≤ 2`\n  (`colorable_two_planeOver_of_ramified_dyadic`).", "* **Two colours**: at a stable prime on whose residue field conjugation is the identity (ramified over `F`; it then holds\n  `2`), `χ(F²) ≤ 2` (`colorable_two_planeOver_of_ramified`).")
u.write_text(s)
v = ROOT / "Proofs/HadwigerNelson/Instances/UpperHalfValues.lean"; t = v.read_text()
t = sub(t, "(colorable_two_planeOver_of_ramified_dyadic P h2 hram).chromaticNumber_le", "(colorable_two_planeOver_of_ramified P hram).chromaticNumber_le")
t = sub(t, "(let ⟨P, h2, hram⟩ := exists_stablePrime_rat", "(let ⟨P, _, hram⟩ := exists_stablePrime_rat")
t = sub(t, "`colorable_two_planeOver_of_ramified_dyadic`'s hypotheses", "`colorable_two_planeOver_of_ramified`'s hypothesis")
v.write_text(t)
a = ROOT / "ARCHITECTURE.md"; w = a.read_text()
w = sub(w, "`colorable_two_planeOver_of_ramified_dyadic`", "`colorable_two_planeOver_of_ramified`")
w = sub(w, "eleven leaves are `sorry`", "twelve leaves are `sorry`")
w = sub(w, "`heightOne`, `localRing` (Mathlib's `valuationSubringAtPrime`), `residue`,", "`StablePrime.heightOne`, `StablePrime.localRing` (Mathlib's `valuationSubringAtPrime`), `StablePrime.residue`,")
a.write_text(w)
print("applied")
