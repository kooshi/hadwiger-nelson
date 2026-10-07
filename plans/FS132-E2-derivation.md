# FS132-E2 — card 3 of FS-132: must a cyclic centre that is not a triangle exist in every measurable six-colouring?

*Ephodos, 2026-10-07 (UTC). Brief: `data/fs132/briefs/FS132-E2-card-three.md`. Plan of the milestone (its §G, §PA, §IQ, read, not
redone): `plans/FS132-six-by-the-nerve.md`. The extraction this job is asked on: `plans/FS132-E1-derivation.md` Stage 3
(C132-EXT-DISC, C132-CORES-FREE, C132-CONFINE; [hand], one mind, kernel pending). Scripts and outputs: `data/fs132/e2/`. `M` is the
release's manuscript, `/home/kooshi/source/math/preprints/The-Euclidean-plane-is-not-five-colorable-September-23-2026/build/sections/`
(read, never written).*

## Theorems this phase proved

All in § Stage 3 — SAVED; each [hand] or [derived], one mind, kernel pending.
- **C132-FILL** — the smoothed colouring maps a disc with finitely many centres into the label graph with triangles filled, as
  a cover of order three and mesh `1 + o(1)`, at every `k ≥ 3` — [hand]; § Argument — the filled target.
- **C132-NOESS** — with triangles filled no centre is essential; with some filled, a four-cycle's fate depends on the others —
  [hand]; § Argument — nothing stays essential.
- **C132-REL** — the cores inside a circle have classes adding up to the circle's, in the first homology of the label graph —
  [hand]; § Argument — the relation a disc imposes.
- **C132-INDEX** — a continuous three-labelled ring with supports disjoint under the rotation by `π/3` has degree `3 (mod 6)` —
  [hand]; § Argument — the degree of a three-labelled ring.
- **C132-RING-WIND** — the same for a step function with finitely many changes, no two `π/3` apart — [derived] from C132-INDEX;
  § Argument — the winding of a tame ring.
- **C132-ORBIT** — the orbit index in `{2, 3, 4}` of a three-labelled measurable ring — [hand]; § Argument — the orbit index.
- **C132-TRI-STRIP** — at an extracted triangle centre, every `k`: a one-sided strip at almost every direction carries only the
  labels outside the triangle — [hand]; § Argument — one-sided pure strips.
- **C132-SEP** — the unit chord's angle has mixed derivative `8/(3√3)` at `(1, 1)` and is not separable — [hand];
  § Argument — the unit chord's angle is not separable.
- **Not proved, stated:** **C132-RING-TAME** (stalls at the finiteness of a three-labelled ring's changes) and **C132-LONG**
  (the forcing statement; stalls at C132-RING-TAME).

## Stage 1 — SAVED: the readback, and what I expect before deriving

**The job, in my words.** The outside proof finds, in every weak measurable colouring with finitely many cyclic centres on a
disc, a centre with a label cycle and continua (C132-EXT-DISC, at every number of colours). At five every cycle length is
contradictory; at seven the honeycomb lives on triangles. The card asks whether, at six, a centre whose cycle is longer than a
triangle is forced, and proposes one frame: enlarge the target of the smoothed colouring from the complete graph on the labels to
the complex with triangles filled, and ask which centres stay essential. I am to state the claims (the target and the map; which
centres stay essential; the forcing statement), derive or stall each, and for every forcing statement say where seven escapes
and why five is consistent. The frame is the asking lane's proposal and not owed.

**Quotation check** (standing rule 3). `data/fs132/e2/readback.py` looks for every quoted line of the brief in the file its
source line names: `quotations=15 lines_matched=15 lines_mismatched=0` (`data/fs132/e2/readback.out`); with one character of each
line changed it reports fifteen mismatches. No finding about the brief.

**Read for this stage, each whole unless said:** the brief and `plans/STANDING-RULES.md`; the stub
`plans/STUB-six-by-the-nerve.md`; the plan `plans/FS132-six-by-the-nerve.md`; `plans/FS132-E1-derivation.md`;
`plans/POROS-2026-10-07-after-release.md` § 1.4; `plans/EXT-OAI2-reading.md` §§ 3.1–3.6, 4.1–4.4, 5.6; `plans/STUB-forced-pair.md`;
`plans/EXT-OAI3-review.md` § 3.2; `LEDGER.md` rows 132, 134, 137, 139 (132 and 139 as the brief quotes them); the claim list
`data/fs132/claims.md`; of the release, `M/introduction.tex:75–135`, `M/transitions.tex:1–75` (Definition 6.1, Lemma 6.2's
statement), `M/interfaces.tex:1–440` (Proposition 7.1, Lemmas 7.2–7.6 with proofs), `M/angular.tex:1–125` (Lemma 8.1 with proof,
Proposition 8.2's opening). **Not read:** `[Voronov2023]`'s PDF (its Theorems 1.1–1.3 are taken from this project's verification
record, `plans/FS106-V-verification.md` rows V-1.1, V-1.2, V-1.3, read at those three rows); `M/interfaces.tex:440–670` (Lemmas
7.7, 7.8 and the proof of Proposition 7.1 — taken from the first deriver's steps S8–S11); family 156's manuscript (the reviewer's
note only); the release's Lean.

**Registered before deriving** (after the reading above — said because a prediction made after reading is worth less; each is
scored at the report):
- **Q1.** The card's first branch as worded — "the essential centres are the cycles of length four to six and a metric cover
  statement forces one" — holds as worded: **0.10**. With triangles filled in the target no centre of any cycle length stays
  essential: **0.75**. *Decides:* whether the route runs through the filled target or stays on the graph-valued map.
- **Q2.** The forcing statement — a centre with a label cycle of length at least four in every weak measurable six-colouring
  with finitely many centres on a disc of some radius — is `derived` in this job: **0.03**; `stalls at` a named step: **0.95**;
  `refuted` by an object: **0.02**. *Decides:* what the report hands on (a theorem, a stall with the YES side's sketch, or an
  object). The asking lane's 0.35 was for its route landing, a different event.
- **Q3.** The place where six differs from seven is located at one named step, with seven's escape said in words and five's
  consistency checked: **0.80**. *Decides:* whether the stall, if it comes, is a result or only a stop.
- **Q4.** Recognition's homes are all killed and `ephodos-invention` is needed: **0.25**. *Decides:* whether Stage 2 is
  followed by an invention stage.

## Stage 2 — SAVED: recognition, and the claims stated

*`ephodos-recognition`, invoked fresh. The stall read: "two descriptions that both apply, and disagree" (the card's sides A and
B) and "a wall that describes a counterexample" (the reading's [P₆] and [L₆], false at seven under local slack). So the pass asks
what every solution carries, in the target where it can be seen.*

**For the stranger, three times.**
- *A dimension theorist.* A closed disc is mapped continuously, off small discs about finitely many points, into the complete
  graph on `k` labels, so that each connected set on which one coordinate is positive has diameter at most `1 + o(1)`. By
  Lebesgue's covering theorem some small circle about one of the points is an essential loop of the graph. *Unknown:* must some
  such loop be other than a triangle run once? **Answer from that field alone: no.** Attach the triangles: the 2-skeleton of a
  simplex is simply connected, every loop bounds, and a disc maps into a 2-complex with fibres as small as one likes (three
  sets of a cover meet at points in general position; four do not). A cycle of length four is two triangles sharing an edge
  pulled together. Nothing topological forces it; the unit distance must.
- *A combinatorial geometer who works on map colourings of the plane.* A six-coloured map with no two interior points of one
  colour at distance 1: must it have a vertex where four regions' colours meet — is a *cubic* six-map impossible? **This is a
  theorem of that field in its regular classes**: `[SokolovVoronov2025]` Corollary 1 (cubic maps with forbidden arcs need
  seven; held here almost everywhere for curved maps, row 134), `[Voronov2023]` Theorems 1.1–1.3 (a forbidden interval, or six
  closed sets on a disc of radius 3; row 132), and for segment-and-arc maps with unit arcs row 137. Its engine, as this
  project's verification records hold it (`plans/FS106-V-verification.md` rows V-1.1, V-1.2; `plans/FS110-CB-verification.md`
  § D5–D6): at a trichromatic vertex `u` the unit circle about `u` is coloured by the **complementary three colours**; that
  three-colouring has an index, which puts nine bichromatic points on the circle; walks from them end at trichromatic vertices
  of ten possible types inside the disc; eleven vertices against ten types give two of one type at distance below 2; and two
  circles coloured by the same three colours about centres at distance between 1 and 2 — the bicycle — cannot be.
- *Someone who works on graph homomorphisms and height functions.* A proper three-colouring of the graph on the circle whose
  edges join points `π/3` apart, continuous in the sense of a partition of unity. **A three-colouring has a height** (the
  universal cover of the triangle is a line; this project's G71): each step of `π/3` raises it by between one third and two
  thirds of a turn, six steps close up, so the winding number is an integer between 2 and 4 modulo 6 — and the ends are
  excluded, so it is 3 modulo 6 (C132-INDEX below). With four colours there is no height (G71, G73); with two, no continuous
  colouring at all.

**The sentence.** *"Some centre is not a triangle", at six, is the non-existence of a cubic six-colouring; in every regular
class it is Sokolov–Voronov's and Voronov's theorem, and what it runs on is the winding number of the complementary triple on
the ring of a triangle centre — a class in the fundamental group of the **unfilled** label graph.* Six differs from seven in
one subtraction: `6 − 3 = 3`, the complement of a triangle is a triangle and its colourings wind; `7 − 3 = 4` and nothing
winds; `5 − 3 = 2` and the ring is binary, which is rigid (the release's own triangle kill).

**The features, sorted.**

| feature | sort | receipt |
|---|---|---|
| the target: the label graph, or the graph with triangles filled | **determines** which invariant exists | filled, the fundamental group is trivial — no centre is essential and the ring's class dies with them (control `two-skeleton`); in the graph the ring of a tame triangle centre has class `(abc)^d`, `d ≡ 3 (mod 6)` (control `ring-degree`) |
| six labels | **splits** | consumed only as "three labels outside a triangle": the ring's target is then a circle and a degree exists. At seven the ring of a honeycomb vertex carries four labels (control `hex7-relation`: `ring-labels=[1, 4, 5, 6]`) |
| the unit distance | **determines** | consumed as: no label is positive at two points `π/3` apart on a unit circle (the rule of C132-INDEX); as the mesh bound it is consumed already by the extraction and distinguishes nothing between six and seven |
| changes of colour at `e` and at `Re` never coincide | **determines** | with it the degree is `3 (mod 6)`; without it every residue occurs, the alternating ring `a, b, a, b, a, b` with degree 0 among them (control `ring-degree`, its fault) |
| a centre's own cycle: a triangle or longer | **accompanies the topology, determines the metric question** | a four-cycle is homologous to two triangles (control `two-skeleton`: `4cycle-in-K6+012+023=True`); what tells them apart is the ring, whose pure strips carry `k − ℓ` labels |
| finitely many centres on the disc | determines the data at a centre (the first deriver's (iii)); accompanies C132-INDEX | C132-INDEX has no colouring in it |
| a map (arcs, tiles, a locally finite singular set) | **unsorted** | the regular chain consumes it at three places — finitely many bichromatic points on the ring, a walk along an interface from each, the bicycle — and no argument here runs without it; no counterexample without it is known either. This line is the stall |

**The homes.**
1. *Dimension theory with the nerve filled* (the card's frame). Name there: the canonical map to the nerve of a cover of order
   three. Its theorem (Lebesgue; Sperner–Knaster–Kuratowski–Mazurkiewicz): a cover by small sets has order at least three — and
   order three suffices. Test "the exceptions vanish": they vanish too well — the triangle and every longer cycle bound.
   **Killed for the forcing statement** on the line "essential loop": none. Kept for claims (i) and (ii).
2. *Obstruction by a map to a simplex with supports disjoint at the forbidden distance* (`[OAIMath2026]` family 156, by the
   reviewer's note only). Its first hypothesis — an open cover whose supports are disjoint at distance 1 — is false for the
   thresholded disc averages below the threshold `1/2` (two points 1 apart may both carry half of one label) and, above `1/2`,
   true of sets that no longer cover. **Killed at its first hypothesis** (it needs a forbidden interval: row 132's slack).
3. *Map colourings: the cubic theorem.* The old proof applies at once in the regular classes; it predicts the neighbours (five:
   a pair outside, binary, rigid — the release's Proposition 8.10; seven: four outside, nothing — the honeycomb). **Adopted.**
   Dictionary to the weak measurable class, line by line:

   | regular class | weak measurable class | holds? |
   |---|---|---|
   | a trichromatic vertex `u` | an extracted centre with `ℓ = 3` (C132-EXT-DISC) | yes, where the centre is isolated |
   | the unit circle about `u` is coloured by the complementary triple | a one-sided strip at almost every direction carries only the labels outside the triangle (C132-TRI-STRIP, from the release's Lemma 8.1) | **weaker**: one side only, and the side changes at up to six directions |
   | finitely many bichromatic points on the circle, changes not `π/3` apart | — | **blank** |
   | the index of the circle's three-colouring | C132-INDEX, for a continuous loop with supports disjoint under the rotation | the lemma holds; its hypothesis is the blank line above |
   | a walk from each bichromatic point along its interface to a vertex inside | the relation C132-REL: the classes of the cores inside a circle add up to the circle's class | **weaker**: a signed count in homology, no walk |
   | two vertices of one type at distance in `(1, 2)`; the bicycle | — (the release's Lemma 5.2 transports palettes between two centres; no three-label form) | **blank** |

4. *Height functions* (this project's G71). Supplies C132-INDEX and nothing about the blank lines.

**The transfer stalls at one named step**: the dictionary's first blank line. A recognition that differs from the card's: the
card proposed the filled target and expected the essential centres to be the long cycles; the home is the unfilled graph, and
the class that tells six from seven sits on the **ring of a triangle centre**, not on the loop around a long one. No
`ephodos-invention` stage follows: the homes killed (1 and 2) fail on different lines, and the collision of sides A and B is
two true statements about two targets (§ Stage 3, "The collision, read") — the premise they share, that the target is the
label graph, is earned by this recognition, not revised.

### The claims (sent to the coordinator; each entry in Stage 3 carries its statement verbatim)

*Terms.* `c` a weak measurable `k`-colouring of the plane (`[OAIMath2026]` Definition 1.2, `M/introduction.tex:83–96`); `𝓛`,
`Γ_x`, `H_i`, `Δ(K)` as in C132-EXT-DISC (`plans/FS132-E1-derivation.md` Stage 3); `p_i^ε`, `q^ε`, the threshold `0 < α < 1/k`,
the disc `D₁`, the holes, the core discs `B_{n,x}` and the map `g_n` as in that entry's argument, steps S2–S5; `𝒢` the complete
graph on the `k` labels, realized as the 1-skeleton of the simplex of probability vectors on the labels; a *palette* `P_x(e)` as
in `M/palettes.tex:49–56` (the reading § 3.1 quotes it); `R` the rotation by `π/3`.

1. **C132-FILL** (the card's (i): the target and the map). Let k ≥ 3 be an integer, X_k the union of 𝒢 with all its filled
   triangles, c a weak measurable k-colouring of the plane and D a closed disc of radius greater than 1 with 𝓛 ∩ D finite;
   then for every large n there is a continuous map from D₁ to X_k that equals g_n off the core discs and equals q^{ε_n} off
   the holes, and the connected components of the sets on which one of its coordinates is positive form an open cover of D₁ of
   multiplicity at most three whose mesh is at most 1 + o(1) as n → ∞. *Not claimed:* that the disc averages themselves fill a
   core disc inside X_k; that the cover's members avoid the unit distance; any obstruction.
2. **C132-NOESS** (the card's (ii): which centres stay essential). For k ≥ 4 every loop of 𝒢 is null-homotopic in X_k; and
   for a set 𝒯 of triangles of 𝒢 the simple four-cycle on the labels 0, 1, 2, 3 is null-homotopic in 𝒢 ∪ 𝒯 when 𝒯 holds the
   triangles 012 and 023, and is not null-homologous when 𝒯 holds the triangle 012 alone. *Not claimed:* a criterion for a
   general 𝒯; anything metric.
3. **C132-REL** (the relation a disc imposes). In the setting of C132-FILL, for a circle C in the interior of D₁ that misses
   𝓛, bounding the open disc U, and every large n, the class of g_n on C in the first integral homology of 𝒢 is the sum over
   the points x of 𝓛 in U of the classes of g_n on ∂B_{n,x}, all circles counterclockwise. *Not claimed:* the relation in the
   fundamental group; independence of n.
4. **C132-INDEX** (the invariant that tells six from seven). Let a, b, c be three labels, Θ the union of the edges ab, bc, ca
   of the simplex of probability vectors, and φ a continuous map from the unit circle S to Θ such that for every e in S no
   label has a positive coordinate both at φ(e) and at φ(Re); then the degree of φ, for the orientation a → b → c of Θ, is
   congruent to 3 modulo 6. *Not claimed:* anything for a measurable ring, for changes that coincide at e and Re, for four
   labels, or that any colouring's ring satisfies the hypothesis.
5. **C132-TRI-STRIP** (what a triangle centre's ring carries, every k). Let k ≥ 3, c a weak measurable k-colouring of the
   plane, and x, ρ, labels i_0, i_1, i_2, continua K_j and directions v_j satisfying clauses (1), (2), (3) of C132-EXT-DISC
   with ℓ = 3; let N be the set of the other k − 3 labels; then for every unit vector e perpendicular to none of the v_j
   there are an arc A about e and a width w > 0 such that almost every point x + r f with f in A and 1 < r < 1 + w has its
   label in N if e·v_j > 0 for at least two j, and almost every point x + r f with f in A and 1 − w < r < 1 has its label in N
   if e·v_j < 0 for at least two j; and P_x(e) meets N for almost every e. *Not claimed:* both sides at once; palettes inside
   N; anything for ℓ ≥ 4; that the class is inhabited at six.
6. **C132-LONG** (the card's (iii): the forcing statement; the disc form of the claim list's C132-M-CV). There is a radius
   R₀ > 1 such that, for every weak measurable six-colouring of the plane and every closed disc D of radius R₀ in which its
   cyclic centres are finitely many, the conclusion of C132-EXT-DISC holds at some point of D with ℓ ≥ 4. *Not claimed:* its
   truth or its falsity; any value of the chromatic number; anything when the centres are infinite in every such disc.
   C132-M-CV follows from it (finiteness in every closed disc gives the hypothesis on one), and stalls with it.

## Stage 3 — SAVED: the claims to their verdicts

*Six claims were fixed by the coordinator from Stage 2 (`data/fs132/claims.md`, third dated line). Four entries are added here:
C132-RING-WIND, C132-ORBIT and C132-SEP, relay-results derived on the way, and **C132-RING-TAME**, the stalled step written as a
statement of its own at the coordinator's word (the same day): what must be true of one circle at one centre for the winding
number to exist and be 3 modulo 6.*

### The entries

derivation: C132-FILL
  statement: Let k ≥ 3 be an integer, X_k the union of 𝒢 with all its filled triangles, c a weak measurable k-colouring of the plane and D a closed disc of radius greater than 1 with 𝓛 ∩ D finite; then for every large n there is a continuous map from D₁ to X_k that equals g_n off the core discs and equals q^{ε_n} off the holes, and the connected components of the sets on which one of its coordinates is positive form an open cover of D₁ of multiplicity at most three whose mesh is at most 1 + o(1) as n → ∞
  uses only: the construction of C132-EXT-DISC's argument, steps S4–S5 (the threshold map, the holes, one core disc per centre, the map g_n); that the 2-skeleton of a simplex is simply connected; the mesh argument of its step S7, which reads of the map only that it equals q^{ε_n} off the holes and of the holes only that their total radius tends to 0
  not claimed: that the disc averages themselves fill a core disc inside X_k (four or more labels may exceed the threshold there); that the members of the cover avoid the unit distance (two points 1 apart may both carry a label above the threshold α); any obstruction — the statement is that this map exists whenever the colouring does, at every k, so no covering theorem of order three forbids it
  argument: § Argument — the filled target
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7, the hexagonal seven-colouring with circumradius 2/5 — near a vertex only its three labels are present, so q^ε itself maps into X_7 and is the filling; the cover is the honeycomb's tiles thickened by O(ε)
  prior art: partly: the map into the graph is `[OAIMath2026]` Lemma 7.4; the classical order-three statement is Lebesgue's covering theorem (`[HurewiczWallman1948]` Thm IV 2, held); the filled form for a weak measurable colouring not found in print by the milestone's gate (`plans/FS132-six-by-the-nerve.md` §PA), which this job did not extend
  handoff: de Bruijn — with C132-EXT-DISC's module: the extension of each core loop over its disc into the 2-skeleton, from simple connectivity of the 2-skeleton of a simplex; the cover's mesh bound is the release's argument for `no_large_positive_sequence` read with a 2-complex target

derivation: C132-NOESS
  statement: For k ≥ 4 every loop of 𝒢 is null-homotopic in X_k; and for a set 𝒯 of triangles of 𝒢 the simple four-cycle on the labels 0, 1, 2, 3 is null-homotopic in 𝒢 ∪ 𝒯 when 𝒯 holds the triangles 012 and 023, and is not null-homologous when 𝒯 holds the triangle 012 alone
  uses only: that the fundamental group of a complex is that of its 2-skeleton and a simplex is contractible; that a four-cycle is the composite of two triangles sharing a diagonal; that the boundary of the one triangle 012 has coefficient 0 on the edge 23
  not claimed: a criterion for a general 𝒯; anything metric; that a centre with a long cycle is ever essential or ever inessential in the complex whose triangles are the ones a given colouring realizes — that depends on the triangles realized at other centres, and no statement here controls them
  argument: § Argument — nothing stays essential
  verdict: derived
  grade: hand
  minds: 1
  model: k = 6 and 𝒯 the twenty triangles — the first homology of X_6 has rank 0 (control `two-skeleton`)
  prior art: known: textbook (cellular approximation; `[Hatcher2002]` § 1.2 and Proposition 1.26, recalled, not read)
  handoff: none — a relay-result; its first clause is step F1 of C132-FILL, which crosses

derivation: C132-REL
  statement: In the setting of C132-FILL, for a circle C in the interior of D₁ that misses 𝓛, bounding the open disc U, and every large n, the class of g_n on C in the first integral homology of 𝒢 is the sum over the points x of 𝓛 in U of the classes of g_n on ∂B_{n,x}, all circles counterclockwise
  uses only: that g_n is continuous on D₁ minus the open core discs (step S5); that the core discs shrink to their centres; that the boundary of a compact planar domain is null-homologous in it
  not claimed: the relation in the fundamental group (a product of conjugates along paths this statement does not fix); that either side is independent of n; that a core's class is non-zero; anything when 𝓛 ∩ D is infinite
  argument: § Argument — the relation a disc imposes
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7, the hexagonal seven-colouring, C the unit circle about the vertex (0, 2/5): the circle's walk of labels 6, 5, 4, 1, 6, 4, 5, 1, 4 as an integral 1-chain is the sum of the triangle chains of the thirteen vertices inside it (control `hex7-relation`)
  prior art: known: Stokes' theorem for a map of a planar domain to a graph; `[OAIMath2026]` uses it in free-homotopy form in Lemma 7.8 (by the first deriver's step S8)
  handoff: de Bruijn — as a statement about signed edge-crossing counts of g_n along C and along the core circles; the planner chooses between homology and a winding-count form

derivation: C132-INDEX
  statement: Let a, b, c be three labels, Θ the union of the edges ab, bc, ca of the simplex of probability vectors, and φ a continuous map from the unit circle S to Θ such that for every e in S no label has a positive coordinate both at φ(e) and at φ(Re); then the degree of φ, for the orientation a → b → c of Θ, is congruent to 3 modulo 6
  uses only: continuity of φ and its lift to the line; that six rotations by π/3 compose to the identity; that a point of Θ whose support is disjoint from the support of a vertex lies on the closed opposite edge, and from the support of an interior point of an edge is the opposite vertex
  not claimed: anything for a ring that is only measurable; for a loop whose changes at e and at Re may coincide (six sectors a, b, c, a, b, c of angle π/3 have degree 2, and a, b, a, b, a, b degree 0: the control's fault); for four labels (the target is then a graph of rank three, with no degree); that the ring of any colouring satisfies the hypothesis
  argument: § Argument — the degree of a three-labelled ring
  verdict: derived
  grade: hand
  minds: 1
  model: nine arcs of 2π/9 labelled a, b, c, a, b, c, a, b, c, joined linearly on short intervals about the nine boundaries — degree 3; in the control's discretization the sequence 0, 0, 1, 1, 2, 2 three times on 18 positions
  prior art: partly: the index of a three-coloured circle and its nine bichromatic points are `[Voronov2023]`'s and `[SokolovVoronov2025]`'s (by this project's records `plans/FS106-V-verification.md` row V-1.2 and `plans/FS110-CB-verification.md` § D5; neither paper read by this job); that a three-colouring's slope lies between one third and two thirds is this project's G71 (FS73-T22); the congruence modulo 6 in this form not searched
  handoff: de Bruijn — a lemma about continuous maps of the circle with no colouring in it: the lift, the six-step sum, the two excluded ends

derivation: C132-RING-WIND
  statement: let N be a set of three labels, Π a measurable function from the unit circle S to the non-empty subsets of N with Π(e) ∩ Π(Re) = ∅ for almost every e, and J the set of the directions e having no arc about e on which Π is almost everywhere equal to one set; if J is finite and no two of its points are at angle π/3, then on each arc of S ∖ J the function Π is almost everywhere one singleton or one pair, two consecutive arcs carry subsets of one pair, and the closed walk they make around the triangle on N has winding number congruent to 3 modulo 6
  uses only: C132-INDEX, applied to the loop that sits at a vertex on a singleton arc, at an edge's midpoint on a pair arc, and moves along one edge across each point of J; the disjointness under R on sets of positive measure; finiteness of J and J ∩ R(J) = ∅, both used to make the loop's supports disjoint under R
  not claimed: the conclusion when two points of J are π/3 apart (the fault of control `ring-degree`); when J is infinite; for a set N of four labels; that the pure-side palette of any colouring has a finite J
  argument: § Argument — the winding of a tame ring
  verdict: derived
  grade: derived from: C132-INDEX
  minds: 1
  model: N = {a, b, c}, Π the singleton a, b, c, a, b, c, a, b, c on nine arcs of 2π/9 — J is the nine boundaries, J + π/3 falls on the arcs' midpoints, the winding number is 3
  prior art: partly: as C132-INDEX
  handoff: de Bruijn — with C132-INDEX, as its form for step functions

derivation: C132-ORBIT
  statement: let N be a set of three labels and Π a measurable function from the unit circle S to the non-empty subsets of N with Π(e) ∩ Π(Re) = ∅ for almost every e; then for almost every e each of the six sets Π(e), Π(Re), …, Π(R⁵e) is a singleton or a pair, no two consecutive ones are pairs, and with a vertex of the triangle on N at coordinates 0, 2, 4 modulo 6 and a pair at the midpoint between its two vertices, the six steps from each set to the next, each taken in the interval [2, 4], add up to 12, 18 or 24
  uses only: that two disjoint non-empty subsets of a three-element set are two distinct singletons or a singleton and the pair of the other two; that the six steps add up to a multiple of 6
  not claimed: that the sum is the same for almost every e; that it is 18; anything for four labels, where two disjoint pairs exist and no step is defined
  argument: § Argument — the orbit index
  verdict: derived
  grade: hand
  minds: 1
  model: the six sectors a, b, c, a, b, c of angle π/3 — every step is 2 and the sum is 12; the nine arcs of C132-RING-WIND's model — three steps of 2 and three of 4, sum 18
  prior art: owed
  handoff: none — a relay-result: the measurable shadow of the winding number, used to state C132-RING-TAME's alternatives; it crosses only if C132-RING-TAME is taken up

derivation: C132-TRI-STRIP
  statement: Let k ≥ 3, c a weak measurable k-colouring of the plane, and x, ρ, labels i_0, i_1, i_2, continua K_j and directions v_j satisfying clauses (1), (2), (3) of C132-EXT-DISC with ℓ = 3; let N be the set of the other k − 3 labels; then for every unit vector e perpendicular to none of the v_j there are an arc A about e and a width w > 0 such that almost every point x + r f with f in A and 1 < r < 1 + w has its label in N if e·v_j > 0 for at least two j, and almost every point x + r f with f in A and 1 − w < r < 1 has its label in N if e·v_j < 0 for at least two j; and P_x(e) meets N for almost every e
  uses only: clause (3) and x ∈ K_j; the points of K_j tending to x with directions tending to v_j; that a set missing H_i meets the class of label i in a null set; that two edges of a triangle have all three vertices among their endpoints; for the last clause the one-sided traces of `[OAIMath2026]` Lemma 8.1 (`M/angular.tex:73–95`, read with its proof, which reads no count of labels)
  not claimed: purity of both sides at one direction; that P_x(e) lies inside N; anything at the at most six directions perpendicular to a v_j; anything for ℓ ≥ 4 (a four-cycle has four of its sixteen sign patterns with no pure side: the fault of control `tri-strips`); that the class is inhabited at six
  argument: § Argument — one-sided pure strips
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7, the hexagonal seven-colouring at the vertex (0, 2/5) with its three edges: N = {1, 4, 5, 6}, and there both sides are pure at every direction (control `hex7-relation`: own-on-rings empty at radii 0.98, 1, 1.02)
  prior art: partly: `[OAIMath2026]` Lemma 8.1 is the strip statement for the sets O(e), I(e) at five labels; its use at a triangle is the opening of its Proposition 8.10 (by `plans/EXT-OAI2-reading.md` § 3.1; `M/angular.tex` past line 125 not read by this job); the statement at every k with the majority rule not found in print by the milestone's gate
  handoff: de Bruijn — from the release's strip lemma (`AngularBoundary.lean`, `BoundaryTrace.lean`, typed at every k by the reading § 4.2 row 14) with a case split on three signs

derivation: C132-SEP
  statement: the angle Φ(r, s) = arccos((r² + s² − 1)/(2rs)) at the common centre between a point of the circle of radius r and a point of the circle of radius s at distance 1 from it has mixed second derivative 8/(3√3) at r = s = 1, so on no neighbourhood of (1, 1) is Φ the sum of a function of r and a function of s
  uses only: differentiation; that a sum f(r) + g(s) of twice differentiable functions has mixed derivative 0, and for arbitrary f, g that Φ(r, s) − Φ(r, s′) − Φ(r′, s) + Φ(r′, s′) would vanish identically, which the non-zero mixed derivative forbids
  not claimed: any statement about colourings — in particular not that two changes of colour π/3 apart are impossible in a strip of positive width; that follows from this only for changes along two curves that cross the whole strip and are matched in both directions, a regularity no weak measurable colouring is known to have
  argument: § Argument — the unit chord's angle is not separable
  verdict: derived
  grade: hand
  minds: 1
  model: r = s = 1 gives Φ = π/3, the angle of the equilateral triangle; the first derivatives there are −1/√3 each (control `chord-angle`)
  prior art: owed
  handoff: none — a relay-result for the YES side's sketch; one computation

derivation: C132-RING-TAME
  statement: for every weak measurable six-colouring of the plane and every x, ρ, labels i_0, i_1, i_2, continua K_j and directions v_j satisfying clauses (1), (2), (3) of C132-EXT-DISC with ℓ = 3, with N the set of the three other labels and Π_x(e) ⊂ N the set of the labels of positive weight, at the direction e, in the weak-* limits of the colouring's samples on circles about x whose radii tend to 1 from the side on which C132-TRI-STRIP's strip at e carries only N, the set J_x of the directions e having no arc about e on which Π_x is almost everywhere equal to one set is finite, and no two of its points are at angle π/3
  uses only: nothing — it is posed, as the hypothesis under which C132-RING-WIND gives the ring of a triangle centre a winding number congruent to 3 modulo 6
  not claimed: that it holds — for a class containing a six-colouring with local slack along such a ring it fails (G95's stripes, planted in the labels of N, make J_x infinite), so the class in which it can be true is a normal form, which is not chosen here; that it suffices for C132-LONG (the count of centres inside the unit circle needs the smoothed colouring on the circle itself, and the two last steps of the regular chain are beyond it); that its second clause can hold at a centre whose three directions v_j make angles of 2π/3, where the six directions at which the pure side changes are π/3 apart
  argument: § The stalled step, as a statement of its own
  verdict: stalls at: the first clause, finiteness of J_x — the release's strip rigidity (its Lemma 8.6) is for two labels on a strip and makes a binary ring locally constant off six directions; for three labels on a strip no rigidity is held, by the release or here, and two of them may alternate at every scale
  grade: hand
  minds: 1
  model: none at six — no six-colouring is known; at seven the hexagonal colouring's ring at a vertex has J_x of nine points, no two π/3 apart, with Π_x valued in a set of four labels (control `hex7-relation`), so it satisfies both clauses and lies outside the statement only by its count of labels
  prior art: partly: in the map classes the first clause is the definition of a map and the second is Sokolov–Voronov's transversality (`plans/FS110-CB-verification.md` § D5, "(i)/(ii) under transversality"); for weak measurable colourings the two-label form is `[OAIMath2026]` Lemmas 8.6–8.7; the three-label form not found by the milestone's gate
  handoff: Poros — not derived; stalls at the finiteness of the changes of a three-labelled ring; the smallest open form is § The stalled step, as a statement of its own, items (a)–(c)

derivation: C132-LONG
  statement: There is a radius R₀ > 1 such that, for every weak measurable six-colouring of the plane and every closed disc D of radius R₀ in which its cyclic centres are finitely many, the conclusion of C132-EXT-DISC holds at some point of D with ℓ ≥ 4
  uses only: nothing is carried; the route attempted is the regular classes' cubic theorem, read step by step against the weak class in § Where the forcing statement stalls
  not claimed: its truth or its falsity; any value of the chromatic number of the plane; anything when the centres are infinite in every such disc; that a centre whose transition graph holds a cycle of length four or more is returned by the extraction with such a cycle (the converse of C132-EXT-DISC's clause (5), open in the first deriver's record)
  argument: § Where the forcing statement stalls
  verdict: stalls at: the winding number of the three outside labels on the unit circle about an extracted triangle centre — C132-RING-TAME, whose first clause no held statement gives a weak measurable colouring; behind it two further steps of the regular chain have no weak form (two centres of one type at distance between 1 and 2, and the bicycle)
  grade: hand
  minds: 1
  model: none — at six no colouring is known; at seven the statement's analogue is false (the hexagonal colouring has triangle centres only), and at five its class is empty (`[OAIMath2026]` Theorem 1.4)
  prior art: partly: in the regular classes it is `[SokolovVoronov2025]` Corollary 1 (held almost everywhere for curved maps, row 134), `[Voronov2023]` Theorems 1.1–1.3 (row 132) and this project's FS114-CV-EXISTS (row 137); for weak measurable colourings `[OAIMath2026]` says "The remaining alternatives six and seven are unresolved." (`M/introduction.tex:70`, as the stub quotes it)
  handoff: Poros — not derived; stalls at C132-RING-TAME; C132-M-CV stalls with it

control: two-skeleton
  of: C132-NOESS — the homological shadow: the first homology of 𝒢 with all triangles filled has rank 0 for k = 4, …, 7; the four-cycle 0-1-2-3 bounds with the triangles 012, 023 and not with 012 alone
  run: python3 ../data/fs132/e2/ring_checks.py skeleton
  expect: k=4:H1=0 k=5:H1=0 k=6:H1=0 k=7:H1=0 4cycle-in-K6+012+023=True 4cycle-in-K6+012=False
  fault: python3 ../data/fs132/e2/ring_checks.py skeleton --fault

control: ring-degree
  of: C132-INDEX — every piecewise-linear loop on 18, 24 and 30 positions with supports disjoint under the rotation, enumerated: its degree modulo 6
  run: python3 ../data/fs132/e2/ring_checks.py index3
  expect: N=18:sequences=12,d-mod-6=[3] N=24:sequences=480,d-mod-6=[3] N=30:sequences=11520,d-mod-6=[3]
  fault: python3 ../data/fs132/e2/ring_checks.py index3 --fault

control: tri-strips
  of: C132-TRI-STRIP — the eight sign patterns of a triangle's three edges: in none do both sides keep a label of the triangle
  run: python3 ../data/fs132/e2/ring_checks.py strips
  expect: cycle-length=3 patterns=8 neither-side-pure=0
  fault: python3 ../data/fs132/e2/ring_checks.py strips --fault

control: hex7-relation
  of: C132-REL — at seven, on the hexagonal colouring: the unit circle about a vertex, its labels, its walk, its changes, and the sum of the triangle chains of the vertices inside it
  run: python3 ../data/fs132/e2/ring_checks.py hexrel
  expect: own-labels=[0, 2, 3] ring-labels=[1, 4, 5, 6] own-on-rings=[[], [], []] crossings=9 ring-walk=654164514 two-jumps-60-apart=False vertices-inside=13 relation-holds=True
  fault: python3 ../data/fs132/e2/ring_checks.py hexrel --fault

control: chord-angle
  of: C132-SEP — the mixed second derivative of the unit chord's angle at r = s = 1, exactly
  run: python3 ../data/fs132/e2/ring_checks.py mixed
  expect: mixed-derivative-at-(1,1)=8*sqrt(3)/9 first-derivatives=-sqrt(3)/3
  fault: python3 ../data/fs132/e2/ring_checks.py mixed --fault

### Argument — the filled target

**F1.** `X_k` is the 2-skeleton of the simplex on `k ≥ 3` labels. The simplex is convex, so contractible; a loop in a cell
complex deforms into the 1-skeleton and a homotopy of loops into the 2-skeleton (cellular approximation), so the inclusion of
the 2-skeleton is an isomorphism on fundamental groups. Hence `π₁(X_k) = 1`. (For `k = 3`, `X_3` is the simplex.)
**F2.** Fix `n` large as in the first deriver's step S5: one core disc per point of `𝓛 ∩ D₁`, closures pairwise disjoint and
inside the interior of `D₁`; `g_n` continuous from `D₁` minus the open core discs to `𝒢`, equal to `q^{ε_n}` off the holes.
Each core loop `g_n|∂B_{n,x}` is a loop in `𝒢 ⊂ X_k`, null-homotopic in `X_k` by F1, so it extends continuously over the
closed core disc with values in `X_k`. Pasting the finitely many extensions to `g_n` gives `g̃_n : D₁ → X_k`.
**F3.** A point of `X_k` lies in a closed triangle and has at most three positive coordinates; `D₁` is locally path
connected, so the components of the relatively open sets `{(g̃_n)_i > 0}` are open: an open cover of multiplicity at most three.
**F4.** The mesh. Step S7's argument is used word for word: a path in `{(g̃_n)_i > 0}` joining points more than `1 + c₀`
apart has its endpoints moved to the boundary of a hole if they lie in one (a core disc is a hole); the limits `a, b` have
`|a − b| > 1` and `a ∈ H_i`; for `z` near `a` outside the union `E_n` of the unit annuli about the holes, a point of the path
at distance 1 from `z` lies outside every closed hole, where `g̃_n = q^{ε_n}` and so `p_i^{ε_n} > α`; hence
`p_i^{ε_n}(z) ≤ 1 − α`, and `α|A_i ∩ U| → 0`, against `a ∈ H_i`. The argument reads that the map equals `q^{ε_n}` off the
holes, that the holes' total radius tends to 0, and S2 — never that the map is graph-valued, nor how the core discs were
filled. ∎

### Argument — nothing stays essential

For `k ≥ 4` the first clause is F1. If `𝒯` holds 012 and 023, the loop `0 → 1 → 2 → 3 → 0` is homotopic in `𝒢 ∪ 𝒯` to the
composite of `0 → 1 → 2 → 0` and `0 → 2 → 3 → 0`, each of which bounds its triangle. If `𝒯 = {012}`, the boundaries of
2-chains are the multiples of `∂(012)`, which has coefficient 0 on the edge 23, and the four-cycle's 1-chain has coefficient 1
there: it is not a boundary (control `two-skeleton`). ∎

*What this says about the card's (ii).* With every triangle filled, no centre is essential, whatever its cycle. With only
the triangles a colouring realizes filled, a four-cycle centre is inessential as soon as two triangles through one of its
diagonals occur — anywhere in the disc. "Essential" is then a property of the pair (centre, the set of triangle types of the
whole colouring), not of the centre. A four-colour meeting point and two three-colour meeting points joined by a short
interface are the same thing to any target built from labels; only the unit distance tells them apart.

### Argument — the relation a disc imposes

`C ∩ 𝓛 = ∅` and the core discs shrink to their centres, so for `n` large each closed core disc lies in `U` or outside its
closure. `Σ_n = Ū ∖ ⋃_{x ∈ 𝓛 ∩ U} B_{n,x}` is a compact planar domain bounded by `C` and the core circles, and `g_n` is
continuous on it (S5). In `H_1(Σ_n; ℤ)` the class of `C` is the sum of the classes of the core circles, all counterclockwise
(the domain's fundamental chain has boundary `C − Σ ∂B_{n,x}`). Apply `(g_n)_*`. ∎

### Argument — the degree of a three-labelled ring

Give `Θ` the coordinate `t ∈ ℝ/6ℤ` with `a, b, c` at `0, 2, 4` and the edges linear. Let `u ∈ Θ` at coordinate `t`. If
`t = 2i` (a vertex), a point whose support is disjoint from that label lies on the closed opposite edge, at a coordinate in
`[2i + 2, 2i + 4]`. If `2i < t < 2i + 2` (two labels positive), the only point with disjoint support is the opposite vertex,
at `2i + 4`, and `2i + 4 − t ∈ (2, 4)`. So `δ(e) = t(φ(Re)) − t(φ(e))` lies in `[2, 4]` modulo 6 for every `e`, and it equals
2 or 4 only where `φ(e)` is a vertex.
Lift `φ` to `φ̃ : ℝ → ℝ`, `φ̃(θ + 2π) = φ̃(θ) + 6d`, `d` the degree. `δ̃(θ) = φ̃(θ + π/3) − φ̃(θ)` is continuous with values in
the disjoint union of the intervals `[2 + 6t, 4 + 6t]`, so in one of them. Summing six steps,
`6d = Σ_{j=0}^{5} δ̃(θ + jπ/3) ∈ [12 + 36t, 24 + 36t]`, so `d ∈ {2 + 6t, 3 + 6t, 4 + 6t}`.
If `d = 2 + 6t`, six numbers each at least `2 + 6t` add up to `6(2 + 6t)`, so `δ̃ ≡ 2 + 6t`; then `φ(e)` is a vertex for every
`e`, a continuous map into three points is constant, and `φ(Re) = φ(e)` shares its label: a contradiction. The same at
`d = 4 + 6t`. Hence `d = 3 + 6t`. ∎
*Two remarks.* (1) `|d| ≥ 3`: the loop runs at least three times round the triangle and crosses at least nine edge midpoints —
Sokolov–Voronov's nine circle points. (2) With two labels there is no such map at all: `Θ` is one edge, an interior point of
it forbids every point, so `φ` takes vertex values only, is constant, and fails at `Re`.

### Argument — the winding of a tame ring

On a component `A` of `S ∖ J` every point has an arc on which `Π` is almost everywhere one set; overlapping arcs share a set
of positive measure, so `Π` is almost everywhere one set `σ_A` on `A`. `σ_A ≠ N`, or `Π(Re)` would be empty on a set of
positive measure. At a point `e₀ ∈ J` between arcs carrying `σ ≠ σ′`: `Re₀ ∉ J` lies in an arc with value `τ`, and
disjointness under `R` just before and just after `e₀` gives `τ ∩ (σ ∪ σ′) = ∅`; so `σ ∪ σ′` has at most two labels, `τ` is
the singleton of the third label `c`, and `σ, σ′` are two different non-empty subsets of the pair `{a, b}`. In the same way,
at `R^{−1}e₀ ∉ J`, the value is `{c}`. Let `φ` sit at the vertex on a singleton arc and at the edge's midpoint on a pair arc,
and move linearly along the edge `ab` on a short interval `I` about each `e₀ ∈ J`, the intervals so short that `R(I)` and
`R^{−1}(I)` meet no other interval (possible: `J` is finite and `J ∩ R(J) = ∅`). Then `φ` is continuous, and its supports are
disjoint under `R` at every `e`: on `I` the support is in `{a, b}` and `φ(Re) = c`; on `R^{−1}(I)` it is `c` and `φ(Re)` is
on the edge `ab`; elsewhere both points sit on arcs whose sets are disjoint. C132-INDEX gives degree `3 (mod 6)`, and the
degree of `φ` is the winding number of the walk of the sets `σ_A`. Moreover `Σ_j (δ̃(R^j e) − 6t) = 18` for every `e`, so the
orbit sum of C132-ORBIT is 18 for almost every `e`. ∎

### Argument — the orbit index

For almost every `e` the six sets are non-empty and each is disjoint from the next. Two disjoint non-empty subsets of a
three-element set are two different singletons, or a singleton and the pair of the two other labels; so none is `N`, and no
two consecutive ones are pairs. With vertices at `0, 2, 4` and a pair at its midpoint (`1, 3, 5`), the step from a vertex to
another vertex is 2 or 4, from a vertex to the opposite pair's midpoint 3, from a pair's midpoint to the opposite vertex 3:
each in `[2, 4]`. The six steps return to the start, so their sum is a multiple of 6 in `[12, 24]`. ∎

### Argument — one-sided pure strips

Let `e·v_j > 0`. Take `q = x + s w ∈ K_j` with `w` near `v_j` and `s > 0` small (clause (2)). For a unit vector `f` and
`r > 0`, `|x + r f − q|² = r² + s² − 2rs f·w`, which at `r = 1`, `f = e` is `1 + s² − 2s e·w < 1` once `s < 2 e·w`. By
continuity there are an arc `A` about `e` and `w₁ > 0` with `|x + r f − q| < 1 < r = |x + r f − x|` for `f ∈ A`,
`1 < r < 1 + w₁`: these points lie in `Δ(K_j)` (`x, q ∈ K_j`), which misses `H_{i_j}` and `H_{i_{j+1}}` (clause (3)), so
almost every one of them has a label other than `i_j, i_{j+1}`. If `e·v_j < 0` the same identity gives
`|x + r f − q| > 1 > r` for `r` slightly below 1: the inner strip. Of the three signs two agree; two edges of a triangle have
all three of its labels among their endpoints (control `tri-strips`); intersecting the two arcs and widths, the strip on that
side carries only `N` almost everywhere. For the last clause: by the proof of the release's Lemma 8.1 (`M/angular.tex:73–95`)
circles about `x` with radii tending to 1 from the pure side give a weak-* limit whose coordinates outside `N` vanish on the
arc and whose coordinates sum to 1, and its positive coordinates belong to `P_x`. ∎

### Argument — the unit chord's angle is not separable

With `u = (r² + s² − 1)/(2rs)`: `u_r = (r² − s² + 1)/(2r²s)`, `u_s = (s² − r² + 1)/(2rs²)`, `u_{rs} = −(r² + s² + 1)/(2r²s²)`;
at `(1, 1)`: `u = 1/2`, `u_r = u_s = 1/2`, `u_{rs} = −3/2`. `Φ = arccos u` has
`Φ_{rs} = −u_{rs}/√(1 − u²) − u u_r u_s/(1 − u²)^{3/2} = √3 − 1/(3√3) = 8/(3√3)` there (control `chord-angle`, exact). If
`Φ(r, s) = f(r) + g(s)` near `(1, 1)` the second difference `Φ(r, s) − Φ(r, s′) − Φ(r′, s) + Φ(r′, s′)` would vanish; it is
`Φ_{rs}(1, 1)(r − r′)(s − s′) + o(|r − r′||s − s′|)`, not zero for small distinct values. ∎

### Where the forcing statement stalls

*The route: the regular classes' proof that a cubic six-colouring does not exist, taken one step at a time against a weak
measurable six-colouring `c` whose cyclic centres on a disc `D` are finitely many and all returned as triangles.*

| step of the regular chain | in the weak class | status |
|---|---|---|
| R1. a trichromatic vertex `u` exists | an extracted centre with `ℓ = 3` (C132-EXT-DISC) | held, one mind |
| R2. the unit circle about `u` is coloured by the three complementary colours | at almost every direction a one-sided strip carries only `N` (C132-TRI-STRIP); every palette meets `N` | **derived here**, one side |
| R3. that three-colouring has an index, 3 modulo 6: nine bichromatic points | C132-INDEX and C132-RING-WIND, given the ring is tame | the lemmas **derived here**; their hypothesis is **C132-RING-TAME — the stall** |
| R4. from each of the nine points an interface leads into the disc to a vertex whose type holds two of the three colours | C132-REL: the cores inside the circle have classes adding up to `d` times the triangle on `N` | the relation **derived here**; to use it the smoothed colouring on the circle itself must be the tame loop (both sides pure near the circle), which is more than C132-RING-TAME |
| R5. eleven vertices against ten types: two of one type at distance below 2 | — | no weak form |
| R6. two circles coloured by the same three colours, centres between 1 and 2 apart: the bicycle | — (the release's Lemma 5.2 transports palettes between two centres and its Lemma 5.5 separates two centres binary for one pair; neither has a three-label form) | no weak form |

So the chain is held through R2, stalls at R3, and has two further steps with nothing under them. In the segment-and-arc map
class every step is held (rows 134, 137), which is the same statement as: **a six-colouring that lives on triangles alone is
not such a map.**

**The two controls every forcing statement must pass.**
- *Seven.* The hexagonal colouring has triangle centres only, so the chain must fail there, and it fails at R2 → R3, in these
  words: *the ring of a triangle centre carries the labels outside the triangle; at seven they are four, and four labels have
  no winding number.* Measured: about the vertex `(0, 2/5)` the unit circle carries the labels 1, 4, 5, 6, its walk is
  6, 5, 4, 1, 6, 4, 5, 1, 4 — a closed walk in the complete graph on four labels that is not a power of a triangle — and both
  of its sides are pure (control `hex7-relation`). C132-FILL, C132-REL and C132-TRI-STRIP all hold at seven and are true of
  the honeycomb; C132-INDEX has no four-label statement to hold.
- *Five.* No weak measurable five-colouring exists, so C132-LONG's analogue is vacuous and consistent. Inside the release's
  proof the same place reads: two labels outside a triangle; by remark (2) under C132-INDEX no tame ring exists with two
  labels, and the release kills the non-tame one — six alternating sectors — by rigidity and the Moser spindle, not by an
  index. Six is the one count at which the outside labels wind.

### The stalled step, as a statement of its own

**The statement is C132-RING-TAME**: one circle, one centre. Its objects, each defined with no hypothesis at an extracted
triangle centre `x` of a weak measurable six-colouring:
- the **pure side** at a direction `e` perpendicular to no `v_j`: outside if two of the `e·v_j` are positive, inside if two
  are negative (C132-TRI-STRIP). It is opposite at `−e`. It changes at two or at six of the directions perpendicular to the
  `v_j`: at six when the `v_j` are pairwise non-parallel and no open half-plane holds the three of them, at two otherwise
  (when a half-plane holds them the three signs pass through `+ + +`).
- the **pure-side palette** `Π_x(e) ⊂ N` (an essential union over the one-sided traces, defined up to angular null sets, as
  the release's palette is): non-empty for almost every `e` (a one-sided trace's coordinates sum to 1 and vanish
  outside `N`), and `Π_x(e) ∩ Π_x(Re) = ∅` for almost every `e`, because `Π_x ⊂ P_x` and `P_x(e) ∩ P_x(Re) = ∅` (the
  release's Corollary 5.4, stated in its Lean at every `k` as `palette_sixty_disjoint` by the reading § 4.2 row 3; **taken at
  that statement, not read by me**).
- so C132-ORBIT applies: **every extracted triangle centre of every weak measurable six-colouring carries an orbit index** —
  for almost every `e` the six pure-side palettes on the orbit of `e` under `R` have step sum 12, 18 or 24, call it
  `6·W_x(e)`, `W_x(e) ∈ {2, 3, 4}`. This needs no tameness. ([hand], one mind, over Corollary 5.4 at its statement.)

**What the two clauses buy** (C132-RING-WIND): if `J_x` is finite the ring has a winding number; if also no two points of
`J_x` are `π/3` apart, it is `3 (mod 6)` and `W_x = 3` almost everywhere. **Neither clause can be dropped**: with `J_x`
infinite there is no integer; with `J_x` finite and changes `π/3` apart the winding number can be 2 (six sectors
`a, b, c, a, b, c`: `W_x = 2`) or 0 (`a, b, a, b, a, b`: `W_x = 3`, so `W_x` alone does not give the winding number) —
the fault of control `ring-degree` produces every residue.

**The two controls.**
- *Where the honeycomb at seven sits:* inside both clauses. At a vertex `J_x` is nine directions, no two `π/3` apart, the
  palette is a singleton on each arc (control `hex7-relation`: `crossings=9`, `two-jumps-60-apart=False`). What it lacks is
  the premise: `Π_x` takes values in four labels, where two disjoint pairs exist, a step between two labels has no sense
  "forward" or "back", and neither C132-ORBIT nor C132-INDEX has a form. Seven escapes by its count of labels, not by any
  wildness.
- *What the release's rigidity gives at five:* the first clause and the failure of the second. With two labels outside,
  `Π_x(Re)` is the other label wherever `Π_x(e)` is one, so every change at `e` is a change at `Re`: `J_x = R(J_x)`
  necessarily. The release's Lemmas 8.6–8.7 (two colours on an open strip are locally one; as the reading § 3.1 gives them,
  "locally constant off one six-point orbit") make `J_x` one orbit of six directions: finite. No index is taken; the kill is
  the open region left to the triangle's three labels, which holds a Moser spindle. **So at five the first clause is a
  theorem and the second is false; at six the first clause is the missing theorem and the second can hold.**

**The smallest open forms** (for the asking lane; each about one circle at one centre):
- **(a) three labels on a strip.** A weak measurable colouring carries only the labels of a three-element set `N` on a
  one-sided strip along an arc of a unit circle and on the strips along the two arcs `π/3` on either side. Is the palette
  along the arc almost everywhere locally constant off finitely many directions? At two labels: yes (Lemma 8.6). At three
  labels this is clause 1, and it is false for some colouring wherever local slack exists along the strip (G95), so it is a
  statement for a normal form (honest saturated colourings, rows 140, 143) or it is false at six.
- **(b) the changes of side.** At the two or six directions where the pure side changes, does `Π_x` change, and may the
  centre's own labels reach the ring there? When the `v_j` make angles `2π/3` those directions are `π/3` apart and clause 2
  fails unless `Π_x` passes through them unchanged. In this project's map vocabulary these are the tips at the ring's change
  points (G91).
- **(c) the orbit index.** Is `W_x` almost everywhere constant on the ring, and is `W_x = 2` or `4` — the ring that turns
  with the rotation, `Π_x(Re)` the next label after `Π_x(e)` — excluded? For changes along curves across a strip of positive
  width, C132-SEP excludes a pair of changes `π/3` apart that is matched in both directions (the alternating kind) and not
  one matched in one direction (the turning kind); one mind, not entered as a claim about colourings.

### The collision, read (the card's two sides)

Side A: "at six colours a point may need three positive coordinates, a 2-complex, where the disc is no obstruction". Side B:
"the cover theorem … has no colour in it and says that *no* colouring, at any `k`, has a graph-valued approximant on a large
disc. Five enters in the two statements that would make one exist". **Both are true, of two targets.** B is about the graph:
C132-CORES-FREE, at every `k`. A is about the 2-complex: C132-FILL, at every `k ≥ 3` — and that is where A's sentence
misplaces five: the 2-complex target has no obstruction at five either; the cover's order is not where five, or six, enters.
The premise the asking lane found under both — that the target is fixed as the label graph — is **earned, not revised**:
enlarging the target erases the one class that tells six from seven (the ring's), together with every centre's. No invention
stage was run; the statement of its closing is here.

### The YES side's first sketch (what a six-colouring that lives on triangles alone must look like at the stall)

*Each line says what is derived and what is only read off the stall. None is a construction.*
1. **It is not a segment-and-arc map** (rows 134, 137, held), and it has no forbidden interval of distances (row 132).
2. **At every one of its centres** `x`, of type `T`: the complementary triple `N` fills a one-sided strip at almost every
   direction, on the side two of the three interfaces point to (C132-TRI-STRIP); the ring carries an orbit index `W_x` with
   values in `{2, 3, 4}` (C132-ORBIT with Corollary 5.4).
3. **Its rings cannot all be tame.** A tame ring winds `3 (mod 6)` times (C132-RING-WIND); in every class where the regular
   chain's last three steps hold this ends in a contradiction. So the colouring must spend its freedom on the ring, in one of
   the ways the weak class allows and a map does not:
   - *infinitely many changes of the three outside labels along the ring* — two of them alternating at scales tending to 0
     inside a pure strip (clause 1 failing). Nothing held forbids it at three labels; at two the release does.
   - *a ring that turns with the rotation*: `W_x = 2` or `4`, `Π_x(Re)` the next label after `Π_x(e)` at almost every `e` —
     six sectors `a, b, c, a, b, c` of angle `π/3` are the simplest. Every change at `e` is then a change at `Re`, the
     winding number where it exists is `2` or `4 (mod 6)`, C132-INDEX does not exclude it, and it is the three-label sibling
     of the release's six alternating sectors. Where its changes sit — at the directions where the pure side changes, or
     inside a pure strip — is not derived.
   - *a binary ring*: only two of the three outside labels on the ring, alternating; then the region `x + e + v`, `e` and `v`
     in sectors of the two labels, is left to four labels — the triangle's and the third outside one — and its exclusion
     would need a unit-distance graph that is not four-colourable placed in that region (not derived here; the same kind of
     placement the reading § 3.5 asks for a four-cycle centre).
4. **Or it has no isolated centres to speak of**: centres accumulating wherever the extraction would be applied, which is the
   first deriver's card 2 and outside every statement here.

### Footholds at six (statements about every weak measurable six-colouring; each at its grade, one mind)

1. Its smoothed classes map every disc with finitely many centres into the label graph with triangles filled, as a cover of
   order three and mesh `1 + o(1)` (C132-FILL): *the disc alone forbids nothing at six.*
2. Inside any circle that misses the centres, the cores' classes add up to the circle's (C132-REL).
3. At every extracted triangle centre the three outside labels fill a one-sided strip at almost every direction and meet
   every palette (C132-TRI-STRIP), and the ring carries an orbit index in `{2, 3, 4}` (C132-ORBIT, over the release's
   Corollary 5.4 at its statement).
4. If such a ring is tame it winds `3 (mod 6)` times (C132-RING-WIND).
*Not claimed by any of these:* a value of the chromatic number; that a six-colouring exists; that a cycle longer than a
triangle is ever returned; that any ring is tame.

### What was dropped, and why

The card's route — fill the triangles and ask which centres stay essential — is answered (C132-FILL, C132-NOESS) and then
dropped as a route to the forcing statement: it removes the invariant. The brief's other suggestions: *through a count* —
not taken as a tile count (G86 stands), and present only as the signed count C132-REL; *through the relation a disc imposes
among the centres' classes* — taken, in homology (C132-REL), applied to the unit circle about a centre; *through the unit
distance directly* — taken: C132-INDEX is the unit distance on one circle. Family 156's method was read at the reviewer's note
only and set aside at its first hypothesis (an open cover with supports disjoint at the forbidden distance).

### Predictions scored

- **Q1** (0.10 the first branch as worded; 0.75 nothing stays essential): the first branch **not met**; "no centre stays
  essential" **met** (C132-NOESS).
- **Q2** (0.03 derived, 0.95 stalls, 0.02 refuted): **stalls** — met at the likeliest value.
- **Q3** (0.80 the difference located at one named step, with both controls): **met** — R2 → R3, the count of labels outside
  a triangle.
- **Q4** (0.25 invention needed): **not needed**.
- The asking lane's 0.35 for card 3's first branch: **not met as worded** — the triangle fills, and so does everything else;
  what is route R's shape is the all-triangles exclusion, and its engine is a winding number, not a cover statement of order
  three.
