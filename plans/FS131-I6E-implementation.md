# FS131-I6E — wave 6's bridge: what every fan carries (`FanBridge`'s five `Fan` lemmas)

*de Bruijn, the implementer (Opus 5.5), on branch `fs131-w6g` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g`, at
`d62406a2` when started (the branch as fast-forwarded by the brief's Amendment 1). Brief: `data/fs131/briefs/FS131-I6E-wave6-bridge.md`
(main tree; its Amendment 1 of 2026-10-06 is part of it). Started 2026-10-06.*

## Theorems this phase proved

*Filled stage by stage; each line names the declaration, its axioms as printed from the build's oleans, and the entry it was read against.
"Wired" means proved here over a leaf that is still `sorry` on this branch — not yet a kernel theorem.*

(none yet — Stage 1 is the readback)

## What I may and may not change

- **Mine**: the proofs of five leaves of `Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean`, in `namespace AeColouring.Fan` —
  `two_le_n`, `col_ne`, `branch_outside_discs`, `branch_contacts`, `sector_alone`; new helper declarations under names no other module
  declares, placed after the header `## What every fan carries under saturation` and before `namespace Fan`, or between my own leaves —
  never above `gamma`; one docstring line of `branch_contacts` (its alternative is inclusive: the deriver's § 6.1); a block "FS131-I6E" in
  `scripts/Axioms.lean`; this record; `tools/fs131_i6e_*.py`; `data/fs131/i6e/`; `data/fs131/reports/FS131-I6E.md`.
- **Not mine**: any statement or definition; the seven other leaves of `FanBridge` (`gamma`, `IsUnitCurve.exists_polarGraph`, `beta`,
  `alpha`, `fan_of_isolated`, `regJLiteral_of_saturated`, `finite_arcs_of_isBounded` — another implementer's, on `fs131-w6f`; they stay
  `sorry` here, and my theorems that rest on `gamma` and `exists_polarGraph` are **wired**, not kernel theorems, until that branch
  lands); `Basic`, `Pinch`, `MapColouring`, `Fan`, `FanExamples`, `Curve`, `LocalGraph`; the planners' record; `main`. No `axiom`, no
  `native_decide`. No merge, no gate.
- **Owned by ruling 531 (c)** (Amendment 1): the three cell lemmas of a fan, each a declaration of its own, named in the report.

## Stage 1 — SAVED (FS131-I6E): the readback, the as-given build, the statement check, the expectations

**Quotations** (standing rule 3): `tools/fs131_i6e_quotes.py` — 23 quotations, 23 exact (`data/fs131/i6e/logs/quotes-1.out`); with
`--plant` it reports one mismatch and exits 1 (`quotes-1-plant.out`).

**Read, in order**: the brief and its amendment; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` §§ Building, Make the gate
fail; `FanBridge.lean`, `Fan.lean`, `Basic.lean`, `Pinch.lean` whole; the statements of `Curve.lean`, `LocalGraph.lean`,
`FanExamples.lean` (their proofs not read); the planners' record Stages 9–12 whole; the deriver's record Stage 3 (§§ 3.1–3.8, with the
erratum and the note) and Stage 6 (§§ 6.1–6.5) whole; `plans/FS121-V2-verification.md` §§ 1.3–2.4 whole. Not read: the planners'
Stages 1–8 (the first pass's Stages 3 and 5 are superseded for my leaves by Stage 9, which I read), the other FS-121 arguments.

**The as-given build** (`d62406a2`): OK — 466 of 466 batches, 4 modules rebuilt, 3 modules with warnings, exit 0
(`data/fs131/i6e/logs/build-0-as-given.log`, the driver's; the tool's full output copied to `build-0-as-given-full.log`). Twenty distinct
`declaration uses sorry` warnings: `FanBridge` 12 (five mine), `Pinch` 7, `MapColouring` 1 — as Amendment 1 says.

**The statement check** (`tools/fs131_i6e_statements.py`, base `d62406a2`): the 17 statements of `FanBridge` verbatim; the seven leaves
that are not mine still `sorry`; the seven files that are not mine byte-identical; no `axiom`, no `native_decide` — 0 failures
(`logs/statements-1.out`); `--plant` reports one `CHANGED` and exits 1. It allows docstring lines to change and nothing between
`theorem` and `:=`.

**Registered expectations** (before any proof was compiled; informed by the plan and the deriver's Stage 6):

| # | expectation |
|---|---|
| Z1 | `two_le_n` and `col_ne` close in one stage with no polar-coordinates integral: the branch is null because the essential boundary of a measurable set is null (Lebesgue's theorem for the set and its complement), not by the plan's image-of-a-graph route — 0.8 |
| Z2 | none of the five statements is false or short of a hypothesis — 0.85 (the deriver checked them) |
| Z3 | `branch_outside_discs` and `branch_contacts` are **wired** over `gamma` and `IsUnitCurve.exists_polarGraph` only (not `beta`, `alpha`) — 0.9 |
| Z4 | the plan's price for the first two leaves (1 d each) is high by a factor of three or more — 0.7 |
| Z5 | I close four of the five leaves inside the budget, `sector_alone` at least to its three cell lemmas and Lemma H — 0.5 |
| Z6 | `sector_alone` needs `θ₁ ≤ π` nowhere: the positive-angle case closes from the two edge contacts and the cyclic order alone — 0.6 (my sketch) |
