# The field-wall session, 2026-09-05 — handoff: findings, tools, open ends, Kooshi's questions, next moves

*Written at Kooshi's request so that everything survives the session. Read this first; it indexes
the rest. Canonical theory: `plans/FIELD-WALL-THEOREM.md` (a copy of `~/field-wall-conjecture.md`,
kept identical). Ledger entries: `plans/STANDING-QUESTIONS.md` T16–T20, Q10. Working theory:
`CLAUDE.md` § Grokkings G1 (promoted), G35–G37 (with the same-day sharpenings). Kernel plan:
`plans/STUB-field-wall-kernel.md`. Board: `plans/ROADMAP.md` § next seven days.*

## 1. What is now known (one paragraph each; the note has the proofs)

1. **Theorem B (the field wall).** Every finite unit-distance graph with coordinates in
   K = ℚ(√3, √11) is 4-colourable, by the residue colouring modulo a conjugation-fixed prime of K(i)
   above 2 (residue field 𝔽₄). Hand-proved; validated by computation on the seed and on the
   1,981-point descent object; not kernel-checked. — note §5.
2. **The wall's location.** For a real field F the method works iff −1 is not a square in some
   completion of F above 2; for multiquadratic F iff no odd square class is ≡ 7 (mod 8). √5 and √7
   break it; √2, √10, √14, √35, √70 do not; spindles at even distance always do. — note §6.1–6.3.
3. **Theorem A′ and the 3-adic wall.** Colouring by a residue class modulo an additive subgroup
   avoiding the norm-one group refines Theorem A. If F has a prime above 3 of residue degree one,
   χ(G(F²)) ≤ 3. Hence χ(G(ℚ(√3)²)) = χ(G(ℚ(√7)²)) = 3; K escapes because 11 is not a square mod 3.
   The residue method's thresholds below 7 are exactly 2, 3, 4. The invariant χ_res(F) is defined.
   — note §6.2′.
4. **Real quadratic planes.** ℚ(√d)²: bipartite for d even or d ≡ 1 (mod 8); ≤ 3 when 3 has a
   degree-one prime (d ≡ 0, 1 mod 3); ≤ 4 for d ≡ 3, 5 (mod 8); beyond the method for d ≡ 7 (mod 8),
   and among those the first with no residue-𝔽₃ prime is d ≡ 23 (mod 24): ℚ(√23), ℚ(√47), ℚ(√71).
   ℚ(√7)² has an explicit unit 5-cycle. — note Cor. 6.5, 6.6.
5. **The residue obstruction (T17).** Σ(C′), a 2-SAT on the seed vertices, decides which cheat sets
   in-field material can never make forcing; every in-field-reachable standing set has Σ UNSAT;
   μ ≥ 3 inside K; measured: 8 odd components on the culled object, 0 blocked singles, 0
   residue-type survivors. — note §7.2, `tools/residue_floor.py`.
6. **The wall-breaking material (T18).** Exact 2-adic classifier; only the √5 class breaks alone
   (4,221 of 950,371 pairs); 523,608 pairs inert; every radicand lies in ℚ(√33) so the classes are
   ⟨−1, 2⟩ at each prime. — `tools/wall_break_test.py`, `tools/wall_pool.py`.
7. **Replays (T19).** Single wall-breaking points kill 0 of 3,936 survivors (19 ms median); the
   573k-point partner pool at five-minute walls: 394 of 394 undecided. — `data/m53/replay-*`.
8. **The rigidity dial (Q10).** At four colours on the 1,953-point unit part, forced-equal pairs sit
   only at 2-adic valuation 6: 163/178 at 8/3, 8/11 at 8/√3, 0 of 15,230 at valuations 2 and 4;
   the zero rows are a theorem (forced-equal ⟹ positive valuation; virtual edge ⟹ valuation 0).
   — `tools/mono_census.py`, `tools/rigidity_dial.py`.
9. **New 5-chromatic unit-distance graphs (T20).** Spindling a forced 8/3 pair about one endpoint
   (cos 119/128, sin 3√247/128) gives a 5-chromatic graph in ℚ(√3, √11, √247): 3,905 points on the
   whole unit part, **1,175 points from the 1-minimal 588-vertex forcing core**; the 8/√3 class gives
   ℚ(√3, √11, √23). Neither field contains √5 or √7. Direct 4-refusals; 5-colourable controls.
   — note §7.5, `tools/forced_spindle.py`, `data/m53/forced-spindle-*.json`.
10. **Kooshi's cheat question, first data.** W (the 1,175-point witness) plus ALL its distance-2
    pairs stays 5-colourable (850 pairs); plus all √3 pairs likewise (2,370); plus both it refuses
    five colours — but trivially, through the seven-point clique of the {1, √3, 2} graph that any
    hexagonal fabric contains. — `tools/witness_cheats.py`, `build/m54/witness-cheats*.json`.

## 2. Tools built this session (all UNTRUSTED, all with a self-test or a control; commands in the docstrings)

| tool | what it does | inputs |
|---|---|---|
| `tools/residue_floor.py` | Σ(C′) for the standing set, every single removal, a batch; odd-cycle census; residue-type scan of a replay's survivors | object label, sidecar, batch dir, verdicts |
| `tools/wall_break_test.py` | exact 2-adic square classes of every radicand; breakers alone / one-prime / inert; the 𝔽₂-span; `--self-test` with 21 planted radicands | object label |
| `tools/wall_pool.py` | exports `depth1-wallfield` (breakers) and `depth1-partnerfield` (every nontrivial class) as engine-readable pools | object label, base pool |
| `tools/mono_census.py` | pair counts per exact distance class with their 2-adic valuation | object label |
| `tools/rigidity_dial.py` | complete four-colour forced-equal sweep joined to distance classes | object label |
| `tools/forced_spindle.py` | confirm a forced pair, shrink to a 1-minimal core, spindle, find chords at 60 digits, refute the union directly | object label, dial file, `--class`, `--shrink` |
| `tools/witness_cheats.py` | W + all pairs of a distance class as cheats: 5-colourable? minimal cheat set if not | witness json, object label |
| `tools/residue_colouring.py` (the other session's) | the explicit 4-colouring of any K-point object; the free 4-colourability certificate | object label |

Durable results: `data/m53/{residue-floor-it4c,wallbreak-it4,mono-census-it4,rigidity-dial-it4,forced-spindle-full,forced-spindle-core-8over3,forced-spindle-full-8oversqrt3}.json`, `data/m53/replay-wall-b2/`, `data/m53/replay-partner-sample/`. Regenerable, gitignored: `build/m54/` (pools, logs, the witness-cheat runs).

## 3. Kooshi's three questions

### (a) Can a minimal set of cheat edges make the new 5-chromatic graph 6-chromatic?

**Data.** One class at a time, no: W + all 850 distance-2 pairs is 5-colourable, and so is W + all
2,370 √3 pairs, + all 4,794 pairs at 1/√3, + all 180 at 4/√3, + the 2 at 8/3. Two classes, yes but
trivially: W + distance-2 + √3 pairs refuses five colours because W's fabric contains closed
hexagonal shells, and a shell with its √3 and distance-2 pairs is K₇ — nine cheats do it with no help
from W. That is not a descent seed, because those nine cheats are exactly the pairs the 6-hunt needs
to force distinct (M48's conjunction), so replacing them is the whole problem.

**The sharper form, in the Exoo–Ismailescu shape** (cheats force a PAIR equal at five colours; then
spindle): does W + its 850 distance-2 cheats force any pair equal at five colours? **No.** The complete
sweep at k = 5 (`data/m53/witness-cheats-w5-rigidity.json`, the Rigidity lattice, settled in 81 calls,
858 s): **0 forced-equal pairs and 0 virtual edges** over all pairs of W + its 850 distance-2 cheats. The
witness with its cheats is pairwise floppy at five colours — G9's rule (rigidity lives only at the
forcing level k − 1) holding one level up: 4-rigid, 5-chromatic, 5-floppy.

**Why single-class cheats fail, and what would work.** W is 5-chromatic but its 5-colourings are
floppy: each side (the 588-core and its copy) is K-fabric, 4-colourable, and the fifth colour is spare
on either side; distance-2 pairs, monochromatic under the residue colouring, are easily separated once
a fifth colour exists. The E–I seed is different in kind: 214 points engineered so that 446 distance-2
cheats leave exactly 35 separating colourings. To make W a seed one needs 5-rigidity, and the analogy
that produced everything above says where to look: K-fabric became 4-rigid at its deepest 2-adic
valuation as the glue lattice grew (Q10: 131/178 → 163/178 in one halo). The corresponding move is
**grow W in its own field F₂₄₇ = ℚ(√3, √11, √247) by glue points and read the five-colour dial** —
forced-equal pairs at five colours are the endgame's whole content (G26/G32), and if one appears at
distance d, the spindle theorem gives χ(ℝ²) ≥ 6 in the field F₂₄₇(√(4d² − 1)) with no descent at all.
That is the programme this session recommends over continuing the cheat descent.

### (b) In which field could a 6-chromatic unit-distance graph live?

**What the arithmetic says.** Residue colourings bound χ(G(F²)) by 2, 3, or 4 exactly when the
2-adic wall stands with residue field 𝔽₂, or 3 has a degree-one prime, or the 2-adic wall stands
with residue field 𝔽₄; above that the method's next values are 7, 8, 9, 11, …, all useless against
the plane's 7. So a field hosting a 6-chromatic graph must pass BOTH walls — √−1 in every completion
above 2, no residue-𝔽₃ prime above 3 — and that is the same condition a 5-chromatic graph needs.
Nothing arithmetic separates 5 from 6 from 7 in this theory; the honest answer is that the field of a
6-forcer is not predictable from residues.

**What the construction says.** Every 5-forcer we can now name is fabric plus a spindle at a distance
the fabric forces equal one level down: de Grey's at 2 and 4 (√15, √63), ours at 8/3 and 8/√3 (√247,
√759 ∼ √23). If a 6-forcer is built the same way, its field is F(√(4d² − 1)) where F is the field of
5-rigid fabric and d the distance it forces equal at five colours. The table of what K-fabric could
force next (valuation 4 after valuation 6, the dial's own order) and the field each spindle adjoins:

| forced distance d (d² 2-adic valuation) | 4d² − 1 | field adjoined to K |
|---|---|---|
| 8/3 (6) | 247/9 | √247 = √(13·19) — realised |
| 8/√3 (6) | 253/3 | √759 ∼ √23 — realised |
| 4 (4) | 63 | √7 — de Grey's second field |
| 4/√3 (4) | 61/3 | √183 ∼ √61 |
| 2√3 (2) | 47 | √47 |
| 2 (2) | 15 | √5 — Heule's field |
| 2/√3 (2) | 13/3 | √39 ∼ √13 |
| 4/3 (2) | 55/9 | √55 ∼ √5 |

So if the dial's order holds, deeper K-fabric will hand us witnesses in K(√7), K(√61), K(√47),
K(√5), K(√13) in roughly that order, each a new 5-forcer without search. For the 6-forcer the same
table exists one level up, over F₂₄₇ or Heule's field, with unknown entries — the five-colour dial
fills it.

**Where the smallest fields are.** The first quadratic planes past both walls are ℚ(√d) with
d ≡ 23 (mod 24). They have no equilateral triangles; whether any of them needs four colours is a
crisp open question (a triangle-free 4-chromatic unit-distance graph in a quadratic field would be a
first); five is conceivable and would be spectacular. The known 5-fields have degree 8 (Heule) and
16 (de Grey); ours have degree 8.

### (c) Can this improve search efficiency?

Yes, in these ways, most already built:

1. **4-colourability of any K-point object is a formula** (`tools/residue_colouring.py`): every
   χ(unit) monitor ask and every "is the halo 4-colourable" question on K-material is free.
2. **Batch admissibility for the in-field loop is a 2-SAT** (`tools/residue_floor.py`): a batch with
   Σ SAT is never worth a pool.
3. **Two thirds of the depth-one pool is provably inert for the endgame** (T18); the wall-breaking
   export is 8,442 points instead of 1.6 M. For intermediate kills the in-field 16,348 still do the
   work; the 573k partner pool is only worth a solver at hour-scale walls.
4. **Four-colour rigidity sweeps need solver calls only on positive-valuation pairs** (forced-equal)
   or valuation-0 pairs (virtual edges): the theorem prunes the candidate set before any ask.
5. **Witnesses without search**: the dial names spindle-able distances; `forced_spindle.py` mints a
   5-chromatic graph per forced pair in one SAT refutation each.
6. **A symmetry-breaking idea, not built**: on K-point objects, seed the one-hot encoding's palette
   with the residue classes (colour 0..3 = residue), so cubes and breaking follow the arithmetic
   rather than vertex order; and for unions of K-planes (the witnesses), break per plane.
7. **Free geometry control**: a misplaced K-point shows as a monochromatic unit edge in the residue
   colouring (G36).

## 4. The papers I could not reach (exact names) — ARRIVED 2026-09-05/06 (Kooshi: `~/source/library/{papers,pdf,notes}`)

*Fischer 1990 read in full 2026-09-06; the reconciliation is `~/field-wall-conjecture.md` §10.1 (copy
`plans/FIELD-WALL-THEOREM.md`): the additive framework and the whole real-quadratic classification are his
(Theorems 8–10), including χ(ℚ(√3)²) = χ(ℚ(√7)²) = 3 and the d ≡ 23 (mod 24) candidates; Corollary 6.5
was wrong at d ≡ 5 (mod 8) (bipartite, not ≤ 4 — conjugation in inertia); Theorem B (the biquadratic
K, χ = 4 exactly) and the local criterion remain ours. Johnson DM 79, Chilakamarri DM 69, Chow DM 115
are in `../library/papers/`; Johnson CN 60 and Zaks are print-only (request notes in `../library/notes/`);
Soifer's book is being borrowed.*

### (the original list) The papers I could not reach (exact names)

1. K. G. Fischer, *Additive K-colorable extensions of the rational plane*, Discrete Mathematics 82
   (1990), no. 2, 181–195. DOI 10.1016/0012-365X(90)90324-B. (Defines additive k-colourings —
   homomorphisms from the subgroup generated by unit vectors to a group of order k, nonzero on unit
   vectors; the residue colourings are instances. The question: does it contain the local criterion
   of note §6, or the biquadratic case?)
2. P. D. Johnson Jr., *Coloring real quadratic extensions of Q²*, Congressus Numerantium 60 (1987),
   51–58. (Cited elsewhere as *Two-colorings of real quadratic extensions of Q² that forbid many
   distances*; likely the bipartite cases of Corollary 6.5.)
3. P. D. Johnson Jr., *Two-colorings of a dense subgroup of Qⁿ that forbid many distances*, Discrete
   Mathematics 79 (1989/90), no. 2, 191–195.
4. J. Zaks, *On the chromatic number of some rational spaces*, Ars Combinatoria 33 (1992) 253–256
   (also Univ. of Waterloo research report CORR 88-26, 1988).
5. K. B. Chilakamarri, *Unit-distance graphs in rational n-spaces*, Discrete Mathematics 69 (1988)
   213–218 (connectivity of G(K^d) over number fields, cited as "not connected for d = 2").
6. T. Chow, *Distances forbidden by two-colorings of ℚ³ and Aₙ*, Discrete Mathematics 115 (1993)
   95–102.
7. Possibly a Fischer follow-up on the connected components of ℚ(√N₁, …, √N_d)² (title unverified).
8. A. Soifer, *The Mathematical Coloring Book* (Springer 2009), the chapters on colourings of
   number-field planes — the survey that would say whether items 1–4 settle Theorem B's small cases.

What I need from them: whether "χ(ℚ(√3, √11)²) = 4", the 2-adic criterion, and "χ(ℚ(√3)²) = 3" are
already there. My guess: the bipartite cases and the framework are; the biquadratic field and the
3-adic line refinement may not be.

## 5. Novel approaches now open (my take, ranked)

1. **DONE as M54 (2026-09-06, `plans/M54-five-colour-dial.md`) — the reading: the localization theorem, two C = ∅ objects, pairwise floppy at five colours; next rung = no spare colour on any thinly attached piece.** *(as written:)* **The five-colour dial on 5-chromatic fabric grown in its own field.** Take W (or the 3,905-point
   union), build its depth-one glue lattice in F₂₄₇ (the tools work on any field once exact
   coordinates exist — a K(√247) arithmetic class is needed, the K5 class in `copy_exact_field.py`
   is the template), commit points that increase five-colour rigidity (the dial as the objective, not
   cheat removal), and watch for the first forced-equal pair at five colours. One such pair is
   χ(ℝ²) ≥ 6. This replaces the descent's objective with the quantity the theorem says matters.
2. **The 588-core's anatomy.** A K-fabric forcer of a pair at 8/3 at four colours, smaller than de
   Grey's 791 and without √5, √7. Its shells, its rot6 orbit structure, and WHY it forces (a human
   argument, like de Grey's mono-triple argument) would be the first mechanism-level understanding of
   4-rigidity in K, and the template for 5-rigidity.
3. **Smaller 5-chromatic witnesses.** The greedy outside-in shrink gave 588; other orders, vertex
   minimality, and forced pairs closer to the fabric's centre could give far smaller cores; a core of
   ~250 would beat Parts's 509-vertex record with a witness in a field of degree 8.
4. **The quadratic planes ℚ(√23), ℚ(√47), ℚ(√71).** SAT on unit-lattice balls: is any of them
   4-chromatic? Triangle-free by construction; the residue method is silent; a positive answer is a
   new kind of object, a negative one per ball is data on a dial (χ against radius).
5. **Kernel certificates**: Theorem B and A′ (`plans/STUB-field-wall-kernel.md`); the 1,175-point
   witness through the M06 pipeline with a √247 leaf added to the tower.
6. **Rigidity of the residue colouring (Q10) as a theorem.** The infinite statement "every
   4-colouring of G(K²) is residue" — approached through the finite dial: prove that a large enough
   ball forces every pair at valuation ≥ 6 monochromatic.

## 6. Derivations to attempt (cheap, derivation-first)

1. **Depth-two classes.** In-field glue points keep the E–I shape (x ∈ √3·ℚ(√33), y ∈ ℚ(√33)), so
   every radicand at every depth of the in-field lattice is 2-adically in ⟨−1, 2⟩: the in-field
   descent's reachable wall-breaking classes are exactly the √5-type (class −1) and 2-type pairs, at
   every depth. Two lines; worth stating and checking on the it-4 depth-two pool.
2. **The forced-distance spectrum.** Which positive-valuation distances CAN be forced equal at four
   colours by K-fabric, as a function of depth? The dial says valuation 6 first; derive whether
   valuation 4 (distance 4) must come before valuation 2 (distance 2), which would predict K(√7)
   witnesses before K(√5) ones.
3. **Spare-colour at five on W.** Which pairs of W can be forced equal at five colours at all? The
   residue colouring on each K-plane side plus the fifth colour gives explicit 5-colourings; a pair
   equated by all of them is the only candidate. Derive the candidate set before any sweep.
4. **χ_res for the known fields** (Heule's, de Grey's, Haugland's cubic field): which primes are
   conjugation-fixed and what the invariant reads; a table, and whether any known witness's field has
   χ_res < 7 (it cannot, but the check is the control).
5. **The 3-adic wall on the descent's K-lattice**: K has residue 𝔽₉ at 3 so Theorem A′ is silent, but
   which adjunctions would REOPEN it (a degree-one prime above 3 in the extended field would cap the
   extended plane at 3 — impossible once χ ≥ 4 material is present, so such adjunctions cannot occur:
   a consistency check that the 2-adic classifier alone is the right filter).
6. **Literature reconciliation** once the papers arrive.

## 7. Open ends (not run, or run to a cap)

* The partner pool at hour-scale walls, or a high-pool-degree restriction of it (the pdeg12 recipe).
* The five-colour forced-pair sweep on W + distance-2 cheats (launched; read `build/m54/w5-rigidity.json`).
* The 8/√3 pair's 1-minimal core (only the full-object union was built).
* Other shrink orders for the 8/3 core; vertex-minimal search.
* Exact geometry of the witnesses in ℚ(√3, √11, √247) and ℚ(√3, √11, √23) (chords verified at 60
  digits, not in exact arithmetic).
* The in-field loop as in-context reduction (admissible, non-terminating, floor three).
* Everything in `plans/M53-iteration-5.md` §R5's table that was resumable at the halt.
