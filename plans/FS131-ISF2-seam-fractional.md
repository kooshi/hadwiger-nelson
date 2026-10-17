# FS131-ISF2 — the fractional chromatic number over ℚ(√3, √11): the merge of `main`, the ruled docstring edit, the gate

*de Bruijn, the implementer (Opus 5.5), 2026-10-17. Brief: `data/fs131/briefs/FS131-ISF2-seam-fractional.md` (on `main`,
commit `f45252bf8`). Worktree `.claude/worktrees/kcs1`, branch `fs131-ksf1`, at `39a5dd2a4` when this job started (the
predecessor FS131-ISF1's last commit; its record `plans/FS131-ISF1-seam-fractional.md`). Working files: `data/fs131/isf2/`.*

## Theorems this phase proved

None: every proof was done by FS131-ISF1 (its record's "Theorems this phase proved"). This job merges, edits two docstrings,
and runs the gate; the kernel theorems it gates are listed with their axioms at stage 3.

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations, checked against their sources

`tools/fs131_isf2_quotes.py` (a copy of FS131-ISF1's `fs131_isf1_quotes.py`, its plant moved to the first quote: this brief
has two) takes each block quotation closed by `— source: <path>`, strips the `>` prefixes, collapses whitespace on both sides,
and requires the quote in its source in `main`'s tree or this branch's. Result (`data/fs131/isf2/quote_check.out`): **2 quotes,
2 FOUND, exit 0** — item 1092 (2,312 characters) and item 1089 (2,778), both in `plans/FS131-close-inventory.md` in `main`'s
tree (this branch predates both items). Planted control (`--plant`: `seam-fractional` → `seam-fractionaI` in the first quote):
it reads MISSING with the longest prefix found, exit 1 (`quote_check_plant.out`).

The words the ruled edit replaces are in `main`'s tree as the brief says: `RationalFour/Compulsion.lean` l. 27–28 and
`RationalFour/Forbid.lean` l. 18–19, each `prior art: pending` at a line end and `` `[KubickiLehelMorayne2002]`). `` on the next,
inside the module docstring's **Not claimed** paragraph.

### 1.2 What the merge must keep

The merge has **two merge bases** (`git merge-base --all`): `6ce038671` and `0c47f7b02`, the planner FS131-KFS1's stage 4,
which holds **both** skeletons, Part A's (`RationalFour/*`) and Part B's (`Instances/SeamFractional`). This branch deleted Part
A's skeleton (`eac56a860`, item 1082 ruling 3); FS131-IRF1 deleted Part B's (its stage 1). A trial merge (`git merge-tree
--write-tree`, `data/fs131/isf2/merge-tree-trial.out`) gives seven conflicts:

| file | conflict | resolution |
|---|---|---|
| `RationalFour/Basic`, `Order`, `Compulsion`, `Forbid` | modify/delete (deleted here, proved on `main`) | `main`'s version — byte-equal in `Proofs/`, `Proofs.lean`, `scripts/` and the package files to IRF1's gated `6ab6248fe` (`git diff 6ab6248fe main` empty there) |
| `Instances/SeamFractional` | modify/delete (proved here, deleted on `main`) | this branch's version — equal to stage 4's `4cb2056c4` |
| `Proofs.lean` | content | both sides' import lines |
| `ARCHITECTURE.md` | content | both sides' rows |

Five of these are proof modules, which the brief says to message at once: messaged; the coordinator confirmed the resolution
(item 1094: "the landed RationalFour from main, byte-equal to 6ab6248fe in Proofs/; this branch's SeamFractional; both sides
kept in ARCHITECTURE.md and Proofs.lean"). No proof or statement of either landing changes; the statement dumps show it (stage 2).

The gate's other inputs move on `main` only (`scripts/Axioms.lean`, `scripts/vacuity-baseline.txt`); this branch adds its own
entries to them at stage 3 (the audit block for `Plane/G27/*` and `SeamFractional`, the vacuity header's counts, and whatever
the assumptions step and the controls ask).

**Build files.** The worktree's `.lake/build` is FS131-ISF1's green build of `39a5dd2a4` (the G27 modules, up to about 5 GB
each to compile, are in it and unchanged by the merge). `main`'s modules that this branch does not have are the four
`RationalFour` modules; their compiled files come from the main tree's build (current for `main`: FS131-IRF1's gated build,
moved there, item 1089), by checksum, those four modules only. `Compulsion` and `Forbid` then recompile for the docstring edit,
and the root for its imports.

### 1.3 The edit

In `Proofs/HadwigerNelson/RationalFour/Compulsion.lean` and `RationalFour/Forbid.lean`, the module docstrings only:
"prior art: pending `[KubickiLehelMorayne2002]`" → "prior art: not found in print (FS131-PAS2, FS131-PAS3;
`CLOSED-QUESTIONS.md` § 3)". Nothing else in them. Shown twice (`LEAN.md` § Searching — Lean, FS131-LC1): in text, the files
with every block comment removed are the same as `main`'s; from the kernel's side, a dump of the two modules made before the
build and after it.

### 1.4 The order of work

1. Merge `main`; resolve as in 1.2; the docstring edit; copy `main`'s four `RationalFour` builds in by checksum (listing
   before and after); the statement dump **before** the build (the merged tree's `SeamFractional`, the four hand-written
   `Plane/G27` modules and the four `RationalFour` modules, from the compiled files as given); the build under the slot; the
   dump **after**; the comparisons — before against after, `SeamFractional`/`G27` against FS131-ISF1's
   `statements-after.txt.gz`, `RationalFour` against FS131-IRF1's. A saved stage.
2. The gate on one commit: the audit block (`data/fs131/isf1/lean/AxiomsAll.lean` over `data/fs131/isf1/modules.txt`), the
   controls, the vacuity header, the assumptions ledger, then the steps of `data/fs131/clone1/run-gate.sh` copied under
   `data/fs131/isf2/`; every count change explained against `main`'s last gate (`data/fs131/irf1/gate/`); the new vacuity
   sites with each structure hypothesis's inhabitant named; `#print axioms` of every head. A saved stage.
3. The drafts' counts, restated with their slots. The report.

## Stage 2 — SAVED: the merge, the edit, the build green; no statement moved

### 2.1 The merge (`6b9fc22ef`)

`git merge main` (`main` at `1c8e07920`: `f45252bf8` and the inventory line for item 1094) stopped on the seven conflicts of
§ 1.2, resolved as ruled. `ARCHITECTURE.md` and `Proofs.lean` by `data/fs131/isf2/scripts/union_conflicts.py` (each block ours
then theirs; it refuses a diff3 base section): `ARCHITECTURE.md` block 1, `main`'s four `RationalFour` rows (ours empty);
block 2, this branch's 52 rows (`SeamFractional` and the 51 `Plane/G27/*`; theirs empty); `Proofs.lean`, the branch's two
imports then `main`'s one. The five modify/delete conflicts by `git add` of the version left in the tree, each checked equal:
the four `RationalFour` files `git diff --quiet main` (and `main` equals FS131-IRF1's gated `6ab6248fe` in `Proofs/`,
`scripts/` and the package files), `SeamFractional` `git diff --quiet HEAD`. The index before the commit held only paths
where `main` differs from the branch. After it: the tree differs from `main` in exactly this branch's 53 files (`Proofs.lean`,
`SeamFractional`, the 51 `G27` modules) and from the branch's `39a5dd2a4` (with stage 1) in exactly `main`'s four modules,
`Proofs.lean`, `scripts/Axioms.lean`, `scripts/vacuity-baseline.txt` and `main`'s plans. `tools/check_architecture.py` PASS
(`data/fs131/isf2/arch-merge.out`).

### 2.2 The edit (`d3d9afafa`)

`data/fs131/isf2/docstring-edit.diff`: in each module docstring's **Not claimed** paragraph, `(prior art: pending` /
`` `[KubickiLehelMorayne2002]`). `` became `(prior art: not found in print` / `` (FS131-PAS2, FS131-PAS3; `CLOSED-QUESTIONS.md`
§ 3)). `` — two lines in each file, nothing else. The ruling's words are taken literally, so the sentence closes two
parentheses (`novelty (prior art: not found in print (…))`). **In text:** `tools/fs131_isf2_code_only.py` (FS131-IDG1's tool,
copied) reads both files SAME as `main` once block comments are removed (16,323 and 6,558 code characters; comment characters
8,741 → 8,776 and 2,966 → 3,001, `code-only.out`); its plant (the last `:=` made `:≡`) reads both DIFFERS, exit 0
(`code-only-plant.out`). `[KubickiLehelMorayne2002]` still appears in `Compulsion`'s structure clause (Thm 4.3's rigidity),
which the ruling does not touch; `Forbid` no longer names the key.

### 2.3 The build files

`data/fs131/isf2/scripts/copy_build.sh`: the 32 files of `main`'s tree under `.lake/build/{lib/lean,ir}/…/RationalFour/`
(listed in `logs/copy-files.txt`) copied by `rsync -a --checksum --files-from`, nothing else. Checksums before and after
(`logs/copy-*.sha256`): the worktree's copies after the copy equal `main`'s before it, and `main`'s were unchanged during it.
Of the 32, 12 (the `ir/` C files) were already byte-equal to the worktree's stale skeleton builds and 20 (`lib/lean/`) were
replaced. A manifest of every compiled `.olean` was taken before the build (`logs/oleans-before.sha256`, 2,269 files).

### 2.4 The statements before the build

`data/fs131/isf2/lean/StatementDump.lean` (FS131-ISF1's dumper with `main`'s four modules added; its body is FS131-IRF1's line
for line) printed every constant of nine modules from the compiled files as given: `SeamFractional`, `G27.Check`, `Sound`,
`Law`, `Bound` and `RationalFour.Basic`, `Order`, `Compulsion`, `Forbid` (`statements-before.txt.gz`, 625 constants, 337 of
them internal). The comparator `tools/fs131_isf2_statements.py` is strict: every constant, internal ones included, with the
same header (kind, name, flags), stored type, value and proof-erased value; anything changed, missing or added fails. Against
the two landings' own last dumps (`statements-before-vs-isf1.out`, `statements-before-vs-irf1.out`): **423 of 423 SAME** in
the five modules of this branch against FS131-ISF1's `statements-after.txt.gz`, **202 of 202 SAME** in the four `RationalFour`
modules against FS131-IRF1's — so the compiled files the merge started from are exactly each landing's.

### 2.5 The build

`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 scripts/slot.py --mem 16 --cpus 10 -- env MEMMAX=16G BATCH=4 ./scripts/build.sh`
(`data/fs131/isf2/build1.log`; the build's own log `build/gate/build/20261017T025153Z-2359804.log`): up-to-date check exit 3;
**OK — 579 of 579 batches, 3 modules rebuilt** (`RationalFour.Compulsion` 3.6 s, `RationalFour.Forbid` 1.8 s, `Proofs` 2.0 s),
**0 modules with warnings**, 13 m 58 s. The manifest after (`logs/oleans-after1.sha256`): exactly those three `.olean`s
changed — `Compulsion` and `Forbid` (a docstring is environment data), the root (its imports) — and the other 2,266 are
byte-identical with unchanged times; the 47 generated `G27` modules were not recompiled.

### 2.6 The statements after the build

The same dumper on the build (`statements-after.txt.gz`) is **byte-identical** to the print before it. The comparator, before
against after with its four plants (`statements-before-vs-after.out`): **625 of 625 SAME**, and each plant fired by name with
nothing else new — one character of `RationalFour.forall_coloring_eq_iff`'s stored type (CHANGED, TYPE), the head
`fractionalChromaticNumber_seamPlane` dropped (MISSING), one character of `G27.val`'s proof-erased value (CHANGED, DATA), a
constant added to `Forbid` (ADDED). Against the landings' dumps again (`statements-after-vs-isf1.out`,
`statements-after-vs-irf1.out`): 423 of 423 and 202 of 202 SAME. So the merge and the edit moved no stored constant of either
landing — `SeamFractional`'s and `G27`'s statements are FS131-ISF1's, `RationalFour`'s are FS131-IRF1's.

## Stage 3 — SAVED: the gate, green on `31df25939`

### 3.1 The gate's inputs (`31df25939`)

* **`scripts/Axioms.lean`**: one CLEAN block, just above the PURCHASED banner after FS131-IRF1's, of **485 records**
  (`data/fs131/isf2/audit.clean.lean`). Generated from the kernel's print of every record of the 52 modules
  (`data/fs131/isf2/lean/AxiomsAll.lean`, FS131-ISF1's copy of FS131-LGT1's printer → `axioms-all.txt`: 497 records, no
  `sorryAx`) by `tools/fs131_isf2_audit_block.py` (FS131-IRF1's generator, plus one positive control: the printer's planted
  imported record `Rigidity.positive_entropy_rigidity_of_polishSpace` must be read with its import, or the run stops BLIND).
  Every public record is CLEAN: 89 on the standard three, 27 on `[propext, Quot.sound]`, 214 on `[propext]`, 155 axiom-free
  (SeamFractional 7, `G27.Sound` 69, `Law` 73, `Check` 34, `All` 13, `Data` 11, `Bound` 7, `RootData` 6, `RootSort` 1, the 43
  `Rows`/`Chk`/`St` modules 264); 12 private records are not audited. `--coverage` after filing: all 485 filed under their class
  (`audit-coverage.out`). Controls: `--plant` (an unknown axiom, a `sorryAx`, a declared import, a misfiled record) — all four
  reported, exit 1 (`audit-plant.out`); the print without its planted line — BLIND, exit 2 (`audit-blind-control.out`). The
  records include ten `f.eq_def` equation lemmas, as 37 earlier records do.
* **`scripts/vacuity-baseline.txt`**'s header: `declarations=23377  refutations-skipped=247  sites=1477` (the second line
  unchanged), reconciled in 3.3.
* **Unchanged**, each by reading: `scripts/axioms-controls.txt` (its `baseline` and `imported_declared` controls read only the
  imported and declared counts; this landing adds neither), `scripts/assumptions-ledger.txt` (the step's rows are identical to
  `main`'s gate, 3.3), `ARCHITECTURE.md` (both sides' rows, 2.1; no § Trust line: no purchase), `Proofs.lean` (2.1).

### 3.2 The run (`data/fs131/isf2/run-gate.sh`, launched from a snapshot `build/isf2/snap/run-gate.sh`; logs `data/fs131/isf2/gate/`)

`HEAD=31df2593996ad1e0f64dde8138f19bfa66bd64a2`, 03:43:45 → 03:57:52 UTC, **every step exit 0**: up to date (4 s); `sorry`
(narrow) **0 lines**; line-initial `axiom` lines 5 (`main`'s, unchanged); `dupnames` OK (31 generated on demand, unchanged) and
its self-test (15 controls: every planted fault fired, every partner passed); `axioms` OK and its self-test (264 s, every planted
fault fired, every partner passed); `vacuity` OK and its self-test (65 controls); `assumptions` OK and its self-test (33 checks);
`check_architecture` PASS; `lake lint` — `-- Linting passed for Proofs.`, 14 linters `(2/2) Passed!`; the three digests exit 0.
Tracked files modified during the pass: 0 (`run-pass.out`).

### 3.3 Every count, against `main`'s last gate (`data/fs131/irf1/gate/`, FS131-IRF1 on `6ab6248fe`)

| count | `main` | here | why |
|---|---|---|---|
| audit records | 11,806 | 12,291 | +485: the 52 modules' public theorems and definitions, filed CLEAN (3.1) |
| clean / axiom-free / imported / purchases | 11,106 / 575 / 120 / 5 | 11,436 / 730 / 120 / 5 | +330 clean (89 on the standard three, 27 on `[propext, Quot.sound]`, 214 on `[propext]`), +155 axiom-free; nothing else moves |
| vacuity `declarations` | 22,802 | 23,377 | +575 = the 485 records + 55 equation lemmas `f.eq_n` Lean generated on demand + 11 matchers `f.match_n` + 24 proof-term matchers `thm.match_1_k` (destructuring in term-mode proofs, `LEAN.md`'s FS131-ICS1 line); read by name with the scan's own filter (`data/fs131/isf2/lean/ScanCount.lean` → `scan-count.txt`: `SCANNED-COUNT 575`) |
| `refutations-skipped` | 246 | 247 | +1: `G27.conj_indep` — its stated conclusion is the membership `(fun x => c (conjR x)) ∈ IndepSets seamField`, which the reducing telescope reads through to `… → False`; it refutes nothing (the class `LEAN.md` names for FS124-L2). Its one hypothesis `c ∈ IndepSets seamField` holds at `c = fun _ => false` |
| `sites` / `witnessed` / `generic` / `unknown` / `declared` / `vacuous` / `stale` | 1,477 / 52 / 1,420 / 2 / 3 / 0 / 0 | the same | no new site; every SITE, EVIDENCE, DECLARED and UNKNOWN row identical to `main`'s gate (1,566 rows, `receipt-compare.out`) |
| assumptions (nine counts) | `axioms=3 rests=168 named=19 inline=14 outside=7 ours=21 open=5 takes=109 mentions=2` | the same, `fails=0` | every row identical to `main`'s gate (1,954 rows); `unseen` 21,950 → 22,054 (+104: hypotheses of the new theorems over their own variables, read and not decided; `cohyp` 80 unchanged) |
| dupnames, generated on demand | 31 | 31 | none doubled |

**Every one of `main`'s 11,806 audit prints is here unchanged** (each print joined to one line, `data/fs131/isf2/scripts/join_prints.py`,
compared under `LC_ALL=C`: 0 missing, 485 new, every new one a `G27` or `SeamFractional` record; `receipt-compare.out`).

**The structure hypotheses, each with its inhabitant** — the scan reads no site in these modules (no binder is a carrier it
tracks), so the landing names them (`LEAN.md` § The gate):
* `μ : IndepLaw seamField` — in `IndepLaw.density_le_quarter_seamField`, `G27.density_le_quarter`, `G27.density_le_of_cert`
  and `Law`'s section variable: inhabited by `Collapse.nonempty_indepLaw` (`[NumberField F] → Nonempty (IndepLaw F)`, a library
  theorem) at `seamField`'s instance `numberField_seamField`; the heads' own proof takes one from `Collapse.exists_indepLaw`.
* `c ∈ IndepSets seamField` (`G27.conj_indep`, `indepFrom_mk`): the constant map `fun _ => false`.
* `density_le_of_cert`'s `hrows`, `hfit`, `hbound`: conditions on its own `rows` and `coefs`, met by the certificate —
  `G27.density_le_quarter` discharges them at the generated rows (`segs_ok`, `cert_bound`).
* `cert_bound`'s `IndepFrom adjL 0 U`: holds at `U = 0` (no point chosen), and at every `mk c` by `indepFrom_mk`.
* The formers `WfAdj`, `IndepFrom`, `SegsOk` are concluded by `wfAdj_of_wfB`, `indepFrom_mk`, `segs_ok`; none stands for an
  assumption (the assumptions step: no new declared or undeclared former, `fails=0`).

### 3.4 `#print axioms` of every head (`data/fs131/isf2/lean/HeadAxioms.lean` → `head-axioms.txt`, `pp.fullNames`)

On the gated build: `fractionalChromaticNumber_seamPlane`, `finIndepRatio_seamPlane`, `iSup_fractionalChromaticNumber_seamPlane`,
`IndepLaw.density_le_quarter_seamField`, `numberField_seamField`, `G27.density_le_quarter`, `G27.density_le_of_cert`,
`G27.cert_bound` — `[propext, Classical.choice, Quot.sound]`; `G27.good_root` (the kernel's DFS) — `[propext, Quot.sound]`; the
seven `RationalFour` heads the edit recompiled (`forall_coloring_eq_iff`, `forall_coloring_ne_iff`,
`exists_coloring_eq_and_ne_iff`, `exists_equiv_coloring_add_eq_residue`, `coloring_eq_of_eqOn_isOpen`,
`exists_coloring_forbidding_iff`, `exists_coloring_forbidding_iff_padicValRat`) — the standard three. **No outside theorem.**
Positive control in the same file: `Rigidity.positive_entropy_rigidity_of_polishSpace` prints its import
`HadwigerNelson.Rigidity.positive_entropy_rigidity`.

### 3.5 Negative controls watched

The four self-tests above, in this pass. Mine: the quotation check (stage 1), the code-only check (2.2), the statement
comparator's four plants (2.6), the audit generator's four plants and its BLIND control (3.1). **The lint's control** (FS131-IRF1
left it unrun): `isf2LintPlant [Inhabited ℕ] : ℕ := 0`, with a docstring, planted in `RationalFour/Forbid` (a leaf; working tree
only, never committed); the build rebuilt `Forbid` and the root, 0 warnings, 14 m 14 s; the lint **exit 1**, exactly one error,
`unusedArguments` at `Forbid.lean:181` naming `@HadwigerNelson.RationalFour.isf2LintPlant` and its argument `[Inhabited ℕ]`, the
other 13 linters passed (`data/fs131/isf2/lintplant/lint-planted.log`). Restored by `git checkout` (the source's hash equal to
its hash before the plant); rebuilt (2 modules, 0 warnings, 13 m 58 s); the lint exit 0; **every one of the 2,269 compiled
`.olean`s byte-identical to build 1's** (`logs/oleans-after-restore.sha256`), so stage 2's dumps describe the gated build.
`check_architecture`'s control was not planted here: FS131-IRF1 planted it, and `tools/check_architecture.py` is unchanged
since (last changed `acda212b0`, 2026-09-22; IRF1's `data/fs131/irf1/plants/arch-plant.out`).
