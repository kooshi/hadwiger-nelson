# FS131-KN7 — the five-colour chain, next: the declared printed theorem against its page, lane N typed, the ergodic decomposition measured, the next modules planned

*de Bruijn, the planner; the third on this chain, after FS131-KN3 and FS131-KN6. Brief: `data/fs131/briefs/FS131-KN7-chain-next.md`
(on `main`). Branch `fs131-wk7`, cut from `fs131-wch` at `afd9df200`, in the worktree `.claude/worktrees/fs131-wq1`. Claims:
`data/fs131/claims-NF2.md`. Stands on `plans/FS131-KN6-chain-first-layer.md` (cited KN6 § n), `plans/FS131-KN3-chain-plan.md`
(KN3 § n) and the deriver's `plans/FS131-EN2-derivation.md` (EN2 § n). Working files: `data/fs131/kn7/`.*

## Theorems this phase proved

None in the library: this job writes no proof into a module before the coordinator's ruling on the declared theorem.
Kernel-checked in scratch files only (`data/fs131/kn7/lean/`, against this tree's built library; not modules, not
imported by any), each on the standard three axioms unless said — evidence for the finding of Stage 2:

- `kn7_borel_le_quotient` — the Borel σ-algebra of `X ⧸ G` is contained in Mathlib's quotient σ-algebra, for every
  topological group `X` with Borel sets — `data/fs131/kn7/lean/DeclaredRead.lean`
- `KN7Scratch.ksEntropy_map_mono`, `entropy_borel_le_quotient`, `current_clause_four_implies_r1` — the entropy on the
  factor for the Borel σ-algebra is at most the entropy for the quotient σ-algebra; so the declared clause (4) implies
  the page's — `data/fs131/kn7/lean/RepairR1.lean`
- `KN7Scratch.positive_entropy_rigidity_of_polishSpace` — from the proposed repair R1 (a scratch axiom), the declared
  statement word for word, for Polish `X` (axioms: the standard three and the scratch axiom) — the same file

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_kn7_readback.py` (the method of `tools/fs131_kn6_readback.py`, for this brief): every line `> <text>` of the
brief whose next line is `> — source: <path>` must be one whole line of that file, character for character. Run against
`main`'s tree, where the brief and its sources live:

- `quotations=4 identical=4 differing=0`, exit 0 (`data/fs131/kn7/logs/readback.out`): W2
  (`data/fs131/REQUEST-2026-10-13.md`); NF2-NC and the dated line of 2026-10-14 on the headline's eight hypotheses
  (`data/fs131/claims-NF2.md`); item 722 (`plans/FS131-close-inventory.md`).
- Control (`--plant`: the last character of every matching source line changed in memory): `identical=0 differing=4`,
  exit 1 (`readback-control.out`).
- The quotations inside item 722 that it attributes to the last planner — "the quotient σ-algebra on `X/G_j` is asserted
  Borel from a Mathlib instance that `IsSolenoid X` does not supply", "`ErgodicDecomposition`'s used cone is unmeasured
  (declared: 28 files, 22,632 lines); it decides whether M7's one port input is hours or days", "\"ergodic\" is strict
  invariance, formally the stronger axiom, equal to the textbook's by an argument that is not a theorem here" — each
  found verbatim in `data/fs131/reports/FS131-KN6.md` on branch `fs131-wch` (`grep -F`).

No mismatch: nothing for the coordinator from the readback of text.

### 1.2 The compiled library, brought up to date by copy, and the first build

- **From where**: `.claude/worktrees/fs131-wnf/.lake/build/`. Its `HEAD` is `1e9014443` before and after the copy, its
  work tree clean (`logs/wnf-head-{before,after}.txt`, `wnf-status-{before,after}.txt`, both empty); `git diff
  1e9014443 fs131-wk7 -- Proofs Proofs.lean lakefile.toml lean-toolchain lake-manifest.json` names only the four
  `Rigidity/` modules and `Proofs.lean`. Nothing was written or run in that tree.
- **How**: `rsync -a --checksum` with no `--delete`. Dry run before: 990 lines, of which 121 `.olean` — 1 absent here, 6
  differing in content, 114 identical in content with another time (`logs/rsync-dry-before.out`); the copy
  (`rsync-real.out`, 03:31:52–03:31:54 UTC, `copy-times.txt`); dry run after: **0 lines** (`rsync-dry-after.out`).
- **The manifest** after the copy and before the build: SHA-256 of the 1,908 `.olean`
  (`logs/olean-manifest-after-copy.sha256`). After the build `sha256sum -c` reports one file changed, `Proofs.olean` —
  the root, which the build rebuilt (`logs/manifest-check-1.out`); the four `Rigidity/` modules were absent from the
  manifest and are the build's own.
- **The build** (`data/fs131/kn7/build.sh 1 8`: `./scripts/build.sh` under the slot, `--mem 10 --cpus 4`, `MEMMAX=10G`,
  `BATCH=8`): `==> build: OK — 249 of 249 batches, 5 module(s) rebuilt, 3 module(s) with warnings, 7m21s`, `exit=0`
  (`logs/build-1.log`); rebuilt `Rigidity.Solenoid`, `Rigidity.Entropy`, `Rigidity.PositiveEntropy`, `Rigidity.ChainAtTA`,
  `Proofs`; fifteen warnings, each `declaration uses 'sorry'` (`Entropy` 8, `PositiveEntropy` 1, `ChainAtTA` 6), no other.
  Wall 676 s by the wrapper's clock, of which about four minutes waiting for the slot behind two other jobs; memory
  sample 4.29 GiB summed, 3.39 GiB the largest process (5-second samples, `logs/build-1.times`).

### 1.3 The declared statement, read from the kernel's side

`data/fs131/kn7/lean/DeclaredRead.lean`, elaborated against the built tree (`logs/lean-declared-read.log`, exit 0):

- **Unchanged since the last planner.** The default print of `@positive_entropy_rigidity` (the same `open` lines as its
  file) is character for character KN6's print (`data/fs131/kn6/logs/FirstLayerCheck-after.log`): `old=1765 new=1765
  IDENTICAL`, exit 0 (`tools/fs131_kn7_axiom_print.py`, `logs/axiom-print-compare.out`); control (one `ksEntropy` made
  `ksEntropyOn` in memory): `DIFFER`, exit 1 (`axiom-print-compare-control.out`). `tools/fs131_kn3_axiom_binders.py`
  on the new print: the four instance binders `AddCommGroup X`, `TopologicalSpace X`, `MeasurableSpace X`, `BorelSpace X`.
- **With every implicit and instance argument shown** (`pp.explicit`): `ksEntropy` occurs **once**, at line 134 of the
  print, after the existential at line 18 — in the conclusion, as the left side of `= 0`; no hypothesis mentions an
  entropy. The hypothesis `herg` is `ZdAction.IsErgodicOn … ⊤ μ` (line 12); clause (1) is `IsErgodicOn … Λ (ν j)`, in the
  conclusion (line 42).
- **The σ-algebra on `X ⧸ G j`** in clause (4) — both in `ksEntropy`'s implicit argument and in `Measure.map`'s codomain —
  is `@QuotientAddGroup.measurableSpace X (AddCommGroup.toAddGroup X inst) (G j)` (lines 140, 149). The stored type's
  93 constants (`run_cmd`, `getUsedConstants`) include `QuotientAddGroup.measurableSpace` and **neither `borel` nor any
  `BorelSpace` instance on a quotient**; `BorelSpace` occurs once, as the binder on `X`.

### 1.4 What the last planner left for this job, restated (KN6 § Stage 6)

The four items of `LEAN.md` § Assumptions for `Rigidity.positive_entropy_rigidity`:
1. *Docstring*: names the key, Thm 1.3, § 1.1, pp. 2–3 of arXiv:2101.11120v1, and the sense and direction of its
   entropy. Lacks the journal's page numbers.
2. *Read-back*: KN3 § 5.3's table and KN6 § 5.2's table for the entropy. Lacks a second reader against the page, to be
   told four things: (a) the entropy is the infimum form, occurring once, in the conclusion, as `= 0`; (b) three senses
   the page leaves open — "no virtually cyclic factors" (FS105-VC's forced sense, the axiom's residual trust), "ergodic"
   as triviality of the strictly invariant sets (formally the stronger axiom, equal to the textbook's for a countable
   group by an argument not in the library), the `ν j` as probability measures; (c) **the factor's σ-algebra**: asserted
   Borel in KN3's table from `QuotientAddGroup.borelSpace`, which needs `PolishSpace X`, not supplied by `IsSolenoid X`;
   (d) "compact" as Hausdorff, `d ≥ 2` explicit, every binder in the signature.
3. *A model*: `positive_entropy_rigidity_model`, degenerate (the one-point solenoid). Lacks PE-1′ (module M6).
4. *`ARCHITECTURE.md` § Trust and the audit*: nothing written on a skeleton. Owed at the first landing that proves a record
   from the axiom.

Item 2 (c) is this job's item 2; (a) and the "ergodic" sense of (b) are read in Stage 2 with it.

