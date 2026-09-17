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
4. **Periodic rigidity.** Every finite quotient of the 3-integral group `O_{(3)}²` of `F²` is a quotient of some `(O/3^m)²` (its finite
   quotients are 3-groups: integers prime to 3 are invertible). So **every periodic 3-colouring of `G₃` is pulled back from some `S_m`,
   hence affine** (D2), and keeps every pair at difference `3u` equal.
5. **The dichotomy, by compactness.** A finite forcer of `(p, p + 3u)` among 3-integral graphs exists **iff `G₃` forces it** (if every
   finite subgraph had a separating colouring, a limit colouring of `G₃` would separate it). So route C over 3-integral forcers asks one
   question per field: **is `G₃` rigid at three colours?** A non-affine 3-colouring of `G₃`, if one exists, is aperiodic (4.).
6. **All additive 3-colourings of `G₃` are affine** (`Hom(O_{(3)}², ℤ/3) = Hom((O/3)², ℤ/3)`), so a non-affine colouring is non-additive
   as well as aperiodic.
7. **The direction-set screen.** A forcer uses finitely many directions `W₀`. If some finite quotient `Cay(ℤ[W₀]/L, W₀)` (with `L`
   containing no element of `W₀`) has a 3-colouring separating `0` from `3u`, its pullback, translated, separates every `(p, p + 3u)` in
   every subgraph of `Cay(ℤ[W₀], W₀)`: **no forcer with directions in `W₀` exists**. `ℤ[W₀] ≅ ℤ⁴` has quotients of every order, unlike
   `O_{(3)}²`, and this screen is a boundary-free SAT question on a vertex-transitive graph.

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

For a finite `T ⊂ F²` call `U ⊆ T` **odd** when `U` has no internal unit distance and the unit-distance graph on `⋃_{u∈U} S(u, 1) ∩ F²`
contains an odd cycle. **If `T` admits no 3-colouring that is proper on `T`'s own unit edges and leaves no odd subset monochromatic, then
`χ(F²) ≥ 4`**, witnessed by `T`, one odd cycle per odd subset used, and one edge from each cycle vertex to a point of its subset. *Proof:*
a monochromatic odd `U` forces its cycle into two colours. `[Wormald1979]` is the case of 13 points, all 5-subsets, bijectively attached
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

`Proofs/HadwigerNelson/ThreeAdicBarrier.lean` (phase D; statements with `sorry`, elaborated 2026-09-17):
`point`, `threeIntegral d : AddSubgroup ℂ`, `kappa d hd : threeIntegral d →+ ZMod 3`, `kappa_point`, `kappa_ne_zero`,
**`colorable_three_of_threeIntegral`** (the barrier for every `d ≡ 2 mod 3`), and the inhabitant pair `norm_point_167_diamond`,
`colorable_three_threeIntegral_167`.

Jackpot statements (not in the tree until a witness exists; phase D generates them):
`four_le_chromaticNumber_planeOver_sqrt11 : 4 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).chromaticNumber`, with the
upper half `chromaticNumber … = 4` from the plane at 7 (row 57's hand step at 7 is the gap to name).

## §M Modeling passes

*(WORKFLOW step 5 — to be run fresh after this plan is committed.)*

## §R Results

*(Phase records, newest last.)*
