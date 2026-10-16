# FS131-ICT3 — the three-colour criterion to the gate: spec examples, lint, the gate on one commit, the read-aloud, the drafts

*Implementer: de Bruijn (Opus 5.5), job FS131-ICT3, brief `data/fs131/briefs/FS131-ICT3-three-colour.md` (on `main` at
`eeec277b7`). Worktree `.claude/worktrees/kel1`, branch `fs131-ktc1`, at `4ea3653d4` on arrival (FS131-ICT2's last commit
`56c51e6bc` with `main` merged in, no Lean changed). Started 2026-10-16 17:38 UTC. No fence (`plans/FS131-close-inventory.md`
§ Rulings in force, ruling 1). The predecessors' records are `plans/FS131-ICT1-three-colour.md` and
`plans/FS131-ICT2-three-colour.md`; the plan is `plans/FS131-KTC1-three-colour-plan.md`. FS131-ICT2 stopped at a pause Kooshi
called.*

## Theorems this phase proved

The proofs are FS131-ICT1's. This job brings them through the gate: kernel-checked by the gate's build on `810e18698` (branch
`fs131-ktc1`, `main` merged at `c03b81e5e`; gate logs `data/fs131/ict3/gate/`), each on exactly `[propext, Classical.choice,
Quot.sound]` by the audit's receipt. Grade [kernel] for all of them:
- `CayleyThree.colorable_three_iff_bandSet_nonempty` — every abelian group, `0 ∉ S`: 3-colourable ⟺ a band character exists.
- `CayleyThree.colorable_three_iff_exists_isPeriodic` — `A` finitely generated, `S` finite: 3-colourable ⟺ periodically so.
- `CayleyThree.exists_torsion_mem_bandSet`, `CayleyThree.finiteIndex_ker_of_nsmul_eq_zero` — its two steps.
- `CayleyThree.colorable_three_rat`, `CayleyThree.not_isPeriodic_rat` — the control over `ℚ`.
- `CayleyThree.exists_isPeriodic_eqOn`, `CayleyThree.coloring_mem_closure_isPeriodic` — density, for a finite generating `S`.
- `CayleyThree.periodicForcedSubgroup_three_eq_forcedSubgroup`, `CayleyThree.inheritanceQuestion_three` — `P = F` at three colours.
- `CayleyThree.forcedSubgroup_finiteIndex_iff_finite` — every `k`, every `S`: `F` of finite index ⟺ finitely many colourings.
- `CayleyThree.exists_affine_of_forall_three_nsmul` — band characters all of order 3 ⟹ every colouring affine.
- `CayleyThree.colorable_three_iff_of_fg_torsionFree`, `CayleyThree.exists_isPeriodic_eqOn_of_fg_torsionFree` — row 79's class.
- `CayleyThree.mcshane_model` — the McShane layer's model (item 1003's form).
- `CayleyThree.exists_rat_solution_near` — any number of equations, after item 1026's drop.

The other 65 public records of the three modules are kernel-checked by the same build on the same axioms, filed in
`scripts/Axioms.lean`. Five stored statements differ from the skeleton's, each by a ruling: items 1003, 1012 (two) and 1026
(two).

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

## Stage 2 — SAVED: the five spec examples, two ruled binder changes, the build green, lint green

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

### 2.4 The ruling (inventory item 1026), applied; the second build; lint green

**Ruling** (the coordinator's message, about 18:46 UTC): (1) drop `[Finite κ]` from `CayleyThree.exists_rat_solution_near` — a
ruled change, checked by a one-binder re-add; (2) keep the finite-generation binder of
`CayleyThree.exists_isPeriodic_eqOn_of_fg_torsionFree`, renamed `[_hfg : AddGroup.FG A]` — a ruled rename with the hash check.
Applied (`Circular.lean` l. 38, `Density.lean` l. 702; nothing else moved); the modules elaborated with the lakefile's options
(`check-modules.sh ruled`, each exit 0, no warning).

**The second build** (the brief's line, admitted at once, 18:49 UTC): **exit 0, "OK — 735 of 735 batches, 4 module(s) rebuilt,
0 module(s) with warnings, 20m29s"** (`Circular` 5.6 s, `Fibre` 9.9 s, `Density` 9.3 s, `Proofs` 4.9 s;
`data/fs131/ict3/build2.full.log`, `build2.log`); no `sorry`; sources unchanged across it (`build2.sources.md5`, `md5sum -c` OK).

**Lint**: `lake lint --no-build -- --no-build --trace` under the slot, **exit 0, "-- Linting passed for Proofs."**, every one of
the 14 linters `(2/2) Passed` (`data/fs131/ict3/lint2.log`).

**The statements, from the kernel's side** (the dumper on this build, `data/fs131/ict3/statements-ruled.txt.gz`):
- against the dump before (`statements-mid.txt.gz`, § 1.3), constant by constant: exactly two differ, both in their stored
  type — `exists_rat_solution_near` and `exists_isPeriodic_eqOn_of_fg_torsionFree` (`data/fs131/ict3/mid-vs-ruled.out`);
- against the skeleton's (`data/fs131/ict1/statements-before.txt.gz`), by `tools/fs131_ict2_statements.py` with the ReAdd print
  (`data/fs131/ict3/readd-ruled.txt`): **VERDICT CLEAN**, the five ruled changes each checked twice (the undone type's hash is
  the skeleton's, every control differs; the text rule exact), the fifteen listed public helpers added and no other public
  constant, `heightWinding.congr_simp` generated on demand in `Density`, **ten plants all fired**
  (`data/fs131/ict3/statements-ruled-compare.out`).

The comparator and ReAdd were fixed at their first run, each fix with a plant: ReAdd's quoted domains named their free variables
hygienically (`Unknown identifier s✝`), now `$(mkIdent …)`; the comparator's text rule for a dropped binder assumed the rest
was one group (`hadd` precedes `hsub`: rule ARROW); a definition whose `sorry` proof was filled stores an auxiliary
`coloringOneTwo._proof_1` where the skeleton's print erased the proof (rule AUXPROOF, with a plant that replaces it by a constant
that is no proof); and the two kinds of item 1026, DROPINST and RENAME (ReAdd's `insertInstAfter`, `binderAt`), each with a
plant. The audit generator's plant was unreachable once no record was filed, or once all were: it now files and unfiles in
memory (`tools/fs131_ict2_audit_block.py`; its run: all four plants reported, `data/fs131/ict3/audit-plant.out`).

Stage 3 (the gate) starts from a merge of `main`: the coordinator's message of about 19:10 UTC (inventory item 1032) — the
`p`-adic plane landed first (`785a46e77`, gated on `e3e1dbb73`, logs `data/fs131/iqp3/gate/`), so the counts are explained
against its gate.

## Stage 3 — SAVED: the gate on one commit

### 3.1 The merge of `main`, and the build it is gated on

`main` merged at `c03b81e5e` (inventory item 1032: the `p`-adic plane, `785a46e77`). It brings eight new modules
(`PadicPlane/Basic` … `Values`, `Arith/FibreCert7`, `FibreCert7Check`, `FibreCert7Bound`) and edits no existing module; four files
conflicted. `scripts/Axioms.lean` keeps both blocks, `main`'s first. The inventory, the session handoff and the brief script
are taken as on `main`: the conflicts came from the rewritten history, and this job never edited those files. `Proofs.lean` merged
cleanly with both import blocks. Against `main`, the merge differs only in the three modules, their three imports and their
audit block.

The p-adic tree's own build had been deleted at its hand-back (`il5/.lake/build` absent). `main`'s tree holds the gated build of
exactly these sources (`git diff` of `Proofs/` is empty), so it was copied in by checksum (`rsync -a --checksum`, no `--delete`).
The dry run first (`data/fs131/ict3/logs/rsync-dry.txt`) found 72 files that differed: the eight new modules and the root, nothing
else. After the copy a second dry run itemized nothing, and the copied `.olean`s match the source tree by `sha256sum -c`
(`logs/copied-oleans.sha256`). **The build** (the brief's line, `--wait 7200`, admitted 19:19 UTC): **exit 0, "OK — 736 of 736
batches, 1 module(s) rebuilt, 0 module(s) with warnings, 21m28s"**. Only the root was rebuilt (`data/fs131/ict3/build3.full.log`,
`build3.log`); no `sorry`; sources unchanged across it (`build3.sources.md5`).

**The merge moved nothing in the three modules**, from the kernel's side:
- the dump on the merged build is byte-identical to the dump before the merge (`statements-ruled.txt.gz`);
- the ReAdd print is identical (`readd-merged.txt`);
- the axioms print of the 97 records is identical (`axioms-all-merged.txt`);
- the audit generator's `--coverage` passes, "every one of the 81 public records is filed under its class"
  (`audit-coverage-merged.out`);
- `Models.lean` and `SpecControls.lean` elaborate with no message (`logs/models-merged.out`, `logs/controls-merged.out`).

### 3.2 The gate

`data/fs131/ict3/run-gate.sh` (FS131-ICT2's copy of `data/fs131/clone1/run-gate.sh`, its log directory and slot names this
job's) ran on **`810e18698`**: the merge plus one commit of gate inputs and logs (the vacuity baseline's header, the build logs).
`tracked-modified=0` at the start and at the end. The pass ran 19:43–20:01 UTC (`data/fs131/ict3/gate/run-pass.out`), and every
step exited 0:

| step | result | log |
|---|---|---|
| up to date | `lake build --no-build Proofs` exit 0 | `uptodate.log` |
| `sorry` | 0 narrow lines; 5 line-initial `axiom` lines, the library's own, as at the p-adic gate | `sorry-narrow.txt`, `axiom-lines.txt` |
| dupnames, self-test | OK, no name declared by two modules, 31 generated on demand (the same 31 as the p-adic gate); self-test OK | `dupnames*.log` |
| axioms, self-test | **OK — 11,547 records: 10,885 clean, 574 axiom-free, 83 imported, 5 declared purchases**; self-test OK, every planted fault fired and every partner passed | `axioms*.log`, `receipt-axioms.log` |
| vacuity, self-test | **OK — `declarations=22519 refutations-skipped=243 sites=1465`, `vacuous=0 stale=0 declared=3 witnessed=40 generic=1420 unknown=2`**; self-test OK, all 65 controls behaved | `vacuity*.log`, `receipt-vacuity.log` |
| assumptions, self-test | OK — `axioms=3 rests=105 named=19 inline=14 outside=7 ours=21 open=5 takes=109 mentions=2`; self-test OK, all 33 checks behaved | `assumptions*.log` |
| architecture | PASS | `arch.txt` |
| lint | exit 0, "Linting passed for Proofs.", 14 of 14 linters passed | `lint.log` |
| digests | each exit 0. The vacuity baseline's header and the assumptions ledger match (9 of 9); CLAUDE.md's Trust-ledger assumptions counts match. **Flagged stale, not failed:** CLAUDE.md's audit sentence (10804 → 10885) and its § The gate vacuity counts | `digest-*.txt` |

### 3.3 Every count change against the `p`-adic gate (`data/fs131/iqp3/gate/`, gated on `e3e1dbb73`)

- **The audit**: records 11,466 → 11,547 (+81), clean 10,804 → 10,885 (+81). The +81 are the three modules' public records: 17 in
  `Circular`, 40 in `Fibre`, 24 in `Density` (FS131-ICT2's printer `data/fs131/ict2/lean/AxiomsAll.lean` →
  `tools/fs131_ict2_audit_block.py`, filed in `scripts/Axioms.lean`'s CLEAN section under the FS131-ICT3 banner; its 16 private
  records are not audited). Each is exactly `[propext, Classical.choice, Quot.sound]`. Axiom-free (574), imported (83) and
  purchases (5) are unchanged: the landing declares no import, and no record is axiom-free. The axioms self-test's state
  controls read imported 83 and declared 3, which are unmoved.
- **Vacuity**: declarations 22,431 → 22,519 (+88 = 20 + 43 + 25: `data/fs131/ict3/vacuity-new.txt`, the scan's own predicate,
  module by module). Refutations-skipped stays 243 (+0): `not_isPeriodic_rat` concludes `¬ IsPeriodic C`, which the law does not
  skip. Sites 1,458 → 1,465 (+7). Witnessed 38 → 40: `coloringOneTwo` (its own site) and `not_isPeriodic_rat` (by
  `colorable_three_rat`). Generic 1,415 → 1,420: `exists_isPeriodic_eqOn`, `exists_isPeriodic_eqOn_of_fg_torsionFree`,
  `coloring_add_ne`, `circularColoring` and `coloring_mem_closure_isPeriodic`, each `(addCayley S).Coloring (Fin 3)` at a
  parameter `S`. **These counts were written into `scripts/vacuity-baseline.txt`'s header before the run, as predicted from the
  pre-merge preview (+88, +7, +2, +5) and the p-adic gate's counts, and the digest reads them "match (9 of 9)".**
- **Assumptions**: unchanged. The modules take no declared hypothesis and declare none. No structure they take as a hypothesis
  is `undeclared-never-concluded`: `ProperAlong`, `IsTight` and `IsPeriodic` are each concluded by a library theorem.
- **dupnames**: unchanged. The one constant the modules generate on demand, `heightWinding.congr_simp` (in `Density`), is
  generated in no other module.

### 3.4 The structures' models (LEAN.md § The gate)

- `ProperAlong`: `ThreeColour.properAlong_one_two`.
- `Winding`: `ThreeColour.nonempty_winding_one_two`.
- `IsTight`: `isTight_one_two`.
- The McShane layer's hypotheses: `mcshane_model`.
- A colouring at a finite generating set without `0`: `coloringOneTwo`.
- `not_isPeriodic_rat`'s closed carrier: `colorable_three_rat`.

These are library theorems or terms, checked by the gate's build. Two head statements take hypotheses that no single library
model meets all at once. For each, a model is kernel-checked outside the library (`data/fs131/ict3/lean/Models.lean`, elaborated
with no message on the merged build):
- `exists_isPeriodic_eqOn_of_fg_torsionFree` at `ℤ` with `S = {−2, −1, 1, 2}`: finite, symmetric, generating, without `0`, and
  `x ↦ x mod 3` colours it; the theorem is applied there.
- `exists_affine_of_forall_three_nsmul` at `ℤ` along `(1, 2)` with `x ↦ x mod 3`: generation, properness, and every band
  character of order 3 (`three_nsmul_of_mem_bandSet_one_two`: `θ(1) = t` and `θ(2) = 2t` in `[1/3, 2/3]` force
  `t ∈ {1/3, 2/3}`); the theorem is applied there.

The five `GENERIC` sites are the caller's obligation by the scan's law. `coloringOneTwo` inhabits each at `S = {1, 2}` (and
`colS4` at `{±1, ±2}` for the class instance).

### 3.5 `#print axioms` of the head statements (the gate's receipt, `data/fs131/ict3/gate/receipt-axioms.log`)

Each of the following is exactly `[propext, Classical.choice, Quot.sound]`:
- `colorable_three_iff_bandSet_nonempty`, `exists_torsion_mem_bandSet`, `finiteIndex_ker_of_nsmul_eq_zero`;
- `colorable_three_iff_exists_isPeriodic`, `colorable_three_rat`, `not_isPeriodic_rat`, `colorable_three_iff_of_fg_torsionFree`;
- `exists_affine_of_forall_three_nsmul`, `exists_isPeriodic_eqOn`, `coloring_mem_closure_isPeriodic`;
- `periodicForcedSubgroup_three_eq_forcedSubgroup`, `inheritanceQuestion_three`, `forcedSubgroup_finiteIndex_iff_finite`;
- `exists_isPeriodic_eqOn_of_fg_torsionFree`, `mcshane_model`, `exists_rat_solution_near`.

### 3.6 The negative controls, each watched firing

- **The gate's own** (each step's self-test above):
  - axioms: 23 planted faults;
  - vacuity: 65 controls;
  - dupnames: 15 controls;
  - assumptions: 33 checks.
- **Lint**: it went red at stage 2 on exactly the two unread binders, and green once the ruling was applied (`lint1.log` against
  `lint2.log` and the gate's `lint.log`). That is a real fault on these modules, seen firing and seen cleared.
- **The comparator** (`tools/fs131_ict2_statements.py`): ten plants fired.
- **The audit generator**: its four plants were reported.
- **The spec examples**: one drift control each (§ 2.1).
- **The byte-identity checks**: a planted byte was reported.
- **The quote and slot checkers**: each plant missed every quotation.
