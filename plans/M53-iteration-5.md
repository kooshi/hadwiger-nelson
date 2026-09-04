# M53 — iteration 5 from the culled plain object (pre-subplan stub, COMPLETE for a fresh session)

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
