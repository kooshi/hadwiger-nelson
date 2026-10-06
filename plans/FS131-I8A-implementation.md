# FS131-I8A — wave 8's first implementer: the route to `emptyNS` (`Plane/RingCalculus/Empty`), then `Star`'s two leaves

*Job FS131-I8A (de Bruijn, the implementer), 2026-10-06, branch `fs131-w8a` (cut from `fs131-w8` at `f1c13612`). Brief:
`data/fs131/briefs/FS131-I8A-wave8-first.md` (on `main`). The plan: `plans/FS131-w8-kernel-plan.md` (the planner's record, FS131-K8).
Working files: `data/fs131/i8a/`. Tools: `tools/fs131_i8a_*.py`.*

## Theorems this phase proved

All [kernel] on branch `fs131-w8a` (built through `./scripts/build.sh`; not gated, not on `main`); each on exactly
`[propext, Classical.choice, Quot.sound]` unless a smaller set is named. Declarations are of `HadwigerNelson.Plane.ArcMap` unless a
namespace is given.

- **FS116-V6-HUBS, second clause** (the trigonometry) — `ringPt_sixth_dist_le_one` (`Plane/RingCalculus/Empty`), from
  `intCast_zmod_six_of_half_le_cos`. Read against "a tile of p tips at most two, and two only if consecutive … Consecutive hubs are 1
  apart, the others √3 or 2" (`plans/FS116-V6-verification.md` l. 141–144): two ring points `60°·(n − m)` apart within distance 1 force
  `n − m ≡ 0, ±1 (mod 6)`.
- **FS116-V6-COUNT, the count** — `v6_count` (`…/Empty`), from `V6Count.count` (`Plane/RingCalculus/HubCount`): `V6Count.exists_shape`,
  `V6Count.table` (the kernel's check of `13⁴` quadruples; axioms `[propext, Quot.sound]`, no native axiom), `V6Count.stmtB_sound`. Read
  against "M = 4, s = 2, each hub of S has exactly two tips, and every tip at a hub of S is a double tile … the two hubs of S are
  antipodal" (ll. 163–169): the five conjuncts of the statement.
- **FS116-V6-COUNT, the last step, without sectors** — `exists_ne_mem_closure_inter_of_split` (`…/Empty`), from
  `Plane/RingCalculus/TilesAt` (`finite_tileAt`, `exists_ball_tileAt`, `TileAt.inter_sphere_nonempty`,
  `sphere_subset_iUnion_closure_tileAt`, `isPreconnected_sphere_complex`). Read against the module docstring's "the closures of the tiles
  of p cover a small circle about p; if those tiles are split into two non-empty groups … a tile of one group and a tile of the other
  share a closure point other than p".

## Stage 1 — SAVED (FS131-I8A): the readback, the branch built as given, the statement instrument

### 1.1 What I may and may not change

- **May**: the proofs of `ringPt_sixth_dist_le_one`, `v6_count`, `exists_ne_mem_closure_inter_of_split`, `v6_hug`, `v6_hubs`, `emptyNS`
  (`Plane/RingCalculus/Empty`), then of `star_recip`, `star_anti` (`…/Star`) if budget remains; new helper declarations under names no
  other module declares; a new module of my own beside them, with its `Proofs.lean` and `ARCHITECTURE.md` lines; a block "FS131-I8A" in
  `scripts/Axioms.lean` above the `=== PURCHASED ===` banner; this record; `tools/fs131_i8a_*.py`; `data/fs131/i8a/`;
  `data/fs131/reports/FS131-I8A.md`. A docstring may be corrected (the plan's § 5.6).
- **May not**: any statement or definition (a false or unprovable leaf is a message to the coordinator); the foundation
  (`…/Basic`) or any landed module beyond new declarations; the planner's record; `outerAdj`, `doubleTip` (they wait for the second
  planning pass and keep their `sorry`); `v6_hubs`, `v6_hug` stay public with their `VACUITY DECLARED` lines and the companions
  `v6_hubs_vacuous`, `v6_hug_vacuous` stay as they are (ruling 518); no `axiom`, no `native_decide`; no nine-colour map of my own and no
  merge of `fs131-w6m` (the model of `emptyNS` is a later job's, ruling 525 (c) as amended by item 530); no merge, no gate, no `main`.

### 1.2 The brief's quotations against their sources (standing rule 3)

Checked by script (`grep -cF` of each quoted first line in its source file; 31 quotations): **every one is found exactly once,
verbatim** — the Counter-priors sentence (`CLAUDE.md`), inventory items 518, 524, 525 (`plans/FS131-close-inventory.md` on `main`,
ll. 5495, 5613, 5636), the ten statements' first lines (`Empty.lean`, `Star.lean`), and the plan's headings and bullets.

One finding about the brief, not a mismatch of wording: the two table rows it quotes under "### 5.4 The statements, attacked" (the rows
for `emptyNS` and for `star_flank`, …) stand in the plan's **§ 5.5** table ("Inhabitants and vacuity"), ll. 287 and 291, not in § 5.4.

### 1.3 What was read

- The brief; `plans/STANDING-RULES.md`; `LEAN.md` in full (with the two facts the launch message names: the section-`variable` bullet
  and the closed-`Nat`-term bullet); `RUNNING.md` § Building and § Make the gate fail, and watch it fail.
- The planner's record whole (`plans/FS131-w8-kernel-plan.md`, Stages 1–5).
- My files and what they import, in full: `Plane/RingCalculus/Empty`, `…/Star`, `…/Basic`, `Plane/ArcMap`, `Plane/LocalMap`. The
  statement surface (every signature, extracted by script) of `Plane/Tiles`, `Plane/Chord`, `Plane/RingGerm`, `Plane/LocalStructure`;
  their proofs are read where a leaf uses them.
- The rows' argument: `plans/FS116-V6-verification.md` § 2.1–2.2 (V6-DIAM … V6-COUNT, the whole route to EMPTY), ll. 91–191.
- Inventory items 518, 524, 525, 530 whole.

### 1.4 The branch as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: `data/fs131/i8a/logs/build-1-as-given.log` ends
"build: OK — all 1805 modules already up to date, nothing built, 2 module(s) with warnings", `EXIT=0`; the warnings are ten
`declaration uses sorry` lines — eight in `Empty.lean` (ll. 86, 97, 109, 125, 136, 148, 180, 193), two in `Star.lean` — the ten the
brief counts.

### 1.5 The leaves as the kernel has them (`LEAN.md` § Searching — Lean, last bullet)

`tools/fs131_i8a_stmt.py` elaborates each of the two modules twice — the source at `f1c13612` (`git show`) and the working source — with
one appended command that prints every declaration of the module from the environment (`ConstantInfo.type`: its structural hash and its
printed form with full names; a definition's value hash), and compares by name. It is a comparison of elaborated signatures, not of text.

- Baseline, saved: `data/fs131/i8a/sigs-base.tsv` (23 declarations: `Empty` 12, `Star` 11).
- **Each of the ten leaves, read from that print, is the statement the file shows**: the three leaves stated under the section
  `variable {k : ℕ} {F : ArcMap k}` are `exists_ne_mem_closure_inter_of_split` (which names `F`, and the kernel's statement begins
  `∀ {k : ℕ} {F : ArcMap k} {p : ℂ}, p ∈ F.dom → …`), `ringPt_sixth_dist_le_one` and `v6_count` (which name no map, and the kernel's
  statements have none — as intended: pure trigonometry and finite combinatorics); the other seven carry their own `{F : ArcMap 6}`.
  No leaf has lost a hypothesis to the section-variable rule.
- Controls, each watched to fire (`data/fs131/i8a/logs/stmt-selftest-1.log`): `text` (a hypothesis of `v6_count` altered: exit 1, names
  `v6_count`); `include` (`include hbad in` above `ringPt_sixth_dist_le_one` — the statement's text unchanged, the kernel's statement
  gains `0 = 1 →`: exit 1, names it; this is the class a text diff passes); `def` (`v6_anti`'s conclusion altered: exit 1, names it).
  The instrument's own failure is exit 2 and was seen once (a wrong option name in the printer: "INSTRUMENT FAILURE … the printer did
  not report"), never a pass.

### 1.6 Working method

- Helpers go in new modules beside `Empty` (one per leaf group), imported by `Empty`; the leaves stay in `Empty` with their statements.
- Iteration by `lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false` (2.4 s on `Empty` as given); evidence only from
  `./scripts/build.sh` under the slot.
- At each save: the build's log, the statement check against `f1c13612`, the axioms print of the stage's declarations with a `sorry`
  control beside it, commit by explicit path, push.

## Stage 2 — SAVED (FS131-I8A): three leaves — the sixths, the count, the split

### 2.1 What closed, and how

| leaf | route | lines (plan's price) | elaborations |
|---|---|---|---|
| `ringPt_sixth_dist_le_one` | `dist² = 2 − 2cos((n − m)·60°)` (`sq_norm_e_sub_e`), so `cos ≥ ½`; reduce `n − m` mod 6 and read six values (`intCast_zmod_six_of_half_le_cos`) | 50 (80) | 1 |
| `v6_count` | a certified computation, new module `Plane/RingCalculus/HubCount` | 230 with docs and examples (150) | 3 |
| `exists_ne_mem_closure_inter_of_split` | the plan's route, new module `Plane/RingCalculus/TilesAt`; the plan's density step is `mem_closure_tile` (landed), so no density argument | 110 (200) | 1 |

**Re-priced after the first two leaves** (the brief's item 2): lines at about the plan's count, time at minutes per leaf; the two
leaves that are compositions over landed lemmas closed at the first or third elaboration. `v6_hubs` and `v6_hug` are re-priced at their
own stages, from their routes.

### 2.2 `v6_count`: the measurement, and the shape chosen (the brief's item 5; `LEAN.md` § The kernel's cost model)

- **Measured under the slot** (`scripts/slot.py --mem 8 --cpus 1`): the cover hypothesis alone over all `13⁴ = 28,561` quadruples of
  tip sets, 4.2 s in the kernel; the whole statement (`V6Count.table`), **12.3 s**, well under the 8 GiB cap. So `decide +kernel`, not
  the hand count. No `native_decide`.
- **The shape.** The statement over a `Bool`-valued relation is a `Bool` (`stmtB`) built from four literal quantifiers (`allZ`, `anyZ`,
  `allF`, `anyF`: a six- or four-fold `&&`/`||`), never a `Decidable` instance over a `Fintype` — whose synthesis for the whole statement
  failed outright, and whose kernel cost is the kind the cost model warns of. The hypotheses come first under `||`, so a quadruple
  failing the cover costs only the cover. `stmtB_sound` reads the `Bool` back as the statement (`CountStmt`), so nothing about `stmtB`
  is trusted: a wrong `stmtB` would fail `stmtB_sound` or `table`. The tip sets are `Option (ZMod 6 × Bool)` — none, one hub, two
  consecutive — and `exists_shape` proves from `hcons` that every tile's set of tipped hubs is one of the thirteen.
- **The closed-`Nat`-term fact** (the launch message's second fact) does not bite here: the kernel term is `decide (… = true)` on a
  `Bool` with no rewriting lemma applied to a closed numeral.
- **The kernel against the planner's tool**: the tool counts 72 quadruples meeting the hypotheses, none violating the conclusion; the
  kernel proves that none of the 28,561 violates it. No disagreement. One of the 72 is a Lean term (`V6Count.countModel`,
  `countModel_hyps`: tiles tipping `{5,0}`, `{0,1}`, `{2,3}`, `{3,4}`), and an adversary with the hug hypothesis dropped
  (`{0,1}`, `{2,3}`, `{4,5}`, nothing) is an `example`.

### 2.3 Spec examples added (the plan's § 5.5 debts for these leaves)

- `ringPt_sixth_dist_le_one`: an inhabitant of its hypothesis (consecutive sixths are 1 apart) and an adversary (sixths two apart are
  not within 1 — the lemma itself refutes it by `decide` in `ℤ/6`).
- `exists_ne_mem_closure_inter_of_split`: applied to `halfPlane2` at its change point `r(0) = 1`, the tiles split into those of colour
  1 and the others — both groups inhabited, so every hypothesis is exercised on a Lean object (the lemma reads no validity).
- `v6_count`: `countModel_hyps`.

### 2.4 The save

- Build: `data/fs131/i8a/logs/build-2-three-leaves.log` — "build: OK — 468 of 468 batches, 4 module(s) rebuilt, 2 module(s) with
  warnings", `EXIT=0` (rebuilt: `HubCount`, `TilesAt`, `Empty`, `Proofs`; the warnings are the `sorry` leaves left: `Empty` 5, `Star` 2).
- Statement check against `f1c13612` (`data/fs131/i8a/logs/stmt-2.log`): 23 base declarations compared, 0 changed or missing; 1 added
  in `Empty` (`intCast_zmod_six_of_half_le_cos`).
- Axioms (`tools/fs131_i8a_axioms.py`, reading this job's block of `scripts/Axioms.lean` against the compiled modules;
  `data/fs131/i8a/logs/axioms-2.txt`): 21 records, each a subset of the standard three (`V6Count.table`: `[propext, Quot.sound]`). Its
  control, a theorem proved by `sorry`, prints `sorryAx` in the same run; with `--fault` (the control added to the audited records) the
  check exits 1 and names it (`axioms-2-fault.verdict`).
- `./scripts/dupnames.sh`: "OK — no name is declared by two modules" (`data/fs131/i8a/logs/dupnames-2.log`).
- `tools/check_architecture.py`: PASS (`data/fs131/i8a/logs/check-architecture-2.log`), with rows for the two new modules.

### 2.5 A finding at this stage, sent to the coordinator mid-job (iteration-grade until Stage 3 saves it)

`v6_hug`'s argument reads no Γ-free ring, and the same argument proves `doubleTip` without *simple* and without its two far-germ
hypotheses. Stage 3 carries it.
