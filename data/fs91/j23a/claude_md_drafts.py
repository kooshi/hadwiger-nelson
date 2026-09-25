"""J23a stage 4: FS-91's drafted edits to CLAUDE.md as exact (old, new) pairs, for the front-page job (J24) to apply.
Run: python3 data/fs91/j23a/claude_md_drafts.py [--plant]
Applies every pair to a COPY of CLAUDE.md in memory (never to the file), checks each `old` occurs exactly once, and prints the net
byte change against the 4,000-byte cap of the brief. Exit 1 on any missing/duplicate anchor or on the cap. The plant corrupts one
anchor, which must be reported. Row numbers N1-N5 are placeholders: J24 assigns the ledger rows."""
import sys
E = []
def e(old, new): E.append((old, new))
# E1 the close line
e("""*Last updated: 2026-09-25 — **FS-89 closed** (rows 95–97; G76 rewritten; G74, G30 corrected): rational band rigidity (row 95) and its consequences at the exposed fields (rows 96–97); verdict **Paid (theorem)**, outcome O1 at a prior of 0.10 (`plans/FS89-rational-band-rigidity.md` §R-close).""",
"""*Last updated: 2026-09-25 — **FS-91 closed** (crunch milestone M1; rows N1–N5; G77 minted; G48, G55, G61, G71, G74, G76 corrected): band rigidity at every band, the class theorem for character colourings at existence scope, the character chromatic numbers at the exposed fields, one prime failing three ways, and three colours over every real number field; verdict **Paid (theorem)**, O1 at a prior of 0.30 (`plans/FS91-character-local-global.md` §R-close).""")
# E2 the target (2)
e("""The conjecture is proved only for L ≤ 3 generally, L ≤ 4 given √3, and
L ≤ 5 for multiquadratic F ⊇ K (G55); since FS-81 also L ≤ 4 for every real quadratic field (row 82). Its remaining *testable* range is L ≤ 5 outside those classes (FS-61, FS-46, FS-48, FS-82), then""",
"""The conjecture is proved for L ≤ 4 over every real number field (row N2) and
L ≤ 5 for multiquadratic F ⊇ K (G55). Its remaining *testable* range is L = 5 outside that class (FS-84, FS-48), then""")
e("""; four at ℚ(α,√7), α³ = α + 1, outside the proved range (FS-82); and at least six at **ℚ(√167)**, proven 4 (rows 79, 82), the widest gap, at discriminant 668 (no character five-colouring, row 96).""",
"""; and at least six at **ℚ(√167)**, proven 4 (rows 79, 82), the widest gap, at discriminant 668 (characters need eight there, given CLG, row N4).""")
e("""Four at the census's 25 open fields, and at every squarefree d ≡ 11 (mod 12), is met (rows 82–83).""",
"""Four at the census's 25 open fields, at every squarefree d ≡ 11 (mod 12) and at ℚ(α,√7), α³ = α + 1, is met (rows 82–83, N2).""")
e("""(its one-character case is closed, row 96)""", """(its one-character case is closed, rows 96, N4)""")
# E4 item 10
e("""χ(F²) = L(F) for every real number field with L ≤ 3, for
   every field containing √3 with L ≤ 4, **for every real quadratic field with L ≤ 4** (row 82, [hand, two independent derivations];
   G74), and""",
"""χ(F²) = L(F) for every real number field with **L ≤ 4**
   (row N2, [hand, three derivations]; G74), and""")
# E5 item 14
e("""A three-colour question over any real
   field is a question about 1/3 (G74).""",
"""Over a number field three colours ask for a
   prime above 3 of residue field 𝔽₃, not for 1/3 (row N2, G74).""")
# E6 item 25 and a new item 26
e("""25. **Two primes restore Furstenberg–Berend rigidity modulo the rotated direction** (rows 95–97, G76): every four- and five-colour band
   character of `ℤ[i][1/p : p ≡ 1 (4)]`, hence of every real field's unit-vector ring, is torsion plus archimedean; at one prime it fails.
   So a falsifier of the conjecture at ℚ(√47) or ℚ(√167) is no character (FS-83 answered). Berend's method, not his statements (row 95).""",
"""25. **Two primes restore Furstenberg–Berend rigidity modulo the rotated direction, at every band** (rows 95–97, N1, N5; G76): every band
   character of `ℤ[i][1/p : p ≡ 1 (4)]`, hence of every real field's unit-vector ring, is torsion plus archimedean at the places of `F(i)`;
   at one prime it fails for points, minimal sets and torsion orders. The band condition is the pyjama problem's (`[Manners2015]`, row N1).
26. **Character colourings are local in the existence sense** (rows N3–N4, G77): a real number field's plane has a character `k`-colouring
   iff some residue target does, so a falsifier of the conjecture is no character at `k ≤ 5` (FS-83 answered) or over a quadratic field;
   given CLG, characters need 8 colours at ℚ(√167), 17 at K(√7), 22 at de Grey's field, 8 on Γ₂₃ and 9 on Γ₄₃ — the window is closed to
   characters. That every character colouring is local is proved only at three colours (row N2) and at HD1's fields.""")
# E7 the prior-art position
e("""rational band rigidity at two or more primes and its field consequences (rows 95–97);""",
"""rational band rigidity at two or more primes, at every band, and its field consequences (rows 95–97, N1); the class theorem for character colourings, the character chromatic numbers, three colours over every real number field and one prime's three failures (rows N2–N5);""")
e("""**Not ours:** closed-set rigidity on the circle""",
"""**Not ours:** band rigidity on `ℤ[i][1/P₅, 1/P₁₃]` (`[Manners2015]` Lemma 5.3), the regular chromatic number (`[BarajasSerra2008]`); closed-set rigidity on the circle""")
# E9 the re-rank preamble
e("""(re-ranked 2026-09-25 at FS-89's close, one rank per row: FS-89 closed; FS-91 minted at rank 2; FS-83 answered and moved below FS-84; FS-59, FS-84, FS-64, FS-90, FS-76 re-aimed; G76 forwarded.""",
"""(re-ranked 2026-09-25 at FS-91's close, one rank per row: FS-91 and FS-82 closed, FS-83 answered; three stubs minted; FS-59, FS-64, FS-75, FS-47, FS-48 re-aimed; G77 forwarded.""")
# E10 table rows (the rank column is renumbered by J24 after deletions and insertions)
e("""| 2 | **FS-91 band rigidity at six colours, and at one prime** — `plans/STUB-band-rigidity-six.md` (minted at FS-89's close) | does row 95's route reach band 1/6 (Lemma SW and VB1 re-read there; the parity line lands in `Θ₃`, which is rigid) and 1/8; D's band-1/6 exit lemma; `MS₄({5})` and U3 at one prime; absorbs FS-83's `k ≥ 6` remainder; solver-free | speculative; the first character statement at six, ℚ(√167)'s predicted count |
""", "")
e("""| 5 | **FS-83 the layer method at four and five colours** — `plans/STUB-layer-method-five-colours.md` (minted at FS-81's close) | can one character of `ℤ[U_F]` put every unit vector in `[1/k, 1 − 1/k]`, a whole-plane colouring local at no prime? **Answered at FS-89's close:** no, at `k = 4` over ℚ(√47) and `k = 5` over ℚ(√167) (row 96); left, `k ≥ 6` (FS-91) | none now at the exposed fields; kept for its banner |
""", "")
e("""| 12 | **FS-82 three colours at residue degree three** — `plans/STUB-three-colours-residue-degree-three.md` | the one class of real number fields row 82 leaves open (FS81-T7): every prime above 3 of odd residue degree has degree ≥ 3, so no additive three-colouring exists; first ℚ(α, √7), α³ = α + 1, where L = 4 by the plane at 7 … | none on six; completes the three-colour classification of real number fields; a cheap exposed test at L = 4 |
""", "")
e("""FS-89: no character five-colouring (row 96) |""", """FS-89, FS-91: characters need eight, given CLG (rows 96, N4) |""")
e("""**re-aimed at FS-81's close: T4 for the whole family in the kernel** — T22's ⟹, then FS81-T1–T5; fallback, a kernel checker for FS-81's structural certificates on the census (row 83); the minted target, `χ(ℚ(√167)²) ≥ 4`, is an instance …""",
"""**re-aimed at FS-91's close: S1 and no mixing in the kernel** (row N2) — finite algebra and one character-sum bound, with FS81-T2 and T22's ⟹ as the named hand inputs; fallback, FS-81's census certificates (row 83) …""")
e("""and the one-character case (FS-83) is closed at both exposed fields (row 96); a five-colour window over ℚ(√167) is untouched |""",
"""and the one-character case is closed at both exposed fields, at six and seven too given CLG (rows 96, N4); a five-colour window over ℚ(√167) is untouched |
| — | **FS-M1a character colourings: classification and CLG-g's exception** — `plans/STUB-character-classification.md` (minted at FS-91's close) | is every band `k`-character, `k ≥ 4`, one place's pullback plus an archimedean part (true at `k = 3` and at HD1's fields; CLG is existential)? is CLG-g's exception ever realised; does (g3) hold at `e ≥ 2`? solver-free | none directly; the shape a character falsifier would need |""")
e("""**re-aimed at FS-81's close: multiquadratic fields without √3** — three colours decided there (row 82)""",
"""**re-aimed at FS-91's close:** three colours decided for every multiquadratic field (row N2)""")
e("""| prime inversion (1/p ∈ R iff no stable prime above p, by lying-over — M56 L7's conjecture …""",
"""| Lemma C/C′ (row N3): `ℤ[U_F] = O′` with no Galois hypothesis off a ramified stable dyadic place; prime inversion a corollary (M56 L7's conjecture …""")
e("""| none directly; free classification theorems if they exist, the negative if they do not, and the paper's second-discipline vocabulary (FS-20) |""",
"""| none directly; free classification theorems if they exist, the negative if they do not, and the paper's second-discipline vocabulary (FS-20) |
| — | FS-M1b band rigidity from the pyjama theorem — `plans/STUB-pyjama-gluing.md` | does row N1 follow from `[Manners2015]` on `A` and `Ā` by one gluing step; an effective `N_k`; density | none; attribution and effectivity |
| — | FS-M1c one-prime minimal sets — `plans/STUB-one-prime-minimal-sets.md` | dimension; are all of them S-adic; band 1/5 | none; mechanism |""")
# E11 grokkings
e("""G1–G76 are stable""", """G1–G77 are stable""")
e("""a verdict names whose route failed.""",
"""a verdict names whose route failed. **FS-91's two:** a positive control of the wrong shape (row 69's line-periodic ceiling at 43 named as a character positive; `χ_char(Γ₄₃) = 9`) — ask a control which shapes its generator represents; and an existence theorem paraphrased as a classification at four addresses (G77).""")
e("""**Proved range:** G55; L(F) is the sharp form""", """**Proved range:** L ≤ 4 over every real number field (row N2), L ≤ 5 over multiquadratic F ⊇ K (G55); L(F) is the sharp form""")
e("""the L = 4 field ℚ(α,√7) (FS-82), and ℚ(√167) at L ≥ 6 (FS-59) — each falsified only by a whole-plane colouring,""",
"""and ℚ(√167) at L ≥ 6 (FS-59) — each falsified only by a whole-plane colouring, and at `k ≤ 5` by no character (G77),""")
e("""lies above p (by lying-over) — M56 L7's conjecture, proved in general;""",
"""lies above p (by lying-over) — M56 L7's conjecture, proved in general; and R = O′, integral at the stable primes, with no Galois hypothesis off a ramified stable dyadic place (row N3);""")
e("""**without √3 the half it lacked is row 82** (G74): `1/3 ∈ ℤ[U_F]` and an odd cycle make `F²` need four in any `F ⊆ ℝ`, so a three-chromatic real number field has a prime above 3 of odd residue degree (FS81-T7), and the conjecture's clause at L ≤ 4 holds for real quadratic fields too;""",
"""**without √3 too** (row N2): a three-colouring's torsion part is a residue character at a stable prime of residue field 𝔽₃, so χ(F²) = L(F) at L ≤ 4 for every real number field (row 82 had the real quadratic case by `1/3`);""")
e("""decide three colours at the field level first — is `1/3 ∈ ℤ[U_F]` (no conjugation-stable prime above 3) and is the plane non-bipartite — and build
  nothing when it is;""",
"""decide three colours at the field level first — over a number field, three iff an odd cycle and a prime above 3 of residue field 𝔽₃
  (row N2); over any real field, `1/3 ∈ ℤ[U_F]` and an odd cycle force four — and build nothing;""")
e("""over a whole real quadratic field it is decided already (row 82, G74: four exactly at d ≡ 11 mod 12)""",
"""over a whole real number field it is decided already (row N2)""")
e("""and the residual three-colour case,
  primes above 3 of odd residue degree ≥ 3, has no `1/3` to glue with (FS-82).""",
"""and the residual three-colour case, primes
  above 3 of odd residue degree ≥ 3, closes without `1/3`: four, by no mixing (row N2).""")
e("""— **fired at one prime** (row 97: two leaves glue); over every split prime at once the reading holds (row 95).*""",
"""— **fired at one prime** (rows 97, N5: two leaves glue, and minimal sets escape too); over two or more primes it holds at every band (rows 95, N1).*""")
e("""and it holds at two or more primes: an orbit closure has archimedean small differences, and meets `T + A`, or every difference,
  and the band forces a corner (row 95); so HD1 holds (row 96); at one prime two leaves glue (row 97).""",
"""and it holds at two or more primes at every band: minimal sets are band-free (Berend's Thm I.2) and the band enters once, in a multi-digit
  sweep (rows 95, N1; on the half ring it is `[Manners2015]`'s pyjama lemma); so HD1 holds (row 96); at one prime points, minimal sets and
  torsion orders all fail (rows 97, N5).""")
e("""FS-64 is the one proposal for an instrument that is not.""",
"""FS-64 is the one proposal for an instrument that is not. Characters are shut out of that gap at the exposed fields: given CLG they need 8, 17, 22 colours at ℚ(√167), K(√7), de Grey's field (row N4).""")
e("""* **G51 — A competitor and an advisor beat one mind.""",
"""* **G77 — A character colouring of a field plane is local in the existence sense only: the value-set profile peels. [hand, two independent derivations (rows N1, N3), given band rigidity at every band]** A band character of `R_F` is torsion plus archimedean; the archimedean part vanishes at complex places and is an interval about 0 at real ones; the torsion part factors over the stable places (`R_F = O′`); and a sum of symmetric subsets of the circle inside the band keeps **some** summand inside it. So a band `k`-character exists iff a residue target at some level has one, and `χ_char(F²)` — `[BarajasSerra2008]`'s regular chromatic number — is a minimum over targets. **Existence, not classification:** CLG does not say a given character colouring comes from one place; that is proved at three colours (no mixing, row N2) and at HD1's fields (Lemma D), and open elsewhere (FS-M1a). On a finite plane a character colouring is a regular colouring of a circulant, weaker than a colouring (`χ_char(Γ₁₁) = 6 > 5`) and than a line-periodic one (`χ_char(Γ₄₃) = 9 > 8`). *Do: when a question is about character colourings of a field plane, compute each residue target's `χ_char` by its trace sets below Weil's threshold and take the minimum — no lattice, no solver; state the result as existence, and name the extra input (no mixing, Lemma D) before saying every character colouring is local. Nothing kills the theorem but a defect in its chain; it forbids a character colouring with fewer than `L(F)` colours at `k ≤ 5` and over quadratic fields. Killing test of the reading that CLG-g's exception is never realised: a band 6- or 7-character above level one of a `U₆₄` tower, or at level `2e + 1` above 3 at `q = 27`.*
* **G51 — A competitor and an advisor beat one mind.""")
if "--render" in sys.argv:
    for i, (o, n) in enumerate(E, 1):
        oo = " ".join(o.split()); nn = " ".join(n.split()) if n else "(delete the row)"
        print(f"**C{i}.** replace «{oo[:160]}{'…' if len(oo) > 160 else ''}» with:\n\n> {nn}\n")
    sys.exit(0)
if "--plant" in sys.argv:
    E[0] = ("*Last updated: 2099", E[0][1])
s = open("CLAUDE.md", encoding="utf-8").read(); t = s; bad = []
for i, (o, n) in enumerate(E):
    c = t.count(o)
    if c != 1: bad.append((i, c, o[:70])); continue
    t = t.replace(o, n)
net = len(t.encode()) - len(s.encode())
print(f"{len(E)} edits; bad anchors: {bad}; CLAUDE.md {len(s.encode())} -> {len(t.encode())} bytes, net {net:+d} (cap 4000; file budget 300000)")
sys.exit(1 if bad or net > 4000 or len(t.encode()) > 300000 else 0)
