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

*Last updated: 2026-09-11, at the FS-36 close.*

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
   or 3 (complete sweeps) and arity floor 4 or 5; a χ ≥ 6 gadget must be constructed, not found (G31).
5. **An in-field descent cannot end.** Points of ℚ(√3,√11) do intermediate kills and never the last one; the
   endgame needs a wall-breaking adjunction into a 6-open field (G34, G36, G37).
6. **Linear instruments are blind to 5–7.** Additive colourings, the fractional number, Hoffman and ϑ all stop
   below the interval, and the finite planes' chromatic numbers are integrality-carried (G38, G41, G44, G48).
7. **The cell family is closed in both directions** — no six-colouring, no bounded witness family — and its
   ≥ 7 floor is `[SokolovVoronov2025]`'s χ_poly(ℝ²) = 7 (G22, G24, G29).
8. **`[Parts2020a]`'s 509-vertex record is reproduced and partly explained** (M62–M64). His base graph is his
   §5.6 closed form: 1,603 points in 92 orbits under his order-24 group ⟨ζ₆⟩ ⋊ Gal(K/ℚ), in which complex
   conjugation is itself a Galois element (`typem.parts_lattice`); our ρ₁₅ cross-edge law returns his two
   connecting orbits with his edge counts. Extended to radius 2.44 (3,433 points, 179 orbits) the base
   contains Heule-510 exactly (2,504 of 2,504 edges, none extra). The record is specified by his Tables 3–4
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
| 26 | [tools] **De Grey anatomy**: 67 edge-direction classes, all words in the half-spindle group (G8); the 791-point forcer forces exactly six pairs at four colours (G9). | `tools/anatomy.py`, `tools/rigidity.py` | M30 |
| 27 | [tools] **Quadrature law**, derived and then confirmed at 26 exact censuses (G12); the mitotic hexagram is 4-chromatic; the 1581's gen-1 closure (24,065 points) is 5-colourable. | `tools/closure.py` | M31 |
| 28 | **The 2-adic kill engine**: `sqrt5_indep` by a mod-5 descent, `sqrt15_split`, `sqrt_indep₈`, `quadrature_rho15` (G12's ρ₁₅ instance). | `Quadrature.lean` | M32 |
| 29 | [tools] **Stacking law** and the flat verdict on designed one-family stacks (G14). | `tools/closure.py` | M32 |
| 30 | [tools] **Mechanism hunt**: the criticality factorization (χ(G) ≥ k + 1 ⟺ the fan at a vertex whose deletion is k-colourable); the distance-2 pigeonhole with a 122-vertex carrier (G16); a 49-vertex 3-cover core; a nine-vertex √3-pair core in the assembled 1581. | `tools/mechanism.py` | M33 |
| 31 | **Act One in the kernel**: the pigeonhole bridge (`mono_pair_of_not_colorable_append`), the transmuter, `not_colorable_iff_covers`; carriers `core9_pigeonhole` and `core122_pigeonhole` with inhabitants `core9_colorable_three` and `core122_colorable_four` (by Theorem B: `UDCert.colorable_four_of_seamFree` makes any √5- and √7-free certificate 4-colourable). **`core9_plane` and `core122_plane` are vacuous** — there are no four-colourings of the plane (`isEmpty_coloring_plane_four`) — and support nothing. [tools] A composed 4,749-vertex union is 5-chromatic by kernel-covered cubes. | `Pigeonhole.lean`, `SeamCert.lean`, `Instances/Core9.lean`, `Instances/Core122*` | M34 |
| 32 | **Two-sided 6-programme**: `mono_pair_of_clique`; the hex-shell pigeonhole (the closed first shell is a K₇ of the {1, √3, 2}-distance graph, so χ(ℝ²; {1,√3,2}) ≥ 7 — folklore, formalization ours); the brick certificate and χ(ℝ²; {1, √(3/2)}) ≤ 9 (row 61). [tools] No pattern class fires at five colours on any object held. | `Instances/HexShell.lean`, `Brick.lean`, `Instances/Nine.lean` | M35 |
| 33 | **The classical interval at both ends**: the boundary-tight brick certificate (`check_pos`); `chromaticNumber_plane_le_seven` on a 7 × 7 torus of 4/5 × 3/5 cells sheared 2/5, coloured by the norm-7 ideal (−3 + ζ₆); **`chromaticNumber_plane_interval`: 5 ≤ χ(ℝ²) ≤ 7**. The colouring is classical; ours is the certificate. | `Brick.lean`, `Instances/Seven.lean`, `Instances/Interval.lean` | M36 |
| 34 | **Coset chromatic number exactly 7**: every nearest-point coset colouring of the triangular lattice uses ≥ 7 colours (2, 5, 6 are not a² + ab + b²), attained at scale 6/7. **Prior art:** the floor follows from `[SokolovVoronov2025]`; the dual problem d(k) is `[deGreyParts2022]`, whose thresholds match our band boundaries exactly (also `[Ivanov2007]`). Ours: the exact value and the arbitrary-label results. | `Coset.lean` (`coset_chromatic_eq_seven`) | M37 |
| 35 | **Coarse cells, arbitrary labels**: for 1/2 < p < 1 any colouring constant on the cells needs 7 colours (the first shell is a 7-clique of the constraint graph). The floor is subsumed by `[SokolovVoronov2025]`. | `Coset.lean` (`seven_le_card_of_cell_constant`, `cell_chromatic_eq_seven`) | M38 |
| 36 | **Scale is not monotone**: 1/2 < p < 3/5 needs 8 and 3/8 < p < 2/5 needs 7 again; the classical scale is a local optimum (the dual-variable form is `[deGreyParts2022]`, `[Parts2023]`; the eight is ours). | `Coset.lean` (`eight_le_card_of_cell_constant`, `seven_le_card_fine`) | M39 |
| 37 | [tools] **Gap atlas**: one graph per band; χ = 9 on p ∈ (1/2, 0.6547) and 12 on (0.4804, 1/2); every band down to p = 0.2236 needs ≥ 7 while ω falls to 3–5; G\* = (0.4330, 0.4804) has ω = 4, χ = 7; the deep pocket (1/3, 0.3464) has χ ≥ 8; no coset 7-colouring exists below the classical window (G24). | `tools/celllat.py` | M40 |
| 38 | [tools] **Gradient hunt**: all five clique-free cell cores factor as pigeonhole × kill (G26); a non-geometric Klein four-group of automorphisms of the 1581 yields three new 5-chromatic witnesses (G27); no pair compulsion at five colours on twelve composed objects. | `tools/gradient.py` | M41 |
| 39 | **Gap atlas, kernel side**: `exists_unit_pair_corner`; `seven_le_card_shell4` (3/28 < p² < 1/9); `twelve_le_card_of_cell_constant` (3/13 < p² < 1/4); `no_coset_seven_on_gap`; `core23_not_colorable_six` with `core23_colorable_seven`, so the 23-vertex G\* core has χ = 7 at ω = 4; `Coset.seven_le_card_gap`. | `Coset.lean` §GapBands, `Instances/Core23*` | M42 |
| 40 | [tools] **The fine tail**: χ(G(p)) = 7 exactly on both flanks of p = 1/7; nineteen further bands ≥ 7; kernel promotion priced (~800,000 LRAT lines per cube) and declined. The whole family is ≥ 7 at every scale by `[Voronov2023]` Thm 1.1 and `[SokolovVoronov2025]`. | `tools/celllat.py` | M43 |
| 41 | **Limit lemma**: non-k-colourable graphs of bounded size, drawn in one compact region with every edge within ε of 1 for every ε, give χ ≥ k + 1 (`add_one_le_chromaticNumber_unitDistance_of_bounded_family`); at a single ε the hypothesis is free (`collapsed_drawing_satisfies_one_tolerance`). [tools] A certified unit-distance defect meter, and the first explicit points ν(0.2792) ≤ 23 … ν(0.1494) ≤ 160. | `Limit.lean`, `tools/embed.py`, `tools/verify_defect.py` | M44 |
| 42 | **The arity floor**: a compulsion is a partial colouring that does not extend; `arityFloor G k : ℕ∞`; arity 2 is exactly `Separated`/`Forces`; `arityFloor_eq_zero_iff` (0 ⟺ not k-colourable); `arityFloor_le_of_degree` (≤ k whenever some vertex has k distinct neighbours). [tools] The p = 1/7 fine-tail stage carries 7 virtual edges (G28). | `Arity.lean`, `tools/arity.py` | M45 |
| 43 | **De Grey's witness, bracketed**: `arityFloor_le_of_embedding`; the plane's homogeneity given an isometry (`transport_pair_of_isometry`, `Separated.planeIn`, `Forces.planeIn`); **the six-target**: χ(ℝ²) ≥ k + 1 from k-colour virtual edges at √3 AND at 2, neither sufficing alone (`add_one_le_chromaticNumber_plane_of_forced_pairs`). [tools] The 1581's arity floor at five colours is 4 or 5, by complete sweeps (G31). | `Arity.lean`, `Homogeneous.lean`, `Instances/HexShell.lean`, `tools/m48.py` | M48 |
| 44 | **The two-distance dial** (G32): `distanceGraph V D`; **the spindle theorem** `not_colorable_of_forced_equal` (a forced-equal pair at any d ≥ 1/2 refutes k-colourability, and 1/2 is exact); `add_one_le_chromaticNumber_unitDistance_of_one_defect`; `seven_le_chromaticNumber_hexShell_distances`. [tools] Exoo–Ismailescu's {1,2} six-forcer re-derived exactly (certificate priced at ~50M hints and deferred; the `Instances/OneTwo` module two docstrings cite does not exist); Parts's {1,φ} forcer is edge-critical; 29 ≤ μ ≤ 252 on the seed. | `DistanceGraph.lean`, `OneDefect.lean`, `tools/twodist.py`, `tools/killengine.py` | M49 |
| 45 | **Batch descent** (G33): `Glue.eq_gluePoint_of_dist_pair` and `Glue.finite_two_unit_neighbors` (depth-one candidate spaces are finite, in any field). [tools] Batch halos compose by construction (1,008 points, 403 of 446 cheats left); growth re-opens refusers; the seed carries 148 absolute virtual edges at d ∈ {3, 4}; the spare-colour lemma ((k−1)-colourable ⟹ no pair compulsion at k). | `PartnerLattice.lean`, `tools/batchkill.py` | M50 |
| 46 | **Copy unions**: `spindleRot`, `copyUnion`, `chromaticNumber_copyUnion_le`. [tools] Every unit edge of the descended object lies on the Moser lattice ℤ⟨1, ζ₆, ω₃, ζ₆ω₃⟩ and every point in ℚ(√3,√11); a ρ₁₅ copy kills no separating class at five colours; the cull cuts the standing cheats 273 → 149 with no material added. | `Copy.lean`, `tools/cull_enum.py`, `data/m52/` | M52 |
| 47 | [hand + tools] **M53, halted when Theorem B was proved**: the residue colouring is proper on every descent object with every cheat monochromatic; the residue obstruction and μ ≥ 3 inside ℚ(√3,√11) (G36); the wall-break census; 5-chromatic witnesses in ℚ(√3,√11,√247) (1,175 points; field and route prior art, `[ExooIsmailescu2019]`, `[Polymath16wiki]`) and ℚ(√3,√11,√23). | `tools/residue_colouring.py`, `tools/residue_floor.py`, `tools/wall_break_test.py`, `plans/FIELD-WALL-THEOREM.md` | M53 |
| 48 | **Critical-set localization** (G39): a forced-equal pair confines the critical set to N(p) ∩ N(q), a virtual edge to N(p) ∪ N(q); in the plane at most two critical vertices, none beyond distance 2 (`encard_criticalSet_le_two_of_forces`, `criticalSet_eq_empty_of_forces_of_two_lt_dist`), generalized to edge-length sets and metric spaces, where the count ≤ 2 does not survive. [tools] Two 5-chromatic objects with no critical vertex; the smaller (2,229 points) has no pair compulsion at five colours. | `CriticalSet.lean`, `tools/five_dial.py` | M54 |
| 49 | **Absorption** (G40): `Extends`, `extends_of_repaint`, `extends_of_hubs`, `extends_symCopy`. [tools] ν = 2 exactly on the two-spindle objects; a depth-two F₂₄₇ cross thickening frees 238 critical vertices, all on the copy side. | `Absorb.lean`, `tools/absorb_dial.py` | M55 |
| 50 | **The additive yardstick** (G41): `additiveColoring`, `not_forces_of_addMonoidHom`, `addMonoidHom_apply_eq_of_sub_eq_nsmul`; the additive spindle theorem (its chord lies in 4Λ). [tools] Exoo–Ismailescu's G's colouring space is exactly its additive family; no 5-chromatic witness has an additive 4-colouring. **Prior art:** the framework and the 1/k obstruction (no additive k-colouring, k ≤ 10, of a wall-broken plane) are `[Fischer1990]` Thm 10(ii). | `Additive.lean`, `tools/additive.py` | M56 |
| 51 | **Additive rigidity** (G42): `AdditivelyRigid`, `forces_of_additivelyRigid`, `six_le_chromaticNumber_plane_of_additivelyRigid`. [tools] Only Exoo–Ismailescu's G is rigid; every unit-distance object held is Kempe-open by orders of magnitude. | `AdditiveRigid.lean`, `tools/additive_rigid.py` | M57 |
| 52 | [hand + tools] **The finite-plane bound and the first exact wall-broken planes**: a field with a prime of residue field 𝔽_q, q ≡ 3 (mod 4), has χ(F²) ≤ χ(UD(𝔽_q,2)); χ(UD(𝔽₁₁,2)) = 5, so χ(ℚ(√3,√5,√11)²) = χ(ℚ(√3,√11,√247)²) = 5. **Prior art:** the bound is `[Moorhouse2010]` §8.2/§10.3, `[Manturov2012]` Thms 17–19 and `[Madore2015]` Cor. 3.4; the value at 11 is Moorhouse's Table 6.1. | `tools/fplane.py`, `reference/Chat-analysis/` | 2026-09-06 |
| 53 | **The field sieve** (G43, G44): `unitQuadrance R`, `unitQuadrance.map` (the bound as functoriality), `UDCert.drawing_adj`; **`chromaticNumber_finitePlane11`** (= 5, no solver) and **`chromaticNumber_heule510`** (= 5). [derived] Kloosterman eigenvalues make every plane at p ≡ 3 (mod 4) from 59 up refuse five; over ℚ(√3,√11), 6-open ⟺ wall broken ∧ 11 inert. **Prior art:** ω and ω ≠ χ on finite planes (`[Krebs2022]`, `[LorenzZimmermann2023]`, `[SchneiderSilva2013]`); `[Vinh2006]` restates the spectral bound without a factor 2, which our kernel value at 19 contradicts. | `UnitQuadrance.lean`, `Instances/FinitePlane11.lean`, `tools/fplane.py` | M58 |
| 54 | **The lift** (G45): `add_one_le_chromaticNumber_plane_of_lift`; `stressPairing_eq_zero_of_lift` (in any ring with π² = 0 a lift forces every self-stress to pair to zero with the defect); no lift modulo 131², 11² or 19² for the 1581's merged image and the 5-critical cores of UD(𝔽₁₁,2) and UD(𝔽₁₉,2). [tools] The hub scan: 3,739 exact depth-one hubs of the 1581 at 131. | `Lift.lean`, `Instances/LiftObstruction{11,19,131}.lean`, `tools/fplift.py` | M59 |
| 55 | **The residue obstruction** (G47): `Forces.image`, `Separated.image`; `forces_iff_eq_of_aperiodic`; the distance law (`Forces.quad_sub_eq_zero`, `Separated.quad_sub_eq_one`); `finitePlane11_forces_iff`, `finitePlane11_separated_iff`. **Over the √7-free tower with 11 ∤ D, a five-colour forced pair has 11 ∣ d² and a virtual edge d² ≡ 1 (mod 11), so neither a √3 nor a distance-2 gadget exists** (`not_separated_sqrt3_11`, `not_separated_two_11`) — and, by the same law at the rational squared distance 25/9 (`not_forces_of_distSq_ratio`, `not_forces_five_thirds_11`, modelled on Heule-510's 5/3 pairs), Polymath16's 2018 question "is 5/3 always coloured like 0?" has the answer no for every such certificate; the field-level reading, wherever 11 is usable, adds M58's hand reduction, and the √247 variant stays a hand argument (`CLOSED-QUESTIONS.md` §1.4). | `ResidueObstruction.lean`, `Instances/ResidueObstruction11.lean`, `tools/fpcompel.py` | M60 |
| 56 | **Local–global tightness** (G48): `addCayleyMap`; `unitQuadrance_colorable_of_quotient`; `card_le_chromaticNumber_mul_indepNum`; **`Forces.isEmpty_ringHom_of_spindle_radicand`** (with `…_of_not_isSquare_neg_one` and `…_of_colorable` forms); `chromaticNumber_finitePlane19_le_five`. [tools] ϑ = Hoffman at eleven primes; no rotationally symmetric 5-colouring of UD(𝔽₂₃,2). **Prior art:** `addCayleyMap` is `[Moorhouse2010]` §4.2 and the periodic quotient an instance of `[CervantesKrebs2023]`; the mechanism is ours. | `LocalGlobal.lean`, `Instances/LocalGlobal19.lean`, `PlaneRotation.lean` | M61 |
| 57 | **Theorems A and B.** **B:** `chromaticNumber_seamPlane`, χ(ℚ(√3,√11)²) = 4 — residue maps onto 𝔽₄ at the two primes above 2, a parity descent in place of valuation theory, and the Moser spindle as an identity in the order; `not_forces_five_of_subset_seamPlane`. **A:** `colorable_of_residue` — a graph drawn in an abelian group, edge differences in a subgroup A and nonzero under ψ : A →+ G, is \|G\|-colourable, with no metric, field or ring; `normOne_subset_valuationSubring`, `colorable_unitDistance_induce_of_valuationSubring`, `normOneColoring`. **Not proved:** that a number field with a conjugation-fixed prime supplies the valuation subring with residue field of size N(𝔭). **Prior art:** the valuation-subring form is `[Madore2015]` Prop. 3.2 and the unit argument `[Fischer1990]` Thm 1; Theorem A's general form is what Madore's Prop. 3.9 declines to formulate. **B answers** `[Moorhouse2010]` §1, `[CranstonRabern2015]` (so 76/21 ≤ χ_f(K²) ≤ 4) and `[ExooIsmailescu2019]`'s closing question, and settles one field of Benda–Perles Open Problem 11.6 (`[Soifer2024]` ch. 11), and closes `[Madore2015]` Prop. 4.6's 4 ≤ χ ≤ 5. | `FieldWall4.lean`, `ResidueColouring.lean` | 2026-09-08 |
| 58 | **The Moser recipe's sharp threshold**: a host graph with no k-clique draws no minimal forcing gadget at k colours (`not_forces_of_drawing`); four plane points are never pairwise unit-distant, so for k ≥ 4 no k + 1 plane points carry a forced pair (`not_forces_of_unit_drawing`), while at k = 3 the drawn rhombus is the minimal gadget (`exists_forces_of_unit_drawing_three`). It says nothing about non-minimal constructions. | `Mascot.lean`, `plans/MASCOT-DERIVATION.md` | 2026-09-09 |
| 59 | **The 2-adic law of four-colour compulsions over K = ℚ(√3,√11)**: the residue colouring identifies two K-points iff their distance lies in the prime 𝔭 above 2 (`residueColouring_eq_iff_psiA_zero`), so a forced-monochromatic pair needs v_𝔭(d) > 0 and a virtual edge v_𝔭(d) = 0 (`not_forces_of_residue_ne_zero`, `not_separated_of_residue_eq_zero`); each distance in `[Parts2020a]` Table 1 is barred from the other column (two rows' √ unverified against the PDF, same valuation either way). The general form needs only a conjugation-stable ideal kernel (`map_mul_conj_eq_zero_iff`). **Open:** are both conditions also sufficient in some finite K-object? **Prior art:** the coordinate form is `[Ducz2026]`; the observed pattern is `[Heule2019]`, `[PartsOdd2022]`, `[Heule2021]`, `[Ardal2009]`. Ours: the field-level valuation statement, the compulsion consumers, the kernel proof. | `ValuationLaw.lean`, `ResidueColouring.lean` §4 | 2026-09-09 |
| 60 | **Plane freedom**: rotations by circle points are automorphisms of `unitQuadrance R` (`rotHom`, `quarterTurnHom`); over a field where −1 is not a square a vector and its quarter turn span the plane; so **over ZMod p with p ≡ 3 (mod 4), `Forces ↔ x = y` whenever the plane is k-colourable** (`finitePlane_forces_iff`) — without colourability the statement is false (`finitePlane3_not_colorable_two`). Prime fields only; the virtual-edge half is proved only at 11. | `PlaneRotation.lean`, `Instances/PlaneFreedom.lean` | 2026-09-09 |
| 61 | **Statements at their proofs' level**: the six-target is colour-generic (`seven_le_chromaticNumber_plane_of_forced_pairs`: two six-colour gadgets give χ ≥ 7) and distance-set-generic, and over {1, 2} one √3 gadget suffices (`six_le_chromaticNumber_oneTwo_of_forced_sqrt3`); a passing brick certificate colours `distanceGraph ℂ D` (`chromaticNumber_plane_avoiding_sqrt_three_halves_le_nine`); the old names are pinned by compiled type ascriptions. | `Instances/HexShell.lean`, `BrickDistance.lean` | FS-24 |
| 62 | **Overcompression is an orbit-closure gap**: for an upward-closed refusal family and H ≤ Aut(A), the rung-H minimum equals min \|cl_H(M)\| over inclusion-minimal refusers M, so every symmetry rung is a hitting-set problem over H-orbits against the correction-set hypergraph Y, with no colouring ask. [tools] On `[Parts2020a]`'s L stage: 375 vertices / 3,264 minima at the trivial rung; a dead involution gives 376 with containment 0 of 1,302 — his §6 sentence reproduced at 375 and 376; S-side rungs cost 8 vertices where L's cost 1; Y accounts for every exclusion. **Prior art:** the symmetry gap of symmetric integer programming (`[HerrRehnSchurmann2013]`), idealness, semilinear sets, MUS/MCS enumeration (arXiv:2412.13606 — our 336 necessary atoms are its backbone). | `tools/parts_faces.py`, `tools/parts_reduce.py`, `data/m62/m64-*.json` | M64 |
| 63 | **Two colours from inertia, and the 2-adic splitting of multiquadratic fields**: a residue map into a reduced characteristic-2 ring that conjugation does not move two-colours every unit-distance graph over its valuation subring (`colorable_two_unitDistance_induce_of_valuationSubring`); a square-class group holding [2] is the sum of two pieces whose 2-adic images avoid [−1], so every real multiquadratic field lies, once √2 is adjoined, in the compositum of two fields that pass the four-colour test (`fieldOfRadicands_le_sup`) — each holding a Moser spindle when the field contains ℚ(√3,√11); de Grey's field lies in ℚ(√2,√3,√11,√35)·ℚ(√3,√10,√11,√35); ℚ(√3,√11,√14) and ℚ(√3,√11,√70) pass the test and their compositum's plane needs five colours (`five_le_chromaticNumber_planeOver_fourteen_sup_seventy`), so, granted the factors' hand χ ≤ 4, no combining rule for test-passing fields gives four. **Not proved:** χ ≤ 4 for any piece (FS-37). [hand] For real multiquadratic F, χ(F²) = 2 iff no odd square class is ≡ 3 (mod 4). **Credit:** the decomposition is ChatGPT's (OpenAI, with Kooshi, 2026-09-11). **Prior art:** the mechanism is Woodall's, `[Fischer1990]` Thm 8, `[Moorhouse2010]` Thm 7.1, `[Madore2015]` Prop. 3.9; the multiquadratic iff is unchecked against `[AxenovichEtAl2014]` and `[Johnson2006]`. | `TwoColourResidue.lean`, `SquareClass.lean`, `Instances/CompositumFive.lean` | FS-36 |

### Paths forward, ranked

*A mirror of `plans/FRONTIER-STUBS.md`, which is authoritative: every row there is a full stub with its
bearing on χ ≥ 6 stated honestly. Kooshi picks; the default is the top.*

**Open milestones, in order** (Kooshi, 2026-09-10: *"the next session will be 100% repro of his algo. The
session after that will be introducing our new angle on it"*):
1. **M63 — reproduce `[Parts2020a]`'s minimization algorithm end to end** (FS-33,
   `plans/M63-parts-reproduction.md`). The reduction stage is reproduced; **open at phases C–E** — the
   correction-set hypergraph work, the held-out runs, the outer loop, the intermediate symmetry rungs.
2. **M62 — the evolutionary type-M search** (`plans/M62-evolutionary-type-m.md`; paused for M63). Beat the
   509-vertex record with a search whose genome, feasibility filter and fitness come from this project's
   theorems; its arena base is `typem.parts_lattice`, and its phases D and E are not run. It is the rehearsal
   for FS-6, the same search one colour up.

**Ranked stubs:**

| rank | stub | the question | bearing on χ ≥ 6 |
|---|---|---|---|
| 1 | FS-20 the paper — `plans/STUB-theorem-B-writeup.md` | Theorem A as the formulation seven lineages stopped short of, with χ(ℚ(√3,√11)²) = 4 closing Madore's bracket; naming is a deliverable; blocked on FS-27 §2 and on obtaining `[Johnson2006]` and `[Fischer1990b]` | none; ranked on the publication trigger |
| 2 | FS-30 consume the rotation list — `plans/STUB-consume-rotation-list.md` | **The "412 rotation classes" never counted rotations** (M63 phase G): a rotation of this kind joins only points collinear with its centre, so rotations enumerate exactly over the base's lines — one stored entry can hold several (the record's holds two), **91 of 150 stored entries hold none**, the list was computed on the wrong base, and only 150 of the 412 were ever saved. Enumerated exactly on his base: **26 candidates, cut to six angles by the 2-adic filter in microseconds — and those six are TWO rotations** once counted up to the base's own symmetry (reflection, half-turn and the arithmetic flip swapping the two square roots make a rotation's four sign-and-conjugate variants the same arrangement relabelled): **one Parts's own, one a new class in a field no published construction uses.** Count rotations up to that symmetry, never angles. Nothing on either base is 6-open. Rank by radius families, wall-breaking radicand and 6-openness, never by cross-edge count | medium |
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
literature, unchecked here), **[method]** (a working rule). A reading is never silently promoted. Entries are
rewritten in place; when a reading dies the entry states what is known instead. G1–G51 are stable
identifiers cited across `plans/`: never renumber.*

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
* **G8 — The direction group. [measured]** ⟨ζ₁₂, σ, √ρ₁₅ = (√15 + i)/4, √ρ₆₃ = (3√7 + i)/8⟩ closes all 67 of
  the 1581's edge directions at exponent ≤ 6. `[Polymath16wiki]` derived the Moser ring's unit group ⟨ζ₆, η⟩
  with η = (√33 + i√3)/6 = iσ⁻¹ and η² = ρ — the index-2 subgroup {ζ₁₂^a σ^b : a + b even} of ours. **Open,
  an afternoon with `tools/anatomy.py`:** are Heule-510/553's six out-of-group direction classes words in
  α = (√5 + i√11)/4, a wiki generator our set lacks?
* **G9 — Rigidity lives only at the forcing level. [measured]** The 791-point forcer (the 1581's
  centrosymmetric core V ∩ −V) forces exactly six pairs at four colours, five of them antipodal — forced
  central symmetry. The hexagram chunk at four colours and the 1581 at five have no forced pair and no
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
  describes Heule's graphs this way. Open: whether every χ ≥ 5 argument must factor so.
* **G16 — The distance-2 pigeonhole. [kernel carriers + measured]** The seam fabric cannot 4-colour without a
  monochromatic distance-2 pair once it has seam depth ≥ 2 or radial extent past a fabric shell
  (r² = 2 − √33/9 on de Grey's fabric). The reason: 2 lies in the prime above 2, so Theorem B's colouring
  makes every positive-valuation distance monochromatic (row 59). The carrier is 122 vertices; the √3-pair
  sibling concentrates to nine, because √3 is the one distance whose equilateral triangle has unit
  circumradius. Every kill of it needs a wall-breaking root (ρ₁₅ adjoins √15).
* **G17 — Globality lives only at the top rung. [measured]** The fan onset (χ ≥ 5 itself) arrives at the
  last vertex; every sub-rung compulsion measured has a small carrier (3-cover at 49 vertices, the distance-2
  pigeonhole at 122).
* **G18 — Composition sees what search cannot. [measured]** Monolithic CDCL capped on the 4,749-vertex union
  while the cubes a kernel pigeonhole covers refuted in minutes each. Certify components, compose in the
  kernel, and pin palettes (6.5–160× measured).
* **G19 — 5-tight fabric. [measured + theorem]** No pattern class fires at five colours on any object held,
  and inside K none can (Theorem B); 5-tight fabric needs a wall-breaking root in the fabric itself. A
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
  cheapest thing to manufacture by accident.
* **G22 — Where a six-colouring cannot live. [kernel + prior art]** No colouring constant on a triangular
  lattice's cells uses six colours (rows 34–35), and no polygonal colouring does (`[SokolovVoronov2025]`). A
  six-colouring, if one exists, has non-polygonal classes finer than half the unit distance. Coset colourings
  need seven because 2, 5, 6 are not of the form a² + ab + b².
* **G23 — Refining is not a route down. [kernel + measured]** The cell family's requirement is not monotone
  in scale; the classical scale is a local optimum (dual form: `[deGreyParts2022]`).
* **G24 — The gap law. [kernel forcing half + measured]** Below the classical window the cell family needs ≥ 7
  at every scale (`[Voronov2023]`, `[SokolovVoronov2025]`) while ω falls to 3–5 and every certified
  relaxation to about 4 — the plane's own pathology (ω = 3, relaxations low, χ = 7) in finite
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
  classes, which is why a six-class sweep reads zero. Act Two exists there.
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
* **G31 — Existing witnesses hold nothing to extract. [kernel + measured, complete]** De Grey's 1581 at five
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
  mod 11 (7, 13, 79, 127, …).
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
  Only Exoo–Ismailescu's G has γ = 0; K-unit parts are 4-colourable; wall-broken thickening can erase the
  family (W plus 63 F₂₄₇ points), while de Grey's half-spindle closure keeps it. Forcing does not need
  rigidity (the seed's 252-cheat subset forces with > 5,000 colourings).
* **G43 — The residue plane seals fields. [kernel over rings; field level gated as G35; prior art
  `[Moorhouse2010]`]** At a usable prime the residue map is a homomorphism into UD(𝔽_q, 2), so
  χ(F²) ≤ χ(UD(𝔽_q, 2)) — non-linear, 5 at q = 11. Every field the descent used is 5-sealed. For F ⊇ K,
  6-open ⟺ wall broken ∧ 11 inert: de Grey's field, K(√7), K(√13), K(√79), K(√127) are 6-open; K(√35) is
  11-inert but keeps the wall. A composite ideal cannot beat the best prime without refuting Hedetniemi's
  conjecture (Moorhouse §9). The shadow sieve: an object's direction residues seal every graph built from
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
  decoupled and integrality-carried.
* **G49 — The prior-art gate. [method, measured]** Recognition is half the rule; the other half is a search
  at the milestone's opening (WORKFLOW step 3a): in the discipline's words, never ours; under two disciplines;
  for the question as well as the method; outside arXiv. Past misses came from checking at the close,
  searching coined vocabulary, and searching one literature when the object sat in two. The field-plane
  reduction was derived independently at least six times, and the Polymath16 corpus (2018–2026) poses
  Theorem B's question while citing Fischer, Moorhouse and Vinh zero times.
* **G50 — Read what the search found. [method]** A held-but-unread paper, or a bibliography title whose guess
  touches a live milestone, blocks that milestone's opening until scanned. An abstract is not a reading. Walk
  the citation graph of the paper that *posed* the question; cross-check citations in two databases; mine
  every read paper's references into the bibliography the same day; mark reading per section.
* **G51 — A competitor and an advisor beat one mind. [measured, one session]** A friendly competitor on the
  same problem plus an advisor (Poros, `~/source/poros`) advising both caught errors one agent missed, and
  two independent attempts hitting one wall licensed an impossibility theorem (row 58). Design: isolate each
  agent's scratchpad (a shared temp directory is a covert channel), brief both identically, give the advisor
  the record and a written expectation, rule prior art shared. Records: `plans/COXETER-2026-09-08-mascot.md`,
  `plans/POROS-2026-09-08-mascot.md`.

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

**Two machines.** A desktop (32 cores, 128 GB) and a laptop (12 cores, 31 GB). `nproc` disagreeing with a
number in a plan is the hardware moving, not an error — **ask which machine before treating a core or memory
count as fact**, and ask to swap to the desktop when a step wants it (the SAT solving does). Timings compare
only within one machine: per-operation ratios carry across, wall-clock totals and safe job counts do not.
Measure in **CPU seconds (user + sys), minimum of three runs**, and name the machine beside any number.

### Building

**ALWAYS build through `./scripts/build.sh` — never `lake build`, bare *or named*. No exceptions.** Lake
5.0.0 has no `-j` and sizes its job pool from the machine; data modules here peak at ~9 GB each and
certificate segments at 3.4 GB + 0.81 GB per chunk, so an unrestricted build asks for hundreds of gigabytes
and has taken the desktop down. A *named* target is not safe either: Lake silently queues every missing or
stale dependency into the same unrestricted pool. `scripts/build.sh` builds every module in dependency order
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
diagnose, retry, or work past it — working past one is how a filesystem event lost ~50 compiled modules.
**One heavy job at a time**: the box has no headroom for a replay, a hunt and a build together.

**Every long-running phase checkpoints and resumes exactly** (Kooshi, 2026-08-26). A run expected to exceed
~15 minutes persists its progress at natural acceptance points (a verdict, a wave, an accepted deletion) and
resumes from that state after a kill; a long phase whose state lives only in a process's memory is a bug.
The subplan answers, in writing: *if this process dies at any instant, what does the relaunch redo?*
**And the checkpoint must not live where another agent is told to clean.** `build/` is described in this
file as regenerable scratch, and an agent tidying up after itself deleted a tree under it on 2026-09-11
while a live job's only resume file sat in a sibling directory (`build/m63d2/ckpt-hismove/`). Recoverable
state one cleanup away from unrecoverable is not recoverable. Put checkpoints outside the scratch tree, and
name the **resume command** in the subplan beside the checkpoint's path — a checkpoint nobody knows how to
resume from is a file, not a recovery.

**Never edit a shell script while it is running.** Bash reads a script lazily, by byte offset, so a live
process resumes mid-token. Launch long runs from a snapshot copy (`cp scripts/x.sh build/x-snapshot.sh`;
`build/` is gitignored).

**Generated modules and invalidation.** For work split across independent modules the wall clock depends
only on the job count, not the piece size, so smaller pieces are free concurrency. Lake takes a module's own
trace from its source and its dependents' traces from the resulting `.olean`:

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
