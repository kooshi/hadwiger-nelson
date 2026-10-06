# FS131-IO — OPEN, the fifth move (`HasHornCount`, `exists_open`) in `Plane/ValidMap/OpenMove`

*The record of FS131-IO1 (de Bruijn, the implementer, on Opus), branch `fs131-wop` cut from `main` at `11a34d9d`, in the worktree
`.claude/worktrees/fs131-wop`. Brief: `data/fs131/briefs/FS131-IO1-open.md` (on `main`). Report: `data/fs131/reports/FS131-IO1.md`.*

## Theorems this phase proved

Kernel-checked in this job's stage-3 build (`build/gate/build/20261005T110040Z-3551665.log`), axioms printed against that build's oleans
(`lake env lean data/fs131/io/AxiomsIO.lean`, `data/fs131/io/axioms-stage3.txt`), all in `Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean`;
each reads exactly `[propext, Classical.choice, Quot.sound]` unless noted:

- `HadwigerNelson.Plane.ArcMap.HasHornCount.eq` — [kernel] — the horn count is unique
- `HadwigerNelson.Plane.ArcMap.HasDegree.eq` — [kernel] — the degree is unique
- `HadwigerNelson.Plane.ne_hornSet_of_interior_coneAt` — [kernel] — a set whose cone at `v` has an interior direction is no horn set
- `HadwigerNelson.Plane.exists_small_arcsin` — [kernel] — a uniform bound on `arcsin (κ t / 2)` for small `t`
- `HadwigerNelson.Plane.BranchGerms.idx_idx` — [kernel], `[propext]` — re-basing the orbit
- `HadwigerNelson.Plane.BranchGerms.turns_idx` — [kernel], `[propext, Quot.sound]`
- `HadwigerNelson.Plane.BranchGerms.liftDir_idx`, `BranchGerms.lift_idx` — [kernel] — lifted directions under re-basing
- `HadwigerNelson.Plane.BranchGerms.openWedge_subset_ball`, `BranchGerms.openRim_subset_sphere` — [kernel]
- `HadwigerNelson.Plane.ArcMap.Near.col_mem_coloursAt` — [kernel] — a chart sector's colour is carried at `v`
- `HadwigerNelson.Plane.ArcMap.Near.exists_openConfig_up` — [kernel] — **E6-OPEN's steps 2–4 on the side `σ = +1`**: the first sector of
  positive angle after a lone cusp, the ray inside it, and the clear wedge from `clear_near_end`
- `HadwigerNelson.Plane.ArcMap.Near.exists_openConfig_down` — [kernel] — the same on the side `σ = −1` (the orbit re-based at the first
  sector of positive angle before the cusp)
- `HadwigerNelson.Plane.ArcMap.Near.exists_openConfig` — [kernel] — **E6-OPEN's steps 1–4**: at a lone horn whose colour's allowed cone has
  interior, OPEN's configuration exists (N3-CONF, `cone_side`, then the side's lemma)
- `HadwigerNelson.Plane.ArcMap.Near.openRay_subset_closedBall`, `openRay_nondegenerate`, `openRim_nondegenerate`,
  `openArcs_subset_closedBall`, `openArcs_finite`, `openArcs_nondegenerate` — [kernel] — the surgery's arc obligations
- `HadwigerNelson.Plane.ArcMap.Near.open_agreesOff`, `open_ringArcsWithin`, `open_condition5` — [kernel] — three of the move's clauses
- `HadwigerNelson.Plane.ArcMap.Near.open_coloursAt_self` — [kernel] — `v` gains no colour

FS131-IO2 (Stages 4–10; build and axioms print in § 10.2):

- `HadwigerNelson.Plane.ArcMap.Near.open_hlc` — [kernel] — OPEN's colouring is locally constant off the trimmed and new arcs
- `HadwigerNelson.Plane.ArcMap.Near.open_valid` — [kernel] — OPEN's map is valid
- `HadwigerNelson.Plane.ArcMap.Near.open_degree_horns` — [kernel] — `v`'s degree does not rise and it loses a horn
- `HadwigerNelson.Plane.ArcMap.Near.open_rim` — [kernel] — the rim's points carry at most three colours, none repeated
- 56 children, listed in `data/fs131/io/io2-new-decls.txt` — [kernel]; `exists_openConfig_up`, `_down` re-proved over `OpenConfig`'s two new
  fields `ray0` and `margin` (Stages 5 and 7)

FS131-IO3 (Stages 11–15; build and axioms print in § 15.2):

- `HadwigerNelson.Plane.ArcMap.Near.open_allowedCone` — [kernel] — OPEN leaves every allowed cone of `c` off `B̄(v, ρ)` unchanged (E6-OPEN
  step 10); so **`HadwigerNelson.Plane.ArcMap.exists_open` — [kernel], exactly the standard three** (E6-OPEN whole)
- 15 children, listed in `data/fs131/io/io3-new-decls.txt` — [kernel], each exactly the standard three: `closure_sectorBetween_subset`,
  `Near.closure_gapSet_subset_gapSet`, `Near.OpenConfig.exists_clearSet`, `Near.OpenConfig.v_mem_closure_region`,
  `Near.mem_open_interiorPts_of_sector_off`, `Near.open_region_of_region`, `Near.open_region_cases`, `Near.open_region_subset`,
  `Near.open_isContact_iff`, `Near.open_exists_tile`, `Near.open_tile_split`, `Near.v_mem_closure_open_tile`, `Near.open_tile_cover`,
  `Near.open_inType_iff`, `Near.open_outType_iff`
- the positive spec example `cuspFrag.HasHornCount 0 2` (an `example`, kernel-checked in the build)

Nothing in `OpenMove` is left `sorry`.

FS131-OL1 (Stages 16 on; OPEN's landing): **proves no theorem** — it brings the 105 records above through the full gate and onto `main`;
the gate's counts are in its stages and in "Drafts for the front page (FS131-OL1)".

## Stage 1 — SAVED (FS131-IO1): the readback, the as-given build, and what this job may change

### 1.1 The brief's quotations against their sources (standing rule 3)

Each quotation was compared with its source by reading the source text (the branch's files, and `main`'s
`plans/FS131-close-inventory.md` by `git show main:…` where the branch predates it):

| quotation (first words) | source | result |
|---|---|---|
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors | **matches** |
| "def HasHornCount (v : ℂ) (j : ℕ) : Prop :=" | `plans/FS131-E6-derivation.md` § 4.5 (1), l. 404 | **matches** |
| "theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}" | same, l. 416 | **matches** |
| "theorem exists_merge (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)" | `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` l. 1525 | **matches** |
| item 382, "**FS131-E6, by message (mid-job): F6 is real; …** (1) **Realized**" | inventory l. 3388 | **matches** |
| item 384, "**FS131-E6 done: F6 is real, and repaired with no backlog statement changed** (harness ≈ 540k …" | `main`'s inventory l. 3411 | **matches** (on `main` at `4f1ec821`, after this branch's cut; not on `fs131-wop`) |
| item 385, "**Rulings on E6's held items, and its slot.** (a) **`exists_arcStep`'s horn clause accepted** …" | `main`'s inventory l. 3435 | **matches** (same note) |
| item 367, "**FS131-IMM4 done: MERGE is proved** (harness ≈ 472k …" | inventory l. 3187 | **matches** |
| item 375, "**MERGE LANDED on `main`, held in the kernel: FS131-ML1 done** (harness ≈ 334k …" | inventory l. 3302 | **matches** |

No mismatch.

### 1.2 Read for this job

- `plans/STANDING-RULES.md`, `LEAN.md` in full; `RUNNING.md` § Building and § Make the gate fail, and watch it fail.
- `plans/FS131-E6-derivation.md` §§ 3–4 in full (the model, E6-NODROP, E6-CONE, **E6-OPEN** § 4.2, E6-ROUTE, the trace, the drafts § 4.5,
  the entries).
- MERGE's record, `git show origin/fs131-w4mm:plans/FS131-IMM-implementation.md` (the theorem lists, §§ 4, 5.2, Stages 7–12) for the reused
  lemmas and the construction's shape.
- The code: `ValidMap/Basic.lean` (definitions), `Surgery.lean` (`surgery`, `Near`, the surgery's clause lemmas), `MergeMove.lean`'s
  declaration list and `cone_side`, `gap_assemble`, `clear_near_end`; `Moves.exists_merge_aux` (the assembly); `Sectors.lean`'s partition
  lemmas (`isSector_iff_of_partition`, `encard_sectors_of_partition`, `IsSectorChart.isSector_cone_or_horn`, `IsSectorChart.hasDegree`);
  `Cone.lean`'s `e_eq_of_mem_coneAt_hornSet`.

### 1.3 The branch builds as given

Under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`), before any edit: **OK — "all 1766 modules
already up to date, nothing built, 0 module(s) with warnings"** (the copied `.lake/build` was current), log
`build/gate/build/20261005T101839Z-3305996.log`, terminal output `data/fs131/io/build-0.log`, exit 0.

### 1.4 What this job may and may not change

- **May**: create `Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean` (new declarations only, importing `Contact`, which imports
  `Moves` and `MergeMove`); add it to `Proofs.lean` and `ARCHITECTURE.md`; add an "FS131-IO1" block to `scripts/Axioms.lean` above the
  `=== PURCHASED ===` banner; write this record, `tools/fs131_io_*.py`, `data/fs131/io/`, `data/fs131/reports/FS131-IO1.md`. The
  statements of `HasHornCount` and `exists_open` are mine to settle within E6-OPEN's clauses.
- **May not**: change any existing declaration of `main` (`MergeMove`, `Moves`, `Contact`, `Surgery` and every other module stay as
  they are); merge another branch; run the gate; touch `main`; add an `axiom` or a `native_decide`.

## Stage 1 — SAVED (FS131-IO1)

## Stage 2 — SAVED (FS131-IO1): the statements settled; `OpenMove` created with its children `sorry`; the build green

### 2.1 `HasHornCount` — E6's sector-set encoding, kept

```lean
def HasHornCount (v : ℂ) (j : ℕ) : Prop :=
  ∀ᶠ r in 𝓝[>] (0 : ℝ), {S | F.IsSector v r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet v α κ₁ κ₂ r}.encard = j
```

E6's draft verbatim (§ 4.5 (1)), chosen over a count read off `BranchGerms`: it is chart-free, so it is a property of the map and
its value is unique (`HasHornCount.eq`), which the potential `degree + horns` of `acted_finitely` needs; a count read off a chart would
need a chart-independence theorem first. The bridge to charts is `ne_hornSet_of_interior_coneAt` (proved): a set whose cone at `v` has
an interior direction is no horn set, since a horn set's cone is one direction (`e_eq_of_mem_coneAt_hornSet`); with
`IsSectorChart.isSector_cone_or_horn` (every chart sector is a horn set or has an interior direction) a sector is a horn set exactly when
its cone has empty interior. **Spec example** (proved): the constant map of the plane has `HasHornCount 0 0` — its one sector is the
ball, no horn set (the point `−(r/2) e α` lies behind every horn's axis); it fails if the definition drifts to counting all sectors.
**Owed**: a positive spec example (the cusp fragment `cuspFrag` has `HasHornCount 0 2`: pieces 0 and 1 are `hornSet 0 0 (−1) 1 r` and
`hornSet 0 π (−1) 1 r`, pieces 2 and 3 have interior directions) — about 40 lines, not yet written.

### 2.2 `exists_open` — read back against E6-OPEN (record § 4.2) clause by clause

| E6-OPEN | `exists_open` | |
|---|---|---|
| `F` valid, `F.Covers v 1` | `hF : F.Valid`, `hv : F.Covers v 1` | same |
| `F.IsHorn v α κ₁ κ₂ c` | `hH` | same |
| `interior (F.allowedCone v c)` non-empty | `hD` | same |
| — | **`h1 : F.HasSectors v c 1`** | **added: the horn is lone** (decision below) |
| (the degree and horn count of `v`, read in the conclusion) | `hm : F.HasDegree v m`, `hj : F.HasHornCount v j` | E6's draft |
| for every `δ > 0` there is `ρ ∈ (0, δ)` | `{δ} (hδ : 0 < δ)`, `∃ ρ, 0 < ρ ∧ ρ < δ` | same |
| a valid map `F′` agreeing with `F` off `B̄(v, ρ)` | `F'.Valid ∧ F'.AgreesOff F (closedBall v ρ)` | same |
| creating no unit arc, keeping Condition 5 | `F'.RingArcsWithin F ∧ (F.Condition5 → F'.Condition5)` | same |
| carrying no new colour at `v` | `F'.coloursAt v ⊆ F.coloursAt v` | same |
| `v`'s degree not raised, its number of horns lowered by at least one | `∃ m' j', m' ≤ m ∧ j' < j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j'` | same |
| the rim's points of at most three colours with none repeated | `∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 3 ∧ ¬ F'.HasRepeatedColour x` | same |
| `allowedCone v′ c` unchanged at every `v′ ∉ B̄(v, ρ)` | `∀ v' ∉ closedBall v ρ, F'.allowedCone v' c = F.allowedCone v' c` | same |

**The one narrowing, `h1 : F.HasSectors v c 1`** (the brief leaves the statements' exact form within E6-OPEN's clauses to me; held for
the coordinator). E6-OPEN's entry says "not claimed: that the horn's colour has one sector (the statement does not need it)", but its
proof's step 5 relies on `exists_clean` to drop the arcs that would separate `c` from `c` when the partial sector `X` or a swallowed horn
has colour `c`; route (a), which the brief names, builds the map with no cleaning step, and without `h1` it needs a second construction
(MERGE's, with the first `c`-sector on that side as its far end) beside OPEN's. **The use site needs only the lone case**: E6-ROUTE's
OPEN branch is "a lone horn with a non-degenerate allowed cone" — with no MERGE available, a colour of two or more sectors has an
empty-interior cone, so the horn's colour has one sector there. E6's title says the same ("the one-sector wedge-opening"). The general
form is the lone form plus the MERGE case and is not attempted here.

### 2.3 The construction and the children (route (a))

In `X : F.Near v`, along the orbit from `s` (`BranchGerms.idx s m`): for `up` (`σ = +1`) the horn is `idx s 0`, the swallowed horns
`idx s m` (`0 < m < b`), the partial sector `X = idx s b`; for `¬ up` (`σ = −1`) the partial sector is `idx s 0` and the horn
`idx s b`. In both cases the germs inside the merged piece are MERGE's gap germs `idx s m`, `0 < m ≤ b`, so the map is MERGE's for the
gap `s, 0, b` with the wedge added: `openArcs = mergeArcs v col s 0 b ρ ∪ {openRay, openRim}` (the ray out to `ρ/2` at `ψ`; the rim arc
at `ρ/2` across the wedge) and `openCol = c` on `openWedge` (the partial sector's part between its gap germ and the ray, out to `ρ/2`),
`mergeCol` elsewhere. `F' = F.surgery v ρ openArcs openCol …`. Children, all in `OpenMove`, each `sorry` at this stage:

- `Near.OpenConfig` (a structure: `1 ≤ b < n`, the horn a cusp of colour `c` and the only `c`-sector, the ray strictly inside the
  partial sector below `ρc`, every point between the horn's inner germ and the ray clear for `c` below `ρc`) and
  `Near.exists_openConfig` (E6-OPEN's steps 1–4: N3-CONF, `cone_side`, the first sector of positive angle, `clear_near_end`).
- The surgery's obligations: `openArcs_finite` (proved), `openArcs_nondegenerate`, `open_hlc`.
- The clauses: `open_agreesOff`, `open_ringArcsWithin`, `open_condition5`, `open_valid`, `open_coloursAt_self`, `open_degree_horns`,
  `open_rim`, `open_allowedCone`.
- **The assembly `ArcMap.exists_open` is proved over them** (no `sorry` in its body): `X` from `exists_near`, the configuration,
  `ρ := min (min (ρ'/2) ρc) (δ/2)` with `X.Small ρ'`.

### 2.4 The build, the checks

Under the slot: **OK** — 451 of 451 batches, 2 modules rebuilt (`OpenMove` 2.3 s, `Proofs`), 8 min 17 s, "Build completed successfully";
warnings only `declaration uses 'sorry'`, all 11 in `OpenMove` (`exists_openConfig`, `openArcs_nondegenerate`, `open_hlc`, and the eight
clauses). Log `build/gate/build/20261005T103947Z-3423705.log`; terminal output `data/fs131/io/build-stage2.log`.
`tools/check_architecture.py`: PASS (exit 0) with the new row. `scripts/Axioms.lean`: an "FS131-IO1" block above the PURCHASED banner
with the 16 new theorems. No existing declaration changed, no `axiom`, no `native_decide`.

## Stage 2 — SAVED (FS131-IO1)

## Stage 3 — SAVED (FS131-IO1): the configuration proved (E6-OPEN's steps 1–4); the arcs; four clauses; five leaves left

### 3.1 What was proved

- **`exists_openConfig`** (record § 2.3) in full, over two side lemmas. The side: `e (β p)` is in `D_c(v)` (`e_mem_allowedCone_of_col`,
  N3-CONF), and `cone_side` gives the interior case (taken as `σ = +1`) or a side `σ = ±1`. On `σ = +1` (`exists_openConfig_up`): `b` is
  the least `m ≥ 1` with `lift p m < lift p (m + 1)` (it exists below `n`, since the lifts gain `2π` in a turn and the horn gains none);
  the sectors between are cusps, so `lift p b = lift p 1`; `clear_near_end` at the horn's upper germ (`base_before`) gives `ε, ρ₁`; the ray
  is `ψ = lift p b + ψ₁` with `ψ₁ = min ε gap / 2`, and `ρc` is small enough that every germ's direction is within `ψ₁` of its tangent
  (`exists_small_arcsin`). On `σ = −1` (`exists_openConfig_down`): the least `b ≥ 1` with the sector `idx p (n − b)` of positive angle,
  the orbit re-based at `s = idx p (n − b)` (`idx_idx`, `lift_idx`, `liftDir_idx`: a re-based lift differs by a constant multiple of `2π`),
  so `idx s b = p`; `clear_near_end` at the horn's lower germ (`base_after`) with `σ = −1`; `ψ = lift s 1 − ψ₁`. E6-OPEN's step 3 ("the
  wedge is clear — a kernel lemma already") holds as derived: `clear_near_end` gave the whole clear region on both sides, with no new
  geometry.
- **The arcs**: `openArcs_nondegenerate` (MERGE's arcs, the ray, and the rim arc across the wedge — its ends `liftDir s b (ρ/2) < ψ` and
  within one turn by `liftDir_add_n`), `openArcs_finite`, `openArcs_subset_closedBall`.
- **Clauses**: `open_agreesOff` (the wedge lies in `B(v, ρ/2)`, so off `B̄(v, ρ)` the colouring is `mergeCol`'s, which is `F`'s),
  `open_ringArcsWithin` (MERGE's unit arcs are germ pieces; the ray is a segment; the rim arc has radius `ρ/2 < 1`), `open_condition5`,
  `open_coloursAt_self` (every colour of the new map in the punctured disc is `c` or a chart sector's; `v` is on the ray, so not interior).
- **Re-priced** after these parts: 25 theorems in about 420 lines, every one compiled within two attempts.

### 3.2 The build, the axioms, the checks

Under the slot: **OK** — 451 of 451 batches, 2 modules rebuilt (`OpenMove`, `Proofs`), 8 min 20 s; warnings only `declaration uses 'sorry'`,
the five in `OpenMove` (l. 568 `open_hlc`, 636 `open_valid`, 672 `open_degree_horns`, 682 `open_rim`, 693 `open_allowedCone`). Log
`build/gate/build/20261005T110040Z-3551665.log`; terminal output `data/fs131/io/build-stage3.log`. **Axioms** against that build's oleans
(`scripts/slot.py --mem 16 --cpus 4 -- lake env lean data/fs131/io/AxiomsIO.lean`, the 30 records of `scripts/Axioms.lean`'s FS131-IO1 block;
`data/fs131/io/axioms-stage3.txt`, parsed with wrapped lines rejoined): **30 records — 22 on exactly the standard three, 2 on fewer
(`idx_idx` on `[propext]`, `turns_idx` on `[propext, Quot.sound]`), 6 with `sorryAx` (the five leaves and `exists_open`, the control: the
print sees the `sorry` beneath the assembly), 0 foreign.** `tools/check_architecture.py`: PASS. No existing declaration changed, no `axiom`,
no `native_decide`.

### 3.3 What is left, and the plan (for whoever continues; no statement of `exists_open` changes)

Five leaves, each stated in `OpenMove` for `F.surgery v ρ (X.G.openArcs …) (X.G.openCol …) hv hρ hA hAf hlc` with the surgery's arguments
implicit, and each taking `cfg : X.OpenConfig c up s b ψ ρc`, `X.Small ρ`, `ρ ≤ ρc` (and `X.Small ρ'`, `ρ < ρ'` where MERGE's analogue does).
In every one the map is MERGE's for the gap `s, 0, b` outside the closed wedge `cl W` (`W = openWedge`, inside `B(v, ρ/2)`), so each proof
is MERGE's (`MergeMove`, the lemma named) with the wedge added; the facts about `W` needed throughout are: `W` is open; its points are
sector points of the partial sector `idx s (rayPos up b)` at radius `< ρ/2` with direction on the horn's side of `ψ`; `W ∪ chain` is
`sectorBetween` from the horn's outer germ to the ray (`(lift s 0, κ (idx s 0))` to `(ψ, 0)` for `up`, `(ψ, 0)` to
`(lift s (b+1), κ (idx s (b+1)))` otherwise), with `mem_sector_idx`. MERGE's hypotheses `hca`, `hcb` (both ends `c`) fail here — one end is
the partial sector — so MERGE's surgery lemmas cannot be instantiated; their proofs are the template.

1. **`open_hlc`** (template `merge_hlc`, ~130 lines): add the cases a point of `W` (open, constant `c`); a point of the gap germ
   `idx s (rayPos up b)` or `idx s 1`/`idx s b` inside `ρ/2` bordering `W` (`exists_ball_subset_of_branchPt`: its ball meets the gap side,
   `c` by `mergeCol`, and the partial sector's side within `W`, `c`); a point of the partial sector off `cl W` (`F`'s colour). The ray and the
   rim arc are arcs. Needs a small lemma: near a branch point of the partial sector's gap germ at radius `t < ρ/2`, the partial sector's
   points are in `W` (their direction is below `liftDir … t + η < ψ`).
2. **`open_valid`** (template `merge_valid`): `Valid.of_agreesOff` on `B̄(v, ρ)`; a recoloured point is a gap point or a wedge point,
   both with direction in the configuration's clear range (`cfg.clear`); the rest as MERGE.
3. **`open_degree_horns`** (template `merge_hasSectors`, the partition at `r < ρ/2` by `encard_sectorsOf_of_partition`; here
   `isSector_iff_of_partition` with pieces indexed by `Fin X.n`: the merged piece `chain ∪ W` at the horn's index, the rest of the partial
   sector at its index, `∅` at the swallowed sectors', `sector r i` elsewhere). Then `m' = n − (b − 1) ≤ n` (`IsSectorChart.hasDegree`,
   `HasDegree.eq`) and the horn sets: unchanged chart sectors keep their status; the merged piece and the rest of the partial sector have an
   interior direction (`ne_hornSet_of_interior_coneAt`; their cones contain an interval at `ψ`); the horn was a horn set
   (`sectorBetween_eq_hornSet` with `cfg.cusp`), so `j' ≤ j − 1`.
4. **`open_rim`** (template `merge_not_hasRepeatedColour_rim`, `merge_ncard_coloursAt_rim`): near a rim point the new map equals MERGE's
   (the wedge, ray and rim arc lie in `B̄(v, ρ/2)`); the proof of each MERGE child it cites that is surgery-specific
   (`mem_merge_interiorPts_of_mem`, `branchPt_mem_merge_interiorPts_iff`) is re-run for `openArcs` (they read only arcs outside
   `B̄(v, ρ/2)`, where `openArcs` is `mergeArcs`); `sides_preconnected` is reused as is.
5. **`open_allowedCone`** (template `merge_allowedCone` and its 19 children): the chain becomes `chain ∪ W ∪` the horn, open and clear for
   `c` (`cfg.clear`), so `dist_ne_one_of_isOpen_isClear` keeps it off `ω(v′)`; the tile facts as MERGE's.

**Owed besides**: the positive spec example for `HasHornCount` (§ 2.1); an inhabitant note for `exists_open` (LEAN.md § The gate asks
for a model of the hypotheses together; `cuspFrag` is not one — its colour `1` has two horns at `0` — and FS131-E6's model, the
instance, is not yet in Lean; the same gap item 375 names for `exists_merge`).

## Stage 3 — SAVED (FS131-IO1)

## Stage 4 — SAVED (FS131-IO2): the readback and the as-given build

*FS131-IO2 (de Bruijn, the implementer, on Opus) continues this record from here, on `fs131-wop` at `7b24117b`. Brief:
`data/fs131/briefs/FS131-IO2-open.md` (on `main`). Report: `data/fs131/reports/FS131-IO2.md`.*

### 4.1 The brief's quotations against their sources (standing rule 3)

| quotation (first words) | source | result |
|---|---|---|
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors | **matches** |
| "theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}" | `OpenMove.lean` l. 713 at `7b24117b` | **matches** |
| "1. **`open_hlc`** (template `merge_hlc`, ~130 lines): add the cases a point of `W` (open, constant `c`); a point of the gap germ" | this record § 3.3 | **matches** |
| "2. **`open_valid`** (template `merge_valid`): `Valid.of_agreesOff` on `B̄(v, ρ)`; a recoloured point is a gap point or a wedge point," | § 3.3 | **matches** |
| "3. **`open_degree_horns`** (template `merge_hasSectors`, the partition at `r < ρ/2` by `encard_sectorsOf_of_partition`; here" | § 3.3 | **matches** |
| "4. **`open_rim`** (template `merge_not_hasRepeatedColour_rim`, `merge_ncard_coloursAt_rim`): near a rim point the new map equals MERGE's" | § 3.3 | **matches** |
| "5. **`open_allowedCone`** (template `merge_allowedCone` and its 19 children): the chain becomes `chain ∪ W ∪` the horn, open and clear for" | § 3.3 | **matches** |
| item 391, "**FS131-IO1 handed back** (Stage 3 SAVED, harness ≈ 408k by the task notice; …" | `main`'s `plans/FS131-close-inventory.md` l. 3507 | **matches** |
| item 392, "**Rulings on IO1's held items, and its slot.** (a) **The lone form `h1` is kept**: after MERGE is ruled out at `v`, a horn whose colour's cone is" | `main`'s inventory l. 3524 | **matches** |
| item 384, "**FS131-E6 done: F6 is real, and repaired with no backlog statement changed** (harness ≈ 540k …" | `main`'s inventory l. 3411 | **matches** |
| item 385, "**Rulings on E6's held items, and its slot.** (a) **`exists_arcStep`'s horn clause accepted** (…" | `main`'s inventory l. 3435 | **matches** |
| item 367, "**FS131-IMM4 done: MERGE is proved** (harness ≈ 472k …" | `main`'s inventory l. 3187 | **matches** |

No mismatch.

### 4.2 Read for this job

`plans/STANDING-RULES.md`, `LEAN.md` in full; `RUNNING.md` § Building and § Make the gate fail; this record's Stages 1–3 in full;
`plans/FS131-E6-derivation.md` § 4.2 (E6-OPEN); `OpenMove.lean` whole.

### 4.3 The branch builds as given

Under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`), before any edit: **OK — "all 1767 modules
already up to date, nothing built, 1 module(s) with warnings"** (the five `sorry` leaves in `OpenMove`, l. 568, 636, 672, 682, 693), exit 0;
log `build/gate/build/20261005T111305Z-3633604.log`, terminal output `data/fs131/io/build-io2-0.log`.

## Stage 4 — SAVED (FS131-IO2)

## Stage 5 — SAVED (FS131-IO2): `open_allowedCone` false as stated; the margin field added (ruling: inventory item 393)

### 5.1 The defect

`open_allowedCone` (for every `cfg : X.OpenConfig c up s b ψ ρc`) is false as IO1 stated it, because `OpenConfig.clear` stops exactly at the
ray: it gives clearness for `φ ∈ [lower, ψ]` (`up`) or `[ψ, upper]` (`¬ up`), closed at `ψ`, never on a neighbourhood of a ray point. The
closure of the recoloured wedge holds the ray points `w = v + t e(ψ)`, `0 < t ≤ ρ/2`, so they are new contacts at any `v′` with `dist w v′ = 1`
and `v′ ∈ closure (F.region c)`; MERGE's route needs an open clear set about every closure point of the recoloured set
(`dist_ne_one_of_isOpen_isClear`).

**Counterexample** (sent to the coordinator mid-job): `k = 3`, `v = 0`, `up`, `s = 0`, `b = 1`, `ψ = 0`. `dom = ball(0, r₁) ∪` a small
neighbourhood of the rectangle `R = {0 < Re y < ρc, 1 < Im y < 1 + δ}` (`r₁, δ, ρc` small). In `ball(0, r₁)`: two germs, circular arcs tangent at
`0` along `α = −π/4` (a cusp horn of colour `c`, the only `c`-sector), colour `c₂` elsewhere in the ball; `R` has colour `c`, the rest of
the second piece `c₃`. Valid: horn points have `Im < 0`, `R`'s `Im > 1`; every other class has diameter `< 1`. `cfg`: `hb1`, `hbn`, `cusp`,
`col_horn`, `lone` immediate; `ray` (`L₁(t) ≈ −π/4 < 0 < L₂(t) ≈ 7π/4`); `clear` (for `Im z ≤ 0` and `y ∈ R`, `|z − y| ≥ Im y − Im z > 1`).
For any small `ρ`, `t₀ ∈ (0, ρ/2]` and `v′ = t₀ + i` (`∉ B̄(0, ρ)`, `∈ closure R`): `w = t₀ ∈ closure W`, `dist w v′ = 1`, so `w` is a new contact,
out-type (the merged tile lies in `{Im < 0}`, missing `B̄(v′, 1) ⊆ {Im ≥ 0}`); `F` has no `c`-contact at `v′` (horn closure points other
than `0` have `Im < 0`; `diam R < 1`), so `F.allowedCone v′ c = univ`, while the new cone is `{d : dot d (w − v′) ≤ 0} = {Im d ≥ 0}`, missing
`−i`. `exists_open` itself is true: `exists_openConfig` puts `ψ = lift ± ψ₁` with `ψ₁ ≤ ε/2`, strictly inside `clear_near_end`'s range
`|φ − lift| ≤ ε`.

### 5.2 The repair (accepted by the coordinator, item 393)

`OpenConfig` (IO1's, unchanged):

```lean
  clear : ∀ t ∈ Ioo 0 ρc, ∀ φ, (if up then X.G.liftDir s 1 t else ψ) ≤ φ →
    φ ≤ (if up then ψ else X.G.liftDir s b t) → F.IsClear c (v + (t : ℂ) * e φ)
```

and one field added after it:

```lean
  margin : ∃ η > 0, ∀ t ∈ Ioo 0 ρc, ∀ φ, (if up then ψ else ψ - η) ≤ φ → φ ≤ (if up then ψ + η else ψ) →
    F.IsClear c (v + (t : ℂ) * e φ)
```

proved in `exists_openConfig_up` and `exists_openConfig_down` with `η = ψ₁` (`ψ ± ψ₁ = lift ± 2ψ₁` stays within `ε`; the `σ`-side condition
holds as for `clear`). The diff is `data/fs131/io/margin.diff` (65 lines: the field, and one bullet in each side lemma). `exists_open`'s and
`HasHornCount`'s statements are unchanged; no other declaration changed. Iteration (`lake env lean`, never evidence): the file elaborates with
the five leaves still `sorry`.

## Stage 5 — SAVED (FS131-IO2)

## Stage 6 — SAVED (FS131-IO2): `open_hlc` proved

**The route** (IO1's § 3.3 item 1 reorganized around one open set). New definitions in `BranchGerms` (with spec examples): `openPiece`
(the merged `c`-sector out to `r`: from germ `idx s 0` to the ray for `up`, from the ray to germ `idx s (b + 1)` otherwise) and `openRest`
(the rest of the partial sector, beyond the ray), each a `sectorBetween` with the ray as one side, and their lifted-direction membership
lemmas (`mem_openWedge`, `mem_openPiece`, `mem_openRest`). Children, all in `OpenMove`:

- `isOpen_sectorBetween` (as `BranchGerms.isOpen_sector`, for any two germs) and so `isOpen_openWedge`, `isOpen_openPiece`, `isOpen_openRest`;
- `polar_eq_of_abs_lt`: two polar forms of one point at angles less than a turn apart are one;
- `mem_openRay`, `mem_openRim`; `OpenConfig.two_le`, `OpenConfig.liftDir_succ_lt` (one step gains less than a turn);
- `openWedge_subset_sector` (the wedge is in the partial sector), `openWedge_subset_openPiece`, `mem_openPiece_of_Icc` (gap sectors and gap
  germs inside `ρ/2` are in the piece), `disjoint_openWedge_openRest`, `sector_rayPos_cases` (a partial-sector point inside `ρ/2` is in the
  wedge, on the ray, on the rim arc, or in the rest);
- `openCol_of_mem_openPiece`: OPEN's colouring is `c` on the whole piece (wedge, gap germs, horn and gap sectors, by
  `exists_step_of_strictMono`).

`open_hlc`: in the piece the colouring is `c` on an open set; inside `B̄(v, ρ/2)` off the piece a point off the arcs is in a chart sector off
the gap (a gap sector or gap germ there is in the piece or on a rim arc), whose neighbourhood misses the wedge (another sector, or the rest of
the partial sector); beyond `ρ/2` OPEN's colouring is MERGE's and MERGE's argument runs unchanged (it uses `hca`, `hcb` only at the gap germs
inside `ρ/2`, which are in the piece, and at `ρ/2` when `b = 1`, where the point is on `openRim`). Iteration (`lake env lean`): clean, four
leaves left (`open_valid`, `open_degree_horns`, `open_rim`, `open_allowedCone`).

## Stage 6 — SAVED (FS131-IO2)

## Stage 7 — SAVED (FS131-IO2): `open_valid` proved; the real build; `open_degree_horns` false as stated, the `ray0` field added (item 397)

### 7.1 `open_valid` and the build

`open_valid` (template `merge_valid`): `Valid.of_agreesOff` on `B̄(v, ρ)`; a recoloured point is a wedge point (`OpenConfig.isClear_of_mem_openWedge`,
from `cfg.clear`) or a gap point (`OpenConfig.isClear_of_Icc`: the gap's directions `[L₁, L_b]` lie in the clear range); the rest as MERGE's,
with `mem_open_interiorPts_iff`, `mem_interiorPts_of_open_rim`, `v_mem_openArcs`, `openCol_of_mem`, `openCol_of_not_mem`. **Real build** at
`fs131-wop` after `open_valid` (commit `1a234d10`'s tree, before `ray0`): **OK** — 451 of 451 batches, 2 modules rebuilt, 8 min 21 s; warnings
only `declaration uses 'sorry'`, the three leaves left (`open_degree_horns`, `open_rim`, `open_allowedCone`); log
`build/gate/build/20261005T114229Z-3949911.log`, terminal output `data/fs131/io/build-io2-1.log`.

### 7.2 The second defect: `open_degree_horns`

`OpenConfig.ray` puts the ray strictly inside the partial sector only for `t > 0`; at `t = 0` it gives `lift s rp ≤ ψ ≤ lift s (rp + 1)`. If `ψ`
equals the horn's direction (`up`: `ψ = lift s 0 = … = lift s b`, possible when germ `b` curves below the ray), the merged piece
`sectorBetween v (lift s 0) κ₀ ψ 0 r` is itself a horn set (`sectorBetween_eq_hornSet`), so the horn count does not drop.

**Counterexample** (sent mid-job): `k = 2`, `v = 0`, `dom = ball(0, r₁)`, `r₁ < 1/2`; two germs tangent at `0` along `α`, curving clockwise
(`κ₀ = −2`, `κ₁ = −1`); sector 0 (the cusp between them) colour `c`, sector 1 (the rest of the disc) colour `c₂`. Valid (both classes have
diameter `< 1`). `cfg`: `up`, `s = 0`, `b = 1`, `ψ = α`; `ray` (`L₁(t) = α + arcsin(−t/2) < α < L₂(t) ≈ α + 2π`), `clear`, `margin` trivial. OPEN's
merged piece is `sectorBetween v α (−2) α 0 r = hornSet v α (−2) 0 r`, a horn set and a sector; the rest has an interior cone; every other
sector is unchanged. Horn count and degree unchanged, so no `j′ < j`. `exists_open` is true (`ψ = lift ± ψ₁` with `0 < ψ₁ ≤ gap/2`).

### 7.3 The repair (accepted, item 397)

One field added to `OpenConfig` after `ray`:

```lean
  ray0 : X.G.lift s (BranchGerms.rayPos up b) < ψ ∧ ψ < X.G.lift s (BranchGerms.rayPos up b + 1)
```

proved in `exists_openConfig_up` (`ψ = lift p b + ψ₁`, `0 < ψ₁ ≤ gap/2`) and `exists_openConfig_down` (`ψ = lift s 1 − ψ₁`, `ψ₁ ≤ (lift s 1 −
lift s 0)/2`); the diff is `data/fs131/io/ray0.diff` (50 lines). With `margin` (Stage 5), `OpenConfig` now reads, after IO1's eight fields
(`hb1`, `hbn`, `hρc`, `hρcs`, `cusp`, `col_horn`, `lone`, `ray`), `ray0`, then IO1's `clear`, then `margin`. `exists_open`'s and `HasHornCount`'s
statements unchanged; iteration clean.

## Stage 7 — SAVED (FS131-IO2)

## Stage 8 — SAVED (FS131-IO2): `open_rim` proved

Template `merge_not_hasRepeatedColour_rim`, `merge_coloursAt_rim`, `merge_ncard_coloursAt_rim`; the surgery-specific children re-run for
`openArcs` (the ray and the rim arc across the wedge lie in `B̄(v, ρ/2)`, so near the rim they never matter): `mem_open_interiorPts_of_mem` (a
point of `F`'s interior off `B̄(v, ρ/2)` is interior to OPEN's map), `branchPt_mem_open_interiorPts_iff` (a germ point in the annulus is interior
exactly when inside `ρ` on a phantom germ), `openCol_of_mem_sector_out`, `open_coloursAt_rim` (the rim's colours are `F`'s), and
`open_not_hasRepeatedColour_rim`, MERGE's proof with those substituted (generated from MERGE's text by renaming, then checked);
`sides_preconnected` reused as is. `open_rim` reads the two (at most two colours at a rim point, `ncard_coloursAt_le_two`; no repeated colour).
Iteration clean; two leaves left (`open_degree_horns`, `open_allowedCone`).

## Stage 8 — SAVED (FS131-IO2)

## Stage 9 — SAVED (FS131-IO2): `open_degree_horns` proved

**OPEN's sectors at `v`** (`openSectors X up s b ψ r i`, a new definition with a spec example): the merged piece at the horn's index, the rest
of the partial sector at its index, `∅` at the swallowed sectors' (`gapSec s 0 b`), the chart's sector elsewhere (`openSectors_cases`).
Children: `mem_sectorBetween_of_lt`, `isPreconnected_sectorBetween` (as `isPreconnected_sector`), `Ioo_subset_coneAt_sectorBetween` (every
direction strictly between two germs' tangents is a direction of the sector between them), `eq_of_mem_openRay`; `OpenConfig.window` (the ray
lies in the window `(L₀, L_{b+1})`, at most a turn wide), `mem_openPiece_iff`, `mem_openRest_iff`, `exists_other`, `exists_germ_off`,
`not_mem_openArcs` (a point at a direction in the window, off the ray, inside `ρ/2`, is on no new arc), `sector_eq_hornSet_iff` (a chart sector
is a horn set exactly when its germs share a direction), `hasHornCount_chart` (the horn count at a chart's point is its number of cusps),
`isSector_iff_of_partition'` and `injOn_of_disjoint` (the partition lemma with empty pieces allowed), `idx_facts`, `cone_piece_rest` (with
`ray0`, the piece and the rest approach `v` along open intervals), `facts_of_cone` (so `v` is in their closures, they are non-empty, and no
horn sets), `isPreconnected_piece_rest`, `disjoint_piece_rest`, `disjoint_piece_other`, `horn_subset_piece`, `mem_piece_of_Icc`,
`mem_openPiece_of_lt`, `mem_openRest_of_lt`, `rest_subset_sector`, `disjoint_openSectors`, `openSectors_facts`; in the surgery section
`mem_open_interiorPts_of_sector` and `open_partition` (inside `ρ/2` OPEN's interior points are its sectors).

`open_degree_horns`: `m = n` (`IsSectorChart.hasDegree`, `HasDegree.eq`), `j` = the number of cusps (`hasHornCount_chart`, `HasHornCount.eq`);
`m′` = the number of indices off the swallowed sectors (`≤ n`), `j′` = the number of cusps off the gap, the horn and the partial sector, `< j`
since the horn is a cusp (`cfg.cusp`, `lift_succ`). The binders `h'`, `hρρ'` are unused here and renamed `_h'`, `_hρρ'` (names only; the
statement is unchanged, as IO1 did for `open_coloursAt_self`'s `_hρc`; likewise `open_rim`'s `_hρc`). Iteration clean; one leaf left
(`open_allowedCone`).

## Stage 9 — SAVED (FS131-IO2)

## Stage 10 — SAVED (FS131-IO2): the handover — four leaves proved, `open_allowedCone` left

*Handed back here, at a saved stage, on the brief's budget line (about 500k by the harness's count); `open_allowedCone` and the positive
`HasHornCount` example are left, with their routes in § 10.3.*

### 10.1 Theorems this phase proved (FS131-IO2)

Kernel-checked in this stage's build (§ 10.2), axioms printed against that build's oleans; each reads exactly the standard three or fewer
unless noted. All in `Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean`.

- `HadwigerNelson.Plane.ArcMap.Near.open_hlc` — [kernel] — OPEN's colouring is locally constant off the trimmed and new arcs (E6-OPEN step 5)
- `HadwigerNelson.Plane.ArcMap.Near.open_valid` — [kernel] — OPEN's map is valid (E6-OPEN step 6)
- `HadwigerNelson.Plane.ArcMap.Near.open_degree_horns` — [kernel] — `v`'s degree does not rise and it loses a horn (E6-OPEN step 8)
- `HadwigerNelson.Plane.ArcMap.Near.open_rim` — [kernel] — the rim's points carry at most three colours, none repeated (E6-OPEN step 9)
- the 56 children listed in `data/fs131/io/io2-new-decls.txt` (generated by `tools/fs131_io_decls.py` against `7b24117b`) — [kernel], among them
  `isOpen_sectorBetween`, `isPreconnected_sectorBetween`, `Ioo_subset_coneAt_sectorBetween`, `polar_eq_of_abs_lt`,
  `ArcMap.isSector_iff_of_partition'`, `Near.hasHornCount_chart`, `Near.sector_eq_hornSet_iff`, `Near.open_partition`,
  `Near.open_not_hasRepeatedColour_rim`, `Near.open_coloursAt_rim`, `Near.openCol_of_mem_openPiece`
- `exists_openConfig_up`, `exists_openConfig_down`, `exists_openConfig` (IO1's) re-proved over the two new `OpenConfig` fields

Not proved: `open_allowedCone` (`sorry`); so `ArcMap.exists_open` still reads `sorryAx` (the print's control).

### 10.2 The build, the axioms, the checks

Under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`), at the tree committed with this stage:
**OK** — 451 of 451 batches, 2 modules rebuilt (`OpenMove`, `Proofs`), 8 min 41 s, exit 0; the only warning is `declaration uses 'sorry'` at
`OpenMove.lean:2175` (`open_allowedCone`). Log `build/gate/build/20261005T115945Z-4035875.log`; terminal output `data/fs131/io/build-io2-2.log`.
**Axioms** against that build's oleans (`data/fs131/io/iter.sh data/fs131/io/AxiomsIO.lean`, IO1's 30 records and this job's 60;
`data/fs131/io/axioms-io2.txt`), classified by `tools/fs131_io_axioms.py --expect 90 --sorry open_allowedCone,exists_open`
(`data/fs131/io/axioms-io2-classified.txt`, exit 0): **90 records — 86 on exactly the standard three, 2 on fewer (`idx_idx` on `[propext]`,
`turns_idx` on `[propext, Quot.sound]`), 2 with `sorryAx` (`open_allowedCone` and `exists_open`, the control: the print sees the `sorry`
beneath the assembly), 0 foreign.** The classifier's planted faults (a foreign axiom, an unexpected `sorryAx`, an empty print, and a name with a
prime) each fire, and a clean partner passes; the prime case was found live — the first version's name pattern dropped
`isSector_iff_of_partition'`, and the count check went red (89 against 90) before it was trusted. `tools/fs131_io_decls.py` (lists a file's
theorems, optionally those absent from a baseline) exits 2 on a file with none (control watched). `tools/check_architecture.py`: PASS. The
`scripts/Axioms.lean` block headed "FS131-IO1" is extended by a `-- FS131-IO2` list of the 60 new theorems. No existing declaration of
`main` changed, no `axiom`, no `native_decide`; `OpenConfig` gained `ray0` and `margin` (Stages 5, 7), and `exists_open`'s and
`HasHornCount`'s statements are unchanged.

### 10.3 What is left, and the plan (for whoever continues; no statement changes, `OpenConfig` as it stands)

1. **`open_allowedCone`** (template `merge_allowedCone` and its children, MergeMove l. 2747–3480). The route, worked out (not written):
   - `open_region_of_region`: `F`'s class of `c` lies in the new one. Inside `B(v, ρ)` a `c`-point of `F` is in a chart sector of colour `c`,
     i.e. the horn sector (`cfg.lone`). A horn-sector point is interior to OPEN's map: not on a germ arc (it is in `F`'s interior), not on
     `rimArc` (`gapSec_of_mem_rimArc` would put it in a swallowed sector, whose colour is not `c`), not on the ray (ray points with `t > 0` lie
     in the partial sector, `cfg.ray`; `idx_facts`), not on `openRim` (its points are a branch point of the wedge's germ or partial-sector
     points). Its new colour is `mergeCol = col (horn) = c` (the horn is no swallowed sector, and it misses the wedge, which lies in the partial
     sector, `openWedge_subset_sector`). Outside the ball, `open_agreesOff`.
   - `open_region_cases`: a new `c`-point is in `F`'s class, in the wedge, in `gapSet s 0 b (ρ/2)`, or a cut branch point of a germ with `c`
     after it (MERGE's proof with `openCol_of_mem`/`openCol_of_not_mem` in front).
   - **The open clear set** `U`: `up` — `sectorBetween v (lift s 0) κ₀ (ψ + η) 0 ρ`; `¬ up` — `sectorBetween v (ψ − η) 0 (lift s (b+1)) κ_{b+1} ρ`,
     with `η` from `cfg.margin`. Open (`isOpen_sectorBetween`). Clear for `c`: a direction below `L₁` (resp. above `L_b`) is a horn-sector point
     (`isClear_col`), one in `[L₁, ψ]` (resp. `[ψ, L_b]`) is `cfg.clear`, one in `[ψ, ψ + η]` (resp. `[ψ − η, ψ]`) is `cfg.margin`.
   - **Closures**: `closure (gapSet s 0 b (ρ/2)) ⊆ {v} ∪ gapSet s 0 b ρ` (MERGE's `closure_gapSet_subset` proof with the chain replaced by the gap
     out to `ρ`: a gap sector's two germs are gap germs) and `gapSet s 0 b ρ ⊆ U` (directions in `[L₁, L_b]`); `closure W ⊆ {v} ∪ U` (a generic
     `closure_sectorBetween_subset`: the closure lies in the image of the compact `{(t, φ) : t ∈ [0, r], f₁ t ≤ φ ≤ f₂ t}`; its points with `t > 0`
     have directions in `[L_b, ψ]` (resp. `[ψ, L₁]`), inside `U`'s range).
   - Then MERGE's chain of lemmas with these substitutions: `closure_open_region`, `open_isContact_iff` (the only new closure points are `v`,
     in the closure of the horn sector, and points of `U`, never at distance `1` from a closure point of `F`'s class:
     `dist_ne_one_of_isOpen_isClear`), `open_exists_tile`, `open_tile_split` (from `open_valid`), `v_mem_closure_open_tile` (a new `c`-point
     inside `ρ/2` is in the merged piece — every other case is another colour, in the piece, or on an arc — and the piece, preconnected and in
     the new class, lies in the tile and holds the horn sector), `open_tile_cover`, `open_inType_iff`, `open_outType_iff`, and the assembly as
     `merge_allowedCone`'s (`hv1` is not needed).
2. **The positive `HasHornCount` spec example** (`cuspFrag` has `HasHornCount 0 2`): not written. Route (IO1's § 2.1): `cuspFrag_partition` and
   `cuspPiece_data` give the four pieces; pieces 0 and 1 are `hornSet 0 0 (−1) 1 r` and `hornSet 0 π (−1) 1 r`, pieces 2 and 3 have interior
   directions (`ne_hornSet_of_interior_coneAt`); count with `isSector_iff_of_partition'` and `injOn_of_disjoint` (both now in `OpenMove`).
3. **Owed besides** (IO1's § 3.3, unchanged): an inhabitant note for `exists_open` (no Lean model satisfies its hypotheses at once; E6's model is
   not in Lean; the same gap item 375 names for `exists_merge`).

## Stage 10 — SAVED (FS131-IO2)

## Stage 11 — SAVED (FS131-IO3): the readback and the as-given build

*FS131-IO3 (de Bruijn, the implementer, on Opus) continues this record from here, on `fs131-wop` at `276aeaff`. Brief:
`data/fs131/briefs/FS131-IO3-open.md` (on `main`). Report: `data/fs131/reports/FS131-IO3.md`.*

### 11.1 The brief's quotations against their sources (standing rule 3)

| quotation (first words) | source | result |
|---|---|---|
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors (l. 119) | **matches** |
| "theorem open_allowedCone (hF : F.Valid) (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ')" | `OpenMove.lean` l. 2175 at `276aeaff` | **matches** |
| "theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}" | `OpenMove.lean` l. 2195 | **matches** |
| "1. **`open_allowedCone`** (template `merge_allowedCone` and its children, MergeMove l. 2747–3480). The route, worked out (not written):" | this record § 10.3, l. 455 | **matches** |
| "2. **The positive `HasHornCount` spec example** (`cuspFrag` has `HasHornCount 0 2`): not written. Route (IO1's § 2.1): `cuspFrag_partition` and" | § 10.3, l. 477 | **matches** |
| "3. **Owed besides** (IO1's § 3.3, unchanged): an inhabitant note for `exists_open` (no Lean model satisfies its hypotheses at once; E6's model is" | § 10.3, l. 480 | **matches** |
| item 400, "**FS131-IO2 handed back** (Stage 10 SAVED, harness ≈ 560k by the task notice — past its line; it stopped at Stage 9 to run the handover; record" | `main`'s `plans/FS131-close-inventory.md` l. 3605 | **matches** |
| item 401, "**Ruling on IO2's slot: OPEN's last leaf, FS131-IO3, on `fs131-wop`** — `open_allowedCone` by record § 10.3 item 1, the positive `HasHornCount` example" | `main`'s inventory l. 3619 | **matches** |
| item 393, "**FS131-IO2, by message: `open_allowedCone` is false as stated; a one-field repair to `OpenConfig`.** Why: in OPEN's new map the closure of the" | `main`'s inventory l. 3530 | **matches** |
| item 397, "**FS131-IO2, by message: `open_degree_horns` is also false as stated; a second one-field repair to `OpenConfig`.** `OpenConfig.ray` puts the ray strictly" | `main`'s inventory l. 3569 | **matches** |
| item 384, "**FS131-E6 done: F6 is real, and repaired with no backlog statement changed** (harness ≈ 540k by the task notice; record `plans/FS131-E6-derivation.md`;" | `main`'s inventory l. 3411 | **matches** |
| item 367, "**FS131-IMM4 done: MERGE is proved** (harness ≈ 472k by the task notice; record `fs131-w4mm`'s `plans/FS131-IMM-implementation.md`, Stages 10–12; report" | `main`'s inventory l. 3187 | **matches** |

No mismatch.

### 11.2 Read for this job

`plans/STANDING-RULES.md`, `LEAN.md` in full; `RUNNING.md` § Building and § Make the gate fail; this record's Stages 4–10 in full;
`OpenMove.lean`'s statements and the children IO2 left (the surgery section, `open_partition`, `openSectors`); MERGE's `merge_allowedCone`
and its children (`MergeMove.lean` l. 2747–3480, identical on `fs131-wop` and `main`).

### 11.3 The branch builds as given

Under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`), before any edit: **OK — "all 1767 modules
already up to date, nothing built, 1 module(s) with warnings"** (the one `sorry`, `OpenMove.lean:2175`, `open_allowedCone`), exit 0; log
`build/gate/build/20261005T121321Z-4119716.log`, terminal output `data/fs131/io/build-io3-0.log`.

## Stage 11 — SAVED (FS131-IO3)

## Stage 12 — SAVED (FS131-IO3): `open_allowedCone` proved; `exists_open` on the standard three

**The route** (IO2's § 10.3 item 1, every child MERGE's with the wedge added; MERGE's surgery lemmas cannot be instantiated, one end of the gap
being the partial sector, so each is re-run for `openArcs`/`openCol`). New theorems, all in `OpenMove.lean`:

- `closure_sectorBetween_subset` (generic): the closure of `sectorBetween v β₁ κ₁ β₂ κ₂ r` lies in the image of the compact region
  `{(t, φ) : t ∈ [0, r], germDir β₁ κ₁ t ≤ φ ≤ germDir β₂ κ₂ t}` (bounded since `arcsin ∈ [−π/2, π/2]`).
- `Near.closure_gapSet_subset_gapSet`: the closure of the gap out to `ρ/2` lies in `{v}` and the gap out to `ρ` (MERGE's
  `closure_gapSet_subset` with the chain replaced by the gap: a gap sector's two germs are gap germs).
- `Near.OpenConfig.exists_clearSet` — **the open clear set**: with `η` from `cfg.margin`, `U = sectorBetween v (lift s 0) κ₀ (ψ + η) 0 ρ`
  (`up`) or `sectorBetween v (ψ − η) 0 (lift s (b+1)) κ_{b+1} ρ` (`¬ up`) is open, clear for `c` (a direction inside the horn's sector by
  validity, `isClear_col`; one in the clear range by `cfg.clear`; one in the margin by `cfg.margin`), inside `B(v, ρ)`, and holds the
  closures of the recoloured gap and wedge off `v` (`cfg.ray` and strict monotonicity of the lifted directions place them strictly inside
  `U`'s range). This is where IO2's `margin` field is consumed.
- `Near.OpenConfig.v_mem_closure_region`: `v` is in the closure of `F`'s class of `c` (the horn's sector).
- Surgery section: `mem_open_interiorPts_of_sector_off` (a chart-sector point off the partial sector and the gap is interior to OPEN's map,
  at any radius below `ρ`, the rim arc at `ρ/2` included), `open_region_of_region` (`F`'s class of `c` survives: inside `B(v, ρ)` it is the
  horn's sector, by `lone`), `open_region_cases`, `open_region_subset`, `open_isContact_iff`, `open_exists_tile`, `open_tile_split` (from
  `open_valid`), `v_mem_closure_open_tile` (through `open_partition`: near `v` a new `c`-point lies in OPEN's sectors, and of colour `c`
  only the merged piece, which is preconnected, interior, and holds the horn's sector), `open_tile_cover`, `open_inType_iff`,
  `open_outType_iff`.
- `open_allowedCone`: the assembly, `merge_allowedCone`'s text over the OPEN children. **No statement changed**: the diff against
  `276aeaff` removes exactly one line (`sorry`) and adds the fifteen theorems and the proof.

**The build** (under the slot, `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, source unchanged since
07:29:45, before the build's start): **OK** — 451 of 451 batches, 2 modules rebuilt (`OpenMove` 8.6 s, `Proofs`), **0 modules with
warnings**, 8 min 37 s, exit 0, "Build completed successfully (5750 jobs)"; log `build/gate/build/20261005T123016Z-33946.log`, terminal
output `data/fs131/io/build-io3-1.log`. `grep sorry OpenMove.lean`: 0.

**Axioms** against that build's oleans (`data/fs131/io/iter.sh data/fs131/io/AxiomsIO.lean`: IO1's 30 records, IO2's 60, this job's 15;
`data/fs131/io/axioms-io3.txt`), classified by `tools/fs131_io_axioms.py --expect 105` with no `--sorry` allowance
(`data/fs131/io/axioms-io3-classified.txt`, exit 0): **105 records — 103 on exactly `[propext, Classical.choice, Quot.sound]`, 2 on fewer
(`idx_idx` on `[propext]`, `turns_idx` on `[propext, Quot.sound]`), 0 `sorryAx`, 0 foreign**; `Near.open_allowedCone` and
`ArcMap.exists_open` read exactly the standard three (IO2's print read `sorryAx` on both). **Control**: the same print with `sorryAx`
planted into `exists_open`'s record makes the classifier exit 1 naming it (`SORRY-UNEXPECTED`). `scripts/Axioms.lean`'s OPEN block gains a
`-- FS131-IO3` list of the fifteen (its banner no longer says the children are `sorry`); `tools/check_architecture.py`: PASS (no new module).
The new names: `data/fs131/io/io3-new-decls.txt` (`tools/fs131_io_decls.py` against `276aeaff`).

## Stage 12 — SAVED (FS131-IO3)

## Stage 13 — SAVED (FS131-IO3): the positive `HasHornCount` spec example

`example : ArcMap.cuspFrag.HasHornCount 0 2` in `OpenMove.lean`, after the constant map's `HasHornCount 0 0`. Route (IO1's § 2.1): for
`r ∈ (0, 1/2]`, `cuspFrag_partition` and `cuspPiece_data` make the sectors at `0` exactly the four pieces (`isSector_iff_of_partition`);
piece 0 is `hornSet 0 0 (−1) 1 r` by definition; piece 1 equals `hornSet 0 π (−1) 1 r` (in the frame along `e π` the normal is `−i`, so
`tanAbove_neg_one_iff` and `tanBelow_one_iff` read the arcs of `ω(i)` and `ω(−i)` in traded places, against `mem_cuspPiece_one`); pieces 2
and 3 (`B(0, r) ∩ B(±i, 1)`) hold `t e(δ)` for every small `t` at each `δ ∈ (0, π)`, resp. `(−π, 0)`
(`‖t e(δ) ∓ i‖² = t² ∓ 2t sin δ + 1`), so their cones at `0` have interior (`BranchGerms.mem_coneAt_of_ray`) and they are no horn sets
(`ne_hornSet_of_interior_coneAt`); the horn sectors are the pair `{piece 0, piece 1}`, distinct as disjoint non-empty sets (`encard_pair`).
**Control**: the same proof claiming `HasHornCount 0 1` goes red at its last step (`rfl`: `2` is not `↑1`), watched in a scratch copy.
Evidence so far: iteration only (`lake env lean` on `OpenMove.lean`, exit 0, no warning); the real build comes with Stage 14.

## Stage 13 — SAVED (FS131-IO3)

## Stage 14 — SAVED (FS131-IO3): `exists_open`'s inhabitant note

A paragraph appended to `ArcMap.exists_open`'s docstring (the statement untouched; the diff is the docstring's last line and five added
lines): no Lean model satisfies its hypotheses at once yet; FS131-E6's model (`plans/FS131-E6-derivation.md` § 3.1–3.3: a valid plane map in
twelve colours, `v = 0`, `IsHorn 0 0 0 2 c`, `HasSectors 0 c 1`, `D_c(0)` a closed half-plane, degree `3`, one horn) satisfies all of them at
[hand] grade with exact checks and is not formalized; `cuspFrag` is no model (`hv` fails, its domain being `B(0, 1/2)`; `h1` fails, colour `1`
having two horn sectors at `0`). **A pointer not confirmed**: IO1's § 3.3 says item 375 names "the same gap" for `exists_merge`; item 375
as read on `main` records MERGE's landing and its vacuity digest ("no new carrier tracked") but no inhabitant gap, and `exists_merge`'s
docstring (`Contact.lean` l. 1513–1524) carries no inhabitant note — so the note cites E6's model only. Iteration (`lake env lean`): exit 0.

## Stage 14 — SAVED (FS131-IO3)

## Stage 15 — SAVED (FS131-IO3): the handover — OPEN proved whole

*Handed back here at Kooshi's halt ; this
job's three items were done before it, so nothing of the brief is left.*

### 15.1 Theorems this phase proved (FS131-IO3)

All in `Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean`, kernel-checked in § 15.2's build, axioms printed against its oleans:

- `HadwigerNelson.Plane.ArcMap.Near.open_allowedCone` — [kernel], `[propext, Classical.choice, Quot.sound]` — `D_c(v′)` unchanged off
  `B̄(v, ρ)` (read against E6-OPEN's last clause: "no other point's allowed cone for `c` changes", for every `v′ ∉ B̄(v, ρ)`)
- `HadwigerNelson.Plane.ArcMap.exists_open` — [kernel], `[propext, Classical.choice, Quot.sound]` — **FS131-E6-OPEN** (its statement
  unchanged since IO1, read against E6-OPEN clause by clause in § 2.2)
- the 15 children of § 12 (`data/fs131/io/io3-new-decls.txt`) — [kernel], each `[propext, Classical.choice, Quot.sound]`
- `example : ArcMap.cuspFrag.HasHornCount 0 2` — [kernel] — the positive spec example (§ 13)

### 15.2 The build, the axioms, the checks

- **Build** (under the slot, `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, at `864e41b7`'s tree):
  **OK** — 451 of 451 batches, 2 modules rebuilt (`OpenMove` 9.7 s, `Proofs`), **0 modules with warnings**, 8 min 16 s, exit 0, "Build
  completed successfully (5750 jobs)"; log `build/gate/build/20261005T124448Z-133559.log`, terminal output `data/fs131/io/build-io3-2.log`.
  `grep sorry OpenMove.lean`: 0.
- **Axioms** against that build's oleans (`data/fs131/io/iter.sh data/fs131/io/AxiomsIO.lean`, `data/fs131/io/axioms-io3-final.txt`),
  classified by `tools/fs131_io_axioms.py --expect 105` with no `sorryAx` allowed (`data/fs131/io/axioms-io3-final-classified.txt`,
  exit 0): **105 records — 103 exactly the standard three, 2 on fewer (`BranchGerms.idx_idx` `[propext]`, `BranchGerms.turns_idx`
  `[propext, Quot.sound]`), 0 `sorryAx`, 0 foreign.** Every `OpenMove` theorem is within the standard three.
- **Control**: the same print with `sorryAx` planted into `exists_open`'s record (`data/fs131/io/axioms-io3-planted.txt`) makes the
  classifier exit 1, naming it `SORRY-UNEXPECTED` (`data/fs131/io/axioms-io3-planted-classified.txt`). The spec example's control (claiming
  `HasHornCount 0 1`) went red at its last `rfl` (§ 13).
- `tools/check_architecture.py`: PASS (no new module). `scripts/Axioms.lean`: the OPEN block's banner no longer says the children are
  `sorry`, and a `-- FS131-IO3` list of the 15 new theorems follows IO2's. No `axiom`, no `native_decide`; no statement in the skeleton
  changed (`OpenConfig` as IO2 left it); no declaration of `main`, `MergeMove`, `Moves`, `Contact` touched.
- **A correction to Stage 14's text**: `exists_merge`'s docstring is `Contact.lean` l. 1520–1524, not 1513–1524.

### 15.3 What is left, and the next step

Of this brief: nothing. Of OPEN's landing, for the coordinator (not this job's to run): the full gate on a branch carrying `fs131-wop`
(build, zero `sorry`, `scripts/axioms.sh` and its self-test, `scripts/vacuity.sh` and its self-test with its counts reconciled — the new
theorems' binders, among them `cfg : X.OpenConfig …` and the surgery's, will read as new sites — and the linters), then the landing on
`main` with the procedure job that cites `exists_open` (ruling 401). Owed besides, not this job's: a Lean model of `exists_open`'s
hypotheses (FS131-E6's twelve-colour map, § 3.1), the inhabitant the docstring note says is missing. **Next step for a successor starting
cold**: read this stage, check out `fs131-wop` at its last commit, build it once under the slot (expect "all … up to date" or two modules
rebuilt and 0 warnings), re-run `data/fs131/io/iter.sh data/fs131/io/AxiomsIO.lean` into a file and classify it with
`tools/fs131_io_axioms.py <file> --expect 105` (expect exit 0, 103 exactly standard), then hand `fs131-wop` to the gate.

## Stage 15 — SAVED (FS131-IO3)

## Stage 16 — SAVED (FS131-OL1): the readback, the as-given build, and what this job may change

*FS131-OL1 (de Bruijn, the implementer, on Opus) continues this record from here, on `fs131-wop` at `a20bb6f5`. Brief:
`data/fs131/briefs/FS131-OL1-open-land.md` (on `main` at `34a28786`). Report: `data/fs131/reports/FS131-OL1.md`. Its job: OPEN's landing —
merge `main` into `fs131-wop`, the full gate on one commit, a fast-forward of `main`, and the drafts for the filing. It proves no theorem.*

### 16.1 The brief's quotations against their sources (standing rule 3)

Checked by script (`data/fs131/ol/quotes.py <brief> --root /home/kooshi/source/lean-dir`: every `> ` line of the brief followed by a
`> — source:` line, searched as an exact substring of one line of its source; a relative source path is read under `main`'s tree, where the
brief was written). Output `data/fs131/ol/quotes.txt`: **13 quotations, 0 mismatches**, each verbatim:

| quotation (a prefix) | source | line |
|---|---|---|
| "408. **FS131-IO3 done — OPEN held** (Stage 15 SAVED at Kooshi's halt, …" | `plans/FS131-close-inventory.md` (`main`) | 3683 |
| "409. **Ruling on OPEN: it lands on `main` by its own gate-and-land job on restart** …" | the same | 3698 |
| "411. **Rulings: the three slots, filled from the queue of the handoff.** …" | the same | 3708 |
| "384. **FS131-E6 done: F6 is real, and repaired with no backlog statement changed** …" | the same | 3411 |
| "391. **FS131-IO1 handed back** (Stage 3 SAVED, …" | the same | 3507 |
| "393. **FS131-IO2, by message: `open_allowedCone` is false as stated; a one-field repair to `OpenConfig`.** …" | the same | 3530 |
| "397. **FS131-IO2, by message: `open_degree_horns` is also false as stated; a second one-field repair to `OpenConfig`.** …" | the same | 3569 |
| "400. **FS131-IO2 handed back** (Stage 10 SAVED, …" | the same | 3605 |
| "375. **MERGE LANDED on `main`, held in the kernel: FS131-ML1 done** …" | the same | 3302 |
| "376. **MERGE's landing counts filed** (Keryx, drafts 1, 2, 4 verbatim): …" | the same | 3324 |
| "Of this brief: nothing. Of OPEN's landing, for the coordinator (not this job's to run): the full gate on a branch carrying `fs131-wop`" | this record § 15.3 | 635 |
| "theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}" | `OpenMove.lean` (`a20bb6f5`) | 2847 |
| "def HasHornCount (v : ℂ) (j : ℕ) : Prop :=" | `OpenMove.lean` (`a20bb6f5`) | 36 |

Controls on the checker: `--plant` (one character of the first quotation altered) reports exactly one `MISMATCH`, exit 1
(`data/fs131/ol/quotes-plant.txt`); a file with no quotation exits 2. A defect found live: the first version read the relative path in this
worktree, whose copy of the inventory is the branch point's (no item 384 or later), and reported 8 mismatches — the reason for `--root`.

### 16.2 Read for this job

`plans/STANDING-RULES.md` and `LEAN.md` in full; `RUNNING.md` § Building and § Make the gate fail, and watch it fail; inventory items 375–376
and 408–411 in full; this record's header and Stages 10–15 in full; ML1's landing (`plans/FS131-IMM-implementation.md` Stages 13–16 and its
drafts), whose order this landing follows; `exists_open` and `HasHornCount` whole, as they stand at `a20bb6f5`; `scripts/axioms.sh`,
`scripts/Vacuity.lean` (the docstring's carrier list and procedure, and the scan) in full.

### 16.3 The branch builds as given, and IO3's axioms check re-run

- **Build** at `a20bb6f5`, under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): **OK — "all 1767
  modules already up to date, nothing built, 0 module(s) with warnings, 2s"**, exit 0; log `build/gate/build/20261006T023101Z-70425.log`
  ("All targets up-to-date (5750 jobs)"), driver output `data/fs131/ol/build-asgiven.log`.
- **Axioms** against those oleans (`data/fs131/io/iter.sh data/fs131/io/AxiomsIO.lean` → `data/fs131/ol/axioms-io-asgiven.txt`, exit 0),
  classified by `tools/fs131_io_axioms.py … --expect 105` (`data/fs131/ol/axioms-io-asgiven-classified.txt`, exit 0): **105 records, 0
  `sorryAx`, 0 foreign; 103 on exactly `[propext, Classical.choice, Quot.sound]`, 2 on fewer** (`BranchGerms.idx_idx` `[propext]`,
  `BranchGerms.turns_idx` `[propext, Quot.sound]`). The classifier's own summary line reads `std=105`: its `STD` class is "within the
  standard three", so the 103 is read from the classified lines (`grep -c` of the full triple: 103), as IO3 read it. The print is
  byte-identical to IO3's `data/fs131/io/axioms-io3-final.txt` but for that file's first line, the slot's own "admitted" notice.

### 16.4 What this job may and may not change

**May**: the merge's files; `scripts/Axioms.lean` (OPEN's records, already registered as one block of 105 by IO1–IO3), `scripts/Vacuity.lean`
(the carrier list's OPEN entry, by the procedure in its docstring), `scripts/vacuity-controls.lean` and `scripts/vacuity.sh`'s `expect` lines
(a control, numbered after `main`'s last, 62, where the procedure asks for one), `scripts/vacuity-baseline.txt`'s header (its two count
lines; **no entry** — a new entry is the coordinator's ruling), `scripts/axioms-controls.txt` (the controls' expected counts, if this state
moves them); `Proofs.lean`, `ARCHITECTURE.md`; `OpenMove.lean` for a linter or docstring fix only; this record; `tools/fs131_ol_*.py`,
`data/fs131/ol/`, `data/fs131/reports/FS131-OL1.md`; then `main`, by fast-forward only. **May not**: any statement — no hypothesis, no
conclusion, no definition a statement uses (`OpenConfig` as IO2 left it); no `axiom`, no `native_decide`; `CLAUDE.md`, `LEAN.md`, `LEDGER.md`,
`tools/claude_md_fact_audit.py` (drafts only); another job's tools (`tools/fs131_io_*.py`, `tools/fs131_ml_*.py` are run, never edited);
and **the branch is never rewritten**: `a20bb6f5` stays an ancestor of everything pushed (FS131-IR1 merges it into wave 5 today, item 411 (d)).

**`main` since the branch point** `11a34d9d` (one merge base, `git merge-base --all HEAD origin/main`), at `origin/main` = `34a28786`:
`git diff --name-only 11a34d9d origin/main` names `BIBLIOGRAPHY.md`, ten briefs under `data/fs131/briefs/`, `plans/FS131-close-inventory.md`
and `plans/SESSION-HANDOFF-2026-10-04.md` — no Lean file, no script (`data/fs131/ol/main-since-base.txt`).

## Stage 16 — SAVED (FS131-OL1)

## Stage 17 — SAVED (FS131-OL1): `main` merged (`dff76573`); the build green; the checkers written; the counts predicted

**The merge** (`dff76573`: `git merge --no-ff origin/main` at `34a28786`, one merge base `11a34d9d`, no conflict). The files it changed on this
branch (`git diff --name-only f8c6173e dff76573`): `BIBLIOGRAPHY.md`, ten briefs under `data/fs131/briefs/`, `plans/FS131-close-inventory.md`,
`plans/SESSION-HANDOFF-2026-10-04.md` — **no Lean file, no script, no tool** (`git diff --name-only f8c6173e dff76573 -- '*.lean' scripts
lakefile.toml lake-manifest.json lean-toolchain tools ARCHITECTURE.md CLAUDE.md LEAN.md`: empty). Against `origin/main`, outside `plans/` and
`data/`, the branch differs in exactly its own six files: `ARCHITECTURE.md` (one row), `Proofs.lean` (one import), `OpenMove.lean`,
`scripts/Axioms.lean` (OPEN's block), `tools/fs131_io_axioms.py`, `tools/fs131_io_decls.py`. `a20bb6f5` is an ancestor of `dff76573`. With
no Lean source of `main` changed there is no name to collide and no statement to re-check against `main`: the Lean tree is `a20bb6f5`'s.

**Build** of the merged tree (under the slot): **OK — "all 1767 modules already up to date, nothing built, 0 module(s) with warnings, 2s"**,
exit 0 (`build/gate/build/20261006T023331Z-82931.log`, "All targets up-to-date (5750 jobs)"; driver `data/fs131/ol/build-merged.log`). The
oleans it found current are IO3's last full build's (`build/gate/build/20261005T124448Z-133559.log`: 451 of 451 batches, `OpenMove` and
`Proofs` rebuilt, "Build completed successfully (5750 jobs)"). **Warnings counted**: `grep -c warning` is 0 in both logs (the full log's one
`error` line is the up-to-date probe's "target is out-of-date", which starts the walk). Control on the count: IO2's log of the tree with one
`sorry` (`20261005T115945Z-4035875.log`) holds 2 `warning` lines, both `OpenMove.lean:2175:8: declaration uses 'sorry'`.

**The checkers** (new, this job's):
- **`tools/fs131_ol_axioms.py <axioms log>`**: three lists must agree — the theorems `OpenMove.lean` declares (its own parser; the same 105
  names as `tools/fs131_io_decls.py` lists, compared as sets), the names in `scripts/Axioms.lean`'s OPEN block (which must stand between the
  CLEAN and PURCHASED banners), and the gate's saved log (IMM4's `records`, imported) — each name once, printed under CLEAN, within the
  standard three. Seen failing before any pass: on the banner-less IO print it fails all 105 on the banner check alone
  (`data/fs131/ol/open-axioms-nobanner.txt`, exit 1); on `main`'s gated log, which holds no OPEN record, 105 × "no record in the log"
  (`open-axioms-mainlog.txt`, exit 1). Its `--plant` is run on the gate's own log in Stage 18.
- **`tools/fs131_ol_vacdiff.py <main log> <landing log>`** (after ML1's): every SITE and EVIDENCE row of `main`'s gated scan must be in
  the landing scan; every added row must belong to a declaration of `OpenMove`; an added SITE row reading VACUOUS, STALE or UNKNOWN is
  `FLAGGED` and fails (the brief's stop). `main`'s scan against itself: 845 rows, 0 lost, 0 added, PASS; `--plant` (a `main` row dropped, a
  non-OPEN row added, an OPEN row added reading UNKNOWN): `LOST`, `NOT OPEN'S`, `FLAGGED`, exit 1 (`data/fs131/ol/vacdiff-plant-pre.txt`).
- **`data/fs131/ol/count-open.lean`** (after ML1's `count-merge.lean`; `isRefutation`, `isNegationConcl`, `isGeneratedDecl` copied verbatim
  from `scripts/Vacuity.lean`): the declarations of the module `OpenMove` as the scan counts them. **147 declarations, 5 refutations**
  (`data/fs131/ol/count-open.out`): 105 theorems (the source's, name for name), 10 equation lemmas (`hornPos.eq_1`, `rayPos.eq_1`,
  `openWedge.eq_1`, `openCol.eq_1`, `openRim.eq_1`, `openPiece.eq_1`, `openRest.eq_1`, `openRay.eq_1`, and `liftDir.eq_1`,
  `sectorBetween.eq_1` realized here), 11 definitions, 5 matchers, the structure `Near.OpenConfig` and its 15 generated declarations (11
  fields, `mk`, `rec`, `recOn`, `casesOn`). The five refutations (a stated conclusion that reduces to `… → False`): `Near.open_valid`,
  `Near.openRay_nondegenerate`, `Near.OpenConfig.isClear_of_mem_openWedge`, `Near.OpenConfig.isClear_of_Icc`, and the generated projection
  `Near.OpenConfig.clear`. Control: the same count over a module that does not exist prints `declarations=0` (`count-open-plant.out`).

**The prediction, written before any gate run in this worktree** (`data/fs131/ol/prediction.txt`): axioms 3,912 records — 3,889 clean, 14
axiom-free, 4 imported, 5 purchases (105 added, all CLEAN); vacuity `declarations=11173 refutations-skipped=118 sites=784`, `vacuous=0
stale=0 declared=3 witnessed=32 generic=747 unknown=2` — 14 new sites, all `GENERIC`: 11 on `F.Valid` (12 theorems bind `hF : F.Valid`;
`open_valid` is a refutation, skipped), 2 on `F.IsHorn v α κ₁ κ₂ c` (`exists_openConfig`, `exists_open`), 1 on `F.Condition5`
(`open_condition5`); no EVIDENCE row; both self-tests unchanged (23, 62).

## Stage 17 — SAVED (FS131-OL1)
