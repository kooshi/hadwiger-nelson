# FS-81 — four colours over real quadratic fields: the plan

*Stage A, written 2026-09-24 by the planner (de Bruijn, Opus 5.5) from `plans/STUB-quadratic-four-colour-classification.md`, under
the owner's brief. This file is the planner's; the owner and a fresh modeling agent (WORKFLOW step 6) score it next. Read the
**close inventory** `plans/FS81-close-inventory.md` beside it; items 22–24 are this plan's finding and the owner's ruling on it.
Grades are `CLAUDE.md` § Notation's. Nothing in this file is claimed as a result: the finding in §F is a planner's sketch at grade
[hand, one mind], and stage C exists to verify or refute it.*

**How to read this file.** §0 is the milestone after the reframe. §G is the re-grokking (WORKFLOW 3.1), §PA the prior-art gate
(3.2), §IQ the invariant question (3.3). §F states the finding exactly, for stage C. §S is the subplan: phases, acceptance,
sequencing. §P lists the registered predictions, §M the modeling passes, and §X the exchange with Poros.

---

## §0. The milestone after the reframe

**What the stub asked.** T4 (G61): every squarefree `d ≡ 11 (mod 12)` has χ(ℚ(√d)²) ≥ 4. These are the only real quadratic fields
that can need four colours (`[Fischer1990]` Thms 8–9). The stub proposed two routes:
- the exact three-colour test `Θ₃` (G71), aimed at the census's 25 open fields;
- FS73-T41's 36-vector obstruction at ℚ(√167), generalised to a family.

The last phase would price a four-colour refusal at ℚ(√47).

**What the reframe found** (§IQ, §F). Asked at the level of the whole field instead of one lattice, the structural question has a
short answer — **if the planner's argument is right**.
- The span of all unit vectors of F² is a ring `R_F = ℤ[U_F]`, because unit vectors multiply.
- Three-colourability of F² is equivalent to a character of that ring putting every unit vector in `[1/3, 2/3]`.
- The rational unit vectors with 5-power denominators force every such character, restricted to each rotated copy ("layer") of
  that rational pattern, into two shapes: a parity character plus a small real one, or one of four order-3 characters (C1(5),
  proved from T40's exact cell list).
- One relation among unit vectors, `1 = n(2 − v − v̄)` with `v` G7's type-M rotation and `n = (d+1)/4 ≡ 0 (mod 3)`, kills both
  shapes.

**So T4 would hold for every d ≡ 11 (mod 12), and more generally for every F ⊆ ℝ with 1/3 ∈ ℤ[U_F] and F² not bipartite.** Grade:
[hand], the planner's, one mind. The owner re-derived step 2's lattice arithmetic, the case split and T40's cells on a 1/600 grid
(inventory item 22); T22's ⟹ direction at the field level, the compactness step and the general form are unchecked.

**The milestone, re-aimed** (the owner's ruling, inventory item 24):

| stage | what | agents |
|---|---|---|
| A | this plan | planner + Poros |
| **P0** | exact `Θ₃` runs: controls, the rational layer at depth 5^K, uniform finite configurations over all 40 census fields, then the census lattices and the chain. Now **confirmation and explicit finite certificates**, no longer the carrier of T4 | one implementer (launched 2026-09-24 from §S.P0) |
| B | modeling passes (fresh agent) | one |
| **C** | **independent verification of §F**, V2 pattern: a verifier writes its own verdict before reading the planner's sketch; then the finite-witness question `V(d, K)` and the general form's scope | one verifier; a second mind only on the stall criterion (§S.C) |
| D | ℚ(√47) at four colours: the four-colour hardness band measured first, with refusing controls, then the screen and one priced ask | one implementer |
| E | the close | close planner |

**What is now at stake.** If §F survives stage C, the conjecture's four-colour clause holds for every real quadratic field. The
proof uses no witness search. It answers, as far as four colours go, a question posed in print (§PA): Benda–Perles OP 11.6,
Moorhouse's question for quadratic fields, and `[Fischer1990]`'s request for an algebraic criterion. That makes it the likeliest
publication trigger this project has had since Theorem B. **Nothing may be claimed until stage C passes and `[Johnson2006]` and
`[Johnson2000]` are read** (§PA.4).

**Bearing on χ ≥ 6: none directly.** High on the programme: a class theorem by derivation, and the field-level `Θ₃` is the object
FS-64 and the "circular colourings do not glue" hunch (inventory item 12) ask about at five colours.

---

## §G. The re-grokking (WORKFLOW 3.1)

*Walked 2026-09-24 with `CLAUDE.md` (disk copy, c65c78da) and `LEDGER.md` open. One line per entry; verdict **B** (bears: what it
says, which phase), **S** (silent: why), **F** (falsifiable here: registered in §P). Phases: P0, C, D (stages above), IQ (§IQ),
PA (§PA), W (the close and write-up). §G.7 lists where each B became an instruction.*

### §G.1 Grokkings G1–G73

| G | verdict | reason → phase |
|---|---|---|
| G1 field wall | B | ℚ(√47) (47 ≡ 7 mod 8) breaks the 2-adic wall, so no free four-colouring null at D; the census's d ≡ 7 (mod 8) half breaks it, the d ≡ 3 (mod 8) half does not → D (a five-forcer can exist at 47), §F (the argument uses no wall) |
| G2 construction grammar | S | no rotation-centre construction; the configurations are group layers, not rings about a point |
| G3 radially crystal | S | about K-witness radii |
| G4 shell vocabulary | S | K-specific |
| G5 ownership factorization | S | de Grey's 1-sum |
| G6 hexagram is fabric | S | K-specific |
| G7 type-M family | **B** | `v_d = ((2n−1)+i√d)/(2n)`, n = (d+1)/4, exists for every d ≡ 3 (mod 4) and carries 3 in its denominator exactly when d ≡ 2 (mod 3) — the one rotation §F needs; other members `4n−1 = dm²` (m odd) give more per field → P0.2 builds its configurations from `v_d`; C verifies the relation `1 = n(2 − v − v̄)` |
| G8 direction group | S | K-specific generators |
| G9 rigidity at the forcing level | S | K's 791-point core; D's control comes from row 78 instead |
| G10 forcing distributed | S | about the 1581 |
| G11 Moser subgraph not necessary | S | these fields hold no Moser spindle (no √3); nothing is built from spindles here |
| G12 quadrature law | S | seam words over K |
| G13 fan ladder | S | pair/k-set compulsions at χ; no fan question in FS-81 |
| G14 width without degree | S | arena design |
| G15 pigeonhole × kill | S | a χ ≥ 5 universality question; §F is a χ ≥ 4 argument by averaging, outside its scope (noted: it does not factor as pigeonhole × kill) |
| G16 distance-2 pigeonhole | S | K-fabric at four colours |
| G17 globality at the top rung | S | sub-rung carriers at K |
| G18 composition sees what search cannot | B | if D's one refusal ask caps monolithically, split by cubes and certify components before growing the ball → D |
| G19 5-tight fabric | S | five-colour class sweeps |
| G20 brick colourings | S | upper-bound certificates |
| G21 a negative measures its enumeration | **B** | P0: every nonempty `Θ₃` is a typed null at its configuration and depth; calibrate the tree on known EMPTY lattices at the open fields' coefficient size (11's `Ld65c8ee8`, a 59 certificate) before reading a null; a one-period census cannot see looseness; D: a four-colour null at a budget is a null. C: **"audit the results you like at the same rate as the ones you do not"** — §F is a result the planner likes, so C is built to break it |
| G22 where a six-colouring cannot live | S | six |
| G23 refining is not a route down | S | cell family |
| G24 the gap law: the step is integrality | B | three to four over these fields is integrality: `χ_f` is capped at 3.5 wherever 7 is usable (G60), so no fractional route proves T4 there; `Θ₃` (circular, integral) is the right object → IQ |
| G25 forcing ladder recursive | S | a reading about χ ≥ 5 kills |
| G26 the 6-forcer reduction | S | six |
| G27 hidden arithmetic symmetry | B | `Θ₃(F)` is invariant under √d ↦ −√d, complex conjugation and multiplication by `U_F`; break these in every tree (halves cases) and read them as the symmetry §IQ averages over → P0, IQ |
| G28 fine-tail forcing factors | S | cell family |
| G29 cell family closed | S | cell family |
| G30 measurement generates, derivation kills | **B** | the finding is a derivation, so C must re-derive it, not measure it. Failure mode 4 (correct and second): the Johnson gate blocks the claim. Mode 5 (empty domain): §F's general form ships an inhabitant, ℚ(√11). Mode 6: T4 is already stated as a theorem over all d, not a list. Mode 7: C checks that no hypothesis is implied by the conclusion's emptiness. Discipline ladder: dynamics (multi-invariant sets) entered at this reframe → C, W |
| G31 no pair compulsion at the top rung | S | five and six |
| G32 two-distance dial | S | five |
| G33 batches compose | S | descent |
| G34 the field is the selection | S | K descent |
| G35 the wall is 2-adic; 1/2 ∈ ℤ[U] | **B** | §F's key hypothesis is the same statement at 3: 1/3 ∈ ℤ[U_F] iff no conjugation-stable prime of F(i) lies above 3 (G55's prime inversion); for ℚ(√d) that is d ≡ 2 (mod 3), and explicitly `1/3 = (n/3)(2 − v − v̄)` → C (verify the explicit form; no prime inversion needed for quadratic F) |
| G36 residue colouring canonical | S | K descent |
| G37 endgame's shape | S | K descent |
| G38 the linear method's thresholds | **B** | Fischer's framework: no additive k-colouring when 1/k ∈ Σ₀. §F upgrades his obstruction at k = 3 from additive colourings to every colouring, given odd cycles; the order-3 layers of §F *are* the additive (𝔽₃) layers, killed by his 1/3 → PA (is the non-additive form in `[Fischer1990]`/`[Johnson2006]`?), C (state the upgrade exactly) |
| G39 redundancy before rigidity | S | forcers at d > 2 |
| G40 absorption | S | arena design |
| G41 additive colourings bound compulsions one-sidedly | B | `Θ₃` points generalise additive 3-colourings (the order-3 points are exactly the additive ones); the F4 characters of §F are Fischer's additive colourings restricted to a layer → C, IQ |
| G42 additive rigidity | S | five-colour gauge |
| G43 residue plane seals fields | B | D: ℚ(√47)'s usable primes are 11, 19, 23, 31, 43 — none four-colourable at any tower level (row 75, §1.7) — so a four-colouring of 47's plane, if one exists, is local at no prime. IQ: for d ≡ 11 (mod 12), L ≥ 4, and T4 is the conjecture's clause χ ≥ min(7, L) at four → D, IQ |
| G44 Kloosterman control | B | D: compute each target's spectrum first at four colours (seconds) before any residue ask |
| G45 lift only a shadow | S | design-and-lift is closed |
| G46 recognise the classical theory first | **B** | done at this reframe: circular colouring (κ, view obstruction), multi-invariant sets on solenoids (`[Berend1983]`), algebraic tori (the layers). The data-layout clause: read T40's actual cell list before reasoning (done: `fs73v2_thetaR.py` re-run) → IQ, PA |
| G47 compulsion face of sealing | S | five colours over sealed fields |
| G48 the conjecture; state the target as L(F) | **B** | every field in scope has L ∈ {4, 5} (4 at d ≡ 3 mod 8 by the dyadic prime or at 7; 5 at d ≡ 47, 143, 167 mod 168 where 11 is the first usable prime); T4 is the lower half of "χ = L" at four; D at 47 tests "exactly five", where only a whole-plane four-colouring local at no prime would falsify (inventory item 3) → IQ, D, predictions |
| G49 the prior-art gate | **B** | §PA: in the disciplines' words; the Johnson surveys unread and blocking; the held Polymath16 threads grepped (§PA.3) → PA, W |
| G50 read what the search found | **B** | `[DeVosEtAl2007]` found and read in full the same day; `[Johnson2006]`/`[Johnson2000]` are a debt with a stated claim boundary (§PA.4) → PA |
| G51 competitor and advisor | **B** | the finding is one mind's; C brings a second mind in while retraction is free (V2 pattern); the stall criterion names when a competitor joins → C |
| G52 wall-breaking necessary, not sufficient | S | type-M arena cross edges |
| G53 counting compulsion | S | type-M arenas |
| G54 tight or slack | B | D: at ℚ(√47) at four colours **no usable plane is four-tight**, so no tight-prime mechanism gives a full-rank F there. The sign `λ_min + deg/3` splits the usable planes (owner's review, §R-review item 1): at **11 and 19 it is slack** (−0.796, −0.943), so the ratio bound permits four and gaps; those planes are five-chromatic **by certificate** (rows 52, 69), not by the ratio bound; at **23, 31 and 43 the ratio bound refuses four** (+0.039, +0.0002, +2.704; P-G54 scored at the opening: Γ₂₃'s λ_min = −7.96). Consequence for D1: at 11 and 19 a lattice's residue *image* target (a subset of the circle) can be four-colourable with a gap even though Γ₁₁, Γ₁₉ are not, and no spectrum can rule it out, so those two are asked by solver, gap-aimed; at 23, 31, 43 compute the image target's own spectrum first (a proper subset of the circle can lose the full plane's refusal). *Superseded wording (the planner's, kept for the record):* "every usable plane refuses four by the ratio bound" — false at 11 and 19. C: the 3-adic tower is Hoffman-tight at three colours (FS58-T1), which is why order-3 layers are rigid, but 3 is not stable for d ≡ 2 (mod 3) — a consistency check |
| G55 unit-vector ring; chain; two- and three-colour classifications | **B** | the centre of §F. ASTRA-T4 proved "χ = 3 ⟺ L = 3" for √3 ∈ F by rhombus periodicity; §F supplies the missing half for 1/3 ∈ ℤ[U] without √3, by a relation `1 = Σ c_j u_j` (3 ∣ c_j, Σc_j even) in the chain theorem's spirit; the final step is ASTRA-T3's walk-parity homomorphism → C (verify; relate to ASTRA-T3/T4), W |
| G56 window for six | S | six |
| G57 triangle-free window | S | these planes are triangle-free (no √3); §F needs no triangle |
| G58 antipodal conjecture | S | finite planes |
| G59 the wall at six | S | six |
| G60 fractional colourings | B | the blow-up route is capped by χ_f at a 7-place (3.5 < 4), so it cannot prove T4 at fields with a usable 7; §F's circular object is not so capped → IQ |
| G61 three colours break at arithmetic; T4 | **F** | "T4 is unproved … no proof and no route to one" and "no witness transfers between fields" are falsified if C verifies §F; "never by congruence class" is tested by P0.2's table by d mod 8 (Poros's weak 2-adic skew, P-G61b) → C, P0 |
| G62 twisted bilayer; a lattice decides layer by layer | **B** | §F is G62's multilayer reading at the field level: `U_F = ⋃ b·U₅`, each layer a rotated rational pattern; "factor U as rotations × base pattern before any tree" → P0.2 builds configurations as layers |
| G63 transcendence free | B | §F's general form holds for every subfield F ⊆ ℝ; with G63, transcendental adjunction changes nothing → C (scope) |
| G64 six may be a value no field attains | S | six |
| G65 the degree law | **B** | a three-colour law; D must measure the four-colour band on refusing and colourable controls before any ball is aimed (FS-79's R-close miss 4) → D |
| G66 the residue ceiling does not drop | B | L(ℚ(√47)) = 5 at every level (row 75), so D's prediction "exactly five" is robust; §F's finite-orbit analysis (IQ) uses that every stable-prime tower refuses three colours at every level → D, IQ |
| G67 form of a grokking | B | a grokking minted at the close (the field-level three-colour theorem, if verified) is written in *Do / Killing test* form → W |
| G68 quotient before ball; read for a gap | B | D: four-colour quotients at every admissible N first, gapped colourings aimed at; P0.4 if a census lattice needs a three-colour quotient → D, P0 |
| G69 rigidity arithmetic; density pulls apart | B | D: at 47, four-colour rigidity needs every odd prime's target to refuse; run the periodic Kempe screen before any refusal ask → D |
| G70 √3-clean is residue | S | K |
| G71 three colours are linear | **B** | the instrument (P0) and the invariant (IQ, §F step 1): colourable ⟺ `Θ₃ ≠ ∅`, exact trees with Farkas leaves; at the field level the same criterion by compactness → P0, C, IQ |
| G72 pose a question needing an invariant | **B** | §IQ; its *Do* "point a new exact procedure at the open list the day it lands" is P0 itself; the count at the close: §F came through the structural question → IQ, W |
| G73 four colours, cell by cell | B | D: no cell-local certificate refuses four colours; a refusal at 47 is a finite graph (or FS-80's averaged certificate); compute `Θ₄` cells before calling any survivor rigid → D |

### §G.2 Ledger rows 1–81 (mechanisms)

| rows | verdict | reason → phase |
|---|---|---|
| 1–11 (two-circle, seam, coverage, fan, greedy, strip) | S | K's seam machinery and fan compulsions |
| 12–16, 19, 21 (tools: extension, coupling) | S | K coupling statistics |
| 13 (negative knowledge) | S | its lesson is G21's |
| 17–18, 20 (gluing, near-relation, triangle layer) | S | geometry over K |
| 22–25 (ladders, hexagram, field-wall identity) | S | K closures |
| 26–30 (de Grey anatomy, quadrature, kill engine, stacking, mechanism hunt) | S | five-forcer mechanics |
| 31 (Act One in the kernel) | S | pigeonhole carriers |
| 32–33 (six-programme, interval) | S | six; the upper end |
| 34–41 (coset/cell family, limit lemma) | S | cell family |
| 42 (arity floor, Forces API) | S | compulsions at χ |
| 43 (homogeneity, six-target) | S | six |
| 44 (spindle theorem) | S | forced pairs; §F uses no forced pair |
| 45 (spare-colour lemma) | B | a three-colourable lattice is four-colourable and loose (FS79-T1) → D's free screen |
| 46–49 (copies, M53, critical sets, absorption) | S | five-colour descent |
| 50 (additive yardstick; Fischer's 1/k obstruction; Ex. 4 at 167) | **B** | the obstruction §F upgrades; Fischer's Example 4 uses `(83 + i√167)/84` to put 1/3 in the ring — prior art for §F's relation at 167 → C, PA |
| 51 (additive rigidity) | S | five |
| 52 (finite-plane bound) | B | D's upper bound 5 at 47 (Γ₁₁) |
| 53 (field sieve) | B | D's residue targets at 47 |
| 54 (lift) | S | lifting closed |
| 55 (residue obstruction) | S | five over sealed fields |
| 56 (local–global tightness, addCayleyMap) | B | D: periodic colourings are residue colourings prime by prime (with G69) |
| 57 (Theorems A, B; B's value is `[Fischer1994]`) | **B** | the prior-art lesson: a value "ours" for weeks was in a 1994 proceedings volume → §PA.4's claim boundary |
| 58 (Moser recipe threshold) | S | forcing gadgets |
| 59 (2-adic law over K) | S | K |
| 60 (plane freedom) | S | finite planes |
| 61 (statements at their level) | S | six |
| 62 (orbit-closure gap) | S | M64 |
| 63 (two colours from inertia) | B | the two-colour side §F's last step contradicts: F² is 2-colourable iff no odd cycle (ASTRA-T3) → C |
| 64–65 (ρ₆₃ arena; Parts's shape) | S | five colours in K(√7) |
| 66 (fan gap) | B | D: one gapped periodic four-colouring frees every pair on a lattice |
| 67 (2-adic tower at four) | S | K at 2 |
| 68–70 (six refused at 83; window; W_f) | S | six |
| 71 (fractional blow-up; χ_f(K²)) | B | the fractional cap (G60) → IQ |
| 72 (the 3-adic barrier) | **B** | a refusal needs a direction with 3 in a denominator; §F explains why: the order-3 layers survive exactly when 1/3 is not reachable → C (the barrier is the order-3 half of §F), IQ |
| 73 (ℚ(√11) kernel; 23, 47, 71, 95, 191 certified) | B | controls for P0; the kernel's ℚ(√11) is §F's inhabitant for the general form → P0, C |
| 74 (the census) | **B** | the 25 open fields and their typed nulls; the dyadic lemma; "no witness transfers … no proof route" (falsifiable, G61) → P0, F-predictions |
| 75 (tower at 7, 11, 19, 23) | B | L(47) = 5 at every level → D |
| 76 (FS-70, five over ℚ(√3,√5) not landed) | B | D's method template: screens close lattices in minutes; build balls last |
| 77 (theorem audit) | B | W: file every theorem in `plans/FS81-derivation.md` and § B |
| 78 (F = P = 8Λ on de Grey's lattice; the (0, v) certificate) | **B** | **D's refusing control at four colours on rank-4 material**: de Grey's lattice plus the edge {0, v} refuses four on 2,044 points (FS73-T6) — the only known four-colour refusal on a rank-4 lattice graph with one added edge → D |
| 79 (the three-colour criterion; `Θ` certificate; ℚ(√167) ≥ 4) | **B** | the instrument and §F's step 1 → P0, C |
| 80 (four colours cell by cell) | B | D: no cell-local four-colour certificate |
| 81 (ℚ(√167) at four; the saturated chain; survivors) | **B** | D's screen template and its caveats (prices are three-colour-law balls; finder nulls are not emptiness) |

### §G.3 `LEDGER.md` § B, by milestone block (bearing lines individually)

| block | verdict | reason; bearing lines |
|---|---|---|
| M18–M52 (seam, cell family, arity, descent) | S | K objects and the cell family; no line bears |
| M53 (Theorems A, B; FIELD-WALL) | B | **M53-T7** (real quadratic planes by d mod 8, explicit 5-cycle in ℚ(√7)²): the bipartite / three / open classification §F completes at d ≡ 11 (mod 12) → C, W. Others S |
| M54–M55, M57, M59–M64 | S | five colours, lifting, M63's arenas. **M63H2-T1** (type-M iff integer diagonal) B: v_d is the unique member with 4n − 1 = d → C |
| M56 (additive colourings) | **B** | **M56-T1/T6**: Fischer's 1/k obstruction and "Σ₀ is a ring" — §F uses both (the ring structure of R_F; 1/3 kills order-3 layers) → C |
| M58, M61 (sieve; L(F)) | B | **M61-T1** (which primes contribute to L) → IQ (T4 is L ≥ 4's lower half); others S |
| 2026-09-06/08/09 (R52, R57, R59, MASCOT) | S | K and finite planes; MASCOT-T6 is K's √3 dichotomy |
| ASTRA-2026-09-14 (G55's theorems) | **B** | **ASTRA-T2** (prime inversion), **T3** (two colours), **T4** (three colours given √3), **T5** (chain): §F is T4's missing half without √3 and uses T3 at its last step → C, W |
| FS-25–FS-39 | S | kernel ports, reductions, the bridge |
| FS-38 (towers) | B | **FS38-D2-A** (tight ⟹ periodic) is behind FS58-T2 (three-colourings of the 3-adic tower are affine), the finite-level reason order-3 layers exist → C consistency; others S |
| FS-50–FS-56 | S | six, windows; **FS54-T2** (trichotomy; odd degree 2-colourable) B for §F's general form's scope, **FS56-T5** (fractional cap) B → IQ |
| FS-58 (three-colour tower, compactness) | **B** | **FS58-T1/T2** (3-adic tower tight at three, colourings affine) → C consistency; **FS58-T4** (finite forcer ⟺ infinite rigid, by compactness) is §F step 1's compactness in another guise → C; **FS58-T8** certified fields → P0 controls |
| FS-61 (the census) | **B** | **FS61-T1** (certified fields, controls) → P0; **FS61-T2** (dyadic law) → P0 enumeration sanity check; **FS61-T3** (no transfer between fields) — true, and §F makes it moot → F; FS61-T4, T5 S (T5's degree heuristic is D's three-colour caveat) |
| FS-62, FS-66 | S | six; towers (FS66's all-levels facts reach D through row 75) |
| FS-70 (five over ℚ(√3,√5)) | B | **FS70-T3** (3-integral lattices 3-colourable) → C (why 1/3 is needed); **FS70-T6, T9, T10** (fan-gap closure, periodic = residue, periodic Kempe screen) → D |
| FS-73 | — | walked individually in §G.5 |
| FS-79 | — | walked by block in §G.6 |

### §G.4 Method rules (`CLAUDE.md` [method] entries; § Toolchain; § Building; the kernel's cost model; § Searching; § The gate)

| rule | verdict | reason → phase |
|---|---|---|
| G21, G30, G46, G49, G50, G51, G67, G72 | B | walked in §G.1 |
| break the symmetry before any (UN)SAT search | B | D's refusal ask pins a clique (ω = 2 at 47: an edge only) plus value precedence → D |
| pysat CaDiCaL ignores `interrupt()` | B | D, P0: bound every pysat ask by a subprocess timeout |
| Python 3.14 forkserver | B | P0/D drivers pass the `fork` context or an initializer |
| `flock -w` expiry is a silent non-run | B | every heavy launch checks the exit status |
| checkpoint and resume exactly (PROTECTED) | **B** | every phase names its checkpoint and resume command (§S); trees resume from state files outside `build/` |
| a blocking run is presumed killable (PROTECTED) | B | D's refusal ask is killed if it blocks a verification |
| kill by pid/pgid, verify by effect; `$!` may be a shell; lock wrappers are parents | B | P0, D launch discipline |
| a pipe can kill the producer; `\| tail` hides exit status | B | P0/D scripts read exit status from the tool |
| never edit a running script | B | snapshot copies for long runs |
| always `./scripts/build.sh`; `lake env lean` is not the check | B | any kernel skeleton (none at this stage, §M) |
| generated modules and invalidation | S | no generated modules planned |
| the kernel's cost model (decide +kernel, literals, Bool over ∀, feed the core) | S | no kernel phase in FS-81 (§M); applies to a later kernel stub |
| § Searching (ugrep alternation, `^`, `rg -uu`, `exact?`) | B | P0/D greps of records use `grep -F` or `rg` |
| vacuity / every structure hypothesis ships an inhabitant | B | §F's general form: inhabitant ℚ(√11) (1/3 ∈ R, non-bipartite) and non-examples ℚ(√3), ℚ(√7) (1/3 ∉ R) → C |
| run every check's negative control; positive signal for what did not happen | **B** | P0's checkers get the owner's plant; every EMPTY run has a NONEMPTY partner; the uninformative outcome of each prediction is stated reachable (§P) |
| a waiter's condition must be false when armed; waiters on a replaced job's log | B | P0/D monitors |
| state the uninformative outcome and confirm it is reachable | **B** | §P: every prediction lists both outcomes reachable |
| carry what a number measures; one thing differs between two numbers | **B** | D: the four-colour price is a solver time on a stated ball at a stated degree, never a three-colour-law point count |
| measured half vs derived half | B | P0 configurations are derived (built from v and U₅): a refusal there is the suspect verdict → the frozen checker re-derives every unit vector |
| a check reads the shipped value; formatting is the check | B | new checker `tools/fs81_theta_check.py` (if built) |
| enumerate the parameter first | **B** | P0.2 enumerates the layers per field (v_d, N = 2, N = 5 twists) before choosing configurations (Poros's card 2) |
| a positive control proves the generator's shape only | **B** | P0's controls span both d-classes mod 8 (Poros's card 1) |
| a true explanation stops the search for a second | **B** | §F explains FS-61's nulls *and* the barrier; C must still look for a second failure in the argument |
| a caveat written and stepped over | B | every report of §F carries "[hand], unverified" until C passes |
| parameter count against the problem's | B | C: the argument's degrees of freedom (a character on R_F) against its constraints (one relation per layer) |
| "A GPU is not a SAT accelerator" | S | no GPU work planned |
| a kernel leaf priced after a fine obligation pass is priced high | S | no kernel phase |

### §G.5 FS-73's theorems T1–T45, individually

| T | verdict | reason → phase |
|---|---|---|
| T1 Kempe period group | S | four-colour rigidity machinery; D uses it only via FS-79's screen |
| T2 re-periodised W′ | S | as T1 |
| T3 forced differences compose | S | four colours at K |
| T4 8Λ depth | S | K |
| T5 Λ = (1/9)O_E | S | K |
| T6 (0, v) forced on de Grey's lattice | **B** | D's refusing control (2,044 points + one edge, LRAT, frozen checker) |
| T7 F = P = 8Λ | B | D: the only rank-4 lattice with a full-rank F at four colours; its colourings (9,120) calibrate a colourable four-colour band |
| T8 √3-clean = residue | S | K |
| T9 L3's escapes | S | rank 6 |
| T10 rich 2-unit lattices | S | ℚ(√3,√5) |
| T11 soundness split for generator graphs | **B** | a refusal on a sub-configuration's Cayley graph carries up to every lattice containing it — P0.2's configurations are sub-configurations, so an EMPTY there proves the field; a nonempty one says nothing about the saturated lattice |
| T12 F = P = 3Λ at ℚ(√11)'s Λ₁₀ | B | consistency check for §F: at finite depth (denominators 10) the order-3 layers survive (1/3 ∉ Λ₁₀); only the field-level 1/3 kills them → C |
| T13 Λ₅₀ | S | as T12 |
| T14 fixed-prime gap lemma | B | D: a conjugation-fixed prime with a gapped four-colouring target makes every lattice loose |
| T15 five-colour targets | S | five |
| T16 table's loose rows | S | other fields |
| T17 L3e1c94c6's period-23 residue colouring | B | P0: lattice-level residue three-colourings exist at primes that are not three-colourable at the field level (Γ₂₃ needs ≥ 6); finite-depth points are expected and are typed nulls → P0, C consistency |
| T18 52 of 57 lattices colour | B | same lesson: finite lattices without enough 5-adic depth carry points (§F predicts this) → P0 |
| T19 residue classification at 23, 43 | B | P0.4 design rule if the chain route is needed |
| T20 noisy circular colouring | B | method: read a solver colouring's spectrum before searching periods → P0.4 |
| T21 height lift, slope fibre | **B** | §F step 1 (with T22, T42) → C |
| T22 the criterion | **B** | §F step 1 at every Λ_M → C verifies the inverse limit to R_F |
| T23 tight directions affine | S | finite-lattice rigidity |
| T24 density; dichotomy | B | at field level the dichotomy reads: finitely many orbits of characters or a fat set; §F finds the set empty → IQ |
| T25 Θ₃(Λ₁₀) = 16 order-3 points | B | the finite-level F4 layers, explicitly → C consistency |
| T26 the Θ-emptiness certificate | **B** | P0's certificate format and frozen checker |
| T27 Ld14c588b 3-colourable (period index 1,080) | B | P0 negative control (a full cell over 167) |
| T28 controls agree | B | P0 control pattern |
| T29 four colours: no linear criterion | B | D: no Θ-type certificate at four |
| T30 rank-1 walls | S | rank 1 at four |
| T31–T35 rank 6 | S | rank 6 |
| T36–T37 normal form, consequences | B | D's vocabulary (F ⊆ P) |
| T38 invariant-measure subgroup | B | IQ: the averaging move (G72 move 3); §F averages over the multiplicative symmetry instead of an invariant measure |
| T39 L21cc6506 Θ₃ = ∅ (three routes) | **B** | P0 positive control; C consistency (§F predicts emptiness at 167) |
| T40 product structure; Θ_R = c0 + (D0 ∪ F4) + 5ℤ² | **B** | **§F's only computational input** (C1(5)); re-run 2026-09-24 → C must re-derive the cell list independently (a second code path, or by hand from the arrangement) |
| T41 the half-page proof | **B** | §F's finite shadow: T41's four cases are exactly §F's case split (each layer disc-type or an F4 point); P0.2 recomputes the shape across d; C relates the two |
| T42 forward lift, relation form | **B** | §F step 1: the criterion without a generation hypothesis → C |
| T43 P3b controls | B | P0 controls (Ld65c8ee8 over 11 EMPTY, over 59 a slack-0 point) |
| T44 key spans; no four-vector basis | B | P0: listed units versus key completeness; soundness needs only the listed ones (fs73v2_check's own docstring) |
| T45 v is type-M at n = 42; Fischer's Ex. 4 vector | **B** | §F's relation at 167 is `1 = 42(2 − v − v̄)`; Fischer used the same vector for 1/3 ∈ Σ₀ → C, PA |

### §G.6 `plans/FS79-derivation.md`, `plans/FS61-derivation.md`, `plans/FS58-derivation.md`, by block

| block | verdict | reason; bearing lines |
|---|---|---|
| FS79 T1–T2 | B | **T1** (three-colourable ⟹ loose at four) → D's free screen; **T2** (route (ii) needs a forced δ prime to every stable prime) → D (at 47 the chain route needs such δ) |
| FS79 T3–T7 (rank-1 benchmarks, window LP) | B | **T4** (window LP exact in rank 1) and **T5/T7** (K₄-free rank-1/rank-2 graphs refusing four on 33 points) → D's small refusing controls |
| FS79 T8–T16 (phase 0 at 167) | **B** | D's template: the chain sweep, the first rules (additive, gapped residue, linear, quotient), the caveat that prices are three-colour-law balls (T13) |
| FS79 T17–T30 (the four no-gos) | B | D: no cell-local certificate at four; a refusal is a finite graph |
| FS79 T31–T37 (census at 167, C8′, rank-1 criterion, de Grey's cosets) | B | **T32/T33**: a one-period census reads as rigidity and is not → D (compute Θ₄ cells first) |
| FS79 T38–T49 (Θ₄ tree and finder) | **B** | D: the calibrated exact Θ₄ finder (T45's calibration at the survivors' size), the priced tree (T49) |
| FS61 T1–T5 | B | lines in §G.3 |
| FS58 T1–T9 | B | lines in §G.3; **FS58-T9** (d ≡ 7 mod 8: no rational diamond chord is a 2-adic unit) → P0's d-mod-8 reading (P-G61b) |

### §G.7 Extraction index: every B, the instruction it became

| from | instruction | where |
|---|---|---|
| G7, G62, T41, T45, M63H2-T1 | build every configuration from the type-M rotation `v_d` and the rational layers `U^(5^K)`; enumerate other twists as layers per field | §S.P0 P0.2–P0.3 |
| G21, T43, T17, T18, T11 | controls in both d-classes mod 8, a calibration EMPTY at 59, every nonempty result typed; a sub-configuration's EMPTY proves the field, its nonempty proves nothing | §S.P0 P0.0, acceptance |
| G71, T22, T42, T26, T44 | frozen checkers; listed units suffice for soundness; completeness reported separately | §S.P0 |
| G27 | symmetry-break trees by conjugation, ±, the i-rotation | §S.P0 |
| G30, G51, G21 (audit what you like), T40, T21–T22, T42 | C re-derives §F independently in the V2 pattern; the cell list is re-derived on a second code path; the inverse limit written out | §S.C |
| G35, G38, G41, G55, M56, ASTRA, row 50, row 63, row 72 | C states §F's general form against Fischer's and ASTRA's theorems and ships inhabitants (ℚ(√11); non-examples ℚ(√3), ℚ(√7)) | §S.C |
| G49, G50, row 57 | the Johnson debt; the claim boundary; the request to Kooshi | §PA.4, report |
| G43, G44, G48, G54, G66, rows 52–53, 56, 66, 75 | D: ℚ(√47)'s targets, spectra first, L = 5 at every level; a four-colouring there is local at no prime | §S.D |
| G65, G73, rows 78–81, FS79 blocks, T6, T7, T29 | D: measure the four-colour band on refusing controls (de Grey + {0, v}; FS79-T5/T7) and colourable controls before aiming any ball; Θ₄ cells before "rigid" | §S.D |
| G68, G69, T14, FS70-T6/T9/T10 | D: quotients and the periodic Kempe screen before any refusal ask | §S.D |
| G24, G60, row 71, FS56-T5 | §IQ: why the fractional route cannot reach T4 and the circular one can | §IQ |
| G61, row 74, FS61-T3 | predictions P-G61a, P-G61b | §P |
| G67, G72, row 77 | the close: new grokking in form; G72's count; derivation file | §S.E |

### §G.8 What the re-grokking changed in the plan (the test of 3.1)

1. **G7 + G62 + G55 + T40 together produced §F.** The stub's family route (T41 with parameters) was replaced by a field-level
   argument that uses only the type-M rotation and the rational layers. That changes stage C from derivation to verification.
2. **G21 (audit the results you like)** made stage C adversarial by design and put the Johnson papers ahead of any claim.
3. **G65 + rows 78–81 + G73** made stage D measure the four-colour band on known refusing material first; the stub had "one
   refusal ask on the densest survivor, priced".
4. **G21 + FS61-T2 + FS58-T9 + Poros's card 1** put d ≡ 3 (mod 8) controls into phase 0 (11, 59), where the stub had only 167 and 47.
5. **T11 + T44** decided that phase 0 certifies sub-configurations with listed units, not saturated keys, where the checkers'
   completeness enumeration is infeasible.

---

## §PA. The prior-art gate (WORKFLOW 3.2)

*Run 2026-09-24 by the planner. Queries, hit counts and the texts read are in §PA.2; the bibliography rows were committed the same
day (`80f5530b`). Scratch copies of every zbMATH response: the planner's scratch `fs81-plan/zb/`.*

### §PA.1 The eight questions

1. **The object in its home disciplines' words.** Three disciplines own FS-81's object.
   - **Graph theory:** circular colourings and distance graphs. A point of `Θ₃` is a circular 3-colouring. The rank-1 case is the
     parameter `κ(D)` of view obstruction and the lonely runner.
   - **Topological dynamics:** the field-level set `Θ₃(F)` is a closed subset of the dual of a ring, invariant under multiplication
     by the unit vectors. That is a multi-invariant set in the sense of Furstenberg's ×2×3 and `[Berend1983]`.
   - **Arithmetic:** the unit vectors are the rational points of the norm-one torus of F(i)/F, and the layers are its cosets modulo
     the rational points of the norm-one torus of ℚ(i)/ℚ (Poros's card 6).

   Searched under all three (§PA.2).
2. **Two disciplines.** The combinatorial and dynamical searches were run separately. No source joins them for a number-field plane.
3. **The question.** "Chromatic number of the plane over a real quadratic field" is posed by:
   - Benda–Perles OP 11.6, via `[Soifer2024]` ch. 11, re-read today;
   - Moorhouse's slides, via `CLOSED-QUESTIONS.md` §1.7;
   - `[Fischer1990]` §1, re-read today: *"whether some algebraic criterion can be found to determine the chromatic number of F²"*.
     His abstract and §1 also say *"additive k-colorings even on quadratic extensions of ℚ are too special to provide k-colorings
     in most cases"*.

   No answer at four colours was found in either index.
4. **Outside arXiv.** Searched the zbMATH author listings (item 8) and the held proceedings. Geombinatorics is unreachable by script
   (a Cloudflare challenge), which is the Johnson debt (§PA.4).
5. **The poser's citation graph.** The posers are Benda–Perles, Johnson, Fischer and Moorhouse.
   - Johnson's complete listing: 194 works, of which 14 are on the subject (§PA.2).
   - Fischer's: 27 works, all four on the subject held and read.
   - Zaks and Chilakamarri: listings only; their reviews are about ℚᵈ, not quadratic fields.
6. **Citing works opened.** `[DeVosEtAl2007]` was opened and read in full (a 5-page reprint from Mohar's page); OpenAlex counts 4
   citing works, all titles about circular colouring. `[NaserasrPujolWang2026]`: abstract read. The Johnson items could not be opened.
7. **Two databases.** zbMATH and OpenAlex, for `[DeVosEtAl2007]`: closed access, 4 citations in OpenAlex. Its zbMATH record is an
   author's summary, not a review.
8. **Complete author listings and the posers' own vocabulary in a reviews database.** `ai:johnson.peter-d-jun` (194),
   `au:"Fischer, Klaus G."` (27), `au:"Zaks, Joseph"` and `au:"Chilakamarri"` filtered to the subject. Fischer's own words were run
   against abstracts: `ab:"chromatic number" & (ab:"Q(\\sqrt" | ab:"quadratic extension")` returns 6 hits: Johnson 2000, Fischer 1990,
   Fischer 1994, Bacsó–Tuza (projective planes), a 2026 arXiv paper on Exoo–Ismailescu's coordinate fields, and a Turán-density
   paper. None of them states a four-colour lower bound for a real quadratic plane.

### §PA.2 Queries and hit counts (zbMATH Open API unless marked; 2026-09-24)

| query | hits | what was read, and whose text it is |
|---|---|---|
| `an:0974.05029` (`[Johnson2000]`) | 1 | **reviewer's review** (C. G. Droms): lists as open *"the chromatic number of (X,1) when X is a finite algebraic extension of ℚ²"*; no quadratic-field value in the review |
| `an:1506.05069` (`[Johnson2006]`) | 1 | **no review and no summary**; title only |
| `ai:johnson.peter-d-jun` | 194 (two pages) | titles on the subject: 0648.05006 (1987), 0701.05005 (1990), 0786.05008 (1992, **author's summary** read: two-colourings of abelian groups), 0951.05038, 0974.05029, 1506.05069, 1243.05082 (2011 survey, **review** read: ℚⁿ), 0990.05048 (2001, **review** read: planar distance graphs, six open problems), 1407.05234 (2018, contents withheld), 0991.05045, 1037.05020, 1061.05033, 1461.05078 |
| `au:"Fischer, Klaus G."` | 27 | the four subject papers, all held; `[Fischer1990]` re-read today (§1, Thms 8–10, Ex. 4, the ending) |
| `au:"Zaks, Joseph" & (ti:…)` | 9 | reviews: ℚᵈ and Beckman–Quarles only |
| `au:"Chilakamarri" & (ti:…)` | 9 | reviews: ℚⁿ and Minkowski spaces; the 1993 survey's §3 is "rational subspaces" |
| `ti:"circular coloring the plane"` | 1 | `[DeVosEtAl2007]`, then **read in full** |
| `ab:"circular chromatic number" & ab:"unit distance"` | 2 | the above; plane-width (**summary**) |
| `ab:"circular chromatic number" & ab:"distance graph"` | 9 | Zhu, Liu, Chang–Liu–Zhu (distance graphs in ℤ; titles/summaries) |
| `ti:"view obstructions" \| ti:"lonely runner" & ab:"chromatic"` | 5 | `[BieniaEtAl1998]` (**review**), `[Liu2008]` (withheld) |
| `ab:"multi-invariant" \| ti:"multi-invariant sets"` | 5 | `[Berend1983]` (**review** read: the ID-property criterion), `[Berend1984]` (no review) |
| `ab:"unit distance graph" & (ab:"number field" \| …)` | 1 | Maehara 1991 (rigidity; withheld) |
| `ab:"chromatic number" & ab:"algebraic extension" & py:1970-2026` | 1 | `[Johnson2000]` |
| `ab:"unit distance" & ab:"quadratic field"`; `ab:"chromatic number" & ab:"real quadratic"`; `ab:"circular chromatic number" & ab:"Cayley graph" & ab:"abelian"`; `ab:"view obstruction" & ab:"chromatic"`; `ab:"3-colorable" & ab:"unit distance" & ab:"field"`; `ab:"invariant" & ab:"solenoid" & ab:"closed" & ab:"endomorphisms"` | 0 each | — |
| arXiv `abs:` "unit distance" ∧ "quadratic field"; "chromatic number" ∧ "real quadratic"; "unit distance graph" ∧ "number field"; "three-colorable" ∧ "unit distance" ∧ "field" | 0 each | — |
| arXiv `abs:` "circular chromatic" ∧ "unit distance" | 1 | 0812.4346 (plane-width) |
| web search "Circular coloring the plane" | — | found Mohar's reprint page and `[NaserasrPujolWang2026]` (arXiv:2606.25644, **abstract** read) |
| held Polymath16 threads (`library/notes/polymath16-threads-1-18-text.txt`), `grep -F -i` | "quadratic field" 0, "Q(sqrt" 0, "real quadratic" 0, "Fischer" 0, "number field" 3, "3-colou" 5, "circular" 6, "167" 3 | contexts read: J. S. Ellenberg (2018) on the unit vectors as a multiplicative subgroup of `O_K`'s units ("a lot of low-height additive relations"); strip and disc three-colourings; Parts's field lists; nothing on three-colourings of a real quadratic plane |

### §PA.3 What each read text says about FS-81

- **`[Fischer1990]` (re-read).** His colourings are **additive** by definition. Thm 9's three-colourings are homomorphisms to ℤ/3,
  which is Poros's negative control (§F.5), now checked in the text. For N ≡ −1 (mod 24), Thm 10(ii)'s proof puts 1/2 and 1/3 in
  C₀ using ξ = (b + √N i)/a, ξ + ξ̄ = 2b/a, which is §F's relation. Example 4 does the same at 167 with (83 + i√167)/84.
  - He concludes only that no **additive** k-colouring exists for k < 11. He says additive colourings "are too special", and he
    asks for a criterion.
  - **§F's relation is therefore his. What §F adds is the step from additive to all colourings:** T22 at the field level plus
    C1(5).
- **`[DeVosEtAl2007]`.** χ_c(ℝ²) ≥ 4 through the rhombus at distance √3. The method needs √3 in the field. It is the circular form
  of the same rhombus that powers ASTRA-T4's √3 classification, and **it does not reach any field without √3**, which is every
  field in FS-81. Their open question (a finite subgraph with χ_c ≥ 4) is about ℝ².
- **`[Berend1983]`.** The ID property needs an expanding eigenvalue for every common eigenvector. The unit vectors act
  isometrically at both archimedean places, so no rigidity theorem of this kind applies. `Θ₃(ℚ)` already contains an archimedean
  disc (§F, C1(5)). **The rigidity that §F proves by hand holds modulo the isometric places, and only in the band.**
- **`[Johnson1992]` (author's summary).** Johnson's own group-theoretic view is at two colours, with closure properties of
  2-forbiddable translation sets. There is nothing at three.
- **`[NaserasrPujolWang2026]`.** A winding-number frame for circular-chromatic gaps. It is the literature's language for G71's
  height and slope, and useful vocabulary for a write-up (FS-20-type).

### §PA.4 The Johnson debt, and what a claim may say meanwhile

**Unread, and the likeliest place for prior art:**
- **`[Johnson2006]`**, *Coloring the rational points to forbid the distance one — a tentative history and compendium*,
  Geombinatorics XVI(1) (July 2006) 209–218. Its identifiers: zbMATH 1506.05069, ISSN 1065-7371, OCLC 26726988. It has no zbMATH
  review.
- **`[Johnson2000]`**, *Problems posed in or arising from "Colorings of metric spaces": status report*, Geombinatorics IX(4) (April
  2000) 170–179, zbMATH 0974.05029.

The known routes (`BIBLIOGRAPHY.md` § R.2):
1. the author: Peter D. Johnson Jr., emeritus, Auburn, `address-removed@example.org`;
2. the journal's OJS archive, whose galley for the 2006 paper is `https://geombinatorics.uccs.edu/archive/index.php/home/article/view/62/198`
   (a subscription, behind a Cloudflare challenge);
3. the editor, Alexander Soifer (`address-removed@example.org`);
4. interlibrary loan of volumes 9 and 16 (the University of Michigan holds part of the run).

**Contacting anyone is Kooshi's call.** The request to the owner is in the planner's report.

**What a T4 claim may say while they are unread:**
- "proved here, by hand, verified independently (once stage C passes)";
- "not found in zbMATH, OpenAlex, arXiv or the Polymath16 archive, in the disciplines' words; `[Fischer1990]` has the relation and
  proves only the additive case".

**What it may not say:** "new", "first" or "open until now". Nothing goes into `CLOSED-QUESTIONS.md` as closed until both are read.
Two facts make this sharper:
- Johnson thanked Fischer for "pointing out a flaw" and supplied his references, so Johnson knew the additive obstruction in 1988.
- `[Johnson2010]` says the 2006 compendium discusses `G(ℚ(√m)², D)`.

### §PA.5 What the gate taught us about our own object (carried into §IQ and the phases)

1. **The unit vectors form a torus's rational points, and the layers are torus cosets.** It follows that the field-level `Θ₃` is a
   multi-invariant set, rigid only modulo the archimedean places. → §IQ items 2–3; the verifier's C1(5) task (§S.C).
2. **Fischer had the relation and stopped at additive colourings for want of a reason why a general colouring must be additive.**
   T22 plus C1(5) is exactly that reason. → §IQ item 3, and the write-up's attribution line.
3. **Circular colourings are the discipline's name for `Θ` points** (`[DeVosEtAl2007]`, `[NaserasrPujolWang2026]`). The known
   circular results for the plane go through √3, which this family lacks. → the write-up's vocabulary (`BIBLIOGRAPHY.md` § E at the
   close).

---

## §IQ. The invariant question (WORKFLOW 3.3)

**Is 3.3 degenerate here? The owner's challenge, answered.** At the level of one lattice it is: the invariant is known, the height
and its slope (G71), and "for which d is `Θ₃` empty" is the existence form run over d. At the level of the whole field it is not.
The field-level set has a symmetry no finite lattice has: every unit vector acts on it by multiplication. That symmetry is what the
structural question must use (G72, move 3). So the structural form below is posed at the field level, and in the most general class
where it makes sense: every subfield F ⊆ ℝ.

1. **The existence form.** For each squarefree d ≡ 11 (mod 12): is there a finite unit-distance graph over ℚ(√d) that is not
   three-colourable?
2. **The structural form.** *For every subfield F ⊆ ℝ, describe every proper three-colouring of F² up to its invariant.* Concretely,
   classify `Θ₃(F) = {θ ∈ Hom(ℤ[U_F], ℝ/ℤ) : θ(U_F) ⊆ [1/3, 2/3]}`.
   - This is the set of field-level slopes. Every three-colouring of F² carries one (T22 plus compactness, §F.1), and every point
     gives a colouring back (`⌊3{θ(x)}⌋`).
   - It is a closed subset of the compact dual of the unit-vector ring, invariant under x ↦ ux for u ∈ U_F and under conjugation.
   - The question is which such maximal invariant subsets of the band exist.
   - It is about every solution; T4 is the special case "empty". Its check is on the other side: at d ≡ 3, 7 (mod 12) it must
     reproduce Fischer's three-colourings (`[Fischer1990]` Thm 9).
3. **The invariant it forces.** The field-level slope θ, read one layer at a time. U_F is the union of the cosets `b·U₅` of the
   rational unit vectors with 5-power denominators (G62's multilayer at the field level). Every layer `θ(b·)` restricted to
   `ℤ[i][1/5]` is a point of the rational pattern's own field-level rotation set `Θ(U₅)`.
   - **The new invariant is the type of each layer:** parity-plus-archimedean, or order 3 (C1(5), §F.2).
   - Relations among unit vectors force the types to agree.
   - The archimedean parts cannot absorb a finite-order discrepancy, because the layers contain 5⁻ᵏ for every k.
   - Before this reframe the invariant was "none known" at the field level: the lattice-level slope has no symmetry to exploit.
4. **Its route.** Derivation only. The steps are C1(5) from T40's exact cell list (a finite exact computation that a derivation
   consumes, not a search), then gluing by relations. Stage C verifies it; phase 0's computations check its finite shadows and give
   explicit finite certificates, and answer nothing on their own.
5. **The open instances it would decide:**
   - the census's 25 open fields (35, 83, 107, 131, 155, 179, 203, 215, 227, 251, 263, 287, 299, 323, 347, 371, 383, 395, 407, 419,
     443, 455, 467, 479, 491);
   - every squarefree d ≡ 11 (mod 12) above 500;
   - `ℚ(√47)`'s three-colour question, as a control, already known;
   - **every real number field F with 1/3 ∈ ℤ[U_F] and F² not bipartite**. These include multiquadratic fields without √3 and
     without a four-chromatic quadratic subfield, such as ℚ(√2,√7): its subfields ℚ(√2), ℚ(√7), ℚ(√14) are two-, three- and
     two-colourable, and 3 has no conjugation-stable prime above it in ℚ(√2,√7,i) (planner's check: the decomposition group of 3 is
     generated by the automorphism fixing √7 and √−2, which is not complex conjugation, since conjugation moves √−2). Its status is not in the record; FS-48's table covers only
     fields containing √3. A non-example: ℚ(√7,√10), where 3 splits completely in F and every prime above it is fixed by conjugation.
   - at d ≡ 3, 7 (mod 12), the classification: all three-colouring slopes are additive mod 3 (Poros's extension, §F.5), matched
     against Fischer's Thm 9;
   - at five colours, FS-64's question and the "circular colourings do not glue" hunch (inventory item 12). The same field-level
     object at k = 5 is where a residue-free five-colouring of ℚ(√167)² would have to live, and §F's layer method is the first tool
     aimed at it (a stub at the close, not this milestone).

---

## §F. The finding, stated exactly (for stage C)

**Grade: [hand].**
- The steps are the planner's (2026-09-24).
- Poros attacked all five points the planner named and found no break. It independently re-scanned T40's cells at step 1/300,
  re-derived the dual lattice, and proposed a cleaner compactness indexing and the extension in §F.5.
- The owner re-derived §F.2's lattice arithmetic and the case split, and grid-checked T40 at 1/600 (inventory item 22).
- **Not yet an independent derivation.** Stage C is.

**The proofs are in `plans/FS81-F-sketch.md`. A stage-C verifier must not open that file, Poros's record, or the close inventory
until its own verdict on L1–L4 is committed (§S.C).** The statements below are the common starting point for anyone who verifies.

**Notation.**
- F ⊆ ℝ a subfield, U_F the unit vectors of F² viewed in F(i), `R_F = ℤ[U_F]` their additive span. It is a ring, because U_F is a
  multiplicative group, and it is the component of 0 of F²'s unit-distance graph.
- `R₅ = ℤ[i][1/5]`, `w = (3 + 4i)/5`, `U₅ = {iᵏwᵐ}`.
- `θ₂(x) = (x mod (1 + i))/2`, the parity character of R₅.
- `λ_e(x) = Re(ē x)` for e ∈ ℂ, the archimedean characters.

**The statements:**
- **L1 (T22 at the field level).** χ(F²) ≤ 3 ⟹ `Θ₃(F) ≠ ∅`.
- **L2 = C1(5).** `Θ(U₅) := {θ ∈ Hom(R₅, ℝ/ℤ) : θ(U₅) ⊆ [1/3, 2/3]}` equals `{θ₂ + λ_e : |e| ≤ 1/6} ∪ {the four characters through
  ℤ[i]/3 nonzero on ±1, ±i}`. The only computational input is T40's cell list at denominator 5: `Θ_R = c0 + (D0 ∪ F4) + 5ℤ²`.
- **L3 (layers).** For θ ∈ `Θ₃(F)` and b ∈ U_F, `θ_b := θ(b·)|_{R₅}` lies in `Θ(U₅)`.
- **L4 (gluing).** If `1 = Σ_j c_j u_j` with u_j ∈ U_F, every c_j ≡ 0 (mod 3) and Σ_j c_j ≡ 0 (mod 2), then `Θ₃(F) = ∅`.
- **Theorem (F-T4).** For every subfield F ⊆ ℝ with 1/3 ∈ ℤ[U_F] and F² not 2-colourable, χ(F²) ≥ 4. In particular χ(ℚ(√d)²) ≥ 4
  for every squarefree d ≡ 11 (mod 12). The relation is `1 = n(2 − v − v̄)`, with v the type-M rotation and n = (d+1)/4 ≡ 0 (mod 3).
  With `[Fischer1990]` Thm 10(i) and `[Moorhouse2010]` Thm 8.1, χ = 4 at every such d with L = 4, and 4 ≤ χ ≤ 5 at L = 5.
- **§F.5, Poros's extension (hand, Poros; the planner re-derived both mixed cases).** For d ≡ 3 (mod 4) with 3 ∤ n (d ≡ 3, 7
  mod 12), every point of `Θ₃(ℚ(√d))` has only order-3 layers, so θ(R_F) ⊆ (1/3)ℤ/ℤ. **Every three-colouring slope is then an
  additive colouring mod 3** — Fischer's Thm 9 colourings, which are additive in his text (§PA.3). Together with F-T4 this
  classifies `Θ₃` for every real quadratic d ≡ 3 (mod 4).

**Inhabitants and non-examples** (the vacuity rule):
- ℚ(√11) satisfies F-T4's hypotheses, and its conclusion is the kernel's `four_le_chromaticNumber_planeOver_eleven`: a consistency
  check.
- ℚ(√3) and ℚ(√7) have 1/3 ∉ ℤ[U] (a conjugation-stable prime above 3), and both are three-chromatic.
- ℚ(√2) has 1/3 ∈ ℤ[U] but a bipartite plane.

The two hypotheses are each necessary for the conclusion in these examples.

---

## §S. The subplan (WORKFLOW 4)

### §S.1 Routes, in one table

| route | what it decides | carrier | status |
|---|---|---|---|
| R-F (field-level derivation) | T4 for every d ≡ 11 (mod 12), and F-T4 for every F ⊆ ℝ with 1/3 ∈ ℤ[U_F] and a non-bipartite plane | §F, verified in stage C | **primary**, [hand] until C passes |
| R-P0 (exact `Θ₃` certificates) | an explicit finite non-three-colourable configuration per field, checked by a frozen checker | phase 0 | running; confirmation, plus the kernel's per-field input |
| R-V (the uniform finite family `V(d, K)`) | a finite witness for every d at once, with a size bound | stage C4 + P0.3 | secondary; makes F-T4 constructive and kernel-shaped |
| R-T41 (the stub's family) | T41's shape with the twist as a parameter | subsumed | P0.2 maps it (Poros's card 3); no derivation is spent on it |
| R-D (ℚ(√47) at four) | the four-colour hardness band; a priced refusal attempt | stage D | unchanged in aim; re-designed to calibrate first |

### §S.P0 Phase 0 — exact `Θ₃` runs (launched by the owner 2026-09-24 from this spec, with three edits)

*Sent to the owner by message before this section was written. The owner added:*
1. *the owner's plant on any new checker;*
2. *a check of the exact forms of `z` and `z₅` against T40–T41 before building;*
3. *reports at four points.*

*This is the spec of record.*

**Purpose.**
- Controls for the instrument at FS-81's scale.
- The finite shadows of §F: the rational layer at 5-power depth, and the uniform configurations.
- Explicit certified finite witnesses for the 25 open fields, with typed nulls where none is found.

The phase does not carry T4, and nothing it returns refutes §F: a nonempty `Θ₃` on a finite configuration is expected at small
depth.

**Tools.** All untrusted.
- `tools/fs73_theta_lib.py` for keys and unit vectors.
- `tools/fs73v2_xbb.py` (V2's relation tree; it takes explicitly listed units).
- `tools/fs73_theta_cert.py` (the θ-space tree, resumable).
- `tools/fs73v2_thetaR.py` (2-D cells).
- `tools/fs79_p0.py` as the chain pattern. It has D = 167 hard-coded, so copy it under `tools/fs81_*`.

**Frozen checkers:**
- `tools/fs73v2_check.py` (EMPTY and NONEMPTY, listed units);
- `data/fs73/coxeter-c3/certcheck.py`;
- `tools/fs73_theta_check.py`.

Both frozen checkers enumerate the key lattice's unit vectors at O(D³/d), so they are feasible only up to a denominator D of about
2,000. Soundness does not need that enumeration (`fs73v2_check.py`'s own docstring). Above D ≈ 2,000 use a new
`tools/fs81_theta_check.py`: a copy with the completeness enumeration optional and soundness unchanged, its own plants, and the
owner's plant.

| step | what | budget |
|---|---|---|
| **P0.0 controls** | **positive** (must return EMPTY, re-checked frozen): the 36-vector ℚ(√167) certificate `data/fs73/verify-v2/L21cc6506-sub-1vz-empty.json.gz`; `cert_47.json`; E's `Ld65c8ee8` over 11 (the d ≡ 3 mod 8 control); a **new** EMPTY certificate at ℚ(√59) on its certified witness lattice (the calibration at d ≡ 3 mod 8 and at the open fields' coefficient size). **Negative** (a point found and certified): Λ_M over ℚ(√3) and ℚ(√7), M ≤ 60; `Ld65c8ee8` over 59; `Ld14c588b`. No null is read before every positive returns EMPTY within budget | ≈ 1 h |
| **P0.1 the rational layer** | the cells of `Θ(U^(5^K))` on `(1/5^K)ℤ[i]` exactly, K = 2, 3, by level-by-level lifting in 2-D; report every cell per period (parity polygon, order-3 points, anything else). A measurement that aims stage C's finite-level work; extra cells at finite K are *not* a counterexample to L2, which is about all K at once | minutes |
| **P0.2 small-D configurations, all 40 census fields** (the 15 certified ones are controls) | enumerate the parameter first: per d, the type-M `v_d` (and its m = 3 sibling where cheap), the N = 2 twist `z` where a² + d = 2c² (open: 263, 287, 383, 479), the N = 5 twist `z₅ = (2+i)(a − i√d)/(5c)`, a² + d = 5c², at d ≡ 3 (mod 8). Configurations: {1, v, v̄}·U^(5); {vᵏ : \|k\| ≤ 2}·U^(5); {1, v, z}·U^(5) (T41's shape; **check z's exact form against T40–T41 first**); {1, v, z₅}·U^(5). Decide each by xbb with listed units and check it with the frozen `fs73v2_check.py`. Table: d × configuration → EMPTY (certified) / NONEMPTY (certified point) / undecided at the cap, with d mod 8 and n mod 3 as columns | each tree ≤ 30 min; the whole ≤ 1 desktop day |
| **P0.3 the uniform family** (for fields P0.2 leaves open) | `V(d, K) = span({vᵏ : \|k\| ≤ 2}·U^(5^K))`, K = 2, 3, 4, by xbb with listed units, or by a structural certificate in T40's form (the level-K cells from P0.1, the layer maps, a case tree), checked by `tools/fs81_theta_check.py` after the owner's plant | ≤ 1 desktop day |
| **P0.4 fields still open** | the census's open lattices (125 at tier 2l), then the saturated chain Λ_M (M ≤ 420, then 840), cheapest first; residue three-colourings and circular forms first (T17, T20's spectrum read); typed nulls at the depth reached | ≤ 2 h per field |

**Symmetry.** Break every tree by √d ↦ −√d, by the ± pairs and by the i-rotation (G27).

**Stop rule.**
- A field is done at its first certified EMPTY.
- The phase stops when every open field has one, or a typed null at a stated depth, or at 2 desktop days or about 300k tokens.

**Checkpoint and resume.**
- One JSONL record per (d, configuration), appended with fsync under `data/fs81/phase0/`.
- In-flight trees keep state files under `data/fs81/phase0/ckpt/`, outside `build/`.
- To resume, re-run the same driver command: it skips the recorded pairs and resumes the in-flight tree from its state file. The
  implementer writes the exact command in its record's first section.
- A kill redoes at most the in-flight tree since its last checkpoint.

**Heavy runs.**
- Launch under the lock with `setsid`, write a pgid file, and check `flock`'s exit status.
- Bound pysat CaDiCaL asks by a subprocess wall (§G.4).

**Reports** at four points (the owner's edit):
1. after P0.0;
2. after P0.1;
3. after P0.2's table;
4. at the end.

**Acceptance** (what · verified how · pass condition):

| what | verified how | pass |
|---|---|---|
| every EMPTY verdict | the frozen `fs73v2_check.py` or `certcheck.py`, or `fs81_theta_check.py` after the owner's plant | PASS EMPTY |
| every NONEMPTY verdict | the same checker's NONEMPTY path | PASS NONEMPTY on every listed unit |
| controls | P0.0's table | every positive EMPTY and every negative NONEMPTY, both d-classes mod 8 present |
| the configuration builder | unit vectors re-derived in exact integers by the checker; `z`, `z₅` checked against T40–T41 | the checker accepts; the 167 T41 shape reproduces the 1,050-leaf certificate's verdict |
| the table | per field | EMPTY-certified, NONEMPTY at depth X, or undecided at cap Y — never "no" |
| the record | `data/fs81/records/phase-P0.md` | carries **"Theorems this phase proved"** |

**What a result may claim.**
- A certified EMPTY on a configuration over ℚ(√d) proves χ(ℚ(√d)²) ≥ 4. The grade is [cert + hand]: the hand part is T22's ⟹
  direction, derived twice (row 79). By FS73-T11, a sub-configuration's refusal carries up to every lattice containing it.
- A NONEMPTY `Θ₃` is a typed null for that configuration at that depth, never a three-colouring of the plane.
- P0.1 and P0.3 bear on §F's finite shadows. They neither prove nor refute §F.

### §S.C Stage C — independent verification of §F (the owner's ruling, inventory item 24)

**One verifier, V2 pattern.** It is fresh, on Opus 5.5, and has no conversation memory. The brief's content follows.

- **Who and why.**
  - "You are this project's verifier for FS-81.
  - The planner found an argument that would prove χ(ℚ(√d)²) ≥ 4 for every squarefree d ≡ 11 (mod 12), and more (§F's F-T4).
  - One mind produced it; an advisor read it and could not break it.
  - This project's rule (G51, G21) is that a result the team likes gets audited at the same rate as one it does not, and that two
    independent attempts license a claim.
  - Your job is to be the second attempt."
- **What it may read.**
  - `CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`;
  - this plan's §0, §IQ items 1–2 and §F up to "Inhabitants", which are the statements L1–L4 and F-T4, no proofs;
  - `plans/FS73-derivation.md` (T21–T22, T40–T42);
  - `LEDGER.md` rows 72–74, 79; ASTRA-2026-09-14's § B lines; `[Fischer1990]` (held, `library/papers/1-s2.0-0012365X9090324B-main.pdf`);
  - the FS-73 records for T40 (`data/fs73/records/phase-P3b-q167-theta.md` §3, `verify-P3b-q167.md` §7).
- **What it must not open until its C1 verdict is committed:**
  - `plans/FS81-F-sketch.md` (the planner's proofs);
  - Poros's record for this stage (the owner moves it into `plans/` at hand-back);
  - `plans/FS81-close-inventory.md`;
  - this plan's §IQ items 3–4 and §X.

  Say so in words in the brief.
- **Tasks:**
  - **C1 (blind).** Prove or refute L1, L2, L3, L4 and F-T4, each independently. For L2, re-derive T40's cell list on a second code
    path: your own exact arrangement code, not `fs73v2_thetaR.py`, with a planted fault. Write the verdict for each lemma as
    *proved* (with the proof), *gap* (named exactly), or *refuted* (a counterexample). Commit `plans/FS81-C-verification.md` §1
    after each lemma.
  - **C2 (compare).** Now read `plans/FS81-F-sketch.md` and Poros's record. Compare line by line and reconcile. Write §2.
  - **C3 (scope).**
    - The general form's hypotheses, each shown necessary on an inhabitant: ℚ(√11); the new instance ℚ(√2,√7); the
      non-examples ℚ(√3), ℚ(√7), ℚ(√7,√10), ℚ(√2).
    - Poros's classification at d ≡ 3, 7 (mod 12), checked against `[Fischer1990]` Thm 9's additive colourings.
    - The statement "χ(F²) = 3 ⟹ some conjugation-stable prime of F(i) lies above 3", for every real F, against ASTRA-T3/T4.
  - **C4 (finite witnesses).** A finite-level version of L2–L4. Find the least K(d) with `Θ₃(V(d, K)) = ∅` as a function of
    n = (d+1)/4 (the planner's crude estimate is 5^K ≳ 2n), checked against P0.3's data. The result is a finite certificate family
    for every d, which is the kernel's shape.
  - **C5 (filing).** The derivation file's entries (`plans/FS81-derivation.md`: statement, grade, proof address, what rests on it,
    prior art, kernel decision), and "Theorems this phase proved".
- **Standing rules in the brief:**
  - no subagents (one level deep, with the reason);
  - hand-backs content-free, reports to "main" by SendMessage;
  - the heavy lock for anything over 2 minutes;
  - exact scope and grade for every sentence.

**Budget.** C1 ≈ 150k tokens; C2 ≈ 50k; C3–C5 ≈ 100k. About 300k tokens and one working day. No long runs; the cell computation
takes seconds.

**Checkpoint and resume.** `plans/FS81-C-verification.md` is committed after each lemma's verdict. A relaunch reads it and resumes
at the next lemma; a kill redoes at most one lemma.

**The stall criterion: a second mind (G51) joins when any one of these holds:**
1. C1 names a gap in L1–L4 that the verifier cannot close within C1's budget.
2. The verifier's verdict contradicts the sketch on any lemma, and one exchange does not settle it. The exchange is verifier ↔
   planner through the owner, or verifier ↔ Poros.
3. The second-code-path cell list for T40 disagrees with T40.
4. C1 passes 200k tokens without a written verdict on every lemma.

**On a stall.**
- The owner launches a competitor on the disputed lemma only, with a statements-only brief and no access to either verification
  file, plus Poros as advisor, under `plans/PROTOCOL-competitor-and-advisor.md` §1.
- Retraction must stay free: nothing is written into `CLAUDE.md` or `LEDGER.md` until C closes.

**Acceptance** (what · verified how · pass condition):

| what | verified how | pass |
|---|---|---|
| each of L1–L4, F-T4 | a written proof at the publication standard, in the verifier's own words, committed before C2 | proved, or a named gap with the stall criterion applied |
| T40's cell list | a second exact code path with a planted fault that fires | the same cells: one 12-vertex parity cell and four points per period |
| the inverse limit (L1) | written for a non-finitely-generated R_F, indexed by finite symmetric subsets (Poros's form) | no step assumes finite generation |
| the scope (C3) | inhabitants and non-examples computed: 1/3 ∈ ℤ[U] by an explicit relation or by prime inversion; bipartiteness by an odd relation | each hypothesis shown necessary on an example |
| the comparison (C2) | the sketch read line by line | every divergence listed, each resolved or escalated |
| the record | `plans/FS81-C-verification.md` | carries "Theorems this phase proved" |

**What passing buys.** F-T4 at [hand, two independent derivations], the FS-73 standard. It still does not buy a novelty claim: that
waits on §PA.4.

### §S.D Stage D — ℚ(√47) at four colours, calibrated first

**Why it is re-designed.**
- The stub's shape was "FS-79's screen at d = 47, then one refusal ask on the densest survivor, priced".
- G65's law is a three-colour law. FS-79 priced four-colour balls with it, and the owner's report dropped that caveat
  (§R-close.1 item 4).
- No rank-4 lattice graph is known to refuse four colours (Poros's card 5). But **de Grey's lattice plus the one extra generator
  ±v is known to**: `Cay(Λ_dG, U ∪ {±v})`, v = −(4/9)(1 + √−11), refuses four colours on 2,044 points (FS73-T6, LRAT, frozen checker).
- **These refusing controls are abelian Cayley graphs, not unit-distance graphs** (owner's review, §R-review item 2). `Cay(Λ_dG, U ∪ {±v})`
  adds a generator of length |v| = (4/9)√12 = 8/(3√3) ≈ 1.540 ≠ 1, and FS79-T5 and T7 are K₄-free Cayley graphs of ℤ and ℤ² with
  integer generators. **No rank-4 unit-distance lattice graph is known to refuse four colours.** So D0 measures a four-colour band on
  abelian Cayley graphs, and **carrying it to ℚ(√47)'s unit-distance lattices is a [reading]**: D's record states that grade beside
  every price it quotes. The domain pass (§B.1, stage B's record below) defines the band and names what would make the transfer more than a reading.

So D measures the four-colour band on known material before it aims anything at 47.

| step | what | budget |
|---|---|---|
| **D0 the four-colour band** | **refusing families:** balls of `Cay(Λ_dG, U ∪ {±v})` at increasing radius; FS79-T5's rank-1 `G(ℤ, {1,3,7,12,17,22})` and T7's rank-2 product. **Colourable families:** balls of `Cay(Λ_dG, U)` (four-colourable, `F = 8Λ`), of `L21cc6506` (four-colourable and loose), and of ℚ(√47)'s own lattices that D1 finds four-colourable. Per ball: points, average degree, solver, verdict, CPU time, machine. Output: the four-colour phase diagram — where undecided asks cluster, and where refusals decide. Symmetry: pin an edge (ω = 2 on these triangle-free planes) plus value precedence | ≈ ½ desktop day |
| **D1 the screen at 47** | a copy of `fs79_p0.py` for d = 47 (`tools/fs81_d47.py`). The saturated chain Λ_M for M ≤ 2,520. Per lattice, in this order: additive four-colourings; the targets' spectra at 11, 19, 23, 31, 43 (G44), then gapped residue four-colourings (owner's review, §R-review item 1: the spectrum is the lattice's *image* target's, not Γ_q's; at 11 and 19 the sign is slack, so no spectrum refuses there and the gapped ask is a solver's); quotients at every admissible N ≤ 15, gapped colourings aimed at (G68); the periodic Kempe screen (G69); the calibrated exact `Θ₄` finder (`fs79_p3b_theta4.py`, calibrated at 47's coefficient size on lattices known loose, FS79-T45). Survivors are typed by the screens and caps they met; compute their `Θ₄` cells before calling any "rigid" (G73) | ≤ 1 desktop day |
| **D2 one priced ask** | on the densest *minimal* survivor, at the size and degree where D0 says refusals decide, symmetry-broken, under the lock, with a wall from D0 (at most 4× the matched control's refusal time, and at most 6 h). If refused: shrink to a core and certify with the frozen `tools/fs58_check_witness.py`. That would make ℚ(√47) the first real quadratic field needing five (with Γ₁₁: χ = 5), the conjecture's exact prediction met. If not refused: report the price in D0's units | ≤ 1 desktop day |

**Stop rule.**
- D0 ends when the band's edges are located on at least two families.
- D1 ends at M ≤ 2,520 or one desktop day.
- D2 ends at its wall.

**Checkpoint and resume.**
- One JSONL record per ask under `data/fs81/phaseD/`; solver runs go through a subprocess with a wall.
- To resume, re-run the same command: it skips the recorded asks.
- A kill redoes one ask.

**Acceptance** (what · verified how · pass condition):

| what | verified how | pass |
|---|---|---|
| every colouring | an exact checker, frozen or a copy with plants | certified |
| every refusal | the frozen LRAT checker | CERTIFIED |
| every price | reported with its units: points, degree, solver time, machine; the three-colour law never quoted as a four-colour cost | stated with its units |
| the record | the survivors' types | every survivor typed by the screen and cap it met |

**What a result may claim.**
- A certified refusal at 47 proves χ(ℚ(√47)²) = 5. This confirms the conjecture and cannot falsify it.
- A null is a price, not evidence that four colours suffice. Only a four-colouring of the whole plane, local at no prime, would
  falsify the prediction (G48).

**Bearing.** D0's band is what FS-59 (five over ℚ(√167)) needs before it spends anything.

### §S.E Stage E — the close

Worked from `plans/FS81-close-inventory.md`, per WORKFLOW 9.
- **The derivation file:** `plans/FS81-derivation.md` with § B lines.
- **The ledger:** a `LEDGER.md` row for F-T4, if C passes, at its exact grade, and one for phase 0's certificates.
- **G61 rewritten.** Its "no route to T4" becomes a demotion record if C passes.
- **A new grokking in *Do / Killing test* form (G67):** the field-level three-colour theorem, whose layers, gluing and 1/3 relation
  are a method.
- **G72's count:** did the result come through the structural question? (§IQ says yes.)
- **`CLOSED-QUESTIONS.md` §1.7:** only after the Johnson papers are read.
- **Stubs:**
  - FS-75 re-aimed: the kernel route "T22 ⟹ + compactness + C1(5) + L4", parametric in d, or C4's finite family;
  - the layer method at five colours, FS-64's neighbour;
  - multiquadratic fields without √3 (FS-48 re-aimed, ℚ(√2,√7) first);
  - FS-59 re-priced by D0.

### §S.2 Sequencing under the three-agent cap and one heavy job

| when | agents running | heavy lock |
|---|---|---|
| now | planner (finishing A), P0 implementer; Poros idle | P0 |
| after the planner hands back | P0 implementer, B (modeling agent), C (verifier) — C needs only §F's statements, which are fixed | P0; C's cell computation is seconds and runs outside the lock |
| after P0 releases the lock | D implementer replaces P0's; B and C continue or finish | D |
| after C and D | the close planner | none |

D waits for P0 because both are heavy and D0's calibration shares solvers. C does not wait for B: B's passes shape phases D and E,
not the verification of a fixed statement.

---

## §P. Registered predictions (probabilities; both outcomes reachable)

| id | prediction | p | the other outcome, and why it is reachable |
|---|---|---|---|
| **P-F** | stage C verifies F-T4 as stated (no gap left open after the stall criterion) | 0.8 | a named gap or refutation in L1–L4. The argument has not been independently derived |
| P-F-prior | the Johnson papers, once read, contain F-T4 or T4 for an infinite family | 0.05 | they contain only surveys of two-colour and additive results. Unread, so either is possible |
| P-F-gen | C3 confirms the general form (every F ⊆ ℝ with 1/3 ∈ ℤ[U_F], non-bipartite) with no extra hypothesis | 0.75 | an extra hypothesis appears, for instance on the archimedean places of a higher-degree F |
| P0-K1 | K = 1 configurations ({1,v,v̄} or {vᵏ}·U^(5)) are EMPTY for small n (d ≤ 47) and NONEMPTY for most d ≥ 200 | 0.6 | EMPTY throughout, or NONEMPTY even at 11; neither computed yet |
| P0-VK | `V(d, K)` is EMPTY at the least K with 5^K > 2.1n, for every census field | 0.7 | EMPTY only at larger K, or never at K ≤ 4 within budget |
| P0-47 | T41's shape {1, v, z}·U^(5) at d = 47 is EMPTY | 0.55 | NONEMPTY: T41's shape would then be specific to larger n. Not computed |
| P0-T41-finite | T41's fixed-K shape is EMPTY for only finitely many d in the N = 2 family (Poros's card 3) | 0.65 | EMPTY for every d computed to the bound |
| P-G61a | G61's "no route to T4" is falsified at the close | 0.8 (= P-F) | C finds a gap that survives the stall |
| P-G61b | at fixed small K, the EMPTY fraction is higher at d ≡ 7 (mod 8) (n even) than at d ≡ 3 (mod 8) (n odd): a 2-adic skew at finite level, while the field-level answer ignores d mod 8 | 0.6 | no skew, or the reverse. Poros's weak form of R-mod8, never scored |
| P0.1-cells | `Θ(U^(25))` has cells beyond the parity polygon and the four order-3 points | 0.5 | exactly the parity polygon and four points. Uninformative for L2 either way; informative for C4 |
| P-D0 | four-colour refusals on the refusing families decide within 1 h only above an average degree of about 12 | 0.5 | the band sits elsewhere. Unmeasured; the point is to measure it |
| P-D1 | the four-colour screen at 47 leaves at least one survivor at M ≤ 2,520 | 0.7 | every lattice four-colours at the screens |
| P-D2 | D2's single ask refuses within its wall | 0.15 | not refused. The conjecture predicts five, but the cost is unknown |
| P-G72 | the close records F-T4 as having come through the structural question | 0.85 | recorded as coming from elsewhere, for instance from P0's tables |

---

## §M. The modeling passes (WORKFLOW 6)

- **Which passes apply.**
  - **Domain** (always): the field-level object (R_F, `Θ₃(F)`, the layers), the configuration representation phase 0 builds
    (listed units versus keys), and stage D's four-colour band table.
  - **Obligation** (yes): L1–L4's decomposition for stage C, the finite-level K(d) statement (C4), and the proof obligations of any
    new checker.
  - **Experience** (light): the certificate and checker surface (listed-unit certificates, the completeness flag) and the
    verifier's brief.
- **Order:** domain → obligation → experience. The consumer surface is not the milestone's purpose.
- **Lean skeleton: none at this stage.**
  - FS-81 has no kernel phase.
  - Stating L1–L4 in Lean now would formalise an unverified argument before its verification.
  - The kernel route belongs to FS-75's re-aim at the close: T22's ⟹ direction with compactness, C1(5)'s finite input as a
    `decide`-able cell list, and L4's algebra, parametric in d.
  - The modeling agent may revisit this if the domain pass finds a statement that is cheaper to fix in Lean than in prose.

---

## §X. The exchange with Poros (stage A), and its dispositions

| Poros's card | disposition |
|---|---|
| 1. controls from the wrong half (167, 47 both 7 mod 8; 18 of 25 open are 3 mod 8) | **taken**: 11's `Ld65c8ee8` and a new 59 certificate in P0.0; P-G61b registers the weak 2-adic skew |
| 2. which arm reaches d ≡ 3 (mod 8)? enumerate layers per field | **taken** into P0.2 (the parameter first; N = 5 layers). §F makes it moot for T4 itself |
| 3. T41's shape may prove only finitely many d; map (α, β) first | **agreed**: registered as P0-T41-finite. P0.2's table maps the realised shapes, and §F explains why fixed-depth shapes stop as n grows |
| 4. pose §IQ as classification, with Fischer's colourings as field-level negative controls | **taken**: §IQ item 2; §F.5 is the classification at d ≡ 3, 7 (mod 12), checked against Fischer's text (§PA.3) |
| 5. can D be calibrated? no rank-4 lattice refuses four | **answered for abelian Cayley graphs; no rank-4 unit-distance lattice graph is known to refuse four colours** (owner's review, §R-review item 2): de Grey's lattice with the extra non-unit generator ±v refuses four (FS73-T6); D0 uses it and the rank-1/rank-2 K₄-free controls, and the band's transfer to ℚ(√47) is a [reading]. *Superseded disposition (the planner's):* "**answered**", unqualified |
| 6. prior art: κ(D) literature; algebraic tori | **taken**: §PA.2 queries; the torus vocabulary in §PA.1 and §PA.5 |
| its check of §F (five points) | no break found. Its compactness indexing by finite symmetric S ⊂ U_F is adopted in L1's acceptance; its §F.5 extension is recorded at its grade, and both mixed cases were re-derived by the planner |

**Disagreements.** None. Poros asked to state T22's ⟹ direction as load-bearing and hand-graded; §F's grade line does.

**Retractions:** planner 0, Poros 0. By G51's warning, zero retractions means the disagreement has not started; stage C is where it
should.

---

## §R-review. The owner's scoring of stage A (2026-09-24)

*Written by the product owner after reading the plan in full. The body above is the planner's and is not edited; corrections are
listed here and bind the stages that follow.*

**Accepted.** Every hand-back acceptance item is met.

| item | verdict |
|---|---|
| §G | every grokking G1–G73 has a verdict with a reason. Rows 1–81 are grouped only where silent for one reason. Method rules and FS-73 T1–T45 are walked individually, with T31–T35 and T36–T37 in groups. The § B and derivation blocks carry named bearing lines. §G.7 turns every B into an instruction, and §G.8 records what changed. **The test of 3.1 is met emphatically:** the re-grokking (G7 + G62 + G55 + T40) produced §F and re-aimed the milestone. |
| §PA | the eight questions are answered, and the queries are logged with hit counts and whose text each is. `[Fischer1990]` was re-read, and **the relation is his** (Thm 10(ii), Ex. 4). `[DeVosEtAl2007]` was read in full. The Johnson debt is stated with a claim boundary (§PA.4), and §PA.5 carries the object-level lessons forward. |
| §IQ | my challenge is answered: 3.3 is degenerate at the lattice level and not at the field level. The structural form is about every three-colouring of every F ⊆ ℝ. Its check lies on the other side (Fischer's Thm 9), and the open-instance list is complete. |
| the plan | every phase names its budget, stop rule, checkpoint, resume and acceptance. Stage C has a blind-read list and a stall criterion. Stage D calibrates before it aims. The sequencing respects the cap. |

**Corrections, binding on the later stages:**
1. **§G.1's G54 line is wrong at 11 and 19.** It says every usable plane of ℚ(√47) refuses four colours by the ratio bound. The owner
   computed the sign λ_min + d/3 at k = 4:

   | q | λ_min | sign | verdict |
   |---|---|---|---|
   | 11 | −4.796 | −0.796 | **slack** |
   | 19 | −7.610 | −0.943 | **slack** |
   | 23 | — | +0.039 | refuses four by the ratio bound |
   | 31 | — | +0.0002 | refuses four by the ratio bound |
   | 43 | — | +2.704 | refuses four by the ratio bound |

   The conclusion stands: no usable prime of ℚ(√47) is four-tight, so G54's tight mechanism gives no full-rank `F` there. The stated
   reason does not. Stage D reads the targets at 11 and 19 as slack at four colours. They are five-chromatic by certificate (rows 52
   and 69), not by the ratio bound.
2. **Stage D's refusing controls are not unit-distance graphs.**
   - `Cay(Λ_dG, U ∪ {±v})` adds a generator of length |v| = (4/9)√12 ≠ 1.
   - FS79-T5 and T7 are K₄-free Cayley graphs of ℤ and ℤ².

   So D0 measures a four-colour band on abelian Cayley graphs, not on unit-distance lattice graphs. Transferring it to ℚ(√47) is a
   [reading], and D's record must say so beside every price it quotes. §X's "answered" for the advisor's card 5 should read
   "answered for abelian Cayley graphs; no rank-4 unit-distance lattice graph is known to refuse four colours".
3. **Stage B must not change the statements L1–L4 or F-T4 while stage C runs.** C verifies a fixed statement. Any restatement the
   modeling passes find goes to the owner and is applied only after C1's verdicts are committed.

**Tokens.** The planner reported about 230k of working context. The harness counter ended near 600k and counts cumulatively. The
planner delegated nothing.
