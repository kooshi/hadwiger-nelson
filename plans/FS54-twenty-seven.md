# FS-54 — twenty-seven: the subplan

*Opened 2026-09-16 by Kooshi ("You are go for FS-54, along with any additional derivations or measurements about q=27. I
want to know everything that makes it special."). The stub `plans/STUB-twenty-seven.md` holds the mission in full; this
file is the execution plan and supersedes the stub's §4 where they differ. Written for a session with no memory.*

**The object.** `UD(𝔽₂₇,2)`: the 729 points of `𝔽₂₇²`, `𝔽₂₇ = 𝔽₃[t]/(t³ − t − 1)`, two points adjacent when their
difference has `dx² + dy² = 1`. Degree 28, 10,206 edges, `edges_sha256 = b15ae514…` (Python-tools convention). It is
the only non-prime member of the window `{23, 27, 31, 43, 47}` of planes that can be exactly six-chromatic, and the
question the milestone serves is still FS-53's: **is any finite Euclidean plane exactly six-chromatic?** At 27 six needs
`α ≥ 122`, five needs `α ≥ 146`, and a converged exact certificate gives `α ≤ 147`.

---

## §1 What the opening measurements settled (2026-09-16, before any search)

Every item below is re-derived by a committed script; run it rather than trusting this prose.

### 1.1 The structure — `tools/fs54_structure.py` → `data/fs54/structure.out`
* **Every edge lies in exactly one triangle, and that triangle is a straight line** `{z, z+u, z+2u}`: in characteristic 3,
  `2u = −u`, so the three points of an `𝔽₃`-line through a unit direction are pairwise unit-distant. The 10,206 edges split
  into **3,402 edge-disjoint collinear triangles**. At 23 and 47 (where `ω = 3` because 3 is a square) each edge lies in
  **two** genuine equilateral triangles — the two roots of `w² − w + 1`; in characteristic 3 that polynomial is `(w + 1)²`,
  the two roots merge at `w = −1`, and the two triangles merge into one flat one.
* **The 14 unit directions form a cap in `PG(5,3)`** — no three collinear — which is the same fact seen projectively (three
  collinear directions would make a non-degenerate triangle).
* **The spectrum, complete:** `28¹, 10²⁸, 7⁸⁴, 4¹⁶⁸, 1⁸⁴, −2¹⁶⁸, −5⁸⁴, −8¹¹²`. The eigenvalue at character `a` is
  **`3·m_a − 14`**, `m_a` = number of directions in the hyperplane `a^⊥` (`m ∈ {2,…,8}`).
* **`|Aut| = 122,472 = 729 · 56 · 3`** (nauty): translations, `O(2,27)`, and the Frobenius `(x, y) ↦ (x³, y³)` — **nothing
  hidden**. The prime planes lack the factor 3.

### 1.2 Why the spectrum is integral, and why exactly −8 — the stub's fact (c), **closed and prior art**
* **Integral:** every Cayley graph on an elementary abelian 3-group has integer eigenvalues (characters take values in
  `ℤ[ζ₃]`, whose real elements are integers; Bridges–Mena 1982 classify integral abelian Cayley graphs, and the "Cayley
  integral groups" literature records that such 3-groups are exactly the elementary abelian ones). So **every**
  `UD(𝔽_{3^f},2)` is integral — odd or even `f` — and 27 is special only because it is the window's one characteristic-3 member.
* **Exactly −8, by an elementary chain that needs no outside theorem at q = 27:** each unit direction `±u` contributes
  `ζ₃^t + ζ₃^{−t}`, which is 2 or −1, so `λ_a = 3·m_a − 14 ≡ 1 (mod 3)` — and for every `q = 3^f` with `f` odd,
  `λ_a = 3·m_a − (q+1)/2 ≡ 1 (mod 3)`. Weil's `|λ| ≤ 2√27 = 10.39` then forbids −11, so `λ ≥ −8`; attainment is the
  computation (56 hyperplanes hold exactly two directions). **The explanation of what the eigenvalues ARE** is Moisio's
  identity in characteristic 3: each is the trace of Frobenius of `E_a : y² = x³ + x² − a` over `𝔽₂₇`, `t = 28 − #E_a`
  (verified on all 26 curves), and the congruence is `3 | #E_a`; the largest curve has 36 points, Hasse allows 38. The
  multiplicities are the family's point-count distribution (Katz–Livné's class-number formula, listing only). Hence the
  ratio bound is exactly `729·8/36 = 162`.

### 1.3 The stub's fact (d) is WRONG as written, and the truth is more interesting
"Worst certificate reach ever measured, 0.9110" omits **43**, whose certificate `α ≤ 365` against its ratio bound 395.23
has reach **0.9258** (N = 365.917; its solve is not converged, so the relaxation's own reach there is lower; the claim is true only as
"worst among converged solves"). And the reach is high at 27 **because the ratio bound is unusually strong, not because the
relaxation is weak**, as densities show (bound ÷ n):

| q | ratio-bound density | certificate density |
|---|---|---|
| 23 | 131.76/529 = **0.2491** | 108.55/529 = 0.2052 |
| **27** | 162/729 = **0.2222** | 147.58/729 = 0.2024 |
| 31 | 240.25/961 = **0.2500** | 200.9/961 = 0.2091 |

The certificate at 27 sits in line with its neighbours; the ratio bound gets an **integrality gift** — the congruence
`λ ≡ 1 (mod 3)` forbids anything between −8 and −11, and −11 is beyond Weil, so `|λ_min|` is 77 % of Weil's cap at 27
against 83 % at 23 and 96 % at 31.

### 1.4 The stub's fact (f) is prior art in substance, and G57 is wrong in characteristic 3
The collinear triangle is `[Moorhouse2010]` Lemma 6.2(b)'s odd `p`-cycle at `p = 3` and `[Krebs2022]` §5.2 (`UD(F,1)` is a
union of `p`-cycles, `ω = 3` iff `p = 3`); ours is only the edge-disjoint decomposition and the cap. **G57's "a field
contains √3 exactly when its usable planes have triangles" is false in the converse direction**: ℚ has no √3 and its usable
plane at 11 has triangles; and at 27 every plane has them, whatever the field. The correct statement holds for usable `q` prime to 3. (G57's
Moser-spindle conclusion survives: 11 is a non-square in `𝔽₂₇`.)

### 1.5 D6: the field that sees 27 — `tools/fs54_fields.gp` → `data/fs54/fields.out`
* **The primes above 2, classified correctly** (an error in this section's first version, caught while drafting the outward
  write-up): a prime of `F` above 2 that **splits** in `F(i)` gives no bound; one **ramified** in `F(i)/F` gives
  **`χ(F²) ≤ 2` at any norm** — conjugation acts trivially on the residue field, so a unit vector `w` has `w² ≡ w·w̄ = 1`,
  hence `w ≡ 1`, and a linear map `k → 𝔽₂` with `1 ↦ 1` is a proper two-colouring of each coset of the unit-vector group;
  one **inert** gives `Cay(𝔽_{Q²}, μ_{Q+1})`, `Q = N𝔭`, which is **4-colourable at Q = 2, 4, 8, 16, 32** (CaDiCaL; Hoffman
  floors ≤ 4; controls ℚ → 2, ℚ(√3) → ≤ 4, ℚ(√3,√11) → ≤ 4, ℚ(√41) → 2 all agree). **Consequence: every field of odd degree
  is 2-colourable** — some prime above 2 has odd local degree, so `i` is not in that completion, and the extension is ramified
  because `ℚ₂(i)/ℚ₂` is.
* **And the 2-adic side has its own window member**: `U₆₄ = Cay(𝔽₄₀₉₆, μ₆₅)` has `λ_min = −15`, Hoffman `χ ≥ 5.33`, a linear
  8-colouring — so `6 ≤ χ(U₆₄) ≤ 8` — while `U₁₂₈` has floor 8 (`data/fs54/char2/`, carry-less rebuild; an exp-table build
  gave a spurious −129 at 128 and is discarded). A field realising `U₆₄` needs an inert prime above 2 of residue degree 6 with
  `F_𝔭` ramified over `ℚ₂`, so degree ≥ 12.
* **So the first version's answer — the conductor-13 cubic field — is 2-colourable and sees nothing.** Nor does the stub's
  `ℚ(√3, ρ)` (usable plane at 11).
* **A field whose first usable plane is 27, with the wall broken, has even degree ≥ 6**: quadratic fields cannot reach `𝔽₂₇`;
  a quartic with a degree-3 prime above 3 has a degree-1 one too (an `𝔽₃` plane); odd degree is 2-colourable. Smallest found
  among composita of a cubic (|disc| ≤ 4000, 3 inert) with `ℚ(√d)` (`d ≡ 7 mod 8`, `d ≤ 400`): **the cubic `x³ + 2x² − 3x − 2`
  (disc 316) joined with `√79`**, |disc| 31,554,496, usable planes below 100: **27, 43, 79**. Not claimed minimal over all
  sextic fields.

### 1.6 A correction to G56, `data/fs53/window.md` and `data/fplane/map.md`, found by the same complete search
Those files name biquadratic fields for 23, 31, 43, 47 and assert that one radicand cannot do it ("every minimal field
satisfying only the first condition has the wall standing … why these need two radicands"). **False**: quadratic fields
with the 2-adic wall broken see each prime member first —

| member | smallest by discriminant (degree ≤ 4, `|disc|` ≤ 20,000) | usable planes < 100 |
|---|---|---|
| 23 | `ℚ(√167)`, disc 668 | 23, 43, 59, 67, 71, 79, 83 |
| 31 | `ℚ(√1055)`, disc 4220 (every field of degree 3 or 4 fails at 2) | 31, 43, 47, 83 |
| 43 | `ℚ(√4703)`, disc 18812 | **43, 47, 79** |
| 47 | `ℚ(√2351)`, disc 9404 | 47, 67, 71, 83 |

**`ℚ(√4703)` has local bound ≥ 6 by certificate** — its only usable planes below 100 are 43 and 47 (floor six each) and 79
(≥ 7), and every plane from 98 up is ≥ 7 by Weil — so `L(ℚ(√4703)) ∈ {6, 7, 8}`, and **a six-colouring at 43 or 47 makes it
exactly 6**. The earlier searches were bounded to small radicands; `167 > 100`. **Both deciding planes are implausible on the measurements** (`data/fs53/CLOSE.md`, `data/fs53/README.md`): six at 47 needs the certificate to be 99.4 % tight, a tightness seen only at q = 7; at 43 every instrument came back empty — the independent set stuck at 258 against the 309 six needs through over three hours aimed at exactly that, the six-colour search stalled at 1,016 monochromatic edges for 2 h 52 m, the equivariant sweep 0 of 21. These are nulls at a budget, not refusals; but they mean these fields most likely have local bound ≥ 7, where the conjecture's bold form predicts seven, and their six rests on a plane the evidence argues against. The complete listing
(`tools/fs54_quadratic_fields.gp`, d ≤ 30,000) finds 16 such quadratic fields, **every one decided by 43 and/or 47** — so on
current evidence none of them is a six-field.

### 1.7 A cheap bound that does not work (recorded so nobody re-derives it)
Partitioning the plane into cosets of an `𝔽₃`-subspace `W` gives `α ≤ [V:W]·α(G[W])`. Every solid contains at most 5
directions and its induced graph has `α ≥ 27` (SAT, seconds), so the bound is ≥ 243. Every subspace contains large
unit-free subspaces; the partition bound is dead.

---

## §PA Prior-art gate (WORKFLOW 3a), 2026-09-16

**Named in the disciplines' words.** (i) algebraic graph theory: *finite Euclidean graph / unit-quadrance graph over `𝔽_q`,
chromatic number, independence number, prime power*; *integral Cayley graphs over abelian groups*. (ii) arithmetic
geometry / coding theory: *Kloosterman sums over `𝔽_{3^m}`, elliptic curves, value distribution*; *irreducible cyclic codes,
caps in `PG(5,3)`*. (iii) algebraic number theory: *residue fields, cubic fields, chromatic number of the plane over a
number field*.

**Found.**
* `[Moorhouse2010]` Table 6.1 stops at `q = 17` (it includes the prime powers 4, 8, 9, 16); **no value at 27**. Lemma 6.2(b)
  holds the odd-cycle / collinear-triangle mechanism.
* `[Krebs2022]` Thm 5.2 and §5.2: the clique number in every characteristic, the `p = 3` collinear case.
* `[Vinh2005]` (arXiv math/0510092; held): `q^{1/2}(1/2+o(1)) ≤ χ ≤ (p^n + p^{n−1})/2` for `q = p^n` — asymptotic, nothing at 27.
* `[BridgesMena1982]`; `[AhmadyBellMohar2014]` (arXiv:1307.6155, "Integral Cayley graphs and groups"): integrality.
* `[Moisio2008]` (arXiv:0706.2112): `#E(a) = 3^m + K(a)` for `y² = x³ + x² − a` (affine count; verified here in the
  projective form `t = −K`); Katz–Livné's value distribution (listing only).

**Not found** (searched, recorded as a finding): any computed `α` or `χ` of `UD(𝔽₂₇,2)`; any treatment of the plane over a
cubic field via its residue plane at 27; any use of Moisio's identity to explain a chromatic or independence bound.

**Bibliography keys owed today:** `[BridgesMena1982]`, `[AhmadyBellMohar2014]`, `[Moisio2008]`, `[KatzLivne1989]` (listing).
`[Vinh2005]` to be checked against the existing Vinh keys.

---

## §M The domain model (modeling pass, 2026-09-16)

**One representation replaces five instruments.** FS-53 searched with a free finder, rotation-order restrictions, line
quotients, subgroup-periodic sweeps and an antipodal sweep, and treated them as different tools. They are one object: **a
subgroup `H ≤ Aut(UD(𝔽₂₇,2))`, up to conjugacy, and the `H`-invariant independent sets (or `H`-equivariant colourings,
with a homomorphism `H → S_k` acting on colours)**. An `H`-invariant independent set is a set of `H`-orbits, none containing
an edge, pairwise non-adjacent, weighted by orbit size — a weighted independent set problem on the orbit graph. The free
search is `H = 1`; translations by an `𝔽₃`-subspace `W` are the periodic sweeps; rotation orders are cyclic subgroups of
`O(2,27)`; antipodal is `z ↦ −z`; Frobenius is `(x, y) ↦ (x³, y³)`. `Aut = 𝔽₃⁶ ⋊ G₀` with `|G₀| = 168` (nauty), and it is
solvable, so its subgroup classes are enumerable in GAP.
* **Why this is the intrinsic structure and the tool list was not:** the lattice is ordered (`H' ≤ H` ⟹ every `H`-invariant
  set is `H'`-invariant), so a refusal at `H'` covers every `H` above it, and **every set with a nontrivial stabiliser has a
  prime-order symmetry**. So the prime-order classes (orders 2, 3, 7 — `|Aut| = 2³·3⁷·7`) are the complete first layer:
  if none of them carries an invariant independent set of 122, **every 122-set is asymmetric**, and the free search is the
  only instrument left.
* **Where the evidence already sits in this model:** translations of order 9 and above are closed (§D2, exhaustive, best 117);
  KaMIS, knowing nothing of the group, returns a 117-set invariant under an order-9 translation on seven seeds out of seven.

**D4's symmetry group is the full `Aut`**, Frobenius included. FS-53's certificate used `O(2,27) × swap × S₃`, which gives
the same optimum but more variables. The size measure for pricing a level is **the number of `G₀`-orbits of independent
`k`-sets containing 0** — the variables that survive — never the raw matrix dimension.

**D5's antipodal quotient is the order-2 member of the same lattice, with a colour action.** One structural fact settles its
shape at 27: `z` and `−z` differ by `2z = −z`, so they are adjacent exactly when `z` is a unit vector. Hence in any colouring
with `c(−z) = τ(c(z))`, **every colour used on the unit circle is moved by `τ`**, and the colour of 0 is fixed. A `τ` fixing
several colours confines the unit circle to the moved ones.

**D7's kernel field is a concrete computable ring, not a library field.** `ZMod 27` is the wrong object; Mathlib's
`GaloisField 3 3` is a splitting field and does not compute; `AdjoinRoot` is a quotient the kernel cannot evaluate. The
representation is `ZMod 3 × ZMod 3 × ZMod 3` (coefficients of `1, t, t²`) with multiplication reduced by `t³ = t + 1`, its
`CommRing` laws and `IsField` discharged by `decide` over 27 elements — the fact "this is the field with 27 elements" placed
beside the type as theorems (`card = 27`, `IsField`), not inside it.

---

## §O The obligations (modeling pass, 2026-09-16): what is proved, what is tested, what is assumed

| claim | status | the local obligation that carries it |
|---|---|---|
| `λ_a = 3m_a − (q+1)/2` for `q = 3^f`, so every eigenvalue ≡ 1 (mod 3) | **[hand, general]** | one direction's contribution is 2 or −1 |
| `λ_min ≥ −8` at 27 | **[hand]** given Weil for these character sums (prior art) | the congruence and `2√27 < 11` |
| `λ_min = −8`, the multiplicities, `|Aut| = 122,472` | **[tools, exact]** | `tools/fs54_structure.py` (nauty for the group) |
| every edge in exactly one triangle, for every `q = 3^f`, `f` odd | **[hand, general]**; tested at 27 | a third point `w` needs `N(w) = 1` and `N(1−w) = 1`, i.e. `Tr w = 1`, so `w` is a root of `X² − X + 1 = (X + 1)²` |
| a field seeing 27 first with the wall broken has even degree ≥ 6 | **[hand]** | degree 2: residue degree ≤ 2; degree 4: a degree-3 prime above 3 forces a degree-1 one; odd degree: a ramified prime above 2 two-colours |
| every odd-degree real field is 2-colourable | **[hand]** (a corollary of GPT Astra's `χ = 2 ⟺ L = 2`, G55) | local degree odd at some prime above 2 ⟹ `F_𝔭(i)/F_𝔭` ramified ⟹ unit vectors ≡ 1 |
| inert residue graphs at 2 are 4-colourable | **[solver]** at Q ≤ 32 only; general Q a reading | CaDiCaL colourings, verified |
| `L(ℚ(√4703)) ≥ 6` | **[cert]** at 43, 47, 79; **[derived]** from 98 up (Weil); **[tools]** the usable list | a quadratic field's usable planes are primes; each is bounded separately |
| max over prime-order classes of the largest `H`-invariant independent set = max over independent sets with nontrivial stabiliser | **[hand]** | Cauchy: a nontrivial stabiliser contains an element of prime order; conjugating moves the set to the class representative without changing its size; and the GAP group equals `Aut` because its order is nauty's |
| a class's maximum (OPTIMAL) | **[solver]**, untrusted | CP-SAT; a refusal that matters is re-asked on CaDiCaL (orbit weights expanded as literal copies) before it is written as one |
| a found independent set | **[verified]** | `tools/fplane_review_verify.py indep`, sharing no code with any finder |

**Two statements were weaker than their proofs and are restated above:** the −8 no longer leans on Moisio (his identity is
the explanation, the congruence is the proof), and minimality no longer leans on a discriminant table (Minkowski covers
every degree ≥ 5).

---

## §D The deliverables, in order

### D1 — the Rust tools take a prime-power field (WO-21 to `ferrous-engineer`, `~/source/descent-engine`)
As the stub's D1, with these settled surface decisions:

| choice | alternative weighed | why | confidence |
|---|---|---|---|
| `--q 27` **requires** `--modulus`, and the refusal names the canonical one (`t^3-t-1`) so the next call succeeds | default the modulus silently | vertex numbering and both digests depend on the modulus; the Python tools refuse the same way, so the two toolchains stay one convention | high |
| `--p` stays, as an alias for `--q` on a prime | deprecate `--p` | every FS-53 run log and resume note uses `--p`; the prime path must stay byte-identical anyway | high |
| records carry `field: {q, p, f, modulus}` beside the existing `p` | only `q` | a record must be re-checkable from itself | high |
| rotation-order restriction divides `q + 1` (28 at 27: orders 1, 2, 4, 7, 14, 28) and the Frobenius is **not** added to the symmetry search in this order | add Frobenius-equivariant search now | keep D1 a pure field change whose prime path is provably unchanged; Frobenius restriction is D5's | medium — if D2's plateau suggests Frobenius-invariant sets, it becomes WO-22 |

Acceptance (each *seen*): prime path byte-identical at `--p 23` over the WO-19/20 fixtures; `--q 27 --modulus t^3-t-1`
reproduces `b15ae514…` in both digest conventions; a reducible modulus (`t^3-t`) and a wrong-degree one refused by name; the
self-test plants a wrong field multiplication and watches the hash control fire; `claim_scope` and `edges_sha256_rule` in
every record (owed since FS-53).

### D2 — the blank cell `α(27)`
1. **Exhaustive periodic sets** (`tools/fs54_periodic_alpha.py`, running at the opening): the largest independent set that is a
   union of cosets of an `𝔽₃`-subspace of dimension 4, 3, 2 — exact.
2. **KaMIS** (`~/source/KaMIS`, an outside finder, not ours): a first reading while D1 is built.
3. **The calibrated ladder** once D1 lands: free `plane-independent`; restricted to rotation orders 2, 4, 7, 14, 28; chained
   through `--start`; every set re-verified from the definition by `tools/fplane_review_verify.py indep`.

**Registered predictions (2026-09-16, before any of the three reports):**
* **P1** KaMIS's first reading lands in **[118, 132]**, point estimate 124. Both outside outcomes are reachable (anything from
  81 to 147 is a possible reading).
* **P2** the best subspace-periodic set is **108** (α of the 27-vertex quotient = 4); 135 has probability 0.25.
* **P3** the whole D2 ladder finds `α ≥ 122` — six becomes possible at 27 — with probability **0.55**.
* **P4** no search finds 146 (probability 0.9): five stays open from below as well as above.

**Scored so far.**
* **P2 WON exactly.** Exhaustive over every unit-free subspace (orbit-reduced, then every orbit's quotient α re-derived by
  CaDiCaL: SAT at α, UNSAT at α + 1, 0 mismatches over 36 + 282 + 143 orbits): dimension 4 → **81**; dimension 3 → **108**;
  dimension 2 → **117**. The unit-free counts 2,100 and 20,216 reproduce FS-53's colouring sweep (`data/fs53/periodic-q27.json`),
  an independent control. `data/fs54/periodic-alpha-q27.json`, `…-dim2.json`.
* **P1 LOST.** KaMIS's `redumis` reads **117 on seven seeds of seven** (22–32 s each; it converges and exits, so a budget is
  spent by reseeding), below the registered band [118, 132]; `online_mis` 104. Every one of the seven sets is invariant under
  an order-9 translation (seven different subgroups, none an `𝔽₂₇`-line) — the exhaustive periodic ceiling, reached by a
  finder that knows nothing of the group. Verified from the definition by `tools/fplane_review_verify.py indep` (exit 0) with
  a planted non-independent control rejected. `data/fs54/kamis-smoke/` (the environment agent's run).
* **Registered 2026-09-16, before `tools/fs54_symmetric_alpha.py` reports** (15 classes of prime-order subgroups from GAP:
  three of order 2 — the point reflection, 365 orbits, and two reflection classes fixing a line, 378 orbits; eleven of order 3
  — ten translation classes, 243 orbits, and a Frobenius-type class fixing 9 points, 249 orbits; one of order 7, 105 orbits):
  **P5** no prime-order class carries an invariant independent set of 122 or more — probability 0.6 (the informative
  outcome, a symmetric 122-set, is reachable: nothing here excludes it). **P6** the order-7 rotation class is the weakest,
  best ≤ 112, and is the one CP-SAT proves optimal inside its budget. **P7** at least one order-3 translation class reaches
  117 (forced: a 9-periodic set is 3-periodic under its subgroup's lines — a control, not a prediction).
* **Registered 2026-09-16, before they report: P8** the calibrated `plane-independent` ladder (after WO-21) also plateaus at
  **117** — probability 0.7; a set of 118 or more from it would be the first non-9-periodic record. **P9** if the D4 pricing
  agent's 4-point bound is computable at 27, its float value lands in **[138, 146]**, and it refuses five (< 146) with
  probability 0.35.
* **P5–P7 scored (all 15 classes, 180 s each, `data/fs54/symmetric/prime-order-alpha.jsonl`).** **P7 control passed**: three
  order-3 translation classes reach 117. **P6 WON**: the order-7 rotations are the weakest class, **106, proven optimal** by
  CP-SAT (solver's word) in 0.4 s. **P5 undecided**: no class found more than 117 (the point reflection and both line
  reflections 117, the Frobenius class 109), but every solver bound except order 7's is ≥ 132, so nothing at 122 is refused.
  **Every one of the fourteen 117-sets found by any method is 4-rigid**: maximal, with every outside vertex adjacent to at least
  4 of its points.
* **P8 scored: WON.** The ladder completed 2026-09-16T10:57 (`data/fs54/ladder/`): free-s1 117, rot2 117, rot4 117, rot7 106,
  rot14 99, rot28 85, line 81, free-s2 117 — every stage at or below 117, target 122 `not_found` throughout; free-s2's
  117-set re-verified from the definition (`tools/fplane_review_verify.py indep`, INDEPENDENT).
* **Reading, not a claim:** 117 is a strong attractor. If `α(27) = 117`, then `χ(27) = 7` exactly (`⌈729/117⌉ = 7` and a
  seven-colouring is known) and 27 leaves the window — but proving `α ≤ 121` is 26 integers below the converged certificate.

### D3 — structure: closed except the write-up
§1.1–1.4 are the answer. Remaining: grokking **G59 (characteristic 3)** and the multiplicity table as class numbers
(reading only; no claim without the paper).

### D4 — a relaxation strong enough to refuse five at 27, priced before anything runs
The triple-level certificate is converged at 147.577; refusing five needs < 146. A subagent prices the **next level of the
hierarchy on the full stabiliser** (order 168, the Frobenius included — the FS-53 certificate used only `O(2,27) × swap × S₃`,
which leaves the optimum unchanged but not the size): orbit counts, block sizes, memory, iteration cost on card A. **No
solve is launched before the price is on this page.** Gated on D2: if a search finds 146, five is possible and D4 is moot.

### D1 — LANDED 2026-09-16 (descent-engine `1908a8c`…`794c40f`, pushed)
Both tools take `--q 27 --modulus t^3-t-1`; the prime path byte-identical over 11 record pairs; both digests reproduced;
19 refusals by name; planted wrong multiplication caught; gate green; the prime hot path not slower. Records carry
`field: {q, p, f, modulus}` with top-level `p` the **characteristic** (3 at 27 — so a rebuild from `p` fails loudly instead of
building ℤ/27), both digests with their rules, and `claim_scope`. **The engineer's findings, credited:** the integer 1 is not
the field's 1 (at 27 the unit is element 9, and element 1 is `t²`), which no prime could reveal; and three defects in
`tools/fplane_review_verify.py` (a reducible modulus accepted, higher terms dropped in silence, plant B mislabelled), all
fixed. **D97, which bears directly on D5: `plane-colour` cannot find 7 or even 8 colours at 27 from a random start** (best 118
conflicts at k = 7, 41 at k = 8, while one thread finds 8 at 23 at once), though it repairs a damaged 7-colouring in 40
iterations. **So a `k = 6` null from this searcher at 27 is weak evidence even by the standard of its own k = 8 behaviour**, and
D5 must seed from structure (the 117-sets as a fixed class, the periodic 7-colouring) rather than from random starts.

### D4 — the reading, and what was decided (2026-09-16)
The pricing agent's report is `plans/FS54-D4-pricing.md`: Gvozdenović–Laurent–Vallentin `L₃` (orbits of independent sets
of size ≤ 4; 77,238 variables; 102 blocks of order 169–378), controlled at q = 7 (14.000 = α), q = 11 (28.07 ≥ 28), the
full-group triple level reproducing 147.5774 at 27, evaluation at 23 real sets exactly |S| with every block PSD, four plants
firing. Solved not by SCS (9.7 s/iteration on card A, >270 GPU-hours to FS-53's standard) but by an ADMM exploiting the
arrowhead structure of AᵀA (0.17 s/iteration on the CPU, 55× cheaper). **Reading at 8,000 iterations: certificate-shaped
N = 143.055** (P9's band [138, 146] — scored only when certified). **Decisions (PO):** (1) resume the 27 solve toward
convergence — approved and launched (pid 550586, resume line in `data/fs54/d4/runs/RESUME.md`); (2) the exact certificate
path (producer, standard-library checker, soundness page, controls) as a fresh work order from the pricing page as its
letter — spawned; (3) **47 next**: refusing six there needs only 0.76 % below the converged 371.84, which would take 47 out
of the window; priced at ~4 M variables, not yet run; (4) 23 after: five refused if N < 106 (2.35 %).

### D4 — LANDED: five colours refused at 27 (2026-09-16, commit `bacf4a4`)
**`α(UD(𝔽₂₇,2)) ≤ 141` [cert]** — `data/fs54/cert-q27-l3-N141.json`, N = 1415933445295268663/10¹⁶ ≈ 141.5933, CERTIFIED by
`tools/fs54_l3_cert_check.py` (standard library, exact; 28 s one process), **re-run by the PO: CERTIFIED, sha256
`1b6646e3…`**. 5 × 141 = 705 < 729, so **χ(Γ₂₇) ≥ 6**; with the verified 7-colouring, χ ∈ {6, 7}. The certificate agent's
controls: 21 of 21 as designed (flipped sign, non-PSD block, bumped Gram entry, filed against `t³−t−2` both with and
without the hash updated, N lowered by 10⁻¹²), canonical form against brute force (0 disagreements; firing with the
Frobenius dropped), expansion against the definition at the verified 117-set, the identity evaluated exactly at maximum
sets at 7, 11, 27. Small planes: N = 14.00000007 at 7 and 28.0715 at 11 — **so α(7) = 14 and α(11) = 28 are now
certified, not the solver's word**. **Credited findings of the certificate agent:** (i) the pricing page's "±1/√|Stab| bases,
no cosine rounding" is wrong because √2 is irrational — columns are integer ±1 orbit sums with √(stabiliser/group) folded
into the Gram factor; (ii) soundness needs only that each canonical form is an automorphic image of its set, so a faulty
canonicaliser can only refuse; (iii) the rounding loss is ~10⁻⁵ and the real cost is Σμ, the iterate's dual infeasibility —
10,089 its → 142.672, 16,611 → 141.593 (committed), 22,412 → 141.157 (scratch). **P9 scored: WON on the band** (float
≈ 141.2 ∈ [138, 146]) and the refusal, registered at probability 0.35, happened. **Doubt kept:** the checker imports field
arithmetic, the rational reader and the exact LDLᵀ from `tools/fplane_cert_check.py`; an independent fresh-eyes read of the
checker (not a re-run) has not been done and is owed before any outward claim beyond the wall document.

### §D4 at 47 — measured price (2026-09-16; a pricing work order, nothing solved)
**Why.** At 47 six colours need α ≥ 369 against the triple level's converged 371.409 (certified 371.84): a certificate-shaped
`L₃` value below 369 is a drop of **0.649 %** and would refuse six there (and prove W_f at 47). Records: `data/fs54/d4/q47/`
(scripts, logs, JSON); instance and checkpoint in `data/fs54/d4/ckpt/` (not committed). **Every number is a reading, a
size, a time or a control; none is a bound.**

**The instrument had to be rebuilt to reach 47** (`tools/fs54_d4_quad.py` `lean-*` subcommands). It uses the same functions
for the derivation (`canon`, `blocks_for`, `le_diag_rows`), but: the tables are built in forked workers, each block is
compressed to CSR inside its worker, V = −A is kept with int32 indices and no COO stage, the instance is cached on disk,
the ADMM's vector work runs in numba-parallel kernels, and the projection runs either in a CPU thread pool or on card A through `cusolverDnXsyevBatched`.

| measured at q = 47 | value |
|---|---|
| variables | **4,121,921** = 45 pairs + 8,625 triples + 4,113,251 four-sets; census **exact** at k = 2, 3, 4 (867,058,301,120 independent 4-sets) |
| d-classes | 46, each of size 48 (one is the unit circle) |
| PSD blocks | **462**: 93 × 529, 186 × 552, 93 × 576, 45 × 1,081, 45 × 1,128; 111,851,346 PSD rows; Σm³ = 1.843·10¹¹ (133× 27's) |
| constraint matrix | 115,973,267 rows × 4,121,921 columns, **701,212,581 nonzeros, 8.27 GiB** (int32); instance on disk 9.3 GB |
| build wall-clock (14 workers) | **96 s** (tables 63, blocks 26, assembly 1); process peak RSS 17.8 GiB, system use ≈ 19 GB. The first build took 787 s: 40,000 sets per canonical-form call is bandwidth-bound (152 k sets/s over 14 workers against 2.33 M/s at 1,000); rebuilt digests identical |
| ADMM setup | 180 s (load and digest check 6 s, transpose 11 s, G = VᵀV with 99.0 M nonzeros and the Schur factor 164 s); off-diagonal four-set coupling exactly 0; exact solve residual 2.2·10⁻¹³ |
| **s/iteration, CPU projector** (14 threads) | **7.01** = linear solve 0.47 + sparse products 2.08 + vector updates 0.41 + **projection 3.96** |
| **s/iteration, GPU projector** (card A; its 86–340) | **5.15** = 0.47 + 2.10 + 0.41 + **projection 2.09** (unpack 0.16, to device 0.13, **eigensolver 1.43**, reconstruction 0.24, from device 0.13, pack 0.10) |
| solve memory | ≈ 26 GB of system RAM; GPU 1.28 GiB buffers + 1.95 GiB eigensolver workspace; checkpoint 1.89 GB written in 1.4 s |

The pricing page's estimate held on sizes (46 classes, ~4 M variables, blocks to ~1,104) and was pessimistic on time
(10–15 s/iteration estimated; 7.0 s on the CPU, 5.15 s with the GPU).

**Controls.** (i) The lean path's data against `assemble_scs` at 11, 19, 27: same variable numbering, rows, cone, C, bs and
objective constant; entries agree to 2.2·10⁻¹⁶ (13/35/92 sums are exactly zero in one summation order and not the other).
Two planted faults fired: one block scaled by 1 + 10⁻⁹, and one dropped term. (ii) The lean y(S) matches the reference to
≤ 1.9·10⁻¹⁶ at 11 and 19. (iii) The lean ADMM matches the reference ADMM at 11: identical readings after 400 iterations,
and the same when the 400 are split 200 + 200 across a resume. (iv) **At 47, FS-53's verified 265-set gives objective
265.000000000, least eigenvalue −3.0·10⁻¹⁴ over all 462 blocks, and least y ≥ 0 slack 0**, computed from the assembled data
the solver uses. Two planted faults made blocks indefinite: "−−" without its four-set term (−0.960) and permuted four-set
values (−1.042). (v) The GPU projection matches the CPU projection to 3.4·10⁻¹⁵ on a real iterate. **Not run at 47:**
- **The triple-level value.** Its Y/MY blocks come from the functions that reproduced 27's triple value to 5·10⁻⁶. A
  triple-level ADMM at 47 would need more iterations than a control is worth.
- **Random maximal sets.** The 265-set is already not a maximum.

**The trajectory at 47 (340 iterations, stopped at a checkpoint).** The upper reading stays near 1 while the lower reading
climbs: 4.5 at 20, 11.6 at 86, 30.5 at 180, 98 at 274, 227 at 340. It grows ×1.8 per 47 iterations, the same rate as at 27,
but it starts lower, so 47's climb should end around iteration 380–450 (at 27 it ended at 216–264). Nothing about the
descent below the triple level has been measured at 47 yet.

**Calibration from zero on the same code** (`calib-q{11,19,23}.log`, `early-q27-calibration.log`, `trajectories.py`).
Crossings count the first report after each plane's peak at which the upper reading is that far below the triple level.

| q | n | peak | 0.65 % | 1 % | 2 % | last reading |
|---|---|---|---|---|---|---|
| 11 | 121 | 253 | 354 | 429 | 989 | 3.29 % below at 4,000 |
| 19 | 361 | 217 | 434 | 578 | 1,070 | 4.26 % at 4,000; certificate-shaped N 82.105 |
| 23 | 529 | 315 | 1,137 | 1,335 | 2,075 | 3.06 % at 3,500; **certificate-shaped N = 105.431** |
| 27 | 729 | 264 | 1,797 | 2,138 | 3,800 | 4.47 % at 25,671 |

N sits 0.10–0.19 % above the upper reading, so N falls below 369 somewhere between the upper reading's 0.65 % and 1 %
crossings. **Projection** (`projection.py`): scale the descent iterations (from each plane's peak) as a power of n, and add
47's estimated peak of 420.

| exponent source | projected iterations | wall-clock at 5.15 s/iteration |
|---|---|---|
| fit over all four planes | **≈ 6,400** | **≈ 9 h** |
| the last size step (23 → 27, exponent ≈ 1.9) | **≈ 13,600–15,800** | **≈ 20–23 h** |
| 11 → 19 | ≈ 3,750–4,300 | ≈ 6 h |
| 19 → 23 | ≈ 38,600–73,500 | ≈ 2.3–4.4 days |

**Confidence: low.** The fact that would settle it is 47's own descent: the upper reading about 1,000 iterations after its
peak, near iteration 1,450, roughly 2 h from the checkpoint. At that point 27 was 0.3 % below the triple level and 23 was
0.97 % below. Whether `L₃` at 47 goes below 369 at all is a separate question. Every measured plane dropped at least 3 %
(7 dropped only to α), so the answer is probably yes; confidence medium.

**The certificate step at 47 (estimated).** The checker is pure Python.
- Canonical forms: 115 M keys at a measured 5.4 µs each, about 10 CPU-min.
- Gram products and the pairing: scaled from 27, about 25–30 CPU-min.
- Total: roughly 40 min on one process, about 5 min on 14 jobs, a few GB per job. The file would be about 0.4 GB if the
  rank fraction matches 27's 10 %.

The producer, `tools/fs54_l3_cert_round.py`, rebuilds the instance through `Tables`/`assemble_scs`, whose COO assembly
is estimated at tens of GB. It has to be ported to the cached lean instance first: a few hours of engineering.

**Found on the way.**
- **At 23 the calibration iterate already reads N = 105.431 < 106.** Five colours at 23 need α ≥ 106. The checkpoint
  `ckpt/calib-q23.npz` is in the format the 27 producer reads, so an exact certificate that five colours are refused at 23
  looks about an hour away. It is a reading, not a bound.
- **31 is in reach of the same instrument for five:** it needs N < 193, 3.92 % below the converged 200.88. Measured drops
  range 3.1–4.5 %, and the size is about 7× 27's (estimated).
- **Moving the sparse products and vector updates onto a GPU** is estimated to take 5.15 s/iteration to about 2.7 s,
  halving any 47 run. Not built.

### §R Outside responses to the wall document (2026-09-16)
Kooshi relayed two responses to `reference/wall-at-six/WALL-AT-SIX.md`, credited to **GPT Astra** (OpenAI) per the standing
rule — the first written under the Poros procedure. Verbatim copies: `reference/wall-at-six/responses/`. **Every claim was
checked before any text changed**; the verdicts:

| claim | verdict | how checked |
|---|---|---|
| R1.a χ_f = n/α on a vertex-transitive graph; the reading χ = ⌈n/α⌉ is an extra rounding assertion | **correct**; our §5.1 leaned on the reading more than it said, and "at 19 c is above the window, so χ = 5" was a non-sequitur | derivation (standard) |
| R1.b Zhang Thm 1.8 (independence ratio of a direct product of vertex-transitive graphs is the max) and Zhu's fractional Hedetniemi ⟹ χ_f of a product of targets is the min ⟹ a composite target escapes W only through an integrality gap χ_f ≤ 6 < χ in a factor | **correct** — `[Zhang2012]` Thm 1.8 (arXiv v1) read in full: vertex-transitivity is the only hypothesis for the equality; `[Zhu2025]` Thm 2.4 restates `[Zhu2011]` for all finite graphs. The literature agent adds: Zhu's own weakening (one factor with χ_f > n suffices) is refuted and large-girth counterexamples exist, so "an integrality gap in some factor" is exactly the right quantifier and small clique number protects nothing | literature agent (papers read) |
| R1.c Hedetniemi is not open at 5–7 (Wrochna Cor. 4.3 at c = 6) | **correct, and more**: `[Wrochna2020]` Cor. 4.2 (PDF numbering; 4.3 on arXiv's HTML) covers every c ≥ 5, (6, 2, 4) meets its conditions literally; `[Tardif2023]` settles c = 4; H(n) holds for n ≤ 3 and fails for n ≥ 4, "completely solved" (`[Zhu2025]` §3). Our entry `[Tardif2022]` carried a wrong arXiv id (a physics paper) and the wrong year — re-keyed `[Tardif2023]` | literature agent (papers read) |
| R1.d "748.8 refuses nothing" at 67 is wrong: ⌊748.83⌋ = 748 < 749 | **correct**; `data/fs53/README.md` already said "clears by nothing at all" — the wall document mis-transcribed it | our records |
| R1.e "containing a six-chromatic graph ⟹ L ≥ 7 is a local–global gap" overstated; the bold form alone gives χ(ℝ²) = 7 via ℚ(√3,√7,√11), independent of W | **correct**; the same conflation sits in CLAUDE.md G56's closing sentence and Frontier item 11 | derivation |
| R1.f Slackness at six does not by itself prove "no forced pairs"; vacuous if no six-colouring exists | **correct**; the overclaim is also in CLAUDE.md G56 ("so over a field it seals the residue mechanism forces no pair"), contradicting G54's own "slack but gap-free is logically open" | G54 |
| R1.g the dispatch: a proof-logging threshold decision for 89 at Γ₂₃ | **declined, with the evidence the response asked for**: `data/fs50/race23/` — CDCL undecided at 900 s on six cardinality encodings at the easier size 106, and `nscale/` undecided even at sizes ABOVE the Hoffman bound 131.76; resolution does not see the spectral bound at 361+ vertices. The question itself (W_f) is adopted; its instrument is the level-3 relaxation, whose nearest member is 47 (0.76 %) | our records |
| R2.1 u + v = d, uv = d/d̄; char-2 Sidon; \|μ∩(d+μ)\| = 2·Tr(1/N(d)); triangle-free iff m even; K₄ = x + u𝔽₄ for m odd | **correct** — proof read; recomputed for m = 1..6 | `tools/fs54_wall_feedback_verify.py` A |
| R2.2 U₃₂: Tr_{E/𝔽₄} is a proper 4-colouring; least eigenspace = μ₃₃ (moment polynomial + Weil); every maximum independent set is an 𝔽₄-hyperplane (44); 11 colour partitions | **correct** — every step of the Fourier/Sidon argument read (the equation at a + b, the \|B\| ≤ 3 step, the coefficient equations, b/a ∈ 𝔽₄^×); moments re-derived by hand (991, 959, 63391; P gives 10r + r₁ = 15); finite instances recomputed | A |
| R2.3 λ ≡ 1 (mod 4) at Q = 64 ⟹ every binary codim-2 subspace holds ≥ 5 units; attained | **correct** — exhaustive minimum 5 recomputed | A |
| R2.4 a 6- or 7-colouring of U₆₄ has no period subspace of dimension ≥ 8; linear 8-colourings have quotient K₈ | **correct** (three-line proof: a colour class of size ≥ 3 in a cubelike graph spans an independent subgroup of order 4) | read |
| R2.5 inert towers: λ_min(G_j) = Q^{j−1} λ_min(G₁), degree Q^{j−1}(Q+1), Hoffman constant | **correct** — proof read (lifts along the tangent line; ≤ 2 surviving residue points odd, 1 in char 2; λ_min(G₁) ≤ −2 by an induced C₄); recomputed at q = 3 (levels 1–4), 7 (1–3), 11, 19, 23 (1–2), **27 over GR(9,3) (level 2: −216)**, and Q = 2 over ℤ₂[ω] (1–6). **Prior art in substance for odd prime Q**: `[MMST1998]` (read in full) does not state it, but Thms 2.1, 2.3/Cor 2.4 and 2.9/Cor 2.10 give it at once, with a sharper bound (< 2p^{r/2}) on the new eigenvalues; **new for Q = 27 (Galois rings) and even Q** | B; literature agent |
| R2.6 √3 ∈ F ⟹ 3 \| Q + 1 at an inert dyadic prime ⟹ U₆₄ unreachable | **correct** | read |
| R2.7 a CRT target with χ = 6 has a factor with residue size in {23, 27, 31, 43, 47, 59, 64, 67, 79, 83} | **correct** given the tower theorem, the product Hoffman bound (eigenvalues multiply) and the recorded low-Q colourings | derivation |

Negative controls for the verification script: a tower level with one unit point removed goes red (on the degree check —
a wrong-reason red, so a second plant perturbs the level-1 value and goes red on the eigenvalue comparison, its faithful twin
passing); a Q = 64 connection set with one unit swapped for a non-unit fails λ ≡ 1 (mod 4). The response's own appendix
script reproduces (`data/fs54/wall-feedback/responses-appendix-script.out`). **Latent defect found on the way:**
`tools/fs54_char2_spectra.py`'s irreducibility test compares x^{2^d} with x instead of taking a gcd, so a reducible modulus
such as quartic × sextic × quadratic would pass it; its records stand because it asserts |μ_{Q+1}| = Q + 1, which a product
ring fails, and λ_min(U₆₄) = −15 is now confirmed three ways.

**What changes in the milestone.** (1) The target statement becomes **W_f: α(U_Q) < Q²/6 at 23, 27, 31, 43, 47, 64** —
it proves W with no heuristic and closes the product hatch; its thresholds are 88, 121, 160, 308, 368, 682. (2) **47 is the
member where W_f is closest** (368 against the certified 371) and the level-3 relaxation moved 27 by 4.1 %, so the level-3
solve at 47 is the top compute item. (3) At 27 W_f needs 121 against 141 (14 %): out of the relaxation's reach; 27's
remaining question is the six-colouring (D5) or a structural bound. (4) The escape-hatch section of the wall document is
rewritten around the integrality gap and the tower theorem.

### §W Can the wall be proved? (assessment, 2026-09-16, on Kooshi's question)
**W is a finite statement**: every Q outside {23, 27, 31, 43, 47, 64} is settled, so W is six graphs with χ ≠ 6. Its
sufficient form W_f needs α ≤ 88, 121, 160, 308, 368, 682 there, against best certified 108, 141, 200, 365, 371 and
Hoffman 768 — drops of 18.5 %, 14.2 %, 20.0 %, 15.6 %, **0.76 %**, **11.2 %**. Level 3 has dropped 3.1–4.5 % below the
three-point bound on every plane measured, so **47 (level 3, measured 5.15 s/it, 9–23 h projected, low confidence) and
U₆₄ (a characteristic-2 three-point port) are in reach; 23, 27, 31, 43 are not, by any priced instrument**. Exact search is
no substitute: **KaMIS's exact `weighted_branch_reduce` on UD(𝔽₁₉,2) with unit weights (361 vertices) sat at 70 for 600 s**
(`build/fs54-exact/q19-bnr.log`), below the heuristic's 76 — it neither found the best set nor bounded anything; CDCL was
undecided at 23 even above the Hoffman bound (`data/fs50/nscale/`). **And no uniform bound can carry W**: a bound
α ≤ c·q^{3/2} proves W at 23 only with c < 0.799, but α(19) ≥ 76 already has c ≥ 0.918 — so any proof must use something
that changes between 19 and 23, or go member by member (Reading B of the wall document gains weight). **What W would not
give:** χ(ℝ²) ≠ 6 (that needs every field's true χ, i.e. the conjecture's bold form, which gives χ(ℝ²) = 7 on its own), and
nothing against a six-chromatic graph in a field whose local bound is ≥ 7 — the lower-bound hunt is untouched by W.

### D5 — the colour search goes non-periodic
Periodic six-colourings are already excluded at indices 9 and 27. After D1: `plane-colour --q 27 --k 6` seeded with D2's best
set as colour 0 (`--fix-class`), and an **antipodal-quotient finder** (G58's instrument redesign: search colourings with
`c(−z) = τ(c(z))`, `τ` an involution fixing a colour, on the 365 orbits). A six-colouring found is re-verified from the
definition before a word is written.

### D6 — fields: answered at the opening (§1.5–1.6); remaining is recording
Rewrite G56's field sentence, G57's triangle correspondence, `data/fs53/window.md`'s field column and
`data/fplane/map.md` in place (current state only), with the corrections credited to the complete search.

### D7 — the kernel sees the real `𝔽₂₇` (optional, after D2/D5)
`finitePlane 27` is `unitQuadrance (ZMod 27)` and **ℤ/27 is not 𝔽₂₇**. An `IdArith` instance for `𝔽₃[t]/(t³ − t − 1)` makes
`CayleyCert.sound` give `χ(UD(𝔽₂₇,2)) ≤ 7` in the kernel, and would promote any six-colouring D5 finds.
**Decision:** no skeleton now. Alternative weighed: a `sorry`-carrying skeleton today. Why: D7 has no consumer until D5 either
finds a six-colouring or stops, and a tracked `sorry` in the tree would sit through hours of measurement. Confidence: medium —
if D5 finds a six-colouring, D7 becomes the headline and opens with its skeleton at once.

---

## §S Runs, checkpoints and resume commands
| run | expected length | checkpoint | resume |
|---|---|---|---|
| `tools/fs54_periodic_alpha.py --dims 4 3` | minutes | none needed (< 15 min); output `data/fs54/periodic-alpha-q27.json` | rerun |
| KaMIS smoke (setup agent) | 5 min | none needed | rerun |
| D2 ladder, D5 colour search | hours | `plane-colour`/`plane-independent` rewrite their `--out` every tick and resume with `--start` (WO-19/20) | written into `data/fs54/runs/RESUME.md` **before** launch |
| D4 solve (if priced and approved) | hours | SCS chunked driver, `--scs-ckpt` **on a path that exists** | written before launch |
