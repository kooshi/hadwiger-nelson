# FS-131 wave 6 — saturated colourings: the kernel plan (de Bruijn, the planner)

*Job FS131-K6, de Bruijn (Opus 5.5), launched 2026-10-06 on branch `fs131-w6` (cut from `main` at wave 5's landing, HEAD `a917d57f`), in the
worktree `.claude/worktrees/fs131-w6`. Brief `data/fs131/briefs/FS131-K6-wave6.md`, with `plans/STANDING-RULES.md`, `LEAN.md` and `RUNNING.md`
§ Building. Claim list `plans/LEAN-BACKLOG.md` (ruling 2 of `plans/FS131-close-inventory.md`); no phase-1 fence (ruling 1). Working files
`data/fs131/k6/`; tools `tools/fs131_k6_*.py`.*

## Theorems this phase proved

Kernel-checked by the worktree's build (`./scripts/build.sh`, § 7.4); the axiom audit is the gate's, not run by a planning job. Each is
listed in `scripts/Axioms.lean`'s block "FS131-K6". Grade: [kernel] once the wave's gate passes; until then, built.

- **FS121-D3-FALLSAT** — `saturated_of_forall_isMUA`, `AeColouring.saturated_of_idomatic` (`Plane/Saturated/Pinch`), over the new
  `IsMUA.exists_ball_ae_subset`. At a wider class than the row (no partition).
- **FS121-V2-EROSION-DIAM** — `erosion_diam`, `erosion_diam_cot`, over `dist_le_one_of_mem_closure` (`Plane/Saturated/Pinch`). Wider (no sector).
- **FS121-C1-BOUND** — `bound_iff` (`Plane/Saturated/MapColouring`). Wider (one open set; no map).
- **FS121-C1-GMAP** — `gmap_i`, `gmap_ii` (`Plane/Saturated/MapColouring`). Wider (any class of open families).
- **FS111-M-HALF**, its dichotomy only — `half_dichotomy` (`Plane/Saturated/Pinch`); the density clause `half_upperDensity` is a `sorry` leaf.
- Supporting: `essSupport_eq_closure_of_isOpen`; `sat_noPar` from the leaf `sat_inP`; the foundation's inhabitants `sq9_twoColourAt`,
  `sq9_hasTwoDiscsAt` (`Plane/Saturated/Basic`).

**FS131-K6b (the second pass, stages 8–12).** Kernel-checked by the worktree's build (§ 12.3); grade: built, [kernel] at the wave's gate. No
row of the backlog was proved whole by this pass. Proved:
- `norm_sub_le_of_discs` (`Plane/Saturated/Curve`) — the normal of a two-sided unit-disc condition is 1-Lipschitz, by the parallelogram law: the
  kernel's replacement for FS131-E8 § 3.1 (4)'s regularity step.
- `sq9Fan : sq9.Fan sqVertex`, with `sq9_singular_near_vertex`, `sq9_bdry_near_vertex`, `sq9_region_near_vertex`, `sqVertex_mem_singularSet`,
  `sq9_not_isCuspAt_near_vertex`, `sq9_twoColourNhd_of_re`, `_of_im` (`Plane/Saturated/FanExamples`) — the fan's inhabitant; `sq9_isolatedAt`.
- The foundation's and the fan's API: `AeColouring.twoColourNhd_of_h1`, `AeColouring.twoColourNhd_of_halves`,
  `notMem_essClosure_of_mem_densitySet`, `TwoColourNhd.ne`, `TwoColourOn.nonempty`, `Fan.dir_le_nextDir`, `Fan.hasSector_or_hasHorn`,
  `Fan.branch_subset_interfaceSet`, `SingLocallyFinite.exists_ball_subset`, `isUnitCurve_segment`.
- From leaves still `sorry` (so not yet theorems on the standard three): `TwoColourNhd.mem_essBoundary`, `pinch_interface`,
  `c11_discs_interface` (FS111-M-PINCH and C11 (i) at interface points), `regJFan_of_saturated` and `regJFan_iff_singLocallyFinite`
  (**FS131-E8-BRIDGE**, from `fan_of_isolated`), `Fan.sector_unique` (**FS121-DB1-L3**, from `Fan.sector_alone`).

## Stage 1 — SAVED: the readback and the registered expectations

### 1.1 The brief's quotations against their sources (standing rule 3)

Checked by script (exact substring match of each `>`-block against the file its `— source:` line names), 2026-10-06:

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "Do not consider Lean formalization a cost. …" | `CLAUDE.md` § Counter-priors | exact |
| 2 | "### 7.3 What each wave's planning job must hold" | `plans/FS131-kernel-plan.md` | exact |
| 3–6 | items 1–4 of § 7.3 (their first lines) | `plans/FS131-kernel-plan.md` | exact, each |
| 7 | "**Wave 6** (35 rows):" | `plans/FS131-kernel-plan.md` § 7.2 | exact |
| 8–11 | the four module lines (`Pinch`, `Fragment`, `MapColouring`, `Ladder`) | `plans/FS131-kernel-plan.md` § 7.2 | exact, each |
| 12 | "- merged here: FS111-W-NOREP → FS121-DB1-L3; FS121-D1-VT → FS121-V2-VT-W" | `plans/FS131-kernel-plan.md` § 7.2 | exact |

No mismatch; no finding about the brief.

### 1.2 The rows

`data/fs131/k1/dispositions.csv` gives wave 6 **37 lines: 35 *formalize* and 2 *merged into*** (FS111-W-NOREP → FS121-DB1-L3, SR2 item 22;
FS121-D1-VT → FS121-V2-VT-W, SR1 item 7, "conditional on VT-W's corner case being consumed: wave 6's planner confirms it; if not, D1-VT returns to
formalize"). Two rows carry a reason: FS111-M2-HULLC "without its semiconcave clause, which FS111-M-COVER-SC carries (SR2 item 17)"; FS116-S1-KAPPA
"without its last clause (SR3 DNF-2); drops FS116-V4-OUTER with it". The 37 backlog entries, quoted by script from `plans/LEAN-BACKLOG.md`, are
`data/fs131/k6/backlog-rows-w6.md` (29 from § The order, 8 from § Left the order, each under caution C118).

By the plan's module table: `Pinch` 9, `Fragment` 6, `MapColouring` 3, `Ladder` 17.

### 1.3 The worktree builds as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — all 1796 modules already up to date, nothing built,
0 modules with warnings**, exit 0 (`build/gate/build/20261006T100206Z-3136564.log`; driver log `data/fs131/k6/logs/build-0-as-given.log`).

### 1.4 Registered expectations (written before reading the derivations closely)

Written after reading the 37 backlog entries (statement, not-claimed, grade, handoff, notes), the opening plan's §§ 7.1–7.5, `ARCHITECTURE.md`'s
`Plane/` rows and the header of `Plane/Cover`; no derivation file opened. Scored in the last stage.

| # | expectation | probability / interval |
|---|---|---|
| X1 | Statement defects this job finds among the 35 rows (a hidden hypothesis the formal statement must add, a term the derivation never fixed whose readings disagree, or a clause false as written): median **6** | 80 % interval [2, 12]; P(≥ 3) = 0.8 |
| X2 | At least one row false as written (not merely under-hypothesized) | 0.35 |
| X3 | **Short** (a leaf I can prove in about an hour, or a corollary of one line once its upstream is stated): FS121-V2-EROSION-DIAM (two points on the edges at distance 1), FS121-D3-FALLSAT (the small-ball argument), FS111-M-HALF (from C-HULL), FS116-S1-PAIR (from KAPPA's germ rule and closure), FS116-V4-PARTNER's partner clause, FS121-D2-PERFIN (from D2-SYM), FS121-DB1-L6 (given INTRAD), FS121-V3-CPI (from M-HALF), FS121-C1-SAT's second clause (a contrapositive), FS121-C1-GMAP (ii) (propositional) | I prove **3** of them in this job, 80 % interval [1, 6] |
| X4 | **Outside theorem needed**: FS111-M-C11 (the rolling-ball step: two-sided unit-ball condition ⟹ `C^{1,1}` with curvature in `[−1, 1]` — its handoff says so); FS111-M2-HULLC's finite-perimeter clause (Federer 4.5.11; Mathlib has no sets of finite perimeter); FS121-V5-LOC (ii) (a `C^{1,1}` graph) through C11 | The rolling-ball lemma is **formalized** (elementary, no import): 0.75. The finite-perimeter clause is **dropped or named** (no Mathlib notion): 0.8. Axioms imported by this wave: **0** with probability 0.85 |
| X5 | **Hide a statement defect** (ranked): (a) the definitions "honest", "D-NF", "REG-J′", "interface arc", "tangent / split type", "sector / region of zero angle (cusp)" at a point of `Σ` — some row is unprovable or vacuous under the literal reading of at least one: 0.7; (b) FS121-O1-ENDS "off a null set of normals" against FS121-DB1-L6 "off finitely many normals" — one of the two is the weaker form and the rows disagree on which holds: 0.5 that a statement changes; (c) FS116-S1-KAPPA and FS116-S1-PAIR hide `k = 6` ("the two colours absent at p"): certain, by their not-claimed lines — stated with `ArcMap 6`; (d) FS116-O1-SATPIN's "saturated on a disc" for a fragment (its handoff names "the inner-disc reading"): 0.5 that the row needs a hypothesis its statement lacks; (e) FS121-D2-SYM's "in particular" clause (a cocompact symmetry group bounds the windows below) needs local finiteness of the arcs per radius, which REG-J′ may not give as stated: 0.4; (f) FS111-M-PINCH's (H1), (H2): 0.4 that the formal (H1)/(H2) must be stronger than the row's words | as listed |
| X6 | Rows that are **named-hypothesis implications**, not theorems: FS121-C1-SAT's "so" clause (C121-NOPAR), FS121-C1-GMAP (ii) (G-FIN₆, C121-NOPAR), FS121-D2-SYM (¬LRA as a `Prop`) | 3 rows, each certain to carry a named open statement as a `Prop` |
| X7 | The foundation's hardest object is the **curve vocabulary** (interface arcs with a type, a radius of curvature, a unit parallel, a chain of parallels, a pencil with a window), not honest / D-NF: | 0.75 |
| X8 | The wave cannot be stated whole in one planning pass: this job ends with the dispositions, the foundation, and the skeleton of **two** of the four modules | 0.6 (all four: 0.25) |
| X9 | Rows the plan moves to another wave or merges: FS116-S1-RUNG, -V4-PARTNER, -S1-KAPPA, -S1-PAIR and -N1-AXIS are fragment (arc-map) rows over wave 3's ring vocabulary, not measurable-colouring rows; at least one of them belongs with wave 8's ring calculus | 0.3 that I move one; 0.5 that two rows of the 35 turn out to be one theorem |
| X10 | Class emptiness: at least three Ladder rows are about a class no held object inhabits (curved tangent interfaces: "none is held"; LRA; an (R2) end), so their inhabitant notes must say "satisfiability open" in `LEAN.md` § The gate's form | 0.9 |

## Stage 2 — SAVED: the dispositions (35 rows; 12 read against their arguments, 23 from their entries only)

**What was read.** In full: the 37 backlog entries; `data/fs111/claims.md`, `data/fs121/claims.md` (the definitions and the close's notes);
the derivation entries (uses-only, argument, model lines) of all 37; the arguments `plans/FS111-M-regularity.md` §§ 2.1, 3.1–3.6, 4.1 and
`plans/FS111-M2-regularity.md` §§ 2.1, 4.1. **Not read**: the arguments of the FS-116 rows and of the FS-121 rows (their job records). So the
dispositions of the 23 rows marked "second pass" below are from the entry, not from the argument, and a second pass reads those arguments before
stating them — § 7.3 item 1 of the opening plan is met for 12 rows, not for 35.

Kinds: **T** a theorem; **N** a named-hypothesis implication; no row is a certified computation and no row needs an `axiom`.

| row | class the statement is read at | rests on (backlog) | from outside | kind | state |
|---|---|---|---|---|---|
| FS111-M-HALF | one measurable set with null unit pairs, a point `y` of its support (wider: no colouring, no saturation) | wave 1 `hullset` (C-HULL) | — | T | dichotomy **proved**; density leaf stated |
| FS111-M-PINCH | `AeColouring k` with `TwoColourAt x ρ a b`, contacts in the supports | M-HALF's dichotomy | — | T | stated (`pinch`, `pinch_not_in_in`, `pinch_interface`) |
| FS111-M-C11 | saturated `AeColouring k`, interface points | PINCH | the rolling-ball step, **formalized here** (elementary; no import) | T | (i), (iii) stated; (ii) second pass |
| FS111-M2-HULLC | a regular maximal cover (`IsRegularMUA`, wave 2), without the semiconcave clause | M2-FIX (wave 2), PINCH | Federer 4.5.11 for "finite perimeter": **not imported** — Mathlib has no perimeter; state the derivation's own conclusion `∂U ⊆ {d_C = 1/2}` and report the perimeter clause as not formalized (held for Keryx, § 7.5) | T | second pass |
| FS111-W-KB-DIR | a fan at the centre of a split arc | PINCH | fan (REG-J′, § 6) | T | second pass |
| FS111-W-NOBEND | as C11 | C11 | — | T | second pass; **likely one theorem with C11 (i)–(ii)** (no corner = `C¹`, curvature ≤ 1 = the two discs) |
| FS111-M2-INTRAD | saturated, `RegJFan` | C11 | fan | T | second pass; the wave's largest leaf |
| FS121-D3-FALLSAT | any family of MUA sets (wider) | wave 2's MUA lemmas | — | T | **proved** |
| FS121-V2-EROSION-DIAM | one preconnected set with no unit pair (wider) | wave 1 `dist_lt_one_of_forall_dist_ne_one`, `dist_ringPt_ringPt` | — | T | **proved** |
| FS116-O1-SATPIN | `ArcMap k` fragment, `SaturatedAt` on a disc, no cusp at `p` | PINCH, C11 **in a local form** (§ 7.2 item 1) | — | T | second pass |
| FS116-N1-AXIS | `ArcMap k` (clause (d) at `k ≤ 6`: its not-claimed line) | wave 3 GERM-R, GERM-S; SATPIN | — | T | second pass |
| FS116-S1-RUNG | `ArcMap k`, saturated along a segment | SATPIN, wave 3 CLUSTER | — | T | second pass |
| FS116-V4-PARTNER | `ArcMap k`, `SaturatedAt x` at an interior point of a segment edge | wave 3 DICHOTOMY | — | T | second pass |
| FS116-S1-KAPPA | **`ArcMap 6`** ("the two colours absent at p" is `k = 6`; its not-claimed line: "anything at k ≥ 7"), without its last clause | wave 3 CHORD, DICHOTOMY, MEET, TWIST; V4-PARTNER | — | T | second pass |
| FS116-S1-PAIR | `ArcMap 6`, as KAPPA | KAPPA | — | T | second pass |
| FS121-C1-BOUND | one open set with null unit pairs (wider) | wave 1 `dist_ne_one_of_mem_of_mem_closure` | — | T | **proved** |
| FS121-C1-GMAP | (i) open families a.e. equal to a Grundy-bound family; (ii) any class `𝒞` of open families (wider) | C1-BOUND | G-FIN₆ and C121-NOPAR, **named open statements** (`GFin 𝒞`, `NoPar 𝒞`; hypotheses, proved nowhere) | (i) T, (ii) N | **proved** |
| FS121-C1-SAT | an `ArcMap k` plane map whose regions are a saturated colouring's classes | C1-BOUND | C121-NOPAR (named) for the "so" clause | T, then N | stated (`sat_inP`); `sat_noPar` proved from it |
| FS121-D2-EXT, -D2-THIN, -D2-SYM, -D2-PERFIN | saturated, `RegJFan`; circular arcs in `closure 𝓘` | INTRAD, C11, O1-OUT, V5-RAY | fan; ¬LRA a defined `Prop` (circular pieces: the close's note leaves segments open) | T | second pass |
| FS121-DB1-L3 (carries FS111-W-NOREP) | a fan at one point (`DB1L3Statement`, § 6) | PINCH, C11, HALF | fan at the point only | T | second pass |
| FS121-O1-ENDS, -DB1-L6 | saturated, `RegJFan` | INTRAD, PINCH, DB1-L3, HALF, wave 4 `noBoth` | fan | T | second pass; the two differ at "off a null set" against "off finitely many normals" — unresolved (X5 (b)) |
| FS121-O1-OUT, -DB1-L7 | L7: saturated, no REG-J′, pointwise; OUT: its window form under `RegJFan` | PINCH, INTRAD step (1), C11 (iii) | fan (OUT only) | T | second pass; **one lemma and its corollary** |
| FS121-V2-SECTOR, -V3-CPI | a fan at one point | PINCH, C11, DB1-L3 | fan at the point | T | second pass |
| FS121-V2-VT-W, FS121-D1-VT | cusp-free at `Y`, `RegJFan` | PINCH, C11, INTRAD, V2-SECTOR | fan | T | second pass; **the merge's condition fails**, § 7.5 |
| FS121-D1-EROSION, -D1-PENCILWIN | cusp-free, `RegJFan` | D1-VT, wave 1 `xcorner`, C11 (iii); O1-OUT | fan | T | second pass |
| FS121-V5-LOC, -V5-RAY | saturated, `RegJFan` | PINCH, C11 | fan | T | second pass |
| FS121-D4-HOLE | saturated `AeColouring k`, a component of `openPart` (no REG-J′) | PINCH, HALF, wave 1 `hull2` | — | T | second pass; statable over this stage's foundation as it is |

**Vacuity.** Rows whose hypothesis no held object satisfies, by their own model lines ("none held"): FS121-D2-EXT, -D2-THIN, -D1-PENCILWIN,
-V5-RAY, -D4-HOLE, and O1-OUT's curved case. Each docstring will say so in `LEAN.md` § The gate's form (satisfiability open, the question named,
an object meeting the local hypotheses with the one it fails).

## Stage 3 — SAVED: the foundation (`debruijn-domain-modeling`, invoked fresh)

### 3.1 The model

`Plane/Saturated/Basic`, no `sorry`, over wave 2's `Saturated` on families (`Plane/Cover`). The intrinsic structure the pass found: **every notion
of these rows is invariant under a null change of the classes**, so each is a function of `densitySet`, `essClosure`, `essBoundary`, `essSupport`
of the classes and of nothing else; and **every notion is local** (it reads a ball, and the supports at distance 1).

| definition | reads | the decision |
|---|---|---|
| `c.openPart j` | `interior (densitySet (c.cls j))` | the canonical open set of a colour: (H2)'s `P` is not unique (a disc and a punctured disc both serve), but `openPart j ∩ N` is the largest choice and is connected when any is (a connected set dense in it) — the lemma is owed to `pinch`'s implementer, not needed to state anything |
| `c.essBdry`, `c.IsCuspAt j x` | `⋃ j, essBoundary`; `essSupport ∖ essClosure` | "density 0" is `d̄_j(x) = 0`, upper density, as the claim list's `A*_j` |
| `c.H1`, `c.H2`, `c.TwoColourAt x ρ a b` | the row's words, with `N = B(x, ρ)` explicit and `P` existential | a `structure … : Prop` with five named fields; `a ≠ b` is a field (the derivations never say it; with `a = b` (H1) would allow one colour) |
| `c.singularSet`, `c.interfaceSet` | `plans/FS111-M2-regularity.md` § 4.1's sentence, clause by clause | `𝓘 = essBdry ∖ Σ`; `exists_twoColourAt_of_mem_interfaceSet` is the fact consumers use |
| `c.IsSplitAt x ρ a b y` | M-PINCH's (split), `a` inside | ordered: the reverse is `IsSplitAt x ρ b a y` |
| `c.HasTwoDiscsAt x ρ a b ν`, `c.IsTangentAt x ρ a b ν` | the two tangent unit discs; with the contacts `x ± ν` in the supports | **the discs hold at both types** (C11 (i)), so the tangent type must carry its contacts or it is no type at all (finding (b), ruled: inventory item 481) |

**The words the derivations never fixed, and what each choice costs** (the brief's question):
- **Honest** is the type `AeColouring k` (one colour per point). Cost: a row about covers (FS111-M2-HULLC) is stated over a family, not over
  this module's definitions — see § 7.2 item 1.
- **In D-NF** is notation, never a hypothesis. Cost: none found; no row of the 35 uses a pointwise normalisation (said in the module docstring,
  as ruled).
- **Saturated** is wave 2's `Saturated c.cls`. For a colouring the two readings ("for each colour of `P(x)`" and "for each class at its own
  essential boundary points") agree, since a density point of one class is in no other's essential closure.
- **REG-J′, sector, region, angle**: § 6.

Incidental structure refused: a separate type of "saturated colourings" (a predicate on the one type); curves as parametrized `C^{1,1}` maps for
the pinch (sets with a pointwise two-disc condition suffice until C11 (ii)); a planar-graph structure for map colourings (§ 3.3).

### 3.2 Validation

- **Inhabitant**: `sq9` at `sqEdgePt = 1/2 + i/4`, `ρ = 1/8`, colours `sqColA`, `sqColB`: `sq9_twoColourAt` (all five fields, the vertical line
  null through wave 3's `volume_segment_eq_zero`), `sq9_hasTwoDiscsAt` (normal `1`).
- **Spec examples**: no two-colour neighbourhood with `a = b`; `TwoColourAt.symm`; `hasTwoDiscsAt_comm`, `isTangentAt_comm` (the sides and the
  normal's sign); `disjoint_interfaceSet_singularSet`; `IsCuspAt.mem_singularSet`; `not_isCuspAt_of_mem_interfaceSet`.
- **Negative control** (2026-10-06): a planted `example : sqColA = sqColB := by decide` appended to a copy of the module is refused ("proved that
  the proposition is false"), and `#print axioms` of the two inhabitants reads the standard three — the file is elaborated, not skipped.
- **Owed**: `IsTangentAt`'s inhabitant is `sq9_isTangentAt`, a `sorry` leaf of `Pinch` (the contacts `sqEdgePt ± 1` in the supports).

### 3.3 Map colourings

`Plane/Saturated/MapColouring`'s vocabulary: the rows read a map colouring only through its open classes and their closures, so the object is a
family of open sets with null unit pairs. `outerParallel`, `farLevel` with explicit bounds (no `infDist`, no `sSup`: an empty or unbounded set
reads no junk; spec: both levels of a point are its unit circle, both of `∅` are `∅`); `OnLevel`; `x` is `j`-bound iff
`x ∈ unitShadow (closure (S j))` (wave 2's `unitShadow`; no new definition); `SeparatesAt`; `InP S σ` (`𝒫_k` under the order `σ i < σ m`);
`GrundyBound`; `NoPar 𝒞`, `GFin 𝒞`.

**A choice with a cost: `SeparatesAt`.** The claim list's `𝒫_k` reads "every point of every edge separating colours `i < m`", over the Jordan arcs
of a plane graph. `SeparatesAt S i m x` reads the relative-interior points of such an edge without the graph: `x` in both closures, and a ball
about `x` inside `closure (S i) ∪ closure (S m)`. The endpoints of edges follow by closedness of `unitShadow` of a closed set. Cost: when the class
of locally finite Jordan-arc map colourings is formalized (to instantiate `𝒞` at C121-NOPAR's own class), the equivalence of `InP` with the
edge form is a lemma owed there. The closure-level alternative (`x ∈ closure (S i) ∩ closure (S m)`, no ball) is strictly stronger and would
make FS121-C1-SAT false at a vertex where colour `i` has a cusp.

## Stage 4 — SAVED: the skeleton and the read-backs

`Plane/Saturated/Pinch` (7 `sorry` leaves) and `Plane/Saturated/MapColouring` (1). Each formal statement against its row
(`data/fs131/k6/backlog-rows-w6.md`):

| row | declaration | read-back |
|---|---|---|
| FS121-D3-FALLSAT | `saturated_of_forall_isMUA {C} (h : ∀ j, IsMUA (C j)) : Saturated C` | "each maximal among measurable sets with null unit pairs" is `IsMUA` (wave 1); "is an honest saturated a.e.-proper k-colouring": saturated is the conclusion; honest and a.e.-proper are `AeColouring`, the corollary's type. The partition is not a hypothesis (wider). Not claimed (the converse; existence below seven): not stated. |
| FS111-M-HALF | `half_dichotomy`: `P ⊆ closedBall y 1 ∨ Disjoint P (ball y 1)`; `half_upperDensity`: `upperDensityAt P x ≤ 1/2` | "path-connected piece of S̃_j": `IsPreconnected P`, `P ⊆ densitySet A` (wider); "saturated for j": the contact `y ∈ closure (densitySet A)`, `dist x y = 1`; "lies in a closed half-plane in every blow-up": stated before the blow-up, as the disc dichotomy, which implies it; "upper density at most 1/2": the second declaration. "x in its closure" is not used. |
| FS111-M-PINCH | `pinch`, `pinch_not_in_in`, `pinch_interface` | "(H1, H2)": `TwoColourAt`; "saturated point": the contacts `ya`, `yb` given (`pinch`), or supplied by `Saturated` at an interface point (`pinch_interface`); "split … a inside and b outside or the reverse, y a contact of both": `ya = yb ∧ (IsSplitAt … a b ya ∨ IsSplitAt … b a ya)`; "two open unit discs tangent at x from opposite sides": `yb − x = −(ya − x) ∧ IsTangentAt … (ya − x)`; "(in, in) is impossible": `pinch_not_in_in`; "no positive density of the partner": the contacts are in `essSupport` only. Not claimed (without (H1), (H2); at Σ): not stated. |
| FS111-M-C11 (i), (iii) | `c11_discs`, `c11_split` | (i) "unit-parallel partners on both sides" is read as the two discs at every interface point; the partners themselves are the tangent type's contacts (`pinch_interface`). (iii) "a single unit arc if any of its points is of the split type": the essential boundary in `N` is `sphere y 1 ∩ N`. (ii), the `C^{1,1}` curve: not stated. |
| FS121-V2-EROSION-DIAM | `erosion_diam`, `erosion_diam_cot` | "straight pieces of the boundary of one component of that colour, of lengths L₁ and L₂": the points `z + t e α`, `t ≤ L₁`, and `z + t e β`, `t ≤ L₂`, in `closure D`, `D` preconnected with no unit pair; "angle θ in (0, π)": `α < β`, `β − α < π`; the bound verbatim; the "so" clause with `cot` written `cos/sin`. The sector and the colouring are not read (wider). |
| FS121-C1-BOUND | `bound_iff` | "x of F_i ∖ S_i": `x ∈ closure S` (wider); "i-bound": `x ∈ unitShadow (closure S)` (the list's "i.e." clause, as the close's note requires); "the outer unit parallel or the far level of a connected component of F_i": `OnLevel (closure S) x`. Not claimed (which level; uniqueness; points of `S_i`): at `x ∈ S` both sides are false, which the statement includes and the row did not claim. |
| FS121-C1-GMAP | `gmap_i`, `gmap_ii` | (i) "a Grundy-bound k-colouring that is a.e. equal to a locally finite map colouring": `GrundyBound A`, `A j =ᵐ S j`, `S j` open with null unit pairs; "member of 𝒫_k under the order 1 < … < k": `InP S (Equiv.refl _)`. (ii) "given C121-NOPAR, G-FIN₆ holds iff χ_m⁰ ≥ 7": `NoPar 𝒞 → (GFin 𝒞 ↔ 7 ≤ chiM0)`; its first half is the `→` direction. The class is a parameter (wider). |
| FS121-C1-SAT | `sat_inP`, `sat_noPar` | "a locally finite map colouring … whose edges are finite chains of segments and circular arcs": an `ArcMap k` with `IsPlaneMap`; "whose classes form an honest saturated colouring": `c.cls j =ᵐ F.region j`, `Saturated c.cls`; "under every total order": `∀ σ`. Validity is not a hypothesis (it follows). The "so" clause: `sat_noPar`, with C121-NOPAR as `NoPar 𝒞` and `𝒞 F.region`. **An ArcMap is locally finite in arcs, so "finite chains" is read as locally finitely many arcs — the row's own class.** |

## Stage 5 — SAVED: the plan per leaf (`debruijn-obligation-modeling`, invoked fresh)

No induction anywhere: the space of `pinch` is a 2 × 2 table (in or out, for each colour), and the pass's decision is that **one real-variable
identity serves all four cells**: for unit `u = y − x` and a direction `w`, `‖x + t w − y‖² = 1 − 2t⟨w, u⟩ + t²‖w‖²`. Mathlib names below are
confirmed by `#check` at the pin (`data/fs131/k6/K6Checks.lean`, 20 names, no error) or by the proofs already built.

| leaf | route and children | hard part | price |
|---|---|---|---|
| `pinch_not_in_in` | (P2) `ball x ρ ≤ᵐ cls a ∪ cls b` from (H1) (the classes cover; finitely many null sets); (P3a) a point of `N` outside both closed discs: `w = −(u + v)` if `u ≠ −v`, else `w = i u`; (P4) an open set a.e. inside a closed set is inside it (`IsOpen.measure_eq_zero_iff`) | none; prove it first — `pinch` uses it | 2 h |
| `pinch` | (P1) per colour: `half_dichotomy` on (H2)'s `P` with the contact, moved to the class by (H2)'s a.e. equality; then the table: (in, in) by `pinch_not_in_in`; (in, out): `ball yb 1 ∩ N ≤ᵐ closedBall ya 1`, (P4), then `w = v − u` forces `ya = yb`; split's two a.e. equalities from (P2), disjoint classes and `Measure.addHaar_sphere`; (out, out): `ball ya 1 ∩ ball yb 1 ∩ N` open and null, `w = u + v` forces `v = −u`, and the tangent type's fields are the case's facts | the a.e. set algebra of the split case; each inequality as its own small real lemma (`LEAN.md`: `nlinarith` in a small context) | 6 h |
| `pinch_interface` | `exists_twoColourAt_of_mem_interfaceSet`; (I1) both colours have `x` on their essential boundary: the class of `essBdry` is `a` or `b` (`upperDensityAt_eq_zero_of_null`), the other is in `essSupport` by (H2), not a cusp, not a density point (`densitySet_disjoint_compl`); contacts from `Saturated`; `pinch`; reorder by `TwoColourAt.symm` | (I1) | 3 h |
| `c11_discs` | from `pinch_interface`: tangent gives the discs; split with `ν = x − y`, and (G2) `ball (2x − y) 1 ⊆ (closedBall y 1)ᶜ` | none | 1 h |
| `c11_split` | points of `N` inside or outside the circle are density points of `a` or `b` (`subset_densitySet_of_isOpen_ae_subset`), so in no essential boundary; a point on it has both a ball of `a` and a ball of `b` of radius `r/2` in `B(·, r)`, so density in `[1/4, 3/4]` | the two quarter bounds (`upperDensityAt_pos_of_balls`, wave 2, is the model) | 4 h |
| `half_upperDensity` | `half_dichotomy`; the reflection `z ↦ 2x − z` preserves volume and the ball (`Measure.measure_neg`, `measure_preimage_add`); in case "in" the piece and its reflection meet in a null line, so the ratio is at most `1/2` exactly; in case "out" they meet in a strip of width `r²`, so the ratio is at most `1/2 + r/π` | the strip's volume (through `Complex.volume_preserving_equiv_real_prod`) and the `limsup` | 6 h |
| `sq9_isTangentAt` | `sq9_hasTwoDiscsAt`; `sqEdgePt ± 1` are in the closures of the open squares `(3/2, 2) × (0, 1/2)` and `(−1, −1/2) × (0, 1/2)`, of colours `(3, 0) ≡ (0, 0)` and `(−2, 0) ≡ (1, 0)` mod 3; an open subset of a class is in its support | the two floor computations (model: `sq9Col_near_edge`) | 2 h |
| `sat_inP` | by `bound_iff` (regions open, `isOpen_region`; null unit pairs by `UnitPairsNull.congr_ae`) it suffices that `x ∈ unitShadow (closure (region i))`; (S1) `unitShadow` of a closed set is closed (`IsCompact.exists_thickening_subset_open`'s pattern, or sequences); (S3) in a sector chart at `x` (wave 3's `localSectors`) two cyclically adjacent sectors have colours `i` and `m`, and the points of their common branch near `x` have `region i`-density in `[1/4, 3/4]`, so are essential boundary points of `cls i`; saturation gives each a contact, in `closure (region i)` by `essSupport_eq_closure_of_isOpen` | (S3): the branch between an `i`-sector and an `m`-sector, and the half-disc density on a circular arc; **do not** route through "a set with empty essential boundary in a ball is null or conull" — that is the connectedness of the density topology, the imported `falconer_lemma2_nonempty` | 2 days |

Prices are agent-hours for an implementer, re-priced from the two leaves of this kind proved here: `half_dichotomy` and `bound_iff` (each planned
at about an hour, each closed in one elaboration, about twenty minutes) — so the table is likely high by a factor of two to three for the pure
leaves, and not for `sat_inP`, whose cost is wave 3's sector machinery.

**Mutation audit** (statement level, by hand): `pinch` without `hya` is false (the piece may straddle the circle about an arbitrary `ya`);
without `TwoColourAt.ne` (H1) is vacuous in content; `bound_iff` without `x ∈ closure S` is false (a component crossing the unit circle of a far
point); `erosion_diam` without preconnectedness is false (two components). `sat_inP`'s `hv` was a hypothesis the plan never touched and was
removed before the hand-off.

## Stage 6 — SAVED: REG-J′, both forms, and the bridge (for the deriver's job; ruled, inventory item 481)

**The frozen words.** `data/fs111/claims.md` § 6 (l. 147), quoted by `data/fs121/claims.md` § 0 (ll. 28–29): "**REG-J′_k**: a saturated colouring
whose singular set Σ is locally finite, **each point of Σ meeting finitely many interface arcs** (the clause two briefs dropped)". The close's note
(`data/fs121/claims.md`, Notes at the close, ll. 212–215): "*Sector, region, angle, occupies* (FS121-V2's record, its definitions): a disc `B(z, r)`
whose only point of Σ is `z`, in which the essential boundary is the finitely many interface arcs at `z`; every region of the fan is an open set
a.e. of one colour; a region of positive angle has an open arc of directions, a zero-angle region none and one tangent direction." And:
"**REG-J′ is read as a fan** at each point of Σ (no arcs pass arbitrarily near `z` without meeting it); every consumer of FS121-V2-SECTOR reads it
so (V3 § 3.5)."

**In Lean** (`data/fs131/k6/FanDesign.lean`; a design, elaborated with `lake env lean` only — not a library module, because its structure has no
inhabitant yet):

```lean
def arcsAt (c : AeColouring k) (z : ℂ) : Set (Set ℂ) :=
  {A | (∃ y ∈ c.interfaceSet, A = connectedComponentIn c.interfaceSet y) ∧ z ∈ closure A}

def RegJLiteral (c : AeColouring k) : Prop :=
  (∀ x : ℂ, ∃ r > 0, (c.singularSet ∩ ball x r).Finite) ∧ ∀ z ∈ c.singularSet, (c.arcsAt z).Finite

structure Fan (c : AeColouring k) (z : ℂ) where
  r : ℝ
  r_pos : 0 < r
  n : ℕ
  φ : Fin n → ℝ → ℝ          -- branch i is {z + t e(φ i t) : 0 < t < r}
  dir : Fin n → ℝ             -- its limit direction at z (the end tangent)
  col : Fin n → Fin k         -- the colour of the region counter-clockwise of branch i
  cont : ∀ i, ContinuousOn (φ i) (Ioo 0 r)
  tendsto : ∀ i, Tendsto (φ i) (𝓝[>] 0) (𝓝 (dir i))
  mono : ∀ t ∈ Ioo 0 r, StrictMono fun i => φ i t
  wrap : ∀ t ∈ Ioo 0 r, ∀ i j, φ i t < φ j t + 2 * Real.pi
  singular : c.singularSet ∩ ball z r ⊆ {z}
  bdry : c.essBdry ∩ (ball z r \ {z}) = ⋃ i, {w | ∃ t ∈ Ioo 0 r, w = z + (t : ℂ) * e (φ i t)}
  region : ∀ i : Fin n, {w | ∃ t ∈ Ioo 0 r, ∃ θ, φ i t < θ ∧
      θ < (if h : (i : ℕ) + 1 < n then φ ⟨i + 1, h⟩ t else φ ⟨0, i.pos⟩ t + 2 * Real.pi) ∧
      w = z + (t : ℂ) * e θ} ≤ᵐ[volume] c.cls (col i)

def RegJFan (c : AeColouring k) : Prop :=
  (∀ x : ℂ, ∃ r > 0, (c.singularSet ∩ ball x r).Finite) ∧ ∀ z ∈ c.singularSet, Nonempty (c.Fan z)

def RegJBridge (k : ℕ) : Prop := ∀ c : AeColouring k, Saturated c.cls → c.RegJLiteral → c.RegJFan
```

with `Fan.nextDir`, `Fan.HasSector F j` (`∃ i, F.col i = j ∧ F.dir i < F.nextDir i`: a sector of positive angle) and `Fan.HasHorn F j` (equal limit
directions: a zero-angle region), and `DB1L3Statement` (FS121-DB1-L3's shape: two positive-angle regions of one colour are one region).

**The bridge, as the question to quote.** *Is `RegJBridge k` true: in a saturated a.e.-proper measurable `k`-colouring whose singular set is
locally finite and each of whose singular points has finitely many components of the interface set `𝓘 = ∂_e ∖ Σ` accumulating at it, does each
singular point `z` have a disc `B(z, r)` in which (1) `z` is the only singular point, (2) the essential boundary off `z` is exactly finitely many
curves, each a polar graph `t ↦ z + t e(φ(t))` over `0 < t < r` with a limit direction as `t → 0`, in a fixed cyclic order, and (3) each region
between consecutive curves is almost everywhere of one colour?* What the fan adds to the frozen words, clause by clause: (α) **no arc passes near
`z` without meeting it** (`bdry`'s equality: the literal form counts only the arcs with `z` in their closure, and infinitely many other components
of `𝓘` could accumulate at `z` while the singular set stays locally finite — unless each has an endpoint in Σ, which is itself unproved);
(β) **each arc is a polar graph near `z`**; (γ) **each arc has an end tangent** (`tendsto`); (δ) **each region is one colour** (`region`).
Why (β)–(γ) are not automatic: `plans/FS111-M-regularity.md` § 4.1 (c) takes "each arc's tangent" from C11, but C11's unit discs at `x′ ∈ 𝓘` are
unit discs within `N(x′)`, and `N(x′)` cannot contain `z`, so its radius tends to 0 as `x′ → z`; the curvature bound `|κ| ≤ 1` is then local, and
an end tangent needs an argument that a curve with `|κ| ≤ 1` confined near a point has finite length there (I believe it — a curve of curvature at
most 1 in a disc of radius below 1 cannot wind — but no entry derives it). Derived anywhere: not found in `plans/FS111-derivation.md`,
`plans/FS121-derivation.md`, `plans/FS111-M-regularity.md` §§ 3–4, `plans/FS111-M2-regularity.md` § 4.1 (the FS-121 job records not read).

Every theorem that takes `RegJFan` or a `Fan` says in its docstring that the hypothesis is stronger than the frozen words, by (α)–(δ), and why
(the ruling's condition).

## Stage 7 — SAVED: the hand-off, the builds, the expectations scored

### 7.1 For wave 6's implementer (now: `Pinch`, `MapColouring`)

- The eight leaves of § 5, in the order: `pinch_not_in_in`, `pinch`, `pinch_interface`, `c11_discs`, `sq9_isTangentAt`; independently
  `c11_split`, `half_upperDensity`; independently `sat_inP`. **Two implementers split by file**: one on `Pinch` (seven leaves, no import of the map
  lane), one on `MapColouring`'s `sat_inP` (wave 3's sector charts). Neither file imports the other.
- Statements are fixed; children are the implementer's to name, **under names of its own** (no name of `Plane/` re-declared:
  `./scripts/dupnames.sh` is green on this tree and stays so).
- Build: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from the worktree; `lake env lean
  -DautoImplicit=false -DrelaxedAutoImplicit=false <file>` for iteration only.
- Each leaf proved gets its `#print axioms` line in `scripts/Axioms.lean`'s block "FS131-K6".
- **Inhabitants owed with the leaves**: `sat_inP` has no model in Lean of all its hypotheses at once — `sq9` as an `ArcMap 9` (the grid lines as
  segments, `F.region j = interior (sq9.cls j)`), with `sq9_tight_saturated`, is the one to build, and its docstring must name it before the wave's
  gate; `bound_iff`'s hypotheses are met by any open disc of radius `1/3` (an `example` is owed); `half_upperDensity` and `pinch` by `sq9` at
  `sqEdgePt` once `sq9_isTangentAt` is proved.

### 7.2 For the second planning pass (the Ladder, the Fragment rows, C11 (ii), INTRAD, HULLC, KB-DIR, NOBEND) — what it needs

1. **First decision: state the pinch locally, over a family.** `Basic` is over `AeColouring k`. Two consumers need more: FS116-O1-SATPIN reads
   PINCH on a *fragment* (an `ArcMap` on a disc, whose regions are no colouring of the plane), and FS111-M2-HULLC's last clause reads PINCH "verbatim"
   on two classes of a *cover*. PINCH's argument is local — it reads `N`, the two classes in `N`, and the supports at the contacts — so the right
   class is a family `C : Fin k → Set ℂ` of measurable sets with null unit pairs and (H1) as `ball x ρ ≤ᵐ C a ∪ C b` with `C a`, `C b` almost
   disjoint in the ball. Restating `H1`, `H2`, `TwoColourAt`, `IsSplitAt`, `HasTwoDiscsAt`, `IsTangentAt` over families (the `AeColouring` forms as
   their instances at `c.cls`) is a mechanical change while nothing is proved over `pinch`; it is cheapest before the implementer starts on it.
   (For covers, read `plans/FS111-M2-regularity.md` § 2.2 first: the (out, out) case changes with overlaps.) **This is the definition of this
   foundation the second pass leans on hardest, with `interfaceSet`/`singularSet`.**
2. **The fan**: § 6's design, to land as `Plane/Saturated/Fan` with an inhabitant (`sq9` at a grid vertex: four branches along the axes, constant
   `φ`; R7 at a lattice point has horns and is the adversary for `HasHorn`). Rows over one fan: DB1-L3, V2-SECTOR, V3-CPI, KB-DIR; over `RegJFan`:
   the rest of the Ladder.
3. **Curves**: the Ladder's rows speak of circular arcs and segments inside `closure 𝓘`; state them over sets `{z + n e θ : θ ∈ I}` with the
   pointwise type (`IsTangentAt` with `ν = ± e θ`), never over parametrized curves. A general curve notion is needed only for C11 (ii) and V5-LOC (ii):
   a graph over the tangent line with Lipschitz derivative, the curvature bound carried by `HasTwoDiscsAt` at every point (wave 2's lesson with
   `CurvatureLeOne`: three rulings on one definition). ¬LRA: circular pieces, as the close's note leaves it.
4. **Read the FS-116 and FS-121 arguments** (not read here): `plans/FS121-DB1-verification.md` §§ 2.3, 2.5; `FS121-V2-verification.md` §§ 2.3, 2.5,
   2.9; `FS121-V3-verification.md` § 2.3; `FS121-D1-proof.md` §§ 2.1–3.1; `FS121-D2-proof.md` § 2; `FS121-V5-verification.md` § 3.1;
   `FS121-D4-proof.md` § 2.3; `FS121-C1-proof.md` § 2.3; `FS121-map-step.md` §§ 3.2–3.3; the six FS-116 entries' arguments.
5. Unresolved from § 1.4: X5 (b) (ENDS's "null set of normals" against L6's "finitely many"), (d) (SATPIN's inner-disc reading), (e) (D2-SYM's
   "in particular" clause).

### 7.3 Vacuity and inhabitants, as stated so far

`saturated_of_forall_isMUA`: `r7Cls` (an `example` in the module, through `r7Cls_isMaximalCover`). `pinch`, `pinch_interface`, `c11_discs`:
`sq9` at `sqEdgePt` (`sq9_twoColourAt`; saturation `sq9_tight_saturated`). `pinch_not_in_in` and `sat_noPar` conclude `False`; each docstring
names the hypotheses' model without the refuted one. `gmap_ii`: generic in `𝒞`; at `𝒞 = ∅` both sides hold or fail with `χ_m⁰` alone, which the
docstring's reading names. `sat_inP`: owed (§ 7.1).

### 7.4 The builds

- As given: § 1.3.
- Foundation and skeleton: OK — 464 of 464 batches, 4 modules rebuilt, 2 modules with warnings, every warning `declaration uses sorry`
  (`data/fs131/k6/logs/build-1-foundation-skeleton.log`); after `sat_inP` lost `hv`: OK, 2 rebuilt (`build-2-final.log`); the last, after the
  module docstring's sentence: **OK — 464 of 464 batches, 4 modules rebuilt, 2 modules with warnings, every warning `declaration uses sorry`**
  (8 leaves; `build/gate/build/20261006T103835Z-3362629.log`, driver log `data/fs131/k6/logs/build-3-final.log`), exit 0; `dupnames` and
  `check_architecture` re-run after it, both green (`dupnames-2.log`, `check-architecture.log`).
- `./scripts/dupnames.sh`: OK — no name declared by two modules (`data/fs131/k6/logs/dupnames-1.log`). `tools/check_architecture.py`: PASS
  (three rows added to § 3.11). No `axiom`, no `native_decide`. The gate (axioms, vacuity, linters) is not a planning job's and was not run.

### 7.5 Held for the coordinator

1. **FS121-D1-VT's merge condition fails.** The CSV merges D1-VT into V2-VT-W "conditional on VT-W's corner case being consumed". By the uses-only
   lines, D1-EROSION uses "FS121-D1-VT on the straight branch … (where L is C¹)" and D1-PENCILWIN "FS121-D1-VT (i)": no wave-6 row consumes the
   corner case. Proposed: VT-W stays a formalize row (it is one), and D1-VT is declared as its `C¹` case under its own name, the form its
   consumers cite. Read from entries, not from the arguments.
2. **FS111-M2-HULLC's finite-perimeter clause** rests on Federer 4.5.11, "cited unread", and Mathlib has no perimeter. Proposed: formalize the
   derivation's own conclusion (`∂U ⊆ {d_C = 1/2}`) and leave "finite perimeter" unformalized, named in the row's read-back — no axiom. An
   alternative is a named hypothesis for the classical step.
3. **FS111-W-NOBEND** is, on its entry, C11 (i)–(ii) restated; the second pass should confirm and merge it into C11.
4. § 7.2 item 1 changes `Basic`'s signatures (not its content). If an implementer starts on `pinch` before the second pass, it should make that
   change first, or the SATPIN and HULLC consumers pay for it later.

### 7.6 Expectations scored (§ 1.4)

| # | registered | outcome so far |
|---|---|---|
| X1 | 6 defects, [2, 12] | 3 at the statement or definition level among the 12 rows read against their arguments: the tangent type needs its contacts; REG-J′'s frozen words are weaker than every consumer's reading by four clauses; FALLSAT's argument needs the ball, not the shadow identity (a derivation correction). Plus two from entries: KAPPA and PAIR hide `k = 6`; D1-VT's merge condition fails. Open until the second pass |
| X2 | a row false as written, 0.35 | none found in 12 rows |
| X3 | I prove 3, [1, 6] | 4 rows whole (FALLSAT, EROSION-DIAM, C1-BOUND, C1-GMAP) and HALF's dichotomy |
| X4 | no axiom, 0.85; rolling ball formalized; perimeter dropped or named | no axiom; perimeter proposed dropped; rolling ball not yet stated |
| X5 | (a) 0.7 | (a) yes — REG-J′ and the tangent type; (c) confirmed from the entries; (b), (d), (e), (f) open: (f) no — (H1), (H2) formalize as worded, with `a ≠ b` added |
| X6 | 3 named-hypothesis rows | C1-GMAP (ii) and C1-SAT's clause, as parameters `NoPar 𝒞`, `GFin 𝒞`; D2-SYM not stated |
| X7 | curves the hardest, 0.75 | open; the fan was the hard definition of this pass |
| X8 | two of four modules, 0.6 | two: `Pinch` in part, `MapColouring` whole |
| X9 | a row moved 0.3; two rows one theorem 0.5 | none moved; three pairs proposed as one theorem and a corollary (NOBEND/C11, L7/OUT, VT/VT-W) |
| X10 | ≥ 3 uninhabited classes, 0.9 | five, by the rows' own model lines |

---

# FS131-K6b — the second planning pass (stages from 8)

*Job FS131-K6b, de Bruijn (Opus 5.5), launched 2026-10-06 in the same worktree, on `fs131-w6` at `714a972b`. Brief
`/home/kooshi/source/lean-dir/data/fs131/briefs/FS131-K6b-wave6-second.md` (on `main`), with `plans/STANDING-RULES.md`, `LEAN.md`, `RUNNING.md`
§ Building. Working files `data/fs131/k6b/`; tools `tools/fs131_k6b_*.py`. Nothing in this milestone is blind (ruling 1). The deriver's record
`plans/FS131-E8-derivation.md` is read on `main` and not written.*

**What this pass may change, and what it may not.**
- *May*: the signatures of `Plane/Saturated/Basic`'s predicates and the statements of the open leaves of `Pinch` and `MapColouring` — **until
  stage 9 is saved**; new modules under `Plane/Saturated/`; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (a block headed
  "FS131-K6b"); this record from here on; `tools/fs131_k6b_*.py`; `data/fs131/k6b/`.
- *May not*: the proof of any proved theorem of the first pass (each still builds, or the change is wrong); any declaration that is on `main`
  (new declarations only in landed modules); after stage 9's commit, any statement of `Basic` or `Pinch` (a change needed then is a message to
  the coordinator); the first pass's Stages 1–7 above (left standing; a correction to them is a line in a stage of mine); `main`, another wave's
  branch, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`.

## Stage 8 — SAVED: the readback, the as-given build, the registered expectations

### 8.1 The brief's quotations against their sources (standing rule 3)

By script (`tools/fs131_k6b_quotes.py`: exact substring match of each `>`-block against the file its `— source:` line names; output
`data/fs131/k6b/logs/quotes.out`): **34 quotations, 34 exact, 0 mismatched**, exit 0. With one character of the first quotation altered
(`--plant`) it reports 1 mismatch and exits 1 (`quotes-plant.out`). No finding about the brief.

### 8.2 Read, in order

The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building; this record's Stages 1–7 whole and the first pass's report
(`data/fs131/reports/FS131-K6.md`); `Plane/Saturated/Basic`, `Pinch`, `MapColouring` whole; `data/fs131/k6/FanDesign.lean` whole; the deriver's
record `plans/FS131-E8-derivation.md` whole (Stages 1–5, 711 lines); inventory items 481, 486–492; `plans/FS131-kernel-plan.md` §§ 7.1–7.5; the
37 backlog entries (`data/fs131/k6/backlog-rows-w6.md`: statement, not claimed, handoff, notes). **Not yet read at this stage**: the arguments the
first pass's § 7.2 item 4 lists (each is read in the stage that states its rows, and logged there).

### 8.3 The branch builds as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — all 1799 modules already up to date, nothing built,
2 modules with warnings**, every warning `declaration uses sorry` (8: `Pinch` 7, `MapColouring` 1), exit 0
(`build/gate/build/20261006T111946Z-3572998.log`; driver log `data/fs131/k6b/logs/build-0-as-given.log`).

### 8.4 Registered expectations (written before the unread arguments are opened)

Written after §§ 8.1–8.3; the deriver's record is read, the FS-116 and FS-121 job records are not. Scored in the last stage.

| # | expectation | probability / interval |
|---|---|---|
| Y1 | **Rows that hide a statement defect**, ranked: (a) FS111-M2-INTRAD (three steps, the third one mind; "finitely many of each radius" and "almost everywhere" are two quantifiers the entry runs together) 0.5; (b) FS121-O1-ENDS against -DB1-L6 ("off a null set of normals" against "off finitely many"): a statement changes 0.5; (c) FS116-O1-SATPIN's "saturated on a disc" for a fragment needs a hypothesis its statement lacks 0.5; (d) FS121-D2-SYM's "in particular" clause 0.4; (e) FS121-V5-LOC (iii)'s "and its ends" has two readings that disagree 0.35; (f) FS121-D1-EROSION's second disjunct 0.3 | as listed; in total **3** defects among the rows I state, 80 % interval [1, 7] |
| Y2 | **The bridge hides a step that does not formalize as written** (a constant off, a hypothesis a step reads that its entry does not name, or a step whose formal form needs a different argument): at least one | 0.6; the likeliest: § 3.1 (4)'s constants (`h = min(ρ₀, ρ₁)/24` against the 6-Lipschitz normal's domain `B(y, ρ₁/2)`, `δ ≤ ρ₁/8`); § 3.2 (2)'s "a unit-speed parametrization of a component" (no classification of one-manifolds in Mathlib) |
| Y3 | **Short** (provable by me in about an hour): FS131-E8-DELTA; FS131-E8-BRIDGE from -FAN; the fan's inhabitant apart, nothing else of the bridge. Among the first pass's rows: FS121-DB1-L7's statement over `IsTangentAt`; FS121-V3-CPI from M-HALF | I prove **2** leaves in this pass beyond the inhabitants, 80 % interval [0, 4] |
| Y4 | **Price of the bridge** (eight rows, implementer agent-days, before any leaf is stated): LOCAL 4, GAMMA 3, BETA 2, ALPHA 2, DELTA 0.2, FAN 3, BRIDGE 0.1, CLAUSE2 1 — **15 agent-days**, 80 % interval [6, 30]; about 5,000 lines | re-priced in the bridge's stage from its first two leaves |
| Y5 | **How far this pass gets**: the foundation restated, the fan landed, the bridge's eight rows stated — certain to be attempted; beyond them, the rows stated with `sorry` | median **9** of the 28 left by the first pass, 80 % interval [4, 20]; all 28: 0.1 |
| Y6 | **The curve notion**: one definition serves the bridge and the ladder — a unit-speed map on an interval with 1-Lipschitz derivative — rather than a graph over a line | 0.65 |
| Y7 | Rows whose **argument reads a different class than the entry** (a fan at one point where the entry says REG-J′, or more than the fan gives): at least 3 of those I read | 0.7 |
| Y8 | The restated foundation costs the four proved rows nothing (no proof edited beyond a name) | 0.85 |

## Stage 9 — SAVED: the foundation restated over two sets and a family (`debruijn-domain-modeling`, invoked fresh)

**From this stage's commit the statements of `Plane/Saturated/Basic` and `Plane/Saturated/Pinch` are fixed** (an implementer on `Pinch` is cut
from it): a change found necessary later is a message to the coordinator, never an edit.

### 9.1 The model

The pass's question: what does FS111-M-PINCH's argument read? An open set `N`; two sets `A`, `B` in it; that `N` is almost everywhere `A ∪ B`
and that `A ∩ B ∩ N` is null; (H2) for each; a point `x ∈ N`; the supports at the contacts. It reads no colouring, no third class, no index, and
never the centre of `N` (the deriver's note, `plans/FS131-E8-derivation.md` §§ 3.1 (2), 4.1 (i)). The first pass's predicates carried
`c : AeColouring k` and indices `a b : Fin k` through every signature and inspected neither — the smell "an index threaded through every signature
and inspected by none". So:

| level | definitions | the decision |
|---|---|---|
| **two sets on an open set** | `IsCuspAt A x`; `H2On A N`; `TwoColourOn A B N` (a `structure … : Prop`: `isOpen`, `cover : N ≤ᵐ A ∪ B`, `disj : volume (A ∩ B ∩ N) = 0`, `h2a`, `h2b`); `IsSplitAt A B N x y`; `HasTwoDiscsAt A B N x ν`; `IsTangentAt A B N x ν` | the class the argument reads. *Honest*, where an argument reads it, is exactly `cover` and `disj`; on a cover with overlaps `disj` can fail, which is where FS111-M-PINCH's (out, out) case changes (`plans/FS111-M2-regularity.md` § 2.2). `a ≠ b` is no longer a field: it follows from `disj` and (H2) (`TwoColourNhd.ne`; the spec `¬ TwoColourOn A A N`) |
| **a family** `C : Fin k → Set ℂ` | `essBdry C`, `cuspSet C`, `H1On C N a b`, `TwoColourNhd C N a b` ((H1) and `TwoColourOn (C a) (C b) N`), `singularSet C`, `interfaceSet C`, `SaturatedOn C U` | the notions that read every class. A colouring's classes, a cover's, a fragment's regions are all families; FS116-O1-SATPIN's "saturated on a disc" is `SaturatedOn F.region (ball p ρ)` |
| **a colouring** | `c.openPart j`; `c.essBdry`, `c.singularSet`, `c.interfaceSet` as `abbrev`s of the family forms at `c.cls`; `AeColouring.twoColourNhd_of_h1` | "the `AeColouring` forms their instances": for a colouring the frozen (H1), (H2) give `cover` and `disj` (the classes partition the plane) — proved |

**Three choices with a cost.**
1. **`Σ` keeps the frozen words' ball centred at the point.** `data/fs121/claims.md` § 0 says "(H1) at `x`: a ball `N = B(x, ρ)`"; FS111-M-PINCH's
   statement says "a neighbourhood N". The predicates take any open `N` (PINCH's reading); `singularSet C` asks for no two-colour **ball centred
   at the point** (the claim list's). The other reading — no two-colour open set containing the point — defines a set `Σ° ⊆ Σ`, and makes "regular"
   an open condition; under it FS131-E8-LOCAL's hypothesis "U ∩ Σ = ∅" would reduce to "no cusp in U". The two agree under saturation once
   FS131-E8-LOCAL is proved (a point with a two-colour open set, off the cusps, lies on a `C^{1,1}` graph with two sides, so small balls centred at
   it are two-colour — one connectivity lemma beyond LOCAL). I did not move a frozen definition on that argument; **offered, not adopted**
   (INVENTORY: the two frozen sentences differ in this word).
2. **The frozen (H2)'s clause `x ∈ cl P_a ∩ cl P_b` is not a field.** At an essential boundary point of a family with a two-colour neighbourhood it
   follows from the rest: a third class is null near `x`, so `x ∈ ∂_e (C a)` or `∂_e (C b)`; the density ratios of the two sum to 1 in small balls
   (`cover`, `disj`), so `x` is an essential boundary point of both (`TwoColourOn.essBoundary_inter_eq`, a leaf; `TwoColourNhd.mem_essBoundary`,
   proved from it); so `x ∈ supp (C a) ∩ supp (C b)`, and inside the open `N` a point of `supp A` is in `cl P` (`A ∩ N =ᵐ P`, `P` open). So
   `singularSet` is the frozen set. And PINCH's argument does not read the clause: in each of its three cases the contacts give it back.
   Cost: the equivalence with the frozen wording rests on a hand argument until `TwoColourOn.essBoundary_inter_eq` is proved (priced below).
3. **`IsSplitAt`, `HasTwoDiscsAt`, `IsTangentAt` do not carry `x ∈ N`** (the first pass's did not carry `0 < ρ` either): every theorem takes
   `hx : x ∈ N` beside them. An adversarial member: `HasTwoDiscsAt A B ∅ x ν` holds for every unit `ν`.

Incidental structure refused: a typeclass or a bundled "two-colour neighbourhood" type; a separate `AeColouring`-level copy of each predicate (one
concept in two costumes); the open-neighbourhood `Σ°` beside `Σ`.

### 9.2 The leaves restated, each against its row (`data/fs131/k6/backlog-rows-w6.md`)

| row | declaration (new statement) | read-back |
|---|---|---|
| FS111-M-PINCH | `pinch {A B N} (hA hAn hB hBn) (h : TwoColourOn A B N) (hx : x ∈ N) (hya : ya ∈ essSupport A) (hxa : dist x ya = 1) (hyb …) (hxb …) : (ya = yb ∧ (IsSplitAt A B N x ya ∨ IsSplitAt B A N x ya)) ∨ (yb − x = −(ya − x) ∧ IsTangentAt A B N x (ya − x))` | "a neighbourhood N in which only two colours a, b have positive measure and each is a.e. one connected open set of density points (H1, H2)": `TwoColourOn A B N` with `x ∈ N` — any point of `N` (the deriver's note); "honest": `cover`, `disj`; "saturated point": the contacts, given; the conclusion as in the first pass's read-back, with the two sets. Wider than the row: no colouring, no family |
| FS111-M-PINCH, (in, in) | `pinch_not_in_in {A B N} (hN : IsOpen N) (hcover : N ≤ᵐ A ∪ B) (hx : x ∈ N) (hxa) (hxb) (hin : A ∩ N ≤ᵐ closedBall ya 1 ∧ B ∩ N ≤ᵐ closedBall yb 1) : False` | "the case (in, in) is impossible". Reads only `N` open and `cover` (a direction leaving both closed discs at `x`: `−(u + v)`, or `i u` when `v = −u`); neither (H2), nor `disj`, nor measurability. Wider |
| FS111-M-PINCH at its points | `TwoColourOn.essBoundary_inter_eq` (leaf); `TwoColourNhd.mem_essBoundary` (proved from it); `pinch_interface {C} (hC : IsAdmissible C) (hsat : SaturatedOn C U) (hxU : x ∈ U) (hx : x ∈ interfaceSet C) : ∃ ρ a b, TwoColourNhd C (ball x ρ) a b ∧ ((∃ y, IsSplitAt (C a) (C b) (ball x ρ) x y) ∨ ∃ ν, IsTangentAt …)` (**proved** from `pinch` and the leaf) | "at a saturated point x": saturation is read at `x` only (`SaturatedOn C U`, `x ∈ U`); for a family, so for a fragment's regions |
| FS111-M-C11 (i) | `c11_discs {A B N} (…) (h : TwoColourOn A B N) (hx : x ∈ N) (hcA : IsContactFor A x) (hcB : IsContactFor B x) : ∃ ν, HasTwoDiscsAt A B N x ν`; `c11_discs_interface` (proved from it) | "unit-parallel partners on both sides" read as the two discs, **at every point of the one `N`** — the form FS131-E8 § 3.1 (2) applies ("with the same N, P_a, P_b") |
| FS111-M-C11 (iii) | `c11_split {A B N} (hN : IsOpen N) (h : IsSplitAt A B N x y) : essBoundary A ∩ N = sphere y 1 ∩ N ∧ essBoundary B ∩ N = sphere y 1 ∩ N` | "a single unit arc if any of its points is of the split type" — for each of the two sets (the first pass's `c.essBdry` was the family's; with (H1) the family's follows) |
| FS111-M-HALF | `half_dichotomy`, `half_upperDensity` | unchanged (one set) |
| the inhabitant | `sq9_isTangentAt : IsTangentAt (sq9.cls sqColA) (sq9.cls sqColB) (ball sqEdgePt (1/8)) sqEdgePt 1` | unchanged in content |

FS111-M-C11 (ii) with "no cusp in the neighbourhood" (the deriver's second note) is FS131-E8-LOCAL, stated in stage 11 over these predicates; the
foundation's part is `IsCuspAt A x` at the set level, so that "neither set has a cusp in `N`" is `∀ x ∈ N, ¬ IsCuspAt A x ∧ ¬ IsCuspAt B x`.

**Mutation audit** (statement level, by hand): `pinch` without `hx` is false (a point far from `N`); without `disj` its (out, out) case is false
on overlapping classes (two classes that overlap in a lens between the two discs); without `cover`, false (a third set between them);
`pinch_not_in_in` without `hx`, false; `c11_split` without `hN`, false (`N` a single point of the circle); `TwoColourNhd.mem_essBoundary` without
`hx`, false.

### 9.3 Validation

- **The proved rows still build, no proof edited**: FALLSAT, EROSION-DIAM, C1-BOUND, C1-GMAP, HALF's dichotomy — their modules' proofs are
  byte-identical (the diff of `Pinch` touches the PINCH and C11 sections and the module docstring only; `MapColouring` is untouched). The
  inhabitants: `sq9_twoColourNhd` (the first pass's `sq9_twoColourAt`, through `twoColourNhd_of_h1`; the proof of its three parts kept),
  `sq9_hasTwoDiscsAt` (statement re-typed, proof unchanged).
- **Spec examples**: `¬ TwoColourOn A A N`; `TwoColourOn.symm`, `TwoColourNhd.symm`, `TwoColourNhd.ne`, `TwoColourOn.nonempty`,
  `TwoColourNhd.radius_pos`; `hasTwoDiscsAt_comm`, `isTangentAt_comm`; `disjoint_interfaceSet_singularSet`, `cuspSet_subset_singularSet`,
  `not_isCuspAt_of_mem_interfaceSet`; `saturatedOn_univ`, `SaturatedOn.mono`.
- **Negative controls** (2026-10-06, on copies of the module, `lake env lean`): `disj` weakened to a triviality — 3 errors, the first at the spec
  example and at `TwoColourNhd.ne`; `HasTwoDiscsAt` with both discs on one side — 4 errors, the first at `hasTwoDiscsAt_comm`, then at the
  inhabitant. Each fires; the files were scratch copies and the tree is unchanged.
- **Build**: OK — 464 of 464 batches, 2 modules with warnings, every warning `declaration uses sorry` (8: `Pinch` 7 — `half_upperDensity`,
  `sq9_isTangentAt`, `pinch`, `pinch_not_in_in`, `TwoColourOn.essBoundary_inter_eq`, `c11_discs`, `c11_split`; `MapColouring` 1), exit 0
  (`build/gate/build/20261006T114135Z-3705508.log`; driver logs `data/fs131/k6b/logs/build-1-foundation.log` — a first run that failed at one line
  of `TwoColourNhd.mem_essBoundary`, fixed — and `build-2-foundation.log`). `scripts/Axioms.lean`: the first pass's block lost its eleven lines
  for renamed declarations and a block "FS131-K6b" lists the eighteen new ones; all 34 lines of the two blocks resolve and read the standard
  three (checked on a scratch file with the two modules' imports; the audit itself is the gate's).

### 9.4 The plan per leaf, where it changed (the first pass's § 5 otherwise stands)

| leaf | route | price |
|---|---|---|
| `pinch_not_in_in` | as § 5's (P3a), (P4); (P2) is now the hypothesis `hcover` | 1.5 h |
| `pinch` | § 5's route with `P` from `h.h2a`, `h.h2b`; (P2) is `h.cover`; the split case's a.e. equalities from `h.cover` and `Measure.addHaar_sphere` (no `disj`); (out, out) from `h.disj`; every local step uses `Metric.isOpen_iff.1 h.isOpen x hx` in place of the centred ball | 6 h |
| `TwoColourOn.essBoundary_inter_eq` | by symmetry (`h.symm`) one inclusion: for `x ∈ ∂_e A ∩ N` and `ball x r ⊆ N`, `densityRatio A x r + densityRatio B x r = 1` (`h.cover`, `h.disj`, `measure_union_add_inter`, `hA`); so `limsup` of one is positive iff the other does not tend to 1 (`densityRatio_add_compl`'s pattern, `tendsto_densityRatio_of_notMem_essClosure`) | 3 h |
| `c11_discs` | contacts to `essSupport` (`essSupport_eq_closure_densitySet`); `pinch`; tangent gives the discs; split with `ν = x − y` and `ball (2x − y) 1 ⊆ (closedBall y 1)ᶜ` | 1 h |
| `c11_split` | § 5's route, per set, with `Metric.isOpen_iff.1 hN` | 4 h |
| `sq9_isTangentAt` | **shorter than § 5's**: `sqEdgePt + 1 ∈ sq9Sq 3 0` and `sqEdgePt − 1 ∈ sq9Sq (−2) 0`, then `sq9Sq_subset_essClosure` (wave 2) and `essClosure_subset_essSupport`; the colours by `simp` | 0.5 h |

## Stage 10 — SAVED: the fan as a library module, with its inhabitant

### 10.1 The modules

- **`Plane/Saturated/Fan`** (no `sorry`): `polarGraph z r φ`, `polarRegion z r φ ψ`, `cyclicNext φ i` (over wave 3's `polarPt`; the same shape as
  wave 3's `BranchGerms` / `IsSectorChart` for arc maps, whose branches are the circular germs `β + arcsin(κ s/2)` — a fan's are any continuous
  polar graphs); `c.SingLocallyFinite`; `c.arcsAt z`, `c.RegJLiteral`; the structure `c.Fan z` (the first pass's § 6 design, its `bdry` and
  `region` fields written through `polarGraph`, `polarRegion`, `cyclicNext`); `c.RegJFan`; `Fan.branch`, `Fan.cell`, `Fan.nextDir`,
  `Fan.HasSector`, `Fan.HasHorn`. API proved: `polarGraph_subset`, `polarRegion_subset`, `Fan.branch_subset_interfaceSet` (branch points are
  interface points), `Fan.φ_lt_cyclicNext`, `Fan.tendsto_cyclicNext`, `Fan.dir_le_nextDir` (a region's angle is non-negative),
  `Fan.hasSector_or_hasHorn`, `SingLocallyFinite.exists_ball_subset`. Two tools for inhabitants: `notMem_essClosure_of_mem_densitySet`,
  `AeColouring.twoColourNhd_of_halves` (a convex open set cut into two colours by two convex open pieces is a two-colour neighbourhood).
  `RegJBridge` is not a definition any more: it is the theorem `regJFan_of_saturated` (stage 11).
- **`Plane/Saturated/FanExamples`** (no `sorry`): `sq9` at the grid vertex `sqVertex = 1/2 + i/2`, radius `1/4`.

### 10.2 The two facts the design's `Fan` has no field for: lemmas about any fan, not fields (ruling 492 (b))

The deriver's § 4.6 names them: the curvature bound along a branch, and the convergence of the branch's unit tangent (not only its polar angle).
Read against the arguments that consume them (`plans/FS121-V2-verification.md` §§ 2.1–2.3, read in full), they are consumed in **two set-level
forms, neither of which mentions a curve**: (L) *the lens* — the branch stays outside the two open unit discs tangent to its limit direction at
`z` (V2 § 2.3: "it lies on or below that arc, outside `B(y, 1)`"); (T) *the contacts* — Lemma T (ii): the contacts `x ± ν(x)` of the branch's
points converge, so `z ± i e(dir i)` lies in the support of the right colour, or the branch is a unit arc about that point.

**Decision: theorems about every fan under saturation in its punctured disc** (`Fan.branch_outside_discs`, `Fan.branch_contacts`, stated in
`Plane/Saturated/FanBridge`), **not fields.** Why:
1. They are consequences of saturation, not part of what a fan is: a polygonal colouring has fans at its vertices and no curvature bound, and the
   close's note defining the fan has no such clause. A field would make `Fan` mean "saturated fan" and every inhabitant prove it.
2. They are provable for **any** fan, not only the one the bridge builds: under saturation a branch is a connected component of the essential
   boundary in the punctured disc with `z` in its closure (it is relatively closed, and locally all of the boundary by FS131-E8-LOCAL), so
   FS131-E8-GAMMA and -BETA describe it. "Lemmas the bridge exports beside the fan" would be facts about one particular fan that every consumer
   must carry as extra hypotheses; lemmas about any fan are carried by nobody.
3. In the set-level forms the consumers never see a curve: the curve notion stays inside the bridge's modules.
Cost: the two lemmas hold within distance `1/2` of `z` (the chord bound's range), so they are stated for `t < min F.r (1/2)`.

### 10.3 The inhabitant, and the validation

**`sq9Fan : sq9.Fan sqVertex`** — four branches along the half-axes (`φ i t = i π/2`), four regions (the open quadrants) of the four colours
`sqQuad b b'`. Each field is a theorem about `sq9`: `sq9_singular_near_vertex` (`Σ ∩ B(vertex, 1/4) ⊆ {vertex}`: no cusp near the vertex,
`sq9_not_isCuspAt_near_vertex`; the essential boundary there is the two axes, `sq9_axis_of_mem_essBdry`; every axis point but the vertex has a
two-colour ball, `sq9_twoColourNhd_of_re`, `_of_im`), `sq9_bdry_near_vertex`, `sq9_region_near_vertex`. With it: **`sqVertex_mem_singularSet`**
(the vertex is singular: every ball about it holds four colours), so the hypotheses "a fan at `z`", "`z ∈ Σ`", "`Σ ∩ B(z, R) ⊆ {z}`" and
"saturated" (`sq9_tight_saturated`) are met together, at `k = 9`. Spec examples: `sq9Fan_hasSector` (each quadrant colour a sector of angle
`π/2`), `sq9Fan_not_hasHorn`; for the definitions, `polarGraph_subset`, `polarRegion_subset`, `cyclicNext_of_lt`, `cyclicNext_of_not_lt`,
`Fan.hasSector_or_hasHorn`, `RegJFan.singLocallyFinite`, `RegJLiteral.singLocallyFinite`.
**Owed** (a leaf for an implementer, not stated): `sq9.SingLocallyFinite` — the vertex analysis at every grid vertex `(n/2, m/2)` (the lemmas of
`FanExamples` with `n`, `m` general; wave 2's `sq9Sq` lemmas already are) — which with stage 11's bridge gives `sq9.RegJFan`, the model of every
theorem that takes `RegJFan` and saturation. `HasHorn`'s adversary (R7 at a lattice point: three sectors and three horns) is not built.

**Negative control** (2026-10-06, `lake env lean` on a scratch copy of the two modules): an appended
`example : sqQuad true true = sqQuad false true := by decide` is refused ("proved that the proposition is false"); `#print axioms sq9Fan`,
`sqVertex_mem_singularSet`, `sq9Fan_not_hasHorn` read the standard three — the files are elaborated to their end.

**Price, for re-pricing**: the inhabitant is 545 lines; written and closed in this stage in three elaborations (two errors, one line each). The
first pass priced leaves of this kind (floor computations on `sq9`) at 2 h each.

**Build**: OK — 466 of 466 batches, 3 modules rebuilt (`Fan`, `FanExamples`, `Proofs`), 2 modules with warnings, every warning
`declaration uses sorry` (8, as at stage 9: the two new modules have none), exit 0 (`build/gate/build/20261006T115937Z-3809849.log`; driver log
`data/fs131/k6b/logs/build-3-fan.log`). `tools/check_architecture.py`: PASS (`check-architecture-1.log`).

## Stage 11 — SAVED: the bridge's eight rows — the curve notion, the skeleton, the plan and the price (`debruijn-obligation-modeling`, invoked fresh)

**Read for this stage**: `plans/FS131-E8-derivation.md` whole (stage 8); `plans/FS121-V2-verification.md` §§ 1.4–2.4 in full (Lemmas C, H, T;
DB1-L3; V2-SECTOR; the attack). Not read: every other argument of the first pass's § 7.2 item 4.

### 11.1 The space, and the statements the proofs derive from

No induction over data: the argument is *local to global by connectedness and compactness*. The local obligations, each a goal of its own:
(L) a chart at every interface point; (C) three real-variable inequalities on a unit-speed curve; (G) a component is one such curve (the
continuation); (K) compactness on a circle; (O) the angular order of the lifts. The statements are shaped around them:

- **One curve notion** (`Plane/Saturated/Curve`): `IsUnitCurve γ ψ I` — `γ' = e ∘ ψ` on `I`, the tangent angle `ψ` 1-Lipschitz. Unit speed
  and "curvature at most 1" in the only form any argument reads (`|ψ s − ψ u| ≤ |s − u|`); every inequality of E8 §§ 3.2–3.3 is then one integral
  of a cosine. A graph over a line was refused: the inequalities are in arclength, and a graph form would re-derive the reparametrization at
  every use. The ladder's circular arcs and segments are `IsUnitCurve`s with `ψ` affine (`ψ s = ψ₀ + s/n`, or constant); the first pass's
  "curves as sets with a pointwise type" stays the consumers' form — `IsInterfaceChart.discs` carries `HasTwoDiscsAt` at every point of the curve.
- **Components of the essential boundary in the punctured disc**, never "interface arcs": under `IsolatedAt` the two sets are equal
  (`Σ ∩ B(z, R) ⊆ {z}`), and the statements read `c.essBdry ∩ (ball z R \ {z})` to save every proof that step.
- **The fan's consumers' facts as set-level lemmas** (§ 10.2).

### 11.2 The modules and the rows

| module | rows | leaves (`sorry`) | proved here |
|---|---|---|---|
| `Plane/Saturated/Curve` (imports `Plane/Chord` only; no measure) | the curve part of FS131-E8-GAMMA, -BETA | `IsUnitCurve.chord` (C1), `.sin_le_inner` (C2), `.strictMonoOn_dist`, `.norm_sub_le`, `.one_le_dist` (the lens), `lipschitzOnWith_of_chord` | `isUnitCurve_segment` (the inhabitant), `IsUnitCurve.mono`, **`norm_sub_le_of_discs`** |
| `Plane/Saturated/LocalGraph` (imports `Pinch`, `Curve`) | **FS131-E8-DELTA**; **FS131-E8-LOCAL** = FS111-M-C11 (ii) = FS111-W-NOBEND; FS121-V5-LOC (i), (ii) with V5-OFF | `AeColouring.ae_one_colour_of_isConnected`, `.closure_essBdry_subset`, `.notMem_essBdry_of_mem_densitySet`, `local_graph`, `AeColouring.local_graph` | the structure `IsInterfaceChart` |
| `Plane/Saturated/FanBridge` (imports `LocalGraph`, `FanExamples`) | **FS131-E8-GAMMA, -BETA, -ALPHA, -FAN, -BRIDGE, -CLAUSE2**; FS121-V2-SECTOR, FS121-DB1-L3 (with FS111-W-NOREP) | `gamma`, `IsUnitCurve.exists_polarGraph`, `beta`, `alpha`, `fan_of_isolated`, `regJLiteral_of_saturated`, `finite_arcs_of_isBounded`, `Fan.two_le_n`, `Fan.col_ne`, `Fan.branch_outside_discs`, `Fan.branch_contacts`, `Fan.sector_alone` | `sq9_isolatedAt`; **`regJFan_of_saturated`** (BRIDGE, from `fan_of_isolated`), `regJFan_iff_singLocallyFinite`; `Fan.sector_unique` (DB1-L3, from `sector_alone`) |

**Which of the first pass's rows became corollaries** (the brief's question): **FS111-M-C11 (ii)** is `local_graph` (with "no cusp in `U`", the
deriver's erratum); **FS111-W-NOBEND** is its curve clause — no corner is `HasDerivWithinAt` at every point, curvature at most 1 is `lip` — the
merge of ruling 487 (c) **confirmed, from its entry and the deriver's § 4.6** (its own argument, `plans/FS111-W-wild.md`, not read: a third
pass's line); **FS121-V5-LOC (i)** is `closure_essBdry_subset` with `notMem_essBdry_of_mem_densitySet`, **(ii)** is `AeColouring.local_graph`;
clause (iii) is not stated. **FS121-DB1-L3** is a case of **FS121-V2-SECTOR** (`sector_unique` from `sector_alone`), so FS111-W-NOREP rides on it.

### 11.3 Each statement against its entry (`plans/FS131-E8-derivation.md`, verbatim words in quotes)

| entry | declaration | read-back |
|---|---|---|
| FS131-E8-DELTA | `ae_one_colour_of_isConnected (hW : IsOpen W) (hWc : IsConnected W) (hb : Disjoint W c.essBdry) (hcusp : Disjoint W (cuspSet c.cls)) : ∃ j, W ≤ᵐ c.cls j` | "a connected open set that meets the essential boundary of no class and holds no cusp of any class is almost everywhere of one colour" — verbatim; `IsConnected` includes non-empty (for `W = ∅` every `j` serves) |
| FS131-E8-LOCAL | `local_graph … (h : TwoColourOn A B N) (hU : IsOpen U) (hUN : U ⊆ N) (hcusp : ∀ x ∈ U, ¬ IsCuspAt A x ∧ ¬ IsCuspAt B x) (hsatA) (hsatB) (hy : y ∈ essBoundary A ∩ U) : ∃ Q γ ψ h', Q ⊆ U ∧ IsInterfaceChart A B N y Q γ ψ h'` | "an open set that holds no point of the singular set Σ": the argument reads of it only "no cusp" (§ 3.1 (1): "no cusp (it is off Σ)") and the one two-colour ball — so two sets, and `Σ` is not read (**wider**; the centred-ball `Σ` serves: ruling 495 (a) needs no change). "an open square … in which the interface set is the graph, over the tangent line at y, of a C^{1,1} function whose unit tangent is 1-Lipschitz in arclength": an open `Q ∋ y` in which `essBoundary A` is the image of an injective `IsUnitCurve` — the square and the graph are the proof's, the chart is what consumers read; "the two sides … connected open sets, each almost everywhere of one colour, of two different colours": `sides`, with `A`, `B` almost disjoint in `N`. Added: `discs` (the two unit discs at every point of the curve, normal `i e(ψ s)` into `B` — § 3.1 (2)). Not claimed (the chart's size bounded below; anything at `Σ`): not stated. `AeColouring.local_graph` is the entry's own form |
| FS131-E8-GAMMA | `gamma (h : c.IsolatedAt z R) (hy) : ∃ L γ ψ, 0 < L ∧ L ≤ π/2 ∧ IsUnitCurve γ ψ (Icc 0 L) ∧ InjOn γ (Icc 0 L) ∧ component = γ '' Ioo 0 L ∧ (γ 0 = z ∨ γ 0 ∈ sphere z R) ∧ (γ L = z ∨ γ L ∈ sphere z R)` | "0 < R ≤ 1/2 such that B(z, R) holds no other point of Σ and every essential boundary point of B(z, R) other than z has … a point of that class's support at distance 1": `IsolatedAt`; "an open arc of length at most π/2, not closed": `L ≤ π/2`, injective on the closed interval; "each of whose two ends converges to z or to a point of the circle": the two disjunctions; "whose unit tangent has a limit at each end": `IsUnitCurve` on `[0, L]`. `z ∈ Σ` is not a hypothesis (the entry's "let z be a point of the singular set" is not read by §§ 3.2–3.4) |
| FS131-E8-BETA | `IsUnitCurve.exists_polarGraph` (no colouring); `beta (h) (hy) (hz : z ∈ closure component) : ∃ φ d, ContinuousOn φ (Ioo 0 R) ∧ Tendsto φ (𝓝[>] 0) (𝓝 d) ∧ component = polarGraph z R φ` | "the distance from z is strictly increasing": `IsUnitCurve.strictMonoOn_dist`; "its other end lies on the circle", "a polar graph {z + t e(φ(t)) : 0 < t < R} with φ continuous on (0, R) and convergent": `beta`; "to an angle of the component's limit tangent at z": `exists_polarGraph`'s limit is `ψ 0` |
| FS131-E8-ALPHA | `alpha (h) : {components meeting closedBall z (R/2)}.Finite ∧ ∃ r, 0 < r ∧ r ≤ R/2 ∧ ∀ w ∈ c.essBdry ∩ (ball z r \ {z}), z ∈ closure (component of w)` | verbatim, "has an end at z" read as `z` in the component's closure |
| FS131-E8-FAN | `fan_of_isolated (hR : 0 < R) (hS : c.singularSet ∩ ball z R ⊆ {z}) (hsat : SaturatedOn c.cls (ball z R \ {z})) : Nonempty (c.Fan z)`; `Fan.two_le_n (hz : z ∈ c.singularSet) : 2 ≤ F.n`; `Fan.col_ne` | the entry's hypotheses verbatim, without "z a point of Σ" (read only for "at least two", `two_le_n`) and without `R ≤ 1/2` (pass to `min R (1/2)`); the conclusion is the first pass's structure, field by field as § 3.6 reads it. "at least two", "regions on the two sides of a curve being of different colours": for **any** fan, no saturation (**wider**, the planner's argument, § 11.5 (3)) |
| FS131-E8-BRIDGE | `regJFan_of_saturated (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) : c.RegJFan` (**proved** from FAN) | the deriver's hand-off line verbatim; `RegJBridge k` of the first pass's design follows with `RegJLiteral`'s second conjunct unread |
| FS131-E8-CLAUSE2 | `regJLiteral_of_saturated`, `finite_arcs_of_isBounded (hK : Bornology.IsBounded K)` | "every point of Σ lies in the closure of finitely many connected components of the interface set, and every bounded set meets finitely many": the two declarations |

**The docstring line of ruling 490 (b)** is on every theorem that takes a `Fan` (`sector_alone`; the module docstring of `Fan`): "under
saturation … equivalent to `Σ` being locally finite, by FS131-E8-BRIDGE ([hand], one mind, until `fan_of_isolated` is proved)".

### 11.4 The plan per leaf

Mathlib names confirmed at the pin by the proofs built here or by `#check` (`data/fs131/k6b/K6bChecks.lean`): `parallelogram_law_with_norm`,
`HasDerivWithinAt.ofReal_comp`, `LipschitzWith.const`, `le_of_tendsto_of_tendsto`, `Ioo_mem_nhdsGT`, `isClosed_iUnion_of_finite`,
`tendsto_densityRatio_compl_of_mem`, `nonempty_of_measure_ne_zero`, `Real.cos_neg_of_pi_div_two_lt_of_lt`, `Real.sin_neg_of_neg_of_neg_pi_lt`,
`Real.cos_pos_of_mem_Ioo`, `Measure.addHaar_affineSubspace`, `convex_halfSpace_im_lt`. Prices are implementer agent-hours (h) or days (d).

| leaf | route and children | hard part | price |
|---|---|---|---|
| `IsUnitCurve.chord` | `γ ℓ − γ 0 = ∫₀^ℓ e(ψ s) ds` (`intervalIntegral.integral_eq_sub_of_hasDeriv_right` or the `Icc` form; `e ∘ ψ` continuous); the inner product with `e(ψ 0)` is `∫ cos(ψ s − ψ 0)`; `cos(ψ s − ψ 0) ≥ cos s` (`Real.cos_le_cos_of_nonneg_of_le_pi` after `Real.cos_abs`) | one-sided derivatives at the ends of `Icc` | 4 h |
| `.sin_le_inner` | the same with `e(ψ s)`: `∫₀^s cos(ψ s − ψ u) du ≥ ∫₀^s cos(s − u) du = sin s` | — | 3 h |
| `.strictMonoOn_dist` | `(d/ds)‖γ s − γ 0‖² = 2⟨γ s − γ 0, e(ψ s)⟩ ≥ 2 sin s > 0` on `(0, ℓ]`; `strictMonoOn_of_deriv_pos` on the square, then the square root | positivity at `s = 0` is not needed (strict on the interior) | 3 h |
| `.norm_sub_le` | `‖∫₀^s (e(ψ u) − e(ψ 0)) du‖ ≤ ∫₀^s u du` (`norm_e_sub_e_le`, wave 1) | — | 2 h |
| `.one_le_dist` | `f s = ‖γ s − γ 0 ∓ i e(ψ 0)‖²`, `f 0 = 1`, `f' = 2⟨γ s − γ 0, e(ψ s)⟩ ∓ 2 sin(ψ s − ψ 0) ≥ 2 sin s − 2 sin s` (`sin_le_inner`; `Real.sin_le_sin_of_le_of_le_pi_div_two` with `|ψ s − ψ 0| ≤ s ≤ π/2`); monotone | the planner's derivation — § 11.5 (4) | 3 h |
| `lipschitzOnWith_of_chord` | for `u < s` in `I` and `n` pieces: `|ψ sᵢ₊₁ − ψ sᵢ| ≤ 2 arcsin(Δ/2)` once `|Δψ| < π` (uniform continuity on `[u, s]`), sum, `n → ∞` | the limit `n · 2 arcsin(d/2n) → d`; or: `ψ` is locally Lipschitz with constant `1 + ε` for every `ε` | 5 h |
| `notMem_essBdry_of_mem_densitySet` | `notMem_essClosure_of_mem_densitySet` (`Plane/Saturated/Fan`; import it) for the other classes; `essBoundary` excludes the class's own density points | — | 0.5 h |
| `ae_one_colour_of_isConnected` | E8 § 3.5: for `x ∈ W` some `j(x)` has `x ∈ densitySet (cls j)` (`exists_mem_essClosure_of_cover`, wave 2; no essential boundary); the other classes are null near `x` (no cusp: not in their support); so `{x ∈ W | ball about x a.e. in cls j}` is open for each `j`, the sets partition `W`, and `IsPreconnected` makes one of them all of `W` (`isPreconnected_iff_subset_of_disjoint`); then a.e. by a countable cover (`ae_le_set` through `IsOpen` and Lindelöf, or density points: `W ⊆ densitySet (cls j)` and `volume_densitySet_diff`) | the finish — use `volume_densitySet_diff` (wave 2), no cover | 5 h |
| `closure_essBdry_subset` | E8 § 3.1 (0): `x ∈ closure (essBoundary (cls j))` for one `j` (finite union); `exists_ne_mem_essClosure` (wave 2) gives `b ≠ j` at each approximant, one `b` on a subsequence (pigeonhole on `Fin k`, or `closure` of a finite union twice); `essSupport` closed; not a cusp of either gives both in `essClosure`; `notMem_essClosure_of_mem_densitySet` | the two finite pigeonholes: write `essBdry = ⋃ j, ⋃ b ≠ j, essBoundary (cls j) ∩ essClosure (cls b)` first | 5 h |
| `local_graph` | E8 § 3.1 (1)–(4). Children: (a) in `U`: `essBoundary A = essBoundary B = supp A ∩ supp B` (`TwoColourOn.essBoundary_inter_eq`; no cusp) — 3 h; (b) `c11_discs` at every such point, one `N` — given; (c) § 3.1 (3)(b) `|⟨x″ − x′, ν′⟩| ≤ δ²/2` — 2 h; (d) § 3.1 (3)(c), the crude `6δ` (the lens point; control `e8_lens.py`) — 5 h; (e) **sharp**: `norm_sub_le_of_discs`, the midpoint of the centres within `3.5δ` — 3 h; (f) existence on each normal segment (a segment is connected; its ends in the two open sets) — 4 h; (g) uniqueness and `|g u| ≤ u²` — 4 h; (h) the curve: `g` differentiable with `g' = −ν₁/ν₂`, arclength `s(u) = ∫√(1 + g'²)` strictly increasing with a `C¹` inverse, `γ = (u(s), g(u(s)))`, `ψ` a continuous lift of the tangent angle, `lipschitzOnWith_of_chord` with (e) — 2 d; (i) the two sides connected, their colours — 6 h | (h): Mathlib has no arclength reparametrization; **do not** follow § 3.1 (4)'s "where `g″` exists … absolutely continuous" (§ 11.5 (1)) | 5 d |
| `AeColouring.local_graph` | `exists_twoColourNhd_of_mem_interfaceSet` (`y ∉ Σ`), `U' = U ∩ ball y ρ`, cusps lie in `Σ`, `TwoColourNhd.mem_essBoundary`, `local_graph` | — | 1 h |
| `gamma` | E8 § 3.2, by its kernel note: no classification of one-manifolds. From a chart at `y`, the family of injective `IsUnitCurve`s through `y` inside the component, ordered by extension; lengths are at most `π/2` (`chord`: a sub-arc of length `π/2` has chord `≥ 1 > 2R`); the union of a chain is a curve (`ψ` extends: 1-Lipschitz); a maximal one is open and closed in the component (charts at its points; at an end inside the punctured disc the chart extends it — § 3.2 (3)) | gluing two charts along an overlap (two `IsUnitCurve`s with the same image near a point agree up to the parameter's shift and sign) | 4 d |
| `IsUnitCurve.exists_polarGraph` | `t(s) = dist (γ s) (γ 0)` strictly increasing and continuous (`strictMonoOn_dist`), so a homeomorphism of `[0, L]` onto `[0, t(L)]`; `φ(t)` a continuous lift of `arg (γ(s(t)) − γ 0)` chosen near `ψ 0` (`norm_sub_le`: the direction is within `s/2 · (1 + o(1))` of `e(ψ 0)`, so one branch of the argument serves for small `t`, and on `(0, t(L))` the direction stays in the open half-plane about `e(ψ 0)`? — **check**: it holds while `s < π/2` by `chord`, whose inner product is positive) | the lift: use `chord` to keep `(γ s − γ 0) · conj (e (ψ 0))` in the right half-plane, where `Complex.arg` is continuous, and put `φ = ψ 0 + arg(…)` | 1.5 d |
| `beta` | `gamma`; `z` in the closure forces an end at `z` (the other points of the closure are in the punctured disc or on the circle); `strictMonoOn_dist` forces the other end on the circle; `exists_polarGraph` with `dist (γ L) z = R` | — | 4 h |
| `alpha` | E8 § 3.4 (a)–(e): every component meeting the half disc meets the circle of radius `R/2` (continuity of the distance along `γ`); `essBdry ∩ sphere z (R/2)` compact (`closure_essBdry_subset`, no cusp there); each of its points has a chart lying in one component; finite subcover; the least distance of the finitely many components that miss `z` | (c): a chart's image is connected, so in one component | 1.5 d |
| `fan_of_isolated` | E8 § 3.6 with `R' = min R (1/2)`: `alpha`'s `r`; the components with `z` in their closure are finitely many polar graphs (`beta`) pairwise disjoint; lifts ordered within `(φ₀, φ₀ + 2π)` (continuous and never equal mod `2π`); `Fin n` by sorting at one `t`; regions by `ae_one_colour_of_isConnected` (a polar region between two continuous graphs is open and connected) | the ordered lifts; connectedness of `polarRegion` | 3 d |
| `regJLiteral_of_saturated`, `finite_arcs_of_isBounded` | E8 § 3.7: a component with `z` in its closure meets the fan's disc on a branch, and a branch lies in one component; compactness off the fans | — | 0.5 d, 1 d |
| `Fan.two_le_n`, `Fan.col_ne` | § 11.5 (3): a continuous polar graph is null (the image of a graph in `(t, θ)` under the polar map, locally Lipschitz); near a branch point every point is on the branch or in one of the two neighbouring cells; so equal colours make it a density point, against `F.bdry` and `notMem_essBdry_of_mem_densitySet`; `n = 0`: `ae_one_colour_of_isConnected` on the punctured disc | the null graph (`MeasureTheory.addHaar_image_eq_zero_of_differentiableOn_of_addHaar_eq_zero` for the polar map) | 1 d each |
| `Fan.branch_outside_discs` | a branch is a component with `z` in its closure (§ 10.2 (2)); `gamma`'s curve from `z`; `one_le_dist`; `F.dir i ≡ ψ 0` mod `2π` (`exists_polarGraph`'s limit and `F.tendsto`) | identifying the fan's `φ i` with the curve's polar angle | 1 d |
| `Fan.branch_contacts` | at branch points `pinch_interface`'s two types; a split point makes the whole branch a unit arc (§ 11.5 (4)); else all tangent, the normals `i e(ψ s)` converge (`IsUnitCurve` on the closed interval), contacts `x ± ν(x)` converge, supports are closed | the propagation of the split type | 1.5 d |
| `Fan.sector_alone` | `plans/FS121-V2-verification.md` §§ 2.2–2.3 verbatim: Lemma C is `half_dichotomy`; Lemma H from it on two cells of one colour (a cell is preconnected, in the density set: `subset_densitySet_of_isOpen_ae_subset`); the directions `D(W)` of a cell of positive angle are the open arc `(dir i, nextDir i)` (`F.tendsto`); the angular lemma; the zero-angle case by `branch_contacts`' three cases and `branch_outside_discs` | `D(W)` for a cell from the fan's fields; the angular case analysis (V2's control `fs121-v2-sectors` is a half-degree grid) | 2.5 d |

**The price of the bridge**: `Curve` 2.5 d, `LocalGraph` 6.5 d, `FanBridge` without the two sector rows 14.5 d — **about 23 agent-days**, 80 %
interval [12, 40]; registered 15 [6, 30] (Y4). Re-priced from the first two leaves closed here: `norm_sub_le_of_discs` (planned at an hour,
closed in one elaboration) and the fan's inhabitant (§ 10.3) — the *computational* leaves (`Curve`'s six, the two colouring lemmas of
`LocalGraph`) are likely high by a factor of two to three; `local_graph` (h), `gamma` and `fan_of_isolated` are not re-priced by them and carry
the interval's width. **Order of landing**: `Curve` and `LocalGraph`'s first three leaves at once; `local_graph`; then `FanBridge`. If
`gamma` proves large, `fan_of_isolated` stays a `sorry` and every consumer still lands over `Fan` (ruling 490 (a)).

### 11.5 Findings on the bridge (sent to the coordinator mid-job)

1. **A step that does not formalize as written, and a shorter route** — E8 § 3.1 (4), *Regularity*: "At a point where `g″` exists the graph stays
   outside two open unit discs tangent to it there, so its curvature is at most 1 in absolute value; the tangent angle `ψ = arctan g′` is
   absolutely continuous with `dψ/ds = κ`, so `ψ` is 1-Lipschitz in arclength." In the kernel that is Rademacher's theorem and the fundamental
   theorem for Lipschitz functions. **Replacement, proved** (`norm_sub_le_of_discs`): with `w = x′ − x″`, `s = ν′ + ν″`, non-overlap of the
   opposite discs is `‖w + s‖ ≥ 2`, `‖w − s‖ ≥ 2`; the parallelogram law twice gives `‖ν′ − ν″‖² = 4 − ‖s‖² ≤ ‖w‖²`. The non-overlap holds
   because the midpoint of two overlapping opposite discs' centres, `x′ + (x″ − x′)/2 + (ν′ − ν″)/2`, lies within `3.5δ` of `x′` by § 3.1 (3)(c)'s
   crude bound, hence in `N`, where the two discs are a.e. of two almost disjoint sets. The chordal bound then gives the angle's
   (`lipschitzOnWith_of_chord`). One mind (the planner's); the algebra is kernel-checked, the lens-in-`N` step is `local_graph`'s child (e).
2. **The fan's existence reads only a crude curvature bound** (its `r` is existential): with § 3.1 (3)(c)'s constant 6 alone, lengths are at most
   `π/12` in a disc of radius `1/12`, and §§ 3.2–3.6 run. The sharp constant is read by the consumers' lens only. Not used to restate anything.
3. **A generalization**: FS131-E8-FAN's "at least two [curves]" and "regions on the two sides of a curve being of different colours" read no
   saturation — they follow from the fan's fields and, for the first, `z ∈ Σ` (§ 11.4, `Fan.two_le_n`, `Fan.col_ne`). The planner's argument.
4. **Three statements are the planner's assembly**, for a deriver's check: `IsUnitCurve.one_le_dist` (E8's § 4.6 offered
   `|φ i t − dir i| ≤ arcsin(t)/2`, which does not put the branch outside the unit disc; the three lines of § 11.4 do, from E8's C2);
   `Fan.branch_contacts` (V2's Lemma T (ii), with the claim that a branch is of split type along its whole length or of tangent type along it:
   at a point with a common contact `y` of both colours `pinch` gives the split type — its other case needs antipodal contacts — and
   `c11_split` carries the unit circle about `y` along the connected branch); `fan_of_isolated` at every `z` isolated from `Σ ∖ {z}`.
5. **Ruling 495 (a)**: `local_graph` reads `TwoColourOn A B N` and "no cusp in `U`", never `Σ`; the centred-ball `Σ` serves. The agreement of
   the two readings under saturation is not stated; priced at a day after `local_graph` (small centred balls about a chart's point are cut by the
   curve into two connected pieces).

**Mutation audit** (statement level, by hand): `fan_of_isolated` without `hsat` is false (E8 § 4.1: circles of radii `2⁻ⁿ`, a spiral);
without `hS`, false at an accumulation point of `Σ`; `gamma` without `le : R ≤ 1/2`, false (a unit circle of interface in a disc of radius
above 1); `ae_one_colour_of_isConnected` without `hcusp`, false (E8's not-claimed line); `local_graph` without `hcusp` is the gap the deriver's
erratum names; `sector_alone` without `hsat`, false (V2 § 2.4: the bow-tie blocks); `norm_sub_le_of_discs` without `h2`, false (two points of a
line with normals tilted the same way toward each other).

## Stage 12 — SAVED: the hand-off, the builds, what a third pass takes, the expectations scored

### 12.1 For implementers: the split by file (statements fixed; children under names of their own)

Thirty-one `sorry` leaves on the branch (`Pinch` 7, `MapColouring` 1, `Curve` 6, `LocalGraph` 5, `FanBridge` 12). No two of these files' leaves depend on each other's *proofs*, only on statements, so all four lines can
run at once on branches cut from this stage's commit (`fs131-w6p` and `fs131-w6m`, cut at stage 9, hold the first two already).

| line | file | leaves | imports it needs proved | plan |
|---|---|---|---|---|
| P | `Plane/Saturated/Pinch` | 7 | — | § 5, § 9.4 |
| M | `Plane/Saturated/MapColouring` | 1 (`sat_inP`), with `sq9` as an `ArcMap 9` (§ 7.1) | — | § 5 |
| C | `Plane/Saturated/Curve`, then `LocalGraph` | 6 + 5 | `c11_discs`, `TwoColourOn.essBoundary_inter_eq` as statements | § 11.4 |
| F | `Plane/Saturated/FanBridge` (and `sq9.SingLocallyFinite` in `FanExamples`, § 10.3) | 12 | `LocalGraph`'s and `Curve`'s statements | § 11.4 |

Line F is the largest and may be two implementers: one on `gamma`, `exists_polarGraph`, `beta`, `alpha`, `fan_of_isolated`, the CLAUSE2 pair;
one on the `Fan` lemmas (`two_le_n`, `col_ne`, `branch_outside_discs`, `branch_contacts`, `sector_alone`), which take `gamma` and `beta` as
statements. Build and iteration as § 7.1. Each leaf proved gets its `#print axioms` line in `scripts/Axioms.lean`'s block "FS131-K6b".

### 12.2 Vacuity and inhabitants (`LEAN.md` § The gate's form)

- `pinch`, `c11_discs`, `c11_split`, `TwoColourOn.essBoundary_inter_eq`, `pinch_interface`, `c11_discs_interface`: `sq9` at `sqEdgePt`
  (`sq9_twoColourNhd`, `sqEdgePt_mem_ball`, `sq9_tight_saturated`; the contacts by `sq9_isTangentAt`, a leaf). `pinch_not_in_in` concludes `False`;
  its docstring names the model of the other hypotheses.
- `IsUnitCurve`'s theorems: `isUnitCurve_segment`. The unit circle (`γ s = e s`, `ψ s = s + π/2`), where `chord`, `sin_le_inner` and
  `one_le_dist` are equalities, is owed as the sharpness example with `chord`'s proof.
- `local_graph`: `sq9` at `sqEdgePt`, `N = U = B(sqEdgePt, 1/8)`; **owed**: no cusp of the two classes in that ball (the docstring says so).
- `gamma`, `beta`, `alpha`, and every theorem over `IsolatedAt`: `sq9_isolatedAt`. `fan_of_isolated`: the same. `regJFan_of_saturated`,
  `regJLiteral_of_saturated`, `finite_arcs_of_isBounded`: `sq9` once `sq9.SingLocallyFinite` is proved (owed, § 10.3) — until then the note
  names `sq9` for `Saturated` only.
- `Fan.two_le_n`: `sq9Fan` with `sqVertex_mem_singularSet`. `Fan.col_ne`, `Fan.branch_outside_discs`, `Fan.branch_contacts`,
  `Fan.sector_alone`, `Fan.sector_unique`: `sq9Fan` with `sq9_tight_saturated.2.1.saturatedOn _`. In `sq9Fan` no colour repeats, so
  `sector_alone`'s `hcol` holds only at `i = i'`; an object with a repeated colour on two regions that satisfies everything but the conclusion
  is what the theorem refutes (V2 § 2.4: none exists under saturation).
- No theorem of this pass quantifies over a class that no held object inhabits. The first pass's § 2 list of uninhabited classes (D2-EXT,
  D2-THIN, D1-PENCILWIN, V5-RAY, D4-HOLE, O1-OUT's curved case) is the third pass's.

### 12.3 The builds

- As given: § 8.3. The foundation: § 9.3.
- With `Fan` and `FanExamples`: § 10 (OK, 466 of 466 batches, 8 `sorry` warnings; `data/fs131/k6b/logs/build-3-fan.log`).
- With `Curve`, `LocalGraph`, `FanBridge` (the final build): **OK — 466 of 466 batches, 4 modules rebuilt, 5 modules with warnings, 31 warnings, every one `declaration uses sorry`**, exit 0 (`build/gate/build/20261006T121157Z-3880314.log`; driver log `data/fs131/k6b/logs/build-4-bridge.log`). Before it the five new modules were elaborated as one scratch file with `lake env lean` (iteration only).
- `./scripts/dupnames.sh` (under the slot, after the final build): **OK — no name is declared by two modules** (23 generated on demand, the listed class; `data/fs131/k6b/logs/dupnames-1.log`). `tools/check_architecture.py`: PASS (five rows added to § 3.11). No `axiom`, no `native_decide`. The gate
  (axioms, vacuity, linters) is not a planning job's and was not run.

### 12.4 What a third planning pass takes, exactly

**Not stated by this pass, with what was and was not read:**
- **The ladder, 14 of its 17 rows**: FS121-D2-EXT, -D2-THIN, -D2-SYM, -D2-PERFIN, -O1-ENDS, -O1-OUT, -DB1-L6, -DB1-L7, -D1-EROSION, -V5-RAY,
  -D4-HOLE, -V3-CPI, -V2-VT-W with FS121-D1-VT (under its own name, ruling 487 (a)), -D1-PENCILWIN; and FS121-V5-LOC's clause (iii).
  Stated here: FS121-DB1-L3 (`Fan.sector_unique`), FS121-V2-SECTOR (`Fan.sector_alone`), FS121-V5-LOC (i), (ii).
- **The fragment's six**: FS116-O1-SATPIN, -N1-AXIS, -S1-RUNG, -V4-PARTNER, -S1-KAPPA, -S1-PAIR (the last two at `ArcMap 6`, ruling 487 (e)).
  The foundation is ready for them: SATPIN reads `pinch` and `local_graph` for the family `F.region` on an open `N` inside the fragment's
  disc, with `SaturatedOn F.region (ball p ρ)` — "the inner-disc reading" is that predicate; whether SATPIN's statement lacks a hypothesis
  (X5 (d)) is still open, its argument unread.
- **FS111-M2-HULLC** (on a cover `disj` can fail: read `plans/FS111-M2-regularity.md` § 2.2 first; ruling 487 (b)), **FS111-W-KB-DIR** (a fan
  at the centre of a split arc: `Fan.branch_contacts`' first case is its setting), **FS111-M2-INTRAD**.
- **Arguments not read by either pass**: `plans/FS121-DB1-verification.md` §§ 2.3, 2.5; `FS121-V2-verification.md` §§ 2.5–2.9;
  `FS121-V3-verification.md` § 2.3; `FS121-D1-proof.md` §§ 2.1–3.1; `FS121-D2-proof.md` § 2; `FS121-V5-verification.md` § 3.1;
  `FS121-D4-proof.md` § 2.3; `FS121-C1-proof.md` § 2.3; `FS121-map-step.md` §§ 3.2–3.3; `plans/FS111-M2-regularity.md` §§ 2.2, 4.1;
  `plans/FS111-W-wild.md` (W-NOBEND, W-KB-DIR); the six FS-116 entries' arguments. Read by this pass: `FS121-V2-verification.md` §§ 1.4–2.4.
- **Unresolved expectations**: X5 (b) (ENDS's "null set of normals" against L6's "finitely many"), (d), (e).
- **What the third pass can lean on**: rows over a fan at one point take `(F : c.Fan z) (hsat : SaturatedOn c.cls (ball z F.r \ {z}))`
  and read a branch through `F.tendsto`, `Fan.branch_outside_discs`, `Fan.branch_contacts`; rows over `RegJFan` take `c.RegJFan` (or
  `Saturated c.cls` and `c.SingLocallyFinite`, by `regJFan_of_saturated`) and "finitely many arcs in a bounded set" from
  `finite_arcs_of_isBounded`; curves are `IsUnitCurve`s (a circular arc of radius `n` about `w`: `γ s = w + n e(θ₀ + s/n)`,
  `ψ s = θ₀ + s/n + π/2`), with the pointwise type from `IsInterfaceChart.discs` and `IsTangentAt`. The deriver's § 4.6 table is confirmed
  for two of its rows (DB1-L3, V2-SECTOR: a fan at one point, saturation at its branch points, no local finiteness) and unchecked for the rest.

### 12.5 Held for the coordinator

1. The three planner-assembled statements and the generalization of § 11.5 (3), (4): a deriver's check before `Fan.branch_contacts`,
   `IsUnitCurve.one_le_dist`, `Fan.two_le_n`, `Fan.col_ne` are implemented.
2. The erratum line for E8 § 3.1 (4) (the regularity step; § 11.5 (1)), with the deriver's two lines.
3. § 9.1 item 1 (the two readings of `Σ`): ruled (inventory item 495); the agreement lemma is a row candidate, priced at a day, not stated.
4. FS111-W-NOBEND's merge into FS111-M-C11 (ii) / FS131-E8-LOCAL: confirmed from its entry, its argument unread.
5. `sq9.SingLocallyFinite` (and with it `sq9.RegJFan`) is owed before the wave's gate, as the model of every theorem over `RegJFan`.

### 12.6 Expectations scored (§ 8.4)

| # | registered | outcome |
|---|---|---|
| Y1 | 3 defects among the rows I state, [1, 7] | among the rows stated: (a)–(f) concern rows not reached; found instead: the two frozen sentences on `Σ`'s neighbourhood differ (§ 9.1); the frozen (H2)'s closure clause is redundant at essential boundary points; E8-FAN's "at least two / neighbours differ" over-hypothesized. 3, none a falsehood |
| Y2 | a bridge step that does not formalize as written, 0.6 | **yes** — § 3.1 (4)'s regularity step (neither of the two registered as likeliest: the constants were not reached, and § 3.2 (2)'s parametrization is `gamma`, priced not proved) |
| Y3 | I prove 2 leaves beyond the inhabitants, [0, 4] | `norm_sub_le_of_discs`; `regJFan_of_saturated`, `pinch_interface`, `c11_discs_interface`, `TwoColourNhd.mem_essBoundary`, `Fan.sector_unique` (each from a leaf); `AeColouring.twoColourNhd_of_h1`, `twoColourNhd_of_halves`, `notMem_essClosure_of_mem_densitySet`. FS131-E8-DELTA was registered short and was not proved |
| Y4 | the bridge 15 agent-days, [6, 30] | re-priced 23, [12, 40] (§ 11.4) |
| Y5 | 9 of the 28 left rows stated, [4, 20] | **4** stated or made corollaries (C11 (ii), W-NOBEND, DB1-L3, V2-SECTOR) and V5-LOC in part, beside the bridge's eight: at the interval's lower end. The fan's inhabitant took the stage the ladder would have |
| Y6 | one curve notion, unit-speed with 1-Lipschitz angle, 0.65 | yes |
| Y7 | ≥ 3 rows read a different class than their entry, 0.7 | of those read: PINCH (two sets), C11 (i) (every point of one `N`), E8-LOCAL (no `Σ`), E8-FAN (no `z ∈ Σ`; two clauses without saturation), E8-GAMMA (no `z ∈ Σ`): yes |
| Y8 | the restated foundation costs the proved rows nothing, 0.85 | yes — no proof edited |
