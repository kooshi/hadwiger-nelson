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
