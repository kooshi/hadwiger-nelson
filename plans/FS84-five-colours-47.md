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
