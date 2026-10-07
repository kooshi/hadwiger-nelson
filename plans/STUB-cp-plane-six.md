# FS-104 — the stationary chromatic number at six: is `χ_CP(ℝ²) ≥ 6`? (stub)

> Answered YES by citation, 2026-10-07: `χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6` (`[OAIMath2026]` Thm 1.4 with row 130). Routes (0)–(e) are closed as routes to that question. Re-aimed (FS132-P1): the stub now carries the null-set step `χ_m⁰(ℝ²) = χ_m(ℝ²)` — with the transfer, the Shelah–Soifer axiom question for the plane — `χ_B` against `χ_m`, and the ZF + DC audit. It bears on Falconer's number and on the axioms, not on `χ(ℝ²)`.

> **Print addresses from the consolidation run (2026-09-27; job FP from the reading jobs LW and LW3, `data/consolidation-2026-09-27/reports/LW3.md`
> §§ 1, 4; the quotations checked on the pages, `data/consolidation-2026-09-27/fp/record.md` stage 1).** **Item (1), the null-set step:** its compactness step is in print,
> `[Johnson1994choice]` p. 125: *"The well-known DeBruijn-Erdös theorem on the chromatic number of an infinite graph holds for the choice
> number. That is, if G is an infinite graph, k is a positive integer, and c(H) ≤ k for every finite subgraph H of G, then c(G) ≤ k."*
> (proved there by Tychonoff), and the same paper asks, p. 124, *"Is the choice number of the planar unit distance graph finite?"* — a
> posed question no row answers, recorded here, not in `CLOSED-QUESTIONS.md` (the owner's ruling, 2026-09-27). If print answers "infinite",
> item (1) cannot close by a general list-colouring theorem and must use where the lists come from (FS103-M-D's hunch). **Check first**
> whether it is answered (LW3 recalls, unread, an average-degree lower bound for choice numbers). **Item (3), the ZF + DC audit:**
> `[Soifer2007]` p. 86 prints, with no proof, *"Chromatic Number of the Plane Theorem. In ZFS the chromatic number of the plane is 5, 6, or
> 7."*; `[ShelahSoifer2003b]` p. 43 asserts *"DC is sufficient for Falconer's result [F]"* and p. 42 names de Bruijn–Erdős's use of
> choice; that link 2 uses choice only there, its averaging needing only ZF + DC, is a reading at one mind (LW3). **The question as posed
> in print:** *"The Ronald L. Graham New $1,000 Problem. Prove or disprove the existence of a 6-chromatic unit-distance graph."*
> (`[Soifer2019]` p. 213) — by de Bruijn–Erdős it is `χ(ℝ²) ≥ 6`, and given MR (rows 128, 130) it is this stub's `χ_m⁰(ℝ²) ≥ 6`.

> **Re-aimed at the reframe (2026-09-26, job RF1; `plans/FRONTIER-STUBS.md`'s re-rank note; `plans/STUB-regularity-wall.md`): rank 1 → 3,
> below the program Kooshi adopted (`CLAUDE.md` § The aim) — FS-106, the regular half (rank 1), and FS-107, regularity against pathology
> (rank 2). Re-aimed, not demoted.** Its **null-set step** — item (1) of the banner below, "colour the metrical boundary", C-FMT (d),
> `χ_m⁰ = χ_m` (`plans/FS103-derivation.md` FS103-M-D) — **folds into FS-107 as one of its sub-questions** (the regularity-wall stub: "the
> null-set step is one sub-question of FS-107"). **Its other items stand here:** (2) `χ_B` against `χ_m`, (3) the ZF + DC audit, (4) the
> prior-art debts; the density family, Falconer's mechanism in CP form, `k`-point correlation constraints, `χ_g(H)` (post-ban) and the mirror
> (routes (0)–(d) below). The text below is the stub as it stood before the reframe: its "Rank 2" line is as minted, and its "Bearing on
> χ ≥ 6" is read, since the reframe, as a bearing on the answer (`CLAUDE.md` § Counter-priors, rule 1).

> **Re-aimed at FS-103's close (2026-09-26; `plans/FS103-collapse-cp-plane.md` §R-close).** `χ_CP(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ)` with no MR (row 130,
> two minds), and given MR it is `χ(ℝ²)` (rows 128, 130). So the question is now: **is the plane's measurable chromatic number, null sets of
> unit pairs ignored, at least six?** In order: (1) **colour the metrical boundary** — `χ_m⁰ = χ_m` iff some a.e.-proper colouring's null set
> `E` (`[Falconer1981]` Lemma 2) is list-colourable from lists of size ≥ 2 (FS103-M-D, one mind), with M's hunch first (two adjacent points of
> `E` cannot have `P(x) = P(y) = {a, b}`; killing test: an a.e.-proper colouring with such a pair); slack colourings need six (`χ^{sl} ≥ 6`), so
> a five would be tight; (2) `χ_B` against `χ_m` (the same step with a Borel choice); (3) the ZF + DC audit of the chain (MR, the load-bearing
> step, M1): with (1) it would make `χ(ℝ²)` absolute and answer Soifer's Open AC Problem 62.14 at `n = 2` (a reading, not claimed); (4) the
> prior-art debts: "a.e.-proper measurable colouring + Rajchman edge measure ⟹ stationary CP colouring" (N), and a gate under
> descriptive-combinatorics names for "finitary = measurable independence ratio" (FS103-F §3.6); then the density family and correlation
> constraints as before. The advisor's A-E5 has its second mind (FS103-N). Bearing on six: decisive, given MR; success very low.

*Minted 2026-09-26 by job R3 from R1's N2 (`plans/RERANK-2026-09-26.md` §2.2) and the advisor's top-three item 2
(`plans/POROS-2026-09-26-rerank.md` stage 1). Rank 2 in `plans/FRONTIER-STUBS.md`. **Solver column:** none for routes (a)–(c) (reading,
derivation, in-ban); (d) is an LP on a finite configuration, post-ban. Written for a session with zero conversation memory.*

**Kooshi's words** (2026-09-26): *"We now have a real foundation to reach for 6 (or prove that no field is 6 colorable, which would be
fascinating) and potentially answer the HN problem definitively."* — and *"If we end up at a wall which collapses HN to another known open
problem, that in itself would be a writeup."*

## The question

`χ_CP(ℝ²)` is the least `k` for which the unit-distance graph of the plane carries a stationary random `k`-colouring, continuous in
probability, proper almost surely on every unit pair (FS100-BC's definition, quoted in full in FS-103). **Is it at least six?**

- **What is held** (row 125, [hand, two blind]): `χ(F²) ≤ χ_CP(ℝ²)` for every countable `F ⊆ ℝ`, so `χ(ℝ²) ≤ χ_CP(ℝ²) ≤ 7`; and given MR,
  six at ℚ(√167) contains `χ_CP(ℝ²) ≥ 6` as a conjunct. **No held result gives `χ_CP(ℝ²) ≥ 6`, and no one-point density bound can**
  (row 125: Croft's `m₁ ≥ 0.2293 > 1/5`, `[Croft1967]`).
- **What it would be, given FS-103's F1 (a candidate, not held):** rung D itself — `χ(ℝ²) ≥ 6` ⟺ `χ_CP(ℝ²) ≥ 6` — and six at every field with
  no non-6-thick stable place. Without F1 it is `χ_CP ≥ 6`, which implies `χ_m(ℝ²) ≥ 6` for Falconer's measurable chromatic number since
  `χ_CP ≤ χ_m` (the advisor), open since 1981 (`5 ≤ χ_m ≤ 7`; `[Falconer1981]`, **not held**).

## Routes, cheapest first (R1's N2; the advisor's stage 1)

- **(0) Read `[Falconer1981]` first, as a CP statement** — the advisor: continuity in probability lets a forced pair's distance vary
  continuously, which may be Falconer's mechanism. Owed before any route is ranked (G50). With it: Soifer's measurability chapter, the
  Polymath16 measurable page, Bachoc–Nebe–Oliveira–Vallentin (arXiv:0801.1059), `[AmbrusEtAl2023]`.
- **(a) The density family.** A CP five-colouring needs `m_j(ℝ²) ≥ j/5` for every `j ≤ 4` (X21D-Y). R1's reading, **unchecked**: disjoint
  translates of Croft's set into its lattice's deep holes give `m₂ > 2/5` and `m₃ > 3/5`, so `j = 2, 3` die as `j = 1` did; `j = 4` unknown
  (`m₄(ℝ²) < 4/5`?). [reading, R1; the advisor: "a check on Croft's parameters, not a derivation"]. The route to six, if any, is integrality
  (G24; X21D's B-3 answer: "a non-density (integrality) argument").
- **(b) Falconer's mechanism in CP form** (the advisor): a forced pair whose distance moves continuously.
- **(c) `k`-point correlation constraints** on stationary colourings — the tetrahedral embedding at five colours, three- and four-point Bessel
  kernels à la Bachoc–Oliveira–Vallentin; FS-80's averaged certificate at the real place (FS-80 re-aimed). An optimisation: post-ban unless its
  shape is derived first (the advisor).
- **(d) The integral geometric chromatic number `χ_g(H)`** of a finite configuration — `χ(ℝ²) ≥ χ_g(H)` by amenability alone, no MR — whose LP
  is a finite witness (post-ban).
- **The mirror** (FS-44 at the real place): what a CP five-colouring of the plane would have to look like.

## Registered expectations (both outcomes reachable)

- R1: `χ_CP(ℝ²) ≥ 6` proved — 0.02; the density family closed at `j = 2, 3` by Croft translates — 0.70; a no-go of another named format — 0.40;
  a CP five-colouring of the plane — below 0.01.
- **The advisor's prior** (its stage 1, verbatim): *"**Six itself:** won, near-term, P ≈ 0.03 (it is `χ_m`-strength, open 45 years); shown
  impossible for fields (S), P ≈ 0.02. The realistic product is the collapse — a reduction of HN to a named open problem — which is the
  write-up Kooshi named."* Its hunch `no-bound-on-chi-cp-this-cycle`: the next milestone on `χ_CP(ℝ²)` proves no bound beyond five in either
  direction (basis: prior); falsifier: `m_j(ℝ²) < j/5` for some `j ∈ {2,3,4}`, or a measurable "+1" mechanism from a finite forced pair.

## Provisional bearings

G24 (the step to seven in the cell family is integrality; a relaxation that sees the gap is open), G60 (the fractional cap 4.36 and the real
place's `J₀` minimum), G64 (six in the gap; skipping is not evidence), G48, G59, G80, G73 (averaged certificates are one of the formats left),
G72 and G79 (pose the structural form; hunt the invariant every CP colouring carries), G21, G49/G50 (Falconer not held). Stubs: FS-103 (whose
F1 makes this rung D), FS-44 (the mirror), FS-80 (route (c)), FS-49 (the finite-graph route to the same rung, post-ban), FS-102. **Added at FS-106's close (owner, 2026-09-27):** G82 — row 131 holds at every `k`, so this stub's question is a stability question at five: `χ_CP(ℝ²) ≥ 6` ⟺ `lim_{ε→0} µ₅(ε) < 1`, and a five-colour refutation is a sequence of periodic grid-square slack colourings with vanishing holes; FS-107's R and W at `k = 5`.

*At FS-129's audit (FS129-Z2, 2026-10-03):* row 66 (the slack residue
plane Γ₁₁ and the single-vertex repaint — one mechanism under G13, G26, G31 and G48), G75 (route (c)'s format), G55 with row 111 (route (b)'s literal
reading), G43, G48, G54, G68, G69, G76 (the fan's hosts), G63 (the place `t ↦ 0`); FS129-SA1-NOAFF-K, -NOAFF-FIELDS, -PLACE-HOM, -FALC-FAN,
-FALC-DICHO-K, -FALC-RES, -FALC-RED, FS129-OA1-NOPERLAW, FS129-MA2-FALC-HOSTS, FS129-OR1-TOP5.

## Bearing on χ ≥ 6

Derived-decisive if FS-103's F1 holds (it is rung D); success per milestone very low; a no-go of a named format, or a reading that ties
`χ_CP` to `χ_m`, is the likely product.

*Would have searched here:* nothing for (0)–(c); (d) is a finite LP and waits for 2026-10-01.

*At FS-111's close:* the regularity route at five — a maximal five-cover with regular classes and a locally finite boundary graph gives `χ_m⁰(ℝ²) ≥ 6` through AE-MAP6 (FS111-M2-REDUCE-C, two minds) — is equivalent to this stub's YES given AE-MAP6 (FS111-VM2-EQ5): a reformulation, carried in FS-121.

*At FS-116's close (2026-10-03, FS116-Z2):* FS116-O1-YESLIM (held, two minds): for every `k`, valid `k`-coloured fragments — segment-and-arc maps on
discs, no two interior points of one colour at distance 1 — on discs of every radius give `χ_m⁰(ℝ²) ≤ k`, with no map in the limit. So this stub's NO side
(a CP five-colouring) can be supplied by valid five-coloured fragments on growing discs, and its YES (`χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6`, row 130) forbids them: some
radius carries no valid five-coloured fragment on any disc.

*At FS-129's audit (FS129-Z2, 2026-10-03; from the readers' records, each FS-129 result derived, one mind, kernel pending, prior art owed unless named).* The arithmetic era bears on this stub's routes — the audit's
one cross-era hit (its decision 4; `plans/FS129-OA1-audit.md` §§ 2.2–2.3, `plans/FS129-MA1-audit.md` § 3, `plans/FS129-MA2-audit.md` § 2,
`plans/FS129-SA1-audit.md` § 2):
- *Route (c)*: G75's annihilator format is empty wherever a residue target is slack — **FS129-SA1-NOAFF-FIELDS**: "let F ⊆ ℝ be a number field, E = F(t₁, …, t_n) ⊂ ℝ with t₁, …, t_n algebraically independent over F (n ≥ 0), and H ⊂ E² a finite unit-distance graph; suppose k = 5 and F has a usable prime of residue field 𝔽₁₁ or 𝔽₁₉ or χ(F²) ≤ 4, or k = 4 and F has a usable prime of residue field 𝔽₇ or χ(F²) ≤ 3; then for every family of functions φ_v : Fin k → ℝ (v a vertex of H) with Σ_v φ_v(C(v)) taking one value on every proper k-colouring C of H, every φ_v is constant" (from FS129-SA1-NOAFF-K, row 66's
  single-vertex repaint at any target). Route (c)'s linear-identity format dies over those fields; the route, and the format over the other fields, stand.
- *Route (0)*: `[Falconer1981]` is held and read, its Lemmas 1–4 checked against the paper (`plans/FS129-MA1-audit.md` § 2.1); its mechanism, as a
  statement: **FS129-SA1-FALC-RED**: "if a finite unit-distance graph H ⊂ ℝ² has a Falconer fan at k colours with apex a and tip t, |t − a| = r > 1/2, and arcsin(1/(2r))/π irrational, then every cover of ℝ² by k measurable sets has two points at distance 1 inside one of the sets, so χ_m(ℝ²) ≥ k + 1 for Falconer's everywhere-proper measurable chromatic number".
- *Route (b)*: its literal reading is empty (`plans/FS129-OA1-audit.md` § 2.3) — **FS129-OA1-NOPERLAW**: "for a stationary random colouring c of ℝ², continuous in probability and proper almost surely on every unit pair, the set Z of vectors x with c(0) = c(x) almost surely is a discrete subgroup of ℝ²; if the law of c is rotation-invariant, Z = {0}". What remains is Falconer's fan, and the fan
  family says where a five-colour fan can live: **FS129-SA1-FALC-RES**: "let F ⊆ ℝ be a number field, E = F(t₁, …, t_n) ⊂ ℝ with t₁, …, t_n algebraically independent over F (n ≥ 0), and H ⊂ E² a finite connected unit-distance graph with apex a and tip t forming a Falconer fan at five colours; then (i) χ(F²) ≥ 4, and F has no usable prime of residue field 𝔽₇; (ii) for every usable prime 𝔭 of F of residue field 𝔽₁₁ or 𝔽₁₉, with V and φ as in FS129-SA1-PLACE-HOM at 𝔭, t − a has coordinates in V and φ(t − a) = 0" (with FS129-SA1-FALC-FAN and FS129-SA1-FALC-DICHO-K: a five-colour fan has
  `χ(H) ≥ 4`, and at `χ(H) = 4` every four-colouring gives apex and tip one colour). Over ℚ(√59), ℚ(√83) and ℚ(√131) a fan forces `t − a ∈ R ∩ 𝔓⁴`
  and periodicity of every four-colouring (FS129-MA2-FALC-HOSTS (iv)), so one Falconer fan at five colours there would settle row 88's question, and a
  non-periodic four-colouring there would rule such fans out (FS-129 item 87).
- *The map step at five*: **FS129-OR1-TOP5**: "if REG-J′₅ holds — FS111-M-REDUCE-I's regularity hypothesis at five colours, a saturated colouring whose singular set Σ is locally finite with finitely many interface arcs at each point of Σ — then the honest existence form of C-SAT-T at five (every tight a.e.-proper five-colouring can be modified, keeping it a.e.-proper with five colours, into an honest saturated one; FS121-SAT6's k = 5 clause) holds if and only if χ_m⁰(ℝ²) ≥ 6, the forward direction at FS106-AE-MAP6's grade (modulo Townsend's simplification (c))" — the honest five-colour route to this stub's YES. Which stub carries it is the re-rank's call (FS-129
  item 26); of its pieces MUA-FIN is FS-120's and REG-J′₅ FS-127's (`plans/FS129-OR1-audit.md` § J10).

## Dated correction notes (FS129-Z2, 2026-10-03)

- **§ The question, "given FS-103's F1 (a candidate, not held)"** (line 53): F1 is held, given MR — `LEDGER.md` row 128, "The collapse: given MR, the
  plane's number is a field's", with `χ(F²) = χ(ℝ²) = χ_CP(ℝ²)` at every totally real field whose stable places are all 6-thick, at [hand + tools exact];
  row 130 adds `χ_CP(ℝ²) = χ_m⁰(ℝ²)` with no MR. So, given MR, this stub's question is rung D (FS-129 item 28; `data/fs129/reports/FS129-Q1.md`).
- **§ The question, "`[Falconer1981]`, **not held**"** (line 55), and **§ Provisional bearings, "G49/G50 (Falconer not held)"** (line 87): held and read
  in full (`BIBLIOGRAPHY.md` `[Falconer1981]` and its copy row); Lemmas 1–4 checked against pp. 185–187 (`plans/FS129-MA1-audit.md` § 2.1). Route (0)'s
  reading is done (FS-129 items 38, 42, 67).
