# M55 — absorption: the theorem behind "many spindles over one fabric", the ν dial, and what the theorem admits (STUB + SUBPLAN, 2026-09-06; §1–§9 the stub, §B onward the subplan)

*Minted 2026-09-06 (UTC) on Kooshi's "You are go for the next
milestone", with the compaction instruction "next: many spindles over one fabric" — `CLAUDE.md`
§ Paths forward item 1 after M54. Written to the stub rule's standard: everything the deciding session
knew, in plain language, so a session with zero conversation memory can subplan it with all meaning
intact. Read beside this: `plans/M54-five-colour-dial.md` §R3–§R8 (the objects, the derivation that
produced them, the sweep that read them floppy), `Proofs/HadwigerNelson/CriticalSet.lean` (the
localization theorem), `CLAUDE.md` § Grokkings G9, G12, G19, G31, G37, G39.*

## 1. Mission context, in plain language

The project hunts new mathematics about the plane's chromatic number; the kernel holds
5 ≤ χ(ℝ²) ≤ 7. A **pair compulsion at five colours** on a finite unit-distance graph — two points
forced to share a colour in every proper 5-colouring, or forced apart while not adjacent — gives
χ(ℝ²) ≥ 6 by a kernel theorem (`OneDefect.lean`, the spindle; `HexShell.lean`, the two virtual
edges). Nobody has one; every 5-chromatic unit-distance graph ever swept is *pairwise floppy* at
five colours.

M54 said where such a compulsion can live at all: the **critical set** C(G) — the vertices whose
deletion makes the graph 4-colourable — must sit inside the pair's common unit neighbourhood, so
at most two points, and none if the pair is more than two apart. That is the dial's first rung,
*redundancy*: the graph's 5-chromaticity must survive every single deletion. M54 built the first
two unit-distance graphs with that property (two spindles at two centres over one fabric: 5,857 and
2,229 points, C = ∅ by derivation and by census) and swept the smaller one completely at five
colours in 31 seconds: **0 forced pairs, 0 virtual edges**. Redundancy is necessary, not sufficient.

M54's close named the next obstruction from the sweep's shape rather than from the numbers: each
spindle copy is a rotated piece of 4-colourable fabric hanging off the base by a handful of chords,
and any 5-colouring of the base extends over such a piece by painting the few conflicting chord
endpoints with the fifth colour — **absorption**. The paths-forward entry proposed to beat it with
*many* spindles at many centres over one fabric, "so that no large sub-piece is 4-colourable".

**This milestone begins by deriving that the proposal cannot work as stated, for any number of
spindles, and turning the reason into a kernel theorem with a measurable quantity attached.** A
copy at a new centre never touches the other copies and attaches to the base only through its
fused centre and a thin conic of chords (G12's quadrature law, measured again at M54: 8 and 11
chords, 0 copy–copy); so every copy is absorbed in turn, and the union's 5-colourings restrict onto
ALL 5-colourings of the base, whatever the number of copies. The star is floppy by theorem. What
the theorem leaves open is exactly what the milestone then measures: the fifth colour's smallest
class ν (= the fewest deletions to 4-colourability), which the theorem brackets a priori; the
single-centre "flower" (many rotation *powers* about one centre, de Grey's genre), which the theorem
does NOT decide because its petals share a hub; and the cross lattice one depth further into
F₂₄₇ = ℚ(√3, √11, √247), where points of outside-degree ≥ 2 first appear. Predictions are registered
before any run (G30).

## 2. The objects

| name | what it is | where |
|---|---|---|
| **U** | the it-4 object's unit part: 1,953 K-points (K = ℚ(√3, √11)), 13,796 unit edges, 4-chromatic, 4-rigid at 2-adic valuation 6: **163 of its 178 pairs at distance 8/3 are forced equal in every 4-colouring**, 8 of 11 at 8/√3; every vertex lies in at most two forced pairs; Δ = 33 | label L4 = `S29-depth2r-it2v2-depth1-it2v2-depth1-vdel28-it2v2-depth1`; the dial `data/m53/rigidity-dial-it4.json` (`forced_pairs`) |
| **R_{x,q}** | the spindle rotation about a point x for a forced pair (x, y) at distance d = √q: cos θ = 1 − 1/(2q), sin θ = √(4q − 1)/(2q), so that y and R(y) are a unit apart; for q = 64/9 the rotation is (119 + 3i√247)/128 and the copy lives in F₂₄₇ | `tools/forced_spindle.py`, `five_dial.build_multi_spindle` |
| **F_i** | the forcing-critical set of pair i: the vertices of U whose single deletion stops U forcing the pair (one 3-second ask per vertex); F₁ = {29, 79, 161, 199, 1753, 35, 1859}, F₂ = {428, 508, 607, 813, 1939}, disjoint | `data/m54/forcing-critical-U-*.json`; `build/m54/forcing_census.py x,y` |
| **star₂** | U ∪ R₁(U − x₁) ∪ R₂(U − x₂) for pairs (35, 1859), (813, 1939): 5,857 points, 41,390 edges, chords U–R₁ 8, U–R₂ 11, R₁–R₂ 0; C = ∅ (derivation + 34/34 checked); its exhaustive five-colour sweep IN FLIGHT at minting (chain 4, `build/m54/sweep-union-full-4.log`) | `data/m54/spindles-35_1859-813_1939-full.json` |
| **core-star₂** | core₁ ∪ R₁(core₁) ∪ core₂ ∪ R₂(core₂), the two 1-minimal forcing cores (588 and 543, overlap 31): 2,229 points, 12,030 edges, chords 6 and 7, C = ∅ (31/31 checked); **sweep complete: 0 / 0 in 31 s** | `data/m54/spindles-35_1859-813_1939.json`, `sweep-spindles-35_1859-813_1939.json` |
| **W, W ∪ P₁** | the 1,175-point witness (core₁ ∪ R₁ core₁, vertex-critical) and its depth-one F₂₄₇ cross pool (71 points, 20 fusions, 114 pool edges; W ∪ P₁ = 1,238 points, C loses three copy-side vertices) | `data/m54/witness-exact-core-8over3.json`, `cross-lattice-W-core-8over3.json`, `W-plus-cross.json` |
| **H** | the Exoo–Ismailescu seed as a {1, 2}-graph: 214 points, 35 proper 5-colourings up to palette, **ν(H) = 38** — the calibration of "no spare colour anywhere" | `tools/batchkill.Obj()`; `data/m54/nu-exact-EI-seed-12graph.json` |

Every K-point set is 4-colourable by the residue colouring (Theorem B, hand-proved, `plans/FIELD-WALL-THEOREM.md`);
every copy R_i(U) is an isometric image of a K-point set and so 4-colourable too, and in a 5-colouring of the
whole it has a spare colour of its own.

## 3. Derived before any instrument runs (2026-09-06, at minting)

Throughout, G is a graph on a vertex set V, A ⊆ V a set of vertices, B = V ∖ A, and "k-colourable" means
proper with k colours. `Forces G k p q` = every proper k-colouring gives p and q the same colour;
`Separated G k p q` = every proper k-colouring gives them different colours.

**D1 — the extension principle (the abstract carrier).** Say A *extends* at k colours if every proper
k-colouring of the induced subgraph G[A] is the restriction of a proper k-colouring of G. Then for
p, q ∈ A: `Forces G k p q ↔ Forces G[A] k p q` and `Separated G k p q ↔ Separated G[A] k p q`.
(Restriction gives ←; extension gives →.) So when A extends and G[A] is (k−1)-colourable, **no pair
compulsion at k colours lives among A's vertices** — the spare-colour lemma relative to a piece.
Two sentences; the whole milestone's kernel content is sufficient conditions for "A extends".

**D2 — hub-and-matching absorption (the spindle copy's shape).** Suppose there is a vertex x ∈ A (the
hub) such that (i) G[B ∪ {x}] is k-colourable, (ii) every b ∈ B has at most one neighbour in A, and
(iii) the vertices of B whose A-neighbour is not x are pairwise non-adjacent. Then A extends at k + 1
colours. *Proof.* Given a (k+1)-colouring c of G[A]: take a k-colouring φ of G[B ∪ {x}]; if c(x) ≤ k,
permute φ's palette so φ(x) = c(x) — then every b ∈ B adjacent to x has φ(b) ≠ c(x); if c(x) = k+1
nothing is needed. Colour B by φ, then repaint each b whose (unique, non-hub) A-neighbour a has
c(a) = φ(b) with the spare colour k+1: the repainted vertices are pairwise non-adjacent by (iii),
their A-neighbour has colour ≠ k+1 (it conflicted with a colour ≤ k), and they are not adjacent to x
(by (ii) their only A-neighbour is a ≠ x). Every other edge is proper by construction. ∎
The plain matching case (no hub: x any vertex of A with no B-neighbour, (i) reducing to "G[B] is
k-colourable") is the instance. **The hypothesis (iii) is load-bearing**: a k-colourable piece is not
in general k-*choosable*, so a matching attachment with adjacent endpoints can refuse a colouring of A
(K₂,₄ attached by a matching at three colours is the planted red — §7).

**D3 — degree absorption (the 5-core).** A vertex b of degree ≤ k: every (k+1)-colouring of G − b
extends (its neighbours use at most k colours). Iterating: peel every vertex of degree ≤ k, then every
vertex whose degree in the remainder is ≤ k, and so on; what remains is the **(k+1)-core** of the
graph, and every pair compulsion at k + 1 colours among its vertices is the core's own. **At five
colours nothing outside the 5-core is ever visible.** The depth-one cross-pool points of M54 §R1 have
two parents and ≤ 2 pool edges each (degree ≤ 4): invisible by D3 unless depth two raises their degree.

**D4 — symmetric copies force only through fused points.** Let G′ be two disjoint copies of G joined
by chords (a, a′) between corresponding vertices for a in any set S (a spindle's *ring* chords
y–R(y), with no fusion). For k ≥ 2 every k-colouring c of the first copy extends: colour a′ with
c(a) + 1 (mod k). So the spindle's refusal at four colours lives entirely in the fused centre (the
copy's image of x IS x), which is the single-centre corollary of M54 seen from the other side, and a
petal attached by ring chords alone is absorbed with no spare colour at all.

**D5 — ν is the deletion distance to 4-colourability.** Define ν(G) = the minimum, over proper
5-colourings, of the smallest colour class. A colour class S has G − S 4-coloured by the other four
colours, and conversely; so **ν(G) = δ₄(G) := min{|S| : G − S is 4-colourable}**, the fewest vertices
whose removal makes the graph 4-colourable. Consequences: ν ≥ 1 ⟺ χ ≥ 5; ν ≥ 2 ⟺ C(G) = ∅ (M54's
first rung is exactly ν ≥ 2); ν ≥ the maximum number of vertex-disjoint 5-chromatic subgraphs; and
under D2, **ν(G) ≤ ν(G[A]) + |E(A, B) ∖ E(x, B)|** — the spare colour is spent only on the matching's
conflicts, never on the hub's chords. ν(H) = 38 on the seed is what "no spare colour anywhere" reads;
every 5-chromatic unit-distance witness ever built reads ν = 1 (vertex-critical or nearly).

**D6 — what this says about the constructions.**

* *The m-spindle star* U ∪ ⋃ᵢ Rᵢ(U − xᵢ), distinct centres. Each copy B = Rᵢ(U − xᵢ) is attached to
  the rest by: its hub xᵢ ∈ U (chords to the copy's images of xᵢ's neighbours), a thin conic of cross
  chords to U (8 and 11 measured), and NOTHING to the other copies (0 chords measured; by the
  quadrature law a copy–copy pair couples on a conic of its own, thin). G[B ∪ {xᵢ}] ≅ G[U] is
  4-colourable. So, provided the conic chords form a matching with pairwise non-adjacent copy-side
  endpoints (a census, §7), D2 applies to every copy in turn and **U extends at five colours: the
  star's 5-colourings restrict onto ALL 5-colourings of U, for every m** — no compulsion among U's
  vertices, and ν(star) ≤ Σᵢ |conic chords of copy i| by D5. The sweep of core-star₂ (0 / 0 in 31 s)
  and the sweep of star₂ in flight are instances of this theorem on the base's pairs; the theorem
  says nothing about pairs with a copy-side endpoint, which the sweep still reads. **Path 1(a) is
  closed by derivation: adding centres adds absorbed pieces.**
* *The flower* U ∪ ⋃_{k=±1..±K} R^k(U − x), one centre, rotation powers (de Grey's single-centre
  genre). Every petal shares the hub x; consecutive petals are joined by ring chords (≤ 2 per petal,
  since U has ≤ 2 points at distance 8/3 from any vertex) and by the conic of the relative rotation
  (the same 8 chords as U–R(U), rotated); petals k, k+2 by the conic of R². D2 applies to each petal
  with hub x if the non-hub chords form a matching with independent endpoints: **the flower's
  U-pairs are floppy by theorem too.** What D2 does not decide is the critical set: the hub x is
  critical iff flower − x is 4-colourable, i.e. iff the chain of conic constraints between 2K + 1
  petals (each a 4-chromatic K-coset minus a point) is satisfiable at four colours. M54 measured the
  two-petal case satisfiable (x ∈ C(W⁺)). Registered: satisfiable at K ≤ 3 (P-M55-4); if NOT, the
  flower is a C = ∅ object of a new kind (its 5-chromaticity carried by conic chords, not by spindle
  triangles) and becomes the milestone's main object (§6).
* *Fusion is impossible between copies of U.* For centres x ≠ x′ the composite R_{x′}⁻¹ R_x is the
  translation by (x′ − x)(1 − e^{−iθ}), which is not a K-vector (1 − e^{−iθ} = (9 + 3i√247)/128 ∉
  K(i)), so R_x(U) and R_{x′}(U) share no point; powers about one centre share only the centre. Dense
  attachment by fusion — de Grey's 1344/234 fusion record — needs fabric already containing the
  rotated material, i.e. fabric grown in F₂₄₇ under the spindle words: the cross lattice, one depth
  further, is the first such thickening, and D3 says its points matter only once their degree
  reaches 5.
* *What survives every absorption theorem*: pieces that are themselves 5-chromatic and overlap (no
  4-colourable piece thinly attached), or interfaces that are dense AND non-symmetric AND non-hub —
  which in this field means fabric closed under the spindle rotation (the F₂₄₇ closure), priced by
  the depth-two census in phase B5.

## 4. The order of work

| phase | what | cost | reads |
|---|---|---|---|
| **0** | **Kernel**: `Proofs/HadwigerNelson/Absorb.lean` — D1 (`Extends`, `forces_induce_iff`, `separated_induce_iff`, `not_forces_of_extends_of_colorable`), D2 (`extends_of_hub_matching`, the matching instance), D3 (`extends_compl_singleton_of_degree_le`), D4 (`symCopy`, `extends_symCopy`), the K₄−e spec (the compulsion survives a pendant thin piece; a degree-2 vertex is invisible at three colours), the planted red (K₂,₄ attached by a matching with adjacent endpoints refuses a colouring: hypothesis (iii) load-bearing) | an afternoon, no compute | the theorem the whole milestone rests on |
| **A** | **Instrument** (`tools/five_dial.py`): `absorb` (per piece: k-colourability of the piece-plus-hub, outside-degree profile, matching-endpoint independence, the D2 verdict, the D5 ν bound); `core5` (the 5-core by peeling: how much of a stage is visible at five colours); `nu-ihs` (exact ν by implicit hitting sets over solver cores with assumptions — cadical's `get_core` — checkpointed, walled, reporting a bracket); `multi-spindle` (m spindles from a pair list, `--full` or cores, and `--power k` for the flower); `cross-lattice --depth 2` (the glue census over W ∪ P₁ itself); every subcommand with a planted control seen red first | half a day | — |
| **B1** | the in-flight sweep of star₂ lands: record (§R addendum); `absorb` on star₂ and core-star₂ (P-M55-2): are the copies absorbed by D2? | minutes | whether the 0 / 0 readings are theorem instances |
| **B2** | ν exact on core-star₂ by `nu-ihs` (P-M55-3), the upper bound from the sweep's 78 checkpointed models first; then on star₂ if the engine reaches it (a wall is an honest outcome) | ≤ 1 h each | ν = 2 or more: whether the copies' rigidity spends more than one fifth-colour vertex each |
| **B3** | the three-spindle star: a third forcing census (pair chosen with F₃ disjoint from F₁ ∪ F₂; 10 min), core₃ by the greedy shrink (~1 h, checkpointed) or the full fabric; build; C = ∅ by derivation (spot-checked on F's); `absorb` verdict; ν by `nu-ihs` (P-M55-5) | ~2 h, background | the ν = m law, and the D2 verdict at m = 3 |
| **B4** | the flower at K = 1, 2, 3 about x = 35 (3, 5, 7 petals): build; ONE 4-colour ask each (flower − x 4-colourable?) (P-M55-4); `absorb` on the petals; if any refuses, the critical census on {x} ∪ ⋃ R^k(F₁) (≤ 1 + 7·6 asks) and the milestone's re-plan (§6) | ≤ 1 h | whether the single-centre genre has a C = ∅ member |
| **B5** | the depth-two cross lattice of W: the glue census over all pairs of W ∪ P₁ at distance < 2 (exact, F₂₄₇), the pool P₂, its fusions and edges, the total-degree profile of P₁ ∪ P₂, the 5-core of W ∪ P₁ ∪ P₂ (D3), and its critical census (P-M55-6) | ≤ 1 h | whether F₂₄₇ thickening produces visible material (degree ≥ 5) |
| **C** | close: the gate, `data/m55/README.md`, the Frontier (the M55 paragraph, ledger row 49, paths forward re-ranked from what D2 admits), G40, T24, the jobs ledger, the report | | |

Order: 0 → A → B1/B2 (B3, B4, B5 launched as the box allows: one heavy solver job at a time — the
star₂ sweep is one until it lands; censuses at ≤ 24 workers beside it are fine, they are seconds-long
asks) → C.

## 5. Registered predictions (scored at the close; G30: derived first where a derivation exists)

| # | prediction | basis |
|---|---|---|
| P-M55-1 | star₂'s sweep (in flight) reads 0 forced-equal, 0 virtual edges, complete | D2 + D6 for the base's pairs; the copy-side pairs by the same absorption argument run from each copy's side, not a theorem (registered at M54 §R4 already) |
| P-M55-2 | `absorb` finds every copy of star₂ and core-star₂ absorbed by D2: outside-degree ≤ 1 on every copy vertex not adjacent to its hub, non-hub chord endpoints pairwise non-adjacent, G[copy ∪ hub] 4-colourable | the conic chords are 6–11 scattered points; the copy is a K-coset |
| P-M55-3 | ν(core-star₂) = 2 exactly (lower bound: C = ∅; upper: the two spindle chords' base endpoints y₁, y₂ deleted, if the remaining conic chords are palette-compatible — else ≤ 2 + conflicts ≤ 13 by D5); ν(star₂) = 2 if the engine reaches it | D5; the spare colour is spent once per spindle chord |
| P-M55-4 | flower − x is 4-colourable at K = 1, 2, 3 (x critical, ν(flower) = 1) | M54: W⁺ − x 4-colourable; the conic constraints between petals are 8 per adjacent pair against the huge 4-colouring space of U − x |
| P-M55-5 | the three-spindle star has C = ∅ (F's pairwise disjoint) and ν = 3 | D6, D5 |
| P-M55-6 | the depth-two pool P₂ is sparse (< 0.2 % of the tested pairs), lattice-like (fusions and pool edges present), and the total-degree profile of P₁ ∪ P₂ is ≤ 4 for ≥ 90 % of pool points; the 5-core of W ∪ P₁ ∪ P₂ drops ≥ 90 % of the pool; C(W ∪ P₁ ∪ P₂) is nonempty (ν = 1), shrinking from C(W ∪ P₁) by at most a few copy-side vertices | M54 §R1's 0.04 % and 20 fusions; D3 |
| P-M55-7 | the planted red (K₂,₄ by a matching) refuses; the planted green (a pendant K-piece on K₄−e) extends — the kernel's spec examples elaborate first try after the modeling passes | D2's proof |
| P-M55-8 | no compulsion at five colours is found anywhere in the milestone (the jackpot clause stays armed and unfired) | D1–D6 |

## 6. Failure and jackpot clauses (registered before any instrument runs)

* **Jackpot**: any confirmed pair compulsion at five colours on any stage — the `ask`/`sweep` jackpot
  protocol (banner, second encoding, jackpot file, exit 3) — HALT AND VERIFY; nothing else matters.
* **D2 contradicted by a measurement** (a copy the census certifies absorbed, on which the sweep
  reads a compulsion among base vertices): an instrument bug or a false theorem — the kernel decides;
  halt the census and audit.
* **ν outside D5's bracket** ([2, Σ conflicts] on a C = ∅ object): instrument bug (the bracket is a
  theorem).
* **flower − x refuses four colours at some K** (P-M55-4 missed): the flower is a C = ∅ candidate of a
  new kind; run the restricted critical census ({x} ∪ ⋃ R^k(F₁)), and if C = ∅ the exhaustive
  five-colour sweep on it becomes the milestone's main run, the star phases demoted to background.
* **the depth-two pool produces points of degree ≥ 5 in quantity** (P-M55-6 missed in its degree
  half): the F₂₄₇ thickening is live; the critical census and, if C = ∅, the sweep on W ∪ P₁ ∪ P₂ —
  the paths-forward entry 1(b) upgraded.
* **`nu-ihs` walls on core-star₂** (2,229 points): report the bracket; the ν readings of larger
  objects are then upper bounds from checkpointed models only, stated as such.

## 7. Instruments to build (one file, `tools/five_dial.py`; every subcommand with a self-test or planted control seen red before its first real run)

| subcommand | asserts | planted control |
|---|---|---|
| `absorb --graph <stage> [--pieces from meta.names]` | per copy side B with hub x: G[B ∪ {x}] k-colourable (SAT; the colouring verified), the histogram of A-neighbours per B-vertex (with the hub excluded), the non-hub endpoint set and its induced edge count, the D2 verdict, the D5 bound ν ≤ ν(A) + \|matching\| | K₂,₄ attached by a matching with adjacent endpoints: verdict "not absorbed (iii fails)" and a witnessed non-extending colouring; K₄−e plus a pendant path: "absorbed" |
| `core5 <stage> --k 5` | the (k)-core by peeling; the count and identity of peeled vertices; headline "n_core of n visible at k colours" | a path attached to K₅: the path peels, K₅ stays |
| `nu-ihs <stage> --k 5 --wall --max` | ν exactly, by implicit hitting sets: assumptions ¬dᵥ for v ∉ S, solver core K ⇒ every deletion set meets K; S := a minimum hitting set of the cores (exact for small sizes, greedy bound otherwise); SAT at S ⇒ ν ≤ \|S\| with the 4-colouring of G − S verified; checkpoints the core list | K₅ plus a disjoint K₅: ν = 2; the seed H: ν = 38 (exact, known) |
| `multi-spindle --pairs "x1,y1;x2,y2;…" [--full \| --cores] [--power k1,k2,…]` | the m-spindle union (a `--graph` stage with points and sides), each pair verified at its distance, near-misses rejected; `--power` for the flower (one centre, rotations by kθ exact via ρ^k) | the two-spindle union reproduces M54's fingerprint |
| `cross-lattice --depth 2` | the glue census over all non-adjacent pairs of W ∪ P₁ at distance < 2 in F₂₄₇, the pool P₂, fusions, pool edges, the total-degree profile | depth-one output reproduced when run on W alone |
| `build/m54/forcing_census.py x,y` | (existing) F for a third pair | — |

## 8. Cost anchors (desktop, 32 cores, 125 GB; measured at M54, populations named)

* a 4-colour deletion ask on U (1,953 points): 3 s; on star₂ (5,857): up to 1,800 s wall in the
  worst case, seconds typically; a forcing census of U: 1,951 asks / 24 workers ≈ 450–640 s.
* the greedy 1-minimal shrink of a forcing core on U: 4,254 s (pair 2), sequential, checkpointed.
* the exhaustive five-colour sweep: core-star₂ 31 s (78 models); star₂ — each seeded model 220 s
  (no-AMO), the first batch query at ~3.4 M selectors ran > 2 h at 4 GB on the un-seeded attempt.
* the depth-one cross census of W: 287,695 pairs, 28 workers, minutes.
* `nu-ihs`: unmeasured — each iteration one 4-colour SAT with assumptions (seconds on 2,229 points),
  iterations unknown (cores are not minimal); the wall is the design.

## 9. Discipline

Every headline names its population and its conditioning (G21). Every SAT colouring is verified in
Python; UNSAT verdicts are solver-trusted and read in the safe direction (an UNSAT core only enlarges
a hitting set; an UNSAT deletion ask only says "not critical", which is the direction that admits more
candidates). One heavy solver job at a time (the star₂ sweep holds the slot until it lands); every phase
over 15 minutes checkpoints. The jobs ledger `data/m53/jobs-ledger.txt` records every launch.

## §B. Decisions settled at subplanning (2026-09-06, before the modeling passes)

| decision | choice | alternative weighed | why | confidence |
|---|---|---|---|---|
| B1 the milestone's spine | the absorption theorem first, then ν and the three constructions the theorem does not decide | build the m-spindle star and sweep it, as the paths-forward entry says | D6 derives the star floppy for every m (G30: a sweep would measure a theorem); what the theorem leaves open is cheap to measure and is where a surprise could live | high |
| B2 the theorem's shape | one abstract carrier (D1, "A extends") with three sufficient conditions (D2 hub-and-matching, D3 degree, D4 symmetric copy) | three separate compulsion-transfer theorems | the extension property is what every instance actually proves, and the compulsion transfer is two lines from it; the sufficient conditions are independently reusable | high |
| B3 the hub in D2 | stated with a hub x ∈ A and G[B ∪ {x}] k-colourable (the spindle copy's real shape), the plain matching case an instance | the plain matching version only | the copies of U are attached at their fused centre to up to 33 copy-side vertices that are NOT independent (unit triangles at the centre), so the plain version does not apply to a single M54 object | high |
| B4 ν's engine | implicit hitting sets over solver cores (assumption literals, `get_core`), exact when the hitting-set step is exact | RC2 (walled at M54 on both objects); the cardinality ladder (one SAT with AtMost-s: hard at s ≥ 2) | cores localize the 5-chromatic subgraphs; the hitting-set step is tiny while the cores are few; every step is a plain 4-colour ask | medium — iterations unknown; the wall and the checkpoint make a stall an honest bracket |
| B5 which star | core-star₂ for ν (2,229 points); the three-spindle star with cores if the third shrink finishes in an hour, else on the full fabric | full-fabric stars only | asks on 2,229 points are seconds; on 5,857 they are minutes to half an hour; the ν law is the same either way | medium |
| B6 the flower's centre | x = 35 (pair 1's centre), powers ±1..±K | a centre in two forced pairs (two spindle chords per petal) | 35 is the best-measured centre (F₁, core₁, W⁺ all about it) and the ring chords are ≤ 2 per petal at any centre | high |
| B7 the milestone's number | M55 | reopen M54 | a new question (absorption) with its own theorem | high |
| B8 kernel ν | ν stays an instrument quantity; the identity ν = δ₄ is one sentence in the plan and the tool's docstring | a kernel `deletionNumber` with the identity proved | nothing downstream consumes it yet; the cost is an ℕ∞ layer for a bookkeeping fact | medium — promoted the day a theorem needs it |

## §Bʹ. The domain-modeling pass (2026-09-06, fresh invocation) — what it changed

**The carrier.** `Extends G A k` — the restriction map from `k`-colourings of `G` to `k`-colourings of the
induced subgraph `G[A]` is onto — is the intrinsic object: the compulsions of `G` among `A`'s vertices are
determined by the IMAGE of that map, and "the image is everything" is exactly the boundary case in which
they are `G[A]`'s own. Kept, with the two `iff`s (D1) as its API. Unsampled members checked: `A = ∅` says
`G` is `k`-colourable; `A = univ` is trivial; `k = 0` is consistent (a `0`-colouring exists iff the vertex
type is empty).

**The proof under every sufficient condition is one construction**, so it becomes the kernel's carrier
beneath the instances: the **repaint lemma** — colour the piece with `k` colours, repaint every piece
vertex that clashes across the cut with the spare colour; proper iff the clashing vertices are pairwise
non-adjacent and none touches a spare-coloured neighbour (`Clashes`, `extends_of_repaint`). The hub and
matching statements differ only in HOW the piece's colouring is chosen (a palette permutation putting the
hub's colour on the hub; nothing), so they are instances, ten lines each, and the "which hypothesis is
load-bearing" question has one answer: the independence of the clash set.

**D2 generalizes to many hubs at once.** The m-spindle star has m fused centres, one per copy, and the
copies never touch; iterating a single-hub theorem would pass through nested induced subgraphs (casts on
every step — the ugliness the pass exists to catch). Instead: a hub map `hub : V → V` whose fibres on the
piece are the components (adjacent piece vertices share a hub), each fibre plus its hub `k`-colourable,
one permutation per fibre. `extends_of_hubs` is the theorem; the single hub and the plain matching are
instances. The plain matching is NOT the single-hub theorem at a hub with no piece neighbours in general
(different colourability hypothesis), so it stays a separate instance of the repaint lemma.

**D3 generalizes to a greedy extension order** — the inductive `ExtensionOrder G k A L`: vertices added to
`A` one at a time, each with at most `k` neighbours among `A` and its predecessors (the reverse of a
`(k+1)`-core peeling) — because that, iterated, is what the `core5` instrument claims, and the single
vertex is its instance. The recursor is the induction; each step colours one vertex with a colour its
≤ `k` coloured neighbours miss.

**D4's carrier is the palette-permutation colouring** `symCopy.coloringOfPerm`: any permutation moving
every ring colour colours the symmetric copy; the shift is the instance (`extends_symCopy`). Fusing a
point is the constraint that the permutation fix its colour; a ring point forced to wear that colour
makes it impossible — the spindle, stated in palette language, and the reason the symmetric part of a
copy's attachment can never force. `symCopy` on `V ⊕ V` (no identification) is the right model of ring
chords WITHOUT fusion; fusion is modelled as the constraint, never as a quotient.

**The planted red was wrong and is corrected before it could mislead.** `K₂,₄` is not 2-choosable only
with FOUR colours in play; under a 3-colour palette every size-2 list assignment on it is colourable. The
right red at three colours is `K₃,₃` with lists `{0,1}, {0,2}, {1,2}` on each side (each side needs two
colours, four in all), realized by six pendant attachment vertices coloured `2, 1, 0, 2, 1, 0` — every
piece vertex has exactly one neighbour across the cut and the piece is 2-colourable, so only the
independence hypothesis is violated. Decidable over the piece's 729 colourings.

**ν stays the measurable.** ν = δ₄ is an object invariant, monotone under adding vertices and edges (a
deletion set of a supergraph restricts to one of the subgraph), bracketed a priori by D5, computable by
implicit hitting sets. The number of 5-colourings up to palette is astronomically large on every floppy
object (a dial that reads "∞" until the jackpot); the sweep's models-to-closure count is a property of
the solver's sampling, not of the object. Both are recorded, neither is the dial.

**Seams.** The model of the hub hypotheses is a spec example (`k4MinusEdgeHub`: `K₄ − e` with a path at
hub 2 and a chord to 1, every hypothesis closed by `decide`); the red is `k33Pendants`. Nothing in the
kernel names ν (B8 stands).

## §Bʺ. The obligation-modeling pass (2026-09-06, fresh invocation) — each proof's space, and the prove / test / assume partition

### The kernel piece, obligation by obligation

| obligation | space and decomposition | lines |
|---|---|---|
| `Extends.forces_iff`, `separated_iff` | (→) take a colouring `c` of `G[A]`, extend it to `C`, read `C p = C q`; (←) restrict any `C` by `restrictColoring` (definitional on points) | 2 + 2 each |
| `Extends.not_forces_of_colorable`, `not_separated_of_colorable` | rewrite through the iff, then `not_forces_of_colorable` / `not_separated_of_colorable` (SpareColour) on the induced graph; the adjacency transports by `comap_adj` | 2 each |
| `extends_of_repaint` (the carrier) | glue `f v := if v ∈ A then c v else if clashes v then last else castSucc (φ v)` (classical decidability); properness in FOUR cases, each naming its hypothesis: both in `A` — `c.valid`; both outside — two clashes: the INDEPENDENCE hypothesis; one clash: `castSucc < last`; none: `φ.valid`; across the cut, outside end repainted — the NO-SPARE-NEIGHBOUR hypothesis; not repainted — the clash definition (equal colours would be a clash witness). Restriction by `dif_pos` and subtype eta | ~35 |
| `extends_of_hubs` | the colourability hypothesis is re-indexed by HUB VALUE `x ∈ hub '' Aᶜ` (the pass's one statement change: choice is per fibre, and two piece vertices with the same hub name the same set); classical choice of `ψ x`; the palette swap `Equiv.swap (ψ x x) j` where `j = castPred (c x)` when `c x ≠ last` and a dummy `swap a a = 1` otherwise — one uniform definition; glue `φ b := (σ ∘ ψ) (hub b) b` (adjacent piece vertices share a hub by `hcomp`, so `φ` is proper fibre by fibre); then the repaint lemma with: a hub chord never clashes (`σ ψ b = σ ψ x` would give `ψ b = ψ x` against `ψ`'s validity on the fibre-plus-hub), so every clash is through the unique non-hub neighbour (`hdeg`), whence independence (`hind`) and no spare neighbour (`hdeg` again) | ~60 |
| `extends_of_hub_matching` | `extends_of_hubs` at `hub := fun _ => x`; the fibre set rewrites to `insert x Aᶜ` by `Set.ext` | ~6 |
| `extends_of_matching` | the repaint lemma with `φ` the given colouring; clashes are attached vertices, independent by `hind`; no spare neighbour by `hdeg` | ~8 |
| `exists_notMem_of_encard_le` (private) | `S = univ` would have `encard = k + 1 > k`; so some colour is missing (`Set.encard_univ`, `ENat` arithmetic) | ~6 |
| `extends_of_extensionOrder` | induction on the inductive predicate — the recursor IS the induction and `A` is generalized by the index: `nil` — `A = univ`, restrict/extend trivially; `cons` — from `c` on `G[A]` build `c'` on `G[insert b A]` giving `b` a colour missing from its `≤ k` coloured `A`-neighbours (the private pigeonhole on the image of `c` over `N(b) ∩ A`, transported by `Subtype.val_injective.encard_image`), then the IH extends `c'`; restriction to `A` avoids `b` | ~40 |
| `extends_compl_singleton_of_degree_le` | `ExtensionOrder.cons` with `N(b) ∩ {b}ᶜ = N(b)` and `encard N(b) = degree b` (the M54 calc), then `nil` | ~8 |
| `symCopy.coloringOfPerm` validity | `fromRel_adj` then the four constructor cases: `inl–inl` `c.valid`; `inr–inr` `c.valid` + `π.injective`; `inl–inr` / `inr–inl` the chord condition `a = b ∧ a ∈ S` and `hπ` | ~12 |
| `extends_symCopy` | transport `c'` on the induced first copy to `c` on `G`; `k = n + 2`; `π := finRotate (n+2)`, derangement by `finRotate_succ_apply` and `Fin.ext_iff`/`omega`; `coloringOfPerm`; restriction by proof irrelevance on the subtype | ~15 |
| spec: the hub model | `extends_of_hub_matching` with every hypothesis a finite check over `Fin 6` (`decide`; the fibre colouring explicit if `decide` refuses the subtype quantifier) | ~10 |
| spec: the red | `k33_lists_refuse` by `decide +kernel` over the 729 functions `Fin 6 → Fin 3` (isolated so its cost is measured alone); then from a hypothetical extension `C`: `f i := C i` is proper on `K₃,₃`, hits a forbidden colour, but that colour is `C` of the pendant adjacent to `i` — `C.valid` refutes | ~20 |

**Prove / test / assume.** Prove: everything above. Test: the hub model (non-vacuity of `extends_of_hubs`'s
hypotheses), the red (the independence hypothesis load-bearing), an edge-count `decide` on each spec
graph so a mis-transcribed relation is caught by name. Assume (tool-side, never in the kernel): that a
copy `Rᵢ(U)` is 4-colourable — Theorem B is hand-proved, so the instrument VERIFIES a 4-colouring of
each fibre-plus-hub by SAT and the kernel theorem takes colourability as a hypothesis.

**Mutation audit, registered.** Drop the independence hypothesis → the repaint lemma's two-clash case
fails; drop the no-spare-neighbour hypothesis → the repainted-across-the-cut case fails; drop `hcomp` →
`φ` is not proper across fibres; drop `hdeg` from `extends_of_hubs` → the clash may have a second,
spare-coloured neighbour; `≤ k + 1` in place of `≤ k` in `ExtensionOrder` → the pigeonhole fails;
`1 ≤ k` in place of `2 ≤ k` → `finRotate 1` is the identity. Each is run once at implementation and its
failure recorded in the closing commit.

### The instrument's invariants (what each subcommand asserts, and the test that would catch it lying)

| subcommand | asserts | how it is tested |
|---|---|---|
| `absorb` | for the base `A` and pieces `Bᵢ` with hubs `xᵢ` (from the builder's side labels): each `G[Bᵢ ∪ {xᵢ}]` 4-colourable by a colouring VERIFIED on the induced edges; no edge between different pieces (`hcomp`); every piece vertex has ≤ 1 base neighbour (`hdeg`, the histogram reported); the non-hub-attached piece vertices pairwise non-adjacent (`hind`); verdict "A extends by `extends_of_hubs`" or the list of violating vertices; the D5 bound `ν ≤ ν(A) + #non-hub chords` with `ν(A) = 0` when `A` 4-colours | planted: the K₃,₃-pendants graph → `hind` violated AND the tool's direct extension ask (the red colouring, SAT on the piece with lists) returns UNSAT; the K₄−e hub graph → all hypotheses hold; a copy with one vertex of outside-degree 2 planted → `hdeg` violated at that vertex by name |
| `core5` | the `k`-core by peeling (`k = 5`: remove degree ≤ 4 repeatedly); the peel list REVERSED is an `ExtensionOrder` from the core, re-checked by counting each vertex's neighbours among the core and its predecessors | planted: the seed `H` plus a pendant path → the path peels, `H`'s core is unchanged; a disjoint `K₅` peels entirely (degree 4 ≤ 4: a lone `K₅` is invisible at five colours, which is correct) |
| `nu-ihs` | (i) each solver core `K` (the assumptions `¬dᵥ`, `v ∈ K`, jointly 4-UNSAT) is RE-VERIFIED by a second encoding (the 3-bit `binary3` refutation of `G[K]`) before it enters the hitting-set family — a wrong core would inflate the lower bound, the unsafe direction; (ii) the hitting-set step is EXACT (RC2 on the family: soft `¬dᵥ`, hard "each core hit"; the family is small) — the lower bound is the optimum's size; (iii) at a SAT `S` the 4-colouring of `G − S` is decoded and verified in Python — the upper bound is certified; (iv) exact when lower = upper; the core list and the best `S` checkpointed every iteration; a wall returns the bracket | planted: two disjoint `K₅` at `k = 4` → ν = 2; the seed `H` at `k = 5` → ν = 38 (known exact); `K₅ − e` at `k = 4`… ν = 1 with `C ≠ ∅` |
| `multi-spindle` | each pair at its declared squared distance (mpmath, 60 digits); rotations from `q` (and `ρ^k` for `--power`); unit edges by float prescreen + 60-digit confirmation, near-misses rejected; fusions detected; four-colour refusal and five-colour admission asked directly; sides labelled for `absorb` | `--pairs 35,1859;813,1939 --full` reproduces star₂'s fingerprint `a7d58e7346920d3a`; `--power 1` about 35 on core₁ reproduces W |
| `cross-lattice --depth 2` | the glue census over every non-adjacent pair of `W ∪ P₁` at distance < 2, exact in F₂₄₇; every glue point re-verified at unit distance from both parents; fusions and pool edges exact | run on `W` alone (depth 1) it reproduces `cross-lattice-W-core-8over3.json` |

## §Bʹʹʹ. The experience-modeling pass (2026-09-06, fresh invocation) — the surfaces

### (1) `Absorb.lean` — what a consumer holds, and which direction to reach for

The consumer is a future certificate of a copy union, the descent's halt clauses, or the dial's reader,
holding a goal `¬ Forces G 5 p q` with `p q : V` known to lie in the base `A`. The path they travel:
`Extends.not_forces_of_colorable h hA hp hq hpq`, with `h := extends_of_hubs …` and `hA` the base's
4-colourability — so the two negative corollaries take MEMBERSHIP proofs `(hp : p ∈ A) (hq : q ∈ A)`
(changed from subtype elements by this pass); the two iffs keep the subtype because they mention the
induced graph's vertices. `induce_adj` (definitional, `@[simp]`) is the one normal form every downstream
proof needs, added so no proof opens with the same `comap_adj`/`coe_subtype` preamble (Mathlib has no
`SimpleGraph.induce_adj`; checked). Public: `Extends`, `restrictColoring` (+ its `@[simp]` apply lemma),
`Clashes` (it appears in the carrier's statement), `ExtensionOrder` (consumers build it), `symCopy` and
`symCopy.coloringOfPerm`; private: the free-colour pigeonhole. Names follow `colorable_of_degree_lt`'s
pattern (`extends_of_hubs`, `extends_of_matching`, `extends_of_extensionOrder`, `extends_symCopy`);
`ExtensionOrder.extends` was rejected because `extends` is a keyword. Docstrings state the contract
first ("you hold …; you get …") and the plane instance second. The module doc's table is the API.

### (2) `tools/five_dial.py` — the new subcommands

| subcommand | arguments | headline (population and conditioning in the sentence) | result file |
|---|---|---|---|
| `absorb --graph <stage> [--k 5]` | pieces and hubs INFERRED from the builder's side labels (`meta.names` sides `R{i}`, hub = the base vertex named `("U", pairᵢ[0])`); no other input | `[absorb] <label> k=5: base U (n, 4-colourable ✓ verified); piece R0 (n₀, hub 35): piece∪hub 4-colourable ✓, base-neighbour histogram {0: a, 1: b, 2: c}, cross-piece edges 0, non-hub chords m with e edges among their piece endpoints → absorbed / NOT (reason, vertices); … VERDICT: U extends at 5 colours by Absorb.extends_of_hubs — no compulsion among U's pairs; D5: ν ≤ Σ non-hub chords = s` | `data/m55/absorb-<name>.json`: kind, k, stage header, per-piece records, verdict, theorem, bound, claim_scope |
| `core5 <stage> --k 5` | any stage | `[core5] <label>: 5-core n_core of n (m peeled in r rounds; the reversed peel order re-checked as an ExtensionOrder) — by Absorb.extends_of_extensionOrder the m peeled vertices are invisible at 5 colours` | `data/m55/core-<name>-k5.json`: core, peel order, recheck |
| `nu-ihs <stage> --k 5 --wall W [--max M]` | k, wall, optional cap on |S| | per iteration `[nu] iter i: cores c (all re-verified), min hitting set s, ask SAT/UNSAT`; final EITHER `ν(<label>) = s EXACT (k=5; lower = the exact hitting set of c re-verified cores, upper = a verified 4-colouring of G − S)` OR `ν ∈ [lo, hi] at the wall (lo … , hi …)` — the word EXACT only when both bounds are certified and equal | `data/m55/nu-<name>-k5.json`: lower, upper, exact, cores, S, iterations, seconds, claim_scope; checkpoint `build/m55/nu-ihs-<name>-k5.json` every iteration |
| `multi-spindle --object <L4> --q 64/9 (--pairs "35,1859;813,1939" \| --flower 35,1859 --powers 1,-1,2,-2) [--full] [--dps 60]` | two modes: distinct centres, or one centre with rotation powers; cores looked up (`data/m53/forced-spindle-core-8over3.json`, `build/m54/shrink-<x>-<y>.json`) unless `--full`; a missing core names the `shrink` command to run | `[multi] <label>: n points (n_U in U, copies …, fused f), e unit edges, cross chords {…}, near-misses rejected r; 4-colourable: False (must be); 5-colourable: True` | `data/m55/spindles-<pairs>[-full].json` / `data/m55/flower-<x>_<y>-p<powers>.json` (a `--graph` stage with points and sides) |
| `shrink --object <L4> --pair x,y [--wall]` | the greedy 1-minimal forcing core, checkpointed (exists as a function; exposed) | `[shrink] 1-minimal core of (x, y): n vertices, every vertex necessary` | `build/m55/shrink-<x>-<y>.json` |
| `cross-lattice --depth 2 --exact <witness> --cross <depth-1 json> [--workers]` | the depth-one output | `[cross2] W ∪ P₁ (n): pairs at d < 2 not adjacent: N; in-F₂₄₇ glue points: p (q %); pool P₂: m distinct points, fusions f, … ; grown stage n' points, e edges; total-degree profile of P₁ ∪ P₂: {2: …, 3: …, 4: …, ≥5: …}` | `data/m55/cross-lattice-depth2-<name>.json` and the grown stage `data/m55/W-plus-cross-depth2.json` |

Breakdowns designed: `absorb` on a piece whose piece-plus-hub is NOT 4-colourable says so as a READING
("the piece is itself 5-chromatic; extends_of_hubs does not apply") rather than an error; a stage without
side labels fails naming the missing field; `nu-ihs` at its wall never prints "=" — the bracket carries
which side is certified how; `multi-spindle` refuses a pair not at the declared distance by name. The
jackpot protocol (banner, second encoding, exit 3) stays in `ask`/`sweep`; the new subcommands never
produce a compulsion and say nothing about one.

### (3) `data/m55/README.md`

One bullet per artifact: what the object is, the command that regenerates it, the headline number with its
population, and THE THEOREM IT INSTANTIATES (`Absorb.extends_of_hubs` for an absorb verdict,
`Absorb.extends_of_extensionOrder` for a core, D5 for a ν bracket, `CriticalSet` for a census) — so a
reader can tell a measurement of a theorem from a measurement of the world at a glance.

## §R0. Phase 0 and phase A closed (2026-09-06 ~05:30Z, desktop)

**The kernel module** `Proofs/HadwigerNelson/Absorb.lean`: 21 declarations, zero sorry, elaborates; imported
in `Proofs.lean` after `CriticalSet`; twelve audit entries in `scripts/Axioms.lean` (the gate's build and
axiom receipt run at the close). One statement changed at implementation, at exactly the joint §Bʺ
flagged: `extends_of_hubs`'s colourability hypothesis is `∃ ψ : (G.induce Aᶜ).Coloring (Fin k), ∃ h : V → Fin k,
∀ b ∉ A, G.Adj b (hub b) → ψ b ≠ h (hub b)` — a `k`-colouring of the piece with one designated colour per hub
that the hub's piece-neighbours avoid — rather than "each fibre plus its hub is `k`-colourable". The former
is what the proof uses; the latter implies it by gluing (trivial tool-side, a dependent-type exercise in
Lean that carries no mathematics), and the single-hub instance `extends_of_hub_matching` derives it from
the fibre-plus-hub colouring by `induceHomOfLE`. Everything else landed as the modeling passes specified.

**The mutation audit (registered §Bʺ), all six refused** (`build/m55/mutation-audit.log` from `tools/m55_mutation_audit.py`, scratch copies, 3 s
each): the repaint lemma without independence — refused at the two-clash case; without the no-spare-neighbour
hypothesis — refused at the repainted-across-the-cut case; `extends_of_hubs` without `hcomp` — refused at
`φ`'s properness; without `hdeg` — refused at the spare-neighbour step; `ExtensionOrder` at `≤ k + 1` —
refused at the pigeonhole; `extends_symCopy` at `1 ≤ k` — refused (`omega` cannot derange `Fin 1`). Every
hypothesis is load-bearing.

**The instrument** `tools/absorb_dial.py` (dispatched from `five_dial.py`: `absorb`, `core5`, `nu-exact`
with `--method ladder|ihs`, `multi-spindle --pairs|--flower --powers`, `shrink`, `cross-lattice --depth 2`,
`absorb-self-test`): 13 planted controls green — the K₃,₃-pendants red (not absorbed, `hind` violated on
exactly the nine K₃,₃ edges, the red colouring refused by a direct extension ask), the K₄−e hub green
(absorbed), the outside-degree-2 plant (`hdeg` violated at vertex 5 by name), the K₆-plus-path core (the
path peels, the order re-checked), the lone K₅ (peels entirely at five colours — correct: it is invisible),
ν(K₅ ⊔ K₅) = 2 by both methods, ν(K₅) = 1, ν(K₅ − e) = 1 at four. `build_multi_spindle` gained a rotation
power per spindle (the flower).

## §R1. B1 — the two M54 objects read by the new instruments (2026-09-06 ~05:40Z)

| object | `absorb` at five colours | `core5` |
|---|---|---|
| core-star₂ (2,229; fp `e84485d3b20dc6f6`) | base 1,100 (4-colourable ✓); two pieces (587, 542) with hubs; **every piece vertex has ≤ 1 base neighbour** ({0: 1,116, 1: 13}); 0 piece–piece edges; piece ∪ hubs 4-colourable ✓ (0.1 s); non-hub chords **2 with 0 edges among them** — **ABSORBED: the base extends at five colours by `extends_of_hubs`**; D5: ν ≤ 0 + 2 = 2 | 5-core 2,186 of 2,229 (43 peeled in 3 rounds) |
| star₂ (5,857; fp `a7d58e7346920d3a`) | base 1,953 (4-colourable ✓); pieces 1,952 + 1,952, hubs 31 and 785; {0: 3,885, 1: 19}; 0 piece–piece edges; piece ∪ hubs 4-colourable ✓ (0.2 s); non-hub chords **2 with 0 edges** — **ABSORBED**; D5: ν ≤ 2 | 5-core 5,854 of 5,857 (3 peeled) |

**Reading, and a sharpening the census found.** P-M55-2 MET. And the cross chords are not "a thin conic of
which the spindle chord is one": on both objects every cross chord but ONE per copy is a HUB chord — a
copy point on the unit circle about the centre (the copy's image of a centre neighbour, 5–10 of them);
the single non-hub chord per copy is the spindle chord y–R(y) itself. So the copy hangs on the fabric by
its fused centre and one chord, and the theorem's bound is tight: **ν(core-star₂) = ν(star₂) = 2 exactly**,
the lower bound from M54's C = ∅ (no single deletion 4-colours either object) and the upper from D5 — no
solver run was needed for the exact value; the ladder (B2, in flight) is its confirmation. P-M55-3 MET by
derivation before measurement. The 0 / 0 five-colour readings of M54 §R7 are instances of
`extends_of_hubs` for every pair inside the base; only pairs with a copy-side endpoint were ever a
measurement.

## §R2. B4 — the single-centre flower (2026-09-06 ~06:10–06:30Z)

Petals R^k(core₁ − x), k = ±1, …, ±K, about x = 35 on the 588-core (`multi-spindle --flower 35,1859
--powers …`; rotations ρ^k at 60 digits, near-misses rejected 6 / 18).

| K | object | cross chords | `absorb` at five colours | the centre's deletion ask at four colours |
|---|---|---|---|---|
| 1 | 1,762 points, 8,660 edges (fp `6ed9b47bec37930f`) | U–R 6, U–R⁻¹ 6, R–R⁻¹ 0 | base 588 extends by `extends_of_hubs` (one hub; 5 hub chords + 1 spindle chord per petal; piece ∪ hub 4-colourable); D5: ν ≤ 2 | **flower − x is 4-colourable** (verified colouring, 1 ask): x ∈ C, ν = 1 |
| 2 | 2,936 points, 14,434 edges (fp `eba0475e9adf5fef`) | U–R^{±1} 6, U–R^{±2} 5, **R–R² 1, R⁻¹–R⁻² 1** (the ring chords R(y)–R²(y)), all else 0 | **NOT absorbed by theorem**: the petal union plus the hub REFUSES four colours (69 s; direct check: R ∪ R² ∪ {x} is a rotated copy of W — 1,175 vertices, 5,773 edges, UNSAT) — `hcol` fails; hdeg/hind/hcomp hold (non-hub base chords 2, independent) | **flower − x is 4-colourable** (verified, 1 ask): x ∈ C, ν = 1; by `CriticalSet` a forced-equal pair must lie inside N(x) (300 candidate pairs), a virtual edge must touch N(x) (72,760) — the sweep is the reading (P-M55-9) |
| 3 | 4,110 points, 20,208 edges (fp `9c835c297a4ced54`) | U–R^{±1} 6, U–R^{±2} 5, U–R^{±3} 5; R^k–R^{k+1} exactly 1 for each consecutive pair (four ring chords); all else 0; 30 near-misses rejected | **NOT absorbed by theorem** (`hcol` fails: the petal union plus hub is 5-chromatic — every consecutive petal pair with the hub is a rotated W; direct check UNSAT on all four such pairs and on the union) | **flower − x is 4-colourable** (verified, 1 ask): x ∈ C, ν = 1; candidates confined to N(x) as at K = 2 — the sweep is the reading (P-M55-9) |

**Incident, recorded.** My first reading of the K = 2 and K = 3 verdicts came from a log line I had cut to
300 characters — the `hcol` field and the VERDICT sat beyond the cut — and I wrote both rows as "absorbed".
The recorded JSON said UNSAT / not absorbed all along, and the derivation (§3 D6's own observation that
R ∪ R² with the fused centre and the ring chord is W rotated) says the same; a direct 4-colour ask on every
consecutive petal pair and on the petal union confirmed it before the rows were corrected. Rule kept: never
read a verdict off a truncated headline — the tool's headline carries it whole, the cut was mine.

**Reading.** P-M55-4 MET at K = 1, 2 and 3: the single-centre genre has a critical centre
exactly as the palette-permutation argument (§3 D6) predicts, and the conic coupling between consecutive
petals is a single ring chord — de Grey's genre with our angle is a star folded onto one point. But the
K ≥ 2 flowers are the milestone's first objects the theorem does NOT decide: the petal union plus hub is
itself 5-chromatic (consecutive petals with the fused centre and their ring chord form a rotated W), so
`extends_of_hubs` cannot absorb it, and with C = {x} the localization theorem confines any compulsion to
the centre's unit neighbourhood — a forced-equal pair inside N(x), a virtual edge touching it. **Registered
before the run — P-M55-9: the exhaustive five-colour sweeps of the K = 2 and K = 3 flowers read 0 / 0,
complete** (basis: colour x with the spare colour; every petal and the base are then 4-colourable pieces
joined by single ring and spindle chords, a chain of pieces coloured by palette permutations, so the
colouring space with x spare is huge; colourings with x not spare add more). Falsifier: any hit inside
N(x) — the jackpot protocol. Two
sharpenings the census supplies: (i) the "conic of chords" between a copy and its base is, on this
fabric, the centre's unit neighbourhood plus the spindle chord and nothing else — 5 or 6 hub chords
and one non-hub chord per petal — so at K = 1 D2 applies with the bound ν ≤ 2; (ii) with x critical
the flower is worse than the two-centre star (ν = 1 against ν = 2) at every K. The 5-core drops 60 / 100
vertices (the petals' outer rims). The `critical --only` run asked ONE vertex; the "2,935 non-critical"
in its record is the tool's framing for a caller-supplied theorem and is NOT derived here — only the
centre's verdict is a measurement.

## §R3. B3 — the third pair and the three-spindle star (2026-09-06 ~06:50Z)

| quantity | measured |
|---|---|
| pair 3 = (1205, 1442), the forced pair at 8/3 whose midpoint is farthest (1.98) from the two existing spindles' midpoints among the 163 with endpoints outside F₁ ∪ F₂ | forcing census 1,951 asks, 24 workers, 592 s: **F₃ = {29, 1753, 1899, 1950} ∪ {1205, 1442}**, four of the six inside the 588-core |
| F₃ ∩ (F₁ ∪ F₂) | **{29, 1753}** — NOT disjoint: two of pair 1's five indispensable helpers are pair 3's too (P-M55-5's disjointness half MISSED on the first pair tried; the derivation then bounds C by F₁ ∩ F₃, two vertices) |
| star₃ = U ∪ R₁(U − x₁) ∪ R₂(U − x₂) ∪ R₃(U − x₃) (`multi-spindle --pairs … --full`) | **7,809 points, 55,187 unit edges**; cross chords U–R₁ 8, U–R₂ 11, U–R₃ 11, copy–copy 0; 2 near-misses rejected; refuses four colours, admits five (fp `ffb0ff162cd4c392`) |
| critical set | **∅**: the two candidates 29 and 1753 asked directly at four colours (3,000-s wall) — both NON-critical; every other vertex non-critical by the §R3-M54 derivation (a base vertex is critical only if forcing-critical for every pair; no copy vertex is) |
| `absorb` at five colours | ABSORBED by `extends_of_hubs`: every piece vertex has ≤ 1 base neighbour ({0: 5,826, 1: 30}); 0 piece–piece edges; the three non-hub chords are the three spindle chords, pairwise non-adjacent; piece ∪ hubs 4-colourable (verified) — **no compulsion at five colours among U's 1,953 vertices; D5: ν ≤ 3** |
| 5-core | 7,805 of 7,809 |

**Reading.** A third 5-chromatic unit-distance graph with no critical vertex, reached by two censuses
and two asks; ν ∈ [2, 3] (C = ∅ below, D5 above — the ladder decides, B2). The overlap F₁ ∩ F₃ =
{29, 1753} says the fabric's forcings share helpers: 29 and 1753 are indispensable to two of the three
pairs tried, so "generators = pairs with disjoint forcing-critical sets" is a filter that will reject
some pairs, and the derivation's fallback (ask the intersection) costs one deletion ask per shared
vertex — here two asks of a few minutes each on 7,809 points.

## §R4. B5 — the F₂₄₇ cross lattice one depth further (2026-09-06 ~06:40–07:10Z; the criticality census pending)

Two censuses over W ∪ P₁ (1,238 points: the witness plus its 63-point depth-one pool), every non-adjacent
pair at distance < 2 tested exactly in F₂₄₇ (`cross-lattice --depth 2`, 20 and 12 workers):

| census | pairs tested | in-field glue | new points P₂ | fusions (≥ 3 parents) | grown stage | total-degree profile of the pool P₁ ∪ P₂ |
|---|---|---|---|---|---|---|
| all pairs | 649,158 | 45,861 (**7.07 %**) | 9,303 (55,932 glue points coincide with existing points) | 4,023 | 10,541 points, 69,910 edges; 5-core 8,462 (2,079 peeled in 5 rounds; max degree 53) | **{2: 358, 3: 530, 4: 631, ≥ 5: 7,847}** — 84 % at degree ≥ 5 |
| `--cross-only` (pairs not both on one K-coset side — the plan's intended object; a same-side pair's glue points are that coset's own partner lattice, M50's material) | 345,704 | 2,243 (**0.65 %**; depth one read 0.04 %) | 1,195 (2,468 coincide) | 309 | 2,433 points, 10,632 edges | **{2: 59, 3: 155, 4: 241, ≥ 5: 803}** — 64 % at degree ≥ 5 |

**Reading.** P-M55-6 MISSED in both its sparsity half (0.65 % cross-only against < 0.2 % registered; the
all-pairs 7 % is the K-partner lattice showing through and was never the question) and its degree half
(64 % of the cross-only pool at degree ≥ 5 against ≥ 90 % at ≤ 4 registered) — **the F₂₄₇ thickening is
live in the sense the failure clause named**: depth-two pool points mostly clear the greedy-absorption
floor (D3 peels only the degree ≤ 4 minority), so they are visible at five colours. What remains for
the dial is the first rung: the criticality census of the cross-only grown stage on W's own 1,175
vertices (a pool point can never be critical — deleting it leaves the 5-chromatic W intact), which
says whether the thickening removes W's critical set. Also measured: the depth-two pool is again
lattice-like (309 fusions among 1,195 points — a quarter of the points are reached from two or more
parent pairs).

**§R2, continued (2026-09-06 ~07:40Z) — the sweeps.** The K = 2 flower's exhaustive five-colour sweep
(40 relabelling-seeded models, `--no-amo`): **status done — 0 forced-equal pairs (0 unsettled), 0 virtual
edges (0 unsettled), 46 models, 6 calls, 11 s** (`data/m55/sweep-flower-35_1859-p1_-1_2_-2.json`). P-M55-9
MET at K = 2 — the first object of the milestone that the absorption theorem does NOT decide reads floppy
anyway, as the spare-colour argument on the centre predicted; K = 3 queued behind it.
The K = 3 flower's sweep, the same recipe: **status done — 0 / 0, 47 models, 7 calls, 29.8 s**
(`data/m55/sweep-flower-35_1859-p1_-1_2_-2_3_-3.json`). P-M55-9 MET at K = 3 as well. So the single-centre
genre, at every depth tried, is pairwise floppy at five colours and reads so in seconds — the theorem does not
absorb it, but the localization theorem's C = {x} leaves the sweep only the centre's neighbourhood to
settle, and it settles it by observation alone (forced-equal side) and a handful of batch queries.

**§R4, continued (2026-09-06 ~08:20Z) — the criticality censuses of the grown stages.** A pool point can
never be critical (deleting it leaves the 5-chromatic W intact), so both censuses ask W's 1,175 vertices
only (`critical --only`; the census's "recorded non-critical by the caller's theorem" is exactly that
theorem).

| grown stage | asked | critical | freed relative to W ∪ P₁ (1,172 critical of 1,175) | candidates at five colours |
|---|---|---|---|---|
| cross-only, 2,433 points (fp `ebd913ef61c9f013`) | 1,175, 0 unknown (mean 10.8 s per ask; 937 verified colourings) | **937** | **238 freed — every one on the copy side (R(core₁)), none on the core side** | 0 forced-equal, 0 virtual-edge: C (937 vertices, spread over the copy and the whole core) is coverable by no two unit circles — **the dial reads zero by theorem** |
| all pairs, 10,541 points (fp `5cc40ce1af4f9aa9`) | 169 of 1,175 at the checkpoint (mean 113 s per ask); resumed at 16 workers | **1 of 169 so far** | the K-partner thickening of both cosets makes the 5-chromaticity redundant almost everywhere — the same-side pool is the fabric's own partner lattice, and M54 §R3 measured the same on the full fabric (C = 13 of 3,905) | pending: if C = ∅ the sweep is the reading |

**Reading.** P-M55-6's criticality half: C nonempty (ν = 1) MET on the cross-only stage, but "shrinking
by at most a few" MISSED by two orders (238); and the shrinkage is one-sided. The asymmetry is a
finding to explain, not a number to pass over: the depth-two cross pool gives the COPY's forcing of
(x, R(y)) alternative routes and the CORE's forcing of (x, y) none — the same one-sidedness as M54's
depth-one reading (three copy-side vertices freed, none on the core side), now at scale. Registered as
an open question (T24 at the close): what distinguishes the two K-cosets in the F₂₄₇ pool — the pool
points are glue points of (core, copy) pairs and their descendants, symmetric in the construction, so
the asymmetry must come from the rotation's direction relative to the fabric's own ladder structure
(T13). Incident recorded: I stopped both censuses believing them stalled — their checkpoints were being
written under `data/m54/` (the tool's default DATA dir), not `data/m55/` where I looked; the cross-only
census was one vertex from done. Both resumed from their checkpoints; nothing was lost. The checkpoint
rule (CLAUDE.md, 2026-08-26) paid for itself twice in one hour.

## §R5. Close (2026-09-06 ~09:30Z; the star₂ sweep, the full-pool census and the third core's shrink in flight)

### Predictions scored

| # | registered | outcome |
|---|---|---|
| P-M55-1 | star₂'s sweep reads 0 / 0 complete | **MET** (landed after the close, §R6): 0 / 0 complete, 138 models, 98 calls, 16,752 s |
| P-M55-2 | both M54 objects absorbed by `extends_of_hubs` | **MET, sharpened**: every cross chord but ONE per copy is a hub chord (the copy's image of the centre's neighbourhood); the one non-hub chord is the spindle chord |
| P-M55-3 | ν(core-star₂) = 2, ν(star₂) = 2 | **MET by derivation** (D5's ν ≤ 2 from the census, ν ≥ 2 from M54's C = ∅) — the ladder was to confirm it and could not (§ Incidents) |
| P-M55-4 | flower − x 4-colourable at K = 1, 2, 3 | **MET** at all three (one verified colouring each) |
| P-M55-5 | the three-spindle star: F's pairwise disjoint, C = ∅, ν = 3 | disjointness **MISSED** on the first pair tried (F₃ ∩ F₁ = {29, 1753}); C = ∅ **MET** by the two asks the derivation left; ν ∈ [2, 3] **UNDECIDED** (the ladder is infeasible at 7,809 points on this evidence) |
| P-M55-6 | depth-two pool < 0.2 % of pairs; ≥ 90 % at degree ≤ 4; the 5-core drops ≥ 90 % of the pool; C nonempty, shrinking by a few | sparsity **MISSED** (0.65 % cross-only; 7 % all pairs, the K-partner lattice showing through); degree **MISSED** (64 % of the cross-only pool at ≥ 5); the 5-core clause **MISSED** (the cross-only stage's 5-core is 1,756 of 2,433 — about half the pool peels, not 90 %); C nonempty **MET**, "by a few" **MISSED** by two orders (238, all copy-side) |
| P-M55-7 | the kernel specs elaborate first try after the passes | **MISSED in letter** (three elaboration rounds: a name resolving to the theorem under construction, `induceHomOfLE`'s explicit graph argument, two motive-failing rewrites, the decide-shaped specs' argument order; then one simp attribute the linter refused), **MET in substance** (no statement changed except `hcol`'s form, and that at the joint §Bʺ flagged) |
| P-M55-8 | no compulsion anywhere | **MET** — 0 / 0 complete on core-star₂ (M54), on the K = 2 and K = 3 flowers; star₂'s forced-equal side; every other object by theorem |
| P-M55-9 | the K = 2, 3 flowers' sweeps read 0 / 0 | **MET** (11 s and 30 s, complete) |

### What landed, in one table

| deliverable | state |
|---|---|
| `Absorb.lean` | 21 declarations, zero sorry, standard three axioms (578 clean in the audit); the six-mutation audit all refused |
| `tools/absorb_dial.py` + `five_dial.py` hooks | `absorb`, `core5`, `nu-exact` (ladder / ihs), `multi-spindle --pairs / --flower --powers`, `shrink`, `cross-lattice --depth 2 [--cross-only]`, `absorb-self-test` (13 controls); the walled SAT helper made real |
| objects | the three-spindle star (7,809, C = ∅); the flowers K = 1, 2, 3 (1,762 / 2,936 / 4,110; centre critical); the cross-only depth-two grown witness (2,433; C = 937 of W's 1,175) and the full-pool one (10,541) |
| readings | every star absorbed by theorem (ν = number of spindles as an upper bound, = 2 exactly at two spindles); the K ≥ 2 flowers NOT absorbed and floppy anyway in seconds; the F₂₄₇ thickening moves the critical set one-sidedly (T24) |

### Incidents (each caught by a control or a derivation; none moved a result)

1. **The truncated headline** (§R2): two flower verdicts read off a 300-character cut of a log line; the
   JSON and a direct ask said the opposite; corrected before any downstream use.
2. **Censuses stopped as "stalled"** (§R4): their checkpoints lived under `data/m54/` (the tool's default),
   not `data/m55/` where I looked; one was a vertex from done. Both resumed; nothing lost.
3. **The inert wall.** `five_dial.sat`'s Timer-based wall never worked: pysat's `interrupt()` does not stop
   cadical153 (measured: a 2-s timer never returned; when the ν ladder's rung-1 ask reached 1,800 s the
   timer thread raised and the solve ran on unbounded). Audit: no recorded ask of M54 or M55 ever reached
   its wall (maximum 213 s against walls ≥ 600 s), so every "0 unknown at wall" verdict stands as a
   verdict, but the guard was fiction. Fixed: walled asks now run the toolchain's cadical in a subprocess
   with a real timeout (`forcer._solve`, the Rigidity engine's route); a hard ask returns `unknown` at its
   wall to the second, and the planted K₅ − e control is green.
4. **The ν ladder** could not confirm ν = 2 on core-star₂ within its walls: the rung s = 0 refused in
   55 s and 60 s (two encodings), the rung s = 1 — the whole criticality census as ONE cardinality-
   constrained ask — exceeded 30 min per encoding. ν there is exact by theorem + census, not by the
   instrument; the ladder is reported as unfit at this size, the hitting-set method untested beyond its
   controls (an open end).
5. **A self-matching `pkill -f`** (the standing trap, CLAUDE.md memory) killed my shell once; the intended
   process died too, and the ledger records it.

### Open ends (not run, or run to a wall)

* star₂'s five-colour sweep (chain 4), virtual-edge side; the full-pool grown stage's census
  (1 critical of the first 389 asked, and that one is the fused CENTRE — the single-centre corollary once more;
  C = {x} is the likely reading, ν = 1, and the theorem then confines any compulsion to N(x)); the third core's shrink (650 of 1,951 at the close) and the three-core star.
* ν exact on the three-spindle star (bracket [2, 3]); the ν = number-of-spindles law as a theorem (a
  derivation from disjoint forcing-critical sets and the one-chord attachment is the natural next kernel
  piece); the IHS engine on a real object.
* T24: the copy-side asymmetry of the F₂₄₇ thickening.
* Absorb.lean's plane instance (a copy union as a `Copy.copyUnion` satisfying `extends_of_hubs`'s
  hypotheses from the census data) — the certificate shape for "this star carries no compulsion",
  unpriced.

### The gate

`./scripts/build.sh` OK; `scripts/axioms.sh` OK (578 clean, 5 declared purchases); `lake lint` PASSED on the
third run — the first refused a redundant `@[simp]` on `induce_adj` (simp reaches it through `comap_adj`;
attribute removed), the second an auto-named decidability instance with an underscore (named
`decidablePredMemHubPiece`). Every check's red was seen on the way to its green.

## §R6. Addenda after the close (2026-09-06, 10:15Z onward)

* **The third core.** The greedy 1-minimal forcing core of (1205, 1442) on U: **587 vertices, 2,881 unit
  edges, every vertex's necessity witnessed** (4,346 s, sequential; `build/m55/shrink-1205-1442.json`).
  Three cores of 588 / 543 / 587 for three pairs at the same distance — the forcing cores are the same size
  to within 8 %. The three-core star is launched: its critical set is bounded by the TRIPLE intersection of
  the 1-minimal cores with no asks (a base vertex is critical only if its deletion breaks every spindle's
  forcing, and a core's vertex breaks only its own), and it is the first real object for the hitting-set ν
  engine (`nu-exact --method ihs`) — P-M55-5's ν question, if the engine finishes.
* **The full-pool census** kept writing to its checkpoint after I moved the file (an open append handle
  follows a rename on one filesystem); 981 of 1,175 verdicts at this note, **2 critical: the fused centre
  (index 12) and one more (565)**. If the run dies before finishing, move the checkpoint back under
  `data/m54/` before resuming.
* **The full-pool grown witness's critical set, complete** (1,175 asks, mean 113 s, 0 unknown;
  `data/m55/critical-W-plus-cross-depth2.json`): **C = {12, 565, 1152} — three vertices, the fused centre and
  two of its neighbours, pairwise adjacent** (degrees 54, 49, 49), of 10,541. The K-partner thickening of both
  cosets makes the witness's 5-chromaticity redundant everywhere except at one unit triangle through the
  centre. The localization theorem then admits **0 forced-equal candidates and 108 virtual-edge candidates**
  (non-adjacent pairs whose neighbourhoods cover the triangle). **Registered before the run — P-M55-10: all
  108 asks are refuted (0 hits)**; basis: the object is the witness's two cosets thickened by their own
  K-partner lattices plus the cross pool, and every earlier reading of this kind (M54 §R2, §R3) was zero;
  falsifier: any hit — the jackpot protocol.
* **The three-core star** (cores 588 / 543 / 587, pairwise overlaps 31 / 220 / 98, triple intersection 16):
  **3,100 points, 17,402 unit edges** (fp `c19235b55e35b1e5`); ABSORBED by `extends_of_hubs` (base 1,385,
  4-colourable; three pieces with hubs; base-neighbour histogram {0: 1,692, 1: 23}); **C = ∅** (the 16 triple-
  intersection vertices asked at four colours, 0 unknown; every other vertex non-critical by the cores'
  1-minimality) — the fourth 5-chromatic unit-distance graph with no critical vertex; ν ∈ [2, 3]. The
  hitting-set ν engine's first real run: solver cores of ~1,960 vertices, the hitting set a singleton
  refuted one vertex per iteration (~65 s each) — the cores overlap in a large common set, so the lower
  bound climbs only when that set empties; reported at its wall as a bracket.
* **The hitting-set ν engine on the three-core star, to its wall**: 196 iterations in 3,601 s, every solver
  core ≈ 1,950 of the 3,100 vertices (re-verified each time), the exact hitting set a singleton throughout
  — the cores' common intersection never emptied — so the instrument returns only ν ≥ 1, below what the
  theorem and the census already give (ν ∈ [2, 3]). Both ν engines are unfit on objects of this size:
  the ladder's rung s = 1 is one intractable ask, the hitting-set loop needs cores far smaller than the
  5-chromatic subgraphs the solver returns. A ν instrument for these objects needs either core
  minimization (each shrink a deletion ask) or the structural route — the ν = number-of-spindles law as a
  theorem (T25). `data/m55/nu-spindles-35_1859-813_1939-1205_1442-k5.json`.
* **star₂'s sweep landed** (2026-09-06 ~08:15Z): **0 forced-equal, 0 virtual edges, complete — 138 models, 98
  calls, 16,752 s** (`data/m54/sweep-spindles-35_1859-813_1939-full.json`). P-M55-1 MET; M54 §R4's
  registration MET; the addendum written into `plans/M54-five-colour-dial.md` §R7.

* **The 108 asks, DONE (2026-09-07 00:22 UTC, 85,651 s; `data/m55/ask-W-plus-cross-depth2-k5.json`).** On the full-pool grown
  witness (10,541 points, 69,910 edges; critical set a triangle through the centre) the theorem-admitted candidates at five
  colours were 0 forced-equal and 108 virtual-edge pairs. Result: **0 HIT, 22 refuted by verified separating colourings, 86
  UNDECIDED at the 900-s wall.** P-M55-10 ("0 hits") is met on the 22 decided candidates and undecided on 86 — the population
  in the headline, as G21 requires; no jackpot. The input `data/m54/critical-W-plus-cross-depth2.json` now lives in `data/m55/`.
