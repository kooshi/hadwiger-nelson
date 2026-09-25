from pathlib import Path
p = Path("CLAUDE.md"); t = p.read_text(encoding="utf-8")
def rep(old, new):
    global t
    n = t.count(old); assert n == 1, (n, old[:90]); t = t.replace(old, new)

# intro range
rep("G1–G74 are stable\nidentifiers", "G1–G75 are stable\nidentifiers") if "G1–G74 are stable\nidentifiers" in t else rep("G1–G74", "G1–G75")

# ---- G54 ----
rep("* **G54 — Tight or slack: a residue plane's compulsions at k colours are classified by one sign. [kernel one",
    "* **G54 — Tight or slack: one sign says where a residue plane must force; slack only permits gaps. [kernel one")
rep("""Blokhuis–Brouwer–Haemers's, the periodicity ours). The middle case — slack but gap-free — is logically open and
  unobserved (at 11 no 5-colouring has every vertex gapped, on two engines).""",
"""Blokhuis–Brouwer–Haemers's, the periodicity ours). **The middle case — slack but gap-free — is observed** (row 87):
  `Cay(Λ/16Λ, U)` is slack at four colours (`λ_min = −18.883 < −18`), yet every four-colouring pulls back from the tight `Λ/8Λ`
  (54 generators onto 36, unequal fibres), so all are gap-free and it forces; at 11 no 5-colouring has every vertex gapped, on two
  engines. *Demotion record:* as minted this entry said the sign classifies a plane's compulsions and read slack as free; slackness
  permits gaps and does not supply one.""")
rep("""residue mechanism forces pairs only where the plane is tight, and no plane that seals a field at five is — so the""",
    """residue mechanism forces pairs where the plane is tight or pulls back from a tight quotient, and no plane that seals a field at five does (each has a gap, row 66) — so the""")
rep("""Slack: expect gaps, and with one gapped colouring the freedom of every pair above it (row 66) — ask no solver for forced pairs on that plane's fabric.""",
    """Slack: find one gapped colouring, and with it the freedom of every pair above it (row 66) — then ask no solver for forced pairs on that plane's fabric; with none found, check whether its colourings pull back from a tight quotient (`Λ/16Λ` → `Λ/8Λ`, row 87) before calling it free.""")
rep("""plane that is unbalanced or gapped; a slack plane every one of whose k-colourings is gap-free (the middle case).*""",
    """plane that is unbalanced or gapped; of the reading that the middle case comes from a tight quotient, a slack plane whose k-colourings are all gap-free and pull back from none (the middle case itself fired at row 87).*""")
rep("""the prime above 3 is split in `ℚ(√11, i)`, not conjugation-fixed (Poros), and `Θ₃` explains that instance (G71); the K instance
  is unexplained (`plans/STUB-algebraic-explanation.md`).""",
"""the prime above 3 is split in `ℚ(√11, i)`, not conjugation-fixed (Poros), and `Θ₃` explains that instance (G71); the K instance
  is explained since row 85 (G75): the triangles supply the period and the tight dyadic quotient kills the 5-part pointwise —
  tightness alone did not, the infinite lattice being slack (row 87).""")

# ---- G69 ----
rep("""at `v = −(4/9)(1+√−11)` (row 78)**""", """at `v = −(4/9)(1+√−11)` (row 78), and since row 85 by derivation from Parts's trees, so Harder's `8/3 ∈ 8Λ` is derived too**""")

# ---- G70 ----
rep("""classes of four-colourings — all of them, since `F = 8Λ` — exactly one is √3-clean, and it is Theorem B's pair.""",
    """classes of four-colourings — all of them, since `F = 8Λ` — exactly one is √3-clean, and it is Theorem B's pair. Since row 85 the classes are derived, not enumerated: every colouring is a striped colouring of the 64-vertex torus pulled back along one prime above 2 (G75).""")

# ---- G71 ----
rep("""and whatever makes de Grey's lattice rigid at four colours (`F = 8Λ`, row 78) is not a height
  of this kind, even on its own language.""",
"""and whatever makes de Grey's lattice rigid at four colours (`F = 8Λ`, row 78) is not a height
  of this kind, even on its own language — it is a linear identity and a tight quotient (row 85, G75).""")
rep("""that uses no arithmetic of the lattice — not met at FS-79 (P-G71).*""",
    """that uses no arithmetic of the lattice — not met at FS-79 (P-G71); **met at FS-85 in the abstract class** (row 86: an embedding makes any finite forcer's compulsions translation-invariant with no arithmetic), so the reading survives on unit-distance lattices only, where row 85 uses the dyadic primes and the 5-part.*""")

# ---- G72 ----
rep("""On the plan-phase advisor's proposed split — target-moving results counted apart from no-gos, **Kooshi's call, open** — the method stands two for three: FS-73 and FS-81 moved targets, FS-79 produced no-gos.""",
    """**Third count (FS-85, §R-close.4):** through the structural question — row 85 answers S1 (classify every four-colouring), row 86 S2 in the abstract class, row 87's no-gos the same questions. The plan-phase advisor's split, target-moving results apart from no-gos, **Kooshi declined: "yes", no-gos count** (2026-09-24); so the method stands **four of four** — FS-73, FS-79, FS-81, FS-85.""")

# ---- G73 ----
rep("""or structure-derived (group ring, counting on a base
  pattern).""",
"""or structure-derived (group ring, counting on a base
  pattern). **On de Grey's lattice** (rows 85, 87): radius 1 of the averaged format cannot lift `120Λ` to `8Λ`, and the proof that
  does is structure-derived — a linear identity per family, then a pointwise splitting at a tight quotient (G75).""")

p.write_text(t, encoding="utf-8"); print(len(t.encode()))
