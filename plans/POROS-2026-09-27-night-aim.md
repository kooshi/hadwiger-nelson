# Poros — tonight's milestones after FS-112's close (job NIGHT-A, 2026-09-27)

*Poros (Opus 5.5), for the product owner; brief `data/night-2026-09-27/brief-A.md` (a311ce82). Kooshi deferred the choice to a Poros agent
(`plans/FS112-close-inventory.md` item 70: *"Even decompressed, this is a bit beyond me, […]. I'll defer to a Poros agent."*); it
binds within the standing rules (at most three agents at once, all Opus 5.5, one level deep; no finite-witness search; every milestone opens with
WORKFLOW's reframe). Read from disk, in this order: the brief; `~/source/poros/CLAUDE.md` and the three Poros skills; `CLAUDE.md` § The aim and
§ Counter-priors; FS-112's close report and FS112-YB3's report; the stubs of FS-114, FS-115 and FS-111; FS-112 §R-close stage 3;
`data/fs112/fs112-c/reconciliation.md` §§1.5–1.11 (stage 1b included); `plans/FS112-close-inventory.md` items 58–70; `LEDGER.md` rows 131–134 and the
drafted rows 135–136; `plans/FS107-R-stability.md` §3.4; `plans/POROS-2026-09-27-fs107-competition.md` X1, §5.1, §5.9; `plans/FS107-derivation.md`
FS107-RR and FS107-MEET; `plans/FS112-NB3-verification.md` §2.3; the Polymath16 extracts on Sirgedas (`data/fs112/fs112-pa/extracts.md`);
`plans/FRONTIER-STUBS.md`'s top fourteen; the Proof Atlas's routes and credences (`data/viz/proof-atlas/facts.json`). FS112-C2 was editing the two
unit-arc stubs while I read; nothing below rests on its unfinished edits.*

## 1. The decision, in four parts

**The choice.** Open two milestones tonight, in this order:
1. **FS-114, the unit-arc question** (`plans/STUB-global-step.md`): can the plane be six-coloured by a map of segments and circular arcs once arcs of
   radius exactly 1 are allowed?
2. **FS-111, the cone scale** (`plans/STUB-reg-scale.md`): the same question for colourings of unbounded complexity, asked as "do near-optimal
   colourings keep their junctions fat?".

The three slots:
- **Slot 1: FS-114's planner.** It runs WORKFLOW 3–4: the re-grokking, the prior-art gate, §IQ, then the plan.
- **Slot 2: FS-111's planner.** The same steps.
- **Slot 3: BASE-V, a blind re-derivation of the four print steps under row 134's base.** These are `[SokolovVoronov2025]` Lemma 5, Prop. 18 and
  Lemma 6's `< 9` branch, and CUSP-BASE's one-mind items. The verifier is fenced from every walk that took them (FS110-CB, FS110-CE, FS112-N3,
  FS112-NB3). This pays a debt that FS-112's close named: *"a second derivation of those steps is owed before anything final rests on them"*
  (`plans/STUB-global-step.md`). It needs no plan.

As a slot frees, FS-114's phases take it first, then FS-111's. **FS-115, the stuck ray, does not open tonight.** It opens, and takes the next free slot
ahead of FS-111's phases, the day FS-114's accepted plan commits to the four-colour form for maps that are not periodic.

**Alternatives weighed.**
- (a) **Kooshi's original pair, FS-114 + FS-115** (the global step and the stuck ray; item 59). It would buy a night on the aperiodic lemma of the
  four-colour form: rays, long chains, the one-vertex bowtie end. It has a concrete toolkit — the dynamics of the parabolic Möbius map `λ/(1 + λ)` —
  and Kooshi named it.
- (b) **FS-114 alone, staffed as FS-112 was**: a planner, then a proof side and a construction side with an advisor.
- (c) **A third planner (FS-115) or a planning advisor** in slot 3, in place of BASE-V.

**Why this one won.**
- *Against (a).* FS112-C-COMPOSE was derived after Kooshi's ruling, and it removed the reason for the pair. By FS112-N3-DENSE3, every valid map has a
  vertex of four or more colours, or a vertex with a repeated colour, within 3 of every point. So FS-114, taken in that form, **is the NO itself** and
  needs no step about rays. FS-115 bears on the answer only if FS-114 chooses the four-colour form for maps that are not periodic. FS-114's own planner
  makes that choice tonight, so opening FS-115 first risks a night on a lemma nobody ends up needing.
- *For FS-111.* It is the route to seven's other door. It lives in another discipline (geometric measure theory), and its literature is unheld: Bukh
  2008, Falconer–Marstrand 1986, Furstenberg–Katznelson–Weiss 1990. Its planning depends on nothing FS-114 will produce tonight. Its first question
  (card 1, §3) tests a one-mind synthesis that the front page's route to seven rests on.
- *Against (b).* FS-114's contest cannot start before its plan exists. During the planning hours, two slots would sit idle.
- *BASE-V over (c).* The four steps sit under row 134 and under FS112-N3-DENSE3 alike. They come from a paper whose other steps have needed repair
  (row 132): *"S–V Thm 2 holds after three repairs"*, Lemma 3's *"printed Fig. 5 argument fails from `√3`"*, and *"S–V Thm 1 is a GAP at Prop. 19's
  fills"*. No mind in this project has derived them. Checking them costs one agent a few hours, and nothing has to wait for it.

**Confidence: medium.**
- The main fact that would change the plan: FS-114's planner commits early to the four-colour form for maps that are not periodic. Then FS-115 becomes
  that route's bottleneck and takes the next free slot.
- A second: BASE-V finds a failing step. Then FS-114's first phase is the repair, and row 134 is regraded before anything builds on it.

**The default — if the owner hears nothing more:**
- Launch the three jobs now: FS-114's planner, FS-111's planner and BASE-V. Each brief carries its card from §3 as its opening question.
- The front-page job applies §2's ranking.
- As slots free, FS-114's phases go first.
- FS-115 stays unopened until FS-114's accepted plan commits to the four-colour form. Its bowtie item stays in its stub.
- Sirgedas's argument stays unfetched until Kooshi rules on fetching from the Google group.

## 2. The ranking, by bearing on the answer

| rank | stub | bearing, in one sentence |
|---|---|---|
| 1 | **FS-114 the unit-arc question** (`plans/STUB-global-step.md`) | decisive both ways at bounded complexity: a YES gives `χ(ℝ²) ≤ 6` with no MR; a NO answers `[SokolovVoronov2025]` Question 2's unit-arc half and `[Polymath2021]` p. 199's hope (with row 134, the whole question, almost everywhere, for segment-and-arc maps) and closes door (A) at every complexity bound |
| 2 | **FS-111 the cone scale** (`plans/STUB-reg-scale.md`) | the unbounded-complexity door: a family with holes `→ 0` refuting it is `χ(ℝ²) ≤ 6` with no MR; with FS-114's NO it is the route to `χ_m⁰(ℝ²) = 7` (so `χ(ℝ²) = 7` given MR) — but that composition is a one-mind reading (FS107-MEET; row 133's grade, "the meeting one mind (A2)") until card 1 is answered |
| 3 | **FS-104 `χ_CP(ℝ²)` at six** (unchanged) | given MR, `χ(ℝ²) ≥ 6`: a new lower bound, independent of the map line |
| 4 | **FS-115 the stuck ray** (`plans/STUB-stuck-ray.md`) | none alone: a lemma of FS-114's four-colour form on maps that are not periodic (FS112-C-COMPOSE); its fragments (the pencil, BOWTIE) are local positives a YES could use; it moves to 2 the day FS-114's plan commits to that form |

Everything from FS-109 down keeps its order, one place lower. FS-112 leaves the table as closed.

**The change from the close's draft.** The draft read FS-114 1, FS-115 2, FS-111 3, FS-104 4. FS-115's rank 2 was the close's reading of Kooshi's "two
gaps" ruling, and C-COMPOSE, derived afterwards, superseded it. By `CLAUDE.md` § Counter-priors rule 1 ("Rank a route by its bearing on the answer"),
a stub with no bearing alone ranks below one with a direct bearing.

## 3. The first questions

The short form, for each opened milestone's brief.
- **FS-114, the re-grokking.** Ask whether the NO is local — an explicit radius past which no valid fragment survives around a four-colour vertex — or
  visible only to a count over the whole plane. G17 predicts a top-rung compulsion arrives only "at the last vertex", and the strip, valid along a
  strip of unbounded length, says any obstruction must read two dimensions. Choose FS-114's form (DENSE3's, the four-colour form, or §6's) by the
  answer.
- **FS-114, the prior-art gate.** In the planar-map vocabulary: "discharging" with "unit distance", "tiling" or "exclusion zone". Also: upper bounds on
  a six-tile-colourable disc's radius or strip's width (`[Polymath2021]`'s strips and discs, and the works citing it). Sirgedas's near-proof for
  non-Siamese tilings is the first debt (`[16.317]`, unheld, in the Google group `hadwiger-nelson-problem`); fetching it is Kooshi's call.
- **FS-111, the re-grokking and §IQ.** Before anything else, derive whether FS-114's NO at every complexity bound plus a cone-scale lower bound
  actually gives seven. R's reduction needs (A) over every near-colouring of any complexity, while W-EQ-K bounds holes only at each fixed complexity.
  The pairing of the two doors is one mind's synthesis.
- **FS-111, the prior-art gate.** Name the object as the literature does:
  - regularity of near-minimisers or optimal partitions under a non-local constraint (De Giorgi, Almgren, Taylor; Morgan's planar clusters, whose
    boundaries are circular arcs — recalled, not read);
  - compactness for sets avoiding a distance (`[Bukh2008]`, Falconer–Marstrand 1986, Furstenberg–Katznelson–Weiss 1990).
  Ask whether any regularity theorem makes limits of near-optimal colourings into maps of segments and arcs, the only class the map NO covers.

The cards, ranked (the gate's form):

question: does-the-route-to-seven-close-with-two-doors
  evidence: `plans/STUB-reg-scale.md` § Bearing: "Decisive jointly with (A) — at bounded complexity row 134 … and, with unit arcs, FS-114's NO";
    `plans/FS107-derivation.md` l. 46, FS107-RR's (A) quantifies over "every band-proper partial six-colouring with holes `< δ`" (any complexity);
    l. 147, FS107-MEET is "derived, one mind: A2"; `LEDGER.md` row 133: W-EQ-K holds "at bounded arc complexity `K`", the meeting graded "one mind
    (A2)", and "So stability at six is two questions"; row 134 "Not claimed: … boundaries other than segments and circular arcs"
  expected: a derivation, at two minds, that the map NO at every complexity bound plus a cone-scale lower bound gives `lim µ₆(ε) < 1`
  ask: Does FS-114's NO at every complexity bound plus FS-111's cone-scale bound give seven, or is a third statement needed — R's (A) at unbounded complexity, a hole bound uniform in K, or a NO for the boundaries a limit produces?
  if it closes: FS-111 is door (B) as posed; its plan is the regularity theory, and the front page's "decisive jointly" is regraded to the derivation's minds
  if a third statement is needed: FS-111's first product is that statement, named and stubbed; the route to seven has three open pieces, and the front
    page's row 2, row 133's "two questions" and the atlas's route `wall7` are corrected
  answered by: derivation — FS-111's planner, at §IQ, before any phase
  cost: one to two hours of the planner's derivation
  hunch: a third statement is needed — the NO bounds holes by `δ(K)` with no uniformity in `K`, and (B) presupposes (A)'s junctions exist
  falsifier: a derivation that every family with holes → 0 and cone scale ≥ s₀ has a subsequence of bounded complexity whose limit is a segment-and-arc map
  rank: 1

question: is-the-unit-arc-no-local-or-global
  evidence: `plans/STUB-global-step.md` "What is open" item 2, C-LOCAL: "FS-112's steps read radius at most 3; none is a NO"; the strip is valid along
    an unbounded strip of height ≈ 3.668 and the disk is a valid disc of radius ≈ 2.124 (FS112-CAL-STRIP, FS112-CAL-DISK; draft row 136); FS-112
    §R-close 3.4: `h-no-local-kill` (0.6) "supported, open", `h-discharging` "untested (carried to FS-114)"; `CLAUDE.md` G17: "The fan onset (χ ≥ 5
    itself) arrives at the last vertex"
  expected: FS-114's stub names its method; it lists discharging and C-LOCAL and chooses neither
  ask: Is the unit-arc NO local — an explicit radius past which no valid fragment survives around a four-colour vertex — or visible only to a count over the whole plane, as Euler's formula and discharging give?
  if local: the NO is a finite case analysis on a disc of explicit radius above 2.124, uniform in complexity (C-LOCAL, E17); with §6's note one
    four-colour vertex suffices, so no density and no ray step are needed, and FS-115 closes as moot
  if global: FS-114's phases are built around one plane-wide count (Euler characteristic, the angular budget of unit arcs at four-colour vertices,
    discharging), with local lemmas as its reducible configurations and the strip as the control every count must fail on
  answered by: derivation — FS-114's planner, at the re-grokking (G17, G13, G15, G60) and the prior-art gate
  cost: the planner's §G and §PA, a few hours
  hunch: global — G17's top-rung pattern, and the strip forces any obstruction to read two dimensions
  falsifier: an explicit radius R with a derived exclusion of every valid fragment on the disc of radius R about a four-colour vertex
  rank: 2

question: are-the-base-print-steps-sound
  evidence: `plans/FS112-NB3-verification.md` §2.3: "S–V's Lemma 5, Prop. 18 and Lemma 6's `< 9` branch (circle-abstract, from (i), (ii) and finiteness
    — CB and CE took them from print), CUSP-BASE … An error common to both walks would sit there"; `LEDGER.md` row 132: "S–V Thm 2 holds after three
    repairs", "the printed Fig. 5 argument fails from `√3`", "S–V Thm 1 is a GAP at Prop. 19's fills"; row 134's grade: "D4 one reading (CE)", "D5
    items 1–4, 6 true after CE's local repair … one mind"
  expected: steps of a print used as the base of a held row are derived here at least once
  ask: Do S–V's Lemma 5, Prop. 18 and Lemma 6's < 9 branch, and CUSP-BASE's one-mind items, hold in the curved almost-everywhere setting with unit arcs, re-derived by a mind blind to the walks that took them?
  if they hold: row 134's base and FS112-N3-DENSE3 stand at full grade, and FS-114 builds on them as they are
  if one fails: row 134 and every FS-112 row resting on N3-BASE are regraded before FS-114's phases, and FS-114's first phase is the repair
  answered by: derivation — BASE-V, a blind verifier, slot 3
  cost: one agent, a few hours; in the ban
  hunch: they hold — the print's measured defect rate is the reason to check, not evidence of a defect in these four
  falsifier: a configuration meeting a step's hypotheses where its conclusion fails
  rank: 3

## 4. Evidence inventory

- `data/fs112/reports/FS112-C.md`, the close's report — read against: FS-112 closes undecided with two named gaps of equal standing — surprised: yes; the
  global step in DENSE3's form is the NO itself, and FS-115 bears nothing alone
- `plans/STUB-global-step.md` (FS-114) — read against: a lemma smaller than FS-112's question — surprised: yes; it is FS-112's question with FS-112's
  invariants, and its first decision is which form to attack
- `plans/STUB-stuck-ray.md` (FS-115) — read against: a bearing conditional on FS-114's form — surprised: no
- `plans/STUB-reg-scale.md` (FS-111) — read against: a derived statement that door (B) with the map NO gives seven — surprised: yes; "decisive jointly"
  rests on a pairing graded one mind, and RR's (A) is quantified over every complexity
- `plans/FS107-R-stability.md` §3.4, RR — read against: the no-complementary-pair branch handled at unbounded complexity — surprised: yes; only "W's only
  escape from a forced complementary pair" is discussed
- `plans/FS107-derivation.md` FS107-MEET — read against: two minds — surprised: yes; "derived, one mind: A2"
- `plans/POROS-2026-09-27-fs107-competition.md` X1, §5.1, §5.9 — read against: the source of the two-door split — surprised: no; X1's own sketch says
  the bounded-complexity NO "proves nothing about unbounded complexity"
- `data/fs112/fs112-c/reconciliation.md` §1.6 — read against: the composition's links at two minds, the assembly one — surprised: no
- `data/fs112/fs112-c/reconciliation.md` §§1.8–1.9 — read against: YB3's refutation narrows (b′) — surprised: no; BOWTIE lies within 1 of four-colour
  vertices, and no link of the composition used Y3-END-NEEDS
- `data/fs112/reports/FS112-YB3.md` — read against: Y3's claims confirmed or refuted — surprised: no
- `plans/FS112-NB3-verification.md` §2.3 — read against: the base's print steps derived at FS-110 — surprised: yes; "CB and CE took them from print"
- `LEDGER.md` rows 131–134 — read against: the S–V print sound where used — surprised: yes; three repairs, one failed printed proof and one GAP in row 132
- `plans/FS112-unit-arc-half.md` §R-close stage 3 — read against: the verdict and scores — surprised: no
- `plans/FS112-close-inventory.md` items 58–70 — read against: item 66 open, answered by delegation — surprised: no
- `plans/FRONTIER-STUBS.md`, the top fourteen — read against: FS-114 and FS-115 already inserted — surprised: no; the front-page job has not run, and
  FS-112 still reads rank 1
- `data/viz/proof-atlas/facts.json`, the routes — read against: route `wall7` requires the stuck ray and the cone scale — surprised: no; it predates
  C-COMPOSE, and it draws the doors' composition as held
- `data/fs112/fs112-pa/extracts.md` on Sirgedas — read against: his argument summarised — surprised: yes; of `[16.317]`, `[16.346]`–`[16.349]`,
  `[17.5]` and `[17.282]`, only "Tom Sirgedas got very close to such a proof" is held, and the argument is not
- `CLAUDE.md` § The aim and § Counter-priors — read against: solve HN, verify in Lean, rank routes by bearing — surprised: no

## 5. Hunch ledger

hunch: third-statement-needed
  claim: FS-114's NO at every complexity bound plus a cone-scale lower bound does not give `lim µ₆(ε) < 1` alone; R's (A) at unbounded complexity, a
    uniform hole bound, or a NO for the limit's boundary class is also needed
  basis: derived
  falsifier: a derivation of the composition, as in card 1's falsifier
  registered: 2026-09-27
  status: open

hunch: the-unit-arc-no-is-global
  claim: no explicit radius R excludes every valid fragment about a four-colour vertex; the NO needs a plane-wide count
  basis: analogy
  falsifier: card 2's falsifier
  registered: 2026-09-27
  status: open

hunch: the-base-print-steps-hold
  claim: S–V Lemma 5, Prop. 18, Lemma 6's `< 9` branch and CUSP-BASE's one-mind items hold in the curved a.e. setting with unit arcs (0.8)
  basis: prior
  falsifier: card 3's falsifier
  registered: 2026-09-27
  status: open

hunch: fs115-waits
  claim: FS-114's plan will not commit to the four-colour form for maps that are not periodic, so FS-115 does not open before FS-114's phases (0.65)
  basis: derived
  falsifier: FS-114's accepted plan choosing the four-colour form for aperiodic maps
  registered: 2026-09-27
  status: open

hunch: every-valid-map-has-a-four-colour-vertex
  claim: the terminal modification of every valid six-map with unit arcs has a vertex of at least four colours, outside FS112-C-ENDS's named residue
  basis: derived
  falsifier: a flaw in the chain of §6, or a valid map whose terminal modification has no four-colour vertex
  registered: 2026-09-27
  status: open

## 6. Notes for the planners and the atlas keeper

- **A construction for FS-114's planner to check** (the hypothetical mood; one mind, mine, over the close's links). Suppose a valid map's terminal
  modification `M*` had no four-colour vertex. Then:
  - (L1) its repeated-colour vertices meet every closed disc of radius 3;
  - (L2) each such vertex has at most three colours, so it is stuck;
  - (L3) each lies on a stuck chain that is not infinite in both directions, so the chain has a finite end;
  - (L4, FS112-C-ENDS, one mind) the point one step past that end has at least four colours — a contradiction.

  So every valid map carries a four-colour vertex, outside C-ENDS's residue. Two consequences:
  - A local exclusion about **one** four-colour vertex would be the whole NO, with no ray step and no density (card 2, "if local").
  - Any YES must hold a four-colour vertex, the unit-radius tactic's centre — as the strip and the disk both do.

  This is the four-colour form at its weakest density: the vertex is merely present. It sharpens G83. It is a restatement of the NO, not a smaller step.
- **For the atlas keeper** (memory `proof-atlas-keep-current`).
  - The route `wall7` draws the stuck ray as required. After C-COMPOSE, it is required only in the four-colour form, and only for maps that are not
    periodic.
  - The route draws FS-114 plus FS-111 reaching `χ(ℝ²) ≥ 7` as a held composition. That step is a one-mind reading until card 1 is answered.
- **For the owner's briefs.** Each brief carries the no-children rule with its reason, and the "would have searched here" log. BASE-V's brief quotes
  S–V's four statements verbatim and fences the verifier from FS110-CB, FS110-CE, FS112-N3 and FS112-NB3's treatment of them.
