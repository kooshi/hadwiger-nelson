# FS131-I3i — `localSectors`, the separation lemma, and the cusp-free four-colour clause

*Job FS131-I3i, de Bruijn the implementer (Opus 5.5), 2026-10-04. Brief: `data/fs131/briefs/FS131-I3i-localsectors.md` (main tree), with
`plans/STANDING-RULES.md`, `LEAN.md`, `RUNNING.md` § Building and § Make the gate fail. Worktree `.claude/worktrees/fs131-w3b`, branch `fs131-w3b`,
from `origin/main` at `0ff8f659`. Working files `data/fs131/i3i/`. No agents, no search.*

## Theorems this phase proved

Axioms read from the gate's saved audit log `build/gate/axioms/20261004T145223Z-97257.log` (copy `data/fs131/i3i/axioms-gate-full.log`), run on the
merged branch (`167a2a74`, `origin/main` with T3's gate merged in); every one of the 62 records this job added reads `[propext, Classical.choice, Quot.sound]`.
Statements read against their sources: `localSectors` and `ArcMap.IsSectorChart` against I3h's draft (`data/fs131/i3/h/LS.lean`, identical) and inventory
item 136 (branch germs with direction and signed curvature, sectors between consecutive branches for every smaller radius, each sector's cone an
interval); the separation lemma against `plans/FS131-E2-derivation.md` § 2.7 (identical text); `four_of_bothKind_simple` against `git show
05cb0a3e:Proofs/HadwigerNelson/Plane/RingGerm.lean` l. 300–302 (identical binders and conclusion).
- **FS131-E2-SECT, the sector structure** (inventory item 136) — `HadwigerNelson.Plane.localSectors` (every point of the domain has a sector chart:
  `∃ r₀ n G, F.IsSectorChart G v r₀`): `[propext, Classical.choice, Quot.sound]`. Children on the same axioms: `ArcMap.isSectorChart_of`,
  `BranchGerms.dir_lt_nextDir`, `BranchGerms.coneAt_sector`, `BranchGerms.isOpen_sector`, `BranchGerms.isPreconnected_sector`,
  `BranchGerms.sector_disjoint`, `BranchGerms.Mono.disjoint`, `BranchGerms.exists_angle`, `BranchGerms.Mono.not_mem_angleIoo`, `branchPt_curveGerm_mem`,
  `exists_eq_branchPt_curveGerm`, `exists_germDir_ne`, `Arc.eventually_mem_carrier`, `Arc.branch_mem_of_mem`, `Arc.exists_near`; inhabitant
  `halfDisc_sectorChart`.
- **FS131-E2-ONESECT, one sector per Jordan tile** — `HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_tile_inter_ball`: `[propext, Classical.choice,
  Quot.sound]`.
- **FS131-E2-SEP, the separated interval** — `HadwigerNelson.Plane.ArcMap.Simple.coneAt_eq_angleIcc_sep`: `[propext, Classical.choice, Quot.sound]`.
- **FS116-V5-U1's four-colour clause in the simple class, cusps included** (FS131-E2-U1-CUSP; inventory item 139's ruling: `hnc` dropped, statement
  `05cb0a3e`'s) — `HadwigerNelson.Plane.ArcMap.four_of_bothKind_simple`: `[propext, Classical.choice, Quot.sound]`.

## Stage 1 — SAVED: readback

**The quotation.** The brief quotes I3h's handoff:

> **Not done: `localSectors`, `Simple.coneAt_eq_angleIcc_sep`, `four_of_bothKind_simple` without `hnc`** (brief item 8; the budget's hand-back line was reached at

Source: `plans/FS131-I3-implementation.md` § Stage 11, line 409 on this branch. **Matches verbatim** (the brief cuts the sentence where the source
continues "the landing).").

**The other addresses the brief names**, each read:
- the draft `data/fs131/i3/h/LS.lean` — `branchPt`, `sectorBetween`, `BranchGerms` (`nextβ`, `nextκ`, `sector`, `Sorted`), `ArcMap.IsSectorChart`,
  `localSectors : ∃ r₀ n G, F.IsSectorChart G v r₀` with one `sorry`; **elaborates** against the landed module (`lake env lean data/fs131/i3/h/LS.lean`:
  one warning, "declaration uses `sorry`" at line 93, nothing else);
- inventory item 136 (main tree `plans/FS131-close-inventory.md` l. 814): branch germs with direction and signed curvature, sectors between consecutive
  branches, finite and constant in `r`, each sector's cone an interval — the draft's fields carry each;
- `plans/FS131-E2-derivation.md` § 2.7: the statement of `Simple.coneAt_eq_angleIcc_sep`; § 2.4: the proof shape of the four-colour clause; § 2.2–2.3:
  FS131-E2-SECT, -ONESECT, -SEP;
- inventory item 139 (l. 837): the ruling — `hnc` is mathematically unnecessary; restore `05cb0a3e`'s statement;
- `git show 05cb0a3e:Proofs/HadwigerNelson/Plane/RingGerm.lean`, l. 300–303: `four_of_bothKind_simple (hF : F.Valid) (hN : F.NonSiamese) (hS : F.Simple)
  {z : ℂ} (hz : z ∈ F.dom) {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') (hc : c ∈ F.coloursAt z) (hc' : c' ∈ F.coloursAt z) :
  4 ≤ (F.coloursAt z).ncard` — the landed statement differs only by the extra hypothesis `hnc`.

**The build as given.** `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from the worktree at `0ff8f659`: "OK — all 1737
modules already up to date, nothing built, 0 module(s) with warnings, 3s" (`data/fs131/i3i/build-stage1.log`; `build/gate/build/20261004T140251Z-4044353.log`).
The copied build directory is current.

## Stage 2 — SAVED: `localSectors`, the separated interval, and `four_of_bothKind_simple` without `hnc`

**The draft's shape is kept.** I3h's definitions (`branchPt`, `sectorBetween`, `BranchGerms` with `nextβ`, `nextκ`, `sector`, `Sorted`), the structure
`ArcMap.IsSectorChart` with its thirteen fields, and the statement `localSectors {v} (hv : v ∈ F.dom) : ∃ r₀ n G, F.IsSectorChart G v r₀` are in
`Plane/LocalStructure` exactly as the draft wrote them (section `LocalSectors`, appended; no landed statement touched). Nothing in the proofs pushed against
the shape, so no message on it was owed.

**The route** (all in `Plane/LocalStructure`, section `LocalSectors`):
1. *Germ directions* (`germDir β κ s = β + arcsin(κ s/2)`) and *the angular partition* of a weakly increasing germ list (`BranchGerms.Mono`, implied by
   `Sorted`): the closed interval of one consecutive pair meets the open interval of another in nothing (`Mono.disjoint`), every angle is a germ direction or
   in one open interval (`exists_angle`), no germ direction lies in an open interval (`Mono.not_mem_angleIoo`).
2. *The cyclic order at every distance* (`dir_lt_nextDir`): if the germs are sorted, `|κ| r₀ < 2`, and distinct germs' branches never meet at one distance,
   then `fᵢ(s) < fᵢ₊₁(s)` for every `s ∈ (0, r₀)` — the gap is continuous, never `0`, positive near `0` (sorted lexicographically: direction first, then
   curvature), so positive throughout (intermediate value on `(0, r₀)`).
3. *Sectors*: disjoint (`sector_disjoint`, from 1–2 at one radius), open (`isOpen_sector`: the local angle `φ₀ + arg((z − v)/(z₀ − v))` is continuous at
   `z₀`), connected (`isPreconnected_sector`: the image of `(0, r) × (0, 1)`), with cone `angleIcc (β i) (nextβ i)` (`coneAt_sector`: rays inside the open
   interval; nothing outside the closed one, by `‖e φ − e b‖² = 2 − 2 cos(φ − b)`; a cusp's one direction from the nonempty cone).
4. *A chart from branch data* (`ArcMap.isSectorChart_of`): sorted germs, `|κ| r₀ < 2`, `v ∈ Γ ↔ 0 < n`, the branches equal to the punctured ball's arcs, and
   no two branches meeting at one distance give every field; `cover` from 1 at radius `‖z − v‖`.
5. *The germs of a line or circle through `v`* (`curveGerm κ b σ`, `σ = ±1`, direction normalised into `[0, 2π)`, signed curvature `σκ/‖b‖`): each
   branch lies on its curve (`branchPt_curveGerm_mem`), each curve point near `v` lies on one of the two germs at its own distance
   (`exists_eq_branchPt_curveGerm`, by `cos(φ − arg b) = κ s/(2‖b‖)`), and two distinct normalised germs never meet at one small distance
   (`exists_germDir_ne`).
6. *Arcs near their own points*: off its ends an arc holds every nearby point of its full curve (`Arc.eventually_mem_carrier`, segment and circle);
   so below the distance of its far ends a branch lies in the arc wholly or not at all (`Arc.branch_mem_of_mem`, connectedness of `(0, r)`); and an
   arc through `v` has points at every small distance (`Arc.exists_near`).
7. *`localSectors`*: from `exists_goodAt`, the candidate germs of the finitely many arcs meeting the good ball; `r₀` below `ρ₀`, below every far end, and
   below every distance at which two distinct candidates meet (three `∀ᶠ r in 𝓝[>] 0`); the germs are the candidates whose whole branch lies in `Γ`,
   sorted by `Finset.orderEmbOfFin` on `Lex (ℝ × ℝ)`; then 4.

**Spec examples and inhabitant** (same section): `branchPt 0 0 0 1 = 1`; `‖branchPt 0 0 1 1 − i‖ = 1` (positive curvature bends left); `i/2` in the sector
between `0` and `π` and, adversary, `−i/2` not; `nextβ`/`nextκ` wrap one turn; two opposite rays sorted; a ray and a tangent circle sorted with the circle
second, and, adversary, not in the other order; `germDir 0 2 1 = π/2`; `curveGerm 1 i 1 = (0, 1)`; `(Arc.seg 0 1).ends = {0, 1}`; `next`, `atRadius`, `dir`,
`Mono` on a written instance. **Inhabitant**: `halfDisc_sectorChart` — `halfDisc` has a sector chart at the origin with at least one germ.

**The separated interval** (FS131-E2 § 2.7's statement, verbatim): `ArcMap.Simple.coneAt_eq_angleIcc_sep`. **Route divergence from E2 § 2.3, recorded**: E2
derives one sector per tile (ONESECT) through the Jordan curve theorem ("`J`'s two sides near a C¹ point lie in different components"). The proof here
needs none of it: `IsSectorChart.exists_tile_inter_ball` reads the landed `IsJordanDomain.local_connected` (the tile's part of a small ball lies in one
connected piece of the tile), which lies in one sector of the chart; a second sector of the tile would reach into that small ball and meet the first. Then
the cone is the sector's (`cone` field, `coneAt` local), and another tile's sector is another index, so `Mono.disjoint` gives the separation. The `n = 0`
case is the whole ball in one tile, alone at `x`.

**`four_of_bothKind_simple` without `hnc`** (item 139's ruling; statement now commit `05cb0a3e`'s, verbatim): proof by E2 § 2.4 — the tiles at `z` are
finitely many (`finite_tiles_near`), each with a separated interval (chosen); their end directions are countable, so side directions `σ ∈ S₁`, `σ′ ∈ S₂`
avoid them (measure zero); each lies in the open interval of the tile holding it, of a colour other than `c`, `c′` (`ringArc_sideCone_other`,
`coneAt_region_eq_biUnion`); one colour would make them one tile (non-Siamese), whose open interval then holds `[θ₂ − 90°, θ₁ + 90°]` (same lift) or
`[θ₂ + 90°, θ₁ + 270°] − 360°` (next lift) — the only two lifts the bounds allow — so the `c`- or `c′`-tile's cone direction, cusp or not, points into it,
against the separation. `θ₂ − θ₁ ≤ π` is read off `c`'s nonempty cone. The general `four_of_bothKind` (with `β₁ < β₂`) is untouched.

**Build**: `data/fs131/i3i/build-stage2.log` (`build/gate/build/20261004T143952Z-4189697.log`): "OK — 441 of 441 batches, 5 module(s) rebuilt, 0 module(s)
with warnings" (`Plane.LocalStructure`, `Plane.Tiles`, `Plane.RingGerm`, `Plane.RingBand`, `Proofs`). Scratch `#print axioms` (before the move into the module):
`localSectors`, `Simple.coneAt_eq_angleIcc_sep`, the new `four_of_bothKind_simple` — each `[propext, Classical.choice, Quot.sound]`; the gate's audit follows.

**Bookkeeping in this commit**: 62 records in `scripts/Axioms.lean` (section "FS-131 (job FS131-I3i)"); `ARCHITECTURE.md` rows `Plane/LocalStructure` and
`Plane/RingGerm`; `scripts/Vacuity.lean`, the carrier list, by T1's procedure step (1): `BranchGerms`, `Sorted`, `Mono`, `ArcMap.IsSectorChart` OUT, with
reasons (data; or existence a theorem, `localSectors`, and every site at a variable chart, `GENERIC`, like `IsTile`). One name renamed before landing:
my `eq_norm_mul_e_arg` collided with `SixFragment`'s (same namespace, both imported by `RingGerm`); it is `eq_polar_arg`. The other new top-level names were
grepped on `main`, `fs131-w2`, `fs131-w2d`, `fs131-w4`, `fs131-ww`: no collision.

## Stage 3 — SAVED: the gate on `fs131-w3b`, merged with `origin/main`

**Merge.** `origin/main` (`f01c964d`: T3's axiom-gate repair, E3, W3 and I2h briefs; no `Proofs/` change) merged into `fs131-w3b` as `167a2a74`, clean;
`scripts/Axioms.lean` merged with this job's 62 records in T3's CLEAN section, before the PURCHASED banner. **T3 had landed first, so its gate is the one
run**: the set check (CLEAN a subset of the standard three), the IMPORTED section, and `axioms.sh --self-test`.

**The gate** (every log read, not only its last line):
* **build** — `data/fs131/i3i/build-gate.log` = `build/gate/build/20261004T150953Z-223848.log`: "OK — 441 of 441 batches, 2 module(s) rebuilt, 0
  module(s) with warnings" (the two are `RingBand` and `Proofs`, rebuilt after the build control below was reverted); stage 2's build of the same
  Lean source: `build/gate/build/20261004T143952Z-4189697.log`, 5 rebuilt, 0 warnings. Zero `sorry` in `Plane/LocalStructure` and `Plane/RingGerm`
  (grep, word match); `sorryAx` 0 times in the receipt.
* **axioms** — `data/fs131/i3i/axioms-gate.log` (full: `build/gate/axioms/20261004T145223Z-97257.log`, copy `data/fs131/i3i/axioms-gate-full.log`):
  "OK — 1856 clean, 11 axiom-free, 0 imported, 5 declared purchase(s)" over 1,872 records. **Reconciled**: 1794 + 62 = 1856 clean (this job's 62
  records, every one `[propext, Classical.choice, Quot.sound]`); axiom-free, purchases (the five Moser-spindle ones) and imported unchanged. The digest
  flags `CLAUDE.md` § Trust ledger stale (1794 → 1856): draft below.
* **axioms self-test** — `data/fs131/i3i/axioms-selftest.log` (`build/gate/axioms-self-test/20261004T145240Z-99072.log`): "every planted fault fired,
  and every partner passed".
* **vacuity self-test** — `data/fs131/i3i/vacuity-selftest.log` (`build/gate/vacuity-self-test/20261004T145403Z-108385.log`): "every control fired, and
  the silent ones stayed silent". No control added: the new structures are OUT (stage 2), so no `trackedProps` entry and no `expect` line.
* **vacuity** — `data/fs131/i3i/vacuity-gate.log` (`build/gate/vacuity/20261004T145511Z-114524.log`): "vacuity: OK", `declarations=8500
  refutations-skipped=57 sites=460`, `vacuous=0 stale=0 declared=3 witnessed=21 generic=434 unknown=2` (the baseline's two). **Reconciled against
  8385 / 57 / 459 / 21 / 433**: declarations +115 = the 102 non-internal constants declared in section `LocalSectors` (counted by declaration range,
  line ≥ 3581 of `Plane/LocalStructure`) + 13 generated ones without a range (`BranchGerms.mk.inj`, `.mk.injEq`, `.mk.sizeOf_spec`, `.ctorIdx`,
  `.noConfusionType`, `Mono.le_add.match_1_1`, and the equation lemmas `branchPt.eq_1`, `germDir.eq_1`, `curveGerm.eq_1`, `BranchGerms.nextβ.eq_1`,
  `.nextDir.eq_1`, `.next.eq_1`, `.dir.eq_1`); sites +1 = generic +1 = `ArcMap.Simple.coneAt_eq_angleIcc_sep :: F.Simple` (a variable map);
  `four_of_bothKind_simple` keeps its four sites (`hnc` was never a tracked carrier); refutations-skipped, witnessed, vacuous, stale, declared, unknown
  unchanged.
* **architecture** — `tools/check_architecture.py`: exit 0, "RESULT: PASS" (`data/fs131/i3i/arch.log`).
* **spec examples** — elaborated in the build (section `LocalSectors`'s twelve `example`s and `halfDisc_sectorChart`).

**Negative controls, each watched red, each reverted** (`git diff` empty after each):
* build — `theorem fs131_i3i_planted_build : (1 : ℕ) = 1 := by sorry` appended to `Plane/RingBand`: "2 module(s) rebuilt, **1 module(s) with
  warnings**", naming `RingBand.lean:1191:8: declaration uses sorry` (`data/fs131/i3i/build-plant.log`). Observed: `build.sh` still exits 0 and prints
  "OK" with a warning; the gate's zero-warnings check is the count, not the exit status — read the count.
* axioms — `theorem fs131_i3i_planted_sorry : (1 : ℕ) = 2 := sorry` with its record in CLEAN: "FAIL sorry CLEAN 'fs131_i3i_planted_sorry' carries
  sorryAx", exit 1 (`data/fs131/i3i/axioms-plant.log`).
* vacuity — the self-test is the control suite, every control fired (above).
* architecture — `Plane/LocalStructure`'s Imports cell without `Plane/Chord`: "FAIL imports of Plane/LocalStructure: … real-only ['Plane/Chord']",
  exit 1 (`data/fs131/i3i/arch-plant.log`).

## Drafts for the front page

From the gate above (FS131-I3i, 2026-10-04; if another branch lands first, its records and declarations add to these numbers):
1. **`CLAUDE.md` § Trust ledger**, replacing "the current audit reads 1794 clean and 5 declared purchases, and 0 imported (and 11 axiom-free; 1,810 records
   at wave 3's landing with FS131-T3's gate repair, 2026-10-04)" with "the current audit reads 1856 clean and 5 declared purchases, and 0 imported (and 11
   axiom-free; 1,872 records at `localSectors`' landing, FS131-I3i, 2026-10-04)".
2. **`CLAUDE.md` § The gate**, replacing "`declarations=8385 refutations-skipped=57 sites=459`, `vacuous=0 stale=0 declared=3 witnessed=21 generic=433
   unknown=2`" with "`declarations=8500 refutations-skipped=57 sites=460`, `vacuous=0 stale=0 declared=3 witnessed=21 generic=434 unknown=2`".
3. **`scripts/vacuity-baseline.txt`'s header**, replacing "#   declarations=8385  refutations-skipped=57  sites=459" and "#   vacuous=0 stale=0
   declared=3 witnessed=21 generic=433 unknown=2" with "#   declarations=8500  refutations-skipped=57  sites=460" and "#   vacuous=0 stale=0 declared=3
   witnessed=21 generic=434 unknown=2". The baseline's two entries are unchanged.
4. **`CLAUDE.md` § Frontier, "What the kernel holds, beyond the interval"** — I3h's draft 4 (its record, "Drafts for the front page") is not filed yet;
   it inserts the wave-3 clause after "**FS-101's first slot** — `χ(ℚ(√47)²) ≤ 5`, and the main clause through five over named hypotheses (row 127);".
   In that clause, after its words "and FS116-Y2-SIXFRAG's six-colour fragment, valid and non-Siamese,", insert: "the sector structure at a point of an
   arc map (`localSectors`: finitely many branch germs, the interior points near the point the sectors between consecutive germs, each with the cone of
   its two germs), one sector per Jordan tile and the separated interval (FS131-E2-SECT, -ONESECT, -SEP), and FS116-V5-U1's four-colour clause in the
   simple class with cusps (FS131-E2-U1-CUSP),". Nothing for `LEDGER.md` (rows are regraded at the milestone's filing); there FS131-E2-SECT, -ONESECT,
   -SEP and -U1-CUSP move from [hand]/[derived] to [kernel].

## Stage 4 — SAVED: the landing

`origin/main` moved after stage 3 (`f833838a`: QA2, W3, I4c briefs; plans, data and `tools/fs131_qa2_census.py` only, no `Proofs/` or `scripts/` change);
merged again as `746a7b80`, and the gate re-run there: build "all 1737 modules already up to date, nothing built, 0 module(s) with warnings"
(`data/fs131/i3i/build-gate2.log`, `build/gate/build/20261004T152357Z-336277.log`); axioms "OK — 1856 clean, 11 axiom-free, 0 imported, 5 declared
purchase(s)" (`data/fs131/i3i/axioms-gate2.log`, `build/gate/axioms/20261004T152427Z-338905.log`); vacuity "OK", counts as stage 3
(`data/fs131/i3i/vacuity-gate2.log`, `build/gate/vacuity/20261004T152430Z-339294.log`); `check_architecture` PASS (`data/fs131/i3i/arch2.log`). Then
`origin/main` fast-forwarded to this branch by `git push origin HEAD:main` (the commit carrying this stage and the report). The main tree's local `main`
was not touched.

**Third merge** (`0fe08a25`): `origin/main` moved again during the report (`d5a4acfd`: QA2's `plans/FS131-QA2-audit.md` and `tools/fs131_qa2_brick.py`
only). `git diff 746a7b80 0fe08a25 -- Proofs scripts lakefile.toml lean-toolchain ARCHITECTURE.md` is empty, so the gate of `746a7b80` covers the same Lean
source and gate scripts; the build re-run there: "all 1737 modules already up to date, nothing built, 0 module(s) with warnings"
(`build/gate/build/20261004T152617Z-348924.log`).
