# M45 — the derivation file: every theorem this milestone stated outside the kernel

*Written 2026-09-22 by the FS-71 batch-2a implementer. Enumeration: `plans/M45-arity-floor.md` read in full (§6
§0a D1–D5, §12, §R R0–R7). Grades are `CLAUDE.md` § Notation's. The milestone's headline finding (M43's "does not
factor" refuted, the seven virtual edges) is already fully recorded as CLAUDE.md's G28 demotion record — not
restated here, per the seed's instruction — leaving one genuinely uncaptured finding: the first confirmed arity-3
compulsion in the project's history.*

## The theorems

**M45-T1 — Three genuine arity-3 compulsions, on the fine-tail critical stage. [tools; the M45 implementer,
confirmed in two independent SAT encodings each, with all sub-pairs separately verified free]** On `core-minus`
(the 159-vertex fine-tail 1-minimal core less its highest-degree vertex — one vertex short of refusing five
colours), **three triples of vertices are compelled** (every proper colouring of the stage identifies their pattern)
**with every one of their three constituent sub-pairs independently verified realizable (free)** — i.e. these are
genuine arity-3 compulsions, not virtual edges in disguise: `(-5,3),(-2,-7),(0,-3)` (monochromatic, 17.8 s free /
31.0 s pinned), `(-3,5),(-2,1),(2,-5)` (monochromatic, 7.0 s / 20.4 s), and `(-2,-5),(-1,4),(0,-1)` (a "two together,
one apart" pattern, 240.6 s / 46.1 s). A fourth candidate found during the same sweep, `(-2,1),(2,0),(5,-1)`, is
**not** a genuine arity-3 compulsion — its norm-13 sub-pair is itself compelled, so the triple's compulsion is
wholly explained by that pair (`explained_by_subtuple`). *Proof:* `plans/M45-arity-floor.md` §R "R3 — genuine
arity-3 compulsions exist, and one near-miss is recorded as such" — each of the three triples and each of their
nine constituent sub-pairs is an exact SAT-decided (UNSAT for the compelled pattern, SAT for the free sub-pairs)
computation, confirmed in a forward and a colour-pinned encoding independently; the near-miss is a fourth SAT
computation whose explaining sub-pair is separately confirmed compelled. *Proof verdict:* closes (exhaustive,
exact, two-encoding-confirmed finite SAT computations on named finite objects — the [tools] grade's own bar).
*Rests on it:* explicitly informs M48's design (`plans/M48-from-below-arity.md`: "M45's arity-3 hits were on a stage one
vertex from refusing" — a design lesson for the complete arity-3 sweep of the 1581, which found zero); §12's own
analysis of what an arity-3 find would mean (it does not compose with G26's forced-distinct-pair route, so it is
recorded as standalone structure, not a rung). *Prior art:* "arity" in this project's sense — the smallest partial
colouring pattern that fails to extend to a proper colouring — is this repository's coined vocabulary for a notion
close to *list-colouring extendability* or *colouring-defect* in the literature, but the exact framing (a compelled
`k`-tuple pattern with every sub-pattern free) was not searched under either name. zbMATH: `ab:"list coloring" &
ab:"forced" & ab:"triple"` (0 hits, 2026-09-22), `ti:"coloring extension" & ab:"unit distance"` (0 hits). Nearest
held key: none on point — the closest is the project's own `arityFloor` framework (row 42, kernel, `Arity.lean`),
which this milestone's D1–D5 also produced and which is already fully kernel-checked. *Kernel:* declined — this is
the first and (as of this audit) only known instance of a genuine arity-3 compulsion anywhere in the project's held
objects; no consumer, and the object (`core-minus`, a specific 159-vertex ball) has no named Lean module.

## Readings and measurements that were called theorems

- **R1, the seven virtual edges refuting M43's "does not factor."** Already fully recorded, verbatim, as
  `CLAUDE.md` G28's demotion record (which this audit's plan §G.1 already cites and which `plans/M43-derivation.md`
  points at rather than restates); not filed again here.
- **R0, D1–D5 of §6** (the `arityFloor` machinery, `arityFloor_le_of_degree`/D4, `realizes_iff_extends`,
  `compels_of_fan`): all now kernel (`Arity.lean`, row 42) — "D1–D5 of §6 were derived on paper and are now kernel
  theorems." Not filed here.
- **R2, the coverage-vs-criticality separation** (51 virtual edges on the complete 9,636-pair sweep of `core-minus`
  against 7 on the same pairs restricted to the R=8 ball): [tools] measurement, a quantitative elaboration of R1's
  finding; already the content G28 summarizes qualitatively.
- **R4, the orbit-completeness observation, inverted under its own control** (cores are 3–30× more orbit-complete
  than random same-size subsets) — explicitly flagged by the milestone itself as **"the control is itself
  suspect"** (a shrink-order confound not ruled out) and its follow-up test **not run**; recorded as an open,
  unresolved measurement, not a theorem.

## Conjectures surfaced, not claimed

(none — every candidate either closed as [tools] or is already recorded elsewhere)

## Prior art re-attributed

(none)

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M45-T1 | declined — the only instance of arity-3 structure held; no consumer; no named Lean object for the stage |
