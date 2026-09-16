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
contains √3 exactly when its usable planes have triangles" fails at 27**: the field in §1.5 is cubic, so contains no √3,
and its first usable plane is 27, which has triangles. The correct statement holds for usable `q` prime to 3. (G57's
Moser-spindle conclusion survives: 11 is a non-square in `𝔽₂₇`.)

### 1.5 D6 answered: the field that sees 27 — `tools/fs54_fields.gp` → `data/fs54/fields.out`
* **The stub's candidate `ℚ(√3, ρ)`, `ρ³ = ρ + 1`, is refuted**: its usable planes are 11, 23, 27, … — sealed at five by 11
  before 27 is reached.
* **The smallest field whose first usable plane is 27: the cyclic cubic field of conductor 13**, `x³ − x² − 4x − 1`,
  discriminant 169 = 13², totally real — the cubic subfield of `ℚ(ζ₁₃)`. Usable planes below 100: **27, 31, 47, 79, 83**; 2 is
  inert (the only conjugation-fixed prime above 2 has norm 8, so no four-colour bound). Its local bound is
  `min(χ(27), χ(31), χ(47)) ∈ {5, 6, 7}`. **Minimal over every number field**: a quadratic field cannot see `𝔽₂₇`, a quartic
  with a degree-3 prime above 3 also has a degree-1 prime there (3-colourable plane), `nflist` enumerates every cubic field
  completely, and every field of degree ≥ 5 has `|disc| > 169` by Minkowski's bound `(π/4)ⁿ(nⁿ/n!)²` (202.7 at n = 5,
  increasing in n).
* **So 27 is the window member seen first by the arithmetically smallest field** — root discriminant 5.5, against 25.8 for
  the smallest field that sees 23 first.

### 1.6 A correction to G56, `data/fs53/window.md` and `data/fplane/map.md`, found by the same complete search
Those files name biquadratic fields for 23, 31, 43, 47 and assert that one radicand cannot do it ("every minimal field
satisfying only the first condition has the wall standing … why these need two radicands"). **False**: quadratic fields
with the 2-adic wall broken see each prime member first —

| member | smallest by discriminant (degree ≤ 4, `|disc|` ≤ 20,000) | usable planes < 100 |
|---|---|---|
| 23 | `ℚ(√167)`, disc 668 | 23, 43, 59, 67, 71, 79, 83 |
| 31 | cyclic quartic `x⁴ − 30x² + 45`, disc 1125; quadratic `ℚ(√1055)`, disc 4220 | 31, 59 / 31, 43, 47, 83 |
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
| the conductor-13 cubic is the least-discriminant field whose first usable plane is 27 | **[hand]** for degrees 2, 4, ≥ 5 (residue degrees; Minkowski); **[tools]** for degree 3 (PARI's `nflist`, trusted as software) | per degree |
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
