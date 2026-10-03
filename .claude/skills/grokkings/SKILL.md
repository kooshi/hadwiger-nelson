---
name: grokkings
description: lean-dir's grokkings, the working theory of the Hadwiger–Nelson hunt — entries G1 to G87, each with its status, its Do and its killing test or what it forbids. Preloaded at launch into the poros, ephodos, ephodos-verifier and debruijn agents through their skills field; the coordinator and the Clerk read an entry here by its number instead of loading the file.
---

# Grokkings — the working theory of Hadwiger–Nelson (the entries)

*Moved verbatim from `CLAUDE.md` § Grokkings on 2026-09-28, at Kooshi's word, so that only the lanes that reason from the theory load
it. The section's rules — every entry's status, demotion with its refutation recorded and never deletion, stable identifiers — and the
theory in one paragraph stay in `CLAUDE.md` § Grokkings, which every agent loads. Retired entries keep a titled pointer here and their
text in `plans/GROKKINGS-RETIRED.md`; second and later instances are in `plans/GROKKING-INSTANCES.md`. Keryx is this file's only
writer.*

* **G1 — The field wall. [kernel]** The Moser twist is a seam-group word (ρσ² = −1), the seam group's
  countable closures are exactly 4-chromatic, and all of K² is 4-chromatic (Theorem B). A 5-forcer's
  coordinates must break the 2-adic wall when their field is multiquadratic or of degree at most 11 — for a multiquadratic
  field, contain an odd square class ≡ 7 (mod 8), such as √5, √7 or √247 (G35); in general they need only avoid a place above 2
  ramified in F(i) or inert of norm ≤ 32, and given MR a field whose wall stands can hold one (G35's K·E₇). The certified witnesses' √5 and √7 are instances, not the criterion. *Do: before any solver on a candidate
  over a multiquadratic field, read its square classes for an odd one ≡ 7 (mod 8) (G35's congruence); none means a residue
  colouring at a prime above 2 (Theorem B's, over K) four-colours the object and the null is free — never run it; over any other
  field, read its places above 2 (G35's Do). Nothing kills it; it kills every five-colour design in a wall-standing field that is
  multiquadratic or of degree at most 11.*
* **G2 — Construction grammar. [measured]** Rings of vertices about a point ⟺ that point was a rotation
  centre of the construction: de Grey's graph has two ring-hearts (its spindle centres), Heule's one. Mirror
  defects are the chirality of a rotated copy. *Do: when you see rings about a point, name it a rotation centre and look
  for the copy; when you design, expect one ring-heart per rotation used and read mirror defects as the copy's chirality.
  Killing test: a witness with rings about a point that was no rotation centre of its construction.*
* **G3 — Radially crystal, angularly detuned. [measured]** Every exact radius of the three certified
  witnesses about their centres lies in ℚ(√33); the new-field content lives in the angles. This is the
  hexagonal fabric's form. *Do: read a witness's new field in its angles, never its radii; when you build, the rotation is
  the parameter — enumerate every in-field detune (G7's family) and screen the base against each, rather than asking the one
  detune a base's norms happen to realise. Killing test: a certified witness with a centre radius outside ℚ(√33).*
* **G4 — One shell vocabulary. [measured]** Every known 5-forcer stands on one inventory of ~30–44 seam radii; 25 of de Grey's 29 per-centre rings are Heule-510 rings.
  *Do: check a new forcer's shells against the inventory first and expect nothing new from them — a fourth witness's radii
  are a lookup, not a discovery. Killing test: a five-forcer over K whose shells lie mostly outside the inventory.*
* **G5 — Ownership factorization. [measured]** De Grey's graph is two congruent 29-ring single-centre
  systems; as a graph it is a 1-sum of two 791-vertex halves at vertex 14 plus the one cross edge (11, 802).
  *Do: when an object is a 1-sum, test the halves apart and expect the join to carry only its edge — a compulsion of the
  whole is a compulsion of a half or it is the cross edge's (and then G40 says the copy absorbs). Killing test: a compulsion
  of the 1581 that neither 791-half carries.*
* **G6 — The hexagram is fabric, not seed. [measured]** Heule-510's centre carries the certified hexagram,
  but the hexagram plus any single detuned copy stays 4-chromatic: containment, not causation. *Do: when a base contains a
  certified object, do not read it as the seed — one detuned copy over any fabric predicts a four-colourable arena before the
  run, and containment (checked in seconds on the base half alone) proves nothing. Killing test: the hexagram plus a single
  detuned copy refusing four colours.*
* **G7 — Detuning, read arithmetically. [measured + theorem]** Every forcing rotation is a small detune off a
  crystal angle (ρ₁₅ 1.045° off 30°, the Moser twist 3.557° off 30°), but the angle is the metric shadow: a
  spindle at distance d adjoins √(4d² − 1) and forces the next colour only if that radicand breaks the
  relevant wall, which every even d does for the 2-adic one. Haugland's heptagonal construction closes with
  the same ρ₁₅ = (7 + i√15)/8, because the radicand depends only on the forced distance.
  **The "detunes" are one family, and the family IS the spindle — which is prior art, stated in words.**
  `2d²(1 − cos θ) = 1` gives `cos θ = (2n − 1)/(2n)` with `n = d²`, the **only** rational cosine putting the
  spindle distance at integer `n` (`plans/M63-phaseH2-the-family.md` §3), with `sin θ = √(4n−1)/(2n)`: **`n = 3`
  IS the Moser twist** (`cos θ = 5/6`, radicand 11) and **`n = 4` IS ρ₁₅** (`cos θ = 7/8`, radicand 15). The family
  is a **ladder, each rung failing for the reason the next fixes**: `n = 3`'s radicand lies in `K`, so the Moser
  spindle can never reach five; `n = 4` breaks the wall but its field is 5-sealed, so the record can never reach
  six; `n = 16` (`ρ₆₃`, radicand `63 → 7`) is the cheapest member that is wall-breaking **and** 6-open.
  **Prior art, and it covers more than the angle:** `[Polymath16wikiMain]` (2018) states the family as
  `ω_t = exp(i·arccos(1 − 1/(2t)))` **and attaches the spindle reading in words** (*"the apex angle of a
  `√t, √t, 1` isosceles triangle"*); `[PartsOdd2022]` §3's `m₁ = m₂`, `r = 1` slice is the same family. **Ours:** the
  radicand form `√(4n−1)` as the adjoined quantity, the field screen over it, 6-openness as the selection criterion,
  and dropping the restriction to Loeschian `t` (the wiki lists *"particularly the Loeschian numbers 1, 3, 4, 7, 9,
  12, …"*; **2 is not Loeschian** — a second reason, beside `plans/M63-phaseH2-prior-art.md` §PA.4's census-image
  failure, that `n = 2` was never examined). *Do: read every rotation as its `n`, its radicand `4n−1` and the field that
  radicand lands in, and screen it by the four gates (row 64: free circle; `sin θ ∉ K`; the wall; 11's residue degree) before
  any base is built — the gates decide in seconds what a solver decides in hours; enumerate the family's in-field members,
  never the one rotation a base happens to realise. Killing test: a five-forcer whose rotation is no spindle — `cos θ` not
  of the form `(2n−1)/(2n)` — or a member whose radicand keeps the wall and still forces five.*
* **G8 — The direction group. [measured]** ⟨ζ₁₂, σ, √ρ₁₅ = (√15 + i)/4, √ρ₆₃ = (3√7 + i)/8⟩ closes all 67 of
  the 1581's edge directions at exponent ≤ 6. `[Polymath16wiki]` derived the Moser ring's unit group ⟨ζ₆, η⟩
  with η = (√33 + i√3)/6 = iσ⁻¹ and η² = ρ — the index-2 subgroup {ζ₁₂^a σ^b : a + b even} of ours. **Open,
  an afternoon with `tools/anatomy.py`:** are Heule-510/553's six out-of-group direction classes words in
  α = (√5 + i√11)/4, a wiki generator our set lacks? *Do: factor an object's edge directions as words in the group before
  anything else — an out-of-group class names a missing generator — and build fabric as a group's bounded-length words, never
  as free directions. Killing test: a direction of a K(√5,√7)-object that is a word in no extension of these generators by α.*
* **G9 — Rigidity lives only at the forcing level. [measured]** The 791-point forcer (the 1581's
  centrosymmetric core V ∩ −V) forces exactly six pairs at four colours: the axis pair at distance 4 and five
  **antipodal** pairs at 4/√3 — forced central symmetry on the radius-2/√3 circle. Closing the antipodal
  compulsion needs the √183 spindle, **outside de Grey's field** (K(√183) = K(√61) is itself 6-open). The hexagram chunk at four colours and the 1581 at five have no forced pair and no
  virtual edge. *Do: hunt compulsions one rung below the top — a core asked at χ−1 colours — and expect the top rung empty;
  over K the forced distances are 4 and 4/√3 and the shape includes antipodal pairs on a circle: list those targets before a
  search, and check the closing spindle's field for openness before closing. Killing test: a forced pair or virtual edge at
  the top rung of a held object.*
* **G10 — The forcing is distributed. [measured, sampled]** Random single edge deletions make the 1581
  4-colourable, and neither enrichment nor designed stacks localize the forcing. The exhaustive criticality
  sweep is unrun and no edge's witness is on disk; vertices 11, 802 and 14 are critical structurally (the
  1-sum; `data/e4-critical-vertices.json`) and a sweep should exclude them. "Minimal" should mean least
  geometry, not fewest vertices. *Do: expect no organ — minimise geometry, not vertices; exclude 11, 802 and 14 from any
  criticality sweep, and run the exhaustive sweep before claiming edge-criticality. Killing test: an enrichment or stack that
  localises the forcing to a small subgraph carrying it alone.*
* **G11 — The Moser subgraph is not necessary for 5. [external, unverified here]** Voronov et al. (2021,
  64,513 vertices) and Haugland (arXiv:2608.04542; 2,131 vertices, float arithmetic and uncertified SAT) give
  Moser-free 5-chromatic graphs, by landing a forced pair at a spindle-able distance and spindling. *Do: when the field
  lacks √11, take their route — land a forced pair at a spindle-able distance, then spindle — and treat "the spindle is
  necessary" as refuted. Killing test: a verification here finding either graph five-colourable.*
* **G12 — The quadrature law. [hand (M31-T1), confirmed at 26 exact censuses; kernel for the ρ₁₅ instance (row 28)]** A detuned copy RX of seam material couples
  to X only along anchor-collinear pairs (W an even half-spindle word) or anchor-perpendicular pairs (W odd),
  with radii on one conic; words mixing √ρ₁₅ and √ρ₆₃ couple nowhere. A single detune's colour pressure is one thin conic, which is why 5-forcers
  are built from forced pairs. *Do: rank rotations by cross-edge density on their conic, never by count; expect one detune to
  press along one thin conic, so pressure comes from a forced pair or from two rotated copies (de Grey's two centres); never
  expect mixed √ρ₁₅/√ρ₆₃ words to couple. Killing test: a single detune whose cross edges leave its conic, or a mixed word
  that couples.*
* **G13 — The fan ladder. [kernel + measured]** Colour steps happen by confinement at a centre
  (`fan_iff_coverage`): two circles are 3-colourable and their centre forces a fourth; Heule-510's centre is
  fanned at four colours by the ambient web, which its own two-circle system provably cannot deliver. Fans
  are not special to centres, and coverage is a k-set property invisible to pair sweeps. The ladder's other
  face is slack: a fan gap is exactly the failure of coverage at level k−1 (`exists_fanGap_iff_not_coverAtLeast`),
  and one gap in a target colouring frees every pair above it (row 66). *Do: when a pair sweep reads zero, ask the k-set
  question — does every colouring cover N(p) ∪ Q at some centre — and when a target colouring has a gap, expect every pair
  above it free without asking. Nothing kills the iff; it kills pair sweeps as evidence about fans.*
* **G14 — Width without degree does not force. [measured + derivation]** Same-word copies at unit-separated
  anchors couple through an O(n) translation matching, and at separation 1/√3 through nothing. A matching is
  1-regular and carries no colour pressure, even composed into forced-rainbow triangles. *Do: before an arena is built,
  look at what its cross edges close — a matching-shaped cross set predicts the null; rank first the rotations whose cross
  edges close cycles through both halves. Killing test: a forcer whose only inter-copy edges form a matching.*
* **G15 — Pigeonhole × kill. [measured constructive half; universality a reading]** Every known 5-forcing
  argument composes a disjunctive class-level compulsion on fabric ("every 4-colouring puts some forbidden
  pattern somewhere") with a thin kill web refuting each placement; instance meters cannot see the
  disjunction. The composition builds 5-chromatic objects by design (row 31), and `[Heule2019]` §6.2
  describes Heule's graphs this way. In the finite lab it is **five of five**: every clique-free 1-minimal
  cell-family core (23, 28, 53, 66, 117 vertices) factors, with Act One a monochromatic pair on a small
  non-edge class. Open: whether every χ ≥ 5 argument must factor so — the one registered falsifier, M43's
  non-factoring fine tail, was itself withdrawn (a G21 instance), so universality has never been tested
  against a counterexample here. *Do: design five as a class-level disjunction plus a kill web, and ask the class question
  first — does every 4-colouring of this fabric put a monochromatic pair on class C? — because a pair meter cannot see it.
  Killing test of universality: a χ ≥ 5 argument on a finite graph that does not factor, never yet met.*
* **G16 — The distance-2 pigeonhole. [kernel carriers + measured]** Theorem B's colouring identifies every pair at
  positive-valuation distance — 2 lies in the prime above 2 (row 59) — so seam fabric of seam depth ≥ 2, or of radial extent
  past a fabric shell (r² = 2 − √33/9 on de Grey's fabric), cannot 4-colour without a monochromatic distance-2 pair: on such
  fabric the pigeonhole is free, and every kill of it needs a wall-breaking root (ρ₁₅ adjoins √15). The carrier is 122
  vertices; the √3-pair sibling concentrates to nine, because √3 is the one distance whose equilateral triangle has unit
  circumradius — but it is an **assembly product**: only the full 1581 carries it, onset at the √21 shell where
  cross-system material enters, and Heule's shrinking discarded it. **The converse on the Moser lattice is a theorem** (MASCOT-T6,
  Coxeter, 2026-09-08; surfaced by FS-71): a four-colouring of the rank-4 lattice with no monochromatic √3-pair IS one of Theorem B's
  two residue colourings — the doubling quotient is `𝔽₄ × 𝔽₄`, the two primes above 2, and `K₄ × K₄` is uniquely colourable — so on
  K-fabric the √3-pigeonhole is the only escape from the residue colouring. *Do: on fabric a residue colouring identifies, expect the
  monochromatic pair at every positive-valuation distance without asking, and spend the search on the kill — `separated` asks
  at those distances on wall-broken material. Nothing kills the pigeonhole; it kills every in-field kill.*
* **G17 — Globality lives only at the top rung. [measured]** The fan onset (χ ≥ 5 itself) arrives at the
  last vertex; every sub-rung compulsion measured has a small carrier (3-cover at 49 vertices, the distance-2
  pigeonhole at 122). *Do: ask sub-rung compulsions on modest fabric first (carriers of 9 to 122) and expect the top rung
  only at the last vertex — a whole-object ask measures the top rung alone. Killing test: a sub-rung compulsion whose
  minimal carrier is the whole object.*
* **G18 — Composition sees what search cannot. [measured]** Monolithic CDCL capped on the 4,749-vertex union
  while the cubes a kernel pigeonhole covers refuted in minutes each. Certify components, compose in the
  kernel, and pin palettes (6.5–160× measured). *Do: when monolithic CDCL caps, split by a kernel-covered pigeonhole, pin
  palettes, certify the components and compose in the kernel. Killing test: a split whose cubes each run slower than the
  monolith.*
* **G19 — 5-tight fabric. [measured + theorem]** No pattern class fires at five colours on the swept population
  (52/4/0 over 7 objects × 8 classes, M35 — not the whole inventory), and inside K none can (Theorem B); 5-tight fabric needs a wall-breaking root in the fabric itself. A
  five-colour avoider for any class proves χ(ℝ²) ≤ 5; a six-colour avoider bounds only 7-forcers. *Do: run the class sweep
  only on fabric holding a wall-breaking root — inside K the zero is Theorem B's and free — and read an avoider by what it
  bounds. Nothing kills the K half; a class firing at five on wall-broken fabric is the finding the sweep exists for.*
* **G20 — Brick colourings. [hand (M36-T1: the coset-7 family is forced boundary-tight) + kernel (the certificate) + measured]** A brick 7-colouring of the plane exists and is
  boundary-tight by force (cell diagonal exactly 1), so every strict-separation certificate refuses the whole
  family. Under the exact certificate, brick colourings reach seven and refuse six and five. *Do: use the exact certificate,
  never strict separation, and read one brick refusal as the whole family's. Killing test: a brick six-colouring under the
  exact certificate.*
* **G21 — A negative measures its enumeration. [method]** A search run against a sufficient-but-not-necessary
  check measures the check; a verdict — negative, positive count, or speedup — is a statement about its
  enumeration and conditioning, and both belong in the headline sentence — scope lines inside an artifact do not survive into
  summaries unless they are in the headline. When a sweep refuses, the first question is not "what does this say about the
  objects" but "is my acceptance test the exact condition, or a sufficient one?" — because a conservative test converts a
  *finding* into a *measurement of my own instrument*, silently and with the registered-prediction discipline fully satisfied.
  At registration, say whether the acceptance test is also necessary — and if it is only sufficient, what a refusal therefore
  cannot mean. Point every new instrument at a known positive before believing its zero;
  assert on the written artifact, never on the list that produced it; a control the instrument cannot see is
  not a control. **And where a phase's output is eliminations, its defects all point one way**: four in one phase
  (M63 phase G, 2026-09-11) — an edge law that drops an edge, an over-merged equivalence key, a float sign test inside
  an exact verdict, a truncated input with no producer — every one silent and every one biased toward making the
  survey look productive, because a missing edge yields an easier graph, a colouring, and a "sound elimination". So
  an elimination carries an exact quantifier or it is not one, and where a phase also has a positive product, **the
  count of eliminations is the outcome to be least satisfied with**. **The mechanism is selection**: a defect whose
  result displeases is investigated within the hour; one whose result pleases is kept — five independent defects in
  three phases of M63 were every one flattering. **Audit the results you like at the same rate as the ones you do
  not**, and when an artifact and its written record disagree, suspect the newest thing in the file first. **The census's own
  instance (FS-71, row 77):** of four hand claims that had no proof on disk, the one that was wrong (M37's general-lattice bound)
  was the one stated as a bare number — a conclusion with no chain is the shape to re-derive first, and the corpus under-graded
  its hand derivations four times for every over-grade. **And a periodic search measures its period cap** (FS-73, twice in one
  milestone, row 79): ℚ(√167)'s `L3e1c94c6` read as having no periodic three-colouring because the search stopped at `N = 20` —
  its least period is 23 — and the survivor `Ld14c588b` colours linearly with period index 1,080, past `N ≤ 30` and circular
  `N ≤ 120`. **Read a solver's colouring before searching its periods:** one Fourier transform of FS-61's 1.47 M-point colouring
  showed a single character of amplitude 0.74 that named the period 23 at once. FS-81's three, and the rest: `plans/GROKKING-INSTANCES.md` §G21. *Do: when a search, sweep or census returns a zero — or a count, a speedup, an elimination — ask first whether the acceptance test is the exact
  condition or only a sufficient one, and put the answer and the enumeration's bounds (its period cap, radius or generator image) into the
  headline sentence; before believing a new instrument's zero, point it at a known positive at the scale of the question; check the
  written artifact, not the in-memory list behind it; and audit a result you like at the rate you audit one you do not. Killing test:
  a zero reported with its enumeration in the headline that readers still took for a fact about the objects (the rule is not enough), or
  a run of milestones in which no headline scope ever changed a decision (the rule is ceremony).*
* **G22 — Where a six-colouring cannot live. [kernel + prior art]** No colouring constant on a triangular
  lattice's cells uses six colours (rows 34–35), and no polygonal colouring does (`[SokolovVoronov2025]`). A
  six-colouring, if one exists, has non-polygonal classes finer than half the unit distance. Coset colourings
  need seven because 2, 5, 6 are not of the form a² + ab + b². *Do: never search for a six-colouring among cell-constant or
  polygonal colourings; a candidate's classes must be non-polygonal and finer than 1/2. Nothing kills the kernel half; the
  polygonal half stands or falls with `[SokolovVoronov2025]`.*
* **G23 — Refining is not a route down. [kernel + measured]** The cell family's requirement is not monotone
  in scale; the classical scale is a local optimum (dual form: `[deGreyParts2022]`). *Do: expect no colour saved by refining
  the scale; "refine toward six" is closed. Killing test: a scale in the cell family needing fewer than seven colours.*
* **G24 — The gap law. [kernel forcing half + measured]** Below the classical window the cell family needs ≥ 7
  at every scale (`[Voronov2023]`, `[SokolovVoronov2025]`) while ω falls to 3–5, the certified
  Hoffman/spectral bracket to ≈ 4.1 (3.56 at p = 1/7) and the fractional relaxation only to χ_f ≤ 48/7 at
  G\* (α(12×12) = 21) — **the step to seven is integrality**, not a low relaxation: the exactly certified
  χ_f are 130/23 at the 23-core, 501/74 at the 53-core and ≈ 4.83796 at the 117-core. The plane's own
  pathology (ω = 3, relaxations below χ, χ = 7) in finite
  kernel-checkable objects, the smallest the 23-vertex core with χ = 7 at ω = 4. Open: the deep pocket's
  χ ≥ 8 in the kernel; a relaxation that sees the gap. At five the relation inverts: row 123's five is a fractional bound rounded up, the count entering at one pigeonhole (row 129, G60). *Do: when a relaxation reads far below χ on a plane-like object,
  expect integrality, not a low bound — certify χ on the exact object and spend no relaxation on the gap. Killing test: a
  relaxation that certifies seven on a gap-band core (the open item; it would be a finding).*
* **G25 — The forcing ladder is recursive. [reading]** For the objects held, χ ≥ 4 is holonomy of
  rainbow-clique propagation (triangle-free routes also exist: Wormald 1979, O'Donnell 1999) and χ ≥ 5 a
  regional pigeonhole whose kills are the previous level's forcer one field up; so a 6-forcer's kills
  default to 5-forcer grade (~10⁵–10⁶ vertices, composition only) unless a shortcut shape fires. *Do: price a 6-forcer's
  kills at 5-forcer grade and name the shortcut shape before spending on anything cheaper. Killing test: a 6-forcer whose
  kills are cheaper than a 5-forcer's; per shape, `plans/SHAPES-OF-SIX.md` §3.*
* **G26 — The 6-forcer reduction. [kernel]** `hexShell_plane` puts a monochromatic pair at √3 or 2 in every
  colouring with fewer than seven colours, so χ(ℝ²) ≥ k + 1 follows from k-colour virtual edges at √3 AND at
  2 — never either alone (row 43); at six colours that is χ ≥ 7. Over {1, 2} the diameters are already edges
  and one five-colour √3 gadget gives χ(ℝ²; {1,2}) ≥ 6 (row 61). Over any field where 11 is usable neither
  five-colour gadget exists (row 55): the gadgets' field must be 6-open. With `[ExooIsmailescu2019]`'s 426-vertex {1, 2}
  graph as host, one five-colour virtual edge at distance 2 gives χ(ℝ²) ≥ 6 (GPT Astra, G55) — M49's descent replaced its 892
  length-2 edges one at a time; the ρ₆₃ arena has none (H4's sweep). *Do: aim every six-gadget hunt at one five-colour
  virtual edge at distance 2 (or at √3 over {1, 2}) in a 6-open field — over an 11-usable field the gadget cannot exist, so
  do not ask there. Nothing kills it; it kills every six-gadget design over a sealed field.*
* **G27 — Hidden arithmetic symmetry. [measured]** The Galois flip √3,√5,√11 ↦ −√3,−√5,−√11 is an automorphism
  of the 1581, which has no plane self-isometry; its Klein four-group orbit yields three new 5-chromatic
  witnesses. Forced equivariance under non-geometric automorphisms is an unused compulsion vocabulary. *Do: before any SAT
  ask over a multiquadratic field, test each Galois flip for automorphism and break the symmetry it gives; read a witness's
  Galois orbit as free witnesses and the quotient as a finder's instance. Killing test of its value: a Galois-broken ask no
  faster than the unbroken one.*
* **G28 — The fine-tail forcing factors. [measured]** The p = 1/7 stage carries 7 triple-encoded virtual
  edges (51 on its critical stage), at offset norms 27, 28, 31 — none among the six smallest non-edge
  classes, which is why a six-class sweep reads zero. Act Two exists there. **Demotion record:** as minted at M43 this entry claimed the opposite — "the fine-tail forcing does NOT factor: pigeonhole × kill is not universal; zero virtual edges at k = 6" — from six anchored asks on the R = 8 stage; M45 re-asked 9,636 pairs on the identical stage (fingerprint `9d9599be0db64677`) and found the seven, so the claim measured its acceptance set, not the object (G21's second instance).
  *Do: forcing sits at offset norms outside the smallest classes — sweep every non-edge class, never the six smallest, and
  when a class sweep reads zero, say which classes it swept. Killing test: a full-class re-ask on the fingerprinted stage
  finding no virtual edge.*
* **G29 — The cell family is a dial, and it is closed. [kernel + measured]** As the scale p → 0 the cell
  family's limit is the unit-distance problem, and its value is 7 on the whole open ray. By the limit lemma
  (row 41) the divergence of the critical size N(p) is necessary for χ(ℝ²) ≤ 6; in the family the edge defect
  falls like p while the size grows like p^(−1.75), so it supplies no bounded family either — closed both
  ways. Compare our measured refuting radius (1.02–1.38) with `[Voronov2023]` Thm 1.3's radius-3 disc. *Do: spend nothing
  on the cell family in either direction. Killing test: a scale with χ < 7, or a bounded refuting family whose defect tends
  to zero.*
* **G30 — Measurement generates; derivation kills. [method]** Retired to `plans/GROKKINGS-RETIRED.md`; carried by the Ephodos and Poros cores (derive rather than measure; name the discipline), the search ban (§ Toolchain), `.claude/agents/ephodos.md` § A derivation job (computation only as a control) and §PA item 2 (this entry's ladder of disciplines).
* **G31 — No unit-distance object we hold, built or found, carries a pair compulsion at its top rung. [kernel on the
  sealed objects (row 66) and for the 1581's arity bracket; measured, complete at arity 2, on the 6-open ones]** **On
  sealed objects the arity-2 emptiness is a theorem**: Heule-510's `Forces ↔ =` and `Separated ↔ Adj` at five colours
  and its arity floor ≥ 3 are kernel, and hold for every unit-distance graph over any 5-sealed multiquadratic field
  ⊇ K, because the sealing plane's fan gap frees every pair above it. **On 6-open objects it stays a
  measurement, unexplained.** The `ρ₆₃` arena — produced, in a 6-open field where row 55's bar does not apply — has
  **0 forced pairs of 1,307,266,278 and 0 virtual edges of 1,306,721,748**, certified by 4,480 exhibited
  five-colourings with no solver UNSAT; Heule-510 and Heule-553 return 0 and 0. Its compulsion budget is 66 of
  544,530 edges (36 off-diagonal once G52's free diagonal is removed) — rank candidate bases on that, never on circle
  count. Open: arity 3, swept only on 163 interface vertices, 337 candidates standing. No filter can help on a 6-open
  object: a field is 5-sealed exactly when some usable prime's plane is 5-colourable, which IS the residue filter's
  hypothesis. `Forces` is monotone upward in the graph (`Forcer.Forces.mono`), so refuting a pair in a subgraph says
  nothing about the whole. De Grey's 1581 at five colours has no forced pair (forcing at χ allows ≤ 2 critical
  vertices, and this 1-sum has 3), no virtual edge, and no compulsion at arity 3 or at arity 4 inside a
  neighbourhood, so its arity floor is 4 or 5; its gen-1 closure adds nothing. A χ ≥ 6 gadget must be constructed.
  Unswept: general 4-subsets, other witnesses. External null: `[Heule2019]`'s graphs up to 100,000 vertices were all
  5-colourable. *Do: never extract from a held witness — construct; on a sealed object the arity-2 zero is a theorem and
  is not run; on a 6-open object rank candidate bases by compulsion budget, never by circle count, and ask arity 3 on the
  standing candidates before any new arity-2 sweep. Killing test: a pair compulsion at the top rung of any held
  unit-distance object.*
* **G32 — The two-distance dial. [kernel + measured]** A pair forced equal at k colours is a
  (k+1)-chromatic graph with one non-unit edge, so μ(d) — the fewest d-edges of a non-5-colourable
  {1, d}-graph — is a dial whose value 1 is χ(ℝ²) ≥ 6, read by adding unit material to a forcer. Kills are
  coverage compulsions at points outside the object and are context-dependent. μ ≥ 3 inside K (G36); μ = 1
  is impossible in any 5-sealed field. *Do: on wall-broken fabric ask the `{1, d}` distance-graph question
  (`tools/twodist.py`, `tools/killengine.py`) before any pair sweep — μ(d) = 1 is a forced pair, a small μ is the pigeonhole
  form with its kill count — and read the dial as unit material is added; in K or any 5-sealed field expect μ ≥ 3 and μ ≠ 1
  without asking. Nothing kills the sealed half; a `{1, d}` graph with one d-edge refusing k colours on 6-open fabric is
  the finding the dial reads.*
* **G33 — Batches compose; growth compounds. [measured]** A halo designed against a whole batch's separating
  colourings composes removals by construction; committed material's own partner lattice re-opens refusers;
  the cull (dropping jointly redundant cheats) needs no geometry. Reading: depth-one descent self-accelerates
  until width-shaped stalls bind. *Do: grow toward a forced pair by counterexample-guided growth — add the depth-one points
  that kill each separating colouring, cull, iterate — instead of a fixed ball, and expect self-acceleration until a width
  stall. Killing test of the reading: a descent whose per-wave kills fall before any width stall binds.*
* **G34 — The field is the selection. [measured + theorem]** Every committed descent point lies in K, because
  every kept glue point is a parent plus a Moser-lattice unit vector; in-field material is 1.0% of the
  depth-1 pool, essentially the points with ≥ 3 object neighbours. By Theorem B it can never do the last
  kill. *Do: use in-field points for intermediate kills only; expect no in-field endgame and commit the out-of-field
  adjunction deliberately (G37). Nothing kills it (Theorem B); it kills every in-field endgame.*
* **G35 — The wall is 2-adic. [kernel over subrings; field level gated]** For a real number field F, a
  conjugation-fixed prime 𝔭 of F(i) gives χ(F²) ≤ N(𝔭); one above 2 exists iff −1 is not a square in some
  completion above 2 — of norm 2 or 4 when F is multiquadratic, any power of 2 in general. One ramified in F(i)/F gives
  χ(F²) ≤ 2, and one inert there, over a place of norm Q, gives the target U_Q, four-colourable exactly when Q ≤ 32 (G56, row 123);
  so a standing wall four-colours F² over a multiquadratic field and below degree 12, and not in general: K·E₇, E₇ the septic
  subfield of ℚ(ζ₂₉), keeps its wall at two places inert of norm 128, and given MR its plane needs five (`plans/WORKFLOW3-TC1-theory-corrections.md`
  TC1-STANDING-FOUR, TC1-STANDING-FIVE). *Demotion record: this clause read "(norm 2 or 4)" for every real number field;
  ℚ(ζ₇)⁺'s prime above 2 has norm 8 (TC1).* For multiquadratic F the wall stands iff no odd square class is
  ≡ 7 (mod 8); a glue point over K with radicand r breaks it iff −r is a square in both 2-adic completions
  of K — a congruence test before any solver (of the classes {1, 2, 5, 7, 10, 14, 35, 70}, exactly 5 and 7
  break). The wall is broken iff 1/2 lies in the unit-vector ring ℤ[U] (GPT Astra's prime inversion, G55; for real quadratic fields `[Fischer1990b]` Thm 4, 1/2 ∈ Σ₀ iff N ≡ 7 (mod 8)); in the kernel in valuation form, `UnitRing.inv_two_mem_unitRing_iff` (row 105). **Reciprocity bounds the wall, but the wall is not the ramification of one algebra** [hand; corrected 2026-09-22 at
  FS-71's gate — the audit's first instance]: `(−1,−1)_F` splits at a place `v` above 2 iff −1 is a sum of two squares in `F_v`,
  which for a 2-adic field is iff its local degree is even (`(−1,−1)_{F_v} = (−1, N_{F_v/ℚ₂}(−1))_{ℚ₂} = (−1)^{[F_v:ℚ₂]}`) —
  implied by −1 being a square there (`ℚ₂(i) ⊆ F_v`) and **not implying it**: over ℚ(√2) and ℚ(√3) the algebra splits at the
  one place above 2 and the wall stands. *Demotion record: as minted this entry said the broken wall "says exactly" that the
  algebra splits above 2 and "restates the wall as the ramification of a single algebra"; both false, by those two fields.* What
  survives: a broken wall makes every local degree above 2 even, so the algebra's ramification set is exactly the real places of
  F (it splits at every odd finite place, its coefficients being units there, and is Hamilton's at every real place); that set is
  even by Hilbert reciprocity, so **no field with an odd number of real places can break the wall** — none of odd degree, since
  r ≡ [F:ℚ] (mod 2). The sharper form, odd degree ⟹ 2-colourable, is G56's by the local-degree parity argument and is
  `[Moorhouse2010]` §7.1's. The wall itself is the behaviour of the quadratic extension `F_v(i)/F_v` at each place above 2 —
  split, inert or ramified, G56's trichotomy — not of any single quaternion algebra. **Gate:** the field-level statement is row 57's gap (a conjugation-fixed prime
  supplying the valuation subring); closing it promotes G35 and G43, and it is the one lemma prime inversion's number-field reading (FS-47) and G55's T7 beyond `K(√7)` still need (M2). *Do: before any solver
  over F, decide the wall by congruence — for a K-glue point, is −r a square in both 2-adic completions; for multiquadratic
  F, is some odd square class ≡ 7 (mod 8); for any F, is 1/2 ∈ ℤ[U], i.e. does every prime above 2 split in F(i) — and
  expect no odd-degree field to break it; where it stands, call the null free only once a place above 2 is ramified in F(i) or inert
  of norm ≤ 32, which is automatic over a multiquadratic field or below degree 12. Killing test: a field whose plane needs five colours and whose `(−1,−1)` ramifies at
  a finite place (which would refute the parity step, not the trichotomy).*
* **G36 — The residue colouring is the canonical separating colouring. [theorem + measured]** On a K-point
  descent stage it is proper, monochromatic on every distance-2 cheat, and separates the seed's pair — one
  colouring every cheat set must kill, and a free geometry check (a misplaced point shows as a monochromatic
  unit edge). With a fifth colour on S it separates iff S is an independent exact transversal of the
  cheats, a 2-SAT system; while that is satisfiable no in-field halo makes the cheats force, so μ ≥ 3 inside
  K. `tools/residue_floor.py`. *Do: on any K-point stage compute the residue colouring first — it is the one colouring every
  kill set must beat, a free geometry check, and its 2-SAT transversal decides whether any in-field halo can make the cheats
  force. Nothing kills it; it kills μ ≤ 2 inside K.*
* **G37 — The endgame's shape. [theorem for necessity]** A descent's unit part becomes 5-chromatic only after
  an out-of-field point is committed; the endgame is one wall-breaking adjunction into a field that is also
  6-open, then the last kills. The spindles a K-descent can run (ρ₁₅, 8/3) land in 5-sealed fields. K-fabric
  grown to four-colour rigidity supplies its own wall-breaking angle (forced pairs at 8/3 spindle through
  √247). Over K the 6-open single radicals are the odd squarefree d ≡ 5, 7 (mod 8) that are non-residues
  mod 11 (7, 13, 79, 127, …). **This does not contradict G35's "≡ 7 (mod 8)"**, which is the test on the
  field's *square classes*, not on the radicand: 3 is already in K, so d ≡ 5 breaks the wall through the
  class 3d ≡ 7 (mod 8). Hence 13 joins 7, 79, 127. *Do: plan a descent as K-fabric grown to four-colour rigidity, then one
  wall-breaking adjunction into a 6-open field chosen by the two congruences, then the kills; expect ρ₁₅ and 8/3 to land
  5-sealed. Nothing kills the necessity; the sufficiency dies if fabric rigid at four colours supplies no wall-breaking
  angle.*
* **G38 — The linear method's thresholds. [hand theorem; Fischer's framework]** Colouring by cosets of a
  subgroup avoiding the reduced norm-one group gives 2, 3 or 4 colours and then nothing below 7. With
  conjugation in inertia the reduced group is {±1}, so ℚ(√N)² with N ≡ 5 (mod 8) is bipartite
  (`[Fischer1990]` Thm 8); ℚ(√3)² and ℚ(√7)² need 3; K² needs 4 (`[Fischer1994]`, an additive ℤ/4-colouring, 1994). Over a real multiquadratic field the two-colour case is exact: F² is 2-colourable iff no odd square class is ≡ 3 (mod 4) (hand; the mechanism is kernel, row 63), correcting `plans/FIELD-WALL-THEOREM.md` Prop. 6.4. The finite-plane bound sees 5 (G43); its
  usable primes are exactly those with residue field 𝔽_q, q ≡ 3 (mod 4). A 6-forcer's field is predicted by
  its construction (a spindle at forced distance d lands in F(√(4d² − 1))), not by linear arithmetic. **At three colours the obstruction is now all colourings** (row 82, G74): `1/3 ∈ ℤ[U_F]` and an odd cycle refuse every three-colouring, not only the additive ones, and at `d ≡ 3, 7 (mod 12)` the three-colourings are exactly the additive ones. *Do: decide two and
  three colours by the linear criterion before any plane — N ≡ 5 (mod 8) bipartite, an odd square class ≡ 3 (mod 4) forbids
  two, a usable prime with residue field 𝔽₃ caps at three (G43) — and above four use the finite planes, never linear
  arithmetic; predict a forcer's field from its spindle distance. Killing test: a multiquadratic plane two-colourable with
  an odd square class ≡ 3 (mod 4).*
* **G39 — Redundancy before rigidity. [kernel]** A forced-equal pair at χ(G) colours confines the critical
  set to the pair's common neighbourhood — in the plane at most two vertices, none beyond distance 2. So a
  6-forcer built as fabric plus a spindle at d > 2 needs fabric whose 5-chromaticity survives every vertex
  deletion, and every descent stage has an empty critical set. Necessary, not sufficient (G40). *Do: before asking whether a
  candidate forces a pair at d > 2, delete each vertex once and confirm the fabric keeps its χ — a critical vertex beyond
  distance 2 refutes the design without a solver. Nothing kills it; it kills every forcer at d > 2 on fabric with a
  critical vertex.*
* **G40 — Absorption. [kernel + measured]** A vertex set whose colourings all extend carries only its induced
  subgraph's compulsions — none when it has a spare colour. A spindle copy hangs by its fused centre plus one
  chord, so more spindles or centres cannot create a compulsion, and every K-coset piece is 4-colourable: a
  five-colour compulsion needs material thick in a wall-breaking field. Only the F₂₄₇ cross thickening has
  moved the redundancy dial (238 critical vertices freed, all copy-side — why only that side is open). *Do: before an arena
  is built, count how the copy is joined — a copy hanging by its centre plus few chords has a spare colour, absorbs, and
  predicts the null; a five-colour compulsion needs the copy joined thickly, or several copies, in a wall-breaking field.
  Nothing kills the kernel half; the "thick" reading dies if a thinly joined wall-broken copy carries a compulsion.*
* **G41 — Additive colourings bound compulsions from one side. [kernel + measured]** An additive colouring
  (φ : Λ → G, nonzero on edges) is proper, so the pairs all such φ identify contain the forced ones; since
  exp(G)·Λ ⊆ ker φ, no additive four-colouring separates a pair of 2-adic depth ≥ 2 on any object
  (`addMonoidHom_apply_eq_of_sub_eq_exponent_nsmul`; Fischer's k·G = 0 obstruction at the exponent). The
  valuation law is its exponent-2 member; **`[Fischer1994]`'s ℤ/4-colouring of K² is the exponent-4 member on the whole plane**
  (read 2026-09-22): it gives the Moser vertex `P = ((5√3−√11)/12, (5+√33)/12)` the value 1, so it separates the distance-2 pair
  `(0, 2P)` that every residue colouring identifies — the two colourings are different, and both exist on de Grey's lattice (FS-70's
  screen: 12 homomorphisms to each group). His map is the 2-adic embedding in disguise [reading, tools]: with `√pq` read as its
  2-adic root the same functional colours every ℚ(√p,√q) with p ≡ 3, q ≡ 1, 3 (mod 8) sampled — the fields completing to ℚ₂(ζ₁₂)
  above 2 — so the ℤ/4 colouring is local at 2 at a finite tower level, and his mod-16/mod-32 family is where it can be written with
  `u = 1` (`tools/fischer1994_check.py`; killed by a unit vector there with `v = 0`). On the Exoo–Ismailescu seed this bound is the truth; K-fabric's
  16-pair residue sits at depth 3, beyond any additive four-colouring. *Do: compute the additive family first — exact and
  cheap — and read it one-sidedly: a pair some additive colouring separates is not forced, no solver needed; a pair none
  separates is not thereby forced (depth ≥ 2 is beyond them all). Nothing kills the kernel half; the seed's equality of
  colouring space and additive family dies with one non-additive colouring of it.*
* **G42 — Additive rigidity is closure, and the family dies before it closes. [kernel + measured]** Rigidity
  needs every two-colour Kempe subgraph of every admissible hom connected (gauge γ = Σ(components − 1)).
  Only Exoo–Ismailescu's G has γ = 0 **with its cheats** — the gauge is measured on the graph including its
  non-unit cheat edges, never on the unit-distance graph alone; K-unit parts are 4-colourable; wall-broken thickening can erase the
  family (W plus 63 F₂₄₇ points), while de Grey's half-spindle closure keeps it. Forcing does not need
  rigidity (the seed's 252-cheat subset forces with > 5,000 colourings). *Do: measure γ on the unit-distance graph and on
  the graph with its cheats and say which; expect every unit-distance object Kempe-open, so rigidity is not the route and
  forcing is. Killing test: a unit-distance object without cheats at γ = 0.*
* **G43 — The residue plane seals fields. [kernel over rings; field level gated as G35; prior art
  `[Moorhouse2010]`]** At a usable prime the residue map is a homomorphism into Γ_q, so
  χ(F²) ≤ χ(Γ_q) — non-linear, 5 at q = 11. Every field the descent used is 5-sealed. For multiquadratic F ⊇ K,
  6-open ⟺ wall broken ∧ 11 inert (not for every F ⊇ K: K·E₇ is 6-open with its wall standing, G35): K(√7), K(√13), K(√79), K(√127) are 6-open; K(√35) is
  11-inert but keeps the wall. **De Grey's field IS 6-open, and so is K(√5,√7,√247)** — his coordinates span
  K(√5,√7) (ℚ-span rank **16 of 16** over `tools/degrey_cert.json`; √7 enters by the rotations through
  π/2 ± arcsin(1/8)); Frobenius at 11 is trivial on √5 and nontrivial on √7, so the residue field is 𝔽₁₂₁ and
  **no prime below 131 is usable** (`tools/fplane.py`, `data/fplane/map.md`, since M58). **Row 52 is about the
  proper subfield K(√5)**, never about de Grey's field. The 5-sealed witnesses are Heule-510/553 —
  ℚ-span rank **8**, K(√5), no √7 — where row 52's bound is exactly tight against
  `chromaticNumber_heule510` = 5. Moorhouse §9's bar on a composite ideal beating the best prime rests on
  Hedetniemi's conjecture, which `[Shitov2019]` refuted, so it is not a bar (FS-42) — but the *fractional* chromatic number
  of a categorical product is the minimum of its factors' (`[Zhu2011]`; for vertex-transitive factors the independence
  ratio is the maximum, `[Zhang2012]`), so a composite ideal beats its best prime only through an **integrality gap**
  χ_f ≤ k < χ in some factor (outside review, 2026-09-16). The shadow sieve: an object's direction residues seal every graph built from
  those directions. *Do: at the opening of any milestone over a field, run the sieve (`tools/fplane.py`) — its primes with
  residue field 𝔽_q, q ≡ 3 (mod 4), checking the residue DEGREE, since a larger field can lose a prime its subfield had — and
  read the smallest usable plane's χ as the ceiling and the free null. Nothing kills the ring-level theorem; the field-level
  step is G35's gate.*
* **G44 — Kloosterman control. [derived + measured; ω facts prior art]** Γ_p has eigenvalues
  −K(1, c/4), so Weil and Hoffman force χ > 5 from p = 59 and χ > 6 from p = 103 (exact spectra; 71 as well), and at 83 six is
  refused by the exact certificate (row 68) — the window between is G56's: small planes are SAT questions,
  large ones theorems, and over K the sieve is the single prime 11. ω = 3 iff char 3 or 3 is a square, else 2
  (`[Krebs2022]`); ω ≠ χ above p = 3 (`[SchneiderSilva2013]`). Open: the size of χ − ω (`[Krebs2022]`'s χ > ω result, his Prop. 6.1, is weaker than what we hold); χ(𝔽₁₇²) ∈ {5, 6, 7}.
  *Do: at any new prime compute the spectrum first — seconds — and let Hoffman's floor say whether the plane is a SAT
  question or a theorem before any solver runs; from 59 five is refused for free, from 103 six; at four colours a field's stable place from 37 up has `|λ_min|/d ≤ 2√p/(p+1) < 1/3` and needs no certificate (row 112). Nothing kills an exact
  spectrum; the open items stay open.*
* **G45 — A residue configuration lifts only if it is a shadow. [kernel + derived]** Modulo p² a finite-plane
  subgraph lifts iff its defect pairs to zero with every self-stress; a 6-critical subgraph carries
  ≥ \|V\|/2 + 3 such conditions, and a rigid framework's lift is unique and algebraic. A field's sealing prime
  is never its lifting prime (11 ramifies in ℚ(√11)). Designing in a finite plane and lifting is closed; the
  plane remains a filter and an enumerator (the hub scan). *Do: use a finite plane as a filter and an enumerator, never as a
  design bed to lift from; when a residue configuration is offered as a shadow, check the stress pairing first. Nothing
  kills it; it kills design-and-lift.*
* **G46 — Recognize the classical theory first. [method]** Retired to `plans/GROKKINGS-RETIRED.md`; carried by `ephodos-recognition`, the opening play of every derivation job (`.claude/agents/ephodos.md` § A derivation job), §PA item 1, and the Poros core.
* **G47 — The compulsion face of sealing, at level one. [kernel; subsumed by row 66]** Retired to `plans/GROKKINGS-RETIRED.md`; carried by row 66 (`LEDGER.md`), whose consequences G13, G31 and G48 state.
* **G48 — The tightness mechanism, and the six-level question answered no over sealed fields. [kernel]** Over a field
  sealed at k by a usable prime 𝔭 whose plane is k-colourable, a pair forced equal at k colours has 𝔭 ∣ d², its
  spindle adjoins √(4d² − 1) ≡ √−1 (mod 𝔭), and every prime above p stops being usable: the forcer deletes
  exactly the local bound it beats (the Moser spindle's √11 removes 3; √15 and √247 remove 2). So the six-level
  was one question — does a 5-sealed field carry a pair forced equal at five colours, necessarily at 11 ∣ d²? —
  **answered NO by row 66** over every 5-sealed multiquadratic field ⊇ K (11 usable of residue degree
  one there, and slack): the only pairs forced equal at five colours are single vertices, so
  the mechanism has **no instance**, FS-6 is dead by theorem, and a 6-forcer's every compulsion lives in a 6-open
  field, where no residue plane is five-colourable and this mechanism is silent. The spindle identity stands as
  the reason 6-openness is forced on any 6-forcer, not as a route to one. The first digit (is any finite plane
  exactly 6-chromatic) is decoupled and integrality-carried. **The conjecture the mechanism was minted to serve**
  (FS-15): *χ(F²) equals its best local bound wherever that bound is ≤ 6* — attained wherever χ is
  known — whose **bold form is χ(ℝ²) = 7**. It **loses its constructive route** (a forced pair spindled into
  6-openness) and keeps its predictions: Γ₈₃ is not six-colourable (row 68), so under it **χ(K(√7)²) = 7**
  — the boldest prediction, pinned to the field the ρ₆₃ arena was built in — and de Grey's field, all of whose usable primes have spectral floor ≥ 8, is 7 outright (FS-40, closed with FS-50).
  **Proved range:** L ≤ 5 over every real number field (rows 99, 123; `L = 5` given MR, row 120); given MR, where every stable place of a totally real field is 6-thick the conjecture's value is the plane's own, `χ(F²) = χ(ℝ²)` (row 128), so its bold form at de Grey's field or ℚ(√635087) (`L ≥ 7`) is Hadwiger–Nelson itself; L(F) is the sharp form — the residue graph's chromatic number, 2 at ℚ(√5) where |κ| reads 4. *Do:
  state every milestone's target as a value of L(F) and say whether F sits inside the proved range; outside it (now `L ≥ 6`) the
  milestone is a test of the conjecture, so register its outcome as a prediction before the first solver runs. Falsifiers:
  a field with χ(F²) < min(7, L(F)) — ℚ(√11)² and ℚ(√23)², the cheapest, now meet their value (row 73); the `L = 5` fields are met (rows 121, 123), so the next is ℚ(√167) at L ≥ 6 (FS-59) — each falsified only by a whole-plane colouring, and at `k ≤ 5` by no character (G77),
  never by a finite refusal, which confirms; a wall-broken, 5-sealed field whose plane is 4-colourable by a colouring local at no prime (none at `L = 5` through MR, row 123); for
  the six-question, a 5-colourable, 5-tight Cayley quotient of a 6-open plane (FS-42).*
* **G49 — The prior-art gate. [method, measured]** Retired to `plans/GROKKINGS-RETIRED.md`; carried by `.claude/agents/ephodos.md` § The opening job, §PA's eight questions.
* **G50 — Read what the search found. [method]** Retired to `plans/GROKKINGS-RETIRED.md`; carried by `.claude/agents/ephodos.md` §PA (item 6 and the held-paper reading) and `plans/STANDING-RULES.md` rule 10.
* **G52 — Breaking the wall is necessary and visibly not sufficient; the equal-radius family is the mechanism. [hand for the
  necessary half — the σ-criterion, M63G-T4/T5 in `plans/M63G-derivation.md`; measured + reading for sufficiency, one instance with a positive control]** A wall-breaking rotation can still be four-colourable: breaking the wall is a
  property of the field the rotated copy lives in, while the residue colouring reads the base points, which never leave the
  original field. The rotation escapes the colouring only through one family — cross edges joining two base points the colouring
  gives the same colour, which requires the base to realise a specific radius sum, via `d² = σ − (σ−1)/cos θ`. Measured on M63
  phase G's rotation: it breaks the wall and dies because `[Parts2020a]`'s lattice cannot realise the live radius sum (no
  solution, against 30 at his own angle) — a fact about that lattice, not that angle. Inverted, a design target: the cosine
  names the live radius sums before any base exists; one free prime kills. Necessary is proved; sufficient is untested, the
  record's rotation the only positive instance. **The apparent filter is free where the circle is free**: with the circle `t ×`
  the unit shell for an integer `t`, the certificate's defeat is automatic for even `t` (`φ` lands in a characteristic-2 residue
  field, so every circle point carries the centre's residue, and the shared centre pins the colour twist that might have repaired it (measured: **0 of 24** twists at either prime)), and the record has `t = 2`; so "this object defeats the residue
  certificate" is not evidence about the object, and the live quantity is the **off-diagonal** share of monochromatic cross
  edges (the record 0 of 30, `ρ₆₃` 24 of 54). `|p|² = n` is free — nonempty by scaling alone — whenever `n = k²·m` with `m` a squared distance the lattice already
  realises (4, 16, 12 free; 2 not); the converse fails (`n = 5` has 60 points and no such decomposition — M63H2-T2's own correction record; FS-71, batch 4c). *Do: for every in-field rotation compute the live radius sums from its cosine before any
  base exists — a free prime filter — and measure the off-diagonal monochromatic share under the base's colourings, never
  the diagonal, which is free where the circle is free. Killing test: a rotation whose base realises the live radius sum and
  stays four-colourable (sufficiency, untested), or a wall-breaking rotation forcing with no monochromatic cross pair.*
* **G53 — The counting compulsion, and the refutation criterion it defines. [derived; one provisional measurement]** For a
  type-M arena — base `B` plus its rotated copy sharing the centre, joined by cross edges — any proper `k`-colouring `C` yields two
  proper `k`-colourings of `B` alone, `f(v) = C(v)` and `g(v) = C(Rv)` (G46). The shared centre forces `f(0) = g(0)` and each
  **diagonal** cross edge forces `f(v) ≠ g(v)`, so with `B(h) = {circle v : h(v) = h(0)}` the sets `B(f)`, `B(g)` are disjoint,
  and with `L = min_h |B(h)|` over proper `k`-colourings of the base, **`2L > (circle count)` ⟹ the arena is not `k`-colourable**
  — a property of the base alone, no arena solve; sufficient, never necessary. A **counting** compulsion, a shape the vocabulary
  lacked — "at least `L` of these `n` points share one designated point's colour" — with a forced pair as `L = count`; it explains
  why both fail on `ρ₆₃`, where `L/count = 10/30` (provisional) and no circle point is forced. **The design target — maximise
  `L / (circle count)`, refute above `1/2` — is the first objective in M63 phase H2 that a free construction cannot supply**, the
  circle count and the residue certificate's defeat both being free (G52). *Do: compute `L` on the base alone before any
  arena solve and refuse above `1/2`; below it the screen says nothing. Nothing kills the derivation; the provisional
  `10/30` dies with a recount.*
* **G54 — Tight or slack: one sign says where a residue plane must force; slack only permits gaps. [kernel one
  way; hand the other (FS38-D2-A/B, `plans/FS38-derivation.md`); the table computed]** Let `P` be the level-one plane at a usable prime, `d` its degree,
  `λ_min` its least eigenvalue, `k` the colour count. **Slack** (`λ_min < −d/(k−1)`; Hoffman's α-bound exceeds
  n/k): gaps are permitted, and where one exists — found at 7, 11, 19; 23 and 83 slack by the spectrum with no
  colouring asked — **gap ⟹ free** is kernel (row 66). **Tight** (`λ_min = −d/(k−1)`, the literature's Hoffman
  colorability): every k-colouring is balanced, gap-free and periodic under the common kernel of the minimising
  characters, so **tight ⟹ forced by `H_min` ∧ gap-free** is derived (Theorem D2-A; balance and gap-freedom are
  Blokhuis–Brouwer–Haemers's, the periodicity ours). **The middle case — slack but gap-free — is observed** (row 87):
  `Cay(Λ/16Λ, U)` is slack at four colours (`λ_min = −18.883 < −18`), yet every four-colouring pulls back from the tight `Λ/8Λ`
  (54 generators onto 36, unequal fibres), so all are gap-free and it forces; at 11 no 5-colouring has every vertex gapped, on two
  engines. *Demotion record:* as minted this entry said the sign classifies a plane's compulsions and read slack as free; slackness
  permits gaps and does not supply one. **Slackness propagates up a tower** whose level maps carry `S_{m+1}` onto `S_m` with constant fibres (`λ_min/d` is non-increasing under pullback), which is why the 11-adic tower is slack at every level; **tightness does not** (row 93: `Λ₅₁₀`'s quotients, constant fibres, are tight at 14 and slack at 24) — the 2-adic tower is tight at every level by FS38-L2's non-strict half, as is every unramified quadratic dyadic tower containing `√3` (row 93). *Demotion record:* this sentence said both properties propagate, from FS38-L1, whose tightness half has a wrong-direction step (FS-86's B2); the slack towers at 7–23 do not drop either, by certificate, not by the spectrum (row 75). **In an inert tower the ratio is exactly
  constant** (GPT Astra, 2026-09-16, hand; recomputed at 3, 7, 11, 19, 23, 27 and 2 by `tools/fs54_wall_feedback_verify.py`;
  for odd prime Q immediate from `[MMST1998]` Thms 2.1, 2.3, 2.9, new for Galois rings and even Q):
  λ_min(G_j) = Q^{j−1}·λ_min(G₁) with degree Q^{j−1}(Q+1), so every Hoffman floor survives every level. **Tight can be rigid
  and still force nothing** (same review, recomputed): at U₃₂ = Cay(𝔽₁₀₂₄, μ₃₃), k = 4, the least eigenspace is exactly
  μ₃₃, the unit circle is a Sidon set, so a maximum independent set's Fourier support is {0, a, b, a+b} and **every maximum
  independent set is an 𝔽₄-hyperplane** — eleven four-colourings, with trivial common kernel. The table: tight at 3 (k = 3;
  the rhombus forces, row 58) and at 2 (k = 4; forced from level 5, row 67); slack at 7 (k = 4) and at 11, 19, 23
  (k = 5) and 83 (k = 6); by Weil, tightness at k needs `(p+1)/(k−1) ≤ 2√p`, so no usable prime above 3 in the
  committed table is tight for any k ≤ 7 (p = 31 misses 4-tightness by 4.4·10⁻⁵ in the normalisation `9(λ_min + d/3)/d`: `λ_min + d/3 = 1.5617·10⁻⁴`, ratio `1/4 − 2.745·10⁻⁶`). **At four colours no stable place has an integrality gap** (row 123): a stable place's target is four-colourable iff its all-levels ratio is `≥ 1/4` — only `𝔽₃`, `𝔽₇`, dyadic inert `Q ≤ 32` and dyadic ramified — so slack everywhere and `L ≥ 5` are one condition. **In a product, Hoffman-tight pulls back where the other factor mixes** (FS-67, rows 114–115): every colouring of a Hoffman-tight plane is gap-free — a fall colouring, which Csernák calls "tight", another sense of the word — and a gap-free `G` pulls back against every abelian Cayley `H` with `λ* < 1/(k−1)`, sharp at `K_k`; gap-freedom alone fails against some `H` from four colours up (`K_k × X`, `X` from a Hedetniemi pair), and whether Hoffman-tightness suffices is open — check the other factor's `λ*` before calling a product colouring local. **What it says about six:** the
  residue mechanism forces pairs where the plane is tight or pulls back from a tight quotient, and no plane that seals a field at five does (each has a gap, row 66) — so the
  only residue route left to a five-colour forced pair is a **quotient** of a 6-open plane that is 5-colourable and
  5-tight (FS-42, a reading with its falsifier). *Do: when you meet a new prime, ring or quotient, compute the sign of
  `λ_min + d/(k−1)` at the colour count FIRST — a character sum, seconds per (field, k). Tight: expect every k-colouring
  balanced, gap-free and periodic under `H_min`, and forced pairs at some depth of its tower (row 67's mechanism) — go find
  the depth. Slack: find one gapped colouring, and with it the freedom of every pair above it (row 66) — then ask no solver for forced pairs on that plane's fabric; with none found, check whether its colourings pull back from a tight quotient (`Λ/16Λ` → `Λ/8Λ`, row 87) before calling it free. Positive: the ratio bound refuses `k` colours outright and the plane is no `k`-target at all (Γ₂₃ at four, by 0.039; FS81-T25) — a registration that names only tight and slack has missed a reachable outcome. Neither is a substitute for FS-17's ask. Killing test: a k-colouring of a tight
  plane that is unbalanced or gapped; of the reading that the middle case comes from a tight quotient, a slack plane whose k-colourings are all gap-free and pull back from none (the middle case itself fired at row 87).* *Reading (FS-73's implementer B, restated at the close):*
  a full-rank forced group appears where a lattice is integral at a prime whose target is Hoffman-tight at `k` and no other prime's
  quotient has a gap — K at 2 with four colours (`F = 8Λ`, row 78), ℚ(√11)'s `Λ₁₀` at 3 with three (`F = 3Λ`, row 79). At ℚ(√11)
  the prime above 3 is split in `ℚ(√11, i)`, not conjugation-fixed (Poros), and `Θ₃` explains that instance (G71); the K instance
  is explained since row 85 (G75): triangles supply the period, the tight dyadic quotient kills the 5-part. Killing test: a lattice integral at a tight prime, with no gapped
  quotient, whose `F` is not of full rank.
* **G55 — The unit-vector ring decides the walls, and the chain replaces the spindle. [hand, GPT Astra (OpenAI,
  2026-09-14, in conversation with Kooshi); read here and found sound; the identities verified twice in exact arithmetic —
  `reference/ChatGPT-local-global-tightness-conjecture/VERIFICATION.md`; every result below is a kernel target, FS-45–48 (Kooshi, 2026-09-14)]** Of these kernel targets, in the kernel since M2: the chain theorem and its ring form (`1/δ ∈ ℤ[U_F]`), prime inversion in valuation form, the ℚ(√2,√3) lower bound and the `K(√7)` implication (rows 103, 105); the rest named at M2's close remain targets — prime inversion's number-field reading (row 57's gap), `G4`'s certificate, `χ(ℚ(√2,√3)²) ≤ 4`, the vertex bound `m(n − 1) + 1`, the two-colour classification. Let R = ℤ[U] be the ring the unit vectors of F(i)
  generate (M56's Σ₀). **Prime inversion:** 1/p ∈ R iff no conjugation-stable prime of F(i) lies above p (by lying-over) — M56 L7's conjecture, proved in general; and R = O′, integral at the stable primes, with no Galois hypothesis off a ramified stable dyadic place (row 100); **prior art for multiquadratic F at odd unramified p and for every prime of a real quadratic F**: `[Fischer1990b]` Thms 1, 3, 4 (1989), whose Σ₀ is this R, so M56 reconstructed a published theorem; so "the 2-adic wall is
  broken" is "1/2 ∈ R". **The chain theorem:** a finite graph over F forcing two points at difference δ equal at k colours makes
  every k-colouring of F² periodic under the ideal δR (transport by every isometry z ↦ t + u(z − a)); if 1/δ = u₁ + ⋯ + u_m is a
  sum of unit vectors, 1 is a period and χ(F²) > k, witnessed by m chained copies plus one closing edge, at most m(n − 1) + 1
  vertices, **in F itself** — the spindle is m = 2, which is why its threshold is d ≥ 1/2 and its field F(√(4d² − 1)) (row 44).
  **Consequences.** χ(F²) = 2 ⟺ L(F) = 2 for every real number field (walk parity is a ring homomorphism R → 𝔽₂). For √3 ∈ F: χ(F²) = 3 ⟺ some prime has residue field 𝔽₃ ⟺ L(F) = 3
  (every three-colouring is 3R-periodic by the rhombus and descends to Cay(R/3R, H), which contains the product of the planes
  at the stable primes above 3; `[ElZaharSauer1985]` and the Weil floor leave q = 3), so the conjecture holds for L ≤ 4 there; **without √3 too** (row 99): a three-colouring's torsion part is a residue character at a stable prime of residue field 𝔽₃, so χ(F²) = L(F) at L ≤ 4 for every real number field (row 82 had the real quadratic case by `1/3`); the same argument cannot run at four colours — not at the product, since Hedetniemi fails from four up (`[Tardif2023]`, `[Zhu2025]`) but
  never among residue targets (each needing five has `χ_f > 4`; `[Zhang2012]`; `plans/PA-tardif2023.md` §5), but at the descent: nothing gives four-colourings an ideal period; five came by measure rigidity instead (row 123). Given the 8/3 forcer over K — **prior art: Jannis Harder, Polymath16 first thread, 28 April 2018** (*"V + V + H … forces the point (8/3, 0) to have the same color as the origin"*, 745 vertices, spindled at arccos(119/128) into K(√247); `[Polymath2021]`'s strip forcer is the same pair on `ζ₆^m ρ^n`-fabric; M53–M56's 588-vertex core, one solver refusal, is a smaller rediscovery — found by FS-70's gate, 2026-09-21): every wall-broken real F ⊇ K has χ(F²) ≥ 5 (3/8 = 3·(1/2)³ ∈ R) — wall-broken is
  *sufficient* for five over K where G35 had it necessary — and every multiquadratic F ⊇ K with L ≤ 5 has χ(F²) = L(F); over
  K(√7), w = (−3 + i√7)/4 has w³ + w̄³ − 3w² − 3w̄² = 3/8, so eight copies plus an edge, at most 4,697 vertices, need five colours
  by hand, against the ρ₆₃ arena's 51,133 by solver (FS-45 puts it in the kernel). An 18-vertex, 33-edge graph over ℚ(√2,√3)
  (six chained rhombi) is four-chromatic with no Moser spindle in its field, and χ(ℚ(√2,√3)²) = 4. **On six:** one five-colour
  virtual edge at distance 2 over any F ⊇ K is a six-chromatic unit-distance graph (the sentence is the advisor's; M49–M50
  replaced those edges one at a time; the host and the consumer are G26); its field must be 6-open (row 66), and the arena
  has no such pair. What the chain cannot do is
  produce the five-forcer it needs. **Over K a second four-colour forced pair is known, at `8/9 = −(v + v̄)`** (Parts, Polymath16, 2021, who spindled it too; row 78): `9/8 ∉ ℤ[U]`
  over K, so no chain contradicts χ(K²) = 4, but its spindle lands straight in the 6-open K(√7), since `4(8/9)² − 1 = 175/81 =
  (5√7/9)²`. *Do: for a pair forced at δ, look for 1/δ as a sum of unit vectors before adjoining any
  radical — the closer stays in F, at most m(n − 1) + 1 vertices. Killing test: chained copies of a forced pair with 1/δ ∈ R
  that are k-colourable (a defect in the proof); or the 8/3 forcer's one solver refusal failing to replicate, on which the chain's route to the
  five-colour consequences over K rests (row 123 reaches them through MR).*
* **G56 — The window for six, and reciprocity's exclusion of it. [derived: exact spectra and the 83 certificate; the
  exclusion is elementary and script-verified; the consequence for χ(ℝ²) rides on the conjecture's bold form and on FS-39's
  bridge, which is `[BendaPerles2000]` pp. 117–118 (Madore's ¶5.4) plus de Bruijn–Erdős]** Six colours on Γ_q need an independent set of ⌈q²/6⌉, which the
  ratio bound permits only while 5|λ_min| ≥ q + 1: by Weil that fails from q = 98, the exact spectrum already fails it at 71, and
  83 — the last prime where six was spectrally possible — refuses it by certificate (row 68), as do 59, 67 and 79 (FS-53 phase B,
  row 69). Five is refused from 59 up. So over the residue fields a number field can have, **a plane with χ exactly 6 can live only
  at q ∈ {23, 27, 31, 43, 47}**, with floors 6, 6, 5, 6, 6 (five refused by certificate everywhere but 31: rows 69–71; at 27 row 70's `α(Γ₂₇) ≤ 141 < 146`) and none
  decided (ceilings and searches: row 69). **The exclusion.** A prime is usable for a
  field only if the field's radicands are all squares in its residue field, and **every field this project has built in contains
  K**: 3 is a non-square modulo 31, 43, 67, 79 and 11 modulo 23, 47, 59, 71, and at 27 the residue 11 ≡ −1 (mod 3) is a non-square
  in every 𝔽_q with q ≡ 3 (mod 4); so such a field's usable primes are 11 and then nothing below 83; its places above 2 never ramify in F(i) and, when
  not split, have norm 2, 8, 32, 128, …, never 64 (`plans/WORKFLOW3-TC1-theory-corrections.md` TC1-SQRT3-DYADIC); its local bound is 4
  (a place above 2 inert of norm ≤ 32), 5 or ≥ 7, and **six is arithmetically excluded for all of them**. A six-chromatic number field, if one exists, contains no √11 and none of
  the known five-forcers; every field with local bound ≥ 6 needs five through MR (row 123, [hand]). **Each member has its field named**
  (`data/fs54/fields.out`, `data/fs54/quadratic-fields.out` — complete enumerations by PARI's `nflist`, FS-54): the smallest field
  whose FIRST usable plane is that member **and whose 2-adic wall is broken**, the second condition being what makes a local bound
  of 6 worth anything, since a wall-standing field below degree 12 — every field these enumerations reach — is four-colourable
  by the residue at 2 (TC1-STANDING-FOUR; from degree 12 a place above 2 inert of norm ≥ 64 keeps the wall without four colours). **The primes above 2 decide which
  fields count, and there are only three cases**: a prime of F above 2 that **splits** in F(i) gives no bound; one **ramified** in
  F(i)/F gives **χ(F²) ≤ 2** whatever its norm (conjugation acts trivially on the residue field, so every unit vector reduces to 1
  and a linear map to 𝔽₂ sending 1 to 1 two-colours the plane); one **inert** gives U_Q, Q = N(𝔭), which is **4-colourable at
  Q = 2, 4, 8, 16, 32** (CaDiCaL, FS-54; by an F₂-linear formula, X26B, and by no F₄-linear one at 4, 16) — and **at Q = 64 its Hoffman floor is 6** (λ_min = −15; a linear 8-colouring exists, so
  6 ≤ χ ≤ 8), so **U₆₄ is a sixth window member, in characteristic 2**, realised only by fields of degree ≥ 12; Q = 128 has floor 8
  (`data/fs54/char2/`). So "the wall is broken" means **every prime above 2 splits in F(i)**, i.e. −1 is a square in every
  completion above 2, and **every field of odd degree is 2-colourable** (some prime above 2 has odd local degree, so i is not in
  that completion and it ramifies; the reciprocity form is in G35) — **`[Moorhouse2010]` §7.1's theorem**, by the same residue
  mechanism (attributed by FS-71, batch 6b; FS54-T2). With that criterion the
  smallest fields are **23 → ℚ(√167), 31 → ℚ(√1055), 43 → ℚ(√4703), 47 → ℚ(√2351)** — every field of degree 3 or 4 with
  |disc| ≤ 20,000 fails at 2 — and **27 needs even degree ≥ 6** (a quadratic field cannot reach 𝔽₂₇, a quartic reaching it also has
  an 𝔽₃ plane, an odd-degree field is 2-colourable); the smallest found, among composita of a cubic with a quadratic field, is **the
  cubic of disc 316, x³ + 2x² − 3x − 2, joined with √79** (|disc| 31,554,496; usable planes below 100: 27, 43, 79).  **Real quadratic
  fields with local bound at least 6 exist, each decided by one to three planes**: with d ≤ 30,000 there are 44 whose wall is
  broken and whose usable planes avoid {3, 7, 11, 19, 31} (`data/fs54/quadratic-fields.out`, rerun 2026-09-17); every one has 23,
  43 or 47 usable, so its L is 6 exactly when a usable one of those is six-chromatic and ≥ 7 otherwise — the smallest are
  **ℚ(√167)** (23 or 43), ℚ(√1319) (23 or 47) and **ℚ(√2351)** (47 alone). **Five is refused at all three, so a six-colouring at
  23, 43 or 47 makes χ(ℚ(√167)²), χ(ℚ(√4703)²) or χ(ℚ(√2351)²) ≤ 6 a theorem: the first number field with local bound exactly 6.**
  **All three deciding planes are implausible on the measurements** (row 69's plateaus at 23 and 43 and the 99.4 % tightness six
  needs at 47; `data/fs53/CLOSE.md`) — nulls at a budget, not refusals, but they put these fields most likely at local bound ≥ 7. **And 27 is the unique non-prime member, permanently:** `q = p^f` is usable iff p ≡ 3 (mod 4) **and f is odd** — "odd residue
  degree" is the congruence restated; 25 fails twice, 49 on the degree alone, the mechanism that costs de Grey's field the prime 11
  — and of the non-prime prime powers below Weil's cap of 97 only 27 qualifies; the next, 243 and 343, are far beyond it, so the
  tooling's prime-only assumption costs exactly one member. **What the window decides is whether six
  is reachable by the residue method at all**, since χ(ℝ²) = sup_F χ(F²): no six-chromatic window plane ⟹ no field has local
  bound 6 ⟹ every field holding a six-chromatic unit-distance graph has all its usable planes at ≥ 7, so the finite planes can
  never pin six — and under the conjecture six is a value no field attains, though every seven-chromatic graph passes through it
  (χ(ℝ²) = 7 follows from the bold form at K(√7) alone, without the window; a field merely *containing* a six-chromatic graph may
  have χ(F²) = 7 = L, which is no local–global gap); one six-chromatic plane ⟹ a field with χ(F²) ≤ 6 by theorem, predicted 6
  (FS-53), a finite six-chromatic graph by compactness. The clique structure decides which field can see which member, and rules
  the Moser spindle out of every one of them (G57). Every window plane is slack at six — at 23, 27, 31, 43, 47, 67 by divisibility
  (Hoffman-tightness at k needs (k−1) | (q+1), and 5 ∤ q + 1), at 59 and 79 by the exact spectrum — so the tight mechanism, which
  forces pairs in every colouring, is not available there. *Demotion record: this sentence once continued "so over a field it seals the
  residue mechanism forces no pair"; slack only permits gaps (G54's middle case is open) — caught by an outside review,
  2026-09-16.* **The rounding reading:** on a vertex-transitive graph
  χ_f = q²/α, so χ ≥ ⌈q²/α⌉ is a theorem and only the equality **χ = ⌈q²/α⌉** is the reading (true at 3, 7, 11; consistent at 19;
  it replaces the "+1 over the spectral floor" reading, which fails at the Hoffman-tight q = 3). The fractional wall W_f, which
  proves the window empty with no reading at all, and what the conjecture makes of the window: G59. *Do: for any field, list
  its usable q and its places above 2 first — six is possible only if a usable q lies in {23, 27, 31, 43, 47} or a place above 2
  is inert in F(i) of norm 64, and no place above 2 is ramified in F(i) or inert there of norm ≤ 32 (row 123; over a multiquadratic
  field or below degree 12, that is the broken wall); otherwise L is 2, 3, 4, 5 or ≥ 7 before any solver. Over any F ⊇ K no place
  above 2 ramifies in F(i) or has norm 64 (TC1-SQRT3-DYADIC), so L is 4, 5 or ≥ 7, and 4 when a place above 2 is inert of norm ≤ 32. An exception field of row 100 (a stable dyadic place ramified in `F(i)/F`) has `L = 2`: never scope a claim at `L ≥ 3` by that exception (row 123). Killing tests —
  of the exclusion: a usable window member for some field containing K (impossible by reciprocity); of the reading: a decided
  plane with χ ≠ ⌈q²/α⌉; of W_f: an independent set of ⌈Q²/6⌉ at an open member.*
* **G57 — The window is triangle-free where it is roomy, and no candidate field holds a Moser spindle. [derived;
  the clique rule is `[Krebs2022]`, verified here; the correspondence and its consequence are ours]** Three mutual unit
  distances force an equilateral triangle, whose apex is `(1/2, √3/2)`, so **`ω(unit-distance graph over F) = 3` iff
  `√3 ∈ F`**, and 2 otherwise (`[Krebs2022]` Lemma 5.1, any characteristic ≠ 2). Downstairs, Krebs: `ω(Γ_q) = 3` iff char 3 or 3
  is a square in `𝔽_q`. **One direction transfers**: `q` is usable for `F` only if every radicand of `F` is a square in `𝔽_q`, so
  **`√3 ∈ F` puts triangles in every usable plane, and a usable plane without triangles certifies `√3 ∉ F`.** *Demotion record:
  this entry first called the two conditions the same — "a field contains √3 exactly when its usable planes have triangles". The
  converse is false: ℚ has no √3 and its usable plane at 11 has triangles (3 = 5² mod 11); and in characteristic 3 every plane has
  them — at 27 the collinear triples `{z, z+u, z+2u}` (FS-54), present whatever the field. Every consequence below uses only the
  direction that holds.* Across the window: `ω = 3` at 23, 27 and 47 (3 a square, or char 3), `ω = 2` at **31 and 43**, which can
  therefore serve only fields *without* `√3`, whose own planes are **triangle-free**. And **no window member admits `√3` and `√11`
  together** (11 is a non-square at 23, 27, 47; 3 is a non-square at 31, 43 — 11 *is* a square at 43, so there the exclusion is
  driven by 3 alone), which is G56's reciprocity seen through the clique structure — and since the **Moser spindle needs both**
  (`√3` for its rhombi, `√11` for the twist `cos θ = 5/6`), **no field whose local bound could be 6 contains a Moser spindle.**
  Every forcer this project holds is assembled from spindles or their relatives, so G31's "a χ ≥ 6 gadget must be constructed,
  not found" acquires its sharp form: over a window field there is nothing to build *from*, and at 31 and 43 not even a triangle.
  **The tension this creates is the milestone's, in one line:** the member where our construction vocabulary could apply is **47**, which has almost no room — six
  needs `α ≥ 369` against the certified `α ≤ 371`, a three-integer window at 99.5 % of the ceiling — while the member with room is
  **43**, a fifty-seven-integer window at 84.7 % of the ceiling, in triangle-free territory where we have no vocabulary at all.
  *Do: read ω of a usable plane as a certificate — no triangles downstairs means `√3 ∉ F` — and over a window field look for
  no spindle to build from: the vocabulary must be Moser-free (G11's route). A five over a field without √3 answers Soifer 55.1's existence half (row 121). Killing test: a five- or six-forcer built over a
  field containing neither `√3` nor `√11`, which would show the vocabulary is not the binding constraint.*
* **G58 — The antipodal conjecture: an optimal colouring can always be taken symmetric under `z ↦ −z`. [reading,
  4 of 4 planes with a known χ, each verified from the definition; the fixed-colour half is derived]** **Conjecture:
  every Γ_q has an optimal colouring `c` with `c(−z) = τ(c(z))` for some **involution** `τ` of the colours. Verified where χ is
  known exactly: `q = 3` (χ = 3, `τ = (2,1)`), `q = 7` (4, `(2,1,1)`), `q = 11` (5, `(2,2,1)` and `(2,1,1,1)`), `q = 19` (5,
  `(2,2,1)`) — proper on every edge by an independent rebuild. **No simpler form survives**: at 19 the identity and every single
  transposition are refuted, so "invariant" without a colour involution is false. **Derived, not conjectured:** a rotation fixes
  the origin, so `c(0) = τ(c(0))` and **τ must fix a colour** — which refutes 73 of the 226 rows refused across seven equivariant
  sweeps (32 %) in one line, with no solver, and should be a filter in the tool rather than solver time. **Why it matters: it
  halves every colouring instance**, `(q² + 1)/2` orbits against `q²` vertices — 925 against 1,849 at 43, 145 against 289 at 17 —
  and the equivariant sweep's order-2 rows *are* that search. **Which relocates the open question**: at 11 and 19 the satisfiable
  rows are order 2 with `τ = (2,2,1)` or `(2,1,1,1)`, **exactly the rows left undecided** at 17 (k = 5) and 23, 43, 47 (k = 6). So
  the sweeps' zeros are not evidence of absence — they refused only the rows refused at 11 and 19 too, where a colouring
  demonstrably exists — and the effort belongs on those half-size instances rather than on a full cube-and-conquer. **Asked as a DECISION at 23 (k = 7, 8)
  and 43 (k = 8), it returned nothing**: every refusal was free (the fixed-colour argument; an edge joining some `z` to `−z`) and
  every row that could carry a colouring was undecided at 3,000,000 conflicts. G58 asserts EXISTENCE, so its instrument is a FINDER
  on the antipodal quotient, `(q²+1)/2` orbits, never a decider on the full plane. A decider is being asked to refute, which is the expensive direction and the wrong one for an existence claim (More instances: `plans/GROKKING-INSTANCES.md` §G58). **Prior art** (searched 2026-09-16 under graph
  theory and algebraic combinatorics, in their words): the frame is the Burnside chromatic polynomial of group-invariant graphs,
  and the abelian-Cayley colouring literature (`[GarciaMarcoKnauer2024]`, arXiv:2405.19543 — the key and id corrected by FS-71 batch 6a: 2303.06262 is `[CervantesKrebs2023]`) works on χ, not on invariance; **nothing
  found asserting or refuting this for any graph family** — the *distinguishing* chromatic number is the opposite question, and
  the failure of invariance under the FULL automorphism group says nothing about one involution up to a colour permutation.
  Bibliography keys owed. *Do: search with a FINDER on the antipodal quotient under a colour involution that fixes a colour;
  filter every equivariant row by the fixed-colour test before any solver time; never a decider on the full plane. Killing
  test: a plane with an optimal colouring but none antipodally invariant under any involution.*
* **G59 — The wall at six is finite and fractional, its escape hatches close to integrality gaps, and what it leaves is a
  quadratic prediction. [cert + proof (GPT Astra, verified by recomputation) + derived]** **Finite:** χ(U_Q) ≠ 6 is settled
  everywhere except Q ∈ {23, 27, 31, 43, 47, 64} (floors 6, 6, 5, 6, 6, 6). **Fractional (the wall W_f):** χ_f = Q²/α on these
  vertex-transitive graphs and χ ≥ ⌈χ_f⌉, so α(U_Q) < Q²/6 at the six (≤ 88, 121, 160, 308, 368, 682) proves the wall with no rounding
  reading; only 47 (0.76 % below its certificate) and U₆₄ (0.888 of Hoffman) are within reach of a priced relaxation (FS-57).
  **The normalization, and what a uniform bound DOES carry** (2026-09-18): with `c = α/q^{3/2}` the colour count is `≈ √q/c`, so
  six needs `c ≈ √q/6` — **a threshold that grows with q against a constant that looks flat**. Measured c: 0.756 (7), 0.767 (11),
  **0.918 (19)**, 0.789 (23), 0.834 (27), 0.846 (31), **0.915 (43)**, 0.822 (47) — exact at 7 and 11, bracketed at 19
  (76 or 77: 0.918–0.930), best-found elsewhere, hence lower bounds on the truth. Six needs c = 0.807, 0.870, 0.933, 1.096, 1.145
  at 23, 27, 31, 43, 47 and 1.334 at U₆₄, crossing the observed maximum 0.92 at **q ≈ 30.5**. So **one uniform theorem
  `α ≤ 0.93·q^{3/2}` closes 31, 43 AND 47** — three of the six, in place of three separate relaxations, **though it is the harder
  object, not the cheaper one**: against the exact ratio bound it must reach 0.668, 0.663 and 0.642 there, where the best reach
  ever measured is 0.797 (FS-62 §2a(4)) — leaving only **23 and 27**, plus U₆₄, whose characteristic-2 scaling is different
  (measured c = 1.0; its maximum sets are subspaces). No uniform bound can close 23: it needs c < 0.799 while 19 itself reaches
  0.918. **So the wall is not a law about the number six. It is one quantity being bounded, plus a two-vertex accident at 23**
  (best set 87, six needs 89; row 69) **and a five-vertex one at 27** (117 against 122): the colour count climbs like `√q`, so
  each value is reachable only in a narrow band of q, and six's band falls in the gap between the last comfortably-five member
  and the first comfortably-seven one. *Reading — c is bounded by ≈ 0.93 over odd q. **The killing test at 19 — a set of 78 — is
  closed from the refusing side** (FS-66: the exact all-levels certificate `data/fs66/b1/cert-p19.json` gives `α(Γ₁₉) ≤ 77`, so
  `α(19) ∈ {76, 77}` and `c(19) ≤ 0.930`), where SAT's frontier sat thirty above the answer (`k = 110` refutes in 383 s,
  `k = 105` not in 900) and the level-3 relaxation read 80.59 with the fixed-cardinality moment equations adding nothing (FS-62
  §2a, `data/fs62/q19/`). **The one left is an independent set of 263 at q = 43**, which gives c ≥ 0.933 and kills the uniform
  route to 31; at 19 the margin is gone — `0.93·19^{3/2} = 77.02` against a possible 77. Caveat, G21: every c above 19 is a found
  set, so the flatness may be measuring search effort. A symmetry break is an encoding and is measured, never argued: at 19 both
  exact normalisations of the 361 translations were slower than the weak origin pin and slower than no break at all.* **Escape hatches:** χ_f of a categorical product is its factors' minimum (`[Zhu2011]`, `[Zhang2012]`), so
  W_f also rules six out for every CRT product of first-level targets, and a composite target is six-chromatic only through a
  factor with χ_f ≤ 6 < χ; inert towers keep the Hoffman ratio (G54); so a six-chromatic target of any ideal has a factor of
  residue size in {23, 27, 31, 43, 47, 59, 64, 67, 79, 83} at some tower level. **Rigidity where Hoffman is tight:** U₃₂ at k = 4
  (G54); at 64 Hoffman is slack, but a 683-set must carry ≥ 50.2 % of its Fourier energy on the least eigenspace — a stability
  route's first step. **What the conjecture makes of it:** if the wall holds, the main clause (held through five, row 123) says nothing above five — χ(F²) =
  L(F) is then a finite rule read off the conjugation-fixed primes with residue 𝔽₃ (3), 𝔽₇ (4), 𝔽₁₁ or 𝔽₁₉ (5), or dyadic,
  ramified (2) or inert of norm ≤ 32 (4) — and the bold form makes every other field 7: χ(F²) ∈ {2, 3, 4, 5, 7}, and every
  six-chromatic unit-distance graph extends to a seven-chromatic one over its own field. The sharpest instance is **ℚ(√167)**, the
  smallest-discriminant real field with no such prime (usable planes 23, 43, 59, …): five being refused at 23 (FS-56), the
  conjecture predicts χ(ℚ(√167)²) ≥ 6 whichever way the wall goes (6 by the main clause, 7 by the bold form), against a proven 5 (row 123, [hand]; 4 in the kernel, row 119),
  in a field with no √3 and no triangles. *Do: at any window member aim at α < Q²/6 — the fractional wall needs no rounding —
  and report c = α/q^{3/2} beside every found set, marked found or exact. Killing tests: a six-colouring of a window member
  (the wall); an independent set of ⌈Q²/6⌉ at one (W_f); a colouring of ℚ(√167)² with fewer than six colours (the conjecture
  above five; five there is held, row 123).*
* **G60 — Fractional colourings reach fields the residue method cannot, and stop where a residue plane is fractionally small. [hand, from `[MatolcsiEtAl2025]`; cert; measured; one reading]** Every congruence between subsets of `F²` is an isometry of `F²`, so the blow-up of a finite `H ⊂ F²` along a Følner set of the (solvable) group its congruences generate stays in `F²`, and **χ(F²) ≥ ⌈χ_gf(H)⌉** (`plans/FS56-field-blowup.md`) — a lower bound that uses no residue map, no additive structure and no forced pair; instance: χ_f(K²) = 4. Its **ceiling** is `min(4.36, χ_f` of every usable residue plane`)` — 3 at an `𝔽₃` place, 3.5 at `𝔽₇` — so it can never prove more than five colours. **Given MR the cap is exact, and it is what row 123 proves** (row 129, two minds): `α₁(F²) = max(m₁(ℝ²), sup_v r_v)`, the fractional local–global principle, and row 123's five is `⌈1/α₁⌉`, the colour count entering only at one pigeonhole on the densest class — so no argument that runs one class at a time gives six. The finitary–measurable gap `[AmbrusEtAl2023]` §4 expected is a tight place's (the Moser lattice's dyadic places), gone at ℚ(√635087), where `α₁(ℝ²) = m₁(ℝ²)` given MR. **The reading** (R-C; killing test in FS-58): its ratio-bound shadow on pieces `Cay(ℤ⁴, W)` tends to the least local character mean over the places where the unit circle is compact (real: `J₀`'s −0.40276; `𝔽₃` −1/2; `𝔽₇` −0.5617; `𝔽₂₃` −0.3317), the split places controlled by the weights, so a real field whose compact places all read above −1/2 — ℚ(√167) first — would have χ_f ≥ 3.48. What reached four colours over real quadratic fields was not this route but finite refutations (G61, row 73). *Do: run a field-level lower bound on one colour class before believing it — if it runs per class it is `⌈1/α⌉ ≤ 5` (row 129); read the cap first — a usable plane with χ_f at or below the target kills the route by theorem; where every usable plane's χ_f sits above it (no `𝔽₃`, no `𝔽₇` place), price a finite `H` with χ_gf(H) > k − 1 before any forced-pair route: it proves k with no refusal, and FS-56's LP and checker exist. The real place's `J₀` minimum `−0.40276` is below `−1/3`: a one-sided spectral bound at `−1/k`, `k ≥ 3`, fails over every real field before it is tried (row 122; missed at FS-100 stage 5's registration). Killing tests: a real field whose compact places all read above −1/2 with a 3-colourable plane (the reading); a finite `H ⊂ F²` with χ_gf(H) above a usable plane's χ_f (a defect, never a finding).* *The same engine splits the inheritance
  question* (FS-73): `Λ ≅ ℤ^r` is amenable, so the differences no invariant probability measure on the colouring shift separates form
  a subgroup `F_μ` with `F ⊆ F_μ ⊆ P` — a walls half and a recurrent half (`plans/FS73-derivation.md` T38); at three colours both
  close (row 79). *What this entry caps is the one-point densities* (FS-79): window frequencies are not controlled by `χ_f` — their LP is
  exact in rank 1 (row 80) — and FS-73's `Θ₃ = ∅` is itself an averaged pair statistic plus integrality [reading, Poros], so G72's
  averaging move is not capped here (FS-80).
* **G61 — Three colours break at arithmetic, not at size — at 1/3 in the unit-vector ring, which a finite lattice sees as its supply of unit vectors. [kernel + certified + hand + measured; one reading]** Over a real
  quadratic field with `d ≡ 2 (mod 3)`: (1) **The barrier** [kernel, row 72]: directions integral at 3 are 3-colourable outright, so a refusal needs a direction with 3 in a denominator —
  met by count in every certified witness (89 to 4,328 such edges, never zero). (2) **The theorem** [hand, two independent derivations; row 82; its method is G74]: the plane over any `F ⊆ ℝ` needs four once `1/3 ∈ ℤ[U_F]` and the plane has an odd cycle — for ℚ(√d) exactly `d ≡ 11 (mod 12)`, by the type-M relation `1 = 2n − nv − nv̄` — so **T4 holds**, and so does the conjecture's four-colour clause for real quadratic fields (`[Fischer1990]` Thms 8–9: χ = 2 iff d ≢ 3 mod 4, χ = 3 for d ≡ 3, 7 mod 12, and at those every three-colouring is additive mod 3; L = 4 by the dyadic bound at d ≡ 3 (mod 8), his Thm 10(i), or the plane at 7, and L ≥ 5 exactly at d ≡ 47, 143, 167 (mod 168)), and the
  barrier is its necessary half: `1/3` needs a 3 in a denominator. (3) **Rigidity is periodic and local** [measured]: the 3-adic plane is Hoffman-tight at three colours and rigid
  from level 1, and stays rigid tensored with the residue planes at 7 and 11 (at 11 a theorem: the plane is 3-gap-free and `Γ₁₁` mixes, `λ* < 1/2`, so every three-colouring of the product pulls back, rows 114–115; at 7, where `Γ₇` neither mixes nor has `χv > 3`, still measured; false without gap-freedom); the periodic colourings of the 3-integral pools tried were all affine, so quotient screens never kill; on ℚ(√11)'s `Λ₁₀` "every colouring is affine" is a theorem (G71). (4) **The rational directions are
  load-bearing** [measured; explained by row 82]: the `√d`-vectors alone force nothing, and two fields' unit vectors in one lattice shape share *only* the rational ones, because the
  norm equation is linear in `d` — the rational pattern `U₅` is the layer every field-level argument reads. (5) **On a finite lattice, supply decided refusal** [measured, row 74]:
  one integral shape refuses over ℚ(√11) with 108 unit vectors and is periodically 3-colourable over five fields with 20–36; refusing lattices are rich in classes, not coarse;
  odd girth ≤ 9 is necessary and far from sufficient; and the congruence class did not decide which lattices refused — 11 and 59 land at `d ≡ 3 (mod 8)`, cutting across
  `[Fischer1990]` Thm 10's split of the family. Since row 82 this is a fact about finite witnesses only: every field in the family refuses, and a finite witness appears where the
  field's `Θ₃` empties at small depth (five layers at depth `5^K`, `K_B(d) ≤ 3` below 500, row 83). *Demotion records:* this entry first read "every field with a usable plane at 7
  has χ = 4" (false at ℚ(√2), ℚ(√7)) and "forcing at small size tracks short odd cycles in a COARSE 3-non-integral lattice" (the census: rich, not coarse); FS-58's plan first
  derived periodic affinity from "finite quotients of the 3-integral group are 3-groups" — false, since the unit vectors' lattice maps onto every stable residue plane. **And until
  FS-81 (2026-09-24) it read "T4 — every such d needs four — is unproved: no proof and no route to one — no witness transfers between fields, and the chain route needs a forcer in
  every field's own 3-integral graph"**: killed by row 82, whose route transfers one relation and one rational pattern to every field and needs no forcer. *Reading, with its
  test:* **the census's mod-8 skew** (13 of 20 certified at `d ≡ 7 (mod 8)` against 2 of 20 at `d ≡ 3`) is configuration A's: `{1, v, v̄}·U^(5^K)` never empties at
  `d ≡ 11 (mod 24)` (FS81-T8), and lattices built around `v` and `v̄` inherit it. Killing test: a census-style search that lands the `d ≡ 11 (mod 24)` fields at the `d ≡ 23` rate.
  *Do: over any real field, decide three colours at the field level first — over a number field, three iff an odd cycle and a prime above 3 of residue field 𝔽₃
  (row 99); over any real field, `1/3 ∈ ℤ[U_F]` and an odd cycle force four — and build nothing; for a finite witness take the five layers `{vᵏ : |k| ≤ 2}·U^(5^K)` at the least `K` with `d < 21·5^{K−1}` and certify structurally (row 83). Nothing kills
  the theorem but a defect in its chain (FS73-T22's ⟹ is hand-proved, never kernel); it forbids a three-colouring of any such plane, and every three-colour search over one.*
* **G62 — Every witness is a twisted bilayer, and the twist family is the coincidence rotations. [derived, the
  identification verified symbolically; the prior art external]** Every 5-chromatic object this project holds or reproduces —
  de Grey's 1581, Heule's 510, `[Parts2020a]`'s record, the `ρ₆₃` arena — is **a point set plus a rotated copy of itself,
  joined where the two layers land at distance 1.** That is the definition of a **Moiré bilayer**, and the resemblance the
  pictures have to Moiré patterns is not a resemblance but a description. **The identification is exact.** With
  `w = (1 + i√(4n−1))/2`, the standard generator of the integers of `ℚ(√−(4n−1))`, `|w|² = n` and **`w̄/w = −ρ_n`** — so
  G7's type-M family is, up to a half-turn, **the coincidence rotation of index `Σ = n` of the imaginary quadratic order
  of discriminant `1 − 4n`, one for each `n`**. Verified symbolically for general `n` and at `n = 3, 4, 16`:
  `(5+i√11)/6`, `(7+i√15)/8`, `(31+3i√7)/32`. (Derived at M63 phase H3 and left in `plans/M63-phaseH3-prior-art.md` §PA.4;
  promoted here 2026-09-17.) **Commensurate or incommensurate IS the field wall.** A twist is *commensurate* with a module
  when the two layers share a finite-index sublattice — equivalently, when `√(4n−1)` already lies in the module's field.
  Then the bilayer is **periodic**, so it is a Cayley graph of a finite quotient, so its chromatic number is bounded by that
  quotient's: **a commensurate twist cannot raise the colour count above its base field's local bound — there is nowhere for
  it to go.** Only an incommensurate twist generates a new field, and *which* field is exactly what the 2-adic wall test
  measures. G7's ladder, rung by rung: `n = 3` (Moser, `Σ3`, radicand 11 already in `K`) is **commensurate** and can never
  reach five; `n = 4` (`Σ4`, radicand 15 → `√5`) is incommensurate, reaches five, lands 5-sealed; `n = 16` (`Σ16`,
  radicand 63 → `√7`) is incommensurate, reaches five, lands 6-open. **And the plane's own 7-colouring is the `Σ7`
  coincidence lattice**: `Instances/Seven.lean` colours by cosets of the norm-7 Eisenstein ideal `(−3 + ζ₆)`, whose
  index-7 sublattice is the coincidence site lattice of the 21.79° twist — the canonical `Σ7` grain boundary and the
  textbook twisted-bilayer-graphene commensurate angle. Row 34's "2, 5, 6 are not `a² + ab + b²`" is that discipline's
  statement that a coset colouring's colour count is an ideal index, hence a norm (G64). **Refuted trap, recorded so it is
  not rediscovered:** `ρ₁₅` sits **1.045°** off 30° and twisted bilayer graphene's first magic angle is **≈1.05°**. This is
  a coincidence. Ours is `arccos(7/8) − 30°`, algebraic and forced by a Diophantine condition; theirs is the first zero of a
  ratio of interlayer coupling to Fermi velocity, a continuum quantity that moves with the material. **What the frame does
  NOT reach: the forcing side.** Moiré physics' localisation — flat bands, trapped states at the superlattice scale — has no
  principled translation into "this vertex's colour is determined"; every construction of one is word-association, and
  forcing stays where G15 left it. **Prior art** (M63 phase H3 §PA.4, three passes): `[BaakeZeiner2017]` §6 defines a
  submodule to have the **same rank** (footnote 8), so rank-halving ones are out of scope by definition;
  `[BaakeGrimm2004]`'s Bravais colourings are similarity submodules, and ours is neither map; the twisted-bilayer-graphene
  literature's commensurate family is the **hexagonal** one, `cos θ = (m²+n²+4mn)/(2(m²+n²+mn))`, a different one-parameter
  shape that does not contain ours; and **no source joins coincidence-site theory to unit-distance colouring.** The full
  gate is FS-63. **A lattice can be a multilayer, and then it decides layer by layer** (FS-73, missed and then found by hand):
  ℚ(√167)'s `L21cc6506` is `U = {1, v, v̄, z, z̄}·U_R`, the rational pattern in five rotations, and `v = (83 + i√167)/84` is the
  `Σ = 42` rotation (`cos θ = 83/84`, radicand 167) — so `Θ₃` is the set of `θ` whose every layer pulls back into the rational
  pattern's rotation set, the product route that proved χ(ℚ(√167)²) ≥ 4 (row 79). *Do: name every bilayer by its `Σ = n` —
  and factor a lattice's unit vectors as rotations times a base pattern before any tree — and decide commensurate or not by whether `√(4n−1)` lies in the
  field: commensurate is periodic, so ask a finite quotient's colouring before any solver — one proper colouring of the
  quotient colours every arena on that module at once; incommensurate names the new field, which the wall screens. Killing
  test: a commensurate twist whose arena's chromatic number exceeds its base field's local bound, which would refute the
  periodic ⟹ finite-quotient ⟹ bounded step.*
* **G63 — The chromatic number of a field plane is arithmetic only: pure transcendence is free. [kernel at `d = 2` (row 104); prior art:
  `[Fischer1990]` Thm 6, statement and proof; its lemma `[Madore2015]` Prop. 3.2]** For any `F ⊆ ℝ` and any `t` transcendental over `F`, **`χ(F(t)²) = χ(F²)`**. At the place `t ↦ 0` the
  residue field is `F`, which is formally real, so `−1` is not a square there; a unit vector `(u,v)` with a pole would need
  the leading terms of `u²` and `v²` to cancel, which needs `−1` to be a square — so **every unit vector is integral**, the
  plane splits into cosets of the valuation ring, and reduction is a graph homomorphism onto `F²`. The other inequality is
  the induced subgraph. **So `χ(ℚ(π)²) = χ(ℚ(e)²) = 2`: the planes over the transcendental fields are bipartite.** No amount
  of transcendence buys a colour; only algebraic extension does, and the chromatic number cannot see transcendence degree at
  all. (The other constant people ask about is the golden ratio, and it is arithmetic, not transcendental: `ℚ(φ) = ℚ(√5)`,
  `5 ≡ 5 (mod 8)`, so the prime above 2 is inert in `ℚ(√5)` and ramified in `ℚ(√5, i)` — **`χ(ℚ(φ)²) = 2`**, the golden-ratio
  plane is bipartite. `L(ℚ(√5)) = 2` is G48's; `data/fplane/map.md` reads "sealed-at-4" there, which is the coarse `|κ|` bound
  and not the sharp value.) **One lemma under two methods** (M2): the kernel's `unitQuadrance_colorable_of_valuationSubring` colours `K²` from any place whose
  residue ring has no `√−1` — Theorem A's finite places (`q ≡ 3 (mod 4)`) and this entry's `t = 0` are its two instances, a smooth rational
  point of a curve a third. **Fischer's Remark 1 and the bridge.** `[Fischer1990]` Remark 1 reduces a finitely generated `E ⊂ ℝ` to a
  number field by calling `E` "a purely transcendental extension of some finite algebraic extension" of ℚ — false: `ℚ(π, √(π³ − π))` lies in no purely transcendental extension of any number field (genus 1: Lemma NP is Fermat–Catalan at signature `(4, 4, 2)`, and its genus-0
  twin fails exactly at `(2, 2, 1)`; kernel with `2 + L` for `π`, row 107), yet its plane is two-chromatic (a degree-one place, J17-T8).
  The bridge `χ(ℝ²) = max` over real number fields is **`[BendaPerles2000]` pp. 117–118 (1976), by Tarski** (re-derived as `[Madore2015]` ¶5.4 with ¶1.3, whose fn. 5 credits them;
  asserted in `[Soifer2024]` ch. 11); in the kernel it is conditional on one true proposition, `RealAlgebraicDescent` — the equational
  existential fragment of Tarski–Seidenberg for `ℝ_alg ⊆ ℝ`, months of formalization, Artin–Lang being no cheaper (J17-T10). **Open (Q-const):** for finitely
  generated `E ⊂ ℝ` with constant field `F`, is `χ(E²) = χ(F²)`? True when `E/F` has a degree-one place with formally real residue field.
  `[Fischer1990]` Theorem 6 is the statement for every dimension and for additive colourings too ("`F^d` can be k-colored iff `F(α)^d` can"), proved by writing a unit vector over `F[x]` without common factor and setting `x = 0`. Nothing here is ours but the kernel forms. *Do: when a construction adjoins a parameter or a transcendental, expect no
  colour from it — reduce to the algebraic field first; asked about ℚ(π), ℚ(e) or ℚ(φ), answer 2 without computing. Nothing kills
  it (kernel); it forbids a colour gained by adjoining a transcendental to a real field.*
* **G64 — Six may be a value no field attains: a claim about fields, stronger than χ(ℝ²) ≠ 6 and not equivalent to it. [derived; the pattern a reading]**
  **The two statements.** *S:* no subfield `F ⊆ ℝ` has `χ(F²) = 6`. *W:* `χ(ℝ²) ∈ {5, 7}`. **S ⟹ W trivially** (ℝ is a subfield;
  for *number* fields it is FS-39's bridge — if `χ(ℝ²) = 6`, de Bruijn–Erdős gives a finite 6-chromatic unit-distance graph, its
  coordinates generate a number field `F`, and `6 ≤ χ(F²) ≤ 6`). **W ⟹ S is unproved and unmotivated**: a plane needing seven forbids
  no smaller field from needing exactly six, and one quadratic step can jump two colours (ℚ → ℚ(√11), 2 → 4). **The exact form, given
  the bridge: `χ(ℝ²) ≠ 6` ⟺ every six-chromatic number field has a seven-chromatic finite real extension** (⟸: a field attaining the
  plane's 6 has none; ⟹: take the compositum with a field holding a 7-chromatic graph) — six is never where the climb *stops*, which
  restates Hadwiger–Nelson and does not reduce it. *Demotion record: as minted 2026-09-17 this entry claimed S ⟺ W —
  "Hadwiger–Nelson reduced from three values to two" — when both lines of its proof gave only S ⟹ W; the wall bears on S and on
  the value set of `L`, never on W, and FS-62's conditional target dissolved with it. Caught on review 2026-09-19, after two days
  of compute at `q = 19` under that banner.* **What the wall does decide.**
  `χ(F²) ≤ L(F)` is a theorem (row 52; row 57's gap is the kernel's, not the mathematics': the localisation at a prime is a DVR in every number field), so a six-chromatic field has `L(F) ≥ 6`, and
  `L(F) = 6` needs one of six named finite graphs to be six-chromatic (G56, G59); under the conjecture's bold form S *is* the wall, and
  under its main clause a six-chromatic window plane is a six-chromatic field. **The gap question has two strengths.** The strong one —
  `χ(F²) ≥ 6 ⟹ χ(F²) ≥ 7` in `F` itself — is what S needs, and wants G55's chain at six: a forced pair at `δ` with `1/δ ∈ ℤ[U]`. The
  weak one — some finite extension reaches 7 — is W, and there a six-colour forced pair at *any* distance ≥ 1/2 suffices (the spindle,
  row 44): the arithmetic hypothesis is the price of staying in the field. Either is this file's open structural question at six
  instead of five. **The aiming statement, unconditional:** six hides nowhere in the arithmetic — it hides only in the gap between
  `L(F)` and `χ(F²)` at `L(F) ≥ 6`, where `χ(F²) ≥ 5` through MR (row 123), where every ceiling instrument this project owns (residue maps, additive colourings, the hexagonal 7) is silent;
  FS-64 is the one proposal for an instrument that is not. **Given MR the plane sits at the gap's top** (row 128): S_nf (no real number field has `χ(F²) = 6`) ⟹ `χ(ℝ²) ≠ 6`, and row 128 states its exact form over totally real fields — never S ⟺ W. Characters are shut out of that gap at the exposed fields: given CLG they need 8, 17, 22 colours at ℚ(√167), K(√7), de Grey's field (row 101). **Warning:** "six is skipped" is **not**
  evidence for seven — it is equally consistent with every field being `≤ 5` and `χ(ℝ²) = 5`. What forces seven is the
  conjecture's bold form at `K(√7)` (G48), never the skipping. **The norm reading** [reading]: every chromatic number this
  project has ever pinned for a plane over a coefficient structure is **2, 3, 4, 5 or 7** — exactly the integers `≤ 7` that
  are `a² + b²` or `a² + ab + b²` — and **6 is the smallest integer that is neither**, because `6 = 2·3` with 2 inert in the
  Eisenstein integers and 3 ramified. Mechanism where it has one: a coset colouring's classes are cosets of a rotation-stable
  sublattice, hence of an ideal, hence the colour count is a norm (row 34, G62). **No mechanism at the finite planes** — the
  5-colouring of `Γ₁₁` cannot be a subgroup quotient, since `(ℤ/11)²` has no subgroup of index 5 — so this is half
  numerology and is labelled so. Next predicted skips: 11, 14, 15. **The mechanism half is three theorems, and it WEAKENS the
  reading rather than supporting it** (2026-09-18): every structured colouring we own constrains its count — a residue colouring's
  is the size of a residue field, hence a **prime power**; a coset colouring of the triangular lattice by a rotation-stable
  sublattice is an Eisenstein ideal, hence **Loeschian**; the same on the square lattice is a Gaussian ideal, hence a **sum of two
  squares** — and six is the smallest positive integer none of the three can produce, for three independent reasons. **But five has
  no mechanism either, and five occurs**: the pattern already fails at the value immediately below the one it is being used to
  explain, and it fails at the finite plane, which is where the wall lives. The two criteria are also distinguishable — the
  three-mechanism union admits 11 (a prime power) where the two-form criterion forbids it — so the killing test below separates
  them instead of merely testing one. **Measured** (`tools/fq_chi.py`, `data/fs62/`): an independent rebuild
  reproduces `χ = 3, 4, 3, 5, 5` at `q = 3, 7, 9, 11, 19` and the controls `χ(Γ₅) = 3`, `χ(Γ₁₃) = 5`; 17, 25, 29
  are `≥ 5` and undecided at five. **The dimension-3 probe returned nothing** — `χ(UD(𝔽₃,3)) = 3` and every other case decided
  is `≥ 7` — so a six outside dimension two was unreachable *at the sizes the budget could decide*, and whether the skipping is
  specific to the plane stays untested. More instances: `plans/GROKKING-INSTANCES.md` §G64. *Do: never cite "six is skipped" as evidence for seven; aim any six-hunt at the gap
  between `L(F)` and `χ(F²)`, where the residue, additive and hexagonal ceilings are silent; keep S and W apart in every
  sentence about six. Killing tests: a six-colouring at 17 (`χ ∈ {5,6}`), at `U₆₄` (`χ ∈ [6,8]`), or at any window member;
  or any plane pinned at exactly 11 (which refutes the two-form reading and confirms the mechanism one).*
* **G65 — The refusal phase diagram: a ball's average degree, not its size, decides whether a solver answers, and hardness marks the threshold, never the far side. [measured on 775 asked
  balls of FS-61; one registered prediction lost]** Put every asked ball of a lattice unit-distance graph at its average degree `2·edges/points`: below 4 everything 3-colours at once; **4–6 is the
  hardness peak** — most undecided balls sit there and every decided one is colourable (random graphs have their 3-colouring threshold at ≈ 4.7; 25 undecided balls sit on planes that are
  3-colourable by theorem); **no ball below 6.6 has ever refused**; from 14 up almost everything decides in seconds, colourable or not. On a fixed refusing lattice the *smallest* refusing ball is
  the slow one and larger radii refuse faster (47: 104 s at R = 1.2, under a second at 1.5). So "suddenly hard" is the signal of standing at the threshold from either side, and the move is away
  from it. **The law that aims a ball before it is built: degree = g·φ(R)²**, `g` the lattice's unit-vector count, `φ(R) = [2R²·acos(1/(2R)) − ½√(4R²−1)]/(πR²)` the overlap of a disc with its unit
  translate, squared because a ball is a bidisc (observed/predicted median 1.0000, range 0.715–1.184); figure of merit `N₁₄ = π²R₁₄⁴/covolume`. **A radius ladder that steps down to fit a point cap
  steps down in degree, into the peak** — FS-61's did, 24 of 37 asks came back undecided, and "the solver is the wall" was accepted from a population at median degree 5.5; re-aimed at degree 14,
  five new fields refused. **To certify, go up in degree too**: at 239 the degree-14 ball refused in 403 s and its core rounds crawled (8,336 points after 52 rounds and 77 minutes, still falling ~25 a round), while the degree-18 ball of the same lattice refused in 197 s, ran its core rounds to a fixpoint in 12 minutes and certified at 2,360 points — *though the registered prediction about it lost on both halves* (not under 120 s; round 0 left 49,576 points, not under 5,000): what differs between the two balls is the tail of the core rounds, not round 0. **What lost:** "every ball at degree ≥ 14 decides" — 2 of 17 ran to the wall, both above the old cap, where the record it was registered on held nothing: a
  population extrapolated past its own edge. And certification cost is predicted by none of the three statistics proposed for it in one day — ball points, plain solve time, the first core round's output: the largest of five balls
  certified in 44 s, the smallest needed a second, denser ball — so the instrument is a **stop rule on the measured rate (points per second, on the current window), not a predictor**; certificate weight is a cliff (1,004 points → 19 MB, 1,739 → 40 MB, 2,360 → 43 MB). Minted from
  Kooshi's question — *is there a cliff we can traverse instead of searching blindly?* — which the records already answered. It bears on every SAT search here, not only on quadratic fields.
  **The law prices balls bounded in every embedding; a word ball has a combinatorial ceiling it does not see** (FS-70, 2026-09-22): on the
  rank-8 lattice `group:u3:2+w4` the 1.9 M-point ball at sums of ≤ 4 has average degree 15.4, its ≤ 3 interior has 84 generator-neighbours
  each — and its 13-core is empty, because the interior's own induced degree is 11.5 and the shell that carries the rest peels first; the
  denser-core lever of FS-61 does not exist there, and the Minkowski ball that the law does price is `10⁹` points at degree 18. **The
  ceiling is radius-indexed, not rank-indexed** (FS-70 phase 1f): a word ball's core number is set by its outermost shell's mean degree,
  and that shell is ≥ 93 % of the ball at every radius measured — 11.7 at sums of ≤ 4 (ceiling 12), 14.6 at ≤ 5 (29 M points, mean degree
  19.2, ~103 GB of solver); the same lattice's radius-4 ball in its 132-unit-vector metric is 11 M points at 18.7. *Do: on a word ball,
  compute the core numbers and the outermost shell's mean degree before promising a denser core; a shell one radius out raises the
  ceiling by about the shell's degree gain, at the shell's size.*
  More instances: `plans/GROKKING-INSTANCES.md` §G65.
  *Killing test: a refusing ball below average degree 6.5; or a family of lattice balls whose undecided fraction does not fall with degree.*
* **G66 — Up a residue tower nothing drops where we can see, because a higher level is a *fuzzy* copy of level one and
  fuzziness is taxed; what is left of the question is the carry. [kernel + cert + hand; one reading]** The tower's
  limits are analytic: `lim_k χ(G_k)` is the clopen chromatic number of `ℤ_p²`, `lim_k α(G_k)/p^{2k}` its measurable
  independence density, and `χ(F²) ≤ χ(ℚ_p²) ≤ χ_Bor ≤ χ_clopen ≤ χ(Γ_p)` — every ceiling we own, and `L(F)`, reads the
  *weakest* term of a chain whose other terms nobody had computed at an odd prime. **Why they do not drop** (row 75):
  every character of `G_k` that is new at level k is small (`|λ| ≤ 2p^{k−1}` against degree `p^{k−1}(p+1)`), so to level
  one an independent set of any level is a fractional set φ paying `2Σφ(1−φ)` for its fractional part — one inequality
  at every level, and the certificates show it leaves no room for a fourth class at 11 or 19 or a fifth at 23. The 2-
  and 3-adic towers of row 67 are constant for a different reason (level one is Hoffman-tight); at `p ≥ 7` nothing is
  tight and the tax is what holds. **The gain is real locally and unaffordable globally**: on one single-direction line
  the p-cycle unrolls into a `p²`-cycle and a level-two set beats the pull-back (Lemma W), so fibre shares leave the
  stable-set polytope and no pointwise transfer can exist; only the plane's bracing as a whole forbids the gain (G45's
  over-determination from the other side). **The whole content is the carry**: with the carry of integer addition set to
  zero the tower is over a ring containing `𝔽_p` and is impotent in two lines (Theorem E); and every instrument we own —
  the spectrum, the inequality, every `B₁` certificate — is blind to the carry, holding verbatim for every twisted cover
  (Lemma T). So the certificates prove more than was asked, and the method can prove *the tower never rises* at a prime
  only if no twist of `Γ_p` rises there. *Reading — the tower never rises: `α(G_k) = p^{2(k−1)}α(Γ_p)` for every p and k
  (true at level two of 7, `α = 686`; `B₁ = α(Γ_p)` numerically at 7, 11, 19 — at 23 the relaxation reads 97.6
  against a best set of 87: the gap grows with p, or `B₁(23) > α`), and the same for every twist.* **What it does to the conjecture:** `L(F)` with every level
  allowed is the same number at 7, 11, 19 and 23, so the prediction at ℚ(√167) survives its first tower — and 43, its
  other plane, is beyond this instrument (priced at 84 GPU-days and 310 GB: a smaller relaxation, not a bigger machine)
  and ℚ(√47)'s bracket could not close from above by residues (`CLOSED-QUESTIONS.md` §1.7; it closed at five, row 121). **Instrument lessons**
  [method]: ask the whole graph directly, clique pinned, before building any finder — the pilot, `UD(ℤ/121,2)` at four
  colours, fell in 1.7 s; a level-two resolution refutation projects onto level one, so CDCL refuses nothing up a tower
  it cannot refuse at the bottom; the symmetry-reduced second-level moment relaxation beats the three-point
  bound and the level-3 relaxation on these planes (77.5 against 80.59 at 19) and bounds `α(Γ_p)` itself — *"it must
  beat the last instrument's reading" was never an argument that it cannot* (the owner ruled 23 out of reach on that and
  the 19 reading overturned it); a rounded bound travels with its shift (positive definiteness survives iff `shift ≥
  10^(3−D)` at 7, 11, 19 and `10^(4−D)` at 23 — the recipe followed literally returns no certificate there, so scan
  three decades; at 11 one knob moves `U` from 28.2021 to 30.5445) and tracks the **dual** residual; in the kernel the
  clause table is the graph's bill and the segments the proof's. *Do: read `L(F)` as the all-levels number at 7, 11, 19 and
  23 without recomputing; at a new prime ask the whole graph clique-pinned before any finder, expect CDCL to refuse nothing
  up a tower it cannot refuse at the bottom, and certify by the fibre-share relaxation rather than by SAT. Killing tests: a
  verified independent set of 687 in `UD(ℤ/49, 2)` (which would refute a hand link or the checker, not only the reading); of
  3,389 in any twisted cover of `Γ₁₁`.* *The first sentence reaches colourings too* (FS-73): a lattice graph's periodic colourings
  are exactly the continuous colourings of the odometer `Λ ↷ Λ̂`, so `P = F_clopen`, and the inheritance question is the compulsion
  analogue of `χ_clopen = χ`, with the measurable colourings between (`F ⊆ F_μ ⊆ F_meas ⊆ P`).
* **G67 — A grokking is grokked by its form, and the reframe is re-grokking. [method; measured on one milestone]** Retired to `plans/GROKKINGS-RETIRED.md`; carried by `.claude/agents/ephodos.md` § Why the reframe, § The opening job (§G) and § The close job (the form every drafted grokking takes).
* **G68 — Ask the quotient before the ball, and read its colouring for a gap. [derived from kernel rows 56 and 66; measured on
  seven lattices; the instrument of FS-70 phase 1d]** A lattice unit-distance graph is periodic, so a proper k-colouring of the finite
  quotient `Cay(Λ/NΛ, U mod N)` (`U` the lattice's *complete* unit-vector set, none in `NΛ`) colours every graph on the lattice at
  once — and if one vertex's closed neighbourhood misses a colour, the quotient is slack, and every pair on every graph in the
  lattice is free: `Forces ↔ =` at every distance and radius (`unitQuadrance_colorable_of_quotient`; `slack_addCayley_of_fanGap`,
  `Slack.forces_iff_of_hom`). Minutes per lattice, no ball, one-sided: an UNSAT or a gap-free colouring at one `N` proves nothing
  (L6 gives a gapped colouring at `N = 5` and a gap-free one at `N = 8`), so the finder is aimed at *gapped* colourings (a clause
  that empties one closed neighbourhood of a colour). Over ℚ(√3,√5) it closed, by theorem, four lattices three phases had asked
  with solvers; over K it finds no gapped colouring on de Grey's lattice at any `N ≤ 12`, as Harder's forced pair requires. The
  gapped colourings are non-additive (`Hom((ℤ/p)^r, G) = 0` for odd `p`, `|G| = 4`) — the colourings the additive screens (G41,
  G42, `FS70-T2`) are structurally blind to; G61(2)'s "quotient screens are blind" was a fact about *colourability* at three
  colours on affine colourings, and the gap reading is the half it lacked. Its soundness edge is completeness of `U`: on a lattice
  whose saturation is unaffordable, a gap read from the generators alone proves nothing. *Do: before building any ball over a
  lattice, run the quotient at every admissible `N` the rank allows and read each colouring for a gap; one gapped colouring closes
  `Forces` on the whole lattice — build nothing on it; where every colouring is gap-free, the lattice is rigid as far as periodic
  colourings go and the periodic Kempe screen (`FS70-T10`) decides the target. Killing test: a lattice with a gapped quotient
  four-colouring that carries a four-colour forced pair — which would refute the reduction's being a homomorphism, i.e. an
  incomplete `U`, never row 66.* **A gap is sufficient for looseness, not necessary** (FS-73, row 78): the rank-6 L3 is gap-free at
  every period and still loose — one period-2 colouring's Kempe period group (the translations fixing every Kempe component) is 0 —
  so finitely many periodic colourings whose Kempe period groups meet in 0 make a lattice loose, a gap being the case of an isolated component — sufficient, not necessary: `L21cc6506` is loose through a full-dimensional `Θ₄` cell, infinitely many periodic colourings (row 81; G21; whether finitely many already meet in 0 there is open). *Where every colouring is gap-free, compute the Kempe period groups, and the `Θ_k` cells (G73), before calling a lattice rigid.*
* **G69 — Rigidity is arithmetic, decided on the quotient, and over ℚ(√3,√5) it pulls apart from density. [hand + tools; FS-70
  phases 1c–1e; one prediction of the owner's lost on the way]** The chain route (G55) needs a four-colourable lattice with a
  *forced* pair — a rigid colouring space — and rigidity is decided before any ball is built. **Periodic colourings are residue
  colourings, prime by prime:** for a rank-4 lattice whose ℚ-span is a CM field `E`, a period-`p` four-colouring is Theorem A's
  colouring at `p` on the target the unit vectors' reductions generate — a prime of `E⁺` **split** in `E` supplies the residue plane
  `UD(𝔽_q, 2)`, five-chromatic from `q = 25` (de Grey's 54 unit vectors are *exactly* the torus of `𝔽₂₅` mod 5 and of `𝔽₄₉` mod 7,
  which is why his lattice has no odd-period colouring and Harder's `8/3` pair is forced); **inert** or **ramified** supplies a
  norm-one Cayley graph that is computed, not read off, and over ℚ(√3,√5) four-colours with a gap at 5 and 7 for the hexagonal
  fabric's CM field `ℚ(√−3,√−5)` and at 5 for the doubly split `ℚ(√3,√−5)` (`FS70-T5`, `T9`). **A forced pair at `δ` then needs
  every periodic colouring's Kempe component of the origin to reach `δ`** — the lift of the quotient's two-colour component, a coset
  `p + V` of the closed-walk voltage lattice, with the index `[NΛ : V]` the deciding quantity (`FS70-T10`); the fan gap (G68) is the
  degenerate case `V`-trivial and **is not the classifier**: the rank-6 L3 is gap-free at every period and escapes at every target
  (`[2Λ : V] = 81`), which is the prediction the owner lost. Over `K` the hexagonal lattice is rank 4, meets refusing targets at 5,
  7, 11, 13 and is Kempe-rigid at `8/3` under all six periodic colourings found — **dense and rigid**, so a forced pair exists — Harder's
  at `8/3` (745 points his smallest forcing subgraph; our control ball was 23,083) — and **every four-colouring of de Grey's lattice is
  `8Λ`-periodic: `F = P = 8Λ`, from one 2,044-point certificate at `v = −(4/9)(1+√−11)` (row 78), and since row 85 by derivation from Parts's trees, so Harder's `8/3 ∈ 8Λ` is derived too** — on the Moser ring Hubai had the same count by 2018 (`[Hubai2018]`); rigidity there is complete. Over ℚ(√3,√5) every lattice of rank ≤ 6 built is loose, and the one lattice with no periodic colouring found is
  rank 8, whose dense finite pieces start at `~10⁷` points (a 29 M-point word ball at degree 19.2; an 11 M-point ball at 18.7 in a
  132-vector metric; the 1.9 M-point ball's 13-core is empty) against the 745 to 2,044 points of the forcing objects over `K`: **where
  rigidity is possible, density costs nearly four orders of magnitude more — the two pull apart, and that is the whole difference between
  the two fields.** (Our *rigid* — every colouring identifies the pair — is
  the symbolic-dynamics literature's *frozen*, `[AlonEtAl2021]`; `[PeledSpinka2023]`'s *rigidity* of ℤ^d colourings is another notion.)
  G61(4)'s "supply of unit vectors" has its
  mechanism here: supply is what covers the residue circles. *Do: before building fabric over a field, take the direction set's CM
  field, classify the primes above 5, 7, 11, 13 in `E/E⁺` and compute the targets; run the quotient at every admissible `N` and the
  periodic Kempe screen at every target; spend a solver only where every colouring found is rigid at the target — and if that
  lattice's rank is the field's full degree, expect density only at `10⁷` points and price the shape (word ball, metric ball, core,
  the two-stage survivor route) before building anything. Killing
  test: a lattice rigid under every periodic colouring found whose finite balls all four-colour with `(0, δ)` separated — a
  non-periodic escape, the inheritance question row 67 leaves; or a rank-4 lattice loose at every odd prime that still forces.*
* **G70 — √3-clean is residue: on the Moser lattice a four-colouring escapes Theorem B's colouring only through a monochromatic
  √3-pair. [hand; Coxeter, 2026-09-08 (MASCOT-T6–T11, `plans/MASCOT-derivation.md`); re-derived by the owner at FS-71; minted at
  Kooshi's call, 2026-09-22]** A proper four-colouring of the rank-4 Moser lattice `ℤ⟨1, ζ₆, ω₃, ζ₆ω₃⟩` with no monochromatic pair
  at distance √3 is one of Theorem B's two residue colourings up to relabelling: a √3-clean hexagonal shell forces its antipodal rim
  points equal, so `c(x + 2u) = c(x)` for every unit vector `u` and the colouring factors through `R/2R ≅ 𝔽₄ × 𝔽₄` (2 splits in
  `ℚ(√−3,√−11)`, `33 ≡ 1 (mod 8)`, each factor of residue field `𝔽₄`), where the unit vectors land in `𝔽₄ˣ × 𝔽₄ˣ` and the quotient
  graph is `K₄ × K₄`, whose only proper four-colourings are its two projections (Greenwell–Lovász). **The dichotomy:** every
  four-colouring of K-fabric either has a monochromatic √3-pair or identifies every pair whose difference lies in `2R` — the
  distances 2, 4, 8/3, 8/√3, 4/3, 4/√3, 2/√3 at once — which is why `[Parts2020hv]`'s table of mono and non-mono gadget distances
  has the shape it has, and the √3-*dirty* colourings are where row 67's 2-adic depth stratification lives (the theorem says
  nothing about them). **Consequences (MASCOT-T7–T10):** the `ρ₄` theorem realises an unconditional √3-pigeonhole inside
  K(√7)-fabric — a 6-open field — so Act One of a five-forcer exists there by theorem and only the kill is open; `core9_plane`'s
  nine-point carrier is intrinsically a ℚ(√5)-object and cannot be drawn in K(√7)², so the kill cannot be borrowed from Heule's
  field; and the mascot — `[Parts2020hv]`'s human-verifiable proof with its one √5 step (the `arccos(7/8)` pinning rotation)
  replaced by the Moser twist `arccos(5/6)` — is one open lemma away (T10's one-case dichotomy). Prior art: the `K₄ × K₄` step is
  classical; the hexagon lemma and the identification of the doubling quotient with the two primes above 2 are Coxeter's. *Do: on
  K-fabric ask the √3-pair question first — a colouring with no monochromatic √3-pair IS the residue colouring and identifies every
  `2R`-pair without a solver — and read rigidity (FS-73) as "which colourings are √3-clean"; a five-forcer over K(√7) starts from
  the `ρ₄` pigeonhole and needs a kill drawn in a field with no √5 (FS-49). Killing test: a four-colouring of the Moser lattice with
  no monochromatic √3-pair that is not a residue colouring — a defect in the hexagon lemma or in `R/2R ≅ 𝔽₄ × 𝔽₄`.* **Held exhaustively on de Grey's lattice** (FS-73, row 78): of its 12
  classes of four-colourings — all of them, since `F = 8Λ` — exactly one is √3-clean, and it is Theorem B's pair. Since row 85 the classes are derived, not enumerated: every colouring is a striped colouring of the 64-vertex torus pulled back along one prime above 2 (G75).
* **G71 — Three colours are linear, four are not: a three-colouring of a lattice graph has a height and a slope, a four-colouring
  only a parity. [hand, two independent derivations (row 79); the lift is prior art — Chandgotia's height functions]** `K₃`'s
  universal cover is a line, so every proper three-colouring of a Cayley graph of a finitely generated torsion-free abelian group
  lifts, through the grid that covers it, to an integer height with a winding on the relation lattice and a slope in a rational
  polytope. Hence three-colourability is the non-emptiness of `Θ₃ = {θ : θ(S) ⊆ [1/3, 2/3] + ℤ}` on the character torus, periodic
  three-colourings are dense (so a pair every periodic colouring identifies is forced, and colourable means periodically
  colourable — with no arithmetic of the lattice), and the forced group has finite index exactly when `Θ₃` is finitely many points;
  isolated points of order 3 make every colouring affine, which is how ℚ(√11)'s `F = 3Λ` falls out with no forcer. `K₄`'s square
  complex is `ℝP²` (the cube modulo its antipode), whose one loop invariant, the ℤ/2 winding in `Hom(R, ℤ/2)`, is each relation's
  length parity, fixed by the graph (row 80): no height, no slope, no polytope from loops. Edge-local heights need a sum-closed half
  of `S` (Moore–Newman's triangular lattice and its degenerations, rank ≤ 2, all four-colourable; the grid's absence of
  one is `[CGHO2025coh]` Thm 1.1, FS73-T29's prior art), so the absence holds wherever a certificate is wanted (G73) — `G(ℤ, {1,3,4,5})`
  four-colours with no linear colouring — and whatever makes de Grey's lattice rigid at four colours (`F = 8Λ`, row 78) is not a height
  of this kind, even on its own language — it is a linear identity and a tight quotient (row 85, G75). Everything the hunt asks lives at four colours and above. The index of a density trace (row 132) is this height on a curve; its bound between complementary curves fails only at a swap, which a unit-arc interface facing a bowtie forces: Condition 5 buys general position, not the height. *Do: when a question is at three colours on a lattice, decide it by `Θ₃`; over a whole real number field it is decided already (row 99), so ask a lattice only for a finite witness. Decide it by `Θ₃`, an exact polytope tree with
  Farkas leaves, never by a ball and a solver, and read its cells: empty refuses; points of order 3 mean every colouring affine and a
  finite-index `F`; a fat cell means infinitely many colourings. At four colours expect no slope, no linear criterion and no
  two-sided certificate (decidability is stated open in print): a refusal there is a finite graph, or an averaged or non-local
  certificate (G73). Nothing kills the three-colour theorem; it forbids a three-colour
  counterexample to the inheritance question on any abelian Cayley graph, and a `Θ`-type certificate built from edge-local heights at four colours anywhere in the class.
  Killing test of the reading "at four colours the arithmetic must enter": a four-colour rigidity theorem over a class of lattices
  that uses no arithmetic of the lattice — not met at FS-79 (P-G71); **met at FS-85 in the abstract class** (row 86, no arithmetic), so the reading survives on unit-distance lattices only, where row 85 uses the dyadic primes; FS-86's field-level results all use the tight dyadic place (P-G71′ met).*
* **G72 — Pose a question that cannot be answered without an invariant every solution carries. [method; Kooshi's wording,
  2026-09-23; one instance (FS-73)]** Retired to `plans/GROKKINGS-RETIRED.md`; carried by `.claude/agents/poros.md` job 1 (the structural form) and `.claude/agents/ephodos.md` §IQ.
* **G73 — Four colours, cell by cell: the colour complex gives a four-colouring of a lattice graph nothing to certify with, one
  cell at a time. [hand, two independent derivations (de Bruijn, Coxeter) read by Poros, with exact rank checks (row 80); one
  reading]** Read `K₄` through the cells of `Cay(Λ, S)` and every local invariant a certificate could use is empty or blind.
  **Loops:** the ℤ/2 winding is each relation's length parity, fixed by the graph (`Q₃ = K₄ × K₂`). **Edges:** a non-trivial
  edge-local height exists iff `S` has a sum-closed half (`±{a}`, `±{a, 2a}`, `±{a, b, a+b}`, rank ≤ 2) — Moore–Newman's height,
  which is the `V₄` structure of `K₄`'s three perfect matchings, the three components of the Kneser graph `KG(4, 2)` — and every such
  graph is four-colourable; from five colours up `KG(k, 2)` is connected and no presentation with two generator classes carries one.
  **Faces:** monopoles kill the skyrmion class, the parity-free flux is `dη + κ` once three directions span induced cubes, and the
  signed flux cancels on every odd relation. **The domain's topology:** the coindex bounds stop at four on every K₂,₃-free graph
  (Simonyi–Tardos), so on every unit-distance graph; the index bounds are untouched. So on a triangle-free lattice a four-colour
  certificate, if one exists, is averaged (window frequencies, exact in rank 1, to be kept small by the symmetry in rank ≥ 2), non-local
  (cocycles reading windows of radius ≥ 2, `[CGHO2025coh]` Thm 5.8's route) or structure-derived (group ring, counting on a base
  pattern). **On de Grey's lattice** (rows 85, 87) radius-1 averaging cannot lift `120Λ` to `8Λ`; the
  proof that does is structure-derived (G75). **What survives, colour-generically, is a looseness instrument:** a full-dimensional cell of `Θ_k` gives `P = F = 0` at `k`
  colours, as at `L21cc6506` (row 81; G21's one-period census). On field planes in FS-86's class S2 the measurable-window format and finite-type character colourings are closed at four colours (rows 91–92). *Reading, with its test (Poros): arithmetic cannot enter an averaged certificate as a residue label — the product of an invariant measure with
  Haar measure on the 𝔭-adic odometer is always a consistent joint. Killing test: a residue-labelled window LP that refutes where the
  same window's unlabelled one does not.* *Do: when a four-colour certificate is wanted on a lattice graph, build no cell-local
  topological invariant — an edge height, a loop winding, a face flux or a coindex bound is empty or blind by theorem — and price a
  window-frequency LP whose size the point group controls, a radius-≥ 2 cocycle or a structure-derived certificate instead (FS-80);
  when a lattice looks rigid on one period, compute its `Θ_k` cells before calling it rigid — one full-dimensional cell makes it loose.
  Nothing kills the four no-gos; they forbid a cell-local topological certificate of non-four-colourability anywhere in the class, a
  coindex certificate of five on any unit-distance graph, and an edge-local height at five or more colours on any presentation with
  two generator classes.*
* **G74 — Read a field's plane one layer at a time: every unit-vector set holds the rational pattern, and one relation among layers decides three colours for the whole field. [hand, two independent derivations (row 82); the lift is FS73-T22's, hand; one reading]**
  A three-colouring of `F²`, for any `F ⊆ ℝ`, carries a **field-level slope** `θ ∈ Hom(ℤ[U_F], ℝ/ℤ)` with every unit vector in `[1/3, 2/3]` — FS73-T22's height on every
  finite set of unit vectors, then compactness (G71 at the field level; in the literature's words, a circular colouring given by a character). `U_F` is a union of **layers**
  `b·U₅`, rotated copies of the rational unit vectors with 5-power denominators (G62's multilayer, for the whole field), and on each layer a slope has **one of two types**: the parity character plus an archimedean character of norm at most 1/6, or one of the four order-3 characters (C1(5), from FS73-T40's exact cells). A relation `1 = Σ c_j u_j` carries the
  types across layers, and the archimedean parts cannot absorb a finite-order discrepancy, because every layer holds `5^{−k}` for every `k`; so `1/3 ∈ ℤ[U_F]` plus an odd cycle
  leaves no slope and the field needs four. The field is incidental: any multiplicatively closed `U ⊇ U₅`, and five layers `{vᵏ : |k| ≤ 2}·U₅` already suffice (FS81-T5). **The
  mechanism in the discipline's words** [reading]: `U_F` is the rational points of a torus, the layers are its cosets through the rational pattern, and `Θ₃(F)` is rigid only
  modulo the archimedean places; `[Fischer1990]` had the relation and stopped at additive colourings for want of exactly this. **Where it stops:** from four colours up there is
  no height (G71, G73), so a point of `Θ_k(F)` still colours the whole plane but emptiness proves nothing about `χ` — one-sided there (FS-83); and the residual three-colour case, primes
  above 3 of odd residue degree ≥ 3, closes without `1/3`: four, by no mixing (row 99). *Do: when a question is three colours over a whole field — any subfield of ℝ, any degree — ask
  whether `1/3 ∈ ℤ[U_F]` and whether the plane is bipartite, and answer before building anything; when a field-level question at any `k` resists, factor `U_F` into layers of a
  base pattern, classify the base pattern's rotation set exactly at the band (T40's cells), and glue by relations — naming the step that uses infinitely many layers, because a
  finite configuration holds points the field does not (FS81-T8: at depth `J` the archimedean parts absorb a parity discrepancy while `5^J ≲ 0.25·d`). Nothing kills the
  three-colour theorem but a defect in its chain; it forbids a three-colouring of every plane with `1/3 ∈ ℤ[U_F]` and an odd cycle. Killing test of the reading that the rational
  layer's rotation set is always a disc plus finitely many torsion points: T40's cells at the band `[1/4, 3/4]` or `[1/5, 4/5]` holding a third kind of cell (FS-83's first step) — **fired at one prime** (rows 97, 102: two leaves glue, and minimal sets escape too); over two or more primes it holds at every band (rows 95, 98).*
* **G75 — Where triangles enter four-colour rigidity: as a local linear identity that pins the spectrum. [hand + tools exact (row 85); one reading]**
  On de Grey's lattice, with colours as the vertices of a regular tetrahedron, "no monochromatic √3-triple in family `k`" (Parts's
  theorem placed in `Λ`) is the eigen-equation `A_k g = −2g` of the family's hexagon operator, whose symbol `(1+X)(1+Y)(X+Y)/XY` is the
  triangle relation `1 + ζ₆² = ζ₆` made algebraic: the spectrum lies on three circles per family, the nine families' circles meet in 42
  torsion characters, exactly the dual of `8Λ`, and a Smith form reads off the period (C7, C8). The inner families leave 7,290
  (`120Λ`); odd-index cosets carry the identity outward (C15), and the 5-part dies **pointwise**, slice by slice, at the tight dyadic
  quotient, a tetrahedron-valued `G + H` being constant in one variable (R3a; FS-67's product shape) — not by second moments (row 87),
  and the infinite lattice is slack. Without triangles rigidity is free in the abstract class, Soifer-strength in the plane (row 86). On the triangular lattice the stripe lemma (kernel, row 106) uses the triangle condition once, to make one line two-periodic; properness does the rest. *Reading* (Coxeter's R2.6): in a
  triangle-free lattice the analogous frequencies are generically non-torsion, so the mechanism has nothing to pin. *Do: when a lattice
  looks rigid at four colours, find a local forbidden pattern that is linear on the tetrahedral embedding, intersect its zero sets on the
  character torus, read the period from a Smith form, and kill what the spectrum leaves pointwise at a tight quotient — never by second
  moments. Nothing kills the derivation but a defect in the chain or in Parts's trees (walked, row 85); it forbids a four-colouring of de
  Grey's lattice that is not `8Λ`-periodic. Killing test of the reading: a triangle-free lattice whose NT-type identity pins the spectrum onto finitely many torsion characters (FS-59; not fired at FS-86, where no pinning identity was found on a type-(B) plane and pair correlations provably cannot pin on a real field, row 91).* *The method is Kari–Szabados's annihilator method, and one family alone is Puzynina's exceptional case (`det(B + I) = 0`), which is why one family cannot give periodicity (row 85's attribution); on type-(B) planes such an identity valid for every colouring exists iff `F(R) ≠ 0` (FS86-Cx-C11), so the identity is the question.*
* **G76 — Four-colour rigidity over a field is a local theorem and a global extension question; every construction of a "no" that reads finitely much dies, and no character is one. [hand, two derivations for the frame, the local theorem, the no-gos and the measure half (rows 88–92, 111–113); the obstruction a reading, reached twice independently]**
  Over a real field with one stable place tight at four colours and every other factor of all-levels ratio `< 1/4` (FS-86's S2), periodic
  four-colourings are pullbacks from the tight place and a non-zero forced group is an ideal of finite index, so rigidity is one pair (row 88);
  the local plane at that place is rigid, triangles entering only through the local forcer (row 90), so the question is whether the field
  realises a local forcer — `4 ∈ F_tf`, a question about number fields inside the completion. Two tight places give a choice per coset (K,
  row 89); a slack stable place gives non-periodic colourings (ℚ(√11), row 94). **A "no" must disagree with every pullback in every
  archimedean direction, patch no two pullbacks, and read infinitely many split places** (rows 91–92). For characters the exclusion is **closed-set** (Furstenberg–Berend) rigidity on `R̂` with the archimedean
  directions rotated, and it holds at two or more primes at every band: minimal sets are band-free (Berend's Thm I.2) and the band enters once, in a multi-digit
  sweep (rows 95, 98; on the half ring it is `[Manners2015]`'s pyjama lemma); so HD1 holds (row 96); at one prime points, minimal sets and
  torsion orders all fail (rows 97, 102). **For vectors of characters** a split place pairs its conjugate primes into a cross (`ψ_w(u) = 0` or `ψ_w̄(u) = 0` on every unit vector): no naive vector band rigidity, Kronecker selection onto `T + A` false (row 116), and a closed invariant set may be a union of subgroup translates (`[LindenstraussWang2012]`), which a saturation statement must allow. **At five colours over ℚ(√167)** (row 110) a factor leaves a product colouring when its compact pieces mix (`λ* < 1/4`, a spectral Burr–Erdős–Lovász), not when its ratio is small (false at 125 colours); twelve places do not mix, so the window question lives at nine places, and with a real place it is `χ_B(ℝ²)`'s. **For colourings** rigidity splits into invariant measures and transience — the measure centre of every orbit closure inside the pullbacks (row 111); a spectrum carried by `T + A + Fin_S`, `S` finite, extends to the completion and a stationary count against the tight factor makes it a pullback (row 112), and at ℚ(√47) no such spectrum exists (row 113); given MR, over the type-(B) fields every rotation-invariant random four-colouring is a pullback and row 88 ⟺ no rigid-motion-transient colouring (row 124); the translation-invariant half is TR-ROT; a transient colouring is invisible to every measure method. *Demotion record:* this entry said "measure rigidity … not in print"; the
  question was about closed sets, where Berend's proof survives with the rotated plane set aside. *Reading:* for all colourings the obstruction is the real place (non-real analogues are pinned on `T + A + Fin`, row 94) — false on `T + A + Fin_S`, where the real place is an input (`m₁ < 1/4`, row 112); **demoted in MR's form** (row 120; the ×2×3 crunch's §5 item 7, its registered falsifier, fired): a rotation-invariant colouring's spectrum is Haar plus a part on `T + A`, so infinite-place spectra are out; the real place is where non-Haar invariant measures survive, and it lies inside `E`. The reading survives only for transient colourings (T-B1, FS-98). Killing test: a non-periodic four-colouring of
  ℚ(√−709)'s plane. *Do: when a field has one tight place and every other factor below `1/k`, state its `k`-colour rigidity as one forced
  pair at the tight place's depth, never as a lattice question; aim at realising a local forcer or at colourings no character gives, and build no
  non-periodic colouring from finitely many places, measurable windows or one character — excluded by theorem; when the question is a closed
  invariant set of characters under a rotating group, run Berend's dichotomy with the rotated plane set aside and count the primes first
  (one is not enough); test a statement about several characters against a split place's pair `(ψ_w, ψ_w̄)` first; when an invariant measure's spectrum reads finitely many places, extend it to the completion and count (row 112), never search for its falsifier; never write 'row 88 ⟺ Q-tr' (row 124); when a group of multipliers has polynomially many elements of bounded height, run Einsiedler–Fish's pigeonhole with the product formula before calling a measure question ×2×3-hard; with two tight places expect a choice per
  coset. Nothing kills the frame or the no-gos but a defect in their chains; they forbid a periodic non-pullback colouring and every "no"
  of the excluded formats.*
* **G77 — A character colouring of a field plane is local in the existence sense only: the value-set profile peels. [hand, two independent derivations (rows 98, 100), given band rigidity at every band]** A band character of `R_F` is torsion plus archimedean; its archimedean part is zero at each complex place and an interval about 0 at each real one; the torsion part factors over the stable places (`R_F = O′`); and when symmetric subsets of the circle add up inside the band, **some** one of them already lies in it (the peeling lemma). So a band `k`-character exists iff a residue target at some level has one, and `χ_char(F²)` — `[BarajasSerra2008]`'s regular chromatic number — is a minimum over targets. **Existence, not classification:** CLG does not say a given character colouring comes from one place; that is proved at three colours (no mixing, row 99) and at HD1's fields (Lemma D), and open elsewhere (FS-92). On a finite plane a character colouring is a regular colouring of a circulant, weaker than a colouring (`χ_char(Γ₁₁) = 6 > 5`) and than a line-periodic one (`χ_char(Γ₄₃) = 9 > 8`). *Do: when a question is about character colourings of a field plane, compute each residue target's `χ_char` by its trace sets below Weil's threshold and take the minimum — no lattice, no solver; state the result as existence, and name the extra input (no mixing, Lemma D) before saying every character colouring is local. Nothing kills it but a flaw in the derivation; it forbids a character colouring with fewer than `L(F)` colours at `k ≤ 5` and over quadratic fields. Killing test of the reading that CLG-g's exception is never realised: a band 6- or 7-character above level one of a `U₆₄` tower, or at level `2e + 1` above 3 at `q = 27`.*
* **G78 — Rank-one inheritance is "countable ⟹ finite", and Kempe moves cannot see a frozen wall. [hand, two derivations (row 108); tools exact on named sets; one reading]** The four-colourings of `G(ℤ, D)` form a one-dimensional SFT; all phases rigid is zero entropy, and R2 says such a shift is finite — equivalently `P₄ = F₄`, equivalently no heteroclinic colouring has an all-rigid completion `X₄(D_c(M))`. In an all-rigid shift the periodic points are gap-free with two-sided strands, and Kempe moves never bring a wall point's two tails into one labelled phase; at frozen tails Kempe moves only relabel, so the frozen part of R2 needs an invariant no Kempe argument supplies. *Reading:* all-rigid shifts are Kempe-rich (`{2,6,11,13,14}`: 94 phases, none frozen). *Do: when a rank-one colouring question resists, restate it on single colourings and split it at frozen tails before choosing a Kempe route. Killing test of the reading: an all-rigid `X₄(D)` with a frozen rigid point. Nothing kills the equivalences; they forbid a Kempe proof of the frozen case.*
* **G79 — A wall arrives as a counterexample's invariant; the breakthroughs came from an example's. [method; Kooshi's wording, 2026-09-25; new, untested]** *"This is an interesting grokking too: walls often show up as 'the (impossible?) counter-example invariant' and we have had a successful breakthrough when looking for the 'example invariant'."* A no-go says what a counterexample must carry, a class that may be empty: rows 96, 113; G22; G48, G31; G57. What moved a question was an invariant every actual solution carries: G71 and G74's slope, G75's eigen-equation, G76's locality, row 95. It is G72's dual: G72 asks about every solution; G79 says which invariant to hunt once a wall stands. *Do: when a wall hands back a no-go ("a counterexample would need X"), flip the wanted poster — ask what every solution the problem already has must carry, and derive that before sharpening the no-go. Killing test: a breakthrough that came from a counterexample invariant alone, or flips that keep producing nothing, make the rule ceremony; a close records only such a counterexample and keeps no running count (2026-09-28). Its record to that date: `plans/GROKKING-INSTANCES.md` §G79 (FS-106: the headline from an example invariant, the walls from counterexample invariants).*
* **G80 — Infinite rank is the resource: the unit-vector group is large enough for rigidity that no finitely generated piece has. [hand theorem + reading]**
  `U_F` has polynomially many elements of bounded height; no finitely generated subgroup does, and none acts irreducibly on `R̂` (row 118). The classical
  ×2×3 question lives at finite rank; `U` sidesteps it (row 120): positive entropy is Einsiedler–Lindenstrauss (their Thm 1.3) on each finitely generated piece, all of it at finite places since `U` is isometric at every archimedean one, zero
  entropy is Einsiedler–Fish's pigeonhole run with the whole group's growth, and what survives is the archimedean isometric layer, inside `E`. *Do: when a
  question over a field's plane reduces to invariant measures under `U_F`, count the group's elements by height before calling it ×2×3-hard — any positive exponent suffices, the degree entering constants only (FS-105); transfer a
  one-dimensional polynomial-growth theorem by running its Diophantine step through the product formula at all places. Killing test of the reading that
  this extends: a real field whose `U`-invariant `E`-null measures are not Haar (row 100's exception fields are uncovered for MR; they have `L = 2`, so no colouring consequence is lost, row 123). Since row 129 MR is testable on finite graphs: a proof that `α₁(ℝ²) > m₁(ℝ²)` refutes it at ℚ(√635087).*
* **G81 — Where every place mixes, the field is the plane. [hand, two blind minds (row 128); the ambiguity reading one mind]** A stable place whose local piece mixes (`λ*_v < 1/(k−1)`, both signs, every level) drops out of any `k`-colouring question (G76's selection, now over infinitely many places at once, the count entering only at the pigeonhole `max_j m_j ≥ 1/k`), and MR removes the one other escape, an SP witness. So at a totally real field with every stable place 6-thick — ℚ(√635087), de Grey's field — `χ(F²) = χ(ℝ²) = χ_CP(ℝ²) = χ_m⁰(ℝ²)` (rows 128, 130): the field's arithmetic is invisible, and `[Payne2009]`'s *ambiguity* (`χ ≠ χ_m`) lives only at non-thick places — his examples ℚ and ℚ(√3) are the chain's stopping controls; the Soifer–Shelah translate graphs (`[SoiferShelah2004g]`) are ambiguous even modulo null sets of edges, their connection set accumulating at 0, where the unit circle's does not (two readers: the consolidation run's LW3, FP). One arithmetic fact is read twice: de Grey's graph needed a field that no small residue plane seals; the collapse needs a field with no place a colouring could use to beat the plane. *Do: when a question is `χ(F²)`, list the field's non-`k`-thick stable places first (exact spectra, both signs, every level); with none, given MR, it is the plane's question — spend nothing field-specific on it; with some, the field's own content is product locality at exactly those places (FS-67). Killing test: a totally real field with every stable place 6-thick whose plane's chromatic number differs from `χ(ℝ²)` — it refutes MR there.*
* **G82 — The measurable question is a stability question: a refutation is regular, and only its limit is wild. [hand, two minds, one blind
  (row 131); the reading one mind, corrected at FS-107]** A weak-* limit of near-colourings is a colouring (the circle measure is Rajchman), so
  `χ_m⁰ ≥ 7` is the stability of a regular theorem: W's objects are periodic tilings checked exactly, and R must count a defect at a scale
  independent of `ε` — spread over positive measure, or at features whose own scale is bounded below (row 133's (B)). *Demotion record:* as minted it
  read "R must count a defect non-locally, Voronov's contradiction being feature-local"; row 133's cone lemma is feature-local and `ε`-independent —
  feature scale is not band scale. *Do: when a question asks whether a class of colourings exists, ask whether its limit object is a weak-* limit of
  regular near-solutions; if so, pose it as stability, build on the regular objects, test a stability proof against strips and erosion (row 131's
  no-gos) first, and price each certificate at its feature's scale, never at `ε`'s — and where the limit object is a map, look first for the printed regular
  theorem's own chain (FS-110: S–V's Cor. 1 and Woodall's step 3, made curved and almost everywhere). Nothing kills the equivalence; it forbids a construction needing a
  wild set. Killing test of the reading: a proof of `lim µ₆(ε) < 1` whose features' scale is not bounded below.*
* **G83 — With unit arcs, the tight question lives at one four-colour vertex. [hand, two minds, one blind (rows 135–138); the reading one mind]**
  The unit-radius tactic survives reduction only at vertices of four or more colours, and every valid map has one (row 137, two minds blind to each
  other), so an exclusion at an explicit radius about a single such vertex suffices for the NO; the count (route T) gives six room only at degree-4 four-colour
  vertices with three or four tactic edges, and every such configuration examined died by a straddle — two tiles of one colour forced along two unit
  circles to come within 1 — at `√3` or `1 + ε` (row 138). *Reading:* what is left is four-colour vertices whose rings carry (Q) arcs, the class every
  exclusion so far had to except; killing test: a valid fragment by formula about such a vertex beyond `φ²/√2`. *Do: when a tight-map question admits
  unit arcs, take one four-colour vertex and ask what its ring carries (a (Q)-free ring's change points are four-colour vertices, N7-HUB) before
  excluding its next escape, and hunt the straddle along two unit circles. Nothing kills the theorems but a defect in row 134's base; they forbid a
  valid map with unit arcs and no four-colour vertex.*
* **G84 — Contact is the regularity mechanism: a saturated or maximal class is carved by unit circles about its own points. [hand; the pinch lemma three minds, the shadow identity two, bands and ladders one]** In a saturated colouring a two-colour interface point lies on a unit arc whose centre carries both colours, or on a `C^{1,1}` curve with `|κ| ≤ 1` between two tangent unit discs — no partner density needed; de Grey's Reuleaux 4 + 3 seven-colouring is the inhabitant (row 140). A maximal class is a fixed point of its unit shadow, `int F = ℝ² ∖ (F + S¹)`; maximal covers are free (Zorn), maximal partitions are measurable fall colourings, saturated. Maximality leaves bands free: a flat side facing its class across 2 needs material at distance 1 whose thickness may vanish on any closed set, and in a partition such a pinch climbs a short ladder of unit parallels to a junction (row 141). *Do: when a regularity question about a tight colouring arises, pass to a maximal cover and read each boundary point's contacts first; spend effort on the singular set and on blocks facing across 2 — draw the ladder, find where it ends; never ask a selection from a cover to be saturated unless the cover is a partition. Killing test: a saturated colouring with a two-colour, locally connected interface point that is not `C^{1,1}`; or a maximal partition whose ladder outlasts FS111-M4-CUT's bound.*
* **G85 — Saturated interfaces have integer radii. [hand; two minds on the core, one on finiteness]** Off a singular set that is locally finite with finitely many arcs at each point, the unit parallel of a saturated interface is an interface, so radii fall by exactly 1 toward the centre and stop at 1 — row 134's shadow map on saturated colourings: interfaces are segments and arcs of integer radius (row 140). What escapes is radii → ∞: thin pencils, along a whole unit-spaced normal line (FS121-O1-LRA-LINE, FS121-D2-THIN), and none under a cocompact symmetry (FS121-D2-SYM). *Do: before asking whether a saturated colouring can bend, walk its unit parallels toward the centre; a chain that cannot end at a unit arc or at the singular set cannot exist. Killing test: a saturated colouring with a locally finite singular set and an interface of non-integer radius.*
* **G86 — Tile counts are blind to Siamese pairs: a count reaches the non-Siamese part, and a Siamese kill reads points and distances. [hand, one mind
  (FS114-N2, row 137); the reading one mind]** Euler's formula fixes a map's average number of neighbours, and a six-colouring pays for neighbours beyond
  five with repeated colours — a unit arc about a four-colour vertex, or a Siamese pair (tiles of one colour within each other's exclusion annulus).
  Where Siamese pairs are allowed a tile can be cut into any two-colour map, so no density bound exists and a Siamese vertex pays its demand at no cost:
  no count over tiles charges it (N2-REFINE). So a count gives the non-Siamese NO at best — de Grey's target (`[16.317]`), Thomassen's theorem without
  scalability — and the whole NO must be a local exclusion reading distances between points of colour classes. *Do: before a counting or discharging
  route to a map-colouring NO, ask whether the class allows Siamese pairs; if it does, put "non-Siamese" in the count's headline and aim the rest at a
  distance argument. Nothing kills the refinement lemma; it forbids a tile-count proof of a NO for a class with Siamese pairs.*
* **G87 — The invention signal: two truths that contradict, or a whiff of them. [method; Kooshi's wording, 2026-09-28; new, untested]**
  *"we have one low frequency, high value gap. Every time Poros is active, it needs to look for the signal for invention: two
  contradicting truths, or even a whiff of them. Add it in its jobs, as well as in the main instruction file so that everyone is on the
  lookout."* The signal is what `ephodos-invention` begins from, a collision, in the four kinds its § the_collision names: "Two held
  descriptions both apply and disagree"; "A derived consequence the frame refuses"; "A proof or a construction that will not close";
  "A paradox dismissed". The easy exit is to settle it on the spot — one side called wrong, the case excluded, the consequence called an
  artifact — and the exit hides the premise both sides share, which is where an invention starts. Poros looks for it in every job and
  writes a line on it in every record (`.claude/agents/poros.md` § Your jobs); every other mind reports one when it sees it. *Do: when
  two things held here — results, readings, descriptions, a theorem and a measurement — give answers that cannot both be true, or you
  catch yourself about to exclude a case, dismiss a consequence, or push a proof that keeps failing on the same line, state the
  collision in the words of both sides, with both addresses, and report it to Keryx as an `invention signal` item, without picking a
  side; Keryx routes it to Poros for a card and on to Ephodos, who works it with `ephodos-invention` once recognition's homes are
  killed. Killing test: a collision found afterwards on record, unreported, in a milestone whose minds were on the lookout (the lookout
  did not install); or signals raised close after close with none worth an invention job (the threshold is set too low).*
* **G88 — Curved tangent interfaces are the honest class's whole open content at the ends. [derived (held lemmas) + one-mind composition; a reading]**
  In an honest saturated colouring with REG-J′ a tangent arc of radius `n` forces tangent arcs of every larger radius over its window (FS121-O1-OUT),
  an (R2) arc is a tangent unit arc, and LRA puts tangent arcs of radius ≥ 2 in the colouring (FS121-D2-INCURVED); so a NO to curved tangent interfaces
  makes C121-R2-FOUR vacuous, gives ¬LRA, and leaves every curved interface a split (Q) arc (FS121-Z1-NOCURVED); and under a cocompact symmetry there are
  none (FS121-V5-SYM-CPT). *Reading:* aperiodic honest saturated colourings have no curved tangent interface either. *Do: when a question about saturated
  interfaces asks where ladders end or whether radii accumulate, ask first whether the colouring can have a curved tangent interface at all, and if it
  is periodic answer no. Killing test: a curved tangent-type interface in an honest saturated REG-J′ colouring at some `k ≥ 7`, by formula with an exact
  check.*
* **G89 — Honesty is free; the six-colour content of saturation is the top colour. [hand, two minds each on GRUNDY and FALLSAT; one mind on EQ]** Every
  a.e.-proper colouring becomes a measurable Grundy colouring without raising a point's colour index, bound at each interface on every colour but the
  largest (FS121-D3-GRUNDY); every measurable idomatic partition is saturated, and saturation is strictly weaker (FS121-D3-FALLSAT, -SWAP1D); a Grundy
  colouring that is a map is bound one-sidedly in its lower colours (FS121-C1-GMAP). So binding the top colour (TOP₆) is all of honest saturation at six,
  and given a NO for honest saturated colourings it is the answer (FS121-D3-EQ). *Do: when a route needs a saturated or maximal colouring, Grundy-ize
  first and state what is left as the top colour's binding, a coverage question on its boundary's unit circles (G13); read the cover route's class as
  Grundy maps, never as a maximal cover's merged map (FS121-C1-COVMAP). Nothing kills GRUNDY and FALLSAT but a defect; killing test of "the content is
  the top colour": a saturation procedure at six that binds both sides of an interface at once without a global rebuild.*
* **G90 — Lateral extent against gap: where the plane's curvature enters regularity. [hand, two minds on FACE and GRID; one mind on the rest; a
  reading]** A same-colour piece of lateral half-width `ρ` facing a flat side across a gap `g` with `ρ² ≥ 2g − g²` leaves the side's point no contact
  (FS121-D4-FACE, -V5-FACE-SHARP); on the line nothing replaces it and local finiteness fails with two colours (FS121-D4-LINE); regions can be as small
  as wished at sixteen colours (FS121-D4-TINY16), so no count per region bounds the singular set. *Reading:* an accumulation of the singular set needs
  same-colour pieces shrinking faster than the square root of their gaps (LAT's open case). *Do: before bounding a singular set by a count per region,
  ask lateral extent against gap at each accumulation; spend the plane's dimension at distance exactly 1, the sagitta of the unit circle. Killing test:
  an honest saturated colouring at some `k`, by formula, whose singular set accumulates with pieces shrinking slower than the square root of their gaps
  (it would refute FACE, a defect), or one with point-like accumulation (it refutes C121-REGJ and confirms the reading's open case is real).*
* **G91 — The ring is the pigeonhole: a four-colour vertex's unit circle is a twisted colouring of its 60° hexagons, its change points place four-colour
  vertices, and the defect-free ring is empty. [hand: FS116-RING-TWIST-C, -RING-GERM, -N3-SEMI and -Y4-EMPTY held (two minds each, one prior); the placing
  rule assembled at one mind (FS116-RING-TRANSFER-QC); the reading one mind (FS116-N2)]** Points 60° apart on the unit circle `ω(p)` are 1 apart, so in a
  valid six-coloured fragment the ring of a vertex `p` of at least four colours is, off the boundary, a proper colouring of its 60°-hexagon graph by the two
  colours absent at `p`, alternating under the 60° rotation (RING-TWIST-C). Its defects are where `p`'s own colours reach it: (Q) arcs, other arcs of `Γ`,
  and the tips at its change points. A change point whose `±60°` germs lie off (Q) arcs is a vertex of at least four colours (RING-GERM), and every semi-hub
  but the full parallel one of three colours places one at itself or 60° along the ring (SEMI, by the cone calculus at the unit rhombus `p, u, y, v`); so
  four-colour vertices propagate along the unit triangular lattice until a (Q) arc intervenes. The defect-free ring — no arc of `Γ` at all — is empty at
  `1 + ε` in the non-Siamese simple class (EMPTY): four tiles of diameter at most 1 cannot tip six hubs without one tile alone at two adjacent hubs, and its
  two flanking tiles, of one absent colour, are pinned to two unit circles and straddle (G83; `|a − b|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2)`). Six is
  spent where the ring has exactly two absent colours and where the tip sector holds only `p`'s colours. *Reading* (FS116-N2, one mind): the transfer at a
  hub is a homomorphism into the Kneser graph `KG(6, 2)`, the placed missing pairs living in `KG(4, 2)`. *Do: at a vertex of at least four colours in a
  six-coloured map or fragment, read its ring before anything else — the alternation, the change points, the defects — and place the four-colour vertices
  its change points force; and before building on a ring type's structure lemmas, ask whether the type is inhabited: the structure that pins it is usually
  its kill, found by testing the straddle among the forced pieces first (FS-116's round 3 worked the defect-free type for two rounds before FS116-Y4
  compared its two flank tiles). Killing test: a valid six-coloured fragment by formula, non-Siamese and simple, about a vertex of at least four colours
  whose ring carries no arc of `Γ`, on a disc of radius above 1 (a defect in two routes, never a finding); of the reading, a hub whose placed missing pairs
  leave `KG(4, 2)`. It forbids the defect-free ring past `1 + ε` in that class.*
* **G51 — A competitor and an advisor beat one mind. [measured, one session]** Retired to `plans/GROKKINGS-RETIRED.md`; carried by `plans/PROTOCOL-competitor-and-advisor.md`, the `keryx` skill's `<independence>`, `.claude/agents/ephodos-verifier.md`, and `plans/STANDING-RULES.md` rules 6, 8 and 11.
