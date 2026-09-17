> **CLOSED 2026-09-16 — run as FS-56; the record is `plans/FS56-quadratic-167.md`.** Q0 landed (five refused at 23, α ≤ 105), so the prediction χ(ℚ(√167)²) ≥ 6 stands. Q1 (≥ 4) not landed: the milestone's instrument is the fractional blow-up (which also gave χ_f(ℚ(√3,√11)²) = 4), and small pieces of this plane are starved (odd girth 7, 3-colourable balls of 215,409 points). Q1–Q4 continue as FS-58 (`plans/STUB-fractional-four.md`). The text below is the stub as written.

# FS-56 — ℚ(√167): the smallest field the conjecture says needs six colours

*Minted 2026-09-16 at FS-54's close. Kooshi: "Let's close this out and look at 167 next." Written for a session with **zero
conversation memory**: the motivation, every number and where it came from, what is proved and what is only predicted.
Read beside: `CLAUDE.md` G55 (the chain theorem, the unit-vector ring), G56 (the window, the 2-adic trichotomy), G57
(triangles and fields), **G59** (the wall and what the conjecture makes of it); `reference/wall-at-six/WALL-AT-SIX.md` §2;
`plans/FS54-twenty-seven.md` §W; `BIBLIOGRAPHY.md` `[Fischer1990b]` (read in full — it describes this field's unit-vector ring
exactly); `data/fs54/fields.out`.*

---

## 1. What this is about, in plain language

The **plane over a field F** is the graph on the points (x, y) with x, y in F, joining two points at distance exactly 1.
The chromatic number of the real plane is the largest chromatic number over all real number fields F, so each field is a
smaller version of Hadwiger–Nelson. For a field there is an upper bound from its primes: if a prime of F reduces to the
finite field 𝔽_q with q ≡ 3 (mod 4), the plane over F can be coloured with as many colours as the **finite plane** over 𝔽_q
needs (a finite graph, Γ_q). The **local bound L(F)** is the best such bound over all of F's usable primes (primes above 2
included, `CLAUDE.md` G56).

**Our local–global conjecture** says the plane over F needs exactly L(F) colours whenever L(F) ≤ 6, and (its *bold form*)
exactly 7 whenever L(F) ≥ 7. It is proved for L ≤ 3 (every real field), L ≤ 4 (fields containing √3) and L ≤ 5
(multiquadratic fields containing ℚ(√3,√11), given one computer-found gadget) — GPT Astra's hand proofs, G55.

**ℚ(√167) is where that conjecture first says something enormous.** Every small prime that could colour its plane with five
colours or fewer is missing, so its local bound is at least six. The conjecture therefore predicts that the plane over this
*quadratic* field — degree 2, no √3, not a single unit triangle — needs **at least six colours**, and under the bold form
**seven**. The best proven lower bound is **three**. Either the prediction is right, and a real quadratic field carries a
unit-distance graph needing six or seven colours (which would settle χ(ℝ²) ≥ 6, or = 7), or the conjecture fails here, at
its cheapest point.

## 2. Why this field — the derivation, with its evidence

**(a) Its small primes are all unusable** [exact; `data/fs54/fields.out` line 3, re-checked in PARI 2026-09-16].
* **2:** 167 ≡ 7 (mod 8), so −167 is a square in ℚ₂, i ∈ ℚ₂(√167), and every prime above 2 **splits** in F(i): no bound
  from 2 (G56's trichotomy). Equivalently 1/2 lies in the unit-vector ring — `[Fischer1990b]` Theorem 4, N ≡ 7 (mod 8).
* **3, 7, 11, 19:** 167 is a quadratic non-residue modulo each (167 ≡ 2, 6, 2, 15), so the primes above them have residue
  field 𝔽_{p²} ∋ i and are unusable. These are exactly the primes whose finite planes are ≤ 5-colourable (χ = 3, 4, 5, 5).
* **Usable planes below 100:** exactly **23, 43, 59, 67, 71, 79, 83** (plus the ramified 167 and everything past Weil's cap,
  all ≥ 7 colours).

**(b) It is the smallest such field** [derivation + exact]. A real quadratic ℚ(√d) needs d ≡ 7 (mod 8) (otherwise some prime
above 2 is ramified or inert with norm ≤ 4, giving ≤ 2 or ≤ 4 colours), 3 ∤ d and (d/3) = −1, so d ≡ 23 (mod 24): 23, 47, 71,
95, 119, 143, **167**. Then 23 fails at 7 (a residue), 47 at 11, 71 at 7, 95 at 7, 119 = 7·17 and 143 = 11·13 are ramified at
a small prime; 167 passes. The next are ℚ(√887) (usable 23, 31, 67), ℚ(√1055) (31, 43, 47), ℚ(√1319), ℚ(√1823),
**ℚ(√2351)** (47, 67, 71 — decided by 47 alone), 14 below 5,000 (PARI). Among all real number fields: odd degree is
2-colourable (G56), every field of degree 3 or 4 with |disc| ≤ 20,000 fails at 2 (`data/fs54/fields.out`), and degree ≥ 5
with a real place has |disc| ≥ 1,609 > 668 = disc ℚ(√167). **So ℚ(√167) is the smallest-discriminant real number field with
no usable prime giving five colours or fewer.**

**(c) Its local bound is decided by two finite planes** [cert + exact]. L(ℚ(√167)) = min(χ(Γ₂₃), χ(Γ₄₃)) if either is ≤ 6,
and ≥ 7 otherwise.
* χ(Γ₂₃) ∈ [5, 8]: ≤ 8 by a kernel-checked 8-colouring; ≥ 5 by certificate. **The level-3 relaxation already reads
  105.431 < 106** at 3,500 iterations (`data/fs54/d4/ckpt/calib-q23.npz`), so an exact certificate refusing five colours at 23
  is about one CPU-hour away (`tools/fs54_l3_cert_round.py` reads that checkpoint; checker `tools/fs54_l3_cert_check.py`).
  **This is the precondition of the prediction — do it first.**
* χ(Γ₄₃) ∈ [6, 8]: five refused by exact certificate (α ≤ 365 < 370), an 8-colouring verified.
* Six colours at 23 need an independent set of 89; the largest found in ~96,000 restarts is 87. At 43 six need 309; found 258.

**(d) The prediction** [derivation]. Once five is refused at 23: if Γ₂₃ or Γ₄₃ is six-chromatic, L = 6 and the conjecture's
main clause predicts χ(ℚ(√167)²) = 6; if neither is (the wall W, `CLAUDE.md` G59), L ≥ 7 and the bold form predicts 7.
**Either way ≥ 6.** Only the non-bold conjecture together with W predicts nothing here.

**(e) What is proved about this plane** [theorems].
* **χ ≥ 3:** χ(F²) = 2 iff L(F) = 2 for every real field (G55), and L ≠ 2.
* **χ ≤ 7:** the plane's own 7-colouring restricts (row 33).
* **The component of the origin is known exactly** (`[Fischer1990b]` Theorem 5(v), N ≡ 7 mod 8): it is the ring
  R = {(a + bi) + (c + di)√167 : a, b, c, d ∈ ℤ_{S*}}, where ℤ_{S*} allows denominators built from 2, every prime ≡ 1 (mod 4),
  and every prime p ≡ 3 (mod 4) at which 167 is a non-residue — **every prime except the usable ones** (23, 43, 59, 67, 71,
  79, 83, …, and 167). The plane is the disjoint union of translates of R (infinitely many). So the unit-vector ring R is
  as large as the local bound permits: the residue maps at the usable primes are its only obstructions.
* **No additive colouring with fewer than 23 colours** (Fischer's 1/k obstruction, row 50): an additive colouring into a
  group of exponent e needs 1/e ∉ R, i.e. e divisible by a usable prime, so linear methods are useless here.
* **No triangles, no Moser spindle** (G57): √3 ∉ F, so ω = 2; the spindle needs √3 and √11.

**(f) Unit vectors, and the construction vocabulary that exists** [exact].
* Reduced unit vectors are ξ = (a + bi)(x + y√167·i)/c with (a² + b²)(x² + 167y²) = c² (`[Fischer1990b]` Lemma 2).
* **ρ₄₂ = (83 + i√167)/84** is a unit vector (83² + 167 = 84²): the type-M rotation with n = 42 of `CLAUDE.md` G7
  (cos θ = (2n−1)/(2n), radicand 4n − 1 = 167). Rational (Pythagorean) unit vectors are all present.
* **The chain theorem makes this field easy to close** (G55): if a finite unit-distance graph over F forces two points at
  difference δ to share a colour in every k-colouring, every k-colouring of F² is periodic under δR, and if 1/δ ∈ R the
  plane is not k-colourable. Here R contains 1/p for every non-usable prime p, so **a single forced pair at k colours, at
  any distance δ whose norm involves no usable prime, proves χ(ℚ(√167)²) > k.** The whole lower-bound question at each
  level is: does a finite k-colour forcer exist over this field?

## 3. The questions, cheapest first

* **Q0 — the precondition.** The exact five-refusal certificate at 23 from the existing checkpoint (≈ 1 CPU-hour), re-run
  by the PO. If the exact N is ≥ 106, χ(Γ₂₃) = 5 stays possible, L(ℚ(√167)) could be 5, and the prediction weakens to "≥ 5".
* **Q1 — is χ(ℚ(√167)²) ≥ 4?** No quadratic field without a small usable prime is known to need four colours (check at the
  prior-art gate). Route: a **three-colour forced pair** in a finite unit-distance graph over R at an R-invertible distance
  (chain theorem). Instrument: grow finite graphs inside R from small unit vectors (ρ₄₂, Pythagorean, Lemma 2 families),
  decide 3-colourability and pair compulsions by SAT with symmetry breaking (`CLAUDE.md` § Toolchain checklist). A
  triangle-free 4-chromatic unit-distance graph over a quadratic field is probably new — the gate decides.
* **Q2 — the same at 4 and 5 colours**, which the conjecture also predicts (≥ 5 needs a 4-colour forcer, ≥ 6 a 5-colour one).
  Each level is the chain theorem plus one finite forcer.
* **Q3 — the falsifier's side.** What could 6-colour ℚ(√167)²? Residue colourings cannot (every usable plane is ≥ 6);
  additive colourings need ≥ 23; a composite target Γ₂₃ × Γ₄₃ can only if a factor has an integrality gap (χ_f ≤ 6 < χ,
  `CLAUDE.md` G43/G59); tower levels keep Hoffman's floor (4.01 at 23, 4.68 at 43) but not the certificates. A six-colouring
  would have to be of a kind this project has never seen — which is what makes the prediction bold.
* **Q4 — growth measurements, as evidence only.** The chromatic number of the unit-distance graph on growing finite pieces of
  R (by radius, by denominator height): where does it reach 3, 4, …? A plateau at 3 over large pieces is evidence against the
  conjecture here, never a refutation: a finite piece can stay colourable long after the whole plane is not (G21).

## 4. Prior-art gate (WORKFLOW 3a) — questions to search, in the discipline's words

* Chromatic number of the rational plane extended by one square root: Johnson 1987 (`[Johnson1987]`, two-colourings of real
  quadratic extensions), Fischer 1990 (additive colourings; Thm 8), Madore 2015, `[AxenovichEtAl2014]`, Soifer's Open
  Problem 11.6 (`[Soifer2024]`, Benda–Perles: χ of ℚ(√2)² "and, in general, of any algebraic extension"), `[Johnson2006]`
  (the compendium, still not held — the one place a quadratic-field value could hide).
* Triangle-free unit-distance graphs with χ ≥ 4 (Wormald 1979, O'Donnell 1999/2000) — which fields do their coordinates need?
* Forcing / uniquely colourable unit-distance graphs without triangles.

## 5. Registered expectations to decide at the subplan (candidates, not yet registered)

* Q0 certifies (the float reading has 0.57 of margin; the certificate-shaped value sits 0.10–0.19 % above the reading).
* Q1: small pieces of R are 3-colourable; a three-colour forcer, if it exists, needs a rotation of infinite order such as
  ρ₄₂ and more than a few hundred vertices.
* State both reachable outcomes of each before running (`CLAUDE.md` § The gate, "confirm BOTH outcomes are reachable").

## 6. Failure and jackpot clauses

* **Jackpot:** a finite unit-distance graph over ℚ(√167) that is not five-colourable proves χ(ℝ²) ≥ 6 — in a quadratic
  field, where nobody has looked. A three-colour forcer alone (χ ≥ 4) is probably already a first for a field with no small prime (the gate decides).
* **Informative failure:** large pieces of R stay 3-colourable with no three-colour compulsions — evidence that the
  conjecture's clauses above five (and possibly above three) fail at fields with no small prime, i.e. that local–global gaps
  exist exactly where the residue method runs out. That would re-scope G48's conjecture and the wall document's §2.
* **Not a failure:** Q0 failing. It moves 23 back into play as a five-colourable candidate, and ℚ(√167) then waits on 23.

## 7. What this is not

Not a search for six-chromatic finite planes (that is FS-57, the wall). Not a claim that ℚ(√167)² needs six colours — that
is the conjecture's prediction, recorded with its dependency on Q0 and the conjecture's two clauses.
