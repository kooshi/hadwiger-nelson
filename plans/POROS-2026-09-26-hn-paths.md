# Poros — paths to the full answer of Hadwiger–Nelson, and to its Lean verification (job PA1, 2026-09-26)

*Advisory record for job PA1 (brief `data/paths-2026-09-26/briefs/PA1-poros-paths.md`, standing rules
`data/fs105/briefs/STANDING-RULES.md` read as "this job"). Written by Poros, Opus 5.5. No planner beside me; this record is the
options Kooshi chooses from. Current state only within each stage; stages are appended and saved in order.*

## Stage 1 — SAVED (the expectation, written before any search or any reading of rows 100–130)

### 1.1 Quotation check (standing rule 5)

| quotation in the brief | source | result |
|---|---|---|
| Kooshi, 2026-09-26: "My goal is to fully solve, and then verify in Lean, HN. Then we publish. (Anything we do must be formalized in Lean before publishing, that's the bar for AI found proofs, and I think we can go all the way to an HN solution)." | `CLAUDE.md` line 111 (§ Publication) | matches word for word; the brief's continuation ("Your recommendation does sound good to me, but spawn a Poros advisor …") is not in any file — it is the owner's transcription, unverifiable from disk, and nothing below rests on it |
| Kooshi on FS-62: "one possibility with some soft evidence" | `CLAUDE.md` line 276; `data/rerank-2026-09-26/briefs/R1-rerank-planner.md` line 16: *"It's just one possibility with some soft evidence."* | a verbatim substring; matches |
| "Where things stand" (three bullets) | the brief calls them orientation, not a source | checked against rows 128–130 in stage 2 |

### 1.2 My expectation (registered before reading the ledger rows, the stubs or any paper)

**Which value.** My prior on `χ(ℝ²)`: **7 at 0.55, 6 at 0.30, 5 at 0.15.** Basis: prior (the literature's mood and its
structural facts as I recall them, none re-read today) — every "nice" colouring class that has been fully analysed needs seven
(hexagonal and polygonal colourings, `[SokolovVoronov2025]`; cell colourings, rows 34–41; G22), every relaxation that is not
integral stops near 4.36 (the fractional chromatic number; row 129 as the brief summarises it), and every lower bound above four
came from a finite witness, never from analysis. Seven is favoured because no one has ever seen a six-colouring of any
structured kind, and five is disfavoured because a five-colouring would have to be wild in a way no construction has hinted at.
Confidence in this prior: **low** — it is exactly the kind of fluent prior this job exists to distrust. What would move it most: a
measurable six-colouring of any kind (→ 6 or 5 up to ~0.5), or a finite six-chromatic unit-distance graph (→ 6 or 7, with 7
favoured).

**Where a proof would most likely come from** (my expectation, before reading how the project now frames it):
1. **From below, six** — most likely from a **finite witness** found by search and certified through the existing LRAT checker
   (the only route that has ever moved the lower bound: Moser 1961 → de Grey 2018), *unless* the collapse to measurable colourings
   (rows 128–130, "given MR") turns an **analytic** argument into a proof of six. I expect the analytic route to need a *joint*
   (multi-class) constraint, not a one-class density bound, and I expect it to be harder than it looks.
2. **From below, seven** — I expect no finite witness is findable (a seven-chromatic unit-distance graph, if one exists, is likely
   astronomically large), so seven would have to come from analysis on the collapsed (measurable) problem, or from a structural
   theorem saying colourings of a field plane are "tame" enough that the polygonal bound applies.
3. **From above, five or six** — only from an explicit construction; I expect none within reach, and I expect the project's
   instruments (residue maps, characters, cut-and-project windows) all to cap at seven or above for the fields that matter.
4. **The Lean side** — I expect the finite-witness route to be the cheapest to formalize by far (the pipeline exists and rung B
   went through it), and any route through MR (entropy, leafwise measures, Einsiedler–Lindenstrauss) to be **very high** cost —
   plausibly years of Mathlib work — so that the cost criterion will favour routes that avoid MR or use only a weak, formalizable
   fragment of it.

**Probability that the project reaches the full answer**, meaning the value of `χ(ℝ²)` proved *and* formalized: **about 0.03–0.05**
over the next year, all routes together. Probability that it reaches a *new bound* (six from below, or a conditional collapse
formalized) in that time: **about 0.15**. These are priors, basis prior, and I register them so the stages below can be scored
against them.

### 1.3 Hunches registered at the opening

```markdown
hunch: mr-is-the-formalization-bottleneck
  claim: every route in the ledger that goes above five without a finite witness passes through MR (row 120), and MR's Lean cost is very high (years), so the cheapest formalizable path to any new headline avoids MR or reduces it to a statement provable from ergodic theory Mathlib already has
  basis: prior
  falsifier: a row among 128–130 whose conclusion does not use MR, or a form of MR the project needs that follows from Mathlib's existing ergodic theorems plus weeks of work
  registered: 2026-09-26
  status: open

hunch: six-needs-a-joint-constraint
  claim: no argument that bounds one colour class at a time (density, fractional, Hoffman-type) can give six; a proof of six on the collapsed problem must constrain several classes jointly (pair or triple correlations, a flag-algebra or SDP hierarchy, a Falconer-type density-point argument on a configuration)
  basis: prior
  falsifier: row 129 or a paper giving six (or a bound above 5 for the measurable chromatic number) from one-class information
  registered: 2026-09-26
  status: open

hunch: the-finite-witness-route-is-cheapest-in-lean
  claim: whatever the value, a finite six-chromatic unit-distance graph with an LRAT refutation is the cheapest route to a Lean-verified headline by an order of magnitude, if one exists at a size a solver can refute
  basis: prior
  falsifier: a finite witness priced (after the ban) at a size the kernel checker cannot absorb, or an analytic route whose Lean cost is priced below it
  registered: 2026-09-26
  status: open
```

### 1.4 "Would have searched here" log

- (none yet)
