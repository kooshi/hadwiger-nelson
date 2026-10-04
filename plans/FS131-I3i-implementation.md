# FS131-I3i — `localSectors`, the separation lemma, and the cusp-free four-colour clause

*Job FS131-I3i, de Bruijn the implementer (Opus 5.5), 2026-10-04. Brief: `data/fs131/briefs/FS131-I3i-localsectors.md` (main tree), with
`plans/STANDING-RULES.md`, `LEAN.md`, `RUNNING.md` § Building and § Make the gate fail. Worktree `.claude/worktrees/fs131-w3b`, branch `fs131-w3b`,
from `origin/main` at `0ff8f659`. Working files `data/fs131/i3i/`. No agents, no search.*

## Theorems this phase proved

*(Filled at the gate, from the saved audit log.)*

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
