import sys
p='/home/kooshi/source/lean-dir/CLAUDE.md'
s=open(p,encoding='utf-8').read()
n0=len(s.encode())
def rep(a,b):
    global s
    c=s.count(a)
    if c!=1:
        print("COUNT",c,"for:",a[:100]); sys.exit(1)
    s=s.replace(a,b)
rep("(re-ranked 2026-09-25 at FS-86's close, one rank per row: FS-86 closed; FS-89, FS-90 minted at ranks 2, 3; FS-59, FS-83, FS-84, FS-64, FS-67, FS-76, FS-87 re-aimed; G76 forwarded.",
    "(re-ranked 2026-09-25 at FS-89's close, one rank per row: FS-89 closed; FS-91 minted at rank 2; FS-83 answered and moved below FS-84; FS-59, FS-84, FS-64, FS-90, FS-76 re-aimed; G76 forwarded.")
rep("FS-86: four-colour windows excluded (row 92), five untouched |","FS-86: four-colour windows excluded (row 92); FS-89: no character five-colouring (row 96) |")
rep("""| 2 | **FS-89 the missing theorem: measure rigidity with isometric archimedean directions** — `plans/STUB-isometric-measure-rigidity.md` (minted at FS-86's close) | every non-periodic construction reading finitely much is dead (rows 91–92); HD1 needs an `S`-adic, Berend-type rigidity theorem for the unit-vector action on `R̂` with isometric archimedean directions, not in print (G76); with it Lemma X, the three-phase case; solver-free | none directly; HD1 false gives `F(R) = 0` over ℚ(√59), HD1 true excludes every character colouring; reading-room research, low confidence |""",
"""| 2 | **FS-91 band rigidity at six colours, and at one prime** — `plans/STUB-band-rigidity-six.md` (minted at FS-89's close) | does row 95's route reach band 1/6 (Lemma SW and VB1 re-read there; the parity line lands in `Θ₃`, which is rigid) and 1/8; D's band-1/6 exit lemma; `MS₄({5})` and U3 at one prime; absorbs FS-83's `k ≥ 6` remainder; solver-free | speculative; the first character statement at six, the colour count the conjecture predicts at ℚ(√167) |""")
rep("HD1-cert's certificate on `Λ₅₁₀` (semi-decidable: two hours can confirm HD1, never refute it)","HD1-cert's certificate on `Λ₅₁₀` (HD1 is proved, row 96, so a certificate exists on some lattice; the search would find its size and a kernel-checkable form)")
rep("The plan-phase advisor's question; solver-free. **At FS-86's close:** dead at `k = 4` on type-(B) planes and for windows over ℚ(√47) (rows 91–92); live at `k = 5` and for characters of infinite type (FS-89) | speculative; the only solver-free instrument aimed at the conjecture's falsifier where it is exposed |",
    "**Answered at FS-89's close:** no, at `k = 4` over ℚ(√47) and `k = 5` over ℚ(√167) (row 96); left, `k ≥ 6` (FS-91) | none now at the exposed fields; kept for its banner |")
rep("cannot be a measurable window colouring over finitely many places (row 92, one mind)","cannot be a measurable window colouring over finitely many places (row 92, one mind), nor a character colouring (row 96)")
rep("Kempe swaps, patchworks and half-space defects cannot break inheritance (row 91)","Kempe swaps, patchworks, half-space defects (row 91) and character colourings (row 96) cannot break inheritance")
rep("**At FS-86's close:** with any finite set of places and measurable windows it cannot four-colour a type-(B) plane non-periodically (row 92); its five-colour aim at ℚ(√167) is untouched",
    "**At FS-86's and FS-89's closes:** with finitely many places and measurable windows it cannot four-colour a type-(B) plane non-periodically (row 92), and its one-character case is closed at both exposed fields (row 96); a five-colour window over ℚ(√167) is untouched")
# swap FS-83 (rank 4) below FS-84 (rank 5)
L=s.split('\n')
i83=[i for i,l in enumerate(L) if l.startswith('| 4 | **FS-83 ')]
i84=[i for i,l in enumerate(L) if l.startswith('| 5 | **FS-84 ')]
assert len(i83)==1 and len(i84)==1 and i84[0]==i83[0]+1, (i83,i84)
a,b=L[i83[0]],L[i84[0]]
L[i83[0]]='| 4 |'+b[len('| 5 |'):]
L[i84[0]]='| 5 |'+a[len('| 4 |'):]
s='\n'.join(L)
# grokkings
rep("""* **G76 — Four-colour rigidity over a field is a local theorem and a global extension question, and every construction of a "no" that reads finitely much dies. [hand, two derivations for the frame, the local theorem and the no-gos (rows 88–92); the obstruction a reading, reached twice independently]**""",
"""* **G76 — Four-colour rigidity over a field is a local theorem and a global extension question; every construction of a "no" that reads finitely much dies, and no character is one. [hand, two derivations for the frame, the local theorem and the no-gos (rows 88–92); for characters one derivation, every lemma blind-verified (rows 95–96)]**""")
rep("""(rows 91–92); what would exclude it is measure
  rigidity for the unit-vector action on `R̂` whose archimedean directions are isometries (Berend and Einsiedler–Lindenstrauss need
  expansion), and both competitors stopped there independently. *Reading:* the obstruction is the real place (non-real analogues are pinned on `T + A + Fin`, row 94).""",
"""(rows 91–92). For characters the exclusion is **closed-set** (Furstenberg–Berend) rigidity of the unit-vector action on `R̂`
  with its archimedean directions rotated, and it holds: at two or more primes an orbit closure has archimedean small differences, and meets
  `T + A`, or every difference, and then the band forces a corner — so every band character is torsion plus archimedean (row 95) and HD1
  holds (row 96); at one prime two leaves glue (row 97). *Demotion record:* this entry said "measure rigidity … not in print"; the
  question was about closed sets, where Berend's proof survives with the rotated plane set aside. *Reading:* for all colourings the obstruction is the real place (non-real analogues are pinned on `T + A + Fin`, row 94).""")
rep("""aim at realising a local forcer or at the rigidity theorem, and build no
  non-periodic colouring from finitely many places or measurable windows — excluded by theorem; with two tight places""",
"""aim at realising a local forcer or at colourings no character gives, and build no
  non-periodic colouring from finitely many places, measurable windows or one character — excluded by theorem; when the question is a closed
  invariant set of characters under a rotating group, run Berend's dichotomy with the rotated plane set aside and count the primes first
  (one is not enough); with two tight places""")
rep("holding a third kind of cell (FS-83's first step).*","holding a third kind of cell (FS-83's first step) — **fired at one prime** (row 97: two leaves glue); over every split prime at once the reading holds (row 95).*")
rep("row 80); unentered: commutative algebra, FS-10).","row 80); → topological dynamics and algebraic `ℤ^d`-actions (entered at FS-89: Furstenberg–Berend closed-set rigidity survives a rotated direction at two primes, row 95); unentered: commutative algebra, FS-10).")
rep("the pinning operator §IQ hoped for was neither found nor excluded: **five of five**.","the pinning operator §IQ hoped for was neither found nor excluded: **five of five**. **Sixth (FS-89):** §IQ posed Berend's MT/ID property modulo the isometric direction for every orbit closure, and that property at two or more primes is the result (row 95): **six of six**.")
rep("**Its runs** (FS-73, FS-79, FS-81, FS-85, FS-86;","**Its runs** (FS-73, FS-79, FS-81, FS-85, FS-86, FS-89;")
rep("a verifier checks a fixed statement and cannot supply a missing route (FS-81)","FS-89 ran one derivation agent and blind verifiers, no competition: the second verifier's blind route stalled at the rotated direction and the lemma statements closed it, so blindness bought a re-derivation of every lemma, not a second route; a verifier checks a fixed statement and cannot supply a missing route (FS-81)")
rep("**quote a statement verbatim in a brief**.","**quote a statement verbatim in a brief**. **FS-89's three:** D's corner-check plants could not fire until replaced; the owner's brief carried an advisor's consequence as settled (one prime's `T + A` band set cannot bound the torsion order); and a verifier's blind GAP measured its route, not the claims — a verdict names whose route failed.")
rep("**FS-86's:** Berend 1984 and Einsiedler–Lindenstrauss, which both competitors named as the missing theorem's literature, are unread, and Puzynina (row 85's exception) is not held.",
    "**FS-86's:** Berend 1984 and Einsiedler–Lindenstrauss, named by both competitors, went unread, and Puzynina (row 85's exception) is not held; **FS-89's** gate read `[Berend1984min]` in full, which carried the method, and `[Berend1984]` (TAMS) was saved and read only at the close; 1983 is unheld.")
rep("""*"ban SAT solvers for a week and see what we can do on algebra alone"*; the scope""","""*"ban SAT solvers for a week and see what we can do on algebra alone"*; its intent, *"to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time"*; the scope""")
rep("an agent returning with ~500k–600k tokens of context is replaced, not reused)","an agent returning with ~500k–600k tokens of context, by the harness's count (agents' own run at 55–70 % of it, FS-89), is replaced, not reused)")
open(p,'w',encoding='utf-8').write(s)
print(n0, len(s.encode()), len(s.encode())-n0)
