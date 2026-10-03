# FS129-OA1 — pass 1 of the cross-application audit, lane A (the arithmetic era): the record

*Job FS129-OA1, brief `data/fs129/briefs/FS129-OA1-pass1.md`; a `general-purpose` agent on Opus reading Ephodos's identity
(`.claude/skills/ephodos/SKILL.md`, then `.claude/agents/ephodos.md` from `# Ephodos in lean-dir — the workflow`). Plan:
`plans/FS129-cross-application-audit.md` § 3 Stage 2. Writes only this file, `data/fs129/oa1/`, `tools/fs129_oa1_*.py` and
`data/fs129/reports/FS129-OA1.md`.*

## Theorems this phase proved

None yet (filled at the last stage).

## Stage 1 — SAVED (readback, registered expectations)

### 1.1 Readback of the brief's quotations (standing rule 3)

Checked by `grep -cF` of each quotation, character for character, against the source the brief names (2026-10-03 23:10 UTC):

| quotation | source named | found |
|---|---|---|
| "Right after this close, we'll be refining the workflow again... File that as a special case stub for after the workflow refinements." (full text) | `plans/STUB-cross-application-audit.md` § The request | 1 — verbatim |
| "1. yes, we don't want O(N^2) here. 2. Yes, keep to the cap, … so it'll pick up the latest changes." (full text) | `plans/FS129-cross-application-audit.md` § 1 | 1 — verbatim |
| "Also a note for the whole plan that not only are "hubs" important, but deep "roots", … even if it has only one offshoot" (full text) | `plans/FS129-cross-application-audit.md` § 1 | 1 — verbatim |

No mismatch. The brief's references to the inventory (items 11, 19, 20, 23, 24, 25) were read against `plans/FS129-close-inventory.md`;
each says what the brief says it says.

### 1.2 What I read before registering

The brief; the identity and the lane workflow's `## Where you sit`, `## A derivation job`, `## What leaves your lane`;
`plans/STANDING-RULES.md`; the plan; the inventory; and the stub in full — **including Poros's bearing paragraph, which names J1–J4,
J10 and the two lane-A sites of decision 4 (TOP₆'s coverage; FS-104's correlation route) by their headlines**. I had not opened
`data/fs129/demand-judged.md`, the index, or any derivation file when I wrote § 1.3. So the registration below is blind to the list's
steps except for those five headlines.

### 1.3 Registered expectations (before reading the demand list; scored at FS129-Z1)

My prior on the mechanism: lane A's results are algebraic and discrete — residue colourings, finite planes, field towers, forced pairs
in finite graphs, measure rigidity for the unit-vector group. The demand list is regularity-era: local geometry of colour classes near a
point, unit arcs, saturation, a CP colouring's correlations. The two eras meet in at most three places I can name in advance: (i)
anything that speaks of a colouring of one unit circle (a fan, coverage — G13) is local and era-free; (ii) the compulsion toolkit
(forced pairs, virtual edges) speaks of every proper k-colouring of a finite graph, and every finite unit-distance graph embeds in the
plane, so it constrains a measurable colouring wherever the graph is "seen" almost surely (row 130's random-motion argument); (iii)
measure rigidity and the collapse are already the bridge (rows 120, 128, 130), and the stub cites them.

| id | expectation | value |
|---|---|---|
| OA1-E1 | steps closed by a lane-A composition | expected 0; P(≥ 1) = 0.10 |
| OA1-E2 | steps shortened (a named case closed, a hypothesis removed) or reduced to another step by a lane-A composition | expected 1.5; P(≥ 1) = 0.55; P(≥ 3) = 0.15 |
| OA1-E3 | nulls ("no lane-A result bears") among the steps I reach | expected about 85 % of the steps reached |
| OA1-E4 | this lane moves the bearing on the answer (changes `CLAUDE.md` § Where the problem stands item 31's open list or the top three) | P = 0.07 |
| OA1-E5 | lane A closes or shortens a regularity-era step from a result its stub does not cite (Poros's A5, registered at 0.35) | P = 0.30 |
| OA1-E6 | a held lane-A result found false on reading | P = 0.03 |
| OA1-E7 | a composition outside the demand list, recorded for pass 2 | expected 1; P(≥ 1) = 0.5 |
| OA1-E8 | merges and new stubs from this pass (pass 1 is not the merge pass) | merges 0; new stubs expected 0.3 |
| OA1-E9 | the site most likely to yield, of Poros's four (J4, J12–J13, J2, J17) | J4 (TOP₆ as coverage, G13), P(it yields a shortening or reduction) = 0.3 |

## Stage 2 — SAVED (Poros's lane-A sites J4, J12, J13)

*Read for this stage: `data/fs129/demand-judged.md` in full (§ 1 homonyms, § 2 no-gos, §§ 3–5); `plans/STUB-top-colour.md`;
`plans/FS121-D3-proof.md` §§ 2.1–2.2, 3.1–3.6; G13, G54, G68, G89, G73, G75, G76; `LEDGER.md` rows 66, 91, 111–113, 124, 128–130;
`plans/STUB-cp-plane-six.md` ll. 1–110; `plans/FS103-M-derivation.md` § 1.2 (the first-hand reading of `[Falconer1981]`); the kernel's
`Fan`, `fan_iff_coverage`, `CoverAtLeast`, `FanGap`, `exists_fanGap_iff_not_coverAtLeast`, `not_fan_of_fanGap`
(`Proofs/HadwigerNelson/{Fan,Coverage,CoverageMono,FanGap}.lean`) and the two Γ₁₁ tables
(`Proofs/HadwigerNelson/Instances/FinitePlane11.lean` `finitePlane11Table`, `Instances/FanGap11.lean` `finitePlane11DoubleGapTable`).*

### 2.1 J4 — FS-128, TOP₆, a smaller form

**Step** (`plans/STUB-top-colour.md` ll. 10–11, as the list quotes it): "boundary point is bound (has a point at distance exactly 1) for every
colour present there except the largest (FS121-D3-GRUNDY, held). **TOP₆:** can some Grundy six-colouring, obtained from a tight one, have its
largest colour bound too? That is honest saturation at six (C121-SAT6). On the cover"

**Kind of input, before scanning** (my line, replacing the list's hunch): *an existence argument that uses the number six* — a procedure or a
global object that binds the top colour; coverage of the top colour's boundary circles is the bookkeeping of the conclusion, not the input
that delivers it. Against § 2: FS111-M2-NOSEL and FS111-M-DEADLOCK exclude selection and local fills; row 129 excludes density. So the
admissible kinds are a global rebuild or a universal ("every colouring") statement.

**Read against it (lane A):** G13 with `fan_iff_coverage`, `Fan.of_coverage`, `exists_fanGap_iff_not_coverAtLeast`; row 66
(`not_fan_of_fanGap`, `Slack.forces_iff`); G54 (Hoffman-tight ⟹ every colouring gap-free); G68; FS-67's gap-free pullbacks (G54's product
paragraph, rows 114–115).

**Null — no lane-A result bears.** Why each near miss misses:
1. **G13 is the wrong quantifier.** `Fan G k p Q` is "∀ proper colourings, `p` is painted like a member of `Q`", and `fan_iff_coverage` turns
   it into "∀ colourings, every colour shows on `N(p) ∪ Q`". Its contrapositive produces a colouring *with* a gap — a free point, the object
   TOP₆ wants to avoid. TOP₆ is existential: *some* Grundy six-colouring with no free top point. The only way a ∀-colourings compulsion
   reaches it is through the universal form, "every Grundy six-colouring obtained from a tight one has its top colour bound", which implies
   TOP₆ given a tight six-colouring (FS121-D3-GRUNDY supplies the Grundy one).
2. **The universal form is what Hoffman-tightness delivers finitely (G54), and the plane is Hoffman-slack at six.** The measurable
   unit-distance operator of ℝ² has normalised spectrum `{J₀(ρ) : ρ ≥ 0}`, least value `J₀(3.8317…) = −0.402759…` (computed with mpmath:
   `besselj(0, findroot(besselj(1, x), 3.8))`). Tightness at `k` is `λ_min = −1/(k−1)`, i.e. `k = 1 + 1/0.402759… = 3.4829…`, an integer for no
   `k`; at `k = 6`, `−0.4028 < −1/5`, so the plane is slack, and its Hoffman ratio `0.402759/1.402759 = 0.28712` exceeds `1/6`. G54's own
   demotion record says slack *permits* gaps and supplies none (row 87's middle case), so this does not refute the universal form; it says
   the one lane-A mechanism that proves a universal gap-freedom has no instance at the real place.
3. **The recolouring move inside `fan_iff_coverage` is the plane's fill move, already held and already shown insufficient.** The forward
   direction hands a colour missing from `N(p)` to `p`; in the plane that is FS111-C-FILL's Fubini step (used in FS121-D3-FALLSAT and
   -GRUNDY (b)), and FS111-W-FILL-FREE (a fill leaves the filled colour free on its new boundary) and FS111-M-DEADLOCK are exactly why
   attempt 3 stalled (`plans/FS121-D3-proof.md` § 3.4).
4. **Row 66 runs the other way.** "One gap frees every pair above it" uses a gap's *existence* to free compulsions; TOP₆ needs a gap's
   *absence*. G54's FS-67 paragraph (gap-free pullbacks in products) needs a gap-free factor, which the measurable plane does not supply.

**A defect in the card's wording (for Poros; not a defect in any held statement).** The carried card (`plans/STUB-top-colour.md`, "is the top
colour's binding at a boundary point the failure of a coverage — that point's unit circle covered by the five lower colours") is exact only
where `max P(x)` is the sixth colour. At a boundary point `x` with `m = max P(x) < 6`, colours above `m` may lie on `T₁(x)` (they are absent
only *near* `x`), so `m` is free at `x` iff `T₁(x)` misses `F_m`, i.e. is covered by the *other five* colours, higher ones included.

**What the step needs (the card's "needs a new kind of input" line).** TOP₆ needs either a universal gap-freedom statement for Grundy
six-colourings of the plane that does not come from a spectral tightness (the plane has none at any `k`), or a global rebuild that spends
six; no held result of either era delivers either. My reading of the card's question: **"no — coverage at the top colour restates TOP₆; it
cannot spend six"**, so FS-128's smaller question stays NOPAR-C5 (the card's own *if it is not* branch). Grade of this paragraph: a reading
with three receipts (the quantifier, the spectrum, the fill move); killing test: a Grundy six-colouring of a model space (a circle, a
lattice) whose top colour is bound by a coverage argument that reads no spectrum and no rebuild.

### 2.2 J12 — FS-104 route (c), correlation constraints on stationary colourings

**Step** (`plans/STUB-cp-plane-six.md` ll. 67–69): "- **(c) `k`-point correlation constraints** on stationary colourings — the tetrahedral
embedding at five colours, three- and four-point Bessel kernels à la Bachoc–Oliveira–Vallentin; FS-80's averaged certificate at the real
place (FS-80 re-aimed). An optimisation: post-ban unless its shape is derived first (the advisor)."

**Kind of input, before scanning:** a constraint on how the five classes of an invariant random colouring of ℝ² sit *together* — a
multi-point correlation or a joint spectral identity. Against § 2: row 129 excludes one class at a time; row 91's C0 excludes two-point
correlations on a real field; and the two-point simplex bound in ℝ² gives only `k ≥ 3.48` (the number above). Admissible formats: (i) a
*linear identity* on the simplex embedding valid for every proper colouring of some configuration (G75's annihilator input), (ii) ≥ 3-point
*positivity* (BOV's kernels, an SDP), (iii) a *count against a compact factor* (row 112's mechanism).

**Read against it (lane A):** G75 and row 85's annihilator; G73's no-gos and its averaged-certificate reading; G76; rows 111–113 (row 112's
stationary count against a compact Hoffman-tight factor); row 124 (SEL-k); row 91 (C0); rows 125, 129 (the one-class cap); row 66
(`Slack`, `PairwiseFusable`).

**Format (i) — a composition: closed over every field with a residue-𝔽₁₁ prime.** G75's mechanism needs "a local forbidden pattern that is
linear on the tetrahedral embedding". At five colours no finite unit-distance graph over such a field carries one:

derivation: FS129-OA1-NOLIN5
  statement: let F ⊆ ℝ be a number field with a prime 𝔭 of residue field 𝔽₁₁, let H ⊂ F² be a finite connected unit-distance graph, and for a
    proper five-colouring C of H let f_C(v) be the vertex of a fixed regular 4-simplex labelled C(v); if real numbers c_v and a vector w satisfy
    Σ_v c_v f_C(v) = w for every proper five-colouring C of H, then every c_v is 0 and w = 0
  uses only: row 66's Slack (Γ₁₁, 5) (every vertex of Γ₁₁ is gapped in some proper five-colouring; kernel, `finitePlane11_slack`); the residue
    map ρ : H → Γ₁₁ (unit vectors of F are 𝔭-integral because −1 is a non-square in 𝔽₁₁; H translated to put a vertex at 0); the single-vertex
    repaint of row 66 (`repaintAt`); the injectivity of the simplex labelling
  not claimed: anything about inequalities (three- and four-point positivity, BOV's format (ii)); polynomial identities of degree ≥ 2 beyond
    row 66's separated pairs; fields with no prime of residue field 𝔽₁₁ (K(√7) among them, where 7 is a non-square mod 11 and √7 has no image);
    any statement at the real place or about χ(ℝ²)
  argument: § 2.2 J12 — FS-104 route (c), correlation constraints on stationary colourings
  verdict: derived
  grade: hand
  minds: 1
  model: H the two unit rhombi a, b, c, t and a, b′, c′, t′ of the Moser spindle without its tip edge, over ℚ(√3) (11 splits there into two
    primes of residue field 𝔽₁₁); at three colours the analogous statement fails — every proper three-colouring forces the tips, f(t) − f(t′) = 0
    — and nothing contradicts that, because Γ₁₁ is not three-colourable, so ρ supplies no three-colouring to repaint
  prior art: owed — the forced-pair case is row 66's `Slack.forces_iff` (kernel); the linear-identity form not searched
  handoff: de Bruijn — a short corollary of `Slack.forces_iff_of_hom`'s proof: for each vertex u, the pulled-back colouring and its repaint at u
    differ only at u, so c_u (f(γ) − f(C(ρu))) = 0

*Argument.* Fix a vertex `u` of `H`. Slack gives a proper five-colouring `C` of `Γ₁₁` and a colour `γ` absent from `N[ρ(u)]`. `C∘ρ` is a
proper five-colouring of `H` (ρ is a graph homomorphism: adjacent points differ by a unit vector, whose image has quadrance 1 ≠ 0), and so
is its repaint at `u` with `γ` (every neighbour of `u` maps into `N(ρu)`, which misses `γ`). The identity holds for both; they differ only
at `u`, so `c_u (f(γ) − f(C(ρu))) = 0`, and `γ ≠ C(ρu)` with an injective labelling gives `c_u = 0`. Every `u` is such a vertex, so every
`c_v = 0` and `w = 0`. ∎ A forced pair is the case `c = e_u − e_{u′}` (row 66's `Forces ↔ =`); this is the same move with no restriction on
the support of `c`.

**Format (ii) — null.** No lane-A result bears on three- and four-point positivity. Row 66's `PairwiseFusable` (virtual edges are unit edges,
over the same fields) closes only the pair identities `⟨f(u), f(v)⟩ = −1/4` at non-edges, which are two-point and already excluded by § 2.
**Format (iii) — null by theorem's hypothesis.** Row 112's count needs a compact Hoffman-tight factor; the plane is one archimedean factor
with no compact piece, and its own ratio is slack at five (`m₁(ℝ²) ≥ 0.2293 > 1/5`, row 125's Croft). Row 113's "four classes cannot
cover" needs every factor below `1/k`: at `k = 5` the real place is above. **Verdict on J12: shortened, not closed** — format (i) is
closed on every configuration over a field with a residue-𝔽₁₁ prime, so an annihilator certificate for `χ_CP(ℝ²) ≥ 6` must be built on a
configuration over a field with no such prime; format (ii) needs a new kind of input relative to lane A.

### 2.3 J13 — FS-104 routes (0) and (b), Falconer's mechanism read as a CP statement

**Step** (`plans/STUB-cp-plane-six.md` ll. 59–61): "- **(0) Read `[Falconer1981]` first, as a CP statement** — the advisor: continuity in
probability lets a forced pair's distance vary continuously, which may be Falconer's mechanism. Owed before any route is ranked (G50). With
it: Soifer's measurability chapter, the Polymath16 measurable page, Bachoc–Nebe–Oliveira–Vallentin (arXiv:0801.1059), `[AmbrusEtAl2023]`."
**And** (l. 66): "- **(b) Falconer's mechanism in CP form** (the advisor): a forced pair whose distance moves continuously."

**A finding about the step's premise.** The stub (l. 41: "`[Falconer1981]`, **not held**") and the list's J13 ("Check `BIBLIOGRAPHY.md` for
`[Falconer1981]` first; the stub says it is not held") are stale: `BIBLIOGRAPHY.md` l. 169 has it **held and read in full, first-hand**
(2026-09-26, FS103-M and FS103-N), and `plans/FS103-M-derivation.md` § 1.2 quotes Lemmas 1–4 and Theorems 1–2 verbatim. Route (0) is done;
a correction is owed to the stub (for FS129-Z1, beside inventory item 28).

**Kind of input, before scanning:** a *compulsion* — a pair, or a vertex and a set, forced by every proper colouring of a finite
configuration — carried into the measurable setting by what a boundary point of a measurable colouring carries (two colours). Against § 2:
none of the listed no-gos excludes a compulsion; row 129 excludes the density half of Falconer's Theorem 1 (below).

**Read against it (lane A):** the compulsion toolkit (row 42; row 66's `Fan`, `FanGap`, `not_fan_of_fanGap`, `Slack`, `PairwiseFusable`);
G13; G26/rows 43, 61 (the χ ≥ 6 target); G55 and row 111 (the forced group is an ideal under rotations); rows 125, 129; the kernel's
Γ₁₁ tables.

**What Falconer's mechanism is, made explicit.** Reading FS103-M's quotations of Lemmas 1–4, the proof of Theorem 2 at `n = 2` consumes one
finite object, which I name: a **Falconer fan at `k` colours** is a finite unit-distance graph `H` with an apex `a` and a tip `t` not adjacent
to `a`, such that every proper `k`-colouring of `H − a` in which `N(a)` avoids two colours `c₁, c₂` gives `t` one of `c₁, c₂`. In the kernel's
vocabulary it is `Fan H′ k t [a₁, a₂]`, `H′` being `H` with `a` replaced by two adjacent copies with `a`'s neighbourhood. At `k = 4` the unit
rhombus `a, b, c, t` is one (`b, c` take the two colours other than `c₁, c₂`, so `t` takes `c₁` or `c₂`), with `|t − a| = √3`.

derivation: FS129-OA1-FALC-RED
  statement: if a finite unit-distance graph H ⊂ ℝ² has a Falconer fan at k colours with apex a and tip t, |t − a| = r > 1/2, and
    arcsin(1/(2r))/π irrational, then every cover of ℝ² by k measurable sets has two points at distance 1 inside one of the sets, so
    χ_m(ℝ²) ≥ k + 1 for Falconer's everywhere-proper measurable chromatic number
  uses only: `[Falconer1981]` Lemma 1 (a.e. rotation of a countable configuration about a point of a null set E meets E only there), Lemma 2 (E
    non-empty and null; at a point of E at least two classes are present — FS103-M's D2), Lemma 3 (a small translation puts the apex in either
    present class and keeps every other point in its class), Lemma 4 (a circle of radius r > 1/2 with irrational unit-chord angle, almost all of
    it in S̃₁ ∪ S̃₂, contains a unit pair in S₁ or S₂) — as quoted verbatim in `plans/FS103-M-derivation.md` § 1.2, not re-read from the paper
  not claimed: the almost-everywhere form (χ_m⁰, the target given MR) — it needs Lemma 3 with a positive-measure set of translations, which the
    1981 text does not supply (FS103-M § 1.2's table) and the 2005 exposition is reported to; that any Falconer fan at five colours exists;
    anything for χ(ℝ²) without MR
  argument: § 2.3 J13 — FS-104 routes (0) and (b), Falconer's mechanism read as a CP statement
  verdict: derived
  grade: hand
  minds: 1
  model: k = 4, H the unit rhombus with tip √3 — the angle condition is Falconer's own ((5 + i√11)^m ≠ 6^m), and the statement is his
    Theorem 2 at n = 2, χ_m(ℝ²) ≥ 5
  prior art: partly: `[Falconer1981]` Theorem 2's proof, which uses the spindle's rhombus; the form with a general Falconer fan not searched (owed)
  handoff: de Bruijn — behind the measurable chain (FS-113), with Lemmas 1–4 imported from `[Falconer1981]` as a documented assumption

*Argument.* Suppose `S₁, …, S_k` cover `ℝ²`, are measurable, and none contains a unit pair. By Lemma 2 pick `x₁ ∈ E`, with two classes, say
1 and 2, present at `x₁`. Place `H` with `a` at `x₁`; by Lemma 1, for almost every rotation `R` about `x₁` every other vertex `v` lies at a
density point of some class `k(v)`. By Lemma 3 (with `j = 1`, then `j = 2`) there are translations `p₁`, `p₂` with `p_j(x₁) ∈ S_j` and
`p_j(v) ∈ S_{k(v)}` for every other vertex. No set holds a unit pair, so `k` is a proper colouring of `H − a`, and `N(a)` avoids colour 1 (by
`p₁`) and colour 2 (by `p₂`). The Falconer fan gives `k(t) ∈ {1, 2}`: the point `x₁ + R(t − a)` is a density point of `S₁` or `S₂`. This
holds for almost every `R`, so almost all of the circle of radius `r` about `x₁` lies in `S̃₁ ∪ S̃₂`, and Lemma 4 gives a unit pair inside
`S₁` or `S₂` — a contradiction. ∎ The mechanism is the "+1" from a finite object that the advisor's hunch on FS-104 names as its falsifier
("a measurable "+1" mechanism from a finite forced pair"): it needs strictly less than a forced pair — a forced pair at `k` makes `H` a
Falconer fan vacuously, since `a` coloured `c₁` and `a` coloured `c₂` would force `t` to both — and it lives on the boundary points, which
carry two colours.

**The lane-A composition: the residue plane at 11 kills every Falconer fan at five colours except at tips congruent to the apex.**

derivation: FS129-OA1-FALC-11
  statement: let F ⊆ ℝ be a number field with a prime 𝔭 of residue field 𝔽₁₁; in every finite connected unit-distance graph H ⊂ F², every
    Falconer fan at five colours with apex a and tip t has t ≡ a (mod 𝔭)
  uses only: the residue map ρ : H → Γ₁₁ (as in FS129-OA1-NOLIN5); row 66's single-vertex repaint; the two kernel five-colourings of Γ₁₁
    (`finitePlane11Table`, `finitePlane11DoubleGapTable`, proper — decided in the kernel), their orbit under Γ₁₁'s 24-element point group and
    121 translations, and the exact finite fact read off that orbit: for every w ≠ 0 in 𝔽₁₁² some orbit colouring C with a gap γ at 0 has
    C(w) ∉ {C(0), γ} or a gap at w outside {C(0), γ} (control FS129-OA1-FALC-11-W)
  not claimed: the case t ≡ a (mod 𝔭) — no held colouring has a vertex with two gap colours, so the orbit cannot reach it (a search request);
    fields with no prime of residue field 𝔽₁₁; that any Falconer fan at five colours exists elsewhere; the almost-everywhere form
  argument: § 2.3 J13 — FS-104 routes (0) and (b), Falconer's mechanism read as a CP statement
  verdict: derived
  grade: hand
  minds: 1
  model: H = the unit rhombus a, b, c, t over ℚ(√3) (11 splits there into two primes of residue field 𝔽₁₁), apex a, tip t at distance √3:
    |t − a|² = 3 is a unit at 11, so ρ(t) ≠ ρ(a), and the statement says H is no Falconer fan at five colours — true directly: with N(a) = {b, c}
    avoiding c₁, c₂, the points b, c take two of the other three colours and t takes the third
  prior art: owed — it is row 66's arity-1 statement (`not_fan_of_fanGap`, `Forces ↔ =`) moved to the doubled apex; not searched
  handoff: de Bruijn — the orbit fact is a `decide` over 2 × 121 × 24 colourings of a 121-vertex graph, beside `Instances/FanGap11.lean`

control: FS129-OA1-FALC-11-W
  of: FS129-OA1-FALC-11 — the finite fact: the exceptional set of residue differences is {0}
  run: python3 ../tools/fs129_oa1_falconer_fan.py | tail -1
  expect: W = [(0, 0)]
  fault: python3 ../tools/fs129_oa1_falconer_fan.py --fault-gap | tail -1

control: FS129-OA1-SLACK-ORBIT
  of: FS129-OA1-NOLIN5 — every vertex of Γ₁₁ is gapped in some colouring of the held orbit (the translations do it)
  run: python3 ../tools/fs129_oa1_falconer_fan.py | head -1
  expect: vertices of Gamma_11 gapped in some colouring of the orbit: 121 of 121
  fault: python3 ../tools/fs129_oa1_falconer_fan.py --fault-notrans | head -1

*Argument.* Given `H`, `ρ`, and a vertex pair `a`, `t` with `ρ(t) − ρ(a) = w ≠ 0`. By the control's finite fact (translate so that `ρ(a)` sits
at the orbit colouring's gap vertex) there is a proper five-colouring `C` of `Γ₁₁` with a gap `γ` at `ρ(a)` such that either `C(ρt) ∉
{C(ρa), γ}`, or `ρ(t)` has a gap `γ′ ∉ {C(ρa), γ}`. Colour `H − a` by `C∘ρ`, repainting `t` with `γ′` in the second case (proper: `t ∉ N(a)`,
and `t`'s neighbours map into `N(ρt)`, which misses `γ′`). `N(a)` maps into `N(ρa)`, which misses `C(ρa)` (properness) and `γ` (the gap), so
the colouring is admissible with `{c₁, c₂} = {C(ρa), γ}`, and `t`'s colour lies outside it: no Falconer fan. ∎ The tool's script
(`tools/fs129_oa1_falconer_fan.py`) refuses an improper table (`--fault-table` exits 2 with "REFUSED"), and with gaps miscounted (`--fault-gap`)
its exceptional set changes.

**What this does to route (b).** A Falconer fan at five colours gives, by FS129-OA1-FALC-RED, `χ_m(ℝ²) ≥ 6`, and with an almost-everywhere
Lemma 3 it would give `χ_m⁰(ℝ²) ≥ 6`, hence `χ(ℝ²) ≥ 6` given MR (row 130) — FS-104's YES. FS129-OA1-FALC-11 confines where one can live:
over every field with a residue-𝔽₁₁ prime — every 5-sealed multiquadratic field ⊇ K among them (row 66) — only with the tip congruent to the
apex at that prime. So the route reduces to: **a Falconer fan at five colours whose tip is congruent to its apex at every residue-𝔽₁₁ prime
of its field (or over a field with none)**, plus the almost-everywhere Lemma 3. The literal reading of route (b) — "a forced pair whose
distance moves continuously" — has no instance at all:

derivation: FS129-OA1-NOPERLAW
  statement: for a stationary random colouring c of ℝ², continuous in probability and proper almost surely on every unit pair, the set Z of
    vectors x with c(0) = c(x) almost surely is a discrete subgroup of ℝ²; if the law of c is rotation-invariant, Z = {0}
  uses only: continuity in probability (x ↦ P(c(0) ≠ c(x)) is continuous, so Z is closed); stationarity (Z is a subgroup: c(x) = c(x + y) a.s. is
    the shift of c(0) = c(y)); properness on unit pairs (Z misses the unit circle); that a closed subgroup of ℝ² that is not discrete contains a
    line through 0
  not claimed: anything about pairs forced with probability below 1, or about near-forcing at a scale; that rotation-averaging preserves every
    property a route needs (it preserves stationarity, continuity in probability and almost-sure properness, which is all this statement uses)
  argument: § 2.3 J13 — FS-104 routes (0) and (b), Falconer's mechanism read as a CP statement
  verdict: derived
  grade: hand
  minds: 1
  model: the hexagonal seven-colouring under a uniformly random translation of its period torus: Z is its period lattice, discrete and
    non-zero, and the law is not rotation-invariant
  prior art: owed — the arithmetic analogue is G55's (row 111: a forced group invariant under the rotations is an ideal, so 0 or everything);
    this is its real-place form, not searched
  handoff: none — a relay-result recorded for FS-104's route (b); it enters no proof in this record

*Argument.* `δ(x) = P(c(0) ≠ c(x))` is continuous and `δ(x + y) ≤ δ(x) + δ(y)`, `δ(−x) = δ(x)` by stationarity, so `Z = δ⁻¹(0)` is a closed
subgroup. A closed non-discrete subgroup of ℝ² contains a line `ℝe`; then `c(0) = c(e)` a.s. with `|e| = 1`, against properness, so `Z` is
discrete. A rotation-invariant law makes `Z` rotation-invariant, and the only discrete rotation-invariant subgroup is `{0}`. ∎ So a forced
pair "whose distance moves continuously" exists in no CP colouring; Falconer's mechanism is not a forced pair in law but the doubled apex
on the boundary (FS129-OA1-FALC-RED), and that is the reading route (b) should carry.

**Falconer's Theorem 1 cannot give six.** Theorem 1 (FS103-M § 1.2: "if Rⁿ is covered by M/D or fewer measurable sets Sⱼ, there is a set in
the covering within which all distances are realized"; "an improvement of one … if the configuration employed has M/D integral") consumes a
configuration whose critical number `D` bounds every independent set (`D ≥ α(C)`, which the remark's chromatic reading needs; the paper's
definition is not quoted in FS103-M and was not re-read). For every finite unit-distance graph `G`, averaging a random translate of Croft's
periodic unit-avoiding set (density `≥ 0.2293`, `[Croft1967]` via row 125) gives `α(G) ≥ 0.2293 |G|`, so `M/D ≤ M/α(C) ≤ 4.36 < 5`: the
largest integral `M/D` is 4, and Theorem 1 gives at most `χ_m(ℝ²) ≥ 5`. This is row 129's one-class cap applied to Falconer's +1; recorded as
a null with its reason, not as an entry.

**Verdict on J13: shortened.** Route (0) is already done (Falconer held and read); route (b)'s literal reading is empty
(FS129-OA1-NOPERLAW); Theorem 1's format cannot give six (row 129's cap); Theorem 2's format reduces to a finite object, a Falconer fan at
five colours (FS129-OA1-FALC-RED), which every field with a residue-𝔽₁₁ prime kills except at tips congruent to the apex
(FS129-OA1-FALC-11), plus an almost-everywhere Lemma 3. **This is decision 4's question answered with a hit**: the arithmetic era (row 66's
slack Γ₁₁, the kernel's tables, the residue reduction of row 52) bears on the measurable question, by confining Falconer's route to six.
**Search request** (for the Searcher; no job here searches): does `Γ₁₁` have a proper five-colouring with a vertex whose closed neighbourhood
shows at most three colours (two gap colours)? A yes empties FS129-OA1-FALC-11's exception (`t ≡ a`), by the same repaint. Object: `Γ₁₁`,
121 vertices, degree 12, five colours, one clause emptying two colours from one closed neighbourhood. A second request, conditional on a no:
the same question on `UD(ℤ/121, 2)` with the two gap colours at `0` and a vertex `t ∈ 11ℤ² ∖ 121ℤ²` coloured outside them.

## Stage 3 — SAVED (J2 and J17, Poros's other two lane-A sites; then J1–J24 in rank order)

*Read for this stage: G71, G73 (stage 2), G53; `plans/FS116-N3-proof.md` § 3.2–3.3 (SEMI-PAR3's residue and RING-TRANSFER-QC);
`plans/STUB-q-ring.md` cases 1, 3, 5, 6 as the list quotes them; the list's J1–J24 entries.*

### 3.1 J2 — FS-124 case 1, SEMI-PAR3

**Step** (`plans/STUB-q-ring.md` ll. 25–29, as the list quotes it): "1. **SEMI-PAR3** (inventory items 96, 97): "in a non-Siamese simple valid
fragment on a closed disc of radius above 1 about a vertex p of at least four colours, no change point of the ring is a full parallel semi-hub of
exactly three colours" — GAP: "the step from the bowtie's four-colour parallel semi-hub to three colours — removing the tile of p toward y from y
(kind O), or the outer tile (kind T) — is excluded by no cone at p, u, y or v; a proof must read y's own ring, which carries three absent colours
and no parity". A construction by formula (FS114-Y2-BOWTIE with its tip `t2` removed from `top`) or a reason none exists decides it."

**Kind of input, before scanning:** an invariant of a three-colouring of `ω(y)` in which points 60° apart differ — the list's hunch, kept.
Against § 2: not a count (G86), not a cell-local certificate on a lattice (G73 is about four colours on lattice graphs; this is three colours on
a circle, where G71 says a height exists).

**Read against it (lane A):** G71 (three colours are linear: a height and a winding); G73 (the `V₄` of `K₄`'s matchings); row 79's `Θ₃`.
Lane R's row 132 (the index of density traces, "this height on a curve", G71) is the same object in the plane, held — a cross-era line.

**What lane A delivers — an invariant, derived; it does not close the step.**

derivation: FS129-OA1-RINGWIND
  statement: let c colour the circle by three colours, defined and locally constant off a finite set Σ of change points, with c(θ) ≠ c(θ + 60°)
    wherever both are defined; for θ with no point θ + 60°j in Σ let W(θ) = (1/3) Σ_{j=0..5} d(c(θ + 60°j), c(θ + 60°(j+1))), where d(x, y) is +1
    if y = x + 1 and −1 if y = x − 1 (mod 3); then W takes values in {−2, 0, 2}, has period 60°, and changes across θ₀ only if Σ contains two
    points θ₀ + 60°j and θ₀ + 60°(j+1) for some j; so its jumps over one period sum to zero, and a hexagon position that is the only one with two
    change points 60° apart carries no jump
  uses only: properness at 60°; that a single hexagon vertex changing from colour x to colour y forces both its hexagon neighbours to the third
    colour z, and z → x → z, z → y → z both contribute 0; that changes at non-adjacent hexagon vertices are read against unchanged neighbours;
    periodicity of W; that six steps of ±1 summing to 0 mod 3 sum to −6, 0 or 6
  not claimed: that W is constant (two change points 60° apart can move it by ±2 — the swap of row 132 and G71); anything about the parts of the
    ring outside the fragment (at radius below 2 about p, part of ω(y) is unread); that SEMI-PAR3 holds or fails
  argument: § 3.1 J2 — FS-124 case 1, SEMI-PAR3
  verdict: derived
  grade: hand
  minds: 1
  model: the colouring c(θ) = ⌊θ/60°⌋ mod 3 (six 60° arcs coloured 0, 1, 2, 0, 1, 2): Σ = six points, every hexagon position has all six
    vertices changing at once, W = 2 on both sides of each — the jumps are zero, as the sum rule requires
  prior art: partly: G71 (Chandgotia's height functions for three-colourings) and row 132's index of density traces, both "fail only at a swap";
    the ring-hexagon form not searched (owed)
  handoff: none — a relay-result handed to FS-124's opening and to lane R (FS129-OR1) for J2; it enters no proof here

control: FS129-OA1-RINGWIND-ALL
  of: FS129-OA1-RINGWIND — every proper three-colouring of the 12-cell discretised ring (first cell fixed) obeys the jump rule
  run: python3 ../tools/fs129_oa1_ringwind.py | tail -1
  expect: violations: 0
  fault: python3 ../tools/fs129_oa1_ringwind.py --fault | tail -1

*Argument.* Off `Σ − 60°ℤ`, `W` is locally constant. At `θ₀` where exactly one hexagon vertex `h` changes, from `x` to `y`, its two hexagon
neighbours are 60° from it, so they differ from `x` before and from `y` after; being unchanged, each is the third colour `z`, and the two
steps through `h` contribute `d(z, x) + d(x, z) = 0` before and `d(z, y) + d(y, z) = 0` after. If several vertices change but no two are
adjacent in the hexagon, the same computation applies to each against unchanged neighbours. So a jump needs two adjacent hexagon vertices
— two points of `Σ` exactly 60° apart — changing together. `W(θ + 60°) = W(θ)` (the same hexagon), so the jumps met as `θ` runs over one
period sum to zero. ∎ The 18-cell ring was also checked once (`--m3`: 97,284 proper colourings for 12 and 18 cells together, 0 violations,
about a minute; not a gate control because of its time).

**How it bears on SEMI-PAR3 (a reduction proposed for lane R, not derived here).** In SEMI-PAR3's configuration (`plans/FS116-N3-proof.md`
§ 3.2) `y` carries `X`, `X̄` (absent at `p`) and `t_back`'s colour, so `ω(y)` carries only `a`, `a′` and `t_front`'s colour; `ω(p)` carries
only `X`, `X̄`. With `y = r(ψ)`, the points `u = r(ψ + 60°)` and `v = r(ψ − 60°)` of `ω(p)` lie on `ω(y)` at 60° on either side of `p`, which
is on `ω(y)` too (`y + e^{i(ψ+120°)} = p + e^{i(ψ+60°)}`). Being on both rings, `u` and `v` are interior to no tile, so the hexagon of `ω(y)`
through `p` is the one hexagon position with three consecutive candidate change points (`u`, `p`, `v`). **So, on a fragment of radius at least 2
about `p` (where all of `ω(y)` is coloured), W's jump at `p`'s hexagon is minus the sum of its jumps at every other pair of change points of
`ω(y)` 60° apart; a configuration whose jump at `(u, p, v)` is non-zero must carry another such pair on `ω(y)`.** The jump at `(u, p, v)` is
read from the colours of `ω(y)` on both sides of `u`, `p`, `v` — FS116-N3's (Q) arcs at `u⁺`, `v⁻` and `p`'s tiles `t_a`, `t_{a′}` — which is lane
R's data. At the step's own radius ("above 1") the far part of `ω(y)` is outside the fragment and W is not defined round the whole ring, so the
reduction needs the radius raised to 2 (C114-LOCAL-F allows any explicit radius). **Verdict on J2: not closed; one input of the kind named,
delivered** — the list's hunch "three colours have a height" is right in kind, and its plane form is held in lane R (row 132).

### 3.2 J17 — FS-124 cases 3, 5 and 6: crossed reciprocity, the recurrence, FS114-K1's (Q) residues

**Step:** the three quotations of the list's J17 (`plans/STUB-q-ring.md` ll. 34–35, 40–42, 43–45).

**Kind of input, before scanning:** a label conserved along placements (the list's hunch) — more exactly, a statement that the perfect
matching `{A, B, C}` of the six colours carried by a placement edge is the same at both ends.

**Read against it (lane A):** G73 (`KG(4, 2)` is three disjoint edges — the three perfect matchings of `K₄`'s colours, the `V₄`; from five
colours `KG(k, 2)` is connected and carries no edge-local height on a presentation with two generator classes); G71 (a three-colouring of a
graph with unit triangles is forced along them).

**Null — no lane-A result bears beyond the list's own reading.** G73's `KG(4, 2)` fact gives exactly what the list already derives: around one
four-colour vertex the placed missing pairs alternate between a pair `B` and its complement in `p`'s four colours, so one matching `{A, B, C}` per
vertex. Whether the matching is conserved from `p` to a placed hub `q` (whose own placed pairs live in `KG(4, 2)` on `A ∪ C`, where `{A, C}` is one
of three splits) is the recurrence itself, and G73's connectedness of `KG(6, 2)` is the caution: a label free to move in `KG(6, 2)` carries no
height (G73's no-go at five colours and above), so G71's linearity enters only after conservation is shown. Lane A supplies the vocabulary, not
the step.

### 3.3 The rest of the judged list, in rank order (each with its kind line, what I read, and the verdict)

| step | kind of input every closing argument reads (my line, before scanning) | lane-A results read | verdict |
|---|---|---|---|
| **J1** FS-123 q. 1, the bends on a fragment (`plans/STUB-qfree-ring.md` ll. 29–31) | a modification lemma: FS-112's moves keep validity, non-Siamese, simplicity and `p`'s colours on a fragment | row 78 / G68's Kempe swaps and voltage escape; row 91's HD4 (Kempe swaps of pullbacks are pullbacks) | **null**: lane A's only modification lemmas act on discrete colourings of lattices and field planes (a Kempe component, a single-vertex repaint) and preserve properness, never the geometry of tiles; nothing about a map's arcs |
| **J3** FS-125, NO-SAT (`plans/STUB-saturated-local.md` ll. 21–22, 48–52) | contact at distance exactly 1 (SATPIN) against a straddle, and how a collision's margin moves with a tilt | the compulsion toolkit (row 42), G13 | **null**: no lane-A result reads contact geometry; G13's coverage is the bookkeeping of saturation (stage 2, J4), not an exclusion |
| **J5** FS-124 case 4, five- and six-colour vertices (ll. 36–39) | distances between outer tiles at (Q)-arc ends 60° apart | G75's triangle relation `1 + ζ₆² = ζ₆`; G55's unit-vector ring | **null**: the identities lane A holds are exact relations among unit vectors in a field; the step needs inequalities between tiles; V6-HUG (lane R) is the right kind |
| **J6** FS-124 case 2, the disk's corner (ll. 30–33) | points and distances on `p`'s far side | — | **null**: nothing in lane A reads a configuration's far side |
| **J7** FS-123 q. 3 / FS-124 case 7, Siamese and non-simple classes | points and distances only, never a count (G86) | — | **null** |
| **J8** FS-126, a curved tangent interface (`plans/STUB-curved-pencils.md` ll. 14–15) | aperiodic structure (a construction meeting PENCILWIN, DOUBLE, VT) or an obstruction | G62, G78 and FS-76's aperiodic colourings, which the list names at low confidence | **null**: lane A's aperiodic colourings live on field planes and lattices (discrete, residue-built); none has boundary arcs, and none carries a smooth interface |
| **J9** FS-127, LAT (`plans/STUB-lateral-extent.md` ll. 12–13) | distance-exactly-1 facts at an accumulation point (the sagitta) | — | **null** |
| **J10** the map step at five (FS111-REG-JP-C5) | regularity of maximal covers by modifications that keep maximality | rows 125, 129 (the one-class cap at five); G54 | **null**: the step is regularity, which no lane-A result reads; the five-colour density facts lane A holds (m₁ ≥ 0.2293 > 1/5) say only that one class at a time cannot refute five |
| **J11** FS-120, the pinch at a junction (`plans/STUB-pinch-at-junction.md` ll. 28–29) | a modification lemma along the ladder of unit parallels, ending at a junction | — | **null** |
| **J14** FS-122, B-RR (`plans/STUB-forced-pair.md` ll. 23–24) | a feature's scale bounded below, independent of the holes | row 66's arity floor (a forced pair at five is one vertex over sealed fields) | **null**: route R's "forced pair" is sense (ii) of the list's § 1 — a structure, not a colour equality; row 66 speaks of sense (i) |
| **J15** route R's pairs and route M's four-colour vertices (Poros's words) | a band-stable form of row 135's rhombus lemma | — | **null** (both sides are lane R; no side picked) |
| **J16** FS-122, a robust count and the kills under a band (ll. 25–27, l. 68) | a margin bounded below at a feature's scale | G53's counting compulsion; G15 | **null**: a counting compulsion degrades by at most one per hole met, so it is robust under small holes by a union bound — but every finite obstruction is robust that way (a hole-free random placement exists when the hole density is below `1/|G|`), so G53 adds nothing beyond finite graphs, and the step asks for a *local* kill at a radius independent of ε and the complexity, not a finite graph |
| **J18** FS-123 q. 2, the (R2)-arc ring | as J1, after the bends | — | **null** |
| **J19** FS-124 case 8, DISC-F and LOCAL-DENSE | compactness, and a vertex of four colours in a bounded disc | de Bruijn–Erdős as used in rows 103, 107 (the kernel's compactness) | **null**: lane A's compactness is for colourings of countable graphs; FS114-N114-COMPACT (lane R) already holds the fragment form |
| **J20** FS-128, C121-NOPAR-C5 | jets of boundaries along unit parallels | — | **null** |
| **J21** FS-104 route (a), the density family at `j = 4` | a non-density (integrality) argument, or the value of `m₄(ℝ²)` against `4/5` | row 129 (the one-class principle), G60, FS-56's field blow-up, as the list asks | **null**: a `j`-class form of row 129 would bound field planes by `max(m_j(ℝ²), sup_v r_v^{(j)})`, and at the real place that is `m₄(ℝ²)` itself — the question, not an input. (Half-period translates of Croft's set do not reach `4/5`: three translates on the deep-hole classes are disjoint and give `3 × 0.2293`, but a fourth at the finer lattice's deep holes sits about `0.6` from three tile centres with tile radius about `1/2`; a reading, not checked on Croft's parameters) |
| **J22** row 134's base, Lemma 4 at cusps | — (a root of lane R) | — | **null** |
| **J23** Townsend's (c), in full | — (a root of lane R) | — | **null** |
| **J24** FS-117, K2′, GAP-μ, COVER-3 | counts and covers at cubic vertices | G53 | **null**: the counts there are of tiles meeting a disc; G53's is of colours at a circle's points in a finite base |

**Cross-era lines (results of lane R I saw bear on a step; noted for FS129-OR1, not derived):**
- J2: row 132's index of density traces is FS129-OA1-RINGWIND's object in the plane; RINGWIND's sum rule is its ring form.
- J13: row 130's random-motion argument (N-EASY) is what turns a Falconer fan's everywhere-proper conclusion into an almost-everywhere one only
  if Lemma 3 holds with a positive-measure set of translations; FS103-M § 1.2 records that the 1981 text does not supply it.
- J4: FS111-W-FILL-FREE and FS111-M-DEADLOCK are the held reasons the fill move (the plane form of `fan_iff_coverage`'s recolouring) cannot
  bind a top colour.
