# FS-66 — does the residue ceiling drop up the tower? Subplan

*Opened 2026-09-20. Planner: one Fable agent (this file's author); implementer: one Opus agent, briefed by the product owner
from this file, arriving with no conversation memory — **everything the implementer needs is here or at a path named here.**
The stub is `plans/STUB-residue-tower-drop.md`; the owner's notes are `data/fs66/owner/`; the planner's measurements are
`data/fs66/planner/` (its `README.md` is the record this file cites as §M). Read order for a cold reader: §0, §M, §S, §Q, then
the phase you were given in §H.*

---

## 0. What this milestone is, in plain language, and what changed on its first day

Every upper bound this project holds on the number of colours a plane over a number field `F` needs comes from one move: reduce
coordinates modulo a prime `𝔓` and colour the finite plane over the residue field. That uses the **first** residue level. Reduction
modulo `𝔓²`, `𝔓³`, … is a graph homomorphism too, into the unit-distance graphs `G_k = UD(ℤ/p^k, 2)` over the rings `ℤ/p^k`
(`p^{2k}` vertices, degree `p^{k−1}(p+1)`), and `χ(F²) ≤ … ≤ χ(G₃) ≤ χ(G₂) ≤ χ(G₁)`. The milestone asks whether any of those
inequalities is strict — whether the ceiling **drops up the tower** — starting with the pilot: *is `UD(ℤ/121, 2)`
four-colourable?* (level one at 11 needs five).

**The pilot was answered on day one, by the first direct ask made while pricing this plan (§M): no.** CaDiCaL refuses four
colours on `UD(ℤ/121, 2)` in 1.7 s; the refutation's core is a 1,115-vertex subgraph that four solver codebases refuse with no
symmetry breaking; the owner replicated it with a different encoder (0.97 s pinned, 56 s with no pin at all). Level three's
preimage of that core refuses too (135 s). So at 11 the ceiling does **not** drop at levels two or three — on solvers' words.
What is left, and what this plan is for: **(1)** turn level two's refusal into a kernel theorem; **(2)** decide the *whole*
tower at 11 by certifying a level-one inequality (§S4–S5) that, numerically, forbids four colours at every level at once;
**(3)** ask the rows that still bear on the local–global conjecture — 19 at four colours, 23 at five — in the order the owner
ruled (§Q); **(4)** record what the tower limit *is* (§S2: the clopen chromatic number of the `p`-adic plane) so the conjecture's
statement can be written correctly whichever way the remaining rows fall.

---

## §PA. The prior-art gate (WORKFLOW step 3a), run 2026-09-20 before any derivation

**Verdict: the question is posed in print twice and answered nowhere; the inequality chain is prior art; nothing found on the
chromatic number of `UD(ℤ/p^r, 2)` for `r ≥ 2`, nor on whether it can fall below level one's.** Found works are in
`BIBLIOGRAPHY.md` (§ A rows `[BardestaniMallahiKarai2017]`, `[BardestaniMallahiKarai2018]`; § C for the rest) with honest read
status. "Read first-hand" below means the planner read the named sections in the PDF today; everything else says what it is.

### PA.1 The object in the discipline's words, and the queries run

The recognition sentences (G46) that served as queries: *"the unit-quadrance (finite Euclidean) graph over the ring `ℤ/p^r`"*
(Medrano–Myers–Stark–Terras's name); *"the quadratic graph of an anisotropic form over a local field"* and *"the `p`-adic
Hadwiger–Nelson problem"* (Bardestani–Mallahi-Karai's names, found by this gate); *"a regular abelian cover (voltage lift) of a
Cayley multigraph"*; *"Cayley graph of a Galois ring / of the unit circle of `GR(p², 2)`"*; *"Borel / measurable / continuous
chromatic number of a Cayley graph of a compact group"*. **None of this project's coined words** (tower, ceiling, sealed, level)
was used as a query.

| item | what was done | result |
|---|---|---|
| 1–2, two disciplines | **Finite-ring Cayley graphs / association schemes:** zbMATH `(ab:"Euclidean graph*" \| ti:…) & ab:"ring*"` (7 hits), `ab:"finite Euclidean graph*" \| "unit-quadrance" \| "quadrance graph*"` (11), `ab:"Galois ring*" & (Cayley \| association scheme) & (chromatic \| independen* \| clique \| distance)` (1: Ito–Munemasa–Yamada 1991, characteristic 4, amorphous schemes — not ours), `unitary Cayley graph* & chromatic number` (13). **Non-archimedean / descriptive combinatorics:** `ab:"chromatic number" & (p-adic \| non-archimedean)` (3), `ti:"chromatic" & ti:(adic \| ultrametric)` (3, none relevant), `(Hadwiger–Nelson \| "chromatic number of the plane") & (adic \| valuation* \| "local field*")` (2), `("Borel" \| "measurable" \| "continuous") chromatic number & (adic \| profinite \| "compact group*")` (1). **Lifts and covers:** `ti:(lift* \| cover*) & ti:"chromatic number"` (12), `ab:"random lift*" & (chromatic \| independen*)` (16). Web: four phrasings of "chromatic number / unit-distance graph over `ℤ/p²` / `ℤ_n`", "`p`-adic Hadwiger–Nelson" | spectra of `UD(ℤ/p^r, n)` only (`[MMST1998]`, DeDeo 2003, `[Vinh2009]` — all Ramanujan-ness); **the `p`-adic problem found: `[BardestaniMallahiKarai2017]`** (PA.2); unitary Cayley graphs of finite rings are the neighbouring family where the answer is known and trivial (PA.4); lifts: PA.5 |
| 3, the question | "has anyone computed `χ` of `UD(ℤ/p²,2)`, or of `ℚ_p²`?" — searched as such in zbMATH (`ab:"unit distance graph*" & (ring* \| modulo \| residue)`: 1 hit, `[Ducz2026]`, already ours) and on the web | **posed, not answered**: `[Madore2015]` ¶1.5 (plain `χ(ℚ_p²)`), `[BardestaniMallahiKarai2017]` Question 1 (Borel). No value, no table, no bound beyond `O(p²)` and level one's |
| 4, outside arXiv | `[Moorhouse2010]` (unpublished draft, held) re-read §8–§9; the held Polymath16 thread text grepped for `p-adic`, `Hensel`, `prime power`, `mod 9/49` | Moorhouse §9 writes the bound with **prime-power ideals** `χ(K²) ≤ χ((O/B)²) ≤ min_j χ((O/𝔭_j^{e_j})²)` and remarks that every ideal he used was "either prime or the square of a prime ideal" (his Theorem 8.5, the ramified prime 2) — he never asks whether `e_j ≥ 2` beats `e_j = 1` at an odd prime. Polymath16 (D. Speyer, thread comment of 2018-05-03, held text): `8R`-periodic 4-colourings of the Moser ring that do not descend modulo `4R` — the 2-adic tower at a **fixed** colour count, which is FS-38's subject (row 67), not a drop |
| 5, citation walk of the posers | citing lists of `[Madore2015]`, `[BardestaniMallahiKarai2017]`, `[BardestaniMallahiKarai2018]`, `[MMST1998]` | Madore: 4 citing (Davies 2023, Krebs 2022, Exoo–Ismailescu 2018, Aggarwal) — none on `ℚ_p`. BMK 2017: 5 citing (Bulj–Kovač 2026, Kovač 2023, Davies 2023, and BMK's own two) — **opened Davies and Kovač: neither touches the anisotropic `p`-adic case** (grep for `adic`, `local field`: only the citation itself). BMK 2018: 5 citing (Davies–Hatzel–Yepremyan ×2, Das 2026, Nica 2023 — matrix-ring graphs). MMST 1998: 13 — spectra, integral distances, H. Tanaka, *Association schemes of affine type over finite rings* (2004; the scheme a triple-level SDP at level two would live in — listing only) |
| 6, open the neighbours | first-hand today: `[Madore2015]` ¶1.5, §3 (Props 3.2, 3.8, Rem. 3.6, ¶3.7); `[Moorhouse2010]` §8.4–§9; `[BardestaniMallahiKarai2017]` abstract, §1, §2 (Thms 2.2, 2.5), Lemma 3.3; `[BardestaniMallahiKarai2018]` §1 (Thm 1.8–1.11), §4 (Prop. 4.1–Lemma 4.4, proof of Thm 1.11); `[BardestaniMallahiKarai2020]` abstract and the introduction's paragraph on quadratic graphs | see PA.2–PA.3 |
| 7, two databases | OpenAlex against Semantic Scholar on the four posers | **they disagree, as usual**: BMK 2017 has 0 citing works in OpenAlex and 5 in Semantic Scholar; Madore 1 against 4; MMST 10 against 13. The Semantic Scholar lists were the ones opened. OpenAlex returned HTTP 503 on a third of requests today — retried, never read as a zero |
| 8, author listings in their vocabulary (zbMATH Open API) | complete listings: **Medrano** (4 entries), **Myers, Perla** (3), **Bardestani** (14), **Mallahi-Karai** (graph/colour subset, 5), **Madore** (13), **Moorhouse** (chromatic/plane subset, 9), **Krebs, Mike** 2015–2026 (18); subject-filtered: **Terras** (`graph*`, 1990–2012: 28), **Vinh** (`ring* \| chromatic \| colo*`: 24; `Z_ \| modulo \| residue`: 5) | the MMST lineage wrote on spectra, zeta functions and random walks over rings — **never a chromatic or independence number**. Vinh over rings: distance sets, sum–product, expanders (Hieu–Vinh 2013, Mich. Math. J. 62 — a reviewer's review: large subsets of `(ℤ/p^r)^n` determine all distances; a Hoffman-strength statement, weaker than what we hold). Bardestani–Mallahi-Karai: exactly three papers on the subject, all read (PA.2). Krebs: nothing over rings. Several zbMATH summaries are withheld by the API ("conflicting licenses") — BMK's among them, so their content was read from arXiv instead |

### PA.2 What is in print about the `p`-adic plane — read first-hand

* **`[Madore2015]` Proposition 3.8 states this milestone's chain verbatim:** for a valuation ring `A` with maximal ideal `𝔪` and
  fraction field `K`, if `z₁² + ⋯ + z_d² = 0` has no solution modulo `𝔪²` with some `z_i ∉ 𝔪`, then
  *"`χ(K^d) = χ(A^d) ≤ χ((A/𝔪²)^d) ≤ χ((A/𝔪)^d)`"*. He needs the `𝔪²` form at the prime 2 (where level one is isotropic) and
  never asks whether the last inequality is strict at an odd prime. ¶1.5 poses `χ((ℚ_p)²)` as a quantity worth asking for and
  records `χ((ℚ_p)²) ≤ χ((𝔽_p)²)` for `p ≡ 3 (mod 4)` (Rem. 3.6). **So "`χ(F²) ≤ χ(G₂) ≤ χ(G₁)`" is Madore's, not ours**, and the
  stub's §1 should cite it.
* **`[BardestaniMallahiKarai2017]`** (Israel J. Math. 217 (2017) 313–335; arXiv:1507.05300v4) define the *quadratic graph* of a
  form `Q` over a field (`u ~ w` iff `Q(u − w) = 1`) and prove (Theorem 1.1, arXiv p. 2): over a local field of characteristic
  zero *"`χ_Bor(QG_Q)` is finite if and only if `Q` is anisotropic"*. For anisotropic forms the proof is a box colouring (their
  Lemma 3.3, p. 7), which for `x² + y²` over `ℚ_p`, `p ≡ 3 (mod 4)`, gives `χ_Bor = O(p²)` — level one's trivial `p²` colours.
  Then, p. 2, verbatim: ***"Question 1 (The p–adic Hadwiger-Nelson problem). Is it true that there exists a universal constant
  `B` (independent of `p`) such that `χ_Bor(QG_{ℚ_p}) ≤ B`, holds as `p` ranges over all primes of the form `4k + 3`?"*** Their
  tool for lower bounds is Theorem 2.5 (p. 5; credited to Bachoc–DeCorte–de Oliveira Filho–Vallentin, our `[BachocEtAl2014]`):
  *"Let `F` be either `ℝ` or a `p`-adic field `ℚ_p` and let `S` be a bounded, symmetric … Borel measurable subset of `Fⁿ` which
  does not contain the origin in its closure. Then for any symmetric, finite Borel measure `μ` on `Fⁿ` with support contained in
  `S` we have `1 − sup_u μ̂(u) / inf_u μ̂(u) ≤ χ_Bor(Cay(Fⁿ, S))`."* They use it only for isotropic forms. **No exact value and no
  lower bound for any anisotropic `p`-adic plane is stated.** §S3 below argues their Question 1 has a negative answer by their
  own Theorem 2.5 — hand-grade, offered to the owner to check, **not claimed**.
* **`[BardestaniMallahiKarai2018]`** (J. Combin. Theory A 160 (2018) 202–216; arXiv:1511.02427v3) treat the *isotropic* sibling
  over rings: the hyperbola graph `HG(R) = Cay(R², {xy = 1})`. Lemma 4.3 (p. 8) is the tower's monotonicity in their setting
  (*"`χ(HG(R)) ≤ χ(HG(R/𝔞))`"*); Theorem 1.11 is `√p/4 ≤ χ(G₂(ℤ/p^r)) ≤ 8(p+1)` for the `SL₂` non-singular graph, by Hoffman's
  bound with the Estermann–Weil estimate for Kloosterman sums modulo `pⁿ` — **a level-independent floor, the same shape as our
  G54**, and no question about whether `χ` moves with `r`. `[BardestaniMallahiKarai2020]` (J. Anal. Math. 142) restates the
  dichotomy and turns to unbounded algebraic sets; nothing on the anisotropic case.

### PA.3 The neighbouring family where the answer is known, and why it says nothing here

The **unitary Cayley graph** of a finite ring (`x ~ y` iff `x − y` is a unit; Klotz–Sander 2007, Akhtar et al. 2009 — listings
and summaries only, the statement recalled and not re-read): over a local ring it is complete multipartite with the cosets of
the maximal ideal as parts, so its chromatic number is the residue field's size at every level — the tower is constant for the
trivial reason that the connection set is a union of cosets of `𝔪` (a full blow-up). Ours is the opposite extreme: `S₂` meets
each coset of `𝔪` in a line of `p` of its `p²` points, a `1/p` fraction (§S1).

### PA.4 Lifts and covers: drops are possible in general, and a random lift would not drop

`G₂` is a regular cover, with group `(ℤ/p)²`, of the **multigraph** `p·G₁` (each level-one edge `p` times). The discipline's
results, from reviews and summaries only (none of these papers was opened): Amit–Linial–Matoušek 2002 (reviewer's review,
zbMATH 0993.05071) — a random lift's chromatic number is at most the base's and at least of order `√(χ/log χ)`, with examples
where it equals the base's and examples where it is `O(χ/log χ)`; Farzad–Theis 2012 — random lifts of `K₅ ∖ e` are 3-colourable;
Nir–Pérez-Giménez (arXiv:2109.13347, authors' summary) — a random lift of a `d`-regular graph has `χ ∈ {k, k+1}` with `k` least
such that `d < 2k log k`; Chen–van der Holst–Luo–Ma (arXiv:2608.02934, abstract) — the *spectrum* of chromatic numbers over all
`ℓ`-fold cyclic covers of a multigraph with `χ ≥ 3` contains every integer from 3 to `χ`. **Reading:** cover theory puts no
obstruction in the way of a drop; but a *random* cover of a 132-regular base would have `k ≈ 22`, so the base's 5 binds and
nothing drops — a four-colouring of `G₂(11)` could only have come from the algebra. It did not (§M).

### PA.5 Negatives, recorded as findings (each measures its query's words, G21)

Nothing found under any of: chromatic or independence number of `UD(ℤ/p^r, 2)`, `r ≥ 2`; chromatic number of a Cayley graph on
a Galois ring's unit circle; Borel, measurable or continuous chromatic number of a Cayley graph of `ℤ_p^n` or of a profinite
group, beyond BMK; any lower bound for `χ(ℚ_p²)`; any statement that the `p`-adic plane needs as many colours as its residue
plane (the stub's closing condition — **not met, the stub does not close as prior art**). Not searched: MathSciNet (no access);
Russian-language literature beyond zbMATH's coverage; the Geombinatorics archive (no index reaches it — `BIBLIOGRAPHY.md` § R).

### PA.6 What the gate taught us about our own object (WORKFLOW step 9's sweep, done at the opening)

1. **The tower limit has a name: `lim_k χ(G_k)` is the *clopen* (continuous) chromatic number of the `p`-adic plane**, and it
   sits in a chain with two literatures' quantities on either side — `χ(F²) ≤ χ(ℚ_p²) = χ(ℤ_p²) ≤ χ_Bor(ℤ_p²) ≤ χ_clopen(ℤ_p²) =
   lim_k χ(G_k) ≤ χ(G₁)` (§S2). FS-66 measures the last two links; the local–global conjecture lives at the first. A repaired
   conjecture, if one is ever needed, is a statement about `χ(ℤ_p²)`, and BMK's Question 1 is the literature's handle on it.
2. **The independence ratio up the tower is the `p`-adic analogue of the density of 1-avoiding sets**: `lim_k α(G_k)/p^{2k}` is
   the supremum of Haar densities of measurable independent sets of `ℤ_p²` (§S2), the quantity `m₁(ℝ²)` is for the real plane
   (`[AmbrusEtAl2023]`, `[KMOR2016]`) — so `tools/fplane_lp.py`, which ports that literature's linear programme to a finite
   plane, was already the level-one shadow of a `p`-adic instrument.
3. **Our graphs are BMK's quadratic graphs**, and our finite-plane spectral floor (G44, G54) is their Theorem 2.5 applied to the
   Haar measure of the norm-one group — which is how their Question 1 appears to answer itself (§S3).
4. **`G₂` is a regular abelian cover of the multigraph `p·G₁`**, and between two adjacent fibres it is `p` disjoint copies of
   `K_{p,p}` (§S1; found independently by the owner the same day). In that discipline's terms the milestone asks where one
   specific *algebraic* cover sits in the "spectrum of chromatic numbers of covers".
