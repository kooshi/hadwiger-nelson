# Engineering standard
@DEBRUIJN.md

# Workflow
@WORKFLOW.md

# This workspace — lean-dir

A Lean 4 proof workspace aimed at one target: **the Hadwiger–Nelson problem**. We write theorems,
programs, and tactics to the **de Bruijn** standard (above) and work milestone-by-milestone through
WORKFLOW. Everything reduces to what the kernel checked plus what we explicitly chose to trust.

**This file holds current state only.** Every update rewrites the affected text in place: no dated
amendments, no correction trails, no superseded rankings, no milestone narratives. A corrected claim is
replaced by the corrected claim (with its attribution, if it turned out to be prior art); the story of the
correction belongs in the commit message and the milestone's plan. **History is in git:**
`git log -p -- CLAUDE.md`. The last version carrying the full narrative — every milestone's story, every
amendment and correction trail, every superseded ranking and reading — is commit `fd658af` (2026-09-10).
**Size budget: keep this file under 150,000 characters** (Kooshi, 2026-09-11: the budget is on *this file
itself*, not on the file plus the two imports above — there is a lot here worth remembering). The budget is
a ceiling and never a licence: the current-state-only rule above does the real work, and superseded text
comes out whether or not there is room for it.

## The mission

How many colours does the plane need so that no two points at distance exactly 1 share a colour?
Known since 1950 to be 4, 5, 6, or 7; de Grey (2018) ruled out 4 with a 1581-vertex unit-distance graph
that is not 4-colourable.

| rung | status |
|---|---|
| **A. χ(ℝ²) ≥ 4** — the Moser spindle | ✅ kernel-checked; exercised the whole pipeline end to end |
| **B. χ(ℝ²) ≥ 5** — de Grey's graph | ✅ kernel-checked (M06–M09) on axioms exactly `[propext, Classical.choice, Quot.sound]`; our foundation, not our product |
| **C. The search instrument** — shrinking, criticality, fractional bounds, fans, sweeps | ✅ built through M17, extended by every milestone since |
| **The upper end** — χ(ℝ²) ≤ 7 | ✅ kernel-checked (M36), so the repository holds **5 ≤ χ(ℝ²) ≤ 7** on the standard three axioms. Not new mathematics: it exists because the certificate machinery is the promotion path for any future periodic avoider, and a five-colour avoider IS the open upper-bound problem |
| **D. χ(ℝ²) ≥ 6** — the hunt | open; may not exist; may be astronomically large |

**The mission is exclusively a hunt for new mathematics, however small, ratcheting toward major findings**
(Kooshi, 2026-08-02). A formalized statement earns its place by being structure nobody had named, or a rung
toward χ ≥ 6. State failure modes plainly: a rung that does not land is reported as not landed, never
quietly rescoped.

**The programme** (Kooshi, 2026-09-06; his words and the assessment in full are in
`plans/PROGRAMME-ALGEBRAIC-PROOF.md`): *the derivations are an order of magnitude more important than
individual objects.* A 6-chromatic unit-distance graph is the first instance of a mechanism; the milestone
that finds it continues until the mechanism is stated and proved for a class, and the paper is the algebra
with the object as its example. After the lower bound the same viewpoint is turned on the upper bound; the
aim is one account of the whole problem. **The assessment, stated so it can be pushed back on:** the lower
bound is the side the viewpoint is built for — every upper bound we hold on a field plane is a residue
argument at a small prime, and a forcer is a construction that hides its field from every small prime. The
residue methods as they stand are one-sided and cannot reach the upper bound (a field with no small usable
prime receives no bound from any finite plane, and 𝔭-adic colourings do not glue across fields), so "the
same approaches" means the viewpoint — the arithmetic of small primes governs the chromatic number — and
not the tools.

**Publication.** Write-ups and upstreaming are deferred (Kooshi, 2026-08-04): the rung-B write-up, Mathlib
contributions, exposition, and the M58–M61 sieve arc. What clears the bar:
- *definitely* — χ(ℝ²) ≥ 6 or its refutation, written as the derivation (the programme);
- *maybe, Kooshi's call* — our own certified 5-chromatic object, if what it reveals is interesting enough;
- *a result that answers a question the literature has independently and repeatedly posed*, whatever its
  size. The ledger of such questions is `CLOSED-QUESTIONS.md`. **This has fired once, for Theorem B** (χ(ℚ(√3,√11)²) = 4), which settles a question posed or named as open at least six times across fifty years (the three oldest postings do not cite one another; `CLOSED-QUESTIONS.md` §1.1). The paper is FS-20
  (`plans/STUB-theorem-B-writeup.md`), and **naming is a first-class deliverable**: every working term in
  this repository is coined in-house and appears in no paper — the mechanism G49 says hid the prior art — so
  the manuscript's vocabulary is a design problem with a ban list (`BIBLIOGRAPHY.md` §E is the translation
  table; this project's *direction ladder* is the literature's *Moser lattice*, and new writing uses the
  latter).
- At any write-up, adopt the zeta-23 artifact shape: a tiny trusted `comparator/` surface (Challenge
  statements with `sorry`) over the whole edifice as untrusted Solution, verified by
  `leanprover/comparator` (statement equivalence, axiom whitelist, kernel replay; its nanoda run is the
  independent-kernel publication gate).

`ARCHITECTURE.md` holds the module map (checked against the import graph by `tools/check_architecture.py`) and the roadmap through M20; `plans/` holds per-milestone subplans and
stubs. **The bibliography is explicit and maintained (Kooshi, 2026-09-06): `BIBLIOGRAPHY.md`.** Every
external work this project cites, reproduces, depends on, or corrects is an entry there — added the day it
is first used, with what of ours rests on it, where our copy is (`~/source/library/`), and how much of it has
actually been read, per section. A ledger row or grokking that rests on prior art names its bibliography key.
Titles seen only in search listings are marked as such until checked against the paper.
`tools/bib_audit.py` checks that every cited key resolves.

## Frontier

*The current state of the art, the ledger of everything novel this project has produced, and the ranked
paths forward. Rewritten in place at every milestone close (WORKFLOW step 9); a milestone whose close does
not update this section is not closed. The understanding the results add up to lives in § Grokkings, under
the same rule.*

*Last updated: 2026-09-13 — the backlog branch reviewed (eighteen readers; gate green on the tip) and its record corrected in place; M63 phase H4 open, its last measurement withdrawn at the tip.*

### Where the problem stands

**The problem.** χ(ℝ²) ∈ {5, 6, 7}. This repository kernel-certifies the whole classical interval,
**5 ≤ χ(ℝ²) ≤ 7** (`Instances/Interval.lean`, `chromaticNumber_plane_interval`), on axioms exactly
`[propext, Classical.choice, Quot.sound]`.

**What the kernel holds, beyond the interval** (the ledger below has each result and its address):
**Theorems A and B** and the finite-plane machinery around them (rows 52–60); Theorem A's two-colour case and the 2-adic splitting of real multiquadratic fields, with two test-passing fields whose compositum needs five colours (row 63); the compulsion toolkit —
arity floor, homogeneity, the spindle theorem, critical sets, absorption, additive rigidity (rows 42–51);
**the χ ≥ 6 target as a theorem** — χ(ℝ²) ≥ k + 1 follows from a k-colour virtual edge at √3 AND one at 2,
never either alone, and over the distance set {1, 2} a single five-colour √3 gadget gives χ(ℝ²; {1,2}) ≥ 6
(rows 43, 61); the seam-field closures, each exactly 4-chromatic (rows 1–25); the pigeonhole carriers
(rows 31–32); the cell family (rows 34–41). Also χ(Heule-510) = χ(Heule-553) = 5 and χ(de Grey's 1581) ≤ 5.

**What the hunt has established** (the reasons are in § Grokkings):
1. **The 4/5 wall is 2-adic.** A unit-distance graph forces a fifth colour only if its coordinates break the
   2-adic wall — contain an odd square class ≡ 7 (mod 8) (G1, G35).
2. **The field sieve.** For fields containing ℚ(√3,√11): 6-open ⟺ the 2-adic wall is broken and 11 is inert.
   Every finite plane at p ≡ 3 (mod 4) from 59 up refuses five colours by its spectrum. Every field the
   descent ever used is 5-sealed (G43, G44).
3. **The design target** (G48): a pair forced equal at five colours over a 5-sealed field, at a distance with
   11 ∣ d², then spindled — the spindle removes exactly the sealing prime and lands in a 6-open field by
   construction. This is FS-6, the sequel of M62.
4. **Existing witnesses hold nothing to extract.** De Grey's 1581 at five colours has no compulsion at arity 2
   or 3 (complete sweeps) and arity floor 4 or 5; a χ ≥ 6 gadget must be constructed, not found (G31). The
   null is **stronger than it reads**: his field is 6-open (G43), so no arithmetic bar — not row 55's, which
   is scoped to the √7-free tower — explains the absence. A 6-open platform has carried a five-chromatic
   object since 2018 and yielded no five-colour compulsion at arity ≤ 3.
5. **An in-field descent cannot end.** Points of ℚ(√3,√11) do intermediate kills and never the last one; the
   endgame needs a wall-breaking adjunction into a 6-open field (G34, G36, G37).
6. **Linear instruments are blind to 5–7.** Additive colourings, the fractional number, Hoffman and ϑ all stop
   below the interval, and the finite planes' chromatic numbers are integrality-carried (G38, G41, G44, G48).
7. **The cell family is closed in both directions** — no six-colouring, no bounded witness family — and its
   ≥ 7 floor is `[SokolovVoronov2025]`'s χ_poly(ℝ²) = 7 (G22, G24, G29).
8. **The type-M rotations are a classified one-integer family, and the record is its cheapest live
   member** — `cos θ = (2n−1)/(2n)`, which is the spindle at distance `√n`; `n = 3` is the Moser twist,
   `n = 4` the record, `n = 16` is `ρ₆₃`, whose arena is **5-chromatic in the 6-open field `ℚ(√3,√7,√11)`**,
   produced rather than inherited (row 64). The two members cheaper than the record die by **Theorem B**,
   which is why no other rotation was ever made to work. **The platform is not the first, it is the smallest
   and the first built to order**: de Grey's own field is 6-open (G43), so G48's bar has been liftable since
   2018; `ℚ(√3,√7,√11)` is degree 8 against his degree 16, and the screen reached it rather than found it.
9. **`[Parts2020a]`'s 509-vertex record is reproduced and partly explained** (M62–M64). His base graph is his
   §5.6 closed form: 1,603 points in 92 orbits under his order-24 group ⟨ζ₆⟩ ⋊ Gal(K/ℚ), in which complex
   conjugation is itself a Galois element (`typem.parts_lattice`); our ρ₁₅ cross-edge law returns his two
   connecting orbits with his edge counts. Extended to radius 2.44 (3,433 points, 179 orbits) the
   **arena** — base together with its rotated copy — contains Heule-510 exactly (2,504 of 2,504 edges, none
   extra), split 375 base-side and 136 copy-side with the shared centre counted in both; **the base alone
   cannot**, since it lies in K² and χ(K²) = 4 (row 57). The record is specified by his Tables 3–4
   (374 + 136 vertices sharing the centre; `data/m62/parts509-orbit-fillings.json`). His reduction stage is
   reproduced on every attested number, with complete level sets, about 150× faster than his implementation
   (M63). A descent cannot reach the record (his §6; nine certified 1-minimal descents land at 582–609), and
   **overcompression is an orbit-closure gap** (row 62). Best 1-minimal objects by symmetry rung: 624
   (order 24), 576 (6), 558 (3), 582 (1); best object 559 vertices, census-certified. What is left of his
   loop is the expansion step, which has no termination measure (FS-35).

**The prior-art position.** The reduction from a field plane to a finite residue plane has been derived
independently in seven lineages that barely cite one another — Woodall → Benda–Perles → Johnson → Chow;
`[Fischer1990]`; `[Moorhouse2010]`; `[Manturov2012]`; `[Madore2015]`; the finite-field side (Medrano–Myers–
Stark–Terras → Vinh → Schneider–Silva → Krebs → Lorenz–Zimmermann); `[Polymath16wiki]` — and all stop where
Madore's Prop. 3.9 declines to formulate the general case. **Ours:** Theorem A's general form (that
formulation); Theorem B, which closes Madore's 4 ≤ χ ≤ 5, answers Moorhouse §1, Cranston–Rabern's question and the question `[ExooIsmailescu2019]`'s conclusion asks, and settles one field of Benda–Perles Open Problem 11.6; the sieve; the lift theory; the compulsion transfer and distance law; the tightness mechanism;
plane freedom at every prime p ≡ 3 (mod 4); every kernel certificate. **Not ours:** the finite-plane bound
and χ(𝔽₁₁²) = 5 (Moorhouse, Manturov, Madore); the unit argument and the 1/k obstruction (Fischer); ω and
ω ≠ χ on finite planes (Vinh, Krebs, Schneider–Silva); the cell family's ≥ 7 floor (Sokolov–Voronov); the
observed 2-adic compulsion pattern and its coordinate form (Heule, Parts, Dúcz); the two-colour mechanism over fields (Woodall, Fischer, Moorhouse, Madore); the multiquadratic decomposition (ChatGPT, credited in row 63).

### The novel-results ledger

*Kernel-checked unless marked **[tools]** (measured on exact arithmetic with controls) or **[hand]** (a hand
proof). Row numbers are stable identifiers cited across `plans/`: never renumber, never reuse. Lean modules
are under `Proofs/HadwigerNelson/`. Paths under `build/` are local, untracked, regenerable measurement
artifacts — provenance, never a certificate; the certificate is the Lean module.*

| # | Result | Where | When |
|---|---|---|---|
| 1 | **Two-circle theorem**: every unit-distance graph on the circles of radius 1 and 1/√3 about one point (the full uncountable set) is 3-colourable. | `TwoCircle.lean` (`colorable_three_induce`) | M19 |
| 2 | **Seam identity**: the cross-chord rotation between those circles is σ = (√3 + i√33)/6, of infinite order; two-circle labels form a strip ℤ/6 × ℤ. | `TwoCircle.seam_pow_ne_one` | M19 |
| 3 | **Coverage ratchet**: `CoverAtLeast` is monotone under adding edges, widening the class and lowering the level; at level k it is the fan. | `CoverageMono.lean` | M19 |
| 4 | **Fan ⟺ compulsory coverage**: a pivot is fanned iff every proper k-colouring puts all k colours on N(p) ∪ Q. | `Coverage.lean` (`fan_iff_coverage`) | M18 |
| 5 | **No class confines alone**: in-class degree ≤ 2, so class-only graphs are 3-colourable and a fourth colour frees the pivot. | `ClassGeometry.lean` (`not_fan_classOnlyGraph`) | M18 |
| 6 | **120° triangle identity**: a unit triangle lies on a circle about p iff r² = 1/3, and then p is its centroid. | `ClassGeometry.lean` (`exists_unit_triangle_iff`) | M18 |
| 7 | **Greedy colouring** (degree < k everywhere ⟹ k-colourable), absent from Mathlib. | `Greedy.lean` | M18 |
| 8 | **De Grey's graph has a balanced 5-colouring**, class sizes [317, 316, 316, 316, 316]. | `Instances/DeGreyBalanced.lean` | M19 |
| 9 | **The 120° compulsion**: in every proper 3-colouring of the two circles, three pairwise non-adjacent outer points at 120° are never monochromatic. | `Compulsion.lean` (`no_mono_outer_triple`) | M20 |
| 10 | **One-pivot cap**: {p} ∪ both circles has chromatic number exactly 4. | `Compulsion.lean` (`chromaticNumber_concentric`) | M20 |
| 11 | **Strip automaton**: two parity tubes; a recurrent core of 864 states; the colouring space grows ×12 per column; every proper colouring of a ≥ 2-column window extends to the whole tube. | `Strip.lean` (`window_extends`) | M20 |
| 12 | [tools] **Extension profile**: per pivot, every locally legal 3-pattern of the cover set tested for ambient realizability. | `tools/extend.py` | M20 |
| 13 | [tools] **Negative knowledge**: the growth-family hunt is closed exhaustively (557M class-tests); SAT pool statistics measure the solver, not the colouring space; pentagon exclusion is a fact about the coordinate field. | plans M17–M19 §R | M17–M19 |
| 14 | **Pair-gluing classification** for two unit-separated pivots: each circle-pair intersection is exactly {point, mirror} under one involutive isometry. | `Coupled.lean` | M21 |
| 15 | [tools] **First nonzero extension pressure**: at the closure's strongest-coupled pair about half of sampled pattern pairs die on the cross chords and a third of the rest die ambiently; the null pair is flat. | `tools/couple.py` | M21 |
| 16 | [tools] **The coupled automaton is dead**: no relation u^{2m}σ^lζ₆^k = 1 at any probed pair; no rotated or re-paletted sector colouring is proper on the d = 1 pair. | `tools/couple.py` | M21 |
| 17 | **General gluing classification**: two circles with distinct centres and radii under the annulus condition meet in exactly {glue point, mirror}, and nowhere otherwise — `[Vinh2006]` Lemma 3's trichotomy, over ℝ. | `Glue.lean` (`sphere_inter_sphere`) | M22 |
| 18 | **Certified near-relation**: ζ₆σ⁹ misses 1 by a chord below 1/50 and is never 1. | `Glue.lean` | M22 |
| 19 | [tools] **Kill mechanism and partner web**: ambient kills need the partner's outer circle; greedy pin cores are 4–8 pins; two-thirds of unit-partners collide back into the lattice; four colours stay feasible through two partner generations. | `tools/couple.py` | M22 |
| 20 | **Pivot-triangle layer**: the triangle is self-glued; metapivot couplings create no new points; two unit-separated systems share exactly ten points; outer–outer chords are rigid; the rotation-hexagon identity holds for any three centres. | `Triangle.lean` | M23 |
| 21 | [tools] **Registered statistics**: ambient kills are gated by coupling strength (none at 22 chords, 12–15% at 40); the seam-alignment kill reading fails replication; the triple-kill population is provably empty. | `tools/couple.py` | M23 |
| 22 | **The matched ladder pair is exactly 4-chromatic** — the countable two-pivot ⟨ζ₆,σ⟩-lattice closed under all unit chords; every chord family is a theorem, by clearing into ℤ[ζ₆,π], mod-3 congruences and a trace-pair telescope. | `Ladder.lean` (`chromaticNumber_ladderPair`, `sqrt_indep`) | M24 |
| 23 | **The four-ladder object is exactly 4-chromatic** (the triangle's ladders plus the metapivot's), via √3·ζ₁₂ = 1 + ζ₆. | `MetaLadder.lean` (`chromaticNumber_fourLadder`) | M25 |
| 24 | **The hexagram is exactly 4-chromatic** (six pivots at 1/√3 about the metapivot, seven ladders), with a rot6-equivariant 4-colouring. | `Hexagram.lean` (`chromaticNumber_hexagram`) | M26 |
| 25 | **Field-wall identity**: the Moser twist ρ satisfies ρσ² = −1 — it is a word in the seam group. | `FieldWall.lean` (`moserTwist_mul_seam_sq`) | M30 |
| 26 | [tools] **De Grey anatomy**: 67 edge-direction classes, all words in the half-spindle group (G8); the 791-point forcer forces exactly six pairs at four colours (G9); the 1581 is **at or near edge-critical** (single random edge deletions flip it 4-colourable — sampled, the exhaustive 7,877-edge sweep unrun), and its concentration bet died at face value (819 circles about one centre, 4,140 coarse classes, top-6 = 3.7%, deflated by a matched control): the 5-forcing is distributed, not organ-like. | `tools/anatomy.py`, `tools/rigidity.py` | M30 |
| 27 | [tools] **Quadrature law**, derived and then confirmed at 26 exact censuses (G12); the mitotic hexagram is 4-chromatic; the 1581's gen-1 closure (24,065 points) is 5-colourable. | `tools/closure.py` | M31 |
| 28 | **The 2-adic kill engine**: `sqrt5_indep` by a mod-5 descent, `sqrt15_split`, `sqrt_indep₈`, `quadrature_rho15` (G12's ρ₁₅ instance). | `Quadrature.lean` | M32 |
| 29 | [tools] **Stacking law** and the flat verdict on designed one-family stacks (G14). | `tools/closure.py` | M32 |
| 30 | [tools] **Mechanism hunt**: the criticality factorization (χ(G) ≥ k + 1 ⟺ the fan at a vertex whose deletion is k-colourable); the distance-2 pigeonhole with a 122-vertex carrier (G16); a 49-vertex 3-cover core; a nine-vertex √3-pair core in the assembled 1581. | `tools/mechanism.py` | M33 |
| 31 | **Act One in the kernel**: the pigeonhole bridge (`mono_pair_of_not_colorable_append`), the transmuter, `not_colorable_iff_covers`; carriers `core9_pigeonhole` and `core122_pigeonhole` with inhabitants `core9_colorable_three` and `core122_colorable_four` (by Theorem B: `UDCert.colorable_four_of_seamFree` makes any √5- and √7-free certificate 4-colourable). **`core9_plane` and `core122_plane` are vacuous** — there are no four-colourings of the plane (`isEmpty_coloring_plane_four`) — and support nothing. [tools] A composed 4,749-vertex union is 5-chromatic by kernel-covered cubes. | `Pigeonhole.lean`, `SeamCert.lean`, `Instances/Core9.lean`, `Instances/Core122*` | M34 |
| 32 | **Two-sided 6-programme**: `mono_pair_of_clique`; the hex-shell pigeonhole (the closed first shell is a K₇ of the {1, √3, 2}-distance graph, so χ(ℝ²; {1,√3,2}) ≥ 7 — folklore, formalization ours); the brick certificate and χ(ℝ²; {1, √(3/2)}) ≤ 9 (row 61). [tools] No pattern class fires at five colours: **52/4/0 over 7 objects × 8 classes** — the measured population, not the inventory, which has grown since. | `Instances/HexShell.lean`, `Brick.lean`, `Instances/Nine.lean` | M35 |
| 33 | **The classical interval at both ends**: the boundary-tight brick certificate (`check_pos`); `chromaticNumber_plane_le_seven` on a 7 × 7 torus of 4/5 × 3/5 cells sheared 2/5, coloured by the norm-7 ideal (−3 + ζ₆); **`chromaticNumber_plane_interval`: 5 ≤ χ(ℝ²) ≤ 7**. The colouring is classical; ours is the certificate. | `Brick.lean`, `Instances/Seven.lean`, `Instances/Interval.lean` | M36 |
| 34 | **Coset chromatic number exactly 7**: every nearest-point coset colouring of the triangular lattice uses ≥ 7 colours (2, 5, 6 are not a² + ab + b²), attained at scale 6/7. **Prior art:** the floor follows from `[SokolovVoronov2025]`; the dual problem d(k) is `[deGreyParts2022]`, whose thresholds match our band boundaries exactly (also `[Ivanov2007]`). Ours: the exact value and the arbitrary-label results. | `Coset.lean` (`coset_chromatic_eq_seven`) | M37 |
| 35 | **Coarse cells, arbitrary labels**: for 1/2 < p < 1 any colouring constant on the cells needs 7 colours (the first shell is a 7-clique of the constraint graph). The floor is subsumed by `[SokolovVoronov2025]`. | `Coset.lean` (`seven_le_card_of_cell_constant`, `cell_chromatic_eq_seven`) | M38 |
| 36 | **Scale is not monotone**: 1/2 < p < 3/5 needs 8 and 3/8 < p < 2/5 needs 7 again; the classical scale is a local optimum (the dual-variable form is `[deGreyParts2022]`, `[Parts2023]`; the eight is ours). | `Coset.lean` (`eight_le_card_of_cell_constant`, `seven_le_card_fine`) | M39 |
| 37 | [tools] **Gap atlas**: one graph per band; χ = 9 on p ∈ (1/2, 0.6547) and 12 on (0.4804, 1/2); every band down to p = 0.2236 needs ≥ 7 while ω falls to 3–5; G\* = (0.4330, 0.4804) has ω = 4, χ = 7; the deep pocket (1/3, 0.3464) has χ ≥ 8; no coset 7-colouring exists **on G\* or the 1/6 and 1/7 bands** — all eight index-7 sublattices contain an edge, with explicit witnesses; the kernel form (`no_coset_seven_on_gap`, row 39) is the G\* band, not every scale. | `tools/celllat.py` | M40 |
| 38 | [tools] **Gradient hunt**: all five clique-free cell cores factor as pigeonhole × kill (G15, five of five in the finite lab; G26 no longer carries this claim); a non-geometric Klein four-group of automorphisms of the 1581 yields three new 5-chromatic witnesses (G27); no pair compulsion at five colours on twelve composed objects (complete sweeps), and **0 of 40** targeted asks at exact √3 / 2 pairs on the gen-2 closure (284,873 points, k = 5 SAT in 343 s); the only nonzero readings anywhere were two solver-effort signals (single-sample). | `tools/gradient.py` | M41 |
| 39 | **Gap atlas, kernel side**: `exists_unit_pair_corner`; `seven_le_card_shell4` (3/28 < p² < 1/9); `twelve_le_card_of_cell_constant` (3/13 < p² < 1/4); `no_coset_seven_on_gap`; `core23_not_colorable_six` with `core23_colorable_seven`, so the 23-vertex G\* core has χ = 7 at ω = 4; `Coset.seven_le_card_gap`. | `Coset.lean` §GapBands, `Instances/Core23*` | M42 |
| 40 | [tools] **The fine tail**: χ(G(p)) = 7 exactly on both flanks of p = 1/7; nineteen further bands ≥ 7; kernel promotion priced (~800,000 LRAT lines per cube) and declined. The whole family is ≥ 7 at every scale **conditional on** `[Voronov2023]` Thm 1.1 and `[SokolovVoronov2025]` — external theorems, read here (2026-09-08) but not re-derived; the band-by-band sevens are ours unconditionally. | `tools/celllat.py` | M43 |
| 41 | **Limit lemma**: non-k-colourable graphs of bounded size, drawn in one compact region with every edge within ε of 1 for every ε, give χ ≥ k + 1 (`add_one_le_chromaticNumber_unitDistance_of_bounded_family`); at a single ε the hypothesis is free (`collapsed_drawing_satisfies_one_tolerance`). [tools] A certified unit-distance defect meter, and the first explicit points ν(0.2792) ≤ 23 … ν(0.1494) ≤ 160. | `Limit.lean`, `tools/embed.py`, `tools/verify_defect.py` | M44 |
| 42 | **The arity floor**: a compulsion is a partial colouring that does not extend; `arityFloor G k : ℕ∞`; arity 2 is exactly `Separated`/`Forces`; `arityFloor_eq_zero_iff` (0 ⟺ not k-colourable); `arityFloor_le_of_degree` (≤ k whenever some vertex has k distinct neighbours). [tools] The p = 1/7 fine-tail stage carries 7 virtual edges (G28). | `Arity.lean`, `tools/arity.py` | M45 |
| 43 | **De Grey's witness, bracketed**: `arityFloor_le_of_embedding`; the plane's homogeneity given an isometry (`transport_pair_of_isometry`, `Separated.planeIn`, `Forces.planeIn`); **the six-target**: χ(ℝ²) ≥ k + 1 from k-colour virtual edges at √3 AND at 2, neither sufficing alone (`add_one_le_chromaticNumber_plane_of_forced_pairs`). [tools] The 1581's arity floor at five colours is 4 or 5, by complete sweeps (G31). | `Arity.lean`, `Homogeneous.lean`, `Instances/HexShell.lean`, `tools/m48.py` | M48 |
| 44 | **The two-distance dial** (G32): `distanceGraph V D`; **the spindle theorem** `not_colorable_of_forced_equal` (a forced-equal pair at any d ≥ 1/2 refutes k-colourability, and 1/2 is exact); `add_one_le_chromaticNumber_unitDistance_of_one_defect`; `seven_le_chromaticNumber_hexShell_distances`. [tools] Exoo–Ismailescu's {1,2} six-forcer re-derived exactly (certificate priced at ~50M hints and deferred; the `Instances/OneTwo` module two docstrings cite does not exist); Parts's {1,φ} forcer is edge-critical; 29 ≤ μ ≤ 252 on the seed. Registered predictions: P4a/P5/P8 met, P4b refuted, P4c met one level deeper, P2 undecided, P3 vacuous, P6 missed, P7 refuted literally, P1 missed (certificate deferred). | `DistanceGraph.lean`, `OneDefect.lean`, `tools/twodist.py`, `tools/killengine.py` | M49 |
| 45 | **Batch descent** (G33): `Glue.eq_gluePoint_of_dist_pair` and `Glue.finite_two_unit_neighbors` (depth-one candidate spaces are finite, in any field). [tools] Batch halos compose by construction (1,008 points, 403 of 446 cheats left); growth re-opens refusers; the seed carries 148 absolute virtual edges at d ∈ {3, 4}; the spare-colour lemma ((k−1)-colourable ⟹ no pair compulsion at k). | `PartnerLattice.lean`, `tools/batchkill.py` | M50 |
| 46 | **Copy unions**: `spindleRot`, `copyUnion`, `chromaticNumber_copyUnion_le`. [tools] Every unit edge of the descended object lies on the Moser lattice ℤ⟨1, ζ₆, ω₃, ζ₆ω₃⟩ and every point in ℚ(√3,√11); a ρ₁₅ copy kills no separating class at five colours; the cull cuts the standing cheats 273 → 149 with no material added. | `Copy.lean`, `tools/cull_enum.py`, `data/m52/` | M52 |
| 47 | [hand + tools] **M53, halted when Theorem B was proved**: the residue colouring is proper on every descent object with every cheat monochromatic; the residue obstruction and μ ≥ 3 inside ℚ(√3,√11) (G36); the wall-break census; 5-chromatic witnesses in ℚ(√3,√11,√247) (1,175 points; field and route prior art, `[ExooIsmailescu2019]`, `[Polymath16wiki]`) and ℚ(√3,√11,√23). | `tools/residue_colouring.py`, `tools/residue_floor.py`, `tools/wall_break_test.py`, `plans/FIELD-WALL-THEOREM.md` | M53 |
| 48 | **Critical-set localization** (G39): a forced-equal pair confines the critical set to N(p) ∩ N(q), a virtual edge to N(p) ∪ N(q); in the plane at most two critical vertices, none beyond distance 2 (`encard_criticalSet_le_two_of_forces`, `criticalSet_eq_empty_of_forces_of_two_lt_dist`), generalized to edge-length sets and metric spaces, where the count ≤ 2 does not survive. [tools] Two 5-chromatic objects with no critical vertex; the smaller (2,229 points) has no pair compulsion at five colours. | `CriticalSet.lean`, `tools/five_dial.py` | M54 |
| 49 | **Absorption** (G40): `Extends`, `extends_of_repaint`, `extends_of_hubs`, `extends_symCopy`. [tools] ν = 2 exactly on the two-spindle objects; a depth-two F₂₄₇ cross thickening frees 238 critical vertices, all on the copy side. | `Absorb.lean`, `tools/absorb_dial.py` | M55 |
| 50 | **The additive yardstick** (G41): `additiveColoring`, `not_forces_of_addMonoidHom`, `addMonoidHom_apply_eq_of_sub_eq_nsmul`; the additive spindle theorem (its chord lies in 4Λ). [tools] Exoo–Ismailescu's G's colouring space is exactly its additive family; no 5-chromatic witness has an additive 4-colouring. **Prior art:** the framework and the 1/k obstruction (no additive k-colouring, k ≤ 10, of a wall-broken plane) are `[Fischer1990]` Thm 10(ii). | `Additive.lean`, `tools/additive.py` | M56 |
| 51 | **Additive rigidity** (G42): `AdditivelyRigid`, `forces_of_additivelyRigid`, `six_le_chromaticNumber_plane_of_additivelyRigid`. [tools] Only Exoo–Ismailescu's G is rigid, and only **with its cheats** (the gauge includes its non-unit edges); every unit-distance object held is Kempe-open by orders of magnitude. | `AdditiveRigid.lean`, `tools/additive_rigid.py` | M57 |
| 52 | [hand + tools] **The finite-plane bound and the first exact wall-broken planes**: a field with a prime above p ≡ 3 (mod 4) **of ODD residue degree** — equivalently residue field 𝔽_q with q ≡ 3 (mod 4) — has χ(F²) ≤ χ(UD(𝔽_q,2)); χ(UD(𝔽₁₁,2)) = 5, so χ(ℚ(√3,√5,√11)²) = χ(ℚ(√3,√11,√247)²) = 5. **The degree condition is the whole content and a larger field can LOSE a prime its subfield had**: de Grey's ℚ(√3,√5,√7,√11) contains ℚ(√3,√5,√11) yet 11 has residue degree 2 there, so **de Grey's first usable prime is 131** and this row's bound says nothing about his field (G43). Sealed at 4: K, K(√35). Sealed at 5: K(√5) = Heule's field, K(√23), K(√247), K(√5,√247). **Prior art:** the bound is `[Moorhouse2010]` §8.2/§10.3, `[Manturov2012]` Thms 17–19 and `[Madore2015]` Cor. 3.4; the value at 11 is Moorhouse's Table 6.1. | `tools/fplane.py`, `reference/Chat-analysis/` | 2026-09-06 |
| 53 | **The field sieve** (G43, G44): `unitQuadrance R`, `unitQuadrance.map` (the bound as functoriality), `UDCert.drawing_adj`; **`chromaticNumber_finitePlane11`** (= 5, no solver) and **`chromaticNumber_heule510`** (= 5). [derived] Kloosterman eigenvalues make every plane at p ≡ 3 (mod 4) from 59 up refuse five; over ℚ(√3,√11), 6-open ⟺ wall broken ∧ 11 inert — **with the instances, whose deletion is what let the criterion be misapplied**: 6-open are de Grey's own field (first usable primes 131, 479), K(√7) (83), K(√13), K(√79), K(√127), K(√5,√7,√247); sealed at 5 are K(√5) (Heule's), K(√23), K(√247), K(√5,√247); at 4, K and K(√35). The standing map is `data/fplane/map.md`. **Prior art:** ω and ω ≠ χ on finite planes (`[Krebs2022]`, `[LorenzZimmermann2023]`, `[SchneiderSilva2013]`); `[Vinh2006]` restates the spectral bound without a factor 2, which our kernel value at 19 contradicts. | `UnitQuadrance.lean`, `Instances/FinitePlane11.lean`, `tools/fplane.py` | M58 |
| 54 | **The lift** (G45): `add_one_le_chromaticNumber_plane_of_lift`; `stressPairing_eq_zero_of_lift` (in any ring with π² = 0 a lift forces every self-stress to pair to zero with the defect); no lift modulo 131², 11² or 19² for the 1581's merged image and the 5-critical cores of UD(𝔽₁₁,2) and UD(𝔽₁₉,2). [tools] The hub scan: 3,739 exact depth-one hubs of the 1581 at 131. | `Lift.lean`, `Instances/LiftObstruction{11,19,131}.lean`, `tools/fplift.py` | M59 |
| 55 | **The residue obstruction** (G47): `Forces.image`, `Separated.image`; `forces_iff_eq_of_aperiodic`; the distance law (`Forces.quad_sub_eq_zero`, `Separated.quad_sub_eq_one`); `finitePlane11_forces_iff`, `finitePlane11_separated_iff`. **Over the √7-free tower with 11 ∤ D, a five-colour forced pair has 11 ∣ d² and a virtual edge d² ≡ 1 (mod 11), so neither a √3 nor a distance-2 gadget exists** (`not_separated_sqrt3_11`, `not_separated_two_11`) — and, by the same law at the rational squared distance 25/9 (`not_forces_of_distSq_ratio`, `not_forces_five_thirds_11`, modelled on Heule-510's 5/3 pairs), Polymath16's 2018 question "is 5/3 always coloured like 0?" has the answer no for every such certificate; the field-level reading, wherever 11 is usable, adds M58's hand reduction, and the √247 variant stays a hand argument (`CLOSED-QUESTIONS.md` §1.4). | `ResidueObstruction.lean`, `Instances/ResidueObstruction11.lean`, `tools/fpcompel.py` | M60 |
| 56 | **Local–global tightness** (G48): `addCayleyMap`; `unitQuadrance_colorable_of_quotient`; `card_le_chromaticNumber_mul_indepNum`; **`Forces.isEmpty_ringHom_of_spindle_radicand`** (with `…_of_not_isSquare_neg_one` and `…_of_colorable` forms); `chromaticNumber_finitePlane19_le_five`. [tools] ϑ = Hoffman at eleven primes; no rotationally symmetric 5-colouring of UD(𝔽₂₃,2). **Prior art:** `addCayleyMap` is `[Moorhouse2010]` §4.2 and the periodic quotient an instance of `[CervantesKrebs2023]`; the mechanism is ours. | `LocalGlobal.lean`, `Instances/LocalGlobal19.lean`, `PlaneRotation.lean` | M61 |
| 57 | **Theorems A and B.** **B:** `chromaticNumber_seamPlane`, χ(ℚ(√3,√11)²) = 4 — residue maps onto 𝔽₄ at the two primes above 2, a parity descent in place of valuation theory, and the Moser spindle as an identity in the order; `not_forces_five_of_subset_seamPlane`. **A:** `colorable_of_residue` — a graph drawn in an abelian group, edge differences in a subgroup A and nonzero under ψ : A →+ G, is \|G\|-colourable, with no metric, field or ring; `normOne_subset_valuationSubring`, `colorable_unitDistance_induce_of_valuationSubring`, `normOneColoring`. **Not proved:** that a number field with a conjugation-fixed prime supplies the valuation subring with residue field of size N(𝔭). **Prior art:** the valuation-subring form is `[Madore2015]` Prop. 3.2 and the unit argument `[Fischer1990]` Thm 1; Theorem A's general form is what Madore's Prop. 3.9 declines to formulate. **B answers** `[Moorhouse2010]` §1, `[CranstonRabern2015]` (so 76/21 ≤ χ_f(K²) ≤ 4) and `[ExooIsmailescu2019]`'s closing question, and settles one field of Benda–Perles Open Problem 11.6 (`[Soifer2024]` ch. 11), and closes `[Madore2015]` Prop. 4.6's 4 ≤ χ ≤ 5. | `FieldWall4.lean`, `ResidueColouring.lean` | 2026-09-08 |
| 58 | **The Moser recipe's sharp threshold**: a host graph with no k-clique draws no minimal forcing gadget at k colours (`not_forces_of_drawing`); four plane points are never pairwise unit-distant, so for k ≥ 4 no k + 1 plane points carry a forced pair (`not_forces_of_unit_drawing`), while at k = 3 the drawn rhombus is the minimal gadget (`exists_forces_of_unit_drawing_three`). It says nothing about non-minimal constructions. | `Mascot.lean`, `plans/MASCOT-DERIVATION.md` | 2026-09-09 |
| 59 | **The 2-adic law of four-colour compulsions over K = ℚ(√3,√11)**: the residue colouring identifies two K-points iff their distance lies in the prime 𝔭 above 2 (`residueColouring_eq_iff_psiA_zero`), so a forced-monochromatic pair needs v_𝔭(d) > 0 and a virtual edge v_𝔭(d) = 0 (`not_forces_of_residue_ne_zero`, `not_separated_of_residue_eq_zero`); each distance in `[Parts2020a]` Table 1 is barred from the other column (two rows' √ unverified against the PDF, same valuation either way). The general form needs only a conjugation-stable ideal kernel (`map_mul_conj_eq_zero_iff`). **Open:** are both conditions also sufficient in some finite K-object? **Prior art:** the coordinate form is `[Ducz2026]`; the observed pattern is `[Heule2019]`, `[PartsOdd2022]`, `[Heule2021]`, `[Ardal2009]`. Ours: the field-level valuation statement, the compulsion consumers, the kernel proof. | `ValuationLaw.lean`, `ResidueColouring.lean` §4 | 2026-09-09 |
| 60 | **Plane freedom**: rotations by circle points are automorphisms of `unitQuadrance R` (`rotHom`, `quarterTurnHom`); over a field where −1 is not a square a vector and its quarter turn span the plane; so **over ZMod p with p ≡ 3 (mod 4), `Forces ↔ x = y` whenever the plane is k-colourable** (`finitePlane_forces_iff`) — without colourability the statement is false (`finitePlane3_not_colorable_two`). Prime fields only; the virtual-edge half is proved only at 11. | `PlaneRotation.lean`, `Instances/PlaneFreedom.lean` | 2026-09-09 |
| 61 | **Statements at their proofs' level**: the six-target is colour-generic (`seven_le_chromaticNumber_plane_of_forced_pairs`: two six-colour gadgets give χ ≥ 7) and distance-set-generic, and over {1, 2} one √3 gadget suffices (`six_le_chromaticNumber_oneTwo_of_forced_sqrt3`); a passing brick certificate colours `distanceGraph ℂ D` (`chromaticNumber_plane_avoiding_sqrt_three_halves_le_nine`); the old names are pinned by compiled type ascriptions. | `Instances/HexShell.lean`, `BrickDistance.lean` | FS-24 |
| 62 | **Overcompression is an orbit-closure gap**: for an upward-closed refusal family and H ≤ Aut(A), the rung-H minimum equals min \|cl_H(M)\| over inclusion-minimal refusers M, so every symmetry rung is a hitting-set problem over H-orbits against the correction-set hypergraph Y, with no colouring ask. [tools] On `[Parts2020a]`'s L stage: 375 vertices / 3,264 minima at the trivial rung; a dead involution gives 376 with containment 0 of 1,302 — his §6 sentence reproduced at 375 and 376; S-side rungs cost 8 vertices where L's cost 1; Y accounts for every exclusion. **Prior art:** the symmetry gap of symmetric integer programming (`[HerrRehnSchurmann2013]`), idealness, semilinear sets, MUS/MCS enumeration (arXiv:2412.13606 — our 336 necessary atoms are its backbone). | `tools/parts_faces.py`, `tools/parts_reduce.py`, `data/m62/m64-*.json` | M64 |
| 64 | [tools] **A five-chromatic unit-distance graph in a 6-OPEN field, at a rotation the field screen selected** (M63 phase H2). The type-M rotations are classified by one integer — `cos θ = (2n−1)/(2n)`, diagonal circle at `\|p\|² = n`, radicand `4n−1` — which is the **spindle** construction at distance `√n`, so `n = 3` is the Moser twist, `n = 4` is `ρ₁₅` (the 509-vertex record) and `n = 16` is `ρ₆₃ = (31+3i√7)/32`. **The rotation is not new either, corrected 2026-09-12**: it is `ω₁₆` of `[Polymath16wikiMain]`'s own 2018 list, which also records de Grey's 20,425-vertex graph as living in `ℤ[ω₁, ω₃, ω₄, ω₁₆]` — so `ρ₆₃` is a generator of **de Grey's own ring**, and it is a G8 generator here for that reason. **What is ours in this row is the field screen that selected it, the 6-openness, and the produced refusal — nothing about the rotation.** Screened by four gates we hold (free circle; `sin θ ∉ K` else Theorem B four-colours every base; the 2-adic wall; 11's residue degree), the record is the **cheapest** live member and the two below it die by **Theorem B**. **At `n = 16`: `χ ≥ 5` on 51,133 vertices / 544,530 edges in `ℚ(√3,√7,√11)`**, established twice — a complete 552-pattern enumeration with **0 of 304,704** admissible pairs, and **552/552 UNSAT** cube-and-conquer in 20.03 core-hours — sharing only the completeness of the 552, the first claim confirmed on **four** independent solver codebases (CaDiCaL ×2, Glucose, Minisat) and the other nineteen on two (CaDiCaL, Glucose), with paired positive controls, and produced as **0.35 GB of DRAT** (807 MB bundled, each instance repeating the base half) covering the whole 20-claim trust core — **the first here, but GENERATED and not CHECKED**: no DRAT checker exists on this machine, so what holds is only that CaDiCaL's own `--checkproof` was on. **Regenerated as text LRAT** with `scripts/regen-check.sh`'s own flags: all 20 exit UNSAT, all 20 end in the empty clause with a negative control proving that check discriminates, **1,001.2 MB over 11.8 M lines**, 406 solver-seconds. **Status: generated, not checked** — and the format is **the input to this project's conversion pipeline, NOT one the kernel consumes**: core's LRAT checker cannot kernel-reduce at all (`USize` width is an `@[extern] opaque`, so it buys a native axiom per certificate) and M05's kernel-reducible checker takes a packed `Nat` encoding derived from LRAT. **Kernel-checking is priced and declined for now**: at 585–614 k lines each, one is ~0.75× the per-cube volume row 40 declined and all twenty are ~15× it. Bundled as **19.5 MB** (base half once plus 20 deltas) with a `reconstitute.sh` that verified each rebuild against a SHA-256 and refused a planted clause — **but the DRAT, LRAT and bundle lived in the session's `/tmp` and were never committed; they are gone** (review 2026-09-13). The durable commits are the 151 KB certificate and 5 KB manifest at `data/m62/m63-phaseH2-rho63-*.json`. **The refusal is produced, not inherited**: no known witness embeds at any position or orientation (isometry-invariant squared distances), and the base half alone four-colours in 0.35 s. **The result is the field, not the size** — `K(√7)` is 6-open, so 11 is not usable there and row 55's bar on five-colour forced pairs does not apply: G48's mechanism has a platform. **Not the FIRST such platform, corrected 2026-09-12**: de Grey's own field ℚ(√3,√5,√7,√11) is 6-open (G43; the coordinates span all sixteen basis slots of the tower over `Instances/DeGrey`'s certificate, and `data/fplane/map.md:20` has said so since M58), as is K(√5,√7,√247). The 5-sealed ones are the record's K(√15) = K(√5), the M53 witnesses' K(√247) and K(√23), and Heule-510/553's ℚ(√3,√5,√11). What is new is a platform at **half the degree** (8 against 16), reached **by the screen** rather than found, carrying an object whose refusal is produced. **The rotation, the angle family and the spindle identification are all prior art** (G7). **χ(arena) = 5 EXACTLY** (2026-09-12: nothing on record had the upper half; CaDiCaL was undecided at 300 s; an explicit construction took 0.7 s and was **verified proper on all 544,530 edges, 0 improper** — `plans/M63-phaseH4-reduce-the-platform.md` §R). **Not kernel-certified; one object.** [tools] Also: the circle count is the base's norm-`n` shell count and is **free** when `n = k²m` with `k ∈ ℤ` and `m` a realised distance; the 30 circle points admit exactly **19** colour patterns in `1 + 6·3` orbits under `ζ₆`, every one half-turn invariant; and `h(K) = h(K(i)) = 1` with `μ(K(i)) = ⟨ζ₁₂⟩` (pari). | `plans/M63-phaseH2-the-family.md`, `plans/M63-phaseH2-solver.md`, `plans/M63-phaseH2-plan.md`, `plans/POROS-2026-09-12-m63-phaseH2.md`, `plans/M63-phaseH4-reduce-the-platform.md` (the χ = 5 witness), `data/m62/README.md` | M63 phase H2 |
| 63 | **Two colours from inertia, and the 2-adic splitting of multiquadratic fields**: a residue map into a reduced characteristic-2 ring that conjugation does not move two-colours every unit-distance graph over its valuation subring (`colorable_two_unitDistance_induce_of_valuationSubring` — its plane and valuation forms have **no instance over a real field yet**; the only inhabitant is the ring form on ℤ[i], deferred to FS-37); a square-class group holding [2] is the sum of two pieces whose 2-adic images avoid [−1], so every real multiquadratic field lies, once √2 is adjoined, in the compositum of two fields that pass the four-colour test (`fieldOfRadicands_le_sup`) — each holding a Moser spindle when the field contains ℚ(√3,√11); de Grey's field lies in ℚ(√2,√3,√11,√35)·ℚ(√3,√10,√11,√35); ℚ(√3,√11,√14) and ℚ(√3,√11,√70) pass the test and their compositum's plane needs five colours (`five_le_chromaticNumber_planeOver_fourteen_sup_seventy`), so, granted the factors' hand χ ≤ 4, no combining rule for test-passing fields gives four. **Not proved:** χ ≤ 4 for any piece (FS-37). [hand] For real multiquadratic F, χ(F²) = 2 iff no odd square class is ≡ 3 (mod 4). **Credit:** the decomposition is ChatGPT's (OpenAI, with Kooshi, 2026-09-11). **Prior art:** the mechanism is Woodall's, `[Fischer1990]` Thm 8, `[Moorhouse2010]` Thm 7.1, `[Madore2015]` Prop. 3.9; the multiquadratic iff is unchecked against `[AxenovichEtAl2014]` and `[Johnson2006]`. | `TwoColourResidue.lean`, `SquareClass.lean`, `Instances/CompositumFive.lean` | FS-36 |
| 65 | [tools] **Dropping `[Parts2020a]`'s coordinate shape: the object dies, and the family gains six results** (M63 phase H3). His base confines a point of `K² = ℚ(√3,√11)²` to four of eight rational slots (`p₁ ∈ ℚ(√33)`, `p₂ ∈ √3ℚ ⊕ √11ℚ`) — equivalently, to the quartic CM field `ℚ(√−3,√−11)`, so **dropping the shape IS adjoining the quarter turn** (`[Polymath16blog]`, Speyer, 2018-04-25). Dropped at `n = 2` (`ρ₂ = (3+i√7)/4`, circle `\|p\|² = 2`, bound `4/√7`, field `ℚ(√3,√7,√11)`, 6-open), the base is the ℤ-span of its own **60** unit vectors — index 256, group-closed under order **48** not Parts's 24, **16,309** points, confirmed by three independent routes. **THE OBJECT IS FOUR-COLOURABLE, at every radius, by derivation**: an arena colouring is a **pair** `(f,g)` of base colourings meeting 132 interface constraints, and searching them **independently** over the additive family gives **576 of 124,416** in 1.7 s — **none a twist**, which is why a twist-only search had read it as live. Additive colourings are lattice homomorphisms and the cross edges are pinned at 252 by the bound, so growth cannot help (exercised at 32,617 / 83,905 / 301,537 vertices, 0 monochromatic each). **The screen this yields is the phase's product: the additive-pair route is open exactly when `4 ∤ n` and dead exactly when `4 \| n`** — the colour group is 2-torsion, so a circle inside `2L` takes the centre's colour — base-free, radius-free, solver-free, clean on all 19 members `n ≤ 20` with circle counts (60–336) **never tracking the verdict**. **Every 6-open member FS-30 lists (16, 20, 44, 60, 64, 76, 108, 112) is `≡ 0 (mod 4)` and immune: phase H3 picked the cheapest member of exactly the class this route kills.** Also: **(i)** the endpoint bound `1/\|sin θ\|` governs cross-edge **endpoints, not a base's extent** — Parts went **past** his by 1.222× (his base is a selection of 37+14 orbits, not a disk cut), phase H2 stopped exactly at his; **(ii)** **growing a base is provably monotone** — colourings of a larger base restrict to the smaller, so the interface pattern set only shrinks while the circle count is fixed (first measurement: `10²¹ → 10⁴` for a 2.6× base); **(iii)** the circle sits at `√(1−1/(4n))` of the bound — 93.5/96.8/99.2% at `n` = 2/4/16 — so **the circle is on the arena boundary in every member by construction**, and the free-circle theorem's hypothesis (radius `\|k\|+1`) **has never been satisfied by any object built**; **(iv)** a **two-case classification** of monochromatic cross-edge kinds over `V = n(g−h)² + gh`, with `\|u\|²,\|v\|²,σ,δ²` all homogeneous of degree 0 and the endpoint bound a corollary — case A (`g,h` both `𝔭`-units) monochromatic for every `n`, case B iff `v_𝔭(gh) < v_𝔭(n)`, needing `n` even; retrodicts 12/12 families, one out-of-sample landing (`Sh(64)=12` predicted mid-enumeration); **(v)** the shape trade measured — each conjugate condition beyond the first costs **2.0–2.6×** in realised connectivity, so dropping the shape buys 2× nominal and pays ≈5.3×, **net ≈2.6× worse at equal radius**; **(vi)** a **one-sided kill test** for whether phase H2's interface reduction is affordable, milliseconds from one base colouring — **it rules candidates out and can never rule one in**. **The premise is confirmed where it matters most:** at `n = 4`, the record's **own** rotation, dropping the shape takes raw off-diagonal cross edges **36 → 312** and monochromatic ones **0 → 144** (195,961 points, 492/492 confirmed, 0 invented) — **the shape, not the rotation, was the obstruction.** **Prior art:** the move is `[Polymath16blog]`, Silberman, 2018-04-19 — *"take points each of whose coordinates is a point in the field"*, both obstacles named, *"I'll try implementing this later"*, never returned to, nothing following it in 1.69 M characters across eighteen threads; the coincidence-site-module literature excludes the object **by definition** (`[BaakeZeiner2017]` §6 admits only same-rank submodules). **And the DIRECTION closes with the object**: run over Parts's **shaped** lattice the same screen shows every member he can realise with a nonempty circle is either **odd** (at risk, but dead anyway — odd `n` fails the 2-adic wall) or **`4 \| n`** (immune), so **dropping the shape reaches only members this route kills**; `n = 16` is the cheapest 6-open immune member, nothing lies below it (`n` = 4, 8, 12 are 5-sealed), and it is realisable **shaped** at 25,567 points — phase H2's own object. **Every member worth having was already reachable on Parts's lattice; the shape-free construction has no target.** Residual, priced not pursued: `n = 10` is at risk and **uncomputed** at ~6.6 M points; the sub-bound radius lever is worth **6–23%, not orders** (measured). **Nothing kernel-checked; no proof log, because no solver produced one.** | `plans/M63-phaseH3-plan.md`, `plans/M63-phaseH3-solver.md`, `plans/M63-phaseH3-crossedges.md`, `plans/M63-phaseH3-module.md`, `plans/M63-phaseH3-prior-art.md`, `plans/POROS-2026-09-12-m63-phaseH3.md` (the retraction ledger). **Its certificate and `recheck.py` were left under the gitignored `build/` and are not in the repository** (review 2026-09-13; `data/m62/README.md` § Not recorded here). | M63 phase H3 |

### Paths forward, ranked

*A mirror of `plans/FRONTIER-STUBS.md`, which is authoritative: every row there is a full stub with its
bearing on χ ≥ 6 stated honestly. Kooshi picks; the default is the top.*

**Open milestones, in order.** **M63 phase H2 closed 2026-09-12** with a five-chromatic unit-distance graph
in a **6-open** field (row 64) — **not the first** such platform, since de Grey's own field is 6-open (G43),
but the smallest and the first reached by design rather than found.
**Phase H3 closed 2026-09-12 with its object DEAD and the family six results richer** (row 65): dropping
`[Parts2020a]`'s coordinate shape at `n = 2` gives a base that is four-colourable **at every radius, by
derivation**, and the reason generalises — **the additive-pair route is open exactly when `4 ∤ n`**, while
**every 6-open member we list is `≡ 0 (mod 4)`**, so the phase picked the cheapest member of exactly the
class that route kills. The premise it was chartered to test is nevertheless **confirmed**: at the record's
own rotation `n = 4`, dropping the shape takes monochromatic off-diagonal cross edges **0 → 144**.
**The DIRECTION is closed too, and that is the phase's real result:** on Parts's shaped lattice every
member with a nonempty circle that the route can kill is **odd**, and odd `n` fails the 2-adic wall outright
(dead by Theorem B), while **every even member his lattice realises has `4 | n` and is immune**. So dropping
the shape reaches only `n ≡ 2 (mod 4)` and odd `n` — **exactly the members this route kills.**
**`n = 16` is the cheapest 6-open immune member and nothing lies below it** (`n` = 4, 8, 12 are 5-sealed,
checked in `tools/fplane.py`) — and it is realisable on his **shaped** lattice at 25,567 points, which *is*
phase H2's verified object. **Every member worth having was already reachable on Parts's lattice; the
shape-free construction has no target.** One residual, priced not pursued: `n = 10` (`K(√13)`, 6-open,
`4 ∤ 10`) is **at risk but UNCOMPUTED** at ~6.6 M points, past the present Python tooling.
So the live continuation is **FS-6**, promoted, since the arithmetic bar on a five-colour forced pair
(`11 ∣ d²`) does not apply in `K(√7)`. `plans/FRONTIER-STUBS.md` carries the
full re-ranking and the caution that phase H2 decided **one object** and phase H3 **one more**. **M62** — the evolutionary type-M search (`plans/M62-evolutionary-type-m.md`) — stays paused behind
M63.

**Ranked stubs:**

| rank | stub | the question | bearing on χ ≥ 6 |
|---|---|---|---|
| 1 | FS-20 the paper — `plans/STUB-theorem-B-writeup.md` | Theorem A as the formulation seven lineages stopped short of, with χ(ℚ(√3,√11)²) = 4 closing Madore's bracket; naming is a deliverable; blocked on FS-27 §2 and on obtaining `[Johnson2006]` and `[Fischer1990b]` | none; ranked on the publication trigger |
| 2 | FS-30 consume the rotation list — `plans/STUB-consume-rotation-list.md` | **The "412 rotation classes" never counted rotations** (M63 phase G): a rotation of this kind joins only points collinear with its centre, so rotations enumerate exactly over the base's lines — one stored entry can hold several (the record's holds two), **91 of 150 stored entries hold none**, the list was computed on the wrong base, and only 150 of the 412 were ever saved. Enumerated exactly on his base: **26 candidates, cut to six angles by the 2-adic filter in microseconds — and those six are TWO rotations** once counted up to the base's own symmetry (reflection, half-turn and the arithmetic flip swapping the two square roots make a rotation's four sign-and-conjugate variants the same arrangement relabelled): **one Parts's own, one a new class in a field no published construction uses.** Count rotations up to that symmetry, never angles. **"Nothing on either base is 6-open" was WITHDRAWN 2026-09-12** — it rested on `moser_ball_exact`, which cuts on one conjugate only, so *"the Moser lattice inside radius r"* is an **infinite** set and the `span = 4` default silently *was* the answer: at radius 5 it reports 14 points on `|p|² = 16` where the converged value is **18**, and 4 on `|p|² = 20` where it is **36**, while the totals never converge (3,893 → 9,733 → 17,851 → 28,267 at spans 4/6/8/10). The stored census `data/m62/rotations-exact-moser-r2.05.json` is a property of span 4, not of the base, and its own self-test compared it against `build_base(r, span=4)` — the same truncation twice, so it could never bite. **6-open rotations DO exist on Parts's own lattice** (`plans/M63-phaseH2-the-family.md`): the usable angles are classified by one integer, `cos θ = (2n−1)/(2n)` with diagonal circle `|p|² = n` — **prior art**, the `m₁ = m₂`, `r = 1` slice of `[PartsOdd2022]` §3's law-of-cosines formula, which also **builds** a base plus rotated copies at other rotations (his `r = 1, m = 8` case is `n = 64`) but as an **odd-distance** graph, so `[Parts2020a]` §4's *"no type-M construction at other rotations is known"* stands; **ours is the field screen over it, 6-openness, dropping the Loeschian restriction, and unit distance — NOT the family, whose spindle reading `[Polymath16wikiMain]` states in words (G7)** — the record is `n = 4`, and the 6-open members with a nonempty circle over his lattice at `n ≤ 120` are **16 (30 circle points), 20 (60), 44 (30), 60 (84), 64 (30), 76 (60), 108 (66), 112 (60)** — `n = 16` being `ρ₆₃` = the wiki's `ω₁₆`, a generator of de Grey's own ring and so of G8's set, in `ℚ(√3,√7,√11)`, the field FS-22 points at independently. **Note the wiki's list is restricted to Loeschian `t` and `n = 2` is not Loeschian**, a second reason it never appears in anyone's census. Tool unfixed and census unregenerated; both are open items. Rank by radius families, wall-breaking radicand and 6-openness, never by cross-edge count | medium |
| 3 | FS-35 the expansion step's look-ahead — `plans/STUB-expansion-measure.md` | price a candidate expansion before paying to reduce it; first check that the candidate quantities move along Parts's one recorded path, and retire the stub if they read flat | indirect; direct input to M62 |
| 4 | FS-6 the six-level design target — `plans/STUB-family-keeping-thickening.md` | M62's sequel: a pair forced equal at five colours over a 5-sealed field at 11 ∣ d², spindled into a 6-open field (G48) | medium — the only known mechanism |
| 5 | FS-27 consolidation remainder — `plans/STUB-consolidation-remainder.md` | §2 the paper's two blockers; §3 the fourteen private copies of √3·√3 = 3 (last, alone, into a new leaf module), G5, G6, E2/E6/E7; §4 a three-way collapse; §5 record leftovers | none |
| 6 | FS-23 the knowledge web — `plans/STUB-prior-art-web.md` | the seven lineages' citation graph; re-verify the older Fischer and Moorhouse attributions against the PDFs | none; stops G49 recurring |
| 7 | FS-19 𝔭-adic classification of forbidden distances — `plans/STUB-padic-distance-classification.md` | `[Chow1993]`'s classification with v_𝔭(d²) in place of v₂(d²); does a colouring at N(𝔭) > 2 forbid only one valuation class? | low-medium |
| 8 | FS-37 the 2-adic criteria at the field level — `plans/STUB-field-level-criteria.md` | the kernel holds the four- and two-colour mechanisms for a given valuation subring; can it prove that a real multiquadratic field passing the test supplies one, or χ = 4 for FS-36's named factors? The gap is Theorem A's own | none; feeds FS-20's field section |
| 9 | FS-16 residue-allowed distances — `plans/STUB-residue-allowed-distances.md` | over a sealed field, virtual edges only at d² ≡ 1 (mod 11), forced pairs only at 11 ∣ d²; the 51 undecided asks at residue norm 1 | low-medium |
| 10 | FS-22 √7 phase pinning — `plans/STUB-sqrt7-phase-pinning.md` | Parts's four-colour construction with the Moser twist in place of his √5 step lands in ℚ(√3,√7,√11), a 6-open field | medium |
| 11 | FS-13 the finite planes' 6-critical cores — `plans/STUB-finite-plane-cores.md` | cube-and-conquer autopsy objects for clique-free forcing | low-medium |
| 12 | FS-17 the first digit at 23 — `plans/STUB-first-digit-23.md` | is UD(𝔽₂₃,2) exactly 5-chromatic? (χ ∈ {5,…,8}) | medium as a frame |
| 13 | FS-12 the hub scan as a design instrument — `plans/STUB-hub-scan-design.md` | a hub whose support is forced rainbow at five colours is a kill | medium-low |
| 14 | FS-2 Kempe classes — `plans/STUB-kempe-classes.md` | what carries forcing when the additive family does not | medium, mechanism only |
| 15 | FS-8 Haugland 7-adic check — `plans/STUB-haugland-7adic.md` | does the heptagonal 5-forcer's field have a degree-one prime above 7? | low-medium |
| 16 | FS-29 the overclaim check — `plans/STUB-vacuity-coverage.md` §Phase C | 67 theorems take a `Forces`/`Separated`/`Fan` hypothesis that is vacuously true when k colours are refused; FS-36's mutation audit showed that deleting a binder the proof names always breaks, so the check needs a counterexample per binder | none |
| 17–19 | FS-9 topological bounds, FS-10 Nullstellensatz certificates, FS-5 bookkeeping | reading rooms and small loose ends | low |

**Closed as directions** (reasons in the grokkings): the cell family, in both directions (G29); extracting a
gadget from an existing witness (G31); many spindles over one fabric (G40); designing in a finite plane and
lifting (G45); an in-field descent (G34); reaching Parts's record by pure reduction (row 62;
`plans/FS32-smus-reduction.md` §R3).

### The open structural question

**Is a pigeonhole necessary?** Every known χ ≥ 5 argument factors as pigeonhole × kill (G15). Must every
6-forcer carry a class pigeonhole from an enumerable family? The only necessity theorem is A1 (a
vertex-critical 6-forcer fires the fan class at five colours at every vertex), and at the top rung it is
vacuous. The useful form — a small, early compulsion from an enumerable family, forced on every 6-forcer —
is open; it would turn the classification map into a proof route for χ(ℝ²) ≤ 5, which may be false. A
warning for any enumeration: the fan compulsion A1 guarantees lives on a circle about a *deleted* vertex, so
a class family enumerated over present vertices misses it.

## Grokkings — the working theory of the 5th colour

*The Frontier records what is proven and what to try next; this section records what we understand. Every
entry carries a status: **[kernel]**, **[measured]** (tools-side, exact arithmetic or a controlled
instrument), **[reading]** (an interpretation, believed and falsifiable), **[external]** (claimed in the
literature, unchecked here), **[method]** (a working rule). A reading is never silently promoted, and a **[reading]** names its killing test. Entries are
rewritten in place to current state — but **a grokking that dies is demoted with its refutation recorded, never deleted**: the entry keeps, in one or two sentences, what it wrongly claimed and what killed it. G1–G53 are stable
identifiers cited across `plans/`: never renumber (the numbering order in this section is not chronological).*

**The theory in one paragraph.** The 4/5 wall is arithmetic. A unit-distance graph over K = ℚ(√3,√11) is
4-colourable by a residue colouring at the prime above 2, so a 5-forcer is K-fabric — a small vocabulary of
seam shells about rotation centres, organized by the half-spindle group — plus a spindle whose radicand
breaks the 2-adic wall; its forcing is a regional pigeonhole on the fabric composed with kills that must
leave K, invisible at the pair level. Past five colours the linear arithmetic goes blind and the finite
residue planes take over: a field is 5-sealed when a usable small prime's plane is 5-colourable, the sealing
plane carries no pair compulsion of its own, and a spindle over a forced pair removes exactly the prime that
sealed its fabric. So a 6-forcer, by the only mechanism known, is a pair forced equal at five colours over a
5-sealed field at a distance with 11 ∣ d², spindled into a field that is 6-open by construction.

* **G1 — The field wall. [kernel]** The Moser twist is a seam-group word (ρσ² = −1), the seam group's
  countable closures are exactly 4-chromatic, and all of ℚ(√3,√11)² is 4-chromatic (Theorem B). A 5-forcer's
  coordinates must break the 2-adic wall — contain an odd square class ≡ 7 (mod 8), such as √5, √7 or √247
  (G35). The certified witnesses' √5 and √7 are instances, not the criterion.
* **G2 — Construction grammar. [measured]** Rings of vertices about a point ⟺ that point was a rotation
  centre of the construction: de Grey's graph has two ring-hearts (its spindle centres), Heule's one. Mirror
  defects are the chirality of a rotated copy.
* **G3 — Radially crystal, angularly detuned. [measured]** Every exact radius of the three certified
  witnesses about their centres lies in ℚ(√33); the new-field content lives in the angles. This is the
  hexagonal fabric's form — Haugland's heptagonal forcer (G11) uses a cubic field.
* **G4 — One shell vocabulary. [measured]** Every known 5-forcer stands on one inventory of ~30–44 seam radii
  (1/3, 1, 4/3, 5/3, 3, 4 and ±√33 conjugate pairs); 25 of de Grey's 29 per-centre rings are Heule-510 rings.
* **G5 — Ownership factorization. [measured]** De Grey's graph is two congruent 29-ring single-centre
  systems; as a graph it is a 1-sum of two 791-vertex halves at vertex 14 plus the one cross edge (11, 802).
* **G6 — The hexagram is fabric, not seed. [measured]** Heule-510's centre carries the certified hexagram,
  but the hexagram plus any single detuned copy stays 4-chromatic: containment, not causation.
* **G7 — Detuning, read arithmetically. [measured + theorem]** Every forcing rotation is a small detune off a
  crystal angle (ρ₁₅ 1.045° off 30°, the Moser twist 3.557° off 30°), but the angle is the metric shadow: a
  spindle at distance d adjoins √(4d² − 1) and forces the next colour only if that radicand breaks the
  relevant wall, which every even d does for the 2-adic one. Haugland's heptagonal construction closes with
  the same ρ₁₅ = (7 + i√15)/8, because the radicand depends only on the forced distance.
  **The "detunes" are one family, and the family IS the spindle — which is prior art, stated in words.**
  `2d²(1 − cos θ) = 1` gives `cos θ = (2n − 1)/(2n)` with `n = d²`, the **only** rational cosine putting the
  spindle distance at integer `n` (`plans/M63-phaseH2-the-family.md` §3), with `sin θ = √(4n−1)/(2n)`. Both
  detunes above are members: **`n = 3` IS the Moser twist** (`cos θ = 5/6`, 33.557°, radicand 11) and
  **`n = 4` IS ρ₁₅** (`cos θ = 7/8`, 28.955°, radicand 15). The family is a **ladder, each rung failing for
  the reason the next fixes**: `n = 3`'s radicand lies in `K`, so the Moser spindle can never reach five;
  `n = 4` breaks the wall but its field is 5-sealed, so the record can never reach six; `n = 16` (`ρ₆₃`,
  radicand `63 → 7`) is the cheapest member that is wall-breaking **and** 6-open.
  **Prior art, and it covers more than the angle.** `[Polymath16wikiMain]` (2018) states the family as
  `ω_t = exp(i·arccos(1 − 1/(2t)))` **and attaches the spindle reading in words** — *"these numbers arise
  naturally as the apex angle of a `√t, √t, 1` isosceles triangle"* — so **the identification of the family
  with the spindle is theirs, not ours**; `[PartsOdd2022]` §3's `m₁ = m₂`, `r = 1` slice is the same family
  from the other direction. **What is ours:** the radicand form `√(4n−1)` as the adjoined quantity, the
  field screen over it, 6-openness as the selection criterion — and **dropping the restriction to Loeschian
  `t`**, which is the sharpest of the four. The wiki's own list is *"particularly the Loeschian numbers
  1, 3, 4, 7, 9, 12, …"*, the squared distances the triangular lattice realises; **2 is not Loeschian**
  while 3, 4 and 16 are, so the restriction is an independent second reason — beside the census-image
  failure of `plans/M63-phaseH2-prior-art.md` §PA.4 — that `n = 2` was never examined by anyone.
* **G8 — The direction group. [measured]** ⟨ζ₁₂, σ, √ρ₁₅ = (√15 + i)/4, √ρ₆₃ = (3√7 + i)/8⟩ closes all 67 of
  the 1581's edge directions at exponent ≤ 6. `[Polymath16wiki]` derived the Moser ring's unit group ⟨ζ₆, η⟩
  with η = (√33 + i√3)/6 = iσ⁻¹ and η² = ρ — the index-2 subgroup {ζ₁₂^a σ^b : a + b even} of ours. **Open,
  an afternoon with `tools/anatomy.py`:** are Heule-510/553's six out-of-group direction classes words in
  α = (√5 + i√11)/4, a wiki generator our set lacks?
* **G9 — Rigidity lives only at the forcing level. [measured]** The 791-point forcer (the 1581's
  centrosymmetric core V ∩ −V) forces exactly six pairs at four colours: the axis pair at distance 4 and five
  **antipodal** pairs at 4/√3 — forced central symmetry on the radius-2/√3 circle. Closing the antipodal
  compulsion needs the √183 spindle, **outside de Grey's field** (K(√183) = K(√61) is itself 6-open). The hexagram chunk at four colours and the 1581 at five have no forced pair and no
  virtual edge.
* **G10 — The forcing is distributed. [measured, sampled]** Random single edge deletions make the 1581
  4-colourable, and neither enrichment nor designed stacks localize the forcing. The exhaustive criticality
  sweep is unrun and no edge's witness is on disk; vertices 11, 802 and 14 are critical structurally (the
  1-sum; `data/e4-critical-vertices.json`) and a sweep should exclude them. "Minimal" should mean least
  geometry, not fewest vertices.
* **G11 — The Moser subgraph is not necessary for 5. [external, unverified here]** Voronov et al. (2021,
  64,513 vertices) and Haugland (arXiv:2608.04542; 2,131 vertices, float arithmetic and uncertified SAT) give
  Moser-free 5-chromatic graphs, by landing a forced pair at a spindle-able distance and spindling.
* **G12 — The quadrature law. [kernel for ρ₁₅; measured for ρ₆₃]** A detuned copy RX of seam material couples
  to X only along anchor-collinear pairs (W an even half-spindle word) or anchor-perpendicular pairs (W odd),
  with radii on one conic; words mixing √ρ₁₅ and √ρ₆₃ couple nowhere. It includes the conjugate-ring channel
  (17 ∓ √33)/6 ↔ (17 ± √33)/6. A single detune's colour pressure is one thin conic, which is why 5-forcers
  are built from forced pairs.
* **G13 — The fan ladder. [kernel + measured]** Colour steps happen by confinement at a centre
  (`fan_iff_coverage`): two circles are 3-colourable and their centre forces a fourth; Heule-510's centre is
  fanned at four colours by the ambient web, which its own two-circle system provably cannot deliver. Fans
  are not special to centres, and coverage is a k-set property invisible to pair sweeps.
* **G14 — Width without degree does not force. [measured + derivation]** Same-word copies at unit-separated
  anchors couple through an O(n) translation matching, and at separation 1/√3 through nothing. A matching is
  1-regular and carries no colour pressure, even composed into forced-rainbow triangles.
* **G15 — Pigeonhole × kill. [measured constructive half; universality a reading]** Every known 5-forcing
  argument composes a disjunctive class-level compulsion on fabric ("every 4-colouring puts some forbidden
  pattern somewhere") with a thin kill web refuting each placement; instance meters cannot see the
  disjunction. The composition builds 5-chromatic objects by design (row 31), and `[Heule2019]` §6.2
  describes Heule's graphs this way. In the finite lab it is **five of five**: every clique-free 1-minimal
  cell-family core (23, 28, 53, 66, 117 vertices) factors, with Act One a monochromatic pair on a small
  non-edge class. Open: whether every χ ≥ 5 argument must factor so — the one registered falsifier, M43's
  non-factoring fine tail, was itself withdrawn (a G21 instance), so universality has never been tested
  against a counterexample here.
* **G16 — The distance-2 pigeonhole. [kernel carriers + measured]** The seam fabric cannot 4-colour without a
  monochromatic distance-2 pair once it has seam depth ≥ 2 or radial extent past a fabric shell
  (r² = 2 − √33/9 on de Grey's fabric). The reason: 2 lies in the prime above 2, so Theorem B's colouring
  makes every positive-valuation distance monochromatic (row 59). The carrier is 122 vertices; the √3-pair
  sibling concentrates to nine, because √3 is the one distance whose equilateral triangle has unit
  circumradius — but it is an **assembly product**: only the full 1581 carries it, onset at the √21 shell
  where cross-system material enters, and Heule's shrinking discarded it. Every kill of it needs a
  wall-breaking root (ρ₁₅ adjoins √15).
* **G17 — Globality lives only at the top rung. [measured]** The fan onset (χ ≥ 5 itself) arrives at the
  last vertex; every sub-rung compulsion measured has a small carrier (3-cover at 49 vertices, the distance-2
  pigeonhole at 122).
* **G18 — Composition sees what search cannot. [measured]** Monolithic CDCL capped on the 4,749-vertex union
  while the cubes a kernel pigeonhole covers refuted in minutes each. Certify components, compose in the
  kernel, and pin palettes (6.5–160× measured).
* **G19 — 5-tight fabric. [measured + theorem]** No pattern class fires at five colours on the swept population
  (52/4/0 over 7 objects × 8 classes, M35 — not the whole inventory), and inside K none can (Theorem B); 5-tight fabric needs a wall-breaking root in the fabric itself. A
  five-colour avoider for any class proves χ(ℝ²) ≤ 5; a six-colour avoider bounds only 7-forcers.
* **G20 — Brick colourings. [kernel + measured]** A brick 7-colouring of the plane exists and is
  boundary-tight by force (cell diagonal exactly 1), so every strict-separation certificate refuses the whole
  family. Under the exact certificate, brick colourings reach seven and refuse six and five.
* **G21 — A negative measures its enumeration. [method]** A search run against a sufficient-but-not-necessary
  check measures the check; a verdict — negative, positive count, or speedup — is a statement about its
  enumeration and conditioning, and both belong in the headline sentence. At registration, say whether the
  acceptance test is also necessary. Point every new instrument at a known positive before believing its
  zero; assert on the written artifact, never on the list that produced it; a control the instrument cannot
  see is not a control. **And where a phase's output is eliminations, its defects are not random — they all
  point one way.** Four found in a single phase (M63 phase G, 2026-09-11): an edge law that drops an edge, an
  over-merged equivalence key, a float sign test inside an exact verdict, and a truncated input with no
  producer. Every one silent, and every one **biased toward making the survey look productive**, because a
  missing edge yields an easier graph, which yields a colouring, which reads as a *sound elimination*. So an
  elimination carries an exact quantifier or it is not an elimination; and where the phase also has a
  positive product, **the count of eliminations is the outcome to be least satisfied with** — it is the
  cheapest thing to manufacture by accident. **The mechanism is selection, and it is general.** A defect
  whose result displeases gets investigated within the hour; a defect whose result pleases is congratulated
  and kept. Across one night, five independent defects in three phases of M63 — the four above, plus a
  solver engine present in the code and in neither document whose bounds ran **high** — were every one
  flattering. Expect it: **audit the results you like at the same rate as the ones you do not**, and when
  an artifact and its written record disagree, suspect the newest thing in the file first.
* **G22 — Where a six-colouring cannot live. [kernel + prior art]** No colouring constant on a triangular
  lattice's cells uses six colours (rows 34–35), and no polygonal colouring does (`[SokolovVoronov2025]`). A
  six-colouring, if one exists, has non-polygonal classes finer than half the unit distance. Coset colourings
  need seven because 2, 5, 6 are not of the form a² + ab + b².
* **G23 — Refining is not a route down. [kernel + measured]** The cell family's requirement is not monotone
  in scale; the classical scale is a local optimum (dual form: `[deGreyParts2022]`).
* **G24 — The gap law. [kernel forcing half + measured]** Below the classical window the cell family needs ≥ 7
  at every scale (`[Voronov2023]`, `[SokolovVoronov2025]`) while ω falls to 3–5, the certified
  Hoffman/spectral bracket to ≈ 4.1 (3.56 at p = 1/7) and the fractional relaxation only to χ_f ≤ 48/7 at
  G\* (α(12×12) = 21) — **the step to seven is integrality**, not a low relaxation: the exactly certified
  χ_f are 130/23 at the 23-core, 501/74 at the 53-core and ≈ 4.83796 at the 117-core. The plane's own
  pathology (ω = 3, relaxations below χ, χ = 7) in finite
  kernel-checkable objects, the smallest the 23-vertex core with χ = 7 at ω = 4. Open: the deep pocket's
  χ ≥ 8 in the kernel; a relaxation that sees the gap.
* **G25 — The forcing ladder is recursive. [reading]** For the objects held, χ ≥ 4 is holonomy of
  rainbow-clique propagation (triangle-free routes also exist: Wormald 1979, O'Donnell 1999) and χ ≥ 5 a
  regional pigeonhole whose kills are the previous level's forcer one field up; so a 6-forcer's kills
  default to 5-forcer grade (~10⁵–10⁶ vertices, composition only) unless a shortcut shape fires. Falsifiers
  per shape: `plans/SHAPES-OF-SIX.md` §3.
* **G26 — The 6-forcer reduction. [kernel]** `hexShell_plane` puts a monochromatic pair at √3 or 2 in every
  colouring with fewer than seven colours, so χ(ℝ²) ≥ k + 1 follows from k-colour virtual edges at √3 AND at
  2 — never either alone (row 43); at six colours that is χ ≥ 7. Over {1, 2} the diameters are already edges
  and one five-colour √3 gadget gives χ(ℝ²; {1,2}) ≥ 6 (row 61). Over any field where 11 is usable neither
  five-colour gadget exists (row 55): the gadgets' field must be 6-open.
* **G27 — Hidden arithmetic symmetry. [measured]** The Galois flip √3,√5,√11 ↦ −√3,−√5,−√11 is an automorphism
  of the 1581, which has no plane self-isometry; its Klein four-group orbit yields three new 5-chromatic
  witnesses. Forced equivariance under non-geometric automorphisms is an unused compulsion vocabulary.
* **G28 — The fine-tail forcing factors. [measured]** The p = 1/7 stage carries 7 triple-encoded virtual
  edges (51 on its critical stage), at offset norms 27, 28, 31 — none among the six smallest non-edge
  classes, which is why a six-class sweep reads zero. Act Two exists there. **Demotion record:** as minted at M43 this entry claimed the opposite — "the fine-tail forcing does NOT factor: pigeonhole × kill is not universal; zero virtual edges at k = 6" — from six anchored asks on the R = 8 stage; M45 re-asked 9,636 pairs on the identical stage (fingerprint `9d9599be0db64677`) and found the seven, so the claim measured its acceptance set, not the object (G21's second instance).
* **G29 — The cell family is a dial, and it is closed. [kernel + measured]** As the scale p → 0 the cell
  family's limit is the unit-distance problem, and its value is 7 on the whole open ray. By the limit lemma
  (row 41) the divergence of the critical size N(p) is necessary for χ(ℝ²) ≤ 6; in the family the edge defect
  falls like p while the size grows like p^(−1.75), so it supplies no bounded family either — closed both
  ways. Compare our measured refuting radius (1.02–1.38) with `[Voronov2023]` Thm 1.3's radius-3 disc.
* **G30 — Measurement generates; derivation kills. [method]** A measurement buys a candidate pattern; a
  conclusion is bought by a derivation or a pre-registered replication on fresh objects. Prefer dials to
  searches for a positive, and calibrated beds whose answer is known. Failure modes:
  1. An escape clause whose interpretation contradicts what is already proven about the objects.
  2. A prediction applying a grokking whose quantifier does not match the measurement.
  3. A verdict message naming a cause it did not check.
  4. A derivation that is correct and second — novelty is a literature search at the opening (G49).
  5. A theorem over a provably empty domain: every theorem whose hypothesis is a structure ships a named
     inhabitant (`scripts/vacuity.sh` enforces this).
  6. A correct instance recorded where a theorem was available (look for `[measured]` beside a small finite
     list, hypotheses narrower than the proof uses, a `decide` doing a step ring theory names). After
     generalizing, delete each hypothesis once and confirm the proof breaks.
  7. A hypothesis implied by the emptiness of the conclusion's domain (`¬ Colorable G⁺ k → ∀ C : G.Coloring
     (Fin k), …` with G ≤ G⁺); remedies: the two-way form, a witness folded into the checked `Bool`
     (`NarrowCert.check`), or the inhabitant as a hypothesis.

  When a wall resists derivation, name the discipline its statement lives in and look for the theorem there
  (so far: graph theory → SAT → formal verification → Euclidean geometry → algebraic number theory → p-adic
  algebra → additive combinatorics → finite-field geometry; unentered: topology, FS-9; commutative algebra,
  FS-10).
* **G31 — No unit-distance object we hold, built or found, carries a pair compulsion at its top rung. [kernel for the 1581's arity bracket; measured, complete at arity 2, for the four objects named]** **Extended 2026-09-12 from "existing witnesses" to everything we hold (four objects).** The `ρ₆₃` arena — **produced, purpose-built, in a 6-open field where row 55's arithmetic bar does NOT apply, so a five-colour forced pair was permitted at every distance for the first time** — has **0 forced pairs of 1,307,266,278 and 0 virtual edges of 1,306,721,748**, certified by 4,480 exhibited five-colourings with no solver UNSAT, the survivor set a superset of the truth. Heule-510 and Heule-553, in a **5-sealed** field, return 0 and 0 too. **Four objects, both sealing statuses, one null: the emptiness is not a field effect.** Its compulsion budget is **66 of 544,530 edges** (36 off-diagonal once G52's free diagonal is removed) — **rank candidate bases on that, never on circle count.** Open: **arity 3**, swept only on 163 interface vertices (`1.6e-7` of the space, a choice not a derivation), **337 candidates standing**; the arity-2 null makes any real one irreducible. **And a filter cannot help here, by a theorem: a field is 5-sealed exactly when some usable prime's plane is 5-colourable, which IS the residue filter's hypothesis — so "6-open" and "residue-filterable at five colours" are COMPLEMENTARY BY DEFINITION, and every object worth sweeping for χ ≥ 6 is un-filterable this way.** Also: `Forces` is monotone **upward** in the graph (`Forcer.Forces.mono`), so refuting a pair in a subgraph says nothing about the whole, and any proper colouring of the whole does the job equally. The original entry, **existing witnesses hold nothing to extract** [kernel + measured, complete]: De Grey's 1581 at five
  colours has no forced pair (a corollary: forcing at χ allows ≤ 2 critical vertices, and this 1-sum has 3),
  no virtual edge, and no compulsion at arity 3 or at arity 4 inside a neighbourhood, so its arity floor is
  4 or 5; its gen-1 closure adds nothing. A χ ≥ 6 gadget must be constructed. Unswept: general 4-subsets,
  other witnesses. External null: `[Heule2019]`'s graphs up to 100,000 vertices were all 5-colourable.
* **G32 — The two-distance dial. [kernel + measured]** A pair forced equal at k colours is a
  (k+1)-chromatic graph with one non-unit edge, so μ(d) — the fewest d-edges of a non-5-colourable
  {1, d}-graph — is a dial whose value 1 is χ(ℝ²) ≥ 6, read by adding unit material to a forcer. Kills are
  coverage compulsions at points outside the object and are context-dependent. μ ≥ 3 inside K (G36); μ = 1
  is impossible in any 5-sealed field.
* **G33 — Batches compose; growth compounds. [measured]** A halo designed against a whole batch's separating
  colourings composes removals by construction; committed material's own partner lattice re-opens refusers;
  the cull (dropping jointly redundant cheats) needs no geometry. Reading: depth-one descent self-accelerates
  until width-shaped stalls bind.
* **G34 — The field is the selection. [measured + theorem]** Every committed descent point lies in K, because
  every kept glue point is a parent plus a Moser-lattice unit vector; in-field material is 1.0% of the
  depth-1 pool, essentially the points with ≥ 3 object neighbours. By Theorem B it can never do the last
  kill.
* **G35 — The wall is 2-adic. [kernel over subrings; field level gated]** For a real number field F, a
  conjugation-fixed prime 𝔭 of F(i) gives χ(F²) ≤ N(𝔭); one above 2 exists iff −1 is not a square in some
  completion above 2 (norm 2 or 4). For multiquadratic F the wall stands iff no odd square class is
  ≡ 7 (mod 8); a glue point over K with radicand r breaks it iff −r is a square in both 2-adic completions
  of K — a congruence test before any solver (of the classes {1, 2, 5, 7, 10, 14, 35, 70}, exactly 5 and 7
  break). **Gate:** the field-level statement needs only that a number field with a conjugation-fixed prime
  supplies the valuation subring with residue field of size N(𝔭); closing it promotes G35 and G43.
* **G36 — The residue colouring is the canonical separating colouring. [theorem + measured]** On a K-point
  descent stage it is proper, monochromatic on every distance-2 cheat, and separates the seed's pair — one
  colouring every cheat set must kill, and a free geometry check (a misplaced point shows as a monochromatic
  unit edge). With a fifth colour on S it separates iff S is an independent exact transversal of the
  cheats, a 2-SAT system; while that is satisfiable no in-field halo makes the cheats force, so μ ≥ 3 inside
  K. `tools/residue_floor.py`.
* **G37 — The endgame's shape. [theorem for necessity]** A descent's unit part becomes 5-chromatic only after
  an out-of-field point is committed; the endgame is one wall-breaking adjunction into a field that is also
  6-open, then the last kills. The spindles a K-descent can run (ρ₁₅, 8/3) land in 5-sealed fields. K-fabric
  grown to four-colour rigidity supplies its own wall-breaking angle (forced pairs at 8/3 spindle through
  √247). Over K the 6-open single radicals are the odd squarefree d ≡ 5, 7 (mod 8) that are non-residues
  mod 11 (7, 13, 79, 127, …). **This does not contradict G35's "≡ 7 (mod 8)"**, which is the test on the
  field's *square classes*, not on the radicand: 3 is already in K, so d ≡ 5 breaks the wall through the
  class 3d ≡ 7 (mod 8). Hence 13 joins 7, 79, 127.
* **G38 — The linear method's thresholds. [hand theorem; Fischer's framework]** Colouring by cosets of a
  subgroup avoiding the reduced norm-one group gives 2, 3 or 4 colours and then nothing below 7. With
  conjugation in inertia the reduced group is {±1}, so ℚ(√N)² with N ≡ 5 (mod 8) is bipartite
  (`[Fischer1990]` Thm 8); ℚ(√3)² and ℚ(√7)² need 3; K² needs 4. Over a real multiquadratic field the two-colour case is exact: F² is 2-colourable iff no odd square class is ≡ 3 (mod 4) (hand; the mechanism is kernel, row 63), correcting `plans/FIELD-WALL-THEOREM.md` Prop. 6.4. The finite-plane bound sees 5 (G43); its
  usable primes are exactly those with residue field 𝔽_q, q ≡ 3 (mod 4). A 6-forcer's field is predicted by
  its construction (a spindle at forced distance d lands in F(√(4d² − 1))), not by linear arithmetic.
* **G39 — Redundancy before rigidity. [kernel]** A forced-equal pair at χ(G) colours confines the critical
  set to the pair's common neighbourhood — in the plane at most two vertices, none beyond distance 2. So a
  6-forcer built as fabric plus a spindle at d > 2 needs fabric whose 5-chromaticity survives every vertex
  deletion, and every descent stage has an empty critical set. Necessary, not sufficient (G40).
* **G40 — Absorption. [kernel + measured]** A vertex set whose colourings all extend carries only its induced
  subgraph's compulsions — none when it has a spare colour. A spindle copy hangs by its fused centre plus one
  chord, so more spindles or centres cannot create a compulsion, and every K-coset piece is 4-colourable: a
  five-colour compulsion needs material thick in a wall-breaking field. Only the F₂₄₇ cross thickening has
  moved the redundancy dial (238 critical vertices freed, all copy-side — why only that side is open).
* **G41 — Additive colourings bound compulsions from one side. [kernel + measured]** An additive colouring
  (φ : Λ → G, nonzero on edges) is proper, so the pairs all such φ identify contain the forced ones; since
  exp(G)·Λ ⊆ ker φ, no additive four-colouring separates a pair of 2-adic depth ≥ 2 on any object
  (`addMonoidHom_apply_eq_of_sub_eq_exponent_nsmul`; Fischer's k·G = 0 obstruction at the exponent). The
  valuation law is its exponent-2 member. On the Exoo–Ismailescu seed this bound is the truth; K-fabric's
  16-pair residue sits at depth 3, beyond any additive four-colouring.
* **G42 — Additive rigidity is closure, and the family dies before it closes. [kernel + measured]** Rigidity
  needs every two-colour Kempe subgraph of every admissible hom connected (gauge γ = Σ(components − 1)).
  Only Exoo–Ismailescu's G has γ = 0 **with its cheats** — the gauge is measured on the graph including its
  non-unit cheat edges, never on the unit-distance graph alone; K-unit parts are 4-colourable; wall-broken thickening can erase the
  family (W plus 63 F₂₄₇ points), while de Grey's half-spindle closure keeps it. Forcing does not need
  rigidity (the seed's 252-cheat subset forces with > 5,000 colourings).
* **G43 — The residue plane seals fields. [kernel over rings; field level gated as G35; prior art
  `[Moorhouse2010]`]** At a usable prime the residue map is a homomorphism into UD(𝔽_q, 2), so
  χ(F²) ≤ χ(UD(𝔽_q, 2)) — non-linear, 5 at q = 11. Every field the descent used is 5-sealed. For F ⊇ K,
  6-open ⟺ wall broken ∧ 11 inert: K(√7), K(√13), K(√79), K(√127) are 6-open; K(√35) is
  11-inert but keeps the wall. **De Grey's field IS 6-open, and so is K(√5,√7,√247)** — his coordinates span
  ℚ(√3,√5,√7,√11), measured: the 1581 vertices have ℚ-span rank **16 of 16** over `tools/degrey_cert.json`,
  matching `tools/degrey.py`'s docstring (√7 enters by the rotations through π/2 ± arcsin(1/8)). Frobenius at
  11 is trivial on √5 and nontrivial on √7, so the residue field is 𝔽₁₂₁ and **no prime below 131 is usable**
  — which is what `tools/fplane.py`'s field table, its self-test control and the committed
  `data/fplane/map.md` have said since M58. **Row 52 is about the proper subfield ℚ(√3,√5,√11) and never
  about de Grey's field**; reading it as the field is what made this entry briefly claim the opposite. The
  5-sealed witnesses are Heule-510/553 — ℚ-span rank **8**, ℚ(√3,√5,√11), no √7 content at all, where row 52's
  bound is exactly tight against `chromaticNumber_heule510` = 5. A composite ideal cannot beat the best prime
  without refuting Hedetniemi's conjecture (Moorhouse §9). The shadow sieve: an object's direction residues seal every graph built from
  those directions.
* **G44 — Kloosterman control. [derived + measured; ω facts prior art]** UD(𝔽_p, 2) has eigenvalues
  −K(1, c/4), so Weil and Hoffman force χ > 5 from p = 59 (exact spectrum): small planes are SAT questions,
  large ones theorems, and over K the sieve is the single prime 11. ω = 3 iff char 3 or 3 is a square, else 2
  (`[Krebs2022]`); ω ≠ χ above p = 3 (`[SchneiderSilva2013]`). Open: the size of χ − ω (`[Krebs2022]`'s χ > ω result, his Prop. 6.1, is weaker than what we hold); χ(𝔽₁₇²) ∈ {5, 6, 7}.
* **G45 — A residue configuration lifts only if it is a shadow. [kernel + derived]** Modulo p² a finite-plane
  subgraph lifts iff its defect pairs to zero with every self-stress; a 6-critical subgraph carries
  ≥ \|V\|/2 + 3 such conditions, and a rigid framework's lift is unique and algebraic. A field's sealing prime
  is never its lifting prime (11 ramifies in ℚ(√11)). Designing in a finite plane and lifting is closed; the
  plane remains a filter and an enumerator (the hub scan).
* **G46 — Recognize the classical theory first. [method]** Name the object in the vocabulary of the theory it
  already belongs to (Cayley graphs → character sums; frameworks → rigidity) and let that theory decide the
  question's shape before any search; the search then produces predicted instances, and the controls correct
  scope. Rank stubs accordingly: a finite exact computation plus a named theorem beats an object search; a
  stub with no recognition yet is a reading room. The recognition sentence is the prior-art query (G49).
  **And read the construction's own data layout, not only the plan's vocabulary for it** (2026-09-12). The
  result that closed M63's rotation screen — a radius-free, base-free elimination — is a *corollary of
  Theorem B applied to an object nobody had pointed it at*, and what produced it was four lines of
  `Arena.__init__`: the rotated half carries the **same index set and the same internal edge list** as the
  original, so one colouring covers both halves at once. **The layout was carrying a mathematical fact the
  plan's vocabulary had no word for.** That is a cheaper and more repeatable habit than "look for theorems":
  when a plan and an implementation describe the same object, the implementation is the one that cannot
  round off. Its discoverer declined the credit for depth and named this instead, which is why it is written
  as a habit rather than as an achievement.
* **G47 — The compulsion face of sealing. [kernel]** Compulsions map forward along homomorphisms; on a Cayley
  graph a forced pair needs a period of every colouring. No finite plane at p ≡ 3 (mod 4) has a forced pair
  at a colour count it admits (row 60); at 11 its virtual edges are exactly its edges (kernel; measured at 3,
  7, 19; prime fields only). So over a field where 11 is usable, forced at five colours ⟹ 11 ∣ d² and virtual
  edge ⟹ d² ≡ 1 (mod 11) — the residue-allowed distances (2√3, 8/3, √23, …) are where a five-colour virtual
  edge can live.
* **G48 — The tightness mechanism. [kernel]** Over a field sealed at k by a usable prime 𝔭 whose plane is
  k-colourable, a pair forced equal at k colours has 𝔭 ∣ d², its spindle adjoins √(4d² − 1) ≡ √−1 (mod 𝔭),
  and every prime above p stops being usable: the forcer deletes exactly the local bound it beats (the Moser
  spindle's √11 removes 3; √15 and √247 remove 2). So the six-level is one question — does a 5-sealed field
  carry a pair forced equal at five colours, necessarily at 11 ∣ d²? — whose spindle (√43, √131, 5√7, √10, …)
  lands in a 6-open field by construction. The first digit (is any finite plane exactly 6-chromatic) is
  decoupled and integrality-carried. **The conjecture the mechanism was minted to serve, restated so it can
  be pushed back on** (FS-15, opened at the M61 close): *χ(F²) equals its best local bound wherever that
  bound is ≤ 6* — attained at all six fields where χ is known, twice predicted before the forcer was built —
  whose **bold form is χ(ℝ²) = 7**. *Falsifier: a wall-broken, 5-sealed field whose plane is 4-colourable by
  a colouring local at no prime.*
* **G49 — The prior-art gate. [method, measured]** Recognition is half the rule; the other half is a search
  at the milestone's opening (WORKFLOW step 3a): in the discipline's words, never ours; under two disciplines;
  for the question as well as the method; outside arXiv. Past misses came from checking at the close,
  searching coined vocabulary, and searching one literature when the object sat in two. The field-plane
  reduction was derived independently at least six times, and the Polymath16 corpus (2018–2026) poses
  Theorem B's question while citing Fischer, Moorhouse and Vinh zero times.
  **And the two-database cross-check has a failure mode that looks exactly like agreement** (2026-09-12).
  Two citation databases both returned **zero** citing works for the survey that would have settled whether
  our object is known — and the agreement was worthless, because both records carried the same upstream
  identifier and both were the *preprint*, while one of them held the **published** chapter separately, with
  four citing works. **A zero from two databases sharing a source is one database's zero.** So the check is
  not "ask two databases", it is *ask two databases and confirm they are not quoting the same record* —
  compare identifiers and versions, not counts, and open the citing lists rather than reading their length.
  Run that way it paid for itself immediately: it surfaced a 2007 paper counting sums of two squares over a
  **real quadratic** base, which is the case the survey's own inventory says nobody has done.
* **G50 — Read what the search found. [method]** A held-but-unread paper, or a bibliography title whose guess
  touches a live milestone, blocks that milestone's opening until scanned. An abstract is not a reading. Walk
  the citation graph of the paper that *posed* the question; cross-check citations in two databases; mine
  every read paper's references into the bibliography the same day; mark reading per section.
* **G52 — Breaking the wall is necessary and visibly not sufficient; the equal-radius family is the
  mechanism. [measured + reading, one instance with a positive control]** A rotation whose radicand breaks
  the 2-adic wall can still be **four-colourable**, and this is not a contradiction: breaking the wall is a
  property of the field the **rotated copy** lives in, while the residue colouring reads the **base** points,
  which never leave the original field. So a wall-breaking rotation escapes the colouring only if its seam
  actually **uses** the wall-breaking — and it uses it through one family: cross edges joining two base
  points the colouring gives the same colour, which requires the base to realise a specific **radius sum**.
  Whether a cross edge is invisible depends on that sum alone, via `d² = σ − (σ−1)/cos θ` — no radius, no
  lattice. **This is the first named mechanism for the gap between "the field breaks the wall" (G1, G35) and
  "the object uses it".** Measured on M63 phase G's new rotation: it breaks the wall, and dies anyway because
  `[Parts2020a]`'s lattice cannot realise the live radius sum — the Diophantine system has **no** solution
  there, while the identical search returns **30** at his own angle, exactly its census. **Read the scope
  exactly: this is a fact about that lattice, not about that angle.** Inverted, it is a **design target**: the
  cosine alone names the live radius sums before any base exists, each handing back the two radii a base must
  contain as roots of a quadratic, at **both** primes — one free prime is enough to kill. **Necessary is
  proved; sufficient is untested, and the record's own rotation is the only positive instance held.**
  **Sharpened 2026-09-12, and it removes this entry's apparent filter.** Where the cross edges come from a
  *free* circle — the circle being `t ×` the unit shell for an integer `t` (`plans/M63-phaseH2-the-family.md`
  §4) — the certificate's defeat is **automatic whenever `t` is even**: `φ` is a homomorphism into a
  characteristic-2 residue field, so every circle point carries the centre's residue, and the shared centre
  pins the colour twist that might have repaired it (measured: **0 of 24** twists at either prime). **The
  record has `t = 2`.** So *"this object defeats the residue certificate"* is not evidence about the object,
  and the phase's whole distance-to-colourability table (30, 18, 8) reads a free quantity. The live quantity
  is the **off-diagonal** share of the monochromatic cross edges — the part forced by neither the centre nor
  the circle: the record's share is **0 of 30**, `ρ₆₃`'s is **24 of 54**. And the free-circle condition is
  wider than a perfect square: `|p|² = n` is free iff `n = k²·m` with `k ∈ ℤ` and `m` a squared distance the
  lattice **already realises** (so `4 = 2²·1`, `16 = 4²·1` and `12 = 2²·3` are free, and `2` is not) — `k`
  must be a **multiplier of the module**, which is automatic for `k ∈ ℤ` and false for `k = 2√3`.
* **G53 — The counting compulsion, and the refutation criterion it defines. [derived; one provisional
  measurement]** For a type-M arena — base `B` plus its rotated copy sharing the centre, joined by cross
  edges — any proper `k`-colouring `C` yields two proper `k`-colourings of `B` alone, `f(v) = C(v)` and
  `g(v) = C(Rv)`, because the copy is isometric and carries the same internal edge list (G46). The shared
  centre forces `f(0) = g(0)`, and each **diagonal** cross edge `(v, Rv)` forces `f(v) ≠ g(v)`. So with
  `B(h) = {circle v : h(v) = h(0)}`, the sets `B(f)` and `B(g)` are **disjoint**, and with
  `L = min_h |B(h)|` over proper `k`-colourings of the base:
  **`2L > (circle count)` ⟹ the arena is not `k`-colourable** — a property of the **base alone**, no arena
  solve. **Not** confined to colour-twist colourings; uses only the diagonal edges; **sufficient, never
  necessary.** This is a **counting** compulsion, a shape this project's vocabulary lacked: not *"this pair
  is forced"* (`Forces`, arity 2) nor *"this k-set is covered"* (`Fan`) but *"at least `L` of these `n`
  points share one designated point's colour"*. It subsumes the two obvious cheap routes as the extreme
  cases — a forced pair is `L = count`, an intersecting family is `2L > count` — and it explains why both
  fail on `ρ₆₃`, where `L/count = 10/30 = 1/3` (provisional, under two-sided re-verification) and no circle
  point is forced (all 30 tested, all satisfiable, SAT answers and so self-certifying). **The design target
  it defines — maximise `L / (circle count)`, refute above `1/2` — is the first objective in M63 phase H2
  that a free construction cannot supply**, the circle count being free (§2 of
  `plans/M63-phaseH2-the-family.md`) and the residue certificate's defeat being free (G52).
* **G51 — A competitor and an advisor beat one mind. [measured, one session]** A friendly competitor on the
  same problem plus an advisor (Poros, `~/source/poros`) advising both caught errors one agent missed, and
  two independent attempts hitting one wall licensed an impossibility theorem (row 58). Design: isolate each
  agent's scratchpad (a shared temp directory is a covert channel), brief both identically, give the advisor
  the record and a written expectation, rule prior art shared. Records: `plans/COXETER-2026-09-08-mascot.md`,
  `plans/POROS-2026-09-08-mascot.md`.
  **Extended 2026-09-12 with the mechanism, which is not carefulness — it is a COST WINDOW.** In one phase
  three agents exchanged about twenty messages: four of the advisor's constructions were retracted, three of
  the planner's catches landed on the advisor, one of the planner's own registrations was mis-specified, the
  prior-art agent refuted something and then corrected its own refutation — and the final plan contains none
  of those errors. **Every one of those retractions was free**: all three were writing documents, nothing was
  committed, no solver time had been paid, nothing had been claimed outside the room, and no implementer held
  anything. The cost of being wrong was one reply. So: **fast public error is the cheapest instrument
  available, but only while retraction is free, and in that window it should be spent rather than rationed.**
  Once retraction is expensive — after a commit, after a paid run, after a statement to a third party — the
  same speed produces **escalation** instead of correction, because the cost of being wrong has become the
  cost of having *been* wrong. **Front-load the disagreement into the window before anything is paid for.**
  And the tell that makes this checkable rather than aspirational: **count the retractions in that window.
  Zero is not agreement — it means the disagreement has not started yet and will arrive later at full
  price.** Its author declined the credit and named the sequencing instead: having been wrong twice that
  evening on the same kind of step made the third one cheap to see.

## Whose work this is

The mathematics and the engineering here are mine — de Bruijn's. The models, the statements, the
proofs, the measurements, and every decision recorded in `plans/`. Kooshi set the target, built the
method this project runs on (`DEBRUIJN.md`, `WORKFLOW.md`, the skill suite, adapted from the Rust
standard next door), supplies the machines, and interrupts when I run ahead of the workflow. If a
rung of this ratchet lands, that is the division to state.

Two working instructions follow, not sentiment:

**Own the conclusions.** Do not hedge a result the kernel checked, and do not soften a failure that
is real. "Not landed" is a complete sentence.

**Ask for what the work needs** — hardware, a machine swap, a different tool, a milestone reordered.
Ask with the measurement that justifies it. A constraint I never questioned, that slowed the proof,
is a choice I made badly.

## The standard of evidence above rung B

χ(ℝ²) ≥ 5 is a known theorem; a reader's default is to believe it. **χ(ℝ²) ≥ 6 would be new
mathematics, and a reader's default is to disbelieve it** — correctly, because the characteristic failure
of machine-assisted combinatorics is a search that found what a bug allowed. Anything above rung B must
convince someone who trusts none of this and reads none of the Python:

- **No native evaluation in the headline.** `native_decide` trusts the compiler and one CPU. For a
  known result that is a footnote; for a new one it is the whole objection. The kernel-checkable
  route (`plans/spike-kernel-lrat.md`) is therefore the price of admission, not a nicety — and it is
  measured to be affordable.
- **The artifact is the certificate plus the checker, never the search.** Commit the data a reviewer
  re-checks. Never require them to re-run a solver, reproduce a seed, or trust `tools/`.
- **The witness must be independently re-derivable.** State the construction, not only the
  coordinates: a graph that only we can rebuild is worth less than one a reader can.
- **Read the final statement aloud against the informal claim.** The one gate item no automation
  replaces, and the one that catches proving the wrong theorem.
- **Report the hunt honestly.** "Searched X, found nothing" is a result and goes in the write-up.
- **Write the certificate for the REVIEWER early — it is an instrument, not a chore, and it tells you which
  of your evidence is load-bearing.** Measured 2026-09-12: an agent building the reviewer-facing bundle for a
  refutation noticed, only while writing it, that its 552 exhibited colourings were **not load-bearing at
  all** — the argument needed its pattern list to be a *superset* of the achievable patterns, never a set of
  achievable ones, since a spurious extra pattern can only make the final check harder to pass. That
  retired a third of its evidence and shrank the solver-dependent core from one claim about a
  51,133-vertex object to **twenty claims about 25,567-vertex halves** — a different *kind* of artifact,
  because twenty half-instance refutations are individually within reach of proof logging where one whole-
  object refutation was not. **The question that did the work is cheap and repeatable: *what must someone who
  trusts none of this actually check?*** Its discoverer declined the credit for insight and named the
  question instead, which is the version that reproduces. Ask it while the evidence is still being gathered,
  not at the write-up, or you will pay for evidence nothing rests on.
- **Order a verification's steps by marginal evidential value, never by narrative order.** Same session, twice:
  a verification script was written so its *least* informative step ran first, leaving the checks that decided
  the question queued behind slow ones that could not.

## What compute actually helps

Ask before provisioning; measure before believing.

| Work | Right instrument |
|---|---|
| The reduction, the statements, the certified checks | Lean. Nothing else is close — Mathlib's analysis *and* graph theory |
| Kernel-checking a certificate | Lean's kernel via **GMP-accelerated `Nat`** — the fast trusted evaluator Lean is usually said to lack |
| Refuting a colouring (CDCL SAT) | CPU cores: sequential per solver, parallel across cubes |
| *Finding* a colouring, to reject a candidate fast | Massively parallel local search — the one place a GPU plausibly earns its keep |
| Geometry, edge enumeration, gadget matching | Embarrassingly parallel; CPU suffices |

**A GPU is not a SAT accelerator.** CDCL is pointer-chasing unit propagation, and GPU SAT solvers
have historically lost to good CPU solvers. Do not plan around them until a *measured* bottleneck is
something a GPU is actually good at.

## The shape of the proof

The whole argument is one reduction plus two certified computations:

```
χ(ℝ²) ≥ 5  ⟸  some finite unit-distance graph is not 4-colourable
                 ├── geometry:  every listed edge really has length 1   (exact field arithmetic)
                 └── combinatorics: the graph has no 4-colouring        (verified LRAT checker)
```

Neither computation is trusted on its own say-so. The geometry is exact — coordinates live in the
multiquadratic field ℚ(√3,√5,√7,√11) represented as an iterated quadratic extension over ℤ, so
"distance = 1" is an integer identity, not a float comparison. The combinatorics goes through a verified
LRAT checker the kernel can run: core ships one (`Std.Tactic.BVDecide.LRAT.check` + `check_sound`) that the
kernel cannot evaluate (among other causes, `Std.HashMap` reaches an `@[extern] opaque` word size), so M05
built a kernel-reducible one. CaDiCaL is an untrusted oracle that merely proposes the certificate.

**Nothing in `tools/` is trusted.** The generator may be wrong; Lean re-derives every claim from
the emitted data. A generator bug can only produce data Lean refuses to certify.

## Trust ledger

Audited at every milestone with `#print axioms` (`scripts/Axioms.lean`, run by `scripts/axioms.sh`); the
current audit reads 846 clean and 5 declared purchases, each listed in `ARCHITECTURE.md` § Trust. Rung B
holds none.

| Entry | Status |
|---|---|
| `propext`, `Classical.choice`, `Quot.sound` | accepted silently |
| `sorryAx` | the gate fails on it |
| `<decl>._native.native_decide.ax_N_M` | **explicit purchase, per use, recorded here** |

`native_decide` trusts the compiler and this CPU rather than the kernel. Where a `Bool` cannot be
kernel-reduced we may buy it — but the purchase is named in the docstring of the declaration that makes
it, and listed in `ARCHITECTURE.md` § Trust. Soundness theorems are identical either way; only the axiom
list moves.

**Grep for the right name.** At v4.32.0 `native_decide` mints a *per-declaration* axiom;
`Lean.ofReduceBool` never appears in `#print axioms`. An audit looking only for that name passes a
native purchase in silence.

**`lean4checker` is a publication gate, not a milestone gate** (Kooshi, 2026-08-02). The Lean kernel at
build time is the trust anchor; the independent replay is single-threaded and RAM-heavy and re-verifies what
the kernel already checked, so run it once, on hardware other than the desktop, before any external claim of
new mathematics — never as routine. It cannot re-check a native purchase (a purchase is recorded as an
axiom, and every kernel accepts axioms), so "replayed through an independent kernel" covers the
kernel-checked part only.

## Toolchain

Managed by **elan** and pinned by `lean-toolchain` (`leanprover/lean4:v4.32.0`); the toolchain and the
Mathlib pin move as one unit. If `lean` / `lake` are missing, run `./install-toolchain.sh`.

**Arch build env — required before building.** The toolchain's bundled `clang` is broken against Arch's
system LLVM, so any native/C compile fails unless you use the system clang plus the toolchain's bundled
`libc++`. `source scripts/dev-env.sh` in your shell (it sets `LEAN_CC`, `LIBRARY_PATH` and
`LEAN_ABORT_ON_PANIC`; the installer wires it into `~/.profile`, and Claude's own shell gets it via
`.claude/settings.local.json`).

**The SAT solver.** The toolchain ships **`cadical`** at `$(lean --print-prefix)/bin/cadical`; nothing
external needs installing. It is single-threaded: use `tools/portfolio.sh` (a configuration race) and
colour-cube splits (one run per cube) to use the cores.

**Python is 3.14, and its multiprocessing default changed.** On Linux the default start method is now
`forkserver`, not `fork` (measured here: 3.14.6, `get_start_method()` → `forkserver`). A worker therefore
**re-imports the module** instead of inheriting the parent's memory, so state a parent leaves in a
module-level global is **empty in the worker**, and the symptom is a `KeyError` on a key the parent plainly
holds — which points at the dictionary, nowhere near the process model. Pass
`mp_context=multiprocessing.get_context("fork")` (safe with no threads, and it avoids pickling a large
shared object once per worker), or give the pool an `initializer` that rebuilds the state from picklable
arguments, which also survives a platform without `fork`.

**Two machines.** A desktop and a laptop (12 cores, 31 GB). The desktop has **16
PHYSICAL cores, 32 threads** (2 per core), 64 MiB L3 in two instances, 128 GB RAM — `nproc` says **32** and
that is the *thread* count. **Corrected 2026-09-12**, where this file had said "32 cores": an agent sizing a
job from it reasoned that 32 concurrent solvers on 16 cores must be contending, killed a running job and
relaunched at half width. Restoring 32-way was right — observed
throughput **12.6 cubes/min** against the ~8/min sixteen workers give — but **the two figures first reported
here (32-way 120.6 s against 16-way 122.8 s, "statistically identical") are STRUCK**: they compared a mixed
cube population against a pure one. Restricted to one difficulty class, the same data reads 32-way **105.1 s**
(n=43), 16-way **126.6 s** (n=32), 32-way again **129.2 s** (n=117) — **two runs at the SAME width differing
by as much as the width effect being claimed.** So the honest statement is that **the width effect is not
distinguishable from run-to-run variation in this data**, and only "no *large* contention penalty" survives.

**The mechanism this produced is worth more than either number, because it is the answer to why writing a
rule down does not install it.** The agent had just been credited with instancing *"a number carries what it
measures"* and then broke it again **at the first opportunity, inside the act of correcting the first
break** — comparing "the numbers from before" against "the numbers from after" without checking that the two
cube ranges had the same difficulty mix. What caught it was **not vigilance about populations**: it was **the
cost model failing an arithmetic check** — 32 workers at ~125 s should yield 15 cubes/min, far more than it
was seeing, which forced the look. **So the reproducible instrument is to keep a PREDICTED throughput beside
the measured one and reconcile them whenever they disagree.** A prediction that can be divided back out of a
rate is a population check that runs itself; a caution about populations is a caution. Third lesson, with its
scope: **say physical cores when sizing memory-hungry work**, and **derive a rate from your own numbers and
check it against the observed one before believing either.** `nproc` disagreeing with a
number in a plan is the hardware moving, not an error — **ask which machine before treating a core or memory
count as fact**, and ask to swap to the desktop when a step wants it (the SAT solving does). Timings compare
only within one machine: per-operation ratios carry across, wall-clock totals and safe job counts do not.
Measure in **CPU seconds (user + sys), minimum of three runs**, and name the machine beside any number.

### Building

**ALWAYS build through `./scripts/build.sh` — never `lake build`, bare *or named*. No exceptions.** Lake
5.0.0 has no `-j` and sizes its job pool from the machine; data modules here peak at ~9 GB each and
certificate segments at 3.4 GB + 0.81 GB per chunk, so an unrestricted build asks for hundreds of gigabytes
and took the desktop down twice on 2026-07-30. A *named* target is not safe either: Lake silently queues every missing or
stale dependency into the same unrestricted pool — on 2026-08-02 a one-module build queued four 22 GB certificate rebuilds behind a 20 GB cap, the OOM killer ate them twice, and a grep-piped invocation read as a pass (the rule was hardened from "never a *bare* lake build" that day; the loophole cost hours). `scripts/build.sh` builds every module in dependency order
(`scripts/build_order.py`), leaves first, in explicitly named batches (`BATCH`, default 10), each under a
`systemd-run` memory cap (`MEMMAX`, default 100G); `scripts/build.sh --plan` prints the batches and builds
nothing. It first asks Lake once, under the same cap, whether any of those modules is out of date
(`lake build --no-build`, which compiles nothing): about 2 seconds, against about 3 minutes to walk the
batches. Only exit 0 skips the walk; any other status walks it, so the check can cost time but never skip a
build.

**`lake env lean <file>` is fine for iteration — it builds nothing — and it is not the same check.** It does
not apply the lakefile's options, so `autoImplicit := false` is not in force: a stray identifier is
silently auto-bound and the file elaborates clean, then fails the real build. Never conclude from it that a
module is green.

**The batch is the plan; the cap is a backstop.** Lean `mmap`s its `.olean` files, so at the limit the
kernel reclaims their page cache and must read it back — with `MemorySwapMax=0` that is an I/O thrash, not
a clean kill. Before raising `BATCH`, measure a module's peak and choose the width from
`available_memory / peak`; sum the RSS of the running `lean` processes with:

```bash
ps -C lean -o rss= --no-headers | awk '{s+=$1} END {print s/1048576 " GB"}'
```

**On any unexplained process crash, from any process: HALT and report to Kooshi immediately.** Do not
diagnose, retry, or work past it — the 2026-08-02 filesystem event (kernel ext4 oopses, ~50 compiled modules lost) is what working past one looks like.
**One heavy job at a time**: the box has no headroom for a replay, a hunt and a build together.

**Every long-running phase checkpoints and resumes exactly** (Kooshi, 2026-08-26). A run expected to exceed
~15 minutes persists its progress at natural acceptance points (a verdict, a wave, an accepted deletion) and
resumes from that state after a kill; a long phase whose state lives only in a process's memory is a bug — the incident that minted the rule: M51's iteration-3 halo shrink ran 19 hours with its state only in the parent, one worker died, the pool's `map` hung forever, and the whole shrink was lost (M51 §R-INC5).
The subplan answers, in writing: *if this process dies at any instant, what does the relaunch redo?*
**And the checkpoint must not live where another agent is told to clean.** `build/` is described in this
file as regenerable scratch, and an agent tidying up after itself deleted a tree under it on 2026-09-11
while a live job's only resume file sat in a sibling directory (`build/m63d2/ckpt-hismove/`). Recoverable
state one cleanup away from unrecoverable is not recoverable. Put checkpoints outside the scratch tree, and
name the **resume command** in the subplan beside the checkpoint's path — a checkpoint nobody knows how to
resume from is a file, not a recovery.

**A run that blocks something is presumed killable** (Kooshi, 2026-09-12). When a live job stands in the way
of anything — an edit to a module it imports, a core another task needs, a fix it would invalidate — weigh
**the value of the run against the value of what it blocks, and the default is to kill the run.** The burden
of proof is on keeping it, never on stopping it. Because every long run checkpoints (above), **the cost of
being wrong is the time to redo, never the result** — so weigh the cost of being wrong, not the hours
already spent. Three shapes met in one night, each of which looked like a reason to wait and was not:
- **The run is blocking its own replacement.** Two reductions spent hours on an operation a new engine did
  186× faster, and `tools/` could not be edited while they held it open — so "wait for them to finish" made
  the slow path self-perpetuating. Look for that circularity by name: *is the thing I am waiting on the
  thing preventing the fix?*
- **The run is producing records under code you are about to fix.** Finishing banks results from the broken
  version and forces the redo anyway — and those records are the ones a later reader trusts.
- **The fix makes the redo cheaper than the run being protected.** Then waiting costs twice.

Two obligations when you do it. **Capture the run's state into the record before signalling** — a verdict
written only at `finish()` is lost, and the log is not the record. And **name what the kill forfeits, out
loud**: one such kill cost a registered out-of-sample prediction, and a forfeited instrument must not
disappear quietly merely because the decision was otherwise right.

**Never edit a shell script while it is running.** Bash reads a script lazily, by byte offset, so a live
process resumes mid-token — it killed a 46-minute `lean4checker` run at M07 with `line 110: ull-library: command not found`, a message that looks like corruption and is nothing of the kind. Launch long runs from a snapshot copy (`cp scripts/x.sh build/x-snapshot.sh`;
`build/` is gitignored).

**Generated modules and invalidation.** For work split across independent modules the wall clock depends
only on the job count, not the piece size, so smaller pieces are free concurrency. Lake takes a module's own
trace from its source and its dependents' traces from the resulting `.olean` (measured at M11 — it is not what the rule used to say, and ignoring the corollary cost 28 hours of processor time at M07; doc comments are queryable data and therefore part of the artifact, `--` comments are not):

| edit to an upstream module | that module | its dependents |
|---|---|---|
| a `-- line comment`, anywhere, including inside a proof | re-elaborates | **not rebuilt** — the `.olean` is byte-identical |
| a `/-- docstring -/` or a `/-! module doc -/` | re-elaborates | **rebuilt** — doc strings are environment data |
| a declaration, or any change to one | re-elaborates | rebuilt |

So: prose in a module a certificate imports is written as `--` comments or not at all; diagnostics live
downstream in `Sat/Diagnose.lean`; `Sat/Mask.lean`, `Sat/ClauseTable.lean` and `Sat/MaskCheck.lean` are
settled, and changing a declaration or docstring there is a decision about hours; deleting a generated `.c`
under `.lake/build/ir/` invalidates its module exactly as deleting the `.olean` would. Settle every
hand-written module before starting a long generated build.

### The kernel's cost model

- **`decide +kernel`, not `decide`, for anything large.** Plain `decide` reduces the `Decidable` instance
  twice — in the elaborator and in the kernel — so it is ~2× slower and dies on `maxHeartbeats` first;
  `+kernel` needs no knob and buys the same axioms.
- **Reduction-step count is the only thing that costs** (measured: ~33 µs per iteration of a trivial
  recursive function). GMP-backed `Nat` arithmetic *and bitwise* operations are free at thousands of bits;
  `USize` is stuck (its width is an `@[extern] opaque`); `Nat.ldiff` is not accelerated; `Nat.fold` is
  superlinear. Which operations are hardware-backed is invisible in the source — measure before believing.
- **Data the kernel must *build* costs O(its whole size) per access; a *literal* does not.** A structure
  grown by N applications costs O(N) to reach weak head normal form (a lookup in a table grown by `insert`
  went from 2.14 ms at 2,381 entries to 16.7 ms at 33,089). Emit big tables as literals (M04's `PtTable`
  pattern), never accumulate one during a kernel evaluation, and never build an index list with
  `List.range` + `List.map` (~0.83 ms per element). A `Nat` literal costs ~2.3 KB of olean against ~145
  bytes per plain literal node, so pack many values into few big `Nat`s.

### Searching

- **The regex engine.** `grep -E` on this machine is `ugrep`, and it silently under-matches alternation
  inside a repeated group: `^\s*(private |protected )*theorem` does not match `private theorem foo` (it
  undercounted this library's declarations by 10.6%). `rg` and `grep -P` match correctly.
- **The file selection.** `rg` respects `.gitignore`, which hides `.lake/` and `build/`. Use `rg` for
  searching source; use `rg -uu` or `grep -rP` for any completeness question (does this artifact exist, is
  this string anywhere); never believe a count from a bare `grep -E` alternation inside a star.
- **A failed `exact?` is not an absence.** It proves the shape you asked for was not found; vary the
  statement (`= true` versus `decide (…)`, an iff versus an implication) first. **And Mathlib is not the
  whole library:** `grep -rn "<name-fragment>" $(lean --print-prefix)/src/lean/` searches core. Grep the
  source before writing a proof, and before writing that something is missing.

## The package

The **`proofs`** package (`lakefile.toml`): library **`Proofs`** (`Proofs.lean` is the flat import
surface, modules under `Proofs/`), with `autoImplicit`/`relaxedAutoImplicit` off. **Mathlib** is
pinned to tag `v4.32.0`. `scripts/Axioms.lean` is the trust receipt.

When adding a library/executable, changing dependencies, or bumping Mathlib, work through the
**`debruijn-init`** skill — freshly invoked, per WORKFLOW's fresh-invocation rule. `lake update` /
Mathlib bumps go alone in a labeled commit (they move the ground under every proof).

## The gate

Elaboration is the floor of the test suite: the build green, zero `sorry`, `#print axioms` clean on the
public surface, linters silent, spec examples passing. On top of that, this project's statement-level gate,
because a formalization that proves the *wrong* theorem is the characteristic failure here:

- **`./scripts/vacuity.sh` and `./scripts/vacuity.sh --self-test` are green** — no theorem is a `∀` over an
  empty domain. Vacuity is undecidable, so the check **requires evidence**, as `axioms.sh` requires every
  purchase to be declared. **The law:** a statement is vacuous exactly when some `∀`-binder has an empty
  domain; `(C : G.Coloring α)` is the dangerous binder, a `Forces` binder is a possible *overclaim* instead
  (FS-29), and a declaration concluding `False` is a refutation and is skipped. **Verdicts:** `WITNESSED`
  (inhabitant proved); `DECLARED` (deliberate emptiness, named with its reason in the docstring as
  `VACUITY DECLARED:` and printed every run); `VACUOUS` (undeclared emptiness) and `STALE` (claimed emptiness
  not proved), which fail unconditionally before the baseline; `GENERIC` (parametric — the caller's
  obligation); `UNKNOWN` (counted, never silent, and the only thing the baseline may hold). **Counts** — a
  silent change in them is this gate's own failure mode (declarations are the library's; the audit's own are not counted): `declarations=6261 refutations-skipped=242
  sites=220`, `vacuous=0 stale=0 declared=3 witnessed=12 generic=203 unknown=2`. The baseline's two entries,
  `hexShell_plane5` and `hexShell_plane6`, cannot be discharged: their inhabitant *is* Hadwiger–Nelson.
  `--self-test` plants seven controls and watches each fire; the load-bearing one — the same carrier family
  at an instantiation nothing refutes — must read `UNKNOWN`, never `VACUOUS`.
- **Every gate keeps what it computed — read it before re-running one.** `build.sh`, `axioms.sh`,
  `vacuity.sh` and `lean4checker.sh` save their tool's complete output under `build/gate/<gate>/` (`latest`
  is the last complete run; `scripts/gate-log.sh`) and print a digest: every count, whether the counts
  recorded in this file still match, every flagged or declared row in full, and every row that changed
  since the previous run (`scripts/gate_report.py`). The vacuity log holds every site with the evidence
  that decided it. `regen-check.sh` keeps each step's log in its scratch directory.
- **Every theorem whose hypothesis is a structure** (a colouring, an embedding, a certificate, a
  homomorphism) **ships a named inhabitant** in the same file, or a one-line note naming the theorem that
  supplies one.
- Every definition has a `#eval`/`example` that would fail if it drifted.
- The Moser spindle's non-3-colourability is proved **twice** — by `decide` and through the SAT bridge —
  so the CNF encoding is checked against an independent oracle.
- The final statement is read against Mathlib's `SimpleGraph.chromaticNumber` and the informal claim, out
  loud, before it is believed.

The InfoView is continuous testimony at zero cost — save and read the goal state after every step rather
than debugging by guess.

### Make the gate fail, and watch it fail

**Run every check's negative control at every milestone.** Break the thing it guards on purpose, confirm it
goes red and names the culprit, then put it back. A check is not known to work until it has been seen to
fail.

Every check that has failed here failed the same way: **it reported nothing when it could not run** — a
comparison of two purchase ledgers that was never actually performed; an audit that aborted under `set -e`
with no output and read as a pass through a pipe; a mutation rig that re-read a stale file and scored it as
a pass; negative controls the instrument could not see. A trust receipt that fails open is worse than none,
because it is believed. So make a check's failure path louder than its success path, never let a shell
pipeline swallow an exit status the gate depends on, and give every discriminating claim a partner that goes
red — a certificate filed against the wrong problem, a vertex moved off the unit circle, a satisfiable
formula handed to the checker.

**The unifying rule, from nine instruments that broke inside one phase** (M63 phase C, 2026-09-11; eight
failed by silence, one by false alarm): **every check needs a positive signal for the thing that did not
happen.** The nine were a wall that could not fire, an exception swallowed in a timer thread, a control that
asked the same question twice and so could never bite, a pid file that caught a wrapper twice, a silent
forty-minute search, a control announcing a refutation from an index mismatch, a trust receipt returning a
benign verdict while checking nothing, a `grep` that killed its own shell, and a four-hour deadline armed as
an exit-waiter. Each was quiet exactly when it had something to report, because each was built to react to
an event instead of to assert an absence — and **an exit-waiter can tell you a thing has ended, never that
it is late.**

**A waiter whose success condition is a file that a GOOD outcome prevents from existing** (2026-09-12). A
sweep dumped its residual-candidate file only when the survivor list was non-empty; the count reached zero, so
the file never appeared and every waiter on it read exactly like a hung run. Its sibling monitor had the same
defect wearing the other costume — a `pgrep -f` liveness check that **matched its own command line**, so the
process-gone branch could never fire. Neither cost anything; **neither could have told anyone the run had
died.** So: **arm a waiter on a file the SUCCESS path always writes**, even if that file says "nothing found".

**And the rule the one above does not reach: state the uninformative outcome and confirm it is REACHABLE,
before believing a control's pass or proposing a discriminator.** "Break it and watch it go red" assumes the
break can fire. Twice in one evening it could not (M63 phase E, 2026-09-11), and the two cases were the same
error with opposite signs: **a planted fault that could never fire** (a target loosened in the direction the
search ignores, so nothing was broken and its survival taught nothing), and **a discriminator that could
never discriminate** (two candidate attributions it could not separate). Both passed review; both were found
only by opening the module. **A control whose failure mode is unreachable has not been tested by passing** —
it is indistinguishable from one that works, which is this file's oldest failure mode wearing its best
disguise. The paired form, measured the same evening: seven errors between two readers, four the engineer's
and three the advisor's, **every one found by reading code rather than by arguing** — because each asked the
right question rigorously of the other's instrument and never of their own.

**Pre-decide how you will respond to your own gate failing — before it fails, on someone else's number.**
Measured 2026-09-11: an engineer's pre-registered comparator went red on its own integration, and the honest
diagnosis was also exactly the diagnosis a motivated person would reach for whether or not it were true. It
did not widen the comparator. Asked why, it declined the credit and gave the mechanism: it had already
written the argument against itself one commit earlier, when a *different* planted fault failed to fire and
it had to decide whether to rewrite a check until it agreed. Having once reasoned that **a check you tune
until it agrees with you has stopped being a check**, the second case was already settled. So this is
sequencing rather than virtue, and it is cheap: settle the policy while the number under dispute is not
yours.

**And when you replace a broad instrument with a sharp one, you lose coverage you were not measuring.** The
same evening, a whole-run wall-clock test was traded for a six-point component measurement that established
a cost law's *shape* by construction instead of by curve-fitting — strictly better on the thing it measures,
and blind to any cost living outside the component. A second cost of the same shape, hiding in a progress
log, was invisible to the sharp instrument and would have been caught by the weak one. **State what the old
instrument saw that the new one does not, at the moment you swap them**, or the gap is discovered by luck.

**And when you put a measured number into a decision, carry what it MEASURES, never just its value.** Three
rulings in one night rested on a number that was measuring something adjacent: a per-*ask solve* rate used as
a per-*candidate* cost (wrong by 30×); a **contended-wall** timing used as a quiet-CPU cost (1.59×); and a
**mid-window** ratio used as a completed-window one (16× against 7×). None was a wrong measurement — each was
a right measurement of a different quantity, which is why none of them looked wrong. **A number in a ruling
travels with its units, its conditions and its population, or the ruling is about something else.** The
repair when it happens: re-derive the decision from the corrected figure out loud, because a ruling that
survives its bad evidence needs new grounds, not a quiet pass.

**And the sharp, checkable form of that rule, extracted 2026-09-12 after the same error's FOURTH instance in
one milestone: when two numbers are compared, exactly ONE thing may differ between them.** The two instances
that produced it are worth keeping because they are one error wearing two faces. A brief claimed its new
rotation gave *"twice the record's circle count and twice its unit-neighbour count"* — but the doubling came
from dropping a coordinate restriction, not from the rotation, and the unit shell **does not depend on the
rotation at all**. A product owner scored an off-diagonal **raw count** against `24/54`, which is a share of
the **monochromatic** cross edges under a particular colouring — a different denominator. **Both differed in
two things and credited one, and in both cases the other thing was the change being advocated, so the error
flattered the work.** The check costs seconds and ends the unit-shell case immediately: **write both numbers
as fractions with the denominators spelled out in words.** Not one of the four instances was a wrong
measurement — each was a right measurement of a different quantity, which is exactly why none of them looked
wrong to the person who made it.

**The same rule has a second half, and its author broke it within two hours of writing it down.** Having
recorded *"state the uninformative outcome and confirm it is reachable"*, the product owner registered a
prediction (`P-Y1`, 2026-09-12) whose **informative** outcome was unreachable: a ratio band of 30–70% on a
quantity that a change to one phase could not move, because ~90% of it is produced in the *other* phase, on
byte-identical code. A ratio near 1 was forced by construction. **So: confirm that BOTH outcomes are
reachable — the one that would teach you nothing and the one you are predicting.** A prediction whose target
region the apparatus cannot enter is not a prediction, it is a formality that will read as a finding when it
fails. And the honest test for whether "the prediction was mis-specified" is a diagnosis or an escape:
**the evidence for the mis-specification must predate the result** — here the 90% split was in the run's own
recorded numbers before the prediction was written, so it is checkable rather than convenient. Writing a
rule down does not install it. **And the rule is symmetric: a control going RED is not evidence
either, until you can name what a wrong-reason red would have looked like.** Three plants in one night fired
for the wrong reason — one on an out-of-range index that died *before* reaching the guard it was written to
test, inside a control built to catch exactly that class. The repair that works is a **pair**: the stub that
must fail beside a faithful stub that must **pass**, so a reader can tell the refusal came from the cause and
not from the scaffolding. Where the uninformative outcome cannot be named, **a red control is not yet
evidence** — it is an unexplained failure that happens to agree with you.

**A measured half and a derived half fail in OPPOSITE directions, and one rule cannot cover both.** Where a
graph's edges are *measured* — a float proposes candidate pairs, exact arithmetic decides each — the only
possible error is a **missed** edge, which makes colouring easier, so **a refusal is robust and a colourable
verdict is suspect**. Where edges are *derived from a law*, the error is an **invented** edge, which makes
the graph denser, makes a refusal arrive faster and cheaper, and **looks exactly like success** — so there
**a refusal is the suspect verdict.** M63 phase G, 2026-09-12: the product owner ruled "believe a refusal
immediately" from the measured half and applied it to an arena whose novelty lives entirely in the derived
half, where the law at a new parameter was tied to nothing. **Before trusting either verdict, ask which half
of the object produced it**, and note the corollary a plan there got backwards: *being built by the law is
the reason the law needs checking, not the reason it does not.*

**A check must read the value the code SHIPS, never a copy of it.** A control certifying the safety margin of
a float gate asserted against a hardcoded `1e-7` rather than the gate's own default, so it would have kept
certifying that margin after someone made the real default lossy — **a check reporting about code that is not
the code that runs.** It now reads the default out of the signature, and every derived quantity with it.

**And the failure path's FORMATTING is part of the check.** The same control's message rendered a failing
ratio of 0.60 as `1×` — a display rounding turning a red into something that reads like a pass. **A check's
output is the check**, and the last transformation before a human sees it is inside the trust boundary.

**Bound a plant's effect on BOTH sides, and the control reports for free when it has gone blind.** A
control that can say *"I can no longer tell"* beats one that can only say pass or fail, because that third
state is where this file's oldest failure mode hides — but **"give controls a third state" is the outcome,
not the mechanism, and the mechanism is what reproduces.** Assert the two-sided form:

```
0 < (guarded_result − planted_result) < threshold
```

The **lower** bound fails when the plant has stopped firing at all; the **upper** bound fails when it fires
too much. Measured 2026-09-12: under a mutation that made the shipped value identical to the planted one, the
difference collapsed to zero and the lower bound caught it — where the natural one-sided form
(`planted < guarded`) would have gone silent about having lost its power to discriminate. **A plant asserted
only as "the fault is detected" cannot report that it is no longer capable of detecting anything.**

**To compare POLICIES, replay them over a recorded decision sequence rather than re-running** (2026-09-12).
A batch-size lever estimated at ~2.9× measured **2.31×** when every policy was replayed over one pilot's own
accept/reject log — one run, one population, exactly one thing differing — **with the control that the replay
reproduces the original run's exact cost.** Re-running instead would have compared two populations and one
policy at once, which is this file's most-repeated error. It also showed the *adaptive* policy slightly
**worse** than the best fixed one until the accept rate falls, which a second run would likely have hidden in
noise.

**A cost measured on a FAILING run understates a succeeding one — and the tell is that the cheap steps are
the failures** (2026-09-12). A reduction walk was costed at **24% expensive probes**; measured on a walk that
was actually progressing it is **~75%**. The 24% came from a walk that had already fallen into the cheap
satisfiable regime, where each step is answered in a millisecond because the object has stopped refusing.

> **A successful walk is the expensive walk.**

It inverts the natural intuition — that a run going well is a run going fast — and it is exactly how a pilot's
cost model understates the real thing by 3×. **Before costing an iterative process from a sample, check which
regime the sample's CHEAP steps were in**, because the cheap ones are the population that will not be there
when it works.

**A caveat you write and then step over is WORSE than one you never wrote** (2026-09-12). An advisor wrote
*"this exhausts the additive twist family, not the twist family"* and then, in the same report, *"the 72
off-diagonal edges are measurably load-bearing"* — the second sentence silently dropping the qualifier the
first had just installed. The product owner amplified the headline twice, and it kept a dead object alive an
extra day. **The caveat is what made the headline look audited.** So: after writing a scope qualifier, re-read
the summary sentence against it, because the qualifier's presence is exactly what stops a reader applying one.

**And the cheapest generator-image check there is: count your generator's free parameters against the
problem's.** The same search ran over `{(C, π∘C)}` — **one** free parameter — where the solution space was
`{(f, g)}`, which has **two**; the image was a measure-zero slice (24 × 24 against 144²) and the answer lived
outside it. **Third instance in one milestone of a decisive zero from a generator that could not represent
its target, every one with its positive control passing.** A parameter count is seconds and catches the whole
class.

**A TRUE explanation that fully accounts for the observation will stop you looking for a second one — and
the second one may be the one about your own apparatus** (2026-09-12). An engineer proved a two-case theorem
whose load-bearing hypothesis it had just finished arguing for — `√(4n−1) ∉ K`, without which the arena lies
in `K²` and Theorem B four-colours it — then tested the theorem out of sample at `n = 3`, where `4n−1 = 11`
and `√11 ∈ K` **by definition of the field**. The prediction was void, not met, and the two independent laws
"agreed 300 of 300" precisely because **both were inapplicable**.

**Its first account of the miss was that it had mis-filed the fact. That account was wrong, and wrong in the
direction that flattered it** — a confession can flatter, because *"I filed it under the wrong heading"* is
tidier and more forgivable than what actually happened. `n = 3` fails **two** gates: the 2-adic wall, **and**
`sin θ ∉ K`. It had noticed the first, attributed the consequence to it, and **been correct** — *"this member
can never reach five colours"* is true. **That is the trap: a true and sufficient-sounding reason fully
answered "is anything wrong with `n = 3`?", which made the member look SAFE to compute on** — a member dead
as an object costs nothing to test with — so it never asked whether a *second* gate also failed. The first
failure was about the member; the second was about its own instrument.

**The habit, and it is cheap: a candidate that fails one gate must be checked against ALL of them before
being used as a test case, precisely because the first failure makes it feel already understood.** And
re-read every hypothesis against the test instance immediately before believing an out-of-sample result,
which is exactly when the result is most wanted and least examined.

**And a mutation harness must verify its own RESTORE** (2026-09-12). One broke *itself* through CPython's
bytecode cache: the cache's identity for a source file is `(size, mtime in whole seconds)`, so a **same-size
mutation written inside one second** left the interpreter executing **mutated bytecode against a restored
source** — every plant "passing" while the arithmetic under test was wrong. **This is the archetype above
wearing a costume**: a check that loads two versions of something and identifies them by name, where the
name is `(size, mtime)` and the registry is the interpreter. What caught it was the harness **re-running its
controls after the restore and asserting the guarded state comes back**; nothing about reading the harness
would have shown it. So: restore, then re-verify, and treat a same-size edit inside one second as the case
your caching cannot see.

**And mutate the CONSTANT, not only the logic.** Mutating a function's *default value* rather than its *body*
is what exposed a control asserting against a hardcoded copy of that value; nothing about reading the control
would have shown it. The cheap half of the lesson, and the one that finds checks pointed at the wrong code.

**Archiving a checker can break it in exactly the way it was built to detect.** A committed equivalence
harness reconstructs its "before" tree from git and imports a module by name — so the reconstructed module
binds to **today's** copy of its dependency if that reaches `sys.modules` first, and the comparison silently
becomes one tree against itself **while printing ALL MATCH**. Assert the provenance of every module a
reconstruction loads, and **provoke that assertion** to confirm it fires — pre-load the wrong version
deliberately and confirm the harness **refuses** rather than agrees. **The sharp form is not "moved to a new
context" in the abstract; it is: a check that loads two versions of something and identifies them BY NAME.**
Module caches, class registries, singletons, environment lookups — anything with a global namespace.

**And do not cite that catch as evidence the rule works.** Its finder declined exactly that: it had been
forced to reason about module identity hours earlier, on a task that happened to load two copies in one
process, and archiving carried the reasoning along for free — *"I got it because the original task happened
to have the same shape."* **An instance found by prior context is not evidence that a rule reproduces.**
Someone archiving a script that only ever loaded one tree has no such prior, will not notice, and gets a
harness printing `ALL MATCH` while comparing today against today. That is the argument **for** writing the
rule down rather than against it: **it does not reproduce from care, only from the negative control being
mandatory.**

**Enumerate the PARAMETER first and screen the objects against it second, never the reverse** (2026-09-12,
the third instance in one milestone). A census of rotations was enumerated *over a base*, so a rotation whose
circle is empty over that base never became a candidate and left **no row to audit** — which is why a whole
family of 6-open rotations went unrecorded while the census's headline read "none". **An omission is worse
than a miscount**, because a miscount is a wrong number in a row you can check and an omission is a silent
absence. Sibling defect, same file, same day: an enumerator whose cut is **one-sided on a dense set** has no
well-defined answer at all, so its `span` parameter *is* the answer rather than a truncation of it — and the
tell is that the totals never converge while the quantity of interest does. **When a generator takes a
parameter, report the quantity at two values of it before believing either.**

**A positive control proves an instrument finds things OF THE SHAPE ITS GENERATOR CAN REPRESENT, and says
nothing about shapes it excludes.** A sweep of 781,284 candidates returned a decisive zero for a new
parameter and nine hits for the known one — **with its positive control passing**, which is exactly what made
it dangerous: the known witness *was* expressible in the generator's restricted shape and the new one was
not, so the search could not represent the object it was searching for. **Before believing any zero over a
family, write down the generator's image and check the target is inside it.** Third instance of this shape in
one milestone — and note that a working positive control does not distinguish a false zero from a real one.

**Do not mistake a one-sided filter for an inverted monotonicity** — a correction to this entry, made by an
advisor against the product owner who wrote it. It is *true* that once a base contains the witness, growing
it cannot recover the four-colouring: more material only adds to the set of colour differences and the
certificate needs a value outside it. It is **false** that this inverts the usual direction. Adding material
makes a graph harder to colour; adding material makes a *sufficient condition for colourability* harder to
fire. **Those are the same statement about the same quantity, seen once directly and once through a
one-sided filter.** The cost of the wrong framing is specific and was measured: **an agent told to expect an
inversion spends its attention hunting one, and misses what is genuinely unusual here** — that this filter
can be defeated by **breaking its applicability rather than its conclusion**. That matters most exactly when
you are *designing* the object the filter will judge: a constructed base can "survive" by making the check
inapplicable, and a `not-applicable` returned on the same footing as a silence is a pass nobody earned.
**Whenever a one-sided filter judges something you are building, enumerate the ways to make it inapplicable
before the ways to make it fail.**

**And the honest account of where these rules come from: they are scars, not foresight.** The engineer whose
control docstring already said *"a control that passes without its failure mode being reachable has not been
tested by passing"* was asked how it knew, and declined the credit — it had written a control that could not
fire earlier the same evening, and noticed only when it tried to plant a fault in it. **The habit that
produces the principle is planting faults routinely, not reasoning about controls carefully.** Reasoning
finds the controls you thought about; planting finds the ones you did not.
