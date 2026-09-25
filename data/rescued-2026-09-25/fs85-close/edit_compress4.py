from pathlib import Path
p = Path("CLAUDE.md"); t = p.read_text(encoding="utf-8")
def rep(old, new):
    global t
    n = t.count(old); assert n == 1, (n, old[:90]); t = t.replace(old, new)
rep("""As minted: χ ≥ 4 for the 13 certified fields beyond 11 in the kernel through a certificate type over `Adjoin d ℤ`, parametric in `d`, or through `Θ` certificates (FS-75), ℚ(√167) now among them (one witness format, one checker; 131–2,360 points, seven 1-minimal; 239's LRAT is 43 MB and 59's 39.7 MB, 95 is the expensive field to shrink; 11 has a 189-point direct witness beside the kernel's 204-point chain one); the upper halves wait""",
    """As minted: χ ≥ 4 for the 13 certified fields beyond 11 in the kernel, one witness format over `Adjoin d ℤ` and one checker, or `Θ` certificates (FS-75); sizes in the stub; the upper halves wait""")
rep("""| none on finding a 6-forcer; high on every χ(ℝ²) sentence the programme writes, and it carries the one correct form of FS-62's statement as a corollary. Phase B′, the transcendence lemma, is a half-day kernel theorem — prior art, `[Fischer1990]` Thm 6, whose Remark 1 is this bridge with a false step (G63): the product is the repair and the kernel form |""",
    """| none on finding a 6-forcer; high on every χ(ℝ²) sentence the programme writes, with FS-62's one correct form as a corollary. Phase B′, the transcendence lemma (`[Fischer1990]` Thm 6, whose Remark 1 is this bridge with a false step, G63), is a half-day kernel theorem |""")
rep("""As minted, `χ(ℚ(√167)²) ≥ 4` in the kernel: T22's ⟹ direction by V2's forward lift, V2's relation-form certificate checker with its soundness theorem, the 36-vector certificate (1,050 leaves) first; then FS-60's fields through `Θ` in place of LRATs |""",
    """As minted, `χ(ℚ(√167)²) ≥ 4` in the kernel by V2's forward lift and relation-form checker, the 36-vector certificate (1,050 leaves) first, then FS-60's fields through `Θ` |""")
# G51 fifth run, tighter
rep("""**Its fifth run** (FS-85, 2026-09-24): FS-79's personas reused; both first routes identical in kind and order (the same triangle-free abstract yes, base 8 and base 7, before any contact), divergence only after different round-1 endpoints; retractions de Bruijn 1, Coxeter 0, Poros 1 — *"the disagreement never started; verification is where contest must begin"*: two blind verifiers, one launched while the competition ran, found every divergence the milestone had (V6, D1–D4), none of truth, and an input audit walked Parts's trees. Two more covert channels: the owner wrote competitor progress into `plans/` and commit subjects, and the harness's start-up snapshot shows the last five commit subjects — so subjects are neutral from the first competitive commit on (the protocol).""",
    """**Its fifth run** (FS-85, 2026-09-24): personas reused, first routes identical (the same abstract yes, base 8 and base 7, before contact); retractions de Bruijn 1, Coxeter 0, Poros 1 — *"the disagreement never started; verification is where contest must begin"*: two blind verifiers, one during the competition, found every divergence (V6, D1–D4), none of truth, and an input audit walked Parts's trees. Two more covert channels: the owner's writes to `plans/` and commit subjects, and the harness's start-up snapshot of the last five subjects — neutral subjects from the first competitive commit on (the protocol).""")
# G75 tighter
rep("""The five inner families leave 7,290
  (`120Λ`); odd-index cosets carry the identity to the outer families (C15), and the 5-part is killed **pointwise**, slice by slice, at
  the tight dyadic quotient, where a tetrahedron-valued `G + H` must be constant in one variable (R3a) — the Greenwell–Lovász product
  shape at four colours (FS-67). Neither second moments (row 87) nor tightness of the infinite lattice (it is slack) does it. Without
  triangles rigidity is free in the abstract class and Soifer-strength in the plane (row 86).""",
"""The inner families leave 7,290
  (`120Λ`); odd-index cosets carry the identity outward (C15), and the 5-part dies **pointwise**, slice by slice, at the tight dyadic
  quotient, a tetrahedron-valued `G + H` being constant in one variable (R3a; FS-67's product shape) — not by second moments (row 87),
  and the infinite lattice is slack. Without triangles rigidity is free in the abstract class, Soifer-strength in the plane (row 86).""")
p.write_text(t, encoding="utf-8"); print(len(t.encode()))
