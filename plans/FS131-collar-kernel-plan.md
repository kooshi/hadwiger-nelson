# FS-131 — the collar bend's construction: the kernel plan (de Bruijn, the planner)

*Job FS131-KP2, de Bruijn (Opus 5.5), launched 2026-10-05 on branch `fs131-w5` at `ae881022` (worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5`). Brief `data/fs131/briefs/FS131-KP2-collar.md` (on `main`), with
`plans/STANDING-RULES.md`, `LEAN.md` and `RUNNING.md` § Building. No fence (inventory ruling 1). Working files `data/fs131/kp2/`; tools
`tools/fs131_kp2_*.py`.*

## Theorems this phase proved

None yet (updated at each saved stage). A planning job: it lays `bend_toward_collar` out as named children with `sorry` at each; a child
short enough to prove here is proved and listed here with its grade and address.

## Stage 1 — SAVED: the readback, the as-given build, and what this job plans

### 1.1 The brief's quotations against their sources (standing rule 3)

Checked by script, 2026-10-05: `tools/fs131_kp2_quotes.py` reads each quotation from the brief itself (the `> ` line above each
`> — source:` line) and requires it verbatim in the source the brief names — the leaf at `ae881022`, KB2's record at `ae881022`, the
inventory and `CLAUDE.md` on `main`. Result `data/fs131/kp2/quotes.txt`: **PASS, 9 of 9 verbatim**; `--self-test` changes one character in
each quotation in turn and requires the check to fail: **9 of 9 plants fired** (`data/fs131/kp2/quotes-selftest.txt`).

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "Do not consider Lean formalization a cost. …" | `CLAUDE.md` § Counter-priors | verbatim (two sentences of Kooshi's longer quotation) |
| 2 | "theorem bend_toward_collar (hF : F.Valid) {P : ℂ} …" | `Plane/ValidMap/BendCollar.lean` at `ae881022` | verbatim (its first line) |
| 3 | "- **The lens boundary `β`**: `C_A`, `C_B`, …" | `plans/FS131-I5-implementation.md` § 44.3 | verbatim (its first line) |
| 4–9 | items 359, 365, 369, 378, 386, 387 (first lines) | `plans/FS131-close-inventory.md` on `main` | verbatim |

No mismatch. One note on the brief's wording, not a defect: "Done means" item 2 lists `RingArcsWithin` among "the child's clauses"; the
statement of `bend_toward_collar` has no `RingArcsWithin` clause — R1 (`M.IsRingArc → F.IsRingArc`) is its constant-sided form. The
construction gives `M.RingArcsWithin F` anyway (every arc it adds has radius `≠ 1`), and this plan states it as a child because R1 is proved
through it (§ 3).

### 1.2 The as-given build (`ae881022`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — all 1781 modules already up to date, nothing built,
4 modules with warnings, every warning `declaration uses 'sorry'`**, exit 0 (`build/gate/build/20261005T104808Z-3479001.log`; driver log
`data/fs131/kp2/build-asgiven.log`). The `sorry` declarations: `BendCollar` 1 (`bend_toward_collar`, line 31), `HexRing` 1 (`bv_l3`),
`BaseDense` 4 (three `exists_preBend` children and `cv_exists`'s stale copy), `Terminal` 9 (stale; the `Terminal` lane's).

### 1.3 What this job plans, and what it may change

**Planned**: the construction of `ArcMap.bend_toward_collar` (`Plane/ValidMap/BendCollar`), whose statement is fixed — reduced to named
children, each with `sorry`, each read back against what its consumer needs, a plan and a price per child, the obligation pass, inhabitants
for any structure a child takes as a hypothesis, and a handoff that two implementers can split by file. A child provable in about an hour is
proved here.

**May change**: `Plane/ValidMap/BendCollar.lean` (new declarations; `bend_toward_collar`'s docstring and statement byte-for-byte unchanged,
checked by script), new modules upstream of it, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-I5g",
extended), this record, `tools/fs131_kp2_*.py`, `data/fs131/kp2/`, `data/fs131/reports/FS131-KP2.md`.

**May not change**: any declaration `main` brought (new declarations only — so `bendMap`, `cutArcs`, `toward_clear`, `bend_toward` are cited
or re-proved under new names, never edited); `BaseDense` (the remaining `exists_preBend` children are another job's), `HexRing`,
`BaseWalk`, `Terminal`. No merge of another branch, no gate run, nothing on `main`. No new `axiom`, no `native_decide`.

## Stage 1 — SAVED

## Stage 2 — SAVED: the route checked (D1 against the clauses and against `main`'s machinery)

### 2.1 Read back: what each clause needs, and where D1 meets it

The construction as laid out here (the skeleton, § 3) is KB2's D1 with one change of frame: **the bent map is `F`'s image under the
homeomorphism** (`ArcMap.pushforward`: same domain, arcs `cutArcs ∪ {collarArcA, collarArcB}`, colour `F.col ∘ h⁻¹`), not a `bendMap` with
a recoloured lens. D1 already says "the bent map as the image of the old one"; taking it literally makes clauses 4–6 topology, with no case
on the lens.

| clause of `bend_toward_collar` | how the construction meets it | `main`'s machinery reused | new children |
|---|---|---|---|
| 1 `M.Valid` | `Valid.of_agreesOff` on the closed lens; its points are `c'` in `M`, clear for `c'` in `F` (open lens: `toward_clear`, the lens being under the toward profile; open arc: `ne1_region`), no two `1` apart (radii `≤ 1`, angles within `60°`) | `Valid.of_agreesOff`, `toward_clear`, `n2_env_toward`, `n2_env_near`, `ne1_region` | `map_valid`, `map_agreesOff`, `map_lens`, `one_sub_lensProf_le`, `dist_lt_one_of_mem_polarSet`, `CollarFit.clear` (in `exists_collarFit`) |
| 2 `M.dom = F.dom` | definitional (`rfl`) | — | — |
| 3 `h = id` off `thickening ε α` | `h = id` off the collar `K`, and `K ⊆ thickening ε α` | — | `homeo_eq_self`, `pushHomeo_eq_self`, `CollarFit.sub_thick` |
| 4 `h` fixes `Γ ∖ α°` | `Γ ∩ K ⊆ α` (`CollarFit.free`) and `h` fixes the ends | — | `homeo_fix_Γ` |
| 5 interior points and colours carried | `M.interiorPts = h(F.interiorPts)`, `M.col ∘ h = F.col` | — | `pushforward_mem_interiorPts_iff`, `pushforward_col_apply` (proved) |
| 6 `coloursAt` carried | a homeomorphism carries closures of classes | — | `pushforward_coloursAt`, `pushforward_region` |
| 7–8 degree, repeated colour | **computed at each point, never transported by `h`** (sector counts read balls): off `K` the maps agree near the point; inside `K` interior points have degree 1; `α°` and `β°` have two-germ charts with sectors `c`, `c'`; at the ends `M`'s chart is `F`'s with `α`'s germ curvature `1 ↦ ±1/R` | `localSectors_disj`, `isSectorChart_of`, `IsSectorChart.hasDegree`, `IsSectorChart.encard_sectorsOf`, `exists_eq_branchPt_curveGerm`, `branchPt_curveGerm_mem`, `exists_germDir_ne_of_ne`, `carrier_germArc`, `not_hasRepeatedColour_of_mem_interiorPts` | `map_hasDegree`, `map_hasRepeatedColour`, `hasDegree_iff_of_agree`, `hasDegree_iff_of_mem_interiorPts`, `degree_openArc`, `map_degree_lensCurve`, `map_degree_end` |
| 9 R1 | the arc lies in `F.Γ` (`M` creates no unit arc: `β` has radius `R ≠ 1`); its sides change only at the ends, where the collar's horn lies on one side of `ω(Q)` | `ringArcsWithin_of_Γ_subset`, `germArc_isUnitArc_iff` | `map_R1`, `map_ringArcsWithin`, `sides_end` |
| 10 R2 | the closed arc misses `α°` (an end on `α°` is excluded by `hfree`), so lies in `M.Γ`; sides as in R1 | `mem_cutArcs_iff` | `map_R2`, `map_Γ` |
| 11 R3 | `α°` lies in the lens, interior in `M` | — | `map_R3` |
| 12 no new inert arc | only `c` is lost, only on `lensSet`; a unit arc centred there never has `c` on a side | `lock`, `Valid.dist_ne_one_of_isOpen_subset_closure` | `map_inert`, `coloursAt_subset`, `side_ne_inner_of_mem_lens` |

**No clause D1 cannot meet.** Checked in particular: (a) `c = c'` is allowed by the statement (no hypothesis excludes it); every degree child
reads the sector colours as a list (`c` and `c'`), so `c = c'` needs no case. (b) An end where `α`'s germ is the only germ (then `c = c'`): the
germ swap is uniform (the sector before `i` is the sector from `i`). (c) An end where another germ has `α`'s direction: its curvature is not
`1`, so `R'`, `R''` (and `R` between them) can be taken nearer `1` than it — finitely many germs. (d) `ε` arbitrary: the collar is chosen inside
`thickening ε α ∩ dom` (`α` compact in the open domain). (e) The ends are fixed by `h`: `A = P + e(θ₁)` is a polar point only at angles
`≡ θ₁`, none in `(θ₁, θ₂)`.

### 2.2 Findings

1. **Generalization — `hmax` is not read by the construction** (grade: [reading], the planner's; its killing test is the proof of the
   children, none of which takes `hmax`). Maximality is what `exists_preBend`'s measure needs, not what the bend needs: a non-maximal `α`
   bends the same way (at an end where `α` continues with the same sides, the chart swap is the same). `hlen` is implied (`l60_le`, KB2).
   The assembly opens with `clear hlen hmax`. Nothing downstream changes: `exists_preBend_step` supplies both anyway. Sent to the
   coordinator mid-job.
2. **`toward_clear` and `n2_env_*` are public on this branch** (since the merge with `main`): KB2's "~30 lines to re-prove under a new name"
   is not needed; `toward_clear` is cited as it stands.
3. **`main`'s `bendMap` is not reused** (only its cut engine `cutArcs`, `cutArcs_locallyFinite`, `mem_cutArcs_iff`, `exists_kept_of_mem_openArc`,
   and its validity engine `Valid.of_agreesOff`): the pushforward frame replaces `bend_hlc`'s case analysis by one topological lemma
   (`pushforward_locallyConstant`), and KB2's "the collar lens inside `main`'s crescent `L`" is not needed — clearness comes straight from
   `toward_clear` at each lens point, and pairs from a polar bound.
4. **The bi-Lipschitz condition of I5o's notes (§ 41.2 (c)) is not needed**: no sector count is carried by `h`; each is computed from a chart
   at its point (§ 2.1, clauses 7–8).
5. **`RingArcsWithin`** (the brief's word) is not a clause; the construction proves `M.RingArcsWithin F` (`map_ringArcsWithin`) as R1's
   first step.

## Stage 2 — SAVED
