# FS-58 — four colours over real quadratic fields: the subplan

*Opened 2026-09-17. Stub: `plans/STUB-fractional-four.md`. Read first: `plans/FS58-prelude-seven-cycle-gadget.md` (the seven-cycle,
the family, the 3-adic barrier), `plans/FS56-quadratic-167.md` §2 and §D, `CLAUDE.md` G54, G55, G59, G60. Status tags follow
`CLAUDE.md` § Grokkings. Written for a session with no memory of the opening.*

## §1 The question, and what changed at the opening

**The target.** Our local–global conjecture predicts `χ(F²) = L(F)` whenever the best residue bound `L(F)` is at most 6. For every real
field without `√3` its level-4 clause is open: nothing proves `χ(F²) ≥ 4` for **any real quadratic field**. The three fields in view:

| field | upper bound known | conjecture predicts | what a lower bound of 4 would be |
|---|---|---|---|
| `ℚ(√11)` | 4 (`[Fischer1990]` Thm 9, `N ≡ 3 mod 8`; also the plane at 7) | 4 | **`χ(ℚ(√11)²) = 4` exactly** — the first real quadratic field with χ = 4 |
| `ℚ(√23)` | 4 (the plane at 7, usable since `23 ≡ 3²`) | 4 | **`χ(ℚ(√23)²) = 4` exactly** |
| `ℚ(√167)` | 7 | 6 or 7 | the first step of FS-56's prediction; the stub's headline field |

**The stub's routes were R1 (a ratio-bound equidistribution theorem), R2 (fractional programmes at height) and R3 (SAT on balls).** The
opening measurements (§0) and the prelude's barrier reorganise them around one sharper target, **route C — the chain at three colours**:

> By the chain theorem (G55), a finite unit-distance graph over `F` with two vertices at difference `δ ≠ 0` forced to share a colour in
> every 3-colouring, where `1/δ` is a sum of unit vectors, proves `χ(F²) ≥ 4`. For `d ≡ 2 (mod 3)` with 3 inert, the 3-adic analysis
> (§2 D2–D3) says exactly which `δ` a 3-integral graph can force (`δ ∈ 3·(3-integral vectors)`), that the 3-adic tower forces all of
> them at every level, and that **a finite forcer exists if and only if the infinite 3-integral graph forces the pair** — one yes-or-no
> question per field, with a solver-free screen that kills candidate direction sets.

A second solver-light target came out of the prior-art gate, **route W — forcing by pigeonhole** (§2 D7, after `[Wormald1979]`): a point
set none of whose admissible 3-colourings avoids a monochromatic subset whose unit circles hold an odd cycle. It needs no rigidity; its
first measurement found no such triple at low height (§0 O6). Routes R1–R3 stay, re-scoped (§3 phases C, E). Route C runs first, at **ℚ(√11)** — richest at low height (24 directions outside `ℚ(i)` at
denominator 10, against `ℚ(√167)`'s first at 24; §0 O5) and the field where a landing is an exact value.

## §0 Measured at the opening (2026-09-17), before the subplan — [tools] `tools/fs58_local.py` → `data/fs58/opening/`

* **O1 — the 3-adic residue plane is Hoffman-tight at three colours and rigid** (`tower.out`). `S₁ = Cay(𝔽₉², C)`, `C` the eight-point
  circle, has spectrum `{8¹, 5⁸, 2²⁴, −1³², −4¹⁶}`: `λ_min = −4 = −d/2`, the ratio bound is exactly `81/3`. Its proper 3-colourings with
  the origin pinned to 0 and one neighbour to 1: **8, exhaustively, every one affine** (`x ↦ σ(L(x))`, `L` an 𝔽₃-linear form). Up the
  tower `(O/3^m)²`, `O = ℤ₃[i]`: the least character mean is −1/2 at levels 1, 2, 3, **reached only by the 16 level-1 characters**;
  the least mean of a character primitive at level 2 is −0.234923, at level 3 −0.082770.
* **O2 — local character means under height weighting** (`split-means-3.out`, `dyadic-means.out`) [readings, floats]. At the split
  3-adic place (weight `dt/max(1,|t|)²`): least −0.400000 at level ≤ 2, attained at level 1 (`= K_min/(q+1) = −4/10`); next −0.188.
  **At the dyadic place of `ℚ(√167)`** (`ℚ₂(i)`, weight 4 on the unit shell, which carries 2/3 of the mass): **least −0.750000** at
  level ≤ 2 — below −1/2. Height-weighted unit vectors cannot give a ratio bound above 3 on this field: the 2-integral directions are
  bipartite (the prelude's remark at 2) and carry two thirds of the height measure.
* **O3 — word balls force nothing and are almost all boundary** (`balls.out`). Pairs `(p, p + 3u)`, `u ∈ W_N`, `p` at word depth ≤ 1,
  asked with a planted-rhombus positive control that reads *forced* (and its unplanted twin *separable*): `W₁₄₀` radius 3 (8,353
  points, mean degree 5.62 of 36): 0 of 88 forced; radius 4 (74,533 points, 7.56 of 36): 0 of 200, the first model alone separating
  199; `W₇₀₀` radius 3 (37,641, 5.76 of 60): 0 of 168. A rank-4 ball's shell dominates its volume; balls measure the boundary.
* **O4 — an instrument defect, caught** [method]. A shell-weight LP over the dyadic characters of level ≤ 3 returned optimum 0 with all
  weight on one far shell: every character in the truncated set averages to 0 there, while the omitted higher-level characters see that
  shell as a copy of the unit shell (reading −1). **A truncated dual makes distant support look free** (G21's shape). The correct LP is
  §2 D6; nothing from the artifact is used.
* **O5 — low-height direction counts** (outside `ℚ(i)`, by denominator N): `ℚ(√11)`: 24 at 10, 8 at 12, 24 at 20, 96 at 60;
  `ℚ(√23)`: 8 at 8, 16 at 12, 32 at 24; `ℚ(√167)`: 8 at 24, 8 at 28, 24 at 140. (Scratch count with FS-56's enumerator generalised to
  `d`: `counts.out`.)
* **O7 — tensor products with the stable residue planes are rigid at three colours** (`tensor.out`; found after the subplan's
  commit, and it corrected D3.4). `S₁ × P_q` (the Cayley graph of `𝔽₉² × 𝔽_q²` on pairs of circle points), asked for a 3-colouring
  with `f(0, 0) ≠ f(0, e)`, `e ≠ 0`: `q = 3` (control; `P₃` is 3-colourable) — **Separable, verified**; `q = 7` (3,969 vertices),
  `11` (9,801), `19` (29,241), `23` (42,849) — **Forced (solver claim) for every `e`**, 0–10 s each: every 3-colouring is pulled back
  from `S₁`.
* **O6 — the pigeonhole route (D7) at three points finds nothing in triangle-free fields at this height** (`circles.out`). Independent
  triples `U = {0, a, b}` (`a, b` sums of one to three directions, no unit distance inside `U`) whose union of unit circles, with
  directions in `W_N`, holds an odd cycle: `ℚ(√3)`, `W₂` — **37 of 90** (the positive control); `ℚ(√11)`, `W₆₀` — **0 of 1,292**;
  `ℚ(√167)`, `W₈₄₀` — **0 of 632**. The triples found before the independence filter all contained a unit edge, whose odd cycles run
  through `U`'s own points and constrain nothing. A found cycle is real (missing edges only hide cycles); a zero measures the height
  and the sums of at most three directions.

## §PA — prior-art gate (WORKFLOW 3a), 2026-09-17

**How it was run.** A sweep agent searched for about 90 minutes under the brief's seven questions, in the disciplines' words:
combinatorial geometry (the chromatic number of `ℚ(√d)²`; triangle-free 4-chromatic unit-distance graphs), number theory
(equidistribution of rational points of bounded height on conics and norm-one tori), harmonic analysis and spectral graph theory (the
Hoffman bound on infinite Cayley graphs, its equality case), finite geometry (planes over `𝔽_q`, `q ≡ 1 mod 4`; p-adic planes), and
gadgets. It walked the citation lists of `[Fischer1990]`, `[Johnson1987]`, `[BachocEtAl2014]` and `[MatolcsiEtAl2025]` in OpenAlex and
Semantic Scholar, comparing records by identifier. It saved ten papers, now in `BIBLIOGRAPHY.md`. De Bruijn read the load-bearing
statements himself: `[DutourSikiricEtAl2021]` §5.1 and Cor. 5.2, `[FourUnitVectors2025]` §1, `[BardestaniMallahiKarai2015]` Thm 3.7 and
Lemma 3.8, `[Wormald1979]`'s construction, and `[Moorhouse2010]` §8.2.

**The question: nothing in print gives `χ(F²) ≥ 4` for any real quadratic field.** Every lower bound found stops at 3:
* `[Moorhouse2010]` Thm 8.6, an odd cycle from Pell's equation;
* `[Madore2015]` Props 4.3–4.4, `ℚ(√7)` and `ℚ(√−5)`.

Everything else is upper bounds: `[Moorhouse2010]` Thm 8.1 (`≤ 4` unless `d ≡ 47, 59, 83 mod 84`; **167 ≡ 83**), `[Payne2009]`,
`[AxenovichEtAl2014]` §2. The question is posed only in general: Benda–Perles Open Problem 11.6 (`[Soifer2024]` ch. 11), and
`[Fischer1990]` §1. `[Fischer1990]` Example 4 is the only printed mention of `ℚ(√167)`: no additive colouring with fewer than 11
colours, and no lower bound on χ. Nobody asks whether `χ(ℚ(√11)²) = 4`. The one near remark (Voronov, Polymath16, July 2021, about five
colours): *"without triangles … it must be computationally very hard."* *Not reached, and the likeliest places for a posed quadratic
question:* Johnson's 2000 status report and his 2006 compendium, both Geombinatorics, behind the archive's challenge.

**What the gate changed in this plan.**
1. **The ratio bound is a theorem at every fixed height** (`[DutourSikiricEtAl2021]` §5.1, on `ℓ²(Λ)` for a Cayley graph of a lattice;
   the argument does not use Voronoi vectors). So route R1 needs no limit theorem to *prove* four colours. It needs one weighted `W`
   whose least character mean over the dual 4-torus is **above −1/2** (the sweep wrote "below", a sign slip), with a certified minimum.
   Equidistribution only predicts which `W`.
2. **The obstruction to that is structural, in two places.** Every 3-integral `W` has least mean exactly −1/2 (§0 O1, D1). By
   `[BachocEtAl2009]` §10.1 (reported by the sweep), the infinite graph's spectral bound dominates every finite piece's, so a spectral
   certificate needs 3-non-integral directions *with weight*. The dyadic place under height weights reads −0.75 (O2). The local repair
   is published over `ℚ_p`: `[BardestaniMallahiKarai2015]` Lemma 3.8, where log-uniform weights over valuation shells give Fourier
   transform `≥ −4/((4T+2)(1 − 1/p))`, which is D6.
3. **No uniform additive-character equidistribution statement exists in print for torus points of bounded height.** The ones that do
   exist test other things:
   * `[AkhtariVaalerWidmer2025]` covers exactly our torus (the unit vectors of `ℚ(√d)²`), but only archimedean angles, with
     discrepancy `≪ 1/H`;
   * `[Peyre2003]` tests continuous adelic functions, and an additive character is not one at split places;
   * Batyrev–Tschinkel use multiplicative characters.

   The sweep did not search the automorphic-period literature (Einsiedler–Lindenstrauss–Michel–Venkatesh). **R1's limit is probably new
   mathematics, not a lookup** (phase E decides whether to carry it).
4. **`[FourUnitVectors2025]`: at most four edge directions, three colours.** A four-chromatic witness needs five directions or more, and
   one on five or six would answer their open `χmax(5)`, `χmax(6)`.
5. **`[Wormald1979]` forces by pigeonhole, not rigidity.** Generalised in D7 and measured in §0 O6.

**Prior art for our derivations.**
* **D1:** `χ(𝔽₉²) = 3` is `[Moorhouse2010]` Table 6.1. His residue lemma (§8.2) is stated for primes whose residue field has
  `q ≡ 3 (mod 4)`, where every unit vector is integral. **Restricting the residue map to the integral directions at an inert prime with
  residue `𝔽₉`**, where not every unit vector is integral, is not in `[Moorhouse2010]`, `[Madore2015]` or `[Fischer1990]` as read. The
  mechanism is theirs; the barrier and its use as a design rule are ours.
* **D2:** the Kloosterman bound modulo prime powers is standard (Salié, stationary phase); not re-read, owed before any external claim.
* **D3.1–2:** the chain theorem and prime inversion are GPT Astra's (G55) and `[Fischer1990b]`.
* **D3.4–7** (periodic rigidity, the dichotomy, the quotient screen) and **D7:** not found.

**Negatives recorded** (the sweep's §3): the arXiv API returned 0 for `"chromatic number" AND "quadratic field"` and 0 for
`"rational points" AND "chromatic number"`. Nothing was found for a non-60° rhombus gadget or a "run of three" 7-cycle, for unit-distance
graphs over `ℚ_p²` beyond BMK, for the Hoffman equality case on infinite amenable Cayley graphs, for a height zeta function twisted by
an additive character, or for the smallest 4-chromatic graph of odd girth 7. *Semantic Scholar rate-limited the `[Johnson1987]` walk:
unknown, not zero.*

## §2 The derivations the milestone rests on

### D1 — the 3-adic barrier, for every `d ≡ 2 (mod 3)` [hand; kernel target `ThreeAdicBarrier.lean`]

For `d ≡ 2 (mod 3)`, reduction sends the ring of `(a + b√d)/m` with `3 ∤ m` onto `𝔽₉ = 𝔽₃[t]/(t² + 1)`, `√d ↦ t`, since `d ≡ −1`. A unit
vector with 3-integral coordinates reduces to the eight-point circle `C ⊂ 𝔽₉²`; `κ(x₀ + x₁t, y₀ + y₁t) = x₀ + x₁ + y₀` is nonzero on `C`
and additive; so `κ ∘ reduction` three-colours, by Theorem A, every unit-distance graph over `ℚ(√d)` whose edge vectors are 3-integral.
The prelude proved it for 167; nothing in the proof used more than `d mod 3`. **Instances:** 11, 23, 167, 1055, 2351, 4703 (all four
window fields), and 2, 5 (already 2-colourable). **Consequence:** a four-chromatic graph over these fields has an edge with 3 in its
direction's denominator.

### D2 — the split 3-adic tower is tight and rigid from level 1 [measured at `m ≤ 3` (O1); derived for every `m`]

`S_m = Cay((O/3^m)², C_m)`, `O = ℤ₃[i]`, `|C_m| = 8·9^{m−1}`. Its eigenvalues are the character means `E_t ψ(αt + β/t)` over
`t ∈ (O/3^m)^×` (the circle in the coordinates `u = x + iy = t`, `v = x − iy = 1/t`). At level 1 they are the eight-point Kloosterman
sums, least −4 (O1). **At level `m ≥ 2` a primitive character reads above −1/2:** if exactly one of `α, β` is a unit the sum vanishes
(summing over `t ↦ t + 3^{m−1}s` kills it), and if both are units it is a Kloosterman sum modulo `3^m` over the unramified ring, of
absolute value at most `2·9^{m/2}` (the prime-power evaluation — stationary phase, Salié's method; prior art owed in §PA), so the mean is at
most `2·9^{m/2}/(8·9^{m−1}) = (9/4)·9^{−m/2}`: 0.25 at `m = 2` (measured 0.2349), 0.083 at `m = 3` (measured 0.0828). So every `S_m` is
3-tight with minimisers exactly the 16 level-1 characters, and by G54's Theorem D2-A (balance, gap-freedom, Fourier support on the
minimisers) **every 3-colouring of every `S_m` is pulled back from `S₁`, hence affine**.

### D3 — the chain target at three colours, and the one question it reduces to [hand; the chain theorem is GPT Astra's, G55]

Let `F = ℚ(√d)`, `d ≡ 2 (mod 3)` squarefree, `G₃` the unit-distance graph on the 3-integral vectors of `F²` (every 3-integral unit vector
an edge direction), and `R = ℤ[U]` the ring the unit vectors of `F(i)` generate.

1. **The chain.** If a finite `H ⊂ F²` forces two vertices at difference `δ` to share a colour in every 3-colouring and `1/δ ∈ R`, then
   `χ(F²) ≥ 4` (G55: every 3-colouring of `F²` is `δR`-periodic; `1 ∈ δR`; the edge `(0, 1)` is monochromatic). The witness is at most
   `m(|H| − 1) + 1` points, `m` the length of `1/δ` as a sum of unit vectors — **in `F` itself**.
2. **Which `δ` are admissible.** `1/δ ∈ R` iff `δ` is a unit at every conjugation-stable prime of `F(i)` (prime inversion, G55;
   `[Fischer1990b]` Thm 5 for the closed form). 3 is inert in `F` with residue `𝔽₉ ∋ i`, so it splits in `F(i)`: `1/3 ∈ R`. So
   `δ = 3u` for any unit vector `u` is admissible (`1/(3u) = ū/3`).
3. **The screens** (each a homomorphism to a colourable target, which separates any pair it separates downstairs):
   * *bipartite*: a graph whose edges are all 2-integral is bipartite (the prelude's remark at 2) and forces nothing at three colours — a
     forcer needs a direction of even denominator;
   * *3-adic*: if every edge of `H` is 3-integral, `H` maps to `S₁` and its affine colourings separate every pair whose difference has
     nonzero residue — **a 3-integral forcer can force only `δ ∈ 3·(3-integral vectors)`**;
   * *tower*: by D2 every `S_m` forces every such `δ`, so no finite level of the 3-adic tower rules any of them out.
4. **Periodic rigidity** [corrected 2026-09-17; the first version was wrong]. The component of `G₃` through `0` lies in
   `Λ₃ = ℤ[S]`, the group the 3-integral unit vectors generate, **not** in `A = O_{(3)}²`: at every conjugation-stable prime `𝔮` of
   `F(i)` (for `ℚ(√11)`: the primes above 2, 7, 11, 19, …; for `ℚ(√167)`: above 23, 43, 59, 167, …) every unit vector is `𝔮`-integral,
   so `Λ₃` maps onto the residue plane `P_𝔮` there while `1/p ∉ Λ₃` (prime inversion, G55). The first version argued from `A`, where
   such primes are invertible, and concluded that every finite quotient is a 3-group — false for `Λ₃`. **Correct statement:** a
   periodic 3-colouring of `G₃` factors through a finite quotient of `Λ₃`, which maps to a product of 3-adic levels `S_m` and levels of
   the stable planes `P_𝔮`; since `S` surjects onto `C_m × Π C_𝔮` (weak approximation on the conic), the quotient graph is a
   **tensor product** `S_m × Π P_𝔮`. *Measured* (§0 O7): for `q = 7, 11, 19, 23`, every 3-colouring of `S₁ × P_q` is pulled back from
   `S₁`, with the positive control at `q = 3` (whose plane is 3-colourable) separating at once. *Not derived:* the statement for every
   product of levels; the relevant graph-theoretic fact — 3-colourings of `G × H` with `χ(H) > 3` factor through `G` — is a
   multiplicativity-type property of `K₃` whose prior art (Häggkvist–Hell–Miller–Neumann-Lara 1988, Greenwell–Lovász 1974 for `K_n`
   factors) is owed a reading before it is cited. The lifting step (every circle point modulo `𝔮^m` and `3^m` lifts jointly) stays.
5. **The dichotomy, by compactness.** A finite forcer of `(p, p + 3u)` among 3-integral graphs exists **iff `G₃` forces it** (if every
   finite subgraph had a separating colouring, a limit colouring of `G₃` would separate it). So route C over 3-integral forcers asks one
   question per field: **is `G₃` rigid at three colours?** A non-affine 3-colouring of `G₃`, if one exists, is aperiodic (4.).
6. **All additive 3-colourings of `G₃` are affine** (`Hom(O_{(3)}², ℤ/3) = Hom((O/3)², ℤ/3)`), so a non-affine colouring is non-additive
   as well as aperiodic.
7. **The direction-set screen.** Let `W₀` be a finite symmetric set of unit vectors and `Λ₀ = ℤ[W₀]`. If some finite quotient
   `Cay(Λ₀/L, W₀)` (no element of `W₀` in `L`) has a 3-colouring `c̄` with `c̄(0) ≠ c̄(3ū)`, then for every `p ∈ Λ₀` the translated
   pullback `x ↦ c̄(x̄ − p̄)` is a proper colouring of `Cay(Λ₀, W₀)` separating `p` from `p + 3u`. So **no graph whose edge vectors all
   lie in `W₀` forces a pair at difference `3u`** — the scope is the forcer's *edges*: a graph drawn on those points may carry further
   unit distances with directions outside `W₀`, and forcing only grows with edges, so a piece's direction set is read from its full exact
   edge set, never from the directions used to build it. `Λ₀ ≅ ℤ⁴` has quotients of every order, unlike `A`, and this screen is a
   boundary-free SAT question on a vertex-transitive graph. *Controls, both reachable:* on `L = 3Λ₀` the pair is one vertex, so no
   separation exists; on an `L` with `3u ≡ w ∈ W₀`, the pair is an edge, so every colouring separates it.
8. **A distance-2 virtual edge is enough** [hand, three lines]. If a finite 3-integral graph separates `x` from `x + 2u` in every
   3-colouring, then any graph containing it and the run `x, x + u, x + 2u, x + 3u` (and the same gadget translated by `u`) forces
   `x` and `x + 3u` equal: `c(x), c(x+u), c(x+2u)` are distinct and so are `c(x+u), c(x+2u), c(x+3u)`, so `c(x + 3u) = c(x)`. Every
   affine colouring separates `2u` (`κ(2u) = 2κ(u) ≠ 0`), the tower separates it at every level, and the compactness dichotomy holds
   for separation as for forcing. So the chain target can be sought as **a virtual edge at difference `2u`** — a Moser-spindle-shaped
   question (a 4-chromatic `{1, 2}`-graph with one distance-2 edge, over the field) — which is a stronger property than forcing `3u`
   and the more geometric one to design for.

*What is not claimed:* that `G₃` is rigid. Forcers that use 3-non-integral edges escape screen 3 (they have no homomorphism to `S₁`) and are
phase C's.

### D4 — the geometry of finite pieces [derived]

The two real embeddings put `F²` into `ℝ² × ℝ²`, and `W_N` onto the torus `S¹ × S¹`; `Λ_N = ℤ[W_N]` is a lattice in `ℝ⁴` of covolume
`[ℤ⁴ : Λ_N]·(2√d/N²)²`, and the unit-distance graph over `F` is the induced subgraph of the tensor square of `UD(ℝ²)` on `F²`. At
`d = 167`, `N = 140`: index 16, about 36,000 points per unit of 4-volume, generators of length `√2` — a word ball is mostly shell (O3) and
a Euclidean ball of radius 2 holds ~2.8 million points with almost no interior. **Thick pieces need coarse lattices**: few directions `W₀`
spanning a lattice of covolume near `det` of four generators, or quotients (D3.7). Phase B chooses `W₀` by the screen first and builds
pieces only for survivors.

### D5 — screens at the other places [derived]

Compact places give no 3-colour screen when their residue plane is not 3-colourable: `𝔽₇` (χ = 4) for `ℚ(√11)`, `ℚ(√23)`; `𝔽₂₃`, `𝔽₄₃`
for `ℚ(√167)`. Split places other than 3 and 2 have residue planes that refuse three colours by Hoffman (at `𝔽₂₉`, least mean ≥ −0.36, ratio
floor above 3.6), so they screen nothing.

### D6 — the ratio route's local problem, stated correctly [derived statement; values to be measured in phase A]

The ratio bound on height-ordered unit vectors tends (under uniform equidistribution, unproved) to the least local mean over places;
O2 shows the dyadic place reads −0.75 under height weights. A reweighting by 2-adic shells is a probability vector `w` on `k ∈ ℤ`, and
the local problem is `max_w min_{α,β} Σ_k w_k a_k(α, β)` **over characters of every level**. By `t ↦ πt` a single shell reads exactly like
the unit shell (least −1), so no finite truncation of the character set is valid for support beyond the truncation's reach (O4). The
computable form: the shell averages depend only on `(v(α) + k, v(β) − k, αβ)` (unit scaling `t ↦ ct`), so for support `|k| ≤ S` it
suffices to range valuations over `[−S − c, S + c]` and the unit class of `αβ` to the precision those valuations fix. Registered
expectation: spreading over `2S + 1` shells gives least mean near `−1/(2S + 1)`, so `S = 1` already clears −1/2 and the real place's
−0.40276 binds.

### D7 — forcing by pigeonhole, generalised from `[Wormald1979]` [hand]

For a finite `T ⊂ F²` call `U ⊆ T` **odd** when the unit-distance graph on `⋃_{u∈U} S(u, 1) ∩ F²`
contains an odd cycle. **If `T` admits no 3-colouring that is proper on `T`'s own unit edges and leaves no odd subset monochromatic, then
`χ(F²) ≥ 4`**, witnessed by `T`, one odd cycle per odd subset used, and one edge from each cycle vertex to a point of its subset. *Proof:*
a monochromatic odd `U` forces its cycle into two colours. The lemma needs no independence hypothesis: a `U` with an internal unit
distance is never monochromatic, and a cycle vertex can coincide with a point of `U` only across such a distance; independence is the
*search's* filter (§0 O6: every odd triple found without it was dependent, and useless). `[Wormald1979]` is the case of 13 points, all 5-subsets, bijectively attached
5-cycles. The smallest subsets that can be odd have size 3: one unit circle is edgeless without `√3`, and two circles form a bipartite
graph. **A three-point subset needs an arithmetic coincidence**: a vertex has at most two neighbours on another circle (the glue points,
row 17), so an odd cycle through three circles closes only where a composition of glue maps returns. §0 O6 found none at low height in
`ℚ(√11)` or `ℚ(√167)`. Larger subsets (`s` points, `|T| ≥ 3s − 2` for an unconditional pigeonhole) have more circles and more chances, and
the SAT form needs only enough odd subsets to block every 3-colouring of `T`. **The certificate is small**: a few hundred vertices,
kernel-checkable by the SAT bridge, and no rigidity question.

## §3 The phases

| phase | what | output | exit |
|---|---|---|---|
| A | local instruments committed: `tools/fs58_local.py` (tower, split and dyadic means, balls), the `d`-generic enumerator, D6's valuation-reduced LP | `data/fs58/opening/`, `data/fs58/local/` | §0 regenerated from committed code; D6's optimum at `S ≤ 2` |
| B | **route C at `ℚ(√11)`**: the direction-set screen (D3.7) over growing 3-integral `W₀`, then forcing probes on thick pieces for survivors, then the chain witness | `tools/fs58_chain.py`, `data/fs58/chain-11/` | a forcer (→ B3), or every `W₀` up to the priced budget killed by a quotient colouring (recorded, → C) |
| W | route W (D7): odd subsets of size 3–5 at growing height over `ℚ(√11)`, exact glue tracing (all heights, not `W_N`-bounded), then the SAT form on `T` | `tools/fs58_pigeon.py`, `data/fs58/pigeon-11/` | an odd triple or quadruple (then `T`), or the null at the priced height recorded |
| C | route S: pieces with 3-non-integral directions, pairs at every admissible `δ`, and an affine-alignment meter on solver colourings | `data/fs58/pieces-*/` | a forced pair or a 4-chromatic piece, or the plateau recorded |
| D | kernel: `ThreeAdicBarrier.lean` (D1 for every `d ≡ 2 mod 3`); if B or C lands, the witness over `ℚ(√d)` through the SAT bridge | Lean modules | build green, zero `sorry`, axioms clean, vacuity green |
| E | route R1 re-stated with D6's local optimum and the prior art (§PA); decide carry-forward | a stub or a section | the statement with its local table, or a stub |
| F | the close | `CLAUDE.md`, stubs | WORKFLOW step 9 |

### Phase B in detail — route C at `ℚ(√11)` (then `ℚ(√23)`, `ℚ(√167)`)

* **B0 — the direction pool.** `W₃(N)` = 3-integral unit vectors of `ℚ(√11)(i)` with denominator dividing `N`, `3 ∤ N`, `N` even (D3.3,
  bipartite screen): `N ∈ {10, 20, 40, 70, 140, 280}`. Record `|W₃(N)|`, the rank and a reduced basis of `ℤ[W₃(N)]` (LLL on the Minkowski
  embedding, D4), covolume, the least odd cycle.
* **B1 — the screen.** For `W₀ = W₃(N)` in increasing `N`, and `δ = 3u`: search sublattices `L ⊂ ℤ[W₀]` with `W₀ ∩ L = ∅` and
  `3u ∉ L` — first the principal families `L = mℤ[W₀]` for `3 ∤ m` and `m` small, then random full-rank sublattices of index up to the
  budget — and SAT-solve the quotient Cayley graph for a 3-colouring **with `c(0) ≠ c(3u)` asked directly** (a selector, as in O3). A hit
  kills `W₀` (D3.7), and is recorded with `L` and the colouring (verified on every quotient edge). Symmetry: pin the origin to 0 and one
  neighbour to 1; the colours are otherwise interchangeable (`CLAUDE.md` § The SAT solver).
  *Control (both reachable):* at `d = 3`-adic level the affine colouring of `(O/3)²` never separates `3u` — the screen must return "not
  killed" on the quotient `L = 3ℤ[W₀]`; and on a quotient where `3u ≡` a generator, `c(0) ≠ c(3u)` is forced true, so the screen must
  return "killed".
* **B2 — forcing probes for survivors.** Thick pieces: `ℤ[W₀]`-points in a Euclidean body of the Minkowski embedding (D4), sized by the
  budget below; for each, a colouring, the central pairs at `3u`, the planted-rhombus control (O3), and **the checkpoint per piece** (a
  JSON record written before the next piece starts; resume = rerun the same command, finished pieces skipped).
* **B3 — the witness.** A forced pair at `δ = 3u` in a finite `H`: write `ū/3` as a sum of unit vectors of `ℚ(√11)(i)` (search, then exact
  check), build the chained graph, **verify its unit edges in exact arithmetic with a checker independent of the generator**, refuse three
  colours with CaDiCaL emitting LRAT, and check the proof with an independent LRAT checker. Then the kernel (phase D).
* **Budget, priced before running:** B1 — quotients up to `10⁵` vertices, 60 s per SAT call, the first 50 `L` per `W₀`; B2 — pieces up to
  `2·10⁶` points, 30 min per SAT call, one heavy job at a time, checkpoint per piece. The price is re-measured on the first `W₀` and
  written into §R before the budget is spent.

### Phase C in detail — pieces with 3-non-integral directions

Only if B records every `W₀` killed or every survivor plateaued. Pieces mix `W₃(N)` with directions of denominator divisible by 3
(`ℚ(√11)`: 8 at 12, 96 at 60); admissible `δ` widen (any `δ` with `1/δ ∈ R`, including 2 and 6); the **affine-alignment meter** reads, on
each solver colouring, the largest fraction of 3-integral cosets on which the colouring agrees with one affine rule — a dial for whether
rigidity is approaching.

## §4 Registered expectations (both outcomes confirmed reachable before running)

| id | expectation | confidence | what each outcome would look like |
|---|---|---|---|
| P1 | B1 kills `W₃(10)` and `W₃(20)` over `ℚ(√11)` by a quotient colouring | 0.8 | killed: a verified separating colouring; not killed at budget: no hit in 50 lattices (a budget, not a proof) |
| P2 | some `W₃(N)`, `N ≤ 280`, survives B1's budget | 0.45 | survives / every one killed |
| P3 | `G₃` over `ℚ(√11)` is rigid (route C lands at some size) | 0.3 | a forced pair (then a witness) / a non-affine colouring of `G₃` found by an argument, never by a finite search |
| P4 | D6's dyadic optimum at `S = 1` is above −1/2 | 0.75 | above / at or below |
| P6 | route W finds an independent odd subset of size ≤ 5 over `ℚ(√11)` within height 840 | 0.35 | a verified odd cycle in a circle union / zero at the height |
| P5 | the barrier theorem D1 closes in the kernel without a solver | 0.9 | `ThreeAdicBarrier.lean` green / a representation problem recorded |

## §5 What this milestone is not

Not a search for six colours; not a fractional certificate unless phase C hands R2 a nearly rigid piece; not a proof of R1's uniform
equidistribution (phase E states it and decides the carry-forward). A null in B or C measures its direction sets and pieces (G21).

## §S — the skeleton

`Proofs/HadwigerNelson/ThreeAdicBarrier.lean` (phase D; statements with `sorry`; names fixed by the experience pass M3):
* `instance : NatScalar ℚ` (leaf-local, as `Instances/FanGap11.lean` does for `ℤ_[11]`, so `Field/Quadratic.lean` is untouched);
* `Plane d := Adjoin d ℚ × Adjoin d ℚ`; `IsThreeIntegral q := (q.den : ZMod 3) ≠ 0`; `threeIntegralRat : Subring ℚ`;
* `toZModThree : threeIntegralRat →+* ZMod 3` with `@[simp] toZModThree_apply` (the cast);
* `threeIntegral d : AddSubgroup (Plane d)`; `kappa d : threeIntegral d →+ ZMod 3` with `@[simp] kappa_apply`;
* `circle_kappa_ne_zero` (81 tuples, in the reduction's shape), `unit_reduce`, `kappa_ne_zero` (under `d % 3 = 2`);
* `integralDirectionPlane d := addCayley {v | v.1² + v.2² = 1 ∧ v ∈ threeIntegral d}`;
* **`colorable_three_integralDirectionPlane : d % 3 = 2 → (integralDirectionPlane d).Colorable 3`**, the barrier;
* the inhabitant `diamond167` with `integralDirectionPlane_adj_diamond167`; the adversary `vanishingVectorThree` with
  `vanishingVectorThree_mem`, `vanishingVectorThree_unit`, `kappa_vanishingVectorThree`.

Checked outside Lean before stating: the 𝔽₃ fact by brute force (8 circle points, `a + b + c` never 0), and `diamond167` exactly
(`a² + 167b² + c² + 167e² = 1`, `2ab + 2ce = 0`, denominators 28, 20, 4, 140).

Jackpot statements (not in the tree until a witness exists; phase D generates them):
`four_le_chromaticNumber_planeOver_sqrt11 : 4 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).chromaticNumber`.
A lower bound transfers from a drawing in `Plane 11` to `ℂ` along evaluation with no injectivity: a graph homomorphism suffices. The
upper half, `= 4`, is `[Fischer1990]`'s and is not restated.

## §M Modeling passes

### M1 — domain (2026-09-17)

**Decisions, kernel side** (choice · alternative · why · confidence):

| # | choice | alternative weighed | why this one | confidence |
|---|---|---|---|---|
| 1 | the plane is `Adjoin d ℚ × Adjoin d ℚ`: coordinates as data | points of `ℂ` with an existential `(a, b, c, e, m)` representation (the first skeleton) | the linear rule must be a function; on `ℂ` it needs a chosen representation, a proof that the choice does not matter, and the irrationality of `√d` to prove it — three purchases the problem does not ask for. On the data model the representation is unique by construction | high |
| 2 | 3-integrality is `(q.den : ZMod 3) ≠ 0` per coordinate, and the reduction is `Rat.cast` into the field `ZMod 3` | `padicValRat 3 q ≥ 0` and `ℤ_[3]`'s `toZMod` | `Rat.cast_add_of_ne_zero` and `Rat.cast_mul_of_ne_zero` are exactly the additivity and multiplicativity needed, under exactly this hypothesis; the p-adic route adds a completion no statement mentions | high |
| 3 | no type for 𝔽₉: the circle fact is stated on four `ZMod 3` components (`a² + 2b² + c² + 2e² = 1 ∧ ab + ce = 0 → a + b + c ≠ 0`) | `Adjoin 2 (ZMod 3)` as the residue field, with a ring map onto it | the only use of 𝔽₉ is one 81-case check; a residue-ring type adds a `NatScalar (ZMod 3)` instance and a ring-map API that nothing else consumes. 𝔽₉ stays in the docstring, where the reader needs it | high — if FS-58 ever needs the tower `(O/3^m)²` in the kernel, this becomes `Adjoin 2 (ZMod (3^m))` |
| 4 | the object is the Cayley graph `integralPlane d`; the theorem colours all of it | a theorem about a drawing `f : V → Plane d` with 3-integral unit edges (the `colorable_of_residue` shape) | "every unit-distance graph with 3-integral directions" *is* "every subgraph of a translate of this Cayley graph"; one statement says it all, and the drawing form is a two-line corollary with no consumer this milestone | high |
| 5 | `kappa` takes no `d % 3 = 2` hypothesis; only `kappa_ne_zero` and the barrier do | the hypothesis on `kappa` itself | the rule is linear for every `d`; the congruence is needed only where the circle reduces to 𝔽₉'s. Index only what consumers need | high |
| 6 | the transfer to `ℂ` / `planeOver` is **not stated** for the barrier | a `planeOver (fieldOfRadicands {d})` form | a colouring transfers only along an injective map, which costs the irrationality of `√d` plus the fact that `fieldOfRadicands {d} = {a + b√d}`; nothing this milestone consumes it. The jackpot is a *lower* bound and transfers along evaluation for free | medium — if the close's ledger row wants the `ℂ` sentence, it is FS-47-style work, priced then |

**Decisions, tools side** (the phases' domain, fixed before code):

| # | choice | alternative weighed | why | confidence |
|---|---|---|---|---|
| T1 | route C works in **coordinates of a ℤ-basis of `ℤ[W₀]`** (a lattice `≅ ℤ⁴`): a quotient is a full-rank sublattice `L` (a 4 × 4 integer matrix), the finite group `ℤ⁴/L` comes from its Smith normal form, a generator is a loop iff it lies in `L`, and `3u ≡ 0 mod L` makes the pair trivially equal | the prelude's global denominator `M = 58800` with 4-vectors over it | the Cayley graph depends only on the relation module of `W₀` (`[FourUnitVectors2025]`'s Heuberger matrix); denominators are incidental to it and overflow as heights grow | high |
| T2 | route W works in **canonical reduced rationals** `(a, b, c, e, m)`, `gcd = 1`, `m > 0`, so points of any height hash, and 2- and 3-integrality read `2 ∤ m`, `3 ∤ m`; glue points (`S(x, 1) ∩ S(u, 1)`) by an exact square root in `ℚ(√d)` | points restricted to `u + W_N` (the §0 O6 probe) | O6's zero measures `W_N`; the pigeonhole needs the circle at every height, and glue points leave any fixed `W_N` | high |
| T3 | a forcing query returns `Forced (solver claim)`, `Separable (colouring, verified on every edge)` or `Unknown (budget)`, and carries its control's outcome | a boolean | G21: a verdict carries its enumeration; a separable verdict is certified by its colouring, a forced one is not until an LRAT check | high |
| T4 | an odd-subset witness is `(U, cycle points in order, anchor index per cycle vertex)`, verified exactly (unit cycle edges, unit anchor edges, `U` independent); the pigeonhole SAT runs on `T` with `T`'s unit edges | a boolean "odd" flag per subset | the final certificate is built from the witnesses; a flag cannot be re-checked | high |
| T5 | the local LP of D6 indexes characters by `(v(α) + k, v(β) − k, class of αβ)` per shell | enumerating `(A, B)` up to a level (§0 O4's defect) | unit scaling `t ↦ ct` fixes shell averages on these orbits, so a finite index set covers every level, which is exactly what the truncated enumeration got wrong | medium — the class of `αβ` needs a precision that depends on the valuations; the obligation pass states it |

**Seams checked.** The model of the barrier's hypotheses is `diamond167`: an edge exists, so three colours colour a nonempty
graph. The adversarial member owed to the obligation pass is a unit vector at some `d ≡ 1 (mod 3)` on which `a + b + c ≡ 0`, which
would show `hd` is used; if none exists, `kappa_ne_zero`'s hypothesis is too strong and the statement should say so.

### M2 — obligations (2026-09-17): what is proved, tested, assumed

**The kernel barrier, decomposed** (each a leaf of `ThreeAdicBarrier.lean`, each a local obligation):

| leaf | local obligation | instrument |
|---|---|---|
| `ratIntegral3` (subring) | `(q₁ + q₂).den ∣ q₁.den·q₂.den`, same for `*`; `(−q).den = q.den`; a product of naturals prime to 3 is prime to 3 | `Rat.add_den_dvd`, `Rat.mul_den_dvd`; `ZMod` cast of a divisor |
| `red3` (ring hom) | `map_add`, `map_mul` under nonvanishing denominators | `Rat.cast_add_of_ne_zero`, `Rat.cast_mul_of_ne_zero` |
| `threeIntegral` (subgroup), `kappa` (additive) | coordinatewise from the subring; `kappa := red3 ∘ re₁ + red3 ∘ im₁ + red3 ∘ re₂` | `Adjoin.add_re`, … (`Field/Quadratic.lean`, all `rfl`) |
| `unit_reduce` | `(x² + y²).re = x.re² + d·x.im² + y.re² + d·y.im²` and `.im = 2x.re·x.im + 2y.re·y.im` (`mul_re`, `mul_im`); apply `red3`; `(d : ZMod 3) = 2` from `d % 3 = 2` | `ZMod.natCast_mod` |
| `circle_kappa_ne_zero` | 81 tuples | `decide` |
| `kappa_ne_zero` | `unit_reduce` then the circle fact | two lines |
| `colorable_three_integralPlane` | `colorable_of_residue` with `f = id`: an edge difference is `±s`, `s` a 3-integral unit vector, and the circle is closed under negation | `addCayley_adj`, `cosetResidue_apply_of_mem`, `ZMod.card` |
| `integralPlane_167_adj_diamond` | the unit identity in `Adjoin 167 ℚ` and four denominators | `decide +kernel` first; fallback `Adjoin.ext` and `norm_num` |
| `kappa_vanishes_at_three` | the adversary: `(−√3/2, 1/2)`, dens 2, `κ = 0 + (−1/2) + 1/2 = 0` already in `ℚ` | `norm_num` |

**The mutation audit, run on the statements before any proof.** Dropping `d % 3 = 2` from `kappa_ne_zero` breaks it
(`kappa_vanishes_at_three`). Dropping it from the barrier does **not** make the conclusion false: at `d ≡ 0, 1 (mod 3)` the whole plane is
3-colourable through its usable residue plane at 3 (`[Moorhouse2010]` Cor. 8.3). The hypothesis is kept anyway, with the reason in the
docstring: the milestone's content is the `d ≡ 2` case, where 3 is not usable and only the integral part colours, and restating
Moorhouse's cases means three rules and nothing that consumes them. *Choice:* keep `hd`. *Alternative:* a case split on `d mod 3` with
three rules. *Why:* no consumer, and the general form's other cases are prior art. *Confidence:* high.

**The hand obligations** (prove / test / assume):

| claim | status | local obligation or instrument |
|---|---|---|
| D2 (i): a character with exactly one unit coordinate has mean 0 at level `m ≥ 2` | **prove** [hand] | substitute `t ↦ t(1 + 3^{m−1}s)`: the non-unit term is unchanged mod `3^m`, the unit term picks up `Tr(αts)/3`, which sums to 0 over `s ∈ O/3` |
| D2 (ii): both units, `\|S\| ≤ 2·9^{m/2}` | **prove** [hand, standard] | stationary phase: `m = 2k`, `t = t₀(1 + 3^k s)` gives `S = 9^k Σ_{αt₀² ≡ β (3^k)} ψ(…)`, at most two roots (Hensel, `p` odd); `m = 2k + 1` the same with a quadratic Gauss sum of modulus `3`. **Test:** measured `\|S\|` at `m = 3` is 53.6 against the bound 54 (§0 O1) |
| D2 conclusion: every 3-colouring of `S_m` is pulled back from `S₁` | **prove** [hand] from (i)–(ii), each character primitive at exactly one level, and G54's Theorem D2-A | **assume** D2-A's applicability to finite abelian Cayley graphs (derived at FS-38) |
| every 3-colouring of `S₁` is affine | **test** (§0 O1: exhaustive enumeration by the solver, 8 colourings, each verified; completeness is the solver's claim) | a hand derivation from the Fourier support is not attempted |
| D3.4 (a) finite quotients are 3-groups; (b) circle points lift | **prove** [hand] | (a) Cauchy; (b) the rational parametrisation and density — **the obligation this pass found missing** |
| D3.5 finite forcer ⟺ `G₃` forces | **prove** [hand] | ⟸ compactness over a countable vertex set (a pointwise-convergent subsequence of separating colourings of an exhausting chain); ⟹ `Forces` is monotone in the graph |
| D3.7 the quotient screen | **prove** [hand] | pullback along `Λ₀ → Λ₀/L` and translation; scope corrected to graphs with edge vectors in `W₀` |
| D6: the local LP over a finite character index is exact up to ε | **prove** at odd split places [hand]; **measure** at the dyadic place | `a_k(α, β) = a_0(απ^k, βπ^{−k})` (substitute `t = π^k s`) and unit scaling fix the index `(v(α) + k, v(β) − k, αβ)`; characters whose every shell term has level `≥ L₀` read `≥ −ε(L₀)` by (ii)'s bound. At `p = 2` the stationary-phase bound needs its own derivation; until then the dyadic LP is a measurement |
| D7: the pigeonhole lemma | **prove** [hand, three lines] | as written; no independence hypothesis |
| routes' verdicts | **test** | every separable verdict by a colouring verified on every edge; every forced verdict a solver claim until an LRAT check; controls per §3 |

### M3 — experience (2026-09-17): names, verdicts, records, and the gate

**Decisions** (choice · alternative · why · confidence):

| # | choice | alternative | why | confidence |
|---|---|---|---|---|
| 1 | `IsThreeIntegral`, `threeIntegralRat`, `toZModThree` | `IsIntegral3`, `ratIntegral3`, `red3` | Mathlib's `IsIntegral` means algebraic integrality, and a reader who knows it misreads `IsIntegral3`; `toZModThree` follows `PadicInt.toZMod`, the name a user would guess for the same map | high |
| 2 | `integralDirectionPlane` | `integralPlane` | "integral plane" reads as a plane of integral *points*; the vertex set is all of `ℚ(√d)²` and only the *directions* are restricted | high |
| 3 | `kappa` keeps its Greek name | a descriptive name such as `sumRule` | the prelude, the plan and the tools all call it κ; one vocabulary across plan, code and records beats a local improvement | medium — revisit if the paper renames it |
| 4 | the adversary is a named vector with three plain lemmas | one `∃ h, … ∧ …` statement | a consumer uses the vector; destructuring an existential to reach it is work the statement imposed | high |
| 5 | `@[simp]` on `kappa_apply` and `toZModThree_apply` only | tagging the membership and unit lemmas too | Mathlib tags `_apply` lemmas; the others are facts about particular vectors, not rewrites toward a normal form | high |
| 6 | **verdicts are exactly `Separable (colouring verified)`, `Forced (solver claim)`, `Unknown (budget)`**, in every tool and record | free-form sentences per tool | a reader scanning records across phases must be able to grep one vocabulary; the qualifier in brackets states the trust level at the point of use. Caught while writing this: `balls` printed "colouring verified" for separations it had not verified; the tool now checks every separating model | high |

**Tool surfaces (phases B and W), fixed before code.** Every long command prints its headline first, appends one JSON object per
unit of work to a JSONL record with a flush and `fsync` per line, writes derived files to `<name>.tmp` and renames them, and resumes by
**re-running the same command**: finished units are read back from the JSONL and skipped. No command is ever piped into `head`.

| command | output | unit of work |
|---|---|---|
| `tools/fs58_chain.py pool D N` | `data/fs58/chain-D/pool-N.json`: the direction count, a reduced ℤ-basis of `ℤ[W₃(N)]` and its index, the rank (must be 4), the least odd cycle | one `N` |
| `tools/fs58_chain.py control D N` | `CONTROL PASS` twice, or a named failure: on `L = 3Λ₀` no separation; on an `L` with `3u ≡ w`, every colouring separates | one `N` |
| `tools/fs58_chain.py screen D N --lattices K --wall S` | `data/fs58/chain-D/screen-N.jsonl`: `{lattice, u, verdict, colouring_file}` | one `(L, u)` |
| `tools/fs58_chain.py probe D N --points P` | `data/fs58/chain-D/probe-N.jsonl`: piece size, edges, direction set read from the exact edge set, pairs asked, verdicts, planted-rhombus control | one piece |
| `tools/fs58_pigeon.py odd D --size s --height H` | `data/fs58/pigeon-D/odd-s-H.jsonl`: every odd subset found, with its witness `(U, cycle, anchors)`, and the count of dependent subsets excluded | one subset |
| `tools/fs58_pigeon.py sat T.json` | the pigeonhole SAT on `T`; on UNSAT, the assembled graph written for the checker | one `T` |
| `tools/fs58_check_witness.py GRAPH` | `CERTIFIED` or a named refusal; standard library only; rebuilds every edge in exact arithmetic from the point list and checks a refutation proof with a checker that is not the solver | one witness |

### §G — the phase gates (what · verified how · pass condition), scored by artifact and gate log, never by a report's summary

| phase | gate item | verified how | pass condition |
|---|---|---|---|
| A | §0's records regenerate from committed code | rerun each `tools/fs58_local.py` subcommand into `.tmp`; `cmp` against `data/fs58/opening/` with timing lines removed | identical |
| A | the `d`-generic enumerator agrees with FS-56's | `units_d(N, 167)` against `fs56_low_height.units(N)` for `N ∈ {84, 420, 2184}` | identical sets |
| A | D6's local LP | `tools/fs58_local.py lp PLACE S L0` → `data/fs58/local/`; the omitted-character bound `ε(L0)` printed beside the optimum | the controls at `S = 0` read −1/2 (3-adic) and −1 (dyadic); optima at `S = 1, 2` recorded with `ε` |
| B | pool records | `pool` for `ℚ(√11)`, `N ∈ {10, 20, 40, 70, 140, 280}` | rank 4 in every file; every vector re-asserted unit when written |
| B | controls before any screen | `control` per `N` | both `CONTROL PASS`, in the log before the first screen line |
| B | screen verdicts | every `Separable` line's colouring file re-verified on every quotient edge and on `c(0) ≠ c(3u)` by a re-read of the written file | 0 failures; each `N` recorded as *killed* (with its `L`) or *not killed at budget* (with the budget) |
| B, W | any forced pair or UNSAT pigeonhole | the assembled witness through `fs58_check_witness.py`, plus five planted faults (a point moved, a non-unit edge added, the proof truncated, a vertex deleted, the pinned pair flipped) | `CERTIFIED`; all five refused for their named reasons |
| W | odd subsets | every witness line re-verified by `check`; the `ℚ(√3)` positive control run first at the same `--size` and `--height` | control finds odd triples; 0 witness failures |
| C | the affine-alignment meter | run on a colouring pulled back through κ on a 3-integral piece | reads exactly 1 |
| D | the kernel barrier | `./scripts/build.sh`; `grep sorry` on the module; `./scripts/axioms.sh`; `./scripts/vacuity.sh`; `python3 tools/check_architecture.py` | green; zero `sorry`; axioms exactly `[propext, Classical.choice, Quot.sound]`, no native purchase; vacuity counts updated in `CLAUDE.md` if they move; architecture PASS, with the row's SKELETON banner removed |
| E | R1's statement | the plan section with D6's table | written, and a carry-forward decision recorded |
| F | the close | WORKFLOW step 9, including the sweep of this plan for "conjecture" and "not claimed" | `CLAUDE.md` Frontier, ledger and grokkings updated; `plans/FRONTIER-STUBS.md` re-ranked; every hit minted or declined |

**Standing rules for whoever implements** (with the reason each exists): checkpoint per unit and resume by rerunning (the PROTECTED
checkpointing rule); one heavy job at a time; kill by pid, verified by the named pid gone and the record static for ten seconds; no
`| head` on a command whose cleanup matters; a gate's exit status is read from the gate, never through a pipe; symmetry is broken
before any SAT search (origin 0, one neighbour 1), and an `Unknown` from an unbroken encoding is not a fact about the graph; edges are
decided by exact arithmetic, so a refusal is robust and a colourable verdict measures the piece.

## §R Results

*(Phase records, newest last.)*

### R-D — phase D, the kernel barrier: LANDED (2026-09-17, `073a91e`; implementer Opus 5, reviewed by artifact)

`colorable_three_integralDirectionPlane`: for `d ≡ 2 (mod 3)` the plane over `ℚ(√d)` restricted to its 3-integral directions is
3-colourable, on exactly `[propext, Classical.choice, Quot.sound]`, no native purchase. **Gate, re-checked by the reviewer:** zero `sorry`
(grep 0); the diff removes only `:= sorry` endings (no public statement changed); axioms log
`build/gate/axioms/20260917T065657Z-1476791.log` (10 new records, standard three); vacuity green, counts
`declarations=6588 refutations-skipped=267`, sites unchanged at 260; build 172/172; architecture PASS; lint 0 of 20 declarations.
Controls on scratch copies: four planted faults refused, their negations proved (so they fail for being false, not by a stuck
reduction), and `hd`'s mutation proved load-bearing from the adversary. **Owed at the close:** `CLAUDE.md` trust-ledger count 966 → 976
and the vacuity counts line; `scripts/vacuity-baseline.txt`'s header. **Declined, with reason:** a public `DecidablePred IsThreeIntegral`
instance and a public `mem_threeIntegral` (no consumer this milestone).

### R-B1 — phase B, the quotient screen over `ℚ(√11)`: nothing killed, for a structural reason (2026-09-17, `ced5722`; implementer Opus 5)

* **The plan's denominator list was wrong** (de Bruijn's error, caught by the implementer): `W₃(N)` for `N = 10, 20, 40, 70, 140, 280` is
  **one set of 36 vectors**, because every prime dividing those `N` other than 5 (that is, 2 and 7) is conjugation-stable over
  `ℚ(√11)`, where every unit vector is integral. §0 O5's counts (24 outside `ℚ(i)` at each of them) showed it and were not read. The
  pool first grows at `N = 50` (100 vectors), 130, 230 (108), 250 (196).
* **Every periodic 3-colouring found is affine.** Across 427 lattice records at `N = 10` and `50`, 399 quotients refuse three colours; on
  the 21 that accept them exactly one admissible linear form (up to sign) descends, and a non-affine colouring is refused (solver
  claim). An affine colouring never separates `3u`, so the screen **cannot** kill this pool on any lattice. P1 (0.8 that it kills
  `W₃(10)`) lost.
* Controls: seven parts, all `CONTROL PASS`; a mutation audit of nine planted faults, all red. The least character mean of `W₀` over
  its dual torus is about −0.596 (below −1/2), so the ratio bound is not what refuses the quotients.

### R-B2 — the forced pair: box pieces over `ℚ(√11)` force `0` and `3w` equal at three colours (2026-09-17) — **solver claims, two codebases, independent build; certificate owed (B3)**

`tools/fs58_box.py` (box pieces `|x_i| ≤ R` of `Cay(ℤ[W₀], W₀)`, `W₀` the 36 unit vectors of `ℚ(√11)(i)` with denominator dividing 10,
coordinates in a basis LLL-reduced in the Minkowski embedding) → `data/fs58/chain-11/box-probe.out`; `tools/fs58_box_indep.py` (points
rebuilt as exact vectors from the pool's own unreduced basis, edges from a fresh enumeration of unit vectors by exact membership, the
query written as DIMACS and solved by the CaDiCaL binary and by Glucose4) → `box-indep.out`.

| piece | points | edges | identify `(0, 2w)` | separate `(0, 3w)` | identify `(0, 3w)` (control) |
|---|---|---|---|---|---|
| `R = 6` | 28,561 | 294,644 | **UNSAT** (3 directions) | **UNSAT** (3 directions) | SAT |
| `R = 9` | 130,321 | 1,627,148 | **UNSAT** | **UNSAT** (CaDiCaL and Glucose4, independent build; 2 directions) | SAT, model verified |

A further control: identifying `0` with `3·(basis vector)` (affine value 0, not a direction multiple) is SAT with a verified model. So
the identification encoding can answer yes, and it answers no exactly at `2w`.

*Correction (B3 implementer, verified): the `R = 6` lines above are for three other directions — `fs58_box.py`'s float LLL leaves the
pool basis unchanged, and in it `w = (0,3,−1,0)/10` has coordinates `(0,2,0,−3)`, so `3w` lies outside the `R = 6` box; `w` itself was
asked only at `R = 9`, by the independent build. Every direction forces from a span-2 box (R-B3).*

**What it means, if the certificate holds.** A finite piece `H` forces `c(0) = c(3u)` in every 3-colouring (at `R = 9` for `w`), and
separates `0` from `2u` (a virtual edge, D3.8). Over `ℚ(√11)`, `1/3 = 1 + 1 + v + v̄` with `v = (−5 + i√11)/6` a
unit vector (`tools`-side search, N = 12). So the chain (G55) closes with four copies: transporting `H` by the rotations `w̄, w̄, w̄v, w̄v̄`
forces `c(0) = c(3) = c(6) = c(6 + 3v) = c(6 + 3v + 3v̄) = c(1)`, while `0` and `1` are adjacent. **χ(ℚ(√11)²) ≥ 4**, and with
`[Fischer1990]`'s four colours, **χ(ℚ(√11)²) = 4** — by §PA, the first real quadratic field whose plane is known to need four colours.

**Status: not yet claimed.** Owed before any sentence outside this plan: the forcing core extracted from the refutation, the chained
witness built and refuted directly, every edge checked in exact arithmetic by a checker that shares no code with the generator, the
refutation checked by a proof checker that is not the solver, and the kernel route priced (B3). *Reading:* the thick box forces where
word balls (§0 O3) and every periodic screen (R-B1) could not; this is the rigidity D3.4 predicted, arriving at finite size.
*Negative, same session:* `ℚ(√23)` with 12 directions (`N = 8, 56`) forces nothing at `R = 7`; `ℚ(√23)` with 36 (`N = 40`) and `ℚ(√167)`
(`N = 28, 56, 140`) have reduced coordinates up to 8–49, too large for boxes that contain `3w` at this size.

### R-B3 — the certificate: a 204-point unit-distance graph over `ℚ(√11)` with no proper 3-colouring (2026-09-17, `1b045f8`; implementer Opus 5; re-verified by the reviewer)

* **The forcer** (`data/fs58/witness-11/forcer.json`): **52 points, 111 edges**, vertex-minimal under deletion, forcing `c(0) = c(3u)` for
  `u = (−3/5, 4/5)` — a direction in `ℚ(i)`; 20 of its 32 signed directions involve `√11`. Found by scanning all 18 directions on span
  boxes (every direction forces from span 2; every direction also has the virtual edge at `2u`), extracting the LRAT core, and deleting.
* **The witness** (`witness.json`): the chain of four transported copies with `1/3 = 1 + 1 + v + v̄`, `v = (−5 + i√11)/6` — **204 points,
  455 unit edges** (444 transported, 11 new between copies), `(0,0)` and `(1,0)` adjacent. **227 of the 455 edges have 3 in their direction's
  denominator**, as D1 requires of any four-chromatic graph over this field.
* **Evidence.** `tools/fs58_check_witness.py` (standard library only, no import from `tools/`): rebuilds every unit pair in integer
  arithmetic, builds the CNF itself, checks the LRAT (461 additions) with its own RUP checker — `CERTIFIED` (exit 0, re-run by the
  reviewer); twelve planted faults refused for their named reasons and a mutation audit of the checker all red. **Reviewer's decorrelated
  recheck** (sharing no code with generator or checker): all 20,706 pairs tested in exact rational arithmetic give exactly the file's 455
  edges; Minisat22 and Lingeling both refuse three colours (with CaDiCaL and Glucose4: four solver codebases); deleting vertex `(1, 0)`
  makes the graph 3-colourable, model verified. The no-solver exhaustive search refuses each copy's end-separation (445, 231, 201, 189
  nodes).
* **Status: `χ(ℚ(√11)²) ≥ 4` at the tools-certificate level; with `[Fischer1990]` Thm 9, `χ(ℚ(√11)²) = 4`.** By §PA, the first real
  quadratic field whose plane is shown to need four colours; the graph is triangle-free (no `√3` in the field) with explicit coordinates in a
  quadratic field (the smallest known triangle-free 4-chromatic unit-distance graphs, Exoo–Ismailescu's EI17 and EI19, have coordinate fields
  certified by `[CostaSilvaFilho2026]` as a degree-20 field and a base `ℚ(√2,√5,√7)` with a degree-12 angle). **P3 (0.3) won** — route C landed at finite size. **The kernel form is phase D2**, priced by the implementer at
  well under a minute through the `UDCert`/SAT-bridge pipeline (running).

