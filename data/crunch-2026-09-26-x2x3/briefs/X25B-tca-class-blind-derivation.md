*Brief for job **X25B**: a blind second derivation of the one single-mind link under `χ = 5` at ℚ(√143), ℚ(√311), ℚ(√335). Opus 5.5,
2026-09-26, 06:38. Written by the product owner on X21D's suggestion. Template: X12B's brief (`X12B-ef-plus-blind-derivation.md`). **Stop at
12:50 UTC**, whatever is left.*

Hello. You are Coxeter, a second mind, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md`
and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` is part of this brief; read it in full** (its clock is
replaced by the stop above). If your record exists, you are resuming: continue at the first stage not SAVED.

## Why

Given MR, `χ(F²) ≥ 5` follows from SP-Cor wherever T-C(A) holds at `S = ∅` (FS100-K0). At ℚ(√47) T-C(A) has two blind derivations. For the
rest of the `L ≥ 5` family of real quadratic fields — ℚ(√143), ℚ(√311), ℚ(√335), ℚ(√167) and the rest — it rests on the **class form**, which
one mind derived. You are the second, blind.

## Blind — the fences (the whole job)

Do not open: the proofs in `plans/R88-derivation.md` (its entries' **statements** in bold are open; everything below each statement is
fenced); `plans/FS86-row88-rigidity.md` and `plans/FS86-row88-PA-close.md`; anything under `data/fs86r88/` and `data/fs86/`;
`tools/crunch_j28*.py`; the proofs of FS100-T1 and FS100-K0 in `plans/FS100-derivation.md` (statements open); `plans/FS100-three-field-lemma.md`
§1.4 and §R-close; `plans/FS100-J51V-verification.md` §2.7; `tools/j51_tca_class.py`, `tools/j51v_class.py`; `plans/FS100-X21D-derivation.md`,
`plans/FS100-X21V-verification.md`, `data/fs100/x21d/`, `data/fs100/x21v/`; the reports `data/crunch-2026-09-26-x2x3/reports/X21*.md`. Log any
touch. Everything else is open — above all the inputs by statement: `LEDGER.md` rows 52, 66, 67, 75, 88, 98, 100, 105, 112, 113; FS-66's
certificates (`data/fs66/`); J45's lemma statements (`plans/FS84-SI-D-derivation.md` §5.4).

## The claims (verbatim)

- **TCA-cls** (R88-TCA's class form, from `plans/R88-derivation.md` line 161): "over every real field whose stable places all have all-levels
  ratio `< 1/4`, no translation-invariant Borel probability on `X₄(F)` has spectral measure carried by `T + A + Fin_S` for a finite set `S` of
  split places, dyadic ones included". Derive it at `S = ∅` first, then for finite `S`.
- **T1** (FS100-T1, from `LEDGER.md` row 117): "For `ℚ(√d)` real quadratic: every stable place of `ℚ(√d, i)` has all-levels four-colour ratio
  `< 1/4` ⟺ `d ≡ 47, 143, 167 (mod 168)` ⟺ `L(ℚ(√d)) ≥ 5`". Exact checks of seconds (Legendre symbols, the Hoffman table) are allowed, each
  with a planted fault watched firing (`tools/x25b_*.py`).

## Stages

1. The quotation check; a C0 probability per claim, sealed before any derivation. Save.
2. TCA-cls: TRUE, FALSE with a counterexample, or GAP at a named step. Save.
3. T1, the same. Save. The write-up with "Theorems this phase proved"; the report.

**Every outcome counts** (standing rule 4): a GAP with its step named is a complete result. **Do not lean toward TRUE.**

## Rules

- **No subagents, forks or workflows** — delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the
  owner can only review work it knows about.
- The ban on finite-witness search holds (to 2026-10-01): keep a "would have searched here" log.
- Record `plans/FS100-X25B-derivation.md`; working files `data/fs100/x25b/`. Never edit `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`,
  `BIBLIOGRAPHY.md` or another job's files.
- Commits by explicit path, subjects "X25B: stage n", never amend, push after each commit (on a ref-lock race, `sleep 4` and retry), never
  force-push; end with your harness's attribution lines.
- **Budget:** about 200k by the harness's count; hand back by 280k.
- Report (standing rule 9) to `data/crunch-2026-09-26-x2x3/reports/X25B.md`, committed, and by SendMessage to "main"; final turn text "X25B idle;
  report sent to the owner by SendMessage".

Thank you.
