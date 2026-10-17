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
