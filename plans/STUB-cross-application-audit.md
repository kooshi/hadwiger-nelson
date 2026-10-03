# FS-129 — the cross-application audit: where does each novel result this project holds apply to the others? (stub; Opened 2026-10-03)

*Filed 2026-10-03 17:56 UTC by Keryx, the coordinator, at Kooshi's word, as a **special case**: it is not ranked among the stubs. It runs after the joint filing of
FS-116's and FS-121's closes and after the workflow refinement that follows them, in that order. Its question section, bearings and bearing on the
answer are Poros's to write at its opening, its plan Ephodos's; this file holds the request verbatim and the context a fresh mind needs to plan it.*

## The request (Kooshi, 2026-10-03 17:56 UTC, verbatim)

> Right after this close, we'll be refining the workflow again... then I think it might be worth an audit of all previously novel lemmas and theorems in this project, to see where they can be applied across all others, interweaving and strengthening what we have, and potentially finding new paths. File that as a special case stub for after the workflow refinements.

## What it asks, in plain language (the coordinator's reading; Poros's card replaces it)

Every result this project derived was derived for the milestone that needed it, and filed there. The audit asks the reverse question of each
one: **where else does it bear?** For every novel lemma and theorem, find the other results whose hypotheses it meets, whose steps it shortens, or
whose open steps it closes; then do three things with what is found:
- **interweave**: derive the compositions the record holds the pieces of but never wrote down;
- **strengthen**: weaken hypotheses, promote grades where a second route already exists, merge statements that are one statement;
- **find new paths**: a composition that bears on the answer becomes a stub, ranked as any other.

## What it audits (counts as of 2026-10-03 17:56 UTC; re-count at the opening)

- **`LEDGER.md`**: rows 1–141 (FS-116's and FS-121's rows join at their filing), and § B, one line per theorem proved outside the kernel (1,203
  before the two closes, 1,289 with their drafts).
- **The derivation files**, `plans/*-derivation.md` (99 files), each theorem an entry with its statement, its *not claimed* line, its grade and minds,
  and, since 2026-09-28, a "Rests on it:" paragraph — the one place the record already says what each result feeds.
- **The grokkings**, `.claude/skills/grokkings/SKILL.md` (G1–G90, and FS-116's from G91), with `plans/GROKKING-INSTANCES.md` and
  `plans/GROKKINGS-RETIRED.md`: the mechanisms, which are the natural index for "where else".
- **The kernel**: the Lean library and its trust ledger (`CLAUDE.md` § Trust ledger), where a cross-application is a lemma reused across modules.
- **`CLOSED-QUESTIONS.md`**: a result here may answer a question posed elsewhere.

## Why now: the instances that prompted it (FS-116 and FS-121, 2026-10-03)

- **A mechanism held, and not applied where it bore.** FS116-Y4 found the Γ-free four-colour vertex empty at radius 1 + ε by G83's straddle;
  round 3's construction job had stated both flank edges of the double tip and used each only against a far lens vertex, so the class was worked
  for two rounds, and checked by a blind verifier, as though inhabited (`plans/FS116-close-inventory.md` items 122, 124, 127;
  `plans/FS116-Y4-construction.md` § 3.4).
- **An identity with a closed form, asked after by name.** FS116-V6's `|a − b|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2)` (V6-HUG,
  `plans/FS116-V6-verification.md` § 2.2), and Kooshi's question the same day, "where else can we use that identity?" (FS-116 item 142).
- **Three open claims that are one question.** FS-121's close found that three of its six open claims reduce to one (FS-126;
  `plans/FS121-Z1-close.md` § 2.5).
- **Two files that disagree.** What FS-112's bends leave on a ring is stated two ways in two records, and the difference decides how far a held
  result reaches (FS-116 item 136).

## Precedents (read before planning)

- **FS-71's census** (`LEDGER.md` row 77; G21): every derivation counted and graded, one entry each; it measured the corpus, it did not cross-apply it.
- **The consolidation run of 2026-09-27** (`plans/CONSOLIDATION-2026-09-27.md`): the last whole-corpus pass.
- **G49**: in-house vocabulary hid prior art; the same vocabulary can hide a result from its own neighbours, one milestone to the next.

## Method and staffing: decided (Kooshi, 2026-10-03)

**Opened.** The method, the passes and the staffing are Kooshi's decisions, recorded with his words in `plans/FS129-cross-application-audit.md`
(the plan) § 1: never pairwise (about 1,300 theorems make about 850,000 pairs) but one index, the dependency map, then three passes in
order — open steps, mechanisms, merges and strengthening — split into two era lanes that each read the whole corpus against their own held
results, so the arithmetic era is asked whether it bears on the measurable question; within the cap of three agents, the readers
`general-purpose` agents that read the deriver's identity rather than the agent file that preloads the grokkings; and the audit prepares
the Lean backlog's input. The registered expectations and the failure clauses are the plan's § 7 and the jobs'. Any derivation it produces
meets the same standard as every other: held once its Lean module passes the gate (Workflow 3.1); until then, derived, one mind.

## The question (Poros, 2026-10-03)

*Posed by Poros, job FS129-Q1; the record is `plans/POROS-2026-10-03-fs129-card.md`, stage 2. The demand list it aims is
`data/fs129/demand-judged.md` (24 steps, ranked by bearing on the answer, each with my reading of its kind of input as a hunch).*

### The card

question: what-kind-of-input-closes-each-step
  evidence: both instances that prompted this audit missed an input of the right kind, held under another name. FS116-Y4's flank tiles needed a
    distance below 1 between two same-colour tiles pinned to unit circles, held as G83's straddle and applied to neither flank edge for two rounds
    (`plans/FS116-close-inventory.md` items 122, 124, 127); TOP₆ needed the coverage of a boundary point's unit circle by the other colours, held as
    G13's `fan_iff_coverage` and never asked (`plans/FS121-Z1-close.md` § 4.1). Held no-gos already exclude kinds: G86 (tile counts, with Siamese
    pairs), row 129 (one class at a time), row 131 (holes met by circles; trichromatic points), G73 (cell-local topology at four colours), row 91
    (pair correlations on a real field), FS121-D4-TINY16 (counts per region), FS121-C1-FLAT (germs at the chain's points)
  expected: that the audit's unit is the theorem — "which held result closes this step?" — as the plan's pass 1 words it
  ask: For each open step, what kind of input must every argument that closes it read — given the held no-gos that exclude kinds — and which held results, in either era and under any name, deliver that kind?
  if a held result of an admissible kind exists that the step's stub does not cite: the reader derives the composition, or records the null with the missing hypothesis named
  if no held result delivers an admissible kind: the step's line says "needs a new kind of input", with the excluding no-gos; its stub's opening runs recognition outside the corpus first, and the audit stops reading for it
  if two steps need the same kind: they are worked together, the higher-ranked first, and both lines say so
  answered by: derivation — the pass-1 readers FS129-OA1 and FS129-OR1, one line per step written before the era's statements are scanned
  cost: one line per step before reading; no new job
  hunch: at least a third of the list's steps need a kind of input no held result delivers, and those are the steps the next milestones open on
  falsifier: the readers find a held result of an admissible kind for more than two thirds of the steps
  rank: 1

### Existence form

For a step on the demand list: is there a held result — in either era, under any name — whose hypotheses the step's setting meets, and which
closes the step, shortens it (a named case closed, a hypothesis removed), or reduces it to another step?

### Structural form

For every open step of the project, in every class where it is posed (general and saturated; non-Siamese and Siamese; at five colours and at
six): what kind of input must every argument that closes it read, once the held no-gos have excluded kinds — and which steps have an admissible
kind that no held result, in either era, delivers? It cannot be answered without the invariant every closing argument carries: the kind of input
it reads (points and distances, contact at distance exactly 1, coverage of a circle, a count, a density, a spectrum or correlation, an invariant
of a colouring of a circle or lattice, a modification lemma, compactness or symmetry). It is not the existence form reworded: its answer is a
classification of the open steps with a gap set, informative where no composition exists, and the gap set is what the next milestones should
open on; the existence form is answered step by step, by one result or a null.

## Bearing on the answer

**None by itself; its ceiling is its demand list's.** The audit moves the answer only through the steps it closes or reduces
(`data/fs129/demand-judged.md`), the highest by bearing: whether FS-112's bends keep a fragment in FS116-Y4-EMPTY's class (J1, which would close
FS-123's half and shorten FS-124's case list); SEMI-PAR3, the placing rule's one exception (J2); NO-SAT's cases, the class route M's honest branch
consumes (J3); and a step smaller than TOP₆, the last statement of that branch (J4). Each is a piece of route M toward `χ(ℝ²) = 7` given MR, and the
failure of J1–J3's exclusions — valid fragments on discs of every radius — is `χ(ℝ²) ≤ 6` with no MR (FS116-O1-YESLIM). Its structural product, the
steps that need a kind of input no held result delivers, aims the next milestones whatever the compositions. **One route found unowned:** the map
step at five (FS111-REG-JP-C5; J10), which with held FS106-AE-MAP6 is a route to `χ(ℝ²) ≥ 6` given MR, is carried by no open stub since FS-121's
close. **Decision 4:** the arithmetic era's two concrete sites are TOP₆'s coverage (G13, row 66, G54) and FS-104's correlation route (rows 111–113,
124; G73, G75); a null there is a finding. Registered (Poros, scored at the record job): the audit changes `CLAUDE.md` § Where the problem stands
item 31's open list or the top three, P = 0.2; the arithmetic era bears on a regularity-era step, P = 0.35.

## Deliverables (from the request)

- For each novel lemma and theorem, where else it applies, with addresses.
- The compositions derived (interweaving), each an entry in a derivation file at its grade.
- The strengthenings (weaker hypotheses, grades promoted, merged statements), filed at their grades.
- New stubs for the new paths, ranked by Poros.
