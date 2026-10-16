# FS131-IRU1 — the ring of unit vectors in the kernel: Lemma C′, the components clause and the dichotomy (implementer)

*Implementer: de Bruijn (FS131-IRU1), on branch `fs131-kru1` in the worktree `.claude/worktrees/il5`, from `e27c45182` (the
planner's skeleton with `main` merged in). Brief: `data/fs131/briefs/FS131-IRU1-ring.md` (on `main` at `fe00e94d1`). The plan:
`plans/FS131-KRU1-ring-plan.md`. Nothing in this milestone is blind.*

## Theorems this phase proved

None yet.

## Stage 1 — SAVED: the readback

### 1.1 Quotations

All ten block quotations of the brief are verbatim in their named sources: `data/fs131/iru1/quote_check.py` (after the
planner's `data/fs131/kru1/quote_check.py`) strips the `> ` prefix, collapses whitespace and searches the source, read from
this worktree (the skeleton modules exist only on this branch). Run 2026-10-16 20:56 UTC: `ALL VERBATIM`, exit 0
(`data/fs131/iru1/quote_check.out`): W2 (278 chars), `LEDGER.md` row 100 (3,453), the five Lean statements (135, 167, 61, 184,
137), inventory items 1044 (3,246), 1040 (2,287) and 1025 (2,276). Planted control (`--plant`: one character changed in the
first and the last quotation): exactly quotations 0 and 9 reported `MISMATCH`, the others `OK`, `PLANT FIRED`, exit 0
(`quote_check_plant.out`). No mismatch: no finding about the brief.

The brief's other figures, checked against the skeleton: **40 leaves** — `Rigidity/NormOneGen` 6, `Rigidity/UnitRingEq` 10,
`Rigidity/UsablePrime` 11, `Rigidity/PlaneComponents` 9, `Instances/UnitRingModels` 4 (the module's `example` is proved by a
term); the five head statements at the lines inventory item 1044 names. **FS131-ICS1's bridge** (`UpperHalf.exists_stablePrime_card_eq_sq`,
`Arith/StableAboveUsable`) is not on `main` at `fe00e94d1` (grep of `Proofs/`, 2026-10-16 20:55 UTC): I take the plan's
fallback (`exists_stablePrime_natCast_mem` by `Arith.placeHom_base` and row 105's prime inversion), as the brief directs.

### 1.2 The target, the rulings, the order of work

**The target.** Replace each of the 40 `sorry`s of the five skeleton modules by a proof, changing no stored statement; make
public the three private lemmas of `Rigidity/AdmissiblePrime` that route E reads (`exists_integral_primitive`,
`exists_dvd_of_dvd_exponent`, `nonempty_residueHom`), each with the plan's § 3.7 item 1 docstring, in my first build; then the
full gate on one commit. The head statements: Lemma C′ as typed (`Rigidity.unitRing_eq_stableIntegers`), its odd part at every
real number field (`Rigidity.exists_two_pow_mul_mem_unitRing`), `F(i)` has a stable prime at every real number field
(`Rigidity.nonempty_stablePrime`), the dichotomy at every subfield of `ℝ` (`Rigidity.connected_or_infinite_planeOver`) and C8,
the components clause at every real number field (`Rigidity.infinite_connectedComponent_planeOver`).

**The rulings I work under** (inventory items 1044, 1040, 1025, quoted in the brief):
1. *`AdmissiblePrime`'s three private lemmas made public* — a ruled change of stored names (the three constants and their
   generated internals move from `_private.….0.` to public names, LEAN.md l. 369); their stored types must not change.
2. *The dichotomy rides* — `connected_or_infinite_planeOver`, `connected_planeOver_iff_isEmpty_stablePrime` are proved here.
3. *One implementer, sequential*: one branch, one gate.
4. *The elementary route E*, no outside theorem: the stable prime at every real number field from a usable prime of degree one
   found by the sign change of a minimal polynomial at its real root.
5. *History*: commits by explicit path on `fs131-kru1`, never pushed; the commit hook's privacy guard is obeyed, never
   bypassed.

**Not mine:** any stored statement of the skeleton or of `main` beyond the ruled `AdmissiblePrime` edit — a statement that
cannot be proved as typed goes to the coordinator, never edited.

**The order of work** (the plan's, § 3.5): module 1 (`NormOneGen`, Mathlib only), with the `AdmissiblePrime` edit in the first
build; module 2 (`UnitRingEq`); module 3 (`UsablePrime`); module 4 (`PlaneComponents`); module 5 (`UnitRingModels`). A saved stage
after each module's build. Iteration on a scratch farm (a symlink copy of the compiled library, `build/iru1-farm`), never in
`.lake/build`; the builds through `scripts/build.sh` under the slot, with the brief's command line.

### 1.3 The statement dump, before any proof edit

Taken at 2026-10-16 20:56 UTC from the planner's compiled modules as they stand (`lake build --no-build` under the slot: only
the root `Proofs` out of date, `data/fs131/iru1/uptodate0.log`), before any edit of any source:
`data/fs131/iru1/lean/StatementDump.lean` (FS131-ICO2's dumper, module list changed: the five skeleton modules and
`Rigidity/AdmissiblePrime`) → `data/fs131/iru1/statements-before.txt.gz` (166 lines; `AdmissiblePrime` 33 constants,
`NormOneGen` 6, `UnitRingEq` 14, `UsablePrime` 11, `PlaneComponents` 9, `UnitRingModels` 4). The sources it was made from:
`data/fs131/iru1/skeleton-sources.md5`.
