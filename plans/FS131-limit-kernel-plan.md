# FS131-KL1 — the limit constructions planned: `exists_red`, `exists_terminal` over a limit of `ArcMap`s

*de Bruijn, the planner (Opus), on branch `fs131-w5c` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c`, from `ff6e917f`. Brief:
`data/fs131/briefs/FS131-KL1-limit.md` (main tree). Record of the planning job; the implementer works from §§ 4–7.*

## Theorems this phase proved

All [kernel] on `[propext, Classical.choice, Quot.sound]` (`data/fs131/kl/KLAxioms2.out`): `ArcMap.LocalStep.refl`, `ArcMap.LocalSeq.const`,
`ArcMap.LocalSeq.dom_eq` (`Plane/ValidMap/Limit.lean`); `ArcMap.terminal_vertices` (`Plane/ValidMap/Terminal.lean`, FS112-N2-TERM's clause 2 in
every terminal map). Proved **over open children** (no `sorry` of their own): `ArcMap.exists_terminalMap` (`Procedure`), `ArcMap.exists_red`,
`ArcMap.exists_terminal`, `ArcMap.run_ends` (`Terminal`).

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

Checked by script, `tools/fs131_kl_quotes.py` (a copy of FS131-I5h's checker under this job's prefix; rule 7 bars editing another job's
tool): **13 quotations, 0 failures** — `CLAUDE.md` § Counter-priors; the first lines of `exists_red`, `exists_terminal` (`Terminal.lean`) and
`IsModification` (`Chain.lean`); the wave-5 plan's § 4 leaves 2–3, § 9.1's row, § 10.2's "It may"; `FS131-I5-implementation.md` Stage 44's "Left";
the inventory's items 361, 362, 347, 348. `--self-test` (one letter planted in the first quotation): **fired** (1 failure), the unplanted run
exit 0. No mismatch.

Read in full: the two leaves and `IsModification` (with all of `Chain.lean`); `ArcMap` (`Plane/ArcMap.lean`) and wave 4's vocabulary
(`Plane/ValidMap/Basic.lean`, through the engines); the plan's §§ 4, 9.1, 10.1–10.6; I5's Stages 39–44; inventory items 269, 347, 348, 361–364
and, on `main` (newer than the brief), 365–366; the moves' statements — `exists_shave`, `exists_rayMerge`, `exists_merge` (this branch's
`Contact`, ruling-269 form), `bend_toward`, `bend_away_whole` (`main`'s `UnitArc`, by statement); `main`'s `Surgery` (`trimArcs`, `surgery`,
`Near`, `Near.move`, `newArcs`) and `Moves`' header, `origin/fs131-w4mm`'s `exists_merge_aux` (proved there by FS131-IMM4, `c9623d04`) and its
`mergeArcs`; the hand proofs `plans/FS112-N-proof.md` N2-RED, N2-TERM (Stage N2-3–N2-4) and `plans/FS110-N-proof.md` § 2.7 (N4-TERM).

### 1.2 The as-given build (`ff6e917f`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — all 1755 modules
already up to date, nothing built, 8 modules with warnings**, exit 0 (`build/gate/build/20261005T085414Z-2846430.log`; driver log
`data/fs131/kl/build-stage1-asgiven.log`). `Terminal`'s `sorry` declarations: `exists_red`, `exists_terminal` — I5p's count.

### 1.3 What I am planning, and what I may change

Planning: the limit of a sequence of `ArcMap`s and what passes to it; what `IsModification` and the descent need of each move; `exists_red`
and `exists_terminal` reduced to named children with `sorry`, each read back, planned and priced; the obligation pass; the handoff. Mine to
decide: the limit's definition and layout, the cut, names, and where the infrastructure lives within my touches (a new module upstream of
`Terminal`; `Terminal` beside the two leaves). Not mine: the two leaves' statements (unchanged), any statement outside wave 5, and the files the
brief fences (`Contact`, wave 4's stale modules here, `HexRing`, `Cor3`, `BaseWalk`, `Dense`, `MapGraph`, `BaseDense`). A move needing a
change outside wave 5 goes to Keryx as a list.

## Stage 1 — SAVED

## Stage 2 — SAVED: the skeleton (`debruijn-domain-modeling`, invoked fresh) and the findings sent

### 2.1 The model, and why this shape

- **The limit is point-set where it can be, arc-tracked where it must be.** `ArcMap` carries a presentation (`arcs`), and the limit
  needs a locally finite family; the arcs present from some stage on (`limitArcs`) are one, *if* a step keeps every arc missing its
  support as the same object and puts every new arc inside the support or inside an arc that meets it (`LocalStep`). The adversary
  this excludes: a step renaming a far arc (an arc replaced by a copy) would leave `limitArcs` empty there. The surgeries have exactly
  `LocalStep`'s shape (`trimArcs` keeps arcs missing `v`; its pieces lie in arcs through `v`; new arcs lie in the disc).
- **The pivot is one lemma, `LocalSeq.frozen`**: by induction every arc of a stage lies in an arc of `F 0` or in an earlier support,
  so the arcs ever meeting a compact `K ⊆ dom` lie in one compact set, met by finitely many supports. Everything else (local
  finiteness, local constancy, validity, `IsModification`, terminality) reads `frozen` and the locality lemmas.
- **Locality needs validity once**: `InType`/`OutType` quantify over whole tiles, which are global; in a valid map a tile of a colour
  carried at `v` never meets `ω(v)` (the IVT argument behind `contact_inType_or_outType`), so the type is read near the contact.
  Radius `3` covers every predicate the moves read (cones on `ω(v)`, clearness on unit circles about points near `v`, the radius-2
  witness).
- **One construction, not two** (finding (4), accepted, inventory item 372): `exists_terminalMap` at every `k`; `exists_red` reads
  `Valid` and `QROnly` off it, `exists_terminal` adds three theorems about every terminal six-map. Both leaves now carry no `sorry` of
  their own.
- **Clean maps** (findings (1)–(3), accepted): the one generic `exists_clean` repairs SHAVE's descent (`K = univ` keeps the horn's
  germs) and the full rim circle of `Near.move`, and makes the input map's sites isolated — without it, an arc with one colour on both
  sides is a continuum of repeated-colour points.
- **Inhabitants**: `LocalSeq.const F` (every clause of `LocalSeq` at once, any map); `LocalStep.refl`; `IsClean` on the one-colour
  plane (spec example); `exists_terminalMap`'s hypotheses by `sevenBrickMap` at `k = 7`; `IsTerminalMap` by
  `sevenBrickMap_isTerminalMap`. The stuck-run children (`run_ends`, `run_hornBoundsQR`, `stuckRun_ne_univ`) are `GENERIC` (FS-115: no
  model of a stuck vertex in a terminal plane map is known), as wave 5's other chain theorems.

### 2.2 What was added (statements of the two leaves unchanged)

- **`Plane/ValidMap/Limit`** (new, imports `Chain`): `LocalStep` (+`refl` proved, `mono`), `LocalSeq` (+`const`, `dom_eq` proved; `exists_stab`,
  `stab`, `frozen`), `limitArcs`, `limitCol`, `limit` (a definition over the sorried children `limitArcs_locallyFinite`,
  `limitCol_locallyConstant`), `eventually_agreesOn`, `limit_isPlaneMap` (proved), `limit_valid`, `limit_isModification`, the six
  locality lemmas, `limit_isTerminalMap`, `IsClean`, `IsSite`, `not_available_of_not_isSite`, `IsClean.eventually_not_isSite`,
  `exists_clean`; three spec examples.
- **`Plane/ValidMap/Procedure`** (new, imports `Limit`): `IsMaxRingArc`, `badCount`, `treatPts`, `badCount_eq_zero_iff`, `badCount_lt_top`,
  `treatPts_inter_finite`, `mergeAvailable_of_bothKind`, `exists_vertexStep`, `exists_arcStep` (question (5) is its last clause),
  `exists_terminalSeq`, and **`exists_terminalMap` proved over them**.
- **`Terminal`** (imports `Procedure`, `HexRing`): `exists_red` and `exists_terminal` proved over `exists_terminalMap` and four
  children placed after `c_ends` (the N2-TERM block moved there, statements unchanged): `terminal_vertices` and `run_ends` **proved**,
  `run_hornBoundsQR`, `stuckRun_ne_univ` `sorry`.

### 2.3 The build, the map, the receipt

`./scripts/build.sh` (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 447 of 447 batches, 7 modules rebuilt, 10 with warnings, every warning
`declaration uses 'sorry'`**, exit 0, 8 min 48 s (`build/gate/build/20261005T090553Z-2902958.log`; driver log `data/fs131/kl/build-stage2.log`).
`Terminal`'s `sorry` declarations: `run_hornBoundsQR`, `stuckRun_ne_univ` (was: `exists_red`, `exists_terminal`). `tools/check_architecture.py`:
PASS, exit 0 (`data/fs131/kl/arch-stage2.txt`; rows `Limit`, `Procedure` added, `Terminal`'s Imports cell and description updated).
`scripts/Axioms.lean`: 37 records added to the "FS131-I5h" block, above `=== PURCHASED ===`; read from this build's oleans
(`data/fs131/kl/KLAxioms2.lean` → `KLAxioms2.out`, exit 0): `LocalStep.refl`, `LocalSeq.const`, `LocalSeq.dom_eq`, `terminal_vertices` on
`[propext, Classical.choice, Quot.sound]`; the rest on `sorryAx` through their children (and `run_ends` through this branch's stale
`flankQ_*`, proved on `main`).

### 2.4 Findings sent to Keryx mid-job (ruled: inventory items 371–372)

(1) SHAVE as built (`exists_shave_recolour`, `X.move hs univ …`) raises `Φ(v)` and `v`'s degree — the descent of FS110 N4-SHAVE fails
for the construction (a correction owed to N4-SHAVE's text, item 372 (d)); (2) `Near.move`'s full rim circle makes a continuum of
repeated-colour points; (3) an input map may carry one-coloured arcs; repair: `exists_clean`, accepted; (4) the shorter route, accepted;
(5) the bend's witness question, now `exists_arcStep`'s last clause, checked by the kernel when proved.

## Stage 2 — SAVED

## Stage 3 — SAVED: the obligation pass (`debruijn-obligation-modeling`, invoked fresh), the plan per child, the moves' lemmas, the handoff

### 3.1 The pass, statement by statement (each: what the proof derives from; children; a missing hypothesis)

*Superseded in part — see § 17.4 (FS131-IR1's corrections: the cleaned step is `cleanKeep`, not `exists_clean`; "within `3`" is within `4`; the potential is degree plus horns), and Stage 18 on for the vertex step as proved (pointer added by FS131-IR2, ruling 421 (b)).*

| child | verdict | route and children |
|---|---|---|
| `LocalSeq.frozen` | derives **from a strengthened invariant** | `arc_origin`: every arc of `F n` lies in an arc of `F 0` or in some `U m`, `m < n` (induction on `n` by `keep`/`new`). Then `K' := ⋃ {a ∈ (F 0).arcs meeting K} ∪ ⋃ {U m meeting K}` is compact (finitely many: `(F 0).locallyFinite` on compact `K ⊆ dom`, `LocallyFinite.finite_nonempty_inter_compact`); `N` past the finitely many `n` with `U n ∩ K' ≠ ∅`; for `n ≥ N` induction on `n` (arcs meeting `K` lie in `K'`, so miss `U n`: `keep`; a new arc meeting `K` would lie in `U n` or in an arc meeting `U n`, both inside `K'`). **M** |
| `exists_stab`, `limitArcs_locallyFinite`, `limitCol_locallyConstant`, `eventually_agreesOn`, `limit_valid`, `limit_isModification` | derive from `frozen` | `LocallyFinite.point_finite` + `Set.Finite.bddAbove`; `frozen` on `closedBall x 1` then `(F N).locallyFinite`; the same and `(F N).locallyConstant` (a point on no limit arc is on no arc of `F N` meeting the ball); `W := ball` of `K`'s thickening inside `dom`; a unit pair `{x, y}` is compact; a ring arc is compact (`isCompact_Icc.image`), `onRingArc_iff_of_agreesOn`. **E–M** each |
| locality (six lemmas) | derive, **validity needed for MERGE** | `coloursAt`: closure of `region j` near an interior point of `W` (open). Sectors, horns, flanks, `IsClear` (the unit circle about a point of `B̄(v, 1)` lies in `B̄(v, 2)`), ring arcs and the radius-2 witness are read in `B̄(v, 3)`. `InType`/`OutType` quantify over tiles (global): child **`tile_subset_ball_or_disjoint`** — in a valid map a tile of a colour carried at `v` lies in `B(v, 1)` or misses `B̄(v, 1)` (the IVT pair behind `contact_inType_or_outType`), so the type is read near the contact. `rayAvailable`, `shaveAvailable`, `qrAt` need no validity. **M** (merge), **E–M** others |
| `limit_isTerminalMap` | derives | `eventually_agreesOn` at `closedBall v 3`, the four locality lemmas, `hev v`; `QROnly` pointwise at each centre. **E** |
| `exists_clean` | derives | Define `ess F := {x ∈ F.dom ∣ 2 ≤ ncard (F.coloursAt x)}` (closed in the domain: its complement is open, one colour near the point). Children: **`ess_inter_arc`** — for an arc `a`, `{t ∈ a.params ∣ a.pt t ∈ ess F}` is a finite union of closed intervals (cover `a` by finitely many sector charts, `localSectors`; along a branch the two side sectors' colours are constant, so ess-membership changes only at chart centres); the clean map's arcs are the maximal non-degenerate pieces (`Arc.sub`, `nondegenerate_sub` — `main`'s `Surgery`, or re-proved here), a fully essential arc kept as itself (so `LocalStep` survives cleaning off a move's disc); colour on the dropped points := the one colour around; `clean_valid` (approximate a dropped point by interior points of its colour: two points at distance exactly `1` would give an interior unit pair in `F`, the argument of I5o's retraction, item 365); `coloursAt` unchanged (dropped points are already in the closure of their colour's class); `Γ` shrinks, so `RingArcsWithin` is immediate. No missing hypothesis. **H** (the piece decomposition; about 400–600 lines) |
| `not_available_of_not_isSite`, `IsClean.eventually_not_isSite` | derive | MERGE: `2 ≤ n` sectors give a repeated colour; RAY, SHAVE: a horn. Isolation: in a sector chart (`IsSectorChart.branches`) every point of the punctured ball is interior or on one branch, its two sides sectors of different colours (clean) and half-discs, not horn sets. **E**, **M** |
| `badCount_eq_zero_iff`, `badCount_lt_top`, `treatPts_inter_finite` | derive | maximal extension of a ring arc (lengths `≤ π/3`, `l60_le`; sup of the extensions with the same sides, closed by local finiteness); finitely many maximal arcs (side changes at sites of the compact `ω(P)`, `IsClean.eventually_not_isSite`); sites closed and isolated, centres of the finitely many unit arcs meeting a compact set. **M** each |
| `mergeAvailable_of_bothKind` | derives (N2-RED's parenthesis), **one mind** | U1 at the arc (`u1_shadow`, wave 4) puts the side colours' cones off the arc's directions; a colour holding both side cones at `P` has two sectors with an open cone between. Read N2-RED/NB2-RED first. **M–H** |
| `exists_vertexStep` | derives **in priority form; a residual case for the deriver** | Case MERGE: `exists_merge_aux` (`fs131-w4mm`/`main` after landing) then `exists_clean`. Case RAY with no MERGE: `horn_bounds_of_noMerge` gives `−1 ≤ κ₁`, `κ₄ ≤ 1`, so `exists_rayMerge_aux` applies. Case SHAVE with no MERGE and the horn's colour of `≥ 2` sectors: bounds by `horn_bounds_of_noMerge`, `exists_shave_aux`. **Case SHAVE at a lone horn** (its colour one sector, bounds unconstrained): `exists_shave` needs `−1 ≤ κ₁`, `κ₂ ≤ 1`; the construction (`shaveArcs_not_isUnitArc`) needs only `|σ| ≠ 1` or `σ ∈ {κ₁, κ₂}`, so a generalized SHAVE (§ 3.3, `shave_step_gen`) covers it — **except `σ = ±1` strictly between `κ₁` and `κ₂` with no other admissible `σ`, where every shave creates a unit arc** (finding F6, § 3.4). The statement should take the priority form (`¬ MergeAvailable` in the RAY/SHAVE cases) when the implementer proves it — a strengthening of the hypothesis inside my module, decided at implementation. Degree drop: count non-phantom germs after `exists_clean`. **H** |
| `exists_arcStep` | derives over three bends and **question (5)** | in-only or inert (`c' ∉ P_cl(P)`): `bend_toward`; out-only, no witness on the whole arc: `bend_away_whole`; out-only with a partial witness: N2-TAN's tangent bend (not in `main`'s `UnitArc` by that name — grep `n2_tan`, `bend_away` first; if absent, a new child **`bend_away_part`**, H). Then `exists_clean`. `badCount P` drops (the arc removed or left as (R2) pieces; `P`'s colours and its other arcs' witnesses untouched: the lens lies within `ε` of the arc, the witnesses at distance `2`). Last clause: the lens's closure avoids `T` off the arc (`T` locally finite, `ε` small); centres on the arc's open part only lose `c`; **(5)**: a witness `R₂(β) ⊆ cl(region d)` cannot cross the open arc (beyond it lies the outer tile, colour `c' ≠ d` when `d = c`; tangency puts it locally outside) — one mind's sketch, child **`witness_not_cross`**. **H** |
| `exists_terminalSeq` | derives | Enumerate `treatPts F` (countable: `treatPts_inter_finite` on `closedBall 0 n`). Build the stages by `Nat.rec` with a chosen step at the least-index point with something to do (`Classical.choice` on the step lemmas), radii below `δ = min(1/2, dist to other treatment points in B̄(v, 3))/3`, idle otherwise. Children: **`acted_finitely`** (a site: degree never rises — vertex steps leave other sites' degrees by `LocalStep` and `¬ IsSite` in the disc, arc steps by their degree clause; a centre: `badCount` rises only at vertex steps within `3` (finitely many) or when its colours shrink (`≤ k` times), each step at it lowers it), **`supports_locallyFinite`** (finitely many treatment points in a compact set, each acted on finitely often), **`fair`** (a point with something to do from stage `N` on would be the least-index choice infinitely often). **H** (about 400 lines) |
| `exists_terminalMap` | **proved** over its children | — |
| `run_hornBoundsQR` | derives | at `w = v + j n`: `stuckAlong_of_mem_stuckRun` (axis `±α`), `stuck_structure_at_axis` (the horns are the two-sector colour's, flanks `g`, `h`, out-type contacts at the poles), a horn `IsHorn w β κ 1 d` with `β ≡ α` or `α + π` is one of them (`IsHorn` uniqueness at a chart index, `Near.horn_index`-style), then `flankQ_upper_of_qrOnly` / `flankQ_lower_of_qrOnly`. **M** |
| `stuckRun_ne_univ` | derives **given one new child** | along `univ` every vertex is stuck along `±α`; bounds `≠ ±1` (`cv_l0` at the neighbour: a bound `1` puts an arc of `ω(N)` in `Γ` centred at a chain vertex); child **`shadow_recursion`**: for consecutive run vertices `w`, `w + n`, `λ_w ≤ curvDown λ_{w+n}` and `curvUp υ_w ≤ υ_{w+n}` (no SHAVE at a stuck vertex: `shaveAvailable_of_not_doublyShadowed`'s contrapositive with unit arcs, then SH1 `shadow_hornSet_subset_S`/`_N` places the flank's shadow) — then `n4_fin`. Wave 4's `stuck_chain` did the propagation under Condition 5 without the recursion. **M–H** |

### 3.2 Price (re-price from the first two leaves; the brief's counter-priors stand)

`Limit`: `frozen` and its five consumers — one session; the locality lemmas with `tile_subset_ball_or_disjoint` — half a session; `exists_clean` —
one session. `Procedure`: the finiteness lemmas and `mergeAvailable_of_bothKind` — half to one session; `exists_vertexStep` and
`exists_arcStep` (after the merge with `main`) — one to two sessions; `exists_terminalSeq` — one session. `Terminal`: `run_hornBoundsQR` and
`stuckRun_ne_univ` — one session. **Total: five to seven implementer sessions.** Two implementers can split by file with no shared
statement: **A** — `Limit` (the limit, locality, `exists_clean`) then `Procedure`'s finiteness lemmas; **B** — `Terminal`'s two children now,
then `exists_vertexStep`/`exists_arcStep` after the merge with `main`. `exists_terminalSeq` last, by whoever finishes first.

### 3.3 The moves' lemmas, for the module downstream of `Moves` and `MergeMove` (ruling 372 (a); new declarations only)

*Superseded in part — see § 17.4 (`shave_step_gen` is not needed; the four `LocalStep` clauses are one lemma, `surgery_localStep`) and ruling 421 (c) (new declarations may go into the moves' modules) (pointer added by FS131-IR2, ruling 421 (b)).*

Each is proved by re-opening a construction, after this branch merges `main`, in `Plane/ValidMap/Procedure` (its imports then gain
`Moves`, `MergeMove`, `UnitArc`) or a module between them; none changes a landed statement.

| lemma (statement) | reads |
|---|---|
| `merge_step`: `exists_merge_aux`'s map with `LocalStep F F' (closedBall v ρ)` and `∀ x ∈ closedBall v ρ, x ≠ v → (F'.coloursAt x).ncard ≤ 3 ∧ ¬ F'.HasRepeatedColour x ∧ ∀ α κ₁ κ₂ c, ¬ F'.IsHorn x α κ₁ κ₂ c` | `MergeMove`'s `surgery … (mergeArcs …)`, `trimArcs_spec`; the interior points of the disc (`merge_*` sector lemmas): **private detail** — the merge's new points in the open disc off the rim (sides of kept germs) are not stated anywhere today |
| `rayMerge_step`, `shave_step`: the same three clauses for `exists_rayMerge_aux`, `exists_shave_aux` **before cleaning** except no-repeated-colour (false: the kept germs and the full rim circle), with `exists_clean` supplying it | `Moves`' `Near.move`, `newArcs`, `rayKeep`, `shaveArcs`; `Surgery`'s `trimArcs_spec` |
| `shave_step_gen`: SHAVE at any bounds when `κ₁ < σ < κ₂ → |σ| ≠ 1` | `exists_shave_recolour`'s proof with `shaveArcs_not_isUnitArc` re-proved from `|σ| ≠ 1` |
| `degree_lt_of_clean_step`: after `exists_clean`, `v`'s degree is the number of germs with two colours, so each move lowers it | `Near`'s chart (`IsSectorChart.encard_sectorsOf`), the move's kept set |
| `bend_step` (toward, away): `LocalStep F F' (cthickening ε (ringArc P θ₁ θ₂))`, sites' degrees unchanged, no site created, colours at points of `T` off the arc unchanged | `UnitArc`'s `bendMap` (arcs, lens `L`), `bendMap_region`; **private detail** — `bendMap`'s arc set is not exported by `bend_toward`'s statement |

### 3.4 Findings of this stage (to Keryx with the report)

- **F6 — a residual case of SHAVE (a question for the deriver; statement risk for `exists_terminalMap`).** `ShaveAvailable v` (wave 4's
  `Basic`) admits a lone horn (its colour one sector at `v`, so no curvature bound from `horn_bounds_of_noMerge`) whose only admissible split
  is `σ = ±1` with `κ₁ < σ < κ₂`. Every shave there adds an arc of `ω(v ± n)` inside the horn — a unit arc `IsModification` forbids — and FS112-
  WALK row 7 covers only `[κ₁, κ₂] ⊆ [−1, 1]`. Either such a configuration is impossible in a valid map (to derive: the flanks' shadows bounded
  by one unit circle from both sides), or `Terminal` is unreachable there by the moves. Smallest form: a horn at `v` with `κ₁ < 1 < κ₂`, flank
  `g` whose shadow in the horn is exactly the part below `ω(N)`, flank `h` whose shadow is exactly the part above. No counterexample built.
- **F7 — RAY needs MERGE first.** `RayAvailable` carries no clearness; `exists_rayMerge` needs `−1 ≤ κ₁`, `κ₄ ≤ 1`, which hold when MERGE is not
  available (`horn_bounds_of_noMerge`). So the procedure treats MERGE first at a vertex; `exists_vertexStep`'s statement will take that
  priority form (inside my module).

## Stage 3 — SAVED

## Stage 4 — SAVED: the handoff to the implementer

**Where.** Branch `fs131-w5c` (worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c`), at this stage's commit. Build with
`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree; iterate on a scratch file importing
the built module (`lake env lean`, ~6 s a run, never evidence).

**What to prove** (the open children, § 3.1's routes; order cheapest re-pricing first): `LocalStep.mono`, `exists_stab` →
`frozen` (with `arc_origin`) → `limitArcs_locallyFinite`, `limitCol_locallyConstant`, `eventually_agreesOn`, `limit_valid`,
`limit_isModification` → the locality lemmas (with `tile_subset_ball_or_disjoint`) → `limit_isTerminalMap` → `not_available_of_not_isSite`,
`IsClean.eventually_not_isSite` → `exists_clean` → `badCount_eq_zero_iff`, `badCount_lt_top`, `treatPts_inter_finite`,
`mergeAvailable_of_bothKind` → (`Terminal`) `run_hornBoundsQR`, `stuckRun_ne_univ` (with `shadow_recursion`) → after the merge with `main`:
`exists_vertexStep`, `exists_arcStep` over § 3.3's lemmas → `exists_terminalSeq`. Two implementers split as § 3.2 says.

**What it may change**: add children anywhere in `Limit`, `Procedure`, `Terminal` (and § 3.3's lemmas in `Procedure` or a module between it
and `Moves`/`MergeMove`); strengthen a hypothesis of `exists_vertexStep` to the priority form (F7) and of `exists_arcStep` if a bend needs it,
since both are internal to the construction; move declarations within a file. **It may not**: change `exists_red`'s or `exists_terminal`'s
statement, `IsModification`, `IsTerminalMap` or any wave-4 definition; a statement of `exists_terminalMap`, `terminal_vertices`, `run_ends`,
`run_hornBoundsQR`, `stuckRun_ne_univ` changes only through Keryx. **Watch**: F6 (a lone horn shaveable only at `σ = ±1`) — if
`exists_vertexStep`'s lone-horn case cannot be closed, stop and report the configuration; `exists_arcStep`'s last clause is question (5) —
a failed proof is routed to the deriver, never weakened silently.

**Vacuity and inhabitants**: `LocalSeq.const` inhabits `LocalSeq`; `exists_terminalMap`, `exists_clean`, the locality lemmas are `GENERIC`
or inhabited at `sevenBrickMap` (`k = 7`); the stuck-run children are `GENERIC` (FS-115). Every new definition has a spec example except
`badCount`/`IsMaxRingArc`/`treatPts`, whose examples (the one-colour plane: `badCount = 0`, `treatPts = ∅`) the implementer adds when it
proves `badCount_eq_zero_iff`.

## Stage 4 — SAVED

---

# FS131-IL1 — the implementer, lane A (`Limit`, then `Procedure`'s finiteness lemmas)

*de Bruijn, the implementer (Opus), on branch `fs131-w5c` from `8a42a2e0`. Brief: `data/fs131/briefs/FS131-IL1-limit.md` (main tree).*

## Theorems this phase proved (FS131-IL1)

All [kernel], read against the stage-8 build's oleans (`data/fs131/il/ILAxioms.out`, Stage 8); each on `[propext, Classical.choice,
Quot.sound]` or a subset unless the print says otherwise. In `Plane/ValidMap/Limit`:
- the plan's leaves: `ArcMap.LocalStep.mono`; `ArcMap.LocalSeq.exists_stab`, `.frozen`, `.limitArcs_locallyFinite`, `.limitCol_locallyConstant`,
  `.eventually_agreesOn`, `.limit_valid`, `.limit_isModification`, `.limit_isTerminalMap` (and the definition `.limit`, now sorry-free);
  `ArcMap.coloursAt_eq_of_agreesOn`, `.onRingArc_iff_of_agreesOn`, `.mergeAvailable_iff_of_agreesOn`, `.rayAvailable_iff_of_agreesOn`,
  `.shaveAvailable_iff_of_agreesOn`, `.qrAt_iff_of_agreesOn`; `ArcMap.not_available_of_not_isSite`; `ArcMap.IsClean.eventually_not_isSite`;
- children added: `ArcMap.finite_arcs_inter_compact`, `.mem_Γ_iff`, `.AgreesOff.symm`, `.mem_closure_iff_of_inter_eq`, `.region_inter_eq_of_agreesOn`,
  `.interiorPts_inter_eq_of_agreesOn`, `.mem_closure_region_inter_iff`, `.isSector_iff_of_agreesOn`, `.IsSector.subset_ball`,
  `.sectorsOf_eq_of_agreesOn`, `.eventually_ball_subset`, `.hasSectors_iff_of_agreesOn`, `.hasRepeatedColour_iff_of_agreesOn`,
  `.hornSet_subset_ball`, `.isHorn_iff_of_agreesOn`, `.subset_region_iff_of_agreesOn`, `.isFlankAbove_iff_of_agreesOn`,
  `.isFlankBelow_iff_of_agreesOn`, `.isClear_iff_of_agreesOn`, `.isTile_of_agreesOn`, `.tileOf_iff_of_agreesOn`, `.inType_iff_of_agreesOn`,
  `.allowedCone_eq_of_agreesOn`, `.isRingArc_iff_of_agreesOn`, `.isQArc_iff_of_agreesOn`, `.isR2Arc_iff_of_agreesOn`,
  `.LocalSeq.arc_origin`, `.LocalSeq.agree_of_not_mem`, `.LocalSeq.col_eq_limitCol`, `.LocalSeq.exists_disjoint_of_isCompact`,
  `.LocalSeq.limitArcs_inter_eq`, `.LocalSeq.eventually_mem_limitInterior_iff`, `.LocalSeq.agreesOn_of_disjoint`, `.LocalSeq.exists_agreesOn_ball`,
  `.interior_coneAt_hornSet_eq_empty`, `.germ_eq_curveGerm_of_goodAt`, `.not_isSite_of_goodAt`, and `Arc.curve_eq_of_mem`.
In `Plane/ValidMap/Procedure`: no theorem; three spec examples (below).

## Stage 5 — SAVED (FS131-IL1): the readback and the as-given build

### 5.1 The brief's quotations against their sources (standing rule 3)

Checked by script, `tools/fs131_il_quotes.py` (a copy of KL1's checker under this job's prefix): **11 quotations, 0 failures**
(`data/fs131/il/quotes.txt`) — `CLAUDE.md` § Counter-priors; the first lines of `LocalSeq`, `frozen`, `limit_isModification` (`Limit.lean`);
this record's Stage 4 "What to prove" and "What it may change" and § 3.2's price line; the inventory's items 371–374 (main tree). `--self-test`
(one letter planted in the first quotation): **fired** (1 failure), exit 0 for the self-test (`data/fs131/il/quotes-selftest.txt`). No mismatch.

Read in full: this record (KL1's §§ 1–4); `Limit.lean`, `Procedure.lean` at `8a42a2e0`; `Chain.lean`; `ArcMap.lean`; `ValidMap/Basic.lean`'s
definitions and engine 1; `LocalMap`'s ring vocabulary; `IsSectorChart` and `localSectors_disj` (`LocalStructure`); `Sectors.lean`'s chart
lemmas; `contact_inType_or_outType` (`Contact`, read only); `ne1_region`, `IsTile.subset_ball` (`Tiles`); inventory items 371–374.

### 5.2 The as-given build (`8a42a2e0`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — all 1757
modules already up to date, nothing built, 10 modules with warnings**, exit 0 (`build/gate/build/20261005T092713Z-3005915.log`; driver log
`data/fs131/il/build-stage1-asgiven.log`). Open `sorry` children in my two files: 18 in `Limit`, 7 in `Procedure` (KL1's count).

### 5.3 Route notes before the first leaf

- **Locality needs no domain hypothesis, through tile size.** In a valid map every tile lies in `B(x, 1)` for each point `x` of its closure
  (`IsTile.subset_ball`, `Tiles`), so a tile at a point of `B̄(v, 2)` lies in `B(v, 3) ⊆ W`; two valid maps agreeing on `W` have the same such
  tiles. That reads `InType`/`OutType` at contacts without KL1's `tile_subset_ball_or_disjoint` (kept as an option, not needed).
- **The limit agrees with a late stage on any set the late supports miss**, not only near compact parts of the domain: `LocallyFinite U` is
  over all of `ℂ`, and pointwise stabilization of arcs at `z ∈ dom` is `frozen` at `{z}`. So `coloursAt` passes at every point, the domain's
  frontier included (`limit_isModification`'s third clause quantifies over all `x`).

## Stage 5 — SAVED (FS131-IL1)

## Stage 6 — SAVED (FS131-IL1): `frozen` and its consumers, and the re-pricing

- **Proved** (commit `a305d41c`, then `333a88cf`): `LocalStep.mono`; `exists_stab` (`LocallyFinite.point_finite`, bounded above);
  `frozen` over the child `arc_origin` (KL1's route exactly: `K'` = the arcs of `F 0` and the supports meeting `K`, compact; past the
  supports meeting `K'` nothing on `K` changes); `limitArcs_locallyFinite`, `limitCol_locallyConstant`, `eventually_agreesOn`, `limit_valid`,
  `limit_isModification`, over five children: `agree_of_not_mem`, `col_eq_limitCol`, `exists_disjoint_of_isCompact`, `limitArcs_inter_eq`,
  `eventually_mem_limitInterior_iff` (pointwise: `frozen` at `{z}`), `agreesOn_of_disjoint` (**the limit agrees with every stage past the supports
  meeting any set `t`, on `t`** — not only near compact parts of the domain, since `LocallyFinite U` is over all of `ℂ`; this is what reads
  `coloursAt` at frontier points of the domain in `limit_isModification`).
- **Build** (`a305d41c`): OK, 447 of 447 batches, 7 modules rebuilt, 8 min 47 s, exit 0 (`build/gate/build/20261005T093324Z-3028114.log`;
  driver log `data/fs131/il/build-stage6.log`).
- **Re-price** (the brief's checkpoint, after `frozen`): `frozen` and its five consumers took well under the plan's "one session" (about a fifth);
  the locality lemmas the same order. `IsClean.eventually_not_isSite` is **H, not M** (planar geometry at a point of `Γ`: see Stage 7);
  `exists_clean` stays **H** (Stage 8 § 8.3 carries the design).

## Stage 6 — SAVED (FS131-IL1)

## Stage 7 — SAVED (FS131-IL1): locality, terminality, sites; the domain defect in three `Procedure` children

- **Locality** (commit `333a88cf`): the six lemmas. `MERGE`'s needs validity only through tiles: **in a valid map a tile lies in `B(x, 1)` for
  each point `x` of its closure** (`IsTile.subset_ball`), so two valid maps agreeing on an open `W ⊇ B̄(v, 3)` have the same tiles at every
  contact (`isTile_of_agreesOn`, `tileOf_iff_of_agreesOn`), hence the same in- and out-types and allowed cones. KL1's
  `tile_subset_ball_or_disjoint` was not needed. Sectors, horns, flanks, clearness (unit circles about points of `B(v, 1)` lie in `B̄(v, 2)`),
  ring arcs, (Q) and (R2) (the witness at distance `2`) are read in `B̄(·, 3)` with no validity.
- `limit_isTerminalMap` and `not_available_of_not_isSite`: proved.
- **`IsClean.eventually_not_isSite`** (commit `d3d38d3a`): at `x ∈ dom` take a good radius `ρ₀` (`exists_goodAt`); at `y ∈ B(x, ρ₀)`, `y ≠ x`,
  `not_isSite_of_goodAt`. Off `Γ` the chart at `y` has no germ and one sector, the ball. On `Γ`, every arc near `y` passes through `y` (good
  radius at `y`) and through `x`, and any two share `y ≠ x`, so (`GoodAt.uniq` at `x`, then `Arc.curve_eq_of_mem`) all lie on one curve through
  `y`; so every germ of `y`'s chart is, at each small distance, one of that curve's two germs (`germ_eq_curveGerm_of_goodAt`, through
  `exists_eq_branchPt_curveGerm`). Distinct germs never meet at one distance (`localSectors_disj`), so there are at most two; clean gives at
  least two; the two leave `y` in opposite directions (their difference quotients tend to norms `0` and `2`), so both sector cones have
  non-empty interior while a horn's has none (`interior_coneAt_hornSet_eq_empty`, from `Contact`'s `e_eq_of_mem_coneAt_hornSet`); the two
  sectors carry the two colours, one sector each. `Limit` now imports `Plane/Tiles`, `Plane/ValidMap/Sectors`, `Plane/ValidMap/Contact`
  (`ARCHITECTURE.md` row updated; `tools/check_architecture.py`: PASS, `data/fs131/il/arch-stage7.txt`).
- **Build** (`7722c2c6`, before `eventually_not_isSite`): OK, 447 of 447 batches, 7 rebuilt, 8 min 46 s, exit 0
  (`build/gate/build/20261005T094524Z-3097403.log`; `data/fs131/il/build-stage7.log`).
- **Statement defect, sent to Keryx mid-job and ruled (inventory item 380): three of KL1's `Procedure` children are false without a domain
  hypothesis.** `badCount_eq_zero_iff (hF : F.Valid) (P : ℂ)` — counterexample: `P = 0`, `k = 2`, `dom = {z : 1/2 < |z| < 3/2, 0 < arg z < π/6}`,
  `arcs = {Arc.circ 0 1 0 (π/6)}`, colour `0` inside `ω(0)` and `1` outside (each colour's part has diameter about `0.81 < 1`, so valid). Its
  ring arcs about `0` are the `[θ₁, θ₂]` with `0 < θ₁ < θ₂ < π/6` (the arc's ends are not in `dom`), none maximal, so `badCount F 0 = 0`; yet none
  is (Q) or (R2), since `0 ∉ closure dom` makes `coloursAt 0 = ∅`. `badCount_lt_top` and `treatPts_inter_finite` have the same gap (maximal arcs,
  or centres in `K` of unit arcs, accumulating at the domain's frontier; sketched, not built). **Old statements**:
  `badCount_eq_zero_iff (hF : F.Valid) (P : ℂ)`, `badCount_lt_top (hF : F.Valid) (hc : F.IsClean) (P : ℂ)`,
  `treatPts_inter_finite (hc : F.IsClean) {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ F.dom)`. **New** (Keryx's ruling): each with
  `(hP : F.IsPlaneMap)` added — after `hF` in the first two (`badCount_lt_top (hF) (hP) (hc) (P)`), first in the third. Their only consumer,
  `exists_terminalSeq`, carries `hP`. Conclusions unchanged; `treatPts_inter_finite` had no `Valid` to drop.
- **Spec examples** (commit `7722c2c6`) owed by KL1's plan: `IsMaxRingArc` (none on the one-colour plane), `badCount` (`0` there), `treatPts`
  (`∅` on the one-colour plane — one sector per point, so no repeated colour and no horn; **adversary**: `0 ∈ unitArcPlane.treatPts`).
- **Statement warts kept, not changed** (KL1's binders): `onRingArc_iff_of_agreesOn`'s `x` and `hW`, `rayAvailable_iff_of_agreesOn`'s and
  `shaveAvailable_iff_of_agreesOn`'s `hW`, `eventually_agreesOn`'s `hKd` are unused by their proofs; each is referenced by a `have _ := …` so the
  unused-variables linter stays silent.

## Stage 7 — SAVED (FS131-IL1)

## Stage 8 — SAVED (FS131-IL1): the handover

### 8.1 The build and the receipt

- **Build** of `d3d38d3a` (the code this record describes; `18437fe0` added only this record): `scripts/slot.py --mem 40 --cpus 8 -- env
  MEMMAX=40G BATCH=4 ./scripts/build.sh` — **OK, 447 of 447 batches, 7 modules rebuilt, 10 with warnings, every warning `declaration uses
  'sorry'`**, 8 min 53 s, exit 0 (`build/gate/build/20261005T095506Z-3150087.log`, which ends "Build completed successfully (5372 jobs)";
  driver log `data/fs131/il/build-stage8.log`). `sorry` declarations: `Limit` 1 (`exists_clean`), `Procedure` 7 (unchanged), `Terminal` 2
  (lane B's).
- **Axioms**, read against that build's oleans (`data/fs131/il/ILAxioms.lean` → `ILAxioms.out`, `slot.py --mem 12 --cpus 2 -- lake env
  lean`, exit 0; summary `data/fs131/il/ILAxioms-summary.txt`): **75 records — 63 on the standard three or fewer, 12 through `sorryAx`, 0
  other.** The twelve: `exists_clean`, the four `Procedure` lemmas of my brief, `exists_vertexStep`, `exists_arcStep`, `exists_terminalSeq`,
  `exists_terminalMap`, `run_ends`, `run_hornBoundsQR`, `stuckRun_ne_univ`. **Control on `sorryAx`**: `exists_clean`, a `sorry` by
  construction, prints `sorryAx`, so the print sees it; and the summary's parse, run on a copy with `sorryAx` planted in `frozen`'s record,
  counted 13 instead of 12 (fired).
- `scripts/Axioms.lean`: 38 records added to the "FS131-I5h" block, above `=== PURCHASED ===` (heading "FS131-IL1"). Map: `tools/check_architecture.py`
  PASS. I ran no gate (my brief).

### 8.2 What is left (my brief's part), with routes

- **`exists_clean`** (`Limit`, H). Design worked out, not built: `E := {x ∈ Γ | 2 ≤ ncard (coloursAt x)}`, closed in `dom` (a point of the
  domain with one colour has a neighbourhood all of whose points carry at most that colour). New interior points `dom \ E`; new colour `F.col`
  on `F.interiorPts`, the one colour of `coloursAt x` on `Γ \ E`. Then: `coloursAt` unchanged (`F.region j ⊆ region' j ⊆ closure (F.region j)`);
  validity because a new interior point of colour `j` lies in `interior (closure (F.region j))`, and two such points at distance exactly `1`
  give an interior unit pair of `F` (a ball in `region j` near one, the unit circle about a point of `region j` near the other, the radial
  point); `Γ' ⊆ Γ` and `IsModification` immediate. **The work is the presentation**: arcs' = the maximal non-degenerate parameter intervals of
  `A_a := {t | a t ∉ dom ∨ a t ∈ E}` (closed) over `a ∈ F.arcs`. Needed: (i) every `x ∈ E` lies on such an interval of some arc (two adjacent
  sectors of `x`'s chart with different colours share a germ, whose branch is essential; rigidity puts that branch on one arc —
  `Arc.finite_inter_sphere_or_eq_circ`-style facts and `germ_eq_curveGerm_of_goodAt` are the tools); (ii) local finiteness: near `x`, `E`-membership
  is constant along each branch of a good chart at `x`, so each arc contributes at most one interval near `x`. Sub-arcs: `main`'s `Surgery`
  (`Arc.sub`) is not on this branch; re-prove or wait for the merge.
- **`treatPts_inter_finite`** (now with `hP`, M): sites — `IsClean.eventually_not_isSite` at each point and `IsCompact.induction_on` (as in
  `finite_arcs_inter_compact`), about 25 lines; centres — the ring arc lies in `Γ ∩ cthickening 1 K`, met by finitely many arcs; one arc holds
  infinitely many of its points, so by `Arc.finite_inter_sphere_or_eq_circ` (`UnitArc`) it is `circ v 1 _ _`: the centres lie in the finite set of
  centres of those arcs.
- **`badCount_eq_zero_iff`** (now with `hP`, M): `←` is immediate (no maximal arc is bad); `→` needs a maximal extension of each ring arc —
  extensions with the same sides are directed (overlapping ones unite), bounded by `l60_le`, and the sup is attained because `Γ ∩ ω(P)` is closed
  in the plane; a sub-arc with the same sides of a (Q) or (R2) arc is one (sides are unique: `innerColours = {c}`).
- **`badCount_lt_top`** (now with `hP`, M): maximal arcs have disjoint interiors (same sides unite; different sides cannot overlap); their ends are
  sites or side changes on the compact `ω(P)`, finitely many by `IsClean.eventually_not_isSite`.
- **`mergeAvailable_of_bothKind`** (M–H, one mind's hand proof): not started; read N2-RED/NB2-RED first (KL1 § 3.1).

### 8.3 Notes for the merge with `main`

`Limit` imports this branch's `Contact` (stale, ruling-269 form) for `e_eq_of_mem_coneAt_hornSet` only; if `main`'s `Contact` renames it, that one
call moves.

## Stage 8 — SAVED (FS131-IL1)

---

# FS131-IL2 — the implementer, lane A continued (`exists_clean`, the three finiteness lemmas, `mergeAvailable_of_bothKind`)

*de Bruijn, the implementer (Opus), on branch `fs131-w5c` from `6a792494`. Brief: `data/fs131/briefs/FS131-IL2-limit.md` (main tree).*

## Theorems this phase proved (FS131-IL2)

All [kernel], read against the stage-11 build's oleans (`data/fs131/il/IL2Axioms.out`, Stage 11): each on `[propext, Classical.choice,
Quot.sound]` or a subset.
- **My brief's five leaves**: `ArcMap.exists_clean` (`Plane/ValidMap/Limit`); `ArcMap.treatPts_inter_finite`, `ArcMap.badCount_eq_zero_iff`,
  `ArcMap.badCount_lt_top`, `ArcMap.mergeAvailable_of_bothKind` (`Plane/ValidMap/Procedure`).
- Children in `Limit`: `Arc.continuous_ptL`, `Arc.carrier_eq_imageL`, `Arc.carrier_subL`, `Arc.nondegenerate_subL` (copies of `main`'s `Surgery`
  lemmas), `Arc.isCompact_paramsL`, `Arc.ordConnected_paramsL`, `Arc.finite_ptL_eq`; `isClosed_ordConnectedComponent`,
  `ordConnectedComponent_eq_Icc`, `eventually_finite_components`, `isPreconnected_ball_diff_singleton`; `ArcMap.coloursAt_nonempty`,
  `.eventually_coloursAt_subset`, `.coloursAt_eq_singleton_of_interior`, `.essSet_subset_Γ`, `.exists_coloursAt_eq_singleton`,
  `.eventually_coloursAt_eq_singleton`, `.isOpen_dom_diff_essSet`, `.notMem_essSet_of_isolated`, `.branchPt_mem_closure_sector_pair`,
  `.germs_le_two_of_goodAt`, `.eventually_essSet_iff_of_goodAt`, `.isClosed_essParams`, `.essComp_eq_Icc`, `.cleanArcs_nondegenerate`,
  `.essParams_eventually_iff`, `.eventually_clean_near`, `.cleanArcs_locallyFinite`, `.essSet_subset_cleanArcs`, `.dom_inter_cleanArcs`,
  `.cleanCol_eq`, `.clean_Γ`, `.clean_interiorPts`, `.region_subset_clean_region`, `.clean_region_subset_closure`, `.coloursAt_clean`,
  `.clean_valid`, `.clean_isClean`; `halfDiscMono_essSet` (spec).
- Children in `Procedure`: `ArcMap.ringPt_add_int`, `.ringArc_add_int`, `.radiusTwoArc_add_int`, `.isRingArc_add_int`, `.isQArc_add_int`,
  `.isR2Arc_add_int`, `.IsRingArc.sides_eq`, `.IsRingArc.mono`, `.mem_Ioo_or_of_overlap`, `.IsRingArc.union`, `.IsQArc.of_subarc`,
  `.IsR2Arc.of_subarc`, `.isClosed_Γ_of_isPlaneMap`, `.exists_isMaxRingArc`, `.IsMaxRingArc.not_regularAt`, `.finite_sites_inter_compact`,
  `.infinite_ringArc`, `.finite_centres_inter_compact`.
- Definitions (each with a spec example): `Arc.ptL`, `Arc.paramsL`, `Arc.subL`, `ArcMap.essSet`, `.essParams`, `.cleanArcs`, `.cleanCol`,
  `.clean`.

## Stage 9 — SAVED (FS131-IL2): the readback and the as-given build

### 9.1 The brief's quotations against their sources (standing rule 3)

Checked by script with IL1's checker, run unchanged (`tools/fs131_il_quotes.py`, in my touches): **12 quotations, 0 failures**
(`data/fs131/il/il2-quotes.txt`) — `CLAUDE.md` § Counter-priors; this record's § 8.2 bullets for `exists_clean`, `treatPts_inter_finite`,
`badCount_eq_zero_iff`, `badCount_lt_top`, `mergeAvailable_of_bothKind`; the inventory's items 380, 381, 382, 383, 373, 374 (main tree).
`--self-test` (one letter planted in the first quotation): **fired** (1 failure; `data/fs131/il/il2-quotes-selftest.txt`). No mismatch.

Read in full: KL1's §§ 2.1, 3.1, 4 (Stages 2–4) and IL1's Stages 5–8 of this record; `Procedure.lean`; `Limit.lean`'s statements, the sites
section and `exists_clean`; `ArcMap` (`Plane/ArcMap.lean`); `IsModification`, `QROnly`, `IsTerminalMap` (`Chain.lean`); `IsRingArc`, `IsQArc`,
`innerColours`, `OnRingArc` (`LocalMap.lean`); `IsR2Arc`, `AgreesOff`, `RingArcsWithin` (`ValidMap/Basic.lean`); `GoodAt`, `exists_goodAt`,
`IsSectorChart`, `isSectorChart_of`, `Arc.branch_mem_of_mem` (`LocalStructure.lean`); inventory items 373, 374, 380–383.

### 9.2 The as-given build (`6a792494`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any edit: **OK — all 1757
modules already up to date, nothing built, 10 modules with warnings**, exit 0 (`build/gate/build/20261005T101037Z-3279589.log`; driver log
`data/fs131/il/build-il2-stage9-asgiven.log`). Open `sorry` in my files: `Limit` 1 (`exists_clean`), `Procedure` 7 (four mine:
`badCount_eq_zero_iff`, `badCount_lt_top`, `treatPts_inter_finite`, `mergeAvailable_of_bothKind`; three not: `exists_vertexStep` (held, item
383 (b)), `exists_arcStep`, `exists_terminalSeq`).

### 9.3 A first observation on `exists_clean` before building

`Γ' = E` is forced, not chosen: if the new map keeps every point's colours and `x ∈ E` (two colours) were interior in the new map, the new
colour would be constant near `x` and `x` would carry one colour. So the presentation — `E` as a locally finite union of arcs — cannot be
avoided, and the work is IL1's (i)–(ii).

## Stage 9 — SAVED (FS131-IL2)

## Stage 10 — SAVED (FS131-IL2): `exists_clean` proved, and the re-pricing

- **`exists_clean` proved** (`Limit`), over the clean map `ArcMap.clean`: same domain; arcs `cleanArcs` — for each arc `a` of `F`, the
  sub-arcs `a.subL s t` over the non-trivial maximal intervals `[s, t]` (`ordConnectedComponent`, closed: `isClosed_ordConnectedComponent`,
  `= Icc`: `ordConnectedComponent_eq_Icc`) of its *essential parameters* `essParams a` (the parameters whose point is off the domain or carries
  two or more colours, `essSet`); colour `cleanCol` (the one colour at a point carrying one). The proof's facts, each a lemma:
  - **`dom ∩ ⋃ cleanArcs = essSet`** (`dom_inter_cleanArcs`), hence `clean.Γ = essSet ⊆ Γ` and `clean.interiorPts = dom \ essSet`. The
    inclusion `essSet ⊆ ⋃ cleanArcs` (`essSet_subset_cleanArcs`) is by isolation: an essential point on no clean arc would have no essential
    point near it (every essential point of `Γ` near `x` lies on an arc through `x`, joined to `x`'s parameter through essential parameters,
    `eventually_finite_components`), and an isolated point of the essential set is not essential (`not_mem_essSet_of_isolated`: the punctured
    disc is connected, `isPreconnected_ball_diff_singleton`, and carries one colour).
  - **Local finiteness** (`cleanArcs_locallyFinite`): in a good ball about `x` the essential status is locally constant on `Γ` off `x`
    (`eventually_essSet_iff_of_goodAt`: a chart at `y ≠ x` has at most two germs, `germs_le_two_of_goodAt`, the argument of IL1's
    `not_isSite_of_goodAt`; with two, every point of `Γ` near `y` is in the closure of both sectors, `branchPt_mem_closure_sector_pair`, copied
    from `fs131-w5`'s `MapTopology`), so along each arc through `x` the essential parameters are, near each parameter at `x`, all or none of
    each side (`essParams_eventually_iff`); a general lemma about a closed set of parameters of a path on a compact interval
    (`eventually_finite_components`) then gives finitely many components near `x`. Finitely many parameters of an arc map to one point
    (`Arc.finite_ptL_eq`).
  - **Validity** (`clean_valid`): two points of the new interior of one colour `j` at distance `1` are moved together by a small vector onto
    an interior point `z` of `F` (of colour `j`) and a point of the closure of `j`'s class at distance `1` from it, against `ne1_region`.
  - **Colours unchanged** (`coloursAt_clean`): `F.region j ⊆ clean.region j ⊆ closure (F.region j)`; clean (`clean_isClean`); `IsModification`
    from `Γ' ⊆ Γ` and the colours.
- **The arc parametrisation** (`Arc.ptL`, `Arc.paramsL`, `Arc.subL`, `continuous_ptL`, `carrier_eq_imageL`, `carrier_subL`, `nondegenerate_subL`) is
  `main`'s `Surgery` block (`Arc.pt`, `Arc.params`, `Arc.sub` and their lemmas) copied under names suffixed `L`, since `Surgery` is not on this
  branch: **at the merge with `main`, delete the copies and rename the uses** (seven names; no statement depends on the suffix).
- **Build** (code at this stage's commit): `slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` — **OK, 447 of 447 batches,
  7 modules rebuilt, 9 with warnings (was 10: `Limit` now has none)**, 8 min 48 s, exit 0 (`build/gate/build/20261005T102944Z-3350317.log`, which
  ends "Build completed successfully (5372 jobs)"; driver log `data/fs131/il/build-il2-stage10.log`). `Limit`: no `sorry`. An iteration copy
  with a planted `example : (1:ℕ) = 2 := rfl` after the proof went red (control).
- **Re-price** (the brief's checkpoint after `exists_clean`): planned H, "400–600 lines, one session"; it took about 800 lines in one pass of
  well under a session (the scratch elaborated after three rounds of local fixes). The three finiteness lemmas re-price to E–M each: `RingGerm`'s
  regular angles (`RegularAt`, `finite_not_regular`) already hold the local structure of `Γ` on a unit circle, and `badCount_lt_top` needs no
  cleanness (the ends of a maximal arc are irregular angles); `mergeAvailable_of_bothKind` stays M (U1 is `ringArc_sideCone_other`, the
  allowed cone's interior is `woodallCone`'s contrapositive, two sectors from the chart's cone intervals, `Mono.disjoint`).

## Stage 10 — SAVED (FS131-IL2)

## Stage 11 — SAVED (FS131-IL2): the three finiteness lemmas and `mergeAvailable_of_bothKind` proved; the handover

### 11.1 What was proved (statements unchanged; `Procedure` now imports `Plane/ValidMap/UnitArc`)

- **`badCount_eq_zero_iff`**: `←` from the definition; `→` by `exists_isMaxRingArc` — the ring arcs with the same sides containing a given one
  are directed (`IsRingArc.union`), at most `60°` long (`l60_le`, hence the new import), and their union is one: its interior angles lie in a
  member, its ends are limits of points of `Γ`, closed in a plane map (`isClosed_Γ_of_isPlaneMap`, where item 380's `hP` is spent); a whole
  turn normalises the start to `[0, 2π)` (`isRingArc_add_int`). (Q) and (R2) pass to sub-arcs with constant sides (`IsQArc.of_subarc`,
  `IsR2Arc.of_subarc`) and through turns.
- **`badCount_lt_top`**: the ends of a maximal arc are **irregular angles** of the ring (`IsMaxRingArc.not_regularAt`: at a regular end the
  arc would unite with the arc through it, `RingGerm`'s `RegularAt`), and the irregular angles of a bounded range are finitely many
  (`finite_not_regular`, wave 3); a maximal arc starts in `[0, 2π)` and is at most `60°` long. **Cleanness is not used** (`hc` is kept and
  referenced by `have _ := hc`; a generalization for the coordinator).
- **`treatPts_inter_finite`**: sites — isolated (`IsClean.eventually_not_isSite`), so finitely many in a compact part of the domain
  (`finite_sites_inter_compact`); centres — a centre in `K` has a ring arc in `cthickening 1 K` (compact, in the domain: `hP`), met by finitely
  many arcs; the ring arc is infinite (`infinite_ringArc`), so one of them meets `ω(v)` infinitely often and is an arc of `ω(v)`
  (`Arc.finite_inter_sphere_or_eq_circ`): the centres are among the finitely many centres of those arcs (`finite_centres_inter_compact`).
- **`mergeAvailable_of_bothKind`** (N2-RED's parenthesis, one mind's hand proof — now kernel-checked; no configuration failed): the side
  colours differ (U1 puts their cones in the facing and the away intervals, `disj_lifts`); every direction of the two open side cones is a
  direction of a colour other than `c`, `c'` (`ringArc_sideCone_other`), and at most three colours make it one colour `d`; `d` has **two
  sectors** — in the chart at `P` a single `d`-sector's cone interval would hold a direction of each side cone, so (its length at most `2π`)
  the facing or the away interval strictly inside it, with a direction of `c` or `c'` there, against `Mono.disjoint`; and `d`'s **allowed cone
  has interior** — else every `d`-sector is a horn along one axis (`woodallCone`), but two directions of one side cone `w/2` apart are not both
  `α + nπ`. The proof uses `hP` only for `P ∈ dom` and `F.Covers P 1`.

### 11.2 The build and the receipt (the handover)

- **Build** (code at this stage's commit): `slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` — **OK, 447 of 447 batches,
  7 modules rebuilt, 9 with warnings, every warning `declaration uses 'sorry'`**, 8 min 51 s, exit 0 (`build/gate/build/20261005T104536Z-3456361.log`,
  which ends "Build completed successfully (5372 jobs)"; driver log `data/fs131/il/build-il2-stage11.log`). `sorry` declarations in lane A's files:
  `Limit` 0; `Procedure` 3 — `exists_vertexStep` (held, item 383 (b)), `exists_arcStep`, `exists_terminalSeq` (none in my brief); `Terminal` 2 (lane B's).
- **Axioms**, read against that build's oleans (`data/fs131/il/IL2Axioms.lean` → `IL2Axioms.out`, `slot.py --mem 12 --cpus 2 -- lake env lean`,
  exit 0; summary `data/fs131/il/IL2Axioms-summary.txt` by `tools/fs131_il_axsum.py`, exit 0): **132 records (IL1's 75 and my 57) — 125 on the
  standard three or fewer, 7 through `sorryAx`, 0 other.** The seven: `exists_vertexStep`, `exists_arcStep`, `exists_terminalSeq`, and through them
  `exists_terminalMap`, `run_ends`, `run_hornBoundsQR`, `stuckRun_ne_univ`. My five leaves each print `[propext, Classical.choice, Quot.sound]`.
  **Control on `sorryAx`**: `exists_vertexStep`, a `sorry` by construction, prints `sorryAx`, so the print sees it; the summary's parse, run with
  `sorryAx` planted into the first standard record, counted `(124, 8)` instead of `(125, 7)` (fired, `IL2Axioms-selftest.txt`); and a source with
  one print command the output lacks made it exit 1 (`MISMATCH: 76 print commands but 75 records`, on IL1's files).
- **Statements unchanged**: `tools/fs131_il_stmt_check.py 6a792494` — every declaration of `Limit`, `Procedure`, `Terminal`, `Chain` at `6a792494`
  present with the same statement (a definition's whole body compared) — **PASS**, exit 0 (`data/fs131/il/il2-stmt-check.txt`); `--self-test`:
  five plants (a hypothesis of `badCount_lt_top` dropped, `exists_clean`'s conclusion reversed, `mergeAvailable_of_bothKind` renamed, `treatPts`'s
  body changed, `IsModification`'s signature changed) each **fired**, the unplanted control PASS (`il2-stmt-check-selftest.txt`). FS131-I5h's
  checker, which this copies, read a `def … := {…}` up to the next `:= by`, so a lemma inserted after `treatPts` read as a change to it (a false
  FAIL); fixed in my copy, the original left as it is (rule 7).
- **Map**: `ARCHITECTURE.md` rows `Limit` (stage 10) and `Procedure` (description; Imports cell gains `Plane/ValidMap/UnitArc`);
  `tools/check_architecture.py` PASS, exit 0 (`data/fs131/il/arch-il2-stage11.txt`); with the new import removed from the cell it failed,
  naming `Procedure` (control), then PASS again on the restored row.
- **Receipt**: 57 records appended to the "FS131-I5h" block of `scripts/Axioms.lean` (heading "FS131-IL2"), above `=== PURCHASED ===`; the five
  leaves were already listed by KL1. I ran no gate (my brief).
- **Spec examples** (`Limit`'s Spec section): `Arc.ptL`, `Arc.paramsL`, `Arc.subL` (two); `essSet` (`halfDiscMono_essSet`: a one-coloured segment
  has no essential point); `clean` (`halfDiscMono.clean.Γ = ∅`) and its **adversary** (`0 ∈ halfDisc.clean.Γ`: a two-coloured segment is kept);
  `essParams` (the segment's start, off the domain, is essential; its midpoint is not); `cleanCol` (an interior point keeps its colour).

### 11.3 What is left (lane A: nothing of my brief)

All five children of my brief are proved. Left in `Procedure`, none mine: `exists_vertexStep` (its degree clause held, item 383 (b); E6 derives
OPEN), `exists_arcStep`, `exists_terminalSeq`; in `Terminal`, lane B's `run_hornBoundsQR`, `stuckRun_ne_univ`.

### 11.4 Notes for the merge with `main`

- `Arc.ptL`, `Arc.paramsL`, `Arc.subL`, `Arc.continuous_ptL`, `Arc.carrier_eq_imageL`, `Arc.carrier_subL`, `Arc.nondegenerate_subL` (`Limit`) are
  `main`'s `Surgery` `Arc.pt`, `Arc.params`, `Arc.sub` and lemmas copied under suffixed names: delete them at the merge and rename their uses (all
  in `Limit`'s clean section and its spec examples). `branchPt_mem_closure_sector_pair` is `fs131-w5`'s `BranchGerms.branchPt_mem_closure_sector`
  (`MapTopology`), re-proved under another name.
- `germs_le_two_of_goodAt` is the at-most-two-germs argument inside IL1's `not_isSite_of_goodAt`, factored out; that proof can call it.

## Stage 11 — SAVED (FS131-IL2)

---

# FS131-IR1 — the implementer: the procedure's last steps (`fs131-wop` merged in, the two steps restated, the leaves under `exists_terminalMap` and in `Terminal`)

*de Bruijn, the implementer (Opus), on branch `fs131-w5c` from `87e95385`. Brief: `data/fs131/briefs/FS131-IR1-procedure.md` (main tree).*

## Theorems this phase proved (FS131-IR1)

All [kernel], read against the Stage-17 build's oleans (`data/fs131/ir/IRAxiomsFinal.out`): each on `[propext, Classical.choice, Quot.sound]` or a
subset unless marked. Statements unchanged but the two ruled restatements.
- **`ArcMap.horn_bounds_of_interior_empty`** (`Plane/ValidMap/FlankUA`) — FS131-E6-CONE: a horn of a colour whose allowed cone has empty interior
  has bounds in `[−1, 1]`.
- **`ArcMap.exists_terminalSeq`** (`Plane/ValidMap/Procedure`) — the procedure: **proved over open children** (no `sorry` of its own; on `sorryAx`
  through `ArcMap.exists_procStep` alone, which cites `exists_vertexStep` and `exists_arcStep`).
- The run, in `Procedure`: `ArcMap.eventually_ball_subset_compl`, `.hasDegree_iff_of_agreesOff`, `.hasHornCount_iff_of_agreesOff`,
  `.isSite_iff_of_agreesOff`, `.badCount_eq_of_agreesOff`, `.exists_hasHornCount`, `.pot_eq`, `.finite_strict_of_antitone_off`, `.ProcInv.refl`,
  `.ProcInv.mem_treatPts_of_todo`, `.ProcStep.refl`, `.isCompact_ringArc`, `.dist_of_mem_cthickening_ringArc`, `.ProcRun.finite_vert`,
  `.ProcRun.finite_colChange`, `.ProcRun.finite_arc`, `.ProcRun.finite_acted`, `.ProcRun.locallyFinite`, `.ProcRun.eventually_not_todo`;
  `const_treatPts`.
- Cleaning a step, in `Procedure`: `Arc.exists_params_eq_Icc`, `ordConnectedComponent_Icc`, `ArcMap.cleanKeep_Γ`, `.cleanKeep_interiorPts`,
  `.cleanKeep_col`, `.cleanKeep_col_of_not_mem`, `.cleanKeep_region`, `.coloursAt_cleanKeep`, `.cleanKeep_valid`, `.cleanKeep_isClean`,
  `.cleanKeep_isModification`, `.essParams_eq_params_of_disjoint`, **`.LocalStep.cleanKeep`**, `.LocalStep.exists_clean`,
  **`.surgery_localStep`**, `.surgery_cleanKeep_localStep`.
- Definitions (each with a spec example or a named inhabitant): `ArcMap.pot`, `.MoveAt`, `.Todo`, `.ProcInv`, `.ProcStep`, `.ProcRun`,
  `.ProcRun.const`, `.cleanKeep`.
- On this branch after the merge (proved on `fs131-wop`; standard three against this branch's build, Stage 13): `ArcMap.exists_open` and
  `OpenMove`'s theorems.

## Stage 12 — SAVED (FS131-IR1): the readback and the as-given build

### 12.1 The brief's quotations against their sources (standing rule 3)

Checked by script, `tools/fs131_ir_quotes.py` (IL1's checker copied under this job's prefix; rule 7 bars editing another job's tool): **24
quotations, 0 failures** (`data/fs131/ir/quotes.txt`) — `CLAUDE.md` § Counter-priors; the inventory's items 411, 403, 398, 388, 408, 382, 383, 384,
385, 372 (main tree); the first lines of `exists_vertexStep`, `exists_arcStep`, `exists_terminalSeq` (`Procedure.lean`) and `stuckRun_ne_univ`
(`Terminal.lean`) at `87e95385`; E6's § 4.5 drafts (three lines of the restated `exists_vertexStep`, the horn clause) and § 4.3's opening;
`exists_open` and `HasHornCount` (`fs131-wop`'s `OpenMove.lean`, read at `a20bb6f5`'s text); this record's § 3.1 row for `stuckRun_ne_univ` and § 3.3's
opening. `--self-test` (one letter planted in the first quotation): **fired** (1 failure; `data/fs131/ir/quotes-selftest.txt`). No mismatch.

Read in full: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` §§ Building, Make the gate fail; this record (KL1's §§ 1–4, IL1's Stages
5–8, IL2's Stages 9–11); M6's Stages 53–55 (`plans/FS131-I5-implementation.md`); E6's derivation §§ 3–4 (main tree); OPEN's record's Stage 15 and
`OpenMove.lean`'s header, `HasHornCount`, `exists_open` (`fs131-wop`); `Procedure.lean` whole; `Limit.lean`'s `LocalStep`, `LocalSeq`, `IsClean`,
`IsSite`, the clean section; `Basic.lean`'s and `Chain.lean`'s definitions; the three `…_aux` moves (`Moves.lean`) and `Contact`'s `exists_shave`,
`exists_rayMerge`, `exists_merge`; inventory items 372, 382–385, 398–411.

### 12.2 Two things the readback found (neither a mismatch of a quotation)

- **`exists_open` as proved carries a hypothesis E6's draft did not**: `(h1 : F.HasSectors v c 1)` (the horn's colour has one sector at `v`; IO1's
  settlement). E6-ROUTE (§ 4.3) calls OPEN only at a lone horn, so the vertex step's route is unchanged; the case "a horn of a repeated colour with
  `int D_c(v) ≠ ∅`" is MERGE's (the colour then has two sectors and a non-empty interior), never OPEN's.
- **The four moves' statements export neither `LocalStep`, nor a radius below `δ` (OPEN's apart), nor the points strictly inside the disc** (they
  give `AgreesOff`, `RingArcsWithin`, the colour's sector count at `v`, the colours at `v`, and the rim's colours). So `exists_vertexStep` re-opens
  each construction (`F.surgery v ρ …`), as KL1's § 3.3 planned; the brief's "new declarations downstream only" stands.

### 12.3 The as-given build (`87e95385`)

`/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before any
edit: **OK — all 1784 modules already up to date, nothing built, 5 modules with warnings**, exit 0, 2 s
(`build/gate/build/20261006T023212Z-73259.log`; driver log `data/fs131/ir/build-stage12-asgiven.log`). `sorry` declarations in my files:
`Procedure` 3 (`exists_vertexStep`, `exists_arcStep`, `exists_terminalSeq`), `Terminal` 1 (`stuckRun_ne_univ`).

### 12.4 What I may and may not change (the brief's `touches` and § What is yours to decide)

**May**: merge `a20bb6f5` (keeping both sides in `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`); restate `exists_vertexStep` (E6's form) and
`exists_arcStep` (the horn clause), and settle their final form where the kernel shows the draft needs a change, recording the diff and the reason;
prove `exists_terminalSeq`, `stuckRun_ne_univ` and children beside them; add supporting lemmas in `FlankUA` and `HornShadow`; add a module downstream
of `Moves`, `MergeMove`, `OpenMove` for the moves' exported lemmas; a block of my own in `scripts/Axioms.lean`; `tools/fs131_ir_*.py`,
`data/fs131/ir/`, this record, the report. **May not**: edit `OpenMove.lean`, or a statement or definition in `Moves`, `MergeMove`, `Contact`,
`UnitArc` or any module on `main`; `BaseDense`, `BendCollar`, `HexRing`; `exists_terminalMap`'s statement (and `exists_terminalSeq`'s only after a
message); `main`; the gate scripts' recorded counts; no new `axiom`, no `native_decide`. I do not merge into `fs131-w5`, take `main` beyond the merge
above, or run the full gate.

## Stage 12 — SAVED (FS131-IR1)

## Stage 13 — SAVED (FS131-IR1): `a20bb6f5` (`origin/fs131-wop`'s tip: `main` plus `OpenMove`) merged into `fs131-w5c`

`git merge --no-ff --no-commit a20bb6f5` at `61a0b31d` (one merge base, `1be5d622`: `main` as M5 merged it). **The merge commit is `533195c4`**
(parents `61a0b31d`, `a20bb6f5`). `origin/fs131-wop` had moved to `dff76573` (FS131-OL1's landing work) when I fetched; every check below names
`a20bb6f5`, never the moving ref. Git merged `Proofs.lean` (one import line added: `OpenMove`) and `ARCHITECTURE.md` (one row added) by itself; **one
conflict**, in `scripts/Axioms.lean` (this branch's wave-5 blocks against OPEN's block, both above `=== PURCHASED ===`), resolved by keeping both
blocks, ours first, one blank line between. The other 40 files are `fs131-wop`'s alone (`OpenMove.lean`, E6's and IO's records, tools and data).

### 13.1 The checks

- **Files, byte for byte** — `tools/fs131_ir_merge_check.py` (mine: every path of the three trees; a file changed by one side is that side's blob;
  the three keep-both files have exactly ours' + theirs' − base's lines, no import, axioms record or module row twice): **PASS, 15,679 files**, on
  the index before the commit (`data/fs131/ir/merge-check.txt`) and on `533195c4` after it (`merge-check-committed.txt`). `--self-test`: a byte in
  `OpenMove.lean`, a line added to `Procedure.lean`, `Proofs.lean`'s `OpenMove` import dropped, a doubled axioms record, a both-changed file outside
  the three — **each FIRED naming its file**, the unplanted run PASS (`merge-check-selftest.txt`). *Tool defects of my own, caught by the
  self-test before use*: the first version read the merged side through the working tree and failed on 11 symlinks (fixed: blob hashes from the
  index); and its self-test demanded exactly one failure line per plant, so the doubled record, which trips two checks of one file, read "did not
  fire" (fixed: every failure names the planted file).
- **Statements, three-way** — `tools/fs131_wl_mergestmts.py 61a0b31d a20bb6f5` (WL1's, run unchanged): **7,460 names, 0 mismatches or conflicts, 0
  base conflicts — PASS** (`mergestmts.txt`); `--plant` (`HasDegree.eq`'s merged statement altered): MISMATCH, exit 1 (`mergestmts-plant.txt`).
- **No declaration twice** — M6's `tools/fs131_m6_dupes.py 61a0b31d a20bb6f5 1be5d622`: 0 NAME/STATEMENT pairs. **Its `--plant` cannot fire with
  this merge's refs** (exit 0: its plants re-declare `exists_shave_aux`, `isPreconnected_hornSet` and `branchPt_mem_closure_sector_pair`, all
  declared at this merge's fork, so they read as inherited or STATEMENT-OLD) — a control whose failure is unreachable here. So
  `tools/fs131_ir_dupes.py`: M6's tool copied under my prefix with only the plants changed to names new at `a20bb6f5` (`ArcMap.exists_open`
  re-declared; `ne_hornSet_of_interior_coneAt`'s statement under a new name; the same with two binders made explicit; a docstring line
  "class exists_open"). Unplanted: **0 NAME/STATEMENT pairs**, 11 STATEMENT-OLD/PRIVATE and 5 CONCL candidates, all M6's known ones
  (`dupes-premerge.txt`, exit 0). `--plant`: **exactly the three it must** (NAME, STATEMENT, STATEMENT-NORM), the docstring line not reported, exit 1
  (`dupes-plant.txt`).
- **The map**: `tools/check_architecture.py` PASS, exit 0 (`arch-stage13.txt`; `OpenMove`'s row is `fs131-wop`'s).
- **The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 457 of 457 batches, 2 modules rebuilt (`OpenMove` 10 s, `Proofs`), 5 modules with
  warnings, all 9 warnings `declaration uses 'sorry'`**, 8 min 21 s, exit 0 (`build/gate/build/20261006T024750Z-282826.log`; driver log
  `data/fs131/ir/build-stage13-merge.log`).
- **Axioms**, against that build's oleans (`data/fs131/ir/IRAxioms13.lean` → `IRAxioms13.out`, `slot.py --mem 12 --cpus 2 -- lake env lean`, exit
  0; read by `tools/fs131_ir_axsum.py … --expect-sorry exists_vertexStep,exists_arcStep,exists_terminalSeq,exists_terminalMap,stuckRun_ne_univ`,
  `IRAxioms13-summary.txt`, PASS): **12 records, 7 on the standard three, 5 through `sorryAx`, 0 other.** `exists_open`,
  `Near.open_allowedCone`, `Near.open_degree_horns`, `HasHornCount.eq`, `exists_clean`, `mergeAvailable_of_bothKind`, `run_hornBoundsQR` on
  `[propext, Classical.choice, Quot.sound]`; **controls on `sorryAx`**: `exists_vertexStep`, `exists_arcStep`, `exists_terminalSeq`, and through
  them `exists_terminalMap`; `stuckRun_ne_univ`. The summarizer's `--self-test` (`axsum-selftest.txt`): `sorryAx` planted in a standard record, a
  primed record dropped, a foreign axiom, an expected `sorry` that is standard — each FIRED, the control PASS.

No statement of either side changed; no `axiom`, no `native_decide`.

## Stage 13 — SAVED (FS131-IR1)

## Stage 14 — SAVED (FS131-IR1): the two steps restated (rulings 383 (b), 385 (a)); both still `sorry`

**`exists_vertexStep`** — E6's draft (§ 4.5 (2)) taken as it stands; the diff of the statement (`data/fs131/ir/restate.diff` has the whole file's):

```
-    (hav : F.MergeAvailable v ∨ F.RayAvailable v ∨ F.ShaveAvailable v) {m : ℕ} (hdeg : F.HasDegree v m) {δ : ℝ} (hδ : 0 < δ) :
+    (hav : F.MergeAvailable v ∨ F.RayAvailable v ∨ F.ShaveAvailable v) {m j : ℕ} (hdeg : F.HasDegree v m)
+    (hhorn : F.HasHornCount v j) {δ : ℝ} (hδ : 0 < δ) :
     ∃ ρ, 0 < ρ ∧ ρ < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
-      (∃ m' < m, F'.HasDegree v m') ∧ F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
+      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
+      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
```

**`exists_arcStep`** — one clause added after the degree clause, nothing else changed:

```
       (∀ x m, F.HasDegree x m → F'.HasDegree x m) ∧
+      (∀ x j, F.HasHornCount x j → ∃ j' ≤ j, F'.HasHornCount x j') ∧
       ∀ Q ∈ T, Q ≠ P → F'.coloursAt Q ⊆ F.coloursAt Q ∧
```

Docstrings: the vertex step's now names the four moves in E6-ROUTE's priority order (MERGE; else MERGE-RAY; else SHAVE where `int D_c(v) = ∅`; else
OPEN), says why the potential and not the degree (E6-NODROP), and carries an inhabitant note (no Lean model on file; E6's map at [hand]); the arc
step's names the horn clause and its reason (ruling 385 (a)); the module header reads "potential" and distance `4`. `Procedure` now imports
`Plane/ValidMap/OpenMove` (for `HasHornCount`); `ARCHITECTURE.md`'s row's Imports cell updated — `tools/check_architecture.py` PASS
(`data/fs131/ir/arch-stage14.txt`), and with the new import taken out of the cell it FAILED naming `Plane/ValidMap/Procedure`
(`arch-stage14-control.txt`), then PASS again on the restored row.

**Build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 457 of 457 batches, 6 modules rebuilt, 5 with warnings, all 9 warnings `declaration uses
'sorry'`** (`Procedure` at `exists_vertexStep`, `exists_arcStep`, `exists_terminalSeq`; `Terminal` at `stuckRun_ne_univ`; `BaseDense` 3, `BendCollar`
1, `HexRing` 1, none mine), 9 min 11 s, exit 0 (`build/gate/build/20261006T025905Z-360384.log`; driver log `data/fs131/ir/build-stage14-restate.log`).

**The drafts settled against the kernel before this stage was saved** (iteration, `data/fs131/ir/scratch/Seq.lean`; the real build is Stage 15's):
`exists_terminalSeq` elaborates over exactly these two statements, so **E6's draft of the vertex step and the horn clause of the arc step need no
further change for their consumer**. Two things the consumer reads that the statements do not state, both derived from `LocalStep`: the colours at
`P` after an arc step at `P` (the support, within `ε < 1/2` of `ω(P)`, misses `P`), and every clause at treatment points off a vertex step's disc
(sectors, horns, sites and colours are read in small balls; the bad count in `B̄(·, 3)`).

## Stage 14 — SAVED (FS131-IR1)

## Stage 15 — SAVED (FS131-IR1): `exists_terminalSeq` proved over the two steps; E6-CONE (`horn_bounds_of_interior_empty`) proved; the re-pricing

### 15.1 `exists_terminalSeq` (`Procedure`; statement unchanged) — no `sorry` of its own

The procedure as a run, in `Procedure`'s new section "The run" (about 520 lines):
- **Locality off a step's closed support, at small radii** — `eventually_ball_subset_compl`, `hasDegree_iff_of_agreesOff`,
  `hasHornCount_iff_of_agreesOff`, `isSite_iff_of_agreesOff` (sectors are read in small balls; IL1's locality lemmas ask for `B̄(·, 3)` inside the
  agreement set, too coarse for a point just outside a small disc), and `badCount_eq_of_agreesOff` (ring arcs, (Q), (R2) in `B̄(·, 3)`).
- **The potential** — `exists_hasHornCount` (every point of the domain has a horn count: the chart's number of cusps, `0` at a chart with no germ);
  `pot` (degree plus horn count; a definition, `0` where either is undefined) with `pot_eq`.
- **One counting lemma** — `finite_strict_of_antitone_off`: a sequence of naturals that rises only at finitely many stages falls at finitely many.
- **The invariant** `ProcInv F G` (clean, valid, of the plane, a modification of `F`, sites among `F`'s treatment points;
  `ProcInv.mem_treatPts_of_todo`: something to do only at `F`'s treatment points — a move needs a site, a bad arc a centre, and a modification
  creates no centre) and **one step** `ProcStep T f G G' U a` (`a = none`: idle; `some (t, true)`: a vertex step at `t`; `some (t, false)`: an arc
  step), nine clauses; `ProcStep.refl` (the idle step); **`exists_procStep`**: the step exists — at the least-index treatment point with something
  to do, `exists_vertexStep` with `δ ≤ 1/2` below the distance to every other treatment point, else `exists_arcStep` at a bad maximal arc with
  `δ = 1/2` (its sides are not both at the centre: a both-kind arc at a centre of four colours is (Q), and of at most three makes MERGE available,
  `mergeAvailable_of_bothKind`).
- **A run** `ProcRun F f` (`ProcRun.const`: the idle run, its inhabitant) and KL1's three children under other names: **`acted_finitely`** is
  `ProcRun.finite_acted` (`finite_vert`: the potential never rises at a treatment point and falls at each vertex step at it; `finite_colChange`: its
  colours only shrink; `finite_arc`: its bad count falls at each arc step at it and rises only where it loses a colour or a vertex step acts within
  `4` of it — finitely many stages); **`supports_locallyFinite`** is `ProcRun.locallyFinite` (a support meeting `B(x, 1)` belongs to a step at a
  treatment point within `3`); **`fair`** is `ProcRun.eventually_not_todo` (past the stages acting at the treatment points of index at most `v`'s,
  a `v` with something to do would be the least-index choice).
- `exists_terminalSeq`: an injective index on `treatPts F` (countable: finite in each `B̄(0, n)`), the run by `choose!` and iteration, the
  `LocalSeq`, and `badCount_eq_zero_iff` at the end.

**What the kernel settled about the two restated statements**: they suffice as drafted. No clause was added for the consumer, none is unused: of
the vertex step, `LocalStep`, the potential drop, the colours at `v`, "no other site in the disc", `ρ < δ`, cleanness, validity, modification are
each read; of the arc step, every clause is read, the horn clause in `pot_le`. The distance in `acted_finitely` is `4` where KL1 wrote `3` (a vertex
step's disc of radius below `1/2` must miss `B̄(Q, 3)`).

### 15.2 E6-CONE — `horn_bounds_of_interior_empty` (`FlankUA`, after `horn_bounds_of_noMerge`)

E6's § 4.5 (1) statement as drafted; `horn_bounds_of_noMerge`'s proof from its line `have hD` on. An `example` beside it reads
`horn_bounds_of_noMerge`'s statement off it (so that lemma's inhabitant, `bowtie` at `0`, satisfies the new hypotheses).

### 15.3 The build, the receipt, the checks

- **Build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 457 of 457 batches, 8 modules rebuilt, 5 with warnings, all 8 warnings `declaration uses
  'sorry'`** (`Procedure` now at `exists_vertexStep` and `exists_arcStep` only; `Terminal` at `stuckRun_ne_univ`), 9 min 43 s, exit 0
  (`build/gate/build/20261006T031008Z-441105.log`; driver log `data/fs131/ir/build-stage15.log`).
- **Axioms** against that build (`data/fs131/ir/IRAxioms15.lean` → `.out`; `tools/fs131_ir_axsum.py` with the expectation
  `exists_vertexStep, exists_arcStep, exists_procStep, exists_terminalSeq, exists_terminalMap, exists_red, exists_terminal, stuckRun_ne_univ`;
  `IRAxioms15-summary.txt`, PASS): **30 records — 22 on the standard three, 8 through `sorryAx`, exactly the eight expected, 0 other.** Standard:
  `horn_bounds_of_interior_empty`, the five locality lemmas, `exists_hasHornCount`, `pot_eq`, `finite_strict_of_antitone_off`,
  `ProcInv.mem_treatPts_of_todo`, `ProcStep.refl`, `isCompact_ringArc`, `dist_of_mem_cthickening_ringArc`, the six `ProcRun` theorems,
  `const_treatPts`, and (re-read) `exists_open`, `horn_bounds_of_noMerge`. **`exists_terminalSeq` is on `sorryAx` through `exists_procStep`
  alone, which cites the two steps**: every `ProcRun` theorem is standard, and the build's warnings name exactly two `sorry` declarations in
  `Procedure`. `exists_terminalMap`, `exists_red`, `exists_terminal` follow it (`exists_terminal` also reads `stuckRun_ne_univ`).
- **Statements**: `tools/fs131_il_stmt_check.py 87e95385` (IL2's, run): exactly two changed, `exists_vertexStep` and `exists_arcStep`, the ruled
  restatements (`stmt-check-15.txt`, exit 1 as it must be); against Stage 14's commit `9489c44b`: PASS, additions only (`stmt-check-15b.txt`).
  `FlankUA`'s diff is 27 added lines. `tools/check_architecture.py` PASS (`arch-stage15.txt`; `Procedure`'s row describes the run).
- **Receipt**: a block "FS131-IR1" of 21 records in `scripts/Axioms.lean`, above `=== PURCHASED ===`.
- **Spec examples** (`Procedure`'s Spec section): `Todo`/`MoveAt` (nothing to do on the one-colour plane, by the now-named `const_treatPts`; two
  adversaries: a bad arc alone, an available MERGE alone), `pot` (it is the degree plus the horn count at every point of the domain, the degree at
  least `1`), `ProcInv` (a clean valid plane map over itself), `ProcStep` (the idle step, with its acted point not a vertex step); `ProcRun.const` is
  `ProcRun`'s named inhabitant.

### 15.4 Re-pricing after the first two leaves (the brief's checkpoint)

`horn_bounds_of_interior_empty`: minutes, as E6 said. `exists_terminalSeq`: KL1 priced H, "about 400 lines, one session"; it took about 520 lines
in one pass with three rounds of local fixes — a quarter of a session, and no geometry. What is left re-prices as follows. `exists_vertexStep`
stays **H, two sessions**: none of the four moves' statements exports `LocalStep`, a radius below `δ` (OPEN's apart) or the points strictly inside
the disc, so each construction is re-opened; `LocalStep` from `surgery` is one generic lemma and the radius a line each, and the long part is the
cleaned map's sectors at `v` (degree and horn count) and at every other point of the closed disc (no site). `exists_arcStep` stays **H**, with the
N2-TAN bend as a child. `stuckRun_ne_univ` stays **M–H, one session** (M6's route), untouched.

## Stage 15 — SAVED (FS131-IR1)

## Stage 16 — SAVED (FS131-IR1): cleaning a step — `cleanKeep`, `LocalStep.cleanKeep` (a finding about the route "a move, then `exists_clean`")

**The finding.** KL1's routes for both steps end "then `exists_clean`". `exists_clean`'s statement gives no `LocalStep`, and its witness `ArcMap.clean`
cannot be shown to be one: `clean` sets the colour function to `cleanCol` at **every** point, and at a point of two or more colours `cleanCol` is
`Set.Nonempty.some` of the colours there — a choice that nothing ties to the colour function before the step — while `LocalStep.agreesOff`
(`AgreesOff`, wave 4's definition) asks for equal colour functions at every point off the support, the points of arcs included. So
`LocalStep F F'.clean U` is not provable for an arc of `F` far from `U` (not refutable either: the choice is opaque). No statement is wrong; the
route needs a different witness.

**The repair, [kernel]** (`Procedure`, section "Cleaning a step", about 170 lines; no statement of `Limit` touched):
- `ArcMap.cleanKeep` — the clean map with the colour function changed only on the new interior (`dom \ essSet`) and kept elsewhere; the same
  domain and arcs as `clean`, so `cleanKeep_Γ`, `cleanKeep_interiorPts` are `clean`'s; `cleanKeep_col`, `cleanKeep_col_of_not_mem`,
  `cleanKeep_region` (the same colour classes), `coloursAt_cleanKeep`, `cleanKeep_valid`, `cleanKeep_isClean`, `cleanKeep_isModification`.
- **`LocalStep.cleanKeep`** — a local step from a **clean** map on a **closed** support is still a local step after the new map is cleaned with
  its colour kept. Off the support the new interior is the old one (the old map is clean) with its colours; an old arc missing the support is
  kept as the same arc (`essParams_eq_params_of_disjoint`: each of its points keeps its two colours, so its one clean piece is itself —
  `Arc.exists_params_eq_Icc`, `ordConnectedComponent_Icc`); a clean arc is a piece of an arc of the step.
- `LocalStep.exists_clean` — the packaged form (clean, valid, a local step, a modification, the same colours, no new point of `Γ`).

**Build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 457 of 457 batches, 6 modules rebuilt, 5 with warnings, all 8 warnings `declaration uses
'sorry'`** (`Procedure` at the two steps only), 9 min 14 s, exit 0 (`build/gate/build/20261006T032147Z-527023.log`; driver log
`data/fs131/ir/build-stage16.log`). **Axioms** (`data/fs131/ir/IRAxioms16.lean` → `.out`, `IRAxioms16-summary.txt`, PASS): 15 records — the 14
new ones on the standard three or fewer, the control `exists_vertexStep` on `sorryAx`. `tools/check_architecture.py` PASS (`arch-stage16.txt`).
Spec examples: `halfDiscMono.cleanKeep.Γ = ∅`; the adversary (on the essential set `cleanKeep` keeps the old colour function); cleaning a clean
map is an idle step (`LocalStep.cleanKeep`'s hypotheses inhabited by `LocalStep.refl`).

## Stage 16 — SAVED (FS131-IR1)

## Stage 17 — SAVED (FS131-IR1): a surgery is a local step; the handover

### 17.1 Added in this stage ([kernel], `Procedure`)

- **`surgery_localStep`** — every `F.surgery v ρ A col' …` whose new arcs lie in `B̄(v, ρ)` and whose colouring is `F`'s off it is a
  `LocalStep F _ (closedBall v ρ)`: an arc of `F` missing the closed ball misses `v` and is kept whole by `trimArcs`; a trimmed arc that is no arc
  of `F` is an outer piece of an arc through `v` (`Arc.outer_spec`). All four moves are of this form (MERGE's and OPEN's `surgery`; MERGE-RAY's and
  SHAVE's `Near.move`), so KL1 § 3.3's `LocalStep` clause is one lemma, not four. `surgery_cleanKeep_localStep`: the same after cleaning, from a
  clean map.
- `ProcInv.refl` (the invariant's named inhabitant; `exists_terminalSeq` cites it). The module header no longer says "followed by `exists_clean`".

### 17.2 The build and the receipt (the handover)

- **Build** of this stage's code (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 457 of 457 batches, 6 modules rebuilt, 5 with warnings, all 8 warnings
  `declaration uses 'sorry'`**, 9 min 14 s, exit 0 (`build/gate/build/20261006T034742Z-719788.log`, which ends "Build completed successfully (5792
  jobs)"; driver log `data/fs131/ir/build-stage17-final.log`). The `sorry` declarations: `Procedure` 2 (`exists_vertexStep` l. 795,
  `exists_arcStep` l. 812), `Terminal` 1 (`stuckRun_ne_univ` l. 3592); not mine: `BaseDense` 3, `BendCollar` 1, `HexRing` 1. By `grep -cw`:
  `Procedure` 2, `Terminal` 1, `FlankUA` 0, `Limit` 0, `OpenMove` 0.
- **Axioms** against that build's oleans (`data/fs131/ir/IRAxiomsFinal.lean` → `.out`, `slot.py --mem 12 --cpus 2 -- lake env lean`, exit 0;
  `tools/fs131_ir_axsum.py` with the expectation list; `IRAxiomsFinal-summary.txt`, PASS): **48 records — 40 on the standard three or fewer, 8
  through `sorryAx`, exactly the eight expected, 0 other.** By name: **`exists_terminalMap` is on `sorryAx`**, through `exists_terminalSeq`, which
  is on it through `exists_procStep`, which cites `exists_vertexStep` and `exists_arcStep` — the only two `sorry` declarations under it;
  `exists_red` follows `exists_terminalMap`; `exists_terminal` follows it and `stuckRun_ne_univ`. On the standard three: my 38 receipt records but
  `exists_procStep`, and `exists_open`, `exists_clean`, `run_hornBoundsQR`. **Control**: the same output with a foreign axiom planted in
  `exists_terminalSeq`'s record makes the summarizer exit 1, naming it (`IRAxiomsFinal-planted-summary.txt`); the eight `sorryAx` records are
  themselves the print's positive control.
- **Statements**: `tools/fs131_il_stmt_check.py 87e95385`: exactly two changed, the ruled restatements (`stmt-check-final.txt`). No `axiom`, no
  `native_decide`. `scripts/Axioms.lean`: a block "FS131-IR1" of 38 records above `=== PURCHASED ===`. `tools/check_architecture.py` PASS
  (`arch-stage17.txt`). I ran no gate, merged nothing into `fs131-w5`, took nothing of `main` beyond Stage 13's merge, and left no process running.

### 17.3 What is proved, and what is left (three leaves), each with the route it is ready for

**Proved**: `exists_terminalSeq` over the two steps, so `exists_terminalMap` now rests on exactly `exists_vertexStep` and `exists_arcStep`;
E6-CONE; the cleaned-step machinery.

**Left 1 — `exists_vertexStep`** (`sorry`; H, two sessions). E6-ROUTE's case split (its docstring). For each move, with `F'` its surgery at radius
`ρ` and `F'' := F'.cleanKeep`, these clauses are now one line each: `F''.Valid` (`cleanKeep_valid`), `F''.IsClean` (`cleanKeep_isClean`),
`LocalStep F F'' (closedBall v ρ)` (`surgery_cleanKeep_localStep`, with the move's `…Arcs_subset_closedBall` and its colouring off the ball),
`F''.coloursAt v ⊆ F.coloursAt v` (`coloursAt_cleanKeep` and the move's clause). Left, per move:
  (a) **`ρ < δ`**: OPEN has it; MERGE's assembly (`exists_merge_aux`'s body) re-run with `ρ` also below `δ/2`; MERGE-RAY's and SHAVE's
  assemblies pass through `Near.exists_cut`, `RayConfig.exists_merge`, `exists_shave_recolour`, `exists_shave_of_flankAbove`/`_flankBelow`, which
  hide their map behind `∃ F'` — each needs a form that names its `X.move …` (new declarations downstream; a `private` detail in the way is a
  message to the coordinator, KL1 § 3.3).
  (b) **`F.IsModification F''`**: `dom_eq`, `ringArcsWithin` from the move's clauses and `cleanKeep_isModification`; `coloursAt_subset` off the
  closed disc by locality, at `v` by the move's clause, on the rim by its `ncard ≤ 3` — and **strictly inside the disc off `v` no move's statement
  says anything**: "at most three colours there" has to be read off each construction.
  (c) **the potential at `v`**: the sectors of `G.cleanKeep` at a point with a sector chart of `G` are the maximal runs of consecutive chart
  sectors of one colour (KL1's `degree_lt_of_clean_step`; not written) — state that first, then count per move as E6 § 4.3.
  (d) **no other site in `B̄(v, ρ)`**: at each `x ≠ v` of the closed disc, no repeated colour and no horn in `F''`. A point of a clean map near
  which `Γ` lies on one curve through it is no site (`not_isSite_of_goodAt`, `germs_le_two_of_goodAt`); what is left is the finitely many rim
  points where germs or new arcs meet the rim (and OPEN's inner rim at `ρ/2`). (c) and (d) are where the lines go.

**Left 2 — `exists_arcStep`** (`sorry`; H; not started). Its consumer reads every clause as stated (Stage 15), the horn clause included. Ready:
`LocalStep.cleanKeep` on the closed thickening (`isClosed_cthickening`). Not examined by me: whether `bend_toward` and `bend_away_whole` export
enough for `LocalStep` on `cthickening ε (ringArc …)` (KL1 § 3.3: `bendMap`'s arc set is a private detail — a message when reached); the horn
clause against `bendMap`'s profile (ruling 385 (a)); question (5); and whether the out-only case with a partial witness needs N2-TAN's bend — if
so, `bend_away_part` as a `sorry` child (ruling 411 (e)). I state no `bend_away_part` here: I did not reach the case that would fix its statement.

**Left 3 — `stuckRun_ne_univ`** (`Terminal`, `sorry`; M–H, one session; not started). M6's route stands (`plans/FS131-I5-implementation.md` Stage 55):
no bound is `±1` (`hornBoundsQR_of_isChainVertex`, `cv_l0`), then the child `shadow_recursion`, then `n4_fin`.

**Next step for a successor starting cold**: read Stages 14–17; check out `fs131-w5c` at this stage's commit; build once under the slot (expect
"all … up to date"); re-run `data/fs131/ir/IRAxiomsFinal.lean` through `tools/fs131_ir_axsum.py` with Stage 17's expectation list (expect PASS,
40 and 8); then take one of the three leaves.

### 17.4 Corrections owed to this record's earlier parts (KL1's text, left standing)

- § 3.1's rows for both steps and § 3.3's table end "then `exists_clean`": the cleaned step is `cleanKeep` (Stage 16).
- § 3.1's `exists_terminalSeq` row: "vertex steps within `3`" is within `4`; the potential is degree plus horns (E6).
- § 3.3's `shave_step_gen`: not needed (E6 § 4.3); its `LocalStep` clauses are one lemma, `surgery_localStep` (Stage 17).

### 17.5 Drafts for the front page

None: wave 5 is not at its gate, and my brief runs no gate. For the filing, when `exists_terminalMap` closes: `LEDGER.md`'s rows for N2-TERM's
`exists_red` and `exists_terminal` regrade to [kernel] only after the three leaves above; nothing regrades now.

## Stage 17 — SAVED (FS131-IR1)

---

# FS131-IR2 — the implementer: the vertex step, `exists_vertexStep` (continuing FS131-IR1's record from its Stage 17)

*de Bruijn, the implementer (Opus), on branch `fs131-w5c` from `ebb0b292`. Brief: `data/fs131/briefs/FS131-IR2-vertex-step.md` (main tree), with its
dated amendment (inventory items 422–423).*

## Theorems this phase proved (FS131-IR2)

Each [kernel] on `[propext, Classical.choice, Quot.sound]` or a subset, read against the build of the stage that names it; the list is kept current
at each saved stage (the last stage's receipt is the one to read).
- **Stage 19 — the potential under a step** (`Plane/ValidMap/Procedure`, section "Comparing the sectors of two maps at a point"):
  `ArcMap.IsSector.eq_of_inter_nonempty`, `.encard_le_of_forall_exists_subset`, `.IsSector.hornSet_of_subset`, `.encard_sectors_le_aux`,
  **`.pot_le_of_sectors`**, **`.pot_lt_of_sectors`**, `.exists_isSector_subset`, `.exists_isSector_ne_subset`, **`.pot_lt_of_interior`**,
  `.interiorPts_subset_cleanKeep`, **`.cleanKeep_pot_le`**, `.hasRepeatedColour_of_cleanKeep`, **`.not_isSite_cleanKeep`**;
  `BranchGerms.next_ne_self`.
- **Stage 20 — the points of a step's disc, and the assembly** (`Procedure`): `ArcMap.Near.col_ne_next_of_isClean`,
  `.Near.two_le_of_isClean`, **`.not_hasRepeatedColour_of_degree_le_three`**, **`.hasHornCount_zero_of_germs`**, `.one_le_of_isHorn`,
  `.two_le_of_isHorn_of_isHorn`. **`ArcMap.exists_vertexStep` — proved over open children** (no `sorry` of its own; on `sorryAx` through
  `exists_mergeStep`, `exists_rayStep`, `exists_shaveStep`, `exists_openStep`, the four cases, each a `sorry`).
- **Stage 21 — a point on one curve** (`Procedure`): `ArcMap.not_isSite_of_hasHornCount_zero`, `e_curveGerm_ne`,
  **`ArcMap.not_isSite_of_curve`**, `curveAt_rebase`, `exists_curveAt_of_branch`.
- **Open at the hand-back** (each a `sorry`, stated, with its route in § 20.2): `ArcMap.exists_mergeStep`, `.exists_rayStep`,
  `.exists_shaveStep`, `.exists_openStep`.

## Stage 18 — SAVED (FS131-IR2): the readback, the as-given build, the ruled restatement (inventory item 423)

### 18.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_ir_quotes.py` (IR1's checker, run unchanged) on the brief as launched: **11 quotations, 0 failures**
(`data/fs131/ir/ir2/quotes.txt`); `--self-test` (one letter planted in the first quotation): **fired**, 1 failure
(`quotes-selftest.txt`). On the brief with its amendment (three quotations more: items 422, 423, `covers_of_isPlaneMap`): **14 quotations,
0 failures** (`quotes-amended.txt`). No mismatch.

Read in full: the brief and its amendment; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` §§ Building, Make the gate fail; this record's
Stages 12–17 (IR1); E6's derivation §§ 4.1–4.5; inventory items 372, 420–423; `Procedure.lean`'s cleaning section, the two steps and
`exists_procStep`; `Basic.lean`'s definitions; `Limit.lean`'s `LocalStep`, `IsClean`, `IsSite`, `not_isSite_of_goodAt`,
`germ_eq_curveGerm_of_goodAt`; `Surgery.lean`'s `Near`, `newArcs`, `move`; `Moves.lean`'s three assemblies and `RayConfig.exists_merge`;
`MergeMove.lean`'s `mergeArcs`, `mergeCol`, `exists_gap` and the `merge_*` clauses' statements; `OpenMove.lean`'s outline and `exists_open`;
`LocalStructure.lean`'s `IsSectorChart`, `GoodAt`, `curveAt`, `curveGerm`; `Sectors.lean`'s chart lemmas.

### 18.2 The as-given build (`ebb0b292`) and IR1's axioms check, re-run

`/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before
any edit: **OK — all 1785 modules already up to date, nothing built, 5 modules with warnings**, exit 0, 2 s
(`build/gate/build/20261006T040301Z-811757.log`; driver log `data/fs131/ir/ir2/build-stage18-asgiven.log`). IR1's
`data/fs131/ir/IRAxiomsFinal.lean` re-run (`slot.py --mem 12 --cpus 2 -- lake env lean`, exit 0 → `ir2/IRAxiomsFinal-rerun.out`) and read by
`tools/fs131_ir_axsum.py` with Stage 17's expectation list: **48 records — 40 on the standard three or fewer, 8 through `sorryAx`, exactly the
eight expected, 0 other; PASS** (`ir2/IRAxiomsFinal-rerun-summary.txt`). The summarizer's `--self-test`: four plants, each FIRED, the
control PASS (`ir2/axsum-selftest.txt`).

### 18.3 The ruled restatement of `exists_vertexStep` (inventory items 422–423; the third repair to this statement)

By the coordinator's message and the brief's amendment (FS131-QA4's finding: the step assumed `v ∈ F.dom` where each of the four moves it
composes assumes `F.Covers v 1`). The statement's diff, beside IR1's of Stage 14 (`data/fs131/ir/ir2/restate-423.diff`; the file before it is
`ir2/Procedure-before-423.lean`):

```
-theorem exists_vertexStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : v ∈ F.dom)
+theorem exists_vertexStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : F.Covers v 1)
```

and its one call, in `exists_procStep`:

```
-      exists_vertexStep hG.valid hG.clean (hGd t) hmv hdeg hhorn hδ0
+      exists_vertexStep hG.valid hG.clean (covers_of_isPlaneMap hG.plane t 1) hmv hdeg hhorn hδ0
```

The docstring's first sentence now names the covering hypothesis. Nothing else changed: `exists_arcStep`, `exists_terminalSeq`,
`exists_terminalMap` are as IR1 left them. `tools/fs131_il_stmt_check.py ebb0b292` (IL2's, run): **exactly one statement changed,
`exists_vertexStep`** (exit 1, as it must be; `ir2/stmt-check-18.txt`).

**Build** of this stage (slot 40 GiB, 8 cpus, `BATCH=4`): see § 18.5.

### 18.4 What I may and may not change (the brief's `touches`, § What is yours to decide, ruling 421 (c))

**May**: prove `exists_vertexStep` and add children beside it in `Procedure`; add **new declarations only** to `Moves`, `MergeMove`,
`OpenMove`, `Surgery` (named forms that expose an assembly's map and radius, or a `private` helper made public); supporting lemmas in
`FlankUA`; a module between the moves and `Procedure` (with `Proofs.lean` and `ARCHITECTURE.md`); a block "FS131-IR2" in
`scripts/Axioms.lean` above `=== PURCHASED ===`; `tools/fs131_ir_*.py`, `data/fs131/ir/`, this record, the report. **May not**: change any
statement or definition (the ruled restatement above apart); touch `exists_arcStep`'s, `exists_terminalSeq`'s or `exists_terminalMap`'s
statement; edit `Terminal.lean`, `Limit.lean`, `BaseDense`, `BendCollar`, `HexRing`, `main`; merge anything into this branch; run the gate;
add an `axiom` or a `native_decide`; edit a file while a build of it runs.

### 18.5 Pointers added (ruling 421 (b)) and the stage's build

One-line pointers to § 17.4 at the heads of §§ 3.1 and 3.3 of this record (KL1's text, left standing below them).

**Build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 457 of 457 batches, 6 modules rebuilt, 5 with warnings, all 8 warnings `declaration uses
'sorry'`** (`Procedure` at `exists_vertexStep` l. 796 and `exists_arcStep` l. 813; `Terminal` at `stuckRun_ne_univ`; `BaseDense` 3,
`BendCollar` 1, `HexRing` 1, none mine), 8 min 55 s, exit 0 (`build/gate/build/20261006T041511Z-859027.log`; driver log
`data/fs131/ir/ir2/build-stage18.log`).

## Stage 18 — SAVED (FS131-IR2)

## Stage 19 — SAVED (FS131-IR2): the potential under a step — the comparison of sectors (the brief's item 2, in the form the counts read)

### 19.1 What was proved ([kernel]; `Procedure`, section "Comparing the sectors of two maps at a point", before "The two steps")

The count `degree + horns` at `v`, for every move, without a chart of the new map:
- **`pot_le_of_sectors`** — if, at every small radius, every sector of `F₂` at `v` contains a sector of `F₁`, then `F₂`'s degree and
  horn count at `v` are at most `F₁`'s. (Distinct sectors of `F₂` are disjoint, so the contained sectors are distinct —
  `encard_le_of_forall_exists_subset`; a sector of `F₁` inside a horn set is a horn set — `IsSector.hornSet_of_subset`, from `Moves`'
  `Near.horn_of_sector_subset_hornSet`.)
- **`pot_lt_of_sectors`** — if moreover one sector `H` of `F₁` is never needed (every sector of `F₂` contains a sector of `F₁` other than
  `H`), the degree drops, so `m₂ + j₂ < m₁ + j₁`. This is the form SHAVE's count reads (`H` the shaved horn).
- `exists_isSector_subset` — the first hypothesis holds whenever `F₁`'s interior points near `v` are interior points of `F₂`;
  `exists_isSector_ne_subset`, **`pot_lt_of_interior`** — and the second when, besides, the points near `v` of one germ of `F₁` are interior
  to `F₂` and `F₁` has at least two germs there: the form MERGE's and MERGE-RAY's counts read (a germ inside the recoloured gap).
- **`cleanKeep_pot_le`** — cleaning raises neither the degree nor the horn count (`interiorPts_subset_cleanKeep`): OPEN's count is then
  `exists_open`'s clause (`m' ≤ m`, `j' < j`) and this line.
- `hasRepeatedColour_of_cleanKeep` (cleaning creates no repeated colour) and **`not_isSite_cleanKeep`** (a point with horn count `0` and no
  repeated colour is no site after cleaning) — clause (d)'s reduction to the uncleaned map, where a move's statement exports
  `¬ HasRepeatedColour` on its rim.

### 19.2 The form, and what was not proved (a decision of mine, for the coordinator's eye)

The brief's item 2 names the lemma "the sectors of a kept-colour cleaning at a point with a sector chart are the maximal runs of
consecutive chart sectors of one colour". **I did not prove it in that form.** What every count reads is one direction of it — every
sector of the cleaned map contains a chart sector, and a germ with one colour on both sides joins its two sectors — and that direction
is what Stage 19 proves, as a comparison between two maps' sectors as sets. The converse (two chart sectors lie in one cleaned sector
only if every sector between them, one way round, has their colour) is a separation statement: it needs the cleaned map's own chart (the
sub-family of colour-change germs, re-indexed over `Fin n'` with the wrap-around clause of `BranchGerms.Sorted`), which I priced at
several hundred lines and which no clause of `exists_vertexStep` reads. Reasons the comparison form is the better child: it never
indexes the new map's germs; it covers SHAVE and OPEN, whose new maps are not sub-families of the old chart (a new arc inside a sector);
and it gives the horn count with the degree in one argument. If a later consumer needs the exact description, the route is
`isSectorChart_of` on `cleanKeep` with the kept germs — not started.

### 19.3 The build, the receipt, the checks

- **Build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 457 of 457 batches, 6 modules rebuilt, 5 with warnings, all 8 warnings `declaration uses
  'sorry'`** (`Procedure` at the two steps, now l. 1029 and l. 1046; `Terminal` 1; not mine: `BaseDense` 3, `BendCollar` 1, `HexRing` 1), 9 min
  20 s, exit 0 (`build/gate/build/20261006T042529Z-904698.log`; driver log `data/fs131/ir/ir2/build-stage19.log`).
- **Axioms** against that build (`data/fs131/ir/ir2/IR2Axioms19.lean` → `.out`, `slot.py --mem 12 --cpus 2 -- lake env lean`, exit 0;
  `tools/fs131_ir_axsum.py … --expect-sorry exists_vertexStep,exists_terminalMap`, `IR2Axioms19-summary.txt`, PASS): **16 records — the 14
  new ones on the standard three or fewer; the two controls on `sorryAx`**, 0 other.
- **Statements**: `tools/fs131_il_stmt_check.py d7954838` (against Stage 18): PASS, additions only (`ir2/stmt-check-19.txt`).
- **Receipt**: a block "FS131-IR2" of 14 records in `scripts/Axioms.lean`, above `=== PURCHASED ===`.
- No definition was added (so no spec example is owed); each theorem is parametric in its maps (the vacuity scan's GENERIC), and
  `cleanKeep_pot_le`'s and `not_isSite_cleanKeep`'s hypotheses are inhabited by any map at a point of its domain with its own counts
  (`exists_hasDegree_of_mem_dom`, `exists_hasHornCount`).

## Stage 19 — SAVED (FS131-IR2)

## Stage 20 — SAVED (FS131-IR2): the assembly (`exists_vertexStep` over four cases), and the kit for the points of a step's disc

### 20.1 What was done ([kernel] but the four cases; `Procedure`)

- **The assembly (the brief's item 4, over open children).** `exists_vertexStep` is now E6-ROUTE's case split with **no `sorry` of its
  own**: with MERGE available, `exists_mergeStep`; else, from MERGE-RAY's two horns, the colour has at least two sectors
  (`two_le_of_isHorn_of_isHorn`), the outer bounds lie in `[−1, 1]` (`horn_bounds_of_noMerge`, twice), `exists_rayStep`; else, from
  SHAVE's horn of colour `c` — if `int D_c(v) = ∅`, its bounds lie in `[−1, 1]` (`horn_bounds_of_interior_empty`), `exists_shaveStep`;
  otherwise `c` has exactly one sector (`one_le_of_isHorn`; two would make MERGE available), `exists_openStep`. Among MERGE-RAY and
  SHAVE the split takes whichever the hypothesis' disjunction gives (each case is a theorem on its own hypotheses, so E6's priority
  between them is not needed). **The four cases are stated, each with its move's hypotheses (`exists_merge_aux`,
  `exists_rayMerge_aux`, `exists_shave_aux`, `exists_open`), cleanness, the covering hypothesis and the two counts, and the vertex
  step's conclusion verbatim; each is a `sorry`.** One `sorry` became four smaller ones: each is one construction, and § 20.2 gives its
  route. `Procedure` now imports `Plane/ValidMap/FlankUA` (for the two horn-bound lemmas; `ARCHITECTURE.md`'s row updated).
- **The kit for the points `x ≠ v` of the disc** (section "Points of a step's disc other than its centre"):
  `Near.col_ne_next_of_isClean` (in a clean map consecutive chart sectors differ in colour), `Near.two_le_of_isClean`,
  **`not_hasRepeatedColour_of_degree_le_three`** (a clean map has no repeated colour at a point of degree at most three), and
  **`hasHornCount_zero_of_germs`**: if every point of `Γ` near `x` lies, at its own distance, on one of finitely many branches from `x`
  with pairwise distinct directions, then no sector at `x` is a horn, the degree is at most the number of branches, and at most one
  fewer if one branch has points off `Γ` arbitrarily near `x`. Together: a point on one curve, or at a junction of two transversal
  curves with one dead branch, is no site and carries at most three colours.
### 20.2 What is left: the four cases, each with its route (the next implementer's work list)

Common to all four, with `F'` the move's surgery at radius `ρ` and `F'' := F'.cleanKeep` — **one line each** (IR1's § 17.3, re-read against
the kit): `F''.Valid` (`cleanKeep_valid`), `F''.IsClean` (`cleanKeep_isClean`), `LocalStep F F'' (closedBall v ρ)`
(`surgery_cleanKeep_localStep`), `F''.coloursAt v ⊆ F.coloursAt v` (`coloursAt_cleanKeep`, the move's clause), `F''.dom = F.dom`,
`F''.RingArcsWithin F` (`cleanKeep_isModification` after the move's clause), and `IsModification`'s third clause off the closed disc
(`coloursAt_eq_of_agreesOn` on the open complement) and at `v`. **Left, per case, are four things**: (a) the radius below `δ`; (b) at most
three colours at every `x ≠ v` of the closed disc; (c) the count at `v`; (d) no site at any `x ≠ v` of the closed disc.

**A fact that removes three sub-cases** (`Near.col_ne_next_of_isClean`): in a clean map consecutive chart sectors differ in colour. So
`Moves`' cut constructions never occur here — `exists_shave_of_flankAbove`/`_flankBelow` (a flank of the horn's colour) and the first
branch of `exists_rayMerge_of_clear` (the sector just above the lower horn has colour `c`) — nor MERGE with adjacent `c`-sectors
(`a + 1 = b`), nor a phantom germ (`MergeMove`'s `Phantom`). Each is closed by `absurd` from that lemma; the constructions actually met are
`mergeArcs`/`mergeCol` (two scales, `ρ/2` and `ρ`), `RayConfig.exists_merge` (`Near.move`, kept germs `rayKeep`, the full rim circle),
`exists_shave_recolour` (`Near.move` with `shaveArcs`, `shaveCol`, the full rim circle), and OPEN's surgery (two scales).

**(a) the radius.** OPEN: `exists_open` gives it. MERGE: `exists_merge_aux`'s body is public pieces (`Near.exists_gap`, `merge_hlc`,
`merge_valid`, …, all in `ArcMap.Near`); re-run it in `Procedure` with `ρ := min (min (ρ'/2) (ρc/2)) (δ/2)` — no new declaration in
`MergeMove` is needed for the radius. MERGE-RAY: `exists_rayMerge_of_clear`'s body with `(X.eventually_small.and hclear).and
(Ioo_mem_nhdsGT hδ)`; its pieces are public (`Near.horn_index`, `RayGap.curv_le_of_hornSet_subset`, `Near.RayConfig`), and
`RayConfig.exists_merge` hides its map — add beside it in `Moves` a named form whose conclusion is about
`X.move h (X.rayKeep α κ₂ κ₃) ∅ (F.rayCol v α κ₁ κ₄ ρ c) …` (ruling 421 (c); its proof is the present one, split at `set F' := …`). SHAVE:
the same for `exists_shave_recolour` (its radius is chosen inside; the named form takes `X`, `hs : X.Small ρ` and the clearness at `ρ`).

**(c) the count at `v`**, from Stage 19:
- OPEN — `exists_open`'s clause (`m' ≤ m`, `j' < j` for `F'`) and `cleanKeep_pot_le hvd hm' hj' …`: done in three lines once `F'` is in hand.
- MERGE, MERGE-RAY — `pot_lt_of_interior X (X.two_le_of_isClean hc hn0) hsub hdrop hdeg hhorn …` with `F₂ := F''`: `hsub` — an interior
  point of `F` in `B(v, r)`, `r` small, lies on no new arc (`mem_merge_interiorPts_iff`, `mem_move_interiorPts_iff` with
  `mem_newArcs_iff`), so it is interior to `F'`, hence to `F''` (`interiorPts_subset_cleanKeep`); `hdrop` — the points near `v` of one
  germ inside the recoloured gap are interior to `F'` (MERGE: a germ of `gapGerm s a b`, not among `mergeArcs` inside `ρ/2`; MERGE-RAY:
  the lower horn's upper germ `next i₀`, not in `rayKeep`).
- SHAVE — `pot_lt_of_sectors` with `H` the horn `X.G.sector v r i₀`: a sector `S₂` of `F''` holds an interior point `z` of `F` off the
  `σ`-arc; if `z ∉ H`, its chart sector is interior to `F''` and lies in `S₂` (as `exists_isSector_subset`); if `z ∈ H` above the `σ`-arc,
  then `hornSet v α σ κ₂ r`, a point of the germ `next i₀` and the flank sector above are a connected set of `F''`-interior points (the
  germ's points carry the one colour `g` in `F'`: `g` above, and `g` on the recoloured upper part), so `S₂` contains the flank sector;
  below, the same with `h`. (When `σ = κ₂` there is no upper part, when `σ = κ₁` no lower part; the argument is unchanged.)

**(b), (d) at `x ≠ v` strictly inside the scale where the move acts, on no junction** — one lemma each from Stage 20's kit, once
"`Γ` of `F''` near `x` lies on one line or circle through `x`" is shown: `F''.Γ ⊆ F'.Γ` (`cleanKeep_Γ`, `essSet_subset_Γ`), `F'.Γ` in the
open ball is the union of finitely many germ-like arcs `branchPt v β κ '' Icc 0 ρ` (kept germs, SHAVE's `σ`-arc, OPEN's ray) pairwise
meeting only at `v` (`Near.hdisj`), each a closed set; so some ball about `x` meets at most one, which lies on a full curve through `v`
(`exists_curveGerm_eq`, `branchPt_curveGerm_mem`), the same curve read from `x`. Then `hasHornCount_zero_of_germs` with the curve's two
germs at `x` (`exists_eq_branchPt_curveGerm`; their directions are opposite) gives horn count `0` and degree at most `2`;
`not_hasRepeatedColour_of_degree_le_three` gives no repeated colour; `exists_hasDegree_of_mem_dom` gives at most two colours. (A draft
of this lemma, `not_isSite_of_curve`, and of the change of base point `curveAt_rebase`, was `data/fs131/ir/ir2/scratch/Curve.lean`;
**both are proved in Stage 21**, with `exists_curveAt_of_branch`.)

**(b), (d) at the junctions** — the finitely many points where a germ or new arc meets a rim: the circle of radius `ρ` for MERGE-RAY
and SHAVE (`Near.move` adds the whole circle), **the circle of radius `ρ/2` for MERGE and OPEN** (their surgery recolours inside `ρ/2`
and re-presents the germs between `ρ/2` and `ρ`; so their statements' rim clauses, which speak of `sphere v ρ`, do not cover the
junctions, which lie strictly inside the disc — IR1's finding (b), located). At a junction `x` the arcs of `F''` near `x` lie on two
curves through `x` with different tangents there (the rim circle, `curveAt x 1 (v - x)`, and the germ's curve; they are tangent only if
`x` is antipodal to `v` on the germ's circle, excluded by `|κ| ρ < 2`), so `hasHornCount_zero_of_germs` with the four germs gives horn
count `0`; and **one of the four branches is dead** in every case (its points near `x` carry one colour in `F'`): the germ's inner
branch where the germ lies inside the recoloured region, or a rim branch where the sector on that side keeps its colour across the
rim. The lemma's last clause then gives degree at most `3`, hence no repeated colour (`not_hasRepeatedColour_of_degree_le_three`) and at
most three colours. No identification of which branch is the inner one is needed: the dead points `w` (on the germ inside the rim, or
on the rim) are curve points near `x`, each `branchPt x (curveGerm …σ) ‖w - x‖` for some `σ = ±1`, and one `σ` occurs for points
arbitrarily near `x` (`Filter.Frequently` over two cases). Where both rim branches are dead (the sectors on both sides keep their
colours) the junction is a point on one curve and the previous paragraph applies. The colour facts are read from each construction's
colour function on chart sectors (`mergeCol_of_mem_sector`, `mergeCol_of_mem_sector_out`, `rayCol_of_mem`/`_of_not_mem` with
`RayConfig.sector_disjoint`, `shaveCol_of_above`/`_of_not_above`/`_of_not_mem`, `openCol_of_mem`/`_of_not_mem`), at a chart radius above
`ρ` for the points just outside the rim.

**Points of `sphere v ρ` in MERGE and OPEN** carry the old map near them (the surgery only re-presents the arcs there): no site, since
`F` has none in the punctured good ball (`not_isSite_of_goodAt hc X.hG`, transferred by `isSite_iff_of_agreesOff` on a small closed
ball's complement, or read directly by the one-curve lemma).

**Order suggested**: MERGE-RAY first (one scale, no new arc inside, the kit's simplest instance: it fixes the junction lemma's final
form), then SHAVE (one new arc), then MERGE and OPEN (two scales; OPEN's count is free). Price, from this session's first two leaves
(Stages 19–20: about 420 lines in a quarter of a session, no geometry): the kit was cheap; **the cases are where the lines are** — I
price each at 300–500 lines, the junction lemma's two-curve form (transversality at `x`, the dead branch) at about 150 once, so **two
sessions** for the four, as IR1 priced it; nothing found so far says more.

### 20.3 The build, the receipt, the checks

- **Build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 457 of 457 batches, 6 modules rebuilt, 5 with warnings, all 11 warnings `declaration
  uses 'sorry'`**: `Procedure` 5 — the four cases (l. 1227, 1239, 1251, 1265) and `exists_arcStep` (l. 1331), **not `exists_vertexStep`**;
  `Terminal` 1; not mine: `BaseDense` 3, `BendCollar` 1, `HexRing` 1. 9 min 17 s, exit 0
  (`build/gate/build/20261006T044033Z-1008366.log`; driver log `data/fs131/ir/ir2/build-stage20.log`).
- **Axioms** against that build (`data/fs131/ir/ir2/IR2Axioms20.lean` → `.out`, exit 0; `tools/fs131_ir_axsum.py` with the expectation
  `exists_mergeStep, exists_rayStep, exists_shaveStep, exists_openStep, exists_vertexStep, exists_arcStep, exists_procStep,
  exists_terminalSeq, exists_terminalMap`; `IR2Axioms20-summary.txt`, PASS): **16 records — 7 on the standard three or fewer (the six
  new lemmas and `pot_lt_of_interior`), 9 through `sorryAx`, exactly the nine expected, 0 other.** `exists_vertexStep` is on `sorryAx`
  through its four cases alone (the build names no `sorry` at it); `exists_terminalMap` follows it and `exists_arcStep`.
- **Statements**: `tools/fs131_il_stmt_check.py 8e5276b3` (against Stage 19): PASS, additions only (`ir2/stmt-check-20.txt`).
- **The map**: `tools/check_architecture.py` — with the new import and the old row, **FAILED** (1 failure, `ir2/arch-stage20-control.txt`);
  with `Plane/ValidMap/FlankUA` added to `Procedure`'s Imports cell, PASS (`ir2/arch-stage20.txt`).
- **Receipt**: six records more in the "FS131-IR2" block of `scripts/Axioms.lean` (20 in all); the `sorry` cases are not in it.

## Stage 20 — SAVED (FS131-IR2)

## Stage 21 — SAVED (FS131-IR2): a point on one curve; the handover

### 21.1 Added in this stage ([kernel], `Procedure`, subsection "A point on one curve")

- `not_isSite_of_hasHornCount_zero` (no horn sector and no repeated colour: no site); `e_curveGerm_ne` (the two germs of a line or
  circle leave its point in opposite directions).
- **`not_isSite_of_curve`** — a point of a **clean** map near which `Γ` lies on one line or circle through it is no site, and carries
  at most two colours: `hasHornCount_zero_of_germs` with the curve's two germs, then
  `not_hasRepeatedColour_of_degree_le_three`. It is `not_isSite_of_goodAt`'s local content with the good ball replaced by its one
  consequence, so it applies to the cleaned map of a move, whose arcs are not presented through `v`.
- `curveAt_rebase` (a line or circle through `v`, read from another of its points) and **`exists_curveAt_of_branch`** (a germ's branch
  from `v` lies on one line or circle through any one of its points) — the hypothesis of `not_isSite_of_curve` at a point of a kept
  germ, of SHAVE's arc, of OPEN's ray: § 20.2's paragraph "(b), (d) at `x ≠ v` … on no junction" is now these two lemmas and the
  per-move fact that some ball about `x` meets one arc only.

### 21.2 The build and the receipt (the handover)

- **Build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 457 of 457 batches, 6 modules rebuilt, 5 with warnings, all 11 warnings `declaration
  uses 'sorry'`**: `Procedure` 5 (the four cases l. 1334, 1346, 1358, 1372; `exists_arcStep` l. 1438), `Terminal` 1
  (`stuckRun_ne_univ`); not mine: `BaseDense` 3, `BendCollar` 1, `HexRing` 1. 9 min 10 s, exit 0
  (`build/gate/build/20261006T045152Z-1110185.log`; driver log `data/fs131/ir/ir2/build-stage21.log`). By `grep -cw sorry` `Procedure`
  reads 6: the five proofs and one word in a section header.
- **Axioms** against that build (`data/fs131/ir/ir2/IR2AxiomsFinal.lean` → `.out`, `slot.py --mem 12 --cpus 2 -- lake env lean`, exit
  0; `tools/fs131_ir_axsum.py` with `IR2AxiomsFinal-expect.txt`; `IR2AxiomsFinal-summary.txt`, PASS): **37 records — 25 on the standard
  three or fewer (every lemma of Stages 19–21), 12 through `sorryAx`, exactly the twelve expected, 0 other.** By name:
  **`exists_vertexStep` is on `sorryAx` through its four cases alone** (the build names no `sorry` at it); `exists_procStep`,
  `exists_terminalSeq`, `exists_terminalMap`, `exists_red` follow it and `exists_arcStep`; `exists_terminal` also reads
  `stuckRun_ne_univ`. **Control**: the same output with a foreign axiom planted in `not_isSite_of_curve`'s record makes the summarizer
  exit 1, naming it (`IR2AxiomsFinal-planted-summary.txt`); the twelve `sorryAx` records are the print's positive control. *The brief's
  item 4 asks for `exists_terminalMap` on `sorryAx` through `exists_arcStep` alone: not yet — it is through `exists_arcStep` and the
  four cases.*
- **Statements**: `tools/fs131_il_stmt_check.py 42801d8a` (against Stage 20): PASS, additions only (`ir2/stmt-check-21.txt`);
  against IR1's `ebb0b292`: exactly one changed, `exists_vertexStep`, the ruled restatement (`ir2/stmt-check-final.txt`, exit 1 as it
  must be). No `axiom`, no `native_decide`. `tools/check_architecture.py` PASS (`ir2/arch-stage21.txt`).
- **Receipt**: the block "FS131-IR2" in `scripts/Axioms.lean`, 25 records, above `=== PURCHASED ===`; the open cases are not in it.
- **Declarations added to landed modules** (ruling 421 (c)): **none** — `Moves`, `MergeMove`, `OpenMove`, `Surgery`, `FlankUA` are
  untouched; everything is in `Procedure`. The named forms § 20.2 (a) asks for are the next implementer's.
- I ran no gate, merged nothing, did not touch `Terminal.lean` or `main`, and left no process running (four builds, each ended with
  its exit line read).

### 21.3 Next step for a successor starting cold

Read Stages 18–21 (§ 20.2 is the work list); check out `fs131-w5c` at this stage's commit; build once under the slot (expect "all …
up to date"); re-run `data/fs131/ir/ir2/IR2AxiomsFinal.lean` through `tools/fs131_ir_axsum.py` with `IR2AxiomsFinal-expect.txt`
(expect PASS, 25 and 12); then take `exists_rayStep`. Its first two children fix the forms the other three reuse: the named form of
`RayConfig.exists_merge` in `Moves` (its map exposed), and the junction lemma in its two-curve form (`hasHornCount_zero_of_germs` with
four germs and one dead branch) in `Procedure`. Iterate with `lake env lean` on a scratch file that imports `Procedure` (it elaborates
in about ten seconds), and build only at a stage's end (nine minutes).

### 21.4 Drafts for the front page

None: the vertex step is not closed, wave 5 is not at its gate, and my brief runs no gate. Nothing regrades now. For the filing, when
the four cases close: `exists_vertexStep` joins the declarations under `exists_terminalMap` that are [kernel].

## Stage 21 — SAVED (FS131-IR2)

---

# FS131-IR3 — the implementer: the vertex step's four cases (continuing FS131-IR2's record from its Stage 21)

*de Bruijn, the implementer (Opus), on branch `fs131-w5c` from `a5a12a0b`. Brief: `data/fs131/briefs/FS131-IR3-vertex-cases.md` (main tree).*

## Theorems this phase proved (FS131-IR3)

Each [kernel] on `[propext, Classical.choice, Quot.sound]` or a subset, read against the build of the stage that names it; the list is kept
current at each saved stage (the last stage's receipt is the one to read).
- Stage 22 (the readback): none.
- Stage 23 (the ruled restatement of `exists_arcStep`; the merge of `fs131-w5s`): none of mine. By the merge `ArcMap.stuckRun_ne_univ`
  (FS131-IS1's, `Terminal`) is in this tree on the standard three; `Terminal` holds no `sorry`.
- **Stage 24 — a point on two curves, the points of a move's disc, MERGE-RAY's case** (`Plane/ValidMap/Procedure`):
  `e_arg_sub_ne`, `im_ne_zero_of_far`, `mem_curveAt_of_dist_eq`, `exists_branchPt_near_lt`, `exists_branchPt_near_gt` (namespace
  `HadwigerNelson.Plane`); `ArcMap.cleanKeep_Γ_subset`, `.not_mem_cleanKeep_Γ_of_const`, **`.not_isSite_of_two_curves`**,
  **`.not_isSite_of_rim_junction`**, **`.not_isSite_of_branches`**, **`.Near.not_isSite_of_chart`**, `.Near.exists_rim_mem_sector`,
  `.Near.exists_rim_mem_sector_before`, `.Near.move_not_mem_cleanKeep_Γ`, `.Near.move_Γ_cases`,
  **`.Near.RayConfig.exists_step`**, **`ArcMap.exists_rayStep`** (the first of the four cases; its statement as IR2 wrote it).
- **Stage 25 — the assembly the cases share, SHAVE's case** (`Procedure`): `subset_connectedComponentIn_of_mem_closure` (namespace
  `HadwigerNelson.Plane`), `ArcMap.mem_cleanKeep_interiorPts_of_const`, **`ArcMap.surgery_step`**, `ArcMap.Near.move_step`,
  **`ArcMap.Near.exists_shaveStep_aux`**, **`ArcMap.exists_shaveStep`** (the second case; its statement as IR2 wrote it).
- **Stage 26 — MERGE's case** (`Procedure`): **`ArcMap.Near.exists_mergeStep_aux`**, **`ArcMap.exists_mergeStep`** (the third
  case; its statement as IR2 wrote it).
- **Stage 27 — OPEN's case; the vertex step closed** (`Procedure`): **`ArcMap.Near.exists_openStep_aux`**,
  **`ArcMap.exists_openStep`** (the fourth case; its statement as IR2 wrote it). With it **`ArcMap.exists_vertexStep`** (IR2's
  assembly; ruling 423's statement) **depends on `[propext, Classical.choice, Quot.sound]`** — no open case is left under it.
- **Open at the hand-back**: none of this job's. `ArcMap.exists_arcStep` (`sorry`, restated by ruling 430 in Stage 23) is the one
  `sorry` in `Procedure`; `exists_procStep`, `exists_terminalSeq`, `exists_terminalMap`, `exists_red`, `exists_terminal` are on
  `sorryAx` through it alone.

## Stage 22 — SAVED (FS131-IR3): the readback, the as-given build, IR2's axioms check re-run

### 22.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_ir_quotes.py` (IR1's checker, run unchanged) on the brief as launched: **16 quotations, 0 failures**
(`data/fs131/ir/ir3/quotes.txt`); `--self-test` (one letter planted in the first quotation): **fired**, 1 failure
(`ir3/quotes-selftest.txt`). No mismatch.

Read in full: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` §§ Building, Make the gate fail; this record's § 17.3 (IR1) and
Stages 18–21 (IR2); E6's derivation §§ 4.1–4.3; inventory items 421, 429–430, 435–436; FS131-IA1's § 3.6
(`fs131-w5a`, `plans/FS131-arcstep-implementation.md`); QA4's § 6.2 (rank 7's line); `Procedure.lean`'s kit (ll. 1014–1300), the four cases, the
two steps and `exists_procStep`.

### 22.2 The as-given build (`a5a12a0b`) and IR2's axioms check, re-run

`/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, before
any edit: **OK — all 1785 modules already up to date, nothing built, 5 modules with warnings**, exit 0, 2 s
(`build/gate/build/20261006T050608Z-1196466.log`; driver log `data/fs131/ir/ir3/build-stage22-asgiven.log`): `Procedure` 5 `sorry` warnings
(the four cases l. 1334, 1346, 1358, 1372; `exists_arcStep` l. 1438), `Terminal` 1 (`stuckRun_ne_univ` l. 3592). IR2's
`data/fs131/ir/ir2/IR2AxiomsFinal.lean` re-run (`slot.py --mem 12 --cpus 2 -- lake env lean`, exit 0 → `ir3/IR2AxiomsFinal-rerun.out`) and
read by `tools/fs131_ir_axsum.py` with `ir2/IR2AxiomsFinal-expect.txt`: **37 records — 25 on the standard three or fewer, 12 through
`sorryAx`, exactly the twelve expected, 0 other; PASS** (`ir3/IR2AxiomsFinal-rerun-summary.txt`). The summarizer's `--self-test`: four
plants, each FIRED, the control PASS (`ir3/axsum-selftest.txt`).

### 22.3 What I may and may not change (the brief's `touches`, § Done means, § What is yours to decide)

**May**: the ruled restatement of `exists_arcStep` (ruling 430; IA1's § 3.6) with its caller's lines and the three docstring corrections;
the merge of `origin/fs131-w5s`; prove the four cases and add children beside them in `Procedure`; **new declarations only** in `Moves`,
`MergeMove`, `OpenMove`, `Surgery` (ruling 421 (c): a named form that exposes a move's map, or a `private` helper made public); a block
"FS131-IR3" in `scripts/Axioms.lean` above `=== PURCHASED ===`; `ARCHITECTURE.md` for a row whose imports I change; `tools/fs131_ir_*.py`;
`data/fs131/ir/ir3/`; this record; the report. **May not**: change any other statement or definition; prove `exists_arcStep`; edit
`Terminal.lean` beyond what the merge brings, `BendStep`, `main`; run the gate; add an `axiom` or a `native_decide`; edit a file while a
build of it runs; start an agent.

## Stage 22 — SAVED (FS131-IR3)

## Stage 23 — SAVED (FS131-IR3): the two small edits — `exists_arcStep` restated by ruling 430; `origin/fs131-w5s` merged

### 23.1 The ruled restatement of `exists_arcStep` (inventory items 429–430, 436 (d); FS131-IA1's § 3.6), commit `57b6d9c7`

Copied from IA1's § 3.6 (`fs131-w5a`, `plans/FS131-arcstep-implementation.md`). The statement's diff (whole diff: `data/fs131/ir/ir3/restate-430.diff`;
the file before it: `ir3/Procedure-before-430.lean`):

```
-theorem exists_arcStep (hF : F.Valid) (hc : F.IsClean) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
+theorem exists_arcStep (hF : F.Valid) (hP : F.IsPlaneMap) (hc : F.IsClean) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
-      (∀ x m, F.HasDegree x m → F'.HasDegree x m) ∧
+      (∀ x ∈ T, ∀ m, F.HasDegree x m → ∃ m' ≤ m, F'.HasDegree x m') ∧
```

Its one caller, in `exists_procStep`: the call passes `hG.plane`; the `pot_le` bullet takes `hx`, obtains `⟨m', hm', hdeg'⟩ := hdegs x hx mx
hmx` and rewrites with `pot_eq hdeg' hjx'` (IA1's text, compiled here: it elaborates as written). It stays `sorry`. **Docstrings**:
`exists_arcStep`'s now names the plane-map hypothesis (item 430 (b)) and the degree clause on `T` (430 (a)) in place of "changing no point's
degree", and ends "Inhabitant: no Lean model on file; `l60Frag` cleaned, its whole arc, at [hand] (FS131-QA4 § 6.2, rank 7)";
`exists_vertexStep`'s opens "each followed by `cleanKeep`". **No other statement changed**: `tools/fs131_ir_stmt_check.py a5a12a0b` over
nine files (`Limit`, `Procedure`, `Terminal`, `Chain`, `Surgery`, `Moves`, `MergeMove`, `OpenMove`, `FlankUA`; 827 statements read):
exactly one changed, `exists_arcStep` (exit 1, as it must be; `ir3/stmt-check-23.txt`); with `--allow exists_arcStep`: PASS
(`ir3/stmt-check-23-allow.txt`).

**A tool defect found** (another job's tool; not edited): `tools/fs131_il_stmt_check.py --self-test` exits 1 on this tree with its
unplanted control passing — its first plant names a hypothesis `(hc : F.IsClean)` that `badCount_lt_top` does not have, so the
replace is a no-op and the plant cannot fire (`DID NOT FIRE`). The checker's plain run is sound (it reported the ruled change); only
its self-test is stale. **`tools/fs131_ir_stmt_check.py`** is this job's copy: the move modules added to the file list, the head
pattern reading a declaration behind an attribute or `private`, six plants each raising if its target text is absent, `--allow` for
a ruled change. Its `--self-test`: six plants FIRED, the unplanted control PASS, exit 0 (`ir3/stmt-check-selftest.txt`).

### 23.2 The merge of `origin/fs131-w5s` (`facdf1c2`), commit `77acd5c5`

One conflict, `scripts/Axioms.lean`, as the brief's trial merge said: both blocks kept (IR2's block, then FS131-IS1's seven records);
`ARCHITECTURE.md` merged by itself. `tools/fs131_ir_merge_check.py ebb0b292 57b6d9c7 facdf1c2` (IR1's tool; base, ours, theirs; the
merged side read from the index): **15,815 files, 0 failures, PASS** (`ir3/merge-check.txt`); its `--self-test` with these refs: five
plants FIRED, the unplanted run PASS (`ir3/merge-check-selftest.txt`); the same check told a wrong "theirs" (`4f7115e3`, two commits
back on that branch): 12 failures, FAIL (`ir3/merge-check-control.txt`). The merge is its own commit (a merge cannot be committed by
path; the index held the merge and nothing else, and my three check files were untracked at the time).

### 23.3 The build, the axioms print, the checks

- **Build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 457 of 457 batches, 7 modules rebuilt, 4 with warnings, all 10 warnings `declaration
  uses 'sorry'`**: `Procedure` 5 (the four cases l. 1334, 1346, 1358, 1372; `exists_arcStep` l. 1442); **`Terminal` 0**; not mine:
  `BaseDense` 3, `BendCollar` 1, `HexRing` 1. 9 min 22 s, exit 0 (`build/gate/build/20261006T050823Z-1209628.log`, which ends "Build
  completed successfully (5792 jobs)"; driver log `data/fs131/ir/ir3/build-stage23.log`).
- **Axioms** against that build (`data/fs131/ir/ir3/IR3Axioms23.lean` → `.out`, `slot.py --mem 12 --cpus 2 -- lake env lean`, exit 0;
  `tools/fs131_ir_axsum.py` with `IR3Axioms23-expect.txt`; `IR3Axioms23-summary.txt`, PASS): **15 records — 4 on the standard three
  (`stuckRun_ne_univ`, `shadow_recursion`, `horn_upper_ne_one`, `horn_lower_ne_neg_one`), 11 through `sorryAx`, exactly the eleven
  expected, 0 other.** `exists_terminal` is on `sorryAx` through the five open leaves alone (the four cases and `exists_arcStep`:
  the build names no other `sorry` under it). **Control**: the same output read with IR2's expectation, which lists
  `stuckRun_ne_univ` among the `sorry` names, FAILS naming it (`SORRY-EXPECTED-BUT-STANDARD`, `IR3Axioms23-control.txt`).
- **The map**: `tools/check_architecture.py` PASS (`ir3/arch-stage23.txt`).
- No `axiom`, no `native_decide`. I ran no gate and did not touch `main`.

## Stage 23 — SAVED (FS131-IR3)

## Stage 24 — SAVED (FS131-IR3): MERGE-RAY's case proved; the kit the four cases share (two curves; a move's disc in one statement)

### 24.1 What was proved ([kernel]; `Procedure`, subsection "A point on two curves, and the points of a move's disc in one statement", then "MERGE-RAY's case")

- **`not_isSite_of_two_curves`** — the junction lemma in its two-curve form: a point of a clean map near which `Γ` lies on two
  curves `curveAt x κ b`, `curveAt x κ' b'` through it with non-parallel normals (`(b * conj b').im ≠ 0`), with points of the two
  curves off `Γ` arbitrarily near it, is no site and carries at most three colours. (`hasHornCount_zero_of_germs` with the four curve
  germs; one of the four is dead — by contradiction, no identification of which; `not_hasRepeatedColour_of_degree_le_three`.)
- **`not_isSite_of_rim_junction`** — the same at a branch from `v` meeting the circle of radius `ρ` about `v`: transversality is
  `im_ne_zero_of_far` (the branch's curve passes through `v` and, at some `r > ρ` where it is still a graph, holds a point farther
  from `v`; a curve tangent to the circle at `x` and through `v` is the circle on the diameter `[v, x]`, all of it within `ρ` of `v`).
- **`not_isSite_of_branches`** — **the whole disc in one statement**: if the arcs of a clean map `M` in the punctured ball
  `B(v, R)` lie on the circle of radius `ρ₁` and on finitely many branches from `v`, pairwise apart and graphs out to `R`, then
  every `x ≠ v` of the ball is no site and carries at most three colours, given a dead branch where a branch meets the circle at
  `x`. (The branches not through `x` are compact pieces away from it; off the circle or off every branch `x` is on at most one
  curve, `not_isSite_of_curve`.) It mentions neither the map before the move nor a chart.
- **`Near.not_isSite_of_chart`** — the same read in the chart of the map before the move, with a finite set `𝒠` of extra branches
  apart from the germs (SHAVE's arc, OPEN's ray); `Near.exists_rim_mem_sector`, `_before` (points of the rim circle in the chart
  sector after, before, a germ, arbitrarily near the germ's rim point); `Near.move_not_mem_cleanKeep_Γ` (a chart sector on which a
  `Near.move` keeps the map's colour holds no arc of the cleaned move); `Near.move_Γ_cases` (the arcs of a `Near.move` near `v`).
- **`Near.RayConfig.exists_step`** and **`exists_rayStep`** — MERGE-RAY's case, as stated by IR2, **proved**.

### 24.2 The route, where it differs from § 20.2's (decisions of mine)

- **No declaration was added to `Moves`** (ruling 421 (c) allowed it; it was not needed): `Near.move`, `rayKeep`, `rayCol`,
  `RayConfig.hlc`, `move_valid` and the rest are public, so the map is named in `Procedure` and the two clauses read from
  `RayConfig.exists_merge`'s body (validity, no colour gained at `v`; about 35 lines) are re-run there. A named form in `Moves`
  would save those lines and cost a rebuild of every module downstream of `Moves`; if the coordinator prefers one proof, the split
  is `RayConfig.exists_merge` at its `set F' := …`.
- **The nearest-horn choice is not needed, and neither is the sector count.** `RayConfig.exists_merge` asks that the gap hold no
  chart sector of colour `c` (`hfree`), which is why `exists_rayMerge_of_clear` picks the nearest `c`-horn and why § 20.2 excludes
  the cut case by cleanness. `hfree` serves only the count `HasSectors v c n`; the step's count is the potential
  (`pot_lt_of_interior` at the lower horn's upper germ), so `RayConfig.exists_step` takes the two given horns as they are, and
  `exists_rayStep` does not read its hypothesis `hn` (kept in the statement; `have _ := hn`).
- **A dead branch at every junction, by one of two reasons.** A kept germ: the chart sector after it is the lower horn (colour `c`
  before and after) or misses the merged horn (`RayConfig.sector_disjoint`), so it has one colour on both sides of the rim — its
  rim points are on no arc of the cleaned map. A dropped germ: its points inside the rim are interior to the merged horn.
- `exists_hasHornCount` (IR1's) is moved up in the file, before the cases that read it; its statement is unchanged.

### 24.3 For the arc step's assembly (the brief's question)

`not_isSite_of_two_curves` is stated for any two curves `curveAt x κ b` through `x` — it does not know about `v`, a rim or a move —
so a bend's new curve meeting an old arc at a point is an instance: its hypotheses are that near the point `Γ` lies on the two
curves, that their normals are not parallel there, and that one of the four branches is dead. `not_isSite_of_branches` is the form
for a point from which finitely many branches leave, with one concentric circle. I built nothing for the arc step.

### 24.4 The build, the receipt, the checks

- **Build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 457 of 457 batches, 6 modules rebuilt, 4 with warnings, all 9 warnings `declaration
  uses 'sorry'`**: `Procedure` 4 (`exists_mergeStep` l. 1837, `exists_shaveStep` l. 2027, `exists_openStep` l. 2041, `exists_arcStep`
  l. 2111 — **not `exists_rayStep`**); `Terminal` 0; not mine: `BaseDense` 3, `BendCollar` 1, `HexRing` 1. 9 min 1 s, exit 0
  (`build/gate/build/20261006T052839Z-1285243.log`, which ends "Build completed successfully (5792 jobs)"; driver log
  `data/fs131/ir/ir3/build-stage24.log`).
- **Axioms** against that build (`data/fs131/ir/ir3/IR3Axioms24.lean` → `.out`, exit 0; `tools/fs131_ir_axsum.py` with
  `IR3Axioms24-expect.txt`; `IR3Axioms24-summary.txt`, PASS): **28 records — 18 on the standard three or fewer (the 17 of this stage
  and `exists_hasHornCount`), 10 through `sorryAx`, exactly the ten expected, 0 other.** **`exists_rayStep` depends on `[propext,
  Classical.choice, Quot.sound]`.** `exists_vertexStep` is on `sorryAx` through the three cases left. **Control**: the same output
  read with Stage 23's expectation (which lists `exists_rayStep` among the `sorry` names) FAILS naming it
  (`SORRY-EXPECTED-BUT-STANDARD`, `IR3Axioms24-control.txt`).
- **Statements**: `tools/fs131_ir_stmt_check.py 2ead3ee3` (against Stage 23): PASS, 832 statements read, additions only
  (`ir3/stmt-check-24.txt`). No `axiom`, no `native_decide`. `tools/check_architecture.py` PASS (`ir3/arch-stage24.txt`; no import
  changed).
- **Receipt**: a block "FS131-IR3" of 17 records in `scripts/Axioms.lean`, above `=== PURCHASED ===`.
- No definition was added (no spec example is owed). The new theorems are parametric in their maps (the vacuity scan's GENERIC);
  `Near.RayConfig.exists_step` and `exists_rayStep` have no Lean model on file, as `exists_vertexStep` (their docstrings say so).
- Working files: `data/fs131/ir/ir3/scratch/Kit.lean` (the kit and the case as developed; it elaborated against Stage 23's build),
  `scratch/transplant24.py` (the script that placed it in `Procedure`).

## Stage 24 — SAVED (FS131-IR3)

## Stage 25 — SAVED (FS131-IR3): SHAVE's case proved; the assembly the four cases share

### 25.1 What was proved ([kernel]; `Procedure`, subsections "The assembly the four cases share" and "SHAVE's case")

- **`surgery_step`** — the assembly, once for the four cases: a valid surgery at `v` of radius `ρ`, its new arcs in the closed disc
  and its colouring `F`'s off it, creating no unit arc and adding no colour at `v`, whose cleaned map has no site and at most three
  colours at the other points of the disc and a lower potential at `v`, gives the vertex step's conclusion (`cleanKeep_valid`,
  `cleanKeep_isClean`, `surgery_cleanKeep_localStep`; `IsModification`'s colour clause off the disc by locality, at `v` by the
  surgery's clause, elsewhere in the disc by the bound three). `Near.move_step` is the same for a `Near.move`. MERGE-RAY's
  `RayConfig.exists_step` now ends in it (its statement unchanged).
- **`Near.exists_shaveStep_aux`** and **`exists_shaveStep`** — SHAVE's case, as stated by IR2, **proved**. The count is § 20.2's
  (`pot_lt_of_sectors` with the shaved horn): a sector of the cleaned map holds an interior point of the move
  (`dense_interiorPts`); off the horn its chart sector lies in the sector; in the horn above the `σ`-arc, the upper piece
  `hornSet v α σ κ₂ r`, a point of the germ above it and the flank sector are joined
  (`subset_connectedComponentIn_of_mem_closure`), the germ's point being interior after cleaning because both sides carry `g` near
  it (`mem_cleanKeep_interiorPts_of_const` on a ball cut by `0 < tanHeight σ`); below, the same with `h`.
- The rim (`Near.not_isSite_of_chart` with the extra branch `(α, σ)` when `κ₁ < σ < κ₂`): at a germ other than the horn's lower one
  the sector after it misses the horn and keeps its colour; at the horn's lower germ the sector before it does; **the `σ`-arc ends
  on the rim** (a T-junction), and the dead branch is its continuation past the rim, interior to the horn outside the disc.

### 25.2 The route, where it differs from § 20.2's (decisions of mine)

- **`Moves`' two cut cases are not separated**, and neither `g ≠ c` nor `h ≠ c` is used: § 20.2 excluded the cuts by cleanness
  (a flank of the horn's colour); the recolouring serves whatever the flank colours are, because the count reads the potential
  and not `HasSectors v c n`. `exists_shaveStep` does not read its hypothesis `hn`.
- **No declaration was added to `Moves`** (as Stage 24): `shaveArcs`, `shaveCol`, `Near.shave_hlc`,
  `Near.shave_mem_interiorPts_iff` are public; validity and "no colour gained at `v`" are re-run from `exists_shave_recolour`'s
  body (about 20 lines).

### 25.3 The build, the receipt, the checks

- **Build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 457 of 457 batches, 6 modules rebuilt, 4 with warnings, all 8 warnings `declaration
  uses 'sorry'`**: `Procedure` 3 (`exists_mergeStep` l. 1922, `exists_openStep` l. 2398, `exists_arcStep` l. 2468); `Terminal` 0; not
  mine: `BaseDense` 3, `BendCollar` 1, `HexRing` 1. 8 min 58 s, exit 0 (`build/gate/build/20261006T054044Z-1332088.log`, which ends
  "Build completed successfully (5792 jobs)"; driver log `data/fs131/ir/ir3/build-stage25.log`).
- **Axioms** against that build (`data/fs131/ir/ir3/IR3Axioms25.lean` → `.out`, exit 0; `tools/fs131_ir_axsum.py` with
  `IR3Axioms25-expect.txt`; `IR3Axioms25-summary.txt`, PASS): **33 records — 24 on the standard three or fewer, 9 through `sorryAx`,
  exactly the nine expected, 0 other.** **`exists_shaveStep` and `exists_rayStep` depend on `[propext, Classical.choice,
  Quot.sound]`.** **Control**: read with Stage 24's expectation (which lists `exists_shaveStep`), the summarizer FAILS naming it
  (`IR3Axioms25-control.txt`).
- **Statements**: `tools/fs131_ir_stmt_check.py 844435a5` (against Stage 24): PASS, 848 read, additions only
  (`ir3/stmt-check-25.txt`). No `axiom`, no `native_decide`. `tools/check_architecture.py` PASS (`ir3/arch-stage25.txt`).
- **Receipt**: six records more in the "FS131-IR3" block of `scripts/Axioms.lean` (23 in all).
- Working files: `data/fs131/ir/ir3/scratch/Shave.lean`, `scratch/transplant25.py`.

## Stage 25 — SAVED (FS131-IR3)

## Stage 26 — SAVED (FS131-IR3): MERGE's case proved

### 26.1 What was proved ([kernel]; `Procedure`, subsection "MERGE's case")

**`Near.exists_mergeStep_aux`** and **`exists_mergeStep`**, as stated by IR2. The map is `MergeMove`'s surgery at radius `ρ` for
the gap `Near.exists_gap` gives; the radius is `min (min (ρ'/2) (ρc/2)) (δ/2)` (§ 20.2 (a): `exists_merge_aux`'s body re-run with
`δ/2`; no declaration added to `MergeMove`). Through `surgery_step`:
- validity `merge_valid`, no colour gained `merge_coloursAt_self`, no unit arc `merge_ringArcsWithin`;
- **the arcs**: a point of the surgery's `Γ` is on `F`'s `Γ` or on the rim arc (`mem_merge_interiorPts_of_mem`, read backwards),
  so in the punctured ball the arcs lie on the chart's branches and the circle of radius `ρ/2` — the junctions are on that circle,
  as § 20.2 located them, and the points of `sphere v ρ` need no separate argument (they are points of `B(v, ρ')` off that circle);
- **the dead branch**: at a gap germ, its branch inside `ρ/2` is interior to the surgery (`mem_mergeArcs_inner`: the arcs kept
  inside `ρ/2` are germs off the gap); at any other germ the sector after it is no gap sector, so its points on the circle are off
  the rim arc (`gapSec_of_mem_rimArc`) and interior to the surgery;
- **the count**: `pot_lt_of_interior` at the gap's first germ `idx s (a + 1) = next (idx s a)`.

### 26.2 The route, where it differs from § 20.2's

No colour function is read at the junctions (§ 20.2 proposed `mergeCol_of_mem_sector`, `mergeCol_of_mem_sector_out`): every dead
branch is a set of points interior to the surgery itself. Neither "the gap holds no `c`-sector" (`exists_gap`'s fifth clause, dropped
at the `obtain`), nor `a + 1 < b`, nor the absence of phantom germs is used — the three sub-cases § 20.2 removes by cleanness
never needed separating.

### 26.3 The build, the receipt, the checks

- **Build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 457 of 457 batches, 6 modules rebuilt, 4 with warnings, all 7 warnings `declaration
  uses 'sorry'`**: `Procedure` 2 (`exists_openStep` l. 2511, `exists_arcStep` l. 2581); `Terminal` 0; not mine: `BaseDense` 3,
  `BendCollar` 1, `HexRing` 1. 9 min 11 s, exit 0 (`build/gate/build/20261006T055146Z-1390179.log`, which ends "Build completed
  successfully (5792 jobs)"; driver log `data/fs131/ir/ir3/build-stage26.log`).
- **Axioms** against that build (`data/fs131/ir/ir3/IR3Axioms26.lean` → `.out`, exit 0; `IR3Axioms26-summary.txt`, PASS): **34
  records — 26 on the standard three or fewer, 8 through `sorryAx`, exactly the eight expected, 0 other.** **`exists_mergeStep`
  depends on `[propext, Classical.choice, Quot.sound]`.** **Control**: read with Stage 25's expectation (which lists
  `exists_mergeStep`), the summarizer FAILS naming it (`IR3Axioms26-control.txt`).
- **Statements**: `tools/fs131_ir_stmt_check.py a6642d49` (against Stage 25): PASS, 853 read, additions only
  (`ir3/stmt-check-26.txt`). No `axiom`, no `native_decide`. `tools/check_architecture.py` PASS (`ir3/arch-stage26.txt`).
- **Receipt**: two records more in the "FS131-IR3" block of `scripts/Axioms.lean` (25 in all).
- Working files: `data/fs131/ir/ir3/scratch/Merge.lean`, `scratch/transplant26.py` (run with `merge`).

## Stage 26 — SAVED (FS131-IR3)

## Stage 27 — SAVED (FS131-IR3): OPEN's case proved; the vertex step rests on no open case; the handover

### 27.1 What was proved ([kernel]; `Procedure`, subsection "OPEN's case")

**`Near.exists_openStep_aux`** and **`exists_openStep`**, as stated by IR2. The map is `OpenMove`'s surgery for the configuration
`Near.exists_openConfig` gives. Through `surgery_step`:
- validity `open_valid`, no colour gained `open_coloursAt_self`, no unit arc `open_ringArcsWithin`;
- **the arcs**: on `F`'s `Γ`, on the circle of radius `ρ/2` (`norm_of_mem_rimArc`, `openRim_subset_sphere`), or on the ray
  `v + t e ψ`, `t ≤ ρ/2` — the branch `(ψ, 0)`, apart from the chart's germs below the configuration's clear radius `ρc` because
  it runs strictly inside the partial sector there (`OpenConfig.ray`);
- **the dead branch**: at a gap germ, its branch inside `ρ/2` (`OpenConfig.not_mem_openArcs`: a direction in the window, off the
  ray); at another germ, the sector after it if that is not the partial sector, else the sector before it — neither a gap sector
  nor the partial sector, so interior to the surgery on the circle (`mem_open_interiorPts_of_sector_off`); at the ray's end, the
  ray's continuation past `ρ/2` (`mem_open_interiorPts_of_mem`);
- **the count**: `open_degree_horns` (`m₁ ≤ m`, `j₁ < j` for the surgery) and `cleanKeep_pot_le`.

**One change of radius** (mine to decide; no statement touched): `exists_open` takes `ρ = min (min (ρ'/2) ρc) (δ/2)`, so `ρ ≤ ρc`
and the ray is known inside the partial sector only up to `ρ`. The step needs it past the inner rim, out to the chart radius the
kit reads (`R > ρ`), so `exists_openStep` takes the chart radius `R = min ρ₀ ρc` and `ρ = min (R/2) (δ/2)`: then `ρ < R ≤ ρc`.

### 27.2 The build and the receipt (the handover)

- **Build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 457 of 457 batches, 6 modules rebuilt, 4 with warnings, all 6 warnings `declaration
  uses 'sorry'`**: **`Procedure` 1 — `exists_arcStep` l. 2748, and no other**; `Terminal` 0; not mine: `BaseDense` 3, `BendCollar` 1,
  `HexRing` 1. 9 min 17 s, exit 0 (`build/gate/build/20261006T060632Z-1519398.log`, which ends "Build completed successfully (5792
  jobs)"; driver log `data/fs131/ir/ir3/build-stage27.log`). By `grep -nw sorry` `Procedure` reads one line, l. 2759.
- **Axioms** against that build (`data/fs131/ir/ir3/IR3Axioms27.lean` → `.out`, `slot.py --mem 12 --cpus 2 -- lake env lean`, exit 0;
  `tools/fs131_ir_axsum.py` with `IR3Axioms27-expect.txt`; `IR3Axioms27-summary.txt`, PASS): **35 records — 29 on the standard three
  or fewer, 6 through `sorryAx`, exactly the six expected, 0 other.** By name: **`exists_rayStep`, `exists_shaveStep`,
  `exists_mergeStep`, `exists_openStep` and `exists_vertexStep` each depend on `[propext, Classical.choice, Quot.sound]`**;
  `exists_arcStep` is the `sorry`; `exists_procStep`, `exists_terminalSeq`, `exists_terminalMap`, `exists_red`, `exists_terminal`
  are on `sorryAx` through it alone (the build names no other `sorry` in `Procedure` or `Terminal`). **Controls**: read with
  Stage 26's expectation (which lists `exists_openStep` and `exists_vertexStep`), the summarizer FAILS naming both
  (`IR3Axioms27-control.txt`); the same output with a foreign axiom planted in `exists_vertexStep`'s record makes it exit 1, naming
  it (`IR3Axioms27-planted-summary.txt`); the six `sorryAx` records are the print's positive control.
- **Statements**: `tools/fs131_ir_stmt_check.py a036811f` (against Stage 26): PASS, 854 read, additions only
  (`ir3/stmt-check-27.txt`); **against the tree as given, `a5a12a0b`, over nine files (827 statements): one changed,
  `exists_arcStep`, the ruled restatement** — PASS with `--allow exists_arcStep` (`ir3/stmt-check-final.txt`); the checker's
  `--self-test`: six plants FIRED, the unplanted control PASS (`ir3/stmt-check-final-selftest.txt`). No `axiom`, no
  `native_decide`. `tools/check_architecture.py` PASS (`ir3/arch-stage27.txt`; no import changed in this job).
- **Receipt**: the block "FS131-IR3" in `scripts/Axioms.lean`, 27 records, above `=== PURCHASED ===` (`exists_vertexStep` itself is
  recorded in an earlier block and is now standard there).
- **Declarations added to landed modules** (ruling 421 (c)): **none** — `Moves`, `MergeMove`, `OpenMove`, `Surgery`, `FlankUA` are
  untouched; everything is in `Procedure` (1,297 lines added by this job, the file now 3,403 lines). In `Procedure`: no statement
  or definition changed but the ruled one; `exists_hasHornCount` moved up in the file, its statement unchanged; the proofs of
  `exists_procStep` (two lines, Stage 23) and `RayConfig.exists_step` (its tail, Stage 25) edited; docstrings of the four cases,
  the two steps and the cases' section header brought up to date; one-line inhabitant notes on the new step lemmas (LEAN.md § The
  gate).
- I ran no gate, did not touch `main`, `Terminal.lean` beyond the merge, or `BendStep`; five builds, each ended with its exit line
  read; no process left running.

### 27.3 What is proved, and what is left

**Proved**: the four cases, so `exists_vertexStep` is [kernel] on the standard three. Their truth at the junctions — IR2's hand
check, one mind — is now the kernel's: at every junction of every move one branch is dead, by one of three reasons (a chart sector
that keeps its colour across the rim; points interior to the surgery; the continuation of an arc that ends on the rim). No clause
of any case failed, and no message to the coordinator was needed.

**Left under `exists_terminalMap`: `exists_arcStep` alone** (`sorry`; not this job's — its assembly is a later job's, on FS131-IA1's
groundwork on `fs131-w5a`). Its statement is ruling 430's (Stage 23); its consumer `exists_procStep` reads the restated degree clause
on `T` and compiles. For that assembly: § 24.3 says what the two-curve lemma offers it.

**Next step for a successor starting cold**: read Stages 22–27; check out `fs131-w5c` at this stage's commit; build once under the
slot (expect "all … up to date"); re-run `data/fs131/ir/ir3/IR3Axioms27.lean` through `tools/fs131_ir_axsum.py` with
`IR3Axioms27-expect.txt` (expect PASS, 29 and 6); then `exists_arcStep`.

### 27.4 Prices, scored

IR1 and IR2 priced the four cases at two sessions (IR2: 300–500 lines each, a junction lemma of about 150). Measured: one session;
the kit 480 lines (Stage 24, of which the two-curve lemma 100 and `not_isSite_of_branches` 105), MERGE-RAY 150, SHAVE 250 with the
assembly 90, MERGE 110, OPEN 170. What made it short: `not_isSite_of_branches` reduced "no site at the other points of the disc"
to a description of the arcs and one dead branch per junction, and no case needed the three exclusions by cleanness.

## Drafts for the front page

None to file now: wave 5 is not at its gate (`exists_arcStep` is a `sorry`), and my brief runs no gate. For the filing, when
`exists_terminalMap` closes — slot `LEDGER.md`, the rows for N2-TERM's `exists_red` and `exists_terminal` (they regrade to [kernel]
only after `exists_arcStep`): the vertex step's declarations to name are `ArcMap.exists_vertexStep` and its four cases
`ArcMap.exists_mergeStep`, `.exists_rayStep`, `.exists_shaveStep`, `.exists_openStep`, each on `[propext, Classical.choice,
Quot.sound]` with no assumption beyond their stated hypotheses (`F.Valid`, `F.IsClean`, `F.Covers v 1`, the move's own). Slot
`CLAUDE.md` § The gate and § Trust ledger: no count is mine to state (I ran neither `axioms.sh` nor `vacuity.sh`); this job adds 27
records to the receipt's CLEAN section and no purchase.

## Stage 27 — SAVED (FS131-IR3)
