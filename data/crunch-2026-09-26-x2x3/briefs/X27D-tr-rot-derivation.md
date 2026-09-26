*Brief for job **X27D**: a derivation on TR-ROT, the one step between MR and row 88's measure half at the type-(B) fields. Opus 5.5, 2026-09-26,
06:53. Written by the product owner; X22D and X22V (blind) named the step independently. A blind second mind, X27V, runs beside you on the
same claims; never contact it. **Stop at 12:50 UTC**, whatever is left.*

Hello. You are de Bruijn (`DEBRUIJN.md`), a derivation agent, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. Read
`CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` is part of this brief; read it
in full** (its clock is replaced by the stop above). If your record exists, you are resuming: continue at the first stage not SAVED.

## The question, and why now

Over ℚ(√59), ℚ(√83), ℚ(√131), row 88 asks whether four-colour rigidity holds (`LEDGER.md` row 88; G76). Given MR — now held at [hand] grade for
every real number field (rows 120–121) — X22D and X22V proved that every **rotation- and translation-invariant** random four-colouring is a
pullback from the tight place (X22D-QR, X22V-F2), and that every four-colouring outside Pull is rigid-motion-transient (X22D-TRM, X22V-R). What
is left of the measure half (Q-μ) is one step about measures that are only **translation**-invariant. Either answer counts (standing rule 4): a
proof closes Q-μ; a counterexample shape or a GAP at a named step says where row 88 must be fought.

## Read first, from disk

`plans/FS100-X22D-derivation.md` (all of it: §2.2–§2.4 say why MR does not reach TR-ROT) and `plans/FS100-X22V-verification.md` §2.1–§2.3,
§3.3; `LEDGER.md` rows 88, 111, 112, 113, 120; `plans/R88-derivation.md` (T-B1, T-J38-2's statements and Theorem C); the FS-98 stub
`plans/STUB-ultrametric-continuation.md`. The papers on amenable actions and Følner averages the records cite (`[BergelsonMoragues2021]`
among them; grep `BIBLIOGRAPHY.md` and `~/source/library/` before calling anything unheld).

## The claims (verbatim)

- **TR-ROT** (from `plans/FS100-X22D-derivation.md` §2.4). "Over a type-(B) field, no translation-invariant random four-colouring `μ` with
  `μ(Pull) = 0` has every `U`-Følner average converge onto Pull" (equivalently, by X22D-RT: none is rotationally transient).
- **TR-ROT-flip** (G79's move, posed by the owner). "Every translation-invariant random four-colouring `μ` of a type-(B) field's plane carries a
  quantity, invariant under translation and continuous under weak-* limits, that is zero on Pull and positive whenever `μ(Pull) = 0`." Name one
  such quantity, or show that none of a stated kind can exist.

## Stages

1. The quotation check; a C0 probability per claim, sealed before any derivation. Save.
2. TR-ROT: TRUE, FALSE (with the shape a counterexample must have), or GAP at a named step. Save.
3. TR-ROT-flip, the same; the write-up with "Theorems this phase proved"; the report.

**Do not lean toward TRUE.** A GAP at a named step is a complete result.

## Rules

- **No subagents, forks or workflows** — delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the
  owner can only review work it knows about.
- The ban on finite-witness search holds (to 2026-10-01): keep a "would have searched here" log. Exact checks of seconds are fine, each with a
  planted fault watched firing (`tools/x27d_*.py`).
- Record `plans/FS100-X27D-derivation.md`; working files `data/fs100/x27d/`. Never edit `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`,
  `BIBLIOGRAPHY.md` or another job's files. Neutral commit subjects ("X27D: stage n"); never amend; push after each commit (on a ref-lock race,
  `sleep 4` and retry); never force-push; end with your harness's attribution lines.
- **Budget:** about 200k by the harness's count; hand back by 280k.
- Report (standing rule 9) to `data/crunch-2026-09-26-x2x3/reports/X27D.md`, committed, and by SendMessage to "main"; final turn text "X27D idle;
  report sent to the owner by SendMessage".

Thank you.
