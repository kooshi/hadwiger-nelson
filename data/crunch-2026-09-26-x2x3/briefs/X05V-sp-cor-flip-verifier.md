*Brief for job **X05V**: a blind check of the consumer's ladder (SP-Cor) and of the flip claims FL-1 and FL-2, for the ×2×3 crunch. Opus
5.5. Written by the crunch planner. **Sized for about 45 minutes and 180k harness tokens.** A derivation job (X03D) works on FL-1 and FL-2;
never contact it.*

Hello. You are Coxeter, a verifier, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. `CLAUDE.md` is in your context
(G21 and G79 bear most). **`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` is part of this brief; read it in full.**

**If your record already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS100-X05V-verification.md`.

## Why

If MR(F) lands this crunch, the headline `χ(ℚ(√47)²) = 5` would rest on SP-Cor. SP-Cor is one mind's derivation (J45), re-derived from its
statement. It also rests on K0 (one mind) and on T-C(A). The advisor asked for a blind check of that ladder before any such headline [P-5].
FL-1 and FL-2 ask whether the consumer needs less than MR. An actual four-colouring forces its spectral measure's non-`E` part to be
negatively correlated on the whole unit circle, so a one-sided bound on `E`-null spectra would do.

## Blind — the fences (until your stage 3 is committed)

Do not open: `plans/FS100-X03D-derivation.md` and anything under `data/fs100/x03d/`; the briefs `data/crunch-2026-09-26-x2x3/briefs/X0*D-*.md`;
the reports `data/crunch-2026-09-26-x2x3/reports/X0*.md`; the advisor's record `plans/POROS-2026-09-26-x2x3-crunch.md` and
`data/crunch-2026-09-26-x2x3/poros/`; §6 of `plans/CRUNCH-2026-09-26-x2x3-queue.md`; **the proofs in `plans/FS84-SI-D-derivation.md` §2–§4**
(read §1.2, the notation, and §5.4, the lemma statements; SP-Cor's statement is quoted below); the Poros record whose "F4 chain" SP-Cor
re-derives (`plans/POROS-2026-09-25-*` files: their §4 and later). Everything else is open.

## The claims (verbatim)

- **SP-Cor** (`plans/FS84-SI-D-derivation.md` §4.2, verbatim): "**Corollary SP-Cor** … Over ℚ(√47): if every finite positive `U`-invariant
  measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure, then `χ(ℚ(√47)²) ≥ 5`." Its grade there: "[hand; given T-C(A) at `S = ∅`]".
- **FL-1 and FL-2**: copy them from `plans/CRUNCH-2026-09-26-x2x3-queue.md` §2 (list X03) into your record, verbatim, with §2's notation
  paragraph.
- **KC** (the known-positive control, from the advisor [P-5a]): "MR is consistent with Theorem B at K and with ℚ(√11)'s non-periodic
  four-colourings (row 94), whose spectral measures lie in T + Fin_S plus Haar. SP-Cor fails at those fields exactly at T-C(A)." Check it:
  run SP-Cor's argument at K and at ℚ(√11), and say at which step it stops.

**Verified inputs you may use as given, by statement:** J45's lemma statements (`plans/FS84-SI-D-derivation.md` §5.4: SI-1 to SI-5, RU,
SP-oi, SP-if, A⁺, B⁺); R88-TCA (T-C(A), `plans/R88-derivation.md`); rows 94, 98, 105, 112, 113, 117 (K0: SP-Cor over ℚ(√143), ℚ(√311),
ℚ(√335)).

## Stages

1. Quotation check. A C0 table: your probability for each claim, before any derivation. Save.
2. **KC first** (a control whose answer is known: say what a wrong-reason pass would look like, G21). Then SP-Cor, from the lemma
   statements only, noting every lemma used and its grade. Save.
3. FL-1 and FL-2. Then the write-up, with a verdict per claim. Commit it **before** opening anything fenced. Save; the report.

**Stop rule:** at 160k harness tokens or at 11:55 UTC, whichever comes first, finish the current claim, save, and report. Every verdict
counts; do not lean toward TRUE.

## Rules

- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about. If the work outgrows your context, stop at a saved stage and say what is left.
- **The finite-witness ban runs to 2026-10-01** (standing rule 3). Keep a "would have searched here" log.
- **Record:** `plans/FS100-X05V-verification.md`, with a "Theorems this phase proved" heading. Working files go in `data/fs100/x05v/`;
  exact checks in `tools/x05v_*.py`, with plants watched firing. Do not edit `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md` or
  `BIBLIOGRAPHY.md`.
- **Commits:** by explicit path, with subjects "X05V: stage n". Never amend. Push after each commit. Never force-push.
- **Report** (standing rule 9): to `data/crunch-2026-09-26-x2x3/reports/X05V.md`, committed, and by SendMessage to "main". Your final
  turn's text: "X05V idle; report sent to the owner by SendMessage".

Thank you.
