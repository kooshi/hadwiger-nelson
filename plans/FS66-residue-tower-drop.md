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
| M11 | 4-colourability of all of **`UD(ℤ/361, 2)`** (130,321 vertices, degree 380; the owner's biclique encoder, 795,644 variables, 5,617,523 clauses, **an edge pinned and nothing else** — `ω = 2` at 19) | **not decided in 900 s** (≈ 120,000 conflicts at 655 s); one run. Level one's `(19, 4)` time under the same breaks was not measured first — Phase 3a's opening step |

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

(`w = ±s_j(1+pic)` gives `w s̄_j = ±(1 + pic)`; conversely `w s̄_j = ±1 + p·i·c′` has norm 1.) So each point has `(p+1)/2`
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

**What each outcome is worth now.** Phase 1 landing: the first kernel statement about a level-two plane, and the pilot closed
with a certificate instead of a solver's word. Phase 2 landing: *"at 11, local bounds survive at every level of the tower"* — a
theorem about the clopen chromatic number of `ℤ₁₁²`, by a level-one certificate; not landing: a typed null and levels two and
three on solvers' words. Phase 3: a second prime's data point (19), and an honest statement of why 23 is out of reach.
