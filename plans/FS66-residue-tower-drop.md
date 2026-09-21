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
| 1–2, two disciplines | **Finite-ring Cayley graphs / association schemes:** zbMATH `(ab:"Euclidean graph*" \| ti:…) & ab:"ring*"` (7 hits), `ab:"finite Euclidean graph*" \| "unit-quadrance" \| "quadrance graph*"` (11), `ab:"Galois ring*" & (Cayley \| association scheme) & (chromatic \| independen* \| clique \| distance)` (1: Ito–Munemasa–Yamada 1991, characteristic 4, amorphous schemes — not ours), `unitary Cayley graph* & chromatic number` (13). **Non-archimedean / descriptive combinatorics:** `ab:"chromatic number" & (p-adic \| non-archimedean)` (3), `ti:"chromatic" & ti:(adic \| ultrametric)` (3, none relevant), `(Hadwiger–Nelson \| "chromatic number of the plane") & (adic \| valuation* \| "local field*")` (2), `("Borel" \| "measurable" \| "continuous") chromatic number & (adic \| profinite \| "compact group*")` (1). **Lifts and covers:** `ti:(lift* \| cover*) & ti:"chromatic number"` (12), `ab:"random lift*" & (chromatic \| independen*)` (16). Web: four phrasings of "chromatic number / unit-distance graph over `ℤ/p²` / `ℤ_n`", "`p`-adic Hadwiger–Nelson" | spectra of `UD(ℤ/p^r, n)` only (`[MMST1998]`, DeDeo 2003, `[Vinh2009]` — all Ramanujan-ness); **the `p`-adic problem found: `[BardestaniMallahiKarai2017]`** (PA.2); unitary Cayley graphs of finite rings are the neighbouring family where the answer is known and trivial (PA.3); lifts: PA.4 |
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

---

## §G. Words this plan uses (the repository's own vocabulary — G-numbers, ledger rows — is in `CLAUDE.md`, which you have)

| word | meaning here |
|---|---|
| **owner** | the product owner: the session that briefs, reviews by artifact and rules on proposals. **planner**: this file's author. **implementer**: you |
| **`G_k`, level `k`** | `UD(ℤ/p^k, 2)`: points `(a, b)` with coordinates modulo `p^k`, two points adjacent when the squares of their coordinate differences sum to 1. Level one is the finite plane over `𝔽_p` |
| **the tower, the ceiling** | the chain `… → G₃ → G₂ → G₁` of reductions, each a graph homomorphism, so `χ(G_{k+1}) ≤ χ(G_k)`; "the ceiling drops" means some inequality is strict |
| **fibre** over a level-one point `x` | the `p^{2(k−1)}` points of `G_k` that reduce to `x`; no two are adjacent |
| **pulled back** | a colouring or set of `G_k` that depends only on the level-one reduction: whole fibres, one colour each |
| **direction class / tangent line** | §S1: the `(p+1)/2` classes `±s̄` of level-one unit vectors; the lifts of `s̄` differ along the line of direction `i·s̄` in the fibre |
| **biclique encoding** | the owner's CNF for level two: one "line" variable per (fibre, direction class, line, colour), so each `K_{p,p}` costs one clause per colour instead of `p²` |
| **pin** | unit clauses fixing the colours of a clique — sound only because the clique's vertices are pairwise adjacent *in the graph being asked* |
| **core** | the vertices and edges a refutation actually uses (read off its LRAT proof by backward reachability); a core that refuses refutes every graph containing it |
| **fibre density `φ`**, **`B₁(p)`**, **budget**, **cuts** | §S4–S5: the share of each fibre a set fills; the largest total `Σφ` the level-one inequality allows; `c·p²` in the owner's four-class form; the linear inequalities from subgraphs that lift |
| **trust word** | the closed list in §D saying what a verdict rests on: a verified colouring, a solver's refusal, the checker's `CERTIFIED`, or the kernel |

---

## §M. What has been measured (2026-09-20; records: `data/fs66/planner/README.md`, `data/fs66/owner/`)

*Machine: the desktop (16 physical cores / 32 threads, 125 GB; graphics card A + graphics card B). Every time below is one
single-threaded run on a quiet machine unless it says otherwise — a price, not a benchmark. Every verdict is a **solver's word**
unless marked; nothing here is kernel-checked.*

| # | what was asked, of which graph, by which tool | result |
|---|---|---|
| M1 | 4-colourability of **all of `UD(ℤ/121, 2)`** (14,641 vertices, degree 132, 966,306 edges; plain encoding, a triangle pinned; `fs66_planner_ask.py 11 4`) | **UNSAT, 1.7 s, 1,535 conflicts, 1.1 GB.** Owner's replication with a different encoder (bicliques): UNSAT 0.97 s / 1,279 conflicts pinned; **UNSAT 56 s / 83,102 conflicts with no pin** |
| M2 | the refutation's LRAT core, iterated to a fixpoint (`fs66_planner_core.py`, `fs66_planner_shrink.py`) | 2,713 vertices / 12,914 edges at round 0 → **1,115 vertices / 4,405 edges** after 13 rounds (LRAT 716 KB text). Every core edge re-verified from the definition; **glucose4, minisat22, cadical153, maplechrono each refuse the bare edge list, no pin** (0.8–5.2 s); the same list 5-colours |
| M3 | 5-colourability of all of `UD(ℤ/121, 2)`, same pipeline, **not handed the pulled-back colouring** | SAT in 251 s (572,161 conflicts); class sizes 2632, 2701, 2743, 3259, 3306 — not pulled back; **VERIFIED by `tools/fs66_owner_verify.py`** (all-pairs sweep, shares no code with the asker) |
| M4 | controls at 7 (`fs66_planner_ask.py 7 3`, `7 4`): truth is UNSAT, SAT | UNSAT 0.0 s; SAT 0.1 s with a verified non-pulled-back colouring (543, 603, 624, 631) |
| M5 | 4-colourability of the two types of **1,331-vertex periodic quotient** of `UD(ℤ/121,2)` (by an order-11 translation subgroup: tangent type, degree 112; other type, degree 132) | both UNSAT in 0.1 s (185, 188 conflicts); tangent type 5-colours in 0.4 s |
| M6 | 4-colourability of **`UD(ℤ/1331, 2)` induced on the preimage of M2's core** (134,915 vertices, 16,457,815 edges; plain encoding, triangle pinned; `fs66_planner_level3.py`) | **UNSAT, 135 s, 12,311 conflicts, 11.0 GB** — one solver, no proof kept |
| M7 | spectra by FFT from the definition (`fs66_planner_g2.py`; the owner's `depth-spectrum.out` agrees) | level two's eigenvalues on level-one characters are exactly `p·λ₁`; all others lie in `[−2p, 2p]` (−21.9926 at 11); Hoffman's ratio is equal at both levels (0.2855 at 11, 0.2756 at 19, 0.2491 at 23, 0.3597 at 7) |
| M8 | the **single-class fibre-density problem** `B₁(p)` (§S5), local maxima by SLSQP (`fs66_planner_single_class.py`; owner's `alpha-fuzzy.out`) | 7: 14.0000 = `α(G₁)`; 11: **28.0000 = `α(G₁)`**, max = median (40 and 200 starts), best point pure; owner: 19 → 76.0000, 23 → 87.51 (fractional edge-like pairs, which §S5's cuts remove) |
| M9 | **certifying `B₁`** by spatial branch and bound (Gurobi 13.0.3 size-limited licence, 4 threads; scratch script, recipe in §I3) with the edge/triangle cuts and sound symmetry breaks | **(7, three colours) LANDS: bound 16.165 < 16.333 in 300 s** (bare problem: 19.95 after 240 s; cuts only: 18.04). **(11, four): after 420 s the bound is 35.88 against the 30.25 needed**, 39,720 open nodes and growing, falling ≈ 0.1 per minute and slowing |
| M10 | the largest subset of one fibre `AG(2, p)` with at most `b` lines used in each tangent parallel class (`fs66_planner_proj.py`, HiGHS) | 7: exactly 5 (`b = 3`), 9 (`b = 4`); 11: ≥ 10 (`b = 5`, dual bound 17), ≥ 14 (`b = 6`, dual bound 35), not closed in 120 s — against 30.25 points per fibre needed on average for four colours |
| M11 | 4-colourability of all of **`UD(ℤ/361, 2)`** (130,321 vertices, degree 380; the owner's biclique encoder, 795,644 variables, 5,617,523 clauses, **an edge pinned and nothing else** — `ω = 2` at 19) | **UNKNOWN at the 900 s limit: 165,454 conflicts, 1.19 GB**; one run, exit status read from the solver. Level one's `(19, 4)` time under the same breaks was not measured first — Phase 3a's opening step |

**What M1–M6 establish, in one sentence each.** `χ(UD(ℤ/121, 2)) = 5` on five solvers' words and two encoders: **at 11 the
ceiling does not drop at level two.** `χ(UD(ℤ/1331, 2)) = 5` on one solver's word: nor at level three. No 4-colouring of level
two is periodic under any order-11 translation. None of it is a certificate; Phase 1 makes level two one.

---

## §S. Structure — the derivations the plan rests on, each with its status

### S1. Level two is `(p+1)/2` cyclic coordinates; between adjacent fibres it is `p` copies of `K_{p,p}` [hand; checked exhaustively at 7 and 11 by the owner's encoder, 0 failures]

Write `R = ℤ/p²`, `R[i] = R[x]/(x²+1)` (a Galois ring), points `u = a + bi`, `S₂ = {s : s·s̄ = 1}`, `|S₂| = p(p+1)`. Reduction
`S₂ → S₁` is onto with kernel `{1 + p·i·c : c ∈ 𝔽_p}`, so the lifts of `s̄ ∈ S₁` are `s(1 + pic) = s + p·(i s̄)c`: **a line of
direction `i·s̄` in the fibre `𝔽_{p²}`**. Let `s_j` (`j = 1 … (p+1)/2`) represent `S₁/±`. For `w ∈ R[i]` put
`ν_j(w) = Re(w·s̄_j) ∈ ℤ/p²` and `τ_j(w) = Im(w·s̄_j) mod p`. Then

> **`u ~ v` in `UD(ℤ/p², 2)` ⟺ for some `j`: `ν_j(v − u) = ±1` and `τ_j(v − u) ≡ 0 (mod p)`.**

(`w = ±s_j(1+pic)` gives `w s̄_j = ±(1 + pic)`; conversely `w s̄_j = ±1 + p·i·c′` has norm 1.) *Intrinsically:* for each direction class `σ ∈ S₁/±` let `L_σ = p·(i s_σ)·𝔽_p` and `Λ_σ = R[i]/L_σ ≅ ℤ/p² × ℤ/p`; then
`u ~ v` iff the images of `u, v` in some `Λ_σ` differ by `±s_σ` — `(ν_j, τ_j)` are coordinates on `Λ_σ`, and the choice of
representatives and lifts is incidental. **The same holds between any two consecutive levels** (the kernel of
`S_k → S_{k−1}` is `{1 + p^{k−1}·i·c}`, a line), but *not* between level `k ≥ 3` and level one, where the lifts of `s̄` form a
curve, not a coset — which is why the model that is generic in `k` is the fibre density over level ONE (S4), the only
finite base every level shares. So each point has `(p+1)/2`
coordinates `(ν_j, τ_j)`, each living on one of `p` cycles of length `p²`, and two points are adjacent iff some coordinate moves
one step along its cycle. Consequences: (a) between the fibres over adjacent `x, y = x + s̄_j` the graph is `p` disjoint `K_{p,p}`
(lines of direction `i s̄_j` over `x`, each completely joined to one line over `y`) — **966,306 edges = 7,986 bicliques at 11**,
which is the owner's tenfold-smaller encoding; (b) in direction `j` the level-one `p`-cycle `x, x+s̄_j, …` unrolls into
`p²`-cycles — the one family of level-one odd cycles that does **not** lift (holonomy 1), and the only place a level-two gain can
live; every closed walk of `G₁` using two or more directions lifts to a closed walk of the same length (one free parameter `c`
per step, and two directions span the fibre); (c) an independent set is a choice, per direction, of a set of lines with no two
consecutive on their cycle, and a point is usable iff all `(p+1)/2` of its lines are chosen — so a fibre's usable points are an
intersection of line-unions in `(p+1)/2` directions, and M10 says how small that is when the directions are balanced (≤ 17 of
121 with five lines each; four colours need 30.25 on average).

### S2. What the tower's limit is [hand]

A finite clopen (locally constant) colouring of the compact group `ℤ_p²` is constant modulo `p^k` for some `k`, and every edge of
`G_k` lifts to an edge of the `p`-adic graph (Hensel on `a² + b² = 1` at a unit), so such a colouring is exactly a proper
colouring of some `G_k`. Hence

> `χ(F²) ≤ χ(ℚ_p²) = χ(ℤ_p²) ≤ χ_Bor(ℤ_p²) ≤ χ_clopen(ℤ_p²) = lim_k χ(G_k) ≤ χ(G₁)` for `F ⊂ ℚ_p`, `p ≡ 3 (mod 4)`.

(The first equality is `[Madore2015]` Prop. 3.2: unit vectors are integral, so components are cosets of `ℤ_p²`.) **FS-66
measures the last two links; the local–global conjecture lives at the first.** The plain link can be strict for the reason G45
gives: a finite subgraph of `G_k` extends to `ℤ_p` only if it is a shadow. Likewise for densities: if `I ⊆ ℤ_p²` is measurable
and independent, the cosets of `p^k ℤ_p²` that `I` more than half fills form an independent set of `G_k` (if two such cosets
were adjacent, Fubini over the lifts of the connecting unit vector gives an edge inside `I`), and by Lebesgue density their
share tends to `I`'s measure; conversely independent sets pull back. So

> **`sup {Haar measure of a measurable independent set of ℤ_p²} = lim_k α(G_k)/p^{2k}`** — the `p`-adic analogue of `m₁(ℝ²)`.

### S3. `[BardestaniMallahiKarai2017]`'s Question 1 appears to answer itself — for the owner to check; NOT claimed [hand]

*Exact statements quoted in §PA.2 (Question 1: arXiv v4 p. 2; Theorem 2.5: p. 5).* **Which chromatic number:** the Borel one —
the bound below is Hoffman's for Haar-measurable independent sets and says nothing about the plain `χ(ℚ_p²)`. **Argument.** Let
`S = {(a, b) ∈ ℤ_p² : a² + b² = 1}`, `p ≡ 3 (mod 4)`: compact (the form is anisotropic), symmetric, Borel, `0 ∉ S̄`, so Theorem
2.5 applies to the Haar probability measure `μ` of the compact group `S` (the norm-one group of `ℤ_p[i]`). For a frequency `u`
of exact level `k` (`u ∈ p^{−k}ℤ_p² ∖ p^{−(k−1)}ℤ_p²`, modulo `ℤ_p²`), `μ̂(u) = λ_u(G_k)/|S_k|`: the normalised eigenvalue of
`G_k` at the character `u`. By `[MMST1998]` (Thm 2.3 / Cor. 2.4 for inherited characters, Thm 2.9 / Cor. 2.10 for new ones — as
recorded in `BIBLIOGRAPHY.md`; the planner re-checked the consequence by FFT at levels 2 of 3, 7, 11, 19, 23, and the owner at
level 3 of 3 and 7) every new eigenvalue at level `k ≥ 2` has modulus at most `2p^{k/2}` against degree `p^{k−1}(p+1)`, i.e.
normalised modulus `≤ 2/(p+1)`, while level one's least is `λ_min(G₁)/(p+1)` with `|λ_min(G₁)| ≤ 2√p` (Weil, `[MMST1996]`). So
`sup μ̂ = 1`, `inf μ̂ = λ_min(G₁)/(p+1)`, and

> `χ_Bor(QG_{ℚ_p}) ≥ 1 + (p+1)/|λ_min(G₁)| ≥ 1 + (p+1)/(2√p) > √p/2 → ∞` — **no universal bound `B` exists; Question 1's
> answer is no.** At `p = 11` the bound reads `1 + 12/4.7958 = 3.502`, so `χ_Bor(ℚ₁₁²) ≥ 4` — below what the tower gives (5 at
> every level asked), as Hoffman is below the truth at level one.

**What to check before it goes anywhere:** that Theorem 2.5's hypotheses are met verbatim (they are stated for `ℚ_p`; `S ⊂ ℤ_p²`
is bounded); that `μ̂(u)` for `u ∉ ℤ_p²`'s dual normalisation is the eigenvalue as claimed (their character is the Tate character
`ψ(x) = exp(2πi·{x}_p)`, p. 4); `[MMST1998]`'s bound first-hand (our row says a literature agent read it in full — G50). No
citing work addresses it (§PA item 5). If it stands it is a `CLOSED-QUESTIONS.md` entry of the small kind: their question, their
theorem, a finite-field estimate they cite elsewhere.

### S4. The fibre-density inequality [hand; the owner's, `data/fs66/owner/note-2026-09-20-fibre-density.md` §2; re-derived line by line by the planner — it is right]

For an independent set `I` of `G_k` (`k ≥ 2`) let `φ(x) ∈ [0,1]` be the share of the fibre over `x ∈ G₁` that `I` fills.
`1_I = Pφ + g` with `g` orthogonal to fibre-constant functions; `A_k` preserves both parts (they are sums of character
spaces); `⟨Pφ, A_k Pφ⟩ = p^{3(k−1)}⟨φ, A₁φ⟩`; `‖g‖² = p^{2(k−1)}Σφ(1−φ)`; `⟨g, A_k g⟩ ≥ −c·p^{k−1}‖g‖²` with
`c = c(p) = −λ_min(level two, new characters)/p < 2` (1.999326 at 11, 1.995891 at 7, 1.999924 at 19). Independence is
`⟨1_I, A_k 1_I⟩ = 0`, so

> **`⟨φ, A₁φ⟩ ≤ c·Σ_x φ(x)(1 − φ(x))`** for every independent set of every level `k ≥ 2`; and for an `m`-colouring, with
> `Φ` the row-stochastic `p² × m` matrix of class densities, **`tr(Φᵀ(A₁ + cI)Φ) ≤ c·p²`**.

Necessary, never sufficient. The planner had the same inequality with constant 2 before the note arrived; `c` is the sharp form.
**Dependence to keep visible:** "the same `c` serves every level" rests on `[MMST1998]`'s bound for deeper characters (FFT-checked
to level 4 at 3, level 3 at 7, level 2 at 11); at level two alone it is the FFT's exact number.

### S5. The single-class problem `B₁(p)` and the cuts [hand + numerics; reached independently by the owner and the planner]

> **`B₁(p) := max Σφ` over `φ ∈ [0,1]^{p²}` with `φᵀ(A₁ + cI)φ ≤ c·Σφ`** bounds `α(G_k)/p^{2(k−1)}` for every `k ≥ 2`; **if
> `m·B₁(p) < p²`, no level of the `p`-adic tower is `m`-colourable.** At 11 with `m = 4`: need `B₁ < 30.25`; found 28.0000 (M8).

*Valid linear cuts at every level (the owner's argument, which generalises the planner's level-two product bound):* if a
subgraph `K ⊆ G₁` **lifts** to `G_k` (a section that is a homomorphism), its translates by the kernel `p(ℤ/p^k)²` partition the
fibres over `K` into disjoint copies of `K`, so `Σ_{x∈K} φ(x) ≤ α(K)`. Edges lift; triangles lift (Hensel); odd cycles using two
or more directions lift (S1(b)). So `φ_x + φ_y ≤ 1`, `φ_x + φ_y + φ_z ≤ 1`, `Σ_C φ ≤ (ℓ−1)/2`. The single-direction `p`-cycles
do not lift. `G₁` itself does not (G45), which is why this is a relaxation. *Why the cuts matter:* under the bare inequality an
edge carries `2c/(1+c) ≈ 4/3` and a triangle `3c/(2+c) ≈ 1.4997`, and "25 full vertices + two half-weight triangles" reaches
27.9995 at 11 — `B₁ = α` survives there only because `c` is a hair under 2. *First-order criterion:* at a pure maximal
independent set `I`, raising `φ_v` (`v ∉ I` with `t_v` neighbours in `I`) by `ε` must be paid by lowering neighbours by
`η ≥ ((2t_v − c)/c)·ε`; so `I` is a strict local maximum iff every outside vertex has `t_v ≥ 2`.
**The registered quantity is `B₁` WITH the edge and triangle cuts; the bare `B₁` is kept as a control.**

*If `B₁(p) = α(G₁)` were a theorem, the independence ratio — hence the fractional chromatic number — would be constant up the
whole tower.* It is not a theorem about graphs in general. **Conjecture, NOT claimed (WORKFLOW step 9's sweep will find this
line): for `p ≡ 3 (mod 4)`, `α(UD(ℤ/p^k, 2)) = p^{2(k−1)}·α(UD(𝔽_p, 2))` for every `k`.** Its cheapest killing test is an
independent set of `UD(ℤ/49, 2)` with more than `686 = 49·14` points (I6).

### S6. Two instruments the brief proposed that are dead by derivation — recorded so nobody runs them

* **`ϑ′(G₂)` (Delsarte's LP).** A feasible point of level one's LP pulls back to level two (a pulled-back positive-definite
  function is positive definite, and `S₂ → S₁`), so `ϑ′(G₂)/p⁴ ≥ ϑ′(G₁)/p²`, which is the Hoffman ratio (measured on every
  plane, row 68); and `ϑ′ ≤ ϑ =` Hoffman by arc-transitivity. Equality: 0.2855 > 1/4 at 11. It refuses nothing. The same
  pull-back shows the triple-level value at level two is `≥ 0.2411`, as the brief said.
* **A resolution refutation of level two projects onto level one** (the owner's observation): substitute `c[v,a] ↦ c[x(v),a]`
  and every line variable to its fibre's colour variable; at-least-one clauses go to at-least-one clauses, edge and biclique
  clauses to level one's edge clauses, implications to tautologies. So **level two's shortest refutation is at least as long
  as level one's** — measured at 11: 1,535 conflicts at level two, 12,311 at level three. Where CDCL never refuted level one
  (`(23, 5)`: undecided at four hours, M58; refused only by the level-3 semidefinite certificate, row 71), it cannot refuse
  level two.

---

## §Q. The questions now, and the owner's rulings (2026-09-20) that order them

1. **Certify level two at 11** — checked LRAT, a minimal core, the kernel theorem `χ(UD(ℤ/121, 2)) = 5`. *Ruled: yes, Phase 1.*
2. **The whole tower at 11** — certify `B₁(11) < 30.25` (with cuts). *Ruled: this comes first in Phase 2, because it subsumes
   level three and every level after it; level three by SAT is a data point beside it (already taken, M6).*
3. **The rows that bear on the conjecture**, in this order: **(a)** `(19, 4)` at level two; **(b)** level ONE at `(23, 5)` with
   the full symmetry checklist and cubes across the 32 threads — also FS-17's standing question's neighbour, and the
   precondition for (c); **(c)** level two at `(23, 5)` as a *refusal* ask **only if (b) refuses**; **(d)** a finder at
   `UD(ℤ/529, 2)` last, with a bounded budget and the sentence saying what its null would teach (§I7: little).
4. **The ℚ(√167) row stays numerics-only in this milestone**: certifying `B₁(23) < 105.8` would have to prove
   `α(UD(𝔽₂₃,2)) < 105.8`, which took the level-3 relaxation with 0.4 to spare; no certifier we own can land it. The numerics
   (four-class minimum 1.4656 × budget; single-class 87.51 before cuts) predict no drop at 23 at any level. Said plainly so
   nobody plans a run that cannot land.
5. **Does the tower rise at all?** (S5's conjecture.) One cheap killing test at 7 (I6). Not a phase of its own.

**Rulings of 2026-09-20, evening (Kooshi, after the interim report; full text and the comparison he asked for: `data/fs66/owner/rulings-2026-09-20.md`).** (i) *The all-levels certificate is BUILT in this milestone, not merely priced* — §I4 becomes a build phase after its `p = 7` reading, which still comes first and still kills the route if it fails. (ii) *The 8-hour cube run at level one of `(23, 5)` is NOT run*, under his test ("only if … implemented with the greatest chance of success; we don't want to waste compute hours"): about 5 core-hours were ever spent on that exact ask, so it would not duplicate effort in size, but the same instrument failed to converge after ≈ 50 core-hours one plane down (`data/fs53/runs/q17-cube-*`: 7,500 cubes decided, 28,063 outstanding and not falling), the refusal at 23 is a counting fact, and a success would only re-prove what row 71's exact certificate already holds; §I7 (b), (c), (d) are struck from this milestone and P7 is void, not scored. The overnight compute goes to the certificate's solve and to `(19, 4)` at level two. (iii) Tools: Kooshi installs what is asked (list in the rulings file: `time`, `bc`, `julia`, `scip`, `cryptominisat`, `kissat`).

**Phase 1a ACCEPTED by the owner, 2026-09-20** (§R; scoring commands run; the owner's own recheck — own edge test, own CNF in a different variable order, no pin: UNSAT at four, SAT at five with a proper colouring — and the owner's plant, a pair that is a unit pair modulo 11 but not modulo 121, refused `NOT_UNIT_PAIR` by name: `data/fs66/owner/po-recheck-phase1a.out`).

**Phase 1b ACCEPTED by the owner, 2026-09-21** (§R; commits `19897bed`, `36f24935`): `(unitQuadrance (ZMod 121)).chromaticNumber = 5` on `[propext, Classical.choice, Quot.sound]`; gate logs read (`build/gate/{build,axioms}/latest`: 1,696 modules up to date; every new theorem clean); the Lean literal unpacked by the owner's own parser equals the certified witness's points and `Edges.lean` its edges in order; the owner's mutation through the kernel (`data/fs66/owner/po_mutation_phase1b.lean`: one point moved → the edge check is `false`; the table read modulo 122 → `false`; unmodified → `true`). **Owed at the close, found by this phase:** `lake lint` has one pre-existing error (`CayleyCert.cert23_8`, an underscore in a name, FS-53 — a rename upstream of a certificate, so it goes alone in a labelled commit); and the rule *a fault planted in a generated data module must be compiled into that module, not only into its consumer*. **The owner's error:** the second planner's four-thread probe ran beside this phase's timing measurements — staffing a planner in parallel was my call, and "light" was not light enough for a phase whose product is a timing; the measured costs are upper bounds for that reason.

**Phase 2 is re-planned, 2026-09-21: `plans/FS66-phase2-certificate.md` SUPERSEDES this file's §I3, §I4, predictions P3 and P4, and §H's "Phase 2" checklist.** The second planner's go/no-go came back GO with room: the second-level moment relaxation of the BARE single-class problem (`c = 2`, no cuts) reads **14.01 at 7 and 28.20 at 11** (needed: 16.33 and 30.25) — below the three-point bound's 29.18, which the owner's brief had wrongly called a floor — and an exact-rounding prototype gives `U = 14.0176` and `28.2251` (NOT certificates: the prototype checks itself). So exact global optimisation (§I3) is moot, no GPU and no Julia are needed at 11, and §I6 changes meaning: once certified, `α(UD(ℤ/49,2)) = 686` exactly and `3,388 ≤ α(UD(ℤ/121,2)) ≤ 3,415`, so a verified 687-set at 7 would refute the hand links or the checker, not a conjecture. **Owner's rulings:** Phase 2A (the checker, from the spec) then 2B (producer, certificates at 7 and 11) run next; **Phase 1c (level three by SAT) and Phase 3a (`(19, 4)` at level two by SAT) are HELD** — each is subsumed if the certificate lands at its prime — and Phase 2C (the certificate at 19, the one appropriate GPU use) is decided after 2B.

**Phase 2A ACCEPTED by the owner, 2026-09-21** (`plans/FS66-phase2-certificate.md` §R; commits `5b067e5e`…`fe018898`): the standard-library checker `tools/fs66_b1_cert_check.py`, written from the specification without reading the prototype's bookkeeping, certifies the three prototype files (`U = 28.225133…` at 11 in 6.6 s) — the third independent program to agree; its one first-run disagreement was its own sign error in the reflection map, in the safe direction. The owner's four plants, three of them identity-preserving (a compensated negative multiplier; every sign flipped; an indefinite block with a compensator), are each refused by name: `data/fs66/owner/po-plants-phase2a.md`. **Ruling: Phase 2B next, and Phase 2C (the certificate at 19 — the one appropriate GPU use, and it subsumes Phase 3a) WILL run after it**, as a separate brief.

**Phase 2B ACCEPTED by the owner, 2026-09-21 — THE ALL-LEVELS CERTIFICATE AT 11 IS `CERTIFIED`** (`plans/FS66-phase2-certificate.md` §R; commits `3c740871`, `4b7f39d0`, `9287638c`): `data/fs66/b1/cert-p11.json`, `U = 28.204320…`, `4U = 112.817… < 121`, and `cert-p7.json`, `U = 14.015224…`, each by the frozen standard-library checker run by the owner; records' digests equal the files'; both level-one sets (14 and 28 points) verified independent by the owner's own code; the owner's perturbation (`U_num − 1`, one part in 10³⁰) refused (`data/fs66/owner/po-recheck-phase2b.out`). **So, tools-grade plus the six hand-proved links: no level of the tower at 11 is four-colourable; `α(UD(ℤ/49,2)) = 686` exactly; `3,388 ≤ α(UD(ℤ/121,2)) ≤ 3,412`; `χ_Bor(ℚ₇²) = 4`, `χ_Bor(ℚ₁₁²) = 5`.** The statement's numbers in the phase-2 plan's §S.7/§ST and in `SOUNDNESS.md` §8 were updated in place from the prototype's to the production certificates' (the owner's edit; the prototype's figures remain in §M and §R as records). **Phase 2C (19, four colours, `U < 90.25` needed) launched next.**

**§Q4 OVERTURNED, 2026-09-21 (the owner's error; full account in `data/fs66/owner/rulings-2026-09-20.md`).** Phase 2C's float reading at 19 is **≈ 77.5** (needed: 90.25) — *below* the level-3 relaxation's 80.59, which §19 and the owner's brief said it could not be. The relaxation is stronger than the rung the "23 is out of reach" argument compared it with, so **the ℚ(√167) row is re-opened**: after `cert-p19.json` is certified, Phase 2C builds `p = 23` and takes the float reading only (`m = 5` needs `U < 105.8`); a Phase 2D (round and certify at 23) is briefed from that reading or not at all.

**The certificate at 19 ACCEPTED by the owner, 2026-09-21** (`plans/FS66-phase2-certificate.md` §R″): `data/fs66/b1/cert-p19.json`, `U = 77.511742…`, `4U = 310.05 < 361`, `CERTIFIED` by the frozen checker in the owner's own run (`data/fs66/owner/po-recheck-phase2c-19.md`), rounded from a converged GPU solve (13,950 iterations, 3 h 23 m on graphics card A; GPU 3.0× the 16-thread CPU backend at the real size). **No level of the tower at 19 is four-colourable; `α(UD(𝔽₁₉,2)) ∈ {76, 77}` (the standing bracket was `[76, 80]`); `χ_Bor(ℚ₁₉²) = 5`.** This subsumes Phase 3a (`(19, 4)` at level two by SAT), which is struck. **23 at five colours:** the build fits with room (134,447 moment variables, 24 blocks of ≈ 266, 204.7 M non-zeros, 4.0 GB of GPU memory, 3.9 s/iteration); full convergence projects at 19–28 h. The solve runs in the certifying shape (3,000-iteration chunks), its first chunk's reading is the go/no-go, and on a go it is left running detached and checkpointed for a Phase 2D implementer to round and certify.

**The prover's note ACCEPTED, 2026-09-21 — NOT PROVED; the solve at 23 continues** (`plans/FS66-tower-conjecture.md`, with the owner's review at its end, commit `520d57d2`). Kooshi asked for a prover on *the towers never rise* so that the day-long run at 23 could be cancelled if it were proved; it is not, for any class of primes containing 23. Proved and checked by the owner from the definitions: Lemma W (the weighted form is false at every `p`, so §S5 has no local proof — **§S5's "Conjecture, NOT claimed" line should be read with that beside it**), Theorem E (equal-characteristic towers are impotent; the content is the carry), Lemma T (every `B₁` certificate bounds every twisted cover; one sign erratum in its Definition, recorded in the review).

**The close's sweep of the three FS-66 plan files for "conjecture" / "not claimed" (WORKFLOW step 9), 2026-09-21 — every hit disposed of:** (i) §S3, BMK's Question 1 "NOT claimed" → **claimed and recorded**, `CLOSED-QUESTIONS.md` §1.8 (the owner's check is note §7–8). (ii) §S5, *the tower never rises* → **stub minted: FS-68, `plans/STUB-tower-never-rises.md`**, which also carries (iii) the phase-2 plan's §PA / §R.9 remark that it may be provable at 7 by an exact-face certificate (its deliverable 1), (iv) the prover's *fractional local–global tightness at one field* and its killing test `χ_f(ℚ(√11)²) = 7/2` (deliverable 2), and (v) the prover's reading that no twist of level one ever raises `α` (deliverables 3–4). (vi) The phase-2 plan's "anything at `(23, 5)` (out of reach)" is **overturned** (the block above) and is Phase 2D. No hit is left without a stub or a decision.

**What each outcome is worth now.** Phase 1 landing: the first kernel statement about a level-two plane, and the pilot closed
with a certificate instead of a solver's word. Phase 2 landing: *"at 11, local bounds survive at every level of the tower"* — a
theorem about the clopen chromatic number of `ℤ₁₁²`, by a level-one certificate; not landing: a typed null and levels two and
three on solvers' words. Phase 3: a second prime's data point (19), and an honest statement of why 23 is out of reach.

---

## §I. The instruments, in order

*For each: what it is · its acceptance test · its controls (the uninformative AND the informative outcome shown reachable) · its
checkpoint and resume command if it can pass ~15 minutes · its cost, from a measurement · how it uses the machine. "Owner's
verifier" is `tools/fs66_owner_verify.py` (all-pairs from the definition; shares no code with any finder or encoder).*

### I1. The witness, its checker, and the minimal core (Phase 1a)

**What.** A witness that `UD(ℤ/n, 2)` is not `k`-colourable is: a list of points of `(ℤ/n)²`, a list of pairs of them, a pinned
clique, and an LRAT refutation of that edge list's `k`-colouring formula. **`tools/fs66_check_witness.py` — standard library
only, importing nothing from `tools/`** — modelled on `tools/fs58_check_witness.py` (frozen: read it, never import or edit it)
and doing, in order: (1) every point is a pair of integers in `[0, n)`, no point twice (*hygiene, not soundness*: a repeated point would still be
a homomorphic image and a valid refutation — the kernel needs only that listed pairs go to edges); (2) **every listed pair is re-verified
from the definition** `(a−c)² + (b−e)² ≡ 1 (mod n)` in integer arithmetic, and the count of *all* unit pairs among the listed
points is reported beside the listed count (subset semantics: a subgraph that refuses refutes every supergraph — the kernel
needs only that listed pairs are edges, and fewer clauses are cheaper there); (3) the pinned vertices are pairwise listed
edges; (4) it builds the CNF **itself**, in **exactly the order of `tools/coloring.py` and of `Sat/Encoding.lean`'s
`coloringCNF k n E ++ cubeCNF k n cube`** (`x(v,c) = k·v + c + 1`; ids `0 … n−1` the at-least-one clauses in vertex order; then
per listed edge, in listed order, its `k` conflict clauses; then one unit per pin) — **so ONE LRAT file serves both this
checker and the kernel pipeline**; the checker re-implements the order (it imports nothing), and a control asserts that its
CNF's SHA-256 equals the one `tools/coloring.py` produces for the same witness: two builders, agreement checked, never assumed; (5) it checks the LRAT with its own
reverse-unit-propagation checker (each added clause implied using exactly its hints in order, deletions honoured, the empty
clause added). Output `CERTIFIED` (exit 0) or `REFUSED <CODE>: <detail>` (exit 1).

**The output is the product — its reader holds nothing else** (a reviewer who trusts none of `tools/`; an agent scoring a
phase from `check.out`). On success, in this order: the SHA-256 of the witness, of the proof and **of the checker itself**;
`n`, `k`; points, listed edges, induced unit pairs among the points, clauses, proof lines, seconds; then one sentence in plain
words and one last line a script can match:
`the listed graph (… points, … edges, every pair re-verified as a unit pair modulo n) has no proper k-colouring; it is a
subgraph of UD(Z/n,2), so UD(Z/n,2) has none` / `CERTIFIED by fs66_check_witness (standard-library checker; NOT the Lean kernel)`.
On refusal: the code from a **closed list that `--help` prints with a one-line meaning each** (`BAD_POINT`, `REPEATED_POINT`,
`NOT_UNIT_PAIR`, `PIN_NOT_CLIQUE`, `PROOF_STEP_NOT_RUP`, `PROOF_NO_EMPTY_CLAUSE`, `PROOF_BAD_HINT`, `CNF_DIGEST_MISMATCH`, `IO`),
and **the first offending item in the reader's vocabulary** — for `NOT_UNIT_PAIR`: both indices, both points, and the quadrance
computed (`edge 17: (3,40)–(91,7): 8² + 33² ≡ 64 (mod 121), not 1`), never a stack trace. `--controls` prints one row per plant
— plant · expected code · observed code · `ok`/`FAIL` — then the faithful twin's row, then `ALL CONTROLS BEHAVED` or the count
that did not, **and exits non-zero unless all behaved**. Nothing is accepted and ignored: an unknown JSON key, a `k` below the
pin's size, an empty edge list are each refused by name.

**Format** (`witness.json`): `{"kind": "fs66-witness", "n": 121, "k": 4, "points": [[a, b], …], "edges": [[i, j], …] (i < j,
indices into points, sorted), "pin": [i, j, l], "provenance": {…}}` and `witness.lrat.gz` beside it. **`*.lrat` is gitignored
repository-wide; `*.lrat.gz` under `data/fs58/` and `data/fs61/` are committed — check `.gitignore` and follow that precedent.**

**Acceptance.** `CERTIFIED` on the committed witness; `--controls` refuses each planted fault **for its named reason** and
certifies the faithful twin: a non-unit pair listed (move one endpoint by 1); a repeated point; `n` changed to 120 (almost every
pair stops being unit — must be refused at step 2, not later); the pin replaced by a non-clique; the proof truncated before the
empty clause; one hint id corrupted; **the `k = 5` formula with the `k = 4` proof** (a satisfiable formula handed to the
checker); a witness with one edge deleted but the original proof (hint/clause-id mismatch). *Uninformative outcome and its
reachability:* a checker that certifies everything — excluded by the plants, each of which must be seen red. *Wrong-reason red:*
each plant asserts the refusal **code**, and the faithful twin (same scaffolding, no fault) must pass.

**The minimal core.** Start from `data/fs66/planner/core-p11-k4-fixpoint-1115v.json` (or regenerate it, §M's README). Delete
vertices one at a time while the remainder still refuses: each probe is a CaDiCaL run on ≤ 1,115 vertices (0.9 s measured at the
fixpoint) under a **conflict budget of 300,000** (an `UNKNOWN` keeps the vertex and is counted — never read as "needed"). Run 16
probes at a time on distinct candidate vertices, accept one refusing deletion per wave, re-extract the LRAT core of the accepted
instance (it usually drops more than one vertex). **Checkpoint:** `data/fs66/ckpt/minimise-p11-l2.jsonl`, one line per accepted
deletion (`{"removed": v, "vertices_left": …, "edges_left": …, "probe_conflicts": …}`) plus the current vertex list in
`data/fs66/ckpt/minimise-p11-l2.current.json` rewritten atomically after every acceptance; **resume:** `python3
tools/fs66_minimise.py --resume data/fs66/ckpt/minimise-p11-l2.current.json`. **If the process dies at any instant the relaunch
redoes at most one wave.** *Stop rule (G65: certification cost is predicted by nothing; use the measured rate):* stop at
1-minimality, or when the last 200 probes accepted nothing and the wave rate has fallen under one acceptance per five minutes,
or at two hours — whichever first; the witness is whatever stands then. **The aim is a cheaper kernel check, not a record
size**; G65 also says the core's average degree (7.9 at the fixpoint) is already near where four-colour asks turn hard, so
expect probes to slow as it shrinks — the budget, not patience, handles that.
*Cost:* minutes to two hours on 16 cores. *Hardware:* 16 single-threaded probes in parallel (`multiprocessing` with the `fork`
context — `CLAUDE.md` § Toolchain on Python 3.14).

### I2. The kernel theorem (Phase 1b)

`χ(UD(ℤ/121, 2)) = 5` in Lean: §L has the skeleton (it elaborates). Upper half: `finitePlane11_colorable_five` pulled back along
`unitQuadrance.map (ZMod.castHom …)` — no data. Lower half: the witness through **the existing certificate pipeline**
(`tools/emit_mask.py --edges … --n N --edges-name … --pins … --lrat … --name zmod121Four --out … --module …`; precedent
`Instances/TwoAdicFive.lean` + `Instances/TwoAdicFive/{Edges.lean, Cnf/}`, FS-38 phase K3; and `Instances/Heule510` for a
4-colour certificate on 510 vertices), a generated vertex table held as **one packed natural-number literal** (`unpackPt`; fallback if the measurement says
otherwise: a balanced tree in the manner of `Certificate.lean`'s `PtTable` — never a `![…]` vector or a `List` indexed by
position, whose access cost is linear), a `Bool` edge check through `List.all` on ℕ arithmetic (`unitPairNat`), and one
bridging `iff` from that check to adjacency over `ZMod n` — generic in `n`, so 19's witness (Phase 3a) reuses it.
**Measure before promising** (`CLAUDE.md` § The kernel's cost model — three of its rules bind here): `List.all f = true`, never
`∀ e ∈ l`; **no `ZMod 121` literal in the data** (a numeral at a type index is paid per numeral — the table is `ℕ × ℕ` and the
cast happens once, inside the bridging lemma's statement); feed the kernel the core, never the 14,641-vertex instance. Measure on
the round-0 witness **before** minimising further: if the pipeline already checks the 1,115-vertex core in minutes, minimisation
stops mattering and I1's stop rule can fire early.
**Acceptance.** `./scripts/build.sh` green (never `lake build`); zero `sorry`; `./scripts/axioms.sh` shows the new theorems on
`[propext, Classical.choice, Quot.sound]` with **no `native_decide` purchase**; `./scripts/vacuity.sh` and `--self-test` green
with counts reconciled; the final statement **read aloud** against `SimpleGraph.chromaticNumber` and "the unit-distance graph
over the ring of integers modulo 121 needs exactly five colours". *Negative controls, each seen red then restored and
re-verified:* one vertex of the table moved by 1 (the edge check must fail, naming a pair); the certificate filed against
`k = 5` (must fail); the pin changed to a non-triangle (must fail at the triangle gadget).
*Cost:* unknown until measured — precedents: 125 vertices / 3,240 clauses, 5.9 s (FS-38 K3); 204 points at three colours, 32.8
CPU s (FS-58); this is ≈ 1,115 × 4 + 4,405 × 4 ≈ 22,000 clauses and a 716 KB text LRAT. *Hardware:* segments elaborate in
parallel under `scripts/build.sh`'s batching; measure one data module's peak memory before raising `BATCH`.

### I3. Certifying `B₁(11) < 30.25` by exact global optimisation (Phase 2a) — low confidence, bounded, killable

**What.** Maximise `Σφ` over `φ ∈ [0,1]^{121}` subject to `φᵀ(A₁ + c⁺I)φ ≤ c⁺Σφ` (`c⁺` = `c` rounded **up**: a larger `c` only
weakens the constraint, so an upper bound for `c⁺` is one for `c`), the 726 edge cuts and 484 triangle cuts (§S5), and two
**sound** symmetry breaks: `φ₀ ≥ φ_x` for all `x` (translate a maximum entry to the origin — vertex-transitivity) and
`φ_{s₁} ≥ φ_s` over the origin's twelve neighbours (rotations act transitively on them). Solver: Gurobi 13 (`pip install
gurobipy` in a venv **outside `build/`**, e.g. `~/venvs/fs66`; the bundled size-limited licence covers 2,000 variables and
constraints — this model has 121 and ≈ 1,340) with `NonConvex = 2`; SCIP (`pyscipopt 6.2.1`, wheel exists for Python 3.14) as
the second opinion. The planner's scratch script is reproduced in `data/fs66/planner/` only as a recipe — the implementer writes
`tools/fs66_b1_global.py`.
**Positive control — measured, M9:** at `p = 7`, three colours, the same model **lands: bound 16.165 < 16.333 in 300 s on 4
threads** (the truth there is refusal: the certified 297-point graph over ℚ(√23) maps into every level). Bare problem 19.95,
cuts only 18.04, cuts + symmetry 16.165 — so both additions are doing work. *Uninformative outcome and its reachability:* a
bound that never crosses — reached at 11 in M9's 420 s probe (35.88). *Informative:* reached at 7.
**Registered kill line (the prediction is that it fires):** run on 16 threads with Gurobi's own node file on disk
(`NodefileStart = 8` GB, `NodefileDir` **outside `build/`**) and a log line per minute. **If the bound is above 33.0 after two
hours, or has moved less than 0.05 in the last 30 minutes, stop and record the trajectory** — the log is the record
(`data/fs66/b1/gurobi-p11.log`, committed). Gurobi cannot checkpoint a branch-and-bound tree portably; **what a death redoes is
the whole run**, which is why the budget is two hours and not a day. **Before stopping it, write cause / measurement / forfeit
in the record (`CLAUDE.md` § "A run that blocks something").**
**Even if it lands it is a solver's floating-point word**, not a certificate: the plan's claim would read "refused at every
level on Gurobi's word", and a rational certificate is I4's job.
*Cost:* (7) 300 s [measured]; (11) unknown, expected not to land [M9: 38.6 → 35.9 in 7 minutes and slowing, open nodes growing].
*Hardware:* 16 threads (Gurobi parallelises its tree); no GPU.

### I4. Pricing — not running — a second-level moment relaxation of `B₁(11)` (Phase 2b)

No first-level relaxation can work: Shor + RLT, symmetrised, contains `ϑ′ =` Hoffman `= 34.55 > 30.25` as the special case of
pure `φ`. The candidate is the second-level moment (Lasserre) relaxation of the 121-variable problem with its cuts, with
`Aut(G₁)` (translations × rotations × conjugation, order 2,904) divided out — FS-50's machinery (`tools/fplane_sdp_blocks.py`,
`tools/fplane_cert_round.py`, `tools/fplane_cert_check.py`; the GPU build of SCS in `build/venv-sdp-gpu`, keyword
`linear_solver=`, 0.33 s per iteration at 83) pointed at a different polynomial. **Its margin is thin by construction:** it
cannot read below the triple-level value for true independent sets, 29.18, and must read below 30.25. **Deliverable of this
phase: a one-page price** — the moment matrix's size after symmetry reduction (monomials of degree ≤ 2 in 121 variables: 7,503
before reduction), the number of orbit variables, the localising constraints for the box, the quadratic constraint and the
cuts, an estimated iteration cost on card A, and **a small-case reading first: the same relaxation at `p = 7`, three
colours, where it must read below 16.33** (49 variables, 1,275 monomials — a CPU-minute problem with `cvxpy` + SCS, no symmetry
reduction needed). If (7) does not read below 16.33, the route is dead and the price says so in one line. **Do not build the
11 solve in this milestone without the owner's ruling on the price.**

### I5. `(19, 4)` at level two, and level one first (Phase 3a)

**What.** Is `UD(ℤ/361, 2)` (130,321 vertices, degree 380, 24.76 M edges) four-colourable? Floor 4 (ℚ(√11)'s kernel witness
maps in: 11 is a square modulo 19), ceiling 5. **By §S6 the refusal can be no shorter than level one's, so level one is asked
first:** `(19, 4)` at level one with the full symmetry checklist (`ω = 2` at 19: an edge pin is all the clique buys, so the
**precedence constraint on the two remaining colours is mandatory** — `CLAUDE.md` § Toolchain measured 72× for it at `(13, 5)`);
record its conflicts and time. Then level two in the owner's biclique encoding
(`data/fs66/owner/fs66_owner_biclique_cnf.py`: 795,644 variables, 5,617,523 clauses at `(19, 4)`, built in 7 s) **with
precedence added** — M11's probe had the edge pin only and did not decide in 900 s, which by `CLAUDE.md`'s rule measures the
encoding, not the graph. If a single solve does not decide in 30 minutes: cube on the colours of the origin's neighbourhood
and run cubes across the cores with `tools/fplane_sat_cube.py`'s checkpoint discipline (one JSON line per decided cube, a digest
of the cube list in the header, a resume refused against a different enumeration); **price the cubes on a sample of 16 before
committing** (M63 phase H2's rule).
**Acceptance.** SAT → the colouring VERIFIED by the owner's verifier (then `χ(UD(ℤ/361,2)) = 4`: a drop at 19, and the milestone
has a second, louder result — tell the owner at once). UNSAT → LRAT kept, core extracted, four-solver recheck of the bare core
as in M2, witness in I1's format, `CERTIFIED` by I1's checker. UNKNOWN → a typed null with the conflict counts of levels one
and two side by side. *Controls:* the same encoder must refuse `(7, 3)` and 5-colour `(11, 5)` with a verified colouring (both
measured by the owner's encoder today); level one `(19, 4)` must refuse (the truth: `χ(UD(𝔽₁₉,2)) = 5`, M58).
**Checkpoint:** single solves ≤ 30 min need none; the cube run's is `data/fs66/ckpt/cubes-p19-l2-k4.jsonl`, resume `python3
tools/fs66_cubes.py --resume data/fs66/ckpt/cubes-p19-l2-k4.jsonl`; a death redoes the cubes in flight.
*Cost:* encoder 7 s, 96 MB CNF [measured]; solve ≥ 900 s with the weak break [measured], unknown with precedence. *Hardware:* one
core per solve; 16 (then 32 — record which) for cubes; no GPU.

### I6. The cheap killing test of "the tower never rises": an independent set of `UD(ℤ/49, 2)` above 686 (rides along, any phase)

2,401 vertices, degree 56. `α(UD(𝔽₇,2)) = 14` exactly (FS-54), so the pulled-back set has `14·49 = 686`, Hoffman allows 863, and
`B₁(7) ≤ 16.165` (M9) allows at most `16·49 = 784`. **Ask:** an independent set of 687 — by SAT with a cardinality constraint and
the translation symmetry broken (origin in the set), 30 minutes; and by any local search the implementer has to hand, seeded
**both** from random and from the pulled-back set with line-sized moves (S1: adding one point over an empty fibre costs a whole
line of `p` points in each full neighbouring fibre — single-vertex moves cannot leave the pulled-back optimum). *Both outcomes
reachable:* the finder must first find **686** from a random start (positive control — if it cannot, its null is void).
A 687-set, VERIFIED by the owner's verifier (`indep` mode), **kills §S5's conjecture** and is reported at once; a null is weak
evidence for it (G21: say the budget and the moves in the sentence).

### I7. 23 at five colours (Phase 3b–d) — what can land, and what cannot

**(b) Level ONE, `(23, 5)`, as a CDCL refusal.** Known UNSAT by certificate (`α ≤ 105 < 105.8`, row 71) and **undecided by CDCL
at four hours with a pinned clique** (M58). `ω = 3` at 23: pin a triangle, precedence on the remaining two colours, then
cube-and-conquer across **32 threads** with `tools/fplane_sat_cube.py` (checkpointed, resumable; read its `--help` and
`data/fs53/README.md` for its record format). **Price first:** 16 sampled cubes at a 10-minute conflict budget each; project the
whole run from the sample *and keep the prediction beside the measured rate* (`CLAUDE.md`: a prediction that can be divided back
out of a rate is a population check). **Registered budget: 8 hours of wall time; ask the owner before exceeding it.** A refusal
here is worth having either way (it makes `(23, 5)`'s level-one refusal a checkable LRAT rather than an SDP certificate, and it
is the precondition for (c)).
**(c) Level two, `(23, 5)`, as a refusal — only if (b) refuses**, and then priced from (b)'s conflict count times the 11 →
121 → 1331 growth seen at 11 (1,535 → 12,311 conflicts per level: ×8). 279,841 vertices; ≈ 17.5 M clauses in the biclique
encoding.
**(d) A finder at `UD(ℤ/529, 2)`, five colours — last, bounded, and its null teaches little.** The four-class fibre-density
minimum at `(23, 5)` is 1.4656 × budget over 30 starts (owner's numerics): no level is expected to be 5-colourable, so a null is
the predicted outcome and cannot distinguish "none exists" from "not found". **If run at all: CaDiCaL on the biclique encoding as
the finder** (it found the non-pulled-back 5-colouring of `UD(ℤ/121,2)` in 251 s, M3), 16 seeds × 30 minutes, positive control
`UD(ℤ/529, 2)` at **eight** colours (a pulled-back 8-colouring exists — `colorable_finitePlane23_eight` — and the finder must
find one it was not handed). A colouring, VERIFIED, would make `χ(ℚ(√167)²) ≤ 5` a theorem and is reported at once.
**Decision on the brief's finder question** (§W): no new finder is built and no work order is opened in
`~/source/descent-engine` in this milestone; the GPU is not used for search.

---

## §P. Registered predictions (registered 2026-09-20, before any phase runs; scored in §R at the close)

*Each names the outcome that would teach nothing and the one predicted, and both are reachable on the measurements in §M.*

| id | prediction | confidence | what would refute it | reachable? |
|---|---|---|---|---|
| P1 | Phase 1's witness certifies: a core of **between 600 and 1,115 vertices** is `CERTIFIED` by the new checker, and the kernel checks it in **under 15 minutes of CPU and under 12 GB** | medium-high on landing; low on the size band | a checker refusal that is not a planted one; a kernel cost an order of magnitude over (then I1's minimisation earns its keep) | both: the pipeline has certified 510 vertices at four colours (`Instances/Heule510`) and 125 at 5.9 s |
| P2 | vertex-minimising below the fixpoint core is slow: **fewer than 300 vertices come off in the two-hour budget**, and probes turn `UNKNOWN` as the average degree falls toward 7 (G65) | medium | a 1-minimal core under 500 vertices | yes — FS-61's cores ranged 131–2,360 |
| P3 | **I3's kill line fires**: Gurobi's bound on `B₁(11)` is above 33.0 at two hours | medium-high (M9: 35.88 at 7 min, slowing) | the bound crossing 30.25 — then "every level" holds on a solver's word and I4 becomes the milestone's priority | the crossing is reachable in kind (it happened at 7) |
| P4 | I4's small case reads **below 16.33 at `p = 7`** (the second-level moment relaxation sees what the first cannot) | low-medium — no measurement behind it | a reading ≥ 16.33: the SDP route is dead, said in one line | both |
| P5 | `(19, 4)`: level one refuses within minutes under edge pin + precedence; **level two then refuses, with 5–20× level one's conflicts** (the ratio at 11 was ×8 per level) | medium | a 4-colouring of `UD(ℤ/361,2)` (a drop — reported at once); or `UNKNOWN` after cubes (a typed null) | refusal: by analogy with 11 only; SAT: nothing forbids it except the owner's numerics (1.2763 × budget) |
| P6 | I6 finds **no** independent set of 687 in `UD(ℤ/49,2)`, and its positive control (686 from a random start) **is** found | medium | a verified 687-set: §S5's conjecture is dead and the tower rises at 7 | the control's reachability is the point of running it first |
| P7 | I7(b): level-one `(23, 5)` is **not** refused by cube-and-conquer in 8 hours | medium-high (M58: undecided at four hours, single solve) | a refusal — then (c) is priced and asked | the sample of 16 cubes tells which before the budget is spent |
| P8 | the owner's check of §S3 finds the argument sound | medium-high | a hypothesis of Theorem 2.5 not met, or the normalisation of `μ̂` off by the level's scaling | both |

**Scored already (kept for the record, the planner's own):** before M1 the planner's written prior was "probably no
4-colouring, but CDCL will not be able to say so" — **half wrong**: the refusal took 1.7 s. And the brief's "`ϑ′` first" and the
planner's first thought of an LP with subgraph cuts both died by derivation (§S6) before being run.

---

## §L. The Lean side — the generic layer proved, the instance layer a skeleton (checked under `lake env lean` with `autoImplicit false`, 2026-09-20 — which is NOT the build: it applies none of the lakefile's options, so the implementer's first act is to place it and build)

*Where it goes:* `Proofs/HadwigerNelson/ResidueTower.lean` (the two generic lemmas) and `Proofs/HadwigerNelson/Instances/
ZMod121Four.lean` + `Instances/ZMod121Four/{Pts.lean, Edges.lean, Cnf/…}` (generated). `ARCHITECTURE.md`'s module map is
checked by `tools/check_architecture.py` — add the modules there in the same commit. Names follow Mathlib convention (the name
is the statement); the experience pass (§E below) owns their final form.

```lean
import Proofs.HadwigerNelson.Instances.FinitePlane11
import Proofs.HadwigerNelson.EdgeList
import Proofs.HadwigerNelson.Gadget

open SimpleGraph

/-- The shifted natural subtraction IS subtraction in `ZMod n`. False at `n = 0` (`a = 0`, `b = 1`), hence `NeZero`. In
Mathlib's namespace, as `ZMod.exists_eq_add_mul_of_castHom_eq` (`Lift.lean`) is: it is a fact about `ZMod`. NOT `@[simp]`
and not `@[push_cast]` — it is cited by name at its one use; the cast normal form is Mathlib's to legislate. -/
theorem ZMod.natCast_add_self_sub_mod {n : ℕ} [NeZero n] (a b : ℕ) :
    ((a + n - b % n : ℕ) : ZMod n) = (a : ZMod n) - (b : ZMod n) := by
  have hb : b % n ≤ a + n := (Nat.mod_lt b (NeZero.pos n)).le.trans (Nat.le_add_left n a)
  rw [Nat.cast_sub hb, Nat.cast_add, ZMod.natCast_self, add_zero, ZMod.natCast_mod]

namespace HadwigerNelson

/-! ## The generic layer — PROVED in the planner's scratch file (no `sorry`), to be placed in `ResidueTower.lean` -/

/-- Colourability pulls back along a ring homomorphism: the colouring face of `unitQuadrance.map`, named in the house
pattern of `unitQuadrance_forces_eq_of_ringHom` (`FanGap.lean`). -/
theorem unitQuadrance_colorable_of_ringHom {R S : Type*} [CommRing R] [CommRing S] [Nontrivial S] (f : R →+* S)
    {k : ℕ} (h : (unitQuadrance S).Colorable k) : (unitQuadrance R).Colorable k :=
  Colorable.of_hom (unitQuadrance.map f) h

/-- **The residue ceiling is monotone along divisibility** — up the tower `ZMod (p^k)`, across CRT composites, and (at
`n = 0`) from `ℤ` itself: the kernel form of the second inequality of `[Madore2015]` Prop. 3.8. -/
theorem chromaticNumber_unitQuadrance_zmod_le_of_dvd {m n : ℕ} (hm : 1 < m) (h : m ∣ n) :
    (unitQuadrance (ZMod n)).chromaticNumber ≤ (unitQuadrance (ZMod m)).chromaticNumber :=
  haveI : Fact (1 < m) := ⟨hm⟩
  chromaticNumber_le_of_forall_imp fun _ hk => unitQuadrance_colorable_of_ringHom (ZMod.castHom h (ZMod m)) hk

/-- Over a nontrivial ring unit quadrance already excludes equality (`0 ≠ 1`): adjacency is the one equation. The
argument was inlined in `unitQuadrance.map`; minted once here because the bridge below needs it again. **NOT `@[simp]`:**
`unitQuadrance_adj` already is, with the same left side, and the set's normal form (`u ≠ v ∧ …`) is not ours to fork. -/
theorem unitQuadrance_adj_iff_quadrance {R : Type*} [CommRing R] [Nontrivial R] {u v : R × R} :
    (unitQuadrance R).Adj u v ↔ (u.1 - v.1) ^ 2 + (u.2 - v.2) ^ 2 = 1 := by
  rw [unitQuadrance_adj]
  refine ⟨fun h => h.2, fun h => ⟨?_, h⟩⟩
  rintro rfl
  simp at h

/-- The per-pair check on natural-number representatives, as a `Bool` the kernel evaluates; no `ZMod` literal is carried.
`v`'s coordinates are reduced first, so the subtraction never truncates and no "entries are `< n`" hypothesis is needed. -/
def unitPairNat (n : ℕ) (u v : ℕ × ℕ) : Bool :=
  ((u.1 + n - v.1 % n) ^ 2 + (u.2 + n - v.2 % n) ^ 2) % n == 1 % n

/-- **The bridge, both ways.** `1 < n` is load-bearing twice: at `n = 1` the check says `true` of a point and itself
(the adversary below), and at `n = 0` its subtraction truncates. The ONLY place a cast appears. -/
theorem unitPairNat_eq_true_iff {n : ℕ} (hn : 1 < n) (u v : ℕ × ℕ) :
    unitPairNat n u v = true ↔
      (unitQuadrance (ZMod n)).Adj ((u.1 : ZMod n), (u.2 : ZMod n)) ((v.1 : ZMod n), (v.2 : ZMod n)) := by
  haveI : Fact (1 < n) := ⟨hn⟩
  haveI : NeZero n := ⟨by omega⟩
  rw [unitQuadrance_adj_iff_quadrance, unitPairNat, beq_iff_eq, ← ZMod.natCast_eq_natCast_iff']
  push_cast [ZMod.natCast_add_self_sub_mod]
  rfl

-- the consumer's path at an instance — an explicit `1 < n`, discharged inline, no `haveI` ceremony:
example : (unitQuadrance (ZMod 121)).Adj ((0 : ℕ), (0 : ℕ)) ((0 : ℕ), (120 : ℕ)) :=
  (unitPairNat_eq_true_iff (by norm_num) (0, 0) (0, 120)).mp rfl
example : (unitQuadrance (ZMod 121)).chromaticNumber ≤ (unitQuadrance (ZMod 11)).chromaticNumber :=
  chromaticNumber_unitQuadrance_zmod_le_of_dvd (by norm_num) (by norm_num)

example : unitPairNat 1 (0, 0) (0, 0) = true := rfl     -- the adversary: why `1 < n` cannot be dropped

/-- Entry `i` of a vertex table packed into ONE literal: the `w`-bit field at offset `w·i` holds `a·n + b`. Parametric in
`(n, w)` because the next instance is already planned (`n = 361`, `w = 17`). -/
def unpackPt (n w packed i : ℕ) : ℕ × ℕ :=
  let id := (packed >>> (w * i)) &&& (2 ^ w - 1)
  (id / n, id % n)

#guard unpackPt 121 14 (120 + (5747 <<< 14)) 1 == (47, 60)
#guard unitPairNat 121 (0, 0) (0, 120)                                          -- `(0,0) ~ (0,−1)`
#guard unitPairNat 121 (0, 120) (47, 60) && unitPairNat 121 (0, 0) (47, 60)     -- the planner's pinned triangle 0, 120, 5747
#guard !unitPairNat 121 (0, 0) (11, 0)                                          -- `11² = 121 ≡ 0`, not `1`
#guard !unitPairNat 121 (5, 7) (5, 7)                                           -- a point is not its own neighbour

/-! ## The instance layer — `sorry` at each leaf; data GENERATED -/

-- GENERATED: `zmod121CorePacked : ℕ`, `zmod121CoreEdges : List (Fin N × Fin N)`, and `Cnf/` by `tools/emit_mask.py`

theorem unitQuadrance_zmod121_not_colorable_four : ¬ (unitQuadrance (ZMod 121)).Colorable 4 := by
  sorry

theorem unitQuadrance_zmod121_colorable_five : (unitQuadrance (ZMod 121)).Colorable 5 :=
  haveI : Fact (1 < 11) := ⟨by decide⟩
  unitQuadrance_colorable_of_ringHom (ZMod.castHom (show 11 ∣ 121 by norm_num) (ZMod 11)) finitePlane11_colorable_five

/-- **The ring of integers modulo 121 needs exactly five colours**: at 11 the residue ceiling does not drop at level two. -/
theorem chromaticNumber_unitQuadrance_zmod121 : (unitQuadrance (ZMod 121)).chromaticNumber = 5 :=
  chromaticNumber_eq_iff_colorable_not_colorable.mpr
    ⟨unitQuadrance_zmod121_colorable_five, unitQuadrance_zmod121_not_colorable_four⟩

end HadwigerNelson
```

**The one remaining `sorry`, decomposed** (each child strictly smaller: data check < homomorphism < refutation of the listed
graph < headline; precedent for every line: `Instances/TwoAdicFive.lean`):

| child | statement | how it closes |
|---|---|---|
| a | `zmod121CoreEdges.all (fun e => unitPairNat 121 (pt e.1) (pt e.2)) = true`, `pt i := unpackPt 121 14 zmod121CorePacked i` | **leaf, `decide +kernel`** — ≤ 4,405 evaluations of a dozen GMP operations each; also excludes loops and coincident points, since `unitPairNat 121 u u = false` |
| b | `zmod121CoreHom : edgeGraph N zmod121CoreEdges →g unitQuadrance (ZMod 121)`, `toFun i := (↑(pt i).1, ↑(pt i).2)` | proof, ~10 lines: `List.all_eq_true` on (a), `(unitPairNat_eq_true_iff (by norm_num) _ _).mp`, and `.symm` for the reversed pair — `twoAdicFiveHom`'s shape |
| c | `zmod121Four_unsat : (coloringCNF 4 N zmod121CoreEdges ++ cubeCNF 4 N cube).Unsat` | **generated, kernel** — `tools/emit_mask.py`'s segments; a wrong table fails `…_agrees`, a wrong proof fails a segment |
| d | the pinned triangle's three `Gadget.edge`s | **leaves, `decide +kernel`** on list membership — where "the pin is a clique *of the listed graph*" is checked (trap §T1) |
| e | `¬ (edgeGraph N zmod121CoreEdges).Colorable 4` | `not_colorable_of_gadget (refuted.inter triangle) (by decide)` — 64 port colourings |
| f | the headline `sorry` | `fun h => e (Colorable.of_hom zmod121CoreHom h)` |

**Where this decomposition could silently prove the wrong thing, and what stands guard.** *The hom is about the wrong
object:* it cannot be — its type names `unitQuadrance (ZMod 121)`, and (a) is evaluated on the very table `toFun` casts.
*The certificate is about another edge list:* `emit_mask.py` takes the graph and the **Lean name** of the list, never a
formula, and `agreesWithCNF` re-derives the table from Lean's own `coloringCNF`. *A cast changes the statement:* the only
cast is inside `unitPairNat_eq_true_iff`, stated for the literal type `ZMod 121`; nothing mentions `ZMod (11 ^ 2)`.
*Vacuity:* every theorem here either concludes `False` from a colouring (a refutation), or has its hypothesis inhabited in
the same file. *The mutation audit the implementer runs* (each must break the build, then be restored and re-verified):
drop `(hn : 1 < n)` from the bridge (the `example` above is the counter-model); change one table entry by 1 (child a
fails); pin a non-triangle (child d fails); file the `k = 5` certificate (child c fails).

**What is deliberately absent.** No field-level consumer (`χ(ℚ(√47)²)` is untouched by a refusal, and the number-field residue
step is row 57's gap, FS-47). No statement about level three, the `p`-adic plane, or `B₁`: none has a certificate. No
`ZMod (11 ^ 2)` — the type is `ZMod 121`, a literal, because a numeral at an unsimplified type index is paid per numeral
(`CLAUDE.md` § The kernel's cost model). **Vacuity:** `unitQuadrance_zmod121_not_colorable_four` concludes `False` under a colouring and is a refutation (skipped by
the gate); `unitQuadrance_colorable_of_ringHom` is parametric (`GENERIC`, the caller's obligation) and its `Colorable`
hypothesis is inhabited in the same file by `finitePlane11_colorable_five` at `ZMod.castHom`; `unitPairNat_eq_true_iff` is an
`iff` with both sides inhabited by the `#guard`s and the consumer-path `example`.

---

## §D. Artifact layout and record format

```
data/fs66/
  README.md                      the map of this directory, written at the close (what each file is, what it licenses, trust word)
  owner/                         the owner's notes, encoder, verifier outputs            (exists; not the implementer's)
  planner/                       the planner's measurements and scripts                  (exists; frozen as a record)
  witness-p11-l2-k4/             witness.json, witness.lrat.gz, check.out, controls.out  (Phase 1a)
  b1/                            gurobi-p7.log, gurobi-p11.log, b1-records.jsonl, moment-price.md   (Phase 2)
  level2-p19-k4/                 records.jsonl, level1.log, level2.log, [witness.json + .lrat.gz | colouring.json]   (Phase 3a)
  alpha-p7-l2/                   control-686.json, ask-687.json                                       (I6)
  level1-p23-k5/                 cube-sample.jsonl, cubes.jsonl, summary.json                         (Phase 3b)
  ckpt/                          every checkpoint of every run over 15 minutes — NEVER under build/
tools/
  fs66_owner_verify.py           exists (the owner's)
  fs66_check_witness.py          I1's checker — standard library only, imports nothing from tools/
  fs66_tower.py                  one tool, subcommands: build | ask | core | level | quotient   (the planner's scratch scripts, rewritten —
                                 they were run only as recorded in §M and are NOT imported by anything; the checker imports nothing at all)
  fs66_minimise.py               I1's checkpointed core minimiser
  fs66_b1_global.py, fs66_cubes.py
```

**One record shape for every ask, in ONE file per directory named `records.jsonl`** (so `cat data/fs66/*/records.jsonl` is
the whole milestone, and the owner's recount is one script over one glob; raw solver logs sit beside as `*.log`, and the files
named in the tree above are those logs and artifacts, never a second copy of a verdict). **An `UNKNOWN` is a first-class
record — a typed null — and must carry the limit that stopped it.** Every field is flat and typed; nothing is free text a
script must parse: `{"kind": "fs66-ask", "record_version": 1, "utc": "2026-09-21T03:14:15Z", "command": "<the exact command line, so the record
can be rerun>", "tool_sha256": "…", "graph": {"n": 121, "level": 2, "p": 11, "restriction": {"type": "all" | "subset" |
"preimage" | "quotient", "of_sha256": "<the vertex list's digest, or null>", "detail": "<e.g. p·(1,0)>"}}, "vertices": …, "edges": …, "k": 4, "encoding": "plain" |
"biclique", "symmetry": {"pin": [...], "precedence": true}, "solver": "cadical-<version>", "seed": 0, "limit": {"kind": "wall_s" | "conflicts" | "none", "value": 900},
"verdict": "SAT" | "UNSAT" | "UNKNOWN", "conflicts": …, "cpu_s": …, "wall_s": …, "rss_mb": …, "machine":
"desktop", "threads": 1, "artifact": "<path of colouring or proof>", "artifact_sha256": "…", "trust": "verified
colouring" | "refused (solver, untrusted)" | "CERTIFIED (fs66_check_witness)" | "kernel"}`. **The trust word is mandatory and
comes from that closed list** (FS-38's README is the model). Numbers travel with their population: every record says which
graph, which restriction, which encoding, which breaks.

---

## §H. Phases for the implementer — one phase per brief; each fits well under 500k tokens

*Every phase: read §0, §M, §S1, the instrument(s) named, and §T. Build only through `./scripts/build.sh`. One heavy job at a
time on this machine. On any unexplained process crash: stop and tell the owner. **You start no agents of any kind** (`CLAUDE.md`
§ Delegation: a child's children are unbudgeted and unreviewable); if the phase does not fit, stop at a clean boundary, persist,
and say what is left. Commit by explicit path; never push. Use the machine: the per-instrument "hardware" lines are
instructions, not suggestions (Kooshi, 2026-09-20: all 16 cores, and the GPU where appropriate — in this milestone that is I4
only).*

### Phase 1a — the witness and its checker (I1). Acceptance checklist, scorable from artifacts:
*Scoring commands (the owner runs these; each must behave as stated):* `python3 tools/fs66_check_witness.py
data/fs66/witness-p11-l2-k4/witness.json; echo $?` → last line `CERTIFIED by fs66_check_witness …`, status 0 ·
`python3 tools/fs66_check_witness.py --controls data/fs66/witness-p11-l2-k4/witness.json; echo $?` → `ALL CONTROLS BEHAVED`,
status 0 · `grep -nE "^(import|from) " tools/fs66_check_witness.py` → standard library only · `wc -l
data/fs66/witness-p11-l2-k4/records.jsonl` and a recount of its verdicts by the owner's own script.
- [ ] `tools/fs66_check_witness.py` exists, imports only the standard library (`grep -n "^import\|^from" ` shows nothing from `tools/`), and `--controls` prints one line per planted fault with the **expected refusal code** and ends `ALL CONTROLS BEHAVED`; `data/fs66/witness-p11-l2-k4/controls.out` is that output.
- [ ] `data/fs66/witness-p11-l2-k4/check.out` ends `CERTIFIED`, and names the point count, listed-edge count, induced-edge count, clause count and proof-line count.
- [ ] the witness regenerates from the definition by a documented command in `data/fs66/README.md` (CaDiCaL is deterministic at a fixed seed; say the seed).
- [ ] the minimiser's checkpoint and resume were **exercised**: the log shows one deliberate kill (by PID) and a resume that redid at most one wave.
- [ ] the four-solver no-pin recheck (M2's shape) is rerun on the final witness and recorded in §D's record shape.
- [ ] P1, P2 scored in the plan's §R.

### Phase 1b — the kernel theorem (I2). Checklist:
*Scoring:* the digests under `build/gate/{build,axioms,vacuity}/latest` (`scripts/gate-log.sh`; read them before re-running a
gate); `grep -rn --include="*.lean" sorry Proofs/` empty; `#print axioms HadwigerNelson.chromaticNumber_unitQuadrance_zmod121`
in `scripts/Axioms.lean`'s output reads exactly `[propext, Classical.choice, Quot.sound]`.
- [ ] measured first: CPU seconds (user+sys, minimum of three) and peak RSS of the clause-table module and one segment, **written in the plan before the full build**.
- [ ] `./scripts/build.sh` green; `grep -rn --include="*.lean" sorry Proofs/` empty; `./scripts/axioms.sh`: the three new theorems on the standard three axioms, no `native_decide`; `./scripts/vacuity.sh` and `--self-test` green, counts reconciled against `CLAUDE.md` § The gate (a silent change in counts is that gate's failure mode).
- [ ] three negative controls each **seen red, restored, re-verified green** (I2), recorded with the error text.
- [ ] `tools/check_architecture.py` green with the new modules in `ARCHITECTURE.md`.
- [ ] the final statement read aloud against the informal claim, and the reading recorded in §R in one sentence.

### Phase 1c — level three's refusal, certified the same way (optional; the owner's call after 1a) 
M6 refused four colours on a 134,915-vertex piece of `UD(ℤ/1331, 2)` in 135 s with **no proof kept**. The same recipe applies:
rerun with `--lrat --no-binary` (expect a proof of tens of MB; **11 GB of memory — nothing else heavy beside it**), extract the
core by backward reachability, iterate to a fixpoint, and hand the result to Phase 1a's checker at `n = 1331` (it takes `n` as
data; the packing width becomes 21 bits). *Worth it because* it turns "level three, one solver's word" into a second
`CERTIFIED` witness at the price of one more run, and a small core would make `χ(UD(ℤ/1331, 2)) = 5` a second kernel theorem
through unchanged Lean (`unitPairNat 1331`). *Not worth more than half a day:* if the level-three core does not fall below
≈ 20,000 vertices after the fixpoint rounds, record the size and stop. Checklist: the record in `data/fs66/witness-p11-l3-k4/
records.jsonl`; `check.out` ending `CERTIFIED …` or the stop recorded with the core's size per round.

### Phase 2 — the whole tower at 11 (I3, then I4's price; I6 rides along). Checklist:
*Scoring:* `data/fs66/b1/records.jsonl` holds one record per solve with the bound's value at 10, 30, 60, 120 minutes as
fields; `data/fs66/b1/gurobi-p11.log` exists and its last bound matches the record; `data/fs66/b1/moment-price.md` exists and
its first line is the `p = 7` reading against 16.33.
- [ ] `tools/fs66_b1_global.py` reproduces M9's control: at 7 with cuts and symmetry the bound crosses 16.333; **and its planted fault**: with the symmetry break replaced by an *unsound* one (`φ₀ ≥ 0.9`) the control must be flagged by a second, sound run disagreeing — the point being that an unsound break is invisible from inside one run.
- [ ] `data/fs66/b1/gurobi-p11.log` committed with a line per minute; the kill line's verdict stated with the bound's trajectory (value at 10, 30, 60, 120 minutes); cause / measurement / forfeit written **before** any stop.
- [ ] `data/fs66/b1/moment-price.md`: the `p = 7` moment-relaxation reading and the one-page price for 11 (I4). No 11 solve.
- [ ] I6: the 686 control found from a random start (or the instrument declared void); the 687 ask's verdict in §D's shape.
- [ ] P3, P4, P6 scored.

### Phase 3 — 19, then 23 (I5, I7). Checklist:
*Scoring:* in `data/fs66/level2-p19-k4/records.jsonl` the level-ONE record's `utc` precedes the level-two record's; a SAT
record's `artifact` passes `python3 tools/fs66_owner_verify.py colouring <artifact>`; an UNSAT record's witness passes Phase
1a's checker; `data/fs66/level1-p23-k5/cube-sample.jsonl` precedes `cubes.jsonl` and `summary.json` carries the projection
beside the measured rate.
- [ ] level one `(19, 4)` refused under edge pin + precedence, conflicts and CPU time recorded — **before** level two is asked.
- [ ] level two `(19, 4)` in the biclique encoding with precedence: verdict in §D's shape; if UNSAT, a witness `CERTIFIED` by Phase 1a's checker (which is why it takes `n` as data); if SAT, the colouring VERIFIED by the owner's verifier and the owner told at once; if UNKNOWN, the cube sample's projection beside the measured rate.
- [ ] I7(b): the 16-cube sample, the projected total, the owner's go/no-go recorded, then the run within its 8-hour budget, checkpointed and resumed at least once on purpose.
- [ ] I7(c) only on (b)'s refusal; I7(d) only on the owner's word, with its positive control first.
- [ ] P5, P7 scored; the census brackets (`4 ≤ χ ≤ 5` at `d = 47, 311, 335`, row 74) restated as unchanged by level two.

### The close (WORKFLOW steps 8–10) is the owner's; the implementer hands over: §R filled, `data/fs66/README.md`, the sweep of this plan for "conjecture" and "not claimed" (there are two: §S3 and §S5), and the list of what §PA taught (PA.6) checked against what the milestone then found.

---

## §T. Traps and dead ends found while planning — so nobody walks into them again

1. **A pin is sound only while its clique is in the graph.** The planner's first core-shrinker dropped the pinned triangle's
   edges when the refutation did not use them; the next round's "core" was 4-colourable. Keep the clique's edges in every
   round; the checker's step (3) is the guard.
2. **`/usr/bin/time` does not exist on this machine**, and a `… | grep` after it turns "command not found" into silence. Read a
   solver's exit status from the solver (10 SAT, 20 UNSAT, 0 unknown); write output to a file and grep the file.
3. **CaDiCaL's second positional argument is a proof file, not a model file** — the first version of the planner's asker
   handed it a `.model` path and got binary DRAT. Models come from stdout (`v` lines) or `-w`.
4. **`-t` is wall-clock seconds.** Prefer conflict budgets for anything compared across runs.
5. **`ϑ′`, first-level SDPs and LPs with pulled-back-feasible constraints cannot refuse anything at level two** (§S6): their
   level-one optimum pulls back. Do not run them.
6. **A level-two refusal says nothing about level three, and nothing about the `p`-adic plane** (§S2; the stub's first draft
   had this wrong). Only a level-one certificate of `B₁` speaks to every level.
7. **"Unions of parallel lines" is a dead family of level-two independent sets** (owner's note §4): a used line silences six of
   its eleven parallels; the family tops out near 16–27 of 121 against 28. And **balanced fibres are tiny** (M10).
8. **The owner's first `(11, 4)` probe never ran** (`cd X && (A) & (B) &` put the second subshell in the repository root and
   left `b-11-4.err` saying the CNF did not exist, wall 0 s). A probe that reports nothing because it could not run reads like
   a slow solver. Check that the artifact a run should write exists and is non-empty before reading its silence.
9. **Gurobi's size-limited licence** stops at 2,000 variables or constraints: the 11 model fits (121 and ≈ 1,340); 19 (361
   variables, 3,610 edge cuts) does not — drop to SCIP there, or to a subset of the cuts.
10. **`build/` is scratch that agents clean.** Venvs with pip-installable contents may live there; checkpoints, node files
    and logs may not.

---

## §W. Decisions that were the planner's, in four parts (choice · alternative · why · confidence)

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| **Ask the whole graph directly before building any finder** — which answered the pilot | the brief's order: periodic asks, then an independent-set finder, then blind search, with a GPU finder priced | a direct CDCL ask with a triangle pinned costs seconds to try and is decisive in both directions; G65 says degree 132 is far past the hard band, so it would answer fast or not at all | high (it ran) |
| **No new finder, no work order in `~/source/descent-engine`, no GPU search in this milestone** | (a) a work order there adding `UD(ℤ/p^r,2)`; (b) a standalone tabu finder; (c) a CUDA finder | the only finder ask left is `UD(ℤ/529,2)` at five colours, whose null is the predicted outcome and teaches little (I7(d)); CaDiCaL on the biclique encoding already finds non-pulled-back colourings at this scale (M3). If a later milestone needs sets or colourings on rings, the work order's content is one paragraph: *accept a modulus `n` that is a prime power, build the circle from `a² + b² ≡ 1 (mod n)`, keep `check` independent, and add a line-move neighbourhood (S1)* | medium-high — changes if the owner wants I6 pushed hard, where (a) would be the right tool |
| **The GPU is used only for I4, and only after its price is ruled on** | running the four-class or single-class SDP at once on card A | the relaxation's margin is thin (cannot read below 29.18, must read below 30.25) and unmeasured; a `p = 7` reading costs a CPU-minute and decides whether the route exists | medium |
| **Subset semantics for the witness's edge list** (listed pairs must be unit; not "all unit pairs must be listed") | FS-58's equality semantics | a refusing subgraph refutes every supergraph, the kernel pays per clause, and the checker still reports the induced count so nothing is hidden | high |
| **Level one is always asked before level two** | asking level two alone, as M11 did | §S6: level two's refutation is at least as long; level one's count prices it and catches an encoding that cannot refuse even the easy case | high |
| **`B₁` with cuts is the registered quantity; the bare `B₁` a control** (the owner's suggestion, adopted) | certifying the bare problem | at 11 the bare problem's near-ties (27.9995) exist only because `c < 2` by a hair; the cuts are true at every level and M9 shows they move the bound (19.95 → 18.04 → 16.165 at 7) | high |
| **One packed natural-number literal for the vertex table + one bridging `iff`, generic in `n`** | a table of `ZMod 121` literals and `decide` on `unitQuadrance` adjacency | FS-38 measured 32.9 GB and a timeout for literals at an unsimplified index against seconds for evaluating on naturals | medium-high — to be measured in Phase 1b, which is the point of measuring first |

---

## §E. The modeling passes (WORKFLOW step 5) — what each changed

**Domain modeling (fresh invocation, 2026-09-20).** *Grokked by executing:* every statement below elaborates and every
`#guard` passes under `lake env lean` with `autoImplicit false`. *The one cut, applied:* **intrinsic** — the ring-hom
functoriality of colourability (so the minted lemma is `unitQuadrance_colorable_of_ringHom`, generic in the rings, proved in
two lines, and the `ZMod` tower statement is its corollary along `m ∣ n` — which also covers CRT composites and `ℤ` at `n = 0`);
the edge check as one predicate in two costumes joined by an **`iff`** (the first draft had only the forward implication, which
left the negative `#guard`s meaning nothing); `1 < n` as the single hypothesis doing both jobs (the adversaries: at `n = 1`
the check says *true* of a point and itself; at `n = 0` its subtraction truncates). **Incidental, and quarantined in
generated data:** `121`, the core, the packing width 14. *Placement:* nothing is indexed — no `residuePlane p k` abbreviation
is minted (one instance; and a `ZMod (p ^ k)` index is paid per numeral). *Ugliness read:* a position-indexed vertex table
(`![…]` or `List.get`) is linear per access × 8,810 accesses — replaced by one packed literal (the repository's own `Sat/Mask`
idiom); two CNF builders (checker, kernel pipeline) are one concept in two costumes — joined by a digest-equality control
and one stated clause order (`tools/coloring.py`'s). *Seams:* the checker's "no point twice" is hygiene, not soundness, and
says so; §S1 now states the level-two structure intrinsically (quotients `Λ_σ`, not chosen coordinates) and says which part
is generic in the level (consecutive levels) and which is not (level `k ≥ 3` over level one), which is *why* the
level-generic model is the fibre density over level one. *Next-lemma test:* `(19, 2)` needs no new Lean vocabulary —
`unitPairNat 361`, the same `iff`, the same pipeline.

**Obligation modeling (fresh invocation, 2026-09-20).** *Partition:* **prove** — the ring-hom transfer, the tower's
monotonicity, the bridge `iff`, the homomorphism from the listed graph, the headline; **test** — the `#guard`s and the
adversary `example` (spec sanity: the instruments that catch a wrong statement); **assume** — nothing: no theorem here takes
a hypothesis a caller must discharge beyond `m ∣ n` and `1 < n`. *Derived by attempting, reading each stuck goal as a
report:* none stuck — the first draft's single bridging lemma split into **three children, each two to four lines**
(`unitQuadrance_adj_iff_quadrance`: nontrivial ring ⟹ the inequality is free; `natCast_add_self_sub_mod`: the shifted
subtraction is subtraction; then the bridge is `rw` + `push_cast` + `rfl`), and the monotonicity lemma is one term through
`chromaticNumber_le_of_forall_imp`. **The whole generic layer is now proved in the plan**, so Phase 1b's proof burden is one
`sorry` with a six-row decomposition whose leaves are `decide +kernel` or generated. *Reduction to a named theorem:*
`Colorable.of_hom`, `chromaticNumber_le_of_forall_imp`, `chromaticNumber_eq_iff_colorable_not_colorable`,
`ZMod.natCast_eq_natCast_iff'`, `ZMod.natCast_self`, `ZMod.natCast_mod` — every name taken from the elaborator's acceptance
today, none from memory. *Adversarial validation:* `1 < n` and `NeZero n` each certified load-bearing by a counter-model;
the mutation audit is written into §L for the implementer to run against the real build.

**Experience modeling (fresh invocation, 2026-09-20).** *Crossed the wire for each consumer and took only the bytes.*
**The Lean API's users** (the next instance; `exact?`; `simp`): the first draft made every user write `haveI : Fact (1 < n) :=
…` before each call — an instance everyone supplies by hand is the argument being the bug — so `1 < m` and `1 < n` are now
**explicit hypotheses discharged inline** (`by norm_num`), and the plan carries the two-line consumer paths as `example`s that
elaborate; the `ZMod` cast lemma moved into Mathlib's namespace, where this repository already keeps such facts; the halves of
the headline are named object-first (`unitQuadrance_zmod121_not_colorable_four`, `…_colorable_five`), the pattern
`finitePlane11_*` taught; `unpackPt` takes `(n, w)` because its second use is already planned; and **nothing is tagged
`@[simp]`** — `unitQuadrance_adj` owns that left side and its normal form, and a second rule there would fork the set.
**The checker's reader** holds only its output: it now states its claim in a plain sentence, carries three digests including
its own, prints its trust word so `CERTIFIED` cannot be read as the kernel's, refuses from a closed list of codes with the
first offending item in the reader's vocabulary, and accepts-and-ignores nothing. **The owner recounting** gets one
`records.jsonl` per directory, flat typed fields (the limit and the restriction were free text), the exact command, and
`UNKNOWN` as a first-class record. **The owner scoring a phase** gets the commands to run and the line each must print.
**The implementer arriving cold** gets §G. *Breakdown designed first:* every refusal code exists because a plant in
`--controls` provokes it.

---

## §R. Results — filled by the implementer, phase by phase (predictions scored here; decisions implementation overturned, in four parts)

### Phase 1a — the witness, its checker, and the minimal core (2026-09-20/21, one Opus implementer)

**What landed.** `data/fs66/witness-p11-l2-k4/` holds an **883-point, 3,441-edge subgraph of `UD(ℤ/121, 2)`
that cannot be four-coloured**, with its LRAT refutation, `CERTIFIED` in 0.08 s by
`tools/fs66_check_witness.py` — standard library only, importing nothing from `tools/`, taking `n` and `k`
from the witness. 23 planted-fault controls each refuse **for their named code**, a faithful twin passes
through the same scaffolding, a second CNF builder (`tools/coloring.py`) agrees on the formula's SHA-256, an
all-pairs test agrees with the circle walk, and the committed files come back byte-identical afterwards.
Four other solver codebases refuse the bare edge list **with no pin and no symmetry breaking at all**
(glucose4 1.0 s, minisat22 0.9 s, cadical153 1.0 s, maplechrono 5.2 s) and all four five-colour the same list
with the model verified on every listed edge. The graph is **1-minimal in vertices**: all 880 deletable points
probed against this exact graph under a 300,000-conflict budget, every deletion four-colourable, **no probe
undecided**. `data/fs66/README.md` is the map and carries the five-command regeneration recipe (seed 2
throughout). Two earlier stages (2,974 and 996 points) are committed in the same format and also `CERTIFIED`,
so Phase 1b can measure the kernel on a large instance before choosing. **Nothing is kernel-checked**;
`CERTIFIED` is this checker's word and says so on its own last line.

**Scored: P1 — the checker half WON, the kernel half is Phase 1b's.** 883 vertices, inside the predicted
600–1,115 band, `CERTIFIED`. The `< 15 min / < 12 GB` half is not this phase's to score.

**Scored: P2 — one third won, two thirds lost.** *"Fewer than 300 vertices come off"* — **won**: 996 → 883
from this phase's own fixpoint, 1,115 → 883 against the planner's. *"Vertex-minimising is slow … in the
two-hour budget"* — **lost, by three orders of magnitude**: 2,656 probes, 56 accepted deletions, **15.7
seconds** on sixteen cores, stopping at provable 1-minimality rather than at any budget. *"Probes turn
UNKNOWN as the average degree falls toward 7"* — **lost**: zero of 2,656 probes undecided at a final average
degree of 7.8, and the hardest accepted probe used ~1,700 of its 300,000 conflicts. The mechanism P2 was
reaching for is real but appears elsewhere and as *conflicts*, not as `UNKNOWN`s: under **edge** deletion the
probes climb to 120,000–150,000 conflicts each and slow to one edge per seven seconds.

**The finding that should change Phase 1b's plan.** *The kernel pays for the proof, and past a point graph
size and proof size move in opposite directions.* Deleting edges as well as vertices takes the graph from
3,441 to 3,090 edges — a 10 % smaller clause table — and makes CaDiCaL's refutation **100× harder** (1,503
conflicts → 148,524) and its **LRAT 71× larger: 55.9 MB / 204,288 lines against 784 KB / 3,023 lines**
(`data/fs66/ckpt/minimise-resume-exercise.log`, and the measurement is one `fs66_tower.py witness` call on
each). So §I1's *"the aim is a cheaper kernel check, not a record size"* needs its sharper form: **shrinking
past the point where the refutation stops being easy makes the kernel check more expensive, not less.** The
committed witness is the vertex-1-minimal graph with the small proof; `--mode edges|both` stays in the tool,
unused.

**Decisions, in four parts.**

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| **Commit the vertex-1-minimal graph (883 v / 3,441 e); keep edge deletion in the tool, unused** | commit the edge-minimised 883 v / 3,090 e, with 10 % fewer clauses | measured: its proof is 55.9 MB against 784 KB, because its refutation costs 148,524 conflicts against 1,503 | high on the measurement; **medium on the ranking**, because nobody has yet measured whether the kernel's cost is dominated by the clause table or by the LRAT replay — Phase 1b decides that, and the two stage witnesses are committed so it can |
| **The production pipeline drops the `shrink` step**: round-0 core → minimiser, four commands | keep `shrink` in the path, as §I1 and `data/fs66/planner/README.md` do | the minimiser re-extracts an LRAT core after every acceptance, which is what `shrink` does; measured over eight seeds, round-0 → minimise lands at **883** where round-0 → shrink → minimise lands at **888** | high (eight seeds, all landing at 888 with the shrink step and 883 without) |
| **Write `tools/fs66_mutation_audit.py`: remove one test at a time from a COPY of the checker and require the control rows that exist to catch it to go red** | rely on the planted-fault controls alone, which is all §I1 asks for | a control row whose failure mode is unreachable passes exactly like one that works. It **found a real gap**: no plant isolated the "every added clause id must be fresh" test, so that test was passing untested — now control 19, a proof line re-adding clause id 1 with a derivation that is itself valid RUP | high — it changed the artifact |
| **Three refusal codes beyond §I1's list**: `BAD_WITNESS`, `BAD_EDGE`, `PROOF_MALFORMED` | force the nine listed codes to cover structural faults | §I1 requires an unknown JSON key, a `k` below the pin's size and an empty edge list each to be *"refused by name"*, and none of the nine names them; and a proof line that is not integers is not a bad hint | high |
| **One `records.jsonl` at `witness-p11-l2-k4/`, covering its `stages/` subdirectories too** | one per subdirectory | §D's promise is that `cat data/fs66/*/records.jsonl` is the whole milestone, which is one glob level | high |
| **The kill-and-resume exercise runs on the edge-deletion mode, not the production run** | slow the production run artificially (`--workers 1` gives ≈ 4 minutes) | the production run is 15.7 s end to end; the tool, the checkpoint code and the resume path are identical, and an artificially slowed run exercises scheduling rather than recovery. The log says plainly why, and that the run's product is deliberately not the witness | medium-high — it meets the checklist's intent; say the word and `--workers 1` interrupts the production path itself |
| **The minimiser solves its own final graph before writing anything** | trust the accepted deletions | the loop only ever solves graphs one item *lighter* than the state; if the state itself were colourable, every probe would answer SAT and the run would report "1-minimal" about a graph that refuses nothing. It now asks the graph directly and refuses to write `--out` unless the answer is UNSAT | high |
| **The stall rule reads the RECENT acceptance rate, not the lifetime one** | leave it as first written | as written it divided all acceptances by the whole elapsed time, so a run that accepted quickly for an hour and has accepted nothing for ten minutes still reads as healthy — the rule could not fire | high |

**Where the plan or the brief was wrong, or is now out of date.**
1. **§I1's stop rule, and the whole two-hour budget, are aimed at a step that costs 16 seconds.** Nothing in
   Phase 1a was compute-bound. The budget, the 200-probe stall and the five-minute rate test all exist and all
   went unused; the run stopped at 1-minimality.
2. **§I1's refusal-code list does not cover the faults its own next sentence demands be refused by name**
   (decision four above).
3. **§I1's `n → 120` plant is refused at step 1, not step 2.** Point 27 of the witness is `(0, 120)`, which
   leaves `(ℤ/120)²` before any pair is tested, so the code is `BAD_POINT`. The control accepts either code and
   prints which fired; a *modulus doubled* plant (`n → 242`) was added, which does reach the unit-pair test and
   names the first offending edge with its quadrance.
4. **`data/fs66/planner/` was not used at all.** The committed witness descends from a fresh
   `fs66_tower.py build/ask/core` run, so the artifact depends on no frozen scratch file. The planner's core
   and this one differ (2,713/1,115 against 2,974/996 at the same stages) only because the pinned triangle is
   chosen differently; both reproduce §M's graph exactly — **14,641 vertices, 966,306 edges, UNSAT in 1.4 s at
   1,412 conflicts**, against §M's 1.7 s and 1,535.
5. **§D's record shape has no honest slot for a non-solver verdict.** The checker's own `CERTIFIED` is filed as
   `solver: "fs66_check_witness (no solver)"`, `verdict: "UNSAT"`, with the trust word carrying the meaning.
   A `verdict: "CERTIFIED"` value would be cleaner if §D is ever revised.
6. **The brief's "keep the round-0 and fixpoint witnesses" is honoured, but "fixpoint" is no longer a stage of
   the production recipe** (decision two). Both are committed under `stages/` and regenerate from the same
   round-0 core.

**Two process notes, because both are instances of rules already in `CLAUDE.md`.** *(a)* `nohup … & echo $!`
reported **2631420** while the process that mattered was **2631423** — the wrapper-shell trap, met exactly as
written. Every kill and every wait in this phase therefore found its target by reading `/proc/<pid>/cmdline`,
never by `pgrep -f`. *(b)* A waiter written as `until ! kill -0 $(pgrep -u $USER -f "fs66_minimise.py.*edgetest")`
was armed and then caught before it ran: the shell executing it carries that pattern in its own command line,
so the condition could never become false. That is the eight-times-recorded self-match bug wearing a waiter's
costume — it does not kill the wrong process, it waits forever, and it looks exactly like a job that never
finished. *(c)* A kill aimed at the production run returned `No such process`; **verified by effect** rather
than assumed either way, the run had already exited normally 15.7 s after launch, with its own `stop:` and
`final:` lines in the log. Nothing crashed. The log carries the correction directly under the kill header.

**What Phase 1b needs, beyond `data/fs66/README.md`.**
* The witness's CNF is **3,532 variables, 14,650 clauses, SHA-256 `2f2c2015…`**, and `tools/coloring.py`
  reproduces that digest exactly (controls row 2), so `tools/emit_mask.py` must be handed **this edge list in
  this order** — the LRAT addresses clauses by position.
* The pin is witness indices `[0, 27, 430]`, i.e. the points **(0, 0), (0, 120), (47, 60)** — the same
  triangle §L's `#guard`s already use, at different indices.
* Every point's packed id `a·121 + b` is at most **14,618 < 2¹⁴**, so §L's `unpackPt 121 14` is right as
  written.
* Three instances to measure on, all `CERTIFIED`: **883 v / 3,441 e / 14,650 clauses / 2,642 proof lines**,
  **996 / 4,283 / 18,131 / 3,023**, and **2,974 / 14,190 / 59,737 / 2,990**. Note the proof lengths barely
  differ while the clause tables differ 4× — which is the sharpest available hint about which of the two the
  kernel's cost follows, and measuring the 2,974-point one first answers it.
* If a smaller instance turns out to matter, the lever is **not** more minimisation of this object: it is
  1-minimal, and edge deletion makes the proof 71× larger. A different seed changes nothing material (eight
  seeds all land at 888 ± 0 vertices through the shrink path).

---

### Phase 1b — the kernel theorem (2026-09-20/21, one Opus implementer)

**What landed.** **`chromaticNumber_unitQuadrance_zmod121 : (unitQuadrance (ZMod 121)).chromaticNumber = 5`**
[kernel, axioms exactly `[propext, Classical.choice, Quot.sound]`, no `native_decide`] — the first kernel
statement about a level-two residue plane, and the pilot closed with a certificate instead of a solver's word.
Two modules and one generated family:

* `Proofs/HadwigerNelson/ResidueTower.lean` — §L's generic layer, unchanged in substance: colourability pulls
  back along any ring homomorphism (`unitQuadrance_colorable_of_ringHom`); the ceiling is monotone along
  divisibility (`chromaticNumber_unitQuadrance_zmod_le_of_dvd`, the kernel form of `[Madore2015]` Prop. 3.8's
  second inequality, covering the tower, CRT composites and `ℤ` at `n = 0`); the per-pair check `unitPairNat`
  with its one bridge `unitPairNat_eq_true_iff`, **generic in `n`**, so Phase 3a's `n = 361` reuses it with no
  new Lean; `unpackPt`. `1 < n` is explicit and both counter-models (`n = 1`, `n = 0`) are `example`s in the file.
* `Proofs/HadwigerNelson/Instances/ZMod121Four{.lean,/Pts.lean,/Edges.lean,/Cnf/}` — Phase 1a's 883-point,
  3,441-edge witness through the M05 pipeline, composed with its pinned triangle through `Gadget`. The lower
  half is `unitQuadrance_zmod121_not_colorable_four`; the upper half is `finitePlane11_colorable_five` pulled
  back along `ZMod.castHom (11 ∣ 121)`, with no data at all.
* `tools/fs66_emit_lean.py` — the driver: it writes `Pts.lean` (the vertex table as one packed literal) and
  `Edges.lean`, checks that the formula it would build has the witness's own recorded CNF digest before
  emitting anything, and hands the rest to `tools/emit_mask.py`. Untrusted; a mistake in it can only produce
  modules that fail to build.

**The measurement, made before the full build** (desktop; `lake env lean` with the lakefile's options;
CPU is user + sys; minimum of three runs where marked, single runs otherwise).

| module | instance | table slots | proof hints | CPU s | peak RSS GB |
|---|---|---|---|---|---|
| `Cnf/Table.lean` | **the witness**, 883 v / 3,441 e | 16,262 | — | **31.59** (min of 3) | **6.14** |
| `Cnf/Seg000.lean`, 2 segments | the witness | — | 96,820 / 2 | 79.57 (min of 3) | 14.01 |
| `Cnf/Seg000.lean`, **8 segments** | the witness | — | 96,820 / 8 | **29.32** | **5.18** |
| `Cnf/Table.lean` | `stages/round0`, 2,974 v / 14,190 e | 61,484 | — | **616.57** | **20.84** |
| `Cnf/Seg000.lean`, 8 segments | `stages/round0` | — | 95,653 / 8 | **23.70** | **5.16** |

Whole family, as built: **≈ 4.4 CPU-minutes and a 6.14 GB peak** (the clause table; every segment is smaller),
against P1's 15 CPU-minutes and 12 GB.

**Scored: P1 — the kernel half WON, on both numbers.** 4.4 CPU-minutes against 15, 6.14 GB against 12. It is
worth saying *how*: at the emitter's natural 2-way split the peak is **14.01 GB**, which is over P1's 12 GB, so
the prediction was met by a choice made inside the phase (eight segments) and not by the object. P1's checker
half was already won at Phase 1a.

**The finding, and it is the sentence to keep.** ***The kernel has two charges and they are paid on
different things: the clause table is the graph's bill, the segments are the proof's.*** Two `CERTIFIED`
instances of the same refusal, with proofs of the **same length** (96,820 against 95,653 hint entries, a 1.2 %
difference) and clause tables differing **3.8×** (16,262 against 61,484 slots):

* the **table** check costs **19.5× more CPU and 3.4× more memory** on the bigger graph (31.6 s / 6.14 GB
  against 616.6 s / 20.84 GB) — and super-linearly, since `3.8² = 14.3` is nearer to 19.5 than `3.8` is;
* the **segments** cost the *same* on both (29.3 s / 5.18 GB against 23.7 s / 5.16 GB) although one graph is
  3.8× the other — indeed the bigger graph's segment is the cheaper one, so **the graph does not enter the
  segment charge at all**. Whether that charge is exactly proportional to the proof was not measured: these two
  proofs differ by 1.2 %, which is too little to fit a slope to.

**Which charge dominates is a function of size, and the crossover is between these two objects.** On the
committed 883-point witness the segments are **88 %** of the 4.4 CPU-minutes and the table 12 %; on the
2,974-point stage the table is **76 %** of 13.4 CPU-minutes and the segments 24 %.

**So Phase 1a's two levers are both real, and they are charged at different counters.** Vertex minimisation
buys the *table* down super-linearly — 19.5× between these two objects. Edge minimisation past vertex
1-minimality makes the proof 71× larger, which is a multiplier on the *segment* charge, i.e. on the 88 % that
dominates at this size. Phase 1a's decision to commit the vertex-1-minimal graph is right; its stated reason,
"the kernel pays for the proof", is the larger half of the truth **at this size only**, and it misses the
table charge entirely — which is the one that would have bitten had the object not been minimised.
**The operating rule for every later certificate: minimise vertices while the refutation stays easy, then
stop; and expect the table charge to take over as the graph grows.**

**Decisions, in four parts.**

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| **Eight certificate segments, not the emitter's natural two** | `--segments 2`, which is what an instance this size suggests and what `Instances/SqrtEleven/Cnf/` uses | measured: peak RSS per segment 14.01 → 5.18 GB, CPU 79.6 → 29.3 s, and the eight elaborate in parallel. Total CPU rises 159 → 234 s, which buys a peak under P1's 12 GB and a wall clock of one segment instead of four | high on the measurement; **medium** on eight being the right number — 4 and 16 were not measured, and the marginal fit (`≈ 12.5 s + 4.6 s per certificate chunk`) says the per-segment overhead is small but not zero |
| **One name prefix, `zmod121Four`, for the whole object** | §L's two prefixes — `zmod121Core*` for the graph, `zmod121Four*` for the certificate | `emit_mask.py` derives every certificate name from a single `--name`, so two prefixes make a reader ask which half of one object a name belongs to; `Instances/TwoAdicFive` uses one prefix throughout and reads better for it. The theorem names are §L's unchanged | high |
| **The packed vertex table gets its own module `Pts.lean`, importing only `Mathlib.Data.Nat.Notation`** | keep it beside the edge list, as §L's "GENERATED: `zmod121CorePacked`, `zmod121CoreEdges`" reads | `ARCHITECTURE.md` § 3.10's rule — geometry never sits upstream of a certificate. `Cnf/Table` imports the edge list; had the packed literal sat there, re-emitting the geometry would re-check all eight segments | high |
| **All fourteen new records go into `scripts/Axioms.lean`'s CLEAN section**, including the two generated ones | name only the three headline theorems | the audit is the trust receipt, and the records where a native purchase could hide are exactly the generated `zmod121Four_agrees` and `zmod121Four_unsat`. Both read `[propext]` | high |
| **`scripts/vacuity-baseline.txt`'s recorded counts updated in this phase; `CLAUDE.md`'s reported to the owner instead** | leave both stale and report both | the baseline's header is the gate's own tripwire, and it prints `RECORDED COUNTS ARE STALE` until it matches — a line that is always red trains its reader to skip it. `CLAUDE.md` is the owner's file, so its § Trust ledger and § The gate counts are in the hand-over and not edited here | high |

**Negative controls — four planted, each seen red for its named reason, restored, and re-verified green.**

| plant | what went red |
|---|---|
| **A.** drop `(hn : 1 < n)` from `unitPairNat_eq_true_iff` | `failed to synthesize instance … Nontrivial (ZMod n)` and `omega could not prove the goal` for `NeZero n` — the hypothesis is load-bearing at **both** of the two places §L claimed, and the `n = 1` `example` below it then fails to elaborate as well |
| **B.** move one point of the packed table (point 0, `(0,0) → (0,1)`) | ``Tactic `decide` proved that the proposition (zmod121FourEdges.all fun e => unitPairNat 121 (zmod121FourPt e.1) (zmod121FourPt e.2)) = true is false``, plus the `#guard` on that point and the `Reds` example on the cast |
| **C.** pin a vertex that is not in the triangle (port 2, `430 → 431`) | ``pinCube zmod121FourPorts ![0, 1, 2] = zmod121FourCube is false`` **and** ``List.elem (zmod121FourPorts 0, zmod121FourPorts 2) zmod121FourEdges = true is false`` — the cube and the clique are checked separately and both fired |
| **D.** file the certificate against five colours | `Application type mismatch: zmod121FourCube has type Cube 883 4 but is expected to have type Cube 883 5`, then ``decide failed for zmod121FourClauseTable.agreesWithCNF zmod121FourCnf = true`` |

**The control that could not fire, and the general rule it gives.** As first written, control **B** planted the
fault in `Pts.lean` and then ran `lake env lean` on the *consumer* module — which reads `Pts.olean`, not the
source. **It passed silently**, looking exactly like a control that works. It fires only once the data module's
own `.olean` is rebuilt from the planted source. `CLAUDE.md`'s "a control whose failure mode is unreachable has
not been tested by passing" in a costume specific to this repository: **a fault planted in a generated data
module must be compiled into that module, not only into the file that consumes it** — which is the same fact
that makes generated data cheap to import and expensive to invalidate.

**The final statement, read aloud against Mathlib.** `chromaticNumber_unitQuadrance_zmod121` says
`(unitQuadrance (ZMod 121)).chromaticNumber = 5`, where `unitQuadrance R` is the graph on `R × R` joining two
points whose coordinate differences satisfy `(Δx)² + (Δy)² = 1`, and `SimpleGraph.chromaticNumber` is
`⨅ n ∈ {n | G.Colorable n}, n` in `ℕ∞` — so it says, in the informal claim's own words, **the unit-distance
graph over the ring of integers modulo 121 needs exactly five colours**: five suffice and four do not.

**Gate counts, for `CLAUDE.md` (the owner's to write).** Axioms: **990 → 1004 clean**, 10 axiom-free, **5
declared purchases unchanged** (all five are M03's, none is this phase's); every one of the fourteen new records
is clean, and `chromaticNumber_unitQuadrance_zmod121` reads exactly `[propext, Classical.choice, Quot.sound]`.
Vacuity: **declarations 6632 → 6723, refutations-skipped 268 → 270**; `sites=262 vacuous=0 stale=0 declared=3
witnessed=17 generic=240 unknown=2`, all unchanged, with `unitQuadrance_zmod121_colorable_five` added as
evidence; `--self-test` OK, every control fired. `tools/check_architecture.py` **PASS**.

**A process note, because it is this file's own rule catching its own author.** The finding above was first
written as *"the kernel pays for the clause table, not for the proof"* — and then failed the arithmetic check
that `CLAUDE.md` prescribes for exactly this shape (*when two numbers are compared, exactly ONE thing may
differ*). The measurement varies the **graph** at a fixed proof length; it says nothing about varying the
proof, and multiplying out the eight segments shows the proof is **88 %** of the committed witness's kernel
cost. Both halves of the corrected sentence are in the same table; the wrong version was one sentence reading
one column of it. The check that caught it was three lines of arithmetic over numbers already collected.

**Where the plan, Phase 1a's hand-over or the brief was wrong, or is now out of date.**
1. **§L's generic layer elaborated as written and needed no repair** — its one blind spot was the thing
   `lake env lean` cannot see: a module with no `import` does not have `ℕ` (it is `Mathlib.Data.Nat.Notation`'s,
   not core's), which the generated `Pts.lean` hit on its first build. One line.
2. **§I2's fallback was never needed.** `Nat.shiftRight` and `Nat.land` are kernel-accelerated at the 12,362-bit
   width of the packed literal, so `unpackPt` costs one shift and one mask; `zmod121FourEdges_all_ok` —
   3,441 pairs, 6,882 table reads, `decide +kernel` — sits in a module that elaborates in **1.0 s** in the real
   build. The `PtTable`-style balanced tree is not required at this scale and probably not at 19's either.
3. **§I2's "measure on the round-0 witness *before* minimising further" was the right instruction, and its
   answer is the opposite of the one it anticipated.** It said minimisation might stop mattering; the round-0
   object's clause table alone costs 616.6 CPU s and 20.8 GB against the minimised object's 31.6 s and 6.14 GB,
   so Phase 1a's 15.7-second minimisation bought a **19.5×** cheaper kernel check.
4. **The brief's stop rule was not triggered** (4.4 CPU-minutes and 6.14 GB against 15 minutes and 12 GB), so no
   ruling was sought.
5. **§H Phase 1b's three controls and §L's four mutations overlap in three.** The union is four and all four were
   run; the checklist and the mutation audit should say so in one place.
6. **The desktop was not quiet.** Another FS-66 job (`tools/fs66_b1_probe.py`, four threads) ran during part of
   the measurement window. Its visible effect is the 2-segment triple, whose CPU rose **79.6 → 97.7 → 119.3 s at
   a constant 14.0 GB RSS** — the machine filling, not the module. Every number above is a minimum over its runs
   or a single run, so all of them are **upper bounds** on a quiet machine, and the ratios (which is what the
   finding rests on) are between numbers taken minutes apart under the same load. The brief's "one heavy job at
   a time" cannot be honoured by one agent when two are staffed; that is the owner's call and is reported, not
   worked around.
7. **`lake lint` is not green in this repository and was not green before this phase**: one error,
   `HadwigerNelson.CayleyCert.cert23_8` contains an underscore (`CayleyCertificate.lean`, FS-53), in a file
   Phase 1b did not touch. Nothing in the new modules is reported.
