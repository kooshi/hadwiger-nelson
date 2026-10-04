# FS-131 — the Lean backlog: the kernel plan (de Bruijn, the planner)

*Job FS131-K1, de Bruijn (Opus 5.5), launched 2026-10-03 at HEAD `8613b932`. Brief `data/fs131/briefs/FS131-K1-opening.md`, with
`plans/STANDING-RULES.md`, `LEAN.md` and `RUNNING.md` § Building. Claim list `plans/LEAN-BACKLOG.md` (259 rows; ruling 2 of
`plans/FS131-close-inventory.md`). No phase-1 fence (ruling 1). Working files `data/fs131/k1/`; tools `tools/fs131_k1_*.py`.*

## Theorems this phase proved

None. A planning job: it writes definitions, statements with `sorry` at every leaf, and plans. Any `example` or `theorem` that closes in
the foundation modules is a sanity check of a definition (a spec example), not a backlog row, and is listed under the stage that adds it.

## Stage 1 — SAVED: the readback and the registered expectations

### 1.1 The brief's quotations against their sources (standing rule 3)

Checked by script (exact substring match of each `>`-block against the file its `— source:` line names), 2026-10-03:

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "We will of course need to handle the backlog of lean work …" | `plans/STUB-lean-backlog.md` § The request | exact |
| 2 | "Do not consider Lean formalization a cost. …" | `CLAUDE.md` § Counter-priors | exact (a prefix of the paragraph's quotation) |
| 3 | "- **Dated notes**: every paragraph filed under an entry …" | `plans/LEAN-BACKLOG.md` § How to read this file | exact |
| 4 | "- **Never formalized as filed**: the twelve superseded entries …" | `plans/LEAN-BACKLOG.md` § How to read this file | exact |
| 5 | "1. **Every one of the 259 rows of `plans/LEAN-BACKLOG.md` has one disposition** …" | `plans/FS131-close-inventory.md` § What "Closed" means here | exact |

No mismatch; no finding about the brief.

The backlog itself parses as the brief says: `tools/fs131_k1_rows.py` reads the backlog's own machine tags into `data/fs131/k1/rows.json`
and confirms 259 rows — 178 in § The order, 32 in § FS-129's compositions, 26 in § Left the order, 23 in § Named by a merge line or a caution
— each with a statement block (`--self-test` drops a row heading and renames a statement tag; both fire).

### 1.2 What "Closed" means here, in my words

FS-131 is Closed when every one of the backlog's 259 rows has exactly one of four dispositions, with its reason in this plan, and every row
disposed *formalize* has a Lean declaration that passes the whole gate on one commit — build green through `./scripts/build.sh`, no `sorry`,
`#print axioms` clean except for declared purchases, the vacuity scan green with its counts reconciled, linters silent, spec examples passing,
each check's negative control watched — and whose formal statement has been read back against the row in this plan. No hand result of ours may
remain a hypothesis of a backlog declaration at the close unless it is outside the backlog and named. FS-129 closes with this milestone when
its 32 compositions pass. A row the kernel shows wrong is a result (a statement defect, routed to Ephodos), after which it takes one of the
four dispositions like any other row.

The four dispositions:
- **formalize** — the row gets its own declaration, in its merged form where a merge line names one, else in the form its errata and
  cautions govern;
- **merged into** — the row's content is carried by another row's declaration (that row must itself be *formalize*), so it gets none of its own;
- **excluded** — no declaration: the audit's "do not formalize as stated" (an empty class), a superseded form, or a statement shown false
  (with its corrected form a row of its own, or the counterexample named);
- **outside theorem** — a published result entering as an `axiom`, carrying `LEAN.md` § Assumptions' four items.

### 1.3 Registered expectations (written before reading the derivations closely)

Written after reading the backlog's how-to-read section, its cautions and a one-line digest of every row's statement (no derivation file
opened beyond its header). Scored at the milestone's close.

| # | expectation | probability / interval |
|---|---|---|
| E1 | Statement defects the formalization (skeletons plus implementations) finds among the 210 rows of § The order and § FS-129's compositions: median **12**. Most will be hidden hypotheses — non-degeneracy of arcs and tiles, the disc's radius against the fragment's domain, what "vertex" and "sector" mean at a point of a locally finite arc map — rather than false theorems | 80 % interval [4, 30]; P(≥ 5) = 0.8 |
| E2 | At least one of those 210 rows is shown false as written (beyond caution C109's three FS89 rows, which are outside the 210) | 0.55 |
| E3 | The skeleton stage alone (this job's wave 1) finds at least one defect | 0.6 |
| E4 | Outside theorems entering as axioms: the base of row 134 (`[SokolovVoronov2025]` Cor. 1 almost everywhere, with Lemma 5, Prop. 18, Lemma 6's `< 9` branch, CUSP-BASE) | 0.6 (else hypothesis or a separate job) |
| E5 | Measure rigidity (`[EinsiedlerLindenstrauss2022]` Thm 1.3) enters as an axiom, if any backlog row's declaration needs it | 0.85 |
| E6 | de Bruijn–Erdős (compactness of colourings) is formalized here or found in Mathlib, not imported | 0.75 |
| E7 | The Lebesgue density theorem is in Mathlib in a usable form for the plane | 0.9 |
| E8 | Euler's formula for cellular torus maps (FS114-N114-EULER's input) is not in Mathlib and enters as a hypothesis on a combinatorial map or as a separate job | 0.7 |
| E9 | Waves | median **9**; 80 % interval [6, 14] |
| E10 | Dispositions | formalize ≈ 195, merged into ≈ 25, excluded ≈ 30, outside theorem ≤ 8 |
| E11 | The hardest part is the foundation for planar maps and fragments (tiles, closure colours, sectors, rings, germs, change points), not the leaves | 0.8 |

## Stage 2 — SAVED: §G, the grokkings about the kernel, and what the library already holds

### 2.1 The grokkings, read by number

`.claude/skills/grokkings/SKILL.md` was grepped for `Lean`, `kernel phase`, `formaliz`, `vacu`, `gate`, `cost model`, `re-price`, `skeleton`,
`heartbeat`, `olean`, `Mathlib`, `statement-level` (script in this stage's commit message). **No live grokking is about the kernel, the gate or the
cost model**: those rules moved to `LEAN.md` (§ The kernel's cost model, § The gate, § Searching — Lean) and the method entries that carried them
(G30, G46, G49, G50) are retired. The hits on `gate` and `decide` are the field-level gating of G35/G43 and the English verb. What does bear on
this plan, read in full:

| entry | what it changes here |
|---|---|
| **G92** (a held result reaches as far as its argument) | The backlog's merged forms are G92 applied once by the audit. The plan applies it again at the skeleton: every statement is written at the class its argument reads (`k` colours, Siamese allowed) unless the row's own words name the class, and a hypothesis the proof plan never consumes is reported as a generalization (brief: § What leaves your lane), never silently dropped — the implementer may not change a statement. |
| **G21** (a negative measures its enumeration) | The vacuity gate is this milestone's main defence: every class statement ("no fragment of the class X exists") is a `¬ ∃`, which is never vacuous, but every structure lemma over a class (`∀ F : Fragment …, P F → …`) is a `∀` over a domain that the backlog itself proves empty for many classes (EMPTY-NS, QFREE-NS, OBST). Such rows are excluded, not formalized with `VACUITY DECLARED`, unless a later row consumes them (§ 4). |
| **G86** (tile counts are blind to Siamese pairs) | "Non-Siamese" and "simple" are predicates on a fragment, never baked into the fragment type: a class is a `Prop` on the one `Fragment` structure, so the Siamese-allowed lemmas (most of FS116-N1, V4, V5) and the class statements share one object. |
| **G84, G85, G88** (contact; integer radii; curved tangent interfaces) | The saturated-colouring lane (FS111-M*, FS121) is stated over measurable sets and their density sets, not over maps: "honest", "saturated", "D-NF" and "REG-J′" are predicates on a measurable colouring, and the map structure appears only as the hypothesis REG-J′. |
| **G91** (the ring is the pigeonhole) | The ring `ω(p)`, its points `r(θ) = p + e(θ)`, germs and change points are the central objects of 79 rows (FS116, FS129 lane R); the foundation defines them once, angle-parametrized, so that "60° apart" is `θ + π/3` and the chord lemma FS116-V4-CHORD is the bridge to distance 1. |
| **G87** (the invention signal) | Logged when found; none yet. |

### 2.2 What this library already holds that the rows reuse

Surveyed from `ARCHITECTURE.md` § 3 and the modules' headers:

- **The plane is `ℂ`.** `UnitDistance.unitDistance ℂ` and `Reduction.chromaticNumber_plane_eq_complex` (`EuclideanSpace ℝ (Fin 2)` ≅ `ℂ`), and
  `SpectralChain` states its measure theory over `ℂ`. The foundation follows: `ℂ` carries the metric, `volume` (Lebesgue, through
  `Complex.measureSpace`), rotation by multiplication and `Complex.exp`, so `e(θ) = exp(θ i)` and the 60° rotation is a product.
- **Finite-graph compulsions** for lane A: `Forcer.Forces`, `Fan.Fan`, `Fan.Separated`, `Palette` (compulsions over any palette),
  `FanGap.Slack.forces_iff_of_hom` (row 66 — SA1-6.3 item 1 calls it NOAFF-K's two-vertex case), `UnitQuadrance`, `ResidueColouring`
  (Theorem A, `colorable_of_residue`), `Transcendental` (`unitQuadrance_colorable_of_valuationSubring` — the coset map PLACE-HOM iterates),
  `UnitRing`, `SquareClass.planeOver`, `SpectralChain` (`fieldI`, `StablePrime`, `localBound`, the usable-prime vocabulary).
- **Plane geometry**: `Glue.sphere_inter_sphere` (two-circle intersections), `Coupled.reflAcross`, `Limit` (bounded families within ε of
  unit length force χ — the shape of the slack arguments).
- **Nothing measure-theoretic about colourings of `ℝ²` exists yet**, and nothing about maps, arcs, tiles or fragments. The foundation for
  lanes P and M is new.
