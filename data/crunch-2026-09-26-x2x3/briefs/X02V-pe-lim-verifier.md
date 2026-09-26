*Brief for job **X02V**: a blind verifier for routes (B) and (C) of the ×2×3 crunch. Opus 5.5. Written by the crunch planner. **Sized for
about one hour and 220k harness tokens.** Derivation jobs work on the same claims; never contact them.*

Hello. You are Coxeter, a verifier, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. `CLAUDE.md` is in your context
(G21 bears most). **`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` is part of this brief; read it in full.**

**If your record already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS100-X02V-verification.md`.

## Blind — the fences (until your stage 3 is committed)

Do not open: `plans/FS100-X02D-derivation.md`, `plans/FS100-X03D-derivation.md`, `plans/FS100-X01D-derivation.md`; anything under
`data/fs100/x02d/`, `data/fs100/x03d/`, `data/fs100/x01d/`; the briefs `data/crunch-2026-09-26-x2x3/briefs/X0*D-*.md`; the reports
`data/crunch-2026-09-26-x2x3/reports/X0*.md`; the advisor's record `plans/POROS-2026-09-26-x2x3-crunch.md` and everything under
`data/crunch-2026-09-26-x2x3/poros/`; §6 of `plans/CRUNCH-2026-09-26-x2x3-queue.md`; the bodies of commits whose subjects start "X02D",
"X03D", "X01D" or "X23 advisor". Everything else is open, including §1 and §2 of the queue plan.

## The question

`LEDGER.md` row 118 records "MR is its zero-entropy half plus an owed lemma PE-lim (from finitely generated `Γ` to `U`)". MR(F) is "every
`U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure" (J38 §3.5, T-J38-2 (iii)). The claims ask
whether PE-lim holds, what MR is conditional on, and two facts about MR's Fourier form. Derive each yourself.

## The fixed claim lists (verbatim, from `plans/CRUNCH-2026-09-26-x2x3-queue.md` §2, fixed before any derivation)

Copy §2's notation paragraph, **list X02** (HX-1, PE-1, PE-2, CE-1), and **FR-1 and ED-1 from list X03** into your record first,
verbatim, and work from that copy. Order: X02's claims first; FR-1 and ED-1 only if budget remains after PE-2.

**Verified inputs you may use as given, by statement:** row 105 and Lemmas C, C′ (`R = O′`, a Dedekind domain); EL2021
(`~/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` (the held copy, under its journal-year key; J51's `data/fs100/j51/el2021.pdf` is not on disk); read what you use, and mark reading status per section); row 118's FS100-T2 (no finitely generated `Γ`
acts irreducibly on `R̂`); standard ergodic theory (ergodic decomposition; Kolmogorov–Sinai entropy of factors and inverse limits; Bochner).

## Stages

1. Quotation check. A C0 table: your probability for each claim, before any derivation. Save.
2. Blind derivation, claim by claim: TRUE, FALSE with a counterexample, or GAP at a named step. **HX-1 first, as a control.** For PE-2,
   treat explicitly the case of a `U`-invariant `τ` whose pushforwards are not `Γ`-ergodic: EL2021 Thm 1.2 is stated for ergodic measures.
   Save.
3. The write-up, with a verdict per claim. Commit it **before** opening anything fenced. Save.
4. **Fallback:** if stage 2 stalls on a claim, and only after stage 3 is committed, you may read X02D's lemma statements (not its proofs)
   and check them one by one. Save; the report.

**Stop rule:** at 200k harness tokens or at 11:55 UTC, whichever comes first, finish the current claim, save, and report. Every verdict
counts; do not lean toward TRUE.

## Rules

- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about. If the work outgrows your context, stop at a saved stage and say what is left.
- **The finite-witness ban runs to 2026-10-01** (standing rule 3). Keep a "would have searched here" log.
- **Record:** `plans/FS100-X02V-verification.md`, with a "Theorems this phase proved" heading. Working files go in `data/fs100/x02v/`;
  exact checks in `tools/x02v_*.py`, with plants watched firing. Do not edit `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md` or
  `BIBLIOGRAPHY.md`.
- **Commits:** by explicit path, with subjects "X02V: stage n". Never amend. Push after each commit. Never force-push.
- **Report** (standing rule 9): to `data/crunch-2026-09-26-x2x3/reports/X02V.md`, committed, and by SendMessage to "main". Your final
  turn's text: "X02V idle; report sent to the owner by SendMessage".

Thank you.
