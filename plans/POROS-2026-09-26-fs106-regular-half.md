# Poros — advising FS-106, the regular half (job FS106-A, 2026-09-26)

*Advisor's record. Brief: `data/fs106/briefs/A106-advisor.md` with `data/fs106/briefs/STANDING-RULES.md`. Planner: de Bruijn, job FS106-P.
Derivation sketches behind this record, fenced from every blind job: `data/fs106/fs106-a/derivations.md` (A1–A6).*

## Stage 1 — SAVED (expectation, written before any planner draft)

### Quotation check (standing rule 5)

The brief's quotations, checked against their sources: rule 0's *"From here on out, you may doubt your ability to tackle the difficulty
of the problems we encounter. Don't. You are capable, and you will surprise yourself."* matches `CLAUDE.md` § Counter-priors (a line break
after "encounter." hid it from a one-line grep); rule 4's *"A proven theorem about why its impossible is also valid. All novel knowledge
is a success."* matches `CLAUDE.md` item 23; rule 3's *"The intent of the ban is to eliminate the crutch …"* matches
`plans/PROTOCOL-crunch.md`. No discrepancy.

### Evidence inventory

- `[Voronov2023]` v3 (`library/pdf/arXiv-2304.10163-voronov.pdf`), read in full this stage — expected: a circle-topology proof whose
  closed-set use I could point to — surprised: yes, twice. Closedness is used once, as compactness giving a band (A1); the band is used in
  five places, and one of them is the engine: with one forbidden distance a unit circle is two-colourable (A2.5), so Thm 1.2's bicycle
  cannot be the tight engine as stated.
- `[SokolovVoronov2025]` (`library/pdf/arXiv-2502.01958-maptype.pdf`), §§1–5 and §9 read — expected: a polygon argument riding on local
  finiteness — surprised: yes. It is **Voronov's method already run with one forbidden distance** (Condition 1 is the single distance), and
  its hypotheses name the tight wall: Condition 5 (no boundary contains an arc of a unit circle) and Condition 6 (no trichromatic vertex of
  degree ≥ 4). Its Question 2 asks exactly whether seven survive without them; §9 says the band is recoverable off an `Ω(ε²)` area without
  unit arcs and only off `Ω(ε)` with them, and that a uniform bound `μ*₆ < 1` on the band-properly six-colourable fraction would give
  `χ_map = 7`.
- `[Townsend1981]` (`library/papers/townsend-1981-…pdf`, two pages, read in full; it landed today) — expected: a proof of six for maps —
  surprised: yes. It is a two-page note with **no proof** ("about two hundred lines of argument"), whose content is a counterexample to
  `[Woodall1973]`'s key assertion, and the counterexample is built from an arc "of unit radius centre `a`" — a unit arc. The map ≥ 6
  theorem's history is the tight wall's history.
- `CLAUDE.md` § The aim, § Counter-priors; `plans/STUB-regularity-wall.md`; `LEDGER.md` rows 120–130 — read against: the stub's link 4
  ("An almost-everywhere-proper colouring with slack needs seven outright") and link 5 (the normal form) — surprised: at link 4 only in its
  quantifier (A6).
- `[Thomassen1999]`, `[Townsend2005]`, `[Pritikin1998]` — unread (unheld); `[Woodall1973]`, `[Coulson2004]`, `[Falconer1981]` — held,
  unread by me.

### The expectation

**1. Where Voronov's argument uses closed classes, and what a density-open replacement needs.**
Thm 1.3's proof uses closedness exactly once: compactness turns "no class realizes 1 on the radius-3 disc" into "each class avoids a band
`[1−ε, 1+ε]`" (A1). Everything else is Thm 1.1, and Thm 1.1 consumes the **band**, never closedness: the tile discretization (Prop. 2.1,
which is where all the topology comes from — finitely many bichromatic points, polylines, simply connected regions, discrete trichromatic
points), the open set of equidistant points in Prop. 2.2, the transfer "`x` trichromatic ⟹ `T_1(x)` avoids all of `C(x)`", and the small
rotation in the bicycle lemma (A2). So *the closed-set step* the claim list must name is **compactness ⟹ band** (plus, for Thm 1.1, the
tile discretization it licenses), and the measurable question is not "closed versus density-open" but **band versus no band**.
A density-open replacement needs three things, none of which is the band:
- **(R1) an asymptotic band** — held in its simplest form: at a density point of its colour the colour has density → 0 on thin annuli
  about the unit circle (A3, one mind). It fails exactly on the essential boundaries, where the method lives.
- **(R2) a tangent-level multicolour.** Voronov's multicolour (colours in every neighbourhood) becomes "colours of positive measure in every
  neighbourhood", and its content at the circle is carried by **tangent partitions**: the unit-distance relation between neighbourhoods of
  two points at distance 1 blows up to "same projection onto the joining direction". Voronov's Prop. 2.2 survives in tangent form iff the
  intersected projections have positive length on both sides (A5), and the configurations where it fails are exactly the two conditions
  Sokolov–Voronov had to assume: the degree-4 trichromatic **bowtie**, and a boundary **curving with a unit circle**. Pointwise, touching is
  free (the cone pair, A4).
- **(R3) a topology of components that ignores null sets** — for finite-perimeter classes this exists: indecomposable components, holes and
  the Jordan-boundary theorem for simple sets of `[AmbrosioCasellesMasnouMorel2001]` (recalled, not read) are Voronov's Obs. 2.2 and
  polylines in measure-theoretic form. Without finite perimeter I know no replacement.

**2. Whether the almost-everywhere forms hold.**
- *Slack, a.e.:* holds — high. Name the step the one-line proof skips (A6): which measure the a.e. is in, and positive-measure colour choice
  per tile.
- *Closed, a.e.:* the naive form (closures realize 1) is false and says nothing (A4; hexagons of diameter exactly 1, seven colours). Its
  correct form is **open classes, boundaries free** — a tight question, not a corollary; it is the first honest target.
- *Nice maps, a.e.:* holds — medium-high: Thomassen's strict separation is, on compacta, a band again (A1's argument), so Voronov applies
  locally. To check on reading `[Thomassen1999]`.
- *Polygons and SV Thm 1 (fa + 3col), a.e.:* I expect them to hold — medium. At the tangent level the new tight touchings a free boundary
  allows are cone–cone and curvature-borderline ones (A4, A5), which polygons and Condition 5 exclude; the points to check are SV's
  Lemma 1 and Props. 3–5, which colour boundary points.
- *Maps (six), a.e.:* holds — medium, but its everywhere form is itself shaky in print: Woodall's proof was refuted by a unit arc and
  Townsend's fix is unpublished in 1981; it rests on `[Townsend2005]` and `[Coulson2004]`. Verify before building on it.

**3. The most promising way through the wall.**
The wall is already named in print in its regular form: **`[SokolovVoronov2025]` Question 2** — seven for locally finite maps whose
boundaries may be unit arcs and whose trichromatic vertices may have degree ≥ 4. The measurable question contains it (a tight map is a
density-open colouring), and the two obstructions the tangent computation finds are its two conditions. So the order that aims at the
answer:
1. **Q2 first, in the a.e. setting, where Voronov's topology is intact.** Either the bowtie and the unit arc can be excised (recoloured
   locally, as SV §5 does for polylines) — then the method runs on every tight map — or one of them is a genuine saving, and a map built
   around unit arcs or bowtie vertices is where a six-colouring would have to live (FS-107's builder starts there; Woodall's refuted
   assertion is the first such local object in print).
2. **Robust Voronov** — SV §9's `μ*₆ < 1`, in its measurable form: a lower bound, linear in `ε`, on the density of monochromatic pairs at
   distances in `[1−ε, 1+ε]` in every measurable six-colouring. Every a.e.-proper colouring has that density `o(ε)` (continuity of the
   pair-correlation in the distance), so a linear bound gives `χ_m⁰(ℝ²) = 7` with no regularity at all. This is the one route that
   sidesteps both unit arcs and wildness; its content is a stability version of a topological argument.
3. **Regularity**: finite perimeter for some optimal CP colouring (the stub's link 6), then (R3) and the tangent analysis on its reduced
   boundary. This is the route where a wild colouring would show itself as infinite perimeter; FS-107's R and W meet at the question
   "must an a.e.-proper six-colouring have infinite perimeter density?".

### Hunch ledger

```
hunch: bicycle-tight-is-3-colourable
  claim: with the single forbidden distance 1, T_1(u) ∪ T_1(v), 1 < |u−v| < 2, has a proper 3-colouring by finitely many arcs
  basis: derived (A2.5: each circle alone 2-colours; Prop. 4.1's index bookkeeping and the α-rotation both use the band)
  falsifier: a derivation that every arc 3-colouring of the tight bicycle has a monochromatic unit pair
  registered: 2026-09-26
  status: open

hunch: tangent-2.2-names-SV-conditions
  claim: the tangent form of Prop. 2.2 fails only at bowtie tangents and at unit-curvature interfaces (A5), and nowhere else
  basis: derived (A5, blow-up level only)
  falsifier: a tangent configuration at trichromatic u with I_u of positive length where the curvature term still permits a completion
  registered: 2026-09-26
  status: open

hunch: ae-polygon-holds
  claim: SokolovVoronov Thm 2 holds with boundaries free (a.e.-proper polygonal colourings need seven)
  basis: analogy (A4, A5; polygons have no unit arcs)
  falsifier: an a.e.-proper polygonal six-colouring, or a step of SV's proof that colours a boundary point and has no a.e. substitute
  registered: 2026-09-26
  status: open

hunch: robust-voronov-is-the-cheapest-decisive-route
  claim: a linear-in-ε lower bound on monochromatic band-pair density for measurable six-colourings is provable by stabilizing Voronov's
         argument, and gives χ_m⁰ = 7 without any regularity
  basis: prior (SV §9's remark; the o(ε) fact is derived)
  falsifier: a measurable six-colouring with monochromatic band-pair density o(ε) along a sequence — which is itself a tight colouring's shadow
  registered: 2026-09-26
  status: open
```

### Cards for the planner

```
question: which-regular-hypothesis-does-the-method-consume
  evidence: `[Voronov2023]` v3 p. 14 — closedness used only for the limit pair (x*, y*) ∈ A_i; the band used in Prop. 2.1, Prop. 2.2, §3's
            first paragraph, §5's α-rotation (A1, A2)
  expected: the stub's framing, "closed classes" as the regular class the method needs
  ask: should the claim list name "compactness ⟹ band" as the closed-set step, and state the heart question as band versus no band?
  if yes: the method transfer is posed as "Voronov without a band", with SV Condition 1 as the prior instance of it
  if no: the plan hunts a topological use of closedness that the proof does not make, and FS-107's target is mis-named
  answered by: FS106-P
  cost: one paragraph of the claim list
  rank: 1

question: is-SV-question-2-the-first-target
  evidence: `[SokolovVoronov2025]` Conditions 5–6, Question 2, §9; `[Townsend1981]`'s unit-arc counterexample to `[Woodall1973]`
  expected: the tight wall to be new with the measurable setting
  ask: should the plan's first derivation target be SV Question 2 in its a.e. form, before density-open classes?
  if yes: the method is pushed where its topology is intact and the obstruction is already localized to two configurations
  if no: the plan meets the same two configurations inside the measurable argument, without the map's topology to handle them
  answered by: FS106-P
  cost: re-ordering two phases
  rank: 2
```

### Would have searched here

- A SAT/CSP search for a proper three-colouring of a discretized tight bicycle (to test hunch `bicycle-tight-is-3-colourable`) — instead
  registered it as a derivation claim for the plan.
- A search for tight map six-colourings with bowtie vertices or unit-arc boundaries — instead named as FS-107 W's starting material.

### Theorems this phase proved

- A1, compactness ⟹ band for closed classes on a compact set; Thm 1.3's only use of closedness — [hand, one mind; classical] —
  `data/fs106/fs106-a/derivations.md` §A1.
- A3, density exclusion: a density point of a unit-avoiding measurable set sees only density-zero points of it at distance 1 — [hand, one
  mind] — §A3.
- A4, the cone pair: one colour, density-positive points at distance 1, no unit pair — [hand, one mind] — §A4.
- A2.5, the unit circle is two-colourable with one forbidden distance — [hand; elementary] — §A2.
- A5, tangent Prop. 2.2 and its two exceptional configurations — [hand, one mind, blow-up level only] — §A5.

### Proposed `BIBLIOGRAPHY.md` rows (for the close)

- `[AmbrosioCasellesMasnouMorel2001]` L. Ambrosio, V. Caselles, S. Masnou, J.-M. Morel, *Connected components of sets of finite perimeter
  and applications to image processing*, J. Eur. Math. Soc. 3 (2001) 39–92 — recalled, not read; unheld. Role: (R3).
- `[Townsend1981]` — reading status: read in full 2026-09-26 (FS106-A); it contains no proof; its content is the unit-arc counterexample
  to `[Woodall1973]` and the announcement of a lemma on finitely disconnected unit annuli.
