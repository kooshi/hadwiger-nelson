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
**Size budget: keep this file under 200,000 bytes** (Kooshi, 2026-09-11: the budget is on *this file
itself*, not on the file plus the two imports above — there is a lot here worth remembering; raised from 150,000 to
200,000 on 2026-09-15 after a rule's reasoning was trimmed to fit and its loss cost hours). The budget is
a ceiling and never a licence: the current-state-only rule above does the real work, and superseded text
comes out whether or not there is room for it. **A paragraph tagged `[PROTECTED — never compress …]` is exempt from every trim
(Kooshi, 2026-09-15): the tag marks reasoning whose loss has already cost hours; trim elsewhere.**

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

*Last updated: 2026-09-15 — FS-50 closed: six colours refused at 83 by two independent exact certificates (row 68), the sieve's six gone from K(√7); the window for an exactly six-chromatic plane and reciprocity's exclusion of it for every field containing ℚ(√3,√11) (G56); the sixth-colour question minted as FS-53, the next milestone (Kooshi).*

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
   Every finite plane at p ≡ 3 (mod 4) from 59 up refuses five colours by its spectrum, and the plane at 83 refuses six by an exact certificate (row 68). Every field the
   descent ever used is 5-sealed (G43, G44). The wall is broken exactly when 1/2 lies in the unit-vector ring, and over ℚ(√3,√11) that is sufficient for five, given M56's 8/3 forcer (G55).
3. **The design target has no instance** (G48, row 66): the six-level question — a pair forced equal at five colours over a
   5-sealed field at 11 ∣ d², spindled into a 6-open field — is answered **no by theorem** over every 5-sealed
   multiquadratic field ⊇ ℚ(√3,√11): the sealing plane at 11 has a five-colouring with a fan gap, and a gap at
   level one, repainted along the residue map, frees every pair above it, so forced-equal pairs are single
   vertices and virtual edges are unit edges, at every distance. FS-6 is dead; a 6-forcer's every compulsion
   lives in a 6-open field, where no residue plane is five-colourable. The frame that replaces it is **tight
   or slack** (G54): the residue plane forces pairs only where it is Hoffman-tight, and no 5-sealing plane is.
4. **Existing witnesses hold nothing to extract — on sealed objects by theorem, on 6-open ones by
   measurement.** Heule-510's arity-2 emptiness at five colours is kernel (row 66: `Forces ↔ =`,
   `Separated ↔ Adj`, arity floor ≥ 3) and holds for every unit-distance graph over its field. De Grey's 1581
   has no compulsion at arity 2 or 3 (complete sweeps) and arity floor 4 or 5, and the `ρ₆₃` arena reads 0 at
   arity 2 — both in **6-open** fields, where no residue target exists, so those nulls stay measured and
   unexplained: a χ ≥ 6 gadget must be constructed, not found (G31).
5. **An in-field descent cannot end.** Points of ℚ(√3,√11) do intermediate kills and never the last one; the
   endgame needs a wall-breaking adjunction into a 6-open field (G34, G36, G37).
6. **Linear instruments are blind to 5–7.** Additive colourings, the fractional number, Hoffman and ϑ all stop
   below the interval, and the finite planes' chromatic numbers are integrality-carried (G38, G41, G44, G48).
7. **The cell family is closed in both directions** — no six-colouring, no bounded witness family — and its
   ≥ 7 floor is `[SokolovVoronov2025]`'s χ_poly(ℝ²) = 7 (G22, G24, G29).
8. **The type-M rotations are a classified one-integer family** — `cos θ = (2n−1)/(2n)`, the spindle at
   distance `√n`; `n = 3` is the Moser twist, `n = 4` the record, `n = 16` the `ρ₆₃` arena, **5-chromatic in the
   6-open field `ℚ(√3,√7,√11)`**, produced rather than inherited (row 64). The two members below the record die
   by Theorem B. Not the first 6-open platform (de Grey's own field is 6-open, G43) but the smallest, degree 8
   against 16, and reached by the screen rather than found.
9. **`[Parts2020a]`'s 509-vertex record is reproduced and partly explained** (M62–M64). His base is his §5.6
   closed form (1,603 points, 92 orbits under an order-24 group); the radius-2.44 arena — base plus rotated
   copy — contains Heule-510 exactly, while the base alone cannot (it lies in K² and χ(K²) = 4, row 57); his
   reduction stage is reproduced on every attested number, ~150× faster; a descent cannot reach the record
   (nine certified 1-minimal descents land at 582–609), and **overcompression is an orbit-closure gap**
   (row 62). Best 1-minimal objects by symmetry rung 624 / 576 / 558 / 582; best object 559, census-certified.
   What is left of his loop is the expansion step, which has no termination measure (FS-35).
10. **The conjecture's proved range** (GPT Astra, 2026-09-14, hand, read here — G55): χ(F²) = L(F) for every real number
   field with L ≤ 3, for every field containing √3 with L ≤ 4, and, given the measured 8/3 forcer, for every multiquadratic
   F ⊇ ℚ(√3,√11) with L ≤ 5, by the chain theorem, which lands a forced pair's contradiction in the field itself. Its cheapest
   exposed predictions are quadratic — four for ℚ(√11) and ℚ(√23), four or five for ℚ(√47) — with no forcer known there (FS-46).
11. **The window for six, and who can see it** (G56, row 68). A finite plane UD(𝔽_q, 2) with q ≡ 3 (mod 4) of odd degree can be
   exactly six-chromatic only at q ∈ {23, 27, 31, 43, 47, 59, 67, 79} — the exact spectra put 71 at ≥ 7, the certificate puts 83
   at ≥ 7, Weil refuses six from 98 — and none of the eight is decided (floors 5, 5, 5, 5, 5, 6, 6, 6; ceilings 8, 7, 8, 8, 10,
   10, 12 by verified colourings; no six-colouring found anywhere). No field containing ℚ(√3,√11) can use any of them (3 is a
   non-square at 31, 43, 67, 79 and 11 at 23, 47, 59, 71; at 27, 11 ≡ −1 (mod 3) is a non-square in every 𝔽_q with q ≡ 3 (mod 4)),
   so every field the hunt has built in has local bound 5 or ≥ 7: **six is arithmetically excluded for all of them**, and a
   six-chromatic number field, if one exists, contains no √11 and none of the known five-forcers. What the window decides is
   whether six is *reachable by the residue method*: no six-chromatic plane means no field has local bound 6, so any field
   holding a six-chromatic unit-distance graph has every usable plane at ≥ 7 and the finite planes can never pin it — under the
   conjecture's bold form (χ = 7 wherever L ≥ 7) that is χ(ℝ²) = 7 with six a value no field attains; one six-chromatic plane
   means a field with χ(F²) ≤ 6 by theorem and predicted 6 (FS-53).

**The prior-art position.** The reduction from a field plane to a finite residue plane has been derived
independently in seven lineages that barely cite one another — Woodall → Benda–Perles → Johnson → Chow;
`[Fischer1990]`; `[Moorhouse2010]`; `[Manturov2012]`; `[Madore2015]`; the finite-field side (Medrano–Myers–
Stark–Terras → Vinh → Schneider–Silva → Krebs → Lorenz–Zimmermann); `[Polymath16wiki]` — and all stop where
Madore's Prop. 3.9 declines to formulate the general case. **Ours:** Theorem A's general form (that
formulation); Theorem B, which closes Madore's 4 ≤ χ ≤ 5, answers Moorhouse §1, Cranston–Rabern's question and the question `[ExooIsmailescu2019]`'s conclusion asks, and settles one field of Benda–Perles Open Problem 11.6; the sieve; the lift theory; the compulsion transfer and distance law; the tightness mechanism;
the fan-gap transport and its compulsion consumers (row 66); the tight/slack classifier of a residue plane's
compulsions and its propagation up a tower (row 67, G54); plane freedom at every prime p ≡ 3 (mod 4); every
kernel certificate. **Not ours:** the finite-plane bound
and χ(𝔽₁₁²) = 5 (Moorhouse, Manturov, Madore); the unit argument and the 1/k obstruction (Fischer); ω and
ω ≠ χ on finite planes (Vinh, Krebs, Schneider–Silva); the cell family's ≥ 7 floor (Sokolov–Voronov); the
observed 2-adic compulsion pattern and its coordinate form (Heule, Parts, Dúcz); the two-colour mechanism over fields (Woodall, Fischer, Moorhouse, Madore); the multiquadratic decomposition (ChatGPT, credited in row 63); the ratio bound with its equality case and the Hoffman-colouring facts (Hoffman, Delsarte, Lovász, Blokhuis–Brouwer–Haemers); the non-frozen vertex (reconfiguration folklore); the chain theorem, the prime inversion and the two- and three-colour classifications (GPT Astra, G55).

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
| 32 | **Two-sided 6-programme**: `mono_pair_of_clique`; the hex-shell pigeonhole (the closed first shell is a K₇ of the {1, √3, 2}-distance graph, so χ(ℝ²; {1,√3,2}) ≥ 7 — folklore, formalization ours); the brick certificate and χ(ℝ²; {1, √(3/2)}) ≤ 9 (row 61). [tools] The five-colour pattern sweep: G19. | `Instances/HexShell.lean`, `Brick.lean`, `Instances/Nine.lean` | M35 |
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
| 43 | **De Grey's witness, bracketed**: `arityFloor_le_of_embedding`; the plane's homogeneity given an isometry (`transport_pair_of_isometry`, `Separated.planeIn`, `Forces.planeIn`); **the six-target**: χ(ℝ²) ≥ k + 1 from k-colour virtual edges at √3 AND at 2, neither sufficing alone on the hex-shell host (`add_one_le_chromaticNumber_plane_of_forced_pairs`; the {1, 2} host needs one, G26). [tools] The 1581's arity floor at five colours is 4 or 5, by complete sweeps (G31). | `Arity.lean`, `Homogeneous.lean`, `Instances/HexShell.lean`, `tools/m48.py` | M48 |
| 44 | **The two-distance dial** (G32): `distanceGraph V D`; **the spindle theorem** `not_colorable_of_forced_equal` (a forced-equal pair at any d ≥ 1/2 refutes k-colourability, and 1/2 is exact); `add_one_le_chromaticNumber_unitDistance_of_one_defect`; `seven_le_chromaticNumber_hexShell_distances`. [tools] Exoo–Ismailescu's {1,2} six-forcer re-derived exactly (certificate priced at ~50M hints and deferred; the `Instances/OneTwo` module two docstrings cite does not exist); Parts's {1,φ} forcer is edge-critical; 29 ≤ μ ≤ 252 on the seed. Predictions scored in the plan. | `DistanceGraph.lean`, `OneDefect.lean`, `tools/twodist.py`, `tools/killengine.py` | M49 |
| 45 | **Batch descent** (G33): `Glue.eq_gluePoint_of_dist_pair` and `Glue.finite_two_unit_neighbors` (depth-one candidate spaces are finite, in any field). [tools] Batch halos compose by construction (1,008 points, 403 of 446 cheats left); growth re-opens refusers; the seed carries 148 absolute virtual edges at d ∈ {3, 4}; the spare-colour lemma ((k−1)-colourable ⟹ no pair compulsion at k). | `PartnerLattice.lean`, `tools/batchkill.py` | M50 |
| 46 | **Copy unions**: `spindleRot`, `copyUnion`, `chromaticNumber_copyUnion_le`. [tools] Every unit edge of the descended object lies on the Moser lattice ℤ⟨1, ζ₆, ω₃, ζ₆ω₃⟩ and every point in ℚ(√3,√11); a ρ₁₅ copy kills no separating class at five colours; the cull cuts the standing cheats 273 → 149 with no material added. | `Copy.lean`, `tools/cull_enum.py`, `data/m52/` | M52 |
| 47 | [hand + tools] **M53, halted when Theorem B was proved**: the residue colouring is proper on every descent object with every cheat monochromatic; the residue obstruction and μ ≥ 3 inside ℚ(√3,√11) (G36); the wall-break census; 5-chromatic witnesses in ℚ(√3,√11,√247) (1,175 points; field and route prior art, `[ExooIsmailescu2019]`, `[Polymath16wiki]`) and ℚ(√3,√11,√23). | `tools/residue_colouring.py`, `tools/residue_floor.py`, `tools/wall_break_test.py`, `plans/FIELD-WALL-THEOREM.md` | M53 |
| 48 | **Critical-set localization** (G39): a forced-equal pair confines the critical set to N(p) ∩ N(q), a virtual edge to N(p) ∪ N(q); in the plane at most two critical vertices, none beyond distance 2 (`encard_criticalSet_le_two_of_forces`, `criticalSet_eq_empty_of_forces_of_two_lt_dist`), generalized to edge-length sets and metric spaces, where the count ≤ 2 does not survive. [tools] Two 5-chromatic objects with no critical vertex; the smaller (2,229 points) has no pair compulsion at five colours. | `CriticalSet.lean`, `tools/five_dial.py` | M54 |
| 49 | **Absorption** (G40): `Extends`, `extends_of_repaint`, `extends_of_hubs`, `extends_symCopy`. [tools] ν = 2 exactly on the two-spindle objects; a depth-two F₂₄₇ cross thickening frees 238 critical vertices, all on the copy side. | `Absorb.lean`, `tools/absorb_dial.py` | M55 |
| 50 | **The additive yardstick** (G41): `additiveColoring`, `not_forces_of_addMonoidHom`, `addMonoidHom_apply_eq_of_sub_eq_nsmul`; the additive spindle theorem (its chord lies in 4Λ). [tools] Exoo–Ismailescu's G's colouring space is exactly its additive family; no 5-chromatic witness has an additive 4-colouring. **Prior art:** the framework and the 1/k obstruction (no additive k-colouring, k ≤ 10, of a wall-broken plane) are `[Fischer1990]` Thm 10(ii). | `Additive.lean`, `tools/additive.py` | M56 |
| 51 | **Additive rigidity** (G42): `AdditivelyRigid`, `forces_of_additivelyRigid`, `six_le_chromaticNumber_plane_of_additivelyRigid`. [tools] Only Exoo–Ismailescu's G is rigid, and only **with its cheats** (the gauge includes its non-unit edges); every unit-distance object held is Kempe-open by orders of magnitude. | `AdditiveRigid.lean`, `tools/additive_rigid.py` | M57 |
| 52 | [hand + tools] **The finite-plane bound and the first exact wall-broken planes**: a field with a prime above p ≡ 3 (mod 4) **of ODD residue degree** — equivalently residue field 𝔽_q with q ≡ 3 (mod 4) — has χ(F²) ≤ χ(UD(𝔽_q,2)); χ(UD(𝔽₁₁,2)) = 5, so χ(ℚ(√3,√5,√11)²) = χ(ℚ(√3,√11,√247)²) = 5. **The degree condition is the whole content and a larger field can LOSE a prime its subfield had**: de Grey's ℚ(√3,√5,√7,√11) contains ℚ(√3,√5,√11) yet 11 has residue degree 2 there, so **de Grey's first usable prime is 131** and this row's bound says nothing about his field (G43). Sealed at 4: K, K(√35). Sealed at 5: K(√5) = Heule's field, K(√23), K(√247), K(√5,√247). **Prior art:** the bound is `[Moorhouse2010]` §8.2/§10.3, `[Manturov2012]` Thms 17–19 and `[Madore2015]` Cor. 3.4; the value at 11 is Moorhouse's Table 6.1. | `tools/fplane.py`, `reference/Chat-analysis/` | 2026-09-06 |
| 53 | **The field sieve** (G43, G44): `unitQuadrance R`, `unitQuadrance.map` (the bound as functoriality), `UDCert.drawing_adj`; **`chromaticNumber_finitePlane11`** (= 5, no solver) and **`chromaticNumber_heule510`** (= 5). [derived] Kloosterman eigenvalues make every plane at p ≡ 3 (mod 4) from 59 up refuse five, and at 83 six is refused by exact certificate (row 68); over ℚ(√3,√11), 6-open ⟺ wall broken ∧ 11 inert — **with the instances, whose deletion is what let the criterion be misapplied**: 6-open are de Grey's own field (first usable primes 131, 479), K(√7) (83), K(√13), K(√79), K(√127), K(√5,√7,√247); sealed at 5 are K(√5) (Heule's), K(√23), K(√247), K(√5,√247); at 4, K and K(√35). The standing map is `data/fplane/map.md`. **Prior art:** ω and ω ≠ χ on finite planes (`[Krebs2022]`, `[LorenzZimmermann2023]`, `[SchneiderSilva2013]`); `[Vinh2006]` restates the spectral bound without a factor 2, which our kernel value at 19 contradicts. | `UnitQuadrance.lean`, `Instances/FinitePlane11.lean`, `tools/fplane.py` | M58 |
| 54 | **The lift** (G45): `add_one_le_chromaticNumber_plane_of_lift`; `stressPairing_eq_zero_of_lift` (in any ring with π² = 0 a lift forces every self-stress to pair to zero with the defect); no lift modulo 131², 11² or 19² for the 1581's merged image and the 5-critical cores of UD(𝔽₁₁,2) and UD(𝔽₁₉,2). [tools] The hub scan: 3,739 exact depth-one hubs of the 1581 at 131. | `Lift.lean`, `Instances/LiftObstruction{11,19,131}.lean`, `tools/fplift.py` | M59 |
| 55 | **The residue obstruction** (G47): `Forces.image`, `Separated.image`; `forces_iff_eq_of_aperiodic`; the distance law (`Forces.quad_sub_eq_zero`, `Separated.quad_sub_eq_one`); `finitePlane11_forces_iff`, `finitePlane11_separated_iff`. **Over the √7-free tower with 11 ∤ D, a five-colour forced pair has 11 ∣ d² and a virtual edge d² ≡ 1 (mod 11), so neither a √3 nor a distance-2 gadget exists** (`not_separated_sqrt3_11`, `not_separated_two_11`) — and at the rational squared distance 25/9 (`not_forces_of_distSq_ratio`, `not_forces_five_thirds_11`) Polymath16's 5/3 question has the answer no (`CLOSED-QUESTIONS.md` §1.4). **Subsumed by row 66**, which refutes every five-colour forced pair and every non-edge virtual edge over the same fields at every distance; the law stays as the level-one shadow. | `ResidueObstruction.lean`, `Instances/ResidueObstruction11.lean`, `tools/fpcompel.py` | M60 |
| 56 | **Local–global tightness** (G48): `addCayleyMap`; `unitQuadrance_colorable_of_quotient`; `card_le_chromaticNumber_mul_indepNum`; **`Forces.isEmpty_ringHom_of_spindle_radicand`** (with `…_of_not_isSquare_neg_one` and `…_of_colorable` forms); `chromaticNumber_finitePlane19_le_five`. [tools] ϑ = Hoffman at eleven primes; no rotationally symmetric 5-colouring of UD(𝔽₂₃,2); the triple-level certificates at 11, 23, 83 are row 68's. **Prior art:** `addCayleyMap` is `[Moorhouse2010]` §4.2 and the periodic quotient an instance of `[CervantesKrebs2023]`; the mechanism is ours. | `LocalGlobal.lean`, `Instances/LocalGlobal19.lean`, `PlaneRotation.lean` | M61 |
| 57 | **Theorems A and B.** **B:** `chromaticNumber_seamPlane`, χ(ℚ(√3,√11)²) = 4 — residue maps onto 𝔽₄ at the two primes above 2, a parity descent in place of valuation theory, and the Moser spindle as an identity in the order; `not_forces_five_of_subset_seamPlane`. **A:** `colorable_of_residue` — a graph drawn in an abelian group, edge differences in a subgroup A and nonzero under ψ : A →+ G, is \|G\|-colourable, with no metric, field or ring; `normOne_subset_valuationSubring`, `colorable_unitDistance_induce_of_valuationSubring`, `normOneColoring`. **Not proved:** that a number field with a conjugation-fixed prime supplies the valuation subring with residue field of size N(𝔭). **Prior art:** the valuation-subring form is `[Madore2015]` Prop. 3.2 and the unit argument `[Fischer1990]` Thm 1; Theorem A's general form is what Madore's Prop. 3.9 declines to formulate. **B answers** `[Moorhouse2010]` §1, `[CranstonRabern2015]` (so 76/21 ≤ χ_f(K²) ≤ 4) and `[ExooIsmailescu2019]`'s closing question, and settles one field of Benda–Perles Open Problem 11.6 (`[Soifer2024]` ch. 11), and closes `[Madore2015]` Prop. 4.6's 4 ≤ χ ≤ 5. | `FieldWall4.lean`, `ResidueColouring.lean` | 2026-09-08 |
| 58 | **The Moser recipe's sharp threshold**: a host graph with no k-clique draws no minimal forcing gadget at k colours (`not_forces_of_drawing`); four plane points are never pairwise unit-distant, so for k ≥ 4 no k + 1 plane points carry a forced pair (`not_forces_of_unit_drawing`), while at k = 3 the drawn rhombus is the minimal gadget (`exists_forces_of_unit_drawing_three`). It says nothing about non-minimal constructions. | `Mascot.lean`, `plans/MASCOT-DERIVATION.md` | 2026-09-09 |
| 59 | **The 2-adic law of four-colour compulsions over K = ℚ(√3,√11)**: the residue colouring identifies two K-points iff their distance lies in the prime 𝔭 above 2 (`residueColouring_eq_iff_psiA_zero`), so a forced-monochromatic pair needs v_𝔭(d) > 0 and a virtual edge v_𝔭(d) = 0 (`not_forces_of_residue_ne_zero`, `not_separated_of_residue_eq_zero`); each distance in `[Parts2020a]` Table 1 is barred from the other column (two rows' √ unverified against the PDF, same valuation either way). The general form needs only a conjugation-stable ideal kernel (`map_mul_conj_eq_zero_iff`). **Open:** are both conditions also sufficient in some finite K-object? **Prior art:** the coordinate form is `[Ducz2026]`; the observed pattern is `[Heule2019]`, `[PartsOdd2022]`, `[Heule2021]`, `[Ardal2009]`. Ours: the field-level valuation statement, the compulsion consumers, the kernel proof. | `ValuationLaw.lean`, `ResidueColouring.lean` §4 | 2026-09-09 |
| 60 | **Plane freedom**: rotations by circle points are automorphisms of `unitQuadrance R` (`rotHom`, `quarterTurnHom`); over a field where −1 is not a square a vector and its quarter turn span the plane; so **over ZMod p with p ≡ 3 (mod 4), `Forces ↔ x = y` whenever the plane is k-colourable** (`finitePlane_forces_iff`) — without colourability the statement is false (`finitePlane3_not_colorable_two`). Prime fields only; the virtual-edge half is proved only at 11. | `PlaneRotation.lean`, `Instances/PlaneFreedom.lean` | 2026-09-09 |
| 61 | **Statements at their proofs' level**: the six-target is colour-generic (`seven_le_chromaticNumber_plane_of_forced_pairs`: two six-colour gadgets give χ ≥ 7) and distance-set-generic, and over {1, 2} one √3 gadget suffices (`six_le_chromaticNumber_oneTwo_of_forced_sqrt3`); a passing brick certificate colours `distanceGraph ℂ D` (`chromaticNumber_plane_avoiding_sqrt_three_halves_le_nine`); the old names are pinned by compiled type ascriptions. | `Instances/HexShell.lean`, `BrickDistance.lean` | FS-24 |
| 62 | **Overcompression is an orbit-closure gap**: for an upward-closed refusal family and H ≤ Aut(A), the rung-H minimum equals min \|cl_H(M)\| over inclusion-minimal refusers M, so every symmetry rung is a hitting-set problem over H-orbits against the correction-set hypergraph Y, with no colouring ask. [tools] On `[Parts2020a]`'s L stage: 375 vertices / 3,264 minima at the trivial rung; a dead involution gives 376 with containment 0 of 1,302 — his §6 sentence reproduced at 375 and 376; S-side rungs cost 8 vertices where L's cost 1; Y accounts for every exclusion. **Prior art:** the symmetry gap of symmetric integer programming (`[HerrRehnSchurmann2013]`), idealness, semilinear sets, MUS/MCS enumeration (arXiv:2412.13606 — our 336 necessary atoms are its backbone). | `tools/parts_faces.py`, `tools/parts_reduce.py`, `data/m62/m64-*.json` | M64 |
| 64 | [tools] **A five-chromatic unit-distance graph in a 6-OPEN field, at a rotation the field screen selected** (M63 phase H2). The type-M rotations are classified by one integer — `cos θ = (2n−1)/(2n)`, diagonal circle at `\|p\|² = n`, radicand `4n−1` — the **spindle** at distance `√n`: `n = 3` is the Moser twist, `n = 4` is `ρ₁₅` (the 509-vertex record), `n = 16` is `ρ₆₃ = (31+3i√7)/32`, which is `ω₁₆` of `[Polymath16wikiMain]`'s 2018 list and a generator of de Grey's own ring (G8). **The rotation, the angle family and the spindle identification are prior art (G7); ours are the field screen that selected it, the 6-openness, and the produced refusal.** Screened by four gates we hold (free circle; `sin θ ∉ K`, else Theorem B four-colours every base; the 2-adic wall; 11's residue degree), the record is the cheapest live member and the two below it die by Theorem B. **At `n = 16`: `χ(arena) = 5` exactly, on 51,133 vertices / 544,530 edges in `ℚ(√3,√7,√11)`** — the lower half twice, a complete 552-pattern enumeration with **0 of 304,704** admissible pairs and **552/552 UNSAT** cube-and-conquer in 20.03 core-hours (four solver codebases on the first claim, two on the other nineteen, paired positive controls), the upper half an explicit colouring verified proper on all 544,530 edges. Proof logs (1 GB LRAT over 11.8 M lines) were **generated, never checked, and never committed — they lived in `/tmp` and are gone**. The durable commits are the 151 KB certificate and 5 KB manifest at `data/m62/m63-phaseH2-rho63-*.json`. **The refusal is produced, not inherited**: no known witness embeds at any position or orientation, and the base half alone four-colours in 0.35 s. **The result is the field, not the size** (6-open `K(√7)`, where row 55's bar does not apply; item 8 above). **Not kernel-certified; one object.** Also: the 30 circle points admit exactly 19 colour patterns in `1 + 6·3` orbits under `ζ₆`, every one half-turn invariant; `h(K) = h(K(i)) = 1` with `μ(K(i)) = ⟨ζ₁₂⟩` (pari). | `plans/M63-phaseH2-the-family.md`, `plans/M63-phaseH2-solver.md`, `plans/M63-phaseH2-plan.md`, `plans/POROS-2026-09-12-m63-phaseH2.md`, `plans/M63-phaseH4-reduce-the-platform.md`, `data/m62/README.md` | M63 phase H2 |
| 63 | **Two colours from inertia, and the 2-adic splitting of multiquadratic fields**: a residue map into a reduced characteristic-2 ring that conjugation does not move two-colours every unit-distance graph over its valuation subring (`colorable_two_unitDistance_induce_of_valuationSubring` — its plane and valuation forms have **no instance over a real field yet**; the only inhabitant is the ring form on ℤ[i], deferred to FS-37); a square-class group holding [2] is the sum of two pieces whose 2-adic images avoid [−1], so every real multiquadratic field lies, once √2 is adjoined, in the compositum of two fields that pass the four-colour test (`fieldOfRadicands_le_sup`) — each holding a Moser spindle when the field contains ℚ(√3,√11); de Grey's field lies in ℚ(√2,√3,√11,√35)·ℚ(√3,√10,√11,√35); ℚ(√3,√11,√14) and ℚ(√3,√11,√70) pass the test and their compositum's plane needs five colours (`five_le_chromaticNumber_planeOver_fourteen_sup_seventy`), so, granted the factors' hand χ ≤ 4, no combining rule for test-passing fields gives four. **Not proved:** χ ≤ 4 for any piece (FS-37). [hand] For real multiquadratic F, χ(F²) = 2 iff no odd square class is ≡ 3 (mod 4); for every real number field, χ(F²) = 2 iff L(F) = 2 (GPT Astra, G55). **Credit:** the decomposition is ChatGPT's (OpenAI, with Kooshi, 2026-09-11). **Prior art:** the mechanism is Woodall's, `[Fischer1990]` Thm 8, `[Moorhouse2010]` Thm 7.1, `[Madore2015]` Prop. 3.9; the multiquadratic iff is unchecked against `[AxenovichEtAl2014]` and `[Johnson2006]`. | `TwoColourResidue.lean`, `SquareClass.lean`, `Instances/CompositumFive.lean` | FS-36 |
| 65 | [tools] **Dropping `[Parts2020a]`'s coordinate shape: the object dies, the family gains six results, and the direction closes** (M63 phase H3). His base confines a point of `K²` to four of eight rational slots (the CM field `ℚ(√−3,√−11)`), so **dropping the shape IS adjoining the quarter turn** (`[Polymath16blog]`, Speyer, 2018-04-25). Dropped at `n = 2` (`ρ₂ = (3+i√7)/4`, field `ℚ(√3,√7,√11)`, 6-open) the base is the ℤ-span of its own 60 unit vectors (index 256, group order 48, 16,309 points) and **is four-colourable at every radius, by derivation**: an arena colouring is a pair `(f, g)` of base colourings meeting 132 interface constraints, searched over the additive family — 576 of 124,416 in 1.7 s, none a twist, which is why a twist-only search read it as live; additive colourings are lattice homomorphisms and the cross edges are pinned at 252, so growth cannot help (0 monochromatic at 32,617 / 83,905 / 301,537 vertices). **The screen is the product: the additive-pair route is open exactly when `4 ∤ n` and dead exactly when `4 \| n`** (the colour group is 2-torsion, so a circle inside `2L` takes the centre's colour) — base-free, radius-free, solver-free, clean on all 19 members `n ≤ 20` — and **every 6-open member listed (16, 20, 44, 60, 64, 76, 108, 112) is `≡ 0 (mod 4)` and immune**. Also: (i) the endpoint bound `1/\|sin θ\|` governs cross-edge endpoints, not a base's extent; (ii) growing a base is monotone — colourings restrict, so the interface pattern set only shrinks (`10²¹ → 10⁴` for a 2.6× base); (iii) the circle sits at `√(1−1/(4n))` of the bound, on the arena boundary in every member, so the free-circle theorem's hypothesis has never been met by any object built; (iv) a two-case classification of monochromatic cross-edge kinds over `V = n(g−h)² + gh` (case A for every `n`; case B iff `v_𝔭(gh) < v_𝔭(n)`), 12/12 families retrodicted; (v) each conjugate condition beyond the first costs 2.0–2.6× in realised connectivity; (vi) a one-sided kill test for phase H2's interface reduction, milliseconds from one base colouring. **The premise is confirmed where it matters**: at the record's own `n = 4`, dropping the shape takes monochromatic off-diagonal cross edges **0 → 144** (195,961 points, 492/492 confirmed) — the shape, not the rotation, was the obstruction. **And the direction closes**: on Parts's shaped lattice every member with a nonempty circle is odd (dead by Theorem B) or `4 \| n` (immune), so the shape-free construction reaches only members this route kills; `n = 16` is the cheapest 6-open immune member and is realisable shaped at 25,567 points — phase H2's own object. Residual, priced not pursued: `n = 10` (`K(√13)`) at ~6.6 M points. **Prior art:** the move is `[Polymath16blog]`, Silberman, 2018-04-19; the coincidence-site-module literature excludes the object by definition (`[BaakeZeiner2017]` §6). **Nothing kernel-checked; no proof log.** Its certificate and `recheck.py` were left under the gitignored `build/` and are not in the repository. | `plans/M63-phaseH3-plan.md`, `plans/M63-phaseH3-solver.md`, `plans/M63-phaseH3-crossedges.md`, `plans/M63-phaseH3-module.md`, `plans/M63-phaseH3-prior-art.md`, `plans/POROS-2026-09-12-m63-phaseH3.md` | M63 phase H3 |
| 66 | **The fan gap, and the arity-2 compulsion structure over sealed fields** (FS-38). A colour absent from a vertex's closed neighbourhood in some proper colouring of a target graph (`FanGap C v γ`), repainted at any vertex above it along a graph homomorphism, frees that vertex from every forced pair: `not_forces_of_fanGap` (no forces-freeness or colourability premise), `not_fan_of_fanGap` (a fan survives only if some partner's image sits on the gap colour in every gapped colouring), `not_separated_of_sharedGap` (one colour absent from both closed neighbourhoods, repainted at a non-adjacent pair); `Slack.forces_iff` (`Forces ↔ =`), `PairwiseFusable.separated_iff_adj` (`Separated ↔ Adj`) and their `_of_hom` forms; the transports `FanGap.comap`, `Slack.of_hom` (no surjectivity), `slack_addCayley_of_fanGap` (one gapped vertex is slackness everywhere on a Cayley graph), `unitQuadrance_fusable_of_sharedGap_base` (one shared-gap table at the base edge, by translation and `rotHom`), `Slack.unitQuadrance_of_ringHom`; `exists_fanGap_iff_not_coverAtLeast`; `three_le_arityFloor_of_forces_eq_of_separated_adj`. **Instances:** `UD(𝔽₁₁,2)` is slack and pairwise fusable at five colours — the certified table's gap at `(2,4)` and a second 121-entry table with colour 4 absent from `N[(0,0)] ∪ N[(1,0)]`, decided — so for every graph with a homomorphism into it **`Forces G 5 u u' ↔ u = u'` and `Separated G 5 u u' ↔ G.Adj u u'`** (`forces_iff_of_hom_finitePlane11`, `separated_iff_adj_of_hom_finitePlane11`): `ZMod (11^m)`, `ℤ_[11]`, `Adjoin 11 ℤ_[11]`, every `Valid` √7-free certificate with `11 ∤ D` (`UDCert.forces_eq_11`, `UDCert.separated_iff_adj_11` — every pair, no distance hypothesis), and **Heule-510 unconditionally** (`heule510_forces_iff`, `heule510_separated_iff_adj`, `three_le_arityFloor_heule510` — G31's measured null promoted, the pair `(0, 475)` M60 was silent on included). At 19 the forces half on the kernel's own periodic colouring (`finitePlane19_slack`; gapped classes `y − x ∈ {4, 10}`). **Consequences:** over every 5-sealed multiquadratic field ⊇ ℚ(√3,√11) — each has 11 usable of residue degree one — a five-colour forced pair is a single vertex and a five-colour virtual edge a unit edge, at every distance: G48's six-level question is answered **no** (arity 2), FS-6 has no instance, FS-16's 51 candidates are none of them virtual edges, and row 55's distance law is the level-one shadow of this. **Not claimed:** the field-level hand step of M58/M60 (row 57's gap); anything at arity ≥ 3; anything over a 6-open field, where no 5-colourable residue target exists. **Prior art:** a gapped vertex is the reconfiguration literature's non-frozen vertex (`[BrewsterEtAl2020]`, folklore); the transport along a homomorphism and its compulsion consumers were not found (plan §PA). | `FanGap.lean`, `Instances/FanGap11.lean`, `Instances/FanGap19.lean`, `data/fs38/` | FS-38 |
| 67 | **The 2-adic tower stabilises at level 4** (FS-38). `P_m = Cay(O/𝔓^m, S_m)`, `O = ℤ₂[ω][√3]`, `𝔓² = (2)` — the local plane of ℚ(√3,√11)(i) above 2 at **four** colours, in a ring-free representation (`twoAdicPlane m`, an `addCayley` under two Eisenstein forms; that it is `Cay(O/𝔓^m, S_m)` is [hand], three independent constructions agreeing). **Kernel:** level 4 is pairwise free (`twoAdicFour_forces_iff`, five tables through the connection set); level 5 forces exactly the kernel of the level map — `Forces (twoAdicPlane 5) 4 0 d ↔ twoAdicLevelMap 4 d = 0` (`twoAdicFive_forces_iff`), the backward half from **one LRAT refusal replayed by the kernel** on the refutation's own 125-vertex, 778-edge core (`twoAdicFive_not_colorable_with_edge`; the pins' clique proved from the edge list) and the `ω`-orbit, the forward half by pullback; no level ≤ 5 has a fan gap (`twoAdicFive_not_slack`, `twoAdicFour_not_slack`, `twoAdicPlane_one_no_fanGap`). **Derived** [hand, `plans/FS38-derivation.md` D-2, Theorems D2-A/B]: every `P_m` is Hoffman-tight at four colours (`λ_min = −d/3`), so every 4-colouring is balanced, gap-free and periodic under `H_min`, the common kernel of the minimising characters; the minimisers stabilise at level 4 (45 characters, trivial common kernel), so for every `m ≥ 5` **every 4-colouring of `P_m` is pulled back from `P₄`** — the tower's colouring space is `P₄`'s 1,179,936 colourings — with `Forces ⟺ x − y ∈ 𝔓⁴` and `Separated ⟺ y − x ∈ S_m + 𝔓⁴`; the depth 4 has an arithmetic origin, a lattice certificate: four norm-one units `≡ 1 (mod 𝔓)` whose `t − 1` span has 2-adic elementary divisors 1, 2, 4, 4, so `𝔓⁴ ⊆ M` and `𝔓³ ⊄ M`. [tools] Measured at levels 1–8 under controls (the forced set exactly `{depth ≥ 4}`, two engines, verified colourings; the level-9 spectrum met out of sample); a 3-adic control met with no solver (every 3-colouring of `UD(ℤ/9,2)` is 3-periodic); the 11-adic tower slack at every level [kernel, row 66]. **The classifier:** the sign of `λ_min + d/(k−1)` of the level-one plane — tight at 2 (k = 4) and 3 (k = 3), slack at 7, 11, 19, 23, 83 — and by the Weil bound no usable prime above 3 in the committed table is tight for any `k ≤ 7`. **The transfer is freeness only:** a K-fabric with a homomorphism into `P₄` cannot force a four-colour pair of depth ≤ 3 (the mechanism behind M53's zeros at depth 2), while the tower's forcing is an extremal property of the whole Cayley graph and says nothing about any finite chunk — M56's depth-6 fact stays unexplained, and P-D3 registers that no finite K²-graph forces depth 4. [hand 2], that a K-certificate draws into `P_m`, is row 57's gap, unchanged. **Prior art:** the ratio bound and its equality case (`[Hoffman1970]`, unpublished by him per `[Haemers2021]`; `[Delsarte1973]`, `[Lovasz1979]`, `[GodsilMeagher2016]`); "k-tight" is the literature's *Hoffman colorable*, and balance plus gap-freedom is Blokhuis–Brouwer–Haemers 2007 Prop. 2.3 (`[AbiadEtAl2025]`); `[MMST1998]` holds the spectra over `ℤ/p^r`; the Fourier periodicity, the tower propagation and the classifier were not found. | `TwoAdicTower.lean`, `Instances/TwoAdicFour.lean`, `Instances/TwoAdicFive.lean`, `Instances/TwoAdicFive/`, `plans/FS38-derivation.md`, `plans/FS38-tower-records.md`, `data/fs38/` | FS-38 |
| 68 | **Six colours refused at 83, by exact certificate** (FS-50). **[exact-rational]** α(UD(𝔽₈₃,2)) ≤ 1059 < 1149 = ⌈6889/6⌉ (the tightest checked certificate, N = 1059.834185, the polish loop's 134,500-iterate of 2026-09-15, its LDL log `data/fs50/p83-refusal/ldl-N1059.log`; at the close N = 1076.366454; the first pair, independent, from two backends' iterates: N = 1082.915378 and 1082.957649), each CERTIFIED by `tools/fplane_cert_check.py` (standard library only; rebuilds the group, its 49,447 pair orbits and the 98,894 canonical rows from the number 83, checks the multipliers' signs, the rational Gram factors and the affine identity exactly; 15 s) and by its exact LDL; the relaxation is the triple-level SDP on the orbit algebra of O(2,p) × swap × S₃, block-diagonalised into 43 real blocks of size ≤ 83 (base points on the two reflection axes) and solved on the GPU (0.2 s/iteration against 1.4 s sequential); certificates at 11 (N = 29.176808 against α = 28, Hoffman 34.55) and 23 (108.546075; α ∈ [87, 108], the five-colour threshold 106 out of the relaxation's reach). **[kernel]** `add_one_le_chromaticNumber_of_indepNum_le` and `seven_le_chromaticNumber_finitePlane83_of_indepNum_le` consume ⌊N⌋ ≤ 1148, so χ(UD(𝔽₈₃,2)) ≥ 7 rests on the checker's word until the certificate's kernel form (FS-52). **[tools]** α(83) ≥ 597 (46 records re-verified from the definition), the plane alone 574; CDCL undecided on every independence instance at 19 and 23; ϑ = ϑ′ = Hoffman on every plane, so only the triple level sees below the ratio bound. **Consequences:** the sieve's six leaves K(√7) = ℚ(√3,√7,√11) — its usable primes are 83 and primes ≥ 103, all ≥ 7 — so L(K(√7)) = 7 and the conjecture predicts χ(K(√7)²) = 7, hence χ(ℝ²) = 7 (G48); FS-40 closes on the refusal side (a seven-colouring was sought by local search for 300 s × 12 threads and not found, best 4.17 % of edges monochromatic, and eight likewise, 2.95 % — nothing decided either way, χ(UD(𝔽₈₃,2)) ∈ {7, 8, …}); the first exact chromatic digit of any finite Euclidean plane above 11. **The mechanism that produced the certificate:** the exact bound is rounded from a fresh short continuation's own dual, never from a long-run iterate or through a nudge — SCS's adaptive scale is not checkpointed and drifts (1082 against 1260 from the same solve). **Prior art:** the SDP's shape is `[Schrijver2005]`'s (recalled, listing), the hierarchy `[GvozdenovicLaurent2008]` (listing); the ratio bound `[Vinh2008]`; no exact digit above 11 found in the literature (FS-50 §PA). | `Instances/IndependenceThreshold.lean`, `LocalGlobal.lean`, `tools/fplane_cert_check.py`, `tools/fplane_cert_round.py`, `tools/fplane_sdp_blocks.py`, `data/fs50/p83-refusal/`, `data/fs50/README.md`, `plans/STUB-independence-threshold.md`, `plans/FS50-certificate-soundness.md` | FS-50 |

### Paths forward, ranked

*A mirror of `plans/FRONTIER-STUBS.md`, which is authoritative: every row there is a full stub with its
bearing on χ ≥ 6 stated honestly. Kooshi picks; the default is the top.*

**Open milestones, in order.** **FS-50 closed 2026-09-15** (row 68, G56): six colours refused at 83 by two independent
exact certificates, the instrument (the triple-level SDP in real blocks on the GPU, the exact rational certificate, the
stranger-checkable checker) proved at 11, 23 and 83; **FS-53 the sixth colour is the next milestone** (Kooshi). **FS-38
closed 2026-09-13** (rows 66–67, G54). **M63** stands at phases H2–H3 closed (rows 64–65); **M62** stays paused behind it.

**Ranked stubs** (re-ranked 2026-09-15 at FS-50's close: FS-53 the next milestone (Kooshi); FS-40 absorbed; FS-51/52 listed; `plans/FRONTIER-STUBS.md` is authoritative):

| rank | stub | the question | bearing on χ ≥ 6 |
|---|---|---|---|
| 1 | FS-53 the sixth colour — `plans/STUB-sixth-colour.md` | which prime has χ(UD(𝔽_p,2)) = 6 exactly, and which field has local bound 6 through it? The window is p ∈ {23, 31, 43, 47, 59, 67, 79} (71 is ≥ 7 by spectrum, 83 refused six by certificate on 2026-09-15, Weil refuses it from 103), none decided; by reciprocity no field containing ℚ(√3,√11) can use a window prime, so six needs a field without √11 (ℚ(√2,√3,√31) sees only 23, ℚ(√2,√3,√7) only 47); under the conjecture the window decides whether six exists at all: no six-chromatic plane ⟹ χ(ℝ²) ∈ {5, 7}; one ⟹ a field with χ(F²) ≤ 6 by theorem, predicted 6, a finite six-chromatic graph by compactness | the highest in either outcome |
| 2 | FS-45 chain, don't spindle — `plans/STUB-chain-theorem.md` | GPT Astra's chain theorem in the kernel with its instances: the 18-vertex ℚ(√2,√3) graph, and `five_le_chromaticNumber_planeOver (K(√7))` from eight copies of the 588-core 8/3 forcer with its pinned refusal as an LRAT | none on six directly; medium, mechanism |
| 3 | FS-47 the unit-vector ring in the kernel — `plans/STUB-unit-vector-ring-kernel.md` | prime inversion (1/p ∈ R iff no stable prime above p, by lying-over — M56 L7's conjecture), the two-colour classification of every real number field, χ ≥ 5 for every wall-broken F ⊇ K; closes row 57's hand step from the ring side | none; medium, mechanism |
| 4 | FS-46 three colours over √3-fields — `plans/STUB-three-colour-classification.md` | Theorem 3.1 in the kernel leaf by leaf: the rhombus period, the descent to R/3R, Hilbert 90, the product embedding, El-Zahar–Sauer formalized (not in Mathlib), the floor at 3^f as the one named hypothesis | none; medium, mechanism |
| 5 | FS-48 the ℚ(√3,√d) table — `plans/STUB-biquadratic-table.md` | χ = 3 iff d ≡ 1 (mod 3); χ = 4 iff d ≡ 2 with the wall standing, by explicit rhombus chains (ℚ(√3,√5)'s is six vectors by hand; 17, 41 predicted new values); d = 5, 23, 47 the open five-level cases, d = 29's local bound FS-17's question; the first witness built from a residue plane upward, over ℚ(√3, α), α³ = α + 1 | none on six; medium-low mechanism, high as a table |
| 6 | FS-43 the slack census — `plans/STUB-arena-slack-census.md` | which vertices of the ρ₆₃ arena are frozen in every five-colouring? A vertex with a free colour in some five-colouring is forced to nothing (row 66 against the graph itself); every vertex off the 66 cross edges is slack by derivation once one compatible pair (f, g) with f four-coloured exists, so the census is ≤ 132 interface vertices, hours; then the slack dial on thick K(√7)-fabric | medium as an instrument — explains H4's null by theorem or hands the hunt its first frozen material in a 6-open field; two-sided |
| 7 | FS-49 one gadget for six — `plans/STUB-distance-two-gadget.md` | a five-colour virtual edge at distance 2 over a 6-open field, transported onto the 892 length-2 edges of Exoo–Ismailescu's 426-vertex graph, is χ(ℝ²) ≥ 6 (GPT Astra's sentence; row 43 needed two gadgets); the arena has none (H4), so the search runs on thick K(√7)-fabric through FS-43's shared-gap filter with pinned asks on survivors; the kernel consumer waits on row 44's certificate | the highest if it lands; the genre that returned zero on the arena |
| 8–13 | FS-39 the bridge to the plane, FS-41 `forces_of_tight`, FS-42 5-tight quotients, FS-44 the fifth colour, FS-51 the ratio bound in the kernel, FS-52 the triple certificate in the kernel | χ(ℝ²) = sup_F χ(F²), invoked since M58 and never stated; Hoffman's equality case in Fourier form, the mechanism behind rows 58 and 67; the one residue route to a five-forced pair row 66 leaves, a reading with its falsifier; what structures five-colourings of 6-open fabric when no residue or additive colouring exists | high on every χ(ℝ²) sentence; medium mechanism; medium-low reading; medium-high frame |
| 14–16 | FS-20 the paper, FS-17 the first digit at 23 (FS-53's phase B at 23; six needs α ≥ 89, five α ≥ 106, the set found 87), FS-2 Kempe classes | Theorem A as the formulation seven lineages stopped short of, now carrying rows 57, 66, 67 and G55; is UD(𝔽₂₃,2) exactly 5-chromatic (slack, so the screen cannot decide it); what carries M56's depth-6 forcing | the publication trigger; the disproof-side digit; mechanism |
| 17–20 | FS-13 finite-plane 6-critical cores, FS-12 the hub scan as a design instrument, FS-19 𝔭-adic classification of forbidden distances, FS-37 the 2-adic criteria at the field level | autopsy objects; a decidable fan filter over sealed fields; `[Chow1993]` with v_𝔭(d²); Theorem A's own gap, shared with FS-47 | low-medium each; FS-37 feeds FS-20 and FS-47 |
| 21–22 | FS-27 consolidation remainder, FS-23 the knowledge web | the paper's blockers; the citation graph | none |
| 23–25 | FS-30 consume the rotation list, FS-35 expansion look-ahead, FS-22 √7 phase pinning | largely answered by M63 phases G–H2; bookkeeping remainders | low |
| 26–27 | FS-8 Haugland 7-adic check, FS-29 the overclaim check | a falsifier of an external claim; a gate's limit | low |
| 28–30 | FS-9 topological bounds, FS-10 Nullstellensatz certificates, FS-5 bookkeeping | reading rooms and loose ends | low |

**Closed as directions** (reasons in the grokkings): the six-level design target over a sealed field (FS-6) and
the residue-allowed distances (FS-16), both dead by theorem (row 66, G48); the cell family, in both directions
(G29); extracting a gadget from an existing witness (G31); many spindles over one fabric (G40); designing in a
finite plane and lifting (G45); an in-field descent (G34); reaching Parts's record by pure reduction (row 62;
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
rewritten in place to current state — but **a grokking that dies is demoted with its refutation recorded, never deleted**: the entry keeps, in one or two sentences, what it wrongly claimed and what killed it. G1–G54 are stable
identifiers cited across `plans/`: never renumber (the numbering order in this section is not chronological).*

**The theory in one paragraph.** The 4/5 wall is arithmetic. A unit-distance graph over K = ℚ(√3,√11) is
4-colourable by a residue colouring at the prime above 2, so a 5-forcer is K-fabric — a small vocabulary of
seam shells about rotation centres, organized by the half-spindle group — plus a spindle whose radicand
breaks the 2-adic wall; its forcing is a regional pigeonhole on the fabric composed with kills that must
leave K, invisible at the pair level. Past five colours the linear arithmetic goes blind and the finite
residue planes take over: a field is 5-sealed when a usable small prime's plane is 5-colourable, the sealing
plane carries no pair compulsion of its own, and a spindle over a forced pair removes exactly the prime that
sealed its fabric. That mechanism now has no instance: the sealing plane at 11 has a fan gap, and a gap at level one frees every
pair above it (row 66), so over every 5-sealed field the five-colour compulsion structure at arity 2 is trivial —
forced pairs are single vertices, virtual edges unit edges — and a residue plane forces pairs only where it is
Hoffman-tight, which at five colours no sealing plane is (G54; at 2 with four colours the plane is tight and the
tower forces from level 5, row 67). So a 6-forcer's every compulsion lives in a 6-open field, where no residue
plane is five-colourable and the residue method is silent; what it can still name is a 5-colourable, 5-tight
quotient of such a plane (FS-42), or the first digit at 83 (FS-40).

* **G1 — The field wall. [kernel]** The Moser twist is a seam-group word (ρσ² = −1), the seam group's
  countable closures are exactly 4-chromatic, and all of ℚ(√3,√11)² is 4-chromatic (Theorem B). A 5-forcer's
  coordinates must break the 2-adic wall — contain an odd square class ≡ 7 (mod 8), such as √5, √7 or √247
  (G35). The certified witnesses' √5 and √7 are instances, not the criterion.
* **G2 — Construction grammar. [measured]** Rings of vertices about a point ⟺ that point was a rotation
  centre of the construction: de Grey's graph has two ring-hearts (its spindle centres), Heule's one. Mirror
  defects are the chirality of a rotated copy.
* **G3 — Radially crystal, angularly detuned. [measured]** Every exact radius of the three certified
  witnesses about their centres lies in ℚ(√33); the new-field content lives in the angles. This is the
  hexagonal fabric's form.
* **G4 — One shell vocabulary. [measured]** Every known 5-forcer stands on one inventory of ~30–44 seam radii; 25 of de Grey's 29 per-centre rings are Heule-510 rings.
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
  failure, that `n = 2` was never examined).
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
  with radii on one conic; words mixing √ρ₁₅ and √ρ₆₃ couple nowhere. A single detune's colour pressure is one thin conic, which is why 5-forcers
  are built from forced pairs.
* **G13 — The fan ladder. [kernel + measured]** Colour steps happen by confinement at a centre
  (`fan_iff_coverage`): two circles are 3-colourable and their centre forces a fourth; Heule-510's centre is
  fanned at four colours by the ambient web, which its own two-circle system provably cannot deliver. Fans
  are not special to centres, and coverage is a k-set property invisible to pair sweeps. The ladder's other
  face is slack: a fan gap is exactly the failure of coverage at level k−1 (`exists_fanGap_iff_not_coverAtLeast`),
  and one gap in a target colouring frees every pair above it (row 66).
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
  acceptance test is also necessary. Point every new instrument at a known positive before believing its zero;
  assert on the written artifact, never on the list that produced it; a control the instrument cannot see is
  not a control. **And where a phase's output is eliminations, its defects all point one way**: four in one phase
  (M63 phase G, 2026-09-11) — an edge law that drops an edge, an over-merged equivalence key, a float sign test inside
  an exact verdict, a truncated input with no producer — every one silent and every one biased toward making the
  survey look productive, because a missing edge yields an easier graph, a colouring, and a "sound elimination". So
  an elimination carries an exact quantifier or it is not one, and where a phase also has a positive product, **the
  count of eliminations is the outcome to be least satisfied with**. **The mechanism is selection**: a defect whose
  result displeases is investigated within the hour; one whose result pleases is kept — five independent defects in
  three phases of M63 were every one flattering. **Audit the results you like at the same rate as the ones you do
  not**, and when an artifact and its written record disagree, suspect the newest thing in the file first.
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
  five-colour gadget exists (row 55): the gadgets' field must be 6-open. With `[ExooIsmailescu2019]`'s 426-vertex {1, 2}
  graph as host, one five-colour virtual edge at distance 2 gives χ(ℝ²) ≥ 6 (GPT Astra, G55) — M49's descent replaced its 892
  length-2 edges one at a time; the ρ₆₃ arena has none (H4's sweep).
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
* **G31 — No unit-distance object we hold, built or found, carries a pair compulsion at its top rung. [kernel on the
  sealed objects (row 66) and for the 1581's arity bracket; measured, complete at arity 2, on the 6-open ones]** **On
  sealed objects the arity-2 emptiness is a theorem**: Heule-510's `Forces ↔ =` and `Separated ↔ Adj` at five colours
  and its arity floor ≥ 3 are kernel, and hold for every unit-distance graph over any 5-sealed multiquadratic field
  ⊇ ℚ(√3,√11), because the sealing plane's fan gap frees every pair above it. **On 6-open objects it stays a
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
  5-colourable.
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
  break). The wall is broken iff 1/2 lies in the unit-vector ring ℤ[U] (GPT Astra's prime inversion, G55). **Gate:** the field-level statement needs only that a number field with a conjugation-fixed prime
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
  ℚ(√3,√5,√7,√11) (ℚ-span rank **16 of 16** over `tools/degrey_cert.json`; √7 enters by the rotations through
  π/2 ± arcsin(1/8)); Frobenius at 11 is trivial on √5 and nontrivial on √7, so the residue field is 𝔽₁₂₁ and
  **no prime below 131 is usable** (`tools/fplane.py`, `data/fplane/map.md`, since M58). **Row 52 is about the
  proper subfield ℚ(√3,√5,√11)**, never about de Grey's field. The 5-sealed witnesses are Heule-510/553 —
  ℚ-span rank **8**, ℚ(√3,√5,√11), no √7 — where row 52's bound is exactly tight against
  `chromaticNumber_heule510` = 5. Moorhouse §9's bar on a composite ideal beating the best prime rests on
  Hedetniemi's conjecture, which `[Shitov2019]` refuted, so it is not a bar (FS-42). The shadow sieve: an object's direction residues seal every graph built from
  those directions.
* **G44 — Kloosterman control. [derived + measured; ω facts prior art]** UD(𝔽_p, 2) has eigenvalues
  −K(1, c/4), so Weil and Hoffman force χ > 5 from p = 59 and χ > 6 from p = 103 (exact spectra; 71 as well), and at 83 six is
  refused by the exact certificate (row 68) — the window between is G56's: small planes are SAT questions,
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
  **And read the construction's own data layout, not only the plan's vocabulary for it** (2026-09-12): the result that
  closed M63's rotation screen came from four lines of `Arena.__init__` — the rotated half carries the same index set and
  internal edge list as the original — a mathematical fact the plan's vocabulary had no word for. When a plan and an
  implementation describe the same object, the implementation is the one that cannot round off.
* **G47 — The compulsion face of sealing, at level one. [kernel; subsumed by row 66]** Compulsions map forward along
  homomorphisms; on a Cayley graph a forced pair needs a period of every colouring. The distance law this entry
  carried — over a field where 11 is usable, forced at five colours ⟹ 11 ∣ d² and virtual edge ⟹ d² ≡ 1 (mod 11)
  — is now the level-one shadow of the fan-gap theorem: over every such field `Forces ↔ =` and
  `Separated ↔ Adj`, so a
  five-colour forced pair is a single vertex and a virtual edge a unit edge at every distance, and the
  residue-allowed distances name nothing. Unchanged: no finite plane at p ≡ 3 (mod 4) has a
  forced pair at a colour count it admits (row 60), and at 11 its virtual edges are exactly its edges (kernel;
  measured at 3, 7, 19; prime fields only).
* **G48 — The tightness mechanism, and the six-level question answered no over sealed fields. [kernel]** Over a field
  sealed at k by a usable prime 𝔭 whose plane is k-colourable, a pair forced equal at k colours has 𝔭 ∣ d², its
  spindle adjoins √(4d² − 1) ≡ √−1 (mod 𝔭), and every prime above p stops being usable: the forcer deletes
  exactly the local bound it beats (the Moser spindle's √11 removes 3; √15 and √247 remove 2). So the six-level
  was one question — does a 5-sealed field carry a pair forced equal at five colours, necessarily at 11 ∣ d²? —
  **answered NO by row 66** over every 5-sealed multiquadratic field ⊇ ℚ(√3,√11) (11 usable of residue degree
  one there, and slack): the only pairs forced equal at five colours are single vertices, so
  the mechanism has **no instance**, FS-6 is dead by theorem, and a 6-forcer's every compulsion lives in a 6-open
  field, where no residue plane is five-colourable and this mechanism is silent. The spindle identity stands as
  the reason 6-openness is forced on any 6-forcer, not as a route to one. The first digit (is any finite plane
  exactly 6-chromatic) is decoupled and integrality-carried. **The conjecture the mechanism was minted to serve**
  (FS-15): *χ(F²) equals its best local bound wherever that bound is ≤ 6* — attained at all six fields where χ is
  known — whose **bold form is χ(ℝ²) = 7**. It **loses its constructive route** (a forced pair spindled into
  6-openness) and keeps its predictions: UD(𝔽₈₃,2) is not six-colourable (row 68), so under it **χ(K(√7)²) = 7**
  — the boldest prediction, pinned to the field the ρ₆₃ arena was built in — and de Grey's field, all of whose usable primes have spectral floor ≥ 8, is 7 outright (FS-40, closed with FS-50).
  **Proved range** (GPT Astra, G55): L ≤ 3 for every real number field; L ≤ 4 for every field containing √3; L ≤ 5 for every
  multiquadratic F ⊇ K given the 8/3 forcer; L(F) is the sharp form — the residue graph's chromatic number, 2 at ℚ(√5) where |κ|
  reads 4. *Falsifiers: a field with χ(F²) < min(7, L(F)) — cheapest a four-colouring of ℚ(√11)² or ℚ(√23)² (L = 4), local at no
  prime and non-additive (FS-46); a wall-broken, 5-sealed field whose plane is 4-colourable by a colouring local at no prime; for
  the six-question, a 5-colourable, 5-tight Cayley quotient of a 6-open plane (FS-42).*
* **G49 — The prior-art gate. [method, measured]** Recognition is half the rule; the other half is a search
  at the milestone's opening (WORKFLOW step 3a): in the discipline's words, never ours; under two disciplines;
  for the question as well as the method; outside arXiv. Past misses came from checking at the close,
  searching coined vocabulary, and searching one literature when the object sat in two. The field-plane
  reduction was derived independently at least six times, and the Polymath16 corpus (2018–2026) poses
  Theorem B's question while citing Fischer, Moorhouse and Vinh zero times. **And the two-database cross-check has a
  failure mode that looks exactly like agreement** (2026-09-12): two citation databases both returned **zero** citing
  works for the survey that would have settled whether our object was known — both carried the same upstream
  identifier and both were the *preprint*, while one held the **published** chapter separately, with four citing
  works. **A zero from two databases sharing a source is one database's zero**: compare identifiers and versions,
  not counts, and open the citing lists; run that way it surfaced a 2007 paper counting sums of two squares over a
  **real quadratic** base.
* **G50 — Read what the search found. [method]** A held-but-unread paper, or a bibliography title whose guess
  touches a live milestone, blocks that milestone's opening until scanned. An abstract is not a reading. Walk
  the citation graph of the paper that *posed* the question; cross-check citations in two databases; mine
  every read paper's references into the bibliography the same day; mark reading per section.
* **G52 — Breaking the wall is necessary and visibly not sufficient; the equal-radius family is the mechanism. [measured +
  reading, one instance with a positive control]** A wall-breaking rotation can still be four-colourable: breaking the wall is a
  property of the field the rotated copy lives in, while the residue colouring reads the base points, which never leave the
  original field. The rotation escapes the colouring only through one family — cross edges joining two base points the colouring
  gives the same colour, which requires the base to realise a specific radius sum, via `d² = σ − (σ−1)/cos θ`. Measured on M63
  phase G's rotation: it breaks the wall and dies because `[Parts2020a]`'s lattice cannot realise the live radius sum (no
  solution, against 30 at his own angle) — a fact about that lattice, not that angle. Inverted, a design target: the cosine
  names the live radius sums before any base exists; one free prime kills. Necessary is proved; sufficient is untested, the
  record's rotation the only positive instance. **The apparent filter is free where the circle is free**: with the circle `t ×`
  the unit shell for an integer `t`, the certificate's defeat is automatic for even `t` (`φ` lands in a characteristic-2 residue
  field, so every circle point carries the centre's residue), and the record has `t = 2`; so "this object defeats the residue
  certificate" is not evidence about the object, and the live quantity is the **off-diagonal** share of monochromatic cross
  edges (the record 0 of 30, `ρ₆₃` 24 of 54). `|p|² = n` is free iff `n = k²·m` with `m` a squared distance the lattice already
  realises (4, 16, 12 free; 2 not).
* **G53 — The counting compulsion, and the refutation criterion it defines. [derived; one provisional measurement]** For a
  type-M arena — base `B` plus its rotated copy sharing the centre, joined by cross edges — any proper `k`-colouring `C` yields two
  proper `k`-colourings of `B` alone, `f(v) = C(v)` and `g(v) = C(Rv)` (G46). The shared centre forces `f(0) = g(0)` and each
  **diagonal** cross edge forces `f(v) ≠ g(v)`, so with `B(h) = {circle v : h(v) = h(0)}` the sets `B(f)`, `B(g)` are disjoint,
  and with `L = min_h |B(h)|` over proper `k`-colourings of the base, **`2L > (circle count)` ⟹ the arena is not `k`-colourable**
  — a property of the base alone, no arena solve; sufficient, never necessary. A **counting** compulsion, a shape the vocabulary
  lacked — "at least `L` of these `n` points share one designated point's colour" — with a forced pair as `L = count`; it explains
  why both fail on `ρ₆₃`, where `L/count = 10/30` (provisional) and no circle point is forced. **The design target — maximise
  `L / (circle count)`, refute above `1/2` — is the first objective in M63 phase H2 that a free construction cannot supply**, the
  circle count and the residue certificate's defeat both being free (G52).
* **G54 — Tight or slack: a residue plane's compulsions at k colours are classified by one sign. [kernel one
  way; derived the other; the table computed]** Let `P` be the level-one plane at a usable prime, `d` its degree,
  `λ_min` its least eigenvalue, `k` the colour count. **Slack** (`λ_min < −d/(k−1)`; Hoffman's α-bound exceeds
  n/k): gaps are permitted, and where one exists — found at 7, 11, 19; 23 and 83 slack by the spectrum with no
  colouring asked — **gap ⟹ free** is kernel (row 66). **Tight** (`λ_min = −d/(k−1)`, the literature's Hoffman
  colorability): every k-colouring is balanced, gap-free and periodic under the common kernel of the minimising
  characters, so **tight ⟹ forced by `H_min` ∧ gap-free** is derived (Theorem D2-A; balance and gap-freedom are
  Blokhuis–Brouwer–Haemers's, the periodicity ours). The middle case — slack but gap-free — is logically open and
  unobserved (at 11 no 5-colouring has every vertex gapped, on two engines). Both properties **propagate up a tower**
  whose level maps carry `S_{m+1}` onto `S_m` with constant fibres (`λ_min/d` is non-increasing under pullback),
  which is why the 2-adic tower is tight and the 11-adic tower slack at every level. The table: tight at 3 (k = 3;
  the rhombus forces, row 58) and at 2 (k = 4; forced from level 5, row 67); slack at 7 (k = 4) and at 11, 19, 23
  (k = 5) and 83 (k = 6); by Weil, tightness at k needs `(p+1)/(k−1) ≤ 2√p`, so no usable prime above 3 in the
  committed table is tight for any k ≤ 7 (p = 31 misses 4-tightness by 4.4·10⁻⁵). **What it says about six:** the
  residue mechanism forces pairs only where the plane is tight, and no plane that seals a field at five is — so the
  only residue route left to a five-colour forced pair is a **quotient** of a 6-open plane that is 5-colourable and
  5-tight (FS-42, a reading with its falsifier). The screen is a character sum, seconds per (field, k), and no
  substitute for FS-17's ask.
* **G55 — The unit-vector ring decides the walls, and the chain replaces the spindle. [hand, GPT Astra (OpenAI,
  2026-09-14, in conversation with Kooshi); read here and found sound; the identities verified twice in exact arithmetic —
  `reference/ChatGPT-local-global-tightness-conjecture/VERIFICATION.md`; every result below is a kernel target, FS-45–48 (Kooshi, 2026-09-14)]** Let R = ℤ[U] be the ring the unit vectors of F(i)
  generate (M56's Σ₀). **Prime inversion:** 1/p ∈ R iff no conjugation-stable prime of F(i) lies above p (by lying-over) — M56 L7's conjecture, proved; so "the 2-adic wall is
  broken" is "1/2 ∈ R". **The chain theorem:** a finite graph over F forcing two points at difference δ equal at k colours makes
  every k-colouring of F² periodic under the ideal δR (transport by every isometry z ↦ t + u(z − a)); if 1/δ = u₁ + ⋯ + u_m is a
  sum of unit vectors, 1 is a period and χ(F²) > k, witnessed by m chained copies plus one closing edge, at most m(n − 1) + 1
  vertices, **in F itself** — the spindle is m = 2, which is why its threshold is d ≥ 1/2 and its field F(√(4d² − 1)) (row 44).
  **Consequences.** χ(F²) = 2 ⟺ L(F) = 2 for every real number field (walk parity is a ring homomorphism R → 𝔽₂). For √3 ∈ F: χ(F²) = 3 ⟺ some prime has residue field 𝔽₃ ⟺ L(F) = 3
  (every three-colouring is 3R-periodic by the rhombus and descends to Cay(R/3R, H), which contains the product of the planes
  at the stable primes above 3; `[ElZaharSauer1985]` and the Weil floor leave q = 3), so
  the conjecture holds for L ≤ 4 there; the same argument cannot run at four colours, where Hedetniemi already fails
  (`[Tardif2022]`, unchecked). Given M56's measured 8/3 forcer over K = ℚ(√3,√11) (588 vertices, one solver refusal): every wall-broken real F ⊇ K has χ(F²) ≥ 5 (3/8 = 3·(1/2)³ ∈ R) — wall-broken is
  *sufficient* for five over K where G35 had it necessary — and every multiquadratic F ⊇ K with L ≤ 5 has χ(F²) = L(F); over
  K(√7), w = (−3 + i√7)/4 has w³ + w̄³ − 3w² − 3w̄² = 3/8, so eight copies plus an edge, at most 4,697 vertices, need five colours
  by hand, against the ρ₆₃ arena's 51,133 by solver (FS-45 puts it in the kernel). An 18-vertex, 33-edge graph over ℚ(√2,√3)
  (six chained rhombi) is four-chromatic with no Moser spindle in its field, and χ(ℚ(√2,√3)²) = 4. **On six:** one five-colour virtual edge at distance 2 over any F ⊇ K, transported onto the 892
  length-2 edges of `[ExooIsmailescu2019]`'s {1, 2} graph, is a six-chromatic unit-distance graph (the sentence is the advisor's;
  M49–M50 replaced those edges one at a time); its field must be 6-open (row 66), and the arena has no such pair. What the chain cannot do is produce the five-forcer it needs.
* **G56 — The window for six, and reciprocity's exclusion of it. [derived: exact spectra and the 83 certificate; the
  exclusion is elementary and script-verified; the consequence for χ(ℝ²) rides on the conjecture's bold form and on FS-39's
  bridge, which is `[Madore2015]` ¶5.4 plus de Bruijn–Erdős]** Six colours on UD(𝔽_q, 2) need an independent set of ⌈q²/6⌉,
  which the ratio bound permits only while 5|λ_min| ≥ q + 1: by Weil that fails from q = 98, the exact spectrum already fails
  it at 71, and 83 — the last prime where six was spectrally possible — refuses it by certificate (row 68). Five is refused from
  59 up. Over the residue fields a number field can have (𝔽_q, q ≡ 3 (mod 4), odd degree), **a plane with χ exactly 6 can live
  only at q ∈ {23, 27, 31, 43, 47, 59, 67, 79}** — floors 5 at the first five and 6 at the last three; ceilings 8, 7, 8, 8, 10,
  10, 12 by verified colourings (`data/fplane/periodic-below-71.json`, `data/fs53/`); none decided: five is CDCL-undecided or
  spectrally refused at every one, and no six-colouring was found by local search (23, 31, 43, 47) or by the subgroup-periodic
  sweep at 27 (exhaustive at indices 9 and 27). A prime is usable for a field only if the field's radicands are all squares in
  its residue field, and **every field this project has built in contains ℚ(√3,√11)**: 3 is a non-square modulo 31, 43, 67,
  79 and 11 modulo 23, 47, 59, 71, and at 27 the residue 11 ≡ −1 (mod 3) is a non-square in every 𝔽_q with q ≡ 3 (mod 4); so
  such a field's usable primes are 11 and then nothing below 83, its local bound is 5 or ≥ 7, and **six is arithmetically
  excluded for all of them**. A six-chromatic number field, if one exists, contains no √11 and none of the known five-forcers
  — ℚ(√2,√3,√31) sees only 23, ℚ(√2,√3,√7) only 47, ℚ(√3, α) with α³ = α + 1 sees 27 — and its five-chromaticity is itself
  open. **What the window decides is whether six is reachable by the residue method at all**, since χ(ℝ²) = sup_F χ(F²): no
  six-chromatic window plane ⟹ no field has local bound 6 ⟹ every field holding a six-chromatic unit-distance graph has all
  its usable planes at ≥ 7, so the finite planes can never pin six — and under the bold form of the conjecture (χ(F²) = 7
  wherever L(F) ≥ 7) χ(ℝ²) = 7, with six a value no field attains though every seven-chromatic graph passes through it; one
  six-chromatic plane ⟹ a field with χ(F²) ≤ 6 by theorem, predicted 6, a finite six-chromatic graph by compactness. Every
  window plane is slack at six — at 23, 27, 31, 43, 47, 67 by divisibility (Hoffman-tightness at k needs (k−1) | (q+1), and
  5 ∤ q + 1), at 59 and 79 by the exact spectrum — so over a field it seals the residue mechanism forces no pair (G54): a
  six-forcer there is built, not transported. The registered reading is **χ = ⌈q²/α⌉ at every plane** (true at 3 and 11,
  consistent at 7 and 19; it replaces the "+1 over the spectral floor" reading, which fails at the Hoffman-tight q = 3), under
  which α decides χ: the calibrated searcher's plateau α(23) = 87 against the 89 six needs is the advisor's 2:1 bet that 23 is
  empty, and FS-53 scores it. *Killing test of the exclusion: a usable window member for some field containing ℚ(√3,√11) —
  impossible by reciprocity; of the reading: a decided plane with χ ≠ ⌈q²/α⌉.*
* **G51 — A competitor and an advisor beat one mind. [measured, one session]** A friendly competitor on the
  same problem plus an advisor (Poros, `~/source/poros`) advising both caught errors one agent missed, and
  two independent attempts hitting one wall licensed an impossibility theorem (row 58). Design: isolate each
  agent's scratchpad (a shared temp directory is a covert channel), brief both identically, give the advisor
  the record and a written expectation, rule prior art shared. Records: `plans/COXETER-2026-09-08-mascot.md`,
  `plans/POROS-2026-09-08-mascot.md`. **The mechanism is not carefulness — it is a COST WINDOW** (2026-09-12): in
  one phase three agents exchanged about twenty messages, eight constructions or registrations were retracted, and
  the final plan contains none of those errors — **every retraction was free** (nothing committed, no solver time
  paid, nothing claimed to a third party). **Fast public error is the cheapest instrument available, but only while
  retraction is free, and in that window it should be spent rather than rationed**; once retraction is expensive the
  same speed produces escalation. **Front-load the disagreement into the window before anything is paid for**, and
  **count the retractions in it: zero is not agreement, it means the disagreement has not started yet and will
  arrive later at full price.**

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
- **Write the certificate for the REVIEWER early — it is an instrument, not a chore, and it tells you which of your
  evidence is load-bearing.** Measured 2026-09-12: an agent building the reviewer-facing bundle for a refutation noticed,
  only while writing it, that its 552 exhibited colourings were **not load-bearing at all** — the argument needed its
  pattern list to be a *superset* of the achievable patterns, never a set of achievable ones — which retired a third of
  its evidence and shrank the solver-dependent core from one claim about a 51,133-vertex object to **twenty claims about
  25,567-vertex halves**. **The question that did the work is cheap and repeatable: *what must someone who trusts none of
  this actually check?*** Ask it while the evidence is still being gathered.
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

**A GPU is not a SAT accelerator.** CDCL is pointer-chasing unit propagation and GPU SAT solvers have historically lost to
good CPU solvers; do not plan around one until a *measured* bottleneck is something a GPU is actually good at.

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
current audit reads 966 clean and 5 declared purchases, each listed in `ARCHITECTURE.md` § Trust. Rung B
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

**`lean4checker` is a publication gate, not a milestone gate** (Kooshi, 2026-08-02): the build-time kernel is the trust
anchor; the independent replay is single-threaded and RAM-heavy, so run it once, on hardware other than the desktop, before
any external claim of new mathematics — never as routine. It cannot re-check a native purchase (a purchase is an axiom, and
every kernel accepts axioms), so "replayed through an independent kernel" covers the kernel-checked part only.

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
`forkserver`, not `fork` (measured: 3.14.6), so a worker **re-imports the module** instead of inheriting the
parent's memory, and state a parent leaves in a module-level global is **empty in the worker** — the symptom is
a `KeyError` on a key the parent plainly holds, nowhere near the process model. Pass
`mp_context=multiprocessing.get_context("fork")` (safe with no threads), or give the pool an `initializer` that
rebuilds the state from picklable arguments, which also survives a platform without `fork`.

**Two machines.** A desktop and a laptop (12 cores, 31 GB). The desktop has **16
PHYSICAL cores, 32 threads** (2 per core), 64 MiB L3 in two instances, 128 GB RAM — `nproc` says **32** and
that is the *thread* count. 32-way solving showed no *large* contention penalty (**12.6 cubes/min** against ~8 at sixteen workers), but per-cube times at
ONE width vary as much as any width effect (105.1 s and 129.2 s at 32-way, 126.6 s at 16-way), so **the width effect is not
distinguishable from run-to-run variation in this data**.

**Keep a PREDICTED throughput beside the measured one and reconcile them whenever they disagree**: a prediction that can be
divided back out of a rate is a population check that runs itself (it caught a before/after comparison over two cube ranges
of different difficulty — the cost model failed an arithmetic check). **Say physical cores when sizing memory-hungry work**; `nproc` disagreeing with a plan is the
hardware moving — **ask which machine before treating a core or memory count as fact**, and ask to swap to the
desktop when a step wants it (the SAT solving does). Timings compare only within one machine: per-operation
ratios carry across, wall-clock totals and safe job counts do not. Measure in **CPU seconds (user + sys),
minimum of three runs**, and name the machine beside any number.

### Building

**ALWAYS build through `./scripts/build.sh` — never `lake build`, bare *or named*. No exceptions.** Lake 5.0.0 has no `-j`
and sizes its job pool from the machine; data modules here peak at ~9 GB each and certificate segments at 3.4 GB + 0.81 GB
per chunk, so an unrestricted build asks for hundreds of gigabytes (it took the desktop down twice on 2026-07-30), and a
*named* target silently queues every missing or stale dependency into the same pool (on 2026-08-02 a one-module build queued
four 22 GB certificate rebuilds behind a 20 GB cap, the OOM killer ate them twice, and a grep-piped invocation read as a
pass; the loophole cost hours). `scripts/build.sh` builds every module in dependency order (`scripts/build_order.py`), leaves
first, in explicitly named batches (`BATCH`, default 10), each under a `systemd-run` memory cap (`MEMMAX`, default 100G);
`--plan` prints the batches and builds nothing. It first asks Lake once, under the same cap, whether any module is out of
date (`lake build --no-build`, about 2 s against about 3 min for the walk); only exit 0 skips the walk, so the check can cost
time but never skip a build.

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

**Every long-running phase checkpoints and resumes exactly** (Kooshi, 2026-08-26). **[PROTECTED — never compress, trim or
paraphrase this paragraph; rewrite it only to add an instance (Kooshi, 2026-09-15).]** A run expected to exceed ~15 minutes
persists its progress at natural acceptance points (a verdict, a wave, an accepted deletion, a solver's iterate) and resumes
from that state after a kill; a long phase whose state lives only in a process's memory is a **bug, not a style choice** —
on this hardware it is a bet against a demonstrated crash rate. The audit question at every phase design: *if this process
dies at any instant, what does the relaunch redo?* — and the answer is written in the subplan, beside the checkpoint's path
and the **resume command**, never discovered at the loss; a checkpoint nobody knows how to resume from is a file, not a
recovery. The instances, each a clause of the rule:
1. **The incident that minted it.** M51's iteration-3 halo shrink ran 19 hours with its state only in the parent (the cover
   checkpointed per wave; the shrink saved only on completion); one worker died, the pool's `map` hung forever, and the
   whole shrink was lost (M51 §R-INC5).
2. **The checkpoint must not live where another agent is told to clean.** `build/` is regenerable scratch, and an agent
   tidying up after itself deleted a tree under it on 2026-09-11 while a live job's only resume file sat in a sibling
   directory (`build/m63d2/ckpt-hismove/`). Recoverable state one cleanup away from unrecoverable is not recoverable:
   checkpoints live outside the scratch tree.
3. **A wall is not a checkpoint, and a tool that cannot be interrupted is not a tool for a long run** (2026-09-15, FS-50).
   Three semidefinite solves at 83 — 7.5 h, 4 h, and an implementer's 3 h 51 m — ran under `timeout` walls with the
   solver's iterate in memory only, because the solver's off-the-shelf interface neither checkpoints nor resumes; the walls
   fired or were about to, and **killing a `timeout` wrapper to lift its wall kills the child too** (GNU timeout 9.11 arms
   `PR_SET_PDEATHSIG`; tested on `sleep`), so all three were lost with nothing on disk. The rule was in this file
   the whole time; the runs were launched without asking its question. The repair: drive the solver through its own API in
   warm-started chunks, the iterate saved after every chunk and one residual line per chunk (`tools/fplane_sdp_scs.py`),
   never under a wall — and a process-model claim is tested on `sleep` before it is acted on or sent to anyone.

**A run that blocks something is presumed killable** (Kooshi, 2026-09-12). **[PROTECTED — never compress, trim or
paraphrase this paragraph; rewrite it only to add an instance (Kooshi, 2026-09-15).]** When a live job stands in the way
of anything — an edit to a module it imports, a core another task needs, a fix it would invalidate — weigh
**the value of the run against the value of what it blocks, and the default is to kill the run.** The burden
of proof is on keeping it, never on stopping it. Because every long run checkpoints (above), **the cost of
being wrong is the time to redo, never the result** — so weigh the cost of being wrong, not the hours
already spent. Three shapes met in one night, each of which looked like a reason to wait and was not:
- **The run is blocking its own replacement.** Two reductions spent hours on an operation a new engine did
  186× faster, and `tools/` could not be edited while they held it open — so "wait for them to finish" made
  the slow path self-perpetuating. Look for that circularity by name: *is the thing I am waiting on the
  thing preventing the fix?* **Second instance, 2026-09-15 (FS-50), and this rule was on this page in full when it
  happened:** four single-threaded semidefinite solves at 83, 3.4 s per iteration and a day to convergence, were kept
  running while the timing of their replacement ran niced beside them — a threaded and a GPU linear-system backend of the
  same solver, selectable the whole time by one keyword (`linear_solver=`) that had been misread the day before as
  "unavailable in this wheel" because the wrong keyword was tried — and the product owner wrote "nothing else is runnable
  until the measurements land". **Measuring the replacement is not a precondition for stopping the run**: with
  checkpoints the redo is minutes on the fast path, so the runs are killed at their next checkpoint and relaunched on
  whatever the measurement names; the two with no checkpoint on disk yet forfeited about 1,800 and 550 iterations of a
  reading the surviving run's chunk lines already gave. The shape to recognise: *the measurement I am waiting on is the
  measurement of the thing that replaces what I am protecting.*
- **The run is producing records under code you are about to fix.** Finishing banks results from the broken
  version and forces the redo anyway — and those records are the ones a later reader trusts.
- **The fix makes the redo cheaper than the run being protected.** Then waiting costs twice.

Two obligations when you do it. **Capture the run's state into the record before signalling** — a verdict
written only at `finish()` is lost, and the log is not the record. And **name what the kill forfeits, out
loud**: one such kill cost a registered out-of-sample prediction, and a forfeited instrument must not
disappear quietly merely because the decision was otherwise right.

**Kill by PID or process group, never by matching a command line.** `pkill -f <pattern>` matches the shell that runs it
and every other process whose command line mentions the pattern — including another agent's monitor. Sixth recorded
instance 2026-09-13 (FS-38 phase T): it killed the engineer's own level-7 run at 11,000 of 16,383 asks and the advisor's
watcher in the same second. `setsid` the job, write its pgid to a file, signal that. **And the pid you hold may not be
the process you mean** (2026-09-15, FS-53 A0.3): `nohup <binary> … &` followed by `$!` reports an intermediate **shell**
in this harness, not the binary — reproduced deliberately on `sleep`, where `$!` read 3469129 and the binary was its
child 3469131. Killing that pid leaves the binary running, re-parented, still writing its `--out`; the engineer found it
only because `git status` showed a **committed** artifact modified after the commit. **A kill is verified by what stopped
changing, never by the exit status of the kill**: after signalling, confirm by effect — no process of that name in `ps`,
and the file's digest identical across ten seconds.

**A pipe can kill the producer, and `| tail` can hide that it did.** Same session: a mutation harness run as
`./plant.sh … | head -6` died of `SIGPIPE` when `head` closed the pipe — **before its `git checkout` restore** — leaving
a planted fault in the tree, and the verification that should have caught it was `cargo nextest run | tail -2`, whose
exit status is `tail`'s and therefore always zero. The plant reached a commit. Two rules, both already here in other
costumes: a command whose *cleanup* matters is never piped into `head`, and a gate's exit status is read from the gate,
never through a pipeline (`set -o pipefail`, or capture to a file and read it).

**Never edit a shell script while it is running.** Bash reads a script lazily, by byte offset, so a live process resumes
mid-token — it killed a 46-minute `lean4checker` run at M07 with `line 110: ull-library: command not found`, a message that
looks like corruption and is nothing of the kind. Launch long runs from a snapshot copy (`cp scripts/x.sh
build/x-snapshot.sh`; `build/` is gitignored).

**Generated modules and invalidation.** For work split across independent modules the wall clock depends only on the
job count, not the piece size, so smaller pieces are free concurrency. Lake takes a module's own trace from its source and
its dependents' traces from the resulting `.olean` (measured at M11 — not what the rule used to say, and ignoring the
corollary cost 28 hours of processor time at M07; doc comments are queryable data and therefore part of the artifact,
`--` comments are not):

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
- **A `∀ x ∈ l, P x` under `decide` costs an order of magnitude more than the same check as a `Bool`.** Measured
  (FS-38 K3): `∀ e ∈ (778 pairs), e.1 ≠ e.2` on a bare import cost 31.9 GB and timed out; `l.all f = true` on the real
  predicate cost 3.5 GB and 5 s. State list checks through `List.all` and recover the per-element form with
  `List.all_eq_true`.
- **A numeral at an unsimplified type index is paid per numeral, at elaboration, even in a definition with no
  proof.** A 48-point literal at `ZMod (2 ^ ((5 + 1) / 2))` cost 32.9 GB and a timeout; the same points at `ZMod 8` cost
  2.5 GB, and then a defeq wall on every access. Carry no literal at such a type; evaluate the form per element.
- **Feed the kernel the refutation's core, never the whole instance.** A certificate's clause table costs
  `agreesWithCNF` over the entire formula: 853 s at 33 GB for a 1,024-vertex instance whose proof reached 125 vertices;
  the core, extracted from the LRAT by backward reachability from the empty clause (861 of 99,335 clauses), proves the
  identical statement in 5.9 s (recipe: `Instances/TwoAdicFive/Edges.lean`).

### Searching

- **The regex engine.** `grep -E` on this machine is `ugrep`, and it silently under-matches alternation
  inside a repeated group: `^\s*(private |protected )*theorem` does not match `private theorem foo`. `rg` and `grep -P` match correctly.
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
  silent change in them is this gate's own failure mode (declarations are the library's; the audit's own are not counted): `declarations=6566 refutations-skipped=265
  sites=260`, `vacuous=0 stale=0 declared=3 witnessed=17 generic=238 unknown=2`. The baseline's two entries,
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
comparison of two purchase ledgers never actually performed; an audit that aborted under `set -e` with no output
and read as a pass through a pipe; a mutation rig that re-read a stale file and scored it as a pass; negative
controls the instrument could not see. A trust receipt that fails open is worse than none, because it is
believed. So make a check's failure path louder than its success path, never let a shell pipeline swallow an
exit status the gate depends on, and give every discriminating claim a partner that goes red — a certificate
filed against the wrong problem, a vertex moved off the unit circle, a satisfiable formula handed to the checker.

**The unifying rule, from nine instruments that broke inside one phase** (M63 phase C, 2026-09-11; eight
failed by silence, one by false alarm): **every check needs a positive signal for the thing that did not
happen.** A wall that could not fire, an exception swallowed in a timer thread, a control asking the same
question twice, a pid file catching a wrapper twice, a silent forty-minute search, a control announcing a
refutation from an index mismatch, a trust receipt returning a benign verdict while checking nothing, a `grep`
that killed its own shell, a four-hour deadline armed as an exit-waiter — each quiet exactly when it had
something to report, because each reacted to an event instead of asserting an absence, and **an exit-waiter can
tell you a thing has ended, never that it is late.**

**A waiter whose success condition is a file that a GOOD outcome prevents from existing** (2026-09-12). A
sweep dumped its residual-candidate file only when the survivor list was non-empty; the count reached zero, the
file never appeared, and every waiter on it read like a hung run. Its sibling monitor had the same defect in the
other costume — a `pgrep -f` liveness check that matched its own command line, so the process-gone branch could
never fire. **Arm a waiter on a file the SUCCESS path always writes**, even if that file says "nothing found".

**And the rule the one above does not reach: state the uninformative outcome and confirm it is REACHABLE,
before believing a control's pass or proposing a discriminator.** "Break it and watch it go red" assumes the
break can fire. Twice in one evening it could not (M63 phase E, 2026-09-11), the same error with opposite
signs: a planted fault that could never fire (a target loosened in the direction the search ignores) and a
discriminator that could never discriminate (two attributions it could not separate). Both passed review; both
were found by opening the module. **A control whose failure mode is unreachable has not been tested by
passing** — it is indistinguishable from one that works. The paired form, measured the same evening: seven
errors between two readers, four the engineer's and three the advisor's, every one found by reading code rather
than by arguing, because each asked the right question of the other's instrument and never of their own.

**Pre-decide how you will respond to your own gate failing — before it fails, on someone else's number.**
Measured 2026-09-11: an engineer's pre-registered comparator went red on its own integration, and the honest
diagnosis was exactly the one a motivated person would reach for. It did not widen the comparator, because it
had already reasoned one commit earlier, on a different planted fault, that **a check you tune until it agrees
with you has stopped being a check** — sequencing, not virtue, and cheap: settle the policy while the number
under dispute is not yours.

**And when you replace a broad instrument with a sharp one, you lose coverage you were not measuring.** A
whole-run wall-clock test was traded for a six-point component measurement that established a cost law's
*shape* by construction — strictly better on what it measures, and blind to any cost outside the component. A
second cost of the same shape, hiding in a progress log, was invisible to the sharp instrument and would have
been caught by the weak one. **State what the old instrument saw that the new one does not, at the moment you
swap them.**

**And when you put a measured number into a decision, carry what it MEASURES, never just its value.** Three
rulings in one night rested on a number measuring something adjacent: a per-*ask solve* rate used as a
per-*candidate* cost (wrong by 30×); a contended-wall timing used as a quiet-CPU cost (1.59×); a mid-window ratio
used as a completed-window one (16× against 7×). None was a wrong measurement, which is why none looked wrong.
**A number in a ruling travels with its units, its conditions and its population, or the ruling is about
something else**; the repair is to re-derive the decision from the corrected figure out loud.

**And the sharp, checkable form of that rule, extracted 2026-09-12 after the same error's FOURTH instance in
one milestone: when two numbers are compared, exactly ONE thing may differ between them.** A brief claimed a new
rotation gave *"twice the record's circle count and twice its unit-neighbour count"* — the doubling came from
dropping a coordinate restriction, and the unit shell does not depend on the rotation at all; a product owner
scored an off-diagonal raw count against `24/54`, a share of the monochromatic cross edges under one colouring — a
different denominator. **Both differed in two things and credited one, and the other thing was the change being
advocated, so the error flattered the work.** The check costs seconds: **write both numbers as fractions with the
denominators spelled out in words.** None of the four instances was a wrong measurement — each was a right
measurement of a different quantity, which is why none looked wrong to its author.

**The same rule has a second half, and its author broke it within two hours of writing it down.** Having
recorded *"state the uninformative outcome and confirm it is reachable"*, the product owner registered a
prediction (`P-Y1`, 2026-09-12) whose **informative** outcome was unreachable: a ratio band of 30–70% on a
quantity ~90% of which is produced in the *other* phase on byte-identical code, so a ratio near 1 was forced.
**Confirm that BOTH outcomes are reachable — the one that would teach you nothing and the one you predict.** And
the test of whether "mis-specified" is a diagnosis or an escape: **the evidence for the mis-specification must
predate the result** (here the 90% split was in the run's own numbers before the prediction). **The rule is
symmetric: a control going RED is not evidence either, until you can name what a wrong-reason red would look
like** — three plants in one night fired for the wrong reason, one on an out-of-range index that died before
reaching the guard it was written to test. The repair is a **pair**: the stub that must fail beside a faithful
stub that must pass, so the refusal is seen to come from the cause and not the scaffolding.

**A measured half and a derived half fail in OPPOSITE directions, and one rule cannot cover both.** Where a
graph's edges are *measured* — a float proposes, exact arithmetic decides — the only possible error is a
**missed** edge, which makes colouring easier, so **a refusal is robust and a colourable verdict is suspect**.
Where edges are *derived from a law*, the error is an **invented** edge, which makes refusals faster and cheaper
and looks exactly like success — so there **a refusal is the suspect verdict.** M63 phase G, 2026-09-12: a
ruling "believe a refusal immediately" from the measured half was applied to an arena whose novelty lived in the
derived half. **Before trusting either verdict, ask which half of the object produced it**; being built by the
law is the reason the law needs checking, not the reason it does not.

**A check must read the value the code SHIPS, never a copy of it.** A control certifying the safety margin of
a float gate asserted against a hardcoded `1e-7` rather than the gate's own default, so it would have kept
certifying that margin after someone made the real default lossy — **a check reporting about code that is not
the code that runs.** It now reads the default out of the signature, and every derived quantity with it.

**And the failure path's FORMATTING is part of the check.** The same control's message rendered a failing
ratio of 0.60 as `1×` — a display rounding turning a red into something that reads like a pass. **A check's
output is the check**, and the last transformation before a human sees it is inside the trust boundary.

**Bound a plant's effect on BOTH sides, and the control reports for free when it has gone blind.** A control
that can say *"I can no longer tell"* beats one that can only pass or fail — but the mechanism, not the outcome,
is what reproduces. Assert the two-sided form:

```
0 < (guarded_result − planted_result) < threshold
```

The lower bound fails when the plant has stopped firing; the upper when it fires too much. Measured 2026-09-12:
under a mutation that made the shipped value identical to the planted one, the difference collapsed to zero
and the lower bound caught it, where the one-sided `planted < guarded` would have gone silent about having
lost its power to discriminate.

**To compare POLICIES, replay them over a recorded decision sequence rather than re-running** (2026-09-12). A batch-size
lever estimated at ~2.9× measured **2.31×** when every policy was replayed over one pilot's own accept/reject log — one run,
one population, one thing differing — with the control that the replay reproduces the original run's exact cost; re-running
would have compared two populations and one policy at once.

**A cost measured on a FAILING run understates a succeeding one — and the tell is that the cheap steps are the failures**
(2026-09-12). A reduction walk was costed at **24% expensive probes** from a sample already fallen into the cheap satisfiable
regime, where each step answers in a millisecond because the object has stopped refusing; on a walk actually progressing it is
**~75%**.

> **A successful walk is the expensive walk.**

It inverts the intuition that a run going well is a run going fast, and it is how a pilot's cost model
understates the real thing by 3×. **Before costing an iterative process from a sample, check which
regime the sample's CHEAP steps were in**, because the cheap ones are the population that will not be there
when it works.

**A caveat you write and then step over is WORSE than one you never wrote** (2026-09-12). An advisor wrote *"this exhausts
the additive twist family, not the twist family"* and, in the same report, *"the 72 off-diagonal edges are measurably
load-bearing"* — the qualifier dropped, the headline amplified twice, a dead object kept alive a day. **The caveat is what
made the headline look audited**: after writing a scope qualifier, re-read the summary sentence against it.

**And the cheapest generator-image check there is: count your generator's free parameters against the
problem's.** A search ran over `{(C, π∘C)}` — one free parameter — where the solution space `{(f, g)}` has two; the image was
a measure-zero slice and the answer lived outside it, with the positive control passing. A parameter count is seconds and
catches the whole class.

**A TRUE explanation that fully accounts for the observation will stop you looking for a second one — and the second one may
be the one about your own apparatus** (2026-09-12). An engineer tested a theorem out of sample at `n = 3`, where its load-bearing
hypothesis `√(4n−1) ∉ K` fails by definition of the field (`4n−1 = 11`): the prediction was void, not met, and two laws "agreed
300 of 300" because both were inapplicable. Its first account — a mis-filed fact — was wrong in the flattering direction: `n = 3`
fails **two** gates, and a true, sufficient-sounding reason for the first (*"this member can never reach five colours"*) made the
member look **safe to compute on** — dead as an object, free as a test case — so it never asked whether a second gate also
failed. The first failure was about the member; the second was about its own instrument.

**The habit, and it is cheap: a candidate that fails one gate must be checked against ALL of them before
being used as a test case, precisely because the first failure makes it feel already understood.** And
re-read every hypothesis against the test instance immediately before believing an out-of-sample result,
which is exactly when the result is most wanted and least examined.

**And a mutation harness must verify its own RESTORE** (2026-09-12). One broke *itself* through CPython's bytecode cache,
whose identity for a source file is `(size, mtime in whole seconds)`: a same-size mutation written inside one second left the
interpreter executing mutated bytecode against a restored source — every plant "passing" while the arithmetic under test was
wrong. What caught it was the harness **re-running its controls after the restore and asserting the guarded state comes
back**. Restore, then re-verify.

**And mutate the CONSTANT, not only the logic.** Mutating a function's *default value* rather than its *body*
is what exposed a control asserting against a hardcoded copy of that value; nothing about reading the control
would have shown it. The cheap half of the lesson, and the one that finds checks pointed at the wrong code.

**Archiving a checker can break it in exactly the way it was built to detect.** A committed equivalence harness reconstructs its
"before" tree from git and imports a module by name — so the reconstructed module binds to **today's** copy of its dependency if
that reaches `sys.modules` first, and the comparison silently becomes one tree against itself **while printing ALL MATCH**. Assert
the provenance of every module a reconstruction loads, and **provoke that assertion** — pre-load the wrong version deliberately
and confirm the harness refuses. **The sharp form: a check that loads two versions of something and identifies them BY NAME** —
module caches, class registries, singletons, environment lookups, anything with a global namespace. Its finder declined the
credit: it had been forced to reason about module identity hours earlier, on a task that loaded two copies in one process —
**an instance found by prior context is not evidence that a rule reproduces**, which is the argument *for* writing it down: it
does not reproduce from care, only from the negative control being mandatory.

**Enumerate the PARAMETER first and screen the objects against it second, never the reverse** (2026-09-12). A census of
rotations was enumerated *over a base*, so a rotation whose circle is empty over that base never became a candidate and left
**no row to audit** — a family of 6-open rotations went unrecorded while the headline read "none". **An omission is worse
than a miscount**: a miscount is a wrong number in a row you can check. Sibling defect: an enumerator whose cut is one-sided
on a dense set has no well-defined answer, so its `span` parameter *is* the answer — the tell is totals that never converge
while the quantity of interest does. **When a generator takes a parameter, report the quantity at two values of it before
believing either.**

**A positive control proves an instrument finds things OF THE SHAPE ITS GENERATOR CAN REPRESENT, and says
nothing about shapes it excludes.** A sweep of 781,284 candidates returned a decisive zero for a new parameter and nine hits
for the known one, its positive control passing — the known witness *was* expressible in the generator's restricted shape and
the new one was not. **Before believing any zero over a family, write down the generator's image and check the target is
inside it.**

**Do not mistake a one-sided filter for an inverted monotonicity** (an advisor's correction of the product owner who wrote it).
Once a base contains the witness, growing it cannot recover the four-colouring — adding material makes a graph harder to colour
and a *sufficient condition for colourability* harder to fire, the same statement seen once directly and once through a
one-sided filter; nothing is inverted. An agent told to expect an inversion hunts one and misses what is unusual here: the filter
can be defeated by **breaking its applicability rather than its conclusion**, and a `not-applicable` returned on the same footing
as a silence is a pass nobody earned. **Whenever a one-sided filter judges something you are building, enumerate the ways to make
it inapplicable before the ways to make it fail.**

**And the honest account of where these rules come from: they are scars, not foresight.** The engineer whose control
docstring already said *"a control that passes without its failure mode being reachable has not been tested by passing"* had
written a control that could not fire earlier the same evening, and noticed only when it tried to plant a fault in it. **The
habit that produces the principle is planting faults routinely, not reasoning about controls carefully.**
