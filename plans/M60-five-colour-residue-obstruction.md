# FS-14 — The five-colour residue obstruction at 11: what a 5-sealed field's colourings force (STUB, 2026-09-06; minted at the M59 close — the programme's named next derivation)

*Read beside: `plans/PROGRAMME-ALGEBRAIC-PROOF.md` §5 ("next: the 5-colour residue obstruction one prime up — why a rigid pair at
five colours needs the 11-wall broken"); `plans/FIELD-WALL-THEOREM.md` §7 (T17: inside K no pair compulsion at five colours — the
residue 4-colouring plus a spare colour); M56 (`Additive.lean`: the pairs every additive colouring identifies contain the forced
pairs); `Instances/FinitePlane11.lean` (χ(UD(𝔽₁₁,2)) = 5, the pulled-back colouring of Heule-510).*

## 1. Mission context, in plain language

Theorem B says no unit-distance graph over K = ℚ(√3, √11) forces a pair at five colours: the residue 4-colouring leaves a colour
spare. The finite-plane bound says every unit-distance graph over a 5-SEALED field (11 usable: K(√5), K(√247), Heule's) is
5-coloured by pulling back a 5-colouring of UD(𝔽₁₁, 2) through the reduction — and the reduction is a homomorphism, so every
5-colouring of the finite plane gives a 5-colouring of the graph that is CONSTANT on residue classes and PROPER across adjacent
ones. A pair of vertices forced equal in every 5-colouring of the graph is therefore forced equal in every pulled-back one:
its two residues must be identified by EVERY 5-colouring of UD(𝔽₁₁, 2). A pair forced distinct (a virtual edge) must have
residues separated by every 5-colouring of the plane. Both are finite questions on a 121-vertex graph: the set F₁₁ of residue
pairs every 5-colouring of UD(𝔽₁₁, 2) identifies, and the set S₁₁ of residue pairs every 5-colouring separates (the plane's own
virtual edges at five colours, M56's F_add and M45's virtual edges one prime up). **The derivation to aim for:** the exact
statement "in a 5-sealed field a pair compulsion at five colours lives only on pairs whose residues lie in F₁₁ ∪ S₁₁", with the
two sets computed — if F₁₁ is empty off the diagonal, no forced-equal pair at five colours exists in any 5-sealed field at
any distance whose endpoints have distinct residues; and the 6-forcer's field must escape 11 for the reason the 5-forcer's
escaped 2: the sealing prime's plane has no rigid pairs of its own.

## 2. What we know

| fact | where |
|---|---|
| χ(UD(𝔽₁₁,2)) = 5 (kernel); the plane is vertex-transitive with automorphism group ⊇ 𝔽₁₁² ⋊ O(2, 𝔽₁₁) (order 121 · 24) | M58 |
| the pulled-back 5-colouring of Heule-510 is proper (kernel) — so its 5-colouring space contains every pullback | M58 |
| M56: the seed's forced pair is exactly the pair every additive 5-colouring identifies; the witnesses' additively forced pairs are all separated by non-additive colourings | M56 §R |
| M45/M48: a compulsion is a partial colouring that does not extend; arity 2 = forced/separated | `Arity.lean` |

## 3. Derivations first

**D1 — the transfer.** For G a unit-distance graph over F with 11 usable and r : V(G) → 𝔽₁₁² the reduction: every 5-colouring c
of UD(𝔽₁₁,2) gives the proper colouring c ∘ r of G. Hence Forces G 5 u v ⟹ ∀ c, c(r u) = c(r v), i.e. (r u, r v) ∈ F₁₁; Separated
G 5 u v ⟹ (r u, r v) ∈ S₁₁. Kernel: `Colorable.of_hom` in M45's `Forces`/`Separated` vocabulary through `UDCert.drawingHom` —
an afternoon.

**D2 — F₁₁ and S₁₁, exactly.** Enumerate the 5-colourings of UD(𝔽₁₁,2) up to the automorphism group (how many? the M58 record has
one; M20's strip-automaton genre suggests a structured count), then intersect. Prediction: F₁₁ is the diagonal only (no two
residues are identified by every colouring) and S₁₁ is exactly the edge set plus possibly the distance-… classes the hex-shell
pigeonhole forces (compare M35's k = 5 class sweep, all clean). If so: **no forced-equal pair at five colours exists over any
5-sealed field between points of distinct residue, and every virtual edge over such a field lies on a residue pair in S₁₁.**

**D3 — the same at 19 (for fields without √3) and the meaning of "escape".** A 6-forcer's field must have every sealing prime
inert; D1–D2 say WHY at the level of compulsions: the sealing plane's colourings are too free to force anything the graph does
not already force through residues.

## 4. Phases

| phase | what | cost |
|---|---|---|
| 0 | D2: the 5-colourings of UD(𝔽₁₁,2) up to symmetry; F₁₁ and S₁₁ | a day |
| A | D1 in the kernel; the transfer theorem with the two sets as decided data | a day |
| B | the reading against the descent's cheats (every cheat pair's residues at 11 on the seed and the it-4 object: which lie in S₁₁) | hours |

## 5. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | F₁₁ off the diagonal is empty | medium-high |
| P2 | S₁₁ is the plane's edge set plus no other class | medium |
| P3 | every one of the seed's 446 cheat pairs has residues in S₁₁ or F₁₁ at 11 | medium |

## 6. Bearing on 6, honestly

Medium as a DERIVATION (the programme's stated next step): it turns "5-sealed" from a chromatic-number statement into a
compulsion statement, the 5-colour analogue of T17, and names the mechanism the 6-forcer's field must escape. No object.

## 7. Addresses

`tools/fplane.py chi`, `data/fplane/chi-p11.json`, `Proofs/HadwigerNelson/Instances/FinitePlane11.lean`, `Arity.lean`, `Additive.lean`.

---

## §S. Subplan (M60 opened 2026-09-07, on Kooshi's go after his compaction; WORKFLOW step 3)

*The stub above (§1–§7) is kept verbatim as the registration. What follows was written at opening, derivation first (G46): the
transfer theorem and the structure of the two residue sets are derived below before any search, and the one measurement the
derivation asked for — two properties of the ONE certified colouring table at 11 — was made before the skeleton was written,
because it decides the kernel's shape (whether the rotation group is needed: it is not).*

### §S0. The state on disk at opening (read first)

| what | where | state |
|---|---|---|
| the plane at 11: `finitePlane 11 := unitQuadrance (ZMod 11)`, its 5-colouring `finitePlane11Colouring` (a literal table, decided proper), `χ = 5` in the kernel; the reduction `heule510Reduce11 : edgeGraph 510 heule510.edges →g finitePlane 11` through `Q4.sevenFree.res11` (`√3 ↦ 5, √5 ↦ 4, √11 ↦ 0`) | `Instances/FinitePlane11.lean`, `UnitQuadrance.lean` | kernel, standard three axioms |
| the reduction as a theorem over any commutative ring: `UDCert.drawing`, `drawing_adj` (the level-1 quadrance identity through `φ` and `u·D = 1`), `drawingHom` | `UnitQuadrance.lean` §UDCert | kernel |
| `Forces G k p q := ∀ C : G.Coloring (Fin k), C p = C q`; `Separated G k p q := ∀ C, C p ≠ C q`; `Forces.comap` (Forcer.lean), `Separated.comap` (Arity.lean): a hom carries the compulsion to the image; `compels_two_eq`/`compels_two_ne`: arity 2 IS these two; `le_arityFloor_iff`, `two_le_arityFloor` | `Forcer.lean`, `Fan.lean`, `Arity.lean` | kernel |
| `quad (d : R × R) := d.1² + d.2²` (M59), `UDCert.PairsAt c ps r` (every listed pair at stored squared distance `r·D²`) with `pairsAt_iff` | `Lift.lean`, `PairDist.lean` | kernel |
| the colouring tables: `chi-p3.json` (k = 3), `chi-p7.json` (k = 4), `chi-p11.json` (k = 5, = the kernel's table), `chi-p19-k5.json` (k = 5; k = 4 refused by the solver, `chi-p19-k4.json`, untrusted) | `data/fplane/` | tools |
| the stages that reduce at 11 with every edge on the circle: the E–I seed's unit part (214 points, 51 distinct residues, the pulled-back 5-colouring proper), Heule-510, W-core-8over3 (1,175 points, ALL 121 residues hit, pullback proper) | `data/fplane/reduce-*-p11.json` | tools (the seed and W: not kernel) |
| the descent's material: the seed's 446 distance-2 cheats and its forced pair A, B at distance 5 (`tools/twodist.py ei_H`, `classify`); the culled it-4 object with 149 standing cheats (`build/m51-edges-…+cull149.json`, gitignored but present; `tools/residue_floor.py` shows the loader) | `tools/`, `build/` | tools |
| the M55 asks: 108 theorem-admitted virtual-edge candidates on `W-plus-cross-depth2` (10,541 points in K(√247), 11 usable) at five colours — 22 refuted by verified colourings, 86 UNDECIDED at the 900-s wall; the stage's exact coordinates are assembled from `witness-exact-core-8over3.json` (W, 1,175), the depth-1 pool (63 kept of 71) and the depth-2 pool (9,303), all in the `A + √247·B` basis | `data/m55/ask-W-plus-cross-depth2-k5.json` and the records it names | tools |

Machine: the desktop (32 cores, 125 GB). Nothing in flight except the per-class solver pass of §S2 (seconds to minutes).

### §S1. D1 derived — the transfer, and why "every colouring of the plane" is one table's translates

**Setting.** `R` a commutative ring, `UD(R) := unitQuadrance R` on `R × R` (`u ~ v ⟺ u ≠ v ∧ quad (u − v) = 1`). A graph
homomorphism `f : G →g UD(R)` — for a certificate over a subring `S ⊆ Q4` with a ring hom `φ : S → R` and an inverse `u` of the
denominator, `f = c.drawingHom φ hS hu hv` (kernel). A `k`-colouring `col` of `UD(R)` pulls back to `col ∘ f`, a `k`-colouring of `G`.

**(T1, T2) — the transfer, one line each (already in the kernel as `Forces.comap` / `Separated.comap`):**
`Forces G k u v ⟹ col (f u) = col (f v)` and `Separated G k u v ⟹ col (f u) ≠ col (f v)`, for EVERY colouring `col` of the plane.

**Translations.** For `t ∈ R²` the map `w ↦ w + t` is an automorphism of `UD(R)`: adjacency depends only on the difference
(`(u + t) − (v + t) = u − v`) and distinctness is preserved. So `col ∘ (· + t)` is a colouring for every `t`, and (T1)/(T2)
hold along the whole translation orbit of ONE table. Writing `d := f v − f u`:

* (T1′) `Forces G k u v ⟹ ∀ t, col t = col (t + d)` — **`d` is a period of `col`.**
* (T2′) `Separated G k u v ⟹ ∀ t, col t ≠ col (t + d)` — **`d` is a never-coincident difference of `col`.**

Hence two properties of a single table decide the transfer completely:

* **(A) aperiodic** — no nonzero `d` is a period: `∀ d ≠ 0, ∃ t, col t ≠ col (t + d)`. Then `Forces G k u v ⟹ f u = f v`.
* **(C) coincident off the circle** — every nonzero `d` with `¬ Adj 0 d` has a coincidence: `∃ t, col t = col (t + d)`. Then
  `Separated G k u v ⟹ Adj (f u) (f v)` (if `f u = f v` the pullback of `col` itself identifies them; if `f u ≠ f v` and not
  adjacent, the translate by `t − f u` identifies them).

Both are decidable on a finite plane and both are statements about ONE table: `(p² − 1)` differences, `p²` translates each,
early exit — at 11, at most 14,520 lookups per property. **No rotation is needed for the theorem**; rotations enter only in
§S2's structural claim that the sets are unions of norm classes, which the tools use to decide by representatives.

**The theorem, in the plane's own words.** Let `F_p(k)` be the set of differences `d` identified by every `k`-colouring of
`UD(𝔽_p, 2)` at every translate, and `S_p(k)` the set separated by every `k`-colouring at every translate. By vertex-transitivity
these are exactly the plane's own arity-2 compulsions (`Forces`/`Separated` of `finitePlane p` at `k` colours, translated to the
origin). Then for any `G` with a hom `f` into the plane, at any `k` at which the plane is `k`-colourable:

> `Forces G k u v ⟹ f v − f u ∈ F_p(k) ∪ {0}`, and `Separated G k u v ⟹ f v − f u ∈ S_p(k)`.

(A) says `F_p(k) = ∅` off zero; (C) says `S_p(k) = N₁`, the unit circle. The transfer is never vacuous: a hom into a
`k`-colourable plane makes `G` `k`-colourable, so `Forces`/`Separated` on `G` are about a nonempty colouring space.

**Kin.** T17 (`plans/FIELD-WALL-THEOREM.md` §7.2) is the same statement at the prime above 2 with `k = 4`: the residue
4-colouring plus a spare colour separates every pair and identifies none, so `F = ∅` and `S = ∅` at five colours over K
(there the plane's colouring uses FOUR colours, so at five everything is free). At 11 the plane needs all five colours and the
same conclusion comes not from a spare colour but from the richness of the plane's colouring space: **the sealing plane's
5-colourings are pairwise free — `F₁₁(5) = {0}`, `S₁₁(5) = N₁` — the finite plane has no arity-2 compulsion at five colours
beyond its edges**, exactly as de Grey's graph has none at its top rung (G31).

### §S2. D2 derived and measured — the two sets are unions of norm classes, and the table at 11 decides both

**Structure.** For `p ≡ 3 (mod 4)` the orthogonal group `O(2, 𝔽_p)` (norm-preserving linear maps, order `2(p+1)`) acts on
`UD(𝔽_p, 2)` by automorphisms; its rotation subgroup is the norm-one group of `𝔽_{p²}`, cyclic of order `p + 1`, acting freely
on every circle `{quad = c}`, `c ≠ 0` — each of which has exactly `p + 1` points because `−1` is a non-square (no isotropic
vectors, so `quad d = 0 ⟺ d = 0`). Hence every nonzero-norm circle is ONE rotation orbit, and **`F_p(k) ∖ {0}` and `S_p(k)`
are unions of the `p − 1` norm classes `N_c := {d : quad d = c}`, `c ∈ 𝔽_p^×`.** `S_p(k) ⊇ N₁` always (properness). Deciding a
class: `N_c ⊄ F_p(k)` iff SOME colouring separates `0` from one representative (an aperiodic table refutes every class at
once); `N_c ⊄ S_p(k)` iff some colouring identifies `0` and a representative (a table with a coincidence at any member, or a
pinned SAT `col 0 = col d` whose model is a verified colouring); `N_c ⊆ S_p(k)` iff that pinned SAT is UNSAT (solver-trusted).
So the kernel-certifiable direction is always the NEGATIVE one — "this class is not compelled" is a colouring — and the sets
are exactly `{0}` and `N₁` precisely when one table certifies both (A) and (C).

**Measured at opening (2026-09-07, the certified table `finitePlane11Table` = `chi-p11.json`, translations only):**

| p | k | periods of the table | never-coincident differences of the table | coincidences at the 108 off-circle differences | verdict |
|---|---|---|---|---|---|
| 11 | 5 | **none** | exactly the 12 circle points (norm 1) | min 4, max 60 | **`F₁₁(5) = {0}`, `S₁₁(5) = N₁` — P1 and P2 MET, by one table, no search** |
| 19 | 5 | none (`F₁₉(5) = {0}`) | 192 of 360, in every norm class | — | per-class SAT (18 classes, 13–62 s each): every non-unit class IDENTIFIED by some verified 5-colouring — **`S₁₉(5) = N₁`, P4 MET** |
| 7 | 4 | none (`F₇(4) = {0}`) | 20 of 48, norms {1, 3, 4, 5} | — | per-class SAT: every non-unit class identified — **`S₇(4) = N₁`, P5 REFUTED** (the single table's never-coincident norms 3, 4, 5 were the table, not the plane: G21) |
| 3 | 3 | the norm-2 class (2 differences) | norms {1, 2} | — | all 12 proper 3-colourings enumerated: **`F₃(3) = {0}`, `S₃(3) = N₁`** |

**The uniform reading (measured at four primes, minted below as G47's candidate): at every finite Euclidean plane whose exact
chromatic number is known, at that number of colours, the plane has NO arity-2 compulsion beyond its edges — `F_p(χ) = {0}`,
`S_p(χ) = N₁` at p = 3, 7, 11, 19.** Even the 3-plane with only twelve proper 3-colourings is pairwise free. (At a prime whose
plane is `k`-colourable for `k` ABOVE its chromatic number the same holds a fortiori: more colourings, fewer compulsions.)

The per-class SAT at 7 and 19 and the enumeration at 3 ran at opening (an inline script of the opening session, 12 minutes;
`tools/fpcompel.py sets` reproduces it and writes `data/fplane/compulsions-p<P>-k<K>.json` as phase 0's record).

### §S3. D3 derived — the distance law, and the hex-shell corollary at every sealing prime

**The distance law.** For a certificate with a pair `(i, j)` certified at squared distance `r` (`PairsAt [(i, j)] r`: `distSq =
r·D²` in `Q4`), the drawing's difference has `quad = (r : R)` — the same computation as `drawing_adj`, which is its `r = 1`
case (`UDCert.drawing_quad`, to be minted as the general lemma with `drawing_adj` its instance). With §S1 at a prime `p` where
the plane is `k`-colourable with `F = {0}`, `S = N₁`:

* `Forces (edgeGraph n c.edges) k i j ⟹ r ≡ 0 (mod p)` — the residues coincide, so the difference's quadrance is `0`.
* `Separated (edgeGraph n c.edges) k i j ⟹ r ≡ 1 (mod p)` — the residues are adjacent, so the quadrance is `1`.

Over a 5-sealed field with 11 usable, a forced-equal pair at five colours therefore lies at a distance whose square is
divisible by the prime above 11 (`√11, √33, 2√11, …`), and a virtual edge at five colours at a distance with `r ≡ 1 (mod 11)`:
`r ∈ {1, 12, 23, 34, 45, 56, 67, 78, 89, 100, …}` — distances `1, 2√3, √23, √34, 3√5, 2√14, √67, √78, √89, 10, …`, and among
rationals `8/3` (`64/9 ≡ 64·5 = 320 ≡ 1`): the K-fabric's forced-equal distance at FOUR colours (M53's dial) is residue-allowed
as a virtual edge at five, and residue-forbidden as a forced-equal pair at five. The seed's own vocabulary: the cheats at
distance 2 (`r = 4`) and the forced pair at distance 5 (`r = 25 ≡ 3`) are in NEITHER set.

**The hex-shell corollary, for every sealing prime at once.** `χ(ℝ²) ≥ 6` needs (kernel, M48: `six_le_chromaticNumber_plane_of_
forced_pairs`) a virtual edge at `√3` AND one at `2` at five colours. `3 ≢ 0, 1` and `4 ≢ 0, 1` modulo every prime `p ≥ 5`. Hence:

> **Over any field with a usable prime `p ≥ 5` whose plane is 5-colourable, no finite unit-distance graph separates a `√3`-pair or
> a distance-2 pair at five colours, and none forces either pair equal.** Each of the two hex-shell gadgets — not only their
> conjunction — is impossible over a 5-sealed field.

This is the compulsion-level content of "sealed": the chromatic statement (`χ(F²) ≤ 5`, so no 6-forcer) says nothing about a
SINGLE gadget; the residue law says each gadget separately must escape every sealing prime. It is why the 6-forcer's field must
be 6-open, one gadget at a time — and the reason has the same shape as the 5-forcer's escape from 2 (G37, G43): the sealing
plane's own compulsion sets are trivial, so nothing pulled back through it can be rigid.

**What the milestone does NOT claim.** The kernel theorem is about certificates over the `√7`-free subring of the tower with
`11 ∤ D`, through the one residue hom `res11`; the field-level statement (every unit vector is 𝔭-integral, every unit-distance
graph in a field with 11 usable reduces) stays the hand argument of M58/`VERIFICATION.md` §1. And a pair compulsion at five
colours in a field where 11 is usable but the plane is NOT 5-colourable is unconstrained by this theorem (the transfer is
vacuous there — de Grey's field at 131, whose plane is ≥ 8-chromatic, is exactly that case).

### §S4. The kernel skeleton

Two new modules; nothing existing is edited (a declaration added to `FinitePlane11.lean` or `UnitQuadrance.lean` would rebuild
their dependents; `UnitQuadrance` has four).

**`Proofs/HadwigerNelson/ResidueObstruction.lean`** — the theory over any commutative ring (imports `UnitQuadrance`, `Lift` for
`quad`, `Arity` for `Forces`/`Separated` and their `comap`s, `PairDist` for `PairsAt`):

| declaration | statement | discharge |
|---|---|---|
| `unitQuadrance.translate (t : R × R) : unitQuadrance R →g unitQuadrance R` | `w ↦ w + t` | `unitQuadrance_adj`, `add_sub_add_right_eq_sub`, `add_left_injective` |
| `Aperiodic (col : R × R → Fin k) : Prop := ∀ d, d ≠ 0 → ∃ t, col t ≠ col (t + d)` | (A) | definition; `Decidable` for finite `R` by `inferInstance` |
| `CoincidesOffCircle (col) : Prop := ∀ d, d ≠ 0 → ¬ (unitQuadrance R).Adj 0 d → ∃ t, col t = col (t + d)` | (C) | definition; decidable |
| `eq_of_forces_of_aperiodic (col : (unitQuadrance R).Coloring (Fin k)) (ha : Aperiodic col) (f : G →g unitQuadrance R) (h : Forces G k u v) : f u = f v` | T1′ + (A) | by contradiction: `d := f v − f u`, the translate by `t − f u` |
| `adj_of_separated_of_coincides (col) (hc : CoincidesOffCircle col) (f) (h : Separated G k u v) : (unitQuadrance R).Adj (f u) (f v)` | T2′ + (C) | two cases on `f u = f v` |
| `UDCert.coord_distSq (hp : distSq = ((r * (D * D) : ℤ) : Q4)) : Δx·Δx + Δy·Δy = ((r * (D * D) : ℤ) : S)` | `coord_quadrance` at class distance `√r` | the same proof with `key := hp` |
| `UDCert.drawing_quad (hu) (hp) : quad (c.drawing φ hS u i − c.drawing φ hS u j) = (r : R)` | the distance law's identity | `drawing_adj`'s `linear_combination`, generalized |
| `UDCert.not_forces_of_pairsAt (col) (ha) (hu) (hv) (hp : c.PairsAt [(i, j)] r = true) (hr : (r : R) ≠ 0) : ¬ Forces (edgeGraph n c.edges) k i j` | `r ≢ 0` | `eq_of_forces_of_aperiodic` + `drawing_quad` at `f i = f j` |
| `UDCert.not_separated_of_pairsAt (col) (hc) (hu) (hv) (hp) (hr : (r : R) ≠ 1) : ¬ Separated (edgeGraph n c.edges) k i j` | `r ≢ 1` | `adj_of_separated_of_coincides` + `drawing_quad` + `unitQuadrance_adj` |
| `forces_iff_eq_of_aperiodic (col) (ha) : Forces (unitQuadrance R) k u v ↔ u = v` | the plane's own forced pairs | `f = id`; `←` trivial |
| `separated_iff_adj_of_coincides (col) (hc) : Separated (unitQuadrance R) k u v ↔ Adj u v` | the plane's own virtual edges | `f = id`; `←` is `Separated.of_adj` |
| `three_le_arityFloor_of_aperiodic_coincides (col) (ha) (hc) : 3 ≤ arityFloor (unitQuadrance R) k` | the plane is pairwise free | `le_arityFloor_iff`; `m ≤ 2`: `m < 2` by `two_le_arityFloor`; `m = 2`: `compels_two_eq`/`compels_two_ne` against the two `iff`s |

**`Proofs/HadwigerNelson/Instances/ResidueObstruction11.lean`** — the instance at 11 (imports the above and `FinitePlane11`):

| declaration | statement | discharge |
|---|---|---|
| `finitePlane11_aperiodic : Aperiodic finitePlane11Colouring` | (A) at 11 | `decide +kernel` (≤ 14,520 lookups) |
| `finitePlane11_coincides : CoincidesOffCircle finitePlane11Colouring` | (C) at 11 | `decide +kernel` |
| `finitePlane11_forces_iff : Forces (finitePlane 11) 5 u v ↔ u = v`; `finitePlane11_separated_iff : Separated (finitePlane 11) 5 u v ↔ (finitePlane 11).Adj u v`; `three_le_arityFloor_finitePlane11` | the sealing plane is pairwise free at five colours | instances of §S4's general theorems with the table |
| `UDCert.residue_eq_of_forces11 (c) (hS : c.CoordsIn Q4.sevenFree) (hu : u * c.denom = 1) (hv) (h : Forces (edgeGraph n c.edges) 5 i j) : c.drawing Q4.sevenFree.res11 hS u i = c.drawing … j` | forced-equal ⟹ equal residues | instance |
| `UDCert.residue_adj_of_separated11 … : (finitePlane 11).Adj (drawing i) (drawing j)` | virtual edge ⟹ residue edge | instance |
| `UDCert.not_forces_of_pairsAt11 (hr : (r : ZMod 11) ≠ 0)`, `UDCert.not_separated_of_pairsAt11 (hr : (r : ZMod 11) ≠ 1)` | the distance law at 11 | instances |
| **`UDCert.not_separated_sqrt3_11 (hp : c.PairsAt [(i, j)] 3 = true) : ¬ Separated (edgeGraph n c.edges) 5 i j`** and **`not_separated_two_11 (hp : … 4 …)`**, `not_forces_two_11`, `not_forces_five_11` (`25 ≡ 3`) | the hex-shell corollary and the seed's vocabulary at 11 | `(3 : ZMod 11) ≠ 1` etc. by `decide` |
| spec: Heule-510's forced pairs at five colours have equal residues (`heule510Reduce11 i = heule510Reduce11 j`, free); the hex-shell certificate (`hexShell`, denom 2, `√7`-free, `6 · 2 = 12 ≡ 1`) — `¬ Separated (edgeGraph 7 hexShellEdges) 5` at its first `√3`-pair and its first diameter through the theorem (a live call of the API on a certificate; trivially true otherwise, the point is the path) | the API exercised on real certificates | `decide` for the side conditions |
| reds: the 3-plane's table (`chi-p3.json`, 9 entries) as `finitePlane3Colouring` is proper (decide) and NOT aperiodic (its norm-2 differences are periods) — so `Aperiodic` is a real property and the hypothesis is load-bearing; `(12 : ZMod 11) = 1` pinned (`2√3` is residue-ALLOWED as a virtual edge: the theorem is silent there, by design); `(3 : ZMod 11) ≠ 1`, `(4 : ZMod 11) ≠ 1`, `(4 : ZMod 11) ≠ 0`, `(25 : ZMod 11) ≠ 0` as `#guard`s | | |

`Proofs.lean`: `ResidueObstruction` after `Lift`; the instance after `LiftObstruction19`. `scripts/Axioms.lean`: an M60 block with
`eq_of_forces_of_aperiodic`, `adj_of_separated_of_coincides`, `UDCert.not_separated_of_pairsAt`, `three_le_arityFloor_of_aperiodic_coincides`,
`finitePlane11_forces_iff`, `finitePlane11_separated_iff`, `three_le_arityFloor_finitePlane11`, `UDCert.not_separated_sqrt3_11`, `UDCert.not_separated_two_11`.

### §S5. The instrument (`tools/fpcompel.py`, new; `fplane.py` untouched)

| subcommand | what | record |
|---|---|---|
| `sets --p P --k K [--table FILE]` | `F_p(k)`, `S_p(k)` by norm class: the table's periods and never-coincident differences first (translations), then for every class the table leaves open a pinned SAT (`col 0 = col d` / `col 0 ≠ col d`) with its model verified proper; a class is `in S` only on the solver's UNSAT (marked untrusted), `not in S`/`not in F` on a VERIFIED colouring. At `p = 3` every proper colouring is enumerated. Headline: `p, k, the classes in F, the classes in S, of p−1; which verdicts are solver-trusted` | `data/fplane/compulsions-p<P>-k<K>.json` |
| `filter --stage … --p P --k K (--pairs "i,j;…" \| --asks FILE)` | reduce the stage at `p` (the frames of `fplane.reduce_stage`; the M55 stage assembled exactly from its three exact records), then per pair: the residue difference's norm class and the theorem's verdict — `forces-impossible` (norm ≠ 0), `separated-impossible` (norm ∉ S_p) WITH the explicit pullback colouring (the translate the proof names) verified proper on the whole stage and identifying the pair — the constructive content, settled with no solver; `allowed` otherwise. For an ask record: every `unknown` ask re-read | `data/fplane/residue-filter-<stage>-p<P>.json` |
| `augment --seed \| --object LABEL --p P --k K` | the cheats' residue pairs at `p`; the plane augmented by exactly those pairs; (i) is it `k`-colourable, (ii) if so does every `k`-colouring identify `r(A)` and `r(B)` (a pinned SAT). Reading: (i) NO ⟹ no pullback is proper on the `{1, 2}`-graph — the forcing lives entirely outside the residue family; (i) YES ⟹ (ii) MUST identify (a separating proper pullback would contradict the certified forcing), and then the finite plane carries a residue shadow of the seed's forcing | `data/fplane/augment-<stage>-p<P>.json` |
| `self-test` | the kernel table's two properties reproduced; a planted periodic proper colouring (a coset colouring) caught; a planted norm-4 pair on the seed gets `separated-impossible` with a verified identifying colouring; an edge gets `allowed`; the `p = 3` enumeration agrees with the pinned-SAT path class by class; a corrupted table (one cell changed) breaks properness | — |

Checkpointing: every subcommand is seconds to minutes; `sets` writes per class as it goes (the 19 plane's UNSATs could take minutes each).

### §S6. Phases and registered predictions

| phase | what | cost |
|---|---|---|
| 0 | `sets` at 3, 7, 11, 19 (the 11 answer already in hand); the records | minutes (running) |
| A | the two kernel modules; gate | half a day |
| B1 | `augment --seed --p 11` and on the it-4 object (149 standing cheats; also the 344 live) | hours |
| B2 | `filter --asks data/m55/ask-W-plus-cross-depth2-k5.json --p 11`: the 86 undecided asks re-read by theorem, verified colourings for every `separated-impossible` | hours (the exact assembly of the 10,541-point stage is the cost) |
| B3 | the descent's classes: every cheat (`r = 4`) and the forced pair (`r = 25`) at 11 — the theorem-level statement of why the in-field descent could never do a cheat's last job over K, K(√5), K(√247) (T17 one prime up, with the distance named) | derivation, minutes to record |
| C | Frontier, ledger row, G47, re-rank, report | — |

Registered predictions (P1–P3 are the stub's; P1–P2 were met at subplanning by one table — recorded as met-before-search; P3 is
refuted by derivation, and the refutation is the theorem):

| # | prediction | confidence | status |
|---|---|---|---|
| P1 | `F₁₁(5) = {0}` | — | **MET at subplanning** (the table has no period) |
| P2 | `S₁₁(5) = N₁` | — | **MET at subplanning** (every off-circle difference coincides at ≥ 4 translates) |
| P3 | every seed cheat pair has residues in `S₁₁ ∪ F₁₁` | — | **REFUTED by derivation**: cheats are at distance 2, `r = 4 ≢ 0, 1 (mod 11)`, so NO cheat's residues lie in either set — the cheats are exactly the pairs the residue plane can neither separate nor identify; the forced pair (`r = 25 ≡ 3`) likewise |
| P4 | `S₁₉(5) = N₁` (every non-unit class identified by some 5-colouring of the 19-plane) | medium | **MET** (phase 0 at opening: 18 classes, each identified by a verified colouring) |
| P5 | `S₇(4) ⊋ N₁` — the 4-chromatic plane at 7 (49 vertices, 4 colours) is tight enough that some non-unit class is separated by every 4-colouring | medium-low | **REFUTED** (phase 0: `S₇(4) = N₁`; the table's three extra never-coincident classes measured the table) |
| P6 | the seed's augmented plane at 11 (unit circle + the 446 cheats' residue pairs) is NOT 5-colourable | medium | phase B1 |
| P7 | of the 86 undecided M55 asks, at least 60 are settled `separated-impossible` by the residue filter with verified identifying colourings (residues of squared distances spread over `𝔽₁₁`; only `r ≡ 1` survives) | medium | phase B2 |
| P8 | `arityFloor (finitePlane 11) 5 ∈ {4, 5}`: no arity-3 compulsion in the sealing plane at five colours (M48's mask engine on 121 vertices decides it exactly) | low-medium | phase B (if cheap: `tools/arity.py` on the plane) |

Failure clauses: if the table at 11 had failed (A) or (C) (it did not), the kernel would carry a LIST of tables (the rotations,
or per-class colourings); if the augmented seed plane is 5-colourable and some colouring SEPARATES `r(A)` from `r(B)`, that is
an instrument catastrophe (it contradicts the certified forcing) and halts the phase.

### §S7. Decisions at subplanning

| decision | choice | alternative | why | confidence |
|---|---|---|---|---|
| kernel scope | the general theorem over any commutative ring with a colouring table satisfying (A)/(C), plus one instance at 11 | a second kernel instance at 19 | the 19 table fails (C) on its own (192 never-coincident differences), so the 19 statement needs per-class colourings from the solver — tools-only until P4's colourings exist as literals; if P4 holds they are 18 small tables and a second instance is an afternoon | high |
| where the theory lives | two new modules (`ResidueObstruction.lean`, `Instances/ResidueObstruction11.lean`) | declarations added to `UnitQuadrance.lean` / `FinitePlane11.lean` | a new declaration upstream rebuilds dependents (M59's lesson written into `Fan.lean`'s comment); the instance module mirrors `LiftObstruction*` | high |
| the instrument | a new `tools/fpcompel.py` importing `fplane.py` | subcommands added to `fplane.py` | M58's tool stays as its record describes; the new tool has its own self-test | high |
| the augmented-plane test | the cheats' SPECIFIC residue pairs | the whole norm-4 class as a Cayley generator | the pullback family is defined by the actual pairs; the class version is a different (stronger) finite object worth a line, not the test | high |
| the hex-shell corollary's statement | at the certificate level over `sevenFree` with `11 ∤ D`, plus the general `(r : R) ≠ 1` form for any prime through any hom | a field-level statement | the field-level integrality is the hand argument the programme already carries; the kernel says exactly what it checks | high |

## §M1. Domain-modeling pass (2026-09-07; fresh Skill invocation)

**Grok.** The objects are: a graph `G`, a hom `f` into a vertex-transitive graph `P` whose translations act simply transitively
on its vertices (the plane is `addCayley S` on the abelian group `R × R`, `S` the circle), and the colouring space of `P` at `k`
colours, on which the translations act. The compulsions of `P` at arity 2 are two relations on vertices: `Forces P k x y` (an
equivalence relation, the intersection of the kernel relations of all colourings) and `Separated P k x y` (a symmetric relation
containing adjacency). Both are invariant under every automorphism, so on a Cayley graph both are determined at the origin:
`Forces P k x y ↔ Forces P k 0 (y − x)`, `Separated P k x y ↔ Separated P k 0 (y − x)`. And a compulsion at the origin is refuted
by ONE colouring: `Forces P k 0 d` fails iff some colouring `C` has `C (t + d) ≠ C t` for some `t` — iff `d` is not a period of
`C` (Mathlib's `Function.Periodic C d := ∀ x, C (x + d) = C x`); `Separated P k 0 d` fails iff some colouring coincides at `d`
somewhere. The transfer to `G` is then a composition: compulsions of `G` map FORWARD along `f` (`Forces.comap` restated as
`Forces G k u v → Forces P k (f u) (f v)`), and `P` has none beyond the trivial ones.

**The cut.** Intrinsic: the group action (translations are automorphisms of every Cayley graph — Mathlib's
`addCayley_adj_add_iff_right`, a simp lemma, is exactly that), the reduction of a compulsion to the origin, and "one table refutes
one origin compulsion" through `Function.Periodic`. Incidental, and stripped: the circle (the property `CoincidesOffCircle` is
about NON-EDGES of the Cayley graph, whatever its connection set — renamed `CoincidesAtNonedges P col`); the ring (`unitQuadrance R`
is `addCayley _` by definition, so every Cayley-level theorem applies to it by unification and the plane is one instance);
the integrality of the class distance `r` (the plane-level distance law is `quad (f u − f v) = 0` / `= 1`, with no `r` at all;
`r : ℤ` enters only in the certificate corollaries where `PairsAt` puts it). Not adopted: naming the period subgroup (no
consumer inspects it; `Periodic.neg`/`.add` carry the structure if one ever does); a LIST of tables (the true object is the
colouring space; the origin-reduction theorem already takes "no origin compulsion at `d`" as its hypothesis, so a family of
tables is several applications of the one-table lemma — 19's eighteen colourings would instantiate it without a new theorem).

**Rebuild — the module's shape (replacing §S4's first table):**

| layer | declarations | idea |
|---|---|---|
| Cayley: translations | `addCayley.translate (t : A) : addCayley S →g addCayley S` (`v ↦ t + v`, Mathlib's lemma) | automorphism |
| Cayley: reduction to the origin | `forces_iff_forces_zero : Forces (addCayley S) k x y ↔ Forces … 0 (y − x)`; `separated_iff_separated_zero` | transitivity |
| one table refutes one origin compulsion | `not_forces_zero_of_not_periodic (col : Coloring) (h : ¬ Periodic col d) : ¬ Forces … 0 d`; `not_separated_zero_of_coincides (col) (h : ∃ t, col (t + d) = col t) : ¬ Separated … 0 d` | the two transfers T1′/T2′, contrapositive |
| the two table properties | `Aperiodic col := ∀ d, Function.Periodic col d → d = 0`; `CoincidesAtNonedges P col := ∀ d, d ≠ 0 → ¬ P.Adj 0 d → ∃ t, col (t + d) = col t` (decidable on finite `A`) | (A), (C) |
| the plane's own compulsions | `forces_iff_eq_of_aperiodic`, `separated_iff_adj_of_coincides`, `three_le_arityFloor_of_aperiodic_coincides` (Cayley level) | F = {0}, S = edges |
| the transfer, any graphs | `Forces.image (f : G →g P) : Forces G k u v → Forces P k (f u) (f v)`; `Separated.image` | compulsions map forward |
| the transfer, composed | `Forces.image_eq_of_aperiodic … : f u = f v`; `Separated.image_adj_of_coincides … : Adj (f u) (f v)` | one line each |
| the distance law, plane level (`unitQuadrance R`) | `Forces.quad_image_eq_zero : quad (f u − f v) = 0`; `Separated.quad_image_eq_one : quad (f u − f v) = 1` | no `r` |
| certificates | `UDCert.coord_distSq`; `UDCert.drawing_quad : quad (drawing i − drawing j) = u² · φ(Δx·Δx + Δy·Δy)` (hypothesis-free; `drawing_adj` is its `r = 1` face, left untouched upstream); `drawing_quad_of_distSq (hp : distSq = r·D²) : … = r`; `not_forces_of_distSq (hr : (r : R) ≠ 0)`, `not_separated_of_distSq (hr : (r : R) ≠ 1)`; the `PairsAt` wrappers | the residue of the squared distance IS the quadrance of the drawn difference |

**Seams.** Model of the hypotheses: the table at 11 (a `Coloring`, aperiodic, coincides at non-edges — decided). Unsampled members:
the zero ring and `k = 0` make every theorem vacuous and none wrong (a `Coloring (Fin 0)` of a nonempty graph does not exist);
`Nontrivial R` is needed nowhere in the transfer (only `drawing_adj` upstream used it). Adversarial member: a proper table WITH a
period — the 3-plane's table (`(1, 1)` is a period) — the theorem is silent, as it should be, and the plane at 3 is pairwise free
by its other eleven colourings (phase 0); kept as the red. Next-lemma test: the 19 instance states as `CoincidesAtNonedges` for
a family = eighteen applications of `not_separated_zero_of_coincides` with eighteen tables — no restatement; the shadow Cayley
graphs `Cay(𝔽_p², D)` (M58 D7) and the cell-family graphs (M39–M43, Cayley graphs of `ℤ²`) are instances of the Cayley layer with
no change. Decorrelation: the two properties were computed by the tool before the kernel states them (§S2), and the per-class
solver pass agrees with the table where the table decides.

**Decisions.** Cayley generality — adopted (subtraction: the translation lemma is Mathlib's; a plane-only statement would
re-prove it). `Function.Periodic` — adopted as the forced side's primitive (the standard word, with its API). The list of tables —
not adopted (the origin-reduction theorem absorbs it). `drawing_adj` — untouched upstream; `drawing_quad` is the new general
identity beside it. The plane-level distance law without `r` — adopted; `r : ℤ` confined to the certificate corollaries.

## §M2. Obligation-modeling pass (2026-09-07; fresh Skill invocation) — every leaf discharged in the probe

**The space.** No induction anywhere: every obligation is a case split, a rewrite along a translation, a `ring`/`linear_combination`
identity, or a finite decide. The partition: **prove** — the sixteen leaves below; **test** — the two decides at 11 (the model of
the hypotheses), the 3-plane reds, the residue `#guard`s; **assume** — a `Coloring` of the plane (data, never `Colorable`), the
subring hom and the denominator's inverse (the certificate's reduction hypotheses, M58's).

**Discharged (`build/m60/probe_obl.lean`, `lake env lean` green in 3.2 s, zero `sorry`):**

| obligation | discharge | shape |
|---|---|---|
| `forces_iff_forces_zero`, `separated_iff_separated_zero` | `→`: `h.image (translate S (−x))`, then `simpa only [translate_apply, neg_add_cancel, neg_add_eq_sub]`; `←`: `h.image (translate S x)`, `add_zero`, and `x + (y − x) = y` by `abel` | two translations |
| `not_forces_zero_of_not_periodic` | `refine h fun t => ?_`; the translated colouring `col.comap (translate S t)` at `0` and `d` is `col (t + 0) = col (t + d)` BY DEFINITION (`Coloring.comap` is composition — the `have` with the stated type is the whole proof), `add_zero`, symm | one colouring per `t` |
| `not_separated_zero_of_coincides` | dual: `show col (t + 0) = col (t + d)` after `refine hs (col.comap …) ?_` | one colouring |
| `forces_iff_eq_of_aperiodic` | `→`: `by_contra`, `sub_ne_zero.mpr`, `not_forces_zero_of_not_periodic col (fun hp => hd (ha _ hp))` on `forces_iff_forces_zero.mp h`; `←`: `rintro rfl; exact fun _ => rfl` | composition |
| `separated_iff_adj_of_coincides` | `→`: `by_contra`; `x = y` refuted by `h col rfl`; `x ≠ y`: `¬ Adj 0 (y − x)` from `¬ Adj x y` through `addCayley_adj_add_iff_right (d := x)` and `abel`, then `not_separated_zero_of_coincides col (hc _ hd hadj0)`; `←`: `Separated.of_adj` | composition + Mathlib's invariance |
| `three_le_arityFloor_of_aperiodic_coincides` | `le_arityFloor_iff.mpr`; `2 ≤ m` from `le_arityFloor_iff.mp (two_le_arityFloor ⟨col⟩)` (M45's lemma consumed exactly as designed); `m < 3` by `exact_mod_cast`; `omega` pins `m = 2`; `subst`; `compels_two_eq`/`compels_two_ne` on `q 0 = q 1` against the two `iff`s; injectivity of `T` refutes `T 0 = T 1` by `decide` | case bash at `m = 2` |
| `Forces.quad_image_eq_zero` | a TYPED `have hfu : f u = f v := h.image_eq_of_aperiodic col ha f` (a bare `rw` fails: the lemma's `f u` is coerced through `addCayley`, the goal's through `unitQuadrance` — the one incident of the pass), `sub_self`, `simp [quad]` | rewrite |
| `Separated.quad_image_eq_one` | `quad_eq_one_of_adj (h.image_adj_of_coincides col hc f)` — term mode; `unitQuadrance R` unifies with `addCayley _` everywhere | one line |
| `UDCert.drawing_quad` | `simp only [drawing, quad, Prod.fst_sub, Prod.snd_sub, map_add, map_mul, map_sub]; ring` | identity |
| `UDCert.coord_distSq` | `coord_quadrance`'s proof with `hp` as the key: `Subtype.ext`, `simp only [Pt.distSq, FastSq.sq_eq] at hp`, `push_cast`, `simpa only [coe_coord_fst, coe_coord_snd, Int.cast_mul] using hp` | copied shape |
| `UDCert.drawing_quad_of_distSq` | `rw [drawing_quad, coord_distSq, map_intCast]; push_cast; linear_combination (r : R) * (u * c.denom + 1) * hu` (the witness: `u²rD² − r = r(uD + 1)(uD − 1)`) | identity |
| `UDCert.not_forces_of_distSq`, `not_separated_of_distSq` | `intro h`; the plane-level law on `c.drawingHom …`; `change quad (drawing i − drawing j) = _ at this` (the hom applied is the drawing, definitionally); `rw [drawing_quad_of_distSq]`; `exact hr this` | composition |
| `finitePlane11_aperiodic`, `finitePlane11_coincides` | `decide +kernel` — both inside the probe's 3.2 s (the `∃ t` exits at the first witness; ≥ 4 per difference) | decide |

**Adversarial validation.** The model of the hypotheses is exhibited (the table at 11, both decides). The hypotheses are
load-bearing by construction of the reds: the 3-plane's table is proper and periodic (`¬ Aperiodic`, decided), so `ha` cannot be
dropped from `forces_iff_eq_of_aperiodic`; `(12 : ZMod 11) = 1` pins that `not_separated_of_distSq`'s `hr` is exactly `≠ 1` and
not weaker (a `2√3`-pair is residue-allowed). The statements read aloud: "a pair forced equal at five colours over the `√7`-free
subring has equal residues at 11; a virtual edge has adjacent residues; hence `√3`- and distance-2 pairs are neither" — and the
formal statements say exactly that, with the certificate-level hypotheses M58 already carries. Nothing in the pass changed a
statement; the decomposition is descending everywhere (sixteen leaves, each one idea).

## §M3. Experience-modeling pass (2026-09-07; fresh Skill invocation)

**The users.** (i) A session holding `Forces`/`Separated` on a certificate over Heule's field with M58's three reduction
hypotheses already in hand (`CoordsIn sevenFree`, the denominator's inverse, `Valid`) and asking what residues say: the path
must add nothing but the pair's class distance. (ii) A session citing "the plane at 11 has no pair compulsion at five colours":
three closed statements. (iii) The tools' reader of `data/fplane/*.json`. (iv) `exact?`/`apply?` on `¬ Separated (edgeGraph n
c.edges) 5 i j`. The frozen upstream vocabulary the surface must not rename: `Forces.comap`/`Forces.map` (Forcer.lean),
`Separated.comap` (Arity.lean), `res11`, `heule510Reduce11`, `finitePlane11Colouring` (FinitePlane11.lean).

**Decisions (each: choice · alternative · why · confidence).**

| surface | choice | alternative | why | conf. |
|---|---|---|---|---|
| the forward transfer | `Forces.image` / `Separated.image` (`Forces P k (f u) (f v)`), docstrings naming `comap` (per-colouring form) and `map` (endomorphisms) as the same fact | rename nothing, use `comap` inline | `comap`'s conclusion is about one colouring; the consumer holds the target graph's compulsion; `map` is taken by the endomorphism form in a frozen module | high |
| the translation hom | `addCayleyTranslate S t` in `HadwigerNelson` | `addCayley.translate` (reads as Mathlib's namespace; a future Mathlib name clash is plausible) | Mathlib's namespace stays Mathlib's; the docstring says whose the hom is | high |
| the origin reduction | `forces_iff_forces_zero_sub`, `separated_iff_separated_zero_sub` | `_zero` | the name says the right-hand side (`0` and `y − x`) | high |
| the coincidence hypothesis | the raw `∃ t, col (t + d) = col t` | a def `Coincides col d` | two uses, both readable raw; Mathlib names only the `∀` dual (`Periodic`); one fewer name | medium — if a third use appears, mint it |
| `@[simp]` | none: not the two `iff`s (data hypotheses), not the 11 instances (`Forces (finitePlane 11) 5 u v` never appears in a simp goal), not `drawing_quad` (its normal form is large) | tag the 11 instances | every simp lemma taxes every simp call; no consumer benefits | high |
| the distance law's names | `Forces.quad_sub_eq_zero`, `Separated.quad_sub_eq_one` (what vanishes / what is one) | `quad_image_eq_zero` | Mathlib names the shape of the conclusion | high |
| the certificate identity | `drawing_quad` (object-first, beside M58's `coord_quadrance`), `drawing_quad_of_distSq`, `coord_distSq`; `drawing_adj` untouched (a `--` note that it is the `r = 1` face) | re-derive `drawing_adj` from it | an upstream edit rebuilds four modules for a cross-reference | high |
| the six hypotheses | kept: M58's three (`hS hu hv`, named theorems every certificate already has) + `hps hmem` (one decide each) + `hr` (a decide) — the `_11` instances fix `r` and drop `hr` | bundle `CoordsIn ∧ u·D = 1 ∧ Valid` into one decidable predicate | `Valid` is never re-decided on a large certificate (`heule510_valid` is a theorem); bundling would push consumers to re-decide it | high |
| instance names | uniform `_11` suffix on theorems (`residue_eq_of_forces_11`, `not_separated_sqrt3_11`, …); defs keep M58's `res11` style | `finitePlane11` token in every name | length; the token is the module's | medium |
| the spelling trap | the bundled colouring is `finitePlane11Colouring.toColoring` (dot notation on the function) | `finitePlane11Coloring` (one letter from the function's name) | one object, one name; the trap is gone | high |
| the floor's upper end | `arityFloor_finitePlane11_le_five` by `arityFloor_le_of_degree` on five neighbours of the origin (`(1,0),(0,1),(10,0),(0,10),(5,3)`) — the bracket `{3,4,5}` in the kernel | leave `≤ 5` to the docstring | a consumer citing the bracket should not have to prove the easy half | high |
| the positive spec | an edge of Heule-510 is separated (`Separated.of_adj`) and the theorem returns adjacent residues | none | closes the loop — the theorem is not only a refuter | high |
| the second path | `#guard decide (Aperiodic …)` and `#guard decide (CoincidesAtNonedges …)`: the compiled evaluator beside the kernel decide | none | a decorrelated check of the two properties, free | high |
| module docs | both carry "what a consumer may conclude, and what not" (M58's pattern): certificate level, not field level; no table at a refusing prime | — | the boundary is the most important byte on the wire | high |
| the audit block | `Forces.image`, `forces_iff_eq_of_aperiodic`, `separated_iff_adj_of_coincides`, `three_le_arityFloor_of_aperiodic_coincides`, `UDCert.drawing_quad`, `UDCert.not_separated_of_distSq`, `finitePlane11_forces_iff`, `finitePlane11_separated_iff`, `three_le_arityFloor_finitePlane11`, `arityFloor_finitePlane11_le_five`, `UDCert.not_separated_sqrt3_11`, `UDCert.not_separated_two_11`, `UDCert.not_forces_five_11` | — | the headline theorems and every instance a report cites | high |

**The instrument's surface** (`tools/fpcompel.py`): every headline names its population and the trust of each verdict in the
same sentence (G21): `sets` — "p=11 k=5: F = {0}, S = N₁ of 10 norm classes; F by the table (aperiodic); S: 9 classes identified by
verified colourings (table 9, solver 0), 0 solver-UNSAT"; `filter` — per pair the residue norm, the verdict, and for
`separated-impossible` the TRANSLATE `t` of the table (the colouring `v ↦ table(res(v) + t)` is then re-derivable from the record's
residues and the table file without the tool) verified proper on the whole stage and identifying the pair; `augment` — the cheat
residue pairs, `k`-colourable or not (UNSAT marked untrusted), the A/B identification with its colouring; the error path: a stage
with a radical lacking a residue names the radical; the M55 assembly is accepted only when `n = 10,541` and all 69,910 edges land
on the circle, else it names the count. Records carry `claim_scope`. What the tool does NOT claim: solver UNSATs; anything the
kernel holds is the 11 instance only.

**The report surfaces.** §R0–§R8 as M59's; ledger row 55; G47 (the compulsion face of sealing — the four sealing planes pairwise
free — with its falsifier); the Frontier paragraph; the memory file.

**Applied to the skeleton (this commit):** every rename above; the floor's upper end; the positive example; the two `#guard`s;
both module docs; the probe regenerated from the renamed modules with the proofs substituted — green in 3.4 s.
