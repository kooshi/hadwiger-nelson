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

## Stage 4 — SAVED: the dispositions

### 4.1 The file and its checker

`data/fs131/k1/dispositions.csv` — one line per backlog row: `id, section, disposition, merged_into, replacement, wave, module, extra_upstream,
outside_backlog, ruling, reason, address`. It is written by `tools/fs131_k1_make_dispositions.py`, where every non-default decision is one line with
its reason and the address of that reason (so a ruling that changes a disposition is a one-line edit there, and the CSV is regenerated), and checked
by `tools/fs131_k1_dispositions.py`, which reads the backlog's own `<!--row-->` and `<!--needs-->` tags independently of the parser:

```
$ python3 tools/fs131_k1_dispositions.py
OK: 259 rows, each once; {'formalize': 205, 'merged into': 25, 'excluded': 29}; every merge target formalize; every exclusion cited;
every upstream in an earlier or the same wave
$ python3 tools/fs131_k1_dispositions.py --self-test
  plant duplicate id: FIRED · plant missing id: FIRED · plant merge into a non-formalize row: FIRED · plant excluded without reason: FIRED
  plant upstream in a later wave: FIRED · plant excluded upstream not dropped: FIRED
self-test: every plant fired
```

The upstream check resolves each upstream id through its disposition: a merged upstream to its targets, an excluded one to its corrected form (FS112-L60
→ FS114-L60-LE), and an excluded one with no corrected form only if the row's reason says "drops <id>" (one case: FS116-S1-KAPPA drops FS116-V4-OUTER
with its last clause). Rows outside § The order carry no `needs` tag in the backlog; the eleven edges this plan adds are the CSV's `extra_upstream`
column. One upstream id is not a backlog row at all (§ 4.3, finding F2).

### 4.2 The summary

| section | formalize | merged into | excluded | outside theorem |
|---|---|---|---|---|
| § The order (178) | 137 | 18 | 23 | 0 |
| § FS-129's compositions (32) | 30 | 2 | 0 | 0 |
| § Left the order (26) | 23 | 0 | 3 | 0 |
| § Named by a merge line or a caution (23) | 15 | 5 | 3 | 0 |
| **all 259** | **205** | **25** | **29** | **0** |

**No row is an outside theorem**: every backlog row is our own result. The outside theorems the rows rest on (§ 3.3) enter as Mathlib lemmas, as
supporting declarations formalized here, or — row 134's base, row 130's conclusion, row 123's chain — as named hypotheses outside the backlog; one,
`[Falconer1981]` Lemma 1, is decided at wave 2's planning job (formalize or an axiom with the four items).

Where the 25 merges come from: the audits' lines (SR1 items 3, 7, 8; SR2 items 9–13, 16, 20–22; SR3 items 23, 24, 26; SA1 items 1, 7), each cited in the
CSV, plus four of this plan's (FS129-SR2-QFCASE, FS129-SR2-YESLIM-EQ, FS116-RING-TRANSFER-C, FS114-L60-WALK — rulings R5–R8 below). The 29 exclusions:
the audits' DNF lines (SR1: 15 rows of empty classes; SR2: FS112-L60, FS112-BUDGET2, FS111-C-HULL-SO; SA1 item 8: ASTRA-2026-09-14-T10) and ten of this
plan's (rulings R1–R3).

Partial forms kept as *formalize* (the reason column says which clauses): FS106-DIAM (i)–(ii), FS106-COMP's second clause, FS111-M2-HULLC without its
semiconcave clause, FS114-N3-JOINT without its first, FS112-U1's shadow clause, FS129-MA2-FALC-HOSTS (ii)–(iv), FS114-Y6-E2RED's chain clause,
FS116-S1-KAPPA without its last clause; forms the audits changed: FS121-D4-FACE with FACE-SHARP's hypothesis, FS114-Y5-PINALL's narrowed exception, the
three FS89 rows with `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1` (C109); errata governing: FS112-C-ENDS, -C-DOUBLE, -N3-BASE, FS114-N2-ENDS, -N3-JOINT (C116; the
other two C116 rows, FS112-L60 and FS114-N7-3T, are excluded). V6-HUG keeps its own colour step (C126, C131).

### 4.3 The ruling list (each needs Keryx's ruling; the CSV's `ruling` column marks the rows)

- **R1. FS114-K1 excluded: it is not a held result.** Its entry's verdict is "gap" (`plans/FS114-derivation.md:810`: "verdict: gap: the cases no entry
  above excludes — rings with (Q) arcs …"), it has no grade and no handoff, and its "disc of explicit radius" names no radius. It is FS-114's open local
  question (K1), which § Left the order carries as a row. Ruling 3's default (*formalize*) cannot apply to a statement nobody proved. (**Finding F1**, a
  backlog defect: a gap-verdict entry entered the backlog as a row.)
- **R2. Two second-route lemmas over QFREE-NS's empty class excluded**: FS116-S1-LENS and FS116-V4-OUTER (non-Siamese valid six-coloured fragment, a
  four-colour vertex, a ring with no (Q) arc — empty by FS129-SR3-QFREE-NS). They serve only S1-QF's second route (SR3 item 23); formalized, they would be
  declarations over an empty domain with no consumer, each a `VACUITY DECLARED` entry bought for nothing.
- **R3. Seven first-route lemmas over EMPTY-NS's empty class excluded**: FS116-Y3-SIX, -Y3-TIPS, -V5-RING (beyond the two clauses FS116-N1-TWIST-D
  carries), -V5-OUT, -V5-GERM, -V5-TIPSET, -V5-LENS. Their class (a non-Siamese six-coloured fragment whose ring carries no arc of Γ) is empty by
  FS129-SR3-EMPTY-NS; their consumers are FS116-Y4-EMPTY's first route, the audit's DNF rows and each other (checked by script over the backlog's edges);
  SR3 item 24 proves EMPTY-NS on FS116-V6's route instead. The audit's DNF list stopped at the rows it named; these are the rest of the same route.
- **R4. FS116-V6-HUBS, -V6-ANTI, -V6-HUG, -V6-COUNT formalized without "simple".** SR3 item 24 proves EMPTY-NS — the non-Siamese class, simplicity not
  assumed — on V6's route, so the route's lemmas must hold at that class; their rows say "non-Siamese simple". The plan states them at the non-Siamese
  class, as steps of EMPTY-NS's proof, each `VACUITY DECLARED` (their class is empty by the theorem they serve). A statement change, though the audit's.
- **R5. FS129-SR2-QFCASE merged into FS129-SR3-QFREE-NS** (S1-QF's statement as QFREE-NS's direct case, SR3 item 23): a one-line corollary in the same
  module, not a second declaration with a row of its own.
- **R6. FS129-SR2-YESLIM-EQ merged into FS116-O1-YESLIM**: SR2 item 18 makes YESLIM-EQ the proof of YESLIM's first clause; YESLIM is the declaration.
- **R7. FS116-RING-TRANSFER-C merged into FS116-N2-FIVERING and FS116-N2-SIXRING**: SR1's DNF list excludes its four-colour clause; the five- and
  six-colour clause that remains is those two rows' content.
- **R8. FS114-L60-WALK merged into FS114-L60-LE**: it is a statement about proofs ("no step of RED, COR3, BASE, DENSE3, CV-EXISTS needs the strict
  bound"). The kernel checks it when those rows are formalized over L60-LE's non-strict bound, which this plan requires of waves 4–5.
- **R9. Verdict clauses dropped from four rows, their mathematics formalized**: FS106-WO (Woodall's Thm 6 as repaired, the step-4 lemma for arcs
  longer than 2π/3), FS106-TW (Townsend's π/3 lemma), FS112-N2-RAY (the one-sided chain satisfies N4-FIN's one-sided inequalities and N4-CONE's step
  fails there), FS114-CVB-THOM (Thomassen's steps other than the rainbow step, each stated for valid maps). "Step 6 is a GAP", "is a GAP" and "the
  steps hold" are verdicts on texts and proofs, not statements a kernel checks.
- **R10. TC1-STANDING-FIVE (conditional seed, C13)**: its unconditional clauses (the degree-28 field, its places above 2 inert of norm 128, no usable
  residue field of size ≤ 47, so `L(F) ≥ 7`) are formalized in wave 10; its clause "given MR, χ(F²) ≥ 5" as an implication from row 123's chain taken
  as a named hypothesis (FS-101's). The other two conditional seeds: FS116-Y4-SPOKE is excluded (SR1's DNF list, empty HEX3 class); TC1-SQRT3-DYADIC is
  merged into FS129-SA1-SQRT3-LOCAL (SA1 item 7), whose general form carries no condition.
- **R11. The eight seeds the audit excluded as empty stay excluded** (FS116-Y3-NOQ, -Y3-TIGHTLENS, -Y3-STARFORCE, -Y4-SPOKE, -N2-HEX6, -N2-HEX3, the
  four-colour clause of -RING-TRANSFER-C, and FS114-N7-3T through N7-HUB): their emptiness is itself formalized, once, as FS129-SR3-EMPTY-NS (with
  FS116-Y4-OBST merged into it) and FS129-SR3-QFREE-NS; a structure lemma over an empty class adds nothing the emptiness theorem does not carry.
- **R12. § Left the order**: 23 of 26 formalized; the three not formalized are FS111-C-HULL-SO and FS112-BUDGET2 (SR2's DNF list) and FS114-K1 (R1).
- **R13. FS111-M-REDUCE-I is formalized beside FS129-OR1-TOP5 in wave 9** as a supporting lemma: OR1-TOP5's `uses only:` names it and it is not a
  backlog row (**finding F2**, backlog completeness; without it TOP5 would carry a hand result of ours as a hypothesis, which inventory item 3 forbids
  for a backlog declaration only if the result is inside the backlog — so it is permitted, but formalizing it is cheaper than naming it).

Findings sent to Keryx with this stage: F1 (R1), F2 (R13), and the prior-art debt of § 3.2.

## Stage 5 — SAVED: the foundation (`debruijn-domain-modeling`, invoked fresh)

Keryx ruled R1–R13 as proposed (`plans/FS131-close-inventory.md` items 5–9, commit `17cc301b`), with two conditions now in the CSV's reasons:
FS116-V6-COUNT keeps its last step in its sector form (SR3 § 2.1: the two tippers of `y_k` and of `y_{k+3}`); TC1-STANDING-FIVE's MR clause takes
row 123's chain as the named hypothesis `Row123Chain`, from outside the backlog (§ 7.4 lists every such hypothesis).

### 5.1 The model, and why this shape

Four modules under `Proofs/HadwigerNelson/Plane/`, on `main`, sorry-free, in the gate:

| module | holds | the modeling decision |
|---|---|---|
| `Plane/Basic` | `e θ = exp(θi)`, `ringPt p θ = p + e θ` (the ring point `r(θ)` of `ω(p) = Metric.sphere p 1`), `arcLength` (Lebesgue on `[0, 2π)`, a finite measure) | **angles are reals**, not `Real.Angle`: the rows reason with intervals of angles (cones `[θ₁, θ₂]`, "just clockwise of `r(ψ)`"), which `ℝ` orders; periodicity is a lemma. `σ` is parametrized by the angle, so every "`Leb ⊗ σ`-null" is a plain `Measure.prod` statement |
| `Plane/UnitPairs` | `unitPairSet A`, `UnitPairsNull A`, `densityRatio`, `densitySet A` (`Ã`), `upperDensityAt A x` (`d̄_A(x)`), `essSupport A` (`supp A`) | **the primitive is one set, not a colouring** (intrinsic: CLOSURE, HULLSET, ID1, M2-INT, M2-ZERO are each about one class; the audit restated them that way). Density with closed balls, matching `Besicovitch.ae_tendsto_measure_inter_div` exactly, so the Lebesgue density theorem applies with no translation |
| `Plane/AeColouring` | `AeColouring k` (measurable `ℂ → Fin k`, each fibre `UnitPairsNull`), `chiM0` (`χ_m⁰(ℝ²)` as an `ℕ∞` infimum) | a colouring is a **total function**; covers and partial colourings (µ_k, maximal covers) are wave 2's, over the same `UnitPairsNull`. `χ_m⁰` is `⨅ k, ⨅ (_ : Nonempty (AeColouring k)), k` — `⊤` if no `k` works, never a junk `0` |
| `Plane/ArcMap` | `Arc` (segment, circular arc; `IsUnitArc`), `ArcMap k` (open `dom`, a locally finite set of nondegenerate arcs, `col : ℂ → Fin k` locally constant off them), `Γ`, `interiorPts`, `region`, `IsTile`, `coloursAt` (`P_cl`), `Valid`, `Covers p R`, `IsPlaneMap`, `Siamese`, `NonSiamese`, `IsJordanDomain`, `Simple` | **one structure for valid maps and fragments** (a valid map is `IsPlaneMap ∧ Valid`; a valid fragment on `B̄(p, R)` is `Covers p R ∧ Valid`); **point-set, not combinatorial**: tiles are connected components (`connectedComponentIn`), `P_cl(x)` is the colours whose region has `x` in its closure, so "a vertex of at least four colours" is `4 ≤ (F.coloursAt p).ncard` with no separate vertex notion; **classes are predicates on the one structure** (G86), so Siamese-allowed lemmas and class statements share their objects. The colour is a function on `ℂ` read only at interior points — extrinsic placement, no subtype of the domain threaded through every lemma |

The incidental structure refused: the derivations' own case split into "maps" (FS-110, FS-112) and "fragments" (FS-114, FS-116) — one object with
a domain; a combinatorial planar map (vertices, edges, faces), which would need the Jordan curve theorem Mathlib lacks to connect to the rows'
geometry — the rows never need faces, only components and closures; `Real.Angle`; a separate type per class.

What the next waves add, each in its own module (§ 7): wave 2 the partial colourings, covers, `µ_k`, tight/slack/band-proper, saturated and
`D-NF`; wave 3 the ring vocabulary (arcs of `Γ` on `ω(p)` with their side colours, (Q), germs, change points) and `isOpen_interiorPts`; wave 4 the
sectors, degrees, cones and `𝓜_K`; wave 7 the combinatorial torus map for route T.

### 5.2 Validation (the seams)

Every definition has a spec example that fails if it drifts, and every structure a later theorem takes has a named inhabitant or a note naming
its supplier:

- `e`: `e 0 = 1`; two ring points `60°` apart are at distance exactly `1` (`Real.cos_pi_div_three`, `Real.sin_pi_div_three`). `arcLength univ = 2π`.
- `UnitPairsNull`: a disc of radius `1/3` has null unit pairs; **adversary** `not_unitPairsNull_ball_two` (a disc of radius 2 does not: the pair
  set holds `B(0, 1/2) × [0, 2π)`, of positive product measure) — the definition is not trivially satisfied.
- `densitySet`, `upperDensityAt`, `essSupport`: every point is a density point of `ℂ`, none of `∅` (adversary); `d̄_ℂ ≡ 1`; `x ∈ supp ℂ`,
  `x ∉ supp ∅`.
- `AeColouring`, `chiM0`: `IsEmpty (AeColouring 0)`, **adversary** `IsEmpty (AeColouring 1)` (its class is `ℂ`, which holds the disc of radius 2),
  hence `2 ≤ chiM0`. Inhabitant: none is cheap — any finite full colouring is a theorem; FS111-W-SQ9 (wave 2) supplies one at `k = 9`.
- `ArcMap`: inhabitants `ArcMap.const` and `halfDisc` (the disc of radius `1/3` cut along the real axis, colour 1 above). A valid fragment
  (`const` on `B(0, 1/3)`); **adversary**: `const` on `B(0, 1)` is not valid (`±1/2`); `halfDisc.coloursAt 0 = univ` (both colours at the cut's
  midpoint — checks `Γ`, `interiorPts` and closure colours together); `halfDisc.NonSiamese`; **adversary**: `halfDiscMono` (the same tiles, one
  colour) has a Siamese pair (`halfDisc_component_upper`, `-_lower` identify the tiles as the two half-discs); `const` on `B(0, 1)` is `Simple`
  (its tile is the disc, a Jordan domain by `closure_ball`).

### 5.3 The gate on this commit

- `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): **OK** — 438 of 438 batches, 5 modules rebuilt (the four
  and `Proofs`), **0 modules with warnings**, 8 m 2 s (`build/gate/build/20261004T043057Z-1091664.log`).
- `./scripts/axioms.sh`: **OK — 1257 clean, 11 axiom-free, 5 declared purchases**; the 21 new records all `[propext, Classical.choice,
  Quot.sound]` (`build/gate/axioms/20261004T043951Z-1129351.log`).
- `./scripts/vacuity.sh`: **OK**; sites unchanged (`sites=279 vacuous=0 stale=0 declared=3 witnessed=17 generic=257 unknown=2`); declarations
  7438 → 7557 and refutations-skipped 313 → 314 since the last recorded run (2026-09-26; the 119 new declarations include other jobs' since then;
  `not_unitPairsNull_ball_two` is the one new refutation); two new `EVIDENCE EMPTY` lines, the two `IsEmpty (AeColouring _)` instances
  (`build/gate/vacuity/20261004T044008Z-1129846.log`).
- `tools/check_architecture.py`: exit 0 — 182 module rows, 0 import mismatches (new § 3.11 and its layer-table row).

**Drafts for Keryx** (files I do not write): `CLAUDE.md` § Trust ledger, "1236 clean" → "1257 clean"; `CLAUDE.md` § The gate,
`declarations=7438 refutations-skipped=313` → `declarations=7557 refutations-skipped=314` (sites line unchanged); the same two numbers in
`scripts/vacuity-baseline.txt`'s header.

## Stage 6 — SAVED: wave 1's skeleton (`debruijn-obligation-modeling`, invoked fresh)

### 6.1 Where it is, and how the implementer works

**Branch `fs131-w1`, head `3358a401`** (pushed to origin), seven modules, 14 rows, **28 `sorry` leaves**, building through `./scripts/build.sh`
in the worktree (440 of 440 batches; the only warnings are the 28 `declaration uses 'sorry'`; `build/gate/build/20261004T050005Z-1179761.log`
in the worktree). `Proofs.lean`, `ARCHITECTURE.md` § 3.11 (seven rows; `tools/check_architecture.py` exit 0, 189 rows, 0 mismatches) and
`scripts/Axioms.lean` (28 records) are already updated on the branch, so the wave lands by fast-forward once the gate is green.

FS129-SR1-RINGBAND moved from wave 1 to wave 3 at this stage (its circle-colouring lift is ring vocabulary; nothing in wave 1 consumes it); the
CSV and checker are re-run green (wave 1: 14 formalize rows).

**The worktree recipe** (Keryx's word, Kooshi's this session: "use symlinks to avoid full rebuilds as we've done before";
`plans/CRUNCH-2026-09-25-queue.md` § 1.6). The wave-1 worktree already exists at
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w1` (branch `fs131-w1`); for any later wave:
```bash
cd /home/kooshi/source/lean-dir
git worktree add -b fs131-wN .claude/worktrees/fs131-wN main
mkdir -p .claude/worktrees/fs131-wN/.lake
ln -s /home/kooshi/source/lean-dir/.lake/packages .claude/worktrees/fs131-wN/.lake/packages
cp -a /home/kooshi/source/lean-dir/.lake/build .claude/worktrees/fs131-wN/.lake/build     # 4.4 GB, ~20 s
```
**Never symlink `.lake/build`** into a tree that compiles: two trees writing one build race on the same `.olean` paths, and the corruption looks like a
proof failure. **One Lean build at a time across all trees**, always the worktree's own `./scripts/build.sh` under
`/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` (run from inside the worktree). For
iteration, `lake env lean <file>` in the worktree, never as evidence. The wave lands when the full gate is green on one commit in the worktree
(build with zero warnings, `scripts/axioms.sh` clean — the 28 records must read the standard three —, `scripts/vacuity.sh` and `--self-test`
green, `tools/check_architecture.py` exit 0); then `main` is merged into the branch (resolve the append-only lines of `ARCHITECTURE.md`,
`Proofs.lean`, `scripts/Axioms.lean`), the gate re-run, and the branch fast-forwarded onto `main`.

**The implementer may**: add lemmas (children) anywhere in the wave's modules, add supporting lemmas to the foundation modules
(`Plane/UnitPairs` is where `measurableSet_unitPairSet` belongs), change imports (updating `ARCHITECTURE.md`'s Imports cell), and import
library modules such as `FanGap` (row 66's `pullbackRepaint`). **It may not** change any statement below; a needed change comes back through Keryx.

### 6.2 The read-backs (each formal statement against its row)

| row | declaration (module) | read-back |
|---|---|---|
| FS111-V0-ID1 | `AeColouring.dist_ne_one` (DensityPoints); its engine `dist_ne_one_of_mem_densitySet` | Row: "if y ∈ S̃_j and d̄_j(x) > 0 then \|x − y\| ≠ 1", every a.e.-proper measurable colouring. Formal: for `c : AeColouring k`, `y ∈ densitySet (c.col⁻¹ {j})`, `0 < upperDensityAt (c.col⁻¹ {j}) x` ⟹ `dist x y ≠ 1`. `S̃_j` = density-1 points (closed balls); `d̄_j` = upper density. **Same statement.** The engine is the set form (one measurable set with null unit pairs), which HULLSET's `uses only:` names as the argument's real class |
| FS129-SR2-HULLSET | `hullset`, `hullset_of_isCompact` (DensityPoints) | Row: measurable `A`, null unit pairs, `C ⊆ Ã` path-connected, `x ∈ A*` ⟹ all `< 1` or all `> 1`; compact `C` ⟹ `sup < 1` or `dist(x, C) > 1`. Formal: same, with **`IsPreconnected C` in place of path-connected** (weaker hypothesis — a generalization, reported), and the compact clause as `∃ r < 1, ∀ c, dist ≤ r` or `∃ r > 1, ∀ c, r ≤ dist`, equivalent to the row's for nonempty compact `C` and free of `Metric.infDist`'s junk value at `∅` |
| FS111-C-HULL (merged) | carried by `hullset` | C-HULL's colouring/tight/D-NF hypotheses are dropped per SR2 item 10 |
| FS111-M-HULL2 | `hull2` (DensityPoints) | Row: "two path-connected pieces of one class of an a.e.-proper colouring have all cross distances < 1 or all > 1"; `uses only:` C-HULL's first clause at each point of one piece, path-connectedness of the other. Formal: `P ⊆ {d̄_A > 0}`, `Q ⊆ Ã`, both preconnected ⟹ all `< 1` or all `> 1`. A piece of a class's density set satisfies both inclusions (density 1 ⟹ positive upper density, `upperDensityAt_pos_of_mem_densitySet`), so the row is the case `P, Q ⊆ Ã`; preconnected widens path-connected (reported) |
| FS111-M2-INT | `dist_ne_one_of_mem_interior_densitySet` (DensityPoints) | Row: "for every a.e. unit-avoiding A, int Ã contains no point at distance exactly 1 from cl Ã". Formal: measurable `A` with `UnitPairsNull A`, `x ∈ interior (densitySet A)`, `y ∈ closure (densitySet A)` ⟹ `dist x y ≠ 1`. **Measurability added** — the row's "A" is a measurable set throughout FS-111 (`D-NF`'s classes); its not-claimed line (the support's interior) is not claimed here either |
| FS129-SR2-CLOSURE | `dist_ne_one_of_mem_of_mem_closure` (Closure) | Row: `U` open, `(Leb ⊗ σ){(x, w) ∈ U × S¹ : x + w ∈ U} = 0` ⟹ no point of `U` at distance exactly `1` from a point of `cl U`. Formal: `IsOpen U`, `UnitPairsNull U`, `x ∈ U`, `y ∈ closure U` ⟹ `dist x y ≠ 1`. **Same statement** (`UnitPairsNull` is the row's null set in the angle parametrization of `σ`) |
| FS106-DIAM | `dist_lt_one_of_forall_dist_ne_one` (i), `dist_lt_one_of_closure_inter_nonempty` (ii) (Diameter) | Row (i): "a connected set with no two points at distance 1 has diameter ≤ 1". Formal: preconnected `S`, no two points at distance `1` ⟹ every two points at distance `< 1` — **stronger** (pointwise strict; the argument gives it; diameter stated pointwise because `Metric.diam` is `0` on unbounded sets). Row (ii): "two same-colour regions whose closures meet have union of diameter ≤ 1" — regions of an almost-everywhere-proper map; formal: `U, V` open preconnected, `UnitPairsNull (U ∪ V)` (same colour, a.e.-proper), closures meet ⟹ all distances in `U ∪ V` below `1`. (iii) is CLOSURE's |
| FS106-TS-C | `dist_lt_one_of_chain` (Diameter) | Row: "a chain of same-colour regions of an almost-everywhere-proper map whose closures meet in sequence has diameter ≤ 1". Formal: `U : Fin (n+1) → Set ℂ` open preconnected, `UnitPairsNull (⋃ U i)`, `cl U i ∩ cl U (i+1) ≠ ∅` ⟹ all distances in `⋃ U i` below `1` (pointwise strict). The regions' union, not the closures', carries the conclusion — two closure points may be exactly `1` apart (CLOSURE's not-claimed line) |
| FS111-M2-ZERO | `unitPairsNull_iff_ae_phi_eq_zero`, `isMUA_iff_ae_phi_pos`, `isMUA_iff_ae_eq` (UnitAvoiding) | Row: "a measurable A is a MUA set iff A = {φ_A = 0} a.e.; unit-avoiding is φ_A = 0 a.e. on A, maximal is φ_A > 0 a.e. off A". Formal: the three clauses, `φ_A(p) = arcLength {θ \| p + e θ ∈ A}` (`= σ{w ∈ S¹ : p + w ∈ A}`); MUA = measurable, null unit pairs, maximal up to null sets (`A ≤ᵐ B ⟹ B ≤ᵐ A` for every measurable `B` with null unit pairs). The maximal half assumes null unit pairs, as the row's "maximal is …" reads it |
| FS116-V4-CHORD | `ringPt_sub_ringPt`, `dist_ringPt_ringPt`, `dist_ringPt_ringPt_cmp_one` (Chord) | Row: distance `2 sin(δ/2)` at `δ = \|α − β\| ∈ [0°, 180°]`; `= 1` at 60°, `< 1` below, `> 1` above up to 180°; the chord from `r(α)` to `r(β)` points along `(α + β)/2 + 90°` for `β > α`. Formal: the same three, the direction clause as the exact vector identity `r(β) − r(α) = 2 sin((β − α)/2) e((α + β)/2 + π/2)` (which is the row's clause wherever `sin((β − α)/2) > 0`, i.e. `0 < β − α < 2π`) |
| FS129-SR1-TWOCIRC | `twoCirc_identity`, `twoCirc_cmp_one`, `exists_sign_of_equilateral` (Chord) | Row: `\|y₀ − y₁\| = \|p − y₀\| = \|p − y₁\| = 1`, `a(s)` from `y₁` turning `s` about `y₀` toward `p`, `b(t)` from `y₀` turning `t` about `y₁` toward `p`; the identity and the three regimes for `0 < s, t < 180°`. Formal: "toward `p`" is the turning sense `σ = ±1` with `p = y₀ + (y₁ − y₀) e(σπ/3)`, so `a(s) = y₀ + (y₁ − y₀) e(σ s)`, `b(t) = y₁ + (y₀ − y₁) e(−σ t)` (the `uses only:` frame `a(s) = y₀ + e(120° + s)`, `b(t) = y₁ + e(300° − t)` is `σ = 1` at `y₀ = e(0°)`, `y₁ = e(60°)`); `exists_sign_of_equilateral` shows every `p` the row allows has such a `σ`. Checked numerically on 4,000 random configurations (both signs, both forms of the identity): 0 mismatches |
| FS121-D1-XCORNER | `xcorner` (Chord) | Row: at a convex corner `z` of angle `θ ∈ (0, π)` with straight edges, the inner unit parallels meet at distance `1/sin(θ/2)` on the bisector, the image of the points at distance `cot(θ/2)` along each edge. Formal: edges along `e(φ)`, `e(φ + θ)`, inner normals `e(φ + π/2)`, `e(φ + θ − π/2)`; the parallels `z + s e(φ) + e(φ + π/2)` and `z + t e(φ + θ) + e(φ + θ − π/2)` coincide iff `s = t = cot(θ/2)`, and the common point is `z + (1/sin(θ/2)) e(φ + θ/2)`. Checked numerically (2,000 random corners) |
| FS129-SA1-NOAFF-K | `noAffine` (Arith/NoAffine) | Row: `k ≥ 2`, `ρ : G → T` a homomorphism, `φ_v : Fin k → ℝ` finitely supported, `Σ φ_v(C(v)) = b` on every proper `k`-colouring of `G` ⟹ `φ_u` constant where some proper `k`-colouring of `T` leaves a colour absent from `N_T[ρ(u)]`; all constant and `b` their sum if every vertex of `T` has one. Formal: the same; "finitely supported" is `(Function.support φ).Finite` (`φ v ≠ 0` as a function), the sum is `∑ᶠ`, "absent from `N_T[w]`" is `∀ x, x = w ∨ T.Adj w x → C' x ≠ γ`, and "the sum of their values" is `∑ᶠ v, φ v 0` |
| FS84-S1-S1e (merged) | carried by `noAffine` | SA1 item 1 |
| FS129-SA1-FALC-FAN | `FalconerFan`, `falconerFan_hom` (Arith/FalconerFan) | Row: `k ≥ 3`, `H` finite, `a ≠ t` non-adjacent forming a Falconer fan at `k` colours; (A) and (B). Formal: `FalconerFan H k a t` is the row's definition verbatim (`H − a` the induced subgraph on `{v ≠ a}`); (A) and (B) as stated, the `(k − 1)`-colourings valued in `Fin (k − 1)`. **Finiteness of `H` dropped** (no step reads it — reported). Inhabitant `rhombus_falconerFan` (the unit rhombus at four colours, the row's not-claimed line names it) |
| FS129-SA1-FALC-DICHO-K | `falconerFan_chromaticNumber` (Arith/FalconerFan) | Row: `χ(H) ≥ k − 1`, and if `χ(H) = k − 1` every proper `(k − 1)`-colouring gives `a, t` one colour. Formal: `(k − 1 : ℕ∞) ≤ χ(H)` and, **unconditionally**, every proper `(k − 1)`-colouring gives `a, t` one colour — stronger: the hypothesis `χ(H) = k − 1` is idle (a `(k − 1)`-colouring exists only when `χ(H) ≤ k − 1`) |

**Statement findings from the read-backs** (sent to Keryx with this stage, none a defect): **G1** HULLSET and HULL2 hold for preconnected pieces,
not only path-connected; **G2** FS106-DIAM (i), (ii) and TS-C give the strict bound pointwise (`< 1` between every two points), stronger than
"diameter ≤ 1"; **G3** FALC-FAN and DICHO-K need no finiteness of `H`; **G4** DICHO-K's second clause holds with no hypothesis on `χ(H)`.
**One definitional note** (not a defect): every "diameter ≤ 1" of the rows must be read pointwise in Lean, because `Metric.diam` is `0` on an
unbounded set — a formal statement through `diam` would be true of unbounded sets for the wrong reason.

### 6.3 The plan per leaf (Mathlib names confirmed with `#check` at the pin, `v4.32.0`, in a scratch file 2026-10-04)

Confirmed: `IsPreconnected.image`, `IsPreconnected.Icc_subset`, `IsPreconnected.subset_closure`, `IsPreconnected.union`, `Continuous.dist`,
`Besicovitch.ae_tendsto_measure_inter_div`, `MeasureTheory.Measure.prod_apply`, `MeasureTheory.Measure.measure_prod_null`,
`MeasureTheory.Measure.measurePreserving_swap`, `measurable_measure_prodMk_left`, `IsCompact.exists_isMinOn`, `IsCompact.exists_isMaxOn`,
`interior_maximal`, `closure_mono`, `Metric.mem_closure_iff`, `Real.sin_pos_of_pos_of_lt_pi`, `Real.strictMonoOn_sin`, `Real.cos_sq`,
`Real.sin_sq`, `Real.cos_two_mul`, `Real.sin_two_mul`, `Real.cos_sub_cos`, `Real.cot_eq_cos_div_sin`, `Complex.exp_sub`,
`Complex.norm_exp_ofReal_mul_I`, `SimpleGraph.Coloring`, `SimpleGraph.Coloring.mk`, `SimpleGraph.Coloring.valid`, `SimpleGraph.Hom.comp`,
`SimpleGraph.chromaticNumber_le_iff_colorable`, `SimpleGraph.Colorable.chromaticNumber_le`, `SimpleGraph.induce`, `SimpleGraph.completeGraph`,
`finsum_eq_sum_of_support_subset`, `Equiv.swap_apply_left`, `Function.update_apply`, `Fin.castLE`. (Unknown at the pin, so not to be cited:
`measure_prod_null` outside `Measure`, `Real.cos_sq_half`, `Real.sin_sq_half`.)

Leaves in dependency order (a leaf's children are lemmas the implementer adds; difficulty E easy, M moderate, H hard):

**`Plane/DensityPoints`**
1. `dist_ne_one_of_mem_densitySet` — **H, the wave's hardest leaf.** Contrapositive: `|x − y| = 1`, `y − x = e θ₀`. From `0 < d̄_A(x)` take
   `δ > 0` and radii `r → 0` with `|A ∩ B̄(x, r)| ≥ δ|B̄(x, r)|` (frequently, from `limsup`); from `y ∈ Ã`, eventually `|B̄(y, 2r) ∖ A| ≤ η|B̄(y, 2r)|`.
   For `x' ∈ B̄(x, r)` and `θ` in a one-sided interval of length `r` at `θ₀` inside `[0, 2π)` (take `[θ₀, θ₀ + r]` if `θ₀ ≤ π`, else `[θ₀ − r, θ₀]`),
   `x' + e θ ∈ B̄(y, 2r)` (`|e θ − e θ₀| ≤ |θ − θ₀|`). By Tonelli in `θ` and translation invariance of `volume`, the unit pairs inside
   `B̄(x, r) × I` have measure at least `r(δπr² − η·4πr²) > 0` once `η < δ/4`. Children: `measurableSet_unitPairSet` (in `Plane/UnitPairs`),
   `unitPairsNull_iff_lintegral` (Tonelli: `Measure.prod_apply` after `Measure.measurePreserving_swap`), `frequently_densityRatio_gt`,
   `eventually_densityRatio_gt`, `norm_e_sub_e_le` (`|e θ − e θ₀| ≤ |θ − θ₀|`, from `ringPt_sub_ringPt` and `|sin u| ≤ |u|`). Hard: the ENNReal
   bookkeeping and `Complex.volume_closedBall`-style constants; nothing conceptual.
2. `AeColouring.dist_ne_one` — **E**: leaf 1 at `A = c.col ⁻¹' {j}` (`c.measurable (measurableSet_singleton j)`, `c.unitPairsNull j`).
3. `upperDensityAt_pos_of_mem_densitySet` — **E**: `Tendsto.limsup_eq` gives `d̄ = 1`.
4. `hullset` — **E**: `f = dist x ·` is continuous; `f '' C` preconnected (`IsPreconnected.image`); `1 ∉ f '' C` by leaf 1; values on both sides of
   `1` would put `1` in `f '' C` (`IsPreconnected.Icc_subset`).
5. `hullset_of_isCompact` — **E**: leaf 4, then `IsCompact.exists_isMaxOn` / `exists_isMinOn` of `dist x ·` (empty `C`: any `r`).
6. `hull2` — **E–M**: empty cases trivial; fix `q₀ ∈ Q`; `dist · q₀` never equals `1` on `P` (leaf 1, `x := p`, `y := q₀`), so `P` is all near or
   all far from `q₀`; at each `p`, leaf 4 (`C := Q`) gives near-all or far-all, and the side is the one `q₀` lies on.
7. `dist_ne_one_of_mem_interior_densitySet` — **M**: `B(x, r) ⊆ Ã`; `y' ∈ Ã` with `|y − y'| < r/2` (`Metric.mem_closure_iff`); the point
   `x' = y' + (x − y')/|x − y'|` on `ω(y')` has `|x' − x| = \|1 − |x − y'|\| < r/2`, so `x' ∈ Ã`, `d̄_A(x') > 0` (leaf 3) and `|x' − y'| = 1`,
   against leaf 1. Child: `exists_mem_sphere_near`.

**`Plane/Closure`**
8. `subset_densitySet_of_isOpen` — **E**: `ball x ε ⊆ U`; for `r < ε`, `U ∩ B̄(x, r) = B̄(x, r)`, ratio `1` (`densityRatio_univ`'s proof).
9. `dist_ne_one_of_mem_of_mem_closure` — **E**: leaf 7 at `A = U` (`hU.measurableSet`), `x ∈ interior Ũ` by `interior_maximal`, `y ∈ closure Ũ` by
   `closure_mono`.

**`Plane/Diameter`**
10. `dist_lt_one_of_isPreconnected` — **E**: `dist x ''  S` is a preconnected set of reals containing a value `< 1` and missing `1`.
11. `dist_lt_one_of_forall_dist_ne_one` — **E**: leaf 10 with `s₀ = x`.
12. `dist_lt_one_of_chain` — **M**: fix `x ∈ U j₀`; claim every `U i` lies within `< 1` of `x`, by induction outward from `j₀` in both directions.
    Step (`chain_step`): if `U i` is within `< 1` of `x` and `z ∈ cl U i ∩ cl U i'`, then `dist x z ≤ 1` (closure of a strict bound) and `≠ 1`
    (leaf 9: `x ∈ ⋃ U`, open, `z ∈ cl ⋃ U`), so `< 1`; `insert z (U i')` is preconnected (`IsPreconnected.subset_closure`) and misses distance `1`
    from `x` (leaf 9 again), so leaf 10 at `s₀ = z`. Hard: only the `Fin` bookkeeping (`Fin.induction` upward from `j₀`, `Fin.reverseInduction`
    downward).
13. `dist_lt_one_of_closure_inter_nonempty` — **E**: leaf 12 at `n = 1` with `![U, V]`.

**`Plane/UnitAvoiding`**
14. `phi_univ` — **E**: `arcLength univ` (the foundation's spec example).
15. `unitPairsNull_iff_ae_phi_eq_zero` — **M**: Tonelli, `(volume ⊗ arcLength)(unitPairSet A) = ∫⁻ x in A, φ_A x`
    (`Measure.prod_apply`, the slice at `x` is `{θ | x + e θ ∈ A}` on `A` and `∅` off it), then `lintegral_eq_zero_iff` with `measurable_phi`
    (`measurable_measure_prodMk_left`). Children: `measurableSet_unitPairSet`, `measurable_phi`.
16. `isMUA_iff_ae_phi_pos` — **H**. (⇐) for `B ⊇ A` a.e. with null unit pairs, the pairs `(B ∖ A) → A` are pairs of `B`, so `φ_A = 0` a.e. on
    `B ∖ A`, hence `|B ∖ A| = 0`. (⇒) if `E = {p ∉ A | φ_A(p) = 0}` has positive measure, a disc `D` of radius `1/3` has `|E ∩ D| > 0` (cover `ℂ`
    by countably many such discs); `B = A ∪ (E ∩ D)` has null unit pairs — `A → E ∩ D` null by the **pair symmetry** (child
    `unitPairs_comm`: `(Leb ⊗ σ){x ∈ S, x + w ∈ T} = (Leb ⊗ σ){x ∈ T, x + w ∈ S}`, by translation in `x` for each `θ` and the shift `θ ↦ θ + π`
    of a `2π`-periodic integrand over `[0, 2π)`), `E ∩ D → A` null by the choice of `E`, `E ∩ D` has no pairs at all (`unitPairsNull_of_dist_lt_one`) —
    so maximality gives `|E ∩ D| = 0`. Hard: the periodic shift on `[0, 2π)` (search Mathlib for the periodic set-lintegral lemma at
    implementation; the fallback is splitting `[0, 2π)` at `π`).
17. `isMUA_iff_ae_eq` — **M**: `A =ᵐ {φ_A = 0}` is "`φ_A = 0` a.e. on `A`" and "`φ_A ≠ 0` a.e. off `A`" (`ae_eq_set`), then leaves 15, 16.

**`Plane/Chord`**
18. `ringPt_sub_ringPt` — **E**: coordinates (`e_eq`, `Complex.ext`) and `Real.cos_sub_cos`, `Real.sin_sub_sin`, or `e_add` with
    `e x − e (−x) = 2i sin x`.
19. `dist_ringPt_ringPt` — **E**: leaf 18, `‖e _‖ = 1`, `|sin((β − α)/2)| = sin(|α − β|/2)` for `|α − β| ≤ π`.
20. `dist_ringPt_ringPt_cmp_one` — **E**: `Real.strictMonoOn_sin` on `[0, π/2]` and `Real.sin_pi_div_six`.
21. `twoCirc_identity` — **M**: `y₁ − y₀ = e φ₀`, so `a − b = e φ₀ (−1 + e(σ s) + e(−σ t))`; `‖−1 + e u + e v‖² = 3 − 2cos u − 2cos v + 2cos(u − v)`;
    with `σ² = 1`, `cos(σ s) = cos s`, `u − v = σ(s + t)`; then the two closed forms by `Real.cos_add`, `Real.cos_two_mul`, `Real.sin_two_mul` at the
    half angles (`s = 2·(s/2)`), closed by `ring`/`nlinarith`.
22. `twoCirc_cmp_one` — **E**: sign of `−8 sin(s/2) sin(t/2) cos((s + t)/2)` with `s/2, t/2 ∈ (0, π/2)`; `dist = ‖·‖`, compare squares.
23. `exists_sign_of_equilateral` — **M**: `w = (p − y₀)/(y₁ − y₀)` has `|w| = |w − 1| = 1`, so `Re w = 1/2`, `(Im w)² = 3/4`, `w = e(±π/3)`.
24. `xcorner` — **M**: multiply by `e(−φ)` to reduce to `φ = 0`; the real and imaginary parts give a 2×2 linear system with determinant `sin θ ≠ 0`;
    `cot(θ/2) = (1 + cos θ)/sin θ`; the common point by `e(θ/2)` algebra (`cot c cos c + sin c = 1/sin c`).

**`Arith/NoAffine`**
25. `noAffine` — **M**: at `u` with gap `γ` in `C'`, for each permutation `π` of `Fin k`, `π ∘ C' ∘ ρ` and its repaint at `u` with `π γ` are proper
    colourings of `G` (`u`'s neighbours map into `N_T(ρ u)`, which `C'` keeps off `γ`); they differ only at `u`, so `φ_u(π(C'(ρ u))) = φ_u(π γ)`;
    `(C'(ρ u), γ)` is an ordered pair of distinct colours and `π` reaches any target pair (`Equiv.swap` composites). Second clause: constancy at
    every vertex, then `b` from one colouring (`C' ∘ ρ`; if `V` is empty, `b = 0 =` the empty sum). Children: `repaint` (`Coloring.mk` with
    `Function.update`), `finsum_update` (via `finsum_eq_sum_of_support_subset`), `exists_perm_pair`. `FanGap.pullbackRepaint` may be reused.

**`Arith/FalconerFan`**
26. `rhombus_falconerFan` — **E**: `0 ≠ 3`, `¬ rhombus.Adj 0 3` by `decide` after `SimpleGraph.fromRel_adj`; the fan condition reduces to five
    values in `Fin 4` (`C 1, C 2, C 3, c₁, c₂`) under the triangle's three inequalities and the four avoidances — `revert` them and `decide`
    (1,024 cases).
27. `falconerFan_hom` — **M**: (A) restrict `C ∘ ρ` to `H − a` (`Coloring.mk`), apply the fan with `{c₁, c₂} = {C(ρ a), γ}` (distinct: `γ` is absent at
    `ρ a` itself); the second part of (A) repaints `t` with `δ` (legal: `t ∉ N(a)`, and `ρ(N(t)) ⊆ N_T(ρ t)` avoids `δ`). (B) read a
    `(k − 1)`-colouring as a `k`-colouring through `Fin.castLE` whose top colour is absent everywhere; (A) with `γ` = the top colour gives
    `C(ρ t) = C(ρ a)`, and a colour absent from `N_T[ρ t]` would equal `C(ρ a) = C(ρ t)`, absent at `ρ t` itself — contradiction.
28. `falconerFan_chromaticNumber` — **M**: if `H` were `m`-colourable with `m ≤ k − 2`, its colouring is a homomorphism to `⊤` on `Fin m`
    (`SimpleGraph.Coloring` is `G →g ⊤`); `Fin.castLE` is a proper `(k − 1)`-colouring of `⊤` leaving colour `k − 2` absent everywhere, against
    leaf 27 (B). The second clause is leaf 27 (B) at `T = H`, `ρ = id`.

**Price** (re-price from the first two leaves, `CLAUDE.md` § What compute actually helps): leaves 1 and 16 are the only hard ones; the other 26 are
easy or moderate. My estimate, to be scored: the wave lands in one implementer session of about 300–450k (harness count).

**Inhabitants and vacuity.** Structures taken as hypotheses: `AeColouring` (leaf 2; inhabitant noted in `Plane/AeColouring`, FS111-W-SQ9 in wave 2),
`FalconerFan` (leaves 27–28; `rhombus_falconerFan`). The set hypotheses (`UnitPairsNull`, density) are inhabited by the foundation's examples
(`B(0, 1/3)`). No wave-1 statement quantifies over a class the backlog proves empty.

## Stage 7 — SAVED: the waves after wave 1, and how `main`'s gate stays meaningful

### 7.1 The ten waves at a glance

| wave | subject | rows | foundation it adds (its planner's first job) | outside theorems and named hypotheses |
|---|---|---|---|---|
| 1 | the plane, sets with null unit pairs, chords, finite graphs | 14 | — (stage 5's) | none |
| 2 | measurable colourings: covers, maximal covers, the slack suprema, examples; place homomorphisms, the dyadic lemma | 27 | partial colourings and covers (`AeCover k`), `IsMaximalCover`, `µ_k(ε)` with band-properness, tile and periodic forms, upper density of a set, tight/slack (the rescaling), `essential multicolour`, saturated (for the examples), stationary families (Krylov–Bogolyubov), `χ_CP` | Krylov–Bogolyubov for `ℤ²` (formalize: Følner averages + `CompactSpace (ProbabilityMeasure _)`); de Bruijn–Erdős (formalize from `Finset.rado_selection`); Banach–Alaoglu (Mathlib); `[Falconer1981]` Lemma 1 (decide: formalize or axiom with the four items); supporting lemma **N-EASY** (row 130's free half, `χ(ℝ²) ≤ χ_m⁰(ℝ²)`, FS-103) formalized here for YESLIM |
| 3 | arc maps and fragments, Siamese allowed: tiles, the ring, germs, change points, (Q) | 21 | `isOpen_interiorPts`; arcs of `Γ` on `ω(p)` with constant sides and their inner/outer colours; (Q) at a ring; germs (`u±`, `v±`), change points, hubs; the circle colouring of RINGBAND | none |
| 4 | valid maps: contact types, Woodall's merge, shadows, the unit-arc calculus, the base's steps; S–V maps a.e. | 29 | sectors and degree at a point (components of `B(p, r) ∖ Γ` with `p` in their closure, stable for small `r`), cones (limit directions), contact types in/out/both/inert, horns, `𝓜_K`, "terminal modification" as a relation on `ArcMap 6`; S–V map-type colourings (Conditions 2–6) | none (Woodall, Townsend: their mathematics as ours, ruling R9) |
| 5 | termination, the stuck chains' ends, row 134's base, density | 12 | stuck chains along the normal line; `F(M)`, `R(M)` | **`Row134Base`** (named hypothesis, outside the backlog: `[SokolovVoronov2025]` Cor. 1 a.e. for curved cubic maps with no `d = 2` exception, as FS-110 repaired it); its own formalization is a separate planner-and-implementer job (stub to mint) |
| 6 | saturated colourings: the pinch, `C^{1,1}` interfaces, ladders of unit parallels, sectors at the singular set, map colourings `𝒫_k` | 35 | `D-NF`, honest, saturated, the singular set `Σ`, interface arcs and their tangent/split type, `REG-J′`, unit parallels, semiconcavity; `𝒫_k`, Grundy-bound | none |
| 7 | four-colour vertices: bowties, lunes, pinwheels; route T's count | 20 | Reuleaux triangles/lenses, tactic edges, pinwheels and their blades (E1, E2); the **combinatorial torus map** (rotation system with `V − E + F = 0`) | Euler's formula for cellular torus maps, and the passage from a doubly periodic valid map to one: decided at this wave's planning job (combinatorial maps here; the passage a separate job or an axiom with the four items) |
| 8 | the ring calculus, non-Siamese: RING-GERM, the star, semi-hubs, the Γ-free class's emptiness | 22 | tips, the transfer star, semi-hubs (full, parallel, crossed), the Γ-free and (Q)-free classes as predicates | none |
| 9 | the reductions (FS-111's `χ_m⁰ ≥ 6` route, TOP5) and the class statements (BENDANY, QFREE-NS, DISCF-NS) | 11 | the fragment restriction `F_ρ` (OR1-WHOLE's), complexity-`K` tilings and `δ₀(K)` | **row 130's conclusion** `χ(ℝ²) = χ_m⁰(ℝ²)` as a named hypothesis for C-SIX-M's and M2-REDUCE-C's "hence χ(ℝ²) ≥ 6" (given MR); supporting lemma **FS111-M-REDUCE-I** formalized here (R13) |
| 10 | arithmetic II: the degree-28 field, character colourings, stationary ratios, the spectral inputs | 14 | the field `K·E₇` (cyclotomic `ℚ(ζ₂₉)`'s degree-7 subfield), `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`, `Θ_k`, `E_S`, spectral measures (against `SpectralChain`'s objects) | **`Row123Chain`** (named hypothesis, outside the backlog: row 123's chain, FS-101's slot) for TC1-STANDING-FIVE's MR clause; MR itself never imported |

Totals: 205 formalize rows (14 + 27 + 21 + 29 + 12 + 35 + 20 + 22 + 11 + 14). The waves are ordered by dependency (the checker's guarantee), not by
size; waves 2 (measure) and 3 (fragments) are independent of each other, as are 6 and 7, and either pair may run concurrently in two worktrees
(builds still one at a time). Lane A's rows (waves 1, 2, 10) depend on nothing in lanes P and M.

### 7.2 Each wave's rows and modules (from `data/fs131/k1/dispositions.csv`)

**Wave 2** (27 rows):
- `Plane/MaximalCover`: FS111-C-FILL, FS111-M-SATC, FS111-M2-COV, FS111-M2-FIX, FS121-D3-GRUNDY, FS111-M-COVER-SC
- `Plane/CoverExamples`: FS111-M-R7, FS111-W-SQ9, FS111-M2-DISC7, FS111-M3-BAND, FS111-M3-FIXCONV, FS111-M3-HC, FS111-M3-IRREG
- `Plane/Slack`: FS111-V0-RESCALE, FS121-D4-FACE, FS129-SR2-SUPK, FS106-COMP, FS106-REM, FS106-EQ, FS121-V5-FACE-SHARP
- `Plane/Stationary`: FS129-OA1-NOPERLAW
- `Plane/FalconerReduction`: FS129-SA1-FALC-RED
- `Arith/PlaceHom`: FS129-SA1-PLACE-HOM, FS129-SA1-NOAFF-FIELDS
- `Arith/FalconerField`: FS129-SA1-FALC-RES, FS129-MA2-FALC-HOSTS
- `Arith/Dyadic`: FS129-SA1-SQRT3-LOCAL
- merged here: FS106-SUP → FS129-SR2-SUPK; TC1-SQRT3-DYADIC → FS129-SA1-SQRT3-LOCAL

**Wave 3** (21 rows):
- `Plane/RingGerm`: FS116-N1-GERM-R, FS116-N1-TWIST-D, FS116-N1-ECHO, FS116-N1-GERM-S, FS116-N1-QFREE4, FS116-N2-FIVERING, FS116-RING-Q-PRIME-S, FS116-V5-U1, FS116-Y4-FLANK, FS129-SR1-SIXQ, FS129-SR2-TOUCHW
- `Plane/YesLimit`: FS116-O1-YESLIM
- `Plane/Tiles`: FS116-S1-CLUSTER, FS116-V4-DICHOTOMY, FS116-V4-MEET, FS116-V4-TWIST, FS116-V5-NE1, FS129-OR1-WHOLE
- `Plane/Lens`: FS116-S1-EXIT
- `Plane/SixFragment`: FS116-Y2-SIXFRAG
- `Plane/RingBand`: FS129-SR1-RINGBAND
- merged here: FS112-SIX → FS116-N2-FIVERING;FS129-SR1-SIXQ; FS116-N1-TOUCH → FS129-SR2-TOUCHW; FS116-RING-Q-PRIME → FS116-RING-Q-PRIME-S; FS116-RING-TRANSFER-C → FS116-N2-FIVERING;FS116-N2-SIXRING; FS129-SR2-YESLIM-EQ → FS116-O1-YESLIM; FS110-N2-RING → FS129-SR1-RINGBAND; FS110-Y3-GP → FS129-SR1-RINGBAND

**Wave 4** (29 rows):
- `Plane/SVMap`: FS106-L, FS106-TS-T, FS106-WO, FS106-TW, FS106-AE-MAP6
- `Plane/ValidMap/Contact`: FS110-N3-CONF, FS110-N3-DEG, FS110-N4-SHADOW, FS110-N4-SHAVE, FS110-N4-STUCK, FS110-W-MERGE
- `Plane/StuckChain`: FS110-N4-FIN
- `Plane/ValidMap/UnitArc`: FS112-A4SIX, FS112-FLANK, FS112-ISO, FS112-LOCK, FS112-N2-BENDS, FS112-N2-FLANK-Q, FS112-N2-RAY, FS112-NB4P, FS112-U1, FS114-L60-LE
- `Plane/ValidMap/BaseSteps`: FS112-BOWTIE, FS112-C-DOUBLE, FS112-N3-ANTI, FS112-N3-FAIL, FS112-N3-NOBOTH, FS112-N3-END, FS112-N3-PAIRS
- merged here: FS112-BEND → FS112-N2-BENDS; FS114-L60-WALK → FS114-L60-LE

**Wave 5** (12 rows):
- `Plane/ValidMap/Dense`: FS114-BV-HEX, FS114-CVB-THOM, FS112-N3-COR3, FS112-ROTHEX, FS112-N3-BASE, FS112-N3-DENSE3, FS114-CV-EXISTS, FS129-OR1-LOCALDENSE, FS129-SR2-DISC1TS
- `Plane/ValidMap/Terminal`: FS114-CV-HD, FS112-N2-TERM, FS112-C-ENDS
- merged here: FS112-DISC1 → FS129-SR2-DISC1TS; FS112-N2-RED → FS112-N2-TERM

**Wave 6** (35 rows):
- `Plane/Saturated/Pinch`: FS111-M-HALF, FS111-M-PINCH, FS111-M-C11, FS111-M2-HULLC, FS111-W-KB-DIR, FS111-W-NOBEND, FS111-M2-INTRAD, FS121-D3-FALLSAT, FS121-V2-EROSION-DIAM
- `Plane/Saturated/Fragment`: FS116-O1-SATPIN, FS116-N1-AXIS, FS116-S1-RUNG, FS116-V4-PARTNER, FS116-S1-KAPPA, FS116-S1-PAIR
- `Plane/Saturated/MapColouring`: FS121-C1-BOUND, FS121-C1-SAT, FS121-C1-GMAP
- `Plane/Saturated/Ladder`: FS121-D2-EXT, FS121-D2-THIN, FS121-DB1-L3, FS121-O1-ENDS, FS121-O1-OUT, FS121-V2-SECTOR, FS121-D1-EROSION, FS121-V5-LOC, FS121-V5-RAY, FS121-D2-SYM, FS121-D4-HOLE, FS121-DB1-L6, FS121-DB1-L7, FS121-V3-CPI, FS121-V2-VT-W, FS121-D1-PENCILWIN, FS121-D2-PERFIN
- merged here: FS111-W-NOREP → FS121-DB1-L3; FS121-D1-VT → FS121-V2-VT-W

**Wave 7** (20 rows):
- `Plane/RouteT`: FS114-N114-RD, FS114-N114-EULER, FS114-N2-FIVE, FS114-N114-ROOM, FS114-N2-ENDS, FS114-N3-JOINT, FS114-Y-EDGE
- `Plane/FourColour/Bowtie`: FS114-N3-LOCAL, FS114-N4-LEMMAS, FS114-N5-GRING, FS114-Y2-BOWTIE, FS114-Y3-RSTOP, FS114-Y4-LUNE, FS114-Y4-RSTOPALL, FS114-Y6-HALF
- `Plane/FourColour/Pinwheel`: FS114-N6-NOQ, FS114-N7-QOPP, FS129-SR3-E2ONE, FS114-Y5-PINALL, FS114-Y6-E2RED
- merged here: FS114-N3-DR → FS114-Y4-RSTOPALL; FS114-N4-D → FS114-Y4-RSTOPALL

**Wave 8** (22 rows):
- `Plane/RingCalculus/Star`: FS116-N2-SIXRING, FS116-RING-GERM, FS116-N2-STAR, FS116-N2-ANTI, FS116-N2-RECIP, FS116-RING-TWIST-C
- `Plane/RingCalculus/SemiHub`: FS116-N3-PAIR, FS116-N3-STAR2, FS116-N3-CONE, FS116-N3-CROSS, FS116-V5-OUT2, FS116-V5-QCOL, FS116-V5-DICHO, FS116-N3-SEMI, FS116-RING-TRANSFER-QC
- `Plane/RingCalculus/Empty`: FS116-V6-HUBS, FS116-V6-ANTI, FS116-V6-HUG, FS116-V6-COUNT, FS129-SR3-EMPTY-NS, FS129-SR3-OUTERADJ, FS129-MR1-DOUBLETIP
- merged here: FS116-Y4-EMPTY → FS129-SR3-EMPTY-NS; FS116-V6-ADJ → FS129-SR3-OUTERADJ; FS116-Y4-OBST → FS129-SR3-EMPTY-NS

**Wave 9** (11 rows):
- `Plane/Reduction`: FS111-C1-UNIF, FS111-C-SIX-M, FS111-M2-REDUCE-C, FS129-OR1-TOP5, FS111-V0-CLEAN, FS111-C1-PW
- `Plane/Classes`: FS129-OR1-DISCF-NS, FS129-SR1-BENDANY, FS129-OR1-QFREE-CLASS, FS129-SR1-BENDLE3, FS129-SR3-QFREE-NS
- merged here: FS116-S1-QF → FS129-SR3-QFREE-NS; FS129-SR2-QFCASE → FS129-SR3-QFREE-NS

**Wave 10** (14 rows):
- `Arith/StandingFive`: TC1-STANDING-FIVE
- `Arith/CharacterColouring`: FS89-CL2, FS89-S0A-10, FS89-S0A-2
- `Arith/SpectralInputs`: J45-N1, J45-N2, J45-SI-4, J45-SI-5, J45-SI-C, J45-SI-J, J45-SP-if, J45-SP-oi
- `Arith/StationaryRatio`: X25B-L1, X25B-PZ

### 7.3 What each wave's planning job must hold

Every wave after the first opens with a planning job (`debruijn`, this lane), then its implementer, exactly as wave 1. The planner of wave N:

1. **Reads its rows' derivation entries in full** (the CSV gives each row's address in `plans/LEAN-BACKLOG.md`, which gives the derivation file's line),
   with their errata (C116 rows: FS112-C-ENDS, -C-DOUBLE, -N3-BASE, FS114-N2-ENDS, -N3-JOINT) and the merge notes the CSV's reason column cites.
2. **Writes the wave's foundation first** (the column above), sorry-free, with a spec example per definition and an inhabitant per structure, on the
   wave's branch, and runs `debruijn-domain-modeling` fresh over it. The definitions the rows' words need and the derivations never fixed are the
   likeliest statement defects of the milestone (E1): wave 3's "germ" and "change point" at a point of `Γ ∩ ω(p)` where `Γ` crosses `ω(p)`
   transversally; wave 4's "sector" and "degree" at a cusp; wave 6's "honest" and "`D-NF`"; wave 7's "simple" for a fragment's tiles that cross the
   domain's boundary (stage 5 reads `Simple` literally, over all tiles — the narrower reading, tiles meeting the disc, would strengthen every class
   statement; the wave-7/8 planner decides with Ephodos's reading, and reports).
3. **States every row at the class its argument reads** (G92), reports each widening to Keryx as a generalization, and reads each statement back in
   its record against the row.
4. **Names every hypothesis from outside the backlog** in the declaration's docstring and in § 7.4's list; never imports a hand result of ours as an
   axiom.
5. **Checks vacuity at the seam**: a route lemma over a class the backlog proves empty (wave 8's V6 lemmas, ruling R4) carries
   `VACUITY DECLARED:` with the emptiness theorem's name; every other class lemma needs an inhabitant or a note naming one (the constructions
   FS116-Y2-SIXFRAG, FS114-Y2-BOWTIE, FS112-BOWTIE, FS111-M-R7, -W-SQ9, -M2-DISC7 are the milestone's inhabitants — schedule each before the lemmas
   that need it).
6. **Prices from its first two leaves**, not from this table.

### 7.4 Hypotheses from outside the backlog, by name (inventory § What "Closed" means, item 3)

| name | what it states | where it is used | its own path to the kernel |
|---|---|---|---|
| `Row134Base` | `[SokolovVoronov2025]` Cor. 1 almost everywhere for curved cubic maps, no `d = 2` exception, with Lemma 5, Prop. 18, Lemma 6's `< 9` branch and CUSP-BASE, in FS-110's repaired form (FS110-CB, -CD, -CE) | FS112-N3-BASE, and through it FS112-N3-DENSE3, FS114-CV-EXISTS, FS129-OR1-LOCALDENSE (wave 5) | a separate planner-and-implementer job: FS-110's module (stub to mint) |
| `Row130Collapse` | `χ(ℝ²) = χ_m⁰(ℝ²)` (row 130, given MR) | FS111-C-SIX-M's and FS111-M2-REDUCE-C's last clauses (wave 9) | FS-113 (MR in Lean) with FS-103's collapse |
| `Row123Chain` | row 123's chain (`min(L(F), 5) ≤ χ(F²)` for every real number field, given MR) | TC1-STANDING-FIVE's MR clause (wave 10) | FS-101 |

Formalized here instead of named: FS-103's N-EASY (`χ(ℝ²) ≤ χ_m⁰(ℝ²)`, no MR; wave 2) and FS111-M-REDUCE-I (wave 9).

### 7.5 How `main`'s gate stays meaningful between waves (the brief's design question; Keryx accepted it ahead of this argument)

**The rule: nothing with a `sorry` is ever on `main`.** The foundation of each wave lands on `main` only sorry-free and gate-green (as stage 5's
did); each wave's skeleton lives on its own branch `fs131-wN`, built in its own worktree (§ 6.1's recipe), and reaches `main` only by a merge whose
commit passes the full gate. Why this and not the alternatives:

- **Modules kept out of the import surface** does not work here: `scripts/build.sh` builds every file under `Proofs/` (`scripts/build_order.py`
  globs `Proofs/**/*.lean`), so an unimported skeleton still compiles, warns `declaration uses 'sorry'`, and turns "linters silent" red for every
  milestone running beside this one. Moving skeletons outside `Proofs/` would change their module names at landing — every import rewritten at
  the moment the wave is supposed to be done.
- **A branch per wave** keeps `main` green and its gate's counts honest (they move only at a landing, by exactly the wave's declarations), lets
  another milestone's job build `main` at any time, and makes "landed" a fact about one merge commit — what the inventory's announcement rule reads.
  Its costs are small and known: a 4.4 GB copy per worktree (~20 s), and append-only conflicts in `ARCHITECTURE.md`, `Proofs.lean` and
  `scripts/Axioms.lean` at the merge (resolved by keeping both sides), after which the gate is re-run on the merge commit.
- **The one shared-resource rule**: one Lean build at a time across all trees, each under `scripts/slot.py`; two concurrent waves alternate builds.

When a wave lands, its planner's record (or the implementer's report) gives Keryx the drafts for `CLAUDE.md` § Trust ledger and § The gate counts,
and the `LEDGER.md` regrades, read from `build/gate/*/latest` on the merge commit (the inventory's announcement rule).

### 7.6 The provisional bearing, rewritten (for the stub's § Bearing on the answer — Keryx's file)

*Draft:* None by itself: FS-131 moves no value of χ. It is the promotion path for every [hand] result the frontier rests on, and the bar for
publishing any of them. Its first product is the foundation every regularity-wall statement is now written over (`Proofs/HadwigerNelson/Plane/`);
the formalization has so far found no statement defect among the rows it has stated (wave 1, 14 rows), four generalizations, and one backlog
defect (FS114-K1, a gap-verdict entry entered as a row, now excluded).
