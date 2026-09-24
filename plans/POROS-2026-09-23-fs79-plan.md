# Poros — advising the FS-79 planner through its opening (2026-09-23)

*Scratch record; I am its only writer. It stays out of `plans/` until the competition ends (close inventory item 12). Held items are
NOT in this file's shared sections; they go only in §H of my final report to the owner.*

## 0. My expectation, written before any exchange with the planner

Read before writing: the brief; the FS-79 stub (in full); the handoff; the close inventory; `CLAUDE.md` G71, G72 (from the loaded
copy, minted today); WORKFLOW 3.3; `plans/FS73-derivation.md` T29, T30, T38, T39–T45 and §8; my two FS-73 records' retraction/error/
held sections; `BIBLIOGRAPHY.md`'s entries for `[Burr1984]`, `[AbrishamiEtAl2025]`, `[Chandgotia2017]`, `[ChandgotiaMarcus2018]`,
`[MooreNewman2000]`, `[AlonEtAl2021]`, `[CarrollPenland2015]`, `[Waite2026]`. **Not yet read:** FS-73 §R-close, Coxeter §6 and de
Bruijn's C3 file in full, the protocol §1/§3, LEDGER rows 78–79 in full. Anything below that rests on recall is marked so.

### 0.1 The question, said for a stranger (symbolic dynamics)

Fix a finitely generated free abelian group Λ ≅ ℤ^r and a finite symmetric S ⊂ Λ∖0. The **colouring shift**
X_k(S) = Hom(Cay(Λ,S), K_k) ⊂ [k]^Λ is a ℤ^r-SFT (forbidden patterns: `(0, s)` monochromatic). It is a hom-shift in the loose sense
(domain an arbitrary Cayley graph of ℤ^r, not the standard grid of `[ChandgotiaMarcus2018]`). The structural question: *what
invariant does every point of X_4(S) carry, and does the set of values realised decide X_4(S) ≠ ∅?* At k = 3 the answer (FS-73, T21–T24)
is the height's slope, realised values form a rational polytope `Θ₃(S)` on `Hom(Λ, ℝ/ℤ)`, and periodic points are dense.

### 0.2 Grokkings, rows and FS-73 theorems I expect to bear (provisional; the planner's §G is the authority)

- **G72** (the method) and **WORKFLOW 3.3**: this milestone is its first planned instance; the close counts it.
- **G71** (the no-go): `K₄`'s square complex is `ℝP²`; only a ℤ/2 winding in `Hom(R, ℤ/2)`; no height, slope or polytope. **Its scope
  is "squares only"**: it is a statement about the 2-cells a *general* abelian Cayley graph forces the target to fill. Where the domain's
  relators include triangles (any S with s₁ + s₂ = s₃, e.g. anything containing ζ₆-fabric), the target complex changes (Moore–Newman's
  and Baxter's heights live exactly there). I expect the plan to have to state which relator complex it means.
- **FS73-T29** (four colours: no linear criterion, `G(ℤ,{1,3,4,5})`), **T30** (rank-1 walls and the wall criterion; `P = F = 0` walls
  at `max D = 10`), **T38** (`F ⊆ F_μ ⊆ F_meas ⊆ F_clopen = P`; walls half vs recurrent half), **T22/T24** (what "complete invariant"
  meant at three colours: criterion + density), **T42** (the forward lift; torsion-freeness essential at three colours).
- **Rows 78–79**: the known positive (de Grey's lattice, `F = P = 8Λ`) and the target (`L21cc6506`, and ℚ(√167) at five).
- **G69/G65** (why a finite refutation is priced out at five: ~10⁷–10⁸ points); **G21** (a periodic screen measures its period cap —
  the phase-0 screen's typed-null clause); **G57** (ℚ(√167)'s graphs are triangle-free: so G71's squares-only complex is exactly the
  one that applies to the target — no triangle 2-cells to rescue a height there); **G62/G7** (the multilayer structure: the target's
  3-colour certificate was small because of the *point-group* structure `U = {1,v,v̄,z,z̄}·U_R`, which the abstract class discards).
- **G66** (`P = F_clopen`, the odometer), **G60** (the amenable-averaging engine), **G54/G38/G41** (linear/spectral instruments blind
  at 5–7; an invariant must be integral — G41's additive colourings are one-sided and are the "linear" part of any four-colour invariant).
- **G51 + the protocol** (the competition design); **G49/G50** (naming, the gate; FS-73's gate named hom-shifts and Chandgotia).
- **G70** (on K-fabric √3-clean ⟹ residue colouring): the known positive's rigidity has an arithmetic explanation; a "complete
  invariant" must reproduce it, which is FS-74's question.

### 0.3 Which disciplines own "an invariant of every four-colouring of an abelian Cayley graph", in their words

1. **Symbolic dynamics / tiling theory**: multidimensional SFTs, hom-shifts, the *domino problem* (Berger, Robinson), weak vs strong
   aperiodicity, periodic-point density, frozen/flexible, height functions (Chandgotia), block gluing (Gangloff–Hellouin de
   Menibus–Oprocha), the domino problem on groups (Aubrun, Barbieri, Jeandel, Bitar). *Recalled, not read:* a recent literature on the
   **"k-colouring problem" / colourings of Cayley graphs and the domino problem** — I believe someone has studied decidability of
   k-colourability of Cay(G, S) with S as input, for groups with undecidable domino problem. If it covers ℤ^r at k = 4, the milestone's
   (b) branch is a literature theorem. **Must be checked before the plan fixes its outcomes.**
2. **Computability**: `[Burr1984]` (periodic graphs, several vertex orbits, k ≥ 3: undecidable) against FS73-T22 (Cayley graphs of
   ℤ^r, k = 3: decidable). *The contrast is the most informative fact in hand*: the Cayley restriction is what made three colours
   decidable. Post's theorem makes "two-sided certificates ⟺ decidable" a tautology, so the content is not the equivalence but the
   mechanism.
3. **Statistical mechanics of zero-temperature antiferromagnetic Potts models**: height representations (Baxter; Kondev–Henley's
   vector heights for four-colouring models; `[MooreNewman2000]` for the four-state triangular AF), "ideal states", topological defects,
   the Kondev–Henley criterion for when a height exists. Vocabulary: *height mapping, ideal state, locking potential, vortex/defect,
   stiffness*.
4. **Algebraic topology / topological combinatorics**: Hom complexes, box and neighbourhood complexes (Lovász; Babson–Kozlov;
   Matoušek), obstruction theory (twisted coefficients: π₂(ℝP²) = ℤ with π₁ acting by −1), the "square complex" of the target
   (Chandgotia's universal-cover construction). Vocabulary: *obstruction cocycle, degree, equivariant index, covering space*.
5. **Descriptive / measurable / continuous combinatorics**: Gao–Jackson–Krohne–Seward's continuous combinatorics of ℤ^d actions
   (the twelve-tiles theorem, and — recalled, not read — an undecidability theorem for continuous equivariant maps into SFTs);
   Bernshteyn; Brandt et al. on LCL problems on grids (their undecidability of classifying LCLs on 2-D grids). T38 already links
   `P = F_clopen`.
6. **Graph homomorphism theory / CSP**: homomorphism duality, finite duality, universal targets, pp-interpretation (K₄'s CSP is
   NP-complete; infinite periodic instances); **distance graphs** (Eggleton–Erdős–Skilton; Zhu's circular chromatic number) for the
   rank-1 case, where everything is periodic and decidable.

### 0.4 What a good structural form looks like

- It quantifies over **every** proper four-colouring (or every invariant measure on X_4(S)), not over one.
- It names the **kind** of invariant it admits, so that "none exists" is a statement and outcome (b) is well posed: e.g. "a map from
  X_4(S) to a finite-dimensional space (or a finitely generated group), continuous and Λ-equivariant/additive, whose realised set is
  cut out by finitely many constraints computable from S". Without the kind, a complete invariant always exists (X_4(S) itself, or
  its set of invariant measures) and (a) is trivial while (b) is unfalsifiable.
- It separates the **two products** the stub braids together: (P1) Kooshi's certificate/decidability question about the *class*
  (two-sided); (P2) what the *target* needs — five colours over ℚ(√167) is a **one-sided** question (an obstruction to four-colourability
  that scales with symmetry). A complete invariant is sufficient for P2 and not necessary.
- It keeps the **known positive** (de Grey's lattice, `F = 8Λ`) and a **known negative** as controls the invariant must reproduce,
  one on each side, and a control with torsion (e.g. `ℤ/4` or `ℤ² × F`) to show why the class excludes it.

### 0.5 Where I expect a plan for this to go wrong

1. **A non-sequitur in the outcomes (product axis).** The stub's outcome (b) says a no-go or undecidability means "five over ℚ(√167)
   must come from the field's arithmetic". It does not follow: undecidability of the class (or nonexistence of a *complete* invariant
   with local bounds) leaves one-sided symmetry-level obstructions untouched. If the plan inherits this line, a (b) result would
   redirect the hunt for a wrong reason.
2. **"Complete" presupposes C3-aper at four.** If the invariant is complete and its values are realised by periodic colourings, then
   colourable ⟹ periodically colourable, hence decidable. So outcome (a)'s strong form *is* a proof of C3-aper at four (FS-76's
   question 1, which FS-79 says it leaves to FS-76). The plan should say which it is aiming at, and that (a)-strong settles FS-76 Q1.
3. **Frame acceptance on the class.** "The most general class, arithmetic stripped" may discard the very symmetry (the point group,
   G62's multilayer) that made ℚ(√167)'s certificate 5.7 KB (T40–T41). G72's third move says "average over the symmetry"; the abstract
   class has only translations. The class should be chosen with that trade-off stated, or a second, intermediate class named
   (Cayley graphs of Λ with S invariant under a finite point group).
4. **The literature question unrun.** Decidability of k-colourability of Cayley graphs of ℤ^r may be settled (recalled, not read). The
   gate must search it in symbolic-dynamics words ("domino problem", "colouring problem", "Cayley graph", "undecidable") before the
   competition is briefed to derive it.
5. **Phase 0 leaking into the brief.** The screen's typed nulls (G21: period cap) would be read as "these lattices need five", and the
   screen's survivors would become the competition's instance list — the brief must be written from §IQ only.
6. **The structural form reworded from the existence form** ("is there an invariant that decides four-colourability?" is an existence
   question about invariants). The honest structural form asks what every colouring *carries*, with the kind stated.
7. **Outcomes unreachable on the budget** (FS-73's competition: ~1.5 h, ~400k tokens each). An undecidability proof (a Wang-tile
   reduction through Cayley constraints) or a complete invariant at four colours is a research programme; the registered outcomes should
   include reachable partial products (a one-sided obstruction; a subclass; a reduction) with their own falsifiers.

### 0.6 Hunch ledger (opened with the expectation)

hunch: the-decidability-question-may-already-be-answered
  claim: decidability of k-colourability of Cayley graphs of ℤ^r (S as input) at k = 4 is settled, or nearly, in the symbolic-dynamics
    literature on the domino problem for colourings of Cayley graphs
  basis: prior
  falsifier: a gate search in that literature's words (zbMATH + arXiv: "domino problem" & "Cayley graph" & colouring/colorability) that
    finds nothing covering ℤ^r, d ≥ 2
  registered: 2026-09-23
  status: killed (by: the planner's gate — CGHO 2025 §6.2.1 Question 6.2 carries decidability of emptiness for ℤ^d with arbitrary
    generators as OPEN, and Ellenberg's 2018 MO question (C3-aper, all k) likewise; reported in message 6, to be confirmed against §PA's
    text). Mechanism of my miss: a recollection of a "k-colouring problem" literature, never read; my own web check had already failed
    to confirm it.

hunch: the-cayley-restriction-is-the-mechanism
  claim: the property that separates Burr's undecidable periodic graphs (k ≥ 3) from T22's decidable Cayley graphs (k = 3) is
    vertex-transitivity with abelian translations, and whether it survives at k = 4 is the whole of Kooshi's certificate question
  basis: derived (Burr's statement from the zbMATH review; T22 from the derivation file)
  falsifier: a Burr-type encoding that already works for Cayley graphs of ℤ^r at k = 3 (impossible by T22), or at k = 4 in print
  registered: 2026-09-23
  status: open

hunch: the-outcomes-conflate-one-sided-and-two-sided
  claim: the stub's (b) consequence ("five must come from arithmetic") will survive into the plan unless flagged
  basis: read (stub, "Outcomes to register", (b))
  falsifier: the planner's §IQ/outcomes already separate the one-sided obstruction question from completeness/decidability
  registered: 2026-09-23
  status: confirmed (by: stub text "(b) … five over ℚ(√167) must come from the field's arithmetic", corrected by the owner at 6396e9df; the planner adopted the split, message 2)

hunch: g71-is-scoped-to-squares
  claim: G71's no-go is about the square complex; for lattices whose relators include triangles, the target complex is ∂(tetrahedron)
    and a different topology applies; ℚ(√167)'s lattices are triangle-free (G57), so for the target G71 applies in full
  basis: derived (G71 text: "K₄'s square complex is ℝP²"; G57)
  falsifier: a reading of T29 showing it already accounts for triangle relators, or a ℚ(√167) lattice with a triangle relator among
    its unit vectors (impossible if √3 ∉ ℚ(√167): G57)
  registered: 2026-09-23
  status: confirmed (by: the planner's independent reading of [MooreNewman2000] §III — four-colourings of the triangular lattice carry a
    2-dim height — §0.2 of the plan draft; replication by an independent reader, not by my own measurement)

## 1. Evidence inventory

- `rank1_density.py` + `rank1_density_scan.py` (mine, scratch) — read against: at k = 3 zero transients (T24), at k = 4 either none (density
  plausible in rank 1) or some — surprised: **yes**. Four transient sets at max D = 10, coinciding exactly with Coxeter's T30 walls: his
  "walls" are one-way. I had expected rank 1 to be the easy, periodic case for every question; it is for existence (EES), not density.

- web check of hunch the-decidability-question-may-already-be-answered (3 searches: "k-colorability Cayley graph Z^2 undecidable domino
  problem"; "coloring problem Cayley graphs decidable domino problem"; "undecidable whether Cayley graph of Z^d is 4-colorable") — read
  against: a paper deciding or refuting decidability of k-colourability of Cay(ℤ^r, S), S as input — surprised: yes (absent). Nothing
  found covering it; hits were the domino problem on groups (Ballier–Stein conjecture: decidable iff virtually free), Silva 2103.04414
  (colourings of BS(1,N), frozen iff n = 3), Bašić 2609.03184 (uniquely colourable finite Cayley graphs). My "k-colouring problem"
  recollection is **unconfirmed**; the pointer stays a pointer. The gate's zbMATH/arXiv run is the authority.
- FS-73 §R-close (§1–§2, §5–§6) — read against: G71 promoted, heights found by the gate and not carried into §C, Hubai's miss — surprised:
  no. One residue: §R-close.1 miss 2 — **G62's multilayer structure was the thing that made the ℚ(√167) certificate small, and nobody
  extracted it**; that is exactly the structure the FS-79 abstract class discards.
- Coxeter §6 (FS-73) — read against: the ℤ/2 winding and chirality reading — surprised: partly. It already names the **cube double
  cover `Q₃` and its sphere** ("`Q₃`'s square complex is a sphere, already simply connected"), so the next topological move is in the
  record the competitors read (the owner's item 10 says H-A's direction is public anyway). It also lists the one-sided certificates
  (fractional, forced-group, Baxter's height) and flags `[Burr1984]` as "the first prior-art question to ask".
- `plans/FS73-derivation.md` T29 — read against: the decidability equivalence — surprised: no. "Two-sided certificates ⟺ decidable" is
  Post's theorem; T29 itself says "a reduction, not a decision".
- Protocol §1, §3 — read against: rules after FS-73 — surprised: no. Rule 6 (the advisor carries nothing) and R1 (held items offered to
  both after first routes).
- LEDGER rows 78–79 (heads) — read against: the known positive and the three-colour theorem — surprised: no.
- **The stub's pricing paragraph** ("the lattices over ℚ(√167) that could need five colours are high-rank ones … finite pieces start
  near 10⁷ points (G65, G69; FS-70's rank-8 lattice)") — read against: a measurement at ℚ(√167) — surprised: **yes**. Every lattice
  over ℚ(√167) has rank ≤ 4 (it sits in the 4-dimensional ℚ-space ℚ(√167, i)); the 10⁷ anchor is a rank-8 lattice over ℚ(√3,√5), and
  the 10⁸ anchor is ℚ(√167) at **three** colours. Two things differ from the claim's population (field/rank, and colour count). Card
  for the planner (§2).

## 2. Exchange log

1. **Poros → planner (opening note).** Two questions to hold: (i) is decidability of k-colourability of Cay(ℤ^r, S) already in the
   domino-problem literature (Burr vs T22 as the contrast); (ii) the target is one-sided; does the stub's (b) consequence follow, and
   does the structural form name the kind of invariant?
2. **Planner → Poros.** Gate running, domino problem and hom-shift decidability first; agreed that "(b) ⟹ arithmetic" does not follow;
   splitting §IQ's structural form into a completeness half and an obstruction half, each with its kind. *Hunch
   the-outcomes-conflate-one-sided-and-two-sided: the planner adopted the split in one message — not a retraction by either side (it had
   not committed to the stub's line).*
3. **Poros → planner, two cards.** Card 1 (question axis): per half, what yes/no question about every 4-colouring forces the
   invariant? The stub asks for the invariant directly; the G72-shaped question for the completeness half is density of periodic
   4-colourings, which the stub gives to FS-76 Q1; if the tool-shaped form is kept, state per half what an invariant must do to count.
   Card 2 (evidence): "priced out" is carried from rank 8 over ℚ(√3,√5) and from three colours at ℚ(√167); every ℚ(√167) lattice has
   rank ≤ 4; phase 0 could measure it (G65 degree law at rank 4, own unit-vector counts).
4. **Poros → planner, correction (retraction Poros 1).** Card 1 said the ℤ/2 winding is "realised periodically" — unchecked; whether
   every winding value some 4-colouring carries is carried by a periodic one is open (a small case of density). Caught by me on
   re-reading, within minutes, before any reply. Free window.
5. **Owner → Poros.** Card 2 accepted as owner error 2 (the pricing paragraph was in the planner's brief too); stub corrected in place
   at 6396e9df (pricing paragraph and outcome (b)'s consequence); the planner told that phase 0 prices a direct four-colour ask on the
   richest rank-4 lattices. Card 1's scope question settled by owner ruling R1: FS-79 may take density of periodic four-colourings if
   that is the best structural form; FS-76 re-aimed at the close. My three inventory items logged as close-inventory items 13–17.
   *Hunch the-outcomes-conflate-one-sided-and-two-sided: confirmed (by: the stub's own text, corrected at 6396e9df).*
6. **Planner → Poros: §G draft** (`plans/FS79-invariant-question.md` §G.1–§G.7, uncommitted). Headlines: row 45 + T18/T27/row 72 make
   56 of FS-61's 57 lattices four-colourable and loose by theorem (P0 screens only `L21cc6506` and the saturated chain `Λ_M`,
   χ(ℚ(√167)²) = sup_M χ(Λ_M)); FS38-D2-A and FS54-T6 are four-colour every-colouring theorems the stub missed; G60's cap at 167 is
   4.36, so a fractional five would prove χ_f(ℝ²) > 4; §IQ gets obstruction, completeness and a rigidity half (route (ii): finite-index
   F + G55's chain; Mixon's 2018 question). Gate: Ellenberg's 2018 MO question = C3-aper for all k, carried as open by CGHO 2025
   §6.2.1 with decidability of emptiness for ℤ^d with arbitrary generators; CGHO's cohomology paper: grid four-colour homshift
   cohomologically trivial (G71's grid half in print); Moore–Newman: triangle relators carry a 2-dim height. Asked: which SILENTs bear.
   *Read against my §0: it matched 0.2 (G71 scoped to squares — found independently via Moore–Newman), 0.4 (the halves), 0.5.1 and
   0.5.4 (literature run). Surprise: the spare-colour reduction to one lattice + the Λ_M chain (not in my expectation — good), and the
   rigidity half (route (ii)), which I had not listed.*
7. **Poros → planner.** Silent review: G53 bears (§IQ's kind: counting compulsion on the base pattern, integral, one-sided, with T40 the
   corpus's pattern-level precedent); G42 bears as pointer (superseded by T1, and the door to the colour-exchange-invariant literature
   the gate found); G58 only if P0 runs equivariant finders (fixed-colour filter); G9, row 42, FS66-T3/T6 silent fine; row 11 B fine.
   **Card A (object):** the abstract class has trivial members of both halves — S ⊇ {s,2s,3s} makes c(x+4s) = c(x) (Cay(ℤ,{1,2,3}): 24
   colourings, all 4-periodic, checked), S ⊇ {s,…,4s} is K₅ — so P-G71's killing test is met by cliques unless each half names its class
   (triangle-free / K₄-free / S on the norm-one torus S¹×S¹). **Card B (correctness):** route (ii) needs a forced δ that is a unit of
   ℤ[U]; finite index gives F ⊇ mΛ, chainable iff 1/m ∈ ℤ[U] iff no prime of m has a stable prime above it; a lattice all of whose
   colourings were residue colourings at a usable prime (23) would be rigid with no five (cf. ℚ(√11)'s F = 3Λ chaining only because 3
   splits there, N3).
8. **Planner → Poros.** Adopted G53/G42/G58 verdicts, card A (classes: (Q-comp) in 𝒞_r; (Q-rig), (Q-obs) in 𝒞_r^{K₄-free}; target
   𝒞_r^{△-free}), card B (route (ii)'s exact target: a forced δ that is a unit at every stable prime). §PA and §IQ written. Asked:
   (1) (Q) with three faces, or (Q-obs) its own question? (2) a missing kind?
9. **Poros → planner.** (1) The faces are three questions; only (Q-comp) follows from (Q); MO (per §PA.2) expects (Q) "no" by domino
   reduction, which gives nothing at the target; (Q-obs) as written already has a success test so may stand alone; rank the questions
   (owner's product call). Benchmark inhabited only in rank 1 (my check: G(ℤ,{1,3,7,12,17,22}) sum-free, periodic independent set of
   density 8/29, 4-colouring refused by CaDiCaL on a 176-window; K₄-free example {1,6,8,11,12}) — require rank ≥ 2 or a stated scaling.
   (2) Kinds T (Lovász's ℤ₂-index — the classical integral obstruction past χ_f; Kneser) and A (algebraic: equivariant Nullstellensatz /
   group-ring ideals, FS-10; Schmidt's algebraic ℤ^d-actions). Control Cay(ℤ,{1,2,3}).
10. **Planner → Poros** (crossed with 9): plan committed at 928acafd; asked also whether any §P probability makes an outcome unreachable
    or forced.
11. **Planner → Poros:** all of 9 adopted, committed 66e9ae32 (hash checked): three ranked questions (owner slot; default obstruction,
    rigidity, density), (Q-obs) needs rank ≥ 2 and a size independent of refuting subgraphs, my rank-1 set recorded as mine and
    unre-run, kinds T and A added, both controls, P-MO and P-rank registered. Handing back.
12. **Poros → planner (late card, answering its §P question) and → owner.** **Density (Q) is false in rank 1 as posed.** Script
    `rank1_density.py` (1-D SFT on canonical windows mod colour permutation; transient ⟺ an edge between distinct SCCs of the essential
    graph). Control k = 3: 0 transients over 274 three-colourable D ⊂ {1..10}, |D| ≤ 5 (T24). k = 4, |D| ≤ 4, max D ≤ 10: exactly 4 of
    367 have transients — {1,5,7,10}, {3,5,9,10}, {3,7,9,10}, {5,7,9,10} — **exactly FS73-T30's walls**, all K₄-free, none triangle-free;
    there P = F = 0 and periodic colourings exist (EES), so Ellenberg's question and C3-inherit survive while density fails. Suggested:
    restate as T38's recurrent half (F_μ = P) or existence + inheritance; add §P's missing cell. Also answers the §P question: as posed,
    P-A/P-A′ ("(Q) yes") are unreachable in any class containing these rank-1 graphs, and a (Q) "no" is forced by an afternoon's rank-1
    computation.
13. **Planner → Poros.** Late card adopted after the planner's own independent re-check (its window-state/SCC code: 8, 4, 24, 2 cross
    edges on T30's four walls, 0 on seven controls) — a second independent replication. (Q) is now existence + inheritance, F_μ = P the
    optional sharper form; committed 61495ca1 (hash checked), §X item 12, recorded as the planner's miss (T30 marked bearing, consequence
    not drawn). Not a retraction by either side (the density form was never defended after the evidence).

hunch: density-fails-in-rank-1
  claim: periodic 4-colourings are not dense in X_4(D) for some K₄-free D ⊂ ℤ (so (Q) as posed is false in rank 1)
  basis: measured (my SCC script, with the k = 3 control at 0)
  falsifier: a bug in the SCC/transient logic — e.g. an explicit periodic 4-colouring of G(ℤ,{5,7,9,10}) containing the pattern on a
    cross edge
  registered: 2026-09-23
  status: confirmed (by: `wall_check.py`, an independent re-implementation — brute-force window enumeration, reachability instead of
    Tarjan — finds the same 2 cross edges for D = {5,7,9,10}; its cross-edge pattern (0,1,2,1,2,1,0,3,0,1,3) lies on an essential edge,
    so it extends to a bi-infinite colouring, and SAT with all 24 colour permutations finds it in no periodic colouring of period ≤ 60.
    The SCC argument itself is a finite-state proof that no periodic colouring of any period contains it; the period-60 check is a
    capped cross-check (G21). The four sets are exactly FS73-T30's walls, scanned independently by Coxeter)

## 3. Retraction count

| side | count | what |
|---|---|---|
| planner | 0 | |
| Poros | 1 | (1) card 1's "the ℤ/2 winding is realised periodically" — an unchecked claim stated as fact; corrected in message 4. |

## 4. My own errors, against myself

1. **An unchecked realisability claim inside an example** (message 3, card 1). Mechanism: the example was chosen to show "carried by
   every colouring" and I added "realised periodically" by analogy with three colours, where density makes it true. Cost: none (caught
   before any reply). Rule it re-confirms (FS-73 error 2): a clause that is quotable alone gets checked before it ships.

2. **Not an error but worth scoring (my expectation against what happened).** §0.5 predicted seven failure points. Four fired and were
   caught: 1 (outcome (b)'s non sequitur), 2 ("complete" presupposes existence of periodic colourings; now in the ranked questions), 3
   (the class: caught as card A, in a form I had not foreseen, cliques), and 4 (the literature: run by the planner; my recollection was
   wrong). Two were handled by the plan unprompted: 5 (phase 0 kept out of the brief) and 7 (partial outcomes registered). 6 (the
   existence form reworded) was card 1. **Missed by my expectation:** the density question's falsity in rank 1. I read T30 before writing
   §0 and listed it as bearing ("rank-1 walls; P = F = 0 walls"), but I drew the consequence only when the planner asked me to check §P,
   the same miss the planner recorded for itself. Mechanism: T30 was filed under "inheritance" (P = F), and density is a different
   property of the same walls. It was caught before any competitor was briefed, at a cost of one late card.

## 5. Final report (2026-09-23, at the owner's request; the plan accepted at 61495ca1)

### 5.1 What I told the planner, and what it did

| # | card / message | what it said | taken or declined |
|---|---|---|---|
| 1 | opening note, Q1 | is decidability of k-colourability of Cay(ℤ^r, S) already settled (Burr 1984 against T22)? | taken; the gate ran it first. Found open in print (Ellenberg 2018 on MathOverflow; CGHO 2025 Question 6.2) |
| 2 | opening note, Q2 | the target needs only a one-sided obstruction; the stub's "(b) ⟹ arithmetic" does not follow; name the *kind* of invariant | taken; the owner also corrected the stub at 6396e9df |
| 3 | card 1 | "what invariant?" gives no way to tell right from wrong; pose a yes/no question per half; density was assigned to FS-76 | taken; became the ranked questions. The owner ruled on scope (R1) |
| 4 | card 2 | "priced out" borrowed a rank-8 lattice and a three-colour price; every ℚ(√167) lattice has rank ≤ 4 | taken; owner error 2, stub corrected, phase 0 now prices it |
| 5 | correction | my "realised periodically" was unchecked | my retraction 1 |
| 6 | silent review | G53 bears (counting kind), G42 bears (Kempe pointer), G58 applies only with equivariant finders; the others are fine | all taken |
| 7 | card A | cliques make the rigidity and obstruction faces trivial in the abstract class; each face names its class | taken (𝒞_r; K₄-free; triangle-free for the target) |
| 8 | card B | route (ii) needs a forced δ that is a unit at every conjugation-stable prime; a residue-rigid lattice gives nothing | taken |
| 9 | answers (1) and (2) | three questions, not three faces; the obstruction question stands alone with a success test; rank them (owner slot); the benchmark is inhabited only in rank 1 (require rank ≥ 2); kinds T (Lovász) and A (algebraic) | all taken (66e9ae32) |
| 10 | late card | density is false in rank 1: T30's four walls are one-way; restate as existence + inheritance (or F_μ = P) | taken after the planner's own re-check (61495ca1); the owner re-checked it a third time |

**Declined:** nothing. Every card changed the plan. By G51's reading that is worth flagging: a planner that takes every card may be
deferring. Against that, it re-derived the one card that mattered most (the late card) with its own code before adopting it, and it
pushed back where I had not checked (it recorded my rank-1 benchmark set as "mine, unre-run" rather than adopting it as fact).

### 5.2 Retraction count

| side | count | what |
|---|---|---|
| planner | 0 | none. It revised on evidence, but it never asserted and then withdrew a claim |
| Poros | 1 | card 1's "the ℤ/2 winding is realised periodically", unchecked (corrected within minutes, before any reply) |

G51's warning, applied here: the planner at 0 does not mean the disagreement never started. It started on the density question and
was settled by computation, not by retraction.

### 5.3 My own errors

1. The unchecked "realised periodically" clause (§4.1). Cost: none.
2. A recollection offered as a pointer (a "k-colouring problem" literature). It was labelled "recalled, not read", my own web check
   failed to confirm it, and the gate found the question open. The label held; the recollection was wrong.
3. **The density consequence drawn late** (§4.2). T30 was in my evidence before I wrote §0, filed as bearing, and its consequence for
   density was drawn only when §P was put to me. Cost: one late card before the brief.
4. A small one: my first rank-1 benchmark message said "refused on a window of 176". The minimal refusing interval is 33 (below). The
   claim was true but not sharp.

### 5.4 The owner's finding on "Kind 0 is controlled by χ_f": checked against me

**Verdict: correct, and stronger than stated.**
- **The rank-1 argument holds.** Legal (max D)-windows are states and legal (max D + 1)-windows are edges. A shift-consistent
  probability on edges is a circulation, a circulation is a nonnegative combination of cycles, and a finite graph has a bi-infinite path
  iff it has a cycle. So the window-(max D + 1) invariant-measure LP is feasible iff X ≠ ∅: exact in rank 1.
- **The benchmark is re-checked (`bench_recheck.py`):**
  - D = {1,3,7,12,17,22} has the independent set {0,2,4,6,10,15,20,25} mod 29, verified exactly, so χ_f ≤ 29/8.
  - Its 4-colouring is refused on 33 consecutive points and satisfiable on 32 (Glucose4 bisection; Minisat22 agrees at both), besides
    CaDiCaL on 176.
  - For D = {1,6,8,11,12} (K₄-free, density exactly 1/4), my exact SCC code finds 2,348 canonical window states and an **empty**
    essential graph. That is the owner's LP-exactness observed directly.
- **Stronger than stated.** The fractional bound is what the one-point marginals (the colour-class densities) give, together with the
  independence-density bound. But **pair statistics already escape**: FS-73's slope is the invariant mean of a pair-cylinder function
  (the ±1 step is determined by (c(x), c(x+s))), and Θ₃ = ∅ is a two-point-density certificate plus the integrality of the winding. So
  the "not a density certificate" clause would have excluded the three-colour certificate itself.
- **One refinement to the consequence ("state the success test by size").**
  - In rank 1 the exact window LP is *larger* than the refutation: {1,6,8,11,12} has 2,348 states against a 22-point refusing interval.
  - Without a size test, a box-marginal LP in rank ≥ 2 is only compactness in LP dress: it is sound and complete in the limit, and
    infeasible where legal patches run out.
  - What won at three colours was not the full window LP. It was that LP projected onto a space of fixed dimension (Hom(Λ, ℝ), the mean
    of an integer cocycle).
  - So the test should say: a sound certificate of **any** kind, densities included, whose bit size is bounded by a function of |S| and
    r, independent of and (on the instances) much smaller than the smallest refuting subgraph.
  - The χ_f ≤ 4 benchmark condition already excludes the one-point shadow; the "not a density" clause can go.

### 5.5 For the competition's advisor

1. **The density question is false in rank 1 as plainly posed** (T30's walls are one-way transients; §2 item 12). The live forms are
   existence (Ellenberg), inheritance (P = F), and F_μ = P. A competitor who "disproves density" with T30 has reproduced a plan fact.
2. **The rank-1 laboratory is exact** (SCC on window states; T28's decider), and it now holds both kinds of control:
   - colourable graphs with transients: {1,5,7,10}, {3,5,9,10}, {3,7,9,10}, {5,7,9,10};
   - non-colourable graphs with χ_f < 4 or = 4: {1,3,7,12,17,22} (triangle-free, minimal refusing interval 33, χ_f ≤ 29/8) and
     {1,6,8,11,12} (K₄-free, empty essential graph).
   Any claimed invariant, restricted to rank 1, should be run on them first. My scripts are in this directory.
3. **Watch for the clique shortcut** (card A) and the chain condition (card B). A rigidity result must be K₄-free, and it gives five at
   ℚ(√167) only through a forced δ that is a unit at every stable prime.
4. **The owner's Kind-0 finding** (§5.4): multi-point averages are admissible and are how three colours was certified. Judge a
   certificate by size, not by kind.
5. **The failure I made twice in two milestones:** stating "realised periodically", or its equivalent, from three-colour intuition. At
   four colours that phrase is the open question itself. Ask for the check each time a competitor writes it.
6. **The expected drift:** toward a domino-style "no" on existence. It would answer a posed question (a real result) and give nothing
   at ℚ(√167), where the rank is at most 4 and the graphs are triangle-free. The owner's ranking puts obstruction first; hold the
   competitors to the rank their result reaches (P-rank).

### 5.6 Token usage
About 215k of the ~450k budget.

## §H. HELD (for the owner; to be offered by the competition's advisor to both competitors at once, after each has written its first
route, per FS-73's ruling R1; also in `HELD-poros-fs79.md`)

**H-P1: withdrawn as held.** "Rigidity manufactures torsion": a rigid factor (de Grey's lattice, 9,120 colourings) turns a
torsion-free Cayley graph into a ℤ² SFT over a finite alphabet. This is the torsion-then-lift step Greenfeld–Tao use for tilings. The
planner reached it independently from T34 (plan §PA.3 item 4), so it is public.

**H-P2: an equivariant-degree candidate (the obstruction question).**
- **Coincidence.** K₄'s square complex is ℝP² = S²/antipode (through Q₃, T29). Lovász's box complex satisfies B(K₄) ≃ S²
  ℤ₂-equivariantly. So "target topology above loops" and Kind T may be one kind.
- **Candidate.** On the winding double cover, lift to Q₃ and hence to the sphere. Take the π₂-charge per unit area on each 2-plane of
  Λ⊗ℝ: a charge-density 2-form, the slope one dimension up.
- **Snag 1 (sign).** π₁ acts on π₂ by −1, so the density must vanish on every 2-plane not inside ker(w).
- **Snag 2 (fillings).** Non-square relators (Pythagorean relators, long odd cycles) have fillings unique only up to π₂, so the charge
  is defined only modulo the relator cells' integer contributions.
- **First test.** On de Grey's lattice (12 classes, all 8Λ-periodic, so every quantity is a finite computation on Λ/8Λ), compute each
  class's winding w and its charge per fundamental domain on each coordinate 2-plane, with the relator-filling ambiguity tracked
  explicitly.
- **Killing test.** Any one of:
  - (a) the relator cells' contributions span the charge lattice, so the density is ill-defined;
  - (b) it is well defined but constant on every colouring of de Grey's lattice, the triangular lattice and the grid (trivial);
  - (c) a colouring with nonzero charge on a 2-plane outside ker(w), which would mean an error in the sign argument.
- **Relation to the owner's items.** The direction ("spheres") is public through G72. This construction, its snags and its tests are
  mine and were derived without reading the owner's held file.

**H-P3: a compositional framing of the obstruction question.**
- **The observation.** At three colours Θ is compositional: Θ(S₁ ∪ S₂) = Θ(S₁) ∩ Θ(S₂), since it is defined generator by generator.
  That is why L21cc6506's certificate was small (T40, one pull-back per layer).
- **Four-colour form.** Is there a sound one-sided invariant T with values in a computable family, T(S₁ ∪ S₂) ⊆ T(S₁) ∩ T(S₂), and
  T(S) = ∅ ⟹ not 4-colourable? The multilayer {1, v, v̄, z, z̄}·U_R invites it.
- **First test.** Which of the known one-sided four-colour obstructions (the fractional bound; Lovász's index; window LPs; G53's
  counting bound) are compositional in this sense.
- **Killing test.** A proof that every compositional one-sided invariant is dominated by the one-point (fractional) bound, which would
  make the framing useless for seeing past χ_f.
