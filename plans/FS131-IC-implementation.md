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
