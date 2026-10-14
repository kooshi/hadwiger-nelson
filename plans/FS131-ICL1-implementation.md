# FS131-ICL1 — the count's plane lane (Λ1) and extension lane (Λ4), proved

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-ICL1-count-plane-extension.md` (on `main`). Branch `fs131-wcl`,
cut from the chain's joined commit `3ae198eac`, in the tree `.claude/worktrees/fs131-wch`. Working files: `data/fs131/icl1/`.
Report: `data/fs131/reports/FS131-ICL1.md`. Commits by explicit path, not pushed (the brief: the server is unreachable).*

## Theorems this phase proved

*(filled at each saved stage; none at stage 1)*

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_icl1_readback.py` (FS131-K12A's checker with this brief's path) requires each block quotation of the brief, the
`> ` prefix and a list marker removed, as one whole line of its source on `main`'s working tree. Output
`data/fs131/icl1/readback.out`: **5 quotations, 5 IDENTICAL** — W2 (`data/fs131/REQUEST-2026-10-13.md`), the two dated lines
of 2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 832 and 854 (`plans/FS131-close-inventory.md`). Control
(`--plant`, `data/fs131/icl1/readback-plant.out`): one character changed in each quotation in memory, **5 of 5 reported**.

### 1.2 The branch, cut and built

`git checkout -b fs131-wcl 3ae198eac` in `fs131-wch` (clean, on `fs131-wk12` before). Build 1 under the slot
(`--mem 10 --cpus 4`, `MEMMAX=10G BATCH=8 ./scripts/build.sh`; `data/fs131/icl1/logs/build-1.log`, full output
`build/gate/build/20261014T145622Z-3507550.log`): **OK — 256 of 256 batches, 40 modules rebuilt, 20 with warnings, 9 m 27 s,
exit 0**; every warning in the log is `declaration uses 'sorry'`. One line sent to the coordinator.

### 1.3 The stored statements, dumped before any edit

`data/fs131/icl1/lean/StatementDump.lean` (after FS124-I2's dumper: every constant of the three modules' compiled data —
kind, stored type and its hash, a definition's stored value, and a pretty print with full names) run by `lake env lean` from the
built tree before any edit: `data/fs131/icl1/statements-before.txt`, **24 constants** (WindowDensity 9, PlaneZhang 9,
CountExtension 6), none internal. The comparator is `tools/fs131_icl1_statements.py` (stage 4 runs it, with its plants).

**Class binders against their sections** (item 847's defect; `fs131_icl1_statements.py --binders-only`). `Plane/WindowDensity`
has no section variable. `Rigidity/CountExtension`'s section declares `[NumberField F]`: **every one of its six constants names
`Subfield` and binds `NumberField ↥F`** — no miss. `Rigidity/PlaneZhang`'s section declares `[AddCommGroup Q] [Fintype Q]
[DecidableEq Q]`: every theorem binds all three; the four definitions bind only what their bodies read — `lonely` none,
`social` and `touched` `[Fintype Q]` (for `Finset.univ`), `RowsEdgeNull` `[AddCommGroup Q]` (for `q + s`). Nine misses, each a
definition omitting a binder it does not read, which is Lean's rule for definitions and no defect: **no stored statement lacks
a class binder its statement needs.**

**Unread binders the theorems carry** (pretty print: a binder printed without a name is not read by the stored type):
`measure_ne_eq` `[NumberField ↥F]`; `measurableSet_lonely`, `unitPairsNull_lonely` all three of `Q`'s; `ae_sIndep_social`,
`ae_disjoint_touched`, `sum_volume_inter_sq_le` `[DecidableEq Q]`. Whether a proof reads one decides whether the
`unusedSectionVars` linter warns; any it does not read is dropped by `omit … in` under item 726's word and listed at stage 4.
Of the statements in these files only `exists_slice` has a reader outside them (`Rigidity/CountDescent`), and it carries no
unread binder.

### 1.4 Each leaf, restated, beside its plan

| file | leaf | the statement, in one line | the plan (`plans/FS131-K12A-count.md` § 3.2) |
|---|---|---|---|
| WindowDensity | `densitySet_bandFree` | for measurable `A` with null unit pairs, its density points have no pair at distance exactly 1 and equal `A` a.e. | `dist_ne_one_of_mem_densitySet`, `upperDensityAt_pos_of_mem_densitySet`; `ae_eq_densitySet` |
| | `volume_inter_sq_le` | for such `A`, every window `squareWin a s`, `s > 0`, holds `|A ∩ W| ≤ m₁ (s + 2)²` | density set, trace on the window, periodised at `s + 2`; `upperDensity_periodize`; `le_iSup₂` |
| | `exists_periodic_near_mOne` | for `ε > 0` some measurable 1-avoiding set periodic under `Lℤ²` fills its cell `squareWin 0 L` to at least `m₁ − ε` | the supremum, a dense window, periodised |
| | `unitPairsNull_diff_essNbhd_union` | for `J` measurable 1-avoiding and `Z` measurable with null unit pairs, `(J ∖ N_e[Z]) ∪ Z` has null unit pairs | proved in scratch (`data/fs131/k12a/leaves/LeafP.lean`): fold in |
| | `exists_nrWindow` | for `ε > 0` there is `s₀ > 0` such that every measurable `Z` with null unit pairs has `|Z ∩ W| ≤ m₁ |N_e[Z] ∩ W| + ε s²` in every window of side `s ≥ s₀` | a near-optimal periodic `J`, its translates averaged over its cell (Tonelli) |
| | `essNbhd ∅ = ∅` (example) | the essential neighbourhood of the empty set is empty | `phi ∅ = 0` |
| PlaneZhang | `unitPairsNull_lonely` | the lonely points of a measurable row have null unit pairs | `pairSet_measure_eq_lintegral`: `phi = 0` on the lonely set |
| | `measurableSet_lonely` | the lonely points of a measurable row form a measurable set | `measurable_phi` |
| | `ae_sIndep_social` | with null edges and symmetric `S`, for a.e. `z` the rows in which `z` is social are independent in `Cay(Q, S)` | each `{z ∈ Y y : phi (Y x) z ≠ 0}`, `y − x ∈ S`, null by `RowsEdgeNull`; a finite union |
| | `ae_disjoint_touched` | for a.e. `z`, no row touched at `z` lies in the closed neighbourhood of the social rows | J28D (ii′)'s four cases, three by edge-nullity, one by the lonely slice swapped |
| | `sum_volume_inter_sq_le` | under `RatioLe S r`, `r ≥ 0`, null edges and `NRWindow ε s₀`, every window of side `s ≥ s₀` has `Σ_q |Y q ∩ W| ≤ (max(m₁, r) + ε) |Q| s²` | social and lonely points; `card_le_mul_card_closedNbhd` pointwise; `NRWindow` on each lonely set |
| CountExtension | `measure_ne_eq` | `P(c(0) ≠ c(y)) = (3/4)(1 − C(y))` for an invariant colouring | `tetra`'s two values |
| | `comap_ιG_le_nhds_tauPrime` | the completion's neighbourhoods of `0`, pulled back to `R`, are finer than `τ′_∅`'s | `nhds_inf`; profinite part by `exists_level_mem_nsmul`; archimedean part by the first coordinate |
| | `tendsto_measure_ne` | spectrum on `T + A` gives `P(c(0) ≠ c(y)) → 0` as `ιG y → 0` | proved in scratch over the two above (`LeafE.lean`): fold in |
| | `exists_extension` | spectrum on `T + A` gives a jointly measurable random colouring of `G_∅`, a.s. proper at every edge in the closure of `ι_G(U)` | approximants `π_n g` along neighbourhoods with summable error; Borel–Cantelli; the eventual value |
| | `exists_slice` | spectrum on `T + A` gives a measurable `φ : ℂ × K → Fin 4` whose monochromatic slice edges are null at every unit vector | Tonelli over the sample; `mem_closure_ιG`; countably many `u` |

**A route change, in advance of its build (Λ1, `exists_nrWindow`):** the plan averages a periodic `J` over its cell, which
needs "a periodic set fills every cell of its period alike" — no lemma of the library states it. Averaging one dense
*window* `T` (`T ⊆ squareWin 0 ℓ`, `|T| ≥ (m₁ − ε/4) ℓ²`) over the translates `T + t` that meet `W`, `t` in a square of side
`s + ℓ`, gives `|Z ∩ W| (s + ℓ)² + |T| |W ∖ N_e[Z]| ≤ m₁ (s + 2)² (s + ℓ)²` by Tonelli on `ℂ × ℂ` alone; choosing `ℓ ≥ 12 s/ε`
after `s` makes `|T|/(s + ℓ)² ≥ m₁ − ε/2`. The scale `s₀ = max(1, 16/ε)` still depends on `ε` only, as `NRWindow` asks.
