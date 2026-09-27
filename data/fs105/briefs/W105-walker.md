*Brief for job **FS105-W**: the degree-16 walk of MR and row 129's finite-graph test, for FS-105, harden MR. Opus 5.5, 2026-09-26. Drafted by
the planner (FS105-P) for the owner, who reviews and launches it. **Sized for about 220k harness tokens.** Two other jobs run beside you (a
reader and a blind derivation); never contact them.*

Hello. You are de Bruijn (`DEBRUIJN.md`), a walker, in `/home/kooshi/source/lean-dir`. **`data/fs105/briefs/STANDING-RULES.md` is part of this
brief; read it in full.** Read from disk `CLAUDE.md` (it changed today), `LEDGER.md` rows 98, 100, 105, 118, 120, 128–130, **`data/fs105/claims.md`**
(your claims are **(c)** and **(d)**), and the plan `plans/FS105-harden-mr.md` §PA and §E. MR's records are open to you — you are not blind:
`plans/FS100-derivation.md` §3; `plans/FS100-X01D-derivation.md` §§2–4; `plans/FS100-X12B-derivation.md` §2; `plans/FS100-X01V-verification.md`
§2.3, §4; `plans/FS100-X02D-derivation.md` §§2–3; `plans/FS100-X02V-verification.md` §2.3; FS-103's statement of C-MR16 in
`plans/FS103-collapse-cp-plane.md` (grep `MR16`).

**If your record `plans/FS105-W-walk.md` already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS105-W-walk.md`.

## Why this matters

MR (`LEDGER.md` row 120) was proved for every real number field with `R_F = O′`, but every step was only ever exercised at degree 2
(ℚ(√47), ℚ(√635087)). FS-103's collapse names **de Grey's field** `F_dG = ℚ(√3,√5,√7,√11)`, degree 16, as its publication instance, and rests
on MR there as stated, walked by nobody (C-MR16, "unreached by both"). And row 129 made MR testable on finite graphs: "any proof that
`α₁(ℝ²) > m₁(ℝ²)` refutes MR at ℚ(√635087)". **A GAP or FALSE is as valuable as TRUE** (standing rule 4); audit the result everyone likes at the
rate of one they dislike (`CLAUDE.md` G21).

## Stages

1. **Quotation check** of `data/fs105/claims.md` §0, (c) and (d) against their sources. **The setting at `F_dG` by PARI** (seconds): totally
   real, the 2-adic wall broken (every prime above 2 splits in `L = F_dG(i)`, so `R = O′`), `[L:ℚ] = 32`, the number of archimedean places of
   `L`, and one totally split prime usable for Lemma W. **C0**: your probability per sub-claim and your wrong-reason TRUE line for each. Save.
2. **(c) EF_F⁺ at degree 16.** Walk X01D §3 and X12B §2 step by step at `F_dG`: the multiplier count (EF-G (b), `#U_N ≥ c·N^{1/16}`) — and, the
   deciding question, **what growth the argument actually needs and whether `1/16` (or any fixed positive exponent) supplies it**, written as an
   inequality with every constant's dependence on the degree named; the expanding place; the product formula over 32-dimensional `L`; the
   leaves at the sixteen complex places; `h_m = log H` for totally real `F`. When two quantities are compared, exactly one thing may differ:
   state the height normalisation once and use it for both. Exact checks of seconds under `tools/fs105_w_*.py`, each with a plant. Save.
3. **(c) PE-2 at degree 16**, written **before** you open `plans/FS105-R-reading.md` (the reader's, on the same items; commit this stage first so
   the two are separate minds): (a1)–(a8) of the claim list at `F_dG` — Lemma W's totally split prime, admissibility against the proper
   subfields of `L`, the pieces `M̂`. Then read the reader's record, if committed, and note agreements and divergences. Save.
4. **(d) Row 129's test.** (d1) the chain MR(`F₁`) ⟹ `α₁(ℝ²) = m₁(ℝ²)`, every inequality's direction named, from `LEDGER.md` row 129 and
   `plans/FS103-derivation.md` §2 (and its sources there); (d2) the weakest statement about finite unit-distance graphs that would prove
   `α₁(ℝ²) > m₁(ℝ²)`, given the best proved bounds (read them in `[AmbrusEtAl2023]`, `[MatolcsiEtAl2025]`, `[DuczVarga2026]`, held — grep
   `BIBLIOGRAPHY.md`); (d3) whether anything in print or held proves it or comes within a named margin, with the margin as a number and its source;
   one zbMATH API query set (WORKFLOW 3.2 item 8) on the citers. **No search for graphs** (the ban). Save.
5. The write-up: a verdict per claim ((c) TRUE / FALSE / GAP at a named step; (d1)–(d3) each), your grade and count of minds (a walk of written
   proofs is a checking reading, not a blind mind — say so). Save; the report.

**Stop rule:** at 190k harness tokens, finish the current stage, save, report. An unreached claim is reported as unreached; (c) before (d).

## Rules

- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about.
- **The ban** (standing rule 3): reading and derivation; PARI and exact arithmetic of seconds. Keep a "would have searched here" log.
- **Touch only** `plans/FS105-W-walk.md`, `data/fs105/fs105-w/` and `tools/fs105_w_*.py`. Record with "Theorems this phase proved". Do not open
  `plans/FS105-B-derivation.md` or `data/fs105/fs105-b/`.
- **Commits:** by explicit path, subjects "FS105-W: stage n"; never amend; push; never force-push.
- **Report** (standing rule 9) to `data/fs105/reports/FS105-W.md`, committed, and by SendMessage to "main". Final turn text:
  "FS105-W idle; report sent to the owner by SendMessage".

Thank you.
