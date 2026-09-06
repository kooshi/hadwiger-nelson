# M54 — the five-colour dial (STUB + SUBPLAN, 2026-09-05; §1–§9 the stub, §B onward the subplan)

*Minted 2026-09-05 on Kooshi's "You are go for the 5 dial milestone", the day the field-wall
conjecture became a theorem (`plans/FIELD-WALL-THEOREM.md`) and the same day's session minted the
first 5-chromatic unit-distance graphs in ℚ(√3, √11, √247) (T20). Written to the stub rule's standard:
everything the deciding session knew, in plain language, so a session with zero conversation memory
can subplan it with all meaning intact. Read beside this: `plans/FIELD-WALL-SESSION-HANDOFF.md`
(the findings, tools and open ends this milestone starts from; §3(a) and §5 item 1 are its
mandate), `plans/STANDING-QUESTIONS.md` T17–T21 and Q10, `plans/M53-iteration-5.md` §R5 (the halt
record), `CLAUDE.md` § Grokkings G9, G19, G25, G26, G32, G37, G38.*

## 1. Mission context, in plain language

The project hunts new mathematics about the plane's chromatic number; the kernel holds
5 ≤ χ(ℝ²) ≤ 7. The reduction everyone states — and the kernel holds as a theorem
(`OneDefect.lean`, the spindle theorem) — is: **if some finite unit-distance graph forces two of its
points to share a colour in every proper 5-colouring, then χ(ℝ²) ≥ 6**, because rotating the graph
about one endpoint until the other endpoint's two positions are a unit apart produces a graph with no
proper 5-colouring. Such a pair is a *forced-equal pair at five colours*; its cousin, a pair forced
DISTINCT in every 5-colouring while not adjacent, is a *virtual edge at five colours*, and by
`HexShell.six_le_chromaticNumber_plane_of_forced_pairs` one virtual edge at distance √3 plus one at
distance 2 also give χ(ℝ²) ≥ 6. Together these are the *pair compulsions at five colours*, and the
whole 6-hunt is the hunt for one.

Nobody has one. Every 5-chromatic unit-distance graph ever examined — de Grey's 1,581, Heule's
510/553, and now our own — is *pairwise floppy* at five colours: zero forced-equal pairs, zero
virtual edges, settled by complete sweeps (G9, M30; G31, M48; T21, 2026-09-05). At FOUR colours the
seam-field fabric grown by the descent is *rigid*: 163 of its 178 pairs at distance 8/3 are forced
equal in every 4-colouring (the rigidity dial, Q10), and that rigidity was spent to mint the new
witnesses. The **five-colour dial** is the same instrument one level up: the complete forced-equal
and virtual-edge sweep at five colours on 5-chromatic material, read against growth, with the first
nonzero reading being χ(ℝ²) ≥ 6 by a kernel theorem. The handoff's ranked recommendation
(`FIELD-WALL-SESSION-HANDOFF.md` §5 item 1): grow the new witness in its own field
ℚ(√3, √11, √247) and watch the dial.

**What this milestone adds before any instrument runs (derived 2026-09-05 at minting, §3 below): a
theorem that says WHERE on any 5-chromatic graph a pair compulsion can live, which explains the zero
measured on the witness without a solver, and which fixes the first rung the dial must climb.** The
milestone is therefore three things in order: the theorem in the kernel (an afternoon, no compute);
the calibrated sub-dials it names (cheap censuses); and the growth census plus the sweep (the
compute), with predictions registered first (G30).

## 2. The objects

| name | what it is | where |
|---|---|---|
| **U** | the it-4 object's unit part: 1,953 K-points (K = ℚ(√3, √11)), 13,796 unit edges, 4-chromatic, 4-rigid at 2-adic valuation 6 (163/178 pairs at 8/3, 8/11 at 8/√3 forced equal) | exact coordinates `data/m52/exact-<L4>.json`; label L4 = `S29-depth2r-it2v2-depth1-it2v2-depth1-vdel28-it2v2-depth1`; the dial `data/m53/rigidity-dial-it4.json` |
| **core** | the 588-vertex 1-minimal sub-object of U forcing the pair (35, 1859) at distance 8/3 equal at four colours; 2,886 unit edges | `data/m53/forced-spindle-core-8over3.json` (`core_vertices`) |
| **W** | core ∪ R(core), R the rotation about point 35 with cos θ = 119/128, sin θ = 3√247/128 (so that 1859 and R(1859) are a unit apart): **1,175 points, 5,773 unit edges, 6 cross chords, the centre fused; 5-chromatic (direct 4-refusal), 5-colourable; lives in F₂₄₇ = ℚ(√3, √11, √247)**; chords verified at 60 digits, NOT yet in exact arithmetic | the same record; rebuilt by `tools/witness_cheats.py`'s recipe |
| **W⁺** | U ∪ R(U), the same rotation on the whole unit part: 3,905 points, 27,593 edges, 8 cross chords | `data/m53/forced-spindle-full.json` |
| **H** | the Exoo–Ismailescu seed as a {1, 2}-graph: 214 points, 1,004 unit edges, 446 distance-2 edges; forces (205, 206) at distance 5 equal in every 5-colouring (35 colourings up to palette); the calibration bed | `tools/batchkill.Obj()` |
| the forced-pair inventory | the 171 four-colour forced pairs of U by class (163 at 64/9, 8 at 64/3); **every vertex of U lies in at most TWO forced pairs and point 35 in exactly one** (counted at minting), so every spindle about a distinct centre is a distinct copy | `data/m53/rigidity-dial-it4.json` |

Every K-point sub-object is 4-colourable by the residue colouring (Theorem B); W is two isometric
copies of K-fabric (U and R(U) — R(U) is a K-plane rotated by ρ = (119 + 3i√247)/128, which is NOT in
K(i)) coupled by the fused centre and six chords. Its 5-colourings restrict on each side to
5-colourings of 4-colourable fabric, which have a spare colour.

## 3. What is derived before any instrument runs (2026-09-05, at minting)

### D1 — the critical-set localization theorem (kernel target, §4 phase 0)

Let χ(G) = k + 1 and let **C(G) = {v : G − v is k-colourable}** be the *critical set* (deleting v's
edges leaves a k-colourable graph). Then:

* **Forced-equal.** If (p, q), p ≠ q, is forced equal at k + 1 colours, then **C(G) ⊆ N(p) ∩ N(q)**
  — every critical vertex is a common neighbour of p and q, and p, q themselves are not critical.
  *Proof.* Take c ∈ C(G) with c ≁ p and c ≠ q. The set S = {p, c} is independent; G − S is a subgraph
  of G − c, so it has a proper k-colouring; paint S with the spare colour k. This is a proper
  (k+1)-colouring of G in which p wears colour k and q (∉ S) does not — p and q are separated. So
  every c ∈ C(G) ∖ {q} is adjacent to p; and c = p is the case S = {p}, which also separates. By
  symmetry every c ∈ C(G) ∖ {p} is adjacent to q. ∎
* **Virtual edge.** If (p, q), p ≁ q, is forced distinct at k + 1 colours, then
  **C(G) ⊆ N(p) ∪ N(q)** and p, q ∉ C(G). *Proof.* c ∈ C(G) non-adjacent to both: S = {p, q, c} is
  independent, colour it k over a k-colouring of G − S ⊆ G − c: p and q agree. ∎
* **The spare-colour lemma is the special case C(G) = V** (a k-colourable graph has every vertex
  critical, and V ⊆ N(p) ∩ N(q) is impossible since p ∉ N(p)) — `SpareColour.lean` re-derived.
* **In the plane.** Two distinct points have at most two common unit neighbours (the glue point and
  its mirror, `PartnerLattice.eq_gluePoint_of_unit_pair`), and none when their distance exceeds 2.
  So **a finite unit-distance graph forcing a pair equal at χ(G) colours has at most two critical
  vertices, and none at all if the pair is more than 2 apart.** For a virtual edge, every critical
  vertex is a unit neighbour of an endpoint: |C(G)| ≤ deg p + deg q.

*Consequences read off at once.* (i) The witness W is a single spindle built on a 1-minimal core:
deleting almost any vertex 4-colours it, so |C(W)| is in the hundreds against a maximum degree of a
few dozen, and **T21's zero (0 forced-equal, 0 virtual edges at five colours on W and on W plus its
850 distance-2 cheats) is an instance of D1, not a finding**. (ii) Any object with ONE fused spindle
centre x has x ∈ C(G) (delete x and every spindle chord loses its forcing), so its five-colour pair
compulsions, if any, live inside N(x) × N(x): **single-centre unions (W, W⁺, and W plus any halo of
degree-2 points) are dead for the dial by theorem**, save for pairs among the centre's own
neighbours. (iii) The first rung of the dial is therefore **redundancy**: |C(G)| must fall to ≤ 2
(forced-equal at distance ≤ 2) or to 0 (distance > 2) before any forced-equal pair is possible, and
to ≤ 2Δ before any virtual edge. |C(G)| is a sub-dial that costs one 4-colour ask per vertex and is
readable on every object below. (iv) On the calibration bed: H forces (205, 206) at distance 5 in
the {1, 2}-graph, whose common neighbours are points within distance 2 of both — none, since
2 + 2 < 5 — so **the theorem predicts C(H) = ∅: every single-vertex deletion of the Exoo–Ismailescu
seed still refuses four colours.** That is P-M54-1, the theorem's calibration, and a wrong proof
fails it in seconds.

### D2 — the absorption principle (a reading with a derivation behind it; falsified at one point in §4 phase C)

A 4-colourable piece P attached to the rest by chords each of whose P-endpoints has ONE neighbour
outside P is *absorbed* at five colours: given any 5-colouring of the rest, colour P by its residue
4-colouring under an injection of its four classes into the five colours, and recolour each chord
endpoint in conflict with a colour free among its ≤ 3 residue-neighbour classes, its one outside
neighbour, and its recoloured neighbours — always possible when the conflict set is independent, which
a choice among the 24 injections makes generic. So **rotated copies of K-fabric never create
five-colour rigidity on the base**: by the quadrature law (G12) a copy couples to the base along one
conic of chords, thin by law, each endpoint of degree one across the interface. This is M52's P5
(a ρ₁₅ copy kills 0 of 15,218 classes) read as a principle, and it predicts that multi-spindle unions
U ∪ R₁U ∪ R₂U ∪ … — however small their critical set becomes (D1 is satisfied by redundancy) — read
zero on the dial. What defeats absorption is a vertex with ≥ 2 neighbours in different pieces whose
colours are rigid: the depth-one glue points of CROSS pairs (one endpoint in U, one in R(U)) have
exactly that shape by construction, and they are the material this milestone measures.

### D3 — the field F₂₄₇ and the cross glue points

For p ∈ K², q ∈ R(K²): |p − q|² = A + B√247 with A, B ∈ K (B ≠ 0 generically), and the glue point of
p, q lies in F₂₄₇ iff the radicand r = 4/d² − 1 is a square in F₂₄₇ — decided exactly by the tower
criterion one level up (x = a + b√247 is a square in K(√247) iff a² − 247b² = n² in K with (a ± n)/2 a
square in K), the same `sqrt_ext` recursion `tools/pool_field_restrict.py` runs for K. In F₂₄₇(i) the
prime above 2 splits (247 ≡ 7 mod 8, so √247 = i√(−247) ∈ ℚ₂(i)) and complex conjugation swaps the two
factors: no conjugation-fixed prime, no residue colouring — the wall is broken, as Theorem B requires
of any 5-forcer's field. The rotation ρ has valuation ±6 at the two primes (119² + 9·247 = 2¹⁴) — the
forced distance's own 2-adic valuation, resurfacing in the angle. Same-side pairs whose radicand
lies in 247·K*² also produce F₂₄₇-points outside both K-planes; T18's census lists the radicand
classes of U's pairs and the class of 247 is read off it in phase D.

### D4 — what D1 says about the shape of any 6-forcer

A 6-forcer built as "5-rigid fabric plus one spindle" needs fabric G with a forced-equal pair at five
colours; by D1 that fabric has at most two critical vertices — **its 5-chromaticity must survive the
deletion of any single vertex (any vertex but the pair's two glue points)**. No known 5-chromatic
unit-distance graph is within a factor of ten of that: de Grey's 1,581 is at or near edge-critical
(G10), Heule's are shrunk to criticality, W is a single spindle. The dial's first rung is not
rigidity but redundancy, and the cheapest instrument for it is the criticality census. This is the
structural reason the "one gadget" reduction (G26/G32) relocates rather than shrinks the problem, made
quantitative.

## 4. The order of work

| phase | what | cost (desktop; anchors in §8) | acceptance |
|---|---|---|---|
| **0 — the kernel piece** | `Proofs/HadwigerNelson/CriticalSet.lean`: `CriticalSet`, the isolating-set lemma, the two localization theorems, the spare-colour corollary as a spec example, the plane corollaries (≤ 2 critical vertices; none beyond distance 2), the cardinality corollary; names probed; standard three axioms | an afternoon; no compute | `lake env lean` green, zero sorry, axioms audited via `scripts/build.sh` in the closing batch |
| **A — exact geometry of W** | the generic quadratic-extension class over K (`KExt(m)`: A + √m·B, A, B ∈ K) with m = 247; W's 1,175 points exactly (core from `exact-<L4>.json`, copies by the exact rotation); every unit edge and every cross chord verified as an exact identity; the 60-digit near-miss list re-confirmed non-unit exactly — upgrades T20 from 60 digits to exact | minutes | 5,773/5,773 exact; the record `data/m54/witness-exact-8over3.json` |
| **B — calibration** | (B1) C(H) on the E–I seed: 214 deletion asks at four colours (P-M54-1); (B2) ν(H) = the fewest fifth-colour vertices of any proper 5-colouring (RC2 MaxSAT: hard = proper 5-colouring of H, soft = "v is not colour 4"); (B3) the sweep's planted red/green: W plus the closed hexagonal shell's nine {√3, 2} pairs as cheats minus two disjoint ones — K₇ minus a 2-matching is 5-chromatic and forces BOTH missing pairs equal — must read exactly those two forced-equal pairs at five colours | seconds to minutes | P-M54-1 scored; the planted pairs found and nothing else |
| **C — the sub-dials on the objects we hold** | C(W), Δ(W), ν(W) (P-M54-2); C(W⁺) (3,905 asks; optional if the anchor prices it above an hour); the k = 4 forced-equal dial on the 588-core itself (does the core force any second pair?); then **the two-spindle union** — core ∪ R₁(core) ∪ (a second forced pair's spindle), the smallest object with two centres — C, ν, and the five-colour sweep: the one-point falsifier of D2 (P-M54-4) | census ≈ n × (one ask) / 28 workers; the sweep by the anchor of T21 (858 s on 2,025 vertices) | verdicts recorded with their populations |
| **D — the F₂₄₇ depth-one census** | every cross pair (p ∈ core, q ∈ R(core)) at distance < 2: r = 4/d² − 1 exact in F₂₄₇, squareness exact; the glue points in F₂₄₇; fusions (points with ≥ 3 W-neighbours — the strong rung); pool–pool unit edges (60-digit screen, exact confirm); same-side pairs with radicand in 247·K*² (from T18's table); the radicand-class table for the cross pairs (P-M54-5) | ≈ 3.4 × 10⁵ pairs × one exact square test; parallel | `data/m54/cross-lattice-8over3.json` with counts, classes, the pool's exact coordinates |
| **E — the dial** | W ∪ (strong rung), then W ∪ (whole cross pool if ≤ ~5,000 points): the criticality census first (does |C| fall?), then the complete five-colour sweep (`rigidity.Rigidity(n, E, 5)`), forced-equal AND virtual edges, with the √3 and distance-2 classes reported separately (the 6-hunt's needs, G26 sharpened) | one heavy job; checkpoint per Rigidity phase | P-M54-6 scored; any nonzero ⟹ HALT AND VERIFY |
| **close** | Frontier (M54 paragraph, ledger row 48, paths forward), Grokkings (G39: redundancy before rigidity), STANDING-QUESTIONS (T22–T24), the handoff's §5 item 1 pointed here, `data/m54/README.md`, memory | — | committed |

Phases 0, A and B are independent and may interleave; C needs A (the exact W) only for the record,
not for the SAT asks (the 60-digit edge list is the same graph, and the record says so); D needs A;
E needs D.

## 5. Registered predictions (scored at the close; G30: derived first where a derivation exists)

| # | prediction | provenance | falsifier |
|---|---|---|---|
| P-M54-1 | **C(H) = ∅**: every single-vertex deletion of the E–I {1,2}-seed still refuses four colours | D1, a theorem | one 4-colourable H − v ⟹ D1's proof is wrong; the kernel piece halts until repaired |
| P-M54-2 | \|C(W)\| > Δ(W) (in fact > 500 of 1,175), and ν(W) = 1 | W is one spindle on a 1-minimal core | \|C(W)\| ≤ Δ(W) |
| P-M54-3 | the 588-core forces NO second pair equal at four colours (it is 1-minimal for one pair and the other 8/3 pairs' cores need vertices it dropped) | reading | a second forced pair inside the core (then the two-spindle union is built from the core alone, and is cheaper) |
| P-M54-4 | the two-spindle union has \|C\| < \|C(W)\| (redundancy works) and reads **0 forced-equal, 0 virtual edges** at five colours (absorption) | D1 + D2 | any compulsion ⟹ D2 is wrong AND the jackpot clause fires |
| P-M54-5 | the F₂₄₇ cross lattice is SPARSE: < 2 % of cross pairs at distance < 2 have in-field glue points, 0 fusions, pool–pool unit-edge density < 1 per point | D3 + the quadrature/stacking laws (cross material has no translation channel) | a lattice-like cross pool — the milestone's real structural find if it happens |
| P-M54-6 | W ∪ (cross pool) reads 0 forced-equal, 0 virtual edges at five colours; \|C\| stays > Δ | D1 (degree-2 halo points cannot remove a critical vertex: colour them last) | any compulsion ⟹ HALT AND VERIFY |
| P-M54-7 | ν(H) ≥ 10 (the seed's 5-colourings pay for their rigidity with many fifth-colour vertices) | reading, low confidence | ν(H) < 10 |

## 6. Failure and jackpot clauses (registered before any instrument runs)

* **Jackpot (never softened):** any confirmed forced-equal pair or virtual edge at five colours on any
  unit-distance object ⟹ HALT, re-ask in a second encoding, verify the geometry exactly, then the
  spindle: χ(ℝ²) ≥ 6 candidate. Nothing else runs until it is confirmed or refuted.
* **F1:** P-M54-1 fails ⟹ D1 is wrong; the kernel piece is where the error surfaces; no census is
  read as anything until D1 is repaired.
* **F2:** the cross lattice is EMPTY at depth one (0 in-field glue points) ⟹ phase E has no material;
  record the zero with its population; the next material is depth two of the cross lattice or the
  glue lattice between copies at unit-separated centres (G14's translation channel), priced in the
  close, not run.
* **F3 (cost):** any census priced above four hours on 28 workers is restricted to a named subset
  (the strong rung, the centre's neighbourhood) and the restriction is in the headline (G21).
* **Unknowns are never folded into verdicts**; the Rigidity engine's `unsettled` lists are reported
  as such.

## 7. Instruments to build (one file, `tools/five_dial.py`; every subcommand with a self-test or planted control seen red before its first real run)

| subcommand | does | control |
|---|---|---|
| `exact-witness` | phase A: `KExt` arithmetic, exact W, exact edge verification, the record | a planted moved point shows as a failed identity |
| `critical` | the criticality census C(G) at k, in parallel; Δ; the D1 verdicts (\|C\| vs Δ, 2Δ; the localization sets); the candidate pairs when \|C\| ≤ 2 | the E–I seed (P-M54-1) is the calibration; a planted K₅ minus an edge has C = the two non-adjacent vertices |
| `nu` | ν(G) by RC2 MaxSAT with a wall; reports the bound found and whether it is optimal | ν(K₆ at five colours) = 1; ν(K₆ ∪ K₆ disjoint) = 2 |
| `planted-sweep` | phase B3: the K₇-minus-matching control on W at five colours | must find exactly the two planted pairs |
| `two-spindle` | phase C: build the second spindle (core or U), the union, its C, ν, and sweep | the single-spindle object reproduces T21's zero |
| `cross-lattice` | phase D: the exact F₂₄₇ census | planted: a K-pair with an in-field radicand classifies as in-field; a cross pair with a non-square radicand refuses; `sqrt_ext` at m = 247 verified by squaring on every root |
| `dial` | phase E: W ∪ pool subsets, C then the sweep, checkpointed | the planted-sweep control re-run on the composed object |

## 8. Cost anchors (desktop, 32 cores, 125 GB; measured at minting, populations named)

| ask (population) | measured | consequence for the phase |
|---|---|---|
| H (214 points, 1,004 + 446 edges): refuse 4 / admit 5 / one deletion at 4 | 0.02 s / 0.01 s / 0.02 s | B1 is seconds for all 214 |
| W (1,175 points, 5,773 edges, Δ = 26, mean degree 9.8): the direct 4-refusal | 29 s | an UNSAT deletion ask (a NON-critical vertex) costs ~30 s |
| W − v at four colours, v ∈ {0, 1, 300, 700, 1100}: all 4-colourable | 0.18–0.58 s | a SAT deletion ask (a critical vertex) costs < 1 s; C(W) at 1,175 asks ≈ 10 min serial if most are critical, ≈ 30 s per non-critical vertex |
| the five-colour sweep on W + 850 cheats (2,025 vertices; T21) | 858 s, 81 calls | phase E on W ∪ a pool of ≤ 5,000 points: hours, one heavy job, checkpointed |

W's fused centre (35) has degree 10 in W, index 0 of the union has degree 10 too; the maximum degree
26 sits on the core's interior. Every number is desktop wall-clock for one pysat/cadical153 process.

## 9. Discipline

One heavy job at a time; every phase over 15 minutes checkpoints per verdict and resumes exactly;
HALT on any unexplained process crash; never `lake build`, only `./scripts/build.sh`; a headline
carries its population and its conditioning; predictions scored as met / missed / refuted with the
measurement, never rescoped.

---

## §B. Decisions settled at subplanning (2026-09-05, before the modeling passes)

| decision | choice | alternative weighed | why | confidence |
|---|---|---|---|---|
| B1 the milestone's spine | the theorem first (D1 in the kernel), then calibrated sub-dials, then the growth census and the sweep | run the handoff's programme directly (build F₂₄₇, grow, sweep) | D1 says single-centre objects and degree-2 halos read zero by theorem; running the sweep first would measure a theorem (G30's failure mode); the census order lets every zero be read against the rung it sits on | high |
| B2 the object to grow | W (the 588-core spindle, 1,175 points), not W⁺ (3,905) | W⁺ carries all of U's rigidity | W's cross-pair census is 11× smaller and W⁺ is single-centre too, so D1 makes it no better for the dial; W⁺ is kept as a second census point if D's numbers are cheap | high |
| B3 the second spindle for phase C | the core's own second forced pair if P-M54-3 fails; else the full U with the second pair (35, 1859)'s neighbour pair … chosen by smallest |core₂| after a bounded shrink (≤ 1 h) | always the full U | the union's sweep cost scales with the vertex count, and the falsifier of D2 needs only two centres | medium — the shrink's cost decides at implementation |
| B4 exact arithmetic | a generic `KExt(m)` class (A + √m·B over K) rather than a hand-written `K247` | copy `K5` with 247 in place of 5 | one class serves 247, 23 (the 8/√3 witness) and 5 (the copies) and the tower square test at every m | high |
| B5 ν's engine | RC2 (pysat's MaxSAT) with a wall, reporting bound + optimality flag | a cardinality ladder of plain SAT asks | RC2 returns an optimum with a certificate of optimality when it finishes and a bound when it does not; the ladder needs one ask per rung | medium — if RC2 stalls on W, the ladder at ν ≤ 3 is enough for P-M54-2 |
| B6 what "the dial" reports | forced-equal AND virtual edges, with the √3 and distance-2 classes broken out | forced-equal only (the spindle's input) | G26 sharpened says the 6-hunt needs virtual edges at √3 and 2 as much as a forced pair anywhere; the Rigidity engine settles both sides in one run | high |
| B7 the milestone's number | M54 | fold into the halted M53 | M53 is halted at phase D with its own resumable state; this is a new objective (the dial), not iteration 5 | high |

## §Bʹ. The domain-modeling pass (2026-09-05, fresh invocation) — what it changed

**The model that converged.** Three objects: a graph with `k` colours; its **critical set**
`CriticalSet G k = {c | (G − c's edges) is k-colourable}` (a `Set V`, so the theorems are containments
and the plane bound is an `encard`); and the **isolating lemma** — through any critical vertex `c`, any
independent set `S ∋ c` can be painted with the spare colour over a `k`-colouring of the rest. Every
compulsion statement of the milestone is one instance of the lemma at one `S`: `S = {c}` is
`Critical.exists_isolating_of_colorable_delete`; `S = {p}` and `S = {p, q}` with every vertex critical
are the two `SpareColour` recolourings; `S = {p, c}` is the forced-equal localization; `S = {p, q, c}`
the virtual-edge localization; and `S = {p, c}` with `c ∉ Q` refutes a **fan** at `p` over `Q` —
`C ⊆ N(p) ∪ Q`, the general form, with `Forces` its width-one case (`fan_singleton_iff`). The fan
theorem is added to the skeleton because the repository's compulsion vocabulary is the fan, and the
statement costs one line.

**Simulated before stated** (grok): K₄ minus the edge {0, 1} at two colours has C = {2, 3} =
N(0) ∩ N(1) exactly — the bound is tight on four vertices, and that graph is the spec example. The Moser
spindle at three colours is vertex-critical (delete the hub: two triangles joined by an edge; delete a
tip: a rhombus and a triangle), so at four colours it has no pair compulsion — a statement the
spare-colour lemma cannot make (the spindle is not 3-colourable), so the theorem is strictly stronger.
The seed H: no point is within {1, 2}-distance of both endpoints of a pair at distance 5, so C(H) = ∅
(P-M54-1 is the simulation, run by the machine).

**The instrument's true quantity is the candidate set, not the sweep.** The theorem admits, on any
graph, exactly the pairs 𝒫_eq(G) = {(p, q) : C ⊆ N(p) ∩ N(q)} for forced-equal and
𝒫_ne(G) = {(p, q) ≁ : C ⊆ N(p) ∪ N(q)} for virtual edges. In a unit-distance graph
|N(p) ∩ N(q)| ≤ 2, so 𝒫_eq = ∅ unless |C| ≤ 2, and 𝒫_ne = ∅ unless |C| ≤ 2Δ. **Hence the criticality
census subsumes the complete five-colour sweep whenever |C| > 2Δ** — on such an object the sweep
measures a theorem, and T21's 858-second sweep of W was one. Phase E is reshaped accordingly:

| step | what | population in the headline |
|---|---|---|
| E1 | the criticality census of the grown object: C, Δ, |C|/n (the redundancy dial) | n asks at four colours |
| E2 | the candidate sets 𝒫_eq, 𝒫_ne from C and the adjacency lists — zero solver calls | pairs admitted by the theorem |
| E3 | targeted asks on the candidates only (one SAT ask per candidate pair per polarity, second encoding on any hit) | |𝒫_eq| + |𝒫_ne| asks |
| E4 | the complete `Rigidity` sweep ONLY as (a) the planted red/green control and (b) the one-point confirmation on the two-spindle union that the pruned reading agrees with the exhaustive one | the whole pair set, once |

**The redundancy dial and ν are two slices of one family.** The spare classes 𝒮(G) = {S independent :
G − S is k-colourable} are exactly the fifth-colour classes of the (k+1)-colourings; C(G) is the
|S| = 1 slice, ν(G) = min |S| over 𝒮, and ν = 1 ⟺ C ≠ ∅. A forced-equal pair needs every S ∈ 𝒮 to
contain both or neither endpoint — the |S| = 2 slice through a critical vertex is the theorem. So |C|/n
(from 1 on a vertex-critical object toward 0) and ν (from 1 upward) are the two cheap readings of the
same structure, and ν's RC2 encoding is the natural one: hard = proper (k+1)-colouring (at-least-one
per vertex plus edge clauses; exactly-one is not needed because a doubly-coloured vertex only ever
costs), soft = "v does not wear the spare colour".

**When a halo cannot move the dial (derived, replacing the loose sentence in P-M54-6).** If every
added point has at most three already-coloured neighbours at the time it is coloured — two parents in
W plus pool-degree ≤ 1 — a 4-colouring of W − c extends greedily over the halo, so C(W ∪ P) ⊇ C(W)
EXACTLY, with no ask. A halo moves the critical set only through its own non-4-colourable (or
boundary-constrained) structure, which is why P-M54-5's pool-degree number is the number that
matters, and why E1 is asked before E3 rather than after.

**Seams validated.** (i) The theorems hold for `u = v`? `Forces G (k+1) u u` is trivially true and the
plane statement's `hne : q u ≠ q v` excludes it — the hypothesis is the true one (`u ≠ v` alone would
let `q u = q v` collapse the two neighbourhoods into one and the bound of two fail). (ii) Injectivity
enters only the count (`encard ≤ 2`); the glue-point statement needs none. (iii) `encard`, not
`ncard`: an infinite critical set would make `ncard ≤ 2` vacuously true. (iv) Adversarial member: a
graph with `C = ∅` and no compulsion (two disjoint copies of the Moser spindle at three colours:
C = ∅ since each deletion leaves the other spindle 4-chromatic; no forced pair since the copies are
independent) — the theorem is necessary, never sufficient, and the plan says so.

**Not added** (the injunction): no `SpareClass` structure (ν is instrument-side; no kernel consumer),
no `Fintype` on the localization theorems (only the count needs it), no edge-list API for the critical
set (the tool filters, the kernel does not certify a census).

## §Bʺ. The obligation-modeling pass (2026-09-05, fresh invocation) — each proof's space, and the prove / test / assume partition

### The kernel piece, obligation by obligation

| obligation | the space, and the local check that closes it |
|---|---|
| `exists_coloring_isolating_of_mem_criticalSet` | `hc` yields `C' : (G − c).Coloring (Fin k)`; the colouring is `v ↦ if v ∈ S then Fin.last k else (C' v).castSucc` (classical membership); validity by the four cases on `(v ∈ S, w ∈ S)`: both — `hS`; one — `castSucc_lt_last`; neither — `deleteIncidenceSet_adj` needs `v ≠ c` and `w ≠ c`, both from `c ∈ S`, then `C'.valid` and `castSucc_injective`. **`c ∈ S` is exactly the hypothesis that makes the deleted edges harmless.** The two conclusions are `if_pos` and `if_neg` + `castSucc_lt_last` |
| `not_forces_of_mem_criticalSet` | `S = {p, c}`; independence by the four cases (irrefl, `hpc`, `hpc` via `Adj.symm`, irrefl); `C p = last`, `C q ≠ last` since `q ∉ S` (`hpq.symm`, `hcq.symm`); `Forces` contradicts. **Mutation audit:** `hcq` is load-bearing for THIS instance (at `c = q` the set `{p, q}` paints both alike and refutes nothing) but NOT for the truth — at `c = q` the conclusion still holds by the instance `S = {q}`, which is `Critical.not_forces_of_colorable_delete` on the swapped pair. So the ∩-theorem's proof is a case split the informal two-liner hid: first `c ≠ p` and `c ≠ q` through `S = {c}` (the pair and its swap, `Forces` being symmetric by `(h C).symm`), then adjacency through `S = {p, c}` |
| `not_separated_of_mem_criticalSet` | `S = {p, q, c}`; nine independence cases from `hpq`, `hpc`, `hqc`, irrefl and `Adj.symm`; `C p = C q = last` contradicts `Separated`. No `p ≠ q`: at `p = q` the set is `{p, c}` and `Separated G _ p p` already fails |
| `not_fan_of_mem_criticalSet` / `criticalSet_subset_of_fan` | `S = {p, c}`; the fan's witness `q ∈ Q` has `q ≠ p` (`hp`), `q ≠ c` (`hcQ`), so `C q ≠ last = C p`; the subset form is `by_contra` + `Set.mem_union`/`mem_neighborSet` |
| `criticalSet_subset_inter_neighborSet_of_forces` | as above: `c ∉ {p, q}` first, then `G.Adj p c` by contradiction with the `S = {p, c}` instance and `G.Adj q c` with the swap; `SimpleGraph.mem_neighborSet` |
| `criticalSet_subset_union_neighborSet_of_separated` | `by_contra` on membership gives `¬ Adj p c ∧ ¬ Adj q c`; the three-point instance. At `c = p` the hypotheses hold trivially (`irrefl`, `hpq.symm`), so `p ∉ CriticalSet` is a corollary, not an extra case |
| `not_mem_criticalSet_of_forces` | the ∩-theorem at `c = p` gives `Adj p p` — `G.loopless` |
| `criticalSet_eq_univ_of_colorable` | `deleteIncidenceSet_le` + `Colorable.mono_left` (the name to be taken from `exact?`) |
| the spare-colour `example` | `criticalSet_eq_univ_of_colorable` + `not_mem_criticalSet_of_forces`, two lines |
| `encard_criticalSet_le_degree_of_forces` | `Set.encard_le_encard` (monotone) along `CriticalSet ⊆ N(p) ∩ N(q) ⊆ N(p)`, then `(G.neighborSet p).encard = G.degree p` by `Set.encard_eq_coe_toFinset_card` and `degree`/`neighborFinset` unfolding — the one place `Fintype`/`DecidableRel` are needed |
| `forces_criticalSet_glue` | `hne → u ≠ v`; the ∩-theorem gives `Adj u c`, `Adj v c`; `hq` turns them into unit distances; `dist_comm`; `Glue.eq_gluePoint_of_unit_pair hne` |
| `criticalSet_eq_empty_of_forces_of_two_lt_dist` | `Set.eq_empty_iff_forall_notMem`; `u ≠ v` from `hd` (`dist_self`); the two unit distances and `dist_triangle` give `dist (q u) (q v) ≤ 2`, against `hd` |
| `encard_criticalSet_le_two_of_forces` | `CriticalSet ⊆ q ⁻¹' {g, g'}` from the glue theorem; `(q ⁻¹' T).encard = (q '' (q ⁻¹' T)).encard ≤ T.encard` by `hinj.encard_image` and `Set.image_preimage_subset`; `T = insert g {g'}` has `encard ≤ 1 + 1` by `Set.encard_insert_le` + `Set.encard_singleton` |
| the K₄ − e spec examples | a `DecidableRel k4MinusEdge.Adj` instance (`decidable_of_iff` through `SimpleGraph.fromRel_adj`); `Forces … 3 0 1`: the four adjacencies by `decide`, then the closed decidable fact `∀ a b c d : Fin 3, a ≠ c → a ≠ d → b ≠ c → b ≠ d → c ≠ d → a = b` by `decide` (81 cases); `2 ∈ CriticalSet`: the explicit colouring `![0, 0, 0, 1]`, properness by `deleteIncidenceSet_adj` then `revert` + `decide` over the 16 pairs; `0 ∉ CriticalSet`: `rintro ⟨C⟩`, the triangle `{1, 2, 3}`'s three adjacencies, and `∀ a b c : Fin 2, a ≠ b → a ≠ c → b ≠ c → False` by `decide` |

**A vacuity seam checked.** `Forces G (k+1) p q` is vacuously true on a non-`(k+1)`-colourable graph; the
theorems still hold there because a critical vertex manufactures a `(k+1)`-colouring (the isolating
lemma at `S = {c}`), so on such a graph the critical set is empty and every containment is trivial.
No colourability hypothesis is needed and none was added.

**Partition.** *Prove*: the thirteen declarations above. *Test*: the K₄ − e triple (the tight case:
`C = N(0) ∩ N(1)` exactly) and the spare-colour example (an existing theorem re-derived). *Assume*:
nothing — every side condition is a stated hypothesis, and the mutation audit (drop `hpc`: K₄ − e
refutes; drop `hpq`: `Forces p p` is trivial; drop `hcq`: the statement stays TRUE by the other
instance, which is the one hypothesis whose deletion the audit must read as "provable another way"
rather than "vacuous") is recorded here so the implementation does not re-run it.

### The instrument's invariants (what each subcommand asserts, and the test that would catch it lying)

| subcommand | asserts | local check | test |
|---|---|---|---|
| `critical` | `C(G) = {v : G − v is k-colourable}` exactly; every SAT answer carries a colouring **verified proper on G − v in Python** (so membership in C is certified by an explicit witness); every UNSAT is solver-trusted and only ENLARGES the candidate sets — the safe direction | the palette pin is placed on a vertex ≠ v (a pin on the deleted vertex would be vacuous) | K₅ − e at three colours: `C = {x, y, z}` (the clique triple), the two non-adjacent vertices not critical; the E–I seed: `C = ∅` (P-M54-1) |
| `candidates` | `𝒫_eq = pairs inside T_eq = ⋂_{c ∈ C} N(c)`; `𝒫_ne = {(p, q) ≁ : q ∈ ⋂_{c ∈ C ∖ N(p)} N(c)}` (with `C ∖ N(p) = ∅` admitting every non-neighbour `q`); `C = ∅` admits every pair; bitset intersections, O(n·\|C\|), zero solver calls | equal to the brute-force `C ⊆ N(p) ∩ N(q)` test on every pair for n ≤ 50 | K₅ − e: `𝒫_eq = 𝒫_ne = {(a, b)}`; K₄ − e at two colours: `𝒫_eq = {(0, 1)}` |
| `ask` | for each candidate the forced-equal ask (`G ∧ p ≠ q` at k+1) and the virtual-edge ask (`G ∧ p = q`); an UNSAT is a HIT and triggers the jackpot protocol (second encoding, exact geometry) | a hit's second encoding must agree | K₅ − e: `(a, b)` forced equal, not separated |
| `nu` | `ν(G) = min` over proper `(k+1)`-colourings of the spare class size; RC2 with hard = at-least-one + edge exclusion (exactly-one unnecessary: a doubly-coloured vertex only ever costs), soft = `¬x_{v, k}` weight 1; the optimum's colouring is decoded (smallest true colour) and **verified proper**; on a wall the result is `unknown` with the best upper bound seen | `ν = 1 ⟺ C ≠ ∅` cross-checks `critical` on every object | K₅ at five colours: 1; two disjoint K₅: 2; K₄ − e at three colours: 1 |
| `exact-witness` | every unit edge and every cross chord of W is an exact identity in `KExt(247)`; the 60-digit near-miss list is exactly non-unit | the arithmetic class's `(a + b√m)` product law tested against mpmath on random elements; `sqrt_ext` at m = 247 verified by squaring on every root | a planted moved point fails exactly one incident edge |
| `cross-lattice` | every glue point written is at exact unit distance from both parents (re-verified from the coordinates, parse-don't-validate); fusions by exact coordinate equality; pool–pool edges screened at 60 digits and confirmed exactly | a K-pair with an in-field radicand (from T18's table) is classified in-field by the same code at m = 247 (K ⊂ F₂₄₇); a cross pair with a non-square radicand refuses | the counts carry their populations |
| `planted-sweep` | the exhaustive `Rigidity` sweep at five colours on W + (a hexagonal shell's nine {√3, 2} pairs minus two disjoint ones) confirms exactly the two missing pairs forced equal | the shell is located by its 12 unit edges among 7 points | seen red first: the same object with all nine pairs is vacuous (K₇), reported as such |

### Phase C's object, priced by these obligations

The two-spindle union's critical set is essentially `core₁ ∩ core₂` (a vertex of U in both forcing
cores breaks both spindles; a copy vertex breaks one and the other spindle carries χ = 5), so the
redundancy reading `|C|/n` is the overlap of the two cores, and the second pair should be chosen to
minimize it — the forced pair whose endpoints lie farthest from pair 1's midpoint, shrunk by the
greedy outside-in order under a one-hour wall (checkpointed per accepted deletion; the first core took
3,800 s). Decision B3 is settled that way. The exhaustive sweep on the union (E4b) is the one
heavy job of phase C; its pruned reading is expected to be "no candidates" (|C| ≫ 2Δ) and the sweep
confirms the theorem's zero at one point.

## §Bʹʹʹ. The experience-modeling pass (2026-09-05, fresh invocation) — the surfaces

### (1) `CriticalSet.lean` — what a consumer holds, and which direction to reach for

| you have | you want | use |
|---|---|---|
| a colouring of `G` minus one vertex `c`, and `c` not adjacent to `p` | no forced pair `(p, q)` for any `q ≠ c` — one colouring retires every partner at once | `not_forces_of_mem_criticalSet` |
| the same `c`, adjacent to neither `p` nor `q` | no virtual edge `(p, q)` | `not_separated_of_mem_criticalSet` |
| the same `c`, outside a fan's partner list | no fan at `p` over that list | `not_fan_of_mem_criticalSet` |
| a forced pair | the critical set inside its common neighbourhood; the count bounded by a degree | `criticalSet_subset_inter_neighborSet_of_forces`, `encard_criticalSet_le_degree_of_forces` |
| a forced pair drawn in the plane with unit edges | its critical vertices at the two glue points; none beyond distance 2; at most two | `eq_gluePoint_or_reflAxis_of_mem_criticalSet_of_forces`, `criticalSet_eq_empty_of_forces_of_two_lt_dist`, `encard_criticalSet_le_two_of_forces` |
| a packed colouring of an edge list minus a vertex | membership in the critical set | `Critical.colorable_delete_of_packed`, then `mem_criticalSet_iff` (definitional) — no new edge-list surface is minted |
| a forced pair `(p, q)` and need it the other way round | `Forces G k q p` | `Forces.symm` (minted here, not in `Forcer.lean`, whose 48 dependents a new declaration would rebuild) |

Two names failed the cold read and are changed in the skeleton: `forces_criticalSet_glue` (says nothing
about its conclusion) becomes `eq_gluePoint_or_reflAxis_of_mem_criticalSet_of_forces`; and the
swapped-pair step is a named theorem rather than `fun C => (h C).symm` at every use.

**A consumer nobody had named.** Every stage of the descent — the seed, every committed object, the
final unit graph — forces `(205, 206)` at five colours in its own {1, 2}-graph, so by the theorem its
critical set is EMPTY at four colours (the endpoints are five apart; no vertex is within {1, 2}-distance
of both). One deletion ask per vertex is therefore a free regression control on any committed object:
a critical vertex is a vertex whose deletion 4-colours the {1, 2}-graph, i.e. the object has stopped
forcing — a bug, not a finding. Recorded in the tool as `critical --seed` / `critical --object`.

### (2) `tools/five_dial.py` — the command line and the result files

One file; one shared **stage loader** (`--witness <json>` rebuilds W from a forced-spindle record;
`--seed` the E–I {1, 2}-graph; `--object <label>` the descent object's {1, 2}-graph; `--graph <json>`
any `{n, edges}`; `--planted k5e | k4e | two-k5 | shell` the controls); every subcommand prints a
one-line headline that names its population and the theorem it leans on, and writes one JSON with a
common header:

```
kind, stage: {name, n, edges, fingerprint (sha256 of the sorted edge list), source}, k, seconds, claim_scope
```

| subcommand | arguments | headline (the shape, with populations) | file |
|---|---|---|---|
| `self-test` | — | every planted control's expected/observed, `ok`/`FAIL` per line, nonzero exit on any FAIL | — |
| `critical` | stage, `--k`, `--workers`, `--wall`, `--out` | `[critical] <stage> k=4: |C| = a of n (a verified colourings, u unknown at wall), Δ = d; forced-equal candidates e (theorem: C ⊆ N(p) ∩ N(q)), virtual-edge candidates f (C ⊆ N(p) ∪ N(q))` | `critical-<stage>.json`: `critical` (list), `unknown`, `delta`, `candidates_eq`, `candidates_ne` (lists when ≤ 10,000, counts always) |
| `ask` | `--critical <file>`, `--k`, `--wall` | `[ask] <stage> k=5: e forced-equal candidates → hits h / refuted r / unknown u; f virtual-edge candidates → …` | `ask-<stage>.json`; on any hit ALSO `jackpot-<stage>.json` and the banner `JACKPOT CANDIDATE — HALT AND VERIFY` with the pair, its exact distance, the second encoding's verdict; exit code 3 |
| `nu` | stage, `--k`, `--wall` | `[nu] <stage> k=5: ν = m (optimal | upper bound, wall hit), spare class {…} verified proper` | `nu-<stage>.json` |
| `exact-witness` | `--witness`, `--out` | `[exact] W: n points in F_247 (a core in K, b rotated), unit edges exact e/e, cross chords exact c/c, near-misses exactly non-unit m/m` | `witness-exact-<name>.json`: per point `[[A-coeffs],[B-coeffs]]` for x and y (A + √247·B, A, B in the (1, √3, √11, √33) basis), the edge list, the chord list |
| `cross-lattice` | `--exact <file>`, `--workers`, `--out` | `[cross] W: P cross pairs at d < 2 of Q; in-F247 glue points g (r %), distinct points p, fusions (≥ 3 W-neighbours) f, pool–pool unit edges e, max pool degree m; same-side 247-class pairs s` | `cross-lattice-<name>.json`: the radicand class table, the pool's exact coordinates and parents, the pool edges |
| `planted-sweep` | `--witness` | `[sweep-control] W + 7 shell cheats k=5: forced-equal confirmed {the two planted pairs} …` | `sweep-control-<name>.json` |
| `two-spindle` | `--object`, `--dial`, `--second <pair>`, `--shrink-wall` | the union's n, edges, chords; then `critical`'s and `nu`'s headlines on it | `two-spindle-<pairs>.json` + the census files |
| `sweep` | stage, `--k`, `--wall` | the exhaustive `Rigidity` reading, both sides, unsettled counts | `sweep-<stage>.json` |

Breakdowns designed: an ask that times out is `unknown` in its own column, never folded; a stage whose
base colourability fails at `k+1` is reported `vacuous` and nothing else runs on it (the Rigidity
engine's own guard); `critical` refuses to pin the palette on the deleted vertex; every SAT answer's
colouring is verified in Python before it counts (a solver returning an improper model is a `FAIL`
that halts, with the offending edge named); the jackpot exit code stops any driver.

### (3) `data/m54/README.md`

One paragraph per file in the order the phases produce them, each with the reading in one sentence
and the regenerating command; a header naming the milestone, the halt/close state, and the plan's §R
section holding the numbers.

## §R0. Phases 0, A, B1, B3 and C1 closed (2026-09-06 ~00:30–01:00Z, desktop)

| phase | result | file |
|---|---|---|
| 0 — the kernel piece | `CriticalSet.lean` fully proved: the isolating lemma, both localization theorems, the fan form, `Forces.symm`, the spare-colour re-derivation, the degree bound, the three plane corollaries (glue points / empty beyond 2 / `encard ≤ 2`), the K₄ − e tight spec; zero `sorry` under `lake env lean`; imported into `Proofs.lean` (the full gate build runs at the close, after the box is free) | `Proofs/HadwigerNelson/CriticalSet.lean` |
| A — exact geometry | the 1,175-point witness exact in K(√247): **5,773 / 5,773 unit edges and all 6 cross chords are exact identities**; 0 near-misses at 60 digits; T20 upgraded from "chords at 60 digits" to exact | `data/m54/witness-exact-core-8over3.json` |
| B1 — P-M54-1 | **MET: C(H) = ∅** — every one of the 214 single-vertex deletions of the Exoo–Ismailescu {1, 2}-seed still refuses four colours (214 non-critical, 0 unknown, 1 s); the theorem's calibration passed | `data/m54/critical-EI-seed-12graph.json` |
| B3 — the sweep's control | W + 7 shell cheats (ring [165, 277, 374, 570, 319, 223] about 7): the two planted pairs (165, 374) at √3 and (277, 319) at 2 found forced equal, status done in 25 s; the red (all nine pairs) seen vacuous; the shell's rigidity also throws 32 virtual edges — recorded, not a finding | `data/m54/sweep-control-W-core-8over3.json` |
| C1 — the witness's critical set | **W is VERTEX-CRITICAL: \|C(W)\| = 1,175 of 1,175** (every deletion 4-colourable, each certified by a verified colouring; 0 unknown; Δ = 26; 24 workers, ~4 min). Hence 0 forced-equal candidates and 0 virtual-edge candidates at five colours BY THEOREM, and T21's exhaustive zero (858 s) was an instance. P-M54-2 met beyond its registration (> 500 predicted; all 1,175 measured). Side fact: W is a vertex-critical 5-chromatic unit-distance graph | `data/m54/critical-W-core-8over3.json` |

**Cost anchors realized.** A critical deletion ask on W: 0.2–0.6 s (SAT); the whole census 1,175 asks
on 24 workers ≈ 4 min. The seed's 214 asks: 1 s.

**Phase C's second pair.** Of the 163 forced pairs at 8/3, the one whose midpoint lies farthest from
pair 1's (3.15 units; both endpoints outside core₁, nearest endpoint 2.23 from pair 1's) is
**(813, 1939)**; its 1-minimal core is being shrunk (checkpointed, `build/m54/shrink-813-1939.json`)
and the union core₁ ∪ R₁(core₁) ∪ core₂ ∪ R₂(core₂) built by `two-spindle`. Decision B3 realized.

**In flight at this record**: ν(H) (RC2, wall 1,800 s), ν(W) (wall 1,800 s), the phase-D cross-lattice
census (28 workers), the pair-2 shrink.

**Literature reconciliation done in the same session** (Kooshi brought the papers): Fischer 1990 owns
the additive framework and the real-quadratic classification (note §10.1); the milestone's kernel piece
is unaffected (a graph-theoretic theorem), and the field-wall note's Corollary 6.5 is corrected at
d ≡ 5 (mod 8).

## §R1. Phase D closed (2026-09-06 ~01:30Z) — the F₂₄₇ cross lattice is rare and lattice-like

| quantity (population) | measured |
|---|---|
| cross pairs (core × copy) at distance < 2, of all 345,156 cross pairs | 287,695 |
| pairs whose glue points lie in F₂₄₇ (r = 4/d² − 1 a square in K(√247), exact) | **104 (0.04 %)** |
| distinct glue points (exact coordinates) | **71** — the 208 glue points fuse heavily |
| points with ≥ 3 parents (fusions) | **20**; the parent histogram runs to (1 core, 18 copy) parents and (7, 1) |
| pool–pool unit edges (40-digit screen, exact confirm) / near-misses rejected | **114** / 0; the pool graph has two components (53 and 18 points) |
| coincidences with W | **8** — the fused centre x itself is a "glue point" of every pair (p, R(p)) with p a unit neighbour of x, and 7 more |
| radial classes about the centre | 35 distinct exact \|g − x\|²: 27 points on the UNIT circle about x (glue points of (x, R(p)) pairs), 5 at \|g − x\|² = 247/64, **2 at 64/9 — the forced-pair radius**, the rest in K(√247) proper (B-part nonzero) |
| the core's own same-side pairs at d < 2 (152,000) | 21,958 in-K glue (the K-lattice), **0 in the √247 class**, 130,042 out of field |
| the grown stage W ∪ pool (`grow`, exact unit census over all 1,238 points) | 1,238 points, 5,977 unit edges (**204 new**), 0 near-misses; new points' W-degree {2: 51, 3: 3, 4: 1, 5: 2, 6: 2, 7: 2, 8: 1, 10: 1}, max total degree on a new point 12 |

**P-M54-5 scored: MET in its sparsity half (0.04 % ≪ 2 %), REFUTED in its structural half** — 20
fusions against 0 predicted, a pool-degree far above 1. The reading the derivation missed: the cross
lattice at depth one is not generic F₂₄₇ dust but the SHADOW OF THE K-LATTICE — the pool's high-parent
points are rotated in-field K-glue points of the core (a copy point with 18 copy-parents is R of a
K-lattice fusion point) that happen to be a unit from a core point, and the centre's unit circle
carries the glue points of (x, R(p)). The half-angle rotation ρ^{1/2} = (√247 + 3i)/16 is where the
(p, R(p)) glue points live — de Grey's half-spindle group (G8) reappearing on our fabric. Anatomy
beyond this paragraph is a tangent, recorded in §7 of the close.

**Phase E1 launched on the grown stage** (1,238 points, 20 workers). The derived rule of §Bʹ ("a halo
of W-degree 2 with pool-degree ≤ 1 cannot move the critical set") does NOT cover this pool (W-degrees
to 10, pool degrees to 12), so E1 is a genuine measurement.

## §R2. Phase E1 closed (2026-09-06 ~01:45Z) — the pool moves the redundancy dial by three vertices, remotely

| quantity | measured |
|---|---|
| the grown stage W ∪ pool | 1,238 points, 5,977 unit edges, Δ = 32 (fingerprint 63795de0d0f1a332) |
| critical set at four colours | **1,172 of 1,238** (each certified by a verified colouring; 0 unknown; 20 workers, 227 s) |
| the 66 non-critical vertices | **63 are the new points** (never critical while W stays a subgraph — trivial) and **3 are W-vertices: 689, 957, 1151**, all on the COPY side at 2.15, 2.24, 2.17 from the centre, each with NO new neighbour |
| candidates at five colours | forced-equal 0, virtual-edge 0 (\|C\| = 1,172 ≫ 2Δ = 64) — by theorem |

**Reading.** P-M54-6 met in its dial half (0 candidates, hence 0 compulsions at five colours by
theorem — no sweep needed) and missed in its "C stays > Δ unchanged" half in an instructive way: the
critical set did move, and it moved at three vertices the pool does not touch. Deleting 689 leaves W
4-colourable, but every such 4-colouring fails to extend over the 63 pool points — the pool KILLS
the separating colourings of W − v for exactly three v, the way a descent halo kills a batch's
colourings (M49's mechanism, one level up). So the depth-one F₂₄₇ material is not inert for
redundancy: it is a weak kill at three sites of 1,175. The redundancy dial reads \|C ∩ W\|/\|W\| =
1,172/1,175 = 0.997, down from 1.000.

**What the derivation of §Bʹ missed and what it now says.** The halo's W-degree-2 points cannot
UNMAKE a critical vertex; they can make one vertex non-critical only collectively, through their own
edges (114 pool–pool edges, a 53-point component) — the "boundary-constrained non-4-colourable
structure" the §Bʹ rule named as the only mechanism. It fired, at three sites.

## §R3. The forcing-critical set, and the single-centre union on the full fabric (2026-09-06 ~02:30Z)

**Derivation (two lines).** For W⁺ = U ∪ R(U) with the spindle chord y–R(y): if v ∈ U is not
forcing-critical for (x, y) — U − v still forces x = y — then W⁺ − v ⊇ (U − v) ∪ R(U) refuses four
colours (R(U) forces x = R(y) and the chord separates y from R(y)); likewise for R(v). So
**C(W⁺) ⊆ F ∪ R(F)**, F the forcing-critical set of U for the pair — and F is one forcing ask per
vertex ("does U − v still force?"), 3 s each, against a 60-s deletion ask on the union.

| quantity | measured |
|---|---|
| F for (35, 1859) on the 1,953-point fabric U (1,951 asks, 24 workers, 449 s) | **7 vertices: {29, 79, 161, 199, 1753} ∪ {35, 1859}**, all inside the 588-core — the forcing survives every other single deletion |
| C(W⁺) on the 13 vertices F ∪ R(F) (13 asks at four colours on 3,905 points, 900-s wall; the other 3,892 non-critical by the derivation) | **exactly 13 of 13 critical** (each certified by a verified colouring); \|C\|/n = 0.003, Δ = 33 |
| candidates at five colours | forced-equal 0, virtual-edge 0 — the 13 critical vertices (the pair, its five indispensable helpers, and their copies) are dispersed across the fabric and no two unit neighbourhoods cover them |

**Readings.** (i) The single-centre corollary of D1 sharpened: C ⊇ {x, y, R(y)} always, and any
further critical vertex only helps the theorem refuse. (ii) The dial's quantity is not \|C\| but
whether C is COVERABLE BY TWO UNIT CIRCLES (a forced-equal pair needs C inside the two glue points
of the pair). (iii) **A route to C = ∅, derived**: on U ∪ R₁(U) ∪ R₂(U) with two spindles on the FULL
fabric, a vertex of U is critical only if it is forcing-critical for BOTH pairs, and a copy vertex
never is (the other spindle survives) — so C ⊆ F₁ ∩ F₂ exactly, with no ask. If F₁ ∩ F₂ = ∅ the union
is a 5-chromatic unit-distance graph with NO critical vertex, the first such object this programme
would hold besides the {1, 2}-seed, and on it the theorem admits every pair: the exhaustive
five-colour sweep is then the only instrument (D2 predicts it reads zero). Pair 2's forcing census is
launched; the two-core union of decision B3 continues in parallel as the smaller sibling.

## §R4. The three-fabric union: a 5-chromatic unit-distance graph with no critical vertex (2026-09-06 ~03:15Z; the sweep in flight)

| quantity | measured |
|---|---|
| F₂, the forcing-critical set of U for pair 2 = (813, 1939) (1,951 asks, 24 workers, 636 s) | **5 vertices: {428, 508, 607} ∪ {813, 1939}, none in the 588-core** |
| F₁ ∩ F₂ | **∅** |
| the union U ∪ R₁(U) ∪ R₂(U) (`two-spindle --full`, 60 digits, float prescreen) | **5,857 points** (1,953 + 1,952 + 1,952, no fusion — each copy omits its centre), **41,390 unit edges**; cross chords U–R₁ 8, U–R₂ 11, **R₁–R₂ 0** (copies never touch: G12/M52 again); 2 near-misses rejected; refuses four colours, admits five |
| critical set | **∅ by the §R3 derivation** (a vertex of U is critical only if forcing-critical for BOTH pairs; no copy vertex is) — **control green: all 34 load-bearing vertices (F₁ ∪ F₂ and their copies) asked directly, 34/34 non-critical, 0 unknown at an 1,800-s wall** (`data/m54/critical-spindles-35_1859-813_1939-full.json`); the other 5,823 non-critical by the derivation |
| candidates at five colours | every pair (C = ∅ admits everything): the exhaustive `Rigidity` sweep at five colours is the reading, launched with a 3,600-s wall per call and per-model checkpoints |

**What this object is.** The first 5-chromatic unit-distance graph in this programme's hands whose
5-chromaticity survives EVERY single vertex deletion (the seed has that property only as a {1, 2}-graph).
It was reached by derivation and two cheap censuses (≈ 20 minutes of forcing asks), not by search: the
localization theorem said what the object must look like (no vertex whose removal drops χ), the forcing-
critical set said how to get it (two spindles whose indispensable vertices are disjoint), and the full
fabric's redundancy (7 and 5 indispensable vertices of 1,953) supplied it. It is also, by the same
derivation, the natural generator of such objects: every pair of the 163 forced pairs with disjoint
forcing-critical sets gives one.

**Prediction for the sweep (registered here, before the first model):** 0 forced-equal pairs and 0 virtual
edges (D2: each copy is 4-colourable K-fabric attached by ≤ 11 chords, each chord endpoint of outside-
degree one, so every 5-colouring of the base extends over both copies; and the base U is 4-colourable
with a spare colour). Falsifier: any confirmed compulsion — the jackpot clause.

## §R5. ν, the fifth colour's smallest class (2026-09-06 ~01:30Z)

| object | ν | how |
|---|---|---|
| the E–I {1, 2}-seed H, five colours | **38** (exact) | all 840 proper 5-colourings enumerated under the exactly-one encoding with one vertex pinned = the 35 colourings up to palette M49 re-derived × 24; smallest class 38, largest-smallest 42 — every colouring is nearly balanced (≈ 43 per class) and the fifth colour is never spare. RC2 (MaxSAT) hit its 1,800-s wall at an upper bound of 40 |
| the witness W, five colours | **1** | a critical vertex v (all 1,175 are) with W − v 4-coloured and v in the fifth colour; RC2 hit its wall at an upper bound of 169 |
| the three-fabric union, five colours | **≥ 2** | C = ∅ (§R4) |

P-M54-7 (ν(H) ≥ 10) MET. Instrument note: RC2 is the wrong engine at this scale (both walls hit); the
exact value came from enumeration where the colouring space is rigid (35 classes), and from the
critical set where it is floppy (ν = 1 ⟺ C ≠ ∅). ν is therefore a dial only between those two
regimes, and the union's reading will come from the sweep, not from ν.

### §R4′. The sweep's engine at 5,857 points — three relaunches, each with its reason (2026-09-06 01:10–01:45Z)

1. The first launch was stopped at 4 GB resident two minutes in: the `Rigidity` engine's first batch
   query is over the eq-candidates after one model — with five classes of ≈ 1,170 vertices that is
   ≈ 3.4 million selector variables — a size the engine was never run at (T21: 2,025 vertices).
   Repair: pre-seed the model checkpoint so the candidate sets are small before the first query.
2. The first seeder (random 60-vertex pins) produced nothing in two minutes: a random pin set on a
   5-chromatic graph is often inconsistent, and refuting it is a hard UNSAT ask. Repair: diversity by a
   random relabelling of the formula per model, always satisfiable.
3. Measured before the third launch: one 5-colour solve of the union takes **66 s** in the plain
   at-least-one encoding and **281 s** with the exactly-one clauses the engine adds by default.
   The exactly-one clauses are not needed for soundness (a proper single-colour model is a one-hot
   model, so an UNSAT batch query certifies its side either way; observed models are decoded to the
   smallest true colour and are proper because the edge clauses bind every true colour) — `sweep
   --no-amo` drops them, the seeder likewise, 40 seed models. Chain 4 is the live run; its models are
   checkpointed and replayed on restart.

The cost anchor to carry: at 5,857 vertices a five-colour SAT call is a minute, so the sweep is an
hours-scale job and belongs to the one-heavy-job rule; the census (one 4-colour ask per vertex, 3 s
when the pair's forcing is asked on the fabric) is the cheap instrument, and the derivation that
reduced the union's critical set to F₁ ∩ F₂ replaced 5,857 deletion asks by 34.

## §R6. The two-core union: C = ∅ measured, on a third of the size (2026-09-06 ~02:30Z)

| quantity | measured |
|---|---|
| core₂, the 1-minimal forcing core of (813, 1939) on U (greedy outside-in, checkpointed, 4,254 s; every vertex's necessity witnessed) | **543 vertices, 2,672 unit edges** (core₁: 588) |
| core₁ ∩ core₂ | **31 vertices (5.7 % of core₂)** |
| the union core₁ ∪ R₁(core₁) ∪ core₂ ∪ R₂(core₂) | **2,229 points** (1,100 in U, 1,129 in the copies, no fusion), **12,030 unit edges**, cross chords U–R₁ 6, U–R₂ 7, copy–copy 0, 0 near-misses; refuses four colours, admits five |
| critical set (the derivation bounds it by the 31 shared vertices; all 31 asked at four colours, 24 workers, 900-s wall) | **∅ — 31/31 non-critical, 0 unknown**; the 2,198 others non-critical by the derivation |

**Reading.** The derivation's bound C ⊆ core₁ ∩ core₂ is an upper bound and the truth is empty: deleting
a vertex that lies in BOTH 1-minimal cores breaks both spindles' forcing on the base side and the union
still refuses four colours — its 5-chromaticity has routes beyond the two spindle chords (the thirteen
accidental chords and the copies' own rigidity, which the deletion does not touch). So a 2,229-point
5-chromatic unit-distance graph with no critical vertex, built from two disjoint-enough 1-minimal
cores; its exhaustive five-colour sweep (40 relabelling-seeded models, `--no-amo`) is launched as the
cheaper twin of §R4's, with the same registered prediction (0 / 0).

## §R7. The dial's reading on a C = ∅ object (2026-09-06 ~02:40Z) — redundancy is necessary, not sufficient

| quantity | measured |
|---|---|
| the two-core union (2,229 points, 12,030 edges, C = ∅ by §R6), the exhaustive `Rigidity` sweep at five colours, `--no-amo`, 40 seeded models | **status done: 0 forced-equal pairs (0 unsettled), 0 virtual edges (0 unsettled)** over every pair; 78 models, 38 calls, 31.5 s; the forced-equal side closed by observation alone (every pair seen separated by model 59), the virtual-edge side by batch queries |

**Scored.** P-M54-4 MET (the two-spindle union reads zero on both sides, and its critical set is not
merely smaller than W's but empty). The registered prediction for the C = ∅ sweep (§R4, D2's
absorption) MET at this point: each copy is 4-colourable K-fabric attached by six or seven chords whose
copy-side endpoints have outside-degree one, so every 5-colouring of the base extends over both copies,
and the base — two overlapping K-cores, 4-colourable — has a spare colour of its own. **So the
theorem's precondition (no critical vertex) is necessary and NOT sufficient**: this is G9/G31's
floppiness one rung higher, with the redundancy rung cleared. What remains between such an object and
a compulsion at five colours is the absorption obstruction (D2): the fifth colour is spare on every
4-colourable piece attached thinly, and the union is such pieces all the way through. The dial's next
rung is therefore named by derivation, not by search — material whose 5-colourings have no spare
colour on any large piece, i.e. a base that is itself 5-chromatic densely (many spindles whose
chords are not a thin conic each), or cross material with outside-degree ≥ 2 into rigid pieces
(§R1's pool, grown deeper). The big union's sweep (§R4′, chain 4) continues as the scale twin.

## §R8. Close (2026-09-06 ~03:15Z)

### Predictions scored

| # | registered | outcome |
|---|---|---|
| P-M54-1 | C(H) = ∅ | **MET** — 214/214 deletions refuse four colours (1 s); the theorem's calibration |
| P-M54-2 | \|C(W)\| > Δ(W), > 500; ν(W) = 1 | **MET** beyond registration — W is vertex-critical (1,175/1,175); ν(W) = 1 |
| P-M54-3 | the 588-core forces no second pair | **not run as stated** — superseded: the second spindle was taken from the full fabric's forced-pair inventory (pair 2 = (813, 1939)) and its own 1-minimal core shrunk (543); the core's own second-pair question is an open end |
| P-M54-4 | the two-spindle union has \|C\| < \|C(W)\| and reads 0 / 0 | **MET** — \|C\| = 0 (not merely smaller) on both the full-fabric union (by derivation, 34/34 checked) and the two-core union (31/31 checked); the two-core union's exhaustive sweep reads 0 / 0, complete |
| P-M54-5 | the F₂₄₇ cross lattice is sparse (< 2 %), 0 fusions, pool degree < 1 | **MET in its sparsity half** (0.04 %), **REFUTED in its structural half** — 71 points, 20 fusions, 114 edges, two components: the K-lattice's shadow |
| P-M54-6 | W ∪ pool reads 0 / 0 and \|C\| stays > Δ | **MET in its dial half** (0 candidates by theorem), **MISSED in its second half** — the pool removed three copy-side vertices from the critical set, remotely (the §Bʹ rule's only mechanism, which fired) |
| P-M54-7 | ν(H) ≥ 10 | **MET** — ν(H) = 38 exact |
| §R4's registration | the C = ∅ union's sweep reads 0 / 0 | **MET** on the two-core twin (31 s, complete); the 5,857-point original's sweep in flight at the close |

### What landed, in one table

| deliverable | state |
|---|---|
| `CriticalSet.lean` | 15 declarations, zero sorry, standard three axioms (audit entries in `scripts/Axioms.lean`) |
| `tools/five_dial.py` | 11 subcommands, 22 planted controls; `build/m54/{forcing_census,seed_models,nu_exact_seed}.py` |
| objects | the witness exact in K(√247); W ∪ cross pool (1,238); the full-fabric single-centre union (3,905); **two 5-chromatic unit-distance graphs with no critical vertex (5,857 and 2,229 points)** |
| readings | every critical set as the theorem predicted; the dial on a C = ∅ object: pairwise floppy at five colours, complete |
| literature | Fischer 1990 reconciled (T23); the note's Cor. 6.5 corrected |

### Open ends (not run, or run to a wall)

* The 5,857-point union's sweep (chain 4) — in flight; its result is an addendum here when it lands.
* The 588-core's own forced pairs at four colours (P-M54-3 as stated); other pairs of the 163 with
  disjoint forcing-critical sets (every such pair is a C = ∅ generator; the census costs 3 s per vertex).
* The cross lattice's anatomy (§R1): the half-angle rotation, the 53-point component, the 27 unit-circle
  points about the centre — a derivation waiting.
* Depth two of the cross lattice; the cross lattice of the C = ∅ unions (their copies never touch, so
  cross material is the only way to give copy-side points outside-degree ≥ 2).
* ν beyond the two regimes RC2 cannot reach (35 s enumeration where rigid, C ≠ ∅ where floppy).
* Kooshi's papers: Chow 1993, Chilakamarri 1988, the arXiv set in `../library/pdf` — unread beyond
  Fischer and Johnson DM 79's abstract; Soifer's chapters and Johnson CN 60 / Zaks pending.

### The gate

`lake env lean` green on the module (zero sorry); `./scripts/build.sh` and `scripts/axioms.sh` run at the
close — their verdicts are in the closing commit's message; `lake lint` likewise.

## §R7, addendum (2026-09-06 ~08:15Z, recorded at the M55 close) — the scale twin lands

The 5,857-point three-fabric union's exhaustive five-colour sweep (chain 4: 40 relabelling-seeded models,
`--no-amo`, 3,600-s wall per call): **status done — 0 forced-equal pairs (0 unsettled), 0 virtual edges
(0 unsettled); 138 models, 98 calls, 16,752 s** (`data/m54/sweep-spindles-35_1859-813_1939-full.json`).
The §R4 registration MET, as its 2,229-point twin already read in 31 s. M55 then showed why by theorem
(`Absorb.extends_of_hubs`, `plans/M55-absorption.md` §R1): every cross chord of each copy but the spindle
chord is a hub chord, so every 5-colouring of the fabric extends over the copies and the base's pairs
were never a measurement; the copy-side pairs were, and they are floppy too.
