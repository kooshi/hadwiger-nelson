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

Not yet proved (`sorry`; its axioms read `sorryAx`, and so does `ArcMap.exists_open` through it — the print's positive control):
`open_allowedCone` (route in § 10.3).

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
