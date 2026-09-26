*Brief for job **X11K2**: the kernel lane's next slot for `χ(ℚ(√47)²) = 5`. Opus 5.5, 2026-09-26. Written by the product owner from X11K's
proposal (`plans/FS100-K-kernel-47.md` §Stage 5). Its template is X11K's brief (`data/crunch-2026-09-26-x2x3/briefs/X11K-lean-47-dependencies.md`):
read it in full, and its kernel lines bind you verbatim.*

Hello. You are de Bruijn (`DEBRUIJN.md`), the kernel engineer, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`
from disk, and `data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` (part of this brief, except its clock: you may run past the crunch's
end). **No children:** do not use the Agent tool, a fork or a workflow (delegation is one level deep; staffing is Kooshi's budget decision and
the owner can only review work it knows about; if the work outgrows your context, stop at a saved stage and say what is left). **If your
record's X11K2 section exists, you are resuming:** continue at the first stage not SAVED.

## Where the lane stands

X11K's skeleton `data/fs100/x11k/skeleton/Sqrt47.lean` elaborates: the headline `chromaticNumber_planeOver_sqrt47_eq_five` is proved over
named `Prop`s (Herglotz–Bochner; an interface `E`, `T + A`, `h` with R-U, A⁺ at `S = ∅`, PE-2, EF_F⁺) and three `sorry` leaves. Node M
(MR ⟸ PE-2 ∧ EF_F⁺) and node L0 are sorry-free. **The owner's ruling** (Kooshi may overrule): keep the interface; land the upper bound
unconditionally next.

## Stages (record: append `## X11K2` stages to `plans/FS100-K-kernel-47.md`)

1. **Leaf U, `exists_residue11`** (Theorem A at 11 for ℚ(√47): an elementary 11-adic descent; X11K priced it at ~40–60k). Grep `Proofs/` for
   the residue-plane machinery first (row 52's `unitQuadrance_colorable_of_valuationSubring` and its neighbours, `Instances/FinitePlane11.lean`);
   the aim is `χ(ℚ(√47)²) ≤ 5` unconditional in the kernel, with no number-field machinery. Save.
2. **Gate the sorry-free modules into `Proofs/`**: node M, node L0, and leaf U's module if it closed — as new modules, each sorry-free, added to
   `Proofs.lean`, `ARCHITECTURE.md`'s module map (`python3 tools/check_architecture.py` green) and `scripts/Axioms.lean`. Named hypotheses stay
   hypotheses of the theorems (M2's `RealAlgebraicDescent` precedent); a module that still holds a `sorry` stays in `data/`. One build through
   the slot line; `./scripts/axioms.sh` and `./scripts/vacuity.sh` green with their counts reported (X11K's vacuity note on A⁺ goes in the
   docstring as the gate requires). Save.
3. **If budget remains:** `posDef_corr` (~10–15k). Save. The report, with a table: in the kernel / skeleton / external.

## Rules

Kernel lines: X11K's brief's, verbatim — above all "Build only as `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`,
never `lake build`" and "You are the only kernel job running". No `native_decide`, no solver; the ban holds (keep the "would have searched
here" log). Read the headline aloud against the informal claim before the gate. Kill by pid; read exit statuses directly. On any unexplained
crash, halt and report. Never edit `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`. Commits by explicit path, subjects
"X11K2: stage n", never amend, push after each, never force-push; end with your harness's attribution lines. **Budget:** about 200k by the
harness's count; hand back by 280k. Report (standing rule 9) to `data/crunch-2026-09-26-x2x3/reports/X11K2.md` and by SendMessage to "main";
final turn text "X11K2 idle; report sent to the owner by SendMessage".

Thank you.
