# FS-131 wave 6 — saturated colourings: the kernel plan (de Bruijn, the planner)

*Job FS131-K6, de Bruijn (Opus 5.5), launched 2026-10-06 on branch `fs131-w6` (cut from `main` at wave 5's landing, HEAD `a917d57f`), in the
worktree `.claude/worktrees/fs131-w6`. Brief `data/fs131/briefs/FS131-K6-wave6.md`, with `plans/STANDING-RULES.md`, `LEAN.md` and `RUNNING.md`
§ Building. Claim list `plans/LEAN-BACKLOG.md` (ruling 2 of `plans/FS131-close-inventory.md`); no phase-1 fence (ruling 1). Working files
`data/fs131/k6/`; tools `tools/fs131_k6_*.py`.*

## Theorems this phase proved

(Filled at each stage; a planning job proves only what is short. See the last stage's list.)

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
