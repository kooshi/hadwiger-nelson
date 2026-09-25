from pathlib import Path
p = Path("CLAUDE.md"); t = p.read_text(encoding="utf-8")
def rep(old, new):
    global t
    n = t.count(old); assert n == 1, (n, old[:90]); t = t.replace(old, new)
rep("""(**row 82 a candidate paper once the Johnson papers are read, Kooshi's call; re-scoped 2026-09-22: `[Fischer1994]` holds Theorem B's value, read and verified; what is left is Theorem A's general form, the kernel certificate, the two colourings compared, and the record corrected — Kooshi's call whether to write it**)""",
    """(**Kooshi's call whether to write it: `[Fischer1994]` holds Theorem B's value, read and verified 2026-09-22; left, Theorem A's general form, the kernel certificate, the two colourings compared, the record corrected; row 82 a candidate once the Johnson papers are read**)""")
rep("""the K instance
  is explained since row 85 (G75): the triangles supply the period and the tight dyadic quotient kills the 5-part pointwise —
  tightness alone did not, the infinite lattice being slack (row 87).""",
    """the K instance
  is explained since row 85 (G75): triangles supply the period, the tight dyadic quotient kills the 5-part.""")
rep("""**On de Grey's lattice** (rows 85, 87): radius 1 of the averaged format cannot lift `120Λ` to `8Λ`, and the proof that
  does is structure-derived — a linear identity per family, then a pointwise splitting at a tight quotient (G75).""",
    """**On de Grey's lattice** (rows 85, 87) radius-1 averaging cannot lift `120Λ` to `8Λ`; the
  proof that does is structure-derived (G75).""")
rep("""**met at FS-85 in the abstract class** (row 86: an embedding makes any finite forcer's compulsions translation-invariant with no arithmetic), so the reading survives on unit-distance lattices only, where row 85 uses the dyadic primes and the 5-part.*""",
    """**met at FS-85 in the abstract class** (row 86, no arithmetic), so the reading survives on unit-distance lattices only, where row 85 uses the dyadic primes.*""")
rep("""**Third count (FS-85, §R-close.4):** through the structural question — row 85 answers S1 (classify every four-colouring), row 86 S2 in the abstract class, row 87's no-gos the same questions.""",
    """**Third count (FS-85, §R-close.4):** through the structural question — rows 85, 86 answer S1 and S2, row 87's no-gos the same questions.""")
rep("""**Ranked stubs** (re-ranked 2026-09-24 at FS-85's close, one rank per row: FS-74 closed by row 85; FS-86, FS-87, FS-88 minted at ranks 2, 8, 15; FS-67 re-aimed to its four-colour form and moved to 9; FS-59, FS-76, FS-80 re-aimed; G75 forwarded into FS-59, FS-67, FS-76, FS-80, FS-86, FS-88. A solver column there marks the stubs the finite-witness-free week can run; `plans/FRONTIER-STUBS.md` is authoritative):""",
    """**Ranked stubs** (re-ranked 2026-09-24 at FS-85's close, one rank per row: FS-86, FS-87, FS-88 minted at ranks 2, 8, 15; FS-67 moved to 9 for its four-colour form; FS-59, FS-76, FS-80 re-aimed; G75 forwarded. Its solver column marks what the finite-witness-free week can run; `plans/FRONTIER-STUBS.md` is authoritative):""")
rep("""the stub carries the banner): de Grey's `8Λ` derived, FS-74 closed by it; the triangle-free abstract yes and its Soifer calibration; FS-86, FS-87, FS-88 minted; FS-59, FS-67, FS-76, FS-80 re-aimed.""",
    """the stub carries the banner); FS-74 closed by it.""")
rep("(six vectors by hand at ℚ(√3,√5);", "(ℚ(√3,√5)'s: six vectors by hand;")
p.write_text(t, encoding="utf-8"); print(len(t.encode()))
