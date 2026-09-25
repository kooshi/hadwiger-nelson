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
