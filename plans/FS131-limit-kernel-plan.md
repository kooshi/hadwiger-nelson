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

None yet (updated at each saved stage).

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
