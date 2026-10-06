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
