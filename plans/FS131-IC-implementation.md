# FS131-IC — wave 4's `Contact` implementation record (branch `fs131-w4c`)

Implementer: de Bruijn on Opus 5.5 (job FS131-IC1). Brief `data/fs131/briefs/FS131-IC1-contact.md` (on `main`); plan
`plans/FS131-w4-kernel-plan.md` (§§ 3.2, 13, 14). Worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4c`, branched from `fs131-w4`
at `68f34f18`. Iteration tools (never evidence): `data/fs131/ic/iter.sh <module…>` (compile oleans into the scratch mirror
`/home/kooshi/scratch-w4c`), `data/fs131/ic/chk.sh <abs .lean path>`.

## Theorems this phase proved

Axioms from `#print axioms` against the stage-2 build's oleans (`data/fs131/ic/axioms-stage2.txt`), not a gate log; each read against its row
(plan § 3.2), same statement.
- FS110-N3-CONF (iii), N3-CLEAR: `HadwigerNelson.Plane.ArcMap.clear_of_subset_interior_allowedCone` — [kernel] `[propext, Classical.choice, Quot.sound]`.
- FS110-N3-DEG (unit arcs, curvatures in `[−1, 1]`): `HadwigerNelson.Plane.ArcMap.woodallCone` — [kernel] `[propext, Classical.choice, Quot.sound]`.
- FS110-N3-DEG as filed (Condition 5, curvatures in `(−1, 1)`): `HadwigerNelson.Plane.ArcMap.woodallCone_strict` — [kernel] `[propext, Classical.choice, Quot.sound]`.
- FS110-N4-SHAVE's criterion: `HadwigerNelson.Plane.ArcMap.shaveAvailable_of_not_doublyShadowed` — proved **over `flank_shadows`** (still `sorry`):
  `[propext, sorryAx, Classical.choice, Quot.sound]` until `flank_shadows` lands (stage-3 build, `data/fs131/ic/axioms-stage3.txt`).
- 35 children in `Plane/ValidMap/Contact` (33 listed in Stage 2; `tanHeight_anti`, `hornSet_mono` in Stage 3), each `[propext, Classical.choice, Quot.sound]`; among them
  `ArcMap.woodall_contacts` (Woodall's out-type contacts at `v ± n` when `int D_c(v) = ∅`) and `interior_nonempty_of_not_mem` (the planar step).
- FS110-N4-STUCK, N4-PROP (FS131-IC2, Stage 5): `HadwigerNelson.Plane.ArcMap.stuck_chain` — proved **over `stuck_structure`** (still `sorry`):
  `[propext, sorryAx, Classical.choice, Quot.sound]` until `stuck_structure` lands (stage-5 build, `data/fs131/ic/axioms-ic2-stage5.txt`). Its three step children
  `ArcMap.stuck_neighbour`, `ArcMap.stuck_flip`, `ArcMap.stuck_step` likewise read `sorryAx` only through `stuck_structure`.
- 9 children (FS131-IC2, Stage 5), each `[propext, Classical.choice, Quot.sound]`: `mem_coneAt_hornSet`, `e_eq_of_mem_coneAt_hornSet` (a horn approaches its
  base point exactly along its axis), `dot_neg_left`, `ArcMap.IsHorn.congr`, `ArcMap.IsHorn.eventually_subset_region`, `ArcMap.IsHorn.mem_coneAt_region`,
  `ArcMap.exists_hasSectors` (every colour has a sector count at a point of the domain), `ArcMap.e_eq_or_of_two_horns`, `ArcMap.covers_of_isPlaneMap`.
- 1 child (FS131-IC2, Stage 6), `[propext, Classical.choice, Quot.sound]`: `ArcMap.shaveAvailable_of_adjacent_horns` (two `c`-horns on one ray sharing their
  bounding arc, with a lower flank, make SHAVE available — Stage 5's finding 1).

- 44 children (FS131-IC3, Stage 8), each [kernel] `[propext, Classical.choice, Quot.sound]` (`data/fs131/ic/axioms-ic3-stage8.txt`), among them:
  `ArcMap.stuck_horns` (N4-STUCK (i): exactly two `c`-horns along `±a`, curvatures in `(−1, 1)`, out-type `c`-contacts at `N`, `S′` — `stuck_structure`'s first
  seven clauses and its two out-type `c`-clauses), `ArcMap.woodallCone_isHorn` (Woodall's cone with radius-independent horns), `ArcMap.IsHorn.exists_flankAbove`,
  `ArcMap.IsHorn.exists_flankBelow` (a horn has flank colours), `ArcMap.horn_unique_of_stuck` (one horn per ray at a stuck vertex),
  `ArcMap.shadow_source_near_poles` (N4-FLANK's localization), `ArcMap.horn_shadow_near_S`, `ArcMap.horn_shadow_near_N`, `ArcMap.outType_S_of_shadow`,
  `ArcMap.outType_N_of_shadow` (a flank colour shadowing the horn near `v` has an out-type contact at the far pole), `hornSet_curv_eq`,
  `ArcMap.IsHorn.exists_chart_index`.

## Stage 1 — SAVED: the readback, the as-given build

**The brief's four quotations against their sources** (standing rule 3):
1. "**It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the"
   — `plans/FS131-w4-kernel-plan.md` § 14.2 (in this tree at `68f34f18`): **matches as a truncation** (the source continues "… foundation
   `Plane/ValidMap/Basic` where § 13.1 puts them, sorry-free, each with a spec example); …").
2. "**What is left (50) and the order I would take it.** Contact 10: `clear_of_subset_interior_allowedCone`, `woodallCone`, `woodallCone_strict` (now has"
   — `plans/FS131-I4-implementation.md` Stage 8, last paragraph: **matches as a truncation**.
3. "194. **Ruling: wave 4 splits by file** (item 191's condition met: six leaves a session on wave 4's last two sessions, 39 left). Choice: the next wave-4 implementer"
   — `plans/FS131-close-inventory.md` on `main`, line 1358: **matches as a truncation**.
4. "Confidence: high. (b) The carriers' in/out recommendation goes to wave 5's implementer at its gate, under T1's procedure (no ruling now). (c) **K5b's slot"
   — `plans/FS131-close-inventory.md` on `main`, item 208, line 1487: **matches as a truncation**; the item continues as the brief says (worktree
   `fs131-w4c` from `fs131-w4` at `68f34f18`, record `plans/FS131-IC-implementation.md`, merge into `fs131-w4` before wave 4's gate).

**A slip in the brief (not a quotation):** its first line reads "# Brief FS131-I4h — wave 4 of the Lean backlog, continued: the 24 remaining `sorry`
declarations in `UnitArc` and `BaseSteps` on branch `fs131-w4`" — the title of I4h's brief; the header block below it (`brief: FS131-IC1`, role, touches)
and the body are this job's. I worked from the header and body.

**A finding about the plan's routing (not a statement):** the brief says `exists_merge` and FS131-I4h's `n3_end` read `woodallCone`. No module imports
`Plane/ValidMap/Contact` today except `Proofs.lean` (`BaseSteps` imports `Basic`, `SVMap`, `LocalMapExamples`, `UnitArc`); if `n3_end`'s proof needs
`woodallCone`, `BaseSteps` must import `Contact` (no cycle: `Contact` imports `Basic`, `Tiles`, and from this job `Sectors`, none of which imports
`BaseSteps` or `UnitArc`). I keep `Contact`'s imports free of `UnitArc` and `BaseSteps` so that import stays possible.

**What I may change** (§ 14.2 and the brief's `touches`): add children anywhere in `Contact` and in a new module of my own (`Plane/ValidMap/ContactAux`,
imported by `Contact`) and additions to the foundation `Plane/ValidMap/Basic` (statements unchanged); `Proofs.lean`, `ARCHITECTURE.md`,
`scripts/Axioms.lean` (my own block, headed "FS131-IC1"), this record, `tools/fs131_ic_*.py`, `data/fs131/ic/`, `data/fs131/reports/FS131-IC1.md`;
imports of `Contact` (with `ARCHITECTURE.md`'s Imports cell). A strengthened form of a move (wave 5's "every point of four or more colours after a move
had them before") only as a new lemma beside the move. **What I may not change**: any statement of §§ 3.2, 7.2 (the ten leaves' hypotheses and
conclusions, `stuck_structure`'s Condition 5 and three-colour hypotheses included), any definition of `Plane/ValidMap/Basic`, the read-back conventions;
`UnitArc`, `BaseSteps`, `SVMap`, `StuckChain` (FS131-I4h's, on `fs131-w4`); no new `axiom`, no `native_decide`; no merge into `fs131-w4`, no gate of
wave 4, no push to `main`. A leaf that cannot be proved as written goes to Keryx at once with the declaration, the reason and the counterexample or
missing hypothesis.

**The worktree as given** (`68f34f18`, nothing edited): `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build: OK —
444 of 444 batches, 3 module(s) rebuilt, 3 module(s) with warnings, 9m21s", exit 0 (`build/gate/build/20261004T185251Z-1528718.log`; driver log
`data/fs131/ic/build-readback.log`). 34 `declaration uses sorry` warnings: `Contact` 10 (the ten leaves), `UnitArc` and `BaseSteps` 24 (I4h's).

## Stage 2 — SAVED: `woodallCone`, `woodallCone_strict`, `clear_of_subset_interior_allowedCone`; 7 `sorry` left in `Contact`

**Proved (3 of 10; no statement changed, no new axiom, no `native_decide`).** Each read against its row (plan § 3.2) — same statements as filed.
- **FS110-N3-DEG, `ArcMap.woodallCone`** (unit arcs allowed, curvatures in `[−1, 1]`). Route: a direction `α` of `c`'s class at `v` (`coneAt_nonempty`)
  lies in `D_c(v)` (`coneAt_subset_allowedCone`); the contact directions form a compact set `A` of unit vectors (in-type `w − v`, out-type `v − w`;
  compact because in/out-type contacts are exactly the closure points of `c`'s class inside / outside the unit disc, `inType_iff`, `outType_iff`, over
  `exists_ball_tiles_mem_closure`), all with `e α · u ≥ 0`; if `n` or `−n` were missing from `A`, `e α ∓ (η/4) n` would be interior to `D_c(v)`
  (`interior_nonempty_of_not_mem`, the planar step, with an explicit margin). So `n, −n ∈ A`, and of the four cases only "out at `N`, out at `S′`"
  survives (`not_inType_both`: `B̄(N,1) ∩ B̄(S′,1) = {v}` against an open tile; in-and-out at one point by `contact_inType_or_outType`):
  `woodall_contacts`. Every `c`-sector lies in a `c`-tile at `v` (`sector_subset_tile`), which is far from the out-type tiles at `N`, `S′` (N-E2,
  `one_le_dist_of_outType`), so its directions satisfy `sin(β − α) = 0` (`dot_nonpos_of_coneAt_subset` twice); in the chart of `localSectors` such a
  sector is a horn `hornSet v β κ₁ κ₂ r` with `β` a direction of it (`IsSectorChart.horn_of_cone_sin`), `e β = e α` or `e (α + π)`
  (`e_eq_or_of_sin_sub_eq_zero`, `hornSet_congr`), and avoiding `B(N, 1)`, `B(S′, 1)` forces `κ₂ ≤ 1`, `κ₁ ≥ −1` (`curv_le_one_of_avoid`,
  `neg_one_le_curv_of_avoid`, by the branch point of an intermediate curvature, `branchPt_mem_hornSet`, `tanHeight_branchPt`). The plan's "closed
  convex cone with empty interior lies in a line" was not needed: only the two generators `±n` are.
- **FS110-N3-DEG as filed, `ArcMap.woodallCone_strict`** (Condition 5). Over `woodallCone`: if `κ₂ = 1`, the points `branchPt v β 1 s`, `0 < s < r`,
  lie in the horn's closure (`branchPt_mem_closure_hornSet_upper`) but not in it, so off the interior points (the horn is a component,
  `not_mem_interiorPts_of_mem_closure_sector`), all on `ω(v + e(β + π/2))` (`dist_branchPt_one`): infinitely many points of `Γ ∩ ω(N′)` in a ball met by
  finitely many arcs, against Condition 5 (`false_of_branch_on_sphere`). `κ₁ = −1` the mirror.
- **FS110-N3-CONF (iii), `ArcMap.clear_of_subset_interior_allowedCone`** (N3-CLEAR, contact arcs allowed). The margin `μ = δ/2` from
  `IsCompact.exists_thickening_subset_open` (`e '' Λ` compact in the open `int D_c(v)`); each contact `w` gets a ball met only by tiles holding `w` in
  their closure (`exists_ball_tiles_mem_closure`), radius `≤ μ/2`; the union `U` of these balls covers the contacts, and compactness of
  `cl(C_c) ∩ {1/2 ≤ |y − v| ≤ 3/2} ∖ U` gives `t₀` with every class point within `t₀` of `ω(v)` inside `U`. For `0 < t < min(t₀, μ/2)` and `y` in `c`'s
  class: far from `ω(v)`, the triangle inequality; in `U`, near a contact `w` whose type fixes the side, `|y − (v + t e β)|² = |y − v|² − 2t e β·(y − v) + t²`
  (`sq_norm_sub_add_smul`) is `< 1` (in-type, `e β·(y − v) ≥ μ/2`) or `> 1` (out-type). No finiteness of contacts is used (FS112-WALK's reading confirmed).

**Imports.** `Contact` now imports `Plane/SVMap` (for `dot_e_e`, `dot_ofReal_mul`, `dot_add_left` and, through it, `Plane/ValidMap/Sectors`'
`localSectors` bridge); no cycle (`SVMap` imports `Sectors`, `Instances/Seven`, `Topology/LebesgueCovering`, `Plane/Diameter`). `ARCHITECTURE.md`'s
row updated; `tools/check_architecture.py`: PASS. All 33 children live in `Contact` itself (no `ContactAux` module was needed). Names checked against
`fs131-w4`, `fs131-w5`, `main` and this tree: no collision at this commit (FS131-I4h may add names meanwhile; the merge's build will say).

**Records.** `tools/fs131_ic_addrecords.py` (new): parses `Contact`'s theorems with their namespaces and appends missing `#print axioms` records under a block
headed "FS131-IC1" before the `=== PURCHASED ===` banner; `--check` exit 0 (63 names, 0 missing); negative control `--plant --check` exit 1 (watched). It
refuses (exit 2) if it parses no names, so it cannot pass by reading nothing.

**Build of this stage**: `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build: OK — 444 of 444 batches, 2 module(s)
rebuilt, 3 module(s) with warnings, 8m45s", exit 0 (`build/gate/build/20261004T191357Z-1654833.log`; driver log `data/fs131/ic/build-stage2.log`).
31 `declaration uses sorry` warnings — `Contact` 7, `UnitArc` and `BaseSteps` 24 (I4h's) — and no other warning or error. Nothing was edited while it ran.

**Axioms**, printed against that build's oleans (`lake env lean data/fs131/ic/AxiomsIC.lean`, `pp.fullNames`; output `data/fs131/ic/axioms-stage2.txt`;
not a gate log): all 63 theorems of `Contact` printed; the 56 proved ones (the three leaves, the 33 children of this stage, and the 20 proved before it)
read `[propext, Classical.choice, Quot.sound]`; the 7 left read `sorryAx` besides.

**Re-pricing (standing order, from the first two hard leaves).** `woodallCone` (H) and `clear_of_subset_interior_allowedCone` (H) took about 40k and
25k tokens of work each once the reading was done, `woodallCone_strict` (M) about 15k; the plan's grades held for these three. The reading of the plan,
the derivation (FS110-N § N3-2, § N4-2) and the wave's API cost more than the proofs. The seven left are larger than the plan's re-priced "M–H": see below.

**What is left (7), in the order I would take it, with what each needs** (my reading, for the successor; none changes a statement):
1. **`flank_shadows`** (H, one session). The semantic statement is not enough for its consumer: `stuck_structure` (ii) reads N4-FLANK's *mechanism*
   ("doubly shadowed gives an out-type `h`-tile at `N` and an out-type `g`-tile at `S′`"), so prove a child stating the mechanism (within the horn near `v`,
   the `g`-shadow is the union of "below `Σ(C)`" over the out-type `g`-sectors at `S′` tangent to `a`, the `h`-shadow the union of "above" over the
   out-type `h`-sectors at `N` tangent to `a`) and derive `flank_shadows` from it. Steps: (a) no in-type `g`- or `h`-contact at `N` or `S′` (N-E2 against
   the flank tile; flank points outside `B̄(N, 1)` and `B̄(S′, 1)` exist because `κ₂ < 1`, `κ₁ > −1` — `branchPt_mem_hornSet` at a curvature between `κ₂`
   and `min(κ′, 1)`); (b) contacts with `|e α·(w − v)| ≥ μ`: the margin argument of `clear_of_subset_interior_allowedCone`'s proof, restricted to horn
   points (their directions tend to `α`); (c) contacts near but not at `N`, `S′`: through the sector chart (`localSectors`) of each tile at the contact —
   the plan's sketch does not treat these, and this is where the work is; (d) out-type at `N` for `g`: `lune_dist_le_of_up` reflected, missing the flank;
   (e) out-type sectors at `S′` tangent to `a` at curvature `υ`: `shadow_farSide_below`; non-tangent: inside `B(S′, 1)`, missing the horn; (f) a finite
   union of "below `σ`" sets is "below the largest".
2. **`shaveAvailable_of_not_doublyShadowed`** (E over 1): not doubly shadowed gives `σ_g ≤ σ_h` (else `hornSet v α σ_h σ_g r` is in both shadows);
   take `σ = σ_g`; `tanHeight` is antitone in the curvature.
3. **`exists_shave`** (H, about a session). `F′ = F` plus two arcs — the branch of curvature `σ` from `v` to radius `ρ` (`Arc.circ` with explicit
   centre `v + n/σ`, or `Arc.seg` at `σ = 0`; none when `σ ∈ {κ₁, κ₂}`) and the arc of `∂B(v, ρ)` across the horn — with colour `g` above `σ`, `h` below on
   `hornSet ∩ B(v, ρ)`. Validity: engine 1 (`Valid.of_agreesOff`) with `hclear`; no unit arc: engine 2 (`ringArcsWithin_of_Γ_subset`, written nowhere yet;
   FS131-I4h's bends need it too — whoever writes it first should tell the other); sector count: a partition of `F′.interiorPts ∩ B(v, r)` and
   `isSector_iff_of_partition`, the two sub-horns preconnected through a two-germ `BranchGerms` and `isPreconnected_sector`; rim colours `≤ 3` from the chart
   at `v` (a rim point off the horn lies in one sector or on one branch). **A hidden case:** the statement does not assume `g ≠ c`, `h ≠ c` (N4-SHAVE's
   setting does; `ShaveAvailable` does not either), and with `g = c` and `σ < κ₂` the upper part is a new `c`-sector unless the `κ₂`-branch inside `B(v, ρ)`
   is deleted — so that case needs the cut of item 4. The statement stays provable; I recommend no change (wave 5 applies SHAVE wherever `ShaveAvailable`
   holds, which allows `g = c`).
4. **`exists_rayMerge`, `exists_merge`** (H each, a session each). **The plan's claim (§ 13.1 engine 3: "the moves of Contact add arcs and recolour; they
   never delete one") is wrong for these two**: `HasSectors v c n` counts components of `F′.interiorPts ∩ B(v, r)`, and while the arcs between the merged
   sectors stay, the recoloured sectors stay separate components and the `c`-count rises instead of falling. Each needs a cut at `v`: every arc through `v`
   whose branch lies inside the merged region is replaced by its pieces outside that branch's part in `B(v, ρ)` (for `ρ` below the chart radius, the arcs
   meeting `B(v, ρ)` are the finitely many through `v`; a circle or segment through `v` meets `B(v, ρ)` in one sub-arc, so each arc becomes at most three
   `Arc` values). Then RAY's clearness (N4-RAY's crossing argument: a unit circle through a point between the horns leaves the stack through a boundary arc
   and crosses into a `c`-horn) and MERGE's (N3-CLEAR at the gap's interior ends, `clear_of_subset_interior_allowedCone`; N3-UP at a cusp end,
   `lens_dist_lt_one_of_up`, `lune_dist_le_of_up`; NB3's two repairs).
5. **`stuck_structure`** (H, a session, after 1 and 2): no MERGE gives `int D_c(v) = ∅` for the two-sector colour, so `woodallCone_strict`; no RAY gives
   one horn per ray; no SHAVE gives doubly shadowed by 2's contrapositive; then 1's mechanism for (ii)–(iv) and the three-colour hypothesis at `v`, `N`, `S′`.
6. **`stuck_chain`** (M over 5): a step lemma "stuck at `v` with an `α`-horn of a colour with two sectors ⟹ stuck at `v + n` with an `α`-horn" (at `N`,
   `h` has two sectors; terminal gives no move; `woodallCone` at `N` with `v` an out-type `h`-contact of `N` fixes the axis: `e α″ ⊥ (v − N)`), the mirror
   by `α + π` (the other horn from `stuck_structure`), then `Int.induction_on` both ways.

## Stage 3 — SAVED: `shaveAvailable_of_not_doublyShadowed` over `flank_shadows`; 6 `sorry` left in `Contact`, and the hand-back

**Proved over `flank_shadows`'s statement** (its own `sorry` gone; it reads `sorryAx` only through `flank_shadows` until that leaf lands; no statement
changed): **FS110-N4-SHAVE's criterion, `ArcMap.shaveAvailable_of_not_doublyShadowed`.** From `flank_shadows`' `σ_g`, `σ_h`: if `σ_h < σ_g`, the band
`hornSet v α σ_h σ_g r` lies in both shadows (`hornSet_mono`), against "not doubly shadowed"; so `σ_g ≤ σ_h`, and `σ = σ_g` splits the horn — above it
outside the `g`-shadow, not above it outside the `h`-shadow (the height above a tangent circle falls as the curvature grows, `tanHeight_anti`). Children:
`tanHeight_anti`, `hornSet_mono`. Records: `tools/fs131_ic_addrecords.py --check` 65 names, 0 missing.

**Build of this stage**: `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`; admitted after a wait for other trees'
builds): "build: OK — 444 of 444 batches, 2 module(s) rebuilt, 3 module(s) with warnings, 8m31s", exit 0 (`build/gate/build/20261004T193115Z-1790239.log`;
driver log `data/fs131/ic/build-stage3.log`). 30 `declaration uses sorry` warnings — `Contact` 6, `UnitArc` and `BaseSteps` 24 (I4h's) — and no other
warning or error. Nothing was edited while it ran. **Axioms** against its oleans (`data/fs131/ic/axioms-stage3.txt`): 65 theorems of `Contact`; 58 read
`[propext, Classical.choice, Quot.sound]`; `shaveAvailable_of_not_doublyShadowed` reads `sorryAx` through `flank_shadows`, and the six left read it besides.

**The hand-back.** Proved in this job: 4 of `Contact`'s 10 leaves (`clear_of_subset_interior_allowedCone`, `woodallCone`, `woodallCone_strict` clean;
`shaveAvailable_of_not_doublyShadowed` over `flank_shadows`) and 35 children. **Left (6):** `flank_shadows`, `exists_shave`, `exists_rayMerge`,
`exists_merge`, `stuck_structure`, `stuck_chain` — the order and what each needs is Stage 2's list (items 1, 3, 4, 5, 6; item 2 is done). Branch
`fs131-w4c` is ready for the merge into `fs131-w4` (conflicts expected at the append points of `scripts/Axioms.lean` and `ARCHITECTURE.md` only; my
records are in their own block headed "FS131-IC1"); I did not merge or run wave 4's gate.

## Stage 4 — SAVED (FS131-IC2 stage 1): the readback, the as-given build

Implementer: de Bruijn on Opus 5.5 (job FS131-IC2), resuming this record at its last SAVED stage (Stage 3, commit `ab4b7182`; the report
`7bb8837b` follows it — `git log -- plans/FS131-IC-implementation.md` agrees). Brief `data/fs131/briefs/FS131-IC2-contact.md` (on `main`).

**The brief's four quotations against their sources** (standing rule 3):
1. "**It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the"
   — `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 14.2, line 887: **matches as a truncation** (identical text in this tree's copy).
2. "**What is left (7), in the order I would take it, with what each needs** (my reading, for the successor; none changes a statement):" — this record,
   Stage 2, line 104: **matches**.
3. "1. **`flank_shadows`** (H, one session). The semantic statement is not enough for its consumer: `stuck_structure` (ii) reads N4-FLANK's *mechanism*"
   — this record, Stage 2, line 105: **matches as a truncation**.
4. "194. **Ruling: wave 4 splits by file** (item 191's condition met: six leaves a session on wave 4's last two sessions, 39 left). Choice: the next
   wave-4 implementer" — `plans/FS131-close-inventory.md` on `main`, line 1358: **matches as a truncation**.
No slip found in the brief (its title line is this job's).

**What I may change** (plan § 14.2, the brief's `touches`, inventory item 218 (g)): add children anywhere in `Contact`, in a new module of my own
(`Plane/ValidMap/ContactAux`, imported by `Contact`) and in the foundation `Plane/ValidMap/Basic` (additions only, statements unchanged) — there,
`ringArcsWithin_of_Γ_subset` under exactly that name if I reach engine 2 first (I4h is told the same; the merge removes an identical copy);
`Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (my own block, headed "FS131-IC2"), this record, `tools/fs131_ic_*.py`, `data/fs131/ic/`,
`data/fs131/reports/FS131-IC2.md`. **What I may not change**: any statement of plan §§ 3.2, 7.2 (the six leaves' hypotheses and conclusions,
`stuck_structure`'s Condition 5 and three-colour hypotheses included — Condition 5 stays a named hypothesis), any definition of `Basic`, the
read-back conventions; `UnitArc`, `BaseSteps`, `SVMap`, `StuckChain` (FS131-I4h's, on `fs131-w4`); no new `axiom`, no `native_decide`; no merge into
`fs131-w4`, no wave-4 gate, no push to `main`. A leaf that cannot be proved as written goes to Keryx at once (declaration, reason, counterexample or
missing hypothesis), and I go on with the others.

**The worktree as given** (`7bb8837b`, nothing edited): `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build:
OK — all 1744 modules already up to date, nothing built, 3 module(s) with warnings, 3s", exit 0 (`build/gate/build/20261004T194420Z-1885568.log`;
driver log `data/fs131/ic/build-ic2-readback.log`) — IC1's stage-3 oleans are current. 30 `declaration uses sorry` warnings replayed: `Contact` 6
(lines 1398, 1437, 1451, 1467, 1483, 1506: `flank_shadows`, `exists_shave`, `exists_rayMerge`, `exists_merge`, `stuck_structure`, `stuck_chain`),
`UnitArc` 17 and `BaseSteps` 7 (I4h's).

## Stage 5 — SAVED (FS131-IC2 stage 2): `stuck_chain` over `stuck_structure`; 5 `sorry` left in `Contact`

**Proved over `stuck_structure`'s statement** (its own `sorry` gone; no statement changed, no new axiom, no `native_decide`): **FS110-N4-PROP,
`ArcMap.stuck_chain`**, read against plan § 3.2's row (FS110-N4-STUCK, "N4-PROP for a terminal valid plane map: `IsStuck (v + j n)` for every `j ∈ ℤ`"): same
statement. Route (N4 § 2.5, the step `k → k + 1`, then induction and the mirror):
- `stuck_neighbour` (the step's second half): if a colour `h` carried at `v` has eventually at least two sectors at `P = v + e(α + π/2)`, then `P` is stuck
  (terminal gives no move; `exists_hasSectors` turns "eventually `≥ 2`" into an exact count) and `h` has a horn at `P` along `e α`: `stuck_structure` at `P` gives
  `h`-horns along `α₁`, `α₁ + π`; both axes lie in `D_h(P)` (`coneAt_subset_allowedCone` over `IsHorn.mem_coneAt_region`), and `v` is an `h`-contact of `P`
  (in- or out-type, `contact_inType_or_outType`), so `e α₁·(v − P) = 0`, i.e. `sin(α₁ − α) = 0`, and one of the two horns lies along `e α`.
- `e_eq_or_of_two_horns`: when `c` has exactly two sectors at `v`, horns along `α₀` and `α₀ + π`, any `c`-horn at `v` lies along one of them (three members
  of a two-element set, the two distinct by their cones; a horn's cone is its axis: `mem_coneAt_hornSet`, `e_eq_of_mem_coneAt_hornSet`).
- `stuck_step`: `stuck_structure` at `w`, the given horn's axis is `α₀` or `α₀ + π`, so `w + e(α + π/2)` is `N` (colour `h`, clause (iv)) or `S′` (colour `g`, its
  mirror), and `stuck_neighbour` applies. `stuck_flip`: a horn along `e(α + π)` of the same colour, from the other horn.
- `stuck_chain`: the invariant "stuck, with a horn along `e α` of a colour with at least two sectors" goes up by `stuck_step` and down by
  `stuck_flip` → `stuck_step` at `α + π` → `stuck_flip`; `Int.induction_on`.

**Build of this stage**: `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build: OK — 444 of 444 batches, 2 module(s)
rebuilt, 3 module(s) with warnings, 8m38s", exit 0 (`build/gate/build/20261004T195447Z-1915995.log`; driver log `data/fs131/ic/build-ic2-stage5.log`). 29
distinct `declaration uses sorry` warnings — `Contact` 5 (lines 1628, 1667, 1681, 1697, 1713: `flank_shadows`, `exists_shave`, `exists_rayMerge`,
`exists_merge`, `stuck_structure`), `UnitArc` 17 and `BaseSteps` 7 (I4h's, as given) — and no other warning or error (the one `error:` line is the
driver's `lake build --no-build` probe, "target is out-of-date"). Nothing was edited while it ran. **Axioms** against its oleans (`lake env lean
data/fs131/ic/AxiomsIC2.lean`, `pp.fullNames`; output `data/fs131/ic/axioms-ic2-stage5.txt`; not a gate log): all 77 theorems of `Contact`; 67 read
`[propext, Classical.choice, Quot.sound]`; 10 read `sorryAx` besides — the five leaves, `shaveAvailable_of_not_doublyShadowed` (through `flank_shadows`), and
`stuck_neighbour`, `stuck_flip`, `stuck_step`, `stuck_chain` (through `stuck_structure`). **Records**: `tools/fs131_ic2_addrecords.py` (new; IC1's tool with its own
block, headed "FS131-IC2", in `scripts/Axioms.lean`): 77 names, 12 added, `--check` exit 0; negative control `--plant --check` exit 1 (watched).
`tools/check_architecture.py`: PASS (no import changed). Names checked against `fs131-w4` (at `ac042f25`), `fs131-w5`, `fs131-w5b` and `main`: no collision.

**Re-pricing** (from this job's first leaf): `stuck_chain` over `stuck_structure` took about 45k of work (IC1's "M over 5" held); the reading of the wave's
API and the derivation cost more than the proof. The five left are each about a session, as IC1 priced them; nothing in this stage changes that.

**Findings for the successor** (route notes; no statement changes):
1. **`stuck_structure`'s "one horn per ray" needs SHAVE with `g = c`, not only RAY.** Two `c`-horns along one ray that share their bounding arc (an arc with
   `c` on both sides; the derivation deletes such arcs WLOG, the formal map need not) are not `RayAvailable` (it needs `κ₂ < κ₃` strictly). They are
   `ShaveAvailable` instead: the lower horn's upper flank is `c` (`IsFlankAbove v α κ₂ c` from the upper horn), its points are clear for `c` (a valid map), and
   `σ = κ₁` splits it into an all-upper part — provided the lower horn has *some* lower flank (`IsFlankBelow v α κ₁ h`). So the proof of (i) needs a child
   **`IsHorn.exists_flanks`**: a horn at a point of the domain has an upper and a lower flank colour. Route: in the chart at `v`, germs along `e α` with
   curvatures in `(κ₂, κ₂ + δ)` are absent for small `δ` (finitely many germs); germs along other directions stay a positive angle from `α + arcsin(m s/2)` for
   small `s`; so `hornSet v α κ₂ (κ₂ + δ) r` misses `Γ` for small `r`, lies in the domain, and is preconnected (`BranchGerms.isPreconnected_sector` on a two-germ
   chart, as `isPreconnected_hornSet_cusp` does), hence in one colour's class. The same child gives (ii)'s flanks `g_±`, `h_±`.
2. **`woodallCone_strict` gives the horn curvatures per radius** (`∀ᶠ r, ∀ S, ∃ κ₁ κ₂, S = hornSet …`); `IsHorn` needs them fixed. Through the chart they are:
   a `c`-coloured chart sector whose cone is one direction has `β i = nextβ i` (`IsSectorChart.cone`, `e_eq_of_mem_coneAt_hornSet`), so it is
   `hornSet v (β i) (κ i) (nextκ i) r` for every `r ≤ r₀` (`sectorBetween_eq_hornSet`), and comparing branch points (`tanHeight_branchPt`) with
   `woodallCone_strict`'s horn at one radius puts `κ i`, `nextκ i` in `(−1, 1)`. With finding 1 this is `stuck_structure`'s first seven clauses and its
   two out-type clauses (from `woodallCone_strict`), a sorry-free child I recommend stating first (`stuck_cone`).
3. `flank_shadows`, the three moves: IC1's Stage 2 list stands (items 1, 3, 4).

**What is left (5)**, in the order I would take it: `stuck_cone` (finding 2, over `IsHorn.exists_flanks`) → `flank_shadows` with N4-FLANK's mechanism as a child
(IC1's item 1) → `stuck_structure` over both (then `stuck_chain` and its three children are sorry-free) → the three moves (IC1's items 3–4; engine 2
`ringArcsWithin_of_Γ_subset` is still written nowhere — FS131-I4i on `fs131-w4` has it first on its list).

## Stage 6 — SAVED (FS131-IC2 stage 3): `shaveAvailable_of_adjacent_horns`; 5 `sorry` left in `Contact`, and the hand-back

**Added** (a child, no statement changed): `ArcMap.shaveAvailable_of_adjacent_horns` — Stage 5's finding 1 made a lemma: if the `c`-horn between `κ₁ < κ₂` has the
`c`-horn between `κ₂ < κ₃` directly above it and a lower flank `h`, SHAVE is available at `v` with upper flank `c` and `σ = κ₁` (the tip is `c`'s own class,
so clear for `c` in a valid map). With `IsHorn.exists_flanks` (Stage 5's finding 1, not yet written) it gives `stuck_structure`'s "one horn per ray" in the
adjacent case. Docstring notes added where the gate asks for a model: this lemma and `stuck_neighbour`, `stuck_flip`, `stuck_step` are steps inside proofs by
contradiction (N4-STUCK (i), N4-PROP), with no model expected, as `stuck_chain`'s own docstring says.

**Engine 2** (the coordinator's message during this stage): `ringArcsWithin_of_Γ_subset` is written on `fs131-w4` by FS131-I4i, commit `3f7ea033` (only
`Plane/ValidMap/Basic`, 112 added lines). Not written here. A successor whose moves need it before the merge brings that exact hunk onto this branch
(`git diff 3f7ea033~1 3f7ea033 -- Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean | git apply`, then build; commit by explicit path naming `3f7ea033`), so the two
copies are identical at the merge (inventory item 218 (g)).

**Build of this stage**: `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build: OK — 444 of 444 batches, 2 module(s)
rebuilt, 3 module(s) with warnings, 8m42s", exit 0 (`build/gate/build/20261004T200630Z-1991775.log`; driver log `data/fs131/ic/build-ic2-stage6.log`). 29
distinct `declaration uses sorry` warnings — `Contact` 5 (lines 1641, 1680, 1694, 1710, 1726: `flank_shadows`, `exists_shave`, `exists_rayMerge`,
`exists_merge`, `stuck_structure`), `UnitArc` 17 and `BaseSteps` 7 (I4h's, as given) — and no other warning or error. Nothing was edited while it ran.
**Axioms** against its oleans (`data/fs131/ic/AxiomsIC2.lean` → `data/fs131/ic/axioms-ic2-stage6.txt`, `pp.fullNames`; not a gate log): all 78 theorems of
`Contact`; 68 read `[propext, Classical.choice, Quot.sound]`; 10 read `sorryAx` besides (the five leaves; `shaveAvailable_of_not_doublyShadowed` through
`flank_shadows`; `stuck_neighbour`, `stuck_flip`, `stuck_step`, `stuck_chain` through `stuck_structure`). **Records**: `tools/fs131_ic2_addrecords.py` — 78
names, 1 added, `--check` exit 0.

**The hand-back.** Proved in this job (FS131-IC2): `stuck_chain` over `stuck_structure` (Contact 6 → 5 `sorry`), its three step children over the same, and 10
sorry-free children. **Left (5)**: `flank_shadows`, `exists_shave`, `exists_rayMerge`, `exists_merge`, `stuck_structure` — the order and what each needs is Stage 5's
"What is left" (with IC1's Stage 2 items 1, 3, 4). Branch `fs131-w4c` is ready for the merge into `fs131-w4` (my records in their own block headed "FS131-IC2"
in `scripts/Axioms.lean`, after IC1's; no import or `ARCHITECTURE.md` change in this job). I did not merge or run wave 4's gate.

## Stage 7 — SAVED (FS131-IC3 stage 1): the readback, the as-given build

Implementer: de Bruijn on Opus 5.5 (job FS131-IC3), resuming this record at its last SAVED stage (Stage 6, commit `95105d9b`; the report
`c7249cc7` follows it — `git log -- plans/FS131-IC-implementation.md` agrees). Brief `data/fs131/briefs/FS131-IC3-contact.md` (on `main`).

**The brief's four quotations against their sources** (standing rule 3):
1. "**It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the"
   — `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 14.2, line 887: **matches as a truncation** (this tree's copy is identical, `diff` empty).
2. "**What is left (5)**, in the order I would take it: `stuck_cone` (finding 2, over `IsHorn.exists_flanks`) → `flank_shadows` with N4-FLANK's mechanism as a
   child" — this record, Stage 5, line 246: **matches as a truncation**.
3. "1. **`stuck_structure`'s "one horn per ray" needs SHAVE with `g = c`, not only RAY.** Two `c`-horns along one ray that share their bounding arc (an arc with"
   — this record, Stage 5, line 231: **matches as a truncation**.
4. "194. **Ruling: wave 4 splits by file** (item 191's condition met: six leaves a session on wave 4's last two sessions, 39 left). Choice: the next wave-4
   implementer" — `plans/FS131-close-inventory.md` on `main`, line 1358: **matches as a truncation**.
No slip found in the brief.

**What I may change** (plan § 14.2, the brief's `touches`): add children anywhere in `Contact`, in a new module of my own (`Plane/ValidMap/ContactAux`,
imported by `Contact`) and in the foundation `Plane/ValidMap/Basic` (additions only, statements unchanged); engine 2 (`ringArcsWithin_of_Γ_subset`) only as
the exact hunk of `fs131-w4`'s `3f7ea033`, applied by `git apply`; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (my own block, headed
"FS131-IC3"), this record, `tools/fs131_ic_*.py`, `data/fs131/ic/`, `data/fs131/reports/FS131-IC3.md`. **What I may not change**: any statement of plan
§§ 3.2, 7.2 (the five leaves' hypotheses and conclusions; `stuck_structure`'s Condition 5 and three-colour hypotheses stay named hypotheses), any definition
of `Basic`, the read-back conventions; `UnitArc`, `BaseSteps`, `SVMap`, `StuckChain` (FS131-I4i's, on `fs131-w4`); no new `axiom`, no `native_decide`; no
merge into `fs131-w4`, no wave-4 gate, no push to `main`. A leaf that cannot be proved as written goes to Keryx at once (declaration, reason,
counterexample or missing hypothesis), and I go on with the others.

**The worktree as given** (`c7249cc7`, nothing edited): `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build:
OK — all 1744 modules already up to date, nothing built, 3 module(s) with warnings, 2s", exit 0 (`build/gate/build/20261004T202040Z-2089578.log`; driver
log `data/fs131/ic/build-ic3-readback.log`) — IC2's stage-6 oleans are current. 29 distinct `declaration uses sorry` warnings replayed: `Contact` 5
(lines 1641, 1680, 1694, 1710, 1726: `flank_shadows`, `exists_shave`, `exists_rayMerge`, `exists_merge`, `stuck_structure`), `UnitArc` 17 and `BaseSteps` 7
(as given on this branch; FS131-I4i's progress on `fs131-w4` is not merged here).

## Stage 8 — SAVED (FS131-IC3 stage 2): 44 sorry-free children — N4-FLANK's mechanism, a horn's chart sector and flanks, N4-STUCK (i); 5 `sorry` left in `Contact`

**No leaf closed; 44 children proved**, each `[propext, Classical.choice, Quot.sound]` (axioms below), no statement changed, no new axiom, no
`native_decide`. They are the first steps of `flank_shadows` and of `stuck_structure`, in the order IC2's Stage 5 recommended (`stuck_cone` and
`IsHorn.exists_flanks` first), plus the localization half of N4-FLANK, which both leaves read. Developed against the as-given oleans in
`data/fs131/ic/Scratch3.lean` … `Scratch6.lean` (iteration only; each checked with `lean`, a planted fault watched to fire), then moved into
`Contact` between `stuck_neighbour`'s block and `flank_shadows`.

**(a) N4-FLANK's mechanism: where a horn's shadow comes from** (27; section "N4-FLANK's mechanism", read against `plans/FS110-N-proof.md` § 2.2, N4-FLANK's
proof). The localization `ArcMap.shadow_source_near_poles`: for a colour `c ∈ P_cl(v)` with `e α ∈ D_c(v)`, a point `z` near `v` near the axis (`x > 0`,
`|y| ≤ ‖z − v‖²/2`) at unit distance from a point of `c`'s class sees it within `δ` of `N` or `S′` — the derivation's "for `w ≠ N, S′` the direction `+a` is
interior to `w`'s half-plane and N3-CLEAR clears a neighbourhood of `H`'s tip", proved by compactness of `cl(C_c) ∩ B̄(v, 2)` off the two poles' balls
(`IsCompact.eventually_forall_of_forall_eventually`), the contact step `shadow_local_contact` (in-type: `|z − y|² < 1`; out-type: `> 1`; two real lemmas
`shadow_ineq_in`, `shadow_ineq_out` carry the arithmetic, per `LEAN.md`'s heartbeat rule), and the triangle inequality off `ω(v)`. **Condition 5 is not used**
(no finiteness of contacts is needed). The pole on the flank's side is excluded by a vertical push: `exists_push_up` / `exists_push_down` (a horn point
pushed along `±n` by `t ∈ (0, 1)` lands in the flank band, by the intermediate value theorem on `tanHeight`), `dist_push_up_lt_one` /
`dist_push_down_lt_one` (the pushed point is nearer than `1` to a point near the pole that the horn point was at unit distance from), and
`false_of_pole` (N-E2: the pushed flank point, outside `B̄(N, 1)`, is far from every tile at `N`, yet nearer than `1` to one of its points):
`horn_not_shadowed_near_N` (upper flank `g`, `κ₂ < 1`) and its mirror `horn_not_shadowed_near_S` (lower flank `h`, `κ₁ > −1`) — the derivation's "out-type
`g` at `N` shadows an upward-closed set that must miss the flank sector, hence misses `H`". Together: `horn_shadow_near_S` (the `g`-shadow of the horn
near `v` comes from within any `δ` of `S′`) and `horn_shadow_near_N` (the `h`-shadow from near `N`). Corollaries `outType_S_of_shadow`,
`outType_N_of_shadow`: a flank colour shadowing horn points arbitrarily near `v` has an **out-type contact** at `S′` (for `g`) or `N` (for `h`); in-type is
excluded by N-E2 against a flank point outside `B̄(S′, 1)` (resp. `B̄(N, 1)`) and near `v` — the derivation's "in-type `g` at `N` or at `S′` would be Siamese
with the flank sector" and N4-STUCK (ii)'s first sentence, "Doubly shadowed gives an out-type `h_±`-tile at `N` and an out-type `g_±`-tile at `S′`".
Helpers: `abs_frameX_sub_le`, `abs_frameY_le_norm`, `abs_frameY_le_of_mem_hornSet`, `half_norm_le_frameX`, `abs_le_sq_of_near_axis`,
`hornSet_mono_radius`, `dot_e_sub_eq_frameX`, `norm_pos_of_frameX_pos`, `eq_N_or_S_of_frameX_eq_zero`, `exists_mem_hornSet_near`,
`IsFlankAbove.mem_coneAt`, `IsFlankBelow.mem_coneAt`.

**(b) A horn's chart sector and its flanks** (14; section "A horn's chart sector and its flanks"). `hornSet_curv_eq` (a horn determines its curvatures:
a branch point of an intermediate curvature separates two different horns; over `not_tanBelow_branchPt`, `not_tanAbove_branchPt`);
`IsHorn.exists_chart_index` (in any sector chart, a horn is the sector after a germ of direction `α` mod `2π` and curvature `κ₁` whose next germ has the
same direction and curvature `κ₂`: the sector's cone is the horn's single direction, so its two germs share it, `e_add_pi_ne` excluding the ball);
`IsSectorChart.index_of_isSector_hornSet` (the same from a horn that is a sector at one radius, with the chart sector equal to the horn at every radius
up to the chart's); `IsSectorChart.exists_col` (a chart sector lies in one colour's class at every radius); `IsSectorChart.exists_flank_after` /
`exists_flank_before` (above a germ, resp. below the germ after a sector, a thin horn lies in that sector's colour — the sector itself when the next germ
has the same direction, else a horn of curvature `κ ± 1` for small radii, by continuity of `arcsin` at `0`: `exists_abs_arcsin_lt`, `abs_half_lt`); and
**`IsHorn.exists_flankAbove`, `IsHorn.exists_flankBelow`** (IC2's finding 1: a horn at a point of the domain has an upper and a lower flank colour). And
**`woodallCone_isHorn`** (IC2's finding 2, the core of its `stuck_cone`): under `woodallCone_strict`'s hypotheses every `c`-sector at a small radius is
a horn with radius-independent curvatures in `(−1, 1)` — `IsHorn` — along `α` or `α + π`, with the two out-type contacts.

**(c) N4-STUCK (i)** (3; section the same). `IsSector.eq_of_mem` (two sectors sharing a point are one); `horn_unique_of_stuck` (two `c`-horns along one
direction where neither MERGE-RAY nor SHAVE is available have the same curvatures: a gap is MERGE-RAY, a shared bounding arc is SHAVE through
`shaveAvailable_of_adjacent_horns` over `IsHorn.exists_flankBelow`, an overlap is one sector); and **`stuck_horns`**, read against N4-STUCK (i) ("`int D_c(v) = ∅`
(no MERGE), so N3-DEG: out-type `c`-contacts at `N`, `S′`, all `c`-sectors horns along `±a` with curvatures in `(−1, 1)`; one per ray (no MERGE-RAY)") and
`stuck_structure`'s first seven clauses: at a stuck vertex with Condition 5 covering `B̄(v, 1)`, a colour with `m ≥ 2` sectors has exactly two, `IsHorn`s
along `α` and `α + π` with curvatures in `(−1, 1)`, `HasSectors v c 2`, and out-type `c`-contacts at `N` and `S′` (`stuck_structure`'s two out-type
`c`-clauses). **Same as the derivation's (i)**, without its doubly-shadowed clause (that is the next step, over `flank_shadows`).

**What is left (5), with the route** (my reading for the successor; none changes a statement):
1. **`stuck_structure`** over `stuck_horns` (horns `H₊` along `α`, `H₋` along `α + π`): (1) flanks by `IsHorn.exists_flankAbove/Below` — note that for
   `H₋` the frame is rotated by `π`, so its `IsFlankAbove v (α + π) κ₄` colour lies on the global `−n` side (the derivation's `h₋`) and its `IsFlankBelow`
   colour on the `+n` side (`g₋`), and `v + e(α + π + π/2) = S′`; (2) no flank colour is `c`: the flank band lies in a sector at `v` (a component of the interior
   points in a ball, `v` in its closure), which would be `H₊` or `H₋` by `stuck_horns`' count — not `H₊` (the band is above `κ₂`), not `H₋` (its directions
   tend to `α`, `H₋`'s to `α + π`: `e_eq_of_mem_coneAt_hornSet`); (3) no SHAVE and `shaveAvailable_of_not_doublyShadowed` (over `flank_shadows`) make each horn
   doubly shadowed; (4) a doubly shadowed band gives horn points arbitrarily near `v` in both shadows, so `outType_N_of_shadow` / `outType_S_of_shadow`
   give out-type `h₊` at `N`, `g₊` at `S′` (and for `H₋`, in its rotated frame, `h₋` at `S′`, `g₋` at `N`); (5) N3-CONF (`coneAt_subset_allowedCone`) puts
   all `h`-directions in `{d·n ≤ 0}`, `g`'s in `{d·n ≥ 0}`; then (ii)'s count with `h3` at `v` (`P_cl(v) = {c, g₊, h₊} = {c, g₋, h₋}`, `g₋ = h₊` excluded),
   degree 4 and the two sides' colours (the chart at `v`: `IsSectorChart.encard_sectors`, `hasDegree`); (6) (iii) from `D_g(v) ⊇ {d·n > 0}`; (7) (iv) at `N`
   and `S′`: the chart at `N`, the tangent out-type `h`-sectors `Q±` (from `flank_shadows`' mechanism at `N`, item 2 below), N-E1 for the ring colour `r`,
   `h3` at `N`; "`h` has two sectors at `N`" by the order of sectors at `N` (N4-STUCK (iv)'s last paragraph). About a session and a half; (iv) is most of it.
2. **`flank_shadows`** over the localization (`horn_shadow_near_S` / `_N`): if `S′ ∉ cl(C_g)`, the `g`-shadow near `v` is empty (`σ_g = κ₁`); if `S′` is a
   `g`-contact (out-type, `outType_S_of_shadow`'s in-type exclusion), the chart at `S′`: each out-type `g`-sector tangent to `+a` (upper germ of direction
   `α` mod `2π`, curvature `υ < 1`) shadows near `v` exactly `TanBelow v α (curvUp υ)` — `shadow_farSide_below` for its far side, plus the crossing: a unit
   circle meeting the far side crosses the `υ`-branch into the sector near the branch; non-tangent sectors shadow only points inside `B(S′, 1)`, which the
   horn misses (`κ₁ > −1`); `σ_g = max(κ₁, max_i curvUp υ_i)`, `≤ κ₂` by validity against the flank (a flank point below `curvUp υ_i` would be shadowed by
   its own colour). The mirror at `N` with `shadow_farSide_above`. About a session.
3. **`exists_shave`, `exists_rayMerge`, `exists_merge`**: IC1's Stage 2 items 3–4 stand (constructions of `F'`; the cut where `g = c` or `h = c` or in a merge
   gap; engine 2 from `3f7ea033`). A session each; untouched by this job.

**Hygiene notes.** Five pure-geometry children sit in the `ArcMap` namespace (`shadow_ineq_in`, `shadow_ineq_out`, `dot_e_sub_eq_frameX`,
`norm_pos_of_frameX_pos`, `eq_N_or_S_of_frameX_eq_zero`) and `exists_mem_hornSet_near`, `exists_abs_arcsin_lt`, `abs_half_lt` are general helpers: harmless,
movable in a cleanup. Two kills, both of this job's own build and by PID: the first while I believed it still waiting for its slot (it had been admitted
and stood at batch 26 of 444, before `Contact`), the second at batch 177 to fold in group (c); each forfeited only the walk, re-run in full below. A slip in
Stage 7's text (`UnitArc` 22) is corrected there to 17.

**Build of this stage**: `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build: OK — 444 of 444 batches, 2 module(s)
rebuilt, 3 module(s) with warnings, 8m36s", exit 0 (`build/gate/build/20261004T204837Z-2282147.log`; driver log `data/fs131/ic/build-ic3-stage8.log`). 29
distinct `declaration uses sorry` warnings — `Contact` 5 (`flank_shadows`, `exists_shave`, `exists_rayMerge`, `exists_merge`, `stuck_structure`), `UnitArc` 17,
`BaseSteps` 7 (as given) — and no other warning or error (the one `error:` line is the driver's `lake build --no-build` probe). Nothing was edited while it
ran. **Axioms** against its oleans (`lake env lean data/fs131/ic/AxiomsIC3.lean`, `pp.fullNames`; output `data/fs131/ic/axioms-ic3-stage8.txt`; not a gate
log): all 122 theorems of `Contact`; 112 read `[propext, Classical.choice, Quot.sound]` — among them the 44 of this stage; 10 read `sorryAx` besides (the
five leaves; `shaveAvailable_of_not_doublyShadowed` through `flank_shadows`; `stuck_neighbour`, `stuck_flip`, `stuck_step`, `stuck_chain` through
`stuck_structure`). **Records**: `tools/fs131_ic3_addrecords.py` (new; IC2's tool, its own block headed "FS131-IC3" in `scripts/Axioms.lean`): 122 names, 44
added, `--check` exit 0; negative control `--plant --check` exit 1 (watched). `tools/check_architecture.py` not re-run: no import or module changed.
Names checked against `fs131-w4`, `fs131-w5` and `main`: no collision.

**Re-pricing** (from this job's work): the localization and the chart children took about 60k and 45k of work; `stuck_horns` about 15k over them. The reading
of the derivation and the API cost as much as the proofs, as for IC1 and IC2. `stuck_structure` is now about a session and a half (its (iv) is most of it),
`flank_shadows` about a session, the three moves a session each — 4.5 to 5 sessions for the five leaves.

## Stage 9 — SAVED (FS131-IC3 stage 3): the hand-back

**Proved in this job (FS131-IC3)**: 44 sorry-free children of `flank_shadows` and `stuck_structure` (Stage 8), among them `stuck_horns` (N4-STUCK (i)),
`woodallCone_isHorn`, `IsHorn.exists_flankAbove` / `exists_flankBelow`, `horn_unique_of_stuck`, and N4-FLANK's localization with its out-type corollaries.
**No leaf closed. Left (5)**: `stuck_structure`, `flank_shadows`, `exists_shave`, `exists_rayMerge`, `exists_merge` — the route and price of each is Stage 8's
"What is left" (with IC1's Stage 2 items 3–4 for the moves). The build log and the axioms print against its oleans are Stage 8's
(`build/gate/build/20261004T204837Z-2282147.log`, `data/fs131/ic/axioms-ic3-stage8.txt`). Branch `fs131-w4c` is ready for the merge into `fs131-w4`
(records in their own block headed "FS131-IC3" in `scripts/Axioms.lean`, after IC2's; no import, module or `ARCHITECTURE.md` change in this job). I did not
merge or run wave 4's gate. `data/fs131/ic/Scratch3.lean` … `Scratch6.lean` are iteration copies, superseded by `Contact` (they redeclare its new names, so
they no longer elaborate against it; nothing builds them).

## Stage 10 — SAVED (FS131-IC4 stage 1): the readback, the as-given build

Implementer: de Bruijn on Opus 5.5 (job FS131-IC4), resuming this record at its last SAVED stage (Stage 9, commit `923c8ad6`; `git log --
plans/FS131-IC-implementation.md` agrees). Brief `data/fs131/briefs/FS131-IC4-contact.md` (on `main`).

**The brief's four quotations against their sources** (standing rule 3):
1. "**It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the"
   — `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 14.2, line 887: **matches as a truncation** (this tree's copy identical, `diff` empty).
2. "**What is left (5), with the route** (my reading for the successor; none changes a statement):" — this record, Stage 8, line 364: **matches**.
3. "236. **Ruling: `Contact` splits once more, when a slot frees** — the three moves (`exists_shave`, `exists_rayMerge`, `exists_merge`) to a parallel implementer in a"
   — `plans/FS131-close-inventory.md` on `main`, line 1692: **matches as a truncation**.
4. "194. **Ruling: wave 4 splits by file** (item 191's condition met: six leaves a session on wave 4's last two sessions, 39 left). Choice: the next wave-4
   implementer" — `plans/FS131-close-inventory.md` on `main`, line 1358: **matches as a truncation**.
No slip found in the brief.

**What I may change** (plan § 14.2, the brief's `touches`): add children anywhere in `Contact`, in a new module of my own (`Plane/ValidMap/ContactAux`,
imported by `Contact`) and in the foundation `Plane/ValidMap/Basic` (additions only, statements unchanged); engine 2 only as the exact hunk of `fs131-w4`'s
`3f7ea033`; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (my own block, headed "FS131-IC4"), this record, `tools/fs131_ic_*.py`, `data/fs131/ic/`,
`data/fs131/reports/FS131-IC4.md`. **What I may not change**: any statement of plan §§ 3.2, 7.2 (the five leaves' hypotheses and conclusions;
`stuck_structure`'s Condition 5 and three-colour hypotheses stay named hypotheses), any definition of `Basic`, the read-back conventions; `UnitArc`,
`BaseSteps`, `SVMap`, `StuckChain` (FS131-I4i's, on `fs131-w4`); no new `axiom`, no `native_decide`; no merge into `fs131-w4`, no wave-4 gate, no push to
`main`. The moves (`exists_shave`, `exists_rayMerge`, `exists_merge`) only after `stuck_structure` and `flank_shadows`, and only if no parallel implementer has
taken them (item 236). A leaf that cannot be proved as written goes to Keryx at once, and I go on with the others.

**The worktree as given** (`923c8ad6`, nothing edited): `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build: OK —
all 1744 modules already up to date, nothing built, 3 module(s) with warnings, 2s", exit 0 (`build/gate/build/20261004T210229Z-2389715.log`; driver log
`data/fs131/ic/build-ic4-readback.log`) — IC3's stage-8 oleans are current. 29 `declaration uses sorry` warnings replayed: `Contact` 5 (lines 2743, 2782,
2796, 2812, 2828: `flank_shadows`, `exists_shave`, `exists_rayMerge`, `exists_merge`, `stuck_structure`), `UnitArc` 17, `BaseSteps` 7 (as given on this branch).
