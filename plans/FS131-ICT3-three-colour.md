# FS131-ICT3 — the three-colour criterion to the gate: spec examples, lint, the gate on one commit, the read-aloud, the drafts

*Implementer: de Bruijn (Opus 5.5), job FS131-ICT3, brief `data/fs131/briefs/FS131-ICT3-three-colour.md` (on `main` at
`eeec277b7`). Worktree `.claude/worktrees/kel1`, branch `fs131-ktc1`, at `4ea3653d4` on arrival (FS131-ICT2's last commit
`56c51e6bc` with `main` merged in, no Lean changed). Started 2026-10-16 17:38 UTC. No fence (`plans/FS131-close-inventory.md`
§ Rulings in force, ruling 1). The predecessors' records are `plans/FS131-ICT1-three-colour.md` and
`plans/FS131-ICT2-three-colour.md`; the plan is `plans/FS131-KTC1-three-colour-plan.md`. FS131-ICT2 stopped at a pause Kooshi
called.*

## Theorems this phase proved

None yet: the mathematics was proved by FS131-ICT1; this job gates it. Filled in at the gate.

## Stage 1 — SAVED: the readback

### 1.1 The quotations of the brief, checked against their sources

`tools/fs131_ict3_quotes.py` (FS131-ICT2's checker with this brief's path; each quotation, as a contiguous block of whole
lines, against its source in this worktree and in the main tree): `data/fs131/ict3/quote_check.out` — **4 quotations, 0
mismatched** (inventory items 1019, 1020, 1012 and 1003 of `plans/FS131-close-inventory.md`, each found in both trees). Its
control (`--plant`: one character changed in the longest line of each quotation) reports all four
(`data/fs131/ict3/quote_check_plant.out`, exit 0).

The brief's statements of where the work stands, checked on the branch:
- `git diff 56c51e6bc HEAD -- Proofs/ Proofs.lean lakefile.toml lean-toolchain lake-manifest.json scripts/` is empty: the two
  merges of `main` since FS131-ICT2's stage carried no Lean and no gate script.
- FS131-ICT2's build: `data/fs131/ict2/build1.full.log` ends `build: OK — 735 of 735 batches, 4 module(s) rebuilt, 0 module(s)
  with warnings, 17m41s` and `exit=0`; `md5sum -c data/fs131/ict2/build1.sources.md5` reads OK for the three modules and
  `Proofs.lean`. So `.lake/build` holds the build of exactly these sources.
- The two ruled drops (item 1012) are in the source: `even_pmHeight_sub_sum` (`Fibre.lean` l. 179) is
  `(x : Fin m → ℤ) : Even (pmHeight s c x - ∑ j, x j)` with no `hc`, its three call sites in `Density.lean` (ll. 462, 463, 473)
  passing `(s := s) (c := c)`; `exists_le_mul_of_imp_eq_zero` (l. 430) takes `M`, `hsub`, `g`, `t`, `hg`, `ht`, `h0` and no
  `hadd`, its docstring reading "closed under differences of comparable elements", its call site (l. 523) passing no `hMadd`.
  `grep -cw sorry` reads 0 in each of the three modules.

### 1.2 What is left, and the order

FS131-ICT2's § 2.4, step 1 done (its § 2.2), corrected by the brief: the five spec examples come first, since they are a
source edit and the gate's build must include them.
1. **The spec examples** — one `example` for each of `circularColoring`, `tightSet`, `fibre`, `Winding.flip`, `coloringOneTwo`
   that fails if the definition drifts; the build (`./scripts/build.sh` under the slot, the brief's line); then `lake lint
   --no-build -- --no-build --trace` under the slot — a saved stage.
2. **The gate on one commit**: the statement dumps (`data/fs131/ict2/lean/StatementDump.lean`, `ReAdd.lean`) and the
   comparison against `data/fs131/ict1/statements-before.txt.gz` with the three ruled changes and the new helper constants
   (`tools/fs131_ict2_statements.py`, its plants first); the audit block (`data/fs131/ict2/lean/AxiomsAll.lean` →
   `tools/fs131_ict2_audit_block.py`, its plant, the block into `scripts/Axioms.lean`, `--coverage`); the vacuity scan's new
   sites with each structure's inhabitant (`data/fs131/ict2/lean/VacuityNew.lean`); the `ARCHITECTURE.md` rows; commit; then
   `data/fs131/ict2/run-gate.sh`'s steps on that commit with logs under `data/fs131/ict3/gate/`, every count against
   `data/fs131/ico2/gate/` (gated on `7c72b9bf7`); `#print axioms` of every head statement — a saved stage.
3. **The read-aloud** of each head statement against ledger row 79, with what is not claimed — a saved stage.
4. **The drafts** for the front files (plan § 3.8 brought to what is proved; "prior art not yet searched" where a novelty
   line would go, item 1000) — a saved stage.
5. **The report.**

### 1.3 A statement dump before the first rebuild

LEAN.md § Searching — Lean (FS124-I2): print every constant of the modules from the build as given, before the first rebuild
replaces the `.olean`s. `data/fs131/ict2/lean/StatementDump.lean` against FS131-ICT2's build, 2026-10-16 17:42 UTC:
`data/fs131/ict3/statements-mid.txt` (195 constants: `Circular` 38, `Fibre` 108, `Density` 49). This is the print of the
statements as FS131-ICT2 left them; the spec examples add no stored constant, so the print after the rebuild must equal it.

## Stage 2 — SAVED (partly): the five spec examples, the build green, lint red on two skeleton statements (ruling asked)

### 2.1 The spec examples

One `example` each, in the modules' spec sections (`--` comments; no stored constant), each pinning the definition at a model
where a drift changes the value:
- `circularColoring` (`Circular.lean`, end): the circular colouring of `x ↦ x/3` on `ℤ`, step `1`, colours `2` with `2`.
- `tightSet` (`Fibre.lean`, end): at `(1, 2)` with `x ↦ x mod 3` it is every direction (the tight relation `(2, −1)` moves both,
  `isTight_one_two`); at `(1, 1)` with `x ↦ x mod 3` it is empty (every relation `k·(1, −1)` rises by `−|k|` against a winding of
  `0`, so none is tight).
- `Winding.flip` (`Fibre.lean`): at `(2, −1)` the flip of the winding of `x ↦ x mod 3` is `1`, and the flip of the flip `0`.
- `fibre` (`Fibre.lean`): the fibre of the winding of `x ↦ x mod 3` along `(1, 2)` is the one point `(1/3, 2/3)` (the relations
  are `ℤ·(2, −1)`, the winding vanishes on them, and `2x₀ = x₁` meets `[1/3, 2/3]²` once).
- `coloringOneTwo` (`Density.lean`, end): `5 ↦ 2`, `−1 ↦ 2`, `3 ↦ 0`.

**Their controls** (`data/fs131/ict3/lean/SpecControls.lean`, elaborated with exit 0, `data/fs131/ict3/logs/controls1.out`): for
each definition a drifted copy, and a kernel proof that the example's statement is **false** at the drift — the circular
colouring shifted by one step (`≠ 2` at `2`: it is `0`); the tight set with tightness dropped (`≠ ∅` along `(1, 1)`: `(1, −1)`
moves direction `0`); the fibre with the relation constraint dropped (`≠ {(1/3, 2/3)}`: `(1/2, 1/2)` is in the box); the flip as
`Σ r + W r` and as `−W r` (the pair `1, 0` fails: `1, 2` and `0, 0`); the colouring `x ↦ (x + 1) mod 3` (the three values fail).
Iteration first (never evidence): `data/fs131/ict3/lean/SpecScratch.lean` against FS131-ICT2's build, then the three modules'
text with the lakefile's options, writing nothing (`data/fs131/ict3/check-modules.sh`: each exit 0, no warning).

### 2.2 The build

`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 scripts/slot.py --mem 8 --cpus 5 --wait 7200 -- env MEMMAX=8G BATCH=3
./scripts/build.sh`, queued 17:59 UTC behind two other implementers' slots, admitted 18:07:55, **exit 0: "OK — 735 of 735
batches, 4 module(s) rebuilt, 0 module(s) with warnings, 23m35s"** (`Circular` 6.3 s, `Fibre` 12 s, `Density` 10 s, `Proofs`
5.4 s; `data/fs131/ict3/build1.full.log`, the tool's log copied to `data/fs131/ict3/build1.log`); `grep -c "declaration uses
'sorry'"` = 0; the one `error:` line is the up-to-date check's own; `md5sum -c data/fs131/ict3/build1.sources.md5` OK (the
three modules and `Proofs.lean` unchanged across the build).

**The stored statements did not move**: the dump after the build (`data/fs131/ict3/statements-after.txt`) is byte-identical to
the dump before it (`statements-mid.txt.gz`, § 1.3) — `cmp` silent; its control, one byte planted on line 5 of a copy, reported
at byte 9268.

### 2.3 Lint: two skeleton statements carry an unread instance binder (ruling asked)

`lake lint --no-build -- --no-build --trace` under the slot: **exit 1**, `unusedArguments` failed, "Found 2 errors in 19513
declarations" (`data/fs131/ict3/lint1.log`), every other linter passed:
- `CayleyThree.exists_rat_solution_near` (`Circular.lean` l. 38): argument 4, `[Finite κ]`, read by no proof — the rational point
  solves every equation `k` at once, so the statement holds for any index set of equations;
- `CayleyThree.exists_isPeriodic_eqOn_of_fg_torsionFree` (`Density.lean` l. 702): argument 3, `[AddGroup.FG A]` — row 79's class,
  which density does not read (it needs `S` finite generating); the skeleton names the class's other unread hypotheses with
  underscores (`_htf`, `_hsymm`, `_hS`), not this one.
Both are the skeleton's text, unchanged; the build's linters do not report an unused instance binder, so FS131-ICT1 and -ICT2
never met them. **Sent to the coordinator at once** (2026-10-16, about 18:36 UTC), with a suggestion: drop `[Finite κ]` (item
998's kind) and rename the second to `[_hfg : AddGroup.FG A]` (part of row 79's class as cited; the stored type moves only in a
binder name). Waiting for the ruling; the gate's other inputs go on meanwhile.
