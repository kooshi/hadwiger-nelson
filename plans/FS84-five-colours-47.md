# FS-84 — ℚ(√47): five colours — the reframe and the post-ban plan

*Crunch job J29 (2026-09-25), FS-84's planner; brief `data/crunch-2026-09-25/briefs/J29-FS84-post-ban-reframe.md` (template J03's).
Stub: `plans/STUB-five-colours-47.md`. **The reframe runs now; every stage after it runs from 2026-10-01** (the finite-witness ban, `CLAUDE.md`
§ Toolchain). Working files: `data/fs84/j29/`. This plan is fenced from every blind verifier it briefs.*

## Stage 1 — SAVED

### 1.0 Reading, and one deviation named

- `CLAUDE.md`: the copy loaded at my start was checked against disk by diff (`git log -- CLAUDE.md`; the one later commit, `543b51d5`, changes
  only the open-milestone line to name the crunch's M1–M3). `LEDGER.md`: rows 1–56 and 72–97 read in full; **rows 57–71 read to their first
  1,600 characters** (headline and mechanism; the tails are numbers, controls and addresses), a budget choice made at 250k harness tokens.
  Rows 78–81 and 85 read to 4,200–5,200 characters (their tails are prior-art attributions). § B not read (not required by 3.1).
- M1's records read for statements only: `plans/FS91-close-inventory.md` (rows 7, 68, 72, 75, 89, 92, 126), `plans/FS91-S1D-character.md`
  §2.7, §3.1, §3.3, §4.4. FS-81's `data/fs81/phaseD/d47/survivors.md` in full; `data/fs81/records/phase-D.md` by grep only.

### 1.1 Quotation check (standing rule 5)

| # | the brief's statement | source | verdict |
|---|---|---|---|
| Q1 | the stub's mission, quoted verbatim | `plans/STUB-five-colours-47.md` § Mission | **verbatim** |
| Q2 | "the degree law's four-colour aim is about `d_ball ≈ 18.4` … a triangle-free survivor over ℚ(√47) needs ≥ 1,284 times the control's points" (unquoted in the brief) | G65 ("the law's four-colour aim is about 18.4, where a triangle-free survivor over ℚ(√47) needs ≥ 1,284 times the control's points"); row 84 | **faithful**; grade omitted — row 84 grades the price **[reading]**, "not measured", and "that the band on de Grey's lattice (ω = 3) transfers to ℚ(√47) (ω = 2)" is **not claimed** |
| Q3 | "rows 92 and 96: measurable windows over finitely many places, and every character, are excluded as four-colourings of this plane" | row 92 ("over ℚ(√47) and ℚ(√167) no measurable window four-colouring exists at all"); row 96 ("ℚ(√47)'s plane has no character four-colouring (`Θ₄ = ∅`)") | **faithful**; grades travel: row 92 rests at the real place on `[AmbrusEtAl2023]` (external, not re-checked); row 96 at ℚ(√47) "given Lemma R and Weil", re-proved through CLG with no Lemma R (J07 §4.4, J10 blind: two derivations, close inventory row 92) |
| Q4 | "M1 proved the conjecture's `L ≤ 4` clause for every real number field (two independent derivations …)" | close inventory row 7 ("the L≤4 clause for every real number field"), row 68 (J02 and J09, two derivations) | **faithful** |
| Q5 | "M1's class theorem CLG (verified blind …) says every character colouring is local at one stable place" | S1D §3.1, CLG_k: *"`Θ_k(R_F) ≠ ∅` if and only if some stable place `𝔓` of `F(i)` and some level `m ≥ 1` have a band `k`-character of `T_{𝔓,m}`"* | **WIDENED.** CLG_k gives a band character *at* one stable place (the peeled survivor), not that every band character *is* a pullback from one place; the pullback form is proved only where a tight place absorbs the rest (FS89-CL3's fields, S1D §4.4). Also carried: CLG is "given `H_k`"; its blind verification is 24 of 25 statements TRUE with a GAP at (g3) (close inventory row 126); correction owed at row 89. **What FS-84 consumes:** (g1) at `k = 4` — no exception — so `Θ₄(R_{ℚ(√47)}) = ∅` (= row 96), nothing wider |
| Q6 | "Soifer's Open Problem 55.1, `CLOSED-QUESTIONS.md` §3" | `CLOSED-QUESTIONS.md` §3: *"Construct a triangle-free 5-chromatic unit-distance graph"* (`[Soifer2024]` ch. 55, p. 699); "Still open in the plane per the Polymath16 threads (Haugstrup, December 2025)" | **faithful**; §3 adds that `χ(ℚ(√47)²) = 5` would also answer Moorhouse's ℚ(√47) question (§1.7) |
| Q7 | "ℚ(√47) has no √3, so its plane has no triangles — G57" | G57 ("`ω(unit-distance graph over F) = 3` iff `√3 ∈ F`") | **faithful** |

### 1.2 The recognition (the milestone's question in the theory's terms)

**FS-84 asks whether the unit-distance graph on ℚ(√47)² is four-colourable.** In the theory's terms:
- **The field is of type (A).** `47 ≡ 7 (mod 8)` breaks the 2-adic wall (G35), so no stable dyadic place and `1/2 ∈ ℤ[U]`; `47 ≡ 11 (mod 12)` gives
  the type-M rotation `v = (23 + i√47)/24` (`n = 12`, `Σ = 12`, G7, G62) and `1/3 ∈ ℤ[U]` (row 82). Every stable place is odd with prime
  `q ∈ {11, 19, 23, 31, 43, 47 (ramified), 59, …}` (J07 §4.4 check C), and every one refuses four colours at every level with all-levels
  ratio `< 1/4` (rows 75, 88; G54: slack at 11, 19, refusing at 23, 31, 43; none four-tight, FS81-T25). So by Zhang's product rule
  **no periodic four-colouring of the plane exists** (row 92's type-(A) corollary; a periodic colouring is a window colouring), **no character
  four-colouring** (row 96; CLG (g1)), **no measurable window four-colouring over finitely many places** (row 92). A four-colouring, if one
  exists, reads infinitely many places non-measurably. Unlike S2 (G76) there is **no tight place** to pull back from.
- **Five colours would answer three posed questions:** Soifer 55.1 (the plane is triangle-free, G57; row 86's dB4), Moorhouse's ℚ(√47)
  question (`CLOSED-QUESTIONS.md` §1.7), and pin the conjecture's `L = 5` clause at its cheapest exposed field (G48). The prior is therefore low:
  55.1 has been open in the plane since 2019 and de Grey's triangle-free five-chromatic graph lives only in ℝ³.
- **Two refusal routes are left by theorem:** a finite graph (a ball-and-solver refusal — priced out by row 84 — or G55's chain, which needs a
  triangle-free four-colour forced pair, itself Soifer-hard by dB4), and an **averaged** certificate (G73: the only kind of certificate the
  four no-gos leave standing). The amenable-group fact that makes the averaged route exact: `R = ℤ[U]` is a countable abelian group, so
  **the plane is four-colourable iff it carries a translation-invariant random four-colouring** (orbit closure plus Følner averaging). §IQ
  takes this as its invariant.
- **The fractional cap does not bite here** (G60): the cap is `min(4.36, χ_f` of every usable residue plane`)` = `χ_f(Γ₁₁) = 121/28 ≈ 4.32 > 4`,
  so a finite `H ⊂ ℚ(√47)²` with `χ_gf(H) > 4` is not excluded — and would prove five **and** `χ_f(ℝ²) > 4`, which is open in print (the
  record is `[MatolcsiEtAl2025]`'s exactly 4). That puts a price on the route: it is at least as hard as an open fractional problem.

### 1.3 §G.1 — the grokkings, one line each (G1–G76)

*Form: `G<n> — bears: … → stage` / `silent: …` / `falsifiable: registered as P-…`. Stages: S0 recognition (this plan), S1 derivation
(post-ban, solver-free), S2 averaged certificate (post-ban, LP), S3 finite refusal and chain (post-ban, SAT), S4 colouring side (post-ban,
finders).*

- G1 — bears: 47 ≡ 7 (mod 8) breaks the wall, so no residue four-colouring and no free null; every four-colour ask here is live → S0, S3.
- G2 — silent: rotation-centre reading of built witnesses.
- G3 — silent: K-witnesses' radii in ℚ(√33).
- G4 — silent: K's seam-radius inventory; ℚ(√47) has no K-fabric.
- G5 — silent: de Grey's 1-sum.
- G6 — silent: hexagram containment.
- G7 — bears: ℚ(√47)'s own type-M member is `n = 12`, `v = (23+i√47)/24`; every survivor is read as `{vᵏ}`-layers → S1.
- G8 — silent: K's direction group; ℚ(√47)'s analogue is G62/G74's layer factorisation.
- G9 — bears: hunt compulsions one rung below — four-colour forced pairs are the chain's input, Soifer-hard here (dB4) → S3.
- G10 — silent: the 1581's distributed forcing.
- G11 — bears: any five-forcer here is Moser-free; land a forced pair, then chain in-field (spindling leaves ℚ(√47)) → S3.
- G12 — silent: seam-fabric coupling conics.
- G13 — silent: fan structure at five colours; FS-84 asks four.
- G14 — silent: arena cross-edge design.
- G15 — falsifiable: registered as P-G15 (a refusal that does not factor as pigeonhole × kill; reachable only if S3 lands).
- G16 — silent: needs Theorem B's residue colouring and √3.
- G17 — silent: sub-rung carriers on K-fabric.
- G18 — bears: post-ban refusals split by a covered pigeonhole with pinned palettes, never one monolith → S3 brief.
- G19 — silent: five-colour class sweep.
- G20 — silent: brick colourings.
- G21 — bears: "survivor" is a capped screen's null, never a refusal; a finder's null is typed; plants at the question's scale → S1–S4.
- G22 — silent: six-colourings.
- G23 — silent: cell-family scale.
- G24 — falsifiable: registered as P-int (ℚ(√47) is five-chromatic with `χ_f ≤ 4`: the step is integrality, and S2's single-class LP is blind).
- G25 — bears: a ℚ(√47) five-forcer's kills are four-forcer grade (the 169-point certified witness, row 73) — S3's price floor.
- G26 — silent: the six-forcer reduction.
- G27 — bears: `√47 ↦ −√47` preserves every saturated `Λ_M`; break it in every post-ban SAT ask and read the quotient → S3, S4.
- G28 — silent: cell fine tail.
- G29 — silent: the cell family.
- G30 — bears: "every four-colouring of ℚ(√47)² is …" is vacuous if χ = 5 (failure modes 5, 7) — S1 states every such theorem two-way → S1.
- G31 — silent: five-colour pair compulsions (ℚ(√47) is 5-sealed; row 66 makes them trivial).
- G32 — bears: a `{1, δ}` graph with one δ-edge refusing four colours is a forced pair; aim δ with `1/δ ∈ ℤ[U]` → S3.
- G33 — bears: grow toward a forced pair by counterexample-guided halos, not fixed balls (row 84 priced balls out) → S3.
- G34 — silent: K-descent selection.
- G35 — bears: every prime above 2 splits in `ℚ(√47, i)`; `1/2 ∈ ℤ[U]`; no dyadic target — type (A) → S0.
- G36 — silent: K's residue colouring.
- G37 — silent: K-descent endgame; here the endgame is the in-field chain.
- G38 — bears: additive four-colourings absent on all 25 survivors (0/0); no linear route to four; do not re-run → S1.
- G39 — bears: before any forced-pair ask at δ > 2, delete each vertex once (critical vertex beyond distance 2 refutes the design) → S3.
- G40 — bears: a union of layers joined thinly absorbs; predicts nulls on thin survivor extensions → S1 (layer-joining count).
- G41 — bears: the additive one-sided screen is exhausted on survivors; no free separations remain → S1.
- G42 — silent: additive rigidity gauge.
- G43 — bears: 11 is usable of residue degree one — the ceiling five and `L = 5` — nothing to recompute → S0.
- G44 — bears: every stable plane above 11 refuses four by spectrum or certificate: no residue four-colouring target exists → S0.
- G45 — silent: design-and-lift.
- G46 — bears: name the plane a Cayley graph of a countable abelian (amenable) group: invariant measures, symbolic dynamics → §PA, §IQ.
- G47 — silent: five-colour compulsions over sealed fields.
- G48 — bears: FS-84 tests the conjecture's `L = 5` clause; outcome registered before any post-ban solver → §P.
- G49 — bears: gate in the disciplines' words, grep the held Polymath16 threads for √47 and "triangle-free" → §PA.
- G50 — bears: held-unread `[Johnson2000]`, `[Johnson2006]` and `[Soifer2024]` ch. 55 touch the milestone → §PA.
- G51 — bears: any derivation stage gets a blind verifier with a fixed list, disagreement front-loaded → S1, S2 staffing.
- G52 — silent: arena rotation's residue family.
- G53 — bears: the counting screen (`2L >` circle count) refuses a type-M arena from its base alone; the `n = 12` base is the rational pattern → S1.
- G54 — bears: four-colour signs at 11, 19 slack, 23, 31, 43 refusing (FS81-T25): no tight target, no residue forcing — S0; P-G54 scored at FS-81.
- G55 — bears: `1/2, 1/3 ∈ ℤ[U]`; a forced δ prime to every stable prime chains to a refusal in ≤ `m(n−1)+1` points → S3.
- G56 — silent: the six-window.
- G57 — bears: no √3 — triangle-free, no spindle, no triangle pin (5.4× lost); vocabulary must be triangle-free → S3 pricing.
- G58 — bears: a four-colour FINDER on a survivor may use `z ↦ −z` with a colour involution fixing a colour → S4.
- G59 — silent: the wall at six.
- G60 — bears: ℚ(√47)'s fractional cap is `121/28 > 4`; a finite `H` with `χ_gf(H) > 4` proves five (and `χ_f(ℝ²) > 4`) → S2.
- G61 — silent: three colours are decided at ℚ(√47) (row 82).
- G62 — bears: survivors are multilayers `{vᵏ}·U_R` of the `Σ = 12` rotation; decide layer by layer → S1.
- G63 — silent: transcendence.
- G64 — silent: six as a value.
- G65 — bears: four-colour aim `d_ball ≈ 18.4`; every minimal survivor needs ≥ 5.1·10⁷ points there; every post-ban ball priced by it → S3.
- G66 — bears: `L(ℚ(√47)) = 5` at every level; residues cannot close the bracket from above (§1.7); ask no tower → S0.
- G67 — bears (method): this §G is written and scored by Do lines.
- G68 — bears: survivors' quotients refuse to `N = 15`; type (A) says no quotient colours the whole plane, so a quotient finder can only colour a finite lattice → S4.
- G69 — bears: every stable target refuses four, so G69's rigidity screen passes on every ℚ(√47) lattice — rigidity is possible, density must be priced → S1, S3.
- G70 — silent: √3-clean colourings of the Moser lattice.
- G71 — bears: at four colours `Θ₄` emptiness is one-sided — the cell analysis can only colour a survivor, never refuse it → S1, S4.
- G72 — bears: pose the structural form (every four-colouring, averaged) → §IQ.
- G73 — bears: cell-local certificates are empty; the averaged (window-frequency) and structure-derived formats remain → S2 is FS-80's format aimed here.
- G74 — bears: `U_F` factors into layers `b·U₅`; at four colours emptiness proves nothing about χ; glue by relations → S1.
- G75 — falsifiable: registered as P-G75 (a local linear identity on a ℚ(√47) survivor pinning its spectrum to torsion; reading predicts none).
- G76 — bears: ℚ(√47) is not in S2 (no tight place); a "no" is a colouring no character or window gives; count the primes → S0, S1.

**§G.1 counts** (by `grep -cE "^- G[0-9]+ — <verdict>"`): 76 entries (G1–G76); bears 40, silent 33, falsifiable 3 (P-G15, P-int, P-G75).

## Stage 2 — SAVED

### 2.1 §G.2 — the ledger rows, one line each (rows 1–97, by mechanism)

- R1 — silent: two-circle three-colourability on K-fabric.
- R2 — silent: seam identity.
- R3 — silent: coverage ratchet.
- R4 — silent: fan ⟺ coverage (a five-colour-rung tool here).
- R5 — silent: class-only graphs.
- R6 — silent: unit triangles; ℚ(√47) has none.
- R7 — silent: greedy colouring.
- R8 — silent: de Grey's balanced 5-colouring.
- R9 — silent: 120° compulsion on the two circles.
- R10 — silent: one-pivot cap.
- R11 — silent: strip automaton.
- R12 — silent: extension profile.
- R13 — silent: growth-family hunt.
- R14 — silent: pair-gluing classification.
- R15 — silent: extension pressure.
- R16 — silent: coupled automaton.
- R17 — silent: general gluing (any field; not a question here).
- R18 — silent: near-relation.
- R19 — silent: kill mechanism on K.
- R20 — silent: pivot-triangle layer.
- R21 — silent: registered statistics (M23).
- R22 — silent: ladder pair.
- R23 — silent: four-ladder object.
- R24 — silent: hexagram.
- R25 — silent: field-wall identity (K).
- R26 — silent: de Grey anatomy.
- R27 — silent: quadrature census.
- R28 — silent: 2-adic kill engine (√5, √15).
- R29 — silent: stacking law.
- R30 — silent: mechanism hunt on K.
- R31 — bears: the kernel pigeonhole bridge and its vacuity lesson (`core9_plane` vacuous) → S1 states every "every four-colouring" theorem two-way, S3's kernel consumer.
- R32 — silent: two-sided six-programme.
- R33 — silent: the classical interval.
- R34 — silent: coset colourings.
- R35 — silent: coarse cells.
- R36 — silent: scale monotonicity.
- R37 — silent: gap atlas.
- R38 — silent: gradient hunt.
- R39 — silent: gap bands in the kernel.
- R40 — silent: fine tail.
- R41 — silent: limit lemma.
- R42 — bears: `Forces`/`Separated` and the arity floor are the chain input's kernel vocabulary → S3.
- R43 — bears: homogeneity (`transport_pair_of_isometry`) moves a forced pair by every isometry — the chain's transport step → S3.
- R44 — bears: the spindle theorem stays in ℚ(√47) whenever `4d² − 1` is a square there (e.g. `d² = 12`, the `n = 12` member) — a two-copy closer → S3.
- R45 — bears: the spare-colour lemma: a four-colour forcer over ℚ(√47) must be non-three-colourable (contain a row-73-type witness) → S3.
- R46 — silent: copy unions over K.
- R47 — silent: M53's K-descent.
- R48 — bears: a four-colour forced pair confines criticality to its common neighbourhood → G39's deletion check in S3.
- R49 — bears: absorption (`Extends`) — thinly joined layers carry no compulsion → S1's layer-joining count.
- R50 — bears: `[Fischer1990]` Thm 10(ii): `47 ≡ −1 (mod 24)`, so no additive colouring with ≤ 6 colours — the survivors' 0/0 is a theorem → S0.
- R51 — silent: additive rigidity.
- R52 — bears: 11 of residue degree one gives χ ≤ 5 → S0.
- R53 — bears: `chromaticNumber_finitePlane11` = 5 (kernel) — the ceiling's kernel input → S0.
- R54 — silent: lift obstruction.
- R55 — silent: five-colour residue obstruction.
- R56 — bears: `card_le_chromaticNumber_mul_indepNum` and `addCayleyMap` — the kernel consumers of S2's density bound → S2.
- R57 — bears: Theorem A supplies the ceiling; its field-level gap (FS-47) travels with "χ ≤ 5" → S0.
- R58 — bears: at four colours no minimal gadget exists in the plane — a ℚ(√47) forcer is non-minimal and large → S3 pricing.
- R59 — silent: 2-adic law over K.
- R60 — silent: plane freedom (the planes at ℚ(√47)'s stable primes refuse four).
- R61 — silent: statements at six.
- R62 — silent: Parts's record anatomy.
- R63 — silent: two colours and multiquadratic splitting.
- R64 — silent: the ρ₆₃ arena.
- R65 — silent: the `n = 2` shape screen.
- R66 — silent: five-colour fan gaps (ℚ(√47) is five-sealed; FS-84 asks four).
- R67 — silent: the 2-adic tower (ℚ(√47) has no stable dyadic place).
- R68 — silent: six at 83.
- R69 — silent: the six-window.
- R70 — bears: the dyadic trichotomy: all primes above 2 split in `ℚ(√47, i)` — no dyadic target → S0.
- R71 — bears: the blow-up stays in F, so `χ(F²) ≥ ⌈χ_gf(H)⌉`; FS-56's LP and checker are S2's instruments → S2.
- R72 — silent: the 3-adic barrier is a three-colour statement.
- R73 — bears: ℚ(√47)'s 169-point certified witness is S3's seed and control → S3.
- R74 — bears: the census method and "no witness transfers between fields"; odd girth ≤ 9 necessary → S3.
- R75 — bears: all-levels four-colour refusal at 11 (`U = 28.20 < 30.25`) and 19 — the type-(A) inputs; `UD(ℤ/121,2)` refuses four in 1.7 s → S1.
- R76 — bears: FS-70's typed null on its last lattice (six undecided attempts) is the precedent for S3's stop rule → S3.
- R77 — bears (method): theorems filed in `plans/FS84-derivation.md` at the close → close.
- R78 — bears: the forced-group vocabulary in the kernel (`forces_iff_exists_finite`, voltage escape) → S3's consumers.
- R79 — bears: the `Θ`-emptiness certificate format (tree, Farkas leaves, re-enumerating checker) → S4; at four colours it is one-sided.
- R80 — bears: window-frequency LPs are exact in rank 1 and see past `χ_f` (33 points refuse four at `χ_f ≤ 29/8`) → S2's four-class format.
- R81 — bears: ℚ(√167)'s seven survivors outlasted P3b; a full-dimensional cell makes a survivor loose → S4 and P-surv.
- R82 — bears: `χ(ℚ(√47)²) ≥ 4` by the layer theorem (`d ≡ 11 mod 12`); the layer method's four-colour version is one-sided → S0, S1.
- R83 — bears: five-layer structural certificates; at `d = 47` the three-colour threshold is `K = 2` (47 < 105) — the configuration S1 starts from → S1.
- R84 — bears: the calibration, the survivor list and the price — S3 and S4 directly; P-D0 unscored.
- R85 — bears: the annihilator (Kari–Szabados) mechanism — a local linear identity pinning the spectrum — is P-G75's test → S1.
- R86 — bears: dB4: a triangle-free four-colour forced pair exists iff Soifer 55.1 has an answer — S3's route is Soifer-hard → S0, S3.
- R87 — bears: radius-1 second moments cannot lift on `Λ`; averaged certificates need joint four-class windows at radius ≥ 2 → S2.
- R88 — bears: Lemma P carries FS-66's certificates to ramified towers (the 47-place) → S1.
- R89 — silent: K's classification.
- R90 — silent: the rigid local plane at `ℚ₂(√3)` (ℚ(√47)'s dyadic completions are split).
- R91 — silent: its no-gos are relative to pullbacks, which do not exist at ℚ(√47).
- R92 — bears: the type-(A) corollary (no measurable window four-colouring) — S1 re-derives its periodic case without `[AmbrusEtAl2023]` → S0, S1.
- R93 — silent: dyadic towers containing √3.
- R94 — bears: C9's formula colouring needs a stable place of ratio ≥ 1/4; ℚ(√47) has none — the formula route to four is closed → S4; Theorem C's invariant-colouring frame → S2.
- R95 — bears: band rigidity at ≥ 2 split primes → S1 (the survivors' split-prime count).
- R96 — bears: `Θ₄(R_{ℚ(√47)}) = ∅`; by compactness some finitely generated `Λ_M` already has `Θ₄ = ∅` → S1, S4.
- R97 — bears: at one split prime heteroclinic band characters exist — **every minimal survivor's `M` has exactly one prime ≡ 1 (mod 4)** → S4, P-1p.

**§G.2 counts** (by grep): 97 rows; bears 36, silent 61.

### 2.2 §G.3 — the method rules, one line each

*§ Grokkings' method entries (G21, G30, G46, G49–G51, G67, G72) are walked in §G.1. Below, `CLAUDE.md` § The standard of evidence (E), § What
compute actually helps (C), § Toolchain (T), § Building and the kernel cost model (B), § Searching (Se) and § The gate (Ga).*

- E1 no native evaluation in a headline — bears: a ℚ(√47) refusal is headline-grade; its route is LRAT to the kernel (FS-60/75) → S3.
- E2 certificate plus checker — bears: K2 (`tools/fs81_check_witness_k.py`) is the refusal checker; S2 needs its own → S2, S3.
- E3 re-derivable witness — bears: state the construction (lattice key, radius) → S3.
- E4 read the statement aloud — bears → close.
- E5 report the hunt — bears: typed nulls in every stage → all.
- E6 write the reviewer's certificate early — bears: S2's dual is written as an identity first → S2.
- E7 order verification by marginal value — bears → S3.
- C1 re-price kernel leaves from the first two — silent: no kernel phase planned.
- C2 a GPU is not a SAT accelerator — bears: S3 is CPU cubes; S2's LP may use the GPU → S2, S3.
- T1 the ban to 2026-10-01 — bears: every stage below is dated from 2026-10-01.
- T2 verify tools with `command -v`; a missing tool fails silently — bears → every brief.
- T3 pysat CaDiCaL ignores `interrupt()` — bears → S3 (subprocess timeouts).
- T4 venvs outside `build/` — silent.
- T5 pin a maximal clique — bears: `ω = 2` here, the pin is one edge (weak) → S3.
- T6 precedence over unpinned colours only — bears → S3.
- T7 price cubes on a sample — bears → S3.
- T8 no UNKNOWN from an unbroken encoding — bears → S3.
- T9 Python 3.14 `forkserver` — bears → S2, S3 tools.
- T10 CPU seconds, minimum of three, machine named; contended times 2–3× — bears → every price.
- T11 predicted throughput beside measured — bears → S3.
- B1 `scripts/build.sh` only — silent: no kernel build planned.
- B2 `lake env lean` is not the gate — silent.
- B3 the batch is the plan — silent.
- B4 halt on an unexplained crash — bears → every brief.
- B5 RAM is the discriminator; `scripts/slot.py` — bears → every brief.
- B6 checkpoint and resume (PROTECTED) — bears: every S2/S3/S4 brief names its checkpoint and resume command.
- B7 a blocking run is presumed killable (PROTECTED) — bears → S3.
- B8 kill by pgid, verify by effect — bears → S3.
- B9 pipes kill producers; read the gate's own exit status — bears → S3.
- B10 never edit a running script — bears → S3.
- B11 generated-module invalidation — silent.
- B12 `decide +kernel`, literals, `List.all` — silent: no kernel phase.
- B13 feed the kernel the refutation's core — bears: a ℚ(√47) refusal's kernel form (FS-60) → S3.
- Se1 `ugrep` alternation and `^` — bears: count certificates with `grep -oF` or `rg` → all.
- Se2 `rg` hides `.lake/`, `build/` — silent.
- Se3 a failed `exact?` is not an absence — silent.
- Ga1 `vacuity.sh` — bears: "every four-colouring of ℚ(√47)² …" is a ∀ over a possibly empty domain → S1 states two-way.
- Ga2 gates keep their output — silent.
- Ga3 structure hypotheses ship an inhabitant — bears: S1's type-(A) theorem needs an inhabited instance (ℚ(√167) or a non-field model) → S1.
- Ga4 one `#eval` per definition — silent.
- Ga5 the spindle twice — silent.
- Ga6 negative controls every milestone — bears → S2, S3.
- Ga7 a positive signal for what did not happen — bears → S3 waiters.
- Ga8 a waiter false at arming; no pattern that matches the shell — bears → S3.
- Ga9 both outcomes reachable — bears → §P.
- Ga10 pre-decide the response to your own gate failing — bears → §P.
- Ga11 a sharp instrument loses the broad one's coverage — bears: S2's LP sees averages, not the finite witness S3 sees → S2.
- Ga12 one thing differs; carry what a number measures — bears: row 84's 1,284 compares an ω = 3 control to an ω = 2 survivor, two things differing → S3 pricing.
- Ga13 measured versus derived halves — bears: the saturated lattices' edges are exact (derived); a refusal there is the verdict to audit → S3.
- Ga14 a check reads the shipped value — bears → tools.
- Ga15 the failure path's formatting — bears → tools.
- Ga16 two-sided plant bounds — bears → S2 tools.
- Ga17 replay policies over a recorded log — silent.
- Ga18 a failing run's cost understates a succeeding one — bears → S3 pricing.
- Ga19 a caveat stepped over — bears → report.
- Ga20 count the generator's free parameters — bears: S2's window family and S4's character shapes → S2, S4.
- Ga21 a true explanation stops the search for a second — bears: the one-prime reading of the survivors must be checked against every screen → S4.
- Ga22 a mutation harness verifies its restore — bears → tools.
- Ga23 mutate the constant — bears → tools.
- Ga24 archiving a checker (module identity) — silent.
- Ga25 enumerate the parameter first — bears: the survivors' split-prime structure is enumerated before screening → S4.
- Ga26 a positive control finds only representable shapes — bears: P3b's calibration positives were torsion+archimedean, not heteroclinic → S4.
- Ga27 enumerate how a one-sided filter becomes inapplicable — bears → S2.
- Ga28 plant faults routinely — bears → tools.

**§G.3 counts** (by grep): 64 rules; bears 50, silent 14.

### 2.3 §G.4 — what the re-grokking changed

1. **The stub's step 1 is demoted and re-aimed.** Exact `Θ₄` cells on the survivors were billed as a refusal step. G71 and row 96 say it can
   only *colour*: `Θ₄` emptiness is one-sided at four colours, and `Θ₄(R) = ∅` is already a theorem. It moves to S4 (the colouring side), and
   row 97 aims it: **all ten minimal survivors have a denominator with exactly one prime ≡ 1 (mod 4)** (240, 360, 840: 5; 408: 17; 1272: 53;
   1464: 61; 2136: 89; 2184: 13; 2328: 97; 2424: 101 — hand factorisation), which is exactly where band rigidity fails. P3b's calibration
   positives were torsion+archimedean shapes (Ga26), so its null says nothing about one-prime heteroclinic characters.
2. **A route the stub lacked, S2 (averaged).** G60's cap is `121/28 > 4` at ℚ(√47), G73 leaves averaged and structure-derived formats, and
   amenability makes the invariant-measure formulation exact. This is FS-80's window-frequency format aimed at ℚ(√47) instead of ℚ(√167).
3. **The stub's step 3 is demoted.** Residue re-asks at 600 s and quotients at `N ≥ 16` can only colour a finite lattice (type (A): no quotient
   colours the plane), and a quotient refusal is not a lattice refusal (row 81). They go to S4, behind the one-prime reading.
4. **The chain (stub step 2) is priced honestly.** dB4 (row 86) makes its input — a triangle-free four-colour forced pair — exactly as hard as
   Soifer 55.1; row 44 adds an in-field two-copy closer at `4d² − 1 ∈ ℚ(√47)²`; R45 and G39 add two free design checks.
5. **A derivation stage, S1**, collects what the corpus holds only in pieces: the type-(A) theorem for ℚ(√47) with its periodic case free of
   `[AmbrusEtAl2023]`, the invariant-measure equivalence, and the one-prime reading.
6. **Predictions registered in §P:** P-G15, P-int, P-G75 (from §G.1), P-surv, P-1p (from rows 81, 97).

## Stage 3 — SAVED

### 3.1 §PA — the prior-art gate (time-boxed; about 15k tokens spent of the 60k allowed)

**The recognition's words, two disciplines.** (a) *Unit-distance graphs / Euclidean distance graphs on rational or algebraic points*
(discrete geometry); (b) *fractional and measurable colourings of infinite graphs, invariant measures on colouring shifts of abelian Cayley
graphs* (graph theory / symbolic dynamics). The questions: is a triangle-free five-chromatic planar unit-distance graph known; is
`χ(ℚ(√47)²)` known; is `χ_f` of the plane (or of a field plane) known above 4.

| # | query (zbMATH Open API, discovery) | hits | what it found |
|---|---|---|---|
| PA1 | `ab:"unit distance" & ab:"triangle-free" & py:2010-2026` | 3 | Exoo–Ismailescu 2016 (small triangle-free **four**-chromatic); **Silva Filho 2026** (arXiv 2607.19995: exact coordinate fields of the triangle-free Exoo–Ismailescu graphs EI17, EI19 — solvable/non-solvable, degree-20; not ℚ(√47)); EuroComb 2013 abstracts |
| PA2 | `ab:"unit distance graph" & ab:"girth" & py:2000-2026` | 2 | `[deGrey2026]` (five-chromatic triangle-free, **ℝ³**, 61 vertices); Raigorodskii 2014 |
| PA3 | `ti:"fractional chromatic number" & ab:"plane" & py:2015-2026` | 2 | `[MatolcsiEtAl2025]` ("at least 4", 2023 listing); Cranston–Rabern 2017 — **nothing above 4** |
| PA4 | `ab:"unit distance" & (ab:"number field" \| ab:"quadratic field" \| ab:"rational points") & py:1985-2026` | 3 | nothing on a field plane's chromatic number (Füredi–Kang 2004, Bhattacharya–Goenka 2026, Singhal 2017 — off-topic) |
| PA5 | `au:"Johnson, Peter D." & ab:"chromatic"` (item 8: the poser's full listing) | 33 | **Johnson 1996** (*About two definitions of the fractional chromatic number*, Zbl 0856.05036: the LP and set-colouring definitions agree when finite; open problems on infinite graphs); **Johnson 2000** (*Infinite graphs and the fractional chromatic number: some recent surprises*, Zbl 0945.05021: the full graph's `χ_f` against its finite subgraphs'); **Johnson–Rodger 2005** (*Coloring the vertices of a graph with measurable sets in a probability space*, Zbl 1059.05050); **Johnson 2011** (*Euclidean distance graphs on the rational points*, Zbl 1243.05082, a survey of `χ(ℚⁿ, {d})`); 2021 *On single-distance graphs on the rational points in Euclidean spaces* (Zbl 1461.05078). `[Johnson2000]` (status report) and `[Johnson2006]` (rational points compendium) are the bibliography's unread entries |

**The held Polymath16 threads** (`~/source/library/notes/polymath16-threads-1-18-text.txt`, grepped for "triangle-free" and for √47):
- thread 11 (29–30 December 2018, ag24ag24 and Parts): *"it makes sense that a triangle-free graph would typically have a FCN less than 3
  regardless of its CN"* — the fractional chromatic number of triangle-free unit-distance graphs measured low. **This bears on S2** (P-int).
- the Algebraic-formulation discussion: *"Without triangles, of course, it must be computationally very hard"* (to decide a field plane).
- December 2025 – February 2026 (Haugstrup, de Grey): Soifer's question restated as open in the plane; five-chromatic triangle-free in ℝ³
  (61 vertices), six-chromatic triangle-free in ℝ⁴ by pseudo-edges; Joe–Noble 2023 (arXiv 2303.09513) on triangle-free `ℚ³` distance graphs.
- No mention of √47 or ℚ(√47).

**Verdicts.**
1. **The question is open in print, and posed three times:** Moorhouse (ℚ(√47), `CLOSED-QUESTIONS.md` §1.7), Soifer 55.1 (2019, in
   `[Soifer2024]`), and the conjecture here. No triangle-free five-chromatic planar unit-distance graph was found in zbMATH or the threads to
   May 2026. A negative from four queries measures their words (G21); the arXiv after May 2026 was not searched.
2. **`χ_f(ℝ²) > 4` is not in print** (PA3): S2's single-class route would beat the published record through a triangle-free field — a price,
   and a reason for the low prior at P-int.
3. **The infinite-graph fractional literature is Johnson's** (PA5), and its "surprises" are exactly about `χ_f` of an infinite graph against
   its finite subgraphs — the step S1's invariant-measure lemma takes by amenability. **Owed before S1 relies on it:** Johnson 1996, 2000
   (surprises) and Johnson–Rodger 2005 read (a debt, G50); Scheinerman–Ullman's *Fractional graph theory* ch. 3 is the textbook form.
4. **Bibliography proposals** (for the front-page lane; this job edits no bibliography): `[Johnson1996fcn]` (Zbl 0856.05036),
   `[Johnson2000surprises]` (Zbl 0945.05021), `[JohnsonRodger2005]` (Zbl 1059.05050), `[Johnson2011rational]` (Zbl 1243.05082),
   `[SilvaFilho2026]` (arXiv 2607.19995), `[JoeNoble2023]` (arXiv 2303.09513). Titles from zbMATH listings only — none read.

### 3.2 What §PA taught about the object (WORKFLOW 9's sweep, done early)

The Polymath16 measurement that triangle-free unit-distance graphs typically have fractional chromatic number below 3 says the
single-class averaged invariant is weak exactly where FS-84 lives: triangle-freeness removes the dense cliques that make `χ_f` large. It is a
reading, not a theorem (finite graphs; the geometric blow-up can be larger), and it moves weight in §P from S2's single-class form to its
four-class (window-frequency) form, which row 80 shows can refute where `χ_f < 4`.

### Would-have-searched-here log (stages 1–3)

- Would have run P3b's exact `Θ₄` finder on the ten minimal survivors to test the one-prime reading; instead derived that each survivor's
  denominator has exactly one prime ≡ 1 (mod 4) (hand factorisation) and registered P-1p for S4.
- Would have asked the ten survivors' UNKNOWN residue targets at 600 s; instead recorded (G68, type (A)) that such an answer can only colour a
  finite lattice, and demoted the ask to S4.
- Would have sampled a four-colour ball at `d_ball ≈ 18` on Λ₂₄₀ to price S3; instead priced it from row 84's recorded numbers (§S).

## Stage 4 — SAVED

### 4.1 §IQ — the invariant question (WORKFLOW 3.3)

1. **Existence form.** Is there a finite unit-distance graph with vertices in ℚ(√47)² that is not four-colourable?
2. **Structural form.** *Let `R` be a countable abelian group, `U = −U ⊂ R` generating, and `k ≥ 2`. When does `Cay(R, U)` carry a probability
   measure on its proper `k`-colourings invariant under translation (and under any amenable group of automorphisms preserving `U`)?* Posed
   with the arithmetic stripped, it is equivalent to `k`-colourability for every such graph (orbit closure plus Følner averaging), and it asks
   about **every** colouring at once, through the measure its orbit carries. For ℚ(√47), `R = ℤ[U_F]` and the symmetry is `R ⋊ U_F` (solvable,
   hence amenable), so the measure may be taken rotation-invariant too.
3. **The invariant it forces.** The invariant random colouring's **joint window frequencies** — the probabilities of the colour patterns on a
   finite window, consistent under the group — in symbolic dynamics, the invariant measure of the colouring subshift. Its single-class
   shadow is the colour-class density (each `1/k` after symmetrising colours), whose upper bound is the plane's invariant independence density
   `ι(F)`; its second-moment shadow is the pair-correlation (Delsarte) LP. **Both shadows are known too weak here:** the pair LP's bound is
   the least local character mean's `0.2871 > 1/4` (row 92 names Hoffman's 0.2871; row 91's C0: pair correlations admit a purely archimedean
   spectrum), and triangle-free graphs typically have `χ_f < 3` (§PA). So the invariant that could decide is the joint **four-class**
   window measure at radius ≥ 2 (row 87 closes radius 1 on de Grey's lattice) — named, not yet shaped.
4. **Its route.** Derivation fixes the window, the symmetry quotient and the relaxation level, and writes the dual as an identity (S1d);
   an exact LP then checks that derived shape (S2), never escalating. A search never answers the structural form.
5. **The open instances it would decide.** ℚ(√47), ℚ(√143), ℚ(√311), ℚ(√335) (four against five at `L = 5`, rows 74, 84); ℚ(√3,√5)'s rank-8
   lattice (FS-72); ℚ(√167) at five colours (FS-59); de Grey's field at six (FS-49's aim); in its single-class form, `χ_f(ℝ²) > 4`.

### 4.2 §S — the stages (every one from 2026-10-01; S1 alone is solver-free and could start earlier if the owner rules so)

| stage | what | kind | budget | stop rule | checkpoint / resume |
|---|---|---|---|---|---|
| **S1** | derivation: S1a the type-(A) theorem at ℚ(√47) (periodic case without `[AmbrusEtAl2023]`); S1b the invariant-measure equivalence and its single-class corollary, with Johnson's infinite-graph `χ_f` papers read first; S1c the one-prime reading of the ten minimal survivors, each ending in a **formula** character or a named obstruction; S1d the shape and price of S2's LP; S1e P-G75's linear-identity question | hand + exact checks of seconds | one agent, ~3 h, 350k | a stage whose derivation stalls twice is written as GAP with the missing step named | the record's `Stage n — SAVED` sections; resume at the first unsaved |
| **S1V** | blind verifier of S1a–S1c against a fixed claim list | hand | one agent, ~2 h, 300k | per claim TRUE / FALSE / GAP; a blind phase that stalls moves to the lemma statements (FS-89's fallback) | its record's stages |
| **S4** | the colouring side: (i) S1c's formula characters checked exactly on each survivor's unit vectors; (ii) the UNKNOWN residue targets re-asked by a copy of `tools/fs81_d47.py` (its `recheck` hard-codes FS-81's `OUT` and removes committed sweep records — see the S4 brief); (iii) quotients at `N = 16–20`; (iv) a four-colour finder on the antipodal quotient (G58) | exact check, then SAT and finders | (i) seconds; (ii) ≤ 375 asks × 600 s ≈ 62 CPU-h worst case (15 survivors carry UNKNOWN targets, ≤ 25 each; `survivors.md`), 4 h wall on 16 cores; (iii)–(iv) 4 h wall | a lattice leaves the list at its first certified colouring (K1 checker); the stage ends at its wall | the tool is resumable by its own JSONL caches (`residue-cache.jsonl`, `screen.jsonl` under its OUT directory; checked: `load_jsonl` of the done set at start); resume = re-run the same command |
| **S2** | the four-class window LP of S1d's shape on the smallest lattice S4 leaves | exact LP | set by S1d; declined if S1d prices it above one machine-day | infeasible → a Farkas dual, read back as an identity and checked exactly; feasible → a typed null at that shape | LP instances written to `data/fs84/s2/` before solving; one instance per process under 15 min, else split |
| **S3** | the finite refusal: forced-pair asks at chainable distances (`d² ∈ {1/2, 5/2, 12, …}`, where `4d² − 1` is a square in ℚ(√47) and the spindle closes in-field, row 44; or `1/δ ∈ ℤ[U]`, G55) by counterexample-guided growth (G33) from the 169-point witness (row 73) | SAT (kissat, CaDiCaL LRAT), K2 checker | **runs only if S1–S4 hand it a candidate** (a lattice with `N(d*) ≤ 5·10⁶`, or a derived forcing gadget); default declined: row 84 prices a matched ball at ≥ 5.1·10⁷ points | the first UNKNOWN at the matched radius ends it (FS-70's six-attempt precedent, row 76) | per-wave halo files under `data/fs84/s3/`; resume from the last wave |

**Order:** S1 → S1V and S4(i) together → S4(ii)–(iv) → S2 → S3. **Pricing, from records only** (no sampling run): row 84 (`t_A` = 55.41 s at
`d*` = 18.41 on 39,829 points, quiet; `R = 1.4` at 462.7 s; the undecided band `d_ball` 8.3–14.7); `survivors.md` (`N(d*)` from 5.1·10⁷ at
Λ₂₄₀ to 2.5·10¹¹ at Λ₂₄₂₄); row 76 (a 1.9 M-point control undecided after 14,800 s); Ga12's caveat: the control is ω = 3, the survivors ω = 2.

### 4.3 §P — registered predictions (before any post-ban stage runs)

| id | statement | probability | the uninformative outcome, and is it reachable |
|---|---|---|---|
| P-FS84 | the milestone certifies `χ(ℚ(√47)²) = 5` | 0.03 | a typed null (0.965) — reachable and likeliest; a four-colouring of the plane, 0.005 |
| P-1p | S1c/S4(i) four-colour at least one minimal survivor by a character built on its one split prime | 0.35 | none coloured — reachable |
| P-surv | all ten minimal survivors still survive S4 | 0.45 | reachable; complements P-1p only in part (other routes may colour) |
| P-int | `ι(ℚ(√47)) < 1/4` (the single-class averaged route proves five, and `χ_f(ℝ²) > 4`) | 0.03 | S1d finds the single-class LP feasible at every shape priced — reachable |
| P-S2 | S2's four-class window LP refutes four-colourability of some ℚ(√47) lattice | 0.07 | feasible at the priced shape — reachable |
| P-S3 | a four-colour forced pair at a chainable distance is certified over ℚ(√47) | 0.03 | S3 declined or UNKNOWN — reachable |
| P-S1a | S1a's no-periodic theorem stands on two derivations without `[AmbrusEtAl2023]` | 0.85 | a GAP at the ramified 47-place (Lemma P's scope) — reachable |
| P-G75 | no local linear identity pins a ℚ(√47) lattice's spectrum to torsion (G75's reading) | 0.85 | a named identity found — reachable, and it would be the finding |
| P-G15 | a refusal, if one lands, factors as pigeonhole × kill | 0.70 | unscored unless P-S2 or P-S3 lands |
| P-int′ | the ℚ(√47) plane is five-chromatic with `χ_f ≤ 4` (G24's integrality at five) | unscored | reachable only if P-FS84 lands |

**Pre-decided responses (Ga10):** if S4 colours every minimal survivor, the next survivors are the two-split-prime lattices, and the report
says the ten were a one-prime artefact, not that ℚ(√47) is "closer to four". If S2's LP is feasible, the report names the shape, not the field.

## Stage 5 — SAVED

### 5.1 §M.1 — domain modeling (fresh `debruijn-domain-modeling` invocation, applied to the statements)

- **S1a, modeled as a number, not a non-existence.** The intrinsic object is the *periodic independence ratio*
  `ρ_per(F) = sup_L α(Cay(R/L, U+L)) / [R : L]` over finite-index `L ≤ R = ℤ[U_F]` with `U ∩ L = ∅`. Statement: **`ρ_per(ℚ(√47)) < 1/4`**,
  bounded by the maximum over stable places of the all-levels ratios (Lemma C factors every quotient through the stable places; `[Zhang2012]`
  Thm 1.8(i) makes the product's ratio the factors' maximum). The binding factor is **31** (Hoffman in an inert tower, `1/4 − 2.745·10⁻⁶`), not 11
  (`28.2043/121 = 0.2331`); the margin is named, the conclusion ("no periodic four-colouring") is the `k = 4` shadow via
  `card_le_chromaticNumber_mul_indepNum` (row 56). It concludes a refusal, so it is not vacuous. **Unsampled member:** the ramified 47-place
  (Lemma P, Theorem E) — its all-levels ratio must be stated, not assumed (P-S1a's GAP risk).
- **S1b, modeled with the arithmetic stripped.** *For a countable amenable group `G` acting on a graph `Γ` by automorphisms: `Γ` is
  `k`-colourable iff there is a `G`-invariant Borel probability measure on its proper `k`-colourings; hence, with
  `ι_G(Γ) = sup_μ μ{I ∋ v₀}` over `G`-invariant measures on independent sets (vertex-transitive `G`), `k`-colourable ⟹ `ι_G(Γ) ≥ 1/k`.* Density
  as `P(v₀ ∈ I)` needs no Følner sets in the statement. **Adversarial member:** a non-amenable `G` (free-group Cayley tree, two-colourable,
  no invariant colouring measure under its full automorphism group is not the issue — the ⟹ direction's averaging fails) — amenability is the
  named hypothesis. Instance: `G = R ⋊ U_F` (solvable). Prior art owed: Johnson–Rodger 2005, `[MatolcsiEtAl2025]`'s blow-up.
- **S1c, and the cut it failed.** The one-prime reading (§G.4 item 1) is **confounded by the sweep's range**: among `M ≤ 2,520` with `24 | M`
  only 1560 (`5·13`) and 2040 (`5·17`) have two primes ≡ 1 (mod 4), so "every minimal survivor has one" is nearly forced by the enumeration
  (Ga25, G21) — incidental, not intrinsic. The one discriminating datum on disk cuts against it: **Λ₁₅₆₀ is a candidate that four-colours by a
  quotient** (`data/fs81/phaseD/d47/screen.jsonl`), while Λ₂₀₄₀ survives only because it contains Λ₄₀₈. P-1p is lowered to 0.25 (§P
  amended below). S1c's output is modeled as a **parsed witness**: a rational `θ` on a ℤ-basis of `Λ_M` with every `θ(u)`, `u ∈ U_M`, checked in
  `[1/4, 3/4]` by Fractions (a periodic colouring of period `ord θ`), or a named obstruction — never an irrational or float `θ`.
- **S2's LP, modeled as the level-`W` relaxation of the invariant measure.** Variables: frequencies of proper colourings of a window `W`
  up to the stabiliser of `W` in the point group × Galois flip × `S₄`; constraints: shift-consistency of marginals on `W ∩ (W + u)`, `u ∈ U_M`.
  Its dual is a discharging identity (a weight on window patterns whose translates sum to a strictly negative constant). The window must
  reach radius ≥ 2 (row 87) and hold more than pair constraints; S1d names `W` and counts its orbit-reduced variables before any run.

**§P amended:** P-1p 0.35 → **0.25** (the confound above); P-surv 0.45 → 0.50.

### 5.2 §M.2 — obligation modeling (fresh `debruijn-obligation-modeling` invocation)

**S1a — `ρ_per(ℚ(√47)) < 1/4`**, decomposed into local obligations (P = prove, A = assume as a named input, T = test):
- a1 [A: Lemma C, J07, one mind — flag it] every finite-index `L` factors through `ρ_K : R → ∏_{𝔓∈S_N} O_𝔓/𝔓^K`, `ker ρ_K ⊆ L`.
- a2 [A: CLG-c, the joint image] `ρ_K(U) = ∏ S_{𝔓,K}`, so `Cay(ρ_K(R), ρ_K(U))` **is** the categorical product of the local levels — without
  this the source graph has fewer edges than the product and its ratio is not bounded by it (the step a proof would silently skip).
- a3 [P, one line] `Cay(ρ_K(R), ρ_K(U)) → Cay(R/L, U+L)` is a homomorphism onto a vertex-transitive graph, so the No-Homomorphism lemma
  gives `α(R/L)/[R:L] ≤` the product's ratio; `[Zhang2012]` Thm 1.8(i) makes that the factors' maximum.
- a4 [P per prime + one analytic lemma] the stable odd places are exactly the `q ≡ 3 (mod 4)` with `(47/q) = 1`, plus the ramified 47 (the
  inert `q` split in `F(i)/F`; `p ≡ 1 (4)` split in ℚ(i); 2 split, G35) — a finite table 11, 19, 23, 31, 43, 47 (cited certificates, Hoffman
  in inert towers, Lemma P at 47) and, for `q ≥ 59`, Hoffman–Weil with the inert-tower ratio constant (G54). **The sup is attained** at 31
  (`1/4 − 2.745·10⁻⁶`); strictness needs only the finite table plus Weil's decay.
- T: the table's numbers re-read from their certificates' files, never from this plan (Ga14).

**S1b — the invariant-measure equivalence**: b1 [P] ⟸ trivial; b2 [A: amenable actions on compact metrizable spaces carry invariant measures —
Følner averaging, weak* limit; cite, not re-prove] ⟹ applied to the closed invariant set of proper colourings in `k^V`; b3 [P] symmetrise over
`S_k` (it commutes with `G`) and read class 1 at `v₀`: `ι_G ≥ 1/k`; b4 [A: `[MatolcsiEtAl2025]`] `ι_G ≤ 1/χ_gf(H)` for every finite `H`.
Inhabitant for the vacuity gate: ℚ(√11)'s plane (four-colourable, row 73 with `Γ₇`) under `R ⋊ U`.

**S1c — a parsed rational band witness**: c1 [T, the checker] a basis of `Λ_M` from the tool's key and `θ ∈ ℚ⁴` on it; every `u ∈ U_M` has
`θ(u) mod 1 ∈ [1/4, 3/4]` in Fractions — a faithful finite transcription, with a plant (one `u` moved out of band) that must fire; c2 [P] the
construction of `θ` from the survivor's layer structure, or a named obstruction — its space is the finite set of torsion-type assignments per
layer that row 95's six types and row 97's leaves allow, fixed by the derivation before any check (the ban's edge: a complete enumeration of
a derived finite set, logged as such).

### 5.3 The briefs written (post-ban, dated from 2026-10-01)

- `data/crunch-2026-09-25/briefs/J29-S1-FS84-derivation.md` — S1 (S1a–S1e), one derivation agent.
- `data/crunch-2026-09-25/briefs/J29-S1V-FS84-blind-verifier.md` — S1V, its fixed claim list written now.
- `data/crunch-2026-09-25/briefs/J29-S4-FS84-colouring-side.md` — S4.
- **Not written (left):** S2's brief waits on S1d's shape; S3's is declined by default (§S). Both are rows in §S with their budgets.

## Theorems this phase proved

- none — a reframe; the hand factorisation of the ten survivors' denominators (§G.4) and the one-prime confound (§M.1) are observations
  about FS-81's records, graded [tools-grade reading of committed data], not theorems.

## §X — would-have-searched-here log (stages 4–5)

- Would have run FS-81's recheck on the UNKNOWN residue targets to see whether one-prime survivors colour; instead read Λ₁₅₆₀'s committed
  verdict (a quotient colouring) and lowered P-1p.
- Would have priced S2's LP by building one window instance; instead left its size to S1d's derivation (orbit count before any run).

## Proposed edits (for the front-page lane; this job edits none of these files)

- `plans/STUB-five-colours-47.md` and FS-84's row: "the survivors' `Θ₄` cell analysis can only colour a survivor (G71, row 96); a refusal
  needs a finite graph or a four-class averaged certificate; `χ(ℚ(√47)²) = 5` answers Soifer 55.1 and Moorhouse's ℚ(√47) question."
- Six bibliography proposals: §3.1 verdict 4.
- FS-80's stub: add ℚ(√47) as a target beside ℚ(√167) (its fractional cap `121/28 > 4`).
