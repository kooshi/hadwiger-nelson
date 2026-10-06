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

*(Filled at each saved stage; the handover stage carries the axioms print.)*

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
