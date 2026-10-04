# FS131-K4 — wave 4's kernel plan: valid maps (contact types, Woodall's merge, shadows, the unit-arc calculus, the base's steps, S–V maps)

*De Bruijn, the planner (Opus 5.5), job FS131-K4, brief `data/fs131/briefs/FS131-K4-wave4.md`. Branch `fs131-w4` in the worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4`, from `05cb0a3e` (wave 3's skeleton). Nothing in this milestone is blind
(`plans/FS131-close-inventory.md` § Rulings in force, ruling 1).*

*Continued by FS131-K4b (de Bruijn, the planner, Opus 5.5; brief `data/fs131/briefs/FS131-K4b-wave4.md`) from `d0c56af0`: stages 1–5 below are
K4's; K4b's stages are numbered on from them (K4b's stage 1 is Stage 6, and so on), so every stage number in this record is unique.*

## Theorems this phase proved

None (a planning job: definitions, spec examples and a skeleton; no row is proved here).

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation in the brief | source | result |
|---|---|---|
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors | **matches**, a prefix of the source sentence run (the source continues "Your predecessor formalized …") |
| "3. **States every row at the class its argument reads** (G92), reports each widening to Keryx as a generalization, and reads each statement back in" | `plans/FS131-kernel-plan.md` § 7.3 item 3 | **matches as a truncation**: the source item ends "… reads each statement back in its record against the row." — the brief cuts mid-sentence; nothing is changed |
| items 7 and 8 of `plans/FS112-derivation.md`'s errata section, "which `plans/LEAN-BACKLOG.md` quotes … at the top" | `plans/LEAN-BACKLOG.md` lines 13–19 | **matches**: both items quoted under "Notes of `plans/FS112-derivation.md`'s errata section that name no entry" |
| the 29 rows, the two merged rows, the three R9 rows, C116 on FS112-C-DOUBLE | `data/fs131/k1/dispositions.csv` (wave 4, *formalize*) | **matches**: 29 formalize rows in the five modules the opening plan names, FS112-BEND → FS112-N2-BENDS, FS114-L60-WALK → FS114-L60-LE, `ruling = Y` on FS106-WO, FS106-TW, FS112-N2-RAY (and FS114-L60-WALK, R8), C116's reason on FS112-C-DOUBLE |

### 1.2 The rows, quoted

`data/fs131/k4/rows.md` holds each of the 31 rows' whole backlog section byte for byte, written by `tools/fs131_k4_rows.py`
(`--check`: OK, 29 rows, 2 merged; `--plant`, one character inserted into a quoted line of FS110-N3-CONF's section: FIRED). The rulings that
govern the rows (`plans/FS131-kernel-plan.md` § 4.3, ruled by Keryx): **R8** — FS114-L60-WALK's content is checked when its consumers (FS112-N2-RED,
-N3-COR3, -N3-BASE, -N3-DENSE3, FS114-CV-EXISTS: all wave 5) are stated over L60-LE's non-strict bound; its one mathematical clause, L60-D5 ("in N3-BASE's
setting, the two ends of a circle-to-circle path (CB D5 item 1) are less than 1 apart"), lives in N3-BASE's setting and is carried to wave 5 with it
(§ 1.4). **R9** — FS106-WO, FS106-TW, FS112-N2-RAY are formalized without their verdict clauses. **C116** — FS112-C-DOUBLE with its errata: item 3
of `plans/FS112-derivation.md`'s errata section (a regrade, two minds) is the only note filed under it, and it changes no word of the statement.

### 1.3 The worktree builds as given

`./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`), driver log `data/fs131/k4/build-stage1.log`: **OK — 440 of 440
batches, 10 modules rebuilt, 6 modules with warnings** (exactly wave 3's six skeleton modules, their `sorry` warnings), 8 m 18 s, exit 0
(`build/gate/build/20261004T065051Z-1749837.log` in the worktree).

### 1.4 What the rows' words need that wave 3 does not give (read before the foundation)

The derivations' vocabulary for this wave, with its source: the **frame** at `v` (`a` a direction, `n ⊥ a`, `N = v + n`, `S′ = v − n`, `P_k = v + kn`,
upward curvature of an arc tangent to `a` at `P_j`) and **shadow** `Sh(T) = {z : ω(z) ∩ T ≠ ∅}` (`plans/FS110-N-proof.md` N4-2 setting); **contacts**,
**in-type/out-type**, `D_c(v) = ⋂_in {d·e_w ≥ 0} ∩ ⋂_out {d·e_w ≤ 0}`, **clear** (N3 table, N3-2 frame); **sectors**, `s_c(v)`, `Φ(v)`, **cusp horns**
(`{κ₁x²/2 < y < κ₂x²/2, x > 0}` to second order, N3-2 frame), **Woodall's cone** (N3-DEG); MERGE, MERGE-RAY, SHAVE, **terminal**, **stuck** (N4-2
§§ 2.2–2.5); the FS-112 **contact kinds** in/out/both/inert of a unit arc, **(Q)**, **(R2)**, `R₂(ᾱ)` (`data/fs112/claims.md` § 0; FS112 derivation
header); **cubic trichromatic**, **repeated colour**, **leaving centre**, **M-in**, CB's **D2 strip** (FS-112 N3 records); S–V's **map-type colouring**
(Conditions 2–6, `data/fs106/claims.md` § 0 D-SV, D-AEMAP) and **chromaticity** (D-VMC); Townsend's **finitely disconnected unit annulus**
(`plans/FS106-V-verification.md` V3 stage 1, Definition 2).

### 1.5 Registered before the definitions

- The likeliest statement defects (opening plan § 7.3 item 2): "sector" and "degree" at a cusp. Expectation: none is a defect once a sector is a
  component of `B(v, r) ∖ Γ` with `v` in its closure, counted for all small `r`; a cusp horn is then one sector, as the rows read it. p ≈ 0.7.
- FS110's rows were derived under Condition 5; FS112-WALK (`plans/FS112-derivation.md` l. 35) says N3-CONF, W-MERGE, N4-RAY and N4-FIN hold as
  written with unit arcs. Expectation: N3-CONF states without Condition 5 (a widening to report); W-MERGE needs Condition 5 only to keep it. p ≈ 0.6.

## Stage 2 — SAVED: the foundation (`debruijn-domain-modeling`, invoked fresh)

### 2.1 The model, and why this shape

One module, `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` (over wave 3's `Plane/LocalStructure`), sorry-free, every definition a
predicate or a set on the one `ArcMap` structure (extrinsic placement, as the foundation of stage 5 of the opening plan):

| group | definitions | the modeling decision |
|---|---|---|
| frame, curvature | `frameX`, `frameY`, `framePt`, `tanHeight`, `TanAbove`, `TanBelow`, `curvDown` (`f`), `curvUp` (`f̃`) | **exact, not second order**: every boundary arc is a circle or a line, so "above the arc tangent to `a` at `v` with upward curvature `κ`" is the sign of `y − κ(x² + y²)/2` in the frame. The rows' `ω(N)` and `ω(S′)` are curvatures `1` and `−1`; `N = v + e(α + π/2)` |
| horns | `hornSet v α κ₁ κ₂ r`, `IsHorn`, `IsFlankAbove`, `IsFlankBelow` | a horn is the exact region between two tangent arcs, and `IsHorn` says that region **is a sector** for all small `r` — so the bounding curvatures are data of the horn, never recovered from a limit; flanks are the colours of the thin horn sets just outside |
| sectors | `IsSector`, `sectorsOf`, `HasSectors`, `HasDegree`, `HasRepeatedColour`, `IsCubicTrichromatic` | a sector is a component of `interiorPts ∩ B(v, r)` with `v` in its closure, counted **for all small `r`** (`∀ᶠ r in 𝓝[>] 0`) and **with `encard`**: infinitely many sectors never count as `0`. A cusp horn is one sector (the opening plan's § 7.3 item 2: the expected defect at a cusp does not arise — registered p ≈ 0.7, scored: none) |
| contacts | `IsContact`, `InType`, `OutType`, `dot`, `allowedCone` | `D_c(v)` as the set of **vectors** satisfying every contact's half-plane — a closed convex cone whose `interior` (in `ℂ`) is the rows' `int D_c(v)`; directions enter through wave 3's `coneAt` (`e β ∈ D_c(v)`) |
| shadows, clear | `shadow T = {z : ∃ y ∈ T, dist z y = 1}`, `IsClear c z` | the derivation's own `Sh(T) = {z : ω(z) ∩ T ≠ ∅}`; clear for `c` is "at distance `≠ 1` from every point of `c`'s class" (FS-110's "clear", class form) |
| the moves | `MergeAvailable`, `RayAvailable`, `ShaveAvailable`, `DoublyShadowed`, `TerminalOn U`, `Terminal`, `IsStuck` | **preconditions, not operations**: MERGE is "a colour with `≥ 2` sectors and `int D_c(v) ≠ ∅`" (N4-STUCK (i) reads "no MERGE" exactly so); MERGE-RAY "two horns of one colour on one ray"; SHAVE **semantically** — the tip splits along a tangent arc into a part clear for each flank (the rows' "`σ_g ≤ σ_h`" is then a theorem, `flank_shadows`, not a definition); doubly shadowed is a band of the horn in both flanks' shadows. `TerminalOn U` lets a fragment be terminal near its named points (FS112-BOWTIE's form) |
| unit arcs | `InContact`, `OutContact`, `BothKind`, `Inert`, `radiusTwoArc`, `IsR2Arc` | over wave 3's `IsRingArc` (constant sides, point-set): FS-112's four contact kinds read off `P_cl` of the centre; (R2) with the inner colour's class holding the whole radius-2 arc in its closure |
| classes | `Condition5`, `InMK K` | Condition 5 read on the arcs inside the domain (finitely many points on every unit circle); `𝓜_K` without periodicity (radii `≥ 1/K`, `≤ K` arcs per unit disc, by `encard`) |

The incidental structure refused: a combinatorial notion of vertex or edge (the rows never need one — a vertex of four colours is
`4 ≤ ncard (coloursAt v)`, a repeated colour is two sectors); second-order models of horns (the arcs are exact circles); the
operations as functions on maps (each row that performs one states the existence of the modified map with its properties); a separate
mirror vocabulary (the mirror at `S′` is the same predicates with `TanBelow` and `v − n`).

**The pass's findings** (the skill's seams): (a) the `±a` mirror is a reflection, not a rotation — the horn along `α + π` in its own frame
has `n` reversed, so `N` and `S′` swap and curvatures negate; rows stating both sides state both (`shadow_farSide_above`/`_below`,
`woodallCone`'s `{α, α + π}`), and the implementer should prove one side and transport by a child `ArcMap.reflect` (conjugation in the
frame) rather than duplicate proofs. (b) The unsampled member: a valid map with a horn exists only through FS112-BOWTIE (a row of this
wave, not yet stated) — so `IsHorn`, `IsStuck` and `TerminalOn` have no inhabitant in the foundation; it is scheduled (§ 5). (c) The
adversary: `MergeAvailable` is true at two adjacent sectors of one colour across an arc with that colour on both sides — consistent with
the derivation, which deletes such arcs without loss (FS-110 N4-2 setting), and harmless (a merge there is an arc deletion).

### 2.2 The definitions the derivations never fixed: the choice, the alternatives, the rows each would change

| term | chosen | alternatives | rows whose statement would change |
|---|---|---|---|
| sector, degree | components of `interiorPts ∩ B(v, r)` with `v` in the closure, for all small `r`, `encard` | a germ quotient of sets | none: equivalent for locally finite arc maps |
| SHAVE available | semantic (a tangent split clear for each flank) | FS-110's `σ_g ≤ σ_h` from the flank tiles' arcs | N4-SHAVE: under the alternative, "unless doubly shadowed" is a definition-chase; here it is `shaveAvailable_of_not_doublyShadowed`, which carries N4-FLANK's content |
| terminal | no move's precondition anywhere (`TerminalOn univ`) | the limit `M*` of N4-TERM | none in wave 4; N4-TERM (wave 5) builds `M*` and proves it `Terminal` |
| clear | distance `≠ 1` from `c`'s class | from `c`'s tiles | none (the class is the union of its tiles) |

None changes what a row says, so no message was owed under the brief's § What is yours to decide.

### 2.3 Validation and the gate on this commit

Spec examples (each fails if its definition drifts): `frameX 0 0 3 = 3`, `frameY 0 0 i = 1`; `ω(N)` and `ω(S′)` as curvatures `±1`
(`tanHeight 1 0 2 = 0`, `tanHeight (−1) 0 (−2) = 0`); `1/4 ∈ hornSet 0 0 (−1) 1 1` and **adversary** `1/4 ∉ hornSet 0 0 0 1 1` (the horn is
open at its arcs); `f(1) = 1/2`, `f̃(1/2) = 1`; `1 ∈ shadow {0}`, **adversary** `1/2 ∉ shadow {0}`; `const_isSector_ball` (an inhabitant of
`IsSector`) and **adversary** `const_not_isSector_far`; Condition 5 and `𝓜_0` on the one-colour plane; a contact on the one-colour plane.

`./scripts/build.sh` (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 440 of 440 batches, 2 modules rebuilt** (`Plane/ValidMap/Basic`, `Proofs`),
**6 modules with warnings — wave 3's six skeleton modules only**, `Basic` with none, 8 m 21 s, exit 0 (`build/gate/build/20261004T070122Z-1807048.log`;
driver log `data/fs131/k4/build-stage2.log`). `tools/check_architecture.py`: PASS, exit 0. `scripts/Axioms.lean`: section "FS-131 wave 4 (job
FS131-K4) — the foundation" (the two theorems). Iteration used `lake env lean` with `-DautoImplicit=false -DrelaxedAutoImplicit=false`; the
evidence is the build.

## Stage 3 — SAVED (partial): the skeleton and the read-backs, 9 of 29 rows

### 3.1 The skeleton

| module | rows | theorems (all `sorry`) |
|---|---|---|
| `Plane/StuckChain` | FS110-N4-FIN, FS112-N2-RAY (R9) | 5 |
| `Plane/ValidMap/Contact` | FS110-N3-CONF, -N3-DEG, -N4-SHADOW, -N4-SHAVE, -N4-STUCK, -W-MERGE | 16 |
| `Plane/ValidMap/UnitArc` | FS112-LOCK, FS112-N3-NOBOTH (laid out here, not in `BaseSteps`), FS114-L60-LE (first clause), FS112-N2-BENDS (N2-SIGN only) | 4 |

25 records in `scripts/Axioms.lean` (section "FS-131 wave 4 (job FS131-K4) — the skeleton"), listed and checked by `tools/fs131_k4_decls.py`
(`--check`: 25 names, 0 missing; `--plant`, namespaces dropped: FIRED, 25 missing). The build of this stage: § 3.4.

### 3.2 The read-backs (each formal statement against its row, `data/fs131/k4/rows.md`)

Conventions read once: "valid map" is `F : ArcMap k` with `F.Valid`, at any `k` (no row stated here reads six colours, except through a
named hypothesis); "near `v`" is `F.Covers v 1` (`covers_one_iff`: a closed disc of radius above `1`); "a `c`-tile at `w`" in a hypothesis or
a clearance is the class of `c` (wave 3's convention); the frame is `a = e α`, `n = e(α + π/2)`, `N = v + n`, `S′ = v − n`.

| row | declarations | read-back |
|---|---|---|
| **FS110-N4-FIN** | `n4_fin` | Row: "No bi-infinite sequence `−1 < λ_k < υ_k < 1` with `λ_k ≤ f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`." Formal: `¬ ∃ l u : ℤ → ℝ, ∀ k, −1 < l k ∧ l k < u k ∧ u k < 1 ∧ l k ≤ curvDown (l (k+1)) ∧ curvUp (u (k−1)) ≤ u k`. **Same.** (`curvUp_curvDown`, the bookkeeping `f̃ = f⁻¹`, is N4-SHADOW's clause, stated here beside its consumer) |
| **FS112-N2-RAY** (R9) | `rayLower`, `ray_chain`, `exists_oneSided_chain`, `rayLower_pencil` | Row (mathematics only, R9): the one-sided chain `λ_k = −1/(k+1)`, `υ_k = 0` is consistent with N4-FIN, every shadow tight; N4-CONE's step fails there; the pencil of circles of radius `k + 1` about `P_{−1}`. Formal: `ray_chain` — `λ_0 = −1`, `−1 < λ_k < 0` for `k ≥ 1`, `λ_k = f(λ_{k+1})` (tight), `f̃(0) = 0`; `exists_oneSided_chain` — a sequence on `ℕ` meeting all of FIN's inequalities with `−1 < λ` past its end (so FIN's contradiction needs the bi-infinite index: "N4-CONE's step fails"); `rayLower_pencil` — in the frame at `P_k`, the arc of curvature `λ_k` is the circle `dist z (v − n) = k + 1`. "Straight upper arcs" is `υ_k = 0`. The verdict "N4-CONE is a GAP" is dropped (R9). **Same, R9's form** |
| **FS110-N3-CONF** | `contact_inType_or_outType`, `coneAt_subset_allowedCone`, `clear_of_subset_interior_allowedCone`, `lens_dist_lt_one_of_up`, `lune_dist_le_of_up` | Row: contacts on `ω(v)` are in- or out-type; directions of `c`-sectors lie in `D_c(v)`; compact sets inside `int D_c(v)` are clear near `v`; tangent in- and out-contacts are upward closed. Formal: (i) in or out, and not both (covering `B̄(v, 1)` so a tile exists at `w` and at `v`); (ii) every direction of `c`'s class at `v` (the union of its sectors' cones) in `D_c(v)`; (iii) a compact `Λ` with `e '' Λ ⊆ int D_c(v)` gives `ρ` with `v + t e(β)` clear for `0 < t < ρ`; (iv) the two exact facts the proof of N3-UP is (checks C1, C2): moving a point near `v` toward `+n` keeps it within `1` of every lens point `B(v, 1) ∩ B̄(N, 1)` it was within `1` of, and moves it away from every lune point `B̄(S′, 1) ∖ B(v, 1)`. An in-type tile at `N` lies in the lens (in-type and diameter `≤ 1`) and all its distances from a `c`-sector point are below `1` (Siamese, N-E2), an out-type tile at `S′` in the lune: so "upward closed" is (iv) applied to them. **No Condition 5** (FS112-WALK: N3-CONF holds as written with unit arcs; the row's "finitely many" contacts is in its proof, not its statement). **Same, widened to unit arcs** |
| **FS110-N3-DEG** | `woodallCone`, `woodallCone_strict` | Row: `int D_c(v)` empty only in Woodall's cone: out-type `c`-contacts at both `v ± n`, every `c`-sector a cusp horn along `±a` with bounding curvatures in `(−1, 1)`. Formal: `woodallCone_strict` (Condition 5) — some axis `α` with out-type contacts at `v ± n` and, for all small `r`, every `c`-sector equal to `hornSet v β κ₁ κ₂ r`, `β ∈ {α, α + π}`, `−1 < κ₁ < κ₂ < 1`: **same**. `woodallCone` — the same with no Condition 5 and `−1 ≤ κ₁ < κ₂ ≤ 1` (the proof's own non-strict step, N3 § 2.3: "strictly by Condition 5"): **a widening** |
| **FS110-N4-SHADOW** | `farSideAbove`, `farSideBelow`, `shadow_farSide_above`, `shadow_farSide_below`, `curvUp_curvDown` (in `StuckChain`), `flank_shadows` | Row: the shadow near `v` of a tile at `N` beyond an arc tangent to `a` at `N` is one side of the circle through `v` concentric with that arc; `f` going down, `f̃` going up; a horn is shadowed by its flanks only through out-type tiles at `S′` and `N` tangent to `a` (N4-FLANK). Formal: the shadow of the far side of the arc (curvature `μ > −1`, the out-type condition) near `N` on the `+a` side is, near `v` on the `+a` side, exactly `TanAbove v α (f μ)` — and the mirror at `S′` with `f̃` (`υ < 1`). The row's tile enters only through its part near `N`, which is that far side, so the statement is about the set itself (**stronger**: no tile, no validity). N4-FLANK as its semantic content: the horn's points near `v` in the `g`-class's shadow are those below a tangent circle of curvature `σ_g ∈ [κ₁, κ₂]`, in the `h`-class's shadow those above one of curvature `σ_h ∈ [κ₁, κ₂]` (Condition 5, curvatures in `(−1, 1)`, as filed). "Only through out-type tiles at `S′` and `N` tangent to `a`" is the proof's mechanism, not stated (the semantic form is what SHAVE and STUCK consume). **Same in content; the mechanism clause left to the proof** |
| **FS110-N4-SHAVE** | `shaveAvailable_of_not_doublyShadowed`, `exists_shave`, `exists_rayMerge` | Row: a horn tip can be recoloured by its two flank colours, valid and keeping Condition 5, unless doubly shadowed; two horns of one colour on one ray merge. Formal: not doubly shadowed ⟹ SHAVE available; SHAVE's split ⟹ a valid map with Condition 5, equal to `F` off `B̄(v, ρ)`, `c` with one sector fewer at `v`, no colour added at `v`, at most three colours on the rim; two `c`-horns on one ray ⟹ the region between is `c`-clear near `v` and the merge gives the same kind of map. **Same** |
| **FS110-N4-STUCK** | `stuck_structure`, `stuck_chain` | Row: at a vertex admitting no move, a two-sector colour has exactly two horns `±a`, degree 4, `P_cl(N) = {c, h, r}`, `P_cl(S′) = {c, g, r′}` with double sectors; in a terminal map a stuck vertex forces stuck vertices at unit spacing along the normal line, bi-infinite. Formal: N4-STUCK (i)–(iv) in full (horns with curvatures in `(−1, 1)`, `s_c = 2`, degree 4, `P_cl(v) = {c, g, h}`, the two sides' colours, the contacts of `g`, `h`, `c`, `P_cl(N)`, `P_cl(S′)`, two sectors of `h` at `N` and of `g` at `S′`); N4-PROP for a terminal valid plane map: `IsStuck (v + j n)` for every `j ∈ ℤ`. **NB-4 replaced by its use**: the proof reads FS110-NB-4 (`≤ 3` colours at every point, Condition 5) only at points of `B̄(v, 1)` (at `v`, `N`, `S′`), so `stuck_structure` assumes "at most three colours on `B̄(v, 1)`" and `stuck_chain` "at most three colours everywhere" — FS110-NB-4 is **not a backlog row** (finding F-NB4, § 3.3). `F.Covers v 2` (the argument reads tiles at `N`, `S′` and their sectors). **Same, over NB-4's conclusion as a hypothesis** |
| **FS110-W-MERGE** | `exists_merge` | Row: if `int D_c(v)` is nonempty, two non-adjacent `c`-sectors are joined by recolouring the gap inside `D_c(v)` near `v`; validity and Condition 5 kept, types only shrink. Formal: `c` with `n + 1 ≥ 2` sectors and `int D_c(v) ≠ ∅` ⟹ a valid map equal to `F` off `B̄(v, ρ)` with `s_c(v) = n`, Condition 5 kept if `F` has it (not assumed: FS112-WALK), no point off the rim gaining a colour, the rim's new points with at most three colours and none repeated, and `D_c(v′)` unchanged off `B̄(v, ρ)`. "Non-adjacent" is not a hypothesis: adjacent sectors of one colour are joined by deleting their common arc, so the formal statement covers both. **Same, widened to unit arcs** |
| **FS112-LOCK** | `lock` | Row: for `w` interior to a unit arc `α ⊂ ω(P)`, a tile of either side colour touches `ω(w)` only at `P`, or — the inner colour only — at `P + 2e_w`, from outside `B(P, 2)`. Formal: the outer class's closure meets `ω(w)` in `⊆ {P}`, the inner class's in `⊆ {P, P + 2e(θ)}`, and an inner tile touching at `P + 2e(θ)` misses `B(P, 2)` (class form for the touching sets: **stronger**). **Same** |
| **FS112-N2-BENDS** (lemma) | `n2_sign` | N2-SIGN: "every point `≠ P` of a side-colour tile is within `< 1` of all of `int α` or `> 1` from all of it", for open-tile points (NB2-SIGN's precision). Formal: `z` in a side colour's class (interior points; `z ≠ P` is automatic where it matters, and the formal statement needs no such hypothesis). **Same, stronger** — the bends themselves are § 5 |
| **FS114-L60-LE** (first clause) | `l60_le` | L60-LE: "a unit arc with constant sides has `ℓ ≤ 60°`". Formal: `IsRingArc P θ₁ θ₂ c c' → θ₂ − θ₁ ≤ π/3`. **Same**; L60-EQ and L60-REAL are § 5. FS114-L60-WALK (merged, R8) is checked at wave 5 by stating its five consumers over this non-strict bound; its clause L60-D5 belongs to FS112-N3-BASE's setting (wave 5) and goes there |
| **FS112-N3-NOBOTH** | `noBoth` | Row: the centre of a both-kind unit arc is a vertex with at least four colours or a repeated colour. Formal: `BothKind P θ₁ θ₂`, `P ∈ F.dom` ⟹ `4 ≤ ncard (coloursAt P) ∨ HasRepeatedColour P`. `P ∈ F.dom` is the hypothesis wave 3 found FS116-V5-U1's last clauses need (its § 5.3), and the proof is "over FS112-U1"; the derivation's centres are always in the domain. **Same, with the domain hypothesis** |

### 3.3 Findings (sent to Keryx with this stage's commit)

- **F-NB4 (backlog completeness).** FS110-N4-STUCK's proof uses FS110-NB-4 (no four-colour vertex under Condition 5), which is not a backlog
  row; the formal N4-STUCK assumes NB-4's conclusion on `B̄(v, 1)` instead (the class its argument reads), so wave 4 does not need NB-4. The
  headline FS110-CLOSURE (if it is ever formalized) would.
- **G-CONF, G-MERGE (generalizations, FS112-WALK's).** N3-CONF and W-MERGE are stated with unit arcs allowed; W-MERGE keeps Condition 5 when
  given it.
- **G-DEG (generalization).** N3-DEG holds with unit arcs in its non-strict form (`woodallCone`, curvatures in `[−1, 1]`); the strict form is
  Condition 5's corollary.
- **G-SHADOW (generalization).** N4-SHADOW's concentric-circle clause is a statement about the far side of an arc, no tile and no map needed.
- **L60-D5** (R8's merged row) is a mathematical clause in FS112-N3-BASE's setting and is carried to wave 5 with N3-BASE.

### 3.4 The build of this stage

`./scripts/build.sh` (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 441 of 441 batches, 4 modules rebuilt, 9 modules with warnings** — wave 3's six
skeleton modules and this stage's three, every warning `declaration uses 'sorry'` (no other warning or error), 8 m 12 s, exit 0
(`build/gate/build/20261004T071131Z-1871759.log`; driver log `data/fs131/k4/build-stage3.log`).

## Stage 4 — SAVED (partial): the plan per stated leaf

*The `debruijn-obligation-modeling` pass is owed (not run in this session; the successor runs it fresh over the whole wave once all 29
rows are stated). Mathlib names below are to be confirmed with `#check` by the successor; none is cited here as confirmed.* E easy, M
moderate, H hard.

**`Plane/StuckChain`** — pure real arithmetic.
1. `curvUp_curvDown` — **E**: `field_simp` with `1 + l ≠ 0`, `1 − l/(1+l) = 1/(1+l)`.
2. `n4_fin` — **M**: N4 § 2.6 verbatim. If some `υ_m > 0`, then `υ_{m+j} > 0` and `1/υ_{m+j} ≤ 1/υ_m − j` (induction on `j`, from
   `υ_{k} ≥ f̃(υ_{k−1})` and `1/f̃(x) = 1/x − 1`), so `υ > 1` past `j > 1/υ_m − 1` — contradiction; so all `υ ≤ 0`, all `λ < 0`, and
   `1/λ_{m−j} ≥ 1/λ_m + j` downward gives `λ ≤ −1`. Children: `inv_curvUp`, `inv_curvDown`, the two inductions. Strictness `λ_k < υ_k` is used
   (NB4's plant: the constant `(0, 0)` survives without it).
3. `ray_chain`, `exists_oneSided_chain` — **E**: `field_simp`; `l = rayLower`, `u = 0`.
4. `rayLower_pencil` — **M**: expand `frameX`, `frameY` (`(z − P_k) conj(e α)` has norm `|z − P_k|`), `tanHeight κ x y = 0 ⟺ x² + (y − 1/κ)² =
   1/κ²`, and `P_k + n/κ = v − n` at `κ = −1/(k+1)`. Child: `frame_normSq : frameX² + frameY² = ‖z − v‖²`, the frame's reusable fact.

**`Plane/ValidMap/Contact`**
5. `shadow_farSide_above`, `_below` — **M–H**: N4 § 2.1. The far side's circle has centre `v + Cn`, `C = 1 + 1/μ` (`C > 1` or `C < 0`,
   `μ > −1`); `dist(z, far side) = |z − (v + Cn)| − (C − 1)` (or `(1 − C) − |…|`), `< 1` iff `z` inside/outside `Σ(C)` of curvature `f(μ)`;
   the far side is connected and has points beyond distance `1` from `z`, so distance exactly `1` is attained (connectedness of the polar
   region). The nearest point lies on the `+a` part of the arc (check C1's role). Children: `farSide_isPreconnected`, `dist_farSide`.
6. `contact_inType_or_outType` — **M**: wave 3's `not_mem_coloursAt_of_mem_sphere` (N-E1: `c`'s class misses `ω(v)`), a tile is preconnected
   (`IsTile.isPreconnected`) so lies inside or outside; "not both" by N-E2 against a `c`-tile at `v` (`mem_coloursAt_iff_exists_tileOf`) —
   the in-type tile forces it into `B̄(w, 1)`, the out-type one out of `B(w, 1)`, so into `ω(w)`, open — empty.
7. `coneAt_subset_allowedCone` — **M**: per contact, N-E2 puts each `c`-sector in `B̄(w, 1)` or outside `B(w, 1)`; a direction `β` of the
   class with `e β·(w − v) < 0` at an in-type `w` gives points `v + t e β` outside `B̄(w, 1)` near `v` — contradiction; limits of directions
   preserve the closed half-plane.
8. `clear_of_subset_interior_allowedCone` — **H**: N3-CLEAR. Finitely many tiles meet a neighbourhood of `ω(v)` (wave 3's
   `finite_tiles_near` on a compact cover); for each in-type tile at a contact, the margin `µ` from compactness of `Λ` in the open cone;
   tiles not touching `ω(v)` are at distance bounded away from `1`. With unit arcs the contacts may be an arc's worth: the per-tile margin
   argument still runs tile by tile (finitely many tiles), which is FS112-WALK's reading — the successor confirms it in the obligation pass.
9. `lens_dist_lt_one_of_up`, `lune_dist_le_of_up` — **E–M**: coordinates; C1 (`|p|² ≤ 2p_y` on the lens; `p_y ≤ 1/4` ⟹ `|z − p| < √(1/2) + r`;
   else `|z + te_y − p|² < |z − p|²` for `0 < t < 2(p_y − z_y)`), C2 (`p_y ≤ −1/2` on the lune). `nlinarith`.
10. `woodallCone`, `woodallCone_strict` — **H**: N3 § 2.3. `D_c(v)` an intersection of closed half-planes with empty interior is a line or a
    ray (a closed convex cone in `ℝ²`); two contacts bound it from opposite sides at `±n`; in-and-out at one point impossible (leaf 6),
    in-and-in impossible (`B̄(N, 1) ∩ B̄(S′, 1) = {v}` near `v`), so out-and-out; every sector then lies outside `B(N, 1) ∪ B(S′, 1)`, the double
    horn, so is a cusp along `±a` bounded by two arcs tangent at `v` with curvatures in `[−1, 1]` (wave 3's sector engine `localSectors` gives
    the branches and their tangents); strict by Condition 5 (a branch of curvature `±1` tangent at `v` lies on `ω(N)` or `ω(S′)`).
    Children: `allowedCone_isClosed`, `convexCone_interior_empty_iff` (planar), `sector_eq_hornSet_of_cone_singleton`.
11. `flank_shadows` — **H**: N4 § 2.2 (N4-FLANK), over leaves 5–8 and N-E2: shadows reaching near `v` come from contacts; off `N`, `S′`
    leaf 8 clears; in-type at `N`/`S′` is Siamese with the flank (impossible for `κ₂ < 1`, `κ₁ > −1`); out-type at `N` (for `g`) is upward
    closed (leaf 9) and misses the flank, hence the horn; out-type at `S′` tangent: leaf 5 (`_below`), non-tangent: inside `B(S′, 1)`, missing
    the horn. The union of finitely many "below a tangent circle" sets is "below the largest".
12. `shaveAvailable_of_not_doublyShadowed` — **M** over leaf 11: take `σ` between `σ_h` and `σ_g` (not doubly shadowed gives `σ_g ≤ σ_h`);
    points below are outside `h`'s shadow, above outside `g`'s — that is clearness.
13. `exists_shave`, `exists_rayMerge`, `exists_merge` — **H** each, one shared engine: **a recolouring lemma** (child, state once):
    given a valid `F`, a small open `R ⊆ B(v, ρ)` bounded by finitely many arcs, and a colour assignment on `R` whose points are clear for
    their new colour (and of diameter `< 1` per colour), the recoloured map (arcs `F.arcs ∪ ∂R`'s arcs, colour updated) is an `ArcMap`, valid,
    equal to `F` off `B̄(v, ρ)`; Condition 5 is kept when the new arcs have radius `≠ 1`. Then each move is the lemma with its clearness:
    SHAVE's from `hclear`, RAY's from N4 § 2.3 (a unit circle through a point between two `c`-horns crosses one: second-order model), MERGE's
    from N3 § 2.2 (leaves 8 and 9 at the gap's ends; NB3's two repairs: `ρ` off finitely many values, fill the enclosed hole). Sector counts
    after the move: the new sectors at `v` are the old ones with the merged pair counted once. Hard: the `ArcMap` construction and the sector
    count; nothing conceptual.
14. `stuck_structure` — **H**: N4 § 2.4 (i)–(iv), over leaves 10–13 (no MERGE ⟹ `int D_c = ∅` ⟹ cone; no RAY ⟹ one horn per ray; no
    SHAVE ⟹ doubly shadowed via leaf 12's contrapositive) and the three-colour hypothesis at `v`, `N`, `S′`.
15. `stuck_chain` — **M** over leaf 14: N4 § 2.5's step `k → k + 1` (at `N`, `h` has two sectors, terminal ⟹ no move ⟹ `IsStuck N` with the
    same axis), then `Int.induction_on` both ways, the mirror by the reflection child (§ 2.1 (a)).

**`Plane/ValidMap/UnitArc`**
16. `n2_sign` — **E**: wave 3's crossing engine (`Valid.dist_lt_or_gt_of_isPreconnected`) on the open arc, which lies in the closure of each
    side colour's class.
17. `lock` — **M**: N2 § 2.2 / NB-LOCK: N-E2 at `w` against both side tiles (two-sidedness), the shadow half-plane; the radius-2 exclusion of
    the outer colour is exact geometry (R2OUT, R2IN of `tools/fs112_n2_checks.py`).
18. `l60_le` — **M**: the outer colour's tiles along the arc form a chain whose closures meet in sequence (compactness of the arc and
    `finite_tiles_near`); wave 1's `dist_lt_one_of_chain` (TS-C) gives the ends within `≤ 1` (closure), and the chord of angle `θ₂ − θ₁` is
    `2 sin((θ₂ − θ₁)/2)` (wave 1's `dist_ringPt_ringPt`): `≤ 1` iff `≤ π/3`. Case `θ₂ − θ₁ ≥ π`: the chord bound fails earlier — split.
19. `noBoth` — **M**: wave 3's `ringArc_sideCone_other` (needs `P ∈ F.dom`): the two side cones hold colours other than `c`, `c′`; if
    `P` has at most three colours both side cones carry one colour `d` in two sectors (a repeated colour), else four.

**Re-pricing** from the first two leaves is the implementer's (CLAUDE.md § What compute actually helps); the plan's estimate for these 25
leaves: one implementer session of about 300k, the moves' recolouring engine (leaf 13) the largest piece.

## Stage 5 — SAVED: what is left, and the handoff

### 5.1 The build of the skeleton

`./scripts/build.sh` (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 441 of 441 batches, 4 modules rebuilt, 9 modules with warnings** — wave 3's six
skeleton modules and this stage's three, every warning `declaration uses 'sorry'` (no other warning or error), 8 m 12 s, exit 0
(`build/gate/build/20261004T071131Z-1871759.log`; driver log `data/fs131/k4/build-stage3.log`).

### 5.2 The 20 rows not yet stated — the successor's list, in the order I would take them

Each needs its derivation entry read in full first (`data/fs131/k4/rows.md` gives the address); the foundation already has the vocabulary
noted.

| row | module | what it needs beyond the foundation | source to read |
|---|---|---|---|
| FS112-U1 (shadow clause only, SR1 item 4) | UnitArc | a "first-order shadow" reading: for each `β ∈ (θ₁ − π/2, θ₂ + π/2)`, `P + t e β ∈ shadow T` for small `t > 0`, `T` a preconnected set approaching the whole open arc from outside `B̄(P, 1)` (stronger than the tile form; checked in my head, not on paper) | `plans/FS112-N-proof.md` §1.3; NB-U1 |
| FS114-L60-LE, clauses L60-EQ and L60-REAL | UnitArc | `Reul(X, Y, Z) = B̄(X,1) ∩ B̄(Y,1) ∩ B̄(Z,1)`; "each end a vertex carrying a third tile"; L60-REAL is a construction (the fragment of `tools/fs114_l60_check.py`, coordinates by formula) | `plans/FS114-L60-audit.md` § 1.3 |
| FS112-N2-BENDS (the bends) + FS112-BEND | UnitArc | existence of the bent map: `∀ ε, ∃ F'` valid, equal to `F` off the `ε`-neighbourhood of the arc, new arcs not unit arcs, every point of the open arc an interior point of `F'`; toward (outer colour absent at `P`), away (inner colour absent and `R₂(ᾱ)` untouched by the inner class), the tangent bend at isolated R2 contacts; BEND is the off-end-vertices case | `plans/FS112-N-proof.md` N2 stage N2-3 |
| FS112-ISO | UnitArc | a construction: a valid fragment with an inner-colour tile outside `B̄(P, 2)` touching `R₂` at one corner; "blocks a first-order away-bend" read as: the radial points `P + (1 + t)e(θ₀)` are not clear for the inner colour | `plans/FS112-NB-verification.md` §2.3 #4 |
| FS112-FLANK | UnitArc | at `κ₂ = 1` (upper arc on `ω(N)`) an in-type flank tile at `N` is Siamese with the flank and shadows a band of the horn; "SHAVE's criterion is incomplete" as: `¬ DoublyShadowed` computed from out-type tiles alone does not give `ShaveAvailable` — needs the exact reading | `plans/FS112-N-proof.md` §1.4 row 7; NB §2.2 |
| FS112-N2-FLANK-Q | UnitArc | a horn bound `±1` on a (Q) arc (then both horns' upper arcs one arc of `ω(N)` through `v`) or on an (R2) arc (its inner tile at the far antipode is FLANK's out-type tile); the mirror frame for the `−a` horn negates curvatures | N2 stage N2-4; NB2-FLANKQ |
| FS112-A4SIX | UnitArc | "covering pair" in the union sense (`coloursAt v ∪ coloursAt y = univ`, `data/fs110/claims.md` §9 item 1); "arcs of `Γ` centred at it of total length ≥ 60°" as `arcLength {θ \| OnRingArc v (r θ)} ≥ π/3`; "six, one in each of six consecutive 60° windows" — decide "lies in" or "meets" with the source | `plans/POROS-2026-09-27-fs110-competition.md` § A4-1 |
| FS112-NB4P | UnitArc | covering pair at a change point; the `σ_v`-orbit of `y₀` (`y_k = r(ψ + kπ/3)`); "in the closure of an arc of `Γ` on `ω(v)`" | `plans/FS112-N-proof.md` §2.1 W1 |
| FS112-N3-PAIRS | BaseSteps | CB's pair steps (i), (ii) — the base's own vocabulary (row 134); "two cubic trichromatic vertices with one multicolour are never at distance 1" is statable now | N3 stage N3-3; `plans/FS110-CB-verification.md` D1–D2 |
| FS112-N3-FAIL | BaseSteps | CB's D2 strip; "leaving centre" (centre of a unit arc ending at `u`) | N3 stage N3-3, N3-4 |
| FS112-N3-ANTI | BaseSteps | "M-in" (CE5) | N3 stage N3-3; `plans/FS110-CE-verification.md` |
| FS112-N3-END | BaseSteps | stuck chains with ends (one-sided `IsStuck` sequences), horn bound `−1` | N3 stage N3-4 |
| FS112-C-DOUBLE (C116) | BaseSteps | `TerminalOn` a neighbourhood of `E`, `E ± n`, `E ± 2n`; all four horn arcs unit arcs (curvatures `±1`); conclusion in-type tiles and `IsQArc` | `data/fs112/fs112-c/reconciliation.md` §1.9 |
| FS112-BOWTIE | BaseSteps | the construction (exact coordinates over ℚ in `tools/fs112_yb3_frags.py bowtie`): an `ArcMap` by formula, valid, with `IsHorn`, `TerminalOn` near `E`, `E ± n`, four colours at `E ± n` — **the inhabitant of `IsHorn`, `IsStuck`, `TerminalOn`**; schedule it before C-DOUBLE and N3-END | FS112-YB3 §2.2, 2.4, 3.1 |
| FS106-L | SVMap | region-only form: `A`, `B` open disjoint in an open `W` with `W ⊆ cl (A ∪ B)`, no unit pair inside `A` or `B`, `b ∈ cl A ∩ cl B` ⟹ `ω(b) ∩ W = ∅` | `plans/FS106-V-verification.md` V3 stage 1 (lemma (L)) |
| FS106-TW (R9) | SVMap | Townsend's Theorem 1: Definition 2's finitely disconnected unit annulus (closed bounded doubly connected `A ⊇ ω`, cut points), "any 2-colouring of `A⁰` contains a monochrome unit", region-only | V3 stage 1 |
| FS106-WO (R9) | SVMap | Woodall's Thm 6 as repaired (maps need six) and the step-4 lemma for arcs longer than `2π/3`; Woodall's text | V3 stage 3; `[Woodall1973]` |
| FS106-TS-T | SVMap | S–V map-type colourings (Conditions 2–4: Jordan boundaries — `C(unitInterval, ℂ)` injective arcs ending at vertices, locally finite), D-AEMAP, chromaticity (D-VMC), Conditions 5, 6 | `plans/FS106-TS-derivation.md` §2.4; SB §2.5 |
| FS106-AE-MAP6 | SVMap | the same structure; "no a.e.-proper map-type 5-colouring", modulo the fill — a large proof (Woodall's whole theorem): likely a separate planner-and-implementer job | TS §3 row C-AE-MAP6; V3 stages 1, 3 |
| FS112-N2-BENDS's ENV lemma | UnitArc | "a lens point's disc leaves the union of unit discs about `ᾱ` only near `P` or near `R₂(ᾱ)`" — make "near" quantitative from N2's identities (ENVT, ENVA) | N2 stage N2-3 |

### 5.3 The handoff (for the successor planner, then the implementer)

- **Where it is**: branch `fs131-w4` (pushed), worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4`; the foundation
  `Plane/ValidMap/Basic` sorry-free; three skeleton modules; `Proofs.lean`, `ARCHITECTURE.md` (four rows, `tools/check_architecture.py`
  PASS) and `scripts/Axioms.lean` (2 + 25 records) updated.
- **The successor planner** resumes at stage 3 (standing rule 2): states the 20 rows of § 5.2, extends `tools/fs131_k4_decls.py`'s module list,
  runs `debruijn-obligation-modeling` fresh over all 29, and writes the implementer's § 7 in wave 3's form. FS112-BOWTIE first among the
  BaseSteps rows: it is the wave's inhabitant.
- **The implementer may** add children anywhere in the wave's modules and supporting lemmas in the foundation modules (wave 3's included,
  statements unchanged): first the frame fact `frame_normSq`, the reflection `ArcMap.reflect` (§ 2.1 (a)), and the recolouring engine
  (leaf 13). **It may not** change a statement; a needed change comes back through Keryx.
- **Nothing with a `sorry` reaches `main`** (opening plan § 7.5): the wave lands after its implementer's gate.

## Stage 6 — SAVED (K4b stage 1): the readback

### 6.1 The brief's quotations against their sources (standing rule 3)

| quotation in the brief | source | result |
|---|---|---|
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors (line 118) | **matches**, a prefix of the source's run (it continues "Your predecessor formalized …") |
| "3. **States every row at the class its argument reads** (G92), reports each widening to Keryx as a generalization, and reads each statement back in" | `plans/FS131-kernel-plan.md` § 7.3 item 3 (line 568) | **matches as a truncation**: the source item ends "… reads each statement back in its record against the row."; nothing changed |
| "Each needs its derivation entry read in full first (`data/fs131/k4/rows.md` gives the address); the foundation already has the vocabulary" | this record § 5.2, its opening sentence | **matches as a truncation**: the source sentence ends "… the foundation already has the vocabulary noted." (the brief drops the last word); nothing changed |

The brief's other statements of fact, checked: K4 stated 9 of 29 rows (§ 3.1: 25 theorems in three modules) — **yes**; § 5.2's table lists twenty items
— **yes** (counted); less FS106-WO, FS106-TW, FS106-AE-MAP6 leaves seventeen — **yes**; "the wave's only inhabitant of `IsHorn`, `IsStuck` and
`TerminalOn`" is § 2.1 (b) — **yes**; inventory items 52 (K4's findings), 53 (N4-STUCK over NB-4's conclusion) and 54 (Woodall's chain is FS131-W)
read in `plans/FS131-close-inventory.md` on `main` — **yes**, as the brief summarizes them.

### 6.2 What is mine: the seventeen items, the merged rows, the rulings, caution C116

The seventeen (K4's § 5.2 less Woodall's three), in the order I take them: **FS106-L**, **FS106-TS-T** (stage 2: Woodall's job branches from
them); then the base steps with **FS112-BOWTIE** first (the inhabitant of `IsHorn`, `IsStuck`, `TerminalOn`), **FS112-C-DOUBLE** (C116),
**FS112-N3-END**, **FS112-N3-PAIRS**, **FS112-N3-FAIL**, **FS112-N3-ANTI**; then the unit-arc rows **FS112-U1** (its shadow clause, SR1 item 4),
**FS114-L60-LE**'s clauses L60-EQ and L60-REAL, **FS112-N2-BENDS**'s bends with **FS112-BEND** merged, the ENV lemma of N2-BENDS, **FS112-ISO**,
**FS112-FLANK**, **FS112-N2-FLANK-Q**, **FS112-A4SIX**, **FS112-NB4P**. Each row's whole backlog section is in `data/fs131/k4/rows.md`
(byte for byte, `tools/fs131_k4_rows.py --check`).

- **Merged rows carried** (ruling of the CSV): FS112-BEND into FS112-N2-BENDS (BEND is the bends off end vertices); FS114-L60-WALK into FS114-L60-LE
  (R8: checked when its wave-5 consumers are stated over the non-strict bound; its clause L60-D5 goes to wave 5 with FS112-N3-BASE, inventory item 52).
- **Rulings in force**: R9 (verdict clauses dropped) on FS112-N2-RAY — already stated by K4 (`Plane/StuckChain`); FS106-WO and FS106-TW are FS131-W's
  (inventory item 54). Item 53: FS110-N4-STUCK over NB-4's conclusion, as K4 stated it — unchanged here. Item 52: K4's generalizations
  (N3-CONF, W-MERGE with unit arcs; N3-DEG non-strict; N4-SHADOW's far-side form; LOCK and N2-SIGN in class form) stand as stated.
- **Caution C116 on FS112-C-DOUBLE**: formalized with the errata filed under it (`plans/LEAN-BACKLOG.md` at the row; re-read at the row in stage 3).
- **The obligation-modeling pass** over all wave-4 rows (K4's slip, item 52) is mine: stage 4.

### 6.3 The worktree builds as K4 left it

`./scripts/build.sh` in the worktree at `d0c56af0` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): **OK — all 1739 modules
already up to date, nothing built, 9 modules with warnings** (wave 3's six skeleton modules and K4's three, their `sorry` warnings), exit 0
(`build/gate/build/20261004T080043Z-2048659.log`; driver log `data/fs131/k4/build-k4b-stage1.log`).


## Stage 7 — SAVED (K4b stage 2): FS106-L and FS106-TS-T, the module FS131-W branches from

### 7.1 The module

`Proofs/HadwigerNelson/Plane/SVMap.lean` (imports `Plane/ValidMap/Basic`, `Instances/Seven`), and one foundation addition, `ArcMap.Condition6` in
`Plane/ValidMap/Basic` (S–V's Condition 6 read on an arc map: a point of exactly three colours has degree at most `3`), with a proved spec example
(the one-colour plane). Both rows are **region-only** (the FS106 derivation's header: "a step that reads no colour at a boundary point"), so both are
stated over open colour classes, never over a map's boundaries — the class their arguments read (G92), and the form Woodall's chain (FS131-W) can
instantiate from whatever structure it gives S–V's map-type colourings (Jordan boundaries are not arc maps; the opening plan's "S–V map-type
colourings (Conditions 2–6)" are FS131-W's to model, and need only produce `AeProperRegions`).

| declaration | what it is |
|---|---|
| `lemmaL` | FS106-L |
| `not_lemmaL_of_not_mem` | **adversary**: lemma (L) is false without `b ∈ W` (§ 7.3) |
| `multicolour S x` | D-VMC / S–V Def. 2: `{j | x ∈ closure (S j)}`; spec example and adversary proved; `ArcMap.coloursAt_eq_multicolour` (by `rfl`) |
| `AeProperRegions k` | D-AEMAP read on regions: open classes `cls j`, no two points of one class at distance `1`, dense union, finitely many components of the classes near each point (S–V's Condition 3 on regions) |
| `closedSquare`, `lebesgue_covering_square` | **an outside theorem** (§ 7.4) |
| `AeProperRegions.exists_three_le_multicolour`, `…_lt_one` | FS106-TS-T (SB's `1/√2 + ε`; TS's "within 1", strict) |
| `ArcMap.region_locallyFinite`, `dense_iUnion_region`, `toAeProperRegions` | a valid map of the plane gives `AeProperRegions` (over wave 3's `finite_tiles_near`, `dense_interiorPts`) |
| `ArcMap.ts_t`, `exists_hasDegree_of_mem_dom`, `ts_t_trichromatic`, `ts_t_degree_three` | TS-T for arc maps; the vertex step; Condition 5's clause over its conclusion; Condition 6's clause |
| `brickCorner`, `sevenBrickArcs`, `sevenBrickMap`, `sevenBrickMap_valid` (proved), `sevenBrickMap_isPlaneMap` (proved), `sevenBrickRegions` | **the inhabitant**: M36's brick seven-colouring as a valid arc map of the plane (three field leaves: `sevenBrickArcs_nondegenerate`, `_locallyFinite`, `sevenBrick_color_locallyConstant`) |

### 7.2 The read-backs

| row | read-back |
|---|---|
| **FS106-L** | Row: "a two-colour change point of a two-coloured open set with no monochrome unit has its unit circle outside the set"; V3 stage 1's form: "(L) in a 2-coloured open set `W` with no monochrome unit, no point `b` with both colours arbitrarily near has `ω(b) ∩ W ≠ ∅`". Formal (`lemmaL`): `A`, `B`, `W` open, `W ⊆ cl (A ∪ B)` (two-coloured, region-only: boundary points uncoloured), no unit pair inside `A` or inside `B` (no monochrome unit; for open sets the same as `UnitPairsNull`, wave 1's `dist_ne_one_of_mem_of_mem_closure` converts), `b ∈ W ∩ cl A ∩ cl B` ⟹ `Disjoint (sphere b 1) W`. "Change point **of** the set" is read as `b ∈ W` — necessary (§ 7.3). Disjointness of `A` and `B` is not a hypothesis: the argument never reads it (a point at unit distance from a point of `A` is not in `A`, whatever else it is) — a widening, harmless. **Same, with the reading `b ∈ W` fixed** |
| **FS106-TS-T** | Row: "every point of an almost-everywhere-proper map has a point of chromaticity ≥ 3 within 1/√2 + ε (TS: within 1); with Condition 5 it is trichromatic, with Condition 6 of degree 3 — closing S–V Lemma 4 (a) under Conditions 5–6". Formal: (i) `AeProperRegions.exists_three_le_multicolour` — for every `z` and `ε > 0` a point `x` with `dist x z < 1/√2 + ε` and `3 ≤ ncard (multicolour cls x)` (chromaticity is D-VMC's, the ncard of the multicolour; "almost-everywhere-proper map" is its regions, D-AEMAP); TS's form `…_lt_one` (strict `< 1`, stronger than "within 1"). For arc maps (`ArcMap.ts_t`): a valid map of the plane, `coloursAt` in place of the multicolour (equal by definition). (ii) "with Condition 5 it is trichromatic": SB § 2.5's second half reads Condition 5 only through **S–V Lemma 2 almost everywhere** (SB § 2.1 A5: no point of chromaticity ≥ 4, at six colours) — not a backlog row (finding F-A5, § 7.5); `ts_t_trichromatic` takes its conclusion, "at most three colours at every point", as inventory ruling 53 did for FS110-N4-STUCK, and concludes chromaticity exactly `3` and degree at least `3` (SB: "a trichromatic point is a vertex"). (iii) "with Condition 6 of degree 3": `ts_t_degree_three`, with `Condition6` (no point of exactly three colours has degree above `3`) — degree exactly `3`. "Closing S–V Lemma 4 (a)" is a remark on a text (dropped, as R9 drops verdicts). **Same; the Condition-5 clause over Lemma 2's conclusion** |

Consumers checked against these forms: FS129-SR2-DISC1TS (wave 5; "every closed disc of radius 1 of a valid map contains a vertex of degree at least
3", not claiming the Condition 5/6 forms) is `ArcMap.ts_t` with `exists_hasDegree_of_mem_dom` — both stated here; FS106-AE-MAP6 (FS131-W, five colours,
no Condition 5) reads clause (i) only, through its own map structure's `AeProperRegions`.

### 7.3 The reading `b ∈ W` is necessary (the adversary `not_lemmaL_of_not_mem`) [hand, one mind; a planner's check, not a row]

`b = 0`, `q = 1 ∈ ω(0)`; `ε ∈ (0, π/4)`, `r = sin ε / 4`, `ρ = min(sin ε, 1/2)/2`. `C_A = {u : 0 < |u| < ρ, |arg u − π| < π/2 − ε}` (a cone pointing
away from `q`), `C_B = {v : 0 < |v| < ρ, |arg v| < π/2 − ε}` (toward `q`), `D = B(1, r)`; `A = C_A ∪ (D ∖ B̄(0, 1))`, `B = C_B ∪ (D ∩ B(0, 1))`,
`W = C_A ∪ C_B ∪ D`. Then `W` is open, `W ⊆ cl (A ∪ B)`, `0 ∈ cl A ∩ cl B`, `0 ∉ W`, `1 ∈ ω(0) ∩ W`. No unit pair in `A`: within each piece the
diameter is below `1`; across, for `u ∈ C_A`, `w ∈ D ∖ B̄(0, 1)`, `Re(w ū) ≤ |u|(r − (1 − r) sin ε) < 0`, so `|w − u|² > |w|² > 1`. No unit pair in
`B`: for `v ∈ C_B`, `w ∈ D ∩ B(0, 1)`, `2 Re(w v̄) > |v| sin ε > |v|²`, so `|w − v|² < |w|² < 1`. So K4's draft form (§ 5.2: "`b ∈ cl A ∩ cl B` ⟹
`ω(b) ∩ W = ∅`", `b` anywhere) is false, and the row's "change point of a two-coloured open set" must be read with `b` in the set; V3's proof reads it
there (its point `z` is within `O(√s)` of `b` and must be coloured). Not a statement defect of the row — the row's words say "of the set" — but
FS131-W, which applies (L) in Townsend's annulus and at Woodall's step 4, must apply it at points of the open set.

### 7.4 The outside theorem: Lebesgue's covering theorem for the square

TS-T's first clause is dimension theory: if every point near `z` had at most two colours, the closures of the chain components (each of diameter
`≤ 1` by wave 1's `dist_lt_one_of_chain`, FS106-TS-C) would cover a square of side above `1` with order two — Lebesgue's covering theorem says they
cannot. TS's route (the hull growth, walking the outer frontier of a cluster) needs instead that the boundary of the unbounded complementary component
of a continuum is connected (the plane's unicoherence) — no easier. **Mathlib has neither** (grepped at the pin: no Lebesgue covering theorem, no
Brouwer fixed point theorem, no Sperner lemma — only Mathlib's homotopy lifting for covering maps, `Topology/Homotopy/Lifting.lean`, from which the
two-dimensional theorem is a long road). Its formalization is more than an hour of agent work (a combinatorial Sperner or Hex lemma, then a
Lebesgue-number compactness step), so by `LEAN.md` § Assumptions it is **either an `axiom` with the four items or a separate
planner-and-implementer job** — Keryx's decision, asked at this stage's commit. The skeleton states it as a `theorem` with `sorry`, so either
disposition is a one-declaration change; its statement, for the read-back owed under item 2: "a closed square covered by finitely many closed sets
`F i` none of which meets two opposite sides has a point in three of them" (`closedSquare c s`, `0 < s`, `F : Fin m → Set ℂ` closed, the two
opposite-sides conditions read on `F i ∩ closedSquare c s`). Source: Hurewicz–Wallman, *Dimension Theory* (Princeton, 1941), Theorem IV 2, the
`n`-cube with `n + 1` sets — **recalled, not read** (no copy in `~/source/library/`, no `BIBLIOGRAPHY.md` entry; SB § 2.5 cites it with the same
wording); its classical source is Lebesgue (Math. Ann. 70, 1911). A model of its hypotheses (item 3): the four closed quarter-squares of
`closedSquare 0 1` — none meets two opposite sides, and their common corner `(1/2, 1/2)` lies in all four (an `example` once the disposition is made).

### 7.5 The build of this stage

`./scripts/build.sh` (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 441 of 441 batches, 6 modules rebuilt, 10 modules with warnings** (wave 3's six, K4's three,
`Plane/SVMap`; every warning `declaration uses 'sorry'`, no other warning or error beyond the up-to-date probe's expected line), 8 m 13 s, exit 0
(`build/gate/build/20261004T081431Z-2082832.log`; driver log `data/fs131/k4/build-k4b-stage2.log`). `tools/check_architecture.py`: PASS. `scripts/Axioms.lean`:
section "FS-131 wave 4 (job FS131-K4b) — the skeleton continued", 20 records; `tools/fs131_k4_decls.py` extended to `Plane/SVMap` and to the three
definitions built from leaves (`--check`: 45 names, 0 missing; `--plant`: FIRED, 45 missing).

### 7.6 Findings sent to Keryx with this stage's commit

- **F-A5 (backlog completeness, as F-NB4).** FS106-TS-T's Condition-5 clause rests on S–V Lemma 2 almost everywhere (SB § 2.1 A5, "no point of
  chromaticity ≥ 4" for six colours with Condition 5) — the map-type twin of FS110-NB-4, and no backlog row. Stated over its conclusion
  (`ts_t_trichromatic`), as ruling 53 did for N4-STUCK; no backlog consumer reads the clause (DISC1TS's not-claimed line excludes it; AE-MAP6 is at
  five colours without Condition 5).
- **L-READ (a reading, with a counterexample to the other).** FS106-L holds for change points **in** `W`; at a frontier point it is false (§ 7.3).
  For FS131-W.
- **G-L (generalization, small).** Lemma (L) needs no disjointness of the two classes.
- **OUT-LEB (decision owed).** Lebesgue's covering theorem for the square: an axiom with the four items, or a separate formalization job (§ 7.4).
  My recommendation: a separate job (it is the plane's dimension theorem, a reusable Mathlib-shaped result, and the only outside theorem the wave
  needs); the axiom only if that job has not landed when wave 4's gate is otherwise green.
