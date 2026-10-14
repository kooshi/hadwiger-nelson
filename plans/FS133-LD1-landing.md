# FS133-LD1 — the density equality landed through the full gate, after the port

*de Bruijn, the implementer; job FS133-LD1 (brief: `data/fs133/briefs/FS133-LD1-landing.md`, on `main`). Branch
`fs133-wl1`, cut from `110f1c923` (FS133-IPQ1's head, branch `fs133-wpq`) in the worktree `.claude/worktrees/fs133-wk1`.
The recipe is `plans/FS131-KO1-port-plan.md` § 4.5 on `main` (steps 1–9; step 0 done, inventory item 798). Working
files: `data/fs133/ld1/`; the gate's logs `data/fs133/ld1/gate/`. "Std" is `[propext, Classical.choice, Quot.sound]`.*

## Theorems this phase proved

None of its own: this job proves no new theorem. It lands FS-133's module (FS133-K1's statements, FS133-IA1 to
FS133-IPQ1's proofs) through the gate; the kernel theorems it lands are listed, with their axioms as the gate prints
them, in the stage that reads them aloud.

## Stage 1 — SAVED (FS133-LD1): the readback, and the dump before the merge

**1.1 The brief's quotations.** `tools/fs133_ld1_readback.py` (FS133-IPQ1's reader with this job's brief; each quoted
line a substring of its source, read in the coordinator's tree): **11 matched, 0 mismatched**, exit 0
(`data/fs133/ld1/readback-brief.out`) — W2 against `data/fs131/REQUEST-2026-10-13.md`; K133-ONE, K133-FN, K133-PAIR,
K133-NC-ONE and K133-NC-ALL against `data/fs133/claims-K1.md`; inventory items 779, 789, 798, 840 and 841 against
`plans/FS131-close-inventory.md`. With `--fault` (the last character of each quoted line changed): 0 matched, 11
mismatched, exit 1 (`readback-brief-fault.out`). No finding about the brief's quotations.

**1.2 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole as it stands on `main` (§ Assumptions,
§ Trust ledger and § The gate among it); `RUNNING.md` § Building and § Make the gate fail; the recipe
(`plans/FS131-KO1-port-plan.md` §§ 4.4–4.6, on `main`); FS133-IPQ1's record whole and FS133-ICD1's record whole (this
tree).

**1.3 The build before the merge** is current: `lake build --no-build` under the slot reads `All targets up-to-date
(6048 jobs)`, exit 0, with no warning replayed (`data/fs133/ld1/nobuild-before.log`; 4.9 s, 0.9 GiB).

**1.4 Recipe step 1 — every constant of the modules, from this tree's build, before the merge.**
`data/fs133/ld1/lean/StatementDump.lean`: FS132-I2's dumper body as FS133-IPQ1 used it, copied by `sed` unchanged, and
a driver that reads its module list from a file and, for the second side of the join, a list of names to be found
wherever they are then declared. Before the merge it dumps nine modules — the eight of the density equality
(`Outside/OAI158Rigidity` and the seven of `Plane/OneClass`) and `Outside/OAI158Transfer`, which the join deletes, so
that its constants can be found again in the port: `data/fs133/ld1/moved/before.out.xz` (sha256 of the text in
`before.sha256`; 11.9 s, 3.5 GiB resident) — **245 constants: `OAI158Rigidity` 10 named and 4 private,
`OAI158Transfer` 50 named (two of them the generated `approxField.congr_simp`, `approxIndex.congr_simp`),
`SectionDensity` 9 and 3, `Defs` 53 and 4, `InvariantLaw` 9 and 19, `Field` 1 and 30, `Algebraic` 9 and 1,
`Fractional` 7 and 11, `Pair` 19 and 6**; no `ABSENT`. Rigidity's ten named: the six copied definitions
(`Spectral.E`, `K`, `DiscreteE`, `kCoeff`, `ContinuousVectors.op`, `space`), the derived
`Spectral.instCommGroupDiscreteE`, the `axiom` `Spectral.residual_fourier`, and `residual_fourier_cross`,
`residual_fourier_model`.

**The dumper is faithful to the last implementer's**: FS133-IPQ1's reader, `--strict`, its built dump
(`data/fs133/ipq1/moved/built.out.xz`) against this one: **181 constants of the seven `Plane/OneClass` modules, 181
IDENTICAL**, the 64 of Rigidity and Transfer new on this side (`moved/ipq1built-vs-before.txt`).
