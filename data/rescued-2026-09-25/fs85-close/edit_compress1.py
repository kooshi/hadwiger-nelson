from pathlib import Path
p = Path("CLAUDE.md"); t = p.read_text(encoding="utf-8")
def rep(old, new):
    global t
    n = t.count(old); assert n == 1, (n, old[:90]); t = t.replace(old, new)
def repitem(num, new):
    global t
    i = t.index(f"\n{num}. **"); j = t.index(f"\n{num+1}. **", i+1) if num < 23 else None
    t = t[:i+1] + new + t[j:]

rep(""" Earlier closes: FS-81 (rows 82–84; G74), FS-79 (rows 80–81; G73), FS-73 (rows 78–79; G71), FS-71 (row 77), FS-70 (row 76; G68, G69), FS-66 (row 75; G66), FS-61 (row 74), FS-58 (rows 72–73); 2026-09-19 — G64 corrected; the rest in git.*""",
    """ Earlier closes: `plans/FRONTIER-STUBS.md`'s closed list, and git.*""")
rep("""the residue plane forces pairs only
   where it is Hoffman-tight or pulls back from a tight quotient (row 87), and no 5-sealing plane does.""",
    """the residue plane forces pairs where
   it is Hoffman-tight, or where its colourings pull back from a tight quotient (row 87); no 5-sealing plane does either.""")

repitem(11, """11. **The window for six, and who can see it** (G56, G59; rows 68–71). A usable plane Γ_q can be exactly six-chromatic only at
   **q ∈ {23, 27, 31, 43, 47}** (six is refused from 59 up); none is decided, so **a single verified six-colouring at 23, 27, 43 or 47
   would be the first exactly six-chromatic finite Euclidean plane**. No field containing K can use any member, so **six is
   arithmetically excluded for every field the hunt has built in**, and a six-chromatic number field contains no √11. The window
   decides whether six is *reachable by the residue method*; its sharp target is fractional, α < q²/6 (G59).""")
repitem(12, """12. **What the wall leaves, and where the conjecture points** (G59, row 70). The wall is six finite graphs — 23, 27, 31, 43, 47
   and U₆₄ — in reach only at 47 and U₆₄ (FS-57); a composite residue target escapes it only through an integrality gap. **If it
   holds, the conjecture's main clause says nothing above five**, and its sharpest remaining prediction is **ℚ(√167)**: at least six
   (five refused at 23 at every level of the tower, row 75) against a proven four (row 79).""")
repitem(14, """14. **Real quadratic fields: three colours are decided, and four is a theorem of the family** (G61, G74, G65; rows 72–74, 79, 82–84).
   **The plane over any subfield of ℝ needs four once 1/3 lies in its unit-vector ring and it has an odd cycle** [hand, two independent
   derivations; row 82] — so every squarefree d ≡ 11 (mod 12) needs four (T4), the conjecture's L ≤ 4 clause holds for real quadratic
   fields, and χ(ℚ(√2,√7)²) ≥ 4 with no √3 in the field; `[Fischer1990]` Thm 10(ii) held the relation and proved the additive case, and
   **nothing is claimed new while `[Johnson2000]` and `[Johnson2006]` are unread**. **The census is complete** (row 83): all 40
   squarefree d ≡ 11 (mod 12) below 500 carry a certified finite witness, each with a direction with 3 in a denominator, as the kernel's
   **3-adic barrier** requires (row 72). **ℚ(√47) at four colours** (row 84): screened after a calibration on de Grey's lattice, a
   matched refusal priced out; **five not landed** (FS-84), and `4 ≤ χ(ℚ(√47)²) ≤ 5` cannot close from above by residues at any depth
   (§1.7, row 75). A three-colour question over any real field is a question about 1/3 (G74).""")
repitem(18, """18. **Where a five-forcer can live in a field is decided on finite quotients, and over ℚ(√3,√5) it is nowhere dense** (G68, G69,
   row 76). A gapped periodic four-colouring of `Λ/NΛ` frees every pair on the lattice (rows 56, 66), and periodic colourings are
   residue colourings prime by prime, so a lattice is rigid — the chain route's fabric — only where every odd prime's target refuses:
   de Grey's lattice over K does at 5, 7, 11, 13; no lattice of rank ≤ 6 over ℚ(√3,√5) does; the rank-8 one is undecided (FS-72). The
   split-prime tower at 2 is tight with forcing from depth 3. **Not landed: five over ℚ(√3,√5).** **Over K the question is closed**
   (rows 78, 85): `F = P = 8Λ`, first by one 2,044-point certificate, now by derivation from Parts's trees (item 23); Hubai had the ring
   form in 2018. No other rank-4 CM lattice in FS-73's table is rigid at four colours; rank 6 adds L3 (loose with no gap) and KR6
   (`F ⊇ 8Λ_dG`, four-colourability open).""")
repitem(20, """20. **At three colours the inheritance question is a theorem, and the answer is topological, not arithmetic** (row 79, G71). For
   every Cayley graph of a finitely generated torsion-free abelian group, three-colourability is a polytope question on the character
   torus, periodic three-colourings are dense, and the forced group has finite index exactly when the polytope is finitely many
   points. It derives ℚ(√11)'s `F = 3Λ` with no forcer, settles `[AbrishamiEtAl2025]` Problem 4.6 at three colours, and answers a
   question posed three times in 2018 — Ellenberg's, Gibbs's, Mixon's (`CLOSED-QUESTIONS.md` §2.4). **It stops at three by a fact about
   `K₄`** (G71, row 80); at four colours a two-sided certificate exists only if four-colourability is decidable, stated open in print
   (`[CGHO2025bg]` §6.2.1).""")
repitem(21, """21. **Four colours, cell by cell** (row 80, G73). Read one cell at a time, `K₄` certifies nothing: edge-local heights live only on
   sum-closed halves of `S` (rank ≤ 2; Moore–Newman's case), the loop winding is the graph's parity, face fluxes are trivial where
   directions span induced cubes, and coindex bounds stop at four on every unit-distance graph; plain density of periodic
   four-colourings fails in rank 1. **Each no-go is for its format, never for a kind of invariant**: averaged, non-local and
   structure-derived certificates stay open (FS-80) — row 85's is structure-derived (G75).""")
repitem(22, """22. **ℚ(√167) at four colours** (row 81). `L21cc6506`, the lattice of `χ ≥ 4`, is loose at four colours (`F = P = 0`); seven
   minimal lattices of a finite part of the saturated chain survive every capped screen — survivors, not refusals. Five over ℚ(√167)
   is FS-59's question.""")
rep("""Every four-colouring of "
 "`Cay(Λ, U)`""", "X") if False else None
rep("""Every four-colouring of `Cay(Λ, U)` is `8Λ`-periodic, local at one prime above 2 (Hubai's chirality), striped, 9,120 in all — by hand and exact computation from Parts's no-monochromatic-√3-triple trees, walked here as a certificate, at two independent derivations, with no solver refusal (row 85);""",
    """De Grey's lattice has exactly 9,120 four-colourings, each `8Λ`-periodic, striped and local at one prime above 2 (Hubai's chirality) — derived by hand and exact computation from Parts's no-monochromatic-√3-triple trees, walked here as a certificate, twice independently and with no solver refusal (row 85);""")
p.write_text(t, encoding="utf-8"); print(len(t.encode()))
