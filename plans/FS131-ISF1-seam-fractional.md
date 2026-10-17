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
