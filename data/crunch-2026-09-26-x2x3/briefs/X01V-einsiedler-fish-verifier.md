*Brief for job **X01V**: a blind verifier for route (A) of the ×2×3 crunch. Opus 5.5. Written by the crunch planner. **Sized for about one
hour and 220k harness tokens.** A derivation job works on the same claims; never contact it.*

Hello. You are Coxeter, a verifier, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. `CLAUDE.md` is in your context
(G21 and G79 bear most). **`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` is part of this brief; read it in full.**

**If your record already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS100-X01V-verification.md`.

## Blind — the fences (until your stage 3 is committed)

Do not open: `plans/FS100-X01D-derivation.md`; anything under `data/fs100/x01d/`; the briefs `data/crunch-2026-09-26-x2x3/briefs/X0*D-*.md`;
the reports `data/crunch-2026-09-26-x2x3/reports/X0*.md`; the advisor's record `plans/POROS-2026-09-26-x2x3-crunch.md` and everything under
`data/crunch-2026-09-26-x2x3/poros/` **except** the paper `einsiedler-fish-0804.3586.pdf` and its text `ef.txt`, which you should use; §6 of
`plans/CRUNCH-2026-09-26-x2x3-queue.md`; the bodies of commits whose subjects start "X01D" or "X23 advisor". Everything else is open.

## The question

The project's missing lemma is MR(F): "every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure"
(J38 §3.5, T-J38-2 (iii), quoted in `plans/STUB-measure-rigidity-three-fields.md` §1). Einsiedler–Fish (Ergodic Theory Dynam. Systems 30
(2010) 151–157, Zbl 1189.37005; arXiv 0804.3586) prove rigidity for multiplier semigroups of polynomial growth on 𝕋, and `U` has infinite
rank. The claims below ask whether their argument transfers. Derive each yourself, from the paper and the public inputs.

## The fixed claim list (verbatim, from `plans/CRUNCH-2026-09-26-x2x3-queue.md` §2, fixed before any derivation)

Copy §2's notation paragraph and list X01 (EF-G, EF_F, EF-MR, EF-X) into your record first, verbatim, and work from that copy. §1 and §2
of that plan are open to you; §6 is fenced.

**Verified inputs you may use as given, by statement:** row 98 (band rigidity, `Θ_k(R_F) ⊆ T + A`); row 105 and Lemmas C, C′ (`R = O′`);
rows 112–113; SP-Cor's statement (`plans/FS84-SI-D-derivation.md` §4.2); EL2021 §1 (`~/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` (the held copy, under its journal-year key; J51's `data/fs100/j51/el2021.pdf` is not on disk)); Furstenberg 1967;
Berend 1983/1984; the counting of rational points of bounded height on tori and conics (cite what you use).

## Stages

1. Quotation check. Read EF in full, and quote its main theorem verbatim. A C0 table: your probability for each claim, before any
   derivation. Save.
2. Blind derivation, claim by claim: TRUE, FALSE with a counterexample, or GAP at a named step. **Run the controls first** (EF-X, EF-G).
   For each control, say what a wrong-reason pass would look like (G21). For EF_F, go through EF's lemmas one by one. For each, name what
   changes when the multipliers expand different places (each `u ∈ U` expands only its own split places) and when there are isometric
   archimedean directions. Save.
3. The write-up, with a verdict per claim. Commit it **before** opening anything fenced. Save.
4. **Fallback** (FS-89's rule): if stage 2 stalls on a claim, and only after stage 3 is committed, you may read X01D's lemma statements
   (not its proofs) and check them one by one. Save; the report.

**Stop rule:** at 200k harness tokens or at 11:55 UTC, whichever comes first, finish the current claim, save, and report. Every verdict
counts; do not lean toward TRUE.

## Rules

- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about. If the work outgrows your context, stop at a saved stage and say what is left.
- **The finite-witness ban runs to 2026-10-01** (standing rule 3). Keep a "would have searched here" log.
- **Record:** `plans/FS100-X01V-verification.md`, with a "Theorems this phase proved" heading. Working files go in `data/fs100/x01v/`;
  exact checks in `tools/x01v_*.py`, with plants watched firing. Do not edit `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md` or
  `BIBLIOGRAPHY.md`.
- **Commits:** by explicit path, with subjects "X01V: stage n". Never amend. Push after each commit. Never force-push.
- **Report** (standing rule 9): to `data/crunch-2026-09-26-x2x3/reports/X01V.md`, committed, and by SendMessage to "main". Your final
  turn's text: "X01V idle; report sent to the owner by SendMessage".

Thank you.
