# FS131-I5 — wave 5's first implementer: the merge, the eleventh-point repair, the base's obligation pass, and wave 5's leaves

*de Bruijn, the implementer (Opus), on branch `fs131-w5` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5`. Brief:
`data/fs131/briefs/FS131-I5-wave5.md` (main tree). Started 2026-10-04.*

## Theorems this phase proved

None yet.

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

Each quotation checked by reading its source at the named address (main tree for `plans/FS131-close-inventory.md`, `CLAUDE.md`; the worktree for the plan):

| quotation (opening words) | source | result |
|---|---|---|
| "**The plan to work from**: § 4 (leaves 1–22, K5's) and § 9 …" | `plans/FS131-w5-kernel-plan.md` § 10.1, paragraph 5 | verbatim |
| "**It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name …" | the plan § 10.2, paragraph 1 | verbatim |
| "227. **Ruling: repair (b) adopted as drafted** (E4 § 5.2). Choice: `UnenclosedC` on …" | `plans/FS131-close-inventory.md` item 227 (line 1629) | verbatim |
| "218. **Rulings on KB's and IC1's held items** (four parts each, …)" | the inventory, item 218 (line 1562) | verbatim; the brief's summary of (b), (c), (d), (e), (g) matches the item |
| Kooshi, "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors — read before pricing anything | verbatim (the sentence continues in the source with the FLT remark) |
| item 208 (a), `cvb_thom_reduced` priced from its first two children | the inventory, item 208 (line 1485) | matches |

The brief's counts: "41 `sorry` leaves in `Terminal`, `Dense`, `HexRing`, `MapGraph`" — the as-given build's warnings read 14 + 10 + 10 + 7 = 41 (§ 1.2).
"`row134BaseUA` laid out as 19 leaves in `BaseWalk`" — checked after the merge (stage 2). No mismatch found.

### 1.2 The as-given build (`764cc558`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree: **OK — all 1749 modules already up to date,
nothing built, 7 modules with warnings**, exit 0 (`build/gate/build/20261004T202344Z-2104727.log`; driver log `data/fs131/i5/build-stage1-asgiven.log`).
Every warning is `declaration uses 'sorry'`, 86 in all: wave 5's `Terminal` 14, `Dense` 10, `HexRing` 10, `MapGraph` 7 (41), and wave 4's `BaseSteps` 16,
`Contact` 10, `UnitArc` 19 (wave 4's implementers' own, on their branches).

### 1.3 What I may and may not change

**May** (plan § 10.2; brief § What is yours to decide): add children anywhere in the wave-5 modules (`Chain`, `Terminal`, `Dense`, `HexRing`, `MapGraph`,
and after the merge `BaseWalk`, `BaseDense`); place shared children in `Chain` or in wave 3–4's foundation modules (`Plane/ValidMap/Basic`,
`Plane/LocalMap`, `Plane/LocalStructure`, `Plane/RingGerm`, `Plane/RingBand`), statements unchanged, each with a spec example; add strengthened forms of
wave 4's moves as new lemmas; change imports (updating `ARCHITECTURE.md` and `scripts/Axioms.lean`, my block headed "FS131-I5"); add `cor3_local` as a
new lemma (item 218 (b)). **One ruled statement change, mine to apply**: FS131-E4's repair (b), E4 § 5.2 verbatim (item 227).

**May not**: change any statement of the plan's §§ 3.2, 8.2 or of KB's base plan beyond E4 § 5.2; change any definition of `Chain` beyond E4's two
additions (`UnenclosedC`, `Unenclosed`), or `HexRing`'s or `MapGraph`'s vocabulary; add an `axiom` or `native_decide`; edit wave 4's modules (`Contact`,
`UnitArc`, `BaseSteps`, `SVMap`, `StuckChain`); edit a file while a build of it runs; build except through `scripts/build.sh` under the slot. A leaf that
cannot be proved as written goes to Keryx at once with the reason and the smallest counterexample or missing hypothesis.

## Stage 1 — SAVED

## Stage 2 — SAVED: the merge of `fs131-w5b`

**The merge**: `fs131-w5b` (`49ed9cc4`, FS131-KB's base skeleton) merged into `fs131-w5` as `160b04f6` — the one commit of this job made without paths
(a merge commit records the merged tree; its message says so). **No conflicts**: `fs131-w5b` branched at `764cc558`, and `fs131-w5` since carried only
this job's record and log, so the expected append-only conflicts (`scripts/Axioms.lean`, `Proofs.lean`, `ARCHITECTURE.md`, `Dense.lean`'s moved block)
did not arise.

**The build** of `160b04f6` (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 446 of 446 batches, 4 modules rebuilt (`Dense`, `BaseWalk`, `BaseDense`, `Proofs`),
9 modules with warnings, every warning `declaration uses 'sorry'`**, exit 0 (`build/gate/build/20261004T202434Z-2107187.log`; driver log
`data/fs131/i5/build-stage2-merge.log`). Sorry declarations, 105 in all: wave 5's **60** — `Terminal` 14, `Dense` 5, `HexRing` 10, `MapGraph` 7 (K5's and
K5b's 41, with `row134BaseUA` and its four consumers now in `BaseDense`, 5) and `BaseWalk` 19 (the brief's count, confirmed) — and wave 4's 45.

**Duplicates.** `tools/fs131_qa1_dupes.py` (FS131-QA1's, run as the brief asks): exit 0, 6 names, all wave 1–4 (`data/fs131/i5/qa1-dupes-stage2.txt`) — but
that tool's body table has no wave 5, so it cannot see this merge. So I wrote **`tools/fs131_i5_dupes.py`**, which reuses QA1's declaration reader and asks
whether a name new in wave 5's own files since its fork from wave 4 (`9a8de899`) is declared at the tip of `main`, `fs131-w2`, `fs131-w4`, `fs131-w4c` or
`fs131-ww` in another file, or in the same file without being there at the fork. **Result: 107 new names, 0 collisions**, exit 0
(`data/fs131/i5/i5-dupes-stage2.txt`). Controls: `--self-test` (a faithful body stays quiet; a different-file plant and a same-file plant each fire) OK; the
red control on real data — the same check against `fs131-w5b`, which carries the merged files — reports all 107 names and exits 1, for the stated reason
("same file, added by both since the fork").

**Iteration** (never evidence): `data/fs131/i5/iter.sh` (wave 4's script re-pointed at this worktree, scratch `/home/kooshi/scratch-w5-i5`).

## Stage 2 — SAVED

## Stage 3 — SAVED: FS131-E4's repair (b), applied

**Applied, E4 § 5.2 verbatim** (`plans/FS131-E4-derivation.md` § 5.2, main tree; inventory item 227):

| E4 § 5.2 item | where | read back against E4 |
|---|---|---|
| `UnenclosedC`, `Unenclosed` (definitions and docstrings) | `Plane/ValidMap/Chain`, namespace `ArcMap`, beside `NoInertNear` | verbatim, text and docstrings |
| `Row134BaseUA` gains `F.UnenclosedC u`; the bold sentence gains "and no tile of a colour of `u` enclosing a tile at `u`" | `Chain` | statement verbatim; the bold sentence carries E4's words; the docstring's module pointer corrected (`Dense` → `BaseDense`, where KB moved it) |
| `BaseCtx` gains `unenclosed : F.UnenclosedC u` ("no tile of a colour of `u` encloses a tile at `u`") | `Plane/ValidMap/BaseWalk` | verbatim |
| `exists_eleventh`: statement unchanged, "**GAP as the walk stands**" → "proved from `B.unenclosed` (FS131-E4 E4-RIM)" | `BaseWalk` | statement unchanged; docstring rewritten around E4's words with the argument's address |
| `n3_base` gains `(hE : F.UnenclosedC u)` | `Plane/ValidMap/BaseDense` | verbatim |
| `exists_unenclosed_or_bad` stated (`sorry`) | `BaseDense` | statement verbatim; E4's docstring sentence kept, the argument's outline and address added |
| `localDense`'s proof through `exists_unenclosed_or_bad` (`ρ = 2`) then `n3_base` at `v` | `BaseDense` | **proved** over the two (`closedBall v 2 ⊆ closedBall x 3` by the triangle inequality); statement unchanged |
| `not_row134BaseUA_seven`'s hypothesis list gains `F.UnenclosedC u` | `Plane/ValidMap/Dense` | verbatim; docstring says why the seven-brick corner satisfies it |
| `dense3`, `cv_exists` statements unchanged | `BaseDense` | unchanged (`dense3` now proved from `localDense`, below) |

**The four children** E4 names, stated or proved: `exists_eleventh` from `B.unenclosed` (an existing `sorry` leaf; its route E4-RIM); `exists_unenclosed_or_bad`
(new `sorry`, E4-OUTERMOST); **the pre-bend** as one new child **`exists_preBend`** (new `sorry`: from `Valid`, `Covers u 2`, cubic trichromatic, `BaseHyp u`,
`UnenclosedC u`, a modified fragment with all of those and `NoInertNear u` — KB's owed strengthened-bend child with E4-BEND-UN's clause joined, as E4 says;
its measure is the number of unit arcs meeting `B̄(u, 2)`, which every bend lowers, a bend's new curve not being a unit arc); **`Unenclosed.unenclosedC`**
(proved, by definition). `n3_base` is now **proved** over `exists_preBend` and `row134BaseUA`.

**Spec examples** (Chain): the one-colour plane satisfies `UnenclosedC` (through `Unenclosed`); an adversary — a tile at `v` with a point in a bounded
component of `(cl T)ᶜ` for `T` of a colour at `v` — refutes it.

**A slip found and fixed in K5's `scripts/Axioms.lean` block**: the record `#print axioms HadwigerNelson.Plane.row134BaseUA` names a constant that never existed
(`row134BaseUA` has always been declared inside `namespace ArcMap`, at `764cc558` in `Dense` and now in `BaseDense`): `Unknown constant`, which would fail the
gate's audit. Corrected to `HadwigerNelson.Plane.ArcMap.row134BaseUA` (one line in K5's block, logged here). All 72 wave-5 records now resolve (checked by
compiling every `#print axioms` line of the wave-5 blocks against the iteration oleans). My block, "FS-131 wave 5 (job FS131-I5)", records the three new
declarations.

**Docstrings updated**: `Chain`'s module doc (an enclosure bullet; `Row134BaseUA`'s bullet), `BaseWalk`'s module doc and `BaseCtx`'s, `BaseDense`'s module doc,
`row134BaseUA`'s (the eleventh point from `unenclosed`), `n3_base`'s, `localDense`'s.

**The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 446 of 446 batches, 7 modules rebuilt, 9 with warnings, every warning `declaration uses 'sorry'`**,
exit 0 (driver log `data/fs131/i5/build-stage3-repair.log`). Wave 5's sorry declarations: `BaseDense` 4 (`row134BaseUA`, `exists_preBend`,
`exists_unenclosed_or_bad`, `cv_exists`; `n3_base`, `localDense`, `dense3` now proved over their children), `BaseWalk` 19, `Dense` 5, `HexRing` 10,
`MapGraph` 7, `Terminal` 14 — 59, against 60 before: two children added, three consumers proved.

## Stage 3 — SAVED
