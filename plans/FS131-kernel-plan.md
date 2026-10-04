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

## Stage 3 — SAVED: §PA, the prior-art gate for the formalization

### 3.1 Mathlib's coverage of the objects the rows are stated over (grepped at the pin, `v4.32.0`)

| object | in Mathlib? | where / what the foundation does |
|---|---|---|
| the plane, unit circles, rotations | yes | `ℂ` (normed, `InnerProductSpace ℝ ℂ`), `Metric.sphere`, `Complex.exp`, `Complex.abs`; the library's plane (§ 2.2) |
| Lebesgue measure on the plane | yes | `Complex.measureSpace`, `Complex.volume_preserving_equiv_real_prod` (`MeasureTheory/Measure/Lebesgue/Complex.lean`) |
| arc-length on the unit circle, `Leb ⊗ σ` | partly | `AddCircle`'s Haar measure exists (`Analysis/Fourier/AddCircle.lean`); the foundation parametrizes `σ` by the angle on `[0, 2π)` with `volume.restrict (Ico 0 (2π))`, which is `σ` up to the constant `1` and makes every "null for `Leb ⊗ σ`" statement a plain product-measure statement (`Measure.prod`) |
| Lebesgue density points | yes, as a theorem | `Besicovitch.ae_tendsto_measure_inter_div` (`MeasureTheory/Covering/Besicovitch.lean:1105`; ℂ is a finite-dimensional real normed space, so `Besicovitch`'s covering instance applies); no `IsDensityPoint` definition — the foundation defines `densitySet A` (the points of density 1) and `upperDensityAt A x` (`limsup` of the ball ratio) |
| upper density of a set in the plane (µ_k, the slack suprema) | no | defined in the foundation's lane-P module of the wave that needs it (wave P2), as the `limsup` of `volume (A ∩ ball 0 R) / volume (ball 0 R)` |
| path-connectedness, connectedness, components, closures | yes | `IsPathConnected`, `IsConnected`, `connectedComponentIn`, `closure` |
| Steinhaus (`A − A` contains a neighbourhood of 0) | yes | `MeasureTheory.Measure.div_mem_nhds_one_of_haar_pos` (additive form generated) |
| Zorn (maximal covers) | yes | `zorn_le`, `zorn_le_nonempty` |
| weak-* compactness (FS106-EQ (c) ⟹ (a), YESLIM) | yes | `WeakDual.isCompact_polar` (Banach–Alaoglu) |
| compactness of probability measures (SUPK's attainment, stationary families) | yes | `MeasureTheory/Measure/Prokhorov.lean:167`, `CompactSpace (ProbabilityMeasure E)` for compact `E` |
| de Bruijn–Erdős | yes, as Rado selection | `Combinatorics/Compactness.lean`: `Finset.rado_selection`, `Set.Finite.rado_selection`; de Bruijn–Erdős is a corollary of under an hour — **formalized here**, not imported |
| closed subgroups of `ℝ²` (NOPERLAW: not discrete ⟹ contains a line) | no (only `ℝ`'s dense-or-cyclic) | formalized here (wave A2) |
| number fields: ramification at 2, residue degrees, Kummer–Dedekind | yes | `Ideal.ramificationIdx`, `Ideal.inertiaDeg`, `NumberTheory/KummerDedekind.lean`, `NumberTheory/NumberField/Ideal/KummerDedekind.lean` — SQRT3-LOCAL's route (`F(i) = F(√−3) = F(ζ₃)`, `x² + x + 1` separable mod 2) is formalized here |
| locally finite maps bounded by segments and circular arcs, tiles, sectors | **no** | the foundation's lane-M model (§ 5), point-set: a closed boundary set that is a locally finite union of arcs, tiles = components of its complement in the domain |
| planar graphs, faces, Euler's formula (plane or torus) | **no** (`eulerCharacteristic`, `Euler` formula: no hits) | route T's count (FS114-N114-EULER and its consumers) is stated over a combinatorial torus map; the bridge from a doubly periodic valid map to a cellular torus map is an outside theorem candidate (§ 3.3) |
| the Jordan curve theorem | **no** (no hit for `Jordan curve`) | avoided: every foundation notion is point-set (components, closures); rows whose statements need it (FS114-CVB-THOM's facial cycles, FS121-D4-HOLE's bounded complementary component is point-set and does not) are flagged at their wave |
| semiconcave functions, `C^{1,1}` curves | no `semiconcave`; `ContDiff`, `LipschitzWith` yes | defined at the wave that needs them (P4), as a `LipschitzWith` derivative and a supporting-paraboloid inequality |

### 3.2 Formalizations in print

One web search (2026-10-03, "Lean formalization Hadwiger-Nelson measurable chromatic number plane Falconer"; listings only, nothing read):
no formalization of measurable colourings, density arguments, or planar maps of the plane was found. Two listings: a Zenodo record claiming a
formal verification that the plane is seven-chromatic (not read; the claim is the open problem, and nothing in this plan rests on it), and a
GitHub repository `decalion89/chromatic-number-of-the-plane` (release v1.1.0) whose listing says it holds Lean 4 proofs of χ(ℚ(√2,√3)²) = 4 and of
Fischer's χ(ℚ(√3,√11)²) = 4 — the content of ledger rows 103 and 57, already in this kernel. **Prior-art debt** (listing only, not read):
those two kernel results have an independent Lean formalization in print; for Keryx to route to `BIBLIOGRAPHY.md` and the claim list.

### 3.3 The outside theorems the rows rest on: formalize, axiom, or separate job

| theorem | rows | decision | why |
|---|---|---|---|
| Lebesgue density, Fubini–Tonelli, Steinhaus, Zorn, Banach–Alaoglu, Prokhorov | lane P throughout | **Mathlib** | § 3.1 |
| de Bruijn–Erdős | FS106-EQ, FS116-O1-YESLIM, FS129-OR1-TOP5's consumers | **formalize** (wave P2) | Rado selection is in Mathlib |
| closed non-discrete subgroups of `ℝ²` contain a line | FS129-OA1-NOPERLAW | **formalize** (wave A2) | classical, an hour or two |
| Krylov–Bogolyubov for `ℤ²` on a compact space (stationary families exist) | FS129-SR2-SUPK's attainment clause | **formalize** (wave P2) | Følner averages plus Prokhorov compactness |
| `[Falconer1981]` Lemma 1, in the paper's form only (SA1-6.3 item 6) | FS129-SA1-FALC-RED | **decide at wave A2's planning job**, after reading the lemma (held: `library/papers/falconer-1981-…pdf`, read in full by FS103-M) | formalize if under an hour (it is a density argument), else an axiom with the four items |
| the base of row 134 (`[SokolovVoronov2025]` Cor. 1, almost everywhere, curved cubic maps, no `d = 2` exception; with Lemma 5, Prop. 18, Lemma 6's `< 9` branch, CUSP-BASE) | FS112-N3-BASE and through it N3-DENSE3, FS114-CV-EXISTS, FS129-OR1-LOCALDENSE | **explicit hypothesis** `Row134Base`, never an axiom; its formalization is a **separate planner-and-implementer job** (stub to mint: FS-110's module) | the printed proof needed repair here (FS110-CB, -CD, -CE), so the statement used is ours, not the paper's; an axiom would import a statement no paper prints. It is outside the backlog (not a row), so inventory item 3 permits it as a named hypothesis at the close |
| measure rigidity (`[EinsiedlerLindenstrauss2022]` Thm 1.3) and row 130 | FS111-C-SIX-M's and FS111-M2-REDUCE-C's "hence χ(ℝ²) ≥ 6" clauses | **explicit hypothesis**: row 130's conclusion `χ(ℝ²) = χ_m⁰(ℝ²)` as a named `Prop` | row 130 is our hand result over MR; MR itself enters nowhere in this milestone (FS-113 holds it) |
| Euler's formula for cellular maps on the torus, and the passage from a doubly periodic valid map to one | FS114-N114-EULER, -N2-FIVE, -N114-ROOM, -N2-ENDS, -N3-JOINT | **combinatorial maps here; the passage a separate job or an axiom, decided at wave M5's planning** | the count is algebra on a combinatorial torus map (a rotation system with `V − E + F = 0`); the topological passage needs the Jordan–Schoenflies machinery Mathlib lacks; Euler's formula for surfaces is classical and would carry the four items if imported |
| `[Woodall1973]` Thm 6, `[Townsend1981]`'s lemma, `[Thomassen1999]`'s steps | FS106-WO, -TW, -AE-MAP6, FS114-CVB-THOM | **formalize the mathematics, as ours** | the rows' mathematical content is the repaired statement; the verdicts on the printed texts ("step 6 is a GAP") are not statements a kernel checks (§ 4) |
| `[Voronov2023]` Thm 1.1 | FS106-COMP's second clause | **no import**: the equivalence names Voronov's statement as a `Prop` | the clause is an equivalence, not a use |

**FS-101 and FS-113.** This milestone absorbs **neither**. FS-113 (measure rigidity in full) is a formalization project of its own and no backlog
row needs MR as an input (rows needing row 130 take its conclusion as a named hypothesis). FS-101's route (Markov–Kakutani, the upper half,
Herglotz–Bochner, then its step 4) is its own; the eight J45 rows of § Named are FS-101's step-4 interfaces N1/N2 and their neighbours, and they
are disposed *formalize* in this milestone's last arithmetic wave (A4) **stated against `SpectralChain`'s existing objects**, so that FS-101 consumes
them by name. If Kooshi prefers FS-101 to formalize them in its own order, A4 moves to FS-101 unchanged (a ruling, § 4.4).
