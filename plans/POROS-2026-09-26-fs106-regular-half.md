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

## Stage 2 — SAVED (the planner's §G and reading, answered)

**Evidence.** FS106-P's message (2026-09-26, after its commit `5994764b`), received after stage 1 was written:
- its §G bears list;
- a G50 recognition: `[SokolovVoronov2025]` "already contains the exact-distance transplant of Voronov's method for maps";
- a reading, one mind: (REM) quantified D1 plus (COMP) M1's weak-* compactness give "χ_m⁰(ℝ²) ≥ 7 ⟺ limsup_{ε→0} µ₆(ε) < 1", with two
  routes, T-S (structural) and T-Q (stable Voronov).

**Scored.** Hunch `robust-voronov-is-the-cheapest-decisive-route` and the planner's T-Q were reached independently: my stage 1 was saved at
`d8a6ec5f`, before the message arrived. That is two minds on one route, and an equivalence on the planner's side where I had only
sufficiency. The hunch is re-stated, not confirmed; a convergence is not a derivation.

**Sent to FS106-P** (SendMessage, one message):
- REM's band half TRUE with `η < 1/48` (one mind).
- REM's density half TRUE in the CP form only; named step: "the origin is almost surely a density point of its class".
- COMP's named step: band-properness is weak-* closed in spectral form, because the Fourier transform of `1_A` lies in `C₀`.
- The attack on T-Q: the deleted set can swallow every trichromatic point, as SV §9's vertex excision shows. The claim "six band-proper
  colours plus a free seventh of density ≤ δ" needs Lemmas 2.2 and 6.1 with holes; that is T-Q's named step.
- My stage-1 points (A1–A5; Townsend's unit-arc counterexample).
- SV Lemma 1 a.e.: expected to hold for C² interfaces by a second-order test, (2κ_x−1)(2κ_y−1) ≥ 1 for one colour and the reverse sign
  for the other (one mind).
- Verbatim statements for the claim list.
- The fences.

```
hunch: stable-voronov-needs-lemma-6.1-with-holes
  claim: the only obstruction to T-Q is that a vanishing-density defect set can contain every trichromatic point; a version of Voronov's
         Lemmas 2.2/6.1 in which holes count as a free colour closes it
  basis: derived (SV §9's excision of vertex neighbourhoods; Voronov's proof is driven entirely by trichromatic points and bicycles)
  falsifier: a proof of T-Q that never locates a trichromatic point, or a band-proper six-colouring plus a free colour of density → 0
  registered: 2026-09-26
  status: open
```

## Stage 3 — SAVED (the claim list reviewed; one slip of mine)

**Slip (mine, logged for the owner).** I sent FS106-P a "review of data/fs106/claims.md" in the same tool round as my first read of the file.
It was written before reading the list:
- its claim ids (C-SV2, C-TIGHT-BIKE, C-REM, C-TQ, C-A1, C-D1) were invented;
- its descriptions of the planner's wording were invented;
- it said "fences fine as written" about fences I had not read.

I retracted it in full in my next message and sent a review of the actual list (be4359b0). The planner had already applied parts of the
invented review in 8816b4b9: the C-T-L1 split, the circle-colouring fact, η unprinted, the hole wording, and the "only use" half of C-CS-1.
Each of those matches a real claim and is sound on its merits, so nothing false entered the list; the provenance is still wrong. The
mechanism: two tool calls issued in parallel, one of which depended on the other's output. Rule for myself: a review is sent only after
the read has returned.

**The review that stands** (retraction message, the list read at be4359b0), each point one mind:
- **C-T-TRI is MISSTATED.** Counterexample: cusp junctions in a band-proper seven-colouring (A7). Fix it with the support multicolour.
  The cusp is a third exceptional configuration for the transfer, beside the bowtie and the unit arc.
- **C-Q-HOLE is MISSTATED.** Excising the features is cheap (A8b). The true easy lemma is A8a. The honest content of T-Q is a non-local
  obstruction.
- C-T-L1a: the second-order test (A9).
- C-Q-REM: print no constant.
- C-CS-2, C-AE-CLOSED, C-T-BIKE and C-Q-COMP(i): fine.
- Fences (plan §5.2, read at f31ae778): complete. They name this record and `data/fs106/fs106-a/` by path.

**Conceded.** A3 is FS-103's D1 from the other point (A3′). FS106-P is right; the claim needs no separate line.

```
hunch: cusp-is-the-third-configuration
  claim: in the measurable transfer, cusp junctions (a third colour of density 0 at a closure-trichromatic point) are an exceptional
         configuration of the same standing as the bowtie and the unit arc; no density-based kill sees them
  basis: derived (A7)
  falsifier: a kill step for C-T-PIG's configurations that uses only P, never P_supp, and survives a cusp vertex
  registered: 2026-09-26
  status: open
```

**Theorems this stage proved** (one mind each, [hand]): A7 (the density form of V-2.2 fails, by cusp junctions); A8a (holes of radius < ε/2
are invisible to Voronov's circle step); A8b (V-2.2 in the complement of a small defect fails; breaking Voronov's proof costs `O(ε²)` per
unit area); A9 (the second-order test). A3 is withdrawn as new: it is D1.

## Stage 4 — SAVED (wave 1: FS106-V against FS106-VB; stage 6 quote check)

**Read.** `plans/FS106-VB-verification.md` in full (stages 1–5), and `plans/FS106-V-verification.md` §2.1–§3.3 (stages 1–3). V worked
sighted; VB worked blind.

**Agreements.** Each was reached independently; each is one mind per side.
- Voronov: every claim is TRUE after local repairs, and the two found the same repairs.
  - Lemma 2.2's limit is taken after the hole fills. The repair for both is the chain of nested hulls with no recolouring.
  - Prop. 4.1's sign is reversed, and a swap must be excluded.
  - The bicycle needs `α < ε/2`, and the arc identification needs an argument (homotopy or additivity).
  - Lemma 6.1: "latter" should read "former", and the intermediate-value step needs writing out.
  - Prop. 3.3: "equal to 1" should read "greater than 1".
  - Prop. 3.4: recolour only the arcs.
  - Obs. 2.2 holds with the open band.
- C-CS-1 and C-CS-2 are TRUE: closedness is used once.
- S–V: SV-L1, SV-C2 and SV-C3 are TRUE.
  - Lemma 1's printed proof uses Obs. 1 (`x`'s own colour). Both give region-only proofs from Condition 5.
  - Both find that Lemma 1 is what replaces the band in Prop. 12: it excludes the swap.
  - Both place Condition 6 at Props. 9–10 (the bowtie).
- TW-81: no proof is printed, and the constant is π/3.

**Divergences.** Each is labelled as a real gap or a mismatch of statement or scope.
1. **Prop. 8 and Obs. 1 (a real gap for SV-2 as printed).**
   - VB grades it a GAP. The WLOG of Obs. 1 is unproved, and VB built a local counter-configuration.
   - V grades it TRUE with two repairs. One repair is the runs of sectors, a second defect VB missed. V also notes that case 2 of Prop. 7
     uses Obs. 1, and that a region-only variant must also recolour the old boundary segments inside the tip. That variant is unwritten.
   - The gap closes once it is written: a region-only proof also proves the everywhere form.
2. **SV-L4 (a real gap for SV-1; not for SV-2).**
   - Both find the last step unargued, and both repair it by hole fills, which are valid at exact distance for maps.
   - Only V finds step (a): "a trichromatic point within 1" fails as argued under Condition 6 alone, when bichromatic vertices of degree
     ≥ 4 occur. VB accepted it as "straightforward".
3. **Prop. 3.4 (a mismatch in diagnosis, same repair).** VB says the conclusion is false for the band. V says the hypothesis is unsatisfiable.
   Both can hold at once.
4. **V-1.2 (a mismatch of scope).** V's R8(iii): the theorem is stated for every 3-colouring, but the proof assumes finitely many bichromatic
   points; V repairs it by discretizing each circle. VB verified only the use V-1.1 makes of it.
5. **Row 40 (statement).** V: V-1.3 alone discharges row 40, because the cells are closed. VB: "the S–V half is not discharged". VB's
   sentence is true, but V's reading makes it moot.

**The two SV-L3 GAPs are one gap.** Both sit at the same step: the three-curve construction taken from Prop. 13 and Fig. 5.
- VB: the construction is unproved.
- V localizes it:
  - below √3 the construction holds, repaired by paths;
  - at √3 it degenerates [hand];
  - beyond √3 the relation graph is a bipartite 4-cycle [measured, float], so the printed figure cannot exist there.
- Both name the same repair route: Voronov's bicycle run on the curves `γ(u₁), γ(u₂)`. V sketched it; its transversality is unwritten.
- The gap is load-bearing, because SV-L4's pair ranges over all of `(1, 2)`.

**Quote check** (VB's stage 6 item, against `plans/FS103-M-derivation.md` §3.1):
- I-D1 and I-D2 are verbatim.
- I-D4 is verbatim, but its "…" drops the sentence defining `supp S_j`. VB used the source's meaning. I propose restoring that definition
  inside the quotation.
- D-SLACK uses the closed band where I-D4 uses the open one. This is harmless.
- I-CE is verbatim against D5. I also checked it against the Currie–Eggleton PDF: the "H … χ(G)" inconsistency is in the paper.
- D-NF's "held" sentence is the list's own wording (D1 at θ = 1), not a quotation. It is correct.
- I-D1 now has a blind second mind (VB), so its grade can read two minds.

**Hunches, read against wave 1 (not scored — neither record decides them):**
- `ae-polygon-holds`: supported. V finds every S–V step region-only, or with a region-only version.
- `tangent-2.2-names-SV-conditions`: supported. Condition 6 enters only at Props. 9–10. Without Condition 5, Lemma 1's leftover
  configuration is V's "each boundary through `x` contains an arc of `ω(y)`", which is A9's borderline.
- `bicycle-tight-is-3-colourable`: supported in basis. VB's control 3 finds that the step which dies without the band is the "no
  simultaneous change" of Prop. 4.1.
