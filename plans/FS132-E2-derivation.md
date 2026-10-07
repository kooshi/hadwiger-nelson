# FS132-E2 — card 3 of FS-132: must a cyclic centre that is not a triangle exist in every measurable six-colouring?

*Ephodos, 2026-10-07 (UTC). Brief: `data/fs132/briefs/FS132-E2-card-three.md`. Plan of the milestone (its §G, §PA, §IQ, read, not
redone): `plans/FS132-six-by-the-nerve.md`. The extraction this job is asked on: `plans/FS132-E1-derivation.md` Stage 3
(C132-EXT-DISC, C132-CORES-FREE, C132-CONFINE; [hand], one mind, kernel pending). Scripts and outputs: `data/fs132/e2/`. `M` is the
release's manuscript, `/home/kooshi/source/math/preprints/The-Euclidean-plane-is-not-five-colorable-September-23-2026/build/sections/`
(read, never written).*

## Theorems this phase proved

*(Filled at each saved stage; see the stage that holds each entry.)*

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
