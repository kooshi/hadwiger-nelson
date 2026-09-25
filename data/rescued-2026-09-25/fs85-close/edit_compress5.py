from pathlib import Path
p = Path("CLAUDE.md"); t = p.read_text(encoding="utf-8")
def rep(old, new):
    global t
    n = t.count(old); assert n == 1, (n, old[:90]); t = t.replace(old, new)
i = t.index("\n23. **De Grey's lattice, derived;"); j = t.index("\n\n**The prior-art position.**")
t = t[:i+1] + ("23. **De Grey's lattice, derived; four-colour rigidity without triangles** (rows 85–87, G75, G54). De Grey's lattice has exactly "
 "9,120 four-colourings, each `8Λ`-periodic, striped and local at one prime above 2 (Hubai's chirality) — derived from Parts's "
 "no-monochromatic-√3-triple trees, walked here as a certificate, twice independently, with no solver refusal (row 85); the triangles "
 "enter as a linear identity pinning the spectrum (G75). It answers Mixon's 2018 question at its exact scope (`CLOSED-QUESTIONS.md` §2.5; "
 "the literal ring is FS-88). **Without triangles** rigidity is free in the abstract class (`F₄ = 4ℤ` on a triangle-free `G(ℤ, D)`) and "
 "in the plane exactly Soifer's Open Problem 55.1 (row 86; `CLOSED-QUESTIONS.md` §3), with no instance known (FS-86). No-gos, and a slack "
 "plane that forces: row 87. **The week** (`plans/FS85-rigidity-without-triangles.md` §R-close.2): **Paid (abstract)**, Part 1 alone "
 "**Draw (K)**; read with Kooshi's *\"A proven theorem about why its impossible is also valid. All novel knowledge is a success\"* — "
 "no-gos count. His worry that the ban was too strict, against 37 logged would-have-searched lines (2 breaches): it paid where a search "
 "would have found, and cost only where one would have aimed.") + t[j:]
rep("""**FS-85's:** `[KlotzSander2017]` and `[Basic2026]`, held since FS-38, bore on its step 2 unread in its words — Klotz–Sander's own Thm 4.2 gives the every-`k` triangle-free circulants in two lines, one page after they pose Problem 3.6 (row 86); and Gibbs's 2018 hand route to periodicity, dropped for want of Parts's input, sat in the held threads (row 85).""",
    """**FS-85's:** `[KlotzSander2017]` and `[Basic2026]`, held since FS-38, went unconnected — Klotz–Sander's own Thm 4.2 gives the every-`k` triangle-free circulants in two lines, one page after they pose Problem 3.6 (row 86); and Gibbs's 2018 hand route to periodicity, dropped for want of Parts's input, sat in the held threads (row 85).""")
rep("""by explicit rhombus chains (ℚ(√3,√5)'s is six vectors by hand; 17, 41 predicted new values)""", """by explicit rhombus chains (six vectors by hand at ℚ(√3,√5); 17, 41 predicted new values)""")
rep("""for d = 23, 47 run the CM-subfield table and the quotient/periodic Kempe screens on every candidate lattice before any ball — FS-70 spent three phases on lattices the screens close in minutes |""",
    """for d = 23, 47, the CM-subfield table and the quotient/periodic Kempe screens before any ball — FS-70 spent three phases on lattices they close in minutes |""")
rep("""**FS-85's two** (rows 85–86): the rank-1 scan's 377 all-rigid sets, none triangle-free, measured its range (`|D| ≤ 5`, `max D ≤ 14`) — the first triangle-free rigid set has `|D| = 70`, `max D ≈ 3.7·10¹⁹`; and a published proof transferred "step by step" by checking its points measured membership, not logic — the wiki's Prop. 7 has a gap (V6).""",
    """**FS-85's two** (rows 85–86): the rank-1 scan's 377 all-rigid sets, none triangle-free, measured its range (`|D| ≤ 5`, `max D ≤ 14`) — the first triangle-free rigid set has `|D| = 70`, `max D ≈ 3.7·10¹⁹`; and a published proof transferred "step by step" by checking its points measured membership, not logic (the wiki's Prop. 7, V6).""")
p.write_text(t, encoding="utf-8"); print(len(t.encode()))
