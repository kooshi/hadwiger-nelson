# The wall at six

## Finite "unit-circle" graphs appear never to need exactly six colours, so no number field has a residue bound of six. We are looking for the theorem.

*A request for help, written to be read cold. From a Hadwiger–Nelson research workspace (Lean 4 formal proofs plus exact
computation), September 2026. Every number below comes from a stored artifact; trust levels are marked on every claim
(legend in §0.2). Nothing here is published.*

---

## 0. Summary

### 0.1 The question in one page

**Hadwiger–Nelson.** The chromatic number of the plane — the least number of colours for ℝ² such that no two points at
distance exactly 1 share a colour — is known to be 5, 6 or 7 (the lower bound 5 is de Grey, 2018).

**A classical reduction to finite graphs.** By de Bruijn–Erdős compactness and a specialisation argument, χ(ℝ²) is the
supremum of χ(F²) over **real number fields** F (the plane over F: points of F², edges at squared distance 1). For a
number field there is a clean *upper* bound coming from its primes (§1.3; Moorhouse, Manturov, Madore): if a prime of F
has residue field 𝔽_q with q ≡ 3 (mod 4), then

  **χ(F²) ≤ χ(Γ_q)**,  where  **Γ_q := Cay(𝔽_{q²}, μ_{q+1})**

is the Cayley graph of the additive group of 𝔽_{q²} whose connection set is the group of (q+1)-st roots of unity. Γ_q is
exactly the **finite Euclidean plane** over 𝔽_q: points (x, y) ∈ 𝔽_q², adjacent when (Δx)² + (Δy)² = 1. The primes above 2
give a third family of targets, Cay(𝔽_{Q²}, μ_{Q+1}) with Q a power of 2, or else a bound of 2 (§1.4).

**The wall.** Put together, the chromatic numbers of all these target graphs appear to **skip 6**:

| target | χ, in order of size |
|---|---|
| Γ_q, q = 3, 7, 11, 19 | **3, 4, 5, 5** (upper bounds by explicit colourings; lower bounds proved at 3 and 11, a solver's refusal at 7 and 19) |
| Γ_q, q = 23, 31 | ≥ 5 proved; the largest independent sets found would force ≥ 7 if they were maximum |
| Γ_q, q = 27, 43, 47 | ≥ 6 by exact certificate; the largest independent sets found would force ≥ 7 if they were maximum |
| Γ_q, every other usable q | **≥ 7**, proved (exact certificates at 59, 67, 79, 83; exact spectrum at 71; Weil's bound from 98 on) |
| 2-adic targets, Q = 2, 4, 8, 16, 32 | **4** (explicit colourings; lower bounds by Hoffman, and at Q = 4 a solver's refusal) |
| 2-adic target, Q = 64 | 6 ≤ χ ≤ 8, open |
| 2-adic targets, Q ≥ 128 | **≥ 7**, proved (≥ 8 at 128, Weil's bound beyond) |

**No target is known to be six-chromatic, and the evidence at every undecided one argues against it.** If the wall is real,
then **no number field has a residue bound of exactly 6**: every field's bound is ≤ 5 or ≥ 7. We have a local–global
conjecture, χ(F²) = L(F), proved for bounds up to 3 (all real fields), 4 (fields containing √3) and 5 (a large family).
**Its bold form alone already gives χ(ℝ²) = 7**, through a field whose bound is ≥ 7 (§1.5), and it does not need W.
**What W adds is that six would be a value no number field attains**: under the conjecture every χ(F²) would lie in
{2, 3, 4, 5, 7}.

**What we have is a pattern, proofs at both ends, six open cases in the middle, and no explanation.** We would like the
theorem — or the counterexample.

**The sharpest form of the question** (from the first response, §0.3). For a vertex-transitive graph the fractional
chromatic number is χ_f = |V|/α, and χ ≥ ⌈χ_f⌉. So **α(U_Q) < Q²/6 at the six open targets would prove W outright**, with
no appeal to any rounding heuristic. Because the fractional chromatic number of a categorical product is the minimum over its
factors, the same inequality would also rule out six for every composite residue target built from them (§6.3).

### 0.2 Trust levels used below

| tag | meaning |
|---|---|
| **[proof]** | a hand proof given or sketched here, or a standard theorem |
| **[kernel]** | checked by the Lean 4 kernel on the three standard axioms |
| **[exact]** | exact integer/rational computation, reproducible from q alone |
| **[cert]** | an exact rational semidefinite certificate, re-checked by a standalone exact checker (§B) |
| **[solver]** | a SAT solver's refusal — untrusted; stated with its budget |
| **[found]** | an explicit object (independent set, colouring) verified from the definition by an independent script. A *found* independent set proves a lower bound on α and nothing else |
| **[null]** | a search that did not find something at a stated budget — evidence, never a refusal |

### 0.3 Responses received

The first version of this document went out on 2026-09-16. Two responses came back the same day, and this version
incorporates them. Both are kept verbatim beside this file in `responses/`. **Credit:** GPT Astra (OpenAI, via the workspace's
owner); the first response was written under the Poros review procedure.

| response | what it established | how we checked it | where it changed this text |
|---|---|---|---|
| **The fractional wall** | For vertex-transitive graphs, χ_f = \|V\|/α. Zhang's theorem on independence ratios of direct products (and Zhu's fractional Hedetniemi theorem) gives χ_f(G × H) = min(χ_f(G), χ_f(H)). So a composite target escapes W only through an **integrality gap**, a factor with χ_f ≤ 6 < χ. It also found **five errors in the first version**: the six-window's upper edge used a rounding heuristic without saying so; Hedetniemi's status was out of date; one sentence about q = 67 was wrong; the field-side consequence of a six-chromatic graph was overstated; and a slackness claim was unproved | theorem statements checked against the papers (§C); the five errors confirmed against our own records | §0.1, §2, §3.2, §5.1, §6.3, §7.3, §8 |
| **Algebraic mechanisms** | (i) Two unit vectors are determined by their sum: u + v = d, uv = d/d̄. In characteristic 2 the unit circle is therefore a Sidon set, with an exact common-neighbour formula; U_{2^m} is triangle-free iff m is even. (ii) **U₃₂: every maximum independent set is an 𝔽₄-hyperplane**: 44 of them, and 11 four-colourings up to colour names. (iii) λ ≡ 1 (mod 4) at Q = 64, so every binary codimension-2 subspace contains ≥ 5 unit vectors, which is why linear four-colourings stop at 64. (iv) **In an inert prime-power tower, λ_min and the degree both scale by Q^{j−1}**, so the Hoffman bound is constant up the tower. (v) A field containing √3 cannot reach U₆₄ | every proof read line by line; every finite instance recomputed by independent code (a different field polynomial, characters via a trace mask, tower levels over (ℤ/p^j)² and GR(9,3)) — `tools/fs54_wall_feedback_verify.py`, output in `data/fs54/wall-feedback/`; the response's own script reproduces | §1.2, §1.4, §4.4, §6.3, §7.1, §8 |

---

## 1. The setting

### 1.1 The plane over a field

For a field F ⊂ ℝ let G(F) be the graph on F² with (x, y) ~ (x′, y′) iff (x − x′)² + (y − y′)² = 1. Then:

* **χ(ℝ²) = sup_F χ(G(F))** over real number fields. [proof, standard] A finite unit-distance graph in ℝ² has a realisation
  with coordinates in a real number field, because real algebraic points are dense in the real points of a variety
  defined over ℚ. Adding the de Bruijn–Erdős theorem gives the equality.
* It is convenient to identify F² with F(i) ⊂ ℂ: then (x, y) ↦ z = x + iy, and the unit vectors are the z with z·z̄ = 1.

**Values known over fields** (all prior art unless marked): χ(ℚ²) = 2 (Woodall); χ(ℚ(√3)²) = 3; χ(ℚ(√3,√11)²) = 4
[kernel, ours]; χ(ℚ(√3,√5,√11)²) = 5, the field of Heule's 5-chromatic graphs, where the residue bound at 11 is tight.
Five-chromatic unit-distance graphs are known in ℚ(√3,√5,√7,√11) (de Grey), ℚ(√3,√5,√11) (Heule) and ℚ(√3,√7,√11)
[found, ours: one 51,133-vertex object, solver-certified, not kernel-checked].

### 1.2 The target graphs

For a prime power Q write

  **U_Q := Cay( (𝔽_{Q²}, +), μ_{Q+1} )**,  μ_{Q+1} = { u : u^{Q+1} = 1 } = the kernel of the norm 𝔽_{Q²}^× → 𝔽_Q^×.

* **For Q = q ≡ 3 (mod 4)** — equivalently q = p^f with p ≡ 3 (mod 4) and f odd — −1 is a non-square in 𝔽_q, so
  𝔽_{q²} = 𝔽_q(i), z = x + iy has norm x² + y², and **U_q = Γ_q = the finite Euclidean plane UD(𝔽_q, 2)** — q² vertices,
  (q+1)-regular. We write 𝒬 = {3, 7, 11, 19, 23, 27, 31, 43, 47, 59, 67, 71, 79, 83, 103, …}. **27 = 3³ is the only element
  of 𝒬 below 98 that is not prime**: 25 and 49 fail (5 ≡ 1 mod 4; even exponent), and the next are 243 and 343.
* **For Q = 2^m**, U_Q is the target of an inert prime above 2 (§1.4).

**Standard facts** (all [proof]):
* U_Q is vertex- and arc-transitive; Aut(U_Q) contains 𝔽_{Q²} ⋊ (μ_{Q+1} ⋊ Gal(𝔽_{Q²}/𝔽_p)), of order Q²(Q+1)·2f.
  **At 27, nauty computes |Aut(Γ₂₇)| = 122,472 = 27²·28·6 exactly** [exact], so there is nothing beyond this group.
* **Spectrum.** The eigenvalue at the additive character ψ_a is λ_a = Σ_{u∈μ_{Q+1}} ψ(Tr(a u)). For a ≠ 0 it is (up to sign)
  a Kloosterman sum over 𝔽_Q, so **|λ_a| ≤ 2√Q** (Weil).
* **Hoffman's ratio bound**: α(U_Q) ≤ Q²·|λ_min| / (Q + 1 + |λ_min|), hence χ(U_Q) ≥ 1 + (Q+1)/|λ_min| ≥ 1 + (Q+1)/(2√Q).
  **Weil therefore gives χ ≥ 6 for Q ≥ 63 and χ ≥ 7 for Q ≥ 98.** On these graphs the Lovász ϑ equals the Hoffman bound
  (measured in floating point for every q ∈ 𝒬 below 84 — a reading, not a certificate).
* **Clique number** (Krebs 2022): ω(Γ_q) = 3 if q is a power of 3 or 3 is a square in 𝔽_q, and 2 otherwise.
* **Colour-class necessity**: a k-colouring needs α ≥ ⌈Q²/k⌉. So **α < Q²/6 refuses six colours**, and α < Q²/5 refuses
  five.
* **Fractional chromatic number.** Because U_Q is vertex-transitive, χ_f(U_Q) = Q²/α(U_Q), and always χ ≥ ⌈χ_f⌉. The
  colour-class necessity above is exactly this inequality. The converse "rounding" χ = ⌈χ_f⌉ is **not** a theorem. We use
  it only as a labelled reading: it holds at q = 3, 7 and 11, and it is consistent with the bounds at 19.
* **Two unit vectors are determined by their sum** [proof; second response, §0.3]. If u, v ∈ μ_{Q+1} and u + v = d ≠ 0,
  then uv = d/d̄, because conjugation inverts units. So {u, v} is the root set of X² − dX + d/d̄, and two distinct vertices
  have at most two common neighbours. That is the finite form of "two unit circles meet in at most two points".
  * In characteristic 2 this makes μ_{Q+1} a Sidon set, with an exact count: |μ ∩ (d + μ)| = 2 when
    Tr_{𝔽_Q/𝔽₂}(1/N(d)) = 1, and 0 otherwise.
  * Hence U_{2^m} is **triangle-free when m is even**. When m is odd, every edge lies in exactly one K₄, a coset x + u𝔽₄.
  * In characteristic 3, with d itself a unit, the polynomial is (X + d)². That is why every edge of Γ₂₇ lies in exactly one
    triangle, and why that triangle is a straight line (§7.1).

### 1.3 The residue bound at odd primes

**Theorem** (Moorhouse 2010, Manturov 2012, Madore 2015). *Let F be a real number field and 𝔭 a prime of F with residue
field 𝔽_q, q ≡ 3 (mod 4). Then χ(F²) ≤ χ(Γ_q).*

*Proof sketch* [proof]. Let v be the valuation of 𝔭. If x² + y² = 1 and min(v(x), v(y)) = −m < 0, say v(y) = −m, then
(x/y)² ≡ −1 (mod 𝔭), which is impossible because −1 is not a square in 𝔽_q. So every unit vector lies in O_𝔭². Let A be the
additive group the unit vectors generate, and ρ : A → 𝔽_q² reduction. ρ sends a unit vector to a unit vector, in particular
to a nonzero vector. G(F) is a disjoint union of copies of Cay(A, unit vectors), one per coset x + A. Colour x + a by
c(ρ(a)) for a proper colouring c of Γ_q. ∎

In the language of F(i): a prime 𝔭 with q ≡ 3 (mod 4) is inert in F(i), its prime 𝔓 is fixed by complex conjugation, the
residue field is 𝔽_{q²}, conjugation acts as the Frobenius z ↦ z^q, and unit vectors reduce into μ_{q+1}. **A prime with
q ≡ 1 (mod 4), or with even residue degree, splits in F(i) and gives no bound**, which is why only 𝒬 appears.

### 1.4 The residue bound at 2 — three cases

Let 𝔭 be a prime of F above 2 and look at it in F(i)/F. [proof, each case in one line; this classification is ours, the
two-colour mechanism is Woodall's and Fischer's]

| 𝔭 in F(i)/F | what the unit vectors reduce to | bound |
|---|---|---|
| **splits** | 𝔓 is not fixed by conjugation; no reduction is available | none |
| **ramified** | conjugation acts trivially on the residue field k, so w̄ ≡ w and w² ≡ w·w̄ = 1, so **w ≡ 1**. A linear map ℓ : k → 𝔽₂ with ℓ(1) = 1 two-colours every coset | **χ(F²) ≤ 2**, at any norm |
| **inert** | conjugation acts as z ↦ z^Q on k = 𝔽_{Q²}, Q = N𝔭, so unit vectors reduce into μ_{Q+1} | χ(F²) ≤ χ(U_Q) |

**Corollary** [proof]. *Every real number field of odd degree is 2-colourable.* Some prime above 2 has odd local degree,
so i is not in that completion. The extension F_𝔭(i)/F_𝔭 is then ramified, because ℚ₂(i)/ℚ₂ is ramified and F_𝔭 has odd
ramification index. (This is consistent with a hand theorem of an outside advisor, GPT Astra: χ(F²) = 2 iff the local bound
is 2, for every real number field.)

**The 2-adic targets computed** [exact spectra; colourings found and verified; refusals are solver's word]:

| Q | vertices | degree | λ_min | Hoffman χ ≥ | χ(U_Q) |
|---|---|---|---|---|---|
| 2 | 4 | 3 | −1 | 4 | **4** (it is K₄) |
| 4 | 16 | 5 | −3 | 2.67 | **4** (3 refused [solver]) |
| 8 | 64 | 9 | −3 | 4.00 | **4** |
| 16 | 256 | 17 | −7 | 3.43 | **4** |
| 32 | 1,024 | 33 | −11 | 4.00 | **4** — the trace 𝔽₁₀₂₄ → 𝔽₄ is a proper colouring, and it is essentially the only one (§4.4) |
| **64** | 4,096 | 65 | **−15** | **5.33** | **6 ≤ χ ≤ 8** — triangle-free; a linear 8-colouring is known; 6 and 7 open |
| 128 | 16,384 | 129 | −19 | 7.79 | ≥ 8 |

So **the 2-adic side gives 2 or 4 up to Q = 32, jumps to ≥ 6 at Q = 64, and ≥ 8 beyond** — the same shape of jump as the
odd side. Q = 64 is realised only by fields of degree ≥ 12: an inert 𝔭 needs F_𝔭 ramified over ℚ₂ (e ≥ 2) and
residue degree 6. **No field containing √3 realises it** [proof; second response]. Such a field makes ω = (−1 + √−3)/2 a unit
vector, and at an inert prime above 2 it reduces to an element of order 3 in μ_{Q+1}, which needs 3 | Q + 1; but 3 ∤ 65.

### 1.5 The local bound, and the conjecture it serves

Define the **local bound** L(F) as the minimum of the bounds from all conjugation-fixed primes of F(i): χ(Γ_q) for odd q,
2 or χ(U_Q) above 2. Then **χ(F²) ≤ L(F)** [proof]. *Caveat: this is the prime-ideal version; §6.3 explains why composite
ideals could in principle do better.*

**Local–global conjecture** (ours). *χ(F²) = L(F) whenever L(F) ≤ 6; bold form: χ(F²) = 7 whenever L(F) ≥ 7.* It holds at
every field where χ(F²) is known. GPT Astra has given hand proofs, read and checked here but not yet published or
formalised, for three ranges:
* L ≤ 3, for every real number field;
* L ≤ 4, for every field containing √3;
* L ≤ 5, for multiquadratic fields containing ℚ(√3, √11), given one computer-found five-colour gadget.

The mechanism: a finite graph that forces two points at difference δ to share a colour makes every k-colouring of F²
periodic under the ideal δR, where R is the ring generated by the unit vectors, and a short chain closes a contradiction.
The bold form, applied to ℚ(√3,√7,√11) (whose first usable plane is 83, with χ(Γ₈₃) ≥ 7 [cert]), would give χ(ℝ²) = 7.

---

## 2. The wall, stated precisely

**W (targets).** *For every prime power Q with Q ≡ 3 (mod 4) of odd exponent, or Q a power of 2: χ(U_Q) ≠ 6.*

**W′ (fields).** *No real number field F has L(F) = 6.*

**W′ ⟹ W at the odd members, and W ⟹ W′** [proof]. W ⟹ W′ is immediate. Conversely, if an odd window member Γ_q were
six-chromatic, the explicit field of §6.2 for that member would have first usable plane q, every other usable plane ≥ 6, and
every prime above 2 split in F(i), hence L = 6. For the 2-adic member U₆₄ a field realising it needs degree ≥ 12 (§1.4); we
expect one exists but have not exhibited it.

**W_f (the fractional wall).** *α(U_Q) < Q²/6 for Q ∈ {23, 27, 31, 43, 47, 64}*, equivalently χ_f(U_Q) > 6 there.

**W_f ⟹ W, with no heuristic** [proof]: the proven ends settle every other Q, and χ ≥ ⌈χ_f⌉ > 6 at these six. W_f is
strictly stronger than W, since a target could have χ ≥ 7 with χ_f ≤ 6. It also closes the composite-ideal escape hatch
(§6.3). One independent set of size ⌈Q²/6⌉ at any of the six refutes W_f and leaves W open there.

| Q | largest set known | best certified α ≤ | W_f needs α ≤ | refuted by a set of |
|---|---|---|---|---|
| 23 | 87 | 108 | 88 | 89 |
| 27 | 117 | **141** | 121 | 122 |
| 31 | 146 | 200 | 160 | 161 |
| 43 | 258 | 365 | 308 | 309 |
| 47 | 265 | 371 | **368** | 369 |
| 64 | 512 (from the linear 8-colouring) | 768 (Hoffman) | 682 | 683 |

**What W would give.**
* With the conjecture: χ(F²) ∈ {2, 3, 4, 5, 7} for every real number field, so six is a value no field attains.
  (χ(ℝ²) = 7 needs only the conjecture's bold form, applied to ℚ(√3,√7,√11); W is not needed for that.)
* Without it: **the residue method can never certify six as an upper bound.** A field whose plane is *exactly*
  six-chromatic would have L ≥ 7, a local–global gap. A field that merely *contains* a six-chromatic unit-distance graph may
  have χ(F²) = 7 = L, which is no gap. *(Corrected after the first response: the first version said "carrying a
  six-chromatic graph".)*
* Either way, a proof of W is a structural statement about Hadwiger–Nelson at the level of finite fields.

**Status.**

| range | status |
|---|---|
| Q ∈ {2, 3, 4, 7, 8, 11, 16, 19, 32} | χ ≤ 5: **W holds** [exact / kernel at 11, 19] |
| Q ∈ {59, 67, 71, 79, 83} and every Q ≥ 98 of either family, and Q = 128 | χ ≥ 7: **W holds**, and so does its fractional form, α < Q²/6 [cert / exact spectrum / Weil] |
| **Q ∈ {23, 27, 31, 43, 47} (odd) and Q = 64 (2-adic)** | **open** — six is possible on the proven bounds; every search argues against it (§4) |

---

## 3. The proven ends

### 3.1 Below the window: χ ≤ 5

| q | χ(Γ_q) | how |
|---|---|---|
| 3 | 3 | explicit 3-colouring; odd cycle [exact] |
| 7 | 4 | explicit 4-colouring; 3 refused [solver]; also Moorhouse's Table 6.1 |
| 11 | 5 | Moorhouse's Table 6.1; **kernel-checked** in Lean, both directions |
| 19 | 5 | explicit 5-colouring (kernel-checked); 4 refused [solver, 5 s] |

Moorhouse's Table 6.1 (2010) lists every q ≤ 17, including 13 → 5 or 6 and 17 → 5, 6 or 7 among the non-𝒬 planes (§6.4);
it does not reach any window member.

### 3.2 Above the window: χ ≥ 7

* **Spectral**: at q = 71 the exact least eigenvalue −14.1728 gives χ ≥ 6.08, so ≥ 7. For q ≥ 98, Weil gives ≥ 7.
* **Exact certificates** [cert] at 59, 67, 79, 83 prove α < q²/6. The method, in brief (§B): Schrijver's three-point
  semidefinite bound, reduced by the symmetry group into real blocks, solved in floating point on a GPU; its dual is rounded
  to exact rationals and re-checked by a standalone exact checker that rebuilds the whole constraint system from q.

| q | certified α ≤ | six needs α ≥ | Hoffman α ≤ |
|---|---|---|---|
| 59 | 575 (575.385) | 581 | 693.14 |
| 67 | 745 (745.235) | 749 | 813.78 |
| 79 | 1023 (1023.382) | 1041 | 1099.19 |
| 83 | 1046 (1046.716) | 1149 | 1199.46 |

At 67 the margin is four integers. A shorter polish of the same solve rounded to 748.83. That still refuses six,
because ⌊748.83⌋ = 748 < 749, but with nothing to spare; the longer polish bought three more integers. *(Corrected after the
first response: the first version said the 748.8 bound refused nothing.)*

### 3.3 Five refused at 27, 43 and 47

| q | certified α ≤ | five needs α ≥ | so χ ≥ | relaxation |
|---|---|---|---|---|
| 27 | **141** (141.593) | 146 | **6** | level 3 (§4.3, §B) |
| 43 | 365 (365.917) | 370 | **6** | three-point |
| 47 | 371 (371.840) | 442 | **6** | three-point |

At these three, **a single verified six-colouring would be the exact chromatic number**. None has been found.

---

## 4. The window: every piece of evidence

### 4.1 The master table (odd members)

| q | Hoffman α ≤ | certified α ≤ | largest set **found** | six needs | five needs | χ | best colouring found |
|---|---|---|---|---|---|---|---|
| 23 | 131.76 | 108 (108.546) | **87** | 89 | 106 | 5 ≤ χ ≤ 8 | 8, **kernel-checked** |
| 27 | 162 (exactly) | **141** (141.593, level 3; three-point 147.578) | **117** | 122 | 146 | **6** ≤ χ ≤ 7 | 7 |
| 31 | 240.25 | 200 (200.881) | **146** | 161 | 193 | 5 ≤ χ ≤ 8 | 8 |
| 43 | 395.23 | 365 (365.917) | **258** | 309 | 370 | 6 ≤ χ ≤ 8 | 8 |
| 47 | 466.39 | 371 (371.840) | **265** | 369 | 442 | 6 ≤ χ ≤ 10 | 10 |

**If the found independence numbers are the true ones, every window member has χ ≥ 7**, because χ ≥ ⌈q²/α⌉ always:
529/87 = 6.08, 729/117 = 6.23,
961/146 = 6.58, 1849/258 = 7.17, 2209/265 = 8.34. The gap between "found" and "certified" is the whole problem.

### 4.2 The instruments, and why the nulls are believable

* **Independent sets** — a local-search engine in Rust, symmetry-restricted variants, and an outside finder (KaMIS).
  **Calibration**: the Rust engine attains the true α at q = 11 (28) in two seconds, and the certificate there is 29.18.
* **Colourings** — Rust local search at fixed k, with checkpointed resumable runs; a subgroup-quotient sweep; an equivariant
  SAT sweep (colourings invariant under a rotation, up to a colour permutation).
* **Upper bounds** — the exact certificates of §B. **At 23, 27, 31 and 47 the three-point solve is converged**, so that
  relaxation will never improve those bounds. Only 43's is a stopped iterate. The next level of the hierarchy is a
  different relaxation, and at 27 it moved the bound from 147 to 141 (§4.3).

### 4.3 Per member

**q = 23** — six needs 89; the plateau is **87**.
* About 96,000 restarts over three stages, three seeds, eight rotation orders and a line quotient never produced 88 [null].
* A six-colouring search: 1,800 s × 3 threads stopped at 121 of 6,348 edges monochromatic [null].
* Equivariant sweep: 47 symmetry classes, 0 colourable, 43 refused [solver], 4 undecided.
* **This is the knife-edge member**: six needs only two more points than any search has found.

**q = 27** — six needs 122; **every method stops at 117**. (Studied in depth; §7.1 has the structure.)
* *Exhaustive* over every 𝔽₃-subspace W of 𝔽₂₇² ≅ 𝔽₃⁶ that contains no unit vector: the largest independent set that is a
  union of cosets of W is **81** (dim W = 4), **108** (3) and **117** (2) [exact].
  * Every orbit's quotient maximum was computed twice, by branch and bound and by CaDiCaL, with 0 disagreements over 461
    orbit classes.
  * The subspace counts (2,100 and 20,216) reproduce an independent earlier sweep.
* KaMIS, an outside state-of-the-art finder that knows nothing of the group, returns **117 on seven seeds of seven**. Every
  one of those sets is invariant under a 9-element translation subgroup [found].
* For each of the 15 conjugacy classes of subgroups of prime order of Aut (orders 2, 3, 7), the largest invariant
  independent set by CP-SAT, 180 s each [found / null]:
  * best **117** (point reflection, both line reflections, several order-3 translations);
  * **106, proven optimal** for the order-7 rotations [solver];
  * nothing above 117 anywhere.
* **Every 117-set found is maximal, and every vertex outside it has at least 4 neighbours inside**. To add one point you
  must remove four, which is why local search stalls.
* The subgroup-quotient colouring sweep is exhaustive at indices 9 and 27: no six-colouring is periodic there [exact]. The
  best periodic colouring found uses 7 colours.
* **Upper side: five colours refused** [cert]. The next level of the semidefinite hierarchy is Gvozdenović–Laurent–
  Vallentin's `L₃`, whose variables are the orbits of independent sets of size ≤ 4: 77,238 of them at 27, in 102 blocks. It
  certifies **α ≤ 141** (N = 141.593), against the converged three-point 147.578. So 5 × 141 = 705 < 729, and **χ(Γ₂₇) ≥ 6**.
  * The checker uses the Python standard library only and rebuilds the plane, the group and every constraint from q and
    the modulus. It passed 21 of 21 planted-fault controls.
  * The same instrument certifies N = 14.00000007 at q = 7 and 28.07 at q = 11, so there it gives the exact α (14 and 28).
  * The floating-point solve is still converging: a later iterate rounds to 141.16. But W_f at 27 needs α ≤ 121, 14 %
    further down, which is beyond anything this relaxation has shown.

**q = 31** — six needs 161; plateau **146** (75,852 restarts in one chained hour alone) [null]. Six-colour search: 195 of
15,376 edges monochromatic after 1,800 s × 3 threads [null].

**q = 43** — six needs 309; plateau **258**.
* 258 = 6·43 is exactly a set constant along the lines of one direction: nothing better than a line-periodic set was ever
  found.
* A dedicated three-hour search aimed at 309 made **zero** progress off its seed [null].
* The six-colour search stalled at 1,016 monochromatic edges and held there for 2 h 52 m [null].
* Equivariant sweep: 21 classes, 0 colourable, 18 refused [solver].

**q = 47** — six needs 369 against a certified 371, so **the certificate would have to be 99.4 % tight**. The level-3
relaxation moved 27 by 4.1 % (147.578 → 141.593). It would need to move 47 by only **0.76 %** (below 369) to refuse six
outright, prove W_f at 47, and take 47 out of the window. It has been priced there, not run. The only plane
where tightness like that has been observed is q = 7 (α/N = 0.9938); at q = 11 it is 0.9597.
* Plateau 265; the six-colour search stalled at 1,851 monochromatic edges [null].
* Equivariant sweep: 63 classes, 0 colourable, 59 refused [solver].

**A caution on the equivariant zeros.** At q = 11 and 19, where five-colourings exist, the colourable symmetry classes are
exactly the kind these sweeps leave *undecided*. The refusals are therefore weaker evidence than their counts suggest, and
about a third of them follow in one line from the fact that a rotation fixes the origin.

### 4.4 The 2-adic member Q = 64

U₆₄ has 4,096 vertices and degree 65. Hoffman gives χ ≥ 6 (α ≤ 768; six needs α ≥ 683), and a linear 8-colouring exists
[found], so 6 ≤ χ ≤ 8. It is the only 2-adic target in the window, reachable only by fields of degree ≥ 12, none of which
contains √3 (§1.4).

**Why the smaller 2-adic targets are four-colourable, and why that stops at 64** [proof; second response; every finite
instance recomputed here]:
* **At Q = 32 the four-colouring is forced to be linear.** The relative trace T : 𝔽₁₀₂₄ → 𝔽₄ never vanishes on μ₃₃
  (μ₃₃ = 𝔽₄^× · μ₁₁; the powers of 4 modulo 11 are the quadratic residues and 2 is a non-residue, so the trace of a
  primitive 11th root of unity is a root of X² + X + 1), so
  x ↦ T(x) is a proper four-colouring. The least eigenvalue −11 occurs exactly at the characters indexed by μ₃₃ (a
  moment-polynomial argument with Weil's bound). A maximum independent set meets Hoffman's bound with equality, so its
  indicator's Fourier transform lives on {0} ∪ μ₃₃. The Sidon property then forces that support to be {0, a, b, a + b}.
  **So every maximum independent set is an 𝔽₄-hyperplane Tr(ax) = c** (44 of them), and **every four-colouring is one of
  11 parallel classes**, up to naming the colours.
* **At Q = 64 no linear four-colouring can exist.** Every eigenvalue is ≡ 1 (mod 4), because μ₆₅ sums to zero. So
  λ_min ≥ −15, and every binary codimension-2 subspace contains at least (65 − 45)/4 = 5 unit vectors. The bound is
  attained: exhaustively, the minimum is exactly 5.
* **Constraints on a six- or seven-colouring of U₆₄.** A cubelike graph on at most 16 vertices that is 7-colourable is
  4-colourable, since a colour class of size ≥ 3 spans an independent subgroup of order 4. So **a six- or seven-colouring
  cannot be periodic under any 𝔽₂-subspace of dimension ≥ 8**. Also, every linear eight-colouring has quotient K₈, so no
  two of its classes can be merged.
* The rigidity argument at 32 rests on Hoffman *equality*. At 64 Hoffman is slack (768 against 683), so it does not
  transfer as stated. A stability version (near-equality forces near-hyperplane structure) is one route to W_f at 64 that we
  have not pursued.

A first SAT attempt at k = 6 and 7 (symmetry pins only) is running at the time of writing.

---

## 5. The shape of the numbers

### 5.1 One normalisation makes the pattern visible

Put **c(q) := α(Γ_q) / q^{3/2}**. Hoffman plus Weil gives c ≤ 2 + o(1). Six colours need c ≥ √q/6 — **unconditionally**,
since each colour class is independent. The other edge is not unconditional: c ≥ √q/5 means χ_f ≤ 5, and a graph can have
χ_f ≤ 5 < χ. So the **six-window [√q/6, √q/5)** is where Γ_q can be exactly six-chromatic *under the rounding reading*
χ = ⌈χ_f⌉ (§1.2); without that reading, only the lower edge is a necessary condition. *(Corrected after the first response,
which pointed out that the first version's argument leaned on the reading more than it said.)*

| q | c from the **largest set found** | c from the **certificate** | six-window [√q/6, √q/5) |
|---|---|---|---|
| 7 | 0.756 (exact α) | 0.761 | [0.441, 0.529) |
| 11 | 0.768 (exact α) | 0.800 | [0.553, 0.663) |
| 19 | ≥ 0.918 (found 76) | — | [0.726, 0.872) |
| **23** | **0.789** | 0.984 | **[0.799, 0.959)** |
| **27** | **0.834** | 1.009 (level 3) | **[0.866, 1.039)** |
| **31** | 0.846 | 1.164 | [0.928, 1.114) |
| **43** | 0.915 | 1.298 | [1.093, 1.311) |
| **47** | 0.822 | 1.154 | [1.143, 1.371) |
| 59 | 0.801 | 1.270 | [1.280, 1.536) |
| 67 | 0.808 | 1.359 | [1.364, 1.637) |
| 79 | 0.823 | 1.457 | [1.481, 1.778) |
| 83 | 0.789 | 1.384 | [1.518, 1.822) |

What the table shows:
* **The found values of c sit in a narrow band, 0.75–0.92, for every q from 7 to 83.**
* The six-window moves up like √q. It crosses that band only for q roughly between 14 and 30, and the elements of 𝒬 in that
  range are 19, 23 and 27.
* **At 19 the found c is above the window**, consistent with χ = 5, which an explicit colouring proves.
* **At 23 and 27 it lands just below the window**: 0.789 against 0.799, and 0.834 against 0.866.
* From 31 upward the window is out of reach of the band, and the certificates close it from 59 on.

### 5.2 Two readings, and what would separate them

**Reading A — a theorem.** Some structural reason keeps α(Γ_q) out of [q²/6, q²/5), or keeps χ(Γ_q) ≠ 6 by other means.
The data's sharpness argues for this reading if the true c(23) and c(27) sit strictly below their windows. That would need
an upper bound far stronger than every relaxation we have: the best certificates give c = 0.98 (three-point) and 1.01
(level 3) there, while the truth appears to be about 0.79 and 0.83.

**Reading B — an arithmetic near miss.** c(q) is a slowly varying function of q, 𝒬 is sparse, and the window of q where
six is plausible happens to contain only 23 and 27, both of which fall just short. Under this reading there is no theorem,
and a small change could land on six: another member of the family, or a composite residue ring whose factor has an
integrality gap (§6.3).

**What would separate them:**
* the true α(Γ₂₃) (is it 87 or 88, or 89 or more?), or any exact α at an open member;
* a proof that α(Γ_q) ≤ 0.8 q^{3/2} for some range;
* a six-colouring of U₆₄;
* the behaviour of the analogous graphs with q ≡ 1 (mod 4) (§6.4), which have no role for fields but are the same kind of
  object.

### 5.3 How weak the relaxations are, measured

| q | certificate ÷ Hoffman | largest found ÷ certificate |
|---|---|---|
| 7 | 0.799 | 0.994 |
| 11 | 0.845 | 0.960 |
| 23 | 0.824 | 0.801 |
| 27 | 0.874 (level 3; three-point 0.911) | 0.826 (three-point 0.793) |
| 31 | 0.836 | 0.727 |
| 43 | 0.926 (not converged) | 0.705 |
| 47 | 0.797 | 0.713 |
| 83 | 0.873 | 0.570 |

The last column is the gap a theorem must close. The three-point certificate at 27 looked weak against Hoffman (0.911)
only because Hoffman is unusually strong there (§7.1): its density 162/729 = 0.222 is well below the 0.249–0.250 at 23 and
31, while that certificate's own density, 0.2024, was in line with its neighbours. The level-3 certificate's density is
0.1942. Every other row is three-point.

---

## 6. The field side

### 6.1 Which fields can see a window member at all

A prime above p is usable only if every square root the field contains is a square modulo that prime (in its residue
field). Across the odd window:

| q | 3 a square in 𝔽_q? | 11 a square? | ω(Γ_q) |
|---|---|---|---|
| 23 | yes | no | 3 |
| 27 | yes (characteristic 3) | no | 3 |
| 31 | no | no | 2 |
| 43 | no | yes | 2 |
| 47 | yes | no | 3 |

**No window member admits √3 and √11 together.** So:
* every field containing ℚ(√3, √11) has L ≤ 5 or L ≥ 7;
* those fields include every field in which a five-chromatic unit-distance graph is known;
* the Moser spindle needs both √3 and √11, so no field whose local bound could be 6 contains a Moser spindle;
* at 31 and 43 such a field's plane has no triangles at all (it contains no √3).

(At 27 the triangles are degenerate: in characteristic 3, 2u = −u, so {0, u, 2u} is pairwise unit-distant and collinear.)

### 6.2 The smallest fields each window member would "buy"

Search: PARI's `nflist`, complete over every field of degree ≤ 4 with |disc| ≤ 20,000, primes above 2 classified as in §1.4
[exact]. Every field of degree 3 or 4 fails at 2 (ramified or inert with Q ≤ 4).

| member | smallest field with it as first usable target, and every prime above 2 split in F(i) | its usable planes below 100 |
|---|---|---|
| 23 | ℚ(√167) | 23, 43, 59, 67, 71, 79, 83 |
| 27 | even degree ≥ 6 is forced; smallest found: the cubic x³ + 2x² − 3x − 2 (disc 316) joined with √79 | 27, 43, 79 |
| 31 | ℚ(√1055) | 31, 43, 47, 83 |
| 43 | ℚ(√4703) | **43, 47, 79** |
| 47 | ℚ(√2351) | **47, 67, 71, 83** |

**Real quadratic fields whose local bound is at least 6.** With d ≤ 30,000 there are **16** real quadratic fields ℚ(√d)
with the 2-adic primes split in F(i) and no usable plane among {3, 7, 11, 19, 23, 31}. **Every one has 43 or 47 usable**, so
its local bound is 6 exactly when one of those two planes is six-chromatic, and ≥ 7 otherwise:
* ℚ(√2351) — decided by 47 alone;
* ℚ(√4703), ℚ(√4847) — decided by 43 or 47;
* ℚ(√20807) — the first decided by 43 alone.

**No real quadratic field with d ≤ 30,000 has local bound ≥ 7 without passing through 43 or 47.** So the fate of these
fields is exactly the fate of W at 43 and 47.

### 6.3 What W′ does not cover — the escape hatches

1. **Composite ideals.** The reduction works modulo any ideal 𝔞 all of whose prime factors are conjugation-fixed. By the
   Chinese remainder theorem the target for 𝔭₁𝔭₂ is the **categorical (tensor) product** U_{Q₁} × U_{Q₂}, and
   χ(G × H) ≤ min(χ(G), χ(H)). Hedetniemi's conjecture — equality — is **false in general** (Shitov 2019), but the known
   counterexamples need far more than seven colours. It is proved at 4 (El-Zahar–Sauer 1985) and, to our knowledge, open at
   5, 6 and 7. **So a product of two targets that are each ≥ 7-chromatic might be six-colourable, and W′ would then fail
   for the field's composite local bound.** We have not measured any such product.
2. **Prime-power ideals.** Modulo 𝔭^k the target is a "tower level" mapping onto U_Q, so its chromatic number is at most
   χ(U_Q). For the 2-adic tower of ℚ(√3,√11) at four colours the levels stabilise; for odd q we have not measured any
   level at six.
3. **Fields with no small usable target at all** (L ≥ 7 from the start, e.g. ℚ(√3,√7,√11)). W says nothing about their
   true chromatic number; only the conjecture does.

### 6.4 A control family: q ≡ 1 (mod 4)

For q ≡ 1 (mod 4) the "unit circle" x² + y² = 1 is a split conic with q − 1 points. The plane UD(𝔽_q, 2) is then a
different graph, never a residue target of a real field. Known values: 5 → 3, 9 → 3, **13 → 5** (5-colouring found, 4
refused [solver]), **17 → 5 or 6** (a six-colouring found [found]; five open; Moorhouse listed 5, 6 or 7). **If χ(UD(𝔽₁₇,2))
= 6, six-chromatic planes exist in the split family**, and any explanation of W must use the non-split structure (the norm-one
group μ_{q+1}) rather than something true of all finite planes.

---

## 7. Structure found along the way that may matter

### 7.1 The plane at 27, in detail (the one non-prime odd member)

* **Every edge lies in exactly one triangle, and it is a straight line** {z, z+u, z+2u}.
  * A third point w over the edge {0, 1} needs N(w) = N(1 − w) = 1, i.e. w² − w + 1 = 0.
  * In characteristic 3 that polynomial is (w + 1)², so the two equilateral triangles of the other ω = 3 planes merge into
    one flat one.
  * The 10,206 edges split into 3,402 edge-disjoint triangles, and the 14 unit directions form a **cap in PG(5, 3)**.
  * This holds for every q = 3^f with f odd [proof]. In the language of §1.2: for a unit d, the two unit vectors summing to
    d are the roots of X² − dX + d², which in characteristic 3 is (X + d)². So the only common neighbour of 0 and d is
    −d = 2d.
* **Every eigenvalue is an integer**, as for any Cayley graph on an elementary abelian 3-group (Bridges–Mena 1982). The
  spectrum is 28¹, 10²⁸, 7⁸⁴, 4¹⁶⁸, 1⁸⁴, −2¹⁶⁸, −5⁸⁴, −8¹¹² [exact].
  * Each eigenvalue is 3m − 14, where m is the number of unit directions in the corresponding hyperplane of 𝔽₃⁶. So every
    eigenvalue is ≡ 1 (mod 3).
  * Weil forbids −11, hence **λ_min = −8 exactly** and the Hoffman bound is exactly 162.
  * **By Moisio's identity** (2008) each eigenvalue is the Frobenius trace of the elliptic curve y² = x³ + x² − a over
    𝔽₂₇, and every curve in that family has 3 | #E. Verified on all 26 curves; the largest has 36 points.
* **|Aut| = 122,472**, with nothing hidden [exact, nauty].
* **Independence**: exhaustive subspace-periodic maximum 117; outside-finder attractor 117; prime-order-symmetric maximum
  117; every 117-set 4-rigid; **certified α ≤ 141** at level 3, so χ ≥ 6 (§4.3).

### 7.2 Symmetry of optimal colourings (a reading)

At every plane where χ is known (q = 3, 7, 11, 19) there is an optimal colouring c with c(−z) = τ(c(z)) for an involution τ
of the colours, and at 19 no simpler form survives [exact, 4 of 4]. If this held in general, it would halve every
colouring question, from q² vertices to (q² + 1)/2 orbits. Nothing in the literature we searched asserts or refutes it.

### 7.3 Slackness

At six colours every window plane is Hoffman-slack. Hoffman-tightness at k needs (k − 1) | (q + 1), and 5 ∤ q + 1 for
q ∈ {23, 27, 31, 43, 47}.

* **What tightness would have given.** When a plane is Hoffman-tight at k, every k-colouring is balanced, no colour is
  missing from any closed neighbourhood, and every colouring is periodic under the common kernel of the least-eigenvalue
  characters (Blokhuis–Brouwer–Haemers for the first two). U₃₂ at four colours is the extreme case (§4.4).
* **What slackness does not give.** It removes that mechanism, but it does **not** prove the converse: that a six-colouring,
  if one exists, leaves every pair of non-adjacent points free to differ. That needs a separate argument. At q = 11 and 19
  with five colours we have one: those planes have colourings in which a colour is missing from some vertex's closed
  neighbourhood, and such a gap frees every pair [kernel]. No six-colouring is known at any window plane, so there the
  statement is unproved. If no six-colouring exists, it is vacuous.
  *(Corrected after the first response: the first version concluded "no residue plane forces pairs at six colours" from
  slackness alone.)*

---

## 8. What we are asking

**Q1 — the governing theorem.** Is χ(U_Q) ≠ 6 for every Q in the two families? In the sharpest form the data suggests:
**is α(U_Q) < Q²/6 for Q ∈ {23, 27, 31, 43, 47, 64}** (W_f, §2)? That would prove W with no heuristic, and close the
composite-ideal escape hatch too. The closest member is **47**, where an upper bound of 368 would do it against the certified
371. The farthest is **27**, which needs 121 against 141.

**Q2 — the independence number of a non-split finite Euclidean plane.** What is known about α(Γ_q) = the largest subset of
𝔽_q² with no two points at squared distance 1, for q ≡ 3 (mod 4)?
* Upper bounds better than Hoffman/ϑ and the three-point SDP.
* Constructions: our best sets are unions of cosets of small subgroups, or constant along lines.
* Exact values for any q > 11.
* Whether α ≈ c·q^{3/2} with c < 1 is known or provable. The finite-field Erdős–Falconer literature (Iosevich–Rudnev and
  successors) treats large sets meeting *every* distance. We need the extremal side for *one* distance, sharp at small q,
  and we have not found it.

**Q3 — a mechanism beyond counting.** Is there a reason a six-colouring of Γ_q must fail that is not "some class is too
small"? For example: a rigidity forcing optimal colourings to be periodic or symmetric, a character-sum obstruction to a
balanced 6-partition, or an algebraic-geometry reason via the norm-one torus.

**Q4 — the 2-adic member.** Is Cay(𝔽₄₀₉₆, μ₆₅) six-colourable, and is α(U₆₄) < 683? *Partly answered by the second
response (§4.4):* the four-colourings at m = 5 are the trace to 𝔽₄ and nothing else; linear four-colourings die at m = 6
because λ ≡ 1 (mod 4); and a six- or seven-colouring of U₆₄ cannot be periodic under a subspace of dimension ≥ 8. Open: a
nonlinear six-colouring, or a stability form of the Hoffman-equality argument that bounds α(U₆₄) below 683.

**Q5 — the escape hatches.** *Largely answered by both responses (§6.3).* A composite target can be exactly six-chromatic
only if some factor has a residue size in {23, 27, 31, 43, 47, 59, 64, 67, 79, 83}. Among first-level factors, only an
**integrality gap** (χ_f ≤ 6 < χ) at one of the six open members lets it through. What remains: **can a tower level above
23, 27, 31, 43, 47, 59, 64, 67, 79 or 83 have χ_f ≤ 6** when the level below has χ_f > 6? The Hoffman bound is constant up
every inert tower, but the certificates at 59–83 do not obviously lift.

**Q6 — the field statement directly.** Is there an argument that no real number field F has χ(F²) = 6, or a construction of
one, that does not go through the residue method at all?

**Pointers to prior art we may have missed would be as valuable as proofs.** In particular: any table of α or χ for
UD(𝔽_q, 2) beyond q = 17; any work on Cayley graphs of 𝔽_{q²} with connection set the norm-one group ("unitary graphs",
"Hermitian unit-circle graphs"); and any result on Hedetniemi's conjecture at 6 or 7 colours for Cayley graphs.

---

## Appendix A — the full table for the odd family, q ≤ 107

| q | degree | λ_min | Hoffman α ≤ | certified α ≤ | largest found | ⌈q²/6⌉ | ⌈q²/5⌉ | χ |
|---|---|---|---|---|---|---|---|---|
| 3 | 4 | −2 | 3 | — | 3 | 2 | 2 | 3 |
| 7 | 8 | −4.4940 | 17.63 | 14 (level 3: 14.0000001) — so α = 14 | 14 | 9 | 10 | 4 |
| 11 | 12 | −4.7958 | 34.55 | 28 (level 3: 28.072; three-point 29.177) — so α = 28 | 28 | 21 | 25 | 5 |
| 19 | 20 | −7.6097 | 99.50 | — | 76 | 61 | 73 | 5 |
| 23 | 24 | −7.9607 | 131.76 | 108 | 87 | 89 | 106 | 5–8 |
| 27 | 28 | −8 | 162 | 141 (level 3) | 117 | 122 | 146 | 6–7 |
| 31 | 32 | −10.6665 | 240.25 | 200 | 146 | 161 | 193 | 5–8 |
| 43 | 44 | −11.9622 | 395.23 | 365 | 258 | 309 | 370 | 6–8 |
| 47 | 48 | −12.8465 | 466.39 | 371 | 265 | 369 | 442 | 6–10 |
| 59 | 60 | −14.9176 | 693.14 | 575 | 363 | 581 | 697 | 7–10 |
| 67 | 68 | −15.0567 | 813.78 | 745 | 443 | 749 | 898 | 7–12 |
| 71 | 72 | −14.1728 | 829.09 | — | 426 | 841 | 1009 | 7–12 |
| 79 | 80 | −17.1019 | 1099.19 | 1023 | 578 | 1041 | 1249 | ≥ 7 |
| 83 | 84 | −17.7087 | 1199.46 | 1046 | 597 | 1149 | 1378 | ≥ 7 |
| 103 | 104 | −20.0322 | 1713.4 | — | — | 1769 | — | ≥ 7 (Hoffman 6.19) |
| 107 | 108 | −19.0495 | 1716.6 | — | — | 1909 | — | ≥ 7 (Hoffman 6.67) |

Eigenvalues are exact algebraic numbers computed as character sums and matched against Kloosterman sums, shown here to four
decimals. Every "largest found" set and every colouring upper bound is verified from the definition by a script sharing no
code with the tool that produced it.

## Appendix B — how the exact certificates work

For a vertex-transitive graph G and an independent set S, one forms the 0/1 matrices indexed by pairs of vertices and
built from the triples inside S — Schrijver's three-point construction. Averaging over Aut(G) and the S₃ relabelling gives
a positive semidefinite matrix in the orbit algebra, with linear constraints forced by S being independent. Maximising |S|
over all such matrices bounds α(G). The orbit algebra is block-diagonalised by the Fourier transform along the rotation
group μ_{q+1}, giving real symmetric blocks of size ≤ q.

A floating-point solver (SCS, on a GPU) produces a near-optimal *dual*. Its multipliers and Gram factors are rounded to
exact rationals, and a standalone checker (Python standard library only) verifies:
* the multipliers' signs;
* the exact positive-semidefiniteness of each block, by exact LDLᵀ;
* the exact affine identity that makes the dual objective N an upper bound.

It rebuilds every orbit and constraint from the number q, so it trusts nothing the solver produced. A certified N gives
α ≤ ⌊N⌋.

**Level 3 (used at 7, 11 and 27).** Gvozdenović–Laurent–Vallentin's block-diagonal hierarchy one step above Schrijver's
bound: moment matrices localised at one or two anchor points, with every sign pattern, in Schrijver's normalisation. Its
variables are the orbits of sets of ≤ 4 points under Aut(G), and symmetry reduction splits the matrices into blocks. At 27
that is 77,238 variables and 102 blocks of orders 169–378. It is solved by a first-order method
(ADMM) that checkpoints its iterate. A copy of the iterate is rounded to exact rationals: integer ±1 orbit-sum columns, with
the stabiliser weights folded into rational Gram factors. The checker then verifies, over all 77,238 variables, the exact
identity N − Σ_u y{0,u} = Σ ⟨Z, A(y)⟩ + Σ λ y + Σ μ (1 − y) with Z ⪰ 0 and λ, μ ≥ 0. It needs no symmetry argument: each
canonical form it uses is checked to be an automorphic image of its set, so a wrong canonicaliser can only make it refuse. At q = 83 a kernel-checked Lean theorem consumes ⌊N⌋ to conclude χ ≥ 7; the certificate itself is not yet
kernel-checked. Files, checker and logs can be provided.

## Appendix C — references

What we used each work for, and how much of it we read.

* A. D. N. J. de Grey, *The chromatic number of the plane is at least 5*, Geombinatorics 28 (2018); arXiv:1804.02385 — the
  lower bound. Read.
* N. G. de Bruijn, P. Erdős, *A colour problem for infinite graphs and a problem in the theory of relations* (1951) —
  compactness. Standard.
* G. E. Moorhouse, *On the Chromatic Numbers of Planes*, preliminary draft (2010), ericmoorhouse.org/pub/chromatic.pdf — the
  residue bound (§8.2, §10.3), Table 6.1 (χ for q ≤ 17), Lemma 6.2. Read in the sections cited.
* V. O. Manturov, *On the chromatic numbers of integer and rational lattices*, arXiv:1206.1934; J. Math. Sci. 214 (2016),
  Thms 17–19 — the residue bound. Read in the theorems cited.
* D. A. Madore, *The Hadwiger–Nelson problem over certain fields*, arXiv:1509.07023 (2015) — the valuation-ring form
  (Prop. 3.2, Cor. 3.4) and the reduction to number fields. Read.
* M. Krebs, *Clique numbers of finite unit-quadrance graphs*, J. Algebraic Combin. 57 (2023) 1–20 — ω in every
  characteristic (Thm 5.2, §5.2). Read.
* L. A. Vinh, *On chromatic number of unit-quadrance graphs (finite Euclidean graphs)*, arXiv:math/0510092 (2005) — general
  bounds for q = p^n. Read.
* A. Medrano, P. Myers, H. Stark, A. Terras, *Finite analogues of Euclidean space* (J. Comput. Appl. Math., 1996) — spectra
  via Kloosterman sums. Held.
* D. Hart, A. Iosevich, D. Koh, S. Senger, I. Uriarte-Tuero, *Distance graphs in vector spaces over finite fields*,
  arXiv:0804.3036 — distance-graph pseudorandomness. Abstract read.
* A. Iosevich, M. Rudnev, *Erdős distance problem in vector spaces over finite fields* (Trans. AMS, 2007) — sets of size
  ≫ q^{3/2} realise every distance. Recalled, not re-read.
* W. G. Bridges, R. A. Mena, *Rational G-matrices with rational eigenvalues* (JCTA, 1982); A. Ahmady, J. Bell, B. Mohar,
  *Integral Cayley graphs and groups*, arXiv:1307.6155 — integrality. Abstracts.
* M. Moisio, *Kloosterman sums, elliptic curves, and irreducible polynomials with prescribed trace and norm* (Acta Arith.,
  2008), arXiv:0706.2112 — #E(a) = 3^m + K(a). Abstract; the identity was verified here at 27.
* N. Katz, R. Livné — value distribution of Kloosterman sums in characteristic 3. Listing only.
* A. J. Hoffman (1970), P. Delsarte (1973), L. Lovász (1979) — the ratio bound and ϑ. Standard.
* A. Schrijver, *New code upper bounds from the Terwilliger algebra and semidefinite programming* (IEEE Trans. Inform.
  Theory, 2005) — the three-point construction. Recalled.
* K. G. Fischer, *Additive k-colorable extensions of the rational plane*, Discrete Math. 82 (1990) 181–195; D. R. Woodall
  (1973) — additive colourings and the two-colour mechanism over fields. Read (Fischer).
* Y. Shitov, *Counterexamples to Hedetniemi's conjecture* (Ann. Math., 2019); M. El-Zahar, N. Sauer (1985) — products.
  Listing.
