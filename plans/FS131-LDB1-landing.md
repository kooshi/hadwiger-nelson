# FS131-LDB1 — the density bound `m₁(ℝ²) ≤ 0.2470` landed through the full gate

*de Bruijn, the implementer (Opus 5.5), 2026-10-14; job FS131-LDB1 (brief: `data/fs131/briefs/FS131-LDB1-landing.md`, on
`main`), with `plans/STANDING-RULES.md`. Branch `fs131-wldb`, cut from `fs131-wdb3` at `9fe574044` in the worktree
`.claude/worktrees/fs131-w10g`. Working files `data/fs131/ldb1/`; the gate's logs `data/fs131/ldb1/gate/`. "Std" is
`[propext, Classical.choice, Quot.sound]`. Resuming: read this file, check its last SAVED stage against `git log --
plans/FS131-LDB1-landing.md`, continue at the first stage not saved.*

## Theorems this phase proved

No new theorem is this job's: it lands the density bound (FS131-KDB1's statements; FS131-IDB1, -IDB2 and -IDB3's proofs)
through the gate. Its headline, as the four jobs left it, is `HadwigerNelson.Plane.oneAvoidingDensityBound :
Plane.OneAvoidingDensityBound` (`Plane/DensityBound/Theorem`) — `[AmbrusEtAl2023]` Theorem 1 — whose axioms the gate's
audit prints (stage 5).

## Stage 1 — SAVED (FS131-LDB1): the readback, and the dump before the merge

**1.1 The brief's quotations.** `tools/fs131_ldb1_readback.py` (FS133-LD1's reader with this job's brief, and the one
inline quotation, W6, added): **7 matched, 0 mismatched**, exit 0 (`data/fs131/ldb1/readback-brief.out`) — W2 and W6
against `data/fs131/REQUEST-2026-10-13.md`; the dated line of 2026-10-14 against `data/fs131/claims-NF2.md`; inventory
items 845, 866, 895 and 911 against `plans/FS131-close-inventory.md`, each read in the coordinator's tree. With `--fault`
(the last character of each quoted line changed): 0 matched, 7 mismatched, exit 1 (`readback-brief-fault.out`). No
finding about the brief's quotations.

**1.2 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole as it stands on `main` (§ Assumptions,
§ Trust ledger and § The gate among it); `RUNNING.md` § Building and § Make the gate fail; the last landing's record
(`plans/FS133-LD1-landing.md` on `main`, whole) and its pass script (`data/fs133/ld1/run-gate.sh`); FS131-IDB3's record
whole; the other three records' drafts as each is cited below. `main` stood at `7c8f9af82` when merged (the brief named
`dca30637f`; the three commits between touch only `data/fs131/briefs/`, `plans/FS131-close-inventory.md` and
`plans/SESSION-HANDOFF-2026-10-14.md`, none of which the gate reads).

**1.3 The trial merge** (`git merge-tree --write-tree --name-only HEAD main`, `data/fs131/ldb1/trial-merge.out`): exit 0,
**no conflict** — `ARCHITECTURE.md` and `Proofs.lean` merge by themselves. Since the merge base (`432c6f7cf`) this branch
adds 83 modules (`Plane/DensityBound/*`, `Plane/DensityBound/Cells/*`, `Plane/OneAvoidingDensity`) and edits
`ARCHITECTURE.md` and `Proofs.lean` only; `main` brings the port's 31 generated modules, `Outside/OAI158Collapse`, the
eight of the density equality, `Plane/LebesgueNumber`, `Plane/RadiusOutside`, and the gate's scripts
(`scripts/Axioms.lean`, `Assumptions.lean`, `assumptions-ledger.txt`, `axioms-controls.txt`, `vacuity-baseline.txt`).

**1.4 The build before the merge is current**: `lake build --no-build Proofs` under the slot reads `All targets
up-to-date (6096 jobs)`, exit 0 (`data/fs131/ldb1/nobuild-before.log`; 3.5 s, 0.88 GiB).

**1.5 Every constant of the density bound, from this tree's build, before the merge.**
`data/fs131/ldb1/lean/StatementDump.lean` (FS131-IDB3's dumper, its import made the headline's module and its count 83)
→ `statements-before.txt`: **83 modules, 4,083 constants** (kind, full name, stored type; a definition's value by hash),
exit 0 (5.1 s, 3.02 GiB). Its reader `tools/fs131_ldb1_statement_diff.py` (FS131-IDB3's, the count changed),
`--self-test` on this dump: the faithful copy 0 findings over 4,083 constants, each of the four plants FIRED, `SELF-TEST
PASS` (`statements-selftest.out`). **Faithful to the last implementer's**: the 56 modules of FS131-IDB3's dump after its
last build (`data/fs131/idb3/statements-after.txt`) are identical line for line to the same modules here
(`statements-vs-idb3.out`: 56 of 56; the 27 others are lane X's own).

**1.6 Noted for the coordinator, not this merge's**: `Plane/OneAvoidingDensity` came to this line from `fs131-wkr`
(`affb9142e`, "text unchanged"), and FS131-IDB2 proved its one leaf here. `fs131-wkr` (`3fabd5e10`) still holds the
file with its `sorry` (sha256 `b5f55c5e…` against this branch's `72b78784…`): wherever the chain's line carries that copy,
the join of the two lines meets the module twice at one path, and should keep this branch's.
