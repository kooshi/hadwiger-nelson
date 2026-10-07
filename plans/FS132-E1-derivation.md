# FS132-E1 — the opening of FS-132 and its first claim: the extraction at every number of colours

*Ephodos, 2026-10-07 (UTC). Brief: `data/fs132/briefs/FS132-E1-opening-and-first-claim.md`. Plan: `plans/FS132-six-by-the-nerve.md`.
Scripts and outputs: `data/fs132/e1/`. `M` is the release's manuscript,
`/home/kooshi/source/math/preprints/The-Euclidean-plane-is-not-five-colorable-September-23-2026/build/sections/`; `L` its Lean,
`/home/kooshi/source/math/lean/OAI/Geometry/PlaneColoring/` (read, never written).*

## Theorems this phase proved

- **C132-EXT-DISC** — the extraction on a disc, at every `k`, with clauses (4) and (5) added — [hand], one mind, kernel pending;
  § Stage 3, entry and § Argument — the extraction on a disc.
- **C132-CORES-FREE** — a cyclic centre in every closed disc of radius above 1, at every `k`, no hypothesis on the centres —
  [derived] from it, one mind; § Argument — cores exist.
- **C132-EXT**, **C132-CORES** — the posed forms, verbatim — [derived], one mind; § Argument — the posed forms.
- **C132-CONFINE** — clause (3) as confinement of a continuum by unit discs about support points — [hand], one mind;
  § Argument — confinement.

## Stage 1 — SAVED: the readback and the opening

The readback, the quotation check (`data/fs132/e1/readback.py`: `quotations=6 lines_matched=6 lines_mismatched=0`; six
mismatches with its fault), §G, §PA, §IQ, the two readings and the registered predictions are the plan,
`plans/FS132-six-by-the-nerve.md` (commit `373d06fa`). The readings went to the coordinator and are fixed in the claim list
(`data/fs132/claims.md`, § Dated lines), with C132-M-EMPTY and C132-M-CV entered as statements of their own.

**Draft for the stub** (`plans/STUB-six-by-the-nerve.md`; *replaces* the line beginning "**Provisional bearings (Poros,
2026-10-07; Ephodos's re-grokking replaces this line at the opening):**" through "one line of why each in § Bearing on the
answer."): "**Bearings (Ephodos, FS132-E1, 2026-10-07; the re-grokking is `plans/FS132-six-by-the-nerve.md` §G):** G94, G95,
G93, G79, G92, G15, G25, G83, G91, G86, G82, G21, G13, G22, G60, G71, G84, G85, G88–G90, G87, G29, G26; rows 131, 132, 137, 145,
148, 149 read by mechanism — one line of why each in the plan's §G; § Bearing on the answer stands as Poros wrote it."

## Stage 2 — SAVED: recognition on C132-EXT and C132-CORES

*`ephodos-recognition`, invoked fresh. No stall is being read: the shape is "a result proved only at an instance" (`k = 5`) and "a
known theorem that almost applies" (Proposition 7.1, whose section stands under a five-colour hypothesis).*

**For the stranger — a dimension theorist.** Let `D` be a closed disc in the plane and, for each scale `ε`, let
`q^ε : U → Δ^{k−1}` be a continuous map from a neighbourhood of `D` to a simplex (a partition of unity with `k` members). Suppose
that (a) for each member `i`, a connected set on which the `i`-th coordinate is positive and which lies off certain small discs
has diameter at most `1 + o(1)`; (b) there is a compact set `𝓛` such that, off small discs about `𝓛` and off further discs of
total radius `o(1)` each of which can be refilled inside a tree, `q^ε` takes values in the 1-skeleton. *Unknown:* must `𝓛` meet
`D`, and what does `q^ε` do on small circles about a point of `𝓛`? **This is a canonical map to the nerve of a cover of order
two off a singular set**, and the governing theorem is **Lebesgue's covering theorem** in its mapping form (a 2-cell has no map
into a graph that moves points less than its inradius: `[HurewiczWallman1948]` Thm IV 2, held since FS131-LEB; the manuscript's
Lemma 7.5 proves the form it needs by Brouwer). The second half — an essential loop of a map to a graph yields, for each edge of
a circuit, a connected fibre crossing an annulus — is the free fundamental group of a graph with a plane separation lemma; the
release's Lean replaces it by one statement with no words in it (`L/GraphPatches.lean:183`, `annulus_forest_extension`, for any
finite vertex type): *if the edges whose midpoint fibres cross the annulus form a forest, the outer boundary map extends over the
disc.*

**The features, sorted.**

| feature | sort | receipt |
|---|---|---|
| five labels | **splits** | consumed in § 7 only as `α < 1/5` (`M/interfaces.tex:174`), as "finitely many simple cycles in the complete graph on five vertices" (`:598`) and through Theorem 6.5 (`:195`); each of the first two holds at every `k` (control `reduced-words`); the third is the hypothesis |
| the square of side ten | accompanies | Lemma 7.5's proof uses a compact convex set and a point farther than the mesh from its boundary; a disc of radius above the mesh does (§ Argument, S6) |
| proper at almost every unit pair | determines | consumed at Lemma 7.2, in the mesh bound and in clause (3); a colouring by parallel stripes has no cyclic centre |
| `𝓛` finite on the compact set | **splits** | (i) core discs of total radius `o(1)`; (ii) a pigeonhole onto one centre; (iii) an annulus about that centre free of other centres — § Argument, S5 and S8; (iii) is a determiner of the conclusion *at that centre*: control `hex7-islands` (clause (4) fails at the accumulation centre) |
| §§ 5–6 of the manuscript (palettes, Lemma 6.2, the state lemmas) | accompanies | § 7 cites from them only (6.1)'s display and Theorem 6.5: control `sec7-cites` |
| the rate `|h|` in Definition 6.1 | determines | Lemma 7.3's `o(ε)` against discs of side `≍ ε` gives total radius `o(1)`; and clause (5) |

**Homes.** (1) *Dimension theory* — adopted: the proofs apply with nothing changed but the label count; the case `k = 5` stops
being special; it predicts a neighbour, checked: at every `k`, cyclic centres in every disc of radius above 1 (the hexagonal
colouring's vertices are `0.4`-dense), and one not checked (in `ℝ^d`, points where `d + 1` classes meet). (2) *Geometric measure
theory* (partitions of finite perimeter: triple junctions are `H¹`-null) — killed as a home for the statement: finite perimeter
is no hypothesis here; kept as a note for card 2, since it would supply (i) and not (iii). (3) *The regular theory*
(`[SokolovVoronov2025]` Props. 1–2) — the manuscript's own precedent; its failing hypothesis ("a regular map") is the step the
manuscript changed, by Hausdorff limits of fibres.

**The recognition agrees with the plan's**, with two refinements: "finite" splits into three consumptions, of which one is the
real hypothesis; and the class is every `k` and every disc of radius above 1, the instance (five, a square of side ten) a corollary.

## Stage 3 — SAVED: C132-CORES and C132-EXT

### The entries

derivation: C132-EXT-DISC
  statement: let k ≥ 1 be an integer, c a weak measurable k-colouring of the plane (`[OAIMath2026]` Definition 1.2), 𝓛 the set of its cyclic centres (the points x whose transition graph Γ_x, Definition 6.1 read with k labels, contains a cycle), and D a closed disc of radius greater than 1 with 𝓛 ∩ D finite; then there are a point x of 𝓛 in the interior of D, an integer ℓ with 3 ≤ ℓ ≤ k, distinct labels i_0, …, i_{ℓ−1}, a radius ρ > 0 with B̄(x, ρ) ⊂ D and 𝓛 ∩ B̄(x, ρ) = {x}, and for each j modulo ℓ a compact connected set K_j ⊂ B̄(x, ρ), a unit vector v_j and points q_{j,m} of K_j other than x, such that (1) x ∈ K_j and K_j meets the circle ∂B(x, ρ); (2) q_{j,m} → x and (q_{j,m} − x)/|q_{j,m} − x| → v_j as m → ∞; (3) H_{i_j} ∩ Δ(K_j) = ∅ and H_{i_{j+1}} ∩ Δ(K_j) = ∅, where H_i is the closed essential support of the class of label i and Δ(K) is the set of z with min over q ∈ K of |z − q| below 1 and max over q ∈ K of |z − q| above 1; (4) K_j ⊂ H_{i_j} ∩ H_{i_{j+1}}; (5) i_j i_{j+1} is an edge of Γ_x
  uses only: Definition 1.2 and Lemma 4.3 at k (density points of a class hold no unit pair); Definition 6.1 and that each edge-presence locus is closed; Lemmas 7.2 and 7.3 (which read two labels at a time); the threshold map with 0 < α < 1/k; that a clique in a forest has at most two vertices; trees are contractible; Lemma 7.5's argument on a disc of radius above the mesh (Brouwer); Lemmas 7.7 and 7.8 for a finite connected simple graph (or `annulus_forest_extension`, any finite vertex type); Hausdorff limits of continua; finitely many simple cycles in the complete graph on k labels. Of the centres it reads finiteness of 𝓛 ∩ D at three places: (i) Lemma 7.4 — the core discs' total radius |𝓛 ∩ D|·δ → 0 and one core disc per centre (`M/interfaces.tex:265–287`), consumed as |E_n| → 0 in the mesh bound and in clause (3); (ii) the pigeonhole "pass to a subsequence with a fixed x" (`:579–581`); (iii) **isolation of that x in 𝓛**, at "Choose ρ > 0 so small that B̄(x, ρ) … contains no other point of L_0 … The map g_n is therefore defined on the closed annulus" (`:581–590`) and at Lemma 7.8's use of the annulus's fundamental group ℤ (`:515–520`, `:568–571`): the continuum must cross an annulus about x that holds no other centre. It reads nothing of § 5, of Lemma 6.2 or of the state lemmas (control `sec7-cites`)
  not claimed: the conclusion when 𝓛 ∩ D is infinite — closed and totally disconnected does not let this argument run (§ Card 2); that a point whose transition graph contains a cycle of length ℓ carries this data with a cycle of length ℓ (the argument selects a centre by an essential loop of the nerve map; the converse of clause (5) is open, § The relation asked for); that the hypothesis holds for any six-colouring; that ℓ ≥ 4 at any centre; any value of χ(ℝ²); sharpness of the radius 1
  argument: § Argument — the extraction on a disc
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7, the hexagonal seven-colouring with circumradius 2/5 and any closed disc of radius above 1 — its cyclic centres are the honeycomb's vertices (18 of them in the disc of control `hex7-islands`), and at the vertex (0, 2/5) the data is the triangle of labels 0, 3, 2 with the three edges cut at ρ = 0.3 (control `hex7-model`); for k ≤ 5 no weak measurable k-colouring exists (`[OAIMath2026]` Theorem 1.4) and the statement is vacuous; at k = 6 the class is not known to be inhabited
  prior art: partly: `[OAIMath2026]` Proposition 7.1 with Lemmas 7.2–7.8 is this argument at five labels on a square of side ten, with clauses (1)–(3) and the sentence "The extracted cycle need not consist of edges of Γ_x"; the statement at every k, the disc, the hypothesis read, and clauses (4) and (5) not found in print — two web queries and the arXiv listing "chromatic number of the plane" newest first (nothing dated from 2026-10-06 on); zbMATH owed (its API returned 503 three times on 2026-10-07)
  handoff: de Bruijn — the statement at `Fin k` with the release's own constants (cores finite in `closedBall 0 8`, the map on `closedBall 0 5`): some core x at which the graph of common interfaces contains a cycle; by the release's skeleton with `commonInterface_graph_acyclic` (five-only) turned into a hypothesis and contraposed. Already general in `L`: `annulus_forest_extension`, `graph_forest_patch`, `forest_disk_extension`, `simplex_mem_forest`, `continuum_limit_support_exclusion`, `compact_open_cover_impossible`, `diskAverage_unit_pair`, `missing_edge_disk_cover`. Typed `Fin 5`, reading five only as α < 1/5: `thresholdMap`, `forest_chart`, `small_hole_map`, `HoleApprox`, `FullApprox`, `no_large_positive_sequence`, `CommonInterface`, `eventually_forest_of_bridges`. The disc of radius above 1 and clauses (4), (5) have no Lean counterpart; read the formal statement back against this one

*Dated line (2026-10-07, filed by FS132-Z1, the record job; sources: `plans/POROS-2026-10-07-fs132-round2.md` ll. 66–74; `plans/FS132-close-inventory.md` item 21; `data/fs132/claims.md`, the dated correction of item 21):* on clause (5) of the entry C132-EXT-DISC above, which stands as filed. The clause is still one mind's (step S11), against the letter of the manuscript's sentence "The extracted cycle need not consist of edges of Γ_x". Two rounds later its consumers are two, and small: a closing remark of FS132-E3 on mixed rings (the release's Lemma 6.2 acting on the extracted cycle), and the words "forming a cycle of the transition graph" in FS132-E5's C132-WIT-EX-FIN. No exclusion of the milestone reads it (C132-M-ORBIT reads clauses (1) and (3) only). The coordinator's ruling 16 (c) called it load-bearing for C132-TURN's stall, and that ruling is withdrawn: the clause is derived for the extraction's own continua and says nothing of whatever witnesses a hypothesis hands a point, for which the relation is false in general. No second reading of it was ordered; it keeps its flag for the two consumers named.

derivation: C132-CORES-FREE
  statement: for every integer k ≥ 1 and every weak measurable k-colouring of the plane, every closed disc of radius greater than 1 contains a cyclic centre
  uses only: C132-EXT-DISC in the case 𝓛 ∩ D = ∅, where its steps S5–S7 run with no core disc at all — nothing is read of the centres
  not claimed: that a closed disc of radius 1 or less contains one (in the model every disc of radius 2/5 does; the constant here is the mesh bound of Lemma 7.6, not a sharp one); that the centre found carries any continuum; anything about a colouring defined only on a disc
  argument: § Argument — cores exist
  verdict: derived
  grade: derived from: C132-EXT-DISC
  minds: 1
  model: k = 7, the hexagonal seven-colouring with circumradius 2/5 — every closed disc of radius 2/5 holds a vertex; and the island colouring `EXT-OAI2-SLACK7-L`, where the statement holds with infinitely many centres in every disc about v
  prior art: partly: `[OAIMath2026]` Lemma 7.6, last sentence ("This argument also rules out the possibility of having no core disks in Q"), at five labels and under Theorem 6.5; the statement with no hypothesis on the centres and at every k not found in print (searches as for C132-EXT-DISC)
  handoff: de Bruijn — at `Fin k` with the release's constants: `(Metric.closedBall 0 8 ∩ CyclicCore c).Nonempty`; it is `fullApprox_exists_of_finite_core` with `L = ∅` at `Fin k` against `no_large_positive_sequence` and `compact_open_cover_impossible`

derivation: C132-EXT
  statement: For every `k` and every measurable `c : ℝ² → {1, …, k}` proper at almost every unit pair whose cyclic centres (the manuscript's Definition 6.1 with `k` labels) are finite in the closed disc of radius 8: there are a cyclic centre `x`, a simple cycle of labels of length `ℓ ∈ {3, …, k}`, and `ℓ` compact connected sets through `x` with limiting directions, each excluding the essential supports of both its labels from its straddle set — the manuscript's Proposition 7.1 with `k` in place of five
  uses only: C132-EXT-DISC with D the closed disc of radius 8
  not claimed: what C132-EXT-DISC does not claim; that radius 8 is needed (any radius above 1 serves)
  argument: § Argument — the posed forms
  verdict: derived
  grade: derived from: C132-EXT-DISC
  minds: 1
  model: the model of C132-EXT-DISC, with the disc of radius 8 about any point
  prior art: partly: as C132-EXT-DISC
  handoff: de Bruijn — as the instance of C132-EXT-DISC that fits the release's Lean constants; the formal statement to read back is this one

derivation: C132-CORES
  statement: for every `k`, such a colouring has a cyclic centre in every closed disc of radius 8
  uses only: C132-CORES-FREE; the finiteness hypothesis carried by "such a colouring" is not used
  not claimed: what C132-CORES-FREE does not claim
  argument: § Argument — the posed forms
  verdict: derived
  grade: derived from: C132-CORES-FREE
  minds: 1
  model: the model of C132-CORES-FREE
  prior art: partly: as C132-CORES-FREE
  handoff: none — subsumed by C132-CORES-FREE, which crosses

derivation: C132-CONFINE
  statement: let K be a compact connected set and H a set with H ∩ Δ(K) = ∅; then for every z ∈ H, either K ⊂ B̄(z, 1) or K ∩ B(z, 1) = ∅; in particular, if x ∈ K and z ∈ H with |z − x| < 1 then K ⊂ B̄(z, 1), and if x ∈ K, z ∈ H, |z − x| = 1 and (q_m) is a sequence in K ∖ {x} tending to x with (q_m − x)/|q_m − x| → v, then v·(z − x) ≥ 0 when K ⊂ B̄(z, 1) and v·(z − x) ≤ 0 when K ∩ B(z, 1) = ∅
  uses only: the definition of Δ(K); for the last clause, |q − z|² = 1 − 2 (q − x)·(z − x) + |q − x|² when |z − x| = 1. Connectedness of K is not used
  not claimed: which of the two cases occurs; that the two cases exclude each other when |z − x| = 1 (K = {x} satisfies both); anything about labels — the statement has no colouring in it
  argument: § Argument — confinement
  verdict: derived
  grade: hand
  minds: 1
  model: K the segment from (0, 0) to (0.3, 0) and H = {(0.15, 0.9)} — the largest distance from that point to K is √(0.15² + 0.81) ≈ 0.912 < 1, so it is outside Δ(K) and K ⊂ B̄(z, 1); checked on the hexagonal model by control `hex7-model`, whose zero count is this statement's contrapositive for the supports of the two edge labels
  prior art: known: the contrapositive of the manuscript's definition (7.1) of the straddling region; the sign form is the mechanism of its Lemma 8.1 (read at its statement in `plans/EXT-OAI2-reading.md` § 3.1, not in `M/angular.tex`)
  handoff: none — a relay-result for the readings (the dictionary's replacement for "the same tile")

control: hex7-model
  of: C132-EXT-DISC — clauses (3) and (4) on the model: the hexagonal seven-colouring at the vertex (0, 2/5), three edges cut at ρ = 0.3, clause (3) on 8,963 grid points of the three straddle sets
  run: python3 ../data/fs132/e1/hex7_check.py model
  expect: vertex-labels=3 edges=3 delta-samples=8963 violations=0 clause4=True
  fault: python3 ../data/fs132/e1/hex7_check.py model --fault

control: hex7-islands
  of: C132-EXT-DISC — where its hypothesis fails: the island colouring; a disc of radius 1.05 with finitely many centres; clause (4) for the straight edge at the accumulation centre v; clauses (3), (4) at the isolated centre of island 6
  run: python3 ../data/fs132/e1/hex7_check.py islands
  expect: island-free-disc=True vertices-in-disc=18 clause4-at-v=False clause3-at-b=0 clause4-at-b=True
  fault: python3 ../data/fs132/e1/hex7_check.py islands --fault

control: sec7-cites
  of: C132-EXT-DISC — its uses only: the labels the manuscript's § 7 cites from outside itself
  run: python3 ../data/fs132/e1/refs_outside.py interfaces.tex
  expect: eq:source-14 sec:transitions thm:cyclic-local-finiteness
  fault: python3 ../data/fs132/e1/refs_outside.py transitions.tex

control: reduced-words
  of: C132-EXT-DISC — step S8's count: every cyclically reduced closed edge word of length at most 7 in the complete graph on 3 to 6 labels contains a simple cycle
  run: python3 ../data/fs132/e1/words_check.py
  expect: 0
  fault: python3 ../data/fs132/e1/words_check.py --fault

### Argument — the extraction on a disc

*The manuscript's § 7 walked with `k` labels. Each step says what it reads of the count and of the centres. Where I only read a
step and did not rework it, it says so.* Fix `k`, `c`, `D = B̄(o, r)` with `r > 1` and `𝓛 ∩ D` finite. Write `a_i` for the
indicator of class `i`, *typical* for a density-one point of its own class.

**S0. Standing facts at `k`.** Definition 1.2 is stated for every `k` (`M/introduction.tex:83–96`), and so is Lemma 4.3: the
density points of a class hold no unit pair, and typical points are conull (`M/transfer.tex:266–270`; its proof names one class).
`H_i`, `D_ij(B, h)` and `Γ_x` are defined label by label and pair by pair. *Count: none. Centres: none.*

**S1. `𝓛` is closed.** The locus where a fixed pair is an edge is closed, because `D_ij` is monotone in its ball
(`M/transitions.tex:41–44`); the locus of a fixed simple cycle is a finite intersection of such; `𝓛` is the union over the
simple cycles of the complete graph on `k` labels. *Count: that union is finite. Centres: none.*

**S2. Disc averages (Lemma 7.2).** `p_i^ε` is continuous, `Σ_i p_i^ε = 1`, `Lip(p_i^ε) ≤ C/ε`, `p_i^ε → a_i` in `L¹_loc`;
`p_i^ε(q) + p_i^ε(z) ≤ 1` at **every** unit pair (translate both points by one uniform vector of `B(0, ε)`: almost every
translate puts both in the typical set); and if `q_n → q`, `ε_n → 0`, `liminf p_i^{ε_n}(q_n) > 0`, then `q ∈ H_i`. Reworked.
*Count: none (one label). Centres: none.*

**S3. A missing edge (Lemma 7.3).** If `ij ∉ Γ_z` there is a ball `B` about `z` with `D_ij(B, h) = o(|h|)`; for `B̄′ ⊂ B`,
`∫_{B′} p_i^ε p_j^ε ≤ sup_{0<|h|≤2ε} D_ij(B, h) = o(ε)` (expand the two averages over independent shifts `h_1, h_2`; the root
`q + h_1` lies in `B`); and for `B̄″ ⊂ B′` the set `{p_i^ε > α, p_j^ε > α} ∩ B″` lies in the interiors of finitely many discs
of total radius `o(1)` (squares of side `≍ αε`, on each of which both averages exceed `α/2`: their number `N` has
`N ε² α² ≲ o(ε)`). Reworked. *Count: none (two labels). Centres: none.*

**S4. The threshold map.** Fix `0 < α < 1/k`. Some `p_i^ε ≥ 1/k > α` at every point, so
`q_i^ε = (p_i^ε − α)_+ / Σ_m (p_m^ε − α)_+` is a continuous map to the simplex on the `k` labels, and `q_i^ε > 0` iff
`p_i^ε > α`. `𝒢` is the simplex's 1-skeleton, the complete graph. *Count: `α < 1/k`, and nothing else. Centres: none.*

**S5. Holes and tree fillings (Lemma 7.4).** Choose `1 < r′ < r` with `∂B(o, r′) ∩ 𝓛 = ∅` (finitely many radii to avoid) and put
`D₁ = B̄(o, r′)`, `L_0 = 𝓛 ∩ D`: `D₁` plays the manuscript's `Q`, `D` its `Q′`. For `δ > 0`,
`M_δ = D ∖ ⋃_{x ∈ L_0} B(x, δ)` is compact and `Γ_z` is a forest at each of its points. S3 at the non-edges of `Γ_z` gives
`s_z`; finitely many `B(z, s_z)` cover `M_δ`, with a Lebesgue number `λ_δ`; their marked discs have total radius
`m_{δ,ε} → 0` as `ε → 0`. At a point of `M_δ` outside the marked discs the labels with `p_i^ε > α` are pairwise edges of the
forest of a selected ball, so they are at most two and `q^ε` lies in `𝒢` — indeed in that forest. Merging discs until closures
are disjoint costs an arbitrarily small total; a final disc is *core* if its class holds some `B(x, δ)`. With `δ_n → 0` and
then `ε_n`, `η_n` small: the total radius of all final discs is at most `|L_0| δ_n + m + η → 0`; each non-core final disc is
smaller than `λ/3`, lies in one selected ball, its boundary circle maps into one tree of that forest, and the map is extended
over it inside the tree. This gives `g_n : D₁ ∖ ⋃_{x ∈ L_0 ∩ D₁} B_{n,x} → 𝒢`, continuous, equal to `q^{ε_n}` off the open
final discs (the *holes* `ℋ_n`), with exactly one core disc `B_{n,x} ∋ x` per centre, of diameter `→ 0`, inside
`int D₁` or disjoint from `D₁`. The merging bookkeeping read, not reworked. *Count: none. Centres: finiteness, twice — the total
radius `|L_0| δ_n → 0` (use (i)), and one core disc per centre with a positive distance to `∂D₁` and to each other.*

**S6. The cover obstruction on a disc (Lemma 7.5).** *A closed disc of radius `r′` has no finite relatively open cover of
multiplicity at most two whose members have diameter at most `m < r′`.* With `z_a ∈ U_a` and the partition of unity
`φ_a ∝ dist(·, D₁ ∖ U_a)`, the map `F = Σ φ_a z_a` takes `D₁` into a finite union of segments and moves no point more than `m`;
for `|y − o| < r′ − m` the map `z ↦ y + z − F(z)` takes `D₁` into `B̄(y, m) ⊂ D₁` and has a fixed point (Brouwer), where
`F = y`; so `F(D₁)` contains an open disc. Reworked from the manuscript's proof for the square of side ten and mesh two; the
same proof. *Count: none — no colouring in it. Centres: none.*

**S7. An essential core (Lemma 7.6).** Suppose that for infinitely many `n` every core loop `g_n|∂B_{n,x}`, `x ∈ L_0 ∩ D₁`, is
null-homotopic in `𝒢` (this includes the case of no core at all). Fill them: `g̃_n : D₁ → 𝒢`. The components of the sets
`{(g̃_n)_i > 0}` are an open cover of `D₁` of multiplicity at most two. Its mesh is at most `1 + o(1)`: otherwise some label
`i`, some `c₀ > 0` and paths in `{(g̃_n)_i > 0}` join points more than `1 + c₀` apart; move an endpoint that lies in a hole to
the path's exit from it; the endpoints `a_n → a`, `b_n → b` have `p_i^{ε_n} > α`, `|a − b| > 1`, and `a ∈ H_i` (S2); for `z` in
a small ball `U` about `a` the path holds a point at distance exactly 1 from `z`, outside every closed hole unless `z` lies in
`E_n`, the union of the unit annuli about the holes, `|E_n| ≤ 4π Σ radii → 0`; there `p_i^{ε_n} > α`, so
`p_i^{ε_n}(z) ≤ 1 − α`, and `α |A_i ∩ U| ≤ ‖p_i^{ε_n} − a_i‖_{L¹(U)} + α |E_n ∩ U| → 0`, against `a ∈ H_i`. For large `n` the
mesh is below `r′`, against S6. **So for all large `n` some core disc in `D₁` has a boundary loop that is not null-homotopic;
in particular `L_0 ∩ D₁ ≠ ∅`.** Reworked. *Count: none (the multiplicity is two because `𝒢` is a graph). Centres: use (i),
through `|E_n| → 0`.*

**S8. One centre, a simple cycle, crossing fibres (Lemmas 7.7, 7.8).** `L_0 ∩ D₁` is finite: along a subsequence one `x` has an
essential core loop at every index (use (ii)). Choose `ρ` with `B̄(x, ρ) ⊂ int D₁` and `B̄(x, ρ) ∩ L_0 = {x}`; for large `n`
the other core discs miss `B̄(x, ρ)` and `B̄_{n,x} ⊂ B(x, ρ)`, so `g_n` is defined on the annulus
`𝒜_n = B̄(x, ρ) ∖ B_{n,x}` — **this is where isolation is read (use (iii))**: with another centre in every `B(x, ρ)` there is a
core disc inside the annulus and no map on it. The inner loop's cyclically reduced word `W_n` is non-empty and contains a simple
cycle (Lemma 7.7; control `reduced-words`); there are finitely many simple cycles on `k` labels, so along a subsequence one
cycle `i_0 … i_{ℓ−1}`, `3 ≤ ℓ ≤ k`, serves every `n`. For each of its edges, with midpoint `m_j`, the fibre `g_n^{−1}(m_j)` has
a compact connected component `K_{n,j}` meeting both boundary circles of `𝒜_n` (Lemma 7.8: otherwise a polygonal loop in
`𝒜_n` missing the fibre winds `d ≠ 0` times about `x`, and its image is freely homotopic to `W_n^d` — the annulus's group is
`ℤ` — while a loop missing `m_j` has a reduced word without that edge). Lemmas 7.7 and 7.8 are stated for a finite connected
simple graph; read in full, not reworked; the release's Lean holds the same step for any finite vertex type without words
(`annulus_forest_extension`). *Count: finitely many simple cycles, of length at most `k`. Centres: uses (ii) and (iii).*

**S9. Limits: clauses (1)–(3).** Along a further subsequence `K_{n,j} → K_j` in the Hausdorff metric, for every `j`; `K_j` is
compact and connected, holds `x` (the inner contact points tend to `x`) and meets `∂B(x, ρ)`. For a closed ball
`U ⊂ Δ(K_j)` and large `n`, every `z ∈ U` has points of `K_{n,j}` nearer and farther than 1, so one at distance exactly 1
(connectedness); for `z ∉ E_n` it lies outside the closed holes, where `g_n = q^{ε_n} = m_j`, so both endpoint averages exceed
`α` there and `p_i^{ε_n}(z) ≤ 1 − α`; as in S7, `|A_i ∩ U| = 0`. So `H_i ∩ Δ(K_j) = ∅` for both endpoint labels. The radii of
points of `K_j` fill `[0, ρ]`; points at radii `ρ/m` have a subsequence of directions converging to some `v_j`. Reworked.
*Count: none. Centres: (i), through `|E_n| → 0`.*

**S10. Clause (4) (mine).** Let `q ∈ K_j`, `q = lim q_n`, `q_n ∈ K_{n,j}`. If `q_n` lies in a hole `B`, then, `K_{n,j}` being
connected and of diameter at least `ρ − o(1)`, larger than `B`'s, it meets `∂B` at some `q′_n` with `|q′_n − q_n| → 0`; on
hole boundaries `g_n = q^{ε_n}`. So in every case there are `q′_n → q` with `q^{ε_n}(q′_n) = m_j`, hence
`p_i^{ε_n}(q′_n) > α` for both endpoint labels, and `q ∈ H_{i_j} ∩ H_{i_{j+1}}` by S2. *Count: none. Centres: none further.*

**S11. Clause (5) (mine; the manuscript says only that the cycle "need not consist of edges of `Γ_x`").** Fix `j`, write
`i, i′` for its labels, and let `B` be any ball about `x`; take `r₀ > 0` with `2r₀ ≤ ρ` and `B̄(x, 3r₀) ⊂ B`. The radii
`|q − x|`, `q ∈ K_{n,j}`, fill `[diam B_{n,x}, ρ]`; the radii of points lying in open holes have measure at most
`2 Σ radii → 0`; so the good radii in `[r₀, 2r₀]` have measure `r₀ − o(1)` and for large `n` there are at least `(r₀/2)·C/(α ε_n)` points `q_s ∈ K_{n,j}` outside the holes with radii in
`[r₀, 2r₀]` pairwise at least `α ε_n / C` apart (greedy). At each, `p_i^{ε_n}, p_{i′}^{ε_n} > α`, so both exceed `α/2` on
`B(q_s, α ε_n/(2C))`, and these balls are disjoint. Hence `∫_{B(x, 2r₀ + ε_n)} p_i^{ε_n} p_{i′}^{ε_n} ≥ c r₀ ε_n` with
`c = π α³/(32 C)`. By the expansion in S3 there are `h_1 ≠ h_2` in `B(0, ε_n)` with
`D_{ii′}(B, h_2 − h_1) ≥ c r₀ ε_n ≥ (c r₀/2) |h_2 − h_1|`. So `limsup_{h→0} D_{ii′}(B, h)/|h| > 0` for every ball `B` about
`x`: `i i′ ∈ Γ_x`. *Count: none. Centres: none further.* ∎

### Argument — cores exist

Let `D` be a closed disc of radius above 1 and suppose `𝓛 ∩ D = ∅`. Then `𝓛 ∩ D` is finite and C132-EXT-DISC gives a point of
`𝓛` in `D`. (Read directly: S5 runs with `L_0 = ∅` and no core disc, S7's map `g_n` is defined on all of `D₁`, and its cover
contradicts S6. No property of `𝓛` is read: if `𝓛 ∩ D` is infinite it is non-empty.) ∎

### Argument — the posed forms

C132-EXT is C132-EXT-DISC with `D` the closed disc of radius 8: "a cyclic centre `x`" is its `x ∈ 𝓛`; "a simple cycle of labels
of length `ℓ ∈ {3, …, k}`" its distinct labels; "compact connected sets through `x` with limiting directions" its clauses (1),
(2); "each excluding the essential supports of both its labels from its straddle set" its clause (3). C132-CORES is
C132-CORES-FREE at radius 8, whatever "such a colouring" assumes. ∎

### Argument — confinement

Let `z ∈ H`. Then `z ∉ Δ(K)`, so it is not the case that `min_K |z − q| < 1 < max_K |z − q|`: either `max_K |z − q| ≤ 1`, that
is `K ⊂ B̄(z, 1)`, or `min_K |z − q| ≥ 1`, that is `K ∩ B(z, 1) = ∅`. If `x ∈ K` and `|z − x| < 1` the second fails. If
`|z − x| = 1` and `q_m → x` in `K` with directions `→ v`: `|q_m − z|² − 1 = −2 (q_m − x)·(z − x) + |q_m − x|²`; in the first
case this is `≤ 0`, so `(q_m − x)·(z − x)/|q_m − x| ≥ |q_m − x|/2 → 0⁺` and `v·(z − x) ≥ 0`; in the second it is `≥ 0`, so
`v·(z − x) ≤ 0`. ∎

### The conclusion at six, as a list (for the two jobs that read against it)

For a weak measurable six-colouring `c` of the plane and a closed disc `D` of radius above 1 **in which `c` has finitely many
cyclic centres** (the hypothesis; nothing supplies it for an arbitrary six-colouring — G95), C132-EXT-DISC gives:

- **E0 — the centre.** A point `x ∈ int D` with `Γ_x` containing a cycle, and no other cyclic centre in `B̄(x, ρ)`.
- **E1 — the label cycle.** Distinct labels `i_0, …, i_{ℓ−1}`, `ℓ ∈ {3, 4, 5, 6}`; by (5) it is a simple cycle **of `Γ_x`**.
  Nothing says which `ℓ`; nothing says the labels outside the cycle are absent near `x`.
- **E2 — the continua.** For each cycle edge a compact connected `K_j ⊂ B̄(x, ρ)` through `x` reaching `∂B(x, ρ)`. No arc,
  no tangent, no local connectedness; two of them may share points other than `x`. *Restriction:* for `0 < ρ′ < ρ` the component
  of `x` in `K_j ∩ B̄(x, ρ′)` reaches `∂B(x, ρ′)` (boundary bumping) and keeps (3), (4), (5), since `Δ(K′) ⊂ Δ(K)` for `K′ ⊂ K`.
- **E3 — a limiting direction** `v_j` of each `K_j` at `x`: one subsequential limit of directions, not a tangent; `K_j` may
  have others.
- **E4 — the two-label exclusion.** `H_{i_j}` and `H_{i_{j+1}}` miss `Δ(K_j)`. In C132-CONFINE's form: for every `z` in either
  support, `K_j ⊂ B̄(z, 1)` or `K_j ∩ B(z, 1) = ∅`; for `z` within less than 1 of `x`, the first; for `z` on the unit circle
  about `x`, `K_j` stays on one side of the unit circle about `z` and `v_j·(z − x)` has the corresponding sign.
- **E5 — the continuum is an interface.** `K_j ⊂ H_{i_j} ∩ H_{i_{j+1}}` (clause (4)).
- **Beside the data, at every `k`** (the release's count-free statements; their Lean types as listed in
  `plans/EXT-OAI2-reading.md` § 4.2, not re-read here): palettes `P_x` and their transport; `P_x(e) ∩ P_x(Re) = ∅` almost
  everywhere; and, **because of (5)**, Lemma 6.2 applies to every edge of the extracted cycle: `P_x(e) ⊄ {i_j, i_{j+1}}` for
  almost every `e`.

### The relation asked for (the coordinator's ruling (b))

*Between "the centre's own transition graph contains a cycle of length `ℓ`" and "the extraction returns that centre with a
cycle of length `ℓ`".* **One way, derived:** if the argument returns `x` with the cycle `i_0 … i_{ℓ−1}`, that cycle is a simple
cycle of `Γ_x` (clause (5), S11). **The other way is not claimed and is open** as a statement about the data; as a statement
about the argument's selection it is false in general: the argument selects a centre by an essential loop of the nerve map, and
a centre can have a cyclic transition graph and a null loop — six sectors coloured 1, 2, 3, 1, 3, 2 about a point, planted in
the local slack of the hexagonal colouring near a vertex of colours 1, 2, 3, have all three pairs as interfaces along rays and
read the word `(12)(23)(31)(13)(32)(21)`, which reduces to nothing (hand, one mind, no control; the planted disc creates other
centres on its rim). So "extracted with length `ℓ`" implies "`Γ_x` contains an `ℓ`-cycle", and `Γ_x` may contain longer or
other cycles that the extraction does not return.

### The two controls at seven: what the statement says

- **The hexagonal seven-colouring.** The hypothesis holds on every disc. By (4), each `K_j` is a connected subset of
  `H_a ∩ H_b` through a vertex `x`, so it lies in one of the three edges at `x` and its labels are two of the three colours at
  `x`: the statement returns **a vertex, the triangle of its three colours, and its three edges** cut at `ρ` — and can return
  nothing else. (With clauses (1)–(3) alone this is not forced; clause (4) is what pins it.) Control `hex7-model`.
- **The island colouring** (`EXT-OAI2-SLACK7-L`). C132-CORES-FREE holds, with infinitely many centres near `v`. C132-EXT-DISC
  **says nothing on a disc containing `v`** (its hypothesis fails) and applies on every disc of radius above 1 that misses
  `B(v, 0.03)`, returning an ordinary vertex. At the isolated centres where an island's rim meets the edge the conclusion holds
  (two arcs of the rim and the edge beyond: control `hex7-islands`, `clause3-at-b=0 clause4-at-b=True`). **At the accumulation
  centre `v` the conclusion with clause (4) fails for the triangle 1, 2, 3**: `H_1 ∩ H_2` near `v` is the edge with the open
  islands removed, which holds no connected set through `v` (`clause4-at-v=False`); only 1, 2, 3 are present near `v`, so no
  other cycle is available. With clauses (1)–(3) alone the straight edges do satisfy it at `v`, by the hexagonal colouring's
  margins. If islands are planted at every vertex, the hypothesis fails on every disc of radius above 1 while the conclusion
  holds at every isolated centre: **finiteness is sufficient and not necessary**, and a weaker hypothesis must still select
  the centre.

### Card 2, answered on the way (not stretched for)

*"Which property of the set of cyclic centres does the extraction's argument read — finite on compacts, or only closed and
totally disconnected?"* **Neither as posed.** The argument reads (i) that `𝓛 ∩ D` can be covered by discs of total radius
tending to 0 — zero one-dimensional Hausdorff measure, strictly between the two; (ii) nothing, where it uses a pigeonhole
(compactness gives a limit point of essential cores); (iii) **that the essential centre is isolated in `𝓛`** — the falsifier
the card names, "a continuum that must reach a fixed radius … an annulus free of centres", at `M/interfaces.tex:581–590`.
"Closed and totally disconnected" fails (i) for sets of positive length and fails (iii) at every non-isolated centre, and the
island colouring shows (iii) is not an artefact: at `v` the four-clause conclusion is false. Finiteness is the one hypothesis
on `𝓛` alone that gives (iii) at whichever centre is essential. **Not derived, a sketch for card 2's job:** for `𝓛 ∩ D`
countable and closed, fill cores from the bottom of the Cantor–Bendixson rank (an isolated centre whose common-interface graph
is acyclic is eventually fillable, by the Lean's contrapositive form; a centre of rank one is then isolated among the unfilled
ones, and fibres crossing the filled discs still carry clause (3), because the filled discs' total radius tends to 0); the step
I have not done is the uniformity in `n` over infinitely many lower-rank centres. The island colouring is countable and closed.

### Footholds at six (statements about every weak measurable six-colouring; each at its grade)

1. **C132-CORES-FREE at `k = 6`** — every closed disc of radius above 1 contains a cyclic centre. [derived], one mind.
2. **The dichotomy** — in every closed disc of radius above 1, either the cyclic centres are infinite, or there is one with
   the data E0–E5. [hand], one mind (C132-EXT-DISC read as a disjunction).
3. **A composition, not entered** (one mind; Lemma 6.2 and Cor. 5.4 taken at their statements): at a centre returned with
   cycle `C`, almost every palette lies inside no edge of `C` and is disjoint from the palette 60° on. For a triangle at six:
   almost every palette holds a label outside the triangle or is the whole triangle. For a six-cycle: almost every palette has
   at least two labels and is no pair of neighbours on the cycle.
4. **A candidate, unchecked against REG-J′'s wording**: in an honest saturated colouring with REG-J′ a cyclic centre is a
   singular point, so `𝓛` is locally finite and the extraction applies with no further hypothesis.
*Not claimed by any of these:* a value of `χ(ℝ²)`; that a six-colouring exists; that `ℓ ≥ 4` anywhere.

### An invention signal's whiff (G87; no side picked)

Side A, the reading § 4.3: "[L₆] the centres whose transition graph has a cycle are locally finite … **Not supplied.**" — the
extraction is asked to wait on local finiteness. Side B, this record: at the island colouring's accumulation centre the
conclusion with clause (4) is false, and with clauses (1)–(3) true; at the isolated centres beside it, true. Both sides share
the premise that "the conclusion at a centre" is one statement. It is two (with and without (4)), and they part exactly at an
accumulation. Which of them the six-colour kills need is card 1's to say.

### Where the second job takes over

C132-RUN-EMPTY is unstarted beyond its statement and dictionary (the plan). What this record hands it: E0–E5; C132-CONFINE as
the replacement for "the same tile"; clause (5), which lets Lemma 6.2 act on the extracted cycle. **Unread by this job, to be
read first there:** `M/angular.tex` (the manuscript's § 8: Lemma 8.1's strips and Lemma 8.6–8.7's six sectors are the measurable
V6-RING/V6-WIN/V6-HUBS, by my reading of the reading's § 3.1 only); `plans/FS131-L8A-landing.md` § 7 (the kernel's errata for
`emptyNS`); `fs131-w7:plans/FS131-w7-kernel-plan.md`; `plans/FS114-CVB-verification.md` § 1.4; `LEDGER.md` rows 138, 150.
C132-RUN-CV, C132-DIAG, C132-RADIUS: unstarted.

### Drafts for the coordinator's files (by-product, two of eight; the other six — G25, G60, G80, G81, G82, G86, G91's
amendments — unstarted)

- **G64**, `.claude/skills/grokkings/SKILL.md`. *Replaces* "**Warning:** "six is skipped" is **not** evidence for seven — it is
  equally consistent with every field being `≤ 5` and `χ(ℝ²) = 5`. What forces seven is the conjecture's bold form at `K(√7)`
  (G48), never the skipping." *with* "**Warning:** "six is skipped" is **not** evidence for seven. Since `[OAIMath2026]`
  (`χ(ℝ²) ≥ 6`) the statement W reads `χ(ℝ²) = 7`, and S (no field's plane is six-chromatic) still does not follow from it; what
  would force seven is a proof, never the skipping."
- **G94**, same file. *Replaces* "if the latter, the statement to prove is local finiteness of cyclic centres and nothing
  about arcs." *with* "if the latter, the statement to prove is about the cyclic centres and nothing about arcs: that they
  exist needs no hypothesis (FS-132, C132-CORES-FREE), and a centre's continua need that centre isolated among them
  (C132-EXT-DISC; finiteness on a disc of radius above 1 suffices and is not necessary)."

### Predictions scored so far

P1 (0.93, EXT as posed) **met**. P2 (0.90, CORES with no hypothesis, every disc of radius above 1) **met**. P3 first half
(0.05, totally disconnected suffices by the manuscript's argument) **met as a NO**; second half (0.55) **open**.
