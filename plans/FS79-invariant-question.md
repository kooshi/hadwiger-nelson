# FS-79 — the invariant question at four colours (subplan)

*Planner: de Bruijn (Opus 5.5), 2026-09-23, desktop. Stub: `plans/STUB-invariant-question-four-colours.md` (as corrected by the owner
at `6396e9df`). Close inventory: `plans/FS79-close-inventory.md` (the owner writes it; items sent by message). Plan-phase advisor:
Poros, whose record stays in its scratch directory until the competition ends (inventory item 12); the exchange is summarised in §X.
This file is the plan's only home; a successor resumes from it. Order, per WORKFLOW 3: §0, §G (3.1), §PA (3.2), §IQ (3.3), then §S
(step 4), §P, §M, §C.*

## §0. The milestone after the reframe

**What FS-79 is.** A derivation milestone, the first planned under G72 and WORKFLOW 3.3. It asks a question about **every
four-colouring** of a Cayley graph of a finitely generated torsion-free abelian group, with the arithmetic stripped, and lets the answer
choose its invariant. The target that motivates it is **five colours over ℚ(√167)** (row 79 proves four; the local–global conjecture
predicts at least six, G59).

**What the reframe changed in the stub's picture** (each with its source):
1. **The question is in print, and open.** Jordan Ellenberg asked it on MathOverflow in 2018 (`[Ellenberg2018]`): does every
   `k`-colourable `Cay(ℤ^r, S)` have a periodic `k`-colouring? Chandgotia–Gangloff–Hellouin de Menibus–Oprocha carry it as open in 2025,
   together with the decidability of emptiness for ℤ^d with arbitrary generators (`[CGHO2025bg]` §6.2.1, Question 6.2). **FS-73's
   T22/T24 answer it at `k = 3` for every rank** (a close-inventory item: row 79 answers a posed question). At `k = 4` it is open.
2. **G71's "no height at four colours" is, for the grid, a published theorem, and it is not true for every generating set.**
   `[CGHO2025coh]` Theorem 1.1: a mixing homshift on the grid is cohomologically trivial (no nontrivial continuous cocycle, i.e. no
   height) iff its square group is ℤ/2 — and `K₄`'s square complex is `ℝP²` (T29). But `[MooreNewman2000]` §III: four-colourings of
   the **triangular** lattice carry a **two-dimensional height**, and every such colouring is a fixed colouring of the height lattice
   composed with the height. The invariant a four-colouring carries depends on the generating set's relation cycles, not on `K₄` alone.
   G71's four-colour sentence is correct for square relations; for triangle relations it is false. (A correction owed at the close.)
3. **The direct price is unmeasured.** Every lattice over ℚ(√167) has rank ≤ 4. The stub's first draft carried 10⁷ (a rank-8 lattice
   over ℚ(√3,√5)) and 10⁸ (ℚ(√167) at three colours) as the price of a direct refutation; neither is a four-colour price at 167.
   Phase 0 measures it (owner error 2, caught by Poros).
4. **A free theorem narrows the four-colour population at 167 to one lattice among FS-61's 57.** A three-colourable lattice is
   four-colourable, and by the spare-colour lemma (row 45, `not_forces_of_colorable`) it carries **no** four-colour pair compulsion. So
   56 of FS-61's 57 lattices are four-colourable and loose at four colours by theorem, and only `L21cc6506` (row 79) is open. The live
   population is `L21cc6506` and richer lattices: the saturated chain `Λ_M` (all unit vectors of denominator dividing `M`), since
   `χ(ℚ(√167)²) = sup_M χ(Cay(Λ_M, U(Λ_M)))`.
5. **Two routes to the target, and the structural question serves both.** (i) *Obstruction*: some `Λ_M` is not four-colourable, with a
   certificate that lives on the group. (ii) *Rigidity + chain*: some four-colourable `Λ_M` has a forced pair `δ` with `1/δ ∈ ℤ[U]`, and
   G55's chain gives `χ(ℚ(√167)²) ≥ 5` in the field. **A finite-index `F` is not enough** (Poros's card B): by prime inversion (ASTRA-T2)
   `1/δ ∈ ℤ[U]` needs `δ` to be a unit at every conjugation-stable prime of `ℚ(√167, i)`, so a lattice whose four-colourings were all
   residue colourings at 23 would have `F = 23Λ` — finite index, rigid, and no five, because 23 is usable. Route (ii)'s exact target is
   **a forced `δ` prime to every stable prime**; `1/2, 1/3, 1/7 ∈ ℤ[U]` over ℚ(√167) (`[Fischer1990]` Ex. 4), so a forced `δ` whose
   norm involves only 2, 3, 7 and non-stable primes suffices. P0 reads each candidate's stable primes first. Route (ii) has one
   precedent, and it gives five colours only *above* K, never over K itself: `χ(K²) = 4` (Theorem B), while de Grey's lattice over K is
   rigid at four colours (`F = 8Λ`, row 78, which contains Harder's pair `8/3`). The chain needs `1/(8/3) = 3/8 ∈ ℤ[U]`, which holds
   exactly when `1/2 ∈ ℤ[U]`, that is, when the 2-adic wall is broken (G55). So rigidity over K gives five in every wall-broken real
   `F ⊇ K` (K(√7) first) and nothing over K. ℚ(√167)'s wall is already broken (G1), so there a forced `δ` of the right kind would give five
   in the field itself. *[Reworded at the modeling pass, owner finding 2 (inventory item 30): the text read "Route (ii) is how five was
   reached over K (row 78: finitely many four-colourings)", but χ(K²) = 4.]* "Is the colouring space finite?" was posed on Polymath16
   in 2018 (D. Mixon, the sixth thread's opening post: *"Is it easy to check whether an infinite k-colorable graph has finitely many
   k-colorings?"*).

**The shape of the milestone** (§S has the phases): phase 0, a measurement (one implementer, now); the modeling passes (a fresh agent,
light); the competition on the structural question (two competitors and a fresh advisor); a verification-and-aiming phase (the key
steps re-derived; every new decision procedure pointed at §IQ item 5 the day it lands); the close.

## §G. The re-grokking (WORKFLOW 3.1)

*Walked 2026-09-23 with `CLAUDE.md` (disk = context: the last edits to `CLAUDE.md` and `WORKFLOW.md` are `af9d9a3a` and `bdb7e133`,
both before this session's snapshot) and `LEDGER.md` open. Verdicts: **B** bears (with the phase it changes), **S** silent (why), **F**
falsifiable here (registered in §P). Phases: P0 (measurement), P1 (modeling), P2 (competition), P3 (verification and aiming), CL
(close). Every B is carried into §G.6 as an instruction and into the phase where it is acted on.*

### §G.1 Grokkings G1–G72

| G | verdict | reason, and what it changes |
|---|---|---|
| G1 | B | ℚ(√167): `167 ≡ 7 (mod 8)`, the wall is broken (`1/2 ∈ ℤ[U]`); no residue colouring at 2 exists, so P0 runs no dyadic screen and five is not excluded by the field wall. P0 |
| G2 | S | anatomy of held witnesses (ring-hearts); FS-79 asks about every colouring of a class, not a witness's construction |
| G3 | S | radii of certified witnesses over K; no bearing on a class question over ℚ(√167) |
| G4 | S | K's shell inventory; ℚ(√167) has no √3, √11 |
| G5 | S | de Grey's 1-sum; a finite witness's factorisation |
| G6 | S | containment of the hexagram; K-fabric only |
| G7 | B | `L21cc6506`'s rotation `v = (83+i√167)/84` is the type-M member `n = 42` (T45): the open instance is a multilayer of the rational pattern. §C carries it; P0 factors each candidate's `U` into rotations × base pattern before any tree |
| G8 | S | K's direction group |
| G9 | S | forced pairs of a finite forcer at one rung below the top; FS-79's forced-group object `F` subsumes it at the class level |
| G10 | S | distributed forcing of the 1581 |
| G11 | B | a five-forcer over ℚ(√167) must be Moser-free (no √3, no √11); the Voronov/Haugland shape (force a pair, then close) is route (ii) of §0.5, kept in the field by G55's chain. §IQ item 5, §C |
| G12 | S | quadrature law of detuned copies over K |
| G13 | B | fan ⟺ coverage; a fan gap frees every pair above it (row 66). P0's gap-aimed screens report looseness only through a gap; §C names the gap as the looseness certificate |
| G14 | S | width without degree; finite arena design |
| G15 | F | "every χ ≥ 5 argument factors as pigeonhole × kill": an invariant obstruction from P2 that certifies non-four-colourability of a lattice without a class pigeonhole would be the first non-factoring argument. Registered P-G15 |
| G16 | B | the √3-clean converse (MASCOT-T6) is part of the known positive's anatomy (de Grey's lattice, T8); §C's known-positive paragraph. Silent on ℚ(√167) (no √3) |
| G17 | S | top-rung globality of finite objects |
| G18 | S | solver composition; P2 forbids search, P0 does not need composition |
| G19 | S | the five-colour class sweep over K |
| G20 | S | brick colourings |
| G21 | B | a periodic search measures its period cap (FS-73, twice). P0 reports "survivor at the periods searched", never "none"; Fourier-read any large colouring before a period search. Also: the sharp generator-image check — §C asks each competitor to state the class its theorem quantifies over. P0, P2 |
| G22 | S | where a six-colouring of the plane cannot live |
| G23 | S | cell-family scale |
| G24 | B | the step to seven is integrality, not a low relaxation: a useful obstruction must see integrality. §IQ's obstruction half asks for an invariant that is not dominated by the fractional bound |
| G25 | S | a reading about 6-forcer kill grades |
| G26 | S | the six-target |
| G27 | B | Galois automorphisms that preserve a lattice act on its colourings (the order-24 point group of the known positive, T6). Any invariant must be equivariant under the lattice's point group, Galois part included; P0 uses the group to reduce classifications. P0, §C |
| G28 | S | fine-tail virtual edges |
| G29 | S | cell family closed |
| G30 | B | derivation kills, measurement generates; P2 is derivation only. Failure mode 5 (vacuity: every class theorem ships an inhabitant) and the discipline ladder: **topology is the unentered room (FS-9)** and §PA puts FS-79's object there. P2, P3 |
| G31 | S | top-rung compulsions of held objects |
| G32 | S | the two-distance dial (six-level design) |
| G33 | S | descent dynamics |
| G34 | S | in-field descent over K |
| G35 | B | the wall is 1/2 ∈ ℤ[U]; with G1, fixes that ℚ(√167) has no dyadic bound and that `1/2` is chainable (route (ii)). P0, §IQ |
| G36 | S | K's residue colouring |
| G37 | S | descent endgame over K |
| G38 | B | the linear method stops at four (T29 confirms: no linear criterion at four colours); `[Fischer1990]` Ex. 4: ℚ(√167)² has no additive `k`-colouring for `k < 11`. P0's additive screen expects none on lattices holding `v`; §IQ's kind excludes linear colourings as the invariant |
| G39 | S | critical-set localisation of forced pairs |
| G40 | S | absorption in arena design |
| G41 | B | additive colourings are one-sided and achiral (T35's remark: `−φ` is a colour permutation of `φ`). P0 runs them first (exact, cheap); §C notes that a four-colour counterexample to density needs a non-additive phase |
| G42 | B | (Poros: "finite objects" was out of date.) Its Kempe gauge is superseded by T1's `KPer`, and a Kempe class is itself something every colouring carries — the door to the colour-exchange-invariant literature §PA found (`[CepasAkhmetiev2020]`, `[MoharSalas2009]`). §IQ item 3's kind K |
| G43 | B | ℚ(√167)'s usable primes (23, 43, 59, 67, 79, 83, …) supply P0's residue targets; the residue map is the periodic colouring's source |
| G44 | B | Kloosterman: the full residue circle at every usable `q ≥ 59` refuses five, so four; only proper residue subsets can colour. P0.1 extends the classification beyond 23 and 43 only where cheap |
| G45 | S | lifting residue configurations |
| G46 | B | name the object in the classical theory first (method): §PA named it a homshift on a non-standard generating set, with Schmidt's cohomology as the discipline's handle, and the graph-theory side's Heuberger matrices (Krebs). §IQ, §C |
| G47 | S | compulsions over 11-usable fields |
| G48 | B | the conjecture predicts `χ(ℚ(√167)²) ≥ 6`; FS-79's target is the next integer. Its falsifier at 167 (a four-colouring of the plane) is unreachable here, so no prediction of it is registered; §0 states the target as a value against `L ≥ 6` |
| G49 | B | the gate (done, §PA) and its new rule: the held Polymath16 threads grepped for the milestone's objects — they hold Gibbs's 2018 periodicity question and Mixon's finiteness question. §PA |
| G50 | B | FS-73 listed `[CGHO2025bg]` and `[CGHO2025coh]` by title and never opened them (`plans/FS73-C3-Coxeter.md` §2, l. 61–63), which is why FS-73's close recorded decidability as "not found"; this gate opened them and found the question stated as open and G71's grid half as a theorem. §PA; this instance goes to G50 at the close |
| G51 | B | the competition design (P2): identical briefs, isolated scratch, retractions counted, the advisor writes its expectation first, held items offered after first routes |
| G52 | S | wall-breaking type-M arenas |
| G53 | B | (Poros.) The counting compulsion is computed on the base pattern alone, is one-sided and **integral**, not fractional: the corpus's precedent for "certify on the pattern, not the graph" on a multilayer, and `L21cc6506` is a multilayer (T40). §IQ item 3 lists it as an admissible kind; §C carries it |
| G54 | B | compute the tight/slack sign at `k = 4` for every usable `q` before any residue ask (P0 step 0); tight ⟹ every colouring periodic under `H_min` (FS38-D2-A) is the corpus's one four-colour *every-colouring* theorem, and §C carries it. **F**: G54's reading (full-rank `F` needs a tight integral prime and no gapped quotient) — registered P-G54 on phase 0's candidates |
| G55 | B | route (ii): a finite-index `F` on a ℚ(√167) lattice plus `1/δ ∈ ℤ[U]` gives five in the field. §IQ's rigidity half and §C |
| G56 | B | ℚ(√167) is the smallest real quadratic field with no usable plane below 23; its local bound is ≥ 6. §0 |
| G57 | B | ℚ(√167)'s lattices are triangle-free (no √3): `[MooreNewman2000]`'s height does not apply there, and P0's clique pin is an edge (ω = 2), so the precedence constraint does the rest of the symmetry break. P0, §C |
| G58 | B (conditional) | silent unless P0 runs point-group-equivariant finders; then its derived half is a free filter — an involution `τ` with `c(−x) = τ(c(x))` must fix a colour — applied before any solver row (Poros) |
| G59 | B | the prediction at 167 (≥ 6 under the conjecture's two clauses); context for §0 only |
| G60 | B | fractional colourings are an averaged, one-sided invariant with cap `min(4.36, χ_f of usable planes)`; at ℚ(√167) the cap is 4.36 > 4, so the fractional route could reach five **only by proving `χ_f(ℝ²) > 4`**, beyond the best known bound (`[MatolcsiEtAl2025]`: ≥ 4). §IQ: the obstruction half's invariant must see past `χ_f`. Also the `F ⊆ F_μ ⊆ P` split (T38) goes into §C |
| G61 | B | supply of unit vectors decides (at three colours); P0 ranks candidates by unit-vector count per covolume and residue coverage, not by congruence |
| G62 | B | factor a lattice's `U` as rotations × a base pattern (`L21cc6506 = {1,v,v̄,z,z̄}·U_R`); commensurate ⟹ periodic ⟹ bounded (M63H3-T8). P0 and §C |
| G63 | S | transcendence is free |
| G64 | S | six as a value of `F ↦ χ(F²)` |
| G65 | B | P0's pricing: degree = `g·φ(R)²` with each lattice's own `g`; the four-colour hardness band is **unmeasured** (G65's diagram is three-colour), so P0 registers where it expects refusals to start and aims above it; a stop rule on the measured rate |
| G66 | B | periodic colourings are the continuous colourings of the odometer (`P = F_clopen`), so the density question is the compulsion analogue of `χ_clopen = χ`; at 23 every tower level refuses five (row 75), so the full-circle target refuses four at every level and P0 uses level one only. §C, P0 |
| G67 | B | the form: whatever invariant P2 lands is minted at the close as a grokking with a trigger, a *Do* and a killing test. CL |
| G68 | B | quotient before ball, gap-aimed first (P0.3); its soundness edge is completeness of `U` (P0 saturates `U` before any quotient) |
| G69 | B | periodic colourings are residue colourings prime by prime; rigidity is decided on quotients; P0 classifies the primes of `ℚ(√167, i)` above each small `q` (split / inert / ramified) before choosing targets, and runs the Kempe-period screen (T1, T33) on gap-free colourings. P0 |
| G70 | B | the known positive's anatomy: of de Grey's 12 colouring classes one is √3-clean (Theorem B's pair). §C |
| G71 | B, F | the no-go the milestone gets around. §PA shows its four-colour half is a theorem for the grid (`[CGHO2025coh]`) and false for triangle relations (`[MooreNewman2000]`). Its killing test — "a four-colour rigidity theorem over a class of lattices that uses no arithmetic" — is reachable in P2: registered P-G71. Correction owed at CL |
| G72 | B | the method, first planned instance; its count (did the result come through the structural question?) is scored at CL (inventory item 1) |
| G51 | B | (see above; listed last in `CLAUDE.md`) |

### §G.2 Ledger rows 1–79 (mechanisms)

| row | verdict | reason, and what it changes |
|---|---|---|
| 1–3 | S | two-circle, seam, coverage-ratchet geometry over K; finite objects |
| 4 | B | `fan_iff_coverage`: the kernel form of the fan/gap dichotomy P0 reads (with row 66) |
| 5–10 | S | class confinement, the 120° identity, greedy colouring, de Grey's balanced colouring, the one-pivot cap: finite K-geometry |
| 11 | B | the strip automaton (colouring space ×12 per column) is the transfer-matrix view of a lattice's strips; §C names strips (the `[CGHO2025bg]` block-gluing / `G_n` walk graphs are the same device) as a legitimate derivation tool for rank 2 |
| 12–13 | S | extension-profile and negative-knowledge tooling of M17–M20 |
| 14–21 | S | circle gluing and partner webs over K |
| 22–25 | S | the ladder closures, hexagram, field-wall identity: finite 4-chromatic objects over K |
| 26–30 | S | anatomy, quadrature, stacking, mechanism hunt: finite witnesses |
| 31–32 | S | Act One pigeonholes and the six-programme |
| 33 | S | the plane's 7-colouring (a periodic coset colouring); upper end, not four-colour structure |
| 34–41 | S | the cell family and the limit lemma |
| 42 | S | arity floor of finite graphs; the class question is at arity 2 (forced groups) |
| 43 | B | transport of forced pairs by isometries: `F` is a subgroup stable under the lattice's point group (used in §IQ's rigidity half and §C) |
| 44 | B | the spindle theorem: a forced pair at `d ≥ 1/2` plus a spindle refutes; with row 44's field `F(√(4d²−1))` it is route (ii)'s out-of-field form, G55's chain its in-field form |
| 45 | B | **the spare-colour lemma** (`not_forces_of_colorable`): every three-colourable lattice is loose at four colours. §0.4's free theorem; P0 runs nothing on FS-61's other 56 lattices |
| 46–49 | S | copy unions, M53's witnesses, critical sets, absorption: finite objects over K |
| 50 | B | `[Fischer1990]` Ex. 4 at ℚ(√167): no additive `k`-colouring for `k < 11`, by `v`; `1/2, 1/3, 1/7 ∈ ℤ[U]`. P0's additive screen and route (ii)'s chainability |
| 51 | S | additive rigidity of finite objects |
| 52 | B | the finite-plane bound: P0's residue targets at usable primes |
| 53 | B | spectral refusals of full residue circles (Kloosterman): P0.1 |
| 54–55 | S | lifts; the residue obstruction over 11-usable fields |
| 56 | B | `addCayleyMap`, `unitQuadrance_colorable_of_quotient`: the kernel soundness of every periodic four-colouring P0 reports |
| 57 | B | Theorem A (`colorable_of_residue`): a homomorphism `ψ : A → G` nonzero on edges colours with `\|G\|` colours — the general form of the periodic certificate; `[Fischer1994]`'s ℤ/4 colouring is the additive instance. §C |
| 58–65 | S | the mascot threshold, the 2-adic law over K, plane freedom, statement levels, overcompression, two colours from inertia, the `ρ₆₃` arena, Parts's shape |
| 66 | B | the fan gap: one gapped vertex makes every pair free on every graph with a homomorphism into the target (`slack_addCayley_of_fanGap`). P0's looseness verdicts |
| 67 | B | **the one four-colour every-colouring theorem in the corpus**: on a Hoffman-tight Cayley graph every `k`-colouring is balanced, gap-free and periodic under `H_min` (FS38-D2-A), and the 2-adic tower's colouring space is finite (D2-B). A spectral structure theorem at `k = 4`; de Grey's lattice is *slack* (FS-73 §R0), so it does not explain the known positive. §C |
| 68–70 | S | the six-colour window and its certificates |
| 71 | B | the field-internal fractional bound and its cap (G60): the averaged one-sided invariant the obstruction half must beat |
| 72 | B | the 3-adic barrier: 3-integral lattices are three-colourable, hence (row 45) four-colourable and loose; dropped in P0 |
| 73 | S | four colours over ℚ(√11) etc.; done |
| 74 | B | FS-61's census: the lattices and the degree law (G65) P0 reuses |
| 75 | B | the residue tower does not drop: at 23 every level refuses five, so four; P0 uses level one only |
| 76 | B | FS-70's instruments (quotient, gap, Kempe screens, the CM-subfield table) and FS-72's rank-8 lattice (an open instance for §IQ item 5); rigidity and density pull apart |
| 77 | S | the theorem audit (its filing rule binds the close, not the plan's content) |
| 78 | B | **the known positive**: `F = P = 8Λ` on de Grey's lattice at four colours, 9,120 colourings in 12 classes (Hubai's count, 2018); a complete invariant must see it. §C |
| 79 | B | the three-colour theorem that stops at four; `χ(ℚ(√167)²) ≥ 4` through `L21cc6506` |

### §G.3 `LEDGER.md` § B, by milestone block (the owner's scoping; bearing lines individually)

| block | verdict | reason; individual bearing lines |
|---|---|---|
| M18–M43 (cell family, fractional cores, fine tail) | S | finite geometry of the cell family; M41-T1's exact `χ_f` values are finite-graph facts |
| M45, M48, M49, M50, M51, M52, Q8 | S | finite witnesses and descents |
| M53 | B (T1, T8) | **M53-T1** Theorem A and **M53-T8** (a norm-one-avoiding additive subgroup refines the residue colouring) — the periodic-colouring sources P0 uses; the rest (T2–T15) K-specific: S |
| M54, M55 | S | critical sets and absorption of finite objects (M55-T4's peeling to the `(k+1)`-core is a finite-graph reduction) |
| M56 | B (T1, T6) | **M56-T1** (every hom of exponent `e` identifies `eΛ`-pairs; Fischer's `1/k ∈ Σ₀` obstruction) and **M56-T6** (`Σ₀` a ring; `1/2, 1/3 ∈ Σ₀` kill `2ᵃ`/`3ᵇ`-colourings): P0's additive screen expectation; the rest S |
| M57 | S | additive rigidity and Kempe gauges on finite objects (M57-T3's gauge is superseded by FS73-T1's Kempe period group) |
| MASCOT | B (T6, T10) | **MASCOT-T6** (√3-clean ⟹ residue) for the known positive; **MASCOT-T10** (striped colourings; a phase wall on `ℤ[ζ₆]` gives a translation-invariant line of monochromatic √3-pairs) — the shape a non-periodic four-colouring of hexagonal fabric takes, for §C; T1–T5, T7–T9, T11 S |
| R57, R52, R59 | S | quaternionic Theorem A, the finite-plane bound's statements, the valuation law's duality |
| M58 | B (T1) | **M58-T1** the Kloosterman spectrum: full circles at `q ≥ 59` refuse five (P0.1); T2–T3 S |
| M59, M60 | S | lifts; compulsion sets of finite planes |
| M61 | B (T3) | **M61-T3** `ϑ = ϑ′ =` Hoffman on the finite planes: linear relaxations collapse, so the obstruction half's invariant cannot be one of them (§IQ); T1, T2, T4, T5 S |
| M62, M63 (all sub-blocks), M64, FS32 | S, except M63H3-T8 | Parts's reduction machinery and the type-M arenas; **M63H3-T8** (commensurate ⟹ periodic ⟹ bounded) bears: one colouring of a finite quotient colours every commensurate multilayer (P0, §C) |
| FS25 | S | the 1581's 1-sum; the periodic circulant of finite planes |
| FS36 | S | two colours over multiquadratic fields |
| FS38 | B (D2-A, D2-B, D3) | **D2-A** tight ⟹ every colouring periodic under `H_min`; **D2-B** the tower's colouring space finite; **D3** the sign classifier. §C, P0 step 0; D1, L1–L3 S |
| ASTRA | B (T2, T5) | **T2** prime inversion (`1/2, 1/3, 1/7 ∈ ℤ[U]` at 167 follows) and **T5** the chain theorem: route (ii). T1, T3, T4, T6–T10 S |
| FS50, FS53 (T2–T4), FS62 | S | the six-colour certificates and readings |
| FS53-T1 | B | tightness at `k` needs `(k−1) \| (q+1)`: P0 step 0 reads the divisibility before any spectrum |
| FS54 | B (T6, T7) | **T6** `U₃₂` completely rigid at four colours (every maximum independent set an 𝔽₄-hyperplane): a four-colour rigidity theorem with no search, from the spectrum and a Sidon set — §C's list of every-colouring theorems at four; **T7** inert towers keep `λ_min/d`; the rest S |
| FS56 | B (T2, T5) | **T2** the field-internal blow-up and **T5** its cap (4.36 at 167): §IQ's obstruction half; the rest S |
| FS58 | B (T4, T5) | **T4** compactness (a finite forcer iff the infinite graph is rigid) — used verbatim in §IQ; **T5** the quotient screen; T1–T3, T6–T9 S |
| FS39, FS61 (T1–T4) | S | transcendence; the census's field results |
| FS61-T5 | B | the degree law's formula `φ(R)` — P0.2 pricing |
| FS66 | B (T8, W, T) | **T8** tower limit = clopen chromatic number (`P = F_clopen` at the lattice level); **Lemma W** and **Lemma T** (local transfers fail; every instrument blind to the carry) — a warning in §C against pointwise/local invariants; the rest S |
| FS70 | B (T2, T6, T9, T10) | the additive Kempe screen, the fan-gap closure, periodic = residue prime by prime, the periodic Kempe screen: P0.3's toolkit; T1, T3–T5, T7, T8, T11 S |

*No block hid a bearing that the one-line verdict would have lost; the two blocks walked line by line to check were M53 and FS38,
the nearest to periodic colourings.*

### §G.4 Method rules (`CLAUDE.md` § Grokkings [method] entries; § Toolchain; § Building; cost model; searching; the gate)

| rule | verdict | reason, and what it changes |
|---|---|---|
| G21, G30, G46, G49, G50, G51, G67, G72 | B | walked in §G.1 |
| Delegation one level deep | B | every brief (P0, P1, P2, P3) says it, with the reason (§C) |
| Standard of evidence above rung B | B | a four-colour refusal at 167 would be new mathematics: P0.5's certificate and a standalone checker are the price of any claim |
| What compute helps; GPU not a SAT accelerator | S | no GPU work planned |
| Break the symmetry before any (UN)SAT search (clique pin, precedence) | B | P0.5 (ω = 2 at 167: edge pin plus precedence) and every P0 quotient ask |
| Python 3.14 forkserver | B | P0's pools use the fork context or rebuild state in an initializer |
| Two machines; physical cores; predicted beside measured throughput | B | P0's budget in physical cores; each priced ask carries its predicted time |
| Build only through `scripts/build.sh`; `lake env lean` is not the check | B | §K (if any skeleton): elaborate with `./scripts/build.sh` only |
| One heavy job at a time; the lock | B | every P0 job over 2 min; P2's exact checks |
| Checkpoint and resume exactly [PROTECTED] | B | P0's jsonl records with fsync, resume by re-run; P2's working files current at every claim |
| A blocking run is presumed killable [PROTECTED] | B | P0 runs beside P2's launch: a P0 job that blocks the lock for a competitor's exact check is killed at its checkpoint (§S.4) |
| Kill by PID or process group; verify by effect; a lock wrapper is a parent | B | every brief |
| A pipe can kill the producer; `\| tail` hides exit status | B | P0's commands write to files; no gate read through a pipe |
| Never edit a running script | S | no long shell scripts planned |
| Generated modules and invalidation | S | no generated Lean |
| Kernel cost model (`decide +kernel`, literals, `List.all`, core not whole) | S | no kernel certificate in this milestone (FS-75 holds the three-colour one) |
| Searching (`ugrep` alternation; `rg -uu`; failed `exact?`) | B | P0's counts use `grep -oF`/`rg`; the gate's greps used Python |
| The gate (vacuity, inhabitants, axioms) | B | any stated Lean skeleton ships inhabitants; any class theorem from P2 names an inhabitant of its hypotheses (G30.5) |
| Make the gate fail; positive signal for absence; waiter condition false at arming | B | P0's controls (both outcomes reachable) and plants |
| State the uninformative outcome and confirm it reachable | B | §P: every prediction lists both outcomes |
| Pre-decide the response to your own gate failing | B | P0: a failed control halts the phase and is reported, not widened |
| Carry what a number measures; one thing differs | B | P0's prices carry lattice, degree and colour count; the stub's 10⁷/10⁸ error was exactly this (two things differed) |
| Measured half vs derived half | B | P0.5: a ball built from exact unit vectors (derived edges) makes a refusal the suspect verdict — the refusing controls are required |
| A check reads the value the code ships; formatting; two-sided plants; replay; failing-run cost; caveats stepped over; parameter count; true explanations; restore; mutate the constant; archiving; enumerate the parameter first; generator image; one-sided filters; scars | B (as one) | P0's instrument discipline: the classifier port is checked against C's shipped table; P0.2 enumerates the parameter (`M`) before screening objects; the survivor list states the generator's image (the screens run) |

### §G.5 FS-73's theorems T1–T45, individually

| T | verdict | reason, and what it changes |
|---|---|---|
| T1 | B | the Kempe period group `KPer(c)`: P0's looseness test for gap-free periodic colourings (a colouring with `KPer = 0` makes `F = 0`) |
| T2 | S | the re-periodised period `W′`; a reporting detail |
| T3 | B | forced differences compose (`F` is a group); §IQ |
| T4 | S | 2-adic depth of `8Λ` at K |
| T5 | B | `Λ = (1/9)·O_E`: the known positive's lattice is an order's scaling; §C |
| T6 | B | the 2,044-point certificate: P0.5's refusing control |
| T7 | B | `F = P = 8Λ`; the known positive; its colouring space finite (9,120). §C, §IQ |
| T8 | B | G70 exhaustively on de Grey's lattice; §C |
| T9 | S | escapes on L3 at N = 2 |
| T10 | B | "rigid-found, forcing undecided" on the rich ℚ(√3,√5) lattices: the census's typed null is FS-72's instance, and P0 reports in the same typed vocabulary |
| T11 | B | generator-graph soundness split: P0 saturates `U` (a colouring of a generator graph proves nothing about the saturated lattice) |
| T12 | S | ℚ(√11)'s `F = 3Λ` at three colours (answered by T25) |
| T13 | S | the 100-vector lattice at three colours |
| T14 | B | the fixed-prime gap lemma and its scope: P0 classifies the primes of `ℚ(√167, i)` and applies it where a conjugation-fixed prime has a gapped target at four colours — every lattice of the field is then loose at once |
| T15 | S | five-colour targets for K(√7)(i) |
| T16 | S | the classification table's loose rows (other fields) |
| T17 | B | the residue colouring at `(23, √167 − 11)`: P0's residue code and control (L3e1c94c6 coloured at 23) |
| T18 | B | 52 + 3 lattices at 167 screened at three colours: with row 45, the free theorem of §0.4 |
| T19 | B | the residue-set classification at 23 and 43: P0.1 re-runs it at four colours, with the three-colour table as the port's control |
| T20 | B | read a solver's colouring's spectrum before searching periods: P0.5 on SAT |
| T21 | B | the height lift through `K₃`'s universal cover: §C's statement of what stops at four, with `[CGHO2025coh]` as its grid form |
| T22 | B | the three-colour criterion: its ⟸ half is colour-generic (`⌊k{θ}⌋` with `θ(S) ⊆ [1/k, 1−1/k]`) — P0.3(a)'s `Θ₄` screen; its ⟹ half is what fails at four (C-5) |
| T23 | B | tight directions are affine; frozen fibres give `F` of finite index — the three-colour model of §IQ's rigidity half |
| T24 | B | density at three colours, with no arithmetic; at four colours §IQ asks only for its consequences (existence, `P = F`), since plain density fails there (T30); and the dichotomy (finite colouring space ⟺ points) answers Mixon's 2018 question at three colours |
| T25 | S | `Θ₃(Λ₁₀)` at ℚ(√11) |
| T26 | B | the `Θ`-emptiness certificate type: the model of a certificate on the group (§IQ's obstruction half) |
| T27 | B | `Ld14c588b` three-colourable by a linear form: one of the 56 lattices §0.4 drops |
| T28 | B | the rank-1 transfer-matrix decider (2,299 sets): a laboratory P2 may use to check claims in rank 1 |
| T29 | B | the four-colour no-go and the decidability equivalence: §IQ items 2–3, now with `[CGHO2025coh]` as its grid form and `[MooreNewman2000]` as its limit |
| T30 | B | rank-1 walls at four colours (first at `max D = 10`), all with `P = F = 0`: §IQ item 5 (FS-76's walls) — **and one-way, so they falsify plain density at four colours** (drawn only after Poros's late card; the first draft missed it) |
| T31 | B | gapped ⟹ `KPer = 0`; exponent-2 colourings achiral; additive iff index 4: P0's reporting |
| T32 | S | L3 loose without a gap (ℚ(√3,√5)) |
| T33 | B | the fibre-collision sandwich `D_Q ⊆ V_Q`: P0's Kempe test is membership, not index |
| T34 | B | KR6: `F ⊇ 8Λ_dG`, no periodic colouring at `N ≤ 6`, four-colourability open — an open instance, and the one lattice in the record whose colourings **are** a ℤ²-subshift over a finite alphabet (de Grey's 9,120 colourings, one per `Λ_dG`-coset): the frame-product mechanism by which a Cayley-graph colouring problem can carry a general finite-alphabet ℤ² SFT. §IQ, §C |
| T35 | B | chiral non-additive colourings are common on loose lattices; Coxeter's reading that a counterexample needs one — §C (with `[Cepas2016]`) |
| T36 | B | the normal form `F = ⋂ KPer`, `P = ⋂_{periodic} KPer`: §IQ item 2 is stated in it |
| T37 | B | C3-inherit ⟺ `P = F`; if `P` has finite index, C3 ⟺ every colouring periodic: §IQ |
| T38 | B | `F ⊆ F_μ ⊆ F_meas ⊆ P = F_clopen`: §C's split of the density question into a walls half and a recurrent half |
| T39 | B | `χ(ℚ(√167)²) ≥ 4` via `L21cc6506`: the open instance's three-colour status |
| T40 | B | the product structure `U = {1,v,v̄,z,z̄}·U_R`: P0 and §C |
| T41 | B | the 36-vector minimal obstruction: the target's nearest precedent — a half-page proof of a lower bound from an invariant |
| T42 | B | the forward lift (no parity step, no generation hypothesis): §C's statement of the class drops the generation hypothesis |
| T43 | S | P3b's controls |
| T44 | B | `L21cc6506`'s unit vectors span its key lattice: P0 may use the key or `span U` interchangeably for it |
| T45 | B | `v = ρ₄₂`: §C |

### §G.6 Extraction index: every B, the instruction it became

| instruction | phase | from |
|---|---|---|
| no screen on FS-61's 56 three-colourable lattices (four-colourable and loose by theorem) | P0 | row 45, T18, T27, row 72 |
| step 0: the tight/slack sign at `k = 4` at every usable `q`, divisibility first | P0 | G54, FS53-T1, FS38-D3 |
| classify the primes of `ℚ(√167, i)` above each small `q`; apply the fixed-prime gap lemma where it reaches | P0 | G69, T14 |
| residue-set classification at 23 and 43 at four colours, the three-colour table as the port's control | P0.1 | T19, G44, M58-T1 |
| sweep the parameter `M` first, then screen; rank candidates by supply and residue coverage | P0.2 | G61, the enumerate-the-parameter rule |
| saturate `U` before any quotient; generator graphs prove nothing | P0.3 | G68, T11 |
| screens cheapest first: `Θ₄`, residue targets, additive (expect none), quotients gap-aimed first, circular forms | P0.3 | T22, G43, G38, G41, G68, G70's family of screens (FS70-T2, T6, T10) |
| gap-free colourings: compute `KPer` by membership (T33), not index | P0.3 | T1, T31, T33 |
| factor `U` into rotations × base pattern before any tree | P0.3 | G7, G62, T40 |
| report survivors "at the periods searched"; Fourier-read any SAT colouring before a period search | P0.3, P0.5 | G21, T20 |
| price by `g·φ(R)²`; register where four-colour refusals start; stop rule on the measured rate | P0.4 | G65, FS61-T5 |
| symmetry break: edge pin + precedence (ω = 2) | P0.5 | G57, § Toolchain |
| refusing controls (T6's 2,044-point graph; Heule-510) because the edges are law-derived | P0.5 | T6, the measured/derived rule |
| the structural question in the normal form, `F ⊆ F_μ ⊆ P`, with the arithmetic stripped and the generation hypothesis dropped | §IQ, §C | T36–T38, T42, G66 |
| the kind of invariant each half admits: not a vertex-level relaxation (`χ_f`, Hoffman, ϑ); must see past `χ_f`. *[Amended at the modeling pass (finding 1): the first draft said "not a linear relaxation", but a linear programme over window-pattern frequencies is exact in rank 1.]* | §IQ | G24, G38, G60, M61-T3, FS56-T5 |
| the rigidity half is route (ii) to the target, through G55's chain | §IQ | G55, ASTRA-T5, row 44, T23–T24 |
| things worth knowing: the grid no-go is a theorem, triangles give a height, the spectral every-colouring theorems, KR6's frame product, the walls half and the recurrent half, local transfers fail | §C | G71, `[CGHO2025coh]`, `[MooreNewman2000]`, row 67, FS54-T6, T34, T38, FS66-W/T |
| the known positive and its anatomy | §C | row 78, T5–T8, G70, G16 |
| the open instances | §IQ item 5 | T34, T30, row 76, T39–T41 |
| competition design, retractions counted | P2 | G51 |
| mint the result in G67's form; count G72; G71 corrected; G50 instance | CL | G67, G72, G71, G50 |

### §G.7 What the re-grokking changed in the plan (the test of 3.1)

1. **Phase 0 shrank and moved.** Row 45 plus T18/T27/row 72 make 56 of FS-61's 57 lattices four-colourable and loose by theorem, so P0
   screens only `L21cc6506` and the saturated chain `Λ_M` — a parameter sweep the stub did not have.
2. **Phase 0 gained a step 0** (G54 at `k = 4`, divisibility first) and a prime classification (G69/T14) before any residue ask.
3. **§IQ gained the rigidity half** (row 44, G55, T23–T24): route (ii) to the target is a question about every four-colouring, and it was
   posed on Polymath16 in 2018.
4. **§IQ's "kind" is fixed by G24/G38/G60/M61-T3**: the obstruction half must see past `χ_f`, which rules out every vertex-level
   relaxation (`χ_f`, Hoffman, ϑ) and makes the fractional route at 167 equivalent to improving `χ_f(ℝ²) > 4`. *[Amended at the
   modeling pass (finding 1): "every linear relaxation" overstated it. A linear programme over window-pattern frequencies of invariant
   measures is exact in rank 1.]*
5. **§C gained a list of every-colouring theorems at four colours that the corpus already holds** (row 67/FS38-D2-A, FS54-T6), which the
   stub's "none known" had missed, and the frame-product mechanism of T34.
6. **Three predictions registered from the corpus** (P-G15, P-G54, P-G71; §P).

## §PA. The prior-art gate (WORKFLOW 3.2)

*Run 2026-09-23 by the planner, before §IQ was written and before any derivation. Scripts (throwaway, scratch):
`…/scratchpad/fs79-plan/pa/{zb.py, ax.py}`; every query and hit count is logged in `queries.jsonl` / `queries-arxiv.jsonl` there and
summarised in §PA.2. Everything found went into `BIBLIOGRAPHY.md` the same day with its read status per section.*

### §PA.1 The eight questions

1. **The object in its discipline's words.** The proper four-colourings of `Cay(Λ, S)`, `Λ ≅ ℤ^r`, form a **ℤ^r shift of finite type**:
   the **homshift** `Hom(Cay(ℤ^r, S), K₄)` on a **non-standard generating set** (symbolic dynamics). Lifting through `π : ℤⁿ → Λ`
   (one coordinate per ± pair of `S`), it is the set of configurations of the **grid homshift** `X_{K₄}^n` that are invariant under the
   relation lattice `R = ker π` (the graph-theory side calls `R`'s basis the **Heuberger matrix**, Cervantes–Krebs). The existence
   question is the **emptiness (domino) problem** for this class; the density question is **density of periodic points**; an invariant
   every configuration carries is, in the discipline's frame, a **continuous cocycle** (K. Schmidt 1995) or a **height**, and its
   averaged value a **rotation/slope**; the statistical-mechanics names are the **zero-temperature 4-state Potts antiferromagnet**, its
   **height representation**, its **Kempe (cluster-move) invariants**; the descriptive-combinatorics name for periodic colourings is
   **continuous colourings of the odometer** (G66).
2. **Two disciplines at least.** Searched under symbolic dynamics (homshifts, domino problem, cocycles), graph colouring (distance graphs,
   abelian Cayley graphs, periodic colourings, decidability), statistical mechanics (Potts antiferromagnet heights, Kempe invariants),
   topological combinatorics (Hom/box complexes of Cayley graphs), descriptive combinatorics (continuous chromatic number).
3. **The question, not only the method.** **Found, posed and open**: `[Ellenberg2018]` (MathOverflow, 2018): *is `χ(Cay(A,S)) =
   inf_N χ(Cay(A/NA, S̄))` — does a `k`-colourable one have a periodic `k`-colouring?*; carried as open in 2025 by `[CGHO2025bg]` §6.2.1
   (Question 6.2), with *"even more elementary questions such as the decidability of the emptiness problem"* for ℤ^d with an arbitrary
   generating set. Also posed on Polymath16 (G49's held-text rule): P. Gibbs, 2018 (*"If a group can be coloured, are there always periodic
   colourings?"*), and D. Mixon's opening post of the sixth thread, 2018 (*"Is it easy to check whether an infinite k-colorable graph has finitely many
   k-colorings?"*, with Boris Alexeev's lemma that finitely many `k`-colourings of an infinite-diameter unit-distance graph gives `χ ≥ k+1`,
   and the question whether Hubai's 8-periodicity of `ℤ[ω₁, ω₃]` is human-provable). `[AbrishamiEtAl2025]` Problem 4.6 (held) is the
   general-graph form.
4. **Outside arXiv.** MathOverflow (read in full through the StackExchange API: question, one answer, seven comments); the held
   Polymath16 threads (grepped: 0 hits for "decidab", "domino", "Potts", "subshift", "box complex", "Ellenberg"; 44 for "topolog", none on
   colourings of Cayley graphs; the Cayley-graph and periodic-colouring passages quoted above); zbMATH reviews.
5. **The citation graph of the poser.** Ellenberg's question is cited by `[CGHO2025bg]`; Semantic Scholar lists two works citing
   `[CGHO2025bg]` (`[CGHO2025coh]`; *Two block gluing constructions*, arXiv:2605.31237, listing only). Nobody in the thread, in
   `[CGHO2025bg]`, or in `[CGHO2025coh]` settles `k = 3` with arbitrary generators: **M. Krebs's comment (2020) settles `k = 2` and says
   `k > 2` "seems to be much more difficult"**. So FS73-T22/T24 answer a posed question at `k = 3` (a close-inventory item; a
   `CLOSED-QUESTIONS.md` entry owed).
6. **Every citing work in the neighbourhood opened.** `[CGHO2025bg]` §1 and §6.2 read; `[CGHO2025coh]` §1–§3.2 read; `[MooreNewman2000]`
   §I–§III read; the Moore–Newman citing list scanned (36 works) and the two in our neighbourhood opened at abstract level
   (`[Cepas2016]`, `[CepasAkhmetiev2020]`).
7. **Two databases.** zbMATH (reviews and summaries) and the arXiv API (abstracts); Semantic Scholar for citing lists. They agree on the
   homshift papers; zbMATH withholds most summaries in this area ("conflicting licenses"), so the arXiv abstracts were read instead.
8. **Complete author listings of the posers, in their vocabulary.** `au:"Krebs, Mike" & ab:"chromatic"` (12: the Heuberger-matrix
   programme; rank ≤ 2 relation lattices settled by `[CervantesKrebs2023]` and Krebs–Leyva, far from our 26 relations at `L21cc6506`);
   `au:"Hellouin de Menibus, Benjamin"` (22: aperiodic points in ℤ² subshifts, the aperiodic domino problem in higher dimension, the
   homshift papers — none on non-standard generators); `au:"Chandgotia, Nishant" & py:2024-2026` (6: the two homshift papers; nothing on
   arbitrary generators); `au:"Ellenberg, Jordan S." & ab:"color"` (0: the question lives only on MathOverflow); `au:"Salo, Ville" &
   ab:"coloring"` (1, unrelated).

**Recorded by the owner's request:** FS-73's gate listed both homshift arXiv titles (`plans/FS73-C3-Coxeter.md` §2, l. 61–63) and never
opened them, which is why FS-73's close recorded the decidability question as "not found". It is a G50 instance: this gate opened every
listed title that touches the question.

### §PA.2 Queries and hit counts (zbMATH Open API and arXiv API, 2026-09-23)

| discipline | queries (hits) | what they found |
|---|---|---|
| symbolic dynamics | zb `ab:"domino problem" & ab:"Cayley graph"` (4), `… & ab:"coloring"` (5), `… & ab:"colouring"` (4), `… & ab:"homomorphism"` (2), `… & ab:"graph"` (12), `ab:"hom-shift"` (1), `ab:"hom shift"` (1), `ab:"homshift"` (1), `ab:"coloring" & ab:"undecidable" & ab:"Z^2"` (4), `ab:"shift of finite type" & ab:"proper colorings"` (0), `ab:"subshift" & ab:"proper coloring"` (0); ax `abs:"domino problem" AND abs:homshift` (0), `… AND abs:"hom-shift"` (0), `… AND abs:coloring` (1), `… AND abs:"Cayley graph"` (1), `abs:homshifts` (2), `abs:"hom shifts"` (3), `abs:"strongly aperiodic" AND abs:coloring` (3), `au:Bitar AND abs:domino` (3), `abs:"H-coloring" AND abs:"domino"` (0), `abs:"graph homomorphism" AND abs:"domino problem"` (0), `abs:"vertex coloring" AND abs:"domino problem"` (0), `abs:"coloring problem" AND abs:"domino"` (0), `abs:"Wang tiles" AND abs:"graph coloring"` (0) | `[CGHO2025bg]`, `[CGHO2025coh]`, `[GangloffEtAl2026]`, Kari–Moutot (low-complexity tilings, decidable; not our class), Bartholdi–Salo (simulations; not our class), `[Bitar2023]` (SAT on groups) — **no reduction of the domino problem to colourings of Cayley graphs of ℤ^d with a fixed number of colours found** |
| graph colouring | zb `ab:"colorability" & ab:"undecidable" & ab:"periodic"` (1: `[Freedman1998]`), `ab:"doubly periodic" & ab:"coloring"` (3: `[Burr1984]`), `ab:"distance graph" & ab:"undecidab"` (0), `ab:"chromatic number" & ab:"computable" & ab:"periodic"` (0), `ab:"Cayley graph" & ab:"free abelian group" & ab:"coloring"` (0), `ab:"periodic graph" & ab:"chromatic number"` (0), `ti:"chromatic number" & ab:"Z^d"` (8, none on decidability), `ab:"distance graph" & ab:"integer lattice" & ab:"chromatic"` (1), `ab:"Cayley graph" & ab:"Z^n" & ab:"chromatic number"` (0), `ab:"chromatic number" & ab:"lattice" & ab:"periodic coloring"` (0), `ab:"chromatic number" & ab:"Cayley graph" & ab:"periodic" & py:2018-2026` (1: `[VallentinEtAl2025]`), `au:"Krebs, Mike" & ab:"chromatic"` (12); ax `abs:"periodic coloring" AND abs:"Cayley graph"` (2), `abs:"periodic colouring" AND abs:"Cayley"` (0), `abs:"chromatic number" AND abs:"abelian Cayley graph" AND abs:infinite` (0), `abs:"k-coloring" AND abs:"Cayley graph" AND abs:"decidable"` (0), `abs:"arbitrary generating set" AND abs:"coloring"` (0), `abs:"Ellenberg" AND abs:coloring` (2, unrelated) | undecidability is known only for several vertex orbits (`[Burr1984]`, `[Freedman1998]`, three colours, doubly periodic, planar); `[VallentinEtAl2025]` (every rank-4 lattice Voronoi graph's value attained periodically); the Krebs programme (few relations) |
| statistical mechanics | zb `ab:"Potts antiferromagnet" & ab:"height"` (2: `[MooreNewman2000]`, Salas–Sokal), `ab:"four-state Potts" & ab:"triangular lattice"` (1), `ab:"4-state Potts" & ab:"antiferromagnet"` (2: `[MoharSalas2009]`, Deng et al.), `ab:"Kempe" & ab:"height function"` (0); Semantic Scholar citing list of `[MooreNewman2000]` (36) | the four-colour height on the triangular lattice; Kempe/chirality invariants on hexagonal lattices (`[Cepas2016]`, `[CepasAkhmetiev2020]`) |
| topological combinatorics | zb `ab:"box complex" & ab:"Cayley graph"` (0), `ab:"Hom complex" & ab:"Cayley graph"` (0), `ab:"neighborhood complex" & ab:"infinite graph"` (0), `ab:"topological lower bound" & ab:"chromatic number" & ab:"Cayley graph"` (0); ax `abs:"box complex" AND abs:"infinite"` (1, unrelated), `abs:"Hom complex" AND abs:"Cayley"` (1, the Cayley trick, unrelated), `abs:"topological lower bound" AND …` (0), `abs:"Z_2-index" AND abs:"Cayley graph"` (0) | **nothing**: Lovász's topological method has not been applied to infinite abelian Cayley graphs in any indexed text found. The square complex of `[CGHO2025coh]` is the nearest topological object |
| descriptive combinatorics | zb `ab:"continuous chromatic number"` (3: GJKS, Lecomte, Deka et al.), `ab:"twelve tiles"` (0); ax `id:1803.03872` (GJKS abstract) | GJKS: continuous colourings of the free part of `2^{ℤ²}`; `[CGHO2025bg]` credits them with the square group and an undecidability of continuous factors |
| author listings (Q8) | as §PA.1 item 8 | as there |

**Negatives, stated as findings about where the unworked ground is:**
- No decision procedure and no undecidability proof for four-colourability (or `k`-colourability, `k ≥ 3`) of Cayley graphs of ℤ^r with
  arbitrary finite `S` was found. The only undecidability results are for several vertex orbits (`[Burr1984]`, `[Freedman1998]`) or
  vary the target graph at fixed standard generators (`[CGHO2025bg]`, `[CGHO2025coh]`: finer properties than emptiness).
- No four-colour height or cocycle theory on non-standard generating sets was found beyond `[MooreNewman2000]`'s triangular lattice.
- No application of the box/Hom complex to infinite Cayley graphs was found.
- MathOverflow's thread suggests (Pálvölgyi, Stadnicki) the answer to Ellenberg's question is "no" by a domino-problem reduction; nobody
  carried it out.

### §PA.3 What the gate taught us about our own object (carried into §IQ and §C)

1. **Our object is a relation-lattice sub-shift of the grid homshift.** `X(Λ, S, 4) = {x ∈ X_{K₄}^n : x is R-invariant}`. The discipline
   studies `X_{K₄}^n` itself (every property decidable there, `[CGHO2025bg]` §1), and its handle on invariants is the **square group**
   `π₁^□(K₄) = ℤ/2` (`ℝP²`). **Our class adds the relation cycles of `R`** — triangles, Pythagorean relations, longer odd cycles — as
   extra 2-cells, and the discipline has not studied that. So the invariant a four-colouring carries is a question about **the target
   complex built from `K₄` and the images of `S`'s relation cycles**; at the grid it is `ℝP²` (no height, `[CGHO2025coh]`), at the
   triangular lattice it supports a two-dimensional height (`[MooreNewman2000]`). → §IQ item 3 and §C.
2. **G71's four-colour sentence needs a scope.** "A four-colouring carries no height" is a theorem for square relations (the grid,
   `[CGHO2025coh]` Theorem 1.1) and false for triangle relations (`[MooreNewman2000]`). T29's structural statement (the lift through the
   cube `Q₃`) is correct as stated; its gloss "no integer height, no slope" is correct only for what factors through the square complex.
   → CL: G71 corrected; T29's prior art is `[CGHO2025coh]` for the grid.
3. **The question is a named open problem**, so an answer at `k = 4` either way is an answer to `[Ellenberg2018]` and to `[CGHO2025bg]`'s
   Question 6.2, and FS-73's `k = 3` answer is already one. → CL: `CLOSED-QUESTIONS.md`.
4. **Undecidability at four colours, if true, is not a citation.** No reduction exists in print; the thread's intuition points that way.
   The corpus holds the mechanism by which a Cayley-graph four-colouring problem carries a finite-alphabet ℤ² SFT: KR6 (T34), where
   de Grey's lattice's 9,120 colourings become the alphabet and the ρ₁₅ directions the ℤ² adjacency rules. Whether such frame products
   can encode arbitrary Wang tile sets is a question, not a result, and whether a no-go at high rank reaches rank 4 (every ℚ(√167)
   lattice) is a second question. → §IQ item 2, §C.
5. **Statistical mechanics has four-colour invariants of two further kinds**: heights with vector charges where triangles exist, and
   Kempe-dynamics invariants (chirality parity `[Cepas2016]`, linking numbers `[CepasAkhmetiev2020]`, `[MoharSalas2009]`'s Kempe
   invariant). Hubai's "one chirality choice" on the Moser ring (`[Hubai2018]`) is the same word. These are invariants of Kempe classes,
   not obstructions to existence; they bear on the rigidity half. → §C.
6. **The graph-theory side's handle is the Heuberger (relation) matrix**, settled only for few relations (≤ 2); ℚ(√167)'s lattices have 26
   and more. → §C (a pointer only).

## §IQ. The invariant question (WORKFLOW 3.3)

*Rewritten from the stub's draft. What changed and why: the stub asked for the invariant directly ("what does every four-colouring
carry, and is it complete?"); Poros's card 1 observed that this gives no way to tell a right invariant from a wrong one except
completeness, since the ℤ/2 winding is already carried by every four-colouring and is incomplete (T29). G72's instance posed a **yes/no
question about every colouring** and let the proof choose the invariant. So the structural form below is a yes/no question with three
faces, and item 3 names the **kinds** of invariant each face admits, so that "none of this kind exists" is a statement (Poros's Q2).*

**The class 𝒞_r.** Cayley graphs `Cay(Λ, S)` with `Λ` a finitely generated torsion-free abelian group of rank `r` and `S = −S` finite,
`0 ∉ S`; `S` need not generate (T42). No field, no metric, no arithmetic. `X(Λ, S, k)` is the space of proper `k`-colourings, a ℤ^r
shift of finite type; `P`, `F` are the H1 group and the forced group (row 78's normal form, T36). **The rank is a parameter of every
answer**: ℚ(√167)'s lattices have `r ≤ 4` (its plane is a four-dimensional ℚ-space), so a no at rank `r ≥ 5` does not reach the
target, and a yes proved only in rank 2 does not either.

**Each face names its class** (Poros's card A). In the fully abstract class both the rigidity and the obstruction faces have trivial
members: `S ⊇ {s, 2s, 3s}` puts a `K₄` on every `s`-line and forces period 4 along `s` (`Cay(ℤ, {1,2,3})` has exactly 24 colourings,
all 4-periodic), and `S ⊇ {s, …, 4s}` is a `K₅`. So:
- **(Q-comp)** lives in 𝒞_r itself (cliques are legitimate members; they are decided at once);
- **(Q-rig) and (Q-obs)** live in **𝒞_r^{K₄-free}**, the graphs in 𝒞_r with no `K₄` — which contains every unit-distance lattice graph,
  since four plane points are never pairwise unit-distant (row 58) — and the target's subclass is **𝒞_r^{△-free}**, the triangle-free
  ones (ℚ(√167), G57). An answer in a larger class must say what it gives in these.

1. **The existence form.** Does ℚ(√167)'s plane need five colours: is some saturated lattice `Λ_M` not four-colourable, or does some
   four-colourable `Λ_M` carry a four-colour forced pair `δ` with `1/δ ∈ ℤ[U]` (then G55's chain closes in the field)?

2. **The structural form: three questions about every four-colouring, ranked** (amended after Poros's answer to the planner's
   question 1; the ranking is the owner's call, see below). The first draft posed one question (Q) with three faces. Poros's objection,
   adopted: only (Q-comp) follows from (Q); (Q) says nothing about (Q-rig), since density holds trivially on a finite colouring space; and
   (Q-obs) is independent of both. Worse for the target, MathOverflow expects (Q) to be answered **no** by a domino reduction, and a no
   reached that way is an aperiodic encoding, probably at high rank and built from cliques, which answers `[Ellenberg2018]` and gives
   nothing at ℚ(√167). G72's bet paid at three colours because the answer there was yes. So the three faces below are **three
   structural questions**, each G72-shaped (about every colouring, answerable only through an invariant), each with its own class and
   success test. **Recommended ranking, and the default if the owner does not rule: (Q-obs) first, (Q-rig) second — both aim at the
   target — and (Q) with (Q-comp) third, where a no is still a finding (Kooshi's certificate question).** Alternative: (Q) first, as the
   stub framed it around Kooshi's certificate question; it wins if the product aim is the certificate question rather than five at 167.
   **Ruled (owner ruling R2, inventory item 31): (Q-obs) first, (Q-rig) second, (Q) third** (existence plus inheritance, as restated
   below). This matches Kooshi's stated aims: a new certificate at four colours, and new routes to five over ℚ(√167). Medium confidence;
   Kooshi may reverse it until the competition launches.

   **Density as first posed is false in rank 1, and (Q) is restated** (Poros's late card, 2026-09-23; the planner re-checked it with its
   own code, `…/scratchpad/fs79-plan/check/rank1.py`: the window-state graph of `G(ℤ, D)` modulo colour permutation, restricted to
   essential states, has edges between different strongly connected components — patterns that occur in a four-colouring and in no
   periodic one — for exactly `{1,5,7,10}` (8 such edges), `{3,5,9,10}` (4), `{3,7,9,10}` (24), `{5,7,9,10}` (2), the numbers Poros
   reported, and none on the controls `{1,3,4,5}`, `{1,2,4,8}`, `{2,3,5,9}` at four colours or on the three-colour controls). These are
   FS73-T30's four walls: **one-way walls**, legal four-colourings whose local patterns no periodic four-colouring contains. They are
   K₄-free (not triangle-free), have `P = F = 0` (T30) and have periodic four-colourings (`[EggletonErdosSkilton1990]`), so existence and
   inheritance survive in rank 1 while density fails. **A planner's miss**: §G.5 marked T30 as bearing on item 5's instances and did not
   reason that a one-way wall falsifies density. The restated question keeps what FS-73 proved at three colours and what is still open:

   > **(Q) For every graph in 𝒞_r: does four-colourability imply a periodic four-colouring (C3-aper, `[Ellenberg2018]`'s question at
   > `k = 4`), and is every difference identified by all periodic four-colourings identified by all four-colourings (C3-inherit,
   > `P = F`)?** *Sharper optional form:* are periodic colourings dense in the support of every invariant measure (`F_μ = P`, T38's
   > recurrent half)? One-way walls carry no invariant measure, so rank 1 does not refute it.

   At `k = 3` all three hold for every rank (T22–T24). **Why it is not the existence form reworded:** no single colouring answers it. A
   yes needs something every four-colouring carries that lets it be matched by periodic colourings (at three colours: the height, its
   slope, the McShane extension). A no needs a four-colourable graph with no periodic colouring, or a pair every periodic colouring
   identifies and some colouring separates, with a proof — which only an invariant can certify. (C3-inherit at four colours is FS-76's
   question 1; the owner's ruling R1 lets FS-79 take it.) It has three faces, each with its own consequence:
   - **(Q-comp) the completeness face — Kooshi's certificate question.** A yes on 𝒞_r makes four-colourability decidable there (refusals
     by compactness, colourability by a periodic colouring) and gives two-sided certificates (FS73-T29's equivalence), and `P = F`, so
     every forced pair is visible to periodic colourings. A no is either an explicit four-colourable graph in 𝒞_r with no periodic
     four-colouring (C3-aper fails; `[Ellenberg2018]` answered no) or, strongest, undecidability of four-colourability on 𝒞_r. Either
     answer states its rank.
   - **(Q-rig) the rigidity face — route (ii) to the target.** *For which graphs in 𝒞_r is the four-colouring space finite* (equivalently
     `F` of finite index, T37)? At three colours: exactly when every cell of `Θ₃` is a point (T24), which is D. Mixon's 2018 Polymath16
     question answered for these graphs. At four colours the known positive is de Grey's lattice (9,120 colourings, `F = 8Λ`, row 78).
     For the target, finiteness is not the whole requirement: five follows in the field from a forced `δ` that is a unit at every
     conjugation-stable prime (§0.5, Poros's card B), so the face's target-grade form is *when does `F` contain an element prime to the
     stable primes?* — a residue-rigid lattice (`F = 𝔭Λ` at a usable 𝔭) is rigid and gives nothing.
   - **(Q-obs) the obstruction face — route (i) to the target.** *Is there an invariant carried by every four-colouring, of a named kind
     (item 3's list is not exhaustive), whose admissible values form a set computable from `S` that is empty for some graph in
     𝒞_r^{K₄-free} that is not four-colourable but has fractional chromatic number at most four?* (A finite refuting subgraph always
     exists by compactness; the question is for a certificate that is an invariant of every colouring, not a subgraph.) **Its success
     test is by size, not by kind** (owner finding 1, inventory item 29): *a sound certificate of any kind, densities included, checkable
     in time polynomial in its bit size, whose bit size is bounded by a stated function of the presentation of `(Λ, S)` that mentions no
     refuting subgraph, and which on the instance is smaller than the best finite refutation known.* The benchmark's `χ_f ≤ 4` already
     rules out the one-point density bound. A clause excluding "density certificates" is therefore unnecessary, and it would exclude the
     averaging move G72 names (item 3, kind 0_W). **It requires rank ≥ 2** (Poros), because rank 1 is decided already:
     `G(ℤ, {1,3,7,12,17,22})` is triangle-free (the set is sum-free) and has the periodic independent set `{0, 2, 4, 6, 10, 15, 20, 25}`
     mod 29, of density 8/29, so `χ_f ≤ 29/8 < 4`. It refuses four colours on **33** consecutive points and is colourable on 32 (the
     advisor's check and the modeling agent's, independently; the first draft's "a window of 176" was true but not sharp). Its window-state
     graph has 3,555 states modulo colour permutation, none on a bi-infinite walk. So the rank-1 transfer matrix decides it with a
     certificate on the group, and that certificate is about as large as the 33-point refutation: rank 1 shows nothing either way. A second
     rank-1 control, the advisor's: `D = {1,6,8,11,12}` is K₄-free, has independence density ≥ 1/4 (a period-20 set; the advisor reports
     exactly 1/4), and has 2,348 window states, none essential. The precedent for a certificate that beats the finite route is `Θ₃`'s
     5.7 KB against refuting patches priced near 10⁸ points. *[Amended at the modeling pass. The first draft required "a certificate that
     is not a density certificate" and called the rank-1 benchmark "met vacuously"; see §R-review.]* **No rank-≥2 K₄-free graph with `χ_f ≤ 4` certified and `χ = 5` is known** (Theorem B four-colours
     every K-lattice; the five-chromatic lattices over K(√5), K(√7) and de Grey's field have no `χ_f ≤ 4` certificate); finding one, or
     working with "not refuted by any density certificate" in its place, is part of the task (G30.5). A yes is a certificate of non-four-colourability that lives on the group and sees
     integrality (the four-colour analogue of `Θ₃ = ∅`). A no-go says either that the kind cannot refute some named instance at all, or
     that its certificates fail the size test on some family (their size tracks the refuting subgraphs). *[The first draft read "every
     invariant of that kind is controlled by the colour-class densities", which holds only for one-point densities (finding 1).]*
     **This face is independent of (Q-comp)**: undecidability would leave it open, because the target needs only a sound,
     one-sided certificate that scales with the symmetry (Poros's Q2).

3. **The invariant it forces: none known for 𝒞_r at four colours.** What is known, by kind (so that a no-go can name its kind):
   - **Kind 0₁, one-point densities** (the colour-class densities of invariant measures on the colouring space; each class is an
     invariant independent set). Averaged and linear; the fractional bound (G60) and the ratio/Hoffman bound are its shadows. Sound and
     one-sided, and **controlled by `χ_f`**: it refutes `k` colours only where the independence density is below `1/k`, and for Cayley
     graphs of ℤ^r that density is `1/χ_f` (standard, by Følner averaging). At ℚ(√167) a certificate of this kind for five would prove
     `χ_f(ℝ²) > 4`, beyond the best known bound (`[MatolcsiEtAl2025]`, ≥ 4). Where the graph is Hoffman-tight, densities already force
     structure: every colouring is periodic under `H_min` (FS38-D2-A), and `U₃₂` is completely rigid (FS54-T6).
   - **Kind 0_W, window-pattern frequencies at a finite window `W ⊂ Λ`** (the `W`-marginals of invariant measures: the frequency of each
     admissible colouring of `W`; pair statistics are the case `W = {0, s}`). Their admissible set lies in the local-consistency polytope:
     probability vectors on the admissible `W`-patterns that agree on the overlaps of `W` with its translates. Its emptiness is the
     infeasibility of a linear programme, certified by a Farkas vector. **This kind is not controlled by `χ_f`.** In rank 1, at the window
     `[0, max D]`, a consistent vector is a circulation on the window-state graph. A circulation exists iff that graph has a cycle, which
     holds iff the colouring space is nonempty. So there the programme is exact, and it refutes `G(ℤ,{1,3,7,12,17,22})` although
     `χ_f ≤ 29/8` (owner finding 1, checked by the advisor and by the modeling agent). In rank ≥ 2 each fixed window gives a relaxation.
     A window large enough to hold a refuting subgraph gives only that subgraph's refutation in LP form, which is why (Q-obs) is scored by
     size (item 2). **Posed, not answered:** how does FS-73's `Θ₃` relate to this kind?
   *[Amended at the modeling pass (owner finding 1). The first draft had a single "Kind 0, densities (invariant means of cylinder events:
   colour-class densities, pair statistics)" and called it controlled by `χ_f`. That conflated the two rows above.]*
   - **Kind 1, heights** (continuous cocycles into ℤ^m in K. Schmidt's sense, their slopes): the three-colour tool (T21). For the grid at
     four colours there is provably none (`[CGHO2025coh]` Thm 1.1: the square group of `K₄` is ℤ/2). With triangle relations there is a
     two-dimensional one (`[MooreNewman2000]` §III). For arbitrary `S` — which relation cycles the lattice has — unknown.
   - **Kind K, Kempe-class invariants** (chirality parity `[Cepas2016]`, linking numbers `[CepasAkhmetiev2020]`, `[MoharSalas2009]`;
     the Kempe period group `KPer`, T1): invariants of recolouring classes. They bear on (Q-rig), not directly on existence.
   - **Kind C, counting compulsions on a base pattern** (G53: `L = min` over the base's colourings of how many circle points share the
     centre's colour; refuse when `2L` exceeds the count): one-sided and **integral**, computed on the pattern and not the graph — the
     corpus's precedent for certifying a multilayer on its layers, and `L21cc6506` is a multilayer (T40).
   - **Kind T, the domain's topology** (Lovász's bound: the ℤ₂-index of the graph's box or neighbourhood complex, `[Lovasz1978]`): the
     classical integral obstruction that sees past `χ_f` (Kneser graphs: `χ_f = n/k`, `χ = n − 2k + 2`). §PA found no application to
     infinite abelian Cayley graphs — unworked ground, not a reason to omit it (Poros).
   - **Kind A, algebraic** (an equivariant Nullstellensatz or ideals in the group ring `ℤ[Λ]`; K. Schmidt's algebraic ℤ^d-actions for the
     linear part; the project's stub FS-10): exact rather than a relaxation, and it can see parity where a linear programme cannot (Poros).
   - **Higher kinds from the target** (invariants taken from the target complex's topology above its loops): not found in any text
     searched (§PA.2's topological-combinatorics row returned nothing for infinite Cayley graphs).

   **Finding an invariant that answers one face, or proving that no invariant of a named kind can, is the milestone.**

4. **Its route: derivation only**, by two competitors and an advisor (P2). Exact computation checks a derived claim (a certificate, a
   control, an instance); no search answers (Q). Phase 0 is a measurement that runs beside the plan and answers none of the faces.

5. **The open instances it would decide** (aim every new exact procedure at these the day it lands, G72's *Do*):
   - **ℚ(√167):** `L21cc6506` at four colours (60 unit vectors, rank 4, not three-colourable; colourable, loose or rigid at four?), and
     phase 0's survivors among the saturated `Λ_M` — slot **[P0-SURVIVORS]**, filled from `data/fs79/records/phase-P0.md`;
   - **KR6** (FS-77, T34): rank 6, `F ⊇ 8Λ_dG`, no periodic colouring at `N ≤ 6`, four-colourability open — its colourings are a ℤ²
     subshift over de Grey's 9,120 colourings;
   - **FS-72's rank-8 lattice** `group:u3:2+w4` over ℚ(√3,√5): no additive or periodic four-colouring found, six undecided attempts;
   - **the rich 2-unit lattices over ℚ(√3,√5)** (T10): rigid-found, forcing undecided;
   - **FS-76's rank-1 walls** (T30): four-colour walls first at `max D = 10`, all with `P = F = 0` — the rank-1 laboratory, where every
     `k`-colourable graph has a periodic colouring (`[EggletonErdosSkilton1990]` Thm 2) and the walls are **one-way** (they falsify
     plain density at four colours; Poros's scan and the planner's re-check), so rank 1 is settled for existence and density and open only
     for the recurrent half;
   - **controls every class-level answer must reproduce:** de Grey's lattice (**the known positive**: finite colouring space, `F = P = 8Λ`,
     12 classes, one √3-clean — Theorem B's pair); the triangular lattice (a two-dimensional height, `[MooreNewman2000]`); the grid
     `ℤ²` with standard generators (no height, `[CGHO2025coh]`); `Cay(ℤ, {1,2,3})`, the clique-rigid member (24 colourings, all
     4-periodic) that any K₄-free (Q-rig) theorem must exclude; `G(ℤ, {1,3,7,12,17,22})`, the rank-1 inhabitant of (Q-obs)'s benchmark.

## §S. The subplan (WORKFLOW 4)

### §S.1 Routes, in one table

| route | face | who | output |
|---|---|---|---|
| R0 — measure the ℚ(√167) population at four colours | none (item 5) | P0 implementer | `data/fs79/records/phase-P0.md`: the four-colour residue-set tables at 23 and 43, the `Λ_M` sweep, `L21cc6506`'s four-colour status, survivors typed by the periods searched, prices, at most one direct ask |
| R1 — the structural question by derivation | (Q-comp), (Q-rig), (Q-obs) | two competitors, one advisor | two working files, each theorem with its class, rank and kind; the retraction tally |
| R2 — verify and aim | all | the owner, the other competitor or the advisor, and (only if a procedure must be coded) one fresh implementer | each key step re-derived once by the other side and once by the owner; every new exact procedure run on §IQ item 5 the same day, with controls |
| R3 — close | — | a fresh close planner | WORKFLOW 9 from the close inventory; G72's first count |

### §S.2 The phases

**P0 — the measurement (running during the plan; its spec was sent to the owner at the plan's opening and is reproduced here).**
- *Purpose.* Measure, not decide: which ℚ(√167) lattices could need five colours, and what a direct four-colour refusal would cost on the
  richest of them. Feeds §IQ item 5 and FS-59. The results go to the owner; §C is written from §IQ and receives only the instance-list slot
  [P0-SURVIVORS].
- *The free theorem first* (§0.4): only `L21cc6506` and the saturated chain `Λ_M` are screened.
- *Step 0 (G54, FS53-T1, FS38-D3).* For each usable `q` of ℚ(√167) up to 100, the divisibility test `3 | (q+1)` and then the exact
  spectral sign of `λ_min + d/3` of `Γ_q` at four colours (only 23 can be tight by Weil; 59, 71 and 83 pass divisibility but fail the Weil
  bound). And the splitting of each small prime in `ℚ(√167, i)`: which primes are conjugation-stable (T14's gap lemma reaches every lattice
  of the field at once where a stable prime has a gapped four-colour target).
- *P0.1 Residue-set classification at four colours* (C's rule, T19). Every antipodal residue subset of the circle mod 23 (24 points) up to
  rotation and reflection, and mod 43 up to 7 antipodal pairs (more if cheap): four-colourable or not; if colourable, whether some
  colouring is gapped. Controls: at `k = 3` the port reproduces C's table exactly (224 classes, 98 colour, 126 refuse,
  `data/fs73/q167/classify-23.jsonl`); the full 24-point circle refuses four (row 71).
- *P0.2 The sweep over the parameter `M`.* For `M` along a chain (every `M ≤ 2520`, then multiples of 420 and of 2520 to 30,240 or the
  stop rule): `U_M`, `g = |U_M|`, rank, covolume, the residue sets at both primes above 23 and above 43 and whether each refuses four
  (by P0.1), the stable primes dividing nothing in `U_M`'s denominators, and G65's price (points at average degree 14, 18, 22, 26 by
  `degree = g·φ(R)²`). **Candidate** := every residue set at 23 and at 43 refuses four. A `Λ_M` known three-colourable (`Θ₃ ≠ ∅` by the
  FS-73 tools, or any periodic three-colouring) is dropped as four-colourable and loose (row 45), with the reason.
- *P0.3 The periodic four-colour screens*, on `L21cc6506` and on every candidate (the cheapest 10 by price if more), cheapest first:
  (a) `Θ₄ := {θ : θ(U) ⊆ [1/4, 3/4] mod 1} ≠ ∅` ⟹ four-colourable (T22's ⟸ half at `k = 4`; one-sided), by an exact tree;
  (b) residue targets at every usable `q ≤ 100` not dividing `M` (23, 43, 59, 67, 71, 79, 83; and 29 and the ramified prime above 167, as T18
  used), plain and gap-aimed; (c) additive colourings into ℤ/4 and `V₄` (exact linear algebra; `[Fischer1990]` predicts none where `v`
  is present — report); (d) full quotients `Λ/NΛ` at admissible `N`, 300 s per ask, gap-aimed first, with `KPer` computed by membership
  (T33) on gap-free colourings; (e) circular forms `⌊4{φ}⌋` to `N ≤ 240`. First factor `U` into rotations × a base pattern (G62, T40)
  and use the point group, Galois part included (G27), to reduce every table; with point-group-equivariant finders, filter by G58's
  fixed-colour test. Each lattice is reported **FOUR-COLOURABLE** (rule, period group, gapped or not, looseness only through a gap or
  `KPer = 0`) or **SURVIVOR AT** the exact screens and periods searched — never "none" (G21).
- *P0.4 Pricing, arithmetic only.* Each survivor's ball radius and point count at degrees 14–26; name the cheapest. Register, before any
  ask, the degree at which four-colour refusals are expected to start (G65's diagram is three-colour).
- *P0.5 One direct ask*, only if the cheapest survivor's ball at degree ≥ 18 is ≤ 5·10⁶ points: build it exactly; break the symmetry (ω = 2
  at 167, so pin one edge's two colours and add the precedence constraint on the other two, § Toolchain item 2); kissat and cadical,
  1,800 s wall each, under the lock. SAT: verify the colouring on every edge and Fourier-read it for a period (T20). UNSAT: extract the core,
  an LRAT, and a **new** standalone standard-library checker (the frozen `fs58_check_witness` and `fs73_cert_check` are three-colour and
  de Grey-specific) with at least five planted faults, each refused by name; report to the owner at once. UNKNOWN: a typed null with its
  budget.
- *Controls (both outcomes reachable).* Colourable: de Grey's lattice over K is four-coloured by the quotient code at `N = 8` and refused at
  `N = 5, 7`; `L3e1c94c6` is coloured by the residue screen at 23. Refusing: the 2,044-point graph of
  `data/fs73/census/cert/t-16_8_8_0-R1.5/` and Heule-510 return UNSAT through P0.5's encoder and symmetry break (the edges are law-derived,
  so a refusal is the suspect verdict and needs these). Plant: a non-square in place of `√167 mod 23` breaks the residue check.
- *Budget* ≤ 350k tokens; ≤ 5 h wall; ≤ 8 core-hours of solver; ≤ 32 GB per job; every job over 2 min or 8 GB under the heavy lock,
  `setsid` with a pgid file.
- *Stop rules.* The sweep stops at `M = 30,240` or when the cheapest candidate's degree-18 price passes 10⁸ points; quotient asks 300 s
  each; the phase at 5 h wall; a failed control halts the phase and is reported, never widened.
- *Checkpoint* `data/fs79/phase0/*.jsonl` (append and fsync per record; every subcommand skips records present). *Resume:* re-run the same
  subcommand of `tools/fs79_p0.py`. *A kill redoes* at most the in-flight ask (≤ 300 s; ≤ 30 min in P0.5).
- *Record* `data/fs79/records/phase-P0.md`, with the heading "Theorems this phase proved".
- *May claim:* four-colourability with its rule and period group; looseness only with a gapped colouring or `KPer = 0`; "survivor at the
  periods searched"; prices; a refusal only with the new checker's CERTIFIED and its plants refused. *May not claim:* "no periodic
  colouring"; anything about forcing; `χ(ℚ(√167)²) ≥ 5` without the checked certificate (if it lands: the target is met by search, and
  G72's count must say so); any reading of survivors as "likely to need five".

**P1 — the modeling passes (a fresh agent, after this plan is scored).** Domain, then obligation (§M). No Lean skeleton is written at the
plan stage (§K). Budget ≤ 300k tokens; the output is edits to §IQ, §C and §K committed per pass. Checkpoint: this file, committed after
each pass; resume from the last committed pass. A kill redoes the pass in flight.

**P2 — the competition (R1).** Two fresh competitors, de Bruijn and Coxeter, briefed identically from §C; a fresh Poros advising both,
briefed from §C.3 and holding the owner's and the plan-phase advisor's held items, offered to both at once after each has written its own
first route (the owner's ruling R1 of FS-73).
- *Launch condition:* P0 finished or killed at a checkpoint (the three-agent cap), P1 committed, §C's slots filled by the owner.
- *Budget:* ≤ 450k tokens each (FS-73's anchors: 360–410k per competitor, 480k for the advisor); about 2 h wall; exact checks under the
  heavy lock.
- *Stop rule:* each competitor hands back at a theorem or counterexample with its key step read by the advisor, or at 450k tokens, or at
  2.5 h wall, whichever first, at a clean boundary; the advisor is stood down when advising has ended (protocol §3).
- *Checkpoint:* each competitor's working file `{SCRATCH}/FS79-C-{NAME}.md`, current at every claim and every retraction (kept and
  marked); the advisor's record in its scratch. *Resume:* a successor reads the working file. *A kill redoes* the step since the last
  write.
- *Acceptance:* every claim carries its class (𝒞_r, K₄-free, triangle-free), its rank, its kind, its grade, and a named inhabitant of its
  hypotheses (G30.5); every theorem's key step read by the advisor; retractions counted; each working file ends with the heading
  "Theorems this phase proved"; the working files moved into `plans/` by the owner only after both hand back.

**P3 — verification and aiming (R2).** Each theorem's key step re-derived once by the other competitor or the advisor and once by the owner;
any exact check re-run by someone who did not write it, with a planted fault; **every new exact procedure pointed at §IQ item 5 the same
day** (G72's *Do*), controls first (the known positive, the triangular lattice, the grid). If a procedure must be coded, one fresh
implementer (≤ 300k tokens, ≤ 1 day wall, checkpoint `data/fs79/p3/*.jsonl`, resume by re-run, a kill redoes the in-flight instance).
The record `data/fs79/records/phase-P3.md` carries "Theorems this phase proved".

**CL — the close (R3).** WORKFLOW 9 from `plans/FS79-close-inventory.md`: the new ledger row (if any), `plans/FS79-derivation.md`, § B
lines, the §G and §IQ re-reads (G72's first count), the conjecture sweep, forward propagation, FS-59/FS-76/FS-77/FS-72/FS-74 re-aimed,
G71 and T29 corrected by §PA.3 item 2, G50's new instance, `CLOSED-QUESTIONS.md` for `[Ellenberg2018]` at `k = 3`.

### §S.3 Acceptance checklists (what · verified how · pass condition)

| phase | what | verified how | pass |
|---|---|---|---|
| P0 | the classifier port | `k = 3` against C's shipped table | exact match (224 / 98 / 126) |
| P0 | the residue plant | a non-square root of 167 mod 23 | the check fails, by name |
| P0 | quotient controls | de Grey's lattice at `N = 8, 5, 7` | SAT, UNSAT, UNSAT |
| P0 | refusal controls | the 2,044-point graph and Heule-510 through P0.5's encoder | both UNSAT |
| P0 | every FOUR-COLOURABLE row | a standalone exact check of its rule on every unit vector | 0 failures |
| P0 | every SURVIVOR row | its screens and periods listed | present on every row |
| P0 | the price formula | `φ(R)` at de Grey's lattice ball, `R = 1.5`, `g = 54` | degree ≈ 18.4, within 2 % |
| P0 | predictions | registered in the record before any run | timestamp before the first run |
| P1 | each pass | a fresh Skill invocation, committed before the next | one commit per pass |
| P2 | each claim | class, rank, kind, grade, inhabitant | all five present |
| P2 | each theorem | its key step read by the advisor | the advisor's note in its record |
| P2 | retractions | counted in each working file and by the advisor | a tally in both |
| P3 | each theorem | re-derived by the other side or the advisor, and one step by the owner | two independent readings |
| P3 | each new procedure | run on §IQ item 5 with the three controls first, and a plant | controls pass, the plant fires |
| CL | the inventory | every item ticked or declined with a reason | none open |

### §S.4 Sequencing under the three-agent cap and one heavy job

| window | agents (≤ 3) | heavy lock |
|---|---|---|
| now | the planner, the plan-phase Poros, the P0 implementer | P0 only |
| after the plan is scored | the P1 modeling agent, the P0 implementer (if still running) | P0 only |
| P2 | two competitors, the competition Poros — **P0 must be finished or killed at its checkpoint first** | the competitors' exact checks; a P0 job still holding it is killed at its checkpoint (the blocking-run rule) and its forfeit named |
| P3 | the owner, at most one implementer, and whichever competitor is asked to re-derive | P3 jobs |
| CL | a fresh close planner | none planned |

**Budget, the whole milestone** (FS-73's anchors in brackets): planner ≤ 450k [580k]; plan-phase Poros ≤ 450k; P0 ≤ 350k [400–560k];
P1 ≤ 300k; P2 ≤ 3 × 450k [360–410k, 480k]; P3 ≤ 300k; close ≤ 500k [490–535k]. Wall: P0 ≤ 5 h; P2 ≈ 2–2.5 h; P3 ≤ 1 day.

### §K. The Lean skeleton: none at the plan stage

**Decision.** No Lean module is written at the plan stage. *Alternative weighed:* state (Q)'s three faces as `Prop`s now, beside
`InheritanceQuestion` in `Proofs/HadwigerNelson/Kempe.lean` (density: every finite pattern of a colouring is a pattern of a periodic
colouring; finiteness of the colouring space). *Why not:* no theorem of this milestone consumes them yet, a new module costs a build, and
FS-73's `InheritanceQuestion` already states the one face the kernel has a use for; a `Prop` with no consumer is a statement nobody reads.
*Confidence:* medium — if P2 lands a class theorem whose kernel form is cheap, P1's successor (P3) writes the skeleton with its
inhabitants then. The P1 domain pass may overturn this; it records why.

## §P. Registered predictions (each with both outcomes reachable)

*Registered 2026-09-23, before any phase-0 run and before any competitor is briefed. Ids carry their phase (FS-73's namespace lesson).*

**The milestone's outcome (P2's headline), a partition:**

| id | outcome | p | reachable because |
|---|---|---|---|
| P-A | **(Q) answered yes** in a class that contains rank-4 triangle-free graphs (reaches ℚ(√167)): existence of periodic colourings (hence decidability and two-sided certificates) and `P = F` there | 0.05 | at three colours the same question fell in one competition; nothing known forbids it at four in low rank |
| P-A′ | (Q) or (Q-rig) answered yes in a **subclass that does not reach ℚ(√167)** (rank 2; triangle lattices through `[MooreNewman2000]`'s height; Hoffman-tight graphs through FS38-D2-A) | 0.15 | the height and spectral theorems already exist for such subclasses |
| P-B | **(Q-comp) answered no**: an explicit four-colourable graph in 𝒞_r with no periodic four-colouring, or undecidability, with proof and its rank | 0.12 | the frame-product mechanism (T34) and the domino problem make it plausible; MathOverflow's intuition points there |
| P-B′ | a **no-go of a named kind** (e.g. every kind-1 invariant is trivial on 𝒞_r^{△-free}; or window-frequency certificates at a fixed window fail the size test on a named family) without settling (Q) | 0.18 | `[CGHO2025coh]`'s method is available and G71's grid half is already such a theorem. *[Amended at the modeling pass (finding 1): the first example, "every kind-0 invariant is controlled by `χ_f`", is false for window frequencies and already known for one-point densities (kind 0₁), so it was no result P2 could land.]* |
| P-O | **(Q-obs) answered yes on at least one explicit graph**: a certificate from an invariant of every four-colouring that refuses four colours where `χ_f ≤ 4` | 0.08 | Θ₃'s emptiness did exactly this at three colours; G53's counting compulsion is an integral precedent |
| P-C | **not landed**: sharpened reductions, a subclass with an invariant candidate, a candidate family (the stub's fallbacks) | 0.42 | the default |

The uninformative outcome is P-C; the most informative for the target are P-A and P-O; for Kooshi's certificate question P-A and P-B.

**From the corpus (§G's F verdicts):**

| id | prediction | p | the other outcome, reachable because |
|---|---|---|---|
| P-G72 | if anything in P-A…P-O lands, it comes through the structural question (§IQ item 2) and not from a search or an extension of a known tool | 0.8 | P0's direct ask could land five at 167 by search (P0-c's other branch) |
| P-G71 | a four-colour rigidity theorem over a class of **K₄-free** Cayley graphs that uses no arithmetic of the lattice (G71's killing test, restated so a clique cannot meet it — Poros's card A) | 0.15 | `[MooreNewman2000]`'s height is arithmetic-free and could force rigidity where extra directions fix the tilt |
| P-G15 | an obstruction from P2 that does not factor as pigeonhole × kill | 0.05 (0.6 given P-O) | a polytope-emptiness certificate has no class pigeonhole |
| P-G54 | step 0 finds `Γ₂₃` Hoffman-**slack** at four colours (so no usable prime of ℚ(√167) is four-tight and G54's tight mechanism cannot give full-rank `F` there) | 0.8 | 23 passes divisibility and the Weil bound; only the exact spectrum decides |
| P-MO | if (Q-comp) is settled in P2, it is settled **no** (MathOverflow's expectation, Poros's registration request) | 0.7 | the three-colour answer was yes, with no arithmetic; a height or spectral argument could extend in low rank |
| P-rank | if a no to (Q-comp) lands, it needs rank ≥ 5 or cliques, so it does not reach ℚ(√167) | 0.75 | a rank-4 triangle-free encoding is not excluded by anything known |

**Phase 0 (the planner's; the implementer registers its own before any run):**

| id | prediction | p |
|---|---|---|
| P0-a | `L21cc6506` has a periodic four-colouring found by P0.3 | 0.75 |
| P0-b | at least one candidate `Λ_M` with `M ≤ 30,240` exists (every residue set at 23 and 43 refuses four) | 0.6 |
| P0-c | the cheapest survivor's degree-18 ball exceeds 5·10⁶ points, so P0.5 is not run | 0.65 |

## §M. The modeling passes (WORKFLOW 6)

- **Domain (`debruijn-domain-modeling`), always.** Its object here is the statement of (Q) and its faces: whether 𝒞_r, 𝒞_r^{K₄-free}
  and 𝒞_r^{△-free} are the right classes; whether the kinds of §IQ item 3 are the right partition; whether any face should be stated in
  Lean now (§K's decision is its to overturn, with the reason).
- **Obligation (`debruijn-obligation-modeling`), yes.** The milestone proves claims over all colourings of a class; the pass decomposes
  what a yes and a no to each face must establish (for (Q-comp) yes: the invariant, its realisation by periodic colourings, the
  extension step; for no: the reduction and its correctness; for (Q-obs): soundness of the certificate and its computability), so §C can
  state them as obligations the advisor checks.
- **Experience (`debruijn-experience-modeling`), no**, unless the domain pass writes Lean statements, in which case a light pass on their
  docstrings. The milestone crosses no consumer boundary otherwise; §C is a brief, and its register is the protocol's.
- **Order:** domain → obligation (→ experience if triggered), each a fresh Skill invocation, each committed before the next. A fresh agent
  runs them (FS-73: the plan and the passes together overran one agent).

## §C. The competition's brief: the slots of `plans/PROTOCOL-competitor-and-advisor.md` §4 and §5, filled

*For two briefs identical except `{NAME}` / `{OTHER}` ("de Bruijn" / "Coxeter") and `{SCRATCH}`. Everything outside these slots (the
register, the hint protocol, "what is yours to decide", the two standing obligations) is the template's. Written from §IQ, not from
phase 0: the one phase-0 slot is the instance list [P0-SURVIVORS], which the owner fills from `data/fs79/records/phase-P0.md`. The
owner's held items are not here and reach the competitors only through the advisor, after each has written a first route.*

### §C.1 "The mathematics you are standing on"

The project attacks the Hadwiger–Nelson problem: how many colours the plane needs so that no two points one unit apart share a colour
(5, 6 or 7). Over a real field `F` a **lattice** is the ℤ-span `Λ ⊂ ℂ` of finitely many unit vectors of `F²`; `U = Λ ∩ S¹` is finite
and `Cay(Λ, U)` is its unit-distance graph. **The abstract class** is every Cayley graph `Cay(Λ, S)` of a finitely generated
torsion-free abelian group `Λ` of rank `r`, with `S = −S` finite and `0 ∉ S`; no field, no metric. `X(Λ, S, k)` is its space of proper
`k`-colourings, a ℤ^r shift of finite type; a colouring is **periodic** if a finite-index subgroup fixes it. The forced group `F` (the
differences every `k`-colouring identifies) and the H1 group `P` (the differences every periodic `k`-colouring identifies) are subgroups,
`F ⊆ P` (`Proofs/HadwigerNelson/Kempe.lean`: `forcedSubgroup`, `periodicForcedSubgroup`, `InheritanceQuestion`,
`forces_iff_exists_finite`).

1. **Three colours are settled, for the whole class, with no arithmetic** (`LEDGER.md` row 79; `plans/FS73-derivation.md` T21–T24, T42;
   `CLAUDE.md` G71). Every three-colouring lifts through `K₃`'s universal cover (the line) to an integer **height** with a winding on the
   relation lattice `R` and a **slope** in a rational polytope; `Cay(Λ, S)` is three-colourable iff
   `Θ₃ = {θ ∈ Hom(Λ, ℝ/ℤ) : θ(S) ⊆ [1/3, 2/3]} ≠ ∅`; periodic three-colourings are **dense** (a McShane-type extension); so `P = F`, and
   `F` has finite index iff every cell of `Θ₃` is a point. The `Θ`-emptiness certificate (T26) proved `χ(ℚ(√167)²) ≥ 4` (T39–T41; a
   half-page proof on 36 vectors).
2. **Why it stops at four, as FS-73 understood it** (T29): label colours by `V₄`; every closed 4-walk of `K₄` lifts through the cube `Q₃`,
   `K₄ = Q₃/antipode`, so `K₄`'s square complex is `ℝP²` and a four-colouring carries, through that complex, only a winding in
   `Hom(R, ℤ/2)`. In rank 1, `G(ℤ, {1,3,4,5})` is four-colourable with no linear colouring (the word `0,1,0,1,2,3,2,3`).
3. **The known positive** (row 78; T5–T8): on de Grey's lattice `Λ = (1/9)·O_E`, `E = ℚ(√−3, √−11)` (rank 4, 54 unit vectors), **every
   four-colouring is `8Λ`-periodic**, `F = P = 8Λ`, from one 2,044-point certificate that `(0, v)` is forced, `v = −(4/9)(1+√−11)`, and
   the point group's orbit of `v` spanning `8Λ`. There are 9,120 colourings (380 with the colours pinned), 12 classes, one √3-clean
   (Theorem B's pair of residue colourings, G70). Hubai counted the same 9,120 on the Moser ring in 2018 (`[Hubai2018]`: stripes of period
   2 on the Eisenstein sublattice and one chirality choice). It is Hoffman-**slack** at four colours (FS-73 §R0), so no spectral argument
   explains it.
4. **The normal form** (T36–T38): `F = ⋂_c KPer(c)` over all colourings, `P = ⋂` over periodic ones, `KPer(c)` the translations fixing
   every Kempe component (T1); and `F ⊆ F_μ ⊆ F_meas ⊆ P = F_clopen` — periodic colourings are the continuous colourings of the odometer
   `Λ ↷ Λ̂` (G66), and the gap between `F` and `P` splits into a walls half (`F = F_μ`, Furstenberg correspondence) and a recurrent half.
5. **Compactness** (`forces_iff_exists_finite`; FS58-T4): a pair is forced iff a finite induced subgraph forces it; a graph is not
   `k`-colourable iff a finite subgraph is not.
6. **Where the target stands.** `χ(ℚ(√167)²) ≥ 4` (row 79); the local–global conjecture predicts ≥ 6 (G59). Every lattice over ℚ(√167)
   has rank ≤ 4 and is triangle-free (no √3, G57). Of FS-61's 57 lattices, 56 are three-colourable, hence four-colourable and loose at
   four by the spare-colour lemma (row 45); `L21cc6506` (60 unit vectors, `U = {1, v, v̄, z, z̄}·U_R` with `U_R` the 12 rational unit
   vectors and `v = (83+i√167)/84` the type-M rotation at `n = 42`, T40, T45) is not three-colourable. Its four-colour status:
   [P0-SURVIVORS]. `1/2, 1/3, 1/7 ∈ ℤ[U]` over ℚ(√167) (`[Fischer1990]` Ex. 4), so a four-colour forced pair `δ` that is a unit at every
   conjugation-stable prime of `ℚ(√167, i)` gives five in the field by G55's chain (`plans/ASTRA-2026-09-14-derivation.md` T5).

### §C.2 "The challenge"

**The question (Q).** For every graph in the abstract class: **does four-colourability imply a periodic four-colouring**, and **is every
difference that all periodic four-colourings identify identified by all four-colourings** (`P = F`)? The first half is Jordan Ellenberg's
MathOverflow question (2018, `mathoverflow.net/q/304715`: *if G has a k-colouring, does it have a periodic one?*) at `k = 4`; Chandgotia,
Gangloff, Hellouin de Menibus and Oprocha carry it as open in 2025, together with the decidability of emptiness for ℤ^d with an arbitrary
generating set (`[CGHO2025bg]` §6.2.1). FS-73 proved both halves at `k = 3` (item 1). *Sharper, optional:* are periodic colourings dense
in the support of every invariant measure (`F_μ = P`)? **Plain density is false at four colours already in rank 1**: FS73-T30's four walls
(`D = {1,5,7,10}`, `{3,5,9,10}`, `{3,7,9,10}`, `{5,7,9,10}`) are one-way — legal four-colourings with local patterns no periodic
four-colouring contains — while those graphs have periodic colourings and `P = F = 0` (checked by the advisor and the planner
independently, on the window-state graph). Do not spend the competition re-deriving that.

**These are three questions, not one**, and they are ranked: **(Q-obs) first, (Q-rig) second, (Q) third** (existence plus inheritance).
The first two aim at five colours over ℚ(√167); the third is Kooshi's certificate question, where a no is still a finding. Only
(Q-comp) follows from (Q); (Q) says nothing about (Q-rig) (it holds trivially on a finite
colouring space), and (Q-obs) is independent of both. MathOverflow's commenters expect (Q) to be answered no by a domino reduction; such a no
answers Ellenberg's question and **does not answer (Q-obs)**, and a no that needs rank ≥ 5 or cliques does not reach ℚ(√167). Say which
question your result answers, **in which class and at which rank**:
- **(Q-comp) completeness** — in the abstract class. A yes makes four-colourability decidable and gives two-sided certificates and `P = F`.
  A no is an explicit four-colourable graph with no periodic four-colouring (proved both ways), or undecidability.
- **(Q-rig) rigidity** — in the **K₄-free** subclass (every unit-distance lattice graph is K₄-free): *when is the four-colouring space
  finite?* For the target: *when does `F` contain an element that is a unit at every conjugation-stable prime?* (a lattice rigid only
  through a residue colouring at a usable prime gives nothing).
- **(Q-obs) obstruction** — in the K₄-free subclass: *is there an invariant carried by every four-colouring whose admissible values form a
  set computable from `S`, empty for some non-four-colourable graph whose fractional chromatic number is at most four?* A finite refuting
  subgraph always exists by compactness; the question is for a certificate that is an invariant of every colouring. **Success is scored
  by size, not by kind**: a sound certificate of any kind, densities included, checkable in time polynomial in its bit size, whose bit
  size is bounded by a stated function of the presentation of `(Λ, S)` that mentions no refuting subgraph, and which on the instance is
  smaller than the best finite refutation known. The benchmark's `χ_f ≤ 4` already rules out colour-class densities. **Success also needs
  rank ≥ 2**, because rank 1 is decided already. `G(ℤ, {1,3,7,12,17,22})` is triangle-free, has `χ_f ≤ 29/8`, and refuses four colours on
  33 consecutive points. Its transfer matrix, a certificate on the group, decides it at about the size of that 33-point refutation. No
  rank-≥2 K₄-free graph with a certified `χ_f ≤ 4` and `χ = 5` is known; naming one, or working with "refuted by no colour-class density
  bound" in its place, is part of the task. Admissible kinds, not exhaustive: colour-class densities, window-pattern frequencies, heights,
  Kempe-class invariants, counting compulsions (G53), the domain's topology (Lovász's box complex, `[Lovasz1978]`), algebraic
  certificates (ideals in the group ring), or a kind you name.

**Why the class, and why the rank.** Cliques make both of the last two faces trivial in the abstract class (`S ⊇ {s, 2s, 3s}` forces period
4 along `s`; `S ⊇ {s, …, 4s}` is a `K₅`); the K₄-free subclass removes them. ℚ(√167)'s lattices have rank ≤ 4 and no triangles, so a
result that reaches them must hold in rank 4, triangle-free.

**What a no would look like.** An explicit graph (its rank, its `S`) with a proof that it is four-colourable and a proof that no periodic
four-colouring exists; or a reduction from the domino problem (Wang tiles) to four-colourability in the class, with the rank at which it
works. A reduction that needs rank ≥ 5 answers Kooshi's certificate question and does not reach ℚ(√167).

**The known positive proves nothing about the inference**: its colouring space is finite, so existence and inheritance hold there
trivially. What any
class-level answer must do is **explain** it (why 9,120 and not infinitely many), and reproduce two controls: the triangular lattice
(item 2 of "things worth knowing") and the grid.

**The hard constraint**: a derivation. Exact computation to check a derived claim is encouraged (exact rationals, sympy, the FS-73 tools on
a small object, a `decide` in Lean). A new solver search over lattices is not part of the challenge; phase 0's rows are yours to use.

**If the challenge as posed is subtly the wrong challenge, say so**: that is a finding, not a refusal.

**Things worth knowing before you choose a line** (the prior-art gate's, `plans/FS79-invariant-question.md` §PA; read the sources):
1. **The object in its discipline's words.** A four-colouring of `Cay(Λ, S)` is, through `π : ℤⁿ → Λ` (one coordinate per ± pair), an
   `R`-invariant configuration of the grid homshift `Hom(ℤⁿ, K₄)`. The discipline's handle on invariants is Klaus Schmidt's
   **cohomology of ℤ^d shifts** (continuous cocycles; a height is a nontrivial one). `[CGHO2025coh]` (arXiv:2510.11969) Theorem 1.1: a
   mixing grid homshift is cohomologically trivial iff its **square group** (the fundamental group of the target with a square 2-cell on
   every 4-cycle) is ℤ/2 — so the four-colour **grid** homshift has no nontrivial cocycle: item 2 above, in print, for standard
   generators. **Our class adds the images of `S`'s relation cycles** (triangles, Pythagorean relations, longer odd cycles), which the
   discipline has not studied.
2. **With triangles there is a four-colour height.** `[MooreNewman2000]` (arXiv:cond-mat/9902295) §III: proper four-colourings of the
   **triangular** lattice carry a **two-dimensional height** — each edge carries `t ⊗ E`, `E ∈ {α/2, β/2, γ/2}` by the colour pair,
   `α + β + γ = 0`, the integral around every triangle vanishes — and every colouring is a fixed four-colouring of the height lattice
   composed with the height (Baxter's three-colouring model; Kondev–Henley's loops). So what a four-colouring carries depends on the
   relation cycles, not on `K₄` alone. de Grey's lattice contains `ℤ[ζ₆]`; ℚ(√167)'s lattices contain no triangle.
3. **Every-colouring theorems the corpus already holds at four colours are spectral.** On a Hoffman-tight Cayley graph every `k`-colouring is
   balanced, gap-free and periodic under the common kernel of the minimising characters (`plans/FS38-derivation.md` D2-A); `U₃₂ =
   Cay(𝔽₁₀₂₄, μ₃₃)` is completely rigid at four colours (FS54-T6). The known positive is slack, so these do not explain it.
4. **A Cayley-graph four-colouring problem can carry a finite-alphabet ℤ² SFT** (T34): KR6 is de Grey's lattice plus the ζ₆-orbit of
   `ρ₁₅` (rank 6); each coset of de Grey's lattice carries one of its 9,120 colourings, and the `ρ₁₅` directions become adjacency rules
   between cosets. Whether such frame products encode arbitrary Wang tile sets is a question, not a result.
5. **Additive colourings are achiral** (`−φ` is a colour permutation of `φ`); a four-colour counterexample to inheritance that is periodic in
   `r − 1` directions needs a chiral, non-additive phase (Coxeter's reading, FS73 §8); chiral non-additive colourings are common on loose
   lattices (T35); statistical mechanics has a chirality parity invariant under Kempe moves on hexagonal lattices (`[Cepas2016]`) and
   Kempe invariants that are linking numbers (`[CepasAkhmetiev2020]`); Hubai's "one chirality choice" is the same word.
6. **Averaged invariants: one-point densities against window frequencies.** Colour-class densities (one-point) give the fractional
   bound and nothing more. At ℚ(√167) its cap is 4.36 > 4, but a certificate of that kind for five there would prove `χ_f(ℝ²) > 4`,
   beyond the best known bound (`[MatolcsiEtAl2025]`: ≥ 4). **Frequencies of colour patterns on a window are a different kind, and they
   are not controlled by `χ_f`.** In rank 1, at the window `[0, max D]`, a shift-consistent frequency vector is a circulation on the
   window-state graph. One exists iff that graph has a cycle, iff the colouring space is nonempty. So the linear programme over window
   frequencies decides rank 1 exactly, including `G(ℤ,{1,3,7,12,17,22})` with `χ_f ≤ 29/8`. In rank ≥ 2 each fixed window is a
   relaxation, and a window big enough to contain a refuting subgraph is that refutation in disguise. That is why success is scored by
   size. How FS-73's `Θ₃` relates to window frequencies is a question worth asking. The counting compulsion (G53) is one-sided and
   integral, computed on a base pattern alone, and `L21cc6506` is a multilayer of the rational pattern.
7. **Local transfers fail** (`plans/FS66-tower-conjecture.md` Lemmas W and T): a pointwise transfer invariant can leave the relevant
   polytope; keep invariants global.
8. **The rank-1 laboratory is decidable**: every `k`-colourable `G(ℤ, D)` has a periodic `k`-colouring (`[EggletonErdosSkilton1990]` Thm 2;
   F. Lehner's MathOverflow answer); four-colour walls first appear at `max D = 10`, all with `P = F = 0` (T30); a transfer-matrix
   decider exists (T28). Rank 1 checks claims; it does not answer (Q).
9. **Topological combinatorics has not been applied here.** No application of Lovász's box or Hom complexes to infinite abelian Cayley
   graphs was found (§PA.2).
10. **The instances** a new procedure is aimed at the day it lands: `L21cc6506` and [P0-SURVIVORS] over ℚ(√167); KR6 (T34); FS-72's rank-8
    lattice over ℚ(√3,√5); the rich 2-unit lattices (T10); the rank-1 walls (T30). Controls: de Grey's lattice, the triangular lattice, the
    grid.

**Reporting.** The target is an answer to one face, in a named class and rank, with its kind of invariant named (`plans/FS79-invariant-
question.md` §IQ item 3: colour-class densities, window frequencies, heights, Kempe-class invariants, counting compulsions, the domain's
topology, algebraic certificates, or another kind you name). If none lands, report
"not landed" and list under it, each as exactly what it is: (a) a sharpened reduction; (b) a subclass where an invariant exists, with the
invariant; (c) a candidate family and what deciding it would take.

**Your working file** is `{SCRATCH}/FS79-C-{NAME}.md`, current at every claim and every retraction (kept and marked; the advisor counts
them, and zero means the disagreement has not started). Do not open `{OTHER}`'s file until you have handed back. Every claim states its
class, rank, kind and grade, and names an inhabitant of its hypotheses.

**Standing rules** (each with its reason): read `CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md` from disk (a copy in your context is the
briefing session's snapshot); do not spawn agents (delegation is one level deep: staffing is Kooshi's budget decision and review needs
every agent known); any job over ~2 minutes or ~8 GB takes the heavy lock `flock -w 1800 <lock> <cmd>`, `setsid` with a pgid file (the
desktop cannot run two); kill by pid or process group and verify by effect; your scratch directory is `{SCRATCH}` and you do not read the
other competitor's; commit nothing (the owner moves your file into `plans/` after both hand back); do not open
`~/source/lean-dir-owner/`; reach the owner with `SendMessage` to `main`; budget about 400k tokens — stop at a clean boundary and report if
the work outgrows it.

### §C.3 The advisor's slots (§5 of the protocol)

**"The situation"**, items: §C.1 items 1–6 verbatim; the known positive and why it proves nothing about the inference (§C.2); §C.2's
"things worth knowing" 1–10; the instance list with [P0-SURVIVORS] filled.

**"The challenge"**: §C.2's three questions with their classes, the ranking ((Q-obs), (Q-rig), (Q); owner ruling R2), (Q-obs)'s success
test (scored by size, not by kind; rank ≥ 2; `χ_f ≤ 4`), "why the class, and why the rank", "what a no would look like", and the
reporting rule.

**Keep "What I want from you" as the template has it**, with these additions:
- *"Count the retractions on both sides, with what killed each; before either competitor's first theorem is believed, ask the second
  question whose shape the first could not have answered (the §10a rule of `plans/COXETER-2026-09-08-mascot.md`)."*
- *"Hold every claim to its class and rank: a clique must not confirm a rigidity or obstruction claim, and a no at rank ≥ 5 must not be
  read as reaching ℚ(√167)."*
- *"You hold two sets of items (the owner's and the plan-phase advisor's); offer them to both competitors at the same moment, only after
  each has written its own first route (FS-73's ruling R1). A card that answers one side's own route may go to that side alone, and is
  logged where the other reads it at hand-back (protocol §3)."*
- A fresh advisor writes its own expectation before its first message.

## §X. The exchange with Poros (this stage), and its retractions

| # | from | what | resolution |
|---|---|---|---|
| 1 | Poros, Q1 | is decidability with `S` as input already studied in the domino-problem literature? | the gate ran it first: open in print (`[CGHO2025bg]` §6.2.1, `[Ellenberg2018]`); undecidability known only for several orbits |
| 2 | Poros, Q2 | "a no-go redirects to arithmetic" does not follow; name the kind of invariant | adopted: (Q-obs) independent of (Q-comp); kinds listed in §IQ item 3 |
| 3 | Poros, card 1 | pose a yes/no question per half, or state what an invariant must do to count | adopted: (Q) is one yes/no question with three faces; kinds named |
| 4 | Poros, card 2 | "priced out" was a number from another population (rank 8; three colours) | adopted by the owner (owner error 2); phase 0 prices the direct ask |
| 5 | Poros, retraction 1 | its card 1 said the ℤ/2 winding is "realised periodically"; unchecked | withdrawn by Poros; the card's point stands with the corrected example |
| 6 | Poros, §G review | G53, G42 bear; G58 conditional; the rest of my silents stand | adopted, credited in §G.1 |
| 7 | Poros, card A | cliques make the rigidity and obstruction faces trivial in the abstract class; P-G71 could be met by a clique | adopted: faces name their classes; P-G71 restated to K₄-free |
| 8 | Poros, card B | a finite-index `F` does not give a chainable `δ`; a residue-rigid lattice gives nothing | adopted: §0.5, (Q-rig)'s target-grade form |

| 9 | Poros, answer to question 1 | the three faces are three questions; only (Q-comp) follows from (Q); a domino-type no gives nothing at ℚ(√167); rank them, obstruction first, and let the owner rule on which success is scored | adopted: §IQ item 2 now three ranked questions, the ranking an owner slot with the planner's recommendation as default; P-MO and P-rank registered |
| 10 | Poros | (Q-obs)'s benchmark is inhabited only in rank 1, where it is met vacuously (`G(ℤ, {1,3,7,12,17,22})`, measured by Poros); require rank ≥ 2 or a stated scaling; name a rank-≥2 inhabitant or register finding one as part of the task | adopted: rank ≥ 2 and a size that does not grow with refuting subgraphs; no rank-≥2 inhabitant with certified `χ_f ≤ 4` is known, registered as part of the task. The rank-1 refusal is Poros's solver measurement, not re-run by the planner |
| 12 | Poros, late card | plain density is false at four colours in rank 1: T30's four walls are one-way (transient window states), while existence and `P = F = 0` hold there; restate (Q) | adopted after an independent re-check with the planner's own code (cross-edge counts 8, 4, 24, 2 reproduced; controls 0): (Q) is now existence + inheritance, with `F_μ = P` as the optional sharper form. **A planner's miss**, logged for the close: T30 was in §G.5 as bearing and its consequence for density was not drawn |
| 11 | Poros, answer to question 2 | two kinds missing: T (Lovász's topological bound, the domain's topology) and A (algebraic: Nullstellensatz, group-ring ideals, FS-10); a control `Cay(ℤ,{1,2,3})` | adopted in §IQ items 3 and 5 and in §C.2 |

**Retractions, counted (G51):** Poros 1 (item 5); planner 0. **Disagreements recorded:** none; the one open point (which question
P2's success is scored on) is a product decision referred to the owner with a recommendation.


## §R-review. The owner's acceptance, and how the modeling stage resolved the review

*Written by the modeling agent (de Bruijn, Opus 5.5, a fresh reader of the plan), 2026-09-23. Committed before the modeling passes,
as the owner asked.*

- **Accepted** by the owner at `aebd48f7`, with two findings routed to this stage and one slot filled by ruling.
- **Blind-control score** (inventory item 32). Of the owner's controls B1–B11, the plan found 7, found 1 and turned it into a
  correction (B10, Moore–Newman), met 2 partially (B2: Greenfeld–Tao not named; B3: the averaging object named but misstated, which is
  finding 1), and missed 1 (B7, the universal-target route, kept independent for held item H-B). §G was complete: 72 grokkings and 45
  FS-73 theorems, checked by script.
- **Ruling R1** (inventory item 17): FS-79 may take the density question (FS-76's question 1); FS-76 is re-aimed at the close.
- **Ruling R2** (inventory item 31): the ranking is (Q-obs), then (Q-rig), then (Q), the last being existence plus inheritance. Filled in
  §IQ item 2 and §C.2, and named in §C.3.
- **Finding 1** (inventory item 29, "Kind 0 conflates two things"). **Checked, and it holds.** A shift-invariant measure on the
  colouring space, read on windows of length `max D + 1`, is a circulation on the window-state graph. A circulation exists iff the
  graph has a cycle, and in rank 1 that holds iff the colouring space is nonempty. So invariant means of window events decide rank 1
  exactly, and they refute `G(ℤ,{1,3,7,12,17,22})` at four colours although `χ_f ≤ 29/8`. The modeling agent re-ran the example
  (`…/scratchpad/fs79-modeling/rank1_bench.py`, `rank1_states.py`): the set is sum-free; `{0,2,4,6,10,15,20,25}` mod 29 is
  independent; four colours are refused on 33 consecutive points and possible on 32; the window-state graph has 3,555 states modulo
  colour permutation and none essential. The plan-phase advisor checked the finding independently the same day, agreed, and corrected
  its own benchmark figure (176 → 33, by two further solvers). The advisor also gave a further argument for dropping the "not a density
  certificate" clause. It is **not reproduced here**, because it answers a question §IQ item 3 now poses, and answering is the
  competitors' job; it stays with the advisor's record (inventory item 12). **Resolution:**
  - §IQ item 3 splits the kind into **0₁, one-point densities** (controlled by `χ_f`, true as the plan had it) and **0_W,
    window-pattern frequencies** (exact in rank 1, a relaxation at each fixed window in rank ≥ 2). It poses, and does not answer, how
    `Θ₃` relates to 0_W.
  - (Q-obs)'s success test is **restated by size** (§IQ item 2 and §C.2), in the advisor's wording adapted: a sound certificate of any
    kind, densities included, checkable in polynomial time, whose bit size is bounded by a stated function of the presentation that
    mentions no refuting subgraph, and which on the instance is smaller than the best finite refutation known. The domain pass pins
    "size" formally (§D).
  - One more consequence the finding did not state: in rank 1 the transfer certificate for `G(ℤ,{1,3,7,12,17,22})` (3,555 states) is
    about as large as the 33-point refutation. So rank 1 is excluded because it is already decided (T28, `[EggletonErdosSkilton1990]`),
    not because the benchmark is "met vacuously" there.
  - §C.2 item 6, P-B′'s example, §G.6's kind row and §G.7 item 4 are amended to match. Each amendment carries a bracketed note with
    the text it replaced.
  - The advisor's second rank-1 control, `D = {1,6,8,11,12}`, is added beside the first (K₄-free; 2,348 window states, none essential,
    both re-checked here; independence density ≥ 1/4 from a period-20 set; the advisor reports exactly 1/4).
- **Finding 2** (inventory item 30). **Holds.** χ(K²) = 4. §0 item 5 is reworded: over K, rigidity (`F = 8Λ ∋ 8/3`) gives five only
  in wall-broken extensions, where `1/2 ∈ ℤ[U]` and hence `3/8 ∈ ℤ[U]` (G55).
