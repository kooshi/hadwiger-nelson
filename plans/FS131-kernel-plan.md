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
