*Brief for job **X26B**: a blind second derivation of CLS, the class condition behind `χ(F²) ≥ min(L(F), 5)` for every real number field.
Opus 5.5, 2026-09-26, 06:46. Written by the product owner. Template: X12B's brief. **Stop at 12:50 UTC**, whatever is left.*

Hello. You are Coxeter, a second mind, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md`
and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` is part of this brief; read it in full** (its clock is
replaced by the stop above). If your record exists, you are resuming: continue at the first stage not SAVED.

## Why

One mind (X23D) derived CLS for every real number field; the blind verifier (X23V) derived it except at one case — a dyadic inert stable place
over a ramified base with `Q ≥ 64` — which it closed by re-deriving X23D's lemma from its statement, not blind. You are the clean second mind.

## Blind — the fences (the whole job)

Do not open: `plans/FS100-X23D-derivation.md`, `plans/FS100-X23V-verification.md`, anything under `data/fs100/x23d/` or `data/fs100/x23v/`,
`tools/x23d_*.py`, `tools/x23v_*.py`, the reports `data/crunch-2026-09-26-x2x3/reports/X23*.md` and `X29C.md`, the briefs `X23*.md`, the advisor's
record `plans/POROS-2026-09-26-x2x3-crunch.md`, `plans/FS100-X25B-derivation.md` and `data/fs100/x25b/` (a parallel blind job), and the bodies
of commits whose subjects start "X23D", "X23V", "X25B" or "X23 advisor". Log any touch. Everything else is open: `LEDGER.md` (rows 52, 57, 66,
67, 75, 99, 100, 105, 117 above all), FS-66's certificates `data/fs66/`, `plans/R88-derivation.md`, J45's `plans/FS84-SI-D-derivation.md`,
and the queue plan's §7 claim list.

## The claims (verbatim, from `plans/CRUNCH-2026-09-26-x2x3-queue.md` §7, list X23)

- **CLS(F).** "For every real number field `F` outside row 100's exception: T-C(A) holds at `S = ∅` iff `L(F) ≥ 5`." The named risks, in the
  queue's words: "`q = 27`; the dyadic `U_Q` for `Q ≥ 64`; ramified stable places; the archimedean part at `n` places." Here "T-C(A) holds at
  `S = ∅`" is read as the queue glosses it for SPC: "every stable place of `L = F(i)` has all-levels four-colour ratio `< 1/4`".
- **SPC(F)**, its archimedean step only: "For every real number field `F` outside row 100's exception: if T-C(A) holds at `S = ∅` (every
  stable place of `L = F(i)` has all-levels four-colour ratio `< 1/4`), then J45's A⁺ and SP-Cor hold with J45's proofs". Derive only the step
  where `F` has `n > 2` real places **and** where `F` has a complex place; take the rest of J45's proofs as given.
- **The exception.** Is row 100's exception (a ramified stable dyadic place) ever inside the class — or is it excluded by the ratio condition?

Exact checks of seconds (norm-one spectra of `U_Q` and `Γ_q`, Legendre and Kummer arithmetic, PARI) are allowed, each with a planted fault
watched firing (`tools/x26b_*.py`).

## Stages

1. The quotation check; a C0 probability per claim, sealed before any derivation. Save.
2. CLS: TRUE, FALSE with a counterexample, or GAP at a named step — above all at the four named risks. Save.
3. SPC's archimedean step and the exception; the write-up with "Theorems this phase proved"; the report.

**Every outcome counts** (standing rule 4). **Do not lean toward TRUE.**

## Rules

- **No subagents, forks or workflows** — delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the
  owner can only review work it knows about.
- The ban on finite-witness search holds (to 2026-10-01): keep a "would have searched here" log.
- Record `plans/FS100-X26B-derivation.md`; working files `data/fs100/x26b/`. Never edit `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`,
  `BIBLIOGRAPHY.md` or another job's files.
- Commits by explicit path, subjects "X26B: stage n", never amend, push after each commit (on a ref-lock race, `sleep 4` and retry), never
  force-push; end with your harness's attribution lines.
- **Budget:** about 200k by the harness's count; hand back by 280k.
- Report (standing rule 9) to `data/crunch-2026-09-26-x2x3/reports/X26B.md`, committed, and by SendMessage to "main"; final turn text "X26B idle;
  report sent to the owner by SendMessage".

Thank you.
