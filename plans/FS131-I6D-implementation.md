# FS131-I6D — wave 6, the bridge's existence half (`FanBridge`), and the model `sq9.SingLocallyFinite`

*The implementer's record (de Bruijn, the implementer). Branch `fs131-w6f`, cut from `fs131-w6` at `32f2ab4c`. Brief:
`data/fs131/briefs/FS131-I6D-wave6-bridge.md` (on `main`).*

## Theorems this phase proved

*(one line per kernel theorem, with its declaration and its axioms; filled stage by stage — see each stage)*

## Stage 1 — SAVED (FS131-I6D): the readback, the as-given build, what may and may not change

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation | source | result |
|---|---|---|
| the seven statement heads (`gamma`, `IsUnitCurve.exists_polarGraph`, `beta`, `alpha`, `fan_of_isolated`, `regJLiteral_of_saturated`, `finite_arcs_of_isBounded`) | `Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean` ll. 67, 78, 91, 100, 112, 130, 136 at `32f2ab4c` | each matches, character for character (the quotation is the first line of each statement) |
| "## Stage 11 — SAVED: the bridge's eight rows …", "### 11.4 The plan per leaf", the `FanBridge` module row, the `gamma`, `alpha`, `fan_of_isolated` rows, "### 12.1 …", "### 12.2 …" | `plans/FS131-w6-kernel-plan.md` ll. 577, 627, 603, 647, 650, 651, 696, 712 | each matches |
| "## Stage 3 — SAVED: the derivation — the four clauses, the fan, the bridge" | `plans/FS131-E8-derivation.md` l. 193 (on `main`) | matches |
| inventory items 501, 502, 490, 499 (first lines) | `plans/FS131-close-inventory.md` ll. 5176, 5205, 4925, 5122 (on `main`) | each matches |

No mismatch.

### 1.2 Read

The brief; `plans/STANDING-RULES.md`; `LEAN.md` in full; `RUNNING.md` § Building, § Make the gate fail, and watch it fail; the planners' record
Stages 9–12 whole; the deriver's Stage 3 (§§ 3.1–3.8) with the erratum under § 3.1 and the note under FS131-E8-FAN; the modules `Basic`, `Fan`,
`FanExamples`, `Curve`, `LocalGraph`, `FanBridge` whole, and `Pinch` ll. 150–260 (`TwoColourOn.essBoundary_inter_eq`, `TwoColourNhd.mem_essBoundary`).
Not read: the deriver's Stage 6 beyond its headings; the first pass's Stages 3 and 5.

### 1.3 The branch builds as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, in the worktree: **OK — all 1804 modules up to date, 5 modules with
warnings, 31 warnings, every one `declaration uses sorry`** (`Pinch` 7, `MapColouring` 1, `Curve` 6, `LocalGraph` 5, `FanBridge` 12), exit 0
(`data/fs131/i6d/logs/build-0-as-given.log`).

### 1.4 What I may and may not change

- **May**: the proofs of `gamma`, `IsUnitCurve.exists_polarGraph`, `beta`, `alpha`, `fan_of_isolated`, `regJLiteral_of_saturated`,
  `finite_arcs_of_isBounded` in `FanBridge` (and an import line there); new helper declarations under names of my own, in new modules of my own beside
  it (with `Proofs.lean` and `ARCHITECTURE.md` rows); `sq9.SingLocallyFinite` as a new declaration in `FanExamples`; a block "FS131-I6D" in
  `scripts/Axioms.lean`; this record; `tools/fs131_i6d_*.py`; `data/fs131/i6d/`; the report.
- **May not**: any statement or definition; `Basic`, `Pinch`, `MapColouring`, `Fan`, the planners' record; the five `AeColouring.Fan` leaves of
  `FanBridge` (`two_le_n`, `col_ne`, `branch_outside_discs`, `branch_contacts`, `sector_alone` — another implementer's, on `fs131-w6g`), nor helpers
  between them; `Curve` and `LocalGraph` (a third implementer's, on `fs131-w6c`); a new `axiom`; `native_decide`; `main`; the gate.
- **What my theorems rest on until the lines join**: `Curve`'s six leaves and `LocalGraph`'s five are `sorry` on this branch, so every theorem below
  that cites one prints `sorryAx` here; each stage's axioms line says which upstream leaves it reads.

### 1.5 The route, fixed before the first leaf (changes to the plan's § 11.4 are said where they are made)

- Helpers live in two new modules, so `FanBridge` gets proof bodies and one import line only: `Plane/Saturated/CurveArc` (no colouring: shift and
  reversal of a unit curve, the chord bound on any interval, the reparametrization lemma, the continuation theorem over a set with charts, the polar
  graph) and `Plane/Saturated/FanArcs` (the colouring's charts; the forms of `gamma`, `beta`, `alpha` with `IsolatedAt`'s fields as hypotheses).
- `gamma`, changed route (the plan's: Zorn over curves ordered by extension, "gluing two charts along an overlap"). Mine: (N) a map of an interval
  with `sin|Δs| ≤ |Δf|`, `sin|Δf| ≤ |Δs|` is `±s + c` (monotone, derivative `±1` by the cubic bound on `sin`); (R) a unit curve inside the image of a
  chart is the chart up to `±s + c` — both inequalities are the chord bound; (U) two arcs through `y` with one tangent angle there agree on their
  common interval (open and closed); the maximal arc is the union, its angle extended 1-Lipschitz to the line and the curve recovered as
  `y + ∫ e ∘ ψ` — every arc is the restriction of a curve on the whole line, which removes the one-sided derivatives at the ends; an end inside the
  punctured disc would be an essential boundary point (`closure_essBdry_subset`) and its chart would extend the arc; the component is the arc (open in
  the essential boundary by the charts, closed by the ends).
