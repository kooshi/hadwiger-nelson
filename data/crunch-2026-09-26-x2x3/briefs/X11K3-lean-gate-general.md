*Brief for job **X11K3**: the kernel lane's next slot — gate what is sorry-free, then the next leaf. Opus 5.5, 2026-09-26, 07:0x. Written by the
product owner from X11K2's hand-off (`plans/FS100-K-kernel-47.md` §X11K2 Stage 1R). Its templates are X11K's and X11K2's briefs
(`data/crunch-2026-09-26-x2x3/briefs/X11K-lean-47-dependencies.md`, `X11K2-lean-47-gate-and-upper-bound.md`): read both; their kernel lines bind
you verbatim.*

Hello. You are de Bruijn (`DEBRUIJN.md`), the kernel engineer, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`
from disk, and `data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` (part of this brief, except its clock: you may run past the crunch's end).
**No children:** no Agent tool, fork or workflow (delegation is one level deep; staffing is Kooshi's budget decision and the owner can only
review work it knows about; if the work outgrows your context, stop at a saved stage and say what is left). If your record's `## X11K3` section
exists, you are resuming.

## Kooshi's target (verbatim)

> "The target for the Lean implementation should move to the more general "every real" claim."

## Where the lane stands (read `plans/FS100-K-kernel-47.md` §X11K and §X11K2 in full first)

- `data/fs100/x11k/skeleton/SqrtFortySeven.lean`: `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five` — `χ(ℚ(√47)²) ≤ 5`,
  **unconditional**, standard three axioms, sorry-free, by an elementary 11-adic descent; not yet in `Proofs/`.
- `data/fs100/x11k/skeleton/Sqrt47.lean` Part G: the every-real headline `X11K.min_localBound_five_le_chromaticNumber` —
  `min(L(F), 5) ≤ χ(F²)` for every real number field, with `L(F)` defined through Mathlib's number-field API — proved over named inputs
  (the count, split totally-real / complex place; A⁺; R-U; MR; CLS; row 99; Bochner) and depending on two `sorry` leaves, **L1** and
  **`posDef_corr`**. Node M and L0 are sorry-free. X29C (wave 3's close) ruled the complex-place step at two derivations: an independence-ratio
  upper bound survives removing edges, so the complex place's factor is bounded by its circle subgraph's `m₁`.

## Stages (append `## X11K3` stages to `plans/FS100-K-kernel-47.md`)

1. **Gate into `Proofs/`**: `SqrtFortySeven` and every sorry-free declaration of Parts L/G (with their named hypotheses as hypotheses, M2's
   `RealAlgebraicDescent` precedent) as new modules — each added to `Proofs.lean`, to `ARCHITECTURE.md`'s module map
   (`python3 tools/check_architecture.py` green) and to `scripts/Axioms.lean`. One build through the slot line; `./scripts/axioms.sh` and
   `./scripts/vacuity.sh` green with their counts reported; an inhabitant per structure hypothesis or a `VACUITY DECLARED:` docstring where the
   gate requires one. Read each headline aloud against the informal claim first. Save.
2. **`posDef_corr`** (~10–15k by X11K's price). Save.
3. **If budget remains, L1**, or price it honestly. Save. The report: a table — in `Proofs/` / skeleton / external — and the next slot.

## Rules

Kernel lines verbatim from X11K's brief — above all "Build only as `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`,
never `lake build`" and "You are the only kernel job running". No `native_decide`, no solver; the ban holds (keep the "would have searched here"
log). Kill by pid; read exit statuses directly. On any unexplained crash, halt and report. Never edit `CLAUDE.md`, `LEDGER.md`,
`plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`. Commits by explicit path, subjects "X11K3: stage n", never amend, push after each, never
force-push; end with your harness's attribution lines. **Budget:** about 200k by the harness's count; hand back by 280k. Report (standing rule
9) to `data/crunch-2026-09-26-x2x3/reports/X11K3.md` and by SendMessage to "main"; final turn text "X11K3 idle; report sent to the owner by
SendMessage".

Thank you.
