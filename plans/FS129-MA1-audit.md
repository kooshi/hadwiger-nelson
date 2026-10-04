# FS129-MA1 — pass 2 of the cross-application audit, lane A (the arithmetic era): the record

*Job FS129-MA1, brief `data/fs129/briefs/FS129-MA1-pass2.md`; a `general-purpose` agent on Opus reading Ephodos's identity
(`.claude/skills/ephodos/SKILL.md` in full, then `.claude/agents/ephodos.md` from `# Ephodos in lean-dir — the workflow` to its end). Plan:
`plans/FS129-cross-application-audit.md` § 3 Stage 3. Writes only this file, `data/fs129/ma1/`, `tools/fs129_ma1_*.py` and
`data/fs129/reports/FS129-MA1.md`. Started 2026-10-03 23:42 UTC. A successor, FS129-MA2, continues from the last SAVED stage
(`plans/FS129-close-inventory.md` item 52).*

## Theorems this phase proved

Each `derived`, grade `hand`, one mind, prior art owed; handoff de Bruijn.

- **FS129-MA1-NOAFF5** — for a finite graph mapping into a target slack at five colours (Γ₁₁, Γ₁₉, or any four-colourable target), no affine identity
  on the simplex embedding holds for all its proper five-colourings (FS129-OA1-NOLIN5 widened to vector coefficients and to 19 and L ≤ 4).
  [hand, control FS129-MA1-NOAFF5-DIM] — § 3.1
- **FS129-MA1-FALC-T** — a Falconer fan at five colours, mapped into any graph T: the tip's colour lies in {apex's colour, any apex gap} for every
  gapped five-colouring of T; apex and tip forced equal at four colours in every four-colourable T (so in the plane of any field whose plane is
  four-colourable); T is not three-colourable. [hand] — § 3.1
- **FS129-MA1-FALC-19** — over a field with a prime of residue field 𝔽₁₉, every Falconer fan at five colours has tip ≡ apex at that prime.
  [hand, with the exact orbit fact, control FS129-MA1-FALC-19-W] — § 3.1

## Stage 1 — SAVED (readback, registered expectations)

### 1.1 Readback of the brief's quotations (standing rule 3)

Checked by script (exact substring, 2026-10-03 23:45 UTC):

| quotation | source named | found |
|---|---|---|
| "Right after this close, we'll be refining the workflow again... File that as a special case stub for after the workflow refinements." (full text) | `plans/STUB-cross-application-audit.md` § The request | verbatim |
| "1. yes, we don't want O(N^2) here. 2. Yes, keep to the cap, … so it'll pick up the latest changes." (full text) | `plans/FS129-cross-application-audit.md` § 1 | verbatim |
| "Also a note for the whole plan that not only are "hubs" important, but deep "roots", … even if it has only one offshoot" (full text) | `plans/FS129-cross-application-audit.md` § 1 | verbatim |
| "where else can we use that identity?" | `plans/FS116-close-inventory.md` item 142 | verbatim (Kooshi, 2026-10-03 17:49 UTC) |

No mismatch; no finding about the brief. The brief's inventory references (items 41, 51, 52) say what the brief says they say.

### 1.2 What I had read when I registered

The brief; the identity in full and the lane workflow from its heading to its end; `plans/STANDING-RULES.md`; the plan; the stub (with
Poros's card and bearing); `plans/FS129-close-inventory.md` in full; `data/fs129/demand-judged.md` §§ 1–2 (homonyms, no-gos);
`plans/FS129-OA1-audit.md` in full; `plans/FS129-OR1-audit.md`'s theorem list, its mechanical-half note and its cross-era line. **Not yet read:**
any grokking body, any derivation file, the index's statements files, `[Falconer1981]`.

### 1.3 Registered expectations (before reading the corpus; scored at FS129-Z1)

My prior: lane A's mechanisms are discrete and arithmetic (residue maps, finite planes, compulsions in finite graphs, spectral bounds,
field towers). Pass 1 found that they bear on the regularity era only where a finite configuration is "seen" by a measurable colouring
(Falconer's boundary points; correlations). Inside the arithmetic era, the likeliest unapplied mechanisms are the compulsion toolkit and
the residue/finite-plane reductions applied to a field or a configuration their milestone did not name; the 17 unmentioned grokkings are
the likeliest hiding place, but also the likeliest to be narrow.

| id | expectation | value |
|---|---|---|
| MA1-E1 | mechanisms I reach in this job (of 70) | expected 22; range 12–35 |
| MA1-E2 | of those reached, mechanisms that bear somewhere unapplied (a composition, a miss or a near miss with its failing hypothesis named, beyond pass 1's) | expected 6; P(≥ 3) = 0.6 |
| MA1-E3 | compositions derived (block entries) | expected 4; range 1–8 |
| MA1-E4 | misses of the FS116-Y4 kind (a milestone worked a step the mechanism would have shortened or emptied) | expected 1.5; P(≥ 1) = 0.55 |
| MA1-E5 | `[Falconer1981]` Lemmas 1–4 differ materially from FS103-M's quotation (a difference that changes what FS129-OA1-FALC-RED may use) | P = 0.15 |
| MA1-E6 | a composition of this pass changes the bearing on the answer (item 31's open list or the top three) | P = 0.06 |
| MA1-E7 | a held result found false on reading | P = 0.03 |
| MA1-E8 | cross-era bearings (a lane-A mechanism on a regularity-era site) found beyond pass 1's | expected 1; P(≥ 1) = 0.45 |
| MA1-E9 | of the 17 unmentioned grokkings, the share that bears somewhere unapplied | expected 0.2 |

These are instruments for G21, never caps.

## Stage 2 — SAVED (`[Falconer1981]` Lemmas 1–4 against the paper, before anything builds on FS129-OA1-FALC-RED)

*Read: `~/source/library/papers/falconer-1981-realization-distances-measurable-subsets-covering-Rn-jcta-31-184-189.pdf`, pp. 185–188, as page
images (the text layer is OCR and garbles symbols: it reads `r > ½` as "r > 4"), 2026-10-03 23:55 UTC; against `plans/FS103-M-derivation.md`
§ 1.2 and FS129-OA1-FALC-RED's `uses only:` and argument (`plans/FS129-OA1-audit.md` § 2.3).*

### 2.1 Each lemma as the paper gives it

| item | page | the paper's statement (transcribed from the page image) | FS103-M § 1.2's quotation | difference |
|---|---|---|---|---|
| **Lemma 1** | p. 185 | "Let E be a non-empty subset of Rⁿ with v(E) = 0, where v denotes n-dimensional Lebesgue measure, and let C be a finite or countable configuration of distinct points in Rⁿ. Then there exists a rigid motion p such that p(C) ∩ E is a single point. Further, if x is a given point of C, we may choose p such that for almost all (in the sense of the usual rotational measure) rotations ρ of p(C) about p(x) we have that ρ(p(C)) ∩ E = {p(x)}." Proof: "An obvious modification to the proof of Lemma 3 in Croft [1] suffices." | a parenthetical paraphrase: "a rigid motion `ρ` of a countable configuration `C` meets a given null set `E` in exactly one point, "for almost all … rotations"" | **one that matters for the argument, not the statement** (§ 2.2): the lemma supplies the motion, so the point of `E` at which `x` lands is the lemma's, not the user's. Nothing in it lets one fix a point `e ∈ E` first and rotate about `e` (that form can fail: a null `E` may contain a circle about `e` of radius `|v − x|`) |
| **Lemma 2** | p. 185 (proof continues on p. 186) | "Let S be a measurable subset of Rⁿ with v(S) > 0 and v(Rⁿ\S) > 0 then (i) ∂S is non-empty and v(∂S) = 0, (ii) S̃ is a Borel set." Definitions (p. 185): metrical boundary, "those points of Rⁿ at which the Lebesgue density of S either fails to exist, or exists and has a value other than 0 or 1"; essential part, "those points of Rⁿ where the Lebesgue density of S exists and equals 1" | verbatim | none. FS129-OA1-FALC-RED's gloss "Lemma 2 (E non-empty and null; at a point of E at least two classes are present — FS103-M's D2)" attributes to Lemma 2 two facts it does not state: `E` non-empty follows from (i) applied to a class of positive measure and positive co-measure (if none exists one class is co-null and holds unit pairs); "two classes at a point of `E`" is the proof of Theorem 2's "(at least)" step (p. 188) and FS103-M's D2 (`plans/FS103-M-derivation.md` l. 252), a derivation: with finitely many disjoint covering classes, if `x` lay in only one metrical boundary, the other densities would exist and be 0, so that class's would be 1 and `x ∈ S̃` — not in `E` |
| **the null set** | p. 186 | "Now let S₁,…, S_k be disjoint measurable subsets of Rⁿ with union equal to Rⁿ. If E = Rⁿ\⋃ᵏⱼ₌₁ S̃ⱼ then E is the aggregate of the metrical boundaries of the Sⱼ." | verbatim | none. Lemma 3 is stated under this hypothesis — **disjoint** classes; Theorem 2's "covered by" sets are made disjoint first (standard, and harmless: a subset of a unit-free set is unit-free) |
| **Lemma 3** | p. 186 | "Suppose that x₁,…, x_M are points in Rⁿ such that x₁ ∈ E, say x₁ ∈ ∂S₁ ∩ ⋯ ∩ ∂S_r, and xᵢ ∈ S̃_{k(i)} for 2 ≤ i ≤ M. Then for every j (1 ≤ j ≤ r) there exists a small translation p such that p(x₁) ∈ Sⱼ, and p(xᵢ) ∈ S_{k(i)} if 2 ≤ i ≤ k." Proof: "See Croft [1], proof of Theorem 8." | verbatim, including the paper's misprint "2 ≤ i ≤ k" for "2 ≤ i ≤ M" | none. The conclusion lands in `Sⱼ` and `S_{k(i)}`, not in the essential parts; `j` ranges only over the classes whose metrical boundary holds `x₁`; one translation per `j`, existence only (FS103-M's table already records this against the 2005 exposition) |
| **Lemma 4** | p. 187 | "Let T be a circle of radius r > ½ in R², and let θ = 2 sin⁻¹(1/2r) be an irrational multiple of π. Suppose that R² is divided into sets Sⱼ in such a way that almost all points of T (in the sense of circular measure) belong to either S̃₁ or S̃₂, say. Then there exists some pair of points in R² at unit distance apart either both in S₁ or both in S₂." | a parenthetical paraphrase, accurate in every hypothesis | none in content. "Divided into sets" is read with the measurable partition of p. 186: the proof uses Lemma 2(ii) (Borel `S̃`) and Lemma 3. FALC-RED's "arcsin(1/(2r))/π irrational" is equivalent to "θ an irrational multiple of π" (θ/π = 2 arcsin(1/(2r))/π) |
| Theorems 1, 2 | pp. 186, 188 | as FS103-M quotes | verbatim | none |

### 2.2 What this does to FS129-OA1-FALC-RED

**The statement stands; its argument needs one reordering, which the paper's own proof of Theorem 2 already makes.** FALC-RED's argument
reads: "By Lemma 2 pick `x₁ ∈ E`, with two classes, say 1 and 2, present at `x₁`. Place `H` with `a` at `x₁`; by Lemma 1, for almost every
rotation `R` about `x₁` every other vertex `v` lies at a density point of some class `k(v)`." That uses Lemma 1 at a point of `E` chosen in
advance, which Lemma 1 does not supply. The repair, in the order of p. 188 ("Lemma 1 allows us to assume that the configuration … is
positioned so that x₁ ∈ E … Assume (without loss of generality) that x₁ lies in the metrical boundaries of (at least) the sets S₁ and S₂"):
apply Lemma 1 to `C = V(H)` with `x = a`, obtaining a rigid motion `p` with `p(a) ∈ E` and, for almost every rotation `ρ` about `p(a)`,
`ρ(p(H)) ∩ E = {p(a)}`; then `p(a)` lies in at least two metrical boundaries by the derivation in § 2.1's Lemma 2 row (D2), say `∂S₁ ∩ ∂S₂`;
the rest of FALC-RED's argument runs unchanged with `x₁ = p(a)` and vertices `ρ(p(v))`. Every other use matches the paper: Lemma 3 with
`x₁ ∈ ∂S₁ ∩ ∂S₂` and `j ∈ {1, 2}`, its conclusion in `S_{k(i)}` (enough: no `Sⱼ` holds a unit pair, so `k` is proper on `H − a` and `N(a)`
avoids 1 and 2); Lemma 4 with the hypothesis on `S̃₁ ∪ S̃₂` exactly as FALC-RED's last step produces it.

**Finding (for FS129-Z1 and for FS129-OA1-FALC-RED's `uses only:` line; a correction of wording, no grade moves):** FALC-RED's `uses only:`
should read Lemma 1 as "a rigid motion `p` of a countable configuration with `p(x) ∈ E` and almost every rotation about `p(x)` meeting `E`
only at `p(x)`", Lemma 2(i) for `E ≠ ∅`, and FS103-M-D's D2 for the two classes at `p(x)` — not "Lemma 2 … at a point of `E` at least two
classes are present". FS103-M's quotations of Lemmas 2 and 3, of the null-set sentence and of Theorems 1–2 are verbatim; its Lemma 1
paraphrase is the one place a reader could take the stronger, unstated form. **MA1-E5 (registered P = 0.15 for a material difference): not
met** — no difference changes what FALC-RED may conclude; one changes the order of its argument.

### 2.3 Relay received (from the coordinator, lane R's pass 1, 2026-10-03)

Lane R reports FS129-OA1-RINGWIND as FS110-Y3-GP's and FS110-N2-RING's mechanism in a per-hexagon normalisation (a merge for pass 3), the
winding jump at `(u, p, v)` on `ω(y)` not computed, and FS129-OR1-BEND3 making the three-colour semi-hub's ring free of arcs of `Γ`, so that
FS-110's ring results apply to it. Folded into this record's G71 section (whether the mechanism bears anywhere else unapplied).

## Stage 3 — SAVED (pass 1's leads: the slack residue planes and the repaint; the Falconer fan; Hoffman tightness; the ring winding)

*Read for this stage: G13, G26, G31, G54, G66, G71, G75 (bodies, by number); `LEDGER.md` rows 1, 66; `Proofs/HadwigerNelson/Instances/FanGap19.lean`
and `LocalGlobal19.lean` (the plane at 19), `TwoAdicFive.lean`'s header; `plans/ASTRA-2026-09-14-derivation.md` T7–T10; `plans/FS103-M-derivation.md`
§ 1.2 and its D2 (l. 252); `plans/FS106-derivation.md` FS106-BIKE; `plans/FS121-derivation.md` FS121-D3-SWAP1D; the index's era statements grepped by
content (forc-, fan, compulsion, virtual edge, separated, three-colour, at five colours, slack) in both eras.*

### 3.1 Row 66, G13 and G66 — the slack residue plane and the single-vertex repaint

**What it is.** A colour absent from a vertex's closed neighbourhood in some proper colouring of a target graph (a fan gap) may be given to any
vertex above it, alone, along a graph homomorphism; so every vertex of every graph mapping into a target that is slack at `k` lies in two proper
`k`-colourings that differ only there (row 66, kernel: `not_forces_of_fanGap`, `Slack.of_hom`, `slack_addCayley_of_fanGap`; held instances
`finitePlane11_slack`, `finitePlane19_slack`). G13 is its coverage face (`exists_fanGap_iff_not_coverAtLeast`); G66 its tower (slackness rises with the
level).

**Kind of input it delivers** (the card's list): *a modification lemma* — two colourings differing at one chosen vertex — on every finite configuration
over a field with a slack residue plane; so it kills any universal ("every proper `k`-colouring") statement that one vertex's repaint breaks.

**Where it is used** (by id; the index's G13 and G66 mention lists plus the ledger): row 66's own consumers (`Slack.forces_iff`, Heule-510's arity
floor, `UDCert.forces_eq_11`), G26 and G31 (the six-gadget and arity-2 nulls over sealed fields), M60-T2 and M61-T5 (its predecessors), FS73-T17 (the fan
gap at 23 over ℚ(√167): `F = 0`), ASTRA-2026-09-14-T10's prose, and pass 1's FS129-OA1-NOLIN5 and FS129-OA1-FALC-11.

**Where it bears and was not applied.**

1. **A composition — the linear-identity kill at its class (FS129-OA1-NOLIN5 widened in two directions).** NOLIN5 kills identities with *scalar*
   coefficients over fields with a residue-𝔽₁₁ prime. Its argument uses only a homomorphism into a target slack at five, and the colour symmetry
   then kills *vector* coefficients too — every affine identity on the simplex (or indicator) embedding. The held targets slack at five are `Γ₁₁` and
   `Γ₁₉` (both kernel) and every target of chromatic number at most four (the fifth colour is absent everywhere); NOLIN5 was applied at 11 only.

derivation: FS129-MA1-NOAFF5
  statement: let H be a finite graph with a graph homomorphism ρ into a graph T in which every vertex has a colour absent from its closed
    neighbourhood in some proper five-colouring of T; for a proper five-colouring C of H let f_C(v) be the vertex of a fixed regular 4-simplex in ℝ⁴
    labelled C(v); if vectors a_v ∈ ℝ⁴ and a real b satisfy Σ_v ⟨a_v, f_C(v)⟩ = b for every proper five-colouring C of H, then every a_v is 0 and b = 0
  uses only: the slackness of T at five; that C∘ρ is a proper five-colouring of H when C is one of T; row 66's single-vertex repaint (a colour absent
    from N_T[ρ(u)] may be given to u alone); that a permutation of the five colours carries proper colourings to proper colourings; that the edge
    vectors f(i) − f(j) of a regular 4-simplex span ℝ⁴
  not claimed: inequalities (three- and four-point positivity, FS-104 route (c)'s format (ii)); identities of degree two or more in f; anything over a
    field with no slack residue target — over a number field F a finite connected unit-distance graph maps into Γ_q at a usable prime of residue
    field 𝔽_q (FS129-OA1-NOLIN5's residue map), so the statement covers F with such a prime at q = 11 or q = 19 (kernel `finitePlane11_slack`,
    `finitePlane19_slack`) or with a residue target of chromatic number at most four, and says nothing over a 6-open field
  argument: § 3.1 Row 66, G13 and G66 — the slack residue plane and the single-vertex repaint
  verdict: derived
  grade: hand
  minds: 1
  model: H = the two unit rhombi a, b, c, t and a, b′, c′, t′ of the Moser spindle without its tip edge, over ℚ(√3), with ρ into Γ₁₁ (11 splits in
    ℚ(√3)); its 6,480 proper five-colourings span an affine space of the full dimension 7 · 4 = 28, and at three colours, where the tips are forced
    and no slack target receives H, the dimension is 6 of 14 (control FS129-MA1-NOAFF5-DIM)
  prior art: owed — partly FS129-OA1-NOLIN5 (scalar coefficients, residue-𝔽₁₁ primes) and row 66's `Slack.forces_iff` (the forced-pair case); the
    affine-hull form not searched
  handoff: de Bruijn — beside `Slack.forces_iff_of_hom`: for each vertex u and each colour permutation π, the pulled-back colouring π∘C∘ρ and its
    repaint at u give ⟨a_u, f(π γ) − f(π C(ρ u))⟩ = 0

control: FS129-MA1-NOAFF5-DIM
  of: FS129-MA1-NOAFF5 — the model: the five-colourings of the two-rhombus graph have full affine dimension
  run: python3 ../tools/fs129_ma1_noaff.py | tail -1
  expect: k=5: dim 28 of 28
  fault: python3 ../tools/fs129_ma1_noaff.py --fault | tail -1

*Argument.* Fix a vertex `u` of `H`. Slackness gives a proper five-colouring `C` of `T` and a colour `γ` absent from `N_T[ρ(u)]`; let `β = C(ρ(u))`, so
`β ≠ γ`. For a permutation `π` of the colours, `π∘C` is proper with `π(γ)` absent from `N_T[ρ(u)]`, so `π∘C∘ρ` is a proper five-colouring of `H` (`ρ`
is a homomorphism) and so is its repaint at `u` with `π(γ)` (every neighbour of `u` maps into `N_T(ρ(u))`, which misses `π(γ)`). The identity holds
for both; they differ only at `u`, so `⟨a_u, f(π(γ)) − f(π(β))⟩ = 0`. As `π` ranges over the permutations, `(π(β), π(γ))` ranges over every ordered
pair of distinct colours, so `a_u` is orthogonal to every edge vector of the simplex, which span `ℝ⁴`: `a_u = 0`. Every `u` is such a vertex, so
every `a_v = 0`, and `b = 0` by evaluating at `C∘ρ`. ∎ The case "scalar `c_v`, one identity per coordinate" is FS129-OA1-NOLIN5; the case `a = e_u − e_{u′}`
tested against one coordinate is row 66's `Forces ↔ =`. **What it does to FS-104 route (c), format (i):** an annihilator certificate (G75's format,
in any linear form) for `χ_CP(ℝ²) ≥ 6` must be built on a configuration over a field with no usable prime of residue field 𝔽₁₁ or 𝔽₁₉ and with
`L(F) ≥ 5` — a 6-open field or one sealed at five only by another target. **A link for pass 3:** FS86-Cx-C11 ("on type-(B) planes such an identity
valid for every colouring exists iff `F(R) ≠ 0`", G75's note) is the four-colour face of the same statement — an identity exists exactly where a forced
pair does, and row 66 says none does at five over these fields.

2. **A composition — the Falconer-fan kill at its class (FS129-OA1-FALC-11's argument, stated for any target).** FALC-11's argument uses only a
   homomorphism into a graph carrying a gapped proper five-colouring. Stated so, it applies at every target the record holds a gapped colouring
   of — at 19 (kernel table), and at every four-colourable target, where it turns into a four-colour forced pair.

derivation: FS129-MA1-FALC-T
  statement: let H be a finite graph with an apex a and a tip t, t not adjacent to a, forming a Falconer fan at five colours (every proper five-colouring
    of H − a in which N(a) avoids two colours c₁, c₂ gives t one of c₁, c₂), and let ρ : H → T be a graph homomorphism; then (1) for every proper
    five-colouring C of T and every colour γ absent from N_T[ρ(a)], C(ρ(t)) ∈ {C(ρ(a)), γ} and every colour absent from N_T[ρ(t)] lies in {C(ρ(a)), γ};
    (2) if T has a proper four-colouring, every proper four-colouring of T gives ρ(a) and ρ(t) one colour; (3) T has no proper three-colouring
  uses only: that C∘ρ restricted to H − a is a proper five-colouring of H − a in which N(a) avoids C(ρ(a)) (properness of C at ρ(a)) and γ (absent
    from N_T[ρ(a)]); row 66's single-vertex repaint at t (t is not adjacent to a, and its neighbours map into N_T(ρ(t))); for (2) and (3), a colouring
    with fewer than five colours read as a five-colouring with its unused colours absent everywhere
  not claimed: that any Falconer fan at five colours exists; the converse (a pair that every target identifies need not be a fan); anything about
    k ≠ 5 beyond the same argument's reach (at k colours, (3) reads "no proper (k − 2)-colouring")
  argument: § 3.1 Row 66, G13 and G66 — the slack residue plane and the single-vertex repaint
  verdict: derived
  grade: hand
  minds: 1
  model: H = the unit rhombus a, b, c, t is a Falconer fan at four colours (b, c take the two colours other than c₁, c₂, so t takes one of them); at
    four colours clause (2)'s analogue reads "a proper two-colouring of T identifies ρ(a), ρ(t)" — and the rhombus has no homomorphism into any
    two-colourable T (it holds triangles), consistent; at five colours H itself is no fan, as FS129-OA1-FALC-11's model shows directly
  prior art: owed — it is FS129-OA1-FALC-11's argument with Γ₁₁ replaced by an arbitrary target; row 66's arity-1 statement (`not_fan_of_fanGap`) moved
    to the doubled apex; not searched
  handoff: de Bruijn — a lemma beside `not_fan_of_fanGap`, for `Fan H′ 5 t [a₁, a₂]` with H′ the doubled-apex graph

*Argument.* (1) Given `C` and `γ`, colour `H − a` by `C∘ρ`. It is proper; `N(a)` maps into `N_T(ρ(a))`, which misses `C(ρ(a))` (properness) and `γ`
(the gap), so the colouring is admissible for the fan with `{c₁, c₂} = {C(ρ(a)), γ}`, and the fan gives `C(ρ(t)) ∈ {C(ρ(a)), γ}`. If a colour
`γ′ ∉ {C(ρ(a)), γ}` were absent from `N_T[ρ(t)]`, repaint `t` alone with `γ′`: still proper (`t ∉ N(a)`, and `t`'s neighbours map into `N_T(ρ(t))`), still
admissible, and `t`'s colour is outside the pair — against the fan. (2) Read a proper four-colouring `C` of `T` as a five-colouring whose fifth colour
`γ` is absent everywhere; (1) gives `C(ρ(t)) ∈ {C(ρ(a)), γ}`, and `C(ρ(t)) ≠ γ`. (3) A three-colouring read as a five-colouring leaves two colours
absent everywhere: take `γ` one of them; the other is absent from `N_T[ρ(t)]` and lies outside `{C(ρ(a)), γ}`, against (1). ∎

*Consequences, each read off one clause (not separate claims):* by (3) and `T = K_{χ(H)}` with `ρ` a colouring of `H`, a Falconer fan at five colours has
`χ(H) ≥ 4`, so over a field with `L(F) ≤ 3` there is none; by (2) with `T = F²` itself (`ρ` the inclusion), over a field whose plane is four-colourable —
K by Theorem B (row 57) — **the apex and tip of every Falconer fan at five colours are a forced pair at four colours of the field's plane**; by (1)
at `Γ₁₁` and `Γ₁₉`, the finite facts of FS129-OA1-FALC-11-W and the control below.

derivation: FS129-MA1-FALC-19
  statement: let F ⊆ ℝ be a number field with a prime 𝔭 of residue field 𝔽₁₉; in every finite connected unit-distance graph H ⊂ F², every Falconer
    fan at five colours with apex a and tip t has t ≡ a (mod 𝔭)
  uses only: FS129-MA1-FALC-T clause (1) with T = Γ₁₉ and ρ the residue map (unit vectors of F are 𝔭-integral because −1 is a non-square in 𝔽₁₉; H
    translated to put a vertex at 0); the kernel's proper five-colouring `finitePlane19QuotColouring` (`Instances/FanGap19.lean`); its orbit under
    Γ₁₉'s 40-element point group and 361 translations, and the exact finite fact read off that orbit: for every w ≠ 0 in 𝔽₁₉² some orbit colouring C
    with a gap γ at 0 has C(w) ∉ {C(0), γ} or a gap at w outside {C(0), γ} (control FS129-MA1-FALC-19-W)
  not claimed: the case t ≡ a (mod 𝔭) — the held colouring's gaps are single (the classes y − x ∈ {4, 10}, gap colour 1), so the orbit cannot reach it;
    fields holding √3 — 3 is a non-residue mod 19, so no field with a unit triangle has such a prime (`FanGap19.lean`'s docstring); that any Falconer
    fan at five colours exists; the almost-everywhere form
  argument: § 3.1 Row 66, G13 and G66 — the slack residue plane and the single-vertex repaint
  verdict: derived
  grade: hand
  minds: 1
  model: F = ℚ(√5, √11)-type fields with 19 of residue degree one (19 splits in ℚ(√5): 5 ≡ 9² mod 19); a unit rhombus does not live there (no √3), and
    the statement's content is the orbit fact, which the control exhibits
  prior art: owed — FS129-OA1-FALC-11 at 11; not searched
  handoff: de Bruijn — the orbit fact is a `decide` over 40 × 361 colourings of a 361-vertex graph beside `Instances/FanGap19.lean`

control: FS129-MA1-FALC-19-W
  of: FS129-MA1-FALC-19 — the finite fact: the exceptional set of residue differences at 19 is {0}
  run: python3 ../tools/fs129_ma1_falcfan.py 19 | tail -1
  expect: W = [(0, 0)]
  fault: python3 ../tools/fs129_ma1_falcfan.py 19 --fault-gap | tail -1

control: FS129-MA1-FALC-11-REPLAY
  of: FS129-MA1-FALC-19 — the same code path on 11's two held tables reproduces FS129-OA1-FALC-11-W's set, so the 19 run reads what the 11 run read
  run: python3 ../tools/fs129_ma1_falcfan.py 11 | tail -1
  expect: W = [(0, 0)]
  fault: python3 ../tools/fs129_ma1_falcfan.py 11 --fault-gap | tail -1

The tool refuses an improper table (`python3 tools/fs129_ma1_falcfan.py 19 --fault-table` prints "REFUSED" and exits 2; watched, 2026-10-03).

**What 1 and 2 do to FS-104 route (b) (J13), beyond pass 1.** A Falconer fan at five colours — the finite object FS129-OA1-FALC-RED turns into
`χ_m(ℝ²) ≥ 6` — must now lie in a graph with `χ(H) ≥ 4`, with its apex and tip congruent at every prime of residue field 𝔽₁₁ or 𝔽₁₉ of its field,
and forced equal at four colours in the plane of any field whose plane is four-colourable. A Searcher's request aimed at Falconer fans (inventory item
40's row 3, held for Kooshi) should carry these three filters.

3. **Near misses (the hypothesis that fails, named).**
   - *ASTRA-2026-09-14-T10* (one five-colour virtual edge at distance 2 transported onto Exoo–Ismailescu's host gives six): its hypothesis is empty over
     every field ⊇ K with a residue-𝔽₁₁ prime by row 66's `Separated ↔ Adj`. Its *Rests on it* already says so in prose ("row 66 explains why, over a
     5-sealed field"); its sentence names "any real `F ⊇ K`" with no such clause — a wording item for pass 3 (the entry carries less than its prose
     knows), not a miss.
   - *G26 / row 55 at 19*: the forced-pair half of row 66 holds at 19 (kernel), but the virtual-edge half does not transfer — the held colouring fails
     `CoincidesAtNonedges` at the shifts 7 and 12 (`FanGap19.lean`'s docstring) — so G26's "over any field where 11 is usable neither five-colour
     gadget exists" cannot be widened to 19 from what is held. Failing hypothesis: a shared-gap table at 19.
   - *G13's two-circle theorem (row 1) against FS106-BIKE's GAP* ("whether three suffice by finitely many arcs is open", the bicycle `T₁(u) ∪ T₁(v)`,
     `1 < |u − v| < 2`): row 1 three-colours the full unit-distance graph on two **concentric** circles (radii 1 and `1/√3`) through its seam's strip
     labels (row 2); the bicycle's circles have distinct centres and its cross relation is a non-Grashof four-bar linkage's coupler curve, not a rotation
     orbit, and row 1 asks no arcs. Failing hypotheses: a common centre, and regularity. The route C-T-BIKE served (FS-107's R-S) is closed (row 133), so
     this is recorded, not derived.
4. **Searched, null.** The 75 era-A and 17 era-R statements with a compulsion word, filtered by five colours, eleven, sealed or slack (the list is
   in this stage's command history; the hits are M53-T11, M60-T2, M61-T5, ASTRA-T7–T10, FS70-T11, FS73-T17, FS86-CL3, FS85-dB3/dB4, M54-T1, M55-T1/T4,
   M56–M57's additive five-colour statements, R52-T3, R59-T1/T2). Every five-colour compulsion statement over a field with a residue-𝔽₁₁ prime
   either is row 66's predecessor (M53-T11 at five over K is trivial, K² being four-colourable; M60-T2, M61-T5 subsumed — merges for pass 3) or
   concerns four colours, where Γ₁₁ is no target. FS70-T11 (four colours over ℚ(√3, √5)) computed `¬ Forces` and `¬ Separated` at four colours by
   periodic colourings; the repaint would need a four-colourable slack residue target, and ℚ(√3, √5)'s primes above 7 have residue field 𝔽₄₉ (3 and 5
   are both non-residues mod 7), so none is usable: not a miss.

### 3.2 The Falconer fan (FS129-OA1-FALC-RED) — where else does a "+1 at a boundary point" bear?

**What it is.** A finite configuration with a doubled apex at a point of the metrical boundary, made admissible by Falconer's two translations
(stage 2: Lemma 1 positions it, D2 supplies two classes, Lemma 3 moves the apex into each), whose tip is then confined to the two boundary
classes on a whole circle; Lemma 4 finishes.

**Kind of input:** a compulsion at a boundary point (points and distances plus a finite colouring property), turned into a measure statement on
one circle.

**Where it is used:** FS129-OA1-FALC-RED (J13); `[Falconer1981]` Theorem 2 (the rhombus).

**Where it bears and was not applied.** (a) FS103-M-D's D3 (the null-set step as list-colouring of `E` from lists of size at least two) is the
same boundary point seen from the colouring side; OA1 recorded the link (its § 4.1 item 2) and nothing further composes: a Falconer fan is a *universal*
statement about `H`'s colourings, D3's obstruction an *existential* one about one colouring's lists. (b) The regularity era's map theorems (rows 132,
134) already exceed what a Falconer fan gives (seven for nice maps, six for maps), and its tight-six-map steps work at six colours with no measure
step left to add. (c) The only sites where a "+1 from a finite object" is the missing step are FS-104's routes, where pass 1 placed it. **Null beyond
3.1's filters**, with what was read: the index's era-R statements grepped for boundary, metrical, density point, Lebesgue, translation (31 hits,
all FS-103 to FS-107 and FS-111 entries already citing Falconer or Lebesgue density for a different step).

### 3.3 G54 — Hoffman tightness (tight forces gap-freedom; slack only permits gaps)

**What it is.** At a vertex-transitive target, `λ_min = −d/(k − 1)` makes every `k`-colouring balanced, gap-free and periodic under the minimising
characters' common kernel; `λ_min < −d/(k − 1)` permits gaps and supplies none (G54; kernel one way, FS38-D2-A/B the other).

**Kind of input:** a spectral certificate that delivers a *universal* statement (every colouring gap-free, i.e. a fall colouring); or refuses `k`
colours outright by the ratio bound.

**Where it is used:** the index's 23 mentions (FS100-DLP, FS103-CTL, FS38-D3, FS53-T1, FS54-T6/T7/T11, FS58-T2, FS67-DA4/DC2/DC3/T, FS70-T7,
FS73-T25, FS81-T25, FS85-L16/dB6, FS86-B2-T1/T2, FS86-Cx-C12p1, FS91-J10-L8, MASCOT-T6, R88-TC).

**Where it bears and was not applied.** Its one output a regularity-era step asks for is universal gap-freedom, which TOP₆ needs (OA1 § 2.1 item 2,
computed: the plane's operator is slack at every `k`, `λ_min/d = J₀(3.8317…) = −0.402759…`). Two other regularity-era places carry fall-colouring
questions: FS121-D3-SWAP1D (a circle `ℝ/(5/2)ℤ` with `y ~ y ± 1`, fibred by five-cycles) and FS-121's idomatic partitions (FS121-SAT6). Read against
G54: `C₅` has `λ_min = 2 cos(4π/5) = −1.618…`, tight at no `k` (`2/1.618… − 1 = 0.236…` is no integer), and the unit circle's 60° relation is a union of
hexagons, tight only at two colours. So no tight model exists at those sites, and FS121-D3-SWAP1D's exact computation is the right instrument there.
**Null**, with the reason: every regularity-era graph the record poses (the plane, a ring, the five-cycle circle) is slack at every colour count the
question uses.

### 3.4 G71 and FS129-OA1-RINGWIND — three colours have a height (with lane R's relay)

**What it is.** A proper three-colouring of a Cayley graph of a torsion-free abelian group lifts to an integer height with a winding and a slope
(Chandgotia's height functions; row 79); FS129-OA1-RINGWIND is its form on a ring of 60° hexagons (the winding jumps only at two change points 60°
apart, jumps summing to zero over a period).

**Kind of input:** an invariant of a three-colouring of a circle or a lattice.

**Where it is used:** FS79-T17, FS106-IND (the index's G71 mentions); row 132's index of density traces (G71's last paragraph); FS110-N2-RING and
FS110-Y3-GP (lane R's ring winding, the same mechanism per lane R's relay, stage 2.3); FS129-OA1-RINGWIND (J2).

**Where it bears and was not applied.** Every three-coloured ring is a site. Lane R's FS129-OR1-BEND3 makes the ring of every three-colour vertex
of a whole-tile fragment below `√3` free of arcs of `Γ` (non-Siamese simple class), which is FS110-N2-RING's hypothesis — so FS-110's ring winding,
and RINGWIND's sum rule, now apply at every three-colour vertex of such a fragment, not only at the semi-hub `y` of SEMI-PAR3. Lane R holds both
the mechanism (FS-110) and the site; the merge of RINGWIND with FS110-Y3-GP/-N2-RING is pass 3's, and the jump at `(u, p, v)` is MR1's and FS-124's lead
(the relay). In lane A, the three-colour sites after row 79 (FS75-W, FS79-T13–T46, FS81-T5, FS85-A3, FS86-A4, FS89-S0B-T2, FS91-J02-T1/T3/C2) all
decide three colours by `Θ₃` or by a residue target already: applied. In lane R, FS106-BIKE asks a three-colouring of two hexagon rings coupled by
cross edges "by finitely many arcs" — the winding is the natural invariant (each ring's `W` jumps only where its change points pair at 60°; cross
edges couple the two), and it was not tried there; not derived, because the route it served is closed (§ 3.1 item 3). **Bears unapplied: one site
(FS106-BIKE), on a closed route; otherwise lane R's, and relayed.**

## Stage 4 — SAVED (two hubs read for cross-era bearing; the seventeen grokkings no entry mentions)

*Read for this stage: G55, G56, G81 (bodies); the seventeen bodies below; `LEDGER.md` rows 34, 35; the era-R statements grepped for polygonal,
cell-constant, triangular lattice, brick, finer than.*

### 4.1 G55 — the unit-vector ring and the chain theorem

**What it is.** A finite graph over `F` forcing a pair at difference `δ` equal at `k` colours makes every `k`-colouring of `F²` periodic under the ideal
`δ ℤ[U_F]`; a forced group invariant under the unit vectors is an ideal (row 111: so `0` or everything). **Kind:** an ideal-closure argument on
forced differences. **Used:** the index's 13 mentions (ASTRA-T7, FS38-L3, FS54-T2, FS58-T3, FS73-T10, FS79-T2, FS79-T40, FS86-B1-LR, FS86-V2, FS91-J02-A21p,
FS91-J02-T3, FS91-J07-4, M53-T14).

**Where it bears and was not applied — a miss of the listed kind (no rounds spent), already derived.** FS-104's route (b), "a forced pair whose
distance moves continuously" (`plans/STUB-cp-plane-six.md` l. 66), was carried as an open route from FS-103's close while row 111's ideal argument
was held; its real-place form, FS129-OA1-NOPERLAW (pass 1), empties the route's literal reading in four lines (a stationary CP colouring's pairs forced
in law form a closed subgroup missing the unit circle, hence discrete, hence `{0}` under rotations). Nothing more to derive. **One composition checked
and declined:** FS129-MA1-FALC-T clause (2) with G55's chain theorem over K says a Falconer fan's `t − a` would have to be a non-unit at a stable prime
(else `1/(t − a) ∈ ℤ[U_K]` and `χ(K²) > 4`); FS129-OA1-FALC-11 (`t ≡ a` at both primes of residue field 𝔽₁₁) and the residue colouring's law (row 59:
equal colours iff positive valuation at the dyadic prime) already give more, so it adds nothing.

### 4.2 G56 — the window for six (and G81, lane R's, read for the meeting point)

**What it is.** Over the residue fields a number field can have, a six-chromatic plane can live only at `q ∈ {23, 27, 31, 43, 47}` or `U₆₄`; every field
containing K is excluded from the window by reciprocity. **Kind:** a finite list of finite targets and a field-listing rule. **Used:** the index's 20
mentions (FS100-CLS, -G27, -X28D-CP3, FS53-T1/T2/T4, FS54-T2/T8, FS66-T6, FS86-CL2, -VD-7, -VD-10, FS91-J02-T2/T3, -J07-11, -J08-2, TC1-DEGREE-BELOW-12,
-SQRT3-DYADIC, -STANDING-FIVE, -STANDING-FOUR).

**Cross-era: null, with the reason.** The regularity era reaches the arithmetic only through the collapse field ℚ(√635087), where every stable place is
6-thick (G81: `λ*_v < 1/5`), and 6-thickness forbids a six-colourable target by the ratio bound (`α/n ≤ λ*/(1 + λ*) < 1/6`), so no window member
could bound that field from above even if decided. Within lane A it is applied wherever a field is listed (the Do is followed in every listing read).

### 4.3 The seventeen lane-A grokkings no entry mentions by number

| G | mechanism (one line) | kind | verdict, with what was read |
|---|---|---|---|
| G5 | de Grey's graph is a 1-sum; a compulsion of the whole is a half's or the cross edge's | a decomposition of a finite witness | **null** — no open step in either era reads a 1-sum; finite witnesses for six are out (`CLAUDE.md` § Publication) |
| G6 | containment of a certified object is not causation | a witness-design method | **null** — same reason |
| G8 | the direction group closing the 1581's edge directions | a group-word factorisation | **null for the answer**; its own open item (Heule-510/553's six out-of-group direction classes as words in `α = (√5 + i√11)/4`) is an exact factorisation, unrun — housekeeping, not a search |
| G10 | the 1581's forcing is distributed | a measured null | **null** |
| G11 | the Moser spindle is not necessary for five (Voronov et al., Haugland) | a construction route: land a forced pair, then spindle | **null** — the route needs a forced pair at five colours; over 5-sealed fields there is none (row 66), and the one 6-open arena holds none (G31); FS129-MA1-FALC-T asks less than a forced pair, which is where any new construction would aim |
| G15 | every known five-forcing argument is a class-level pigeonhole composed with a kill web | the shape of a χ ≥ k argument | **applied under another name**: route M's NO is exactly this shape — every tight six-map has a four-colour vertex (rows 135, 137: the pigeonhole; G91, "the ring is the pigeonhole") and one local exclusion kills it (C114-LOCAL-F: the kill web). Recorded so the record job can cross-reference G15 in G83/G91; no composition |
| G17 | sub-rung compulsions have small carriers; globality only at the top rung | a measured pattern | **null** |
| G18 | certify components, compose in the kernel | a method | **applied** in the kernel lane generally; no audit site |
| G19 | no pattern class fires at five on swept fabric; inside K none can (Theorem B) | a measured null with a theorem half | **null** — class sweeps for finite witnesses are out |
| G20 | the brick seven-colouring is boundary-tight by force | a tight colouring as a model | **applied** in lane R (FS111-W-HEXSAT: no recolouring of the brick seven-colouring's tiling is saturated) |
| G22 | cell-constant and polygonal colourings need seven; a six-colouring's classes are non-polygonal | a no-go on colouring shapes | **applied** in lane R through the same source (FS106-SV2, FS106-AE-POLY, FS107-W-POLY; `[SokolovVoronov2025]`); FS-116's valid fragments have curved arcs and are no cell-constant colouring, so rows 34–35 do not reach them |
| G25 | a six-forcer's kills cost five-forcer grade | a pricing reading | **null** — finite witnesses for six are out |
| G28 | forcing sits outside the smallest non-edge classes | a sweep method | **null** |
| G33 | counterexample-guided growth toward a forced pair | a search method | **null** (a search, rule 5) |
| G39 | a forced pair at `χ(G)` colours confines the critical set to the pair's common neighbourhood | a criticality lemma | **null, with the reason**: its consumers would be forced pairs at the top rung; FS129-MA1-FALC-T's fans live in five-colourable graphs, below the top rung, where G39 says nothing |
| G77 | a band character exists iff a residue target has one (existence, not classification) | a character-colouring reduction | **null, with the reason**: at the real place a non-trivial character sends the unit circle onto a neighbourhood of 0, so no band character colours ℝ²; G77 is the field-level statement only |
| G78 | rank-one inheritance is "countable ⟹ finite"; Kempe moves cannot see a frozen wall | a one-dimensional subshift view | **null, with the reason**: the regularity era's one-dimensional objects (a ring of 60° hexagons, FS121-D3-SWAP1D's circle) are compact and checked by finite twist enumeration (FS116-RING-TWIST-C, FS121-D3-SWAP1D's exact control); G78's frozen-tail theorem concerns bi-infinite lines |

**Tally:** of the seventeen, none bears where it was not applied (MA1-E9 registered 0.2); three are applied in lane R or the kernel lane under their
sources (G18, G20, G22), and one is the shape of route M's NO under another name (G15).

## Stage 5 — SAVED (the table of misses; mechanisms that are two; the registration, provisionally scored; what is left for FS129-MA2)

### 5.1 Table of misses (pass 3 and the record job read this first)

| mechanism | site | what it would have given | derived or not |
|---|---|---|---|
| row 66's repaint at every slack target (G13, G66), not only Γ₁₁ | FS129-OA1-NOLIN5 and FS129-OA1-FALC-11 (pass 1 applied the argument at 11 alone, scalar coefficients alone) | the linear-identity kill with vector coefficients and at 19 and at every field with a four-colourable residue target; the Falconer-fan kill at any target, at 19, and as a four-colour forced pair in any four-colourable field plane | **derived**: FS129-MA1-NOAFF5, FS129-MA1-FALC-T, FS129-MA1-FALC-19 (§ 3.1) |
| G55's ideal argument (row 111) | FS-104 route (b)'s literal reading, carried open on `plans/STUB-cp-plane-six.md` l. 66 since FS-103 (listed, never worked) | the route empty at once | **derived by pass 1** (FS129-OA1-NOPERLAW); recorded here as the mechanism's miss |
| G71's height / FS129-OA1-RINGWIND's winding | FS106-BIKE's GAP (C-T-BIKE: three colours on the bicycle by finitely many arcs) | an invariant for a three-colouring of two hexagon rings coupled by cross edges | **not derived** — the route it served (FS-107's R-S) is closed (row 133) |
| row 1's two-circle theorem (G13) | FS106-BIKE | near miss: row 1 needs two concentric circles; the bicycle's are not | not derived |
| row 66's `Separated ↔ Adj` | ASTRA-2026-09-14-T10's statement ("for any real `F ⊇ K`") | its hypothesis is empty over every `F ⊇ K` with a residue-𝔽₁₁ prime; the prose says so, the statement does not | **wording, for pass 3** |
| G15's pigeonhole × kill | route M's NO (rows 135, 137; G83, G91) | the same shape under another name | a cross-reference for the record job; nothing to derive |

No miss of the FS116-Y4 kind (a step worked for rounds that a held mechanism would have emptied) was found in the mechanisms reached.

### 5.2 One grokking, two mechanisms; one mechanism, four grokkings (the brief's "say so")

- **G71 is two mechanisms**: the lattice height (`Θ₃`, three-colourability of abelian Cayley graphs; lane A, row 79) and the height on a curve (row 132's
  index of density traces, FS-110's ring winding, FS129-OA1-RINGWIND), which lane R uses and owns in practice. Pass 3's merge of RINGWIND with
  FS110-Y3-GP/-N2-RING belongs with the second.
- **G13 is two**: the coverage iff (`fan_iff_coverage`, `exists_fanGap_iff_not_coverAtLeast`; kernel, era-free) and the fan-ladder reading of Heule-510
  (measured, lane A only).
- **G54's last paragraph is a separate mechanism**: gap-free pullbacks in products (FS-67, rows 114–115), not tightness itself.
- **Row 66 is one mechanism under four grokkings**: G13's slack face, G26's exclusion over 11-usable fields, G31's sealed half, G48's "no"; a record
  job reading for "where else" should read row 66, not the four.

### 5.3 The registration (§ 1.3), provisionally scored (FS129-Z1 scores)

| id | registered | outcome |
|---|---|---|
| MA1-E1 mechanisms reached | 22 (12–35) | **23** (G13, G66 with row 66, G54, G71, G55, G56, the Falconer fan, and the seventeen); G26, G31, G75 read in support, not audited as mechanisms |
| MA1-E2 bearing somewhere unapplied, beyond pass 1 | 6; P(≥ 3) = 0.6 | **3** — row 66's family (two compositions), G71 (one site, on a closed route), G55 (a listed miss already derived by pass 1) |
| MA1-E3 compositions | 4 (1–8) | **3** |
| MA1-E4 misses of the FS116-Y4 kind | 1.5; P(≥ 1) = 0.55 | **0** worked-for-rounds; one listed-not-worked (G55 on route (b)) |
| MA1-E5 Falconer's lemmas differ materially | P = 0.15 | **no** — one difference changes FALC-RED's argument order, not its statement (stage 2) |
| MA1-E6 the bearing on the answer changes | P = 0.06 | **no** — FS-104's routes (b) and (c) narrowed further; no route closed or opened |
| MA1-E7 a held result found false | P = 0.03 | **no** |
| MA1-E8 new cross-era sites | 1; P(≥ 1) = 0.45 | **0 new sites**; two deepenings of pass 1's (J12 by NOAFF5, J13 by FALC-T and FALC-19) |
| MA1-E9 share of the seventeen bearing unapplied | 0.2 | **0 of 17** |

The miss runs one way: I priced the unmentioned seventeen as the likeliest hiding place, and they were the least productive — most are finite-witness
methods the project has retired (`CLAUDE.md` § Publication: a finite witness for six is out), and the rest are applied under their sources. The yield
came from reading pass 1's own compositions at the class their arguments carry.

### 5.4 What is left for FS129-MA2 (lane A's 47 mechanisms not audited here, in order of mentions in `data/fs129/index/grokking-uses.md`)

G1 (17), G21 (15), G35 (11), G48 (10), G7 (9), G31 (8), G43 (8), G44 (8), G73 (7), G4 (6), G26 (6), G27 (6), G57 (6), G61 (6), G64 (6), G38 (5), G62 (5),
G63 (5), G68 (5), G74 (5), G12 (4), G24 (4), G37 (4), G52 (4), G59 (4), G14 (3), G32 (3), G41 (3), G60 (3), G76 (3), G34 (2), G42 (2), G45 (2), G53 (2),
G58 (2), G65 (2), G75 (2), G80 (2), G9 (1), G16 (1), G23 (1), G29 (1), G36 (1), G40 (1), G69 (1), G70 (1), G79 (1).

**Notes for the successor.** (1) G26, G31, G48 are row 66's consumers (§ 5.2): read row 66's section here first and expect little new from them. (2) The
lane-A roots in `data/fs129/index/roots.md` (FS89-S0B-C1, -S0B-T1, FS91-J01-1/-3/-2/-4, FS89-S0A-4, -D0-T1, FS91-J10-L1, FS89-PA-B1, -S0A-3, FS91-J01-6,
FS66-L3) are G74's and G77's chains (the `Θ₄` layers and the torsion local–global theorem); weigh them when G74 comes up. (3) The method that paid
here: take a held composition, read off what its argument actually uses, and restate it at that class (identity: "state the class the argument
carries"); then list every target or field the record holds that meets the wider hypothesis. (4) A Searcher's request aimed at Falconer fans at five
colours should carry FS129-MA1-FALC-T's three filters (`χ(H) ≥ 4`; tip ≡ apex at every residue-𝔽₁₁ or 𝔽₁₉ prime; apex–tip forced at four colours in any
four-colourable field plane).
