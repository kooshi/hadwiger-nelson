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
