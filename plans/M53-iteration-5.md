# M53 — iteration 5 from the culled plain object (SUBPLAN, 2026-09-04; §1–§9 are the stub as Kooshi compacted on it, §B onward the subplan)

*Rewritten 2026-09-04 at the M52 close, before Kooshi's compaction, to the stub rule's standard:
everything the deciding session knew, in plain language, so a session with zero conversation memory
can subplan it with all meaning intact. Kooshi's rulings that shape it (2026-09-04): "it-5 should be
next"; "defer the rest of the cull until after it's done — those asks should get easier once we have
the more rigid post-it-5 object; unknowns just get carried; the it-5 algo will need the cores"; and,
earlier, "efficiency in Rust before compute" and the in-field pool as a conditional. Read beside
this: `plans/DESCENT-ALGORITHM.md` (the loop, now with phase 0″ the cull and phase 2′ the pool by
field), `plans/RISKS.md` (R1 first), `plans/M52-copy-lock-objects.md` §R0–§R5 (the evidence),
`plans/M51-descent-engine.md` §S-CONT (the campaign log through iteration 4), the engine's
`plans/WO-14-outcome.md` and `plans/WO-16-licence-holding.md`.*

## 1. Mission context, in plain language

The project hunts new mathematics about the plane's chromatic number; the kernel holds
5 ≤ χ(ℝ²) ≤ 7. The live instrument is the **descent**: a 214-point graph (Exoo–Ismailescu) whose
non-5-colourability is financed by 446 "cheat" edges at distance 2 rather than 1 forces two of its
vertices (205 and 206, at distance 5) to share a colour in every proper 5-colouring; the descent
replaces cheats with genuine unit-distance material — glue points, each the intersection of unit
circles about two existing points, chosen to kill every separating colouring a batch of deleted
cheats would admit — one certified batch per iteration. When the unit material alone forces the
pair (zero cheats), the distance-5 spindle makes a 6-chromatic unit-distance graph by a kernel
theorem, and the plane needs six colours. Four iterations and one cull have run: the dial reads
**446 → 149**. The unit part is still 4-colourable; the spare-colour theorem (`SpareColour.lean`)
says it must cross to 5-chromatic before the end, as committed material, with no copy.

## 2. The object iteration 5 starts from

| | |
|---|---|
| label | `S29-depth2r-it2v2-depth1-it2v2-depth1-vdel28-it2v2-depth1` (the plain iteration-4 object) |
| files | `data/m51/m50-object-…-vdel28-it2v2-depth1.json` (tracked; provenance form), `build/m50-object-<label>.json` (the live copy); fingerprint `f0871bab2b915b4f`, bare `d5b1070e4055d241` |
| points | 1,981 (186 live seed of 214 — 28 deleted, edgeless — + 1,767 glue points to depth 5); **every point in ℚ(√3, √11)**, exact 4-basis coordinates in `data/m52/exact-<label>.json`, all 13,796 unit edges exact identities (T14) |
| unit edges | 13,796, every one on the half-twist direction ladder θ ≡ 30a + m·arccos(5/6)/2 (T13) |
| standing cheats | **149** = 27 floor (essential alone, `data/m51/m51-floor-it5-verdicts.jsonl`) + 10 kept by the enumeration cull + 60 witnessed necessary by the Rust culler + **46 kept-undecided** (52 at the 3M/30M rungs; 6 became necessary at 300M before the re-ask was stopped) — the list: `data/m52/cull-result-it4.json` (`kept_final`), the culler's journal `data/m52/rustcull-it4-journal.jsonl` |
| the culled edges sidecar (what the engine reads) | `build/m51-edges-<label>+cull149.json` — `removed` = the 71 halo-removed cheats + the 124 the cull dropped; `cheats_remaining` 149; rebuildable from the object + `cull-result-it4.json` with the snippet in M52's ledger row of 2026-09-03 ~20:20Z |
| the plain sidecar | `build/m51-edges-<label>.json` (removed 71, cheats_remaining 273) |
| certificate of the culled set | one-hot UNSAT 10,640 s; **3-bit re-encode UNKNOWN at 43,200 s** — the culled object is a CANDIDATE on one encoding (R3); `data/m52/final-certify-149.json` |
| the depth-1 pool | **NONE for this object yet.** The cached pools (`build/m51-pool-<bare>-depth1.{json,npz}`) are keyed by the object's bare fingerprint: `c62ecd80a01087ca` is the iteration-3-era object's (1,469,696 points, 133 MB npz); the iteration-4 object needs its own build (~2 h vectorized at 1,981 points; `python3 tools/batchkill.py --pool-only --object <label>`), or the in-field-restricted build (§4) |
| χ(unit part) | 4 (`tools/m50_skewscan.py --unitchi`) |
| viewer | `tools/descent-viz.html`, artifact https://claude.ai/code/artifact/d35ad805-f5dd-483a-a03d-6160704ae6cf (republish: `descentviz_refresh.py --object <label> [--dropped data/m52/culled-final.json]` → `descentviz_artifact.py build/m52-viz-artifact.html` → the Artifact tool with the URL) |

## 3. What changed in the loop since iteration 4 (and why)

1. **Phase 0 is the Rust culler's census, and the cull is a per-commit column.** `descent cull
   --census --groups cheats` replaces `batchkill --recurse` (273/273 agreement, WO-14 A3; the same
   CPU on a census, 10.7× on a cull because the reference cull's CNF was the bottleneck — hard
   clauses, no selector guards). After every halo commit, cull again: the new material makes more
   cheats jointly redundant (273 → 149 on the first complete cull), and the cull is zero geometry.
2. **The batch is chosen from the culled standing set**, where every non-undecided cheat is
   individually necessary (witnessed): the sub-batch curve (`tools/subbatch.py`) starts from a floor
   that IS the standing set; the class count per absent cheat is the same law over fewer cheats.
3. **The pool may be restricted to the in-field slice** (§4), conditional on a measurement.
4. **The copies are not material** (M52 §R3): a ρ₁₅ copy kills 0 of 15,218 classes at five colours;
   D38 (the rotated-copy provenance dialect) is NOT needed. The copy trick is the endgame's tool: its
   kill census is re-run once χ(unit) crosses to 5.
5. Everything else is iteration 4's pipeline: enumerate (Rust `descent enumerate`), profile
   (Rust `descent replay` on the pool export), hitting set (`batchkill --hitting`, scipy MILP over
   survivors ∪ unknowns), design + shrink (Rust `descent design`), certify + commit (Python
   `batchkill --commit --pool depth1 --object <label>`: lookup re-check, one-hot + 3-bit UNSAT, exact
   geometry), columns (`m50_skewscan.py --unitchi`, `field_census.py`, `--scan`), the viewer.

## 4. The order of work (the subplan sharpens each; commands as the record holds them)

**Phase 0 — the out-of-field kill census (RISKS R1's test; FIRST).** The depth-1 pool of the
iteration-4 object is 15 % in-field (280,390 of ~1.9 M points), 3 % in the √5/√35/√2/√14 classes,
81 % in non-rational classes (`data/m52/poolfield-<label>.json`, `tools/pool_field_census.py`), and
**every committed point so far came from the in-field 15 %**. Reading (G34): the design's tiers rank
pool points by object degree, high degree means on-ladder means in-field — a structural selection,
not a verdict on the material. The test: build the pool (`--pool-only`; the builder records each
pool point's parent pair), tag every pool point with its radicand's square class (the census tool's
classification over pairs), export the OUT-OF-FIELD subset as a pool (the same re-export path that
made the `pdeg12`/`strong3`/`mixed16` pools at iteration 4 — `batchkill`'s restricted-pool export;
verify the flag with `--status`), enumerate ONE batch on the culled sidecar (`descent enumerate
--edges build/m51-edges-<label>+cull149.json --out … --floor u-v,… --threads 8 --conflicts 40000000
--max-classes 5000000`; a batch of ~8 standing cheats — 4 of the 27 floor + 4 others gave 15,218
classes on the un-culled object), and replay it against the out-of-field pool (`descent replay
--manifest <pool.json> --classes <list> --out … --threads 12`, first pass wall-capped). **Registered
prediction P-M53-1:** the out-of-field pool kills a nonzero fraction that the in-field pool does not
(confidence low; Kooshi's two horns are exactly zero / nonzero).

**Phase 0′ — the pool decision.** If P-M53-1 reads ZERO: **the in-field pool** (Kooshi: "keep only
the √3 and √11 points for all iterations until we hit a wall") — build/export only in-field pairs
(140,195 of 950,371 on this object: ~6× off the pool, the profile's memory (~8 GB → ~1.3 GB per
worker), and the design's candidate set), sound by the restricted-pool rule (T11, K3: a kill
transfers, a survival is adopted as unknown against the full pool), with the monitor kept — once
per iteration one batch's in-field survivors re-asked on the full pool; the first out-of-field-only
kill is the wall arriving and lifts the restriction. If NONZERO: the design gets a field-aware tier
(out-of-field candidates offered explicitly) — a WO for the engine's `design`.

**Phase 1 — the batch.** `descent cull --census` on the culled sidecar (minutes) as the floor
column; the sub-batch curve from the 149 (`tools/subbatch.py`) to an affordable class count (the
law: ~1.3–1.5× per absent cheat; iteration 4 spent 28 of 39 floor cheats at 37,316 classes);
enumerate (Rust); export the committable sub-list (`tools/export_sublist.py`).

**Phase 2–3 — pool + profile.** The pool per Phase 0′; `descent replay` at ≤ 12 workers (the
memory pre-flight names the count); the tail on a restricted pool first (pdeg12 pattern) then the
full pool for unknowns; adopt with `tools/adopt_rust_profile.py` (kills only from restricted pools;
unknowns never folded).

**Phase 4–6 — hitting, design, certify, commit.** `batchkill --hitting` (keep ≤ 4 expected);
`descent design … --threads 26` whole-pool pass on (decision 29's whole-pool kills dissolve stalls;
the shrink checkpoints per acceptance); `batchkill --commit --pool depth1 --object <label>` with
`CERTIFY_ONEHOT_CAP`/`CERTIFY_REENCODE_CAP` raised (the it-4 3-bit took 8,228 s; the culled set's
3-bit did not finish in 43,200 s — **R3: the 3-bit needs the cube front-end, or the commit is a
candidate**). Refused ⟹ INVESTIGATE, never retry.

**Phase 7 — the columns and the cull.** χ(unit) (4 → 5 ⟹ HALT and certify the new witness), the
field census (`tools/field_census.py` — and now the pool field census), the weighted-ladder scan,
`descent cull --groups cheats` on the new object (the per-commit cull; the carried 46 undecided
join its candidates), the viewer republished, the object snapshot to `data/m51/` (the chain) and the
iteration's results to `data/m53/`.

## 5. Carried unknowns (Kooshi: "unknowns just get carried")

* **The 46 undecided cheats** of M52's cull: kept-undecided in the standing set; re-asked at the
  300M rung after iteration 5's commit (the more rigid object makes the asks easier). The culler's
  journal `build/m52-rustcull-it4/cull.jsonl` (tracked copy `data/m52/rustcull-it4-journal.jsonl`)
  resumes by the same command with `--conflicts 30000000,300000000`.
* **The whole-object point shrink under the culled set** (the cull for points: which committed halo
  points are still necessary with 124 cheats gone): zero geometry, value = object size, priced by a
  24-point census at ~1.1 CPU-h per probe (16 necessary / 3 droppable / 5 undecided of 24; 2.7 h at
  twelve workers) ⟹ ~200 desktop-hours for 12–33 % of the halo. A server job (WO-16's regime).
* **Seed-vertex deletion after the it-4 commit** was not re-run; after the cull it frees no cheat
  (every kept cheat is necessary), so it is folded into the point shrink above.
* **The 3-bit certificate of the culled set** (R3): unknown at 12 h; the cube front-end is the fix.
* **The copies' partner lattice** (their glue points with the original are the first √5 material a
  composed object would hold — whether THOSE kill classes): a pool build on `it4+206p` (~3,933
  points → ~5.8 M pool points, ~6 h) and one batch's replay. Run only if the plain iteration stalls.
* **The copy kill census after the crossing** (Kooshi's intuition, timed): once χ(unit) reads 5,
  re-run `tools/rank_copies.py` on one batch; prediction — the copy that killed 0 at χ(unit) = 4 kills
  a positive fraction once the unit part's 5-colourings are rigid.

## 6. Registered predictions (to be scored at M53's close)

* **P-M53-1** (Phase 0): the out-of-field pool's kill fraction on one batch is nonzero (low
  confidence; the test is designed to decide, not to confirm).
* **P-M53-2**: the class count per absent cheat from the culled 149 follows the same 1.3–1.5× law
  (medium): the first 8-cheat batch from the culled set lands at 10⁴–10⁵ classes.
* **P-M53-3**: the per-cheat halo cost at iteration 5 is below iteration 4's (119 points for 25) —
  the richer object keeps cutting it (G33), medium; falsifier: a halo above 10 points per cheat.
* **P-M53-4**: the post-commit cull drops ≥ 10 % of the standing set again (G33's redundancy
  accumulation), medium.
* **P-M53-5**: χ(unit) stays 4 at iteration 5 (high); the crossing is not this iteration's.

## 7. The engine, as it stands (2026-09-04)

Binary: `~/source/descent-engine/target/release/descent` (main at `9b2fac2`+; the WO-14 worktree
`~/source/descent-engine-wo14-impl` holds the same binary built at `85fdfdd`). Verbs: `inspect`,
`replay`, `enumerate`, `design`, `cull` (`--groups cheats|vertices`, `--census`, `--standing`,
`--candidates`, `--necessary`, `--phase-a off`, `--conflicts a,b`, `--encoding hard|guarded`).
SPEC v0.11.1 (operation G, the cull journal with `drop`/`holds` rows and `standing_fp`). Open
orders: **WO-16** (licence holding + drain on signal + the clean A/B; D75–D77), WO-15 (the IHS
minimum), WO-3 (the server courier, replan authorized), WO-12 (the loop binary; the cube front-end
for the certify belongs here or in WO-16), WO-9. The phase-boundary protocol: one WO per session,
planning and implementation in separate sessions, one writer per worktree, I merge and push, every
subplan through `REVIEW-METHOD.md`'s adversarial round. Defects filed: D68 (enumerate's CONTRADICTION
on an undecided verification), D77 (census prints INCOMPLETE at a natural end).

## 8. The box, and the rules that bind

Desktop: 16 physical / 32 logical, 125 GB; nothing running at this stub's writing. One heavy
job at a time; 16 threads on memory-tight/wall-capped phases; every phase > 15 min checkpoints and
resumes; first passes wall-capped; unknowns never folded; every headline carries its population and
conditioning (G21); a verdict message names only the branch that fired (G30); planted red seen red
before any instrument's first real run; the server gate (M52 §12) reports savings for the
EFFICIENT implementation only (Kooshi: efficiency in Rust before compute); anything that travels
ships as a ferry bundle. The standing halt clauses: μ ≤ 1 at five colours ⟹ HALT AND VERIFY (one
standing cheat is a two-branch disjunction to verify; ZERO is the theorem); χ(unit) 4 → 5 ⟹ HALT
and certify; a REFUSED certificate ⟹ INVESTIGATE, never retry; any hardware event ⟹ HALT.

## 9. What M52 established that M53 stands on (the evidence, by address)

T13 (the direction ladder), T14 (the field: every point in ℚ(√3, √11)), T15 (the copy lock's
finite form), P5's refutation (copies kill nothing at five colours), G34 (the field is the
selection), the cull as phase 0″ — all in `plans/STANDING-QUESTIONS.md`, `CLAUDE.md` § Frontier (the
M52 paragraph, ledger row 46, § Grokkings), and `plans/M52-copy-lock-objects.md`. The competing
next milestone, if Kooshi ever reverses: `plans/STUB-certify-core883.md`. The theory milestone the
field question earned: `plans/STUB-field-wall.md`.

---

## §B. Decisions settled at subplanning (2026-09-04, before the modeling passes)

*Written after re-reading the whole record: the stub above, `plans/DESCENT-ALGORITHM.md`,
`plans/RISKS.md`, `plans/M51-descent-engine.md` §S-CONT (iteration 4's command chain),
`data/m52/cull-result-it4.json`, the culler's `cull.json`, the enumeration cull's fourteen batch rows,
the engine's `--help` for all five verbs (main rebuilt at `787c821`, 25 s, the cull verb present), and
the tools the chain reads (`batchkill._ctx/_gated_seps/_build_pool/load_pool/certify/run_commit`,
`adopt_rust_list.py`, `adopt_rust_profile.py`, `export_edges.py`, `pool_restrict.py`,
`pool_field_census.py`, `rigidity.class_avoid_binary3`, `forcer._solve`). Every decision in the house
four parts. Names: `L4` = the plain iteration-4 label
`S29-depth2r-it2v2-depth1-it2v2-depth1-vdel28-it2v2-depth1`; `L4c` = `L4 + "-cull149"`, the culled
object minted below; `bare` = `d5b1070e4055d241` (the point set, unchanged by the cull).*

| # | Choice | Alternative weighed | Why this one | Confidence |
|---|---|---|---|---|
| D1 | **The culled object is MINTED as a chain object `L4c`** — same points and provenance, `removed` = the 71 halo-removed ∪ the 124 the cull dropped = 195, `fingerprint = obj.fingerprint(removed)` = `a79347720ccda3ed` (the +cull149 sidecar's `fingerprint_removed`), `fingerprint_bare` unchanged — written by `tools/commit_cull.py` with a `certificate` field naming exactly what has been refuted in which encoding, and a `cull-commit` row in `m50-batch.json`. `export_edges.py L4c` then produces the sidecar (asserted edge-for-edge equal to `build/m51-edges-L4+cull149.json`). | Keep working on `L4` and thread a "dropped" list through every consumer (`_ctx`, the adopters, `run_hitting`, `run_commit`, `certify`'s new-object writer). | A cull IS a removal with no halo — the object's `removed` field is the one place the chain already records removals; the deletion commit (`commit_deletions`) set the precedent for a zero-geometry object variant. Threading a second list would put the same fact in two places and the it-5 commit's object would silently re-add the 124 as edges (iteration 2's under-enumeration incident, §R6, in a new coat). The pool cache is keyed by `bare`, so nothing is rebuilt. | high |
| D2 | **The second encoding gets a cube-and-conquer front-end** (`tools/cube_certify.py`): the SAME 3-bit clause generator (`rigidity.binary3_clauses`, extracted from `class_avoid_binary3` so there is one generator and no drift), a complete case split over the codes of the `m` highest-unit-degree vertices (vertex 0 stays pinned to code 0 as the generator does), every cube a separate cadical run in parallel, a cube undecided at its cap SPLIT into five children (adaptive), an unknown at the depth cap reported as unknown with the cube named; UNSAT of every cube = UNSAT (a complete partition of the cube variables' assignments; sound over a symmetry-broken formula too, since the cubes partition colour VALUES). Per-cube verdicts checkpointed (`cubes.jsonl`), resumable. Used first on the culled set's 3-bit (R3's open item, 43,200 s unknown monolithic) with the culled set's ONE-HOT as the positive control (monolithic UNSAT 10,640 s known), then as the it-5 commit's 3-bit (`CERTIFY_REENCODE=cube`). | (a) WO-12 in the engine (the certify port, Rust); (b) a longer monolithic cap (days). | The lever is algorithmic — case-splitting where clause learning does not find the factoring (G18, measured at M34: cubes 800 s where the monolith capped at 3,600 s) — and the work is inside cadical; the driver is 150 lines of orchestration, which is not the phase Kooshi's efficiency rule is about. The engine port stays the loop binary's item; this milestone needs the verdict in days. Alternative (b) is exactly "throwing compute at it". | high for soundness (a partition argument the M05 cover theorem already states); medium for cost — P-M53-6 registers it |
| D3 | **Phase 0's test is the SHARP one**: on one batch `B₀`, replay ALL classes on the IN-FIELD pool (fast: 15 % of the pool) → `K_in / S_in / U_in`; replay only `S_in ∪ U_in` on the FULL pool (`--rows`) → the number is `|{c ∈ S_in : full = killed}|` — classes PROVABLY beyond in-field material (a survive is a proof) and provably within the full pool's; the out-of-field-only replay of the same residual is the diagnostic (`K_out ∖ K_in`). Zero with no unknowns on either side = Kooshi's first horn exactly (no kill on this batch needs an out-of-field point); nonzero = the second; unknowns leave it undecided and the headline says so. | The stub's form: replay the batch on the out-of-field pool alone and read its kill mass. | A class killed by the out-of-field pool may also be killed by the in-field pool — that measures nothing about NEED; and `K_out = ∅` does not give `K_full = K_in` (in- and out-of-field points can cooperate). The sharp form asks the full pool only about the in-field residual, which is the cheap direction (kills are monotone: `K_in ⊆ K_full`). | high |
| D4 | **The batch is chosen from the SINGLE-CHEAT SPECTRUM**: every standing cheat of `L4c` enumerated ALONE (`descent enumerate --floor u-v`, capped at 50,000 classes), giving `|S_e|` or "≥ cap" per cheat; the it-5 batch is the cheapest cheats whose FRESH joint enumeration lands at the scale the later phases are priced for (it-4 paid 37,316), with `tools/subbatch.py`'s put-back curve read from the joint list as at it-4. The spectrum doubles as (i) the culled object's floor census by a SECOND instrument (R3: a witnessed cheat must show ≥ 1 class, and the culler's witness must appear among its classes up to palette), and (ii) the re-ask of the 46 undecided cheats by a different method (an EXACT 0-class single enumeration = redundant alone, decided by cubes where the monolithic 30 M-conflict probe was not — G18 again); an exact-0 cheat joins the batch for free (no class of any batch can be hit only by it). | Enumerate the whole standing set as the floor (the it-4 shape: full floor, then the curve). | The standing set is 149; a 149-absent enumeration is astronomically large (the law: ×1.1–1.5 per absent cheat from 46,350 at 10). The enumeration cull measured 4-cheat batches on THIS object at 0 … 307,716 classes — the per-cheat variance is the whole story, so the single-cheat counts are the ranking column the batch needs, and they cost 149 small runs (15,218 classes ran in 169 s). | medium — P-M53-2 registers the spectrum's shape; F1 covers the case where even the cheapest cheats are wide |
| D5 | **The full depth-1 pool is built once** (`batchkill --pool-only --object L4c`, keyed by `bare`), then two restricted exports by EXACT radicand class (`tools/pool_field_restrict.py`: in-field = the parent pair's `4/d² − 1` is a K-square, verified by squaring in K; out-of-field = its complement), each a `pool_restrict`-shaped export with its own fingerprint and `derived_from`. Phase 0′ then names the profile/design pool: `depth1-infield` if the census reads zero, `depth1` otherwise. | Build only the in-field pool directly (pairs filtered before the glue step; ~6× cheaper). | Phase 0's test needs the full pool for its residual re-ask, and the build is one ~2 h pass that every later choice consumes. The direct in-field build is the RIGHT build for iteration 6+ once the restriction is in force (the loop binary's pool port, phase 2 of its table) — noted, not built here. | high |
| D6 | **The pool build stays the one un-checkpointed phase** (a single vectorized pass, ~1.5–2 h at 1,981 points, no acceptance points; a relaunch redoes it). | Add a partial-save of the glue step. | The rule's audit question ("what does a relaunch redo?") is answered: the whole pass, ~2 h, once; the engine's pool port (already the loop binary's first item) is where checkpointing belongs. Accepted at it-4 for 5,523 s. | high |
| D7 | **The profile and design run on the pool phase 0′ names, with the profile's tiers as at it-4**: bulk at the pre-flight's worker count; the tail (complete-solver classes) on a restricted pool first — `pdeg12`'s criterion over the chosen pool (an acknowledged pool choice, kills transfer) — then survivors/unknowns on the named pool, wall-capped first passes, `adopt_rust_profile.py --merge-tail … --merge-full …`, unknowns never folded. | Full pool, tail included, in one pass. | It-4 measured 3.1× on the tail with identical verdicts and the narrowing to 12 workers by memory; the in-field pool (~280 k points) removes the memory narrowing outright (P-M53-8). | high |
| D8 | **Every instrument this milestone adds ships with a planted red seen red before its first real run** (§2 names each), and every headline carries its population and conditioning in the sentence (G21). | — | The standing rule; a default, not a decision. | — |
| D9 | **The server gate** (M52 §12) reports at two phases: the full-pool profile tail and the design's whole-pool pass — the rate measured on the desktop, extrapolated to two server nodes with 1.5 TB (memory removes the worker cap: at ~9.3 GiB per full-pool complete solver, ~150 workers fit against 12 here), savings stated for the EFFICIENT implementation only (the in-field pool if 0′ chose it). | — | Kooshi's standing instruction. | — |
| D10 | **The post-commit cull** runs on the new object with `descent cull --groups cheats` (main's binary; the carried 46 undecided are candidates like every other standing cheat), WITHOUT waiting for WO-16. | Run WO-16 first. | WO-16 tunes the drop phase's wall clock; the cull's soundness and its per-commit value (G33) do not depend on it. It runs when the campaign's critical path is elsewhere. | high |
| D11 | **Kernel-free milestone.** The lattice-closure lemma (the glue point of two K-points has coordinates in K adjoined ONE root of `4/d² − 1` up to a K-square — the theorem phase 0's classification rests on) stays with `plans/STUB-field-wall.md` (R5). | Land the lemma here as phase 0k. | No K-membership predicate exists in the kernel yet (grep: `Glue.lean`, `Compulsion.lean`, `Ladder.lean` work in explicit ⟨re, im⟩ coordinates with √3/√11/√33 as constants); minting one is R5's first design decision and deserves its own modeling pass rather than a side room here. The census's classification is exact tools-side (squaring in K) and states its own scope. | medium — if the field-wall milestone is next, its stub gains this as row 1 |

## §0. Registered predictions (sharpened at subplanning; §6 above is the stub's form)

* **P-M53-1** (phase 0, the decisive one): `|{c ∈ S_in : full = killed}| > 0` on `B₀` — some class provably needs an out-of-field point. **Low** confidence, deliberately: the test is designed to decide (G30). Falsifier: 0 with `U_in = ∅` and no full-pool unknowns among `S_in`.
* **P-M53-2** (the spectrum): over the 149 standing cheats, the median single-cheat class count is ≤ 5,000 and at least 85 % are exact under the 50,000 cap; the cheapest 8 cheats jointly enumerate fresh at 10³–3·10⁴ classes. **Medium.** Falsifier: median > 20,000 or < 60 % exact.
* **P-M53-3** (the halo): points per removed cheat at the it-5 commit < 10 (it-4: 119/25 = 4.8). **Medium.** Falsifier: > 10.
* **P-M53-4** (the cull): the post-commit cull drops ≥ 10 % of the new object's standing set. **Medium.**
* **P-M53-5** (the crossing): χ(unit) stays 4. **High.**
* **P-M53-6** (D2): the cube front-end refutes the culled set's 3-bit within 6 h wall on 32 threads, and its cubed one-hot runs in under the monolithic 10,640 s. **Medium / medium-low.** Falsifier: unknown cubes at the depth cap.
* **P-M53-7** (D4 ii): at least 5 of the 46 undecided cheats are EXACT-0 under the single enumeration (redundant alone, decided by cubes). **Low-medium.**
* **P-M53-8** (D7): on the in-field pool the profile's pre-flight admits ≥ 24 workers (full pool: 12 at it-4). **High** if 0′ chooses it; moot otherwise.

## §1. Phases — the skeleton (every command as the chain will run it; each phase's acceptance, checkpoint and cost stated; one heavy job at a time)

**Phase A — mint the culled object and the certificate front-end (hours; box: light, then heavy).**
A1. `python3 tools/commit_cull.py --object L4 --cull data/m52/cull-result-it4.json --new-label L4c` → `build/m50-object-L4c.json` (removed 195, fingerprint `a79347720ccda3ed`, bare `d5b1070e4055d241`, `certificate: {onehot: adopted from data/m52/final-certify-149.json by standing-set sha, reencode: pending}`), the `cull-commit` row, the snapshot `data/m51/m50-object-L4c.json`; `python3 tools/export_edges.py L4c` → `build/m51-edges-L4c.json`, asserted equal in `unit_edges`, `cheats`, `removed` (as sets) to `build/m51-edges-L4+cull149.json`. Acceptance: `load_object(L4c)` round-trips; `descent inspect` on the sidecar + object agrees. Cost: minutes.
A2. `python3 tools/cube_certify.py --self-test` (§2 item 2, red seen red), then the culled set, one-hot first (the calibration; `--encoding onehot --object L4c --split 4 --cube-cap 600 --max-depth 9 --workers 32 --out build/m53-cube/L4c-onehot`), then the 3-bit (`--encoding binary3 …-binary3`). Checkpoint: `cubes.jsonl` per verdict; resume = the same command. Result: `data/m53/cube-certify-L4c-{onehot,binary3}.json`; the object's `certificate.reencode` updated by `commit_cull.py --attach`. Acceptance: one-hot UNSAT (must agree with the monolithic), 3-bit UNSAT or an honest UNKNOWN with the open cubes named (F3). Cost: registered by P-M53-6. **Runs after phase B** (B is on every later phase's critical path; A2 is R3's).

**Phase B — the single-cheat spectrum (hours; heavy).**
`python3 tools/spectrum.py --object L4c --edges build/m51-edges-L4c.json --witnesses build/m52-rustcull-it4/cull.jsonl --floor data/m51/m51-floor-it5-verdicts.jsonl --jobs 8 --threads 4 --max-classes 50000 --conflicts 1000000 --out build/m53-spectrum/L4c` — per standing cheat `u-v`: `descent enumerate --edges … --out build/m53-spectrum/L4c/u-v --floor u-v --threads 4 --max-classes 50000 --conflicts 1000000 --no-color`; the driver skips a cheat whose `enumerate.json` already claims exact or capped (resume), records `{cheat, classes, claim, open_leaves, seconds}`, cross-checks the culler's witness for that cheat against the class list (seed projection, up to palette — `rank_copies.load`'s canonicalization), and writes `data/m53/spectrum-L4c.json` + the adopted `recurse-census` row for `L4c` (`essential_alone` = every cheat with ≥ 1 class or capped; `droppable_alone` = exact 0; `unknown` = wall-capped/open). Acceptance: all 103 witnessed cheats ≥ 1 class with the witness found; the 27 floor cheats ≥ 1 class; P-M53-2 and P-M53-7 scored. Cost: 149 runs; the cheap majority in seconds–minutes each at 4 threads, 8 in parallel; the capped tail ≤ 149 × (50,000 classes ≈ 10 min) worst case — expected 2–6 h.

**Phase C — the pool (≈ 2 h; memory-heavy, one process).**
`python3 tools/batchkill.py --pool-only --object L4c` → `build/m51-pool-d5b1070e4055d241-depth1.{json,npz}`; then `python3 tools/pool_field_restrict.py --object L4c --base build/m51-pool-d5b1070e4055d241-depth1` → `…-depth1-infield` and `…-depth1-outfield` (§2 item 3: the self-test's counts against `data/m52/poolfield-L4.json`: 140,195 in-field pairs → ≤ 280,390 points after dedupe/exclusion; planted red seen red). Acceptance: `load_pool(obj, "depth1-infield")` loads (fingerprint re-derived); in + out = full (as index sets). Not checkpointed (D6).

**Phase D — the out-of-field kill census (RISKS R1's test; a day; heavy).**
D1. `B₀` = the cheapest 8 spectrum cheats (or fewer, to land ≤ 20,000 classes fresh): `descent enumerate --edges build/m51-edges-L4c.json --out build/m53-p0/enum --floor <B₀> --threads 8 --max-classes 200000 --conflicts 1000000 --no-color`; the fresh count vs the spectrum's prediction (a joint count is at most the sum of singles, at least their max) recorded. `python3 tools/adopt_rust_list.py --object L4c --list build/m53-p0/enum/classes.jsonl --report build/m53-p0/enum/report.txt` is NOT run for `B₀` unless `B₀` becomes the it-5 batch (phase E) — the census reads the engine's list directly.
D2. `descent replay --manifest build/m51-pool-d5b1070e4055d241-depth1-infield.json --edges build/m51-edges-L4c.json --object build/m50-object-L4c.json --classes build/m53-p0/enum/classes.jsonl --threads 16 --conflicts 2000000 --wall 900s --out build/m53-p0/replay-infield --no-color` → `K_in / S_in / U_in`.
D3. residual rows file = indices of `S_in ∪ U_in` → `descent replay --manifest …-depth1.json … --rows build/m53-p0/residual-rows.txt --threads <pre-flight> --wall 1800s --out build/m53-p0/replay-full`; and the diagnostic `--manifest …-depth1-outfield.json … --out build/m53-p0/replay-outfield` on the same rows.
D4. `python3 tools/outfield_census.py --infield build/m53-p0/replay-infield --full build/m53-p0/replay-full --outfield build/m53-p0/replay-outfield --classes build/m53-p0/enum/classes.jsonl --out data/m53/outfield-census-L4c.json` — the headline: "on batch B₀ (N classes) of L4c, in-field pool P_in (n_in points) vs full pool P (n points): |S_in| survive in-field, of which X are killed on the full pool, Y survive the full pool too, Z unknown; out-of-field alone kills W of the residual; conditioning: caps c_in/c_full, wall w". Decision 0′ recorded in this file and in §R. Cost: D2 minutes–an hour; D3 the residual only — if `S_in` is a few hundred classes, hours; if thousands, the server gate row fires (D9).

**Phase E — iteration 5 (days; heavy).**
E1. The batch: from the spectrum, the cheapest cheats (exact-0 ones included free) whose fresh joint enumeration lands at 10⁴–4·10⁴ classes; grown incrementally (add the next-cheapest, enumerate fresh, stop before the price); `tools/subbatch.py --list <joint> --floor <batch>` for the put-back curve if the last step overshoots. Every cheat spent is in the adopted census row's `essential_alone` (D4). `adopt_rust_list.py` → `build/m50-S-L4c-it2v2.jsonl` + the `enumeration` row.
E2. Profile on the pool 0′ named: `descent replay --manifest <pool> --edges … --object … --classes build/m50-S-L4c-it2v2.jsonl --threads <pre-flight> --conflicts 2000000 --wall 900s --out build/m53-profile-it5-<pool>`; the tail on the pool's `pdeg12` restriction (`python3 tools/pool_restrict.py <base> L4c pdeg12 'nobj>=3|pdeg>=12'`) first, then `--reask-unknown`/`--rows` on the named pool; `python3 tools/adopt_rust_profile.py --object L4c --out <main> --pool <name> --merge-tail … --merge-full …`. Server gate row 1 here.
E3. `python3 tools/batchkill.py --hitting --deepest L4c-it2v2-<pool> --object L4c` → keep/commit; `python3 tools/export_sublist.py L4c L4c-it2v2` → `build/m51-Scommit-L4c-it2v2.jsonl`.
E4. `descent design --manifest <pool> --edges … --object … --classes build/m51-Scommit-L4c-it2v2.jsonl --out build/m53-design-it5-rust --ladder-cap 50000 --threads 26 --trial-order size` (whole-pool pass ON; resumable; on exit read `design.json`: `commit_ready` true AND verification `undecided` 0 — trust no headline). Server gate row 2 here. Then `cp build/m53-design-it5-rust/halo.json build/m50-cover-L4c-it2v2-<pool>.json`.
E5. `CERTIFY_ONEHOT_CAP=43200 CERTIFY_REENCODE=cube python3 -u tools/batchkill.py --commit --pool <pool> --object L4c` — the triple (checkpointed lookup re-check; one-hot; the cubed 3-bit; exact geometry lazily); REFUSED ⟹ INVESTIGATE, never retry; committed ⟹ `build/m50-object-L4c-it2v2-<pool>.json`.

**Phase F — the columns, the cull, the records (a day; heavy for the cull).**
`python3 tools/m50_skewscan.py --unitchi <new label>` (4 → 5 ⟹ HALT and certify); `python3 tools/field_census.py <new label>`; `python3 tools/pool_field_census.py --object <new label>` (needs the exact coordinates: `tools/copy_exact_field.py`'s writer re-run on the new object); `--scan`; `python3 tools/export_edges.py <new label>` then `descent cull --edges build/m51-edges-<new>.json --object build/m50-object-<new>.json --groups cheats --threads 12 --conflicts 3000000,30000000 --out build/m53-cull-<new>` (the per-commit cull; P-M53-4); `descentviz_refresh.py --object <new> --dropped <the cull's dropped>` → `descentviz_artifact.py` → the Artifact republish; snapshots to `data/m51/` (object) and `data/m53/` (every result file); `DESCENT-ALGORITHM.md`'s state table; `RISKS.md` re-read row by row; `CLAUDE.md` § Frontier; the report.

## §2. Instruments to build (each with its self-test and planted red, seen red before the first real run)

1. **`tools/commit_cull.py`** — D1. Reads the plain object + the cull result; removed = plain removed ∪ dropped (asserts |dropped| = 124, no overlap, every dropped cheat live); writes the object with `certificate`; `--attach` updates `certificate.reencode` from a cube result. Red: a tampered dropped list (one cheat added) must yield a fingerprint ≠ the sidecar's `fingerprint_removed` and be refused.
2. **`tools/cube_certify.py`** + **`rigidity.binary3_clauses`** — D2. Self-test: K₆ at five colours UNSAT through cubes on 3 vertices (all 125 cubes refuted, count asserted); a 5-colourable graph SAT with the model VALIDATED (proper, codes < 5, the pin); agreement with the monolithic on ten random small graphs; the split invariant (a split replaces one cube by exactly five children with distinct pins on a fresh vertex; the issued cubes at any moment partition the assignments — asserted by a counter); the planted red on the real object: `--drop <a floor cheat>` must return SAT (a separating colouring exists by the floor census) and the driver must print REFUSED with the colouring validated.
3. **`tools/pool_field_restrict.py`** — D5. Classification exact (K arithmetic from `data/m52/exact-L4.json`; class 1 = a K-square found by PSLQ and VERIFIED by squaring); self-test against `poolfield-L4.json`'s pair counts; red: a pair in the √5 class forced into the in-field set must be refused by the re-verification pass.
4. **`tools/spectrum.py`** — D4. The driver, the witness cross-check, the census-row adoption. Red: a culler witness with one digit changed must NOT be found among its cheat's classes (the check must fail loudly on the plant and pass on the real witness).
5. **`tools/outfield_census.py`** — D3. The join of three checkpoints on class index with the headline sentence. Red: synthetic checkpoints where a class is `killed` in-field and `survives` on the full pool must be refused (monotonicity violated = an instrument fault, never a finding).
6. **`batchkill.certify`** — `CERTIFY_REENCODE=cube` routes the 3-bit through item 2 (default unchanged). Red: the existing `commit_controls` regression plus the cube driver's own plant.
7. `adopt_rust_profile.py` — accepts `--pool depth1-infield` (no code change expected: `load_pool` by name); verified by running it.

## §3. Failure clauses (registered before any instrument runs)

* **F1 — the tightrope fails at the spectrum.** If the cheapest 8 cheats jointly exceed 10⁵ classes fresh, the batch shrinks to what fits (down to 1 cheat); a single cheat above 2·10⁵ classes with no cheaper cheat left is an ENGINEERING WALL: the milestone reports it with the spectrum as the measurement, and the server gate row prices the profile at that width. Not silently rescoped.
* **F2 — P-M53-1 reads NONZERO.** The pool stays full for it-5; the design gains a field-aware tier as an engine WO stub (out-of-field candidates offered by class); R1's status updated to "the tiers hide them".
* **F3 — the cube front-end leaves the culled 3-bit UNKNOWN at the depth cap.** The culled object stays a CANDIDATE on one encoding (R3), it-5 proceeds from it (the final object's certificate is the claim; the chain's intermediate is flagged in the object's `certificate` field and in R3), and the open cubes are the server's first job.
* **F4 — a REFUSED commit** ⟹ INVESTIGATE (which phase's verdict the design trusted wrongly), never retry.
* **F5 — any hardware event** ⟹ HALT and report.
* The standing halt clauses: μ ≤ 1 ⟹ HALT AND VERIFY; χ(unit) 4 → 5 ⟹ HALT and certify the witness.

## §4. Cost table (desktop anchors; every number names its population)

| phase | anchor (it-4 / M52) | expected here |
|---|---|---|
| A1 mint + sidecar | — | minutes |
| A2 cubed one-hot / 3-bit of the culled set | monolithic one-hot 10,640 s; 3-bit unknown at 43,200 s | ≤ 3 h / ≤ 6 h at 32 threads (P-M53-6) |
| B spectrum (149 single enumerations) | 15,218 classes in 169 s at 8 threads (12-cheat batch, un-culled) | 2–6 h at 8 jobs × 4 threads |
| C pool build + two restrictions | 5,523 s at 1,862 pts (1.47 M points) | ~2 h + minutes |
| D census (in-field replay + residual full + residual out) | 26,857 classes in 1.5 h at 12 workers; tail 100–1,800 s/class | in-field: ≤ 1 h; residual: hours (server row if `S_in` > ~1,000) |
| E1 batch enumeration (fresh, ≤ 4·10⁴) | 37,316 in ~45 min of restarts | ≤ 1 h |
| E2 profile | 1.5 h bulk + a day's tail on the full pool (12 workers) | in-field: hours; full: a day (server row 1) |
| E4 design + shrink | it-4: 119-point halo; it-3 shrink ~7 h laptop | hours to a day (server row 2) |
| E5 commit | it-4 3-bit 8,228 s | one-hot hours; cubed 3-bit hours |
| F cull | 2 min/drop at 12 workers (WO-14) | hours to a day |

## §5. Discipline (the rules this milestone runs under, restated once)

One heavy job at a time (A2 waits for B; C after B; D after C; E after D). Threads: 16 on wall-capped/memory-tight phases, the pre-flight's number on the full pool, 8×4 on the spectrum. Every phase > 15 min resumes exactly (the engine's journals and checkpoints; the spectrum's per-cheat directories; the cube driver's `cubes.jsonl`; the commit's lookup checkpoint) — the pool build excepted by D6. Long runs launched from snapshot copies of any script, PIDs recorded in `build/m53-jobs.txt`, waiters by PID never by `pgrep -f`. Unknowns never folded; verdict messages name only the branch that fired; every headline carries its population and its caps. Nothing is written to `data/m53/` that is not reproducible from a `build/` artifact by a named command.

## §Bʹ. The domain-modeling pass (2026-09-04, fresh invocation) — what it changed

*The five objects the pass was aimed at, each run until its shape stopped looking chosen.*

**1. `removed` is a SET of cheats, and the reason a cheat left is the ledger's, not the object's.**
Three moves take a cheat off the dial — a certified halo, a vertex deletion (the cheat dies with its
vertex), a cull (jointly redundant, no geometry) — and the object's forcing claim depends on none of
them: it depends only on `unit ∪ standing`, with `standing = cheats ∖ removed` over live vertices. So
`removed` means "not standing, and a certificate covered its absence", the union over all three moves;
the +cull149 sidecar already used it that way (71 + 124). The RECORD of which move and which
certificate lives in the `m50-batch.json` rows (`batch-commit`, `deletion-commit`, and now
`cull-commit`), exactly as the two existing moves do. One invariant is kept strict rather than
weakened: **an object file exists only for a committed object (both encodings UNSAT)**. Consequence
for the schedule: the cube front-end runs on `L4` plus the dropped list BEFORE `L4c` is minted (A2
precedes A1; the spectrum needs only the sidecar, which exists as `+cull149`), and under F3 (3-bit
unknown at the depth cap) the file is minted with an explicit top-level `"candidate": {reencode:
"unknown", open_cubes: N, …}` marker and the `cull-commit` row says candidate — a named exception,
never a silent one, because the campaign continues on the object either way.

**2. The single-cheat spectrum's verdict is three-valued, and each value names its evidence.** For a
standing cheat `e`, `S_e` (the classes with `e` absent) decides: `necessary` ⟺ ≥ 1 class was written
(the class IS the witness, whether or not the run finished — a capped run's lines are all right);
`droppable-alone` ⟺ the run is EXACT with 0 classes (the enumerator's V3 refuted every leaf — an
UNSAT by cubes where the culler's monolithic probe was undecided, G18's shape); `unknown` ⟺ 0 classes
and open cubes (wall or budget). The adopted `recurse-census` row carries all three lists (the old row
carried `essential_alone` and a count of unknowns). The sub-batch assertion in `adopt_rust_list.py`
(`F ⊆ essential_alone`) exists to refuse spending an edge the census never examined; with the spectrum
examining EVERY standing cheat its honest form is `F ⊆ examined = necessary ∪ droppable ∪ unknown`
— an unknown cheat is spendable (sound: spending a cheat can only add classes), a droppable-alone one
rides free (no class of any batch is hit only by it). The adopter is widened to that, with the reason
in its docstring. The cross-instrument check is stated as the consequence it is: the culler's witness
for `e` is proper on `unit ∪ standing ∖ {e}` and separates the pair, so its palette class is in `S_e`
by the enumerator's completeness — a witness NOT found among the classes (or an exact-0 run for a
witnessed cheat) is an instrument contradiction and the driver refuses loudly; that refusal is the
planted red (a witness with one digit changed).

**3. The field split of the pool is a partition of POINTS, and the census's number has an exact
scope.** A glue point of two K-points `x, y` at distance `d` is `m ± v·√r` with `m = (x+y)/2 ∈ K²`,
`v = i(y−x)/2 ∈ K² ∖ {0}`, `r = 4/d² − 1 ∈ K`; if `√r ∉ K` the point is not in `K²` (else
`√r = (p − m)/v ∈ K`), and if `√r ∈ K` it is. So a pool point's field membership is a property of the
point, not of which parent pair the dedupe happened to record: an in-field pair and an out-of-field
pair can never produce the same point, and classifying by the recorded parents is well-defined.
(This is the lattice-closure lemma's corollary, two lines; it stays tools-side by D11.) The census's
populations, stated once and carried into the headline: `S_in` = classes that PROVABLY extend to the
in-field pool; the number = `|{c ∈ S_in : killed on the full pool}|`; `K_out ∩ S_in` the diagnostic;
unknowns on either side listed, never folded. The monotonicity that orders the verdicts (`killed` is
an up-set in pools, `survives` a down-set) is enforced as a REFUSAL in the census reader — a class
killed in-field and surviving on the full pool is an instrument fault, never a finding. The
classification's one soft edge is named in the scope sentence: "in-field" = a K-square found by PSLQ
and verified by squaring; a K-square PSLQ failed to find would be filed out-of-field, which biases the
census toward the SECOND horn (a class then reads "survives in-field" on a pool missing a point it
could have had) — so the restrict tool decides squareness in K EXACTLY (the tower criterion, §Bʺ.4 — this pass's
two-precision check was superseded by the obligation pass the same afternoon) and keeps PSLQ as the
cross-check that must agree on every radicand.

**4. The cube tree is a prefix tree over ONE global split order, and its invariant is a cover of
models.** Cube variables = the codes of the vertices in the object's unit-degree order (for the one-hot
this IS the palette breaking's order, so the early cubes are mostly refuted by the breaking in
milliseconds and the effective branching is far below 5^d; for the 3-bit every code is live and the
tree is 5-ary). A cube at depth `d` pins the first `d` vertices; a split replaces a cube by its five
extensions on vertex `d+1`. The invariant the verdict rests on: **the open and closed leaves together
cover every model of F** (for each pinned vertex, "code ∈ {0..4}" is implied by F — by the one-hot's
at-least-one clauses, by the 3-bit's per-vertex ban of codes 5–7 — so the five children of any cube
cover everything the parent covered). UNSAT ⟺ every leaf is refuted; a SAT leaf's model is validated
against the object (proper, codes < 5, the pin) and is a REFUSAL; a leaf undecided at the depth cap
leaves the verdict UNKNOWN with the open cubes named. Sound over the symmetry-broken one-hot for the
same reason (the cubes cover the models of `F ∧ brk`, and `F ∧ brk` UNSAT ⟹ F UNSAT is the breaking's
own soundness, already trusted by every certify). Improper cubes (adjacent pinned vertices sharing a
code) are RUN, not pruned — cadical refutes them by one clause and the journal stays a complete
account. Resume: the frontier is recomputed from the journal (a `split` row opens five children; an
`unsat`/`sat` row closes a leaf), so the same command continues.

**5. A restricted pool is a NAMED pool of the object, fingerprinted under the name it is saved as.**
`pool_restrict.py` (it-4) computes its fingerprint with the short name (`pdeg12`) and saves under
`…-depth1-pdeg12`, so `load_pool(obj, "depth1-pdeg12")` refuses it — its exports were consumable by
the engine (`--manifest`) only, never by the Python design/commit. The in-field pool must be THE pool
under 0′ (design, lookup re-check, commit all load it by name), so `pool_field_restrict.py` saves
`depth1-infield` / `depth1-outfield` with the fingerprint computed under exactly those names and
`params = {"restrict": "field=in|out", "dps": …}`; `load_pool` then accepts them unchanged, and
`certify`'s `pool.prov[p]` (parents are object indices) stays valid. The quirk in `pool_restrict.py`
is noted for the next hygiene pass, not fixed here (its exports are still right for the engine).

**6. The schedule the model implies.** B (the spectrum, on the `+cull149` sidecar) → A2 (the cube
front-end on `L4` + dropped: one-hot control, then 3-bit) → A1 (mint `L4c`, sidecar, census row) →
C → D → E → F. §1's phase text is read with this order; the commands are unchanged.

*Unsampled members walked:* a standing cheat at a deleted vertex (impossible — the sidecar's
`cheats` are live by construction, and the driver reads standing from it); a cheat both dropped and
spent (refused by set arithmetic at `commit_cull.py`'s boundary); an exact-0 spectrum run for a
witnessed cheat (the contradiction case above, refused); a pool point whose two possible parent
pairs straddle the field (impossible, item 3); a cube tree with a split whose children were only
partly issued at a kill (the journal's `split` row is written BEFORE any child is issued, so a resume
re-issues all five).

## §Bʺ. The obligation-modeling pass (2026-09-04, fresh invocation) — each instrument's invariant as a two-line argument, and the prove / test / assume partition

**1. The cube front-end.** Let `F` be the formula (one-hot with breaking, or 3-bit with the vertex-0
pin) and `v₁, v₂, …` the split order. A cube is a prefix pin `π : {v₁..v_d} → {0..4}`.
*Invariant I (the cover):* every model `μ` of `F` is consistent with some leaf. *Proof, by induction on
splits:* the root pins nothing; a split replaces a leaf `ℓ` by `ℓ ∪ {v ↦ c}` for all five `c`, and a
model consistent with `ℓ` has `μ(v) ∈ {0..4}` because `F` implies it (one-hot: the at-least-one clause
at `v`; 3-bit: the ban of codes 5–7 at `v`), so `μ` is consistent with the child `c = μ(v)`.
*Verdict:* UNSAT ⟸ every leaf refuted (a model would be consistent with some leaf `ℓ` and satisfy
`F ∧ pins(ℓ)`, contradicting `ℓ`'s refutation); SAT ⟸ a leaf's model VALIDATED against the object
directly (proper on every edge, codes < 5, the pair separated) — a verdict independent of the cube
machinery; UNKNOWN ⟸ an open leaf at the depth cap, named. Over the symmetry-broken one-hot the same
argument covers the models of `F ∧ brk`, and `F ∧ brk` UNSAT ⟹ `F` UNSAT is the breaking's own
soundness, trusted by every certify since M06. *Termination:* a leaf is asked once; undecided at depth
`< D` it splits (depth strictly increases), at depth `D` it is recorded open; asks ≤ (5^{D+1} − 1)/4.
*Resume:* the frontier is a function of the journal (splits open five children, `unsat`/`sat` close a
leaf; the `split` row precedes any child's issue). — **Prove** (a docstring argument; the kernel form
is M05's cover theorem for the certificate route): I and the verdict. **Test:** K₆ at five colours
through cubes on 3 vertices — 125 leaves, all refuted, the leaf set asserted equal to the 125
assignments (I made visible); a 5-colourable graph — SAT with the model validated; ten random small
graphs — cube verdict = monolithic verdict; a journal truncated after a `split` row resumes by
issuing exactly its five children; the planted red on the real object — `--drop <one of the 27 floor
cheats>` must return SAT (the floor census's own `sat` says a separating colouring exists) and the
driver prints REFUSED with the colouring validated. **Assume:** cadical's refutations (the chain's
standing assumption; the kernel LRAT route is the final object's certificate, out of scope here).

**2. The spectrum's verdict.** For a standing cheat `e`, `G_e = unit ∪ (T ∖ {e})` and `S_e` its
separating classes. *necessary(e)* ⟸ one written line, re-validated in Python: proper on `G_e`,
`A ≠ B`, AND monochromatic on `e` — the third is a consequence (a line proper on `e` too would be a
separating colouring of the whole object, which the certificate refutes), so it is a free control on
the certificate and a refusal if it fails. *droppable-alone(e)* ⟸ `claim exact ∧ 0 lines`: the
enumerator's V3 observed a refutation of every leaf on a fresh solver — `G_e ∪ {A ≠ B}` UNSAT by
cubes. *unknown(e)* otherwise (0 lines, open leaves). *Witness transfer (two lines):* the culler's
witness for `e` was found against a standing set `T′ ⊇ T` (drops only shrink it), and a colouring
proper on `unit ∪ (T′ ∖ {e})` is proper on `unit ∪ (T ∖ {e})`; so it is a separating colouring of
`G_e`, and for an EXACT run its palette class is among the lines by completeness. A witness colouring
identifies its own cheat: the set of standing cheats it violates must be exactly one (the driver
derives the cheat from the colouring and refuses if the journal's group index disagrees). *The
contradiction that must refuse:* a witnessed cheat with an exact-0 run, or an exact run not
containing the witness's class — an instrument fault in one of the two engines, never a finding. —
**Prove:** transfer; the verdict function given V1–V3. **Test:** the reds — a witness with one digit
changed fails validation and is refused; the enumerator's own regression first (the M52 enum-rank
batch on the un-culled sidecar must reproduce 15,218 classes exactly — same instrument, same input,
before 149 fresh runs); the 27 floor cheats must all read ≥ 1 line (their `sat` rows carry no
colouring, so containment is not checkable for them — stated). **Assume:** the engine's V1–V3
(self-verification on an independent code path, WO-6/WO-11's evidence).

**3. The out-of-field census.** Pools `P_in, P_out ⊆ P`, disjoint, `P_in ∪ P_out = P`; verdicts
`v_Q(c) ∈ {killed, survives, unknown}`. *Monotonicity (two lines):* an extension of `c` over `Q′ ⊇ Q`
restricts to one over `Q`, so `killed(Q) ⟹ killed(Q′)` and `survives(Q′) ⟹ survives(Q)`. *The join
table over `(v_in, v_full)`:* `(killed, survives)` IMPOSSIBLE — refuse; `(survives, killed)` = the
census number; `(survives, survives)` = beyond depth 1 entirely; `(unknown, killed)` = undecided for
the test (more in-field budget might kill it); `(unknown, survives)` ⟹ `survives_in` DERIVED (labelled
derived, never asked); `(survives, unknown)` = undecided. With `P_out` on the same residual, the
number splits into `out-alone` (`killed_out`), and `cooperative` (`survives_out ∧ killed_full` — neither
slice kills it, together they do; a third category the stub's form could not see). *Meaningful joins:*
by class index over the SAME class list (the three checkpoints' headers must name the same class count
and the census reader checks the list's sha256 and that both restricted manifests carry
`derived_from` the full export). — **Prove:** monotonicity. **Test:** synthetic checkpoints covering
every cell of the table, the refusal on the impossible cell, the derived label. **Assume:** the
replay's verdict semantics (WO-2: verdict-exact against 45,365 reference lines).

**4. The restricted pool by field.** *Soundness for every phase (one line):* the profile's kills on
`P_in` transfer to `P` (item 3), its survivals are conservative for the hitting set (kept); a halo
`⊆ P_in` is a halo `⊆ P` and the commit certifies the true object — so the restriction costs only
dial progress, never soundness, which is what the monitor measures. *The classification, made exact
in BOTH directions (this pass's change to D5/§Bʹ.3):* `r ∈ K` is a square iff a root exists in `K`, and
that is decided by the tower recursion — in `F(√m)`, `x = a + b√m` is a square iff `b = 0` and (`a` or
`m·a`) is a square in `F`, or `b ≠ 0` and `a² − m·b² = n²` for some `n ∈ F` with `(a + n)/2` or
`(a − n)/2` a square in `F` (then `p = √((a ± n)/2)`, `q = b/(2p)`, `x = (p + q√m)²`); the base
`F = ℚ` is decided by integer square roots of numerator and denominator. ONE function on the tower
`ℚ ⊂ ℚ(√3) ⊂ K`, returning the root, so "in-field" = a root found and VERIFIED by squaring, and
"out-of-field" = the criterion's refusal, exact. PSLQ (the census tool's method) becomes the
cross-check: both must agree on all 1,435 radicands or the export refuses. The soft edge named in
§Bʹ.3 is thereby removed. The fusion argument (§Bʹ.3) makes the split a partition of points. —
**Prove:** the square criterion (standard, per level), the fusion argument. **Test:** planted
squares (`y²` for random `y ∈ K` at each level — found, root `= ±y`), planted non-squares (`5y²`,
`2y²`, `y² + 1`), the census's 32 in-field radicands all recognized and its √5/√35 radicands
refused, PSLQ agreement on all 1,435; the export's point counts against `poolfield-L4.json` (in-field
pairs 140,195); `load_pool(obj, "depth1-infield")` re-derives the fingerprint. **Assume:** nothing
beyond exact rational arithmetic.

**5. The culled object's minting.** *What the file asserts by existing:* `unit ∪ (cheats ∖ removed)
∪ {A ≠ B}` is UNSAT in two encodings. *What `removed` asserts:* nothing about WHY — the row does.
*The mint's soundness rests on A2's refutation of the 149-set, not on the cull's bookkeeping:* the
cull could have erred about joint redundancy and the certificate would say REFUSED (a separating
colouring of the 149-set exists), which is the investigate clause — the certificate is the sole
truth-maker here as everywhere. The mint asserts the set identities: `dropped = loop.dropped ⊎
rust.dropped_groups` (114 + 10, disjoint, each live and standing in `L4`), `standing_after = kept_final`
as sets (149), `removed = removed_L4 ⊎ dropped` (195). — **Prove:** set arithmetic (asserted).
**Test:** the pinned fingerprint `a79347720ccda3ed`; the sidecar equality with `+cull149`; the tamper
red (one extra dropped cheat ⟹ a different fingerprint ⟹ refused against the sidecar's
`fingerprint_removed`). **Assume:** A2's verdict.

**6. The batch's joint list against the spectrum — a free identity as E1's control.** For the joint
batch `B` (exact) and each `e ∈ B` whose single run is exact: the lines of `S_B` proper on `B ∖ {e}`
are exactly `S_e` as orbits (properness is palette-invariant, so the put-back filter counts orbits
exactly — the WO-8 identity it-4 verified at 37,316 = 37,316), hence `popcount` of the put-back mask
for `e` must EQUAL the spectrum's count for `e`. Two independent runs, one identity, no solving:
`tools/subbatch.py`'s masks give it for free. A mismatch is an enumerator fault and halts E1.

**7. The partition, in one table.**

| claim | prove (argument in the docstring; kernel form where it exists) | test (self-test / control / planted red) | assume |
|---|---|---|---|
| cube cover + verdict | I by induction on splits; kernel: M05's cover theorem | K₆ 125 leaves; SAT validated; 10 random agreements; resume after a split; `--drop floor` ⟹ REFUSED | cadical refutations |
| spectrum verdicts | witness transfer; line validation incl. mono-on-`e` | enum-rank 15,218 reproduced; corrupted witness refused; floor ≥ 1 | V1–V3 |
| census | monotonicity; the join table | synthetic table incl. the impossible cell; derived label | replay verdict exactness |
| field split | square criterion on the tower; fusion argument | planted squares/non-squares; 32 in-field recognized; PSLQ agreement 1,435/1,435; counts vs census | exact arithmetic only |
| the mint | set identities | pinned fingerprint; sidecar equality; tamper red | A2 |
| E1's identity | put-back = single (orbit counts) | popcount = spectrum count per `e` | both runs exact |

## §Bʹʹʹ. The experience-modeling pass (2026-09-04, fresh invocation) — the surfaces

*Consumers, inhabited at their moment of use: (i) me between runs, holding one question ("which
command next?") and one file; (ii) a fresh session with zero memory, holding the stub and `data/m53/`;
(iii) Kooshi at the close, holding the dial and the decision; (iv) the chain's own tools consuming each
other's files (`load_object`, `adopt_rust_list`, `_gated_seps`, `load_pool`, the census reader) — the
machine users, whose context is exactly the keys they read.*

**Names say what the tool does** (a cold reader's dictionary): `tools/cheat_spectrum.py` (every
standing cheat enumerated alone), `tools/cube_certify.py`, `tools/pool_field_restrict.py`,
`tools/outfield_census.py`, `tools/commit_cull.py`. "Spectrum" is glossed at every first use.

**1. The spectrum's file `data/m53/spectrum-<label>.json`** answers three questions in its first
line: which cheats are cheap, did the second instrument agree with the culler, did any undecided cheat
decide. `headline` (one sentence, populations and caps in it): *"L4c: 149 standing cheats enumerated
alone (cap 50,000 classes · 1,000,000 conflicts · 4 threads, engine `<commit>`): N necessary (≥ 1 class;
M exact, C capped), D droppable-alone (exact 0), U unknown (0 classes, open leaves); median exact count
X; culler witnesses found K/60 (exact runs), not checkable C′ (capped); floor 27/27 ≥ 1; of the 46
undecided: a necessary, b droppable-alone, c unknown."* Then `cheats` sorted by count ascending, one
record each — `cheat, count, claim (exact|capped|open), verdict, evidence` (`{line_validated,
mono_on_cheat}` | `{leaves_refuted}` | `{open_leaves, stop_reason}`), `witness_check`
(`found | not-checkable-capped | none`), `prior` (`floor | witnessed | loop-kept | undecided`),
`seconds, out_dir` — then the three `lists`, the `census_row` exactly as recorded, `conditioning`
(caps, threads, engine commit, sidecar sha, object fingerprint), and `scope` ("a capped count is a
lower bound; droppable-alone is the enumerator's refutation on one encoding and enters the object
only through a commit's two-encoding certificate"). Progress: one line per cheat — `[spectrum] 37/149
4-90: 1,234 classes exact in 41 s — necessary (witness found)` — and a running tally every ten.

**2. The census's file `data/m53/outfield-census-<label>.json`** leads with the verdict on R1's test
and the join table's cells by name: *"B₀ = {…} (8 cheats) on L4c: N classes. In-field pool (n_in
points; rule: the parent pair's 4/d² − 1 is a square in ℚ(√3,√11), exact, PSLQ-agreed 1,435/1,435):
K_in killed, S_in survive (proof), U_in unknown (cap c · wall w). Full pool (n points) on the residual
S_in ∪ U_in: of S_in — **X killed = classes provably needing out-of-field material at depth 1**, Y
survive the full pool too, Z unknown; of U_in — k killed, s survive (⟹ survive in-field, derived), u
unknown. Out-of-field alone on S_in: W killed (out-alone), X − W cooperative. R1 reads: FIRST HORN
(X = 0, Z = 0, U_in = 0) | SECOND HORN (X > 0) | UNDECIDED (X = 0 with Z + U_in > 0)."* Then
`decision_0prime` (the pool named for it-5, the rule that named it, the monitor registered), `table`
(every cell with its count and label; `impossible_cells` absent because the reader REFUSES rather
than writes one), `classes` (per residual class the verdict triple), `conditioning` (the class list's
sha256, the three manifests' fingerprints and `derived_from`, caps, walls, threads, machine).

**3. The cube front-end's lines.** Progress every 60 s: `[cube binary3 L4c] leaves: 611 refuted · 0
sat · 14 open (depth 4 → splitting) · 1,203 s · 32 workers · deepest 5`. The verdict, one of three
shapes, mirrored in `data/m53/cube-certify-<name>.json`: `UNSAT — 1,204 leaves all refuted (max depth
6 · cap 600 s/leaf · 3,412 solver-s · 2h01 wall)`; `REFUSED — leaf (v12=0, v88=3, v5=1) is SAT and the
colouring is VALIDATED (proper on 13,796 unit edges and 149 cheats, separates 205/206): the standing set
does NOT force — investigate, never retry`; `UNKNOWN — 3 leaves open at the depth cap 9 (named), 1,201
refuted; verdict withheld: raise --max-depth or --cube-cap and re-run (resumes)`. A SAT leaf whose
decoded colouring fails validation is `INSTRUMENT FAULT`, never REFUSED (cadical's model and the
decoder disagree). The journal header pins the formula: encoding, object fingerprint, standing-set
sha, split order — a resume against a different formula refuses naming both shas.

**4. The restricted pool's manifest** is a `pool-export` `load_pool` accepts as `depth1-infield`
(name and fingerprint agree), whose `pool.params` say the rule in words — `{"restrict": "field=in",
"field": "Q(sqrt3,sqrt11)", "rule": "parent pair's 4/d²−1 is a square in K — tower criterion, exact;
PSLQ cross-check agreed on every radicand", "exact_source": "data/m52/exact-<label>.json"}` — and
whose `derived_from` names the full export's fingerprint and the radicand census (`total, in, out,
pslq_agreement`). The run prints: `depth1-infield: 280,1xx of 1,8xx,xxx points (15.x %) from 140,195
in-field parent pairs; depth1-outfield: …; in + out = all (asserted)`.

**5. The `cull-commit` row** reads like its siblings (`batch-commit`, `deletion-commit`): `label,
from, dropped (124), dropped_by {enumeration-loop: 114, rust-culler: 10}, standing_after 149,
undecided_carried 46, onehot {outcome, secs, instrument}, reencode {outcome, instrument: "binary3
cubed", leaves, secs}, verdict committed|candidate, object_after {n, unit, cheats}, claim_scope`. Only
under F3 does the object file carry a top-level `"candidate": {"reencode": "unknown", "open_cubes":
[…], "result": "data/m53/cube-certify-…json"}` — and `--status` shows the row's verdict beside the
label, so a cold session sees CANDIDATE without opening the file.

**6. Breakdowns designed first (the error path is the surface).** Every tool refuses, naming both
sides, on: a sidecar whose label is not the `--object`; a cheat named that is not standing; the engine
binary lacking a verb (with the rebuild command); exact coordinates missing for the label (with the
command that writes them); a tower/PSLQ disagreement (the radicand named); checkpoints over different
class lists (both shas); an unfinished replay handed to the census (an unfinished replay is not a
census — no `--allow-unfinished`); a journal from another formula; an overlap between dropped and
removed. No tool writes a partial result file: a result file's existence means the run reached its
verdict. And the widened assertion in `adopt_rust_list.py` still refuses a spent cheat the census
never examined; the row must carry all three lists as keys (an absent key is refused, never read as
empty).

**7. The close's report** is in the house format, every number with its population: the dial line
(`446 → 149 → N`, the object named), the 0′ decision with its number and horn, the eight predictions
scored (met / missed / refuted, each with the measurement), the carried unknowns as ranked items with
defaults, the server-gate rows with their savings, and the decisions implementation forced in four
parts.

## §R0. The opening (2026-09-04, desktop) — controls green, one engine incident, one design correction

* **The enumerator's regression control is GREEN**: the M52 enum-rank batch (8 floor cheats over the
  71 removed, un-culled sidecar) reproduces **15,218 classes, exact, stage `58d88ed886f9ca76`** on
  main's rebuilt binary (`787c821`; 153 s at 8 threads). Same instrument, same input, before any fresh
  run was believed.
* **The field classification is exact and equals the census**: `tools/pool_field_restrict.py
  --classify-only` on the iteration-4 point set — 950,371 live pairs at distance < 2, **1,435 distinct
  radicands, 32 in-field (140,195 pairs), 1,403 out-of-field (810,176 pairs)**, the tower square
  criterion and PSLQ agreeing on every radicand (210 s); the self-test's 80 planted squares found with
  roots verified, 240 planted non-squares refused, 3/11/33 squares and 2/5/−1 not. The M52 census's
  numbers (`poolfield-<L4>.json`) are reproduced to the pair. `data/m53/fieldclass-<L4>.json`.
* **Every instrument's planted red seen red before its first real run**: the spectrum's corrupted
  witness refused; the cube driver's K₆ cover (125 leaves = every assignment), validated SAT, 20
  cube-vs-monolithic agreements, resume-after-split, foreign-journal refusal, INSTRUMENT-FAULT
  distinction; the census reader's impossible cell, unfinished residual, foreign class list; the
  mint's tamper (one extra dropped cheat ⟹ `fd95d985e69db32d` ≠ the sidecar's `a79347720ccda3ed`) —
  and that tamper fingerprint is EXACTLY the engine's stage fingerprint for the `4-90` single-cheat
  stage: the Python and the Rust derivations of "removed ∪ {e}" agree, a free cross-implementation check.
* **Engine incident (D68's shape, not a new defect)**: the spectrum's first launch at the engine's
  default 1,000,000-conflict budget ended every single-cheat run in `CONTRADICTION: verification did
  not hold` (rc 3) — an UNDECIDED verification (`disagreements: []`, `undecided: [0]`, claim
  `capped-solver`, one 67-s solve) worded as a contradiction, exactly the defect filed 2026-09-02. The
  driver now reads `enumerate.json` on any exit code: `disagreements` non-empty ⟹ a REAL contradiction
  (halt and report); `undecided` with none ⟹ the run is OPEN and its written lines stand (re-validated
  here). Relaunched at **40,000,000 conflicts** (the enumeration cull's budget). Single-cheat stages
  are TIGHT instances (unit ∪ 148 cheats): the first solve — finding ANY separating colouring, or
  refuting — runs 10+ minutes single-threaded, so the spectrum's cost is the first solve per cheat,
  not the class writing (the four in flight at 10 min: one journal row each).
* **Design correction found by watching the instrument (P-M53-7's mechanism was wrong)**: the
  enumerator grows its cube tree FROM CLASSES (WO-11: "growth is never blind" — a split needs a
  class census), so on a cheat with ZERO classes there is no split and the exact-0 verdict is ONE
  monolithic refutation at the budget — the same ask the culler left undecided at 30 M conflicts, not
  the cube refutation §Bʺ.2 credited. The instrument that DOES split blind is `tools/cube_certify.py
  --drop e` (a complete prefix cover from depth `--split` regardless of classes): for each cheat the
  spectrum leaves UNKNOWN, one cube run — SAT (validated witness) = necessary, UNSAT = droppable-alone
  by the cover invariant, UNKNOWN at the depth cap = carried. Registered as **phase B′** (after B,
  before A2, the same 32 workers): P-M53-7 is re-attached to B′, its mechanism corrected; the
  spectrum's `unknown` list is B′'s input.
* **The pool build runs beside the spectrum** (decision, recorded): one numpy process, one core,
  memory watched; the spectrum holds 16 threads. The standing "one heavy job" rule is about
  replays/hunts/builds contending for cores and memory; this pair contends for neither (CPU 17 of 32;
  the build's peak measured as it runs). Launched 2026-09-04 ~19:30Z, ~1.5–2 h expected.
