from pathlib import Path
p = Path("CLAUDE.md"); t = p.read_text(encoding="utf-8")
def repitem(num, new):
    global t
    i = t.index(f"\n{num}. **"); j = t.index(f"\n{num+1}. **", i+1)
    t = t[:i+1] + new + t[j:]
repitem(3, """3. **The design target has no instance** (G48, row 66): the six-level question — a pair forced equal at five colours over a
   5-sealed field at 11 ∣ d², spindled into a 6-open field — is answered **no by theorem** over every 5-sealed multiquadratic
   F ⊇ K: Γ₁₁'s fan gap, repainted along the residue map, frees every pair above it, at every distance. FS-6 is dead; a 6-forcer's
   compulsions all live in 6-open fields. The frame that replaces it is **tight or slack** (G54): the residue plane forces pairs where
   it is Hoffman-tight, or where its colourings pull back from a tight quotient (row 87); no 5-sealing plane does either.""")
repitem(9, """9. **`[Parts2020a]`'s 509-vertex record is reproduced and partly explained** (M62–M64, row 62). His base is his §5.6 closed form
   (1,603 points, 92 orbits under an order-24 group); the radius-2.44 arena — base plus rotated copy — contains Heule-510 exactly, while
   the base alone cannot (it lies in K², row 57); his reduction stage is reproduced on every attested number, ~150× faster; a descent
   cannot reach the record (nine certified 1-minimal descents land at 582–609), and **overcompression is an orbit-closure gap**. Best
   1-minimal objects by symmetry rung 624 / 576 / 558 / 582, the last census-certified (`data/m62/c582/`); what is left of his loop is
   the expansion step, which has no termination measure (FS-35).""")
repitem(10, """10. **The conjecture's proved range** (G55; GPT Astra, hand, read here): χ(F²) = L(F) for every real number field with L ≤ 3, for
   every field containing √3 with L ≤ 4, **for every real quadratic field with L ≤ 4** (row 82, [hand, two independent derivations];
   G74), and, given the measured 8/3 forcer, for every multiquadratic F ⊇ K with L ≤ 5, by the chain theorem. Its cheapest predictions
   outside that range — four for ℚ(√11) and ℚ(√23) — are met (row 73); at ℚ(√47) (L = 5: 3 and 7 unusable, 11 usable) it predicts
   exactly five against a proven 4 ≤ χ ≤ 5, as at ℚ(√143), ℚ(√311), ℚ(√335) (row 74) — open (row 84; FS-84). With every residue level
   allowed, `L` is unchanged at 7, 11, 19, 23 (row 75, G66).""")
p.write_text(t, encoding="utf-8"); print(len(t.encode()))
