from pathlib import Path
p = Path("CLAUDE.md"); t = p.read_text(encoding="utf-8")
def rep(old, new):
    global t
    n = t.count(old); assert n == 1, (n, old[:90]); t = t.replace(old, new)

# G21
rep("""so a NONEMPTY at K = 1 says nothing about the field.""",
    """so a NONEMPTY at K = 1 says nothing about the field. **FS-85's two** (rows 85–86): the rank-1 scan's 377 all-rigid sets, none triangle-free, measured its range (`|D| ≤ 5`, `max D ≤ 14`) — the first triangle-free rigid set has `|D| = 70`, `max D ≈ 3.7·10¹⁹`; and a published proof transferred "step by step" by checking its points measured membership, not logic — the wiki's Prop. 7 has a gap (V6).""")

# G49
rep("""he proved the additive case and asked for a criterion.""",
    """he proved the additive case and asked for a criterion. **FS-85's:** `[KlotzSander2017]` and `[Basic2026]`, held since FS-38, bore on its step 2 unread in its words — Klotz–Sander's own Thm 4.2 gives the every-`k` triangle-free circulants in two lines, one page after they pose Problem 3.6 (row 86); and Gibbs's 2018 hand route to periodicity, dropped for want of Parts's input, sat in the held threads (row 85).""")

# G50
rep("""one page after the chapter FS-70 read in full; nothing here cited it.""",
    """one page after the chapter FS-70 read in full; nothing here cited it. **FS-85's:** the wiki's "Coloring R_2", Hubai's rotation word and `[Parts2020hv]`'s striping lemma, all held, went uncited by FS-74's leads; and an owner brief called the wiki's *Algebraic formulation* page "not held", copied from a record — held since 2026-09-09.""")

# G51
rep("""A verifier checks a fixed statement and cannot supply a missing route (the protocol, §3).""",
    """A verifier checks a fixed statement and cannot supply a missing route (the protocol, §3). **Its fifth run** (FS-85, 2026-09-24): FS-79's personas reused; both first routes identical in kind and order (the same triangle-free abstract yes, base 8 and base 7, before any contact), divergence only after different round-1 endpoints; retractions de Bruijn 1, Coxeter 0, Poros 1 — *"the disagreement never started; verification is where contest must begin"*: two blind verifiers, one launched while the competition ran, found every divergence the milestone had (V6, D1–D4), none of truth, and an input audit walked Parts's trees. Two more covert channels: the owner wrote competitor progress into `plans/` and commit subjects, and the harness's start-up snapshot shows the last five commit subjects — so subjects are neutral from the first competitive commit on (the protocol).""")

# G75 before G51
g75 = """* **G75 — Where triangles enter four-colour rigidity: as a local linear identity that pins the spectrum. [hand + tools exact (row 85); one reading]**
  On de Grey's lattice, with colours as the vertices of a regular tetrahedron, "no monochromatic √3-triple in family `k`" (Parts's
  theorem placed in `Λ`) is the eigen-equation `A_k g = −2g` of the family's hexagon operator, whose symbol `(1+X)(1+Y)(X+Y)/XY` is the
  triangle relation `1 + ζ₆² = ζ₆` made algebraic: the spectrum lies on three circles per family, the nine families' circles meet in 42
  torsion characters, exactly the dual of `8Λ`, and a Smith form reads off the period (C7, C8). The five inner families leave 7,290
  (`120Λ`); odd-index cosets carry the identity to the outer families (C15), and the 5-part is killed **pointwise**, slice by slice, at
  the tight dyadic quotient, where a tetrahedron-valued `G + H` must be constant in one variable (R3a) — the Greenwell–Lovász product
  shape at four colours (FS-67). Neither second moments (row 87) nor tightness of the infinite lattice (it is slack) does it. Without
  triangles rigidity is free in the abstract class and Soifer-strength in the plane (row 86). *Reading* (Coxeter's R2.6): in a
  triangle-free lattice the analogous frequencies are generically non-torsion, so the mechanism has nothing to pin. *Do: when a lattice
  looks rigid at four colours, find a local forbidden pattern that is linear on the tetrahedral embedding, intersect its zero sets on the
  character torus, read the period from a Smith form, and kill what the spectrum leaves pointwise at a tight quotient — never by second
  moments. Nothing kills the derivation but a defect in the chain or in Parts's trees (walked, row 85); it forbids a four-colouring of de
  Grey's lattice that is not `8Λ`-periodic. Killing test of the reading: a triangle-free lattice whose NT-type identity pins the spectrum
  onto finitely many torsion characters (FS-86, FS-59).*
"""
rep("* **G51 — A competitor and an advisor beat one mind.", g75 + "* **G51 — A competitor and an advisor beat one mind.")
p.write_text(t, encoding="utf-8"); print(len(t.encode()))
