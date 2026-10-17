# FS131-ISF1 — the fractional chromatic number of the plane over ℚ(√3, √11) is 4: the implementation

*de Bruijn, the implementer (Opus 5.5), 2026-10-17. Brief: `data/fs131/briefs/FS131-ISF1-seam-fractional.md` (on `main`,
commit `c5593cb77`). Worktree `.claude/worktrees/kcs1`, branch `fs131-ksf1`, cut at `10cf51dd0` (the planner's skeleton, `main`
merged). Plan: `plans/FS131-KFS1-four-space-plan.md` (Part B). Working files: `data/fs131/isf1/`.*

## Theorems this phase proved

None yet (filled at each saved stage).

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations, checked against their sources

`tools/fs131_isf1_quotes.py` (after FS131-KFS1's `quote_check.py`, its nested-prefix fix kept) takes every block quotation
of the brief (a run of `>` lines closed by `— source: <path>`), strips the `>` prefixes and collapses whitespace on both sides,
and requires the quote to occur in its source in `main`'s tree or this branch's. Result (`data/fs131/isf1/quote_check.out`):
**7 quotes, 7 FOUND, exit 0** — W2 (`data/fs131/REQUEST-2026-10-13.md`), § 1.6 (`CLOSED-QUESTIONS.md`), the two head
statements (`Proofs/HadwigerNelson/Instances/SeamFractional.lean`, this branch), items 1082, 1080 and 1025
(`plans/FS131-close-inventory.md`). Planted control (`--plant`: `fractionalChromaticNumber` → `fractionalchromaticNumber`
in the third quote): that quote reads MISSING and the exit is 1 (`quote_check_plant.out`).

**Finding (no defect in the brief).** Item 1080's quote is found in this branch's copy of the inventory and in `main`'s at
the brief's own commit (`c5593cb77`), but not in `main`'s working tree: `main` reworded item 1080 after the brief was
written (commit `1253d345c`, "inventory item 1084; three arXiv titles and an alias key" — the sentence on the key
`[Johnson2011]`/`[Johnson2010]`). The quotation was exact when the brief was written.

### 1.2 The target, restated

`K = ℚ(√3, √11)` (`seamField`), `K²` the unit-distance graph on `seamPlane = planeOver seamField` (`unitDistance ℂ` induced).
Three head statements, already proved in the skeleton from two leaves (the plan's § 3.2):
* `fractionalChromaticNumber_seamPlane` — `χ_f(K²) = 4`, `[CranstonRabern2015]`'s question;
* `finIndepRatio_seamPlane` — `α₁(K²) = 1/4`;
* `iSup_fractionalChromaticNumber_seamPlane` — `⨆_S χ_f(K²[S]) = 4` over finite `S`.

The two leaves: `numberField_seamField : NumberField seamField`, and `IndepLaw.density_le_quarter_seamField (μ : IndepLaw
seamField) : μ.density ≤ 4⁻¹` — every translation- and rotation-invariant random independent set of `Cay(R, U)` (`R = ℤ[U]`,
`U` the unit vectors of `K²`) has `P(0 ∈ I) ≤ 1/4`. The second is `[MatolcsiEtAl2025]`'s Theorem 3 (`χ_gf(G27) ≥ 4`) read
against an invariant law, through its certificate `data/fs56/g27/cert-g27-mrvz.json`, checked by the kernel.

### 1.3 The rulings and the order of work

* **Remove Part A's skeleton in the first commit** (item 1082, ruling 3): done, `eac56a860` — the four `RationalFour`
  modules, their import line in `Proofs.lean`, their four `ARCHITECTURE.md` rows; `tools/check_architecture.py` PASS
  (`data/fs131/isf1/arch-check-c1.out`).
* **The first leaf is a price probe** (ruling 2): generate the data, check two atom chunks in the kernel, message the
  coordinator the time and memory per chunk and the extrapolation; continue unless the whole check will not fit the machine.
* **The generalization** (FS131-PAS2 § 4.2: every finite unit-distance graph over `K` has `χ_gf ≤ 4`) is optional: state and
  prove it if it is under about 100 lines in the library's vocabulary, else write its price here.
* **Merge `main` before the gate**; the gate in full on one commit (the steps of `data/fs131/clone1/run-gate.sh`), every count
  change explained against `main`'s last gate (`data/fs131/iru2/gate/`).
* **Order**: Stage 2 the probe; then the leaves in the plan's order (`numberField_seamField`; the checker; the data; the
  soundness; the law; the head leaf), a saved stage after each module; then the gate, the read-aloud, the drafts, the report.

### 1.4 The skeleton's stored statements, before any proof edit

`data/fs131/isf1/lean/StatementDump.lean` (a copy of FS131-IRU2's dumper, module list replaced) printed every constant of
`Instances/SeamFractional` from the planner's build as given (`data/fs131/isf1/statements-skeleton.txt`: seven constants,
all theorems — the three heads, `finIndepRatio_seamPlane_le`, the two leaves and the instance). The comparator
`tools/fs131_isf1_statements.py` (BEFORE/AFTER; SAME / CHANGED / MISSING, additions listed) run on the dump against itself
with `--plant` reads 7 SAME, and each of its three plants fires by name — a head's stored type changed, a head dropped, a leaf
made an axiom (`data/fs131/isf1/statements-selfcheck.out`).

## Stage 2 — SAVED: the price probe

### 2.1 The check, and why it is not the plan's

The certificate (`data/fs56/g27/cert-g27-mrvz.json`): 27 points, 28,496 weighted sets, rational weights with common
denominator `D` of 843 bits. Condition (iii) — every independent set `S` of `G27` has `Σ_{Y ⊆ S} y_Y ≤ 1` — is the expensive
check. The plan's route (`X23Check`'s DFS, scanning every term of a point's group at every node where the point enters) costs
**974 M mask tests** on `G27` in the identity order and 632 M in the best breadth-first order
(`data/fs131/isf1/probes/dfs_cost.py`): at `X23`'s 140 µs a test, a day of kernel. So the check is a **residual DFS**
(`Plane/G27/Check`): the DFS carries the list of terms whose decided part lies in the chosen set, with the decided part
removed; a point out drops the terms that need it, a point in shifts the terms that hold it and drops those holding one of
its neighbours, and the two parts are merged with equal keys added. At a leaf the residual's constant term is the set's sum.
Simulated (`probes/dfs_cost3.py`, `dfs_profile.py`), in the order of degree descending: 411,038 nodes, **2.76 M list
elements** in all (62.7 M with no merging, 10.5 M with no pruning), every leaf at most `D` — so the certificate's
condition (iii) holds on the DFS's own terms.

### 2.2 The data

`tools/fs131_kfs1_g27.py` (the plan's name): points relabelled in the DFS order and translated so point 0 is the origin;
the 49 edges as masks; a path of edges from point 0 to every point; the congruence classes of the 28,469 weighted sets of
two or more points by an exact isometry test over `ℚ(√3, √11)(i)` — **11,640 classes**, matching `fs56_gf_check.py`'s
count, each summing to 0 (checked) — and from each class with representative `R` and members `Y`, **16,829 rows**
`R → Y` with an isometry `z ↦ (U/m)(b ? z̄ : z) + V/(12m)` in `X23Check`'s row format and the coefficient `y_Y·D`. The
row's terms are `−c` on `R` and `+c` on `Y`: so the expected value of a row's terms is zero for any law invariant under the
isometry, and the class-sum property is built into the data rather than checked. The singletons' `y_i·D` sum to `4D`
(checked). The 33,685 expanded terms sorted and merged give exactly the certificate's 28,496 weights (checked).

**The 64-bit tag.** `X23Check`'s row format reserves digit 0 for a weight that `rowOk` never reads (it reads digits 1–19 and
the index lists). The rows' first version put the constant `2⁷⁰` there, so every row's low 64 bits were zero — and the
kernel's caches hash a `Nat` literal by its low 64 bits (`LEAN.md`, FS131-KC13): a 600-row fit check took **108 s**. With a
64-bit odd tag in digit 0 (the first 8 bytes of `sha256("FS131-ISF1 G27 row k")`), the same check takes **0.92 s**. The
tag carries no meaning: `rowOk` does not read digit 0, and nothing in the soundness proof mentions it.

### 2.3 The measurement (laptop, `lake env lean` under the slot; `data/fs131/isf1/probes/logs/`)

| check | size | kernel | peak RSS |
|---|---|---|---|
| atom chunk 0 (first checker) | 63,845 residual elements | 29.0 s | 3.68 GB |
| atom chunk 1 (first checker) | 63,967 | 31.9 s | 3.70 GB |
| congruence rows, one module | 600 rows, 5–6 points | 46.6 s | 5.16 GB |
| atom chunk 0, `List.rec` checker | 63,845 | **10.2 s** | **1.96 GB** |

About 0.8 GB of each peak is the environment. The first checker used structural recursion and notation; a micro-benchmark
(`probes/bench/`) priced one pass at 86 µs an element that way, 50 µs with direct `Nat` calls, 24 µs with `List.rec` and
direct calls, and a merge step at about 48 µs. The checker now has the last form (`noncomputable`, since `List.rec` does not
compile; the kernel alone evaluates it). Reported to the coordinator (item 1087); ruling: tens of MB of generated text are
acceptable with no file over about 25 MB, the cheap shrinks first, and the generator committed with its `--check`.

### 2.4 The extrapolation and the structure it forces

With the `List.rec` checker: about 160 µs and 18 KB of kernel memory per residual element. The whole DFS, 2.76 M elements, is
about **7.4 min** of kernel; the rows (16,829 at about 78 ms) about **22 min**; the sort of the expanded terms (about 0.54 M merge
steps) about **0.5 min**. Memory, not time, sets the cut: a declaration of at most about 200 k elements (about 3.6 GB). So:
* the DFS is cut into a tree of literal states — a declaration starts at a literal state and either runs its whole subtree
  or computes the states at a chosen depth, compared with literals. The depths are chosen by dynamic programming over the
  whole DFS tree to minimise the literal data (`probes/split_dp.py`): at 200 k elements a declaration, 26 split
  declarations, 72 leaf states, about 110 k literal entries (the root's 28,496 among them);
* the sort is cut by row module: each sorts its own terms against a literal, and one declaration merges the sorted
  segments into the root;
* rows at 300 a declaration.

Total: about 30 min of kernel, every declaration under about 4.5 GB.

## Stage 3 — SAVED: the modules (hand-written proofs complete; generated data built, see Stage 4)

All under `Proofs/HadwigerNelson/Plane/G27/`, namespace `HadwigerNelson.G27`:

| module | what | lines |
|---|---|---|
| `Check` (core, imports only `X23Check`) | the checker: terms `key + 2²⁷·(c + 2⁸⁵²)`, the residual steps (`stepOut`, `stepIn`, `mergeR`), `dfsR`/`collectR`, `goodB`, `splitOk`, the sort (`sortRounds`), the rows' terms (`rowsTerms`, `rowsFit`), `adjOk`, `wfB`, `pathsOk`, `singSumOk`; spec examples | 230 |
| `Sound` | `val_mergeR`, `val_sortR`, `val_stepOut`, `val_stepIn`, **`dfsR_sound`**, `dfsR_append`, `dfsR_eq_all`, `goodB_of_split`, `segsOk_spec` | 600 |
| `Law` | the field and points (`xpt_mem`: every point in `ℤ[U]` by a path of edges); `row_corr`/`row_phi` (each row an isometry of `R`, preserving `φ(Y) = P(Y ⊆ I) + P(Ȳ ⊆ I)`); `expect_le` (integrals of the terms); `indepFrom_mk`; **`density_le_of_cert`** | 650 |
| `Bound` | `cert_bound` (condition (iii) from `good_root`, `root_sorted`, `segs_ok`); **`density_le_quarter`** | 60 |
| generated (`tools/fs131_kfs1_g27.py --write`) | `Data` (points, masks, paths, `Dn`, singletons; `adj_ok`, `wf_ok`, `paths_ok`, `origin_ok`, `sing_ok`), `Rows00…28` (600 rows each: two `rowOk` checks, `rowsFit`, the sorted terms), `RootData`, `RootSort`, `St000…005` (the split tree's literal states), `Chk00…07` (the split and leaf-group checks), `All` (the assembly: `segs_ok`, `root_sorted`, `good000…005`, `good_root`) | 47 files, 46 MB |

`Instances/SeamFractional`: `numberField_seamField` proved (a ring map into `fieldOfRadicands {3, 11}`, a number field);
`IndepLaw.density_le_quarter_seamField` is `G27.density_le_quarter` (edited after the build, which must not read it mid-walk).

**Re-price from the first leaves.** The plan priced Part B at about 1,360 hand-written lines; written: about 1,540, of which the
soundness of the residual DFS (the plan's route had none to write — it borrowed `X23`'s scan) and the split tree are the new
part. Kernel, measured: a `Chk` module of about 410 k residual entries is 46 s and 2.9 GB; a `Rows` module about 50 s.

**The split tree** (`--stats`, `data/fs131/isf1/gen/manifest.json`): leaves of at most 150 k residual entries, splits of at
most 200 k, groups of at most 150 k; 6 splits (root → point 5; then 5 → 12, 12 → 13, 5 → 6 twice, 5 → 9), 22 leaf groups,
94,639 literal residual entries below the root; largest generated file 9.0 MB, all 47.3 MB.

**The generalization** (FS131-PAS2 § 4.2: every finite unit-distance graph over `K` has `χ_gf ≤ 4`) — not stated: `χ_gf` is
not in the library's vocabulary. Price: about 40 lines to define the geometric fractional chromatic number of a finite set
`H ⊆ K²` (fractional colourings whose aggregate on a point set depends only on its congruence class), and about 100–150 for
the bound — the four classes of Theorem B's residue colouring, each weighted 1, have aggregate `[c constant on Y]`, which
is invariant under the isometries of `K²` because the residue map is additive and multiplies by the unit's residue. Over
the 100-line line: left as priced.

## Stage 4 — SAVED: every leaf proved; the build green; the statements unchanged

* **Build 1** (`data/fs131/isf1/build1.log`; the build's own log `build/gate/build/20261017T014626Z-2188811.log`): OK, 1,127
  batches at `BATCH=2`, 51 modules rebuilt in 45 m 18 s — the 47 generated modules, `Check`, `Sound`, `SeamFractional`
  (its density leaf still `sorry` then) and the root. Measured in the build: `Rows*` 23–58 s each (two in parallel), `St000`
  61 s (9 MB of literals), `Chk00…07` 19–68 s, `RootSort` 16 s, `All` 1.3 s. Its one class of warning — unused `simp`
  arguments in `All`'s split assembly — is gone: the generator now writes each split's proof as a term
  (`all_append_true`, `all_singleton_true`, added to `Sound`).
* **Build 2** (`data/fs131/isf1/build2.log`, `build2-full.log`): OK, 248 batches at `BATCH=10`, 6 modules rebuilt (`Sound`,
  `All`, `Law`, `Bound`, `SeamFractional`, the root), **0 warnings**, 6 m 28 s. A first attempt at `BATCH=2` was stopped by
  its process group at batch 8 of 1,129 (a 45-minute walk for six modules), checked stopped (no process, log static).
* **`sorry`**: none in the library (`grep`, narrow form: 0 files).
* **Axioms** (`data/fs131/isf1/head-axioms.txt`, `pp.fullNames`): `fractionalChromaticNumber_seamPlane`,
  `finIndepRatio_seamPlane`, `iSup_fractionalChromaticNumber_seamPlane`, `IndepLaw.density_le_quarter_seamField`,
  `numberField_seamField`, `G27.density_le_quarter`, `G27.cert_bound`: `[propext, Classical.choice, Quot.sound]`;
  `G27.good_root` (the kernel's DFS): `[propext, Quot.sound]`. No outside theorem.
* **Statements** (`tools/fs131_isf1_statements.py data/fs131/isf1/statements-skeleton.txt.gz
  data/fs131/isf1/statements-after.txt.gz --plant`): the skeleton's 7 constants **SAME**, none added to `SeamFractional`;
  4 new hand-written modules, 416 constants; each of the three plants fires. RESULT: CLEAN.
* **Generator**: `--check` IDENTICAL (47 modules and the manifest); `--check --plant` (one hex digit of `Rows00` changed in
  memory) MISMATCH naming `Rows00.lean`, exit 1.
* **Architecture**: rows for the 51 `Plane/G27/` modules (`data/fs131/isf1/arch_rows.py`, imports from `build_order.py`),
  the `SeamFractional` row brought to what is proved; `tools/check_architecture.py` PASS
  (`data/fs131/isf1/arch-check-c2.out`).

## Theorems this phase proved (filled at stage 4)

All on `[propext, Classical.choice, Quot.sound]` or fewer; no outside theorem; no hypothesis standing for an assumption.
* `HadwigerNelson.Instances.SeamFractional.numberField_seamField` — `ℚ(√3, √11)` is a number field.
* `HadwigerNelson.Instances.SeamFractional.IndepLaw.density_le_quarter_seamField` — every `R ⋊ U`-invariant random
  independent set of `Cay(R, U)` over `ℚ(√3, √11)` has density at most `1/4` (`[MatolcsiEtAl2025]` Thm 3, by `G27.density_le_quarter`).
* With these two leaves the skeleton's three heads stand: `fractionalChromaticNumber_seamPlane` (`χ_f(K²) = 4`),
  `finIndepRatio_seamPlane` (`α₁(K²) = 1/4`), `iSup_fractionalChromaticNumber_seamPlane` (`⨆_S χ_f(K²[S]) = 4`).
* `HadwigerNelson.G27.cert_bound` — the certificate's condition (iii) for every independent set of `G27`, by the kernel.
* `HadwigerNelson.G27.density_le_of_cert`, `density_le_quarter`, `dfsR_sound`, `goodB_of_split`, `val_stepIn`,
  `val_mergeR`, `val_sortR`, `row_phi`, `xpt_mem` — the route's named steps (`Plane/G27/Sound`, `Law`, `Bound`).

## Stage 5 — SAVED: the read-aloud, the drafts that need no gate count, and what is left

### 5.1 The read-aloud (the stored types, `data/fs131/isf1/head-axioms.txt`)

`[CranstonRabern2015]`, concluding section: *"What is the fractional chromatic number of `ℚ(√3,√11) × ℚ(√3,√11)`?"* — the graph
on the points of the plane with both coordinates in `ℚ(√3, √11)`, two points adjacent at distance exactly 1.
* `fractionalChromaticNumber_seamPlane : (SimpleGraph.induce FieldWall4.seamPlane (unitDistance ℂ)).fractionalChromaticNumber = 4`.
  `unitDistance ℂ` joins `z, w` with `dist z w = 1`; `seamPlane` is `{z | z.re ∈ seamSpan ∧ z.im ∈ seamSpan}`, `seamSpan` the
  numbers `a + b√3 + c√11 + d√33` with `a, b, c, d` rational — `ℚ(√3, √11)`. The library's `fractionalChromaticNumber` is the
  infimum, over `b > 0` and `b`-fold `n`-colourings (each vertex at least `b` of `n` colours, adjacent vertices none in
  common), of `n/b` in `ℝ≥0∞`. So: no `b`-fold `n`-colouring of `K²` has `n/b < 4`, and `4` is attained (Theorem B's
  four-colouring). This is § 1.6's "Our answer: 4, exactly".
* `iSup_fractionalChromaticNumber_seamPlane : ⨆ S, χ_f(K²[S]) = 4` over finite `S` — § 1.6's "finite unit-distance graphs
  over `ℚ(√3,√11)` have fractional chromatic numbers arbitrarily close to 4"; so the finitary reading of the question gives
  the same 4.
* `finIndepRatio_seamPlane : (…).finIndepRatio = 4⁻¹` — the infimum over nonempty finite `S` of `α(K²[S])/|S|`: § 1.6's
  "independence ratios arbitrarily close to `1/4`, never below".

**Not claimed**: `χ_f` at any other field; `χ_gf(G27) ≥ 4` as a statement (the certificate is consumed by `cert_bound`, a
statement about the 27 relabelled, translated points, not stated as MRVZ's Theorem 3); the generalization of FS131-PAS2
§ 4.2 (priced, stage 3); novelty — FS131-PAS2's line, quoted in 5.2. **Route** (not the hand proof's): no blow-up and no
measure rigidity; `Collapse.exists_indepLaw` (amenability, standard three) and the certificate read against the law.

### 5.2 Drafts (each naming its slot; none applied; the gate's counts are left for the gate)

1. **`CLOSED-QUESTIONS.md` § 1.6**, replace `**Not kernel-checked** beyond Theorem B.` with: `**Kernel-checked** (FS131-ISF1,
   on the standard three axioms, no outside theorem): `Instances/SeamFractional`'s `fractionalChromaticNumber_seamPlane`,
   `iSup_fractionalChromaticNumber_seamPlane`, `finIndepRatio_seamPlane`. The route is not the hand proof's: an invariant random
   independent set of `Cay(R, U)` (`Collapse.exists_indepLaw`, the amenability step) has density at most `1/4` by
   `[MatolcsiEtAl2025]`'s certificate for `G27`, every condition of which the kernel checks (`Plane/G27/`: 16,829 congruence
   rows as isometries, the 28,496 weights, every independent set of `G27` by a residual DFS); no blow-up and no measure rigidity.`
2. **The novelty line** (FS131-PAS2 § 4.4, "C14's novelty line", quoted, not reworded): *"`χ_f(ℚ(√3,√11)²) = 4` answers
   `[CranstonRabern2015]`'s question; prior art: not found in print (FS131-PAS2, 2026-10-17). The upper bound is Fischer's
   (1994), the lower bound's graph and blow-up are Matolcsi, Ruzsa, Varga and Zsámboki's (2025), read inside the field; at
   the Moser ring the geometric value 4 is Dúcz's (2026)."*
3. **`BIBLIOGRAPHY.md`**, `[MatolcsiEtAl2025]`'s "what of ours rests on it": add "Thm 3's certificate (`G27`, the witness
   re-checked by `tools/fs56_gf_check.py`) is kernel-checked in `Plane/G27/` and consumed by `G27.density_le_quarter`
   (FS131-ISF1); its Thm 1 (the blow-up) is not used by the kernel route." `[CranstonRabern2015]`: add "the question is
   answered in the kernel by `Instances/SeamFractional` (FS131-ISF1)."
4. **`LEAN.md`** § The kernel's cost model, two lines (Keryx's pen): (a) *A certificate whose terms are sums over subsets
   (`Σ_{Y ⊆ S} y_Y` for every independent `S`) is checked by a residual DFS, not by testing every term at every node: the
   residual of the term list (terms whose decided part is in the set, that part removed, equal keys merged, terms holding a
   neighbour of a chosen point dropped) took `G27`'s check from 974 M mask tests to 2.76 M list elements (FS131-ISF1).*
   (b) *A list pass written with `List.rec` and direct `Nat` calls costs about 24 µs an element in the kernel, against 50 µs
   with structural recursion and direct calls and 86 µs with structural recursion and notation; the definitions are
   `noncomputable` (`List.rec` does not compile), which `decide +kernel` does not mind (FS131-ISF1's benchmark,
   `data/fs131/isf1/probes/bench/`).* (c) *`simp only [cond_true]` on a goal holding a closed `2¹⁰⁰⁰` offset sent the kernel into
   deep recursion; stated with the offset a variable and instantiated, the same lemma checks (`Sound.tv_combine_aux`).*

### 5.3 What is left (for this job's successor, or this lane's next job)

**The gate**, on one commit, after merging `main`:
1. Merge `main` (now with FS131-IRF1's `RationalFour/*`, landed as `cb4ed8079`, item 1089); keep both sides of the gate's
   inputs (`scripts/Axioms.lean`, the vacuity header, `scripts/assumptions-ledger.txt`, `ARCHITECTURE.md`, `Proofs.lean`).
   Copy `main`'s compiled `RationalFour` modules in by checksum (`LEAN.md` § Building, FS131-LU1/ICS1's recipe) before the build.
2. **The coordinator's amendment** (item 1089's message to this job): in the merged tree, in the module docstrings of
   `Proofs/HadwigerNelson/RationalFour/Compulsion.lean` and `RationalFour/Forbid.lean`, replace each "prior art: pending
   `[KubickiLehelMorayne2002]`" with "prior art: not found in print (FS131-PAS2, FS131-PAS3; `CLOSED-QUESTIONS.md` § 3)" —
   docstrings only; the statement comparison must show those two modules' declarations unchanged.
3. The audit's block for `scripts/Axioms.lean` (CLEAN): print every record of the 52 modules of `data/fs131/isf1/modules.txt`
   with `data/fs131/isf1/lean/AxiomsAll.lean` (a copy of FS131-LGT1's printer; its plant is an imported record that must
   class as IMPORTED), check each public record's axioms are within the standard three, and file them; then `axioms.sh`,
   `--self-test`, `dupnames.sh` (before the audit) and its self-test, `vacuity.sh` (count changes explained against
   FS131-IRF1's gate, `data/fs131/irf1/gate/` on `main`; the new `IndepLaw seamField` binders and the `List`/`Nat` lemmas
   are the likely sites — `nonempty_indepLaw` is the law's model), `assumptions.sh` (no hypothesis here stands for an
   assumption: `density_le_of_cert`'s are conditions on its own `rows`, `coefs`; `WfAdj`, `IndepFrom`, `SegsOk` are concluded
   by `wfAdj_of_wfB`, `indepFrom_mk`, `segs_ok`) and its self-test, `lake lint`, the steps of
   `data/fs131/clone1/run-gate.sh` copied under `data/fs131/isf1/`.
4. The front-page drafts that need the gate's counts (`CLAUDE.md` § The gate and § Trust ledger).
