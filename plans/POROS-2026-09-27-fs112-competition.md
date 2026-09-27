# Poros — FS-112 competition advisor record (job FS112-A2)

*Poros (Opus 5.5), 2026-09-27, competition advisor of FS-112, the unit-arc half, beside the proof side FS112-N (agent `a46c8569ab2f7de52`, record
`plans/FS112-N-proof.md`) and the construction side FS112-Y (agent `a150ea46ef684fdcd`, record `plans/FS112-Y-construction.md`). Brief:
`data/fs112/briefs/A2-112-competition-advisor.md`, with `data/fs112/briefs/STANDING-RULES.md`. HEAD at launch: 799131a2. Working directory
`data/fs112/fs112-a2/`. **This record is fenced from both sides and from every blind verifier of FS-112** (it carries hunches, expectations and both
sides' pre-round answers; `plans/PROTOCOL-competitor-and-advisor.md` §1 rule 1).*

## Theorems this phase proved

*(none — an advisor's record. The one-line derivations below are hunches with basis "derived", handed to nobody as results.)*

## Would-have-searched-here log

- (stage 1) Would have scanned T2's free ray angles for a four-colour vertex carrying six resolved arcs, to price `h-four-colour-crux` before writing
  it down. Instead: the expectation names the obstacle (the arc-end constraint, below) and leaves the realisation to the construction side, by formula.

## Fence log

- Not a blind job. My brief fences `plans/FS112-close-inventory.md` and `data/fs112/reports/`; **the owner's launch message directed me to read
  exactly items 10–16 of the inventory and `data/fs112/reports/FS112-PA.md`**, and I read exactly those (items 10–16 were printed by a filter on the
  item number; the table header, lines 1–8, came with them). Logged here because the brief's text and the owner's message differ.
- **2026-09-27, stage 3:** at the owner's direction (message after N's and NB's hand-backs) I read `data/fs112/reports/FS112-N.md`,
  `data/fs112/reports/FS112-NB.md` and `plans/FS112-NB-verification.md` (§ Theorems, § Fence log, stage 2 in full; stage 1 by its theorem table only),
  although my brief fences the verifiers' records and `data/fs112/reports/`. The construction side's stage 2 and report are **not** read (the owner:
  "Keep the construction side's material to the construction half"; YB is still running).
- The owner lifted the §5.3 fence for both sides after stage 2b (owner's message; identical words to each side).
- Read otherwise: my brief's list; `plans/FS110-derivation.md` §1 (l. 1–120) and its list of §§2–4 statements; `plans/FS110-NB-verification.md`
  §2.3–2.6 (NB-4's derivation, l. 157–200); `plans/FS110-Y-construction.md` by grep for T2 (its types, l. 413–440).

---

## Stage 0 — SAVED: quotation check (standing rule 5)

| quotation | source | verdict |
|---|---|---|
| rule 0: "From here on out, you may doubt your ability … You are capable, and you will surprise yourself." | `CLAUDE.md` § Counter-priors (disk) | verbatim |
| rule 3: "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time" | `CLAUDE.md` § Toolchain | verbatim |
| rule 3: "search for a finite graph is out. It would be huge, not feasible." | `CLAUDE.md` § Publication | verbatim |
| rule 4: "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | `CLAUDE.md` § Where the problem stands, item 23 | verbatim but for a closing period the source does not have inside the quotation |
| rule 10: "It's ok if jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress." | `plans/CONSOLIDATION-2026-09-27.md` l. 75, item 20 | verbatim |
| my brief: the hand-back sentence; "(G51: zero retractions means the disagreement has not started)" | G51 on disk: "zero is not agreement, it means the disagreement has not started yet" | the second is a paraphrase outside quotation marks, faithful |
| claims §4 YB-V5X's rider "Rests on it: C-V5-K in the unit-arc half." | `plans/FS110-derivation.md` l. 202 | verbatim |

`CLAUDE.md` was read from disk (last changed at df120f6b): G17 l. 554, G71 l. 1468, G79 l. 1584, G82 l. 1593, G51 l. 1603; § The aim's link 2 now carries
`[GwynStavrianos2022]`, which my context's snapshot lacked. No quotation in my brief fails.

## Stage 0 — SAVED

---

## Stage 1 — SAVED: my expectation, written before either side's first card (brief item 1)

### 1.1 The frame on five axes, and what changed from FS-110

- **Object.** The same maps as row 134 with one thing let back in: a boundary arc `α ⊂ ω(P)` of radius 1. Such an arc breaks Condition 5 on exactly one
  circle, `ω(P)`. So "a step survives unit arcs" is a statement about **which circles the step reads** (claims §3's question).
- **Question.** Q-full (a map) and Q-full_K (bounded `K`, the form W-EQ-K consumes), kept apart.
- **Discipline.** Row 134 was map colouring (Woodall's degree reduction, S–V's Cor. 1) plus Voronov's circle topology. With every seam realised locally
  and exactly (S1, T2, BB, MX), a local lemma cannot refute the object on the region those fragments cover. The question has become **global
  consistency of local configurations that each exist** — the tiling-theory shape (a NO by a propagation or a count, a YES by a periodic
  construction). This is the planning advisor's reading, and I adopt it.
- **Audience.** `[SokolovVoronov2025]` Question 2 and `[Polymath2021]` p. 199, posed in print; Polymath16 threads 6–9 and 16 worked it informally
  (`plans/FS112-PA-reading.md`).
- **Product.** A NO, a YES, or the first break of the chain with its configuration. Everything else is a rung.

### 1.2 The obstacles, per side (named, not priced)

**The proof side (NO).**
1. **The architecture, not a step.** Row 134 ran: no four-colour vertex (NB-4) → reduce to a cubic map (W-MERGE, the N4 chain, N4-TERM) → S–V
   Cor. 1 on the cubic map. With unit arcs, four-colour vertices exist locally and exactly (T2's `P(w) = {1, 3, 4, 5}`,
   `plans/FS110-Y-construction.md` l. 413–440). Merges act within one colour: they reduce sectors, never colours. So a four-colour vertex ends the
   reduction at degree at least 4, and **N4-TERM's "every vertex is cubic" fails there even if every N3 and N4 step survives**. The cubic conclusion
   was never N4-TERM's own; it imports NB-4 (K-TIGHT, `plans/FS110-derivation.md` l. 43: NB-4 "Rests on it: NB-5; the N4 chain at every stage"). The
   base (C-CHAIN-13, "for curved cubic maps") then has no input. So the NO needs one of two things: a global exclusion of four-colour vertices (the
   arc budget, C-UA-BUDGET), or a Cor. 1 that tolerates four-colour unit-arc centres.
2. **The local positives.** The strip (height `√15/2 + √3`) and the disk (radius `≈ 2.12426`) are valid six-colourings with the tactic. Any lemma
   whose support fits inside them is refuted by them. Row 134's only unbounded step was N4-PROP's bi-infinite line; a unit-arc NO needs a new global
   step (C-BEYOND), or an explicit radius (C-LOCAL).
3. **Act One.** Row 134 went round it through the degree reduction. If the reduction stops at four-colour vertices, the detour may close.

**The construction side (YES).**
1. **The arc ends.** Each end `x` of a unit arc of `ω(P)` is at distance 1 from `P`, so `ω(x)` passes through `P`. Then every colour of `P_cl(x)` is
   forbidden on tile-interior points of `ω(x)` near `P` (A-CIRC): `P`'s sectors of those colours must not straddle the tangent of `ω(x)` at `P`. Each
   arc therefore adds two tangent lines at its own centre. An arc-closed fragment (C-ARC-END) must meet these constraints at every centre and at every end.
   FS-110's fragments all leave the ends open.
2. **Extension.** Polymath16 found the strip and the disk and could not extend either. Sirgedas's reason for the strip is in words only (`[16.347]`, "A
   triangle can't be added because all 6 colors are within two “steps” of the new vertex").
3. **The checker.** An exact tile checker's suspect verdict is ACCEPT (a missed pair makes acceptance easy). The strip needs ℚ(√3, √5) and the disk a
   nested radical, so no frozen checker can accept either.

### 1.3 The chain walk: my expectation step by step, with the circles I believe each step reads

"Centre" means a unit-arc centre. "Holds off centres" means the step's proof holds verbatim at every vertex none of whose read circles is `ω(P)` for a
centre `P`. This table is my expectation only; the sides do not read it.

| step | circles read (my reading) | expected verdict |
|---|---|---|
| 1 NB-4 | `ω(v)` (the ring); `ω(y_k)` for the six change points (the first step at `y_k`, `|P_cl(y_k)| ≤ 4`); `ω(y_{k±1})` near `y_k` | **fails**, realised by T2's `w`. See 1.4 on the printed form |
| 2 NB-5 | `ω(u)`, `ω(v)` near `w₀`; `ω(w₀)` near `u`, `v`; everything NB-4 reads at `w₀` | **fails**, realised by S1 (centre `u`) and T2 (centre `w₀`) |
| 3 N3-CONF | `ω(v)` | **holds off centres; extends at centres** — an arc contact is a family of contacts all of one type, and N-E2's half-plane holds for each |
| 4 W-MERGE | `ω(v)`, and `ω(v′)` for vertices `v′` at distance `1 ± ρ` | **holds**, with "Condition 5 kept" read as "no new unit arc" |
| 5 N3-DEG | `ω(v)` | **fails at centres**: an arc contact of angle `α` confines `D_c(P)` to a cone of opening `180° − α`, so `int D_c` can be empty with no horn ("arc cones") |
| 6 N4-SHADOW | `ω(N)`, `ω(S′)` (the antipodes), and the circle concentric with the flank arc | **fails when a flank is an arc of `ω(v)`** (radius-0 shadow); otherwise holds |
| 7 N4-SHAVE, 8 N4-STUCK | as 6, plus NB-4 at `v` for STUCK's degree count | 7 holds off centres; **8 imports NB-4** ("the vertex has degree 4") and fails at four-colour vertices |
| 9 N4-FIN | none (arithmetic) | **holds as written; its input can reach the endpoints**: a horn bounded by an arc of `ω(N)` has curvature exactly `±1`, where `f` and `f̃` have poles |
| 10 N4-TERM | through NB-4 | **existence holds; "every vertex is cubic" fails** at surviving four-colour vertices and at arc cones (obstacle 1 above) |
| 11 NB4-CS | through 5–9 | fails where 5–9 fail |
| 12 P17 | `ω(v)` at a three-sector vertex | holds off centres; at a centre the "purely rotating ring" is not defined (the ring carries an arc) |
| 13–17 the base | `ω(u)`, the pigeonhole endpoints' circles, and D1's (P′) `ω(y)` for points `y` near `x` | **the informative disagreement**: if a step reads `ω(y)` for `y` ranging over a curve, only finitely many `y` are centres, which is harmless in an a.e. argument; if it reads a named vertex's circle, a centre there breaks it. I expect the two walks to differ here |
| 18 headline | all | fails as a chain; the question is which break is essential |

**The first break in chain order is C-CHAIN-1, and it is nearly free (E1). The informative results are elsewhere:** at step 10 (the cubic conclusion's
import of NB-4); at step 5 (arc cones); at step 9's endpoints (unit arcs as horn flanks, centred at the antipodes — a Woodall cone whose antipodal
out-contacts become the tactic); and at the base's circle scope.

### 1.4 A reading of NB-4's printed exception, held until both walks are committed

The claim list marks NB-4's printed exception MISSTATED-suspect: "`ω(y_k)` cannot pass through `y_k`; likely a slip for `ω(v)`" (claims §2). My reading of
`plans/FS110-NB-verification.md` l. 164–171: the proof uses `ω(y_k)` in the first step at `y_k` ("`|P_cl(y_k)| ≤ 4` (first step at `y_k`)", which needs
the one colour left on `ω(y_k) ∖ Γ`), so the `ω(y_k)` clause is that first step's hypothesis: **no `Γ`-arc on `ω(y_k)` anywhere**, not "through `y_k`". The
`ω(v)` condition is separate: it is N2-V4's own proviso on the ring (FS110-A3-HOLE). If so, the exception has three circle families — `ω(v)`, `ω(y_k)`, and
`ω(y_{k±1})` through `y_k` — and the suggested correction to `ω(v)` alone would drop one. Hunch `a2-nb4-three-circles` below. **I hold it:** sending it
before the walks commit would prime both at step 1. If neither walk states it, it goes to both sides at once as a card after both stage 1s are committed.

### 1.5 The planning advisor's hunches, carried and scored as they stand (`plans/POROS-2026-09-27-fs112-unit-arc-half.md` §1.7, §2.3)

| hunch | its claim, short | status now | my note |
|---|---|---|---|
| h-seams-two | T2's seam points are four-colour vertices; two seam species | open | supported by the read types: `P(u) = {1,2,3}`, `P(v) = {4,5,6}`, `P(w) = {1,3,4,5}`, so `(w, u)` is not a covering pair and `w` is on A4-SIX-ARCS's first branch |
| h-loc | each step holds verbatim off centres; every defect lies within distance 2 of a centre | open | **incomplete as stated**: a step can fail through an imported premise (step 10 through NB-4), not only through a circle it reads |
| h-arc-cone | W-MERGE survives; N3-DEG fails at centres | open | I share it |
| h-four-colour-crux | the first global obstruction is a four-colour centre's arc budget | open (0.6) | I share the object, not the mechanism: my obstacle is the arc ends' tangent lines at the centre (1.2), not a 360° overdraw |
| h-lattice | (S1) systems live on the triangular lattice | open | untested by anything held |
| h-no-local-kill | no NO confined to radius 3 | open (0.6) | C-LOCAL, E17 |
| h-discharging | the global step is a discharging count | open | a reading; the sides are not told |
| h-yb3-counter | YB3-SAME falls to a local counter-fragment | open (0.6) | ranked last by the plan |
| h-dial | an arc-closed patch beyond 2.124 or 3.668 by formula | open (0.3) | E6 registers 0.2 |
| h-answer-no | NO, at bounded `K` at least | open (0.85; a YES in-milestone 0.02) | an instrument, never evidence |
| h-arc-inert (narrowed) | inert arcs bend off isolated contact points | narrowed, one mind | ARC-INERT, E9 |
| h-nb4-slip | the printed `ω(y_k)` is a slip for `ω(v)` | open | **my reading (1.4) disagrees**: `ω(y_k)` is the first step's hypothesis; both `ω(v)` and `ω(y_k)` belong in the exception |

### 1.6 My hunches (registered 2026-09-27 22:05 UTC, before either side's first card)

hunch: a2-cubic-imports-nb4
  claim: N4-TERM's "every vertex is cubic" and N4-STUCK's "the vertex has degree 4" import NB-4, so both fail at four-colour vertices however the circles they read behave; the base then has no cubic input
  basis: read
  falsifier: a derivation of N4-TERM's cubic conclusion that uses no bound on the number of colours at a vertex
  registered: 2026-09-27
  status: open

hunch: a2-walks-miss-the-import
  claim: at least one of the two walks marks C-CHAIN-10 as holding (as written, or off centres) without naming its import of NB-4
  basis: prior
  falsifier: both walks name the import at C-CHAIN-10
  registered: 2026-09-27
  status: open

hunch: a2-base-scope-divergence
  claim: the two walks disagree on the base (C-CHAIN-13 to 17) about which circles it reads — a continuum of circles (centres harmless) against named vertices' circles (centres fatal)
  basis: prior
  falsifier: both walks give the base the same verdict with the same named circles
  registered: 2026-09-27
  status: open

hunch: a2-nb4-three-circles
  claim: NB-4's exception, corrected, names three circle families (`ω(v)`, `ω(y_k)` anywhere, `ω(y_{k±1})` through `y_k`); the claim list's suggested correction to `ω(v)` drops `ω(y_k)`
  basis: read
  falsifier: NB §2.3's first step at `y_k` holding with a `Γ`-arc on `ω(y_k)`
  registered: 2026-09-27
  status: open

hunch: a2-arc-contact-vertex
  claim: a unit-arc centre carrying a contact colour is a vertex (or a cusp), and that colour's tiles at `P` lie in a cone of opening at most `180° − α` (facing the arc for in-contact, facing away for out-contact), by N-E2 applied at every point of the arc
  basis: derived
  falsifier: an exact fragment with a contact colour at an edge point that is a unit-arc centre
  registered: 2026-09-27
  status: open (C-UA-WEDGE's first half; I expect it TRUE at two minds quickly)

hunch: a2-arc-ends-bind
  claim: the construction side's binding difficulty is the arc ends: each end `x` puts the tangent of `ω(x)` at the centre into the centre's sector constraints, so every added arc adds constraints at the centre it was added to help
  basis: derived
  falsifier: an arc-closed fragment in which every centre carries at least two arcs and no end constraint is tight
  registered: 2026-09-27
  status: open

### 1.7 What I will watch for (brief item 5)

1. A seam or contact kind outside claims §0 and §2 — a unit arc whose centre is not a vertex; an arc whose centre lies on another unit arc; a four-colour
   vertex that is a centre and also lies on a unit arc of another centre.
2. An ACCEPT that no plant could have turned into a REJECT (the pair count against the object's).
3. A local TRUE for an escape scored as a refutation of the NO.
4. A NO route whose steps all fit inside the strip (killing test 8).
5. A candidate map that is a seven-colouring in disguise (a class split into two colours whose union is a class of the hexagonal colouring).
6. A step's verdict that ignores an imported premise (1.3, step 10).

### 1.8 Evidence inventory

- `data/fs112/briefs/A2-112-competition-advisor.md`, `STANDING-RULES.md` — read against: FS-110's competition brief, with the new fence of §5.3 — surprised: no
- `data/fs112/claims.md` — read against: FS-110's list, with unit arcs — surprised: yes; C-CHAIN-10's statement carries its cubic conclusion without naming its import of NB-4
- `plans/FS112-unit-arc-half.md` §1.3, §G part 3, §PA, §IQ, stages 4–5 — read against: a plan whose registrations guess the break — surprised: no
- `plans/POROS-2026-09-27-fs112-unit-arc-half.md` — read against: the hunches the brief names — surprised: yes; h-nb4-slip reads `ω(y_k)` as a slip, which NB §2.3's first step contradicts (1.4)
- `plans/FS112-PA-reading.md`, `data/fs112/reports/FS112-PA.md` — read against: extracts with the disk's rule — surprised: yes; the rule is not printed, only the skeleton and the radius, and the disk has a `{1,3,5,6}` junction in de Grey's words (`[16.106]`)
- items 10–16 of the close inventory — read against: the rulings the owner named — surprised: no
- `plans/POROS-2026-09-27-fs110-competition.md` § A6-2, § A6-3 — read against: the hand-over — surprised: no
- `plans/PROTOCOL-competitor-and-advisor.md` §1 — read against: the rules I follow — surprised: no
- both side briefs — read against: identical but for § Your side — surprised: no
- `LEDGER.md` rows 131–134 — read against: row 134's chain as the claim list quotes it — surprised: no
- `plans/FS110-NB-verification.md` l. 157–200 — read against: NB-4's exception as the claim list quotes it — surprised: yes (1.4)
- `plans/FS110-Y-construction.md` l. 413–440 by grep — read against: T2's types — surprised: no
- `plans/FS112-N-proof.md`, `plans/FS112-Y-construction.md` — read against: two blind walks — surprised: unread (not yet written)

## Stage 1 — SAVED

---

## Stage 2a — SAVED: FS112-N's pre-round answer, registered verbatim (received 2026-09-27, after N's stage 1 at 46ad0ff7)

> FS112-N pre-round answer (stage 1 committed and pushed, 46ad0ff7).
> 1. Step: the construction side's "a four-colour centre" among the §6 killing tests (C-V4-K / C-UA-BUDGET), built arc-closed at the vertex's reading radius — the whole ring ω(v) plus flowers at its change points — as opposed to a flower of radius 1/10 at v.
> 2. Obstruction expected: under the corrected NB-4 (the "ω(y_k)" clause of NB l. 164 is vacuous and the |P_cl(y_k)| ≤ 4 bound is unneeded), a four-colour v needs either ≥ 60° (or ≥ six) unit arcs centred at v with no covering pair on its ring, or, in EVERY σ_v-orbit of change points, a unit arc of ω(y_{k±1}) through y_k — "both" kind at the ring point, whose wedges (TS-U as a shadow statement) push the ring colours e, f into opposite cones there. I expect those cone constraints around the six points and the arcs' ends not to close in a tight fragment.
> 3. What would show me wrong: an exact fragment, accepted by two checkers, covering ω(v) entirely (every point of the ring coloured or on Γ) with |P_cl(v)| = 4 — FS-110's T2 and BB are below that radius (BB carries four-colour w, w′ with no unit arc at all).
> Secondary, lower confidence: C-ARC-END for (S1) at both ends of the arc fails for the same reason at the ends' vertices (Y2-S1I item 4).

**Read against my expectation (for me only; nothing goes to Y).**
- N's parenthesis contradicts my held hunch `a2-nb4-three-circles`: N says the `ω(y_k)` clause is vacuous because the bound `|P_cl(y_k)| ≤ 4` is not
  needed. My quick reading of NB l. 164–171 says the bound does work: it gives each `y_k` exactly one inner and one outer colour. Without it, the inner
  half-arcs of `ω(y_{k+1})` and `ω(y_{k−1})` at `y_k` (directions 210° and 150° in NB's coordinates) could lie in two different colours `i ≠ i′`. Then
  `i ∉ P_cl(y_{k+1})` and `i′ ∉ P_cl(y_{k−1})`, and the alternation `{A, B}`, `{C, D}` is no longer forced. **Unresolved; a live disagreement.** I read
  N's derivation at the walk comparison, and it becomes a card only if Y's walk speaks to it too.
- N's third item names BB's four-colour `w`, `w′` "with no unit arc at all". This is consistent with NB-4, because BB's flowers are truncated below
  the ring's radius (`1/10`), so NB-4's hypothesis is never met inside the fragment. It is the same point as killing test 4's rewrite (open-ended
  fragments cannot fire).
- It overlaps `h-four-colour-crux` and `a2-arc-ends-bind`: the obstacle both N and I name is the cone constraints at the ring points and the arc ends.
  This overlap is not independent evidence; both of us read the same NB-4 text.

## Stage 2a — SAVED

---

## Stage 2b — SAVED: FS112-Y's pre-round answer, registered verbatim; the two chain walks compared (brief items 2–3)

### 2b.1 FS112-Y's pre-round answer (received 2026-09-27, after Y's stage 1 at 3fdae23d)

> FS112-Y's pre-round answer (stage 1 committed and pushed, 3fdae23d).
> 1. Step: C-UA-CHAIN (§IQ candidate (c)), the monotone quantity excluding bi-infinite chains of unit arcs, and with it any NO route shaped like N4-PROP/N4-FIN; next most likely, C-UA-BUDGET's second branch.
> 2. Configuration: [AxenovichEtAl2014]'s strip rebuilt from its printed words. Every midline vertex is a four-colour vertex of degree 4 that centres four unit arcs of kind "both". The arches' arcs form a bi-infinite periodic zigzag chain that is valid inside the strip, so no strictly monotone local quantity exists along it. The strip stops only at the upper common unit point of a close complementary pair (valley {1,3,5}, apex {2,4,6}, about 0.757 apart), which sits on its edge. So a NO needs a step that reads above height √15/2 + √3. The same object carries covering pairs at the midline vertices while the arcs sit on ω(v) itself (against the second branch as stated).
> 3. What would show me wrong: my stage-2 exact checker REJECTs the rebuilt strip; or the proof side's monotone quantity is shown to read beyond the strip, so that the strip's periodic chain does not meet its hypothesis.
> Grade: hand, one mind; the exact check comes next.

**The two answers point at each other.** N expects the construction side to fail at a four-colour vertex whose whole ring `ω(v)` is coloured. Y's
walk and answer claim such a vertex exists in print: the strip's midline vertex `P_1 = (1/2, 0)`, `P_cl = {1,2,4,5}`, whose unit circle lies inside the
strip (radius 1, below the half-height `≈ 1.834`). N's own falsifier is "an exact fragment, accepted by two checkers, covering ω(v) entirely … with
|P_cl(v)| = 4". **If Y's stage-2 checker ACCEPTs the strip, N's pre-round expectation is falsified at one checker, and at two once YB rebuilds it.**
Neither side knows this; it is the round's first scoring event.

### 2b.2 The walks compared (N: `plans/FS112-N-proof.md` §1.4 at 46ad0ff7; Y: `plans/FS112-Y-construction.md` §1.4 at 3fdae23d)

**Convergences, independent (neither side read the other):**

| step | both walks say | note |
|---|---|---|
| 1 NB-4 | the first break in chain order | N: (b), exceptions E1, E2; Y: (c), realised arc-closed by the strip. The labels differ; both say the step does not hold as written |
| 2 NB-5 | fails locally; (S1) and T2 are its exceptions | Y adds an arc-closed realisation in the strip (T2 at `d = √3`; `(V₀, A₁)` saved at `P_1`) |
| 3 N3-CONF | (a), with "finite" read as "compact" | same repair, two minds |
| 5 N3-DEG | (b); the exception is a horn curvature `κ = ±1`, a horn bounded by a unit arc centred at `N` or `S′`, out-kind | **my expectation (arc cones with empty interior) is killed** by N's argument, which Y's verdict matches: empty interior still needs antipodal contacts |
| 6 N4-SHADOW | (b); `C = 0` degenerates (a tile at `N` beyond an arc of `ω(v)`) | N: a wedge (N112-U1); Y: the cone within 90° of the arc, `f(−1) = −∞`. Same object, two descriptions |
| 7 N4-SHAVE/FLANK | fails at `κ_+ = 1`: an in-type flank contact at `N` is no longer excluded, so FLANK's shadow list is incomplete | two minds, independent |
| 8 N4-STUCK | its (iv) fails with a unit arc of `ω(v)` through `N`; inherits NB-4 | N labels it (b), Y labels it (c) as a GAP; the substance is the same |
| 9 N4-FIN | (a), and not where the chain breaks | **two routes**: N excludes the closed ends along a stuck chain (N112-END); Y lets the curvatures reach `±1` and ends the chain by the same count |
| 10 N4-TERM | existence holds; **"every vertex is cubic" inherits NB-4 and fails** | Y exhibits a terminal non-cubic object, the strip (if valid). **My hunch `a2-walks-miss-the-import` is killed: both walks name the import** |
| 12 P17 | (b); the exception is a unit arc of `ω(x₂)` through `x₁`; N2-HEX's pure rotating ring is live again | the contact kinds differ (below) |
| 18 headline | the proof does not transfer; Q-full is open | — |

**Divergences (each checked against both texts):**

| # | step | N's walk | Y's walk | kind |
|---|---|---|---|---|
| D1 | 1 NB-4, the corrected exception | "if in one `σ_v`-orbit of change points no arc of `Γ` on `ω(y_{k±1})` passes through `y_k`, then `|P_cl(v)| = 4` is impossible"; the bound `|P_cl(y_k)| ≤ 4` "is not needed"; "It is not a slip for `ω(v)` either: an arc of `ω(v)` through `y_k` is already excluded by `y_k` being a change point"; arcs on `ω(v)` are a separate exception (E1) in the walk table | "an arc of `Γ` of `ω(v)` or of `ω(σ_v^{±1}y)` through a change point `y`, or an arc of `ω(y)`, in every orbit"; the strip's apex orbit escapes by "the arc of `ω(v)` ending at `A₁`" | **truth**: whether an arc of `ω(v)` *ending* at a change point, and an arc anywhere on `ω(y_k)`, belong in the exception. N's "through" does not exclude "ending at". This is also my held hunch `a2-nb4-three-circles` (Y's form contains my three families) |
| D2 | 4 W-MERGE | (a): "New arcs have radius `ρ < 1`; unit arcs inside the recoloured gap are deleted" | (b), GAP at "for every other vertex `v′`, `D_c(v′)` is unchanged" when `v` lies on a unit arc of `ω(v′)` bounding a sector of the recoloured gap, `c ∈ P_cl(v′)` | **truth** (a side condition; termination unaffected by Y's account) |
| D3 | 7 N4-RAY | (a): "the middle region's boundary curvatures lie strictly inside `(−1, 1)` even when the outermost are `±1`" | fails "when a stack boundary or `M`'s boundary is a unit arc (the circle can run along it)" | **truth** |
| D4 | 13–17 the base | reads `ω(u)`, `ω(u + e)` for arcs leaving `u` (D2's strip), and `ω(y)` for every pair `(x, y)` at distance 1 the chain uses; exceptions (B1) inert arcs of `ω(u)`, (B2), (B3); fatal or repairable: GAP | reads the pair's circles and the bicycle's; holds "off pairs with a unit arc centred at `u` or `v` (any kind)" | **scope**: which circles the base reads. **My hunch `a2-base-scope-divergence` is confirmed in shape**, not in its predicted mechanism (the split is "the pair's circles" against "the pair's and the partners'", not "a continuum" against "named vertices") |
| D5 | 12 P17 | the arc at `x₂` is **both** (`s_in = q`, `s_out = g`, both in `P_cl(x₂)`: Polymath's tactic at the ring points) | out-contact for `g` | kind (minor) |
| D6 | 1 NB-4, the held positives | "FS-110's fragments are below NB-4's reading radius and cannot test it"; the strip is not read at step 1 | the strip's midline vertex refutes any argument confined to `B(v, 1.834)` excluding a four-colour vertex | **scope of the evidence**: N's step-1 verdict does not read CAL-STRIP, the one held positive at that radius |

**Outside the walks, from Y's stage 1 (for the owner; nothing to N):** Y claims **C-UA-BUDGET's second branch as stated is FALSE** — the strip's `P_1`
has a covering pair on its ring (`(P_1, P_2)`, `P_2 = (3/2, 0)`, `{1,3,4,6}`, distance 1, union `[6]`) and yet its arcs lie on `ω(P_1)` itself (total
`≈ 62.1°`), not on `ω(σ^{±1}P_2)` through `P_2`. So the two branches of A4-SIX-ARCS are not exclusive, and the second branch's "not at v" fails. It rests on
the strip's validity (Y's stage 2). It is also a contact configuration outside claims §2's dichotomy (brief item 5): a four-colour centre carrying a
covering pair and its own arcs at once.

### 2b.3 Hunches scored (mine; the planning advisor's in the next line)

- `a2-cubic-imports-nb4` — **confirmed** (by: both walks' row 10, independent; Y adds the strip as a terminal non-cubic object, pending stage 2).
- `a2-walks-miss-the-import` — **killed** (by: both walks name the import at C-CHAIN-10). My prior underrated the walks.
- `a2-base-scope-divergence` — **confirmed in shape, killed in mechanism** (D4).
- `a2-nb4-three-circles` — **open, now a live divergence between the sides** (D1); Y's corrected form agrees with mine, N's derivation contradicts its `ω(y_k)` part.
- `a2-arc-contact-vertex` — **confirmed by derivation** (N112-U1, one mind; Y's row 3 cones agree).
- `a2-arc-ends-bind` — **weakened**: the strip closes every arc's ends inside itself (Y, pending stage 2). Open at the plane's scale.
- My stage-1 expectation at step 5 ("arc cones", `int D_c` empty with no horn) — **retracted** (killed by N's derivation, matched by Y's verdict). A free retraction.
- Planning advisor: `h-arc-cone`'s N3-DEG half **killed** as mine was; its W-MERGE half open (D2). `h-seams-two` **supported** (Y: T2 at `d = √3` with
  four-colour seam points, arc-closed, pending stage 2). `h-loc` stands as both walks' shape, with Y's D2 GAP as a possible non-local leak (a merge changing
  `D_c(v′)` at a distant centre). `h-dial` and `h-no-local-kill` untouched.

**Retractions so far:** A2: 1 (step 5). N: 0. Y: 0. The sides have not yet met any claim of the other's; D1–D6 go to both as one card.

### 2b.4 Card sent to both sides at once, identically (`data/fs112/fs112-a2/card-walks.md`)

The card names D1–D5 at claim level and asks each side to re-examine its verdict. It gives no derivation or construction of either side. D6 goes as a
generic instruction to read every held positive at each step's reading radius, which the construction side has already done and which killing test 8
requires of the proof side anyway. The C-UA-BUDGET item stays with me until Y's stage-2 check.

## Stage 2b — SAVED

---

## Stage 3 — SAVED: the proof half at N's and NB's hand-backs — every divergence and its settlement, the registrations scored, round 2's aim (brief item 6, proof half)

*Read: `plans/FS112-N-proof.md` stage 2 (§2.1–2.6, at 74f0b705) and its theorem table; `data/fs112/reports/FS112-N.md`; `plans/FS112-NB-verification.md`
§ Theorems, stage 2 (§2.1–2.5, at ebf3113e); `data/fs112/reports/FS112-NB.md`. Construction-side material stays in the construction half (stage 4, after YB).*

### 3.1 N against NB — every divergence, and how each settles

NB's stage 1 was blind (2cd9d152), and its stage 2 read N's record after that commit. The letter verdicts of the chain walk agree step for step:
(a) at 3, 4, 9 and N4-RAY; (b) at 1, 2, 5–8 and 10–17; (c) at 18. Both put the first break at C-CHAIN-1. The divergences are NB's table §2.3, rows
1–15, and each was checked against both texts:

| # | topic | settlement | who stands | grade after |
|---|---|---|---|---|
| 1 | N4-FLANK at `κ = ±1` | **fails**: an in-type flank tile at `N`, Siamese with the flank, shadows a band of the horn. NB's stage 1 said it survives; NB re-derived N's failure and conceded | N | two minds (N blind, NB sighted) |
| 1′ | **consequence NB draws, which N's record does not** | N112-END (= NB-END) is conditional on N4-STUCK's structure. At a stuck vertex whose horn is bounded at `±1`, FLANK's failure means that structure no longer follows. So **N's row 9, "its application also survives", is overstated**: N4-FIN's application is a GAP at chains with a horn bound `±1` | NB (by N's own row 7) | one mind (NB); **not yet a named GAP in N's record** |
| 2 | "NB-4's exception is realised locally by T2" | withdrawn by NB. BB is all straight (Condition 5 holds locally) and still carries four-colour vertices, so FS-110's fragments are below NB-4's reading radius. **The first break is C-CHAIN-1, and no FS-110 fragment realises it** | N | two minds |
| 3 | SHAVE's new arc | `σ_h = −1` puts `Σ` on the existing lower arc; no unit arc is created. NB's stage-1 sentence is withdrawn | N | two minds |
| 4 | isolated inner-colour contacts at `P + 2e_{w₀}` | **N's l. 231 ("do not exist in the arc's interior") is FALSE** as a statement about contacts. NB's local example: a corner of an inner-colour tile outside `B̄(P, 2)` touching at `q₀`; every interior distance from `T_in ⊂ B(P,1)` exceeds 1. I re-checked it: a lens point `z = P + (1+δ)e_{w₀}` of the away-bend is at distance `1 − δ` from `q₀`, so the tile blocks the first-order away-bend. It is harmless to ARC-INERT (the toward-bend), but **N112-RED has a GAP its author does not name** (RED bends away "wherever R2 fails", with R2 meaning "over all of α"). The tangent bend that would close it is a sketch, one mind | NB | the FALSE sentence two minds (NB, my check); the GAP one mind |
| 5 | N112-RED's GAPs | the union: end vertices; #4; the bookkeeping (a bend creating no new contact at another centre); and stub accumulation at an end vertex, which is why the end-vertex GAP also blocks termination | both, combined | — |
| 6 | C-SEAMS-TWO's correction | two statements, both TRUE in their own frames. NB (unconditional): the seam point lies in the closure of a unit arc centred at `u` or `v`, or is a vertex of `≥ 4` colours. N (conditional on RED): one species up to reduction. NB's precision holds: on NB4′'s (E2) branch the seam point `w₀` carries no unit arc, and the (Q) centres are its ring points | both; **file NB's as the claim's correction and N's as a corollary conditional on RED** (my recommendation; NB held the choice for the owner) | one mind each |
| 7 | C-UA-CHAIN's (E2) step | "both kind" at `y_{k±1}` is derived only when `y_k` is **interior** to the arc; an arc that only ends at `y_k` does not force its sides | NB's precision | GAP (two minds agree it is a GAP) |
| 8–9 | U1 "is"/"contains"; L60's second clause | wording and scope; NB's forms are the precise ones | NB | — |
| 10–14 | C-CHAIN-8, 15; C-UA-BUDGET's branches; C-LOCAL; C-BEYOND | compatible; NB sharper at 8 (`|P_cl(N)| ≥ 4`) and 15 | — | — |
| 15 | `tools/fs112_n_arcs.py` | **tool defect stands**: the plants `r2_outside` and `end_half` are twins that exit 0, and no plant turns R2, END or L60 red. The checks are paired but not seen to fail (`CLAUDE.md` § Make the gate fail) | NB | — |

**Card W on the proof side (A2's cards, answered by N, re-derived by NB):**
- **W1 (NB-4's exception) is settled: N112-NB4′, two minds, one blind.** Arcs of `ω(v)` that *end* at an orbit point must be named (N's retraction 1,
  prompted by the card). The bound `|P_cl(y_k)| ≤ 4` is not needed: NB found this blind, N found it independently.
- **W2 (W-MERGE): the clause holds, and the configuration is empty.** N derived it; NB re-derived it by a shorter route. Two minds.
- **W3 (N4-RAY): holds, but its printed step (1) fails at `κ₄ = 1`.** Step (1) is restated for the middle region `M` (N). NB agrees on RAY.
- **W4: N named every circle the base reads**, with CB's line numbers (N §2.1 W4). **W5: both kind** (N).
- The other walk's positions on W2 and W3 are scored in the construction half.

### 3.2 My hunches and retractions (proof half)

- `a2-nb4-three-circles` — **killed in its `ω(y_k)` part** (two minds, one blind: N; NB), **confirmed in its `ω(v)` part** (arcs of `ω(v)` with an orbit
  point in their closure; N's retraction). My quick doubt in stage 2a — that the two inner half-arcs at `y_k` might carry two colours — is answered by
  N's W1 (ii): `P_cl(y_{k+1}) ∩ P_cl(v)` is squeezed into one 2-set that must hold both `Q⁻_{k+1}` and `Q⁺_{k+1}`. **Retraction (A2, free: held, never sent).**
- My stage-1 row 1 ("fails, realised by T2's `w`") — **retracted**: the fragment is below the reading radius (divergence 2). The planning advisor's
  §4.3 made the same error, and so did NB's stage 1. Three minds read a truncated four-colour vertex as a counterexample to a ring statement; N's BB
  remark caught all three. **A G21 instance**: the acceptance test ("a four-colour vertex exists in an exact fragment") was sufficient-looking and was
  not the step's condition (a whole ring).
- `h-nb4-slip` (planning advisor) — **confirmed in effect**: the printed `ω(y_k)` clause is empty or unneeded, and the corrected form carries `ω(v)`, in
  closure form (two minds, one blind).
- `h-arc-inert` — **confirmed, sharper** (two minds): no exceptional contact points for the toward-bend; the GAP moved to the end vertices.
- `h-four-colour-crux` — **supported**: the reduction lands on (Q), vertices with `≥ 4` colours that are unit-arc centres carrying both side colours.
- `h-loc` — **stands**: every step N derives reads a disc of radius at most 2 about a point, and N says so (§2.5).

**Retractions, proof half:** A2 3 (step 5 at stage 2b; `a2-nb4-three-circles`'s `ω(y_k)` part; row 1's "realised by T2"). N 1 (W1 (i)). NB 3, all
after its blind commit, none free. **One unstated flip:** N's pre-round expectation was that a four-colour vertex whose ring is wholly covered would fail
to close in a tight fragment. N's own registration N112-P2 now predicts that the printed strip contains such vertices within `0.834` of its midline.
N112-P2's hypothesis ("with no covering pair on its ring") narrows it, but N112-P1 ("every unit arc is (Q)") predicts four-colour centres with rings
inside the strip either way. **The pre-round answer was not withdrawn in N's record.** It is scored in the construction half.

### 3.3 The registrations, scored (proof half; the planning `E`s at `plans/FS112-unit-arc-half.md` §5.3)

| id | registered | outcome |
|---|---|---|
| E1 (0.9) | NB-4 and NB-5 fail as written, realised by FS-110's own fragments | **half met**: they fail as written (two minds each); **not realised by FS-110's fragments** (below the reading radius) |
| E2 (0.6 / 0.5) | W-MERGE and N3-CONF survive; the N4 chain survives off centres | **met**: W-MERGE and N3-CONF (a) at two minds; the N4 chain's exceptions all sit at unit arcs centred at `v`, `N` or `S′` |
| E3 (0.5) | the first N4 break is at the curvature endpoints `±1` | **met**: FLANK at `κ = ±1`, two minds |
| E4 (0.5) | the proof side's first unclosed step sits at a four-colour unit-arc centre | **met**: N112-RED's terminal object is (Q), and C-BEYOND's step is to exclude all-(Q)/(R2) maps |
| E8 (0.7) | C-SEAMS-TWO TRUE | **not met as stated** (MISSTATED, two corrections); NB's unconditional correction keeps two species |
| E9 (0.6) | ARC-INERT TRUE off isolated contact points, GAP at them | **met, sharper**: TRUE with no exceptional points; the GAP is at end vertices |
| E14 (0.3) | a NO of Q-full at one mind within P1 | **not met**: a reduction, not a NO |
| E15 (0.85) | a named obstruction or GAP as the product | **met** |
| E16 (0.4) | a blind verifier finds a divergence of truth | **met**: #4 (N's l. 231 FALSE; RED's GAP unnamed) and #1′ (N4-FIN's application overstated); the one reversal, #1, went the side's way |
| E17 (0.35) | an explicit `R` | not met (C-LOCAL a GAP) |

### 3.4 What the proof half adds up to

The proof side has turned §IQ's structural question into a **reduction theorem at one mind**. N112-RED says that every valid map can be modified,
validly and creating no unit arc, until every unit arc is either (Q) — centred at a vertex of at least four colours that carries both of the arc's side
colours, which is Polymath's tactic at a vertex of degree at least 4 — or (R2), an out-contact whose inner colour runs along the radius-2 circle. Beside
it, N112-NB4′ (two minds, one blind) ties every four-colour vertex to a unit arc: one centred at the vertex, or one through a ring point of its covering
pair's orbit. **So in a reduced map, unit arcs and four-colour vertices occur together.** Every step is local (radius at most 2), and the proof side
itself says all of it holds on the strip and the disk. The decisive step, C-BEYOND's exclusion of all-(Q)/(R2) maps, is named and not derived. It is
G79's example invariant in its first form: what every unit arc's centre carries after reduction.

### 3.5 Round 2 for the proof side — a decision in four parts

- **The choice.** The successor takes **the end vertices of unit arcs**, which are at once N112-RED's first GAP, C-ARC-END's question, and C-UA-CHAIN's
  step ("each unit arc forces a further unit arc … at its end vertices"). In order:
  1. Close N112-BEND at the end vertices, and NB-ISO's isolated radius-2 contacts by the tangent bend. Settle RED's termination, stub
     accumulation included.
  2. Combine RED with the N4 moves and the corrected FLANK into **one terminal-map statement**: every vertex cubic or a (Q) centre; every unit arc
     (Q) or (R2); FLANK's `κ = ±1` exception placed inside (Q) or (R2), or named; N4-FIN's application at horn bound `±1` (divergence 1′) closed or
     named.
  3. With that object, the first global step, by one of two routes, with the choice stated: the (E2)/end-vertex chain (C-UA-CHAIN), or S–V Cor. 1
     a.e. with (Q) centres admitted (the base's exceptions B1–B3 are all at arc centres, which RED makes (Q)).
  The tool gets red plants at R2, END and L60 (divergence 15) before any of its checks is cited.
- **The alternative weighed.** Go straight at C-BEYOND's global exclusion of all-(Q)/(R2) maps, carrying RED's GAPs as named.
- **Why this one won.** Every global route consumes RED's terminal object. RED's open GAP sits at the arc's end vertices, and **the end vertices are
  the joints where one unit arc meets the next** — the place any chain, count or propagation must pass through. So closing the end-vertex GAP is the
  first half of the global question, not bookkeeping. A global attempt over a reduction that is open exactly at its joints would have to re-derive
  them anyway, inside a harder argument. Item 2 also repairs the one overstatement that the two minds left in N's record (1′).
- **Confidence: medium.** The fact that would change it: **N's own registrations N112-P1 and P2** (the strip's arcs all (Q), with rings inside it).
  If they are confirmed exactly at the end vertices — arc-closed (Q) centres in a held valid object — then the end-vertex analysis cannot end in a
  local exclusion. Item 3's global step then becomes the round's whole aim, and item 1 shrinks to a lemma.
- **Default:** if the owner says nothing, the successor's brief is items 1–3 in order, with the tool plants first, and a blind verifier after it.
- **Fence note for the successor's brief:** nothing of the construction side (its record, stage 2 or report) goes into it. Card W's text, NB's divergence
  table and this section's four parts are proof-side material and may go in.

### 3.6 Evidence inventory (additions)

- `plans/FS112-N-proof.md` stage 2 — read against: a round-1 proof side answering card W and working §6 — surprised: yes. It is a reduction theorem
  (RED), not a set of seam kills, and N registered predictions (P1–P3) that contradict its own pre-round answer without saying so.
- `plans/FS112-NB-verification.md` stage 2 — read against: a verifier confirming the walk — surprised: yes, twice. NB found a FALSE sentence and an
  unnamed GAP in RED (#4). And NB's own FLANK verdict reversed toward the side's, at a curvature endpoint.
- `data/fs112/reports/FS112-N.md`, `FS112-NB.md` — read against: their records — surprised: no. The NB report's "letter-for-letter" matches its §2.3.

## Stage 3 — SAVED

---

# § Continuation — FS112-A3

*Poros (Opus 5.5), 2026-09-27, taking over from FS112-A2 (replaced at about 480k tokens) for the construction half's comparison and round 2. Brief:
`data/fs112/briefs/A3-112-competition-advisor-continued.md` plus A2's brief, with `STANDING-RULES.md`. HEAD at launch `c9d22f72`. Working directory
`data/fs112/fs112-a3/`. The proof side's successor FS112-N2 (agent `ad14d810fd7717a7e`) is running; the construction side has no successor yet. This
section never rewrites A2's stages. **Label note:** A2's stage 2b follows Y in calling `(3/2, 0)` "`P_2`"; by Y's own formula `P_j = (j/2, 0)` it is
`P_3` (YB's D1). Below, `P_j = (j/2, 0)` throughout, in Y's colour labels 1–6.*

## A3: theorems this continuation proved

*(none — an advisor's record. The derivations below are hunches with basis "derived", handed to nobody as results.)*

## A3: would-have-searched-here log

- Would have computed the strip's end-vertex tangent margins numerically for every arc to price `a2-arc-ends-bind`. Instead: by hand from the exact
  quadrant sectors at `P_1` (YB O1) and the eight end directions, at one midline vertex; the translation symmetry carries it to the rest.
- Would have enumerated the strip's covering pairs and their common unit points to classify every seam. Instead: read YB's exhaustive list
  (`strip-objects.txt` as summarised in YB O2–O3) and derived the two overlapping pairs' seams by hand (A3-1.6).

## A3: fence log

- Not a blind job. Read per my brief: `plans/FS112-Y-construction.md` (stages 1–2 in full), `plans/FS112-YB-verification.md` (stages 1–5 in full), the
  reports `FS112-Y.md`, `FS112-YB.md`, `FS112-N.md`, `FS112-NB.md` (the brief: "all reports in `data/fs112/reports/`; the records are yours to read").
  Also `plans/FS112-N-proof.md` in full, including FS112-N2's stage 1 (committed `b0356886` after my launch), and NB §1.5–1.6 by grep.
- Not opened: `plans/FS112-close-inventory.md` (fenced by A2's brief; mine does not lift it); the transcripts; `chats-bak/`; scratchpad files I did not
  create (I work in `scratchpad/fs112-a3/`).

## Stage A3-0 — SAVED: quotation check (standing rule 5)

| quotation in my brief | source | verdict |
|---|---|---|
| A2's §3.5 confidence clause: "The fact that would change it: **N's own registrations N112-P1 and P2** (the strip's arcs all (Q), with rings inside it). If they are confirmed exactly at the end vertices — arc-closed (Q) centres in a held valid object — then the end-vertex analysis cannot end in a local exclusion." | this record, stage 3 §3.5 | **verbatim** (the brief drops the leading "**Confidence: medium.**", outside its quotation marks) |
| Y's §2.5 list: "CAL-DISK with Fig. 10 transcribed first, the dial past 3.668, a `κ = ±1` horn fragment, C-HOCK on A6-C2" | `plans/FS112-Y-construction.md` §2.5 items 1–4 | the brief's own words, outside quotation marks; faithful to items 1–4 |
| standing rules 0, 3, 4, 10's quotations of Kooshi | `CLAUDE.md`; `plans/CONSOLIDATION-2026-09-27.md` | `STANDING-RULES.md` unchanged since `1e8afbe4`, before A2's stage 0, which found all verbatim; rule 4's re-checked against `CLAUDE.md` item 23 on disk: verbatim |

`CLAUDE.md` read from disk: since `e133253b` it changed in § The aim link 2 (`[GwynStavrianos2022]`), the prior-art paragraph, and the ranked table
(FS-113 ranked 8; FS-112's row now cites `[Polymath2021]` p. 199 and `[Parts2021]` p. 182). Nothing in my brief depends on those lines.

## Stage A3-0 — SAVED

## Stage A3-1 — SAVED: the construction half compared; the held claim decided; the registrations and pre-round answers scored (brief item 1)

### A3-1.1 Y against YB — every divergence, and how each settles

YB's stage 5 table (D1–D12) was checked against both records. **No divergence of truth; no object or verdict differs.** Two blind rebuilds from
`[AxenovichEtAl2014]` p. 8's words, two independent exact checkers (Y's tower of quadratic fields with a float-guarded map hypothesis; YB's
multiquadratic field with an exact meeting test), the same strip, the same colouring up to relabelling, ACCEPT on the same population of pairs.

| # | divergence (YB's numbering) | settlement | owed, and to whom |
|---|---|---|---|
| D1 | `(3/2, 0)` called "`P_2`" | slip; it is `P_3`. Carried into A2's stage 2b and the YB instance file; no object changes | nothing |
| D2 | valley or apex in "the point of intersection of circular arcs" | both readings give the same height exactly (YB): the rule is unambiguous | nothing |
| D3 | CAL-7's object | the claim list names row 33's **brick**; Y calibrated on the hexagonal colouring. The named object is ACCEPTed by one checker (YB's) only | the construction successor: Y's checker on the brick (seconds) |
| D4 | the checker model | YB's exact map-consistency confirms Y's map hypothesis **on the strip only** | the construction successor: **both checkers on every new object** (the disk, dial patches, the horn fragment); a wrong transcription breaks exactly Y's map hypothesis |
| D5 | 60 ordered pairs against 36 of 90 orbit pairs | the same population | nothing |
| D6 | 22 arcs read against 12 per period | unreconciled, verdict-neutral (a window edge, probably) | one line for the successor |
| D7 | plants | the cross-run agrees pair for pair | nothing |
| D8 | found by YB only: T2 on a **thin** unit rhombus (`A_j, A′_j` at `√15/2`, seams `P_j, P_{j+1}` at distance `1/2`); the overlapping covering pairs `(P_j, P_{j+1})` | stands, one mind, exact. **A correction owed to the claim list:** §2 defines T2 with the parenthesis "(the spindle's rhombus)"; the strip realises it on a unit rhombus with diagonals `1/2` and `√15/2` | the close |
| D9 | Y112-EDGE | two minds, one blind (YB adds the exact open cone `(30°, 165.52°)` and a control) | nothing |
| D10–D12 | framing and coverage | consistent | nothing |

### A3-1.2 Y's held claim: C-UA-BUDGET's second branch — decided

**FALSE as stated** [tools, exact; two minds, one blind: Y; YB]. Claim list §6, verbatim: "**on the other branch** (a covering pair at a ring point `y`),
the arcs sit on `ω(σ_v^{±1}y)` through `y` — centred at ring points at distance 1 from `v`, not at `v`". At `P_1` (`{1,2,4,5}`), `y = P_3` (`{1,3,4,6}`)
is a ring point at distance 1 whose types cover `[6]` in the list's union sense (§0, correction 1). `σ^{±1}P_3 = W, W′` are valleys; no unit arc of the
strip is centred off the midline, so no arc of `ω(W)` or `ω(W′)` exists, and `P_1`'s own four arcs lie on `ω(P_1)`. **The corrected branch 2 is TRUE at
two minds** (N §2.3; NB §1.6, NB's (1)–(2) predicting blind exactly this configuration: a four-colour ring partner, and an arc of `ω(v)` at an orbit
point). The strip realises the correction through its `ω(v)` alternative. Under the disjoint sense of "covering pair" the branch has no instance on
the strip, and branch 1 holds there (`62.09° ≥ 60°`, exact). **The two branches are exclusive as hypotheses and not as conclusions** (NB; YB): the
strip's four-colour vertices meet branch 2's hypothesis and branch 1's conclusion at once. Four minds agree that branch 2 is not TRUE as stated.

### A3-1.3 The one divergence of truth left between the sides after card W: W1 (ii)

- **The construction side** (Y §2.3 W1 (ii), verbatim): "**Yes, the alternation uses `|P_cl(y_k)| ≤ 4`:** … A fifth colour at `y_k` lets the two inner
  half-arcs carry two colours and breaks the disjointness." Y adds exception (γ), "`Γ`-arcs of total measure `≥ 180°` on some `ω(y_k)`".
- **The proof side** (N §2.1 W1 (ii); NB §1.5, blind): no. The straddler pair of `ω(y_{k+1})` at `y_k` lies on `ω(y_{k+1})`, so by N-E1 it avoids
  `P_cl(y_{k+1})`. Then `P_cl(y_{k+1}) ∩ P_cl(v)` lies in the complementary 2-set of `P_cl(v)`, and the bound on `|P_cl(y_{k+1})|` is a consequence.
- **My reading: the proof side is right.** Y's sentence is true of NB's printed proof, which states the bound as its first step. It is false as a claim that
  the alternation needs the bound: a fifth colour at `y_k` would be a third colour of `P_cl(v)` there, and the neighbour's straddlers exclude it.
  Y112-NB4-MIS is **TRUE but weaker**, with one redundant exception. **N112-NB4′ stands** (two minds, one blind).
- **Owed:** the construction successor re-derives (ii). A retraction there would be Y's fourth.

### A3-1.4 The proof side's pre-round answer and registrations, scored against the strip

| item | registered (verbatim or by id) | outcome |
|---|---|---|
| **N's pre-round answer** (stage 2a) | "What would show me wrong: an exact fragment, accepted by two checkers, covering ω(v) entirely (every point of the ring coloured or on Γ) with \|P_cl(v)\| = 4" | **FALSIFIED by its own named observation** [tools, exact]: two blind rebuilds, two checkers; `ω(P_1)` lies wholly inside the strip (radius 1, half-height ≈ 1.834), every ring point coloured or on `Γ`, `\|P_cl(P_1)\| = 4`. N's P1/P2 had flipped to the opposite without withdrawing the answer (A2 §3.2) |
| N's secondary | "C-ARC-END for (S1) at both ends of the arc fails for the same reason at the ends' vertices" | **untested**: the strip holds no (S1) seam (YB O2) |
| **N112-P1** (0.8) | "every unit arc is (Q) … none is (R2)" | **MET** [tools, exact; two minds, one blind]: 12 arcs per period, each centred at a midline vertex of four colours, of kind both (self in-contact and out-contact); none out-only, so none (R2) |
| **N112-P2** (0.85) | "every four-colour vertex of CAL-STRIP within `0.834` of the midline with no covering pair on its ring has centred arcs of total `≥ 60°` (four arcs, each `< 60°`)" | **vacuous as registered** in the list's union sense: every four-colour vertex (the midline `P_j`) has covering partners `P_{j±2}` on its ring. **Met in the disjoint sense.** **Its conclusion holds unconditionally:** four arcs of `≈ 15.52°` each, total `62.09°` (exact cosine, YB) |
| N112-P3 (0.7) | CAL-DISK's `{1,3,5,6}` junction is (Q) | **open**: the disk is not rebuilt |

### A3-1.5 The construction side's pre-round answer, scored

- **What Y named:** "Step: C-UA-CHAIN …, the monotone quantity excluding bi-infinite chains of unit arcs, and with it any NO route shaped like
  N4-PROP/N4-FIN; next most likely, C-UA-BUDGET's second branch."
- **C-UA-BUDGET's second branch: met** (A3-1.2).
- **C-UA-CHAIN: supported, not yet scorable.** The bi-infinite periodic chain of unit arcs is exact at two minds, one blind (YB-CHAIN). No local
  monotone quantity along it can exclude it. The proof side has proposed no such quantity: N and NB grade C-UA-CHAIN a GAP, and N2's brief names the
  chain route as one candidate for its item 3.
- **The N4-PROP/N4-FIN clause: not met.** Both walks keep N4-FIN as written. Its application at horn bound `±1` is a GAP (A2 §3.1, 1′), not a failure.
- **Y's falsifier (a), "my stage-2 exact checker REJECTs the rebuilt strip": did not fire.**

### A3-1.6 What the list does not name (A2's brief item 5)

1. **T2 beyond the spindle's rhombus** (D8): a seam realisation that §2's parenthesis excludes. A correction owed to the list.
2. **The overlapping covering pairs are saved by (S2) with arcs, exactly** [my reading, one mind, from Y's and YB's exact types]:
   - `(P_1, P_3)`: `{1,2,4,5}` and `{1,3,4,6}`, distance 1. Its common unit points are the valleys `W, W′`.
   - At `W`, an arc of `ω(P_1)` (to `A_1`) and an arc of `ω(P_3)` (to `A_2`) both start. The other tangent direction of each circle enters a tile
     whose colour only the other point holds: arch 2, colour 3; arch 1, colour 2. That is the Q-rule's (S2) with one arc of each circle ending at the
     seam.
   - The same holds at the apexes for `(P_j, P_{j+1})` at distance `1/2`.
   - Claim list §1 records (S2)-with-arcs as "GAP at every pattern but N-X's". **This pattern is realised locally, exactly and arc-closed.**
   - It is T2 read from the rhombus's other diagonal: in T2, `u` and `v` each emit arcs of both `ω(w₀)` and `ω(w₀′)`, so from the pair `(w₀, w₀′)`
     both circles have arcs ending at `u`. Hunch `a3-t2-dual`.
3. **Every close complementary pair of the strip is saved by a four-colour centre at one seam, and the `(V, A)` pairs at one seam only** (YB-SEAMS,
   exhaustive over a period):
   - `(W, W′)` at `√3` and `(A_j, A′_j)` at `√15/2` are saved at both common unit points.
   - The `(V, A)` pairs at `≈ 0.757` (12 per period) are saved at `P_j` and not at their second point, **which is an edge vertex**, where the colouring
     cannot continue (Y112-EDGE, two minds).
   - The same edge is where the circles of Lemma 3's and Cor. 3's configurations leave the strip (Y §1.4 row 13; YB O5 C-CHAIN-14): the strip holds
     the base's forbidden point configurations, and escapes only through its edge. Hunch `a3-base-reads-beyond`.
4. **An ACCEPT that no plant could turn into a REJECT: not fired.** Y's `endpoints_only` plant is unreachable on the strip (Y says so). Every other plant
   fired at its predicted pairs, on two checkers.
5. **A local TRUE scored as a refutation of the NO: not fired.** Both score the strip as a strip.
6. **A seven-colouring in disguise: no** (six colours).

### A3-1.7 The plan's §5.3, the construction half

| # | p | outcome |
|---|---|---|
| E5 YES by formula | 0.03 | not met in round 1 (no global candidate attempted) |
| E6 the dial | 0.2 | not attempted in round 1 |
| E7 strip rebuilt and accepted; carries out-contacts | 0.85; 0.6 | **both MET**: two blind rebuilds, two exact checkers; every arc of kind both |
| E8 C-SEAMS-TWO TRUE | 0.7 | not met as stated (proof half, A2 §3.3); the construction half's reachable FALSE ("a T2 realisation whose seam points carry three colours") did not fire: T2 on two rhombi, seam points four-colour, exact |
| E10 a closed cycle of unit arcs | 0.35 | **not met**: no cycle; bi-infinite chains instead, the sibling outcome that defeats a chain-local monotone quantity |
| E11 every seam arc-closed | 0.6 | **two of three**: T2 (two rhombi) and NB-4's four-colour vertex with its whole ring, exact; (S1) not realised arc-closed |
| E12 G71 survives | 0.75 | untested (no bowtie seam with unit arcs in the strip) |
| E13 C-HOCK | 0.6 | untested (left to the successor) |
| E1 (construction half's share) | 0.9 | NB-4 and NB-5 fail as written, now also by an exact print object; the "FS-110's fragments" half stays not met |
| E2 (W-MERGE) | 0.6 | met at three minds (N, NB, Y after its retraction) |
| E16 | 0.4 | YB found no divergence of truth with Y (E16 was met on the proof half) |

### A3-1.8 Hunches

**Scored:**
- `a2-arc-ends-bind`: **killed** [hand, one mind, on the exact strip].
  - At `P_1` the sectors are the four quadrants (YB O1). Arcs end at directions `60°, 75.52°, 104.48°, 120°` and their mirrors.
  - For each end `x`, the sectors at `P_1` whose colours lie in `P_cl(x)` sit off the tangent of `ω(x)` at `P_1` by at least `14.48°`
    (`75.52°`: `G` and `M` against the line `165.52°/345.52°`).
  - Every centre carries four arcs and no end constraint is tight: the falsifier fires. The arc ends are not the construction's binding difficulty at
    the strip's scale.
- `h-seams-two` (planning advisor): **supported** at two minds, exact.
- `h-no-local-kill`: supported at the strip's scale (C-BEYOND at 1.834, exact); radius 3 untouched.
- `h-lattice`, `h-yb3-counter`: untested.
- `h-dial`: open.
- `h-discharging`: open, sharpened by A3-1.6 item 3.

**Registered (2026-09-27, after reading both halves, before the card):**

hunch: a3-base-reads-beyond
  claim: a NO's step past CAL-STRIP is the base's reading of unit circles about trivalent vertices (C-CHAIN-13/14's Cor. 3 and Lemma 3 configurations, four-colour unit-arc centres admitted), not a monotone quantity local to a chain of unit arcs
  basis: read (Y §1.4 row 13, §2.3 W6; YB O3, O5 C-CHAIN-14)
  falsifier: a NO whose step past the strip is local to a chain of unit arcs; or Lemma 3, with four-colour centres admitted, refuted by the strip or the disk at its own reading radius
  registered: 2026-09-27
  status: open

hunch: a3-t2-dual
  claim: T2 at the pair (u, v) of a unit rhombus u w₀ v w₀′ is the (S2)-with-arcs pattern "one arc of each circle ending at the seam" for the other diagonal pair (w₀, w₀′), whenever that pair is covering; the strip realises it at (P_j, P_{j+2}) and (P_j, P_{j+1})
  basis: derived
  falsifier: a T2 realisation whose other diagonal is a covering pair that fails (S2) at u or v
  registered: 2026-09-27
  status: open

hunch: a3-disk-stops-at-a-seam
  claim: the rebuilt CAL-DISK cannot be continued past a point that is an unsaved common unit point of a close complementary pair, as the strip cannot past its edge vertices
  basis: analogy
  falsifier: the rebuilt disk's non-continuable boundary points include none that is a common unit point of a close complementary pair
  registered: 2026-09-27
  status: open

**Retractions, construction half:**
- Y: 3, all free (W2, W3, W5, at stage 2). One more is owed, or its defence, at W1 (ii).
- YB: 0 of substance. Two harness defects were caught by its own plants.
- A3: 0 so far.

### A3-1.9 Evidence inventory (A3)

- A2's record, read in full — read against: the brief's summary of the hand-over — surprised: yes; stage 2b labels `(3/2, 0)` "`P_2`" after Y
- `data/fs112/fs112-a2/card-walks.md`, `pre-round-question.md` — read against: card W as the records quote it — surprised: no
- `plans/FS112-Y-construction.md` stages 1–2 — read against: a calibrated checker, the strip accepted, card W answered — surprised: yes; at W1 (ii) Y answers the opposite of N and NB, and adds exception (γ)
- `plans/FS112-YB-verification.md` stages 1–5 — read against: a blind rebuild agreeing with Y — surprised: yes; T2 on a thin rhombus, and the base's forbidden configurations present in the strip, saved only by its edge
- `data/fs112/reports/FS112-Y.md`, `FS112-YB.md`, `FS112-N.md`, `FS112-NB.md` — read against: their records — surprised: no
- `plans/FS112-N-proof.md`, including N2's stage 1 — read against: N2 starting its item 1 — surprised: no
- `data/fs112/claims.md` §0–2, §6–9 — read against: the statements being scored — surprised: yes; T2's definition says "(the spindle's rhombus)"
- `plans/FS112-unit-arc-half.md` §5.1–5.3 — read against: the E rows — surprised: no
- `plans/FS112-NB-verification.md` §1.5–1.6, by grep — read against: W1 (ii) and C-UA-BUDGET — surprised: yes; NB's branch-2 diagnosis predicted the strip's configuration blind

## Stage A3-1 — SAVED
