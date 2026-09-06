# The finite-plane bound — verified (de Bruijn, 2026-09-06, on Kooshi's "check the new files")

The four files beside this note came from Kooshi's web-Claude session (`analysis.txt` the argument, `fplane.py` its DSATUR
solver, `d11_five_colouring.txt` the 5-colouring of F₁₁², `usable.py` the prime sieve). Everything below was re-derived or
re-measured here with this repository's own code (`tools/fplane.py`, `self-test` green) before being believed.

## 1. The theorem, checked by hand

*F ⊂ ℝ a number field, p ≡ 3 (mod 4), 𝔭 a prime of F above p with residue field F_p. Then every finite unit-distance graph
in F² maps homomorphically to UD(F_p, 2) = Cay(F_p², {(a, b) : a² + b² = 1}), so χ(F²) ≤ χ(UD(F_p, 2)).*

Proof, as I re-ran it: 𝔭 is odd so it is unramified in F(i) (the discriminant of x² + 1 is −4); it splits iff −1 is a
square in F_p, and for p ≡ 3 (mod 4) it is not, so 𝔭 is inert with residue field F_p(√−1) ≅ F_{p²}; complex conjugation is
the nontrivial automorphism of F(i)/F, fixes the unique prime 𝔓 above 𝔭, and reduces to Frobenius. A unit vector z has
z z̄ = 1, so v_𝔓(z) = v_𝔓(z̄) = 0 and z is 𝔓-integral; translating a component so one vertex is 0 makes every vertex a sum of
unit vectors, hence 𝔓-integral; reduce. For adjacent vertices the difference is a unit vector whose residue r satisfies
r · r^p = 1, i.e. N(r) = a² + b² = 1 with r = a + b√−1 — a point of the circle, nonzero. So the residue map is a graph
homomorphism into the Cayley graph. ∎ Odd residue degree f: the same with F_{p^f} (p^f ≡ 3 mod 4). The additive
method (Theorem B, Fischer) coloured F_p² by a LINE missing the circle (p colours — G38's "next values 7, 11"); the
plane's own chromatic number is what enters here, and it is not linear.

## 2. Measured here (independent solver: pysat/cadical, one-hot, two pins; every colouring verified proper)

| claim | measurement |
|---|---|
| the file's 5-colouring of F₁₁² is proper | 0 monochromatic pairs over all 121 × 12 / 2 circle differences |
| χ(UD(F₁₁, 2)) = 5 | k = 4 UNSAT (0.0 s), k = 5 SAT verified (0.1 s); `data/fplane/chi-p11.json` |
| controls | χ(UD(F₃,2)) = 3, χ(UD(F₇,2)) = 4 (Vinh 2005's computer value), χ(UD(F₁₃,2)) = 5 (p ≡ 1 mod 4: not usable, part of the map) |
| the circle has p + 1 points for p ≡ 3 (mod 4) | 12 at p = 11 |
| Heule-510 reduces into UD(F₁₁,2) | √3 ↦ 5, √5 ↦ 4, √11 ↦ 0: 510 points onto all 121 residues, **2,504 of 2,504 edges on the circle**, the pulled-back colouring PROPER (χ(Heule-510) ≤ 5 by pullback — and Heule-510 is 5-chromatic, so χ(UD(F₁₁,2)) ≥ 5 needs no solver) |
| W (the T20 witness, K(√247)) reduces | √3 ↦ 5, √11 ↦ 0, √247 ↦ 4: 1,175 points onto all 121, **5,773 of 5,773** on the circle, pullback proper |
| the E–I seed's unit part (K) reduces | 214 points onto 51 residues, **1,004 of 1,004**, pullback proper; the pullback puts 97 of 446 cheats and the forced pair on one colour |
| planted red | a wrong residue for √3 (4, not a square root of 3 mod 11) breaks the homomorphism on Heule-510 |
| the sieve | usable primes below 600 — K: 11, 83, 107, 131, 167, 227; Heule's Q(√3,√5,√11): 11, 131, 239, …; **de Grey's Q(√3,√5,√7,√11): 131, 479 (none below 131)**; K(√247): 11, …; K(√5,√247): 11, …; K(√35): 107, 131, …; K(√5): 11, …; K(√7): 83, 131, … |
| de Grey's 1581 carries √7 | 8,092 nonzero √7-coefficients — the 11-bound does not reach it |

## 3. Corollaries (mine, from the verified pieces)

* **χ(Q(√3, √5, √11)²) = 5 exactly** — Heule-510 (kernel-certified 5-chromatic, M06–M09 lineage) below, UD(F₁₁,2)'s
  5-colouring pulled back above. The first exact chromatic number of a wall-broken plane; it closes §8 of the field-wall
  note. Likewise **χ(K(√247)²) = 5** (W is 5-chromatic there) and χ(K(√5)²) = χ(K(√5,√247)²) ≤ 5.
* **No 6-chromatic unit-distance graph has all its coordinates in a field with a degree-one prime above 11** — K, K(√5),
  K(√247), K(√5, √247), Heule's field: every object the descent (M49–M53), the copy-lock family (M52), the T20 witness
  and the F₂₄₇ thickening (M54–M57) live in a field where 6 is impossible. FS-3 and FS-6-in-F₂₄₇ are dead as routes to 6.
* De Grey's field has no usable prime below 131 (√7 makes 11 inert: 7 is not a square mod 11); K(√7) has 83 first,
  K(√35) has 107 first. Whether those planes refuse five colours decides whether the theorem bounds those fields:
  UD(F₈₃,2), UD(F₁₀₇,2), UD(F₁₃₁,2) at k = 5 are running (`build/m57/fplane-big.log`); Vinh's lower bound √p/2 ≈ 4.6,
  5.2, 5.7 says nothing decisive.
* The Haugland check (his heptagonal field has a degree-one prime above 7 unless the detuning adjoins a 7-inert
  radical, and χ(UD(F₇,2)) = 4) needs his coordinates; not done.

## 4. Literature (the novelty claim is PROVISIONAL)

Vinh 2005 (arXiv math/0510092, full text read for this question) has the plane and its asymptotic bounds, computes only
χ(UD(F₇,2)) = 4, and says nothing about number fields, reduction, or the plane's chromatic number. Mohar's problem page:
nothing. The library's number-field papers (Manturov 2012 — residue-class colourings, i.e. linear; Brouwer–Joe–Noble
2023 — odd cycles in ℤ_mⁿ; Zapletal; Noble; Currie; Payne): no finite-plane bound. Not checked: Soifer 2024 (held,
unread), the Springer 2022 clique-number paper (paywalled), and the web session's own bibliography beyond Vinh (its
✓/~ marks are its own). "χ(UD(F₁₁,2)) = 5 looks unrecorded" stands as the web session's reading, not confirmed by a
search of the literature.

## 5. What is and is not certified

The reduction argument is a hand proof (§1). The homomorphism for a SPECIFIC stage is an exact finite check
(`reduce`, a certificate for that stage); the pulled-back colouring is a verified colouring (a certificate of ≤ k for
that stage). "χ(UD(F₁₁,2)) ≥ 5" is the solver's UNSAT until certified — or, better, it follows from Heule-510's
kernel-certified 5-chromaticity plus the verified homomorphism, with no solver at all. A kernel statement of
χ(Q(√3,√5,√11)²) = 5 would need: the reduction as a theorem over the field's exact arithmetic, the 121-point colouring as a
`decide`, and the homomorphism from the certified 510 — priced, not done.
