# FS-15 — The local–global tightness conjecture: is the chromatic number of a field plane its best local bound? (STUB, 2026-09-07; minted on Kooshi's direction after the M59 close)

*A derivation stub. It is written to be read cold: every term is defined where it first appears. Read beside, when
you want the evidence in full: `plans/FIELD-WALL-THEOREM.md` (the 2-adic wall), `plans/M58-field-sieve.md` §S1–§S2 and §R
(the finite-plane bound and the spectra), `plans/M59-finite-plane-lift.md` §S1 and §R (why finite-plane objects do not lift),
`plans/PROGRAMME-ALGEBRAIC-PROOF.md` (the aim this stub serves), `plans/STUB-five-colour-residue-obstruction.md` (FS-14, the
conjecture's first compulsion-level instance).*

## 1. The setting, in plain language

The Hadwiger–Nelson problem asks how many colours the real plane needs so that no two points at distance exactly one share a
colour. The answer is 5, 6 or 7. A compactness theorem of de Bruijn and Erdős says the answer is the largest chromatic number
of any FINITE unit-distance graph, and every finite graph has coordinates in some number field F (a finite extension of the
rationals inside the reals). So the problem is the same as: over all real number fields F, what is the largest chromatic
number χ(F²) of the unit-distance graph whose vertices are the points of F² with coordinates in F?

Everything this project has proved about χ(F²) from above is LOCAL: it uses the arithmetic of F at ONE prime number p.

* **At p = 2 (the field-wall theorem, M53).** If −1 is not a square in any completion of F at a prime above 2, colour each
  point by its residue modulo a suitable prime of F(i): four colours (or two), proper on every unit edge. So χ(F²) ≤ 4. For the
  seam field K = ℚ(√3, √11) the bound is exactly attained: the Moser spindle needs four and lives in K.
* **At p = 3 (Fischer).** If some prime of F above 3 has residue field 𝔽₃, three colours suffice. Attained by a unit triangle
  over ℚ(√3).
* **At any prime p ≡ 3 (mod 4) where F has a prime 𝔭 of residue field 𝔽_p (the finite-plane bound, M58).** Reducing
  coordinates modulo 𝔭 sends every unit-distance graph over F homomorphically into the finite Euclidean plane UD(𝔽_p, 2) —
  the graph on the p² points of 𝔽_p² joining two points when their difference has x² + y² = 1 — so χ(F²) ≤ χ(UD(𝔽_p, 2)).
  Such a p is called **usable** for F. The finite planes' chromatic numbers are known exactly at 3, 7, 11 (values 3, 4, 5, the
  last in the kernel) and 19 (value 5), are at least 6 from p = 59 on (their spectra are Kloosterman sums; Hoffman's bound),
  and are at least 7 from p ≈ 100 on.

Call the smallest of these numbers, over all the usable primes of F together with the walls at 2 and 3, the **local bound**
L(F). The one bound that is not local is the classical hexagonal 7-colouring of the real plane, which restricts to every F² at
once, so χ(F²) ≤ min(7, L(F)) for every F.

A field is **sealed at k** when L(F) ≤ k: no unit-distance graph over it can need more than k colours. A field is **6-open**
when L(F) ≥ 6 and the 2-adic wall is broken — the only fields where a 6-chromatic unit-distance graph could live. For fields
containing K this is a congruence: 6-open iff the wall is broken and 11 is inert (M58's theorem).

## 2. What is known about tightness, exactly

At every field where χ(F²) is known exactly, it EQUALS the local bound:

| field F | local bound L(F), from | χ(F²) | attained by |
|---|---|---|---|
| ℚ | 2 (p = 2) | 2 | a unit edge (Woodall) |
| ℚ(√3) | 3 (p = 3) | 3 | a unit triangle |
| K = ℚ(√3, √11) | 4 (p = 2) | 4 | the Moser spindle (Theorem B for ≤) |
| ℚ(√3, √5, √11), Heule's field | 5 (p = 11) | 5 | Heule-510 (both halves in the kernel, M58) |
| K(√247) | 5 (p = 11) | 5 | the T20 witness, 1,175 points (M53) |
| K(√23) | 5 (p = 11) | 5 | the second T20 witness (M53) |

The last two rows are not a selection effect: the field-wall analysis PREDICTED that a 5-forcer needs the 2-adic wall broken,
and the rigidity dial then found forcers in exactly the fields it named (√247 read off the forced distances of K-fabric, §M53
T20). The conjecture below is the statement that this is what always happens.

At the next level nothing is known. De Grey's field ℚ(√3, √5, √7, √11) has L = 8 (its first usable prime is 131, whose plane is
at least 8-chromatic), so the cap gives χ ≤ 7 and the truth is 5, 6 or 7. K(√7) has L ≥ 6 (first usable prime 83, plane ≥ 6);
K(√13), K(√79), K(√127) likewise.

## 3. The conjecture

> **Local–global tightness (T1, the working form).** For every real number field F with L(F) ≤ 6, χ(F²) = L(F): the best local
> bound is attained by a finite unit-distance graph over F.
>
> **The bold form (T2).** For every real number field F, χ(F²) = min(7, L(F)).

T1 is where the evidence is (six fields, two of them predicted before they were built). T2 adds the claim that a field with
no small usable prime is 7-chromatic — which, since de Grey's field has L = 8, is equivalent to **χ(ℝ²) = 7**. T2 is stated
so that it can be pushed back on; it is not believed here, only named: it is exactly what "the local bounds are the whole
truth" would mean, and de Grey's field is its test.

**Why it is the right conjecture to hold.** It says the chromatic number of a field plane is a function of the field's
arithmetic at small primes — the "intrinsic nature" the programme document names — and it turns two open questions into one:

* **The lower bound becomes a target computation.** If T1 holds and some finite plane UD(𝔽_p, 2) has chromatic number EXACTLY 6,
  then every field whose local bound is that plane's (p usable, every smaller usable prime's plane ≥ 6, the wall broken) hosts a
  6-chromatic unit-distance graph — a target field named by congruences, as √247 was named by a forced distance. The first
  digit is therefore: **is any finite Euclidean plane exactly 6-chromatic?** Candidates: 23, 31, 43, 47 (spectral floors
  4.0–4.7, values 5 or 6, undecided at four solver-hours), 59 (floor 5.02, value 6 or 7), 67, 79, 83 (floors 5.5–5.7). If none
  is, T1 says no field is exactly 6-chromatic: the answer to Hadwiger–Nelson is 5 or 7, never 6.
* **The upper bound becomes a gluing question.** Every local colouring is one colouring of one F² at one prime; the hexagonal
  colouring is one colouring of ℝ² that restricts to every F². T2 says nothing global with six colours exists. The obstruction
  to gluing local colourings into a global one is the object the upper-bound side of the programme has to name (§4 (c)).

## 4. Derivations first

**(a) The local bound, stated in full.** L(F) as written above takes primes of residue degree one; M58's argument works at
odd residue degree f, into the plane over 𝔽_{p^f} — whose chromatic numbers are unknown and worth a table — and at ramified
primes for the UPPER bound only (M59: the lift needs unramified). Write L(F) as the minimum over every place where a residue
colouring exists, and prove that every colouring obtained this way is "local at one prime" in a precise sense (constant on
residue classes of that prime).

**(b) The compulsion-level face.** Over a field sealed at k by a prime p, every pair of points forced equal (or forced
distinct) at k colours has residues forced the same way in UD(𝔽_p, 2). This is FS-14 at p = 11, k = 5; T17 is its p = 2,
k = 4 case (already a theorem). Proving it in general is the first theorem of this stub and is cheap (a homomorphism argument).

**(c) Why forcers attain the bound — the mechanism of tightness.** In every attained case the forcer's field is the SMALLEST
field breaking the wall the bound came from: the spindle's twist is the least adjunction that turns off 3 (it lives in K, and
K is 3-adically closed to residue colourings); the 5-forcers' √5 or √7 is the least adjunction turning off 2. Derive the
general statement: a forcer at k + 1 colours is K-fabric plus the least adjunction that removes the prime giving L = k (G37's
"adjoin a root that turns off the next wall", made exact). If the derivation goes through, T1 at the 6-level says which
adjunction to make — the one that turns off 11 while keeping the wall broken — and predicts the forcer's field.

**(d) The gluing obstruction (the upper-bound side).** Two colourings of F² and F'² local at different primes never agree on
F² ∩ F'² in general; ask what invariant of a colouring of a field plane says whether it is the restriction of a colouring of a
larger field's plane. A colouring local at 𝔭 is constant on 𝔭-adic balls of radius 1/p; a colouring of ℝ² restricted to F²
is constant on nothing of the kind. Derive: no colouring of ℝ² with k < 7 colours restricts to a 𝔭-local colouring on any
field (probably easy), and — the real question — whether some measurable/topological invariant of colourings of ℝ² is
forced to vanish on every local colouring. If T2 is true the invariant exists; if a global 6-colouring exists it does not.

## 5. Phases

| phase | what | cost |
|---|---|---|
| 0 | (b) in the kernel in general form (the transfer of compulsions along the reduction); (a) the table of L(F) for the fields held, with the odd-degree planes' floors | 2 days |
| A | the first digit: the exact chromatic numbers of the planes at 23, 31, 43, 47, 59 — by cube-and-conquer over a neighbourhood's colourings (FS-13's D1) or by the exact count of colourings via the torus structure; the first plane with value exactly 6, if any, and the fields it names | days to weeks |
| B | (c): the mechanism of tightness as a derivation on the six attained fields; a design principle for the 6-level, tested on the fields (A) names | weeks |
| C | (d): the gluing obstruction, derivation only | open |

## 6. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | the planes at 23, 31, 43, 47 are 5-chromatic; 59 is 6-chromatic; 67, 79, 83 are 6-chromatic | low-medium (Hoffman is loose at small p: 1.5 above the truth at 11 and 19) |
| P2 | (b) is a theorem in general form within a day, and every one of the seed's 148 absolute virtual edges at distances 3 and 4 has residues that every 5-colouring of UD(𝔽₁₁,2) separates | medium-high |
| P3 | T1 fails nowhere among the fields held; its first genuine test is a field whose local bound is 6 | — (this is the conjecture) |

## 7. Failure and pivot clauses

A field with L(F) = 5 and a proof that χ(F²) ≤ 4 (a colouring of some 5-sealed, wall-broken field with four colours that is
NOT local at any prime) refutes T1 below the 6-level and would be a new colouring genre — record it as the finding, it is
larger than the conjecture. A finite plane with chromatic number exactly 6 turns phase B into the hunt's target: HALT and
design in the named field. No plane exactly 6 among those decided: record, and T1's prediction "never 6" becomes the
programme's stated position on the answer.

## 8. Bearing on 6, honestly

High as a FRAME, medium as work: it reorganizes both halves of the problem around one computable quantity, its first digit
(phase A) is exactly the solver question M58 left undecided, and its mechanism half (c) is the derivation the programme asked
for after the lower bound. It produces no object by itself.

## 9. Addresses

`tools/fplane.py` (`chi`, `spectral`, `map`, `usable`), `data/fplane/`, `Proofs/HadwigerNelson/UnitQuadrance.lean`
(`unitQuadrance.map`, the reduction as a functor), `Instances/FinitePlane11.lean`, `plans/STUB-five-colour-residue-obstruction.md`,
`plans/STUB-finite-plane-cores.md`, `plans/FIELD-WALL-THEOREM.md`.
