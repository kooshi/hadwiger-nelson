# FS131-KL1 — the limit constructions planned: `exists_red`, `exists_terminal` over a limit of `ArcMap`s

*de Bruijn, the planner (Opus), on branch `fs131-w5c` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c`, from `ff6e917f`. Brief:
`data/fs131/briefs/FS131-KL1-limit.md` (main tree). Record of the planning job; the implementer works from §§ 4–7.*

## Theorems this phase proved

None yet (a planning job; see the last stage for any child proved).

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
