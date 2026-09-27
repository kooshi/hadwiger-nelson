# Poros — FS-110, the tangency seam: planning advice (job FS110-A, the planning advisor, 2026-09-27)

*Opus 5.5. Brief `data/fs110/briefs/A110-advisor.md` with `data/fs110/briefs/STANDING-RULES.md`. I advise the planner FS110-P (de Bruijn); the
planner decides. Every result below is one mind (mine) unless marked, at the grade stated. I touch only this record and `data/fs110/fs110-a/`.*

## Theorems this phase proved

- **A-EXACT** — on a full tight a.e.-proper map colouring (open tiles, boundaries null), an interior point `z` of a colour-`j` tile has no interior
  point of a colour-`j` tile at distance exactly 1; so for a vertex `u` the set `B_u(s) = {z : ω(z) meets a tile of every colour of P_cl(u) inside
  B(u, s)}` is open and must be coloured outside `P_cl(u)`. [hand, one mind, trivial] — §1.2.
- **A-CIRC** — on such a map, every tile-interior point of `ω(u)` has a colour outside `P_cl(u)` (the closure type): the distance map on
  `tile(x) × sector` is open, connected and takes values on both sides of 1. [hand, one mind, sketch] — §1.2.
- **A-SIX** — FS106-TS's proof of C-T-TAN uses `|P(u)| = |P(v)| = 3` only through "all six classes are in `P(u) ∪ P(v)`"; so it holds verbatim for
  disjoint types of sizes (2, 4). [read + hand, one mind] — §1.3.
- **A-PAR** — the second-order blocking computation (§1.4): at a tangent interface of relative curvature `κ` the forced band has depth
  `≍ |1 − κ|s²/2`; at `κ = 1` (a unit arc centred at `w₀`) no band along `e_u`, but a thin wedge along `ω(u)` at `w₀`. [hand, one mind, sketch]

## Would-have-searched-here log (standing rule 3)

- A scan over the interface curvature `κ` and the sector angles of a ring junction for the band depth: derived the parabola comparison instead (§1.4).

## Stage 0 — SAVED: quotation check (standing rule 5) and reading

| quotation in my brief or the standing rules | source | result |
|---|---|---|
| V's C5, quoted as "tangency is no escape at positive scale" | `plans/FS107-V-verification.md` l. 272: "**Tangency is not an escape at positive scale**"; the stub's heading: "Tangency may be no escape at positive scale" | **paraphrase, not verbatim** (sense kept; "no" for "not an"). Carried below in V's words |
| Kooshi, rule 0: "From here on out, you may doubt … you will surprise yourself." | `CLAUDE.md` § Counter-priors | verbatim |
| Kooshi, rule 4: "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | `CLAUDE.md` § Where the problem stands, item 23 | verbatim |
| the ban's intent, rule 3 | `CLAUDE.md` § Toolchain | verbatim |
| "search for a finite graph is out. It would be huge, not feasible." | `CLAUDE.md` § Publication | verbatim |

Read from disk, in full unless marked: `CLAUDE.md` § The aim, § Counter-priors, G82 (rewritten at FS-107's close); `plans/STUB-tangency-seam.md`;
`LEDGER.md` rows 131–133; `plans/FS107-derivation.md`; `plans/POROS-2026-09-27-fs107-competition.md` §5; `data/fs107/claims.md` §2 and §7;
`plans/FS107-V-verification.md` §4.3; `plans/FS106-TS-derivation.md` §2.2 (TS-U), stages 4–5 (C-T-TAN, C-T-BIKE, C-T-KILL, C-T-CHR4, C-T-IND);
`plans/FS106-V-verification.md` § Continuation — FS106-V3, Townsend's ⅔π example (l. 368–375); the protocol §1 rule 1 (l. 28–56).
**Order of events:** the planner's message with its §G bears list (summary only; its draft file unopened) arrived at about 09:12 UTC, after the
computation in §1.4 was done in my working notes and before this record was written; nothing in §1 comes from it.

## Stage 0 — SAVED

## Stage 1 — SAVED: my expectation, written before any planner draft

### 1.1 The frame on five axes

- **Object:** a locally finite map in `𝓜_K` (tiles bounded by `≤ K` circular or straight arcs of radius `≥ 1/K`), six-coloured, every
  same-colour pair of tile interiors free of distance exactly 1 (tight, a.e.-proper). In a stranger's words: **six open unit-distance-avoiding
  sets, each a locally finite union of curvilinear polygons, with dense union.** Row 132 says as much ("closed classes are the tight question itself").
- **The question asked:** its existence (Q-full); its local necessary conditions at vertex pairs (Q-rule).
- **Discipline:** the seams are local: a second-order contact computation between unit circles and a vertex figure (§1.4); the vertex figures
  are the tilings discipline's; the bicycle is a distance graph on a one-manifold (circular colourings, `[Zhu]`-type).
- **Audience:** a reader of `[SokolovVoronov2025]` Question 2 and `[Voronov2023]` §6.
- **Product:** Q-full decided, or each seam closed, realised or a named GAP.

### 1.2 Two facts that make the map world exact (A-EXACT, A-CIRC)

In `𝓜_K` the limit is a map, not only a density colouring, and on a map the tight condition is exact at every scale: tiles are open, so a
monochromatic unit pair between two tile interiors carries a neighbourhood of monochromatic unit pairs. Two consequences:
- **A-EXACT.** For complementary `u, v` the open sets `B_u(s)`, `B_v(s)` must be **disjoint**: a point of both would need a colour outside
  `P(u) ∪ P(v)`. C-T-TAN is this statement's blow-up at `w₀`. So Q-rule has an **exact positive-scale form** — `B_u ∩ B_v = ∅` near each common unit
  point — and it reads **closure types**, because every tile whose closure contains `u` has positive area in every `B(u, s)`.
- **A-CIRC.** `ω(u)`'s tile-interior points avoid `P_cl(u)`: for `x ∈ ω(u)` in a tile of colour `j ∈ P_cl(u)`, the distances between `tile(x)` and
  `u`'s colour-`j` sector form an open connected set with values on both sides of 1 (move `p` toward or away from `u`), so they contain 1.
  This is Voronov's first observation in exact form; with it the same-type seam (§1.5, seam 4) is exactly C-T-BIKE.

### 1.3 "Complementary" is "the union is all six", not "two disjoint three-sets" (A-SIX)

C-T-TAN's proof (TS stage 4): "Some class `j` fills at least `|Π|/6` of `w₀ + r_nΠ` (all six classes are in `P(u) ∪ P(v)`)". Nothing else uses
`|P| = 3`. So disjoint types of sizes **(2, 4)** — an edge point or a bichromatic vertex against a **four-colour vertex** (C-T-CHR4: `|P(x)| = 4` not
excluded on LIM) — are complementary pairs, blocked by the same argument. The stub and K-C6 list only three-sets. **A G21 instance in waiting:** a
NO that kills every (3, 3) seam leaves a four-colour vertex as an unlisted escape; a YES may use one. A four-colour vertex `c d e f` blocks or not by
direction exactly as a bowtie does (two of its colours in opposite closed half-planes of `e⊥` for an open set of `e`).

### 1.4 The positive-scale computation: what each local seam costs (A-PAR)

Put `u` at the origin, `e = e_u` toward `w₀`, `x` along `e⊥`. For `z = w₀ + ρe + τe⊥` the circle `ω(z)` near `u` is `y = ρ − τx + x²/2` (it bends
toward `w₀`). A tangent interface at `u` between `A` (above) and `B` (below) is the ray `y = κx²/2`, `x > 0`, the third colour `C` on the far side.
- **`κ ≠ 1`:** at `τ = 0` the circle crosses the interface at `x² = 2ρ/(κ − 1)`, and meets `A`, `B` and `C` for `ρ` of one sign, depth
  `≍ |1 − κ|s²/2`. V's straight case is `κ = 0` (depth `s²/2`, V's C5). **A band along `e`**: it meets any partner's band near `w₀`.
- **`κ = 1`, the interface an arc of `ω(w₀)`:** at `τ = 0` the circle is parallel to the arc near `u` and sees `{A, C}` or `{B, C}`: **no band on
  either side** — V's sketched general claim ("every ring junction blocks every direction, on one side or the other, at depth
  `≳ min(s·(angular margin), s²/2)`, unless a colour is a sliver near `θ ± 90°`", V §4.3) **fails here in its band form**: its killing test ("a ring
  junction and a direction `θ` with no forced band on either side") fires. **But** tilted circles (`τ ≠ 0`) cross the arc at `x = ρ/τ ∈ (0, s)`: `B_u`
  contains the thin double wedge `{0 < ρ/τ < s}` hugging `ω(u)` at `w₀`. A partner that blocks has a band crossing `ω(u)` transversally at `w₀`, and
  one of the two wedges enters it: `B_u ∩ B_v ≠ ∅`. So **against a blocking partner tangency is still no escape** — V's conclusion survives in the
  form that matters; only its band shape fails.
- **Three single sectors never escape** (every line near `u` with direction near `e⊥` that crosses the shared ray sees all three): a ring
  junction's `B_u` near `w₀` is at least a thin wedge. **A colour in two sectors straddling the tangent line with margin `µ`** (the bowtie
  `a b a c`, `b` above and `c` below) has `B_u` **empty** near `w₀` for tilts `< µ`: a **strong escape**, open in the direction.
- **A cusp** at positive scale is a sector of angle 0 whose colour every crossing circle sees (a curve crossing from one side of the horn's
  direction to the other traverses the horn); so it blocks as a ring junction does, and is at best a thin wedge when the horn lies along `ω(w₀)`.
  **The cusp GAP is the essential type's artifact; with closure types it is the tangent seam again.**

So at a common unit point `w₀` a complementary pair survives only if **one side is a strong escape** (bowtie-type, or a four-colour vertex in a
bowtie direction), or **both sides carry unit arcs centred at `w₀`** (two thin wedges along two transversal circles meet only at `w₀`) — the
**double unit-arc seam**. Then TS-U at `w₀` (twice) makes `w₀` a vertex: each arc's inner colour only in the wedge facing its endpoint, the outer
colour only in the wedge facing away, a third colour in each pair of side cones. Townsend's ⅔π example (FS106-V3, l. 368) is this seam's local
model: a boundary `e` that is an arc of `ω(a)`, its centre `a` a corner of the sector.

### 1.5 The expectation, seam by seam (obstacles, not odds)

| seam | what would close it | what would realise it | the obstacle |
|---|---|---|---|
| 1. tangent | §1.4 for `κ ≠ 1` and for one-sided unit arcs: a derivation at positive scale, exact on the map | a **double unit-arc seam**: `u, v` both emit arcs of `ω(w₀)`, and of `ω(w₀′)` for the second unit point, so `u w₀ v w₀′` is a unit rhombus of **vertices** (the spindle's rhombus), `ω(w₀) ∩ ω(w₀′) = {u, v}` | the cascade: `w₀, w₀′` are vertices at distance `√(4 − d²) < 2` whose own common unit points are `u, v`; their types, and the pair `(w₀, w₀′)`, must be consistent. A NO needs this cascade to fail finitely; a YES needs it periodic |
| 2. bowtie | not by the index (row 132: `\|ΔInd\| = 2` at a unit-arc interface facing a bowtie); by an area (a priced swap, FS107-R-SW's `s³` at flat swaps) or by an Act One that forces a non-bowtie complementary partner near every bowtie | robustly: an open condition on the direction, no curvature matching | **the likeliest seam to stay live**; R has no instrument there (the index is dead, CP needs blocking) |
| 3. cusp | closed by §1.4 once types are closure types: it reduces to seam 1 | only inside a double unit-arc seam, the horn along `ω(w₀)` | none beyond seam 1, if the planner states Q-rule on closure types; a GAP by construction if on essential types |
| 4. same type in `(1, 2)` | C-T-BIKE decided NO: `T₁(u) ∪ T₁(v)`, coloured by the three complementary colours (A-CIRC), has no proper arc 3-colouring at any `d ∈ (1, 2)`; or the swap priced | a **formula** arc 3-colouring of the bicycle at some `d` — checkable exactly, allowed under the ban | the tight swap at an isolated parameter is harmless (TS C-T-BIKE (ii)); R's `π/3` ansatz fails narrowly at `d = 1.9` and the general two-circle colouring is unused — **live as long as bowties** |
| 5. four-colour and bichromatic `≥ 4` vertices | A-SIX puts (2, 4) pairs under C-T-TAN; C-T-CHR4 at `\|P\| = 4` | a four-colour vertex in a bowtie direction | unlisted in the stub; must be in the exception list for G21's completeness |

**Longest live:** the bowtie and the bicycle, together — and the configuration where the printed method dies (a unit-arc interface facing a
bowtie) is where a construction should start. **V's C5 survives a general ring junction** in the form "a tangent ring junction still blocks against
a blocking partner", and **fails** in its band form at unit arcs; the exception it leaves is the double unit-arc seam. **Act One stands apart from
the seams:** the NO also needs every tight map to have a close complementary or same-type pair at all (C-T-TRIb, C-T-PIG; K-C6's intersecting
families). FS107-A's star test shows one colour cannot be in every type; a local version (every diameter-2 disc's types intersecting) is not
excluded by anything held.

### 1.6 Evidence inventory

- `plans/FS107-V-verification.md` §4.3, V's C5 — read against: a band at every ring junction for straight and curved interfaces alike — surprised: yes, the sketch is for a straight interface only, and the unit arc escapes the band (§1.4)
- `plans/FS106-TS-derivation.md` stage 4, C-T-TAN's proof — read against: `|P| = 3` used in the slice sets — surprised: yes, used only via "all six classes" (A-SIX)
- `plans/FS106-V-verification.md` l. 368, Townsend's ⅔π example — read against: a unit-arc seam whose centre is a vertex or corner — surprised: no
- `data/fs107/claims.md` §2 K-TAN and §7 — read against: the exception list reads essential three-sets — surprised: no; that is the gap in §1.3
- `plans/STUB-tangency-seam.md` § Types — read against: a recommendation between essential and closure types — surprised: yes, left open; §1.2 settles it for `𝓜_K`
- the planner's §G bears message (about 04:12) — read against: nothing about positive-scale contact geometry or (2, 4) pairs — surprised: no; it lists bichromatic `≥ 4` vertices as a fifth kind (it agrees with §1.5 row 5) and Act One (agrees with §1.5)

### 1.7 Hunch ledger

hunch: c5-fails-in-band-form-at-unit-arcs
  claim: a ring junction whose tangent interface is an arc of the unit circle about `w₀` has no forced band along `e_u` on either side
  basis: derived
  falsifier: an explicit ring junction with a unit-arc interface and a side `ρ` of one sign on which `ω(w₀ + ρe_u)` meets all three colours within `B(u, s)`
  registered: 2026-09-27
  status: open

hunch: tangency-is-no-escape-against-a-blocking-partner
  claim: at positive scale a complementary pair survives at `w₀` only by a strong escape on one side or a double unit-arc seam centred at `w₀`
  basis: derived
  falsifier: a tight map in `𝓜_K` with a complementary pair at `w₀` where one side is a ring junction and the other blocks with margin
  registered: 2026-09-27
  status: open

hunch: cusps-close-under-closure-types
  claim: with closure types, a cusp vertex's blocking set near `w₀` is nonempty, so the cusp seam reduces to the tangent seam
  basis: derived
  falsifier: a cusp vertex with a blocking partner whose blocking set near `w₀` is empty
  registered: 2026-09-27
  status: open

hunch: bowtie-and-bicycle-outlive-tangent-and-cusp
  claim: at FS-110's close the seams still live, if any, are the bowtie and the same-type bicycle, not the tangent or the cusp
  basis: prior
  falsifier: FS-110 closes the bowtie or the bicycle while the tangent or cusp seam stays open
  registered: 2026-09-27
  status: open

hunch: complementary-means-union-six
  claim: C-T-TAN holds for disjoint types of sizes (2, 4), so four-colour vertices belong in the exception list
  basis: read
  falsifier: a step of C-T-TAN's proof (TS stage 4) that uses `|P(u)| = 3` beyond the union
  registered: 2026-09-27
  status: confirmed (by: `plans/FS106-TS-derivation.md` stage 4, C-T-TAN row — "(all six classes are in `P(u) ∪ P(v)`)" is the only use)

### 1.8 The card for the planner

question: which-types-and-which-pairs-does-q-rule-read
  evidence: the stub's § Types leaves essential against closure open; C-T-TAN's proof uses `|P| = 3` only via "all six classes are in `P(u) ∪ P(v)`" (TS stage 4); on a map in `𝓜_K`, B_u ∩ B_v = ∅ is exact at every scale (§1.2)
  expected: Q-rule stated on essential three-sets, as the stub and K-C6 have it
  ask: should Q-rule be stated exactly on the map — closure types, "complementary" meaning disjoint with union all six, and `B_u ∩ B_v = ∅` at positive scale — with C-T-TAN's blow-up as its first-order shadow?
  if yes: cusps merge into the tangent seam, (2, 4) pairs and four-colour vertices enter the list, and the seams left are the double unit-arc seam, the bowtie and the bicycle
  if no: the cusp stays a GAP by construction and four-colour vertices are an unlisted escape, so a NO cannot be complete (G21)
  answered by: derivation (the planner FS110-P decides)
  cost: one paragraph of the claim list
  hunch: yes — the limit in `𝓜_K` is a map, and the blow-up reads less than the map holds
  falsifier: a vertex configuration in `𝓜_K` that the exact positive-scale rule admits and the essential-type rule forbids
  rank: 1

## Stage 1 — SAVED

## Stage 2 — SAVED: advice to the planner (SendMessage to FS110-P, about 09:20 UTC)

Sent in full to FS110-P. The points, in short:
- **Types.** Define `P_ess(u)` (colours of positive upper density at `u`) and `P_cl(u)` (colours of tiles whose closure contains `u`); `P_ess ⊆ P_cl`,
  equal off zero-angle tiles. State Q-rule on `P_cl` with the exact form `B_u ∩ B_v = ∅` (A-EXACT); C-T-TAN is its first-order shadow.
- **Complementary** = `P(u) ∩ P(v) = ∅` and `P(u) ∪ P(v)` all six (A-SIX): (2, 4) pairs and four-colour vertices enter (beside the planner's fifth
  vertex kind, bichromatic degree `≥ 4`).
- **Seams:** (1a) one-sided tangent or `κ ≠ 1` — closed by the sketch; (1b) the double unit-arc seam — live, Y's tangent object, a unit rhombus of
  vertices `u w₀ v w₀′`; (2) bowtie / strong escape; (3) cusp — reduces to (1) on closure types; (4) the bicycle = C-T-BIKE (A-CIRC); (5) four-colour
  and bichromatic `≥ 4` vertices; Act One separate.
- **Killing tests:** V-C5's own (predicted to fire in band form); a separate claim C-TAN-POS with the falsifier in §1.7; a formula arc 3-colouring of
  the bicycle, checked exactly; Act One's falsifier a tight map with locally intersecting junction types and no same-type pair in `(1, 2)`; the
  hexagonal seven-colour control and a known-REJECT control before any YES verdict.
- **Contest:** seam by seam, N against Y; fix the exact local calculus in the claim list before either side starts (G51's cost window); Y may start
  where the index dies (a unit-arc interface facing a bowtie), N at Act One and the bicycle, neither told the other's start; a fresh competition
  advisor, this record its carry-forward.
- **Fences:** rule 13's trio; the other side's record and directory; both advisors' records — **this one included, §1.4 being a route**; the close
  inventory; `data/fs110/reports/`; the owner's scripts; other jobs' briefs; `git log -p` on fenced paths; blind verifiers statements-only and fenced
  from the plan's §G and §IQ as well, so C-TAN-POS gets a second mind blind to my sketch; neutral subjects; content-free hand-backs; worktree
  isolation the fallback.

## Stage 2 — SAVED
